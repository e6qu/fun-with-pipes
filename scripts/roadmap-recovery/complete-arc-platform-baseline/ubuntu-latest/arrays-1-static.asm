
/tmp/fwp-arc-3991/arrays-1-static-O2:     file format elf64-x86-64


Disassembly of section .init:

0000000000002000 <_init>:
    2000:	f3 0f 1e fa          	endbr64
    2004:	48 83 ec 08          	sub    $0x8,%rsp
    2008:	48 8b 05 b9 ff 00 00 	mov    0xffb9(%rip),%rax        # 11fc8 <__gmon_start__@Base>
    200f:	48 85 c0             	test   %rax,%rax
    2012:	74 02                	je     2016 <_init+0x16>
    2014:	ff d0                	call   *%rax
    2016:	48 83 c4 08          	add    $0x8,%rsp
    201a:	c3                   	ret

Disassembly of section .plt:

0000000000002020 <getenv@plt-0x10>:
    2020:	ff 35 ca ff 00 00    	push   0xffca(%rip)        # 11ff0 <_GLOBAL_OFFSET_TABLE_+0x8>
    2026:	ff 25 cc ff 00 00    	jmp    *0xffcc(%rip)        # 11ff8 <_GLOBAL_OFFSET_TABLE_+0x10>
    202c:	0f 1f 40 00          	nopl   0x0(%rax)

0000000000002030 <getenv@plt>:
    2030:	ff 25 ca ff 00 00    	jmp    *0xffca(%rip)        # 12000 <getenv@GLIBC_2.2.5>
    2036:	68 00 00 00 00       	push   $0x0
    203b:	e9 e0 ff ff ff       	jmp    2020 <_init+0x20>

0000000000002040 <dl_iterate_phdr@plt>:
    2040:	ff 25 c2 ff 00 00    	jmp    *0xffc2(%rip)        # 12008 <dl_iterate_phdr@GLIBC_2.2.5>
    2046:	68 01 00 00 00       	push   $0x1
    204b:	e9 d0 ff ff ff       	jmp    2020 <_init+0x20>

0000000000002050 <abort@plt>:
    2050:	ff 25 ba ff 00 00    	jmp    *0xffba(%rip)        # 12010 <abort@GLIBC_2.2.5>
    2056:	68 02 00 00 00       	push   $0x2
    205b:	e9 c0 ff ff ff       	jmp    2020 <_init+0x20>

0000000000002060 <_exit@plt>:
    2060:	ff 25 b2 ff 00 00    	jmp    *0xffb2(%rip)        # 12018 <_exit@GLIBC_2.2.5>
    2066:	68 03 00 00 00       	push   $0x3
    206b:	e9 b0 ff ff ff       	jmp    2020 <_init+0x20>

0000000000002070 <strcpy@plt>:
    2070:	ff 25 aa ff 00 00    	jmp    *0xffaa(%rip)        # 12020 <strcpy@GLIBC_2.2.5>
    2076:	68 04 00 00 00       	push   $0x4
    207b:	e9 a0 ff ff ff       	jmp    2020 <_init+0x20>

0000000000002080 <sigaction@plt>:
    2080:	ff 25 a2 ff 00 00    	jmp    *0xffa2(%rip)        # 12028 <sigaction@GLIBC_2.2.5>
    2086:	68 05 00 00 00       	push   $0x5
    208b:	e9 90 ff ff ff       	jmp    2020 <_init+0x20>

0000000000002090 <strtod@plt>:
    2090:	ff 25 9a ff 00 00    	jmp    *0xff9a(%rip)        # 12030 <strtod@GLIBC_2.2.5>
    2096:	68 06 00 00 00       	push   $0x6
    209b:	e9 80 ff ff ff       	jmp    2020 <_init+0x20>

00000000000020a0 <clock_gettime@plt>:
    20a0:	ff 25 92 ff 00 00    	jmp    *0xff92(%rip)        # 12038 <clock_gettime@GLIBC_2.17>
    20a6:	68 07 00 00 00       	push   $0x7
    20ab:	e9 70 ff ff ff       	jmp    2020 <_init+0x20>

00000000000020b0 <write@plt>:
    20b0:	ff 25 8a ff 00 00    	jmp    *0xff8a(%rip)        # 12040 <write@GLIBC_2.2.5>
    20b6:	68 08 00 00 00       	push   $0x8
    20bb:	e9 60 ff ff ff       	jmp    2020 <_init+0x20>

00000000000020c0 <fclose@plt>:
    20c0:	ff 25 82 ff 00 00    	jmp    *0xff82(%rip)        # 12048 <fclose@GLIBC_2.2.5>
    20c6:	68 09 00 00 00       	push   $0x9
    20cb:	e9 50 ff ff ff       	jmp    2020 <_init+0x20>

00000000000020d0 <strlen@plt>:
    20d0:	ff 25 7a ff 00 00    	jmp    *0xff7a(%rip)        # 12050 <strlen@GLIBC_2.2.5>
    20d6:	68 0a 00 00 00       	push   $0xa
    20db:	e9 40 ff ff ff       	jmp    2020 <_init+0x20>

00000000000020e0 <mmap@plt>:
    20e0:	ff 25 72 ff 00 00    	jmp    *0xff72(%rip)        # 12058 <mmap@GLIBC_2.2.5>
    20e6:	68 0b 00 00 00       	push   $0xb
    20eb:	e9 30 ff ff ff       	jmp    2020 <_init+0x20>

00000000000020f0 <strchr@plt>:
    20f0:	ff 25 6a ff 00 00    	jmp    *0xff6a(%rip)        # 12060 <strchr@GLIBC_2.2.5>
    20f6:	68 0c 00 00 00       	push   $0xc
    20fb:	e9 20 ff ff ff       	jmp    2020 <_init+0x20>

0000000000002100 <snprintf@plt>:
    2100:	ff 25 62 ff 00 00    	jmp    *0xff62(%rip)        # 12068 <snprintf@GLIBC_2.2.5>
    2106:	68 0d 00 00 00       	push   $0xd
    210b:	e9 10 ff ff ff       	jmp    2020 <_init+0x20>

0000000000002110 <strtof@plt>:
    2110:	ff 25 5a ff 00 00    	jmp    *0xff5a(%rip)        # 12070 <strtof@GLIBC_2.2.5>
    2116:	68 0e 00 00 00       	push   $0xe
    211b:	e9 00 ff ff ff       	jmp    2020 <_init+0x20>

0000000000002120 <memset@plt>:
    2120:	ff 25 52 ff 00 00    	jmp    *0xff52(%rip)        # 12078 <memset@GLIBC_2.2.5>
    2126:	68 0f 00 00 00       	push   $0xf
    212b:	e9 f0 fe ff ff       	jmp    2020 <_init+0x20>

0000000000002130 <fputc@plt>:
    2130:	ff 25 4a ff 00 00    	jmp    *0xff4a(%rip)        # 12080 <fputc@GLIBC_2.2.5>
    2136:	68 10 00 00 00       	push   $0x10
    213b:	e9 e0 fe ff ff       	jmp    2020 <_init+0x20>

0000000000002140 <pthread_attr_init@plt>:
    2140:	ff 25 42 ff 00 00    	jmp    *0xff42(%rip)        # 12088 <pthread_attr_init@GLIBC_2.2.5>
    2146:	68 11 00 00 00       	push   $0x11
    214b:	e9 d0 fe ff ff       	jmp    2020 <_init+0x20>

0000000000002150 <fgets@plt>:
    2150:	ff 25 3a ff 00 00    	jmp    *0xff3a(%rip)        # 12090 <fgets@GLIBC_2.2.5>
    2156:	68 12 00 00 00       	push   $0x12
    215b:	e9 c0 fe ff ff       	jmp    2020 <_init+0x20>

0000000000002160 <strtoull@plt>:
    2160:	ff 25 32 ff 00 00    	jmp    *0xff32(%rip)        # 12098 <strtoull@GLIBC_2.2.5>
    2166:	68 13 00 00 00       	push   $0x13
    216b:	e9 b0 fe ff ff       	jmp    2020 <_init+0x20>

0000000000002170 <strcmp@plt>:
    2170:	ff 25 2a ff 00 00    	jmp    *0xff2a(%rip)        # 120a0 <strcmp@GLIBC_2.2.5>
    2176:	68 14 00 00 00       	push   $0x14
    217b:	e9 a0 fe ff ff       	jmp    2020 <_init+0x20>

0000000000002180 <signal@plt>:
    2180:	ff 25 22 ff 00 00    	jmp    *0xff22(%rip)        # 120a8 <signal@GLIBC_2.2.5>
    2186:	68 15 00 00 00       	push   $0x15
    218b:	e9 90 fe ff ff       	jmp    2020 <_init+0x20>

0000000000002190 <strtoll@plt>:
    2190:	ff 25 1a ff 00 00    	jmp    *0xff1a(%rip)        # 120b0 <strtoll@GLIBC_2.2.5>
    2196:	68 16 00 00 00       	push   $0x16
    219b:	e9 80 fe ff ff       	jmp    2020 <_init+0x20>

00000000000021a0 <fprintf@plt>:
    21a0:	ff 25 12 ff 00 00    	jmp    *0xff12(%rip)        # 120b8 <fprintf@GLIBC_2.2.5>
    21a6:	68 17 00 00 00       	push   $0x17
    21ab:	e9 70 fe ff ff       	jmp    2020 <_init+0x20>

00000000000021b0 <sigemptyset@plt>:
    21b0:	ff 25 0a ff 00 00    	jmp    *0xff0a(%rip)        # 120c0 <sigemptyset@GLIBC_2.2.5>
    21b6:	68 18 00 00 00       	push   $0x18
    21bb:	e9 60 fe ff ff       	jmp    2020 <_init+0x20>

00000000000021c0 <strtol@plt>:
    21c0:	ff 25 02 ff 00 00    	jmp    *0xff02(%rip)        # 120c8 <strtol@GLIBC_2.2.5>
    21c6:	68 19 00 00 00       	push   $0x19
    21cb:	e9 50 fe ff ff       	jmp    2020 <_init+0x20>

00000000000021d0 <memcpy@plt>:
    21d0:	ff 25 fa fe 00 00    	jmp    *0xfefa(%rip)        # 120d0 <memcpy@GLIBC_2.14>
    21d6:	68 1a 00 00 00       	push   $0x1a
    21db:	e9 40 fe ff ff       	jmp    2020 <_init+0x20>

00000000000021e0 <fflush@plt>:
    21e0:	ff 25 f2 fe 00 00    	jmp    *0xfef2(%rip)        # 120d8 <fflush@GLIBC_2.2.5>
    21e6:	68 1b 00 00 00       	push   $0x1b
    21eb:	e9 30 fe ff ff       	jmp    2020 <_init+0x20>

00000000000021f0 <pthread_attr_setstack@plt>:
    21f0:	ff 25 ea fe 00 00    	jmp    *0xfeea(%rip)        # 120e0 <pthread_attr_setstack@GLIBC_2.34>
    21f6:	68 1c 00 00 00       	push   $0x1c
    21fb:	e9 20 fe ff ff       	jmp    2020 <_init+0x20>

0000000000002200 <setvbuf@plt>:
    2200:	ff 25 e2 fe 00 00    	jmp    *0xfee2(%rip)        # 120e8 <setvbuf@GLIBC_2.2.5>
    2206:	68 1d 00 00 00       	push   $0x1d
    220b:	e9 10 fe ff ff       	jmp    2020 <_init+0x20>

0000000000002210 <pthread_create@plt>:
    2210:	ff 25 da fe 00 00    	jmp    *0xfeda(%rip)        # 120f0 <pthread_create@GLIBC_2.34>
    2216:	68 1e 00 00 00       	push   $0x1e
    221b:	e9 00 fe ff ff       	jmp    2020 <_init+0x20>

0000000000002220 <mprotect@plt>:
    2220:	ff 25 d2 fe 00 00    	jmp    *0xfed2(%rip)        # 120f8 <mprotect@GLIBC_2.2.5>
    2226:	68 1f 00 00 00       	push   $0x1f
    222b:	e9 f0 fd ff ff       	jmp    2020 <_init+0x20>

0000000000002230 <fopen@plt>:
    2230:	ff 25 ca fe 00 00    	jmp    *0xfeca(%rip)        # 12100 <fopen@GLIBC_2.2.5>
    2236:	68 20 00 00 00       	push   $0x20
    223b:	e9 e0 fd ff ff       	jmp    2020 <_init+0x20>

0000000000002240 <sysconf@plt>:
    2240:	ff 25 c2 fe 00 00    	jmp    *0xfec2(%rip)        # 12108 <sysconf@GLIBC_2.2.5>
    2246:	68 21 00 00 00       	push   $0x21
    224b:	e9 d0 fd ff ff       	jmp    2020 <_init+0x20>

0000000000002250 <__cxa_atexit@plt>:
    2250:	ff 25 ba fe 00 00    	jmp    *0xfeba(%rip)        # 12110 <__cxa_atexit@GLIBC_2.2.5>
    2256:	68 22 00 00 00       	push   $0x22
    225b:	e9 c0 fd ff ff       	jmp    2020 <_init+0x20>

0000000000002260 <sprintf@plt>:
    2260:	ff 25 b2 fe 00 00    	jmp    *0xfeb2(%rip)        # 12118 <sprintf@GLIBC_2.2.5>
    2266:	68 23 00 00 00       	push   $0x23
    226b:	e9 b0 fd ff ff       	jmp    2020 <_init+0x20>

0000000000002270 <exit@plt>:
    2270:	ff 25 aa fe 00 00    	jmp    *0xfeaa(%rip)        # 12120 <exit@GLIBC_2.2.5>
    2276:	68 24 00 00 00       	push   $0x24
    227b:	e9 a0 fd ff ff       	jmp    2020 <_init+0x20>

0000000000002280 <fwrite@plt>:
    2280:	ff 25 a2 fe 00 00    	jmp    *0xfea2(%rip)        # 12128 <fwrite@GLIBC_2.2.5>
    2286:	68 25 00 00 00       	push   $0x25
    228b:	e9 90 fd ff ff       	jmp    2020 <_init+0x20>

0000000000002290 <getrlimit@plt>:
    2290:	ff 25 9a fe 00 00    	jmp    *0xfe9a(%rip)        # 12130 <getrlimit@GLIBC_2.2.5>
    2296:	68 26 00 00 00       	push   $0x26
    229b:	e9 80 fd ff ff       	jmp    2020 <_init+0x20>

00000000000022a0 <pthread_join@plt>:
    22a0:	ff 25 92 fe 00 00    	jmp    *0xfe92(%rip)        # 12138 <pthread_join@GLIBC_2.34>
    22a6:	68 27 00 00 00       	push   $0x27
    22ab:	e9 70 fd ff ff       	jmp    2020 <_init+0x20>

00000000000022b0 <sigaltstack@plt>:
    22b0:	ff 25 8a fe 00 00    	jmp    *0xfe8a(%rip)        # 12140 <sigaltstack@GLIBC_2.2.5>
    22b6:	68 28 00 00 00       	push   $0x28
    22bb:	e9 60 fd ff ff       	jmp    2020 <_init+0x20>

00000000000022c0 <strstr@plt>:
    22c0:	ff 25 82 fe 00 00    	jmp    *0xfe82(%rip)        # 12148 <strstr@GLIBC_2.2.5>
    22c6:	68 29 00 00 00       	push   $0x29
    22cb:	e9 50 fd ff ff       	jmp    2020 <_init+0x20>

Disassembly of section .plt.got:

00000000000022d0 <__cxa_finalize@plt>:
    22d0:	ff 25 02 fd 00 00    	jmp    *0xfd02(%rip)        # 11fd8 <__cxa_finalize@GLIBC_2.2.5>
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
    22ff:	ff 15 ab fc 00 00    	call   *0xfcab(%rip)        # 11fb0 <__libc_start_main@GLIBC_2.34>
    2305:	f4                   	hlt
    2306:	66 2e 0f 1f 84 00 00 	cs nopw 0x0(%rax,%rax,1)
    230d:	00 00 00 

0000000000002310 <deregister_tm_clones>:
    2310:	48 8d 3d 79 18 01 00 	lea    0x11879(%rip),%rdi        # 13b90 <__TMC_END__>
    2317:	48 8d 05 72 18 01 00 	lea    0x11872(%rip),%rax        # 13b90 <__TMC_END__>
    231e:	48 39 f8             	cmp    %rdi,%rax
    2321:	74 15                	je     2338 <deregister_tm_clones+0x28>
    2323:	48 8b 05 8e fc 00 00 	mov    0xfc8e(%rip),%rax        # 11fb8 <_ITM_deregisterTMCloneTable@Base>
    232a:	48 85 c0             	test   %rax,%rax
    232d:	74 09                	je     2338 <deregister_tm_clones+0x28>
    232f:	ff e0                	jmp    *%rax
    2331:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)
    2338:	c3                   	ret
    2339:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)

0000000000002340 <register_tm_clones>:
    2340:	48 8d 3d 49 18 01 00 	lea    0x11849(%rip),%rdi        # 13b90 <__TMC_END__>
    2347:	48 8d 35 42 18 01 00 	lea    0x11842(%rip),%rsi        # 13b90 <__TMC_END__>
    234e:	48 29 fe             	sub    %rdi,%rsi
    2351:	48 89 f0             	mov    %rsi,%rax
    2354:	48 c1 ee 3f          	shr    $0x3f,%rsi
    2358:	48 c1 f8 03          	sar    $0x3,%rax
    235c:	48 01 c6             	add    %rax,%rsi
    235f:	48 d1 fe             	sar    $1,%rsi
    2362:	74 14                	je     2378 <register_tm_clones+0x38>
    2364:	48 8b 05 65 fc 00 00 	mov    0xfc65(%rip),%rax        # 11fd0 <_ITM_registerTMCloneTable@Base>
    236b:	48 85 c0             	test   %rax,%rax
    236e:	74 08                	je     2378 <register_tm_clones+0x38>
    2370:	ff e0                	jmp    *%rax
    2372:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)
    2378:	c3                   	ret
    2379:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)

0000000000002380 <__do_global_dtors_aux>:
    2380:	f3 0f 1e fa          	endbr64
    2384:	80 3d 05 18 01 00 00 	cmpb   $0x0,0x11805(%rip)        # 13b90 <__TMC_END__>
    238b:	75 2b                	jne    23b8 <__do_global_dtors_aux+0x38>
    238d:	55                   	push   %rbp
    238e:	48 83 3d 42 fc 00 00 	cmpq   $0x0,0xfc42(%rip)        # 11fd8 <__cxa_finalize@GLIBC_2.2.5>
    2395:	00 
    2396:	48 89 e5             	mov    %rsp,%rbp
    2399:	74 0c                	je     23a7 <__do_global_dtors_aux+0x27>
    239b:	48 8b 3d b6 fd 00 00 	mov    0xfdb6(%rip),%rdi        # 12158 <__dso_handle>
    23a2:	e8 29 ff ff ff       	call   22d0 <__cxa_finalize@plt>
    23a7:	e8 64 ff ff ff       	call   2310 <deregister_tm_clones>
    23ac:	c6 05 dd 17 01 00 01 	movb   $0x1,0x117dd(%rip)        # 13b90 <__TMC_END__>
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
    23e2:	86 0d 00 20 01 00    	xchg   %cl,0x12000(%rip)        # 143e8 <fwp_static+0x848>
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
    2417:	4c 8d 05 82 17 01 00 	lea    0x11782(%rip),%r8        # 13ba0 <fwp_static>
    241e:	49 01 f1             	add    %rsi,%r9
    2421:	4c 29 0d b0 1f 01 00 	sub    %r9,0x11fb0(%rip)        # 143d8 <fwp_static+0x838>
    2428:	49 8b 74 d0 38       	mov    0x38(%r8,%rdx,8),%rsi
    242d:	48 89 34 07          	mov    %rsi,(%rdi,%rax,1)
    2431:	49 89 4c d0 38       	mov    %rcx,0x38(%r8,%rdx,8)
    2436:	c6 05 ab 1f 01 00 00 	movb   $0x0,0x11fab(%rip)        # 143e8 <fwp_static+0x848>
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
    245b:	83 3d 3e 17 01 00 00 	cmpl   $0x0,0x1173e(%rip)        # 13ba0 <fwp_static>
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
    2503:	40 86 35 de 1e 01 00 	xchg   %sil,0x11ede(%rip)        # 143e8 <fwp_static+0x848>
    250a:	40 84 f6             	test   %sil,%sil
    250d:	75 f1                	jne    2500 <fwp_pool_get+0xb0>
    250f:	48 01 c1             	add    %rax,%rcx
    2512:	89 d6                	mov    %edx,%esi
    2514:	48 8d 3d 85 16 01 00 	lea    0x11685(%rip),%rdi        # 13ba0 <fwp_static>
    251b:	48 8b 44 f7 38       	mov    0x38(%rdi,%rsi,8),%rax
    2520:	48 85 c0             	test   %rax,%rax
    2523:	74 0b                	je     2530 <fwp_pool_get+0xe0>
    2525:	4c 8b 40 10          	mov    0x10(%rax),%r8
    2529:	4c 89 44 f7 38       	mov    %r8,0x38(%rdi,%rsi,8)
    252e:	eb 21                	jmp    2551 <fwp_pool_get+0x101>
    2530:	48 8b 35 99 16 01 00 	mov    0x11699(%rip),%rsi        # 13bd0 <fwp_static+0x30>
    2537:	48 8b 05 8a 16 01 00 	mov    0x1168a(%rip),%rax        # 13bc8 <fwp_static+0x28>
    253e:	48 29 c6             	sub    %rax,%rsi
    2541:	48 39 ce             	cmp    %rcx,%rsi
    2544:	72 46                	jb     258c <fwp_pool_get+0x13c>
    2546:	48 8d 34 08          	lea    (%rax,%rcx,1),%rsi
    254a:	48 89 35 77 16 01 00 	mov    %rsi,0x11677(%rip)        # 13bc8 <fwp_static+0x28>
    2551:	48 03 0d 80 1e 01 00 	add    0x11e80(%rip),%rcx        # 143d8 <fwp_static+0x838>
    2558:	48 89 0d 79 1e 01 00 	mov    %rcx,0x11e79(%rip)        # 143d8 <fwp_static+0x838>
    255f:	48 3b 0d 7a 1e 01 00 	cmp    0x11e7a(%rip),%rcx        # 143e0 <fwp_static+0x840>
    2566:	76 07                	jbe    256f <fwp_pool_get+0x11f>
    2568:	48 89 0d 71 1e 01 00 	mov    %rcx,0x11e71(%rip)        # 143e0 <fwp_static+0x840>
    256f:	c6 05 72 1e 01 00 00 	movb   $0x0,0x11e72(%rip)        # 143e8 <fwp_static+0x848>
    2576:	89 10                	mov    %edx,(%rax)
    2578:	c7 40 04 00 00 00 00 	movl   $0x0,0x4(%rax)
    257f:	48 83 c0 10          	add    $0x10,%rax
    2583:	48 81 c4 d0 00 00 00 	add    $0xd0,%rsp
    258a:	5b                   	pop    %rbx
    258b:	c3                   	ret
    258c:	c6 05 55 1e 01 00 00 	movb   $0x0,0x11e55(%rip)        # 143e8 <fwp_static+0x848>
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
    26b2:	86 0d 30 1d 01 00    	xchg   %cl,0x11d30(%rip)        # 143e8 <fwp_static+0x848>
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
    26df:	48 8d 0d ba 14 01 00 	lea    0x114ba(%rip),%rcx        # 13ba0 <fwp_static>
    26e6:	48 01 d6             	add    %rdx,%rsi
    26e9:	48 29 35 e8 1c 01 00 	sub    %rsi,0x11ce8(%rip)        # 143d8 <fwp_static+0x838>
    26f0:	48 8b 54 c1 38       	mov    0x38(%rcx,%rax,8),%rdx
    26f5:	49 89 57 10          	mov    %rdx,0x10(%r15)
    26f9:	4c 89 7c c1 38       	mov    %r15,0x38(%rcx,%rax,8)
    26fe:	c6 05 e3 1c 01 00 00 	movb   $0x0,0x11ce3(%rip)        # 143e8 <fwp_static+0x848>
    2705:	4c 89 e0             	mov    %r12,%rax
    2708:	eb 74                	jmp    277e <realloc+0x14e>
    270a:	48 83 fe 01          	cmp    $0x1,%rsi
    270e:	48 83 d6 00          	adc    $0x0,%rsi
    2712:	48 89 f7             	mov    %rsi,%rdi
    2715:	e9 36 fd ff ff       	jmp    2450 <fwp_pool_get>
    271a:	8b 47 f4             	mov    -0xc(%rdi),%eax
    271d:	0f 1f 00             	nopl   (%rax)
    2720:	b1 01                	mov    $0x1,%cl
    2722:	86 0d c0 1c 01 00    	xchg   %cl,0x11cc0(%rip)        # 143e8 <fwp_static+0x848>
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
    2753:	48 8d 35 46 14 01 00 	lea    0x11446(%rip),%rsi        # 13ba0 <fwp_static>
    275a:	49 01 d0             	add    %rdx,%r8
    275d:	4c 29 05 74 1c 01 00 	sub    %r8,0x11c74(%rip)        # 143d8 <fwp_static+0x838>
    2764:	48 8b 54 c6 38       	mov    0x38(%rsi,%rax,8),%rdx
    2769:	48 89 17             	mov    %rdx,(%rdi)
    276c:	48 89 4c c6 38       	mov    %rcx,0x38(%rsi,%rax,8)
    2771:	c6 05 70 1c 01 00 00 	movb   $0x0,0x11c70(%rip)        # 143e8 <fwp_static+0x848>
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
    29d7:	48 8d 05 d2 e9 00 00 	lea    0xe9d2(%rip),%rax        # 113b0 <fwp_fn_table>
    29de:	48 89 05 7b 1d 01 00 	mov    %rax,0x11d7b(%rip)        # 14760 <fwp_fns>
    29e5:	4c 8b 35 d4 f5 00 00 	mov    0xf5d4(%rip),%r14        # 11fc0 <stdout@GLIBC_2.2.5>
    29ec:	49 8b 06             	mov    (%r14),%rax
    29ef:	48 89 05 72 1d 01 00 	mov    %rax,0x11d72(%rip)        # 14768 <fwp_prog_out>
    29f6:	48 89 35 73 1d 01 00 	mov    %rsi,0x11d73(%rip)        # 14770 <fwp_argv>
    29fd:	48 8d 35 74 1d 01 00 	lea    0x11d74(%rip),%rsi        # 14778 <fwp_start_time>
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
    2a85:	48 c7 05 d0 f6 00 00 	movq   $0x1000000,0xf6d0(%rip)        # 12160 <fwp_main_stack>
    2a8c:	00 00 00 01 
    2a90:	48 8b 35 79 19 01 00 	mov    0x11979(%rip),%rsi        # 14410 <fwp_static+0x870>
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
    2ae5:	48 89 0d 74 f6 00 00 	mov    %rcx,0xf674(%rip)        # 12160 <fwp_main_stack>
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
    2b39:	83 3d 60 10 01 00 00 	cmpl   $0x0,0x11060(%rip)        # 13ba0 <fwp_static>
    2b40:	0f 85 ee 01 00 00    	jne    2d34 <fwp_static_init+0x204>
    2b46:	c7 05 50 10 01 00 01 	movl   $0x1,0x11050(%rip)        # 13ba0 <fwp_static>
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
    2b94:	48 89 05 0d 10 01 00 	mov    %rax,0x1100d(%rip)        # 13ba8 <fwp_static+0x8>
    2b9b:	49 01 c6             	add    %rax,%r14
    2b9e:	4c 89 35 13 10 01 00 	mov    %r14,0x11013(%rip)        # 13bb8 <fwp_static+0x18>
    2ba5:	48 83 c0 0f          	add    $0xf,%rax
    2ba9:	48 83 e0 f0          	and    $0xfffffffffffffff0,%rax
    2bad:	48 8d 88 00 00 00 02 	lea    0x2000000(%rax),%rcx
    2bb4:	48 89 05 0d 10 01 00 	mov    %rax,0x1100d(%rip)        # 13bc8 <fwp_static+0x28>
    2bbb:	48 89 05 fe 0f 01 00 	mov    %rax,0x10ffe(%rip)        # 13bc0 <fwp_static+0x20>
    2bc2:	48 89 0d 07 10 01 00 	mov    %rcx,0x11007(%rip)        # 13bd0 <fwp_static+0x30>
    2bc9:	4c 8d 73 ff          	lea    -0x1(%rbx),%r14
    2bcd:	48 01 d8             	add    %rbx,%rax
    2bd0:	48 05 ff ff ff 01    	add    $0x1ffffff,%rax
    2bd6:	4c 21 f8             	and    %r15,%rax
    2bd9:	48 89 05 18 18 01 00 	mov    %rax,0x11818(%rip)        # 143f8 <fwp_static+0x858>
    2be0:	48 c7 05 1d 18 01 00 	movq   $0x48a000,0x1181d(%rip)        # 14408 <fwp_static+0x868>
    2be7:	00 a0 48 00 
    2beb:	48 05 ff 9f 49 00    	add    $0x499fff,%rax
    2bf1:	48 25 00 00 ff ff    	and    $0xffffffffffff0000,%rax
    2bf7:	48 89 05 f2 17 01 00 	mov    %rax,0x117f2(%rip)        # 143f0 <fwp_static+0x850>
    2bfe:	48 c7 05 f7 17 01 00 	movq   $0x4000000,0x117f7(%rip)        # 14400 <fwp_static+0x860>
    2c05:	00 00 00 04 
    2c09:	48 01 d8             	add    %rbx,%rax
    2c0c:	48 05 ff ff ff 03    	add    $0x3ffffff,%rax
    2c12:	4c 21 f8             	and    %r15,%rax
    2c15:	48 8d 88 00 00 00 01 	lea    0x1000000(%rax),%rcx
    2c1c:	48 89 0d 8d 0f 01 00 	mov    %rcx,0x10f8d(%rip)        # 13bb0 <fwp_static+0x10>
    2c23:	48 89 05 e6 17 01 00 	mov    %rax,0x117e6(%rip)        # 14410 <fwp_static+0x870>
    2c2a:	45 31 e4             	xor    %r12d,%r12d
    2c2d:	4c 8d 2d 6c 0f 01 00 	lea    0x10f6c(%rip),%r13        # 13ba0 <fwp_static>
    2c34:	66 66 66 2e 0f 1f 84 	data16 data16 cs nopw 0x0(%rax,%rax,1)
    2c3b:	00 00 00 00 00 
    2c40:	48 8b 3d 69 0f 01 00 	mov    0x10f69(%rip),%rdi        # 13bb0 <fwp_static+0x10>
    2c47:	4c 01 f7             	add    %r14,%rdi
    2c4a:	4c 21 ff             	and    %r15,%rdi
    2c4d:	48 8d 87 00 00 10 00 	lea    0x100000(%rdi),%rax
    2c54:	48 89 05 55 0f 01 00 	mov    %rax,0x10f55(%rip)        # 13bb0 <fwp_static+0x10>
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
    2c84:	c7 05 8a 1a 01 00 40 	movl   $0x40,0x11a8a(%rip)        # 14718 <fwp_static+0xb78>
    2c8b:	00 00 00 
    2c8e:	48 8b 05 1b 0f 01 00 	mov    0x10f1b(%rip),%rax        # 13bb0 <fwp_static+0x10>
    2c95:	4c 01 f0             	add    %r14,%rax
    2c98:	4c 21 f8             	and    %r15,%rax
    2c9b:	48 89 05 7e 1a 01 00 	mov    %rax,0x11a7e(%rip)        # 14720 <fwp_static+0xb80>
    2ca2:	4c 01 f0             	add    %r14,%rax
    2ca5:	48 05 00 00 10 00    	add    $0x100000,%rax
    2cab:	4c 21 f8             	and    %r15,%rax
    2cae:	48 89 05 73 1a 01 00 	mov    %rax,0x11a73(%rip)        # 14728 <fwp_static+0xb88>
    2cb5:	4c 01 f0             	add    %r14,%rax
    2cb8:	48 05 00 00 10 00    	add    $0x100000,%rax
    2cbe:	4c 21 f8             	and    %r15,%rax
    2cc1:	48 89 05 68 1a 01 00 	mov    %rax,0x11a68(%rip)        # 14730 <fwp_static+0xb90>
    2cc8:	4c 01 f0             	add    %r14,%rax
    2ccb:	48 05 00 00 10 00    	add    $0x100000,%rax
    2cd1:	4c 21 f8             	and    %r15,%rax
    2cd4:	48 89 05 5d 1a 01 00 	mov    %rax,0x11a5d(%rip)        # 14738 <fwp_static+0xb98>
    2cdb:	4c 01 f0             	add    %r14,%rax
    2cde:	48 05 00 00 10 00    	add    $0x100000,%rax
    2ce4:	4c 21 f8             	and    %r15,%rax
    2ce7:	48 89 05 52 1a 01 00 	mov    %rax,0x11a52(%rip)        # 14740 <fwp_static+0xba0>
    2cee:	4c 01 f0             	add    %r14,%rax
    2cf1:	48 05 00 00 10 00    	add    $0x100000,%rax
    2cf7:	4c 21 f8             	and    %r15,%rax
    2cfa:	48 89 05 47 1a 01 00 	mov    %rax,0x11a47(%rip)        # 14748 <fwp_static+0xba8>
    2d01:	4c 01 f0             	add    %r14,%rax
    2d04:	48 05 00 00 10 00    	add    $0x100000,%rax
    2d0a:	4c 21 f8             	and    %r15,%rax
    2d0d:	48 89 05 3c 1a 01 00 	mov    %rax,0x11a3c(%rip)        # 14750 <fwp_static+0xbb0>
    2d14:	4c 01 f0             	add    %r14,%rax
    2d17:	48 05 00 00 10 00    	add    $0x100000,%rax
    2d1d:	4c 21 f8             	and    %r15,%rax
    2d20:	48 89 05 31 1a 01 00 	mov    %rax,0x11a31(%rip)        # 14758 <fwp_static+0xbb8>
    2d27:	48 05 00 00 10 00    	add    $0x100000,%rax
    2d2d:	48 89 05 7c 0e 01 00 	mov    %rax,0x10e7c(%rip)        # 13bb0 <fwp_static+0x10>
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
    2d74:	83 3d d9 03 01 00 00 	cmpl   $0x0,0x103d9(%rip)        # 13154 <fwp_gc+0xfec>
    2d7b:	75 05                	jne    2d82 <fwp_main_thread+0x22>
    2d7d:	e8 0e 43 00 00       	call   7090 <fwp_gc_init>
    2d82:	48 89 2d 67 04 01 00 	mov    %rbp,0x10467(%rip)        # 131f0 <fwp_gc+0x1088>
    2d89:	48 8d 3d 60 b4 00 00 	lea    0xb460(%rip),%rdi        # e1f0 <fwp_gc_find_data>
    2d90:	31 f6                	xor    %esi,%esi
    2d92:	e8 a9 f2 ff ff       	call   2040 <dl_iterate_phdr@plt>
    2d97:	83 3d ba 03 01 00 00 	cmpl   $0x0,0x103ba(%rip)        # 13158 <fwp_gc+0xff0>
    2d9e:	0f 95 c0             	setne  %al
    2da1:	83 3d 50 05 01 00 00 	cmpl   $0x0,0x10550(%rip)        # 132f8 <fwp_gc+0x1190>
    2da8:	0f 9f c1             	setg   %cl
    2dab:	20 c1                	and    %al,%cl
    2dad:	0f b6 c1             	movzbl %cl,%eax
    2db0:	89 05 a6 03 01 00    	mov    %eax,0x103a6(%rip)        # 1315c <fwp_gc+0xff4>
    2db6:	83 3d a7 03 01 00 00 	cmpl   $0x0,0x103a7(%rip)        # 13164 <fwp_gc+0xffc>
    2dbd:	74 0c                	je     2dcb <fwp_main_thread+0x6b>
    2dbf:	48 8d 3d 0a b5 00 00 	lea    0xb50a(%rip),%rdi        # e2d0 <fwp_gc_report>
    2dc6:	e8 95 bb 00 00       	call   e960 <atexit>
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
    2df4:	48 8d 3d 25 b7 00 00 	lea    0xb725(%rip),%rdi        # e520 <fwp_static_report>
    2dfb:	e8 60 bb 00 00       	call   e960 <atexit>
    2e00:	83 3d 55 03 01 00 00 	cmpl   $0x0,0x10355(%rip)        # 1315c <fwp_gc+0xff4>
    2e07:	74 43                	je     2e4c <fwp_main_thread+0xec>
    2e09:	48 83 3d 77 03 01 00 	cmpq   $0x0,0x10377(%rip)        # 13188 <fwp_gc+0x1020>
    2e10:	00 
    2e11:	74 39                	je     2e4c <fwp_main_thread+0xec>
    2e13:	48 8b 05 5e 05 01 00 	mov    0x1055e(%rip),%rax        # 13378 <fwp_gc+0x1210>
    2e1a:	48 2b 05 47 f3 00 00 	sub    0xf347(%rip),%rax        # 12168 <fwp_gc>
    2e21:	f2 48 0f 2a c0       	cvtsi2sd %rax,%xmm0
    2e26:	f2 0f 58 05 22 05 01 	addsd  0x10522(%rip),%xmm0        # 13350 <fwp_gc+0x11e8>
    2e2d:	00 
    2e2e:	f2 0f 11 05 1a 05 01 	movsd  %xmm0,0x1051a(%rip)        # 13350 <fwp_gc+0x11e8>
    2e35:	00 
    2e36:	48 c7 05 37 05 01 00 	movq   $0x0,0x10537(%rip)        # 13378 <fwp_gc+0x1210>
    2e3d:	00 00 00 00 
    2e41:	48 c7 05 1c f3 00 00 	movq   $0x0,0xf31c(%rip)        # 12168 <fwp_gc>
    2e48:	00 00 00 00 
    2e4c:	48 8b 05 0d f3 00 00 	mov    0xf30d(%rip),%rax        # 12160 <fwp_main_stack>
    2e53:	48 8d 4d a0          	lea    -0x60(%rbp),%rcx
    2e57:	48 89 0d 42 19 01 00 	mov    %rcx,0x11942(%rip)        # 147a0 <fwp_main_stack_top>
    2e5e:	48 89 05 43 19 01 00 	mov    %rax,0x11943(%rip)        # 147a8 <fwp_main_stack_size>
    2e65:	48 8d 05 44 19 01 00 	lea    0x11944(%rip),%rax        # 147b0 <fwp_stack_guard_init.alt>
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
    2ee5:	48 8d 05 c4 b6 00 00 	lea    0xb6c4(%rip),%rax        # e5b0 <fwp_segv>
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
    2f27:	48 8b 15 3a f2 00 00 	mov    0xf23a(%rip),%rdx        # 12168 <fwp_gc>
    2f2e:	80 3d 7b 18 02 00 00 	cmpb   $0x0,0x2187b(%rip)        # 247b0 <caf0.st>
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
    2f66:	e8 e5 74 00 00       	call   a450 <fwp_data>
    2f6b:	48 89 c1             	mov    %rax,%rcx
    2f6e:	48 2b 0d 23 02 01 00 	sub    0x10223(%rip),%rcx        # 13198 <fwp_gc+0x1030>
    2f75:	48 8b 15 44 02 01 00 	mov    0x10244(%rip),%rdx        # 131c0 <fwp_gc+0x1058>
    2f7c:	48 c1 e2 10          	shl    $0x10,%rdx
    2f80:	48 39 d1             	cmp    %rdx,%rcx
    2f83:	73 76                	jae    2ffb <fwp_main_thread+0x29b>
    2f85:	48 8b 15 54 02 01 00 	mov    0x10254(%rip),%rdx        # 131e0 <fwp_gc+0x1078>
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
    2ff1:	e8 9a 3a 00 00       	call   6a90 <fwp_rc_forget_slot>
    2ff6:	48 89 d8             	mov    %rbx,%rax
    2ff9:	eb c3                	jmp    2fbe <fwp_main_thread+0x25e>
    2ffb:	48 b9 00 00 00 00 00 	movabs $0x3fd0000000000000,%rcx
    3002:	00 d0 3f 
    3005:	48 89 4d a0          	mov    %rcx,-0x60(%rbp)
    3009:	48 89 45 a8          	mov    %rax,-0x58(%rbp)
    300d:	48 8d 55 a0          	lea    -0x60(%rbp),%rdx
    3011:	bf 01 00 00 00       	mov    $0x1,%edi
    3016:	be 02 00 00 00       	mov    $0x2,%esi
    301b:	e8 30 74 00 00       	call   a450 <fwp_data>
    3020:	48 89 c1             	mov    %rax,%rcx
    3023:	48 2b 0d 6e 01 01 00 	sub    0x1016e(%rip),%rcx        # 13198 <fwp_gc+0x1030>
    302a:	48 8b 15 8f 01 01 00 	mov    0x1018f(%rip),%rdx        # 131c0 <fwp_gc+0x1058>
    3031:	48 c1 e2 10          	shl    $0x10,%rdx
    3035:	48 39 d1             	cmp    %rdx,%rcx
    3038:	73 76                	jae    30b0 <fwp_main_thread+0x350>
    303a:	48 8b 15 9f 01 01 00 	mov    0x1019f(%rip),%rdx        # 131e0 <fwp_gc+0x1078>
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
    30a6:	e8 e5 39 00 00       	call   6a90 <fwp_rc_forget_slot>
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
    30dd:	e8 6e 73 00 00       	call   a450 <fwp_data>
    30e2:	48 89 c1             	mov    %rax,%rcx
    30e5:	48 2b 0d ac 00 01 00 	sub    0x100ac(%rip),%rcx        # 13198 <fwp_gc+0x1030>
    30ec:	48 8b 15 cd 00 01 00 	mov    0x100cd(%rip),%rdx        # 131c0 <fwp_gc+0x1058>
    30f3:	48 c1 e2 10          	shl    $0x10,%rdx
    30f7:	48 39 d1             	cmp    %rdx,%rcx
    30fa:	73 76                	jae    3172 <fwp_main_thread+0x412>
    30fc:	48 8b 15 dd 00 01 00 	mov    0x100dd(%rip),%rdx        # 131e0 <fwp_gc+0x1078>
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
    3168:	e8 23 39 00 00       	call   6a90 <fwp_rc_forget_slot>
    316d:	48 89 d8             	mov    %rbx,%rax
    3170:	eb c3                	jmp    3135 <fwp_main_thread+0x3d5>
    3172:	48 b9 00 00 00 00 00 	movabs $0x3ff8000000000000,%rcx
    3179:	00 f8 3f 
    317c:	48 89 8d c0 fe ff ff 	mov    %rcx,-0x140(%rbp)
    3183:	48 89 85 c8 fe ff ff 	mov    %rax,-0x138(%rbp)
    318a:	48 8d 95 c0 fe ff ff 	lea    -0x140(%rbp),%rdx
    3191:	bf 01 00 00 00       	mov    $0x1,%edi
    3196:	be 02 00 00 00       	mov    $0x2,%esi
    319b:	e8 b0 72 00 00       	call   a450 <fwp_data>
    31a0:	49 89 c6             	mov    %rax,%r14
    31a3:	48 2b 05 ee ff 00 00 	sub    0xffee(%rip),%rax        # 13198 <fwp_gc+0x1030>
    31aa:	48 8b 0d 0f 00 01 00 	mov    0x1000f(%rip),%rcx        # 131c0 <fwp_gc+0x1058>
    31b1:	48 c1 e1 10          	shl    $0x10,%rcx
    31b5:	48 39 c8             	cmp    %rcx,%rax
    31b8:	73 6f                	jae    3229 <fwp_main_thread+0x4c9>
    31ba:	48 8b 0d 1f 00 01 00 	mov    0x1001f(%rip),%rcx        # 131e0 <fwp_gc+0x1078>
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
    3222:	e8 69 38 00 00       	call   6a90 <fwp_rc_forget_slot>
    3227:	eb c9                	jmp    31f2 <fwp_main_thread+0x492>
    3229:	48 8d 35 20 ea 00 00 	lea    0xea20(%rip),%rsi        # 11c50 <d0>
    3230:	4c 89 f7             	mov    %r14,%rdi
    3233:	e8 58 39 00 00       	call   6b90 <fwp_p_array_from_list_typed>
    3238:	49 89 c7             	mov    %rax,%r15
    323b:	4c 89 f7             	mov    %r14,%rdi
    323e:	e8 cd b3 00 00       	call   e610 <fwp_drop0>
    3243:	31 db                	xor    %ebx,%ebx
    3245:	be 04 00 00 00       	mov    $0x4,%esi
    324a:	31 ff                	xor    %edi,%edi
    324c:	4c 89 fa             	mov    %r15,%rdx
    324f:	e8 8c 46 00 00       	call   78e0 <f12>
    3254:	49 89 c6             	mov    %rax,%r14
    3257:	4c 89 ff             	mov    %r15,%rdi
    325a:	e8 41 78 00 00       	call   aaa0 <fwp_drop1>
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
    32b3:	e8 e8 77 00 00       	call   aaa0 <fwp_drop1>
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
    330d:	48 8d 35 3c e9 00 00 	lea    0xe93c(%rip),%rsi        # 11c50 <d0>
    3314:	e8 37 4a 00 00       	call   7d50 <fwp_show>
    3319:	49 89 c6             	mov    %rax,%r14
    331c:	48 2b 05 75 fe 00 00 	sub    0xfe75(%rip),%rax        # 13198 <fwp_gc+0x1030>
    3323:	48 8b 0d 96 fe 00 00 	mov    0xfe96(%rip),%rcx        # 131c0 <fwp_gc+0x1058>
    332a:	48 c1 e1 10          	shl    $0x10,%rcx
    332e:	48 39 c8             	cmp    %rcx,%rax
    3331:	73 6f                	jae    33a2 <fwp_main_thread+0x642>
    3333:	48 8b 0d a6 fe 00 00 	mov    0xfea6(%rip),%rcx        # 131e0 <fwp_gc+0x1078>
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
    339b:	e8 f0 36 00 00       	call   6a90 <fwp_rc_forget_slot>
    33a0:	eb c9                	jmp    336b <fwp_main_thread+0x60b>
    33a2:	4c 89 f7             	mov    %r14,%rdi
    33a5:	48 83 c7 08          	add    $0x8,%rdi
    33a9:	49 8b 16             	mov    (%r14),%rdx
    33ac:	48 8b 0d b5 13 01 00 	mov    0x113b5(%rip),%rcx        # 14768 <fwp_prog_out>
    33b3:	be 01 00 00 00       	mov    $0x1,%esi
    33b8:	e8 c3 ee ff ff       	call   2280 <fwrite@plt>
    33bd:	48 8b 35 a4 13 01 00 	mov    0x113a4(%rip),%rsi        # 14768 <fwp_prog_out>
    33c4:	bf 0a 00 00 00       	mov    $0xa,%edi
    33c9:	e8 62 ed ff ff       	call   2130 <fputc@plt>
    33ce:	4c 89 f0             	mov    %r14,%rax
    33d1:	48 2b 05 c0 fd 00 00 	sub    0xfdc0(%rip),%rax        # 13198 <fwp_gc+0x1030>
    33d8:	48 8b 0d e1 fd 00 00 	mov    0xfde1(%rip),%rcx        # 131c0 <fwp_gc+0x1058>
    33df:	48 c1 e1 10          	shl    $0x10,%rcx
    33e3:	48 39 c8             	cmp    %rcx,%rax
    33e6:	73 7a                	jae    3462 <fwp_main_thread+0x702>
    33e8:	48 8b 0d f1 fd 00 00 	mov    0xfdf1(%rip),%rcx        # 131e0 <fwp_gc+0x1078>
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
    344c:	e8 1f 7b 00 00       	call   af70 <fwp_rc_free_obj>
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
    3492:	e8 b9 6f 00 00       	call   a450 <fwp_data>
    3497:	48 89 c1             	mov    %rax,%rcx
    349a:	48 2b 0d f7 fc 00 00 	sub    0xfcf7(%rip),%rcx        # 13198 <fwp_gc+0x1030>
    34a1:	48 8b 15 18 fd 00 00 	mov    0xfd18(%rip),%rdx        # 131c0 <fwp_gc+0x1058>
    34a8:	48 c1 e2 10          	shl    $0x10,%rdx
    34ac:	48 39 d1             	cmp    %rdx,%rcx
    34af:	73 76                	jae    3527 <fwp_main_thread+0x7c7>
    34b1:	48 8b 15 28 fd 00 00 	mov    0xfd28(%rip),%rdx        # 131e0 <fwp_gc+0x1078>
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
    351d:	e8 6e 35 00 00       	call   6a90 <fwp_rc_forget_slot>
    3522:	48 89 d8             	mov    %rbx,%rax
    3525:	eb c3                	jmp    34ea <fwp_main_thread+0x78a>
    3527:	48 c7 85 e0 fe ff ff 	movq   $0x3e800000,-0x120(%rbp)
    352e:	00 00 80 3e 
    3532:	48 89 85 e8 fe ff ff 	mov    %rax,-0x118(%rbp)
    3539:	48 8d 95 e0 fe ff ff 	lea    -0x120(%rbp),%rdx
    3540:	bf 01 00 00 00       	mov    $0x1,%edi
    3545:	be 02 00 00 00       	mov    $0x2,%esi
    354a:	e8 01 6f 00 00       	call   a450 <fwp_data>
    354f:	48 89 c1             	mov    %rax,%rcx
    3552:	48 2b 0d 3f fc 00 00 	sub    0xfc3f(%rip),%rcx        # 13198 <fwp_gc+0x1030>
    3559:	48 8b 15 60 fc 00 00 	mov    0xfc60(%rip),%rdx        # 131c0 <fwp_gc+0x1058>
    3560:	48 c1 e2 10          	shl    $0x10,%rdx
    3564:	48 39 d1             	cmp    %rdx,%rcx
    3567:	73 76                	jae    35df <fwp_main_thread+0x87f>
    3569:	48 8b 15 70 fc 00 00 	mov    0xfc70(%rip),%rdx        # 131e0 <fwp_gc+0x1078>
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
    35d5:	e8 b6 34 00 00       	call   6a90 <fwp_rc_forget_slot>
    35da:	48 89 d8             	mov    %rbx,%rax
    35dd:	eb c3                	jmp    35a2 <fwp_main_thread+0x842>
    35df:	4c 89 bd f0 fe ff ff 	mov    %r15,-0x110(%rbp)
    35e6:	48 89 85 f8 fe ff ff 	mov    %rax,-0x108(%rbp)
    35ed:	48 8d 95 f0 fe ff ff 	lea    -0x110(%rbp),%rdx
    35f4:	bf 01 00 00 00       	mov    $0x1,%edi
    35f9:	be 02 00 00 00       	mov    $0x2,%esi
    35fe:	e8 4d 6e 00 00       	call   a450 <fwp_data>
    3603:	48 89 c1             	mov    %rax,%rcx
    3606:	48 2b 0d 8b fb 00 00 	sub    0xfb8b(%rip),%rcx        # 13198 <fwp_gc+0x1030>
    360d:	48 8b 15 ac fb 00 00 	mov    0xfbac(%rip),%rdx        # 131c0 <fwp_gc+0x1058>
    3614:	48 c1 e2 10          	shl    $0x10,%rdx
    3618:	48 39 d1             	cmp    %rdx,%rcx
    361b:	73 76                	jae    3693 <fwp_main_thread+0x933>
    361d:	48 8b 15 bc fb 00 00 	mov    0xfbbc(%rip),%rdx        # 131e0 <fwp_gc+0x1078>
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
    3689:	e8 02 34 00 00       	call   6a90 <fwp_rc_forget_slot>
    368e:	48 89 d8             	mov    %rbx,%rax
    3691:	eb c3                	jmp    3656 <fwp_main_thread+0x8f6>
    3693:	48 c7 85 00 ff ff ff 	movq   $0x3fc00000,-0x100(%rbp)
    369a:	00 00 c0 3f 
    369e:	48 89 85 08 ff ff ff 	mov    %rax,-0xf8(%rbp)
    36a5:	48 8d 95 00 ff ff ff 	lea    -0x100(%rbp),%rdx
    36ac:	bf 01 00 00 00       	mov    $0x1,%edi
    36b1:	be 02 00 00 00       	mov    $0x2,%esi
    36b6:	e8 95 6d 00 00       	call   a450 <fwp_data>
    36bb:	49 89 c7             	mov    %rax,%r15
    36be:	48 2b 05 d3 fa 00 00 	sub    0xfad3(%rip),%rax        # 13198 <fwp_gc+0x1030>
    36c5:	48 8b 0d f4 fa 00 00 	mov    0xfaf4(%rip),%rcx        # 131c0 <fwp_gc+0x1058>
    36cc:	48 c1 e1 10          	shl    $0x10,%rcx
    36d0:	48 39 c8             	cmp    %rcx,%rax
    36d3:	73 6f                	jae    3744 <fwp_main_thread+0x9e4>
    36d5:	48 8b 0d 04 fb 00 00 	mov    0xfb04(%rip),%rcx        # 131e0 <fwp_gc+0x1078>
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
    373d:	e8 4e 33 00 00       	call   6a90 <fwp_rc_forget_slot>
    3742:	eb c9                	jmp    370d <fwp_main_thread+0x9ad>
    3744:	48 8d 35 c5 e5 00 00 	lea    0xe5c5(%rip),%rsi        # 11d10 <d2>
    374b:	4c 89 ff             	mov    %r15,%rdi
    374e:	e8 3d 34 00 00       	call   6b90 <fwp_p_array_from_list_typed>
    3753:	4c 89 f9             	mov    %r15,%rcx
    3756:	48 2b 0d 3b fa 00 00 	sub    0xfa3b(%rip),%rcx        # 13198 <fwp_gc+0x1030>
    375d:	49 89 c6             	mov    %rax,%r14
    3760:	48 8b 05 59 fa 00 00 	mov    0xfa59(%rip),%rax        # 131c0 <fwp_gc+0x1058>
    3767:	48 c1 e0 10          	shl    $0x10,%rax
    376b:	48 39 c1             	cmp    %rax,%rcx
    376e:	0f 83 a0 00 00 00    	jae    3814 <fwp_main_thread+0xab4>
    3774:	48 8b 05 65 fa 00 00 	mov    0xfa65(%rip),%rax        # 131e0 <fwp_gc+0x1078>
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
    37dd:	e8 8e 77 00 00       	call   af70 <fwp_rc_free_obj>
    37e2:	48 89 d9             	mov    %rbx,%rcx
    37e5:	48 2b 0d ac f9 00 00 	sub    0xf9ac(%rip),%rcx        # 13198 <fwp_gc+0x1030>
    37ec:	48 8b 05 cd f9 00 00 	mov    0xf9cd(%rip),%rax        # 131c0 <fwp_gc+0x1058>
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
    3833:	e8 98 95 00 00       	call   cdd0 <fwp_drop7>
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
    389f:	48 8d 35 6a e4 00 00 	lea    0xe46a(%rip),%rsi        # 11d10 <d2>
    38a6:	e8 a5 44 00 00       	call   7d50 <fwp_show>
    38ab:	49 89 c6             	mov    %rax,%r14
    38ae:	48 2b 05 e3 f8 00 00 	sub    0xf8e3(%rip),%rax        # 13198 <fwp_gc+0x1030>
    38b5:	48 8b 0d 04 f9 00 00 	mov    0xf904(%rip),%rcx        # 131c0 <fwp_gc+0x1058>
    38bc:	48 c1 e1 10          	shl    $0x10,%rcx
    38c0:	48 39 c8             	cmp    %rcx,%rax
    38c3:	73 6f                	jae    3934 <fwp_main_thread+0xbd4>
    38c5:	48 8b 0d 14 f9 00 00 	mov    0xf914(%rip),%rcx        # 131e0 <fwp_gc+0x1078>
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
    392d:	e8 5e 31 00 00       	call   6a90 <fwp_rc_forget_slot>
    3932:	eb c9                	jmp    38fd <fwp_main_thread+0xb9d>
    3934:	4c 89 f7             	mov    %r14,%rdi
    3937:	48 83 c7 08          	add    $0x8,%rdi
    393b:	49 8b 16             	mov    (%r14),%rdx
    393e:	48 8b 0d 23 0e 01 00 	mov    0x10e23(%rip),%rcx        # 14768 <fwp_prog_out>
    3945:	be 01 00 00 00       	mov    $0x1,%esi
    394a:	e8 31 e9 ff ff       	call   2280 <fwrite@plt>
    394f:	48 8b 35 12 0e 01 00 	mov    0x10e12(%rip),%rsi        # 14768 <fwp_prog_out>
    3956:	bf 0a 00 00 00       	mov    $0xa,%edi
    395b:	e8 d0 e7 ff ff       	call   2130 <fputc@plt>
    3960:	4c 89 f0             	mov    %r14,%rax
    3963:	48 2b 05 2e f8 00 00 	sub    0xf82e(%rip),%rax        # 13198 <fwp_gc+0x1030>
    396a:	48 8b 0d 4f f8 00 00 	mov    0xf84f(%rip),%rcx        # 131c0 <fwp_gc+0x1058>
    3971:	48 c1 e1 10          	shl    $0x10,%rcx
    3975:	48 39 c8             	cmp    %rcx,%rax
    3978:	73 7a                	jae    39f4 <fwp_main_thread+0xc94>
    397a:	48 8b 0d 5f f8 00 00 	mov    0xf85f(%rip),%rcx        # 131e0 <fwp_gc+0x1078>
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
    39de:	e8 8d 75 00 00       	call   af70 <fwp_rc_free_obj>
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
    3a1b:	e8 30 6a 00 00       	call   a450 <fwp_data>
    3a20:	48 89 c1             	mov    %rax,%rcx
    3a23:	48 2b 0d 6e f7 00 00 	sub    0xf76e(%rip),%rcx        # 13198 <fwp_gc+0x1030>
    3a2a:	48 8b 15 8f f7 00 00 	mov    0xf78f(%rip),%rdx        # 131c0 <fwp_gc+0x1058>
    3a31:	48 c1 e2 10          	shl    $0x10,%rdx
    3a35:	48 39 d1             	cmp    %rdx,%rcx
    3a38:	73 76                	jae    3ab0 <fwp_main_thread+0xd50>
    3a3a:	48 8b 15 9f f7 00 00 	mov    0xf79f(%rip),%rdx        # 131e0 <fwp_gc+0x1078>
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
    3aa6:	e8 e5 2f 00 00       	call   6a90 <fwp_rc_forget_slot>
    3aab:	48 89 d8             	mov    %rbx,%rax
    3aae:	eb c3                	jmp    3a73 <fwp_main_thread+0xd13>
    3ab0:	48 c7 85 20 ff ff ff 	movq   $0x0,-0xe0(%rbp)
    3ab7:	00 00 00 00 
    3abb:	48 89 85 28 ff ff ff 	mov    %rax,-0xd8(%rbp)
    3ac2:	48 8d 95 20 ff ff ff 	lea    -0xe0(%rbp),%rdx
    3ac9:	bf 01 00 00 00       	mov    $0x1,%edi
    3ace:	be 02 00 00 00       	mov    $0x2,%esi
    3ad3:	e8 78 69 00 00       	call   a450 <fwp_data>
    3ad8:	48 89 c1             	mov    %rax,%rcx
    3adb:	48 2b 0d b6 f6 00 00 	sub    0xf6b6(%rip),%rcx        # 13198 <fwp_gc+0x1030>
    3ae2:	48 8b 15 d7 f6 00 00 	mov    0xf6d7(%rip),%rdx        # 131c0 <fwp_gc+0x1058>
    3ae9:	48 c1 e2 10          	shl    $0x10,%rdx
    3aed:	48 39 d1             	cmp    %rdx,%rcx
    3af0:	73 76                	jae    3b68 <fwp_main_thread+0xe08>
    3af2:	48 8b 15 e7 f6 00 00 	mov    0xf6e7(%rip),%rdx        # 131e0 <fwp_gc+0x1078>
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
    3b5e:	e8 2d 2f 00 00       	call   6a90 <fwp_rc_forget_slot>
    3b63:	48 89 d8             	mov    %rbx,%rax
    3b66:	eb c3                	jmp    3b2b <fwp_main_thread+0xdcb>
    3b68:	48 c7 85 30 ff ff ff 	movq   $0xffffffffffffff80,-0xd0(%rbp)
    3b6f:	80 ff ff ff 
    3b73:	48 89 85 38 ff ff ff 	mov    %rax,-0xc8(%rbp)
    3b7a:	48 8d 95 30 ff ff ff 	lea    -0xd0(%rbp),%rdx
    3b81:	bf 01 00 00 00       	mov    $0x1,%edi
    3b86:	be 02 00 00 00       	mov    $0x2,%esi
    3b8b:	e8 c0 68 00 00       	call   a450 <fwp_data>
    3b90:	49 89 c7             	mov    %rax,%r15
    3b93:	48 2b 05 fe f5 00 00 	sub    0xf5fe(%rip),%rax        # 13198 <fwp_gc+0x1030>
    3b9a:	48 8b 0d 1f f6 00 00 	mov    0xf61f(%rip),%rcx        # 131c0 <fwp_gc+0x1058>
    3ba1:	48 c1 e1 10          	shl    $0x10,%rcx
    3ba5:	48 39 c8             	cmp    %rcx,%rax
    3ba8:	73 6f                	jae    3c19 <fwp_main_thread+0xeb9>
    3baa:	48 8b 0d 2f f6 00 00 	mov    0xf62f(%rip),%rcx        # 131e0 <fwp_gc+0x1078>
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
    3c12:	e8 79 2e 00 00       	call   6a90 <fwp_rc_forget_slot>
    3c17:	eb c9                	jmp    3be2 <fwp_main_thread+0xe82>
    3c19:	48 8d 35 90 e0 00 00 	lea    0xe090(%rip),%rsi        # 11cb0 <d1>
    3c20:	4c 89 ff             	mov    %r15,%rdi
    3c23:	e8 68 2f 00 00       	call   6b90 <fwp_p_array_from_list_typed>
    3c28:	49 89 c6             	mov    %rax,%r14
    3c2b:	4c 89 ff             	mov    %r15,%rdi
    3c2e:	e8 ad aa 00 00       	call   e6e0 <fwp_drop4>
    3c33:	31 db                	xor    %ebx,%ebx
    3c35:	45 31 ff             	xor    %r15d,%r15d
    3c38:	45 31 e4             	xor    %r12d,%r12d
    3c3b:	45 31 ed             	xor    %r13d,%r13d
    3c3e:	31 ff                	xor    %edi,%edi
    3c40:	eb 22                	jmp    3c64 <fwp_main_thread+0xf04>
    3c42:	66 66 66 66 66 2e 0f 	data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    3c49:	1f 84 00 00 00 00 00 
    3c50:	4c 89 f7             	mov    %r14,%rdi
    3c53:	e8 48 98 00 00       	call   d4a0 <fwp_drop9>
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
    3cbb:	e8 f0 64 00 00       	call   a1b0 <fwp_show_i64>
    3cc0:	49 89 c6             	mov    %rax,%r14
    3cc3:	48 2b 05 ce f4 00 00 	sub    0xf4ce(%rip),%rax        # 13198 <fwp_gc+0x1030>
    3cca:	48 8b 0d ef f4 00 00 	mov    0xf4ef(%rip),%rcx        # 131c0 <fwp_gc+0x1058>
    3cd1:	48 c1 e1 10          	shl    $0x10,%rcx
    3cd5:	48 39 c8             	cmp    %rcx,%rax
    3cd8:	73 6f                	jae    3d49 <fwp_main_thread+0xfe9>
    3cda:	48 8b 0d ff f4 00 00 	mov    0xf4ff(%rip),%rcx        # 131e0 <fwp_gc+0x1078>
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
    3d42:	e8 49 2d 00 00       	call   6a90 <fwp_rc_forget_slot>
    3d47:	eb c9                	jmp    3d12 <fwp_main_thread+0xfb2>
    3d49:	4c 89 f7             	mov    %r14,%rdi
    3d4c:	48 83 c7 08          	add    $0x8,%rdi
    3d50:	49 8b 16             	mov    (%r14),%rdx
    3d53:	48 8b 0d 0e 0a 01 00 	mov    0x10a0e(%rip),%rcx        # 14768 <fwp_prog_out>
    3d5a:	be 01 00 00 00       	mov    $0x1,%esi
    3d5f:	e8 1c e5 ff ff       	call   2280 <fwrite@plt>
    3d64:	48 8b 35 fd 09 01 00 	mov    0x109fd(%rip),%rsi        # 14768 <fwp_prog_out>
    3d6b:	bf 0a 00 00 00       	mov    $0xa,%edi
    3d70:	e8 bb e3 ff ff       	call   2130 <fputc@plt>
    3d75:	4c 89 f0             	mov    %r14,%rax
    3d78:	48 2b 05 19 f4 00 00 	sub    0xf419(%rip),%rax        # 13198 <fwp_gc+0x1030>
    3d7f:	48 8b 0d 3a f4 00 00 	mov    0xf43a(%rip),%rcx        # 131c0 <fwp_gc+0x1058>
    3d86:	48 c1 e1 10          	shl    $0x10,%rcx
    3d8a:	48 39 c8             	cmp    %rcx,%rax
    3d8d:	73 7a                	jae    3e09 <fwp_main_thread+0x10a9>
    3d8f:	48 8b 0d 4a f4 00 00 	mov    0xf44a(%rip),%rcx        # 131e0 <fwp_gc+0x1078>
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
    3df3:	e8 78 71 00 00       	call   af70 <fwp_rc_free_obj>
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
    3e30:	e8 1b 66 00 00       	call   a450 <fwp_data>
    3e35:	48 89 c1             	mov    %rax,%rcx
    3e38:	48 2b 0d 59 f3 00 00 	sub    0xf359(%rip),%rcx        # 13198 <fwp_gc+0x1030>
    3e3f:	48 8b 15 7a f3 00 00 	mov    0xf37a(%rip),%rdx        # 131c0 <fwp_gc+0x1058>
    3e46:	48 c1 e2 10          	shl    $0x10,%rdx
    3e4a:	48 39 d1             	cmp    %rdx,%rcx
    3e4d:	73 76                	jae    3ec5 <fwp_main_thread+0x1165>
    3e4f:	48 8b 15 8a f3 00 00 	mov    0xf38a(%rip),%rdx        # 131e0 <fwp_gc+0x1078>
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
    3ebb:	e8 d0 2b 00 00       	call   6a90 <fwp_rc_forget_slot>
    3ec0:	48 89 d8             	mov    %rbx,%rax
    3ec3:	eb c3                	jmp    3e88 <fwp_main_thread+0x1128>
    3ec5:	48 c7 85 50 ff ff ff 	movq   $0x2,-0xb0(%rbp)
    3ecc:	02 00 00 00 
    3ed0:	48 89 85 58 ff ff ff 	mov    %rax,-0xa8(%rbp)
    3ed7:	48 8d 95 50 ff ff ff 	lea    -0xb0(%rbp),%rdx
    3ede:	bf 01 00 00 00       	mov    $0x1,%edi
    3ee3:	be 02 00 00 00       	mov    $0x2,%esi
    3ee8:	e8 63 65 00 00       	call   a450 <fwp_data>
    3eed:	48 89 c1             	mov    %rax,%rcx
    3ef0:	48 2b 0d a1 f2 00 00 	sub    0xf2a1(%rip),%rcx        # 13198 <fwp_gc+0x1030>
    3ef7:	48 8b 15 c2 f2 00 00 	mov    0xf2c2(%rip),%rdx        # 131c0 <fwp_gc+0x1058>
    3efe:	48 c1 e2 10          	shl    $0x10,%rdx
    3f02:	48 39 d1             	cmp    %rdx,%rcx
    3f05:	73 76                	jae    3f7d <fwp_main_thread+0x121d>
    3f07:	48 8b 15 d2 f2 00 00 	mov    0xf2d2(%rip),%rdx        # 131e0 <fwp_gc+0x1078>
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
    3f73:	e8 18 2b 00 00       	call   6a90 <fwp_rc_forget_slot>
    3f78:	48 89 d8             	mov    %rbx,%rax
    3f7b:	eb c3                	jmp    3f40 <fwp_main_thread+0x11e0>
    3f7d:	48 c7 85 60 ff ff ff 	movq   $0x1,-0xa0(%rbp)
    3f84:	01 00 00 00 
    3f88:	48 89 85 68 ff ff ff 	mov    %rax,-0x98(%rbp)
    3f8f:	48 8d 95 60 ff ff ff 	lea    -0xa0(%rbp),%rdx
    3f96:	bf 01 00 00 00       	mov    $0x1,%edi
    3f9b:	be 02 00 00 00       	mov    $0x2,%esi
    3fa0:	e8 ab 64 00 00       	call   a450 <fwp_data>
    3fa5:	49 89 c7             	mov    %rax,%r15
    3fa8:	48 2b 05 e9 f1 00 00 	sub    0xf1e9(%rip),%rax        # 13198 <fwp_gc+0x1030>
    3faf:	48 8b 0d 0a f2 00 00 	mov    0xf20a(%rip),%rcx        # 131c0 <fwp_gc+0x1058>
    3fb6:	48 c1 e1 10          	shl    $0x10,%rcx
    3fba:	48 39 c8             	cmp    %rcx,%rax
    3fbd:	73 6f                	jae    402e <fwp_main_thread+0x12ce>
    3fbf:	48 8b 0d 1a f2 00 00 	mov    0xf21a(%rip),%rcx        # 131e0 <fwp_gc+0x1078>
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
    4027:	e8 64 2a 00 00       	call   6a90 <fwp_rc_forget_slot>
    402c:	eb c9                	jmp    3ff7 <fwp_main_thread+0x1297>
    402e:	48 8d 35 7b dc 00 00 	lea    0xdc7b(%rip),%rsi        # 11cb0 <d1>
    4035:	4c 89 ff             	mov    %r15,%rdi
    4038:	e8 53 2b 00 00       	call   6b90 <fwp_p_array_from_list_typed>
    403d:	49 89 c6             	mov    %rax,%r14
    4040:	4c 89 ff             	mov    %r15,%rdi
    4043:	e8 98 a6 00 00       	call   e6e0 <fwp_drop4>
    4048:	31 db                	xor    %ebx,%ebx
    404a:	45 31 ff             	xor    %r15d,%r15d
    404d:	45 31 e4             	xor    %r12d,%r12d
    4050:	45 31 ed             	xor    %r13d,%r13d
    4053:	31 ff                	xor    %edi,%edi
    4055:	eb 1d                	jmp    4074 <fwp_main_thread+0x1314>
    4057:	66 0f 1f 84 00 00 00 	nopw   0x0(%rax,%rax,1)
    405e:	00 00 
    4060:	4c 89 f7             	mov    %r14,%rdi
    4063:	e8 38 94 00 00       	call   d4a0 <fwp_drop9>
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
    40d6:	e8 d5 60 00 00       	call   a1b0 <fwp_show_i64>
    40db:	49 89 c6             	mov    %rax,%r14
    40de:	48 2b 05 b3 f0 00 00 	sub    0xf0b3(%rip),%rax        # 13198 <fwp_gc+0x1030>
    40e5:	48 8b 0d d4 f0 00 00 	mov    0xf0d4(%rip),%rcx        # 131c0 <fwp_gc+0x1058>
    40ec:	48 c1 e1 10          	shl    $0x10,%rcx
    40f0:	48 39 c8             	cmp    %rcx,%rax
    40f3:	73 6f                	jae    4164 <fwp_main_thread+0x1404>
    40f5:	48 8b 0d e4 f0 00 00 	mov    0xf0e4(%rip),%rcx        # 131e0 <fwp_gc+0x1078>
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
    415d:	e8 2e 29 00 00       	call   6a90 <fwp_rc_forget_slot>
    4162:	eb c9                	jmp    412d <fwp_main_thread+0x13cd>
    4164:	4c 89 f7             	mov    %r14,%rdi
    4167:	48 83 c7 08          	add    $0x8,%rdi
    416b:	49 8b 16             	mov    (%r14),%rdx
    416e:	48 8b 0d f3 05 01 00 	mov    0x105f3(%rip),%rcx        # 14768 <fwp_prog_out>
    4175:	be 01 00 00 00       	mov    $0x1,%esi
    417a:	e8 01 e1 ff ff       	call   2280 <fwrite@plt>
    417f:	48 8b 35 e2 05 01 00 	mov    0x105e2(%rip),%rsi        # 14768 <fwp_prog_out>
    4186:	bf 0a 00 00 00       	mov    $0xa,%edi
    418b:	e8 a0 df ff ff       	call   2130 <fputc@plt>
    4190:	4c 89 f0             	mov    %r14,%rax
    4193:	48 2b 05 fe ef 00 00 	sub    0xeffe(%rip),%rax        # 13198 <fwp_gc+0x1030>
    419a:	48 8b 0d 1f f0 00 00 	mov    0xf01f(%rip),%rcx        # 131c0 <fwp_gc+0x1058>
    41a1:	48 c1 e1 10          	shl    $0x10,%rcx
    41a5:	48 39 c8             	cmp    %rcx,%rax
    41a8:	73 7a                	jae    4224 <fwp_main_thread+0x14c4>
    41aa:	48 8b 0d 2f f0 00 00 	mov    0xf02f(%rip),%rcx        # 131e0 <fwp_gc+0x1078>
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
    420e:	e8 5d 6d 00 00       	call   af70 <fwp_rc_free_obj>
    4213:	eb 0f                	jmp    4224 <fwp_main_thread+0x14c4>
    4215:	3d ff 00 00 00       	cmp    $0xff,%eax
    421a:	0f 84 4e 06 00 00    	je     486e <fwp_main_thread+0x1b0e>
    4220:	fe c8                	dec    %al
    4222:	88 07                	mov    %al,(%rdi)
    4224:	48 8d 35 25 da 00 00 	lea    0xda25(%rip),%rsi        # 11c50 <d0>
    422b:	31 db                	xor    %ebx,%ebx
    422d:	31 ff                	xor    %edi,%edi
    422f:	e8 5c 2a 00 00       	call   6c90 <fwp_array_typed_new>
    4234:	49 89 c6             	mov    %rax,%r14
    4237:	31 ff                	xor    %edi,%edi
    4239:	e8 d2 a3 00 00       	call   e610 <fwp_drop0>
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
    42a3:	e8 f8 67 00 00       	call   aaa0 <fwp_drop1>
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
    42fd:	48 8d 35 4c d9 00 00 	lea    0xd94c(%rip),%rsi        # 11c50 <d0>
    4304:	e8 47 3a 00 00       	call   7d50 <fwp_show>
    4309:	49 89 c6             	mov    %rax,%r14
    430c:	48 2b 05 85 ee 00 00 	sub    0xee85(%rip),%rax        # 13198 <fwp_gc+0x1030>
    4313:	48 8b 0d a6 ee 00 00 	mov    0xeea6(%rip),%rcx        # 131c0 <fwp_gc+0x1058>
    431a:	48 c1 e1 10          	shl    $0x10,%rcx
    431e:	48 39 c8             	cmp    %rcx,%rax
    4321:	73 6f                	jae    4392 <fwp_main_thread+0x1632>
    4323:	48 8b 0d b6 ee 00 00 	mov    0xeeb6(%rip),%rcx        # 131e0 <fwp_gc+0x1078>
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
    438b:	e8 00 27 00 00       	call   6a90 <fwp_rc_forget_slot>
    4390:	eb c9                	jmp    435b <fwp_main_thread+0x15fb>
    4392:	4c 89 f7             	mov    %r14,%rdi
    4395:	48 83 c7 08          	add    $0x8,%rdi
    4399:	49 8b 16             	mov    (%r14),%rdx
    439c:	48 8b 0d c5 03 01 00 	mov    0x103c5(%rip),%rcx        # 14768 <fwp_prog_out>
    43a3:	be 01 00 00 00       	mov    $0x1,%esi
    43a8:	e8 d3 de ff ff       	call   2280 <fwrite@plt>
    43ad:	48 8b 35 b4 03 01 00 	mov    0x103b4(%rip),%rsi        # 14768 <fwp_prog_out>
    43b4:	bf 0a 00 00 00       	mov    $0xa,%edi
    43b9:	e8 72 dd ff ff       	call   2130 <fputc@plt>
    43be:	4c 89 f0             	mov    %r14,%rax
    43c1:	48 2b 05 d0 ed 00 00 	sub    0xedd0(%rip),%rax        # 13198 <fwp_gc+0x1030>
    43c8:	48 8b 0d f1 ed 00 00 	mov    0xedf1(%rip),%rcx        # 131c0 <fwp_gc+0x1058>
    43cf:	48 c1 e1 10          	shl    $0x10,%rcx
    43d3:	48 39 c8             	cmp    %rcx,%rax
    43d6:	73 7a                	jae    4452 <fwp_main_thread+0x16f2>
    43d8:	48 8b 0d 01 ee 00 00 	mov    0xee01(%rip),%rcx        # 131e0 <fwp_gc+0x1078>
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
    443c:	e8 2f 6b 00 00       	call   af70 <fwp_rc_free_obj>
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
    446f:	e8 dc 5f 00 00       	call   a450 <fwp_data>
    4474:	48 89 c1             	mov    %rax,%rcx
    4477:	48 2b 0d 1a ed 00 00 	sub    0xed1a(%rip),%rcx        # 13198 <fwp_gc+0x1030>
    447e:	48 8b 15 3b ed 00 00 	mov    0xed3b(%rip),%rdx        # 131c0 <fwp_gc+0x1058>
    4485:	48 c1 e2 10          	shl    $0x10,%rdx
    4489:	48 39 d1             	cmp    %rdx,%rcx
    448c:	73 76                	jae    4504 <fwp_main_thread+0x17a4>
    448e:	48 8b 15 4b ed 00 00 	mov    0xed4b(%rip),%rdx        # 131e0 <fwp_gc+0x1078>
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
    44fa:	e8 91 25 00 00       	call   6a90 <fwp_rc_forget_slot>
    44ff:	48 89 d8             	mov    %rbx,%rax
    4502:	eb c3                	jmp    44c7 <fwp_main_thread+0x1767>
    4504:	48 c7 85 70 ff ff ff 	movq   $0x0,-0x90(%rbp)
    450b:	00 00 00 00 
    450f:	48 89 85 78 ff ff ff 	mov    %rax,-0x88(%rbp)
    4516:	48 8d 95 70 ff ff ff 	lea    -0x90(%rbp),%rdx
    451d:	bf 01 00 00 00       	mov    $0x1,%edi
    4522:	be 02 00 00 00       	mov    $0x2,%esi
    4527:	e8 24 5f 00 00       	call   a450 <fwp_data>
    452c:	48 89 c1             	mov    %rax,%rcx
    452f:	48 2b 0d 62 ec 00 00 	sub    0xec62(%rip),%rcx        # 13198 <fwp_gc+0x1030>
    4536:	48 8b 15 83 ec 00 00 	mov    0xec83(%rip),%rdx        # 131c0 <fwp_gc+0x1058>
    453d:	48 c1 e2 10          	shl    $0x10,%rdx
    4541:	48 39 d1             	cmp    %rdx,%rcx
    4544:	73 76                	jae    45bc <fwp_main_thread+0x185c>
    4546:	48 8b 15 93 ec 00 00 	mov    0xec93(%rip),%rdx        # 131e0 <fwp_gc+0x1078>
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
    45b2:	e8 d9 24 00 00       	call   6a90 <fwp_rc_forget_slot>
    45b7:	48 89 d8             	mov    %rbx,%rax
    45ba:	eb c3                	jmp    457f <fwp_main_thread+0x181f>
    45bc:	48 c7 45 80 00 00 00 	movq   $0x0,-0x80(%rbp)
    45c3:	00 
    45c4:	48 89 45 88          	mov    %rax,-0x78(%rbp)
    45c8:	48 8d 55 80          	lea    -0x80(%rbp),%rdx
    45cc:	bf 01 00 00 00       	mov    $0x1,%edi
    45d1:	be 02 00 00 00       	mov    $0x2,%esi
    45d6:	e8 75 5e 00 00       	call   a450 <fwp_data>
    45db:	48 89 c1             	mov    %rax,%rcx
    45de:	48 2b 0d b3 eb 00 00 	sub    0xebb3(%rip),%rcx        # 13198 <fwp_gc+0x1030>
    45e5:	48 8b 15 d4 eb 00 00 	mov    0xebd4(%rip),%rdx        # 131c0 <fwp_gc+0x1058>
    45ec:	48 c1 e2 10          	shl    $0x10,%rdx
    45f0:	48 39 d1             	cmp    %rdx,%rcx
    45f3:	73 76                	jae    466b <fwp_main_thread+0x190b>
    45f5:	48 8b 15 e4 eb 00 00 	mov    0xebe4(%rip),%rdx        # 131e0 <fwp_gc+0x1078>
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
    4661:	e8 2a 24 00 00       	call   6a90 <fwp_rc_forget_slot>
    4666:	48 89 d8             	mov    %rbx,%rax
    4669:	eb c3                	jmp    462e <fwp_main_thread+0x18ce>
    466b:	48 c7 45 90 00 00 00 	movq   $0x0,-0x70(%rbp)
    4672:	00 
    4673:	48 89 45 98          	mov    %rax,-0x68(%rbp)
    4677:	48 8d 55 90          	lea    -0x70(%rbp),%rdx
    467b:	bf 01 00 00 00       	mov    $0x1,%edi
    4680:	be 02 00 00 00       	mov    $0x2,%esi
    4685:	e8 c6 5d 00 00       	call   a450 <fwp_data>
    468a:	48 89 c1             	mov    %rax,%rcx
    468d:	48 2b 0d 04 eb 00 00 	sub    0xeb04(%rip),%rcx        # 13198 <fwp_gc+0x1030>
    4694:	48 8b 15 25 eb 00 00 	mov    0xeb25(%rip),%rdx        # 131c0 <fwp_gc+0x1058>
    469b:	48 c1 e2 10          	shl    $0x10,%rdx
    469f:	48 39 d1             	cmp    %rdx,%rcx
    46a2:	73 76                	jae    471a <fwp_main_thread+0x19ba>
    46a4:	48 8b 15 35 eb 00 00 	mov    0xeb35(%rip),%rdx        # 131e0 <fwp_gc+0x1078>
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
    4710:	e8 7b 23 00 00       	call   6a90 <fwp_rc_forget_slot>
    4715:	48 89 d8             	mov    %rbx,%rax
    4718:	eb c3                	jmp    46dd <fwp_main_thread+0x197d>
    471a:	48 89 c1             	mov    %rax,%rcx
    471d:	48 2b 0d 74 ea 00 00 	sub    0xea74(%rip),%rcx        # 13198 <fwp_gc+0x1030>
    4724:	48 8b 15 95 ea 00 00 	mov    0xea95(%rip),%rdx        # 131c0 <fwp_gc+0x1058>
    472b:	48 c1 e2 10          	shl    $0x10,%rdx
    472f:	48 39 d1             	cmp    %rdx,%rcx
    4732:	0f 83 9c 00 00 00    	jae    47d4 <fwp_main_thread+0x1a74>
    4738:	48 8b 15 a1 ea 00 00 	mov    0xeaa1(%rip),%rdx        # 131e0 <fwp_gc+0x1078>
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
    47a0:	e8 cb 67 00 00       	call   af70 <fwp_rc_free_obj>
    47a5:	48 89 d9             	mov    %rbx,%rcx
    47a8:	48 2b 0d e9 e9 00 00 	sub    0xe9e9(%rip),%rcx        # 13198 <fwp_gc+0x1030>
    47af:	48 8b 15 0a ea 00 00 	mov    0xea0a(%rip),%rdx        # 131c0 <fwp_gc+0x1058>
    47b6:	48 c1 e2 10          	shl    $0x10,%rdx
    47ba:	48 89 d8             	mov    %rbx,%rax
    47bd:	48 39 d1             	cmp    %rdx,%rcx
    47c0:	0f 82 72 ff ff ff    	jb     4738 <fwp_main_thread+0x19d8>
    47c6:	eb 0c                	jmp    47d4 <fwp_main_thread+0x1a74>
    47c8:	81 f9 ff 00 00 00    	cmp    $0xff,%ecx
    47ce:	74 79                	je     4849 <fwp_main_thread+0x1ae9>
    47d0:	fe c9                	dec    %cl
    47d2:	88 0f                	mov    %cl,(%rdi)
    47d4:	c6 05 d5 ff 01 00 01 	movb   $0x1,0x1ffd5(%rip)        # 247b0 <caf0.st>
    47db:	48 8b 05 86 d9 00 00 	mov    0xd986(%rip),%rax        # 12168 <fwp_gc>
    47e2:	48 8b 55 b0          	mov    -0x50(%rbp),%rdx
    47e6:	48 83 3d 52 eb 00 00 	cmpq   $0x0,0xeb52(%rip)        # 13340 <fwp_gc+0x11d8>
    47ed:	00 
    47ee:	0f 85 ec 00 00 00    	jne    48e0 <fwp_main_thread+0x1b80>
    47f4:	83 3d 5d e9 00 00 00 	cmpl   $0x0,0xe95d(%rip)        # 13158 <fwp_gc+0xff0>
    47fb:	0f 85 df 00 00 00    	jne    48e0 <fwp_main_thread+0x1b80>
    4801:	48 39 c2             	cmp    %rax,%rdx
    4804:	0f 8f d6 00 00 00    	jg     48e0 <fwp_main_thread+0x1b80>
    480a:	66 0f 57 c0          	xorpd  %xmm0,%xmm0
    480e:	66 0f 2e 05 5a eb 00 	ucomisd 0xeb5a(%rip),%xmm0        # 13370 <fwp_gc+0x1208>
    4815:	00 
    4816:	0f 83 c4 00 00 00    	jae    48e0 <fwp_main_thread+0x1b80>
    481c:	48 8b 05 9d d7 00 00 	mov    0xd79d(%rip),%rax        # 11fc0 <stdout@GLIBC_2.2.5>
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
    483f:	e8 4c 64 00 00       	call   ac90 <fwp_rc_wide_drop>
    4844:	e9 cb ef ff ff       	jmp    3814 <fwp_main_thread+0xab4>
    4849:	e8 42 64 00 00       	call   ac90 <fwp_rc_wide_drop>
    484e:	eb 84                	jmp    47d4 <fwp_main_thread+0x1a74>
    4850:	e8 3b 64 00 00       	call   ac90 <fwp_rc_wide_drop>
    4855:	e9 08 ec ff ff       	jmp    3462 <fwp_main_thread+0x702>
    485a:	e8 31 64 00 00       	call   ac90 <fwp_rc_wide_drop>
    485f:	e9 90 f1 ff ff       	jmp    39f4 <fwp_main_thread+0xc94>
    4864:	e8 27 64 00 00       	call   ac90 <fwp_rc_wide_drop>
    4869:	e9 9b f5 ff ff       	jmp    3e09 <fwp_main_thread+0x10a9>
    486e:	e8 1d 64 00 00       	call   ac90 <fwp_rc_wide_drop>
    4873:	e9 ac f9 ff ff       	jmp    4224 <fwp_main_thread+0x14c4>
    4878:	e8 13 64 00 00       	call   ac90 <fwp_rc_wide_drop>
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
    48b6:	e8 a5 21 00 00       	call   6a60 <fwp_flush>
    48bb:	48 8b 05 1e d7 00 00 	mov    0xd71e(%rip),%rax        # 11fe0 <stderr@GLIBC_2.2.5>
    48c2:	48 8b 38             	mov    (%rax),%rdi
    48c5:	48 8d 35 01 ac 00 00 	lea    0xac01(%rip),%rsi        # f4cd <fwp_segv.msg+0x24d>
    48cc:	48 89 da             	mov    %rbx,%rdx
    48cf:	31 c0                	xor    %eax,%eax
    48d1:	e8 ca d8 ff ff       	call   21a0 <fprintf@plt>
    48d6:	bf 65 00 00 00       	mov    $0x65,%edi
    48db:	e8 90 d9 ff ff       	call   2270 <exit@plt>
    48e0:	48 8b 0d f9 d6 00 00 	mov    0xd6f9(%rip),%rcx        # 11fe0 <stderr@GLIBC_2.2.5>
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
    4917:	48 2b 05 7a e8 00 00 	sub    0xe87a(%rip),%rax        # 13198 <fwp_gc+0x1030>
    491e:	48 8b 0d 9b e8 00 00 	mov    0xe89b(%rip),%rcx        # 131c0 <fwp_gc+0x1058>
    4925:	48 c1 e1 10          	shl    $0x10,%rcx
    4929:	48 39 c8             	cmp    %rcx,%rax
    492c:	73 63                	jae    4991 <e1+0x81>
    492e:	48 8b 0d ab e8 00 00 	mov    0xe8ab(%rip),%rcx        # 131e0 <fwp_gc+0x1078>
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
    4991:	48 8d 35 b8 d2 00 00 	lea    0xd2b8(%rip),%rsi        # 11c50 <d0>
    4998:	e8 f3 21 00 00       	call   6b90 <fwp_p_array_from_list_typed>
    499d:	48 89 c1             	mov    %rax,%rcx
    49a0:	48 2b 0d f1 e7 00 00 	sub    0xe7f1(%rip),%rcx        # 13198 <fwp_gc+0x1030>
    49a7:	48 8b 15 12 e8 00 00 	mov    0xe812(%rip),%rdx        # 131c0 <fwp_gc+0x1058>
    49ae:	48 c1 e2 10          	shl    $0x10,%rdx
    49b2:	48 39 d1             	cmp    %rdx,%rcx
    49b5:	73 5f                	jae    4a16 <e1+0x106>
    49b7:	48 8b 15 22 e8 00 00 	mov    0xe822(%rip),%rdx        # 131e0 <fwp_gc+0x1078>
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
    4a18:	e8 43 20 00 00       	call   6a60 <fwp_flush>
    4a1d:	48 8b 05 bc d5 00 00 	mov    0xd5bc(%rip),%rax        # 11fe0 <stderr@GLIBC_2.2.5>
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
    4a57:	48 2b 05 3a e7 00 00 	sub    0xe73a(%rip),%rax        # 13198 <fwp_gc+0x1030>
    4a5e:	48 8b 0d 5b e7 00 00 	mov    0xe75b(%rip),%rcx        # 131c0 <fwp_gc+0x1058>
    4a65:	48 c1 e1 10          	shl    $0x10,%rcx
    4a69:	48 39 c8             	cmp    %rcx,%rax
    4a6c:	73 63                	jae    4ad1 <e4+0x81>
    4a6e:	48 8b 0d 6b e7 00 00 	mov    0xe76b(%rip),%rcx        # 131e0 <fwp_gc+0x1078>
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
    4ad1:	48 8d 35 d8 d1 00 00 	lea    0xd1d8(%rip),%rsi        # 11cb0 <d1>
    4ad8:	e8 b3 20 00 00       	call   6b90 <fwp_p_array_from_list_typed>
    4add:	48 89 c1             	mov    %rax,%rcx
    4ae0:	48 2b 0d b1 e6 00 00 	sub    0xe6b1(%rip),%rcx        # 13198 <fwp_gc+0x1030>
    4ae7:	48 8b 15 d2 e6 00 00 	mov    0xe6d2(%rip),%rdx        # 131c0 <fwp_gc+0x1058>
    4aee:	48 c1 e2 10          	shl    $0x10,%rdx
    4af2:	48 39 d1             	cmp    %rdx,%rcx
    4af5:	73 5f                	jae    4b56 <e4+0x106>
    4af7:	48 8b 15 e2 e6 00 00 	mov    0xe6e2(%rip),%rdx        # 131e0 <fwp_gc+0x1078>
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
    4b58:	e8 03 1f 00 00       	call   6a60 <fwp_flush>
    4b5d:	48 8b 05 7c d4 00 00 	mov    0xd47c(%rip),%rax        # 11fe0 <stderr@GLIBC_2.2.5>
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
    4b97:	48 2b 05 fa e5 00 00 	sub    0xe5fa(%rip),%rax        # 13198 <fwp_gc+0x1030>
    4b9e:	48 8b 0d 1b e6 00 00 	mov    0xe61b(%rip),%rcx        # 131c0 <fwp_gc+0x1058>
    4ba5:	48 c1 e1 10          	shl    $0x10,%rcx
    4ba9:	48 39 c8             	cmp    %rcx,%rax
    4bac:	73 63                	jae    4c11 <e9+0x81>
    4bae:	48 8b 0d 2b e6 00 00 	mov    0xe62b(%rip),%rcx        # 131e0 <fwp_gc+0x1078>
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
    4c11:	48 8d 35 f8 d0 00 00 	lea    0xd0f8(%rip),%rsi        # 11d10 <d2>
    4c18:	e8 73 1f 00 00       	call   6b90 <fwp_p_array_from_list_typed>
    4c1d:	48 89 c1             	mov    %rax,%rcx
    4c20:	48 2b 0d 71 e5 00 00 	sub    0xe571(%rip),%rcx        # 13198 <fwp_gc+0x1030>
    4c27:	48 8b 15 92 e5 00 00 	mov    0xe592(%rip),%rdx        # 131c0 <fwp_gc+0x1058>
    4c2e:	48 c1 e2 10          	shl    $0x10,%rdx
    4c32:	48 39 d1             	cmp    %rdx,%rcx
    4c35:	73 5f                	jae    4c96 <e9+0x106>
    4c37:	48 8b 15 a2 e5 00 00 	mov    0xe5a2(%rip),%rdx        # 131e0 <fwp_gc+0x1078>
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
    4c98:	e8 c3 1d 00 00       	call   6a60 <fwp_flush>
    4c9d:	48 8b 05 3c d3 00 00 	mov    0xd33c(%rip),%rax        # 11fe0 <stderr@GLIBC_2.2.5>
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
    4cd8:	48 2b 05 b9 e4 00 00 	sub    0xe4b9(%rip),%rax        # 13198 <fwp_gc+0x1030>
    4cdf:	48 8b 0d da e4 00 00 	mov    0xe4da(%rip),%rcx        # 131c0 <fwp_gc+0x1058>
    4ce6:	48 c1 e1 10          	shl    $0x10,%rcx
    4cea:	48 39 c8             	cmp    %rcx,%rax
    4ced:	73 64                	jae    4d53 <e12+0x83>
    4cef:	48 8b 0d ea e4 00 00 	mov    0xe4ea(%rip),%rcx        # 131e0 <fwp_gc+0x1078>
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
    4d5d:	e8 7e 2b 00 00       	call   78e0 <f12>
    4d62:	48 89 c1             	mov    %rax,%rcx
    4d65:	48 2b 0d 2c e4 00 00 	sub    0xe42c(%rip),%rcx        # 13198 <fwp_gc+0x1030>
    4d6c:	48 8b 15 4d e4 00 00 	mov    0xe44d(%rip),%rdx        # 131c0 <fwp_gc+0x1058>
    4d73:	48 c1 e2 10          	shl    $0x10,%rdx
    4d77:	48 39 d1             	cmp    %rdx,%rcx
    4d7a:	73 5f                	jae    4ddb <e12+0x10b>
    4d7c:	48 8b 15 5d e4 00 00 	mov    0xe45d(%rip),%rdx        # 131e0 <fwp_gc+0x1078>
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
    4ddd:	e8 7e 1c 00 00       	call   6a60 <fwp_flush>
    4de2:	48 8b 05 f7 d1 00 00 	mov    0xd1f7(%rip),%rax        # 11fe0 <stderr@GLIBC_2.2.5>
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
    4e17:	48 8d 35 f2 ce 00 00 	lea    0xcef2(%rip),%rsi        # 11d10 <d2>
    4e1e:	e8 2d 2f 00 00       	call   7d50 <fwp_show>
    4e23:	48 89 c1             	mov    %rax,%rcx
    4e26:	48 2b 0d 6b e3 00 00 	sub    0xe36b(%rip),%rcx        # 13198 <fwp_gc+0x1030>
    4e2d:	48 8b 15 8c e3 00 00 	mov    0xe38c(%rip),%rdx        # 131c0 <fwp_gc+0x1058>
    4e34:	48 c1 e2 10          	shl    $0x10,%rdx
    4e38:	48 39 d1             	cmp    %rdx,%rcx
    4e3b:	0f 83 8d 00 00 00    	jae    4ece <e15+0xbe>
    4e41:	48 8b 35 98 e3 00 00 	mov    0xe398(%rip),%rsi        # 131e0 <fwp_gc+0x1078>
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
    4e80:	48 8b 15 39 e3 00 00 	mov    0xe339(%rip),%rdx        # 131c0 <fwp_gc+0x1058>
    4e87:	48 89 c1             	mov    %rax,%rcx
    4e8a:	48 2b 0d 07 e3 00 00 	sub    0xe307(%rip),%rcx        # 13198 <fwp_gc+0x1030>
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
    4ec4:	e8 c7 1b 00 00       	call   6a90 <fwp_rc_forget_slot>
    4ec9:	4c 89 f0             	mov    %r14,%rax
    4ecc:	eb af                	jmp    4e7d <e15+0x6d>
    4ece:	48 39 d1             	cmp    %rdx,%rcx
    4ed1:	73 5f                	jae    4f32 <e15+0x122>
    4ed3:	48 8b 15 06 e3 00 00 	mov    0xe306(%rip),%rdx        # 131e0 <fwp_gc+0x1078>
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
    4f3a:	e8 21 1b 00 00       	call   6a60 <fwp_flush>
    4f3f:	48 8b 05 9a d0 00 00 	mov    0xd09a(%rip),%rax        # 11fe0 <stderr@GLIBC_2.2.5>
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
    4f77:	48 2b 05 1a e2 00 00 	sub    0xe21a(%rip),%rax        # 13198 <fwp_gc+0x1030>
    4f7e:	48 8b 0d 3b e2 00 00 	mov    0xe23b(%rip),%rcx        # 131c0 <fwp_gc+0x1058>
    4f85:	48 c1 e1 10          	shl    $0x10,%rcx
    4f89:	48 39 c8             	cmp    %rcx,%rax
    4f8c:	73 63                	jae    4ff1 <e16+0x81>
    4f8e:	48 8b 0d 4b e2 00 00 	mov    0xe24b(%rip),%rcx        # 131e0 <fwp_gc+0x1078>
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
    4ff8:	48 8b 0d 69 f7 00 00 	mov    0xf769(%rip),%rcx        # 14768 <fwp_prog_out>
    4fff:	be 01 00 00 00       	mov    $0x1,%esi
    5004:	e8 77 d2 ff ff       	call   2280 <fwrite@plt>
    5009:	48 8b 35 58 f7 00 00 	mov    0xf758(%rip),%rsi        # 14768 <fwp_prog_out>
    5010:	bf 0a 00 00 00       	mov    $0xa,%edi
    5015:	e8 16 d1 ff ff       	call   2130 <fputc@plt>
    501a:	31 c0                	xor    %eax,%eax
    501c:	48 2b 05 75 e1 00 00 	sub    0xe175(%rip),%rax        # 13198 <fwp_gc+0x1030>
    5023:	48 8b 0d 96 e1 00 00 	mov    0xe196(%rip),%rcx        # 131c0 <fwp_gc+0x1058>
    502a:	48 c1 e1 10          	shl    $0x10,%rcx
    502e:	48 39 c1             	cmp    %rax,%rcx
    5031:	76 5c                	jbe    508f <e16+0x11f>
    5033:	48 8b 0d a6 e1 00 00 	mov    0xe1a6(%rip),%rcx        # 131e0 <fwp_gc+0x1078>
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
    5093:	e8 c8 19 00 00       	call   6a60 <fwp_flush>
    5098:	48 8b 05 41 cf 00 00 	mov    0xcf41(%rip),%rax        # 11fe0 <stderr@GLIBC_2.2.5>
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
    50e3:	48 2b 0d ae e0 00 00 	sub    0xe0ae(%rip),%rcx        # 13198 <fwp_gc+0x1030>
    50ea:	48 8b 15 cf e0 00 00 	mov    0xe0cf(%rip),%rdx        # 131c0 <fwp_gc+0x1058>
    50f1:	48 c1 e2 10          	shl    $0x10,%rdx
    50f5:	48 39 d1             	cmp    %rdx,%rcx
    50f8:	73 5f                	jae    5159 <e24+0x89>
    50fa:	48 8b 15 df e0 00 00 	mov    0xe0df(%rip),%rdx        # 131e0 <fwp_gc+0x1078>
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
    515b:	e8 00 19 00 00       	call   6a60 <fwp_flush>
    5160:	48 8b 05 79 ce 00 00 	mov    0xce79(%rip),%rax        # 11fe0 <stderr@GLIBC_2.2.5>
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
    51a3:	48 2b 0d ee df 00 00 	sub    0xdfee(%rip),%rcx        # 13198 <fwp_gc+0x1030>
    51aa:	48 8b 15 0f e0 00 00 	mov    0xe00f(%rip),%rdx        # 131c0 <fwp_gc+0x1058>
    51b1:	48 c1 e2 10          	shl    $0x10,%rdx
    51b5:	48 39 d1             	cmp    %rdx,%rcx
    51b8:	73 5f                	jae    5219 <e25+0x89>
    51ba:	48 8b 15 1f e0 00 00 	mov    0xe01f(%rip),%rdx        # 131e0 <fwp_gc+0x1078>
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
    521b:	e8 40 18 00 00       	call   6a60 <fwp_flush>
    5220:	48 8b 05 b9 cd 00 00 	mov    0xcdb9(%rip),%rax        # 11fe0 <stderr@GLIBC_2.2.5>
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
    5257:	e8 54 4f 00 00       	call   a1b0 <fwp_show_i64>
    525c:	48 89 c1             	mov    %rax,%rcx
    525f:	48 2b 0d 32 df 00 00 	sub    0xdf32(%rip),%rcx        # 13198 <fwp_gc+0x1030>
    5266:	48 8b 15 53 df 00 00 	mov    0xdf53(%rip),%rdx        # 131c0 <fwp_gc+0x1058>
    526d:	48 c1 e2 10          	shl    $0x10,%rdx
    5271:	48 39 d1             	cmp    %rdx,%rcx
    5274:	0f 83 8d 00 00 00    	jae    5307 <e26+0xb7>
    527a:	48 8b 35 5f df 00 00 	mov    0xdf5f(%rip),%rsi        # 131e0 <fwp_gc+0x1078>
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
    52b9:	48 8b 15 00 df 00 00 	mov    0xdf00(%rip),%rdx        # 131c0 <fwp_gc+0x1058>
    52c0:	48 89 c1             	mov    %rax,%rcx
    52c3:	48 2b 0d ce de 00 00 	sub    0xdece(%rip),%rcx        # 13198 <fwp_gc+0x1030>
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
    52fd:	e8 8e 17 00 00       	call   6a90 <fwp_rc_forget_slot>
    5302:	4c 89 f0             	mov    %r14,%rax
    5305:	eb af                	jmp    52b6 <e26+0x66>
    5307:	48 39 d1             	cmp    %rdx,%rcx
    530a:	73 5f                	jae    536b <e26+0x11b>
    530c:	48 8b 15 cd de 00 00 	mov    0xdecd(%rip),%rdx        # 131e0 <fwp_gc+0x1078>
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
    5373:	e8 e8 16 00 00       	call   6a60 <fwp_flush>
    5378:	48 8b 05 61 cc 00 00 	mov    0xcc61(%rip),%rax        # 11fe0 <stderr@GLIBC_2.2.5>
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
    53c8:	48 2b 0d c9 dd 00 00 	sub    0xddc9(%rip),%rcx        # 13198 <fwp_gc+0x1030>
    53cf:	48 8b 15 ea dd 00 00 	mov    0xddea(%rip),%rdx        # 131c0 <fwp_gc+0x1058>
    53d6:	48 c1 e2 10          	shl    $0x10,%rdx
    53da:	48 39 d1             	cmp    %rdx,%rcx
    53dd:	73 5f                	jae    543e <e32+0x8e>
    53df:	48 8b 15 fa dd 00 00 	mov    0xddfa(%rip),%rdx        # 131e0 <fwp_gc+0x1078>
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
    5464:	e8 f7 15 00 00       	call   6a60 <fwp_flush>
    5469:	48 8b 05 70 cb 00 00 	mov    0xcb70(%rip),%rax        # 11fe0 <stderr@GLIBC_2.2.5>
    5470:	48 8b 38             	mov    (%rax),%rdi
    5473:	48 8d 35 53 a0 00 00 	lea    0xa053(%rip),%rsi        # f4cd <fwp_segv.msg+0x24d>
    547a:	48 89 da             	mov    %rbx,%rdx
    547d:	eb 1d                	jmp    549c <e32+0xec>
    547f:	e8 dc 15 00 00       	call   6a60 <fwp_flush>
    5484:	48 8b 05 55 cb 00 00 	mov    0xcb55(%rip),%rax        # 11fe0 <stderr@GLIBC_2.2.5>
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
    54b7:	e8 f4 4c 00 00       	call   a1b0 <fwp_show_i64>
    54bc:	48 89 c1             	mov    %rax,%rcx
    54bf:	48 2b 0d d2 dc 00 00 	sub    0xdcd2(%rip),%rcx        # 13198 <fwp_gc+0x1030>
    54c6:	48 8b 15 f3 dc 00 00 	mov    0xdcf3(%rip),%rdx        # 131c0 <fwp_gc+0x1058>
    54cd:	48 c1 e2 10          	shl    $0x10,%rdx
    54d1:	48 39 d1             	cmp    %rdx,%rcx
    54d4:	0f 83 8d 00 00 00    	jae    5567 <e33+0xb7>
    54da:	48 8b 35 ff dc 00 00 	mov    0xdcff(%rip),%rsi        # 131e0 <fwp_gc+0x1078>
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
    5519:	48 8b 15 a0 dc 00 00 	mov    0xdca0(%rip),%rdx        # 131c0 <fwp_gc+0x1058>
    5520:	48 89 c1             	mov    %rax,%rcx
    5523:	48 2b 0d 6e dc 00 00 	sub    0xdc6e(%rip),%rcx        # 13198 <fwp_gc+0x1030>
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
    555d:	e8 2e 15 00 00       	call   6a90 <fwp_rc_forget_slot>
    5562:	4c 89 f0             	mov    %r14,%rax
    5565:	eb af                	jmp    5516 <e33+0x66>
    5567:	48 39 d1             	cmp    %rdx,%rcx
    556a:	73 5f                	jae    55cb <e33+0x11b>
    556c:	48 8b 15 6d dc 00 00 	mov    0xdc6d(%rip),%rdx        # 131e0 <fwp_gc+0x1078>
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
    55d3:	e8 88 14 00 00       	call   6a60 <fwp_flush>
    55d8:	48 8b 05 01 ca 00 00 	mov    0xca01(%rip),%rax        # 11fe0 <stderr@GLIBC_2.2.5>
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
    5617:	48 8d 35 32 c6 00 00 	lea    0xc632(%rip),%rsi        # 11c50 <d0>
    561e:	e8 2d 27 00 00       	call   7d50 <fwp_show>
    5623:	48 89 c1             	mov    %rax,%rcx
    5626:	48 2b 0d 6b db 00 00 	sub    0xdb6b(%rip),%rcx        # 13198 <fwp_gc+0x1030>
    562d:	48 8b 15 8c db 00 00 	mov    0xdb8c(%rip),%rdx        # 131c0 <fwp_gc+0x1058>
    5634:	48 c1 e2 10          	shl    $0x10,%rdx
    5638:	48 39 d1             	cmp    %rdx,%rcx
    563b:	0f 83 8d 00 00 00    	jae    56ce <e37+0xbe>
    5641:	48 8b 35 98 db 00 00 	mov    0xdb98(%rip),%rsi        # 131e0 <fwp_gc+0x1078>
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
    5680:	48 8b 15 39 db 00 00 	mov    0xdb39(%rip),%rdx        # 131c0 <fwp_gc+0x1058>
    5687:	48 89 c1             	mov    %rax,%rcx
    568a:	48 2b 0d 07 db 00 00 	sub    0xdb07(%rip),%rcx        # 13198 <fwp_gc+0x1030>
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
    56c4:	e8 c7 13 00 00       	call   6a90 <fwp_rc_forget_slot>
    56c9:	4c 89 f0             	mov    %r14,%rax
    56cc:	eb af                	jmp    567d <e37+0x6d>
    56ce:	48 39 d1             	cmp    %rdx,%rcx
    56d1:	73 5f                	jae    5732 <e37+0x122>
    56d3:	48 8b 15 06 db 00 00 	mov    0xdb06(%rip),%rdx        # 131e0 <fwp_gc+0x1078>
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
    573a:	e8 21 13 00 00       	call   6a60 <fwp_flush>
    573f:	48 8b 05 9a c8 00 00 	mov    0xc89a(%rip),%rax        # 11fe0 <stderr@GLIBC_2.2.5>
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
    5781:	48 2b 0d 10 da 00 00 	sub    0xda10(%rip),%rcx        # 13198 <fwp_gc+0x1030>
    5788:	48 8b 15 31 da 00 00 	mov    0xda31(%rip),%rdx        # 131c0 <fwp_gc+0x1058>
    578f:	48 c1 e2 10          	shl    $0x10,%rdx
    5793:	48 39 d1             	cmp    %rdx,%rcx
    5796:	73 5f                	jae    57f7 <e45+0x87>
    5798:	48 8b 15 41 da 00 00 	mov    0xda41(%rip),%rdx        # 131e0 <fwp_gc+0x1078>
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
    57f9:	e8 62 12 00 00       	call   6a60 <fwp_flush>
    57fe:	48 8b 05 db c7 00 00 	mov    0xc7db(%rip),%rax        # 11fe0 <stderr@GLIBC_2.2.5>
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
    5841:	48 2b 0d 50 d9 00 00 	sub    0xd950(%rip),%rcx        # 13198 <fwp_gc+0x1030>
    5848:	48 8b 15 71 d9 00 00 	mov    0xd971(%rip),%rdx        # 131c0 <fwp_gc+0x1058>
    584f:	48 c1 e2 10          	shl    $0x10,%rdx
    5853:	48 39 d1             	cmp    %rdx,%rcx
    5856:	73 5f                	jae    58b7 <e46+0x87>
    5858:	48 8b 15 81 d9 00 00 	mov    0xd981(%rip),%rdx        # 131e0 <fwp_gc+0x1078>
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
    58b9:	e8 a2 11 00 00       	call   6a60 <fwp_flush>
    58be:	48 8b 05 1b c7 00 00 	mov    0xc71b(%rip),%rax        # 11fe0 <stderr@GLIBC_2.2.5>
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
    58f8:	48 2b 05 99 d8 00 00 	sub    0xd899(%rip),%rax        # 13198 <fwp_gc+0x1030>
    58ff:	48 8b 0d ba d8 00 00 	mov    0xd8ba(%rip),%rcx        # 131c0 <fwp_gc+0x1058>
    5906:	48 c1 e1 10          	shl    $0x10,%rcx
    590a:	48 39 c8             	cmp    %rcx,%rax
    590d:	73 64                	jae    5973 <e47+0x83>
    590f:	48 8b 0d ca d8 00 00 	mov    0xd8ca(%rip),%rcx        # 131e0 <fwp_gc+0x1078>
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
    5976:	48 8d 15 d3 c2 00 00 	lea    0xc2d3(%rip),%rdx        # 11c50 <d0>
    597d:	e8 7e 49 00 00       	call   a300 <fwp_p_array_get_typed>
    5982:	48 89 c1             	mov    %rax,%rcx
    5985:	48 2b 0d 0c d8 00 00 	sub    0xd80c(%rip),%rcx        # 13198 <fwp_gc+0x1030>
    598c:	48 8b 15 2d d8 00 00 	mov    0xd82d(%rip),%rdx        # 131c0 <fwp_gc+0x1058>
    5993:	48 c1 e2 10          	shl    $0x10,%rdx
    5997:	48 39 d1             	cmp    %rdx,%rcx
    599a:	73 5f                	jae    59fb <e47+0x10b>
    599c:	48 8b 15 3d d8 00 00 	mov    0xd83d(%rip),%rdx        # 131e0 <fwp_gc+0x1078>
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
    59fd:	e8 5e 10 00 00       	call   6a60 <fwp_flush>
    5a02:	48 8b 05 d7 c5 00 00 	mov    0xc5d7(%rip),%rax        # 11fe0 <stderr@GLIBC_2.2.5>
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
    5a41:	48 2b 0d 50 d7 00 00 	sub    0xd750(%rip),%rcx        # 13198 <fwp_gc+0x1030>
    5a48:	48 8b 15 71 d7 00 00 	mov    0xd771(%rip),%rdx        # 131c0 <fwp_gc+0x1058>
    5a4f:	48 c1 e2 10          	shl    $0x10,%rdx
    5a53:	48 39 d1             	cmp    %rdx,%rcx
    5a56:	73 5f                	jae    5ab7 <e48+0x87>
    5a58:	48 8b 15 81 d7 00 00 	mov    0xd781(%rip),%rdx        # 131e0 <fwp_gc+0x1078>
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
    5add:	e8 7e 0f 00 00       	call   6a60 <fwp_flush>
    5ae2:	48 8b 05 f7 c4 00 00 	mov    0xc4f7(%rip),%rax        # 11fe0 <stderr@GLIBC_2.2.5>
    5ae9:	48 8b 38             	mov    (%rax),%rdi
    5aec:	48 8d 35 da 99 00 00 	lea    0x99da(%rip),%rsi        # f4cd <fwp_segv.msg+0x24d>
    5af3:	48 89 da             	mov    %rbx,%rdx
    5af6:	eb 1d                	jmp    5b15 <e48+0xe5>
    5af8:	e8 63 0f 00 00       	call   6a60 <fwp_flush>
    5afd:	48 8b 05 dc c4 00 00 	mov    0xc4dc(%rip),%rax        # 11fe0 <stderr@GLIBC_2.2.5>
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
    5b37:	48 2b 05 5a d6 00 00 	sub    0xd65a(%rip),%rax        # 13198 <fwp_gc+0x1030>
    5b3e:	48 8b 0d 7b d6 00 00 	mov    0xd67b(%rip),%rcx        # 131c0 <fwp_gc+0x1058>
    5b45:	48 c1 e1 10          	shl    $0x10,%rcx
    5b49:	48 39 c8             	cmp    %rcx,%rax
    5b4c:	73 63                	jae    5bb1 <e49+0x81>
    5b4e:	48 8b 0d 8b d6 00 00 	mov    0xd68b(%rip),%rcx        # 131e0 <fwp_gc+0x1078>
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
    5bb1:	e8 ba 4a 00 00       	call   a670 <f49>
    5bb6:	48 89 c1             	mov    %rax,%rcx
    5bb9:	48 2b 0d d8 d5 00 00 	sub    0xd5d8(%rip),%rcx        # 13198 <fwp_gc+0x1030>
    5bc0:	48 8b 15 f9 d5 00 00 	mov    0xd5f9(%rip),%rdx        # 131c0 <fwp_gc+0x1058>
    5bc7:	48 c1 e2 10          	shl    $0x10,%rdx
    5bcb:	48 39 d1             	cmp    %rdx,%rcx
    5bce:	73 5f                	jae    5c2f <e49+0xff>
    5bd0:	48 8b 15 09 d6 00 00 	mov    0xd609(%rip),%rdx        # 131e0 <fwp_gc+0x1078>
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
    5c31:	e8 2a 0e 00 00       	call   6a60 <fwp_flush>
    5c36:	48 8b 05 a3 c3 00 00 	mov    0xc3a3(%rip),%rax        # 11fe0 <stderr@GLIBC_2.2.5>
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
    5c67:	48 8b 0d 2a d5 00 00 	mov    0xd52a(%rip),%rcx        # 13198 <fwp_gc+0x1030>
    5c6e:	48 89 fe             	mov    %rdi,%rsi
    5c71:	48 29 ce             	sub    %rcx,%rsi
    5c74:	48 8b 15 45 d5 00 00 	mov    0xd545(%rip),%rdx        # 131c0 <fwp_gc+0x1058>
    5c7b:	48 c1 e2 10          	shl    $0x10,%rdx
    5c7f:	48 39 d6             	cmp    %rdx,%rsi
    5c82:	73 68                	jae    5cec <e50+0x8c>
    5c84:	4c 8b 05 55 d5 00 00 	mov    0xd555(%rip),%r8        # 131e0 <fwp_gc+0x1078>
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
    5cbd:	e9 1d 01 00 00       	jmp    5ddf <e50+0x17f>
    5cc2:	41 80 fa 01          	cmp    $0x1,%r10b
    5cc6:	75 24                	jne    5cec <e50+0x8c>
    5cc8:	4f 8d 14 08          	lea    (%r8,%r9,1),%r10
    5ccc:	47 8b 44 08 20       	mov    0x20(%r8,%r9,1),%r8d
    5cd1:	49 0f af f0          	imul   %r8,%rsi
    5cd5:	48 c1 ee 20          	shr    $0x20,%rsi
    5cd9:	4c 01 d6             	add    %r10,%rsi
    5cdc:	48 81 c6 28 02 00 00 	add    $0x228,%rsi
    5ce3:	80 3e 00             	cmpb   $0x0,(%rsi)
    5ce6:	0f 85 f3 00 00 00    	jne    5ddf <e50+0x17f>
    5cec:	48 8b 70 08          	mov    0x8(%rax),%rsi
    5cf0:	48 89 f0             	mov    %rsi,%rax
    5cf3:	48 29 c8             	sub    %rcx,%rax
    5cf6:	48 39 d0             	cmp    %rdx,%rax
    5cf9:	73 64                	jae    5d5f <e50+0xff>
    5cfb:	48 8b 0d de d4 00 00 	mov    0xd4de(%rip),%rcx        # 131e0 <fwp_gc+0x1078>
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
    5d32:	e9 a8 00 00 00       	jmp    5ddf <e50+0x17f>
    5d37:	41 80 f8 01          	cmp    $0x1,%r8b
    5d3b:	75 22                	jne    5d5f <e50+0xff>
    5d3d:	4c 8d 04 11          	lea    (%rcx,%rdx,1),%r8
    5d41:	8b 4c 11 20          	mov    0x20(%rcx,%rdx,1),%ecx
    5d45:	48 0f af c1          	imul   %rcx,%rax
    5d49:	48 c1 e8 20          	shr    $0x20,%rax
    5d4d:	4c 01 c0             	add    %r8,%rax
    5d50:	48 05 28 02 00 00    	add    $0x228,%rax
    5d56:	80 38 00             	cmpb   $0x0,(%rax)
    5d59:	0f 85 80 00 00 00    	jne    5ddf <e50+0x17f>
    5d5f:	e8 6c 55 00 00       	call   b2d0 <fwp_p_loop_own>
    5d64:	48 89 c1             	mov    %rax,%rcx
    5d67:	48 2b 0d 2a d4 00 00 	sub    0xd42a(%rip),%rcx        # 13198 <fwp_gc+0x1030>
    5d6e:	48 8b 15 4b d4 00 00 	mov    0xd44b(%rip),%rdx        # 131c0 <fwp_gc+0x1058>
    5d75:	48 c1 e2 10          	shl    $0x10,%rdx
    5d79:	48 39 d1             	cmp    %rdx,%rcx
    5d7c:	73 5f                	jae    5ddd <e50+0x17d>
    5d7e:	48 8b 15 5b d4 00 00 	mov    0xd45b(%rip),%rdx        # 131e0 <fwp_gc+0x1078>
    5d85:	48 89 ce             	mov    %rcx,%rsi
    5d88:	48 c1 ee 10          	shr    $0x10,%rsi
    5d8c:	48 69 f6 28 12 00 00 	imul   $0x1228,%rsi,%rsi
    5d93:	0f b6 3c 32          	movzbl (%rdx,%rsi,1),%edi
    5d97:	48 81 e1 ff ff 00 00 	and    $0xffff,%rcx
    5d9e:	75 18                	jne    5db8 <e50+0x158>
    5da0:	40 80 ff 02          	cmp    $0x2,%dil
    5da4:	75 12                	jne    5db8 <e50+0x158>
    5da6:	48 8d 0c 32          	lea    (%rdx,%rsi,1),%rcx
    5daa:	48 81 c1 28 02 00 00 	add    $0x228,%rcx
    5db1:	80 39 00             	cmpb   $0x0,(%rcx)
    5db4:	74 27                	je     5ddd <e50+0x17d>
    5db6:	eb 27                	jmp    5ddf <e50+0x17f>
    5db8:	40 80 ff 01          	cmp    $0x1,%dil
    5dbc:	75 1f                	jne    5ddd <e50+0x17d>
    5dbe:	48 8d 3c 32          	lea    (%rdx,%rsi,1),%rdi
    5dc2:	8b 54 32 20          	mov    0x20(%rdx,%rsi,1),%edx
    5dc6:	48 0f af ca          	imul   %rdx,%rcx
    5dca:	48 c1 e9 20          	shr    $0x20,%rcx
    5dce:	48 01 f9             	add    %rdi,%rcx
    5dd1:	48 81 c1 28 02 00 00 	add    $0x228,%rcx
    5dd8:	80 39 00             	cmpb   $0x0,(%rcx)
    5ddb:	75 02                	jne    5ddf <e50+0x17f>
    5ddd:	59                   	pop    %rcx
    5dde:	c3                   	ret
    5ddf:	e8 7c 0c 00 00       	call   6a60 <fwp_flush>
    5de4:	48 8b 05 f5 c1 00 00 	mov    0xc1f5(%rip),%rax        # 11fe0 <stderr@GLIBC_2.2.5>
    5deb:	48 8b 38             	mov    (%rax),%rdi
    5dee:	48 8d 35 d8 96 00 00 	lea    0x96d8(%rip),%rsi        # f4cd <fwp_segv.msg+0x24d>
    5df5:	48 8d 15 a4 96 00 00 	lea    0x96a4(%rip),%rdx        # f4a0 <fwp_segv.msg+0x220>
    5dfc:	31 c0                	xor    %eax,%eax
    5dfe:	e8 9d c3 ff ff       	call   21a0 <fprintf@plt>
    5e03:	bf 65 00 00 00       	mov    $0x65,%edi
    5e08:	e8 63 c4 ff ff       	call   2270 <exit@plt>
    5e0d:	0f 1f 00             	nopl   (%rax)

0000000000005e10 <e51>:
    5e10:	50                   	push   %rax
    5e11:	48 8b 77 08          	mov    0x8(%rdi),%rsi
    5e15:	48 89 f0             	mov    %rsi,%rax
    5e18:	48 2b 05 79 d3 00 00 	sub    0xd379(%rip),%rax        # 13198 <fwp_gc+0x1030>
    5e1f:	48 8b 0d 9a d3 00 00 	mov    0xd39a(%rip),%rcx        # 131c0 <fwp_gc+0x1058>
    5e26:	48 c1 e1 10          	shl    $0x10,%rcx
    5e2a:	48 39 c8             	cmp    %rcx,%rax
    5e2d:	73 64                	jae    5e93 <e51+0x83>
    5e2f:	48 8b 0d aa d3 00 00 	mov    0xd3aa(%rip),%rcx        # 131e0 <fwp_gc+0x1078>
    5e36:	48 89 c2             	mov    %rax,%rdx
    5e39:	48 c1 ea 10          	shr    $0x10,%rdx
    5e3d:	48 69 d2 28 12 00 00 	imul   $0x1228,%rdx,%rdx
    5e44:	44 0f b6 04 11       	movzbl (%rcx,%rdx,1),%r8d
    5e49:	48 25 ff ff 00 00    	and    $0xffff,%rax
    5e4f:	75 1a                	jne    5e6b <e51+0x5b>
    5e51:	41 80 f8 02          	cmp    $0x2,%r8b
    5e55:	75 14                	jne    5e6b <e51+0x5b>
    5e57:	48 8d 04 11          	lea    (%rcx,%rdx,1),%rax
    5e5b:	48 05 28 02 00 00    	add    $0x228,%rax
    5e61:	80 38 00             	cmpb   $0x0,(%rax)
    5e64:	74 2d                	je     5e93 <e51+0x83>
    5e66:	e9 b2 00 00 00       	jmp    5f1d <e51+0x10d>
    5e6b:	41 80 f8 01          	cmp    $0x1,%r8b
    5e6f:	75 22                	jne    5e93 <e51+0x83>
    5e71:	4c 8d 04 11          	lea    (%rcx,%rdx,1),%r8
    5e75:	8b 4c 11 20          	mov    0x20(%rcx,%rdx,1),%ecx
    5e79:	48 0f af c1          	imul   %rcx,%rax
    5e7d:	48 c1 e8 20          	shr    $0x20,%rax
    5e81:	4c 01 c0             	add    %r8,%rax
    5e84:	48 05 28 02 00 00    	add    $0x228,%rax
    5e8a:	80 38 00             	cmpb   $0x0,(%rax)
    5e8d:	0f 85 8a 00 00 00    	jne    5f1d <e51+0x10d>
    5e93:	48 8b 3f             	mov    (%rdi),%rdi
    5e96:	48 8d 15 73 be 00 00 	lea    0xbe73(%rip),%rdx        # 11d10 <d2>
    5e9d:	e8 5e 44 00 00       	call   a300 <fwp_p_array_get_typed>
    5ea2:	48 89 c1             	mov    %rax,%rcx
    5ea5:	48 2b 0d ec d2 00 00 	sub    0xd2ec(%rip),%rcx        # 13198 <fwp_gc+0x1030>
    5eac:	48 8b 15 0d d3 00 00 	mov    0xd30d(%rip),%rdx        # 131c0 <fwp_gc+0x1058>
    5eb3:	48 c1 e2 10          	shl    $0x10,%rdx
    5eb7:	48 39 d1             	cmp    %rdx,%rcx
    5eba:	73 5f                	jae    5f1b <e51+0x10b>
    5ebc:	48 8b 15 1d d3 00 00 	mov    0xd31d(%rip),%rdx        # 131e0 <fwp_gc+0x1078>
    5ec3:	48 89 ce             	mov    %rcx,%rsi
    5ec6:	48 c1 ee 10          	shr    $0x10,%rsi
    5eca:	48 69 f6 28 12 00 00 	imul   $0x1228,%rsi,%rsi
    5ed1:	0f b6 3c 32          	movzbl (%rdx,%rsi,1),%edi
    5ed5:	48 81 e1 ff ff 00 00 	and    $0xffff,%rcx
    5edc:	75 18                	jne    5ef6 <e51+0xe6>
    5ede:	40 80 ff 02          	cmp    $0x2,%dil
    5ee2:	75 12                	jne    5ef6 <e51+0xe6>
    5ee4:	48 8d 0c 32          	lea    (%rdx,%rsi,1),%rcx
    5ee8:	48 81 c1 28 02 00 00 	add    $0x228,%rcx
    5eef:	80 39 00             	cmpb   $0x0,(%rcx)
    5ef2:	74 27                	je     5f1b <e51+0x10b>
    5ef4:	eb 27                	jmp    5f1d <e51+0x10d>
    5ef6:	40 80 ff 01          	cmp    $0x1,%dil
    5efa:	75 1f                	jne    5f1b <e51+0x10b>
    5efc:	48 8d 3c 32          	lea    (%rdx,%rsi,1),%rdi
    5f00:	8b 54 32 20          	mov    0x20(%rdx,%rsi,1),%edx
    5f04:	48 0f af ca          	imul   %rdx,%rcx
    5f08:	48 c1 e9 20          	shr    $0x20,%rcx
    5f0c:	48 01 f9             	add    %rdi,%rcx
    5f0f:	48 81 c1 28 02 00 00 	add    $0x228,%rcx
    5f16:	80 39 00             	cmpb   $0x0,(%rcx)
    5f19:	75 02                	jne    5f1d <e51+0x10d>
    5f1b:	59                   	pop    %rcx
    5f1c:	c3                   	ret
    5f1d:	e8 3e 0b 00 00       	call   6a60 <fwp_flush>
    5f22:	48 8b 05 b7 c0 00 00 	mov    0xc0b7(%rip),%rax        # 11fe0 <stderr@GLIBC_2.2.5>
    5f29:	48 8b 38             	mov    (%rax),%rdi
    5f2c:	48 8d 35 9a 95 00 00 	lea    0x959a(%rip),%rsi        # f4cd <fwp_segv.msg+0x24d>
    5f33:	48 8d 15 66 95 00 00 	lea    0x9566(%rip),%rdx        # f4a0 <fwp_segv.msg+0x220>
    5f3a:	31 c0                	xor    %eax,%eax
    5f3c:	e8 5f c2 ff ff       	call   21a0 <fprintf@plt>
    5f41:	bf 65 00 00 00       	mov    $0x65,%edi
    5f46:	e8 25 c3 ff ff       	call   2270 <exit@plt>
    5f4b:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)

0000000000005f50 <e52>:
    5f50:	50                   	push   %rax
    5f51:	48 8b 3f             	mov    (%rdi),%rdi
    5f54:	48 89 f8             	mov    %rdi,%rax
    5f57:	48 2b 05 3a d2 00 00 	sub    0xd23a(%rip),%rax        # 13198 <fwp_gc+0x1030>
    5f5e:	48 8b 0d 5b d2 00 00 	mov    0xd25b(%rip),%rcx        # 131c0 <fwp_gc+0x1058>
    5f65:	48 c1 e1 10          	shl    $0x10,%rcx
    5f69:	48 39 c8             	cmp    %rcx,%rax
    5f6c:	73 63                	jae    5fd1 <e52+0x81>
    5f6e:	48 8b 0d 6b d2 00 00 	mov    0xd26b(%rip),%rcx        # 131e0 <fwp_gc+0x1078>
    5f75:	48 89 c2             	mov    %rax,%rdx
    5f78:	48 c1 ea 10          	shr    $0x10,%rdx
    5f7c:	48 69 d2 28 12 00 00 	imul   $0x1228,%rdx,%rdx
    5f83:	0f b6 34 11          	movzbl (%rcx,%rdx,1),%esi
    5f87:	48 25 ff ff 00 00    	and    $0xffff,%rax
    5f8d:	75 1a                	jne    5fa9 <e52+0x59>
    5f8f:	40 80 fe 02          	cmp    $0x2,%sil
    5f93:	75 14                	jne    5fa9 <e52+0x59>
    5f95:	48 8d 04 11          	lea    (%rcx,%rdx,1),%rax
    5f99:	48 05 28 02 00 00    	add    $0x228,%rax
    5f9f:	80 38 00             	cmpb   $0x0,(%rax)
    5fa2:	74 2d                	je     5fd1 <e52+0x81>
    5fa4:	e9 a8 00 00 00       	jmp    6051 <e52+0x101>
    5fa9:	40 80 fe 01          	cmp    $0x1,%sil
    5fad:	75 22                	jne    5fd1 <e52+0x81>
    5faf:	48 8d 34 11          	lea    (%rcx,%rdx,1),%rsi
    5fb3:	8b 4c 11 20          	mov    0x20(%rcx,%rdx,1),%ecx
    5fb7:	48 0f af c1          	imul   %rcx,%rax
    5fbb:	48 c1 e8 20          	shr    $0x20,%rax
    5fbf:	48 01 f0             	add    %rsi,%rax
    5fc2:	48 05 28 02 00 00    	add    $0x228,%rax
    5fc8:	80 38 00             	cmpb   $0x0,(%rax)
    5fcb:	0f 85 80 00 00 00    	jne    6051 <e52+0x101>
    5fd1:	e8 ca 69 00 00       	call   c9a0 <f52>
    5fd6:	48 89 c1             	mov    %rax,%rcx
    5fd9:	48 2b 0d b8 d1 00 00 	sub    0xd1b8(%rip),%rcx        # 13198 <fwp_gc+0x1030>
    5fe0:	48 8b 15 d9 d1 00 00 	mov    0xd1d9(%rip),%rdx        # 131c0 <fwp_gc+0x1058>
    5fe7:	48 c1 e2 10          	shl    $0x10,%rdx
    5feb:	48 39 d1             	cmp    %rdx,%rcx
    5fee:	73 5f                	jae    604f <e52+0xff>
    5ff0:	48 8b 15 e9 d1 00 00 	mov    0xd1e9(%rip),%rdx        # 131e0 <fwp_gc+0x1078>
    5ff7:	48 89 ce             	mov    %rcx,%rsi
    5ffa:	48 c1 ee 10          	shr    $0x10,%rsi
    5ffe:	48 69 f6 28 12 00 00 	imul   $0x1228,%rsi,%rsi
    6005:	0f b6 3c 32          	movzbl (%rdx,%rsi,1),%edi
    6009:	48 81 e1 ff ff 00 00 	and    $0xffff,%rcx
    6010:	75 18                	jne    602a <e52+0xda>
    6012:	40 80 ff 02          	cmp    $0x2,%dil
    6016:	75 12                	jne    602a <e52+0xda>
    6018:	48 8d 0c 32          	lea    (%rdx,%rsi,1),%rcx
    601c:	48 81 c1 28 02 00 00 	add    $0x228,%rcx
    6023:	80 39 00             	cmpb   $0x0,(%rcx)
    6026:	74 27                	je     604f <e52+0xff>
    6028:	eb 27                	jmp    6051 <e52+0x101>
    602a:	40 80 ff 01          	cmp    $0x1,%dil
    602e:	75 1f                	jne    604f <e52+0xff>
    6030:	48 8d 3c 32          	lea    (%rdx,%rsi,1),%rdi
    6034:	8b 54 32 20          	mov    0x20(%rdx,%rsi,1),%edx
    6038:	48 0f af ca          	imul   %rdx,%rcx
    603c:	48 c1 e9 20          	shr    $0x20,%rcx
    6040:	48 01 f9             	add    %rdi,%rcx
    6043:	48 81 c1 28 02 00 00 	add    $0x228,%rcx
    604a:	80 39 00             	cmpb   $0x0,(%rcx)
    604d:	75 02                	jne    6051 <e52+0x101>
    604f:	59                   	pop    %rcx
    6050:	c3                   	ret
    6051:	e8 0a 0a 00 00       	call   6a60 <fwp_flush>
    6056:	48 8b 05 83 bf 00 00 	mov    0xbf83(%rip),%rax        # 11fe0 <stderr@GLIBC_2.2.5>
    605d:	48 8b 38             	mov    (%rax),%rdi
    6060:	48 8d 35 66 94 00 00 	lea    0x9466(%rip),%rsi        # f4cd <fwp_segv.msg+0x24d>
    6067:	48 8d 15 32 94 00 00 	lea    0x9432(%rip),%rdx        # f4a0 <fwp_segv.msg+0x220>
    606e:	31 c0                	xor    %eax,%eax
    6070:	e8 2b c1 ff ff       	call   21a0 <fprintf@plt>
    6075:	bf 65 00 00 00       	mov    $0x65,%edi
    607a:	e8 f1 c1 ff ff       	call   2270 <exit@plt>
    607f:	90                   	nop

0000000000006080 <e53>:
    6080:	50                   	push   %rax
    6081:	48 89 f8             	mov    %rdi,%rax
    6084:	48 8b 3f             	mov    (%rdi),%rdi
    6087:	48 8b 0d 0a d1 00 00 	mov    0xd10a(%rip),%rcx        # 13198 <fwp_gc+0x1030>
    608e:	48 89 fe             	mov    %rdi,%rsi
    6091:	48 29 ce             	sub    %rcx,%rsi
    6094:	48 8b 15 25 d1 00 00 	mov    0xd125(%rip),%rdx        # 131c0 <fwp_gc+0x1058>
    609b:	48 c1 e2 10          	shl    $0x10,%rdx
    609f:	48 39 d6             	cmp    %rdx,%rsi
    60a2:	73 68                	jae    610c <e53+0x8c>
    60a4:	4c 8b 05 35 d1 00 00 	mov    0xd135(%rip),%r8        # 131e0 <fwp_gc+0x1078>
    60ab:	49 89 f1             	mov    %rsi,%r9
    60ae:	49 c1 e9 10          	shr    $0x10,%r9
    60b2:	4d 69 c9 28 12 00 00 	imul   $0x1228,%r9,%r9
    60b9:	47 0f b6 14 08       	movzbl (%r8,%r9,1),%r10d
    60be:	48 81 e6 ff ff 00 00 	and    $0xffff,%rsi
    60c5:	75 1b                	jne    60e2 <e53+0x62>
    60c7:	41 80 fa 02          	cmp    $0x2,%r10b
    60cb:	75 15                	jne    60e2 <e53+0x62>
    60cd:	4b 8d 34 08          	lea    (%r8,%r9,1),%rsi
    60d1:	48 81 c6 28 02 00 00 	add    $0x228,%rsi
    60d8:	80 3e 00             	cmpb   $0x0,(%rsi)
    60db:	74 2f                	je     610c <e53+0x8c>
    60dd:	e9 1d 01 00 00       	jmp    61ff <e53+0x17f>
    60e2:	41 80 fa 01          	cmp    $0x1,%r10b
    60e6:	75 24                	jne    610c <e53+0x8c>
    60e8:	4f 8d 14 08          	lea    (%r8,%r9,1),%r10
    60ec:	47 8b 44 08 20       	mov    0x20(%r8,%r9,1),%r8d
    60f1:	49 0f af f0          	imul   %r8,%rsi
    60f5:	48 c1 ee 20          	shr    $0x20,%rsi
    60f9:	4c 01 d6             	add    %r10,%rsi
    60fc:	48 81 c6 28 02 00 00 	add    $0x228,%rsi
    6103:	80 3e 00             	cmpb   $0x0,(%rsi)
    6106:	0f 85 f3 00 00 00    	jne    61ff <e53+0x17f>
    610c:	48 8b 70 08          	mov    0x8(%rax),%rsi
    6110:	48 89 f0             	mov    %rsi,%rax
    6113:	48 29 c8             	sub    %rcx,%rax
    6116:	48 39 d0             	cmp    %rdx,%rax
    6119:	73 64                	jae    617f <e53+0xff>
    611b:	48 8b 0d be d0 00 00 	mov    0xd0be(%rip),%rcx        # 131e0 <fwp_gc+0x1078>
    6122:	48 89 c2             	mov    %rax,%rdx
    6125:	48 c1 ea 10          	shr    $0x10,%rdx
    6129:	48 69 d2 28 12 00 00 	imul   $0x1228,%rdx,%rdx
    6130:	44 0f b6 04 11       	movzbl (%rcx,%rdx,1),%r8d
    6135:	48 25 ff ff 00 00    	and    $0xffff,%rax
    613b:	75 1a                	jne    6157 <e53+0xd7>
    613d:	41 80 f8 02          	cmp    $0x2,%r8b
    6141:	75 14                	jne    6157 <e53+0xd7>
    6143:	48 8d 04 11          	lea    (%rcx,%rdx,1),%rax
    6147:	48 05 28 02 00 00    	add    $0x228,%rax
    614d:	80 38 00             	cmpb   $0x0,(%rax)
    6150:	74 2d                	je     617f <e53+0xff>
    6152:	e9 a8 00 00 00       	jmp    61ff <e53+0x17f>
    6157:	41 80 f8 01          	cmp    $0x1,%r8b
    615b:	75 22                	jne    617f <e53+0xff>
    615d:	4c 8d 04 11          	lea    (%rcx,%rdx,1),%r8
    6161:	8b 4c 11 20          	mov    0x20(%rcx,%rdx,1),%ecx
    6165:	48 0f af c1          	imul   %rcx,%rax
    6169:	48 c1 e8 20          	shr    $0x20,%rax
    616d:	4c 01 c0             	add    %r8,%rax
    6170:	48 05 28 02 00 00    	add    $0x228,%rax
    6176:	80 38 00             	cmpb   $0x0,(%rax)
    6179:	0f 85 80 00 00 00    	jne    61ff <e53+0x17f>
    617f:	e8 4c 51 00 00       	call   b2d0 <fwp_p_loop_own>
    6184:	48 89 c1             	mov    %rax,%rcx
    6187:	48 2b 0d 0a d0 00 00 	sub    0xd00a(%rip),%rcx        # 13198 <fwp_gc+0x1030>
    618e:	48 8b 15 2b d0 00 00 	mov    0xd02b(%rip),%rdx        # 131c0 <fwp_gc+0x1058>
    6195:	48 c1 e2 10          	shl    $0x10,%rdx
    6199:	48 39 d1             	cmp    %rdx,%rcx
    619c:	73 5f                	jae    61fd <e53+0x17d>
    619e:	48 8b 15 3b d0 00 00 	mov    0xd03b(%rip),%rdx        # 131e0 <fwp_gc+0x1078>
    61a5:	48 89 ce             	mov    %rcx,%rsi
    61a8:	48 c1 ee 10          	shr    $0x10,%rsi
    61ac:	48 69 f6 28 12 00 00 	imul   $0x1228,%rsi,%rsi
    61b3:	0f b6 3c 32          	movzbl (%rdx,%rsi,1),%edi
    61b7:	48 81 e1 ff ff 00 00 	and    $0xffff,%rcx
    61be:	75 18                	jne    61d8 <e53+0x158>
    61c0:	40 80 ff 02          	cmp    $0x2,%dil
    61c4:	75 12                	jne    61d8 <e53+0x158>
    61c6:	48 8d 0c 32          	lea    (%rdx,%rsi,1),%rcx
    61ca:	48 81 c1 28 02 00 00 	add    $0x228,%rcx
    61d1:	80 39 00             	cmpb   $0x0,(%rcx)
    61d4:	74 27                	je     61fd <e53+0x17d>
    61d6:	eb 27                	jmp    61ff <e53+0x17f>
    61d8:	40 80 ff 01          	cmp    $0x1,%dil
    61dc:	75 1f                	jne    61fd <e53+0x17d>
    61de:	48 8d 3c 32          	lea    (%rdx,%rsi,1),%rdi
    61e2:	8b 54 32 20          	mov    0x20(%rdx,%rsi,1),%edx
    61e6:	48 0f af ca          	imul   %rdx,%rcx
    61ea:	48 c1 e9 20          	shr    $0x20,%rcx
    61ee:	48 01 f9             	add    %rdi,%rcx
    61f1:	48 81 c1 28 02 00 00 	add    $0x228,%rcx
    61f8:	80 39 00             	cmpb   $0x0,(%rcx)
    61fb:	75 02                	jne    61ff <e53+0x17f>
    61fd:	59                   	pop    %rcx
    61fe:	c3                   	ret
    61ff:	e8 5c 08 00 00       	call   6a60 <fwp_flush>
    6204:	48 8b 05 d5 bd 00 00 	mov    0xbdd5(%rip),%rax        # 11fe0 <stderr@GLIBC_2.2.5>
    620b:	48 8b 38             	mov    (%rax),%rdi
    620e:	48 8d 35 b8 92 00 00 	lea    0x92b8(%rip),%rsi        # f4cd <fwp_segv.msg+0x24d>
    6215:	48 8d 15 84 92 00 00 	lea    0x9284(%rip),%rdx        # f4a0 <fwp_segv.msg+0x220>
    621c:	31 c0                	xor    %eax,%eax
    621e:	e8 7d bf ff ff       	call   21a0 <fprintf@plt>
    6223:	bf 65 00 00 00       	mov    $0x65,%edi
    6228:	e8 43 c0 ff ff       	call   2270 <exit@plt>
    622d:	0f 1f 00             	nopl   (%rax)

0000000000006230 <e54>:
    6230:	50                   	push   %rax
    6231:	48 8b 77 08          	mov    0x8(%rdi),%rsi
    6235:	48 89 f0             	mov    %rsi,%rax
    6238:	48 2b 05 59 cf 00 00 	sub    0xcf59(%rip),%rax        # 13198 <fwp_gc+0x1030>
    623f:	48 8b 0d 7a cf 00 00 	mov    0xcf7a(%rip),%rcx        # 131c0 <fwp_gc+0x1058>
    6246:	48 c1 e1 10          	shl    $0x10,%rcx
    624a:	48 39 c8             	cmp    %rcx,%rax
    624d:	73 64                	jae    62b3 <e54+0x83>
    624f:	48 8b 0d 8a cf 00 00 	mov    0xcf8a(%rip),%rcx        # 131e0 <fwp_gc+0x1078>
    6256:	48 89 c2             	mov    %rax,%rdx
    6259:	48 c1 ea 10          	shr    $0x10,%rdx
    625d:	48 69 d2 28 12 00 00 	imul   $0x1228,%rdx,%rdx
    6264:	44 0f b6 04 11       	movzbl (%rcx,%rdx,1),%r8d
    6269:	48 25 ff ff 00 00    	and    $0xffff,%rax
    626f:	75 1a                	jne    628b <e54+0x5b>
    6271:	41 80 f8 02          	cmp    $0x2,%r8b
    6275:	75 14                	jne    628b <e54+0x5b>
    6277:	48 8d 04 11          	lea    (%rcx,%rdx,1),%rax
    627b:	48 05 28 02 00 00    	add    $0x228,%rax
    6281:	80 38 00             	cmpb   $0x0,(%rax)
    6284:	74 2d                	je     62b3 <e54+0x83>
    6286:	e9 b2 00 00 00       	jmp    633d <e54+0x10d>
    628b:	41 80 f8 01          	cmp    $0x1,%r8b
    628f:	75 22                	jne    62b3 <e54+0x83>
    6291:	4c 8d 04 11          	lea    (%rcx,%rdx,1),%r8
    6295:	8b 4c 11 20          	mov    0x20(%rcx,%rdx,1),%ecx
    6299:	48 0f af c1          	imul   %rcx,%rax
    629d:	48 c1 e8 20          	shr    $0x20,%rax
    62a1:	4c 01 c0             	add    %r8,%rax
    62a4:	48 05 28 02 00 00    	add    $0x228,%rax
    62aa:	80 38 00             	cmpb   $0x0,(%rax)
    62ad:	0f 85 8a 00 00 00    	jne    633d <e54+0x10d>
    62b3:	48 8b 3f             	mov    (%rdi),%rdi
    62b6:	48 8d 15 f3 b9 00 00 	lea    0xb9f3(%rip),%rdx        # 11cb0 <d1>
    62bd:	e8 3e 40 00 00       	call   a300 <fwp_p_array_get_typed>
    62c2:	48 89 c1             	mov    %rax,%rcx
    62c5:	48 2b 0d cc ce 00 00 	sub    0xcecc(%rip),%rcx        # 13198 <fwp_gc+0x1030>
    62cc:	48 8b 15 ed ce 00 00 	mov    0xceed(%rip),%rdx        # 131c0 <fwp_gc+0x1058>
    62d3:	48 c1 e2 10          	shl    $0x10,%rdx
    62d7:	48 39 d1             	cmp    %rdx,%rcx
    62da:	73 5f                	jae    633b <e54+0x10b>
    62dc:	48 8b 15 fd ce 00 00 	mov    0xcefd(%rip),%rdx        # 131e0 <fwp_gc+0x1078>
    62e3:	48 89 ce             	mov    %rcx,%rsi
    62e6:	48 c1 ee 10          	shr    $0x10,%rsi
    62ea:	48 69 f6 28 12 00 00 	imul   $0x1228,%rsi,%rsi
    62f1:	0f b6 3c 32          	movzbl (%rdx,%rsi,1),%edi
    62f5:	48 81 e1 ff ff 00 00 	and    $0xffff,%rcx
    62fc:	75 18                	jne    6316 <e54+0xe6>
    62fe:	40 80 ff 02          	cmp    $0x2,%dil
    6302:	75 12                	jne    6316 <e54+0xe6>
    6304:	48 8d 0c 32          	lea    (%rdx,%rsi,1),%rcx
    6308:	48 81 c1 28 02 00 00 	add    $0x228,%rcx
    630f:	80 39 00             	cmpb   $0x0,(%rcx)
    6312:	74 27                	je     633b <e54+0x10b>
    6314:	eb 27                	jmp    633d <e54+0x10d>
    6316:	40 80 ff 01          	cmp    $0x1,%dil
    631a:	75 1f                	jne    633b <e54+0x10b>
    631c:	48 8d 3c 32          	lea    (%rdx,%rsi,1),%rdi
    6320:	8b 54 32 20          	mov    0x20(%rdx,%rsi,1),%edx
    6324:	48 0f af ca          	imul   %rdx,%rcx
    6328:	48 c1 e9 20          	shr    $0x20,%rcx
    632c:	48 01 f9             	add    %rdi,%rcx
    632f:	48 81 c1 28 02 00 00 	add    $0x228,%rcx
    6336:	80 39 00             	cmpb   $0x0,(%rcx)
    6339:	75 02                	jne    633d <e54+0x10d>
    633b:	59                   	pop    %rcx
    633c:	c3                   	ret
    633d:	e8 1e 07 00 00       	call   6a60 <fwp_flush>
    6342:	48 8b 05 97 bc 00 00 	mov    0xbc97(%rip),%rax        # 11fe0 <stderr@GLIBC_2.2.5>
    6349:	48 8b 38             	mov    (%rax),%rdi
    634c:	48 8d 35 7a 91 00 00 	lea    0x917a(%rip),%rsi        # f4cd <fwp_segv.msg+0x24d>
    6353:	48 8d 15 46 91 00 00 	lea    0x9146(%rip),%rdx        # f4a0 <fwp_segv.msg+0x220>
    635a:	31 c0                	xor    %eax,%eax
    635c:	e8 3f be ff ff       	call   21a0 <fprintf@plt>
    6361:	bf 65 00 00 00       	mov    $0x65,%edi
    6366:	e8 05 bf ff ff       	call   2270 <exit@plt>
    636b:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)

0000000000006370 <e55>:
    6370:	50                   	push   %rax
    6371:	48 8b 3f             	mov    (%rdi),%rdi
    6374:	48 89 f8             	mov    %rdi,%rax
    6377:	48 2b 05 1a ce 00 00 	sub    0xce1a(%rip),%rax        # 13198 <fwp_gc+0x1030>
    637e:	48 8b 0d 3b ce 00 00 	mov    0xce3b(%rip),%rcx        # 131c0 <fwp_gc+0x1058>
    6385:	48 c1 e1 10          	shl    $0x10,%rcx
    6389:	48 39 c8             	cmp    %rcx,%rax
    638c:	73 63                	jae    63f1 <e55+0x81>
    638e:	48 8b 0d 4b ce 00 00 	mov    0xce4b(%rip),%rcx        # 131e0 <fwp_gc+0x1078>
    6395:	48 89 c2             	mov    %rax,%rdx
    6398:	48 c1 ea 10          	shr    $0x10,%rdx
    639c:	48 69 d2 28 12 00 00 	imul   $0x1228,%rdx,%rdx
    63a3:	0f b6 34 11          	movzbl (%rcx,%rdx,1),%esi
    63a7:	48 25 ff ff 00 00    	and    $0xffff,%rax
    63ad:	75 1a                	jne    63c9 <e55+0x59>
    63af:	40 80 fe 02          	cmp    $0x2,%sil
    63b3:	75 14                	jne    63c9 <e55+0x59>
    63b5:	48 8d 04 11          	lea    (%rcx,%rdx,1),%rax
    63b9:	48 05 28 02 00 00    	add    $0x228,%rax
    63bf:	80 38 00             	cmpb   $0x0,(%rax)
    63c2:	74 2d                	je     63f1 <e55+0x81>
    63c4:	e9 a8 00 00 00       	jmp    6471 <e55+0x101>
    63c9:	40 80 fe 01          	cmp    $0x1,%sil
    63cd:	75 22                	jne    63f1 <e55+0x81>
    63cf:	48 8d 34 11          	lea    (%rcx,%rdx,1),%rsi
    63d3:	8b 4c 11 20          	mov    0x20(%rcx,%rdx,1),%ecx
    63d7:	48 0f af c1          	imul   %rcx,%rax
    63db:	48 c1 e8 20          	shr    $0x20,%rax
    63df:	48 01 f0             	add    %rsi,%rax
    63e2:	48 05 28 02 00 00    	add    $0x228,%rax
    63e8:	80 38 00             	cmpb   $0x0,(%rax)
    63eb:	0f 85 80 00 00 00    	jne    6471 <e55+0x101>
    63f1:	e8 3a 6c 00 00       	call   d030 <f55>
    63f6:	48 89 c1             	mov    %rax,%rcx
    63f9:	48 2b 0d 98 cd 00 00 	sub    0xcd98(%rip),%rcx        # 13198 <fwp_gc+0x1030>
    6400:	48 8b 15 b9 cd 00 00 	mov    0xcdb9(%rip),%rdx        # 131c0 <fwp_gc+0x1058>
    6407:	48 c1 e2 10          	shl    $0x10,%rdx
    640b:	48 39 d1             	cmp    %rdx,%rcx
    640e:	73 5f                	jae    646f <e55+0xff>
    6410:	48 8b 15 c9 cd 00 00 	mov    0xcdc9(%rip),%rdx        # 131e0 <fwp_gc+0x1078>
    6417:	48 89 ce             	mov    %rcx,%rsi
    641a:	48 c1 ee 10          	shr    $0x10,%rsi
    641e:	48 69 f6 28 12 00 00 	imul   $0x1228,%rsi,%rsi
    6425:	0f b6 3c 32          	movzbl (%rdx,%rsi,1),%edi
    6429:	48 81 e1 ff ff 00 00 	and    $0xffff,%rcx
    6430:	75 18                	jne    644a <e55+0xda>
    6432:	40 80 ff 02          	cmp    $0x2,%dil
    6436:	75 12                	jne    644a <e55+0xda>
    6438:	48 8d 0c 32          	lea    (%rdx,%rsi,1),%rcx
    643c:	48 81 c1 28 02 00 00 	add    $0x228,%rcx
    6443:	80 39 00             	cmpb   $0x0,(%rcx)
    6446:	74 27                	je     646f <e55+0xff>
    6448:	eb 27                	jmp    6471 <e55+0x101>
    644a:	40 80 ff 01          	cmp    $0x1,%dil
    644e:	75 1f                	jne    646f <e55+0xff>
    6450:	48 8d 3c 32          	lea    (%rdx,%rsi,1),%rdi
    6454:	8b 54 32 20          	mov    0x20(%rdx,%rsi,1),%edx
    6458:	48 0f af ca          	imul   %rdx,%rcx
    645c:	48 c1 e9 20          	shr    $0x20,%rcx
    6460:	48 01 f9             	add    %rdi,%rcx
    6463:	48 81 c1 28 02 00 00 	add    $0x228,%rcx
    646a:	80 39 00             	cmpb   $0x0,(%rcx)
    646d:	75 02                	jne    6471 <e55+0x101>
    646f:	59                   	pop    %rcx
    6470:	c3                   	ret
    6471:	e8 ea 05 00 00       	call   6a60 <fwp_flush>
    6476:	48 8b 05 63 bb 00 00 	mov    0xbb63(%rip),%rax        # 11fe0 <stderr@GLIBC_2.2.5>
    647d:	48 8b 38             	mov    (%rax),%rdi
    6480:	48 8d 35 46 90 00 00 	lea    0x9046(%rip),%rsi        # f4cd <fwp_segv.msg+0x24d>
    6487:	48 8d 15 12 90 00 00 	lea    0x9012(%rip),%rdx        # f4a0 <fwp_segv.msg+0x220>
    648e:	31 c0                	xor    %eax,%eax
    6490:	e8 0b bd ff ff       	call   21a0 <fprintf@plt>
    6495:	bf 65 00 00 00       	mov    $0x65,%edi
    649a:	e8 d1 bd ff ff       	call   2270 <exit@plt>
    649f:	90                   	nop

00000000000064a0 <e56>:
    64a0:	50                   	push   %rax
    64a1:	48 89 f8             	mov    %rdi,%rax
    64a4:	48 8b 3f             	mov    (%rdi),%rdi
    64a7:	48 8b 0d ea cc 00 00 	mov    0xccea(%rip),%rcx        # 13198 <fwp_gc+0x1030>
    64ae:	48 89 fe             	mov    %rdi,%rsi
    64b1:	48 29 ce             	sub    %rcx,%rsi
    64b4:	48 8b 15 05 cd 00 00 	mov    0xcd05(%rip),%rdx        # 131c0 <fwp_gc+0x1058>
    64bb:	48 c1 e2 10          	shl    $0x10,%rdx
    64bf:	48 39 d6             	cmp    %rdx,%rsi
    64c2:	73 68                	jae    652c <e56+0x8c>
    64c4:	4c 8b 05 15 cd 00 00 	mov    0xcd15(%rip),%r8        # 131e0 <fwp_gc+0x1078>
    64cb:	49 89 f1             	mov    %rsi,%r9
    64ce:	49 c1 e9 10          	shr    $0x10,%r9
    64d2:	4d 69 c9 28 12 00 00 	imul   $0x1228,%r9,%r9
    64d9:	47 0f b6 14 08       	movzbl (%r8,%r9,1),%r10d
    64de:	48 81 e6 ff ff 00 00 	and    $0xffff,%rsi
    64e5:	75 1b                	jne    6502 <e56+0x62>
    64e7:	41 80 fa 02          	cmp    $0x2,%r10b
    64eb:	75 15                	jne    6502 <e56+0x62>
    64ed:	4b 8d 34 08          	lea    (%r8,%r9,1),%rsi
    64f1:	48 81 c6 28 02 00 00 	add    $0x228,%rsi
    64f8:	80 3e 00             	cmpb   $0x0,(%rsi)
    64fb:	74 2f                	je     652c <e56+0x8c>
    64fd:	e9 1d 01 00 00       	jmp    661f <e56+0x17f>
    6502:	41 80 fa 01          	cmp    $0x1,%r10b
    6506:	75 24                	jne    652c <e56+0x8c>
    6508:	4f 8d 14 08          	lea    (%r8,%r9,1),%r10
    650c:	47 8b 44 08 20       	mov    0x20(%r8,%r9,1),%r8d
    6511:	49 0f af f0          	imul   %r8,%rsi
    6515:	48 c1 ee 20          	shr    $0x20,%rsi
    6519:	4c 01 d6             	add    %r10,%rsi
    651c:	48 81 c6 28 02 00 00 	add    $0x228,%rsi
    6523:	80 3e 00             	cmpb   $0x0,(%rsi)
    6526:	0f 85 f3 00 00 00    	jne    661f <e56+0x17f>
    652c:	48 8b 70 08          	mov    0x8(%rax),%rsi
    6530:	48 89 f0             	mov    %rsi,%rax
    6533:	48 29 c8             	sub    %rcx,%rax
    6536:	48 39 d0             	cmp    %rdx,%rax
    6539:	73 64                	jae    659f <e56+0xff>
    653b:	48 8b 0d 9e cc 00 00 	mov    0xcc9e(%rip),%rcx        # 131e0 <fwp_gc+0x1078>
    6542:	48 89 c2             	mov    %rax,%rdx
    6545:	48 c1 ea 10          	shr    $0x10,%rdx
    6549:	48 69 d2 28 12 00 00 	imul   $0x1228,%rdx,%rdx
    6550:	44 0f b6 04 11       	movzbl (%rcx,%rdx,1),%r8d
    6555:	48 25 ff ff 00 00    	and    $0xffff,%rax
    655b:	75 1a                	jne    6577 <e56+0xd7>
    655d:	41 80 f8 02          	cmp    $0x2,%r8b
    6561:	75 14                	jne    6577 <e56+0xd7>
    6563:	48 8d 04 11          	lea    (%rcx,%rdx,1),%rax
    6567:	48 05 28 02 00 00    	add    $0x228,%rax
    656d:	80 38 00             	cmpb   $0x0,(%rax)
    6570:	74 2d                	je     659f <e56+0xff>
    6572:	e9 a8 00 00 00       	jmp    661f <e56+0x17f>
    6577:	41 80 f8 01          	cmp    $0x1,%r8b
    657b:	75 22                	jne    659f <e56+0xff>
    657d:	4c 8d 04 11          	lea    (%rcx,%rdx,1),%r8
    6581:	8b 4c 11 20          	mov    0x20(%rcx,%rdx,1),%ecx
    6585:	48 0f af c1          	imul   %rcx,%rax
    6589:	48 c1 e8 20          	shr    $0x20,%rax
    658d:	4c 01 c0             	add    %r8,%rax
    6590:	48 05 28 02 00 00    	add    $0x228,%rax
    6596:	80 38 00             	cmpb   $0x0,(%rax)
    6599:	0f 85 80 00 00 00    	jne    661f <e56+0x17f>
    659f:	e8 2c 4d 00 00       	call   b2d0 <fwp_p_loop_own>
    65a4:	48 89 c1             	mov    %rax,%rcx
    65a7:	48 2b 0d ea cb 00 00 	sub    0xcbea(%rip),%rcx        # 13198 <fwp_gc+0x1030>
    65ae:	48 8b 15 0b cc 00 00 	mov    0xcc0b(%rip),%rdx        # 131c0 <fwp_gc+0x1058>
    65b5:	48 c1 e2 10          	shl    $0x10,%rdx
    65b9:	48 39 d1             	cmp    %rdx,%rcx
    65bc:	73 5f                	jae    661d <e56+0x17d>
    65be:	48 8b 15 1b cc 00 00 	mov    0xcc1b(%rip),%rdx        # 131e0 <fwp_gc+0x1078>
    65c5:	48 89 ce             	mov    %rcx,%rsi
    65c8:	48 c1 ee 10          	shr    $0x10,%rsi
    65cc:	48 69 f6 28 12 00 00 	imul   $0x1228,%rsi,%rsi
    65d3:	0f b6 3c 32          	movzbl (%rdx,%rsi,1),%edi
    65d7:	48 81 e1 ff ff 00 00 	and    $0xffff,%rcx
    65de:	75 18                	jne    65f8 <e56+0x158>
    65e0:	40 80 ff 02          	cmp    $0x2,%dil
    65e4:	75 12                	jne    65f8 <e56+0x158>
    65e6:	48 8d 0c 32          	lea    (%rdx,%rsi,1),%rcx
    65ea:	48 81 c1 28 02 00 00 	add    $0x228,%rcx
    65f1:	80 39 00             	cmpb   $0x0,(%rcx)
    65f4:	74 27                	je     661d <e56+0x17d>
    65f6:	eb 27                	jmp    661f <e56+0x17f>
    65f8:	40 80 ff 01          	cmp    $0x1,%dil
    65fc:	75 1f                	jne    661d <e56+0x17d>
    65fe:	48 8d 3c 32          	lea    (%rdx,%rsi,1),%rdi
    6602:	8b 54 32 20          	mov    0x20(%rdx,%rsi,1),%edx
    6606:	48 0f af ca          	imul   %rdx,%rcx
    660a:	48 c1 e9 20          	shr    $0x20,%rcx
    660e:	48 01 f9             	add    %rdi,%rcx
    6611:	48 81 c1 28 02 00 00 	add    $0x228,%rcx
    6618:	80 39 00             	cmpb   $0x0,(%rcx)
    661b:	75 02                	jne    661f <e56+0x17f>
    661d:	59                   	pop    %rcx
    661e:	c3                   	ret
    661f:	e8 3c 04 00 00       	call   6a60 <fwp_flush>
    6624:	48 8b 05 b5 b9 00 00 	mov    0xb9b5(%rip),%rax        # 11fe0 <stderr@GLIBC_2.2.5>
    662b:	48 8b 38             	mov    (%rax),%rdi
    662e:	48 8d 35 98 8e 00 00 	lea    0x8e98(%rip),%rsi        # f4cd <fwp_segv.msg+0x24d>
    6635:	48 8d 15 64 8e 00 00 	lea    0x8e64(%rip),%rdx        # f4a0 <fwp_segv.msg+0x220>
    663c:	31 c0                	xor    %eax,%eax
    663e:	e8 5d bb ff ff       	call   21a0 <fprintf@plt>
    6643:	bf 65 00 00 00       	mov    $0x65,%edi
    6648:	e8 23 bc ff ff       	call   2270 <exit@plt>
    664d:	0f 1f 00             	nopl   (%rax)

0000000000006650 <e57>:
    6650:	50                   	push   %rax
    6651:	48 8b 3f             	mov    (%rdi),%rdi
    6654:	48 89 f8             	mov    %rdi,%rax
    6657:	48 2b 05 3a cb 00 00 	sub    0xcb3a(%rip),%rax        # 13198 <fwp_gc+0x1030>
    665e:	48 8b 0d 5b cb 00 00 	mov    0xcb5b(%rip),%rcx        # 131c0 <fwp_gc+0x1058>
    6665:	48 c1 e1 10          	shl    $0x10,%rcx
    6669:	48 39 c8             	cmp    %rcx,%rax
    666c:	73 63                	jae    66d1 <e57+0x81>
    666e:	48 8b 0d 6b cb 00 00 	mov    0xcb6b(%rip),%rcx        # 131e0 <fwp_gc+0x1078>
    6675:	48 89 c2             	mov    %rax,%rdx
    6678:	48 c1 ea 10          	shr    $0x10,%rdx
    667c:	48 69 d2 28 12 00 00 	imul   $0x1228,%rdx,%rdx
    6683:	0f b6 34 11          	movzbl (%rcx,%rdx,1),%esi
    6687:	48 25 ff ff 00 00    	and    $0xffff,%rax
    668d:	75 1a                	jne    66a9 <e57+0x59>
    668f:	40 80 fe 02          	cmp    $0x2,%sil
    6693:	75 14                	jne    66a9 <e57+0x59>
    6695:	48 8d 04 11          	lea    (%rcx,%rdx,1),%rax
    6699:	48 05 28 02 00 00    	add    $0x228,%rax
    669f:	80 38 00             	cmpb   $0x0,(%rax)
    66a2:	74 2d                	je     66d1 <e57+0x81>
    66a4:	e9 a8 00 00 00       	jmp    6751 <e57+0x101>
    66a9:	40 80 fe 01          	cmp    $0x1,%sil
    66ad:	75 22                	jne    66d1 <e57+0x81>
    66af:	48 8d 34 11          	lea    (%rcx,%rdx,1),%rsi
    66b3:	8b 4c 11 20          	mov    0x20(%rcx,%rdx,1),%ecx
    66b7:	48 0f af c1          	imul   %rcx,%rax
    66bb:	48 c1 e8 20          	shr    $0x20,%rax
    66bf:	48 01 f0             	add    %rsi,%rax
    66c2:	48 05 28 02 00 00    	add    $0x228,%rax
    66c8:	80 38 00             	cmpb   $0x0,(%rax)
    66cb:	0f 85 80 00 00 00    	jne    6751 <e57+0x101>
    66d1:	e8 2a 70 00 00       	call   d700 <f57>
    66d6:	48 89 c1             	mov    %rax,%rcx
    66d9:	48 2b 0d b8 ca 00 00 	sub    0xcab8(%rip),%rcx        # 13198 <fwp_gc+0x1030>
    66e0:	48 8b 15 d9 ca 00 00 	mov    0xcad9(%rip),%rdx        # 131c0 <fwp_gc+0x1058>
    66e7:	48 c1 e2 10          	shl    $0x10,%rdx
    66eb:	48 39 d1             	cmp    %rdx,%rcx
    66ee:	73 5f                	jae    674f <e57+0xff>
    66f0:	48 8b 15 e9 ca 00 00 	mov    0xcae9(%rip),%rdx        # 131e0 <fwp_gc+0x1078>
    66f7:	48 89 ce             	mov    %rcx,%rsi
    66fa:	48 c1 ee 10          	shr    $0x10,%rsi
    66fe:	48 69 f6 28 12 00 00 	imul   $0x1228,%rsi,%rsi
    6705:	0f b6 3c 32          	movzbl (%rdx,%rsi,1),%edi
    6709:	48 81 e1 ff ff 00 00 	and    $0xffff,%rcx
    6710:	75 18                	jne    672a <e57+0xda>
    6712:	40 80 ff 02          	cmp    $0x2,%dil
    6716:	75 12                	jne    672a <e57+0xda>
    6718:	48 8d 0c 32          	lea    (%rdx,%rsi,1),%rcx
    671c:	48 81 c1 28 02 00 00 	add    $0x228,%rcx
    6723:	80 39 00             	cmpb   $0x0,(%rcx)
    6726:	74 27                	je     674f <e57+0xff>
    6728:	eb 27                	jmp    6751 <e57+0x101>
    672a:	40 80 ff 01          	cmp    $0x1,%dil
    672e:	75 1f                	jne    674f <e57+0xff>
    6730:	48 8d 3c 32          	lea    (%rdx,%rsi,1),%rdi
    6734:	8b 54 32 20          	mov    0x20(%rdx,%rsi,1),%edx
    6738:	48 0f af ca          	imul   %rdx,%rcx
    673c:	48 c1 e9 20          	shr    $0x20,%rcx
    6740:	48 01 f9             	add    %rdi,%rcx
    6743:	48 81 c1 28 02 00 00 	add    $0x228,%rcx
    674a:	80 39 00             	cmpb   $0x0,(%rcx)
    674d:	75 02                	jne    6751 <e57+0x101>
    674f:	59                   	pop    %rcx
    6750:	c3                   	ret
    6751:	e8 0a 03 00 00       	call   6a60 <fwp_flush>
    6756:	48 8b 05 83 b8 00 00 	mov    0xb883(%rip),%rax        # 11fe0 <stderr@GLIBC_2.2.5>
    675d:	48 8b 38             	mov    (%rax),%rdi
    6760:	48 8d 35 66 8d 00 00 	lea    0x8d66(%rip),%rsi        # f4cd <fwp_segv.msg+0x24d>
    6767:	48 8d 15 32 8d 00 00 	lea    0x8d32(%rip),%rdx        # f4a0 <fwp_segv.msg+0x220>
    676e:	31 c0                	xor    %eax,%eax
    6770:	e8 2b ba ff ff       	call   21a0 <fprintf@plt>
    6775:	bf 65 00 00 00       	mov    $0x65,%edi
    677a:	e8 f1 ba ff ff       	call   2270 <exit@plt>
    677f:	90                   	nop

0000000000006780 <e58>:
    6780:	50                   	push   %rax
    6781:	48 89 f8             	mov    %rdi,%rax
    6784:	48 8b 3f             	mov    (%rdi),%rdi
    6787:	48 8b 0d 0a ca 00 00 	mov    0xca0a(%rip),%rcx        # 13198 <fwp_gc+0x1030>
    678e:	48 89 fe             	mov    %rdi,%rsi
    6791:	48 29 ce             	sub    %rcx,%rsi
    6794:	48 8b 15 25 ca 00 00 	mov    0xca25(%rip),%rdx        # 131c0 <fwp_gc+0x1058>
    679b:	48 c1 e2 10          	shl    $0x10,%rdx
    679f:	48 39 d6             	cmp    %rdx,%rsi
    67a2:	73 68                	jae    680c <e58+0x8c>
    67a4:	4c 8b 05 35 ca 00 00 	mov    0xca35(%rip),%r8        # 131e0 <fwp_gc+0x1078>
    67ab:	49 89 f1             	mov    %rsi,%r9
    67ae:	49 c1 e9 10          	shr    $0x10,%r9
    67b2:	4d 69 c9 28 12 00 00 	imul   $0x1228,%r9,%r9
    67b9:	47 0f b6 14 08       	movzbl (%r8,%r9,1),%r10d
    67be:	48 81 e6 ff ff 00 00 	and    $0xffff,%rsi
    67c5:	75 1b                	jne    67e2 <e58+0x62>
    67c7:	41 80 fa 02          	cmp    $0x2,%r10b
    67cb:	75 15                	jne    67e2 <e58+0x62>
    67cd:	4b 8d 34 08          	lea    (%r8,%r9,1),%rsi
    67d1:	48 81 c6 28 02 00 00 	add    $0x228,%rsi
    67d8:	80 3e 00             	cmpb   $0x0,(%rsi)
    67db:	74 2f                	je     680c <e58+0x8c>
    67dd:	e9 1d 01 00 00       	jmp    68ff <e58+0x17f>
    67e2:	41 80 fa 01          	cmp    $0x1,%r10b
    67e6:	75 24                	jne    680c <e58+0x8c>
    67e8:	4f 8d 14 08          	lea    (%r8,%r9,1),%r10
    67ec:	47 8b 44 08 20       	mov    0x20(%r8,%r9,1),%r8d
    67f1:	49 0f af f0          	imul   %r8,%rsi
    67f5:	48 c1 ee 20          	shr    $0x20,%rsi
    67f9:	4c 01 d6             	add    %r10,%rsi
    67fc:	48 81 c6 28 02 00 00 	add    $0x228,%rsi
    6803:	80 3e 00             	cmpb   $0x0,(%rsi)
    6806:	0f 85 f3 00 00 00    	jne    68ff <e58+0x17f>
    680c:	48 8b 70 08          	mov    0x8(%rax),%rsi
    6810:	48 89 f0             	mov    %rsi,%rax
    6813:	48 29 c8             	sub    %rcx,%rax
    6816:	48 39 d0             	cmp    %rdx,%rax
    6819:	73 64                	jae    687f <e58+0xff>
    681b:	48 8b 0d be c9 00 00 	mov    0xc9be(%rip),%rcx        # 131e0 <fwp_gc+0x1078>
    6822:	48 89 c2             	mov    %rax,%rdx
    6825:	48 c1 ea 10          	shr    $0x10,%rdx
    6829:	48 69 d2 28 12 00 00 	imul   $0x1228,%rdx,%rdx
    6830:	44 0f b6 04 11       	movzbl (%rcx,%rdx,1),%r8d
    6835:	48 25 ff ff 00 00    	and    $0xffff,%rax
    683b:	75 1a                	jne    6857 <e58+0xd7>
    683d:	41 80 f8 02          	cmp    $0x2,%r8b
    6841:	75 14                	jne    6857 <e58+0xd7>
    6843:	48 8d 04 11          	lea    (%rcx,%rdx,1),%rax
    6847:	48 05 28 02 00 00    	add    $0x228,%rax
    684d:	80 38 00             	cmpb   $0x0,(%rax)
    6850:	74 2d                	je     687f <e58+0xff>
    6852:	e9 a8 00 00 00       	jmp    68ff <e58+0x17f>
    6857:	41 80 f8 01          	cmp    $0x1,%r8b
    685b:	75 22                	jne    687f <e58+0xff>
    685d:	4c 8d 04 11          	lea    (%rcx,%rdx,1),%r8
    6861:	8b 4c 11 20          	mov    0x20(%rcx,%rdx,1),%ecx
    6865:	48 0f af c1          	imul   %rcx,%rax
    6869:	48 c1 e8 20          	shr    $0x20,%rax
    686d:	4c 01 c0             	add    %r8,%rax
    6870:	48 05 28 02 00 00    	add    $0x228,%rax
    6876:	80 38 00             	cmpb   $0x0,(%rax)
    6879:	0f 85 80 00 00 00    	jne    68ff <e58+0x17f>
    687f:	e8 4c 4a 00 00       	call   b2d0 <fwp_p_loop_own>
    6884:	48 89 c1             	mov    %rax,%rcx
    6887:	48 2b 0d 0a c9 00 00 	sub    0xc90a(%rip),%rcx        # 13198 <fwp_gc+0x1030>
    688e:	48 8b 15 2b c9 00 00 	mov    0xc92b(%rip),%rdx        # 131c0 <fwp_gc+0x1058>
    6895:	48 c1 e2 10          	shl    $0x10,%rdx
    6899:	48 39 d1             	cmp    %rdx,%rcx
    689c:	73 5f                	jae    68fd <e58+0x17d>
    689e:	48 8b 15 3b c9 00 00 	mov    0xc93b(%rip),%rdx        # 131e0 <fwp_gc+0x1078>
    68a5:	48 89 ce             	mov    %rcx,%rsi
    68a8:	48 c1 ee 10          	shr    $0x10,%rsi
    68ac:	48 69 f6 28 12 00 00 	imul   $0x1228,%rsi,%rsi
    68b3:	0f b6 3c 32          	movzbl (%rdx,%rsi,1),%edi
    68b7:	48 81 e1 ff ff 00 00 	and    $0xffff,%rcx
    68be:	75 18                	jne    68d8 <e58+0x158>
    68c0:	40 80 ff 02          	cmp    $0x2,%dil
    68c4:	75 12                	jne    68d8 <e58+0x158>
    68c6:	48 8d 0c 32          	lea    (%rdx,%rsi,1),%rcx
    68ca:	48 81 c1 28 02 00 00 	add    $0x228,%rcx
    68d1:	80 39 00             	cmpb   $0x0,(%rcx)
    68d4:	74 27                	je     68fd <e58+0x17d>
    68d6:	eb 27                	jmp    68ff <e58+0x17f>
    68d8:	40 80 ff 01          	cmp    $0x1,%dil
    68dc:	75 1f                	jne    68fd <e58+0x17d>
    68de:	48 8d 3c 32          	lea    (%rdx,%rsi,1),%rdi
    68e2:	8b 54 32 20          	mov    0x20(%rdx,%rsi,1),%edx
    68e6:	48 0f af ca          	imul   %rdx,%rcx
    68ea:	48 c1 e9 20          	shr    $0x20,%rcx
    68ee:	48 01 f9             	add    %rdi,%rcx
    68f1:	48 81 c1 28 02 00 00 	add    $0x228,%rcx
    68f8:	80 39 00             	cmpb   $0x0,(%rcx)
    68fb:	75 02                	jne    68ff <e58+0x17f>
    68fd:	59                   	pop    %rcx
    68fe:	c3                   	ret
    68ff:	e8 5c 01 00 00       	call   6a60 <fwp_flush>
    6904:	48 8b 05 d5 b6 00 00 	mov    0xb6d5(%rip),%rax        # 11fe0 <stderr@GLIBC_2.2.5>
    690b:	48 8b 38             	mov    (%rax),%rdi
    690e:	48 8d 35 b8 8b 00 00 	lea    0x8bb8(%rip),%rsi        # f4cd <fwp_segv.msg+0x24d>
    6915:	48 8d 15 84 8b 00 00 	lea    0x8b84(%rip),%rdx        # f4a0 <fwp_segv.msg+0x220>
    691c:	31 c0                	xor    %eax,%eax
    691e:	e8 7d b8 ff ff       	call   21a0 <fprintf@plt>
    6923:	bf 65 00 00 00       	mov    $0x65,%edi
    6928:	e8 43 b9 ff ff       	call   2270 <exit@plt>
    692d:	0f 1f 00             	nopl   (%rax)

0000000000006930 <e59>:
    6930:	50                   	push   %rax
    6931:	48 8b 3f             	mov    (%rdi),%rdi
    6934:	48 89 f8             	mov    %rdi,%rax
    6937:	48 2b 05 5a c8 00 00 	sub    0xc85a(%rip),%rax        # 13198 <fwp_gc+0x1030>
    693e:	48 8b 0d 7b c8 00 00 	mov    0xc87b(%rip),%rcx        # 131c0 <fwp_gc+0x1058>
    6945:	48 c1 e1 10          	shl    $0x10,%rcx
    6949:	48 39 c8             	cmp    %rcx,%rax
    694c:	73 63                	jae    69b1 <e59+0x81>
    694e:	48 8b 0d 8b c8 00 00 	mov    0xc88b(%rip),%rcx        # 131e0 <fwp_gc+0x1078>
    6955:	48 89 c2             	mov    %rax,%rdx
    6958:	48 c1 ea 10          	shr    $0x10,%rdx
    695c:	48 69 d2 28 12 00 00 	imul   $0x1228,%rdx,%rdx
    6963:	0f b6 34 11          	movzbl (%rcx,%rdx,1),%esi
    6967:	48 25 ff ff 00 00    	and    $0xffff,%rax
    696d:	75 1a                	jne    6989 <e59+0x59>
    696f:	40 80 fe 02          	cmp    $0x2,%sil
    6973:	75 14                	jne    6989 <e59+0x59>
    6975:	48 8d 04 11          	lea    (%rcx,%rdx,1),%rax
    6979:	48 05 28 02 00 00    	add    $0x228,%rax
    697f:	80 38 00             	cmpb   $0x0,(%rax)
    6982:	74 2d                	je     69b1 <e59+0x81>
    6984:	e9 a8 00 00 00       	jmp    6a31 <e59+0x101>
    6989:	40 80 fe 01          	cmp    $0x1,%sil
    698d:	75 22                	jne    69b1 <e59+0x81>
    698f:	48 8d 34 11          	lea    (%rcx,%rdx,1),%rsi
    6993:	8b 4c 11 20          	mov    0x20(%rcx,%rdx,1),%ecx
    6997:	48 0f af c1          	imul   %rcx,%rax
    699b:	48 c1 e8 20          	shr    $0x20,%rax
    699f:	48 01 f0             	add    %rsi,%rax
    69a2:	48 05 28 02 00 00    	add    $0x228,%rax
    69a8:	80 38 00             	cmpb   $0x0,(%rax)
    69ab:	0f 85 80 00 00 00    	jne    6a31 <e59+0x101>
    69b1:	e8 3a 73 00 00       	call   dcf0 <f59>
    69b6:	48 89 c1             	mov    %rax,%rcx
    69b9:	48 2b 0d d8 c7 00 00 	sub    0xc7d8(%rip),%rcx        # 13198 <fwp_gc+0x1030>
    69c0:	48 8b 15 f9 c7 00 00 	mov    0xc7f9(%rip),%rdx        # 131c0 <fwp_gc+0x1058>
    69c7:	48 c1 e2 10          	shl    $0x10,%rdx
    69cb:	48 39 d1             	cmp    %rdx,%rcx
    69ce:	73 5f                	jae    6a2f <e59+0xff>
    69d0:	48 8b 15 09 c8 00 00 	mov    0xc809(%rip),%rdx        # 131e0 <fwp_gc+0x1078>
    69d7:	48 89 ce             	mov    %rcx,%rsi
    69da:	48 c1 ee 10          	shr    $0x10,%rsi
    69de:	48 69 f6 28 12 00 00 	imul   $0x1228,%rsi,%rsi
    69e5:	0f b6 3c 32          	movzbl (%rdx,%rsi,1),%edi
    69e9:	48 81 e1 ff ff 00 00 	and    $0xffff,%rcx
    69f0:	75 18                	jne    6a0a <e59+0xda>
    69f2:	40 80 ff 02          	cmp    $0x2,%dil
    69f6:	75 12                	jne    6a0a <e59+0xda>
    69f8:	48 8d 0c 32          	lea    (%rdx,%rsi,1),%rcx
    69fc:	48 81 c1 28 02 00 00 	add    $0x228,%rcx
    6a03:	80 39 00             	cmpb   $0x0,(%rcx)
    6a06:	74 27                	je     6a2f <e59+0xff>
    6a08:	eb 27                	jmp    6a31 <e59+0x101>
    6a0a:	40 80 ff 01          	cmp    $0x1,%dil
    6a0e:	75 1f                	jne    6a2f <e59+0xff>
    6a10:	48 8d 3c 32          	lea    (%rdx,%rsi,1),%rdi
    6a14:	8b 54 32 20          	mov    0x20(%rdx,%rsi,1),%edx
    6a18:	48 0f af ca          	imul   %rdx,%rcx
    6a1c:	48 c1 e9 20          	shr    $0x20,%rcx
    6a20:	48 01 f9             	add    %rdi,%rcx
    6a23:	48 81 c1 28 02 00 00 	add    $0x228,%rcx
    6a2a:	80 39 00             	cmpb   $0x0,(%rcx)
    6a2d:	75 02                	jne    6a31 <e59+0x101>
    6a2f:	59                   	pop    %rcx
    6a30:	c3                   	ret
    6a31:	e8 2a 00 00 00       	call   6a60 <fwp_flush>
    6a36:	48 8b 05 a3 b5 00 00 	mov    0xb5a3(%rip),%rax        # 11fe0 <stderr@GLIBC_2.2.5>
    6a3d:	48 8b 38             	mov    (%rax),%rdi
    6a40:	48 8d 35 86 8a 00 00 	lea    0x8a86(%rip),%rsi        # f4cd <fwp_segv.msg+0x24d>
    6a47:	48 8d 15 52 8a 00 00 	lea    0x8a52(%rip),%rdx        # f4a0 <fwp_segv.msg+0x220>
    6a4e:	31 c0                	xor    %eax,%eax
    6a50:	e8 4b b7 ff ff       	call   21a0 <fprintf@plt>
    6a55:	bf 65 00 00 00       	mov    $0x65,%edi
    6a5a:	e8 11 b8 ff ff       	call   2270 <exit@plt>
    6a5f:	90                   	nop

0000000000006a60 <fwp_flush>:
    6a60:	50                   	push   %rax
    6a61:	48 8b 3d 00 dd 00 00 	mov    0xdd00(%rip),%rdi        # 14768 <fwp_prog_out>
    6a68:	48 85 ff             	test   %rdi,%rdi
    6a6b:	74 05                	je     6a72 <fwp_flush+0x12>
    6a6d:	e8 6e b7 ff ff       	call   21e0 <fflush@plt>
    6a72:	48 8b 05 47 b5 00 00 	mov    0xb547(%rip),%rax        # 11fc0 <stdout@GLIBC_2.2.5>
    6a79:	48 8b 38             	mov    (%rax),%rdi
    6a7c:	58                   	pop    %rax
    6a7d:	e9 5e b7 ff ff       	jmp    21e0 <fflush@plt>
    6a82:	66 66 66 66 66 2e 0f 	data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    6a89:	1f 84 00 00 00 00 00 

0000000000006a90 <fwp_rc_forget_slot>:
    6a90:	50                   	push   %rax
    6a91:	80 3f ff             	cmpb   $0xff,(%rdi)
    6a94:	74 02                	je     6a98 <fwp_rc_forget_slot+0x8>
    6a96:	58                   	pop    %rax
    6a97:	c3                   	ret
    6a98:	48 89 f8             	mov    %rdi,%rax
    6a9b:	48 c1 e8 11          	shr    $0x11,%rax
    6a9f:	31 f8                	xor    %edi,%eax
    6aa1:	89 c1                	mov    %eax,%ecx
    6aa3:	c1 e9 09             	shr    $0x9,%ecx
    6aa6:	31 c1                	xor    %eax,%ecx
    6aa8:	0f b6 c9             	movzbl %cl,%ecx
    6aab:	48 8d 15 b6 b6 00 00 	lea    0xb6b6(%rip),%rdx        # 12168 <fwp_gc>
    6ab2:	48 8b 84 ca 18 12 00 	mov    0x1218(%rdx,%rcx,8),%rax
    6ab9:	00 
    6aba:	48 85 c0             	test   %rax,%rax
    6abd:	0f 84 9e 00 00 00    	je     6b61 <fwp_rc_forget_slot+0xd1>
    6ac3:	48 39 38             	cmp    %rdi,(%rax)
    6ac6:	74 23                	je     6aeb <fwp_rc_forget_slot+0x5b>
    6ac8:	0f 1f 84 00 00 00 00 	nopl   0x0(%rax,%rax,1)
    6acf:	00 
    6ad0:	48 89 c1             	mov    %rax,%rcx
    6ad3:	48 8b 40 10          	mov    0x10(%rax),%rax
    6ad7:	48 85 c0             	test   %rax,%rax
    6ada:	0f 84 81 00 00 00    	je     6b61 <fwp_rc_forget_slot+0xd1>
    6ae0:	48 39 38             	cmp    %rdi,(%rax)
    6ae3:	75 eb                	jne    6ad0 <fwp_rc_forget_slot+0x40>
    6ae5:	48 83 c1 10          	add    $0x10,%rcx
    6ae9:	eb 0b                	jmp    6af6 <fwp_rc_forget_slot+0x66>
    6aeb:	48 8d 0c ca          	lea    (%rdx,%rcx,8),%rcx
    6aef:	48 81 c1 18 12 00 00 	add    $0x1218,%rcx
    6af6:	48 8b 50 10          	mov    0x10(%rax),%rdx
    6afa:	48 89 11             	mov    %rdx,(%rcx)
    6afd:	8b 48 f4             	mov    -0xc(%rax),%ecx
    6b00:	b2 01                	mov    $0x1,%dl
    6b02:	86 15 e0 d8 00 00    	xchg   %dl,0xd8e0(%rip)        # 143e8 <fwp_static+0x848>
    6b08:	84 d2                	test   %dl,%dl
    6b0a:	75 f4                	jne    6b00 <fwp_rc_forget_slot+0x70>
    6b0c:	48 29 c8             	sub    %rcx,%rax
    6b0f:	48 8d 50 f0          	lea    -0x10(%rax),%rdx
    6b13:	8b 70 f0             	mov    -0x10(%rax),%esi
    6b16:	89 f1                	mov    %esi,%ecx
    6b18:	c1 e9 02             	shr    $0x2,%ecx
    6b1b:	bf 01 00 00 00       	mov    $0x1,%edi
    6b20:	48 d3 e7             	shl    %cl,%rdi
    6b23:	89 f1                	mov    %esi,%ecx
    6b25:	83 e1 03             	and    $0x3,%ecx
    6b28:	49 89 f8             	mov    %rdi,%r8
    6b2b:	49 c1 e8 02          	shr    $0x2,%r8
    6b2f:	4c 0f af c1          	imul   %rcx,%r8
    6b33:	49 01 f8             	add    %rdi,%r8
    6b36:	4c 29 05 9b d8 00 00 	sub    %r8,0xd89b(%rip)        # 143d8 <fwp_static+0x838>
    6b3d:	48 8d 0d 5c d0 00 00 	lea    0xd05c(%rip),%rcx        # 13ba0 <fwp_static>
    6b44:	48 8b 7c f1 38       	mov    0x38(%rcx,%rsi,8),%rdi
    6b49:	48 89 38             	mov    %rdi,(%rax)
    6b4c:	48 89 54 f1 38       	mov    %rdx,0x38(%rcx,%rsi,8)
    6b51:	c6 05 90 d8 00 00 00 	movb   $0x0,0xd890(%rip)        # 143e8 <fwp_static+0x848>
    6b58:	48 ff 0d 21 d0 00 00 	decq   0xd021(%rip)        # 13b80 <fwp_gc+0x1a18>
    6b5f:	58                   	pop    %rax
    6b60:	c3                   	ret
    6b61:	e8 fa fe ff ff       	call   6a60 <fwp_flush>
    6b66:	48 8b 05 73 b4 00 00 	mov    0xb473(%rip),%rax        # 11fe0 <stderr@GLIBC_2.2.5>
    6b6d:	48 8b 38             	mov    (%rax),%rdi
    6b70:	48 8d 35 56 89 00 00 	lea    0x8956(%rip),%rsi        # f4cd <fwp_segv.msg+0x24d>
    6b77:	48 8d 15 5e 89 00 00 	lea    0x895e(%rip),%rdx        # f4dc <fwp_segv.msg+0x25c>
    6b7e:	31 c0                	xor    %eax,%eax
    6b80:	e8 1b b6 ff ff       	call   21a0 <fprintf@plt>
    6b85:	bf 65 00 00 00       	mov    $0x65,%edi
    6b8a:	e8 e1 b6 ff ff       	call   2270 <exit@plt>
    6b8f:	90                   	nop

0000000000006b90 <fwp_p_array_from_list_typed>:
    6b90:	41 56                	push   %r14
    6b92:	53                   	push   %rbx
    6b93:	50                   	push   %rax
    6b94:	48 89 fb             	mov    %rdi,%rbx
    6b97:	48 85 ff             	test   %rdi,%rdi
    6b9a:	0f 84 ae 00 00 00    	je     6c4e <fwp_p_array_from_list_typed+0xbe>
    6ba0:	31 ff                	xor    %edi,%edi
    6ba2:	48 89 d8             	mov    %rbx,%rax
    6ba5:	66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
    6bac:	00 00 00 00 
    6bb0:	48 ff c7             	inc    %rdi
    6bb3:	48 8b 40 10          	mov    0x10(%rax),%rax
    6bb7:	48 85 c0             	test   %rax,%rax
    6bba:	75 f4                	jne    6bb0 <fwp_p_array_from_list_typed+0x20>
    6bbc:	49 89 f6             	mov    %rsi,%r14
    6bbf:	e8 cc 00 00 00       	call   6c90 <fwp_array_typed_new>
    6bc4:	48 85 db             	test   %rbx,%rbx
    6bc7:	0f 84 88 00 00 00    	je     6c55 <fwp_p_array_from_list_typed+0xc5>
    6bcd:	b9 04 00 00 00       	mov    $0x4,%ecx
    6bd2:	ba 84 04 00 00       	mov    $0x484,%edx
    6bd7:	be 21 00 00 00       	mov    $0x21,%esi
    6bdc:	bf 42 00 00 00       	mov    $0x42,%edi
    6be1:	49 89 d8             	mov    %rbx,%r8
    6be4:	4d 89 f1             	mov    %r14,%r9
    6be7:	eb 18                	jmp    6c01 <fwp_p_array_from_list_typed+0x71>
    6be9:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)
    6bf0:	4c 89 54 c8 e8       	mov    %r10,-0x18(%rax,%rcx,8)
    6bf5:	4d 8b 40 10          	mov    0x10(%r8),%r8
    6bf9:	48 ff c1             	inc    %rcx
    6bfc:	4d 85 c0             	test   %r8,%r8
    6bff:	74 54                	je     6c55 <fwp_p_array_from_list_typed+0xc5>
    6c01:	48 83 38 00          	cmpq   $0x0,(%rax)
    6c05:	78 56                	js     6c5d <fwp_p_array_from_list_typed+0xcd>
    6c07:	4d 8b 50 08          	mov    0x8(%r8),%r10
    6c0b:	4d 85 c9             	test   %r9,%r9
    6c0e:	74 e0                	je     6bf0 <fwp_p_array_from_list_typed+0x60>
    6c10:	45 8b 19             	mov    (%r9),%r11d
    6c13:	41 83 fb 0a          	cmp    $0xa,%r11d
    6c17:	77 d7                	ja     6bf0 <fwp_p_array_from_list_typed+0x60>
    6c19:	44 0f a3 da          	bt     %r11d,%edx
    6c1d:	72 21                	jb     6c40 <fwp_p_array_from_list_typed+0xb0>
    6c1f:	44 0f a3 de          	bt     %r11d,%esi
    6c23:	72 22                	jb     6c47 <fwp_p_array_from_list_typed+0xb7>
    6c25:	44 0f a3 df          	bt     %r11d,%edi
    6c29:	73 c5                	jae    6bf0 <fwp_p_array_from_list_typed+0x60>
    6c2b:	66 44 89 14 48       	mov    %r10w,(%rax,%rcx,2)
    6c30:	eb c3                	jmp    6bf5 <fwp_p_array_from_list_typed+0x65>
    6c32:	66 66 66 66 66 2e 0f 	data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    6c39:	1f 84 00 00 00 00 00 
    6c40:	44 89 54 88 f8       	mov    %r10d,-0x8(%rax,%rcx,4)
    6c45:	eb ae                	jmp    6bf5 <fwp_p_array_from_list_typed+0x65>
    6c47:	44 88 54 08 04       	mov    %r10b,0x4(%rax,%rcx,1)
    6c4c:	eb a7                	jmp    6bf5 <fwp_p_array_from_list_typed+0x65>
    6c4e:	31 ff                	xor    %edi,%edi
    6c50:	e8 3b 00 00 00       	call   6c90 <fwp_array_typed_new>
    6c55:	48 83 c4 08          	add    $0x8,%rsp
    6c59:	5b                   	pop    %rbx
    6c5a:	41 5e                	pop    %r14
    6c5c:	c3                   	ret
    6c5d:	e8 fe fd ff ff       	call   6a60 <fwp_flush>
    6c62:	48 8b 05 77 b3 00 00 	mov    0xb377(%rip),%rax        # 11fe0 <stderr@GLIBC_2.2.5>
    6c69:	48 8b 38             	mov    (%rax),%rdi
    6c6c:	48 8d 35 5a 88 00 00 	lea    0x885a(%rip),%rsi        # f4cd <fwp_segv.msg+0x24d>
    6c73:	48 8d 15 ab 89 00 00 	lea    0x89ab(%rip),%rdx        # f625 <fwp_segv.msg+0x3a5>
    6c7a:	31 c0                	xor    %eax,%eax
    6c7c:	e8 1f b5 ff ff       	call   21a0 <fprintf@plt>
    6c81:	bf 65 00 00 00       	mov    $0x65,%edi
    6c86:	e8 e5 b5 ff ff       	call   2270 <exit@plt>
    6c8b:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)

0000000000006c90 <fwp_array_typed_new>:
    6c90:	41 56                	push   %r14
    6c92:	53                   	push   %rbx
    6c93:	50                   	push   %rax
    6c94:	48 b8 ff ff ff ff ff 	movabs $0x1fffffffffffffff,%rax
    6c9b:	ff ff 1f 
    6c9e:	48 39 c7             	cmp    %rax,%rdi
    6ca1:	0f 83 21 02 00 00    	jae    6ec8 <fwp_array_typed_new+0x238>
    6ca7:	48 89 fb             	mov    %rdi,%rbx
    6caa:	48 85 f6             	test   %rsi,%rsi
    6cad:	74 23                	je     6cd2 <fwp_array_typed_new+0x42>
    6caf:	8b 06                	mov    (%rsi),%eax
    6cb1:	48 83 f8 0a          	cmp    $0xa,%rax
    6cb5:	77 0e                	ja     6cc5 <fwp_array_typed_new+0x35>
    6cb7:	b9 e7 04 00 00       	mov    $0x4e7,%ecx
    6cbc:	0f a3 c1             	bt     %eax,%ecx
    6cbf:	0f 82 93 00 00 00    	jb     6d58 <fwp_array_typed_new+0xc8>
    6cc5:	48 8d 0c dd 00 00 00 	lea    0x0(,%rbx,8),%rcx
    6ccc:	00 
    6ccd:	e9 95 00 00 00       	jmp    6d67 <fwp_array_typed_new+0xd7>
    6cd2:	48 8d 14 dd 08 00 00 	lea    0x8(,%rbx,8),%rdx
    6cd9:	00 
    6cda:	48 81 fa 00 40 00 00 	cmp    $0x4000,%rdx
    6ce1:	77 68                	ja     6d4b <fwp_array_typed_new+0xbb>
    6ce3:	48 8d 42 0f          	lea    0xf(%rdx),%rax
    6ce7:	48 c1 e8 04          	shr    $0x4,%rax
    6ceb:	48 8d 0d 76 b4 00 00 	lea    0xb476(%rip),%rcx        # 12168 <fwp_gc>
    6cf2:	0f b6 b4 08 e8 0b 00 	movzbl 0xbe8(%rax,%rcx,1),%esi
    6cf9:	00 
    6cfa:	8b 84 b1 48 0b 00 00 	mov    0xb48(%rcx,%rsi,4),%eax
    6d01:	48 29 05 60 b4 00 00 	sub    %rax,0xb460(%rip)        # 12168 <fwp_gc>
    6d08:	78 41                	js     6d4b <fwp_array_typed_new+0xbb>
    6d0a:	48 8d 34 76          	lea    (%rsi,%rsi,2),%rsi
    6d0e:	48 8d 3c f1          	lea    (%rcx,%rsi,8),%rdi
    6d12:	48 81 c7 88 07 00 00 	add    $0x788,%rdi
    6d19:	4c 8b 37             	mov    (%rdi),%r14
    6d1c:	4d 85 f6             	test   %r14,%r14
    6d1f:	74 0e                	je     6d2f <fwp_array_typed_new+0x9f>
    6d21:	49 8b 0e             	mov    (%r14),%rcx
    6d24:	48 f7 d1             	not    %rcx
    6d27:	48 89 0f             	mov    %rcx,(%rdi)
    6d2a:	e9 f8 00 00 00       	jmp    6e27 <fwp_array_typed_new+0x197>
    6d2f:	4c 8b b4 f1 90 07 00 	mov    0x790(%rcx,%rsi,8),%r14
    6d36:	00 
    6d37:	48 8b bc f1 98 07 00 	mov    0x798(%rcx,%rsi,8),%rdi
    6d3e:	00 
    6d3f:	4c 29 f7             	sub    %r14,%rdi
    6d42:	48 39 c7             	cmp    %rax,%rdi
    6d45:	0f 83 ca 00 00 00    	jae    6e15 <fwp_array_typed_new+0x185>
    6d4b:	48 89 d7             	mov    %rdx,%rdi
    6d4e:	be 02 00 00 00       	mov    $0x2,%esi
    6d53:	e9 9c 00 00 00       	jmp    6df4 <fwp_array_typed_new+0x164>
    6d58:	48 8d 0d 41 85 00 00 	lea    0x8541(%rip),%rcx        # f2a0 <fwp_segv.msg+0x20>
    6d5f:	48 8b 0c c1          	mov    (%rcx,%rax,8),%rcx
    6d63:	48 0f af cb          	imul   %rbx,%rcx
    6d67:	48 8d 51 08          	lea    0x8(%rcx),%rdx
    6d6b:	83 f8 0b             	cmp    $0xb,%eax
    6d6e:	0f 87 66 ff ff ff    	ja     6cda <fwp_array_typed_new+0x4a>
    6d74:	be ef 0d 00 00       	mov    $0xdef,%esi
    6d79:	0f a3 c6             	bt     %eax,%esi
    6d7c:	0f 83 58 ff ff ff    	jae    6cda <fwp_array_typed_new+0x4a>
    6d82:	48 81 f9 f8 3f 00 00 	cmp    $0x3ff8,%rcx
    6d89:	77 61                	ja     6dec <fwp_array_typed_new+0x15c>
    6d8b:	48 83 c1 17          	add    $0x17,%rcx
    6d8f:	48 c1 e9 04          	shr    $0x4,%rcx
    6d93:	48 8d 05 ce b3 00 00 	lea    0xb3ce(%rip),%rax        # 12168 <fwp_gc>
    6d9a:	0f b6 b4 01 e8 0b 00 	movzbl 0xbe8(%rcx,%rax,1),%esi
    6da1:	00 
    6da2:	8b 8c b0 48 0b 00 00 	mov    0xb48(%rax,%rsi,4),%ecx
    6da9:	48 29 0d b8 b3 00 00 	sub    %rcx,0xb3b8(%rip)        # 12168 <fwp_gc>
    6db0:	78 3a                	js     6dec <fwp_array_typed_new+0x15c>
    6db2:	48 8d 34 76          	lea    (%rsi,%rsi,2),%rsi
    6db6:	48 8d 3c f0          	lea    (%rax,%rsi,8),%rdi
    6dba:	48 81 c7 c8 03 00 00 	add    $0x3c8,%rdi
    6dc1:	4c 8b 37             	mov    (%rdi),%r14
    6dc4:	4d 85 f6             	test   %r14,%r14
    6dc7:	74 0b                	je     6dd4 <fwp_array_typed_new+0x144>
    6dc9:	49 8b 06             	mov    (%r14),%rax
    6dcc:	48 f7 d0             	not    %rax
    6dcf:	48 89 07             	mov    %rax,(%rdi)
    6dd2:	eb 3a                	jmp    6e0e <fwp_array_typed_new+0x17e>
    6dd4:	4c 8b b4 f0 d0 03 00 	mov    0x3d0(%rax,%rsi,8),%r14
    6ddb:	00 
    6ddc:	48 8b bc f0 d8 03 00 	mov    0x3d8(%rax,%rsi,8),%rdi
    6de3:	00 
    6de4:	4c 29 f7             	sub    %r14,%rdi
    6de7:	48 39 cf             	cmp    %rcx,%rdi
    6dea:	73 12                	jae    6dfe <fwp_array_typed_new+0x16e>
    6dec:	48 89 d7             	mov    %rdx,%rdi
    6def:	be 01 00 00 00       	mov    $0x1,%esi
    6df4:	e8 07 01 00 00       	call   6f00 <fwp_gc_alloc_slow>
    6df9:	49 89 c6             	mov    %rax,%r14
    6dfc:	eb 36                	jmp    6e34 <fwp_array_typed_new+0x1a4>
    6dfe:	48 8d 04 f0          	lea    (%rax,%rsi,8),%rax
    6e02:	48 05 d0 03 00 00    	add    $0x3d0,%rax
    6e08:	4c 01 f1             	add    %r14,%rcx
    6e0b:	48 89 08             	mov    %rcx,(%rax)
    6e0e:	4c 89 f7             	mov    %r14,%rdi
    6e11:	31 f6                	xor    %esi,%esi
    6e13:	eb 1a                	jmp    6e2f <fwp_array_typed_new+0x19f>
    6e15:	48 8d 0c f1          	lea    (%rcx,%rsi,8),%rcx
    6e19:	48 81 c1 90 07 00 00 	add    $0x790,%rcx
    6e20:	49 8d 14 06          	lea    (%r14,%rax,1),%rdx
    6e24:	48 89 11             	mov    %rdx,(%rcx)
    6e27:	4c 89 f7             	mov    %r14,%rdi
    6e2a:	31 f6                	xor    %esi,%esi
    6e2c:	48 89 c2             	mov    %rax,%rdx
    6e2f:	e8 ec b2 ff ff       	call   2120 <memset@plt>
    6e34:	49 89 1e             	mov    %rbx,(%r14)
    6e37:	4c 89 f0             	mov    %r14,%rax
    6e3a:	48 2b 05 57 c3 00 00 	sub    0xc357(%rip),%rax        # 13198 <fwp_gc+0x1030>
    6e41:	48 8b 0d 78 c3 00 00 	mov    0xc378(%rip),%rcx        # 131c0 <fwp_gc+0x1058>
    6e48:	48 c1 e1 10          	shl    $0x10,%rcx
    6e4c:	48 39 c8             	cmp    %rcx,%rax
    6e4f:	73 6c                	jae    6ebd <fwp_array_typed_new+0x22d>
    6e51:	48 8b 0d 88 c3 00 00 	mov    0xc388(%rip),%rcx        # 131e0 <fwp_gc+0x1078>
    6e58:	48 89 c2             	mov    %rax,%rdx
    6e5b:	48 c1 ea 10          	shr    $0x10,%rdx
    6e5f:	48 69 d2 28 12 00 00 	imul   $0x1228,%rdx,%rdx
    6e66:	0f b6 34 11          	movzbl (%rcx,%rdx,1),%esi
    6e6a:	48 25 ff ff 00 00    	and    $0xffff,%rax
    6e70:	75 1b                	jne    6e8d <fwp_array_typed_new+0x1fd>
    6e72:	40 80 fe 02          	cmp    $0x2,%sil
    6e76:	75 15                	jne    6e8d <fwp_array_typed_new+0x1fd>
    6e78:	48 8d 1c 11          	lea    (%rcx,%rdx,1),%rbx
    6e7c:	48 81 c3 28 02 00 00 	add    $0x228,%rbx
    6e83:	80 3b ff             	cmpb   $0xff,(%rbx)
    6e86:	74 2b                	je     6eb3 <fwp_array_typed_new+0x223>
    6e88:	c6 03 01             	movb   $0x1,(%rbx)
    6e8b:	eb 30                	jmp    6ebd <fwp_array_typed_new+0x22d>
    6e8d:	40 80 fe 01          	cmp    $0x1,%sil
    6e91:	75 2a                	jne    6ebd <fwp_array_typed_new+0x22d>
    6e93:	48 8d 34 11          	lea    (%rcx,%rdx,1),%rsi
    6e97:	8b 4c 11 20          	mov    0x20(%rcx,%rdx,1),%ecx
    6e9b:	48 0f af c1          	imul   %rcx,%rax
    6e9f:	48 c1 e8 20          	shr    $0x20,%rax
    6ea3:	48 8d 1c 30          	lea    (%rax,%rsi,1),%rbx
    6ea7:	48 81 c3 28 02 00 00 	add    $0x228,%rbx
    6eae:	80 3b ff             	cmpb   $0xff,(%rbx)
    6eb1:	75 d5                	jne    6e88 <fwp_array_typed_new+0x1f8>
    6eb3:	48 89 df             	mov    %rbx,%rdi
    6eb6:	e8 d5 fb ff ff       	call   6a90 <fwp_rc_forget_slot>
    6ebb:	eb cb                	jmp    6e88 <fwp_array_typed_new+0x1f8>
    6ebd:	4c 89 f0             	mov    %r14,%rax
    6ec0:	48 83 c4 08          	add    $0x8,%rsp
    6ec4:	5b                   	pop    %rbx
    6ec5:	41 5e                	pop    %r14
    6ec7:	c3                   	ret
    6ec8:	e8 93 fb ff ff       	call   6a60 <fwp_flush>
    6ecd:	48 8b 05 0c b1 00 00 	mov    0xb10c(%rip),%rax        # 11fe0 <stderr@GLIBC_2.2.5>
    6ed4:	48 8b 38             	mov    (%rax),%rdi
    6ed7:	48 8d 35 ef 85 00 00 	lea    0x85ef(%rip),%rsi        # f4cd <fwp_segv.msg+0x24d>
    6ede:	48 8d 15 1e 86 00 00 	lea    0x861e(%rip),%rdx        # f503 <fwp_segv.msg+0x283>
    6ee5:	31 c0                	xor    %eax,%eax
    6ee7:	e8 b4 b2 ff ff       	call   21a0 <fprintf@plt>
    6eec:	bf 65 00 00 00       	mov    $0x65,%edi
    6ef1:	e8 7a b3 ff ff       	call   2270 <exit@plt>
    6ef6:	66 2e 0f 1f 84 00 00 	cs nopw 0x0(%rax,%rax,1)
    6efd:	00 00 00 

0000000000006f00 <fwp_gc_alloc_slow>:
    6f00:	41 57                	push   %r15
    6f02:	41 56                	push   %r14
    6f04:	41 55                	push   %r13
    6f06:	41 54                	push   %r12
    6f08:	53                   	push   %rbx
    6f09:	89 f3                	mov    %esi,%ebx
    6f0b:	83 3d 42 c2 00 00 00 	cmpl   $0x0,0xc242(%rip)        # 13154 <fwp_gc+0xfec>
    6f12:	74 19                	je     6f2d <fwp_gc_alloc_slow+0x2d>
    6f14:	48 81 ff 01 40 00 00 	cmp    $0x4001,%rdi
    6f1b:	72 24                	jb     6f41 <fwp_gc_alloc_slow+0x41>
    6f1d:	89 de                	mov    %ebx,%esi
    6f1f:	5b                   	pop    %rbx
    6f20:	41 5c                	pop    %r12
    6f22:	41 5d                	pop    %r13
    6f24:	41 5e                	pop    %r14
    6f26:	41 5f                	pop    %r15
    6f28:	e9 d3 04 00 00       	jmp    7400 <fwp_gc_alloc_big>
    6f2d:	49 89 fe             	mov    %rdi,%r14
    6f30:	e8 5b 01 00 00       	call   7090 <fwp_gc_init>
    6f35:	4c 89 f7             	mov    %r14,%rdi
    6f38:	48 81 ff 01 40 00 00 	cmp    $0x4001,%rdi
    6f3f:	73 dc                	jae    6f1d <fwp_gc_alloc_slow+0x1d>
    6f41:	48 8d 47 0f          	lea    0xf(%rdi),%rax
    6f45:	48 c1 e8 04          	shr    $0x4,%rax
    6f49:	4c 8d 3d 18 b2 00 00 	lea    0xb218(%rip),%r15        # 12168 <fwp_gc>
    6f50:	46 0f b6 b4 38 e8 0b 	movzbl 0xbe8(%rax,%r15,1),%r14d
    6f57:	00 00 
    6f59:	43 8b 94 b7 48 0b 00 	mov    0xb48(%r15,%r14,4),%edx
    6f60:	00 
    6f61:	48 83 3d ff b1 00 00 	cmpq   $0x0,0xb1ff(%rip)        # 12168 <fwp_gc>
    6f68:	00 
    6f69:	0f 89 8c 00 00 00    	jns    6ffb <fwp_gc_alloc_slow+0xfb>
    6f6f:	83 3d de c1 00 00 00 	cmpl   $0x0,0xc1de(%rip)        # 13154 <fwp_gc+0xfec>
    6f76:	75 11                	jne    6f89 <fwp_gc_alloc_slow+0x89>
    6f78:	49 89 fc             	mov    %rdi,%r12
    6f7b:	49 89 d5             	mov    %rdx,%r13
    6f7e:	e8 0d 01 00 00       	call   7090 <fwp_gc_init>
    6f83:	4c 89 ea             	mov    %r13,%rdx
    6f86:	4c 89 e7             	mov    %r12,%rdi
    6f89:	8b 0d cd c1 00 00    	mov    0xc1cd(%rip),%ecx        # 1315c <fwp_gc+0xff4>
    6f8f:	85 c9                	test   %ecx,%ecx
    6f91:	74 2a                	je     6fbd <fwp_gc_alloc_slow+0xbd>
    6f93:	48 8b 05 ee c1 00 00 	mov    0xc1ee(%rip),%rax        # 13188 <fwp_gc+0x1020>
    6f9a:	48 85 c0             	test   %rax,%rax
    6f9d:	74 1e                	je     6fbd <fwp_gc_alloc_slow+0xbd>
    6f9f:	48 8b 0d ea c1 00 00 	mov    0xc1ea(%rip),%rcx        # 13190 <fwp_gc+0x1028>
    6fa6:	48 ff c1             	inc    %rcx
    6fa9:	48 89 0d e0 c1 00 00 	mov    %rcx,0xc1e0(%rip)        # 13190 <fwp_gc+0x1028>
    6fb0:	48 39 c1             	cmp    %rax,%rcx
    6fb3:	0f 8d c7 00 00 00    	jge    7080 <fwp_gc_alloc_slow+0x180>
    6fb9:	31 c0                	xor    %eax,%eax
    6fbb:	eb 0d                	jmp    6fca <fwp_gc_alloc_slow+0xca>
    6fbd:	b8 00 00 80 00       	mov    $0x800000,%eax
    6fc2:	85 c9                	test   %ecx,%ecx
    6fc4:	0f 85 b1 00 00 00    	jne    707b <fwp_gc_alloc_slow+0x17b>
    6fca:	48 8b 0d a7 c3 00 00 	mov    0xc3a7(%rip),%rcx        # 13378 <fwp_gc+0x1210>
    6fd1:	48 2b 0d 90 b1 00 00 	sub    0xb190(%rip),%rcx        # 12168 <fwp_gc>
    6fd8:	f2 48 0f 2a c1       	cvtsi2sd %rcx,%xmm0
    6fdd:	f2 0f 58 05 6b c3 00 	addsd  0xc36b(%rip),%xmm0        # 13350 <fwp_gc+0x11e8>
    6fe4:	00 
    6fe5:	f2 0f 11 05 63 c3 00 	movsd  %xmm0,0xc363(%rip)        # 13350 <fwp_gc+0x11e8>
    6fec:	00 
    6fed:	48 89 05 84 c3 00 00 	mov    %rax,0xc384(%rip)        # 13378 <fwp_gc+0x1210>
    6ff4:	48 89 05 6d b1 00 00 	mov    %rax,0xb16d(%rip)        # 12168 <fwp_gc>
    6ffb:	89 d8                	mov    %ebx,%eax
    6ffd:	48 69 c0 c0 03 00 00 	imul   $0x3c0,%rax,%rax
    7004:	49 01 c7             	add    %rax,%r15
    7007:	4b 8d 34 76          	lea    (%r14,%r14,2),%rsi
    700b:	49 8d 0c f7          	lea    (%r15,%rsi,8),%rcx
    700f:	48 83 c1 08          	add    $0x8,%rcx
    7013:	49 8b 44 f7 08       	mov    0x8(%r15,%rsi,8),%rax
    7018:	48 85 c0             	test   %rax,%rax
    701b:	74 08                	je     7025 <fwp_gc_alloc_slow+0x125>
    701d:	48 8b 30             	mov    (%rax),%rsi
    7020:	48 f7 d6             	not    %rsi
    7023:	eb 39                	jmp    705e <fwp_gc_alloc_slow+0x15e>
    7025:	49 8b 44 f7 10       	mov    0x10(%r15,%rsi,8),%rax
    702a:	4d 8b 44 f7 18       	mov    0x18(%r15,%rsi,8),%r8
    702f:	49 29 c0             	sub    %rax,%r8
    7032:	49 39 d0             	cmp    %rdx,%r8
    7035:	73 1b                	jae    7052 <fwp_gc_alloc_slow+0x152>
    7037:	49 89 ff             	mov    %rdi,%r15
    703a:	48 89 cf             	mov    %rcx,%rdi
    703d:	44 89 f6             	mov    %r14d,%esi
    7040:	49 89 d6             	mov    %rdx,%r14
    7043:	89 da                	mov    %ebx,%edx
    7045:	e8 e6 05 00 00       	call   7630 <fwp_gc_refill>
    704a:	4c 89 f2             	mov    %r14,%rdx
    704d:	4c 89 ff             	mov    %r15,%rdi
    7050:	eb 0f                	jmp    7061 <fwp_gc_alloc_slow+0x161>
    7052:	49 8d 0c f7          	lea    (%r15,%rsi,8),%rcx
    7056:	48 83 c1 10          	add    $0x10,%rcx
    705a:	48 8d 34 10          	lea    (%rax,%rdx,1),%rsi
    705e:	48 89 31             	mov    %rsi,(%rcx)
    7061:	83 fb 01             	cmp    $0x1,%ebx
    7064:	48 0f 44 d7          	cmove  %rdi,%rdx
    7068:	48 89 c7             	mov    %rax,%rdi
    706b:	31 f6                	xor    %esi,%esi
    706d:	5b                   	pop    %rbx
    706e:	41 5c                	pop    %r12
    7070:	41 5d                	pop    %r13
    7072:	41 5e                	pop    %r14
    7074:	41 5f                	pop    %r15
    7076:	e9 a5 b0 ff ff       	jmp    2120 <memset@plt>
    707b:	e8 30 08 00 00       	call   78b0 <fwp_gc_collect>
    7080:	48 c7 05 05 c1 00 00 	movq   $0x0,0xc105(%rip)        # 13190 <fwp_gc+0x1028>
    7087:	00 00 00 00 
    708b:	e8 20 08 00 00       	call   78b0 <fwp_gc_collect>

0000000000007090 <fwp_gc_init>:
    7090:	41 56                	push   %r14
    7092:	53                   	push   %rbx
    7093:	50                   	push   %rax
    7094:	c7 05 b6 c0 00 00 01 	movl   $0x1,0xc0b6(%rip)        # 13154 <fwp_gc+0xfec>
    709b:	00 00 00 
    709e:	0f 28 05 8b 7f 00 00 	movaps 0x7f8b(%rip),%xmm0        # f030 <_IO_stdin_used+0x30>
    70a5:	0f 11 05 04 bc 00 00 	movups %xmm0,0xbc04(%rip)        # 12cb0 <fwp_gc+0xb48>
    70ac:	0f 28 05 8d 7f 00 00 	movaps 0x7f8d(%rip),%xmm0        # f040 <_IO_stdin_used+0x40>
    70b3:	0f 11 05 06 bc 00 00 	movups %xmm0,0xbc06(%rip)        # 12cc0 <fwp_gc+0xb58>
    70ba:	0f 28 05 8f 7f 00 00 	movaps 0x7f8f(%rip),%xmm0        # f050 <_IO_stdin_used+0x50>
    70c1:	0f 11 05 08 bc 00 00 	movups %xmm0,0xbc08(%rip)        # 12cd0 <fwp_gc+0xb68>
    70c8:	0f 28 05 91 7f 00 00 	movaps 0x7f91(%rip),%xmm0        # f060 <_IO_stdin_used+0x60>
    70cf:	0f 11 05 0a bc 00 00 	movups %xmm0,0xbc0a(%rip)        # 12ce0 <fwp_gc+0xb78>
    70d6:	0f 28 05 93 7f 00 00 	movaps 0x7f93(%rip),%xmm0        # f070 <_IO_stdin_used+0x70>
    70dd:	0f 11 05 0c bc 00 00 	movups %xmm0,0xbc0c(%rip)        # 12cf0 <fwp_gc+0xb88>
    70e4:	0f 28 05 95 7f 00 00 	movaps 0x7f95(%rip),%xmm0        # f080 <_IO_stdin_used+0x80>
    70eb:	0f 11 05 0e bc 00 00 	movups %xmm0,0xbc0e(%rip)        # 12d00 <fwp_gc+0xb98>
    70f2:	0f 28 05 97 7f 00 00 	movaps 0x7f97(%rip),%xmm0        # f090 <_IO_stdin_used+0x90>
    70f9:	0f 11 05 10 bc 00 00 	movups %xmm0,0xbc10(%rip)        # 12d10 <fwp_gc+0xba8>
    7100:	0f 28 05 99 7f 00 00 	movaps 0x7f99(%rip),%xmm0        # f0a0 <_IO_stdin_used+0xa0>
    7107:	0f 11 05 12 bc 00 00 	movups %xmm0,0xbc12(%rip)        # 12d20 <fwp_gc+0xbb8>
    710e:	0f 28 05 9b 7f 00 00 	movaps 0x7f9b(%rip),%xmm0        # f0b0 <_IO_stdin_used+0xb0>
    7115:	0f 11 05 14 bc 00 00 	movups %xmm0,0xbc14(%rip)        # 12d30 <fwp_gc+0xbc8>
    711c:	0f 28 05 9d 7f 00 00 	movaps 0x7f9d(%rip),%xmm0        # f0c0 <_IO_stdin_used+0xc0>
    7123:	0f 11 05 16 bc 00 00 	movups %xmm0,0xbc16(%rip)        # 12d40 <fwp_gc+0xbd8>
    712a:	31 c9                	xor    %ecx,%ecx
    712c:	48 8d 05 35 b0 00 00 	lea    0xb035(%rip),%rax        # 12168 <fwp_gc>
    7133:	31 d2                	xor    %edx,%edx
    7135:	66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
    713c:	00 00 00 00 
    7140:	89 d6                	mov    %edx,%esi
    7142:	c1 e6 04             	shl    $0x4,%esi
    7145:	48 ff c9             	dec    %rcx
    7148:	48 89 cf             	mov    %rcx,%rdi
    714b:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)
    7150:	48 89 f9             	mov    %rdi,%rcx
    7153:	48 ff c7             	inc    %rdi
    7156:	3b b4 88 4c 0b 00 00 	cmp    0xb4c(%rax,%rcx,4),%esi
    715d:	77 f1                	ja     7150 <fwp_gc_init+0xc0>
    715f:	40 88 bc 02 e8 0b 00 	mov    %dil,0xbe8(%rdx,%rax,1)
    7166:	00 
    7167:	48 89 d6             	mov    %rdx,%rsi
    716a:	48 83 ce 01          	or     $0x1,%rsi
    716e:	48 81 fe 01 04 00 00 	cmp    $0x401,%rsi
    7175:	74 26                	je     719d <fwp_gc_init+0x10d>
    7177:	89 f7                	mov    %esi,%edi
    7179:	c1 e7 04             	shl    $0x4,%edi
    717c:	0f 1f 40 00          	nopl   0x0(%rax)
    7180:	49 89 c8             	mov    %rcx,%r8
    7183:	48 ff c1             	inc    %rcx
    7186:	42 3b bc 80 4c 0b 00 	cmp    0xb4c(%rax,%r8,4),%edi
    718d:	00 
    718e:	77 f0                	ja     7180 <fwp_gc_init+0xf0>
    7190:	88 8c 06 e8 0b 00 00 	mov    %cl,0xbe8(%rsi,%rax,1)
    7197:	48 83 c2 02          	add    $0x2,%rdx
    719b:	eb a3                	jmp    7140 <fwp_gc_init+0xb0>
    719d:	e8 8e b9 ff ff       	call   2b30 <fwp_static_init>
    71a2:	48 8b 05 47 d2 00 00 	mov    0xd247(%rip),%rax        # 143f0 <fwp_static+0x850>
    71a9:	48 89 05 e8 bf 00 00 	mov    %rax,0xbfe8(%rip)        # 13198 <fwp_gc+0x1030>
    71b0:	48 8b 05 49 d2 00 00 	mov    0xd249(%rip),%rax        # 14400 <fwp_static+0x860>
    71b7:	48 c1 e8 10          	shr    $0x10,%rax
    71bb:	48 89 05 f6 bf 00 00 	mov    %rax,0xbff6(%rip)        # 131b8 <fwp_gc+0x1050>
    71c2:	48 8b 0d 3f d2 00 00 	mov    0xd23f(%rip),%rcx        # 14408 <fwp_static+0x868>
    71c9:	48 89 0d 18 c0 00 00 	mov    %rcx,0xc018(%rip)        # 131e8 <fwp_gc+0x1080>
    71d0:	48 8b 0d 21 d2 00 00 	mov    0xd221(%rip),%rcx        # 143f8 <fwp_static+0x858>
    71d7:	48 89 0d 02 c0 00 00 	mov    %rcx,0xc002(%rip)        # 131e0 <fwp_gc+0x1078>
    71de:	48 89 05 e3 bf 00 00 	mov    %rax,0xbfe3(%rip)        # 131c8 <fwp_gc+0x1060>
    71e5:	48 8d 3d 27 83 00 00 	lea    0x8327(%rip),%rdi        # f513 <fwp_segv.msg+0x293>
    71ec:	e8 3f ae ff ff       	call   2030 <getenv@plt>
    71f1:	48 85 c0             	test   %rax,%rax
    71f4:	74 2e                	je     7224 <fwp_gc_init+0x194>
    71f6:	48 89 c3             	mov    %rax,%rbx
    71f9:	48 8d 35 1a 83 00 00 	lea    0x831a(%rip),%rsi        # f51a <fwp_segv.msg+0x29a>
    7200:	48 89 c7             	mov    %rax,%rdi
    7203:	e8 68 af ff ff       	call   2170 <strcmp@plt>
    7208:	85 c0                	test   %eax,%eax
    720a:	74 1f                	je     722b <fwp_gc_init+0x19b>
    720c:	48 8d 35 f6 84 00 00 	lea    0x84f6(%rip),%rsi        # f709 <fwp_segv.msg+0x489>
    7213:	48 89 df             	mov    %rbx,%rdi
    7216:	e8 55 af ff ff       	call   2170 <strcmp@plt>
    721b:	31 c9                	xor    %ecx,%ecx
    721d:	85 c0                	test   %eax,%eax
    721f:	0f 95 c1             	setne  %cl
    7222:	eb 09                	jmp    722d <fwp_gc_init+0x19d>
    7224:	b9 01 00 00 00       	mov    $0x1,%ecx
    7229:	eb 02                	jmp    722d <fwp_gc_init+0x19d>
    722b:	31 c9                	xor    %ecx,%ecx
    722d:	89 0d 25 bf 00 00    	mov    %ecx,0xbf25(%rip)        # 13158 <fwp_gc+0xff0>
    7233:	48 8d 3d e4 82 00 00 	lea    0x82e4(%rip),%rdi        # f51e <fwp_segv.msg+0x29e>
    723a:	e8 f1 ad ff ff       	call   2030 <getenv@plt>
    723f:	31 c9                	xor    %ecx,%ecx
    7241:	48 85 c0             	test   %rax,%rax
    7244:	74 1b                	je     7261 <fwp_gc_init+0x1d1>
    7246:	80 38 00             	cmpb   $0x0,(%rax)
    7249:	74 16                	je     7261 <fwp_gc_init+0x1d1>
    724b:	48 8d 35 b7 84 00 00 	lea    0x84b7(%rip),%rsi        # f709 <fwp_segv.msg+0x489>
    7252:	48 89 c7             	mov    %rax,%rdi
    7255:	e8 16 af ff ff       	call   2170 <strcmp@plt>
    725a:	31 c9                	xor    %ecx,%ecx
    725c:	85 c0                	test   %eax,%eax
    725e:	0f 95 c1             	setne  %cl
    7261:	89 0d fd be 00 00    	mov    %ecx,0xbefd(%rip)        # 13164 <fwp_gc+0xffc>
    7267:	48 8d 3d a5 82 00 00 	lea    0x82a5(%rip),%rdi        # f513 <fwp_segv.msg+0x293>
    726e:	e8 bd ad ff ff       	call   2030 <getenv@plt>
    7273:	48 85 c0             	test   %rax,%rax
    7276:	74 18                	je     7290 <fwp_gc_init+0x200>
    7278:	48 8d 35 ac 82 00 00 	lea    0x82ac(%rip),%rsi        # f52b <fwp_segv.msg+0x2ab>
    727f:	48 89 c7             	mov    %rax,%rdi
    7282:	e8 e9 ae ff ff       	call   2170 <strcmp@plt>
    7287:	31 c9                	xor    %ecx,%ecx
    7289:	85 c0                	test   %eax,%eax
    728b:	0f 95 c1             	setne  %cl
    728e:	eb 05                	jmp    7295 <fwp_gc_init+0x205>
    7290:	b9 01 00 00 00       	mov    $0x1,%ecx
    7295:	89 0d cd be 00 00    	mov    %ecx,0xbecd(%rip)        # 13168 <fwp_gc+0x1000>
    729b:	c7 05 cb be 00 00 01 	movl   $0x1,0xbecb(%rip)        # 13170 <fwp_gc+0x1008>
    72a2:	00 00 00 
    72a5:	48 8d 3d 84 82 00 00 	lea    0x8284(%rip),%rdi        # f530 <fwp_segv.msg+0x2b0>
    72ac:	e8 7f ad ff ff       	call   2030 <getenv@plt>
    72b1:	31 c9                	xor    %ecx,%ecx
    72b3:	48 85 c0             	test   %rax,%rax
    72b6:	74 1b                	je     72d3 <fwp_gc_init+0x243>
    72b8:	80 38 00             	cmpb   $0x0,(%rax)
    72bb:	74 16                	je     72d3 <fwp_gc_init+0x243>
    72bd:	48 8d 35 45 84 00 00 	lea    0x8445(%rip),%rsi        # f709 <fwp_segv.msg+0x489>
    72c4:	48 89 c7             	mov    %rax,%rdi
    72c7:	e8 a4 ae ff ff       	call   2170 <strcmp@plt>
    72cc:	31 c9                	xor    %ecx,%ecx
    72ce:	85 c0                	test   %eax,%eax
    72d0:	0f 95 c1             	setne  %cl
    72d3:	89 0d 93 be 00 00    	mov    %ecx,0xbe93(%rip)        # 1316c <fwp_gc+0x1004>
    72d9:	48 8d 3d 5e 82 00 00 	lea    0x825e(%rip),%rdi        # f53e <fwp_segv.msg+0x2be>
    72e0:	e8 4b ad ff ff       	call   2030 <getenv@plt>
    72e5:	48 85 c0             	test   %rax,%rax
    72e8:	74 14                	je     72fe <fwp_gc_init+0x26e>
    72ea:	48 89 c7             	mov    %rax,%rdi
    72ed:	31 f6                	xor    %esi,%esi
    72ef:	ba 0a 00 00 00       	mov    $0xa,%edx
    72f4:	e8 c7 ae ff ff       	call   21c0 <strtol@plt>
    72f9:	48 89 c3             	mov    %rax,%rbx
    72fc:	eb 02                	jmp    7300 <fwp_gc_init+0x270>
    72fe:	31 db                	xor    %ebx,%ebx
    7300:	31 c0                	xor    %eax,%eax
    7302:	48 85 db             	test   %rbx,%rbx
    7305:	48 0f 4f c3          	cmovg  %rbx,%rax
    7309:	48 89 05 78 be 00 00 	mov    %rax,0xbe78(%rip)        # 13188 <fwp_gc+0x1020>
    7310:	48 8d 3d fc 81 00 00 	lea    0x81fc(%rip),%rdi        # f513 <fwp_segv.msg+0x293>
    7317:	e8 14 ad ff ff       	call   2030 <getenv@plt>
    731c:	48 85 c0             	test   %rax,%rax
    731f:	74 2e                	je     734f <fwp_gc_init+0x2bf>
    7321:	49 89 c6             	mov    %rax,%r14
    7324:	80 38 00             	cmpb   $0x0,(%rax)
    7327:	74 26                	je     734f <fwp_gc_init+0x2bf>
    7329:	48 8d 35 ea 81 00 00 	lea    0x81ea(%rip),%rsi        # f51a <fwp_segv.msg+0x29a>
    7330:	4c 89 f7             	mov    %r14,%rdi
    7333:	e8 38 ae ff ff       	call   2170 <strcmp@plt>
    7338:	85 c0                	test   %eax,%eax
    733a:	74 13                	je     734f <fwp_gc_init+0x2bf>
    733c:	48 8d 35 c6 83 00 00 	lea    0x83c6(%rip),%rsi        # f709 <fwp_segv.msg+0x489>
    7343:	4c 89 f7             	mov    %r14,%rdi
    7346:	e8 25 ae ff ff       	call   2170 <strcmp@plt>
    734b:	85 c0                	test   %eax,%eax
    734d:	75 5f                	jne    73ae <fwp_gc_init+0x31e>
    734f:	48 85 db             	test   %rbx,%rbx
    7352:	7f 5a                	jg     73ae <fwp_gc_init+0x31e>
    7354:	83 3d 11 be 00 00 00 	cmpl   $0x0,0xbe11(%rip)        # 1316c <fwp_gc+0x1004>
    735b:	75 51                	jne    73ae <fwp_gc_init+0x31e>
    735d:	48 8d 3d 25 82 00 00 	lea    0x8225(%rip),%rdi        # f589 <fwp_segv.msg+0x309>
    7364:	e8 c7 ac ff ff       	call   2030 <getenv@plt>
    7369:	48 85 c0             	test   %rax,%rax
    736c:	74 18                	je     7386 <fwp_gc_init+0x2f6>
    736e:	80 38 00             	cmpb   $0x0,(%rax)
    7371:	74 13                	je     7386 <fwp_gc_init+0x2f6>
    7373:	48 8d 35 8f 83 00 00 	lea    0x838f(%rip),%rsi        # f709 <fwp_segv.msg+0x489>
    737a:	48 89 c7             	mov    %rax,%rdi
    737d:	e8 ee ad ff ff       	call   2170 <strcmp@plt>
    7382:	85 c0                	test   %eax,%eax
    7384:	75 56                	jne    73dc <fwp_gc_init+0x34c>
    7386:	c7 05 c8 bd 00 00 00 	movl   $0x0,0xbdc8(%rip)        # 13158 <fwp_gc+0xff0>
    738d:	00 00 00 
    7390:	48 c7 05 dd bf 00 00 	movq   $0x800000,0xbfdd(%rip)        # 13378 <fwp_gc+0x1210>
    7397:	00 00 80 00 
    739b:	48 c7 05 c2 ad 00 00 	movq   $0x800000,0xadc2(%rip)        # 12168 <fwp_gc>
    73a2:	00 00 80 00 
    73a6:	48 83 c4 08          	add    $0x8,%rsp
    73aa:	5b                   	pop    %rbx
    73ab:	41 5e                	pop    %r14
    73ad:	c3                   	ret
    73ae:	e8 ad f6 ff ff       	call   6a60 <fwp_flush>
    73b3:	48 8b 05 26 ac 00 00 	mov    0xac26(%rip),%rax        # 11fe0 <stderr@GLIBC_2.2.5>
    73ba:	48 8b 38             	mov    (%rax),%rdi
    73bd:	48 8d 35 09 81 00 00 	lea    0x8109(%rip),%rsi        # f4cd <fwp_segv.msg+0x24d>
    73c4:	48 8d 15 81 81 00 00 	lea    0x8181(%rip),%rdx        # f54c <fwp_segv.msg+0x2cc>
    73cb:	31 c0                	xor    %eax,%eax
    73cd:	e8 ce ad ff ff       	call   21a0 <fprintf@plt>
    73d2:	bf 65 00 00 00       	mov    $0x65,%edi
    73d7:	e8 94 ae ff ff       	call   2270 <exit@plt>
    73dc:	e8 7f f6 ff ff       	call   6a60 <fwp_flush>
    73e1:	48 8b 05 f8 ab 00 00 	mov    0xabf8(%rip),%rax        # 11fe0 <stderr@GLIBC_2.2.5>
    73e8:	48 8b 38             	mov    (%rax),%rdi
    73eb:	48 8d 35 db 80 00 00 	lea    0x80db(%rip),%rsi        # f4cd <fwp_segv.msg+0x24d>
    73f2:	48 8d 15 a1 81 00 00 	lea    0x81a1(%rip),%rdx        # f59a <fwp_segv.msg+0x31a>
    73f9:	eb d0                	jmp    73cb <fwp_gc_init+0x33b>
    73fb:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)

0000000000007400 <fwp_gc_alloc_big>:
    7400:	55                   	push   %rbp
    7401:	41 57                	push   %r15
    7403:	41 56                	push   %r14
    7405:	41 55                	push   %r13
    7407:	41 54                	push   %r12
    7409:	53                   	push   %rbx
    740a:	50                   	push   %rax
    740b:	48 b8 01 00 00 00 00 	movabs $0x4000000000000001,%rax
    7412:	00 00 40 
    7415:	48 39 c7             	cmp    %rax,%rdi
    7418:	0f 83 ce 01 00 00    	jae    75ec <fwp_gc_alloc_big+0x1ec>
    741e:	89 f5                	mov    %esi,%ebp
    7420:	48 89 fb             	mov    %rdi,%rbx
    7423:	48 29 3d 3e ad 00 00 	sub    %rdi,0xad3e(%rip)        # 12168 <fwp_gc>
    742a:	0f 89 80 00 00 00    	jns    74b0 <fwp_gc_alloc_big+0xb0>
    7430:	83 3d 1d bd 00 00 00 	cmpl   $0x0,0xbd1d(%rip)        # 13154 <fwp_gc+0xfec>
    7437:	75 05                	jne    743e <fwp_gc_alloc_big+0x3e>
    7439:	e8 52 fc ff ff       	call   7090 <fwp_gc_init>
    743e:	8b 0d 18 bd 00 00    	mov    0xbd18(%rip),%ecx        # 1315c <fwp_gc+0xff4>
    7444:	85 c9                	test   %ecx,%ecx
    7446:	74 2a                	je     7472 <fwp_gc_alloc_big+0x72>
    7448:	48 8b 05 39 bd 00 00 	mov    0xbd39(%rip),%rax        # 13188 <fwp_gc+0x1020>
    744f:	48 85 c0             	test   %rax,%rax
    7452:	74 1e                	je     7472 <fwp_gc_alloc_big+0x72>
    7454:	48 8b 0d 35 bd 00 00 	mov    0xbd35(%rip),%rcx        # 13190 <fwp_gc+0x1028>
    745b:	48 ff c1             	inc    %rcx
    745e:	48 89 0d 2b bd 00 00 	mov    %rcx,0xbd2b(%rip)        # 13190 <fwp_gc+0x1028>
    7465:	48 39 c1             	cmp    %rax,%rcx
    7468:	0f 8d ad 01 00 00    	jge    761b <fwp_gc_alloc_big+0x21b>
    746e:	31 c0                	xor    %eax,%eax
    7470:	eb 0d                	jmp    747f <fwp_gc_alloc_big+0x7f>
    7472:	b8 00 00 80 00       	mov    $0x800000,%eax
    7477:	85 c9                	test   %ecx,%ecx
    7479:	0f 85 97 01 00 00    	jne    7616 <fwp_gc_alloc_big+0x216>
    747f:	48 8b 0d f2 be 00 00 	mov    0xbef2(%rip),%rcx        # 13378 <fwp_gc+0x1210>
    7486:	48 2b 0d db ac 00 00 	sub    0xacdb(%rip),%rcx        # 12168 <fwp_gc>
    748d:	f2 48 0f 2a c1       	cvtsi2sd %rcx,%xmm0
    7492:	f2 0f 58 05 b6 be 00 	addsd  0xbeb6(%rip),%xmm0        # 13350 <fwp_gc+0x11e8>
    7499:	00 
    749a:	f2 0f 11 05 ae be 00 	movsd  %xmm0,0xbeae(%rip)        # 13350 <fwp_gc+0x11e8>
    74a1:	00 
    74a2:	48 89 05 cf be 00 00 	mov    %rax,0xbecf(%rip)        # 13378 <fwp_gc+0x1210>
    74a9:	48 89 05 b8 ac 00 00 	mov    %rax,0xacb8(%rip)        # 12168 <fwp_gc>
    74b0:	4c 8d b3 ff ff 00 00 	lea    0xffff(%rbx),%r14
    74b7:	49 c1 ee 10          	shr    $0x10,%r14
    74bb:	4c 89 f7             	mov    %r14,%rdi
    74be:	e8 9d 02 00 00       	call   7760 <fwp_gc_chunks>
    74c3:	48 8b 0d 16 bd 00 00 	mov    0xbd16(%rip),%rcx        # 131e0 <fwp_gc+0x1078>
    74ca:	4c 69 e0 28 12 00 00 	imul   $0x1228,%rax,%r12
    74d1:	42 c6 04 21 02       	movb   $0x2,(%rcx,%r12,1)
    74d6:	42 88 6c 21 01       	mov    %bpl,0x1(%rcx,%r12,1)
    74db:	66 42 c7 44 21 03 00 	movw   $0x100,0x3(%rcx,%r12,1)
    74e2:	01 
    74e3:	46 89 74 21 10       	mov    %r14d,0x10(%rcx,%r12,1)
    74e8:	4a 89 5c 21 18       	mov    %rbx,0x18(%rcx,%r12,1)
    74ed:	4e 8d 3c 21          	lea    (%rcx,%r12,1),%r15
    74f1:	49 81 c7 28 02 00 00 	add    $0x228,%r15
    74f8:	42 80 bc 21 28 02 00 	cmpb   $0xff,0x228(%rcx,%r12,1)
    74ff:	00 ff 
    7501:	0f 84 d2 00 00 00    	je     75d9 <fwp_gc_alloc_big+0x1d9>
    7507:	41 c6 07 00          	movb   $0x0,(%r15)
    750b:	48 81 fb 01 00 01 00 	cmp    $0x10001,%rbx
    7512:	0f 82 9b 00 00 00    	jb     75b3 <fwp_gc_alloc_big+0x1b3>
    7518:	49 83 fe 03          	cmp    $0x3,%r14
    751c:	ba 02 00 00 00       	mov    $0x2,%edx
    7521:	49 0f 43 d6          	cmovae %r14,%rdx
    7525:	48 8b 0d b4 bc 00 00 	mov    0xbcb4(%rip),%rcx        # 131e0 <fwp_gc+0x1078>
    752c:	48 ff ca             	dec    %rdx
    752f:	be 01 00 00 00       	mov    $0x1,%esi
    7534:	48 81 fb 01 00 02 00 	cmp    $0x20001,%rbx
    753b:	72 5a                	jb     7597 <fwp_gc_alloc_big+0x197>
    753d:	49 8d 3c 0c          	lea    (%r12,%rcx,1),%rdi
    7541:	48 81 c7 60 24 00 00 	add    $0x2460,%rdi
    7548:	49 89 d0             	mov    %rdx,%r8
    754b:	49 83 e0 fe          	and    $0xfffffffffffffffe,%r8
    754f:	49 f7 d8             	neg    %r8
    7552:	66 66 66 66 66 2e 0f 	data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    7559:	1f 84 00 00 00 00 00 
    7560:	c6 87 c8 ed ff ff 03 	movb   $0x3,-0x1238(%rdi)
    7567:	c6 87 cc ed ff ff 01 	movb   $0x1,-0x1234(%rdi)
    756e:	89 87 d8 ed ff ff    	mov    %eax,-0x1228(%rdi)
    7574:	c6 47 f0 03          	movb   $0x3,-0x10(%rdi)
    7578:	c6 47 f4 01          	movb   $0x1,-0xc(%rdi)
    757c:	89 07                	mov    %eax,(%rdi)
    757e:	48 81 c7 50 24 00 00 	add    $0x2450,%rdi
    7585:	4d 8d 0c 30          	lea    (%r8,%rsi,1),%r9
    7589:	49 83 c1 02          	add    $0x2,%r9
    758d:	48 83 c6 02          	add    $0x2,%rsi
    7591:	49 83 f9 01          	cmp    $0x1,%r9
    7595:	75 c9                	jne    7560 <fwp_gc_alloc_big+0x160>
    7597:	f6 c2 01             	test   $0x1,%dl
    759a:	74 17                	je     75b3 <fwp_gc_alloc_big+0x1b3>
    759c:	4c 01 e1             	add    %r12,%rcx
    759f:	48 69 d6 28 12 00 00 	imul   $0x1228,%rsi,%rdx
    75a6:	c6 04 11 03          	movb   $0x3,(%rcx,%rdx,1)
    75aa:	c6 44 11 04 01       	movb   $0x1,0x4(%rcx,%rdx,1)
    75af:	89 44 11 10          	mov    %eax,0x10(%rcx,%rdx,1)
    75b3:	48 c1 e0 10          	shl    $0x10,%rax
    75b7:	48 03 05 da bb 00 00 	add    0xbbda(%rip),%rax        # 13198 <fwp_gc+0x1030>
    75be:	48 89 c7             	mov    %rax,%rdi
    75c1:	31 f6                	xor    %esi,%esi
    75c3:	48 89 da             	mov    %rbx,%rdx
    75c6:	48 83 c4 08          	add    $0x8,%rsp
    75ca:	5b                   	pop    %rbx
    75cb:	41 5c                	pop    %r12
    75cd:	41 5d                	pop    %r13
    75cf:	41 5e                	pop    %r14
    75d1:	41 5f                	pop    %r15
    75d3:	5d                   	pop    %rbp
    75d4:	e9 47 ab ff ff       	jmp    2120 <memset@plt>
    75d9:	4c 89 ff             	mov    %r15,%rdi
    75dc:	49 89 c5             	mov    %rax,%r13
    75df:	e8 ac f4 ff ff       	call   6a90 <fwp_rc_forget_slot>
    75e4:	4c 89 e8             	mov    %r13,%rax
    75e7:	e9 1b ff ff ff       	jmp    7507 <fwp_gc_alloc_big+0x107>
    75ec:	48 8b 05 ed a9 00 00 	mov    0xa9ed(%rip),%rax        # 11fe0 <stderr@GLIBC_2.2.5>
    75f3:	48 8b 08             	mov    (%rax),%rcx
    75f6:	48 8d 3d dc 7f 00 00 	lea    0x7fdc(%rip),%rdi        # f5d9 <fwp_segv.msg+0x359>
    75fd:	be 13 00 00 00       	mov    $0x13,%esi
    7602:	ba 01 00 00 00       	mov    $0x1,%edx
    7607:	e8 74 ac ff ff       	call   2280 <fwrite@plt>
    760c:	bf 66 00 00 00       	mov    $0x66,%edi
    7611:	e8 5a ac ff ff       	call   2270 <exit@plt>
    7616:	e8 95 02 00 00       	call   78b0 <fwp_gc_collect>
    761b:	48 c7 05 6a bb 00 00 	movq   $0x0,0xbb6a(%rip)        # 13190 <fwp_gc+0x1028>
    7622:	00 00 00 00 
    7626:	e8 85 02 00 00       	call   78b0 <fwp_gc_collect>
    762b:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)

0000000000007630 <fwp_gc_refill>:
    7630:	55                   	push   %rbp
    7631:	41 57                	push   %r15
    7633:	41 56                	push   %r14
    7635:	41 55                	push   %r13
    7637:	41 54                	push   %r12
    7639:	53                   	push   %rbx
    763a:	50                   	push   %rax
    763b:	89 d5                	mov    %edx,%ebp
    763d:	41 89 f7             	mov    %esi,%r15d
    7640:	48 89 fb             	mov    %rdi,%rbx
    7643:	bf 01 00 00 00       	mov    $0x1,%edi
    7648:	e8 13 01 00 00       	call   7760 <fwp_gc_chunks>
    764d:	49 89 c6             	mov    %rax,%r14
    7650:	4c 8b 25 89 bb 00 00 	mov    0xbb89(%rip),%r12        # 131e0 <fwp_gc+0x1078>
    7657:	48 8d 05 0a ab 00 00 	lea    0xab0a(%rip),%rax        # 12168 <fwp_gc>
    765e:	4d 69 ee 28 12 00 00 	imul   $0x1228,%r14,%r13
    7665:	43 c6 04 2c 01       	movb   $0x1,(%r12,%r13,1)
    766a:	43 88 6c 2c 01       	mov    %bpl,0x1(%r12,%r13,1)
    766f:	47 88 7c 2c 02       	mov    %r15b,0x2(%r12,%r13,1)
    7674:	43 c6 44 2c 04 01    	movb   $0x1,0x4(%r12,%r13,1)
    767a:	44 89 f9             	mov    %r15d,%ecx
    767d:	8b 8c 88 48 0b 00 00 	mov    0xb48(%rax,%rcx,4),%ecx
    7684:	43 89 4c 2c 08       	mov    %ecx,0x8(%r12,%r13,1)
    7689:	b8 00 00 01 00       	mov    $0x10000,%eax
    768e:	31 d2                	xor    %edx,%edx
    7690:	f7 f1                	div    %ecx
    7692:	43 89 44 2c 0c       	mov    %eax,0xc(%r12,%r13,1)
    7697:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    769c:	48 01 c8             	add    %rcx,%rax
    769f:	48 0f ba e0 20       	bt     $0x20,%rax
    76a4:	73 07                	jae    76ad <fwp_gc_refill+0x7d>
    76a6:	31 d2                	xor    %edx,%edx
    76a8:	48 f7 f1             	div    %rcx
    76ab:	eb 04                	jmp    76b1 <fwp_gc_refill+0x81>
    76ad:	31 d2                	xor    %edx,%edx
    76af:	f7 f1                	div    %ecx
    76b1:	43 89 44 2c 20       	mov    %eax,0x20(%r12,%r13,1)
    76b6:	48 83 3d c2 c4 00 00 	cmpq   $0x0,0xc4c2(%rip)        # 13b80 <fwp_gc+0x1a18>
    76bd:	00 
    76be:	74 2e                	je     76ee <fwp_gc_refill+0xbe>
    76c0:	4f 8d 3c 2c          	lea    (%r12,%r13,1),%r15
    76c4:	49 81 c7 28 02 00 00 	add    $0x228,%r15
    76cb:	31 ed                	xor    %ebp,%ebp
    76cd:	eb 0d                	jmp    76dc <fwp_gc_refill+0xac>
    76cf:	90                   	nop
    76d0:	48 ff c5             	inc    %rbp
    76d3:	48 81 fd 00 10 00 00 	cmp    $0x1000,%rbp
    76da:	74 12                	je     76ee <fwp_gc_refill+0xbe>
    76dc:	41 80 3c 2f ff       	cmpb   $0xff,(%r15,%rbp,1)
    76e1:	75 ed                	jne    76d0 <fwp_gc_refill+0xa0>
    76e3:	49 8d 3c 2f          	lea    (%r15,%rbp,1),%rdi
    76e7:	e8 a4 f3 ff ff       	call   6a90 <fwp_rc_forget_slot>
    76ec:	eb e2                	jmp    76d0 <fwp_gc_refill+0xa0>
    76ee:	4f 8d 3c 2c          	lea    (%r12,%r13,1),%r15
    76f2:	49 83 c7 08          	add    $0x8,%r15
    76f6:	4b 8d 3c 2c          	lea    (%r12,%r13,1),%rdi
    76fa:	48 81 c7 28 02 00 00 	add    $0x228,%rdi
    7701:	ba 00 10 00 00       	mov    $0x1000,%edx
    7706:	31 f6                	xor    %esi,%esi
    7708:	e8 13 aa ff ff       	call   2120 <memset@plt>
    770d:	49 c1 e6 10          	shl    $0x10,%r14
    7711:	4c 03 35 80 ba 00 00 	add    0xba80(%rip),%r14        # 13198 <fwp_gc+0x1030>
    7718:	83 3d 4d ba 00 00 00 	cmpl   $0x0,0xba4d(%rip)        # 1316c <fwp_gc+0x1004>
    771f:	74 0f                	je     7730 <fwp_gc_refill+0x100>
    7721:	ba 00 00 01 00       	mov    $0x10000,%edx
    7726:	4c 89 f7             	mov    %r14,%rdi
    7729:	31 f6                	xor    %esi,%esi
    772b:	e8 f0 a9 ff ff       	call   2120 <memset@plt>
    7730:	41 8b 07             	mov    (%r15),%eax
    7733:	49 8d 0c 06          	lea    (%r14,%rax,1),%rcx
    7737:	48 89 4b 08          	mov    %rcx,0x8(%rbx)
    773b:	41 8b 4f 04          	mov    0x4(%r15),%ecx
    773f:	48 0f af c8          	imul   %rax,%rcx
    7743:	4c 01 f1             	add    %r14,%rcx
    7746:	48 89 4b 10          	mov    %rcx,0x10(%rbx)
    774a:	4c 89 f0             	mov    %r14,%rax
    774d:	48 83 c4 08          	add    $0x8,%rsp
    7751:	5b                   	pop    %rbx
    7752:	41 5c                	pop    %r12
    7754:	41 5d                	pop    %r13
    7756:	41 5e                	pop    %r14
    7758:	41 5f                	pop    %r15
    775a:	5d                   	pop    %rbp
    775b:	c3                   	ret
    775c:	0f 1f 40 00          	nopl   0x0(%rax)

0000000000007760 <fwp_gc_chunks>:
    7760:	53                   	push   %rbx
    7761:	48 81 ec d0 00 00 00 	sub    $0xd0,%rsp
    7768:	31 d2                	xor    %edx,%edx
    776a:	48 83 ff 01          	cmp    $0x1,%rdi
    776e:	0f 95 c2             	setne  %dl
    7771:	48 8d 35 f0 a9 00 00 	lea    0xa9f0(%rip),%rsi        # 12168 <fwp_gc>
    7778:	48 8b 8c d6 68 10 00 	mov    0x1068(%rsi,%rdx,8),%rcx
    777f:	00 
    7780:	48 8b 05 39 ba 00 00 	mov    0xba39(%rip),%rax        # 131c0 <fwp_gc+0x1058>
    7787:	49 89 ca             	mov    %rcx,%r10
    778a:	49 29 c2             	sub    %rax,%r10
    778d:	73 5f                	jae    77ee <fwp_gc_chunks+0x8e>
    778f:	4c 8d 0c d5 68 10 00 	lea    0x1068(,%rdx,8),%r9
    7796:	00 
    7797:	4c 69 d9 28 12 00 00 	imul   $0x1228,%rcx,%r11
    779e:	4c 03 1d 3b ba 00 00 	add    0xba3b(%rip),%r11        # 131e0 <fwp_gc+0x1078>
    77a5:	45 31 c0             	xor    %r8d,%r8d
    77a8:	31 d2                	xor    %edx,%edx
    77aa:	eb 15                	jmp    77c1 <fwp_gc_chunks+0x61>
    77ac:	0f 1f 40 00          	nopl   0x0(%rax)
    77b0:	31 d2                	xor    %edx,%edx
    77b2:	49 ff c8             	dec    %r8
    77b5:	49 81 c3 28 12 00 00 	add    $0x1228,%r11
    77bc:	4d 39 c2             	cmp    %r8,%r10
    77bf:	74 2f                	je     77f0 <fwp_gc_chunks+0x90>
    77c1:	41 80 3b 00          	cmpb   $0x0,(%r11)
    77c5:	75 e9                	jne    77b0 <fwp_gc_chunks+0x50>
    77c7:	48 ff c2             	inc    %rdx
    77ca:	48 39 fa             	cmp    %rdi,%rdx
    77cd:	75 e3                	jne    77b2 <fwp_gc_chunks+0x52>
    77cf:	48 ff c1             	inc    %rcx
    77d2:	48 89 c8             	mov    %rcx,%rax
    77d5:	4c 29 c0             	sub    %r8,%rax
    77d8:	49 89 04 31          	mov    %rax,(%r9,%rsi,1)
    77dc:	48 29 3d 65 bb 00 00 	sub    %rdi,0xbb65(%rip)        # 13348 <fwp_gc+0x11e0>
    77e3:	48 29 f9             	sub    %rdi,%rcx
    77e6:	4c 29 c1             	sub    %r8,%rcx
    77e9:	48 89 c8             	mov    %rcx,%rax
    77ec:	eb 57                	jmp    7845 <fwp_gc_chunks+0xe5>
    77ee:	31 d2                	xor    %edx,%edx
    77f0:	48 29 d0             	sub    %rdx,%rax
    77f3:	48 01 c7             	add    %rax,%rdi
    77f6:	48 3b 3d bb b9 00 00 	cmp    0xb9bb(%rip),%rdi        # 131b8 <fwp_gc+0x1050>
    77fd:	76 1b                	jbe    781a <fwp_gc_chunks+0xba>
    77ff:	83 3d 56 b9 00 00 00 	cmpl   $0x0,0xb956(%rip)        # 1315c <fwp_gc+0xff4>
    7806:	74 12                	je     781a <fwp_gc_chunks+0xba>
    7808:	83 3d 51 b9 00 00 00 	cmpl   $0x0,0xb951(%rip)        # 13160 <fwp_gc+0xff8>
    780f:	75 09                	jne    781a <fwp_gc_chunks+0xba>
    7811:	f6 05 78 cf 00 00 01 	testb  $0x1,0xcf78(%rip)        # 14790 <fwp_gc_chunks.retrying>
    7818:	74 34                	je     784e <fwp_gc_chunks+0xee>
    781a:	48 29 15 27 bb 00 00 	sub    %rdx,0xbb27(%rip)        # 13348 <fwp_gc+0x11e0>
    7821:	48 39 3d a0 b9 00 00 	cmp    %rdi,0xb9a0(%rip)        # 131c8 <fwp_gc+0x1060>
    7828:	72 3a                	jb     7864 <fwp_gc_chunks+0x104>
    782a:	48 89 3d 8f b9 00 00 	mov    %rdi,0xb98f(%rip)        # 131c0 <fwp_gc+0x1058>
    7831:	48 c1 e7 10          	shl    $0x10,%rdi
    7835:	48 3b 3d 74 b9 00 00 	cmp    0xb974(%rip),%rdi        # 131b0 <fwp_gc+0x1048>
    783c:	76 07                	jbe    7845 <fwp_gc_chunks+0xe5>
    783e:	48 89 3d 6b b9 00 00 	mov    %rdi,0xb96b(%rip)        # 131b0 <fwp_gc+0x1048>
    7845:	48 81 c4 d0 00 00 00 	add    $0xd0,%rsp
    784c:	5b                   	pop    %rbx
    784d:	c3                   	ret
    784e:	c6 05 3b cf 00 00 01 	movb   $0x1,0xcf3b(%rip)        # 14790 <fwp_gc_chunks.retrying>
    7855:	0f 57 c0             	xorps  %xmm0,%xmm0
    7858:	0f 11 05 71 b9 00 00 	movups %xmm0,0xb971(%rip)        # 131d0 <fwp_gc+0x1068>
    785f:	e8 4c 00 00 00       	call   78b0 <fwp_gc_collect>
    7864:	4c 8b 05 95 cb 00 00 	mov    0xcb95(%rip),%r8        # 14400 <fwp_static+0x860>
    786b:	49 c1 e8 0a          	shr    $0xa,%r8
    786f:	48 8d 15 ed 7a 00 00 	lea    0x7aed(%rip),%rdx        # f363 <fwp_segv.msg+0xe3>
    7876:	48 8d 0d a3 7d 00 00 	lea    0x7da3(%rip),%rcx        # f620 <fwp_segv.msg+0x3a0>
    787d:	4c 8d 0d 9a 7d 00 00 	lea    0x7d9a(%rip),%r9        # f61e <fwp_segv.msg+0x39e>
    7884:	48 89 e3             	mov    %rsp,%rbx
    7887:	be c8 00 00 00       	mov    $0xc8,%esi
    788c:	48 89 df             	mov    %rbx,%rdi
    788f:	31 c0                	xor    %eax,%eax
    7891:	e8 6a a8 ff ff       	call   2100 <snprintf@plt>
    7896:	48 63 d0             	movslq %eax,%rdx
    7899:	bf 02 00 00 00       	mov    $0x2,%edi
    789e:	48 89 de             	mov    %rbx,%rsi
    78a1:	e8 0a a8 ff ff       	call   20b0 <write@plt>
    78a6:	bf 66 00 00 00       	mov    $0x66,%edi
    78ab:	e8 b0 a7 ff ff       	call   2060 <_exit@plt>

00000000000078b0 <fwp_gc_collect>:
    78b0:	50                   	push   %rax
    78b1:	e8 aa f1 ff ff       	call   6a60 <fwp_flush>
    78b6:	48 8b 05 23 a7 00 00 	mov    0xa723(%rip),%rax        # 11fe0 <stderr@GLIBC_2.2.5>
    78bd:	48 8b 38             	mov    (%rax),%rdi
    78c0:	48 8d 35 06 7c 00 00 	lea    0x7c06(%rip),%rsi        # f4cd <fwp_segv.msg+0x24d>
    78c7:	48 8d 15 1f 7d 00 00 	lea    0x7d1f(%rip),%rdx        # f5ed <fwp_segv.msg+0x36d>
    78ce:	31 c0                	xor    %eax,%eax
    78d0:	e8 cb a8 ff ff       	call   21a0 <fprintf@plt>
    78d5:	bf 65 00 00 00       	mov    $0x65,%edi
    78da:	e8 91 a9 ff ff       	call   2270 <exit@plt>
    78df:	90                   	nop

00000000000078e0 <f12>:
    78e0:	55                   	push   %rbp
    78e1:	41 57                	push   %r15
    78e3:	41 56                	push   %r14
    78e5:	41 55                	push   %r13
    78e7:	41 54                	push   %r12
    78e9:	53                   	push   %rbx
    78ea:	50                   	push   %rax
    78eb:	48 89 d3             	mov    %rdx,%rbx
    78ee:	49 89 ff             	mov    %rdi,%r15
    78f1:	49 bc ff ff ff ff ff 	movabs $0x7fffffffffffffff,%r12
    78f8:	ff ff 7f 
    78fb:	48 8b 02             	mov    (%rdx),%rax
    78fe:	49 89 c6             	mov    %rax,%r14
    7901:	4d 21 e6             	and    %r12,%r14
    7904:	31 c9                	xor    %ecx,%ecx
    7906:	48 85 ff             	test   %rdi,%rdi
    7909:	4c 0f 4e f9          	cmovle %rcx,%r15
    790d:	4d 39 f7             	cmp    %r14,%r15
    7910:	4d 0f 43 fe          	cmovae %r14,%r15
    7914:	48 85 f6             	test   %rsi,%rsi
    7917:	48 0f 4f ce          	cmovg  %rsi,%rcx
    791b:	4d 29 fe             	sub    %r15,%r14
    791e:	4c 39 f1             	cmp    %r14,%rcx
    7921:	4c 0f 42 f1          	cmovb  %rcx,%r14
    7925:	4d 85 f6             	test   %r14,%r14
    7928:	74 10                	je     793a <f12+0x5a>
    792a:	48 89 d9             	mov    %rbx,%rcx
    792d:	48 85 c0             	test   %rax,%rax
    7930:	78 1b                	js     794d <f12+0x6d>
    7932:	49 83 fe 04          	cmp    $0x4,%r14
    7936:	73 1f                	jae    7957 <f12+0x77>
    7938:	eb 44                	jmp    797e <f12+0x9e>
    793a:	48 8d 35 0f a3 00 00 	lea    0xa30f(%rip),%rsi        # 11c50 <d0>
    7941:	31 ff                	xor    %edi,%edi
    7943:	e8 48 f3 ff ff       	call   6c90 <fwp_array_typed_new>
    7948:	e9 7e 00 00 00       	jmp    79cb <f12+0xeb>
    794d:	48 8b 4b 08          	mov    0x8(%rbx),%rcx
    7951:	49 83 fe 04          	cmp    $0x4,%r14
    7955:	72 27                	jb     797e <f12+0x9e>
    7957:	48 8b 09             	mov    (%rcx),%rcx
    795a:	48 89 ca             	mov    %rcx,%rdx
    795d:	48 c1 ea 02          	shr    $0x2,%rdx
    7961:	48 be ff ff ff ff ff 	movabs $0x1fffffffffffffff,%rsi
    7968:	ff ff 1f 
    796b:	48 21 d6             	and    %rdx,%rsi
    796e:	83 e1 03             	and    $0x3,%ecx
    7971:	48 83 f9 01          	cmp    $0x1,%rcx
    7975:	48 83 de ff          	sbb    $0xffffffffffffffff,%rsi
    7979:	4c 39 f6             	cmp    %r14,%rsi
    797c:	76 5c                	jbe    79da <f12+0xfa>
    797e:	48 8d 35 cb a2 00 00 	lea    0xa2cb(%rip),%rsi        # 11c50 <d0>
    7985:	4c 89 f7             	mov    %r14,%rdi
    7988:	e8 03 f3 ff ff       	call   6c90 <fwp_array_typed_new>
    798d:	48 8d 4b 08          	lea    0x8(%rbx),%rcx
    7991:	49 c1 e7 03          	shl    $0x3,%r15
    7995:	31 d2                	xor    %edx,%edx
    7997:	66 0f 1f 84 00 00 00 	nopw   0x0(%rax,%rax,1)
    799e:	00 00 
    79a0:	48 83 3b 00          	cmpq   $0x0,(%rbx)
    79a4:	48 89 ce             	mov    %rcx,%rsi
    79a7:	79 04                	jns    79ad <f12+0xcd>
    79a9:	48 8b 73 10          	mov    0x10(%rbx),%rsi
    79ad:	48 83 38 00          	cmpq   $0x0,(%rax)
    79b1:	0f 88 37 02 00 00    	js     7bee <f12+0x30e>
    79b7:	4c 01 fe             	add    %r15,%rsi
    79ba:	48 8b 34 d6          	mov    (%rsi,%rdx,8),%rsi
    79be:	48 89 74 d0 08       	mov    %rsi,0x8(%rax,%rdx,8)
    79c3:	48 ff c2             	inc    %rdx
    79c6:	49 39 d6             	cmp    %rdx,%r14
    79c9:	75 d5                	jne    79a0 <f12+0xc0>
    79cb:	48 83 c4 08          	add    $0x8,%rsp
    79cf:	5b                   	pop    %rbx
    79d0:	41 5c                	pop    %r12
    79d2:	41 5d                	pop    %r13
    79d4:	41 5e                	pop    %r14
    79d6:	41 5f                	pop    %r15
    79d8:	5d                   	pop    %rbp
    79d9:	c3                   	ret
    79da:	48 85 c0             	test   %rax,%rax
    79dd:	78 09                	js     79e8 <f12+0x108>
    79df:	48 8d 43 08          	lea    0x8(%rbx),%rax
    79e3:	49 89 dd             	mov    %rbx,%r13
    79e6:	eb 08                	jmp    79f0 <f12+0x110>
    79e8:	4c 8b 6b 08          	mov    0x8(%rbx),%r13
    79ec:	48 8b 43 10          	mov    0x10(%rbx),%rax
    79f0:	4a 8d 2c f8          	lea    (%rax,%r15,8),%rbp
    79f4:	48 8d 0d 6d a7 00 00 	lea    0xa76d(%rip),%rcx        # 12168 <fwp_gc>
    79fb:	0f b6 05 50 b3 00 00 	movzbl 0xb350(%rip),%eax        # 12d52 <fwp_gc+0xbea>
    7a02:	8b 94 81 48 0b 00 00 	mov    0xb48(%rcx,%rax,4),%edx
    7a09:	48 8b 3d 58 a7 00 00 	mov    0xa758(%rip),%rdi        # 12168 <fwp_gc>
    7a10:	48 29 d7             	sub    %rdx,%rdi
    7a13:	48 89 3d 4e a7 00 00 	mov    %rdi,0xa74e(%rip)        # 12168 <fwp_gc>
    7a1a:	78 56                	js     7a72 <f12+0x192>
    7a1c:	48 8d 34 40          	lea    (%rax,%rax,2),%rsi
    7a20:	4c 8d 04 f1          	lea    (%rcx,%rsi,8),%r8
    7a24:	49 83 c0 08          	add    $0x8,%r8
    7a28:	49 8b 00             	mov    (%r8),%rax
    7a2b:	48 85 c0             	test   %rax,%rax
    7a2e:	74 25                	je     7a55 <f12+0x175>
    7a30:	48 8b 08             	mov    (%rax),%rcx
    7a33:	48 f7 d1             	not    %rcx
    7a36:	49 89 08             	mov    %rcx,(%r8)
    7a39:	83 fa 19             	cmp    $0x19,%edx
    7a3c:	72 7e                	jb     7abc <f12+0x1dc>
    7a3e:	48 8d 78 18          	lea    0x18(%rax),%rdi
    7a42:	48 83 c2 e7          	add    $0xffffffffffffffe7,%rdx
    7a46:	48 83 e2 f8          	and    $0xfffffffffffffff8,%rdx
    7a4a:	48 83 c2 08          	add    $0x8,%rdx
    7a4e:	31 f6                	xor    %esi,%esi
    7a50:	49 89 c7             	mov    %rax,%r15
    7a53:	eb 5f                	jmp    7ab4 <f12+0x1d4>
    7a55:	48 8b 44 f1 10       	mov    0x10(%rcx,%rsi,8),%rax
    7a5a:	4c 8b 44 f1 18       	mov    0x18(%rcx,%rsi,8),%r8
    7a5f:	4d 89 c1             	mov    %r8,%r9
    7a62:	49 29 c1             	sub    %rax,%r9
    7a65:	49 39 d1             	cmp    %rdx,%r9
    7a68:	73 16                	jae    7a80 <f12+0x1a0>
    7a6a:	49 89 c7             	mov    %rax,%r15
    7a6d:	49 39 d1             	cmp    %rdx,%r9
    7a70:	73 34                	jae    7aa6 <f12+0x1c6>
    7a72:	bf 18 00 00 00       	mov    $0x18,%edi
    7a77:	31 f6                	xor    %esi,%esi
    7a79:	e8 82 f4 ff ff       	call   6f00 <fwp_gc_alloc_slow>
    7a7e:	eb 3c                	jmp    7abc <f12+0x1dc>
    7a80:	4c 8d 0c f1          	lea    (%rcx,%rsi,8),%r9
    7a84:	49 83 c1 10          	add    $0x10,%r9
    7a88:	4c 8d 3c 10          	lea    (%rax,%rdx,1),%r15
    7a8c:	4d 89 39             	mov    %r15,(%r9)
    7a8f:	48 85 c0             	test   %rax,%rax
    7a92:	75 a5                	jne    7a39 <f12+0x159>
    7a94:	48 89 3d cd a6 00 00 	mov    %rdi,0xa6cd(%rip)        # 12168 <fwp_gc>
    7a9b:	4d 29 f8             	sub    %r15,%r8
    7a9e:	4d 89 c1             	mov    %r8,%r9
    7aa1:	49 39 d1             	cmp    %rdx,%r9
    7aa4:	72 cc                	jb     7a72 <f12+0x192>
    7aa6:	49 8d 04 17          	lea    (%r15,%rdx,1),%rax
    7aaa:	48 89 44 f1 10       	mov    %rax,0x10(%rcx,%rsi,8)
    7aaf:	4c 89 ff             	mov    %r15,%rdi
    7ab2:	31 f6                	xor    %esi,%esi
    7ab4:	e8 67 a6 ff ff       	call   2120 <memset@plt>
    7ab9:	4c 89 f8             	mov    %r15,%rax
    7abc:	4b 8d 0c 34          	lea    (%r12,%r14,1),%rcx
    7ac0:	48 ff c1             	inc    %rcx
    7ac3:	48 89 08             	mov    %rcx,(%rax)
    7ac6:	4c 89 68 08          	mov    %r13,0x8(%rax)
    7aca:	48 89 68 10          	mov    %rbp,0x10(%rax)
    7ace:	4c 2b 2d c3 b6 00 00 	sub    0xb6c3(%rip),%r13        # 13198 <fwp_gc+0x1030>
    7ad5:	48 8b 0d e4 b6 00 00 	mov    0xb6e4(%rip),%rcx        # 131c0 <fwp_gc+0x1058>
    7adc:	48 c1 e1 10          	shl    $0x10,%rcx
    7ae0:	49 39 cd             	cmp    %rcx,%r13
    7ae3:	73 6a                	jae    7b4f <f12+0x26f>
    7ae5:	48 8b 0d f4 b6 00 00 	mov    0xb6f4(%rip),%rcx        # 131e0 <fwp_gc+0x1078>
    7aec:	4c 89 ea             	mov    %r13,%rdx
    7aef:	48 c1 ea 10          	shr    $0x10,%rdx
    7af3:	48 69 d2 28 12 00 00 	imul   $0x1228,%rdx,%rdx
    7afa:	0f b6 34 11          	movzbl (%rcx,%rdx,1),%esi
    7afe:	49 81 e5 ff ff 00 00 	and    $0xffff,%r13
    7b05:	75 13                	jne    7b1a <f12+0x23a>
    7b07:	40 80 fe 02          	cmp    $0x2,%sil
    7b0b:	75 0d                	jne    7b1a <f12+0x23a>
    7b0d:	48 8d 3c 11          	lea    (%rcx,%rdx,1),%rdi
    7b11:	48 81 c7 28 02 00 00 	add    $0x228,%rdi
    7b18:	eb 21                	jmp    7b3b <f12+0x25b>
    7b1a:	40 80 fe 01          	cmp    $0x1,%sil
    7b1e:	75 2f                	jne    7b4f <f12+0x26f>
    7b20:	48 8d 34 11          	lea    (%rcx,%rdx,1),%rsi
    7b24:	8b 4c 11 20          	mov    0x20(%rcx,%rdx,1),%ecx
    7b28:	4c 0f af e9          	imul   %rcx,%r13
    7b2c:	49 c1 ed 20          	shr    $0x20,%r13
    7b30:	4a 8d 3c 2e          	lea    (%rsi,%r13,1),%rdi
    7b34:	48 81 c7 28 02 00 00 	add    $0x228,%rdi
    7b3b:	0f b6 0f             	movzbl (%rdi),%ecx
    7b3e:	84 c9                	test   %cl,%cl
    7b40:	74 0d                	je     7b4f <f12+0x26f>
    7b42:	80 f9 fe             	cmp    $0xfe,%cl
    7b45:	0f 83 93 00 00 00    	jae    7bde <f12+0x2fe>
    7b4b:	fe c1                	inc    %cl
    7b4d:	88 0f                	mov    %cl,(%rdi)
    7b4f:	48 89 c1             	mov    %rax,%rcx
    7b52:	48 2b 0d 3f b6 00 00 	sub    0xb63f(%rip),%rcx        # 13198 <fwp_gc+0x1030>
    7b59:	48 8b 15 60 b6 00 00 	mov    0xb660(%rip),%rdx        # 131c0 <fwp_gc+0x1058>
    7b60:	48 c1 e2 10          	shl    $0x10,%rdx
    7b64:	48 39 d1             	cmp    %rdx,%rcx
    7b67:	73 60                	jae    7bc9 <f12+0x2e9>
    7b69:	48 8b 15 70 b6 00 00 	mov    0xb670(%rip),%rdx        # 131e0 <fwp_gc+0x1078>
    7b70:	48 89 ce             	mov    %rcx,%rsi
    7b73:	48 c1 ee 10          	shr    $0x10,%rsi
    7b77:	48 69 f6 28 12 00 00 	imul   $0x1228,%rsi,%rsi
    7b7e:	0f b6 3c 32          	movzbl (%rdx,%rsi,1),%edi
    7b82:	48 81 e1 ff ff 00 00 	and    $0xffff,%rcx
    7b89:	75 13                	jne    7b9e <f12+0x2be>
    7b8b:	40 80 ff 02          	cmp    $0x2,%dil
    7b8f:	75 0d                	jne    7b9e <f12+0x2be>
    7b91:	4c 8d 34 32          	lea    (%rdx,%rsi,1),%r14
    7b95:	49 81 c6 28 02 00 00 	add    $0x228,%r14
    7b9c:	eb 21                	jmp    7bbf <f12+0x2df>
    7b9e:	40 80 ff 01          	cmp    $0x1,%dil
    7ba2:	75 25                	jne    7bc9 <f12+0x2e9>
    7ba4:	48 8d 3c 32          	lea    (%rdx,%rsi,1),%rdi
    7ba8:	8b 54 32 20          	mov    0x20(%rdx,%rsi,1),%edx
    7bac:	48 0f af ca          	imul   %rdx,%rcx
    7bb0:	48 c1 e9 20          	shr    $0x20,%rcx
    7bb4:	4c 8d 34 39          	lea    (%rcx,%rdi,1),%r14
    7bb8:	49 81 c6 28 02 00 00 	add    $0x228,%r14
    7bbf:	41 80 3e ff          	cmpb   $0xff,(%r14)
    7bc3:	74 09                	je     7bce <f12+0x2ee>
    7bc5:	41 c6 06 01          	movb   $0x1,(%r14)
    7bc9:	e9 fd fd ff ff       	jmp    79cb <f12+0xeb>
    7bce:	4c 89 f7             	mov    %r14,%rdi
    7bd1:	49 89 c7             	mov    %rax,%r15
    7bd4:	e8 b7 ee ff ff       	call   6a90 <fwp_rc_forget_slot>
    7bd9:	4c 89 f8             	mov    %r15,%rax
    7bdc:	eb e7                	jmp    7bc5 <f12+0x2e5>
    7bde:	49 89 c6             	mov    %rax,%r14
    7be1:	e8 3a 00 00 00       	call   7c20 <fwp_rc_wide_dup>
    7be6:	4c 89 f0             	mov    %r14,%rax
    7be9:	e9 61 ff ff ff       	jmp    7b4f <f12+0x26f>
    7bee:	e8 6d ee ff ff       	call   6a60 <fwp_flush>
    7bf3:	48 8b 05 e6 a3 00 00 	mov    0xa3e6(%rip),%rax        # 11fe0 <stderr@GLIBC_2.2.5>
    7bfa:	48 8b 38             	mov    (%rax),%rdi
    7bfd:	48 8d 35 c9 78 00 00 	lea    0x78c9(%rip),%rsi        # f4cd <fwp_segv.msg+0x24d>
    7c04:	48 8d 15 1a 7a 00 00 	lea    0x7a1a(%rip),%rdx        # f625 <fwp_segv.msg+0x3a5>
    7c0b:	31 c0                	xor    %eax,%eax
    7c0d:	e8 8e a5 ff ff       	call   21a0 <fprintf@plt>
    7c12:	bf 65 00 00 00       	mov    $0x65,%edi
    7c17:	e8 54 a6 ff ff       	call   2270 <exit@plt>
    7c1c:	0f 1f 40 00          	nopl   0x0(%rax)

0000000000007c20 <fwp_rc_wide_dup>:
    7c20:	41 56                	push   %r14
    7c22:	53                   	push   %rbx
    7c23:	50                   	push   %rax
    7c24:	48 89 fb             	mov    %rdi,%rbx
    7c27:	48 89 f8             	mov    %rdi,%rax
    7c2a:	48 c1 e8 11          	shr    $0x11,%rax
    7c2e:	31 d8                	xor    %ebx,%eax
    7c30:	89 c1                	mov    %eax,%ecx
    7c32:	c1 e9 09             	shr    $0x9,%ecx
    7c35:	31 c1                	xor    %eax,%ecx
    7c37:	0f b6 c1             	movzbl %cl,%eax
    7c3a:	48 8d 0d 27 a5 00 00 	lea    0xa527(%rip),%rcx        # 12168 <fwp_gc>
    7c41:	4c 8d 34 c1          	lea    (%rcx,%rax,8),%r14
    7c45:	49 81 c6 18 12 00 00 	add    $0x1218,%r14
    7c4c:	48 8b 84 c1 18 12 00 	mov    0x1218(%rcx,%rax,8),%rax
    7c53:	00 
    7c54:	48 85 c0             	test   %rax,%rax
    7c57:	74 1a                	je     7c73 <fwp_rc_wide_dup+0x53>
    7c59:	48 39 18             	cmp    %rbx,(%rax)
    7c5c:	74 22                	je     7c80 <fwp_rc_wide_dup+0x60>
    7c5e:	66 90                	xchg   %ax,%ax
    7c60:	49 89 c6             	mov    %rax,%r14
    7c63:	48 8b 40 10          	mov    0x10(%rax),%rax
    7c67:	48 85 c0             	test   %rax,%rax
    7c6a:	74 0e                	je     7c7a <fwp_rc_wide_dup+0x5a>
    7c6c:	48 39 18             	cmp    %rbx,(%rax)
    7c6f:	75 ef                	jne    7c60 <fwp_rc_wide_dup+0x40>
    7c71:	eb 09                	jmp    7c7c <fwp_rc_wide_dup+0x5c>
    7c73:	80 3b fe             	cmpb   $0xfe,(%rbx)
    7c76:	74 12                	je     7c8a <fwp_rc_wide_dup+0x6a>
    7c78:	eb 64                	jmp    7cde <fwp_rc_wide_dup+0xbe>
    7c7a:	31 c0                	xor    %eax,%eax
    7c7c:	49 83 c6 10          	add    $0x10,%r14
    7c80:	80 3b fe             	cmpb   $0xfe,(%rbx)
    7c83:	75 38                	jne    7cbd <fwp_rc_wide_dup+0x9d>
    7c85:	48 85 c0             	test   %rax,%rax
    7c88:	75 73                	jne    7cfd <fwp_rc_wide_dup+0xdd>
    7c8a:	bf 18 00 00 00       	mov    $0x18,%edi
    7c8f:	e8 bc a7 ff ff       	call   2450 <fwp_pool_get>
    7c94:	48 89 18             	mov    %rbx,(%rax)
    7c97:	48 c7 40 08 ff 00 00 	movq   $0xff,0x8(%rax)
    7c9e:	00 
    7c9f:	48 c7 40 10 00 00 00 	movq   $0x0,0x10(%rax)
    7ca6:	00 
    7ca7:	49 89 06             	mov    %rax,(%r14)
    7caa:	c6 03 ff             	movb   $0xff,(%rbx)
    7cad:	48 8d 05 cc be 00 00 	lea    0xbecc(%rip),%rax        # 13b80 <fwp_gc+0x1a18>
    7cb4:	48 8b 0d c5 be 00 00 	mov    0xbec5(%rip),%rcx        # 13b80 <fwp_gc+0x1a18>
    7cbb:	eb 13                	jmp    7cd0 <fwp_rc_wide_dup+0xb0>
    7cbd:	48 85 c0             	test   %rax,%rax
    7cc0:	74 1c                	je     7cde <fwp_rc_wide_dup+0xbe>
    7cc2:	48 8b 48 08          	mov    0x8(%rax),%rcx
    7cc6:	48 83 f9 ff          	cmp    $0xffffffffffffffff,%rcx
    7cca:	74 50                	je     7d1c <fwp_rc_wide_dup+0xfc>
    7ccc:	48 83 c0 08          	add    $0x8,%rax
    7cd0:	48 ff c1             	inc    %rcx
    7cd3:	48 89 08             	mov    %rcx,(%rax)
    7cd6:	48 83 c4 08          	add    $0x8,%rsp
    7cda:	5b                   	pop    %rbx
    7cdb:	41 5e                	pop    %r14
    7cdd:	c3                   	ret
    7cde:	e8 7d ed ff ff       	call   6a60 <fwp_flush>
    7ce3:	48 8b 05 f6 a2 00 00 	mov    0xa2f6(%rip),%rax        # 11fe0 <stderr@GLIBC_2.2.5>
    7cea:	48 8b 38             	mov    (%rax),%rdi
    7ced:	48 8d 35 d9 77 00 00 	lea    0x77d9(%rip),%rsi        # f4cd <fwp_segv.msg+0x24d>
    7cf4:	48 8d 15 e1 77 00 00 	lea    0x77e1(%rip),%rdx        # f4dc <fwp_segv.msg+0x25c>
    7cfb:	eb 3c                	jmp    7d39 <fwp_rc_wide_dup+0x119>
    7cfd:	e8 5e ed ff ff       	call   6a60 <fwp_flush>
    7d02:	48 8b 05 d7 a2 00 00 	mov    0xa2d7(%rip),%rax        # 11fe0 <stderr@GLIBC_2.2.5>
    7d09:	48 8b 38             	mov    (%rax),%rdi
    7d0c:	48 8d 35 ba 77 00 00 	lea    0x77ba(%rip),%rsi        # f4cd <fwp_segv.msg+0x24d>
    7d13:	48 8d 15 37 79 00 00 	lea    0x7937(%rip),%rdx        # f651 <fwp_segv.msg+0x3d1>
    7d1a:	eb 1d                	jmp    7d39 <fwp_rc_wide_dup+0x119>
    7d1c:	e8 3f ed ff ff       	call   6a60 <fwp_flush>
    7d21:	48 8b 05 b8 a2 00 00 	mov    0xa2b8(%rip),%rax        # 11fe0 <stderr@GLIBC_2.2.5>
    7d28:	48 8b 38             	mov    (%rax),%rdi
    7d2b:	48 8d 35 9b 77 00 00 	lea    0x779b(%rip),%rsi        # f4cd <fwp_segv.msg+0x24d>
    7d32:	48 8d 15 3d 79 00 00 	lea    0x793d(%rip),%rdx        # f676 <fwp_segv.msg+0x3f6>
    7d39:	31 c0                	xor    %eax,%eax
    7d3b:	e8 60 a4 ff ff       	call   21a0 <fprintf@plt>
    7d40:	bf 65 00 00 00       	mov    $0x65,%edi
    7d45:	e8 26 a5 ff ff       	call   2270 <exit@plt>
    7d4a:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)

0000000000007d50 <fwp_show>:
    7d50:	41 57                	push   %r15
    7d52:	41 56                	push   %r14
    7d54:	53                   	push   %rbx
    7d55:	48 83 ec 20          	sub    $0x20,%rsp
    7d59:	48 89 f2             	mov    %rsi,%rdx
    7d5c:	48 89 fe             	mov    %rdi,%rsi
    7d5f:	0f 57 c0             	xorps  %xmm0,%xmm0
    7d62:	0f 29 04 24          	movaps %xmm0,(%rsp)
    7d66:	48 c7 44 24 10 00 00 	movq   $0x0,0x10(%rsp)
    7d6d:	00 00 
    7d6f:	48 89 e7             	mov    %rsp,%rdi
    7d72:	b9 01 00 00 00       	mov    $0x1,%ecx
    7d77:	e8 54 01 00 00       	call   7ed0 <fwp_write>
    7d7c:	48 8b 04 24          	mov    (%rsp),%rax
    7d80:	4c 8b 7c 24 08       	mov    0x8(%rsp),%r15
    7d85:	48 85 c0             	test   %rax,%rax
    7d88:	4c 8d 35 43 7c 00 00 	lea    0x7c43(%rip),%r14        # f9d2 <fwp_segv.msg+0x752>
    7d8f:	4c 0f 45 f0          	cmovne %rax,%r14
    7d93:	49 8d 57 09          	lea    0x9(%r15),%rdx
    7d97:	48 81 fa 00 40 00 00 	cmp    $0x4000,%rdx
    7d9e:	77 61                	ja     7e01 <fwp_show+0xb1>
    7da0:	49 8d 4f 18          	lea    0x18(%r15),%rcx
    7da4:	48 c1 e9 04          	shr    $0x4,%rcx
    7da8:	48 8d 05 b9 a3 00 00 	lea    0xa3b9(%rip),%rax        # 12168 <fwp_gc>
    7daf:	0f b6 b4 01 e8 0b 00 	movzbl 0xbe8(%rcx,%rax,1),%esi
    7db6:	00 
    7db7:	8b 8c b0 48 0b 00 00 	mov    0xb48(%rax,%rsi,4),%ecx
    7dbe:	48 29 0d a3 a3 00 00 	sub    %rcx,0xa3a3(%rip)        # 12168 <fwp_gc>
    7dc5:	78 3a                	js     7e01 <fwp_show+0xb1>
    7dc7:	48 8d 34 76          	lea    (%rsi,%rsi,2),%rsi
    7dcb:	48 8d 3c f0          	lea    (%rax,%rsi,8),%rdi
    7dcf:	48 81 c7 c8 03 00 00 	add    $0x3c8,%rdi
    7dd6:	48 8b 1f             	mov    (%rdi),%rbx
    7dd9:	48 85 db             	test   %rbx,%rbx
    7ddc:	74 0b                	je     7de9 <fwp_show+0x99>
    7dde:	48 8b 03             	mov    (%rbx),%rax
    7de1:	48 f7 d0             	not    %rax
    7de4:	48 89 07             	mov    %rax,(%rdi)
    7de7:	eb 3a                	jmp    7e23 <fwp_show+0xd3>
    7de9:	48 8b 9c f0 d0 03 00 	mov    0x3d0(%rax,%rsi,8),%rbx
    7df0:	00 
    7df1:	48 8b bc f0 d8 03 00 	mov    0x3d8(%rax,%rsi,8),%rdi
    7df8:	00 
    7df9:	48 29 df             	sub    %rbx,%rdi
    7dfc:	48 39 cf             	cmp    %rcx,%rdi
    7dff:	73 12                	jae    7e13 <fwp_show+0xc3>
    7e01:	48 89 d7             	mov    %rdx,%rdi
    7e04:	be 01 00 00 00       	mov    $0x1,%esi
    7e09:	e8 f2 f0 ff ff       	call   6f00 <fwp_gc_alloc_slow>
    7e0e:	48 89 c3             	mov    %rax,%rbx
    7e11:	eb 1a                	jmp    7e2d <fwp_show+0xdd>
    7e13:	48 8d 04 f0          	lea    (%rax,%rsi,8),%rax
    7e17:	48 05 d0 03 00 00    	add    $0x3d0,%rax
    7e1d:	48 01 d9             	add    %rbx,%rcx
    7e20:	48 89 08             	mov    %rcx,(%rax)
    7e23:	48 89 df             	mov    %rbx,%rdi
    7e26:	31 f6                	xor    %esi,%esi
    7e28:	e8 f3 a2 ff ff       	call   2120 <memset@plt>
    7e2d:	4c 89 3b             	mov    %r15,(%rbx)
    7e30:	48 8d 7b 08          	lea    0x8(%rbx),%rdi
    7e34:	4c 89 f6             	mov    %r14,%rsi
    7e37:	4c 89 fa             	mov    %r15,%rdx
    7e3a:	e8 91 a3 ff ff       	call   21d0 <memcpy@plt>
    7e3f:	42 c6 44 3b 08 00    	movb   $0x0,0x8(%rbx,%r15,1)
    7e45:	48 8b 04 24          	mov    (%rsp),%rax
    7e49:	48 85 c0             	test   %rax,%rax
    7e4c:	74 6a                	je     7eb8 <fwp_show+0x168>
    7e4e:	8b 48 f4             	mov    -0xc(%rax),%ecx
    7e51:	66 66 66 66 66 66 2e 	data16 data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    7e58:	0f 1f 84 00 00 00 00 
    7e5f:	00 
    7e60:	b2 01                	mov    $0x1,%dl
    7e62:	86 15 80 c5 00 00    	xchg   %dl,0xc580(%rip)        # 143e8 <fwp_static+0x848>
    7e68:	84 d2                	test   %dl,%dl
    7e6a:	75 f4                	jne    7e60 <fwp_show+0x110>
    7e6c:	48 29 c8             	sub    %rcx,%rax
    7e6f:	8b 50 f0             	mov    -0x10(%rax),%edx
    7e72:	89 d1                	mov    %edx,%ecx
    7e74:	c1 e9 02             	shr    $0x2,%ecx
    7e77:	be 01 00 00 00       	mov    $0x1,%esi
    7e7c:	48 d3 e6             	shl    %cl,%rsi
    7e7f:	48 8d 48 f0          	lea    -0x10(%rax),%rcx
    7e83:	89 d7                	mov    %edx,%edi
    7e85:	83 e7 03             	and    $0x3,%edi
    7e88:	49 89 f0             	mov    %rsi,%r8
    7e8b:	49 c1 e8 02          	shr    $0x2,%r8
    7e8f:	4c 0f af c7          	imul   %rdi,%r8
    7e93:	48 8d 3d 06 bd 00 00 	lea    0xbd06(%rip),%rdi        # 13ba0 <fwp_static>
    7e9a:	49 01 f0             	add    %rsi,%r8
    7e9d:	4c 29 05 34 c5 00 00 	sub    %r8,0xc534(%rip)        # 143d8 <fwp_static+0x838>
    7ea4:	48 8b 74 d7 38       	mov    0x38(%rdi,%rdx,8),%rsi
    7ea9:	48 89 30             	mov    %rsi,(%rax)
    7eac:	48 89 4c d7 38       	mov    %rcx,0x38(%rdi,%rdx,8)
    7eb1:	c6 05 30 c5 00 00 00 	movb   $0x0,0xc530(%rip)        # 143e8 <fwp_static+0x848>
    7eb8:	48 89 d8             	mov    %rbx,%rax
    7ebb:	48 83 c4 20          	add    $0x20,%rsp
    7ebf:	5b                   	pop    %rbx
    7ec0:	41 5e                	pop    %r14
    7ec2:	41 5f                	pop    %r15
    7ec4:	c3                   	ret
    7ec5:	66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
    7ecc:	00 00 00 00 

0000000000007ed0 <fwp_write>:
    7ed0:	55                   	push   %rbp
    7ed1:	41 57                	push   %r15
    7ed3:	41 56                	push   %r14
    7ed5:	41 55                	push   %r13
    7ed7:	41 54                	push   %r12
    7ed9:	53                   	push   %rbx
    7eda:	48 81 ec 78 02 00 00 	sub    $0x278,%rsp
    7ee1:	8b 02                	mov    (%rdx),%eax
    7ee3:	48 83 f8 19          	cmp    $0x19,%rax
    7ee7:	0f 87 26 12 00 00    	ja     9113 <fwp_write+0x1243>
    7eed:	49 89 d7             	mov    %rdx,%r15
    7ef0:	49 89 f6             	mov    %rsi,%r14
    7ef3:	48 89 fd             	mov    %rdi,%rbp
    7ef6:	48 8d 15 23 72 00 00 	lea    0x7223(%rip),%rdx        # f120 <_IO_stdin_used+0x120>
    7efd:	48 63 34 82          	movslq (%rdx,%rax,4),%rsi
    7f01:	48 01 d6             	add    %rdx,%rsi
    7f04:	48 89 3c 24          	mov    %rdi,(%rsp)
    7f08:	ff e6                	jmp    *%rsi
    7f0a:	48 8d 15 7e 77 00 00 	lea    0x777e(%rip),%rdx        # f68f <fwp_segv.msg+0x40f>
    7f11:	eb 07                	jmp    7f1a <fwp_write+0x4a>
    7f13:	48 8d 15 7a 77 00 00 	lea    0x777a(%rip),%rdx        # f694 <fwp_segv.msg+0x414>
    7f1a:	4c 8d 7c 24 70       	lea    0x70(%rsp),%r15
    7f1f:	be 00 02 00 00       	mov    $0x200,%esi
    7f24:	4c 89 ff             	mov    %r15,%rdi
    7f27:	4c 89 f1             	mov    %r14,%rcx
    7f2a:	31 c0                	xor    %eax,%eax
    7f2c:	e8 cf a1 ff ff       	call   2100 <snprintf@plt>
    7f31:	4c 89 ff             	mov    %r15,%rdi
    7f34:	e8 97 a1 ff ff       	call   20d0 <strlen@plt>
    7f39:	48 89 ef             	mov    %rbp,%rdi
    7f3c:	4c 89 fe             	mov    %r15,%rsi
    7f3f:	e9 c7 11 00 00       	jmp    910b <fwp_write+0x123b>
    7f44:	83 f8 13             	cmp    $0x13,%eax
    7f47:	48 8d 05 80 77 00 00 	lea    0x7780(%rip),%rax        # f6ce <fwp_segv.msg+0x44e>
    7f4e:	48 8d 35 7e 77 00 00 	lea    0x777e(%rip),%rsi        # f6d3 <fwp_segv.msg+0x453>
    7f55:	48 0f 44 f0          	cmove  %rax,%rsi
    7f59:	ba 04 00 00 00       	mov    $0x4,%edx
    7f5e:	48 89 ef             	mov    %rbp,%rdi
    7f61:	e8 4a 13 00 00       	call   92b0 <buf_put>
    7f66:	49 83 3e 00          	cmpq   $0x0,(%r14)
    7f6a:	0f 84 c3 00 00 00    	je     8033 <fwp_write+0x163>
    7f70:	49 8b 57 38          	mov    0x38(%r15),%rdx
    7f74:	49 8b 76 08          	mov    0x8(%r14),%rsi
    7f78:	48 8b 1c 24          	mov    (%rsp),%rbx
    7f7c:	48 89 df             	mov    %rbx,%rdi
    7f7f:	31 c9                	xor    %ecx,%ecx
    7f81:	e8 4a ff ff ff       	call   7ed0 <fwp_write>
    7f86:	41 83 3f 12          	cmpl   $0x12,(%r15)
    7f8a:	75 26                	jne    7fb2 <fwp_write+0xe2>
    7f8c:	48 8d 35 45 77 00 00 	lea    0x7745(%rip),%rsi        # f6d8 <fwp_segv.msg+0x458>
    7f93:	ba 02 00 00 00       	mov    $0x2,%edx
    7f98:	48 89 df             	mov    %rbx,%rdi
    7f9b:	e8 10 13 00 00       	call   92b0 <buf_put>
    7fa0:	49 8b 76 10          	mov    0x10(%r14),%rsi
    7fa4:	49 8b 57 40          	mov    0x40(%r15),%rdx
    7fa8:	48 89 df             	mov    %rbx,%rdi
    7fab:	31 c9                	xor    %ecx,%ecx
    7fad:	e8 1e ff ff ff       	call   7ed0 <fwp_write>
    7fb2:	49 83 3e 02          	cmpq   $0x2,(%r14)
    7fb6:	72 7b                	jb     8033 <fwp_write+0x163>
    7fb8:	49 8d 5e 20          	lea    0x20(%r14),%rbx
    7fbc:	bd 01 00 00 00       	mov    $0x1,%ebp
    7fc1:	4c 8d 25 f9 76 00 00 	lea    0x76f9(%rip),%r12        # f6c1 <fwp_segv.msg+0x441>
    7fc8:	eb 12                	jmp    7fdc <fwp_write+0x10c>
    7fca:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)
    7fd0:	48 ff c5             	inc    %rbp
    7fd3:	48 83 c3 10          	add    $0x10,%rbx
    7fd7:	49 3b 2e             	cmp    (%r14),%rbp
    7fda:	73 57                	jae    8033 <fwp_write+0x163>
    7fdc:	ba 02 00 00 00       	mov    $0x2,%edx
    7fe1:	4c 8b 2c 24          	mov    (%rsp),%r13
    7fe5:	4c 89 ef             	mov    %r13,%rdi
    7fe8:	4c 89 e6             	mov    %r12,%rsi
    7feb:	e8 c0 12 00 00       	call   92b0 <buf_put>
    7ff0:	48 8b 73 f8          	mov    -0x8(%rbx),%rsi
    7ff4:	49 8b 57 38          	mov    0x38(%r15),%rdx
    7ff8:	4c 89 ef             	mov    %r13,%rdi
    7ffb:	31 c9                	xor    %ecx,%ecx
    7ffd:	e8 ce fe ff ff       	call   7ed0 <fwp_write>
    8002:	41 83 3f 12          	cmpl   $0x12,(%r15)
    8006:	75 c8                	jne    7fd0 <fwp_write+0x100>
    8008:	ba 02 00 00 00       	mov    $0x2,%edx
    800d:	4c 8b 2c 24          	mov    (%rsp),%r13
    8011:	4c 89 ef             	mov    %r13,%rdi
    8014:	48 8d 35 bd 76 00 00 	lea    0x76bd(%rip),%rsi        # f6d8 <fwp_segv.msg+0x458>
    801b:	e8 90 12 00 00       	call   92b0 <buf_put>
    8020:	48 8b 33             	mov    (%rbx),%rsi
    8023:	49 8b 57 40          	mov    0x40(%r15),%rdx
    8027:	4c 89 ef             	mov    %r13,%rdi
    802a:	31 c9                	xor    %ecx,%ecx
    802c:	e8 9f fe ff ff       	call   7ed0 <fwp_write>
    8031:	eb 9d                	jmp    7fd0 <fwp_write+0x100>
    8033:	c6 44 24 70 7d       	movb   $0x7d,0x70(%rsp)
    8038:	48 8d 74 24 70       	lea    0x70(%rsp),%rsi
    803d:	ba 01 00 00 00       	mov    $0x1,%edx
    8042:	48 8b 3c 24          	mov    (%rsp),%rdi
    8046:	e9 c3 10 00 00       	jmp    910e <fwp_write+0x123e>
    804b:	4d 8b 67 08          	mov    0x8(%r15),%r12
    804f:	4d 85 e4             	test   %r12,%r12
    8052:	0f 84 af 06 00 00    	je     8707 <fwp_write+0x837>
    8058:	48 8d 35 7c 76 00 00 	lea    0x767c(%rip),%rsi        # f6db <fwp_segv.msg+0x45b>
    805f:	4c 89 e7             	mov    %r12,%rdi
    8062:	e8 09 a1 ff ff       	call   2170 <strcmp@plt>
    8067:	85 c0                	test   %eax,%eax
    8069:	0f 84 36 0b 00 00    	je     8ba5 <fwp_write+0xcd5>
    806f:	4d 8d 6f 10          	lea    0x10(%r15),%r13
    8073:	4c 89 e7             	mov    %r12,%rdi
    8076:	e8 55 a0 ff ff       	call   20d0 <strlen@plt>
    807b:	48 89 ef             	mov    %rbp,%rdi
    807e:	4c 89 e6             	mov    %r12,%rsi
    8081:	48 89 c2             	mov    %rax,%rdx
    8084:	e8 27 12 00 00       	call   92b0 <buf_put>
    8089:	c6 44 24 70 20       	movb   $0x20,0x70(%rsp)
    808e:	48 8d 74 24 70       	lea    0x70(%rsp),%rsi
    8093:	ba 01 00 00 00       	mov    $0x1,%edx
    8098:	48 89 ef             	mov    %rbp,%rdi
    809b:	e8 10 12 00 00       	call   92b0 <buf_put>
    80a0:	31 db                	xor    %ebx,%ebx
    80a2:	e9 7f 06 00 00       	jmp    8726 <fwp_write+0x856>
    80a7:	49 81 fe ff 0f 00 00 	cmp    $0xfff,%r14
    80ae:	0f 87 00 05 00 00    	ja     85b4 <fwp_write+0x6e4>
    80b4:	44 89 f0             	mov    %r14d,%eax
    80b7:	e9 fb 04 00 00       	jmp    85b7 <fwp_write+0x6e7>
    80bc:	66 49 0f 6e ce       	movq   %r14,%xmm1
    80c1:	66 0f 2e c9          	ucomisd %xmm1,%xmm1
    80c5:	0f 8a d2 11 00 00    	jp     929d <fwp_write+0x13cd>
    80cb:	66 0f 28 05 fd 6f 00 	movapd 0x6ffd(%rip),%xmm0        # f0d0 <_IO_stdin_used+0xd0>
    80d2:	00 
    80d3:	66 0f 54 c1          	andpd  %xmm1,%xmm0
    80d7:	66 0f 2e 05 41 6f 00 	ucomisd 0x6f41(%rip),%xmm0        # f020 <_IO_stdin_used+0x20>
    80de:	00 
    80df:	0f 82 66 08 00 00    	jb     894b <fwp_write+0xa7b>
    80e5:	66 0f 57 c0          	xorpd  %xmm0,%xmm0
    80e9:	66 0f 2e c8          	ucomisd %xmm0,%xmm1
    80ed:	e9 55 04 00 00       	jmp    8547 <fwp_write+0x677>
    80f2:	c6 44 24 70 3c       	movb   $0x3c,0x70(%rsp)
    80f7:	48 8d 74 24 70       	lea    0x70(%rsp),%rsi
    80fc:	ba 01 00 00 00       	mov    $0x1,%edx
    8101:	48 89 ef             	mov    %rbp,%rdi
    8104:	e8 a7 11 00 00       	call   92b0 <buf_put>
    8109:	4d 8b 77 08          	mov    0x8(%r15),%r14
    810d:	e9 82 04 00 00       	jmp    8594 <fwp_write+0x6c4>
    8112:	48 8d 35 91 75 00 00 	lea    0x7591(%rip),%rsi        # f6aa <fwp_segv.msg+0x42a>
    8119:	ba 08 00 00 00       	mov    $0x8,%edx
    811e:	48 89 ef             	mov    %rbp,%rdi
    8121:	e9 5c 0d 00 00       	jmp    8e82 <fwp_write+0xfb2>
    8126:	49 8d 76 08          	lea    0x8(%r14),%rsi
    812a:	49 8b 16             	mov    (%r14),%rdx
    812d:	85 c9                	test   %ecx,%ecx
    812f:	0f 84 13 07 00 00    	je     8848 <fwp_write+0x978>
    8135:	48 89 ef             	mov    %rbp,%rdi
    8138:	e9 45 0d 00 00       	jmp    8e82 <fwp_write+0xfb2>
    813d:	4d 8b 0e             	mov    (%r14),%r9
    8140:	4d 8b 46 08          	mov    0x8(%r14),%r8
    8144:	4c 89 c8             	mov    %r9,%rax
    8147:	4c 09 c0             	or     %r8,%rax
    814a:	0f 84 11 07 00 00    	je     8861 <fwp_write+0x991>
    8150:	31 ff                	xor    %edi,%edi
    8152:	49 ba cd cc cc cc cc 	movabs $0xcccccccccccccccd,%r10
    8159:	cc cc cc 
    815c:	49 bb cc cc cc cc cc 	movabs $0xcccccccccccccccc,%r11
    8163:	cc cc cc 
    8166:	4c 89 c3             	mov    %r8,%rbx
    8169:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)
    8170:	4c 89 c1             	mov    %r8,%rcx
    8173:	4c 0f a4 c9 3f       	shld   $0x3f,%r9,%rcx
    8178:	48 d1 eb             	shr    $1,%rbx
    817b:	48 89 ce             	mov    %rcx,%rsi
    817e:	48 01 de             	add    %rbx,%rsi
    8181:	48 83 d6 00          	adc    $0x0,%rsi
    8185:	48 89 f0             	mov    %rsi,%rax
    8188:	49 f7 e2             	mul    %r10
    818b:	48 c1 ea 02          	shr    $0x2,%rdx
    818f:	48 8d 04 92          	lea    (%rdx,%rdx,4),%rax
    8193:	48 29 c6             	sub    %rax,%rsi
    8196:	48 29 f1             	sub    %rsi,%rcx
    8199:	48 83 db 00          	sbb    $0x0,%rbx
    819d:	48 89 ce             	mov    %rcx,%rsi
    81a0:	49 0f af f3          	imul   %r11,%rsi
    81a4:	48 89 c8             	mov    %rcx,%rax
    81a7:	49 f7 e2             	mul    %r10
    81aa:	48 01 f2             	add    %rsi,%rdx
    81ad:	49 0f af da          	imul   %r10,%rbx
    81b1:	48 01 d3             	add    %rdx,%rbx
    81b4:	48 89 c1             	mov    %rax,%rcx
    81b7:	48 01 c1             	add    %rax,%rcx
    81ba:	48 8d 0c 89          	lea    (%rcx,%rcx,4),%rcx
    81be:	44 89 ca             	mov    %r9d,%edx
    81c1:	29 ca                	sub    %ecx,%edx
    81c3:	80 ca 30             	or     $0x30,%dl
    81c6:	88 54 3c 20          	mov    %dl,0x20(%rsp,%rdi,1)
    81ca:	48 ff c7             	inc    %rdi
    81cd:	49 83 f9 0a          	cmp    $0xa,%r9
    81d1:	49 83 d8 00          	sbb    $0x0,%r8
    81d5:	49 89 c1             	mov    %rax,%r9
    81d8:	49 89 d8             	mov    %rbx,%r8
    81db:	73 93                	jae    8170 <fwp_write+0x2a0>
    81dd:	85 ff                	test   %edi,%edi
    81df:	0f 8f 86 06 00 00    	jg     886b <fwp_write+0x99b>
    81e5:	e9 ab 00 00 00       	jmp    8295 <fwp_write+0x3c5>
    81ea:	4d 8b 06             	mov    (%r14),%r8
    81ed:	4d 8b 4e 08          	mov    0x8(%r14),%r9
    81f1:	4d 85 c9             	test   %r9,%r9
    81f4:	0f 88 93 06 00 00    	js     888d <fwp_write+0x9bd>
    81fa:	4c 89 c0             	mov    %r8,%rax
    81fd:	4c 09 c8             	or     %r9,%rax
    8200:	0f 84 bc 09 00 00    	je     8bc2 <fwp_write+0xcf2>
    8206:	31 ff                	xor    %edi,%edi
    8208:	49 ba cd cc cc cc cc 	movabs $0xcccccccccccccccd,%r10
    820f:	cc cc cc 
    8212:	49 bb cc cc cc cc cc 	movabs $0xcccccccccccccccc,%r11
    8219:	cc cc cc 
    821c:	4c 89 cb             	mov    %r9,%rbx
    821f:	90                   	nop
    8220:	4c 89 c9             	mov    %r9,%rcx
    8223:	4c 0f a4 c1 3f       	shld   $0x3f,%r8,%rcx
    8228:	48 d1 eb             	shr    $1,%rbx
    822b:	48 89 ce             	mov    %rcx,%rsi
    822e:	48 01 de             	add    %rbx,%rsi
    8231:	48 83 d6 00          	adc    $0x0,%rsi
    8235:	48 89 f0             	mov    %rsi,%rax
    8238:	49 f7 e2             	mul    %r10
    823b:	48 c1 ea 02          	shr    $0x2,%rdx
    823f:	48 8d 04 92          	lea    (%rdx,%rdx,4),%rax
    8243:	48 29 c6             	sub    %rax,%rsi
    8246:	48 29 f1             	sub    %rsi,%rcx
    8249:	48 83 db 00          	sbb    $0x0,%rbx
    824d:	48 89 ce             	mov    %rcx,%rsi
    8250:	49 0f af f3          	imul   %r11,%rsi
    8254:	48 89 c8             	mov    %rcx,%rax
    8257:	49 f7 e2             	mul    %r10
    825a:	48 01 f2             	add    %rsi,%rdx
    825d:	49 0f af da          	imul   %r10,%rbx
    8261:	48 01 d3             	add    %rdx,%rbx
    8264:	48 89 c1             	mov    %rax,%rcx
    8267:	48 01 c1             	add    %rax,%rcx
    826a:	48 8d 0c 89          	lea    (%rcx,%rcx,4),%rcx
    826e:	44 89 c2             	mov    %r8d,%edx
    8271:	29 ca                	sub    %ecx,%edx
    8273:	80 ca 30             	or     $0x30,%dl
    8276:	88 54 3c 20          	mov    %dl,0x20(%rsp,%rdi,1)
    827a:	48 ff c7             	inc    %rdi
    827d:	49 83 f8 0a          	cmp    $0xa,%r8
    8281:	49 83 d9 00          	sbb    $0x0,%r9
    8285:	49 89 c0             	mov    %rax,%r8
    8288:	49 89 d9             	mov    %rbx,%r9
    828b:	73 93                	jae    8220 <fwp_write+0x350>
    828d:	85 ff                	test   %edi,%edi
    828f:	0f 8f 37 09 00 00    	jg     8bcc <fwp_write+0xcfc>
    8295:	31 c0                	xor    %eax,%eax
    8297:	e9 57 0e 00 00       	jmp    90f3 <fwp_write+0x1223>
    829c:	c6 44 24 70 5b       	movb   $0x5b,0x70(%rsp)
    82a1:	48 8d 74 24 70       	lea    0x70(%rsp),%rsi
    82a6:	ba 01 00 00 00       	mov    $0x1,%edx
    82ab:	48 89 ef             	mov    %rbp,%rdi
    82ae:	e8 fd 0f 00 00       	call   92b0 <buf_put>
    82b3:	4d 85 f6             	test   %r14,%r14
    82b6:	0f 84 e6 0c 00 00    	je     8fa2 <fwp_write+0x10d2>
    82bc:	49 8b 57 38          	mov    0x38(%r15),%rdx
    82c0:	49 8b 76 08          	mov    0x8(%r14),%rsi
    82c4:	48 89 ef             	mov    %rbp,%rdi
    82c7:	31 c9                	xor    %ecx,%ecx
    82c9:	e8 02 fc ff ff       	call   7ed0 <fwp_write>
    82ce:	49 8b 5e 10          	mov    0x10(%r14),%rbx
    82d2:	48 85 db             	test   %rbx,%rbx
    82d5:	0f 84 c7 0c 00 00    	je     8fa2 <fwp_write+0x10d2>
    82db:	4c 8d 35 df 73 00 00 	lea    0x73df(%rip),%r14        # f6c1 <fwp_segv.msg+0x441>
    82e2:	66 66 66 66 66 2e 0f 	data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    82e9:	1f 84 00 00 00 00 00 
    82f0:	ba 02 00 00 00       	mov    $0x2,%edx
    82f5:	48 89 ef             	mov    %rbp,%rdi
    82f8:	4c 89 f6             	mov    %r14,%rsi
    82fb:	e8 b0 0f 00 00       	call   92b0 <buf_put>
    8300:	48 8b 73 08          	mov    0x8(%rbx),%rsi
    8304:	49 8b 57 38          	mov    0x38(%r15),%rdx
    8308:	48 89 ef             	mov    %rbp,%rdi
    830b:	31 c9                	xor    %ecx,%ecx
    830d:	e8 be fb ff ff       	call   7ed0 <fwp_write>
    8312:	48 8b 5b 10          	mov    0x10(%rbx),%rbx
    8316:	48 85 db             	test   %rbx,%rbx
    8319:	75 d5                	jne    82f0 <fwp_write+0x420>
    831b:	e9 82 0c 00 00       	jmp    8fa2 <fwp_write+0x10d2>
    8320:	4d 63 67 48          	movslq 0x48(%r15),%r12
    8324:	44 89 e3             	mov    %r12d,%ebx
    8327:	49 8d 54 24 03       	lea    0x3(%r12),%rdx
    832c:	48 81 fa 00 40 00 00 	cmp    $0x4000,%rdx
    8333:	0f 87 57 08 00 00    	ja     8b90 <fwp_write+0xcc0>
    8339:	49 8d 4c 24 12       	lea    0x12(%r12),%rcx
    833e:	48 c1 e9 04          	shr    $0x4,%rcx
    8342:	48 8d 05 1f 9e 00 00 	lea    0x9e1f(%rip),%rax        # 12168 <fwp_gc>
    8349:	0f b6 b4 01 e8 0b 00 	movzbl 0xbe8(%rcx,%rax,1),%esi
    8350:	00 
    8351:	8b 8c b0 48 0b 00 00 	mov    0xb48(%rax,%rsi,4),%ecx
    8358:	48 29 0d 09 9e 00 00 	sub    %rcx,0x9e09(%rip)        # 12168 <fwp_gc>
    835f:	0f 88 2b 08 00 00    	js     8b90 <fwp_write+0xcc0>
    8365:	48 8d 34 76          	lea    (%rsi,%rsi,2),%rsi
    8369:	48 8d 3c f0          	lea    (%rax,%rsi,8),%rdi
    836d:	48 81 c7 c8 03 00 00 	add    $0x3c8,%rdi
    8374:	4c 8b 3f             	mov    (%rdi),%r15
    8377:	4d 85 ff             	test   %r15,%r15
    837a:	0f 84 f4 07 00 00    	je     8b74 <fwp_write+0xca4>
    8380:	49 8b 07             	mov    (%r15),%rax
    8383:	48 f7 d0             	not    %rax
    8386:	48 89 07             	mov    %rax,(%rdi)
    8389:	e9 2d 0a 00 00       	jmp    8dbb <fwp_write+0xeeb>
    838e:	49 83 fe ff          	cmp    $0xffffffffffffffff,%r14
    8392:	48 8d 05 03 73 00 00 	lea    0x7303(%rip),%rax        # f69c <fwp_segv.msg+0x41c>
    8399:	48 8d 0d 69 73 00 00 	lea    0x7369(%rip),%rcx        # f709 <fwp_segv.msg+0x489>
    83a0:	48 0f 44 c8          	cmove  %rax,%rcx
    83a4:	49 83 fe 01          	cmp    $0x1,%r14
    83a8:	4c 8d 35 ea 72 00 00 	lea    0x72ea(%rip),%r14        # f699 <fwp_segv.msg+0x419>
    83af:	4c 0f 45 f1          	cmovne %rcx,%r14
    83b3:	4c 89 f7             	mov    %r14,%rdi
    83b6:	e8 15 9d ff ff       	call   20d0 <strlen@plt>
    83bb:	48 89 ef             	mov    %rbp,%rdi
    83be:	4c 89 f6             	mov    %r14,%rsi
    83c1:	e9 b9 0a 00 00       	jmp    8e7f <fwp_write+0xfaf>
    83c6:	48 8d 35 fa 72 00 00 	lea    0x72fa(%rip),%rsi        # f6c7 <fwp_segv.msg+0x447>
    83cd:	ba 06 00 00 00       	mov    $0x6,%edx
    83d2:	48 89 ef             	mov    %rbp,%rdi
    83d5:	e8 d6 0e 00 00       	call   92b0 <buf_put>
    83da:	49 8b 36             	mov    (%r14),%rsi
    83dd:	48 8d 04 75 00 00 00 	lea    0x0(,%rsi,2),%rax
    83e4:	00 
    83e5:	48 85 c0             	test   %rax,%rax
    83e8:	0f 84 b4 0b 00 00    	je     8fa2 <fwp_write+0x10d2>
    83ee:	49 8b 57 38          	mov    0x38(%r15),%rdx
    83f2:	b8 08 00 00 00       	mov    $0x8,%eax
    83f7:	48 85 d2             	test   %rdx,%rdx
    83fa:	74 13                	je     840f <fwp_write+0x53f>
    83fc:	8b 0a                	mov    (%rdx),%ecx
    83fe:	48 83 f9 0a          	cmp    $0xa,%rcx
    8402:	77 0b                	ja     840f <fwp_write+0x53f>
    8404:	48 8d 05 ed 6e 00 00 	lea    0x6eed(%rip),%rax        # f2f8 <fwp_segv.msg+0x78>
    840b:	48 8b 04 c8          	mov    (%rax,%rcx,8),%rax
    840f:	4d 8d 6e 08          	lea    0x8(%r14),%r13
    8413:	4c 89 e9             	mov    %r13,%rcx
    8416:	48 85 f6             	test   %rsi,%rsi
    8419:	79 04                	jns    841f <fwp_write+0x54f>
    841b:	49 8b 4e 10          	mov    0x10(%r14),%rcx
    841f:	48 83 f8 01          	cmp    $0x1,%rax
    8423:	0f 84 74 0a 00 00    	je     8e9d <fwp_write+0xfcd>
    8429:	48 83 f8 08          	cmp    $0x8,%rax
    842d:	0f 84 65 0a 00 00    	je     8e98 <fwp_write+0xfc8>
    8433:	48 83 f8 02          	cmp    $0x2,%rax
    8437:	0f 85 6c 0a 00 00    	jne    8ea9 <fwp_write+0xfd9>
    843d:	83 3a 01             	cmpl   $0x1,(%rdx)
    8440:	0f b7 01             	movzwl (%rcx),%eax
    8443:	48 0f bf f0          	movswq %ax,%rsi
    8447:	e9 65 0a 00 00       	jmp    8eb1 <fwp_write+0xfe1>
    844c:	48 8d 35 67 72 00 00 	lea    0x7267(%rip),%rsi        # f6ba <fwp_segv.msg+0x43a>
    8453:	ba 06 00 00 00       	mov    $0x6,%edx
    8458:	48 89 ef             	mov    %rbp,%rdi
    845b:	e8 50 0e 00 00       	call   92b0 <buf_put>
    8460:	49 83 3e 00          	cmpq   $0x0,(%r14)
    8464:	0f 84 a3 00 00 00    	je     850d <fwp_write+0x63d>
    846a:	41 0f b6 4e 08       	movzbl 0x8(%r14),%ecx
    846f:	48 8d 15 4e 72 00 00 	lea    0x724e(%rip),%rdx        # f6c4 <fwp_segv.msg+0x444>
    8476:	4c 8d 7c 24 70       	lea    0x70(%rsp),%r15
    847b:	be 00 02 00 00       	mov    $0x200,%esi
    8480:	4c 89 ff             	mov    %r15,%rdi
    8483:	31 c0                	xor    %eax,%eax
    8485:	e8 76 9c ff ff       	call   2100 <snprintf@plt>
    848a:	4c 89 ff             	mov    %r15,%rdi
    848d:	e8 3e 9c ff ff       	call   20d0 <strlen@plt>
    8492:	48 89 ef             	mov    %rbp,%rdi
    8495:	4c 89 fe             	mov    %r15,%rsi
    8498:	48 89 c2             	mov    %rax,%rdx
    849b:	e8 10 0e 00 00       	call   92b0 <buf_put>
    84a0:	49 83 3e 02          	cmpq   $0x2,(%r14)
    84a4:	72 67                	jb     850d <fwp_write+0x63d>
    84a6:	bb 09 00 00 00       	mov    $0x9,%ebx
    84ab:	4c 8d 3d 0f 72 00 00 	lea    0x720f(%rip),%r15        # f6c1 <fwp_segv.msg+0x441>
    84b2:	4c 8d 25 0b 72 00 00 	lea    0x720b(%rip),%r12        # f6c4 <fwp_segv.msg+0x444>
    84b9:	4c 8d 6c 24 70       	lea    0x70(%rsp),%r13
    84be:	66 90                	xchg   %ax,%ax
    84c0:	ba 02 00 00 00       	mov    $0x2,%edx
    84c5:	48 89 ef             	mov    %rbp,%rdi
    84c8:	4c 89 fe             	mov    %r15,%rsi
    84cb:	e8 e0 0d 00 00       	call   92b0 <buf_put>
    84d0:	41 0f b6 0c 1e       	movzbl (%r14,%rbx,1),%ecx
    84d5:	be 00 02 00 00       	mov    $0x200,%esi
    84da:	4c 89 ef             	mov    %r13,%rdi
    84dd:	4c 89 e2             	mov    %r12,%rdx
    84e0:	31 c0                	xor    %eax,%eax
    84e2:	e8 19 9c ff ff       	call   2100 <snprintf@plt>
    84e7:	4c 89 ef             	mov    %r13,%rdi
    84ea:	e8 e1 9b ff ff       	call   20d0 <strlen@plt>
    84ef:	48 89 ef             	mov    %rbp,%rdi
    84f2:	4c 89 ee             	mov    %r13,%rsi
    84f5:	48 89 c2             	mov    %rax,%rdx
    84f8:	e8 b3 0d 00 00       	call   92b0 <buf_put>
    84fd:	48 8d 43 01          	lea    0x1(%rbx),%rax
    8501:	48 83 c3 f9          	add    $0xfffffffffffffff9,%rbx
    8505:	49 3b 1e             	cmp    (%r14),%rbx
    8508:	48 89 c3             	mov    %rax,%rbx
    850b:	72 b3                	jb     84c0 <fwp_write+0x5f0>
    850d:	c6 44 24 20 5d       	movb   $0x5d,0x20(%rsp)
    8512:	48 8d 74 24 20       	lea    0x20(%rsp),%rsi
    8517:	e9 90 0a 00 00       	jmp    8fac <fwp_write+0x10dc>
    851c:	66 41 0f 6e ce       	movd   %r14d,%xmm1
    8521:	0f 2e c9             	ucomiss %xmm1,%xmm1
    8524:	0f 8a 73 0d 00 00    	jp     929d <fwp_write+0x13cd>
    852a:	0f 28 05 af 6b 00 00 	movaps 0x6baf(%rip),%xmm0        # f0e0 <_IO_stdin_used+0xe0>
    8531:	0f 54 c1             	andps  %xmm1,%xmm0
    8534:	0f 2e 05 d1 6a 00 00 	ucomiss 0x6ad1(%rip),%xmm0        # f00c <_IO_stdin_used+0xc>
    853b:	0f 82 6e 04 00 00    	jb     89af <fwp_write+0xadf>
    8541:	0f 57 c0             	xorps  %xmm0,%xmm0
    8544:	0f 2e c8             	ucomiss %xmm0,%xmm1
    8547:	48 8d 05 a2 71 00 00 	lea    0x71a2(%rip),%rax        # f6f0 <fwp_segv.msg+0x470>
    854e:	48 8d 35 9a 71 00 00 	lea    0x719a(%rip),%rsi        # f6ef <fwp_segv.msg+0x46f>
    8555:	48 0f 47 f0          	cmova  %rax,%rsi
    8559:	48 8d 7c 24 70       	lea    0x70(%rsp),%rdi
    855e:	e8 0d 9b ff ff       	call   2070 <strcpy@plt>
    8563:	e9 90 0b 00 00       	jmp    90f8 <fwp_write+0x1228>
    8568:	48 8d 35 30 71 00 00 	lea    0x7130(%rip),%rsi        # f69f <fwp_segv.msg+0x41f>
    856f:	ba 0a 00 00 00       	mov    $0xa,%edx
    8574:	48 89 ef             	mov    %rbp,%rdi
    8577:	e9 06 09 00 00       	jmp    8e82 <fwp_write+0xfb2>
    857c:	48 8d 35 30 71 00 00 	lea    0x7130(%rip),%rsi        # f6b3 <fwp_segv.msg+0x433>
    8583:	ba 06 00 00 00       	mov    $0x6,%edx
    8588:	48 89 ef             	mov    %rbp,%rdi
    858b:	e8 20 0d 00 00       	call   92b0 <buf_put>
    8590:	49 83 c6 10          	add    $0x10,%r14
    8594:	4c 89 f7             	mov    %r14,%rdi
    8597:	e8 34 9b ff ff       	call   20d0 <strlen@plt>
    859c:	48 89 ef             	mov    %rbp,%rdi
    859f:	4c 89 f6             	mov    %r14,%rsi
    85a2:	48 89 c2             	mov    %rax,%rdx
    85a5:	e8 06 0d 00 00       	call   92b0 <buf_put>
    85aa:	c6 44 24 70 3e       	movb   $0x3e,0x70(%rsp)
    85af:	e9 f3 09 00 00       	jmp    8fa7 <fwp_write+0x10d7>
    85b4:	41 8b 06             	mov    (%r14),%eax
    85b7:	49 8b 4f 18          	mov    0x18(%r15),%rcx
    85bb:	41 89 c5             	mov    %eax,%r13d
    85be:	4e 8b 24 e9          	mov    (%rcx,%r13,8),%r12
    85c2:	4c 89 e7             	mov    %r12,%rdi
    85c5:	e8 06 9b ff ff       	call   20d0 <strlen@plt>
    85ca:	48 89 ef             	mov    %rbp,%rdi
    85cd:	4c 89 e6             	mov    %r12,%rsi
    85d0:	48 89 c2             	mov    %rax,%rdx
    85d3:	e8 d8 0c 00 00       	call   92b0 <buf_put>
    85d8:	49 8b 47 28          	mov    0x28(%r15),%rax
    85dc:	42 83 3c a8 00       	cmpl   $0x0,(%rax,%r13,4)
    85e1:	0f 8e 2c 0b 00 00    	jle    9113 <fwp_write+0x1243>
    85e7:	45 31 e4             	xor    %r12d,%r12d
    85ea:	4c 89 7c 24 10       	mov    %r15,0x10(%rsp)
    85ef:	4c 89 6c 24 68       	mov    %r13,0x68(%rsp)
    85f4:	eb 3c                	jmp    8632 <fwp_write+0x762>
    85f6:	66 2e 0f 1f 84 00 00 	cs nopw 0x0(%rax,%rax,1)
    85fd:	00 00 00 
    8600:	48 8b 2c 24          	mov    (%rsp),%rbp
    8604:	48 89 ef             	mov    %rbp,%rdi
    8607:	48 89 de             	mov    %rbx,%rsi
    860a:	4c 89 ea             	mov    %r13,%rdx
    860d:	31 c9                	xor    %ecx,%ecx
    860f:	e8 bc f8 ff ff       	call   7ed0 <fwp_write>
    8614:	49 ff c4             	inc    %r12
    8617:	4c 8b 7c 24 10       	mov    0x10(%rsp),%r15
    861c:	49 8b 47 28          	mov    0x28(%r15),%rax
    8620:	4c 8b 6c 24 68       	mov    0x68(%rsp),%r13
    8625:	4a 63 04 a8          	movslq (%rax,%r13,4),%rax
    8629:	49 39 c4             	cmp    %rax,%r12
    862c:	0f 8d e1 0a 00 00    	jge    9113 <fwp_write+0x1243>
    8632:	4b 8b 5c e6 08       	mov    0x8(%r14,%r12,8),%rbx
    8637:	49 8b 47 30          	mov    0x30(%r15),%rax
    863b:	4a 8b 04 e8          	mov    (%rax,%r13,8),%rax
    863f:	4e 8b 2c e0          	mov    (%rax,%r12,8),%r13
    8643:	c6 44 24 70 20       	movb   $0x20,0x70(%rsp)
    8648:	ba 01 00 00 00       	mov    $0x1,%edx
    864d:	48 89 ef             	mov    %rbp,%rdi
    8650:	48 8d 74 24 70       	lea    0x70(%rsp),%rsi
    8655:	e8 56 0c 00 00       	call   92b0 <buf_put>
    865a:	41 8b 45 00          	mov    0x0(%r13),%eax
    865e:	48 83 f8 10          	cmp    $0x10,%rax
    8662:	77 9c                	ja     8600 <fwp_write+0x730>
    8664:	48 8d 0d 1d 6b 00 00 	lea    0x6b1d(%rip),%rcx        # f188 <_IO_stdin_used+0x188>
    866b:	48 63 04 81          	movslq (%rcx,%rax,4),%rax
    866f:	48 01 c8             	add    %rcx,%rax
    8672:	ff e0                	jmp    *%rax
    8674:	48 89 d9             	mov    %rbx,%rcx
    8677:	48 c1 e9 3f          	shr    $0x3f,%rcx
    867b:	85 c9                	test   %ecx,%ecx
    867d:	74 81                	je     8600 <fwp_write+0x730>
    867f:	c6 44 24 70 28       	movb   $0x28,0x70(%rsp)
    8684:	ba 01 00 00 00       	mov    $0x1,%edx
    8689:	48 8b 2c 24          	mov    (%rsp),%rbp
    868d:	48 89 ef             	mov    %rbp,%rdi
    8690:	4c 8d 7c 24 70       	lea    0x70(%rsp),%r15
    8695:	4c 89 fe             	mov    %r15,%rsi
    8698:	e8 13 0c 00 00       	call   92b0 <buf_put>
    869d:	48 89 ef             	mov    %rbp,%rdi
    86a0:	48 89 de             	mov    %rbx,%rsi
    86a3:	4c 89 ea             	mov    %r13,%rdx
    86a6:	31 c9                	xor    %ecx,%ecx
    86a8:	e8 23 f8 ff ff       	call   7ed0 <fwp_write>
    86ad:	c6 44 24 70 29       	movb   $0x29,0x70(%rsp)
    86b2:	ba 01 00 00 00       	mov    $0x1,%edx
    86b7:	48 89 ef             	mov    %rbp,%rdi
    86ba:	4c 89 fe             	mov    %r15,%rsi
    86bd:	e8 ee 0b 00 00       	call   92b0 <buf_put>
    86c2:	e9 4d ff ff ff       	jmp    8614 <fwp_write+0x744>
    86c7:	31 c9                	xor    %ecx,%ecx
    86c9:	48 81 fb 00 10 00 00 	cmp    $0x1000,%rbx
    86d0:	0f 93 c1             	setae  %cl
    86d3:	eb a6                	jmp    867b <fwp_write+0x7ab>
    86d5:	48 8b 4b 08          	mov    0x8(%rbx),%rcx
    86d9:	eb 9c                	jmp    8677 <fwp_write+0x7a7>
    86db:	89 d9                	mov    %ebx,%ecx
    86dd:	c1 e9 1f             	shr    $0x1f,%ecx
    86e0:	eb 99                	jmp    867b <fwp_write+0x7ab>
    86e2:	49 8b 7d 08          	mov    0x8(%r13),%rdi
    86e6:	48 85 ff             	test   %rdi,%rdi
    86e9:	0f 84 11 ff ff ff    	je     8600 <fwp_write+0x730>
    86ef:	48 8d 35 e5 6f 00 00 	lea    0x6fe5(%rip),%rsi        # f6db <fwp_segv.msg+0x45b>
    86f6:	e8 75 9a ff ff       	call   2170 <strcmp@plt>
    86fb:	31 c9                	xor    %ecx,%ecx
    86fd:	85 c0                	test   %eax,%eax
    86ff:	0f 95 c1             	setne  %cl
    8702:	e9 74 ff ff ff       	jmp    867b <fwp_write+0x7ab>
    8707:	41 83 7f 10 00       	cmpl   $0x0,0x10(%r15)
    870c:	0f 84 a7 08 00 00    	je     8fb9 <fwp_write+0x10e9>
    8712:	4d 8d 6f 10          	lea    0x10(%r15),%r13
    8716:	4d 85 e4             	test   %r12,%r12
    8719:	0f 94 c0             	sete   %al
    871c:	41 83 7f 48 00       	cmpl   $0x0,0x48(%r15)
    8721:	0f 95 c3             	setne  %bl
    8724:	20 c3                	and    %al,%bl
    8726:	84 db                	test   %bl,%bl
    8728:	b8 28 00 00 00       	mov    $0x28,%eax
    872d:	b9 7b 00 00 00       	mov    $0x7b,%ecx
    8732:	0f 45 c8             	cmovne %eax,%ecx
    8735:	88 4c 24 70          	mov    %cl,0x70(%rsp)
    8739:	48 8d 74 24 70       	lea    0x70(%rsp),%rsi
    873e:	ba 01 00 00 00       	mov    $0x1,%edx
    8743:	48 89 ef             	mov    %rbp,%rdi
    8746:	e8 65 0b 00 00       	call   92b0 <buf_put>
    874b:	41 83 7d 00 00       	cmpl   $0x0,0x0(%r13)
    8750:	0f 8e da 00 00 00    	jle    8830 <fwp_write+0x960>
    8756:	84 db                	test   %bl,%bl
    8758:	75 31                	jne    878b <fwp_write+0x8bb>
    875a:	49 8b 47 18          	mov    0x18(%r15),%rax
    875e:	4c 8b 20             	mov    (%rax),%r12
    8761:	4c 89 e7             	mov    %r12,%rdi
    8764:	e8 67 99 ff ff       	call   20d0 <strlen@plt>
    8769:	48 89 ef             	mov    %rbp,%rdi
    876c:	4c 89 e6             	mov    %r12,%rsi
    876f:	48 89 c2             	mov    %rax,%rdx
    8772:	e8 39 0b 00 00       	call   92b0 <buf_put>
    8777:	48 8d 35 69 6f 00 00 	lea    0x6f69(%rip),%rsi        # f6e7 <fwp_segv.msg+0x467>
    877e:	ba 03 00 00 00       	mov    $0x3,%edx
    8783:	48 89 ef             	mov    %rbp,%rdi
    8786:	e8 25 0b 00 00       	call   92b0 <buf_put>
    878b:	49 8b 76 08          	mov    0x8(%r14),%rsi
    878f:	49 8b 47 20          	mov    0x20(%r15),%rax
    8793:	48 8b 10             	mov    (%rax),%rdx
    8796:	48 89 ef             	mov    %rbp,%rdi
    8799:	31 c9                	xor    %ecx,%ecx
    879b:	e8 30 f7 ff ff       	call   7ed0 <fwp_write>
    87a0:	41 83 7f 10 02       	cmpl   $0x2,0x10(%r15)
    87a5:	0f 8c 85 00 00 00    	jl     8830 <fwp_write+0x960>
    87ab:	41 bd 01 00 00 00    	mov    $0x1,%r13d
    87b1:	4c 8d 25 09 6f 00 00 	lea    0x6f09(%rip),%r12        # f6c1 <fwp_segv.msg+0x441>
    87b8:	eb 29                	jmp    87e3 <fwp_write+0x913>
    87ba:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)
    87c0:	4b 8b 74 ee 08       	mov    0x8(%r14,%r13,8),%rsi
    87c5:	49 8b 47 20          	mov    0x20(%r15),%rax
    87c9:	4a 8b 14 e8          	mov    (%rax,%r13,8),%rdx
    87cd:	48 89 ef             	mov    %rbp,%rdi
    87d0:	31 c9                	xor    %ecx,%ecx
    87d2:	e8 f9 f6 ff ff       	call   7ed0 <fwp_write>
    87d7:	49 ff c5             	inc    %r13
    87da:	49 63 47 10          	movslq 0x10(%r15),%rax
    87de:	49 39 c5             	cmp    %rax,%r13
    87e1:	7d 4d                	jge    8830 <fwp_write+0x960>
    87e3:	ba 02 00 00 00       	mov    $0x2,%edx
    87e8:	48 89 ef             	mov    %rbp,%rdi
    87eb:	4c 89 e6             	mov    %r12,%rsi
    87ee:	e8 bd 0a 00 00       	call   92b0 <buf_put>
    87f3:	84 db                	test   %bl,%bl
    87f5:	75 c9                	jne    87c0 <fwp_write+0x8f0>
    87f7:	49 8b 47 18          	mov    0x18(%r15),%rax
    87fb:	4a 8b 2c e8          	mov    (%rax,%r13,8),%rbp
    87ff:	48 89 ef             	mov    %rbp,%rdi
    8802:	e8 c9 98 ff ff       	call   20d0 <strlen@plt>
    8807:	48 8b 3c 24          	mov    (%rsp),%rdi
    880b:	48 89 ee             	mov    %rbp,%rsi
    880e:	48 8b 2c 24          	mov    (%rsp),%rbp
    8812:	48 89 c2             	mov    %rax,%rdx
    8815:	e8 96 0a 00 00       	call   92b0 <buf_put>
    881a:	ba 03 00 00 00       	mov    $0x3,%edx
    881f:	48 89 ef             	mov    %rbp,%rdi
    8822:	48 8d 35 be 6e 00 00 	lea    0x6ebe(%rip),%rsi        # f6e7 <fwp_segv.msg+0x467>
    8829:	e8 82 0a 00 00       	call   92b0 <buf_put>
    882e:	eb 90                	jmp    87c0 <fwp_write+0x8f0>
    8830:	84 db                	test   %bl,%bl
    8832:	b8 29 00 00 00       	mov    $0x29,%eax
    8837:	b9 7d 00 00 00       	mov    $0x7d,%ecx
    883c:	0f 45 c8             	cmovne %eax,%ecx
    883f:	88 4c 24 70          	mov    %cl,0x70(%rsp)
    8843:	e9 5f 07 00 00       	jmp    8fa7 <fwp_write+0x10d7>
    8848:	48 89 ef             	mov    %rbp,%rdi
    884b:	48 81 c4 78 02 00 00 	add    $0x278,%rsp
    8852:	5b                   	pop    %rbx
    8853:	41 5c                	pop    %r12
    8855:	41 5d                	pop    %r13
    8857:	41 5e                	pop    %r14
    8859:	41 5f                	pop    %r15
    885b:	5d                   	pop    %rbp
    885c:	e9 3f 0b 00 00       	jmp    93a0 <fwp_escape>
    8861:	c6 44 24 20 30       	movb   $0x30,0x20(%rsp)
    8866:	bf 01 00 00 00       	mov    $0x1,%edi
    886b:	89 f8                	mov    %edi,%eax
    886d:	48 83 f8 08          	cmp    $0x8,%rax
    8871:	73 0a                	jae    887d <fwp_write+0x9ad>
    8873:	31 c9                	xor    %ecx,%ecx
    8875:	48 89 c2             	mov    %rax,%rdx
    8878:	e9 7a 04 00 00       	jmp    8cf7 <fwp_write+0xe27>
    887d:	83 f8 20             	cmp    $0x20,%eax
    8880:	0f 83 68 03 00 00    	jae    8bee <fwp_write+0xd1e>
    8886:	31 c9                	xor    %ecx,%ecx
    8888:	e9 10 04 00 00       	jmp    8c9d <fwp_write+0xdcd>
    888d:	31 ff                	xor    %edi,%edi
    888f:	49 f7 d8             	neg    %r8
    8892:	41 ba 00 00 00 00    	mov    $0x0,%r10d
    8898:	4d 19 ca             	sbb    %r9,%r10
    889b:	c6 44 24 70 2d       	movb   $0x2d,0x70(%rsp)
    88a0:	49 b9 cd cc cc cc cc 	movabs $0xcccccccccccccccd,%r9
    88a7:	cc cc cc 
    88aa:	49 bb cc cc cc cc cc 	movabs $0xcccccccccccccccc,%r11
    88b1:	cc cc cc 
    88b4:	4c 89 d3             	mov    %r10,%rbx
    88b7:	66 0f 1f 84 00 00 00 	nopw   0x0(%rax,%rax,1)
    88be:	00 00 
    88c0:	4c 89 d1             	mov    %r10,%rcx
    88c3:	4c 0f a4 c1 3f       	shld   $0x3f,%r8,%rcx
    88c8:	48 d1 eb             	shr    $1,%rbx
    88cb:	48 89 ce             	mov    %rcx,%rsi
    88ce:	48 01 de             	add    %rbx,%rsi
    88d1:	48 83 d6 00          	adc    $0x0,%rsi
    88d5:	48 89 f0             	mov    %rsi,%rax
    88d8:	49 f7 e1             	mul    %r9
    88db:	48 c1 ea 02          	shr    $0x2,%rdx
    88df:	48 8d 04 92          	lea    (%rdx,%rdx,4),%rax
    88e3:	48 29 c6             	sub    %rax,%rsi
    88e6:	48 29 f1             	sub    %rsi,%rcx
    88e9:	48 83 db 00          	sbb    $0x0,%rbx
    88ed:	48 89 ce             	mov    %rcx,%rsi
    88f0:	49 0f af f3          	imul   %r11,%rsi
    88f4:	48 89 c8             	mov    %rcx,%rax
    88f7:	49 f7 e1             	mul    %r9
    88fa:	48 01 f2             	add    %rsi,%rdx
    88fd:	49 0f af d9          	imul   %r9,%rbx
    8901:	48 01 d3             	add    %rdx,%rbx
    8904:	48 89 c1             	mov    %rax,%rcx
    8907:	48 01 c1             	add    %rax,%rcx
    890a:	48 8d 0c 89          	lea    (%rcx,%rcx,4),%rcx
    890e:	44 89 c2             	mov    %r8d,%edx
    8911:	29 ca                	sub    %ecx,%edx
    8913:	80 ca 30             	or     $0x30,%dl
    8916:	88 54 3c 20          	mov    %dl,0x20(%rsp,%rdi,1)
    891a:	48 ff c7             	inc    %rdi
    891d:	49 83 f8 0a          	cmp    $0xa,%r8
    8921:	49 83 da 00          	sbb    $0x0,%r10
    8925:	49 89 c0             	mov    %rax,%r8
    8928:	49 89 da             	mov    %rbx,%r10
    892b:	73 93                	jae    88c0 <fwp_write+0x9f0>
    892d:	85 ff                	test   %edi,%edi
    892f:	0f 8e 98 06 00 00    	jle    8fcd <fwp_write+0x10fd>
    8935:	89 f8                	mov    %edi,%eax
    8937:	48 83 f8 08          	cmp    $0x8,%rax
    893b:	0f 83 e4 07 00 00    	jae    9125 <fwp_write+0x1255>
    8941:	31 c9                	xor    %ecx,%ecx
    8943:	48 89 c2             	mov    %rax,%rdx
    8946:	e9 fc 08 00 00       	jmp    9247 <fwp_write+0x1377>
    894b:	bd 01 00 00 00       	mov    $0x1,%ebp
    8950:	4c 8d 74 24 70       	lea    0x70(%rsp),%r14
    8955:	0f 29 4c 24 10       	movaps %xmm1,0x10(%rsp)
    895a:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)
    8960:	4c 89 f7             	mov    %r14,%rdi
    8963:	66 0f 28 c1          	movapd %xmm1,%xmm0
    8967:	89 ee                	mov    %ebp,%esi
    8969:	e8 a2 16 00 00       	call   a010 <fwp_format_g>
    896e:	4c 89 f7             	mov    %r14,%rdi
    8971:	31 f6                	xor    %esi,%esi
    8973:	e8 18 97 ff ff       	call   2090 <strtod@plt>
    8978:	66 0f 28 4c 24 10    	movapd 0x10(%rsp),%xmm1
    897e:	66 0f 2e c1          	ucomisd %xmm1,%xmm0
    8982:	75 06                	jne    898a <fwp_write+0xaba>
    8984:	0f 8b 9e 03 00 00    	jnp    8d28 <fwp_write+0xe58>
    898a:	ff c5                	inc    %ebp
    898c:	83 fd 12             	cmp    $0x12,%ebp
    898f:	75 cf                	jne    8960 <fwp_write+0xa90>
    8991:	4c 8d 74 24 70       	lea    0x70(%rsp),%r14
    8996:	4c 89 f7             	mov    %r14,%rdi
    8999:	66 0f 28 c1          	movapd %xmm1,%xmm0
    899d:	be 11 00 00 00       	mov    $0x11,%esi
    89a2:	e8 69 16 00 00       	call   a010 <fwp_format_g>
    89a7:	4c 89 f7             	mov    %r14,%rdi
    89aa:	e9 7e 03 00 00       	jmp    8d2d <fwp_write+0xe5d>
    89af:	0f 57 c0             	xorps  %xmm0,%xmm0
    89b2:	f3 0f 5a c1          	cvtss2sd %xmm1,%xmm0
    89b6:	4c 8d 74 24 70       	lea    0x70(%rsp),%r14
    89bb:	4c 89 f7             	mov    %r14,%rdi
    89be:	f2 0f 11 44 24 10    	movsd  %xmm0,0x10(%rsp)
    89c4:	be 01 00 00 00       	mov    $0x1,%esi
    89c9:	0f 29 0c 24          	movaps %xmm1,(%rsp)
    89cd:	e8 3e 16 00 00       	call   a010 <fwp_format_g>
    89d2:	4c 89 f7             	mov    %r14,%rdi
    89d5:	31 f6                	xor    %esi,%esi
    89d7:	e8 34 97 ff ff       	call   2110 <strtof@plt>
    89dc:	0f 2e 04 24          	ucomiss (%rsp),%xmm0
    89e0:	75 06                	jne    89e8 <fwp_write+0xb18>
    89e2:	0f 8b 6f 01 00 00    	jnp    8b57 <fwp_write+0xc87>
    89e8:	4c 8d 74 24 70       	lea    0x70(%rsp),%r14
    89ed:	4c 89 f7             	mov    %r14,%rdi
    89f0:	f2 0f 10 44 24 10    	movsd  0x10(%rsp),%xmm0
    89f6:	be 02 00 00 00       	mov    $0x2,%esi
    89fb:	e8 10 16 00 00       	call   a010 <fwp_format_g>
    8a00:	4c 89 f7             	mov    %r14,%rdi
    8a03:	31 f6                	xor    %esi,%esi
    8a05:	e8 06 97 ff ff       	call   2110 <strtof@plt>
    8a0a:	0f 2e 04 24          	ucomiss (%rsp),%xmm0
    8a0e:	75 06                	jne    8a16 <fwp_write+0xb46>
    8a10:	0f 8b 41 01 00 00    	jnp    8b57 <fwp_write+0xc87>
    8a16:	4c 8d 74 24 70       	lea    0x70(%rsp),%r14
    8a1b:	4c 89 f7             	mov    %r14,%rdi
    8a1e:	f2 0f 10 44 24 10    	movsd  0x10(%rsp),%xmm0
    8a24:	be 03 00 00 00       	mov    $0x3,%esi
    8a29:	e8 e2 15 00 00       	call   a010 <fwp_format_g>
    8a2e:	4c 89 f7             	mov    %r14,%rdi
    8a31:	31 f6                	xor    %esi,%esi
    8a33:	e8 d8 96 ff ff       	call   2110 <strtof@plt>
    8a38:	0f 2e 04 24          	ucomiss (%rsp),%xmm0
    8a3c:	75 06                	jne    8a44 <fwp_write+0xb74>
    8a3e:	0f 8b 13 01 00 00    	jnp    8b57 <fwp_write+0xc87>
    8a44:	4c 8d 74 24 70       	lea    0x70(%rsp),%r14
    8a49:	4c 89 f7             	mov    %r14,%rdi
    8a4c:	f2 0f 10 44 24 10    	movsd  0x10(%rsp),%xmm0
    8a52:	be 04 00 00 00       	mov    $0x4,%esi
    8a57:	e8 b4 15 00 00       	call   a010 <fwp_format_g>
    8a5c:	4c 89 f7             	mov    %r14,%rdi
    8a5f:	31 f6                	xor    %esi,%esi
    8a61:	e8 aa 96 ff ff       	call   2110 <strtof@plt>
    8a66:	0f 2e 04 24          	ucomiss (%rsp),%xmm0
    8a6a:	75 06                	jne    8a72 <fwp_write+0xba2>
    8a6c:	0f 8b e5 00 00 00    	jnp    8b57 <fwp_write+0xc87>
    8a72:	4c 8d 74 24 70       	lea    0x70(%rsp),%r14
    8a77:	4c 89 f7             	mov    %r14,%rdi
    8a7a:	f2 0f 10 44 24 10    	movsd  0x10(%rsp),%xmm0
    8a80:	be 05 00 00 00       	mov    $0x5,%esi
    8a85:	e8 86 15 00 00       	call   a010 <fwp_format_g>
    8a8a:	4c 89 f7             	mov    %r14,%rdi
    8a8d:	31 f6                	xor    %esi,%esi
    8a8f:	e8 7c 96 ff ff       	call   2110 <strtof@plt>
    8a94:	0f 2e 04 24          	ucomiss (%rsp),%xmm0
    8a98:	75 06                	jne    8aa0 <fwp_write+0xbd0>
    8a9a:	0f 8b b7 00 00 00    	jnp    8b57 <fwp_write+0xc87>
    8aa0:	4c 8d 74 24 70       	lea    0x70(%rsp),%r14
    8aa5:	4c 89 f7             	mov    %r14,%rdi
    8aa8:	f2 0f 10 44 24 10    	movsd  0x10(%rsp),%xmm0
    8aae:	be 06 00 00 00       	mov    $0x6,%esi
    8ab3:	e8 58 15 00 00       	call   a010 <fwp_format_g>
    8ab8:	4c 89 f7             	mov    %r14,%rdi
    8abb:	31 f6                	xor    %esi,%esi
    8abd:	e8 4e 96 ff ff       	call   2110 <strtof@plt>
    8ac2:	0f 2e 04 24          	ucomiss (%rsp),%xmm0
    8ac6:	75 06                	jne    8ace <fwp_write+0xbfe>
    8ac8:	0f 8b 89 00 00 00    	jnp    8b57 <fwp_write+0xc87>
    8ace:	4c 8d 74 24 70       	lea    0x70(%rsp),%r14
    8ad3:	4c 89 f7             	mov    %r14,%rdi
    8ad6:	f2 0f 10 44 24 10    	movsd  0x10(%rsp),%xmm0
    8adc:	be 07 00 00 00       	mov    $0x7,%esi
    8ae1:	e8 2a 15 00 00       	call   a010 <fwp_format_g>
    8ae6:	4c 89 f7             	mov    %r14,%rdi
    8ae9:	31 f6                	xor    %esi,%esi
    8aeb:	e8 20 96 ff ff       	call   2110 <strtof@plt>
    8af0:	0f 2e 04 24          	ucomiss (%rsp),%xmm0
    8af4:	75 02                	jne    8af8 <fwp_write+0xc28>
    8af6:	7b 5f                	jnp    8b57 <fwp_write+0xc87>
    8af8:	4c 8d 74 24 70       	lea    0x70(%rsp),%r14
    8afd:	4c 89 f7             	mov    %r14,%rdi
    8b00:	f2 0f 10 44 24 10    	movsd  0x10(%rsp),%xmm0
    8b06:	be 08 00 00 00       	mov    $0x8,%esi
    8b0b:	e8 00 15 00 00       	call   a010 <fwp_format_g>
    8b10:	4c 89 f7             	mov    %r14,%rdi
    8b13:	31 f6                	xor    %esi,%esi
    8b15:	e8 f6 95 ff ff       	call   2110 <strtof@plt>
    8b1a:	0f 28 0c 24          	movaps (%rsp),%xmm1
    8b1e:	0f 2e c1             	ucomiss %xmm1,%xmm0
    8b21:	75 02                	jne    8b25 <fwp_write+0xc55>
    8b23:	7b 32                	jnp    8b57 <fwp_write+0xc87>
    8b25:	4c 8d 74 24 70       	lea    0x70(%rsp),%r14
    8b2a:	4c 89 f7             	mov    %r14,%rdi
    8b2d:	f2 0f 10 44 24 10    	movsd  0x10(%rsp),%xmm0
    8b33:	be 09 00 00 00       	mov    $0x9,%esi
    8b38:	e8 d3 14 00 00       	call   a010 <fwp_format_g>
    8b3d:	4c 89 f7             	mov    %r14,%rdi
    8b40:	31 f6                	xor    %esi,%esi
    8b42:	e8 c9 95 ff ff       	call   2110 <strtof@plt>
    8b47:	0f 2e 04 24          	ucomiss (%rsp),%xmm0
    8b4b:	0f 85 2c 07 00 00    	jne    927d <fwp_write+0x13ad>
    8b51:	0f 8a 26 07 00 00    	jp     927d <fwp_write+0x13ad>
    8b57:	48 8d 7c 24 70       	lea    0x70(%rsp),%rdi
    8b5c:	be 2e 00 00 00       	mov    $0x2e,%esi
    8b61:	e8 8a 95 ff ff       	call   20f0 <strchr@plt>
    8b66:	48 85 c0             	test   %rax,%rax
    8b69:	0f 85 89 05 00 00    	jne    90f8 <fwp_write+0x1228>
    8b6f:	e9 d0 01 00 00       	jmp    8d44 <fwp_write+0xe74>
    8b74:	4c 8b bc f0 d0 03 00 	mov    0x3d0(%rax,%rsi,8),%r15
    8b7b:	00 
    8b7c:	48 8b bc f0 d8 03 00 	mov    0x3d8(%rax,%rsi,8),%rdi
    8b83:	00 
    8b84:	4c 29 ff             	sub    %r15,%rdi
    8b87:	48 39 cf             	cmp    %rcx,%rdi
    8b8a:	0f 83 1b 02 00 00    	jae    8dab <fwp_write+0xedb>
    8b90:	48 89 d7             	mov    %rdx,%rdi
    8b93:	be 01 00 00 00       	mov    $0x1,%esi
    8b98:	e8 63 e3 ff ff       	call   6f00 <fwp_gc_alloc_slow>
    8b9d:	49 89 c7             	mov    %rax,%r15
    8ba0:	e9 20 02 00 00       	jmp    8dc5 <fwp_write+0xef5>
    8ba5:	49 8b 76 08          	mov    0x8(%r14),%rsi
    8ba9:	48 89 f2             	mov    %rsi,%rdx
    8bac:	48 c1 fa 3f          	sar    $0x3f,%rdx
    8bb0:	4c 8d 74 24 70       	lea    0x70(%rsp),%r14
    8bb5:	4c 89 f7             	mov    %r14,%rdi
    8bb8:	e8 23 09 00 00       	call   94e0 <fwp_fmt_duration>
    8bbd:	e9 3b 05 00 00       	jmp    90fd <fwp_write+0x122d>
    8bc2:	c6 44 24 20 30       	movb   $0x30,0x20(%rsp)
    8bc7:	bf 01 00 00 00       	mov    $0x1,%edi
    8bcc:	89 f8                	mov    %edi,%eax
    8bce:	48 83 f8 08          	cmp    $0x8,%rax
    8bd2:	73 0a                	jae    8bde <fwp_write+0xd0e>
    8bd4:	31 c9                	xor    %ecx,%ecx
    8bd6:	48 89 c2             	mov    %rax,%rdx
    8bd9:	e9 f2 04 00 00       	jmp    90d0 <fwp_write+0x1200>
    8bde:	83 f8 20             	cmp    $0x20,%eax
    8be1:	0f 83 f2 03 00 00    	jae    8fd9 <fwp_write+0x1109>
    8be7:	31 c9                	xor    %ecx,%ecx
    8be9:	e9 92 04 00 00       	jmp    9080 <fwp_write+0x11b0>
    8bee:	89 fa                	mov    %edi,%edx
    8bf0:	83 e2 1f             	and    $0x1f,%edx
    8bf3:	48 89 c1             	mov    %rax,%rcx
    8bf6:	48 29 d1             	sub    %rdx,%rcx
    8bf9:	48 8d b4 24 80 00 00 	lea    0x80(%rsp),%rsi
    8c00:	00 
    8c01:	66 0f ef c0          	pxor   %xmm0,%xmm0
    8c05:	49 89 c0             	mov    %rax,%r8
    8c08:	0f 1f 84 00 00 00 00 	nopl   0x0(%rax,%rax,1)
    8c0f:	00 
    8c10:	f3 42 0f 6f 0c 04    	movdqu (%rsp,%r8,1),%xmm1
    8c16:	f3 42 0f 6f 54 04 10 	movdqu 0x10(%rsp,%r8,1),%xmm2
    8c1d:	66 0f 6f da          	movdqa %xmm2,%xmm3
    8c21:	66 0f 60 d8          	punpcklbw %xmm0,%xmm3
    8c25:	66 0f 70 db 4e       	pshufd $0x4e,%xmm3,%xmm3
    8c2a:	f2 0f 70 db 1b       	pshuflw $0x1b,%xmm3,%xmm3
    8c2f:	f3 0f 70 db 1b       	pshufhw $0x1b,%xmm3,%xmm3
    8c34:	66 0f 68 d0          	punpckhbw %xmm0,%xmm2
    8c38:	66 0f 70 d2 4e       	pshufd $0x4e,%xmm2,%xmm2
    8c3d:	f2 0f 70 d2 1b       	pshuflw $0x1b,%xmm2,%xmm2
    8c42:	f3 0f 70 d2 1b       	pshufhw $0x1b,%xmm2,%xmm2
    8c47:	66 0f 67 d3          	packuswb %xmm3,%xmm2
    8c4b:	66 0f 6f d9          	movdqa %xmm1,%xmm3
    8c4f:	66 0f 60 d8          	punpcklbw %xmm0,%xmm3
    8c53:	66 0f 70 db 4e       	pshufd $0x4e,%xmm3,%xmm3
    8c58:	f2 0f 70 db 1b       	pshuflw $0x1b,%xmm3,%xmm3
    8c5d:	f3 0f 70 db 1b       	pshufhw $0x1b,%xmm3,%xmm3
    8c62:	66 0f 68 c8          	punpckhbw %xmm0,%xmm1
    8c66:	66 0f 70 c9 4e       	pshufd $0x4e,%xmm1,%xmm1
    8c6b:	f2 0f 70 c9 1b       	pshuflw $0x1b,%xmm1,%xmm1
    8c70:	f3 0f 70 c9 1b       	pshufhw $0x1b,%xmm1,%xmm1
    8c75:	66 0f 67 cb          	packuswb %xmm3,%xmm1
    8c79:	66 0f 7f 56 f0       	movdqa %xmm2,-0x10(%rsi)
    8c7e:	66 0f 7f 0e          	movdqa %xmm1,(%rsi)
    8c82:	49 83 c0 e0          	add    $0xffffffffffffffe0,%r8
    8c86:	48 83 c6 20          	add    $0x20,%rsi
    8c8a:	4c 39 c2             	cmp    %r8,%rdx
    8c8d:	75 81                	jne    8c10 <fwp_write+0xd40>
    8c8f:	48 85 d2             	test   %rdx,%rdx
    8c92:	0f 84 5b 04 00 00    	je     90f3 <fwp_write+0x1223>
    8c98:	83 fa 08             	cmp    $0x8,%edx
    8c9b:	72 5a                	jb     8cf7 <fwp_write+0xe27>
    8c9d:	89 fa                	mov    %edi,%edx
    8c9f:	83 e2 07             	and    $0x7,%edx
    8ca2:	48 89 c6             	mov    %rax,%rsi
    8ca5:	48 29 ce             	sub    %rcx,%rsi
    8ca8:	48 8d 3c 0c          	lea    (%rsp,%rcx,1),%rdi
    8cac:	48 83 c7 70          	add    $0x70,%rdi
    8cb0:	48 89 c1             	mov    %rax,%rcx
    8cb3:	48 29 d1             	sub    %rdx,%rcx
    8cb6:	66 0f ef c0          	pxor   %xmm0,%xmm0
    8cba:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)
    8cc0:	f3 0f 7e 4c 34 18    	movq   0x18(%rsp,%rsi,1),%xmm1
    8cc6:	66 0f 60 c8          	punpcklbw %xmm0,%xmm1
    8cca:	66 0f 70 c9 4e       	pshufd $0x4e,%xmm1,%xmm1
    8ccf:	f2 0f 70 c9 1b       	pshuflw $0x1b,%xmm1,%xmm1
    8cd4:	f3 0f 70 c9 1b       	pshufhw $0x1b,%xmm1,%xmm1
    8cd9:	66 0f 67 c9          	packuswb %xmm1,%xmm1
    8cdd:	66 0f d6 0f          	movq   %xmm1,(%rdi)
    8ce1:	48 83 c6 f8          	add    $0xfffffffffffffff8,%rsi
    8ce5:	48 83 c7 08          	add    $0x8,%rdi
    8ce9:	48 39 f2             	cmp    %rsi,%rdx
    8cec:	75 d2                	jne    8cc0 <fwp_write+0xdf0>
    8cee:	48 85 d2             	test   %rdx,%rdx
    8cf1:	0f 84 fc 03 00 00    	je     90f3 <fwp_write+0x1223>
    8cf7:	48 8d 74 24 20       	lea    0x20(%rsp),%rsi
    8cfc:	48 01 f2             	add    %rsi,%rdx
    8cff:	48 ff ca             	dec    %rdx
    8d02:	66 66 66 66 66 2e 0f 	data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    8d09:	1f 84 00 00 00 00 00 
    8d10:	0f b6 32             	movzbl (%rdx),%esi
    8d13:	40 88 74 0c 70       	mov    %sil,0x70(%rsp,%rcx,1)
    8d18:	48 ff c1             	inc    %rcx
    8d1b:	48 ff ca             	dec    %rdx
    8d1e:	48 39 c8             	cmp    %rcx,%rax
    8d21:	75 ed                	jne    8d10 <fwp_write+0xe40>
    8d23:	e9 cb 03 00 00       	jmp    90f3 <fwp_write+0x1223>
    8d28:	48 8d 7c 24 70       	lea    0x70(%rsp),%rdi
    8d2d:	be 2e 00 00 00       	mov    $0x2e,%esi
    8d32:	e8 b9 93 ff ff       	call   20f0 <strchr@plt>
    8d37:	48 85 c0             	test   %rax,%rax
    8d3a:	48 8b 2c 24          	mov    (%rsp),%rbp
    8d3e:	0f 85 b4 03 00 00    	jne    90f8 <fwp_write+0x1228>
    8d44:	48 8d 7c 24 70       	lea    0x70(%rsp),%rdi
    8d49:	be 65 00 00 00       	mov    $0x65,%esi
    8d4e:	e8 9d 93 ff ff       	call   20f0 <strchr@plt>
    8d53:	48 85 c0             	test   %rax,%rax
    8d56:	0f 85 9c 03 00 00    	jne    90f8 <fwp_write+0x1228>
    8d5c:	48 8d 35 8d 69 00 00 	lea    0x698d(%rip),%rsi        # f6f0 <fwp_segv.msg+0x470>
    8d63:	48 8d 7c 24 70       	lea    0x70(%rsp),%rdi
    8d68:	e8 53 95 ff ff       	call   22c0 <strstr@plt>
    8d6d:	48 85 c0             	test   %rax,%rax
    8d70:	0f 85 82 03 00 00    	jne    90f8 <fwp_write+0x1228>
    8d76:	48 8d 35 6e 69 00 00 	lea    0x696e(%rip),%rsi        # f6eb <fwp_segv.msg+0x46b>
    8d7d:	48 8d 7c 24 70       	lea    0x70(%rsp),%rdi
    8d82:	e8 39 95 ff ff       	call   22c0 <strstr@plt>
    8d87:	48 85 c0             	test   %rax,%rax
    8d8a:	0f 85 68 03 00 00    	jne    90f8 <fwp_write+0x1228>
    8d90:	48 8d 7c 24 70       	lea    0x70(%rsp),%rdi
    8d95:	e8 36 93 ff ff       	call   20d0 <strlen@plt>
    8d9a:	66 c7 44 04 70 2e 30 	movw   $0x302e,0x70(%rsp,%rax,1)
    8da1:	c6 44 04 72 00       	movb   $0x0,0x72(%rsp,%rax,1)
    8da6:	e9 4d 03 00 00       	jmp    90f8 <fwp_write+0x1228>
    8dab:	48 8d 04 f0          	lea    (%rax,%rsi,8),%rax
    8daf:	48 05 d0 03 00 00    	add    $0x3d0,%rax
    8db5:	4c 01 f9             	add    %r15,%rcx
    8db8:	48 89 08             	mov    %rcx,(%rax)
    8dbb:	4c 89 ff             	mov    %r15,%rdi
    8dbe:	31 f6                	xor    %esi,%esi
    8dc0:	e8 5b 93 ff ff       	call   2120 <memset@plt>
    8dc5:	66 41 c7 07 30 74    	movw   $0x7430,(%r15)
    8dcb:	85 db                	test   %ebx,%ebx
    8dcd:	0f 8e 98 00 00 00    	jle    8e6b <fwp_write+0xf9b>
    8dd3:	44 89 e1             	mov    %r12d,%ecx
    8dd6:	48 f7 d9             	neg    %rcx
    8dd9:	4a 8d 34 3b          	lea    (%rbx,%r15,1),%rsi
    8ddd:	48 ff c6             	inc    %rsi
    8de0:	31 ff                	xor    %edi,%edi
    8de2:	49 b8 56 55 55 55 55 	movabs $0x5555555555555556,%r8
    8de9:	55 55 55 
    8dec:	eb 2e                	jmp    8e1c <fwp_write+0xf4c>
    8dee:	66 90                	xchg   %ax,%ax
    8df0:	41 b2 30             	mov    $0x30,%r10b
    8df3:	44 88 14 3e          	mov    %r10b,(%rsi,%rdi,1)
    8df7:	48 85 d2             	test   %rdx,%rdx
    8dfa:	0f 95 c2             	setne  %dl
    8dfd:	4d 85 f6             	test   %r14,%r14
    8e00:	41 0f 98 c2          	sets   %r10b
    8e04:	41 20 d2             	and    %dl,%r10b
    8e07:	41 0f b6 d2          	movzbl %r10b,%edx
    8e0b:	48 29 d0             	sub    %rdx,%rax
    8e0e:	4c 01 c8             	add    %r9,%rax
    8e11:	48 ff cf             	dec    %rdi
    8e14:	49 89 c6             	mov    %rax,%r14
    8e17:	48 39 f9             	cmp    %rdi,%rcx
    8e1a:	74 4f                	je     8e6b <fwp_write+0xf9b>
    8e1c:	4c 89 f0             	mov    %r14,%rax
    8e1f:	49 f7 e8             	imul   %r8
    8e22:	48 89 d0             	mov    %rdx,%rax
    8e25:	48 c1 e8 3f          	shr    $0x3f,%rax
    8e29:	48 01 d0             	add    %rdx,%rax
    8e2c:	4c 8d 0c 40          	lea    (%rax,%rax,2),%r9
    8e30:	4c 89 f2             	mov    %r14,%rdx
    8e33:	4c 29 ca             	sub    %r9,%rdx
    8e36:	49 f7 d9             	neg    %r9
    8e39:	4d 01 f1             	add    %r14,%r9
    8e3c:	49 83 c1 03          	add    $0x3,%r9
    8e40:	48 83 fa fd          	cmp    $0xfffffffffffffffd,%rdx
    8e44:	4c 0f 42 ca          	cmovb  %rdx,%r9
    8e48:	4d 85 c9             	test   %r9,%r9
    8e4b:	74 a3                	je     8df0 <fwp_write+0xf20>
    8e4d:	49 83 f9 01          	cmp    $0x1,%r9
    8e51:	75 0d                	jne    8e60 <fwp_write+0xf90>
    8e53:	41 b2 2b             	mov    $0x2b,%r10b
    8e56:	45 31 c9             	xor    %r9d,%r9d
    8e59:	eb 98                	jmp    8df3 <fwp_write+0xf23>
    8e5b:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)
    8e60:	41 b2 2d             	mov    $0x2d,%r10b
    8e63:	41 b9 01 00 00 00    	mov    $0x1,%r9d
    8e69:	eb 88                	jmp    8df3 <fwp_write+0xf23>
    8e6b:	43 c6 44 27 02 00    	movb   $0x0,0x2(%r15,%r12,1)
    8e71:	4c 89 ff             	mov    %r15,%rdi
    8e74:	e8 57 92 ff ff       	call   20d0 <strlen@plt>
    8e79:	48 89 ef             	mov    %rbp,%rdi
    8e7c:	4c 89 fe             	mov    %r15,%rsi
    8e7f:	48 89 c2             	mov    %rax,%rdx
    8e82:	48 81 c4 78 02 00 00 	add    $0x278,%rsp
    8e89:	5b                   	pop    %rbx
    8e8a:	41 5c                	pop    %r12
    8e8c:	41 5d                	pop    %r13
    8e8e:	41 5e                	pop    %r14
    8e90:	41 5f                	pop    %r15
    8e92:	5d                   	pop    %rbp
    8e93:	e9 18 04 00 00       	jmp    92b0 <buf_put>
    8e98:	48 8b 31             	mov    (%rcx),%rsi
    8e9b:	eb 18                	jmp    8eb5 <fwp_write+0xfe5>
    8e9d:	83 3a 00             	cmpl   $0x0,(%rdx)
    8ea0:	0f b6 01             	movzbl (%rcx),%eax
    8ea3:	48 0f be f0          	movsbq %al,%rsi
    8ea7:	eb 08                	jmp    8eb1 <fwp_write+0xfe1>
    8ea9:	83 3a 02             	cmpl   $0x2,(%rdx)
    8eac:	8b 01                	mov    (%rcx),%eax
    8eae:	48 63 f0             	movslq %eax,%rsi
    8eb1:	48 0f 45 f0          	cmovne %rax,%rsi
    8eb5:	48 8b 2c 24          	mov    (%rsp),%rbp
    8eb9:	48 89 ef             	mov    %rbp,%rdi
    8ebc:	31 c9                	xor    %ecx,%ecx
    8ebe:	e8 0d f0 ff ff       	call   7ed0 <fwp_write>
    8ec3:	48 b8 ff ff ff ff ff 	movabs $0x7fffffffffffffff,%rax
    8eca:	ff ff 7f 
    8ecd:	48 ff c8             	dec    %rax
    8ed0:	49 85 06             	test   %rax,(%r14)
    8ed3:	0f 84 c9 00 00 00    	je     8fa2 <fwp_write+0x10d2>
    8ed9:	bb 01 00 00 00       	mov    $0x1,%ebx
    8ede:	4c 8d 25 dc 67 00 00 	lea    0x67dc(%rip),%r12        # f6c1 <fwp_segv.msg+0x441>
    8ee5:	eb 39                	jmp    8f20 <fwp_write+0x1050>
    8ee7:	83 3a 01             	cmpl   $0x1,(%rdx)
    8eea:	0f b7 04 31          	movzwl (%rcx,%rsi,1),%eax
    8eee:	48 0f bf f0          	movswq %ax,%rsi
    8ef2:	48 0f 45 f0          	cmovne %rax,%rsi
    8ef6:	48 8b 2c 24          	mov    (%rsp),%rbp
    8efa:	48 89 ef             	mov    %rbp,%rdi
    8efd:	31 c9                	xor    %ecx,%ecx
    8eff:	e8 cc ef ff ff       	call   7ed0 <fwp_write>
    8f04:	48 ff c3             	inc    %rbx
    8f07:	49 8b 06             	mov    (%r14),%rax
    8f0a:	48 b9 ff ff ff ff ff 	movabs $0x7fffffffffffffff,%rcx
    8f11:	ff ff 7f 
    8f14:	48 21 c8             	and    %rcx,%rax
    8f17:	48 39 c3             	cmp    %rax,%rbx
    8f1a:	0f 83 82 00 00 00    	jae    8fa2 <fwp_write+0x10d2>
    8f20:	ba 02 00 00 00       	mov    $0x2,%edx
    8f25:	48 89 ef             	mov    %rbp,%rdi
    8f28:	4c 89 e6             	mov    %r12,%rsi
    8f2b:	e8 80 03 00 00       	call   92b0 <buf_put>
    8f30:	49 8b 57 38          	mov    0x38(%r15),%rdx
    8f34:	b8 08 00 00 00       	mov    $0x8,%eax
    8f39:	48 85 d2             	test   %rdx,%rdx
    8f3c:	74 13                	je     8f51 <fwp_write+0x1081>
    8f3e:	8b 0a                	mov    (%rdx),%ecx
    8f40:	48 83 f9 0a          	cmp    $0xa,%rcx
    8f44:	77 0b                	ja     8f51 <fwp_write+0x1081>
    8f46:	48 8d 05 ab 63 00 00 	lea    0x63ab(%rip),%rax        # f2f8 <fwp_segv.msg+0x78>
    8f4d:	48 8b 04 c8          	mov    (%rax,%rcx,8),%rax
    8f51:	49 83 3e 00          	cmpq   $0x0,(%r14)
    8f55:	4c 89 e9             	mov    %r13,%rcx
    8f58:	79 04                	jns    8f5e <fwp_write+0x108e>
    8f5a:	49 8b 4e 10          	mov    0x10(%r14),%rcx
    8f5e:	48 89 c6             	mov    %rax,%rsi
    8f61:	48 0f af f3          	imul   %rbx,%rsi
    8f65:	48 83 f8 01          	cmp    $0x1,%rax
    8f69:	74 19                	je     8f84 <fwp_write+0x10b4>
    8f6b:	48 83 f8 02          	cmp    $0x2,%rax
    8f6f:	0f 84 72 ff ff ff    	je     8ee7 <fwp_write+0x1017>
    8f75:	48 83 f8 08          	cmp    $0x8,%rax
    8f79:	75 19                	jne    8f94 <fwp_write+0x10c4>
    8f7b:	48 8b 34 31          	mov    (%rcx,%rsi,1),%rsi
    8f7f:	e9 72 ff ff ff       	jmp    8ef6 <fwp_write+0x1026>
    8f84:	83 3a 00             	cmpl   $0x0,(%rdx)
    8f87:	0f b6 04 31          	movzbl (%rcx,%rsi,1),%eax
    8f8b:	48 0f be f0          	movsbq %al,%rsi
    8f8f:	e9 5e ff ff ff       	jmp    8ef2 <fwp_write+0x1022>
    8f94:	83 3a 02             	cmpl   $0x2,(%rdx)
    8f97:	8b 04 31             	mov    (%rcx,%rsi,1),%eax
    8f9a:	48 63 f0             	movslq %eax,%rsi
    8f9d:	e9 50 ff ff ff       	jmp    8ef2 <fwp_write+0x1022>
    8fa2:	c6 44 24 70 5d       	movb   $0x5d,0x70(%rsp)
    8fa7:	48 8d 74 24 70       	lea    0x70(%rsp),%rsi
    8fac:	ba 01 00 00 00       	mov    $0x1,%edx
    8fb1:	48 89 ef             	mov    %rbp,%rdi
    8fb4:	e9 55 01 00 00       	jmp    910e <fwp_write+0x123e>
    8fb9:	48 8d 35 24 67 00 00 	lea    0x6724(%rip),%rsi        # f6e4 <fwp_segv.msg+0x464>
    8fc0:	ba 02 00 00 00       	mov    $0x2,%edx
    8fc5:	48 89 ef             	mov    %rbp,%rdi
    8fc8:	e9 b5 fe ff ff       	jmp    8e82 <fwp_write+0xfb2>
    8fcd:	31 c0                	xor    %eax,%eax
    8fcf:	c6 44 04 71 00       	movb   $0x0,0x71(%rsp,%rax,1)
    8fd4:	e9 1f 01 00 00       	jmp    90f8 <fwp_write+0x1228>
    8fd9:	89 fa                	mov    %edi,%edx
    8fdb:	83 e2 1f             	and    $0x1f,%edx
    8fde:	48 89 c1             	mov    %rax,%rcx
    8fe1:	48 29 d1             	sub    %rdx,%rcx
    8fe4:	48 8d b4 24 80 00 00 	lea    0x80(%rsp),%rsi
    8feb:	00 
    8fec:	66 0f ef c0          	pxor   %xmm0,%xmm0
    8ff0:	49 89 c0             	mov    %rax,%r8
    8ff3:	f3 42 0f 6f 0c 04    	movdqu (%rsp,%r8,1),%xmm1
    8ff9:	f3 42 0f 6f 54 04 10 	movdqu 0x10(%rsp,%r8,1),%xmm2
    9000:	66 0f 6f da          	movdqa %xmm2,%xmm3
    9004:	66 0f 60 d8          	punpcklbw %xmm0,%xmm3
    9008:	66 0f 70 db 4e       	pshufd $0x4e,%xmm3,%xmm3
    900d:	f2 0f 70 db 1b       	pshuflw $0x1b,%xmm3,%xmm3
    9012:	f3 0f 70 db 1b       	pshufhw $0x1b,%xmm3,%xmm3
    9017:	66 0f 68 d0          	punpckhbw %xmm0,%xmm2
    901b:	66 0f 70 d2 4e       	pshufd $0x4e,%xmm2,%xmm2
    9020:	f2 0f 70 d2 1b       	pshuflw $0x1b,%xmm2,%xmm2
    9025:	f3 0f 70 d2 1b       	pshufhw $0x1b,%xmm2,%xmm2
    902a:	66 0f 67 d3          	packuswb %xmm3,%xmm2
    902e:	66 0f 6f d9          	movdqa %xmm1,%xmm3
    9032:	66 0f 60 d8          	punpcklbw %xmm0,%xmm3
    9036:	66 0f 70 db 4e       	pshufd $0x4e,%xmm3,%xmm3
    903b:	f2 0f 70 db 1b       	pshuflw $0x1b,%xmm3,%xmm3
    9040:	f3 0f 70 db 1b       	pshufhw $0x1b,%xmm3,%xmm3
    9045:	66 0f 68 c8          	punpckhbw %xmm0,%xmm1
    9049:	66 0f 70 c9 4e       	pshufd $0x4e,%xmm1,%xmm1
    904e:	f2 0f 70 c9 1b       	pshuflw $0x1b,%xmm1,%xmm1
    9053:	f3 0f 70 c9 1b       	pshufhw $0x1b,%xmm1,%xmm1
    9058:	66 0f 67 cb          	packuswb %xmm3,%xmm1
    905c:	66 0f 7f 56 f0       	movdqa %xmm2,-0x10(%rsi)
    9061:	66 0f 7f 0e          	movdqa %xmm1,(%rsi)
    9065:	49 83 c0 e0          	add    $0xffffffffffffffe0,%r8
    9069:	48 83 c6 20          	add    $0x20,%rsi
    906d:	4c 39 c2             	cmp    %r8,%rdx
    9070:	75 81                	jne    8ff3 <fwp_write+0x1123>
    9072:	48 85 d2             	test   %rdx,%rdx
    9075:	0f 84 78 00 00 00    	je     90f3 <fwp_write+0x1223>
    907b:	83 fa 08             	cmp    $0x8,%edx
    907e:	72 50                	jb     90d0 <fwp_write+0x1200>
    9080:	89 fa                	mov    %edi,%edx
    9082:	83 e2 07             	and    $0x7,%edx
    9085:	48 89 c6             	mov    %rax,%rsi
    9088:	48 29 ce             	sub    %rcx,%rsi
    908b:	48 8d 3c 0c          	lea    (%rsp,%rcx,1),%rdi
    908f:	48 83 c7 70          	add    $0x70,%rdi
    9093:	48 89 c1             	mov    %rax,%rcx
    9096:	48 29 d1             	sub    %rdx,%rcx
    9099:	66 0f ef c0          	pxor   %xmm0,%xmm0
    909d:	f3 0f 7e 4c 34 18    	movq   0x18(%rsp,%rsi,1),%xmm1
    90a3:	66 0f 60 c8          	punpcklbw %xmm0,%xmm1
    90a7:	66 0f 70 c9 4e       	pshufd $0x4e,%xmm1,%xmm1
    90ac:	f2 0f 70 c9 1b       	pshuflw $0x1b,%xmm1,%xmm1
    90b1:	f3 0f 70 c9 1b       	pshufhw $0x1b,%xmm1,%xmm1
    90b6:	66 0f 67 c9          	packuswb %xmm1,%xmm1
    90ba:	66 0f d6 0f          	movq   %xmm1,(%rdi)
    90be:	48 83 c6 f8          	add    $0xfffffffffffffff8,%rsi
    90c2:	48 83 c7 08          	add    $0x8,%rdi
    90c6:	48 39 f2             	cmp    %rsi,%rdx
    90c9:	75 d2                	jne    909d <fwp_write+0x11cd>
    90cb:	48 85 d2             	test   %rdx,%rdx
    90ce:	74 23                	je     90f3 <fwp_write+0x1223>
    90d0:	48 8d 74 24 20       	lea    0x20(%rsp),%rsi
    90d5:	48 01 f2             	add    %rsi,%rdx
    90d8:	48 ff ca             	dec    %rdx
    90db:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)
    90e0:	0f b6 32             	movzbl (%rdx),%esi
    90e3:	40 88 74 0c 70       	mov    %sil,0x70(%rsp,%rcx,1)
    90e8:	48 ff c1             	inc    %rcx
    90eb:	48 ff ca             	dec    %rdx
    90ee:	48 39 c8             	cmp    %rcx,%rax
    90f1:	75 ed                	jne    90e0 <fwp_write+0x1210>
    90f3:	c6 44 04 70 00       	movb   $0x0,0x70(%rsp,%rax,1)
    90f8:	4c 8d 74 24 70       	lea    0x70(%rsp),%r14
    90fd:	4c 89 f7             	mov    %r14,%rdi
    9100:	e8 cb 8f ff ff       	call   20d0 <strlen@plt>
    9105:	48 89 ef             	mov    %rbp,%rdi
    9108:	4c 89 f6             	mov    %r14,%rsi
    910b:	48 89 c2             	mov    %rax,%rdx
    910e:	e8 9d 01 00 00       	call   92b0 <buf_put>
    9113:	48 81 c4 78 02 00 00 	add    $0x278,%rsp
    911a:	5b                   	pop    %rbx
    911b:	41 5c                	pop    %r12
    911d:	41 5d                	pop    %r13
    911f:	41 5e                	pop    %r14
    9121:	41 5f                	pop    %r15
    9123:	5d                   	pop    %rbp
    9124:	c3                   	ret
    9125:	83 f8 20             	cmp    $0x20,%eax
    9128:	73 07                	jae    9131 <fwp_write+0x1261>
    912a:	31 c9                	xor    %ecx,%ecx
    912c:	e9 b6 00 00 00       	jmp    91e7 <fwp_write+0x1317>
    9131:	89 fe                	mov    %edi,%esi
    9133:	89 fa                	mov    %edi,%edx
    9135:	83 e2 1f             	and    $0x1f,%edx
    9138:	48 89 c1             	mov    %rax,%rcx
    913b:	48 29 d1             	sub    %rdx,%rcx
    913e:	4c 8d 04 34          	lea    (%rsp,%rsi,1),%r8
    9142:	49 83 c0 10          	add    $0x10,%r8
    9146:	48 29 d6             	sub    %rdx,%rsi
    9149:	45 31 c9             	xor    %r9d,%r9d
    914c:	66 0f ef c0          	pxor   %xmm0,%xmm0
    9150:	f3 41 0f 6f 48 f0    	movdqu -0x10(%r8),%xmm1
    9156:	f3 41 0f 6f 10       	movdqu (%r8),%xmm2
    915b:	66 0f 6f da          	movdqa %xmm2,%xmm3
    915f:	66 0f 60 d8          	punpcklbw %xmm0,%xmm3
    9163:	66 0f 70 db 4e       	pshufd $0x4e,%xmm3,%xmm3
    9168:	f2 0f 70 db 1b       	pshuflw $0x1b,%xmm3,%xmm3
    916d:	f3 0f 70 db 1b       	pshufhw $0x1b,%xmm3,%xmm3
    9172:	66 0f 68 d0          	punpckhbw %xmm0,%xmm2
    9176:	66 0f 70 d2 4e       	pshufd $0x4e,%xmm2,%xmm2
    917b:	f2 0f 70 d2 1b       	pshuflw $0x1b,%xmm2,%xmm2
    9180:	f3 0f 70 d2 1b       	pshufhw $0x1b,%xmm2,%xmm2
    9185:	66 0f 67 d3          	packuswb %xmm3,%xmm2
    9189:	66 0f 6f d9          	movdqa %xmm1,%xmm3
    918d:	66 0f 60 d8          	punpcklbw %xmm0,%xmm3
    9191:	66 0f 70 db 4e       	pshufd $0x4e,%xmm3,%xmm3
    9196:	f2 0f 70 db 1b       	pshuflw $0x1b,%xmm3,%xmm3
    919b:	f3 0f 70 db 1b       	pshufhw $0x1b,%xmm3,%xmm3
    91a0:	66 0f 68 c8          	punpckhbw %xmm0,%xmm1
    91a4:	66 0f 70 c9 4e       	pshufd $0x4e,%xmm1,%xmm1
    91a9:	f2 0f 70 c9 1b       	pshuflw $0x1b,%xmm1,%xmm1
    91ae:	f3 0f 70 c9 1b       	pshufhw $0x1b,%xmm1,%xmm1
    91b3:	66 0f 67 cb          	packuswb %xmm3,%xmm1
    91b7:	f3 42 0f 7f 54 0c 71 	movdqu %xmm2,0x71(%rsp,%r9,1)
    91be:	f3 42 0f 7f 8c 0c 81 	movdqu %xmm1,0x81(%rsp,%r9,1)
    91c5:	00 00 00 
    91c8:	49 83 c1 20          	add    $0x20,%r9
    91cc:	49 83 c0 e0          	add    $0xffffffffffffffe0,%r8
    91d0:	4c 39 ce             	cmp    %r9,%rsi
    91d3:	0f 85 77 ff ff ff    	jne    9150 <fwp_write+0x1280>
    91d9:	48 85 d2             	test   %rdx,%rdx
    91dc:	0f 84 91 00 00 00    	je     9273 <fwp_write+0x13a3>
    91e2:	83 fa 08             	cmp    $0x8,%edx
    91e5:	72 60                	jb     9247 <fwp_write+0x1377>
    91e7:	48 89 ce             	mov    %rcx,%rsi
    91ea:	41 89 f8             	mov    %edi,%r8d
    91ed:	89 fa                	mov    %edi,%edx
    91ef:	83 e2 07             	and    $0x7,%edx
    91f2:	48 89 c1             	mov    %rax,%rcx
    91f5:	48 29 d1             	sub    %rdx,%rcx
    91f8:	49 89 f1             	mov    %rsi,%r9
    91fb:	49 f7 d9             	neg    %r9
    91fe:	49 01 e1             	add    %rsp,%r9
    9201:	49 83 c1 20          	add    $0x20,%r9
    9205:	4d 01 c1             	add    %r8,%r9
    9208:	49 83 c1 f8          	add    $0xfffffffffffffff8,%r9
    920c:	49 29 d0             	sub    %rdx,%r8
    920f:	66 0f ef c0          	pxor   %xmm0,%xmm0
    9213:	f3 41 0f 7e 09       	movq   (%r9),%xmm1
    9218:	66 0f 60 c8          	punpcklbw %xmm0,%xmm1
    921c:	66 0f 70 c9 4e       	pshufd $0x4e,%xmm1,%xmm1
    9221:	f2 0f 70 c9 1b       	pshuflw $0x1b,%xmm1,%xmm1
    9226:	f3 0f 70 c9 1b       	pshufhw $0x1b,%xmm1,%xmm1
    922b:	66 0f 67 c9          	packuswb %xmm1,%xmm1
    922f:	66 0f d6 4c 34 71    	movq   %xmm1,0x71(%rsp,%rsi,1)
    9235:	48 83 c6 08          	add    $0x8,%rsi
    9239:	49 83 c1 f8          	add    $0xfffffffffffffff8,%r9
    923d:	49 39 f0             	cmp    %rsi,%r8
    9240:	75 d1                	jne    9213 <fwp_write+0x1343>
    9242:	48 85 d2             	test   %rdx,%rdx
    9245:	74 2c                	je     9273 <fwp_write+0x13a3>
    9247:	48 8d 74 24 20       	lea    0x20(%rsp),%rsi
    924c:	48 01 f2             	add    %rsi,%rdx
    924f:	48 ff ca             	dec    %rdx
    9252:	89 fe                	mov    %edi,%esi
    9254:	66 66 66 2e 0f 1f 84 	data16 data16 cs nopw 0x0(%rax,%rax,1)
    925b:	00 00 00 00 00 
    9260:	0f b6 3a             	movzbl (%rdx),%edi
    9263:	40 88 7c 0c 71       	mov    %dil,0x71(%rsp,%rcx,1)
    9268:	48 ff c1             	inc    %rcx
    926b:	48 ff ca             	dec    %rdx
    926e:	48 39 ce             	cmp    %rcx,%rsi
    9271:	75 ed                	jne    9260 <fwp_write+0x1390>
    9273:	c6 44 04 71 00       	movb   $0x0,0x71(%rsp,%rax,1)
    9278:	e9 7b fe ff ff       	jmp    90f8 <fwp_write+0x1228>
    927d:	4c 8d 74 24 70       	lea    0x70(%rsp),%r14
    9282:	4c 89 f7             	mov    %r14,%rdi
    9285:	f2 0f 10 44 24 10    	movsd  0x10(%rsp),%xmm0
    928b:	be 09 00 00 00       	mov    $0x9,%esi
    9290:	e8 7b 0d 00 00       	call   a010 <fwp_format_g>
    9295:	4c 89 f7             	mov    %r14,%rdi
    9298:	e9 bf f8 ff ff       	jmp    8b5c <fwp_write+0xc8c>
    929d:	c7 44 24 70 4e 61 4e 	movl   $0x4e614e,0x70(%rsp)
    92a4:	00 
    92a5:	e9 4e fe ff ff       	jmp    90f8 <fwp_write+0x1228>
    92aa:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)

00000000000092b0 <buf_put>:
    92b0:	41 57                	push   %r15
    92b2:	41 56                	push   %r14
    92b4:	41 54                	push   %r12
    92b6:	53                   	push   %rbx
    92b7:	50                   	push   %rax
    92b8:	49 89 fe             	mov    %rdi,%r14
    92bb:	48 8b 7f 08          	mov    0x8(%rdi),%rdi
    92bf:	48 83 ff ff          	cmp    $0xffffffffffffffff,%rdi
    92c3:	0f 84 a2 00 00 00    	je     936b <buf_put+0xbb>
    92c9:	48 89 d3             	mov    %rdx,%rbx
    92cc:	48 c7 c0 fe ff ff ff 	mov    $0xfffffffffffffffe,%rax
    92d3:	48 29 f8             	sub    %rdi,%rax
    92d6:	48 39 d0             	cmp    %rdx,%rax
    92d9:	0f 82 8c 00 00 00    	jb     936b <buf_put+0xbb>
    92df:	48 8d 04 3b          	lea    (%rbx,%rdi,1),%rax
    92e3:	48 ff c0             	inc    %rax
    92e6:	49 8b 4e 10          	mov    0x10(%r14),%rcx
    92ea:	48 39 c8             	cmp    %rcx,%rax
    92ed:	76 30                	jbe    931f <buf_put+0x6f>
    92ef:	48 85 c9             	test   %rcx,%rcx
    92f2:	41 bf 40 00 00 00    	mov    $0x40,%r15d
    92f8:	4c 0f 45 f9          	cmovne %rcx,%r15
    92fc:	49 89 f4             	mov    %rsi,%r12
    92ff:	49 39 c7             	cmp    %rax,%r15
    9302:	73 23                	jae    9327 <buf_put+0x77>
    9304:	66 66 66 2e 0f 1f 84 	data16 data16 cs nopw 0x0(%rax,%rax,1)
    930b:	00 00 00 00 00 
    9310:	4d 85 ff             	test   %r15,%r15
    9313:	78 0f                	js     9324 <buf_put+0x74>
    9315:	4d 01 ff             	add    %r15,%r15
    9318:	49 39 c7             	cmp    %rax,%r15
    931b:	72 f3                	jb     9310 <buf_put+0x60>
    931d:	eb 08                	jmp    9327 <buf_put+0x77>
    931f:	49 8b 06             	mov    (%r14),%rax
    9322:	eb 21                	jmp    9345 <buf_put+0x95>
    9324:	49 89 c7             	mov    %rax,%r15
    9327:	49 8b 3e             	mov    (%r14),%rdi
    932a:	4c 89 fe             	mov    %r15,%rsi
    932d:	e8 fe 92 ff ff       	call   2630 <realloc>
    9332:	48 85 c0             	test   %rax,%rax
    9335:	74 34                	je     936b <buf_put+0xbb>
    9337:	49 89 06             	mov    %rax,(%r14)
    933a:	4d 89 7e 10          	mov    %r15,0x10(%r14)
    933e:	49 8b 7e 08          	mov    0x8(%r14),%rdi
    9342:	4c 89 e6             	mov    %r12,%rsi
    9345:	48 01 c7             	add    %rax,%rdi
    9348:	48 89 da             	mov    %rbx,%rdx
    934b:	e8 80 8e ff ff       	call   21d0 <memcpy@plt>
    9350:	49 03 5e 08          	add    0x8(%r14),%rbx
    9354:	49 89 5e 08          	mov    %rbx,0x8(%r14)
    9358:	49 8b 06             	mov    (%r14),%rax
    935b:	c6 04 18 00          	movb   $0x0,(%rax,%rbx,1)
    935f:	48 83 c4 08          	add    $0x8,%rsp
    9363:	5b                   	pop    %rbx
    9364:	41 5c                	pop    %r12
    9366:	41 5e                	pop    %r14
    9368:	41 5f                	pop    %r15
    936a:	c3                   	ret
    936b:	48 8b 05 6e 8c 00 00 	mov    0x8c6e(%rip),%rax        # 11fe0 <stderr@GLIBC_2.2.5>
    9372:	48 8b 08             	mov    (%rax),%rcx
    9375:	48 8d 3d 5d 62 00 00 	lea    0x625d(%rip),%rdi        # f5d9 <fwp_segv.msg+0x359>
    937c:	be 13 00 00 00       	mov    $0x13,%esi
    9381:	ba 01 00 00 00       	mov    $0x1,%edx
    9386:	e8 f5 8e ff ff       	call   2280 <fwrite@plt>
    938b:	bf 66 00 00 00       	mov    $0x66,%edi
    9390:	e8 db 8e ff ff       	call   2270 <exit@plt>
    9395:	66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
    939c:	00 00 00 00 

00000000000093a0 <fwp_escape>:
    93a0:	55                   	push   %rbp
    93a1:	41 57                	push   %r15
    93a3:	41 56                	push   %r14
    93a5:	41 55                	push   %r13
    93a7:	41 54                	push   %r12
    93a9:	53                   	push   %rbx
    93aa:	48 83 ec 18          	sub    $0x18,%rsp
    93ae:	49 89 d6             	mov    %rdx,%r14
    93b1:	49 89 f7             	mov    %rsi,%r15
    93b4:	48 89 fb             	mov    %rdi,%rbx
    93b7:	c6 04 24 22          	movb   $0x22,(%rsp)
    93bb:	48 89 e6             	mov    %rsp,%rsi
    93be:	ba 01 00 00 00       	mov    $0x1,%edx
    93c3:	e8 e8 fe ff ff       	call   92b0 <buf_put>
    93c8:	4d 85 f6             	test   %r14,%r14
    93cb:	0f 84 de 00 00 00    	je     94af <fwp_escape+0x10f>
    93d1:	48 89 e5             	mov    %rsp,%rbp
    93d4:	4c 8d 2d f1 5d 00 00 	lea    0x5df1(%rip),%r13        # f1cc <_IO_stdin_used+0x1cc>
    93db:	45 31 e4             	xor    %r12d,%r12d
    93de:	eb 21                	jmp    9401 <fwp_escape+0x61>
    93e0:	ba 02 00 00 00       	mov    $0x2,%edx
    93e5:	48 89 df             	mov    %rbx,%rdi
    93e8:	48 8d 35 28 63 00 00 	lea    0x6328(%rip),%rsi        # f717 <fwp_segv.msg+0x497>
    93ef:	90                   	nop
    93f0:	e8 bb fe ff ff       	call   92b0 <buf_put>
    93f5:	49 ff c4             	inc    %r12
    93f8:	4d 39 e6             	cmp    %r12,%r14
    93fb:	0f 84 ae 00 00 00    	je     94af <fwp_escape+0x10f>
    9401:	43 0f b6 04 27       	movzbl (%r15,%r12,1),%eax
    9406:	0f b6 c8             	movzbl %al,%ecx
    9409:	8d 51 f7             	lea    -0x9(%rcx),%edx
    940c:	83 fa 19             	cmp    $0x19,%edx
    940f:	77 1f                	ja     9430 <fwp_escape+0x90>
    9411:	49 63 54 95 00       	movslq 0x0(%r13,%rdx,4),%rdx
    9416:	4c 01 ea             	add    %r13,%rdx
    9419:	ff e2                	jmp    *%rdx
    941b:	ba 02 00 00 00       	mov    $0x2,%edx
    9420:	48 89 df             	mov    %rbx,%rdi
    9423:	48 8d 35 ea 62 00 00 	lea    0x62ea(%rip),%rsi        # f714 <fwp_segv.msg+0x494>
    942a:	eb c4                	jmp    93f0 <fwp_escape+0x50>
    942c:	0f 1f 40 00          	nopl   0x0(%rax)
    9430:	83 f9 5c             	cmp    $0x5c,%ecx
    9433:	75 11                	jne    9446 <fwp_escape+0xa6>
    9435:	ba 02 00 00 00       	mov    $0x2,%edx
    943a:	48 89 df             	mov    %rbx,%rdi
    943d:	48 8d 35 ca 62 00 00 	lea    0x62ca(%rip),%rsi        # f70e <fwp_segv.msg+0x48e>
    9444:	eb aa                	jmp    93f0 <fwp_escape+0x50>
    9446:	3c 20                	cmp    $0x20,%al
    9448:	72 39                	jb     9483 <fwp_escape+0xe3>
    944a:	3c 7f                	cmp    $0x7f,%al
    944c:	74 35                	je     9483 <fwp_escape+0xe3>
    944e:	88 04 24             	mov    %al,(%rsp)
    9451:	ba 01 00 00 00       	mov    $0x1,%edx
    9456:	48 89 df             	mov    %rbx,%rdi
    9459:	48 89 ee             	mov    %rbp,%rsi
    945c:	eb 92                	jmp    93f0 <fwp_escape+0x50>
    945e:	ba 02 00 00 00       	mov    $0x2,%edx
    9463:	48 89 df             	mov    %rbx,%rdi
    9466:	48 8d 35 9e 62 00 00 	lea    0x629e(%rip),%rsi        # f70b <fwp_segv.msg+0x48b>
    946d:	eb 81                	jmp    93f0 <fwp_escape+0x50>
    946f:	ba 02 00 00 00       	mov    $0x2,%edx
    9474:	48 89 df             	mov    %rbx,%rdi
    9477:	48 8d 35 93 62 00 00 	lea    0x6293(%rip),%rsi        # f711 <fwp_segv.msg+0x491>
    947e:	e9 6d ff ff ff       	jmp    93f0 <fwp_escape+0x50>
    9483:	be 10 00 00 00       	mov    $0x10,%esi
    9488:	48 89 ef             	mov    %rbp,%rdi
    948b:	48 8d 15 88 62 00 00 	lea    0x6288(%rip),%rdx        # f71a <fwp_segv.msg+0x49a>
    9492:	31 c0                	xor    %eax,%eax
    9494:	e8 67 8c ff ff       	call   2100 <snprintf@plt>
    9499:	48 89 ef             	mov    %rbp,%rdi
    949c:	e8 2f 8c ff ff       	call   20d0 <strlen@plt>
    94a1:	48 89 df             	mov    %rbx,%rdi
    94a4:	48 89 ee             	mov    %rbp,%rsi
    94a7:	48 89 c2             	mov    %rax,%rdx
    94aa:	e9 41 ff ff ff       	jmp    93f0 <fwp_escape+0x50>
    94af:	c6 04 24 22          	movb   $0x22,(%rsp)
    94b3:	48 89 e6             	mov    %rsp,%rsi
    94b6:	ba 01 00 00 00       	mov    $0x1,%edx
    94bb:	48 89 df             	mov    %rbx,%rdi
    94be:	e8 ed fd ff ff       	call   92b0 <buf_put>
    94c3:	48 83 c4 18          	add    $0x18,%rsp
    94c7:	5b                   	pop    %rbx
    94c8:	41 5c                	pop    %r12
    94ca:	41 5d                	pop    %r13
    94cc:	41 5e                	pop    %r14
    94ce:	41 5f                	pop    %r15
    94d0:	5d                   	pop    %rbp
    94d1:	c3                   	ret
    94d2:	66 66 66 66 66 2e 0f 	data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    94d9:	1f 84 00 00 00 00 00 

00000000000094e0 <fwp_fmt_duration>:
    94e0:	41 57                	push   %r15
    94e2:	41 56                	push   %r14
    94e4:	41 54                	push   %r12
    94e6:	53                   	push   %rbx
    94e7:	48 81 ec 88 00 00 00 	sub    $0x88,%rsp
    94ee:	48 89 f0             	mov    %rsi,%rax
    94f1:	48 09 d0             	or     %rdx,%rax
    94f4:	0f 84 bf 02 00 00    	je     97b9 <fwp_fmt_duration+0x2d9>
    94fa:	49 89 d0             	mov    %rdx,%r8
    94fd:	48 b9 1d 3f c2 25 d6 	movabs $0xd2fe1d625c23f1d,%rcx
    9504:	e1 2f 0d 
    9507:	48 0f af ce          	imul   %rsi,%rcx
    950b:	49 b9 0d b1 f3 e4 99 	movabs $0x1c52799e4f3b10d,%r9
    9512:	27 c5 01 
    9515:	48 89 f0             	mov    %rsi,%rax
    9518:	49 f7 e1             	mul    %r9
    951b:	48 01 ca             	add    %rcx,%rdx
    951e:	4d 0f af c8          	imul   %r8,%r9
    9522:	49 01 d1             	add    %rdx,%r9
    9525:	48 b9 00 a0 34 52 a3 	movabs $0x6baf6aa35234a000,%rcx
    952c:	6a af 6b 
    952f:	48 01 c1             	add    %rax,%rcx
    9532:	48 b8 37 f9 ff e2 04 	movabs $0x4e2fff937,%rax
    9539:	00 00 00 
    953c:	4c 11 c8             	adc    %r9,%rax
    953f:	48 89 c2             	mov    %rax,%rdx
    9542:	48 0f ac ca 0d       	shrd   $0xd,%rcx,%rdx
    9547:	48 0f a4 c8 33       	shld   $0x33,%rcx,%rax
    954c:	48 b9 4a 23 35 aa f6 	movabs $0x9376baf6aa35234a,%rcx
    9553:	ba 76 93 
    9556:	48 39 c1             	cmp    %rax,%rcx
    9559:	b8 ff 2f 4e 00       	mov    $0x4e2fff,%eax
    955e:	48 19 d0             	sbb    %rdx,%rax
    9561:	0f 83 70 02 00 00    	jae    97d7 <fwp_fmt_duration+0x2f7>
    9567:	48 b9 b3 b2 61 36 8c 	movabs $0xc5ce3b8c3661b2b3,%rcx
    956e:	3b ce c5 
    9571:	49 b9 c3 5f 47 6a 04 	movabs $0x1a8d52046a475fc3,%r9
    9578:	52 8d 1a 
    957b:	48 89 f0             	mov    %rsi,%rax
    957e:	49 f7 e1             	mul    %r9
    9581:	48 0f af ce          	imul   %rsi,%rcx
    9585:	48 01 ca             	add    %rcx,%rdx
    9588:	4d 0f af c8          	imul   %r8,%r9
    958c:	49 01 d1             	add    %rdx,%r9
    958f:	48 b9 00 a8 16 d1 91 	movabs $0x4f473f91d116a800,%rcx
    9596:	3f 47 4f 
    9599:	48 01 c1             	add    %rax,%rcx
    959c:	48 b8 3f 9a ff 4c 49 	movabs $0x494cff9a3f,%rax
    95a3:	00 00 00 
    95a6:	4c 11 c8             	adc    %r9,%rax
    95a9:	48 89 c2             	mov    %rax,%rdx
    95ac:	48 0f ac ca 0b       	shrd   $0xb,%rcx,%rdx
    95b1:	48 0f a4 c8 35       	shld   $0x35,%rcx,%rax
    95b6:	48 b9 ab 45 74 e4 cf 	movabs $0x8fd3d1cfe47445ab,%rcx
    95bd:	d1 d3 8f 
    95c0:	48 39 c8             	cmp    %rcx,%rax
    95c3:	48 81 da e6 3f 53 12 	sbb    $0x12533fe6,%rdx
    95ca:	0f 82 27 02 00 00    	jb     97f7 <fwp_fmt_duration+0x317>
    95d0:	48 b9 7e 78 b9 2f 37 	movabs $0x97157d372fb9787e,%rcx
    95d7:	7d 15 97 
    95da:	48 0f af ce          	imul   %rsi,%rcx
    95de:	49 b9 6d 9c 2e 3a 42 	movabs $0x8e47ce423a2e9c6d,%r9
    95e5:	ce 47 8e 
    95e8:	48 89 f0             	mov    %rsi,%rax
    95eb:	49 f7 e1             	mul    %r9
    95ee:	48 01 ca             	add    %rcx,%rdx
    95f1:	4d 0f af c8          	imul   %r8,%r9
    95f5:	49 01 d1             	add    %rdx,%r9
    95f8:	48 b9 00 46 54 40 8b 	movabs $0xa52cb98b40544600,%rcx
    95ff:	b9 2c a5 
    9602:	48 01 c1             	add    %rax,%rcx
    9605:	48 b8 b5 09 fa 82 4b 	movabs $0x44b82fa09b5,%rax
    960c:	04 00 00 
    960f:	4c 11 c8             	adc    %r9,%rax
    9612:	48 89 c2             	mov    %rax,%rdx
    9615:	48 0f ac ca 09       	shrd   $0x9,%rcx,%rdx
    961a:	48 0f a4 c8 37       	shld   $0x37,%rcx,%rax
    961f:	48 b9 47 54 40 8b b9 	movabs $0xb5a52cb98b405447,%rcx
    9626:	2c a5 b5 
    9629:	48 39 c8             	cmp    %rcx,%rax
    962c:	48 b8 09 fa 82 4b 04 	movabs $0x44b82fa09,%rax
    9633:	00 00 00 
    9636:	48 19 c2             	sbb    %rax,%rdx
    9639:	0f 82 0d 03 00 00    	jb     994c <fwp_fmt_duration+0x46c>
    963f:	48 b9 cb d5 8f 4d f2 	movabs $0xc57e23f24d8fd5cb,%rcx
    9646:	23 7e c5 
    9649:	48 0f af ce          	imul   %rsi,%rcx
    964d:	49 b9 39 61 c2 68 56 	movabs $0x790fb65668c26139,%r9
    9654:	b6 0f 79 
    9657:	48 89 f0             	mov    %rsi,%rax
    965a:	49 f7 e1             	mul    %r9
    965d:	48 01 ca             	add    %rcx,%rdx
    9660:	4d 0f af c8          	imul   %r8,%r9
    9664:	49 01 d1             	add    %rdx,%r9
    9667:	48 b9 00 0b 27 69 fe 	movabs $0xa6d698fe69270b00,%rcx
    966e:	98 d6 a6 
    9671:	48 01 c1             	add    %rax,%rcx
    9674:	48 b8 b1 bd 16 f4 de 	movabs $0x218def416bdb1,%rax
    967b:	18 02 00 
    967e:	4c 11 c8             	adc    %r9,%rax
    9681:	48 89 c2             	mov    %rax,%rdx
    9684:	48 0f ac ca 06       	shrd   $0x6,%rcx,%rdx
    9689:	48 0f a4 c8 3a       	shld   $0x3a,%rcx,%rax
    968e:	48 b9 59 38 49 f3 c7 	movabs $0x8d36b4c7f3493859,%rcx
    9695:	b4 36 8d 
    9698:	48 39 c8             	cmp    %rcx,%rax
    969b:	48 b8 ed b5 a0 f7 c6 	movabs $0x10c6f7a0b5ed,%rax
    96a2:	10 00 00 
    96a5:	48 19 c2             	sbb    %rax,%rdx
    96a8:	0f 82 ad 02 00 00    	jb     995b <fwp_fmt_duration+0x47b>
    96ae:	48 b9 5a 64 3b df 4f 	movabs $0x6e978d4fdf3b645a,%rcx
    96b5:	8d 97 6e 
    96b8:	48 0f af ce          	imul   %rsi,%rcx
    96bc:	49 b9 d5 78 e9 26 31 	movabs $0x1cac083126e978d5,%r9
    96c3:	08 ac 1c 
    96c6:	48 89 f0             	mov    %rsi,%rax
    96c9:	49 f7 e1             	mul    %r9
    96cc:	48 01 ca             	add    %rcx,%rdx
    96cf:	4d 0f af c8          	imul   %r8,%r9
    96d3:	49 01 d1             	add    %rdx,%r9
    96d6:	48 b9 48 62 10 58 39 	movabs $0x76c8b43958106248,%rcx
    96dd:	b4 c8 76 
    96e0:	48 01 c1             	add    %rax,%rcx
    96e3:	48 b8 be 9f 1a 2f dd 	movabs $0x10624dd2f1a9fbe,%rax
    96ea:	24 06 01 
    96ed:	4c 11 c8             	adc    %r9,%rax
    96f0:	48 89 c2             	mov    %rax,%rdx
    96f3:	48 0f ac ca 03       	shrd   $0x3,%rcx,%rdx
    96f8:	48 0f a4 c8 3d       	shld   $0x3d,%rcx,%rax
    96fd:	48 b9 93 18 04 56 0e 	movabs $0x9db22d0e56041893,%rcx
    9704:	2d b2 9d 
    9707:	48 39 c8             	cmp    %rcx,%rax
    970a:	48 b8 ef a7 c6 4b 37 	movabs $0x4189374bc6a7ef,%rax
    9711:	89 41 00 
    9714:	48 19 c2             	sbb    %rax,%rdx
    9717:	0f 82 4d 02 00 00    	jb     996a <fwp_fmt_duration+0x48a>
    971d:	4d 85 c0             	test   %r8,%r8
    9720:	0f 88 d6 06 00 00    	js     9dfc <fwp_fmt_duration+0x91c>
    9726:	45 31 d2             	xor    %r10d,%r10d
    9729:	49 bb cd cc cc cc cc 	movabs $0xcccccccccccccccd,%r11
    9730:	cc cc cc 
    9733:	48 bb cc cc cc cc cc 	movabs $0xcccccccccccccccc,%rbx
    973a:	cc cc cc 
    973d:	4d 89 c6             	mov    %r8,%r14
    9740:	4c 89 c1             	mov    %r8,%rcx
    9743:	48 0f a4 f1 3f       	shld   $0x3f,%rsi,%rcx
    9748:	49 d1 ee             	shr    $1,%r14
    974b:	49 89 c9             	mov    %rcx,%r9
    974e:	4d 01 f1             	add    %r14,%r9
    9751:	49 83 d1 00          	adc    $0x0,%r9
    9755:	4c 89 c8             	mov    %r9,%rax
    9758:	49 f7 e3             	mul    %r11
    975b:	48 c1 ea 02          	shr    $0x2,%rdx
    975f:	48 8d 04 92          	lea    (%rdx,%rdx,4),%rax
    9763:	49 29 c1             	sub    %rax,%r9
    9766:	4c 29 c9             	sub    %r9,%rcx
    9769:	49 83 de 00          	sbb    $0x0,%r14
    976d:	49 89 c9             	mov    %rcx,%r9
    9770:	4c 0f af cb          	imul   %rbx,%r9
    9774:	48 89 c8             	mov    %rcx,%rax
    9777:	49 f7 e3             	mul    %r11
    977a:	4c 01 ca             	add    %r9,%rdx
    977d:	4d 0f af f3          	imul   %r11,%r14
    9781:	49 01 d6             	add    %rdx,%r14
    9784:	48 89 c1             	mov    %rax,%rcx
    9787:	48 01 c1             	add    %rax,%rcx
    978a:	48 8d 0c 89          	lea    (%rcx,%rcx,4),%rcx
    978e:	89 f2                	mov    %esi,%edx
    9790:	29 ca                	sub    %ecx,%edx
    9792:	80 ca 30             	or     $0x30,%dl
    9795:	42 88 54 14 40       	mov    %dl,0x40(%rsp,%r10,1)
    979a:	49 ff c2             	inc    %r10
    979d:	48 83 fe 0a          	cmp    $0xa,%rsi
    97a1:	49 83 d8 00          	sbb    $0x0,%r8
    97a5:	48 89 c6             	mov    %rax,%rsi
    97a8:	4d 89 f0             	mov    %r14,%r8
    97ab:	73 93                	jae    9740 <fwp_fmt_duration+0x260>
    97ad:	45 85 d2             	test   %r10d,%r10d
    97b0:	7f 12                	jg     97c4 <fwp_fmt_duration+0x2e4>
    97b2:	31 c0                	xor    %eax,%eax
    97b4:	e9 79 01 00 00       	jmp    9932 <fwp_fmt_duration+0x452>
    97b9:	c6 44 24 40 30       	movb   $0x30,0x40(%rsp)
    97be:	41 ba 01 00 00 00    	mov    $0x1,%r10d
    97c4:	44 89 d0             	mov    %r10d,%eax
    97c7:	48 83 f8 08          	cmp    $0x8,%rax
    97cb:	73 1e                	jae    97eb <fwp_fmt_duration+0x30b>
    97cd:	31 c9                	xor    %ecx,%ecx
    97cf:	48 89 c2             	mov    %rax,%rdx
    97d2:	e9 3d 01 00 00       	jmp    9914 <fwp_fmt_duration+0x434>
    97d7:	49 89 fe             	mov    %rdi,%r14
    97da:	48 ba 00 a0 b8 30 46 	movabs $0x34630b8a000,%rdx
    97e1:	03 00 00 
    97e4:	31 c0                	xor    %eax,%eax
    97e6:	e9 8c 01 00 00       	jmp    9977 <fwp_fmt_duration+0x497>
    97eb:	83 f8 20             	cmp    $0x20,%eax
    97ee:	73 1e                	jae    980e <fwp_fmt_duration+0x32e>
    97f0:	31 c9                	xor    %ecx,%ecx
    97f2:	e9 c3 00 00 00       	jmp    98ba <fwp_fmt_duration+0x3da>
    97f7:	49 89 fe             	mov    %rdi,%r14
    97fa:	48 ba 00 58 47 f8 0d 	movabs $0xdf8475800,%rdx
    9801:	00 00 00 
    9804:	b8 01 00 00 00       	mov    $0x1,%eax
    9809:	e9 69 01 00 00       	jmp    9977 <fwp_fmt_duration+0x497>
    980e:	44 89 d2             	mov    %r10d,%edx
    9811:	83 e2 1f             	and    $0x1f,%edx
    9814:	48 89 c1             	mov    %rax,%rcx
    9817:	48 29 d1             	sub    %rdx,%rcx
    981a:	48 8d 74 24 10       	lea    0x10(%rsp),%rsi
    981f:	66 0f ef c0          	pxor   %xmm0,%xmm0
    9823:	49 89 c0             	mov    %rax,%r8
    9826:	66 2e 0f 1f 84 00 00 	cs nopw 0x0(%rax,%rax,1)
    982d:	00 00 00 
    9830:	f3 42 0f 6f 4c 04 20 	movdqu 0x20(%rsp,%r8,1),%xmm1
    9837:	f3 42 0f 6f 54 04 30 	movdqu 0x30(%rsp,%r8,1),%xmm2
    983e:	66 0f 6f da          	movdqa %xmm2,%xmm3
    9842:	66 0f 60 d8          	punpcklbw %xmm0,%xmm3
    9846:	66 0f 70 db 4e       	pshufd $0x4e,%xmm3,%xmm3
    984b:	f2 0f 70 db 1b       	pshuflw $0x1b,%xmm3,%xmm3
    9850:	f3 0f 70 db 1b       	pshufhw $0x1b,%xmm3,%xmm3
    9855:	66 0f 68 d0          	punpckhbw %xmm0,%xmm2
    9859:	66 0f 70 d2 4e       	pshufd $0x4e,%xmm2,%xmm2
    985e:	f2 0f 70 d2 1b       	pshuflw $0x1b,%xmm2,%xmm2
    9863:	f3 0f 70 d2 1b       	pshufhw $0x1b,%xmm2,%xmm2
    9868:	66 0f 67 d3          	packuswb %xmm3,%xmm2
    986c:	66 0f 6f d9          	movdqa %xmm1,%xmm3
    9870:	66 0f 60 d8          	punpcklbw %xmm0,%xmm3
    9874:	66 0f 70 db 4e       	pshufd $0x4e,%xmm3,%xmm3
    9879:	f2 0f 70 db 1b       	pshuflw $0x1b,%xmm3,%xmm3
    987e:	f3 0f 70 db 1b       	pshufhw $0x1b,%xmm3,%xmm3
    9883:	66 0f 68 c8          	punpckhbw %xmm0,%xmm1
    9887:	66 0f 70 c9 4e       	pshufd $0x4e,%xmm1,%xmm1
    988c:	f2 0f 70 c9 1b       	pshuflw $0x1b,%xmm1,%xmm1
    9891:	f3 0f 70 c9 1b       	pshufhw $0x1b,%xmm1,%xmm1
    9896:	66 0f 67 cb          	packuswb %xmm3,%xmm1
    989a:	66 0f 7f 56 f0       	movdqa %xmm2,-0x10(%rsi)
    989f:	66 0f 7f 0e          	movdqa %xmm1,(%rsi)
    98a3:	49 83 c0 e0          	add    $0xffffffffffffffe0,%r8
    98a7:	48 83 c6 20          	add    $0x20,%rsi
    98ab:	4c 39 c2             	cmp    %r8,%rdx
    98ae:	75 80                	jne    9830 <fwp_fmt_duration+0x350>
    98b0:	48 85 d2             	test   %rdx,%rdx
    98b3:	74 7d                	je     9932 <fwp_fmt_duration+0x452>
    98b5:	83 fa 08             	cmp    $0x8,%edx
    98b8:	72 5a                	jb     9914 <fwp_fmt_duration+0x434>
    98ba:	44 89 d2             	mov    %r10d,%edx
    98bd:	83 e2 07             	and    $0x7,%edx
    98c0:	48 89 c6             	mov    %rax,%rsi
    98c3:	48 29 ce             	sub    %rcx,%rsi
    98c6:	4c 8d 04 0c          	lea    (%rsp,%rcx,1),%r8
    98ca:	48 89 c1             	mov    %rax,%rcx
    98cd:	48 29 d1             	sub    %rdx,%rcx
    98d0:	66 0f ef c0          	pxor   %xmm0,%xmm0
    98d4:	66 66 66 2e 0f 1f 84 	data16 data16 cs nopw 0x0(%rax,%rax,1)
    98db:	00 00 00 00 00 
    98e0:	f3 0f 7e 4c 34 38    	movq   0x38(%rsp,%rsi,1),%xmm1
    98e6:	66 0f 60 c8          	punpcklbw %xmm0,%xmm1
    98ea:	66 0f 70 c9 4e       	pshufd $0x4e,%xmm1,%xmm1
    98ef:	f2 0f 70 c9 1b       	pshuflw $0x1b,%xmm1,%xmm1
    98f4:	f3 0f 70 c9 1b       	pshufhw $0x1b,%xmm1,%xmm1
    98f9:	66 0f 67 c9          	packuswb %xmm1,%xmm1
    98fd:	66 41 0f d6 08       	movq   %xmm1,(%r8)
    9902:	48 83 c6 f8          	add    $0xfffffffffffffff8,%rsi
    9906:	49 83 c0 08          	add    $0x8,%r8
    990a:	48 39 f2             	cmp    %rsi,%rdx
    990d:	75 d1                	jne    98e0 <fwp_fmt_duration+0x400>
    990f:	48 85 d2             	test   %rdx,%rdx
    9912:	74 1e                	je     9932 <fwp_fmt_duration+0x452>
    9914:	48 8d 74 24 40       	lea    0x40(%rsp),%rsi
    9919:	48 01 f2             	add    %rsi,%rdx
    991c:	48 ff ca             	dec    %rdx
    991f:	90                   	nop
    9920:	0f b6 32             	movzbl (%rdx),%esi
    9923:	40 88 34 0c          	mov    %sil,(%rsp,%rcx,1)
    9927:	48 ff c1             	inc    %rcx
    992a:	48 ff ca             	dec    %rdx
    992d:	48 39 c8             	cmp    %rcx,%rax
    9930:	75 ee                	jne    9920 <fwp_fmt_duration+0x440>
    9932:	c6 04 04 00          	movb   $0x0,(%rsp,%rax,1)
    9936:	48 8d 35 f0 5d 00 00 	lea    0x5df0(%rip),%rsi        # f72d <fwp_segv.msg+0x4ad>
    993d:	48 89 e2             	mov    %rsp,%rdx
    9940:	31 c0                	xor    %eax,%eax
    9942:	e8 19 89 ff ff       	call   2260 <sprintf@plt>
    9947:	e9 a1 04 00 00       	jmp    9ded <fwp_fmt_duration+0x90d>
    994c:	49 89 fe             	mov    %rdi,%r14
    994f:	ba 00 ca 9a 3b       	mov    $0x3b9aca00,%edx
    9954:	b8 02 00 00 00       	mov    $0x2,%eax
    9959:	eb 1c                	jmp    9977 <fwp_fmt_duration+0x497>
    995b:	49 89 fe             	mov    %rdi,%r14
    995e:	ba 40 42 0f 00       	mov    $0xf4240,%edx
    9963:	b8 03 00 00 00       	mov    $0x3,%eax
    9968:	eb 0d                	jmp    9977 <fwp_fmt_duration+0x497>
    996a:	49 89 fe             	mov    %rdi,%r14
    996d:	ba e8 03 00 00       	mov    $0x3e8,%edx
    9972:	b8 04 00 00 00       	mov    $0x4,%eax
    9977:	31 c9                	xor    %ecx,%ecx
    9979:	c1 e0 04             	shl    $0x4,%eax
    997c:	48 8d 1d ed 83 00 00 	lea    0x83ed(%rip),%rbx        # 11d70 <fwp_fmt_duration.units>
    9983:	48 01 c3             	add    %rax,%rbx
    9986:	48 89 f7             	mov    %rsi,%rdi
    9989:	4c 89 c6             	mov    %r8,%rsi
    998c:	e8 1f 4e 00 00       	call   e7b0 <__divti3>
    9991:	48 89 c1             	mov    %rax,%rcx
    9994:	48 89 d6             	mov    %rdx,%rsi
    9997:	48 85 d2             	test   %rdx,%rdx
    999a:	0f 88 b0 00 00 00    	js     9a50 <fwp_fmt_duration+0x570>
    99a0:	48 89 c8             	mov    %rcx,%rax
    99a3:	48 09 f0             	or     %rsi,%rax
    99a6:	0f 84 61 01 00 00    	je     9b0d <fwp_fmt_duration+0x62d>
    99ac:	45 31 d2             	xor    %r10d,%r10d
    99af:	49 bb cd cc cc cc cc 	movabs $0xcccccccccccccccd,%r11
    99b6:	cc cc cc 
    99b9:	49 bf cc cc cc cc cc 	movabs $0xcccccccccccccccc,%r15
    99c0:	cc cc cc 
    99c3:	49 89 f4             	mov    %rsi,%r12
    99c6:	4c 89 f7             	mov    %r14,%rdi
    99c9:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)
    99d0:	49 89 f0             	mov    %rsi,%r8
    99d3:	49 0f a4 c8 3f       	shld   $0x3f,%rcx,%r8
    99d8:	49 d1 ec             	shr    $1,%r12
    99db:	4d 89 c1             	mov    %r8,%r9
    99de:	4d 01 e1             	add    %r12,%r9
    99e1:	49 83 d1 00          	adc    $0x0,%r9
    99e5:	4c 89 c8             	mov    %r9,%rax
    99e8:	49 f7 e3             	mul    %r11
    99eb:	48 c1 ea 02          	shr    $0x2,%rdx
    99ef:	48 8d 04 92          	lea    (%rdx,%rdx,4),%rax
    99f3:	49 29 c1             	sub    %rax,%r9
    99f6:	4d 29 c8             	sub    %r9,%r8
    99f9:	49 83 dc 00          	sbb    $0x0,%r12
    99fd:	4d 89 c1             	mov    %r8,%r9
    9a00:	4d 0f af cf          	imul   %r15,%r9
    9a04:	4c 89 c0             	mov    %r8,%rax
    9a07:	49 f7 e3             	mul    %r11
    9a0a:	4c 01 ca             	add    %r9,%rdx
    9a0d:	4d 0f af e3          	imul   %r11,%r12
    9a11:	49 01 d4             	add    %rdx,%r12
    9a14:	48 89 c2             	mov    %rax,%rdx
    9a17:	48 01 c2             	add    %rax,%rdx
    9a1a:	48 8d 14 92          	lea    (%rdx,%rdx,4),%rdx
    9a1e:	41 89 c8             	mov    %ecx,%r8d
    9a21:	41 29 d0             	sub    %edx,%r8d
    9a24:	41 80 c8 30          	or     $0x30,%r8b
    9a28:	46 88 44 14 40       	mov    %r8b,0x40(%rsp,%r10,1)
    9a2d:	49 ff c2             	inc    %r10
    9a30:	48 83 f9 0a          	cmp    $0xa,%rcx
    9a34:	48 83 de 00          	sbb    $0x0,%rsi
    9a38:	48 89 c1             	mov    %rax,%rcx
    9a3b:	4c 89 e6             	mov    %r12,%rsi
    9a3e:	73 90                	jae    99d0 <fwp_fmt_duration+0x4f0>
    9a40:	45 85 d2             	test   %r10d,%r10d
    9a43:	0f 8f d2 00 00 00    	jg     9b1b <fwp_fmt_duration+0x63b>
    9a49:	31 c0                	xor    %eax,%eax
    9a4b:	e9 12 02 00 00       	jmp    9c62 <fwp_fmt_duration+0x782>
    9a50:	45 31 c0             	xor    %r8d,%r8d
    9a53:	48 f7 d9             	neg    %rcx
    9a56:	41 b9 00 00 00 00    	mov    $0x0,%r9d
    9a5c:	49 19 f1             	sbb    %rsi,%r9
    9a5f:	c6 04 24 2d          	movb   $0x2d,(%rsp)
    9a63:	49 ba cd cc cc cc cc 	movabs $0xcccccccccccccccd,%r10
    9a6a:	cc cc cc 
    9a6d:	49 bb cc cc cc cc cc 	movabs $0xcccccccccccccccc,%r11
    9a74:	cc cc cc 
    9a77:	4d 89 cf             	mov    %r9,%r15
    9a7a:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)
    9a80:	4c 89 ce             	mov    %r9,%rsi
    9a83:	48 0f a4 ce 3f       	shld   $0x3f,%rcx,%rsi
    9a88:	49 d1 ef             	shr    $1,%r15
    9a8b:	48 89 f7             	mov    %rsi,%rdi
    9a8e:	4c 01 ff             	add    %r15,%rdi
    9a91:	48 83 d7 00          	adc    $0x0,%rdi
    9a95:	48 89 f8             	mov    %rdi,%rax
    9a98:	49 f7 e2             	mul    %r10
    9a9b:	48 c1 ea 02          	shr    $0x2,%rdx
    9a9f:	48 8d 04 92          	lea    (%rdx,%rdx,4),%rax
    9aa3:	48 29 c7             	sub    %rax,%rdi
    9aa6:	48 29 fe             	sub    %rdi,%rsi
    9aa9:	49 83 df 00          	sbb    $0x0,%r15
    9aad:	48 89 f7             	mov    %rsi,%rdi
    9ab0:	49 0f af fb          	imul   %r11,%rdi
    9ab4:	48 89 f0             	mov    %rsi,%rax
    9ab7:	49 f7 e2             	mul    %r10
    9aba:	48 01 fa             	add    %rdi,%rdx
    9abd:	4d 0f af fa          	imul   %r10,%r15
    9ac1:	49 01 d7             	add    %rdx,%r15
    9ac4:	48 89 c2             	mov    %rax,%rdx
    9ac7:	48 01 c2             	add    %rax,%rdx
    9aca:	48 8d 14 92          	lea    (%rdx,%rdx,4),%rdx
    9ace:	89 ce                	mov    %ecx,%esi
    9ad0:	29 d6                	sub    %edx,%esi
    9ad2:	40 80 ce 30          	or     $0x30,%sil
    9ad6:	42 88 74 04 40       	mov    %sil,0x40(%rsp,%r8,1)
    9adb:	49 ff c0             	inc    %r8
    9ade:	48 83 f9 0a          	cmp    $0xa,%rcx
    9ae2:	49 83 d9 00          	sbb    $0x0,%r9
    9ae6:	48 89 c1             	mov    %rax,%rcx
    9ae9:	4d 89 f9             	mov    %r15,%r9
    9aec:	73 92                	jae    9a80 <fwp_fmt_duration+0x5a0>
    9aee:	45 85 c0             	test   %r8d,%r8d
    9af1:	4c 89 f7             	mov    %r14,%rdi
    9af4:	7e 44                	jle    9b3a <fwp_fmt_duration+0x65a>
    9af6:	44 89 c0             	mov    %r8d,%eax
    9af9:	48 83 f8 08          	cmp    $0x8,%rax
    9afd:	0f 83 68 01 00 00    	jae    9c6b <fwp_fmt_duration+0x78b>
    9b03:	31 c9                	xor    %ecx,%ecx
    9b05:	48 89 c2             	mov    %rax,%rdx
    9b08:	e9 97 02 00 00       	jmp    9da4 <fwp_fmt_duration+0x8c4>
    9b0d:	c6 44 24 40 30       	movb   $0x30,0x40(%rsp)
    9b12:	41 ba 01 00 00 00    	mov    $0x1,%r10d
    9b18:	4c 89 f7             	mov    %r14,%rdi
    9b1b:	44 89 d0             	mov    %r10d,%eax
    9b1e:	48 83 f8 08          	cmp    $0x8,%rax
    9b22:	73 0a                	jae    9b2e <fwp_fmt_duration+0x64e>
    9b24:	31 c9                	xor    %ecx,%ecx
    9b26:	48 89 c2             	mov    %rax,%rdx
    9b29:	e9 16 01 00 00       	jmp    9c44 <fwp_fmt_duration+0x764>
    9b2e:	83 f8 20             	cmp    $0x20,%eax
    9b31:	73 0e                	jae    9b41 <fwp_fmt_duration+0x661>
    9b33:	31 c9                	xor    %ecx,%ecx
    9b35:	e9 b0 00 00 00       	jmp    9bea <fwp_fmt_duration+0x70a>
    9b3a:	31 c0                	xor    %eax,%eax
    9b3c:	e9 93 02 00 00       	jmp    9dd4 <fwp_fmt_duration+0x8f4>
    9b41:	44 89 d2             	mov    %r10d,%edx
    9b44:	83 e2 1f             	and    $0x1f,%edx
    9b47:	48 89 c1             	mov    %rax,%rcx
    9b4a:	48 29 d1             	sub    %rdx,%rcx
    9b4d:	48 8d 74 24 10       	lea    0x10(%rsp),%rsi
    9b52:	66 0f ef c0          	pxor   %xmm0,%xmm0
    9b56:	49 89 c0             	mov    %rax,%r8
    9b59:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)
    9b60:	f3 42 0f 6f 4c 04 20 	movdqu 0x20(%rsp,%r8,1),%xmm1
    9b67:	f3 42 0f 6f 54 04 30 	movdqu 0x30(%rsp,%r8,1),%xmm2
    9b6e:	66 0f 6f da          	movdqa %xmm2,%xmm3
    9b72:	66 0f 60 d8          	punpcklbw %xmm0,%xmm3
    9b76:	66 0f 70 db 4e       	pshufd $0x4e,%xmm3,%xmm3
    9b7b:	f2 0f 70 db 1b       	pshuflw $0x1b,%xmm3,%xmm3
    9b80:	f3 0f 70 db 1b       	pshufhw $0x1b,%xmm3,%xmm3
    9b85:	66 0f 68 d0          	punpckhbw %xmm0,%xmm2
    9b89:	66 0f 70 d2 4e       	pshufd $0x4e,%xmm2,%xmm2
    9b8e:	f2 0f 70 d2 1b       	pshuflw $0x1b,%xmm2,%xmm2
    9b93:	f3 0f 70 d2 1b       	pshufhw $0x1b,%xmm2,%xmm2
    9b98:	66 0f 67 d3          	packuswb %xmm3,%xmm2
    9b9c:	66 0f 6f d9          	movdqa %xmm1,%xmm3
    9ba0:	66 0f 60 d8          	punpcklbw %xmm0,%xmm3
    9ba4:	66 0f 70 db 4e       	pshufd $0x4e,%xmm3,%xmm3
    9ba9:	f2 0f 70 db 1b       	pshuflw $0x1b,%xmm3,%xmm3
    9bae:	f3 0f 70 db 1b       	pshufhw $0x1b,%xmm3,%xmm3
    9bb3:	66 0f 68 c8          	punpckhbw %xmm0,%xmm1
    9bb7:	66 0f 70 c9 4e       	pshufd $0x4e,%xmm1,%xmm1
    9bbc:	f2 0f 70 c9 1b       	pshuflw $0x1b,%xmm1,%xmm1
    9bc1:	f3 0f 70 c9 1b       	pshufhw $0x1b,%xmm1,%xmm1
    9bc6:	66 0f 67 cb          	packuswb %xmm3,%xmm1
    9bca:	66 0f 7f 56 f0       	movdqa %xmm2,-0x10(%rsi)
    9bcf:	66 0f 7f 0e          	movdqa %xmm1,(%rsi)
    9bd3:	49 83 c0 e0          	add    $0xffffffffffffffe0,%r8
    9bd7:	48 83 c6 20          	add    $0x20,%rsi
    9bdb:	4c 39 c2             	cmp    %r8,%rdx
    9bde:	75 80                	jne    9b60 <fwp_fmt_duration+0x680>
    9be0:	48 85 d2             	test   %rdx,%rdx
    9be3:	74 7d                	je     9c62 <fwp_fmt_duration+0x782>
    9be5:	83 fa 08             	cmp    $0x8,%edx
    9be8:	72 5a                	jb     9c44 <fwp_fmt_duration+0x764>
    9bea:	44 89 d2             	mov    %r10d,%edx
    9bed:	83 e2 07             	and    $0x7,%edx
    9bf0:	48 89 c6             	mov    %rax,%rsi
    9bf3:	48 29 ce             	sub    %rcx,%rsi
    9bf6:	4c 8d 04 0c          	lea    (%rsp,%rcx,1),%r8
    9bfa:	48 89 c1             	mov    %rax,%rcx
    9bfd:	48 29 d1             	sub    %rdx,%rcx
    9c00:	66 0f ef c0          	pxor   %xmm0,%xmm0
    9c04:	66 66 66 2e 0f 1f 84 	data16 data16 cs nopw 0x0(%rax,%rax,1)
    9c0b:	00 00 00 00 00 
    9c10:	f3 0f 7e 4c 34 38    	movq   0x38(%rsp,%rsi,1),%xmm1
    9c16:	66 0f 60 c8          	punpcklbw %xmm0,%xmm1
    9c1a:	66 0f 70 c9 4e       	pshufd $0x4e,%xmm1,%xmm1
    9c1f:	f2 0f 70 c9 1b       	pshuflw $0x1b,%xmm1,%xmm1
    9c24:	f3 0f 70 c9 1b       	pshufhw $0x1b,%xmm1,%xmm1
    9c29:	66 0f 67 c9          	packuswb %xmm1,%xmm1
    9c2d:	66 41 0f d6 08       	movq   %xmm1,(%r8)
    9c32:	48 83 c6 f8          	add    $0xfffffffffffffff8,%rsi
    9c36:	49 83 c0 08          	add    $0x8,%r8
    9c3a:	48 39 f2             	cmp    %rsi,%rdx
    9c3d:	75 d1                	jne    9c10 <fwp_fmt_duration+0x730>
    9c3f:	48 85 d2             	test   %rdx,%rdx
    9c42:	74 1e                	je     9c62 <fwp_fmt_duration+0x782>
    9c44:	48 8d 74 24 40       	lea    0x40(%rsp),%rsi
    9c49:	48 01 f2             	add    %rsi,%rdx
    9c4c:	48 ff ca             	dec    %rdx
    9c4f:	90                   	nop
    9c50:	0f b6 32             	movzbl (%rdx),%esi
    9c53:	40 88 34 0c          	mov    %sil,(%rsp,%rcx,1)
    9c57:	48 ff c1             	inc    %rcx
    9c5a:	48 ff ca             	dec    %rdx
    9c5d:	48 39 c8             	cmp    %rcx,%rax
    9c60:	75 ee                	jne    9c50 <fwp_fmt_duration+0x770>
    9c62:	c6 04 04 00          	movb   $0x0,(%rsp,%rax,1)
    9c66:	e9 6e 01 00 00       	jmp    9dd9 <fwp_fmt_duration+0x8f9>
    9c6b:	83 f8 20             	cmp    $0x20,%eax
    9c6e:	73 07                	jae    9c77 <fwp_fmt_duration+0x797>
    9c70:	31 c9                	xor    %ecx,%ecx
    9c72:	e9 bd 00 00 00       	jmp    9d34 <fwp_fmt_duration+0x854>
    9c77:	44 89 c6             	mov    %r8d,%esi
    9c7a:	44 89 c2             	mov    %r8d,%edx
    9c7d:	83 e2 1f             	and    $0x1f,%edx
    9c80:	48 89 c1             	mov    %rax,%rcx
    9c83:	48 29 d1             	sub    %rdx,%rcx
    9c86:	4c 8d 0c 34          	lea    (%rsp,%rsi,1),%r9
    9c8a:	49 83 c1 30          	add    $0x30,%r9
    9c8e:	48 29 d6             	sub    %rdx,%rsi
    9c91:	45 31 d2             	xor    %r10d,%r10d
    9c94:	66 0f ef c0          	pxor   %xmm0,%xmm0
    9c98:	0f 1f 84 00 00 00 00 	nopl   0x0(%rax,%rax,1)
    9c9f:	00 
    9ca0:	f3 41 0f 6f 49 f0    	movdqu -0x10(%r9),%xmm1
    9ca6:	f3 41 0f 6f 11       	movdqu (%r9),%xmm2
    9cab:	66 0f 6f da          	movdqa %xmm2,%xmm3
    9caf:	66 0f 60 d8          	punpcklbw %xmm0,%xmm3
    9cb3:	66 0f 70 db 4e       	pshufd $0x4e,%xmm3,%xmm3
    9cb8:	f2 0f 70 db 1b       	pshuflw $0x1b,%xmm3,%xmm3
    9cbd:	f3 0f 70 db 1b       	pshufhw $0x1b,%xmm3,%xmm3
    9cc2:	66 0f 68 d0          	punpckhbw %xmm0,%xmm2
    9cc6:	66 0f 70 d2 4e       	pshufd $0x4e,%xmm2,%xmm2
    9ccb:	f2 0f 70 d2 1b       	pshuflw $0x1b,%xmm2,%xmm2
    9cd0:	f3 0f 70 d2 1b       	pshufhw $0x1b,%xmm2,%xmm2
    9cd5:	66 0f 67 d3          	packuswb %xmm3,%xmm2
    9cd9:	66 0f 6f d9          	movdqa %xmm1,%xmm3
    9cdd:	66 0f 60 d8          	punpcklbw %xmm0,%xmm3
    9ce1:	66 0f 70 db 4e       	pshufd $0x4e,%xmm3,%xmm3
    9ce6:	f2 0f 70 db 1b       	pshuflw $0x1b,%xmm3,%xmm3
    9ceb:	f3 0f 70 db 1b       	pshufhw $0x1b,%xmm3,%xmm3
    9cf0:	66 0f 68 c8          	punpckhbw %xmm0,%xmm1
    9cf4:	66 0f 70 c9 4e       	pshufd $0x4e,%xmm1,%xmm1
    9cf9:	f2 0f 70 c9 1b       	pshuflw $0x1b,%xmm1,%xmm1
    9cfe:	f3 0f 70 c9 1b       	pshufhw $0x1b,%xmm1,%xmm1
    9d03:	66 0f 67 cb          	packuswb %xmm3,%xmm1
    9d07:	f3 42 0f 7f 54 14 01 	movdqu %xmm2,0x1(%rsp,%r10,1)
    9d0e:	f3 42 0f 7f 4c 14 11 	movdqu %xmm1,0x11(%rsp,%r10,1)
    9d15:	49 83 c2 20          	add    $0x20,%r10
    9d19:	49 83 c1 e0          	add    $0xffffffffffffffe0,%r9
    9d1d:	4c 39 d6             	cmp    %r10,%rsi
    9d20:	0f 85 7a ff ff ff    	jne    9ca0 <fwp_fmt_duration+0x7c0>
    9d26:	48 85 d2             	test   %rdx,%rdx
    9d29:	0f 84 a5 00 00 00    	je     9dd4 <fwp_fmt_duration+0x8f4>
    9d2f:	83 fa 08             	cmp    $0x8,%edx
    9d32:	72 70                	jb     9da4 <fwp_fmt_duration+0x8c4>
    9d34:	48 89 ce             	mov    %rcx,%rsi
    9d37:	45 89 c1             	mov    %r8d,%r9d
    9d3a:	44 89 c2             	mov    %r8d,%edx
    9d3d:	83 e2 07             	and    $0x7,%edx
    9d40:	48 89 c1             	mov    %rax,%rcx
    9d43:	48 29 d1             	sub    %rdx,%rcx
    9d46:	49 89 f2             	mov    %rsi,%r10
    9d49:	49 f7 da             	neg    %r10
    9d4c:	49 01 e2             	add    %rsp,%r10
    9d4f:	49 83 c2 40          	add    $0x40,%r10
    9d53:	4d 01 ca             	add    %r9,%r10
    9d56:	49 83 c2 f8          	add    $0xfffffffffffffff8,%r10
    9d5a:	49 29 d1             	sub    %rdx,%r9
    9d5d:	66 0f ef c0          	pxor   %xmm0,%xmm0
    9d61:	66 66 66 66 66 66 2e 	data16 data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    9d68:	0f 1f 84 00 00 00 00 
    9d6f:	00 
    9d70:	f3 41 0f 7e 0a       	movq   (%r10),%xmm1
    9d75:	66 0f 60 c8          	punpcklbw %xmm0,%xmm1
    9d79:	66 0f 70 c9 4e       	pshufd $0x4e,%xmm1,%xmm1
    9d7e:	f2 0f 70 c9 1b       	pshuflw $0x1b,%xmm1,%xmm1
    9d83:	f3 0f 70 c9 1b       	pshufhw $0x1b,%xmm1,%xmm1
    9d88:	66 0f 67 c9          	packuswb %xmm1,%xmm1
    9d8c:	66 0f d6 4c 34 01    	movq   %xmm1,0x1(%rsp,%rsi,1)
    9d92:	48 83 c6 08          	add    $0x8,%rsi
    9d96:	49 83 c2 f8          	add    $0xfffffffffffffff8,%r10
    9d9a:	49 39 f1             	cmp    %rsi,%r9
    9d9d:	75 d1                	jne    9d70 <fwp_fmt_duration+0x890>
    9d9f:	48 85 d2             	test   %rdx,%rdx
    9da2:	74 30                	je     9dd4 <fwp_fmt_duration+0x8f4>
    9da4:	48 8d 74 24 40       	lea    0x40(%rsp),%rsi
    9da9:	48 01 f2             	add    %rsi,%rdx
    9dac:	48 ff ca             	dec    %rdx
    9daf:	44 89 c6             	mov    %r8d,%esi
    9db2:	66 66 66 66 66 2e 0f 	data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    9db9:	1f 84 00 00 00 00 00 
    9dc0:	44 0f b6 02          	movzbl (%rdx),%r8d
    9dc4:	44 88 44 0c 01       	mov    %r8b,0x1(%rsp,%rcx,1)
    9dc9:	48 ff c1             	inc    %rcx
    9dcc:	48 ff ca             	dec    %rdx
    9dcf:	48 39 ce             	cmp    %rcx,%rsi
    9dd2:	75 ec                	jne    9dc0 <fwp_fmt_duration+0x8e0>
    9dd4:	c6 44 04 01 00       	movb   $0x0,0x1(%rsp,%rax,1)
    9dd9:	48 8b 0b             	mov    (%rbx),%rcx
    9ddc:	48 8d 35 45 59 00 00 	lea    0x5945(%rip),%rsi        # f728 <fwp_segv.msg+0x4a8>
    9de3:	48 89 e2             	mov    %rsp,%rdx
    9de6:	31 c0                	xor    %eax,%eax
    9de8:	e8 73 84 ff ff       	call   2260 <sprintf@plt>
    9ded:	48 81 c4 88 00 00 00 	add    $0x88,%rsp
    9df4:	5b                   	pop    %rbx
    9df5:	41 5c                	pop    %r12
    9df7:	41 5e                	pop    %r14
    9df9:	41 5f                	pop    %r15
    9dfb:	c3                   	ret
    9dfc:	45 31 c9             	xor    %r9d,%r9d
    9dff:	48 f7 de             	neg    %rsi
    9e02:	41 ba 00 00 00 00    	mov    $0x0,%r10d
    9e08:	4d 19 c2             	sbb    %r8,%r10
    9e0b:	c6 04 24 2d          	movb   $0x2d,(%rsp)
    9e0f:	49 bb cd cc cc cc cc 	movabs $0xcccccccccccccccd,%r11
    9e16:	cc cc cc 
    9e19:	48 bb cc cc cc cc cc 	movabs $0xcccccccccccccccc,%rbx
    9e20:	cc cc cc 
    9e23:	4d 89 d6             	mov    %r10,%r14
    9e26:	66 2e 0f 1f 84 00 00 	cs nopw 0x0(%rax,%rax,1)
    9e2d:	00 00 00 
    9e30:	4c 89 d1             	mov    %r10,%rcx
    9e33:	48 0f a4 f1 3f       	shld   $0x3f,%rsi,%rcx
    9e38:	49 d1 ee             	shr    $1,%r14
    9e3b:	49 89 c8             	mov    %rcx,%r8
    9e3e:	4d 01 f0             	add    %r14,%r8
    9e41:	49 83 d0 00          	adc    $0x0,%r8
    9e45:	4c 89 c0             	mov    %r8,%rax
    9e48:	49 f7 e3             	mul    %r11
    9e4b:	48 c1 ea 02          	shr    $0x2,%rdx
    9e4f:	48 8d 04 92          	lea    (%rdx,%rdx,4),%rax
    9e53:	49 29 c0             	sub    %rax,%r8
    9e56:	4c 29 c1             	sub    %r8,%rcx
    9e59:	49 83 de 00          	sbb    $0x0,%r14
    9e5d:	49 89 c8             	mov    %rcx,%r8
    9e60:	4c 0f af c3          	imul   %rbx,%r8
    9e64:	48 89 c8             	mov    %rcx,%rax
    9e67:	49 f7 e3             	mul    %r11
    9e6a:	4c 01 c2             	add    %r8,%rdx
    9e6d:	4d 0f af f3          	imul   %r11,%r14
    9e71:	49 01 d6             	add    %rdx,%r14
    9e74:	48 89 c1             	mov    %rax,%rcx
    9e77:	48 01 c1             	add    %rax,%rcx
    9e7a:	48 8d 0c 89          	lea    (%rcx,%rcx,4),%rcx
    9e7e:	89 f2                	mov    %esi,%edx
    9e80:	29 ca                	sub    %ecx,%edx
    9e82:	80 ca 30             	or     $0x30,%dl
    9e85:	42 88 54 0c 40       	mov    %dl,0x40(%rsp,%r9,1)
    9e8a:	49 ff c1             	inc    %r9
    9e8d:	48 83 fe 0a          	cmp    $0xa,%rsi
    9e91:	49 83 da 00          	sbb    $0x0,%r10
    9e95:	48 89 c6             	mov    %rax,%rsi
    9e98:	4d 89 f2             	mov    %r14,%r10
    9e9b:	73 93                	jae    9e30 <fwp_fmt_duration+0x950>
    9e9d:	45 85 c9             	test   %r9d,%r9d
    9ea0:	7e 13                	jle    9eb5 <fwp_fmt_duration+0x9d5>
    9ea2:	44 89 c8             	mov    %r9d,%eax
    9ea5:	48 83 f8 08          	cmp    $0x8,%rax
    9ea9:	73 11                	jae    9ebc <fwp_fmt_duration+0x9dc>
    9eab:	31 c9                	xor    %ecx,%ecx
    9ead:	48 89 c2             	mov    %rax,%rdx
    9eb0:	e9 29 01 00 00       	jmp    9fde <fwp_fmt_duration+0xafe>
    9eb5:	31 c0                	xor    %eax,%eax
    9eb7:	e9 48 01 00 00       	jmp    a004 <fwp_fmt_duration+0xb24>
    9ebc:	83 f8 20             	cmp    $0x20,%eax
    9ebf:	73 07                	jae    9ec8 <fwp_fmt_duration+0x9e8>
    9ec1:	31 c9                	xor    %ecx,%ecx
    9ec3:	e9 b5 00 00 00       	jmp    9f7d <fwp_fmt_duration+0xa9d>
    9ec8:	44 89 ce             	mov    %r9d,%esi
    9ecb:	44 89 ca             	mov    %r9d,%edx
    9ece:	83 e2 1f             	and    $0x1f,%edx
    9ed1:	48 89 c1             	mov    %rax,%rcx
    9ed4:	48 29 d1             	sub    %rdx,%rcx
    9ed7:	4c 8d 04 34          	lea    (%rsp,%rsi,1),%r8
    9edb:	49 83 c0 30          	add    $0x30,%r8
    9edf:	48 29 d6             	sub    %rdx,%rsi
    9ee2:	45 31 d2             	xor    %r10d,%r10d
    9ee5:	66 0f ef c0          	pxor   %xmm0,%xmm0
    9ee9:	f3 41 0f 6f 48 f0    	movdqu -0x10(%r8),%xmm1
    9eef:	f3 41 0f 6f 10       	movdqu (%r8),%xmm2
    9ef4:	66 0f 6f da          	movdqa %xmm2,%xmm3
    9ef8:	66 0f 60 d8          	punpcklbw %xmm0,%xmm3
    9efc:	66 0f 70 db 4e       	pshufd $0x4e,%xmm3,%xmm3
    9f01:	f2 0f 70 db 1b       	pshuflw $0x1b,%xmm3,%xmm3
    9f06:	f3 0f 70 db 1b       	pshufhw $0x1b,%xmm3,%xmm3
    9f0b:	66 0f 68 d0          	punpckhbw %xmm0,%xmm2
    9f0f:	66 0f 70 d2 4e       	pshufd $0x4e,%xmm2,%xmm2
    9f14:	f2 0f 70 d2 1b       	pshuflw $0x1b,%xmm2,%xmm2
    9f19:	f3 0f 70 d2 1b       	pshufhw $0x1b,%xmm2,%xmm2
    9f1e:	66 0f 67 d3          	packuswb %xmm3,%xmm2
    9f22:	66 0f 6f d9          	movdqa %xmm1,%xmm3
    9f26:	66 0f 60 d8          	punpcklbw %xmm0,%xmm3
    9f2a:	66 0f 70 db 4e       	pshufd $0x4e,%xmm3,%xmm3
    9f2f:	f2 0f 70 db 1b       	pshuflw $0x1b,%xmm3,%xmm3
    9f34:	f3 0f 70 db 1b       	pshufhw $0x1b,%xmm3,%xmm3
    9f39:	66 0f 68 c8          	punpckhbw %xmm0,%xmm1
    9f3d:	66 0f 70 c9 4e       	pshufd $0x4e,%xmm1,%xmm1
    9f42:	f2 0f 70 c9 1b       	pshuflw $0x1b,%xmm1,%xmm1
    9f47:	f3 0f 70 c9 1b       	pshufhw $0x1b,%xmm1,%xmm1
    9f4c:	66 0f 67 cb          	packuswb %xmm3,%xmm1
    9f50:	f3 42 0f 7f 54 14 01 	movdqu %xmm2,0x1(%rsp,%r10,1)
    9f57:	f3 42 0f 7f 4c 14 11 	movdqu %xmm1,0x11(%rsp,%r10,1)
    9f5e:	49 83 c2 20          	add    $0x20,%r10
    9f62:	49 83 c0 e0          	add    $0xffffffffffffffe0,%r8
    9f66:	4c 39 d6             	cmp    %r10,%rsi
    9f69:	0f 85 7a ff ff ff    	jne    9ee9 <fwp_fmt_duration+0xa09>
    9f6f:	48 85 d2             	test   %rdx,%rdx
    9f72:	0f 84 8c 00 00 00    	je     a004 <fwp_fmt_duration+0xb24>
    9f78:	83 fa 08             	cmp    $0x8,%edx
    9f7b:	72 61                	jb     9fde <fwp_fmt_duration+0xafe>
    9f7d:	48 89 ce             	mov    %rcx,%rsi
    9f80:	45 89 c8             	mov    %r9d,%r8d
    9f83:	44 89 ca             	mov    %r9d,%edx
    9f86:	83 e2 07             	and    $0x7,%edx
    9f89:	48 89 c1             	mov    %rax,%rcx
    9f8c:	48 29 d1             	sub    %rdx,%rcx
    9f8f:	49 89 f2             	mov    %rsi,%r10
    9f92:	49 f7 da             	neg    %r10
    9f95:	49 01 e2             	add    %rsp,%r10
    9f98:	49 83 c2 40          	add    $0x40,%r10
    9f9c:	4d 01 c2             	add    %r8,%r10
    9f9f:	49 83 c2 f8          	add    $0xfffffffffffffff8,%r10
    9fa3:	49 29 d0             	sub    %rdx,%r8
    9fa6:	66 0f ef c0          	pxor   %xmm0,%xmm0
    9faa:	f3 41 0f 7e 0a       	movq   (%r10),%xmm1
    9faf:	66 0f 60 c8          	punpcklbw %xmm0,%xmm1
    9fb3:	66 0f 70 c9 4e       	pshufd $0x4e,%xmm1,%xmm1
    9fb8:	f2 0f 70 c9 1b       	pshuflw $0x1b,%xmm1,%xmm1
    9fbd:	f3 0f 70 c9 1b       	pshufhw $0x1b,%xmm1,%xmm1
    9fc2:	66 0f 67 c9          	packuswb %xmm1,%xmm1
    9fc6:	66 0f d6 4c 34 01    	movq   %xmm1,0x1(%rsp,%rsi,1)
    9fcc:	48 83 c6 08          	add    $0x8,%rsi
    9fd0:	49 83 c2 f8          	add    $0xfffffffffffffff8,%r10
    9fd4:	49 39 f0             	cmp    %rsi,%r8
    9fd7:	75 d1                	jne    9faa <fwp_fmt_duration+0xaca>
    9fd9:	48 85 d2             	test   %rdx,%rdx
    9fdc:	74 26                	je     a004 <fwp_fmt_duration+0xb24>
    9fde:	48 8d 74 24 40       	lea    0x40(%rsp),%rsi
    9fe3:	48 01 f2             	add    %rsi,%rdx
    9fe6:	48 ff ca             	dec    %rdx
    9fe9:	44 89 ce             	mov    %r9d,%esi
    9fec:	0f 1f 40 00          	nopl   0x0(%rax)
    9ff0:	44 0f b6 02          	movzbl (%rdx),%r8d
    9ff4:	44 88 44 0c 01       	mov    %r8b,0x1(%rsp,%rcx,1)
    9ff9:	48 ff c1             	inc    %rcx
    9ffc:	48 ff ca             	dec    %rdx
    9fff:	48 39 ce             	cmp    %rcx,%rsi
    a002:	75 ec                	jne    9ff0 <fwp_fmt_duration+0xb10>
    a004:	c6 44 04 01 00       	movb   $0x0,0x1(%rsp,%rax,1)
    a009:	e9 28 f9 ff ff       	jmp    9936 <fwp_fmt_duration+0x456>
    a00e:	66 90                	xchg   %ax,%ax

000000000000a010 <fwp_format_g>:
    a010:	55                   	push   %rbp
    a011:	41 57                	push   %r15
    a013:	41 56                	push   %r14
    a015:	41 55                	push   %r13
    a017:	41 54                	push   %r12
    a019:	53                   	push   %rbx
    a01a:	48 81 ec 98 00 00 00 	sub    $0x98,%rsp
    a021:	89 f5                	mov    %esi,%ebp
    a023:	48 89 fb             	mov    %rdi,%rbx
    a026:	ff cd                	dec    %ebp
    a028:	48 8d 15 c5 56 00 00 	lea    0x56c5(%rip),%rdx        # f6f4 <fwp_segv.msg+0x474>
    a02f:	4c 8d 64 24 50       	lea    0x50(%rsp),%r12
    a034:	be 40 00 00 00       	mov    $0x40,%esi
    a039:	4c 89 e7             	mov    %r12,%rdi
    a03c:	89 e9                	mov    %ebp,%ecx
    a03e:	f2 0f 11 44 24 08    	movsd  %xmm0,0x8(%rsp)
    a044:	b0 01                	mov    $0x1,%al
    a046:	e8 b5 80 ff ff       	call   2100 <snprintf@plt>
    a04b:	4c 89 e7             	mov    %r12,%rdi
    a04e:	be 65 00 00 00       	mov    $0x65,%esi
    a053:	e8 98 80 ff ff       	call   20f0 <strchr@plt>
    a058:	49 89 c7             	mov    %rax,%r15
    a05b:	48 8d 78 01          	lea    0x1(%rax),%rdi
    a05f:	45 31 ed             	xor    %r13d,%r13d
    a062:	31 f6                	xor    %esi,%esi
    a064:	ba 0a 00 00 00       	mov    $0xa,%edx
    a069:	e8 52 81 ff ff       	call   21c0 <strtol@plt>
    a06e:	49 89 c6             	mov    %rax,%r14
    a071:	83 c0 ef             	add    $0xffffffef,%eax
    a074:	83 f8 e9             	cmp    $0xffffffe9,%eax
    a077:	77 5f                	ja     a0d8 <fwp_format_g+0xc8>
    a079:	4d 29 e7             	sub    %r12,%r15
    a07c:	4c 8d 6c 24 10       	lea    0x10(%rsp),%r13
    a081:	4c 89 ef             	mov    %r13,%rdi
    a084:	4c 89 e6             	mov    %r12,%rsi
    a087:	4c 89 fa             	mov    %r15,%rdx
    a08a:	e8 41 81 ff ff       	call   21d0 <memcpy@plt>
    a08f:	42 c6 44 3c 10 00    	movb   $0x0,0x10(%rsp,%r15,1)
    a095:	4c 89 ef             	mov    %r13,%rdi
    a098:	be 2e 00 00 00       	mov    $0x2e,%esi
    a09d:	e8 4e 80 ff ff       	call   20f0 <strchr@plt>
    a0a2:	48 85 c0             	test   %rax,%rax
    a0a5:	0f 84 a8 00 00 00    	je     a153 <fwp_format_g+0x143>
    a0ab:	4d 85 ff             	test   %r15,%r15
    a0ae:	0f 84 9f 00 00 00    	je     a153 <fwp_format_g+0x143>
    a0b4:	66 66 66 2e 0f 1f 84 	data16 data16 cs nopw 0x0(%rax,%rax,1)
    a0bb:	00 00 00 00 00 
    a0c0:	42 0f b6 44 3c 0f    	movzbl 0xf(%rsp,%r15,1),%eax
    a0c6:	83 f8 30             	cmp    $0x30,%eax
    a0c9:	75 7d                	jne    a148 <fwp_format_g+0x138>
    a0cb:	42 c6 44 3c 0f 00    	movb   $0x0,0xf(%rsp,%r15,1)
    a0d1:	49 ff cf             	dec    %r15
    a0d4:	75 ea                	jne    a0c0 <fwp_format_g+0xb0>
    a0d6:	eb 7b                	jmp    a153 <fwp_format_g+0x143>
    a0d8:	44 29 f5             	sub    %r14d,%ebp
    a0db:	85 ed                	test   %ebp,%ebp
    a0dd:	44 0f 4f ed          	cmovg  %ebp,%r13d
    a0e1:	48 8d 15 1b 56 00 00 	lea    0x561b(%rip),%rdx        # f703 <fwp_segv.msg+0x483>
    a0e8:	be 90 01 00 00       	mov    $0x190,%esi
    a0ed:	48 89 df             	mov    %rbx,%rdi
    a0f0:	44 89 e9             	mov    %r13d,%ecx
    a0f3:	f2 0f 10 44 24 08    	movsd  0x8(%rsp),%xmm0
    a0f9:	b0 01                	mov    $0x1,%al
    a0fb:	e8 00 80 ff ff       	call   2100 <snprintf@plt>
    a100:	48 89 df             	mov    %rbx,%rdi
    a103:	e8 c8 7f ff ff       	call   20d0 <strlen@plt>
    a108:	49 89 c6             	mov    %rax,%r14
    a10b:	48 89 df             	mov    %rbx,%rdi
    a10e:	be 2e 00 00 00       	mov    $0x2e,%esi
    a113:	e8 d8 7f ff ff       	call   20f0 <strchr@plt>
    a118:	48 85 c0             	test   %rax,%rax
    a11b:	74 69                	je     a186 <fwp_format_g+0x176>
    a11d:	4d 85 f6             	test   %r14,%r14
    a120:	74 64                	je     a186 <fwp_format_g+0x176>
    a122:	66 66 66 66 66 2e 0f 	data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    a129:	1f 84 00 00 00 00 00 
    a130:	42 0f b6 44 33 ff    	movzbl -0x1(%rbx,%r14,1),%eax
    a136:	83 f8 30             	cmp    $0x30,%eax
    a139:	75 5d                	jne    a198 <fwp_format_g+0x188>
    a13b:	42 c6 44 33 ff 00    	movb   $0x0,-0x1(%rbx,%r14,1)
    a141:	49 ff ce             	dec    %r14
    a144:	75 ea                	jne    a130 <fwp_format_g+0x120>
    a146:	eb 3e                	jmp    a186 <fwp_format_g+0x176>
    a148:	83 f8 2e             	cmp    $0x2e,%eax
    a14b:	75 06                	jne    a153 <fwp_format_g+0x143>
    a14d:	42 c6 44 3c 0f 00    	movb   $0x0,0xf(%rsp,%r15,1)
    a153:	44 89 f0             	mov    %r14d,%eax
    a156:	c1 e8 1f             	shr    $0x1f,%eax
    a159:	44 8d 04 45 2b 00 00 	lea    0x2b(,%rax,2),%r8d
    a160:	00 
    a161:	45 89 f1             	mov    %r14d,%r9d
    a164:	41 f7 d9             	neg    %r9d
    a167:	45 0f 48 ce          	cmovs  %r14d,%r9d
    a16b:	48 8d 15 87 55 00 00 	lea    0x5587(%rip),%rdx        # f6f9 <fwp_segv.msg+0x479>
    a172:	48 8d 4c 24 10       	lea    0x10(%rsp),%rcx
    a177:	be 90 01 00 00       	mov    $0x190,%esi
    a17c:	48 89 df             	mov    %rbx,%rdi
    a17f:	31 c0                	xor    %eax,%eax
    a181:	e8 7a 7f ff ff       	call   2100 <snprintf@plt>
    a186:	48 81 c4 98 00 00 00 	add    $0x98,%rsp
    a18d:	5b                   	pop    %rbx
    a18e:	41 5c                	pop    %r12
    a190:	41 5d                	pop    %r13
    a192:	41 5e                	pop    %r14
    a194:	41 5f                	pop    %r15
    a196:	5d                   	pop    %rbp
    a197:	c3                   	ret
    a198:	83 f8 2e             	cmp    $0x2e,%eax
    a19b:	75 e9                	jne    a186 <fwp_format_g+0x176>
    a19d:	42 c6 44 33 ff 00    	movb   $0x0,-0x1(%rbx,%r14,1)
    a1a3:	eb e1                	jmp    a186 <fwp_format_g+0x176>
    a1a5:	66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
    a1ac:	00 00 00 00 

000000000000a1b0 <fwp_show_i64>:
    a1b0:	41 57                	push   %r15
    a1b2:	41 56                	push   %r14
    a1b4:	53                   	push   %rbx
    a1b5:	48 83 ec 20          	sub    $0x20,%rsp
    a1b9:	48 be 00 00 00 00 01 	movabs $0x100000000,%rsi
    a1c0:	00 00 00 
    a1c3:	48 89 f9             	mov    %rdi,%rcx
    a1c6:	48 f7 d9             	neg    %rcx
    a1c9:	48 0f 48 cf          	cmovs  %rdi,%rcx
    a1cd:	48 8d 5c 24 18       	lea    0x18(%rsp),%rbx
    a1d2:	4c 8d 44 24 17       	lea    0x17(%rsp),%r8
    a1d7:	45 31 f6             	xor    %r14d,%r14d
    a1da:	49 b9 cd cc cc cc cc 	movabs $0xcccccccccccccccd,%r9
    a1e1:	cc cc cc 
    a1e4:	66 66 66 2e 0f 1f 84 	data16 data16 cs nopw 0x0(%rax,%rax,1)
    a1eb:	00 00 00 00 00 
    a1f0:	48 89 c8             	mov    %rcx,%rax
    a1f3:	49 f7 e1             	mul    %r9
    a1f6:	48 c1 ea 03          	shr    $0x3,%rdx
    a1fa:	8d 04 12             	lea    (%rdx,%rdx,1),%eax
    a1fd:	8d 04 80             	lea    (%rax,%rax,4),%eax
    a200:	41 89 ca             	mov    %ecx,%r10d
    a203:	41 29 c2             	sub    %eax,%r10d
    a206:	41 80 ca 30          	or     $0x30,%r10b
    a20a:	45 88 10             	mov    %r10b,(%r8)
    a20d:	49 01 f6             	add    %rsi,%r14
    a210:	49 ff c8             	dec    %r8
    a213:	48 83 f9 09          	cmp    $0x9,%rcx
    a217:	48 89 d1             	mov    %rdx,%rcx
    a21a:	77 d4                	ja     a1f0 <fwp_show_i64+0x40>
    a21c:	48 85 ff             	test   %rdi,%rdi
    a21f:	78 06                	js     a227 <fwp_show_i64+0x77>
    a221:	49 c1 fe 20          	sar    $0x20,%r14
    a225:	eb 11                	jmp    a238 <fwp_show_i64+0x88>
    a227:	49 01 f6             	add    %rsi,%r14
    a22a:	49 c1 fe 20          	sar    $0x20,%r14
    a22e:	48 89 e0             	mov    %rsp,%rax
    a231:	4c 29 f0             	sub    %r14,%rax
    a234:	c6 40 18 2d          	movb   $0x2d,0x18(%rax)
    a238:	49 8d 56 09          	lea    0x9(%r14),%rdx
    a23c:	48 81 fa 00 40 00 00 	cmp    $0x4000,%rdx
    a243:	77 61                	ja     a2a6 <fwp_show_i64+0xf6>
    a245:	49 8d 4e 18          	lea    0x18(%r14),%rcx
    a249:	48 c1 e9 04          	shr    $0x4,%rcx
    a24d:	48 8d 05 14 7f 00 00 	lea    0x7f14(%rip),%rax        # 12168 <fwp_gc>
    a254:	0f b6 b4 01 e8 0b 00 	movzbl 0xbe8(%rcx,%rax,1),%esi
    a25b:	00 
    a25c:	8b 8c b0 48 0b 00 00 	mov    0xb48(%rax,%rsi,4),%ecx
    a263:	48 29 0d fe 7e 00 00 	sub    %rcx,0x7efe(%rip)        # 12168 <fwp_gc>
    a26a:	78 3a                	js     a2a6 <fwp_show_i64+0xf6>
    a26c:	48 8d 34 76          	lea    (%rsi,%rsi,2),%rsi
    a270:	48 8d 3c f0          	lea    (%rax,%rsi,8),%rdi
    a274:	48 81 c7 c8 03 00 00 	add    $0x3c8,%rdi
    a27b:	4c 8b 3f             	mov    (%rdi),%r15
    a27e:	4d 85 ff             	test   %r15,%r15
    a281:	74 0b                	je     a28e <fwp_show_i64+0xde>
    a283:	49 8b 07             	mov    (%r15),%rax
    a286:	48 f7 d0             	not    %rax
    a289:	48 89 07             	mov    %rax,(%rdi)
    a28c:	eb 3a                	jmp    a2c8 <fwp_show_i64+0x118>
    a28e:	4c 8b bc f0 d0 03 00 	mov    0x3d0(%rax,%rsi,8),%r15
    a295:	00 
    a296:	48 8b bc f0 d8 03 00 	mov    0x3d8(%rax,%rsi,8),%rdi
    a29d:	00 
    a29e:	4c 29 ff             	sub    %r15,%rdi
    a2a1:	48 39 cf             	cmp    %rcx,%rdi
    a2a4:	73 12                	jae    a2b8 <fwp_show_i64+0x108>
    a2a6:	48 89 d7             	mov    %rdx,%rdi
    a2a9:	be 01 00 00 00       	mov    $0x1,%esi
    a2ae:	e8 4d cc ff ff       	call   6f00 <fwp_gc_alloc_slow>
    a2b3:	49 89 c7             	mov    %rax,%r15
    a2b6:	eb 1a                	jmp    a2d2 <fwp_show_i64+0x122>
    a2b8:	48 8d 04 f0          	lea    (%rax,%rsi,8),%rax
    a2bc:	48 05 d0 03 00 00    	add    $0x3d0,%rax
    a2c2:	4c 01 f9             	add    %r15,%rcx
    a2c5:	48 89 08             	mov    %rcx,(%rax)
    a2c8:	4c 89 ff             	mov    %r15,%rdi
    a2cb:	31 f6                	xor    %esi,%esi
    a2cd:	e8 4e 7e ff ff       	call   2120 <memset@plt>
    a2d2:	4c 29 f3             	sub    %r14,%rbx
    a2d5:	4d 89 37             	mov    %r14,(%r15)
    a2d8:	49 8d 7f 08          	lea    0x8(%r15),%rdi
    a2dc:	48 89 de             	mov    %rbx,%rsi
    a2df:	4c 89 f2             	mov    %r14,%rdx
    a2e2:	e8 e9 7e ff ff       	call   21d0 <memcpy@plt>
    a2e7:	43 c6 44 37 08 00    	movb   $0x0,0x8(%r15,%r14,1)
    a2ed:	4c 89 f8             	mov    %r15,%rax
    a2f0:	48 83 c4 20          	add    $0x20,%rsp
    a2f4:	5b                   	pop    %rbx
    a2f5:	41 5e                	pop    %r14
    a2f7:	41 5f                	pop    %r15
    a2f9:	c3                   	ret
    a2fa:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)

000000000000a300 <fwp_p_array_get_typed>:
    a300:	48 85 ff             	test   %rdi,%rdi
    a303:	78 3e                	js     a343 <fwp_p_array_get_typed+0x43>
    a305:	48 8b 0e             	mov    (%rsi),%rcx
    a308:	48 b8 ff ff ff ff ff 	movabs $0x7fffffffffffffff,%rax
    a30f:	ff ff 7f 
    a312:	48 21 c8             	and    %rcx,%rax
    a315:	48 39 f8             	cmp    %rdi,%rax
    a318:	76 29                	jbe    a343 <fwp_p_array_get_typed+0x43>
    a31a:	b8 08 00 00 00       	mov    $0x8,%eax
    a31f:	48 85 d2             	test   %rdx,%rdx
    a322:	74 14                	je     a338 <fwp_p_array_get_typed+0x38>
    a324:	44 8b 02             	mov    (%rdx),%r8d
    a327:	49 83 f8 0a          	cmp    $0xa,%r8
    a32b:	77 0b                	ja     a338 <fwp_p_array_get_typed+0x38>
    a32d:	48 8d 05 c4 4f 00 00 	lea    0x4fc4(%rip),%rax        # f2f8 <fwp_segv.msg+0x78>
    a334:	4a 8b 04 c0          	mov    (%rax,%r8,8),%rax
    a338:	48 85 c9             	test   %rcx,%rcx
    a33b:	78 09                	js     a346 <fwp_p_array_get_typed+0x46>
    a33d:	48 8d 4e 08          	lea    0x8(%rsi),%rcx
    a341:	eb 07                	jmp    a34a <fwp_p_array_get_typed+0x4a>
    a343:	31 c0                	xor    %eax,%eax
    a345:	c3                   	ret
    a346:	48 8b 4e 10          	mov    0x10(%rsi),%rcx
    a34a:	41 57                	push   %r15
    a34c:	41 56                	push   %r14
    a34e:	53                   	push   %rbx
    a34f:	48 83 ec 10          	sub    $0x10,%rsp
    a353:	48 0f af f8          	imul   %rax,%rdi
    a357:	48 83 f8 01          	cmp    $0x1,%rax
    a35b:	49 89 f6             	mov    %rsi,%r14
    a35e:	74 1f                	je     a37f <fwp_p_array_get_typed+0x7f>
    a360:	48 83 f8 02          	cmp    $0x2,%rax
    a364:	74 0c                	je     a372 <fwp_p_array_get_typed+0x72>
    a366:	48 83 f8 08          	cmp    $0x8,%rax
    a36a:	75 20                	jne    a38c <fwp_p_array_get_typed+0x8c>
    a36c:	48 8b 04 39          	mov    (%rcx,%rdi,1),%rax
    a370:	eb 27                	jmp    a399 <fwp_p_array_get_typed+0x99>
    a372:	83 3a 01             	cmpl   $0x1,(%rdx)
    a375:	0f b7 0c 39          	movzwl (%rcx,%rdi,1),%ecx
    a379:	48 0f bf c1          	movswq %cx,%rax
    a37d:	eb 16                	jmp    a395 <fwp_p_array_get_typed+0x95>
    a37f:	83 3a 00             	cmpl   $0x0,(%rdx)
    a382:	0f b6 0c 39          	movzbl (%rcx,%rdi,1),%ecx
    a386:	48 0f be c1          	movsbq %cl,%rax
    a38a:	eb 09                	jmp    a395 <fwp_p_array_get_typed+0x95>
    a38c:	83 3a 02             	cmpl   $0x2,(%rdx)
    a38f:	8b 0c 39             	mov    (%rcx,%rdi,1),%ecx
    a392:	48 63 c1             	movslq %ecx,%rax
    a395:	48 0f 45 c1          	cmovne %rcx,%rax
    a399:	48 89 44 24 08       	mov    %rax,0x8(%rsp)
    a39e:	48 8d 54 24 08       	lea    0x8(%rsp),%rdx
    a3a3:	bf 01 00 00 00       	mov    $0x1,%edi
    a3a8:	be 01 00 00 00       	mov    $0x1,%esi
    a3ad:	e8 9e 00 00 00       	call   a450 <fwp_data>
    a3b2:	48 89 c2             	mov    %rax,%rdx
    a3b5:	48 2b 15 dc 8d 00 00 	sub    0x8ddc(%rip),%rdx        # 13198 <fwp_gc+0x1030>
    a3bc:	48 8b 0d fd 8d 00 00 	mov    0x8dfd(%rip),%rcx        # 131c0 <fwp_gc+0x1058>
    a3c3:	48 c1 e1 10          	shl    $0x10,%rcx
    a3c7:	48 39 ca             	cmp    %rcx,%rdx
    a3ca:	4c 89 f1             	mov    %r14,%rcx
    a3cd:	73 77                	jae    a446 <fwp_p_array_get_typed+0x146>
    a3cf:	48 8b 35 0a 8e 00 00 	mov    0x8e0a(%rip),%rsi        # 131e0 <fwp_gc+0x1078>
    a3d6:	48 89 d7             	mov    %rdx,%rdi
    a3d9:	48 c1 ef 10          	shr    $0x10,%rdi
    a3dd:	48 69 ff 28 12 00 00 	imul   $0x1228,%rdi,%rdi
    a3e4:	44 0f b6 04 3e       	movzbl (%rsi,%rdi,1),%r8d
    a3e9:	48 81 e2 ff ff 00 00 	and    $0xffff,%rdx
    a3f0:	75 1b                	jne    a40d <fwp_p_array_get_typed+0x10d>
    a3f2:	41 80 f8 02          	cmp    $0x2,%r8b
    a3f6:	75 15                	jne    a40d <fwp_p_array_get_typed+0x10d>
    a3f8:	48 8d 1c 3e          	lea    (%rsi,%rdi,1),%rbx
    a3fc:	48 81 c3 28 02 00 00 	add    $0x228,%rbx
    a403:	80 3b ff             	cmpb   $0xff,(%rbx)
    a406:	74 2b                	je     a433 <fwp_p_array_get_typed+0x133>
    a408:	c6 03 01             	movb   $0x1,(%rbx)
    a40b:	eb 39                	jmp    a446 <fwp_p_array_get_typed+0x146>
    a40d:	41 80 f8 01          	cmp    $0x1,%r8b
    a411:	75 33                	jne    a446 <fwp_p_array_get_typed+0x146>
    a413:	4c 8d 04 3e          	lea    (%rsi,%rdi,1),%r8
    a417:	8b 74 3e 20          	mov    0x20(%rsi,%rdi,1),%esi
    a41b:	48 0f af d6          	imul   %rsi,%rdx
    a41f:	48 c1 ea 20          	shr    $0x20,%rdx
    a423:	4a 8d 1c 02          	lea    (%rdx,%r8,1),%rbx
    a427:	48 81 c3 28 02 00 00 	add    $0x228,%rbx
    a42e:	80 3b ff             	cmpb   $0xff,(%rbx)
    a431:	75 d5                	jne    a408 <fwp_p_array_get_typed+0x108>
    a433:	48 89 df             	mov    %rbx,%rdi
    a436:	49 89 c7             	mov    %rax,%r15
    a439:	e8 52 c6 ff ff       	call   6a90 <fwp_rc_forget_slot>
    a43e:	4c 89 f8             	mov    %r15,%rax
    a441:	4c 89 f1             	mov    %r14,%rcx
    a444:	eb c2                	jmp    a408 <fwp_p_array_get_typed+0x108>
    a446:	48 83 c4 10          	add    $0x10,%rsp
    a44a:	5b                   	pop    %rbx
    a44b:	41 5e                	pop    %r14
    a44d:	41 5f                	pop    %r15
    a44f:	c3                   	ret

000000000000a450 <fwp_data>:
    a450:	55                   	push   %rbp
    a451:	41 57                	push   %r15
    a453:	41 56                	push   %r14
    a455:	41 55                	push   %r13
    a457:	41 54                	push   %r12
    a459:	53                   	push   %rbx
    a45a:	50                   	push   %rax
    a45b:	48 89 d3             	mov    %rdx,%rbx
    a45e:	89 f5                	mov    %esi,%ebp
    a460:	41 89 ff             	mov    %edi,%r15d
    a463:	41 89 f4             	mov    %esi,%r12d
    a466:	4e 8d 2c e5 00 00 00 	lea    0x0(,%r12,8),%r13
    a46d:	00 
    a46e:	4a 8d 3c e5 08 00 00 	lea    0x8(,%r12,8),%rdi
    a475:	00 
    a476:	81 fe ff 07 00 00    	cmp    $0x7ff,%esi
    a47c:	0f 87 e6 00 00 00    	ja     a568 <fwp_data+0x118>
    a482:	49 8d 75 17          	lea    0x17(%r13),%rsi
    a486:	48 c1 ee 04          	shr    $0x4,%rsi
    a48a:	48 8d 05 d7 7c 00 00 	lea    0x7cd7(%rip),%rax        # 12168 <fwp_gc>
    a491:	0f b6 8c 06 e8 0b 00 	movzbl 0xbe8(%rsi,%rax,1),%ecx
    a498:	00 
    a499:	8b 94 88 48 0b 00 00 	mov    0xb48(%rax,%rcx,4),%edx
    a4a0:	4c 8b 05 c1 7c 00 00 	mov    0x7cc1(%rip),%r8        # 12168 <fwp_gc>
    a4a7:	4d 89 c1             	mov    %r8,%r9
    a4aa:	49 29 d1             	sub    %rdx,%r9
    a4ad:	4c 89 0d b4 7c 00 00 	mov    %r9,0x7cb4(%rip)        # 12168 <fwp_gc>
    a4b4:	0f 88 ae 00 00 00    	js     a568 <fwp_data+0x118>
    a4ba:	4c 8d 0c 49          	lea    (%rcx,%rcx,2),%r9
    a4be:	4e 8d 14 c8          	lea    (%rax,%r9,8),%r10
    a4c2:	49 83 c2 08          	add    $0x8,%r10
    a4c6:	4d 8b 32             	mov    (%r10),%r14
    a4c9:	4d 85 f6             	test   %r14,%r14
    a4cc:	74 29                	je     a4f7 <fwp_data+0xa7>
    a4ce:	49 8b 06             	mov    (%r14),%rax
    a4d1:	48 f7 d0             	not    %rax
    a4d4:	49 89 02             	mov    %rax,(%r10)
    a4d7:	48 39 d7             	cmp    %rdx,%rdi
    a4da:	0f 83 ad 00 00 00    	jae    a58d <fwp_data+0x13d>
    a4e0:	4c 01 f7             	add    %r14,%rdi
    a4e3:	4c 29 ea             	sub    %r13,%rdx
    a4e6:	48 83 c2 f7          	add    $0xfffffffffffffff7,%rdx
    a4ea:	48 83 e2 f8          	and    $0xfffffffffffffff8,%rdx
    a4ee:	48 83 c2 08          	add    $0x8,%rdx
    a4f2:	e9 8f 00 00 00       	jmp    a586 <fwp_data+0x136>
    a4f7:	4e 8b 74 c8 10       	mov    0x10(%rax,%r9,8),%r14
    a4fc:	4e 8b 54 c8 18       	mov    0x18(%rax,%r9,8),%r10
    a501:	4d 29 f2             	sub    %r14,%r10
    a504:	49 39 d2             	cmp    %rdx,%r10
    a507:	72 2f                	jb     a538 <fwp_data+0xe8>
    a509:	4a 8d 0c c8          	lea    (%rax,%r9,8),%rcx
    a50d:	48 83 c1 10          	add    $0x10,%rcx
    a511:	4d 8d 0c 16          	lea    (%r14,%rdx,1),%r9
    a515:	4c 89 09             	mov    %r9,(%rcx)
    a518:	4d 85 f6             	test   %r14,%r14
    a51b:	75 ba                	jne    a4d7 <fwp_data+0x87>
    a51d:	0f b6 8c 06 e8 0b 00 	movzbl 0xbe8(%rsi,%rax,1),%ecx
    a524:	00 
    a525:	8b 94 88 48 0b 00 00 	mov    0xb48(%rax,%rcx,4),%edx
    a52c:	49 29 d0             	sub    %rdx,%r8
    a52f:	4c 89 05 32 7c 00 00 	mov    %r8,0x7c32(%rip)        # 12168 <fwp_gc>
    a536:	78 30                	js     a568 <fwp_data+0x118>
    a538:	48 8d 0c 49          	lea    (%rcx,%rcx,2),%rcx
    a53c:	4c 8b 74 c8 08       	mov    0x8(%rax,%rcx,8),%r14
    a541:	4d 85 f6             	test   %r14,%r14
    a544:	74 10                	je     a556 <fwp_data+0x106>
    a546:	48 8d 04 c8          	lea    (%rax,%rcx,8),%rax
    a54a:	48 83 c0 08          	add    $0x8,%rax
    a54e:	49 8b 0e             	mov    (%r14),%rcx
    a551:	48 f7 d1             	not    %rcx
    a554:	eb 2a                	jmp    a580 <fwp_data+0x130>
    a556:	4c 8b 74 c8 10       	mov    0x10(%rax,%rcx,8),%r14
    a55b:	48 8b 74 c8 18       	mov    0x18(%rax,%rcx,8),%rsi
    a560:	4c 29 f6             	sub    %r14,%rsi
    a563:	48 39 d6             	cmp    %rdx,%rsi
    a566:	73 0c                	jae    a574 <fwp_data+0x124>
    a568:	31 f6                	xor    %esi,%esi
    a56a:	e8 91 c9 ff ff       	call   6f00 <fwp_gc_alloc_slow>
    a56f:	49 89 c6             	mov    %rax,%r14
    a572:	eb 19                	jmp    a58d <fwp_data+0x13d>
    a574:	48 8d 04 c8          	lea    (%rax,%rcx,8),%rax
    a578:	48 83 c0 10          	add    $0x10,%rax
    a57c:	49 8d 0c 16          	lea    (%r14,%rdx,1),%rcx
    a580:	48 89 08             	mov    %rcx,(%rax)
    a583:	4c 89 f7             	mov    %r14,%rdi
    a586:	31 f6                	xor    %esi,%esi
    a588:	e8 93 7b ff ff       	call   2120 <memset@plt>
    a58d:	45 89 3e             	mov    %r15d,(%r14)
    a590:	41 89 6e 04          	mov    %ebp,0x4(%r14)
    a594:	85 ed                	test   %ebp,%ebp
    a596:	0f 84 bb 00 00 00    	je     a657 <fwp_data+0x207>
    a59c:	83 fd 08             	cmp    $0x8,%ebp
    a59f:	72 10                	jb     a5b1 <fwp_data+0x161>
    a5a1:	4c 89 f0             	mov    %r14,%rax
    a5a4:	48 29 d8             	sub    %rbx,%rax
    a5a7:	48 83 c0 08          	add    $0x8,%rax
    a5ab:	48 83 f8 20          	cmp    $0x20,%rax
    a5af:	73 71                	jae    a622 <fwp_data+0x1d2>
    a5b1:	31 c0                	xor    %eax,%eax
    a5b3:	4c 89 e2             	mov    %r12,%rdx
    a5b6:	48 89 c1             	mov    %rax,%rcx
    a5b9:	48 83 e2 03          	and    $0x3,%rdx
    a5bd:	74 22                	je     a5e1 <fwp_data+0x191>
    a5bf:	48 89 c1             	mov    %rax,%rcx
    a5c2:	66 66 66 66 66 2e 0f 	data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    a5c9:	1f 84 00 00 00 00 00 
    a5d0:	48 8b 34 cb          	mov    (%rbx,%rcx,8),%rsi
    a5d4:	49 89 74 ce 08       	mov    %rsi,0x8(%r14,%rcx,8)
    a5d9:	48 ff c1             	inc    %rcx
    a5dc:	48 ff ca             	dec    %rdx
    a5df:	75 ef                	jne    a5d0 <fwp_data+0x180>
    a5e1:	4c 29 e0             	sub    %r12,%rax
    a5e4:	48 83 f8 fc          	cmp    $0xfffffffffffffffc,%rax
    a5e8:	77 6d                	ja     a657 <fwp_data+0x207>
    a5ea:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)
    a5f0:	48 8b 04 cb          	mov    (%rbx,%rcx,8),%rax
    a5f4:	49 89 44 ce 08       	mov    %rax,0x8(%r14,%rcx,8)
    a5f9:	48 8b 44 cb 08       	mov    0x8(%rbx,%rcx,8),%rax
    a5fe:	49 89 44 ce 10       	mov    %rax,0x10(%r14,%rcx,8)
    a603:	48 8b 44 cb 10       	mov    0x10(%rbx,%rcx,8),%rax
    a608:	49 89 44 ce 18       	mov    %rax,0x18(%r14,%rcx,8)
    a60d:	48 8b 44 cb 18       	mov    0x18(%rbx,%rcx,8),%rax
    a612:	49 89 44 ce 20       	mov    %rax,0x20(%r14,%rcx,8)
    a617:	48 83 c1 04          	add    $0x4,%rcx
    a61b:	49 39 cc             	cmp    %rcx,%r12
    a61e:	75 d0                	jne    a5f0 <fwp_data+0x1a0>
    a620:	eb 35                	jmp    a657 <fwp_data+0x207>
    a622:	44 89 e0             	mov    %r12d,%eax
    a625:	83 e0 fc             	and    $0xfffffffc,%eax
    a628:	49 83 e5 e0          	and    $0xffffffffffffffe0,%r13
    a62c:	31 c9                	xor    %ecx,%ecx
    a62e:	66 90                	xchg   %ax,%ax
    a630:	0f 10 04 0b          	movups (%rbx,%rcx,1),%xmm0
    a634:	0f 10 4c 0b 10       	movups 0x10(%rbx,%rcx,1),%xmm1
    a639:	41 0f 11 44 0e 08    	movups %xmm0,0x8(%r14,%rcx,1)
    a63f:	41 0f 11 4c 0e 18    	movups %xmm1,0x18(%r14,%rcx,1)
    a645:	48 83 c1 20          	add    $0x20,%rcx
    a649:	49 39 cd             	cmp    %rcx,%r13
    a64c:	75 e2                	jne    a630 <fwp_data+0x1e0>
    a64e:	4c 39 e0             	cmp    %r12,%rax
    a651:	0f 85 5c ff ff ff    	jne    a5b3 <fwp_data+0x163>
    a657:	4c 89 f0             	mov    %r14,%rax
    a65a:	48 83 c4 08          	add    $0x8,%rsp
    a65e:	5b                   	pop    %rbx
    a65f:	41 5c                	pop    %r12
    a661:	41 5d                	pop    %r13
    a663:	41 5e                	pop    %r14
    a665:	41 5f                	pop    %r15
    a667:	5d                   	pop    %rbp
    a668:	c3                   	ret
    a669:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)

000000000000a670 <f49>:
    a670:	41 57                	push   %r15
    a672:	41 56                	push   %r14
    a674:	53                   	push   %rbx
    a675:	48 83 ec 30          	sub    $0x30,%rsp
    a679:	48 89 fb             	mov    %rdi,%rbx
    a67c:	48 8b 47 10          	mov    0x10(%rdi),%rax
    a680:	48 2b 05 11 8b 00 00 	sub    0x8b11(%rip),%rax        # 13198 <fwp_gc+0x1030>
    a687:	48 8b 0d 32 8b 00 00 	mov    0x8b32(%rip),%rcx        # 131c0 <fwp_gc+0x1058>
    a68e:	48 c1 e1 10          	shl    $0x10,%rcx
    a692:	48 39 c8             	cmp    %rcx,%rax
    a695:	73 68                	jae    a6ff <f49+0x8f>
    a697:	48 8b 0d 42 8b 00 00 	mov    0x8b42(%rip),%rcx        # 131e0 <fwp_gc+0x1078>
    a69e:	48 89 c2             	mov    %rax,%rdx
    a6a1:	48 c1 ea 10          	shr    $0x10,%rdx
    a6a5:	48 69 d2 28 12 00 00 	imul   $0x1228,%rdx,%rdx
    a6ac:	0f b6 34 11          	movzbl (%rcx,%rdx,1),%esi
    a6b0:	48 25 ff ff 00 00    	and    $0xffff,%rax
    a6b6:	75 13                	jne    a6cb <f49+0x5b>
    a6b8:	40 80 fe 02          	cmp    $0x2,%sil
    a6bc:	75 0d                	jne    a6cb <f49+0x5b>
    a6be:	48 8d 3c 11          	lea    (%rcx,%rdx,1),%rdi
    a6c2:	48 81 c7 28 02 00 00 	add    $0x228,%rdi
    a6c9:	eb 21                	jmp    a6ec <f49+0x7c>
    a6cb:	40 80 fe 01          	cmp    $0x1,%sil
    a6cf:	75 2e                	jne    a6ff <f49+0x8f>
    a6d1:	48 8d 34 11          	lea    (%rcx,%rdx,1),%rsi
    a6d5:	8b 4c 11 20          	mov    0x20(%rcx,%rdx,1),%ecx
    a6d9:	48 0f af c1          	imul   %rcx,%rax
    a6dd:	48 c1 e8 20          	shr    $0x20,%rax
    a6e1:	48 8d 3c 30          	lea    (%rax,%rsi,1),%rdi
    a6e5:	48 81 c7 28 02 00 00 	add    $0x228,%rdi
    a6ec:	0f b6 07             	movzbl (%rdi),%eax
    a6ef:	84 c0                	test   %al,%al
    a6f1:	74 0c                	je     a6ff <f49+0x8f>
    a6f3:	3c fe                	cmp    $0xfe,%al
    a6f5:	0f 83 cc 02 00 00    	jae    a9c7 <f49+0x357>
    a6fb:	fe c0                	inc    %al
    a6fd:	88 07                	mov    %al,(%rdi)
    a6ff:	4c 8b 7b 08          	mov    0x8(%rbx),%r15
    a703:	48 8b 7b 10          	mov    0x10(%rbx),%rdi
    a707:	f2 0f 10 43 18       	movsd  0x18(%rbx),%xmm0
    a70c:	f2 0f 11 04 24       	movsd  %xmm0,(%rsp)
    a711:	4d 85 ff             	test   %r15,%r15
    a714:	78 20                	js     a736 <f49+0xc6>
    a716:	48 8b 07             	mov    (%rdi),%rax
    a719:	48 b9 ff ff ff ff ff 	movabs $0x7fffffffffffffff,%rcx
    a720:	ff ff 7f 
    a723:	48 21 c1             	and    %rax,%rcx
    a726:	4c 39 f9             	cmp    %r15,%rcx
    a729:	76 0b                	jbe    a736 <f49+0xc6>
    a72b:	48 85 c0             	test   %rax,%rax
    a72e:	78 7c                	js     a7ac <f49+0x13c>
    a730:	48 8d 47 08          	lea    0x8(%rdi),%rax
    a734:	eb 7a                	jmp    a7b0 <f49+0x140>
    a736:	e8 65 03 00 00       	call   aaa0 <fwp_drop1>
    a73b:	f2 0f 10 04 24       	movsd  (%rsp),%xmm0
    a740:	f2 0f 11 44 24 18    	movsd  %xmm0,0x18(%rsp)
    a746:	48 8d 54 24 18       	lea    0x18(%rsp),%rdx
    a74b:	bf 01 00 00 00       	mov    $0x1,%edi
    a750:	be 01 00 00 00       	mov    $0x1,%esi
    a755:	e8 f6 fc ff ff       	call   a450 <fwp_data>
    a75a:	49 89 c6             	mov    %rax,%r14
    a75d:	48 2b 05 34 8a 00 00 	sub    0x8a34(%rip),%rax        # 13198 <fwp_gc+0x1030>
    a764:	48 8b 0d 55 8a 00 00 	mov    0x8a55(%rip),%rcx        # 131c0 <fwp_gc+0x1058>
    a76b:	48 c1 e1 10          	shl    $0x10,%rcx
    a76f:	48 39 c8             	cmp    %rcx,%rax
    a772:	0f 83 3a 02 00 00    	jae    a9b2 <f49+0x342>
    a778:	48 8b 0d 61 8a 00 00 	mov    0x8a61(%rip),%rcx        # 131e0 <fwp_gc+0x1078>
    a77f:	48 89 c2             	mov    %rax,%rdx
    a782:	48 c1 ea 10          	shr    $0x10,%rdx
    a786:	48 69 d2 28 12 00 00 	imul   $0x1228,%rdx,%rdx
    a78d:	0f b6 34 11          	movzbl (%rcx,%rdx,1),%esi
    a791:	48 25 ff ff 00 00    	and    $0xffff,%rax
    a797:	0f 85 e4 01 00 00    	jne    a981 <f49+0x311>
    a79d:	40 80 fe 02          	cmp    $0x2,%sil
    a7a1:	0f 84 c3 01 00 00    	je     a96a <f49+0x2fa>
    a7a7:	e9 d5 01 00 00       	jmp    a981 <f49+0x311>
    a7ac:	48 8b 47 10          	mov    0x10(%rdi),%rax
    a7b0:	f2 42 0f 10 04 f8    	movsd  (%rax,%r15,8),%xmm0
    a7b6:	f2 0f 59 05 52 48 00 	mulsd  0x4852(%rip),%xmm0        # f010 <_IO_stdin_used+0x10>
    a7bd:	00 
    a7be:	f2 0f 58 05 52 48 00 	addsd  0x4852(%rip),%xmm0        # f018 <_IO_stdin_used+0x18>
    a7c5:	00 
    a7c6:	f2 0f 11 44 24 08    	movsd  %xmm0,0x8(%rsp)
    a7cc:	48 89 f8             	mov    %rdi,%rax
    a7cf:	48 2b 05 c2 89 00 00 	sub    0x89c2(%rip),%rax        # 13198 <fwp_gc+0x1030>
    a7d6:	49 ff c7             	inc    %r15
    a7d9:	48 8b 0d e0 89 00 00 	mov    0x89e0(%rip),%rcx        # 131c0 <fwp_gc+0x1058>
    a7e0:	48 c1 e1 10          	shl    $0x10,%rcx
    a7e4:	48 39 c8             	cmp    %rcx,%rax
    a7e7:	73 66                	jae    a84f <f49+0x1df>
    a7e9:	48 8b 0d f0 89 00 00 	mov    0x89f0(%rip),%rcx        # 131e0 <fwp_gc+0x1078>
    a7f0:	48 89 c2             	mov    %rax,%rdx
    a7f3:	48 c1 ea 10          	shr    $0x10,%rdx
    a7f7:	48 69 d2 28 12 00 00 	imul   $0x1228,%rdx,%rdx
    a7fe:	0f b6 34 11          	movzbl (%rcx,%rdx,1),%esi
    a802:	48 25 ff ff 00 00    	and    $0xffff,%rax
    a808:	75 12                	jne    a81c <f49+0x1ac>
    a80a:	40 80 fe 02          	cmp    $0x2,%sil
    a80e:	75 0c                	jne    a81c <f49+0x1ac>
    a810:	48 8d 04 11          	lea    (%rcx,%rdx,1),%rax
    a814:	48 05 28 02 00 00    	add    $0x228,%rax
    a81a:	eb 1f                	jmp    a83b <f49+0x1cb>
    a81c:	40 80 fe 01          	cmp    $0x1,%sil
    a820:	75 2d                	jne    a84f <f49+0x1df>
    a822:	48 8d 34 11          	lea    (%rcx,%rdx,1),%rsi
    a826:	8b 4c 11 20          	mov    0x20(%rcx,%rdx,1),%ecx
    a82a:	48 0f af c1          	imul   %rcx,%rax
    a82e:	48 c1 e8 20          	shr    $0x20,%rax
    a832:	48 01 f0             	add    %rsi,%rax
    a835:	48 05 28 02 00 00    	add    $0x228,%rax
    a83b:	0f b6 08             	movzbl (%rax),%ecx
    a83e:	84 c9                	test   %cl,%cl
    a840:	74 0d                	je     a84f <f49+0x1df>
    a842:	80 f9 fe             	cmp    $0xfe,%cl
    a845:	0f 83 86 01 00 00    	jae    a9d1 <f49+0x361>
    a84b:	fe c1                	inc    %cl
    a84d:	88 08                	mov    %cl,(%rax)
    a84f:	49 89 fe             	mov    %rdi,%r14
    a852:	e8 49 02 00 00       	call   aaa0 <fwp_drop1>
    a857:	f2 0f 10 04 24       	movsd  (%rsp),%xmm0
    a85c:	f2 0f 58 44 24 08    	addsd  0x8(%rsp),%xmm0
    a862:	4c 89 7c 24 18       	mov    %r15,0x18(%rsp)
    a867:	4c 89 74 24 20       	mov    %r14,0x20(%rsp)
    a86c:	f2 0f 11 44 24 28    	movsd  %xmm0,0x28(%rsp)
    a872:	48 8d 54 24 18       	lea    0x18(%rsp),%rdx
    a877:	31 ff                	xor    %edi,%edi
    a879:	be 03 00 00 00       	mov    $0x3,%esi
    a87e:	e8 cd fb ff ff       	call   a450 <fwp_data>
    a883:	48 89 c1             	mov    %rax,%rcx
    a886:	48 2b 0d 0b 89 00 00 	sub    0x890b(%rip),%rcx        # 13198 <fwp_gc+0x1030>
    a88d:	48 8b 15 2c 89 00 00 	mov    0x892c(%rip),%rdx        # 131c0 <fwp_gc+0x1058>
    a894:	48 c1 e2 10          	shl    $0x10,%rdx
    a898:	48 39 d1             	cmp    %rdx,%rcx
    a89b:	73 76                	jae    a913 <f49+0x2a3>
    a89d:	48 8b 15 3c 89 00 00 	mov    0x893c(%rip),%rdx        # 131e0 <fwp_gc+0x1078>
    a8a4:	48 89 ce             	mov    %rcx,%rsi
    a8a7:	48 c1 ee 10          	shr    $0x10,%rsi
    a8ab:	48 69 f6 28 12 00 00 	imul   $0x1228,%rsi,%rsi
    a8b2:	0f b6 3c 32          	movzbl (%rdx,%rsi,1),%edi
    a8b6:	48 81 e1 ff ff 00 00 	and    $0xffff,%rcx
    a8bd:	75 1d                	jne    a8dc <f49+0x26c>
    a8bf:	40 80 ff 02          	cmp    $0x2,%dil
    a8c3:	75 17                	jne    a8dc <f49+0x26c>
    a8c5:	4c 8d 34 32          	lea    (%rdx,%rsi,1),%r14
    a8c9:	49 81 c6 28 02 00 00 	add    $0x228,%r14
    a8d0:	41 80 3e ff          	cmpb   $0xff,(%r14)
    a8d4:	74 2d                	je     a903 <f49+0x293>
    a8d6:	41 c6 06 01          	movb   $0x1,(%r14)
    a8da:	eb 37                	jmp    a913 <f49+0x2a3>
    a8dc:	40 80 ff 01          	cmp    $0x1,%dil
    a8e0:	75 31                	jne    a913 <f49+0x2a3>
    a8e2:	48 8d 3c 32          	lea    (%rdx,%rsi,1),%rdi
    a8e6:	8b 54 32 20          	mov    0x20(%rdx,%rsi,1),%edx
    a8ea:	48 0f af ca          	imul   %rdx,%rcx
    a8ee:	48 c1 e9 20          	shr    $0x20,%rcx
    a8f2:	4c 8d 34 39          	lea    (%rcx,%rdi,1),%r14
    a8f6:	49 81 c6 28 02 00 00 	add    $0x228,%r14
    a8fd:	41 80 3e ff          	cmpb   $0xff,(%r14)
    a901:	75 d3                	jne    a8d6 <f49+0x266>
    a903:	4c 89 f7             	mov    %r14,%rdi
    a906:	49 89 c7             	mov    %rax,%r15
    a909:	e8 82 c1 ff ff       	call   6a90 <fwp_rc_forget_slot>
    a90e:	4c 89 f8             	mov    %r15,%rax
    a911:	eb c3                	jmp    a8d6 <f49+0x266>
    a913:	48 89 44 24 10       	mov    %rax,0x10(%rsp)
    a918:	48 8d 54 24 10       	lea    0x10(%rsp),%rdx
    a91d:	31 ff                	xor    %edi,%edi
    a91f:	be 01 00 00 00       	mov    $0x1,%esi
    a924:	e8 27 fb ff ff       	call   a450 <fwp_data>
    a929:	49 89 c6             	mov    %rax,%r14
    a92c:	48 2b 05 65 88 00 00 	sub    0x8865(%rip),%rax        # 13198 <fwp_gc+0x1030>
    a933:	48 8b 0d 86 88 00 00 	mov    0x8886(%rip),%rcx        # 131c0 <fwp_gc+0x1058>
    a93a:	48 c1 e1 10          	shl    $0x10,%rcx
    a93e:	48 39 c8             	cmp    %rcx,%rax
    a941:	73 6f                	jae    a9b2 <f49+0x342>
    a943:	48 8b 0d 96 88 00 00 	mov    0x8896(%rip),%rcx        # 131e0 <fwp_gc+0x1078>
    a94a:	48 89 c2             	mov    %rax,%rdx
    a94d:	48 c1 ea 10          	shr    $0x10,%rdx
    a951:	48 69 d2 28 12 00 00 	imul   $0x1228,%rdx,%rdx
    a958:	0f b6 34 11          	movzbl (%rcx,%rdx,1),%esi
    a95c:	48 25 ff ff 00 00    	and    $0xffff,%rax
    a962:	75 1d                	jne    a981 <f49+0x311>
    a964:	40 80 fe 02          	cmp    $0x2,%sil
    a968:	75 17                	jne    a981 <f49+0x311>
    a96a:	4c 8d 3c 11          	lea    (%rcx,%rdx,1),%r15
    a96e:	49 81 c7 28 02 00 00 	add    $0x228,%r15
    a975:	41 80 3f ff          	cmpb   $0xff,(%r15)
    a979:	74 2d                	je     a9a8 <f49+0x338>
    a97b:	41 c6 07 01          	movb   $0x1,(%r15)
    a97f:	eb 31                	jmp    a9b2 <f49+0x342>
    a981:	40 80 fe 01          	cmp    $0x1,%sil
    a985:	75 2b                	jne    a9b2 <f49+0x342>
    a987:	48 8d 34 11          	lea    (%rcx,%rdx,1),%rsi
    a98b:	8b 4c 11 20          	mov    0x20(%rcx,%rdx,1),%ecx
    a98f:	48 0f af c1          	imul   %rcx,%rax
    a993:	48 c1 e8 20          	shr    $0x20,%rax
    a997:	4c 8d 3c 30          	lea    (%rax,%rsi,1),%r15
    a99b:	49 81 c7 28 02 00 00 	add    $0x228,%r15
    a9a2:	41 80 3f ff          	cmpb   $0xff,(%r15)
    a9a6:	75 d3                	jne    a97b <f49+0x30b>
    a9a8:	4c 89 ff             	mov    %r15,%rdi
    a9ab:	e8 e0 c0 ff ff       	call   6a90 <fwp_rc_forget_slot>
    a9b0:	eb c9                	jmp    a97b <f49+0x30b>
    a9b2:	48 89 df             	mov    %rbx,%rdi
    a9b5:	e8 36 00 00 00       	call   a9f0 <fwp_drop6>
    a9ba:	4c 89 f0             	mov    %r14,%rax
    a9bd:	48 83 c4 30          	add    $0x30,%rsp
    a9c1:	5b                   	pop    %rbx
    a9c2:	41 5e                	pop    %r14
    a9c4:	41 5f                	pop    %r15
    a9c6:	c3                   	ret
    a9c7:	e8 54 d2 ff ff       	call   7c20 <fwp_rc_wide_dup>
    a9cc:	e9 2e fd ff ff       	jmp    a6ff <f49+0x8f>
    a9d1:	49 89 fe             	mov    %rdi,%r14
    a9d4:	48 89 c7             	mov    %rax,%rdi
    a9d7:	e8 44 d2 ff ff       	call   7c20 <fwp_rc_wide_dup>
    a9dc:	4c 89 f7             	mov    %r14,%rdi
    a9df:	e9 6b fe ff ff       	jmp    a84f <f49+0x1df>
    a9e4:	66 66 66 2e 0f 1f 84 	data16 data16 cs nopw 0x0(%rax,%rax,1)
    a9eb:	00 00 00 00 00 

000000000000a9f0 <fwp_drop6>:
    a9f0:	48 89 f8             	mov    %rdi,%rax
    a9f3:	48 2b 05 9e 87 00 00 	sub    0x879e(%rip),%rax        # 13198 <fwp_gc+0x1030>
    a9fa:	48 8b 0d bf 87 00 00 	mov    0x87bf(%rip),%rcx        # 131c0 <fwp_gc+0x1058>
    aa01:	48 c1 e1 10          	shl    $0x10,%rcx
    aa05:	48 39 c8             	cmp    %rcx,%rax
    aa08:	0f 83 83 00 00 00    	jae    aa91 <fwp_drop6+0xa1>
    aa0e:	48 8b 0d cb 87 00 00 	mov    0x87cb(%rip),%rcx        # 131e0 <fwp_gc+0x1078>
    aa15:	48 89 c2             	mov    %rax,%rdx
    aa18:	48 c1 ea 10          	shr    $0x10,%rdx
    aa1c:	48 69 d2 28 12 00 00 	imul   $0x1228,%rdx,%rdx
    aa23:	0f b6 34 11          	movzbl (%rcx,%rdx,1),%esi
    aa27:	48 25 ff ff 00 00    	and    $0xffff,%rax
    aa2d:	75 12                	jne    aa41 <fwp_drop6+0x51>
    aa2f:	40 80 fe 02          	cmp    $0x2,%sil
    aa33:	75 0c                	jne    aa41 <fwp_drop6+0x51>
    aa35:	48 8d 04 11          	lea    (%rcx,%rdx,1),%rax
    aa39:	48 05 28 02 00 00    	add    $0x228,%rax
    aa3f:	eb 1f                	jmp    aa60 <fwp_drop6+0x70>
    aa41:	40 80 fe 01          	cmp    $0x1,%sil
    aa45:	75 4a                	jne    aa91 <fwp_drop6+0xa1>
    aa47:	48 8d 34 11          	lea    (%rcx,%rdx,1),%rsi
    aa4b:	8b 4c 11 20          	mov    0x20(%rcx,%rdx,1),%ecx
    aa4f:	48 0f af c1          	imul   %rcx,%rax
    aa53:	48 c1 e8 20          	shr    $0x20,%rax
    aa57:	48 01 f0             	add    %rsi,%rax
    aa5a:	48 05 28 02 00 00    	add    $0x228,%rax
    aa60:	0f b6 08             	movzbl (%rax),%ecx
    aa63:	85 c9                	test   %ecx,%ecx
    aa65:	74 2a                	je     aa91 <fwp_drop6+0xa1>
    aa67:	83 f9 01             	cmp    $0x1,%ecx
    aa6a:	75 19                	jne    aa85 <fwp_drop6+0x95>
    aa6c:	53                   	push   %rbx
    aa6d:	48 8b 47 10          	mov    0x10(%rdi),%rax
    aa71:	48 89 fb             	mov    %rdi,%rbx
    aa74:	48 89 c7             	mov    %rax,%rdi
    aa77:	e8 24 00 00 00       	call   aaa0 <fwp_drop1>
    aa7c:	48 89 df             	mov    %rbx,%rdi
    aa7f:	5b                   	pop    %rbx
    aa80:	e9 eb 04 00 00       	jmp    af70 <fwp_rc_free_obj>
    aa85:	81 f9 ff 00 00 00    	cmp    $0xff,%ecx
    aa8b:	74 05                	je     aa92 <fwp_drop6+0xa2>
    aa8d:	fe c9                	dec    %cl
    aa8f:	88 08                	mov    %cl,(%rax)
    aa91:	c3                   	ret
    aa92:	48 89 c7             	mov    %rax,%rdi
    aa95:	e9 f6 01 00 00       	jmp    ac90 <fwp_rc_wide_drop>
    aa9a:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)

000000000000aaa0 <fwp_drop1>:
    aaa0:	53                   	push   %rbx
    aaa1:	48 89 f8             	mov    %rdi,%rax
    aaa4:	48 2b 05 ed 86 00 00 	sub    0x86ed(%rip),%rax        # 13198 <fwp_gc+0x1030>
    aaab:	48 8b 0d 0e 87 00 00 	mov    0x870e(%rip),%rcx        # 131c0 <fwp_gc+0x1058>
    aab2:	48 c1 e1 10          	shl    $0x10,%rcx
    aab6:	48 39 c8             	cmp    %rcx,%rax
    aab9:	0f 83 9c 00 00 00    	jae    ab5b <fwp_drop1+0xbb>
    aabf:	48 8b 0d 1a 87 00 00 	mov    0x871a(%rip),%rcx        # 131e0 <fwp_gc+0x1078>
    aac6:	48 89 c2             	mov    %rax,%rdx
    aac9:	48 c1 ea 10          	shr    $0x10,%rdx
    aacd:	48 69 d2 28 12 00 00 	imul   $0x1228,%rdx,%rdx
    aad4:	0f b6 34 11          	movzbl (%rcx,%rdx,1),%esi
    aad8:	48 25 ff ff 00 00    	and    $0xffff,%rax
    aade:	75 20                	jne    ab00 <fwp_drop1+0x60>
    aae0:	40 80 fe 02          	cmp    $0x2,%sil
    aae4:	75 1a                	jne    ab00 <fwp_drop1+0x60>
    aae6:	48 8d 04 11          	lea    (%rcx,%rdx,1),%rax
    aaea:	48 05 28 02 00 00    	add    $0x228,%rax
    aaf0:	eb 2d                	jmp    ab1f <fwp_drop1+0x7f>
    aaf2:	66 66 66 66 66 2e 0f 	data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    aaf9:	1f 84 00 00 00 00 00 
    ab00:	40 80 fe 01          	cmp    $0x1,%sil
    ab04:	75 55                	jne    ab5b <fwp_drop1+0xbb>
    ab06:	48 8d 34 11          	lea    (%rcx,%rdx,1),%rsi
    ab0a:	8b 4c 11 20          	mov    0x20(%rcx,%rdx,1),%ecx
    ab0e:	48 0f af c1          	imul   %rcx,%rax
    ab12:	48 c1 e8 20          	shr    $0x20,%rax
    ab16:	48 01 f0             	add    %rsi,%rax
    ab19:	48 05 28 02 00 00    	add    $0x228,%rax
    ab1f:	0f b6 08             	movzbl (%rax),%ecx
    ab22:	85 c9                	test   %ecx,%ecx
    ab24:	74 35                	je     ab5b <fwp_drop1+0xbb>
    ab26:	83 f9 01             	cmp    $0x1,%ecx
    ab29:	75 32                	jne    ab5d <fwp_drop1+0xbd>
    ab2b:	48 83 3f 00          	cmpq   $0x0,(%rdi)
    ab2f:	79 3a                	jns    ab6b <fwp_drop1+0xcb>
    ab31:	48 8b 5f 08          	mov    0x8(%rdi),%rbx
    ab35:	e8 46 00 00 00       	call   ab80 <fwp_rc_free_arr>
    ab3a:	48 89 d8             	mov    %rbx,%rax
    ab3d:	48 2b 05 54 86 00 00 	sub    0x8654(%rip),%rax        # 13198 <fwp_gc+0x1030>
    ab44:	48 8b 0d 75 86 00 00 	mov    0x8675(%rip),%rcx        # 131c0 <fwp_gc+0x1058>
    ab4b:	48 c1 e1 10          	shl    $0x10,%rcx
    ab4f:	48 89 df             	mov    %rbx,%rdi
    ab52:	48 39 c8             	cmp    %rcx,%rax
    ab55:	0f 82 64 ff ff ff    	jb     aabf <fwp_drop1+0x1f>
    ab5b:	5b                   	pop    %rbx
    ab5c:	c3                   	ret
    ab5d:	81 f9 ff 00 00 00    	cmp    $0xff,%ecx
    ab63:	74 09                	je     ab6e <fwp_drop1+0xce>
    ab65:	fe c9                	dec    %cl
    ab67:	88 08                	mov    %cl,(%rax)
    ab69:	5b                   	pop    %rbx
    ab6a:	c3                   	ret
    ab6b:	5b                   	pop    %rbx
    ab6c:	eb 12                	jmp    ab80 <fwp_rc_free_arr>
    ab6e:	48 89 c7             	mov    %rax,%rdi
    ab71:	5b                   	pop    %rbx
    ab72:	e9 19 01 00 00       	jmp    ac90 <fwp_rc_wide_drop>
    ab77:	66 0f 1f 84 00 00 00 	nopw   0x0(%rax,%rax,1)
    ab7e:	00 00 

000000000000ab80 <fwp_rc_free_arr>:
    ab80:	48 89 f8             	mov    %rdi,%rax
    ab83:	48 2b 05 0e 86 00 00 	sub    0x860e(%rip),%rax        # 13198 <fwp_gc+0x1030>
    ab8a:	48 8b 0d 2f 86 00 00 	mov    0x862f(%rip),%rcx        # 131c0 <fwp_gc+0x1058>
    ab91:	48 c1 e1 10          	shl    $0x10,%rcx
    ab95:	48 39 c8             	cmp    %rcx,%rax
    ab98:	0f 83 e9 00 00 00    	jae    ac87 <fwp_rc_free_arr+0x107>
    ab9e:	53                   	push   %rbx
    ab9f:	48 8b 0d 3a 86 00 00 	mov    0x863a(%rip),%rcx        # 131e0 <fwp_gc+0x1078>
    aba6:	48 89 c2             	mov    %rax,%rdx
    aba9:	48 c1 ea 10          	shr    $0x10,%rdx
    abad:	48 69 d2 28 12 00 00 	imul   $0x1228,%rdx,%rdx
    abb4:	0f b6 34 11          	movzbl (%rcx,%rdx,1),%esi
    abb8:	48 25 ff ff 00 00    	and    $0xffff,%rax
    abbe:	75 1a                	jne    abda <fwp_rc_free_arr+0x5a>
    abc0:	40 80 fe 02          	cmp    $0x2,%sil
    abc4:	75 14                	jne    abda <fwp_rc_free_arr+0x5a>
    abc6:	48 8d 04 11          	lea    (%rcx,%rdx,1),%rax
    abca:	48 05 28 02 00 00    	add    $0x228,%rax
    abd0:	80 38 01             	cmpb   $0x1,(%rax)
    abd3:	74 31                	je     ac06 <fwp_rc_free_arr+0x86>
    abd5:	e9 ac 00 00 00       	jmp    ac86 <fwp_rc_free_arr+0x106>
    abda:	40 80 fe 01          	cmp    $0x1,%sil
    abde:	0f 85 a2 00 00 00    	jne    ac86 <fwp_rc_free_arr+0x106>
    abe4:	48 8d 34 11          	lea    (%rcx,%rdx,1),%rsi
    abe8:	8b 4c 11 20          	mov    0x20(%rcx,%rdx,1),%ecx
    abec:	48 0f af c1          	imul   %rcx,%rax
    abf0:	48 c1 e8 20          	shr    $0x20,%rax
    abf4:	48 01 f0             	add    %rsi,%rax
    abf7:	48 05 28 02 00 00    	add    $0x228,%rax
    abfd:	80 38 01             	cmpb   $0x1,(%rax)
    ac00:	0f 85 80 00 00 00    	jne    ac86 <fwp_rc_free_arr+0x106>
    ac06:	8b 0d 7c 8f 00 00    	mov    0x8f7c(%rip),%ecx        # 13b88 <fwp_reuse_verify>
    ac0c:	85 c9                	test   %ecx,%ecx
    ac0e:	78 0d                	js     ac1d <fwp_rc_free_arr+0x9d>
    ac10:	85 c9                	test   %ecx,%ecx
    ac12:	74 47                	je     ac5b <fwp_rc_free_arr+0xdb>
    ac14:	48 c7 07 00 00 00 00 	movq   $0x0,(%rdi)
    ac1b:	eb 69                	jmp    ac86 <fwp_rc_free_arr+0x106>
    ac1d:	48 89 fb             	mov    %rdi,%rbx
    ac20:	48 8d 3d 62 49 00 00 	lea    0x4962(%rip),%rdi        # f589 <fwp_segv.msg+0x309>
    ac27:	e8 04 74 ff ff       	call   2030 <getenv@plt>
    ac2c:	31 c9                	xor    %ecx,%ecx
    ac2e:	48 85 c0             	test   %rax,%rax
    ac31:	74 1b                	je     ac4e <fwp_rc_free_arr+0xce>
    ac33:	80 38 00             	cmpb   $0x0,(%rax)
    ac36:	74 16                	je     ac4e <fwp_rc_free_arr+0xce>
    ac38:	48 8d 35 ca 4a 00 00 	lea    0x4aca(%rip),%rsi        # f709 <fwp_segv.msg+0x489>
    ac3f:	48 89 c7             	mov    %rax,%rdi
    ac42:	e8 29 75 ff ff       	call   2170 <strcmp@plt>
    ac47:	31 c9                	xor    %ecx,%ecx
    ac49:	85 c0                	test   %eax,%eax
    ac4b:	0f 95 c1             	setne  %cl
    ac4e:	89 0d 34 8f 00 00    	mov    %ecx,0x8f34(%rip)        # 13b88 <fwp_reuse_verify>
    ac54:	48 89 df             	mov    %rbx,%rdi
    ac57:	85 c9                	test   %ecx,%ecx
    ac59:	75 b9                	jne    ac14 <fwp_rc_free_arr+0x94>
    ac5b:	48 8b 1d 06 75 00 00 	mov    0x7506(%rip),%rbx        # 12168 <fwp_gc>
    ac62:	e8 b9 00 00 00       	call   ad20 <fwp_mem_free>
    ac67:	48 8b 05 fa 74 00 00 	mov    0x74fa(%rip),%rax        # 12168 <fwp_gc>
    ac6e:	48 29 d8             	sub    %rbx,%rax
    ac71:	f2 48 0f 2a c0       	cvtsi2sd %rax,%xmm0
    ac76:	f2 0f 58 05 f2 86 00 	addsd  0x86f2(%rip),%xmm0        # 13370 <fwp_gc+0x1208>
    ac7d:	00 
    ac7e:	f2 0f 11 05 ea 86 00 	movsd  %xmm0,0x86ea(%rip)        # 13370 <fwp_gc+0x1208>
    ac85:	00 
    ac86:	5b                   	pop    %rbx
    ac87:	c3                   	ret
    ac88:	0f 1f 84 00 00 00 00 	nopl   0x0(%rax,%rax,1)
    ac8f:	00 

000000000000ac90 <fwp_rc_wide_drop>:
    ac90:	53                   	push   %rbx
    ac91:	48 89 f8             	mov    %rdi,%rax
    ac94:	48 c1 e8 11          	shr    $0x11,%rax
    ac98:	31 f8                	xor    %edi,%eax
    ac9a:	89 c1                	mov    %eax,%ecx
    ac9c:	c1 e9 09             	shr    $0x9,%ecx
    ac9f:	31 c1                	xor    %eax,%ecx
    aca1:	0f b6 c1             	movzbl %cl,%eax
    aca4:	48 8d 0d bd 74 00 00 	lea    0x74bd(%rip),%rcx        # 12168 <fwp_gc>
    acab:	48 8b 84 c1 18 12 00 	mov    0x1218(%rcx,%rax,8),%rax
    acb2:	00 
    acb3:	48 85 c0             	test   %rax,%rax
    acb6:	74 16                	je     acce <fwp_rc_wide_drop+0x3e>
    acb8:	0f 1f 84 00 00 00 00 	nopl   0x0(%rax,%rax,1)
    acbf:	00 
    acc0:	48 39 38             	cmp    %rdi,(%rax)
    acc3:	74 37                	je     acfc <fwp_rc_wide_drop+0x6c>
    acc5:	48 8b 40 10          	mov    0x10(%rax),%rax
    acc9:	48 85 c0             	test   %rax,%rax
    accc:	75 f2                	jne    acc0 <fwp_rc_wide_drop+0x30>
    acce:	e8 8d bd ff ff       	call   6a60 <fwp_flush>
    acd3:	48 8b 05 06 73 00 00 	mov    0x7306(%rip),%rax        # 11fe0 <stderr@GLIBC_2.2.5>
    acda:	48 8b 38             	mov    (%rax),%rdi
    acdd:	48 8d 35 e9 47 00 00 	lea    0x47e9(%rip),%rsi        # f4cd <fwp_segv.msg+0x24d>
    ace4:	48 8d 15 f1 47 00 00 	lea    0x47f1(%rip),%rdx        # f4dc <fwp_segv.msg+0x25c>
    aceb:	31 c0                	xor    %eax,%eax
    aced:	e8 ae 74 ff ff       	call   21a0 <fprintf@plt>
    acf2:	bf 65 00 00 00       	mov    $0x65,%edi
    acf7:	e8 74 75 ff ff       	call   2270 <exit@plt>
    acfc:	48 8b 48 08          	mov    0x8(%rax),%rcx
    ad00:	48 ff c9             	dec    %rcx
    ad03:	48 89 48 08          	mov    %rcx,0x8(%rax)
    ad07:	48 81 f9 fe 00 00 00 	cmp    $0xfe,%rcx
    ad0e:	75 0b                	jne    ad1b <fwp_rc_wide_drop+0x8b>
    ad10:	48 89 fb             	mov    %rdi,%rbx
    ad13:	e8 78 bd ff ff       	call   6a90 <fwp_rc_forget_slot>
    ad18:	c6 03 fe             	movb   $0xfe,(%rbx)
    ad1b:	5b                   	pop    %rbx
    ad1c:	c3                   	ret
    ad1d:	0f 1f 00             	nopl   (%rax)

000000000000ad20 <fwp_mem_free>:
    ad20:	48 85 ff             	test   %rdi,%rdi
    ad23:	0f 84 17 02 00 00    	je     af40 <fwp_mem_free+0x220>
    ad29:	48 8b 05 68 84 00 00 	mov    0x8468(%rip),%rax        # 13198 <fwp_gc+0x1030>
    ad30:	48 89 f9             	mov    %rdi,%rcx
    ad33:	48 29 c1             	sub    %rax,%rcx
    ad36:	48 8b 15 83 84 00 00 	mov    0x8483(%rip),%rdx        # 131c0 <fwp_gc+0x1058>
    ad3d:	48 c1 e2 10          	shl    $0x10,%rdx
    ad41:	48 39 d1             	cmp    %rdx,%rcx
    ad44:	0f 83 f6 01 00 00    	jae    af40 <fwp_mem_free+0x220>
    ad4a:	41 57                	push   %r15
    ad4c:	41 56                	push   %r14
    ad4e:	41 55                	push   %r13
    ad50:	41 54                	push   %r12
    ad52:	53                   	push   %rbx
    ad53:	4c 8b 25 86 84 00 00 	mov    0x8486(%rip),%r12        # 131e0 <fwp_gc+0x1078>
    ad5a:	4d 85 e4             	test   %r12,%r12
    ad5d:	0f 84 d4 01 00 00    	je     af37 <fwp_mem_free+0x217>
    ad63:	49 89 cf             	mov    %rcx,%r15
    ad66:	49 c1 ef 10          	shr    $0x10,%r15
    ad6a:	4d 69 f7 28 12 00 00 	imul   $0x1228,%r15,%r14
    ad71:	43 0f b6 14 34       	movzbl (%r12,%r14,1),%edx
    ad76:	83 fa 02             	cmp    $0x2,%edx
    ad79:	0f 84 b9 00 00 00    	je     ae38 <fwp_mem_free+0x118>
    ad7f:	83 fa 01             	cmp    $0x1,%edx
    ad82:	0f 85 af 01 00 00    	jne    af37 <fwp_mem_free+0x217>
    ad88:	47 0f b6 4c 34 01    	movzbl 0x1(%r12,%r14,1),%r9d
    ad8e:	47 0f b6 44 34 02    	movzbl 0x2(%r12,%r14,1),%r8d
    ad94:	43 8b 74 34 08       	mov    0x8(%r12,%r14,1),%esi
    ad99:	0f b7 c7             	movzwl %di,%eax
    ad9c:	31 d2                	xor    %edx,%edx
    ad9e:	f7 f6                	div    %esi
    ada0:	48 c7 c2 fe ff ff ff 	mov    $0xfffffffffffffffe,%rdx
    ada7:	89 c1                	mov    %eax,%ecx
    ada9:	48 d3 c2             	rol    %cl,%rdx
    adac:	4b 8d 0c 34          	lea    (%r12,%r14,1),%rcx
    adb0:	41 89 c2             	mov    %eax,%r10d
    adb3:	41 c1 ea 03          	shr    $0x3,%r10d
    adb7:	41 81 e2 f8 1f 00 00 	and    $0x1ff8,%r10d
    adbe:	49 21 54 0a 28       	and    %rdx,0x28(%r10,%rcx,1)
    adc3:	49 69 d1 c0 03 00 00 	imul   $0x3c0,%r9,%rdx
    adca:	4c 8d 3d 97 73 00 00 	lea    0x7397(%rip),%r15        # 12168 <fwp_gc>
    add1:	49 01 d7             	add    %rdx,%r15
    add4:	4f 8d 2c 40          	lea    (%r8,%r8,2),%r13
    add8:	4d 01 e6             	add    %r12,%r14
    addb:	49 83 c6 08          	add    $0x8,%r14
    addf:	48 8d 1c 08          	lea    (%rax,%rcx,1),%rbx
    ade3:	48 81 c3 28 02 00 00 	add    $0x228,%rbx
    adea:	80 bc 08 28 02 00 00 	cmpb   $0xff,0x228(%rax,%rcx,1)
    adf1:	ff 
    adf2:	0f 84 49 01 00 00    	je     af41 <fwp_mem_free+0x221>
    adf8:	4f 8d 3c ef          	lea    (%r15,%r13,8),%r15
    adfc:	49 83 c7 08          	add    $0x8,%r15
    ae00:	c6 03 00             	movb   $0x0,(%rbx)
    ae03:	83 3d 62 83 00 00 00 	cmpl   $0x0,0x8362(%rip)        # 1316c <fwp_gc+0x1004>
    ae0a:	74 12                	je     ae1e <fwp_mem_free+0xfe>
    ae0c:	89 f2                	mov    %esi,%edx
    ae0e:	48 89 fb             	mov    %rdi,%rbx
    ae11:	31 f6                	xor    %esi,%esi
    ae13:	e8 08 73 ff ff       	call   2120 <memset@plt>
    ae18:	48 89 df             	mov    %rbx,%rdi
    ae1b:	41 8b 36             	mov    (%r14),%esi
    ae1e:	49 8b 07             	mov    (%r15),%rax
    ae21:	48 f7 d0             	not    %rax
    ae24:	48 89 07             	mov    %rax,(%rdi)
    ae27:	49 89 3f             	mov    %rdi,(%r15)
    ae2a:	89 f0                	mov    %esi,%eax
    ae2c:	48 01 05 35 73 00 00 	add    %rax,0x7335(%rip)        # 12168 <fwp_gc>
    ae33:	e9 ff 00 00 00       	jmp    af37 <fwp_mem_free+0x217>
    ae38:	48 81 e1 00 00 ff ff 	and    $0xffffffffffff0000,%rcx
    ae3f:	48 01 c8             	add    %rcx,%rax
    ae42:	48 39 f8             	cmp    %rdi,%rax
    ae45:	0f 85 ec 00 00 00    	jne    af37 <fwp_mem_free+0x217>
    ae4b:	4b 8b 44 34 18       	mov    0x18(%r12,%r14,1),%rax
    ae50:	48 01 05 11 73 00 00 	add    %rax,0x7311(%rip)        # 12168 <fwp_gc>
    ae57:	43 c6 44 34 03 00    	movb   $0x0,0x3(%r12,%r14,1)
    ae5d:	4b 8d 1c 34          	lea    (%r12,%r14,1),%rbx
    ae61:	48 81 c3 28 02 00 00 	add    $0x228,%rbx
    ae68:	43 80 bc 34 28 02 00 	cmpb   $0xff,0x228(%r12,%r14,1)
    ae6f:	00 ff 
    ae71:	0f 84 e0 00 00 00    	je     af57 <fwp_mem_free+0x237>
    ae77:	c6 03 00             	movb   $0x0,(%rbx)
    ae7a:	43 8b 44 34 10       	mov    0x10(%r12,%r14,1),%eax
    ae7f:	48 85 c0             	test   %rax,%rax
    ae82:	0f 84 88 00 00 00    	je     af10 <fwp_mem_free+0x1f0>
    ae88:	48 8b 0d 51 83 00 00 	mov    0x8351(%rip),%rcx        # 131e0 <fwp_gc+0x1078>
    ae8f:	89 c2                	mov    %eax,%edx
    ae91:	83 e2 03             	and    $0x3,%edx
    ae94:	83 f8 04             	cmp    $0x4,%eax
    ae97:	73 04                	jae    ae9d <fwp_mem_free+0x17d>
    ae99:	31 f6                	xor    %esi,%esi
    ae9b:	eb 3b                	jmp    aed8 <fwp_mem_free+0x1b8>
    ae9d:	4a 8d 3c 31          	lea    (%rcx,%r14,1),%rdi
    aea1:	41 89 c0             	mov    %eax,%r8d
    aea4:	41 83 e0 fc          	and    $0xfffffffc,%r8d
    aea8:	31 f6                	xor    %esi,%esi
    aeaa:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)
    aeb0:	c6 07 00             	movb   $0x0,(%rdi)
    aeb3:	c6 87 28 12 00 00 00 	movb   $0x0,0x1228(%rdi)
    aeba:	c6 87 50 24 00 00 00 	movb   $0x0,0x2450(%rdi)
    aec1:	c6 87 78 36 00 00 00 	movb   $0x0,0x3678(%rdi)
    aec8:	48 83 c6 04          	add    $0x4,%rsi
    aecc:	48 81 c7 a0 48 00 00 	add    $0x48a0,%rdi
    aed3:	49 39 f0             	cmp    %rsi,%r8
    aed6:	75 d8                	jne    aeb0 <fwp_mem_free+0x190>
    aed8:	48 85 d2             	test   %rdx,%rdx
    aedb:	74 33                	je     af10 <fwp_mem_free+0x1f0>
    aedd:	48 69 f6 28 12 00 00 	imul   $0x1228,%rsi,%rsi
    aee4:	4c 01 f6             	add    %r14,%rsi
    aee7:	48 01 f1             	add    %rsi,%rcx
    aeea:	48 69 d2 28 12 00 00 	imul   $0x1228,%rdx,%rdx
    aef1:	31 f6                	xor    %esi,%esi
    aef3:	66 66 66 66 2e 0f 1f 	data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    aefa:	84 00 00 00 00 00 
    af00:	c6 04 31 00          	movb   $0x0,(%rcx,%rsi,1)
    af04:	48 81 c6 28 12 00 00 	add    $0x1228,%rsi
    af0b:	48 39 f2             	cmp    %rsi,%rdx
    af0e:	75 f0                	jne    af00 <fwp_mem_free+0x1e0>
    af10:	48 01 05 31 84 00 00 	add    %rax,0x8431(%rip)        # 13348 <fwp_gc+0x11e0>
    af17:	4c 3b 3d ba 82 00 00 	cmp    0x82ba(%rip),%r15        # 131d8 <fwp_gc+0x1070>
    af1e:	73 07                	jae    af27 <fwp_mem_free+0x207>
    af20:	4c 89 3d b1 82 00 00 	mov    %r15,0x82b1(%rip)        # 131d8 <fwp_gc+0x1070>
    af27:	4c 3b 3d a2 82 00 00 	cmp    0x82a2(%rip),%r15        # 131d0 <fwp_gc+0x1068>
    af2e:	73 07                	jae    af37 <fwp_mem_free+0x217>
    af30:	4c 89 3d 99 82 00 00 	mov    %r15,0x8299(%rip)        # 131d0 <fwp_gc+0x1068>
    af37:	5b                   	pop    %rbx
    af38:	41 5c                	pop    %r12
    af3a:	41 5d                	pop    %r13
    af3c:	41 5e                	pop    %r14
    af3e:	41 5f                	pop    %r15
    af40:	c3                   	ret
    af41:	49 89 fc             	mov    %rdi,%r12
    af44:	48 89 df             	mov    %rbx,%rdi
    af47:	e8 44 bb ff ff       	call   6a90 <fwp_rc_forget_slot>
    af4c:	4c 89 e7             	mov    %r12,%rdi
    af4f:	41 8b 36             	mov    (%r14),%esi
    af52:	e9 a1 fe ff ff       	jmp    adf8 <fwp_mem_free+0xd8>
    af57:	48 89 df             	mov    %rbx,%rdi
    af5a:	e8 31 bb ff ff       	call   6a90 <fwp_rc_forget_slot>
    af5f:	e9 13 ff ff ff       	jmp    ae77 <fwp_mem_free+0x157>
    af64:	66 66 66 2e 0f 1f 84 	data16 data16 cs nopw 0x0(%rax,%rax,1)
    af6b:	00 00 00 00 00 

000000000000af70 <fwp_rc_free_obj>:
    af70:	48 89 f8             	mov    %rdi,%rax
    af73:	48 2b 05 1e 82 00 00 	sub    0x821e(%rip),%rax        # 13198 <fwp_gc+0x1030>
    af7a:	48 8b 0d 3f 82 00 00 	mov    0x823f(%rip),%rcx        # 131c0 <fwp_gc+0x1058>
    af81:	48 c1 e1 10          	shl    $0x10,%rcx
    af85:	48 39 c8             	cmp    %rcx,%rax
    af88:	0f 83 b8 01 00 00    	jae    b146 <fwp_rc_free_obj+0x1d6>
    af8e:	55                   	push   %rbp
    af8f:	41 57                	push   %r15
    af91:	41 56                	push   %r14
    af93:	53                   	push   %rbx
    af94:	50                   	push   %rax
    af95:	48 8b 1d 44 82 00 00 	mov    0x8244(%rip),%rbx        # 131e0 <fwp_gc+0x1078>
    af9c:	48 89 c1             	mov    %rax,%rcx
    af9f:	48 c1 e9 10          	shr    $0x10,%rcx
    afa3:	4c 69 f1 28 12 00 00 	imul   $0x1228,%rcx,%r14
    afaa:	42 0f b6 2c 33       	movzbl (%rbx,%r14,1),%ebp
    afaf:	48 25 ff ff 00 00    	and    $0xffff,%rax
    afb5:	75 1a                	jne    afd1 <fwp_rc_free_obj+0x61>
    afb7:	40 80 fd 02          	cmp    $0x2,%bpl
    afbb:	75 14                	jne    afd1 <fwp_rc_free_obj+0x61>
    afbd:	4a 8d 04 33          	lea    (%rbx,%r14,1),%rax
    afc1:	48 05 28 02 00 00    	add    $0x228,%rax
    afc7:	80 38 01             	cmpb   $0x1,(%rax)
    afca:	74 32                	je     affe <fwp_rc_free_obj+0x8e>
    afcc:	e9 6b 01 00 00       	jmp    b13c <fwp_rc_free_obj+0x1cc>
    afd1:	40 80 fd 01          	cmp    $0x1,%bpl
    afd5:	0f 85 61 01 00 00    	jne    b13c <fwp_rc_free_obj+0x1cc>
    afdb:	4a 8d 0c 33          	lea    (%rbx,%r14,1),%rcx
    afdf:	42 8b 54 33 20       	mov    0x20(%rbx,%r14,1),%edx
    afe4:	48 0f af c2          	imul   %rdx,%rax
    afe8:	48 c1 e8 20          	shr    $0x20,%rax
    afec:	48 01 c8             	add    %rcx,%rax
    afef:	48 05 28 02 00 00    	add    $0x228,%rax
    aff5:	80 38 01             	cmpb   $0x1,(%rax)
    aff8:	0f 85 3e 01 00 00    	jne    b13c <fwp_rc_free_obj+0x1cc>
    affe:	8b 0d 84 8b 00 00    	mov    0x8b84(%rip),%ecx        # 13b88 <fwp_reuse_verify>
    b004:	85 c9                	test   %ecx,%ecx
    b006:	0f 88 c3 00 00 00    	js     b0cf <fwp_rc_free_obj+0x15f>
    b00c:	85 c9                	test   %ecx,%ecx
    b00e:	0f 84 fd 00 00 00    	je     b111 <fwp_rc_free_obj+0x1a1>
    b014:	42 80 7c 33 01 01    	cmpb   $0x1,0x1(%rbx,%r14,1)
    b01a:	75 0d                	jne    b029 <fwp_rc_free_obj+0xb9>
    b01c:	40 80 fd 02          	cmp    $0x2,%bpl
    b020:	75 22                	jne    b044 <fwp_rc_free_obj+0xd4>
    b022:	4a 8b 54 33 18       	mov    0x18(%rbx,%r14,1),%rdx
    b027:	eb 20                	jmp    b049 <fwp_rc_free_obj+0xd9>
    b029:	c7 07 ad de 00 00    	movl   $0xdead,(%rdi)
    b02f:	8b 47 04             	mov    0x4(%rdi),%eax
    b032:	48 85 c0             	test   %rax,%rax
    b035:	0f 84 01 01 00 00    	je     b13c <fwp_rc_free_obj+0x1cc>
    b03b:	83 f8 04             	cmp    $0x4,%eax
    b03e:	73 26                	jae    b066 <fwp_rc_free_obj+0xf6>
    b040:	31 c9                	xor    %ecx,%ecx
    b042:	eb 6a                	jmp    b0ae <fwp_rc_free_obj+0x13e>
    b044:	42 8b 54 33 08       	mov    0x8(%rbx,%r14,1),%edx
    b049:	48 89 fb             	mov    %rdi,%rbx
    b04c:	be dd 00 00 00       	mov    $0xdd,%esi
    b051:	e8 ca 70 ff ff       	call   2120 <memset@plt>
    b056:	48 c7 03 00 00 00 00 	movq   $0x0,(%rbx)
    b05d:	c6 43 08 00          	movb   $0x0,0x8(%rbx)
    b061:	e9 d6 00 00 00       	jmp    b13c <fwp_rc_free_obj+0x1cc>
    b066:	89 c1                	mov    %eax,%ecx
    b068:	83 e1 fc             	and    $0xfffffffc,%ecx
    b06b:	48 8d 14 c5 00 00 00 	lea    0x0(,%rax,8),%rdx
    b072:	00 
    b073:	48 83 e2 e0          	and    $0xffffffffffffffe0,%rdx
    b077:	31 f6                	xor    %esi,%esi
    b079:	66 0f 28 05 6f 40 00 	movapd 0x406f(%rip),%xmm0        # f0f0 <_IO_stdin_used+0xf0>
    b080:	00 
    b081:	66 66 66 66 66 66 2e 	data16 data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    b088:	0f 1f 84 00 00 00 00 
    b08f:	00 
    b090:	66 0f 11 44 37 08    	movupd %xmm0,0x8(%rdi,%rsi,1)
    b096:	66 0f 11 44 37 18    	movupd %xmm0,0x18(%rdi,%rsi,1)
    b09c:	48 83 c6 20          	add    $0x20,%rsi
    b0a0:	48 39 f2             	cmp    %rsi,%rdx
    b0a3:	75 eb                	jne    b090 <fwp_rc_free_obj+0x120>
    b0a5:	48 39 c1             	cmp    %rax,%rcx
    b0a8:	0f 84 8e 00 00 00    	je     b13c <fwp_rc_free_obj+0x1cc>
    b0ae:	48 ba ef be ad de ef 	movabs $0xdeadbeefdeadbeef,%rdx
    b0b5:	be ad de 
    b0b8:	0f 1f 84 00 00 00 00 	nopl   0x0(%rax,%rax,1)
    b0bf:	00 
    b0c0:	48 89 54 cf 08       	mov    %rdx,0x8(%rdi,%rcx,8)
    b0c5:	48 ff c1             	inc    %rcx
    b0c8:	48 39 c8             	cmp    %rcx,%rax
    b0cb:	75 f3                	jne    b0c0 <fwp_rc_free_obj+0x150>
    b0cd:	eb 6d                	jmp    b13c <fwp_rc_free_obj+0x1cc>
    b0cf:	49 89 ff             	mov    %rdi,%r15
    b0d2:	48 8d 3d b0 44 00 00 	lea    0x44b0(%rip),%rdi        # f589 <fwp_segv.msg+0x309>
    b0d9:	e8 52 6f ff ff       	call   2030 <getenv@plt>
    b0de:	31 c9                	xor    %ecx,%ecx
    b0e0:	48 85 c0             	test   %rax,%rax
    b0e3:	74 1b                	je     b100 <fwp_rc_free_obj+0x190>
    b0e5:	80 38 00             	cmpb   $0x0,(%rax)
    b0e8:	74 16                	je     b100 <fwp_rc_free_obj+0x190>
    b0ea:	48 8d 35 18 46 00 00 	lea    0x4618(%rip),%rsi        # f709 <fwp_segv.msg+0x489>
    b0f1:	48 89 c7             	mov    %rax,%rdi
    b0f4:	e8 77 70 ff ff       	call   2170 <strcmp@plt>
    b0f9:	31 c9                	xor    %ecx,%ecx
    b0fb:	85 c0                	test   %eax,%eax
    b0fd:	0f 95 c1             	setne  %cl
    b100:	89 0d 82 8a 00 00    	mov    %ecx,0x8a82(%rip)        # 13b88 <fwp_reuse_verify>
    b106:	4c 89 ff             	mov    %r15,%rdi
    b109:	85 c9                	test   %ecx,%ecx
    b10b:	0f 85 03 ff ff ff    	jne    b014 <fwp_rc_free_obj+0xa4>
    b111:	48 8b 1d 50 70 00 00 	mov    0x7050(%rip),%rbx        # 12168 <fwp_gc>
    b118:	e8 03 fc ff ff       	call   ad20 <fwp_mem_free>
    b11d:	48 8b 05 44 70 00 00 	mov    0x7044(%rip),%rax        # 12168 <fwp_gc>
    b124:	48 29 d8             	sub    %rbx,%rax
    b127:	f2 48 0f 2a c0       	cvtsi2sd %rax,%xmm0
    b12c:	f2 0f 58 05 3c 82 00 	addsd  0x823c(%rip),%xmm0        # 13370 <fwp_gc+0x1208>
    b133:	00 
    b134:	f2 0f 11 05 34 82 00 	movsd  %xmm0,0x8234(%rip)        # 13370 <fwp_gc+0x1208>
    b13b:	00 
    b13c:	48 83 c4 08          	add    $0x8,%rsp
    b140:	5b                   	pop    %rbx
    b141:	41 5e                	pop    %r14
    b143:	41 5f                	pop    %r15
    b145:	5d                   	pop    %rbp
    b146:	c3                   	ret
    b147:	66 0f 1f 84 00 00 00 	nopw   0x0(%rax,%rax,1)
    b14e:	00 00 

000000000000b150 <fwp_owned_entry49>:
    b150:	48 8b 3f             	mov    (%rdi),%rdi
    b153:	e9 18 f5 ff ff       	jmp    a670 <f49>
    b158:	0f 1f 84 00 00 00 00 	nopl   0x0(%rax,%rax,1)
    b15f:	00 

000000000000b160 <fwp_caps49>:
    b160:	53                   	push   %rbx
    b161:	83 7f 04 00          	cmpl   $0x0,0x4(%rdi)
    b165:	74 56                	je     b1bd <fwp_caps49+0x5d>
    b167:	48 89 fb             	mov    %rdi,%rbx
    b16a:	48 8b 7f 08          	mov    0x8(%rdi),%rdi
    b16e:	85 f6                	test   %esi,%esi
    b170:	74 51                	je     b1c3 <fwp_caps49+0x63>
    b172:	48 2b 3d 1f 80 00 00 	sub    0x801f(%rip),%rdi        # 13198 <fwp_gc+0x1030>
    b179:	48 8b 05 40 80 00 00 	mov    0x8040(%rip),%rax        # 131c0 <fwp_gc+0x1058>
    b180:	48 c1 e0 10          	shl    $0x10,%rax
    b184:	48 39 c7             	cmp    %rax,%rdi
    b187:	73 38                	jae    b1c1 <fwp_caps49+0x61>
    b189:	48 8b 05 50 80 00 00 	mov    0x8050(%rip),%rax        # 131e0 <fwp_gc+0x1078>
    b190:	48 89 f9             	mov    %rdi,%rcx
    b193:	48 c1 e9 10          	shr    $0x10,%rcx
    b197:	48 69 c9 28 12 00 00 	imul   $0x1228,%rcx,%rcx
    b19e:	0f b6 14 08          	movzbl (%rax,%rcx,1),%edx
    b1a2:	48 81 e7 ff ff 00 00 	and    $0xffff,%rdi
    b1a9:	75 26                	jne    b1d1 <fwp_caps49+0x71>
    b1ab:	80 fa 02             	cmp    $0x2,%dl
    b1ae:	75 21                	jne    b1d1 <fwp_caps49+0x71>
    b1b0:	48 8d 3c 08          	lea    (%rax,%rcx,1),%rdi
    b1b4:	48 81 c7 28 02 00 00 	add    $0x228,%rdi
    b1bb:	eb 33                	jmp    b1f0 <fwp_caps49+0x90>
    b1bd:	85 f6                	test   %esi,%esi
    b1bf:	74 0a                	je     b1cb <fwp_caps49+0x6b>
    b1c1:	5b                   	pop    %rbx
    b1c2:	c3                   	ret
    b1c3:	e8 28 f8 ff ff       	call   a9f0 <fwp_drop6>
    b1c8:	48 89 df             	mov    %rbx,%rdi
    b1cb:	5b                   	pop    %rbx
    b1cc:	e9 9f fd ff ff       	jmp    af70 <fwp_rc_free_obj>
    b1d1:	80 fa 01             	cmp    $0x1,%dl
    b1d4:	75 eb                	jne    b1c1 <fwp_caps49+0x61>
    b1d6:	48 8d 14 08          	lea    (%rax,%rcx,1),%rdx
    b1da:	8b 44 08 20          	mov    0x20(%rax,%rcx,1),%eax
    b1de:	48 0f af f8          	imul   %rax,%rdi
    b1e2:	48 c1 ef 20          	shr    $0x20,%rdi
    b1e6:	48 01 d7             	add    %rdx,%rdi
    b1e9:	48 81 c7 28 02 00 00 	add    $0x228,%rdi
    b1f0:	0f b6 07             	movzbl (%rdi),%eax
    b1f3:	84 c0                	test   %al,%al
    b1f5:	74 ca                	je     b1c1 <fwp_caps49+0x61>
    b1f7:	3c fe                	cmp    $0xfe,%al
    b1f9:	73 06                	jae    b201 <fwp_caps49+0xa1>
    b1fb:	fe c0                	inc    %al
    b1fd:	88 07                	mov    %al,(%rdi)
    b1ff:	5b                   	pop    %rbx
    b200:	c3                   	ret
    b201:	5b                   	pop    %rbx
    b202:	e9 19 ca ff ff       	jmp    7c20 <fwp_rc_wide_dup>
    b207:	66 0f 1f 84 00 00 00 	nopw   0x0(%rax,%rax,1)
    b20e:	00 00 

000000000000b210 <fwp_args49>:
    b210:	85 f6                	test   %esi,%esi
    b212:	0f 85 8a 00 00 00    	jne    b2a2 <fwp_args49+0x92>
    b218:	85 d2                	test   %edx,%edx
    b21a:	0f 84 82 00 00 00    	je     b2a2 <fwp_args49+0x92>
    b220:	48 8b 07             	mov    (%rdi),%rax
    b223:	48 2b 05 6e 7f 00 00 	sub    0x7f6e(%rip),%rax        # 13198 <fwp_gc+0x1030>
    b22a:	48 8b 0d 8f 7f 00 00 	mov    0x7f8f(%rip),%rcx        # 131c0 <fwp_gc+0x1058>
    b231:	48 c1 e1 10          	shl    $0x10,%rcx
    b235:	48 39 c8             	cmp    %rcx,%rax
    b238:	73 68                	jae    b2a2 <fwp_args49+0x92>
    b23a:	48 8b 0d 9f 7f 00 00 	mov    0x7f9f(%rip),%rcx        # 131e0 <fwp_gc+0x1078>
    b241:	48 89 c2             	mov    %rax,%rdx
    b244:	48 c1 ea 10          	shr    $0x10,%rdx
    b248:	48 69 d2 28 12 00 00 	imul   $0x1228,%rdx,%rdx
    b24f:	0f b6 34 11          	movzbl (%rcx,%rdx,1),%esi
    b253:	48 25 ff ff 00 00    	and    $0xffff,%rax
    b259:	75 13                	jne    b26e <fwp_args49+0x5e>
    b25b:	40 80 fe 02          	cmp    $0x2,%sil
    b25f:	75 0d                	jne    b26e <fwp_args49+0x5e>
    b261:	48 8d 3c 11          	lea    (%rcx,%rdx,1),%rdi
    b265:	48 81 c7 28 02 00 00 	add    $0x228,%rdi
    b26c:	eb 21                	jmp    b28f <fwp_args49+0x7f>
    b26e:	40 80 fe 01          	cmp    $0x1,%sil
    b272:	75 2e                	jne    b2a2 <fwp_args49+0x92>
    b274:	48 8d 34 11          	lea    (%rcx,%rdx,1),%rsi
    b278:	8b 4c 11 20          	mov    0x20(%rcx,%rdx,1),%ecx
    b27c:	48 0f af c1          	imul   %rcx,%rax
    b280:	48 c1 e8 20          	shr    $0x20,%rax
    b284:	48 8d 3c 30          	lea    (%rax,%rsi,1),%rdi
    b288:	48 81 c7 28 02 00 00 	add    $0x228,%rdi
    b28f:	0f b6 07             	movzbl (%rdi),%eax
    b292:	84 c0                	test   %al,%al
    b294:	74 0c                	je     b2a2 <fwp_args49+0x92>
    b296:	3c fe                	cmp    $0xfe,%al
    b298:	0f 83 82 c9 ff ff    	jae    7c20 <fwp_rc_wide_dup>
    b29e:	fe c0                	inc    %al
    b2a0:	88 07                	mov    %al,(%rdi)
    b2a2:	c3                   	ret
    b2a3:	66 66 66 66 2e 0f 1f 	data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    b2aa:	84 00 00 00 00 00 

000000000000b2b0 <fwp_arg_drop49>:
    b2b0:	85 f6                	test   %esi,%esi
    b2b2:	75 0c                	jne    b2c0 <fwp_arg_drop49+0x10>
    b2b4:	85 d2                	test   %edx,%edx
    b2b6:	74 08                	je     b2c0 <fwp_arg_drop49+0x10>
    b2b8:	48 8b 3f             	mov    (%rdi),%rdi
    b2bb:	e9 30 f7 ff ff       	jmp    a9f0 <fwp_drop6>
    b2c0:	c3                   	ret
    b2c1:	66 66 66 66 66 66 2e 	data16 data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    b2c8:	0f 1f 84 00 00 00 00 
    b2cf:	00 

000000000000b2d0 <fwp_p_loop_own>:
    b2d0:	55                   	push   %rbp
    b2d1:	41 57                	push   %r15
    b2d3:	41 56                	push   %r14
    b2d5:	41 55                	push   %r13
    b2d7:	41 54                	push   %r12
    b2d9:	53                   	push   %rbx
    b2da:	48 83 ec 18          	sub    $0x18,%rsp
    b2de:	49 89 fe             	mov    %rdi,%r14
    b2e1:	48 89 34 24          	mov    %rsi,(%rsp)
    b2e5:	48 89 7c 24 08       	mov    %rdi,0x8(%rsp)
    b2ea:	eb 0c                	jmp    b2f8 <fwp_p_loop_own+0x28>
    b2ec:	0f 1f 40 00          	nopl   0x0(%rax)
    b2f0:	fe c0                	inc    %al
    b2f2:	88 07                	mov    %al,(%rdi)
    b2f4:	48 89 34 24          	mov    %rsi,(%rsp)
    b2f8:	8b 05 96 94 00 00    	mov    0x9496(%rip),%eax        # 14794 <fwp_budget>
    b2fe:	8d 48 ff             	lea    -0x1(%rax),%ecx
    b301:	89 0d 8d 94 00 00    	mov    %ecx,0x948d(%rip)        # 14794 <fwp_budget>
    b307:	83 f8 01             	cmp    $0x1,%eax
    b30a:	0f 8e bb 03 00 00    	jle    b6cb <fwp_p_loop_own+0x3fb>
    b310:	48 89 34 24          	mov    %rsi,(%rsp)
    b314:	4c 8b 25 45 94 00 00 	mov    0x9445(%rip),%r12        # 14760 <fwp_fns>
    b31b:	41 8b 06             	mov    (%r14),%eax
    b31e:	48 c1 e0 05          	shl    $0x5,%rax
    b322:	49 83 7c 04 18 00    	cmpq   $0x0,0x18(%r12,%rax,1)
    b328:	0f 84 62 01 00 00    	je     b490 <fwp_p_loop_own+0x1c0>
    b32e:	4d 8d 04 04          	lea    (%r12,%rax,1),%r8
    b332:	49 83 c0 18          	add    $0x18,%r8
    b336:	49 01 c4             	add    %rax,%r12
    b339:	bd 01 00 00 00       	mov    $0x1,%ebp
    b33e:	31 f6                	xor    %esi,%esi
    b340:	4c 89 f0             	mov    %r14,%rax
    b343:	49 89 e7             	mov    %rsp,%r15
    b346:	41 bd 01 00 00 00    	mov    $0x1,%r13d
    b34c:	0f 1f 40 00          	nopl   0x0(%rax)
    b350:	40 f6 c6 01          	test   $0x1,%sil
    b354:	0f 85 86 00 00 00    	jne    b3e0 <fwp_p_loop_own+0x110>
    b35a:	48 89 c7             	mov    %rax,%rdi
    b35d:	48 2b 3d 34 7e 00 00 	sub    0x7e34(%rip),%rdi        # 13198 <fwp_gc+0x1030>
    b364:	48 8b 0d 55 7e 00 00 	mov    0x7e55(%rip),%rcx        # 131c0 <fwp_gc+0x1058>
    b36b:	48 c1 e1 10          	shl    $0x10,%rcx
    b36f:	48 39 cf             	cmp    %rcx,%rdi
    b372:	73 6c                	jae    b3e0 <fwp_p_loop_own+0x110>
    b374:	48 8b 0d 65 7e 00 00 	mov    0x7e65(%rip),%rcx        # 131e0 <fwp_gc+0x1078>
    b37b:	48 89 fa             	mov    %rdi,%rdx
    b37e:	48 c1 ea 10          	shr    $0x10,%rdx
    b382:	48 69 d2 28 12 00 00 	imul   $0x1228,%rdx,%rdx
    b389:	0f b6 34 11          	movzbl (%rcx,%rdx,1),%esi
    b38d:	48 81 e7 ff ff 00 00 	and    $0xffff,%rdi
    b394:	75 13                	jne    b3a9 <fwp_p_loop_own+0xd9>
    b396:	40 80 fe 02          	cmp    $0x2,%sil
    b39a:	75 0d                	jne    b3a9 <fwp_p_loop_own+0xd9>
    b39c:	48 8d 3c 11          	lea    (%rcx,%rdx,1),%rdi
    b3a0:	48 81 c7 28 02 00 00 	add    $0x228,%rdi
    b3a7:	eb 20                	jmp    b3c9 <fwp_p_loop_own+0xf9>
    b3a9:	40 80 fe 01          	cmp    $0x1,%sil
    b3ad:	75 31                	jne    b3e0 <fwp_p_loop_own+0x110>
    b3af:	48 8d 34 11          	lea    (%rcx,%rdx,1),%rsi
    b3b3:	8b 4c 11 20          	mov    0x20(%rcx,%rdx,1),%ecx
    b3b7:	48 0f af f9          	imul   %rcx,%rdi
    b3bb:	48 c1 ef 20          	shr    $0x20,%rdi
    b3bf:	48 01 f7             	add    %rsi,%rdi
    b3c2:	48 81 c7 28 02 00 00 	add    $0x228,%rdi
    b3c9:	0f b6 0f             	movzbl (%rdi),%ecx
    b3cc:	84 c9                	test   %cl,%cl
    b3ce:	74 10                	je     b3e0 <fwp_p_loop_own+0x110>
    b3d0:	80 f9 fe             	cmp    $0xfe,%cl
    b3d3:	0f 83 9f 00 00 00    	jae    b478 <fwp_p_loop_own+0x1a8>
    b3d9:	fe c1                	inc    %cl
    b3db:	88 0f                	mov    %cl,(%rdi)
    b3dd:	0f 1f 00             	nopl   (%rax)
    b3e0:	41 8b 1c 24          	mov    (%r12),%ebx
    b3e4:	8b 70 04             	mov    0x4(%rax),%esi
    b3e7:	29 f3                	sub    %esi,%ebx
    b3e9:	39 dd                	cmp    %ebx,%ebp
    b3eb:	41 89 dc             	mov    %ebx,%r12d
    b3ee:	44 0f 42 e5          	cmovb  %ebp,%r12d
    b3f2:	45 89 e6             	mov    %r12d,%r14d
    b3f5:	45 39 e5             	cmp    %r12d,%r13d
    b3f8:	45 0f 42 f5          	cmovb  %r13d,%r14d
    b3fc:	73 2d                	jae    b42b <fwp_p_loop_own+0x15b>
    b3fe:	44 89 e2             	mov    %r12d,%edx
    b401:	44 29 f2             	sub    %r14d,%edx
    b404:	4d 8b 00             	mov    (%r8),%r8
    b407:	44 89 f1             	mov    %r14d,%ecx
    b40a:	49 8d 3c cf          	lea    (%r15,%rcx,8),%rdi
    b40e:	44 01 f6             	add    %r14d,%esi
    b411:	4c 89 7c 24 10       	mov    %r15,0x10(%rsp)
    b416:	41 89 ef             	mov    %ebp,%r15d
    b419:	48 89 c5             	mov    %rax,%rbp
    b41c:	41 ff 50 10          	call   *0x10(%r8)
    b420:	48 89 e8             	mov    %rbp,%rax
    b423:	44 89 fd             	mov    %r15d,%ebp
    b426:	4c 8b 7c 24 10       	mov    0x10(%rsp),%r15
    b42b:	48 89 c7             	mov    %rax,%rdi
    b42e:	44 89 e6             	mov    %r12d,%esi
    b431:	4c 89 fa             	mov    %r15,%rdx
    b434:	e8 b7 08 00 00       	call   bcf0 <fwp_apply_owned>
    b439:	39 dd                	cmp    %ebx,%ebp
    b43b:	0f 86 bf 00 00 00    	jbe    b500 <fwp_p_loop_own+0x230>
    b441:	44 89 e1             	mov    %r12d,%ecx
    b444:	4d 8d 3c cf          	lea    (%r15,%rcx,8),%r15
    b448:	44 29 e5             	sub    %r12d,%ebp
    b44b:	45 29 f5             	sub    %r14d,%r13d
    b44e:	48 8b 0d 0b 93 00 00 	mov    0x930b(%rip),%rcx        # 14760 <fwp_fns>
    b455:	8b 10                	mov    (%rax),%edx
    b457:	48 c1 e2 05          	shl    $0x5,%rdx
    b45b:	4c 8d 24 11          	lea    (%rcx,%rdx,1),%r12
    b45f:	4c 8d 04 11          	lea    (%rcx,%rdx,1),%r8
    b463:	49 83 c0 18          	add    $0x18,%r8
    b467:	40 b6 01             	mov    $0x1,%sil
    b46a:	48 83 7c 11 18 00    	cmpq   $0x0,0x18(%rcx,%rdx,1)
    b470:	0f 85 da fe ff ff    	jne    b350 <fwp_p_loop_own+0x80>
    b476:	eb 23                	jmp    b49b <fwp_p_loop_own+0x1cb>
    b478:	48 89 c3             	mov    %rax,%rbx
    b47b:	4d 89 c6             	mov    %r8,%r14
    b47e:	e8 9d c7 ff ff       	call   7c20 <fwp_rc_wide_dup>
    b483:	4d 89 f0             	mov    %r14,%r8
    b486:	48 89 d8             	mov    %rbx,%rax
    b489:	e9 52 ff ff ff       	jmp    b3e0 <fwp_p_loop_own+0x110>
    b48e:	66 90                	xchg   %ax,%ax
    b490:	bd 01 00 00 00       	mov    $0x1,%ebp
    b495:	49 89 e7             	mov    %rsp,%r15
    b498:	4c 89 f0             	mov    %r14,%rax
    b49b:	4c 8b 1d f6 7c 00 00 	mov    0x7cf6(%rip),%r11        # 13198 <fwp_gc+0x1030>
    b4a2:	48 89 c2             	mov    %rax,%rdx
    b4a5:	4c 29 da             	sub    %r11,%rdx
    b4a8:	48 8b 0d 11 7d 00 00 	mov    0x7d11(%rip),%rcx        # 131c0 <fwp_gc+0x1058>
    b4af:	48 c1 e1 10          	shl    $0x10,%rcx
    b4b3:	48 39 ca             	cmp    %rcx,%rdx
    b4b6:	4c 8b 74 24 08       	mov    0x8(%rsp),%r14
    b4bb:	0f 83 8f 00 00 00    	jae    b550 <fwp_p_loop_own+0x280>
    b4c1:	48 8b 35 18 7d 00 00 	mov    0x7d18(%rip),%rsi        # 131e0 <fwp_gc+0x1078>
    b4c8:	48 89 d7             	mov    %rdx,%rdi
    b4cb:	48 c1 ef 10          	shr    $0x10,%rdi
    b4cf:	48 69 ff 28 12 00 00 	imul   $0x1228,%rdi,%rdi
    b4d6:	44 0f b6 04 3e       	movzbl (%rsi,%rdi,1),%r8d
    b4db:	48 81 e2 ff ff 00 00 	and    $0xffff,%rdx
    b4e2:	75 34                	jne    b518 <fwp_p_loop_own+0x248>
    b4e4:	41 80 f8 02          	cmp    $0x2,%r8b
    b4e8:	75 2e                	jne    b518 <fwp_p_loop_own+0x248>
    b4ea:	48 8d 14 3e          	lea    (%rsi,%rdi,1),%rdx
    b4ee:	48 81 c2 28 02 00 00 	add    $0x228,%rdx
    b4f5:	80 3a 00             	cmpb   $0x0,(%rdx)
    b4f8:	74 56                	je     b550 <fwp_p_loop_own+0x280>
    b4fa:	e9 f3 01 00 00       	jmp    b6f2 <fwp_p_loop_own+0x422>
    b4ff:	90                   	nop
    b500:	4c 8b 74 24 08       	mov    0x8(%rsp),%r14
    b505:	48 3d ff 0f 00 00    	cmp    $0xfff,%rax
    b50b:	0f 86 00 01 00 00    	jbe    b611 <fwp_p_loop_own+0x341>
    b511:	8b 08                	mov    (%rax),%ecx
    b513:	e9 fb 00 00 00       	jmp    b613 <fwp_p_loop_own+0x343>
    b518:	41 80 f8 01          	cmp    $0x1,%r8b
    b51c:	75 32                	jne    b550 <fwp_p_loop_own+0x280>
    b51e:	4c 8d 04 3e          	lea    (%rsi,%rdi,1),%r8
    b522:	8b 74 3e 20          	mov    0x20(%rsi,%rdi,1),%esi
    b526:	48 0f af d6          	imul   %rsi,%rdx
    b52a:	48 c1 ea 20          	shr    $0x20,%rdx
    b52e:	4c 01 c2             	add    %r8,%rdx
    b531:	48 81 c2 28 02 00 00 	add    $0x228,%rdx
    b538:	80 3a 00             	cmpb   $0x0,(%rdx)
    b53b:	0f 85 b1 01 00 00    	jne    b6f2 <fwp_p_loop_own+0x422>
    b541:	66 66 66 66 66 66 2e 	data16 data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    b548:	0f 1f 84 00 00 00 00 
    b54f:	00 
    b550:	85 ed                	test   %ebp,%ebp
    b552:	0f 84 a0 00 00 00    	je     b5f8 <fwp_p_loop_own+0x328>
    b558:	48 8b 15 81 7c 00 00 	mov    0x7c81(%rip),%rdx        # 131e0 <fwp_gc+0x1078>
    b55f:	89 ee                	mov    %ebp,%esi
    b561:	31 ff                	xor    %edi,%edi
    b563:	eb 2b                	jmp    b590 <fwp_p_loop_own+0x2c0>
    b565:	66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
    b56c:	00 00 00 00 
    b570:	4e 8d 04 0a          	lea    (%rdx,%r9,1),%r8
    b574:	49 81 c0 28 02 00 00 	add    $0x228,%r8
    b57b:	41 80 38 00          	cmpb   $0x0,(%r8)
    b57f:	74 6f                	je     b5f0 <fwp_p_loop_own+0x320>
    b581:	e9 6c 01 00 00       	jmp    b6f2 <fwp_p_loop_own+0x422>
    b586:	66 2e 0f 1f 84 00 00 	cs nopw 0x0(%rax,%rax,1)
    b58d:	00 00 00 
    b590:	4d 8b 04 ff          	mov    (%r15,%rdi,8),%r8
    b594:	4d 29 d8             	sub    %r11,%r8
    b597:	49 39 c8             	cmp    %rcx,%r8
    b59a:	73 54                	jae    b5f0 <fwp_p_loop_own+0x320>
    b59c:	4d 89 c1             	mov    %r8,%r9
    b59f:	49 c1 e9 10          	shr    $0x10,%r9
    b5a3:	4d 69 c9 28 12 00 00 	imul   $0x1228,%r9,%r9
    b5aa:	46 0f b6 14 0a       	movzbl (%rdx,%r9,1),%r10d
    b5af:	49 81 e0 ff ff 00 00 	and    $0xffff,%r8
    b5b6:	75 06                	jne    b5be <fwp_p_loop_own+0x2ee>
    b5b8:	41 80 fa 02          	cmp    $0x2,%r10b
    b5bc:	74 b2                	je     b570 <fwp_p_loop_own+0x2a0>
    b5be:	41 80 fa 01          	cmp    $0x1,%r10b
    b5c2:	75 2c                	jne    b5f0 <fwp_p_loop_own+0x320>
    b5c4:	4e 8d 14 0a          	lea    (%rdx,%r9,1),%r10
    b5c8:	46 8b 4c 0a 20       	mov    0x20(%rdx,%r9,1),%r9d
    b5cd:	4d 0f af c1          	imul   %r9,%r8
    b5d1:	49 c1 e8 20          	shr    $0x20,%r8
    b5d5:	4d 01 d0             	add    %r10,%r8
    b5d8:	49 81 c0 28 02 00 00 	add    $0x228,%r8
    b5df:	41 80 38 00          	cmpb   $0x0,(%r8)
    b5e3:	0f 85 09 01 00 00    	jne    b6f2 <fwp_p_loop_own+0x422>
    b5e9:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)
    b5f0:	48 ff c7             	inc    %rdi
    b5f3:	48 39 fe             	cmp    %rdi,%rsi
    b5f6:	75 98                	jne    b590 <fwp_p_loop_own+0x2c0>
    b5f8:	48 89 c7             	mov    %rax,%rdi
    b5fb:	89 ee                	mov    %ebp,%esi
    b5fd:	4c 89 fa             	mov    %r15,%rdx
    b600:	e8 8b 01 00 00       	call   b790 <fwp_apply>
    b605:	48 3d ff 0f 00 00    	cmp    $0xfff,%rax
    b60b:	0f 87 00 ff ff ff    	ja     b511 <fwp_p_loop_own+0x241>
    b611:	89 c1                	mov    %eax,%ecx
    b613:	48 8b 70 08          	mov    0x8(%rax),%rsi
    b617:	85 c9                	test   %ecx,%ecx
    b619:	0f 85 bc 00 00 00    	jne    b6db <fwp_p_loop_own+0x40b>
    b61f:	48 89 f0             	mov    %rsi,%rax
    b622:	48 2b 05 6f 7b 00 00 	sub    0x7b6f(%rip),%rax        # 13198 <fwp_gc+0x1030>
    b629:	48 8b 0d 90 7b 00 00 	mov    0x7b90(%rip),%rcx        # 131c0 <fwp_gc+0x1058>
    b630:	48 c1 e1 10          	shl    $0x10,%rcx
    b634:	48 39 c8             	cmp    %rcx,%rax
    b637:	0f 83 b7 fc ff ff    	jae    b2f4 <fwp_p_loop_own+0x24>
    b63d:	48 8b 0d 9c 7b 00 00 	mov    0x7b9c(%rip),%rcx        # 131e0 <fwp_gc+0x1078>
    b644:	48 89 c2             	mov    %rax,%rdx
    b647:	48 c1 ea 10          	shr    $0x10,%rdx
    b64b:	48 69 d2 28 12 00 00 	imul   $0x1228,%rdx,%rdx
    b652:	0f b6 3c 11          	movzbl (%rcx,%rdx,1),%edi
    b656:	48 25 ff ff 00 00    	and    $0xffff,%rax
    b65c:	75 22                	jne    b680 <fwp_p_loop_own+0x3b0>
    b65e:	40 80 ff 02          	cmp    $0x2,%dil
    b662:	75 1c                	jne    b680 <fwp_p_loop_own+0x3b0>
    b664:	48 8d 3c 11          	lea    (%rcx,%rdx,1),%rdi
    b668:	48 81 c7 28 02 00 00 	add    $0x228,%rdi
    b66f:	eb 33                	jmp    b6a4 <fwp_p_loop_own+0x3d4>
    b671:	66 66 66 66 66 66 2e 	data16 data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    b678:	0f 1f 84 00 00 00 00 
    b67f:	00 
    b680:	40 80 ff 01          	cmp    $0x1,%dil
    b684:	0f 85 6a fc ff ff    	jne    b2f4 <fwp_p_loop_own+0x24>
    b68a:	48 8d 3c 11          	lea    (%rcx,%rdx,1),%rdi
    b68e:	8b 4c 11 20          	mov    0x20(%rcx,%rdx,1),%ecx
    b692:	48 0f af c1          	imul   %rcx,%rax
    b696:	48 c1 e8 20          	shr    $0x20,%rax
    b69a:	48 01 c7             	add    %rax,%rdi
    b69d:	48 81 c7 28 02 00 00 	add    $0x228,%rdi
    b6a4:	0f b6 07             	movzbl (%rdi),%eax
    b6a7:	84 c0                	test   %al,%al
    b6a9:	0f 84 45 fc ff ff    	je     b2f4 <fwp_p_loop_own+0x24>
    b6af:	3c fe                	cmp    $0xfe,%al
    b6b1:	0f 82 39 fc ff ff    	jb     b2f0 <fwp_p_loop_own+0x20>
    b6b7:	48 89 f3             	mov    %rsi,%rbx
    b6ba:	e8 61 c5 ff ff       	call   7c20 <fwp_rc_wide_dup>
    b6bf:	48 89 de             	mov    %rbx,%rsi
    b6c2:	48 89 1c 24          	mov    %rbx,(%rsp)
    b6c6:	e9 2d fc ff ff       	jmp    b2f8 <fwp_p_loop_own+0x28>
    b6cb:	48 89 f3             	mov    %rsi,%rbx
    b6ce:	e8 4d 00 00 00       	call   b720 <fwp_preempt>
    b6d3:	48 89 de             	mov    %rbx,%rsi
    b6d6:	e9 35 fc ff ff       	jmp    b310 <fwp_p_loop_own+0x40>
    b6db:	48 89 34 24          	mov    %rsi,(%rsp)
    b6df:	48 8b 04 24          	mov    (%rsp),%rax
    b6e3:	48 83 c4 18          	add    $0x18,%rsp
    b6e7:	5b                   	pop    %rbx
    b6e8:	41 5c                	pop    %r12
    b6ea:	41 5d                	pop    %r13
    b6ec:	41 5e                	pop    %r14
    b6ee:	41 5f                	pop    %r15
    b6f0:	5d                   	pop    %rbp
    b6f1:	c3                   	ret
    b6f2:	e8 69 b3 ff ff       	call   6a60 <fwp_flush>
    b6f7:	48 8b 05 e2 68 00 00 	mov    0x68e2(%rip),%rax        # 11fe0 <stderr@GLIBC_2.2.5>
    b6fe:	48 8b 38             	mov    (%rax),%rdi
    b701:	48 8d 35 c5 3d 00 00 	lea    0x3dc5(%rip),%rsi        # f4cd <fwp_segv.msg+0x24d>
    b708:	48 8d 15 91 3d 00 00 	lea    0x3d91(%rip),%rdx        # f4a0 <fwp_segv.msg+0x220>
    b70f:	31 c0                	xor    %eax,%eax
    b711:	e8 8a 6a ff ff       	call   21a0 <fprintf@plt>
    b716:	bf 65 00 00 00       	mov    $0x65,%edi
    b71b:	e8 50 6b ff ff       	call   2270 <exit@plt>

000000000000b720 <fwp_preempt>:
    b720:	8b 0d 72 90 00 00    	mov    0x9072(%rip),%ecx        # 14798 <fwp_slice>
    b726:	85 c9                	test   %ecx,%ecx
    b728:	74 07                	je     b731 <fwp_preempt+0x11>
    b72a:	89 0d 64 90 00 00    	mov    %ecx,0x9064(%rip)        # 14794 <fwp_budget>
    b730:	c3                   	ret
    b731:	50                   	push   %rax
    b732:	48 8d 3d 17 40 00 00 	lea    0x4017(%rip),%rdi        # f750 <fwp_segv.msg+0x4d0>
    b739:	e8 f2 68 ff ff       	call   2030 <getenv@plt>
    b73e:	48 89 c7             	mov    %rax,%rdi
    b741:	b8 10 27 00 00       	mov    $0x2710,%eax
    b746:	48 85 ff             	test   %rdi,%rdi
    b749:	74 11                	je     b75c <fwp_preempt+0x3c>
    b74b:	80 3f 00             	cmpb   $0x0,(%rdi)
    b74e:	74 0c                	je     b75c <fwp_preempt+0x3c>
    b750:	31 f6                	xor    %esi,%esi
    b752:	ba 0a 00 00 00       	mov    $0xa,%edx
    b757:	e8 34 6a ff ff       	call   2190 <strtoll@plt>
    b75c:	48 8d 88 00 00 00 80 	lea    -0x80000000(%rax),%rcx
    b763:	48 81 f9 01 00 00 80 	cmp    $0xffffffff80000001,%rcx
    b76a:	b9 ff ff ff 7f       	mov    $0x7fffffff,%ecx
    b76f:	0f 43 c8             	cmovae %eax,%ecx
    b772:	89 0d 20 90 00 00    	mov    %ecx,0x9020(%rip)        # 14798 <fwp_slice>
    b778:	48 83 c4 08          	add    $0x8,%rsp
    b77c:	89 0d 12 90 00 00    	mov    %ecx,0x9012(%rip)        # 14794 <fwp_budget>
    b782:	c3                   	ret
    b783:	66 66 66 66 2e 0f 1f 	data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    b78a:	84 00 00 00 00 00 

000000000000b790 <fwp_apply>:
    b790:	55                   	push   %rbp
    b791:	48 89 e5             	mov    %rsp,%rbp
    b794:	41 57                	push   %r15
    b796:	41 56                	push   %r14
    b798:	41 55                	push   %r13
    b79a:	41 54                	push   %r12
    b79c:	53                   	push   %rbx
    b79d:	48 83 ec 18          	sub    $0x18,%rsp
    b7a1:	48 89 d3             	mov    %rdx,%rbx
    b7a4:	49 89 ff             	mov    %rdi,%r15
    b7a7:	eb 23                	jmp    b7cc <fwp_apply+0x3c>
    b7a9:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)
    b7b0:	4a 8d 1c f3          	lea    (%rbx,%r14,8),%rbx
    b7b4:	31 c9                	xor    %ecx,%ecx
    b7b6:	49 89 c7             	mov    %rax,%r15
    b7b9:	4c 8b 75 c8          	mov    -0x38(%rbp),%r14
    b7bd:	48 8b 65 c0          	mov    -0x40(%rbp),%rsp
    b7c1:	89 d6                	mov    %edx,%esi
    b7c3:	83 f9 01             	cmp    $0x1,%ecx
    b7c6:	0f 84 aa 04 00 00    	je     bc76 <fwp_apply+0x4e6>
    b7cc:	48 8b 05 8d 8f 00 00 	mov    0x8f8d(%rip),%rax        # 14760 <fwp_fns>
    b7d3:	41 8b 0f             	mov    (%r15),%ecx
    b7d6:	45 8b 6f 04          	mov    0x4(%r15),%r13d
    b7da:	48 c1 e1 05          	shl    $0x5,%rcx
    b7de:	44 8b 24 08          	mov    (%rax,%rcx,1),%r12d
    b7e2:	4d 85 ed             	test   %r13,%r13
    b7e5:	75 39                	jne    b820 <fwp_apply+0x90>
    b7e7:	41 8d 54 24 ff       	lea    -0x1(%r12),%edx
    b7ec:	39 f2                	cmp    %esi,%edx
    b7ee:	73 30                	jae    b820 <fwp_apply+0x90>
    b7f0:	48 89 df             	mov    %rbx,%rdi
    b7f3:	49 89 f7             	mov    %rsi,%r15
    b7f6:	ff 54 08 08          	call   *0x8(%rax,%rcx,1)
    b7fa:	4c 89 fe             	mov    %r15,%rsi
    b7fd:	49 89 c7             	mov    %rax,%r15
    b800:	44 39 e6             	cmp    %r12d,%esi
    b803:	0f 84 a4 02 00 00    	je     baad <fwp_apply+0x31d>
    b809:	4a 8d 1c e3          	lea    (%rbx,%r12,8),%rbx
    b80d:	44 29 e6             	sub    %r12d,%esi
    b810:	b9 03 00 00 00       	mov    $0x3,%ecx
    b815:	83 f9 01             	cmp    $0x1,%ecx
    b818:	75 b2                	jne    b7cc <fwp_apply+0x3c>
    b81a:	e9 57 04 00 00       	jmp    bc76 <fwp_apply+0x4e6>
    b81f:	90                   	nop
    b820:	4c 89 75 c8          	mov    %r14,-0x38(%rbp)
    b824:	46 8d 34 2e          	lea    (%rsi,%r13,1),%r14d
    b828:	45 39 e6             	cmp    %r12d,%r14d
    b82b:	48 89 75 d0          	mov    %rsi,-0x30(%rbp)
    b82f:	0f 82 1a 02 00 00    	jb     ba4f <fwp_apply+0x2bf>
    b835:	48 89 65 c0          	mov    %rsp,-0x40(%rbp)
    b839:	45 89 e3             	mov    %r12d,%r11d
    b83c:	41 83 fc 02          	cmp    $0x2,%r12d
    b840:	ba 01 00 00 00       	mov    $0x1,%edx
    b845:	41 0f 43 d4          	cmovae %r12d,%edx
    b849:	48 8d 14 d5 0f 00 00 	lea    0xf(,%rdx,8),%rdx
    b850:	00 
    b851:	48 83 e2 f0          	and    $0xfffffffffffffff0,%rdx
    b855:	48 89 e7             	mov    %rsp,%rdi
    b858:	48 29 d7             	sub    %rdx,%rdi
    b85b:	48 89 fc             	mov    %rdi,%rsp
    b85e:	4d 85 ed             	test   %r13,%r13
    b861:	0f 84 c9 00 00 00    	je     b930 <fwp_apply+0x1a0>
    b867:	41 83 fd 04          	cmp    $0x4,%r13d
    b86b:	72 10                	jb     b87d <fwp_apply+0xed>
    b86d:	48 89 fa             	mov    %rdi,%rdx
    b870:	4c 29 fa             	sub    %r15,%rdx
    b873:	48 83 c2 f8          	add    $0xfffffffffffffff8,%rdx
    b877:	48 83 fa 20          	cmp    $0x20,%rdx
    b87b:	73 65                	jae    b8e2 <fwp_apply+0x152>
    b87d:	31 d2                	xor    %edx,%edx
    b87f:	4d 89 e8             	mov    %r13,%r8
    b882:	49 89 d2             	mov    %rdx,%r10
    b885:	49 83 e0 03          	and    $0x3,%r8
    b889:	74 16                	je     b8a1 <fwp_apply+0x111>
    b88b:	49 89 d2             	mov    %rdx,%r10
    b88e:	66 90                	xchg   %ax,%ax
    b890:	4f 8b 4c d7 08       	mov    0x8(%r15,%r10,8),%r9
    b895:	4e 89 0c d7          	mov    %r9,(%rdi,%r10,8)
    b899:	49 ff c2             	inc    %r10
    b89c:	49 ff c8             	dec    %r8
    b89f:	75 ef                	jne    b890 <fwp_apply+0x100>
    b8a1:	4c 29 ea             	sub    %r13,%rdx
    b8a4:	48 83 fa fc          	cmp    $0xfffffffffffffffc,%rdx
    b8a8:	0f 87 82 00 00 00    	ja     b930 <fwp_apply+0x1a0>
    b8ae:	66 90                	xchg   %ax,%ax
    b8b0:	4b 8b 54 d7 08       	mov    0x8(%r15,%r10,8),%rdx
    b8b5:	4a 89 14 d7          	mov    %rdx,(%rdi,%r10,8)
    b8b9:	4b 8b 54 d7 10       	mov    0x10(%r15,%r10,8),%rdx
    b8be:	4a 89 54 d7 08       	mov    %rdx,0x8(%rdi,%r10,8)
    b8c3:	4b 8b 54 d7 18       	mov    0x18(%r15,%r10,8),%rdx
    b8c8:	4a 89 54 d7 10       	mov    %rdx,0x10(%rdi,%r10,8)
    b8cd:	4b 8b 54 d7 20       	mov    0x20(%r15,%r10,8),%rdx
    b8d2:	4a 89 54 d7 18       	mov    %rdx,0x18(%rdi,%r10,8)
    b8d7:	49 83 c2 04          	add    $0x4,%r10
    b8db:	4d 39 d5             	cmp    %r10,%r13
    b8de:	75 d0                	jne    b8b0 <fwp_apply+0x120>
    b8e0:	eb 4e                	jmp    b930 <fwp_apply+0x1a0>
    b8e2:	44 89 ea             	mov    %r13d,%edx
    b8e5:	83 e2 fc             	and    $0xfffffffc,%edx
    b8e8:	4e 8d 0c ed 00 00 00 	lea    0x0(,%r13,8),%r9
    b8ef:	00 
    b8f0:	49 83 e1 e0          	and    $0xffffffffffffffe0,%r9
    b8f4:	45 31 c0             	xor    %r8d,%r8d
    b8f7:	66 0f 1f 84 00 00 00 	nopw   0x0(%rax,%rax,1)
    b8fe:	00 00 
    b900:	43 0f 10 44 07 08    	movups 0x8(%r15,%r8,1),%xmm0
    b906:	43 0f 10 4c 07 18    	movups 0x18(%r15,%r8,1),%xmm1
    b90c:	42 0f 29 04 07       	movaps %xmm0,(%rdi,%r8,1)
    b911:	42 0f 29 4c 07 10    	movaps %xmm1,0x10(%rdi,%r8,1)
    b917:	49 83 c0 20          	add    $0x20,%r8
    b91b:	4d 39 c1             	cmp    %r8,%r9
    b91e:	75 e0                	jne    b900 <fwp_apply+0x170>
    b920:	4c 39 ea             	cmp    %r13,%rdx
    b923:	0f 85 56 ff ff ff    	jne    b87f <fwp_apply+0xef>
    b929:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)
    b930:	45 29 eb             	sub    %r13d,%r11d
    b933:	45 89 de             	mov    %r11d,%r14d
    b936:	45 39 ec             	cmp    %r13d,%r12d
    b939:	0f 84 85 00 00 00    	je     b9c4 <fwp_apply+0x234>
    b93f:	41 83 fb 0e          	cmp    $0xe,%r11d
    b943:	0f 83 a0 00 00 00    	jae    b9e9 <fwp_apply+0x259>
    b949:	31 d2                	xor    %edx,%edx
    b94b:	4d 89 f0             	mov    %r14,%r8
    b94e:	48 89 d6             	mov    %rdx,%rsi
    b951:	49 83 e0 03          	and    $0x3,%r8
    b955:	74 1d                	je     b974 <fwp_apply+0x1e4>
    b957:	48 89 d6             	mov    %rdx,%rsi
    b95a:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)
    b960:	4c 8b 0c f3          	mov    (%rbx,%rsi,8),%r9
    b964:	46 8d 14 2e          	lea    (%rsi,%r13,1),%r10d
    b968:	4e 89 0c d7          	mov    %r9,(%rdi,%r10,8)
    b96c:	48 ff c6             	inc    %rsi
    b96f:	49 ff c8             	dec    %r8
    b972:	75 ec                	jne    b960 <fwp_apply+0x1d0>
    b974:	4c 29 f2             	sub    %r14,%rdx
    b977:	48 83 fa fc          	cmp    $0xfffffffffffffffc,%rdx
    b97b:	77 47                	ja     b9c4 <fwp_apply+0x234>
    b97d:	0f 1f 00             	nopl   (%rax)
    b980:	48 8b 14 f3          	mov    (%rbx,%rsi,8),%rdx
    b984:	46 8d 04 2e          	lea    (%rsi,%r13,1),%r8d
    b988:	4a 89 14 c7          	mov    %rdx,(%rdi,%r8,8)
    b98c:	48 8b 54 f3 08       	mov    0x8(%rbx,%rsi,8),%rdx
    b991:	46 8d 04 2e          	lea    (%rsi,%r13,1),%r8d
    b995:	41 ff c0             	inc    %r8d
    b998:	4a 89 14 c7          	mov    %rdx,(%rdi,%r8,8)
    b99c:	48 8b 54 f3 10       	mov    0x10(%rbx,%rsi,8),%rdx
    b9a1:	45 8d 44 35 02       	lea    0x2(%r13,%rsi,1),%r8d
    b9a6:	4a 89 14 c7          	mov    %rdx,(%rdi,%r8,8)
    b9aa:	48 8b 54 f3 18       	mov    0x18(%rbx,%rsi,8),%rdx
    b9af:	46 8d 04 2e          	lea    (%rsi,%r13,1),%r8d
    b9b3:	41 83 c0 03          	add    $0x3,%r8d
    b9b7:	4a 89 14 c7          	mov    %rdx,(%rdi,%r8,8)
    b9bb:	48 83 c6 04          	add    $0x4,%rsi
    b9bf:	49 39 f6             	cmp    %rsi,%r14
    b9c2:	75 bc                	jne    b980 <fwp_apply+0x1f0>
    b9c4:	45 89 dc             	mov    %r11d,%r12d
    b9c7:	ff 54 08 08          	call   *0x8(%rax,%rcx,1)
    b9cb:	b9 01 00 00 00       	mov    $0x1,%ecx
    b9d0:	48 8b 75 d0          	mov    -0x30(%rbp),%rsi
    b9d4:	89 f2                	mov    %esi,%edx
    b9d6:	44 29 e2             	sub    %r12d,%edx
    b9d9:	0f 85 d1 fd ff ff    	jne    b7b0 <fwp_apply+0x20>
    b9df:	89 f2                	mov    %esi,%edx
    b9e1:	49 89 c6             	mov    %rax,%r14
    b9e4:	e9 d4 fd ff ff       	jmp    b7bd <fwp_apply+0x2d>
    b9e9:	49 8d 56 ff          	lea    -0x1(%r14),%rdx
    b9ed:	89 d6                	mov    %edx,%esi
    b9ef:	44 01 ee             	add    %r13d,%esi
    b9f2:	0f 82 51 ff ff ff    	jb     b949 <fwp_apply+0x1b9>
    b9f8:	48 c1 ea 20          	shr    $0x20,%rdx
    b9fc:	ba 00 00 00 00       	mov    $0x0,%edx
    ba01:	0f 85 44 ff ff ff    	jne    b94b <fwp_apply+0x1bb>
    ba07:	4a 8d 14 ef          	lea    (%rdi,%r13,8),%rdx
    ba0b:	48 29 da             	sub    %rbx,%rdx
    ba0e:	48 83 fa 20          	cmp    $0x20,%rdx
    ba12:	0f 82 31 ff ff ff    	jb     b949 <fwp_apply+0x1b9>
    ba18:	44 89 f2             	mov    %r14d,%edx
    ba1b:	83 e2 fc             	and    $0xfffffffc,%edx
    ba1e:	31 f6                	xor    %esi,%esi
    ba20:	0f 10 04 f3          	movups (%rbx,%rsi,8),%xmm0
    ba24:	0f 10 4c f3 10       	movups 0x10(%rbx,%rsi,8),%xmm1
    ba29:	46 8d 04 2e          	lea    (%rsi,%r13,1),%r8d
    ba2d:	42 0f 11 04 c7       	movups %xmm0,(%rdi,%r8,8)
    ba32:	42 0f 11 4c c7 10    	movups %xmm1,0x10(%rdi,%r8,8)
    ba38:	48 83 c6 04          	add    $0x4,%rsi
    ba3c:	48 39 f2             	cmp    %rsi,%rdx
    ba3f:	75 df                	jne    ba20 <fwp_apply+0x290>
    ba41:	4c 39 f2             	cmp    %r14,%rdx
    ba44:	0f 85 01 ff ff ff    	jne    b94b <fwp_apply+0x1bb>
    ba4a:	e9 75 ff ff ff       	jmp    b9c4 <fwp_apply+0x234>
    ba4f:	44 89 f0             	mov    %r14d,%eax
    ba52:	41 81 fe ff 07 00 00 	cmp    $0x7ff,%r14d
    ba59:	77 72                	ja     bacd <fwp_apply+0x33d>
    ba5b:	48 8d 14 c5 00 00 00 	lea    0x0(,%rax,8),%rdx
    ba62:	00 
    ba63:	48 83 c2 17          	add    $0x17,%rdx
    ba67:	48 c1 ea 04          	shr    $0x4,%rdx
    ba6b:	48 8d 0d f6 66 00 00 	lea    0x66f6(%rip),%rcx        # 12168 <fwp_gc>
    ba72:	0f b6 bc 0a e8 0b 00 	movzbl 0xbe8(%rdx,%rcx,1),%edi
    ba79:	00 
    ba7a:	8b 94 b9 48 0b 00 00 	mov    0xb48(%rcx,%rdi,4),%edx
    ba81:	48 29 15 e0 66 00 00 	sub    %rdx,0x66e0(%rip)        # 12168 <fwp_gc>
    ba88:	78 43                	js     bacd <fwp_apply+0x33d>
    ba8a:	4c 8d 04 7f          	lea    (%rdi,%rdi,2),%r8
    ba8e:	4a 8d 3c c1          	lea    (%rcx,%r8,8),%rdi
    ba92:	48 81 c7 88 07 00 00 	add    $0x788,%rdi
    ba99:	4c 8b 27             	mov    (%rdi),%r12
    ba9c:	4d 85 e4             	test   %r12,%r12
    ba9f:	74 14                	je     bab5 <fwp_apply+0x325>
    baa1:	49 8b 04 24          	mov    (%r12),%rax
    baa5:	48 f7 d0             	not    %rax
    baa8:	48 89 07             	mov    %rax,(%rdi)
    baab:	eb 48                	jmp    baf5 <fwp_apply+0x365>
    baad:	4d 89 fe             	mov    %r15,%r14
    bab0:	e9 c1 01 00 00       	jmp    bc76 <fwp_apply+0x4e6>
    bab5:	4e 8b a4 c1 90 07 00 	mov    0x790(%rcx,%r8,8),%r12
    babc:	00 
    babd:	4a 8b bc c1 98 07 00 	mov    0x798(%rcx,%r8,8),%rdi
    bac4:	00 
    bac5:	4c 29 e7             	sub    %r12,%rdi
    bac8:	48 39 d7             	cmp    %rdx,%rdi
    bacb:	73 17                	jae    bae4 <fwp_apply+0x354>
    bacd:	48 8d 3c c5 08 00 00 	lea    0x8(,%rax,8),%rdi
    bad4:	00 
    bad5:	be 02 00 00 00       	mov    $0x2,%esi
    bada:	e8 21 b4 ff ff       	call   6f00 <fwp_gc_alloc_slow>
    badf:	49 89 c4             	mov    %rax,%r12
    bae2:	eb 1b                	jmp    baff <fwp_apply+0x36f>
    bae4:	4a 8d 04 c1          	lea    (%rcx,%r8,8),%rax
    bae8:	48 05 90 07 00 00    	add    $0x790,%rax
    baee:	49 8d 0c 14          	lea    (%r12,%rdx,1),%rcx
    baf2:	48 89 08             	mov    %rcx,(%rax)
    baf5:	4c 89 e7             	mov    %r12,%rdi
    baf8:	31 f6                	xor    %esi,%esi
    bafa:	e8 21 66 ff ff       	call   2120 <memset@plt>
    baff:	41 8b 07             	mov    (%r15),%eax
    bb02:	41 89 04 24          	mov    %eax,(%r12)
    bb06:	45 89 74 24 04       	mov    %r14d,0x4(%r12)
    bb0b:	4d 85 ed             	test   %r13,%r13
    bb0e:	4d 89 e6             	mov    %r12,%r14
    bb11:	48 8b 7d d0          	mov    -0x30(%rbp),%rdi
    bb15:	0f 84 c6 00 00 00    	je     bbe1 <fwp_apply+0x451>
    bb1b:	31 c0                	xor    %eax,%eax
    bb1d:	41 83 fd 06          	cmp    $0x6,%r13d
    bb21:	72 53                	jb     bb76 <fwp_apply+0x3e6>
    bb23:	4c 89 f1             	mov    %r14,%rcx
    bb26:	4c 29 f9             	sub    %r15,%rcx
    bb29:	48 83 f9 20          	cmp    $0x20,%rcx
    bb2d:	72 47                	jb     bb76 <fwp_apply+0x3e6>
    bb2f:	44 89 e8             	mov    %r13d,%eax
    bb32:	83 e0 fc             	and    $0xfffffffc,%eax
    bb35:	4a 8d 0c ed 00 00 00 	lea    0x0(,%r13,8),%rcx
    bb3c:	00 
    bb3d:	48 83 e1 e0          	and    $0xffffffffffffffe0,%rcx
    bb41:	31 d2                	xor    %edx,%edx
    bb43:	66 66 66 66 2e 0f 1f 	data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    bb4a:	84 00 00 00 00 00 
    bb50:	41 0f 10 44 17 08    	movups 0x8(%r15,%rdx,1),%xmm0
    bb56:	41 0f 10 4c 17 18    	movups 0x18(%r15,%rdx,1),%xmm1
    bb5c:	41 0f 11 44 16 08    	movups %xmm0,0x8(%r14,%rdx,1)
    bb62:	41 0f 11 4c 16 18    	movups %xmm1,0x18(%r14,%rdx,1)
    bb68:	48 83 c2 20          	add    $0x20,%rdx
    bb6c:	48 39 d1             	cmp    %rdx,%rcx
    bb6f:	75 df                	jne    bb50 <fwp_apply+0x3c0>
    bb71:	4c 39 e8             	cmp    %r13,%rax
    bb74:	74 6b                	je     bbe1 <fwp_apply+0x451>
    bb76:	4c 89 ea             	mov    %r13,%rdx
    bb79:	48 89 c1             	mov    %rax,%rcx
    bb7c:	48 83 e2 03          	and    $0x3,%rdx
    bb80:	74 20                	je     bba2 <fwp_apply+0x412>
    bb82:	48 89 c1             	mov    %rax,%rcx
    bb85:	66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
    bb8c:	00 00 00 00 
    bb90:	49 8b 74 cf 08       	mov    0x8(%r15,%rcx,8),%rsi
    bb95:	49 89 74 ce 08       	mov    %rsi,0x8(%r14,%rcx,8)
    bb9a:	48 ff c1             	inc    %rcx
    bb9d:	48 ff ca             	dec    %rdx
    bba0:	75 ee                	jne    bb90 <fwp_apply+0x400>
    bba2:	4c 29 e8             	sub    %r13,%rax
    bba5:	48 83 f8 fc          	cmp    $0xfffffffffffffffc,%rax
    bba9:	77 36                	ja     bbe1 <fwp_apply+0x451>
    bbab:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)
    bbb0:	49 8b 44 cf 08       	mov    0x8(%r15,%rcx,8),%rax
    bbb5:	49 89 44 ce 08       	mov    %rax,0x8(%r14,%rcx,8)
    bbba:	49 8b 44 cf 10       	mov    0x10(%r15,%rcx,8),%rax
    bbbf:	49 89 44 ce 10       	mov    %rax,0x10(%r14,%rcx,8)
    bbc4:	49 8b 44 cf 18       	mov    0x18(%r15,%rcx,8),%rax
    bbc9:	49 89 44 ce 18       	mov    %rax,0x18(%r14,%rcx,8)
    bbce:	49 8b 44 cf 20       	mov    0x20(%r15,%rcx,8),%rax
    bbd3:	49 89 44 ce 20       	mov    %rax,0x20(%r14,%rcx,8)
    bbd8:	48 83 c1 04          	add    $0x4,%rcx
    bbdc:	49 39 cd             	cmp    %rcx,%r13
    bbdf:	75 cf                	jne    bbb0 <fwp_apply+0x420>
    bbe1:	85 ff                	test   %edi,%edi
    bbe3:	0f 84 8d 00 00 00    	je     bc76 <fwp_apply+0x4e6>
    bbe9:	89 f8                	mov    %edi,%eax
    bbeb:	83 ff 14             	cmp    $0x14,%edi
    bbee:	0f 83 94 00 00 00    	jae    bc88 <fwp_apply+0x4f8>
    bbf4:	31 c9                	xor    %ecx,%ecx
    bbf6:	48 89 c6             	mov    %rax,%rsi
    bbf9:	48 89 ca             	mov    %rcx,%rdx
    bbfc:	48 83 e6 03          	and    $0x3,%rsi
    bc00:	74 23                	je     bc25 <fwp_apply+0x495>
    bc02:	48 89 ca             	mov    %rcx,%rdx
    bc05:	66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
    bc0c:	00 00 00 00 
    bc10:	48 8b 3c d3          	mov    (%rbx,%rdx,8),%rdi
    bc14:	46 8d 04 2a          	lea    (%rdx,%r13,1),%r8d
    bc18:	4b 89 7c c6 08       	mov    %rdi,0x8(%r14,%r8,8)
    bc1d:	48 ff c2             	inc    %rdx
    bc20:	48 ff ce             	dec    %rsi
    bc23:	75 eb                	jne    bc10 <fwp_apply+0x480>
    bc25:	48 29 c1             	sub    %rax,%rcx
    bc28:	48 83 f9 fc          	cmp    $0xfffffffffffffffc,%rcx
    bc2c:	77 48                	ja     bc76 <fwp_apply+0x4e6>
    bc2e:	66 90                	xchg   %ax,%ax
    bc30:	48 8b 0c d3          	mov    (%rbx,%rdx,8),%rcx
    bc34:	42 8d 34 2a          	lea    (%rdx,%r13,1),%esi
    bc38:	49 89 4c f6 08       	mov    %rcx,0x8(%r14,%rsi,8)
    bc3d:	48 8b 4c d3 08       	mov    0x8(%rbx,%rdx,8),%rcx
    bc42:	42 8d 34 2a          	lea    (%rdx,%r13,1),%esi
    bc46:	ff c6                	inc    %esi
    bc48:	49 89 4c f6 08       	mov    %rcx,0x8(%r14,%rsi,8)
    bc4d:	48 8b 4c d3 10       	mov    0x10(%rbx,%rdx,8),%rcx
    bc52:	41 8d 74 15 02       	lea    0x2(%r13,%rdx,1),%esi
    bc57:	49 89 4c f6 08       	mov    %rcx,0x8(%r14,%rsi,8)
    bc5c:	48 8b 4c d3 18       	mov    0x18(%rbx,%rdx,8),%rcx
    bc61:	42 8d 34 2a          	lea    (%rdx,%r13,1),%esi
    bc65:	83 c6 03             	add    $0x3,%esi
    bc68:	49 89 4c f6 08       	mov    %rcx,0x8(%r14,%rsi,8)
    bc6d:	48 83 c2 04          	add    $0x4,%rdx
    bc71:	48 39 d0             	cmp    %rdx,%rax
    bc74:	75 ba                	jne    bc30 <fwp_apply+0x4a0>
    bc76:	4c 89 f0             	mov    %r14,%rax
    bc79:	48 8d 65 d8          	lea    -0x28(%rbp),%rsp
    bc7d:	5b                   	pop    %rbx
    bc7e:	41 5c                	pop    %r12
    bc80:	41 5d                	pop    %r13
    bc82:	41 5e                	pop    %r14
    bc84:	41 5f                	pop    %r15
    bc86:	5d                   	pop    %rbp
    bc87:	c3                   	ret
    bc88:	48 8d 50 ff          	lea    -0x1(%rax),%rdx
    bc8c:	31 c9                	xor    %ecx,%ecx
    bc8e:	89 d6                	mov    %edx,%esi
    bc90:	44 01 ee             	add    %r13d,%esi
    bc93:	0f 82 5d ff ff ff    	jb     bbf6 <fwp_apply+0x466>
    bc99:	48 c1 ea 20          	shr    $0x20,%rdx
    bc9d:	0f 85 53 ff ff ff    	jne    bbf6 <fwp_apply+0x466>
    bca3:	4b 8d 0c ee          	lea    (%r14,%r13,8),%rcx
    bca7:	48 29 d9             	sub    %rbx,%rcx
    bcaa:	48 83 c1 08          	add    $0x8,%rcx
    bcae:	48 83 f9 20          	cmp    $0x20,%rcx
    bcb2:	0f 82 3c ff ff ff    	jb     bbf4 <fwp_apply+0x464>
    bcb8:	89 c1                	mov    %eax,%ecx
    bcba:	83 e1 fc             	and    $0xfffffffc,%ecx
    bcbd:	31 d2                	xor    %edx,%edx
    bcbf:	90                   	nop
    bcc0:	0f 10 04 d3          	movups (%rbx,%rdx,8),%xmm0
    bcc4:	0f 10 4c d3 10       	movups 0x10(%rbx,%rdx,8),%xmm1
    bcc9:	42 8d 34 2a          	lea    (%rdx,%r13,1),%esi
    bccd:	41 0f 11 44 f6 08    	movups %xmm0,0x8(%r14,%rsi,8)
    bcd3:	41 0f 11 4c f6 18    	movups %xmm1,0x18(%r14,%rsi,8)
    bcd9:	48 83 c2 04          	add    $0x4,%rdx
    bcdd:	48 39 d1             	cmp    %rdx,%rcx
    bce0:	75 de                	jne    bcc0 <fwp_apply+0x530>
    bce2:	48 39 c1             	cmp    %rax,%rcx
    bce5:	0f 85 0b ff ff ff    	jne    bbf6 <fwp_apply+0x466>
    bceb:	eb 89                	jmp    bc76 <fwp_apply+0x4e6>
    bced:	0f 1f 00             	nopl   (%rax)

000000000000bcf0 <fwp_apply_owned>:
    bcf0:	55                   	push   %rbp
    bcf1:	48 89 e5             	mov    %rsp,%rbp
    bcf4:	41 57                	push   %r15
    bcf6:	41 56                	push   %r14
    bcf8:	41 55                	push   %r13
    bcfa:	41 54                	push   %r12
    bcfc:	53                   	push   %rbx
    bcfd:	48 83 ec 28          	sub    $0x28,%rsp
    bd01:	48 89 d3             	mov    %rdx,%rbx
    bd04:	41 89 f5             	mov    %esi,%r13d
    bd07:	48 8b 05 52 8a 00 00 	mov    0x8a52(%rip),%rax        # 14760 <fwp_fns>
    bd0e:	8b 17                	mov    (%rdi),%edx
    bd10:	48 89 d6             	mov    %rdx,%rsi
    bd13:	48 c1 e6 05          	shl    $0x5,%rsi
    bd17:	48 8b 4c 30 18       	mov    0x18(%rax,%rsi,1),%rcx
    bd1c:	48 85 c9             	test   %rcx,%rcx
    bd1f:	0f 84 ca 02 00 00    	je     bfef <fwp_apply_owned+0x2ff>
    bd25:	4c 8d 04 30          	lea    (%rax,%rsi,1),%r8
    bd29:	49 83 c0 18          	add    $0x18,%r8
    bd2d:	49 89 fc             	mov    %rdi,%r12
    bd30:	48 89 7d c0          	mov    %rdi,-0x40(%rbp)
    bd34:	48 c1 e2 05          	shl    $0x5,%rdx
    bd38:	8b 04 10             	mov    (%rax,%rdx,1),%eax
    bd3b:	45 8b 74 24 04       	mov    0x4(%r12),%r14d
    bd40:	47 8d 3c 2e          	lea    (%r14,%r13,1),%r15d
    bd44:	41 39 c7             	cmp    %eax,%r15d
    bd47:	0f 82 10 03 00 00    	jb     c05d <fwp_apply_owned+0x36d>
    bd4d:	41 89 c7             	mov    %eax,%r15d
    bd50:	45 29 f7             	sub    %r14d,%r15d
    bd53:	45 89 fa             	mov    %r15d,%r10d
    bd56:	85 c0                	test   %eax,%eax
    bd58:	4c 89 55 d0          	mov    %r10,-0x30(%rbp)
    bd5c:	74 22                	je     bd80 <fwp_apply_owned+0x90>
    bd5e:	45 85 f6             	test   %r14d,%r14d
    bd61:	75 1d                	jne    bd80 <fwp_apply_owned+0x90>
    bd63:	48 89 df             	mov    %rbx,%rdi
    bd66:	ff 11                	call   *(%rcx)
    bd68:	49 89 c4             	mov    %rax,%r12
    bd6b:	4c 8b 75 c0          	mov    -0x40(%rbp),%r14
    bd6f:	e9 35 02 00 00       	jmp    bfa9 <fwp_apply_owned+0x2b9>
    bd74:	66 66 66 2e 0f 1f 84 	data16 data16 cs nopw 0x0(%rax,%rax,1)
    bd7b:	00 00 00 00 00 
    bd80:	4c 89 6d c8          	mov    %r13,-0x38(%rbp)
    bd84:	48 89 65 b8          	mov    %rsp,-0x48(%rbp)
    bd88:	85 c0                	test   %eax,%eax
    bd8a:	b9 01 00 00 00       	mov    $0x1,%ecx
    bd8f:	0f 45 c8             	cmovne %eax,%ecx
    bd92:	48 8d 0c cd 0f 00 00 	lea    0xf(,%rcx,8),%rcx
    bd99:	00 
    bd9a:	48 83 e1 f0          	and    $0xfffffffffffffff0,%rcx
    bd9e:	49 89 e5             	mov    %rsp,%r13
    bda1:	49 29 cd             	sub    %rcx,%r13
    bda4:	4c 89 ec             	mov    %r13,%rsp
    bda7:	4d 85 f6             	test   %r14,%r14
    bdaa:	0f 84 d0 00 00 00    	je     be80 <fwp_apply_owned+0x190>
    bdb0:	41 83 fe 04          	cmp    $0x4,%r14d
    bdb4:	72 10                	jb     bdc6 <fwp_apply_owned+0xd6>
    bdb6:	4c 89 e9             	mov    %r13,%rcx
    bdb9:	4c 29 e1             	sub    %r12,%rcx
    bdbc:	48 83 c1 f8          	add    $0xfffffffffffffff8,%rcx
    bdc0:	48 83 f9 20          	cmp    $0x20,%rcx
    bdc4:	73 6d                	jae    be33 <fwp_apply_owned+0x143>
    bdc6:	31 c9                	xor    %ecx,%ecx
    bdc8:	4c 89 f6             	mov    %r14,%rsi
    bdcb:	48 89 ca             	mov    %rcx,%rdx
    bdce:	48 83 e6 03          	and    $0x3,%rsi
    bdd2:	74 1e                	je     bdf2 <fwp_apply_owned+0x102>
    bdd4:	48 89 ca             	mov    %rcx,%rdx
    bdd7:	66 0f 1f 84 00 00 00 	nopw   0x0(%rax,%rax,1)
    bdde:	00 00 
    bde0:	49 8b 7c d4 08       	mov    0x8(%r12,%rdx,8),%rdi
    bde5:	49 89 7c d5 00       	mov    %rdi,0x0(%r13,%rdx,8)
    bdea:	48 ff c2             	inc    %rdx
    bded:	48 ff ce             	dec    %rsi
    bdf0:	75 ee                	jne    bde0 <fwp_apply_owned+0xf0>
    bdf2:	4c 29 f1             	sub    %r14,%rcx
    bdf5:	48 83 f9 fc          	cmp    $0xfffffffffffffffc,%rcx
    bdf9:	0f 87 81 00 00 00    	ja     be80 <fwp_apply_owned+0x190>
    bdff:	90                   	nop
    be00:	49 8b 4c d4 08       	mov    0x8(%r12,%rdx,8),%rcx
    be05:	49 89 4c d5 00       	mov    %rcx,0x0(%r13,%rdx,8)
    be0a:	49 8b 4c d4 10       	mov    0x10(%r12,%rdx,8),%rcx
    be0f:	49 89 4c d5 08       	mov    %rcx,0x8(%r13,%rdx,8)
    be14:	49 8b 4c d4 18       	mov    0x18(%r12,%rdx,8),%rcx
    be19:	49 89 4c d5 10       	mov    %rcx,0x10(%r13,%rdx,8)
    be1e:	49 8b 4c d4 20       	mov    0x20(%r12,%rdx,8),%rcx
    be23:	49 89 4c d5 18       	mov    %rcx,0x18(%r13,%rdx,8)
    be28:	48 83 c2 04          	add    $0x4,%rdx
    be2c:	49 39 d6             	cmp    %rdx,%r14
    be2f:	75 cf                	jne    be00 <fwp_apply_owned+0x110>
    be31:	eb 4d                	jmp    be80 <fwp_apply_owned+0x190>
    be33:	44 89 f1             	mov    %r14d,%ecx
    be36:	83 e1 fc             	and    $0xfffffffc,%ecx
    be39:	4a 8d 14 f5 00 00 00 	lea    0x0(,%r14,8),%rdx
    be40:	00 
    be41:	48 83 e2 e0          	and    $0xffffffffffffffe0,%rdx
    be45:	31 f6                	xor    %esi,%esi
    be47:	66 0f 1f 84 00 00 00 	nopw   0x0(%rax,%rax,1)
    be4e:	00 00 
    be50:	41 0f 10 44 34 08    	movups 0x8(%r12,%rsi,1),%xmm0
    be56:	41 0f 10 4c 34 18    	movups 0x18(%r12,%rsi,1),%xmm1
    be5c:	41 0f 29 44 35 00    	movaps %xmm0,0x0(%r13,%rsi,1)
    be62:	41 0f 29 4c 35 10    	movaps %xmm1,0x10(%r13,%rsi,1)
    be68:	48 83 c6 20          	add    $0x20,%rsi
    be6c:	48 39 f2             	cmp    %rsi,%rdx
    be6f:	75 df                	jne    be50 <fwp_apply_owned+0x160>
    be71:	4c 39 f1             	cmp    %r14,%rcx
    be74:	0f 85 4e ff ff ff    	jne    bdc8 <fwp_apply_owned+0xd8>
    be7a:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)
    be80:	44 39 f0             	cmp    %r14d,%eax
    be83:	0f 84 f7 00 00 00    	je     bf80 <fwp_apply_owned+0x290>
    be89:	41 83 ff 0a          	cmp    $0xa,%r15d
    be8d:	0f 83 95 00 00 00    	jae    bf28 <fwp_apply_owned+0x238>
    be93:	31 c0                	xor    %eax,%eax
    be95:	4c 89 d2             	mov    %r10,%rdx
    be98:	48 89 c1             	mov    %rax,%rcx
    be9b:	48 83 e2 03          	and    $0x3,%rdx
    be9f:	74 24                	je     bec5 <fwp_apply_owned+0x1d5>
    bea1:	48 89 c1             	mov    %rax,%rcx
    bea4:	66 66 66 2e 0f 1f 84 	data16 data16 cs nopw 0x0(%rax,%rax,1)
    beab:	00 00 00 00 00 
    beb0:	48 8b 34 cb          	mov    (%rbx,%rcx,8),%rsi
    beb4:	41 8d 3c 0e          	lea    (%r14,%rcx,1),%edi
    beb8:	49 89 74 fd 00       	mov    %rsi,0x0(%r13,%rdi,8)
    bebd:	48 ff c1             	inc    %rcx
    bec0:	48 ff ca             	dec    %rdx
    bec3:	75 eb                	jne    beb0 <fwp_apply_owned+0x1c0>
    bec5:	4c 29 d0             	sub    %r10,%rax
    bec8:	48 83 f8 fc          	cmp    $0xfffffffffffffffc,%rax
    becc:	0f 87 ae 00 00 00    	ja     bf80 <fwp_apply_owned+0x290>
    bed2:	66 66 66 66 66 2e 0f 	data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    bed9:	1f 84 00 00 00 00 00 
    bee0:	48 8b 04 cb          	mov    (%rbx,%rcx,8),%rax
    bee4:	41 8d 14 0e          	lea    (%r14,%rcx,1),%edx
    bee8:	49 89 44 d5 00       	mov    %rax,0x0(%r13,%rdx,8)
    beed:	48 8b 44 cb 08       	mov    0x8(%rbx,%rcx,8),%rax
    bef2:	41 8d 14 0e          	lea    (%r14,%rcx,1),%edx
    bef6:	ff c2                	inc    %edx
    bef8:	49 89 44 d5 00       	mov    %rax,0x0(%r13,%rdx,8)
    befd:	48 8b 44 cb 10       	mov    0x10(%rbx,%rcx,8),%rax
    bf02:	41 8d 54 0e 02       	lea    0x2(%r14,%rcx,1),%edx
    bf07:	49 89 44 d5 00       	mov    %rax,0x0(%r13,%rdx,8)
    bf0c:	48 8b 44 cb 18       	mov    0x18(%rbx,%rcx,8),%rax
    bf11:	41 8d 14 0e          	lea    (%r14,%rcx,1),%edx
    bf15:	83 c2 03             	add    $0x3,%edx
    bf18:	49 89 44 d5 00       	mov    %rax,0x0(%r13,%rdx,8)
    bf1d:	48 83 c1 04          	add    $0x4,%rcx
    bf21:	49 39 ca             	cmp    %rcx,%r10
    bf24:	75 ba                	jne    bee0 <fwp_apply_owned+0x1f0>
    bf26:	eb 58                	jmp    bf80 <fwp_apply_owned+0x290>
    bf28:	49 8d 42 ff          	lea    -0x1(%r10),%rax
    bf2c:	89 c1                	mov    %eax,%ecx
    bf2e:	44 01 f1             	add    %r14d,%ecx
    bf31:	0f 82 5c ff ff ff    	jb     be93 <fwp_apply_owned+0x1a3>
    bf37:	48 c1 e8 20          	shr    $0x20,%rax
    bf3b:	b8 00 00 00 00       	mov    $0x0,%eax
    bf40:	0f 85 4f ff ff ff    	jne    be95 <fwp_apply_owned+0x1a5>
    bf46:	44 89 d0             	mov    %r10d,%eax
    bf49:	83 e0 fc             	and    $0xfffffffc,%eax
    bf4c:	31 c9                	xor    %ecx,%ecx
    bf4e:	66 90                	xchg   %ax,%ax
    bf50:	0f 10 04 cb          	movups (%rbx,%rcx,8),%xmm0
    bf54:	0f 10 4c cb 10       	movups 0x10(%rbx,%rcx,8),%xmm1
    bf59:	41 8d 14 0e          	lea    (%r14,%rcx,1),%edx
    bf5d:	41 0f 11 44 d5 00    	movups %xmm0,0x0(%r13,%rdx,8)
    bf63:	41 0f 11 4c d5 10    	movups %xmm1,0x10(%r13,%rdx,8)
    bf69:	48 83 c1 04          	add    $0x4,%rcx
    bf6d:	48 39 c8             	cmp    %rcx,%rax
    bf70:	75 de                	jne    bf50 <fwp_apply_owned+0x260>
    bf72:	4c 39 d0             	cmp    %r10,%rax
    bf75:	0f 85 1a ff ff ff    	jne    be95 <fwp_apply_owned+0x1a5>
    bf7b:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)
    bf80:	49 8b 00             	mov    (%r8),%rax
    bf83:	4c 8b 75 c0          	mov    -0x40(%rbp),%r14
    bf87:	4c 89 f7             	mov    %r14,%rdi
    bf8a:	be 01 00 00 00       	mov    $0x1,%esi
    bf8f:	4d 89 c4             	mov    %r8,%r12
    bf92:	ff 50 08             	call   *0x8(%rax)
    bf95:	49 8b 04 24          	mov    (%r12),%rax
    bf99:	4c 89 ef             	mov    %r13,%rdi
    bf9c:	ff 10                	call   *(%rax)
    bf9e:	49 89 c4             	mov    %rax,%r12
    bfa1:	48 8b 65 b8          	mov    -0x48(%rbp),%rsp
    bfa5:	4c 8b 6d c8          	mov    -0x38(%rbp),%r13
    bfa9:	4c 89 f7             	mov    %r14,%rdi
    bfac:	e8 af 05 00 00       	call   c560 <fwp_closure_drop>
    bfb1:	45 29 fd             	sub    %r15d,%r13d
    bfb4:	0f 84 89 05 00 00    	je     c543 <fwp_apply_owned+0x853>
    bfba:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
    bfbe:	48 8d 1c c3          	lea    (%rbx,%rax,8),%rbx
    bfc2:	48 8b 05 97 87 00 00 	mov    0x8797(%rip),%rax        # 14760 <fwp_fns>
    bfc9:	41 8b 14 24          	mov    (%r12),%edx
    bfcd:	48 89 d1             	mov    %rdx,%rcx
    bfd0:	48 c1 e1 05          	shl    $0x5,%rcx
    bfd4:	4c 8d 04 08          	lea    (%rax,%rcx,1),%r8
    bfd8:	49 83 c0 18          	add    $0x18,%r8
    bfdc:	48 8b 4c 08 18       	mov    0x18(%rax,%rcx,1),%rcx
    bfe1:	4c 89 e7             	mov    %r12,%rdi
    bfe4:	48 85 c9             	test   %rcx,%rcx
    bfe7:	0f 85 43 fd ff ff    	jne    bd30 <fwp_apply_owned+0x40>
    bfed:	eb 03                	jmp    bff2 <fwp_apply_owned+0x302>
    bfef:	49 89 fc             	mov    %rdi,%r12
    bff2:	48 8b 05 9f 71 00 00 	mov    0x719f(%rip),%rax        # 13198 <fwp_gc+0x1030>
    bff9:	4c 89 e2             	mov    %r12,%rdx
    bffc:	48 29 c2             	sub    %rax,%rdx
    bfff:	48 8b 0d ba 71 00 00 	mov    0x71ba(%rip),%rcx        # 131c0 <fwp_gc+0x1058>
    c006:	48 c1 e1 10          	shl    $0x10,%rcx
    c00a:	48 39 ca             	cmp    %rcx,%rdx
    c00d:	0f 83 12 01 00 00    	jae    c125 <fwp_apply_owned+0x435>
    c013:	48 8b 35 c6 71 00 00 	mov    0x71c6(%rip),%rsi        # 131e0 <fwp_gc+0x1078>
    c01a:	48 89 d7             	mov    %rdx,%rdi
    c01d:	48 c1 ef 10          	shr    $0x10,%rdi
    c021:	48 69 ff 28 12 00 00 	imul   $0x1228,%rdi,%rdi
    c028:	44 0f b6 04 3e       	movzbl (%rsi,%rdi,1),%r8d
    c02d:	48 81 e2 ff ff 00 00 	and    $0xffff,%rdx
    c034:	0f 85 c2 00 00 00    	jne    c0fc <fwp_apply_owned+0x40c>
    c03a:	41 80 f8 02          	cmp    $0x2,%r8b
    c03e:	0f 85 b8 00 00 00    	jne    c0fc <fwp_apply_owned+0x40c>
    c044:	48 8d 14 3e          	lea    (%rsi,%rdi,1),%rdx
    c048:	48 81 c2 28 02 00 00 	add    $0x228,%rdx
    c04f:	80 3a 00             	cmpb   $0x0,(%rdx)
    c052:	0f 84 cd 00 00 00    	je     c125 <fwp_apply_owned+0x435>
    c058:	e9 55 01 00 00       	jmp    c1b2 <fwp_apply_owned+0x4c2>
    c05d:	4c 89 45 d0          	mov    %r8,-0x30(%rbp)
    c061:	4c 89 6d c8          	mov    %r13,-0x38(%rbp)
    c065:	44 89 f9             	mov    %r15d,%ecx
    c068:	48 8d 3c cd 08 00 00 	lea    0x8(,%rcx,8),%rdi
    c06f:	00 
    c070:	41 81 ff ff 07 00 00 	cmp    $0x7ff,%r15d
    c077:	0f 87 f0 01 00 00    	ja     c26d <fwp_apply_owned+0x57d>
    c07d:	48 c1 e1 03          	shl    $0x3,%rcx
    c081:	4c 8d 41 17          	lea    0x17(%rcx),%r8
    c085:	49 c1 e8 04          	shr    $0x4,%r8
    c089:	48 8d 05 d8 60 00 00 	lea    0x60d8(%rip),%rax        # 12168 <fwp_gc>
    c090:	41 0f b6 b4 00 e8 0b 	movzbl 0xbe8(%r8,%rax,1),%esi
    c097:	00 00 
    c099:	8b 94 b0 48 0b 00 00 	mov    0xb48(%rax,%rsi,4),%edx
    c0a0:	4c 8b 0d c1 60 00 00 	mov    0x60c1(%rip),%r9        # 12168 <fwp_gc>
    c0a7:	4d 89 ca             	mov    %r9,%r10
    c0aa:	49 29 d2             	sub    %rdx,%r10
    c0ad:	4c 89 15 b4 60 00 00 	mov    %r10,0x60b4(%rip)        # 12168 <fwp_gc>
    c0b4:	0f 88 b3 01 00 00    	js     c26d <fwp_apply_owned+0x57d>
    c0ba:	4c 8d 14 76          	lea    (%rsi,%rsi,2),%r10
    c0be:	4e 8d 1c d0          	lea    (%rax,%r10,8),%r11
    c0c2:	49 83 c3 08          	add    $0x8,%r11
    c0c6:	4d 8b 2b             	mov    (%r11),%r13
    c0c9:	4d 85 ed             	test   %r13,%r13
    c0cc:	0f 84 24 01 00 00    	je     c1f6 <fwp_apply_owned+0x506>
    c0d2:	49 8b 45 00          	mov    0x0(%r13),%rax
    c0d6:	48 f7 d0             	not    %rax
    c0d9:	49 89 03             	mov    %rax,(%r11)
    c0dc:	48 39 d7             	cmp    %rdx,%rdi
    c0df:	0f 83 ad 01 00 00    	jae    c292 <fwp_apply_owned+0x5a2>
    c0e5:	4c 01 ef             	add    %r13,%rdi
    c0e8:	48 29 ca             	sub    %rcx,%rdx
    c0eb:	48 83 c2 f7          	add    $0xfffffffffffffff7,%rdx
    c0ef:	48 83 e2 f8          	and    $0xfffffffffffffff8,%rdx
    c0f3:	48 83 c2 08          	add    $0x8,%rdx
    c0f7:	e9 8f 01 00 00       	jmp    c28b <fwp_apply_owned+0x59b>
    c0fc:	41 80 f8 01          	cmp    $0x1,%r8b
    c100:	75 23                	jne    c125 <fwp_apply_owned+0x435>
    c102:	4c 8d 04 3e          	lea    (%rsi,%rdi,1),%r8
    c106:	8b 74 3e 20          	mov    0x20(%rsi,%rdi,1),%esi
    c10a:	48 0f af d6          	imul   %rsi,%rdx
    c10e:	48 c1 ea 20          	shr    $0x20,%rdx
    c112:	4c 01 c2             	add    %r8,%rdx
    c115:	48 81 c2 28 02 00 00 	add    $0x228,%rdx
    c11c:	80 3a 00             	cmpb   $0x0,(%rdx)
    c11f:	0f 85 8d 00 00 00    	jne    c1b2 <fwp_apply_owned+0x4c2>
    c125:	45 85 ed             	test   %r13d,%r13d
    c128:	0f 84 b2 00 00 00    	je     c1e0 <fwp_apply_owned+0x4f0>
    c12e:	48 8b 15 ab 70 00 00 	mov    0x70ab(%rip),%rdx        # 131e0 <fwp_gc+0x1078>
    c135:	44 89 ee             	mov    %r13d,%esi
    c138:	31 ff                	xor    %edi,%edi
    c13a:	eb 21                	jmp    c15d <fwp_apply_owned+0x46d>
    c13c:	0f 1f 40 00          	nopl   0x0(%rax)
    c140:	4e 8d 04 0a          	lea    (%rdx,%r9,1),%r8
    c144:	49 81 c0 28 02 00 00 	add    $0x228,%r8
    c14b:	41 80 38 00          	cmpb   $0x0,(%r8)
    c14f:	75 61                	jne    c1b2 <fwp_apply_owned+0x4c2>
    c151:	48 ff c7             	inc    %rdi
    c154:	48 39 fe             	cmp    %rdi,%rsi
    c157:	0f 84 83 00 00 00    	je     c1e0 <fwp_apply_owned+0x4f0>
    c15d:	4c 8b 04 fb          	mov    (%rbx,%rdi,8),%r8
    c161:	49 29 c0             	sub    %rax,%r8
    c164:	49 39 c8             	cmp    %rcx,%r8
    c167:	73 e8                	jae    c151 <fwp_apply_owned+0x461>
    c169:	4d 89 c1             	mov    %r8,%r9
    c16c:	49 c1 e9 10          	shr    $0x10,%r9
    c170:	4d 69 c9 28 12 00 00 	imul   $0x1228,%r9,%r9
    c177:	46 0f b6 14 0a       	movzbl (%rdx,%r9,1),%r10d
    c17c:	49 81 e0 ff ff 00 00 	and    $0xffff,%r8
    c183:	75 06                	jne    c18b <fwp_apply_owned+0x49b>
    c185:	41 80 fa 02          	cmp    $0x2,%r10b
    c189:	74 b5                	je     c140 <fwp_apply_owned+0x450>
    c18b:	41 80 fa 01          	cmp    $0x1,%r10b
    c18f:	75 c0                	jne    c151 <fwp_apply_owned+0x461>
    c191:	4e 8d 14 0a          	lea    (%rdx,%r9,1),%r10
    c195:	46 8b 4c 0a 20       	mov    0x20(%rdx,%r9,1),%r9d
    c19a:	4d 0f af c1          	imul   %r9,%r8
    c19e:	49 c1 e8 20          	shr    $0x20,%r8
    c1a2:	4d 01 d0             	add    %r10,%r8
    c1a5:	49 81 c0 28 02 00 00 	add    $0x228,%r8
    c1ac:	41 80 38 00          	cmpb   $0x0,(%r8)
    c1b0:	74 9f                	je     c151 <fwp_apply_owned+0x461>
    c1b2:	e8 a9 a8 ff ff       	call   6a60 <fwp_flush>
    c1b7:	48 8b 05 22 5e 00 00 	mov    0x5e22(%rip),%rax        # 11fe0 <stderr@GLIBC_2.2.5>
    c1be:	48 8b 38             	mov    (%rax),%rdi
    c1c1:	48 8d 35 05 33 00 00 	lea    0x3305(%rip),%rsi        # f4cd <fwp_segv.msg+0x24d>
    c1c8:	48 8d 15 d1 32 00 00 	lea    0x32d1(%rip),%rdx        # f4a0 <fwp_segv.msg+0x220>
    c1cf:	31 c0                	xor    %eax,%eax
    c1d1:	e8 ca 5f ff ff       	call   21a0 <fprintf@plt>
    c1d6:	bf 65 00 00 00       	mov    $0x65,%edi
    c1db:	e8 90 60 ff ff       	call   2270 <exit@plt>
    c1e0:	4c 89 e7             	mov    %r12,%rdi
    c1e3:	44 89 ee             	mov    %r13d,%esi
    c1e6:	48 89 da             	mov    %rbx,%rdx
    c1e9:	e8 a2 f5 ff ff       	call   b790 <fwp_apply>
    c1ee:	49 89 c4             	mov    %rax,%r12
    c1f1:	e9 4d 03 00 00       	jmp    c543 <fwp_apply_owned+0x853>
    c1f6:	4e 8b 6c d0 10       	mov    0x10(%rax,%r10,8),%r13
    c1fb:	4e 8b 5c d0 18       	mov    0x18(%rax,%r10,8),%r11
    c200:	4d 29 eb             	sub    %r13,%r11
    c203:	49 39 d3             	cmp    %rdx,%r11
    c206:	72 34                	jb     c23c <fwp_apply_owned+0x54c>
    c208:	4a 8d 34 d0          	lea    (%rax,%r10,8),%rsi
    c20c:	48 83 c6 10          	add    $0x10,%rsi
    c210:	4e 8d 14 2a          	lea    (%rdx,%r13,1),%r10
    c214:	4c 89 16             	mov    %r10,(%rsi)
    c217:	4d 85 ed             	test   %r13,%r13
    c21a:	0f 85 bc fe ff ff    	jne    c0dc <fwp_apply_owned+0x3ec>
    c220:	41 0f b6 b4 00 e8 0b 	movzbl 0xbe8(%r8,%rax,1),%esi
    c227:	00 00 
    c229:	8b 94 b0 48 0b 00 00 	mov    0xb48(%rax,%rsi,4),%edx
    c230:	49 29 d1             	sub    %rdx,%r9
    c233:	4c 89 0d 2e 5f 00 00 	mov    %r9,0x5f2e(%rip)        # 12168 <fwp_gc>
    c23a:	78 31                	js     c26d <fwp_apply_owned+0x57d>
    c23c:	48 8d 0c 76          	lea    (%rsi,%rsi,2),%rcx
    c240:	4c 8b 6c c8 08       	mov    0x8(%rax,%rcx,8),%r13
    c245:	4d 85 ed             	test   %r13,%r13
    c248:	74 11                	je     c25b <fwp_apply_owned+0x56b>
    c24a:	48 8d 04 c8          	lea    (%rax,%rcx,8),%rax
    c24e:	48 83 c0 08          	add    $0x8,%rax
    c252:	49 8b 4d 00          	mov    0x0(%r13),%rcx
    c256:	48 f7 d1             	not    %rcx
    c259:	eb 2a                	jmp    c285 <fwp_apply_owned+0x595>
    c25b:	4c 8b 6c c8 10       	mov    0x10(%rax,%rcx,8),%r13
    c260:	48 8b 74 c8 18       	mov    0x18(%rax,%rcx,8),%rsi
    c265:	4c 29 ee             	sub    %r13,%rsi
    c268:	48 39 d6             	cmp    %rdx,%rsi
    c26b:	73 0c                	jae    c279 <fwp_apply_owned+0x589>
    c26d:	31 f6                	xor    %esi,%esi
    c26f:	e8 8c ac ff ff       	call   6f00 <fwp_gc_alloc_slow>
    c274:	49 89 c5             	mov    %rax,%r13
    c277:	eb 19                	jmp    c292 <fwp_apply_owned+0x5a2>
    c279:	48 8d 04 c8          	lea    (%rax,%rcx,8),%rax
    c27d:	48 83 c0 10          	add    $0x10,%rax
    c281:	4a 8d 0c 2a          	lea    (%rdx,%r13,1),%rcx
    c285:	48 89 08             	mov    %rcx,(%rax)
    c288:	4c 89 ef             	mov    %r13,%rdi
    c28b:	31 f6                	xor    %esi,%esi
    c28d:	e8 8e 5e ff ff       	call   2120 <memset@plt>
    c292:	4c 8b 4d d0          	mov    -0x30(%rbp),%r9
    c296:	41 8b 04 24          	mov    (%r12),%eax
    c29a:	41 89 45 00          	mov    %eax,0x0(%r13)
    c29e:	45 89 7d 04          	mov    %r15d,0x4(%r13)
    c2a2:	4d 85 f6             	test   %r14,%r14
    c2a5:	0f 84 c6 00 00 00    	je     c371 <fwp_apply_owned+0x681>
    c2ab:	31 c0                	xor    %eax,%eax
    c2ad:	41 83 fe 06          	cmp    $0x6,%r14d
    c2b1:	72 53                	jb     c306 <fwp_apply_owned+0x616>
    c2b3:	4c 89 e9             	mov    %r13,%rcx
    c2b6:	4c 29 e1             	sub    %r12,%rcx
    c2b9:	48 83 f9 20          	cmp    $0x20,%rcx
    c2bd:	72 47                	jb     c306 <fwp_apply_owned+0x616>
    c2bf:	44 89 f0             	mov    %r14d,%eax
    c2c2:	83 e0 fc             	and    $0xfffffffc,%eax
    c2c5:	4a 8d 0c f5 00 00 00 	lea    0x0(,%r14,8),%rcx
    c2cc:	00 
    c2cd:	48 83 e1 e0          	and    $0xffffffffffffffe0,%rcx
    c2d1:	31 d2                	xor    %edx,%edx
    c2d3:	66 66 66 66 2e 0f 1f 	data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    c2da:	84 00 00 00 00 00 
    c2e0:	41 0f 10 44 14 08    	movups 0x8(%r12,%rdx,1),%xmm0
    c2e6:	41 0f 10 4c 14 18    	movups 0x18(%r12,%rdx,1),%xmm1
    c2ec:	41 0f 11 44 15 08    	movups %xmm0,0x8(%r13,%rdx,1)
    c2f2:	41 0f 11 4c 15 18    	movups %xmm1,0x18(%r13,%rdx,1)
    c2f8:	48 83 c2 20          	add    $0x20,%rdx
    c2fc:	48 39 d1             	cmp    %rdx,%rcx
    c2ff:	75 df                	jne    c2e0 <fwp_apply_owned+0x5f0>
    c301:	4c 39 f0             	cmp    %r14,%rax
    c304:	74 6b                	je     c371 <fwp_apply_owned+0x681>
    c306:	4c 89 f2             	mov    %r14,%rdx
    c309:	48 89 c1             	mov    %rax,%rcx
    c30c:	48 83 e2 03          	and    $0x3,%rdx
    c310:	74 20                	je     c332 <fwp_apply_owned+0x642>
    c312:	48 89 c1             	mov    %rax,%rcx
    c315:	66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
    c31c:	00 00 00 00 
    c320:	49 8b 74 cc 08       	mov    0x8(%r12,%rcx,8),%rsi
    c325:	49 89 74 cd 08       	mov    %rsi,0x8(%r13,%rcx,8)
    c32a:	48 ff c1             	inc    %rcx
    c32d:	48 ff ca             	dec    %rdx
    c330:	75 ee                	jne    c320 <fwp_apply_owned+0x630>
    c332:	4c 29 f0             	sub    %r14,%rax
    c335:	48 83 f8 fc          	cmp    $0xfffffffffffffffc,%rax
    c339:	77 36                	ja     c371 <fwp_apply_owned+0x681>
    c33b:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)
    c340:	49 8b 44 cc 08       	mov    0x8(%r12,%rcx,8),%rax
    c345:	49 89 44 cd 08       	mov    %rax,0x8(%r13,%rcx,8)
    c34a:	49 8b 44 cc 10       	mov    0x10(%r12,%rcx,8),%rax
    c34f:	49 89 44 cd 10       	mov    %rax,0x10(%r13,%rcx,8)
    c354:	49 8b 44 cc 18       	mov    0x18(%r12,%rcx,8),%rax
    c359:	49 89 44 cd 18       	mov    %rax,0x18(%r13,%rcx,8)
    c35e:	49 8b 44 cc 20       	mov    0x20(%r12,%rcx,8),%rax
    c363:	49 89 44 cd 20       	mov    %rax,0x20(%r13,%rcx,8)
    c368:	48 83 c1 04          	add    $0x4,%rcx
    c36c:	49 39 ce             	cmp    %rcx,%r14
    c36f:	75 cf                	jne    c340 <fwp_apply_owned+0x650>
    c371:	48 8b 4d c8          	mov    -0x38(%rbp),%rcx
    c375:	85 c9                	test   %ecx,%ecx
    c377:	0f 84 89 00 00 00    	je     c406 <fwp_apply_owned+0x716>
    c37d:	89 c8                	mov    %ecx,%eax
    c37f:	83 f9 14             	cmp    $0x14,%ecx
    c382:	0f 83 fb 00 00 00    	jae    c483 <fwp_apply_owned+0x793>
    c388:	31 c9                	xor    %ecx,%ecx
    c38a:	48 89 c6             	mov    %rax,%rsi
    c38d:	48 89 ca             	mov    %rcx,%rdx
    c390:	48 83 e6 03          	and    $0x3,%rsi
    c394:	74 1f                	je     c3b5 <fwp_apply_owned+0x6c5>
    c396:	48 89 ca             	mov    %rcx,%rdx
    c399:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)
    c3a0:	48 8b 3c d3          	mov    (%rbx,%rdx,8),%rdi
    c3a4:	45 8d 04 16          	lea    (%r14,%rdx,1),%r8d
    c3a8:	4b 89 7c c5 08       	mov    %rdi,0x8(%r13,%r8,8)
    c3ad:	48 ff c2             	inc    %rdx
    c3b0:	48 ff ce             	dec    %rsi
    c3b3:	75 eb                	jne    c3a0 <fwp_apply_owned+0x6b0>
    c3b5:	48 29 c1             	sub    %rax,%rcx
    c3b8:	48 83 f9 fc          	cmp    $0xfffffffffffffffc,%rcx
    c3bc:	77 48                	ja     c406 <fwp_apply_owned+0x716>
    c3be:	66 90                	xchg   %ax,%ax
    c3c0:	48 8b 0c d3          	mov    (%rbx,%rdx,8),%rcx
    c3c4:	41 8d 34 16          	lea    (%r14,%rdx,1),%esi
    c3c8:	49 89 4c f5 08       	mov    %rcx,0x8(%r13,%rsi,8)
    c3cd:	48 8b 4c d3 08       	mov    0x8(%rbx,%rdx,8),%rcx
    c3d2:	41 8d 34 16          	lea    (%r14,%rdx,1),%esi
    c3d6:	ff c6                	inc    %esi
    c3d8:	49 89 4c f5 08       	mov    %rcx,0x8(%r13,%rsi,8)
    c3dd:	48 8b 4c d3 10       	mov    0x10(%rbx,%rdx,8),%rcx
    c3e2:	41 8d 74 16 02       	lea    0x2(%r14,%rdx,1),%esi
    c3e7:	49 89 4c f5 08       	mov    %rcx,0x8(%r13,%rsi,8)
    c3ec:	48 8b 4c d3 18       	mov    0x18(%rbx,%rdx,8),%rcx
    c3f1:	41 8d 34 16          	lea    (%r14,%rdx,1),%esi
    c3f5:	83 c6 03             	add    $0x3,%esi
    c3f8:	49 89 4c f5 08       	mov    %rcx,0x8(%r13,%rsi,8)
    c3fd:	48 83 c2 04          	add    $0x4,%rdx
    c401:	48 39 d0             	cmp    %rdx,%rax
    c404:	75 ba                	jne    c3c0 <fwp_apply_owned+0x6d0>
    c406:	49 8b 01             	mov    (%r9),%rax
    c409:	4c 8b 75 c0          	mov    -0x40(%rbp),%r14
    c40d:	4c 89 f7             	mov    %r14,%rdi
    c410:	be 01 00 00 00       	mov    $0x1,%esi
    c415:	ff 50 08             	call   *0x8(%rax)
    c418:	4c 89 e8             	mov    %r13,%rax
    c41b:	48 2b 05 76 6d 00 00 	sub    0x6d76(%rip),%rax        # 13198 <fwp_gc+0x1030>
    c422:	48 8b 0d 97 6d 00 00 	mov    0x6d97(%rip),%rcx        # 131c0 <fwp_gc+0x1058>
    c429:	48 c1 e1 10          	shl    $0x10,%rcx
    c42d:	48 39 c8             	cmp    %rcx,%rax
    c430:	0f 83 02 01 00 00    	jae    c538 <fwp_apply_owned+0x848>
    c436:	48 8b 0d a3 6d 00 00 	mov    0x6da3(%rip),%rcx        # 131e0 <fwp_gc+0x1078>
    c43d:	48 89 c2             	mov    %rax,%rdx
    c440:	48 c1 ea 10          	shr    $0x10,%rdx
    c444:	48 69 d2 28 12 00 00 	imul   $0x1228,%rdx,%rdx
    c44b:	0f b6 34 11          	movzbl (%rcx,%rdx,1),%esi
    c44f:	48 25 ff ff 00 00    	and    $0xffff,%rax
    c455:	0f 85 a5 00 00 00    	jne    c500 <fwp_apply_owned+0x810>
    c45b:	40 80 fe 02          	cmp    $0x2,%sil
    c45f:	0f 85 9b 00 00 00    	jne    c500 <fwp_apply_owned+0x810>
    c465:	4c 8d 3c 11          	lea    (%rcx,%rdx,1),%r15
    c469:	49 81 c7 28 02 00 00 	add    $0x228,%r15
    c470:	41 80 3f ff          	cmpb   $0xff,(%r15)
    c474:	0f 84 b1 00 00 00    	je     c52b <fwp_apply_owned+0x83b>
    c47a:	41 c6 07 01          	movb   $0x1,(%r15)
    c47e:	e9 b5 00 00 00       	jmp    c538 <fwp_apply_owned+0x848>
    c483:	48 8d 50 ff          	lea    -0x1(%rax),%rdx
    c487:	31 c9                	xor    %ecx,%ecx
    c489:	89 d6                	mov    %edx,%esi
    c48b:	44 01 f6             	add    %r14d,%esi
    c48e:	0f 82 f6 fe ff ff    	jb     c38a <fwp_apply_owned+0x69a>
    c494:	48 c1 ea 20          	shr    $0x20,%rdx
    c498:	0f 85 ec fe ff ff    	jne    c38a <fwp_apply_owned+0x69a>
    c49e:	4a 8d 0c f5 00 00 00 	lea    0x0(,%r14,8),%rcx
    c4a5:	00 
    c4a6:	4c 01 e9             	add    %r13,%rcx
    c4a9:	48 29 d9             	sub    %rbx,%rcx
    c4ac:	48 83 c1 08          	add    $0x8,%rcx
    c4b0:	48 83 f9 20          	cmp    $0x20,%rcx
    c4b4:	0f 82 ce fe ff ff    	jb     c388 <fwp_apply_owned+0x698>
    c4ba:	89 c1                	mov    %eax,%ecx
    c4bc:	83 e1 fc             	and    $0xfffffffc,%ecx
    c4bf:	31 d2                	xor    %edx,%edx
    c4c1:	66 66 66 66 66 66 2e 	data16 data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    c4c8:	0f 1f 84 00 00 00 00 
    c4cf:	00 
    c4d0:	0f 10 04 d3          	movups (%rbx,%rdx,8),%xmm0
    c4d4:	0f 10 4c d3 10       	movups 0x10(%rbx,%rdx,8),%xmm1
    c4d9:	41 8d 34 16          	lea    (%r14,%rdx,1),%esi
    c4dd:	41 0f 11 44 f5 08    	movups %xmm0,0x8(%r13,%rsi,8)
    c4e3:	41 0f 11 4c f5 18    	movups %xmm1,0x18(%r13,%rsi,8)
    c4e9:	48 83 c2 04          	add    $0x4,%rdx
    c4ed:	48 39 d1             	cmp    %rdx,%rcx
    c4f0:	75 de                	jne    c4d0 <fwp_apply_owned+0x7e0>
    c4f2:	48 39 c1             	cmp    %rax,%rcx
    c4f5:	0f 85 8f fe ff ff    	jne    c38a <fwp_apply_owned+0x69a>
    c4fb:	e9 06 ff ff ff       	jmp    c406 <fwp_apply_owned+0x716>
    c500:	40 80 fe 01          	cmp    $0x1,%sil
    c504:	75 32                	jne    c538 <fwp_apply_owned+0x848>
    c506:	48 8d 34 11          	lea    (%rcx,%rdx,1),%rsi
    c50a:	8b 4c 11 20          	mov    0x20(%rcx,%rdx,1),%ecx
    c50e:	48 0f af c1          	imul   %rcx,%rax
    c512:	48 c1 e8 20          	shr    $0x20,%rax
    c516:	4c 8d 3c 30          	lea    (%rax,%rsi,1),%r15
    c51a:	49 81 c7 28 02 00 00 	add    $0x228,%r15
    c521:	41 80 3f ff          	cmpb   $0xff,(%r15)
    c525:	0f 85 4f ff ff ff    	jne    c47a <fwp_apply_owned+0x78a>
    c52b:	4c 89 ff             	mov    %r15,%rdi
    c52e:	e8 5d a5 ff ff       	call   6a90 <fwp_rc_forget_slot>
    c533:	e9 42 ff ff ff       	jmp    c47a <fwp_apply_owned+0x78a>
    c538:	4c 89 f7             	mov    %r14,%rdi
    c53b:	e8 20 00 00 00       	call   c560 <fwp_closure_drop>
    c540:	4d 89 ec             	mov    %r13,%r12
    c543:	4c 89 e0             	mov    %r12,%rax
    c546:	48 8d 65 d8          	lea    -0x28(%rbp),%rsp
    c54a:	5b                   	pop    %rbx
    c54b:	41 5c                	pop    %r12
    c54d:	41 5d                	pop    %r13
    c54f:	41 5e                	pop    %r14
    c551:	41 5f                	pop    %r15
    c553:	5d                   	pop    %rbp
    c554:	c3                   	ret
    c555:	66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
    c55c:	00 00 00 00 

000000000000c560 <fwp_closure_drop>:
    c560:	41 57                	push   %r15
    c562:	41 56                	push   %r14
    c564:	53                   	push   %rbx
    c565:	48 81 ec 30 02 00 00 	sub    $0x230,%rsp
    c56c:	48 89 f8             	mov    %rdi,%rax
    c56f:	48 2b 05 22 6c 00 00 	sub    0x6c22(%rip),%rax        # 13198 <fwp_gc+0x1030>
    c576:	48 8b 0d 43 6c 00 00 	mov    0x6c43(%rip),%rcx        # 131c0 <fwp_gc+0x1058>
    c57d:	48 c1 e1 10          	shl    $0x10,%rcx
    c581:	48 39 c8             	cmp    %rcx,%rax
    c584:	0f 83 91 00 00 00    	jae    c61b <fwp_closure_drop+0xbb>
    c58a:	48 89 fe             	mov    %rdi,%rsi
    c58d:	48 8b 0d 4c 6c 00 00 	mov    0x6c4c(%rip),%rcx        # 131e0 <fwp_gc+0x1078>
    c594:	48 89 c2             	mov    %rax,%rdx
    c597:	48 c1 ea 10          	shr    $0x10,%rdx
    c59b:	48 69 d2 28 12 00 00 	imul   $0x1228,%rdx,%rdx
    c5a2:	0f b6 3c 11          	movzbl (%rcx,%rdx,1),%edi
    c5a6:	48 25 ff ff 00 00    	and    $0xffff,%rax
    c5ac:	75 13                	jne    c5c1 <fwp_closure_drop+0x61>
    c5ae:	40 80 ff 02          	cmp    $0x2,%dil
    c5b2:	75 0d                	jne    c5c1 <fwp_closure_drop+0x61>
    c5b4:	48 8d 3c 11          	lea    (%rcx,%rdx,1),%rdi
    c5b8:	48 81 c7 28 02 00 00 	add    $0x228,%rdi
    c5bf:	eb 20                	jmp    c5e1 <fwp_closure_drop+0x81>
    c5c1:	40 80 ff 01          	cmp    $0x1,%dil
    c5c5:	75 54                	jne    c61b <fwp_closure_drop+0xbb>
    c5c7:	48 8d 3c 11          	lea    (%rcx,%rdx,1),%rdi
    c5cb:	8b 4c 11 20          	mov    0x20(%rcx,%rdx,1),%ecx
    c5cf:	48 0f af c1          	imul   %rcx,%rax
    c5d3:	48 c1 e8 20          	shr    $0x20,%rax
    c5d7:	48 01 c7             	add    %rax,%rdi
    c5da:	48 81 c7 28 02 00 00 	add    $0x228,%rdi
    c5e1:	0f b6 07             	movzbl (%rdi),%eax
    c5e4:	85 c0                	test   %eax,%eax
    c5e6:	74 33                	je     c61b <fwp_closure_drop+0xbb>
    c5e8:	83 f8 01             	cmp    $0x1,%eax
    c5eb:	75 1f                	jne    c60c <fwp_closure_drop+0xac>
    c5ed:	64 48 8b 3c 25 f8 ff 	mov    %fs:0xfffffffffffffff8,%rdi
    c5f4:	ff ff 
    c5f6:	48 85 ff             	test   %rdi,%rdi
    c5f9:	74 2d                	je     c628 <fwp_closure_drop+0xc8>
    c5fb:	48 81 c4 30 02 00 00 	add    $0x230,%rsp
    c602:	5b                   	pop    %rbx
    c603:	41 5e                	pop    %r14
    c605:	41 5f                	pop    %r15
    c607:	e9 b4 01 00 00       	jmp    c7c0 <fwp_closure_drop_push>
    c60c:	3d ff 00 00 00       	cmp    $0xff,%eax
    c611:	0f 84 56 01 00 00    	je     c76d <fwp_closure_drop+0x20d>
    c617:	fe c8                	dec    %al
    c619:	88 07                	mov    %al,(%rdi)
    c61b:	48 81 c4 30 02 00 00 	add    $0x230,%rsp
    c622:	5b                   	pop    %rbx
    c623:	41 5e                	pop    %r14
    c625:	41 5f                	pop    %r15
    c627:	c3                   	ret
    c628:	64 48 8b 04 25 00 00 	mov    %fs:0x0,%rax
    c62f:	00 00 
    c631:	4c 8d b0 f8 ff ff ff 	lea    -0x8(%rax),%r14
    c638:	48 8d 5c 24 30       	lea    0x30(%rsp),%rbx
    c63d:	48 89 5c 24 18       	mov    %rbx,0x18(%rsp)
    c642:	48 c7 44 24 20 00 00 	movq   $0x0,0x20(%rsp)
    c649:	00 00 
    c64b:	48 c7 44 24 28 40 00 	movq   $0x40,0x28(%rsp)
    c652:	00 00 
    c654:	48 8b 05 2d 81 00 00 	mov    0x812d(%rip),%rax        # 14788 <fwp_cleanups>
    c65b:	48 89 04 24          	mov    %rax,(%rsp)
    c65f:	48 8d 05 9a 02 00 00 	lea    0x29a(%rip),%rax        # c900 <fwp_closure_drop_release>
    c666:	48 89 44 24 08       	mov    %rax,0x8(%rsp)
    c66b:	48 8d 7c 24 18       	lea    0x18(%rsp),%rdi
    c670:	48 89 7c 24 10       	mov    %rdi,0x10(%rsp)
    c675:	49 89 e7             	mov    %rsp,%r15
    c678:	4c 89 3d 09 81 00 00 	mov    %r15,0x8109(%rip)        # 14788 <fwp_cleanups>
    c67f:	49 89 3e             	mov    %rdi,(%r14)
    c682:	e8 39 01 00 00       	call   c7c0 <fwp_closure_drop_push>
    c687:	66 0f 1f 84 00 00 00 	nopw   0x0(%rax,%rax,1)
    c68e:	00 00 
    c690:	48 8b 44 24 20       	mov    0x20(%rsp),%rax
    c695:	48 85 c0             	test   %rax,%rax
    c698:	74 35                	je     c6cf <fwp_closure_drop+0x16f>
    c69a:	48 8b 4c 24 18       	mov    0x18(%rsp),%rcx
    c69f:	48 8d 50 ff          	lea    -0x1(%rax),%rdx
    c6a3:	48 89 54 24 20       	mov    %rdx,0x20(%rsp)
    c6a8:	48 8b 7c c1 f8       	mov    -0x8(%rcx,%rax,8),%rdi
    c6ad:	48 8b 05 ac 80 00 00 	mov    0x80ac(%rip),%rax        # 14760 <fwp_fns>
    c6b4:	8b 0f                	mov    (%rdi),%ecx
    c6b6:	48 c1 e1 05          	shl    $0x5,%rcx
    c6ba:	48 8b 44 08 18       	mov    0x18(%rax,%rcx,1),%rax
    c6bf:	48 85 c0             	test   %rax,%rax
    c6c2:	0f 84 b6 00 00 00    	je     c77e <fwp_closure_drop+0x21e>
    c6c8:	31 f6                	xor    %esi,%esi
    c6ca:	ff 50 08             	call   *0x8(%rax)
    c6cd:	eb c1                	jmp    c690 <fwp_closure_drop+0x130>
    c6cf:	4c 39 3d b2 80 00 00 	cmp    %r15,0x80b2(%rip)        # 14788 <fwp_cleanups>
    c6d6:	0f 85 d0 00 00 00    	jne    c7ac <fwp_closure_drop+0x24c>
    c6dc:	48 8b 04 24          	mov    (%rsp),%rax
    c6e0:	48 89 05 a1 80 00 00 	mov    %rax,0x80a1(%rip)        # 14788 <fwp_cleanups>
    c6e7:	49 c7 06 00 00 00 00 	movq   $0x0,(%r14)
    c6ee:	48 8b 44 24 18       	mov    0x18(%rsp),%rax
    c6f3:	48 39 d8             	cmp    %rbx,%rax
    c6f6:	0f 84 1f ff ff ff    	je     c61b <fwp_closure_drop+0xbb>
    c6fc:	48 85 c0             	test   %rax,%rax
    c6ff:	0f 84 16 ff ff ff    	je     c61b <fwp_closure_drop+0xbb>
    c705:	8b 48 f4             	mov    -0xc(%rax),%ecx
    c708:	0f 1f 84 00 00 00 00 	nopl   0x0(%rax,%rax,1)
    c70f:	00 
    c710:	b2 01                	mov    $0x1,%dl
    c712:	86 15 d0 7c 00 00    	xchg   %dl,0x7cd0(%rip)        # 143e8 <fwp_static+0x848>
    c718:	84 d2                	test   %dl,%dl
    c71a:	75 f4                	jne    c710 <fwp_closure_drop+0x1b0>
    c71c:	48 29 c8             	sub    %rcx,%rax
    c71f:	8b 50 f0             	mov    -0x10(%rax),%edx
    c722:	89 d1                	mov    %edx,%ecx
    c724:	c1 e9 02             	shr    $0x2,%ecx
    c727:	be 01 00 00 00       	mov    $0x1,%esi
    c72c:	48 d3 e6             	shl    %cl,%rsi
    c72f:	48 8d 48 f0          	lea    -0x10(%rax),%rcx
    c733:	89 d7                	mov    %edx,%edi
    c735:	83 e7 03             	and    $0x3,%edi
    c738:	49 89 f0             	mov    %rsi,%r8
    c73b:	49 c1 e8 02          	shr    $0x2,%r8
    c73f:	4c 0f af c7          	imul   %rdi,%r8
    c743:	48 8d 3d 56 74 00 00 	lea    0x7456(%rip),%rdi        # 13ba0 <fwp_static>
    c74a:	49 01 f0             	add    %rsi,%r8
    c74d:	4c 29 05 84 7c 00 00 	sub    %r8,0x7c84(%rip)        # 143d8 <fwp_static+0x838>
    c754:	48 8b 74 d7 38       	mov    0x38(%rdi,%rdx,8),%rsi
    c759:	48 89 30             	mov    %rsi,(%rax)
    c75c:	48 89 4c d7 38       	mov    %rcx,0x38(%rdi,%rdx,8)
    c761:	c6 05 80 7c 00 00 00 	movb   $0x0,0x7c80(%rip)        # 143e8 <fwp_static+0x848>
    c768:	e9 ae fe ff ff       	jmp    c61b <fwp_closure_drop+0xbb>
    c76d:	48 81 c4 30 02 00 00 	add    $0x230,%rsp
    c774:	5b                   	pop    %rbx
    c775:	41 5e                	pop    %r14
    c777:	41 5f                	pop    %r15
    c779:	e9 12 e5 ff ff       	jmp    ac90 <fwp_rc_wide_drop>
    c77e:	e8 dd a2 ff ff       	call   6a60 <fwp_flush>
    c783:	48 8b 05 56 58 00 00 	mov    0x5856(%rip),%rax        # 11fe0 <stderr@GLIBC_2.2.5>
    c78a:	48 8b 38             	mov    (%rax),%rdi
    c78d:	48 8d 35 39 2d 00 00 	lea    0x2d39(%rip),%rsi        # f4cd <fwp_segv.msg+0x24d>
    c794:	48 8d 15 c1 2f 00 00 	lea    0x2fc1(%rip),%rdx        # f75c <fwp_segv.msg+0x4dc>
    c79b:	31 c0                	xor    %eax,%eax
    c79d:	e8 fe 59 ff ff       	call   21a0 <fprintf@plt>
    c7a2:	bf 65 00 00 00       	mov    $0x65,%edi
    c7a7:	e8 c4 5a ff ff       	call   2270 <exit@plt>
    c7ac:	e8 9f 58 ff ff       	call   2050 <abort@plt>
    c7b1:	66 66 66 66 66 66 2e 	data16 data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    c7b8:	0f 1f 84 00 00 00 00 
    c7bf:	00 

000000000000c7c0 <fwp_closure_drop_push>:
    c7c0:	55                   	push   %rbp
    c7c1:	41 57                	push   %r15
    c7c3:	41 56                	push   %r14
    c7c5:	41 55                	push   %r13
    c7c7:	41 54                	push   %r12
    c7c9:	53                   	push   %rbx
    c7ca:	50                   	push   %rax
    c7cb:	48 89 f3             	mov    %rsi,%rbx
    c7ce:	49 89 fe             	mov    %rdi,%r14
    c7d1:	4c 8b 6f 08          	mov    0x8(%rdi),%r13
    c7d5:	4c 3b 6f 10          	cmp    0x10(%rdi),%r13
    c7d9:	0f 85 ca 00 00 00    	jne    c8a9 <fwp_closure_drop_push+0xe9>
    c7df:	4c 89 e8             	mov    %r13,%rax
    c7e2:	48 c1 e8 3c          	shr    $0x3c,%rax
    c7e6:	0f 85 db 00 00 00    	jne    c8c7 <fwp_closure_drop_push+0x107>
    c7ec:	4a 8d 2c 6d 00 00 00 	lea    0x0(,%r13,2),%rbp
    c7f3:	00 
    c7f4:	49 c1 e5 04          	shl    $0x4,%r13
    c7f8:	49 83 fd 01          	cmp    $0x1,%r13
    c7fc:	49 83 d5 00          	adc    $0x0,%r13
    c800:	4c 89 ef             	mov    %r13,%rdi
    c803:	e8 48 5c ff ff       	call   2450 <fwp_pool_get>
    c808:	49 89 c7             	mov    %rax,%r15
    c80b:	4d 8b 26             	mov    (%r14),%r12
    c80e:	4d 8b 6e 08          	mov    0x8(%r14),%r13
    c812:	4a 8d 14 ed 00 00 00 	lea    0x0(,%r13,8),%rdx
    c819:	00 
    c81a:	48 89 c7             	mov    %rax,%rdi
    c81d:	4c 89 e6             	mov    %r12,%rsi
    c820:	e8 ab 59 ff ff       	call   21d0 <memcpy@plt>
    c825:	49 8d 46 18          	lea    0x18(%r14),%rax
    c829:	49 39 c4             	cmp    %rax,%r12
    c82c:	74 72                	je     c8a0 <fwp_closure_drop_push+0xe0>
    c82e:	4d 85 e4             	test   %r12,%r12
    c831:	74 6d                	je     c8a0 <fwp_closure_drop_push+0xe0>
    c833:	41 8b 44 24 f4       	mov    -0xc(%r12),%eax
    c838:	0f 1f 84 00 00 00 00 	nopl   0x0(%rax,%rax,1)
    c83f:	00 
    c840:	b1 01                	mov    $0x1,%cl
    c842:	86 0d a0 7b 00 00    	xchg   %cl,0x7ba0(%rip)        # 143e8 <fwp_static+0x848>
    c848:	84 c9                	test   %cl,%cl
    c84a:	75 f4                	jne    c840 <fwp_closure_drop_push+0x80>
    c84c:	49 29 c4             	sub    %rax,%r12
    c84f:	41 8b 44 24 f0       	mov    -0x10(%r12),%eax
    c854:	89 c1                	mov    %eax,%ecx
    c856:	c1 e9 02             	shr    $0x2,%ecx
    c859:	ba 01 00 00 00       	mov    $0x1,%edx
    c85e:	48 d3 e2             	shl    %cl,%rdx
    c861:	49 8d 4c 24 f0       	lea    -0x10(%r12),%rcx
    c866:	89 c6                	mov    %eax,%esi
    c868:	83 e6 03             	and    $0x3,%esi
    c86b:	48 89 d7             	mov    %rdx,%rdi
    c86e:	48 c1 ef 02          	shr    $0x2,%rdi
    c872:	48 0f af fe          	imul   %rsi,%rdi
    c876:	48 8d 35 23 73 00 00 	lea    0x7323(%rip),%rsi        # 13ba0 <fwp_static>
    c87d:	48 01 d7             	add    %rdx,%rdi
    c880:	48 29 3d 51 7b 00 00 	sub    %rdi,0x7b51(%rip)        # 143d8 <fwp_static+0x838>
    c887:	48 8b 54 c6 38       	mov    0x38(%rsi,%rax,8),%rdx
    c88c:	49 89 14 24          	mov    %rdx,(%r12)
    c890:	48 89 4c c6 38       	mov    %rcx,0x38(%rsi,%rax,8)
    c895:	c6 05 4c 7b 00 00 00 	movb   $0x0,0x7b4c(%rip)        # 143e8 <fwp_static+0x848>
    c89c:	4d 8b 6e 08          	mov    0x8(%r14),%r13
    c8a0:	4d 89 3e             	mov    %r15,(%r14)
    c8a3:	49 89 6e 10          	mov    %rbp,0x10(%r14)
    c8a7:	eb 03                	jmp    c8ac <fwp_closure_drop_push+0xec>
    c8a9:	4d 8b 3e             	mov    (%r14),%r15
    c8ac:	49 8d 45 01          	lea    0x1(%r13),%rax
    c8b0:	49 89 46 08          	mov    %rax,0x8(%r14)
    c8b4:	4b 89 1c ef          	mov    %rbx,(%r15,%r13,8)
    c8b8:	48 83 c4 08          	add    $0x8,%rsp
    c8bc:	5b                   	pop    %rbx
    c8bd:	41 5c                	pop    %r12
    c8bf:	41 5d                	pop    %r13
    c8c1:	41 5e                	pop    %r14
    c8c3:	41 5f                	pop    %r15
    c8c5:	5d                   	pop    %rbp
    c8c6:	c3                   	ret
    c8c7:	e8 94 a1 ff ff       	call   6a60 <fwp_flush>
    c8cc:	48 8b 05 0d 57 00 00 	mov    0x570d(%rip),%rax        # 11fe0 <stderr@GLIBC_2.2.5>
    c8d3:	48 8b 38             	mov    (%rax),%rdi
    c8d6:	48 8d 35 f0 2b 00 00 	lea    0x2bf0(%rip),%rsi        # f4cd <fwp_segv.msg+0x24d>
    c8dd:	48 8d 15 a6 2e 00 00 	lea    0x2ea6(%rip),%rdx        # f78a <fwp_segv.msg+0x50a>
    c8e4:	31 c0                	xor    %eax,%eax
    c8e6:	e8 b5 58 ff ff       	call   21a0 <fprintf@plt>
    c8eb:	bf 65 00 00 00       	mov    $0x65,%edi
    c8f0:	e8 7b 59 ff ff       	call   2270 <exit@plt>
    c8f5:	66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
    c8fc:	00 00 00 00 

000000000000c900 <fwp_closure_drop_release>:
    c900:	64 48 c7 04 25 f8 ff 	movq   $0x0,%fs:0xfffffffffffffff8
    c907:	ff ff 00 00 00 00 
    c90d:	48 8b 17             	mov    (%rdi),%rdx
    c910:	48 8d 47 18          	lea    0x18(%rdi),%rax
    c914:	48 39 c2             	cmp    %rax,%rdx
    c917:	74 75                	je     c98e <fwp_closure_drop_release+0x8e>
    c919:	48 85 d2             	test   %rdx,%rdx
    c91c:	74 70                	je     c98e <fwp_closure_drop_release+0x8e>
    c91e:	8b 4a f4             	mov    -0xc(%rdx),%ecx
    c921:	66 66 66 66 66 66 2e 	data16 data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    c928:	0f 1f 84 00 00 00 00 
    c92f:	00 
    c930:	40 b6 01             	mov    $0x1,%sil
    c933:	40 86 35 ae 7a 00 00 	xchg   %sil,0x7aae(%rip)        # 143e8 <fwp_static+0x848>
    c93a:	40 84 f6             	test   %sil,%sil
    c93d:	75 f1                	jne    c930 <fwp_closure_drop_release+0x30>
    c93f:	48 29 ca             	sub    %rcx,%rdx
    c942:	8b 72 f0             	mov    -0x10(%rdx),%esi
    c945:	89 f1                	mov    %esi,%ecx
    c947:	c1 e9 02             	shr    $0x2,%ecx
    c94a:	41 b8 01 00 00 00    	mov    $0x1,%r8d
    c950:	49 d3 e0             	shl    %cl,%r8
    c953:	48 8d 4a f0          	lea    -0x10(%rdx),%rcx
    c957:	41 89 f1             	mov    %esi,%r9d
    c95a:	41 83 e1 03          	and    $0x3,%r9d
    c95e:	4d 89 c2             	mov    %r8,%r10
    c961:	49 c1 ea 02          	shr    $0x2,%r10
    c965:	4d 0f af d1          	imul   %r9,%r10
    c969:	4c 8d 0d 30 72 00 00 	lea    0x7230(%rip),%r9        # 13ba0 <fwp_static>
    c970:	4d 01 c2             	add    %r8,%r10
    c973:	4c 29 15 5e 7a 00 00 	sub    %r10,0x7a5e(%rip)        # 143d8 <fwp_static+0x838>
    c97a:	4d 8b 44 f1 38       	mov    0x38(%r9,%rsi,8),%r8
    c97f:	4c 89 02             	mov    %r8,(%rdx)
    c982:	49 89 4c f1 38       	mov    %rcx,0x38(%r9,%rsi,8)
    c987:	c6 05 5a 7a 00 00 00 	movb   $0x0,0x7a5a(%rip)        # 143e8 <fwp_static+0x848>
    c98e:	48 89 07             	mov    %rax,(%rdi)
    c991:	48 c7 47 08 00 00 00 	movq   $0x0,0x8(%rdi)
    c998:	00 
    c999:	c3                   	ret
    c99a:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)

000000000000c9a0 <f52>:
    c9a0:	41 57                	push   %r15
    c9a2:	41 56                	push   %r14
    c9a4:	53                   	push   %rbx
    c9a5:	48 83 ec 30          	sub    $0x30,%rsp
    c9a9:	48 89 fb             	mov    %rdi,%rbx
    c9ac:	48 8b 47 10          	mov    0x10(%rdi),%rax
    c9b0:	48 2b 05 e1 67 00 00 	sub    0x67e1(%rip),%rax        # 13198 <fwp_gc+0x1030>
    c9b7:	48 8b 0d 02 68 00 00 	mov    0x6802(%rip),%rcx        # 131c0 <fwp_gc+0x1058>
    c9be:	48 c1 e1 10          	shl    $0x10,%rcx
    c9c2:	48 39 c8             	cmp    %rcx,%rax
    c9c5:	73 68                	jae    ca2f <f52+0x8f>
    c9c7:	48 8b 0d 12 68 00 00 	mov    0x6812(%rip),%rcx        # 131e0 <fwp_gc+0x1078>
    c9ce:	48 89 c2             	mov    %rax,%rdx
    c9d1:	48 c1 ea 10          	shr    $0x10,%rdx
    c9d5:	48 69 d2 28 12 00 00 	imul   $0x1228,%rdx,%rdx
    c9dc:	0f b6 34 11          	movzbl (%rcx,%rdx,1),%esi
    c9e0:	48 25 ff ff 00 00    	and    $0xffff,%rax
    c9e6:	75 13                	jne    c9fb <f52+0x5b>
    c9e8:	40 80 fe 02          	cmp    $0x2,%sil
    c9ec:	75 0d                	jne    c9fb <f52+0x5b>
    c9ee:	48 8d 3c 11          	lea    (%rcx,%rdx,1),%rdi
    c9f2:	48 81 c7 28 02 00 00 	add    $0x228,%rdi
    c9f9:	eb 21                	jmp    ca1c <f52+0x7c>
    c9fb:	40 80 fe 01          	cmp    $0x1,%sil
    c9ff:	75 2e                	jne    ca2f <f52+0x8f>
    ca01:	48 8d 34 11          	lea    (%rcx,%rdx,1),%rsi
    ca05:	8b 4c 11 20          	mov    0x20(%rcx,%rdx,1),%ecx
    ca09:	48 0f af c1          	imul   %rcx,%rax
    ca0d:	48 c1 e8 20          	shr    $0x20,%rax
    ca11:	48 8d 3c 30          	lea    (%rax,%rsi,1),%rdi
    ca15:	48 81 c7 28 02 00 00 	add    $0x228,%rdi
    ca1c:	0f b6 07             	movzbl (%rdi),%eax
    ca1f:	84 c0                	test   %al,%al
    ca21:	74 0c                	je     ca2f <f52+0x8f>
    ca23:	3c fe                	cmp    $0xfe,%al
    ca25:	0f 83 cb 02 00 00    	jae    ccf6 <f52+0x356>
    ca2b:	fe c0                	inc    %al
    ca2d:	88 07                	mov    %al,(%rdi)
    ca2f:	4c 8b 7b 08          	mov    0x8(%rbx),%r15
    ca33:	48 8b 7b 10          	mov    0x10(%rbx),%rdi
    ca37:	48 8b 43 18          	mov    0x18(%rbx),%rax
    ca3b:	4d 85 ff             	test   %r15,%r15
    ca3e:	78 20                	js     ca60 <f52+0xc0>
    ca40:	48 8b 0f             	mov    (%rdi),%rcx
    ca43:	48 ba ff ff ff ff ff 	movabs $0x7fffffffffffffff,%rdx
    ca4a:	ff ff 7f 
    ca4d:	48 21 ca             	and    %rcx,%rdx
    ca50:	4c 39 fa             	cmp    %r15,%rdx
    ca53:	76 0b                	jbe    ca60 <f52+0xc0>
    ca55:	48 85 c9             	test   %rcx,%rcx
    ca58:	78 79                	js     cad3 <f52+0x133>
    ca5a:	48 8d 4f 08          	lea    0x8(%rdi),%rcx
    ca5e:	eb 77                	jmp    cad7 <f52+0x137>
    ca60:	41 89 c6             	mov    %eax,%r14d
    ca63:	e8 68 03 00 00       	call   cdd0 <fwp_drop7>
    ca68:	4c 89 74 24 18       	mov    %r14,0x18(%rsp)
    ca6d:	48 8d 54 24 18       	lea    0x18(%rsp),%rdx
    ca72:	bf 01 00 00 00       	mov    $0x1,%edi
    ca77:	be 01 00 00 00       	mov    $0x1,%esi
    ca7c:	e8 cf d9 ff ff       	call   a450 <fwp_data>
    ca81:	49 89 c6             	mov    %rax,%r14
    ca84:	48 2b 05 0d 67 00 00 	sub    0x670d(%rip),%rax        # 13198 <fwp_gc+0x1030>
    ca8b:	48 8b 0d 2e 67 00 00 	mov    0x672e(%rip),%rcx        # 131c0 <fwp_gc+0x1058>
    ca92:	48 c1 e1 10          	shl    $0x10,%rcx
    ca96:	48 39 c8             	cmp    %rcx,%rax
    ca99:	0f 83 42 02 00 00    	jae    cce1 <f52+0x341>
    ca9f:	48 8b 0d 3a 67 00 00 	mov    0x673a(%rip),%rcx        # 131e0 <fwp_gc+0x1078>
    caa6:	48 89 c2             	mov    %rax,%rdx
    caa9:	48 c1 ea 10          	shr    $0x10,%rdx
    caad:	48 69 d2 28 12 00 00 	imul   $0x1228,%rdx,%rdx
    cab4:	0f b6 34 11          	movzbl (%rcx,%rdx,1),%esi
    cab8:	48 25 ff ff 00 00    	and    $0xffff,%rax
    cabe:	0f 85 ec 01 00 00    	jne    ccb0 <f52+0x310>
    cac4:	40 80 fe 02          	cmp    $0x2,%sil
    cac8:	0f 84 cb 01 00 00    	je     cc99 <f52+0x2f9>
    cace:	e9 dd 01 00 00       	jmp    ccb0 <f52+0x310>
    cad3:	48 8b 4f 10          	mov    0x10(%rdi),%rcx
    cad7:	89 44 24 0c          	mov    %eax,0xc(%rsp)
    cadb:	f3 42 0f 10 04 b9    	movss  (%rcx,%r15,4),%xmm0
    cae1:	f3 0f 59 05 1b 25 00 	mulss  0x251b(%rip),%xmm0        # f004 <_IO_stdin_used+0x4>
    cae8:	00 
    cae9:	f3 0f 58 05 17 25 00 	addss  0x2517(%rip),%xmm0        # f008 <_IO_stdin_used+0x8>
    caf0:	00 
    caf1:	f3 0f 11 44 24 08    	movss  %xmm0,0x8(%rsp)
    caf7:	48 89 f8             	mov    %rdi,%rax
    cafa:	48 2b 05 97 66 00 00 	sub    0x6697(%rip),%rax        # 13198 <fwp_gc+0x1030>
    cb01:	49 ff c7             	inc    %r15
    cb04:	48 8b 0d b5 66 00 00 	mov    0x66b5(%rip),%rcx        # 131c0 <fwp_gc+0x1058>
    cb0b:	48 c1 e1 10          	shl    $0x10,%rcx
    cb0f:	48 39 c8             	cmp    %rcx,%rax
    cb12:	73 66                	jae    cb7a <f52+0x1da>
    cb14:	48 8b 0d c5 66 00 00 	mov    0x66c5(%rip),%rcx        # 131e0 <fwp_gc+0x1078>
    cb1b:	48 89 c2             	mov    %rax,%rdx
    cb1e:	48 c1 ea 10          	shr    $0x10,%rdx
    cb22:	48 69 d2 28 12 00 00 	imul   $0x1228,%rdx,%rdx
    cb29:	0f b6 34 11          	movzbl (%rcx,%rdx,1),%esi
    cb2d:	48 25 ff ff 00 00    	and    $0xffff,%rax
    cb33:	75 12                	jne    cb47 <f52+0x1a7>
    cb35:	40 80 fe 02          	cmp    $0x2,%sil
    cb39:	75 0c                	jne    cb47 <f52+0x1a7>
    cb3b:	48 8d 04 11          	lea    (%rcx,%rdx,1),%rax
    cb3f:	48 05 28 02 00 00    	add    $0x228,%rax
    cb45:	eb 1f                	jmp    cb66 <f52+0x1c6>
    cb47:	40 80 fe 01          	cmp    $0x1,%sil
    cb4b:	75 2d                	jne    cb7a <f52+0x1da>
    cb4d:	48 8d 34 11          	lea    (%rcx,%rdx,1),%rsi
    cb51:	8b 4c 11 20          	mov    0x20(%rcx,%rdx,1),%ecx
    cb55:	48 0f af c1          	imul   %rcx,%rax
    cb59:	48 c1 e8 20          	shr    $0x20,%rax
    cb5d:	48 01 f0             	add    %rsi,%rax
    cb60:	48 05 28 02 00 00    	add    $0x228,%rax
    cb66:	0f b6 08             	movzbl (%rax),%ecx
    cb69:	84 c9                	test   %cl,%cl
    cb6b:	74 0d                	je     cb7a <f52+0x1da>
    cb6d:	80 f9 fe             	cmp    $0xfe,%cl
    cb70:	0f 83 8a 01 00 00    	jae    cd00 <f52+0x360>
    cb76:	fe c1                	inc    %cl
    cb78:	88 08                	mov    %cl,(%rax)
    cb7a:	49 89 fe             	mov    %rdi,%r14
    cb7d:	e8 4e 02 00 00       	call   cdd0 <fwp_drop7>
    cb82:	f3 0f 10 44 24 08    	movss  0x8(%rsp),%xmm0
    cb88:	f3 0f 58 44 24 0c    	addss  0xc(%rsp),%xmm0
    cb8e:	66 0f 7e c0          	movd   %xmm0,%eax
    cb92:	4c 89 7c 24 18       	mov    %r15,0x18(%rsp)
    cb97:	4c 89 74 24 20       	mov    %r14,0x20(%rsp)
    cb9c:	48 89 44 24 28       	mov    %rax,0x28(%rsp)
    cba1:	48 8d 54 24 18       	lea    0x18(%rsp),%rdx
    cba6:	31 ff                	xor    %edi,%edi
    cba8:	be 03 00 00 00       	mov    $0x3,%esi
    cbad:	e8 9e d8 ff ff       	call   a450 <fwp_data>
    cbb2:	48 89 c1             	mov    %rax,%rcx
    cbb5:	48 2b 0d dc 65 00 00 	sub    0x65dc(%rip),%rcx        # 13198 <fwp_gc+0x1030>
    cbbc:	48 8b 15 fd 65 00 00 	mov    0x65fd(%rip),%rdx        # 131c0 <fwp_gc+0x1058>
    cbc3:	48 c1 e2 10          	shl    $0x10,%rdx
    cbc7:	48 39 d1             	cmp    %rdx,%rcx
    cbca:	73 76                	jae    cc42 <f52+0x2a2>
    cbcc:	48 8b 15 0d 66 00 00 	mov    0x660d(%rip),%rdx        # 131e0 <fwp_gc+0x1078>
    cbd3:	48 89 ce             	mov    %rcx,%rsi
    cbd6:	48 c1 ee 10          	shr    $0x10,%rsi
    cbda:	48 69 f6 28 12 00 00 	imul   $0x1228,%rsi,%rsi
    cbe1:	0f b6 3c 32          	movzbl (%rdx,%rsi,1),%edi
    cbe5:	48 81 e1 ff ff 00 00 	and    $0xffff,%rcx
    cbec:	75 1d                	jne    cc0b <f52+0x26b>
    cbee:	40 80 ff 02          	cmp    $0x2,%dil
    cbf2:	75 17                	jne    cc0b <f52+0x26b>
    cbf4:	4c 8d 34 32          	lea    (%rdx,%rsi,1),%r14
    cbf8:	49 81 c6 28 02 00 00 	add    $0x228,%r14
    cbff:	41 80 3e ff          	cmpb   $0xff,(%r14)
    cc03:	74 2d                	je     cc32 <f52+0x292>
    cc05:	41 c6 06 01          	movb   $0x1,(%r14)
    cc09:	eb 37                	jmp    cc42 <f52+0x2a2>
    cc0b:	40 80 ff 01          	cmp    $0x1,%dil
    cc0f:	75 31                	jne    cc42 <f52+0x2a2>
    cc11:	48 8d 3c 32          	lea    (%rdx,%rsi,1),%rdi
    cc15:	8b 54 32 20          	mov    0x20(%rdx,%rsi,1),%edx
    cc19:	48 0f af ca          	imul   %rdx,%rcx
    cc1d:	48 c1 e9 20          	shr    $0x20,%rcx
    cc21:	4c 8d 34 39          	lea    (%rcx,%rdi,1),%r14
    cc25:	49 81 c6 28 02 00 00 	add    $0x228,%r14
    cc2c:	41 80 3e ff          	cmpb   $0xff,(%r14)
    cc30:	75 d3                	jne    cc05 <f52+0x265>
    cc32:	4c 89 f7             	mov    %r14,%rdi
    cc35:	49 89 c7             	mov    %rax,%r15
    cc38:	e8 53 9e ff ff       	call   6a90 <fwp_rc_forget_slot>
    cc3d:	4c 89 f8             	mov    %r15,%rax
    cc40:	eb c3                	jmp    cc05 <f52+0x265>
    cc42:	48 89 44 24 10       	mov    %rax,0x10(%rsp)
    cc47:	48 8d 54 24 10       	lea    0x10(%rsp),%rdx
    cc4c:	31 ff                	xor    %edi,%edi
    cc4e:	be 01 00 00 00       	mov    $0x1,%esi
    cc53:	e8 f8 d7 ff ff       	call   a450 <fwp_data>
    cc58:	49 89 c6             	mov    %rax,%r14
    cc5b:	48 2b 05 36 65 00 00 	sub    0x6536(%rip),%rax        # 13198 <fwp_gc+0x1030>
    cc62:	48 8b 0d 57 65 00 00 	mov    0x6557(%rip),%rcx        # 131c0 <fwp_gc+0x1058>
    cc69:	48 c1 e1 10          	shl    $0x10,%rcx
    cc6d:	48 39 c8             	cmp    %rcx,%rax
    cc70:	73 6f                	jae    cce1 <f52+0x341>
    cc72:	48 8b 0d 67 65 00 00 	mov    0x6567(%rip),%rcx        # 131e0 <fwp_gc+0x1078>
    cc79:	48 89 c2             	mov    %rax,%rdx
    cc7c:	48 c1 ea 10          	shr    $0x10,%rdx
    cc80:	48 69 d2 28 12 00 00 	imul   $0x1228,%rdx,%rdx
    cc87:	0f b6 34 11          	movzbl (%rcx,%rdx,1),%esi
    cc8b:	48 25 ff ff 00 00    	and    $0xffff,%rax
    cc91:	75 1d                	jne    ccb0 <f52+0x310>
    cc93:	40 80 fe 02          	cmp    $0x2,%sil
    cc97:	75 17                	jne    ccb0 <f52+0x310>
    cc99:	4c 8d 3c 11          	lea    (%rcx,%rdx,1),%r15
    cc9d:	49 81 c7 28 02 00 00 	add    $0x228,%r15
    cca4:	41 80 3f ff          	cmpb   $0xff,(%r15)
    cca8:	74 2d                	je     ccd7 <f52+0x337>
    ccaa:	41 c6 07 01          	movb   $0x1,(%r15)
    ccae:	eb 31                	jmp    cce1 <f52+0x341>
    ccb0:	40 80 fe 01          	cmp    $0x1,%sil
    ccb4:	75 2b                	jne    cce1 <f52+0x341>
    ccb6:	48 8d 34 11          	lea    (%rcx,%rdx,1),%rsi
    ccba:	8b 4c 11 20          	mov    0x20(%rcx,%rdx,1),%ecx
    ccbe:	48 0f af c1          	imul   %rcx,%rax
    ccc2:	48 c1 e8 20          	shr    $0x20,%rax
    ccc6:	4c 8d 3c 30          	lea    (%rax,%rsi,1),%r15
    ccca:	49 81 c7 28 02 00 00 	add    $0x228,%r15
    ccd1:	41 80 3f ff          	cmpb   $0xff,(%r15)
    ccd5:	75 d3                	jne    ccaa <f52+0x30a>
    ccd7:	4c 89 ff             	mov    %r15,%rdi
    ccda:	e8 b1 9d ff ff       	call   6a90 <fwp_rc_forget_slot>
    ccdf:	eb c9                	jmp    ccaa <f52+0x30a>
    cce1:	48 89 df             	mov    %rbx,%rdi
    cce4:	e8 37 00 00 00       	call   cd20 <fwp_drop8>
    cce9:	4c 89 f0             	mov    %r14,%rax
    ccec:	48 83 c4 30          	add    $0x30,%rsp
    ccf0:	5b                   	pop    %rbx
    ccf1:	41 5e                	pop    %r14
    ccf3:	41 5f                	pop    %r15
    ccf5:	c3                   	ret
    ccf6:	e8 25 af ff ff       	call   7c20 <fwp_rc_wide_dup>
    ccfb:	e9 2f fd ff ff       	jmp    ca2f <f52+0x8f>
    cd00:	49 89 fe             	mov    %rdi,%r14
    cd03:	48 89 c7             	mov    %rax,%rdi
    cd06:	e8 15 af ff ff       	call   7c20 <fwp_rc_wide_dup>
    cd0b:	4c 89 f7             	mov    %r14,%rdi
    cd0e:	e9 67 fe ff ff       	jmp    cb7a <f52+0x1da>
    cd13:	66 66 66 66 2e 0f 1f 	data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    cd1a:	84 00 00 00 00 00 

000000000000cd20 <fwp_drop8>:
    cd20:	48 89 f8             	mov    %rdi,%rax
    cd23:	48 2b 05 6e 64 00 00 	sub    0x646e(%rip),%rax        # 13198 <fwp_gc+0x1030>
    cd2a:	48 8b 0d 8f 64 00 00 	mov    0x648f(%rip),%rcx        # 131c0 <fwp_gc+0x1058>
    cd31:	48 c1 e1 10          	shl    $0x10,%rcx
    cd35:	48 39 c8             	cmp    %rcx,%rax
    cd38:	0f 83 83 00 00 00    	jae    cdc1 <fwp_drop8+0xa1>
    cd3e:	48 8b 0d 9b 64 00 00 	mov    0x649b(%rip),%rcx        # 131e0 <fwp_gc+0x1078>
    cd45:	48 89 c2             	mov    %rax,%rdx
    cd48:	48 c1 ea 10          	shr    $0x10,%rdx
    cd4c:	48 69 d2 28 12 00 00 	imul   $0x1228,%rdx,%rdx
    cd53:	0f b6 34 11          	movzbl (%rcx,%rdx,1),%esi
    cd57:	48 25 ff ff 00 00    	and    $0xffff,%rax
    cd5d:	75 12                	jne    cd71 <fwp_drop8+0x51>
    cd5f:	40 80 fe 02          	cmp    $0x2,%sil
    cd63:	75 0c                	jne    cd71 <fwp_drop8+0x51>
    cd65:	48 8d 04 11          	lea    (%rcx,%rdx,1),%rax
    cd69:	48 05 28 02 00 00    	add    $0x228,%rax
    cd6f:	eb 1f                	jmp    cd90 <fwp_drop8+0x70>
    cd71:	40 80 fe 01          	cmp    $0x1,%sil
    cd75:	75 4a                	jne    cdc1 <fwp_drop8+0xa1>
    cd77:	48 8d 34 11          	lea    (%rcx,%rdx,1),%rsi
    cd7b:	8b 4c 11 20          	mov    0x20(%rcx,%rdx,1),%ecx
    cd7f:	48 0f af c1          	imul   %rcx,%rax
    cd83:	48 c1 e8 20          	shr    $0x20,%rax
    cd87:	48 01 f0             	add    %rsi,%rax
    cd8a:	48 05 28 02 00 00    	add    $0x228,%rax
    cd90:	0f b6 08             	movzbl (%rax),%ecx
    cd93:	85 c9                	test   %ecx,%ecx
    cd95:	74 2a                	je     cdc1 <fwp_drop8+0xa1>
    cd97:	83 f9 01             	cmp    $0x1,%ecx
    cd9a:	75 19                	jne    cdb5 <fwp_drop8+0x95>
    cd9c:	53                   	push   %rbx
    cd9d:	48 8b 47 10          	mov    0x10(%rdi),%rax
    cda1:	48 89 fb             	mov    %rdi,%rbx
    cda4:	48 89 c7             	mov    %rax,%rdi
    cda7:	e8 24 00 00 00       	call   cdd0 <fwp_drop7>
    cdac:	48 89 df             	mov    %rbx,%rdi
    cdaf:	5b                   	pop    %rbx
    cdb0:	e9 bb e1 ff ff       	jmp    af70 <fwp_rc_free_obj>
    cdb5:	81 f9 ff 00 00 00    	cmp    $0xff,%ecx
    cdbb:	74 05                	je     cdc2 <fwp_drop8+0xa2>
    cdbd:	fe c9                	dec    %cl
    cdbf:	88 08                	mov    %cl,(%rax)
    cdc1:	c3                   	ret
    cdc2:	48 89 c7             	mov    %rax,%rdi
    cdc5:	e9 c6 de ff ff       	jmp    ac90 <fwp_rc_wide_drop>
    cdca:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)

000000000000cdd0 <fwp_drop7>:
    cdd0:	53                   	push   %rbx
    cdd1:	48 89 f8             	mov    %rdi,%rax
    cdd4:	48 2b 05 bd 63 00 00 	sub    0x63bd(%rip),%rax        # 13198 <fwp_gc+0x1030>
    cddb:	48 8b 0d de 63 00 00 	mov    0x63de(%rip),%rcx        # 131c0 <fwp_gc+0x1058>
    cde2:	48 c1 e1 10          	shl    $0x10,%rcx
    cde6:	48 39 c8             	cmp    %rcx,%rax
    cde9:	0f 83 9c 00 00 00    	jae    ce8b <fwp_drop7+0xbb>
    cdef:	48 8b 0d ea 63 00 00 	mov    0x63ea(%rip),%rcx        # 131e0 <fwp_gc+0x1078>
    cdf6:	48 89 c2             	mov    %rax,%rdx
    cdf9:	48 c1 ea 10          	shr    $0x10,%rdx
    cdfd:	48 69 d2 28 12 00 00 	imul   $0x1228,%rdx,%rdx
    ce04:	0f b6 34 11          	movzbl (%rcx,%rdx,1),%esi
    ce08:	48 25 ff ff 00 00    	and    $0xffff,%rax
    ce0e:	75 20                	jne    ce30 <fwp_drop7+0x60>
    ce10:	40 80 fe 02          	cmp    $0x2,%sil
    ce14:	75 1a                	jne    ce30 <fwp_drop7+0x60>
    ce16:	48 8d 04 11          	lea    (%rcx,%rdx,1),%rax
    ce1a:	48 05 28 02 00 00    	add    $0x228,%rax
    ce20:	eb 2d                	jmp    ce4f <fwp_drop7+0x7f>
    ce22:	66 66 66 66 66 2e 0f 	data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    ce29:	1f 84 00 00 00 00 00 
    ce30:	40 80 fe 01          	cmp    $0x1,%sil
    ce34:	75 55                	jne    ce8b <fwp_drop7+0xbb>
    ce36:	48 8d 34 11          	lea    (%rcx,%rdx,1),%rsi
    ce3a:	8b 4c 11 20          	mov    0x20(%rcx,%rdx,1),%ecx
    ce3e:	48 0f af c1          	imul   %rcx,%rax
    ce42:	48 c1 e8 20          	shr    $0x20,%rax
    ce46:	48 01 f0             	add    %rsi,%rax
    ce49:	48 05 28 02 00 00    	add    $0x228,%rax
    ce4f:	0f b6 08             	movzbl (%rax),%ecx
    ce52:	85 c9                	test   %ecx,%ecx
    ce54:	74 35                	je     ce8b <fwp_drop7+0xbb>
    ce56:	83 f9 01             	cmp    $0x1,%ecx
    ce59:	75 32                	jne    ce8d <fwp_drop7+0xbd>
    ce5b:	48 83 3f 00          	cmpq   $0x0,(%rdi)
    ce5f:	79 3a                	jns    ce9b <fwp_drop7+0xcb>
    ce61:	48 8b 5f 08          	mov    0x8(%rdi),%rbx
    ce65:	e8 16 dd ff ff       	call   ab80 <fwp_rc_free_arr>
    ce6a:	48 89 d8             	mov    %rbx,%rax
    ce6d:	48 2b 05 24 63 00 00 	sub    0x6324(%rip),%rax        # 13198 <fwp_gc+0x1030>
    ce74:	48 8b 0d 45 63 00 00 	mov    0x6345(%rip),%rcx        # 131c0 <fwp_gc+0x1058>
    ce7b:	48 c1 e1 10          	shl    $0x10,%rcx
    ce7f:	48 89 df             	mov    %rbx,%rdi
    ce82:	48 39 c8             	cmp    %rcx,%rax
    ce85:	0f 82 64 ff ff ff    	jb     cdef <fwp_drop7+0x1f>
    ce8b:	5b                   	pop    %rbx
    ce8c:	c3                   	ret
    ce8d:	81 f9 ff 00 00 00    	cmp    $0xff,%ecx
    ce93:	74 0c                	je     cea1 <fwp_drop7+0xd1>
    ce95:	fe c9                	dec    %cl
    ce97:	88 08                	mov    %cl,(%rax)
    ce99:	5b                   	pop    %rbx
    ce9a:	c3                   	ret
    ce9b:	5b                   	pop    %rbx
    ce9c:	e9 df dc ff ff       	jmp    ab80 <fwp_rc_free_arr>
    cea1:	48 89 c7             	mov    %rax,%rdi
    cea4:	5b                   	pop    %rbx
    cea5:	e9 e6 dd ff ff       	jmp    ac90 <fwp_rc_wide_drop>
    ceaa:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)

000000000000ceb0 <fwp_owned_entry52>:
    ceb0:	48 8b 3f             	mov    (%rdi),%rdi
    ceb3:	e9 e8 fa ff ff       	jmp    c9a0 <f52>
    ceb8:	0f 1f 84 00 00 00 00 	nopl   0x0(%rax,%rax,1)
    cebf:	00 

000000000000cec0 <fwp_caps52>:
    cec0:	53                   	push   %rbx
    cec1:	83 7f 04 00          	cmpl   $0x0,0x4(%rdi)
    cec5:	74 56                	je     cf1d <fwp_caps52+0x5d>
    cec7:	48 89 fb             	mov    %rdi,%rbx
    ceca:	48 8b 7f 08          	mov    0x8(%rdi),%rdi
    cece:	85 f6                	test   %esi,%esi
    ced0:	74 51                	je     cf23 <fwp_caps52+0x63>
    ced2:	48 2b 3d bf 62 00 00 	sub    0x62bf(%rip),%rdi        # 13198 <fwp_gc+0x1030>
    ced9:	48 8b 05 e0 62 00 00 	mov    0x62e0(%rip),%rax        # 131c0 <fwp_gc+0x1058>
    cee0:	48 c1 e0 10          	shl    $0x10,%rax
    cee4:	48 39 c7             	cmp    %rax,%rdi
    cee7:	73 38                	jae    cf21 <fwp_caps52+0x61>
    cee9:	48 8b 05 f0 62 00 00 	mov    0x62f0(%rip),%rax        # 131e0 <fwp_gc+0x1078>
    cef0:	48 89 f9             	mov    %rdi,%rcx
    cef3:	48 c1 e9 10          	shr    $0x10,%rcx
    cef7:	48 69 c9 28 12 00 00 	imul   $0x1228,%rcx,%rcx
    cefe:	0f b6 14 08          	movzbl (%rax,%rcx,1),%edx
    cf02:	48 81 e7 ff ff 00 00 	and    $0xffff,%rdi
    cf09:	75 26                	jne    cf31 <fwp_caps52+0x71>
    cf0b:	80 fa 02             	cmp    $0x2,%dl
    cf0e:	75 21                	jne    cf31 <fwp_caps52+0x71>
    cf10:	48 8d 3c 08          	lea    (%rax,%rcx,1),%rdi
    cf14:	48 81 c7 28 02 00 00 	add    $0x228,%rdi
    cf1b:	eb 33                	jmp    cf50 <fwp_caps52+0x90>
    cf1d:	85 f6                	test   %esi,%esi
    cf1f:	74 0a                	je     cf2b <fwp_caps52+0x6b>
    cf21:	5b                   	pop    %rbx
    cf22:	c3                   	ret
    cf23:	e8 f8 fd ff ff       	call   cd20 <fwp_drop8>
    cf28:	48 89 df             	mov    %rbx,%rdi
    cf2b:	5b                   	pop    %rbx
    cf2c:	e9 3f e0 ff ff       	jmp    af70 <fwp_rc_free_obj>
    cf31:	80 fa 01             	cmp    $0x1,%dl
    cf34:	75 eb                	jne    cf21 <fwp_caps52+0x61>
    cf36:	48 8d 14 08          	lea    (%rax,%rcx,1),%rdx
    cf3a:	8b 44 08 20          	mov    0x20(%rax,%rcx,1),%eax
    cf3e:	48 0f af f8          	imul   %rax,%rdi
    cf42:	48 c1 ef 20          	shr    $0x20,%rdi
    cf46:	48 01 d7             	add    %rdx,%rdi
    cf49:	48 81 c7 28 02 00 00 	add    $0x228,%rdi
    cf50:	0f b6 07             	movzbl (%rdi),%eax
    cf53:	84 c0                	test   %al,%al
    cf55:	74 ca                	je     cf21 <fwp_caps52+0x61>
    cf57:	3c fe                	cmp    $0xfe,%al
    cf59:	73 06                	jae    cf61 <fwp_caps52+0xa1>
    cf5b:	fe c0                	inc    %al
    cf5d:	88 07                	mov    %al,(%rdi)
    cf5f:	5b                   	pop    %rbx
    cf60:	c3                   	ret
    cf61:	5b                   	pop    %rbx
    cf62:	e9 b9 ac ff ff       	jmp    7c20 <fwp_rc_wide_dup>
    cf67:	66 0f 1f 84 00 00 00 	nopw   0x0(%rax,%rax,1)
    cf6e:	00 00 

000000000000cf70 <fwp_args52>:
    cf70:	85 f6                	test   %esi,%esi
    cf72:	0f 85 8a 00 00 00    	jne    d002 <fwp_args52+0x92>
    cf78:	85 d2                	test   %edx,%edx
    cf7a:	0f 84 82 00 00 00    	je     d002 <fwp_args52+0x92>
    cf80:	48 8b 07             	mov    (%rdi),%rax
    cf83:	48 2b 05 0e 62 00 00 	sub    0x620e(%rip),%rax        # 13198 <fwp_gc+0x1030>
    cf8a:	48 8b 0d 2f 62 00 00 	mov    0x622f(%rip),%rcx        # 131c0 <fwp_gc+0x1058>
    cf91:	48 c1 e1 10          	shl    $0x10,%rcx
    cf95:	48 39 c8             	cmp    %rcx,%rax
    cf98:	73 68                	jae    d002 <fwp_args52+0x92>
    cf9a:	48 8b 0d 3f 62 00 00 	mov    0x623f(%rip),%rcx        # 131e0 <fwp_gc+0x1078>
    cfa1:	48 89 c2             	mov    %rax,%rdx
    cfa4:	48 c1 ea 10          	shr    $0x10,%rdx
    cfa8:	48 69 d2 28 12 00 00 	imul   $0x1228,%rdx,%rdx
    cfaf:	0f b6 34 11          	movzbl (%rcx,%rdx,1),%esi
    cfb3:	48 25 ff ff 00 00    	and    $0xffff,%rax
    cfb9:	75 13                	jne    cfce <fwp_args52+0x5e>
    cfbb:	40 80 fe 02          	cmp    $0x2,%sil
    cfbf:	75 0d                	jne    cfce <fwp_args52+0x5e>
    cfc1:	48 8d 3c 11          	lea    (%rcx,%rdx,1),%rdi
    cfc5:	48 81 c7 28 02 00 00 	add    $0x228,%rdi
    cfcc:	eb 21                	jmp    cfef <fwp_args52+0x7f>
    cfce:	40 80 fe 01          	cmp    $0x1,%sil
    cfd2:	75 2e                	jne    d002 <fwp_args52+0x92>
    cfd4:	48 8d 34 11          	lea    (%rcx,%rdx,1),%rsi
    cfd8:	8b 4c 11 20          	mov    0x20(%rcx,%rdx,1),%ecx
    cfdc:	48 0f af c1          	imul   %rcx,%rax
    cfe0:	48 c1 e8 20          	shr    $0x20,%rax
    cfe4:	48 8d 3c 30          	lea    (%rax,%rsi,1),%rdi
    cfe8:	48 81 c7 28 02 00 00 	add    $0x228,%rdi
    cfef:	0f b6 07             	movzbl (%rdi),%eax
    cff2:	84 c0                	test   %al,%al
    cff4:	74 0c                	je     d002 <fwp_args52+0x92>
    cff6:	3c fe                	cmp    $0xfe,%al
    cff8:	0f 83 22 ac ff ff    	jae    7c20 <fwp_rc_wide_dup>
    cffe:	fe c0                	inc    %al
    d000:	88 07                	mov    %al,(%rdi)
    d002:	c3                   	ret
    d003:	66 66 66 66 2e 0f 1f 	data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    d00a:	84 00 00 00 00 00 

000000000000d010 <fwp_arg_drop52>:
    d010:	85 f6                	test   %esi,%esi
    d012:	75 0c                	jne    d020 <fwp_arg_drop52+0x10>
    d014:	85 d2                	test   %edx,%edx
    d016:	74 08                	je     d020 <fwp_arg_drop52+0x10>
    d018:	48 8b 3f             	mov    (%rdi),%rdi
    d01b:	e9 00 fd ff ff       	jmp    cd20 <fwp_drop8>
    d020:	c3                   	ret
    d021:	66 66 66 66 66 66 2e 	data16 data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    d028:	0f 1f 84 00 00 00 00 
    d02f:	00 

000000000000d030 <f55>:
    d030:	41 57                	push   %r15
    d032:	41 56                	push   %r14
    d034:	41 54                	push   %r12
    d036:	53                   	push   %rbx
    d037:	48 83 ec 78          	sub    $0x78,%rsp
    d03b:	48 89 fb             	mov    %rdi,%rbx
    d03e:	48 8b 47 10          	mov    0x10(%rdi),%rax
    d042:	48 2b 05 4f 61 00 00 	sub    0x614f(%rip),%rax        # 13198 <fwp_gc+0x1030>
    d049:	48 8b 0d 70 61 00 00 	mov    0x6170(%rip),%rcx        # 131c0 <fwp_gc+0x1058>
    d050:	48 c1 e1 10          	shl    $0x10,%rcx
    d054:	48 39 c8             	cmp    %rcx,%rax
    d057:	73 68                	jae    d0c1 <f55+0x91>
    d059:	48 8b 0d 80 61 00 00 	mov    0x6180(%rip),%rcx        # 131e0 <fwp_gc+0x1078>
    d060:	48 89 c2             	mov    %rax,%rdx
    d063:	48 c1 ea 10          	shr    $0x10,%rdx
    d067:	48 69 d2 28 12 00 00 	imul   $0x1228,%rdx,%rdx
    d06e:	0f b6 34 11          	movzbl (%rcx,%rdx,1),%esi
    d072:	48 25 ff ff 00 00    	and    $0xffff,%rax
    d078:	75 13                	jne    d08d <f55+0x5d>
    d07a:	40 80 fe 02          	cmp    $0x2,%sil
    d07e:	75 0d                	jne    d08d <f55+0x5d>
    d080:	48 8d 3c 11          	lea    (%rcx,%rdx,1),%rdi
    d084:	48 81 c7 28 02 00 00 	add    $0x228,%rdi
    d08b:	eb 21                	jmp    d0ae <f55+0x7e>
    d08d:	40 80 fe 01          	cmp    $0x1,%sil
    d091:	75 2e                	jne    d0c1 <f55+0x91>
    d093:	48 8d 34 11          	lea    (%rcx,%rdx,1),%rsi
    d097:	8b 4c 11 20          	mov    0x20(%rcx,%rdx,1),%ecx
    d09b:	48 0f af c1          	imul   %rcx,%rax
    d09f:	48 c1 e8 20          	shr    $0x20,%rax
    d0a3:	48 8d 3c 30          	lea    (%rax,%rsi,1),%rdi
    d0a7:	48 81 c7 28 02 00 00 	add    $0x228,%rdi
    d0ae:	0f b6 07             	movzbl (%rdi),%eax
    d0b1:	84 c0                	test   %al,%al
    d0b3:	74 0c                	je     d0c1 <f55+0x91>
    d0b5:	3c fe                	cmp    $0xfe,%al
    d0b7:	0f 83 bd 02 00 00    	jae    d37a <f55+0x34a>
    d0bd:	fe c0                	inc    %al
    d0bf:	88 07                	mov    %al,(%rdi)
    d0c1:	4c 8b 63 08          	mov    0x8(%rbx),%r12
    d0c5:	4c 8b 73 10          	mov    0x10(%rbx),%r14
    d0c9:	4c 8b 7b 18          	mov    0x18(%rbx),%r15
    d0cd:	4d 85 e4             	test   %r12,%r12
    d0d0:	78 20                	js     d0f2 <f55+0xc2>
    d0d2:	49 8b 06             	mov    (%r14),%rax
    d0d5:	48 b9 ff ff ff ff ff 	movabs $0x7fffffffffffffff,%rcx
    d0dc:	ff ff 7f 
    d0df:	48 21 c1             	and    %rax,%rcx
    d0e2:	4c 39 e1             	cmp    %r12,%rcx
    d0e5:	76 0b                	jbe    d0f2 <f55+0xc2>
    d0e7:	48 85 c0             	test   %rax,%rax
    d0ea:	78 79                	js     d165 <f55+0x135>
    d0ec:	49 8d 46 08          	lea    0x8(%r14),%rax
    d0f0:	eb 77                	jmp    d169 <f55+0x139>
    d0f2:	4c 89 f7             	mov    %r14,%rdi
    d0f5:	e8 a6 03 00 00       	call   d4a0 <fwp_drop9>
    d0fa:	4c 89 7c 24 10       	mov    %r15,0x10(%rsp)
    d0ff:	48 8d 54 24 10       	lea    0x10(%rsp),%rdx
    d104:	bf 01 00 00 00       	mov    $0x1,%edi
    d109:	be 01 00 00 00       	mov    $0x1,%esi
    d10e:	e8 3d d3 ff ff       	call   a450 <fwp_data>
    d113:	49 89 c6             	mov    %rax,%r14
    d116:	48 2b 05 7b 60 00 00 	sub    0x607b(%rip),%rax        # 13198 <fwp_gc+0x1030>
    d11d:	48 8b 0d 9c 60 00 00 	mov    0x609c(%rip),%rcx        # 131c0 <fwp_gc+0x1058>
    d124:	48 c1 e1 10          	shl    $0x10,%rcx
    d128:	48 39 c8             	cmp    %rcx,%rax
    d12b:	0f 83 32 02 00 00    	jae    d363 <f55+0x333>
    d131:	48 8b 0d a8 60 00 00 	mov    0x60a8(%rip),%rcx        # 131e0 <fwp_gc+0x1078>
    d138:	48 89 c2             	mov    %rax,%rdx
    d13b:	48 c1 ea 10          	shr    $0x10,%rdx
    d13f:	48 69 d2 28 12 00 00 	imul   $0x1228,%rdx,%rdx
    d146:	0f b6 34 11          	movzbl (%rcx,%rdx,1),%esi
    d14a:	48 25 ff ff 00 00    	and    $0xffff,%rax
    d150:	0f 85 dc 01 00 00    	jne    d332 <f55+0x302>
    d156:	40 80 fe 02          	cmp    $0x2,%sil
    d15a:	0f 84 bb 01 00 00    	je     d31b <f55+0x2eb>
    d160:	e9 cd 01 00 00       	jmp    d332 <f55+0x302>
    d165:	49 8b 46 10          	mov    0x10(%r14),%rax
    d169:	4a 0f be 04 20       	movsbq (%rax,%r12,1),%rax
    d16e:	48 83 c0 81          	add    $0xffffffffffffff81,%rax
    d172:	48 3d ff fe ff ff    	cmp    $0xfffffffffffffeff,%rax
    d178:	0f 86 10 02 00 00    	jbe    d38e <f55+0x35e>
    d17e:	4c 89 f0             	mov    %r14,%rax
    d181:	48 2b 05 10 60 00 00 	sub    0x6010(%rip),%rax        # 13198 <fwp_gc+0x1030>
    d188:	48 8b 0d 31 60 00 00 	mov    0x6031(%rip),%rcx        # 131c0 <fwp_gc+0x1058>
    d18f:	48 c1 e1 10          	shl    $0x10,%rcx
    d193:	48 39 c8             	cmp    %rcx,%rax
    d196:	73 68                	jae    d200 <f55+0x1d0>
    d198:	48 8b 0d 41 60 00 00 	mov    0x6041(%rip),%rcx        # 131e0 <fwp_gc+0x1078>
    d19f:	48 89 c2             	mov    %rax,%rdx
    d1a2:	48 c1 ea 10          	shr    $0x10,%rdx
    d1a6:	48 69 d2 28 12 00 00 	imul   $0x1228,%rdx,%rdx
    d1ad:	0f b6 34 11          	movzbl (%rcx,%rdx,1),%esi
    d1b1:	48 25 ff ff 00 00    	and    $0xffff,%rax
    d1b7:	75 13                	jne    d1cc <f55+0x19c>
    d1b9:	40 80 fe 02          	cmp    $0x2,%sil
    d1bd:	75 0d                	jne    d1cc <f55+0x19c>
    d1bf:	48 8d 3c 11          	lea    (%rcx,%rdx,1),%rdi
    d1c3:	48 81 c7 28 02 00 00 	add    $0x228,%rdi
    d1ca:	eb 21                	jmp    d1ed <f55+0x1bd>
    d1cc:	40 80 fe 01          	cmp    $0x1,%sil
    d1d0:	75 2e                	jne    d200 <f55+0x1d0>
    d1d2:	48 8d 34 11          	lea    (%rcx,%rdx,1),%rsi
    d1d6:	8b 4c 11 20          	mov    0x20(%rcx,%rdx,1),%ecx
    d1da:	48 0f af c1          	imul   %rcx,%rax
    d1de:	48 c1 e8 20          	shr    $0x20,%rax
    d1e2:	48 8d 3c 30          	lea    (%rax,%rsi,1),%rdi
    d1e6:	48 81 c7 28 02 00 00 	add    $0x228,%rdi
    d1ed:	0f b6 07             	movzbl (%rdi),%eax
    d1f0:	84 c0                	test   %al,%al
    d1f2:	74 0c                	je     d200 <f55+0x1d0>
    d1f4:	3c fe                	cmp    $0xfe,%al
    d1f6:	0f 83 88 01 00 00    	jae    d384 <f55+0x354>
    d1fc:	fe c0                	inc    %al
    d1fe:	88 07                	mov    %al,(%rdi)
    d200:	4c 89 f7             	mov    %r14,%rdi
    d203:	e8 98 02 00 00       	call   d4a0 <fwp_drop9>
    d208:	49 ff c7             	inc    %r15
    d20b:	0f 80 8d 01 00 00    	jo     d39e <f55+0x36e>
    d211:	49 ff c4             	inc    %r12
    d214:	4c 89 64 24 10       	mov    %r12,0x10(%rsp)
    d219:	4c 89 74 24 18       	mov    %r14,0x18(%rsp)
    d21e:	4c 89 7c 24 20       	mov    %r15,0x20(%rsp)
    d223:	48 8d 54 24 10       	lea    0x10(%rsp),%rdx
    d228:	31 ff                	xor    %edi,%edi
    d22a:	be 03 00 00 00       	mov    $0x3,%esi
    d22f:	e8 1c d2 ff ff       	call   a450 <fwp_data>
    d234:	48 89 c1             	mov    %rax,%rcx
    d237:	48 2b 0d 5a 5f 00 00 	sub    0x5f5a(%rip),%rcx        # 13198 <fwp_gc+0x1030>
    d23e:	48 8b 15 7b 5f 00 00 	mov    0x5f7b(%rip),%rdx        # 131c0 <fwp_gc+0x1058>
    d245:	48 c1 e2 10          	shl    $0x10,%rdx
    d249:	48 39 d1             	cmp    %rdx,%rcx
    d24c:	73 76                	jae    d2c4 <f55+0x294>
    d24e:	48 8b 15 8b 5f 00 00 	mov    0x5f8b(%rip),%rdx        # 131e0 <fwp_gc+0x1078>
    d255:	48 89 ce             	mov    %rcx,%rsi
    d258:	48 c1 ee 10          	shr    $0x10,%rsi
    d25c:	48 69 f6 28 12 00 00 	imul   $0x1228,%rsi,%rsi
    d263:	0f b6 3c 32          	movzbl (%rdx,%rsi,1),%edi
    d267:	48 81 e1 ff ff 00 00 	and    $0xffff,%rcx
    d26e:	75 1d                	jne    d28d <f55+0x25d>
    d270:	40 80 ff 02          	cmp    $0x2,%dil
    d274:	75 17                	jne    d28d <f55+0x25d>
    d276:	4c 8d 34 32          	lea    (%rdx,%rsi,1),%r14
    d27a:	49 81 c6 28 02 00 00 	add    $0x228,%r14
    d281:	41 80 3e ff          	cmpb   $0xff,(%r14)
    d285:	74 2d                	je     d2b4 <f55+0x284>
    d287:	41 c6 06 01          	movb   $0x1,(%r14)
    d28b:	eb 37                	jmp    d2c4 <f55+0x294>
    d28d:	40 80 ff 01          	cmp    $0x1,%dil
    d291:	75 31                	jne    d2c4 <f55+0x294>
    d293:	48 8d 3c 32          	lea    (%rdx,%rsi,1),%rdi
    d297:	8b 54 32 20          	mov    0x20(%rdx,%rsi,1),%edx
    d29b:	48 0f af ca          	imul   %rdx,%rcx
    d29f:	48 c1 e9 20          	shr    $0x20,%rcx
    d2a3:	4c 8d 34 39          	lea    (%rcx,%rdi,1),%r14
    d2a7:	49 81 c6 28 02 00 00 	add    $0x228,%r14
    d2ae:	41 80 3e ff          	cmpb   $0xff,(%r14)
    d2b2:	75 d3                	jne    d287 <f55+0x257>
    d2b4:	4c 89 f7             	mov    %r14,%rdi
    d2b7:	49 89 c7             	mov    %rax,%r15
    d2ba:	e8 d1 97 ff ff       	call   6a90 <fwp_rc_forget_slot>
    d2bf:	4c 89 f8             	mov    %r15,%rax
    d2c2:	eb c3                	jmp    d287 <f55+0x257>
    d2c4:	48 89 44 24 08       	mov    %rax,0x8(%rsp)
    d2c9:	48 8d 54 24 08       	lea    0x8(%rsp),%rdx
    d2ce:	31 ff                	xor    %edi,%edi
    d2d0:	be 01 00 00 00       	mov    $0x1,%esi
    d2d5:	e8 76 d1 ff ff       	call   a450 <fwp_data>
    d2da:	49 89 c6             	mov    %rax,%r14
    d2dd:	48 2b 05 b4 5e 00 00 	sub    0x5eb4(%rip),%rax        # 13198 <fwp_gc+0x1030>
    d2e4:	48 8b 0d d5 5e 00 00 	mov    0x5ed5(%rip),%rcx        # 131c0 <fwp_gc+0x1058>
    d2eb:	48 c1 e1 10          	shl    $0x10,%rcx
    d2ef:	48 39 c8             	cmp    %rcx,%rax
    d2f2:	73 6f                	jae    d363 <f55+0x333>
    d2f4:	48 8b 0d e5 5e 00 00 	mov    0x5ee5(%rip),%rcx        # 131e0 <fwp_gc+0x1078>
    d2fb:	48 89 c2             	mov    %rax,%rdx
    d2fe:	48 c1 ea 10          	shr    $0x10,%rdx
    d302:	48 69 d2 28 12 00 00 	imul   $0x1228,%rdx,%rdx
    d309:	0f b6 34 11          	movzbl (%rcx,%rdx,1),%esi
    d30d:	48 25 ff ff 00 00    	and    $0xffff,%rax
    d313:	75 1d                	jne    d332 <f55+0x302>
    d315:	40 80 fe 02          	cmp    $0x2,%sil
    d319:	75 17                	jne    d332 <f55+0x302>
    d31b:	4c 8d 3c 11          	lea    (%rcx,%rdx,1),%r15
    d31f:	49 81 c7 28 02 00 00 	add    $0x228,%r15
    d326:	41 80 3f ff          	cmpb   $0xff,(%r15)
    d32a:	74 2d                	je     d359 <f55+0x329>
    d32c:	41 c6 07 01          	movb   $0x1,(%r15)
    d330:	eb 31                	jmp    d363 <f55+0x333>
    d332:	40 80 fe 01          	cmp    $0x1,%sil
    d336:	75 2b                	jne    d363 <f55+0x333>
    d338:	48 8d 34 11          	lea    (%rcx,%rdx,1),%rsi
    d33c:	8b 4c 11 20          	mov    0x20(%rcx,%rdx,1),%ecx
    d340:	48 0f af c1          	imul   %rcx,%rax
    d344:	48 c1 e8 20          	shr    $0x20,%rax
    d348:	4c 8d 3c 30          	lea    (%rax,%rsi,1),%r15
    d34c:	49 81 c7 28 02 00 00 	add    $0x228,%r15
    d353:	41 80 3f ff          	cmpb   $0xff,(%r15)
    d357:	75 d3                	jne    d32c <f55+0x2fc>
    d359:	4c 89 ff             	mov    %r15,%rdi
    d35c:	e8 2f 97 ff ff       	call   6a90 <fwp_rc_forget_slot>
    d361:	eb c9                	jmp    d32c <f55+0x2fc>
    d363:	48 89 df             	mov    %rbx,%rdi
    d366:	e8 85 00 00 00       	call   d3f0 <fwp_drop10>
    d36b:	4c 89 f0             	mov    %r14,%rax
    d36e:	48 83 c4 78          	add    $0x78,%rsp
    d372:	5b                   	pop    %rbx
    d373:	41 5c                	pop    %r12
    d375:	41 5e                	pop    %r14
    d377:	41 5f                	pop    %r15
    d379:	c3                   	ret
    d37a:	e8 a1 a8 ff ff       	call   7c20 <fwp_rc_wide_dup>
    d37f:	e9 3d fd ff ff       	jmp    d0c1 <f55+0x91>
    d384:	e8 97 a8 ff ff       	call   7c20 <fwp_rc_wide_dup>
    d389:	e9 72 fe ff ff       	jmp    d200 <f55+0x1d0>
    d38e:	48 8d 15 9d 23 00 00 	lea    0x239d(%rip),%rdx        # f732 <fwp_segv.msg+0x4b2>
    d395:	48 8d 0d ae 22 00 00 	lea    0x22ae(%rip),%rcx        # f64a <fwp_segv.msg+0x3ca>
    d39c:	eb 0e                	jmp    d3ac <f55+0x37c>
    d39e:	48 8d 15 8d 23 00 00 	lea    0x238d(%rip),%rdx        # f732 <fwp_segv.msg+0x4b2>
    d3a5:	48 8d 0d a0 23 00 00 	lea    0x23a0(%rip),%rcx        # f74c <fwp_segv.msg+0x4cc>
    d3ac:	48 8d 5c 24 10       	lea    0x10(%rsp),%rbx
    d3b1:	be 60 00 00 00       	mov    $0x60,%esi
    d3b6:	48 89 df             	mov    %rbx,%rdi
    d3b9:	31 c0                	xor    %eax,%eax
    d3bb:	e8 40 4d ff ff       	call   2100 <snprintf@plt>
    d3c0:	e8 9b 96 ff ff       	call   6a60 <fwp_flush>
    d3c5:	48 8b 05 14 4c 00 00 	mov    0x4c14(%rip),%rax        # 11fe0 <stderr@GLIBC_2.2.5>
    d3cc:	48 8b 38             	mov    (%rax),%rdi
    d3cf:	48 8d 35 f7 20 00 00 	lea    0x20f7(%rip),%rsi        # f4cd <fwp_segv.msg+0x24d>
    d3d6:	48 89 da             	mov    %rbx,%rdx
    d3d9:	31 c0                	xor    %eax,%eax
    d3db:	e8 c0 4d ff ff       	call   21a0 <fprintf@plt>
    d3e0:	bf 65 00 00 00       	mov    $0x65,%edi
    d3e5:	e8 86 4e ff ff       	call   2270 <exit@plt>
    d3ea:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)

000000000000d3f0 <fwp_drop10>:
    d3f0:	48 89 f8             	mov    %rdi,%rax
    d3f3:	48 2b 05 9e 5d 00 00 	sub    0x5d9e(%rip),%rax        # 13198 <fwp_gc+0x1030>
    d3fa:	48 8b 0d bf 5d 00 00 	mov    0x5dbf(%rip),%rcx        # 131c0 <fwp_gc+0x1058>
    d401:	48 c1 e1 10          	shl    $0x10,%rcx
    d405:	48 39 c8             	cmp    %rcx,%rax
    d408:	0f 83 83 00 00 00    	jae    d491 <fwp_drop10+0xa1>
    d40e:	48 8b 0d cb 5d 00 00 	mov    0x5dcb(%rip),%rcx        # 131e0 <fwp_gc+0x1078>
    d415:	48 89 c2             	mov    %rax,%rdx
    d418:	48 c1 ea 10          	shr    $0x10,%rdx
    d41c:	48 69 d2 28 12 00 00 	imul   $0x1228,%rdx,%rdx
    d423:	0f b6 34 11          	movzbl (%rcx,%rdx,1),%esi
    d427:	48 25 ff ff 00 00    	and    $0xffff,%rax
    d42d:	75 12                	jne    d441 <fwp_drop10+0x51>
    d42f:	40 80 fe 02          	cmp    $0x2,%sil
    d433:	75 0c                	jne    d441 <fwp_drop10+0x51>
    d435:	48 8d 04 11          	lea    (%rcx,%rdx,1),%rax
    d439:	48 05 28 02 00 00    	add    $0x228,%rax
    d43f:	eb 1f                	jmp    d460 <fwp_drop10+0x70>
    d441:	40 80 fe 01          	cmp    $0x1,%sil
    d445:	75 4a                	jne    d491 <fwp_drop10+0xa1>
    d447:	48 8d 34 11          	lea    (%rcx,%rdx,1),%rsi
    d44b:	8b 4c 11 20          	mov    0x20(%rcx,%rdx,1),%ecx
    d44f:	48 0f af c1          	imul   %rcx,%rax
    d453:	48 c1 e8 20          	shr    $0x20,%rax
    d457:	48 01 f0             	add    %rsi,%rax
    d45a:	48 05 28 02 00 00    	add    $0x228,%rax
    d460:	0f b6 08             	movzbl (%rax),%ecx
    d463:	85 c9                	test   %ecx,%ecx
    d465:	74 2a                	je     d491 <fwp_drop10+0xa1>
    d467:	83 f9 01             	cmp    $0x1,%ecx
    d46a:	75 19                	jne    d485 <fwp_drop10+0x95>
    d46c:	53                   	push   %rbx
    d46d:	48 8b 47 10          	mov    0x10(%rdi),%rax
    d471:	48 89 fb             	mov    %rdi,%rbx
    d474:	48 89 c7             	mov    %rax,%rdi
    d477:	e8 24 00 00 00       	call   d4a0 <fwp_drop9>
    d47c:	48 89 df             	mov    %rbx,%rdi
    d47f:	5b                   	pop    %rbx
    d480:	e9 eb da ff ff       	jmp    af70 <fwp_rc_free_obj>
    d485:	81 f9 ff 00 00 00    	cmp    $0xff,%ecx
    d48b:	74 05                	je     d492 <fwp_drop10+0xa2>
    d48d:	fe c9                	dec    %cl
    d48f:	88 08                	mov    %cl,(%rax)
    d491:	c3                   	ret
    d492:	48 89 c7             	mov    %rax,%rdi
    d495:	e9 f6 d7 ff ff       	jmp    ac90 <fwp_rc_wide_drop>
    d49a:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)

000000000000d4a0 <fwp_drop9>:
    d4a0:	53                   	push   %rbx
    d4a1:	48 89 f8             	mov    %rdi,%rax
    d4a4:	48 2b 05 ed 5c 00 00 	sub    0x5ced(%rip),%rax        # 13198 <fwp_gc+0x1030>
    d4ab:	48 8b 0d 0e 5d 00 00 	mov    0x5d0e(%rip),%rcx        # 131c0 <fwp_gc+0x1058>
    d4b2:	48 c1 e1 10          	shl    $0x10,%rcx
    d4b6:	48 39 c8             	cmp    %rcx,%rax
    d4b9:	0f 83 9c 00 00 00    	jae    d55b <fwp_drop9+0xbb>
    d4bf:	48 8b 0d 1a 5d 00 00 	mov    0x5d1a(%rip),%rcx        # 131e0 <fwp_gc+0x1078>
    d4c6:	48 89 c2             	mov    %rax,%rdx
    d4c9:	48 c1 ea 10          	shr    $0x10,%rdx
    d4cd:	48 69 d2 28 12 00 00 	imul   $0x1228,%rdx,%rdx
    d4d4:	0f b6 34 11          	movzbl (%rcx,%rdx,1),%esi
    d4d8:	48 25 ff ff 00 00    	and    $0xffff,%rax
    d4de:	75 20                	jne    d500 <fwp_drop9+0x60>
    d4e0:	40 80 fe 02          	cmp    $0x2,%sil
    d4e4:	75 1a                	jne    d500 <fwp_drop9+0x60>
    d4e6:	48 8d 04 11          	lea    (%rcx,%rdx,1),%rax
    d4ea:	48 05 28 02 00 00    	add    $0x228,%rax
    d4f0:	eb 2d                	jmp    d51f <fwp_drop9+0x7f>
    d4f2:	66 66 66 66 66 2e 0f 	data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    d4f9:	1f 84 00 00 00 00 00 
    d500:	40 80 fe 01          	cmp    $0x1,%sil
    d504:	75 55                	jne    d55b <fwp_drop9+0xbb>
    d506:	48 8d 34 11          	lea    (%rcx,%rdx,1),%rsi
    d50a:	8b 4c 11 20          	mov    0x20(%rcx,%rdx,1),%ecx
    d50e:	48 0f af c1          	imul   %rcx,%rax
    d512:	48 c1 e8 20          	shr    $0x20,%rax
    d516:	48 01 f0             	add    %rsi,%rax
    d519:	48 05 28 02 00 00    	add    $0x228,%rax
    d51f:	0f b6 08             	movzbl (%rax),%ecx
    d522:	85 c9                	test   %ecx,%ecx
    d524:	74 35                	je     d55b <fwp_drop9+0xbb>
    d526:	83 f9 01             	cmp    $0x1,%ecx
    d529:	75 32                	jne    d55d <fwp_drop9+0xbd>
    d52b:	48 83 3f 00          	cmpq   $0x0,(%rdi)
    d52f:	79 3a                	jns    d56b <fwp_drop9+0xcb>
    d531:	48 8b 5f 08          	mov    0x8(%rdi),%rbx
    d535:	e8 46 d6 ff ff       	call   ab80 <fwp_rc_free_arr>
    d53a:	48 89 d8             	mov    %rbx,%rax
    d53d:	48 2b 05 54 5c 00 00 	sub    0x5c54(%rip),%rax        # 13198 <fwp_gc+0x1030>
    d544:	48 8b 0d 75 5c 00 00 	mov    0x5c75(%rip),%rcx        # 131c0 <fwp_gc+0x1058>
    d54b:	48 c1 e1 10          	shl    $0x10,%rcx
    d54f:	48 89 df             	mov    %rbx,%rdi
    d552:	48 39 c8             	cmp    %rcx,%rax
    d555:	0f 82 64 ff ff ff    	jb     d4bf <fwp_drop9+0x1f>
    d55b:	5b                   	pop    %rbx
    d55c:	c3                   	ret
    d55d:	81 f9 ff 00 00 00    	cmp    $0xff,%ecx
    d563:	74 0c                	je     d571 <fwp_drop9+0xd1>
    d565:	fe c9                	dec    %cl
    d567:	88 08                	mov    %cl,(%rax)
    d569:	5b                   	pop    %rbx
    d56a:	c3                   	ret
    d56b:	5b                   	pop    %rbx
    d56c:	e9 0f d6 ff ff       	jmp    ab80 <fwp_rc_free_arr>
    d571:	48 89 c7             	mov    %rax,%rdi
    d574:	5b                   	pop    %rbx
    d575:	e9 16 d7 ff ff       	jmp    ac90 <fwp_rc_wide_drop>
    d57a:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)

000000000000d580 <fwp_owned_entry55>:
    d580:	48 8b 3f             	mov    (%rdi),%rdi
    d583:	e9 a8 fa ff ff       	jmp    d030 <f55>
    d588:	0f 1f 84 00 00 00 00 	nopl   0x0(%rax,%rax,1)
    d58f:	00 

000000000000d590 <fwp_caps55>:
    d590:	53                   	push   %rbx
    d591:	83 7f 04 00          	cmpl   $0x0,0x4(%rdi)
    d595:	74 56                	je     d5ed <fwp_caps55+0x5d>
    d597:	48 89 fb             	mov    %rdi,%rbx
    d59a:	48 8b 7f 08          	mov    0x8(%rdi),%rdi
    d59e:	85 f6                	test   %esi,%esi
    d5a0:	74 51                	je     d5f3 <fwp_caps55+0x63>
    d5a2:	48 2b 3d ef 5b 00 00 	sub    0x5bef(%rip),%rdi        # 13198 <fwp_gc+0x1030>
    d5a9:	48 8b 05 10 5c 00 00 	mov    0x5c10(%rip),%rax        # 131c0 <fwp_gc+0x1058>
    d5b0:	48 c1 e0 10          	shl    $0x10,%rax
    d5b4:	48 39 c7             	cmp    %rax,%rdi
    d5b7:	73 38                	jae    d5f1 <fwp_caps55+0x61>
    d5b9:	48 8b 05 20 5c 00 00 	mov    0x5c20(%rip),%rax        # 131e0 <fwp_gc+0x1078>
    d5c0:	48 89 f9             	mov    %rdi,%rcx
    d5c3:	48 c1 e9 10          	shr    $0x10,%rcx
    d5c7:	48 69 c9 28 12 00 00 	imul   $0x1228,%rcx,%rcx
    d5ce:	0f b6 14 08          	movzbl (%rax,%rcx,1),%edx
    d5d2:	48 81 e7 ff ff 00 00 	and    $0xffff,%rdi
    d5d9:	75 26                	jne    d601 <fwp_caps55+0x71>
    d5db:	80 fa 02             	cmp    $0x2,%dl
    d5de:	75 21                	jne    d601 <fwp_caps55+0x71>
    d5e0:	48 8d 3c 08          	lea    (%rax,%rcx,1),%rdi
    d5e4:	48 81 c7 28 02 00 00 	add    $0x228,%rdi
    d5eb:	eb 33                	jmp    d620 <fwp_caps55+0x90>
    d5ed:	85 f6                	test   %esi,%esi
    d5ef:	74 0a                	je     d5fb <fwp_caps55+0x6b>
    d5f1:	5b                   	pop    %rbx
    d5f2:	c3                   	ret
    d5f3:	e8 f8 fd ff ff       	call   d3f0 <fwp_drop10>
    d5f8:	48 89 df             	mov    %rbx,%rdi
    d5fb:	5b                   	pop    %rbx
    d5fc:	e9 6f d9 ff ff       	jmp    af70 <fwp_rc_free_obj>
    d601:	80 fa 01             	cmp    $0x1,%dl
    d604:	75 eb                	jne    d5f1 <fwp_caps55+0x61>
    d606:	48 8d 14 08          	lea    (%rax,%rcx,1),%rdx
    d60a:	8b 44 08 20          	mov    0x20(%rax,%rcx,1),%eax
    d60e:	48 0f af f8          	imul   %rax,%rdi
    d612:	48 c1 ef 20          	shr    $0x20,%rdi
    d616:	48 01 d7             	add    %rdx,%rdi
    d619:	48 81 c7 28 02 00 00 	add    $0x228,%rdi
    d620:	0f b6 07             	movzbl (%rdi),%eax
    d623:	84 c0                	test   %al,%al
    d625:	74 ca                	je     d5f1 <fwp_caps55+0x61>
    d627:	3c fe                	cmp    $0xfe,%al
    d629:	73 06                	jae    d631 <fwp_caps55+0xa1>
    d62b:	fe c0                	inc    %al
    d62d:	88 07                	mov    %al,(%rdi)
    d62f:	5b                   	pop    %rbx
    d630:	c3                   	ret
    d631:	5b                   	pop    %rbx
    d632:	e9 e9 a5 ff ff       	jmp    7c20 <fwp_rc_wide_dup>
    d637:	66 0f 1f 84 00 00 00 	nopw   0x0(%rax,%rax,1)
    d63e:	00 00 

000000000000d640 <fwp_args55>:
    d640:	85 f6                	test   %esi,%esi
    d642:	0f 85 8a 00 00 00    	jne    d6d2 <fwp_args55+0x92>
    d648:	85 d2                	test   %edx,%edx
    d64a:	0f 84 82 00 00 00    	je     d6d2 <fwp_args55+0x92>
    d650:	48 8b 07             	mov    (%rdi),%rax
    d653:	48 2b 05 3e 5b 00 00 	sub    0x5b3e(%rip),%rax        # 13198 <fwp_gc+0x1030>
    d65a:	48 8b 0d 5f 5b 00 00 	mov    0x5b5f(%rip),%rcx        # 131c0 <fwp_gc+0x1058>
    d661:	48 c1 e1 10          	shl    $0x10,%rcx
    d665:	48 39 c8             	cmp    %rcx,%rax
    d668:	73 68                	jae    d6d2 <fwp_args55+0x92>
    d66a:	48 8b 0d 6f 5b 00 00 	mov    0x5b6f(%rip),%rcx        # 131e0 <fwp_gc+0x1078>
    d671:	48 89 c2             	mov    %rax,%rdx
    d674:	48 c1 ea 10          	shr    $0x10,%rdx
    d678:	48 69 d2 28 12 00 00 	imul   $0x1228,%rdx,%rdx
    d67f:	0f b6 34 11          	movzbl (%rcx,%rdx,1),%esi
    d683:	48 25 ff ff 00 00    	and    $0xffff,%rax
    d689:	75 13                	jne    d69e <fwp_args55+0x5e>
    d68b:	40 80 fe 02          	cmp    $0x2,%sil
    d68f:	75 0d                	jne    d69e <fwp_args55+0x5e>
    d691:	48 8d 3c 11          	lea    (%rcx,%rdx,1),%rdi
    d695:	48 81 c7 28 02 00 00 	add    $0x228,%rdi
    d69c:	eb 21                	jmp    d6bf <fwp_args55+0x7f>
    d69e:	40 80 fe 01          	cmp    $0x1,%sil
    d6a2:	75 2e                	jne    d6d2 <fwp_args55+0x92>
    d6a4:	48 8d 34 11          	lea    (%rcx,%rdx,1),%rsi
    d6a8:	8b 4c 11 20          	mov    0x20(%rcx,%rdx,1),%ecx
    d6ac:	48 0f af c1          	imul   %rcx,%rax
    d6b0:	48 c1 e8 20          	shr    $0x20,%rax
    d6b4:	48 8d 3c 30          	lea    (%rax,%rsi,1),%rdi
    d6b8:	48 81 c7 28 02 00 00 	add    $0x228,%rdi
    d6bf:	0f b6 07             	movzbl (%rdi),%eax
    d6c2:	84 c0                	test   %al,%al
    d6c4:	74 0c                	je     d6d2 <fwp_args55+0x92>
    d6c6:	3c fe                	cmp    $0xfe,%al
    d6c8:	0f 83 52 a5 ff ff    	jae    7c20 <fwp_rc_wide_dup>
    d6ce:	fe c0                	inc    %al
    d6d0:	88 07                	mov    %al,(%rdi)
    d6d2:	c3                   	ret
    d6d3:	66 66 66 66 2e 0f 1f 	data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    d6da:	84 00 00 00 00 00 

000000000000d6e0 <fwp_arg_drop55>:
    d6e0:	85 f6                	test   %esi,%esi
    d6e2:	75 0c                	jne    d6f0 <fwp_arg_drop55+0x10>
    d6e4:	85 d2                	test   %edx,%edx
    d6e6:	74 08                	je     d6f0 <fwp_arg_drop55+0x10>
    d6e8:	48 8b 3f             	mov    (%rdi),%rdi
    d6eb:	e9 00 fd ff ff       	jmp    d3f0 <fwp_drop10>
    d6f0:	c3                   	ret
    d6f1:	66 66 66 66 66 66 2e 	data16 data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    d6f8:	0f 1f 84 00 00 00 00 
    d6ff:	00 

000000000000d700 <f57>:
    d700:	41 57                	push   %r15
    d702:	41 56                	push   %r14
    d704:	41 55                	push   %r13
    d706:	41 54                	push   %r12
    d708:	53                   	push   %rbx
    d709:	48 83 ec 70          	sub    $0x70,%rsp
    d70d:	48 89 fb             	mov    %rdi,%rbx
    d710:	48 8b 47 10          	mov    0x10(%rdi),%rax
    d714:	48 2b 05 7d 5a 00 00 	sub    0x5a7d(%rip),%rax        # 13198 <fwp_gc+0x1030>
    d71b:	48 8b 0d 9e 5a 00 00 	mov    0x5a9e(%rip),%rcx        # 131c0 <fwp_gc+0x1058>
    d722:	48 c1 e1 10          	shl    $0x10,%rcx
    d726:	48 39 c8             	cmp    %rcx,%rax
    d729:	73 68                	jae    d793 <f57+0x93>
    d72b:	48 8b 0d ae 5a 00 00 	mov    0x5aae(%rip),%rcx        # 131e0 <fwp_gc+0x1078>
    d732:	48 89 c2             	mov    %rax,%rdx
    d735:	48 c1 ea 10          	shr    $0x10,%rdx
    d739:	48 69 d2 28 12 00 00 	imul   $0x1228,%rdx,%rdx
    d740:	0f b6 34 11          	movzbl (%rcx,%rdx,1),%esi
    d744:	48 25 ff ff 00 00    	and    $0xffff,%rax
    d74a:	75 13                	jne    d75f <f57+0x5f>
    d74c:	40 80 fe 02          	cmp    $0x2,%sil
    d750:	75 0d                	jne    d75f <f57+0x5f>
    d752:	48 8d 3c 11          	lea    (%rcx,%rdx,1),%rdi
    d756:	48 81 c7 28 02 00 00 	add    $0x228,%rdi
    d75d:	eb 21                	jmp    d780 <f57+0x80>
    d75f:	40 80 fe 01          	cmp    $0x1,%sil
    d763:	75 2e                	jne    d793 <f57+0x93>
    d765:	48 8d 34 11          	lea    (%rcx,%rdx,1),%rsi
    d769:	8b 4c 11 20          	mov    0x20(%rcx,%rdx,1),%ecx
    d76d:	48 0f af c1          	imul   %rcx,%rax
    d771:	48 c1 e8 20          	shr    $0x20,%rax
    d775:	48 8d 3c 30          	lea    (%rax,%rsi,1),%rdi
    d779:	48 81 c7 28 02 00 00 	add    $0x228,%rdi
    d780:	0f b6 07             	movzbl (%rdi),%eax
    d783:	84 c0                	test   %al,%al
    d785:	74 0c                	je     d793 <f57+0x93>
    d787:	3c fe                	cmp    $0xfe,%al
    d789:	0f 83 cb 02 00 00    	jae    da5a <f57+0x35a>
    d78f:	fe c0                	inc    %al
    d791:	88 07                	mov    %al,(%rdi)
    d793:	4c 8b 7b 08          	mov    0x8(%rbx),%r15
    d797:	4c 8b 73 10          	mov    0x10(%rbx),%r14
    d79b:	4c 0f be 63 18       	movsbq 0x18(%rbx),%r12
    d7a0:	4d 85 ff             	test   %r15,%r15
    d7a3:	78 20                	js     d7c5 <f57+0xc5>
    d7a5:	49 8b 06             	mov    (%r14),%rax
    d7a8:	48 b9 ff ff ff ff ff 	movabs $0x7fffffffffffffff,%rcx
    d7af:	ff ff 7f 
    d7b2:	48 21 c1             	and    %rax,%rcx
    d7b5:	4c 39 f9             	cmp    %r15,%rcx
    d7b8:	76 0b                	jbe    d7c5 <f57+0xc5>
    d7ba:	48 85 c0             	test   %rax,%rax
    d7bd:	78 79                	js     d838 <f57+0x138>
    d7bf:	49 8d 46 08          	lea    0x8(%r14),%rax
    d7c3:	eb 77                	jmp    d83c <f57+0x13c>
    d7c5:	4c 89 f7             	mov    %r14,%rdi
    d7c8:	e8 d3 fc ff ff       	call   d4a0 <fwp_drop9>
    d7cd:	4c 89 64 24 10       	mov    %r12,0x10(%rsp)
    d7d2:	48 8d 54 24 10       	lea    0x10(%rsp),%rdx
    d7d7:	bf 01 00 00 00       	mov    $0x1,%edi
    d7dc:	be 01 00 00 00       	mov    $0x1,%esi
    d7e1:	e8 6a cc ff ff       	call   a450 <fwp_data>
    d7e6:	49 89 c6             	mov    %rax,%r14
    d7e9:	48 2b 05 a8 59 00 00 	sub    0x59a8(%rip),%rax        # 13198 <fwp_gc+0x1030>
    d7f0:	48 8b 0d c9 59 00 00 	mov    0x59c9(%rip),%rcx        # 131c0 <fwp_gc+0x1058>
    d7f7:	48 c1 e1 10          	shl    $0x10,%rcx
    d7fb:	48 39 c8             	cmp    %rcx,%rax
    d7fe:	0f 83 3d 02 00 00    	jae    da41 <f57+0x341>
    d804:	48 8b 0d d5 59 00 00 	mov    0x59d5(%rip),%rcx        # 131e0 <fwp_gc+0x1078>
    d80b:	48 89 c2             	mov    %rax,%rdx
    d80e:	48 c1 ea 10          	shr    $0x10,%rdx
    d812:	48 69 d2 28 12 00 00 	imul   $0x1228,%rdx,%rdx
    d819:	0f b6 34 11          	movzbl (%rcx,%rdx,1),%esi
    d81d:	48 25 ff ff 00 00    	and    $0xffff,%rax
    d823:	0f 85 e7 01 00 00    	jne    da10 <f57+0x310>
    d829:	40 80 fe 02          	cmp    $0x2,%sil
    d82d:	0f 84 c6 01 00 00    	je     d9f9 <f57+0x2f9>
    d833:	e9 d8 01 00 00       	jmp    da10 <f57+0x310>
    d838:	49 8b 46 10          	mov    0x10(%r14),%rax
    d83c:	4e 0f be 2c 38       	movsbq (%rax,%r15,1),%r13
    d841:	49 8d 45 81          	lea    -0x7f(%r13),%rax
    d845:	48 3d ff fe ff ff    	cmp    $0xfffffffffffffeff,%rax
    d84b:	0f 86 1d 02 00 00    	jbe    da6e <f57+0x36e>
    d851:	4c 89 f0             	mov    %r14,%rax
    d854:	48 2b 05 3d 59 00 00 	sub    0x593d(%rip),%rax        # 13198 <fwp_gc+0x1030>
    d85b:	48 8b 0d 5e 59 00 00 	mov    0x595e(%rip),%rcx        # 131c0 <fwp_gc+0x1058>
    d862:	48 c1 e1 10          	shl    $0x10,%rcx
    d866:	48 39 c8             	cmp    %rcx,%rax
    d869:	73 68                	jae    d8d3 <f57+0x1d3>
    d86b:	48 8b 0d 6e 59 00 00 	mov    0x596e(%rip),%rcx        # 131e0 <fwp_gc+0x1078>
    d872:	48 89 c2             	mov    %rax,%rdx
    d875:	48 c1 ea 10          	shr    $0x10,%rdx
    d879:	48 69 d2 28 12 00 00 	imul   $0x1228,%rdx,%rdx
    d880:	0f b6 34 11          	movzbl (%rcx,%rdx,1),%esi
    d884:	48 25 ff ff 00 00    	and    $0xffff,%rax
    d88a:	75 13                	jne    d89f <f57+0x19f>
    d88c:	40 80 fe 02          	cmp    $0x2,%sil
    d890:	75 0d                	jne    d89f <f57+0x19f>
    d892:	48 8d 3c 11          	lea    (%rcx,%rdx,1),%rdi
    d896:	48 81 c7 28 02 00 00 	add    $0x228,%rdi
    d89d:	eb 21                	jmp    d8c0 <f57+0x1c0>
    d89f:	40 80 fe 01          	cmp    $0x1,%sil
    d8a3:	75 2e                	jne    d8d3 <f57+0x1d3>
    d8a5:	48 8d 34 11          	lea    (%rcx,%rdx,1),%rsi
    d8a9:	8b 4c 11 20          	mov    0x20(%rcx,%rdx,1),%ecx
    d8ad:	48 0f af c1          	imul   %rcx,%rax
    d8b1:	48 c1 e8 20          	shr    $0x20,%rax
    d8b5:	48 8d 3c 30          	lea    (%rax,%rsi,1),%rdi
    d8b9:	48 81 c7 28 02 00 00 	add    $0x228,%rdi
    d8c0:	0f b6 07             	movzbl (%rdi),%eax
    d8c3:	84 c0                	test   %al,%al
    d8c5:	74 0c                	je     d8d3 <f57+0x1d3>
    d8c7:	3c fe                	cmp    $0xfe,%al
    d8c9:	0f 83 95 01 00 00    	jae    da64 <f57+0x364>
    d8cf:	fe c0                	inc    %al
    d8d1:	88 07                	mov    %al,(%rdi)
    d8d3:	4c 89 f7             	mov    %r14,%rdi
    d8d6:	e8 c5 fb ff ff       	call   d4a0 <fwp_drop9>
    d8db:	4b 8d 04 2c          	lea    (%r12,%r13,1),%rax
    d8df:	48 ff c0             	inc    %rax
    d8e2:	48 0f be c8          	movsbq %al,%rcx
    d8e6:	48 39 c1             	cmp    %rax,%rcx
    d8e9:	0f 85 7f 01 00 00    	jne    da6e <f57+0x36e>
    d8ef:	49 ff c7             	inc    %r15
    d8f2:	4c 89 7c 24 10       	mov    %r15,0x10(%rsp)
    d8f7:	4c 89 74 24 18       	mov    %r14,0x18(%rsp)
    d8fc:	48 89 44 24 20       	mov    %rax,0x20(%rsp)
    d901:	48 8d 54 24 10       	lea    0x10(%rsp),%rdx
    d906:	31 ff                	xor    %edi,%edi
    d908:	be 03 00 00 00       	mov    $0x3,%esi
    d90d:	e8 3e cb ff ff       	call   a450 <fwp_data>
    d912:	48 89 c1             	mov    %rax,%rcx
    d915:	48 2b 0d 7c 58 00 00 	sub    0x587c(%rip),%rcx        # 13198 <fwp_gc+0x1030>
    d91c:	48 8b 15 9d 58 00 00 	mov    0x589d(%rip),%rdx        # 131c0 <fwp_gc+0x1058>
    d923:	48 c1 e2 10          	shl    $0x10,%rdx
    d927:	48 39 d1             	cmp    %rdx,%rcx
    d92a:	73 76                	jae    d9a2 <f57+0x2a2>
    d92c:	48 8b 15 ad 58 00 00 	mov    0x58ad(%rip),%rdx        # 131e0 <fwp_gc+0x1078>
    d933:	48 89 ce             	mov    %rcx,%rsi
    d936:	48 c1 ee 10          	shr    $0x10,%rsi
    d93a:	48 69 f6 28 12 00 00 	imul   $0x1228,%rsi,%rsi
    d941:	0f b6 3c 32          	movzbl (%rdx,%rsi,1),%edi
    d945:	48 81 e1 ff ff 00 00 	and    $0xffff,%rcx
    d94c:	75 1d                	jne    d96b <f57+0x26b>
    d94e:	40 80 ff 02          	cmp    $0x2,%dil
    d952:	75 17                	jne    d96b <f57+0x26b>
    d954:	4c 8d 34 32          	lea    (%rdx,%rsi,1),%r14
    d958:	49 81 c6 28 02 00 00 	add    $0x228,%r14
    d95f:	41 80 3e ff          	cmpb   $0xff,(%r14)
    d963:	74 2d                	je     d992 <f57+0x292>
    d965:	41 c6 06 01          	movb   $0x1,(%r14)
    d969:	eb 37                	jmp    d9a2 <f57+0x2a2>
    d96b:	40 80 ff 01          	cmp    $0x1,%dil
    d96f:	75 31                	jne    d9a2 <f57+0x2a2>
    d971:	48 8d 3c 32          	lea    (%rdx,%rsi,1),%rdi
    d975:	8b 54 32 20          	mov    0x20(%rdx,%rsi,1),%edx
    d979:	48 0f af ca          	imul   %rdx,%rcx
    d97d:	48 c1 e9 20          	shr    $0x20,%rcx
    d981:	4c 8d 34 39          	lea    (%rcx,%rdi,1),%r14
    d985:	49 81 c6 28 02 00 00 	add    $0x228,%r14
    d98c:	41 80 3e ff          	cmpb   $0xff,(%r14)
    d990:	75 d3                	jne    d965 <f57+0x265>
    d992:	4c 89 f7             	mov    %r14,%rdi
    d995:	49 89 c7             	mov    %rax,%r15
    d998:	e8 f3 90 ff ff       	call   6a90 <fwp_rc_forget_slot>
    d99d:	4c 89 f8             	mov    %r15,%rax
    d9a0:	eb c3                	jmp    d965 <f57+0x265>
    d9a2:	48 89 44 24 08       	mov    %rax,0x8(%rsp)
    d9a7:	48 8d 54 24 08       	lea    0x8(%rsp),%rdx
    d9ac:	31 ff                	xor    %edi,%edi
    d9ae:	be 01 00 00 00       	mov    $0x1,%esi
    d9b3:	e8 98 ca ff ff       	call   a450 <fwp_data>
    d9b8:	49 89 c6             	mov    %rax,%r14
    d9bb:	48 2b 05 d6 57 00 00 	sub    0x57d6(%rip),%rax        # 13198 <fwp_gc+0x1030>
    d9c2:	48 8b 0d f7 57 00 00 	mov    0x57f7(%rip),%rcx        # 131c0 <fwp_gc+0x1058>
    d9c9:	48 c1 e1 10          	shl    $0x10,%rcx
    d9cd:	48 39 c8             	cmp    %rcx,%rax
    d9d0:	73 6f                	jae    da41 <f57+0x341>
    d9d2:	48 8b 0d 07 58 00 00 	mov    0x5807(%rip),%rcx        # 131e0 <fwp_gc+0x1078>
    d9d9:	48 89 c2             	mov    %rax,%rdx
    d9dc:	48 c1 ea 10          	shr    $0x10,%rdx
    d9e0:	48 69 d2 28 12 00 00 	imul   $0x1228,%rdx,%rdx
    d9e7:	0f b6 34 11          	movzbl (%rcx,%rdx,1),%esi
    d9eb:	48 25 ff ff 00 00    	and    $0xffff,%rax
    d9f1:	75 1d                	jne    da10 <f57+0x310>
    d9f3:	40 80 fe 02          	cmp    $0x2,%sil
    d9f7:	75 17                	jne    da10 <f57+0x310>
    d9f9:	4c 8d 3c 11          	lea    (%rcx,%rdx,1),%r15
    d9fd:	49 81 c7 28 02 00 00 	add    $0x228,%r15
    da04:	41 80 3f ff          	cmpb   $0xff,(%r15)
    da08:	74 2d                	je     da37 <f57+0x337>
    da0a:	41 c6 07 01          	movb   $0x1,(%r15)
    da0e:	eb 31                	jmp    da41 <f57+0x341>
    da10:	40 80 fe 01          	cmp    $0x1,%sil
    da14:	75 2b                	jne    da41 <f57+0x341>
    da16:	48 8d 34 11          	lea    (%rcx,%rdx,1),%rsi
    da1a:	8b 4c 11 20          	mov    0x20(%rcx,%rdx,1),%ecx
    da1e:	48 0f af c1          	imul   %rcx,%rax
    da22:	48 c1 e8 20          	shr    $0x20,%rax
    da26:	4c 8d 3c 30          	lea    (%rax,%rsi,1),%r15
    da2a:	49 81 c7 28 02 00 00 	add    $0x228,%r15
    da31:	41 80 3f ff          	cmpb   $0xff,(%r15)
    da35:	75 d3                	jne    da0a <f57+0x30a>
    da37:	4c 89 ff             	mov    %r15,%rdi
    da3a:	e8 51 90 ff ff       	call   6a90 <fwp_rc_forget_slot>
    da3f:	eb c9                	jmp    da0a <f57+0x30a>
    da41:	48 89 df             	mov    %rbx,%rdi
    da44:	e8 77 00 00 00       	call   dac0 <fwp_drop11>
    da49:	4c 89 f0             	mov    %r14,%rax
    da4c:	48 83 c4 70          	add    $0x70,%rsp
    da50:	5b                   	pop    %rbx
    da51:	41 5c                	pop    %r12
    da53:	41 5d                	pop    %r13
    da55:	41 5e                	pop    %r14
    da57:	41 5f                	pop    %r15
    da59:	c3                   	ret
    da5a:	e8 c1 a1 ff ff       	call   7c20 <fwp_rc_wide_dup>
    da5f:	e9 2f fd ff ff       	jmp    d793 <f57+0x93>
    da64:	e8 b7 a1 ff ff       	call   7c20 <fwp_rc_wide_dup>
    da69:	e9 65 fe ff ff       	jmp    d8d3 <f57+0x1d3>
    da6e:	48 8d 15 bd 1c 00 00 	lea    0x1cbd(%rip),%rdx        # f732 <fwp_segv.msg+0x4b2>
    da75:	48 8d 0d ce 1b 00 00 	lea    0x1bce(%rip),%rcx        # f64a <fwp_segv.msg+0x3ca>
    da7c:	48 8d 5c 24 10       	lea    0x10(%rsp),%rbx
    da81:	be 60 00 00 00       	mov    $0x60,%esi
    da86:	48 89 df             	mov    %rbx,%rdi
    da89:	31 c0                	xor    %eax,%eax
    da8b:	e8 70 46 ff ff       	call   2100 <snprintf@plt>
    da90:	e8 cb 8f ff ff       	call   6a60 <fwp_flush>
    da95:	48 8b 05 44 45 00 00 	mov    0x4544(%rip),%rax        # 11fe0 <stderr@GLIBC_2.2.5>
    da9c:	48 8b 38             	mov    (%rax),%rdi
    da9f:	48 8d 35 27 1a 00 00 	lea    0x1a27(%rip),%rsi        # f4cd <fwp_segv.msg+0x24d>
    daa6:	48 89 da             	mov    %rbx,%rdx
    daa9:	31 c0                	xor    %eax,%eax
    daab:	e8 f0 46 ff ff       	call   21a0 <fprintf@plt>
    dab0:	bf 65 00 00 00       	mov    $0x65,%edi
    dab5:	e8 b6 47 ff ff       	call   2270 <exit@plt>
    daba:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)

000000000000dac0 <fwp_drop11>:
    dac0:	48 89 f8             	mov    %rdi,%rax
    dac3:	48 2b 05 ce 56 00 00 	sub    0x56ce(%rip),%rax        # 13198 <fwp_gc+0x1030>
    daca:	48 8b 0d ef 56 00 00 	mov    0x56ef(%rip),%rcx        # 131c0 <fwp_gc+0x1058>
    dad1:	48 c1 e1 10          	shl    $0x10,%rcx
    dad5:	48 39 c8             	cmp    %rcx,%rax
    dad8:	0f 83 83 00 00 00    	jae    db61 <fwp_drop11+0xa1>
    dade:	48 8b 0d fb 56 00 00 	mov    0x56fb(%rip),%rcx        # 131e0 <fwp_gc+0x1078>
    dae5:	48 89 c2             	mov    %rax,%rdx
    dae8:	48 c1 ea 10          	shr    $0x10,%rdx
    daec:	48 69 d2 28 12 00 00 	imul   $0x1228,%rdx,%rdx
    daf3:	0f b6 34 11          	movzbl (%rcx,%rdx,1),%esi
    daf7:	48 25 ff ff 00 00    	and    $0xffff,%rax
    dafd:	75 12                	jne    db11 <fwp_drop11+0x51>
    daff:	40 80 fe 02          	cmp    $0x2,%sil
    db03:	75 0c                	jne    db11 <fwp_drop11+0x51>
    db05:	48 8d 04 11          	lea    (%rcx,%rdx,1),%rax
    db09:	48 05 28 02 00 00    	add    $0x228,%rax
    db0f:	eb 1f                	jmp    db30 <fwp_drop11+0x70>
    db11:	40 80 fe 01          	cmp    $0x1,%sil
    db15:	75 4a                	jne    db61 <fwp_drop11+0xa1>
    db17:	48 8d 34 11          	lea    (%rcx,%rdx,1),%rsi
    db1b:	8b 4c 11 20          	mov    0x20(%rcx,%rdx,1),%ecx
    db1f:	48 0f af c1          	imul   %rcx,%rax
    db23:	48 c1 e8 20          	shr    $0x20,%rax
    db27:	48 01 f0             	add    %rsi,%rax
    db2a:	48 05 28 02 00 00    	add    $0x228,%rax
    db30:	0f b6 08             	movzbl (%rax),%ecx
    db33:	85 c9                	test   %ecx,%ecx
    db35:	74 2a                	je     db61 <fwp_drop11+0xa1>
    db37:	83 f9 01             	cmp    $0x1,%ecx
    db3a:	75 19                	jne    db55 <fwp_drop11+0x95>
    db3c:	53                   	push   %rbx
    db3d:	48 8b 47 10          	mov    0x10(%rdi),%rax
    db41:	48 89 fb             	mov    %rdi,%rbx
    db44:	48 89 c7             	mov    %rax,%rdi
    db47:	e8 54 f9 ff ff       	call   d4a0 <fwp_drop9>
    db4c:	48 89 df             	mov    %rbx,%rdi
    db4f:	5b                   	pop    %rbx
    db50:	e9 1b d4 ff ff       	jmp    af70 <fwp_rc_free_obj>
    db55:	81 f9 ff 00 00 00    	cmp    $0xff,%ecx
    db5b:	74 05                	je     db62 <fwp_drop11+0xa2>
    db5d:	fe c9                	dec    %cl
    db5f:	88 08                	mov    %cl,(%rax)
    db61:	c3                   	ret
    db62:	48 89 c7             	mov    %rax,%rdi
    db65:	e9 26 d1 ff ff       	jmp    ac90 <fwp_rc_wide_drop>
    db6a:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)

000000000000db70 <fwp_owned_entry57>:
    db70:	48 8b 3f             	mov    (%rdi),%rdi
    db73:	e9 88 fb ff ff       	jmp    d700 <f57>
    db78:	0f 1f 84 00 00 00 00 	nopl   0x0(%rax,%rax,1)
    db7f:	00 

000000000000db80 <fwp_caps57>:
    db80:	53                   	push   %rbx
    db81:	83 7f 04 00          	cmpl   $0x0,0x4(%rdi)
    db85:	74 56                	je     dbdd <fwp_caps57+0x5d>
    db87:	48 89 fb             	mov    %rdi,%rbx
    db8a:	48 8b 7f 08          	mov    0x8(%rdi),%rdi
    db8e:	85 f6                	test   %esi,%esi
    db90:	74 51                	je     dbe3 <fwp_caps57+0x63>
    db92:	48 2b 3d ff 55 00 00 	sub    0x55ff(%rip),%rdi        # 13198 <fwp_gc+0x1030>
    db99:	48 8b 05 20 56 00 00 	mov    0x5620(%rip),%rax        # 131c0 <fwp_gc+0x1058>
    dba0:	48 c1 e0 10          	shl    $0x10,%rax
    dba4:	48 39 c7             	cmp    %rax,%rdi
    dba7:	73 38                	jae    dbe1 <fwp_caps57+0x61>
    dba9:	48 8b 05 30 56 00 00 	mov    0x5630(%rip),%rax        # 131e0 <fwp_gc+0x1078>
    dbb0:	48 89 f9             	mov    %rdi,%rcx
    dbb3:	48 c1 e9 10          	shr    $0x10,%rcx
    dbb7:	48 69 c9 28 12 00 00 	imul   $0x1228,%rcx,%rcx
    dbbe:	0f b6 14 08          	movzbl (%rax,%rcx,1),%edx
    dbc2:	48 81 e7 ff ff 00 00 	and    $0xffff,%rdi
    dbc9:	75 26                	jne    dbf1 <fwp_caps57+0x71>
    dbcb:	80 fa 02             	cmp    $0x2,%dl
    dbce:	75 21                	jne    dbf1 <fwp_caps57+0x71>
    dbd0:	48 8d 3c 08          	lea    (%rax,%rcx,1),%rdi
    dbd4:	48 81 c7 28 02 00 00 	add    $0x228,%rdi
    dbdb:	eb 33                	jmp    dc10 <fwp_caps57+0x90>
    dbdd:	85 f6                	test   %esi,%esi
    dbdf:	74 0a                	je     dbeb <fwp_caps57+0x6b>
    dbe1:	5b                   	pop    %rbx
    dbe2:	c3                   	ret
    dbe3:	e8 d8 fe ff ff       	call   dac0 <fwp_drop11>
    dbe8:	48 89 df             	mov    %rbx,%rdi
    dbeb:	5b                   	pop    %rbx
    dbec:	e9 7f d3 ff ff       	jmp    af70 <fwp_rc_free_obj>
    dbf1:	80 fa 01             	cmp    $0x1,%dl
    dbf4:	75 eb                	jne    dbe1 <fwp_caps57+0x61>
    dbf6:	48 8d 14 08          	lea    (%rax,%rcx,1),%rdx
    dbfa:	8b 44 08 20          	mov    0x20(%rax,%rcx,1),%eax
    dbfe:	48 0f af f8          	imul   %rax,%rdi
    dc02:	48 c1 ef 20          	shr    $0x20,%rdi
    dc06:	48 01 d7             	add    %rdx,%rdi
    dc09:	48 81 c7 28 02 00 00 	add    $0x228,%rdi
    dc10:	0f b6 07             	movzbl (%rdi),%eax
    dc13:	84 c0                	test   %al,%al
    dc15:	74 ca                	je     dbe1 <fwp_caps57+0x61>
    dc17:	3c fe                	cmp    $0xfe,%al
    dc19:	73 06                	jae    dc21 <fwp_caps57+0xa1>
    dc1b:	fe c0                	inc    %al
    dc1d:	88 07                	mov    %al,(%rdi)
    dc1f:	5b                   	pop    %rbx
    dc20:	c3                   	ret
    dc21:	5b                   	pop    %rbx
    dc22:	e9 f9 9f ff ff       	jmp    7c20 <fwp_rc_wide_dup>
    dc27:	66 0f 1f 84 00 00 00 	nopw   0x0(%rax,%rax,1)
    dc2e:	00 00 

000000000000dc30 <fwp_args57>:
    dc30:	85 f6                	test   %esi,%esi
    dc32:	0f 85 8a 00 00 00    	jne    dcc2 <fwp_args57+0x92>
    dc38:	85 d2                	test   %edx,%edx
    dc3a:	0f 84 82 00 00 00    	je     dcc2 <fwp_args57+0x92>
    dc40:	48 8b 07             	mov    (%rdi),%rax
    dc43:	48 2b 05 4e 55 00 00 	sub    0x554e(%rip),%rax        # 13198 <fwp_gc+0x1030>
    dc4a:	48 8b 0d 6f 55 00 00 	mov    0x556f(%rip),%rcx        # 131c0 <fwp_gc+0x1058>
    dc51:	48 c1 e1 10          	shl    $0x10,%rcx
    dc55:	48 39 c8             	cmp    %rcx,%rax
    dc58:	73 68                	jae    dcc2 <fwp_args57+0x92>
    dc5a:	48 8b 0d 7f 55 00 00 	mov    0x557f(%rip),%rcx        # 131e0 <fwp_gc+0x1078>
    dc61:	48 89 c2             	mov    %rax,%rdx
    dc64:	48 c1 ea 10          	shr    $0x10,%rdx
    dc68:	48 69 d2 28 12 00 00 	imul   $0x1228,%rdx,%rdx
    dc6f:	0f b6 34 11          	movzbl (%rcx,%rdx,1),%esi
    dc73:	48 25 ff ff 00 00    	and    $0xffff,%rax
    dc79:	75 13                	jne    dc8e <fwp_args57+0x5e>
    dc7b:	40 80 fe 02          	cmp    $0x2,%sil
    dc7f:	75 0d                	jne    dc8e <fwp_args57+0x5e>
    dc81:	48 8d 3c 11          	lea    (%rcx,%rdx,1),%rdi
    dc85:	48 81 c7 28 02 00 00 	add    $0x228,%rdi
    dc8c:	eb 21                	jmp    dcaf <fwp_args57+0x7f>
    dc8e:	40 80 fe 01          	cmp    $0x1,%sil
    dc92:	75 2e                	jne    dcc2 <fwp_args57+0x92>
    dc94:	48 8d 34 11          	lea    (%rcx,%rdx,1),%rsi
    dc98:	8b 4c 11 20          	mov    0x20(%rcx,%rdx,1),%ecx
    dc9c:	48 0f af c1          	imul   %rcx,%rax
    dca0:	48 c1 e8 20          	shr    $0x20,%rax
    dca4:	48 8d 3c 30          	lea    (%rax,%rsi,1),%rdi
    dca8:	48 81 c7 28 02 00 00 	add    $0x228,%rdi
    dcaf:	0f b6 07             	movzbl (%rdi),%eax
    dcb2:	84 c0                	test   %al,%al
    dcb4:	74 0c                	je     dcc2 <fwp_args57+0x92>
    dcb6:	3c fe                	cmp    $0xfe,%al
    dcb8:	0f 83 62 9f ff ff    	jae    7c20 <fwp_rc_wide_dup>
    dcbe:	fe c0                	inc    %al
    dcc0:	88 07                	mov    %al,(%rdi)
    dcc2:	c3                   	ret
    dcc3:	66 66 66 66 2e 0f 1f 	data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    dcca:	84 00 00 00 00 00 

000000000000dcd0 <fwp_arg_drop57>:
    dcd0:	85 f6                	test   %esi,%esi
    dcd2:	75 0c                	jne    dce0 <fwp_arg_drop57+0x10>
    dcd4:	85 d2                	test   %edx,%edx
    dcd6:	74 08                	je     dce0 <fwp_arg_drop57+0x10>
    dcd8:	48 8b 3f             	mov    (%rdi),%rdi
    dcdb:	e9 e0 fd ff ff       	jmp    dac0 <fwp_drop11>
    dce0:	c3                   	ret
    dce1:	66 66 66 66 66 66 2e 	data16 data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    dce8:	0f 1f 84 00 00 00 00 
    dcef:	00 

000000000000dcf0 <f59>:
    dcf0:	41 57                	push   %r15
    dcf2:	41 56                	push   %r14
    dcf4:	53                   	push   %rbx
    dcf5:	48 83 ec 30          	sub    $0x30,%rsp
    dcf9:	48 89 fb             	mov    %rdi,%rbx
    dcfc:	48 8b 47 10          	mov    0x10(%rdi),%rax
    dd00:	48 2b 05 91 54 00 00 	sub    0x5491(%rip),%rax        # 13198 <fwp_gc+0x1030>
    dd07:	48 8b 0d b2 54 00 00 	mov    0x54b2(%rip),%rcx        # 131c0 <fwp_gc+0x1058>
    dd0e:	48 c1 e1 10          	shl    $0x10,%rcx
    dd12:	48 39 c8             	cmp    %rcx,%rax
    dd15:	73 68                	jae    dd7f <f59+0x8f>
    dd17:	48 8b 0d c2 54 00 00 	mov    0x54c2(%rip),%rcx        # 131e0 <fwp_gc+0x1078>
    dd1e:	48 89 c2             	mov    %rax,%rdx
    dd21:	48 c1 ea 10          	shr    $0x10,%rdx
    dd25:	48 69 d2 28 12 00 00 	imul   $0x1228,%rdx,%rdx
    dd2c:	0f b6 34 11          	movzbl (%rcx,%rdx,1),%esi
    dd30:	48 25 ff ff 00 00    	and    $0xffff,%rax
    dd36:	75 13                	jne    dd4b <f59+0x5b>
    dd38:	40 80 fe 02          	cmp    $0x2,%sil
    dd3c:	75 0d                	jne    dd4b <f59+0x5b>
    dd3e:	48 8d 3c 11          	lea    (%rcx,%rdx,1),%rdi
    dd42:	48 81 c7 28 02 00 00 	add    $0x228,%rdi
    dd49:	eb 21                	jmp    dd6c <f59+0x7c>
    dd4b:	40 80 fe 01          	cmp    $0x1,%sil
    dd4f:	75 2e                	jne    dd7f <f59+0x8f>
    dd51:	48 8d 34 11          	lea    (%rcx,%rdx,1),%rsi
    dd55:	8b 4c 11 20          	mov    0x20(%rcx,%rdx,1),%ecx
    dd59:	48 0f af c1          	imul   %rcx,%rax
    dd5d:	48 c1 e8 20          	shr    $0x20,%rax
    dd61:	48 8d 3c 30          	lea    (%rax,%rsi,1),%rdi
    dd65:	48 81 c7 28 02 00 00 	add    $0x228,%rdi
    dd6c:	0f b6 07             	movzbl (%rdi),%eax
    dd6f:	84 c0                	test   %al,%al
    dd71:	74 0c                	je     dd7f <f59+0x8f>
    dd73:	3c fe                	cmp    $0xfe,%al
    dd75:	0f 83 cc 02 00 00    	jae    e047 <f59+0x357>
    dd7b:	fe c0                	inc    %al
    dd7d:	88 07                	mov    %al,(%rdi)
    dd7f:	4c 8b 7b 08          	mov    0x8(%rbx),%r15
    dd83:	48 8b 7b 10          	mov    0x10(%rbx),%rdi
    dd87:	f2 0f 10 43 18       	movsd  0x18(%rbx),%xmm0
    dd8c:	f2 0f 11 04 24       	movsd  %xmm0,(%rsp)
    dd91:	4d 85 ff             	test   %r15,%r15
    dd94:	78 20                	js     ddb6 <f59+0xc6>
    dd96:	48 8b 07             	mov    (%rdi),%rax
    dd99:	48 b9 ff ff ff ff ff 	movabs $0x7fffffffffffffff,%rcx
    dda0:	ff ff 7f 
    dda3:	48 21 c1             	and    %rax,%rcx
    dda6:	4c 39 f9             	cmp    %r15,%rcx
    dda9:	76 0b                	jbe    ddb6 <f59+0xc6>
    ddab:	48 85 c0             	test   %rax,%rax
    ddae:	78 7c                	js     de2c <f59+0x13c>
    ddb0:	48 8d 47 08          	lea    0x8(%rdi),%rax
    ddb4:	eb 7a                	jmp    de30 <f59+0x140>
    ddb6:	e8 e5 cc ff ff       	call   aaa0 <fwp_drop1>
    ddbb:	f2 0f 10 04 24       	movsd  (%rsp),%xmm0
    ddc0:	f2 0f 11 44 24 18    	movsd  %xmm0,0x18(%rsp)
    ddc6:	48 8d 54 24 18       	lea    0x18(%rsp),%rdx
    ddcb:	bf 01 00 00 00       	mov    $0x1,%edi
    ddd0:	be 01 00 00 00       	mov    $0x1,%esi
    ddd5:	e8 76 c6 ff ff       	call   a450 <fwp_data>
    ddda:	49 89 c6             	mov    %rax,%r14
    dddd:	48 2b 05 b4 53 00 00 	sub    0x53b4(%rip),%rax        # 13198 <fwp_gc+0x1030>
    dde4:	48 8b 0d d5 53 00 00 	mov    0x53d5(%rip),%rcx        # 131c0 <fwp_gc+0x1058>
    ddeb:	48 c1 e1 10          	shl    $0x10,%rcx
    ddef:	48 39 c8             	cmp    %rcx,%rax
    ddf2:	0f 83 3a 02 00 00    	jae    e032 <f59+0x342>
    ddf8:	48 8b 0d e1 53 00 00 	mov    0x53e1(%rip),%rcx        # 131e0 <fwp_gc+0x1078>
    ddff:	48 89 c2             	mov    %rax,%rdx
    de02:	48 c1 ea 10          	shr    $0x10,%rdx
    de06:	48 69 d2 28 12 00 00 	imul   $0x1228,%rdx,%rdx
    de0d:	0f b6 34 11          	movzbl (%rcx,%rdx,1),%esi
    de11:	48 25 ff ff 00 00    	and    $0xffff,%rax
    de17:	0f 85 e4 01 00 00    	jne    e001 <f59+0x311>
    de1d:	40 80 fe 02          	cmp    $0x2,%sil
    de21:	0f 84 c3 01 00 00    	je     dfea <f59+0x2fa>
    de27:	e9 d5 01 00 00       	jmp    e001 <f59+0x311>
    de2c:	48 8b 47 10          	mov    0x10(%rdi),%rax
    de30:	f2 42 0f 10 04 f8    	movsd  (%rax,%r15,8),%xmm0
    de36:	f2 0f 59 05 d2 11 00 	mulsd  0x11d2(%rip),%xmm0        # f010 <_IO_stdin_used+0x10>
    de3d:	00 
    de3e:	f2 0f 58 05 d2 11 00 	addsd  0x11d2(%rip),%xmm0        # f018 <_IO_stdin_used+0x18>
    de45:	00 
    de46:	f2 0f 11 44 24 08    	movsd  %xmm0,0x8(%rsp)
    de4c:	48 89 f8             	mov    %rdi,%rax
    de4f:	48 2b 05 42 53 00 00 	sub    0x5342(%rip),%rax        # 13198 <fwp_gc+0x1030>
    de56:	49 ff c7             	inc    %r15
    de59:	48 8b 0d 60 53 00 00 	mov    0x5360(%rip),%rcx        # 131c0 <fwp_gc+0x1058>
    de60:	48 c1 e1 10          	shl    $0x10,%rcx
    de64:	48 39 c8             	cmp    %rcx,%rax
    de67:	73 66                	jae    decf <f59+0x1df>
    de69:	48 8b 0d 70 53 00 00 	mov    0x5370(%rip),%rcx        # 131e0 <fwp_gc+0x1078>
    de70:	48 89 c2             	mov    %rax,%rdx
    de73:	48 c1 ea 10          	shr    $0x10,%rdx
    de77:	48 69 d2 28 12 00 00 	imul   $0x1228,%rdx,%rdx
    de7e:	0f b6 34 11          	movzbl (%rcx,%rdx,1),%esi
    de82:	48 25 ff ff 00 00    	and    $0xffff,%rax
    de88:	75 12                	jne    de9c <f59+0x1ac>
    de8a:	40 80 fe 02          	cmp    $0x2,%sil
    de8e:	75 0c                	jne    de9c <f59+0x1ac>
    de90:	48 8d 04 11          	lea    (%rcx,%rdx,1),%rax
    de94:	48 05 28 02 00 00    	add    $0x228,%rax
    de9a:	eb 1f                	jmp    debb <f59+0x1cb>
    de9c:	40 80 fe 01          	cmp    $0x1,%sil
    dea0:	75 2d                	jne    decf <f59+0x1df>
    dea2:	48 8d 34 11          	lea    (%rcx,%rdx,1),%rsi
    dea6:	8b 4c 11 20          	mov    0x20(%rcx,%rdx,1),%ecx
    deaa:	48 0f af c1          	imul   %rcx,%rax
    deae:	48 c1 e8 20          	shr    $0x20,%rax
    deb2:	48 01 f0             	add    %rsi,%rax
    deb5:	48 05 28 02 00 00    	add    $0x228,%rax
    debb:	0f b6 08             	movzbl (%rax),%ecx
    debe:	84 c9                	test   %cl,%cl
    dec0:	74 0d                	je     decf <f59+0x1df>
    dec2:	80 f9 fe             	cmp    $0xfe,%cl
    dec5:	0f 83 86 01 00 00    	jae    e051 <f59+0x361>
    decb:	fe c1                	inc    %cl
    decd:	88 08                	mov    %cl,(%rax)
    decf:	49 89 fe             	mov    %rdi,%r14
    ded2:	e8 c9 cb ff ff       	call   aaa0 <fwp_drop1>
    ded7:	f2 0f 10 04 24       	movsd  (%rsp),%xmm0
    dedc:	f2 0f 58 44 24 08    	addsd  0x8(%rsp),%xmm0
    dee2:	4c 89 7c 24 18       	mov    %r15,0x18(%rsp)
    dee7:	4c 89 74 24 20       	mov    %r14,0x20(%rsp)
    deec:	f2 0f 11 44 24 28    	movsd  %xmm0,0x28(%rsp)
    def2:	48 8d 54 24 18       	lea    0x18(%rsp),%rdx
    def7:	31 ff                	xor    %edi,%edi
    def9:	be 03 00 00 00       	mov    $0x3,%esi
    defe:	e8 4d c5 ff ff       	call   a450 <fwp_data>
    df03:	48 89 c1             	mov    %rax,%rcx
    df06:	48 2b 0d 8b 52 00 00 	sub    0x528b(%rip),%rcx        # 13198 <fwp_gc+0x1030>
    df0d:	48 8b 15 ac 52 00 00 	mov    0x52ac(%rip),%rdx        # 131c0 <fwp_gc+0x1058>
    df14:	48 c1 e2 10          	shl    $0x10,%rdx
    df18:	48 39 d1             	cmp    %rdx,%rcx
    df1b:	73 76                	jae    df93 <f59+0x2a3>
    df1d:	48 8b 15 bc 52 00 00 	mov    0x52bc(%rip),%rdx        # 131e0 <fwp_gc+0x1078>
    df24:	48 89 ce             	mov    %rcx,%rsi
    df27:	48 c1 ee 10          	shr    $0x10,%rsi
    df2b:	48 69 f6 28 12 00 00 	imul   $0x1228,%rsi,%rsi
    df32:	0f b6 3c 32          	movzbl (%rdx,%rsi,1),%edi
    df36:	48 81 e1 ff ff 00 00 	and    $0xffff,%rcx
    df3d:	75 1d                	jne    df5c <f59+0x26c>
    df3f:	40 80 ff 02          	cmp    $0x2,%dil
    df43:	75 17                	jne    df5c <f59+0x26c>
    df45:	4c 8d 34 32          	lea    (%rdx,%rsi,1),%r14
    df49:	49 81 c6 28 02 00 00 	add    $0x228,%r14
    df50:	41 80 3e ff          	cmpb   $0xff,(%r14)
    df54:	74 2d                	je     df83 <f59+0x293>
    df56:	41 c6 06 01          	movb   $0x1,(%r14)
    df5a:	eb 37                	jmp    df93 <f59+0x2a3>
    df5c:	40 80 ff 01          	cmp    $0x1,%dil
    df60:	75 31                	jne    df93 <f59+0x2a3>
    df62:	48 8d 3c 32          	lea    (%rdx,%rsi,1),%rdi
    df66:	8b 54 32 20          	mov    0x20(%rdx,%rsi,1),%edx
    df6a:	48 0f af ca          	imul   %rdx,%rcx
    df6e:	48 c1 e9 20          	shr    $0x20,%rcx
    df72:	4c 8d 34 39          	lea    (%rcx,%rdi,1),%r14
    df76:	49 81 c6 28 02 00 00 	add    $0x228,%r14
    df7d:	41 80 3e ff          	cmpb   $0xff,(%r14)
    df81:	75 d3                	jne    df56 <f59+0x266>
    df83:	4c 89 f7             	mov    %r14,%rdi
    df86:	49 89 c7             	mov    %rax,%r15
    df89:	e8 02 8b ff ff       	call   6a90 <fwp_rc_forget_slot>
    df8e:	4c 89 f8             	mov    %r15,%rax
    df91:	eb c3                	jmp    df56 <f59+0x266>
    df93:	48 89 44 24 10       	mov    %rax,0x10(%rsp)
    df98:	48 8d 54 24 10       	lea    0x10(%rsp),%rdx
    df9d:	31 ff                	xor    %edi,%edi
    df9f:	be 01 00 00 00       	mov    $0x1,%esi
    dfa4:	e8 a7 c4 ff ff       	call   a450 <fwp_data>
    dfa9:	49 89 c6             	mov    %rax,%r14
    dfac:	48 2b 05 e5 51 00 00 	sub    0x51e5(%rip),%rax        # 13198 <fwp_gc+0x1030>
    dfb3:	48 8b 0d 06 52 00 00 	mov    0x5206(%rip),%rcx        # 131c0 <fwp_gc+0x1058>
    dfba:	48 c1 e1 10          	shl    $0x10,%rcx
    dfbe:	48 39 c8             	cmp    %rcx,%rax
    dfc1:	73 6f                	jae    e032 <f59+0x342>
    dfc3:	48 8b 0d 16 52 00 00 	mov    0x5216(%rip),%rcx        # 131e0 <fwp_gc+0x1078>
    dfca:	48 89 c2             	mov    %rax,%rdx
    dfcd:	48 c1 ea 10          	shr    $0x10,%rdx
    dfd1:	48 69 d2 28 12 00 00 	imul   $0x1228,%rdx,%rdx
    dfd8:	0f b6 34 11          	movzbl (%rcx,%rdx,1),%esi
    dfdc:	48 25 ff ff 00 00    	and    $0xffff,%rax
    dfe2:	75 1d                	jne    e001 <f59+0x311>
    dfe4:	40 80 fe 02          	cmp    $0x2,%sil
    dfe8:	75 17                	jne    e001 <f59+0x311>
    dfea:	4c 8d 3c 11          	lea    (%rcx,%rdx,1),%r15
    dfee:	49 81 c7 28 02 00 00 	add    $0x228,%r15
    dff5:	41 80 3f ff          	cmpb   $0xff,(%r15)
    dff9:	74 2d                	je     e028 <f59+0x338>
    dffb:	41 c6 07 01          	movb   $0x1,(%r15)
    dfff:	eb 31                	jmp    e032 <f59+0x342>
    e001:	40 80 fe 01          	cmp    $0x1,%sil
    e005:	75 2b                	jne    e032 <f59+0x342>
    e007:	48 8d 34 11          	lea    (%rcx,%rdx,1),%rsi
    e00b:	8b 4c 11 20          	mov    0x20(%rcx,%rdx,1),%ecx
    e00f:	48 0f af c1          	imul   %rcx,%rax
    e013:	48 c1 e8 20          	shr    $0x20,%rax
    e017:	4c 8d 3c 30          	lea    (%rax,%rsi,1),%r15
    e01b:	49 81 c7 28 02 00 00 	add    $0x228,%r15
    e022:	41 80 3f ff          	cmpb   $0xff,(%r15)
    e026:	75 d3                	jne    dffb <f59+0x30b>
    e028:	4c 89 ff             	mov    %r15,%rdi
    e02b:	e8 60 8a ff ff       	call   6a90 <fwp_rc_forget_slot>
    e030:	eb c9                	jmp    dffb <f59+0x30b>
    e032:	48 89 df             	mov    %rbx,%rdi
    e035:	e8 b6 c9 ff ff       	call   a9f0 <fwp_drop6>
    e03a:	4c 89 f0             	mov    %r14,%rax
    e03d:	48 83 c4 30          	add    $0x30,%rsp
    e041:	5b                   	pop    %rbx
    e042:	41 5e                	pop    %r14
    e044:	41 5f                	pop    %r15
    e046:	c3                   	ret
    e047:	e8 d4 9b ff ff       	call   7c20 <fwp_rc_wide_dup>
    e04c:	e9 2e fd ff ff       	jmp    dd7f <f59+0x8f>
    e051:	49 89 fe             	mov    %rdi,%r14
    e054:	48 89 c7             	mov    %rax,%rdi
    e057:	e8 c4 9b ff ff       	call   7c20 <fwp_rc_wide_dup>
    e05c:	4c 89 f7             	mov    %r14,%rdi
    e05f:	e9 6b fe ff ff       	jmp    decf <f59+0x1df>
    e064:	66 66 66 2e 0f 1f 84 	data16 data16 cs nopw 0x0(%rax,%rax,1)
    e06b:	00 00 00 00 00 

000000000000e070 <fwp_owned_entry59>:
    e070:	48 8b 3f             	mov    (%rdi),%rdi
    e073:	e9 78 fc ff ff       	jmp    dcf0 <f59>
    e078:	0f 1f 84 00 00 00 00 	nopl   0x0(%rax,%rax,1)
    e07f:	00 

000000000000e080 <fwp_caps59>:
    e080:	53                   	push   %rbx
    e081:	83 7f 04 00          	cmpl   $0x0,0x4(%rdi)
    e085:	74 56                	je     e0dd <fwp_caps59+0x5d>
    e087:	48 89 fb             	mov    %rdi,%rbx
    e08a:	48 8b 7f 08          	mov    0x8(%rdi),%rdi
    e08e:	85 f6                	test   %esi,%esi
    e090:	74 51                	je     e0e3 <fwp_caps59+0x63>
    e092:	48 2b 3d ff 50 00 00 	sub    0x50ff(%rip),%rdi        # 13198 <fwp_gc+0x1030>
    e099:	48 8b 05 20 51 00 00 	mov    0x5120(%rip),%rax        # 131c0 <fwp_gc+0x1058>
    e0a0:	48 c1 e0 10          	shl    $0x10,%rax
    e0a4:	48 39 c7             	cmp    %rax,%rdi
    e0a7:	73 38                	jae    e0e1 <fwp_caps59+0x61>
    e0a9:	48 8b 05 30 51 00 00 	mov    0x5130(%rip),%rax        # 131e0 <fwp_gc+0x1078>
    e0b0:	48 89 f9             	mov    %rdi,%rcx
    e0b3:	48 c1 e9 10          	shr    $0x10,%rcx
    e0b7:	48 69 c9 28 12 00 00 	imul   $0x1228,%rcx,%rcx
    e0be:	0f b6 14 08          	movzbl (%rax,%rcx,1),%edx
    e0c2:	48 81 e7 ff ff 00 00 	and    $0xffff,%rdi
    e0c9:	75 26                	jne    e0f1 <fwp_caps59+0x71>
    e0cb:	80 fa 02             	cmp    $0x2,%dl
    e0ce:	75 21                	jne    e0f1 <fwp_caps59+0x71>
    e0d0:	48 8d 3c 08          	lea    (%rax,%rcx,1),%rdi
    e0d4:	48 81 c7 28 02 00 00 	add    $0x228,%rdi
    e0db:	eb 33                	jmp    e110 <fwp_caps59+0x90>
    e0dd:	85 f6                	test   %esi,%esi
    e0df:	74 0a                	je     e0eb <fwp_caps59+0x6b>
    e0e1:	5b                   	pop    %rbx
    e0e2:	c3                   	ret
    e0e3:	e8 08 c9 ff ff       	call   a9f0 <fwp_drop6>
    e0e8:	48 89 df             	mov    %rbx,%rdi
    e0eb:	5b                   	pop    %rbx
    e0ec:	e9 7f ce ff ff       	jmp    af70 <fwp_rc_free_obj>
    e0f1:	80 fa 01             	cmp    $0x1,%dl
    e0f4:	75 eb                	jne    e0e1 <fwp_caps59+0x61>
    e0f6:	48 8d 14 08          	lea    (%rax,%rcx,1),%rdx
    e0fa:	8b 44 08 20          	mov    0x20(%rax,%rcx,1),%eax
    e0fe:	48 0f af f8          	imul   %rax,%rdi
    e102:	48 c1 ef 20          	shr    $0x20,%rdi
    e106:	48 01 d7             	add    %rdx,%rdi
    e109:	48 81 c7 28 02 00 00 	add    $0x228,%rdi
    e110:	0f b6 07             	movzbl (%rdi),%eax
    e113:	84 c0                	test   %al,%al
    e115:	74 ca                	je     e0e1 <fwp_caps59+0x61>
    e117:	3c fe                	cmp    $0xfe,%al
    e119:	73 06                	jae    e121 <fwp_caps59+0xa1>
    e11b:	fe c0                	inc    %al
    e11d:	88 07                	mov    %al,(%rdi)
    e11f:	5b                   	pop    %rbx
    e120:	c3                   	ret
    e121:	5b                   	pop    %rbx
    e122:	e9 f9 9a ff ff       	jmp    7c20 <fwp_rc_wide_dup>
    e127:	66 0f 1f 84 00 00 00 	nopw   0x0(%rax,%rax,1)
    e12e:	00 00 

000000000000e130 <fwp_args59>:
    e130:	85 f6                	test   %esi,%esi
    e132:	0f 85 8a 00 00 00    	jne    e1c2 <fwp_args59+0x92>
    e138:	85 d2                	test   %edx,%edx
    e13a:	0f 84 82 00 00 00    	je     e1c2 <fwp_args59+0x92>
    e140:	48 8b 07             	mov    (%rdi),%rax
    e143:	48 2b 05 4e 50 00 00 	sub    0x504e(%rip),%rax        # 13198 <fwp_gc+0x1030>
    e14a:	48 8b 0d 6f 50 00 00 	mov    0x506f(%rip),%rcx        # 131c0 <fwp_gc+0x1058>
    e151:	48 c1 e1 10          	shl    $0x10,%rcx
    e155:	48 39 c8             	cmp    %rcx,%rax
    e158:	73 68                	jae    e1c2 <fwp_args59+0x92>
    e15a:	48 8b 0d 7f 50 00 00 	mov    0x507f(%rip),%rcx        # 131e0 <fwp_gc+0x1078>
    e161:	48 89 c2             	mov    %rax,%rdx
    e164:	48 c1 ea 10          	shr    $0x10,%rdx
    e168:	48 69 d2 28 12 00 00 	imul   $0x1228,%rdx,%rdx
    e16f:	0f b6 34 11          	movzbl (%rcx,%rdx,1),%esi
    e173:	48 25 ff ff 00 00    	and    $0xffff,%rax
    e179:	75 13                	jne    e18e <fwp_args59+0x5e>
    e17b:	40 80 fe 02          	cmp    $0x2,%sil
    e17f:	75 0d                	jne    e18e <fwp_args59+0x5e>
    e181:	48 8d 3c 11          	lea    (%rcx,%rdx,1),%rdi
    e185:	48 81 c7 28 02 00 00 	add    $0x228,%rdi
    e18c:	eb 21                	jmp    e1af <fwp_args59+0x7f>
    e18e:	40 80 fe 01          	cmp    $0x1,%sil
    e192:	75 2e                	jne    e1c2 <fwp_args59+0x92>
    e194:	48 8d 34 11          	lea    (%rcx,%rdx,1),%rsi
    e198:	8b 4c 11 20          	mov    0x20(%rcx,%rdx,1),%ecx
    e19c:	48 0f af c1          	imul   %rcx,%rax
    e1a0:	48 c1 e8 20          	shr    $0x20,%rax
    e1a4:	48 8d 3c 30          	lea    (%rax,%rsi,1),%rdi
    e1a8:	48 81 c7 28 02 00 00 	add    $0x228,%rdi
    e1af:	0f b6 07             	movzbl (%rdi),%eax
    e1b2:	84 c0                	test   %al,%al
    e1b4:	74 0c                	je     e1c2 <fwp_args59+0x92>
    e1b6:	3c fe                	cmp    $0xfe,%al
    e1b8:	0f 83 62 9a ff ff    	jae    7c20 <fwp_rc_wide_dup>
    e1be:	fe c0                	inc    %al
    e1c0:	88 07                	mov    %al,(%rdi)
    e1c2:	c3                   	ret
    e1c3:	66 66 66 66 2e 0f 1f 	data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    e1ca:	84 00 00 00 00 00 

000000000000e1d0 <fwp_arg_drop59>:
    e1d0:	85 f6                	test   %esi,%esi
    e1d2:	75 0c                	jne    e1e0 <fwp_arg_drop59+0x10>
    e1d4:	85 d2                	test   %edx,%edx
    e1d6:	74 08                	je     e1e0 <fwp_arg_drop59+0x10>
    e1d8:	48 8b 3f             	mov    (%rdi),%rdi
    e1db:	e9 10 c8 ff ff       	jmp    a9f0 <fwp_drop6>
    e1e0:	c3                   	ret
    e1e1:	66 66 66 66 66 66 2e 	data16 data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    e1e8:	0f 1f 84 00 00 00 00 
    e1ef:	00 

000000000000e1f0 <fwp_gc_find_data>:
    e1f0:	0f b7 77 18          	movzwl 0x18(%rdi),%esi
    e1f4:	48 85 f6             	test   %rsi,%rsi
    e1f7:	0f 84 be 00 00 00    	je     e2bb <fwp_gc_find_data+0xcb>
    e1fd:	53                   	push   %rbx
    e1fe:	48 8b 07             	mov    (%rdi),%rax
    e201:	4c 8b 47 10          	mov    0x10(%rdi),%r8
    e205:	48 6b ce 38          	imul   $0x38,%rsi,%rcx
    e209:	45 31 c9             	xor    %r9d,%r9d
    e20c:	48 8d 15 55 3f 00 00 	lea    0x3f55(%rip),%rdx        # 12168 <fwp_gc>
    e213:	41 bb 01 00 00 00    	mov    $0x1,%r11d
    e219:	45 31 d2             	xor    %r10d,%r10d
    e21c:	eb 0b                	jmp    e229 <fwp_gc_find_data+0x39>
    e21e:	66 90                	xchg   %ax,%ax
    e220:	49 83 c1 38          	add    $0x38,%r9
    e224:	4c 39 c9             	cmp    %r9,%rcx
    e227:	74 22                	je     e24b <fwp_gc_find_data+0x5b>
    e229:	43 83 3c 08 01       	cmpl   $0x1,(%r8,%r9,1)
    e22e:	75 f0                	jne    e220 <fwp_gc_find_data+0x30>
    e230:	4b 8b 5c 08 10       	mov    0x10(%r8,%r9,1),%rbx
    e235:	48 01 c3             	add    %rax,%rbx
    e238:	48 39 d3             	cmp    %rdx,%rbx
    e23b:	77 e3                	ja     e220 <fwp_gc_find_data+0x30>
    e23d:	4b 03 5c 08 28       	add    0x28(%r8,%r9,1),%rbx
    e242:	48 39 d3             	cmp    %rdx,%rbx
    e245:	45 0f 47 d3          	cmova  %r11d,%r10d
    e249:	eb d5                	jmp    e220 <fwp_gc_find_data+0x30>
    e24b:	31 c0                	xor    %eax,%eax
    e24d:	45 85 d2             	test   %r10d,%r10d
    e250:	0f 95 c0             	setne  %al
    e253:	74 6e                	je     e2c3 <fwp_gc_find_data+0xd3>
    e255:	66 85 f6             	test   %si,%si
    e258:	74 69                	je     e2c3 <fwp_gc_find_data+0xd3>
    e25a:	8b 05 98 50 00 00    	mov    0x5098(%rip),%eax        # 132f8 <fwp_gc+0x1190>
    e260:	48 8b 77 10          	mov    0x10(%rdi),%rsi
    e264:	45 31 c0             	xor    %r8d,%r8d
    e267:	eb 10                	jmp    e279 <fwp_gc_find_data+0x89>
    e269:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)
    e270:	49 83 c0 38          	add    $0x38,%r8
    e274:	4c 39 c1             	cmp    %r8,%rcx
    e277:	74 45                	je     e2be <fwp_gc_find_data+0xce>
    e279:	42 83 3c 06 01       	cmpl   $0x1,(%rsi,%r8,1)
    e27e:	75 f0                	jne    e270 <fwp_gc_find_data+0x80>
    e280:	42 f6 44 06 04 02    	testb  $0x2,0x4(%rsi,%r8,1)
    e286:	74 e8                	je     e270 <fwp_gc_find_data+0x80>
    e288:	83 f8 10             	cmp    $0x10,%eax
    e28b:	74 31                	je     e2be <fwp_gc_find_data+0xce>
    e28d:	4e 8b 4c 06 10       	mov    0x10(%rsi,%r8,1),%r9
    e292:	4c 03 0f             	add    (%rdi),%r9
    e295:	4c 63 d0             	movslq %eax,%r10
    e298:	49 c1 e2 04          	shl    $0x4,%r10
    e29c:	4d 89 8c 12 90 10 00 	mov    %r9,0x1090(%r10,%rdx,1)
    e2a3:	00 
    e2a4:	4e 8b 4c 06 28       	mov    0x28(%rsi,%r8,1),%r9
    e2a9:	4d 89 8c 12 98 10 00 	mov    %r9,0x1098(%r10,%rdx,1)
    e2b0:	00 
    e2b1:	ff c0                	inc    %eax
    e2b3:	89 05 3f 50 00 00    	mov    %eax,0x503f(%rip)        # 132f8 <fwp_gc+0x1190>
    e2b9:	eb b5                	jmp    e270 <fwp_gc_find_data+0x80>
    e2bb:	31 c0                	xor    %eax,%eax
    e2bd:	c3                   	ret
    e2be:	b8 01 00 00 00       	mov    $0x1,%eax
    e2c3:	5b                   	pop    %rbx
    e2c4:	c3                   	ret
    e2c5:	66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
    e2cc:	00 00 00 00 

000000000000e2d0 <fwp_gc_report>:
    e2d0:	55                   	push   %rbp
    e2d1:	41 57                	push   %r15
    e2d3:	41 56                	push   %r14
    e2d5:	41 55                	push   %r13
    e2d7:	41 54                	push   %r12
    e2d9:	53                   	push   %rbx
    e2da:	48 81 ec 58 01 00 00 	sub    $0x158,%rsp
    e2e1:	48 8b 05 90 50 00 00 	mov    0x5090(%rip),%rax        # 13378 <fwp_gc+0x1210>
    e2e8:	48 8b 0d 79 3e 00 00 	mov    0x3e79(%rip),%rcx        # 12168 <fwp_gc>
    e2ef:	48 29 c8             	sub    %rcx,%rax
    e2f2:	f2 48 0f 2a c0       	cvtsi2sd %rax,%xmm0
    e2f7:	f2 0f 58 05 51 50 00 	addsd  0x5051(%rip),%xmm0        # 13350 <fwp_gc+0x11e8>
    e2fe:	00 
    e2ff:	f2 0f 11 44 24 48    	movsd  %xmm0,0x48(%rsp)
    e305:	f2 0f 11 05 43 50 00 	movsd  %xmm0,0x5043(%rip)        # 13350 <fwp_gc+0x11e8>
    e30c:	00 
    e30d:	48 89 0d 64 50 00 00 	mov    %rcx,0x5064(%rip)        # 13378 <fwp_gc+0x1210>
    e314:	48 8b 05 c5 3c 00 00 	mov    0x3cc5(%rip),%rax        # 11fe0 <stderr@GLIBC_2.2.5>
    e31b:	48 8b 28             	mov    (%rax),%rbp
    e31e:	48 8b 1d 1b 50 00 00 	mov    0x501b(%rip),%rbx        # 13340 <fwp_gc+0x11d8>
    e325:	4c 8b 3d 54 4e 00 00 	mov    0x4e54(%rip),%r15        # 13180 <fwp_gc+0x1018>
    e32c:	f2 0f 10 05 3c 50 00 	movsd  0x503c(%rip),%xmm0        # 13370 <fwp_gc+0x1208>
    e333:	00 
    e334:	f2 0f 11 44 24 30    	movsd  %xmm0,0x30(%rsp)
    e33a:	48 8b 05 6f 4e 00 00 	mov    0x4e6f(%rip),%rax        # 131b0 <fwp_gc+0x1048>
    e341:	48 89 44 24 28       	mov    %rax,0x28(%rsp)
    e346:	48 8b 05 e3 4f 00 00 	mov    0x4fe3(%rip),%rax        # 13330 <fwp_gc+0x11c8>
    e34d:	48 89 44 24 20       	mov    %rax,0x20(%rsp)
    e352:	4c 8b 35 df 4f 00 00 	mov    0x4fdf(%rip),%r14        # 13338 <fwp_gc+0x11d0>
    e359:	f2 0f 10 05 f7 4f 00 	movsd  0x4ff7(%rip),%xmm0        # 13358 <fwp_gc+0x11f0>
    e360:	00 
    e361:	f2 0f 11 44 24 40    	movsd  %xmm0,0x40(%rsp)
    e367:	f2 0f 10 05 f1 4f 00 	movsd  0x4ff1(%rip),%xmm0        # 13360 <fwp_gc+0x11f8>
    e36e:	00 
    e36f:	f2 0f 11 44 24 38    	movsd  %xmm0,0x38(%rsp)
    e375:	48 8d 3d 26 15 00 00 	lea    0x1526(%rip),%rdi        # f8a2 <fwp_segv.msg+0x622>
    e37c:	48 8d 35 95 13 00 00 	lea    0x1395(%rip),%rsi        # f718 <fwp_segv.msg+0x498>
    e383:	e8 a8 3e ff ff       	call   2230 <fopen@plt>
    e388:	49 c7 c4 ff ff ff ff 	mov    $0xffffffffffffffff,%r12
    e38f:	48 85 c0             	test   %rax,%rax
    e392:	74 4b                	je     e3df <fwp_gc_report+0x10f>
    e394:	49 89 c5             	mov    %rax,%r13
    e397:	48 89 6c 24 08       	mov    %rbp,0x8(%rsp)
    e39c:	4c 89 7c 24 10       	mov    %r15,0x10(%rsp)
    e3a1:	48 89 5c 24 18       	mov    %rbx,0x18(%rsp)
    e3a6:	48 8d 7c 24 50       	lea    0x50(%rsp),%rdi
    e3ab:	be 00 01 00 00       	mov    $0x100,%esi
    e3b0:	48 89 c2             	mov    %rax,%rdx
    e3b3:	e8 98 3d ff ff       	call   2150 <fgets@plt>
    e3b8:	49 c7 c4 ff ff ff ff 	mov    $0xffffffffffffffff,%r12
    e3bf:	48 85 c0             	test   %rax,%rax
    e3c2:	0f 85 f1 00 00 00    	jne    e4b9 <fwp_gc_report+0x1e9>
    e3c8:	4c 89 ef             	mov    %r13,%rdi
    e3cb:	e8 f0 3c ff ff       	call   20c0 <fclose@plt>
    e3d0:	48 8b 5c 24 18       	mov    0x18(%rsp),%rbx
    e3d5:	4c 8b 7c 24 10       	mov    0x10(%rsp),%r15
    e3da:	48 8b 6c 24 08       	mov    0x8(%rsp),%rbp
    e3df:	66 49 0f 6e c6       	movq   %r14,%xmm0
    e3e4:	66 0f 6f 0d 14 0d 00 	movdqa 0xd14(%rip),%xmm1        # f100 <_IO_stdin_used+0x100>
    e3eb:	00 
    e3ec:	66 0f 62 c1          	punpckldq %xmm1,%xmm0
    e3f0:	66 0f 28 15 18 0d 00 	movapd 0xd18(%rip),%xmm2        # f110 <_IO_stdin_used+0x110>
    e3f7:	00 
    e3f8:	66 0f 5c c2          	subpd  %xmm2,%xmm0
    e3fc:	66 0f 28 e0          	movapd %xmm0,%xmm4
    e400:	66 0f 15 e0          	unpckhpd %xmm0,%xmm4
    e404:	f2 0f 58 e0          	addsd  %xmm0,%xmm4
    e408:	f2 0f 10 35 18 0c 00 	movsd  0xc18(%rip),%xmm6        # f028 <_IO_stdin_used+0x28>
    e40f:	00 
    e410:	f2 0f 59 e6          	mulsd  %xmm6,%xmm4
    e414:	f3 0f 7e 6c 24 20    	movq   0x20(%rsp),%xmm5
    e41a:	66 0f 62 e9          	punpckldq %xmm1,%xmm5
    e41e:	66 0f 5c ea          	subpd  %xmm2,%xmm5
    e422:	66 0f 28 dd          	movapd %xmm5,%xmm3
    e426:	66 0f 15 dd          	unpckhpd %xmm5,%xmm3
    e42a:	f2 0f 58 dd          	addsd  %xmm5,%xmm3
    e42e:	f2 0f 59 de          	mulsd  %xmm6,%xmm3
    e432:	f3 0f 7e 6c 24 28    	movq   0x28(%rsp),%xmm5
    e438:	66 0f 62 e9          	punpckldq %xmm1,%xmm5
    e43c:	66 0f 5c ea          	subpd  %xmm2,%xmm5
    e440:	66 0f 28 d5          	movapd %xmm5,%xmm2
    e444:	66 0f 15 d5          	unpckhpd %xmm5,%xmm2
    e448:	f2 0f 58 d5          	addsd  %xmm5,%xmm2
    e44c:	f2 0f 59 d6          	mulsd  %xmm6,%xmm2
    e450:	f2 0f 10 44 24 48    	movsd  0x48(%rsp),%xmm0
    e456:	f2 0f 10 4c 24 30    	movsd  0x30(%rsp),%xmm1
    e45c:	f2 0f 58 c1          	addsd  %xmm1,%xmm0
    e460:	f2 0f 59 ce          	mulsd  %xmm6,%xmm1
    e464:	f2 0f 59 c6          	mulsd  %xmm6,%xmm0
    e468:	83 3d ed 4c 00 00 00 	cmpl   $0x0,0x4ced(%rip)        # 1315c <fwp_gc+0xff4>
    e46f:	48 8d 05 1a 14 00 00 	lea    0x141a(%rip),%rax        # f890 <fwp_segv.msg+0x610>
    e476:	4c 8d 0d 55 15 00 00 	lea    0x1555(%rip),%r9        # f9d2 <fwp_segv.msg+0x752>
    e47d:	4c 0f 44 c8          	cmove  %rax,%r9
    e481:	48 8d 35 53 13 00 00 	lea    0x1353(%rip),%rsi        # f7db <fwp_segv.msg+0x55b>
    e488:	48 89 ef             	mov    %rbp,%rdi
    e48b:	48 89 da             	mov    %rbx,%rdx
    e48e:	4c 89 f9             	mov    %r15,%rcx
    e491:	f2 0f 10 6c 24 40    	movsd  0x40(%rsp),%xmm5
    e497:	f2 0f 10 74 24 38    	movsd  0x38(%rsp),%xmm6
    e49d:	4d 89 e0             	mov    %r12,%r8
    e4a0:	b0 07                	mov    $0x7,%al
    e4a2:	e8 f9 3c ff ff       	call   21a0 <fprintf@plt>
    e4a7:	48 81 c4 58 01 00 00 	add    $0x158,%rsp
    e4ae:	5b                   	pop    %rbx
    e4af:	41 5c                	pop    %r12
    e4b1:	41 5d                	pop    %r13
    e4b3:	41 5e                	pop    %r14
    e4b5:	41 5f                	pop    %r15
    e4b7:	5d                   	pop    %rbp
    e4b8:	c3                   	ret
    e4b9:	48 8d 6c 24 56       	lea    0x56(%rsp),%rbp
    e4be:	41 bf 56 6d 48 57    	mov    $0x57486d56,%r15d
    e4c4:	48 8d 5c 24 50       	lea    0x50(%rsp),%rbx
    e4c9:	eb 1e                	jmp    e4e9 <fwp_gc_report+0x219>
    e4cb:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)
    e4d0:	48 89 df             	mov    %rbx,%rdi
    e4d3:	be 00 01 00 00       	mov    $0x100,%esi
    e4d8:	4c 89 ea             	mov    %r13,%rdx
    e4db:	e8 70 3c ff ff       	call   2150 <fgets@plt>
    e4e0:	48 85 c0             	test   %rax,%rax
    e4e3:	0f 84 df fe ff ff    	je     e3c8 <fwp_gc_report+0xf8>
    e4e9:	8b 44 24 50          	mov    0x50(%rsp),%eax
    e4ed:	44 31 f8             	xor    %r15d,%eax
    e4f0:	0f b6 4c 24 54       	movzbl 0x54(%rsp),%ecx
    e4f5:	83 f1 4d             	xor    $0x4d,%ecx
    e4f8:	09 c1                	or     %eax,%ecx
    e4fa:	75 d4                	jne    e4d0 <fwp_gc_report+0x200>
    e4fc:	80 7c 24 55 3a       	cmpb   $0x3a,0x55(%rsp)
    e501:	75 cd                	jne    e4d0 <fwp_gc_report+0x200>
    e503:	48 89 ef             	mov    %rbp,%rdi
    e506:	31 f6                	xor    %esi,%esi
    e508:	ba 0a 00 00 00       	mov    $0xa,%edx
    e50d:	e8 ae 3c ff ff       	call   21c0 <strtol@plt>
    e512:	49 89 c4             	mov    %rax,%r12
    e515:	eb b9                	jmp    e4d0 <fwp_gc_report+0x200>
    e517:	66 0f 1f 84 00 00 00 	nopw   0x0(%rax,%rax,1)
    e51e:	00 00 

000000000000e520 <fwp_static_report>:
    e520:	50                   	push   %rax
    e521:	48 8b 05 b8 3a 00 00 	mov    0x3ab8(%rip),%rax        # 11fe0 <stderr@GLIBC_2.2.5>
    e528:	48 8b 38             	mov    (%rax),%rdi
    e52b:	48 8b 15 86 56 00 00 	mov    0x5686(%rip),%rdx        # 13bb8 <fwp_static+0x18>
    e532:	48 2b 15 6f 56 00 00 	sub    0x566f(%rip),%rdx        # 13ba8 <fwp_static+0x8>
    e539:	48 c1 ea 0a          	shr    $0xa,%rdx
    e53d:	48 8b 0d bc 5e 00 00 	mov    0x5ebc(%rip),%rcx        # 14400 <fwp_static+0x860>
    e544:	48 c1 e9 0a          	shr    $0xa,%rcx
    e548:	4c 8b 05 61 4c 00 00 	mov    0x4c61(%rip),%r8        # 131b0 <fwp_gc+0x1048>
    e54f:	49 c1 e8 0a          	shr    $0xa,%r8
    e553:	4c 8b 0d de 4d 00 00 	mov    0x4dde(%rip),%r9        # 13338 <fwp_gc+0x11d0>
    e55a:	49 c1 e9 0a          	shr    $0xa,%r9
    e55e:	4c 8b 15 7b 5e 00 00 	mov    0x5e7b(%rip),%r10        # 143e0 <fwp_static+0x840>
    e565:	49 c1 ea 0a          	shr    $0xa,%r10
    e569:	44 8b 1d ac 61 00 00 	mov    0x61ac(%rip),%r11d        # 1471c <fwp_static+0xb7c>
    e570:	48 83 ec 08          	sub    $0x8,%rsp
    e574:	48 8d 35 39 13 00 00 	lea    0x1339(%rip),%rsi        # f8b4 <fwp_segv.msg+0x634>
    e57b:	31 c0                	xor    %eax,%eax
    e57d:	68 00 04 00 00       	push   $0x400
    e582:	6a 08                	push   $0x8
    e584:	41 53                	push   %r11
    e586:	68 00 04 00 00       	push   $0x400
    e58b:	6a 40                	push   $0x40
    e58d:	68 00 40 00 00       	push   $0x4000
    e592:	41 52                	push   %r10
    e594:	68 00 80 00 00       	push   $0x8000
    e599:	ff 35 a1 4d 00 00    	push   0x4da1(%rip)        # 13340 <fwp_gc+0x11d8>
    e59f:	e8 fc 3b ff ff       	call   21a0 <fprintf@plt>
    e5a4:	48 83 c4 50          	add    $0x50,%rsp
    e5a8:	58                   	pop    %rax
    e5a9:	c3                   	ret
    e5aa:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)

000000000000e5b0 <fwp_segv>:
    e5b0:	48 8b 05 e9 61 00 00 	mov    0x61e9(%rip),%rax        # 147a0 <fwp_main_stack_top>
    e5b7:	48 85 c0             	test   %rax,%rax
    e5ba:	74 22                	je     e5de <fwp_segv+0x2e>
    e5bc:	48 8b 4e 10          	mov    0x10(%rsi),%rcx
    e5c0:	48 2b 05 e1 61 00 00 	sub    0x61e1(%rip),%rax        # 147a8 <fwp_main_stack_size>
    e5c7:	48 8d 90 00 00 f0 ff 	lea    -0x100000(%rax),%rdx
    e5ce:	48 39 ca             	cmp    %rcx,%rdx
    e5d1:	77 0b                	ja     e5de <fwp_segv+0x2e>
    e5d3:	48 05 00 00 10 00    	add    $0x100000,%rax
    e5d9:	48 39 c8             	cmp    %rcx,%rax
    e5dc:	77 07                	ja     e5e5 <fwp_segv+0x35>
    e5de:	31 f6                	xor    %esi,%esi
    e5e0:	e9 9b 3b ff ff       	jmp    2180 <signal@plt>
    e5e5:	50                   	push   %rax
    e5e6:	e8 75 84 ff ff       	call   6a60 <fwp_flush>
    e5eb:	48 8d 35 8e 0c 00 00 	lea    0xc8e(%rip),%rsi        # f280 <fwp_segv.msg>
    e5f2:	ba 1a 00 00 00       	mov    $0x1a,%edx
    e5f7:	bf 02 00 00 00       	mov    $0x2,%edi
    e5fc:	e8 af 3a ff ff       	call   20b0 <write@plt>
    e601:	bf 65 00 00 00       	mov    $0x65,%edi
    e606:	e8 55 3a ff ff       	call   2060 <_exit@plt>
    e60b:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)

000000000000e610 <fwp_drop0>:
    e610:	53                   	push   %rbx
    e611:	48 89 f8             	mov    %rdi,%rax
    e614:	48 2b 05 7d 4b 00 00 	sub    0x4b7d(%rip),%rax        # 13198 <fwp_gc+0x1030>
    e61b:	48 8b 0d 9e 4b 00 00 	mov    0x4b9e(%rip),%rcx        # 131c0 <fwp_gc+0x1058>
    e622:	48 c1 e1 10          	shl    $0x10,%rcx
    e626:	48 39 c8             	cmp    %rcx,%rax
    e629:	0f 83 96 00 00 00    	jae    e6c5 <fwp_drop0+0xb5>
    e62f:	48 8b 0d aa 4b 00 00 	mov    0x4baa(%rip),%rcx        # 131e0 <fwp_gc+0x1078>
    e636:	48 89 c2             	mov    %rax,%rdx
    e639:	48 c1 ea 10          	shr    $0x10,%rdx
    e63d:	48 69 d2 28 12 00 00 	imul   $0x1228,%rdx,%rdx
    e644:	0f b6 34 11          	movzbl (%rcx,%rdx,1),%esi
    e648:	48 25 ff ff 00 00    	and    $0xffff,%rax
    e64e:	75 20                	jne    e670 <fwp_drop0+0x60>
    e650:	40 80 fe 02          	cmp    $0x2,%sil
    e654:	75 1a                	jne    e670 <fwp_drop0+0x60>
    e656:	48 8d 04 11          	lea    (%rcx,%rdx,1),%rax
    e65a:	48 05 28 02 00 00    	add    $0x228,%rax
    e660:	eb 2d                	jmp    e68f <fwp_drop0+0x7f>
    e662:	66 66 66 66 66 2e 0f 	data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    e669:	1f 84 00 00 00 00 00 
    e670:	40 80 fe 01          	cmp    $0x1,%sil
    e674:	75 4f                	jne    e6c5 <fwp_drop0+0xb5>
    e676:	48 8d 34 11          	lea    (%rcx,%rdx,1),%rsi
    e67a:	8b 4c 11 20          	mov    0x20(%rcx,%rdx,1),%ecx
    e67e:	48 0f af c1          	imul   %rcx,%rax
    e682:	48 c1 e8 20          	shr    $0x20,%rax
    e686:	48 01 f0             	add    %rsi,%rax
    e689:	48 05 28 02 00 00    	add    $0x228,%rax
    e68f:	0f b6 08             	movzbl (%rax),%ecx
    e692:	85 c9                	test   %ecx,%ecx
    e694:	74 2f                	je     e6c5 <fwp_drop0+0xb5>
    e696:	83 f9 01             	cmp    $0x1,%ecx
    e699:	75 2c                	jne    e6c7 <fwp_drop0+0xb7>
    e69b:	48 8b 5f 10          	mov    0x10(%rdi),%rbx
    e69f:	e8 cc c8 ff ff       	call   af70 <fwp_rc_free_obj>
    e6a4:	48 89 d8             	mov    %rbx,%rax
    e6a7:	48 2b 05 ea 4a 00 00 	sub    0x4aea(%rip),%rax        # 13198 <fwp_gc+0x1030>
    e6ae:	48 8b 0d 0b 4b 00 00 	mov    0x4b0b(%rip),%rcx        # 131c0 <fwp_gc+0x1058>
    e6b5:	48 c1 e1 10          	shl    $0x10,%rcx
    e6b9:	48 89 df             	mov    %rbx,%rdi
    e6bc:	48 39 c8             	cmp    %rcx,%rax
    e6bf:	0f 82 6a ff ff ff    	jb     e62f <fwp_drop0+0x1f>
    e6c5:	5b                   	pop    %rbx
    e6c6:	c3                   	ret
    e6c7:	81 f9 ff 00 00 00    	cmp    $0xff,%ecx
    e6cd:	74 06                	je     e6d5 <fwp_drop0+0xc5>
    e6cf:	fe c9                	dec    %cl
    e6d1:	88 08                	mov    %cl,(%rax)
    e6d3:	5b                   	pop    %rbx
    e6d4:	c3                   	ret
    e6d5:	48 89 c7             	mov    %rax,%rdi
    e6d8:	5b                   	pop    %rbx
    e6d9:	e9 b2 c5 ff ff       	jmp    ac90 <fwp_rc_wide_drop>
    e6de:	66 90                	xchg   %ax,%ax

000000000000e6e0 <fwp_drop4>:
    e6e0:	53                   	push   %rbx
    e6e1:	48 89 f8             	mov    %rdi,%rax
    e6e4:	48 2b 05 ad 4a 00 00 	sub    0x4aad(%rip),%rax        # 13198 <fwp_gc+0x1030>
    e6eb:	48 8b 0d ce 4a 00 00 	mov    0x4ace(%rip),%rcx        # 131c0 <fwp_gc+0x1058>
    e6f2:	48 c1 e1 10          	shl    $0x10,%rcx
    e6f6:	48 39 c8             	cmp    %rcx,%rax
    e6f9:	0f 83 96 00 00 00    	jae    e795 <fwp_drop4+0xb5>
    e6ff:	48 8b 0d da 4a 00 00 	mov    0x4ada(%rip),%rcx        # 131e0 <fwp_gc+0x1078>
    e706:	48 89 c2             	mov    %rax,%rdx
    e709:	48 c1 ea 10          	shr    $0x10,%rdx
    e70d:	48 69 d2 28 12 00 00 	imul   $0x1228,%rdx,%rdx
    e714:	0f b6 34 11          	movzbl (%rcx,%rdx,1),%esi
    e718:	48 25 ff ff 00 00    	and    $0xffff,%rax
    e71e:	75 20                	jne    e740 <fwp_drop4+0x60>
    e720:	40 80 fe 02          	cmp    $0x2,%sil
    e724:	75 1a                	jne    e740 <fwp_drop4+0x60>
    e726:	48 8d 04 11          	lea    (%rcx,%rdx,1),%rax
    e72a:	48 05 28 02 00 00    	add    $0x228,%rax
    e730:	eb 2d                	jmp    e75f <fwp_drop4+0x7f>
    e732:	66 66 66 66 66 2e 0f 	data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    e739:	1f 84 00 00 00 00 00 
    e740:	40 80 fe 01          	cmp    $0x1,%sil
    e744:	75 4f                	jne    e795 <fwp_drop4+0xb5>
    e746:	48 8d 34 11          	lea    (%rcx,%rdx,1),%rsi
    e74a:	8b 4c 11 20          	mov    0x20(%rcx,%rdx,1),%ecx
    e74e:	48 0f af c1          	imul   %rcx,%rax
    e752:	48 c1 e8 20          	shr    $0x20,%rax
    e756:	48 01 f0             	add    %rsi,%rax
    e759:	48 05 28 02 00 00    	add    $0x228,%rax
    e75f:	0f b6 08             	movzbl (%rax),%ecx
    e762:	85 c9                	test   %ecx,%ecx
    e764:	74 2f                	je     e795 <fwp_drop4+0xb5>
    e766:	83 f9 01             	cmp    $0x1,%ecx
    e769:	75 2c                	jne    e797 <fwp_drop4+0xb7>
    e76b:	48 8b 5f 10          	mov    0x10(%rdi),%rbx
    e76f:	e8 fc c7 ff ff       	call   af70 <fwp_rc_free_obj>
    e774:	48 89 d8             	mov    %rbx,%rax
    e777:	48 2b 05 1a 4a 00 00 	sub    0x4a1a(%rip),%rax        # 13198 <fwp_gc+0x1030>
    e77e:	48 8b 0d 3b 4a 00 00 	mov    0x4a3b(%rip),%rcx        # 131c0 <fwp_gc+0x1058>
    e785:	48 c1 e1 10          	shl    $0x10,%rcx
    e789:	48 89 df             	mov    %rbx,%rdi
    e78c:	48 39 c8             	cmp    %rcx,%rax
    e78f:	0f 82 6a ff ff ff    	jb     e6ff <fwp_drop4+0x1f>
    e795:	5b                   	pop    %rbx
    e796:	c3                   	ret
    e797:	81 f9 ff 00 00 00    	cmp    $0xff,%ecx
    e79d:	74 06                	je     e7a5 <fwp_drop4+0xc5>
    e79f:	fe c9                	dec    %cl
    e7a1:	88 08                	mov    %cl,(%rax)
    e7a3:	5b                   	pop    %rbx
    e7a4:	c3                   	ret
    e7a5:	48 89 c7             	mov    %rax,%rdi
    e7a8:	5b                   	pop    %rbx
    e7a9:	e9 e2 c4 ff ff       	jmp    ac90 <fwp_rc_wide_drop>
    e7ae:	66 90                	xchg   %ax,%ax

000000000000e7b0 <__divti3>:
    e7b0:	f3 0f 1e fa          	endbr64
    e7b4:	55                   	push   %rbp
    e7b5:	49 89 f8             	mov    %rdi,%r8
    e7b8:	49 89 d2             	mov    %rdx,%r10
    e7bb:	49 89 cb             	mov    %rcx,%r11
    e7be:	31 ff                	xor    %edi,%edi
    e7c0:	48 89 e5             	mov    %rsp,%rbp
    e7c3:	41 56                	push   %r14
    e7c5:	53                   	push   %rbx
    e7c6:	48 85 f6             	test   %rsi,%rsi
    e7c9:	79 13                	jns    e7de <__divti3+0x2e>
    e7cb:	45 31 c9             	xor    %r9d,%r9d
    e7ce:	49 f7 d8             	neg    %r8
    e7d1:	48 c7 c7 ff ff ff ff 	mov    $0xffffffffffffffff,%rdi
    e7d8:	49 19 f1             	sbb    %rsi,%r9
    e7db:	4c 89 ce             	mov    %r9,%rsi
    e7de:	4c 89 da             	mov    %r11,%rdx
    e7e1:	4d 85 db             	test   %r11,%r11
    e7e4:	0f 88 f6 00 00 00    	js     e8e0 <__divti3+0x130>
    e7ea:	4d 89 d6             	mov    %r10,%r14
    e7ed:	75 31                	jne    e820 <__divti3+0x70>
    e7ef:	4c 39 f6             	cmp    %r14,%rsi
    e7f2:	0f 83 b8 00 00 00    	jae    e8b0 <__divti3+0x100>
    e7f8:	48 89 f2             	mov    %rsi,%rdx
    e7fb:	31 f6                	xor    %esi,%esi
    e7fd:	4c 89 c0             	mov    %r8,%rax
    e800:	49 f7 f6             	div    %r14
    e803:	48 89 f2             	mov    %rsi,%rdx
    e806:	48 85 ff             	test   %rdi,%rdi
    e809:	74 0a                	je     e815 <__divti3+0x65>
    e80b:	48 f7 d8             	neg    %rax
    e80e:	48 83 d2 00          	adc    $0x0,%rdx
    e812:	48 f7 da             	neg    %rdx
    e815:	5b                   	pop    %rbx
    e816:	41 5e                	pop    %r14
    e818:	5d                   	pop    %rbp
    e819:	c3                   	ret
    e81a:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)
    e820:	4c 39 de             	cmp    %r11,%rsi
    e823:	0f 82 d5 00 00 00    	jb     e8fe <__divti3+0x14e>
    e829:	4d 0f bd d3          	bsr    %r11,%r10
    e82d:	41 83 f2 3f          	xor    $0x3f,%r10d
    e831:	44 89 d1             	mov    %r10d,%ecx
    e834:	b8 40 00 00 00       	mov    $0x40,%eax
    e839:	4c 89 f3             	mov    %r14,%rbx
    e83c:	4d 89 f1             	mov    %r14,%r9
    e83f:	48 d3 e2             	shl    %cl,%rdx
    e842:	49 63 ca             	movslq %r10d,%rcx
    e845:	49 89 f3             	mov    %rsi,%r11
    e848:	48 29 c8             	sub    %rcx,%rax
    e84b:	89 c1                	mov    %eax,%ecx
    e84d:	48 d3 eb             	shr    %cl,%rbx
    e850:	44 89 d1             	mov    %r10d,%ecx
    e853:	49 d3 e1             	shl    %cl,%r9
    e856:	89 c1                	mov    %eax,%ecx
    e858:	48 09 d3             	or     %rdx,%rbx
    e85b:	4c 89 c2             	mov    %r8,%rdx
    e85e:	49 d3 eb             	shr    %cl,%r11
    e861:	44 89 d1             	mov    %r10d,%ecx
    e864:	48 d3 e6             	shl    %cl,%rsi
    e867:	89 c1                	mov    %eax,%ecx
    e869:	48 d3 ea             	shr    %cl,%rdx
    e86c:	48 89 d0             	mov    %rdx,%rax
    e86f:	4c 89 da             	mov    %r11,%rdx
    e872:	48 09 f0             	or     %rsi,%rax
    e875:	48 f7 f3             	div    %rbx
    e878:	49 89 d3             	mov    %rdx,%r11
    e87b:	48 89 c6             	mov    %rax,%rsi
    e87e:	49 f7 e1             	mul    %r9
    e881:	49 39 d3             	cmp    %rdx,%r11
    e884:	0f 82 be 00 00 00    	jb     e948 <__divti3+0x198>
    e88a:	44 89 d1             	mov    %r10d,%ecx
    e88d:	49 d3 e0             	shl    %cl,%r8
    e890:	49 39 c0             	cmp    %rax,%r8
    e893:	73 09                	jae    e89e <__divti3+0xee>
    e895:	49 39 d3             	cmp    %rdx,%r11
    e898:	0f 84 aa 00 00 00    	je     e948 <__divti3+0x198>
    e89e:	48 89 f0             	mov    %rsi,%rax
    e8a1:	31 f6                	xor    %esi,%esi
    e8a3:	e9 5b ff ff ff       	jmp    e803 <__divti3+0x53>
    e8a8:	0f 1f 84 00 00 00 00 	nopl   0x0(%rax,%rax,1)
    e8af:	00 
    e8b0:	4d 85 f6             	test   %r14,%r14
    e8b3:	75 0d                	jne    e8c2 <__divti3+0x112>
    e8b5:	b8 01 00 00 00       	mov    $0x1,%eax
    e8ba:	31 d2                	xor    %edx,%edx
    e8bc:	49 f7 f6             	div    %r14
    e8bf:	49 89 c6             	mov    %rax,%r14
    e8c2:	48 89 f0             	mov    %rsi,%rax
    e8c5:	31 d2                	xor    %edx,%edx
    e8c7:	49 f7 f6             	div    %r14
    e8ca:	48 89 c6             	mov    %rax,%rsi
    e8cd:	4c 89 c0             	mov    %r8,%rax
    e8d0:	49 f7 f6             	div    %r14
    e8d3:	e9 2b ff ff ff       	jmp    e803 <__divti3+0x53>
    e8d8:	0f 1f 84 00 00 00 00 	nopl   0x0(%rax,%rax,1)
    e8df:	00 
    e8e0:	49 f7 da             	neg    %r10
    e8e3:	48 f7 d7             	not    %rdi
    e8e6:	49 83 d3 00          	adc    $0x0,%r11
    e8ea:	4d 89 d6             	mov    %r10,%r14
    e8ed:	49 f7 db             	neg    %r11
    e8f0:	4c 89 da             	mov    %r11,%rdx
    e8f3:	0f 84 f6 fe ff ff    	je     e7ef <__divti3+0x3f>
    e8f9:	4c 39 de             	cmp    %r11,%rsi
    e8fc:	73 12                	jae    e910 <__divti3+0x160>
    e8fe:	31 f6                	xor    %esi,%esi
    e900:	31 c0                	xor    %eax,%eax
    e902:	e9 fc fe ff ff       	jmp    e803 <__divti3+0x53>
    e907:	66 0f 1f 84 00 00 00 	nopw   0x0(%rax,%rax,1)
    e90e:	00 00 
    e910:	49 0f bd c3          	bsr    %r11,%rax
    e914:	48 83 f0 3f          	xor    $0x3f,%rax
    e918:	41 89 c2             	mov    %eax,%r10d
    e91b:	85 c0                	test   %eax,%eax
    e91d:	0f 85 0e ff ff ff    	jne    e831 <__divti3+0x81>
    e923:	49 39 f3             	cmp    %rsi,%r11
    e926:	72 0d                	jb     e935 <__divti3+0x185>
    e928:	31 f6                	xor    %esi,%esi
    e92a:	31 c0                	xor    %eax,%eax
    e92c:	4d 39 f0             	cmp    %r14,%r8
    e92f:	0f 82 ce fe ff ff    	jb     e803 <__divti3+0x53>
    e935:	31 f6                	xor    %esi,%esi
    e937:	b8 01 00 00 00       	mov    $0x1,%eax
    e93c:	e9 c2 fe ff ff       	jmp    e803 <__divti3+0x53>
    e941:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)
    e948:	48 8d 46 ff          	lea    -0x1(%rsi),%rax
    e94c:	31 f6                	xor    %esi,%esi
    e94e:	e9 b0 fe ff ff       	jmp    e803 <__divti3+0x53>
    e953:	66 2e 0f 1f 84 00 00 	cs nopw 0x0(%rax,%rax,1)
    e95a:	00 00 00 
    e95d:	0f 1f 00             	nopl   (%rax)

000000000000e960 <atexit>:
    e960:	f3 0f 1e fa          	endbr64
    e964:	48 8b 15 ed 37 00 00 	mov    0x37ed(%rip),%rdx        # 12158 <__dso_handle>
    e96b:	31 f6                	xor    %esi,%esi
    e96d:	e9 de 38 ff ff       	jmp    2250 <__cxa_atexit@plt>

Disassembly of section .fini:

000000000000e974 <_fini>:
    e974:	f3 0f 1e fa          	endbr64
    e978:	48 83 ec 08          	sub    $0x8,%rsp
    e97c:	48 83 c4 08          	add    $0x8,%rsp
    e980:	c3                   	ret
