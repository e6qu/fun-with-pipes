
/tmp/fwp-arc-3781/arrays-0-dynamic-O2:     file format elf64-x86-64


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

0000000000002050 <free@plt>:
    2050:	ff 25 ba ff 00 00    	jmp    *0xffba(%rip)        # 12010 <free@GLIBC_2.2.5>
    2056:	68 02 00 00 00       	push   $0x2
    205b:	e9 c0 ff ff ff       	jmp    2020 <_init+0x20>

0000000000002060 <abort@plt>:
    2060:	ff 25 b2 ff 00 00    	jmp    *0xffb2(%rip)        # 12018 <abort@GLIBC_2.2.5>
    2066:	68 03 00 00 00       	push   $0x3
    206b:	e9 b0 ff ff ff       	jmp    2020 <_init+0x20>

0000000000002070 <_exit@plt>:
    2070:	ff 25 aa ff 00 00    	jmp    *0xffaa(%rip)        # 12020 <_exit@GLIBC_2.2.5>
    2076:	68 04 00 00 00       	push   $0x4
    207b:	e9 a0 ff ff ff       	jmp    2020 <_init+0x20>

0000000000002080 <strcpy@plt>:
    2080:	ff 25 a2 ff 00 00    	jmp    *0xffa2(%rip)        # 12028 <strcpy@GLIBC_2.2.5>
    2086:	68 05 00 00 00       	push   $0x5
    208b:	e9 90 ff ff ff       	jmp    2020 <_init+0x20>

0000000000002090 <sigaction@plt>:
    2090:	ff 25 9a ff 00 00    	jmp    *0xff9a(%rip)        # 12030 <sigaction@GLIBC_2.2.5>
    2096:	68 06 00 00 00       	push   $0x6
    209b:	e9 80 ff ff ff       	jmp    2020 <_init+0x20>

00000000000020a0 <strtod@plt>:
    20a0:	ff 25 92 ff 00 00    	jmp    *0xff92(%rip)        # 12038 <strtod@GLIBC_2.2.5>
    20a6:	68 07 00 00 00       	push   $0x7
    20ab:	e9 70 ff ff ff       	jmp    2020 <_init+0x20>

00000000000020b0 <clock_gettime@plt>:
    20b0:	ff 25 8a ff 00 00    	jmp    *0xff8a(%rip)        # 12040 <clock_gettime@GLIBC_2.17>
    20b6:	68 08 00 00 00       	push   $0x8
    20bb:	e9 60 ff ff ff       	jmp    2020 <_init+0x20>

00000000000020c0 <write@plt>:
    20c0:	ff 25 82 ff 00 00    	jmp    *0xff82(%rip)        # 12048 <write@GLIBC_2.2.5>
    20c6:	68 09 00 00 00       	push   $0x9
    20cb:	e9 50 ff ff ff       	jmp    2020 <_init+0x20>

00000000000020d0 <fclose@plt>:
    20d0:	ff 25 7a ff 00 00    	jmp    *0xff7a(%rip)        # 12050 <fclose@GLIBC_2.2.5>
    20d6:	68 0a 00 00 00       	push   $0xa
    20db:	e9 40 ff ff ff       	jmp    2020 <_init+0x20>

00000000000020e0 <strlen@plt>:
    20e0:	ff 25 72 ff 00 00    	jmp    *0xff72(%rip)        # 12058 <strlen@GLIBC_2.2.5>
    20e6:	68 0b 00 00 00       	push   $0xb
    20eb:	e9 30 ff ff ff       	jmp    2020 <_init+0x20>

00000000000020f0 <mmap@plt>:
    20f0:	ff 25 6a ff 00 00    	jmp    *0xff6a(%rip)        # 12060 <mmap@GLIBC_2.2.5>
    20f6:	68 0c 00 00 00       	push   $0xc
    20fb:	e9 20 ff ff ff       	jmp    2020 <_init+0x20>

0000000000002100 <strchr@plt>:
    2100:	ff 25 62 ff 00 00    	jmp    *0xff62(%rip)        # 12068 <strchr@GLIBC_2.2.5>
    2106:	68 0d 00 00 00       	push   $0xd
    210b:	e9 10 ff ff ff       	jmp    2020 <_init+0x20>

0000000000002110 <snprintf@plt>:
    2110:	ff 25 5a ff 00 00    	jmp    *0xff5a(%rip)        # 12070 <snprintf@GLIBC_2.2.5>
    2116:	68 0e 00 00 00       	push   $0xe
    211b:	e9 00 ff ff ff       	jmp    2020 <_init+0x20>

0000000000002120 <strtof@plt>:
    2120:	ff 25 52 ff 00 00    	jmp    *0xff52(%rip)        # 12078 <strtof@GLIBC_2.2.5>
    2126:	68 0f 00 00 00       	push   $0xf
    212b:	e9 f0 fe ff ff       	jmp    2020 <_init+0x20>

0000000000002130 <memset@plt>:
    2130:	ff 25 4a ff 00 00    	jmp    *0xff4a(%rip)        # 12080 <memset@GLIBC_2.2.5>
    2136:	68 10 00 00 00       	push   $0x10
    213b:	e9 e0 fe ff ff       	jmp    2020 <_init+0x20>

0000000000002140 <fputc@plt>:
    2140:	ff 25 42 ff 00 00    	jmp    *0xff42(%rip)        # 12088 <fputc@GLIBC_2.2.5>
    2146:	68 11 00 00 00       	push   $0x11
    214b:	e9 d0 fe ff ff       	jmp    2020 <_init+0x20>

0000000000002150 <pthread_attr_init@plt>:
    2150:	ff 25 3a ff 00 00    	jmp    *0xff3a(%rip)        # 12090 <pthread_attr_init@GLIBC_2.2.5>
    2156:	68 12 00 00 00       	push   $0x12
    215b:	e9 c0 fe ff ff       	jmp    2020 <_init+0x20>

0000000000002160 <fgets@plt>:
    2160:	ff 25 32 ff 00 00    	jmp    *0xff32(%rip)        # 12098 <fgets@GLIBC_2.2.5>
    2166:	68 13 00 00 00       	push   $0x13
    216b:	e9 b0 fe ff ff       	jmp    2020 <_init+0x20>

0000000000002170 <strtoull@plt>:
    2170:	ff 25 2a ff 00 00    	jmp    *0xff2a(%rip)        # 120a0 <strtoull@GLIBC_2.2.5>
    2176:	68 14 00 00 00       	push   $0x14
    217b:	e9 a0 fe ff ff       	jmp    2020 <_init+0x20>

0000000000002180 <strcmp@plt>:
    2180:	ff 25 22 ff 00 00    	jmp    *0xff22(%rip)        # 120a8 <strcmp@GLIBC_2.2.5>
    2186:	68 15 00 00 00       	push   $0x15
    218b:	e9 90 fe ff ff       	jmp    2020 <_init+0x20>

0000000000002190 <signal@plt>:
    2190:	ff 25 1a ff 00 00    	jmp    *0xff1a(%rip)        # 120b0 <signal@GLIBC_2.2.5>
    2196:	68 16 00 00 00       	push   $0x16
    219b:	e9 80 fe ff ff       	jmp    2020 <_init+0x20>

00000000000021a0 <strtoll@plt>:
    21a0:	ff 25 12 ff 00 00    	jmp    *0xff12(%rip)        # 120b8 <strtoll@GLIBC_2.2.5>
    21a6:	68 17 00 00 00       	push   $0x17
    21ab:	e9 70 fe ff ff       	jmp    2020 <_init+0x20>

00000000000021b0 <fprintf@plt>:
    21b0:	ff 25 0a ff 00 00    	jmp    *0xff0a(%rip)        # 120c0 <fprintf@GLIBC_2.2.5>
    21b6:	68 18 00 00 00       	push   $0x18
    21bb:	e9 60 fe ff ff       	jmp    2020 <_init+0x20>

00000000000021c0 <sigemptyset@plt>:
    21c0:	ff 25 02 ff 00 00    	jmp    *0xff02(%rip)        # 120c8 <sigemptyset@GLIBC_2.2.5>
    21c6:	68 19 00 00 00       	push   $0x19
    21cb:	e9 50 fe ff ff       	jmp    2020 <_init+0x20>

00000000000021d0 <strtol@plt>:
    21d0:	ff 25 fa fe 00 00    	jmp    *0xfefa(%rip)        # 120d0 <strtol@GLIBC_2.2.5>
    21d6:	68 1a 00 00 00       	push   $0x1a
    21db:	e9 40 fe ff ff       	jmp    2020 <_init+0x20>

00000000000021e0 <memcpy@plt>:
    21e0:	ff 25 f2 fe 00 00    	jmp    *0xfef2(%rip)        # 120d8 <memcpy@GLIBC_2.14>
    21e6:	68 1b 00 00 00       	push   $0x1b
    21eb:	e9 30 fe ff ff       	jmp    2020 <_init+0x20>

00000000000021f0 <malloc@plt>:
    21f0:	ff 25 ea fe 00 00    	jmp    *0xfeea(%rip)        # 120e0 <malloc@GLIBC_2.2.5>
    21f6:	68 1c 00 00 00       	push   $0x1c
    21fb:	e9 20 fe ff ff       	jmp    2020 <_init+0x20>

0000000000002200 <fflush@plt>:
    2200:	ff 25 e2 fe 00 00    	jmp    *0xfee2(%rip)        # 120e8 <fflush@GLIBC_2.2.5>
    2206:	68 1d 00 00 00       	push   $0x1d
    220b:	e9 10 fe ff ff       	jmp    2020 <_init+0x20>

0000000000002210 <realloc@plt>:
    2210:	ff 25 da fe 00 00    	jmp    *0xfeda(%rip)        # 120f0 <realloc@GLIBC_2.2.5>
    2216:	68 1e 00 00 00       	push   $0x1e
    221b:	e9 00 fe ff ff       	jmp    2020 <_init+0x20>

0000000000002220 <setvbuf@plt>:
    2220:	ff 25 d2 fe 00 00    	jmp    *0xfed2(%rip)        # 120f8 <setvbuf@GLIBC_2.2.5>
    2226:	68 1f 00 00 00       	push   $0x1f
    222b:	e9 f0 fd ff ff       	jmp    2020 <_init+0x20>

0000000000002230 <pthread_create@plt>:
    2230:	ff 25 ca fe 00 00    	jmp    *0xfeca(%rip)        # 12100 <pthread_create@GLIBC_2.34>
    2236:	68 20 00 00 00       	push   $0x20
    223b:	e9 e0 fd ff ff       	jmp    2020 <_init+0x20>

0000000000002240 <mprotect@plt>:
    2240:	ff 25 c2 fe 00 00    	jmp    *0xfec2(%rip)        # 12108 <mprotect@GLIBC_2.2.5>
    2246:	68 21 00 00 00       	push   $0x21
    224b:	e9 d0 fd ff ff       	jmp    2020 <_init+0x20>

0000000000002250 <fopen@plt>:
    2250:	ff 25 ba fe 00 00    	jmp    *0xfeba(%rip)        # 12110 <fopen@GLIBC_2.2.5>
    2256:	68 22 00 00 00       	push   $0x22
    225b:	e9 c0 fd ff ff       	jmp    2020 <_init+0x20>

0000000000002260 <sysconf@plt>:
    2260:	ff 25 b2 fe 00 00    	jmp    *0xfeb2(%rip)        # 12118 <sysconf@GLIBC_2.2.5>
    2266:	68 23 00 00 00       	push   $0x23
    226b:	e9 b0 fd ff ff       	jmp    2020 <_init+0x20>

0000000000002270 <__cxa_atexit@plt>:
    2270:	ff 25 aa fe 00 00    	jmp    *0xfeaa(%rip)        # 12120 <__cxa_atexit@GLIBC_2.2.5>
    2276:	68 24 00 00 00       	push   $0x24
    227b:	e9 a0 fd ff ff       	jmp    2020 <_init+0x20>

0000000000002280 <sprintf@plt>:
    2280:	ff 25 a2 fe 00 00    	jmp    *0xfea2(%rip)        # 12128 <sprintf@GLIBC_2.2.5>
    2286:	68 25 00 00 00       	push   $0x25
    228b:	e9 90 fd ff ff       	jmp    2020 <_init+0x20>

0000000000002290 <exit@plt>:
    2290:	ff 25 9a fe 00 00    	jmp    *0xfe9a(%rip)        # 12130 <exit@GLIBC_2.2.5>
    2296:	68 26 00 00 00       	push   $0x26
    229b:	e9 80 fd ff ff       	jmp    2020 <_init+0x20>

00000000000022a0 <fwrite@plt>:
    22a0:	ff 25 92 fe 00 00    	jmp    *0xfe92(%rip)        # 12138 <fwrite@GLIBC_2.2.5>
    22a6:	68 27 00 00 00       	push   $0x27
    22ab:	e9 70 fd ff ff       	jmp    2020 <_init+0x20>

00000000000022b0 <getrlimit@plt>:
    22b0:	ff 25 8a fe 00 00    	jmp    *0xfe8a(%rip)        # 12140 <getrlimit@GLIBC_2.2.5>
    22b6:	68 28 00 00 00       	push   $0x28
    22bb:	e9 60 fd ff ff       	jmp    2020 <_init+0x20>

00000000000022c0 <pthread_join@plt>:
    22c0:	ff 25 82 fe 00 00    	jmp    *0xfe82(%rip)        # 12148 <pthread_join@GLIBC_2.34>
    22c6:	68 29 00 00 00       	push   $0x29
    22cb:	e9 50 fd ff ff       	jmp    2020 <_init+0x20>

00000000000022d0 <sigaltstack@plt>:
    22d0:	ff 25 7a fe 00 00    	jmp    *0xfe7a(%rip)        # 12150 <sigaltstack@GLIBC_2.2.5>
    22d6:	68 2a 00 00 00       	push   $0x2a
    22db:	e9 40 fd ff ff       	jmp    2020 <_init+0x20>

00000000000022e0 <strstr@plt>:
    22e0:	ff 25 72 fe 00 00    	jmp    *0xfe72(%rip)        # 12158 <strstr@GLIBC_2.2.5>
    22e6:	68 2b 00 00 00       	push   $0x2b
    22eb:	e9 30 fd ff ff       	jmp    2020 <_init+0x20>

00000000000022f0 <pthread_attr_setstacksize@plt>:
    22f0:	ff 25 6a fe 00 00    	jmp    *0xfe6a(%rip)        # 12160 <pthread_attr_setstacksize@GLIBC_2.34>
    22f6:	68 2c 00 00 00       	push   $0x2c
    22fb:	e9 20 fd ff ff       	jmp    2020 <_init+0x20>

Disassembly of section .plt.got:

0000000000002300 <__cxa_finalize@plt>:
    2300:	ff 25 d2 fc 00 00    	jmp    *0xfcd2(%rip)        # 11fd8 <__cxa_finalize@GLIBC_2.2.5>
    2306:	66 90                	xchg   %ax,%ax

Disassembly of section .text:

0000000000002310 <_start>:
    2310:	f3 0f 1e fa          	endbr64
    2314:	31 ed                	xor    %ebp,%ebp
    2316:	49 89 d1             	mov    %rdx,%r9
    2319:	5e                   	pop    %rsi
    231a:	48 89 e2             	mov    %rsp,%rdx
    231d:	48 83 e4 f0          	and    $0xfffffffffffffff0,%rsp
    2321:	50                   	push   %rax
    2322:	54                   	push   %rsp
    2323:	45 31 c0             	xor    %r8d,%r8d
    2326:	31 c9                	xor    %ecx,%ecx
    2328:	48 8d 3d d1 00 00 00 	lea    0xd1(%rip),%rdi        # 2400 <main>
    232f:	ff 15 7b fc 00 00    	call   *0xfc7b(%rip)        # 11fb0 <__libc_start_main@GLIBC_2.34>
    2335:	f4                   	hlt
    2336:	66 2e 0f 1f 84 00 00 	cs nopw 0x0(%rax,%rax,1)
    233d:	00 00 00 

0000000000002340 <deregister_tm_clones>:
    2340:	48 8d 3d 61 18 01 00 	lea    0x11861(%rip),%rdi        # 13ba8 <__TMC_END__>
    2347:	48 8d 05 5a 18 01 00 	lea    0x1185a(%rip),%rax        # 13ba8 <__TMC_END__>
    234e:	48 39 f8             	cmp    %rdi,%rax
    2351:	74 15                	je     2368 <deregister_tm_clones+0x28>
    2353:	48 8b 05 5e fc 00 00 	mov    0xfc5e(%rip),%rax        # 11fb8 <_ITM_deregisterTMCloneTable@Base>
    235a:	48 85 c0             	test   %rax,%rax
    235d:	74 09                	je     2368 <deregister_tm_clones+0x28>
    235f:	ff e0                	jmp    *%rax
    2361:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)
    2368:	c3                   	ret
    2369:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)

0000000000002370 <register_tm_clones>:
    2370:	48 8d 3d 31 18 01 00 	lea    0x11831(%rip),%rdi        # 13ba8 <__TMC_END__>
    2377:	48 8d 35 2a 18 01 00 	lea    0x1182a(%rip),%rsi        # 13ba8 <__TMC_END__>
    237e:	48 29 fe             	sub    %rdi,%rsi
    2381:	48 89 f0             	mov    %rsi,%rax
    2384:	48 c1 ee 3f          	shr    $0x3f,%rsi
    2388:	48 c1 f8 03          	sar    $0x3,%rax
    238c:	48 01 c6             	add    %rax,%rsi
    238f:	48 d1 fe             	sar    $1,%rsi
    2392:	74 14                	je     23a8 <register_tm_clones+0x38>
    2394:	48 8b 05 35 fc 00 00 	mov    0xfc35(%rip),%rax        # 11fd0 <_ITM_registerTMCloneTable@Base>
    239b:	48 85 c0             	test   %rax,%rax
    239e:	74 08                	je     23a8 <register_tm_clones+0x38>
    23a0:	ff e0                	jmp    *%rax
    23a2:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)
    23a8:	c3                   	ret
    23a9:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)

00000000000023b0 <__do_global_dtors_aux>:
    23b0:	f3 0f 1e fa          	endbr64
    23b4:	80 3d f5 17 01 00 00 	cmpb   $0x0,0x117f5(%rip)        # 13bb0 <completed.0>
    23bb:	75 2b                	jne    23e8 <__do_global_dtors_aux+0x38>
    23bd:	55                   	push   %rbp
    23be:	48 83 3d 12 fc 00 00 	cmpq   $0x0,0xfc12(%rip)        # 11fd8 <__cxa_finalize@GLIBC_2.2.5>
    23c5:	00 
    23c6:	48 89 e5             	mov    %rsp,%rbp
    23c9:	74 0c                	je     23d7 <__do_global_dtors_aux+0x27>
    23cb:	48 8b 3d 9e fd 00 00 	mov    0xfd9e(%rip),%rdi        # 12170 <__dso_handle>
    23d2:	e8 29 ff ff ff       	call   2300 <__cxa_finalize@plt>
    23d7:	e8 64 ff ff ff       	call   2340 <deregister_tm_clones>
    23dc:	c6 05 cd 17 01 00 01 	movb   $0x1,0x117cd(%rip)        # 13bb0 <completed.0>
    23e3:	5d                   	pop    %rbp
    23e4:	c3                   	ret
    23e5:	0f 1f 00             	nopl   (%rax)
    23e8:	c3                   	ret
    23e9:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)

00000000000023f0 <frame_dummy>:
    23f0:	f3 0f 1e fa          	endbr64
    23f4:	e9 77 ff ff ff       	jmp    2370 <register_tm_clones>
    23f9:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)

0000000000002400 <main>:
    2400:	41 56                	push   %r14
    2402:	53                   	push   %rbx
    2403:	48 83 ec 58          	sub    $0x58,%rsp
    2407:	48 8d 05 a2 ef 00 00 	lea    0xefa2(%rip),%rax        # 113b0 <fwp_fn_table>
    240e:	48 89 05 ab 17 01 00 	mov    %rax,0x117ab(%rip)        # 13bc0 <fwp_fns>
    2415:	4c 8b 35 a4 fb 00 00 	mov    0xfba4(%rip),%r14        # 11fc0 <stdout@GLIBC_2.2.5>
    241c:	49 8b 06             	mov    (%r14),%rax
    241f:	48 89 05 a2 17 01 00 	mov    %rax,0x117a2(%rip)        # 13bc8 <fwp_prog_out>
    2426:	48 89 35 a3 17 01 00 	mov    %rsi,0x117a3(%rip)        # 13bd0 <fwp_argv>
    242d:	48 8d 35 a4 17 01 00 	lea    0x117a4(%rip),%rsi        # 13bd8 <fwp_start_time>
    2434:	bf 01 00 00 00       	mov    $0x1,%edi
    2439:	e8 72 fc ff ff       	call   20b0 <clock_gettime@plt>
    243e:	48 8d 3d c6 d2 00 00 	lea    0xd2c6(%rip),%rdi        # f70b <fwp_segv.msg+0x4cb>
    2445:	e8 e6 fb ff ff       	call   2030 <getenv@plt>
    244a:	48 85 c0             	test   %rax,%rax
    244d:	74 28                	je     2477 <main+0x77>
    244f:	48 89 c3             	mov    %rax,%rbx
    2452:	80 38 00             	cmpb   $0x0,(%rax)
    2455:	74 20                	je     2477 <main+0x77>
    2457:	48 8d 74 24 08       	lea    0x8(%rsp),%rsi
    245c:	48 89 df             	mov    %rbx,%rdi
    245f:	ba 0a 00 00 00       	mov    $0xa,%edx
    2464:	e8 07 fd ff ff       	call   2170 <strtoull@plt>
    2469:	48 8b 44 24 08       	mov    0x8(%rsp),%rax
    246e:	80 38 00             	cmpb   $0x0,(%rax)
    2471:	0f 84 b5 00 00 00    	je     252c <main+0x12c>
    2477:	48 8d 74 24 20       	lea    0x20(%rsp),%rsi
    247c:	31 ff                	xor    %edi,%edi
    247e:	e8 2d fc ff ff       	call   20b0 <clock_gettime@plt>
    2483:	49 8b 3e             	mov    (%r14),%rdi
    2486:	b9 00 00 01 00       	mov    $0x10000,%ecx
    248b:	31 f6                	xor    %esi,%esi
    248d:	31 d2                	xor    %edx,%edx
    248f:	e8 8c fd ff ff       	call   2220 <setvbuf@plt>
    2494:	be 01 00 00 00       	mov    $0x1,%esi
    2499:	bf 0d 00 00 00       	mov    $0xd,%edi
    249e:	e8 ed fc ff ff       	call   2190 <signal@plt>
    24a3:	48 8d 5c 24 20       	lea    0x20(%rsp),%rbx
    24a8:	48 89 df             	mov    %rbx,%rdi
    24ab:	e8 a0 fc ff ff       	call   2150 <pthread_attr_init@plt>
    24b0:	48 8b 35 c1 fc 00 00 	mov    0xfcc1(%rip),%rsi        # 12178 <fwp_main_stack>
    24b7:	48 89 df             	mov    %rbx,%rdi
    24ba:	e8 31 fe ff ff       	call   22f0 <pthread_attr_setstacksize@plt>
    24bf:	48 8d 15 8a 00 00 00 	lea    0x8a(%rip),%rdx        # 2550 <fwp_main_thread>
    24c6:	48 8d 7c 24 18       	lea    0x18(%rsp),%rdi
    24cb:	48 89 de             	mov    %rbx,%rsi
    24ce:	31 c9                	xor    %ecx,%ecx
    24d0:	e8 5b fd ff ff       	call   2230 <pthread_create@plt>
    24d5:	85 c0                	test   %eax,%eax
    24d7:	74 35                	je     250e <main+0x10e>
    24d9:	48 8d 74 24 08       	lea    0x8(%rsp),%rsi
    24de:	bf 03 00 00 00       	mov    $0x3,%edi
    24e3:	e8 c8 fd ff ff       	call   22b0 <getrlimit@plt>
    24e8:	48 8b 4c 24 08       	mov    0x8(%rsp),%rcx
    24ed:	48 83 f9 ff          	cmp    $0xffffffffffffffff,%rcx
    24f1:	ba 00 00 80 00       	mov    $0x800000,%edx
    24f6:	48 0f 44 ca          	cmove  %rdx,%rcx
    24fa:	85 c0                	test   %eax,%eax
    24fc:	48 0f 45 ca          	cmovne %rdx,%rcx
    2500:	48 89 0d 71 fc 00 00 	mov    %rcx,0xfc71(%rip)        # 12178 <fwp_main_stack>
    2507:	e8 44 00 00 00       	call   2550 <fwp_main_thread>
    250c:	eb 0c                	jmp    251a <main+0x11a>
    250e:	48 8b 7c 24 18       	mov    0x18(%rsp),%rdi
    2513:	31 f6                	xor    %esi,%esi
    2515:	e8 a6 fd ff ff       	call   22c0 <pthread_join@plt>
    251a:	49 8b 3e             	mov    (%r14),%rdi
    251d:	e8 de fc ff ff       	call   2200 <fflush@plt>
    2522:	31 c0                	xor    %eax,%eax
    2524:	48 83 c4 58          	add    $0x58,%rsp
    2528:	5b                   	pop    %rbx
    2529:	41 5e                	pop    %r14
    252b:	c3                   	ret
    252c:	0f b6 03             	movzbl (%rbx),%eax
    252f:	83 f8 2d             	cmp    $0x2d,%eax
    2532:	0f 84 3f ff ff ff    	je     2477 <main+0x77>
    2538:	83 f8 2b             	cmp    $0x2b,%eax
    253b:	0f 84 36 ff ff ff    	je     2477 <main+0x77>
    2541:	e9 3d ff ff ff       	jmp    2483 <main+0x83>
    2546:	66 2e 0f 1f 84 00 00 	cs nopw 0x0(%rax,%rax,1)
    254d:	00 00 00 

0000000000002550 <fwp_main_thread>:
    2550:	55                   	push   %rbp
    2551:	48 89 e5             	mov    %rsp,%rbp
    2554:	41 57                	push   %r15
    2556:	41 56                	push   %r14
    2558:	41 55                	push   %r13
    255a:	41 54                	push   %r12
    255c:	53                   	push   %rbx
    255d:	48 81 ec d8 01 00 00 	sub    $0x1d8,%rsp
    2564:	83 3d 01 0c 01 00 00 	cmpl   $0x0,0x10c01(%rip)        # 1316c <fwp_gc+0xfec>
    256b:	75 05                	jne    2572 <fwp_main_thread+0x22>
    256d:	e8 9e 43 00 00       	call   6910 <fwp_gc_init>
    2572:	48 89 2d 8f 0c 01 00 	mov    %rbp,0x10c8f(%rip)        # 13208 <fwp_gc+0x1088>
    2579:	48 8d 3d c0 b7 00 00 	lea    0xb7c0(%rip),%rdi        # dd40 <fwp_gc_find_data>
    2580:	31 f6                	xor    %esi,%esi
    2582:	e8 b9 fa ff ff       	call   2040 <dl_iterate_phdr@plt>
    2587:	83 3d e2 0b 01 00 00 	cmpl   $0x0,0x10be2(%rip)        # 13170 <fwp_gc+0xff0>
    258e:	0f 95 c1             	setne  %cl
    2591:	83 3d 78 0d 01 00 00 	cmpl   $0x0,0x10d78(%rip)        # 13310 <fwp_gc+0x1190>
    2598:	0f 9f c0             	setg   %al
    259b:	20 c8                	and    %cl,%al
    259d:	0f b6 c8             	movzbl %al,%ecx
    25a0:	89 0d ce 0b 01 00    	mov    %ecx,0x10bce(%rip)        # 13174 <fwp_gc+0xff4>
    25a6:	83 3d cf 0b 01 00 00 	cmpl   $0x0,0x10bcf(%rip)        # 1317c <fwp_gc+0xffc>
    25ad:	74 16                	je     25c5 <fwp_main_thread+0x75>
    25af:	48 8d 3d 6a b8 00 00 	lea    0xb86a(%rip),%rdi        # de20 <fwp_gc_report>
    25b6:	e8 65 be 00 00       	call   e420 <atexit>
    25bb:	83 3d b2 0b 01 00 00 	cmpl   $0x0,0x10bb2(%rip)        # 13174 <fwp_gc+0xff4>
    25c2:	0f 95 c0             	setne  %al
    25c5:	84 c0                	test   %al,%al
    25c7:	74 43                	je     260c <fwp_main_thread+0xbc>
    25c9:	48 83 3d cf 0b 01 00 	cmpq   $0x0,0x10bcf(%rip)        # 131a0 <fwp_gc+0x1020>
    25d0:	00 
    25d1:	74 39                	je     260c <fwp_main_thread+0xbc>
    25d3:	48 8b 05 b6 0d 01 00 	mov    0x10db6(%rip),%rax        # 13390 <fwp_gc+0x1210>
    25da:	48 2b 05 9f fb 00 00 	sub    0xfb9f(%rip),%rax        # 12180 <fwp_gc>
    25e1:	f2 48 0f 2a c0       	cvtsi2sd %rax,%xmm0
    25e6:	f2 0f 58 05 7a 0d 01 	addsd  0x10d7a(%rip),%xmm0        # 13368 <fwp_gc+0x11e8>
    25ed:	00 
    25ee:	f2 0f 11 05 72 0d 01 	movsd  %xmm0,0x10d72(%rip)        # 13368 <fwp_gc+0x11e8>
    25f5:	00 
    25f6:	48 c7 05 8f 0d 01 00 	movq   $0x0,0x10d8f(%rip)        # 13390 <fwp_gc+0x1210>
    25fd:	00 00 00 00 
    2601:	48 c7 05 74 fb 00 00 	movq   $0x0,0xfb74(%rip)        # 12180 <fwp_gc>
    2608:	00 00 00 00 
    260c:	48 8b 05 65 fb 00 00 	mov    0xfb65(%rip),%rax        # 12178 <fwp_main_stack>
    2613:	48 8d 4d a0          	lea    -0x60(%rbp),%rcx
    2617:	48 89 0d da 15 01 00 	mov    %rcx,0x115da(%rip)        # 13bf8 <fwp_main_stack_top>
    261e:	48 89 05 db 15 01 00 	mov    %rax,0x115db(%rip)        # 13c00 <fwp_main_stack_size>
    2625:	48 8d 05 e4 15 01 00 	lea    0x115e4(%rip),%rax        # 13c10 <fwp_stack_guard_init.alt>
    262c:	48 89 45 b8          	mov    %rax,-0x48(%rbp)
    2630:	48 c7 45 c8 00 00 01 	movq   $0x10000,-0x38(%rbp)
    2637:	00 
    2638:	c7 45 c0 00 00 00 00 	movl   $0x0,-0x40(%rbp)
    263f:	48 8d 7d b8          	lea    -0x48(%rbp),%rdi
    2643:	31 f6                	xor    %esi,%esi
    2645:	e8 86 fc ff ff       	call   22d0 <sigaltstack@plt>
    264a:	85 c0                	test   %eax,%eax
    264c:	0f 85 95 00 00 00    	jne    26e7 <fwp_main_thread+0x197>
    2652:	48 8d bd 08 fe ff ff 	lea    -0x1f8(%rbp),%rdi
    2659:	66 0f 57 c0          	xorpd  %xmm0,%xmm0
    265d:	66 0f 11 85 88 fe ff 	movupd %xmm0,-0x178(%rbp)
    2664:	ff 
    2665:	66 0f 11 85 78 fe ff 	movupd %xmm0,-0x188(%rbp)
    266c:	ff 
    266d:	66 0f 11 85 68 fe ff 	movupd %xmm0,-0x198(%rbp)
    2674:	ff 
    2675:	66 0f 11 85 58 fe ff 	movupd %xmm0,-0x1a8(%rbp)
    267c:	ff 
    267d:	66 0f 11 85 48 fe ff 	movupd %xmm0,-0x1b8(%rbp)
    2684:	ff 
    2685:	66 0f 11 85 38 fe ff 	movupd %xmm0,-0x1c8(%rbp)
    268c:	ff 
    268d:	66 0f 11 85 28 fe ff 	movupd %xmm0,-0x1d8(%rbp)
    2694:	ff 
    2695:	66 0f 11 85 18 fe ff 	movupd %xmm0,-0x1e8(%rbp)
    269c:	ff 
    269d:	66 0f 11 85 08 fe ff 	movupd %xmm0,-0x1f8(%rbp)
    26a4:	ff 
    26a5:	48 8d 05 c4 b9 00 00 	lea    0xb9c4(%rip),%rax        # e070 <fwp_segv>
    26ac:	48 89 85 00 fe ff ff 	mov    %rax,-0x200(%rbp)
    26b3:	c7 85 88 fe ff ff 04 	movl   $0x8000004,-0x178(%rbp)
    26ba:	00 00 08 
    26bd:	e8 fe fa ff ff       	call   21c0 <sigemptyset@plt>
    26c2:	48 8d 9d 00 fe ff ff 	lea    -0x200(%rbp),%rbx
    26c9:	bf 0b 00 00 00       	mov    $0xb,%edi
    26ce:	48 89 de             	mov    %rbx,%rsi
    26d1:	31 d2                	xor    %edx,%edx
    26d3:	e8 b8 f9 ff ff       	call   2090 <sigaction@plt>
    26d8:	bf 07 00 00 00       	mov    $0x7,%edi
    26dd:	48 89 de             	mov    %rbx,%rsi
    26e0:	31 d2                	xor    %edx,%edx
    26e2:	e8 a9 f9 ff ff       	call   2090 <sigaction@plt>
    26e7:	48 8b 15 92 fa 00 00 	mov    0xfa92(%rip),%rdx        # 12180 <fwp_gc>
    26ee:	80 3d 1b 15 02 00 00 	cmpb   $0x0,0x2151b(%rip)        # 23c10 <caf0.st>
    26f5:	48 89 d0             	mov    %rdx,%rax
    26f8:	0f 85 7b 19 00 00    	jne    4079 <fwp_main_thread+0x1b29>
    26fe:	48 89 55 b0          	mov    %rdx,-0x50(%rbp)
    2702:	48 b8 00 00 00 00 00 	movabs $0xc000000000000000,%rax
    2709:	00 00 c0 
    270c:	48 89 45 b8          	mov    %rax,-0x48(%rbp)
    2710:	48 c7 45 c0 00 00 00 	movq   $0x0,-0x40(%rbp)
    2717:	00 
    2718:	48 8d 55 b8          	lea    -0x48(%rbp),%rdx
    271c:	bf 01 00 00 00       	mov    $0x1,%edi
    2721:	be 02 00 00 00       	mov    $0x2,%esi
    2726:	e8 05 77 00 00       	call   9e30 <fwp_data>
    272b:	48 89 c1             	mov    %rax,%rcx
    272e:	48 2b 0d 7b 0a 01 00 	sub    0x10a7b(%rip),%rcx        # 131b0 <fwp_gc+0x1030>
    2735:	48 8b 15 9c 0a 01 00 	mov    0x10a9c(%rip),%rdx        # 131d8 <fwp_gc+0x1058>
    273c:	48 c1 e2 10          	shl    $0x10,%rdx
    2740:	48 39 d1             	cmp    %rdx,%rcx
    2743:	73 76                	jae    27bb <fwp_main_thread+0x26b>
    2745:	48 8b 15 ac 0a 01 00 	mov    0x10aac(%rip),%rdx        # 131f8 <fwp_gc+0x1078>
    274c:	48 89 ce             	mov    %rcx,%rsi
    274f:	48 c1 ee 10          	shr    $0x10,%rsi
    2753:	48 69 f6 28 12 00 00 	imul   $0x1228,%rsi,%rsi
    275a:	0f b6 3c 32          	movzbl (%rdx,%rsi,1),%edi
    275e:	48 81 e1 ff ff 00 00 	and    $0xffff,%rcx
    2765:	75 1d                	jne    2784 <fwp_main_thread+0x234>
    2767:	40 80 ff 02          	cmp    $0x2,%dil
    276b:	75 17                	jne    2784 <fwp_main_thread+0x234>
    276d:	4c 8d 34 32          	lea    (%rdx,%rsi,1),%r14
    2771:	49 81 c6 28 02 00 00 	add    $0x228,%r14
    2778:	41 80 3e ff          	cmpb   $0xff,(%r14)
    277c:	74 2d                	je     27ab <fwp_main_thread+0x25b>
    277e:	41 c6 06 01          	movb   $0x1,(%r14)
    2782:	eb 37                	jmp    27bb <fwp_main_thread+0x26b>
    2784:	40 80 ff 01          	cmp    $0x1,%dil
    2788:	75 31                	jne    27bb <fwp_main_thread+0x26b>
    278a:	48 8d 3c 32          	lea    (%rdx,%rsi,1),%rdi
    278e:	8b 54 32 20          	mov    0x20(%rdx,%rsi,1),%edx
    2792:	48 0f af ca          	imul   %rdx,%rcx
    2796:	48 c1 e9 20          	shr    $0x20,%rcx
    279a:	4c 8d 34 39          	lea    (%rcx,%rdi,1),%r14
    279e:	49 81 c6 28 02 00 00 	add    $0x228,%r14
    27a5:	41 80 3e ff          	cmpb   $0xff,(%r14)
    27a9:	75 d3                	jne    277e <fwp_main_thread+0x22e>
    27ab:	4c 89 f7             	mov    %r14,%rdi
    27ae:	48 89 c3             	mov    %rax,%rbx
    27b1:	e8 aa 3b 00 00       	call   6360 <fwp_rc_forget_slot>
    27b6:	48 89 d8             	mov    %rbx,%rax
    27b9:	eb c3                	jmp    277e <fwp_main_thread+0x22e>
    27bb:	48 b9 00 00 00 00 00 	movabs $0x3fd0000000000000,%rcx
    27c2:	00 d0 3f 
    27c5:	48 89 4d a0          	mov    %rcx,-0x60(%rbp)
    27c9:	48 89 45 a8          	mov    %rax,-0x58(%rbp)
    27cd:	48 8d 55 a0          	lea    -0x60(%rbp),%rdx
    27d1:	bf 01 00 00 00       	mov    $0x1,%edi
    27d6:	be 02 00 00 00       	mov    $0x2,%esi
    27db:	e8 50 76 00 00       	call   9e30 <fwp_data>
    27e0:	48 89 c1             	mov    %rax,%rcx
    27e3:	48 2b 0d c6 09 01 00 	sub    0x109c6(%rip),%rcx        # 131b0 <fwp_gc+0x1030>
    27ea:	48 8b 15 e7 09 01 00 	mov    0x109e7(%rip),%rdx        # 131d8 <fwp_gc+0x1058>
    27f1:	48 c1 e2 10          	shl    $0x10,%rdx
    27f5:	48 39 d1             	cmp    %rdx,%rcx
    27f8:	73 76                	jae    2870 <fwp_main_thread+0x320>
    27fa:	48 8b 15 f7 09 01 00 	mov    0x109f7(%rip),%rdx        # 131f8 <fwp_gc+0x1078>
    2801:	48 89 ce             	mov    %rcx,%rsi
    2804:	48 c1 ee 10          	shr    $0x10,%rsi
    2808:	48 69 f6 28 12 00 00 	imul   $0x1228,%rsi,%rsi
    280f:	0f b6 3c 32          	movzbl (%rdx,%rsi,1),%edi
    2813:	48 81 e1 ff ff 00 00 	and    $0xffff,%rcx
    281a:	75 1d                	jne    2839 <fwp_main_thread+0x2e9>
    281c:	40 80 ff 02          	cmp    $0x2,%dil
    2820:	75 17                	jne    2839 <fwp_main_thread+0x2e9>
    2822:	4c 8d 34 32          	lea    (%rdx,%rsi,1),%r14
    2826:	49 81 c6 28 02 00 00 	add    $0x228,%r14
    282d:	41 80 3e ff          	cmpb   $0xff,(%r14)
    2831:	74 2d                	je     2860 <fwp_main_thread+0x310>
    2833:	41 c6 06 01          	movb   $0x1,(%r14)
    2837:	eb 37                	jmp    2870 <fwp_main_thread+0x320>
    2839:	40 80 ff 01          	cmp    $0x1,%dil
    283d:	75 31                	jne    2870 <fwp_main_thread+0x320>
    283f:	48 8d 3c 32          	lea    (%rdx,%rsi,1),%rdi
    2843:	8b 54 32 20          	mov    0x20(%rdx,%rsi,1),%edx
    2847:	48 0f af ca          	imul   %rdx,%rcx
    284b:	48 c1 e9 20          	shr    $0x20,%rcx
    284f:	4c 8d 34 39          	lea    (%rcx,%rdi,1),%r14
    2853:	49 81 c6 28 02 00 00 	add    $0x228,%r14
    285a:	41 80 3e ff          	cmpb   $0xff,(%r14)
    285e:	75 d3                	jne    2833 <fwp_main_thread+0x2e3>
    2860:	4c 89 f7             	mov    %r14,%rdi
    2863:	48 89 c3             	mov    %rax,%rbx
    2866:	e8 f5 3a 00 00       	call   6360 <fwp_rc_forget_slot>
    286b:	48 89 d8             	mov    %rbx,%rax
    286e:	eb c3                	jmp    2833 <fwp_main_thread+0x2e3>
    2870:	48 b9 ff ff ff ff ff 	movabs $0x7fffffffffffffff,%rcx
    2877:	ff ff 7f 
    287a:	4c 8d 69 01          	lea    0x1(%rcx),%r13
    287e:	4c 89 ad a0 fe ff ff 	mov    %r13,-0x160(%rbp)
    2885:	48 89 85 a8 fe ff ff 	mov    %rax,-0x158(%rbp)
    288c:	48 8d 95 a0 fe ff ff 	lea    -0x160(%rbp),%rdx
    2893:	bf 01 00 00 00       	mov    $0x1,%edi
    2898:	be 02 00 00 00       	mov    $0x2,%esi
    289d:	e8 8e 75 00 00       	call   9e30 <fwp_data>
    28a2:	48 89 c1             	mov    %rax,%rcx
    28a5:	48 2b 0d 04 09 01 00 	sub    0x10904(%rip),%rcx        # 131b0 <fwp_gc+0x1030>
    28ac:	48 8b 15 25 09 01 00 	mov    0x10925(%rip),%rdx        # 131d8 <fwp_gc+0x1058>
    28b3:	48 c1 e2 10          	shl    $0x10,%rdx
    28b7:	48 39 d1             	cmp    %rdx,%rcx
    28ba:	73 76                	jae    2932 <fwp_main_thread+0x3e2>
    28bc:	48 8b 15 35 09 01 00 	mov    0x10935(%rip),%rdx        # 131f8 <fwp_gc+0x1078>
    28c3:	48 89 ce             	mov    %rcx,%rsi
    28c6:	48 c1 ee 10          	shr    $0x10,%rsi
    28ca:	48 69 f6 28 12 00 00 	imul   $0x1228,%rsi,%rsi
    28d1:	0f b6 3c 32          	movzbl (%rdx,%rsi,1),%edi
    28d5:	48 81 e1 ff ff 00 00 	and    $0xffff,%rcx
    28dc:	75 1d                	jne    28fb <fwp_main_thread+0x3ab>
    28de:	40 80 ff 02          	cmp    $0x2,%dil
    28e2:	75 17                	jne    28fb <fwp_main_thread+0x3ab>
    28e4:	4c 8d 34 32          	lea    (%rdx,%rsi,1),%r14
    28e8:	49 81 c6 28 02 00 00 	add    $0x228,%r14
    28ef:	41 80 3e ff          	cmpb   $0xff,(%r14)
    28f3:	74 2d                	je     2922 <fwp_main_thread+0x3d2>
    28f5:	41 c6 06 01          	movb   $0x1,(%r14)
    28f9:	eb 37                	jmp    2932 <fwp_main_thread+0x3e2>
    28fb:	40 80 ff 01          	cmp    $0x1,%dil
    28ff:	75 31                	jne    2932 <fwp_main_thread+0x3e2>
    2901:	48 8d 3c 32          	lea    (%rdx,%rsi,1),%rdi
    2905:	8b 54 32 20          	mov    0x20(%rdx,%rsi,1),%edx
    2909:	48 0f af ca          	imul   %rdx,%rcx
    290d:	48 c1 e9 20          	shr    $0x20,%rcx
    2911:	4c 8d 34 39          	lea    (%rcx,%rdi,1),%r14
    2915:	49 81 c6 28 02 00 00 	add    $0x228,%r14
    291c:	41 80 3e ff          	cmpb   $0xff,(%r14)
    2920:	75 d3                	jne    28f5 <fwp_main_thread+0x3a5>
    2922:	4c 89 f7             	mov    %r14,%rdi
    2925:	48 89 c3             	mov    %rax,%rbx
    2928:	e8 33 3a 00 00       	call   6360 <fwp_rc_forget_slot>
    292d:	48 89 d8             	mov    %rbx,%rax
    2930:	eb c3                	jmp    28f5 <fwp_main_thread+0x3a5>
    2932:	48 b9 00 00 00 00 00 	movabs $0x3ff8000000000000,%rcx
    2939:	00 f8 3f 
    293c:	48 89 8d b0 fe ff ff 	mov    %rcx,-0x150(%rbp)
    2943:	48 89 85 b8 fe ff ff 	mov    %rax,-0x148(%rbp)
    294a:	48 8d 95 b0 fe ff ff 	lea    -0x150(%rbp),%rdx
    2951:	bf 01 00 00 00       	mov    $0x1,%edi
    2956:	be 02 00 00 00       	mov    $0x2,%esi
    295b:	e8 d0 74 00 00       	call   9e30 <fwp_data>
    2960:	49 89 c6             	mov    %rax,%r14
    2963:	48 2b 05 46 08 01 00 	sub    0x10846(%rip),%rax        # 131b0 <fwp_gc+0x1030>
    296a:	48 8b 0d 67 08 01 00 	mov    0x10867(%rip),%rcx        # 131d8 <fwp_gc+0x1058>
    2971:	48 c1 e1 10          	shl    $0x10,%rcx
    2975:	48 39 c8             	cmp    %rcx,%rax
    2978:	73 6f                	jae    29e9 <fwp_main_thread+0x499>
    297a:	48 8b 0d 77 08 01 00 	mov    0x10877(%rip),%rcx        # 131f8 <fwp_gc+0x1078>
    2981:	48 89 c2             	mov    %rax,%rdx
    2984:	48 c1 ea 10          	shr    $0x10,%rdx
    2988:	48 69 d2 28 12 00 00 	imul   $0x1228,%rdx,%rdx
    298f:	0f b6 34 11          	movzbl (%rcx,%rdx,1),%esi
    2993:	48 25 ff ff 00 00    	and    $0xffff,%rax
    2999:	75 1d                	jne    29b8 <fwp_main_thread+0x468>
    299b:	40 80 fe 02          	cmp    $0x2,%sil
    299f:	75 17                	jne    29b8 <fwp_main_thread+0x468>
    29a1:	4c 8d 3c 11          	lea    (%rcx,%rdx,1),%r15
    29a5:	49 81 c7 28 02 00 00 	add    $0x228,%r15
    29ac:	41 80 3f ff          	cmpb   $0xff,(%r15)
    29b0:	74 2d                	je     29df <fwp_main_thread+0x48f>
    29b2:	41 c6 07 01          	movb   $0x1,(%r15)
    29b6:	eb 31                	jmp    29e9 <fwp_main_thread+0x499>
    29b8:	40 80 fe 01          	cmp    $0x1,%sil
    29bc:	75 2b                	jne    29e9 <fwp_main_thread+0x499>
    29be:	48 8d 34 11          	lea    (%rcx,%rdx,1),%rsi
    29c2:	8b 4c 11 20          	mov    0x20(%rcx,%rdx,1),%ecx
    29c6:	48 0f af c1          	imul   %rcx,%rax
    29ca:	48 c1 e8 20          	shr    $0x20,%rax
    29ce:	4c 8d 3c 30          	lea    (%rax,%rsi,1),%r15
    29d2:	49 81 c7 28 02 00 00 	add    $0x228,%r15
    29d9:	41 80 3f ff          	cmpb   $0xff,(%r15)
    29dd:	75 d3                	jne    29b2 <fwp_main_thread+0x462>
    29df:	4c 89 ff             	mov    %r15,%rdi
    29e2:	e8 79 39 00 00       	call   6360 <fwp_rc_forget_slot>
    29e7:	eb c9                	jmp    29b2 <fwp_main_thread+0x462>
    29e9:	48 8d 35 60 f2 00 00 	lea    0xf260(%rip),%rsi        # 11c50 <d0>
    29f0:	4c 89 f7             	mov    %r14,%rdi
    29f3:	e8 18 3a 00 00       	call   6410 <fwp_p_array_from_list_typed>
    29f8:	49 89 c7             	mov    %rax,%r15
    29fb:	4c 89 f7             	mov    %r14,%rdi
    29fe:	e8 cd b6 00 00       	call   e0d0 <fwp_drop0>
    2a03:	31 db                	xor    %ebx,%ebx
    2a05:	be 04 00 00 00       	mov    $0x4,%esi
    2a0a:	31 ff                	xor    %edi,%edi
    2a0c:	4c 89 fa             	mov    %r15,%rdx
    2a0f:	e8 ec 48 00 00       	call   7300 <f12>
    2a14:	49 89 c6             	mov    %rax,%r14
    2a17:	4c 89 ff             	mov    %r15,%rdi
    2a1a:	e8 81 7a 00 00       	call   a4a0 <fwp_drop1>
    2a1f:	66 0f 57 c0          	xorpd  %xmm0,%xmm0
    2a23:	f2 0f 11 45 d0       	movsd  %xmm0,-0x30(%rbp)
    2a28:	45 31 ff             	xor    %r15d,%r15d
    2a2b:	45 31 e4             	xor    %r12d,%r12d
    2a2e:	31 ff                	xor    %edi,%edi
    2a30:	48 85 db             	test   %rbx,%rbx
    2a33:	78 3b                	js     2a70 <fwp_main_thread+0x520>
    2a35:	66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
    2a3c:	00 00 00 00 
    2a40:	49 8b 06             	mov    (%r14),%rax
    2a43:	48 89 c1             	mov    %rax,%rcx
    2a46:	48 ba ff ff ff ff ff 	movabs $0x7fffffffffffffff,%rdx
    2a4d:	ff ff 7f 
    2a50:	48 21 d1             	and    %rdx,%rcx
    2a53:	48 39 cb             	cmp    %rcx,%rbx
    2a56:	73 18                	jae    2a70 <fwp_main_thread+0x520>
    2a58:	48 85 c0             	test   %rax,%rax
    2a5b:	78 22                	js     2a7f <fwp_main_thread+0x52f>
    2a5d:	49 8d 46 08          	lea    0x8(%r14),%rax
    2a61:	eb 20                	jmp    2a83 <fwp_main_thread+0x533>
    2a63:	66 66 66 66 2e 0f 1f 	data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    2a6a:	84 00 00 00 00 00 
    2a70:	4c 89 f7             	mov    %r14,%rdi
    2a73:	e8 28 7a 00 00       	call   a4a0 <fwp_drop1>
    2a78:	31 c0                	xor    %eax,%eax
    2a7a:	4c 89 ef             	mov    %r13,%rdi
    2a7d:	eb 32                	jmp    2ab1 <fwp_main_thread+0x561>
    2a7f:	49 8b 46 10          	mov    0x10(%r14),%rax
    2a83:	f2 0f 10 04 d8       	movsd  (%rax,%rbx,8),%xmm0
    2a88:	48 ff c3             	inc    %rbx
    2a8b:	f2 0f 59 05 7d c5 00 	mulsd  0xc57d(%rip),%xmm0        # f010 <_IO_stdin_used+0x10>
    2a92:	00 
    2a93:	f2 0f 58 05 7d c5 00 	addsd  0xc57d(%rip),%xmm0        # f018 <_IO_stdin_used+0x18>
    2a9a:	00 
    2a9b:	66 49 0f 6e cd       	movq   %r13,%xmm1
    2aa0:	f2 0f 58 c8          	addsd  %xmm0,%xmm1
    2aa4:	f2 0f 11 4d d0       	movsd  %xmm1,-0x30(%rbp)
    2aa9:	b0 01                	mov    $0x1,%al
    2aab:	4d 89 f7             	mov    %r14,%r15
    2aae:	4d 89 f4             	mov    %r14,%r12
    2ab1:	84 c0                	test   %al,%al
    2ab3:	74 18                	je     2acd <fwp_main_thread+0x57d>
    2ab5:	f3 0f 7e 45 d0       	movq   -0x30(%rbp),%xmm0
    2aba:	66 49 0f 7e c5       	movq   %xmm0,%r13
    2abf:	4d 89 fe             	mov    %r15,%r14
    2ac2:	48 85 db             	test   %rbx,%rbx
    2ac5:	0f 89 75 ff ff ff    	jns    2a40 <fwp_main_thread+0x4f0>
    2acb:	eb a3                	jmp    2a70 <fwp_main_thread+0x520>
    2acd:	48 8d 35 7c f1 00 00 	lea    0xf17c(%rip),%rsi        # 11c50 <d0>
    2ad4:	e8 c7 4c 00 00       	call   77a0 <fwp_show>
    2ad9:	49 89 c6             	mov    %rax,%r14
    2adc:	48 2b 05 cd 06 01 00 	sub    0x106cd(%rip),%rax        # 131b0 <fwp_gc+0x1030>
    2ae3:	48 8b 0d ee 06 01 00 	mov    0x106ee(%rip),%rcx        # 131d8 <fwp_gc+0x1058>
    2aea:	48 c1 e1 10          	shl    $0x10,%rcx
    2aee:	48 39 c8             	cmp    %rcx,%rax
    2af1:	73 6f                	jae    2b62 <fwp_main_thread+0x612>
    2af3:	48 8b 0d fe 06 01 00 	mov    0x106fe(%rip),%rcx        # 131f8 <fwp_gc+0x1078>
    2afa:	48 89 c2             	mov    %rax,%rdx
    2afd:	48 c1 ea 10          	shr    $0x10,%rdx
    2b01:	48 69 d2 28 12 00 00 	imul   $0x1228,%rdx,%rdx
    2b08:	0f b6 34 11          	movzbl (%rcx,%rdx,1),%esi
    2b0c:	48 25 ff ff 00 00    	and    $0xffff,%rax
    2b12:	75 1d                	jne    2b31 <fwp_main_thread+0x5e1>
    2b14:	40 80 fe 02          	cmp    $0x2,%sil
    2b18:	75 17                	jne    2b31 <fwp_main_thread+0x5e1>
    2b1a:	4c 8d 3c 11          	lea    (%rcx,%rdx,1),%r15
    2b1e:	49 81 c7 28 02 00 00 	add    $0x228,%r15
    2b25:	41 80 3f ff          	cmpb   $0xff,(%r15)
    2b29:	74 2d                	je     2b58 <fwp_main_thread+0x608>
    2b2b:	41 c6 07 01          	movb   $0x1,(%r15)
    2b2f:	eb 31                	jmp    2b62 <fwp_main_thread+0x612>
    2b31:	40 80 fe 01          	cmp    $0x1,%sil
    2b35:	75 2b                	jne    2b62 <fwp_main_thread+0x612>
    2b37:	48 8d 34 11          	lea    (%rcx,%rdx,1),%rsi
    2b3b:	8b 4c 11 20          	mov    0x20(%rcx,%rdx,1),%ecx
    2b3f:	48 0f af c1          	imul   %rcx,%rax
    2b43:	48 c1 e8 20          	shr    $0x20,%rax
    2b47:	4c 8d 3c 30          	lea    (%rax,%rsi,1),%r15
    2b4b:	49 81 c7 28 02 00 00 	add    $0x228,%r15
    2b52:	41 80 3f ff          	cmpb   $0xff,(%r15)
    2b56:	75 d3                	jne    2b2b <fwp_main_thread+0x5db>
    2b58:	4c 89 ff             	mov    %r15,%rdi
    2b5b:	e8 00 38 00 00       	call   6360 <fwp_rc_forget_slot>
    2b60:	eb c9                	jmp    2b2b <fwp_main_thread+0x5db>
    2b62:	4c 89 f7             	mov    %r14,%rdi
    2b65:	48 83 c7 08          	add    $0x8,%rdi
    2b69:	49 8b 16             	mov    (%r14),%rdx
    2b6c:	48 8b 0d 55 10 01 00 	mov    0x11055(%rip),%rcx        # 13bc8 <fwp_prog_out>
    2b73:	be 01 00 00 00       	mov    $0x1,%esi
    2b78:	e8 23 f7 ff ff       	call   22a0 <fwrite@plt>
    2b7d:	48 8b 35 44 10 01 00 	mov    0x11044(%rip),%rsi        # 13bc8 <fwp_prog_out>
    2b84:	bf 0a 00 00 00       	mov    $0xa,%edi
    2b89:	e8 b2 f5 ff ff       	call   2140 <fputc@plt>
    2b8e:	4c 89 f0             	mov    %r14,%rax
    2b91:	48 2b 05 18 06 01 00 	sub    0x10618(%rip),%rax        # 131b0 <fwp_gc+0x1030>
    2b98:	48 8b 0d 39 06 01 00 	mov    0x10639(%rip),%rcx        # 131d8 <fwp_gc+0x1058>
    2b9f:	48 c1 e1 10          	shl    $0x10,%rcx
    2ba3:	48 39 c8             	cmp    %rcx,%rax
    2ba6:	73 7a                	jae    2c22 <fwp_main_thread+0x6d2>
    2ba8:	48 8b 0d 49 06 01 00 	mov    0x10649(%rip),%rcx        # 131f8 <fwp_gc+0x1078>
    2baf:	48 89 c2             	mov    %rax,%rdx
    2bb2:	48 c1 ea 10          	shr    $0x10,%rdx
    2bb6:	48 69 d2 28 12 00 00 	imul   $0x1228,%rdx,%rdx
    2bbd:	0f b6 34 11          	movzbl (%rcx,%rdx,1),%esi
    2bc1:	48 25 ff ff 00 00    	and    $0xffff,%rax
    2bc7:	75 13                	jne    2bdc <fwp_main_thread+0x68c>
    2bc9:	40 80 fe 02          	cmp    $0x2,%sil
    2bcd:	75 0d                	jne    2bdc <fwp_main_thread+0x68c>
    2bcf:	48 8d 3c 11          	lea    (%rcx,%rdx,1),%rdi
    2bd3:	48 81 c7 28 02 00 00 	add    $0x228,%rdi
    2bda:	eb 21                	jmp    2bfd <fwp_main_thread+0x6ad>
    2bdc:	40 80 fe 01          	cmp    $0x1,%sil
    2be0:	75 40                	jne    2c22 <fwp_main_thread+0x6d2>
    2be2:	48 8d 34 11          	lea    (%rcx,%rdx,1),%rsi
    2be6:	8b 4c 11 20          	mov    0x20(%rcx,%rdx,1),%ecx
    2bea:	48 0f af c1          	imul   %rcx,%rax
    2bee:	48 c1 e8 20          	shr    $0x20,%rax
    2bf2:	48 8d 3c 30          	lea    (%rax,%rsi,1),%rdi
    2bf6:	48 81 c7 28 02 00 00 	add    $0x228,%rdi
    2bfd:	0f b6 07             	movzbl (%rdi),%eax
    2c00:	85 c0                	test   %eax,%eax
    2c02:	74 1e                	je     2c22 <fwp_main_thread+0x6d2>
    2c04:	83 f8 01             	cmp    $0x1,%eax
    2c07:	75 0a                	jne    2c13 <fwp_main_thread+0x6c3>
    2c09:	4c 89 f7             	mov    %r14,%rdi
    2c0c:	e8 5f 7d 00 00       	call   a970 <fwp_rc_free_obj>
    2c11:	eb 0f                	jmp    2c22 <fwp_main_thread+0x6d2>
    2c13:	3d ff 00 00 00       	cmp    $0xff,%eax
    2c18:	0f 84 c5 14 00 00    	je     40e3 <fwp_main_thread+0x1b93>
    2c1e:	fe c8                	dec    %al
    2c20:	88 07                	mov    %al,(%rdi)
    2c22:	41 bf 00 00 00 80    	mov    $0x80000000,%r15d
    2c28:	49 8d 87 00 00 00 40 	lea    0x40000000(%r15),%rax
    2c2f:	48 89 85 c0 fe ff ff 	mov    %rax,-0x140(%rbp)
    2c36:	48 c7 85 c8 fe ff ff 	movq   $0x0,-0x138(%rbp)
    2c3d:	00 00 00 00 
    2c41:	48 8d 95 c0 fe ff ff 	lea    -0x140(%rbp),%rdx
    2c48:	bf 01 00 00 00       	mov    $0x1,%edi
    2c4d:	be 02 00 00 00       	mov    $0x2,%esi
    2c52:	e8 d9 71 00 00       	call   9e30 <fwp_data>
    2c57:	48 89 c1             	mov    %rax,%rcx
    2c5a:	48 2b 0d 4f 05 01 00 	sub    0x1054f(%rip),%rcx        # 131b0 <fwp_gc+0x1030>
    2c61:	48 8b 15 70 05 01 00 	mov    0x10570(%rip),%rdx        # 131d8 <fwp_gc+0x1058>
    2c68:	48 c1 e2 10          	shl    $0x10,%rdx
    2c6c:	48 39 d1             	cmp    %rdx,%rcx
    2c6f:	73 76                	jae    2ce7 <fwp_main_thread+0x797>
    2c71:	48 8b 15 80 05 01 00 	mov    0x10580(%rip),%rdx        # 131f8 <fwp_gc+0x1078>
    2c78:	48 89 ce             	mov    %rcx,%rsi
    2c7b:	48 c1 ee 10          	shr    $0x10,%rsi
    2c7f:	48 69 f6 28 12 00 00 	imul   $0x1228,%rsi,%rsi
    2c86:	0f b6 3c 32          	movzbl (%rdx,%rsi,1),%edi
    2c8a:	48 81 e1 ff ff 00 00 	and    $0xffff,%rcx
    2c91:	75 1d                	jne    2cb0 <fwp_main_thread+0x760>
    2c93:	40 80 ff 02          	cmp    $0x2,%dil
    2c97:	75 17                	jne    2cb0 <fwp_main_thread+0x760>
    2c99:	4c 8d 34 32          	lea    (%rdx,%rsi,1),%r14
    2c9d:	49 81 c6 28 02 00 00 	add    $0x228,%r14
    2ca4:	41 80 3e ff          	cmpb   $0xff,(%r14)
    2ca8:	74 2d                	je     2cd7 <fwp_main_thread+0x787>
    2caa:	41 c6 06 01          	movb   $0x1,(%r14)
    2cae:	eb 37                	jmp    2ce7 <fwp_main_thread+0x797>
    2cb0:	40 80 ff 01          	cmp    $0x1,%dil
    2cb4:	75 31                	jne    2ce7 <fwp_main_thread+0x797>
    2cb6:	48 8d 3c 32          	lea    (%rdx,%rsi,1),%rdi
    2cba:	8b 54 32 20          	mov    0x20(%rdx,%rsi,1),%edx
    2cbe:	48 0f af ca          	imul   %rdx,%rcx
    2cc2:	48 c1 e9 20          	shr    $0x20,%rcx
    2cc6:	4c 8d 34 39          	lea    (%rcx,%rdi,1),%r14
    2cca:	49 81 c6 28 02 00 00 	add    $0x228,%r14
    2cd1:	41 80 3e ff          	cmpb   $0xff,(%r14)
    2cd5:	75 d3                	jne    2caa <fwp_main_thread+0x75a>
    2cd7:	4c 89 f7             	mov    %r14,%rdi
    2cda:	48 89 c3             	mov    %rax,%rbx
    2cdd:	e8 7e 36 00 00       	call   6360 <fwp_rc_forget_slot>
    2ce2:	48 89 d8             	mov    %rbx,%rax
    2ce5:	eb c3                	jmp    2caa <fwp_main_thread+0x75a>
    2ce7:	48 c7 85 d0 fe ff ff 	movq   $0x3e800000,-0x130(%rbp)
    2cee:	00 00 80 3e 
    2cf2:	48 89 85 d8 fe ff ff 	mov    %rax,-0x128(%rbp)
    2cf9:	48 8d 95 d0 fe ff ff 	lea    -0x130(%rbp),%rdx
    2d00:	bf 01 00 00 00       	mov    $0x1,%edi
    2d05:	be 02 00 00 00       	mov    $0x2,%esi
    2d0a:	e8 21 71 00 00       	call   9e30 <fwp_data>
    2d0f:	48 89 c1             	mov    %rax,%rcx
    2d12:	48 2b 0d 97 04 01 00 	sub    0x10497(%rip),%rcx        # 131b0 <fwp_gc+0x1030>
    2d19:	48 8b 15 b8 04 01 00 	mov    0x104b8(%rip),%rdx        # 131d8 <fwp_gc+0x1058>
    2d20:	48 c1 e2 10          	shl    $0x10,%rdx
    2d24:	48 39 d1             	cmp    %rdx,%rcx
    2d27:	73 76                	jae    2d9f <fwp_main_thread+0x84f>
    2d29:	48 8b 15 c8 04 01 00 	mov    0x104c8(%rip),%rdx        # 131f8 <fwp_gc+0x1078>
    2d30:	48 89 ce             	mov    %rcx,%rsi
    2d33:	48 c1 ee 10          	shr    $0x10,%rsi
    2d37:	48 69 f6 28 12 00 00 	imul   $0x1228,%rsi,%rsi
    2d3e:	0f b6 3c 32          	movzbl (%rdx,%rsi,1),%edi
    2d42:	48 81 e1 ff ff 00 00 	and    $0xffff,%rcx
    2d49:	75 1d                	jne    2d68 <fwp_main_thread+0x818>
    2d4b:	40 80 ff 02          	cmp    $0x2,%dil
    2d4f:	75 17                	jne    2d68 <fwp_main_thread+0x818>
    2d51:	4c 8d 34 32          	lea    (%rdx,%rsi,1),%r14
    2d55:	49 81 c6 28 02 00 00 	add    $0x228,%r14
    2d5c:	41 80 3e ff          	cmpb   $0xff,(%r14)
    2d60:	74 2d                	je     2d8f <fwp_main_thread+0x83f>
    2d62:	41 c6 06 01          	movb   $0x1,(%r14)
    2d66:	eb 37                	jmp    2d9f <fwp_main_thread+0x84f>
    2d68:	40 80 ff 01          	cmp    $0x1,%dil
    2d6c:	75 31                	jne    2d9f <fwp_main_thread+0x84f>
    2d6e:	48 8d 3c 32          	lea    (%rdx,%rsi,1),%rdi
    2d72:	8b 54 32 20          	mov    0x20(%rdx,%rsi,1),%edx
    2d76:	48 0f af ca          	imul   %rdx,%rcx
    2d7a:	48 c1 e9 20          	shr    $0x20,%rcx
    2d7e:	4c 8d 34 39          	lea    (%rcx,%rdi,1),%r14
    2d82:	49 81 c6 28 02 00 00 	add    $0x228,%r14
    2d89:	41 80 3e ff          	cmpb   $0xff,(%r14)
    2d8d:	75 d3                	jne    2d62 <fwp_main_thread+0x812>
    2d8f:	4c 89 f7             	mov    %r14,%rdi
    2d92:	48 89 c3             	mov    %rax,%rbx
    2d95:	e8 c6 35 00 00       	call   6360 <fwp_rc_forget_slot>
    2d9a:	48 89 d8             	mov    %rbx,%rax
    2d9d:	eb c3                	jmp    2d62 <fwp_main_thread+0x812>
    2d9f:	4c 89 bd e0 fe ff ff 	mov    %r15,-0x120(%rbp)
    2da6:	48 89 85 e8 fe ff ff 	mov    %rax,-0x118(%rbp)
    2dad:	48 8d 95 e0 fe ff ff 	lea    -0x120(%rbp),%rdx
    2db4:	bf 01 00 00 00       	mov    $0x1,%edi
    2db9:	be 02 00 00 00       	mov    $0x2,%esi
    2dbe:	e8 6d 70 00 00       	call   9e30 <fwp_data>
    2dc3:	48 89 c1             	mov    %rax,%rcx
    2dc6:	48 2b 0d e3 03 01 00 	sub    0x103e3(%rip),%rcx        # 131b0 <fwp_gc+0x1030>
    2dcd:	48 8b 15 04 04 01 00 	mov    0x10404(%rip),%rdx        # 131d8 <fwp_gc+0x1058>
    2dd4:	48 c1 e2 10          	shl    $0x10,%rdx
    2dd8:	48 39 d1             	cmp    %rdx,%rcx
    2ddb:	73 76                	jae    2e53 <fwp_main_thread+0x903>
    2ddd:	48 8b 15 14 04 01 00 	mov    0x10414(%rip),%rdx        # 131f8 <fwp_gc+0x1078>
    2de4:	48 89 ce             	mov    %rcx,%rsi
    2de7:	48 c1 ee 10          	shr    $0x10,%rsi
    2deb:	48 69 f6 28 12 00 00 	imul   $0x1228,%rsi,%rsi
    2df2:	0f b6 3c 32          	movzbl (%rdx,%rsi,1),%edi
    2df6:	48 81 e1 ff ff 00 00 	and    $0xffff,%rcx
    2dfd:	75 1d                	jne    2e1c <fwp_main_thread+0x8cc>
    2dff:	40 80 ff 02          	cmp    $0x2,%dil
    2e03:	75 17                	jne    2e1c <fwp_main_thread+0x8cc>
    2e05:	4c 8d 34 32          	lea    (%rdx,%rsi,1),%r14
    2e09:	49 81 c6 28 02 00 00 	add    $0x228,%r14
    2e10:	41 80 3e ff          	cmpb   $0xff,(%r14)
    2e14:	74 2d                	je     2e43 <fwp_main_thread+0x8f3>
    2e16:	41 c6 06 01          	movb   $0x1,(%r14)
    2e1a:	eb 37                	jmp    2e53 <fwp_main_thread+0x903>
    2e1c:	40 80 ff 01          	cmp    $0x1,%dil
    2e20:	75 31                	jne    2e53 <fwp_main_thread+0x903>
    2e22:	48 8d 3c 32          	lea    (%rdx,%rsi,1),%rdi
    2e26:	8b 54 32 20          	mov    0x20(%rdx,%rsi,1),%edx
    2e2a:	48 0f af ca          	imul   %rdx,%rcx
    2e2e:	48 c1 e9 20          	shr    $0x20,%rcx
    2e32:	4c 8d 34 39          	lea    (%rcx,%rdi,1),%r14
    2e36:	49 81 c6 28 02 00 00 	add    $0x228,%r14
    2e3d:	41 80 3e ff          	cmpb   $0xff,(%r14)
    2e41:	75 d3                	jne    2e16 <fwp_main_thread+0x8c6>
    2e43:	4c 89 f7             	mov    %r14,%rdi
    2e46:	48 89 c3             	mov    %rax,%rbx
    2e49:	e8 12 35 00 00       	call   6360 <fwp_rc_forget_slot>
    2e4e:	48 89 d8             	mov    %rbx,%rax
    2e51:	eb c3                	jmp    2e16 <fwp_main_thread+0x8c6>
    2e53:	48 c7 85 f0 fe ff ff 	movq   $0x3fc00000,-0x110(%rbp)
    2e5a:	00 00 c0 3f 
    2e5e:	48 89 85 f8 fe ff ff 	mov    %rax,-0x108(%rbp)
    2e65:	48 8d 95 f0 fe ff ff 	lea    -0x110(%rbp),%rdx
    2e6c:	bf 01 00 00 00       	mov    $0x1,%edi
    2e71:	be 02 00 00 00       	mov    $0x2,%esi
    2e76:	e8 b5 6f 00 00       	call   9e30 <fwp_data>
    2e7b:	49 89 c7             	mov    %rax,%r15
    2e7e:	48 2b 05 2b 03 01 00 	sub    0x1032b(%rip),%rax        # 131b0 <fwp_gc+0x1030>
    2e85:	48 8b 0d 4c 03 01 00 	mov    0x1034c(%rip),%rcx        # 131d8 <fwp_gc+0x1058>
    2e8c:	48 c1 e1 10          	shl    $0x10,%rcx
    2e90:	48 39 c8             	cmp    %rcx,%rax
    2e93:	73 6f                	jae    2f04 <fwp_main_thread+0x9b4>
    2e95:	48 8b 0d 5c 03 01 00 	mov    0x1035c(%rip),%rcx        # 131f8 <fwp_gc+0x1078>
    2e9c:	48 89 c2             	mov    %rax,%rdx
    2e9f:	48 c1 ea 10          	shr    $0x10,%rdx
    2ea3:	48 69 d2 28 12 00 00 	imul   $0x1228,%rdx,%rdx
    2eaa:	0f b6 34 11          	movzbl (%rcx,%rdx,1),%esi
    2eae:	48 25 ff ff 00 00    	and    $0xffff,%rax
    2eb4:	75 1d                	jne    2ed3 <fwp_main_thread+0x983>
    2eb6:	40 80 fe 02          	cmp    $0x2,%sil
    2eba:	75 17                	jne    2ed3 <fwp_main_thread+0x983>
    2ebc:	4c 8d 34 11          	lea    (%rcx,%rdx,1),%r14
    2ec0:	49 81 c6 28 02 00 00 	add    $0x228,%r14
    2ec7:	41 80 3e ff          	cmpb   $0xff,(%r14)
    2ecb:	74 2d                	je     2efa <fwp_main_thread+0x9aa>
    2ecd:	41 c6 06 01          	movb   $0x1,(%r14)
    2ed1:	eb 31                	jmp    2f04 <fwp_main_thread+0x9b4>
    2ed3:	40 80 fe 01          	cmp    $0x1,%sil
    2ed7:	75 2b                	jne    2f04 <fwp_main_thread+0x9b4>
    2ed9:	48 8d 34 11          	lea    (%rcx,%rdx,1),%rsi
    2edd:	8b 4c 11 20          	mov    0x20(%rcx,%rdx,1),%ecx
    2ee1:	48 0f af c1          	imul   %rcx,%rax
    2ee5:	48 c1 e8 20          	shr    $0x20,%rax
    2ee9:	4c 8d 34 30          	lea    (%rax,%rsi,1),%r14
    2eed:	49 81 c6 28 02 00 00 	add    $0x228,%r14
    2ef4:	41 80 3e ff          	cmpb   $0xff,(%r14)
    2ef8:	75 d3                	jne    2ecd <fwp_main_thread+0x97d>
    2efa:	4c 89 f7             	mov    %r14,%rdi
    2efd:	e8 5e 34 00 00       	call   6360 <fwp_rc_forget_slot>
    2f02:	eb c9                	jmp    2ecd <fwp_main_thread+0x97d>
    2f04:	48 8d 35 05 ee 00 00 	lea    0xee05(%rip),%rsi        # 11d10 <d2>
    2f0b:	4c 89 ff             	mov    %r15,%rdi
    2f0e:	e8 fd 34 00 00       	call   6410 <fwp_p_array_from_list_typed>
    2f13:	4c 89 f9             	mov    %r15,%rcx
    2f16:	48 2b 0d 93 02 01 00 	sub    0x10293(%rip),%rcx        # 131b0 <fwp_gc+0x1030>
    2f1d:	49 89 c6             	mov    %rax,%r14
    2f20:	48 8b 05 b1 02 01 00 	mov    0x102b1(%rip),%rax        # 131d8 <fwp_gc+0x1058>
    2f27:	48 c1 e0 10          	shl    $0x10,%rax
    2f2b:	48 39 c1             	cmp    %rax,%rcx
    2f2e:	0f 83 a0 00 00 00    	jae    2fd4 <fwp_main_thread+0xa84>
    2f34:	48 8b 05 bd 02 01 00 	mov    0x102bd(%rip),%rax        # 131f8 <fwp_gc+0x1078>
    2f3b:	48 89 ca             	mov    %rcx,%rdx
    2f3e:	48 c1 ea 10          	shr    $0x10,%rdx
    2f42:	48 69 d2 28 12 00 00 	imul   $0x1228,%rdx,%rdx
    2f49:	0f b6 34 10          	movzbl (%rax,%rdx,1),%esi
    2f4d:	48 81 e1 ff ff 00 00 	and    $0xffff,%rcx
    2f54:	75 13                	jne    2f69 <fwp_main_thread+0xa19>
    2f56:	40 80 fe 02          	cmp    $0x2,%sil
    2f5a:	75 0d                	jne    2f69 <fwp_main_thread+0xa19>
    2f5c:	48 8d 3c 10          	lea    (%rax,%rdx,1),%rdi
    2f60:	48 81 c7 28 02 00 00 	add    $0x228,%rdi
    2f67:	eb 21                	jmp    2f8a <fwp_main_thread+0xa3a>
    2f69:	40 80 fe 01          	cmp    $0x1,%sil
    2f6d:	75 65                	jne    2fd4 <fwp_main_thread+0xa84>
    2f6f:	48 8d 34 10          	lea    (%rax,%rdx,1),%rsi
    2f73:	8b 44 10 20          	mov    0x20(%rax,%rdx,1),%eax
    2f77:	48 0f af c8          	imul   %rax,%rcx
    2f7b:	48 c1 e9 20          	shr    $0x20,%rcx
    2f7f:	48 8d 3c 31          	lea    (%rcx,%rsi,1),%rdi
    2f83:	48 81 c7 28 02 00 00 	add    $0x228,%rdi
    2f8a:	0f b6 07             	movzbl (%rdi),%eax
    2f8d:	85 c0                	test   %eax,%eax
    2f8f:	74 43                	je     2fd4 <fwp_main_thread+0xa84>
    2f91:	83 f8 01             	cmp    $0x1,%eax
    2f94:	75 2f                	jne    2fc5 <fwp_main_thread+0xa75>
    2f96:	49 8b 5f 10          	mov    0x10(%r15),%rbx
    2f9a:	4c 89 ff             	mov    %r15,%rdi
    2f9d:	e8 ce 79 00 00       	call   a970 <fwp_rc_free_obj>
    2fa2:	48 89 d9             	mov    %rbx,%rcx
    2fa5:	48 2b 0d 04 02 01 00 	sub    0x10204(%rip),%rcx        # 131b0 <fwp_gc+0x1030>
    2fac:	48 8b 05 25 02 01 00 	mov    0x10225(%rip),%rax        # 131d8 <fwp_gc+0x1058>
    2fb3:	48 c1 e0 10          	shl    $0x10,%rax
    2fb7:	49 89 df             	mov    %rbx,%r15
    2fba:	48 39 c1             	cmp    %rax,%rcx
    2fbd:	0f 82 71 ff ff ff    	jb     2f34 <fwp_main_thread+0x9e4>
    2fc3:	eb 0f                	jmp    2fd4 <fwp_main_thread+0xa84>
    2fc5:	3d ff 00 00 00       	cmp    $0xff,%eax
    2fca:	0f 84 02 11 00 00    	je     40d2 <fwp_main_thread+0x1b82>
    2fd0:	fe c8                	dec    %al
    2fd2:	88 07                	mov    %al,(%rdi)
    2fd4:	31 db                	xor    %ebx,%ebx
    2fd6:	45 31 ff             	xor    %r15d,%r15d
    2fd9:	45 31 e4             	xor    %r12d,%r12d
    2fdc:	45 31 ed             	xor    %r13d,%r13d
    2fdf:	31 ff                	xor    %edi,%edi
    2fe1:	eb 21                	jmp    3004 <fwp_main_thread+0xab4>
    2fe3:	66 66 66 66 2e 0f 1f 	data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    2fea:	84 00 00 00 00 00 
    2ff0:	4c 89 f7             	mov    %r14,%rdi
    2ff3:	e8 a8 97 00 00       	call   c7a0 <fwp_drop8>
    2ff8:	31 c0                	xor    %eax,%eax
    2ffa:	48 89 df             	mov    %rbx,%rdi
    2ffd:	4d 89 e6             	mov    %r12,%r14
    3000:	84 c0                	test   %al,%al
    3002:	74 5b                	je     305f <fwp_main_thread+0xb0f>
    3004:	4d 85 ff             	test   %r15,%r15
    3007:	78 e7                	js     2ff0 <fwp_main_thread+0xaa0>
    3009:	49 8b 06             	mov    (%r14),%rax
    300c:	48 89 c1             	mov    %rax,%rcx
    300f:	48 ba ff ff ff ff ff 	movabs $0x7fffffffffffffff,%rdx
    3016:	ff ff 7f 
    3019:	48 21 d1             	and    %rdx,%rcx
    301c:	49 39 cf             	cmp    %rcx,%r15
    301f:	73 cf                	jae    2ff0 <fwp_main_thread+0xaa0>
    3021:	48 85 c0             	test   %rax,%rax
    3024:	78 06                	js     302c <fwp_main_thread+0xadc>
    3026:	49 8d 46 08          	lea    0x8(%r14),%rax
    302a:	eb 04                	jmp    3030 <fwp_main_thread+0xae0>
    302c:	49 8b 46 10          	mov    0x10(%r14),%rax
    3030:	f3 42 0f 10 04 b8    	movss  (%rax,%r15,4),%xmm0
    3036:	49 ff c7             	inc    %r15
    3039:	f3 0f 59 05 c3 bf 00 	mulss  0xbfc3(%rip),%xmm0        # f004 <_IO_stdin_used+0x4>
    3040:	00 
    3041:	f3 0f 58 05 bf bf 00 	addss  0xbfbf(%rip),%xmm0        # f008 <_IO_stdin_used+0x8>
    3048:	00 
    3049:	66 0f 6e cb          	movd   %ebx,%xmm1
    304d:	f3 0f 58 c8          	addss  %xmm0,%xmm1
    3051:	66 0f 7e cb          	movd   %xmm1,%ebx
    3055:	b0 01                	mov    $0x1,%al
    3057:	4d 89 f4             	mov    %r14,%r12
    305a:	4d 89 f5             	mov    %r14,%r13
    305d:	eb 9e                	jmp    2ffd <fwp_main_thread+0xaad>
    305f:	48 8d 35 aa ec 00 00 	lea    0xecaa(%rip),%rsi        # 11d10 <d2>
    3066:	e8 35 47 00 00       	call   77a0 <fwp_show>
    306b:	49 89 c6             	mov    %rax,%r14
    306e:	48 2b 05 3b 01 01 00 	sub    0x1013b(%rip),%rax        # 131b0 <fwp_gc+0x1030>
    3075:	48 8b 0d 5c 01 01 00 	mov    0x1015c(%rip),%rcx        # 131d8 <fwp_gc+0x1058>
    307c:	48 c1 e1 10          	shl    $0x10,%rcx
    3080:	48 39 c8             	cmp    %rcx,%rax
    3083:	73 6f                	jae    30f4 <fwp_main_thread+0xba4>
    3085:	48 8b 0d 6c 01 01 00 	mov    0x1016c(%rip),%rcx        # 131f8 <fwp_gc+0x1078>
    308c:	48 89 c2             	mov    %rax,%rdx
    308f:	48 c1 ea 10          	shr    $0x10,%rdx
    3093:	48 69 d2 28 12 00 00 	imul   $0x1228,%rdx,%rdx
    309a:	0f b6 34 11          	movzbl (%rcx,%rdx,1),%esi
    309e:	48 25 ff ff 00 00    	and    $0xffff,%rax
    30a4:	75 1d                	jne    30c3 <fwp_main_thread+0xb73>
    30a6:	40 80 fe 02          	cmp    $0x2,%sil
    30aa:	75 17                	jne    30c3 <fwp_main_thread+0xb73>
    30ac:	4c 8d 3c 11          	lea    (%rcx,%rdx,1),%r15
    30b0:	49 81 c7 28 02 00 00 	add    $0x228,%r15
    30b7:	41 80 3f ff          	cmpb   $0xff,(%r15)
    30bb:	74 2d                	je     30ea <fwp_main_thread+0xb9a>
    30bd:	41 c6 07 01          	movb   $0x1,(%r15)
    30c1:	eb 31                	jmp    30f4 <fwp_main_thread+0xba4>
    30c3:	40 80 fe 01          	cmp    $0x1,%sil
    30c7:	75 2b                	jne    30f4 <fwp_main_thread+0xba4>
    30c9:	48 8d 34 11          	lea    (%rcx,%rdx,1),%rsi
    30cd:	8b 4c 11 20          	mov    0x20(%rcx,%rdx,1),%ecx
    30d1:	48 0f af c1          	imul   %rcx,%rax
    30d5:	48 c1 e8 20          	shr    $0x20,%rax
    30d9:	4c 8d 3c 30          	lea    (%rax,%rsi,1),%r15
    30dd:	49 81 c7 28 02 00 00 	add    $0x228,%r15
    30e4:	41 80 3f ff          	cmpb   $0xff,(%r15)
    30e8:	75 d3                	jne    30bd <fwp_main_thread+0xb6d>
    30ea:	4c 89 ff             	mov    %r15,%rdi
    30ed:	e8 6e 32 00 00       	call   6360 <fwp_rc_forget_slot>
    30f2:	eb c9                	jmp    30bd <fwp_main_thread+0xb6d>
    30f4:	4c 89 f7             	mov    %r14,%rdi
    30f7:	48 83 c7 08          	add    $0x8,%rdi
    30fb:	49 8b 16             	mov    (%r14),%rdx
    30fe:	48 8b 0d c3 0a 01 00 	mov    0x10ac3(%rip),%rcx        # 13bc8 <fwp_prog_out>
    3105:	be 01 00 00 00       	mov    $0x1,%esi
    310a:	e8 91 f1 ff ff       	call   22a0 <fwrite@plt>
    310f:	48 8b 35 b2 0a 01 00 	mov    0x10ab2(%rip),%rsi        # 13bc8 <fwp_prog_out>
    3116:	bf 0a 00 00 00       	mov    $0xa,%edi
    311b:	e8 20 f0 ff ff       	call   2140 <fputc@plt>
    3120:	4c 89 f0             	mov    %r14,%rax
    3123:	48 2b 05 86 00 01 00 	sub    0x10086(%rip),%rax        # 131b0 <fwp_gc+0x1030>
    312a:	48 8b 0d a7 00 01 00 	mov    0x100a7(%rip),%rcx        # 131d8 <fwp_gc+0x1058>
    3131:	48 c1 e1 10          	shl    $0x10,%rcx
    3135:	48 39 c8             	cmp    %rcx,%rax
    3138:	73 7a                	jae    31b4 <fwp_main_thread+0xc64>
    313a:	48 8b 0d b7 00 01 00 	mov    0x100b7(%rip),%rcx        # 131f8 <fwp_gc+0x1078>
    3141:	48 89 c2             	mov    %rax,%rdx
    3144:	48 c1 ea 10          	shr    $0x10,%rdx
    3148:	48 69 d2 28 12 00 00 	imul   $0x1228,%rdx,%rdx
    314f:	0f b6 34 11          	movzbl (%rcx,%rdx,1),%esi
    3153:	48 25 ff ff 00 00    	and    $0xffff,%rax
    3159:	75 13                	jne    316e <fwp_main_thread+0xc1e>
    315b:	40 80 fe 02          	cmp    $0x2,%sil
    315f:	75 0d                	jne    316e <fwp_main_thread+0xc1e>
    3161:	48 8d 3c 11          	lea    (%rcx,%rdx,1),%rdi
    3165:	48 81 c7 28 02 00 00 	add    $0x228,%rdi
    316c:	eb 21                	jmp    318f <fwp_main_thread+0xc3f>
    316e:	40 80 fe 01          	cmp    $0x1,%sil
    3172:	75 40                	jne    31b4 <fwp_main_thread+0xc64>
    3174:	48 8d 34 11          	lea    (%rcx,%rdx,1),%rsi
    3178:	8b 4c 11 20          	mov    0x20(%rcx,%rdx,1),%ecx
    317c:	48 0f af c1          	imul   %rcx,%rax
    3180:	48 c1 e8 20          	shr    $0x20,%rax
    3184:	48 8d 3c 30          	lea    (%rax,%rsi,1),%rdi
    3188:	48 81 c7 28 02 00 00 	add    $0x228,%rdi
    318f:	0f b6 07             	movzbl (%rdi),%eax
    3192:	85 c0                	test   %eax,%eax
    3194:	74 1e                	je     31b4 <fwp_main_thread+0xc64>
    3196:	83 f8 01             	cmp    $0x1,%eax
    3199:	75 0a                	jne    31a5 <fwp_main_thread+0xc55>
    319b:	4c 89 f7             	mov    %r14,%rdi
    319e:	e8 cd 77 00 00       	call   a970 <fwp_rc_free_obj>
    31a3:	eb 0f                	jmp    31b4 <fwp_main_thread+0xc64>
    31a5:	3d ff 00 00 00       	cmp    $0xff,%eax
    31aa:	0f 84 3d 0f 00 00    	je     40ed <fwp_main_thread+0x1b9d>
    31b0:	fe c8                	dec    %al
    31b2:	88 07                	mov    %al,(%rdi)
    31b4:	48 c7 85 00 ff ff ff 	movq   $0xc,-0x100(%rbp)
    31bb:	0c 00 00 00 
    31bf:	48 c7 85 08 ff ff ff 	movq   $0x0,-0xf8(%rbp)
    31c6:	00 00 00 00 
    31ca:	48 8d 95 00 ff ff ff 	lea    -0x100(%rbp),%rdx
    31d1:	bf 01 00 00 00       	mov    $0x1,%edi
    31d6:	be 02 00 00 00       	mov    $0x2,%esi
    31db:	e8 50 6c 00 00       	call   9e30 <fwp_data>
    31e0:	48 89 c1             	mov    %rax,%rcx
    31e3:	48 2b 0d c6 ff 00 00 	sub    0xffc6(%rip),%rcx        # 131b0 <fwp_gc+0x1030>
    31ea:	48 8b 15 e7 ff 00 00 	mov    0xffe7(%rip),%rdx        # 131d8 <fwp_gc+0x1058>
    31f1:	48 c1 e2 10          	shl    $0x10,%rdx
    31f5:	48 39 d1             	cmp    %rdx,%rcx
    31f8:	73 76                	jae    3270 <fwp_main_thread+0xd20>
    31fa:	48 8b 15 f7 ff 00 00 	mov    0xfff7(%rip),%rdx        # 131f8 <fwp_gc+0x1078>
    3201:	48 89 ce             	mov    %rcx,%rsi
    3204:	48 c1 ee 10          	shr    $0x10,%rsi
    3208:	48 69 f6 28 12 00 00 	imul   $0x1228,%rsi,%rsi
    320f:	0f b6 3c 32          	movzbl (%rdx,%rsi,1),%edi
    3213:	48 81 e1 ff ff 00 00 	and    $0xffff,%rcx
    321a:	75 1d                	jne    3239 <fwp_main_thread+0xce9>
    321c:	40 80 ff 02          	cmp    $0x2,%dil
    3220:	75 17                	jne    3239 <fwp_main_thread+0xce9>
    3222:	4c 8d 34 32          	lea    (%rdx,%rsi,1),%r14
    3226:	49 81 c6 28 02 00 00 	add    $0x228,%r14
    322d:	41 80 3e ff          	cmpb   $0xff,(%r14)
    3231:	74 2d                	je     3260 <fwp_main_thread+0xd10>
    3233:	41 c6 06 01          	movb   $0x1,(%r14)
    3237:	eb 37                	jmp    3270 <fwp_main_thread+0xd20>
    3239:	40 80 ff 01          	cmp    $0x1,%dil
    323d:	75 31                	jne    3270 <fwp_main_thread+0xd20>
    323f:	48 8d 3c 32          	lea    (%rdx,%rsi,1),%rdi
    3243:	8b 54 32 20          	mov    0x20(%rdx,%rsi,1),%edx
    3247:	48 0f af ca          	imul   %rdx,%rcx
    324b:	48 c1 e9 20          	shr    $0x20,%rcx
    324f:	4c 8d 34 39          	lea    (%rcx,%rdi,1),%r14
    3253:	49 81 c6 28 02 00 00 	add    $0x228,%r14
    325a:	41 80 3e ff          	cmpb   $0xff,(%r14)
    325e:	75 d3                	jne    3233 <fwp_main_thread+0xce3>
    3260:	4c 89 f7             	mov    %r14,%rdi
    3263:	48 89 c3             	mov    %rax,%rbx
    3266:	e8 f5 30 00 00       	call   6360 <fwp_rc_forget_slot>
    326b:	48 89 d8             	mov    %rbx,%rax
    326e:	eb c3                	jmp    3233 <fwp_main_thread+0xce3>
    3270:	48 c7 85 10 ff ff ff 	movq   $0x0,-0xf0(%rbp)
    3277:	00 00 00 00 
    327b:	48 89 85 18 ff ff ff 	mov    %rax,-0xe8(%rbp)
    3282:	48 8d 95 10 ff ff ff 	lea    -0xf0(%rbp),%rdx
    3289:	bf 01 00 00 00       	mov    $0x1,%edi
    328e:	be 02 00 00 00       	mov    $0x2,%esi
    3293:	e8 98 6b 00 00       	call   9e30 <fwp_data>
    3298:	48 89 c1             	mov    %rax,%rcx
    329b:	48 2b 0d 0e ff 00 00 	sub    0xff0e(%rip),%rcx        # 131b0 <fwp_gc+0x1030>
    32a2:	48 8b 15 2f ff 00 00 	mov    0xff2f(%rip),%rdx        # 131d8 <fwp_gc+0x1058>
    32a9:	48 c1 e2 10          	shl    $0x10,%rdx
    32ad:	48 39 d1             	cmp    %rdx,%rcx
    32b0:	73 76                	jae    3328 <fwp_main_thread+0xdd8>
    32b2:	48 8b 15 3f ff 00 00 	mov    0xff3f(%rip),%rdx        # 131f8 <fwp_gc+0x1078>
    32b9:	48 89 ce             	mov    %rcx,%rsi
    32bc:	48 c1 ee 10          	shr    $0x10,%rsi
    32c0:	48 69 f6 28 12 00 00 	imul   $0x1228,%rsi,%rsi
    32c7:	0f b6 3c 32          	movzbl (%rdx,%rsi,1),%edi
    32cb:	48 81 e1 ff ff 00 00 	and    $0xffff,%rcx
    32d2:	75 1d                	jne    32f1 <fwp_main_thread+0xda1>
    32d4:	40 80 ff 02          	cmp    $0x2,%dil
    32d8:	75 17                	jne    32f1 <fwp_main_thread+0xda1>
    32da:	4c 8d 34 32          	lea    (%rdx,%rsi,1),%r14
    32de:	49 81 c6 28 02 00 00 	add    $0x228,%r14
    32e5:	41 80 3e ff          	cmpb   $0xff,(%r14)
    32e9:	74 2d                	je     3318 <fwp_main_thread+0xdc8>
    32eb:	41 c6 06 01          	movb   $0x1,(%r14)
    32ef:	eb 37                	jmp    3328 <fwp_main_thread+0xdd8>
    32f1:	40 80 ff 01          	cmp    $0x1,%dil
    32f5:	75 31                	jne    3328 <fwp_main_thread+0xdd8>
    32f7:	48 8d 3c 32          	lea    (%rdx,%rsi,1),%rdi
    32fb:	8b 54 32 20          	mov    0x20(%rdx,%rsi,1),%edx
    32ff:	48 0f af ca          	imul   %rdx,%rcx
    3303:	48 c1 e9 20          	shr    $0x20,%rcx
    3307:	4c 8d 34 39          	lea    (%rcx,%rdi,1),%r14
    330b:	49 81 c6 28 02 00 00 	add    $0x228,%r14
    3312:	41 80 3e ff          	cmpb   $0xff,(%r14)
    3316:	75 d3                	jne    32eb <fwp_main_thread+0xd9b>
    3318:	4c 89 f7             	mov    %r14,%rdi
    331b:	48 89 c3             	mov    %rax,%rbx
    331e:	e8 3d 30 00 00       	call   6360 <fwp_rc_forget_slot>
    3323:	48 89 d8             	mov    %rbx,%rax
    3326:	eb c3                	jmp    32eb <fwp_main_thread+0xd9b>
    3328:	48 c7 85 20 ff ff ff 	movq   $0xffffffffffffff80,-0xe0(%rbp)
    332f:	80 ff ff ff 
    3333:	48 89 85 28 ff ff ff 	mov    %rax,-0xd8(%rbp)
    333a:	48 8d 95 20 ff ff ff 	lea    -0xe0(%rbp),%rdx
    3341:	bf 01 00 00 00       	mov    $0x1,%edi
    3346:	be 02 00 00 00       	mov    $0x2,%esi
    334b:	e8 e0 6a 00 00       	call   9e30 <fwp_data>
    3350:	49 89 c7             	mov    %rax,%r15
    3353:	48 2b 05 56 fe 00 00 	sub    0xfe56(%rip),%rax        # 131b0 <fwp_gc+0x1030>
    335a:	48 8b 0d 77 fe 00 00 	mov    0xfe77(%rip),%rcx        # 131d8 <fwp_gc+0x1058>
    3361:	48 c1 e1 10          	shl    $0x10,%rcx
    3365:	48 39 c8             	cmp    %rcx,%rax
    3368:	73 6f                	jae    33d9 <fwp_main_thread+0xe89>
    336a:	48 8b 0d 87 fe 00 00 	mov    0xfe87(%rip),%rcx        # 131f8 <fwp_gc+0x1078>
    3371:	48 89 c2             	mov    %rax,%rdx
    3374:	48 c1 ea 10          	shr    $0x10,%rdx
    3378:	48 69 d2 28 12 00 00 	imul   $0x1228,%rdx,%rdx
    337f:	0f b6 34 11          	movzbl (%rcx,%rdx,1),%esi
    3383:	48 25 ff ff 00 00    	and    $0xffff,%rax
    3389:	75 1d                	jne    33a8 <fwp_main_thread+0xe58>
    338b:	40 80 fe 02          	cmp    $0x2,%sil
    338f:	75 17                	jne    33a8 <fwp_main_thread+0xe58>
    3391:	4c 8d 34 11          	lea    (%rcx,%rdx,1),%r14
    3395:	49 81 c6 28 02 00 00 	add    $0x228,%r14
    339c:	41 80 3e ff          	cmpb   $0xff,(%r14)
    33a0:	74 2d                	je     33cf <fwp_main_thread+0xe7f>
    33a2:	41 c6 06 01          	movb   $0x1,(%r14)
    33a6:	eb 31                	jmp    33d9 <fwp_main_thread+0xe89>
    33a8:	40 80 fe 01          	cmp    $0x1,%sil
    33ac:	75 2b                	jne    33d9 <fwp_main_thread+0xe89>
    33ae:	48 8d 34 11          	lea    (%rcx,%rdx,1),%rsi
    33b2:	8b 4c 11 20          	mov    0x20(%rcx,%rdx,1),%ecx
    33b6:	48 0f af c1          	imul   %rcx,%rax
    33ba:	48 c1 e8 20          	shr    $0x20,%rax
    33be:	4c 8d 34 30          	lea    (%rax,%rsi,1),%r14
    33c2:	49 81 c6 28 02 00 00 	add    $0x228,%r14
    33c9:	41 80 3e ff          	cmpb   $0xff,(%r14)
    33cd:	75 d3                	jne    33a2 <fwp_main_thread+0xe52>
    33cf:	4c 89 f7             	mov    %r14,%rdi
    33d2:	e8 89 2f 00 00       	call   6360 <fwp_rc_forget_slot>
    33d7:	eb c9                	jmp    33a2 <fwp_main_thread+0xe52>
    33d9:	48 8d 35 d0 e8 00 00 	lea    0xe8d0(%rip),%rsi        # 11cb0 <d1>
    33e0:	4c 89 ff             	mov    %r15,%rdi
    33e3:	e8 28 30 00 00       	call   6410 <fwp_p_array_from_list_typed>
    33e8:	49 89 c6             	mov    %rax,%r14
    33eb:	4c 89 ff             	mov    %r15,%rdi
    33ee:	e8 ad ad 00 00       	call   e1a0 <fwp_drop4>
    33f3:	31 db                	xor    %ebx,%ebx
    33f5:	45 31 ff             	xor    %r15d,%r15d
    33f8:	45 31 e4             	xor    %r12d,%r12d
    33fb:	45 31 ed             	xor    %r13d,%r13d
    33fe:	31 ff                	xor    %edi,%edi
    3400:	eb 22                	jmp    3424 <fwp_main_thread+0xed4>
    3402:	66 66 66 66 66 2e 0f 	data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    3409:	1f 84 00 00 00 00 00 
    3410:	4c 89 f7             	mov    %r14,%rdi
    3413:	e8 38 9b 00 00       	call   cf50 <fwp_drop11>
    3418:	31 c0                	xor    %eax,%eax
    341a:	48 89 df             	mov    %rbx,%rdi
    341d:	4d 89 e6             	mov    %r12,%r14
    3420:	84 c0                	test   %al,%al
    3422:	74 57                	je     347b <fwp_main_thread+0xf2b>
    3424:	4d 85 ff             	test   %r15,%r15
    3427:	78 e7                	js     3410 <fwp_main_thread+0xec0>
    3429:	49 8b 06             	mov    (%r14),%rax
    342c:	48 89 c1             	mov    %rax,%rcx
    342f:	48 ba ff ff ff ff ff 	movabs $0x7fffffffffffffff,%rdx
    3436:	ff ff 7f 
    3439:	48 21 d1             	and    %rdx,%rcx
    343c:	49 39 cf             	cmp    %rcx,%r15
    343f:	73 cf                	jae    3410 <fwp_main_thread+0xec0>
    3441:	48 85 c0             	test   %rax,%rax
    3444:	78 06                	js     344c <fwp_main_thread+0xefc>
    3446:	49 8d 46 08          	lea    0x8(%r14),%rax
    344a:	eb 04                	jmp    3450 <fwp_main_thread+0xf00>
    344c:	49 8b 46 10          	mov    0x10(%r14),%rax
    3450:	4a 0f be 04 38       	movsbq (%rax,%r15,1),%rax
    3455:	48 83 c0 81          	add    $0xffffffffffffff81,%rax
    3459:	48 3d ff fe ff ff    	cmp    $0xfffffffffffffeff,%rax
    345f:	0f 86 b0 0c 00 00    	jbe    4115 <fwp_main_thread+0x1bc5>
    3465:	48 ff c3             	inc    %rbx
    3468:	0f 80 b7 0c 00 00    	jo     4125 <fwp_main_thread+0x1bd5>
    346e:	49 ff c7             	inc    %r15
    3471:	b0 01                	mov    $0x1,%al
    3473:	4d 89 f4             	mov    %r14,%r12
    3476:	4d 89 f5             	mov    %r14,%r13
    3479:	eb a2                	jmp    341d <fwp_main_thread+0xecd>
    347b:	e8 10 67 00 00       	call   9b90 <fwp_show_i64>
    3480:	49 89 c6             	mov    %rax,%r14
    3483:	48 2b 05 26 fd 00 00 	sub    0xfd26(%rip),%rax        # 131b0 <fwp_gc+0x1030>
    348a:	48 8b 0d 47 fd 00 00 	mov    0xfd47(%rip),%rcx        # 131d8 <fwp_gc+0x1058>
    3491:	48 c1 e1 10          	shl    $0x10,%rcx
    3495:	48 39 c8             	cmp    %rcx,%rax
    3498:	73 6f                	jae    3509 <fwp_main_thread+0xfb9>
    349a:	48 8b 0d 57 fd 00 00 	mov    0xfd57(%rip),%rcx        # 131f8 <fwp_gc+0x1078>
    34a1:	48 89 c2             	mov    %rax,%rdx
    34a4:	48 c1 ea 10          	shr    $0x10,%rdx
    34a8:	48 69 d2 28 12 00 00 	imul   $0x1228,%rdx,%rdx
    34af:	0f b6 34 11          	movzbl (%rcx,%rdx,1),%esi
    34b3:	48 25 ff ff 00 00    	and    $0xffff,%rax
    34b9:	75 1d                	jne    34d8 <fwp_main_thread+0xf88>
    34bb:	40 80 fe 02          	cmp    $0x2,%sil
    34bf:	75 17                	jne    34d8 <fwp_main_thread+0xf88>
    34c1:	4c 8d 3c 11          	lea    (%rcx,%rdx,1),%r15
    34c5:	49 81 c7 28 02 00 00 	add    $0x228,%r15
    34cc:	41 80 3f ff          	cmpb   $0xff,(%r15)
    34d0:	74 2d                	je     34ff <fwp_main_thread+0xfaf>
    34d2:	41 c6 07 01          	movb   $0x1,(%r15)
    34d6:	eb 31                	jmp    3509 <fwp_main_thread+0xfb9>
    34d8:	40 80 fe 01          	cmp    $0x1,%sil
    34dc:	75 2b                	jne    3509 <fwp_main_thread+0xfb9>
    34de:	48 8d 34 11          	lea    (%rcx,%rdx,1),%rsi
    34e2:	8b 4c 11 20          	mov    0x20(%rcx,%rdx,1),%ecx
    34e6:	48 0f af c1          	imul   %rcx,%rax
    34ea:	48 c1 e8 20          	shr    $0x20,%rax
    34ee:	4c 8d 3c 30          	lea    (%rax,%rsi,1),%r15
    34f2:	49 81 c7 28 02 00 00 	add    $0x228,%r15
    34f9:	41 80 3f ff          	cmpb   $0xff,(%r15)
    34fd:	75 d3                	jne    34d2 <fwp_main_thread+0xf82>
    34ff:	4c 89 ff             	mov    %r15,%rdi
    3502:	e8 59 2e 00 00       	call   6360 <fwp_rc_forget_slot>
    3507:	eb c9                	jmp    34d2 <fwp_main_thread+0xf82>
    3509:	4c 89 f7             	mov    %r14,%rdi
    350c:	48 83 c7 08          	add    $0x8,%rdi
    3510:	49 8b 16             	mov    (%r14),%rdx
    3513:	48 8b 0d ae 06 01 00 	mov    0x106ae(%rip),%rcx        # 13bc8 <fwp_prog_out>
    351a:	be 01 00 00 00       	mov    $0x1,%esi
    351f:	e8 7c ed ff ff       	call   22a0 <fwrite@plt>
    3524:	48 8b 35 9d 06 01 00 	mov    0x1069d(%rip),%rsi        # 13bc8 <fwp_prog_out>
    352b:	bf 0a 00 00 00       	mov    $0xa,%edi
    3530:	e8 0b ec ff ff       	call   2140 <fputc@plt>
    3535:	4c 89 f0             	mov    %r14,%rax
    3538:	48 2b 05 71 fc 00 00 	sub    0xfc71(%rip),%rax        # 131b0 <fwp_gc+0x1030>
    353f:	48 8b 0d 92 fc 00 00 	mov    0xfc92(%rip),%rcx        # 131d8 <fwp_gc+0x1058>
    3546:	48 c1 e1 10          	shl    $0x10,%rcx
    354a:	48 39 c8             	cmp    %rcx,%rax
    354d:	73 7a                	jae    35c9 <fwp_main_thread+0x1079>
    354f:	48 8b 0d a2 fc 00 00 	mov    0xfca2(%rip),%rcx        # 131f8 <fwp_gc+0x1078>
    3556:	48 89 c2             	mov    %rax,%rdx
    3559:	48 c1 ea 10          	shr    $0x10,%rdx
    355d:	48 69 d2 28 12 00 00 	imul   $0x1228,%rdx,%rdx
    3564:	0f b6 34 11          	movzbl (%rcx,%rdx,1),%esi
    3568:	48 25 ff ff 00 00    	and    $0xffff,%rax
    356e:	75 13                	jne    3583 <fwp_main_thread+0x1033>
    3570:	40 80 fe 02          	cmp    $0x2,%sil
    3574:	75 0d                	jne    3583 <fwp_main_thread+0x1033>
    3576:	48 8d 3c 11          	lea    (%rcx,%rdx,1),%rdi
    357a:	48 81 c7 28 02 00 00 	add    $0x228,%rdi
    3581:	eb 21                	jmp    35a4 <fwp_main_thread+0x1054>
    3583:	40 80 fe 01          	cmp    $0x1,%sil
    3587:	75 40                	jne    35c9 <fwp_main_thread+0x1079>
    3589:	48 8d 34 11          	lea    (%rcx,%rdx,1),%rsi
    358d:	8b 4c 11 20          	mov    0x20(%rcx,%rdx,1),%ecx
    3591:	48 0f af c1          	imul   %rcx,%rax
    3595:	48 c1 e8 20          	shr    $0x20,%rax
    3599:	48 8d 3c 30          	lea    (%rax,%rsi,1),%rdi
    359d:	48 81 c7 28 02 00 00 	add    $0x228,%rdi
    35a4:	0f b6 07             	movzbl (%rdi),%eax
    35a7:	85 c0                	test   %eax,%eax
    35a9:	74 1e                	je     35c9 <fwp_main_thread+0x1079>
    35ab:	83 f8 01             	cmp    $0x1,%eax
    35ae:	75 0a                	jne    35ba <fwp_main_thread+0x106a>
    35b0:	4c 89 f7             	mov    %r14,%rdi
    35b3:	e8 b8 73 00 00       	call   a970 <fwp_rc_free_obj>
    35b8:	eb 0f                	jmp    35c9 <fwp_main_thread+0x1079>
    35ba:	3d ff 00 00 00       	cmp    $0xff,%eax
    35bf:	0f 84 32 0b 00 00    	je     40f7 <fwp_main_thread+0x1ba7>
    35c5:	fe c8                	dec    %al
    35c7:	88 07                	mov    %al,(%rdi)
    35c9:	48 c7 85 30 ff ff ff 	movq   $0x3,-0xd0(%rbp)
    35d0:	03 00 00 00 
    35d4:	48 c7 85 38 ff ff ff 	movq   $0x0,-0xc8(%rbp)
    35db:	00 00 00 00 
    35df:	48 8d 95 30 ff ff ff 	lea    -0xd0(%rbp),%rdx
    35e6:	bf 01 00 00 00       	mov    $0x1,%edi
    35eb:	be 02 00 00 00       	mov    $0x2,%esi
    35f0:	e8 3b 68 00 00       	call   9e30 <fwp_data>
    35f5:	48 89 c1             	mov    %rax,%rcx
    35f8:	48 2b 0d b1 fb 00 00 	sub    0xfbb1(%rip),%rcx        # 131b0 <fwp_gc+0x1030>
    35ff:	48 8b 15 d2 fb 00 00 	mov    0xfbd2(%rip),%rdx        # 131d8 <fwp_gc+0x1058>
    3606:	48 c1 e2 10          	shl    $0x10,%rdx
    360a:	48 39 d1             	cmp    %rdx,%rcx
    360d:	73 76                	jae    3685 <fwp_main_thread+0x1135>
    360f:	48 8b 15 e2 fb 00 00 	mov    0xfbe2(%rip),%rdx        # 131f8 <fwp_gc+0x1078>
    3616:	48 89 ce             	mov    %rcx,%rsi
    3619:	48 c1 ee 10          	shr    $0x10,%rsi
    361d:	48 69 f6 28 12 00 00 	imul   $0x1228,%rsi,%rsi
    3624:	0f b6 3c 32          	movzbl (%rdx,%rsi,1),%edi
    3628:	48 81 e1 ff ff 00 00 	and    $0xffff,%rcx
    362f:	75 1d                	jne    364e <fwp_main_thread+0x10fe>
    3631:	40 80 ff 02          	cmp    $0x2,%dil
    3635:	75 17                	jne    364e <fwp_main_thread+0x10fe>
    3637:	4c 8d 34 32          	lea    (%rdx,%rsi,1),%r14
    363b:	49 81 c6 28 02 00 00 	add    $0x228,%r14
    3642:	41 80 3e ff          	cmpb   $0xff,(%r14)
    3646:	74 2d                	je     3675 <fwp_main_thread+0x1125>
    3648:	41 c6 06 01          	movb   $0x1,(%r14)
    364c:	eb 37                	jmp    3685 <fwp_main_thread+0x1135>
    364e:	40 80 ff 01          	cmp    $0x1,%dil
    3652:	75 31                	jne    3685 <fwp_main_thread+0x1135>
    3654:	48 8d 3c 32          	lea    (%rdx,%rsi,1),%rdi
    3658:	8b 54 32 20          	mov    0x20(%rdx,%rsi,1),%edx
    365c:	48 0f af ca          	imul   %rdx,%rcx
    3660:	48 c1 e9 20          	shr    $0x20,%rcx
    3664:	4c 8d 34 39          	lea    (%rcx,%rdi,1),%r14
    3668:	49 81 c6 28 02 00 00 	add    $0x228,%r14
    366f:	41 80 3e ff          	cmpb   $0xff,(%r14)
    3673:	75 d3                	jne    3648 <fwp_main_thread+0x10f8>
    3675:	4c 89 f7             	mov    %r14,%rdi
    3678:	48 89 c3             	mov    %rax,%rbx
    367b:	e8 e0 2c 00 00       	call   6360 <fwp_rc_forget_slot>
    3680:	48 89 d8             	mov    %rbx,%rax
    3683:	eb c3                	jmp    3648 <fwp_main_thread+0x10f8>
    3685:	48 c7 85 40 ff ff ff 	movq   $0x2,-0xc0(%rbp)
    368c:	02 00 00 00 
    3690:	48 89 85 48 ff ff ff 	mov    %rax,-0xb8(%rbp)
    3697:	48 8d 95 40 ff ff ff 	lea    -0xc0(%rbp),%rdx
    369e:	bf 01 00 00 00       	mov    $0x1,%edi
    36a3:	be 02 00 00 00       	mov    $0x2,%esi
    36a8:	e8 83 67 00 00       	call   9e30 <fwp_data>
    36ad:	48 89 c1             	mov    %rax,%rcx
    36b0:	48 2b 0d f9 fa 00 00 	sub    0xfaf9(%rip),%rcx        # 131b0 <fwp_gc+0x1030>
    36b7:	48 8b 15 1a fb 00 00 	mov    0xfb1a(%rip),%rdx        # 131d8 <fwp_gc+0x1058>
    36be:	48 c1 e2 10          	shl    $0x10,%rdx
    36c2:	48 39 d1             	cmp    %rdx,%rcx
    36c5:	73 76                	jae    373d <fwp_main_thread+0x11ed>
    36c7:	48 8b 15 2a fb 00 00 	mov    0xfb2a(%rip),%rdx        # 131f8 <fwp_gc+0x1078>
    36ce:	48 89 ce             	mov    %rcx,%rsi
    36d1:	48 c1 ee 10          	shr    $0x10,%rsi
    36d5:	48 69 f6 28 12 00 00 	imul   $0x1228,%rsi,%rsi
    36dc:	0f b6 3c 32          	movzbl (%rdx,%rsi,1),%edi
    36e0:	48 81 e1 ff ff 00 00 	and    $0xffff,%rcx
    36e7:	75 1d                	jne    3706 <fwp_main_thread+0x11b6>
    36e9:	40 80 ff 02          	cmp    $0x2,%dil
    36ed:	75 17                	jne    3706 <fwp_main_thread+0x11b6>
    36ef:	4c 8d 34 32          	lea    (%rdx,%rsi,1),%r14
    36f3:	49 81 c6 28 02 00 00 	add    $0x228,%r14
    36fa:	41 80 3e ff          	cmpb   $0xff,(%r14)
    36fe:	74 2d                	je     372d <fwp_main_thread+0x11dd>
    3700:	41 c6 06 01          	movb   $0x1,(%r14)
    3704:	eb 37                	jmp    373d <fwp_main_thread+0x11ed>
    3706:	40 80 ff 01          	cmp    $0x1,%dil
    370a:	75 31                	jne    373d <fwp_main_thread+0x11ed>
    370c:	48 8d 3c 32          	lea    (%rdx,%rsi,1),%rdi
    3710:	8b 54 32 20          	mov    0x20(%rdx,%rsi,1),%edx
    3714:	48 0f af ca          	imul   %rdx,%rcx
    3718:	48 c1 e9 20          	shr    $0x20,%rcx
    371c:	4c 8d 34 39          	lea    (%rcx,%rdi,1),%r14
    3720:	49 81 c6 28 02 00 00 	add    $0x228,%r14
    3727:	41 80 3e ff          	cmpb   $0xff,(%r14)
    372b:	75 d3                	jne    3700 <fwp_main_thread+0x11b0>
    372d:	4c 89 f7             	mov    %r14,%rdi
    3730:	48 89 c3             	mov    %rax,%rbx
    3733:	e8 28 2c 00 00       	call   6360 <fwp_rc_forget_slot>
    3738:	48 89 d8             	mov    %rbx,%rax
    373b:	eb c3                	jmp    3700 <fwp_main_thread+0x11b0>
    373d:	48 c7 85 50 ff ff ff 	movq   $0x1,-0xb0(%rbp)
    3744:	01 00 00 00 
    3748:	48 89 85 58 ff ff ff 	mov    %rax,-0xa8(%rbp)
    374f:	48 8d 95 50 ff ff ff 	lea    -0xb0(%rbp),%rdx
    3756:	bf 01 00 00 00       	mov    $0x1,%edi
    375b:	be 02 00 00 00       	mov    $0x2,%esi
    3760:	e8 cb 66 00 00       	call   9e30 <fwp_data>
    3765:	49 89 c7             	mov    %rax,%r15
    3768:	48 2b 05 41 fa 00 00 	sub    0xfa41(%rip),%rax        # 131b0 <fwp_gc+0x1030>
    376f:	48 8b 0d 62 fa 00 00 	mov    0xfa62(%rip),%rcx        # 131d8 <fwp_gc+0x1058>
    3776:	48 c1 e1 10          	shl    $0x10,%rcx
    377a:	48 39 c8             	cmp    %rcx,%rax
    377d:	73 6f                	jae    37ee <fwp_main_thread+0x129e>
    377f:	48 8b 0d 72 fa 00 00 	mov    0xfa72(%rip),%rcx        # 131f8 <fwp_gc+0x1078>
    3786:	48 89 c2             	mov    %rax,%rdx
    3789:	48 c1 ea 10          	shr    $0x10,%rdx
    378d:	48 69 d2 28 12 00 00 	imul   $0x1228,%rdx,%rdx
    3794:	0f b6 34 11          	movzbl (%rcx,%rdx,1),%esi
    3798:	48 25 ff ff 00 00    	and    $0xffff,%rax
    379e:	75 1d                	jne    37bd <fwp_main_thread+0x126d>
    37a0:	40 80 fe 02          	cmp    $0x2,%sil
    37a4:	75 17                	jne    37bd <fwp_main_thread+0x126d>
    37a6:	4c 8d 34 11          	lea    (%rcx,%rdx,1),%r14
    37aa:	49 81 c6 28 02 00 00 	add    $0x228,%r14
    37b1:	41 80 3e ff          	cmpb   $0xff,(%r14)
    37b5:	74 2d                	je     37e4 <fwp_main_thread+0x1294>
    37b7:	41 c6 06 01          	movb   $0x1,(%r14)
    37bb:	eb 31                	jmp    37ee <fwp_main_thread+0x129e>
    37bd:	40 80 fe 01          	cmp    $0x1,%sil
    37c1:	75 2b                	jne    37ee <fwp_main_thread+0x129e>
    37c3:	48 8d 34 11          	lea    (%rcx,%rdx,1),%rsi
    37c7:	8b 4c 11 20          	mov    0x20(%rcx,%rdx,1),%ecx
    37cb:	48 0f af c1          	imul   %rcx,%rax
    37cf:	48 c1 e8 20          	shr    $0x20,%rax
    37d3:	4c 8d 34 30          	lea    (%rax,%rsi,1),%r14
    37d7:	49 81 c6 28 02 00 00 	add    $0x228,%r14
    37de:	41 80 3e ff          	cmpb   $0xff,(%r14)
    37e2:	75 d3                	jne    37b7 <fwp_main_thread+0x1267>
    37e4:	4c 89 f7             	mov    %r14,%rdi
    37e7:	e8 74 2b 00 00       	call   6360 <fwp_rc_forget_slot>
    37ec:	eb c9                	jmp    37b7 <fwp_main_thread+0x1267>
    37ee:	48 8d 35 bb e4 00 00 	lea    0xe4bb(%rip),%rsi        # 11cb0 <d1>
    37f5:	4c 89 ff             	mov    %r15,%rdi
    37f8:	e8 13 2c 00 00       	call   6410 <fwp_p_array_from_list_typed>
    37fd:	49 89 c6             	mov    %rax,%r14
    3800:	4c 89 ff             	mov    %r15,%rdi
    3803:	e8 98 a9 00 00       	call   e1a0 <fwp_drop4>
    3808:	31 db                	xor    %ebx,%ebx
    380a:	45 31 ff             	xor    %r15d,%r15d
    380d:	45 31 e4             	xor    %r12d,%r12d
    3810:	45 31 ed             	xor    %r13d,%r13d
    3813:	31 ff                	xor    %edi,%edi
    3815:	eb 1d                	jmp    3834 <fwp_main_thread+0x12e4>
    3817:	66 0f 1f 84 00 00 00 	nopw   0x0(%rax,%rax,1)
    381e:	00 00 
    3820:	4c 89 f7             	mov    %r14,%rdi
    3823:	e8 28 97 00 00       	call   cf50 <fwp_drop11>
    3828:	31 c0                	xor    %eax,%eax
    382a:	48 89 df             	mov    %rbx,%rdi
    382d:	4d 89 e6             	mov    %r12,%r14
    3830:	84 c0                	test   %al,%al
    3832:	74 62                	je     3896 <fwp_main_thread+0x1346>
    3834:	4d 85 ff             	test   %r15,%r15
    3837:	78 e7                	js     3820 <fwp_main_thread+0x12d0>
    3839:	49 8b 06             	mov    (%r14),%rax
    383c:	48 89 c1             	mov    %rax,%rcx
    383f:	48 ba ff ff ff ff ff 	movabs $0x7fffffffffffffff,%rdx
    3846:	ff ff 7f 
    3849:	48 21 d1             	and    %rdx,%rcx
    384c:	49 39 cf             	cmp    %rcx,%r15
    384f:	73 cf                	jae    3820 <fwp_main_thread+0x12d0>
    3851:	48 85 c0             	test   %rax,%rax
    3854:	78 06                	js     385c <fwp_main_thread+0x130c>
    3856:	49 8d 46 08          	lea    0x8(%r14),%rax
    385a:	eb 04                	jmp    3860 <fwp_main_thread+0x1310>
    385c:	49 8b 46 10          	mov    0x10(%r14),%rax
    3860:	4a 0f be 04 38       	movsbq (%rax,%r15,1),%rax
    3865:	48 8d 48 81          	lea    -0x7f(%rax),%rcx
    3869:	48 81 f9 ff fe ff ff 	cmp    $0xfffffffffffffeff,%rcx
    3870:	0f 86 9f 08 00 00    	jbe    4115 <fwp_main_thread+0x1bc5>
    3876:	48 01 c3             	add    %rax,%rbx
    3879:	48 ff c3             	inc    %rbx
    387c:	48 0f be c3          	movsbq %bl,%rax
    3880:	48 39 d8             	cmp    %rbx,%rax
    3883:	0f 85 8c 08 00 00    	jne    4115 <fwp_main_thread+0x1bc5>
    3889:	49 ff c7             	inc    %r15
    388c:	b0 01                	mov    $0x1,%al
    388e:	4d 89 f4             	mov    %r14,%r12
    3891:	4d 89 f5             	mov    %r14,%r13
    3894:	eb 97                	jmp    382d <fwp_main_thread+0x12dd>
    3896:	e8 f5 62 00 00       	call   9b90 <fwp_show_i64>
    389b:	49 89 c6             	mov    %rax,%r14
    389e:	48 2b 05 0b f9 00 00 	sub    0xf90b(%rip),%rax        # 131b0 <fwp_gc+0x1030>
    38a5:	48 8b 0d 2c f9 00 00 	mov    0xf92c(%rip),%rcx        # 131d8 <fwp_gc+0x1058>
    38ac:	48 c1 e1 10          	shl    $0x10,%rcx
    38b0:	48 39 c8             	cmp    %rcx,%rax
    38b3:	73 6f                	jae    3924 <fwp_main_thread+0x13d4>
    38b5:	48 8b 0d 3c f9 00 00 	mov    0xf93c(%rip),%rcx        # 131f8 <fwp_gc+0x1078>
    38bc:	48 89 c2             	mov    %rax,%rdx
    38bf:	48 c1 ea 10          	shr    $0x10,%rdx
    38c3:	48 69 d2 28 12 00 00 	imul   $0x1228,%rdx,%rdx
    38ca:	0f b6 34 11          	movzbl (%rcx,%rdx,1),%esi
    38ce:	48 25 ff ff 00 00    	and    $0xffff,%rax
    38d4:	75 1d                	jne    38f3 <fwp_main_thread+0x13a3>
    38d6:	40 80 fe 02          	cmp    $0x2,%sil
    38da:	75 17                	jne    38f3 <fwp_main_thread+0x13a3>
    38dc:	4c 8d 3c 11          	lea    (%rcx,%rdx,1),%r15
    38e0:	49 81 c7 28 02 00 00 	add    $0x228,%r15
    38e7:	41 80 3f ff          	cmpb   $0xff,(%r15)
    38eb:	74 2d                	je     391a <fwp_main_thread+0x13ca>
    38ed:	41 c6 07 01          	movb   $0x1,(%r15)
    38f1:	eb 31                	jmp    3924 <fwp_main_thread+0x13d4>
    38f3:	40 80 fe 01          	cmp    $0x1,%sil
    38f7:	75 2b                	jne    3924 <fwp_main_thread+0x13d4>
    38f9:	48 8d 34 11          	lea    (%rcx,%rdx,1),%rsi
    38fd:	8b 4c 11 20          	mov    0x20(%rcx,%rdx,1),%ecx
    3901:	48 0f af c1          	imul   %rcx,%rax
    3905:	48 c1 e8 20          	shr    $0x20,%rax
    3909:	4c 8d 3c 30          	lea    (%rax,%rsi,1),%r15
    390d:	49 81 c7 28 02 00 00 	add    $0x228,%r15
    3914:	41 80 3f ff          	cmpb   $0xff,(%r15)
    3918:	75 d3                	jne    38ed <fwp_main_thread+0x139d>
    391a:	4c 89 ff             	mov    %r15,%rdi
    391d:	e8 3e 2a 00 00       	call   6360 <fwp_rc_forget_slot>
    3922:	eb c9                	jmp    38ed <fwp_main_thread+0x139d>
    3924:	4c 89 f7             	mov    %r14,%rdi
    3927:	48 83 c7 08          	add    $0x8,%rdi
    392b:	49 8b 16             	mov    (%r14),%rdx
    392e:	48 8b 0d 93 02 01 00 	mov    0x10293(%rip),%rcx        # 13bc8 <fwp_prog_out>
    3935:	be 01 00 00 00       	mov    $0x1,%esi
    393a:	e8 61 e9 ff ff       	call   22a0 <fwrite@plt>
    393f:	48 8b 35 82 02 01 00 	mov    0x10282(%rip),%rsi        # 13bc8 <fwp_prog_out>
    3946:	bf 0a 00 00 00       	mov    $0xa,%edi
    394b:	e8 f0 e7 ff ff       	call   2140 <fputc@plt>
    3950:	4c 89 f0             	mov    %r14,%rax
    3953:	48 2b 05 56 f8 00 00 	sub    0xf856(%rip),%rax        # 131b0 <fwp_gc+0x1030>
    395a:	48 8b 0d 77 f8 00 00 	mov    0xf877(%rip),%rcx        # 131d8 <fwp_gc+0x1058>
    3961:	48 c1 e1 10          	shl    $0x10,%rcx
    3965:	48 39 c8             	cmp    %rcx,%rax
    3968:	73 7a                	jae    39e4 <fwp_main_thread+0x1494>
    396a:	48 8b 0d 87 f8 00 00 	mov    0xf887(%rip),%rcx        # 131f8 <fwp_gc+0x1078>
    3971:	48 89 c2             	mov    %rax,%rdx
    3974:	48 c1 ea 10          	shr    $0x10,%rdx
    3978:	48 69 d2 28 12 00 00 	imul   $0x1228,%rdx,%rdx
    397f:	0f b6 34 11          	movzbl (%rcx,%rdx,1),%esi
    3983:	48 25 ff ff 00 00    	and    $0xffff,%rax
    3989:	75 13                	jne    399e <fwp_main_thread+0x144e>
    398b:	40 80 fe 02          	cmp    $0x2,%sil
    398f:	75 0d                	jne    399e <fwp_main_thread+0x144e>
    3991:	48 8d 3c 11          	lea    (%rcx,%rdx,1),%rdi
    3995:	48 81 c7 28 02 00 00 	add    $0x228,%rdi
    399c:	eb 21                	jmp    39bf <fwp_main_thread+0x146f>
    399e:	40 80 fe 01          	cmp    $0x1,%sil
    39a2:	75 40                	jne    39e4 <fwp_main_thread+0x1494>
    39a4:	48 8d 34 11          	lea    (%rcx,%rdx,1),%rsi
    39a8:	8b 4c 11 20          	mov    0x20(%rcx,%rdx,1),%ecx
    39ac:	48 0f af c1          	imul   %rcx,%rax
    39b0:	48 c1 e8 20          	shr    $0x20,%rax
    39b4:	48 8d 3c 30          	lea    (%rax,%rsi,1),%rdi
    39b8:	48 81 c7 28 02 00 00 	add    $0x228,%rdi
    39bf:	0f b6 07             	movzbl (%rdi),%eax
    39c2:	85 c0                	test   %eax,%eax
    39c4:	74 1e                	je     39e4 <fwp_main_thread+0x1494>
    39c6:	83 f8 01             	cmp    $0x1,%eax
    39c9:	75 0a                	jne    39d5 <fwp_main_thread+0x1485>
    39cb:	4c 89 f7             	mov    %r14,%rdi
    39ce:	e8 9d 6f 00 00       	call   a970 <fwp_rc_free_obj>
    39d3:	eb 0f                	jmp    39e4 <fwp_main_thread+0x1494>
    39d5:	3d ff 00 00 00       	cmp    $0xff,%eax
    39da:	0f 84 21 07 00 00    	je     4101 <fwp_main_thread+0x1bb1>
    39e0:	fe c8                	dec    %al
    39e2:	88 07                	mov    %al,(%rdi)
    39e4:	48 8d 35 65 e2 00 00 	lea    0xe265(%rip),%rsi        # 11c50 <d0>
    39eb:	31 db                	xor    %ebx,%ebx
    39ed:	31 ff                	xor    %edi,%edi
    39ef:	e8 1c 2b 00 00       	call   6510 <fwp_array_typed_new>
    39f4:	49 89 c6             	mov    %rax,%r14
    39f7:	31 ff                	xor    %edi,%edi
    39f9:	e8 d2 a6 00 00       	call   e0d0 <fwp_drop0>
    39fe:	48 b8 ff ff ff ff ff 	movabs $0x7fffffffffffffff,%rax
    3a05:	ff ff 7f 
    3a08:	4c 8d 78 01          	lea    0x1(%rax),%r15
    3a0c:	66 0f 57 c0          	xorpd  %xmm0,%xmm0
    3a10:	f2 0f 11 45 d0       	movsd  %xmm0,-0x30(%rbp)
    3a15:	45 31 ed             	xor    %r13d,%r13d
    3a18:	45 31 e4             	xor    %r12d,%r12d
    3a1b:	31 ff                	xor    %edi,%edi
    3a1d:	48 85 db             	test   %rbx,%rbx
    3a20:	78 3e                	js     3a60 <fwp_main_thread+0x1510>
    3a22:	66 66 66 66 66 2e 0f 	data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    3a29:	1f 84 00 00 00 00 00 
    3a30:	49 8b 06             	mov    (%r14),%rax
    3a33:	48 89 c1             	mov    %rax,%rcx
    3a36:	48 ba ff ff ff ff ff 	movabs $0x7fffffffffffffff,%rdx
    3a3d:	ff ff 7f 
    3a40:	48 21 d1             	and    %rdx,%rcx
    3a43:	48 39 cb             	cmp    %rcx,%rbx
    3a46:	73 18                	jae    3a60 <fwp_main_thread+0x1510>
    3a48:	48 85 c0             	test   %rax,%rax
    3a4b:	78 22                	js     3a6f <fwp_main_thread+0x151f>
    3a4d:	49 8d 46 08          	lea    0x8(%r14),%rax
    3a51:	eb 20                	jmp    3a73 <fwp_main_thread+0x1523>
    3a53:	66 66 66 66 2e 0f 1f 	data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    3a5a:	84 00 00 00 00 00 
    3a60:	4c 89 f7             	mov    %r14,%rdi
    3a63:	e8 38 6a 00 00       	call   a4a0 <fwp_drop1>
    3a68:	31 c0                	xor    %eax,%eax
    3a6a:	4c 89 ff             	mov    %r15,%rdi
    3a6d:	eb 32                	jmp    3aa1 <fwp_main_thread+0x1551>
    3a6f:	49 8b 46 10          	mov    0x10(%r14),%rax
    3a73:	f2 0f 10 04 d8       	movsd  (%rax,%rbx,8),%xmm0
    3a78:	48 ff c3             	inc    %rbx
    3a7b:	f2 0f 59 05 8d b5 00 	mulsd  0xb58d(%rip),%xmm0        # f010 <_IO_stdin_used+0x10>
    3a82:	00 
    3a83:	f2 0f 58 05 8d b5 00 	addsd  0xb58d(%rip),%xmm0        # f018 <_IO_stdin_used+0x18>
    3a8a:	00 
    3a8b:	66 49 0f 6e cf       	movq   %r15,%xmm1
    3a90:	f2 0f 58 c8          	addsd  %xmm0,%xmm1
    3a94:	f2 0f 11 4d d0       	movsd  %xmm1,-0x30(%rbp)
    3a99:	b0 01                	mov    $0x1,%al
    3a9b:	4d 89 f5             	mov    %r14,%r13
    3a9e:	4d 89 f4             	mov    %r14,%r12
    3aa1:	84 c0                	test   %al,%al
    3aa3:	74 18                	je     3abd <fwp_main_thread+0x156d>
    3aa5:	f3 0f 7e 45 d0       	movq   -0x30(%rbp),%xmm0
    3aaa:	66 49 0f 7e c7       	movq   %xmm0,%r15
    3aaf:	4d 89 ee             	mov    %r13,%r14
    3ab2:	48 85 db             	test   %rbx,%rbx
    3ab5:	0f 89 75 ff ff ff    	jns    3a30 <fwp_main_thread+0x14e0>
    3abb:	eb a3                	jmp    3a60 <fwp_main_thread+0x1510>
    3abd:	48 8d 35 8c e1 00 00 	lea    0xe18c(%rip),%rsi        # 11c50 <d0>
    3ac4:	e8 d7 3c 00 00       	call   77a0 <fwp_show>
    3ac9:	49 89 c6             	mov    %rax,%r14
    3acc:	48 2b 05 dd f6 00 00 	sub    0xf6dd(%rip),%rax        # 131b0 <fwp_gc+0x1030>
    3ad3:	48 8b 0d fe f6 00 00 	mov    0xf6fe(%rip),%rcx        # 131d8 <fwp_gc+0x1058>
    3ada:	48 c1 e1 10          	shl    $0x10,%rcx
    3ade:	48 39 c8             	cmp    %rcx,%rax
    3ae1:	73 6f                	jae    3b52 <fwp_main_thread+0x1602>
    3ae3:	48 8b 0d 0e f7 00 00 	mov    0xf70e(%rip),%rcx        # 131f8 <fwp_gc+0x1078>
    3aea:	48 89 c2             	mov    %rax,%rdx
    3aed:	48 c1 ea 10          	shr    $0x10,%rdx
    3af1:	48 69 d2 28 12 00 00 	imul   $0x1228,%rdx,%rdx
    3af8:	0f b6 34 11          	movzbl (%rcx,%rdx,1),%esi
    3afc:	48 25 ff ff 00 00    	and    $0xffff,%rax
    3b02:	75 1d                	jne    3b21 <fwp_main_thread+0x15d1>
    3b04:	40 80 fe 02          	cmp    $0x2,%sil
    3b08:	75 17                	jne    3b21 <fwp_main_thread+0x15d1>
    3b0a:	4c 8d 3c 11          	lea    (%rcx,%rdx,1),%r15
    3b0e:	49 81 c7 28 02 00 00 	add    $0x228,%r15
    3b15:	41 80 3f ff          	cmpb   $0xff,(%r15)
    3b19:	74 2d                	je     3b48 <fwp_main_thread+0x15f8>
    3b1b:	41 c6 07 01          	movb   $0x1,(%r15)
    3b1f:	eb 31                	jmp    3b52 <fwp_main_thread+0x1602>
    3b21:	40 80 fe 01          	cmp    $0x1,%sil
    3b25:	75 2b                	jne    3b52 <fwp_main_thread+0x1602>
    3b27:	48 8d 34 11          	lea    (%rcx,%rdx,1),%rsi
    3b2b:	8b 4c 11 20          	mov    0x20(%rcx,%rdx,1),%ecx
    3b2f:	48 0f af c1          	imul   %rcx,%rax
    3b33:	48 c1 e8 20          	shr    $0x20,%rax
    3b37:	4c 8d 3c 30          	lea    (%rax,%rsi,1),%r15
    3b3b:	49 81 c7 28 02 00 00 	add    $0x228,%r15
    3b42:	41 80 3f ff          	cmpb   $0xff,(%r15)
    3b46:	75 d3                	jne    3b1b <fwp_main_thread+0x15cb>
    3b48:	4c 89 ff             	mov    %r15,%rdi
    3b4b:	e8 10 28 00 00       	call   6360 <fwp_rc_forget_slot>
    3b50:	eb c9                	jmp    3b1b <fwp_main_thread+0x15cb>
    3b52:	4c 89 f7             	mov    %r14,%rdi
    3b55:	48 83 c7 08          	add    $0x8,%rdi
    3b59:	49 8b 16             	mov    (%r14),%rdx
    3b5c:	48 8b 0d 65 00 01 00 	mov    0x10065(%rip),%rcx        # 13bc8 <fwp_prog_out>
    3b63:	be 01 00 00 00       	mov    $0x1,%esi
    3b68:	e8 33 e7 ff ff       	call   22a0 <fwrite@plt>
    3b6d:	48 8b 35 54 00 01 00 	mov    0x10054(%rip),%rsi        # 13bc8 <fwp_prog_out>
    3b74:	bf 0a 00 00 00       	mov    $0xa,%edi
    3b79:	e8 c2 e5 ff ff       	call   2140 <fputc@plt>
    3b7e:	4c 89 f0             	mov    %r14,%rax
    3b81:	48 2b 05 28 f6 00 00 	sub    0xf628(%rip),%rax        # 131b0 <fwp_gc+0x1030>
    3b88:	48 8b 0d 49 f6 00 00 	mov    0xf649(%rip),%rcx        # 131d8 <fwp_gc+0x1058>
    3b8f:	48 c1 e1 10          	shl    $0x10,%rcx
    3b93:	48 39 c8             	cmp    %rcx,%rax
    3b96:	73 7a                	jae    3c12 <fwp_main_thread+0x16c2>
    3b98:	48 8b 0d 59 f6 00 00 	mov    0xf659(%rip),%rcx        # 131f8 <fwp_gc+0x1078>
    3b9f:	48 89 c2             	mov    %rax,%rdx
    3ba2:	48 c1 ea 10          	shr    $0x10,%rdx
    3ba6:	48 69 d2 28 12 00 00 	imul   $0x1228,%rdx,%rdx
    3bad:	0f b6 34 11          	movzbl (%rcx,%rdx,1),%esi
    3bb1:	48 25 ff ff 00 00    	and    $0xffff,%rax
    3bb7:	75 13                	jne    3bcc <fwp_main_thread+0x167c>
    3bb9:	40 80 fe 02          	cmp    $0x2,%sil
    3bbd:	75 0d                	jne    3bcc <fwp_main_thread+0x167c>
    3bbf:	48 8d 3c 11          	lea    (%rcx,%rdx,1),%rdi
    3bc3:	48 81 c7 28 02 00 00 	add    $0x228,%rdi
    3bca:	eb 21                	jmp    3bed <fwp_main_thread+0x169d>
    3bcc:	40 80 fe 01          	cmp    $0x1,%sil
    3bd0:	75 40                	jne    3c12 <fwp_main_thread+0x16c2>
    3bd2:	48 8d 34 11          	lea    (%rcx,%rdx,1),%rsi
    3bd6:	8b 4c 11 20          	mov    0x20(%rcx,%rdx,1),%ecx
    3bda:	48 0f af c1          	imul   %rcx,%rax
    3bde:	48 c1 e8 20          	shr    $0x20,%rax
    3be2:	48 8d 3c 30          	lea    (%rax,%rsi,1),%rdi
    3be6:	48 81 c7 28 02 00 00 	add    $0x228,%rdi
    3bed:	0f b6 07             	movzbl (%rdi),%eax
    3bf0:	85 c0                	test   %eax,%eax
    3bf2:	74 1e                	je     3c12 <fwp_main_thread+0x16c2>
    3bf4:	83 f8 01             	cmp    $0x1,%eax
    3bf7:	75 0a                	jne    3c03 <fwp_main_thread+0x16b3>
    3bf9:	4c 89 f7             	mov    %r14,%rdi
    3bfc:	e8 6f 6d 00 00       	call   a970 <fwp_rc_free_obj>
    3c01:	eb 0f                	jmp    3c12 <fwp_main_thread+0x16c2>
    3c03:	3d ff 00 00 00       	cmp    $0xff,%eax
    3c08:	0f 84 fd 04 00 00    	je     410b <fwp_main_thread+0x1bbb>
    3c0e:	fe c8                	dec    %al
    3c10:	88 07                	mov    %al,(%rdi)
    3c12:	66 0f 57 c0          	xorpd  %xmm0,%xmm0
    3c16:	66 0f 29 85 00 fe ff 	movapd %xmm0,-0x200(%rbp)
    3c1d:	ff 
    3c1e:	48 8d 95 00 fe ff ff 	lea    -0x200(%rbp),%rdx
    3c25:	bf 01 00 00 00       	mov    $0x1,%edi
    3c2a:	be 02 00 00 00       	mov    $0x2,%esi
    3c2f:	e8 fc 61 00 00       	call   9e30 <fwp_data>
    3c34:	48 89 c1             	mov    %rax,%rcx
    3c37:	48 2b 0d 72 f5 00 00 	sub    0xf572(%rip),%rcx        # 131b0 <fwp_gc+0x1030>
    3c3e:	48 8b 15 93 f5 00 00 	mov    0xf593(%rip),%rdx        # 131d8 <fwp_gc+0x1058>
    3c45:	48 c1 e2 10          	shl    $0x10,%rdx
    3c49:	48 39 d1             	cmp    %rdx,%rcx
    3c4c:	73 76                	jae    3cc4 <fwp_main_thread+0x1774>
    3c4e:	48 8b 15 a3 f5 00 00 	mov    0xf5a3(%rip),%rdx        # 131f8 <fwp_gc+0x1078>
    3c55:	48 89 ce             	mov    %rcx,%rsi
    3c58:	48 c1 ee 10          	shr    $0x10,%rsi
    3c5c:	48 69 f6 28 12 00 00 	imul   $0x1228,%rsi,%rsi
    3c63:	0f b6 3c 32          	movzbl (%rdx,%rsi,1),%edi
    3c67:	48 81 e1 ff ff 00 00 	and    $0xffff,%rcx
    3c6e:	75 1d                	jne    3c8d <fwp_main_thread+0x173d>
    3c70:	40 80 ff 02          	cmp    $0x2,%dil
    3c74:	75 17                	jne    3c8d <fwp_main_thread+0x173d>
    3c76:	4c 8d 34 32          	lea    (%rdx,%rsi,1),%r14
    3c7a:	49 81 c6 28 02 00 00 	add    $0x228,%r14
    3c81:	41 80 3e ff          	cmpb   $0xff,(%r14)
    3c85:	74 2d                	je     3cb4 <fwp_main_thread+0x1764>
    3c87:	41 c6 06 01          	movb   $0x1,(%r14)
    3c8b:	eb 37                	jmp    3cc4 <fwp_main_thread+0x1774>
    3c8d:	40 80 ff 01          	cmp    $0x1,%dil
    3c91:	75 31                	jne    3cc4 <fwp_main_thread+0x1774>
    3c93:	48 8d 3c 32          	lea    (%rdx,%rsi,1),%rdi
    3c97:	8b 54 32 20          	mov    0x20(%rdx,%rsi,1),%edx
    3c9b:	48 0f af ca          	imul   %rdx,%rcx
    3c9f:	48 c1 e9 20          	shr    $0x20,%rcx
    3ca3:	4c 8d 34 39          	lea    (%rcx,%rdi,1),%r14
    3ca7:	49 81 c6 28 02 00 00 	add    $0x228,%r14
    3cae:	41 80 3e ff          	cmpb   $0xff,(%r14)
    3cb2:	75 d3                	jne    3c87 <fwp_main_thread+0x1737>
    3cb4:	4c 89 f7             	mov    %r14,%rdi
    3cb7:	48 89 c3             	mov    %rax,%rbx
    3cba:	e8 a1 26 00 00       	call   6360 <fwp_rc_forget_slot>
    3cbf:	48 89 d8             	mov    %rbx,%rax
    3cc2:	eb c3                	jmp    3c87 <fwp_main_thread+0x1737>
    3cc4:	48 c7 85 60 ff ff ff 	movq   $0x0,-0xa0(%rbp)
    3ccb:	00 00 00 00 
    3ccf:	48 89 85 68 ff ff ff 	mov    %rax,-0x98(%rbp)
    3cd6:	48 8d 95 60 ff ff ff 	lea    -0xa0(%rbp),%rdx
    3cdd:	bf 01 00 00 00       	mov    $0x1,%edi
    3ce2:	be 02 00 00 00       	mov    $0x2,%esi
    3ce7:	e8 44 61 00 00       	call   9e30 <fwp_data>
    3cec:	48 89 c1             	mov    %rax,%rcx
    3cef:	48 2b 0d ba f4 00 00 	sub    0xf4ba(%rip),%rcx        # 131b0 <fwp_gc+0x1030>
    3cf6:	48 8b 15 db f4 00 00 	mov    0xf4db(%rip),%rdx        # 131d8 <fwp_gc+0x1058>
    3cfd:	48 c1 e2 10          	shl    $0x10,%rdx
    3d01:	48 39 d1             	cmp    %rdx,%rcx
    3d04:	73 76                	jae    3d7c <fwp_main_thread+0x182c>
    3d06:	48 8b 15 eb f4 00 00 	mov    0xf4eb(%rip),%rdx        # 131f8 <fwp_gc+0x1078>
    3d0d:	48 89 ce             	mov    %rcx,%rsi
    3d10:	48 c1 ee 10          	shr    $0x10,%rsi
    3d14:	48 69 f6 28 12 00 00 	imul   $0x1228,%rsi,%rsi
    3d1b:	0f b6 3c 32          	movzbl (%rdx,%rsi,1),%edi
    3d1f:	48 81 e1 ff ff 00 00 	and    $0xffff,%rcx
    3d26:	75 1d                	jne    3d45 <fwp_main_thread+0x17f5>
    3d28:	40 80 ff 02          	cmp    $0x2,%dil
    3d2c:	75 17                	jne    3d45 <fwp_main_thread+0x17f5>
    3d2e:	4c 8d 34 32          	lea    (%rdx,%rsi,1),%r14
    3d32:	49 81 c6 28 02 00 00 	add    $0x228,%r14
    3d39:	41 80 3e ff          	cmpb   $0xff,(%r14)
    3d3d:	74 2d                	je     3d6c <fwp_main_thread+0x181c>
    3d3f:	41 c6 06 01          	movb   $0x1,(%r14)
    3d43:	eb 37                	jmp    3d7c <fwp_main_thread+0x182c>
    3d45:	40 80 ff 01          	cmp    $0x1,%dil
    3d49:	75 31                	jne    3d7c <fwp_main_thread+0x182c>
    3d4b:	48 8d 3c 32          	lea    (%rdx,%rsi,1),%rdi
    3d4f:	8b 54 32 20          	mov    0x20(%rdx,%rsi,1),%edx
    3d53:	48 0f af ca          	imul   %rdx,%rcx
    3d57:	48 c1 e9 20          	shr    $0x20,%rcx
    3d5b:	4c 8d 34 39          	lea    (%rcx,%rdi,1),%r14
    3d5f:	49 81 c6 28 02 00 00 	add    $0x228,%r14
    3d66:	41 80 3e ff          	cmpb   $0xff,(%r14)
    3d6a:	75 d3                	jne    3d3f <fwp_main_thread+0x17ef>
    3d6c:	4c 89 f7             	mov    %r14,%rdi
    3d6f:	48 89 c3             	mov    %rax,%rbx
    3d72:	e8 e9 25 00 00       	call   6360 <fwp_rc_forget_slot>
    3d77:	48 89 d8             	mov    %rbx,%rax
    3d7a:	eb c3                	jmp    3d3f <fwp_main_thread+0x17ef>
    3d7c:	48 c7 85 70 ff ff ff 	movq   $0x0,-0x90(%rbp)
    3d83:	00 00 00 00 
    3d87:	48 89 85 78 ff ff ff 	mov    %rax,-0x88(%rbp)
    3d8e:	48 8d 95 70 ff ff ff 	lea    -0x90(%rbp),%rdx
    3d95:	bf 01 00 00 00       	mov    $0x1,%edi
    3d9a:	be 02 00 00 00       	mov    $0x2,%esi
    3d9f:	e8 8c 60 00 00       	call   9e30 <fwp_data>
    3da4:	48 89 c1             	mov    %rax,%rcx
    3da7:	48 2b 0d 02 f4 00 00 	sub    0xf402(%rip),%rcx        # 131b0 <fwp_gc+0x1030>
    3dae:	48 8b 15 23 f4 00 00 	mov    0xf423(%rip),%rdx        # 131d8 <fwp_gc+0x1058>
    3db5:	48 c1 e2 10          	shl    $0x10,%rdx
    3db9:	48 39 d1             	cmp    %rdx,%rcx
    3dbc:	73 76                	jae    3e34 <fwp_main_thread+0x18e4>
    3dbe:	48 8b 15 33 f4 00 00 	mov    0xf433(%rip),%rdx        # 131f8 <fwp_gc+0x1078>
    3dc5:	48 89 ce             	mov    %rcx,%rsi
    3dc8:	48 c1 ee 10          	shr    $0x10,%rsi
    3dcc:	48 69 f6 28 12 00 00 	imul   $0x1228,%rsi,%rsi
    3dd3:	0f b6 3c 32          	movzbl (%rdx,%rsi,1),%edi
    3dd7:	48 81 e1 ff ff 00 00 	and    $0xffff,%rcx
    3dde:	75 1d                	jne    3dfd <fwp_main_thread+0x18ad>
    3de0:	40 80 ff 02          	cmp    $0x2,%dil
    3de4:	75 17                	jne    3dfd <fwp_main_thread+0x18ad>
    3de6:	4c 8d 34 32          	lea    (%rdx,%rsi,1),%r14
    3dea:	49 81 c6 28 02 00 00 	add    $0x228,%r14
    3df1:	41 80 3e ff          	cmpb   $0xff,(%r14)
    3df5:	74 2d                	je     3e24 <fwp_main_thread+0x18d4>
    3df7:	41 c6 06 01          	movb   $0x1,(%r14)
    3dfb:	eb 37                	jmp    3e34 <fwp_main_thread+0x18e4>
    3dfd:	40 80 ff 01          	cmp    $0x1,%dil
    3e01:	75 31                	jne    3e34 <fwp_main_thread+0x18e4>
    3e03:	48 8d 3c 32          	lea    (%rdx,%rsi,1),%rdi
    3e07:	8b 54 32 20          	mov    0x20(%rdx,%rsi,1),%edx
    3e0b:	48 0f af ca          	imul   %rdx,%rcx
    3e0f:	48 c1 e9 20          	shr    $0x20,%rcx
    3e13:	4c 8d 34 39          	lea    (%rcx,%rdi,1),%r14
    3e17:	49 81 c6 28 02 00 00 	add    $0x228,%r14
    3e1e:	41 80 3e ff          	cmpb   $0xff,(%r14)
    3e22:	75 d3                	jne    3df7 <fwp_main_thread+0x18a7>
    3e24:	4c 89 f7             	mov    %r14,%rdi
    3e27:	48 89 c3             	mov    %rax,%rbx
    3e2a:	e8 31 25 00 00       	call   6360 <fwp_rc_forget_slot>
    3e2f:	48 89 d8             	mov    %rbx,%rax
    3e32:	eb c3                	jmp    3df7 <fwp_main_thread+0x18a7>
    3e34:	48 c7 45 80 00 00 00 	movq   $0x0,-0x80(%rbp)
    3e3b:	00 
    3e3c:	48 89 45 88          	mov    %rax,-0x78(%rbp)
    3e40:	48 8d 55 80          	lea    -0x80(%rbp),%rdx
    3e44:	bf 01 00 00 00       	mov    $0x1,%edi
    3e49:	be 02 00 00 00       	mov    $0x2,%esi
    3e4e:	e8 dd 5f 00 00       	call   9e30 <fwp_data>
    3e53:	48 89 c1             	mov    %rax,%rcx
    3e56:	48 2b 0d 53 f3 00 00 	sub    0xf353(%rip),%rcx        # 131b0 <fwp_gc+0x1030>
    3e5d:	48 8b 15 74 f3 00 00 	mov    0xf374(%rip),%rdx        # 131d8 <fwp_gc+0x1058>
    3e64:	48 c1 e2 10          	shl    $0x10,%rdx
    3e68:	48 39 d1             	cmp    %rdx,%rcx
    3e6b:	73 76                	jae    3ee3 <fwp_main_thread+0x1993>
    3e6d:	48 8b 15 84 f3 00 00 	mov    0xf384(%rip),%rdx        # 131f8 <fwp_gc+0x1078>
    3e74:	48 89 ce             	mov    %rcx,%rsi
    3e77:	48 c1 ee 10          	shr    $0x10,%rsi
    3e7b:	48 69 f6 28 12 00 00 	imul   $0x1228,%rsi,%rsi
    3e82:	0f b6 3c 32          	movzbl (%rdx,%rsi,1),%edi
    3e86:	48 81 e1 ff ff 00 00 	and    $0xffff,%rcx
    3e8d:	75 1d                	jne    3eac <fwp_main_thread+0x195c>
    3e8f:	40 80 ff 02          	cmp    $0x2,%dil
    3e93:	75 17                	jne    3eac <fwp_main_thread+0x195c>
    3e95:	4c 8d 34 32          	lea    (%rdx,%rsi,1),%r14
    3e99:	49 81 c6 28 02 00 00 	add    $0x228,%r14
    3ea0:	41 80 3e ff          	cmpb   $0xff,(%r14)
    3ea4:	74 2d                	je     3ed3 <fwp_main_thread+0x1983>
    3ea6:	41 c6 06 01          	movb   $0x1,(%r14)
    3eaa:	eb 37                	jmp    3ee3 <fwp_main_thread+0x1993>
    3eac:	40 80 ff 01          	cmp    $0x1,%dil
    3eb0:	75 31                	jne    3ee3 <fwp_main_thread+0x1993>
    3eb2:	48 8d 3c 32          	lea    (%rdx,%rsi,1),%rdi
    3eb6:	8b 54 32 20          	mov    0x20(%rdx,%rsi,1),%edx
    3eba:	48 0f af ca          	imul   %rdx,%rcx
    3ebe:	48 c1 e9 20          	shr    $0x20,%rcx
    3ec2:	4c 8d 34 39          	lea    (%rcx,%rdi,1),%r14
    3ec6:	49 81 c6 28 02 00 00 	add    $0x228,%r14
    3ecd:	41 80 3e ff          	cmpb   $0xff,(%r14)
    3ed1:	75 d3                	jne    3ea6 <fwp_main_thread+0x1956>
    3ed3:	4c 89 f7             	mov    %r14,%rdi
    3ed6:	48 89 c3             	mov    %rax,%rbx
    3ed9:	e8 82 24 00 00       	call   6360 <fwp_rc_forget_slot>
    3ede:	48 89 d8             	mov    %rbx,%rax
    3ee1:	eb c3                	jmp    3ea6 <fwp_main_thread+0x1956>
    3ee3:	48 c7 45 90 00 00 00 	movq   $0x0,-0x70(%rbp)
    3eea:	00 
    3eeb:	48 89 45 98          	mov    %rax,-0x68(%rbp)
    3eef:	48 8d 55 90          	lea    -0x70(%rbp),%rdx
    3ef3:	bf 01 00 00 00       	mov    $0x1,%edi
    3ef8:	be 02 00 00 00       	mov    $0x2,%esi
    3efd:	e8 2e 5f 00 00       	call   9e30 <fwp_data>
    3f02:	48 89 c1             	mov    %rax,%rcx
    3f05:	48 2b 0d a4 f2 00 00 	sub    0xf2a4(%rip),%rcx        # 131b0 <fwp_gc+0x1030>
    3f0c:	48 8b 15 c5 f2 00 00 	mov    0xf2c5(%rip),%rdx        # 131d8 <fwp_gc+0x1058>
    3f13:	48 c1 e2 10          	shl    $0x10,%rdx
    3f17:	48 39 d1             	cmp    %rdx,%rcx
    3f1a:	0f 83 30 01 00 00    	jae    4050 <fwp_main_thread+0x1b00>
    3f20:	48 8b 35 d1 f2 00 00 	mov    0xf2d1(%rip),%rsi        # 131f8 <fwp_gc+0x1078>
    3f27:	48 89 cf             	mov    %rcx,%rdi
    3f2a:	48 c1 ef 10          	shr    $0x10,%rdi
    3f2e:	4c 69 c7 28 12 00 00 	imul   $0x1228,%rdi,%r8
    3f35:	46 0f b6 0c 06       	movzbl (%rsi,%r8,1),%r9d
    3f3a:	48 89 cf             	mov    %rcx,%rdi
    3f3d:	48 81 e7 ff ff 00 00 	and    $0xffff,%rdi
    3f44:	75 35                	jne    3f7b <fwp_main_thread+0x1a2b>
    3f46:	41 80 f9 02          	cmp    $0x2,%r9b
    3f4a:	75 2f                	jne    3f7b <fwp_main_thread+0x1a2b>
    3f4c:	4e 8d 34 06          	lea    (%rsi,%r8,1),%r14
    3f50:	49 81 c6 28 02 00 00 	add    $0x228,%r14
    3f57:	41 80 3e ff          	cmpb   $0xff,(%r14)
    3f5b:	74 4a                	je     3fa7 <fwp_main_thread+0x1a57>
    3f5d:	41 c6 06 01          	movb   $0x1,(%r14)
    3f61:	48 8b 15 70 f2 00 00 	mov    0xf270(%rip),%rdx        # 131d8 <fwp_gc+0x1058>
    3f68:	48 89 c1             	mov    %rax,%rcx
    3f6b:	48 2b 0d 3e f2 00 00 	sub    0xf23e(%rip),%rcx        # 131b0 <fwp_gc+0x1030>
    3f72:	48 c1 e2 10          	shl    $0x10,%rdx
    3f76:	e9 d5 00 00 00       	jmp    4050 <fwp_main_thread+0x1b00>
    3f7b:	41 80 f9 01          	cmp    $0x1,%r9b
    3f7f:	0f 85 cb 00 00 00    	jne    4050 <fwp_main_thread+0x1b00>
    3f85:	4a 8d 0c 06          	lea    (%rsi,%r8,1),%rcx
    3f89:	42 8b 54 06 20       	mov    0x20(%rsi,%r8,1),%edx
    3f8e:	48 0f af fa          	imul   %rdx,%rdi
    3f92:	48 c1 ef 20          	shr    $0x20,%rdi
    3f96:	4c 8d 34 0f          	lea    (%rdi,%rcx,1),%r14
    3f9a:	49 81 c6 28 02 00 00 	add    $0x228,%r14
    3fa1:	41 80 3e ff          	cmpb   $0xff,(%r14)
    3fa5:	75 b6                	jne    3f5d <fwp_main_thread+0x1a0d>
    3fa7:	4c 89 f7             	mov    %r14,%rdi
    3faa:	48 89 c3             	mov    %rax,%rbx
    3fad:	e8 ae 23 00 00       	call   6360 <fwp_rc_forget_slot>
    3fb2:	48 89 d8             	mov    %rbx,%rax
    3fb5:	eb a6                	jmp    3f5d <fwp_main_thread+0x1a0d>
    3fb7:	66 0f 1f 84 00 00 00 	nopw   0x0(%rax,%rax,1)
    3fbe:	00 00 
    3fc0:	48 8b 15 31 f2 00 00 	mov    0xf231(%rip),%rdx        # 131f8 <fwp_gc+0x1078>
    3fc7:	48 89 ce             	mov    %rcx,%rsi
    3fca:	48 c1 ee 10          	shr    $0x10,%rsi
    3fce:	48 69 f6 28 12 00 00 	imul   $0x1228,%rsi,%rsi
    3fd5:	0f b6 3c 32          	movzbl (%rdx,%rsi,1),%edi
    3fd9:	48 81 e1 ff ff 00 00 	and    $0xffff,%rcx
    3fe0:	75 13                	jne    3ff5 <fwp_main_thread+0x1aa5>
    3fe2:	40 80 ff 02          	cmp    $0x2,%dil
    3fe6:	75 0d                	jne    3ff5 <fwp_main_thread+0x1aa5>
    3fe8:	48 8d 3c 32          	lea    (%rdx,%rsi,1),%rdi
    3fec:	48 81 c7 28 02 00 00 	add    $0x228,%rdi
    3ff3:	eb 20                	jmp    4015 <fwp_main_thread+0x1ac5>
    3ff5:	40 80 ff 01          	cmp    $0x1,%dil
    3ff9:	75 6c                	jne    4067 <fwp_main_thread+0x1b17>
    3ffb:	48 8d 3c 32          	lea    (%rdx,%rsi,1),%rdi
    3fff:	8b 54 32 20          	mov    0x20(%rdx,%rsi,1),%edx
    4003:	48 0f af ca          	imul   %rdx,%rcx
    4007:	48 c1 e9 20          	shr    $0x20,%rcx
    400b:	48 01 cf             	add    %rcx,%rdi
    400e:	48 81 c7 28 02 00 00 	add    $0x228,%rdi
    4015:	0f b6 0f             	movzbl (%rdi),%ecx
    4018:	85 c9                	test   %ecx,%ecx
    401a:	74 4b                	je     4067 <fwp_main_thread+0x1b17>
    401c:	83 f9 01             	cmp    $0x1,%ecx
    401f:	75 3a                	jne    405b <fwp_main_thread+0x1b0b>
    4021:	48 8b 58 10          	mov    0x10(%rax),%rbx
    4025:	48 89 c7             	mov    %rax,%rdi
    4028:	e8 43 69 00 00       	call   a970 <fwp_rc_free_obj>
    402d:	48 89 d9             	mov    %rbx,%rcx
    4030:	48 2b 0d 79 f1 00 00 	sub    0xf179(%rip),%rcx        # 131b0 <fwp_gc+0x1030>
    4037:	48 8b 15 9a f1 00 00 	mov    0xf19a(%rip),%rdx        # 131d8 <fwp_gc+0x1058>
    403e:	48 c1 e2 10          	shl    $0x10,%rdx
    4042:	48 89 d8             	mov    %rbx,%rax
    4045:	66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
    404c:	00 00 00 00 
    4050:	48 39 d1             	cmp    %rdx,%rcx
    4053:	0f 82 67 ff ff ff    	jb     3fc0 <fwp_main_thread+0x1a70>
    4059:	eb 0c                	jmp    4067 <fwp_main_thread+0x1b17>
    405b:	81 f9 ff 00 00 00    	cmp    $0xff,%ecx
    4061:	74 79                	je     40dc <fwp_main_thread+0x1b8c>
    4063:	fe c9                	dec    %cl
    4065:	88 0f                	mov    %cl,(%rdi)
    4067:	c6 05 a2 fb 01 00 01 	movb   $0x1,0x1fba2(%rip)        # 23c10 <caf0.st>
    406e:	48 8b 05 0b e1 00 00 	mov    0xe10b(%rip),%rax        # 12180 <fwp_gc>
    4075:	48 8b 55 b0          	mov    -0x50(%rbp),%rdx
    4079:	48 83 3d d7 f2 00 00 	cmpq   $0x0,0xf2d7(%rip)        # 13358 <fwp_gc+0x11d8>
    4080:	00 
    4081:	0f 85 ec 00 00 00    	jne    4173 <fwp_main_thread+0x1c23>
    4087:	83 3d e2 f0 00 00 00 	cmpl   $0x0,0xf0e2(%rip)        # 13170 <fwp_gc+0xff0>
    408e:	0f 85 df 00 00 00    	jne    4173 <fwp_main_thread+0x1c23>
    4094:	48 39 c2             	cmp    %rax,%rdx
    4097:	0f 8f d6 00 00 00    	jg     4173 <fwp_main_thread+0x1c23>
    409d:	66 0f 57 c0          	xorpd  %xmm0,%xmm0
    40a1:	66 0f 2e 05 df f2 00 	ucomisd 0xf2df(%rip),%xmm0        # 13388 <fwp_gc+0x1208>
    40a8:	00 
    40a9:	0f 83 c4 00 00 00    	jae    4173 <fwp_main_thread+0x1c23>
    40af:	48 8b 05 0a df 00 00 	mov    0xdf0a(%rip),%rax        # 11fc0 <stdout@GLIBC_2.2.5>
    40b6:	48 8b 38             	mov    (%rax),%rdi
    40b9:	e8 42 e1 ff ff       	call   2200 <fflush@plt>
    40be:	31 c0                	xor    %eax,%eax
    40c0:	48 81 c4 d8 01 00 00 	add    $0x1d8,%rsp
    40c7:	5b                   	pop    %rbx
    40c8:	41 5c                	pop    %r12
    40ca:	41 5d                	pop    %r13
    40cc:	41 5e                	pop    %r14
    40ce:	41 5f                	pop    %r15
    40d0:	5d                   	pop    %rbp
    40d1:	c3                   	ret
    40d2:	e8 b9 65 00 00       	call   a690 <fwp_rc_wide_drop>
    40d7:	e9 f8 ee ff ff       	jmp    2fd4 <fwp_main_thread+0xa84>
    40dc:	e8 af 65 00 00       	call   a690 <fwp_rc_wide_drop>
    40e1:	eb 84                	jmp    4067 <fwp_main_thread+0x1b17>
    40e3:	e8 a8 65 00 00       	call   a690 <fwp_rc_wide_drop>
    40e8:	e9 35 eb ff ff       	jmp    2c22 <fwp_main_thread+0x6d2>
    40ed:	e8 9e 65 00 00       	call   a690 <fwp_rc_wide_drop>
    40f2:	e9 bd f0 ff ff       	jmp    31b4 <fwp_main_thread+0xc64>
    40f7:	e8 94 65 00 00       	call   a690 <fwp_rc_wide_drop>
    40fc:	e9 c8 f4 ff ff       	jmp    35c9 <fwp_main_thread+0x1079>
    4101:	e8 8a 65 00 00       	call   a690 <fwp_rc_wide_drop>
    4106:	e9 d9 f8 ff ff       	jmp    39e4 <fwp_main_thread+0x1494>
    410b:	e8 80 65 00 00       	call   a690 <fwp_rc_wide_drop>
    4110:	e9 fd fa ff ff       	jmp    3c12 <fwp_main_thread+0x16c2>
    4115:	48 8d 15 6f b5 00 00 	lea    0xb56f(%rip),%rdx        # f68b <fwp_segv.msg+0x44b>
    411c:	48 8d 0d 80 b4 00 00 	lea    0xb480(%rip),%rcx        # f5a3 <fwp_segv.msg+0x363>
    4123:	eb 0e                	jmp    4133 <fwp_main_thread+0x1be3>
    4125:	48 8d 15 5f b5 00 00 	lea    0xb55f(%rip),%rdx        # f68b <fwp_segv.msg+0x44b>
    412c:	48 8d 0d 72 b5 00 00 	lea    0xb572(%rip),%rcx        # f6a5 <fwp_segv.msg+0x465>
    4133:	48 8d 9d 00 fe ff ff 	lea    -0x200(%rbp),%rbx
    413a:	be 60 00 00 00       	mov    $0x60,%esi
    413f:	48 89 df             	mov    %rbx,%rdi
    4142:	31 c0                	xor    %eax,%eax
    4144:	e8 c7 df ff ff       	call   2110 <snprintf@plt>
    4149:	e8 e2 21 00 00       	call   6330 <fwp_flush>
    414e:	48 8b 05 8b de 00 00 	mov    0xde8b(%rip),%rax        # 11fe0 <stderr@GLIBC_2.2.5>
    4155:	48 8b 38             	mov    (%rax),%rdi
    4158:	48 8d 35 ce b2 00 00 	lea    0xb2ce(%rip),%rsi        # f42d <fwp_segv.msg+0x1ed>
    415f:	48 89 da             	mov    %rbx,%rdx
    4162:	31 c0                	xor    %eax,%eax
    4164:	e8 47 e0 ff ff       	call   21b0 <fprintf@plt>
    4169:	bf 65 00 00 00       	mov    $0x65,%edi
    416e:	e8 1d e1 ff ff       	call   2290 <exit@plt>
    4173:	48 8b 0d 66 de 00 00 	mov    0xde66(%rip),%rcx        # 11fe0 <stderr@GLIBC_2.2.5>
    417a:	48 8b 39             	mov    (%rcx),%rdi
    417d:	48 29 c2             	sub    %rax,%rdx
    4180:	48 8d 35 8d b5 00 00 	lea    0xb58d(%rip),%rsi        # f714 <fwp_segv.msg+0x4d4>
    4187:	31 c0                	xor    %eax,%eax
    4189:	e8 22 e0 ff ff       	call   21b0 <fprintf@plt>
    418e:	bf c1 00 00 00       	mov    $0xc1,%edi
    4193:	e8 f8 e0 ff ff       	call   2290 <exit@plt>
    4198:	0f 1f 84 00 00 00 00 	nopl   0x0(%rax,%rax,1)
    419f:	00 

00000000000041a0 <e1>:
    41a0:	50                   	push   %rax
    41a1:	48 8b 3f             	mov    (%rdi),%rdi
    41a4:	48 89 f8             	mov    %rdi,%rax
    41a7:	48 2b 05 02 f0 00 00 	sub    0xf002(%rip),%rax        # 131b0 <fwp_gc+0x1030>
    41ae:	48 8b 0d 23 f0 00 00 	mov    0xf023(%rip),%rcx        # 131d8 <fwp_gc+0x1058>
    41b5:	48 c1 e1 10          	shl    $0x10,%rcx
    41b9:	48 39 c8             	cmp    %rcx,%rax
    41bc:	73 63                	jae    4221 <e1+0x81>
    41be:	48 8b 0d 33 f0 00 00 	mov    0xf033(%rip),%rcx        # 131f8 <fwp_gc+0x1078>
    41c5:	48 89 c2             	mov    %rax,%rdx
    41c8:	48 c1 ea 10          	shr    $0x10,%rdx
    41cc:	48 69 d2 28 12 00 00 	imul   $0x1228,%rdx,%rdx
    41d3:	0f b6 34 11          	movzbl (%rcx,%rdx,1),%esi
    41d7:	48 25 ff ff 00 00    	and    $0xffff,%rax
    41dd:	75 1a                	jne    41f9 <e1+0x59>
    41df:	40 80 fe 02          	cmp    $0x2,%sil
    41e3:	75 14                	jne    41f9 <e1+0x59>
    41e5:	48 8d 04 11          	lea    (%rcx,%rdx,1),%rax
    41e9:	48 05 28 02 00 00    	add    $0x228,%rax
    41ef:	80 38 00             	cmpb   $0x0,(%rax)
    41f2:	74 2d                	je     4221 <e1+0x81>
    41f4:	e9 af 00 00 00       	jmp    42a8 <e1+0x108>
    41f9:	40 80 fe 01          	cmp    $0x1,%sil
    41fd:	75 22                	jne    4221 <e1+0x81>
    41ff:	48 8d 34 11          	lea    (%rcx,%rdx,1),%rsi
    4203:	8b 4c 11 20          	mov    0x20(%rcx,%rdx,1),%ecx
    4207:	48 0f af c1          	imul   %rcx,%rax
    420b:	48 c1 e8 20          	shr    $0x20,%rax
    420f:	48 01 f0             	add    %rsi,%rax
    4212:	48 05 28 02 00 00    	add    $0x228,%rax
    4218:	80 38 00             	cmpb   $0x0,(%rax)
    421b:	0f 85 87 00 00 00    	jne    42a8 <e1+0x108>
    4221:	48 8d 35 28 da 00 00 	lea    0xda28(%rip),%rsi        # 11c50 <d0>
    4228:	e8 e3 21 00 00       	call   6410 <fwp_p_array_from_list_typed>
    422d:	48 89 c1             	mov    %rax,%rcx
    4230:	48 2b 0d 79 ef 00 00 	sub    0xef79(%rip),%rcx        # 131b0 <fwp_gc+0x1030>
    4237:	48 8b 15 9a ef 00 00 	mov    0xef9a(%rip),%rdx        # 131d8 <fwp_gc+0x1058>
    423e:	48 c1 e2 10          	shl    $0x10,%rdx
    4242:	48 39 d1             	cmp    %rdx,%rcx
    4245:	73 5f                	jae    42a6 <e1+0x106>
    4247:	48 8b 15 aa ef 00 00 	mov    0xefaa(%rip),%rdx        # 131f8 <fwp_gc+0x1078>
    424e:	48 89 ce             	mov    %rcx,%rsi
    4251:	48 c1 ee 10          	shr    $0x10,%rsi
    4255:	48 69 f6 28 12 00 00 	imul   $0x1228,%rsi,%rsi
    425c:	0f b6 3c 32          	movzbl (%rdx,%rsi,1),%edi
    4260:	48 81 e1 ff ff 00 00 	and    $0xffff,%rcx
    4267:	75 18                	jne    4281 <e1+0xe1>
    4269:	40 80 ff 02          	cmp    $0x2,%dil
    426d:	75 12                	jne    4281 <e1+0xe1>
    426f:	48 8d 0c 32          	lea    (%rdx,%rsi,1),%rcx
    4273:	48 81 c1 28 02 00 00 	add    $0x228,%rcx
    427a:	80 39 00             	cmpb   $0x0,(%rcx)
    427d:	74 27                	je     42a6 <e1+0x106>
    427f:	eb 27                	jmp    42a8 <e1+0x108>
    4281:	40 80 ff 01          	cmp    $0x1,%dil
    4285:	75 1f                	jne    42a6 <e1+0x106>
    4287:	48 8d 3c 32          	lea    (%rdx,%rsi,1),%rdi
    428b:	8b 54 32 20          	mov    0x20(%rdx,%rsi,1),%edx
    428f:	48 0f af ca          	imul   %rdx,%rcx
    4293:	48 c1 e9 20          	shr    $0x20,%rcx
    4297:	48 01 f9             	add    %rdi,%rcx
    429a:	48 81 c1 28 02 00 00 	add    $0x228,%rcx
    42a1:	80 39 00             	cmpb   $0x0,(%rcx)
    42a4:	75 02                	jne    42a8 <e1+0x108>
    42a6:	59                   	pop    %rcx
    42a7:	c3                   	ret
    42a8:	e8 83 20 00 00       	call   6330 <fwp_flush>
    42ad:	48 8b 05 2c dd 00 00 	mov    0xdd2c(%rip),%rax        # 11fe0 <stderr@GLIBC_2.2.5>
    42b4:	48 8b 38             	mov    (%rax),%rdi
    42b7:	48 8d 35 6f b1 00 00 	lea    0xb16f(%rip),%rsi        # f42d <fwp_segv.msg+0x1ed>
    42be:	48 8d 15 3b b1 00 00 	lea    0xb13b(%rip),%rdx        # f400 <fwp_segv.msg+0x1c0>
    42c5:	31 c0                	xor    %eax,%eax
    42c7:	e8 e4 de ff ff       	call   21b0 <fprintf@plt>
    42cc:	bf 65 00 00 00       	mov    $0x65,%edi
    42d1:	e8 ba df ff ff       	call   2290 <exit@plt>
    42d6:	66 2e 0f 1f 84 00 00 	cs nopw 0x0(%rax,%rax,1)
    42dd:	00 00 00 

00000000000042e0 <e4>:
    42e0:	50                   	push   %rax
    42e1:	48 8b 3f             	mov    (%rdi),%rdi
    42e4:	48 89 f8             	mov    %rdi,%rax
    42e7:	48 2b 05 c2 ee 00 00 	sub    0xeec2(%rip),%rax        # 131b0 <fwp_gc+0x1030>
    42ee:	48 8b 0d e3 ee 00 00 	mov    0xeee3(%rip),%rcx        # 131d8 <fwp_gc+0x1058>
    42f5:	48 c1 e1 10          	shl    $0x10,%rcx
    42f9:	48 39 c8             	cmp    %rcx,%rax
    42fc:	73 63                	jae    4361 <e4+0x81>
    42fe:	48 8b 0d f3 ee 00 00 	mov    0xeef3(%rip),%rcx        # 131f8 <fwp_gc+0x1078>
    4305:	48 89 c2             	mov    %rax,%rdx
    4308:	48 c1 ea 10          	shr    $0x10,%rdx
    430c:	48 69 d2 28 12 00 00 	imul   $0x1228,%rdx,%rdx
    4313:	0f b6 34 11          	movzbl (%rcx,%rdx,1),%esi
    4317:	48 25 ff ff 00 00    	and    $0xffff,%rax
    431d:	75 1a                	jne    4339 <e4+0x59>
    431f:	40 80 fe 02          	cmp    $0x2,%sil
    4323:	75 14                	jne    4339 <e4+0x59>
    4325:	48 8d 04 11          	lea    (%rcx,%rdx,1),%rax
    4329:	48 05 28 02 00 00    	add    $0x228,%rax
    432f:	80 38 00             	cmpb   $0x0,(%rax)
    4332:	74 2d                	je     4361 <e4+0x81>
    4334:	e9 af 00 00 00       	jmp    43e8 <e4+0x108>
    4339:	40 80 fe 01          	cmp    $0x1,%sil
    433d:	75 22                	jne    4361 <e4+0x81>
    433f:	48 8d 34 11          	lea    (%rcx,%rdx,1),%rsi
    4343:	8b 4c 11 20          	mov    0x20(%rcx,%rdx,1),%ecx
    4347:	48 0f af c1          	imul   %rcx,%rax
    434b:	48 c1 e8 20          	shr    $0x20,%rax
    434f:	48 01 f0             	add    %rsi,%rax
    4352:	48 05 28 02 00 00    	add    $0x228,%rax
    4358:	80 38 00             	cmpb   $0x0,(%rax)
    435b:	0f 85 87 00 00 00    	jne    43e8 <e4+0x108>
    4361:	48 8d 35 48 d9 00 00 	lea    0xd948(%rip),%rsi        # 11cb0 <d1>
    4368:	e8 a3 20 00 00       	call   6410 <fwp_p_array_from_list_typed>
    436d:	48 89 c1             	mov    %rax,%rcx
    4370:	48 2b 0d 39 ee 00 00 	sub    0xee39(%rip),%rcx        # 131b0 <fwp_gc+0x1030>
    4377:	48 8b 15 5a ee 00 00 	mov    0xee5a(%rip),%rdx        # 131d8 <fwp_gc+0x1058>
    437e:	48 c1 e2 10          	shl    $0x10,%rdx
    4382:	48 39 d1             	cmp    %rdx,%rcx
    4385:	73 5f                	jae    43e6 <e4+0x106>
    4387:	48 8b 15 6a ee 00 00 	mov    0xee6a(%rip),%rdx        # 131f8 <fwp_gc+0x1078>
    438e:	48 89 ce             	mov    %rcx,%rsi
    4391:	48 c1 ee 10          	shr    $0x10,%rsi
    4395:	48 69 f6 28 12 00 00 	imul   $0x1228,%rsi,%rsi
    439c:	0f b6 3c 32          	movzbl (%rdx,%rsi,1),%edi
    43a0:	48 81 e1 ff ff 00 00 	and    $0xffff,%rcx
    43a7:	75 18                	jne    43c1 <e4+0xe1>
    43a9:	40 80 ff 02          	cmp    $0x2,%dil
    43ad:	75 12                	jne    43c1 <e4+0xe1>
    43af:	48 8d 0c 32          	lea    (%rdx,%rsi,1),%rcx
    43b3:	48 81 c1 28 02 00 00 	add    $0x228,%rcx
    43ba:	80 39 00             	cmpb   $0x0,(%rcx)
    43bd:	74 27                	je     43e6 <e4+0x106>
    43bf:	eb 27                	jmp    43e8 <e4+0x108>
    43c1:	40 80 ff 01          	cmp    $0x1,%dil
    43c5:	75 1f                	jne    43e6 <e4+0x106>
    43c7:	48 8d 3c 32          	lea    (%rdx,%rsi,1),%rdi
    43cb:	8b 54 32 20          	mov    0x20(%rdx,%rsi,1),%edx
    43cf:	48 0f af ca          	imul   %rdx,%rcx
    43d3:	48 c1 e9 20          	shr    $0x20,%rcx
    43d7:	48 01 f9             	add    %rdi,%rcx
    43da:	48 81 c1 28 02 00 00 	add    $0x228,%rcx
    43e1:	80 39 00             	cmpb   $0x0,(%rcx)
    43e4:	75 02                	jne    43e8 <e4+0x108>
    43e6:	59                   	pop    %rcx
    43e7:	c3                   	ret
    43e8:	e8 43 1f 00 00       	call   6330 <fwp_flush>
    43ed:	48 8b 05 ec db 00 00 	mov    0xdbec(%rip),%rax        # 11fe0 <stderr@GLIBC_2.2.5>
    43f4:	48 8b 38             	mov    (%rax),%rdi
    43f7:	48 8d 35 2f b0 00 00 	lea    0xb02f(%rip),%rsi        # f42d <fwp_segv.msg+0x1ed>
    43fe:	48 8d 15 fb af 00 00 	lea    0xaffb(%rip),%rdx        # f400 <fwp_segv.msg+0x1c0>
    4405:	31 c0                	xor    %eax,%eax
    4407:	e8 a4 dd ff ff       	call   21b0 <fprintf@plt>
    440c:	bf 65 00 00 00       	mov    $0x65,%edi
    4411:	e8 7a de ff ff       	call   2290 <exit@plt>
    4416:	66 2e 0f 1f 84 00 00 	cs nopw 0x0(%rax,%rax,1)
    441d:	00 00 00 

0000000000004420 <e9>:
    4420:	50                   	push   %rax
    4421:	48 8b 3f             	mov    (%rdi),%rdi
    4424:	48 89 f8             	mov    %rdi,%rax
    4427:	48 2b 05 82 ed 00 00 	sub    0xed82(%rip),%rax        # 131b0 <fwp_gc+0x1030>
    442e:	48 8b 0d a3 ed 00 00 	mov    0xeda3(%rip),%rcx        # 131d8 <fwp_gc+0x1058>
    4435:	48 c1 e1 10          	shl    $0x10,%rcx
    4439:	48 39 c8             	cmp    %rcx,%rax
    443c:	73 63                	jae    44a1 <e9+0x81>
    443e:	48 8b 0d b3 ed 00 00 	mov    0xedb3(%rip),%rcx        # 131f8 <fwp_gc+0x1078>
    4445:	48 89 c2             	mov    %rax,%rdx
    4448:	48 c1 ea 10          	shr    $0x10,%rdx
    444c:	48 69 d2 28 12 00 00 	imul   $0x1228,%rdx,%rdx
    4453:	0f b6 34 11          	movzbl (%rcx,%rdx,1),%esi
    4457:	48 25 ff ff 00 00    	and    $0xffff,%rax
    445d:	75 1a                	jne    4479 <e9+0x59>
    445f:	40 80 fe 02          	cmp    $0x2,%sil
    4463:	75 14                	jne    4479 <e9+0x59>
    4465:	48 8d 04 11          	lea    (%rcx,%rdx,1),%rax
    4469:	48 05 28 02 00 00    	add    $0x228,%rax
    446f:	80 38 00             	cmpb   $0x0,(%rax)
    4472:	74 2d                	je     44a1 <e9+0x81>
    4474:	e9 af 00 00 00       	jmp    4528 <e9+0x108>
    4479:	40 80 fe 01          	cmp    $0x1,%sil
    447d:	75 22                	jne    44a1 <e9+0x81>
    447f:	48 8d 34 11          	lea    (%rcx,%rdx,1),%rsi
    4483:	8b 4c 11 20          	mov    0x20(%rcx,%rdx,1),%ecx
    4487:	48 0f af c1          	imul   %rcx,%rax
    448b:	48 c1 e8 20          	shr    $0x20,%rax
    448f:	48 01 f0             	add    %rsi,%rax
    4492:	48 05 28 02 00 00    	add    $0x228,%rax
    4498:	80 38 00             	cmpb   $0x0,(%rax)
    449b:	0f 85 87 00 00 00    	jne    4528 <e9+0x108>
    44a1:	48 8d 35 68 d8 00 00 	lea    0xd868(%rip),%rsi        # 11d10 <d2>
    44a8:	e8 63 1f 00 00       	call   6410 <fwp_p_array_from_list_typed>
    44ad:	48 89 c1             	mov    %rax,%rcx
    44b0:	48 2b 0d f9 ec 00 00 	sub    0xecf9(%rip),%rcx        # 131b0 <fwp_gc+0x1030>
    44b7:	48 8b 15 1a ed 00 00 	mov    0xed1a(%rip),%rdx        # 131d8 <fwp_gc+0x1058>
    44be:	48 c1 e2 10          	shl    $0x10,%rdx
    44c2:	48 39 d1             	cmp    %rdx,%rcx
    44c5:	73 5f                	jae    4526 <e9+0x106>
    44c7:	48 8b 15 2a ed 00 00 	mov    0xed2a(%rip),%rdx        # 131f8 <fwp_gc+0x1078>
    44ce:	48 89 ce             	mov    %rcx,%rsi
    44d1:	48 c1 ee 10          	shr    $0x10,%rsi
    44d5:	48 69 f6 28 12 00 00 	imul   $0x1228,%rsi,%rsi
    44dc:	0f b6 3c 32          	movzbl (%rdx,%rsi,1),%edi
    44e0:	48 81 e1 ff ff 00 00 	and    $0xffff,%rcx
    44e7:	75 18                	jne    4501 <e9+0xe1>
    44e9:	40 80 ff 02          	cmp    $0x2,%dil
    44ed:	75 12                	jne    4501 <e9+0xe1>
    44ef:	48 8d 0c 32          	lea    (%rdx,%rsi,1),%rcx
    44f3:	48 81 c1 28 02 00 00 	add    $0x228,%rcx
    44fa:	80 39 00             	cmpb   $0x0,(%rcx)
    44fd:	74 27                	je     4526 <e9+0x106>
    44ff:	eb 27                	jmp    4528 <e9+0x108>
    4501:	40 80 ff 01          	cmp    $0x1,%dil
    4505:	75 1f                	jne    4526 <e9+0x106>
    4507:	48 8d 3c 32          	lea    (%rdx,%rsi,1),%rdi
    450b:	8b 54 32 20          	mov    0x20(%rdx,%rsi,1),%edx
    450f:	48 0f af ca          	imul   %rdx,%rcx
    4513:	48 c1 e9 20          	shr    $0x20,%rcx
    4517:	48 01 f9             	add    %rdi,%rcx
    451a:	48 81 c1 28 02 00 00 	add    $0x228,%rcx
    4521:	80 39 00             	cmpb   $0x0,(%rcx)
    4524:	75 02                	jne    4528 <e9+0x108>
    4526:	59                   	pop    %rcx
    4527:	c3                   	ret
    4528:	e8 03 1e 00 00       	call   6330 <fwp_flush>
    452d:	48 8b 05 ac da 00 00 	mov    0xdaac(%rip),%rax        # 11fe0 <stderr@GLIBC_2.2.5>
    4534:	48 8b 38             	mov    (%rax),%rdi
    4537:	48 8d 35 ef ae 00 00 	lea    0xaeef(%rip),%rsi        # f42d <fwp_segv.msg+0x1ed>
    453e:	48 8d 15 bb ae 00 00 	lea    0xaebb(%rip),%rdx        # f400 <fwp_segv.msg+0x1c0>
    4545:	31 c0                	xor    %eax,%eax
    4547:	e8 64 dc ff ff       	call   21b0 <fprintf@plt>
    454c:	bf 65 00 00 00       	mov    $0x65,%edi
    4551:	e8 3a dd ff ff       	call   2290 <exit@plt>
    4556:	66 2e 0f 1f 84 00 00 	cs nopw 0x0(%rax,%rax,1)
    455d:	00 00 00 

0000000000004560 <e12>:
    4560:	50                   	push   %rax
    4561:	48 8b 57 10          	mov    0x10(%rdi),%rdx
    4565:	48 89 d0             	mov    %rdx,%rax
    4568:	48 2b 05 41 ec 00 00 	sub    0xec41(%rip),%rax        # 131b0 <fwp_gc+0x1030>
    456f:	48 8b 0d 62 ec 00 00 	mov    0xec62(%rip),%rcx        # 131d8 <fwp_gc+0x1058>
    4576:	48 c1 e1 10          	shl    $0x10,%rcx
    457a:	48 39 c8             	cmp    %rcx,%rax
    457d:	73 64                	jae    45e3 <e12+0x83>
    457f:	48 8b 0d 72 ec 00 00 	mov    0xec72(%rip),%rcx        # 131f8 <fwp_gc+0x1078>
    4586:	48 89 c6             	mov    %rax,%rsi
    4589:	48 c1 ee 10          	shr    $0x10,%rsi
    458d:	48 69 f6 28 12 00 00 	imul   $0x1228,%rsi,%rsi
    4594:	44 0f b6 04 31       	movzbl (%rcx,%rsi,1),%r8d
    4599:	48 25 ff ff 00 00    	and    $0xffff,%rax
    459f:	75 1a                	jne    45bb <e12+0x5b>
    45a1:	41 80 f8 02          	cmp    $0x2,%r8b
    45a5:	75 14                	jne    45bb <e12+0x5b>
    45a7:	48 8d 04 31          	lea    (%rcx,%rsi,1),%rax
    45ab:	48 05 28 02 00 00    	add    $0x228,%rax
    45b1:	80 38 00             	cmpb   $0x0,(%rax)
    45b4:	74 2d                	je     45e3 <e12+0x83>
    45b6:	e9 b2 00 00 00       	jmp    466d <e12+0x10d>
    45bb:	41 80 f8 01          	cmp    $0x1,%r8b
    45bf:	75 22                	jne    45e3 <e12+0x83>
    45c1:	4c 8d 04 31          	lea    (%rcx,%rsi,1),%r8
    45c5:	8b 4c 31 20          	mov    0x20(%rcx,%rsi,1),%ecx
    45c9:	48 0f af c1          	imul   %rcx,%rax
    45cd:	48 c1 e8 20          	shr    $0x20,%rax
    45d1:	4c 01 c0             	add    %r8,%rax
    45d4:	48 05 28 02 00 00    	add    $0x228,%rax
    45da:	80 38 00             	cmpb   $0x0,(%rax)
    45dd:	0f 85 8a 00 00 00    	jne    466d <e12+0x10d>
    45e3:	48 8b 07             	mov    (%rdi),%rax
    45e6:	48 8b 77 08          	mov    0x8(%rdi),%rsi
    45ea:	48 89 c7             	mov    %rax,%rdi
    45ed:	e8 0e 2d 00 00       	call   7300 <f12>
    45f2:	48 89 c1             	mov    %rax,%rcx
    45f5:	48 2b 0d b4 eb 00 00 	sub    0xebb4(%rip),%rcx        # 131b0 <fwp_gc+0x1030>
    45fc:	48 8b 15 d5 eb 00 00 	mov    0xebd5(%rip),%rdx        # 131d8 <fwp_gc+0x1058>
    4603:	48 c1 e2 10          	shl    $0x10,%rdx
    4607:	48 39 d1             	cmp    %rdx,%rcx
    460a:	73 5f                	jae    466b <e12+0x10b>
    460c:	48 8b 15 e5 eb 00 00 	mov    0xebe5(%rip),%rdx        # 131f8 <fwp_gc+0x1078>
    4613:	48 89 ce             	mov    %rcx,%rsi
    4616:	48 c1 ee 10          	shr    $0x10,%rsi
    461a:	48 69 f6 28 12 00 00 	imul   $0x1228,%rsi,%rsi
    4621:	0f b6 3c 32          	movzbl (%rdx,%rsi,1),%edi
    4625:	48 81 e1 ff ff 00 00 	and    $0xffff,%rcx
    462c:	75 18                	jne    4646 <e12+0xe6>
    462e:	40 80 ff 02          	cmp    $0x2,%dil
    4632:	75 12                	jne    4646 <e12+0xe6>
    4634:	48 8d 0c 32          	lea    (%rdx,%rsi,1),%rcx
    4638:	48 81 c1 28 02 00 00 	add    $0x228,%rcx
    463f:	80 39 00             	cmpb   $0x0,(%rcx)
    4642:	74 27                	je     466b <e12+0x10b>
    4644:	eb 27                	jmp    466d <e12+0x10d>
    4646:	40 80 ff 01          	cmp    $0x1,%dil
    464a:	75 1f                	jne    466b <e12+0x10b>
    464c:	48 8d 3c 32          	lea    (%rdx,%rsi,1),%rdi
    4650:	8b 54 32 20          	mov    0x20(%rdx,%rsi,1),%edx
    4654:	48 0f af ca          	imul   %rdx,%rcx
    4658:	48 c1 e9 20          	shr    $0x20,%rcx
    465c:	48 01 f9             	add    %rdi,%rcx
    465f:	48 81 c1 28 02 00 00 	add    $0x228,%rcx
    4666:	80 39 00             	cmpb   $0x0,(%rcx)
    4669:	75 02                	jne    466d <e12+0x10d>
    466b:	59                   	pop    %rcx
    466c:	c3                   	ret
    466d:	e8 be 1c 00 00       	call   6330 <fwp_flush>
    4672:	48 8b 05 67 d9 00 00 	mov    0xd967(%rip),%rax        # 11fe0 <stderr@GLIBC_2.2.5>
    4679:	48 8b 38             	mov    (%rax),%rdi
    467c:	48 8d 35 aa ad 00 00 	lea    0xadaa(%rip),%rsi        # f42d <fwp_segv.msg+0x1ed>
    4683:	48 8d 15 76 ad 00 00 	lea    0xad76(%rip),%rdx        # f400 <fwp_segv.msg+0x1c0>
    468a:	31 c0                	xor    %eax,%eax
    468c:	e8 1f db ff ff       	call   21b0 <fprintf@plt>
    4691:	bf 65 00 00 00       	mov    $0x65,%edi
    4696:	e8 f5 db ff ff       	call   2290 <exit@plt>
    469b:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)

00000000000046a0 <e15>:
    46a0:	41 56                	push   %r14
    46a2:	53                   	push   %rbx
    46a3:	50                   	push   %rax
    46a4:	48 8b 3f             	mov    (%rdi),%rdi
    46a7:	48 8d 35 62 d6 00 00 	lea    0xd662(%rip),%rsi        # 11d10 <d2>
    46ae:	e8 ed 30 00 00       	call   77a0 <fwp_show>
    46b3:	48 89 c1             	mov    %rax,%rcx
    46b6:	48 2b 0d f3 ea 00 00 	sub    0xeaf3(%rip),%rcx        # 131b0 <fwp_gc+0x1030>
    46bd:	48 8b 15 14 eb 00 00 	mov    0xeb14(%rip),%rdx        # 131d8 <fwp_gc+0x1058>
    46c4:	48 c1 e2 10          	shl    $0x10,%rdx
    46c8:	48 39 d1             	cmp    %rdx,%rcx
    46cb:	0f 83 8d 00 00 00    	jae    475e <e15+0xbe>
    46d1:	48 8b 35 20 eb 00 00 	mov    0xeb20(%rip),%rsi        # 131f8 <fwp_gc+0x1078>
    46d8:	48 89 cf             	mov    %rcx,%rdi
    46db:	48 c1 ef 10          	shr    $0x10,%rdi
    46df:	4c 69 c7 28 12 00 00 	imul   $0x1228,%rdi,%r8
    46e6:	46 0f b6 0c 06       	movzbl (%rsi,%r8,1),%r9d
    46eb:	48 89 cf             	mov    %rcx,%rdi
    46ee:	48 81 e7 ff ff 00 00 	and    $0xffff,%rdi
    46f5:	75 30                	jne    4727 <e15+0x87>
    46f7:	41 80 f9 02          	cmp    $0x2,%r9b
    46fb:	75 2a                	jne    4727 <e15+0x87>
    46fd:	4a 8d 1c 06          	lea    (%rsi,%r8,1),%rbx
    4701:	48 81 c3 28 02 00 00 	add    $0x228,%rbx
    4708:	80 3b ff             	cmpb   $0xff,(%rbx)
    470b:	74 41                	je     474e <e15+0xae>
    470d:	c6 03 01             	movb   $0x1,(%rbx)
    4710:	48 8b 15 c1 ea 00 00 	mov    0xeac1(%rip),%rdx        # 131d8 <fwp_gc+0x1058>
    4717:	48 89 c1             	mov    %rax,%rcx
    471a:	48 2b 0d 8f ea 00 00 	sub    0xea8f(%rip),%rcx        # 131b0 <fwp_gc+0x1030>
    4721:	48 c1 e2 10          	shl    $0x10,%rdx
    4725:	eb 37                	jmp    475e <e15+0xbe>
    4727:	41 80 f9 01          	cmp    $0x1,%r9b
    472b:	75 31                	jne    475e <e15+0xbe>
    472d:	4a 8d 0c 06          	lea    (%rsi,%r8,1),%rcx
    4731:	42 8b 54 06 20       	mov    0x20(%rsi,%r8,1),%edx
    4736:	48 0f af fa          	imul   %rdx,%rdi
    473a:	48 c1 ef 20          	shr    $0x20,%rdi
    473e:	48 8d 1c 0f          	lea    (%rdi,%rcx,1),%rbx
    4742:	48 81 c3 28 02 00 00 	add    $0x228,%rbx
    4749:	80 3b ff             	cmpb   $0xff,(%rbx)
    474c:	75 bf                	jne    470d <e15+0x6d>
    474e:	48 89 df             	mov    %rbx,%rdi
    4751:	49 89 c6             	mov    %rax,%r14
    4754:	e8 07 1c 00 00       	call   6360 <fwp_rc_forget_slot>
    4759:	4c 89 f0             	mov    %r14,%rax
    475c:	eb af                	jmp    470d <e15+0x6d>
    475e:	48 39 d1             	cmp    %rdx,%rcx
    4761:	73 5f                	jae    47c2 <e15+0x122>
    4763:	48 8b 15 8e ea 00 00 	mov    0xea8e(%rip),%rdx        # 131f8 <fwp_gc+0x1078>
    476a:	48 89 ce             	mov    %rcx,%rsi
    476d:	48 c1 ee 10          	shr    $0x10,%rsi
    4771:	48 69 f6 28 12 00 00 	imul   $0x1228,%rsi,%rsi
    4778:	0f b6 3c 32          	movzbl (%rdx,%rsi,1),%edi
    477c:	48 81 e1 ff ff 00 00 	and    $0xffff,%rcx
    4783:	75 18                	jne    479d <e15+0xfd>
    4785:	40 80 ff 02          	cmp    $0x2,%dil
    4789:	75 12                	jne    479d <e15+0xfd>
    478b:	48 8d 0c 32          	lea    (%rdx,%rsi,1),%rcx
    478f:	48 81 c1 28 02 00 00 	add    $0x228,%rcx
    4796:	80 39 00             	cmpb   $0x0,(%rcx)
    4799:	74 27                	je     47c2 <e15+0x122>
    479b:	eb 2d                	jmp    47ca <e15+0x12a>
    479d:	40 80 ff 01          	cmp    $0x1,%dil
    47a1:	75 1f                	jne    47c2 <e15+0x122>
    47a3:	48 8d 3c 32          	lea    (%rdx,%rsi,1),%rdi
    47a7:	8b 54 32 20          	mov    0x20(%rdx,%rsi,1),%edx
    47ab:	48 0f af ca          	imul   %rdx,%rcx
    47af:	48 c1 e9 20          	shr    $0x20,%rcx
    47b3:	48 01 f9             	add    %rdi,%rcx
    47b6:	48 81 c1 28 02 00 00 	add    $0x228,%rcx
    47bd:	80 39 00             	cmpb   $0x0,(%rcx)
    47c0:	75 08                	jne    47ca <e15+0x12a>
    47c2:	48 83 c4 08          	add    $0x8,%rsp
    47c6:	5b                   	pop    %rbx
    47c7:	41 5e                	pop    %r14
    47c9:	c3                   	ret
    47ca:	e8 61 1b 00 00       	call   6330 <fwp_flush>
    47cf:	48 8b 05 0a d8 00 00 	mov    0xd80a(%rip),%rax        # 11fe0 <stderr@GLIBC_2.2.5>
    47d6:	48 8b 38             	mov    (%rax),%rdi
    47d9:	48 8d 35 4d ac 00 00 	lea    0xac4d(%rip),%rsi        # f42d <fwp_segv.msg+0x1ed>
    47e0:	48 8d 15 19 ac 00 00 	lea    0xac19(%rip),%rdx        # f400 <fwp_segv.msg+0x1c0>
    47e7:	31 c0                	xor    %eax,%eax
    47e9:	e8 c2 d9 ff ff       	call   21b0 <fprintf@plt>
    47ee:	bf 65 00 00 00       	mov    $0x65,%edi
    47f3:	e8 98 da ff ff       	call   2290 <exit@plt>
    47f8:	0f 1f 84 00 00 00 00 	nopl   0x0(%rax,%rax,1)
    47ff:	00 

0000000000004800 <e16>:
    4800:	50                   	push   %rax
    4801:	48 8b 3f             	mov    (%rdi),%rdi
    4804:	48 89 f8             	mov    %rdi,%rax
    4807:	48 2b 05 a2 e9 00 00 	sub    0xe9a2(%rip),%rax        # 131b0 <fwp_gc+0x1030>
    480e:	48 8b 0d c3 e9 00 00 	mov    0xe9c3(%rip),%rcx        # 131d8 <fwp_gc+0x1058>
    4815:	48 c1 e1 10          	shl    $0x10,%rcx
    4819:	48 39 c8             	cmp    %rcx,%rax
    481c:	73 63                	jae    4881 <e16+0x81>
    481e:	48 8b 0d d3 e9 00 00 	mov    0xe9d3(%rip),%rcx        # 131f8 <fwp_gc+0x1078>
    4825:	48 89 c2             	mov    %rax,%rdx
    4828:	48 c1 ea 10          	shr    $0x10,%rdx
    482c:	48 69 d2 28 12 00 00 	imul   $0x1228,%rdx,%rdx
    4833:	0f b6 34 11          	movzbl (%rcx,%rdx,1),%esi
    4837:	48 25 ff ff 00 00    	and    $0xffff,%rax
    483d:	75 1a                	jne    4859 <e16+0x59>
    483f:	40 80 fe 02          	cmp    $0x2,%sil
    4843:	75 14                	jne    4859 <e16+0x59>
    4845:	48 8d 04 11          	lea    (%rcx,%rdx,1),%rax
    4849:	48 05 28 02 00 00    	add    $0x228,%rax
    484f:	80 38 00             	cmpb   $0x0,(%rax)
    4852:	74 2d                	je     4881 <e16+0x81>
    4854:	e9 ca 00 00 00       	jmp    4923 <e16+0x123>
    4859:	40 80 fe 01          	cmp    $0x1,%sil
    485d:	75 22                	jne    4881 <e16+0x81>
    485f:	48 8d 34 11          	lea    (%rcx,%rdx,1),%rsi
    4863:	8b 4c 11 20          	mov    0x20(%rcx,%rdx,1),%ecx
    4867:	48 0f af c1          	imul   %rcx,%rax
    486b:	48 c1 e8 20          	shr    $0x20,%rax
    486f:	48 01 f0             	add    %rsi,%rax
    4872:	48 05 28 02 00 00    	add    $0x228,%rax
    4878:	80 38 00             	cmpb   $0x0,(%rax)
    487b:	0f 85 a2 00 00 00    	jne    4923 <e16+0x123>
    4881:	48 8b 17             	mov    (%rdi),%rdx
    4884:	48 83 c7 08          	add    $0x8,%rdi
    4888:	48 8b 0d 39 f3 00 00 	mov    0xf339(%rip),%rcx        # 13bc8 <fwp_prog_out>
    488f:	be 01 00 00 00       	mov    $0x1,%esi
    4894:	e8 07 da ff ff       	call   22a0 <fwrite@plt>
    4899:	48 8b 35 28 f3 00 00 	mov    0xf328(%rip),%rsi        # 13bc8 <fwp_prog_out>
    48a0:	bf 0a 00 00 00       	mov    $0xa,%edi
    48a5:	e8 96 d8 ff ff       	call   2140 <fputc@plt>
    48aa:	31 c0                	xor    %eax,%eax
    48ac:	48 2b 05 fd e8 00 00 	sub    0xe8fd(%rip),%rax        # 131b0 <fwp_gc+0x1030>
    48b3:	48 8b 0d 1e e9 00 00 	mov    0xe91e(%rip),%rcx        # 131d8 <fwp_gc+0x1058>
    48ba:	48 c1 e1 10          	shl    $0x10,%rcx
    48be:	48 39 c1             	cmp    %rax,%rcx
    48c1:	76 5c                	jbe    491f <e16+0x11f>
    48c3:	48 8b 0d 2e e9 00 00 	mov    0xe92e(%rip),%rcx        # 131f8 <fwp_gc+0x1078>
    48ca:	48 89 c2             	mov    %rax,%rdx
    48cd:	48 c1 ea 10          	shr    $0x10,%rdx
    48d1:	48 69 d2 28 12 00 00 	imul   $0x1228,%rdx,%rdx
    48d8:	0f b6 34 11          	movzbl (%rcx,%rdx,1),%esi
    48dc:	48 25 ff ff 00 00    	and    $0xffff,%rax
    48e2:	75 17                	jne    48fb <e16+0xfb>
    48e4:	40 80 fe 02          	cmp    $0x2,%sil
    48e8:	75 11                	jne    48fb <e16+0xfb>
    48ea:	48 8d 04 11          	lea    (%rcx,%rdx,1),%rax
    48ee:	48 05 28 02 00 00    	add    $0x228,%rax
    48f4:	80 38 00             	cmpb   $0x0,(%rax)
    48f7:	74 26                	je     491f <e16+0x11f>
    48f9:	eb 28                	jmp    4923 <e16+0x123>
    48fb:	40 80 fe 01          	cmp    $0x1,%sil
    48ff:	75 1e                	jne    491f <e16+0x11f>
    4901:	48 8d 34 11          	lea    (%rcx,%rdx,1),%rsi
    4905:	8b 4c 11 20          	mov    0x20(%rcx,%rdx,1),%ecx
    4909:	48 0f af c1          	imul   %rcx,%rax
    490d:	48 c1 e8 20          	shr    $0x20,%rax
    4911:	48 01 f0             	add    %rsi,%rax
    4914:	48 05 28 02 00 00    	add    $0x228,%rax
    491a:	80 38 00             	cmpb   $0x0,(%rax)
    491d:	75 04                	jne    4923 <e16+0x123>
    491f:	31 c0                	xor    %eax,%eax
    4921:	59                   	pop    %rcx
    4922:	c3                   	ret
    4923:	e8 08 1a 00 00       	call   6330 <fwp_flush>
    4928:	48 8b 05 b1 d6 00 00 	mov    0xd6b1(%rip),%rax        # 11fe0 <stderr@GLIBC_2.2.5>
    492f:	48 8b 38             	mov    (%rax),%rdi
    4932:	48 8d 35 f4 aa 00 00 	lea    0xaaf4(%rip),%rsi        # f42d <fwp_segv.msg+0x1ed>
    4939:	48 8d 15 c0 aa 00 00 	lea    0xaac0(%rip),%rdx        # f400 <fwp_segv.msg+0x1c0>
    4940:	31 c0                	xor    %eax,%eax
    4942:	e8 69 d8 ff ff       	call   21b0 <fprintf@plt>
    4947:	bf 65 00 00 00       	mov    $0x65,%edi
    494c:	e8 3f d9 ff ff       	call   2290 <exit@plt>
    4951:	66 66 66 66 66 66 2e 	data16 data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    4958:	0f 1f 84 00 00 00 00 
    495f:	00 

0000000000004960 <e24>:
    4960:	f3 0f 6f 07          	movdqu (%rdi),%xmm0
    4964:	66 0f 70 c8 aa       	pshufd $0xaa,%xmm0,%xmm1
    4969:	0f 58 c8             	addps  %xmm0,%xmm1
    496c:	66 0f 7e c8          	movd   %xmm1,%eax
    4970:	48 89 c1             	mov    %rax,%rcx
    4973:	48 2b 0d 36 e8 00 00 	sub    0xe836(%rip),%rcx        # 131b0 <fwp_gc+0x1030>
    497a:	48 8b 15 57 e8 00 00 	mov    0xe857(%rip),%rdx        # 131d8 <fwp_gc+0x1058>
    4981:	48 c1 e2 10          	shl    $0x10,%rdx
    4985:	48 39 d1             	cmp    %rdx,%rcx
    4988:	73 5f                	jae    49e9 <e24+0x89>
    498a:	48 8b 15 67 e8 00 00 	mov    0xe867(%rip),%rdx        # 131f8 <fwp_gc+0x1078>
    4991:	48 89 ce             	mov    %rcx,%rsi
    4994:	48 c1 ee 10          	shr    $0x10,%rsi
    4998:	48 69 f6 28 12 00 00 	imul   $0x1228,%rsi,%rsi
    499f:	0f b6 3c 32          	movzbl (%rdx,%rsi,1),%edi
    49a3:	48 81 e1 ff ff 00 00 	and    $0xffff,%rcx
    49aa:	75 18                	jne    49c4 <e24+0x64>
    49ac:	40 80 ff 02          	cmp    $0x2,%dil
    49b0:	75 12                	jne    49c4 <e24+0x64>
    49b2:	48 8d 0c 32          	lea    (%rdx,%rsi,1),%rcx
    49b6:	48 81 c1 28 02 00 00 	add    $0x228,%rcx
    49bd:	80 39 00             	cmpb   $0x0,(%rcx)
    49c0:	74 27                	je     49e9 <e24+0x89>
    49c2:	eb 26                	jmp    49ea <e24+0x8a>
    49c4:	40 80 ff 01          	cmp    $0x1,%dil
    49c8:	75 1f                	jne    49e9 <e24+0x89>
    49ca:	48 8d 3c 32          	lea    (%rdx,%rsi,1),%rdi
    49ce:	8b 54 32 20          	mov    0x20(%rdx,%rsi,1),%edx
    49d2:	48 0f af ca          	imul   %rdx,%rcx
    49d6:	48 c1 e9 20          	shr    $0x20,%rcx
    49da:	48 01 f9             	add    %rdi,%rcx
    49dd:	48 81 c1 28 02 00 00 	add    $0x228,%rcx
    49e4:	80 39 00             	cmpb   $0x0,(%rcx)
    49e7:	75 01                	jne    49ea <e24+0x8a>
    49e9:	c3                   	ret
    49ea:	50                   	push   %rax
    49eb:	e8 40 19 00 00       	call   6330 <fwp_flush>
    49f0:	48 8b 05 e9 d5 00 00 	mov    0xd5e9(%rip),%rax        # 11fe0 <stderr@GLIBC_2.2.5>
    49f7:	48 8b 38             	mov    (%rax),%rdi
    49fa:	48 8d 35 2c aa 00 00 	lea    0xaa2c(%rip),%rsi        # f42d <fwp_segv.msg+0x1ed>
    4a01:	48 8d 15 f8 a9 00 00 	lea    0xa9f8(%rip),%rdx        # f400 <fwp_segv.msg+0x1c0>
    4a08:	31 c0                	xor    %eax,%eax
    4a0a:	e8 a1 d7 ff ff       	call   21b0 <fprintf@plt>
    4a0f:	bf 65 00 00 00       	mov    $0x65,%edi
    4a14:	e8 77 d8 ff ff       	call   2290 <exit@plt>
    4a19:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)

0000000000004a20 <e25>:
    4a20:	f3 0f 6f 07          	movdqu (%rdi),%xmm0
    4a24:	66 0f 70 c8 aa       	pshufd $0xaa,%xmm0,%xmm1
    4a29:	0f 59 c8             	mulps  %xmm0,%xmm1
    4a2c:	66 0f 7e c8          	movd   %xmm1,%eax
    4a30:	48 89 c1             	mov    %rax,%rcx
    4a33:	48 2b 0d 76 e7 00 00 	sub    0xe776(%rip),%rcx        # 131b0 <fwp_gc+0x1030>
    4a3a:	48 8b 15 97 e7 00 00 	mov    0xe797(%rip),%rdx        # 131d8 <fwp_gc+0x1058>
    4a41:	48 c1 e2 10          	shl    $0x10,%rdx
    4a45:	48 39 d1             	cmp    %rdx,%rcx
    4a48:	73 5f                	jae    4aa9 <e25+0x89>
    4a4a:	48 8b 15 a7 e7 00 00 	mov    0xe7a7(%rip),%rdx        # 131f8 <fwp_gc+0x1078>
    4a51:	48 89 ce             	mov    %rcx,%rsi
    4a54:	48 c1 ee 10          	shr    $0x10,%rsi
    4a58:	48 69 f6 28 12 00 00 	imul   $0x1228,%rsi,%rsi
    4a5f:	0f b6 3c 32          	movzbl (%rdx,%rsi,1),%edi
    4a63:	48 81 e1 ff ff 00 00 	and    $0xffff,%rcx
    4a6a:	75 18                	jne    4a84 <e25+0x64>
    4a6c:	40 80 ff 02          	cmp    $0x2,%dil
    4a70:	75 12                	jne    4a84 <e25+0x64>
    4a72:	48 8d 0c 32          	lea    (%rdx,%rsi,1),%rcx
    4a76:	48 81 c1 28 02 00 00 	add    $0x228,%rcx
    4a7d:	80 39 00             	cmpb   $0x0,(%rcx)
    4a80:	74 27                	je     4aa9 <e25+0x89>
    4a82:	eb 26                	jmp    4aaa <e25+0x8a>
    4a84:	40 80 ff 01          	cmp    $0x1,%dil
    4a88:	75 1f                	jne    4aa9 <e25+0x89>
    4a8a:	48 8d 3c 32          	lea    (%rdx,%rsi,1),%rdi
    4a8e:	8b 54 32 20          	mov    0x20(%rdx,%rsi,1),%edx
    4a92:	48 0f af ca          	imul   %rdx,%rcx
    4a96:	48 c1 e9 20          	shr    $0x20,%rcx
    4a9a:	48 01 f9             	add    %rdi,%rcx
    4a9d:	48 81 c1 28 02 00 00 	add    $0x228,%rcx
    4aa4:	80 39 00             	cmpb   $0x0,(%rcx)
    4aa7:	75 01                	jne    4aaa <e25+0x8a>
    4aa9:	c3                   	ret
    4aaa:	50                   	push   %rax
    4aab:	e8 80 18 00 00       	call   6330 <fwp_flush>
    4ab0:	48 8b 05 29 d5 00 00 	mov    0xd529(%rip),%rax        # 11fe0 <stderr@GLIBC_2.2.5>
    4ab7:	48 8b 38             	mov    (%rax),%rdi
    4aba:	48 8d 35 6c a9 00 00 	lea    0xa96c(%rip),%rsi        # f42d <fwp_segv.msg+0x1ed>
    4ac1:	48 8d 15 38 a9 00 00 	lea    0xa938(%rip),%rdx        # f400 <fwp_segv.msg+0x1c0>
    4ac8:	31 c0                	xor    %eax,%eax
    4aca:	e8 e1 d6 ff ff       	call   21b0 <fprintf@plt>
    4acf:	bf 65 00 00 00       	mov    $0x65,%edi
    4ad4:	e8 b7 d7 ff ff       	call   2290 <exit@plt>
    4ad9:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)

0000000000004ae0 <e26>:
    4ae0:	41 56                	push   %r14
    4ae2:	53                   	push   %rbx
    4ae3:	50                   	push   %rax
    4ae4:	48 8b 3f             	mov    (%rdi),%rdi
    4ae7:	e8 a4 50 00 00       	call   9b90 <fwp_show_i64>
    4aec:	48 89 c1             	mov    %rax,%rcx
    4aef:	48 2b 0d ba e6 00 00 	sub    0xe6ba(%rip),%rcx        # 131b0 <fwp_gc+0x1030>
    4af6:	48 8b 15 db e6 00 00 	mov    0xe6db(%rip),%rdx        # 131d8 <fwp_gc+0x1058>
    4afd:	48 c1 e2 10          	shl    $0x10,%rdx
    4b01:	48 39 d1             	cmp    %rdx,%rcx
    4b04:	0f 83 8d 00 00 00    	jae    4b97 <e26+0xb7>
    4b0a:	48 8b 35 e7 e6 00 00 	mov    0xe6e7(%rip),%rsi        # 131f8 <fwp_gc+0x1078>
    4b11:	48 89 cf             	mov    %rcx,%rdi
    4b14:	48 c1 ef 10          	shr    $0x10,%rdi
    4b18:	4c 69 c7 28 12 00 00 	imul   $0x1228,%rdi,%r8
    4b1f:	46 0f b6 0c 06       	movzbl (%rsi,%r8,1),%r9d
    4b24:	48 89 cf             	mov    %rcx,%rdi
    4b27:	48 81 e7 ff ff 00 00 	and    $0xffff,%rdi
    4b2e:	75 30                	jne    4b60 <e26+0x80>
    4b30:	41 80 f9 02          	cmp    $0x2,%r9b
    4b34:	75 2a                	jne    4b60 <e26+0x80>
    4b36:	4a 8d 1c 06          	lea    (%rsi,%r8,1),%rbx
    4b3a:	48 81 c3 28 02 00 00 	add    $0x228,%rbx
    4b41:	80 3b ff             	cmpb   $0xff,(%rbx)
    4b44:	74 41                	je     4b87 <e26+0xa7>
    4b46:	c6 03 01             	movb   $0x1,(%rbx)
    4b49:	48 8b 15 88 e6 00 00 	mov    0xe688(%rip),%rdx        # 131d8 <fwp_gc+0x1058>
    4b50:	48 89 c1             	mov    %rax,%rcx
    4b53:	48 2b 0d 56 e6 00 00 	sub    0xe656(%rip),%rcx        # 131b0 <fwp_gc+0x1030>
    4b5a:	48 c1 e2 10          	shl    $0x10,%rdx
    4b5e:	eb 37                	jmp    4b97 <e26+0xb7>
    4b60:	41 80 f9 01          	cmp    $0x1,%r9b
    4b64:	75 31                	jne    4b97 <e26+0xb7>
    4b66:	4a 8d 0c 06          	lea    (%rsi,%r8,1),%rcx
    4b6a:	42 8b 54 06 20       	mov    0x20(%rsi,%r8,1),%edx
    4b6f:	48 0f af fa          	imul   %rdx,%rdi
    4b73:	48 c1 ef 20          	shr    $0x20,%rdi
    4b77:	48 8d 1c 0f          	lea    (%rdi,%rcx,1),%rbx
    4b7b:	48 81 c3 28 02 00 00 	add    $0x228,%rbx
    4b82:	80 3b ff             	cmpb   $0xff,(%rbx)
    4b85:	75 bf                	jne    4b46 <e26+0x66>
    4b87:	48 89 df             	mov    %rbx,%rdi
    4b8a:	49 89 c6             	mov    %rax,%r14
    4b8d:	e8 ce 17 00 00       	call   6360 <fwp_rc_forget_slot>
    4b92:	4c 89 f0             	mov    %r14,%rax
    4b95:	eb af                	jmp    4b46 <e26+0x66>
    4b97:	48 39 d1             	cmp    %rdx,%rcx
    4b9a:	73 5f                	jae    4bfb <e26+0x11b>
    4b9c:	48 8b 15 55 e6 00 00 	mov    0xe655(%rip),%rdx        # 131f8 <fwp_gc+0x1078>
    4ba3:	48 89 ce             	mov    %rcx,%rsi
    4ba6:	48 c1 ee 10          	shr    $0x10,%rsi
    4baa:	48 69 f6 28 12 00 00 	imul   $0x1228,%rsi,%rsi
    4bb1:	0f b6 3c 32          	movzbl (%rdx,%rsi,1),%edi
    4bb5:	48 81 e1 ff ff 00 00 	and    $0xffff,%rcx
    4bbc:	75 18                	jne    4bd6 <e26+0xf6>
    4bbe:	40 80 ff 02          	cmp    $0x2,%dil
    4bc2:	75 12                	jne    4bd6 <e26+0xf6>
    4bc4:	48 8d 0c 32          	lea    (%rdx,%rsi,1),%rcx
    4bc8:	48 81 c1 28 02 00 00 	add    $0x228,%rcx
    4bcf:	80 39 00             	cmpb   $0x0,(%rcx)
    4bd2:	74 27                	je     4bfb <e26+0x11b>
    4bd4:	eb 2d                	jmp    4c03 <e26+0x123>
    4bd6:	40 80 ff 01          	cmp    $0x1,%dil
    4bda:	75 1f                	jne    4bfb <e26+0x11b>
    4bdc:	48 8d 3c 32          	lea    (%rdx,%rsi,1),%rdi
    4be0:	8b 54 32 20          	mov    0x20(%rdx,%rsi,1),%edx
    4be4:	48 0f af ca          	imul   %rdx,%rcx
    4be8:	48 c1 e9 20          	shr    $0x20,%rcx
    4bec:	48 01 f9             	add    %rdi,%rcx
    4bef:	48 81 c1 28 02 00 00 	add    $0x228,%rcx
    4bf6:	80 39 00             	cmpb   $0x0,(%rcx)
    4bf9:	75 08                	jne    4c03 <e26+0x123>
    4bfb:	48 83 c4 08          	add    $0x8,%rsp
    4bff:	5b                   	pop    %rbx
    4c00:	41 5e                	pop    %r14
    4c02:	c3                   	ret
    4c03:	e8 28 17 00 00       	call   6330 <fwp_flush>
    4c08:	48 8b 05 d1 d3 00 00 	mov    0xd3d1(%rip),%rax        # 11fe0 <stderr@GLIBC_2.2.5>
    4c0f:	48 8b 38             	mov    (%rax),%rdi
    4c12:	48 8d 35 14 a8 00 00 	lea    0xa814(%rip),%rsi        # f42d <fwp_segv.msg+0x1ed>
    4c19:	48 8d 15 e0 a7 00 00 	lea    0xa7e0(%rip),%rdx        # f400 <fwp_segv.msg+0x1c0>
    4c20:	31 c0                	xor    %eax,%eax
    4c22:	e8 89 d5 ff ff       	call   21b0 <fprintf@plt>
    4c27:	bf 65 00 00 00       	mov    $0x65,%edi
    4c2c:	e8 5f d6 ff ff       	call   2290 <exit@plt>
    4c31:	66 66 66 66 66 66 2e 	data16 data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    4c38:	0f 1f 84 00 00 00 00 
    4c3f:	00 

0000000000004c40 <e32>:
    4c40:	53                   	push   %rbx
    4c41:	48 83 ec 60          	sub    $0x60,%rsp
    4c45:	48 8b 47 08          	mov    0x8(%rdi),%rax
    4c49:	48 03 07             	add    (%rdi),%rax
    4c4c:	48 0f be c8          	movsbq %al,%rcx
    4c50:	48 39 c1             	cmp    %rax,%rcx
    4c53:	75 7f                	jne    4cd4 <e32+0x94>
    4c55:	48 89 c1             	mov    %rax,%rcx
    4c58:	48 2b 0d 51 e5 00 00 	sub    0xe551(%rip),%rcx        # 131b0 <fwp_gc+0x1030>
    4c5f:	48 8b 15 72 e5 00 00 	mov    0xe572(%rip),%rdx        # 131d8 <fwp_gc+0x1058>
    4c66:	48 c1 e2 10          	shl    $0x10,%rdx
    4c6a:	48 39 d1             	cmp    %rdx,%rcx
    4c6d:	73 5f                	jae    4cce <e32+0x8e>
    4c6f:	48 8b 15 82 e5 00 00 	mov    0xe582(%rip),%rdx        # 131f8 <fwp_gc+0x1078>
    4c76:	48 89 ce             	mov    %rcx,%rsi
    4c79:	48 c1 ee 10          	shr    $0x10,%rsi
    4c7d:	48 69 f6 28 12 00 00 	imul   $0x1228,%rsi,%rsi
    4c84:	0f b6 3c 32          	movzbl (%rdx,%rsi,1),%edi
    4c88:	48 81 e1 ff ff 00 00 	and    $0xffff,%rcx
    4c8f:	75 18                	jne    4ca9 <e32+0x69>
    4c91:	40 80 ff 02          	cmp    $0x2,%dil
    4c95:	75 12                	jne    4ca9 <e32+0x69>
    4c97:	48 8d 0c 32          	lea    (%rdx,%rsi,1),%rcx
    4c9b:	48 81 c1 28 02 00 00 	add    $0x228,%rcx
    4ca2:	80 39 00             	cmpb   $0x0,(%rcx)
    4ca5:	74 27                	je     4cce <e32+0x8e>
    4ca7:	eb 66                	jmp    4d0f <e32+0xcf>
    4ca9:	40 80 ff 01          	cmp    $0x1,%dil
    4cad:	75 1f                	jne    4cce <e32+0x8e>
    4caf:	48 8d 3c 32          	lea    (%rdx,%rsi,1),%rdi
    4cb3:	8b 54 32 20          	mov    0x20(%rdx,%rsi,1),%edx
    4cb7:	48 0f af ca          	imul   %rdx,%rcx
    4cbb:	48 c1 e9 20          	shr    $0x20,%rcx
    4cbf:	48 01 f9             	add    %rdi,%rcx
    4cc2:	48 81 c1 28 02 00 00 	add    $0x228,%rcx
    4cc9:	80 39 00             	cmpb   $0x0,(%rcx)
    4ccc:	75 41                	jne    4d0f <e32+0xcf>
    4cce:	48 83 c4 60          	add    $0x60,%rsp
    4cd2:	5b                   	pop    %rbx
    4cd3:	c3                   	ret
    4cd4:	48 8d 15 b0 a9 00 00 	lea    0xa9b0(%rip),%rdx        # f68b <fwp_segv.msg+0x44b>
    4cdb:	48 8d 0d c1 a8 00 00 	lea    0xa8c1(%rip),%rcx        # f5a3 <fwp_segv.msg+0x363>
    4ce2:	48 89 e3             	mov    %rsp,%rbx
    4ce5:	be 60 00 00 00       	mov    $0x60,%esi
    4cea:	48 89 df             	mov    %rbx,%rdi
    4ced:	31 c0                	xor    %eax,%eax
    4cef:	e8 1c d4 ff ff       	call   2110 <snprintf@plt>
    4cf4:	e8 37 16 00 00       	call   6330 <fwp_flush>
    4cf9:	48 8b 05 e0 d2 00 00 	mov    0xd2e0(%rip),%rax        # 11fe0 <stderr@GLIBC_2.2.5>
    4d00:	48 8b 38             	mov    (%rax),%rdi
    4d03:	48 8d 35 23 a7 00 00 	lea    0xa723(%rip),%rsi        # f42d <fwp_segv.msg+0x1ed>
    4d0a:	48 89 da             	mov    %rbx,%rdx
    4d0d:	eb 1d                	jmp    4d2c <e32+0xec>
    4d0f:	e8 1c 16 00 00       	call   6330 <fwp_flush>
    4d14:	48 8b 05 c5 d2 00 00 	mov    0xd2c5(%rip),%rax        # 11fe0 <stderr@GLIBC_2.2.5>
    4d1b:	48 8b 38             	mov    (%rax),%rdi
    4d1e:	48 8d 35 08 a7 00 00 	lea    0xa708(%rip),%rsi        # f42d <fwp_segv.msg+0x1ed>
    4d25:	48 8d 15 d4 a6 00 00 	lea    0xa6d4(%rip),%rdx        # f400 <fwp_segv.msg+0x1c0>
    4d2c:	31 c0                	xor    %eax,%eax
    4d2e:	e8 7d d4 ff ff       	call   21b0 <fprintf@plt>
    4d33:	bf 65 00 00 00       	mov    $0x65,%edi
    4d38:	e8 53 d5 ff ff       	call   2290 <exit@plt>
    4d3d:	0f 1f 00             	nopl   (%rax)

0000000000004d40 <e33>:
    4d40:	41 56                	push   %r14
    4d42:	53                   	push   %rbx
    4d43:	50                   	push   %rax
    4d44:	48 8b 3f             	mov    (%rdi),%rdi
    4d47:	e8 44 4e 00 00       	call   9b90 <fwp_show_i64>
    4d4c:	48 89 c1             	mov    %rax,%rcx
    4d4f:	48 2b 0d 5a e4 00 00 	sub    0xe45a(%rip),%rcx        # 131b0 <fwp_gc+0x1030>
    4d56:	48 8b 15 7b e4 00 00 	mov    0xe47b(%rip),%rdx        # 131d8 <fwp_gc+0x1058>
    4d5d:	48 c1 e2 10          	shl    $0x10,%rdx
    4d61:	48 39 d1             	cmp    %rdx,%rcx
    4d64:	0f 83 8d 00 00 00    	jae    4df7 <e33+0xb7>
    4d6a:	48 8b 35 87 e4 00 00 	mov    0xe487(%rip),%rsi        # 131f8 <fwp_gc+0x1078>
    4d71:	48 89 cf             	mov    %rcx,%rdi
    4d74:	48 c1 ef 10          	shr    $0x10,%rdi
    4d78:	4c 69 c7 28 12 00 00 	imul   $0x1228,%rdi,%r8
    4d7f:	46 0f b6 0c 06       	movzbl (%rsi,%r8,1),%r9d
    4d84:	48 89 cf             	mov    %rcx,%rdi
    4d87:	48 81 e7 ff ff 00 00 	and    $0xffff,%rdi
    4d8e:	75 30                	jne    4dc0 <e33+0x80>
    4d90:	41 80 f9 02          	cmp    $0x2,%r9b
    4d94:	75 2a                	jne    4dc0 <e33+0x80>
    4d96:	4a 8d 1c 06          	lea    (%rsi,%r8,1),%rbx
    4d9a:	48 81 c3 28 02 00 00 	add    $0x228,%rbx
    4da1:	80 3b ff             	cmpb   $0xff,(%rbx)
    4da4:	74 41                	je     4de7 <e33+0xa7>
    4da6:	c6 03 01             	movb   $0x1,(%rbx)
    4da9:	48 8b 15 28 e4 00 00 	mov    0xe428(%rip),%rdx        # 131d8 <fwp_gc+0x1058>
    4db0:	48 89 c1             	mov    %rax,%rcx
    4db3:	48 2b 0d f6 e3 00 00 	sub    0xe3f6(%rip),%rcx        # 131b0 <fwp_gc+0x1030>
    4dba:	48 c1 e2 10          	shl    $0x10,%rdx
    4dbe:	eb 37                	jmp    4df7 <e33+0xb7>
    4dc0:	41 80 f9 01          	cmp    $0x1,%r9b
    4dc4:	75 31                	jne    4df7 <e33+0xb7>
    4dc6:	4a 8d 0c 06          	lea    (%rsi,%r8,1),%rcx
    4dca:	42 8b 54 06 20       	mov    0x20(%rsi,%r8,1),%edx
    4dcf:	48 0f af fa          	imul   %rdx,%rdi
    4dd3:	48 c1 ef 20          	shr    $0x20,%rdi
    4dd7:	48 8d 1c 0f          	lea    (%rdi,%rcx,1),%rbx
    4ddb:	48 81 c3 28 02 00 00 	add    $0x228,%rbx
    4de2:	80 3b ff             	cmpb   $0xff,(%rbx)
    4de5:	75 bf                	jne    4da6 <e33+0x66>
    4de7:	48 89 df             	mov    %rbx,%rdi
    4dea:	49 89 c6             	mov    %rax,%r14
    4ded:	e8 6e 15 00 00       	call   6360 <fwp_rc_forget_slot>
    4df2:	4c 89 f0             	mov    %r14,%rax
    4df5:	eb af                	jmp    4da6 <e33+0x66>
    4df7:	48 39 d1             	cmp    %rdx,%rcx
    4dfa:	73 5f                	jae    4e5b <e33+0x11b>
    4dfc:	48 8b 15 f5 e3 00 00 	mov    0xe3f5(%rip),%rdx        # 131f8 <fwp_gc+0x1078>
    4e03:	48 89 ce             	mov    %rcx,%rsi
    4e06:	48 c1 ee 10          	shr    $0x10,%rsi
    4e0a:	48 69 f6 28 12 00 00 	imul   $0x1228,%rsi,%rsi
    4e11:	0f b6 3c 32          	movzbl (%rdx,%rsi,1),%edi
    4e15:	48 81 e1 ff ff 00 00 	and    $0xffff,%rcx
    4e1c:	75 18                	jne    4e36 <e33+0xf6>
    4e1e:	40 80 ff 02          	cmp    $0x2,%dil
    4e22:	75 12                	jne    4e36 <e33+0xf6>
    4e24:	48 8d 0c 32          	lea    (%rdx,%rsi,1),%rcx
    4e28:	48 81 c1 28 02 00 00 	add    $0x228,%rcx
    4e2f:	80 39 00             	cmpb   $0x0,(%rcx)
    4e32:	74 27                	je     4e5b <e33+0x11b>
    4e34:	eb 2d                	jmp    4e63 <e33+0x123>
    4e36:	40 80 ff 01          	cmp    $0x1,%dil
    4e3a:	75 1f                	jne    4e5b <e33+0x11b>
    4e3c:	48 8d 3c 32          	lea    (%rdx,%rsi,1),%rdi
    4e40:	8b 54 32 20          	mov    0x20(%rdx,%rsi,1),%edx
    4e44:	48 0f af ca          	imul   %rdx,%rcx
    4e48:	48 c1 e9 20          	shr    $0x20,%rcx
    4e4c:	48 01 f9             	add    %rdi,%rcx
    4e4f:	48 81 c1 28 02 00 00 	add    $0x228,%rcx
    4e56:	80 39 00             	cmpb   $0x0,(%rcx)
    4e59:	75 08                	jne    4e63 <e33+0x123>
    4e5b:	48 83 c4 08          	add    $0x8,%rsp
    4e5f:	5b                   	pop    %rbx
    4e60:	41 5e                	pop    %r14
    4e62:	c3                   	ret
    4e63:	e8 c8 14 00 00       	call   6330 <fwp_flush>
    4e68:	48 8b 05 71 d1 00 00 	mov    0xd171(%rip),%rax        # 11fe0 <stderr@GLIBC_2.2.5>
    4e6f:	48 8b 38             	mov    (%rax),%rdi
    4e72:	48 8d 35 b4 a5 00 00 	lea    0xa5b4(%rip),%rsi        # f42d <fwp_segv.msg+0x1ed>
    4e79:	48 8d 15 80 a5 00 00 	lea    0xa580(%rip),%rdx        # f400 <fwp_segv.msg+0x1c0>
    4e80:	31 c0                	xor    %eax,%eax
    4e82:	e8 29 d3 ff ff       	call   21b0 <fprintf@plt>
    4e87:	bf 65 00 00 00       	mov    $0x65,%edi
    4e8c:	e8 ff d3 ff ff       	call   2290 <exit@plt>
    4e91:	66 66 66 66 66 66 2e 	data16 data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    4e98:	0f 1f 84 00 00 00 00 
    4e9f:	00 

0000000000004ea0 <e37>:
    4ea0:	41 56                	push   %r14
    4ea2:	53                   	push   %rbx
    4ea3:	50                   	push   %rax
    4ea4:	48 8b 3f             	mov    (%rdi),%rdi
    4ea7:	48 8d 35 a2 cd 00 00 	lea    0xcda2(%rip),%rsi        # 11c50 <d0>
    4eae:	e8 ed 28 00 00       	call   77a0 <fwp_show>
    4eb3:	48 89 c1             	mov    %rax,%rcx
    4eb6:	48 2b 0d f3 e2 00 00 	sub    0xe2f3(%rip),%rcx        # 131b0 <fwp_gc+0x1030>
    4ebd:	48 8b 15 14 e3 00 00 	mov    0xe314(%rip),%rdx        # 131d8 <fwp_gc+0x1058>
    4ec4:	48 c1 e2 10          	shl    $0x10,%rdx
    4ec8:	48 39 d1             	cmp    %rdx,%rcx
    4ecb:	0f 83 8d 00 00 00    	jae    4f5e <e37+0xbe>
    4ed1:	48 8b 35 20 e3 00 00 	mov    0xe320(%rip),%rsi        # 131f8 <fwp_gc+0x1078>
    4ed8:	48 89 cf             	mov    %rcx,%rdi
    4edb:	48 c1 ef 10          	shr    $0x10,%rdi
    4edf:	4c 69 c7 28 12 00 00 	imul   $0x1228,%rdi,%r8
    4ee6:	46 0f b6 0c 06       	movzbl (%rsi,%r8,1),%r9d
    4eeb:	48 89 cf             	mov    %rcx,%rdi
    4eee:	48 81 e7 ff ff 00 00 	and    $0xffff,%rdi
    4ef5:	75 30                	jne    4f27 <e37+0x87>
    4ef7:	41 80 f9 02          	cmp    $0x2,%r9b
    4efb:	75 2a                	jne    4f27 <e37+0x87>
    4efd:	4a 8d 1c 06          	lea    (%rsi,%r8,1),%rbx
    4f01:	48 81 c3 28 02 00 00 	add    $0x228,%rbx
    4f08:	80 3b ff             	cmpb   $0xff,(%rbx)
    4f0b:	74 41                	je     4f4e <e37+0xae>
    4f0d:	c6 03 01             	movb   $0x1,(%rbx)
    4f10:	48 8b 15 c1 e2 00 00 	mov    0xe2c1(%rip),%rdx        # 131d8 <fwp_gc+0x1058>
    4f17:	48 89 c1             	mov    %rax,%rcx
    4f1a:	48 2b 0d 8f e2 00 00 	sub    0xe28f(%rip),%rcx        # 131b0 <fwp_gc+0x1030>
    4f21:	48 c1 e2 10          	shl    $0x10,%rdx
    4f25:	eb 37                	jmp    4f5e <e37+0xbe>
    4f27:	41 80 f9 01          	cmp    $0x1,%r9b
    4f2b:	75 31                	jne    4f5e <e37+0xbe>
    4f2d:	4a 8d 0c 06          	lea    (%rsi,%r8,1),%rcx
    4f31:	42 8b 54 06 20       	mov    0x20(%rsi,%r8,1),%edx
    4f36:	48 0f af fa          	imul   %rdx,%rdi
    4f3a:	48 c1 ef 20          	shr    $0x20,%rdi
    4f3e:	48 8d 1c 0f          	lea    (%rdi,%rcx,1),%rbx
    4f42:	48 81 c3 28 02 00 00 	add    $0x228,%rbx
    4f49:	80 3b ff             	cmpb   $0xff,(%rbx)
    4f4c:	75 bf                	jne    4f0d <e37+0x6d>
    4f4e:	48 89 df             	mov    %rbx,%rdi
    4f51:	49 89 c6             	mov    %rax,%r14
    4f54:	e8 07 14 00 00       	call   6360 <fwp_rc_forget_slot>
    4f59:	4c 89 f0             	mov    %r14,%rax
    4f5c:	eb af                	jmp    4f0d <e37+0x6d>
    4f5e:	48 39 d1             	cmp    %rdx,%rcx
    4f61:	73 5f                	jae    4fc2 <e37+0x122>
    4f63:	48 8b 15 8e e2 00 00 	mov    0xe28e(%rip),%rdx        # 131f8 <fwp_gc+0x1078>
    4f6a:	48 89 ce             	mov    %rcx,%rsi
    4f6d:	48 c1 ee 10          	shr    $0x10,%rsi
    4f71:	48 69 f6 28 12 00 00 	imul   $0x1228,%rsi,%rsi
    4f78:	0f b6 3c 32          	movzbl (%rdx,%rsi,1),%edi
    4f7c:	48 81 e1 ff ff 00 00 	and    $0xffff,%rcx
    4f83:	75 18                	jne    4f9d <e37+0xfd>
    4f85:	40 80 ff 02          	cmp    $0x2,%dil
    4f89:	75 12                	jne    4f9d <e37+0xfd>
    4f8b:	48 8d 0c 32          	lea    (%rdx,%rsi,1),%rcx
    4f8f:	48 81 c1 28 02 00 00 	add    $0x228,%rcx
    4f96:	80 39 00             	cmpb   $0x0,(%rcx)
    4f99:	74 27                	je     4fc2 <e37+0x122>
    4f9b:	eb 2d                	jmp    4fca <e37+0x12a>
    4f9d:	40 80 ff 01          	cmp    $0x1,%dil
    4fa1:	75 1f                	jne    4fc2 <e37+0x122>
    4fa3:	48 8d 3c 32          	lea    (%rdx,%rsi,1),%rdi
    4fa7:	8b 54 32 20          	mov    0x20(%rdx,%rsi,1),%edx
    4fab:	48 0f af ca          	imul   %rdx,%rcx
    4faf:	48 c1 e9 20          	shr    $0x20,%rcx
    4fb3:	48 01 f9             	add    %rdi,%rcx
    4fb6:	48 81 c1 28 02 00 00 	add    $0x228,%rcx
    4fbd:	80 39 00             	cmpb   $0x0,(%rcx)
    4fc0:	75 08                	jne    4fca <e37+0x12a>
    4fc2:	48 83 c4 08          	add    $0x8,%rsp
    4fc6:	5b                   	pop    %rbx
    4fc7:	41 5e                	pop    %r14
    4fc9:	c3                   	ret
    4fca:	e8 61 13 00 00       	call   6330 <fwp_flush>
    4fcf:	48 8b 05 0a d0 00 00 	mov    0xd00a(%rip),%rax        # 11fe0 <stderr@GLIBC_2.2.5>
    4fd6:	48 8b 38             	mov    (%rax),%rdi
    4fd9:	48 8d 35 4d a4 00 00 	lea    0xa44d(%rip),%rsi        # f42d <fwp_segv.msg+0x1ed>
    4fe0:	48 8d 15 19 a4 00 00 	lea    0xa419(%rip),%rdx        # f400 <fwp_segv.msg+0x1c0>
    4fe7:	31 c0                	xor    %eax,%eax
    4fe9:	e8 c2 d1 ff ff       	call   21b0 <fprintf@plt>
    4fee:	bf 65 00 00 00       	mov    $0x65,%edi
    4ff3:	e8 98 d2 ff ff       	call   2290 <exit@plt>
    4ff8:	0f 1f 84 00 00 00 00 	nopl   0x0(%rax,%rax,1)
    4fff:	00 

0000000000005000 <e45>:
    5000:	f2 0f 10 07          	movsd  (%rdi),%xmm0
    5004:	f2 0f 58 47 08       	addsd  0x8(%rdi),%xmm0
    5009:	66 48 0f 7e c0       	movq   %xmm0,%rax
    500e:	48 89 c1             	mov    %rax,%rcx
    5011:	48 2b 0d 98 e1 00 00 	sub    0xe198(%rip),%rcx        # 131b0 <fwp_gc+0x1030>
    5018:	48 8b 15 b9 e1 00 00 	mov    0xe1b9(%rip),%rdx        # 131d8 <fwp_gc+0x1058>
    501f:	48 c1 e2 10          	shl    $0x10,%rdx
    5023:	48 39 d1             	cmp    %rdx,%rcx
    5026:	73 5f                	jae    5087 <e45+0x87>
    5028:	48 8b 15 c9 e1 00 00 	mov    0xe1c9(%rip),%rdx        # 131f8 <fwp_gc+0x1078>
    502f:	48 89 ce             	mov    %rcx,%rsi
    5032:	48 c1 ee 10          	shr    $0x10,%rsi
    5036:	48 69 f6 28 12 00 00 	imul   $0x1228,%rsi,%rsi
    503d:	0f b6 3c 32          	movzbl (%rdx,%rsi,1),%edi
    5041:	48 81 e1 ff ff 00 00 	and    $0xffff,%rcx
    5048:	75 18                	jne    5062 <e45+0x62>
    504a:	40 80 ff 02          	cmp    $0x2,%dil
    504e:	75 12                	jne    5062 <e45+0x62>
    5050:	48 8d 0c 32          	lea    (%rdx,%rsi,1),%rcx
    5054:	48 81 c1 28 02 00 00 	add    $0x228,%rcx
    505b:	80 39 00             	cmpb   $0x0,(%rcx)
    505e:	74 27                	je     5087 <e45+0x87>
    5060:	eb 26                	jmp    5088 <e45+0x88>
    5062:	40 80 ff 01          	cmp    $0x1,%dil
    5066:	75 1f                	jne    5087 <e45+0x87>
    5068:	48 8d 3c 32          	lea    (%rdx,%rsi,1),%rdi
    506c:	8b 54 32 20          	mov    0x20(%rdx,%rsi,1),%edx
    5070:	48 0f af ca          	imul   %rdx,%rcx
    5074:	48 c1 e9 20          	shr    $0x20,%rcx
    5078:	48 01 f9             	add    %rdi,%rcx
    507b:	48 81 c1 28 02 00 00 	add    $0x228,%rcx
    5082:	80 39 00             	cmpb   $0x0,(%rcx)
    5085:	75 01                	jne    5088 <e45+0x88>
    5087:	c3                   	ret
    5088:	50                   	push   %rax
    5089:	e8 a2 12 00 00       	call   6330 <fwp_flush>
    508e:	48 8b 05 4b cf 00 00 	mov    0xcf4b(%rip),%rax        # 11fe0 <stderr@GLIBC_2.2.5>
    5095:	48 8b 38             	mov    (%rax),%rdi
    5098:	48 8d 35 8e a3 00 00 	lea    0xa38e(%rip),%rsi        # f42d <fwp_segv.msg+0x1ed>
    509f:	48 8d 15 5a a3 00 00 	lea    0xa35a(%rip),%rdx        # f400 <fwp_segv.msg+0x1c0>
    50a6:	31 c0                	xor    %eax,%eax
    50a8:	e8 03 d1 ff ff       	call   21b0 <fprintf@plt>
    50ad:	bf 65 00 00 00       	mov    $0x65,%edi
    50b2:	e8 d9 d1 ff ff       	call   2290 <exit@plt>
    50b7:	66 0f 1f 84 00 00 00 	nopw   0x0(%rax,%rax,1)
    50be:	00 00 

00000000000050c0 <e46>:
    50c0:	f2 0f 10 07          	movsd  (%rdi),%xmm0
    50c4:	f2 0f 59 47 08       	mulsd  0x8(%rdi),%xmm0
    50c9:	66 48 0f 7e c0       	movq   %xmm0,%rax
    50ce:	48 89 c1             	mov    %rax,%rcx
    50d1:	48 2b 0d d8 e0 00 00 	sub    0xe0d8(%rip),%rcx        # 131b0 <fwp_gc+0x1030>
    50d8:	48 8b 15 f9 e0 00 00 	mov    0xe0f9(%rip),%rdx        # 131d8 <fwp_gc+0x1058>
    50df:	48 c1 e2 10          	shl    $0x10,%rdx
    50e3:	48 39 d1             	cmp    %rdx,%rcx
    50e6:	73 5f                	jae    5147 <e46+0x87>
    50e8:	48 8b 15 09 e1 00 00 	mov    0xe109(%rip),%rdx        # 131f8 <fwp_gc+0x1078>
    50ef:	48 89 ce             	mov    %rcx,%rsi
    50f2:	48 c1 ee 10          	shr    $0x10,%rsi
    50f6:	48 69 f6 28 12 00 00 	imul   $0x1228,%rsi,%rsi
    50fd:	0f b6 3c 32          	movzbl (%rdx,%rsi,1),%edi
    5101:	48 81 e1 ff ff 00 00 	and    $0xffff,%rcx
    5108:	75 18                	jne    5122 <e46+0x62>
    510a:	40 80 ff 02          	cmp    $0x2,%dil
    510e:	75 12                	jne    5122 <e46+0x62>
    5110:	48 8d 0c 32          	lea    (%rdx,%rsi,1),%rcx
    5114:	48 81 c1 28 02 00 00 	add    $0x228,%rcx
    511b:	80 39 00             	cmpb   $0x0,(%rcx)
    511e:	74 27                	je     5147 <e46+0x87>
    5120:	eb 26                	jmp    5148 <e46+0x88>
    5122:	40 80 ff 01          	cmp    $0x1,%dil
    5126:	75 1f                	jne    5147 <e46+0x87>
    5128:	48 8d 3c 32          	lea    (%rdx,%rsi,1),%rdi
    512c:	8b 54 32 20          	mov    0x20(%rdx,%rsi,1),%edx
    5130:	48 0f af ca          	imul   %rdx,%rcx
    5134:	48 c1 e9 20          	shr    $0x20,%rcx
    5138:	48 01 f9             	add    %rdi,%rcx
    513b:	48 81 c1 28 02 00 00 	add    $0x228,%rcx
    5142:	80 39 00             	cmpb   $0x0,(%rcx)
    5145:	75 01                	jne    5148 <e46+0x88>
    5147:	c3                   	ret
    5148:	50                   	push   %rax
    5149:	e8 e2 11 00 00       	call   6330 <fwp_flush>
    514e:	48 8b 05 8b ce 00 00 	mov    0xce8b(%rip),%rax        # 11fe0 <stderr@GLIBC_2.2.5>
    5155:	48 8b 38             	mov    (%rax),%rdi
    5158:	48 8d 35 ce a2 00 00 	lea    0xa2ce(%rip),%rsi        # f42d <fwp_segv.msg+0x1ed>
    515f:	48 8d 15 9a a2 00 00 	lea    0xa29a(%rip),%rdx        # f400 <fwp_segv.msg+0x1c0>
    5166:	31 c0                	xor    %eax,%eax
    5168:	e8 43 d0 ff ff       	call   21b0 <fprintf@plt>
    516d:	bf 65 00 00 00       	mov    $0x65,%edi
    5172:	e8 19 d1 ff ff       	call   2290 <exit@plt>
    5177:	66 0f 1f 84 00 00 00 	nopw   0x0(%rax,%rax,1)
    517e:	00 00 

0000000000005180 <e47>:
    5180:	50                   	push   %rax
    5181:	48 8b 77 08          	mov    0x8(%rdi),%rsi
    5185:	48 89 f0             	mov    %rsi,%rax
    5188:	48 2b 05 21 e0 00 00 	sub    0xe021(%rip),%rax        # 131b0 <fwp_gc+0x1030>
    518f:	48 8b 0d 42 e0 00 00 	mov    0xe042(%rip),%rcx        # 131d8 <fwp_gc+0x1058>
    5196:	48 c1 e1 10          	shl    $0x10,%rcx
    519a:	48 39 c8             	cmp    %rcx,%rax
    519d:	73 64                	jae    5203 <e47+0x83>
    519f:	48 8b 0d 52 e0 00 00 	mov    0xe052(%rip),%rcx        # 131f8 <fwp_gc+0x1078>
    51a6:	48 89 c2             	mov    %rax,%rdx
    51a9:	48 c1 ea 10          	shr    $0x10,%rdx
    51ad:	48 69 d2 28 12 00 00 	imul   $0x1228,%rdx,%rdx
    51b4:	44 0f b6 04 11       	movzbl (%rcx,%rdx,1),%r8d
    51b9:	48 25 ff ff 00 00    	and    $0xffff,%rax
    51bf:	75 1a                	jne    51db <e47+0x5b>
    51c1:	41 80 f8 02          	cmp    $0x2,%r8b
    51c5:	75 14                	jne    51db <e47+0x5b>
    51c7:	48 8d 04 11          	lea    (%rcx,%rdx,1),%rax
    51cb:	48 05 28 02 00 00    	add    $0x228,%rax
    51d1:	80 38 00             	cmpb   $0x0,(%rax)
    51d4:	74 2d                	je     5203 <e47+0x83>
    51d6:	e9 b2 00 00 00       	jmp    528d <e47+0x10d>
    51db:	41 80 f8 01          	cmp    $0x1,%r8b
    51df:	75 22                	jne    5203 <e47+0x83>
    51e1:	4c 8d 04 11          	lea    (%rcx,%rdx,1),%r8
    51e5:	8b 4c 11 20          	mov    0x20(%rcx,%rdx,1),%ecx
    51e9:	48 0f af c1          	imul   %rcx,%rax
    51ed:	48 c1 e8 20          	shr    $0x20,%rax
    51f1:	4c 01 c0             	add    %r8,%rax
    51f4:	48 05 28 02 00 00    	add    $0x228,%rax
    51fa:	80 38 00             	cmpb   $0x0,(%rax)
    51fd:	0f 85 8a 00 00 00    	jne    528d <e47+0x10d>
    5203:	48 8b 3f             	mov    (%rdi),%rdi
    5206:	48 8d 15 43 ca 00 00 	lea    0xca43(%rip),%rdx        # 11c50 <d0>
    520d:	e8 ce 4a 00 00       	call   9ce0 <fwp_p_array_get_typed>
    5212:	48 89 c1             	mov    %rax,%rcx
    5215:	48 2b 0d 94 df 00 00 	sub    0xdf94(%rip),%rcx        # 131b0 <fwp_gc+0x1030>
    521c:	48 8b 15 b5 df 00 00 	mov    0xdfb5(%rip),%rdx        # 131d8 <fwp_gc+0x1058>
    5223:	48 c1 e2 10          	shl    $0x10,%rdx
    5227:	48 39 d1             	cmp    %rdx,%rcx
    522a:	73 5f                	jae    528b <e47+0x10b>
    522c:	48 8b 15 c5 df 00 00 	mov    0xdfc5(%rip),%rdx        # 131f8 <fwp_gc+0x1078>
    5233:	48 89 ce             	mov    %rcx,%rsi
    5236:	48 c1 ee 10          	shr    $0x10,%rsi
    523a:	48 69 f6 28 12 00 00 	imul   $0x1228,%rsi,%rsi
    5241:	0f b6 3c 32          	movzbl (%rdx,%rsi,1),%edi
    5245:	48 81 e1 ff ff 00 00 	and    $0xffff,%rcx
    524c:	75 18                	jne    5266 <e47+0xe6>
    524e:	40 80 ff 02          	cmp    $0x2,%dil
    5252:	75 12                	jne    5266 <e47+0xe6>
    5254:	48 8d 0c 32          	lea    (%rdx,%rsi,1),%rcx
    5258:	48 81 c1 28 02 00 00 	add    $0x228,%rcx
    525f:	80 39 00             	cmpb   $0x0,(%rcx)
    5262:	74 27                	je     528b <e47+0x10b>
    5264:	eb 27                	jmp    528d <e47+0x10d>
    5266:	40 80 ff 01          	cmp    $0x1,%dil
    526a:	75 1f                	jne    528b <e47+0x10b>
    526c:	48 8d 3c 32          	lea    (%rdx,%rsi,1),%rdi
    5270:	8b 54 32 20          	mov    0x20(%rdx,%rsi,1),%edx
    5274:	48 0f af ca          	imul   %rdx,%rcx
    5278:	48 c1 e9 20          	shr    $0x20,%rcx
    527c:	48 01 f9             	add    %rdi,%rcx
    527f:	48 81 c1 28 02 00 00 	add    $0x228,%rcx
    5286:	80 39 00             	cmpb   $0x0,(%rcx)
    5289:	75 02                	jne    528d <e47+0x10d>
    528b:	59                   	pop    %rcx
    528c:	c3                   	ret
    528d:	e8 9e 10 00 00       	call   6330 <fwp_flush>
    5292:	48 8b 05 47 cd 00 00 	mov    0xcd47(%rip),%rax        # 11fe0 <stderr@GLIBC_2.2.5>
    5299:	48 8b 38             	mov    (%rax),%rdi
    529c:	48 8d 35 8a a1 00 00 	lea    0xa18a(%rip),%rsi        # f42d <fwp_segv.msg+0x1ed>
    52a3:	48 8d 15 56 a1 00 00 	lea    0xa156(%rip),%rdx        # f400 <fwp_segv.msg+0x1c0>
    52aa:	31 c0                	xor    %eax,%eax
    52ac:	e8 ff ce ff ff       	call   21b0 <fprintf@plt>
    52b1:	bf 65 00 00 00       	mov    $0x65,%edi
    52b6:	e8 d5 cf ff ff       	call   2290 <exit@plt>
    52bb:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)

00000000000052c0 <e48>:
    52c0:	53                   	push   %rbx
    52c1:	48 83 ec 60          	sub    $0x60,%rsp
    52c5:	48 8b 47 08          	mov    0x8(%rdi),%rax
    52c9:	48 03 07             	add    (%rdi),%rax
    52cc:	70 7f                	jo     534d <e48+0x8d>
    52ce:	48 89 c1             	mov    %rax,%rcx
    52d1:	48 2b 0d d8 de 00 00 	sub    0xded8(%rip),%rcx        # 131b0 <fwp_gc+0x1030>
    52d8:	48 8b 15 f9 de 00 00 	mov    0xdef9(%rip),%rdx        # 131d8 <fwp_gc+0x1058>
    52df:	48 c1 e2 10          	shl    $0x10,%rdx
    52e3:	48 39 d1             	cmp    %rdx,%rcx
    52e6:	73 5f                	jae    5347 <e48+0x87>
    52e8:	48 8b 15 09 df 00 00 	mov    0xdf09(%rip),%rdx        # 131f8 <fwp_gc+0x1078>
    52ef:	48 89 ce             	mov    %rcx,%rsi
    52f2:	48 c1 ee 10          	shr    $0x10,%rsi
    52f6:	48 69 f6 28 12 00 00 	imul   $0x1228,%rsi,%rsi
    52fd:	0f b6 3c 32          	movzbl (%rdx,%rsi,1),%edi
    5301:	48 81 e1 ff ff 00 00 	and    $0xffff,%rcx
    5308:	75 18                	jne    5322 <e48+0x62>
    530a:	40 80 ff 02          	cmp    $0x2,%dil
    530e:	75 12                	jne    5322 <e48+0x62>
    5310:	48 8d 0c 32          	lea    (%rdx,%rsi,1),%rcx
    5314:	48 81 c1 28 02 00 00 	add    $0x228,%rcx
    531b:	80 39 00             	cmpb   $0x0,(%rcx)
    531e:	74 27                	je     5347 <e48+0x87>
    5320:	eb 66                	jmp    5388 <e48+0xc8>
    5322:	40 80 ff 01          	cmp    $0x1,%dil
    5326:	75 1f                	jne    5347 <e48+0x87>
    5328:	48 8d 3c 32          	lea    (%rdx,%rsi,1),%rdi
    532c:	8b 54 32 20          	mov    0x20(%rdx,%rsi,1),%edx
    5330:	48 0f af ca          	imul   %rdx,%rcx
    5334:	48 c1 e9 20          	shr    $0x20,%rcx
    5338:	48 01 f9             	add    %rdi,%rcx
    533b:	48 81 c1 28 02 00 00 	add    $0x228,%rcx
    5342:	80 39 00             	cmpb   $0x0,(%rcx)
    5345:	75 41                	jne    5388 <e48+0xc8>
    5347:	48 83 c4 60          	add    $0x60,%rsp
    534b:	5b                   	pop    %rbx
    534c:	c3                   	ret
    534d:	48 8d 15 37 a3 00 00 	lea    0xa337(%rip),%rdx        # f68b <fwp_segv.msg+0x44b>
    5354:	48 8d 0d 4a a3 00 00 	lea    0xa34a(%rip),%rcx        # f6a5 <fwp_segv.msg+0x465>
    535b:	48 89 e3             	mov    %rsp,%rbx
    535e:	be 60 00 00 00       	mov    $0x60,%esi
    5363:	48 89 df             	mov    %rbx,%rdi
    5366:	31 c0                	xor    %eax,%eax
    5368:	e8 a3 cd ff ff       	call   2110 <snprintf@plt>
    536d:	e8 be 0f 00 00       	call   6330 <fwp_flush>
    5372:	48 8b 05 67 cc 00 00 	mov    0xcc67(%rip),%rax        # 11fe0 <stderr@GLIBC_2.2.5>
    5379:	48 8b 38             	mov    (%rax),%rdi
    537c:	48 8d 35 aa a0 00 00 	lea    0xa0aa(%rip),%rsi        # f42d <fwp_segv.msg+0x1ed>
    5383:	48 89 da             	mov    %rbx,%rdx
    5386:	eb 1d                	jmp    53a5 <e48+0xe5>
    5388:	e8 a3 0f 00 00       	call   6330 <fwp_flush>
    538d:	48 8b 05 4c cc 00 00 	mov    0xcc4c(%rip),%rax        # 11fe0 <stderr@GLIBC_2.2.5>
    5394:	48 8b 38             	mov    (%rax),%rdi
    5397:	48 8d 35 8f a0 00 00 	lea    0xa08f(%rip),%rsi        # f42d <fwp_segv.msg+0x1ed>
    539e:	48 8d 15 5b a0 00 00 	lea    0xa05b(%rip),%rdx        # f400 <fwp_segv.msg+0x1c0>
    53a5:	31 c0                	xor    %eax,%eax
    53a7:	e8 04 ce ff ff       	call   21b0 <fprintf@plt>
    53ac:	bf 65 00 00 00       	mov    $0x65,%edi
    53b1:	e8 da ce ff ff       	call   2290 <exit@plt>
    53b6:	66 2e 0f 1f 84 00 00 	cs nopw 0x0(%rax,%rax,1)
    53bd:	00 00 00 

00000000000053c0 <e49>:
    53c0:	50                   	push   %rax
    53c1:	48 8b 3f             	mov    (%rdi),%rdi
    53c4:	48 89 f8             	mov    %rdi,%rax
    53c7:	48 2b 05 e2 dd 00 00 	sub    0xdde2(%rip),%rax        # 131b0 <fwp_gc+0x1030>
    53ce:	48 8b 0d 03 de 00 00 	mov    0xde03(%rip),%rcx        # 131d8 <fwp_gc+0x1058>
    53d5:	48 c1 e1 10          	shl    $0x10,%rcx
    53d9:	48 39 c8             	cmp    %rcx,%rax
    53dc:	73 63                	jae    5441 <e49+0x81>
    53de:	48 8b 0d 13 de 00 00 	mov    0xde13(%rip),%rcx        # 131f8 <fwp_gc+0x1078>
    53e5:	48 89 c2             	mov    %rax,%rdx
    53e8:	48 c1 ea 10          	shr    $0x10,%rdx
    53ec:	48 69 d2 28 12 00 00 	imul   $0x1228,%rdx,%rdx
    53f3:	0f b6 34 11          	movzbl (%rcx,%rdx,1),%esi
    53f7:	48 25 ff ff 00 00    	and    $0xffff,%rax
    53fd:	75 1a                	jne    5419 <e49+0x59>
    53ff:	40 80 fe 02          	cmp    $0x2,%sil
    5403:	75 14                	jne    5419 <e49+0x59>
    5405:	48 8d 04 11          	lea    (%rcx,%rdx,1),%rax
    5409:	48 05 28 02 00 00    	add    $0x228,%rax
    540f:	80 38 00             	cmpb   $0x0,(%rax)
    5412:	74 2d                	je     5441 <e49+0x81>
    5414:	e9 a8 00 00 00       	jmp    54c1 <e49+0x101>
    5419:	40 80 fe 01          	cmp    $0x1,%sil
    541d:	75 22                	jne    5441 <e49+0x81>
    541f:	48 8d 34 11          	lea    (%rcx,%rdx,1),%rsi
    5423:	8b 4c 11 20          	mov    0x20(%rcx,%rdx,1),%ecx
    5427:	48 0f af c1          	imul   %rcx,%rax
    542b:	48 c1 e8 20          	shr    $0x20,%rax
    542f:	48 01 f0             	add    %rsi,%rax
    5432:	48 05 28 02 00 00    	add    $0x228,%rax
    5438:	80 38 00             	cmpb   $0x0,(%rax)
    543b:	0f 85 80 00 00 00    	jne    54c1 <e49+0x101>
    5441:	e8 0a 4c 00 00       	call   a050 <f49>
    5446:	48 89 c1             	mov    %rax,%rcx
    5449:	48 2b 0d 60 dd 00 00 	sub    0xdd60(%rip),%rcx        # 131b0 <fwp_gc+0x1030>
    5450:	48 8b 15 81 dd 00 00 	mov    0xdd81(%rip),%rdx        # 131d8 <fwp_gc+0x1058>
    5457:	48 c1 e2 10          	shl    $0x10,%rdx
    545b:	48 39 d1             	cmp    %rdx,%rcx
    545e:	73 5f                	jae    54bf <e49+0xff>
    5460:	48 8b 15 91 dd 00 00 	mov    0xdd91(%rip),%rdx        # 131f8 <fwp_gc+0x1078>
    5467:	48 89 ce             	mov    %rcx,%rsi
    546a:	48 c1 ee 10          	shr    $0x10,%rsi
    546e:	48 69 f6 28 12 00 00 	imul   $0x1228,%rsi,%rsi
    5475:	0f b6 3c 32          	movzbl (%rdx,%rsi,1),%edi
    5479:	48 81 e1 ff ff 00 00 	and    $0xffff,%rcx
    5480:	75 18                	jne    549a <e49+0xda>
    5482:	40 80 ff 02          	cmp    $0x2,%dil
    5486:	75 12                	jne    549a <e49+0xda>
    5488:	48 8d 0c 32          	lea    (%rdx,%rsi,1),%rcx
    548c:	48 81 c1 28 02 00 00 	add    $0x228,%rcx
    5493:	80 39 00             	cmpb   $0x0,(%rcx)
    5496:	74 27                	je     54bf <e49+0xff>
    5498:	eb 27                	jmp    54c1 <e49+0x101>
    549a:	40 80 ff 01          	cmp    $0x1,%dil
    549e:	75 1f                	jne    54bf <e49+0xff>
    54a0:	48 8d 3c 32          	lea    (%rdx,%rsi,1),%rdi
    54a4:	8b 54 32 20          	mov    0x20(%rdx,%rsi,1),%edx
    54a8:	48 0f af ca          	imul   %rdx,%rcx
    54ac:	48 c1 e9 20          	shr    $0x20,%rcx
    54b0:	48 01 f9             	add    %rdi,%rcx
    54b3:	48 81 c1 28 02 00 00 	add    $0x228,%rcx
    54ba:	80 39 00             	cmpb   $0x0,(%rcx)
    54bd:	75 02                	jne    54c1 <e49+0x101>
    54bf:	59                   	pop    %rcx
    54c0:	c3                   	ret
    54c1:	e8 6a 0e 00 00       	call   6330 <fwp_flush>
    54c6:	48 8b 05 13 cb 00 00 	mov    0xcb13(%rip),%rax        # 11fe0 <stderr@GLIBC_2.2.5>
    54cd:	48 8b 38             	mov    (%rax),%rdi
    54d0:	48 8d 35 56 9f 00 00 	lea    0x9f56(%rip),%rsi        # f42d <fwp_segv.msg+0x1ed>
    54d7:	48 8d 15 22 9f 00 00 	lea    0x9f22(%rip),%rdx        # f400 <fwp_segv.msg+0x1c0>
    54de:	31 c0                	xor    %eax,%eax
    54e0:	e8 cb cc ff ff       	call   21b0 <fprintf@plt>
    54e5:	bf 65 00 00 00       	mov    $0x65,%edi
    54ea:	e8 a1 cd ff ff       	call   2290 <exit@plt>
    54ef:	90                   	nop

00000000000054f0 <e50>:
    54f0:	50                   	push   %rax
    54f1:	48 89 f8             	mov    %rdi,%rax
    54f4:	48 8b 3f             	mov    (%rdi),%rdi
    54f7:	48 8b 0d b2 dc 00 00 	mov    0xdcb2(%rip),%rcx        # 131b0 <fwp_gc+0x1030>
    54fe:	48 89 fe             	mov    %rdi,%rsi
    5501:	48 29 ce             	sub    %rcx,%rsi
    5504:	48 8b 15 cd dc 00 00 	mov    0xdccd(%rip),%rdx        # 131d8 <fwp_gc+0x1058>
    550b:	48 c1 e2 10          	shl    $0x10,%rdx
    550f:	48 39 d6             	cmp    %rdx,%rsi
    5512:	73 68                	jae    557c <e50+0x8c>
    5514:	4c 8b 05 dd dc 00 00 	mov    0xdcdd(%rip),%r8        # 131f8 <fwp_gc+0x1078>
    551b:	49 89 f1             	mov    %rsi,%r9
    551e:	49 c1 e9 10          	shr    $0x10,%r9
    5522:	4d 69 c9 28 12 00 00 	imul   $0x1228,%r9,%r9
    5529:	47 0f b6 14 08       	movzbl (%r8,%r9,1),%r10d
    552e:	48 81 e6 ff ff 00 00 	and    $0xffff,%rsi
    5535:	75 1b                	jne    5552 <e50+0x62>
    5537:	41 80 fa 02          	cmp    $0x2,%r10b
    553b:	75 15                	jne    5552 <e50+0x62>
    553d:	4b 8d 34 08          	lea    (%r8,%r9,1),%rsi
    5541:	48 81 c6 28 02 00 00 	add    $0x228,%rsi
    5548:	80 3e 00             	cmpb   $0x0,(%rsi)
    554b:	74 2f                	je     557c <e50+0x8c>
    554d:	e9 24 01 00 00       	jmp    5676 <e50+0x186>
    5552:	41 80 fa 01          	cmp    $0x1,%r10b
    5556:	75 24                	jne    557c <e50+0x8c>
    5558:	4f 8d 14 08          	lea    (%r8,%r9,1),%r10
    555c:	47 8b 44 08 20       	mov    0x20(%r8,%r9,1),%r8d
    5561:	49 0f af f0          	imul   %r8,%rsi
    5565:	48 c1 ee 20          	shr    $0x20,%rsi
    5569:	4c 01 d6             	add    %r10,%rsi
    556c:	48 81 c6 28 02 00 00 	add    $0x228,%rsi
    5573:	80 3e 00             	cmpb   $0x0,(%rsi)
    5576:	0f 85 fa 00 00 00    	jne    5676 <e50+0x186>
    557c:	48 8b 70 08          	mov    0x8(%rax),%rsi
    5580:	48 89 f0             	mov    %rsi,%rax
    5583:	48 29 c8             	sub    %rcx,%rax
    5586:	48 39 d0             	cmp    %rdx,%rax
    5589:	73 64                	jae    55ef <e50+0xff>
    558b:	48 8b 0d 66 dc 00 00 	mov    0xdc66(%rip),%rcx        # 131f8 <fwp_gc+0x1078>
    5592:	48 89 c2             	mov    %rax,%rdx
    5595:	48 c1 ea 10          	shr    $0x10,%rdx
    5599:	48 69 d2 28 12 00 00 	imul   $0x1228,%rdx,%rdx
    55a0:	44 0f b6 04 11       	movzbl (%rcx,%rdx,1),%r8d
    55a5:	48 25 ff ff 00 00    	and    $0xffff,%rax
    55ab:	75 1a                	jne    55c7 <e50+0xd7>
    55ad:	41 80 f8 02          	cmp    $0x2,%r8b
    55b1:	75 14                	jne    55c7 <e50+0xd7>
    55b3:	48 8d 04 11          	lea    (%rcx,%rdx,1),%rax
    55b7:	48 05 28 02 00 00    	add    $0x228,%rax
    55bd:	80 38 00             	cmpb   $0x0,(%rax)
    55c0:	74 2d                	je     55ef <e50+0xff>
    55c2:	e9 af 00 00 00       	jmp    5676 <e50+0x186>
    55c7:	41 80 f8 01          	cmp    $0x1,%r8b
    55cb:	75 22                	jne    55ef <e50+0xff>
    55cd:	4c 8d 04 11          	lea    (%rcx,%rdx,1),%r8
    55d1:	8b 4c 11 20          	mov    0x20(%rcx,%rdx,1),%ecx
    55d5:	48 0f af c1          	imul   %rcx,%rax
    55d9:	48 c1 e8 20          	shr    $0x20,%rax
    55dd:	4c 01 c0             	add    %r8,%rax
    55e0:	48 05 28 02 00 00    	add    $0x228,%rax
    55e6:	80 38 00             	cmpb   $0x0,(%rax)
    55e9:	0f 85 87 00 00 00    	jne    5676 <e50+0x186>
    55ef:	48 8d 15 5a 5b 00 00 	lea    0x5b5a(%rip),%rdx        # b150 <fwp_drop7>
    55f6:	e8 d5 56 00 00       	call   acd0 <fwp_p_loop_own>
    55fb:	48 89 c1             	mov    %rax,%rcx
    55fe:	48 2b 0d ab db 00 00 	sub    0xdbab(%rip),%rcx        # 131b0 <fwp_gc+0x1030>
    5605:	48 8b 15 cc db 00 00 	mov    0xdbcc(%rip),%rdx        # 131d8 <fwp_gc+0x1058>
    560c:	48 c1 e2 10          	shl    $0x10,%rdx
    5610:	48 39 d1             	cmp    %rdx,%rcx
    5613:	73 5f                	jae    5674 <e50+0x184>
    5615:	48 8b 15 dc db 00 00 	mov    0xdbdc(%rip),%rdx        # 131f8 <fwp_gc+0x1078>
    561c:	48 89 ce             	mov    %rcx,%rsi
    561f:	48 c1 ee 10          	shr    $0x10,%rsi
    5623:	48 69 f6 28 12 00 00 	imul   $0x1228,%rsi,%rsi
    562a:	0f b6 3c 32          	movzbl (%rdx,%rsi,1),%edi
    562e:	48 81 e1 ff ff 00 00 	and    $0xffff,%rcx
    5635:	75 18                	jne    564f <e50+0x15f>
    5637:	40 80 ff 02          	cmp    $0x2,%dil
    563b:	75 12                	jne    564f <e50+0x15f>
    563d:	48 8d 0c 32          	lea    (%rdx,%rsi,1),%rcx
    5641:	48 81 c1 28 02 00 00 	add    $0x228,%rcx
    5648:	80 39 00             	cmpb   $0x0,(%rcx)
    564b:	74 27                	je     5674 <e50+0x184>
    564d:	eb 27                	jmp    5676 <e50+0x186>
    564f:	40 80 ff 01          	cmp    $0x1,%dil
    5653:	75 1f                	jne    5674 <e50+0x184>
    5655:	48 8d 3c 32          	lea    (%rdx,%rsi,1),%rdi
    5659:	8b 54 32 20          	mov    0x20(%rdx,%rsi,1),%edx
    565d:	48 0f af ca          	imul   %rdx,%rcx
    5661:	48 c1 e9 20          	shr    $0x20,%rcx
    5665:	48 01 f9             	add    %rdi,%rcx
    5668:	48 81 c1 28 02 00 00 	add    $0x228,%rcx
    566f:	80 39 00             	cmpb   $0x0,(%rcx)
    5672:	75 02                	jne    5676 <e50+0x186>
    5674:	59                   	pop    %rcx
    5675:	c3                   	ret
    5676:	e8 b5 0c 00 00       	call   6330 <fwp_flush>
    567b:	48 8b 05 5e c9 00 00 	mov    0xc95e(%rip),%rax        # 11fe0 <stderr@GLIBC_2.2.5>
    5682:	48 8b 38             	mov    (%rax),%rdi
    5685:	48 8d 35 a1 9d 00 00 	lea    0x9da1(%rip),%rsi        # f42d <fwp_segv.msg+0x1ed>
    568c:	48 8d 15 6d 9d 00 00 	lea    0x9d6d(%rip),%rdx        # f400 <fwp_segv.msg+0x1c0>
    5693:	31 c0                	xor    %eax,%eax
    5695:	e8 16 cb ff ff       	call   21b0 <fprintf@plt>
    569a:	bf 65 00 00 00       	mov    $0x65,%edi
    569f:	e8 ec cb ff ff       	call   2290 <exit@plt>
    56a4:	66 66 66 2e 0f 1f 84 	data16 data16 cs nopw 0x0(%rax,%rax,1)
    56ab:	00 00 00 00 00 

00000000000056b0 <e51>:
    56b0:	50                   	push   %rax
    56b1:	48 8b 77 08          	mov    0x8(%rdi),%rsi
    56b5:	48 89 f0             	mov    %rsi,%rax
    56b8:	48 2b 05 f1 da 00 00 	sub    0xdaf1(%rip),%rax        # 131b0 <fwp_gc+0x1030>
    56bf:	48 8b 0d 12 db 00 00 	mov    0xdb12(%rip),%rcx        # 131d8 <fwp_gc+0x1058>
    56c6:	48 c1 e1 10          	shl    $0x10,%rcx
    56ca:	48 39 c8             	cmp    %rcx,%rax
    56cd:	73 64                	jae    5733 <e51+0x83>
    56cf:	48 8b 0d 22 db 00 00 	mov    0xdb22(%rip),%rcx        # 131f8 <fwp_gc+0x1078>
    56d6:	48 89 c2             	mov    %rax,%rdx
    56d9:	48 c1 ea 10          	shr    $0x10,%rdx
    56dd:	48 69 d2 28 12 00 00 	imul   $0x1228,%rdx,%rdx
    56e4:	44 0f b6 04 11       	movzbl (%rcx,%rdx,1),%r8d
    56e9:	48 25 ff ff 00 00    	and    $0xffff,%rax
    56ef:	75 1a                	jne    570b <e51+0x5b>
    56f1:	41 80 f8 02          	cmp    $0x2,%r8b
    56f5:	75 14                	jne    570b <e51+0x5b>
    56f7:	48 8d 04 11          	lea    (%rcx,%rdx,1),%rax
    56fb:	48 05 28 02 00 00    	add    $0x228,%rax
    5701:	80 38 00             	cmpb   $0x0,(%rax)
    5704:	74 2d                	je     5733 <e51+0x83>
    5706:	e9 b2 00 00 00       	jmp    57bd <e51+0x10d>
    570b:	41 80 f8 01          	cmp    $0x1,%r8b
    570f:	75 22                	jne    5733 <e51+0x83>
    5711:	4c 8d 04 11          	lea    (%rcx,%rdx,1),%r8
    5715:	8b 4c 11 20          	mov    0x20(%rcx,%rdx,1),%ecx
    5719:	48 0f af c1          	imul   %rcx,%rax
    571d:	48 c1 e8 20          	shr    $0x20,%rax
    5721:	4c 01 c0             	add    %r8,%rax
    5724:	48 05 28 02 00 00    	add    $0x228,%rax
    572a:	80 38 00             	cmpb   $0x0,(%rax)
    572d:	0f 85 8a 00 00 00    	jne    57bd <e51+0x10d>
    5733:	48 8b 3f             	mov    (%rdi),%rdi
    5736:	48 8d 15 d3 c5 00 00 	lea    0xc5d3(%rip),%rdx        # 11d10 <d2>
    573d:	e8 9e 45 00 00       	call   9ce0 <fwp_p_array_get_typed>
    5742:	48 89 c1             	mov    %rax,%rcx
    5745:	48 2b 0d 64 da 00 00 	sub    0xda64(%rip),%rcx        # 131b0 <fwp_gc+0x1030>
    574c:	48 8b 15 85 da 00 00 	mov    0xda85(%rip),%rdx        # 131d8 <fwp_gc+0x1058>
    5753:	48 c1 e2 10          	shl    $0x10,%rdx
    5757:	48 39 d1             	cmp    %rdx,%rcx
    575a:	73 5f                	jae    57bb <e51+0x10b>
    575c:	48 8b 15 95 da 00 00 	mov    0xda95(%rip),%rdx        # 131f8 <fwp_gc+0x1078>
    5763:	48 89 ce             	mov    %rcx,%rsi
    5766:	48 c1 ee 10          	shr    $0x10,%rsi
    576a:	48 69 f6 28 12 00 00 	imul   $0x1228,%rsi,%rsi
    5771:	0f b6 3c 32          	movzbl (%rdx,%rsi,1),%edi
    5775:	48 81 e1 ff ff 00 00 	and    $0xffff,%rcx
    577c:	75 18                	jne    5796 <e51+0xe6>
    577e:	40 80 ff 02          	cmp    $0x2,%dil
    5782:	75 12                	jne    5796 <e51+0xe6>
    5784:	48 8d 0c 32          	lea    (%rdx,%rsi,1),%rcx
    5788:	48 81 c1 28 02 00 00 	add    $0x228,%rcx
    578f:	80 39 00             	cmpb   $0x0,(%rcx)
    5792:	74 27                	je     57bb <e51+0x10b>
    5794:	eb 27                	jmp    57bd <e51+0x10d>
    5796:	40 80 ff 01          	cmp    $0x1,%dil
    579a:	75 1f                	jne    57bb <e51+0x10b>
    579c:	48 8d 3c 32          	lea    (%rdx,%rsi,1),%rdi
    57a0:	8b 54 32 20          	mov    0x20(%rdx,%rsi,1),%edx
    57a4:	48 0f af ca          	imul   %rdx,%rcx
    57a8:	48 c1 e9 20          	shr    $0x20,%rcx
    57ac:	48 01 f9             	add    %rdi,%rcx
    57af:	48 81 c1 28 02 00 00 	add    $0x228,%rcx
    57b6:	80 39 00             	cmpb   $0x0,(%rcx)
    57b9:	75 02                	jne    57bd <e51+0x10d>
    57bb:	59                   	pop    %rcx
    57bc:	c3                   	ret
    57bd:	e8 6e 0b 00 00       	call   6330 <fwp_flush>
    57c2:	48 8b 05 17 c8 00 00 	mov    0xc817(%rip),%rax        # 11fe0 <stderr@GLIBC_2.2.5>
    57c9:	48 8b 38             	mov    (%rax),%rdi
    57cc:	48 8d 35 5a 9c 00 00 	lea    0x9c5a(%rip),%rsi        # f42d <fwp_segv.msg+0x1ed>
    57d3:	48 8d 15 26 9c 00 00 	lea    0x9c26(%rip),%rdx        # f400 <fwp_segv.msg+0x1c0>
    57da:	31 c0                	xor    %eax,%eax
    57dc:	e8 cf c9 ff ff       	call   21b0 <fprintf@plt>
    57e1:	bf 65 00 00 00       	mov    $0x65,%edi
    57e6:	e8 a5 ca ff ff       	call   2290 <exit@plt>
    57eb:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)

00000000000057f0 <e52>:
    57f0:	50                   	push   %rax
    57f1:	48 8b 3f             	mov    (%rdi),%rdi
    57f4:	48 89 f8             	mov    %rdi,%rax
    57f7:	48 2b 05 b2 d9 00 00 	sub    0xd9b2(%rip),%rax        # 131b0 <fwp_gc+0x1030>
    57fe:	48 8b 0d d3 d9 00 00 	mov    0xd9d3(%rip),%rcx        # 131d8 <fwp_gc+0x1058>
    5805:	48 c1 e1 10          	shl    $0x10,%rcx
    5809:	48 39 c8             	cmp    %rcx,%rax
    580c:	73 63                	jae    5871 <e52+0x81>
    580e:	48 8b 0d e3 d9 00 00 	mov    0xd9e3(%rip),%rcx        # 131f8 <fwp_gc+0x1078>
    5815:	48 89 c2             	mov    %rax,%rdx
    5818:	48 c1 ea 10          	shr    $0x10,%rdx
    581c:	48 69 d2 28 12 00 00 	imul   $0x1228,%rdx,%rdx
    5823:	0f b6 34 11          	movzbl (%rcx,%rdx,1),%esi
    5827:	48 25 ff ff 00 00    	and    $0xffff,%rax
    582d:	75 1a                	jne    5849 <e52+0x59>
    582f:	40 80 fe 02          	cmp    $0x2,%sil
    5833:	75 14                	jne    5849 <e52+0x59>
    5835:	48 8d 04 11          	lea    (%rcx,%rdx,1),%rax
    5839:	48 05 28 02 00 00    	add    $0x228,%rax
    583f:	80 38 00             	cmpb   $0x0,(%rax)
    5842:	74 2d                	je     5871 <e52+0x81>
    5844:	e9 a8 00 00 00       	jmp    58f1 <e52+0x101>
    5849:	40 80 fe 01          	cmp    $0x1,%sil
    584d:	75 22                	jne    5871 <e52+0x81>
    584f:	48 8d 34 11          	lea    (%rcx,%rdx,1),%rsi
    5853:	8b 4c 11 20          	mov    0x20(%rcx,%rdx,1),%ecx
    5857:	48 0f af c1          	imul   %rcx,%rax
    585b:	48 c1 e8 20          	shr    $0x20,%rax
    585f:	48 01 f0             	add    %rsi,%rax
    5862:	48 05 28 02 00 00    	add    $0x228,%rax
    5868:	80 38 00             	cmpb   $0x0,(%rax)
    586b:	0f 85 80 00 00 00    	jne    58f1 <e52+0x101>
    5871:	e8 ea 6a 00 00       	call   c360 <f52>
    5876:	48 89 c1             	mov    %rax,%rcx
    5879:	48 2b 0d 30 d9 00 00 	sub    0xd930(%rip),%rcx        # 131b0 <fwp_gc+0x1030>
    5880:	48 8b 15 51 d9 00 00 	mov    0xd951(%rip),%rdx        # 131d8 <fwp_gc+0x1058>
    5887:	48 c1 e2 10          	shl    $0x10,%rdx
    588b:	48 39 d1             	cmp    %rdx,%rcx
    588e:	73 5f                	jae    58ef <e52+0xff>
    5890:	48 8b 15 61 d9 00 00 	mov    0xd961(%rip),%rdx        # 131f8 <fwp_gc+0x1078>
    5897:	48 89 ce             	mov    %rcx,%rsi
    589a:	48 c1 ee 10          	shr    $0x10,%rsi
    589e:	48 69 f6 28 12 00 00 	imul   $0x1228,%rsi,%rsi
    58a5:	0f b6 3c 32          	movzbl (%rdx,%rsi,1),%edi
    58a9:	48 81 e1 ff ff 00 00 	and    $0xffff,%rcx
    58b0:	75 18                	jne    58ca <e52+0xda>
    58b2:	40 80 ff 02          	cmp    $0x2,%dil
    58b6:	75 12                	jne    58ca <e52+0xda>
    58b8:	48 8d 0c 32          	lea    (%rdx,%rsi,1),%rcx
    58bc:	48 81 c1 28 02 00 00 	add    $0x228,%rcx
    58c3:	80 39 00             	cmpb   $0x0,(%rcx)
    58c6:	74 27                	je     58ef <e52+0xff>
    58c8:	eb 27                	jmp    58f1 <e52+0x101>
    58ca:	40 80 ff 01          	cmp    $0x1,%dil
    58ce:	75 1f                	jne    58ef <e52+0xff>
    58d0:	48 8d 3c 32          	lea    (%rdx,%rsi,1),%rdi
    58d4:	8b 54 32 20          	mov    0x20(%rdx,%rsi,1),%edx
    58d8:	48 0f af ca          	imul   %rdx,%rcx
    58dc:	48 c1 e9 20          	shr    $0x20,%rcx
    58e0:	48 01 f9             	add    %rdi,%rcx
    58e3:	48 81 c1 28 02 00 00 	add    $0x228,%rcx
    58ea:	80 39 00             	cmpb   $0x0,(%rcx)
    58ed:	75 02                	jne    58f1 <e52+0x101>
    58ef:	59                   	pop    %rcx
    58f0:	c3                   	ret
    58f1:	e8 3a 0a 00 00       	call   6330 <fwp_flush>
    58f6:	48 8b 05 e3 c6 00 00 	mov    0xc6e3(%rip),%rax        # 11fe0 <stderr@GLIBC_2.2.5>
    58fd:	48 8b 38             	mov    (%rax),%rdi
    5900:	48 8d 35 26 9b 00 00 	lea    0x9b26(%rip),%rsi        # f42d <fwp_segv.msg+0x1ed>
    5907:	48 8d 15 f2 9a 00 00 	lea    0x9af2(%rip),%rdx        # f400 <fwp_segv.msg+0x1c0>
    590e:	31 c0                	xor    %eax,%eax
    5910:	e8 9b c8 ff ff       	call   21b0 <fprintf@plt>
    5915:	bf 65 00 00 00       	mov    $0x65,%edi
    591a:	e8 71 c9 ff ff       	call   2290 <exit@plt>
    591f:	90                   	nop

0000000000005920 <e53>:
    5920:	50                   	push   %rax
    5921:	48 89 f8             	mov    %rdi,%rax
    5924:	48 8b 3f             	mov    (%rdi),%rdi
    5927:	48 8b 0d 82 d8 00 00 	mov    0xd882(%rip),%rcx        # 131b0 <fwp_gc+0x1030>
    592e:	48 89 fe             	mov    %rdi,%rsi
    5931:	48 29 ce             	sub    %rcx,%rsi
    5934:	48 8b 15 9d d8 00 00 	mov    0xd89d(%rip),%rdx        # 131d8 <fwp_gc+0x1058>
    593b:	48 c1 e2 10          	shl    $0x10,%rdx
    593f:	48 39 d6             	cmp    %rdx,%rsi
    5942:	73 68                	jae    59ac <e53+0x8c>
    5944:	4c 8b 05 ad d8 00 00 	mov    0xd8ad(%rip),%r8        # 131f8 <fwp_gc+0x1078>
    594b:	49 89 f1             	mov    %rsi,%r9
    594e:	49 c1 e9 10          	shr    $0x10,%r9
    5952:	4d 69 c9 28 12 00 00 	imul   $0x1228,%r9,%r9
    5959:	47 0f b6 14 08       	movzbl (%r8,%r9,1),%r10d
    595e:	48 81 e6 ff ff 00 00 	and    $0xffff,%rsi
    5965:	75 1b                	jne    5982 <e53+0x62>
    5967:	41 80 fa 02          	cmp    $0x2,%r10b
    596b:	75 15                	jne    5982 <e53+0x62>
    596d:	4b 8d 34 08          	lea    (%r8,%r9,1),%rsi
    5971:	48 81 c6 28 02 00 00 	add    $0x228,%rsi
    5978:	80 3e 00             	cmpb   $0x0,(%rsi)
    597b:	74 2f                	je     59ac <e53+0x8c>
    597d:	e9 24 01 00 00       	jmp    5aa6 <e53+0x186>
    5982:	41 80 fa 01          	cmp    $0x1,%r10b
    5986:	75 24                	jne    59ac <e53+0x8c>
    5988:	4f 8d 14 08          	lea    (%r8,%r9,1),%r10
    598c:	47 8b 44 08 20       	mov    0x20(%r8,%r9,1),%r8d
    5991:	49 0f af f0          	imul   %r8,%rsi
    5995:	48 c1 ee 20          	shr    $0x20,%rsi
    5999:	4c 01 d6             	add    %r10,%rsi
    599c:	48 81 c6 28 02 00 00 	add    $0x228,%rsi
    59a3:	80 3e 00             	cmpb   $0x0,(%rsi)
    59a6:	0f 85 fa 00 00 00    	jne    5aa6 <e53+0x186>
    59ac:	48 8b 70 08          	mov    0x8(%rax),%rsi
    59b0:	48 89 f0             	mov    %rsi,%rax
    59b3:	48 29 c8             	sub    %rcx,%rax
    59b6:	48 39 d0             	cmp    %rdx,%rax
    59b9:	73 64                	jae    5a1f <e53+0xff>
    59bb:	48 8b 0d 36 d8 00 00 	mov    0xd836(%rip),%rcx        # 131f8 <fwp_gc+0x1078>
    59c2:	48 89 c2             	mov    %rax,%rdx
    59c5:	48 c1 ea 10          	shr    $0x10,%rdx
    59c9:	48 69 d2 28 12 00 00 	imul   $0x1228,%rdx,%rdx
    59d0:	44 0f b6 04 11       	movzbl (%rcx,%rdx,1),%r8d
    59d5:	48 25 ff ff 00 00    	and    $0xffff,%rax
    59db:	75 1a                	jne    59f7 <e53+0xd7>
    59dd:	41 80 f8 02          	cmp    $0x2,%r8b
    59e1:	75 14                	jne    59f7 <e53+0xd7>
    59e3:	48 8d 04 11          	lea    (%rcx,%rdx,1),%rax
    59e7:	48 05 28 02 00 00    	add    $0x228,%rax
    59ed:	80 38 00             	cmpb   $0x0,(%rax)
    59f0:	74 2d                	je     5a1f <e53+0xff>
    59f2:	e9 af 00 00 00       	jmp    5aa6 <e53+0x186>
    59f7:	41 80 f8 01          	cmp    $0x1,%r8b
    59fb:	75 22                	jne    5a1f <e53+0xff>
    59fd:	4c 8d 04 11          	lea    (%rcx,%rdx,1),%r8
    5a01:	8b 4c 11 20          	mov    0x20(%rcx,%rdx,1),%ecx
    5a05:	48 0f af c1          	imul   %rcx,%rax
    5a09:	48 c1 e8 20          	shr    $0x20,%rax
    5a0d:	4c 01 c0             	add    %r8,%rax
    5a10:	48 05 28 02 00 00    	add    $0x228,%rax
    5a16:	80 38 00             	cmpb   $0x0,(%rax)
    5a19:	0f 85 87 00 00 00    	jne    5aa6 <e53+0x186>
    5a1f:	48 8d 15 da 6f 00 00 	lea    0x6fda(%rip),%rdx        # ca00 <fwp_drop10>
    5a26:	e8 a5 52 00 00       	call   acd0 <fwp_p_loop_own>
    5a2b:	48 89 c1             	mov    %rax,%rcx
    5a2e:	48 2b 0d 7b d7 00 00 	sub    0xd77b(%rip),%rcx        # 131b0 <fwp_gc+0x1030>
    5a35:	48 8b 15 9c d7 00 00 	mov    0xd79c(%rip),%rdx        # 131d8 <fwp_gc+0x1058>
    5a3c:	48 c1 e2 10          	shl    $0x10,%rdx
    5a40:	48 39 d1             	cmp    %rdx,%rcx
    5a43:	73 5f                	jae    5aa4 <e53+0x184>
    5a45:	48 8b 15 ac d7 00 00 	mov    0xd7ac(%rip),%rdx        # 131f8 <fwp_gc+0x1078>
    5a4c:	48 89 ce             	mov    %rcx,%rsi
    5a4f:	48 c1 ee 10          	shr    $0x10,%rsi
    5a53:	48 69 f6 28 12 00 00 	imul   $0x1228,%rsi,%rsi
    5a5a:	0f b6 3c 32          	movzbl (%rdx,%rsi,1),%edi
    5a5e:	48 81 e1 ff ff 00 00 	and    $0xffff,%rcx
    5a65:	75 18                	jne    5a7f <e53+0x15f>
    5a67:	40 80 ff 02          	cmp    $0x2,%dil
    5a6b:	75 12                	jne    5a7f <e53+0x15f>
    5a6d:	48 8d 0c 32          	lea    (%rdx,%rsi,1),%rcx
    5a71:	48 81 c1 28 02 00 00 	add    $0x228,%rcx
    5a78:	80 39 00             	cmpb   $0x0,(%rcx)
    5a7b:	74 27                	je     5aa4 <e53+0x184>
    5a7d:	eb 27                	jmp    5aa6 <e53+0x186>
    5a7f:	40 80 ff 01          	cmp    $0x1,%dil
    5a83:	75 1f                	jne    5aa4 <e53+0x184>
    5a85:	48 8d 3c 32          	lea    (%rdx,%rsi,1),%rdi
    5a89:	8b 54 32 20          	mov    0x20(%rdx,%rsi,1),%edx
    5a8d:	48 0f af ca          	imul   %rdx,%rcx
    5a91:	48 c1 e9 20          	shr    $0x20,%rcx
    5a95:	48 01 f9             	add    %rdi,%rcx
    5a98:	48 81 c1 28 02 00 00 	add    $0x228,%rcx
    5a9f:	80 39 00             	cmpb   $0x0,(%rcx)
    5aa2:	75 02                	jne    5aa6 <e53+0x186>
    5aa4:	59                   	pop    %rcx
    5aa5:	c3                   	ret
    5aa6:	e8 85 08 00 00       	call   6330 <fwp_flush>
    5aab:	48 8b 05 2e c5 00 00 	mov    0xc52e(%rip),%rax        # 11fe0 <stderr@GLIBC_2.2.5>
    5ab2:	48 8b 38             	mov    (%rax),%rdi
    5ab5:	48 8d 35 71 99 00 00 	lea    0x9971(%rip),%rsi        # f42d <fwp_segv.msg+0x1ed>
    5abc:	48 8d 15 3d 99 00 00 	lea    0x993d(%rip),%rdx        # f400 <fwp_segv.msg+0x1c0>
    5ac3:	31 c0                	xor    %eax,%eax
    5ac5:	e8 e6 c6 ff ff       	call   21b0 <fprintf@plt>
    5aca:	bf 65 00 00 00       	mov    $0x65,%edi
    5acf:	e8 bc c7 ff ff       	call   2290 <exit@plt>
    5ad4:	66 66 66 2e 0f 1f 84 	data16 data16 cs nopw 0x0(%rax,%rax,1)
    5adb:	00 00 00 00 00 

0000000000005ae0 <e54>:
    5ae0:	50                   	push   %rax
    5ae1:	48 8b 77 08          	mov    0x8(%rdi),%rsi
    5ae5:	48 89 f0             	mov    %rsi,%rax
    5ae8:	48 2b 05 c1 d6 00 00 	sub    0xd6c1(%rip),%rax        # 131b0 <fwp_gc+0x1030>
    5aef:	48 8b 0d e2 d6 00 00 	mov    0xd6e2(%rip),%rcx        # 131d8 <fwp_gc+0x1058>
    5af6:	48 c1 e1 10          	shl    $0x10,%rcx
    5afa:	48 39 c8             	cmp    %rcx,%rax
    5afd:	73 64                	jae    5b63 <e54+0x83>
    5aff:	48 8b 0d f2 d6 00 00 	mov    0xd6f2(%rip),%rcx        # 131f8 <fwp_gc+0x1078>
    5b06:	48 89 c2             	mov    %rax,%rdx
    5b09:	48 c1 ea 10          	shr    $0x10,%rdx
    5b0d:	48 69 d2 28 12 00 00 	imul   $0x1228,%rdx,%rdx
    5b14:	44 0f b6 04 11       	movzbl (%rcx,%rdx,1),%r8d
    5b19:	48 25 ff ff 00 00    	and    $0xffff,%rax
    5b1f:	75 1a                	jne    5b3b <e54+0x5b>
    5b21:	41 80 f8 02          	cmp    $0x2,%r8b
    5b25:	75 14                	jne    5b3b <e54+0x5b>
    5b27:	48 8d 04 11          	lea    (%rcx,%rdx,1),%rax
    5b2b:	48 05 28 02 00 00    	add    $0x228,%rax
    5b31:	80 38 00             	cmpb   $0x0,(%rax)
    5b34:	74 2d                	je     5b63 <e54+0x83>
    5b36:	e9 b2 00 00 00       	jmp    5bed <e54+0x10d>
    5b3b:	41 80 f8 01          	cmp    $0x1,%r8b
    5b3f:	75 22                	jne    5b63 <e54+0x83>
    5b41:	4c 8d 04 11          	lea    (%rcx,%rdx,1),%r8
    5b45:	8b 4c 11 20          	mov    0x20(%rcx,%rdx,1),%ecx
    5b49:	48 0f af c1          	imul   %rcx,%rax
    5b4d:	48 c1 e8 20          	shr    $0x20,%rax
    5b51:	4c 01 c0             	add    %r8,%rax
    5b54:	48 05 28 02 00 00    	add    $0x228,%rax
    5b5a:	80 38 00             	cmpb   $0x0,(%rax)
    5b5d:	0f 85 8a 00 00 00    	jne    5bed <e54+0x10d>
    5b63:	48 8b 3f             	mov    (%rdi),%rdi
    5b66:	48 8d 15 43 c1 00 00 	lea    0xc143(%rip),%rdx        # 11cb0 <d1>
    5b6d:	e8 6e 41 00 00       	call   9ce0 <fwp_p_array_get_typed>
    5b72:	48 89 c1             	mov    %rax,%rcx
    5b75:	48 2b 0d 34 d6 00 00 	sub    0xd634(%rip),%rcx        # 131b0 <fwp_gc+0x1030>
    5b7c:	48 8b 15 55 d6 00 00 	mov    0xd655(%rip),%rdx        # 131d8 <fwp_gc+0x1058>
    5b83:	48 c1 e2 10          	shl    $0x10,%rdx
    5b87:	48 39 d1             	cmp    %rdx,%rcx
    5b8a:	73 5f                	jae    5beb <e54+0x10b>
    5b8c:	48 8b 15 65 d6 00 00 	mov    0xd665(%rip),%rdx        # 131f8 <fwp_gc+0x1078>
    5b93:	48 89 ce             	mov    %rcx,%rsi
    5b96:	48 c1 ee 10          	shr    $0x10,%rsi
    5b9a:	48 69 f6 28 12 00 00 	imul   $0x1228,%rsi,%rsi
    5ba1:	0f b6 3c 32          	movzbl (%rdx,%rsi,1),%edi
    5ba5:	48 81 e1 ff ff 00 00 	and    $0xffff,%rcx
    5bac:	75 18                	jne    5bc6 <e54+0xe6>
    5bae:	40 80 ff 02          	cmp    $0x2,%dil
    5bb2:	75 12                	jne    5bc6 <e54+0xe6>
    5bb4:	48 8d 0c 32          	lea    (%rdx,%rsi,1),%rcx
    5bb8:	48 81 c1 28 02 00 00 	add    $0x228,%rcx
    5bbf:	80 39 00             	cmpb   $0x0,(%rcx)
    5bc2:	74 27                	je     5beb <e54+0x10b>
    5bc4:	eb 27                	jmp    5bed <e54+0x10d>
    5bc6:	40 80 ff 01          	cmp    $0x1,%dil
    5bca:	75 1f                	jne    5beb <e54+0x10b>
    5bcc:	48 8d 3c 32          	lea    (%rdx,%rsi,1),%rdi
    5bd0:	8b 54 32 20          	mov    0x20(%rdx,%rsi,1),%edx
    5bd4:	48 0f af ca          	imul   %rdx,%rcx
    5bd8:	48 c1 e9 20          	shr    $0x20,%rcx
    5bdc:	48 01 f9             	add    %rdi,%rcx
    5bdf:	48 81 c1 28 02 00 00 	add    $0x228,%rcx
    5be6:	80 39 00             	cmpb   $0x0,(%rcx)
    5be9:	75 02                	jne    5bed <e54+0x10d>
    5beb:	59                   	pop    %rcx
    5bec:	c3                   	ret
    5bed:	e8 3e 07 00 00       	call   6330 <fwp_flush>
    5bf2:	48 8b 05 e7 c3 00 00 	mov    0xc3e7(%rip),%rax        # 11fe0 <stderr@GLIBC_2.2.5>
    5bf9:	48 8b 38             	mov    (%rax),%rdi
    5bfc:	48 8d 35 2a 98 00 00 	lea    0x982a(%rip),%rsi        # f42d <fwp_segv.msg+0x1ed>
    5c03:	48 8d 15 f6 97 00 00 	lea    0x97f6(%rip),%rdx        # f400 <fwp_segv.msg+0x1c0>
    5c0a:	31 c0                	xor    %eax,%eax
    5c0c:	e8 9f c5 ff ff       	call   21b0 <fprintf@plt>
    5c11:	bf 65 00 00 00       	mov    $0x65,%edi
    5c16:	e8 75 c6 ff ff       	call   2290 <exit@plt>
    5c1b:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)

0000000000005c20 <e55>:
    5c20:	50                   	push   %rax
    5c21:	48 8b 3f             	mov    (%rdi),%rdi
    5c24:	48 89 f8             	mov    %rdi,%rax
    5c27:	48 2b 05 82 d5 00 00 	sub    0xd582(%rip),%rax        # 131b0 <fwp_gc+0x1030>
    5c2e:	48 8b 0d a3 d5 00 00 	mov    0xd5a3(%rip),%rcx        # 131d8 <fwp_gc+0x1058>
    5c35:	48 c1 e1 10          	shl    $0x10,%rcx
    5c39:	48 39 c8             	cmp    %rcx,%rax
    5c3c:	73 63                	jae    5ca1 <e55+0x81>
    5c3e:	48 8b 0d b3 d5 00 00 	mov    0xd5b3(%rip),%rcx        # 131f8 <fwp_gc+0x1078>
    5c45:	48 89 c2             	mov    %rax,%rdx
    5c48:	48 c1 ea 10          	shr    $0x10,%rdx
    5c4c:	48 69 d2 28 12 00 00 	imul   $0x1228,%rdx,%rdx
    5c53:	0f b6 34 11          	movzbl (%rcx,%rdx,1),%esi
    5c57:	48 25 ff ff 00 00    	and    $0xffff,%rax
    5c5d:	75 1a                	jne    5c79 <e55+0x59>
    5c5f:	40 80 fe 02          	cmp    $0x2,%sil
    5c63:	75 14                	jne    5c79 <e55+0x59>
    5c65:	48 8d 04 11          	lea    (%rcx,%rdx,1),%rax
    5c69:	48 05 28 02 00 00    	add    $0x228,%rax
    5c6f:	80 38 00             	cmpb   $0x0,(%rax)
    5c72:	74 2d                	je     5ca1 <e55+0x81>
    5c74:	e9 a8 00 00 00       	jmp    5d21 <e55+0x101>
    5c79:	40 80 fe 01          	cmp    $0x1,%sil
    5c7d:	75 22                	jne    5ca1 <e55+0x81>
    5c7f:	48 8d 34 11          	lea    (%rcx,%rdx,1),%rsi
    5c83:	8b 4c 11 20          	mov    0x20(%rcx,%rdx,1),%ecx
    5c87:	48 0f af c1          	imul   %rcx,%rax
    5c8b:	48 c1 e8 20          	shr    $0x20,%rax
    5c8f:	48 01 f0             	add    %rsi,%rax
    5c92:	48 05 28 02 00 00    	add    $0x228,%rax
    5c98:	80 38 00             	cmpb   $0x0,(%rax)
    5c9b:	0f 85 80 00 00 00    	jne    5d21 <e55+0x101>
    5ca1:	e8 1a 6e 00 00       	call   cac0 <f55>
    5ca6:	48 89 c1             	mov    %rax,%rcx
    5ca9:	48 2b 0d 00 d5 00 00 	sub    0xd500(%rip),%rcx        # 131b0 <fwp_gc+0x1030>
    5cb0:	48 8b 15 21 d5 00 00 	mov    0xd521(%rip),%rdx        # 131d8 <fwp_gc+0x1058>
    5cb7:	48 c1 e2 10          	shl    $0x10,%rdx
    5cbb:	48 39 d1             	cmp    %rdx,%rcx
    5cbe:	73 5f                	jae    5d1f <e55+0xff>
    5cc0:	48 8b 15 31 d5 00 00 	mov    0xd531(%rip),%rdx        # 131f8 <fwp_gc+0x1078>
    5cc7:	48 89 ce             	mov    %rcx,%rsi
    5cca:	48 c1 ee 10          	shr    $0x10,%rsi
    5cce:	48 69 f6 28 12 00 00 	imul   $0x1228,%rsi,%rsi
    5cd5:	0f b6 3c 32          	movzbl (%rdx,%rsi,1),%edi
    5cd9:	48 81 e1 ff ff 00 00 	and    $0xffff,%rcx
    5ce0:	75 18                	jne    5cfa <e55+0xda>
    5ce2:	40 80 ff 02          	cmp    $0x2,%dil
    5ce6:	75 12                	jne    5cfa <e55+0xda>
    5ce8:	48 8d 0c 32          	lea    (%rdx,%rsi,1),%rcx
    5cec:	48 81 c1 28 02 00 00 	add    $0x228,%rcx
    5cf3:	80 39 00             	cmpb   $0x0,(%rcx)
    5cf6:	74 27                	je     5d1f <e55+0xff>
    5cf8:	eb 27                	jmp    5d21 <e55+0x101>
    5cfa:	40 80 ff 01          	cmp    $0x1,%dil
    5cfe:	75 1f                	jne    5d1f <e55+0xff>
    5d00:	48 8d 3c 32          	lea    (%rdx,%rsi,1),%rdi
    5d04:	8b 54 32 20          	mov    0x20(%rdx,%rsi,1),%edx
    5d08:	48 0f af ca          	imul   %rdx,%rcx
    5d0c:	48 c1 e9 20          	shr    $0x20,%rcx
    5d10:	48 01 f9             	add    %rdi,%rcx
    5d13:	48 81 c1 28 02 00 00 	add    $0x228,%rcx
    5d1a:	80 39 00             	cmpb   $0x0,(%rcx)
    5d1d:	75 02                	jne    5d21 <e55+0x101>
    5d1f:	59                   	pop    %rcx
    5d20:	c3                   	ret
    5d21:	e8 0a 06 00 00       	call   6330 <fwp_flush>
    5d26:	48 8b 05 b3 c2 00 00 	mov    0xc2b3(%rip),%rax        # 11fe0 <stderr@GLIBC_2.2.5>
    5d2d:	48 8b 38             	mov    (%rax),%rdi
    5d30:	48 8d 35 f6 96 00 00 	lea    0x96f6(%rip),%rsi        # f42d <fwp_segv.msg+0x1ed>
    5d37:	48 8d 15 c2 96 00 00 	lea    0x96c2(%rip),%rdx        # f400 <fwp_segv.msg+0x1c0>
    5d3e:	31 c0                	xor    %eax,%eax
    5d40:	e8 6b c4 ff ff       	call   21b0 <fprintf@plt>
    5d45:	bf 65 00 00 00       	mov    $0x65,%edi
    5d4a:	e8 41 c5 ff ff       	call   2290 <exit@plt>
    5d4f:	90                   	nop

0000000000005d50 <e56>:
    5d50:	50                   	push   %rax
    5d51:	48 89 f8             	mov    %rdi,%rax
    5d54:	48 8b 3f             	mov    (%rdi),%rdi
    5d57:	48 8b 0d 52 d4 00 00 	mov    0xd452(%rip),%rcx        # 131b0 <fwp_gc+0x1030>
    5d5e:	48 89 fe             	mov    %rdi,%rsi
    5d61:	48 29 ce             	sub    %rcx,%rsi
    5d64:	48 8b 15 6d d4 00 00 	mov    0xd46d(%rip),%rdx        # 131d8 <fwp_gc+0x1058>
    5d6b:	48 c1 e2 10          	shl    $0x10,%rdx
    5d6f:	48 39 d6             	cmp    %rdx,%rsi
    5d72:	73 68                	jae    5ddc <e56+0x8c>
    5d74:	4c 8b 05 7d d4 00 00 	mov    0xd47d(%rip),%r8        # 131f8 <fwp_gc+0x1078>
    5d7b:	49 89 f1             	mov    %rsi,%r9
    5d7e:	49 c1 e9 10          	shr    $0x10,%r9
    5d82:	4d 69 c9 28 12 00 00 	imul   $0x1228,%r9,%r9
    5d89:	47 0f b6 14 08       	movzbl (%r8,%r9,1),%r10d
    5d8e:	48 81 e6 ff ff 00 00 	and    $0xffff,%rsi
    5d95:	75 1b                	jne    5db2 <e56+0x62>
    5d97:	41 80 fa 02          	cmp    $0x2,%r10b
    5d9b:	75 15                	jne    5db2 <e56+0x62>
    5d9d:	4b 8d 34 08          	lea    (%r8,%r9,1),%rsi
    5da1:	48 81 c6 28 02 00 00 	add    $0x228,%rsi
    5da8:	80 3e 00             	cmpb   $0x0,(%rsi)
    5dab:	74 2f                	je     5ddc <e56+0x8c>
    5dad:	e9 24 01 00 00       	jmp    5ed6 <e56+0x186>
    5db2:	41 80 fa 01          	cmp    $0x1,%r10b
    5db6:	75 24                	jne    5ddc <e56+0x8c>
    5db8:	4f 8d 14 08          	lea    (%r8,%r9,1),%r10
    5dbc:	47 8b 44 08 20       	mov    0x20(%r8,%r9,1),%r8d
    5dc1:	49 0f af f0          	imul   %r8,%rsi
    5dc5:	48 c1 ee 20          	shr    $0x20,%rsi
    5dc9:	4c 01 d6             	add    %r10,%rsi
    5dcc:	48 81 c6 28 02 00 00 	add    $0x228,%rsi
    5dd3:	80 3e 00             	cmpb   $0x0,(%rsi)
    5dd6:	0f 85 fa 00 00 00    	jne    5ed6 <e56+0x186>
    5ddc:	48 8b 70 08          	mov    0x8(%rax),%rsi
    5de0:	48 89 f0             	mov    %rsi,%rax
    5de3:	48 29 c8             	sub    %rcx,%rax
    5de6:	48 39 d0             	cmp    %rdx,%rax
    5de9:	73 64                	jae    5e4f <e56+0xff>
    5deb:	48 8b 0d 06 d4 00 00 	mov    0xd406(%rip),%rcx        # 131f8 <fwp_gc+0x1078>
    5df2:	48 89 c2             	mov    %rax,%rdx
    5df5:	48 c1 ea 10          	shr    $0x10,%rdx
    5df9:	48 69 d2 28 12 00 00 	imul   $0x1228,%rdx,%rdx
    5e00:	44 0f b6 04 11       	movzbl (%rcx,%rdx,1),%r8d
    5e05:	48 25 ff ff 00 00    	and    $0xffff,%rax
    5e0b:	75 1a                	jne    5e27 <e56+0xd7>
    5e0d:	41 80 f8 02          	cmp    $0x2,%r8b
    5e11:	75 14                	jne    5e27 <e56+0xd7>
    5e13:	48 8d 04 11          	lea    (%rcx,%rdx,1),%rax
    5e17:	48 05 28 02 00 00    	add    $0x228,%rax
    5e1d:	80 38 00             	cmpb   $0x0,(%rax)
    5e20:	74 2d                	je     5e4f <e56+0xff>
    5e22:	e9 af 00 00 00       	jmp    5ed6 <e56+0x186>
    5e27:	41 80 f8 01          	cmp    $0x1,%r8b
    5e2b:	75 22                	jne    5e4f <e56+0xff>
    5e2d:	4c 8d 04 11          	lea    (%rcx,%rdx,1),%r8
    5e31:	8b 4c 11 20          	mov    0x20(%rcx,%rdx,1),%ecx
    5e35:	48 0f af c1          	imul   %rcx,%rax
    5e39:	48 c1 e8 20          	shr    $0x20,%rax
    5e3d:	4c 01 c0             	add    %r8,%rax
    5e40:	48 05 28 02 00 00    	add    $0x228,%rax
    5e46:	80 38 00             	cmpb   $0x0,(%rax)
    5e49:	0f 85 87 00 00 00    	jne    5ed6 <e56+0x186>
    5e4f:	48 8d 15 5a 73 00 00 	lea    0x735a(%rip),%rdx        # d1b0 <fwp_drop13>
    5e56:	e8 75 4e 00 00       	call   acd0 <fwp_p_loop_own>
    5e5b:	48 89 c1             	mov    %rax,%rcx
    5e5e:	48 2b 0d 4b d3 00 00 	sub    0xd34b(%rip),%rcx        # 131b0 <fwp_gc+0x1030>
    5e65:	48 8b 15 6c d3 00 00 	mov    0xd36c(%rip),%rdx        # 131d8 <fwp_gc+0x1058>
    5e6c:	48 c1 e2 10          	shl    $0x10,%rdx
    5e70:	48 39 d1             	cmp    %rdx,%rcx
    5e73:	73 5f                	jae    5ed4 <e56+0x184>
    5e75:	48 8b 15 7c d3 00 00 	mov    0xd37c(%rip),%rdx        # 131f8 <fwp_gc+0x1078>
    5e7c:	48 89 ce             	mov    %rcx,%rsi
    5e7f:	48 c1 ee 10          	shr    $0x10,%rsi
    5e83:	48 69 f6 28 12 00 00 	imul   $0x1228,%rsi,%rsi
    5e8a:	0f b6 3c 32          	movzbl (%rdx,%rsi,1),%edi
    5e8e:	48 81 e1 ff ff 00 00 	and    $0xffff,%rcx
    5e95:	75 18                	jne    5eaf <e56+0x15f>
    5e97:	40 80 ff 02          	cmp    $0x2,%dil
    5e9b:	75 12                	jne    5eaf <e56+0x15f>
    5e9d:	48 8d 0c 32          	lea    (%rdx,%rsi,1),%rcx
    5ea1:	48 81 c1 28 02 00 00 	add    $0x228,%rcx
    5ea8:	80 39 00             	cmpb   $0x0,(%rcx)
    5eab:	74 27                	je     5ed4 <e56+0x184>
    5ead:	eb 27                	jmp    5ed6 <e56+0x186>
    5eaf:	40 80 ff 01          	cmp    $0x1,%dil
    5eb3:	75 1f                	jne    5ed4 <e56+0x184>
    5eb5:	48 8d 3c 32          	lea    (%rdx,%rsi,1),%rdi
    5eb9:	8b 54 32 20          	mov    0x20(%rdx,%rsi,1),%edx
    5ebd:	48 0f af ca          	imul   %rdx,%rcx
    5ec1:	48 c1 e9 20          	shr    $0x20,%rcx
    5ec5:	48 01 f9             	add    %rdi,%rcx
    5ec8:	48 81 c1 28 02 00 00 	add    $0x228,%rcx
    5ecf:	80 39 00             	cmpb   $0x0,(%rcx)
    5ed2:	75 02                	jne    5ed6 <e56+0x186>
    5ed4:	59                   	pop    %rcx
    5ed5:	c3                   	ret
    5ed6:	e8 55 04 00 00       	call   6330 <fwp_flush>
    5edb:	48 8b 05 fe c0 00 00 	mov    0xc0fe(%rip),%rax        # 11fe0 <stderr@GLIBC_2.2.5>
    5ee2:	48 8b 38             	mov    (%rax),%rdi
    5ee5:	48 8d 35 41 95 00 00 	lea    0x9541(%rip),%rsi        # f42d <fwp_segv.msg+0x1ed>
    5eec:	48 8d 15 0d 95 00 00 	lea    0x950d(%rip),%rdx        # f400 <fwp_segv.msg+0x1c0>
    5ef3:	31 c0                	xor    %eax,%eax
    5ef5:	e8 b6 c2 ff ff       	call   21b0 <fprintf@plt>
    5efa:	bf 65 00 00 00       	mov    $0x65,%edi
    5eff:	e8 8c c3 ff ff       	call   2290 <exit@plt>
    5f04:	66 66 66 2e 0f 1f 84 	data16 data16 cs nopw 0x0(%rax,%rax,1)
    5f0b:	00 00 00 00 00 

0000000000005f10 <e57>:
    5f10:	50                   	push   %rax
    5f11:	48 8b 3f             	mov    (%rdi),%rdi
    5f14:	48 89 f8             	mov    %rdi,%rax
    5f17:	48 2b 05 92 d2 00 00 	sub    0xd292(%rip),%rax        # 131b0 <fwp_gc+0x1030>
    5f1e:	48 8b 0d b3 d2 00 00 	mov    0xd2b3(%rip),%rcx        # 131d8 <fwp_gc+0x1058>
    5f25:	48 c1 e1 10          	shl    $0x10,%rcx
    5f29:	48 39 c8             	cmp    %rcx,%rax
    5f2c:	73 63                	jae    5f91 <e57+0x81>
    5f2e:	48 8b 0d c3 d2 00 00 	mov    0xd2c3(%rip),%rcx        # 131f8 <fwp_gc+0x1078>
    5f35:	48 89 c2             	mov    %rax,%rdx
    5f38:	48 c1 ea 10          	shr    $0x10,%rdx
    5f3c:	48 69 d2 28 12 00 00 	imul   $0x1228,%rdx,%rdx
    5f43:	0f b6 34 11          	movzbl (%rcx,%rdx,1),%esi
    5f47:	48 25 ff ff 00 00    	and    $0xffff,%rax
    5f4d:	75 1a                	jne    5f69 <e57+0x59>
    5f4f:	40 80 fe 02          	cmp    $0x2,%sil
    5f53:	75 14                	jne    5f69 <e57+0x59>
    5f55:	48 8d 04 11          	lea    (%rcx,%rdx,1),%rax
    5f59:	48 05 28 02 00 00    	add    $0x228,%rax
    5f5f:	80 38 00             	cmpb   $0x0,(%rax)
    5f62:	74 2d                	je     5f91 <e57+0x81>
    5f64:	e9 a8 00 00 00       	jmp    6011 <e57+0x101>
    5f69:	40 80 fe 01          	cmp    $0x1,%sil
    5f6d:	75 22                	jne    5f91 <e57+0x81>
    5f6f:	48 8d 34 11          	lea    (%rcx,%rdx,1),%rsi
    5f73:	8b 4c 11 20          	mov    0x20(%rcx,%rdx,1),%ecx
    5f77:	48 0f af c1          	imul   %rcx,%rax
    5f7b:	48 c1 e8 20          	shr    $0x20,%rax
    5f7f:	48 01 f0             	add    %rsi,%rax
    5f82:	48 05 28 02 00 00    	add    $0x228,%rax
    5f88:	80 38 00             	cmpb   $0x0,(%rax)
    5f8b:	0f 85 80 00 00 00    	jne    6011 <e57+0x101>
    5f91:	e8 da 72 00 00       	call   d270 <f57>
    5f96:	48 89 c1             	mov    %rax,%rcx
    5f99:	48 2b 0d 10 d2 00 00 	sub    0xd210(%rip),%rcx        # 131b0 <fwp_gc+0x1030>
    5fa0:	48 8b 15 31 d2 00 00 	mov    0xd231(%rip),%rdx        # 131d8 <fwp_gc+0x1058>
    5fa7:	48 c1 e2 10          	shl    $0x10,%rdx
    5fab:	48 39 d1             	cmp    %rdx,%rcx
    5fae:	73 5f                	jae    600f <e57+0xff>
    5fb0:	48 8b 15 41 d2 00 00 	mov    0xd241(%rip),%rdx        # 131f8 <fwp_gc+0x1078>
    5fb7:	48 89 ce             	mov    %rcx,%rsi
    5fba:	48 c1 ee 10          	shr    $0x10,%rsi
    5fbe:	48 69 f6 28 12 00 00 	imul   $0x1228,%rsi,%rsi
    5fc5:	0f b6 3c 32          	movzbl (%rdx,%rsi,1),%edi
    5fc9:	48 81 e1 ff ff 00 00 	and    $0xffff,%rcx
    5fd0:	75 18                	jne    5fea <e57+0xda>
    5fd2:	40 80 ff 02          	cmp    $0x2,%dil
    5fd6:	75 12                	jne    5fea <e57+0xda>
    5fd8:	48 8d 0c 32          	lea    (%rdx,%rsi,1),%rcx
    5fdc:	48 81 c1 28 02 00 00 	add    $0x228,%rcx
    5fe3:	80 39 00             	cmpb   $0x0,(%rcx)
    5fe6:	74 27                	je     600f <e57+0xff>
    5fe8:	eb 27                	jmp    6011 <e57+0x101>
    5fea:	40 80 ff 01          	cmp    $0x1,%dil
    5fee:	75 1f                	jne    600f <e57+0xff>
    5ff0:	48 8d 3c 32          	lea    (%rdx,%rsi,1),%rdi
    5ff4:	8b 54 32 20          	mov    0x20(%rdx,%rsi,1),%edx
    5ff8:	48 0f af ca          	imul   %rdx,%rcx
    5ffc:	48 c1 e9 20          	shr    $0x20,%rcx
    6000:	48 01 f9             	add    %rdi,%rcx
    6003:	48 81 c1 28 02 00 00 	add    $0x228,%rcx
    600a:	80 39 00             	cmpb   $0x0,(%rcx)
    600d:	75 02                	jne    6011 <e57+0x101>
    600f:	59                   	pop    %rcx
    6010:	c3                   	ret
    6011:	e8 1a 03 00 00       	call   6330 <fwp_flush>
    6016:	48 8b 05 c3 bf 00 00 	mov    0xbfc3(%rip),%rax        # 11fe0 <stderr@GLIBC_2.2.5>
    601d:	48 8b 38             	mov    (%rax),%rdi
    6020:	48 8d 35 06 94 00 00 	lea    0x9406(%rip),%rsi        # f42d <fwp_segv.msg+0x1ed>
    6027:	48 8d 15 d2 93 00 00 	lea    0x93d2(%rip),%rdx        # f400 <fwp_segv.msg+0x1c0>
    602e:	31 c0                	xor    %eax,%eax
    6030:	e8 7b c1 ff ff       	call   21b0 <fprintf@plt>
    6035:	bf 65 00 00 00       	mov    $0x65,%edi
    603a:	e8 51 c2 ff ff       	call   2290 <exit@plt>
    603f:	90                   	nop

0000000000006040 <e58>:
    6040:	50                   	push   %rax
    6041:	48 89 f8             	mov    %rdi,%rax
    6044:	48 8b 3f             	mov    (%rdi),%rdi
    6047:	48 8b 0d 62 d1 00 00 	mov    0xd162(%rip),%rcx        # 131b0 <fwp_gc+0x1030>
    604e:	48 89 fe             	mov    %rdi,%rsi
    6051:	48 29 ce             	sub    %rcx,%rsi
    6054:	48 8b 15 7d d1 00 00 	mov    0xd17d(%rip),%rdx        # 131d8 <fwp_gc+0x1058>
    605b:	48 c1 e2 10          	shl    $0x10,%rdx
    605f:	48 39 d6             	cmp    %rdx,%rsi
    6062:	73 68                	jae    60cc <e58+0x8c>
    6064:	4c 8b 05 8d d1 00 00 	mov    0xd18d(%rip),%r8        # 131f8 <fwp_gc+0x1078>
    606b:	49 89 f1             	mov    %rsi,%r9
    606e:	49 c1 e9 10          	shr    $0x10,%r9
    6072:	4d 69 c9 28 12 00 00 	imul   $0x1228,%r9,%r9
    6079:	47 0f b6 14 08       	movzbl (%r8,%r9,1),%r10d
    607e:	48 81 e6 ff ff 00 00 	and    $0xffff,%rsi
    6085:	75 1b                	jne    60a2 <e58+0x62>
    6087:	41 80 fa 02          	cmp    $0x2,%r10b
    608b:	75 15                	jne    60a2 <e58+0x62>
    608d:	4b 8d 34 08          	lea    (%r8,%r9,1),%rsi
    6091:	48 81 c6 28 02 00 00 	add    $0x228,%rsi
    6098:	80 3e 00             	cmpb   $0x0,(%rsi)
    609b:	74 2f                	je     60cc <e58+0x8c>
    609d:	e9 24 01 00 00       	jmp    61c6 <e58+0x186>
    60a2:	41 80 fa 01          	cmp    $0x1,%r10b
    60a6:	75 24                	jne    60cc <e58+0x8c>
    60a8:	4f 8d 14 08          	lea    (%r8,%r9,1),%r10
    60ac:	47 8b 44 08 20       	mov    0x20(%r8,%r9,1),%r8d
    60b1:	49 0f af f0          	imul   %r8,%rsi
    60b5:	48 c1 ee 20          	shr    $0x20,%rsi
    60b9:	4c 01 d6             	add    %r10,%rsi
    60bc:	48 81 c6 28 02 00 00 	add    $0x228,%rsi
    60c3:	80 3e 00             	cmpb   $0x0,(%rsi)
    60c6:	0f 85 fa 00 00 00    	jne    61c6 <e58+0x186>
    60cc:	48 8b 70 08          	mov    0x8(%rax),%rsi
    60d0:	48 89 f0             	mov    %rsi,%rax
    60d3:	48 29 c8             	sub    %rcx,%rax
    60d6:	48 39 d0             	cmp    %rdx,%rax
    60d9:	73 64                	jae    613f <e58+0xff>
    60db:	48 8b 0d 16 d1 00 00 	mov    0xd116(%rip),%rcx        # 131f8 <fwp_gc+0x1078>
    60e2:	48 89 c2             	mov    %rax,%rdx
    60e5:	48 c1 ea 10          	shr    $0x10,%rdx
    60e9:	48 69 d2 28 12 00 00 	imul   $0x1228,%rdx,%rdx
    60f0:	44 0f b6 04 11       	movzbl (%rcx,%rdx,1),%r8d
    60f5:	48 25 ff ff 00 00    	and    $0xffff,%rax
    60fb:	75 1a                	jne    6117 <e58+0xd7>
    60fd:	41 80 f8 02          	cmp    $0x2,%r8b
    6101:	75 14                	jne    6117 <e58+0xd7>
    6103:	48 8d 04 11          	lea    (%rcx,%rdx,1),%rax
    6107:	48 05 28 02 00 00    	add    $0x228,%rax
    610d:	80 38 00             	cmpb   $0x0,(%rax)
    6110:	74 2d                	je     613f <e58+0xff>
    6112:	e9 af 00 00 00       	jmp    61c6 <e58+0x186>
    6117:	41 80 f8 01          	cmp    $0x1,%r8b
    611b:	75 22                	jne    613f <e58+0xff>
    611d:	4c 8d 04 11          	lea    (%rcx,%rdx,1),%r8
    6121:	8b 4c 11 20          	mov    0x20(%rcx,%rdx,1),%ecx
    6125:	48 0f af c1          	imul   %rcx,%rax
    6129:	48 c1 e8 20          	shr    $0x20,%rax
    612d:	4c 01 c0             	add    %r8,%rax
    6130:	48 05 28 02 00 00    	add    $0x228,%rax
    6136:	80 38 00             	cmpb   $0x0,(%rax)
    6139:	0f 85 87 00 00 00    	jne    61c6 <e58+0x186>
    613f:	48 8d 15 3a 77 00 00 	lea    0x773a(%rip),%rdx        # d880 <fwp_drop15>
    6146:	e8 85 4b 00 00       	call   acd0 <fwp_p_loop_own>
    614b:	48 89 c1             	mov    %rax,%rcx
    614e:	48 2b 0d 5b d0 00 00 	sub    0xd05b(%rip),%rcx        # 131b0 <fwp_gc+0x1030>
    6155:	48 8b 15 7c d0 00 00 	mov    0xd07c(%rip),%rdx        # 131d8 <fwp_gc+0x1058>
    615c:	48 c1 e2 10          	shl    $0x10,%rdx
    6160:	48 39 d1             	cmp    %rdx,%rcx
    6163:	73 5f                	jae    61c4 <e58+0x184>
    6165:	48 8b 15 8c d0 00 00 	mov    0xd08c(%rip),%rdx        # 131f8 <fwp_gc+0x1078>
    616c:	48 89 ce             	mov    %rcx,%rsi
    616f:	48 c1 ee 10          	shr    $0x10,%rsi
    6173:	48 69 f6 28 12 00 00 	imul   $0x1228,%rsi,%rsi
    617a:	0f b6 3c 32          	movzbl (%rdx,%rsi,1),%edi
    617e:	48 81 e1 ff ff 00 00 	and    $0xffff,%rcx
    6185:	75 18                	jne    619f <e58+0x15f>
    6187:	40 80 ff 02          	cmp    $0x2,%dil
    618b:	75 12                	jne    619f <e58+0x15f>
    618d:	48 8d 0c 32          	lea    (%rdx,%rsi,1),%rcx
    6191:	48 81 c1 28 02 00 00 	add    $0x228,%rcx
    6198:	80 39 00             	cmpb   $0x0,(%rcx)
    619b:	74 27                	je     61c4 <e58+0x184>
    619d:	eb 27                	jmp    61c6 <e58+0x186>
    619f:	40 80 ff 01          	cmp    $0x1,%dil
    61a3:	75 1f                	jne    61c4 <e58+0x184>
    61a5:	48 8d 3c 32          	lea    (%rdx,%rsi,1),%rdi
    61a9:	8b 54 32 20          	mov    0x20(%rdx,%rsi,1),%edx
    61ad:	48 0f af ca          	imul   %rdx,%rcx
    61b1:	48 c1 e9 20          	shr    $0x20,%rcx
    61b5:	48 01 f9             	add    %rdi,%rcx
    61b8:	48 81 c1 28 02 00 00 	add    $0x228,%rcx
    61bf:	80 39 00             	cmpb   $0x0,(%rcx)
    61c2:	75 02                	jne    61c6 <e58+0x186>
    61c4:	59                   	pop    %rcx
    61c5:	c3                   	ret
    61c6:	e8 65 01 00 00       	call   6330 <fwp_flush>
    61cb:	48 8b 05 0e be 00 00 	mov    0xbe0e(%rip),%rax        # 11fe0 <stderr@GLIBC_2.2.5>
    61d2:	48 8b 38             	mov    (%rax),%rdi
    61d5:	48 8d 35 51 92 00 00 	lea    0x9251(%rip),%rsi        # f42d <fwp_segv.msg+0x1ed>
    61dc:	48 8d 15 1d 92 00 00 	lea    0x921d(%rip),%rdx        # f400 <fwp_segv.msg+0x1c0>
    61e3:	31 c0                	xor    %eax,%eax
    61e5:	e8 c6 bf ff ff       	call   21b0 <fprintf@plt>
    61ea:	bf 65 00 00 00       	mov    $0x65,%edi
    61ef:	e8 9c c0 ff ff       	call   2290 <exit@plt>
    61f4:	66 66 66 2e 0f 1f 84 	data16 data16 cs nopw 0x0(%rax,%rax,1)
    61fb:	00 00 00 00 00 

0000000000006200 <e59>:
    6200:	50                   	push   %rax
    6201:	48 8b 3f             	mov    (%rdi),%rdi
    6204:	48 89 f8             	mov    %rdi,%rax
    6207:	48 2b 05 a2 cf 00 00 	sub    0xcfa2(%rip),%rax        # 131b0 <fwp_gc+0x1030>
    620e:	48 8b 0d c3 cf 00 00 	mov    0xcfc3(%rip),%rcx        # 131d8 <fwp_gc+0x1058>
    6215:	48 c1 e1 10          	shl    $0x10,%rcx
    6219:	48 39 c8             	cmp    %rcx,%rax
    621c:	73 63                	jae    6281 <e59+0x81>
    621e:	48 8b 0d d3 cf 00 00 	mov    0xcfd3(%rip),%rcx        # 131f8 <fwp_gc+0x1078>
    6225:	48 89 c2             	mov    %rax,%rdx
    6228:	48 c1 ea 10          	shr    $0x10,%rdx
    622c:	48 69 d2 28 12 00 00 	imul   $0x1228,%rdx,%rdx
    6233:	0f b6 34 11          	movzbl (%rcx,%rdx,1),%esi
    6237:	48 25 ff ff 00 00    	and    $0xffff,%rax
    623d:	75 1a                	jne    6259 <e59+0x59>
    623f:	40 80 fe 02          	cmp    $0x2,%sil
    6243:	75 14                	jne    6259 <e59+0x59>
    6245:	48 8d 04 11          	lea    (%rcx,%rdx,1),%rax
    6249:	48 05 28 02 00 00    	add    $0x228,%rax
    624f:	80 38 00             	cmpb   $0x0,(%rax)
    6252:	74 2d                	je     6281 <e59+0x81>
    6254:	e9 a8 00 00 00       	jmp    6301 <e59+0x101>
    6259:	40 80 fe 01          	cmp    $0x1,%sil
    625d:	75 22                	jne    6281 <e59+0x81>
    625f:	48 8d 34 11          	lea    (%rcx,%rdx,1),%rsi
    6263:	8b 4c 11 20          	mov    0x20(%rcx,%rdx,1),%ecx
    6267:	48 0f af c1          	imul   %rcx,%rax
    626b:	48 c1 e8 20          	shr    $0x20,%rax
    626f:	48 01 f0             	add    %rsi,%rax
    6272:	48 05 28 02 00 00    	add    $0x228,%rax
    6278:	80 38 00             	cmpb   $0x0,(%rax)
    627b:	0f 85 80 00 00 00    	jne    6301 <e59+0x101>
    6281:	e8 ba 76 00 00       	call   d940 <f59>
    6286:	48 89 c1             	mov    %rax,%rcx
    6289:	48 2b 0d 20 cf 00 00 	sub    0xcf20(%rip),%rcx        # 131b0 <fwp_gc+0x1030>
    6290:	48 8b 15 41 cf 00 00 	mov    0xcf41(%rip),%rdx        # 131d8 <fwp_gc+0x1058>
    6297:	48 c1 e2 10          	shl    $0x10,%rdx
    629b:	48 39 d1             	cmp    %rdx,%rcx
    629e:	73 5f                	jae    62ff <e59+0xff>
    62a0:	48 8b 15 51 cf 00 00 	mov    0xcf51(%rip),%rdx        # 131f8 <fwp_gc+0x1078>
    62a7:	48 89 ce             	mov    %rcx,%rsi
    62aa:	48 c1 ee 10          	shr    $0x10,%rsi
    62ae:	48 69 f6 28 12 00 00 	imul   $0x1228,%rsi,%rsi
    62b5:	0f b6 3c 32          	movzbl (%rdx,%rsi,1),%edi
    62b9:	48 81 e1 ff ff 00 00 	and    $0xffff,%rcx
    62c0:	75 18                	jne    62da <e59+0xda>
    62c2:	40 80 ff 02          	cmp    $0x2,%dil
    62c6:	75 12                	jne    62da <e59+0xda>
    62c8:	48 8d 0c 32          	lea    (%rdx,%rsi,1),%rcx
    62cc:	48 81 c1 28 02 00 00 	add    $0x228,%rcx
    62d3:	80 39 00             	cmpb   $0x0,(%rcx)
    62d6:	74 27                	je     62ff <e59+0xff>
    62d8:	eb 27                	jmp    6301 <e59+0x101>
    62da:	40 80 ff 01          	cmp    $0x1,%dil
    62de:	75 1f                	jne    62ff <e59+0xff>
    62e0:	48 8d 3c 32          	lea    (%rdx,%rsi,1),%rdi
    62e4:	8b 54 32 20          	mov    0x20(%rdx,%rsi,1),%edx
    62e8:	48 0f af ca          	imul   %rdx,%rcx
    62ec:	48 c1 e9 20          	shr    $0x20,%rcx
    62f0:	48 01 f9             	add    %rdi,%rcx
    62f3:	48 81 c1 28 02 00 00 	add    $0x228,%rcx
    62fa:	80 39 00             	cmpb   $0x0,(%rcx)
    62fd:	75 02                	jne    6301 <e59+0x101>
    62ff:	59                   	pop    %rcx
    6300:	c3                   	ret
    6301:	e8 2a 00 00 00       	call   6330 <fwp_flush>
    6306:	48 8b 05 d3 bc 00 00 	mov    0xbcd3(%rip),%rax        # 11fe0 <stderr@GLIBC_2.2.5>
    630d:	48 8b 38             	mov    (%rax),%rdi
    6310:	48 8d 35 16 91 00 00 	lea    0x9116(%rip),%rsi        # f42d <fwp_segv.msg+0x1ed>
    6317:	48 8d 15 e2 90 00 00 	lea    0x90e2(%rip),%rdx        # f400 <fwp_segv.msg+0x1c0>
    631e:	31 c0                	xor    %eax,%eax
    6320:	e8 8b be ff ff       	call   21b0 <fprintf@plt>
    6325:	bf 65 00 00 00       	mov    $0x65,%edi
    632a:	e8 61 bf ff ff       	call   2290 <exit@plt>
    632f:	90                   	nop

0000000000006330 <fwp_flush>:
    6330:	50                   	push   %rax
    6331:	48 8b 3d 90 d8 00 00 	mov    0xd890(%rip),%rdi        # 13bc8 <fwp_prog_out>
    6338:	48 85 ff             	test   %rdi,%rdi
    633b:	74 05                	je     6342 <fwp_flush+0x12>
    633d:	e8 be be ff ff       	call   2200 <fflush@plt>
    6342:	48 8b 05 77 bc 00 00 	mov    0xbc77(%rip),%rax        # 11fc0 <stdout@GLIBC_2.2.5>
    6349:	48 8b 38             	mov    (%rax),%rdi
    634c:	58                   	pop    %rax
    634d:	e9 ae be ff ff       	jmp    2200 <fflush@plt>
    6352:	66 66 66 66 66 2e 0f 	data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    6359:	1f 84 00 00 00 00 00 

0000000000006360 <fwp_rc_forget_slot>:
    6360:	50                   	push   %rax
    6361:	80 3f ff             	cmpb   $0xff,(%rdi)
    6364:	74 02                	je     6368 <fwp_rc_forget_slot+0x8>
    6366:	58                   	pop    %rax
    6367:	c3                   	ret
    6368:	48 89 f8             	mov    %rdi,%rax
    636b:	48 c1 e8 11          	shr    $0x11,%rax
    636f:	31 f8                	xor    %edi,%eax
    6371:	89 c1                	mov    %eax,%ecx
    6373:	c1 e9 09             	shr    $0x9,%ecx
    6376:	31 c1                	xor    %eax,%ecx
    6378:	0f b6 c9             	movzbl %cl,%ecx
    637b:	48 8d 15 fe bd 00 00 	lea    0xbdfe(%rip),%rdx        # 12180 <fwp_gc>
    6382:	48 8b 84 ca 18 12 00 	mov    0x1218(%rdx,%rcx,8),%rax
    6389:	00 
    638a:	48 85 c0             	test   %rax,%rax
    638d:	74 4b                	je     63da <fwp_rc_forget_slot+0x7a>
    638f:	48 39 38             	cmp    %rdi,(%rax)
    6392:	74 23                	je     63b7 <fwp_rc_forget_slot+0x57>
    6394:	66 66 66 2e 0f 1f 84 	data16 data16 cs nopw 0x0(%rax,%rax,1)
    639b:	00 00 00 00 00 
    63a0:	48 89 c1             	mov    %rax,%rcx
    63a3:	48 8b 40 10          	mov    0x10(%rax),%rax
    63a7:	48 85 c0             	test   %rax,%rax
    63aa:	74 2e                	je     63da <fwp_rc_forget_slot+0x7a>
    63ac:	48 39 38             	cmp    %rdi,(%rax)
    63af:	75 ef                	jne    63a0 <fwp_rc_forget_slot+0x40>
    63b1:	48 83 c1 10          	add    $0x10,%rcx
    63b5:	eb 0b                	jmp    63c2 <fwp_rc_forget_slot+0x62>
    63b7:	48 8d 0c ca          	lea    (%rdx,%rcx,8),%rcx
    63bb:	48 81 c1 18 12 00 00 	add    $0x1218,%rcx
    63c2:	48 8b 50 10          	mov    0x10(%rax),%rdx
    63c6:	48 89 11             	mov    %rdx,(%rcx)
    63c9:	48 89 c7             	mov    %rax,%rdi
    63cc:	e8 7f bc ff ff       	call   2050 <free@plt>
    63d1:	48 ff 0d c0 d7 00 00 	decq   0xd7c0(%rip)        # 13b98 <fwp_gc+0x1a18>
    63d8:	58                   	pop    %rax
    63d9:	c3                   	ret
    63da:	e8 51 ff ff ff       	call   6330 <fwp_flush>
    63df:	48 8b 05 fa bb 00 00 	mov    0xbbfa(%rip),%rax        # 11fe0 <stderr@GLIBC_2.2.5>
    63e6:	48 8b 38             	mov    (%rax),%rdi
    63e9:	48 8d 35 3d 90 00 00 	lea    0x903d(%rip),%rsi        # f42d <fwp_segv.msg+0x1ed>
    63f0:	48 8d 15 45 90 00 00 	lea    0x9045(%rip),%rdx        # f43c <fwp_segv.msg+0x1fc>
    63f7:	31 c0                	xor    %eax,%eax
    63f9:	e8 b2 bd ff ff       	call   21b0 <fprintf@plt>
    63fe:	bf 65 00 00 00       	mov    $0x65,%edi
    6403:	e8 88 be ff ff       	call   2290 <exit@plt>
    6408:	0f 1f 84 00 00 00 00 	nopl   0x0(%rax,%rax,1)
    640f:	00 

0000000000006410 <fwp_p_array_from_list_typed>:
    6410:	41 56                	push   %r14
    6412:	53                   	push   %rbx
    6413:	50                   	push   %rax
    6414:	48 89 fb             	mov    %rdi,%rbx
    6417:	48 85 ff             	test   %rdi,%rdi
    641a:	0f 84 ae 00 00 00    	je     64ce <fwp_p_array_from_list_typed+0xbe>
    6420:	31 ff                	xor    %edi,%edi
    6422:	48 89 d8             	mov    %rbx,%rax
    6425:	66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
    642c:	00 00 00 00 
    6430:	48 ff c7             	inc    %rdi
    6433:	48 8b 40 10          	mov    0x10(%rax),%rax
    6437:	48 85 c0             	test   %rax,%rax
    643a:	75 f4                	jne    6430 <fwp_p_array_from_list_typed+0x20>
    643c:	49 89 f6             	mov    %rsi,%r14
    643f:	e8 cc 00 00 00       	call   6510 <fwp_array_typed_new>
    6444:	48 85 db             	test   %rbx,%rbx
    6447:	0f 84 88 00 00 00    	je     64d5 <fwp_p_array_from_list_typed+0xc5>
    644d:	b9 04 00 00 00       	mov    $0x4,%ecx
    6452:	ba 84 04 00 00       	mov    $0x484,%edx
    6457:	be 21 00 00 00       	mov    $0x21,%esi
    645c:	bf 42 00 00 00       	mov    $0x42,%edi
    6461:	49 89 d8             	mov    %rbx,%r8
    6464:	4d 89 f1             	mov    %r14,%r9
    6467:	eb 18                	jmp    6481 <fwp_p_array_from_list_typed+0x71>
    6469:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)
    6470:	4c 89 54 c8 e8       	mov    %r10,-0x18(%rax,%rcx,8)
    6475:	4d 8b 40 10          	mov    0x10(%r8),%r8
    6479:	48 ff c1             	inc    %rcx
    647c:	4d 85 c0             	test   %r8,%r8
    647f:	74 54                	je     64d5 <fwp_p_array_from_list_typed+0xc5>
    6481:	48 83 38 00          	cmpq   $0x0,(%rax)
    6485:	78 56                	js     64dd <fwp_p_array_from_list_typed+0xcd>
    6487:	4d 8b 50 08          	mov    0x8(%r8),%r10
    648b:	4d 85 c9             	test   %r9,%r9
    648e:	74 e0                	je     6470 <fwp_p_array_from_list_typed+0x60>
    6490:	45 8b 19             	mov    (%r9),%r11d
    6493:	41 83 fb 0a          	cmp    $0xa,%r11d
    6497:	77 d7                	ja     6470 <fwp_p_array_from_list_typed+0x60>
    6499:	44 0f a3 da          	bt     %r11d,%edx
    649d:	72 21                	jb     64c0 <fwp_p_array_from_list_typed+0xb0>
    649f:	44 0f a3 de          	bt     %r11d,%esi
    64a3:	72 22                	jb     64c7 <fwp_p_array_from_list_typed+0xb7>
    64a5:	44 0f a3 df          	bt     %r11d,%edi
    64a9:	73 c5                	jae    6470 <fwp_p_array_from_list_typed+0x60>
    64ab:	66 44 89 14 48       	mov    %r10w,(%rax,%rcx,2)
    64b0:	eb c3                	jmp    6475 <fwp_p_array_from_list_typed+0x65>
    64b2:	66 66 66 66 66 2e 0f 	data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    64b9:	1f 84 00 00 00 00 00 
    64c0:	44 89 54 88 f8       	mov    %r10d,-0x8(%rax,%rcx,4)
    64c5:	eb ae                	jmp    6475 <fwp_p_array_from_list_typed+0x65>
    64c7:	44 88 54 08 04       	mov    %r10b,0x4(%rax,%rcx,1)
    64cc:	eb a7                	jmp    6475 <fwp_p_array_from_list_typed+0x65>
    64ce:	31 ff                	xor    %edi,%edi
    64d0:	e8 3b 00 00 00       	call   6510 <fwp_array_typed_new>
    64d5:	48 83 c4 08          	add    $0x8,%rsp
    64d9:	5b                   	pop    %rbx
    64da:	41 5e                	pop    %r14
    64dc:	c3                   	ret
    64dd:	e8 4e fe ff ff       	call   6330 <fwp_flush>
    64e2:	48 8b 05 f7 ba 00 00 	mov    0xbaf7(%rip),%rax        # 11fe0 <stderr@GLIBC_2.2.5>
    64e9:	48 8b 38             	mov    (%rax),%rdi
    64ec:	48 8d 35 3a 8f 00 00 	lea    0x8f3a(%rip),%rsi        # f42d <fwp_segv.msg+0x1ed>
    64f3:	48 8d 15 84 90 00 00 	lea    0x9084(%rip),%rdx        # f57e <fwp_segv.msg+0x33e>
    64fa:	31 c0                	xor    %eax,%eax
    64fc:	e8 af bc ff ff       	call   21b0 <fprintf@plt>
    6501:	bf 65 00 00 00       	mov    $0x65,%edi
    6506:	e8 85 bd ff ff       	call   2290 <exit@plt>
    650b:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)

0000000000006510 <fwp_array_typed_new>:
    6510:	41 56                	push   %r14
    6512:	53                   	push   %rbx
    6513:	50                   	push   %rax
    6514:	48 b8 ff ff ff ff ff 	movabs $0x1fffffffffffffff,%rax
    651b:	ff ff 1f 
    651e:	48 39 c7             	cmp    %rax,%rdi
    6521:	0f 83 21 02 00 00    	jae    6748 <fwp_array_typed_new+0x238>
    6527:	48 89 fb             	mov    %rdi,%rbx
    652a:	48 85 f6             	test   %rsi,%rsi
    652d:	74 23                	je     6552 <fwp_array_typed_new+0x42>
    652f:	8b 06                	mov    (%rsi),%eax
    6531:	48 83 f8 0a          	cmp    $0xa,%rax
    6535:	77 0e                	ja     6545 <fwp_array_typed_new+0x35>
    6537:	b9 e7 04 00 00       	mov    $0x4e7,%ecx
    653c:	0f a3 c1             	bt     %eax,%ecx
    653f:	0f 82 93 00 00 00    	jb     65d8 <fwp_array_typed_new+0xc8>
    6545:	48 8d 0c dd 00 00 00 	lea    0x0(,%rbx,8),%rcx
    654c:	00 
    654d:	e9 95 00 00 00       	jmp    65e7 <fwp_array_typed_new+0xd7>
    6552:	48 8d 14 dd 08 00 00 	lea    0x8(,%rbx,8),%rdx
    6559:	00 
    655a:	48 81 fa 00 40 00 00 	cmp    $0x4000,%rdx
    6561:	77 68                	ja     65cb <fwp_array_typed_new+0xbb>
    6563:	48 8d 42 0f          	lea    0xf(%rdx),%rax
    6567:	48 c1 e8 04          	shr    $0x4,%rax
    656b:	48 8d 0d 0e bc 00 00 	lea    0xbc0e(%rip),%rcx        # 12180 <fwp_gc>
    6572:	0f b6 b4 08 e8 0b 00 	movzbl 0xbe8(%rax,%rcx,1),%esi
    6579:	00 
    657a:	8b 84 b1 48 0b 00 00 	mov    0xb48(%rcx,%rsi,4),%eax
    6581:	48 29 05 f8 bb 00 00 	sub    %rax,0xbbf8(%rip)        # 12180 <fwp_gc>
    6588:	78 41                	js     65cb <fwp_array_typed_new+0xbb>
    658a:	48 8d 34 76          	lea    (%rsi,%rsi,2),%rsi
    658e:	48 8d 3c f1          	lea    (%rcx,%rsi,8),%rdi
    6592:	48 81 c7 88 07 00 00 	add    $0x788,%rdi
    6599:	4c 8b 37             	mov    (%rdi),%r14
    659c:	4d 85 f6             	test   %r14,%r14
    659f:	74 0e                	je     65af <fwp_array_typed_new+0x9f>
    65a1:	49 8b 0e             	mov    (%r14),%rcx
    65a4:	48 f7 d1             	not    %rcx
    65a7:	48 89 0f             	mov    %rcx,(%rdi)
    65aa:	e9 f8 00 00 00       	jmp    66a7 <fwp_array_typed_new+0x197>
    65af:	4c 8b b4 f1 90 07 00 	mov    0x790(%rcx,%rsi,8),%r14
    65b6:	00 
    65b7:	48 8b bc f1 98 07 00 	mov    0x798(%rcx,%rsi,8),%rdi
    65be:	00 
    65bf:	4c 29 f7             	sub    %r14,%rdi
    65c2:	48 39 c7             	cmp    %rax,%rdi
    65c5:	0f 83 ca 00 00 00    	jae    6695 <fwp_array_typed_new+0x185>
    65cb:	48 89 d7             	mov    %rdx,%rdi
    65ce:	be 02 00 00 00       	mov    $0x2,%esi
    65d3:	e9 9c 00 00 00       	jmp    6674 <fwp_array_typed_new+0x164>
    65d8:	48 8d 0d 81 8c 00 00 	lea    0x8c81(%rip),%rcx        # f260 <fwp_segv.msg+0x20>
    65df:	48 8b 0c c1          	mov    (%rcx,%rax,8),%rcx
    65e3:	48 0f af cb          	imul   %rbx,%rcx
    65e7:	48 8d 51 08          	lea    0x8(%rcx),%rdx
    65eb:	83 f8 0b             	cmp    $0xb,%eax
    65ee:	0f 87 66 ff ff ff    	ja     655a <fwp_array_typed_new+0x4a>
    65f4:	be ef 0d 00 00       	mov    $0xdef,%esi
    65f9:	0f a3 c6             	bt     %eax,%esi
    65fc:	0f 83 58 ff ff ff    	jae    655a <fwp_array_typed_new+0x4a>
    6602:	48 81 f9 f8 3f 00 00 	cmp    $0x3ff8,%rcx
    6609:	77 61                	ja     666c <fwp_array_typed_new+0x15c>
    660b:	48 83 c1 17          	add    $0x17,%rcx
    660f:	48 c1 e9 04          	shr    $0x4,%rcx
    6613:	48 8d 05 66 bb 00 00 	lea    0xbb66(%rip),%rax        # 12180 <fwp_gc>
    661a:	0f b6 b4 01 e8 0b 00 	movzbl 0xbe8(%rcx,%rax,1),%esi
    6621:	00 
    6622:	8b 8c b0 48 0b 00 00 	mov    0xb48(%rax,%rsi,4),%ecx
    6629:	48 29 0d 50 bb 00 00 	sub    %rcx,0xbb50(%rip)        # 12180 <fwp_gc>
    6630:	78 3a                	js     666c <fwp_array_typed_new+0x15c>
    6632:	48 8d 34 76          	lea    (%rsi,%rsi,2),%rsi
    6636:	48 8d 3c f0          	lea    (%rax,%rsi,8),%rdi
    663a:	48 81 c7 c8 03 00 00 	add    $0x3c8,%rdi
    6641:	4c 8b 37             	mov    (%rdi),%r14
    6644:	4d 85 f6             	test   %r14,%r14
    6647:	74 0b                	je     6654 <fwp_array_typed_new+0x144>
    6649:	49 8b 06             	mov    (%r14),%rax
    664c:	48 f7 d0             	not    %rax
    664f:	48 89 07             	mov    %rax,(%rdi)
    6652:	eb 3a                	jmp    668e <fwp_array_typed_new+0x17e>
    6654:	4c 8b b4 f0 d0 03 00 	mov    0x3d0(%rax,%rsi,8),%r14
    665b:	00 
    665c:	48 8b bc f0 d8 03 00 	mov    0x3d8(%rax,%rsi,8),%rdi
    6663:	00 
    6664:	4c 29 f7             	sub    %r14,%rdi
    6667:	48 39 cf             	cmp    %rcx,%rdi
    666a:	73 12                	jae    667e <fwp_array_typed_new+0x16e>
    666c:	48 89 d7             	mov    %rdx,%rdi
    666f:	be 01 00 00 00       	mov    $0x1,%esi
    6674:	e8 07 01 00 00       	call   6780 <fwp_gc_alloc_slow>
    6679:	49 89 c6             	mov    %rax,%r14
    667c:	eb 36                	jmp    66b4 <fwp_array_typed_new+0x1a4>
    667e:	48 8d 04 f0          	lea    (%rax,%rsi,8),%rax
    6682:	48 05 d0 03 00 00    	add    $0x3d0,%rax
    6688:	4c 01 f1             	add    %r14,%rcx
    668b:	48 89 08             	mov    %rcx,(%rax)
    668e:	4c 89 f7             	mov    %r14,%rdi
    6691:	31 f6                	xor    %esi,%esi
    6693:	eb 1a                	jmp    66af <fwp_array_typed_new+0x19f>
    6695:	48 8d 0c f1          	lea    (%rcx,%rsi,8),%rcx
    6699:	48 81 c1 90 07 00 00 	add    $0x790,%rcx
    66a0:	49 8d 14 06          	lea    (%r14,%rax,1),%rdx
    66a4:	48 89 11             	mov    %rdx,(%rcx)
    66a7:	4c 89 f7             	mov    %r14,%rdi
    66aa:	31 f6                	xor    %esi,%esi
    66ac:	48 89 c2             	mov    %rax,%rdx
    66af:	e8 7c ba ff ff       	call   2130 <memset@plt>
    66b4:	49 89 1e             	mov    %rbx,(%r14)
    66b7:	4c 89 f0             	mov    %r14,%rax
    66ba:	48 2b 05 ef ca 00 00 	sub    0xcaef(%rip),%rax        # 131b0 <fwp_gc+0x1030>
    66c1:	48 8b 0d 10 cb 00 00 	mov    0xcb10(%rip),%rcx        # 131d8 <fwp_gc+0x1058>
    66c8:	48 c1 e1 10          	shl    $0x10,%rcx
    66cc:	48 39 c8             	cmp    %rcx,%rax
    66cf:	73 6c                	jae    673d <fwp_array_typed_new+0x22d>
    66d1:	48 8b 0d 20 cb 00 00 	mov    0xcb20(%rip),%rcx        # 131f8 <fwp_gc+0x1078>
    66d8:	48 89 c2             	mov    %rax,%rdx
    66db:	48 c1 ea 10          	shr    $0x10,%rdx
    66df:	48 69 d2 28 12 00 00 	imul   $0x1228,%rdx,%rdx
    66e6:	0f b6 34 11          	movzbl (%rcx,%rdx,1),%esi
    66ea:	48 25 ff ff 00 00    	and    $0xffff,%rax
    66f0:	75 1b                	jne    670d <fwp_array_typed_new+0x1fd>
    66f2:	40 80 fe 02          	cmp    $0x2,%sil
    66f6:	75 15                	jne    670d <fwp_array_typed_new+0x1fd>
    66f8:	48 8d 1c 11          	lea    (%rcx,%rdx,1),%rbx
    66fc:	48 81 c3 28 02 00 00 	add    $0x228,%rbx
    6703:	80 3b ff             	cmpb   $0xff,(%rbx)
    6706:	74 2b                	je     6733 <fwp_array_typed_new+0x223>
    6708:	c6 03 01             	movb   $0x1,(%rbx)
    670b:	eb 30                	jmp    673d <fwp_array_typed_new+0x22d>
    670d:	40 80 fe 01          	cmp    $0x1,%sil
    6711:	75 2a                	jne    673d <fwp_array_typed_new+0x22d>
    6713:	48 8d 34 11          	lea    (%rcx,%rdx,1),%rsi
    6717:	8b 4c 11 20          	mov    0x20(%rcx,%rdx,1),%ecx
    671b:	48 0f af c1          	imul   %rcx,%rax
    671f:	48 c1 e8 20          	shr    $0x20,%rax
    6723:	48 8d 1c 30          	lea    (%rax,%rsi,1),%rbx
    6727:	48 81 c3 28 02 00 00 	add    $0x228,%rbx
    672e:	80 3b ff             	cmpb   $0xff,(%rbx)
    6731:	75 d5                	jne    6708 <fwp_array_typed_new+0x1f8>
    6733:	48 89 df             	mov    %rbx,%rdi
    6736:	e8 25 fc ff ff       	call   6360 <fwp_rc_forget_slot>
    673b:	eb cb                	jmp    6708 <fwp_array_typed_new+0x1f8>
    673d:	4c 89 f0             	mov    %r14,%rax
    6740:	48 83 c4 08          	add    $0x8,%rsp
    6744:	5b                   	pop    %rbx
    6745:	41 5e                	pop    %r14
    6747:	c3                   	ret
    6748:	e8 e3 fb ff ff       	call   6330 <fwp_flush>
    674d:	48 8b 05 8c b8 00 00 	mov    0xb88c(%rip),%rax        # 11fe0 <stderr@GLIBC_2.2.5>
    6754:	48 8b 38             	mov    (%rax),%rdi
    6757:	48 8d 35 cf 8c 00 00 	lea    0x8ccf(%rip),%rsi        # f42d <fwp_segv.msg+0x1ed>
    675e:	48 8d 15 fe 8c 00 00 	lea    0x8cfe(%rip),%rdx        # f463 <fwp_segv.msg+0x223>
    6765:	31 c0                	xor    %eax,%eax
    6767:	e8 44 ba ff ff       	call   21b0 <fprintf@plt>
    676c:	bf 65 00 00 00       	mov    $0x65,%edi
    6771:	e8 1a bb ff ff       	call   2290 <exit@plt>
    6776:	66 2e 0f 1f 84 00 00 	cs nopw 0x0(%rax,%rax,1)
    677d:	00 00 00 

0000000000006780 <fwp_gc_alloc_slow>:
    6780:	41 57                	push   %r15
    6782:	41 56                	push   %r14
    6784:	41 55                	push   %r13
    6786:	41 54                	push   %r12
    6788:	53                   	push   %rbx
    6789:	89 f3                	mov    %esi,%ebx
    678b:	83 3d da c9 00 00 00 	cmpl   $0x0,0xc9da(%rip)        # 1316c <fwp_gc+0xfec>
    6792:	74 19                	je     67ad <fwp_gc_alloc_slow+0x2d>
    6794:	48 81 ff 01 40 00 00 	cmp    $0x4001,%rdi
    679b:	72 24                	jb     67c1 <fwp_gc_alloc_slow+0x41>
    679d:	89 de                	mov    %ebx,%esi
    679f:	5b                   	pop    %rbx
    67a0:	41 5c                	pop    %r12
    67a2:	41 5d                	pop    %r13
    67a4:	41 5e                	pop    %r14
    67a6:	41 5f                	pop    %r15
    67a8:	e9 33 06 00 00       	jmp    6de0 <fwp_gc_alloc_big>
    67ad:	49 89 fe             	mov    %rdi,%r14
    67b0:	e8 5b 01 00 00       	call   6910 <fwp_gc_init>
    67b5:	4c 89 f7             	mov    %r14,%rdi
    67b8:	48 81 ff 01 40 00 00 	cmp    $0x4001,%rdi
    67bf:	73 dc                	jae    679d <fwp_gc_alloc_slow+0x1d>
    67c1:	48 8d 47 0f          	lea    0xf(%rdi),%rax
    67c5:	48 c1 e8 04          	shr    $0x4,%rax
    67c9:	4c 8d 3d b0 b9 00 00 	lea    0xb9b0(%rip),%r15        # 12180 <fwp_gc>
    67d0:	46 0f b6 b4 38 e8 0b 	movzbl 0xbe8(%rax,%r15,1),%r14d
    67d7:	00 00 
    67d9:	43 8b 94 b7 48 0b 00 	mov    0xb48(%r15,%r14,4),%edx
    67e0:	00 
    67e1:	48 83 3d 97 b9 00 00 	cmpq   $0x0,0xb997(%rip)        # 12180 <fwp_gc>
    67e8:	00 
    67e9:	0f 89 8c 00 00 00    	jns    687b <fwp_gc_alloc_slow+0xfb>
    67ef:	83 3d 76 c9 00 00 00 	cmpl   $0x0,0xc976(%rip)        # 1316c <fwp_gc+0xfec>
    67f6:	75 11                	jne    6809 <fwp_gc_alloc_slow+0x89>
    67f8:	49 89 fc             	mov    %rdi,%r12
    67fb:	49 89 d5             	mov    %rdx,%r13
    67fe:	e8 0d 01 00 00       	call   6910 <fwp_gc_init>
    6803:	4c 89 ea             	mov    %r13,%rdx
    6806:	4c 89 e7             	mov    %r12,%rdi
    6809:	8b 0d 65 c9 00 00    	mov    0xc965(%rip),%ecx        # 13174 <fwp_gc+0xff4>
    680f:	85 c9                	test   %ecx,%ecx
    6811:	74 2a                	je     683d <fwp_gc_alloc_slow+0xbd>
    6813:	48 8b 05 86 c9 00 00 	mov    0xc986(%rip),%rax        # 131a0 <fwp_gc+0x1020>
    681a:	48 85 c0             	test   %rax,%rax
    681d:	74 1e                	je     683d <fwp_gc_alloc_slow+0xbd>
    681f:	48 8b 0d 82 c9 00 00 	mov    0xc982(%rip),%rcx        # 131a8 <fwp_gc+0x1028>
    6826:	48 ff c1             	inc    %rcx
    6829:	48 89 0d 78 c9 00 00 	mov    %rcx,0xc978(%rip)        # 131a8 <fwp_gc+0x1028>
    6830:	48 39 c1             	cmp    %rax,%rcx
    6833:	0f 8d c7 00 00 00    	jge    6900 <fwp_gc_alloc_slow+0x180>
    6839:	31 c0                	xor    %eax,%eax
    683b:	eb 0d                	jmp    684a <fwp_gc_alloc_slow+0xca>
    683d:	b8 00 00 80 00       	mov    $0x800000,%eax
    6842:	85 c9                	test   %ecx,%ecx
    6844:	0f 85 b1 00 00 00    	jne    68fb <fwp_gc_alloc_slow+0x17b>
    684a:	48 8b 0d 3f cb 00 00 	mov    0xcb3f(%rip),%rcx        # 13390 <fwp_gc+0x1210>
    6851:	48 2b 0d 28 b9 00 00 	sub    0xb928(%rip),%rcx        # 12180 <fwp_gc>
    6858:	f2 48 0f 2a c1       	cvtsi2sd %rcx,%xmm0
    685d:	f2 0f 58 05 03 cb 00 	addsd  0xcb03(%rip),%xmm0        # 13368 <fwp_gc+0x11e8>
    6864:	00 
    6865:	f2 0f 11 05 fb ca 00 	movsd  %xmm0,0xcafb(%rip)        # 13368 <fwp_gc+0x11e8>
    686c:	00 
    686d:	48 89 05 1c cb 00 00 	mov    %rax,0xcb1c(%rip)        # 13390 <fwp_gc+0x1210>
    6874:	48 89 05 05 b9 00 00 	mov    %rax,0xb905(%rip)        # 12180 <fwp_gc>
    687b:	89 d8                	mov    %ebx,%eax
    687d:	48 69 c0 c0 03 00 00 	imul   $0x3c0,%rax,%rax
    6884:	49 01 c7             	add    %rax,%r15
    6887:	4b 8d 34 76          	lea    (%r14,%r14,2),%rsi
    688b:	49 8d 0c f7          	lea    (%r15,%rsi,8),%rcx
    688f:	48 83 c1 08          	add    $0x8,%rcx
    6893:	49 8b 44 f7 08       	mov    0x8(%r15,%rsi,8),%rax
    6898:	48 85 c0             	test   %rax,%rax
    689b:	74 08                	je     68a5 <fwp_gc_alloc_slow+0x125>
    689d:	48 8b 30             	mov    (%rax),%rsi
    68a0:	48 f7 d6             	not    %rsi
    68a3:	eb 39                	jmp    68de <fwp_gc_alloc_slow+0x15e>
    68a5:	49 8b 44 f7 10       	mov    0x10(%r15,%rsi,8),%rax
    68aa:	4d 8b 44 f7 18       	mov    0x18(%r15,%rsi,8),%r8
    68af:	49 29 c0             	sub    %rax,%r8
    68b2:	49 39 d0             	cmp    %rdx,%r8
    68b5:	73 1b                	jae    68d2 <fwp_gc_alloc_slow+0x152>
    68b7:	49 89 ff             	mov    %rdi,%r15
    68ba:	48 89 cf             	mov    %rcx,%rdi
    68bd:	44 89 f6             	mov    %r14d,%esi
    68c0:	49 89 d6             	mov    %rdx,%r14
    68c3:	89 da                	mov    %ebx,%edx
    68c5:	e8 46 07 00 00       	call   7010 <fwp_gc_refill>
    68ca:	4c 89 f2             	mov    %r14,%rdx
    68cd:	4c 89 ff             	mov    %r15,%rdi
    68d0:	eb 0f                	jmp    68e1 <fwp_gc_alloc_slow+0x161>
    68d2:	49 8d 0c f7          	lea    (%r15,%rsi,8),%rcx
    68d6:	48 83 c1 10          	add    $0x10,%rcx
    68da:	48 8d 34 10          	lea    (%rax,%rdx,1),%rsi
    68de:	48 89 31             	mov    %rsi,(%rcx)
    68e1:	83 fb 01             	cmp    $0x1,%ebx
    68e4:	48 0f 44 d7          	cmove  %rdi,%rdx
    68e8:	48 89 c7             	mov    %rax,%rdi
    68eb:	31 f6                	xor    %esi,%esi
    68ed:	5b                   	pop    %rbx
    68ee:	41 5c                	pop    %r12
    68f0:	41 5d                	pop    %r13
    68f2:	41 5e                	pop    %r14
    68f4:	41 5f                	pop    %r15
    68f6:	e9 35 b8 ff ff       	jmp    2130 <memset@plt>
    68fb:	e8 d0 09 00 00       	call   72d0 <fwp_gc_collect>
    6900:	48 c7 05 9d c8 00 00 	movq   $0x0,0xc89d(%rip)        # 131a8 <fwp_gc+0x1028>
    6907:	00 00 00 00 
    690b:	e8 c0 09 00 00       	call   72d0 <fwp_gc_collect>

0000000000006910 <fwp_gc_init>:
    6910:	41 56                	push   %r14
    6912:	53                   	push   %rbx
    6913:	50                   	push   %rax
    6914:	c7 05 4e c8 00 00 01 	movl   $0x1,0xc84e(%rip)        # 1316c <fwp_gc+0xfec>
    691b:	00 00 00 
    691e:	0f 28 05 0b 87 00 00 	movaps 0x870b(%rip),%xmm0        # f030 <_IO_stdin_used+0x30>
    6925:	0f 11 05 9c c3 00 00 	movups %xmm0,0xc39c(%rip)        # 12cc8 <fwp_gc+0xb48>
    692c:	0f 28 05 0d 87 00 00 	movaps 0x870d(%rip),%xmm0        # f040 <_IO_stdin_used+0x40>
    6933:	0f 11 05 9e c3 00 00 	movups %xmm0,0xc39e(%rip)        # 12cd8 <fwp_gc+0xb58>
    693a:	0f 28 05 0f 87 00 00 	movaps 0x870f(%rip),%xmm0        # f050 <_IO_stdin_used+0x50>
    6941:	0f 11 05 a0 c3 00 00 	movups %xmm0,0xc3a0(%rip)        # 12ce8 <fwp_gc+0xb68>
    6948:	0f 28 05 11 87 00 00 	movaps 0x8711(%rip),%xmm0        # f060 <_IO_stdin_used+0x60>
    694f:	0f 11 05 a2 c3 00 00 	movups %xmm0,0xc3a2(%rip)        # 12cf8 <fwp_gc+0xb78>
    6956:	0f 28 05 13 87 00 00 	movaps 0x8713(%rip),%xmm0        # f070 <_IO_stdin_used+0x70>
    695d:	0f 11 05 a4 c3 00 00 	movups %xmm0,0xc3a4(%rip)        # 12d08 <fwp_gc+0xb88>
    6964:	0f 28 05 15 87 00 00 	movaps 0x8715(%rip),%xmm0        # f080 <_IO_stdin_used+0x80>
    696b:	0f 11 05 a6 c3 00 00 	movups %xmm0,0xc3a6(%rip)        # 12d18 <fwp_gc+0xb98>
    6972:	0f 28 05 17 87 00 00 	movaps 0x8717(%rip),%xmm0        # f090 <_IO_stdin_used+0x90>
    6979:	0f 11 05 a8 c3 00 00 	movups %xmm0,0xc3a8(%rip)        # 12d28 <fwp_gc+0xba8>
    6980:	0f 28 05 19 87 00 00 	movaps 0x8719(%rip),%xmm0        # f0a0 <_IO_stdin_used+0xa0>
    6987:	0f 11 05 aa c3 00 00 	movups %xmm0,0xc3aa(%rip)        # 12d38 <fwp_gc+0xbb8>
    698e:	0f 28 05 1b 87 00 00 	movaps 0x871b(%rip),%xmm0        # f0b0 <_IO_stdin_used+0xb0>
    6995:	0f 11 05 ac c3 00 00 	movups %xmm0,0xc3ac(%rip)        # 12d48 <fwp_gc+0xbc8>
    699c:	0f 28 05 1d 87 00 00 	movaps 0x871d(%rip),%xmm0        # f0c0 <_IO_stdin_used+0xc0>
    69a3:	0f 11 05 ae c3 00 00 	movups %xmm0,0xc3ae(%rip)        # 12d58 <fwp_gc+0xbd8>
    69aa:	31 c9                	xor    %ecx,%ecx
    69ac:	48 8d 05 cd b7 00 00 	lea    0xb7cd(%rip),%rax        # 12180 <fwp_gc>
    69b3:	31 d2                	xor    %edx,%edx
    69b5:	66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
    69bc:	00 00 00 00 
    69c0:	89 d6                	mov    %edx,%esi
    69c2:	c1 e6 04             	shl    $0x4,%esi
    69c5:	48 ff c9             	dec    %rcx
    69c8:	48 89 cf             	mov    %rcx,%rdi
    69cb:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)
    69d0:	48 89 f9             	mov    %rdi,%rcx
    69d3:	48 ff c7             	inc    %rdi
    69d6:	3b b4 88 4c 0b 00 00 	cmp    0xb4c(%rax,%rcx,4),%esi
    69dd:	77 f1                	ja     69d0 <fwp_gc_init+0xc0>
    69df:	40 88 bc 02 e8 0b 00 	mov    %dil,0xbe8(%rdx,%rax,1)
    69e6:	00 
    69e7:	48 89 d6             	mov    %rdx,%rsi
    69ea:	48 83 ce 01          	or     $0x1,%rsi
    69ee:	48 81 fe 01 04 00 00 	cmp    $0x401,%rsi
    69f5:	74 26                	je     6a1d <fwp_gc_init+0x10d>
    69f7:	89 f7                	mov    %esi,%edi
    69f9:	c1 e7 04             	shl    $0x4,%edi
    69fc:	0f 1f 40 00          	nopl   0x0(%rax)
    6a00:	49 89 c8             	mov    %rcx,%r8
    6a03:	48 ff c1             	inc    %rcx
    6a06:	42 3b bc 80 4c 0b 00 	cmp    0xb4c(%rax,%r8,4),%edi
    6a0d:	00 
    6a0e:	77 f0                	ja     6a00 <fwp_gc_init+0xf0>
    6a10:	88 8c 06 e8 0b 00 00 	mov    %cl,0xbe8(%rsi,%rax,1)
    6a17:	48 83 c2 02          	add    $0x2,%rdx
    6a1b:	eb a3                	jmp    69c0 <fwp_gc_init+0xb0>
    6a1d:	48 bb 00 00 00 00 10 	movabs $0x1000000000,%rbx
    6a24:	00 00 00 
    6a27:	48 8d b3 00 00 01 00 	lea    0x10000(%rbx),%rsi
    6a2e:	31 ff                	xor    %edi,%edi
    6a30:	31 d2                	xor    %edx,%edx
    6a32:	b9 22 40 00 00       	mov    $0x4022,%ecx
    6a37:	41 b8 ff ff ff ff    	mov    $0xffffffff,%r8d
    6a3d:	45 31 c9             	xor    %r9d,%r9d
    6a40:	e8 ab b6 ff ff       	call   20f0 <mmap@plt>
    6a45:	48 83 f8 ff          	cmp    $0xffffffffffffffff,%rax
    6a49:	75 60                	jne    6aab <fwp_gc_init+0x19b>
    6a4b:	48 bb 00 00 00 00 04 	movabs $0x400000000,%rbx
    6a52:	00 00 00 
    6a55:	48 8d b3 00 00 01 00 	lea    0x10000(%rbx),%rsi
    6a5c:	31 ff                	xor    %edi,%edi
    6a5e:	31 d2                	xor    %edx,%edx
    6a60:	b9 22 40 00 00       	mov    $0x4022,%ecx
    6a65:	41 b8 ff ff ff ff    	mov    $0xffffffff,%r8d
    6a6b:	45 31 c9             	xor    %r9d,%r9d
    6a6e:	e8 7d b6 ff ff       	call   20f0 <mmap@plt>
    6a73:	48 83 f8 ff          	cmp    $0xffffffffffffffff,%rax
    6a77:	75 32                	jne    6aab <fwp_gc_init+0x19b>
    6a79:	48 bb 00 00 00 00 01 	movabs $0x100000000,%rbx
    6a80:	00 00 00 
    6a83:	48 8d b3 00 00 01 00 	lea    0x10000(%rbx),%rsi
    6a8a:	31 ff                	xor    %edi,%edi
    6a8c:	31 d2                	xor    %edx,%edx
    6a8e:	b9 22 40 00 00       	mov    $0x4022,%ecx
    6a93:	41 b8 ff ff ff ff    	mov    $0xffffffff,%r8d
    6a99:	45 31 c9             	xor    %r9d,%r9d
    6a9c:	e8 4f b6 ff ff       	call   20f0 <mmap@plt>
    6aa1:	48 83 f8 ff          	cmp    $0xffffffffffffffff,%rax
    6aa5:	0f 84 4e 02 00 00    	je     6cf9 <fwp_gc_init+0x3e9>
    6aab:	48 85 c0             	test   %rax,%rax
    6aae:	0f 84 a6 02 00 00    	je     6d5a <fwp_gc_init+0x44a>
    6ab4:	48 89 05 fd c6 00 00 	mov    %rax,0xc6fd(%rip)        # 131b8 <fwp_gc+0x1038>
    6abb:	48 89 d9             	mov    %rbx,%rcx
    6abe:	48 81 c9 00 00 01 00 	or     $0x10000,%rcx
    6ac5:	48 89 0d f4 c6 00 00 	mov    %rcx,0xc6f4(%rip)        # 131c0 <fwp_gc+0x1040>
    6acc:	48 05 ff ff 00 00    	add    $0xffff,%rax
    6ad2:	48 25 00 00 ff ff    	and    $0xffffffffffff0000,%rax
    6ad8:	48 89 05 d1 c6 00 00 	mov    %rax,0xc6d1(%rip)        # 131b0 <fwp_gc+0x1030>
    6adf:	48 c1 eb 10          	shr    $0x10,%rbx
    6ae3:	48 89 1d e6 c6 00 00 	mov    %rbx,0xc6e6(%rip)        # 131d0 <fwp_gc+0x1050>
    6aea:	48 69 f3 28 12 00 00 	imul   $0x1228,%rbx,%rsi
    6af1:	48 89 35 08 c7 00 00 	mov    %rsi,0xc708(%rip)        # 13200 <fwp_gc+0x1080>
    6af8:	31 ff                	xor    %edi,%edi
    6afa:	31 d2                	xor    %edx,%edx
    6afc:	b9 22 40 00 00       	mov    $0x4022,%ecx
    6b01:	41 b8 ff ff ff ff    	mov    $0xffffffff,%r8d
    6b07:	45 31 c9             	xor    %r9d,%r9d
    6b0a:	e8 e1 b5 ff ff       	call   20f0 <mmap@plt>
    6b0f:	48 83 f8 ff          	cmp    $0xffffffffffffffff,%rax
    6b13:	0f 84 41 02 00 00    	je     6d5a <fwp_gc_init+0x44a>
    6b19:	48 89 05 d8 c6 00 00 	mov    %rax,0xc6d8(%rip)        # 131f8 <fwp_gc+0x1078>
    6b20:	48 8d 3d 4c 89 00 00 	lea    0x894c(%rip),%rdi        # f473 <fwp_segv.msg+0x233>
    6b27:	e8 04 b5 ff ff       	call   2030 <getenv@plt>
    6b2c:	48 85 c0             	test   %rax,%rax
    6b2f:	74 2e                	je     6b5f <fwp_gc_init+0x24f>
    6b31:	48 89 c3             	mov    %rax,%rbx
    6b34:	48 8d 35 3f 89 00 00 	lea    0x893f(%rip),%rsi        # f47a <fwp_segv.msg+0x23a>
    6b3b:	48 89 c7             	mov    %rax,%rdi
    6b3e:	e8 3d b6 ff ff       	call   2180 <strcmp@plt>
    6b43:	85 c0                	test   %eax,%eax
    6b45:	74 1f                	je     6b66 <fwp_gc_init+0x256>
    6b47:	48 8d 35 14 8b 00 00 	lea    0x8b14(%rip),%rsi        # f662 <fwp_segv.msg+0x422>
    6b4e:	48 89 df             	mov    %rbx,%rdi
    6b51:	e8 2a b6 ff ff       	call   2180 <strcmp@plt>
    6b56:	31 c9                	xor    %ecx,%ecx
    6b58:	85 c0                	test   %eax,%eax
    6b5a:	0f 95 c1             	setne  %cl
    6b5d:	eb 09                	jmp    6b68 <fwp_gc_init+0x258>
    6b5f:	b9 01 00 00 00       	mov    $0x1,%ecx
    6b64:	eb 02                	jmp    6b68 <fwp_gc_init+0x258>
    6b66:	31 c9                	xor    %ecx,%ecx
    6b68:	89 0d 02 c6 00 00    	mov    %ecx,0xc602(%rip)        # 13170 <fwp_gc+0xff0>
    6b6e:	48 8d 3d 09 89 00 00 	lea    0x8909(%rip),%rdi        # f47e <fwp_segv.msg+0x23e>
    6b75:	e8 b6 b4 ff ff       	call   2030 <getenv@plt>
    6b7a:	31 c9                	xor    %ecx,%ecx
    6b7c:	48 85 c0             	test   %rax,%rax
    6b7f:	74 1b                	je     6b9c <fwp_gc_init+0x28c>
    6b81:	80 38 00             	cmpb   $0x0,(%rax)
    6b84:	74 16                	je     6b9c <fwp_gc_init+0x28c>
    6b86:	48 8d 35 d5 8a 00 00 	lea    0x8ad5(%rip),%rsi        # f662 <fwp_segv.msg+0x422>
    6b8d:	48 89 c7             	mov    %rax,%rdi
    6b90:	e8 eb b5 ff ff       	call   2180 <strcmp@plt>
    6b95:	31 c9                	xor    %ecx,%ecx
    6b97:	85 c0                	test   %eax,%eax
    6b99:	0f 95 c1             	setne  %cl
    6b9c:	89 0d da c5 00 00    	mov    %ecx,0xc5da(%rip)        # 1317c <fwp_gc+0xffc>
    6ba2:	48 8d 3d ca 88 00 00 	lea    0x88ca(%rip),%rdi        # f473 <fwp_segv.msg+0x233>
    6ba9:	e8 82 b4 ff ff       	call   2030 <getenv@plt>
    6bae:	48 85 c0             	test   %rax,%rax
    6bb1:	74 18                	je     6bcb <fwp_gc_init+0x2bb>
    6bb3:	48 8d 35 d1 88 00 00 	lea    0x88d1(%rip),%rsi        # f48b <fwp_segv.msg+0x24b>
    6bba:	48 89 c7             	mov    %rax,%rdi
    6bbd:	e8 be b5 ff ff       	call   2180 <strcmp@plt>
    6bc2:	31 c9                	xor    %ecx,%ecx
    6bc4:	85 c0                	test   %eax,%eax
    6bc6:	0f 95 c1             	setne  %cl
    6bc9:	eb 05                	jmp    6bd0 <fwp_gc_init+0x2c0>
    6bcb:	b9 01 00 00 00       	mov    $0x1,%ecx
    6bd0:	89 0d aa c5 00 00    	mov    %ecx,0xc5aa(%rip)        # 13180 <fwp_gc+0x1000>
    6bd6:	c7 05 a8 c5 00 00 01 	movl   $0x1,0xc5a8(%rip)        # 13188 <fwp_gc+0x1008>
    6bdd:	00 00 00 
    6be0:	48 8d 3d a9 88 00 00 	lea    0x88a9(%rip),%rdi        # f490 <fwp_segv.msg+0x250>
    6be7:	e8 44 b4 ff ff       	call   2030 <getenv@plt>
    6bec:	31 c9                	xor    %ecx,%ecx
    6bee:	48 85 c0             	test   %rax,%rax
    6bf1:	74 1b                	je     6c0e <fwp_gc_init+0x2fe>
    6bf3:	80 38 00             	cmpb   $0x0,(%rax)
    6bf6:	74 16                	je     6c0e <fwp_gc_init+0x2fe>
    6bf8:	48 8d 35 63 8a 00 00 	lea    0x8a63(%rip),%rsi        # f662 <fwp_segv.msg+0x422>
    6bff:	48 89 c7             	mov    %rax,%rdi
    6c02:	e8 79 b5 ff ff       	call   2180 <strcmp@plt>
    6c07:	31 c9                	xor    %ecx,%ecx
    6c09:	85 c0                	test   %eax,%eax
    6c0b:	0f 95 c1             	setne  %cl
    6c0e:	89 0d 70 c5 00 00    	mov    %ecx,0xc570(%rip)        # 13184 <fwp_gc+0x1004>
    6c14:	48 8d 3d 83 88 00 00 	lea    0x8883(%rip),%rdi        # f49e <fwp_segv.msg+0x25e>
    6c1b:	e8 10 b4 ff ff       	call   2030 <getenv@plt>
    6c20:	48 85 c0             	test   %rax,%rax
    6c23:	74 14                	je     6c39 <fwp_gc_init+0x329>
    6c25:	48 89 c7             	mov    %rax,%rdi
    6c28:	31 f6                	xor    %esi,%esi
    6c2a:	ba 0a 00 00 00       	mov    $0xa,%edx
    6c2f:	e8 9c b5 ff ff       	call   21d0 <strtol@plt>
    6c34:	48 89 c3             	mov    %rax,%rbx
    6c37:	eb 02                	jmp    6c3b <fwp_gc_init+0x32b>
    6c39:	31 db                	xor    %ebx,%ebx
    6c3b:	31 c0                	xor    %eax,%eax
    6c3d:	48 85 db             	test   %rbx,%rbx
    6c40:	48 0f 4f c3          	cmovg  %rbx,%rax
    6c44:	48 89 05 55 c5 00 00 	mov    %rax,0xc555(%rip)        # 131a0 <fwp_gc+0x1020>
    6c4b:	48 8d 3d 21 88 00 00 	lea    0x8821(%rip),%rdi        # f473 <fwp_segv.msg+0x233>
    6c52:	e8 d9 b3 ff ff       	call   2030 <getenv@plt>
    6c57:	48 85 c0             	test   %rax,%rax
    6c5a:	74 32                	je     6c8e <fwp_gc_init+0x37e>
    6c5c:	49 89 c6             	mov    %rax,%r14
    6c5f:	80 38 00             	cmpb   $0x0,(%rax)
    6c62:	74 2a                	je     6c8e <fwp_gc_init+0x37e>
    6c64:	48 8d 35 0f 88 00 00 	lea    0x880f(%rip),%rsi        # f47a <fwp_segv.msg+0x23a>
    6c6b:	4c 89 f7             	mov    %r14,%rdi
    6c6e:	e8 0d b5 ff ff       	call   2180 <strcmp@plt>
    6c73:	85 c0                	test   %eax,%eax
    6c75:	74 17                	je     6c8e <fwp_gc_init+0x37e>
    6c77:	48 8d 35 e4 89 00 00 	lea    0x89e4(%rip),%rsi        # f662 <fwp_segv.msg+0x422>
    6c7e:	4c 89 f7             	mov    %r14,%rdi
    6c81:	e8 fa b4 ff ff       	call   2180 <strcmp@plt>
    6c86:	85 c0                	test   %eax,%eax
    6c88:	0f 85 f6 00 00 00    	jne    6d84 <fwp_gc_init+0x474>
    6c8e:	48 85 db             	test   %rbx,%rbx
    6c91:	0f 8f ed 00 00 00    	jg     6d84 <fwp_gc_init+0x474>
    6c97:	83 3d e6 c4 00 00 00 	cmpl   $0x0,0xc4e6(%rip)        # 13184 <fwp_gc+0x1004>
    6c9e:	0f 85 e0 00 00 00    	jne    6d84 <fwp_gc_init+0x474>
    6ca4:	48 8d 3d 3e 88 00 00 	lea    0x883e(%rip),%rdi        # f4e9 <fwp_segv.msg+0x2a9>
    6cab:	e8 80 b3 ff ff       	call   2030 <getenv@plt>
    6cb0:	48 85 c0             	test   %rax,%rax
    6cb3:	74 1c                	je     6cd1 <fwp_gc_init+0x3c1>
    6cb5:	80 38 00             	cmpb   $0x0,(%rax)
    6cb8:	74 17                	je     6cd1 <fwp_gc_init+0x3c1>
    6cba:	48 8d 35 a1 89 00 00 	lea    0x89a1(%rip),%rsi        # f662 <fwp_segv.msg+0x422>
    6cc1:	48 89 c7             	mov    %rax,%rdi
    6cc4:	e8 b7 b4 ff ff       	call   2180 <strcmp@plt>
    6cc9:	85 c0                	test   %eax,%eax
    6ccb:	0f 85 e1 00 00 00    	jne    6db2 <fwp_gc_init+0x4a2>
    6cd1:	c7 05 95 c4 00 00 00 	movl   $0x0,0xc495(%rip)        # 13170 <fwp_gc+0xff0>
    6cd8:	00 00 00 
    6cdb:	48 c7 05 aa c6 00 00 	movq   $0x800000,0xc6aa(%rip)        # 13390 <fwp_gc+0x1210>
    6ce2:	00 00 80 00 
    6ce6:	48 c7 05 8f b4 00 00 	movq   $0x800000,0xb48f(%rip)        # 12180 <fwp_gc>
    6ced:	00 00 80 00 
    6cf1:	48 83 c4 08          	add    $0x8,%rsp
    6cf5:	5b                   	pop    %rbx
    6cf6:	41 5e                	pop    %r14
    6cf8:	c3                   	ret
    6cf9:	be 00 00 01 40       	mov    $0x40010000,%esi
    6cfe:	31 ff                	xor    %edi,%edi
    6d00:	31 d2                	xor    %edx,%edx
    6d02:	b9 22 40 00 00       	mov    $0x4022,%ecx
    6d07:	41 b8 ff ff ff ff    	mov    $0xffffffff,%r8d
    6d0d:	45 31 c9             	xor    %r9d,%r9d
    6d10:	e8 db b3 ff ff       	call   20f0 <mmap@plt>
    6d15:	48 83 f8 ff          	cmp    $0xffffffffffffffff,%rax
    6d19:	74 0f                	je     6d2a <fwp_gc_init+0x41a>
    6d1b:	48 85 c0             	test   %rax,%rax
    6d1e:	74 3a                	je     6d5a <fwp_gc_init+0x44a>
    6d20:	bb 00 00 00 40       	mov    $0x40000000,%ebx
    6d25:	e9 8a fd ff ff       	jmp    6ab4 <fwp_gc_init+0x1a4>
    6d2a:	be 00 00 01 10       	mov    $0x10010000,%esi
    6d2f:	31 ff                	xor    %edi,%edi
    6d31:	31 d2                	xor    %edx,%edx
    6d33:	b9 22 40 00 00       	mov    $0x4022,%ecx
    6d38:	41 b8 ff ff ff ff    	mov    $0xffffffff,%r8d
    6d3e:	45 31 c9             	xor    %r9d,%r9d
    6d41:	e8 aa b3 ff ff       	call   20f0 <mmap@plt>
    6d46:	48 8d 48 01          	lea    0x1(%rax),%rcx
    6d4a:	48 83 f9 02          	cmp    $0x2,%rcx
    6d4e:	72 0a                	jb     6d5a <fwp_gc_init+0x44a>
    6d50:	bb 00 00 00 10       	mov    $0x10000000,%ebx
    6d55:	e9 5a fd ff ff       	jmp    6ab4 <fwp_gc_init+0x1a4>
    6d5a:	48 8b 05 7f b2 00 00 	mov    0xb27f(%rip),%rax        # 11fe0 <stderr@GLIBC_2.2.5>
    6d61:	48 8b 08             	mov    (%rax),%rcx
    6d64:	48 8d 3d ce 87 00 00 	lea    0x87ce(%rip),%rdi        # f539 <fwp_segv.msg+0x2f9>
    6d6b:	be 13 00 00 00       	mov    $0x13,%esi
    6d70:	ba 01 00 00 00       	mov    $0x1,%edx
    6d75:	e8 26 b5 ff ff       	call   22a0 <fwrite@plt>
    6d7a:	bf 66 00 00 00       	mov    $0x66,%edi
    6d7f:	e8 0c b5 ff ff       	call   2290 <exit@plt>
    6d84:	e8 a7 f5 ff ff       	call   6330 <fwp_flush>
    6d89:	48 8b 05 50 b2 00 00 	mov    0xb250(%rip),%rax        # 11fe0 <stderr@GLIBC_2.2.5>
    6d90:	48 8b 38             	mov    (%rax),%rdi
    6d93:	48 8d 35 93 86 00 00 	lea    0x8693(%rip),%rsi        # f42d <fwp_segv.msg+0x1ed>
    6d9a:	48 8d 15 0b 87 00 00 	lea    0x870b(%rip),%rdx        # f4ac <fwp_segv.msg+0x26c>
    6da1:	31 c0                	xor    %eax,%eax
    6da3:	e8 08 b4 ff ff       	call   21b0 <fprintf@plt>
    6da8:	bf 65 00 00 00       	mov    $0x65,%edi
    6dad:	e8 de b4 ff ff       	call   2290 <exit@plt>
    6db2:	e8 79 f5 ff ff       	call   6330 <fwp_flush>
    6db7:	48 8b 05 22 b2 00 00 	mov    0xb222(%rip),%rax        # 11fe0 <stderr@GLIBC_2.2.5>
    6dbe:	48 8b 38             	mov    (%rax),%rdi
    6dc1:	48 8d 35 65 86 00 00 	lea    0x8665(%rip),%rsi        # f42d <fwp_segv.msg+0x1ed>
    6dc8:	48 8d 15 2b 87 00 00 	lea    0x872b(%rip),%rdx        # f4fa <fwp_segv.msg+0x2ba>
    6dcf:	eb d0                	jmp    6da1 <fwp_gc_init+0x491>
    6dd1:	66 66 66 66 66 66 2e 	data16 data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    6dd8:	0f 1f 84 00 00 00 00 
    6ddf:	00 

0000000000006de0 <fwp_gc_alloc_big>:
    6de0:	55                   	push   %rbp
    6de1:	41 57                	push   %r15
    6de3:	41 56                	push   %r14
    6de5:	41 55                	push   %r13
    6de7:	41 54                	push   %r12
    6de9:	53                   	push   %rbx
    6dea:	50                   	push   %rax
    6deb:	48 b8 01 00 00 00 00 	movabs $0x4000000000000001,%rax
    6df2:	00 00 40 
    6df5:	48 39 c7             	cmp    %rax,%rdi
    6df8:	0f 83 ce 01 00 00    	jae    6fcc <fwp_gc_alloc_big+0x1ec>
    6dfe:	89 f5                	mov    %esi,%ebp
    6e00:	48 89 fb             	mov    %rdi,%rbx
    6e03:	48 29 3d 76 b3 00 00 	sub    %rdi,0xb376(%rip)        # 12180 <fwp_gc>
    6e0a:	0f 89 80 00 00 00    	jns    6e90 <fwp_gc_alloc_big+0xb0>
    6e10:	83 3d 55 c3 00 00 00 	cmpl   $0x0,0xc355(%rip)        # 1316c <fwp_gc+0xfec>
    6e17:	75 05                	jne    6e1e <fwp_gc_alloc_big+0x3e>
    6e19:	e8 f2 fa ff ff       	call   6910 <fwp_gc_init>
    6e1e:	8b 0d 50 c3 00 00    	mov    0xc350(%rip),%ecx        # 13174 <fwp_gc+0xff4>
    6e24:	85 c9                	test   %ecx,%ecx
    6e26:	74 2a                	je     6e52 <fwp_gc_alloc_big+0x72>
    6e28:	48 8b 05 71 c3 00 00 	mov    0xc371(%rip),%rax        # 131a0 <fwp_gc+0x1020>
    6e2f:	48 85 c0             	test   %rax,%rax
    6e32:	74 1e                	je     6e52 <fwp_gc_alloc_big+0x72>
    6e34:	48 8b 0d 6d c3 00 00 	mov    0xc36d(%rip),%rcx        # 131a8 <fwp_gc+0x1028>
    6e3b:	48 ff c1             	inc    %rcx
    6e3e:	48 89 0d 63 c3 00 00 	mov    %rcx,0xc363(%rip)        # 131a8 <fwp_gc+0x1028>
    6e45:	48 39 c1             	cmp    %rax,%rcx
    6e48:	0f 8d ad 01 00 00    	jge    6ffb <fwp_gc_alloc_big+0x21b>
    6e4e:	31 c0                	xor    %eax,%eax
    6e50:	eb 0d                	jmp    6e5f <fwp_gc_alloc_big+0x7f>
    6e52:	b8 00 00 80 00       	mov    $0x800000,%eax
    6e57:	85 c9                	test   %ecx,%ecx
    6e59:	0f 85 97 01 00 00    	jne    6ff6 <fwp_gc_alloc_big+0x216>
    6e5f:	48 8b 0d 2a c5 00 00 	mov    0xc52a(%rip),%rcx        # 13390 <fwp_gc+0x1210>
    6e66:	48 2b 0d 13 b3 00 00 	sub    0xb313(%rip),%rcx        # 12180 <fwp_gc>
    6e6d:	f2 48 0f 2a c1       	cvtsi2sd %rcx,%xmm0
    6e72:	f2 0f 58 05 ee c4 00 	addsd  0xc4ee(%rip),%xmm0        # 13368 <fwp_gc+0x11e8>
    6e79:	00 
    6e7a:	f2 0f 11 05 e6 c4 00 	movsd  %xmm0,0xc4e6(%rip)        # 13368 <fwp_gc+0x11e8>
    6e81:	00 
    6e82:	48 89 05 07 c5 00 00 	mov    %rax,0xc507(%rip)        # 13390 <fwp_gc+0x1210>
    6e89:	48 89 05 f0 b2 00 00 	mov    %rax,0xb2f0(%rip)        # 12180 <fwp_gc>
    6e90:	4c 8d b3 ff ff 00 00 	lea    0xffff(%rbx),%r14
    6e97:	49 c1 ee 10          	shr    $0x10,%r14
    6e9b:	4c 89 f7             	mov    %r14,%rdi
    6e9e:	e8 9d 02 00 00       	call   7140 <fwp_gc_chunks>
    6ea3:	48 8b 0d 4e c3 00 00 	mov    0xc34e(%rip),%rcx        # 131f8 <fwp_gc+0x1078>
    6eaa:	4c 69 e0 28 12 00 00 	imul   $0x1228,%rax,%r12
    6eb1:	42 c6 04 21 02       	movb   $0x2,(%rcx,%r12,1)
    6eb6:	42 88 6c 21 01       	mov    %bpl,0x1(%rcx,%r12,1)
    6ebb:	66 42 c7 44 21 03 00 	movw   $0x100,0x3(%rcx,%r12,1)
    6ec2:	01 
    6ec3:	46 89 74 21 10       	mov    %r14d,0x10(%rcx,%r12,1)
    6ec8:	4a 89 5c 21 18       	mov    %rbx,0x18(%rcx,%r12,1)
    6ecd:	4e 8d 3c 21          	lea    (%rcx,%r12,1),%r15
    6ed1:	49 81 c7 28 02 00 00 	add    $0x228,%r15
    6ed8:	42 80 bc 21 28 02 00 	cmpb   $0xff,0x228(%rcx,%r12,1)
    6edf:	00 ff 
    6ee1:	0f 84 d2 00 00 00    	je     6fb9 <fwp_gc_alloc_big+0x1d9>
    6ee7:	41 c6 07 00          	movb   $0x0,(%r15)
    6eeb:	48 81 fb 01 00 01 00 	cmp    $0x10001,%rbx
    6ef2:	0f 82 9b 00 00 00    	jb     6f93 <fwp_gc_alloc_big+0x1b3>
    6ef8:	49 83 fe 03          	cmp    $0x3,%r14
    6efc:	ba 02 00 00 00       	mov    $0x2,%edx
    6f01:	49 0f 43 d6          	cmovae %r14,%rdx
    6f05:	48 8b 0d ec c2 00 00 	mov    0xc2ec(%rip),%rcx        # 131f8 <fwp_gc+0x1078>
    6f0c:	48 ff ca             	dec    %rdx
    6f0f:	be 01 00 00 00       	mov    $0x1,%esi
    6f14:	48 81 fb 01 00 02 00 	cmp    $0x20001,%rbx
    6f1b:	72 5a                	jb     6f77 <fwp_gc_alloc_big+0x197>
    6f1d:	49 8d 3c 0c          	lea    (%r12,%rcx,1),%rdi
    6f21:	48 81 c7 60 24 00 00 	add    $0x2460,%rdi
    6f28:	49 89 d0             	mov    %rdx,%r8
    6f2b:	49 83 e0 fe          	and    $0xfffffffffffffffe,%r8
    6f2f:	49 f7 d8             	neg    %r8
    6f32:	66 66 66 66 66 2e 0f 	data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    6f39:	1f 84 00 00 00 00 00 
    6f40:	c6 87 c8 ed ff ff 03 	movb   $0x3,-0x1238(%rdi)
    6f47:	c6 87 cc ed ff ff 01 	movb   $0x1,-0x1234(%rdi)
    6f4e:	89 87 d8 ed ff ff    	mov    %eax,-0x1228(%rdi)
    6f54:	c6 47 f0 03          	movb   $0x3,-0x10(%rdi)
    6f58:	c6 47 f4 01          	movb   $0x1,-0xc(%rdi)
    6f5c:	89 07                	mov    %eax,(%rdi)
    6f5e:	48 81 c7 50 24 00 00 	add    $0x2450,%rdi
    6f65:	4d 8d 0c 30          	lea    (%r8,%rsi,1),%r9
    6f69:	49 83 c1 02          	add    $0x2,%r9
    6f6d:	48 83 c6 02          	add    $0x2,%rsi
    6f71:	49 83 f9 01          	cmp    $0x1,%r9
    6f75:	75 c9                	jne    6f40 <fwp_gc_alloc_big+0x160>
    6f77:	f6 c2 01             	test   $0x1,%dl
    6f7a:	74 17                	je     6f93 <fwp_gc_alloc_big+0x1b3>
    6f7c:	4c 01 e1             	add    %r12,%rcx
    6f7f:	48 69 d6 28 12 00 00 	imul   $0x1228,%rsi,%rdx
    6f86:	c6 04 11 03          	movb   $0x3,(%rcx,%rdx,1)
    6f8a:	c6 44 11 04 01       	movb   $0x1,0x4(%rcx,%rdx,1)
    6f8f:	89 44 11 10          	mov    %eax,0x10(%rcx,%rdx,1)
    6f93:	48 c1 e0 10          	shl    $0x10,%rax
    6f97:	48 03 05 12 c2 00 00 	add    0xc212(%rip),%rax        # 131b0 <fwp_gc+0x1030>
    6f9e:	48 89 c7             	mov    %rax,%rdi
    6fa1:	31 f6                	xor    %esi,%esi
    6fa3:	48 89 da             	mov    %rbx,%rdx
    6fa6:	48 83 c4 08          	add    $0x8,%rsp
    6faa:	5b                   	pop    %rbx
    6fab:	41 5c                	pop    %r12
    6fad:	41 5d                	pop    %r13
    6faf:	41 5e                	pop    %r14
    6fb1:	41 5f                	pop    %r15
    6fb3:	5d                   	pop    %rbp
    6fb4:	e9 77 b1 ff ff       	jmp    2130 <memset@plt>
    6fb9:	4c 89 ff             	mov    %r15,%rdi
    6fbc:	49 89 c5             	mov    %rax,%r13
    6fbf:	e8 9c f3 ff ff       	call   6360 <fwp_rc_forget_slot>
    6fc4:	4c 89 e8             	mov    %r13,%rax
    6fc7:	e9 1b ff ff ff       	jmp    6ee7 <fwp_gc_alloc_big+0x107>
    6fcc:	48 8b 05 0d b0 00 00 	mov    0xb00d(%rip),%rax        # 11fe0 <stderr@GLIBC_2.2.5>
    6fd3:	48 8b 08             	mov    (%rax),%rcx
    6fd6:	48 8d 3d 5c 85 00 00 	lea    0x855c(%rip),%rdi        # f539 <fwp_segv.msg+0x2f9>
    6fdd:	be 13 00 00 00       	mov    $0x13,%esi
    6fe2:	ba 01 00 00 00       	mov    $0x1,%edx
    6fe7:	e8 b4 b2 ff ff       	call   22a0 <fwrite@plt>
    6fec:	bf 66 00 00 00       	mov    $0x66,%edi
    6ff1:	e8 9a b2 ff ff       	call   2290 <exit@plt>
    6ff6:	e8 d5 02 00 00       	call   72d0 <fwp_gc_collect>
    6ffb:	48 c7 05 a2 c1 00 00 	movq   $0x0,0xc1a2(%rip)        # 131a8 <fwp_gc+0x1028>
    7002:	00 00 00 00 
    7006:	e8 c5 02 00 00       	call   72d0 <fwp_gc_collect>
    700b:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)

0000000000007010 <fwp_gc_refill>:
    7010:	55                   	push   %rbp
    7011:	41 57                	push   %r15
    7013:	41 56                	push   %r14
    7015:	41 55                	push   %r13
    7017:	41 54                	push   %r12
    7019:	53                   	push   %rbx
    701a:	50                   	push   %rax
    701b:	89 d5                	mov    %edx,%ebp
    701d:	41 89 f7             	mov    %esi,%r15d
    7020:	48 89 fb             	mov    %rdi,%rbx
    7023:	bf 01 00 00 00       	mov    $0x1,%edi
    7028:	e8 13 01 00 00       	call   7140 <fwp_gc_chunks>
    702d:	49 89 c6             	mov    %rax,%r14
    7030:	4c 8b 25 c1 c1 00 00 	mov    0xc1c1(%rip),%r12        # 131f8 <fwp_gc+0x1078>
    7037:	48 8d 05 42 b1 00 00 	lea    0xb142(%rip),%rax        # 12180 <fwp_gc>
    703e:	4d 69 ee 28 12 00 00 	imul   $0x1228,%r14,%r13
    7045:	43 c6 04 2c 01       	movb   $0x1,(%r12,%r13,1)
    704a:	43 88 6c 2c 01       	mov    %bpl,0x1(%r12,%r13,1)
    704f:	47 88 7c 2c 02       	mov    %r15b,0x2(%r12,%r13,1)
    7054:	43 c6 44 2c 04 01    	movb   $0x1,0x4(%r12,%r13,1)
    705a:	44 89 f9             	mov    %r15d,%ecx
    705d:	8b 8c 88 48 0b 00 00 	mov    0xb48(%rax,%rcx,4),%ecx
    7064:	43 89 4c 2c 08       	mov    %ecx,0x8(%r12,%r13,1)
    7069:	b8 00 00 01 00       	mov    $0x10000,%eax
    706e:	31 d2                	xor    %edx,%edx
    7070:	f7 f1                	div    %ecx
    7072:	43 89 44 2c 0c       	mov    %eax,0xc(%r12,%r13,1)
    7077:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    707c:	48 01 c8             	add    %rcx,%rax
    707f:	48 0f ba e0 20       	bt     $0x20,%rax
    7084:	73 07                	jae    708d <fwp_gc_refill+0x7d>
    7086:	31 d2                	xor    %edx,%edx
    7088:	48 f7 f1             	div    %rcx
    708b:	eb 04                	jmp    7091 <fwp_gc_refill+0x81>
    708d:	31 d2                	xor    %edx,%edx
    708f:	f7 f1                	div    %ecx
    7091:	43 89 44 2c 20       	mov    %eax,0x20(%r12,%r13,1)
    7096:	48 83 3d fa ca 00 00 	cmpq   $0x0,0xcafa(%rip)        # 13b98 <fwp_gc+0x1a18>
    709d:	00 
    709e:	74 2e                	je     70ce <fwp_gc_refill+0xbe>
    70a0:	4f 8d 3c 2c          	lea    (%r12,%r13,1),%r15
    70a4:	49 81 c7 28 02 00 00 	add    $0x228,%r15
    70ab:	31 ed                	xor    %ebp,%ebp
    70ad:	eb 0d                	jmp    70bc <fwp_gc_refill+0xac>
    70af:	90                   	nop
    70b0:	48 ff c5             	inc    %rbp
    70b3:	48 81 fd 00 10 00 00 	cmp    $0x1000,%rbp
    70ba:	74 12                	je     70ce <fwp_gc_refill+0xbe>
    70bc:	41 80 3c 2f ff       	cmpb   $0xff,(%r15,%rbp,1)
    70c1:	75 ed                	jne    70b0 <fwp_gc_refill+0xa0>
    70c3:	49 8d 3c 2f          	lea    (%r15,%rbp,1),%rdi
    70c7:	e8 94 f2 ff ff       	call   6360 <fwp_rc_forget_slot>
    70cc:	eb e2                	jmp    70b0 <fwp_gc_refill+0xa0>
    70ce:	4f 8d 3c 2c          	lea    (%r12,%r13,1),%r15
    70d2:	49 83 c7 08          	add    $0x8,%r15
    70d6:	4b 8d 3c 2c          	lea    (%r12,%r13,1),%rdi
    70da:	48 81 c7 28 02 00 00 	add    $0x228,%rdi
    70e1:	ba 00 10 00 00       	mov    $0x1000,%edx
    70e6:	31 f6                	xor    %esi,%esi
    70e8:	e8 43 b0 ff ff       	call   2130 <memset@plt>
    70ed:	49 c1 e6 10          	shl    $0x10,%r14
    70f1:	4c 03 35 b8 c0 00 00 	add    0xc0b8(%rip),%r14        # 131b0 <fwp_gc+0x1030>
    70f8:	83 3d 85 c0 00 00 00 	cmpl   $0x0,0xc085(%rip)        # 13184 <fwp_gc+0x1004>
    70ff:	74 0f                	je     7110 <fwp_gc_refill+0x100>
    7101:	ba 00 00 01 00       	mov    $0x10000,%edx
    7106:	4c 89 f7             	mov    %r14,%rdi
    7109:	31 f6                	xor    %esi,%esi
    710b:	e8 20 b0 ff ff       	call   2130 <memset@plt>
    7110:	41 8b 07             	mov    (%r15),%eax
    7113:	49 8d 0c 06          	lea    (%r14,%rax,1),%rcx
    7117:	48 89 4b 08          	mov    %rcx,0x8(%rbx)
    711b:	41 8b 4f 04          	mov    0x4(%r15),%ecx
    711f:	48 0f af c8          	imul   %rax,%rcx
    7123:	4c 01 f1             	add    %r14,%rcx
    7126:	48 89 4b 10          	mov    %rcx,0x10(%rbx)
    712a:	4c 89 f0             	mov    %r14,%rax
    712d:	48 83 c4 08          	add    $0x8,%rsp
    7131:	5b                   	pop    %rbx
    7132:	41 5c                	pop    %r12
    7134:	41 5d                	pop    %r13
    7136:	41 5e                	pop    %r14
    7138:	41 5f                	pop    %r15
    713a:	5d                   	pop    %rbp
    713b:	c3                   	ret
    713c:	0f 1f 40 00          	nopl   0x0(%rax)

0000000000007140 <fwp_gc_chunks>:
    7140:	41 57                	push   %r15
    7142:	41 56                	push   %r14
    7144:	53                   	push   %rbx
    7145:	48 89 fb             	mov    %rdi,%rbx
    7148:	31 d2                	xor    %edx,%edx
    714a:	48 83 ff 01          	cmp    $0x1,%rdi
    714e:	0f 95 c2             	setne  %dl
    7151:	48 8d 0d 28 b0 00 00 	lea    0xb028(%rip),%rcx        # 12180 <fwp_gc>
    7158:	48 8b 84 d1 68 10 00 	mov    0x1068(%rcx,%rdx,8),%rax
    715f:	00 
    7160:	4c 8b 35 71 c0 00 00 	mov    0xc071(%rip),%r14        # 131d8 <fwp_gc+0x1058>
    7167:	48 89 c7             	mov    %rax,%rdi
    716a:	4c 29 f7             	sub    %r14,%rdi
    716d:	73 63                	jae    71d2 <fwp_gc_chunks+0x92>
    716f:	48 8d 34 d5 68 10 00 	lea    0x1068(,%rdx,8),%rsi
    7176:	00 
    7177:	4c 69 c0 28 12 00 00 	imul   $0x1228,%rax,%r8
    717e:	4c 03 05 73 c0 00 00 	add    0xc073(%rip),%r8        # 131f8 <fwp_gc+0x1078>
    7185:	31 d2                	xor    %edx,%edx
    7187:	45 31 c9             	xor    %r9d,%r9d
    718a:	eb 16                	jmp    71a2 <fwp_gc_chunks+0x62>
    718c:	0f 1f 40 00          	nopl   0x0(%rax)
    7190:	45 31 c9             	xor    %r9d,%r9d
    7193:	48 ff ca             	dec    %rdx
    7196:	49 81 c0 28 12 00 00 	add    $0x1228,%r8
    719d:	48 39 d7             	cmp    %rdx,%rdi
    71a0:	74 33                	je     71d5 <fwp_gc_chunks+0x95>
    71a2:	41 80 38 00          	cmpb   $0x0,(%r8)
    71a6:	75 e8                	jne    7190 <fwp_gc_chunks+0x50>
    71a8:	49 ff c1             	inc    %r9
    71ab:	49 39 d9             	cmp    %rbx,%r9
    71ae:	75 e3                	jne    7193 <fwp_gc_chunks+0x53>
    71b0:	48 ff c0             	inc    %rax
    71b3:	48 89 c7             	mov    %rax,%rdi
    71b6:	48 29 d7             	sub    %rdx,%rdi
    71b9:	48 89 3c 0e          	mov    %rdi,(%rsi,%rcx,1)
    71bd:	48 29 1d 9c c1 00 00 	sub    %rbx,0xc19c(%rip)        # 13360 <fwp_gc+0x11e0>
    71c4:	48 29 d8             	sub    %rbx,%rax
    71c7:	48 29 d0             	sub    %rdx,%rax
    71ca:	49 89 c6             	mov    %rax,%r14
    71cd:	e9 ca 00 00 00       	jmp    729c <fwp_gc_chunks+0x15c>
    71d2:	45 31 c9             	xor    %r9d,%r9d
    71d5:	4c 29 0d 84 c1 00 00 	sub    %r9,0xc184(%rip)        # 13360 <fwp_gc+0x11e0>
    71dc:	4d 29 ce             	sub    %r9,%r14
    71df:	4c 01 f3             	add    %r14,%rbx
    71e2:	48 8b 3d f7 bf 00 00 	mov    0xbff7(%rip),%rdi        # 131e0 <fwp_gc+0x1060>
    71e9:	48 39 df             	cmp    %rbx,%rdi
    71ec:	0f 83 8f 00 00 00    	jae    7281 <fwp_gc_chunks+0x141>
    71f2:	4c 8b 3d d7 bf 00 00 	mov    0xbfd7(%rip),%r15        # 131d0 <fwp_gc+0x1050>
    71f9:	49 39 df             	cmp    %rbx,%r15
    71fc:	0f 82 a3 00 00 00    	jb     72a5 <fwp_gc_chunks+0x165>
    7202:	48 8d 43 40          	lea    0x40(%rbx),%rax
    7206:	4c 39 f8             	cmp    %r15,%rax
    7209:	4c 0f 42 f8          	cmovb  %rax,%r15
    720d:	4c 89 fe             	mov    %r15,%rsi
    7210:	48 29 fe             	sub    %rdi,%rsi
    7213:	48 c1 e7 10          	shl    $0x10,%rdi
    7217:	48 03 3d 92 bf 00 00 	add    0xbf92(%rip),%rdi        # 131b0 <fwp_gc+0x1030>
    721e:	48 c1 e6 10          	shl    $0x10,%rsi
    7222:	ba 03 00 00 00       	mov    $0x3,%edx
    7227:	e8 14 b0 ff ff       	call   2240 <mprotect@plt>
    722c:	85 c0                	test   %eax,%eax
    722e:	75 75                	jne    72a5 <fwp_gc_chunks+0x165>
    7230:	bf 1e 00 00 00       	mov    $0x1e,%edi
    7235:	e8 26 b0 ff ff       	call   2260 <sysconf@plt>
    723a:	48 8b 0d b7 bf 00 00 	mov    0xbfb7(%rip),%rcx        # 131f8 <fwp_gc+0x1078>
    7241:	48 69 3d 94 bf 00 00 	imul   $0x1228,0xbf94(%rip),%rdi        # 131e0 <fwp_gc+0x1060>
    7248:	28 12 00 00 
    724c:	48 01 cf             	add    %rcx,%rdi
    724f:	49 69 d7 28 12 00 00 	imul   $0x1228,%r15,%rdx
    7256:	48 01 ca             	add    %rcx,%rdx
    7259:	48 8d 34 10          	lea    (%rax,%rdx,1),%rsi
    725d:	48 ff ce             	dec    %rsi
    7260:	48 f7 d8             	neg    %rax
    7263:	48 21 c7             	and    %rax,%rdi
    7266:	48 21 c6             	and    %rax,%rsi
    7269:	48 29 fe             	sub    %rdi,%rsi
    726c:	ba 03 00 00 00       	mov    $0x3,%edx
    7271:	e8 ca af ff ff       	call   2240 <mprotect@plt>
    7276:	85 c0                	test   %eax,%eax
    7278:	75 2b                	jne    72a5 <fwp_gc_chunks+0x165>
    727a:	4c 89 3d 5f bf 00 00 	mov    %r15,0xbf5f(%rip)        # 131e0 <fwp_gc+0x1060>
    7281:	48 89 1d 50 bf 00 00 	mov    %rbx,0xbf50(%rip)        # 131d8 <fwp_gc+0x1058>
    7288:	48 c1 e3 10          	shl    $0x10,%rbx
    728c:	48 3b 1d 35 bf 00 00 	cmp    0xbf35(%rip),%rbx        # 131c8 <fwp_gc+0x1048>
    7293:	76 07                	jbe    729c <fwp_gc_chunks+0x15c>
    7295:	48 89 1d 2c bf 00 00 	mov    %rbx,0xbf2c(%rip)        # 131c8 <fwp_gc+0x1048>
    729c:	4c 89 f0             	mov    %r14,%rax
    729f:	5b                   	pop    %rbx
    72a0:	41 5e                	pop    %r14
    72a2:	41 5f                	pop    %r15
    72a4:	c3                   	ret
    72a5:	48 8b 05 34 ad 00 00 	mov    0xad34(%rip),%rax        # 11fe0 <stderr@GLIBC_2.2.5>
    72ac:	48 8b 08             	mov    (%rax),%rcx
    72af:	48 8d 3d 83 82 00 00 	lea    0x8283(%rip),%rdi        # f539 <fwp_segv.msg+0x2f9>
    72b6:	be 13 00 00 00       	mov    $0x13,%esi
    72bb:	ba 01 00 00 00       	mov    $0x1,%edx
    72c0:	e8 db af ff ff       	call   22a0 <fwrite@plt>
    72c5:	bf 66 00 00 00       	mov    $0x66,%edi
    72ca:	e8 c1 af ff ff       	call   2290 <exit@plt>
    72cf:	90                   	nop

00000000000072d0 <fwp_gc_collect>:
    72d0:	50                   	push   %rax
    72d1:	e8 5a f0 ff ff       	call   6330 <fwp_flush>
    72d6:	48 8b 05 03 ad 00 00 	mov    0xad03(%rip),%rax        # 11fe0 <stderr@GLIBC_2.2.5>
    72dd:	48 8b 38             	mov    (%rax),%rdi
    72e0:	48 8d 35 46 81 00 00 	lea    0x8146(%rip),%rsi        # f42d <fwp_segv.msg+0x1ed>
    72e7:	48 8d 15 5f 82 00 00 	lea    0x825f(%rip),%rdx        # f54d <fwp_segv.msg+0x30d>
    72ee:	31 c0                	xor    %eax,%eax
    72f0:	e8 bb ae ff ff       	call   21b0 <fprintf@plt>
    72f5:	bf 65 00 00 00       	mov    $0x65,%edi
    72fa:	e8 91 af ff ff       	call   2290 <exit@plt>
    72ff:	90                   	nop

0000000000007300 <f12>:
    7300:	55                   	push   %rbp
    7301:	41 57                	push   %r15
    7303:	41 56                	push   %r14
    7305:	41 55                	push   %r13
    7307:	41 54                	push   %r12
    7309:	53                   	push   %rbx
    730a:	50                   	push   %rax
    730b:	48 89 d3             	mov    %rdx,%rbx
    730e:	49 89 ff             	mov    %rdi,%r15
    7311:	49 bc ff ff ff ff ff 	movabs $0x7fffffffffffffff,%r12
    7318:	ff ff 7f 
    731b:	48 8b 02             	mov    (%rdx),%rax
    731e:	49 89 c6             	mov    %rax,%r14
    7321:	4d 21 e6             	and    %r12,%r14
    7324:	31 c9                	xor    %ecx,%ecx
    7326:	48 85 ff             	test   %rdi,%rdi
    7329:	4c 0f 4e f9          	cmovle %rcx,%r15
    732d:	4d 39 f7             	cmp    %r14,%r15
    7330:	4d 0f 43 fe          	cmovae %r14,%r15
    7334:	48 85 f6             	test   %rsi,%rsi
    7337:	48 0f 4f ce          	cmovg  %rsi,%rcx
    733b:	4d 29 fe             	sub    %r15,%r14
    733e:	4c 39 f1             	cmp    %r14,%rcx
    7341:	4c 0f 42 f1          	cmovb  %rcx,%r14
    7345:	4d 85 f6             	test   %r14,%r14
    7348:	74 10                	je     735a <f12+0x5a>
    734a:	48 89 d9             	mov    %rbx,%rcx
    734d:	48 85 c0             	test   %rax,%rax
    7350:	78 1b                	js     736d <f12+0x6d>
    7352:	49 83 fe 04          	cmp    $0x4,%r14
    7356:	73 1f                	jae    7377 <f12+0x77>
    7358:	eb 44                	jmp    739e <f12+0x9e>
    735a:	48 8d 35 ef a8 00 00 	lea    0xa8ef(%rip),%rsi        # 11c50 <d0>
    7361:	31 ff                	xor    %edi,%edi
    7363:	e8 a8 f1 ff ff       	call   6510 <fwp_array_typed_new>
    7368:	e9 7e 00 00 00       	jmp    73eb <f12+0xeb>
    736d:	48 8b 4b 08          	mov    0x8(%rbx),%rcx
    7371:	49 83 fe 04          	cmp    $0x4,%r14
    7375:	72 27                	jb     739e <f12+0x9e>
    7377:	48 8b 09             	mov    (%rcx),%rcx
    737a:	48 89 ca             	mov    %rcx,%rdx
    737d:	48 c1 ea 02          	shr    $0x2,%rdx
    7381:	48 be ff ff ff ff ff 	movabs $0x1fffffffffffffff,%rsi
    7388:	ff ff 1f 
    738b:	48 21 d6             	and    %rdx,%rsi
    738e:	83 e1 03             	and    $0x3,%ecx
    7391:	48 83 f9 01          	cmp    $0x1,%rcx
    7395:	48 83 de ff          	sbb    $0xffffffffffffffff,%rsi
    7399:	4c 39 f6             	cmp    %r14,%rsi
    739c:	76 5c                	jbe    73fa <f12+0xfa>
    739e:	48 8d 35 ab a8 00 00 	lea    0xa8ab(%rip),%rsi        # 11c50 <d0>
    73a5:	4c 89 f7             	mov    %r14,%rdi
    73a8:	e8 63 f1 ff ff       	call   6510 <fwp_array_typed_new>
    73ad:	48 8d 4b 08          	lea    0x8(%rbx),%rcx
    73b1:	49 c1 e7 03          	shl    $0x3,%r15
    73b5:	31 d2                	xor    %edx,%edx
    73b7:	66 0f 1f 84 00 00 00 	nopw   0x0(%rax,%rax,1)
    73be:	00 00 
    73c0:	48 83 3b 00          	cmpq   $0x0,(%rbx)
    73c4:	48 89 ce             	mov    %rcx,%rsi
    73c7:	79 04                	jns    73cd <f12+0xcd>
    73c9:	48 8b 73 10          	mov    0x10(%rbx),%rsi
    73cd:	48 83 38 00          	cmpq   $0x0,(%rax)
    73d1:	0f 88 37 02 00 00    	js     760e <f12+0x30e>
    73d7:	4c 01 fe             	add    %r15,%rsi
    73da:	48 8b 34 d6          	mov    (%rsi,%rdx,8),%rsi
    73de:	48 89 74 d0 08       	mov    %rsi,0x8(%rax,%rdx,8)
    73e3:	48 ff c2             	inc    %rdx
    73e6:	49 39 d6             	cmp    %rdx,%r14
    73e9:	75 d5                	jne    73c0 <f12+0xc0>
    73eb:	48 83 c4 08          	add    $0x8,%rsp
    73ef:	5b                   	pop    %rbx
    73f0:	41 5c                	pop    %r12
    73f2:	41 5d                	pop    %r13
    73f4:	41 5e                	pop    %r14
    73f6:	41 5f                	pop    %r15
    73f8:	5d                   	pop    %rbp
    73f9:	c3                   	ret
    73fa:	48 85 c0             	test   %rax,%rax
    73fd:	78 09                	js     7408 <f12+0x108>
    73ff:	48 8d 43 08          	lea    0x8(%rbx),%rax
    7403:	49 89 dd             	mov    %rbx,%r13
    7406:	eb 08                	jmp    7410 <f12+0x110>
    7408:	4c 8b 6b 08          	mov    0x8(%rbx),%r13
    740c:	48 8b 43 10          	mov    0x10(%rbx),%rax
    7410:	4a 8d 2c f8          	lea    (%rax,%r15,8),%rbp
    7414:	48 8d 0d 65 ad 00 00 	lea    0xad65(%rip),%rcx        # 12180 <fwp_gc>
    741b:	0f b6 05 48 b9 00 00 	movzbl 0xb948(%rip),%eax        # 12d6a <fwp_gc+0xbea>
    7422:	8b 94 81 48 0b 00 00 	mov    0xb48(%rcx,%rax,4),%edx
    7429:	48 8b 3d 50 ad 00 00 	mov    0xad50(%rip),%rdi        # 12180 <fwp_gc>
    7430:	48 29 d7             	sub    %rdx,%rdi
    7433:	48 89 3d 46 ad 00 00 	mov    %rdi,0xad46(%rip)        # 12180 <fwp_gc>
    743a:	78 56                	js     7492 <f12+0x192>
    743c:	48 8d 34 40          	lea    (%rax,%rax,2),%rsi
    7440:	4c 8d 04 f1          	lea    (%rcx,%rsi,8),%r8
    7444:	49 83 c0 08          	add    $0x8,%r8
    7448:	49 8b 00             	mov    (%r8),%rax
    744b:	48 85 c0             	test   %rax,%rax
    744e:	74 25                	je     7475 <f12+0x175>
    7450:	48 8b 08             	mov    (%rax),%rcx
    7453:	48 f7 d1             	not    %rcx
    7456:	49 89 08             	mov    %rcx,(%r8)
    7459:	83 fa 19             	cmp    $0x19,%edx
    745c:	72 7e                	jb     74dc <f12+0x1dc>
    745e:	48 8d 78 18          	lea    0x18(%rax),%rdi
    7462:	48 83 c2 e7          	add    $0xffffffffffffffe7,%rdx
    7466:	48 83 e2 f8          	and    $0xfffffffffffffff8,%rdx
    746a:	48 83 c2 08          	add    $0x8,%rdx
    746e:	31 f6                	xor    %esi,%esi
    7470:	49 89 c7             	mov    %rax,%r15
    7473:	eb 5f                	jmp    74d4 <f12+0x1d4>
    7475:	48 8b 44 f1 10       	mov    0x10(%rcx,%rsi,8),%rax
    747a:	4c 8b 44 f1 18       	mov    0x18(%rcx,%rsi,8),%r8
    747f:	4d 89 c1             	mov    %r8,%r9
    7482:	49 29 c1             	sub    %rax,%r9
    7485:	49 39 d1             	cmp    %rdx,%r9
    7488:	73 16                	jae    74a0 <f12+0x1a0>
    748a:	49 89 c7             	mov    %rax,%r15
    748d:	49 39 d1             	cmp    %rdx,%r9
    7490:	73 34                	jae    74c6 <f12+0x1c6>
    7492:	bf 18 00 00 00       	mov    $0x18,%edi
    7497:	31 f6                	xor    %esi,%esi
    7499:	e8 e2 f2 ff ff       	call   6780 <fwp_gc_alloc_slow>
    749e:	eb 3c                	jmp    74dc <f12+0x1dc>
    74a0:	4c 8d 0c f1          	lea    (%rcx,%rsi,8),%r9
    74a4:	49 83 c1 10          	add    $0x10,%r9
    74a8:	4c 8d 3c 10          	lea    (%rax,%rdx,1),%r15
    74ac:	4d 89 39             	mov    %r15,(%r9)
    74af:	48 85 c0             	test   %rax,%rax
    74b2:	75 a5                	jne    7459 <f12+0x159>
    74b4:	48 89 3d c5 ac 00 00 	mov    %rdi,0xacc5(%rip)        # 12180 <fwp_gc>
    74bb:	4d 29 f8             	sub    %r15,%r8
    74be:	4d 89 c1             	mov    %r8,%r9
    74c1:	49 39 d1             	cmp    %rdx,%r9
    74c4:	72 cc                	jb     7492 <f12+0x192>
    74c6:	49 8d 04 17          	lea    (%r15,%rdx,1),%rax
    74ca:	48 89 44 f1 10       	mov    %rax,0x10(%rcx,%rsi,8)
    74cf:	4c 89 ff             	mov    %r15,%rdi
    74d2:	31 f6                	xor    %esi,%esi
    74d4:	e8 57 ac ff ff       	call   2130 <memset@plt>
    74d9:	4c 89 f8             	mov    %r15,%rax
    74dc:	4b 8d 0c 34          	lea    (%r12,%r14,1),%rcx
    74e0:	48 ff c1             	inc    %rcx
    74e3:	48 89 08             	mov    %rcx,(%rax)
    74e6:	4c 89 68 08          	mov    %r13,0x8(%rax)
    74ea:	48 89 68 10          	mov    %rbp,0x10(%rax)
    74ee:	4c 2b 2d bb bc 00 00 	sub    0xbcbb(%rip),%r13        # 131b0 <fwp_gc+0x1030>
    74f5:	48 8b 0d dc bc 00 00 	mov    0xbcdc(%rip),%rcx        # 131d8 <fwp_gc+0x1058>
    74fc:	48 c1 e1 10          	shl    $0x10,%rcx
    7500:	49 39 cd             	cmp    %rcx,%r13
    7503:	73 6a                	jae    756f <f12+0x26f>
    7505:	48 8b 0d ec bc 00 00 	mov    0xbcec(%rip),%rcx        # 131f8 <fwp_gc+0x1078>
    750c:	4c 89 ea             	mov    %r13,%rdx
    750f:	48 c1 ea 10          	shr    $0x10,%rdx
    7513:	48 69 d2 28 12 00 00 	imul   $0x1228,%rdx,%rdx
    751a:	0f b6 34 11          	movzbl (%rcx,%rdx,1),%esi
    751e:	49 81 e5 ff ff 00 00 	and    $0xffff,%r13
    7525:	75 13                	jne    753a <f12+0x23a>
    7527:	40 80 fe 02          	cmp    $0x2,%sil
    752b:	75 0d                	jne    753a <f12+0x23a>
    752d:	48 8d 3c 11          	lea    (%rcx,%rdx,1),%rdi
    7531:	48 81 c7 28 02 00 00 	add    $0x228,%rdi
    7538:	eb 21                	jmp    755b <f12+0x25b>
    753a:	40 80 fe 01          	cmp    $0x1,%sil
    753e:	75 2f                	jne    756f <f12+0x26f>
    7540:	48 8d 34 11          	lea    (%rcx,%rdx,1),%rsi
    7544:	8b 4c 11 20          	mov    0x20(%rcx,%rdx,1),%ecx
    7548:	4c 0f af e9          	imul   %rcx,%r13
    754c:	49 c1 ed 20          	shr    $0x20,%r13
    7550:	4a 8d 3c 2e          	lea    (%rsi,%r13,1),%rdi
    7554:	48 81 c7 28 02 00 00 	add    $0x228,%rdi
    755b:	0f b6 0f             	movzbl (%rdi),%ecx
    755e:	84 c9                	test   %cl,%cl
    7560:	74 0d                	je     756f <f12+0x26f>
    7562:	80 f9 fe             	cmp    $0xfe,%cl
    7565:	0f 83 93 00 00 00    	jae    75fe <f12+0x2fe>
    756b:	fe c1                	inc    %cl
    756d:	88 0f                	mov    %cl,(%rdi)
    756f:	48 89 c1             	mov    %rax,%rcx
    7572:	48 2b 0d 37 bc 00 00 	sub    0xbc37(%rip),%rcx        # 131b0 <fwp_gc+0x1030>
    7579:	48 8b 15 58 bc 00 00 	mov    0xbc58(%rip),%rdx        # 131d8 <fwp_gc+0x1058>
    7580:	48 c1 e2 10          	shl    $0x10,%rdx
    7584:	48 39 d1             	cmp    %rdx,%rcx
    7587:	73 60                	jae    75e9 <f12+0x2e9>
    7589:	48 8b 15 68 bc 00 00 	mov    0xbc68(%rip),%rdx        # 131f8 <fwp_gc+0x1078>
    7590:	48 89 ce             	mov    %rcx,%rsi
    7593:	48 c1 ee 10          	shr    $0x10,%rsi
    7597:	48 69 f6 28 12 00 00 	imul   $0x1228,%rsi,%rsi
    759e:	0f b6 3c 32          	movzbl (%rdx,%rsi,1),%edi
    75a2:	48 81 e1 ff ff 00 00 	and    $0xffff,%rcx
    75a9:	75 13                	jne    75be <f12+0x2be>
    75ab:	40 80 ff 02          	cmp    $0x2,%dil
    75af:	75 0d                	jne    75be <f12+0x2be>
    75b1:	4c 8d 34 32          	lea    (%rdx,%rsi,1),%r14
    75b5:	49 81 c6 28 02 00 00 	add    $0x228,%r14
    75bc:	eb 21                	jmp    75df <f12+0x2df>
    75be:	40 80 ff 01          	cmp    $0x1,%dil
    75c2:	75 25                	jne    75e9 <f12+0x2e9>
    75c4:	48 8d 3c 32          	lea    (%rdx,%rsi,1),%rdi
    75c8:	8b 54 32 20          	mov    0x20(%rdx,%rsi,1),%edx
    75cc:	48 0f af ca          	imul   %rdx,%rcx
    75d0:	48 c1 e9 20          	shr    $0x20,%rcx
    75d4:	4c 8d 34 39          	lea    (%rcx,%rdi,1),%r14
    75d8:	49 81 c6 28 02 00 00 	add    $0x228,%r14
    75df:	41 80 3e ff          	cmpb   $0xff,(%r14)
    75e3:	74 09                	je     75ee <f12+0x2ee>
    75e5:	41 c6 06 01          	movb   $0x1,(%r14)
    75e9:	e9 fd fd ff ff       	jmp    73eb <f12+0xeb>
    75ee:	4c 89 f7             	mov    %r14,%rdi
    75f1:	49 89 c7             	mov    %rax,%r15
    75f4:	e8 67 ed ff ff       	call   6360 <fwp_rc_forget_slot>
    75f9:	4c 89 f8             	mov    %r15,%rax
    75fc:	eb e7                	jmp    75e5 <f12+0x2e5>
    75fe:	49 89 c6             	mov    %rax,%r14
    7601:	e8 3a 00 00 00       	call   7640 <fwp_rc_wide_dup>
    7606:	4c 89 f0             	mov    %r14,%rax
    7609:	e9 61 ff ff ff       	jmp    756f <f12+0x26f>
    760e:	e8 1d ed ff ff       	call   6330 <fwp_flush>
    7613:	48 8b 05 c6 a9 00 00 	mov    0xa9c6(%rip),%rax        # 11fe0 <stderr@GLIBC_2.2.5>
    761a:	48 8b 38             	mov    (%rax),%rdi
    761d:	48 8d 35 09 7e 00 00 	lea    0x7e09(%rip),%rsi        # f42d <fwp_segv.msg+0x1ed>
    7624:	48 8d 15 53 7f 00 00 	lea    0x7f53(%rip),%rdx        # f57e <fwp_segv.msg+0x33e>
    762b:	31 c0                	xor    %eax,%eax
    762d:	e8 7e ab ff ff       	call   21b0 <fprintf@plt>
    7632:	bf 65 00 00 00       	mov    $0x65,%edi
    7637:	e8 54 ac ff ff       	call   2290 <exit@plt>
    763c:	0f 1f 40 00          	nopl   0x0(%rax)

0000000000007640 <fwp_rc_wide_dup>:
    7640:	41 56                	push   %r14
    7642:	53                   	push   %rbx
    7643:	50                   	push   %rax
    7644:	48 89 fb             	mov    %rdi,%rbx
    7647:	48 89 f8             	mov    %rdi,%rax
    764a:	48 c1 e8 11          	shr    $0x11,%rax
    764e:	31 d8                	xor    %ebx,%eax
    7650:	89 c1                	mov    %eax,%ecx
    7652:	c1 e9 09             	shr    $0x9,%ecx
    7655:	31 c1                	xor    %eax,%ecx
    7657:	0f b6 c1             	movzbl %cl,%eax
    765a:	48 8d 0d 1f ab 00 00 	lea    0xab1f(%rip),%rcx        # 12180 <fwp_gc>
    7661:	4c 8d 34 c1          	lea    (%rcx,%rax,8),%r14
    7665:	49 81 c6 18 12 00 00 	add    $0x1218,%r14
    766c:	48 8b 84 c1 18 12 00 	mov    0x1218(%rcx,%rax,8),%rax
    7673:	00 
    7674:	48 85 c0             	test   %rax,%rax
    7677:	74 1a                	je     7693 <fwp_rc_wide_dup+0x53>
    7679:	48 39 18             	cmp    %rbx,(%rax)
    767c:	74 22                	je     76a0 <fwp_rc_wide_dup+0x60>
    767e:	66 90                	xchg   %ax,%ax
    7680:	49 89 c6             	mov    %rax,%r14
    7683:	48 8b 40 10          	mov    0x10(%rax),%rax
    7687:	48 85 c0             	test   %rax,%rax
    768a:	74 0e                	je     769a <fwp_rc_wide_dup+0x5a>
    768c:	48 39 18             	cmp    %rbx,(%rax)
    768f:	75 ef                	jne    7680 <fwp_rc_wide_dup+0x40>
    7691:	eb 09                	jmp    769c <fwp_rc_wide_dup+0x5c>
    7693:	80 3b fe             	cmpb   $0xfe,(%rbx)
    7696:	74 16                	je     76ae <fwp_rc_wide_dup+0x6e>
    7698:	eb 6d                	jmp    7707 <fwp_rc_wide_dup+0xc7>
    769a:	31 c0                	xor    %eax,%eax
    769c:	49 83 c6 10          	add    $0x10,%r14
    76a0:	80 3b fe             	cmpb   $0xfe,(%rbx)
    76a3:	75 41                	jne    76e6 <fwp_rc_wide_dup+0xa6>
    76a5:	48 85 c0             	test   %rax,%rax
    76a8:	0f 85 a2 00 00 00    	jne    7750 <fwp_rc_wide_dup+0x110>
    76ae:	bf 18 00 00 00       	mov    $0x18,%edi
    76b3:	e8 38 ab ff ff       	call   21f0 <malloc@plt>
    76b8:	48 85 c0             	test   %rax,%rax
    76bb:	74 69                	je     7726 <fwp_rc_wide_dup+0xe6>
    76bd:	48 89 18             	mov    %rbx,(%rax)
    76c0:	48 c7 40 08 ff 00 00 	movq   $0xff,0x8(%rax)
    76c7:	00 
    76c8:	48 c7 40 10 00 00 00 	movq   $0x0,0x10(%rax)
    76cf:	00 
    76d0:	49 89 06             	mov    %rax,(%r14)
    76d3:	c6 03 ff             	movb   $0xff,(%rbx)
    76d6:	48 8d 05 bb c4 00 00 	lea    0xc4bb(%rip),%rax        # 13b98 <fwp_gc+0x1a18>
    76dd:	48 8b 0d b4 c4 00 00 	mov    0xc4b4(%rip),%rcx        # 13b98 <fwp_gc+0x1a18>
    76e4:	eb 13                	jmp    76f9 <fwp_rc_wide_dup+0xb9>
    76e6:	48 85 c0             	test   %rax,%rax
    76e9:	74 1c                	je     7707 <fwp_rc_wide_dup+0xc7>
    76eb:	48 8b 48 08          	mov    0x8(%rax),%rcx
    76ef:	48 83 f9 ff          	cmp    $0xffffffffffffffff,%rcx
    76f3:	74 7a                	je     776f <fwp_rc_wide_dup+0x12f>
    76f5:	48 83 c0 08          	add    $0x8,%rax
    76f9:	48 ff c1             	inc    %rcx
    76fc:	48 89 08             	mov    %rcx,(%rax)
    76ff:	48 83 c4 08          	add    $0x8,%rsp
    7703:	5b                   	pop    %rbx
    7704:	41 5e                	pop    %r14
    7706:	c3                   	ret
    7707:	e8 24 ec ff ff       	call   6330 <fwp_flush>
    770c:	48 8b 05 cd a8 00 00 	mov    0xa8cd(%rip),%rax        # 11fe0 <stderr@GLIBC_2.2.5>
    7713:	48 8b 38             	mov    (%rax),%rdi
    7716:	48 8d 35 10 7d 00 00 	lea    0x7d10(%rip),%rsi        # f42d <fwp_segv.msg+0x1ed>
    771d:	48 8d 15 18 7d 00 00 	lea    0x7d18(%rip),%rdx        # f43c <fwp_segv.msg+0x1fc>
    7724:	eb 66                	jmp    778c <fwp_rc_wide_dup+0x14c>
    7726:	48 8b 05 b3 a8 00 00 	mov    0xa8b3(%rip),%rax        # 11fe0 <stderr@GLIBC_2.2.5>
    772d:	48 8b 08             	mov    (%rax),%rcx
    7730:	48 8d 3d 02 7e 00 00 	lea    0x7e02(%rip),%rdi        # f539 <fwp_segv.msg+0x2f9>
    7737:	be 13 00 00 00       	mov    $0x13,%esi
    773c:	ba 01 00 00 00       	mov    $0x1,%edx
    7741:	e8 5a ab ff ff       	call   22a0 <fwrite@plt>
    7746:	bf 66 00 00 00       	mov    $0x66,%edi
    774b:	e8 40 ab ff ff       	call   2290 <exit@plt>
    7750:	e8 db eb ff ff       	call   6330 <fwp_flush>
    7755:	48 8b 05 84 a8 00 00 	mov    0xa884(%rip),%rax        # 11fe0 <stderr@GLIBC_2.2.5>
    775c:	48 8b 38             	mov    (%rax),%rdi
    775f:	48 8d 35 c7 7c 00 00 	lea    0x7cc7(%rip),%rsi        # f42d <fwp_segv.msg+0x1ed>
    7766:	48 8d 15 3d 7e 00 00 	lea    0x7e3d(%rip),%rdx        # f5aa <fwp_segv.msg+0x36a>
    776d:	eb 1d                	jmp    778c <fwp_rc_wide_dup+0x14c>
    776f:	e8 bc eb ff ff       	call   6330 <fwp_flush>
    7774:	48 8b 05 65 a8 00 00 	mov    0xa865(%rip),%rax        # 11fe0 <stderr@GLIBC_2.2.5>
    777b:	48 8b 38             	mov    (%rax),%rdi
    777e:	48 8d 35 a8 7c 00 00 	lea    0x7ca8(%rip),%rsi        # f42d <fwp_segv.msg+0x1ed>
    7785:	48 8d 15 43 7e 00 00 	lea    0x7e43(%rip),%rdx        # f5cf <fwp_segv.msg+0x38f>
    778c:	31 c0                	xor    %eax,%eax
    778e:	e8 1d aa ff ff       	call   21b0 <fprintf@plt>
    7793:	bf 65 00 00 00       	mov    $0x65,%edi
    7798:	e8 f3 aa ff ff       	call   2290 <exit@plt>
    779d:	0f 1f 00             	nopl   (%rax)

00000000000077a0 <fwp_show>:
    77a0:	41 57                	push   %r15
    77a2:	41 56                	push   %r14
    77a4:	41 54                	push   %r12
    77a6:	53                   	push   %rbx
    77a7:	48 83 ec 18          	sub    $0x18,%rsp
    77ab:	48 89 f2             	mov    %rsi,%rdx
    77ae:	48 89 fe             	mov    %rdi,%rsi
    77b1:	0f 57 c0             	xorps  %xmm0,%xmm0
    77b4:	0f 29 04 24          	movaps %xmm0,(%rsp)
    77b8:	48 c7 44 24 10 00 00 	movq   $0x0,0x10(%rsp)
    77bf:	00 00 
    77c1:	48 89 e7             	mov    %rsp,%rdi
    77c4:	b9 01 00 00 00       	mov    $0x1,%ecx
    77c9:	e8 e2 00 00 00       	call   78b0 <fwp_write>
    77ce:	4c 8b 24 24          	mov    (%rsp),%r12
    77d2:	48 8b 5c 24 08       	mov    0x8(%rsp),%rbx
    77d7:	48 8d 53 09          	lea    0x9(%rbx),%rdx
    77db:	48 81 fa 00 40 00 00 	cmp    $0x4000,%rdx
    77e2:	77 61                	ja     7845 <fwp_show+0xa5>
    77e4:	48 8d 4b 18          	lea    0x18(%rbx),%rcx
    77e8:	48 c1 e9 04          	shr    $0x4,%rcx
    77ec:	48 8d 05 8d a9 00 00 	lea    0xa98d(%rip),%rax        # 12180 <fwp_gc>
    77f3:	0f b6 b4 01 e8 0b 00 	movzbl 0xbe8(%rcx,%rax,1),%esi
    77fa:	00 
    77fb:	8b 8c b0 48 0b 00 00 	mov    0xb48(%rax,%rsi,4),%ecx
    7802:	48 29 0d 77 a9 00 00 	sub    %rcx,0xa977(%rip)        # 12180 <fwp_gc>
    7809:	78 3a                	js     7845 <fwp_show+0xa5>
    780b:	48 8d 34 76          	lea    (%rsi,%rsi,2),%rsi
    780f:	48 8d 3c f0          	lea    (%rax,%rsi,8),%rdi
    7813:	48 81 c7 c8 03 00 00 	add    $0x3c8,%rdi
    781a:	4c 8b 37             	mov    (%rdi),%r14
    781d:	4d 85 f6             	test   %r14,%r14
    7820:	74 0b                	je     782d <fwp_show+0x8d>
    7822:	49 8b 06             	mov    (%r14),%rax
    7825:	48 f7 d0             	not    %rax
    7828:	48 89 07             	mov    %rax,(%rdi)
    782b:	eb 3a                	jmp    7867 <fwp_show+0xc7>
    782d:	4c 8b b4 f0 d0 03 00 	mov    0x3d0(%rax,%rsi,8),%r14
    7834:	00 
    7835:	48 8b bc f0 d8 03 00 	mov    0x3d8(%rax,%rsi,8),%rdi
    783c:	00 
    783d:	4c 29 f7             	sub    %r14,%rdi
    7840:	48 39 cf             	cmp    %rcx,%rdi
    7843:	73 12                	jae    7857 <fwp_show+0xb7>
    7845:	48 89 d7             	mov    %rdx,%rdi
    7848:	be 01 00 00 00       	mov    $0x1,%esi
    784d:	e8 2e ef ff ff       	call   6780 <fwp_gc_alloc_slow>
    7852:	49 89 c6             	mov    %rax,%r14
    7855:	eb 1a                	jmp    7871 <fwp_show+0xd1>
    7857:	48 8d 04 f0          	lea    (%rax,%rsi,8),%rax
    785b:	48 05 d0 03 00 00    	add    $0x3d0,%rax
    7861:	4c 01 f1             	add    %r14,%rcx
    7864:	48 89 08             	mov    %rcx,(%rax)
    7867:	4c 89 f7             	mov    %r14,%rdi
    786a:	31 f6                	xor    %esi,%esi
    786c:	e8 bf a8 ff ff       	call   2130 <memset@plt>
    7871:	4d 85 e4             	test   %r12,%r12
    7874:	4c 8d 3d b4 7e 00 00 	lea    0x7eb4(%rip),%r15        # f72f <fwp_segv.msg+0x4ef>
    787b:	4d 0f 45 fc          	cmovne %r12,%r15
    787f:	49 89 1e             	mov    %rbx,(%r14)
    7882:	49 8d 7e 08          	lea    0x8(%r14),%rdi
    7886:	4c 89 fe             	mov    %r15,%rsi
    7889:	48 89 da             	mov    %rbx,%rdx
    788c:	e8 4f a9 ff ff       	call   21e0 <memcpy@plt>
    7891:	41 c6 44 1e 08 00    	movb   $0x0,0x8(%r14,%rbx,1)
    7897:	48 8b 3c 24          	mov    (%rsp),%rdi
    789b:	e8 b0 a7 ff ff       	call   2050 <free@plt>
    78a0:	4c 89 f0             	mov    %r14,%rax
    78a3:	48 83 c4 18          	add    $0x18,%rsp
    78a7:	5b                   	pop    %rbx
    78a8:	41 5c                	pop    %r12
    78aa:	41 5e                	pop    %r14
    78ac:	41 5f                	pop    %r15
    78ae:	c3                   	ret
    78af:	90                   	nop

00000000000078b0 <fwp_write>:
    78b0:	55                   	push   %rbp
    78b1:	41 57                	push   %r15
    78b3:	41 56                	push   %r14
    78b5:	41 55                	push   %r13
    78b7:	41 54                	push   %r12
    78b9:	53                   	push   %rbx
    78ba:	48 81 ec 78 02 00 00 	sub    $0x278,%rsp
    78c1:	8b 02                	mov    (%rdx),%eax
    78c3:	48 83 f8 19          	cmp    $0x19,%rax
    78c7:	0f 87 26 12 00 00    	ja     8af3 <fwp_write+0x1243>
    78cd:	49 89 d7             	mov    %rdx,%r15
    78d0:	49 89 f6             	mov    %rsi,%r14
    78d3:	48 89 fd             	mov    %rdi,%rbp
    78d6:	48 8d 15 43 78 00 00 	lea    0x7843(%rip),%rdx        # f120 <_IO_stdin_used+0x120>
    78dd:	48 63 34 82          	movslq (%rdx,%rax,4),%rsi
    78e1:	48 01 d6             	add    %rdx,%rsi
    78e4:	48 89 3c 24          	mov    %rdi,(%rsp)
    78e8:	ff e6                	jmp    *%rsi
    78ea:	48 8d 15 f7 7c 00 00 	lea    0x7cf7(%rip),%rdx        # f5e8 <fwp_segv.msg+0x3a8>
    78f1:	eb 07                	jmp    78fa <fwp_write+0x4a>
    78f3:	48 8d 15 f3 7c 00 00 	lea    0x7cf3(%rip),%rdx        # f5ed <fwp_segv.msg+0x3ad>
    78fa:	4c 8d 7c 24 70       	lea    0x70(%rsp),%r15
    78ff:	be 00 02 00 00       	mov    $0x200,%esi
    7904:	4c 89 ff             	mov    %r15,%rdi
    7907:	4c 89 f1             	mov    %r14,%rcx
    790a:	31 c0                	xor    %eax,%eax
    790c:	e8 ff a7 ff ff       	call   2110 <snprintf@plt>
    7911:	4c 89 ff             	mov    %r15,%rdi
    7914:	e8 c7 a7 ff ff       	call   20e0 <strlen@plt>
    7919:	48 89 ef             	mov    %rbp,%rdi
    791c:	4c 89 fe             	mov    %r15,%rsi
    791f:	e9 c7 11 00 00       	jmp    8aeb <fwp_write+0x123b>
    7924:	83 f8 13             	cmp    $0x13,%eax
    7927:	48 8d 05 f9 7c 00 00 	lea    0x7cf9(%rip),%rax        # f627 <fwp_segv.msg+0x3e7>
    792e:	48 8d 35 f7 7c 00 00 	lea    0x7cf7(%rip),%rsi        # f62c <fwp_segv.msg+0x3ec>
    7935:	48 0f 44 f0          	cmove  %rax,%rsi
    7939:	ba 04 00 00 00       	mov    $0x4,%edx
    793e:	48 89 ef             	mov    %rbp,%rdi
    7941:	e8 4a 13 00 00       	call   8c90 <buf_put>
    7946:	49 83 3e 00          	cmpq   $0x0,(%r14)
    794a:	0f 84 c3 00 00 00    	je     7a13 <fwp_write+0x163>
    7950:	49 8b 57 38          	mov    0x38(%r15),%rdx
    7954:	49 8b 76 08          	mov    0x8(%r14),%rsi
    7958:	48 8b 1c 24          	mov    (%rsp),%rbx
    795c:	48 89 df             	mov    %rbx,%rdi
    795f:	31 c9                	xor    %ecx,%ecx
    7961:	e8 4a ff ff ff       	call   78b0 <fwp_write>
    7966:	41 83 3f 12          	cmpl   $0x12,(%r15)
    796a:	75 26                	jne    7992 <fwp_write+0xe2>
    796c:	48 8d 35 be 7c 00 00 	lea    0x7cbe(%rip),%rsi        # f631 <fwp_segv.msg+0x3f1>
    7973:	ba 02 00 00 00       	mov    $0x2,%edx
    7978:	48 89 df             	mov    %rbx,%rdi
    797b:	e8 10 13 00 00       	call   8c90 <buf_put>
    7980:	49 8b 76 10          	mov    0x10(%r14),%rsi
    7984:	49 8b 57 40          	mov    0x40(%r15),%rdx
    7988:	48 89 df             	mov    %rbx,%rdi
    798b:	31 c9                	xor    %ecx,%ecx
    798d:	e8 1e ff ff ff       	call   78b0 <fwp_write>
    7992:	49 83 3e 02          	cmpq   $0x2,(%r14)
    7996:	72 7b                	jb     7a13 <fwp_write+0x163>
    7998:	49 8d 5e 20          	lea    0x20(%r14),%rbx
    799c:	bd 01 00 00 00       	mov    $0x1,%ebp
    79a1:	4c 8d 25 72 7c 00 00 	lea    0x7c72(%rip),%r12        # f61a <fwp_segv.msg+0x3da>
    79a8:	eb 12                	jmp    79bc <fwp_write+0x10c>
    79aa:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)
    79b0:	48 ff c5             	inc    %rbp
    79b3:	48 83 c3 10          	add    $0x10,%rbx
    79b7:	49 3b 2e             	cmp    (%r14),%rbp
    79ba:	73 57                	jae    7a13 <fwp_write+0x163>
    79bc:	ba 02 00 00 00       	mov    $0x2,%edx
    79c1:	4c 8b 2c 24          	mov    (%rsp),%r13
    79c5:	4c 89 ef             	mov    %r13,%rdi
    79c8:	4c 89 e6             	mov    %r12,%rsi
    79cb:	e8 c0 12 00 00       	call   8c90 <buf_put>
    79d0:	48 8b 73 f8          	mov    -0x8(%rbx),%rsi
    79d4:	49 8b 57 38          	mov    0x38(%r15),%rdx
    79d8:	4c 89 ef             	mov    %r13,%rdi
    79db:	31 c9                	xor    %ecx,%ecx
    79dd:	e8 ce fe ff ff       	call   78b0 <fwp_write>
    79e2:	41 83 3f 12          	cmpl   $0x12,(%r15)
    79e6:	75 c8                	jne    79b0 <fwp_write+0x100>
    79e8:	ba 02 00 00 00       	mov    $0x2,%edx
    79ed:	4c 8b 2c 24          	mov    (%rsp),%r13
    79f1:	4c 89 ef             	mov    %r13,%rdi
    79f4:	48 8d 35 36 7c 00 00 	lea    0x7c36(%rip),%rsi        # f631 <fwp_segv.msg+0x3f1>
    79fb:	e8 90 12 00 00       	call   8c90 <buf_put>
    7a00:	48 8b 33             	mov    (%rbx),%rsi
    7a03:	49 8b 57 40          	mov    0x40(%r15),%rdx
    7a07:	4c 89 ef             	mov    %r13,%rdi
    7a0a:	31 c9                	xor    %ecx,%ecx
    7a0c:	e8 9f fe ff ff       	call   78b0 <fwp_write>
    7a11:	eb 9d                	jmp    79b0 <fwp_write+0x100>
    7a13:	c6 44 24 70 7d       	movb   $0x7d,0x70(%rsp)
    7a18:	48 8d 74 24 70       	lea    0x70(%rsp),%rsi
    7a1d:	ba 01 00 00 00       	mov    $0x1,%edx
    7a22:	48 8b 3c 24          	mov    (%rsp),%rdi
    7a26:	e9 c3 10 00 00       	jmp    8aee <fwp_write+0x123e>
    7a2b:	4d 8b 67 08          	mov    0x8(%r15),%r12
    7a2f:	4d 85 e4             	test   %r12,%r12
    7a32:	0f 84 af 06 00 00    	je     80e7 <fwp_write+0x837>
    7a38:	48 8d 35 f5 7b 00 00 	lea    0x7bf5(%rip),%rsi        # f634 <fwp_segv.msg+0x3f4>
    7a3f:	4c 89 e7             	mov    %r12,%rdi
    7a42:	e8 39 a7 ff ff       	call   2180 <strcmp@plt>
    7a47:	85 c0                	test   %eax,%eax
    7a49:	0f 84 36 0b 00 00    	je     8585 <fwp_write+0xcd5>
    7a4f:	4d 8d 6f 10          	lea    0x10(%r15),%r13
    7a53:	4c 89 e7             	mov    %r12,%rdi
    7a56:	e8 85 a6 ff ff       	call   20e0 <strlen@plt>
    7a5b:	48 89 ef             	mov    %rbp,%rdi
    7a5e:	4c 89 e6             	mov    %r12,%rsi
    7a61:	48 89 c2             	mov    %rax,%rdx
    7a64:	e8 27 12 00 00       	call   8c90 <buf_put>
    7a69:	c6 44 24 70 20       	movb   $0x20,0x70(%rsp)
    7a6e:	48 8d 74 24 70       	lea    0x70(%rsp),%rsi
    7a73:	ba 01 00 00 00       	mov    $0x1,%edx
    7a78:	48 89 ef             	mov    %rbp,%rdi
    7a7b:	e8 10 12 00 00       	call   8c90 <buf_put>
    7a80:	31 db                	xor    %ebx,%ebx
    7a82:	e9 7f 06 00 00       	jmp    8106 <fwp_write+0x856>
    7a87:	49 81 fe ff 0f 00 00 	cmp    $0xfff,%r14
    7a8e:	0f 87 00 05 00 00    	ja     7f94 <fwp_write+0x6e4>
    7a94:	44 89 f0             	mov    %r14d,%eax
    7a97:	e9 fb 04 00 00       	jmp    7f97 <fwp_write+0x6e7>
    7a9c:	66 49 0f 6e ce       	movq   %r14,%xmm1
    7aa1:	66 0f 2e c9          	ucomisd %xmm1,%xmm1
    7aa5:	0f 8a d2 11 00 00    	jp     8c7d <fwp_write+0x13cd>
    7aab:	66 0f 28 05 1d 76 00 	movapd 0x761d(%rip),%xmm0        # f0d0 <_IO_stdin_used+0xd0>
    7ab2:	00 
    7ab3:	66 0f 54 c1          	andpd  %xmm1,%xmm0
    7ab7:	66 0f 2e 05 61 75 00 	ucomisd 0x7561(%rip),%xmm0        # f020 <_IO_stdin_used+0x20>
    7abe:	00 
    7abf:	0f 82 66 08 00 00    	jb     832b <fwp_write+0xa7b>
    7ac5:	66 0f 57 c0          	xorpd  %xmm0,%xmm0
    7ac9:	66 0f 2e c8          	ucomisd %xmm0,%xmm1
    7acd:	e9 55 04 00 00       	jmp    7f27 <fwp_write+0x677>
    7ad2:	c6 44 24 70 3c       	movb   $0x3c,0x70(%rsp)
    7ad7:	48 8d 74 24 70       	lea    0x70(%rsp),%rsi
    7adc:	ba 01 00 00 00       	mov    $0x1,%edx
    7ae1:	48 89 ef             	mov    %rbp,%rdi
    7ae4:	e8 a7 11 00 00       	call   8c90 <buf_put>
    7ae9:	4d 8b 77 08          	mov    0x8(%r15),%r14
    7aed:	e9 82 04 00 00       	jmp    7f74 <fwp_write+0x6c4>
    7af2:	48 8d 35 0a 7b 00 00 	lea    0x7b0a(%rip),%rsi        # f603 <fwp_segv.msg+0x3c3>
    7af9:	ba 08 00 00 00       	mov    $0x8,%edx
    7afe:	48 89 ef             	mov    %rbp,%rdi
    7b01:	e9 5c 0d 00 00       	jmp    8862 <fwp_write+0xfb2>
    7b06:	49 8d 76 08          	lea    0x8(%r14),%rsi
    7b0a:	49 8b 16             	mov    (%r14),%rdx
    7b0d:	85 c9                	test   %ecx,%ecx
    7b0f:	0f 84 13 07 00 00    	je     8228 <fwp_write+0x978>
    7b15:	48 89 ef             	mov    %rbp,%rdi
    7b18:	e9 45 0d 00 00       	jmp    8862 <fwp_write+0xfb2>
    7b1d:	4d 8b 0e             	mov    (%r14),%r9
    7b20:	4d 8b 46 08          	mov    0x8(%r14),%r8
    7b24:	4c 89 c8             	mov    %r9,%rax
    7b27:	4c 09 c0             	or     %r8,%rax
    7b2a:	0f 84 11 07 00 00    	je     8241 <fwp_write+0x991>
    7b30:	31 ff                	xor    %edi,%edi
    7b32:	49 ba cd cc cc cc cc 	movabs $0xcccccccccccccccd,%r10
    7b39:	cc cc cc 
    7b3c:	49 bb cc cc cc cc cc 	movabs $0xcccccccccccccccc,%r11
    7b43:	cc cc cc 
    7b46:	4c 89 c3             	mov    %r8,%rbx
    7b49:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)
    7b50:	4c 89 c1             	mov    %r8,%rcx
    7b53:	4c 0f a4 c9 3f       	shld   $0x3f,%r9,%rcx
    7b58:	48 d1 eb             	shr    $1,%rbx
    7b5b:	48 89 ce             	mov    %rcx,%rsi
    7b5e:	48 01 de             	add    %rbx,%rsi
    7b61:	48 83 d6 00          	adc    $0x0,%rsi
    7b65:	48 89 f0             	mov    %rsi,%rax
    7b68:	49 f7 e2             	mul    %r10
    7b6b:	48 c1 ea 02          	shr    $0x2,%rdx
    7b6f:	48 8d 04 92          	lea    (%rdx,%rdx,4),%rax
    7b73:	48 29 c6             	sub    %rax,%rsi
    7b76:	48 29 f1             	sub    %rsi,%rcx
    7b79:	48 83 db 00          	sbb    $0x0,%rbx
    7b7d:	48 89 ce             	mov    %rcx,%rsi
    7b80:	49 0f af f3          	imul   %r11,%rsi
    7b84:	48 89 c8             	mov    %rcx,%rax
    7b87:	49 f7 e2             	mul    %r10
    7b8a:	48 01 f2             	add    %rsi,%rdx
    7b8d:	49 0f af da          	imul   %r10,%rbx
    7b91:	48 01 d3             	add    %rdx,%rbx
    7b94:	48 89 c1             	mov    %rax,%rcx
    7b97:	48 01 c1             	add    %rax,%rcx
    7b9a:	48 8d 0c 89          	lea    (%rcx,%rcx,4),%rcx
    7b9e:	44 89 ca             	mov    %r9d,%edx
    7ba1:	29 ca                	sub    %ecx,%edx
    7ba3:	80 ca 30             	or     $0x30,%dl
    7ba6:	88 54 3c 20          	mov    %dl,0x20(%rsp,%rdi,1)
    7baa:	48 ff c7             	inc    %rdi
    7bad:	49 83 f9 0a          	cmp    $0xa,%r9
    7bb1:	49 83 d8 00          	sbb    $0x0,%r8
    7bb5:	49 89 c1             	mov    %rax,%r9
    7bb8:	49 89 d8             	mov    %rbx,%r8
    7bbb:	73 93                	jae    7b50 <fwp_write+0x2a0>
    7bbd:	85 ff                	test   %edi,%edi
    7bbf:	0f 8f 86 06 00 00    	jg     824b <fwp_write+0x99b>
    7bc5:	e9 ab 00 00 00       	jmp    7c75 <fwp_write+0x3c5>
    7bca:	4d 8b 06             	mov    (%r14),%r8
    7bcd:	4d 8b 4e 08          	mov    0x8(%r14),%r9
    7bd1:	4d 85 c9             	test   %r9,%r9
    7bd4:	0f 88 93 06 00 00    	js     826d <fwp_write+0x9bd>
    7bda:	4c 89 c0             	mov    %r8,%rax
    7bdd:	4c 09 c8             	or     %r9,%rax
    7be0:	0f 84 bc 09 00 00    	je     85a2 <fwp_write+0xcf2>
    7be6:	31 ff                	xor    %edi,%edi
    7be8:	49 ba cd cc cc cc cc 	movabs $0xcccccccccccccccd,%r10
    7bef:	cc cc cc 
    7bf2:	49 bb cc cc cc cc cc 	movabs $0xcccccccccccccccc,%r11
    7bf9:	cc cc cc 
    7bfc:	4c 89 cb             	mov    %r9,%rbx
    7bff:	90                   	nop
    7c00:	4c 89 c9             	mov    %r9,%rcx
    7c03:	4c 0f a4 c1 3f       	shld   $0x3f,%r8,%rcx
    7c08:	48 d1 eb             	shr    $1,%rbx
    7c0b:	48 89 ce             	mov    %rcx,%rsi
    7c0e:	48 01 de             	add    %rbx,%rsi
    7c11:	48 83 d6 00          	adc    $0x0,%rsi
    7c15:	48 89 f0             	mov    %rsi,%rax
    7c18:	49 f7 e2             	mul    %r10
    7c1b:	48 c1 ea 02          	shr    $0x2,%rdx
    7c1f:	48 8d 04 92          	lea    (%rdx,%rdx,4),%rax
    7c23:	48 29 c6             	sub    %rax,%rsi
    7c26:	48 29 f1             	sub    %rsi,%rcx
    7c29:	48 83 db 00          	sbb    $0x0,%rbx
    7c2d:	48 89 ce             	mov    %rcx,%rsi
    7c30:	49 0f af f3          	imul   %r11,%rsi
    7c34:	48 89 c8             	mov    %rcx,%rax
    7c37:	49 f7 e2             	mul    %r10
    7c3a:	48 01 f2             	add    %rsi,%rdx
    7c3d:	49 0f af da          	imul   %r10,%rbx
    7c41:	48 01 d3             	add    %rdx,%rbx
    7c44:	48 89 c1             	mov    %rax,%rcx
    7c47:	48 01 c1             	add    %rax,%rcx
    7c4a:	48 8d 0c 89          	lea    (%rcx,%rcx,4),%rcx
    7c4e:	44 89 c2             	mov    %r8d,%edx
    7c51:	29 ca                	sub    %ecx,%edx
    7c53:	80 ca 30             	or     $0x30,%dl
    7c56:	88 54 3c 20          	mov    %dl,0x20(%rsp,%rdi,1)
    7c5a:	48 ff c7             	inc    %rdi
    7c5d:	49 83 f8 0a          	cmp    $0xa,%r8
    7c61:	49 83 d9 00          	sbb    $0x0,%r9
    7c65:	49 89 c0             	mov    %rax,%r8
    7c68:	49 89 d9             	mov    %rbx,%r9
    7c6b:	73 93                	jae    7c00 <fwp_write+0x350>
    7c6d:	85 ff                	test   %edi,%edi
    7c6f:	0f 8f 37 09 00 00    	jg     85ac <fwp_write+0xcfc>
    7c75:	31 c0                	xor    %eax,%eax
    7c77:	e9 57 0e 00 00       	jmp    8ad3 <fwp_write+0x1223>
    7c7c:	c6 44 24 70 5b       	movb   $0x5b,0x70(%rsp)
    7c81:	48 8d 74 24 70       	lea    0x70(%rsp),%rsi
    7c86:	ba 01 00 00 00       	mov    $0x1,%edx
    7c8b:	48 89 ef             	mov    %rbp,%rdi
    7c8e:	e8 fd 0f 00 00       	call   8c90 <buf_put>
    7c93:	4d 85 f6             	test   %r14,%r14
    7c96:	0f 84 e6 0c 00 00    	je     8982 <fwp_write+0x10d2>
    7c9c:	49 8b 57 38          	mov    0x38(%r15),%rdx
    7ca0:	49 8b 76 08          	mov    0x8(%r14),%rsi
    7ca4:	48 89 ef             	mov    %rbp,%rdi
    7ca7:	31 c9                	xor    %ecx,%ecx
    7ca9:	e8 02 fc ff ff       	call   78b0 <fwp_write>
    7cae:	49 8b 5e 10          	mov    0x10(%r14),%rbx
    7cb2:	48 85 db             	test   %rbx,%rbx
    7cb5:	0f 84 c7 0c 00 00    	je     8982 <fwp_write+0x10d2>
    7cbb:	4c 8d 35 58 79 00 00 	lea    0x7958(%rip),%r14        # f61a <fwp_segv.msg+0x3da>
    7cc2:	66 66 66 66 66 2e 0f 	data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    7cc9:	1f 84 00 00 00 00 00 
    7cd0:	ba 02 00 00 00       	mov    $0x2,%edx
    7cd5:	48 89 ef             	mov    %rbp,%rdi
    7cd8:	4c 89 f6             	mov    %r14,%rsi
    7cdb:	e8 b0 0f 00 00       	call   8c90 <buf_put>
    7ce0:	48 8b 73 08          	mov    0x8(%rbx),%rsi
    7ce4:	49 8b 57 38          	mov    0x38(%r15),%rdx
    7ce8:	48 89 ef             	mov    %rbp,%rdi
    7ceb:	31 c9                	xor    %ecx,%ecx
    7ced:	e8 be fb ff ff       	call   78b0 <fwp_write>
    7cf2:	48 8b 5b 10          	mov    0x10(%rbx),%rbx
    7cf6:	48 85 db             	test   %rbx,%rbx
    7cf9:	75 d5                	jne    7cd0 <fwp_write+0x420>
    7cfb:	e9 82 0c 00 00       	jmp    8982 <fwp_write+0x10d2>
    7d00:	4d 63 67 48          	movslq 0x48(%r15),%r12
    7d04:	44 89 e3             	mov    %r12d,%ebx
    7d07:	49 8d 54 24 03       	lea    0x3(%r12),%rdx
    7d0c:	48 81 fa 00 40 00 00 	cmp    $0x4000,%rdx
    7d13:	0f 87 57 08 00 00    	ja     8570 <fwp_write+0xcc0>
    7d19:	49 8d 4c 24 12       	lea    0x12(%r12),%rcx
    7d1e:	48 c1 e9 04          	shr    $0x4,%rcx
    7d22:	48 8d 05 57 a4 00 00 	lea    0xa457(%rip),%rax        # 12180 <fwp_gc>
    7d29:	0f b6 b4 01 e8 0b 00 	movzbl 0xbe8(%rcx,%rax,1),%esi
    7d30:	00 
    7d31:	8b 8c b0 48 0b 00 00 	mov    0xb48(%rax,%rsi,4),%ecx
    7d38:	48 29 0d 41 a4 00 00 	sub    %rcx,0xa441(%rip)        # 12180 <fwp_gc>
    7d3f:	0f 88 2b 08 00 00    	js     8570 <fwp_write+0xcc0>
    7d45:	48 8d 34 76          	lea    (%rsi,%rsi,2),%rsi
    7d49:	48 8d 3c f0          	lea    (%rax,%rsi,8),%rdi
    7d4d:	48 81 c7 c8 03 00 00 	add    $0x3c8,%rdi
    7d54:	4c 8b 3f             	mov    (%rdi),%r15
    7d57:	4d 85 ff             	test   %r15,%r15
    7d5a:	0f 84 f4 07 00 00    	je     8554 <fwp_write+0xca4>
    7d60:	49 8b 07             	mov    (%r15),%rax
    7d63:	48 f7 d0             	not    %rax
    7d66:	48 89 07             	mov    %rax,(%rdi)
    7d69:	e9 2d 0a 00 00       	jmp    879b <fwp_write+0xeeb>
    7d6e:	49 83 fe ff          	cmp    $0xffffffffffffffff,%r14
    7d72:	48 8d 05 7c 78 00 00 	lea    0x787c(%rip),%rax        # f5f5 <fwp_segv.msg+0x3b5>
    7d79:	48 8d 0d e2 78 00 00 	lea    0x78e2(%rip),%rcx        # f662 <fwp_segv.msg+0x422>
    7d80:	48 0f 44 c8          	cmove  %rax,%rcx
    7d84:	49 83 fe 01          	cmp    $0x1,%r14
    7d88:	4c 8d 35 63 78 00 00 	lea    0x7863(%rip),%r14        # f5f2 <fwp_segv.msg+0x3b2>
    7d8f:	4c 0f 45 f1          	cmovne %rcx,%r14
    7d93:	4c 89 f7             	mov    %r14,%rdi
    7d96:	e8 45 a3 ff ff       	call   20e0 <strlen@plt>
    7d9b:	48 89 ef             	mov    %rbp,%rdi
    7d9e:	4c 89 f6             	mov    %r14,%rsi
    7da1:	e9 b9 0a 00 00       	jmp    885f <fwp_write+0xfaf>
    7da6:	48 8d 35 73 78 00 00 	lea    0x7873(%rip),%rsi        # f620 <fwp_segv.msg+0x3e0>
    7dad:	ba 06 00 00 00       	mov    $0x6,%edx
    7db2:	48 89 ef             	mov    %rbp,%rdi
    7db5:	e8 d6 0e 00 00       	call   8c90 <buf_put>
    7dba:	49 8b 36             	mov    (%r14),%rsi
    7dbd:	48 8d 04 75 00 00 00 	lea    0x0(,%rsi,2),%rax
    7dc4:	00 
    7dc5:	48 85 c0             	test   %rax,%rax
    7dc8:	0f 84 b4 0b 00 00    	je     8982 <fwp_write+0x10d2>
    7dce:	49 8b 57 38          	mov    0x38(%r15),%rdx
    7dd2:	b8 08 00 00 00       	mov    $0x8,%eax
    7dd7:	48 85 d2             	test   %rdx,%rdx
    7dda:	74 13                	je     7def <fwp_write+0x53f>
    7ddc:	8b 0a                	mov    (%rdx),%ecx
    7dde:	48 83 f9 0a          	cmp    $0xa,%rcx
    7de2:	77 0b                	ja     7def <fwp_write+0x53f>
    7de4:	48 8d 05 cd 74 00 00 	lea    0x74cd(%rip),%rax        # f2b8 <fwp_segv.msg+0x78>
    7deb:	48 8b 04 c8          	mov    (%rax,%rcx,8),%rax
    7def:	4d 8d 6e 08          	lea    0x8(%r14),%r13
    7df3:	4c 89 e9             	mov    %r13,%rcx
    7df6:	48 85 f6             	test   %rsi,%rsi
    7df9:	79 04                	jns    7dff <fwp_write+0x54f>
    7dfb:	49 8b 4e 10          	mov    0x10(%r14),%rcx
    7dff:	48 83 f8 01          	cmp    $0x1,%rax
    7e03:	0f 84 74 0a 00 00    	je     887d <fwp_write+0xfcd>
    7e09:	48 83 f8 08          	cmp    $0x8,%rax
    7e0d:	0f 84 65 0a 00 00    	je     8878 <fwp_write+0xfc8>
    7e13:	48 83 f8 02          	cmp    $0x2,%rax
    7e17:	0f 85 6c 0a 00 00    	jne    8889 <fwp_write+0xfd9>
    7e1d:	83 3a 01             	cmpl   $0x1,(%rdx)
    7e20:	0f b7 01             	movzwl (%rcx),%eax
    7e23:	48 0f bf f0          	movswq %ax,%rsi
    7e27:	e9 65 0a 00 00       	jmp    8891 <fwp_write+0xfe1>
    7e2c:	48 8d 35 e0 77 00 00 	lea    0x77e0(%rip),%rsi        # f613 <fwp_segv.msg+0x3d3>
    7e33:	ba 06 00 00 00       	mov    $0x6,%edx
    7e38:	48 89 ef             	mov    %rbp,%rdi
    7e3b:	e8 50 0e 00 00       	call   8c90 <buf_put>
    7e40:	49 83 3e 00          	cmpq   $0x0,(%r14)
    7e44:	0f 84 a3 00 00 00    	je     7eed <fwp_write+0x63d>
    7e4a:	41 0f b6 4e 08       	movzbl 0x8(%r14),%ecx
    7e4f:	48 8d 15 c7 77 00 00 	lea    0x77c7(%rip),%rdx        # f61d <fwp_segv.msg+0x3dd>
    7e56:	4c 8d 7c 24 70       	lea    0x70(%rsp),%r15
    7e5b:	be 00 02 00 00       	mov    $0x200,%esi
    7e60:	4c 89 ff             	mov    %r15,%rdi
    7e63:	31 c0                	xor    %eax,%eax
    7e65:	e8 a6 a2 ff ff       	call   2110 <snprintf@plt>
    7e6a:	4c 89 ff             	mov    %r15,%rdi
    7e6d:	e8 6e a2 ff ff       	call   20e0 <strlen@plt>
    7e72:	48 89 ef             	mov    %rbp,%rdi
    7e75:	4c 89 fe             	mov    %r15,%rsi
    7e78:	48 89 c2             	mov    %rax,%rdx
    7e7b:	e8 10 0e 00 00       	call   8c90 <buf_put>
    7e80:	49 83 3e 02          	cmpq   $0x2,(%r14)
    7e84:	72 67                	jb     7eed <fwp_write+0x63d>
    7e86:	bb 09 00 00 00       	mov    $0x9,%ebx
    7e8b:	4c 8d 3d 88 77 00 00 	lea    0x7788(%rip),%r15        # f61a <fwp_segv.msg+0x3da>
    7e92:	4c 8d 25 84 77 00 00 	lea    0x7784(%rip),%r12        # f61d <fwp_segv.msg+0x3dd>
    7e99:	4c 8d 6c 24 70       	lea    0x70(%rsp),%r13
    7e9e:	66 90                	xchg   %ax,%ax
    7ea0:	ba 02 00 00 00       	mov    $0x2,%edx
    7ea5:	48 89 ef             	mov    %rbp,%rdi
    7ea8:	4c 89 fe             	mov    %r15,%rsi
    7eab:	e8 e0 0d 00 00       	call   8c90 <buf_put>
    7eb0:	41 0f b6 0c 1e       	movzbl (%r14,%rbx,1),%ecx
    7eb5:	be 00 02 00 00       	mov    $0x200,%esi
    7eba:	4c 89 ef             	mov    %r13,%rdi
    7ebd:	4c 89 e2             	mov    %r12,%rdx
    7ec0:	31 c0                	xor    %eax,%eax
    7ec2:	e8 49 a2 ff ff       	call   2110 <snprintf@plt>
    7ec7:	4c 89 ef             	mov    %r13,%rdi
    7eca:	e8 11 a2 ff ff       	call   20e0 <strlen@plt>
    7ecf:	48 89 ef             	mov    %rbp,%rdi
    7ed2:	4c 89 ee             	mov    %r13,%rsi
    7ed5:	48 89 c2             	mov    %rax,%rdx
    7ed8:	e8 b3 0d 00 00       	call   8c90 <buf_put>
    7edd:	48 8d 43 01          	lea    0x1(%rbx),%rax
    7ee1:	48 83 c3 f9          	add    $0xfffffffffffffff9,%rbx
    7ee5:	49 3b 1e             	cmp    (%r14),%rbx
    7ee8:	48 89 c3             	mov    %rax,%rbx
    7eeb:	72 b3                	jb     7ea0 <fwp_write+0x5f0>
    7eed:	c6 44 24 20 5d       	movb   $0x5d,0x20(%rsp)
    7ef2:	48 8d 74 24 20       	lea    0x20(%rsp),%rsi
    7ef7:	e9 90 0a 00 00       	jmp    898c <fwp_write+0x10dc>
    7efc:	66 41 0f 6e ce       	movd   %r14d,%xmm1
    7f01:	0f 2e c9             	ucomiss %xmm1,%xmm1
    7f04:	0f 8a 73 0d 00 00    	jp     8c7d <fwp_write+0x13cd>
    7f0a:	0f 28 05 cf 71 00 00 	movaps 0x71cf(%rip),%xmm0        # f0e0 <_IO_stdin_used+0xe0>
    7f11:	0f 54 c1             	andps  %xmm1,%xmm0
    7f14:	0f 2e 05 f1 70 00 00 	ucomiss 0x70f1(%rip),%xmm0        # f00c <_IO_stdin_used+0xc>
    7f1b:	0f 82 6e 04 00 00    	jb     838f <fwp_write+0xadf>
    7f21:	0f 57 c0             	xorps  %xmm0,%xmm0
    7f24:	0f 2e c8             	ucomiss %xmm0,%xmm1
    7f27:	48 8d 05 1b 77 00 00 	lea    0x771b(%rip),%rax        # f649 <fwp_segv.msg+0x409>
    7f2e:	48 8d 35 13 77 00 00 	lea    0x7713(%rip),%rsi        # f648 <fwp_segv.msg+0x408>
    7f35:	48 0f 47 f0          	cmova  %rax,%rsi
    7f39:	48 8d 7c 24 70       	lea    0x70(%rsp),%rdi
    7f3e:	e8 3d a1 ff ff       	call   2080 <strcpy@plt>
    7f43:	e9 90 0b 00 00       	jmp    8ad8 <fwp_write+0x1228>
    7f48:	48 8d 35 a9 76 00 00 	lea    0x76a9(%rip),%rsi        # f5f8 <fwp_segv.msg+0x3b8>
    7f4f:	ba 0a 00 00 00       	mov    $0xa,%edx
    7f54:	48 89 ef             	mov    %rbp,%rdi
    7f57:	e9 06 09 00 00       	jmp    8862 <fwp_write+0xfb2>
    7f5c:	48 8d 35 a9 76 00 00 	lea    0x76a9(%rip),%rsi        # f60c <fwp_segv.msg+0x3cc>
    7f63:	ba 06 00 00 00       	mov    $0x6,%edx
    7f68:	48 89 ef             	mov    %rbp,%rdi
    7f6b:	e8 20 0d 00 00       	call   8c90 <buf_put>
    7f70:	49 83 c6 10          	add    $0x10,%r14
    7f74:	4c 89 f7             	mov    %r14,%rdi
    7f77:	e8 64 a1 ff ff       	call   20e0 <strlen@plt>
    7f7c:	48 89 ef             	mov    %rbp,%rdi
    7f7f:	4c 89 f6             	mov    %r14,%rsi
    7f82:	48 89 c2             	mov    %rax,%rdx
    7f85:	e8 06 0d 00 00       	call   8c90 <buf_put>
    7f8a:	c6 44 24 70 3e       	movb   $0x3e,0x70(%rsp)
    7f8f:	e9 f3 09 00 00       	jmp    8987 <fwp_write+0x10d7>
    7f94:	41 8b 06             	mov    (%r14),%eax
    7f97:	49 8b 4f 18          	mov    0x18(%r15),%rcx
    7f9b:	41 89 c5             	mov    %eax,%r13d
    7f9e:	4e 8b 24 e9          	mov    (%rcx,%r13,8),%r12
    7fa2:	4c 89 e7             	mov    %r12,%rdi
    7fa5:	e8 36 a1 ff ff       	call   20e0 <strlen@plt>
    7faa:	48 89 ef             	mov    %rbp,%rdi
    7fad:	4c 89 e6             	mov    %r12,%rsi
    7fb0:	48 89 c2             	mov    %rax,%rdx
    7fb3:	e8 d8 0c 00 00       	call   8c90 <buf_put>
    7fb8:	49 8b 47 28          	mov    0x28(%r15),%rax
    7fbc:	42 83 3c a8 00       	cmpl   $0x0,(%rax,%r13,4)
    7fc1:	0f 8e 2c 0b 00 00    	jle    8af3 <fwp_write+0x1243>
    7fc7:	45 31 e4             	xor    %r12d,%r12d
    7fca:	4c 89 7c 24 10       	mov    %r15,0x10(%rsp)
    7fcf:	4c 89 6c 24 68       	mov    %r13,0x68(%rsp)
    7fd4:	eb 3c                	jmp    8012 <fwp_write+0x762>
    7fd6:	66 2e 0f 1f 84 00 00 	cs nopw 0x0(%rax,%rax,1)
    7fdd:	00 00 00 
    7fe0:	48 8b 2c 24          	mov    (%rsp),%rbp
    7fe4:	48 89 ef             	mov    %rbp,%rdi
    7fe7:	48 89 de             	mov    %rbx,%rsi
    7fea:	4c 89 ea             	mov    %r13,%rdx
    7fed:	31 c9                	xor    %ecx,%ecx
    7fef:	e8 bc f8 ff ff       	call   78b0 <fwp_write>
    7ff4:	49 ff c4             	inc    %r12
    7ff7:	4c 8b 7c 24 10       	mov    0x10(%rsp),%r15
    7ffc:	49 8b 47 28          	mov    0x28(%r15),%rax
    8000:	4c 8b 6c 24 68       	mov    0x68(%rsp),%r13
    8005:	4a 63 04 a8          	movslq (%rax,%r13,4),%rax
    8009:	49 39 c4             	cmp    %rax,%r12
    800c:	0f 8d e1 0a 00 00    	jge    8af3 <fwp_write+0x1243>
    8012:	4b 8b 5c e6 08       	mov    0x8(%r14,%r12,8),%rbx
    8017:	49 8b 47 30          	mov    0x30(%r15),%rax
    801b:	4a 8b 04 e8          	mov    (%rax,%r13,8),%rax
    801f:	4e 8b 2c e0          	mov    (%rax,%r12,8),%r13
    8023:	c6 44 24 70 20       	movb   $0x20,0x70(%rsp)
    8028:	ba 01 00 00 00       	mov    $0x1,%edx
    802d:	48 89 ef             	mov    %rbp,%rdi
    8030:	48 8d 74 24 70       	lea    0x70(%rsp),%rsi
    8035:	e8 56 0c 00 00       	call   8c90 <buf_put>
    803a:	41 8b 45 00          	mov    0x0(%r13),%eax
    803e:	48 83 f8 10          	cmp    $0x10,%rax
    8042:	77 9c                	ja     7fe0 <fwp_write+0x730>
    8044:	48 8d 0d 3d 71 00 00 	lea    0x713d(%rip),%rcx        # f188 <_IO_stdin_used+0x188>
    804b:	48 63 04 81          	movslq (%rcx,%rax,4),%rax
    804f:	48 01 c8             	add    %rcx,%rax
    8052:	ff e0                	jmp    *%rax
    8054:	48 89 d9             	mov    %rbx,%rcx
    8057:	48 c1 e9 3f          	shr    $0x3f,%rcx
    805b:	85 c9                	test   %ecx,%ecx
    805d:	74 81                	je     7fe0 <fwp_write+0x730>
    805f:	c6 44 24 70 28       	movb   $0x28,0x70(%rsp)
    8064:	ba 01 00 00 00       	mov    $0x1,%edx
    8069:	48 8b 2c 24          	mov    (%rsp),%rbp
    806d:	48 89 ef             	mov    %rbp,%rdi
    8070:	4c 8d 7c 24 70       	lea    0x70(%rsp),%r15
    8075:	4c 89 fe             	mov    %r15,%rsi
    8078:	e8 13 0c 00 00       	call   8c90 <buf_put>
    807d:	48 89 ef             	mov    %rbp,%rdi
    8080:	48 89 de             	mov    %rbx,%rsi
    8083:	4c 89 ea             	mov    %r13,%rdx
    8086:	31 c9                	xor    %ecx,%ecx
    8088:	e8 23 f8 ff ff       	call   78b0 <fwp_write>
    808d:	c6 44 24 70 29       	movb   $0x29,0x70(%rsp)
    8092:	ba 01 00 00 00       	mov    $0x1,%edx
    8097:	48 89 ef             	mov    %rbp,%rdi
    809a:	4c 89 fe             	mov    %r15,%rsi
    809d:	e8 ee 0b 00 00       	call   8c90 <buf_put>
    80a2:	e9 4d ff ff ff       	jmp    7ff4 <fwp_write+0x744>
    80a7:	31 c9                	xor    %ecx,%ecx
    80a9:	48 81 fb 00 10 00 00 	cmp    $0x1000,%rbx
    80b0:	0f 93 c1             	setae  %cl
    80b3:	eb a6                	jmp    805b <fwp_write+0x7ab>
    80b5:	48 8b 4b 08          	mov    0x8(%rbx),%rcx
    80b9:	eb 9c                	jmp    8057 <fwp_write+0x7a7>
    80bb:	89 d9                	mov    %ebx,%ecx
    80bd:	c1 e9 1f             	shr    $0x1f,%ecx
    80c0:	eb 99                	jmp    805b <fwp_write+0x7ab>
    80c2:	49 8b 7d 08          	mov    0x8(%r13),%rdi
    80c6:	48 85 ff             	test   %rdi,%rdi
    80c9:	0f 84 11 ff ff ff    	je     7fe0 <fwp_write+0x730>
    80cf:	48 8d 35 5e 75 00 00 	lea    0x755e(%rip),%rsi        # f634 <fwp_segv.msg+0x3f4>
    80d6:	e8 a5 a0 ff ff       	call   2180 <strcmp@plt>
    80db:	31 c9                	xor    %ecx,%ecx
    80dd:	85 c0                	test   %eax,%eax
    80df:	0f 95 c1             	setne  %cl
    80e2:	e9 74 ff ff ff       	jmp    805b <fwp_write+0x7ab>
    80e7:	41 83 7f 10 00       	cmpl   $0x0,0x10(%r15)
    80ec:	0f 84 a7 08 00 00    	je     8999 <fwp_write+0x10e9>
    80f2:	4d 8d 6f 10          	lea    0x10(%r15),%r13
    80f6:	4d 85 e4             	test   %r12,%r12
    80f9:	0f 94 c0             	sete   %al
    80fc:	41 83 7f 48 00       	cmpl   $0x0,0x48(%r15)
    8101:	0f 95 c3             	setne  %bl
    8104:	20 c3                	and    %al,%bl
    8106:	84 db                	test   %bl,%bl
    8108:	b8 28 00 00 00       	mov    $0x28,%eax
    810d:	b9 7b 00 00 00       	mov    $0x7b,%ecx
    8112:	0f 45 c8             	cmovne %eax,%ecx
    8115:	88 4c 24 70          	mov    %cl,0x70(%rsp)
    8119:	48 8d 74 24 70       	lea    0x70(%rsp),%rsi
    811e:	ba 01 00 00 00       	mov    $0x1,%edx
    8123:	48 89 ef             	mov    %rbp,%rdi
    8126:	e8 65 0b 00 00       	call   8c90 <buf_put>
    812b:	41 83 7d 00 00       	cmpl   $0x0,0x0(%r13)
    8130:	0f 8e da 00 00 00    	jle    8210 <fwp_write+0x960>
    8136:	84 db                	test   %bl,%bl
    8138:	75 31                	jne    816b <fwp_write+0x8bb>
    813a:	49 8b 47 18          	mov    0x18(%r15),%rax
    813e:	4c 8b 20             	mov    (%rax),%r12
    8141:	4c 89 e7             	mov    %r12,%rdi
    8144:	e8 97 9f ff ff       	call   20e0 <strlen@plt>
    8149:	48 89 ef             	mov    %rbp,%rdi
    814c:	4c 89 e6             	mov    %r12,%rsi
    814f:	48 89 c2             	mov    %rax,%rdx
    8152:	e8 39 0b 00 00       	call   8c90 <buf_put>
    8157:	48 8d 35 e2 74 00 00 	lea    0x74e2(%rip),%rsi        # f640 <fwp_segv.msg+0x400>
    815e:	ba 03 00 00 00       	mov    $0x3,%edx
    8163:	48 89 ef             	mov    %rbp,%rdi
    8166:	e8 25 0b 00 00       	call   8c90 <buf_put>
    816b:	49 8b 76 08          	mov    0x8(%r14),%rsi
    816f:	49 8b 47 20          	mov    0x20(%r15),%rax
    8173:	48 8b 10             	mov    (%rax),%rdx
    8176:	48 89 ef             	mov    %rbp,%rdi
    8179:	31 c9                	xor    %ecx,%ecx
    817b:	e8 30 f7 ff ff       	call   78b0 <fwp_write>
    8180:	41 83 7f 10 02       	cmpl   $0x2,0x10(%r15)
    8185:	0f 8c 85 00 00 00    	jl     8210 <fwp_write+0x960>
    818b:	41 bd 01 00 00 00    	mov    $0x1,%r13d
    8191:	4c 8d 25 82 74 00 00 	lea    0x7482(%rip),%r12        # f61a <fwp_segv.msg+0x3da>
    8198:	eb 29                	jmp    81c3 <fwp_write+0x913>
    819a:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)
    81a0:	4b 8b 74 ee 08       	mov    0x8(%r14,%r13,8),%rsi
    81a5:	49 8b 47 20          	mov    0x20(%r15),%rax
    81a9:	4a 8b 14 e8          	mov    (%rax,%r13,8),%rdx
    81ad:	48 89 ef             	mov    %rbp,%rdi
    81b0:	31 c9                	xor    %ecx,%ecx
    81b2:	e8 f9 f6 ff ff       	call   78b0 <fwp_write>
    81b7:	49 ff c5             	inc    %r13
    81ba:	49 63 47 10          	movslq 0x10(%r15),%rax
    81be:	49 39 c5             	cmp    %rax,%r13
    81c1:	7d 4d                	jge    8210 <fwp_write+0x960>
    81c3:	ba 02 00 00 00       	mov    $0x2,%edx
    81c8:	48 89 ef             	mov    %rbp,%rdi
    81cb:	4c 89 e6             	mov    %r12,%rsi
    81ce:	e8 bd 0a 00 00       	call   8c90 <buf_put>
    81d3:	84 db                	test   %bl,%bl
    81d5:	75 c9                	jne    81a0 <fwp_write+0x8f0>
    81d7:	49 8b 47 18          	mov    0x18(%r15),%rax
    81db:	4a 8b 2c e8          	mov    (%rax,%r13,8),%rbp
    81df:	48 89 ef             	mov    %rbp,%rdi
    81e2:	e8 f9 9e ff ff       	call   20e0 <strlen@plt>
    81e7:	48 8b 3c 24          	mov    (%rsp),%rdi
    81eb:	48 89 ee             	mov    %rbp,%rsi
    81ee:	48 8b 2c 24          	mov    (%rsp),%rbp
    81f2:	48 89 c2             	mov    %rax,%rdx
    81f5:	e8 96 0a 00 00       	call   8c90 <buf_put>
    81fa:	ba 03 00 00 00       	mov    $0x3,%edx
    81ff:	48 89 ef             	mov    %rbp,%rdi
    8202:	48 8d 35 37 74 00 00 	lea    0x7437(%rip),%rsi        # f640 <fwp_segv.msg+0x400>
    8209:	e8 82 0a 00 00       	call   8c90 <buf_put>
    820e:	eb 90                	jmp    81a0 <fwp_write+0x8f0>
    8210:	84 db                	test   %bl,%bl
    8212:	b8 29 00 00 00       	mov    $0x29,%eax
    8217:	b9 7d 00 00 00       	mov    $0x7d,%ecx
    821c:	0f 45 c8             	cmovne %eax,%ecx
    821f:	88 4c 24 70          	mov    %cl,0x70(%rsp)
    8223:	e9 5f 07 00 00       	jmp    8987 <fwp_write+0x10d7>
    8228:	48 89 ef             	mov    %rbp,%rdi
    822b:	48 81 c4 78 02 00 00 	add    $0x278,%rsp
    8232:	5b                   	pop    %rbx
    8233:	41 5c                	pop    %r12
    8235:	41 5d                	pop    %r13
    8237:	41 5e                	pop    %r14
    8239:	41 5f                	pop    %r15
    823b:	5d                   	pop    %rbp
    823c:	e9 3f 0b 00 00       	jmp    8d80 <fwp_escape>
    8241:	c6 44 24 20 30       	movb   $0x30,0x20(%rsp)
    8246:	bf 01 00 00 00       	mov    $0x1,%edi
    824b:	89 f8                	mov    %edi,%eax
    824d:	48 83 f8 08          	cmp    $0x8,%rax
    8251:	73 0a                	jae    825d <fwp_write+0x9ad>
    8253:	31 c9                	xor    %ecx,%ecx
    8255:	48 89 c2             	mov    %rax,%rdx
    8258:	e9 7a 04 00 00       	jmp    86d7 <fwp_write+0xe27>
    825d:	83 f8 20             	cmp    $0x20,%eax
    8260:	0f 83 68 03 00 00    	jae    85ce <fwp_write+0xd1e>
    8266:	31 c9                	xor    %ecx,%ecx
    8268:	e9 10 04 00 00       	jmp    867d <fwp_write+0xdcd>
    826d:	31 ff                	xor    %edi,%edi
    826f:	49 f7 d8             	neg    %r8
    8272:	41 ba 00 00 00 00    	mov    $0x0,%r10d
    8278:	4d 19 ca             	sbb    %r9,%r10
    827b:	c6 44 24 70 2d       	movb   $0x2d,0x70(%rsp)
    8280:	49 b9 cd cc cc cc cc 	movabs $0xcccccccccccccccd,%r9
    8287:	cc cc cc 
    828a:	49 bb cc cc cc cc cc 	movabs $0xcccccccccccccccc,%r11
    8291:	cc cc cc 
    8294:	4c 89 d3             	mov    %r10,%rbx
    8297:	66 0f 1f 84 00 00 00 	nopw   0x0(%rax,%rax,1)
    829e:	00 00 
    82a0:	4c 89 d1             	mov    %r10,%rcx
    82a3:	4c 0f a4 c1 3f       	shld   $0x3f,%r8,%rcx
    82a8:	48 d1 eb             	shr    $1,%rbx
    82ab:	48 89 ce             	mov    %rcx,%rsi
    82ae:	48 01 de             	add    %rbx,%rsi
    82b1:	48 83 d6 00          	adc    $0x0,%rsi
    82b5:	48 89 f0             	mov    %rsi,%rax
    82b8:	49 f7 e1             	mul    %r9
    82bb:	48 c1 ea 02          	shr    $0x2,%rdx
    82bf:	48 8d 04 92          	lea    (%rdx,%rdx,4),%rax
    82c3:	48 29 c6             	sub    %rax,%rsi
    82c6:	48 29 f1             	sub    %rsi,%rcx
    82c9:	48 83 db 00          	sbb    $0x0,%rbx
    82cd:	48 89 ce             	mov    %rcx,%rsi
    82d0:	49 0f af f3          	imul   %r11,%rsi
    82d4:	48 89 c8             	mov    %rcx,%rax
    82d7:	49 f7 e1             	mul    %r9
    82da:	48 01 f2             	add    %rsi,%rdx
    82dd:	49 0f af d9          	imul   %r9,%rbx
    82e1:	48 01 d3             	add    %rdx,%rbx
    82e4:	48 89 c1             	mov    %rax,%rcx
    82e7:	48 01 c1             	add    %rax,%rcx
    82ea:	48 8d 0c 89          	lea    (%rcx,%rcx,4),%rcx
    82ee:	44 89 c2             	mov    %r8d,%edx
    82f1:	29 ca                	sub    %ecx,%edx
    82f3:	80 ca 30             	or     $0x30,%dl
    82f6:	88 54 3c 20          	mov    %dl,0x20(%rsp,%rdi,1)
    82fa:	48 ff c7             	inc    %rdi
    82fd:	49 83 f8 0a          	cmp    $0xa,%r8
    8301:	49 83 da 00          	sbb    $0x0,%r10
    8305:	49 89 c0             	mov    %rax,%r8
    8308:	49 89 da             	mov    %rbx,%r10
    830b:	73 93                	jae    82a0 <fwp_write+0x9f0>
    830d:	85 ff                	test   %edi,%edi
    830f:	0f 8e 98 06 00 00    	jle    89ad <fwp_write+0x10fd>
    8315:	89 f8                	mov    %edi,%eax
    8317:	48 83 f8 08          	cmp    $0x8,%rax
    831b:	0f 83 e4 07 00 00    	jae    8b05 <fwp_write+0x1255>
    8321:	31 c9                	xor    %ecx,%ecx
    8323:	48 89 c2             	mov    %rax,%rdx
    8326:	e9 fc 08 00 00       	jmp    8c27 <fwp_write+0x1377>
    832b:	bd 01 00 00 00       	mov    $0x1,%ebp
    8330:	4c 8d 74 24 70       	lea    0x70(%rsp),%r14
    8335:	0f 29 4c 24 10       	movaps %xmm1,0x10(%rsp)
    833a:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)
    8340:	4c 89 f7             	mov    %r14,%rdi
    8343:	66 0f 28 c1          	movapd %xmm1,%xmm0
    8347:	89 ee                	mov    %ebp,%esi
    8349:	e8 a2 16 00 00       	call   99f0 <fwp_format_g>
    834e:	4c 89 f7             	mov    %r14,%rdi
    8351:	31 f6                	xor    %esi,%esi
    8353:	e8 48 9d ff ff       	call   20a0 <strtod@plt>
    8358:	66 0f 28 4c 24 10    	movapd 0x10(%rsp),%xmm1
    835e:	66 0f 2e c1          	ucomisd %xmm1,%xmm0
    8362:	75 06                	jne    836a <fwp_write+0xaba>
    8364:	0f 8b 9e 03 00 00    	jnp    8708 <fwp_write+0xe58>
    836a:	ff c5                	inc    %ebp
    836c:	83 fd 12             	cmp    $0x12,%ebp
    836f:	75 cf                	jne    8340 <fwp_write+0xa90>
    8371:	4c 8d 74 24 70       	lea    0x70(%rsp),%r14
    8376:	4c 89 f7             	mov    %r14,%rdi
    8379:	66 0f 28 c1          	movapd %xmm1,%xmm0
    837d:	be 11 00 00 00       	mov    $0x11,%esi
    8382:	e8 69 16 00 00       	call   99f0 <fwp_format_g>
    8387:	4c 89 f7             	mov    %r14,%rdi
    838a:	e9 7e 03 00 00       	jmp    870d <fwp_write+0xe5d>
    838f:	0f 57 c0             	xorps  %xmm0,%xmm0
    8392:	f3 0f 5a c1          	cvtss2sd %xmm1,%xmm0
    8396:	4c 8d 74 24 70       	lea    0x70(%rsp),%r14
    839b:	4c 89 f7             	mov    %r14,%rdi
    839e:	f2 0f 11 44 24 10    	movsd  %xmm0,0x10(%rsp)
    83a4:	be 01 00 00 00       	mov    $0x1,%esi
    83a9:	0f 29 0c 24          	movaps %xmm1,(%rsp)
    83ad:	e8 3e 16 00 00       	call   99f0 <fwp_format_g>
    83b2:	4c 89 f7             	mov    %r14,%rdi
    83b5:	31 f6                	xor    %esi,%esi
    83b7:	e8 64 9d ff ff       	call   2120 <strtof@plt>
    83bc:	0f 2e 04 24          	ucomiss (%rsp),%xmm0
    83c0:	75 06                	jne    83c8 <fwp_write+0xb18>
    83c2:	0f 8b 6f 01 00 00    	jnp    8537 <fwp_write+0xc87>
    83c8:	4c 8d 74 24 70       	lea    0x70(%rsp),%r14
    83cd:	4c 89 f7             	mov    %r14,%rdi
    83d0:	f2 0f 10 44 24 10    	movsd  0x10(%rsp),%xmm0
    83d6:	be 02 00 00 00       	mov    $0x2,%esi
    83db:	e8 10 16 00 00       	call   99f0 <fwp_format_g>
    83e0:	4c 89 f7             	mov    %r14,%rdi
    83e3:	31 f6                	xor    %esi,%esi
    83e5:	e8 36 9d ff ff       	call   2120 <strtof@plt>
    83ea:	0f 2e 04 24          	ucomiss (%rsp),%xmm0
    83ee:	75 06                	jne    83f6 <fwp_write+0xb46>
    83f0:	0f 8b 41 01 00 00    	jnp    8537 <fwp_write+0xc87>
    83f6:	4c 8d 74 24 70       	lea    0x70(%rsp),%r14
    83fb:	4c 89 f7             	mov    %r14,%rdi
    83fe:	f2 0f 10 44 24 10    	movsd  0x10(%rsp),%xmm0
    8404:	be 03 00 00 00       	mov    $0x3,%esi
    8409:	e8 e2 15 00 00       	call   99f0 <fwp_format_g>
    840e:	4c 89 f7             	mov    %r14,%rdi
    8411:	31 f6                	xor    %esi,%esi
    8413:	e8 08 9d ff ff       	call   2120 <strtof@plt>
    8418:	0f 2e 04 24          	ucomiss (%rsp),%xmm0
    841c:	75 06                	jne    8424 <fwp_write+0xb74>
    841e:	0f 8b 13 01 00 00    	jnp    8537 <fwp_write+0xc87>
    8424:	4c 8d 74 24 70       	lea    0x70(%rsp),%r14
    8429:	4c 89 f7             	mov    %r14,%rdi
    842c:	f2 0f 10 44 24 10    	movsd  0x10(%rsp),%xmm0
    8432:	be 04 00 00 00       	mov    $0x4,%esi
    8437:	e8 b4 15 00 00       	call   99f0 <fwp_format_g>
    843c:	4c 89 f7             	mov    %r14,%rdi
    843f:	31 f6                	xor    %esi,%esi
    8441:	e8 da 9c ff ff       	call   2120 <strtof@plt>
    8446:	0f 2e 04 24          	ucomiss (%rsp),%xmm0
    844a:	75 06                	jne    8452 <fwp_write+0xba2>
    844c:	0f 8b e5 00 00 00    	jnp    8537 <fwp_write+0xc87>
    8452:	4c 8d 74 24 70       	lea    0x70(%rsp),%r14
    8457:	4c 89 f7             	mov    %r14,%rdi
    845a:	f2 0f 10 44 24 10    	movsd  0x10(%rsp),%xmm0
    8460:	be 05 00 00 00       	mov    $0x5,%esi
    8465:	e8 86 15 00 00       	call   99f0 <fwp_format_g>
    846a:	4c 89 f7             	mov    %r14,%rdi
    846d:	31 f6                	xor    %esi,%esi
    846f:	e8 ac 9c ff ff       	call   2120 <strtof@plt>
    8474:	0f 2e 04 24          	ucomiss (%rsp),%xmm0
    8478:	75 06                	jne    8480 <fwp_write+0xbd0>
    847a:	0f 8b b7 00 00 00    	jnp    8537 <fwp_write+0xc87>
    8480:	4c 8d 74 24 70       	lea    0x70(%rsp),%r14
    8485:	4c 89 f7             	mov    %r14,%rdi
    8488:	f2 0f 10 44 24 10    	movsd  0x10(%rsp),%xmm0
    848e:	be 06 00 00 00       	mov    $0x6,%esi
    8493:	e8 58 15 00 00       	call   99f0 <fwp_format_g>
    8498:	4c 89 f7             	mov    %r14,%rdi
    849b:	31 f6                	xor    %esi,%esi
    849d:	e8 7e 9c ff ff       	call   2120 <strtof@plt>
    84a2:	0f 2e 04 24          	ucomiss (%rsp),%xmm0
    84a6:	75 06                	jne    84ae <fwp_write+0xbfe>
    84a8:	0f 8b 89 00 00 00    	jnp    8537 <fwp_write+0xc87>
    84ae:	4c 8d 74 24 70       	lea    0x70(%rsp),%r14
    84b3:	4c 89 f7             	mov    %r14,%rdi
    84b6:	f2 0f 10 44 24 10    	movsd  0x10(%rsp),%xmm0
    84bc:	be 07 00 00 00       	mov    $0x7,%esi
    84c1:	e8 2a 15 00 00       	call   99f0 <fwp_format_g>
    84c6:	4c 89 f7             	mov    %r14,%rdi
    84c9:	31 f6                	xor    %esi,%esi
    84cb:	e8 50 9c ff ff       	call   2120 <strtof@plt>
    84d0:	0f 2e 04 24          	ucomiss (%rsp),%xmm0
    84d4:	75 02                	jne    84d8 <fwp_write+0xc28>
    84d6:	7b 5f                	jnp    8537 <fwp_write+0xc87>
    84d8:	4c 8d 74 24 70       	lea    0x70(%rsp),%r14
    84dd:	4c 89 f7             	mov    %r14,%rdi
    84e0:	f2 0f 10 44 24 10    	movsd  0x10(%rsp),%xmm0
    84e6:	be 08 00 00 00       	mov    $0x8,%esi
    84eb:	e8 00 15 00 00       	call   99f0 <fwp_format_g>
    84f0:	4c 89 f7             	mov    %r14,%rdi
    84f3:	31 f6                	xor    %esi,%esi
    84f5:	e8 26 9c ff ff       	call   2120 <strtof@plt>
    84fa:	0f 28 0c 24          	movaps (%rsp),%xmm1
    84fe:	0f 2e c1             	ucomiss %xmm1,%xmm0
    8501:	75 02                	jne    8505 <fwp_write+0xc55>
    8503:	7b 32                	jnp    8537 <fwp_write+0xc87>
    8505:	4c 8d 74 24 70       	lea    0x70(%rsp),%r14
    850a:	4c 89 f7             	mov    %r14,%rdi
    850d:	f2 0f 10 44 24 10    	movsd  0x10(%rsp),%xmm0
    8513:	be 09 00 00 00       	mov    $0x9,%esi
    8518:	e8 d3 14 00 00       	call   99f0 <fwp_format_g>
    851d:	4c 89 f7             	mov    %r14,%rdi
    8520:	31 f6                	xor    %esi,%esi
    8522:	e8 f9 9b ff ff       	call   2120 <strtof@plt>
    8527:	0f 2e 04 24          	ucomiss (%rsp),%xmm0
    852b:	0f 85 2c 07 00 00    	jne    8c5d <fwp_write+0x13ad>
    8531:	0f 8a 26 07 00 00    	jp     8c5d <fwp_write+0x13ad>
    8537:	48 8d 7c 24 70       	lea    0x70(%rsp),%rdi
    853c:	be 2e 00 00 00       	mov    $0x2e,%esi
    8541:	e8 ba 9b ff ff       	call   2100 <strchr@plt>
    8546:	48 85 c0             	test   %rax,%rax
    8549:	0f 85 89 05 00 00    	jne    8ad8 <fwp_write+0x1228>
    854f:	e9 d0 01 00 00       	jmp    8724 <fwp_write+0xe74>
    8554:	4c 8b bc f0 d0 03 00 	mov    0x3d0(%rax,%rsi,8),%r15
    855b:	00 
    855c:	48 8b bc f0 d8 03 00 	mov    0x3d8(%rax,%rsi,8),%rdi
    8563:	00 
    8564:	4c 29 ff             	sub    %r15,%rdi
    8567:	48 39 cf             	cmp    %rcx,%rdi
    856a:	0f 83 1b 02 00 00    	jae    878b <fwp_write+0xedb>
    8570:	48 89 d7             	mov    %rdx,%rdi
    8573:	be 01 00 00 00       	mov    $0x1,%esi
    8578:	e8 03 e2 ff ff       	call   6780 <fwp_gc_alloc_slow>
    857d:	49 89 c7             	mov    %rax,%r15
    8580:	e9 20 02 00 00       	jmp    87a5 <fwp_write+0xef5>
    8585:	49 8b 76 08          	mov    0x8(%r14),%rsi
    8589:	48 89 f2             	mov    %rsi,%rdx
    858c:	48 c1 fa 3f          	sar    $0x3f,%rdx
    8590:	4c 8d 74 24 70       	lea    0x70(%rsp),%r14
    8595:	4c 89 f7             	mov    %r14,%rdi
    8598:	e8 23 09 00 00       	call   8ec0 <fwp_fmt_duration>
    859d:	e9 3b 05 00 00       	jmp    8add <fwp_write+0x122d>
    85a2:	c6 44 24 20 30       	movb   $0x30,0x20(%rsp)
    85a7:	bf 01 00 00 00       	mov    $0x1,%edi
    85ac:	89 f8                	mov    %edi,%eax
    85ae:	48 83 f8 08          	cmp    $0x8,%rax
    85b2:	73 0a                	jae    85be <fwp_write+0xd0e>
    85b4:	31 c9                	xor    %ecx,%ecx
    85b6:	48 89 c2             	mov    %rax,%rdx
    85b9:	e9 f2 04 00 00       	jmp    8ab0 <fwp_write+0x1200>
    85be:	83 f8 20             	cmp    $0x20,%eax
    85c1:	0f 83 f2 03 00 00    	jae    89b9 <fwp_write+0x1109>
    85c7:	31 c9                	xor    %ecx,%ecx
    85c9:	e9 92 04 00 00       	jmp    8a60 <fwp_write+0x11b0>
    85ce:	89 fa                	mov    %edi,%edx
    85d0:	83 e2 1f             	and    $0x1f,%edx
    85d3:	48 89 c1             	mov    %rax,%rcx
    85d6:	48 29 d1             	sub    %rdx,%rcx
    85d9:	48 8d b4 24 80 00 00 	lea    0x80(%rsp),%rsi
    85e0:	00 
    85e1:	66 0f ef c0          	pxor   %xmm0,%xmm0
    85e5:	49 89 c0             	mov    %rax,%r8
    85e8:	0f 1f 84 00 00 00 00 	nopl   0x0(%rax,%rax,1)
    85ef:	00 
    85f0:	f3 42 0f 6f 0c 04    	movdqu (%rsp,%r8,1),%xmm1
    85f6:	f3 42 0f 6f 54 04 10 	movdqu 0x10(%rsp,%r8,1),%xmm2
    85fd:	66 0f 6f da          	movdqa %xmm2,%xmm3
    8601:	66 0f 60 d8          	punpcklbw %xmm0,%xmm3
    8605:	66 0f 70 db 4e       	pshufd $0x4e,%xmm3,%xmm3
    860a:	f2 0f 70 db 1b       	pshuflw $0x1b,%xmm3,%xmm3
    860f:	f3 0f 70 db 1b       	pshufhw $0x1b,%xmm3,%xmm3
    8614:	66 0f 68 d0          	punpckhbw %xmm0,%xmm2
    8618:	66 0f 70 d2 4e       	pshufd $0x4e,%xmm2,%xmm2
    861d:	f2 0f 70 d2 1b       	pshuflw $0x1b,%xmm2,%xmm2
    8622:	f3 0f 70 d2 1b       	pshufhw $0x1b,%xmm2,%xmm2
    8627:	66 0f 67 d3          	packuswb %xmm3,%xmm2
    862b:	66 0f 6f d9          	movdqa %xmm1,%xmm3
    862f:	66 0f 60 d8          	punpcklbw %xmm0,%xmm3
    8633:	66 0f 70 db 4e       	pshufd $0x4e,%xmm3,%xmm3
    8638:	f2 0f 70 db 1b       	pshuflw $0x1b,%xmm3,%xmm3
    863d:	f3 0f 70 db 1b       	pshufhw $0x1b,%xmm3,%xmm3
    8642:	66 0f 68 c8          	punpckhbw %xmm0,%xmm1
    8646:	66 0f 70 c9 4e       	pshufd $0x4e,%xmm1,%xmm1
    864b:	f2 0f 70 c9 1b       	pshuflw $0x1b,%xmm1,%xmm1
    8650:	f3 0f 70 c9 1b       	pshufhw $0x1b,%xmm1,%xmm1
    8655:	66 0f 67 cb          	packuswb %xmm3,%xmm1
    8659:	66 0f 7f 56 f0       	movdqa %xmm2,-0x10(%rsi)
    865e:	66 0f 7f 0e          	movdqa %xmm1,(%rsi)
    8662:	49 83 c0 e0          	add    $0xffffffffffffffe0,%r8
    8666:	48 83 c6 20          	add    $0x20,%rsi
    866a:	4c 39 c2             	cmp    %r8,%rdx
    866d:	75 81                	jne    85f0 <fwp_write+0xd40>
    866f:	48 85 d2             	test   %rdx,%rdx
    8672:	0f 84 5b 04 00 00    	je     8ad3 <fwp_write+0x1223>
    8678:	83 fa 08             	cmp    $0x8,%edx
    867b:	72 5a                	jb     86d7 <fwp_write+0xe27>
    867d:	89 fa                	mov    %edi,%edx
    867f:	83 e2 07             	and    $0x7,%edx
    8682:	48 89 c6             	mov    %rax,%rsi
    8685:	48 29 ce             	sub    %rcx,%rsi
    8688:	48 8d 3c 0c          	lea    (%rsp,%rcx,1),%rdi
    868c:	48 83 c7 70          	add    $0x70,%rdi
    8690:	48 89 c1             	mov    %rax,%rcx
    8693:	48 29 d1             	sub    %rdx,%rcx
    8696:	66 0f ef c0          	pxor   %xmm0,%xmm0
    869a:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)
    86a0:	f3 0f 7e 4c 34 18    	movq   0x18(%rsp,%rsi,1),%xmm1
    86a6:	66 0f 60 c8          	punpcklbw %xmm0,%xmm1
    86aa:	66 0f 70 c9 4e       	pshufd $0x4e,%xmm1,%xmm1
    86af:	f2 0f 70 c9 1b       	pshuflw $0x1b,%xmm1,%xmm1
    86b4:	f3 0f 70 c9 1b       	pshufhw $0x1b,%xmm1,%xmm1
    86b9:	66 0f 67 c9          	packuswb %xmm1,%xmm1
    86bd:	66 0f d6 0f          	movq   %xmm1,(%rdi)
    86c1:	48 83 c6 f8          	add    $0xfffffffffffffff8,%rsi
    86c5:	48 83 c7 08          	add    $0x8,%rdi
    86c9:	48 39 f2             	cmp    %rsi,%rdx
    86cc:	75 d2                	jne    86a0 <fwp_write+0xdf0>
    86ce:	48 85 d2             	test   %rdx,%rdx
    86d1:	0f 84 fc 03 00 00    	je     8ad3 <fwp_write+0x1223>
    86d7:	48 8d 74 24 20       	lea    0x20(%rsp),%rsi
    86dc:	48 01 f2             	add    %rsi,%rdx
    86df:	48 ff ca             	dec    %rdx
    86e2:	66 66 66 66 66 2e 0f 	data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    86e9:	1f 84 00 00 00 00 00 
    86f0:	0f b6 32             	movzbl (%rdx),%esi
    86f3:	40 88 74 0c 70       	mov    %sil,0x70(%rsp,%rcx,1)
    86f8:	48 ff c1             	inc    %rcx
    86fb:	48 ff ca             	dec    %rdx
    86fe:	48 39 c8             	cmp    %rcx,%rax
    8701:	75 ed                	jne    86f0 <fwp_write+0xe40>
    8703:	e9 cb 03 00 00       	jmp    8ad3 <fwp_write+0x1223>
    8708:	48 8d 7c 24 70       	lea    0x70(%rsp),%rdi
    870d:	be 2e 00 00 00       	mov    $0x2e,%esi
    8712:	e8 e9 99 ff ff       	call   2100 <strchr@plt>
    8717:	48 85 c0             	test   %rax,%rax
    871a:	48 8b 2c 24          	mov    (%rsp),%rbp
    871e:	0f 85 b4 03 00 00    	jne    8ad8 <fwp_write+0x1228>
    8724:	48 8d 7c 24 70       	lea    0x70(%rsp),%rdi
    8729:	be 65 00 00 00       	mov    $0x65,%esi
    872e:	e8 cd 99 ff ff       	call   2100 <strchr@plt>
    8733:	48 85 c0             	test   %rax,%rax
    8736:	0f 85 9c 03 00 00    	jne    8ad8 <fwp_write+0x1228>
    873c:	48 8d 35 06 6f 00 00 	lea    0x6f06(%rip),%rsi        # f649 <fwp_segv.msg+0x409>
    8743:	48 8d 7c 24 70       	lea    0x70(%rsp),%rdi
    8748:	e8 93 9b ff ff       	call   22e0 <strstr@plt>
    874d:	48 85 c0             	test   %rax,%rax
    8750:	0f 85 82 03 00 00    	jne    8ad8 <fwp_write+0x1228>
    8756:	48 8d 35 e7 6e 00 00 	lea    0x6ee7(%rip),%rsi        # f644 <fwp_segv.msg+0x404>
    875d:	48 8d 7c 24 70       	lea    0x70(%rsp),%rdi
    8762:	e8 79 9b ff ff       	call   22e0 <strstr@plt>
    8767:	48 85 c0             	test   %rax,%rax
    876a:	0f 85 68 03 00 00    	jne    8ad8 <fwp_write+0x1228>
    8770:	48 8d 7c 24 70       	lea    0x70(%rsp),%rdi
    8775:	e8 66 99 ff ff       	call   20e0 <strlen@plt>
    877a:	66 c7 44 04 70 2e 30 	movw   $0x302e,0x70(%rsp,%rax,1)
    8781:	c6 44 04 72 00       	movb   $0x0,0x72(%rsp,%rax,1)
    8786:	e9 4d 03 00 00       	jmp    8ad8 <fwp_write+0x1228>
    878b:	48 8d 04 f0          	lea    (%rax,%rsi,8),%rax
    878f:	48 05 d0 03 00 00    	add    $0x3d0,%rax
    8795:	4c 01 f9             	add    %r15,%rcx
    8798:	48 89 08             	mov    %rcx,(%rax)
    879b:	4c 89 ff             	mov    %r15,%rdi
    879e:	31 f6                	xor    %esi,%esi
    87a0:	e8 8b 99 ff ff       	call   2130 <memset@plt>
    87a5:	66 41 c7 07 30 74    	movw   $0x7430,(%r15)
    87ab:	85 db                	test   %ebx,%ebx
    87ad:	0f 8e 98 00 00 00    	jle    884b <fwp_write+0xf9b>
    87b3:	44 89 e1             	mov    %r12d,%ecx
    87b6:	48 f7 d9             	neg    %rcx
    87b9:	4a 8d 34 3b          	lea    (%rbx,%r15,1),%rsi
    87bd:	48 ff c6             	inc    %rsi
    87c0:	31 ff                	xor    %edi,%edi
    87c2:	49 b8 56 55 55 55 55 	movabs $0x5555555555555556,%r8
    87c9:	55 55 55 
    87cc:	eb 2e                	jmp    87fc <fwp_write+0xf4c>
    87ce:	66 90                	xchg   %ax,%ax
    87d0:	41 b2 30             	mov    $0x30,%r10b
    87d3:	44 88 14 3e          	mov    %r10b,(%rsi,%rdi,1)
    87d7:	48 85 d2             	test   %rdx,%rdx
    87da:	0f 95 c2             	setne  %dl
    87dd:	4d 85 f6             	test   %r14,%r14
    87e0:	41 0f 98 c2          	sets   %r10b
    87e4:	41 20 d2             	and    %dl,%r10b
    87e7:	41 0f b6 d2          	movzbl %r10b,%edx
    87eb:	48 29 d0             	sub    %rdx,%rax
    87ee:	4c 01 c8             	add    %r9,%rax
    87f1:	48 ff cf             	dec    %rdi
    87f4:	49 89 c6             	mov    %rax,%r14
    87f7:	48 39 f9             	cmp    %rdi,%rcx
    87fa:	74 4f                	je     884b <fwp_write+0xf9b>
    87fc:	4c 89 f0             	mov    %r14,%rax
    87ff:	49 f7 e8             	imul   %r8
    8802:	48 89 d0             	mov    %rdx,%rax
    8805:	48 c1 e8 3f          	shr    $0x3f,%rax
    8809:	48 01 d0             	add    %rdx,%rax
    880c:	4c 8d 0c 40          	lea    (%rax,%rax,2),%r9
    8810:	4c 89 f2             	mov    %r14,%rdx
    8813:	4c 29 ca             	sub    %r9,%rdx
    8816:	49 f7 d9             	neg    %r9
    8819:	4d 01 f1             	add    %r14,%r9
    881c:	49 83 c1 03          	add    $0x3,%r9
    8820:	48 83 fa fd          	cmp    $0xfffffffffffffffd,%rdx
    8824:	4c 0f 42 ca          	cmovb  %rdx,%r9
    8828:	4d 85 c9             	test   %r9,%r9
    882b:	74 a3                	je     87d0 <fwp_write+0xf20>
    882d:	49 83 f9 01          	cmp    $0x1,%r9
    8831:	75 0d                	jne    8840 <fwp_write+0xf90>
    8833:	41 b2 2b             	mov    $0x2b,%r10b
    8836:	45 31 c9             	xor    %r9d,%r9d
    8839:	eb 98                	jmp    87d3 <fwp_write+0xf23>
    883b:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)
    8840:	41 b2 2d             	mov    $0x2d,%r10b
    8843:	41 b9 01 00 00 00    	mov    $0x1,%r9d
    8849:	eb 88                	jmp    87d3 <fwp_write+0xf23>
    884b:	43 c6 44 27 02 00    	movb   $0x0,0x2(%r15,%r12,1)
    8851:	4c 89 ff             	mov    %r15,%rdi
    8854:	e8 87 98 ff ff       	call   20e0 <strlen@plt>
    8859:	48 89 ef             	mov    %rbp,%rdi
    885c:	4c 89 fe             	mov    %r15,%rsi
    885f:	48 89 c2             	mov    %rax,%rdx
    8862:	48 81 c4 78 02 00 00 	add    $0x278,%rsp
    8869:	5b                   	pop    %rbx
    886a:	41 5c                	pop    %r12
    886c:	41 5d                	pop    %r13
    886e:	41 5e                	pop    %r14
    8870:	41 5f                	pop    %r15
    8872:	5d                   	pop    %rbp
    8873:	e9 18 04 00 00       	jmp    8c90 <buf_put>
    8878:	48 8b 31             	mov    (%rcx),%rsi
    887b:	eb 18                	jmp    8895 <fwp_write+0xfe5>
    887d:	83 3a 00             	cmpl   $0x0,(%rdx)
    8880:	0f b6 01             	movzbl (%rcx),%eax
    8883:	48 0f be f0          	movsbq %al,%rsi
    8887:	eb 08                	jmp    8891 <fwp_write+0xfe1>
    8889:	83 3a 02             	cmpl   $0x2,(%rdx)
    888c:	8b 01                	mov    (%rcx),%eax
    888e:	48 63 f0             	movslq %eax,%rsi
    8891:	48 0f 45 f0          	cmovne %rax,%rsi
    8895:	48 8b 2c 24          	mov    (%rsp),%rbp
    8899:	48 89 ef             	mov    %rbp,%rdi
    889c:	31 c9                	xor    %ecx,%ecx
    889e:	e8 0d f0 ff ff       	call   78b0 <fwp_write>
    88a3:	48 b8 ff ff ff ff ff 	movabs $0x7fffffffffffffff,%rax
    88aa:	ff ff 7f 
    88ad:	48 ff c8             	dec    %rax
    88b0:	49 85 06             	test   %rax,(%r14)
    88b3:	0f 84 c9 00 00 00    	je     8982 <fwp_write+0x10d2>
    88b9:	bb 01 00 00 00       	mov    $0x1,%ebx
    88be:	4c 8d 25 55 6d 00 00 	lea    0x6d55(%rip),%r12        # f61a <fwp_segv.msg+0x3da>
    88c5:	eb 39                	jmp    8900 <fwp_write+0x1050>
    88c7:	83 3a 01             	cmpl   $0x1,(%rdx)
    88ca:	0f b7 04 31          	movzwl (%rcx,%rsi,1),%eax
    88ce:	48 0f bf f0          	movswq %ax,%rsi
    88d2:	48 0f 45 f0          	cmovne %rax,%rsi
    88d6:	48 8b 2c 24          	mov    (%rsp),%rbp
    88da:	48 89 ef             	mov    %rbp,%rdi
    88dd:	31 c9                	xor    %ecx,%ecx
    88df:	e8 cc ef ff ff       	call   78b0 <fwp_write>
    88e4:	48 ff c3             	inc    %rbx
    88e7:	49 8b 06             	mov    (%r14),%rax
    88ea:	48 b9 ff ff ff ff ff 	movabs $0x7fffffffffffffff,%rcx
    88f1:	ff ff 7f 
    88f4:	48 21 c8             	and    %rcx,%rax
    88f7:	48 39 c3             	cmp    %rax,%rbx
    88fa:	0f 83 82 00 00 00    	jae    8982 <fwp_write+0x10d2>
    8900:	ba 02 00 00 00       	mov    $0x2,%edx
    8905:	48 89 ef             	mov    %rbp,%rdi
    8908:	4c 89 e6             	mov    %r12,%rsi
    890b:	e8 80 03 00 00       	call   8c90 <buf_put>
    8910:	49 8b 57 38          	mov    0x38(%r15),%rdx
    8914:	b8 08 00 00 00       	mov    $0x8,%eax
    8919:	48 85 d2             	test   %rdx,%rdx
    891c:	74 13                	je     8931 <fwp_write+0x1081>
    891e:	8b 0a                	mov    (%rdx),%ecx
    8920:	48 83 f9 0a          	cmp    $0xa,%rcx
    8924:	77 0b                	ja     8931 <fwp_write+0x1081>
    8926:	48 8d 05 8b 69 00 00 	lea    0x698b(%rip),%rax        # f2b8 <fwp_segv.msg+0x78>
    892d:	48 8b 04 c8          	mov    (%rax,%rcx,8),%rax
    8931:	49 83 3e 00          	cmpq   $0x0,(%r14)
    8935:	4c 89 e9             	mov    %r13,%rcx
    8938:	79 04                	jns    893e <fwp_write+0x108e>
    893a:	49 8b 4e 10          	mov    0x10(%r14),%rcx
    893e:	48 89 c6             	mov    %rax,%rsi
    8941:	48 0f af f3          	imul   %rbx,%rsi
    8945:	48 83 f8 01          	cmp    $0x1,%rax
    8949:	74 19                	je     8964 <fwp_write+0x10b4>
    894b:	48 83 f8 02          	cmp    $0x2,%rax
    894f:	0f 84 72 ff ff ff    	je     88c7 <fwp_write+0x1017>
    8955:	48 83 f8 08          	cmp    $0x8,%rax
    8959:	75 19                	jne    8974 <fwp_write+0x10c4>
    895b:	48 8b 34 31          	mov    (%rcx,%rsi,1),%rsi
    895f:	e9 72 ff ff ff       	jmp    88d6 <fwp_write+0x1026>
    8964:	83 3a 00             	cmpl   $0x0,(%rdx)
    8967:	0f b6 04 31          	movzbl (%rcx,%rsi,1),%eax
    896b:	48 0f be f0          	movsbq %al,%rsi
    896f:	e9 5e ff ff ff       	jmp    88d2 <fwp_write+0x1022>
    8974:	83 3a 02             	cmpl   $0x2,(%rdx)
    8977:	8b 04 31             	mov    (%rcx,%rsi,1),%eax
    897a:	48 63 f0             	movslq %eax,%rsi
    897d:	e9 50 ff ff ff       	jmp    88d2 <fwp_write+0x1022>
    8982:	c6 44 24 70 5d       	movb   $0x5d,0x70(%rsp)
    8987:	48 8d 74 24 70       	lea    0x70(%rsp),%rsi
    898c:	ba 01 00 00 00       	mov    $0x1,%edx
    8991:	48 89 ef             	mov    %rbp,%rdi
    8994:	e9 55 01 00 00       	jmp    8aee <fwp_write+0x123e>
    8999:	48 8d 35 9d 6c 00 00 	lea    0x6c9d(%rip),%rsi        # f63d <fwp_segv.msg+0x3fd>
    89a0:	ba 02 00 00 00       	mov    $0x2,%edx
    89a5:	48 89 ef             	mov    %rbp,%rdi
    89a8:	e9 b5 fe ff ff       	jmp    8862 <fwp_write+0xfb2>
    89ad:	31 c0                	xor    %eax,%eax
    89af:	c6 44 04 71 00       	movb   $0x0,0x71(%rsp,%rax,1)
    89b4:	e9 1f 01 00 00       	jmp    8ad8 <fwp_write+0x1228>
    89b9:	89 fa                	mov    %edi,%edx
    89bb:	83 e2 1f             	and    $0x1f,%edx
    89be:	48 89 c1             	mov    %rax,%rcx
    89c1:	48 29 d1             	sub    %rdx,%rcx
    89c4:	48 8d b4 24 80 00 00 	lea    0x80(%rsp),%rsi
    89cb:	00 
    89cc:	66 0f ef c0          	pxor   %xmm0,%xmm0
    89d0:	49 89 c0             	mov    %rax,%r8
    89d3:	f3 42 0f 6f 0c 04    	movdqu (%rsp,%r8,1),%xmm1
    89d9:	f3 42 0f 6f 54 04 10 	movdqu 0x10(%rsp,%r8,1),%xmm2
    89e0:	66 0f 6f da          	movdqa %xmm2,%xmm3
    89e4:	66 0f 60 d8          	punpcklbw %xmm0,%xmm3
    89e8:	66 0f 70 db 4e       	pshufd $0x4e,%xmm3,%xmm3
    89ed:	f2 0f 70 db 1b       	pshuflw $0x1b,%xmm3,%xmm3
    89f2:	f3 0f 70 db 1b       	pshufhw $0x1b,%xmm3,%xmm3
    89f7:	66 0f 68 d0          	punpckhbw %xmm0,%xmm2
    89fb:	66 0f 70 d2 4e       	pshufd $0x4e,%xmm2,%xmm2
    8a00:	f2 0f 70 d2 1b       	pshuflw $0x1b,%xmm2,%xmm2
    8a05:	f3 0f 70 d2 1b       	pshufhw $0x1b,%xmm2,%xmm2
    8a0a:	66 0f 67 d3          	packuswb %xmm3,%xmm2
    8a0e:	66 0f 6f d9          	movdqa %xmm1,%xmm3
    8a12:	66 0f 60 d8          	punpcklbw %xmm0,%xmm3
    8a16:	66 0f 70 db 4e       	pshufd $0x4e,%xmm3,%xmm3
    8a1b:	f2 0f 70 db 1b       	pshuflw $0x1b,%xmm3,%xmm3
    8a20:	f3 0f 70 db 1b       	pshufhw $0x1b,%xmm3,%xmm3
    8a25:	66 0f 68 c8          	punpckhbw %xmm0,%xmm1
    8a29:	66 0f 70 c9 4e       	pshufd $0x4e,%xmm1,%xmm1
    8a2e:	f2 0f 70 c9 1b       	pshuflw $0x1b,%xmm1,%xmm1
    8a33:	f3 0f 70 c9 1b       	pshufhw $0x1b,%xmm1,%xmm1
    8a38:	66 0f 67 cb          	packuswb %xmm3,%xmm1
    8a3c:	66 0f 7f 56 f0       	movdqa %xmm2,-0x10(%rsi)
    8a41:	66 0f 7f 0e          	movdqa %xmm1,(%rsi)
    8a45:	49 83 c0 e0          	add    $0xffffffffffffffe0,%r8
    8a49:	48 83 c6 20          	add    $0x20,%rsi
    8a4d:	4c 39 c2             	cmp    %r8,%rdx
    8a50:	75 81                	jne    89d3 <fwp_write+0x1123>
    8a52:	48 85 d2             	test   %rdx,%rdx
    8a55:	0f 84 78 00 00 00    	je     8ad3 <fwp_write+0x1223>
    8a5b:	83 fa 08             	cmp    $0x8,%edx
    8a5e:	72 50                	jb     8ab0 <fwp_write+0x1200>
    8a60:	89 fa                	mov    %edi,%edx
    8a62:	83 e2 07             	and    $0x7,%edx
    8a65:	48 89 c6             	mov    %rax,%rsi
    8a68:	48 29 ce             	sub    %rcx,%rsi
    8a6b:	48 8d 3c 0c          	lea    (%rsp,%rcx,1),%rdi
    8a6f:	48 83 c7 70          	add    $0x70,%rdi
    8a73:	48 89 c1             	mov    %rax,%rcx
    8a76:	48 29 d1             	sub    %rdx,%rcx
    8a79:	66 0f ef c0          	pxor   %xmm0,%xmm0
    8a7d:	f3 0f 7e 4c 34 18    	movq   0x18(%rsp,%rsi,1),%xmm1
    8a83:	66 0f 60 c8          	punpcklbw %xmm0,%xmm1
    8a87:	66 0f 70 c9 4e       	pshufd $0x4e,%xmm1,%xmm1
    8a8c:	f2 0f 70 c9 1b       	pshuflw $0x1b,%xmm1,%xmm1
    8a91:	f3 0f 70 c9 1b       	pshufhw $0x1b,%xmm1,%xmm1
    8a96:	66 0f 67 c9          	packuswb %xmm1,%xmm1
    8a9a:	66 0f d6 0f          	movq   %xmm1,(%rdi)
    8a9e:	48 83 c6 f8          	add    $0xfffffffffffffff8,%rsi
    8aa2:	48 83 c7 08          	add    $0x8,%rdi
    8aa6:	48 39 f2             	cmp    %rsi,%rdx
    8aa9:	75 d2                	jne    8a7d <fwp_write+0x11cd>
    8aab:	48 85 d2             	test   %rdx,%rdx
    8aae:	74 23                	je     8ad3 <fwp_write+0x1223>
    8ab0:	48 8d 74 24 20       	lea    0x20(%rsp),%rsi
    8ab5:	48 01 f2             	add    %rsi,%rdx
    8ab8:	48 ff ca             	dec    %rdx
    8abb:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)
    8ac0:	0f b6 32             	movzbl (%rdx),%esi
    8ac3:	40 88 74 0c 70       	mov    %sil,0x70(%rsp,%rcx,1)
    8ac8:	48 ff c1             	inc    %rcx
    8acb:	48 ff ca             	dec    %rdx
    8ace:	48 39 c8             	cmp    %rcx,%rax
    8ad1:	75 ed                	jne    8ac0 <fwp_write+0x1210>
    8ad3:	c6 44 04 70 00       	movb   $0x0,0x70(%rsp,%rax,1)
    8ad8:	4c 8d 74 24 70       	lea    0x70(%rsp),%r14
    8add:	4c 89 f7             	mov    %r14,%rdi
    8ae0:	e8 fb 95 ff ff       	call   20e0 <strlen@plt>
    8ae5:	48 89 ef             	mov    %rbp,%rdi
    8ae8:	4c 89 f6             	mov    %r14,%rsi
    8aeb:	48 89 c2             	mov    %rax,%rdx
    8aee:	e8 9d 01 00 00       	call   8c90 <buf_put>
    8af3:	48 81 c4 78 02 00 00 	add    $0x278,%rsp
    8afa:	5b                   	pop    %rbx
    8afb:	41 5c                	pop    %r12
    8afd:	41 5d                	pop    %r13
    8aff:	41 5e                	pop    %r14
    8b01:	41 5f                	pop    %r15
    8b03:	5d                   	pop    %rbp
    8b04:	c3                   	ret
    8b05:	83 f8 20             	cmp    $0x20,%eax
    8b08:	73 07                	jae    8b11 <fwp_write+0x1261>
    8b0a:	31 c9                	xor    %ecx,%ecx
    8b0c:	e9 b6 00 00 00       	jmp    8bc7 <fwp_write+0x1317>
    8b11:	89 fe                	mov    %edi,%esi
    8b13:	89 fa                	mov    %edi,%edx
    8b15:	83 e2 1f             	and    $0x1f,%edx
    8b18:	48 89 c1             	mov    %rax,%rcx
    8b1b:	48 29 d1             	sub    %rdx,%rcx
    8b1e:	4c 8d 04 34          	lea    (%rsp,%rsi,1),%r8
    8b22:	49 83 c0 10          	add    $0x10,%r8
    8b26:	48 29 d6             	sub    %rdx,%rsi
    8b29:	45 31 c9             	xor    %r9d,%r9d
    8b2c:	66 0f ef c0          	pxor   %xmm0,%xmm0
    8b30:	f3 41 0f 6f 48 f0    	movdqu -0x10(%r8),%xmm1
    8b36:	f3 41 0f 6f 10       	movdqu (%r8),%xmm2
    8b3b:	66 0f 6f da          	movdqa %xmm2,%xmm3
    8b3f:	66 0f 60 d8          	punpcklbw %xmm0,%xmm3
    8b43:	66 0f 70 db 4e       	pshufd $0x4e,%xmm3,%xmm3
    8b48:	f2 0f 70 db 1b       	pshuflw $0x1b,%xmm3,%xmm3
    8b4d:	f3 0f 70 db 1b       	pshufhw $0x1b,%xmm3,%xmm3
    8b52:	66 0f 68 d0          	punpckhbw %xmm0,%xmm2
    8b56:	66 0f 70 d2 4e       	pshufd $0x4e,%xmm2,%xmm2
    8b5b:	f2 0f 70 d2 1b       	pshuflw $0x1b,%xmm2,%xmm2
    8b60:	f3 0f 70 d2 1b       	pshufhw $0x1b,%xmm2,%xmm2
    8b65:	66 0f 67 d3          	packuswb %xmm3,%xmm2
    8b69:	66 0f 6f d9          	movdqa %xmm1,%xmm3
    8b6d:	66 0f 60 d8          	punpcklbw %xmm0,%xmm3
    8b71:	66 0f 70 db 4e       	pshufd $0x4e,%xmm3,%xmm3
    8b76:	f2 0f 70 db 1b       	pshuflw $0x1b,%xmm3,%xmm3
    8b7b:	f3 0f 70 db 1b       	pshufhw $0x1b,%xmm3,%xmm3
    8b80:	66 0f 68 c8          	punpckhbw %xmm0,%xmm1
    8b84:	66 0f 70 c9 4e       	pshufd $0x4e,%xmm1,%xmm1
    8b89:	f2 0f 70 c9 1b       	pshuflw $0x1b,%xmm1,%xmm1
    8b8e:	f3 0f 70 c9 1b       	pshufhw $0x1b,%xmm1,%xmm1
    8b93:	66 0f 67 cb          	packuswb %xmm3,%xmm1
    8b97:	f3 42 0f 7f 54 0c 71 	movdqu %xmm2,0x71(%rsp,%r9,1)
    8b9e:	f3 42 0f 7f 8c 0c 81 	movdqu %xmm1,0x81(%rsp,%r9,1)
    8ba5:	00 00 00 
    8ba8:	49 83 c1 20          	add    $0x20,%r9
    8bac:	49 83 c0 e0          	add    $0xffffffffffffffe0,%r8
    8bb0:	4c 39 ce             	cmp    %r9,%rsi
    8bb3:	0f 85 77 ff ff ff    	jne    8b30 <fwp_write+0x1280>
    8bb9:	48 85 d2             	test   %rdx,%rdx
    8bbc:	0f 84 91 00 00 00    	je     8c53 <fwp_write+0x13a3>
    8bc2:	83 fa 08             	cmp    $0x8,%edx
    8bc5:	72 60                	jb     8c27 <fwp_write+0x1377>
    8bc7:	48 89 ce             	mov    %rcx,%rsi
    8bca:	41 89 f8             	mov    %edi,%r8d
    8bcd:	89 fa                	mov    %edi,%edx
    8bcf:	83 e2 07             	and    $0x7,%edx
    8bd2:	48 89 c1             	mov    %rax,%rcx
    8bd5:	48 29 d1             	sub    %rdx,%rcx
    8bd8:	49 89 f1             	mov    %rsi,%r9
    8bdb:	49 f7 d9             	neg    %r9
    8bde:	49 01 e1             	add    %rsp,%r9
    8be1:	49 83 c1 20          	add    $0x20,%r9
    8be5:	4d 01 c1             	add    %r8,%r9
    8be8:	49 83 c1 f8          	add    $0xfffffffffffffff8,%r9
    8bec:	49 29 d0             	sub    %rdx,%r8
    8bef:	66 0f ef c0          	pxor   %xmm0,%xmm0
    8bf3:	f3 41 0f 7e 09       	movq   (%r9),%xmm1
    8bf8:	66 0f 60 c8          	punpcklbw %xmm0,%xmm1
    8bfc:	66 0f 70 c9 4e       	pshufd $0x4e,%xmm1,%xmm1
    8c01:	f2 0f 70 c9 1b       	pshuflw $0x1b,%xmm1,%xmm1
    8c06:	f3 0f 70 c9 1b       	pshufhw $0x1b,%xmm1,%xmm1
    8c0b:	66 0f 67 c9          	packuswb %xmm1,%xmm1
    8c0f:	66 0f d6 4c 34 71    	movq   %xmm1,0x71(%rsp,%rsi,1)
    8c15:	48 83 c6 08          	add    $0x8,%rsi
    8c19:	49 83 c1 f8          	add    $0xfffffffffffffff8,%r9
    8c1d:	49 39 f0             	cmp    %rsi,%r8
    8c20:	75 d1                	jne    8bf3 <fwp_write+0x1343>
    8c22:	48 85 d2             	test   %rdx,%rdx
    8c25:	74 2c                	je     8c53 <fwp_write+0x13a3>
    8c27:	48 8d 74 24 20       	lea    0x20(%rsp),%rsi
    8c2c:	48 01 f2             	add    %rsi,%rdx
    8c2f:	48 ff ca             	dec    %rdx
    8c32:	89 fe                	mov    %edi,%esi
    8c34:	66 66 66 2e 0f 1f 84 	data16 data16 cs nopw 0x0(%rax,%rax,1)
    8c3b:	00 00 00 00 00 
    8c40:	0f b6 3a             	movzbl (%rdx),%edi
    8c43:	40 88 7c 0c 71       	mov    %dil,0x71(%rsp,%rcx,1)
    8c48:	48 ff c1             	inc    %rcx
    8c4b:	48 ff ca             	dec    %rdx
    8c4e:	48 39 ce             	cmp    %rcx,%rsi
    8c51:	75 ed                	jne    8c40 <fwp_write+0x1390>
    8c53:	c6 44 04 71 00       	movb   $0x0,0x71(%rsp,%rax,1)
    8c58:	e9 7b fe ff ff       	jmp    8ad8 <fwp_write+0x1228>
    8c5d:	4c 8d 74 24 70       	lea    0x70(%rsp),%r14
    8c62:	4c 89 f7             	mov    %r14,%rdi
    8c65:	f2 0f 10 44 24 10    	movsd  0x10(%rsp),%xmm0
    8c6b:	be 09 00 00 00       	mov    $0x9,%esi
    8c70:	e8 7b 0d 00 00       	call   99f0 <fwp_format_g>
    8c75:	4c 89 f7             	mov    %r14,%rdi
    8c78:	e9 bf f8 ff ff       	jmp    853c <fwp_write+0xc8c>
    8c7d:	c7 44 24 70 4e 61 4e 	movl   $0x4e614e,0x70(%rsp)
    8c84:	00 
    8c85:	e9 4e fe ff ff       	jmp    8ad8 <fwp_write+0x1228>
    8c8a:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)

0000000000008c90 <buf_put>:
    8c90:	41 57                	push   %r15
    8c92:	41 56                	push   %r14
    8c94:	41 54                	push   %r12
    8c96:	53                   	push   %rbx
    8c97:	50                   	push   %rax
    8c98:	49 89 fe             	mov    %rdi,%r14
    8c9b:	48 8b 7f 08          	mov    0x8(%rdi),%rdi
    8c9f:	48 83 ff ff          	cmp    $0xffffffffffffffff,%rdi
    8ca3:	0f 84 a2 00 00 00    	je     8d4b <buf_put+0xbb>
    8ca9:	48 89 d3             	mov    %rdx,%rbx
    8cac:	48 c7 c0 fe ff ff ff 	mov    $0xfffffffffffffffe,%rax
    8cb3:	48 29 f8             	sub    %rdi,%rax
    8cb6:	48 39 d0             	cmp    %rdx,%rax
    8cb9:	0f 82 8c 00 00 00    	jb     8d4b <buf_put+0xbb>
    8cbf:	48 8d 04 3b          	lea    (%rbx,%rdi,1),%rax
    8cc3:	48 ff c0             	inc    %rax
    8cc6:	49 8b 4e 10          	mov    0x10(%r14),%rcx
    8cca:	48 39 c8             	cmp    %rcx,%rax
    8ccd:	76 30                	jbe    8cff <buf_put+0x6f>
    8ccf:	48 85 c9             	test   %rcx,%rcx
    8cd2:	41 bf 40 00 00 00    	mov    $0x40,%r15d
    8cd8:	4c 0f 45 f9          	cmovne %rcx,%r15
    8cdc:	49 89 f4             	mov    %rsi,%r12
    8cdf:	49 39 c7             	cmp    %rax,%r15
    8ce2:	73 23                	jae    8d07 <buf_put+0x77>
    8ce4:	66 66 66 2e 0f 1f 84 	data16 data16 cs nopw 0x0(%rax,%rax,1)
    8ceb:	00 00 00 00 00 
    8cf0:	4d 85 ff             	test   %r15,%r15
    8cf3:	78 0f                	js     8d04 <buf_put+0x74>
    8cf5:	4d 01 ff             	add    %r15,%r15
    8cf8:	49 39 c7             	cmp    %rax,%r15
    8cfb:	72 f3                	jb     8cf0 <buf_put+0x60>
    8cfd:	eb 08                	jmp    8d07 <buf_put+0x77>
    8cff:	49 8b 06             	mov    (%r14),%rax
    8d02:	eb 21                	jmp    8d25 <buf_put+0x95>
    8d04:	49 89 c7             	mov    %rax,%r15
    8d07:	49 8b 3e             	mov    (%r14),%rdi
    8d0a:	4c 89 fe             	mov    %r15,%rsi
    8d0d:	e8 fe 94 ff ff       	call   2210 <realloc@plt>
    8d12:	48 85 c0             	test   %rax,%rax
    8d15:	74 34                	je     8d4b <buf_put+0xbb>
    8d17:	49 89 06             	mov    %rax,(%r14)
    8d1a:	4d 89 7e 10          	mov    %r15,0x10(%r14)
    8d1e:	49 8b 7e 08          	mov    0x8(%r14),%rdi
    8d22:	4c 89 e6             	mov    %r12,%rsi
    8d25:	48 01 c7             	add    %rax,%rdi
    8d28:	48 89 da             	mov    %rbx,%rdx
    8d2b:	e8 b0 94 ff ff       	call   21e0 <memcpy@plt>
    8d30:	49 03 5e 08          	add    0x8(%r14),%rbx
    8d34:	49 89 5e 08          	mov    %rbx,0x8(%r14)
    8d38:	49 8b 06             	mov    (%r14),%rax
    8d3b:	c6 04 18 00          	movb   $0x0,(%rax,%rbx,1)
    8d3f:	48 83 c4 08          	add    $0x8,%rsp
    8d43:	5b                   	pop    %rbx
    8d44:	41 5c                	pop    %r12
    8d46:	41 5e                	pop    %r14
    8d48:	41 5f                	pop    %r15
    8d4a:	c3                   	ret
    8d4b:	48 8b 05 8e 92 00 00 	mov    0x928e(%rip),%rax        # 11fe0 <stderr@GLIBC_2.2.5>
    8d52:	48 8b 08             	mov    (%rax),%rcx
    8d55:	48 8d 3d dd 67 00 00 	lea    0x67dd(%rip),%rdi        # f539 <fwp_segv.msg+0x2f9>
    8d5c:	be 13 00 00 00       	mov    $0x13,%esi
    8d61:	ba 01 00 00 00       	mov    $0x1,%edx
    8d66:	e8 35 95 ff ff       	call   22a0 <fwrite@plt>
    8d6b:	bf 66 00 00 00       	mov    $0x66,%edi
    8d70:	e8 1b 95 ff ff       	call   2290 <exit@plt>
    8d75:	66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
    8d7c:	00 00 00 00 

0000000000008d80 <fwp_escape>:
    8d80:	55                   	push   %rbp
    8d81:	41 57                	push   %r15
    8d83:	41 56                	push   %r14
    8d85:	41 55                	push   %r13
    8d87:	41 54                	push   %r12
    8d89:	53                   	push   %rbx
    8d8a:	48 83 ec 18          	sub    $0x18,%rsp
    8d8e:	49 89 d6             	mov    %rdx,%r14
    8d91:	49 89 f7             	mov    %rsi,%r15
    8d94:	48 89 fb             	mov    %rdi,%rbx
    8d97:	c6 04 24 22          	movb   $0x22,(%rsp)
    8d9b:	48 89 e6             	mov    %rsp,%rsi
    8d9e:	ba 01 00 00 00       	mov    $0x1,%edx
    8da3:	e8 e8 fe ff ff       	call   8c90 <buf_put>
    8da8:	4d 85 f6             	test   %r14,%r14
    8dab:	0f 84 de 00 00 00    	je     8e8f <fwp_escape+0x10f>
    8db1:	48 89 e5             	mov    %rsp,%rbp
    8db4:	4c 8d 2d 11 64 00 00 	lea    0x6411(%rip),%r13        # f1cc <_IO_stdin_used+0x1cc>
    8dbb:	45 31 e4             	xor    %r12d,%r12d
    8dbe:	eb 21                	jmp    8de1 <fwp_escape+0x61>
    8dc0:	ba 02 00 00 00       	mov    $0x2,%edx
    8dc5:	48 89 df             	mov    %rbx,%rdi
    8dc8:	48 8d 35 a1 68 00 00 	lea    0x68a1(%rip),%rsi        # f670 <fwp_segv.msg+0x430>
    8dcf:	90                   	nop
    8dd0:	e8 bb fe ff ff       	call   8c90 <buf_put>
    8dd5:	49 ff c4             	inc    %r12
    8dd8:	4d 39 e6             	cmp    %r12,%r14
    8ddb:	0f 84 ae 00 00 00    	je     8e8f <fwp_escape+0x10f>
    8de1:	43 0f b6 04 27       	movzbl (%r15,%r12,1),%eax
    8de6:	0f b6 c8             	movzbl %al,%ecx
    8de9:	8d 51 f7             	lea    -0x9(%rcx),%edx
    8dec:	83 fa 19             	cmp    $0x19,%edx
    8def:	77 1f                	ja     8e10 <fwp_escape+0x90>
    8df1:	49 63 54 95 00       	movslq 0x0(%r13,%rdx,4),%rdx
    8df6:	4c 01 ea             	add    %r13,%rdx
    8df9:	ff e2                	jmp    *%rdx
    8dfb:	ba 02 00 00 00       	mov    $0x2,%edx
    8e00:	48 89 df             	mov    %rbx,%rdi
    8e03:	48 8d 35 63 68 00 00 	lea    0x6863(%rip),%rsi        # f66d <fwp_segv.msg+0x42d>
    8e0a:	eb c4                	jmp    8dd0 <fwp_escape+0x50>
    8e0c:	0f 1f 40 00          	nopl   0x0(%rax)
    8e10:	83 f9 5c             	cmp    $0x5c,%ecx
    8e13:	75 11                	jne    8e26 <fwp_escape+0xa6>
    8e15:	ba 02 00 00 00       	mov    $0x2,%edx
    8e1a:	48 89 df             	mov    %rbx,%rdi
    8e1d:	48 8d 35 43 68 00 00 	lea    0x6843(%rip),%rsi        # f667 <fwp_segv.msg+0x427>
    8e24:	eb aa                	jmp    8dd0 <fwp_escape+0x50>
    8e26:	3c 20                	cmp    $0x20,%al
    8e28:	72 39                	jb     8e63 <fwp_escape+0xe3>
    8e2a:	3c 7f                	cmp    $0x7f,%al
    8e2c:	74 35                	je     8e63 <fwp_escape+0xe3>
    8e2e:	88 04 24             	mov    %al,(%rsp)
    8e31:	ba 01 00 00 00       	mov    $0x1,%edx
    8e36:	48 89 df             	mov    %rbx,%rdi
    8e39:	48 89 ee             	mov    %rbp,%rsi
    8e3c:	eb 92                	jmp    8dd0 <fwp_escape+0x50>
    8e3e:	ba 02 00 00 00       	mov    $0x2,%edx
    8e43:	48 89 df             	mov    %rbx,%rdi
    8e46:	48 8d 35 17 68 00 00 	lea    0x6817(%rip),%rsi        # f664 <fwp_segv.msg+0x424>
    8e4d:	eb 81                	jmp    8dd0 <fwp_escape+0x50>
    8e4f:	ba 02 00 00 00       	mov    $0x2,%edx
    8e54:	48 89 df             	mov    %rbx,%rdi
    8e57:	48 8d 35 0c 68 00 00 	lea    0x680c(%rip),%rsi        # f66a <fwp_segv.msg+0x42a>
    8e5e:	e9 6d ff ff ff       	jmp    8dd0 <fwp_escape+0x50>
    8e63:	be 10 00 00 00       	mov    $0x10,%esi
    8e68:	48 89 ef             	mov    %rbp,%rdi
    8e6b:	48 8d 15 01 68 00 00 	lea    0x6801(%rip),%rdx        # f673 <fwp_segv.msg+0x433>
    8e72:	31 c0                	xor    %eax,%eax
    8e74:	e8 97 92 ff ff       	call   2110 <snprintf@plt>
    8e79:	48 89 ef             	mov    %rbp,%rdi
    8e7c:	e8 5f 92 ff ff       	call   20e0 <strlen@plt>
    8e81:	48 89 df             	mov    %rbx,%rdi
    8e84:	48 89 ee             	mov    %rbp,%rsi
    8e87:	48 89 c2             	mov    %rax,%rdx
    8e8a:	e9 41 ff ff ff       	jmp    8dd0 <fwp_escape+0x50>
    8e8f:	c6 04 24 22          	movb   $0x22,(%rsp)
    8e93:	48 89 e6             	mov    %rsp,%rsi
    8e96:	ba 01 00 00 00       	mov    $0x1,%edx
    8e9b:	48 89 df             	mov    %rbx,%rdi
    8e9e:	e8 ed fd ff ff       	call   8c90 <buf_put>
    8ea3:	48 83 c4 18          	add    $0x18,%rsp
    8ea7:	5b                   	pop    %rbx
    8ea8:	41 5c                	pop    %r12
    8eaa:	41 5d                	pop    %r13
    8eac:	41 5e                	pop    %r14
    8eae:	41 5f                	pop    %r15
    8eb0:	5d                   	pop    %rbp
    8eb1:	c3                   	ret
    8eb2:	66 66 66 66 66 2e 0f 	data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    8eb9:	1f 84 00 00 00 00 00 

0000000000008ec0 <fwp_fmt_duration>:
    8ec0:	41 57                	push   %r15
    8ec2:	41 56                	push   %r14
    8ec4:	41 54                	push   %r12
    8ec6:	53                   	push   %rbx
    8ec7:	48 81 ec 88 00 00 00 	sub    $0x88,%rsp
    8ece:	48 89 f0             	mov    %rsi,%rax
    8ed1:	48 09 d0             	or     %rdx,%rax
    8ed4:	0f 84 bf 02 00 00    	je     9199 <fwp_fmt_duration+0x2d9>
    8eda:	49 89 d0             	mov    %rdx,%r8
    8edd:	48 b9 1d 3f c2 25 d6 	movabs $0xd2fe1d625c23f1d,%rcx
    8ee4:	e1 2f 0d 
    8ee7:	48 0f af ce          	imul   %rsi,%rcx
    8eeb:	49 b9 0d b1 f3 e4 99 	movabs $0x1c52799e4f3b10d,%r9
    8ef2:	27 c5 01 
    8ef5:	48 89 f0             	mov    %rsi,%rax
    8ef8:	49 f7 e1             	mul    %r9
    8efb:	48 01 ca             	add    %rcx,%rdx
    8efe:	4d 0f af c8          	imul   %r8,%r9
    8f02:	49 01 d1             	add    %rdx,%r9
    8f05:	48 b9 00 a0 34 52 a3 	movabs $0x6baf6aa35234a000,%rcx
    8f0c:	6a af 6b 
    8f0f:	48 01 c1             	add    %rax,%rcx
    8f12:	48 b8 37 f9 ff e2 04 	movabs $0x4e2fff937,%rax
    8f19:	00 00 00 
    8f1c:	4c 11 c8             	adc    %r9,%rax
    8f1f:	48 89 c2             	mov    %rax,%rdx
    8f22:	48 0f ac ca 0d       	shrd   $0xd,%rcx,%rdx
    8f27:	48 0f a4 c8 33       	shld   $0x33,%rcx,%rax
    8f2c:	48 b9 4a 23 35 aa f6 	movabs $0x9376baf6aa35234a,%rcx
    8f33:	ba 76 93 
    8f36:	48 39 c1             	cmp    %rax,%rcx
    8f39:	b8 ff 2f 4e 00       	mov    $0x4e2fff,%eax
    8f3e:	48 19 d0             	sbb    %rdx,%rax
    8f41:	0f 83 70 02 00 00    	jae    91b7 <fwp_fmt_duration+0x2f7>
    8f47:	48 b9 b3 b2 61 36 8c 	movabs $0xc5ce3b8c3661b2b3,%rcx
    8f4e:	3b ce c5 
    8f51:	49 b9 c3 5f 47 6a 04 	movabs $0x1a8d52046a475fc3,%r9
    8f58:	52 8d 1a 
    8f5b:	48 89 f0             	mov    %rsi,%rax
    8f5e:	49 f7 e1             	mul    %r9
    8f61:	48 0f af ce          	imul   %rsi,%rcx
    8f65:	48 01 ca             	add    %rcx,%rdx
    8f68:	4d 0f af c8          	imul   %r8,%r9
    8f6c:	49 01 d1             	add    %rdx,%r9
    8f6f:	48 b9 00 a8 16 d1 91 	movabs $0x4f473f91d116a800,%rcx
    8f76:	3f 47 4f 
    8f79:	48 01 c1             	add    %rax,%rcx
    8f7c:	48 b8 3f 9a ff 4c 49 	movabs $0x494cff9a3f,%rax
    8f83:	00 00 00 
    8f86:	4c 11 c8             	adc    %r9,%rax
    8f89:	48 89 c2             	mov    %rax,%rdx
    8f8c:	48 0f ac ca 0b       	shrd   $0xb,%rcx,%rdx
    8f91:	48 0f a4 c8 35       	shld   $0x35,%rcx,%rax
    8f96:	48 b9 ab 45 74 e4 cf 	movabs $0x8fd3d1cfe47445ab,%rcx
    8f9d:	d1 d3 8f 
    8fa0:	48 39 c8             	cmp    %rcx,%rax
    8fa3:	48 81 da e6 3f 53 12 	sbb    $0x12533fe6,%rdx
    8faa:	0f 82 27 02 00 00    	jb     91d7 <fwp_fmt_duration+0x317>
    8fb0:	48 b9 7e 78 b9 2f 37 	movabs $0x97157d372fb9787e,%rcx
    8fb7:	7d 15 97 
    8fba:	48 0f af ce          	imul   %rsi,%rcx
    8fbe:	49 b9 6d 9c 2e 3a 42 	movabs $0x8e47ce423a2e9c6d,%r9
    8fc5:	ce 47 8e 
    8fc8:	48 89 f0             	mov    %rsi,%rax
    8fcb:	49 f7 e1             	mul    %r9
    8fce:	48 01 ca             	add    %rcx,%rdx
    8fd1:	4d 0f af c8          	imul   %r8,%r9
    8fd5:	49 01 d1             	add    %rdx,%r9
    8fd8:	48 b9 00 46 54 40 8b 	movabs $0xa52cb98b40544600,%rcx
    8fdf:	b9 2c a5 
    8fe2:	48 01 c1             	add    %rax,%rcx
    8fe5:	48 b8 b5 09 fa 82 4b 	movabs $0x44b82fa09b5,%rax
    8fec:	04 00 00 
    8fef:	4c 11 c8             	adc    %r9,%rax
    8ff2:	48 89 c2             	mov    %rax,%rdx
    8ff5:	48 0f ac ca 09       	shrd   $0x9,%rcx,%rdx
    8ffa:	48 0f a4 c8 37       	shld   $0x37,%rcx,%rax
    8fff:	48 b9 47 54 40 8b b9 	movabs $0xb5a52cb98b405447,%rcx
    9006:	2c a5 b5 
    9009:	48 39 c8             	cmp    %rcx,%rax
    900c:	48 b8 09 fa 82 4b 04 	movabs $0x44b82fa09,%rax
    9013:	00 00 00 
    9016:	48 19 c2             	sbb    %rax,%rdx
    9019:	0f 82 0d 03 00 00    	jb     932c <fwp_fmt_duration+0x46c>
    901f:	48 b9 cb d5 8f 4d f2 	movabs $0xc57e23f24d8fd5cb,%rcx
    9026:	23 7e c5 
    9029:	48 0f af ce          	imul   %rsi,%rcx
    902d:	49 b9 39 61 c2 68 56 	movabs $0x790fb65668c26139,%r9
    9034:	b6 0f 79 
    9037:	48 89 f0             	mov    %rsi,%rax
    903a:	49 f7 e1             	mul    %r9
    903d:	48 01 ca             	add    %rcx,%rdx
    9040:	4d 0f af c8          	imul   %r8,%r9
    9044:	49 01 d1             	add    %rdx,%r9
    9047:	48 b9 00 0b 27 69 fe 	movabs $0xa6d698fe69270b00,%rcx
    904e:	98 d6 a6 
    9051:	48 01 c1             	add    %rax,%rcx
    9054:	48 b8 b1 bd 16 f4 de 	movabs $0x218def416bdb1,%rax
    905b:	18 02 00 
    905e:	4c 11 c8             	adc    %r9,%rax
    9061:	48 89 c2             	mov    %rax,%rdx
    9064:	48 0f ac ca 06       	shrd   $0x6,%rcx,%rdx
    9069:	48 0f a4 c8 3a       	shld   $0x3a,%rcx,%rax
    906e:	48 b9 59 38 49 f3 c7 	movabs $0x8d36b4c7f3493859,%rcx
    9075:	b4 36 8d 
    9078:	48 39 c8             	cmp    %rcx,%rax
    907b:	48 b8 ed b5 a0 f7 c6 	movabs $0x10c6f7a0b5ed,%rax
    9082:	10 00 00 
    9085:	48 19 c2             	sbb    %rax,%rdx
    9088:	0f 82 ad 02 00 00    	jb     933b <fwp_fmt_duration+0x47b>
    908e:	48 b9 5a 64 3b df 4f 	movabs $0x6e978d4fdf3b645a,%rcx
    9095:	8d 97 6e 
    9098:	48 0f af ce          	imul   %rsi,%rcx
    909c:	49 b9 d5 78 e9 26 31 	movabs $0x1cac083126e978d5,%r9
    90a3:	08 ac 1c 
    90a6:	48 89 f0             	mov    %rsi,%rax
    90a9:	49 f7 e1             	mul    %r9
    90ac:	48 01 ca             	add    %rcx,%rdx
    90af:	4d 0f af c8          	imul   %r8,%r9
    90b3:	49 01 d1             	add    %rdx,%r9
    90b6:	48 b9 48 62 10 58 39 	movabs $0x76c8b43958106248,%rcx
    90bd:	b4 c8 76 
    90c0:	48 01 c1             	add    %rax,%rcx
    90c3:	48 b8 be 9f 1a 2f dd 	movabs $0x10624dd2f1a9fbe,%rax
    90ca:	24 06 01 
    90cd:	4c 11 c8             	adc    %r9,%rax
    90d0:	48 89 c2             	mov    %rax,%rdx
    90d3:	48 0f ac ca 03       	shrd   $0x3,%rcx,%rdx
    90d8:	48 0f a4 c8 3d       	shld   $0x3d,%rcx,%rax
    90dd:	48 b9 93 18 04 56 0e 	movabs $0x9db22d0e56041893,%rcx
    90e4:	2d b2 9d 
    90e7:	48 39 c8             	cmp    %rcx,%rax
    90ea:	48 b8 ef a7 c6 4b 37 	movabs $0x4189374bc6a7ef,%rax
    90f1:	89 41 00 
    90f4:	48 19 c2             	sbb    %rax,%rdx
    90f7:	0f 82 4d 02 00 00    	jb     934a <fwp_fmt_duration+0x48a>
    90fd:	4d 85 c0             	test   %r8,%r8
    9100:	0f 88 d6 06 00 00    	js     97dc <fwp_fmt_duration+0x91c>
    9106:	45 31 d2             	xor    %r10d,%r10d
    9109:	49 bb cd cc cc cc cc 	movabs $0xcccccccccccccccd,%r11
    9110:	cc cc cc 
    9113:	48 bb cc cc cc cc cc 	movabs $0xcccccccccccccccc,%rbx
    911a:	cc cc cc 
    911d:	4d 89 c6             	mov    %r8,%r14
    9120:	4c 89 c1             	mov    %r8,%rcx
    9123:	48 0f a4 f1 3f       	shld   $0x3f,%rsi,%rcx
    9128:	49 d1 ee             	shr    $1,%r14
    912b:	49 89 c9             	mov    %rcx,%r9
    912e:	4d 01 f1             	add    %r14,%r9
    9131:	49 83 d1 00          	adc    $0x0,%r9
    9135:	4c 89 c8             	mov    %r9,%rax
    9138:	49 f7 e3             	mul    %r11
    913b:	48 c1 ea 02          	shr    $0x2,%rdx
    913f:	48 8d 04 92          	lea    (%rdx,%rdx,4),%rax
    9143:	49 29 c1             	sub    %rax,%r9
    9146:	4c 29 c9             	sub    %r9,%rcx
    9149:	49 83 de 00          	sbb    $0x0,%r14
    914d:	49 89 c9             	mov    %rcx,%r9
    9150:	4c 0f af cb          	imul   %rbx,%r9
    9154:	48 89 c8             	mov    %rcx,%rax
    9157:	49 f7 e3             	mul    %r11
    915a:	4c 01 ca             	add    %r9,%rdx
    915d:	4d 0f af f3          	imul   %r11,%r14
    9161:	49 01 d6             	add    %rdx,%r14
    9164:	48 89 c1             	mov    %rax,%rcx
    9167:	48 01 c1             	add    %rax,%rcx
    916a:	48 8d 0c 89          	lea    (%rcx,%rcx,4),%rcx
    916e:	89 f2                	mov    %esi,%edx
    9170:	29 ca                	sub    %ecx,%edx
    9172:	80 ca 30             	or     $0x30,%dl
    9175:	42 88 54 14 40       	mov    %dl,0x40(%rsp,%r10,1)
    917a:	49 ff c2             	inc    %r10
    917d:	48 83 fe 0a          	cmp    $0xa,%rsi
    9181:	49 83 d8 00          	sbb    $0x0,%r8
    9185:	48 89 c6             	mov    %rax,%rsi
    9188:	4d 89 f0             	mov    %r14,%r8
    918b:	73 93                	jae    9120 <fwp_fmt_duration+0x260>
    918d:	45 85 d2             	test   %r10d,%r10d
    9190:	7f 12                	jg     91a4 <fwp_fmt_duration+0x2e4>
    9192:	31 c0                	xor    %eax,%eax
    9194:	e9 79 01 00 00       	jmp    9312 <fwp_fmt_duration+0x452>
    9199:	c6 44 24 40 30       	movb   $0x30,0x40(%rsp)
    919e:	41 ba 01 00 00 00    	mov    $0x1,%r10d
    91a4:	44 89 d0             	mov    %r10d,%eax
    91a7:	48 83 f8 08          	cmp    $0x8,%rax
    91ab:	73 1e                	jae    91cb <fwp_fmt_duration+0x30b>
    91ad:	31 c9                	xor    %ecx,%ecx
    91af:	48 89 c2             	mov    %rax,%rdx
    91b2:	e9 3d 01 00 00       	jmp    92f4 <fwp_fmt_duration+0x434>
    91b7:	49 89 fe             	mov    %rdi,%r14
    91ba:	48 ba 00 a0 b8 30 46 	movabs $0x34630b8a000,%rdx
    91c1:	03 00 00 
    91c4:	31 c0                	xor    %eax,%eax
    91c6:	e9 8c 01 00 00       	jmp    9357 <fwp_fmt_duration+0x497>
    91cb:	83 f8 20             	cmp    $0x20,%eax
    91ce:	73 1e                	jae    91ee <fwp_fmt_duration+0x32e>
    91d0:	31 c9                	xor    %ecx,%ecx
    91d2:	e9 c3 00 00 00       	jmp    929a <fwp_fmt_duration+0x3da>
    91d7:	49 89 fe             	mov    %rdi,%r14
    91da:	48 ba 00 58 47 f8 0d 	movabs $0xdf8475800,%rdx
    91e1:	00 00 00 
    91e4:	b8 01 00 00 00       	mov    $0x1,%eax
    91e9:	e9 69 01 00 00       	jmp    9357 <fwp_fmt_duration+0x497>
    91ee:	44 89 d2             	mov    %r10d,%edx
    91f1:	83 e2 1f             	and    $0x1f,%edx
    91f4:	48 89 c1             	mov    %rax,%rcx
    91f7:	48 29 d1             	sub    %rdx,%rcx
    91fa:	48 8d 74 24 10       	lea    0x10(%rsp),%rsi
    91ff:	66 0f ef c0          	pxor   %xmm0,%xmm0
    9203:	49 89 c0             	mov    %rax,%r8
    9206:	66 2e 0f 1f 84 00 00 	cs nopw 0x0(%rax,%rax,1)
    920d:	00 00 00 
    9210:	f3 42 0f 6f 4c 04 20 	movdqu 0x20(%rsp,%r8,1),%xmm1
    9217:	f3 42 0f 6f 54 04 30 	movdqu 0x30(%rsp,%r8,1),%xmm2
    921e:	66 0f 6f da          	movdqa %xmm2,%xmm3
    9222:	66 0f 60 d8          	punpcklbw %xmm0,%xmm3
    9226:	66 0f 70 db 4e       	pshufd $0x4e,%xmm3,%xmm3
    922b:	f2 0f 70 db 1b       	pshuflw $0x1b,%xmm3,%xmm3
    9230:	f3 0f 70 db 1b       	pshufhw $0x1b,%xmm3,%xmm3
    9235:	66 0f 68 d0          	punpckhbw %xmm0,%xmm2
    9239:	66 0f 70 d2 4e       	pshufd $0x4e,%xmm2,%xmm2
    923e:	f2 0f 70 d2 1b       	pshuflw $0x1b,%xmm2,%xmm2
    9243:	f3 0f 70 d2 1b       	pshufhw $0x1b,%xmm2,%xmm2
    9248:	66 0f 67 d3          	packuswb %xmm3,%xmm2
    924c:	66 0f 6f d9          	movdqa %xmm1,%xmm3
    9250:	66 0f 60 d8          	punpcklbw %xmm0,%xmm3
    9254:	66 0f 70 db 4e       	pshufd $0x4e,%xmm3,%xmm3
    9259:	f2 0f 70 db 1b       	pshuflw $0x1b,%xmm3,%xmm3
    925e:	f3 0f 70 db 1b       	pshufhw $0x1b,%xmm3,%xmm3
    9263:	66 0f 68 c8          	punpckhbw %xmm0,%xmm1
    9267:	66 0f 70 c9 4e       	pshufd $0x4e,%xmm1,%xmm1
    926c:	f2 0f 70 c9 1b       	pshuflw $0x1b,%xmm1,%xmm1
    9271:	f3 0f 70 c9 1b       	pshufhw $0x1b,%xmm1,%xmm1
    9276:	66 0f 67 cb          	packuswb %xmm3,%xmm1
    927a:	66 0f 7f 56 f0       	movdqa %xmm2,-0x10(%rsi)
    927f:	66 0f 7f 0e          	movdqa %xmm1,(%rsi)
    9283:	49 83 c0 e0          	add    $0xffffffffffffffe0,%r8
    9287:	48 83 c6 20          	add    $0x20,%rsi
    928b:	4c 39 c2             	cmp    %r8,%rdx
    928e:	75 80                	jne    9210 <fwp_fmt_duration+0x350>
    9290:	48 85 d2             	test   %rdx,%rdx
    9293:	74 7d                	je     9312 <fwp_fmt_duration+0x452>
    9295:	83 fa 08             	cmp    $0x8,%edx
    9298:	72 5a                	jb     92f4 <fwp_fmt_duration+0x434>
    929a:	44 89 d2             	mov    %r10d,%edx
    929d:	83 e2 07             	and    $0x7,%edx
    92a0:	48 89 c6             	mov    %rax,%rsi
    92a3:	48 29 ce             	sub    %rcx,%rsi
    92a6:	4c 8d 04 0c          	lea    (%rsp,%rcx,1),%r8
    92aa:	48 89 c1             	mov    %rax,%rcx
    92ad:	48 29 d1             	sub    %rdx,%rcx
    92b0:	66 0f ef c0          	pxor   %xmm0,%xmm0
    92b4:	66 66 66 2e 0f 1f 84 	data16 data16 cs nopw 0x0(%rax,%rax,1)
    92bb:	00 00 00 00 00 
    92c0:	f3 0f 7e 4c 34 38    	movq   0x38(%rsp,%rsi,1),%xmm1
    92c6:	66 0f 60 c8          	punpcklbw %xmm0,%xmm1
    92ca:	66 0f 70 c9 4e       	pshufd $0x4e,%xmm1,%xmm1
    92cf:	f2 0f 70 c9 1b       	pshuflw $0x1b,%xmm1,%xmm1
    92d4:	f3 0f 70 c9 1b       	pshufhw $0x1b,%xmm1,%xmm1
    92d9:	66 0f 67 c9          	packuswb %xmm1,%xmm1
    92dd:	66 41 0f d6 08       	movq   %xmm1,(%r8)
    92e2:	48 83 c6 f8          	add    $0xfffffffffffffff8,%rsi
    92e6:	49 83 c0 08          	add    $0x8,%r8
    92ea:	48 39 f2             	cmp    %rsi,%rdx
    92ed:	75 d1                	jne    92c0 <fwp_fmt_duration+0x400>
    92ef:	48 85 d2             	test   %rdx,%rdx
    92f2:	74 1e                	je     9312 <fwp_fmt_duration+0x452>
    92f4:	48 8d 74 24 40       	lea    0x40(%rsp),%rsi
    92f9:	48 01 f2             	add    %rsi,%rdx
    92fc:	48 ff ca             	dec    %rdx
    92ff:	90                   	nop
    9300:	0f b6 32             	movzbl (%rdx),%esi
    9303:	40 88 34 0c          	mov    %sil,(%rsp,%rcx,1)
    9307:	48 ff c1             	inc    %rcx
    930a:	48 ff ca             	dec    %rdx
    930d:	48 39 c8             	cmp    %rcx,%rax
    9310:	75 ee                	jne    9300 <fwp_fmt_duration+0x440>
    9312:	c6 04 04 00          	movb   $0x0,(%rsp,%rax,1)
    9316:	48 8d 35 69 63 00 00 	lea    0x6369(%rip),%rsi        # f686 <fwp_segv.msg+0x446>
    931d:	48 89 e2             	mov    %rsp,%rdx
    9320:	31 c0                	xor    %eax,%eax
    9322:	e8 59 8f ff ff       	call   2280 <sprintf@plt>
    9327:	e9 a1 04 00 00       	jmp    97cd <fwp_fmt_duration+0x90d>
    932c:	49 89 fe             	mov    %rdi,%r14
    932f:	ba 00 ca 9a 3b       	mov    $0x3b9aca00,%edx
    9334:	b8 02 00 00 00       	mov    $0x2,%eax
    9339:	eb 1c                	jmp    9357 <fwp_fmt_duration+0x497>
    933b:	49 89 fe             	mov    %rdi,%r14
    933e:	ba 40 42 0f 00       	mov    $0xf4240,%edx
    9343:	b8 03 00 00 00       	mov    $0x3,%eax
    9348:	eb 0d                	jmp    9357 <fwp_fmt_duration+0x497>
    934a:	49 89 fe             	mov    %rdi,%r14
    934d:	ba e8 03 00 00       	mov    $0x3e8,%edx
    9352:	b8 04 00 00 00       	mov    $0x4,%eax
    9357:	31 c9                	xor    %ecx,%ecx
    9359:	c1 e0 04             	shl    $0x4,%eax
    935c:	48 8d 1d 0d 8a 00 00 	lea    0x8a0d(%rip),%rbx        # 11d70 <fwp_fmt_duration.units>
    9363:	48 01 c3             	add    %rax,%rbx
    9366:	48 89 f7             	mov    %rsi,%rdi
    9369:	4c 89 c6             	mov    %r8,%rsi
    936c:	e8 ff 4e 00 00       	call   e270 <__divti3>
    9371:	48 89 c1             	mov    %rax,%rcx
    9374:	48 89 d6             	mov    %rdx,%rsi
    9377:	48 85 d2             	test   %rdx,%rdx
    937a:	0f 88 b0 00 00 00    	js     9430 <fwp_fmt_duration+0x570>
    9380:	48 89 c8             	mov    %rcx,%rax
    9383:	48 09 f0             	or     %rsi,%rax
    9386:	0f 84 61 01 00 00    	je     94ed <fwp_fmt_duration+0x62d>
    938c:	45 31 d2             	xor    %r10d,%r10d
    938f:	49 bb cd cc cc cc cc 	movabs $0xcccccccccccccccd,%r11
    9396:	cc cc cc 
    9399:	49 bf cc cc cc cc cc 	movabs $0xcccccccccccccccc,%r15
    93a0:	cc cc cc 
    93a3:	49 89 f4             	mov    %rsi,%r12
    93a6:	4c 89 f7             	mov    %r14,%rdi
    93a9:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)
    93b0:	49 89 f0             	mov    %rsi,%r8
    93b3:	49 0f a4 c8 3f       	shld   $0x3f,%rcx,%r8
    93b8:	49 d1 ec             	shr    $1,%r12
    93bb:	4d 89 c1             	mov    %r8,%r9
    93be:	4d 01 e1             	add    %r12,%r9
    93c1:	49 83 d1 00          	adc    $0x0,%r9
    93c5:	4c 89 c8             	mov    %r9,%rax
    93c8:	49 f7 e3             	mul    %r11
    93cb:	48 c1 ea 02          	shr    $0x2,%rdx
    93cf:	48 8d 04 92          	lea    (%rdx,%rdx,4),%rax
    93d3:	49 29 c1             	sub    %rax,%r9
    93d6:	4d 29 c8             	sub    %r9,%r8
    93d9:	49 83 dc 00          	sbb    $0x0,%r12
    93dd:	4d 89 c1             	mov    %r8,%r9
    93e0:	4d 0f af cf          	imul   %r15,%r9
    93e4:	4c 89 c0             	mov    %r8,%rax
    93e7:	49 f7 e3             	mul    %r11
    93ea:	4c 01 ca             	add    %r9,%rdx
    93ed:	4d 0f af e3          	imul   %r11,%r12
    93f1:	49 01 d4             	add    %rdx,%r12
    93f4:	48 89 c2             	mov    %rax,%rdx
    93f7:	48 01 c2             	add    %rax,%rdx
    93fa:	48 8d 14 92          	lea    (%rdx,%rdx,4),%rdx
    93fe:	41 89 c8             	mov    %ecx,%r8d
    9401:	41 29 d0             	sub    %edx,%r8d
    9404:	41 80 c8 30          	or     $0x30,%r8b
    9408:	46 88 44 14 40       	mov    %r8b,0x40(%rsp,%r10,1)
    940d:	49 ff c2             	inc    %r10
    9410:	48 83 f9 0a          	cmp    $0xa,%rcx
    9414:	48 83 de 00          	sbb    $0x0,%rsi
    9418:	48 89 c1             	mov    %rax,%rcx
    941b:	4c 89 e6             	mov    %r12,%rsi
    941e:	73 90                	jae    93b0 <fwp_fmt_duration+0x4f0>
    9420:	45 85 d2             	test   %r10d,%r10d
    9423:	0f 8f d2 00 00 00    	jg     94fb <fwp_fmt_duration+0x63b>
    9429:	31 c0                	xor    %eax,%eax
    942b:	e9 12 02 00 00       	jmp    9642 <fwp_fmt_duration+0x782>
    9430:	45 31 c0             	xor    %r8d,%r8d
    9433:	48 f7 d9             	neg    %rcx
    9436:	41 b9 00 00 00 00    	mov    $0x0,%r9d
    943c:	49 19 f1             	sbb    %rsi,%r9
    943f:	c6 04 24 2d          	movb   $0x2d,(%rsp)
    9443:	49 ba cd cc cc cc cc 	movabs $0xcccccccccccccccd,%r10
    944a:	cc cc cc 
    944d:	49 bb cc cc cc cc cc 	movabs $0xcccccccccccccccc,%r11
    9454:	cc cc cc 
    9457:	4d 89 cf             	mov    %r9,%r15
    945a:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)
    9460:	4c 89 ce             	mov    %r9,%rsi
    9463:	48 0f a4 ce 3f       	shld   $0x3f,%rcx,%rsi
    9468:	49 d1 ef             	shr    $1,%r15
    946b:	48 89 f7             	mov    %rsi,%rdi
    946e:	4c 01 ff             	add    %r15,%rdi
    9471:	48 83 d7 00          	adc    $0x0,%rdi
    9475:	48 89 f8             	mov    %rdi,%rax
    9478:	49 f7 e2             	mul    %r10
    947b:	48 c1 ea 02          	shr    $0x2,%rdx
    947f:	48 8d 04 92          	lea    (%rdx,%rdx,4),%rax
    9483:	48 29 c7             	sub    %rax,%rdi
    9486:	48 29 fe             	sub    %rdi,%rsi
    9489:	49 83 df 00          	sbb    $0x0,%r15
    948d:	48 89 f7             	mov    %rsi,%rdi
    9490:	49 0f af fb          	imul   %r11,%rdi
    9494:	48 89 f0             	mov    %rsi,%rax
    9497:	49 f7 e2             	mul    %r10
    949a:	48 01 fa             	add    %rdi,%rdx
    949d:	4d 0f af fa          	imul   %r10,%r15
    94a1:	49 01 d7             	add    %rdx,%r15
    94a4:	48 89 c2             	mov    %rax,%rdx
    94a7:	48 01 c2             	add    %rax,%rdx
    94aa:	48 8d 14 92          	lea    (%rdx,%rdx,4),%rdx
    94ae:	89 ce                	mov    %ecx,%esi
    94b0:	29 d6                	sub    %edx,%esi
    94b2:	40 80 ce 30          	or     $0x30,%sil
    94b6:	42 88 74 04 40       	mov    %sil,0x40(%rsp,%r8,1)
    94bb:	49 ff c0             	inc    %r8
    94be:	48 83 f9 0a          	cmp    $0xa,%rcx
    94c2:	49 83 d9 00          	sbb    $0x0,%r9
    94c6:	48 89 c1             	mov    %rax,%rcx
    94c9:	4d 89 f9             	mov    %r15,%r9
    94cc:	73 92                	jae    9460 <fwp_fmt_duration+0x5a0>
    94ce:	45 85 c0             	test   %r8d,%r8d
    94d1:	4c 89 f7             	mov    %r14,%rdi
    94d4:	7e 44                	jle    951a <fwp_fmt_duration+0x65a>
    94d6:	44 89 c0             	mov    %r8d,%eax
    94d9:	48 83 f8 08          	cmp    $0x8,%rax
    94dd:	0f 83 68 01 00 00    	jae    964b <fwp_fmt_duration+0x78b>
    94e3:	31 c9                	xor    %ecx,%ecx
    94e5:	48 89 c2             	mov    %rax,%rdx
    94e8:	e9 97 02 00 00       	jmp    9784 <fwp_fmt_duration+0x8c4>
    94ed:	c6 44 24 40 30       	movb   $0x30,0x40(%rsp)
    94f2:	41 ba 01 00 00 00    	mov    $0x1,%r10d
    94f8:	4c 89 f7             	mov    %r14,%rdi
    94fb:	44 89 d0             	mov    %r10d,%eax
    94fe:	48 83 f8 08          	cmp    $0x8,%rax
    9502:	73 0a                	jae    950e <fwp_fmt_duration+0x64e>
    9504:	31 c9                	xor    %ecx,%ecx
    9506:	48 89 c2             	mov    %rax,%rdx
    9509:	e9 16 01 00 00       	jmp    9624 <fwp_fmt_duration+0x764>
    950e:	83 f8 20             	cmp    $0x20,%eax
    9511:	73 0e                	jae    9521 <fwp_fmt_duration+0x661>
    9513:	31 c9                	xor    %ecx,%ecx
    9515:	e9 b0 00 00 00       	jmp    95ca <fwp_fmt_duration+0x70a>
    951a:	31 c0                	xor    %eax,%eax
    951c:	e9 93 02 00 00       	jmp    97b4 <fwp_fmt_duration+0x8f4>
    9521:	44 89 d2             	mov    %r10d,%edx
    9524:	83 e2 1f             	and    $0x1f,%edx
    9527:	48 89 c1             	mov    %rax,%rcx
    952a:	48 29 d1             	sub    %rdx,%rcx
    952d:	48 8d 74 24 10       	lea    0x10(%rsp),%rsi
    9532:	66 0f ef c0          	pxor   %xmm0,%xmm0
    9536:	49 89 c0             	mov    %rax,%r8
    9539:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)
    9540:	f3 42 0f 6f 4c 04 20 	movdqu 0x20(%rsp,%r8,1),%xmm1
    9547:	f3 42 0f 6f 54 04 30 	movdqu 0x30(%rsp,%r8,1),%xmm2
    954e:	66 0f 6f da          	movdqa %xmm2,%xmm3
    9552:	66 0f 60 d8          	punpcklbw %xmm0,%xmm3
    9556:	66 0f 70 db 4e       	pshufd $0x4e,%xmm3,%xmm3
    955b:	f2 0f 70 db 1b       	pshuflw $0x1b,%xmm3,%xmm3
    9560:	f3 0f 70 db 1b       	pshufhw $0x1b,%xmm3,%xmm3
    9565:	66 0f 68 d0          	punpckhbw %xmm0,%xmm2
    9569:	66 0f 70 d2 4e       	pshufd $0x4e,%xmm2,%xmm2
    956e:	f2 0f 70 d2 1b       	pshuflw $0x1b,%xmm2,%xmm2
    9573:	f3 0f 70 d2 1b       	pshufhw $0x1b,%xmm2,%xmm2
    9578:	66 0f 67 d3          	packuswb %xmm3,%xmm2
    957c:	66 0f 6f d9          	movdqa %xmm1,%xmm3
    9580:	66 0f 60 d8          	punpcklbw %xmm0,%xmm3
    9584:	66 0f 70 db 4e       	pshufd $0x4e,%xmm3,%xmm3
    9589:	f2 0f 70 db 1b       	pshuflw $0x1b,%xmm3,%xmm3
    958e:	f3 0f 70 db 1b       	pshufhw $0x1b,%xmm3,%xmm3
    9593:	66 0f 68 c8          	punpckhbw %xmm0,%xmm1
    9597:	66 0f 70 c9 4e       	pshufd $0x4e,%xmm1,%xmm1
    959c:	f2 0f 70 c9 1b       	pshuflw $0x1b,%xmm1,%xmm1
    95a1:	f3 0f 70 c9 1b       	pshufhw $0x1b,%xmm1,%xmm1
    95a6:	66 0f 67 cb          	packuswb %xmm3,%xmm1
    95aa:	66 0f 7f 56 f0       	movdqa %xmm2,-0x10(%rsi)
    95af:	66 0f 7f 0e          	movdqa %xmm1,(%rsi)
    95b3:	49 83 c0 e0          	add    $0xffffffffffffffe0,%r8
    95b7:	48 83 c6 20          	add    $0x20,%rsi
    95bb:	4c 39 c2             	cmp    %r8,%rdx
    95be:	75 80                	jne    9540 <fwp_fmt_duration+0x680>
    95c0:	48 85 d2             	test   %rdx,%rdx
    95c3:	74 7d                	je     9642 <fwp_fmt_duration+0x782>
    95c5:	83 fa 08             	cmp    $0x8,%edx
    95c8:	72 5a                	jb     9624 <fwp_fmt_duration+0x764>
    95ca:	44 89 d2             	mov    %r10d,%edx
    95cd:	83 e2 07             	and    $0x7,%edx
    95d0:	48 89 c6             	mov    %rax,%rsi
    95d3:	48 29 ce             	sub    %rcx,%rsi
    95d6:	4c 8d 04 0c          	lea    (%rsp,%rcx,1),%r8
    95da:	48 89 c1             	mov    %rax,%rcx
    95dd:	48 29 d1             	sub    %rdx,%rcx
    95e0:	66 0f ef c0          	pxor   %xmm0,%xmm0
    95e4:	66 66 66 2e 0f 1f 84 	data16 data16 cs nopw 0x0(%rax,%rax,1)
    95eb:	00 00 00 00 00 
    95f0:	f3 0f 7e 4c 34 38    	movq   0x38(%rsp,%rsi,1),%xmm1
    95f6:	66 0f 60 c8          	punpcklbw %xmm0,%xmm1
    95fa:	66 0f 70 c9 4e       	pshufd $0x4e,%xmm1,%xmm1
    95ff:	f2 0f 70 c9 1b       	pshuflw $0x1b,%xmm1,%xmm1
    9604:	f3 0f 70 c9 1b       	pshufhw $0x1b,%xmm1,%xmm1
    9609:	66 0f 67 c9          	packuswb %xmm1,%xmm1
    960d:	66 41 0f d6 08       	movq   %xmm1,(%r8)
    9612:	48 83 c6 f8          	add    $0xfffffffffffffff8,%rsi
    9616:	49 83 c0 08          	add    $0x8,%r8
    961a:	48 39 f2             	cmp    %rsi,%rdx
    961d:	75 d1                	jne    95f0 <fwp_fmt_duration+0x730>
    961f:	48 85 d2             	test   %rdx,%rdx
    9622:	74 1e                	je     9642 <fwp_fmt_duration+0x782>
    9624:	48 8d 74 24 40       	lea    0x40(%rsp),%rsi
    9629:	48 01 f2             	add    %rsi,%rdx
    962c:	48 ff ca             	dec    %rdx
    962f:	90                   	nop
    9630:	0f b6 32             	movzbl (%rdx),%esi
    9633:	40 88 34 0c          	mov    %sil,(%rsp,%rcx,1)
    9637:	48 ff c1             	inc    %rcx
    963a:	48 ff ca             	dec    %rdx
    963d:	48 39 c8             	cmp    %rcx,%rax
    9640:	75 ee                	jne    9630 <fwp_fmt_duration+0x770>
    9642:	c6 04 04 00          	movb   $0x0,(%rsp,%rax,1)
    9646:	e9 6e 01 00 00       	jmp    97b9 <fwp_fmt_duration+0x8f9>
    964b:	83 f8 20             	cmp    $0x20,%eax
    964e:	73 07                	jae    9657 <fwp_fmt_duration+0x797>
    9650:	31 c9                	xor    %ecx,%ecx
    9652:	e9 bd 00 00 00       	jmp    9714 <fwp_fmt_duration+0x854>
    9657:	44 89 c6             	mov    %r8d,%esi
    965a:	44 89 c2             	mov    %r8d,%edx
    965d:	83 e2 1f             	and    $0x1f,%edx
    9660:	48 89 c1             	mov    %rax,%rcx
    9663:	48 29 d1             	sub    %rdx,%rcx
    9666:	4c 8d 0c 34          	lea    (%rsp,%rsi,1),%r9
    966a:	49 83 c1 30          	add    $0x30,%r9
    966e:	48 29 d6             	sub    %rdx,%rsi
    9671:	45 31 d2             	xor    %r10d,%r10d
    9674:	66 0f ef c0          	pxor   %xmm0,%xmm0
    9678:	0f 1f 84 00 00 00 00 	nopl   0x0(%rax,%rax,1)
    967f:	00 
    9680:	f3 41 0f 6f 49 f0    	movdqu -0x10(%r9),%xmm1
    9686:	f3 41 0f 6f 11       	movdqu (%r9),%xmm2
    968b:	66 0f 6f da          	movdqa %xmm2,%xmm3
    968f:	66 0f 60 d8          	punpcklbw %xmm0,%xmm3
    9693:	66 0f 70 db 4e       	pshufd $0x4e,%xmm3,%xmm3
    9698:	f2 0f 70 db 1b       	pshuflw $0x1b,%xmm3,%xmm3
    969d:	f3 0f 70 db 1b       	pshufhw $0x1b,%xmm3,%xmm3
    96a2:	66 0f 68 d0          	punpckhbw %xmm0,%xmm2
    96a6:	66 0f 70 d2 4e       	pshufd $0x4e,%xmm2,%xmm2
    96ab:	f2 0f 70 d2 1b       	pshuflw $0x1b,%xmm2,%xmm2
    96b0:	f3 0f 70 d2 1b       	pshufhw $0x1b,%xmm2,%xmm2
    96b5:	66 0f 67 d3          	packuswb %xmm3,%xmm2
    96b9:	66 0f 6f d9          	movdqa %xmm1,%xmm3
    96bd:	66 0f 60 d8          	punpcklbw %xmm0,%xmm3
    96c1:	66 0f 70 db 4e       	pshufd $0x4e,%xmm3,%xmm3
    96c6:	f2 0f 70 db 1b       	pshuflw $0x1b,%xmm3,%xmm3
    96cb:	f3 0f 70 db 1b       	pshufhw $0x1b,%xmm3,%xmm3
    96d0:	66 0f 68 c8          	punpckhbw %xmm0,%xmm1
    96d4:	66 0f 70 c9 4e       	pshufd $0x4e,%xmm1,%xmm1
    96d9:	f2 0f 70 c9 1b       	pshuflw $0x1b,%xmm1,%xmm1
    96de:	f3 0f 70 c9 1b       	pshufhw $0x1b,%xmm1,%xmm1
    96e3:	66 0f 67 cb          	packuswb %xmm3,%xmm1
    96e7:	f3 42 0f 7f 54 14 01 	movdqu %xmm2,0x1(%rsp,%r10,1)
    96ee:	f3 42 0f 7f 4c 14 11 	movdqu %xmm1,0x11(%rsp,%r10,1)
    96f5:	49 83 c2 20          	add    $0x20,%r10
    96f9:	49 83 c1 e0          	add    $0xffffffffffffffe0,%r9
    96fd:	4c 39 d6             	cmp    %r10,%rsi
    9700:	0f 85 7a ff ff ff    	jne    9680 <fwp_fmt_duration+0x7c0>
    9706:	48 85 d2             	test   %rdx,%rdx
    9709:	0f 84 a5 00 00 00    	je     97b4 <fwp_fmt_duration+0x8f4>
    970f:	83 fa 08             	cmp    $0x8,%edx
    9712:	72 70                	jb     9784 <fwp_fmt_duration+0x8c4>
    9714:	48 89 ce             	mov    %rcx,%rsi
    9717:	45 89 c1             	mov    %r8d,%r9d
    971a:	44 89 c2             	mov    %r8d,%edx
    971d:	83 e2 07             	and    $0x7,%edx
    9720:	48 89 c1             	mov    %rax,%rcx
    9723:	48 29 d1             	sub    %rdx,%rcx
    9726:	49 89 f2             	mov    %rsi,%r10
    9729:	49 f7 da             	neg    %r10
    972c:	49 01 e2             	add    %rsp,%r10
    972f:	49 83 c2 40          	add    $0x40,%r10
    9733:	4d 01 ca             	add    %r9,%r10
    9736:	49 83 c2 f8          	add    $0xfffffffffffffff8,%r10
    973a:	49 29 d1             	sub    %rdx,%r9
    973d:	66 0f ef c0          	pxor   %xmm0,%xmm0
    9741:	66 66 66 66 66 66 2e 	data16 data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    9748:	0f 1f 84 00 00 00 00 
    974f:	00 
    9750:	f3 41 0f 7e 0a       	movq   (%r10),%xmm1
    9755:	66 0f 60 c8          	punpcklbw %xmm0,%xmm1
    9759:	66 0f 70 c9 4e       	pshufd $0x4e,%xmm1,%xmm1
    975e:	f2 0f 70 c9 1b       	pshuflw $0x1b,%xmm1,%xmm1
    9763:	f3 0f 70 c9 1b       	pshufhw $0x1b,%xmm1,%xmm1
    9768:	66 0f 67 c9          	packuswb %xmm1,%xmm1
    976c:	66 0f d6 4c 34 01    	movq   %xmm1,0x1(%rsp,%rsi,1)
    9772:	48 83 c6 08          	add    $0x8,%rsi
    9776:	49 83 c2 f8          	add    $0xfffffffffffffff8,%r10
    977a:	49 39 f1             	cmp    %rsi,%r9
    977d:	75 d1                	jne    9750 <fwp_fmt_duration+0x890>
    977f:	48 85 d2             	test   %rdx,%rdx
    9782:	74 30                	je     97b4 <fwp_fmt_duration+0x8f4>
    9784:	48 8d 74 24 40       	lea    0x40(%rsp),%rsi
    9789:	48 01 f2             	add    %rsi,%rdx
    978c:	48 ff ca             	dec    %rdx
    978f:	44 89 c6             	mov    %r8d,%esi
    9792:	66 66 66 66 66 2e 0f 	data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    9799:	1f 84 00 00 00 00 00 
    97a0:	44 0f b6 02          	movzbl (%rdx),%r8d
    97a4:	44 88 44 0c 01       	mov    %r8b,0x1(%rsp,%rcx,1)
    97a9:	48 ff c1             	inc    %rcx
    97ac:	48 ff ca             	dec    %rdx
    97af:	48 39 ce             	cmp    %rcx,%rsi
    97b2:	75 ec                	jne    97a0 <fwp_fmt_duration+0x8e0>
    97b4:	c6 44 04 01 00       	movb   $0x0,0x1(%rsp,%rax,1)
    97b9:	48 8b 0b             	mov    (%rbx),%rcx
    97bc:	48 8d 35 be 5e 00 00 	lea    0x5ebe(%rip),%rsi        # f681 <fwp_segv.msg+0x441>
    97c3:	48 89 e2             	mov    %rsp,%rdx
    97c6:	31 c0                	xor    %eax,%eax
    97c8:	e8 b3 8a ff ff       	call   2280 <sprintf@plt>
    97cd:	48 81 c4 88 00 00 00 	add    $0x88,%rsp
    97d4:	5b                   	pop    %rbx
    97d5:	41 5c                	pop    %r12
    97d7:	41 5e                	pop    %r14
    97d9:	41 5f                	pop    %r15
    97db:	c3                   	ret
    97dc:	45 31 c9             	xor    %r9d,%r9d
    97df:	48 f7 de             	neg    %rsi
    97e2:	41 ba 00 00 00 00    	mov    $0x0,%r10d
    97e8:	4d 19 c2             	sbb    %r8,%r10
    97eb:	c6 04 24 2d          	movb   $0x2d,(%rsp)
    97ef:	49 bb cd cc cc cc cc 	movabs $0xcccccccccccccccd,%r11
    97f6:	cc cc cc 
    97f9:	48 bb cc cc cc cc cc 	movabs $0xcccccccccccccccc,%rbx
    9800:	cc cc cc 
    9803:	4d 89 d6             	mov    %r10,%r14
    9806:	66 2e 0f 1f 84 00 00 	cs nopw 0x0(%rax,%rax,1)
    980d:	00 00 00 
    9810:	4c 89 d1             	mov    %r10,%rcx
    9813:	48 0f a4 f1 3f       	shld   $0x3f,%rsi,%rcx
    9818:	49 d1 ee             	shr    $1,%r14
    981b:	49 89 c8             	mov    %rcx,%r8
    981e:	4d 01 f0             	add    %r14,%r8
    9821:	49 83 d0 00          	adc    $0x0,%r8
    9825:	4c 89 c0             	mov    %r8,%rax
    9828:	49 f7 e3             	mul    %r11
    982b:	48 c1 ea 02          	shr    $0x2,%rdx
    982f:	48 8d 04 92          	lea    (%rdx,%rdx,4),%rax
    9833:	49 29 c0             	sub    %rax,%r8
    9836:	4c 29 c1             	sub    %r8,%rcx
    9839:	49 83 de 00          	sbb    $0x0,%r14
    983d:	49 89 c8             	mov    %rcx,%r8
    9840:	4c 0f af c3          	imul   %rbx,%r8
    9844:	48 89 c8             	mov    %rcx,%rax
    9847:	49 f7 e3             	mul    %r11
    984a:	4c 01 c2             	add    %r8,%rdx
    984d:	4d 0f af f3          	imul   %r11,%r14
    9851:	49 01 d6             	add    %rdx,%r14
    9854:	48 89 c1             	mov    %rax,%rcx
    9857:	48 01 c1             	add    %rax,%rcx
    985a:	48 8d 0c 89          	lea    (%rcx,%rcx,4),%rcx
    985e:	89 f2                	mov    %esi,%edx
    9860:	29 ca                	sub    %ecx,%edx
    9862:	80 ca 30             	or     $0x30,%dl
    9865:	42 88 54 0c 40       	mov    %dl,0x40(%rsp,%r9,1)
    986a:	49 ff c1             	inc    %r9
    986d:	48 83 fe 0a          	cmp    $0xa,%rsi
    9871:	49 83 da 00          	sbb    $0x0,%r10
    9875:	48 89 c6             	mov    %rax,%rsi
    9878:	4d 89 f2             	mov    %r14,%r10
    987b:	73 93                	jae    9810 <fwp_fmt_duration+0x950>
    987d:	45 85 c9             	test   %r9d,%r9d
    9880:	7e 13                	jle    9895 <fwp_fmt_duration+0x9d5>
    9882:	44 89 c8             	mov    %r9d,%eax
    9885:	48 83 f8 08          	cmp    $0x8,%rax
    9889:	73 11                	jae    989c <fwp_fmt_duration+0x9dc>
    988b:	31 c9                	xor    %ecx,%ecx
    988d:	48 89 c2             	mov    %rax,%rdx
    9890:	e9 29 01 00 00       	jmp    99be <fwp_fmt_duration+0xafe>
    9895:	31 c0                	xor    %eax,%eax
    9897:	e9 48 01 00 00       	jmp    99e4 <fwp_fmt_duration+0xb24>
    989c:	83 f8 20             	cmp    $0x20,%eax
    989f:	73 07                	jae    98a8 <fwp_fmt_duration+0x9e8>
    98a1:	31 c9                	xor    %ecx,%ecx
    98a3:	e9 b5 00 00 00       	jmp    995d <fwp_fmt_duration+0xa9d>
    98a8:	44 89 ce             	mov    %r9d,%esi
    98ab:	44 89 ca             	mov    %r9d,%edx
    98ae:	83 e2 1f             	and    $0x1f,%edx
    98b1:	48 89 c1             	mov    %rax,%rcx
    98b4:	48 29 d1             	sub    %rdx,%rcx
    98b7:	4c 8d 04 34          	lea    (%rsp,%rsi,1),%r8
    98bb:	49 83 c0 30          	add    $0x30,%r8
    98bf:	48 29 d6             	sub    %rdx,%rsi
    98c2:	45 31 d2             	xor    %r10d,%r10d
    98c5:	66 0f ef c0          	pxor   %xmm0,%xmm0
    98c9:	f3 41 0f 6f 48 f0    	movdqu -0x10(%r8),%xmm1
    98cf:	f3 41 0f 6f 10       	movdqu (%r8),%xmm2
    98d4:	66 0f 6f da          	movdqa %xmm2,%xmm3
    98d8:	66 0f 60 d8          	punpcklbw %xmm0,%xmm3
    98dc:	66 0f 70 db 4e       	pshufd $0x4e,%xmm3,%xmm3
    98e1:	f2 0f 70 db 1b       	pshuflw $0x1b,%xmm3,%xmm3
    98e6:	f3 0f 70 db 1b       	pshufhw $0x1b,%xmm3,%xmm3
    98eb:	66 0f 68 d0          	punpckhbw %xmm0,%xmm2
    98ef:	66 0f 70 d2 4e       	pshufd $0x4e,%xmm2,%xmm2
    98f4:	f2 0f 70 d2 1b       	pshuflw $0x1b,%xmm2,%xmm2
    98f9:	f3 0f 70 d2 1b       	pshufhw $0x1b,%xmm2,%xmm2
    98fe:	66 0f 67 d3          	packuswb %xmm3,%xmm2
    9902:	66 0f 6f d9          	movdqa %xmm1,%xmm3
    9906:	66 0f 60 d8          	punpcklbw %xmm0,%xmm3
    990a:	66 0f 70 db 4e       	pshufd $0x4e,%xmm3,%xmm3
    990f:	f2 0f 70 db 1b       	pshuflw $0x1b,%xmm3,%xmm3
    9914:	f3 0f 70 db 1b       	pshufhw $0x1b,%xmm3,%xmm3
    9919:	66 0f 68 c8          	punpckhbw %xmm0,%xmm1
    991d:	66 0f 70 c9 4e       	pshufd $0x4e,%xmm1,%xmm1
    9922:	f2 0f 70 c9 1b       	pshuflw $0x1b,%xmm1,%xmm1
    9927:	f3 0f 70 c9 1b       	pshufhw $0x1b,%xmm1,%xmm1
    992c:	66 0f 67 cb          	packuswb %xmm3,%xmm1
    9930:	f3 42 0f 7f 54 14 01 	movdqu %xmm2,0x1(%rsp,%r10,1)
    9937:	f3 42 0f 7f 4c 14 11 	movdqu %xmm1,0x11(%rsp,%r10,1)
    993e:	49 83 c2 20          	add    $0x20,%r10
    9942:	49 83 c0 e0          	add    $0xffffffffffffffe0,%r8
    9946:	4c 39 d6             	cmp    %r10,%rsi
    9949:	0f 85 7a ff ff ff    	jne    98c9 <fwp_fmt_duration+0xa09>
    994f:	48 85 d2             	test   %rdx,%rdx
    9952:	0f 84 8c 00 00 00    	je     99e4 <fwp_fmt_duration+0xb24>
    9958:	83 fa 08             	cmp    $0x8,%edx
    995b:	72 61                	jb     99be <fwp_fmt_duration+0xafe>
    995d:	48 89 ce             	mov    %rcx,%rsi
    9960:	45 89 c8             	mov    %r9d,%r8d
    9963:	44 89 ca             	mov    %r9d,%edx
    9966:	83 e2 07             	and    $0x7,%edx
    9969:	48 89 c1             	mov    %rax,%rcx
    996c:	48 29 d1             	sub    %rdx,%rcx
    996f:	49 89 f2             	mov    %rsi,%r10
    9972:	49 f7 da             	neg    %r10
    9975:	49 01 e2             	add    %rsp,%r10
    9978:	49 83 c2 40          	add    $0x40,%r10
    997c:	4d 01 c2             	add    %r8,%r10
    997f:	49 83 c2 f8          	add    $0xfffffffffffffff8,%r10
    9983:	49 29 d0             	sub    %rdx,%r8
    9986:	66 0f ef c0          	pxor   %xmm0,%xmm0
    998a:	f3 41 0f 7e 0a       	movq   (%r10),%xmm1
    998f:	66 0f 60 c8          	punpcklbw %xmm0,%xmm1
    9993:	66 0f 70 c9 4e       	pshufd $0x4e,%xmm1,%xmm1
    9998:	f2 0f 70 c9 1b       	pshuflw $0x1b,%xmm1,%xmm1
    999d:	f3 0f 70 c9 1b       	pshufhw $0x1b,%xmm1,%xmm1
    99a2:	66 0f 67 c9          	packuswb %xmm1,%xmm1
    99a6:	66 0f d6 4c 34 01    	movq   %xmm1,0x1(%rsp,%rsi,1)
    99ac:	48 83 c6 08          	add    $0x8,%rsi
    99b0:	49 83 c2 f8          	add    $0xfffffffffffffff8,%r10
    99b4:	49 39 f0             	cmp    %rsi,%r8
    99b7:	75 d1                	jne    998a <fwp_fmt_duration+0xaca>
    99b9:	48 85 d2             	test   %rdx,%rdx
    99bc:	74 26                	je     99e4 <fwp_fmt_duration+0xb24>
    99be:	48 8d 74 24 40       	lea    0x40(%rsp),%rsi
    99c3:	48 01 f2             	add    %rsi,%rdx
    99c6:	48 ff ca             	dec    %rdx
    99c9:	44 89 ce             	mov    %r9d,%esi
    99cc:	0f 1f 40 00          	nopl   0x0(%rax)
    99d0:	44 0f b6 02          	movzbl (%rdx),%r8d
    99d4:	44 88 44 0c 01       	mov    %r8b,0x1(%rsp,%rcx,1)
    99d9:	48 ff c1             	inc    %rcx
    99dc:	48 ff ca             	dec    %rdx
    99df:	48 39 ce             	cmp    %rcx,%rsi
    99e2:	75 ec                	jne    99d0 <fwp_fmt_duration+0xb10>
    99e4:	c6 44 04 01 00       	movb   $0x0,0x1(%rsp,%rax,1)
    99e9:	e9 28 f9 ff ff       	jmp    9316 <fwp_fmt_duration+0x456>
    99ee:	66 90                	xchg   %ax,%ax

00000000000099f0 <fwp_format_g>:
    99f0:	55                   	push   %rbp
    99f1:	41 57                	push   %r15
    99f3:	41 56                	push   %r14
    99f5:	41 55                	push   %r13
    99f7:	41 54                	push   %r12
    99f9:	53                   	push   %rbx
    99fa:	48 81 ec 98 00 00 00 	sub    $0x98,%rsp
    9a01:	89 f5                	mov    %esi,%ebp
    9a03:	48 89 fb             	mov    %rdi,%rbx
    9a06:	ff cd                	dec    %ebp
    9a08:	48 8d 15 3e 5c 00 00 	lea    0x5c3e(%rip),%rdx        # f64d <fwp_segv.msg+0x40d>
    9a0f:	4c 8d 64 24 50       	lea    0x50(%rsp),%r12
    9a14:	be 40 00 00 00       	mov    $0x40,%esi
    9a19:	4c 89 e7             	mov    %r12,%rdi
    9a1c:	89 e9                	mov    %ebp,%ecx
    9a1e:	f2 0f 11 44 24 08    	movsd  %xmm0,0x8(%rsp)
    9a24:	b0 01                	mov    $0x1,%al
    9a26:	e8 e5 86 ff ff       	call   2110 <snprintf@plt>
    9a2b:	4c 89 e7             	mov    %r12,%rdi
    9a2e:	be 65 00 00 00       	mov    $0x65,%esi
    9a33:	e8 c8 86 ff ff       	call   2100 <strchr@plt>
    9a38:	49 89 c7             	mov    %rax,%r15
    9a3b:	48 8d 78 01          	lea    0x1(%rax),%rdi
    9a3f:	45 31 ed             	xor    %r13d,%r13d
    9a42:	31 f6                	xor    %esi,%esi
    9a44:	ba 0a 00 00 00       	mov    $0xa,%edx
    9a49:	e8 82 87 ff ff       	call   21d0 <strtol@plt>
    9a4e:	49 89 c6             	mov    %rax,%r14
    9a51:	83 c0 ef             	add    $0xffffffef,%eax
    9a54:	83 f8 e9             	cmp    $0xffffffe9,%eax
    9a57:	77 5f                	ja     9ab8 <fwp_format_g+0xc8>
    9a59:	4d 29 e7             	sub    %r12,%r15
    9a5c:	4c 8d 6c 24 10       	lea    0x10(%rsp),%r13
    9a61:	4c 89 ef             	mov    %r13,%rdi
    9a64:	4c 89 e6             	mov    %r12,%rsi
    9a67:	4c 89 fa             	mov    %r15,%rdx
    9a6a:	e8 71 87 ff ff       	call   21e0 <memcpy@plt>
    9a6f:	42 c6 44 3c 10 00    	movb   $0x0,0x10(%rsp,%r15,1)
    9a75:	4c 89 ef             	mov    %r13,%rdi
    9a78:	be 2e 00 00 00       	mov    $0x2e,%esi
    9a7d:	e8 7e 86 ff ff       	call   2100 <strchr@plt>
    9a82:	48 85 c0             	test   %rax,%rax
    9a85:	0f 84 a8 00 00 00    	je     9b33 <fwp_format_g+0x143>
    9a8b:	4d 85 ff             	test   %r15,%r15
    9a8e:	0f 84 9f 00 00 00    	je     9b33 <fwp_format_g+0x143>
    9a94:	66 66 66 2e 0f 1f 84 	data16 data16 cs nopw 0x0(%rax,%rax,1)
    9a9b:	00 00 00 00 00 
    9aa0:	42 0f b6 44 3c 0f    	movzbl 0xf(%rsp,%r15,1),%eax
    9aa6:	83 f8 30             	cmp    $0x30,%eax
    9aa9:	75 7d                	jne    9b28 <fwp_format_g+0x138>
    9aab:	42 c6 44 3c 0f 00    	movb   $0x0,0xf(%rsp,%r15,1)
    9ab1:	49 ff cf             	dec    %r15
    9ab4:	75 ea                	jne    9aa0 <fwp_format_g+0xb0>
    9ab6:	eb 7b                	jmp    9b33 <fwp_format_g+0x143>
    9ab8:	44 29 f5             	sub    %r14d,%ebp
    9abb:	85 ed                	test   %ebp,%ebp
    9abd:	44 0f 4f ed          	cmovg  %ebp,%r13d
    9ac1:	48 8d 15 94 5b 00 00 	lea    0x5b94(%rip),%rdx        # f65c <fwp_segv.msg+0x41c>
    9ac8:	be 90 01 00 00       	mov    $0x190,%esi
    9acd:	48 89 df             	mov    %rbx,%rdi
    9ad0:	44 89 e9             	mov    %r13d,%ecx
    9ad3:	f2 0f 10 44 24 08    	movsd  0x8(%rsp),%xmm0
    9ad9:	b0 01                	mov    $0x1,%al
    9adb:	e8 30 86 ff ff       	call   2110 <snprintf@plt>
    9ae0:	48 89 df             	mov    %rbx,%rdi
    9ae3:	e8 f8 85 ff ff       	call   20e0 <strlen@plt>
    9ae8:	49 89 c6             	mov    %rax,%r14
    9aeb:	48 89 df             	mov    %rbx,%rdi
    9aee:	be 2e 00 00 00       	mov    $0x2e,%esi
    9af3:	e8 08 86 ff ff       	call   2100 <strchr@plt>
    9af8:	48 85 c0             	test   %rax,%rax
    9afb:	74 69                	je     9b66 <fwp_format_g+0x176>
    9afd:	4d 85 f6             	test   %r14,%r14
    9b00:	74 64                	je     9b66 <fwp_format_g+0x176>
    9b02:	66 66 66 66 66 2e 0f 	data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    9b09:	1f 84 00 00 00 00 00 
    9b10:	42 0f b6 44 33 ff    	movzbl -0x1(%rbx,%r14,1),%eax
    9b16:	83 f8 30             	cmp    $0x30,%eax
    9b19:	75 5d                	jne    9b78 <fwp_format_g+0x188>
    9b1b:	42 c6 44 33 ff 00    	movb   $0x0,-0x1(%rbx,%r14,1)
    9b21:	49 ff ce             	dec    %r14
    9b24:	75 ea                	jne    9b10 <fwp_format_g+0x120>
    9b26:	eb 3e                	jmp    9b66 <fwp_format_g+0x176>
    9b28:	83 f8 2e             	cmp    $0x2e,%eax
    9b2b:	75 06                	jne    9b33 <fwp_format_g+0x143>
    9b2d:	42 c6 44 3c 0f 00    	movb   $0x0,0xf(%rsp,%r15,1)
    9b33:	44 89 f0             	mov    %r14d,%eax
    9b36:	c1 e8 1f             	shr    $0x1f,%eax
    9b39:	44 8d 04 45 2b 00 00 	lea    0x2b(,%rax,2),%r8d
    9b40:	00 
    9b41:	45 89 f1             	mov    %r14d,%r9d
    9b44:	41 f7 d9             	neg    %r9d
    9b47:	45 0f 48 ce          	cmovs  %r14d,%r9d
    9b4b:	48 8d 15 00 5b 00 00 	lea    0x5b00(%rip),%rdx        # f652 <fwp_segv.msg+0x412>
    9b52:	48 8d 4c 24 10       	lea    0x10(%rsp),%rcx
    9b57:	be 90 01 00 00       	mov    $0x190,%esi
    9b5c:	48 89 df             	mov    %rbx,%rdi
    9b5f:	31 c0                	xor    %eax,%eax
    9b61:	e8 aa 85 ff ff       	call   2110 <snprintf@plt>
    9b66:	48 81 c4 98 00 00 00 	add    $0x98,%rsp
    9b6d:	5b                   	pop    %rbx
    9b6e:	41 5c                	pop    %r12
    9b70:	41 5d                	pop    %r13
    9b72:	41 5e                	pop    %r14
    9b74:	41 5f                	pop    %r15
    9b76:	5d                   	pop    %rbp
    9b77:	c3                   	ret
    9b78:	83 f8 2e             	cmp    $0x2e,%eax
    9b7b:	75 e9                	jne    9b66 <fwp_format_g+0x176>
    9b7d:	42 c6 44 33 ff 00    	movb   $0x0,-0x1(%rbx,%r14,1)
    9b83:	eb e1                	jmp    9b66 <fwp_format_g+0x176>
    9b85:	66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
    9b8c:	00 00 00 00 

0000000000009b90 <fwp_show_i64>:
    9b90:	41 57                	push   %r15
    9b92:	41 56                	push   %r14
    9b94:	53                   	push   %rbx
    9b95:	48 83 ec 20          	sub    $0x20,%rsp
    9b99:	48 be 00 00 00 00 01 	movabs $0x100000000,%rsi
    9ba0:	00 00 00 
    9ba3:	48 89 f9             	mov    %rdi,%rcx
    9ba6:	48 f7 d9             	neg    %rcx
    9ba9:	48 0f 48 cf          	cmovs  %rdi,%rcx
    9bad:	48 8d 5c 24 18       	lea    0x18(%rsp),%rbx
    9bb2:	4c 8d 44 24 17       	lea    0x17(%rsp),%r8
    9bb7:	45 31 f6             	xor    %r14d,%r14d
    9bba:	49 b9 cd cc cc cc cc 	movabs $0xcccccccccccccccd,%r9
    9bc1:	cc cc cc 
    9bc4:	66 66 66 2e 0f 1f 84 	data16 data16 cs nopw 0x0(%rax,%rax,1)
    9bcb:	00 00 00 00 00 
    9bd0:	48 89 c8             	mov    %rcx,%rax
    9bd3:	49 f7 e1             	mul    %r9
    9bd6:	48 c1 ea 03          	shr    $0x3,%rdx
    9bda:	8d 04 12             	lea    (%rdx,%rdx,1),%eax
    9bdd:	8d 04 80             	lea    (%rax,%rax,4),%eax
    9be0:	41 89 ca             	mov    %ecx,%r10d
    9be3:	41 29 c2             	sub    %eax,%r10d
    9be6:	41 80 ca 30          	or     $0x30,%r10b
    9bea:	45 88 10             	mov    %r10b,(%r8)
    9bed:	49 01 f6             	add    %rsi,%r14
    9bf0:	49 ff c8             	dec    %r8
    9bf3:	48 83 f9 09          	cmp    $0x9,%rcx
    9bf7:	48 89 d1             	mov    %rdx,%rcx
    9bfa:	77 d4                	ja     9bd0 <fwp_show_i64+0x40>
    9bfc:	48 85 ff             	test   %rdi,%rdi
    9bff:	78 06                	js     9c07 <fwp_show_i64+0x77>
    9c01:	49 c1 fe 20          	sar    $0x20,%r14
    9c05:	eb 11                	jmp    9c18 <fwp_show_i64+0x88>
    9c07:	49 01 f6             	add    %rsi,%r14
    9c0a:	49 c1 fe 20          	sar    $0x20,%r14
    9c0e:	48 89 e0             	mov    %rsp,%rax
    9c11:	4c 29 f0             	sub    %r14,%rax
    9c14:	c6 40 18 2d          	movb   $0x2d,0x18(%rax)
    9c18:	49 8d 56 09          	lea    0x9(%r14),%rdx
    9c1c:	48 81 fa 00 40 00 00 	cmp    $0x4000,%rdx
    9c23:	77 61                	ja     9c86 <fwp_show_i64+0xf6>
    9c25:	49 8d 4e 18          	lea    0x18(%r14),%rcx
    9c29:	48 c1 e9 04          	shr    $0x4,%rcx
    9c2d:	48 8d 05 4c 85 00 00 	lea    0x854c(%rip),%rax        # 12180 <fwp_gc>
    9c34:	0f b6 b4 01 e8 0b 00 	movzbl 0xbe8(%rcx,%rax,1),%esi
    9c3b:	00 
    9c3c:	8b 8c b0 48 0b 00 00 	mov    0xb48(%rax,%rsi,4),%ecx
    9c43:	48 29 0d 36 85 00 00 	sub    %rcx,0x8536(%rip)        # 12180 <fwp_gc>
    9c4a:	78 3a                	js     9c86 <fwp_show_i64+0xf6>
    9c4c:	48 8d 34 76          	lea    (%rsi,%rsi,2),%rsi
    9c50:	48 8d 3c f0          	lea    (%rax,%rsi,8),%rdi
    9c54:	48 81 c7 c8 03 00 00 	add    $0x3c8,%rdi
    9c5b:	4c 8b 3f             	mov    (%rdi),%r15
    9c5e:	4d 85 ff             	test   %r15,%r15
    9c61:	74 0b                	je     9c6e <fwp_show_i64+0xde>
    9c63:	49 8b 07             	mov    (%r15),%rax
    9c66:	48 f7 d0             	not    %rax
    9c69:	48 89 07             	mov    %rax,(%rdi)
    9c6c:	eb 3a                	jmp    9ca8 <fwp_show_i64+0x118>
    9c6e:	4c 8b bc f0 d0 03 00 	mov    0x3d0(%rax,%rsi,8),%r15
    9c75:	00 
    9c76:	48 8b bc f0 d8 03 00 	mov    0x3d8(%rax,%rsi,8),%rdi
    9c7d:	00 
    9c7e:	4c 29 ff             	sub    %r15,%rdi
    9c81:	48 39 cf             	cmp    %rcx,%rdi
    9c84:	73 12                	jae    9c98 <fwp_show_i64+0x108>
    9c86:	48 89 d7             	mov    %rdx,%rdi
    9c89:	be 01 00 00 00       	mov    $0x1,%esi
    9c8e:	e8 ed ca ff ff       	call   6780 <fwp_gc_alloc_slow>
    9c93:	49 89 c7             	mov    %rax,%r15
    9c96:	eb 1a                	jmp    9cb2 <fwp_show_i64+0x122>
    9c98:	48 8d 04 f0          	lea    (%rax,%rsi,8),%rax
    9c9c:	48 05 d0 03 00 00    	add    $0x3d0,%rax
    9ca2:	4c 01 f9             	add    %r15,%rcx
    9ca5:	48 89 08             	mov    %rcx,(%rax)
    9ca8:	4c 89 ff             	mov    %r15,%rdi
    9cab:	31 f6                	xor    %esi,%esi
    9cad:	e8 7e 84 ff ff       	call   2130 <memset@plt>
    9cb2:	4c 29 f3             	sub    %r14,%rbx
    9cb5:	4d 89 37             	mov    %r14,(%r15)
    9cb8:	49 8d 7f 08          	lea    0x8(%r15),%rdi
    9cbc:	48 89 de             	mov    %rbx,%rsi
    9cbf:	4c 89 f2             	mov    %r14,%rdx
    9cc2:	e8 19 85 ff ff       	call   21e0 <memcpy@plt>
    9cc7:	43 c6 44 37 08 00    	movb   $0x0,0x8(%r15,%r14,1)
    9ccd:	4c 89 f8             	mov    %r15,%rax
    9cd0:	48 83 c4 20          	add    $0x20,%rsp
    9cd4:	5b                   	pop    %rbx
    9cd5:	41 5e                	pop    %r14
    9cd7:	41 5f                	pop    %r15
    9cd9:	c3                   	ret
    9cda:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)

0000000000009ce0 <fwp_p_array_get_typed>:
    9ce0:	48 85 ff             	test   %rdi,%rdi
    9ce3:	78 3e                	js     9d23 <fwp_p_array_get_typed+0x43>
    9ce5:	48 8b 0e             	mov    (%rsi),%rcx
    9ce8:	48 b8 ff ff ff ff ff 	movabs $0x7fffffffffffffff,%rax
    9cef:	ff ff 7f 
    9cf2:	48 21 c8             	and    %rcx,%rax
    9cf5:	48 39 f8             	cmp    %rdi,%rax
    9cf8:	76 29                	jbe    9d23 <fwp_p_array_get_typed+0x43>
    9cfa:	b8 08 00 00 00       	mov    $0x8,%eax
    9cff:	48 85 d2             	test   %rdx,%rdx
    9d02:	74 14                	je     9d18 <fwp_p_array_get_typed+0x38>
    9d04:	44 8b 02             	mov    (%rdx),%r8d
    9d07:	49 83 f8 0a          	cmp    $0xa,%r8
    9d0b:	77 0b                	ja     9d18 <fwp_p_array_get_typed+0x38>
    9d0d:	48 8d 05 a4 55 00 00 	lea    0x55a4(%rip),%rax        # f2b8 <fwp_segv.msg+0x78>
    9d14:	4a 8b 04 c0          	mov    (%rax,%r8,8),%rax
    9d18:	48 85 c9             	test   %rcx,%rcx
    9d1b:	78 09                	js     9d26 <fwp_p_array_get_typed+0x46>
    9d1d:	48 8d 4e 08          	lea    0x8(%rsi),%rcx
    9d21:	eb 07                	jmp    9d2a <fwp_p_array_get_typed+0x4a>
    9d23:	31 c0                	xor    %eax,%eax
    9d25:	c3                   	ret
    9d26:	48 8b 4e 10          	mov    0x10(%rsi),%rcx
    9d2a:	41 57                	push   %r15
    9d2c:	41 56                	push   %r14
    9d2e:	53                   	push   %rbx
    9d2f:	48 83 ec 10          	sub    $0x10,%rsp
    9d33:	48 0f af f8          	imul   %rax,%rdi
    9d37:	48 83 f8 01          	cmp    $0x1,%rax
    9d3b:	49 89 f6             	mov    %rsi,%r14
    9d3e:	74 1f                	je     9d5f <fwp_p_array_get_typed+0x7f>
    9d40:	48 83 f8 02          	cmp    $0x2,%rax
    9d44:	74 0c                	je     9d52 <fwp_p_array_get_typed+0x72>
    9d46:	48 83 f8 08          	cmp    $0x8,%rax
    9d4a:	75 20                	jne    9d6c <fwp_p_array_get_typed+0x8c>
    9d4c:	48 8b 04 39          	mov    (%rcx,%rdi,1),%rax
    9d50:	eb 27                	jmp    9d79 <fwp_p_array_get_typed+0x99>
    9d52:	83 3a 01             	cmpl   $0x1,(%rdx)
    9d55:	0f b7 0c 39          	movzwl (%rcx,%rdi,1),%ecx
    9d59:	48 0f bf c1          	movswq %cx,%rax
    9d5d:	eb 16                	jmp    9d75 <fwp_p_array_get_typed+0x95>
    9d5f:	83 3a 00             	cmpl   $0x0,(%rdx)
    9d62:	0f b6 0c 39          	movzbl (%rcx,%rdi,1),%ecx
    9d66:	48 0f be c1          	movsbq %cl,%rax
    9d6a:	eb 09                	jmp    9d75 <fwp_p_array_get_typed+0x95>
    9d6c:	83 3a 02             	cmpl   $0x2,(%rdx)
    9d6f:	8b 0c 39             	mov    (%rcx,%rdi,1),%ecx
    9d72:	48 63 c1             	movslq %ecx,%rax
    9d75:	48 0f 45 c1          	cmovne %rcx,%rax
    9d79:	48 89 44 24 08       	mov    %rax,0x8(%rsp)
    9d7e:	48 8d 54 24 08       	lea    0x8(%rsp),%rdx
    9d83:	bf 01 00 00 00       	mov    $0x1,%edi
    9d88:	be 01 00 00 00       	mov    $0x1,%esi
    9d8d:	e8 9e 00 00 00       	call   9e30 <fwp_data>
    9d92:	48 89 c2             	mov    %rax,%rdx
    9d95:	48 2b 15 14 94 00 00 	sub    0x9414(%rip),%rdx        # 131b0 <fwp_gc+0x1030>
    9d9c:	48 8b 0d 35 94 00 00 	mov    0x9435(%rip),%rcx        # 131d8 <fwp_gc+0x1058>
    9da3:	48 c1 e1 10          	shl    $0x10,%rcx
    9da7:	48 39 ca             	cmp    %rcx,%rdx
    9daa:	4c 89 f1             	mov    %r14,%rcx
    9dad:	73 77                	jae    9e26 <fwp_p_array_get_typed+0x146>
    9daf:	48 8b 35 42 94 00 00 	mov    0x9442(%rip),%rsi        # 131f8 <fwp_gc+0x1078>
    9db6:	48 89 d7             	mov    %rdx,%rdi
    9db9:	48 c1 ef 10          	shr    $0x10,%rdi
    9dbd:	48 69 ff 28 12 00 00 	imul   $0x1228,%rdi,%rdi
    9dc4:	44 0f b6 04 3e       	movzbl (%rsi,%rdi,1),%r8d
    9dc9:	48 81 e2 ff ff 00 00 	and    $0xffff,%rdx
    9dd0:	75 1b                	jne    9ded <fwp_p_array_get_typed+0x10d>
    9dd2:	41 80 f8 02          	cmp    $0x2,%r8b
    9dd6:	75 15                	jne    9ded <fwp_p_array_get_typed+0x10d>
    9dd8:	48 8d 1c 3e          	lea    (%rsi,%rdi,1),%rbx
    9ddc:	48 81 c3 28 02 00 00 	add    $0x228,%rbx
    9de3:	80 3b ff             	cmpb   $0xff,(%rbx)
    9de6:	74 2b                	je     9e13 <fwp_p_array_get_typed+0x133>
    9de8:	c6 03 01             	movb   $0x1,(%rbx)
    9deb:	eb 39                	jmp    9e26 <fwp_p_array_get_typed+0x146>
    9ded:	41 80 f8 01          	cmp    $0x1,%r8b
    9df1:	75 33                	jne    9e26 <fwp_p_array_get_typed+0x146>
    9df3:	4c 8d 04 3e          	lea    (%rsi,%rdi,1),%r8
    9df7:	8b 74 3e 20          	mov    0x20(%rsi,%rdi,1),%esi
    9dfb:	48 0f af d6          	imul   %rsi,%rdx
    9dff:	48 c1 ea 20          	shr    $0x20,%rdx
    9e03:	4a 8d 1c 02          	lea    (%rdx,%r8,1),%rbx
    9e07:	48 81 c3 28 02 00 00 	add    $0x228,%rbx
    9e0e:	80 3b ff             	cmpb   $0xff,(%rbx)
    9e11:	75 d5                	jne    9de8 <fwp_p_array_get_typed+0x108>
    9e13:	48 89 df             	mov    %rbx,%rdi
    9e16:	49 89 c7             	mov    %rax,%r15
    9e19:	e8 42 c5 ff ff       	call   6360 <fwp_rc_forget_slot>
    9e1e:	4c 89 f8             	mov    %r15,%rax
    9e21:	4c 89 f1             	mov    %r14,%rcx
    9e24:	eb c2                	jmp    9de8 <fwp_p_array_get_typed+0x108>
    9e26:	48 83 c4 10          	add    $0x10,%rsp
    9e2a:	5b                   	pop    %rbx
    9e2b:	41 5e                	pop    %r14
    9e2d:	41 5f                	pop    %r15
    9e2f:	c3                   	ret

0000000000009e30 <fwp_data>:
    9e30:	55                   	push   %rbp
    9e31:	41 57                	push   %r15
    9e33:	41 56                	push   %r14
    9e35:	41 55                	push   %r13
    9e37:	41 54                	push   %r12
    9e39:	53                   	push   %rbx
    9e3a:	50                   	push   %rax
    9e3b:	48 89 d3             	mov    %rdx,%rbx
    9e3e:	89 f5                	mov    %esi,%ebp
    9e40:	41 89 ff             	mov    %edi,%r15d
    9e43:	41 89 f4             	mov    %esi,%r12d
    9e46:	4e 8d 2c e5 00 00 00 	lea    0x0(,%r12,8),%r13
    9e4d:	00 
    9e4e:	4a 8d 3c e5 08 00 00 	lea    0x8(,%r12,8),%rdi
    9e55:	00 
    9e56:	81 fe ff 07 00 00    	cmp    $0x7ff,%esi
    9e5c:	0f 87 e6 00 00 00    	ja     9f48 <fwp_data+0x118>
    9e62:	49 8d 75 17          	lea    0x17(%r13),%rsi
    9e66:	48 c1 ee 04          	shr    $0x4,%rsi
    9e6a:	48 8d 05 0f 83 00 00 	lea    0x830f(%rip),%rax        # 12180 <fwp_gc>
    9e71:	0f b6 8c 06 e8 0b 00 	movzbl 0xbe8(%rsi,%rax,1),%ecx
    9e78:	00 
    9e79:	8b 94 88 48 0b 00 00 	mov    0xb48(%rax,%rcx,4),%edx
    9e80:	4c 8b 05 f9 82 00 00 	mov    0x82f9(%rip),%r8        # 12180 <fwp_gc>
    9e87:	4d 89 c1             	mov    %r8,%r9
    9e8a:	49 29 d1             	sub    %rdx,%r9
    9e8d:	4c 89 0d ec 82 00 00 	mov    %r9,0x82ec(%rip)        # 12180 <fwp_gc>
    9e94:	0f 88 ae 00 00 00    	js     9f48 <fwp_data+0x118>
    9e9a:	4c 8d 0c 49          	lea    (%rcx,%rcx,2),%r9
    9e9e:	4e 8d 14 c8          	lea    (%rax,%r9,8),%r10
    9ea2:	49 83 c2 08          	add    $0x8,%r10
    9ea6:	4d 8b 32             	mov    (%r10),%r14
    9ea9:	4d 85 f6             	test   %r14,%r14
    9eac:	74 29                	je     9ed7 <fwp_data+0xa7>
    9eae:	49 8b 06             	mov    (%r14),%rax
    9eb1:	48 f7 d0             	not    %rax
    9eb4:	49 89 02             	mov    %rax,(%r10)
    9eb7:	48 39 d7             	cmp    %rdx,%rdi
    9eba:	0f 83 ad 00 00 00    	jae    9f6d <fwp_data+0x13d>
    9ec0:	4c 01 f7             	add    %r14,%rdi
    9ec3:	4c 29 ea             	sub    %r13,%rdx
    9ec6:	48 83 c2 f7          	add    $0xfffffffffffffff7,%rdx
    9eca:	48 83 e2 f8          	and    $0xfffffffffffffff8,%rdx
    9ece:	48 83 c2 08          	add    $0x8,%rdx
    9ed2:	e9 8f 00 00 00       	jmp    9f66 <fwp_data+0x136>
    9ed7:	4e 8b 74 c8 10       	mov    0x10(%rax,%r9,8),%r14
    9edc:	4e 8b 54 c8 18       	mov    0x18(%rax,%r9,8),%r10
    9ee1:	4d 29 f2             	sub    %r14,%r10
    9ee4:	49 39 d2             	cmp    %rdx,%r10
    9ee7:	72 2f                	jb     9f18 <fwp_data+0xe8>
    9ee9:	4a 8d 0c c8          	lea    (%rax,%r9,8),%rcx
    9eed:	48 83 c1 10          	add    $0x10,%rcx
    9ef1:	4d 8d 0c 16          	lea    (%r14,%rdx,1),%r9
    9ef5:	4c 89 09             	mov    %r9,(%rcx)
    9ef8:	4d 85 f6             	test   %r14,%r14
    9efb:	75 ba                	jne    9eb7 <fwp_data+0x87>
    9efd:	0f b6 8c 06 e8 0b 00 	movzbl 0xbe8(%rsi,%rax,1),%ecx
    9f04:	00 
    9f05:	8b 94 88 48 0b 00 00 	mov    0xb48(%rax,%rcx,4),%edx
    9f0c:	49 29 d0             	sub    %rdx,%r8
    9f0f:	4c 89 05 6a 82 00 00 	mov    %r8,0x826a(%rip)        # 12180 <fwp_gc>
    9f16:	78 30                	js     9f48 <fwp_data+0x118>
    9f18:	48 8d 0c 49          	lea    (%rcx,%rcx,2),%rcx
    9f1c:	4c 8b 74 c8 08       	mov    0x8(%rax,%rcx,8),%r14
    9f21:	4d 85 f6             	test   %r14,%r14
    9f24:	74 10                	je     9f36 <fwp_data+0x106>
    9f26:	48 8d 04 c8          	lea    (%rax,%rcx,8),%rax
    9f2a:	48 83 c0 08          	add    $0x8,%rax
    9f2e:	49 8b 0e             	mov    (%r14),%rcx
    9f31:	48 f7 d1             	not    %rcx
    9f34:	eb 2a                	jmp    9f60 <fwp_data+0x130>
    9f36:	4c 8b 74 c8 10       	mov    0x10(%rax,%rcx,8),%r14
    9f3b:	48 8b 74 c8 18       	mov    0x18(%rax,%rcx,8),%rsi
    9f40:	4c 29 f6             	sub    %r14,%rsi
    9f43:	48 39 d6             	cmp    %rdx,%rsi
    9f46:	73 0c                	jae    9f54 <fwp_data+0x124>
    9f48:	31 f6                	xor    %esi,%esi
    9f4a:	e8 31 c8 ff ff       	call   6780 <fwp_gc_alloc_slow>
    9f4f:	49 89 c6             	mov    %rax,%r14
    9f52:	eb 19                	jmp    9f6d <fwp_data+0x13d>
    9f54:	48 8d 04 c8          	lea    (%rax,%rcx,8),%rax
    9f58:	48 83 c0 10          	add    $0x10,%rax
    9f5c:	49 8d 0c 16          	lea    (%r14,%rdx,1),%rcx
    9f60:	48 89 08             	mov    %rcx,(%rax)
    9f63:	4c 89 f7             	mov    %r14,%rdi
    9f66:	31 f6                	xor    %esi,%esi
    9f68:	e8 c3 81 ff ff       	call   2130 <memset@plt>
    9f6d:	45 89 3e             	mov    %r15d,(%r14)
    9f70:	41 89 6e 04          	mov    %ebp,0x4(%r14)
    9f74:	85 ed                	test   %ebp,%ebp
    9f76:	0f 84 bb 00 00 00    	je     a037 <fwp_data+0x207>
    9f7c:	83 fd 08             	cmp    $0x8,%ebp
    9f7f:	72 10                	jb     9f91 <fwp_data+0x161>
    9f81:	4c 89 f0             	mov    %r14,%rax
    9f84:	48 29 d8             	sub    %rbx,%rax
    9f87:	48 83 c0 08          	add    $0x8,%rax
    9f8b:	48 83 f8 20          	cmp    $0x20,%rax
    9f8f:	73 71                	jae    a002 <fwp_data+0x1d2>
    9f91:	31 c0                	xor    %eax,%eax
    9f93:	4c 89 e2             	mov    %r12,%rdx
    9f96:	48 89 c1             	mov    %rax,%rcx
    9f99:	48 83 e2 03          	and    $0x3,%rdx
    9f9d:	74 22                	je     9fc1 <fwp_data+0x191>
    9f9f:	48 89 c1             	mov    %rax,%rcx
    9fa2:	66 66 66 66 66 2e 0f 	data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    9fa9:	1f 84 00 00 00 00 00 
    9fb0:	48 8b 34 cb          	mov    (%rbx,%rcx,8),%rsi
    9fb4:	49 89 74 ce 08       	mov    %rsi,0x8(%r14,%rcx,8)
    9fb9:	48 ff c1             	inc    %rcx
    9fbc:	48 ff ca             	dec    %rdx
    9fbf:	75 ef                	jne    9fb0 <fwp_data+0x180>
    9fc1:	4c 29 e0             	sub    %r12,%rax
    9fc4:	48 83 f8 fc          	cmp    $0xfffffffffffffffc,%rax
    9fc8:	77 6d                	ja     a037 <fwp_data+0x207>
    9fca:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)
    9fd0:	48 8b 04 cb          	mov    (%rbx,%rcx,8),%rax
    9fd4:	49 89 44 ce 08       	mov    %rax,0x8(%r14,%rcx,8)
    9fd9:	48 8b 44 cb 08       	mov    0x8(%rbx,%rcx,8),%rax
    9fde:	49 89 44 ce 10       	mov    %rax,0x10(%r14,%rcx,8)
    9fe3:	48 8b 44 cb 10       	mov    0x10(%rbx,%rcx,8),%rax
    9fe8:	49 89 44 ce 18       	mov    %rax,0x18(%r14,%rcx,8)
    9fed:	48 8b 44 cb 18       	mov    0x18(%rbx,%rcx,8),%rax
    9ff2:	49 89 44 ce 20       	mov    %rax,0x20(%r14,%rcx,8)
    9ff7:	48 83 c1 04          	add    $0x4,%rcx
    9ffb:	49 39 cc             	cmp    %rcx,%r12
    9ffe:	75 d0                	jne    9fd0 <fwp_data+0x1a0>
    a000:	eb 35                	jmp    a037 <fwp_data+0x207>
    a002:	44 89 e0             	mov    %r12d,%eax
    a005:	83 e0 fc             	and    $0xfffffffc,%eax
    a008:	49 83 e5 e0          	and    $0xffffffffffffffe0,%r13
    a00c:	31 c9                	xor    %ecx,%ecx
    a00e:	66 90                	xchg   %ax,%ax
    a010:	0f 10 04 0b          	movups (%rbx,%rcx,1),%xmm0
    a014:	0f 10 4c 0b 10       	movups 0x10(%rbx,%rcx,1),%xmm1
    a019:	41 0f 11 44 0e 08    	movups %xmm0,0x8(%r14,%rcx,1)
    a01f:	41 0f 11 4c 0e 18    	movups %xmm1,0x18(%r14,%rcx,1)
    a025:	48 83 c1 20          	add    $0x20,%rcx
    a029:	49 39 cd             	cmp    %rcx,%r13
    a02c:	75 e2                	jne    a010 <fwp_data+0x1e0>
    a02e:	4c 39 e0             	cmp    %r12,%rax
    a031:	0f 85 5c ff ff ff    	jne    9f93 <fwp_data+0x163>
    a037:	4c 89 f0             	mov    %r14,%rax
    a03a:	48 83 c4 08          	add    $0x8,%rsp
    a03e:	5b                   	pop    %rbx
    a03f:	41 5c                	pop    %r12
    a041:	41 5d                	pop    %r13
    a043:	41 5e                	pop    %r14
    a045:	41 5f                	pop    %r15
    a047:	5d                   	pop    %rbp
    a048:	c3                   	ret
    a049:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)

000000000000a050 <f49>:
    a050:	41 57                	push   %r15
    a052:	41 56                	push   %r14
    a054:	53                   	push   %rbx
    a055:	48 83 ec 30          	sub    $0x30,%rsp
    a059:	48 89 fb             	mov    %rdi,%rbx
    a05c:	48 8b 47 10          	mov    0x10(%rdi),%rax
    a060:	48 2b 05 49 91 00 00 	sub    0x9149(%rip),%rax        # 131b0 <fwp_gc+0x1030>
    a067:	48 8b 0d 6a 91 00 00 	mov    0x916a(%rip),%rcx        # 131d8 <fwp_gc+0x1058>
    a06e:	48 c1 e1 10          	shl    $0x10,%rcx
    a072:	48 39 c8             	cmp    %rcx,%rax
    a075:	73 68                	jae    a0df <f49+0x8f>
    a077:	48 8b 0d 7a 91 00 00 	mov    0x917a(%rip),%rcx        # 131f8 <fwp_gc+0x1078>
    a07e:	48 89 c2             	mov    %rax,%rdx
    a081:	48 c1 ea 10          	shr    $0x10,%rdx
    a085:	48 69 d2 28 12 00 00 	imul   $0x1228,%rdx,%rdx
    a08c:	0f b6 34 11          	movzbl (%rcx,%rdx,1),%esi
    a090:	48 25 ff ff 00 00    	and    $0xffff,%rax
    a096:	75 13                	jne    a0ab <f49+0x5b>
    a098:	40 80 fe 02          	cmp    $0x2,%sil
    a09c:	75 0d                	jne    a0ab <f49+0x5b>
    a09e:	48 8d 3c 11          	lea    (%rcx,%rdx,1),%rdi
    a0a2:	48 81 c7 28 02 00 00 	add    $0x228,%rdi
    a0a9:	eb 21                	jmp    a0cc <f49+0x7c>
    a0ab:	40 80 fe 01          	cmp    $0x1,%sil
    a0af:	75 2e                	jne    a0df <f49+0x8f>
    a0b1:	48 8d 34 11          	lea    (%rcx,%rdx,1),%rsi
    a0b5:	8b 4c 11 20          	mov    0x20(%rcx,%rdx,1),%ecx
    a0b9:	48 0f af c1          	imul   %rcx,%rax
    a0bd:	48 c1 e8 20          	shr    $0x20,%rax
    a0c1:	48 8d 3c 30          	lea    (%rax,%rsi,1),%rdi
    a0c5:	48 81 c7 28 02 00 00 	add    $0x228,%rdi
    a0cc:	0f b6 07             	movzbl (%rdi),%eax
    a0cf:	84 c0                	test   %al,%al
    a0d1:	74 0c                	je     a0df <f49+0x8f>
    a0d3:	3c fe                	cmp    $0xfe,%al
    a0d5:	0f 83 d8 01 00 00    	jae    a2b3 <f49+0x263>
    a0db:	fe c0                	inc    %al
    a0dd:	88 07                	mov    %al,(%rdi)
    a0df:	4c 8b 7b 08          	mov    0x8(%rbx),%r15
    a0e3:	48 8b 7b 10          	mov    0x10(%rbx),%rdi
    a0e7:	4c 8b 73 18          	mov    0x18(%rbx),%r14
    a0eb:	4d 85 ff             	test   %r15,%r15
    a0ee:	78 20                	js     a110 <f49+0xc0>
    a0f0:	48 8b 07             	mov    (%rdi),%rax
    a0f3:	48 b9 ff ff ff ff ff 	movabs $0x7fffffffffffffff,%rcx
    a0fa:	ff ff 7f 
    a0fd:	48 21 c1             	and    %rax,%rcx
    a100:	4c 39 f9             	cmp    %r15,%rcx
    a103:	76 0b                	jbe    a110 <f49+0xc0>
    a105:	48 85 c0             	test   %rax,%rax
    a108:	78 2e                	js     a138 <f49+0xe8>
    a10a:	48 8d 47 08          	lea    0x8(%rdi),%rax
    a10e:	eb 2c                	jmp    a13c <f49+0xec>
    a110:	e8 8b 03 00 00       	call   a4a0 <fwp_drop1>
    a115:	41 bf 01 00 00 00    	mov    $0x1,%r15d
    a11b:	48 89 df             	mov    %rbx,%rdi
    a11e:	e8 ad 01 00 00       	call   a2d0 <fwp_drop6>
    a123:	4c 89 ff             	mov    %r15,%rdi
    a126:	4c 89 f6             	mov    %r14,%rsi
    a129:	e8 52 02 00 00       	call   a380 <fwp_vbox1>
    a12e:	48 83 c4 30          	add    $0x30,%rsp
    a132:	5b                   	pop    %rbx
    a133:	41 5e                	pop    %r14
    a135:	41 5f                	pop    %r15
    a137:	c3                   	ret
    a138:	48 8b 47 10          	mov    0x10(%rdi),%rax
    a13c:	4c 89 74 24 08       	mov    %r14,0x8(%rsp)
    a141:	f2 42 0f 10 04 f8    	movsd  (%rax,%r15,8),%xmm0
    a147:	f2 0f 59 05 c1 4e 00 	mulsd  0x4ec1(%rip),%xmm0        # f010 <_IO_stdin_used+0x10>
    a14e:	00 
    a14f:	f2 0f 58 05 c1 4e 00 	addsd  0x4ec1(%rip),%xmm0        # f018 <_IO_stdin_used+0x18>
    a156:	00 
    a157:	f2 0f 11 44 24 10    	movsd  %xmm0,0x10(%rsp)
    a15d:	48 89 f8             	mov    %rdi,%rax
    a160:	48 2b 05 49 90 00 00 	sub    0x9049(%rip),%rax        # 131b0 <fwp_gc+0x1030>
    a167:	49 ff c7             	inc    %r15
    a16a:	48 8b 0d 67 90 00 00 	mov    0x9067(%rip),%rcx        # 131d8 <fwp_gc+0x1058>
    a171:	48 c1 e1 10          	shl    $0x10,%rcx
    a175:	48 39 c8             	cmp    %rcx,%rax
    a178:	73 66                	jae    a1e0 <f49+0x190>
    a17a:	48 8b 0d 77 90 00 00 	mov    0x9077(%rip),%rcx        # 131f8 <fwp_gc+0x1078>
    a181:	48 89 c2             	mov    %rax,%rdx
    a184:	48 c1 ea 10          	shr    $0x10,%rdx
    a188:	48 69 d2 28 12 00 00 	imul   $0x1228,%rdx,%rdx
    a18f:	0f b6 34 11          	movzbl (%rcx,%rdx,1),%esi
    a193:	48 25 ff ff 00 00    	and    $0xffff,%rax
    a199:	75 12                	jne    a1ad <f49+0x15d>
    a19b:	40 80 fe 02          	cmp    $0x2,%sil
    a19f:	75 0c                	jne    a1ad <f49+0x15d>
    a1a1:	48 8d 04 11          	lea    (%rcx,%rdx,1),%rax
    a1a5:	48 05 28 02 00 00    	add    $0x228,%rax
    a1ab:	eb 1f                	jmp    a1cc <f49+0x17c>
    a1ad:	40 80 fe 01          	cmp    $0x1,%sil
    a1b1:	75 2d                	jne    a1e0 <f49+0x190>
    a1b3:	48 8d 34 11          	lea    (%rcx,%rdx,1),%rsi
    a1b7:	8b 4c 11 20          	mov    0x20(%rcx,%rdx,1),%ecx
    a1bb:	48 0f af c1          	imul   %rcx,%rax
    a1bf:	48 c1 e8 20          	shr    $0x20,%rax
    a1c3:	48 01 f0             	add    %rsi,%rax
    a1c6:	48 05 28 02 00 00    	add    $0x228,%rax
    a1cc:	0f b6 08             	movzbl (%rax),%ecx
    a1cf:	84 c9                	test   %cl,%cl
    a1d1:	74 0d                	je     a1e0 <f49+0x190>
    a1d3:	80 f9 fe             	cmp    $0xfe,%cl
    a1d6:	0f 83 e1 00 00 00    	jae    a2bd <f49+0x26d>
    a1dc:	fe c1                	inc    %cl
    a1de:	88 08                	mov    %cl,(%rax)
    a1e0:	49 89 fe             	mov    %rdi,%r14
    a1e3:	e8 b8 02 00 00       	call   a4a0 <fwp_drop1>
    a1e8:	f2 0f 10 44 24 10    	movsd  0x10(%rsp),%xmm0
    a1ee:	f2 0f 58 44 24 08    	addsd  0x8(%rsp),%xmm0
    a1f4:	4c 89 7c 24 18       	mov    %r15,0x18(%rsp)
    a1f9:	4c 89 74 24 20       	mov    %r14,0x20(%rsp)
    a1fe:	f2 0f 11 44 24 28    	movsd  %xmm0,0x28(%rsp)
    a204:	45 31 ff             	xor    %r15d,%r15d
    a207:	48 8d 54 24 18       	lea    0x18(%rsp),%rdx
    a20c:	31 ff                	xor    %edi,%edi
    a20e:	be 03 00 00 00       	mov    $0x3,%esi
    a213:	e8 18 fc ff ff       	call   9e30 <fwp_data>
    a218:	49 89 c6             	mov    %rax,%r14
    a21b:	48 2b 05 8e 8f 00 00 	sub    0x8f8e(%rip),%rax        # 131b0 <fwp_gc+0x1030>
    a222:	48 8b 0d af 8f 00 00 	mov    0x8faf(%rip),%rcx        # 131d8 <fwp_gc+0x1058>
    a229:	48 c1 e1 10          	shl    $0x10,%rcx
    a22d:	48 39 c8             	cmp    %rcx,%rax
    a230:	0f 83 e5 fe ff ff    	jae    a11b <f49+0xcb>
    a236:	48 8b 0d bb 8f 00 00 	mov    0x8fbb(%rip),%rcx        # 131f8 <fwp_gc+0x1078>
    a23d:	48 89 c2             	mov    %rax,%rdx
    a240:	48 c1 ea 10          	shr    $0x10,%rdx
    a244:	48 69 d2 28 12 00 00 	imul   $0x1228,%rdx,%rdx
    a24b:	0f b6 34 11          	movzbl (%rcx,%rdx,1),%esi
    a24f:	48 25 ff ff 00 00    	and    $0xffff,%rax
    a255:	75 23                	jne    a27a <f49+0x22a>
    a257:	40 80 fe 02          	cmp    $0x2,%sil
    a25b:	75 1d                	jne    a27a <f49+0x22a>
    a25d:	4c 8d 3c 11          	lea    (%rcx,%rdx,1),%r15
    a261:	49 81 c7 28 02 00 00 	add    $0x228,%r15
    a268:	41 80 3f ff          	cmpb   $0xff,(%r15)
    a26c:	74 33                	je     a2a1 <f49+0x251>
    a26e:	41 c6 07 01          	movb   $0x1,(%r15)
    a272:	45 31 ff             	xor    %r15d,%r15d
    a275:	e9 a1 fe ff ff       	jmp    a11b <f49+0xcb>
    a27a:	40 80 fe 01          	cmp    $0x1,%sil
    a27e:	75 2b                	jne    a2ab <f49+0x25b>
    a280:	48 8d 34 11          	lea    (%rcx,%rdx,1),%rsi
    a284:	8b 4c 11 20          	mov    0x20(%rcx,%rdx,1),%ecx
    a288:	48 0f af c1          	imul   %rcx,%rax
    a28c:	48 c1 e8 20          	shr    $0x20,%rax
    a290:	4c 8d 3c 30          	lea    (%rax,%rsi,1),%r15
    a294:	49 81 c7 28 02 00 00 	add    $0x228,%r15
    a29b:	41 80 3f ff          	cmpb   $0xff,(%r15)
    a29f:	75 cd                	jne    a26e <f49+0x21e>
    a2a1:	4c 89 ff             	mov    %r15,%rdi
    a2a4:	e8 b7 c0 ff ff       	call   6360 <fwp_rc_forget_slot>
    a2a9:	eb c3                	jmp    a26e <f49+0x21e>
    a2ab:	45 31 ff             	xor    %r15d,%r15d
    a2ae:	e9 68 fe ff ff       	jmp    a11b <f49+0xcb>
    a2b3:	e8 88 d3 ff ff       	call   7640 <fwp_rc_wide_dup>
    a2b8:	e9 22 fe ff ff       	jmp    a0df <f49+0x8f>
    a2bd:	49 89 fe             	mov    %rdi,%r14
    a2c0:	48 89 c7             	mov    %rax,%rdi
    a2c3:	e8 78 d3 ff ff       	call   7640 <fwp_rc_wide_dup>
    a2c8:	4c 89 f7             	mov    %r14,%rdi
    a2cb:	e9 10 ff ff ff       	jmp    a1e0 <f49+0x190>

000000000000a2d0 <fwp_drop6>:
    a2d0:	48 89 f8             	mov    %rdi,%rax
    a2d3:	48 2b 05 d6 8e 00 00 	sub    0x8ed6(%rip),%rax        # 131b0 <fwp_gc+0x1030>
    a2da:	48 8b 0d f7 8e 00 00 	mov    0x8ef7(%rip),%rcx        # 131d8 <fwp_gc+0x1058>
    a2e1:	48 c1 e1 10          	shl    $0x10,%rcx
    a2e5:	48 39 c8             	cmp    %rcx,%rax
    a2e8:	0f 83 83 00 00 00    	jae    a371 <fwp_drop6+0xa1>
    a2ee:	48 8b 0d 03 8f 00 00 	mov    0x8f03(%rip),%rcx        # 131f8 <fwp_gc+0x1078>
    a2f5:	48 89 c2             	mov    %rax,%rdx
    a2f8:	48 c1 ea 10          	shr    $0x10,%rdx
    a2fc:	48 69 d2 28 12 00 00 	imul   $0x1228,%rdx,%rdx
    a303:	0f b6 34 11          	movzbl (%rcx,%rdx,1),%esi
    a307:	48 25 ff ff 00 00    	and    $0xffff,%rax
    a30d:	75 12                	jne    a321 <fwp_drop6+0x51>
    a30f:	40 80 fe 02          	cmp    $0x2,%sil
    a313:	75 0c                	jne    a321 <fwp_drop6+0x51>
    a315:	48 8d 04 11          	lea    (%rcx,%rdx,1),%rax
    a319:	48 05 28 02 00 00    	add    $0x228,%rax
    a31f:	eb 1f                	jmp    a340 <fwp_drop6+0x70>
    a321:	40 80 fe 01          	cmp    $0x1,%sil
    a325:	75 4a                	jne    a371 <fwp_drop6+0xa1>
    a327:	48 8d 34 11          	lea    (%rcx,%rdx,1),%rsi
    a32b:	8b 4c 11 20          	mov    0x20(%rcx,%rdx,1),%ecx
    a32f:	48 0f af c1          	imul   %rcx,%rax
    a333:	48 c1 e8 20          	shr    $0x20,%rax
    a337:	48 01 f0             	add    %rsi,%rax
    a33a:	48 05 28 02 00 00    	add    $0x228,%rax
    a340:	0f b6 08             	movzbl (%rax),%ecx
    a343:	85 c9                	test   %ecx,%ecx
    a345:	74 2a                	je     a371 <fwp_drop6+0xa1>
    a347:	83 f9 01             	cmp    $0x1,%ecx
    a34a:	75 19                	jne    a365 <fwp_drop6+0x95>
    a34c:	53                   	push   %rbx
    a34d:	48 8b 47 10          	mov    0x10(%rdi),%rax
    a351:	48 89 fb             	mov    %rdi,%rbx
    a354:	48 89 c7             	mov    %rax,%rdi
    a357:	e8 44 01 00 00       	call   a4a0 <fwp_drop1>
    a35c:	48 89 df             	mov    %rbx,%rdi
    a35f:	5b                   	pop    %rbx
    a360:	e9 0b 06 00 00       	jmp    a970 <fwp_rc_free_obj>
    a365:	81 f9 ff 00 00 00    	cmp    $0xff,%ecx
    a36b:	74 05                	je     a372 <fwp_drop6+0xa2>
    a36d:	fe c9                	dec    %cl
    a36f:	88 08                	mov    %cl,(%rax)
    a371:	c3                   	ret
    a372:	48 89 c7             	mov    %rax,%rdi
    a375:	e9 16 03 00 00       	jmp    a690 <fwp_rc_wide_drop>
    a37a:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)

000000000000a380 <fwp_vbox1>:
    a380:	41 56                	push   %r14
    a382:	53                   	push   %rbx
    a383:	48 83 ec 18          	sub    $0x18,%rsp
    a387:	48 89 7c 24 08       	mov    %rdi,0x8(%rsp)
    a38c:	48 8d 54 24 10       	lea    0x10(%rsp),%rdx
    a391:	48 89 74 24 10       	mov    %rsi,0x10(%rsp)
    a396:	83 ff 01             	cmp    $0x1,%edi
    a399:	74 5c                	je     a3f7 <fwp_vbox1+0x77>
    a39b:	85 ff                	test   %edi,%edi
    a39d:	0f 85 ba 00 00 00    	jne    a45d <fwp_vbox1+0xdd>
    a3a3:	31 ff                	xor    %edi,%edi
    a3a5:	be 01 00 00 00       	mov    $0x1,%esi
    a3aa:	e8 81 fa ff ff       	call   9e30 <fwp_data>
    a3af:	48 89 c1             	mov    %rax,%rcx
    a3b2:	48 2b 0d f7 8d 00 00 	sub    0x8df7(%rip),%rcx        # 131b0 <fwp_gc+0x1030>
    a3b9:	48 8b 15 18 8e 00 00 	mov    0x8e18(%rip),%rdx        # 131d8 <fwp_gc+0x1058>
    a3c0:	48 c1 e2 10          	shl    $0x10,%rdx
    a3c4:	48 39 d1             	cmp    %rdx,%rcx
    a3c7:	0f 83 ca 00 00 00    	jae    a497 <fwp_vbox1+0x117>
    a3cd:	48 8b 15 24 8e 00 00 	mov    0x8e24(%rip),%rdx        # 131f8 <fwp_gc+0x1078>
    a3d4:	48 89 ce             	mov    %rcx,%rsi
    a3d7:	48 c1 ee 10          	shr    $0x10,%rsi
    a3db:	48 69 f6 28 12 00 00 	imul   $0x1228,%rsi,%rsi
    a3e2:	0f b6 3c 32          	movzbl (%rdx,%rsi,1),%edi
    a3e6:	48 81 e1 ff ff 00 00 	and    $0xffff,%rcx
    a3ed:	75 72                	jne    a461 <fwp_vbox1+0xe1>
    a3ef:	40 80 ff 02          	cmp    $0x2,%dil
    a3f3:	74 53                	je     a448 <fwp_vbox1+0xc8>
    a3f5:	eb 6a                	jmp    a461 <fwp_vbox1+0xe1>
    a3f7:	bf 01 00 00 00       	mov    $0x1,%edi
    a3fc:	be 01 00 00 00       	mov    $0x1,%esi
    a401:	e8 2a fa ff ff       	call   9e30 <fwp_data>
    a406:	48 89 c1             	mov    %rax,%rcx
    a409:	48 2b 0d a0 8d 00 00 	sub    0x8da0(%rip),%rcx        # 131b0 <fwp_gc+0x1030>
    a410:	48 8b 15 c1 8d 00 00 	mov    0x8dc1(%rip),%rdx        # 131d8 <fwp_gc+0x1058>
    a417:	48 c1 e2 10          	shl    $0x10,%rdx
    a41b:	48 39 d1             	cmp    %rdx,%rcx
    a41e:	73 77                	jae    a497 <fwp_vbox1+0x117>
    a420:	48 8b 15 d1 8d 00 00 	mov    0x8dd1(%rip),%rdx        # 131f8 <fwp_gc+0x1078>
    a427:	48 89 ce             	mov    %rcx,%rsi
    a42a:	48 c1 ee 10          	shr    $0x10,%rsi
    a42e:	48 69 f6 28 12 00 00 	imul   $0x1228,%rsi,%rsi
    a435:	0f b6 3c 32          	movzbl (%rdx,%rsi,1),%edi
    a439:	48 81 e1 ff ff 00 00 	and    $0xffff,%rcx
    a440:	75 1f                	jne    a461 <fwp_vbox1+0xe1>
    a442:	40 80 ff 02          	cmp    $0x2,%dil
    a446:	75 19                	jne    a461 <fwp_vbox1+0xe1>
    a448:	48 8d 1c 32          	lea    (%rdx,%rsi,1),%rbx
    a44c:	48 81 c3 28 02 00 00 	add    $0x228,%rbx
    a453:	80 3b ff             	cmpb   $0xff,(%rbx)
    a456:	74 2f                	je     a487 <fwp_vbox1+0x107>
    a458:	c6 03 01             	movb   $0x1,(%rbx)
    a45b:	eb 3a                	jmp    a497 <fwp_vbox1+0x117>
    a45d:	31 c0                	xor    %eax,%eax
    a45f:	eb 36                	jmp    a497 <fwp_vbox1+0x117>
    a461:	40 80 ff 01          	cmp    $0x1,%dil
    a465:	75 30                	jne    a497 <fwp_vbox1+0x117>
    a467:	48 8d 3c 32          	lea    (%rdx,%rsi,1),%rdi
    a46b:	8b 54 32 20          	mov    0x20(%rdx,%rsi,1),%edx
    a46f:	48 0f af ca          	imul   %rdx,%rcx
    a473:	48 c1 e9 20          	shr    $0x20,%rcx
    a477:	48 8d 1c 39          	lea    (%rcx,%rdi,1),%rbx
    a47b:	48 81 c3 28 02 00 00 	add    $0x228,%rbx
    a482:	80 3b ff             	cmpb   $0xff,(%rbx)
    a485:	75 d1                	jne    a458 <fwp_vbox1+0xd8>
    a487:	48 89 df             	mov    %rbx,%rdi
    a48a:	49 89 c6             	mov    %rax,%r14
    a48d:	e8 ce be ff ff       	call   6360 <fwp_rc_forget_slot>
    a492:	4c 89 f0             	mov    %r14,%rax
    a495:	eb c1                	jmp    a458 <fwp_vbox1+0xd8>
    a497:	48 83 c4 18          	add    $0x18,%rsp
    a49b:	5b                   	pop    %rbx
    a49c:	41 5e                	pop    %r14
    a49e:	c3                   	ret
    a49f:	90                   	nop

000000000000a4a0 <fwp_drop1>:
    a4a0:	53                   	push   %rbx
    a4a1:	48 89 f8             	mov    %rdi,%rax
    a4a4:	48 2b 05 05 8d 00 00 	sub    0x8d05(%rip),%rax        # 131b0 <fwp_gc+0x1030>
    a4ab:	48 8b 0d 26 8d 00 00 	mov    0x8d26(%rip),%rcx        # 131d8 <fwp_gc+0x1058>
    a4b2:	48 c1 e1 10          	shl    $0x10,%rcx
    a4b6:	48 39 c8             	cmp    %rcx,%rax
    a4b9:	0f 83 9c 00 00 00    	jae    a55b <fwp_drop1+0xbb>
    a4bf:	48 8b 0d 32 8d 00 00 	mov    0x8d32(%rip),%rcx        # 131f8 <fwp_gc+0x1078>
    a4c6:	48 89 c2             	mov    %rax,%rdx
    a4c9:	48 c1 ea 10          	shr    $0x10,%rdx
    a4cd:	48 69 d2 28 12 00 00 	imul   $0x1228,%rdx,%rdx
    a4d4:	0f b6 34 11          	movzbl (%rcx,%rdx,1),%esi
    a4d8:	48 25 ff ff 00 00    	and    $0xffff,%rax
    a4de:	75 20                	jne    a500 <fwp_drop1+0x60>
    a4e0:	40 80 fe 02          	cmp    $0x2,%sil
    a4e4:	75 1a                	jne    a500 <fwp_drop1+0x60>
    a4e6:	48 8d 04 11          	lea    (%rcx,%rdx,1),%rax
    a4ea:	48 05 28 02 00 00    	add    $0x228,%rax
    a4f0:	eb 2d                	jmp    a51f <fwp_drop1+0x7f>
    a4f2:	66 66 66 66 66 2e 0f 	data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    a4f9:	1f 84 00 00 00 00 00 
    a500:	40 80 fe 01          	cmp    $0x1,%sil
    a504:	75 55                	jne    a55b <fwp_drop1+0xbb>
    a506:	48 8d 34 11          	lea    (%rcx,%rdx,1),%rsi
    a50a:	8b 4c 11 20          	mov    0x20(%rcx,%rdx,1),%ecx
    a50e:	48 0f af c1          	imul   %rcx,%rax
    a512:	48 c1 e8 20          	shr    $0x20,%rax
    a516:	48 01 f0             	add    %rsi,%rax
    a519:	48 05 28 02 00 00    	add    $0x228,%rax
    a51f:	0f b6 08             	movzbl (%rax),%ecx
    a522:	85 c9                	test   %ecx,%ecx
    a524:	74 35                	je     a55b <fwp_drop1+0xbb>
    a526:	83 f9 01             	cmp    $0x1,%ecx
    a529:	75 32                	jne    a55d <fwp_drop1+0xbd>
    a52b:	48 83 3f 00          	cmpq   $0x0,(%rdi)
    a52f:	79 3a                	jns    a56b <fwp_drop1+0xcb>
    a531:	48 8b 5f 08          	mov    0x8(%rdi),%rbx
    a535:	e8 46 00 00 00       	call   a580 <fwp_rc_free_arr>
    a53a:	48 89 d8             	mov    %rbx,%rax
    a53d:	48 2b 05 6c 8c 00 00 	sub    0x8c6c(%rip),%rax        # 131b0 <fwp_gc+0x1030>
    a544:	48 8b 0d 8d 8c 00 00 	mov    0x8c8d(%rip),%rcx        # 131d8 <fwp_gc+0x1058>
    a54b:	48 c1 e1 10          	shl    $0x10,%rcx
    a54f:	48 89 df             	mov    %rbx,%rdi
    a552:	48 39 c8             	cmp    %rcx,%rax
    a555:	0f 82 64 ff ff ff    	jb     a4bf <fwp_drop1+0x1f>
    a55b:	5b                   	pop    %rbx
    a55c:	c3                   	ret
    a55d:	81 f9 ff 00 00 00    	cmp    $0xff,%ecx
    a563:	74 09                	je     a56e <fwp_drop1+0xce>
    a565:	fe c9                	dec    %cl
    a567:	88 08                	mov    %cl,(%rax)
    a569:	5b                   	pop    %rbx
    a56a:	c3                   	ret
    a56b:	5b                   	pop    %rbx
    a56c:	eb 12                	jmp    a580 <fwp_rc_free_arr>
    a56e:	48 89 c7             	mov    %rax,%rdi
    a571:	5b                   	pop    %rbx
    a572:	e9 19 01 00 00       	jmp    a690 <fwp_rc_wide_drop>
    a577:	66 0f 1f 84 00 00 00 	nopw   0x0(%rax,%rax,1)
    a57e:	00 00 

000000000000a580 <fwp_rc_free_arr>:
    a580:	48 89 f8             	mov    %rdi,%rax
    a583:	48 2b 05 26 8c 00 00 	sub    0x8c26(%rip),%rax        # 131b0 <fwp_gc+0x1030>
    a58a:	48 8b 0d 47 8c 00 00 	mov    0x8c47(%rip),%rcx        # 131d8 <fwp_gc+0x1058>
    a591:	48 c1 e1 10          	shl    $0x10,%rcx
    a595:	48 39 c8             	cmp    %rcx,%rax
    a598:	0f 83 e9 00 00 00    	jae    a687 <fwp_rc_free_arr+0x107>
    a59e:	53                   	push   %rbx
    a59f:	48 8b 0d 52 8c 00 00 	mov    0x8c52(%rip),%rcx        # 131f8 <fwp_gc+0x1078>
    a5a6:	48 89 c2             	mov    %rax,%rdx
    a5a9:	48 c1 ea 10          	shr    $0x10,%rdx
    a5ad:	48 69 d2 28 12 00 00 	imul   $0x1228,%rdx,%rdx
    a5b4:	0f b6 34 11          	movzbl (%rcx,%rdx,1),%esi
    a5b8:	48 25 ff ff 00 00    	and    $0xffff,%rax
    a5be:	75 1a                	jne    a5da <fwp_rc_free_arr+0x5a>
    a5c0:	40 80 fe 02          	cmp    $0x2,%sil
    a5c4:	75 14                	jne    a5da <fwp_rc_free_arr+0x5a>
    a5c6:	48 8d 04 11          	lea    (%rcx,%rdx,1),%rax
    a5ca:	48 05 28 02 00 00    	add    $0x228,%rax
    a5d0:	80 38 01             	cmpb   $0x1,(%rax)
    a5d3:	74 31                	je     a606 <fwp_rc_free_arr+0x86>
    a5d5:	e9 ac 00 00 00       	jmp    a686 <fwp_rc_free_arr+0x106>
    a5da:	40 80 fe 01          	cmp    $0x1,%sil
    a5de:	0f 85 a2 00 00 00    	jne    a686 <fwp_rc_free_arr+0x106>
    a5e4:	48 8d 34 11          	lea    (%rcx,%rdx,1),%rsi
    a5e8:	8b 4c 11 20          	mov    0x20(%rcx,%rdx,1),%ecx
    a5ec:	48 0f af c1          	imul   %rcx,%rax
    a5f0:	48 c1 e8 20          	shr    $0x20,%rax
    a5f4:	48 01 f0             	add    %rsi,%rax
    a5f7:	48 05 28 02 00 00    	add    $0x228,%rax
    a5fd:	80 38 01             	cmpb   $0x1,(%rax)
    a600:	0f 85 80 00 00 00    	jne    a686 <fwp_rc_free_arr+0x106>
    a606:	8b 0d 94 95 00 00    	mov    0x9594(%rip),%ecx        # 13ba0 <fwp_reuse_verify>
    a60c:	85 c9                	test   %ecx,%ecx
    a60e:	78 0d                	js     a61d <fwp_rc_free_arr+0x9d>
    a610:	85 c9                	test   %ecx,%ecx
    a612:	74 47                	je     a65b <fwp_rc_free_arr+0xdb>
    a614:	48 c7 07 00 00 00 00 	movq   $0x0,(%rdi)
    a61b:	eb 69                	jmp    a686 <fwp_rc_free_arr+0x106>
    a61d:	48 89 fb             	mov    %rdi,%rbx
    a620:	48 8d 3d c2 4e 00 00 	lea    0x4ec2(%rip),%rdi        # f4e9 <fwp_segv.msg+0x2a9>
    a627:	e8 04 7a ff ff       	call   2030 <getenv@plt>
    a62c:	31 c9                	xor    %ecx,%ecx
    a62e:	48 85 c0             	test   %rax,%rax
    a631:	74 1b                	je     a64e <fwp_rc_free_arr+0xce>
    a633:	80 38 00             	cmpb   $0x0,(%rax)
    a636:	74 16                	je     a64e <fwp_rc_free_arr+0xce>
    a638:	48 8d 35 23 50 00 00 	lea    0x5023(%rip),%rsi        # f662 <fwp_segv.msg+0x422>
    a63f:	48 89 c7             	mov    %rax,%rdi
    a642:	e8 39 7b ff ff       	call   2180 <strcmp@plt>
    a647:	31 c9                	xor    %ecx,%ecx
    a649:	85 c0                	test   %eax,%eax
    a64b:	0f 95 c1             	setne  %cl
    a64e:	89 0d 4c 95 00 00    	mov    %ecx,0x954c(%rip)        # 13ba0 <fwp_reuse_verify>
    a654:	48 89 df             	mov    %rbx,%rdi
    a657:	85 c9                	test   %ecx,%ecx
    a659:	75 b9                	jne    a614 <fwp_rc_free_arr+0x94>
    a65b:	48 8b 1d 1e 7b 00 00 	mov    0x7b1e(%rip),%rbx        # 12180 <fwp_gc>
    a662:	e8 b9 00 00 00       	call   a720 <fwp_mem_free>
    a667:	48 8b 05 12 7b 00 00 	mov    0x7b12(%rip),%rax        # 12180 <fwp_gc>
    a66e:	48 29 d8             	sub    %rbx,%rax
    a671:	f2 48 0f 2a c0       	cvtsi2sd %rax,%xmm0
    a676:	f2 0f 58 05 0a 8d 00 	addsd  0x8d0a(%rip),%xmm0        # 13388 <fwp_gc+0x1208>
    a67d:	00 
    a67e:	f2 0f 11 05 02 8d 00 	movsd  %xmm0,0x8d02(%rip)        # 13388 <fwp_gc+0x1208>
    a685:	00 
    a686:	5b                   	pop    %rbx
    a687:	c3                   	ret
    a688:	0f 1f 84 00 00 00 00 	nopl   0x0(%rax,%rax,1)
    a68f:	00 

000000000000a690 <fwp_rc_wide_drop>:
    a690:	53                   	push   %rbx
    a691:	48 89 f8             	mov    %rdi,%rax
    a694:	48 c1 e8 11          	shr    $0x11,%rax
    a698:	31 f8                	xor    %edi,%eax
    a69a:	89 c1                	mov    %eax,%ecx
    a69c:	c1 e9 09             	shr    $0x9,%ecx
    a69f:	31 c1                	xor    %eax,%ecx
    a6a1:	0f b6 c1             	movzbl %cl,%eax
    a6a4:	48 8d 0d d5 7a 00 00 	lea    0x7ad5(%rip),%rcx        # 12180 <fwp_gc>
    a6ab:	48 8b 84 c1 18 12 00 	mov    0x1218(%rcx,%rax,8),%rax
    a6b2:	00 
    a6b3:	48 85 c0             	test   %rax,%rax
    a6b6:	74 16                	je     a6ce <fwp_rc_wide_drop+0x3e>
    a6b8:	0f 1f 84 00 00 00 00 	nopl   0x0(%rax,%rax,1)
    a6bf:	00 
    a6c0:	48 39 38             	cmp    %rdi,(%rax)
    a6c3:	74 37                	je     a6fc <fwp_rc_wide_drop+0x6c>
    a6c5:	48 8b 40 10          	mov    0x10(%rax),%rax
    a6c9:	48 85 c0             	test   %rax,%rax
    a6cc:	75 f2                	jne    a6c0 <fwp_rc_wide_drop+0x30>
    a6ce:	e8 5d bc ff ff       	call   6330 <fwp_flush>
    a6d3:	48 8b 05 06 79 00 00 	mov    0x7906(%rip),%rax        # 11fe0 <stderr@GLIBC_2.2.5>
    a6da:	48 8b 38             	mov    (%rax),%rdi
    a6dd:	48 8d 35 49 4d 00 00 	lea    0x4d49(%rip),%rsi        # f42d <fwp_segv.msg+0x1ed>
    a6e4:	48 8d 15 51 4d 00 00 	lea    0x4d51(%rip),%rdx        # f43c <fwp_segv.msg+0x1fc>
    a6eb:	31 c0                	xor    %eax,%eax
    a6ed:	e8 be 7a ff ff       	call   21b0 <fprintf@plt>
    a6f2:	bf 65 00 00 00       	mov    $0x65,%edi
    a6f7:	e8 94 7b ff ff       	call   2290 <exit@plt>
    a6fc:	48 8b 48 08          	mov    0x8(%rax),%rcx
    a700:	48 ff c9             	dec    %rcx
    a703:	48 89 48 08          	mov    %rcx,0x8(%rax)
    a707:	48 81 f9 fe 00 00 00 	cmp    $0xfe,%rcx
    a70e:	75 0b                	jne    a71b <fwp_rc_wide_drop+0x8b>
    a710:	48 89 fb             	mov    %rdi,%rbx
    a713:	e8 48 bc ff ff       	call   6360 <fwp_rc_forget_slot>
    a718:	c6 03 fe             	movb   $0xfe,(%rbx)
    a71b:	5b                   	pop    %rbx
    a71c:	c3                   	ret
    a71d:	0f 1f 00             	nopl   (%rax)

000000000000a720 <fwp_mem_free>:
    a720:	48 85 ff             	test   %rdi,%rdi
    a723:	0f 84 17 02 00 00    	je     a940 <fwp_mem_free+0x220>
    a729:	48 8b 05 80 8a 00 00 	mov    0x8a80(%rip),%rax        # 131b0 <fwp_gc+0x1030>
    a730:	48 89 f9             	mov    %rdi,%rcx
    a733:	48 29 c1             	sub    %rax,%rcx
    a736:	48 8b 15 9b 8a 00 00 	mov    0x8a9b(%rip),%rdx        # 131d8 <fwp_gc+0x1058>
    a73d:	48 c1 e2 10          	shl    $0x10,%rdx
    a741:	48 39 d1             	cmp    %rdx,%rcx
    a744:	0f 83 f6 01 00 00    	jae    a940 <fwp_mem_free+0x220>
    a74a:	41 57                	push   %r15
    a74c:	41 56                	push   %r14
    a74e:	41 55                	push   %r13
    a750:	41 54                	push   %r12
    a752:	53                   	push   %rbx
    a753:	4c 8b 25 9e 8a 00 00 	mov    0x8a9e(%rip),%r12        # 131f8 <fwp_gc+0x1078>
    a75a:	4d 85 e4             	test   %r12,%r12
    a75d:	0f 84 d4 01 00 00    	je     a937 <fwp_mem_free+0x217>
    a763:	49 89 cf             	mov    %rcx,%r15
    a766:	49 c1 ef 10          	shr    $0x10,%r15
    a76a:	4d 69 f7 28 12 00 00 	imul   $0x1228,%r15,%r14
    a771:	43 0f b6 14 34       	movzbl (%r12,%r14,1),%edx
    a776:	83 fa 02             	cmp    $0x2,%edx
    a779:	0f 84 b9 00 00 00    	je     a838 <fwp_mem_free+0x118>
    a77f:	83 fa 01             	cmp    $0x1,%edx
    a782:	0f 85 af 01 00 00    	jne    a937 <fwp_mem_free+0x217>
    a788:	47 0f b6 4c 34 01    	movzbl 0x1(%r12,%r14,1),%r9d
    a78e:	47 0f b6 44 34 02    	movzbl 0x2(%r12,%r14,1),%r8d
    a794:	43 8b 74 34 08       	mov    0x8(%r12,%r14,1),%esi
    a799:	0f b7 c7             	movzwl %di,%eax
    a79c:	31 d2                	xor    %edx,%edx
    a79e:	f7 f6                	div    %esi
    a7a0:	48 c7 c2 fe ff ff ff 	mov    $0xfffffffffffffffe,%rdx
    a7a7:	89 c1                	mov    %eax,%ecx
    a7a9:	48 d3 c2             	rol    %cl,%rdx
    a7ac:	4b 8d 0c 34          	lea    (%r12,%r14,1),%rcx
    a7b0:	41 89 c2             	mov    %eax,%r10d
    a7b3:	41 c1 ea 03          	shr    $0x3,%r10d
    a7b7:	41 81 e2 f8 1f 00 00 	and    $0x1ff8,%r10d
    a7be:	49 21 54 0a 28       	and    %rdx,0x28(%r10,%rcx,1)
    a7c3:	49 69 d1 c0 03 00 00 	imul   $0x3c0,%r9,%rdx
    a7ca:	4c 8d 3d af 79 00 00 	lea    0x79af(%rip),%r15        # 12180 <fwp_gc>
    a7d1:	49 01 d7             	add    %rdx,%r15
    a7d4:	4f 8d 2c 40          	lea    (%r8,%r8,2),%r13
    a7d8:	4d 01 e6             	add    %r12,%r14
    a7db:	49 83 c6 08          	add    $0x8,%r14
    a7df:	48 8d 1c 08          	lea    (%rax,%rcx,1),%rbx
    a7e3:	48 81 c3 28 02 00 00 	add    $0x228,%rbx
    a7ea:	80 bc 08 28 02 00 00 	cmpb   $0xff,0x228(%rax,%rcx,1)
    a7f1:	ff 
    a7f2:	0f 84 49 01 00 00    	je     a941 <fwp_mem_free+0x221>
    a7f8:	4f 8d 3c ef          	lea    (%r15,%r13,8),%r15
    a7fc:	49 83 c7 08          	add    $0x8,%r15
    a800:	c6 03 00             	movb   $0x0,(%rbx)
    a803:	83 3d 7a 89 00 00 00 	cmpl   $0x0,0x897a(%rip)        # 13184 <fwp_gc+0x1004>
    a80a:	74 12                	je     a81e <fwp_mem_free+0xfe>
    a80c:	89 f2                	mov    %esi,%edx
    a80e:	48 89 fb             	mov    %rdi,%rbx
    a811:	31 f6                	xor    %esi,%esi
    a813:	e8 18 79 ff ff       	call   2130 <memset@plt>
    a818:	48 89 df             	mov    %rbx,%rdi
    a81b:	41 8b 36             	mov    (%r14),%esi
    a81e:	49 8b 07             	mov    (%r15),%rax
    a821:	48 f7 d0             	not    %rax
    a824:	48 89 07             	mov    %rax,(%rdi)
    a827:	49 89 3f             	mov    %rdi,(%r15)
    a82a:	89 f0                	mov    %esi,%eax
    a82c:	48 01 05 4d 79 00 00 	add    %rax,0x794d(%rip)        # 12180 <fwp_gc>
    a833:	e9 ff 00 00 00       	jmp    a937 <fwp_mem_free+0x217>
    a838:	48 81 e1 00 00 ff ff 	and    $0xffffffffffff0000,%rcx
    a83f:	48 01 c8             	add    %rcx,%rax
    a842:	48 39 f8             	cmp    %rdi,%rax
    a845:	0f 85 ec 00 00 00    	jne    a937 <fwp_mem_free+0x217>
    a84b:	4b 8b 44 34 18       	mov    0x18(%r12,%r14,1),%rax
    a850:	48 01 05 29 79 00 00 	add    %rax,0x7929(%rip)        # 12180 <fwp_gc>
    a857:	43 c6 44 34 03 00    	movb   $0x0,0x3(%r12,%r14,1)
    a85d:	4b 8d 1c 34          	lea    (%r12,%r14,1),%rbx
    a861:	48 81 c3 28 02 00 00 	add    $0x228,%rbx
    a868:	43 80 bc 34 28 02 00 	cmpb   $0xff,0x228(%r12,%r14,1)
    a86f:	00 ff 
    a871:	0f 84 e0 00 00 00    	je     a957 <fwp_mem_free+0x237>
    a877:	c6 03 00             	movb   $0x0,(%rbx)
    a87a:	43 8b 44 34 10       	mov    0x10(%r12,%r14,1),%eax
    a87f:	48 85 c0             	test   %rax,%rax
    a882:	0f 84 88 00 00 00    	je     a910 <fwp_mem_free+0x1f0>
    a888:	48 8b 0d 69 89 00 00 	mov    0x8969(%rip),%rcx        # 131f8 <fwp_gc+0x1078>
    a88f:	89 c2                	mov    %eax,%edx
    a891:	83 e2 03             	and    $0x3,%edx
    a894:	83 f8 04             	cmp    $0x4,%eax
    a897:	73 04                	jae    a89d <fwp_mem_free+0x17d>
    a899:	31 f6                	xor    %esi,%esi
    a89b:	eb 3b                	jmp    a8d8 <fwp_mem_free+0x1b8>
    a89d:	4a 8d 3c 31          	lea    (%rcx,%r14,1),%rdi
    a8a1:	41 89 c0             	mov    %eax,%r8d
    a8a4:	41 83 e0 fc          	and    $0xfffffffc,%r8d
    a8a8:	31 f6                	xor    %esi,%esi
    a8aa:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)
    a8b0:	c6 07 00             	movb   $0x0,(%rdi)
    a8b3:	c6 87 28 12 00 00 00 	movb   $0x0,0x1228(%rdi)
    a8ba:	c6 87 50 24 00 00 00 	movb   $0x0,0x2450(%rdi)
    a8c1:	c6 87 78 36 00 00 00 	movb   $0x0,0x3678(%rdi)
    a8c8:	48 83 c6 04          	add    $0x4,%rsi
    a8cc:	48 81 c7 a0 48 00 00 	add    $0x48a0,%rdi
    a8d3:	49 39 f0             	cmp    %rsi,%r8
    a8d6:	75 d8                	jne    a8b0 <fwp_mem_free+0x190>
    a8d8:	48 85 d2             	test   %rdx,%rdx
    a8db:	74 33                	je     a910 <fwp_mem_free+0x1f0>
    a8dd:	48 69 f6 28 12 00 00 	imul   $0x1228,%rsi,%rsi
    a8e4:	4c 01 f6             	add    %r14,%rsi
    a8e7:	48 01 f1             	add    %rsi,%rcx
    a8ea:	48 69 d2 28 12 00 00 	imul   $0x1228,%rdx,%rdx
    a8f1:	31 f6                	xor    %esi,%esi
    a8f3:	66 66 66 66 2e 0f 1f 	data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    a8fa:	84 00 00 00 00 00 
    a900:	c6 04 31 00          	movb   $0x0,(%rcx,%rsi,1)
    a904:	48 81 c6 28 12 00 00 	add    $0x1228,%rsi
    a90b:	48 39 f2             	cmp    %rsi,%rdx
    a90e:	75 f0                	jne    a900 <fwp_mem_free+0x1e0>
    a910:	48 01 05 49 8a 00 00 	add    %rax,0x8a49(%rip)        # 13360 <fwp_gc+0x11e0>
    a917:	4c 3b 3d d2 88 00 00 	cmp    0x88d2(%rip),%r15        # 131f0 <fwp_gc+0x1070>
    a91e:	73 07                	jae    a927 <fwp_mem_free+0x207>
    a920:	4c 89 3d c9 88 00 00 	mov    %r15,0x88c9(%rip)        # 131f0 <fwp_gc+0x1070>
    a927:	4c 3b 3d ba 88 00 00 	cmp    0x88ba(%rip),%r15        # 131e8 <fwp_gc+0x1068>
    a92e:	73 07                	jae    a937 <fwp_mem_free+0x217>
    a930:	4c 89 3d b1 88 00 00 	mov    %r15,0x88b1(%rip)        # 131e8 <fwp_gc+0x1068>
    a937:	5b                   	pop    %rbx
    a938:	41 5c                	pop    %r12
    a93a:	41 5d                	pop    %r13
    a93c:	41 5e                	pop    %r14
    a93e:	41 5f                	pop    %r15
    a940:	c3                   	ret
    a941:	49 89 fc             	mov    %rdi,%r12
    a944:	48 89 df             	mov    %rbx,%rdi
    a947:	e8 14 ba ff ff       	call   6360 <fwp_rc_forget_slot>
    a94c:	4c 89 e7             	mov    %r12,%rdi
    a94f:	41 8b 36             	mov    (%r14),%esi
    a952:	e9 a1 fe ff ff       	jmp    a7f8 <fwp_mem_free+0xd8>
    a957:	48 89 df             	mov    %rbx,%rdi
    a95a:	e8 01 ba ff ff       	call   6360 <fwp_rc_forget_slot>
    a95f:	e9 13 ff ff ff       	jmp    a877 <fwp_mem_free+0x157>
    a964:	66 66 66 2e 0f 1f 84 	data16 data16 cs nopw 0x0(%rax,%rax,1)
    a96b:	00 00 00 00 00 

000000000000a970 <fwp_rc_free_obj>:
    a970:	48 89 f8             	mov    %rdi,%rax
    a973:	48 2b 05 36 88 00 00 	sub    0x8836(%rip),%rax        # 131b0 <fwp_gc+0x1030>
    a97a:	48 8b 0d 57 88 00 00 	mov    0x8857(%rip),%rcx        # 131d8 <fwp_gc+0x1058>
    a981:	48 c1 e1 10          	shl    $0x10,%rcx
    a985:	48 39 c8             	cmp    %rcx,%rax
    a988:	0f 83 b8 01 00 00    	jae    ab46 <fwp_rc_free_obj+0x1d6>
    a98e:	55                   	push   %rbp
    a98f:	41 57                	push   %r15
    a991:	41 56                	push   %r14
    a993:	53                   	push   %rbx
    a994:	50                   	push   %rax
    a995:	48 8b 1d 5c 88 00 00 	mov    0x885c(%rip),%rbx        # 131f8 <fwp_gc+0x1078>
    a99c:	48 89 c1             	mov    %rax,%rcx
    a99f:	48 c1 e9 10          	shr    $0x10,%rcx
    a9a3:	4c 69 f1 28 12 00 00 	imul   $0x1228,%rcx,%r14
    a9aa:	42 0f b6 2c 33       	movzbl (%rbx,%r14,1),%ebp
    a9af:	48 25 ff ff 00 00    	and    $0xffff,%rax
    a9b5:	75 1a                	jne    a9d1 <fwp_rc_free_obj+0x61>
    a9b7:	40 80 fd 02          	cmp    $0x2,%bpl
    a9bb:	75 14                	jne    a9d1 <fwp_rc_free_obj+0x61>
    a9bd:	4a 8d 04 33          	lea    (%rbx,%r14,1),%rax
    a9c1:	48 05 28 02 00 00    	add    $0x228,%rax
    a9c7:	80 38 01             	cmpb   $0x1,(%rax)
    a9ca:	74 32                	je     a9fe <fwp_rc_free_obj+0x8e>
    a9cc:	e9 6b 01 00 00       	jmp    ab3c <fwp_rc_free_obj+0x1cc>
    a9d1:	40 80 fd 01          	cmp    $0x1,%bpl
    a9d5:	0f 85 61 01 00 00    	jne    ab3c <fwp_rc_free_obj+0x1cc>
    a9db:	4a 8d 0c 33          	lea    (%rbx,%r14,1),%rcx
    a9df:	42 8b 54 33 20       	mov    0x20(%rbx,%r14,1),%edx
    a9e4:	48 0f af c2          	imul   %rdx,%rax
    a9e8:	48 c1 e8 20          	shr    $0x20,%rax
    a9ec:	48 01 c8             	add    %rcx,%rax
    a9ef:	48 05 28 02 00 00    	add    $0x228,%rax
    a9f5:	80 38 01             	cmpb   $0x1,(%rax)
    a9f8:	0f 85 3e 01 00 00    	jne    ab3c <fwp_rc_free_obj+0x1cc>
    a9fe:	8b 0d 9c 91 00 00    	mov    0x919c(%rip),%ecx        # 13ba0 <fwp_reuse_verify>
    aa04:	85 c9                	test   %ecx,%ecx
    aa06:	0f 88 c3 00 00 00    	js     aacf <fwp_rc_free_obj+0x15f>
    aa0c:	85 c9                	test   %ecx,%ecx
    aa0e:	0f 84 fd 00 00 00    	je     ab11 <fwp_rc_free_obj+0x1a1>
    aa14:	42 80 7c 33 01 01    	cmpb   $0x1,0x1(%rbx,%r14,1)
    aa1a:	75 0d                	jne    aa29 <fwp_rc_free_obj+0xb9>
    aa1c:	40 80 fd 02          	cmp    $0x2,%bpl
    aa20:	75 22                	jne    aa44 <fwp_rc_free_obj+0xd4>
    aa22:	4a 8b 54 33 18       	mov    0x18(%rbx,%r14,1),%rdx
    aa27:	eb 20                	jmp    aa49 <fwp_rc_free_obj+0xd9>
    aa29:	c7 07 ad de 00 00    	movl   $0xdead,(%rdi)
    aa2f:	8b 47 04             	mov    0x4(%rdi),%eax
    aa32:	48 85 c0             	test   %rax,%rax
    aa35:	0f 84 01 01 00 00    	je     ab3c <fwp_rc_free_obj+0x1cc>
    aa3b:	83 f8 04             	cmp    $0x4,%eax
    aa3e:	73 26                	jae    aa66 <fwp_rc_free_obj+0xf6>
    aa40:	31 c9                	xor    %ecx,%ecx
    aa42:	eb 6a                	jmp    aaae <fwp_rc_free_obj+0x13e>
    aa44:	42 8b 54 33 08       	mov    0x8(%rbx,%r14,1),%edx
    aa49:	48 89 fb             	mov    %rdi,%rbx
    aa4c:	be dd 00 00 00       	mov    $0xdd,%esi
    aa51:	e8 da 76 ff ff       	call   2130 <memset@plt>
    aa56:	48 c7 03 00 00 00 00 	movq   $0x0,(%rbx)
    aa5d:	c6 43 08 00          	movb   $0x0,0x8(%rbx)
    aa61:	e9 d6 00 00 00       	jmp    ab3c <fwp_rc_free_obj+0x1cc>
    aa66:	89 c1                	mov    %eax,%ecx
    aa68:	83 e1 fc             	and    $0xfffffffc,%ecx
    aa6b:	48 8d 14 c5 00 00 00 	lea    0x0(,%rax,8),%rdx
    aa72:	00 
    aa73:	48 83 e2 e0          	and    $0xffffffffffffffe0,%rdx
    aa77:	31 f6                	xor    %esi,%esi
    aa79:	66 0f 28 05 6f 46 00 	movapd 0x466f(%rip),%xmm0        # f0f0 <_IO_stdin_used+0xf0>
    aa80:	00 
    aa81:	66 66 66 66 66 66 2e 	data16 data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    aa88:	0f 1f 84 00 00 00 00 
    aa8f:	00 
    aa90:	66 0f 11 44 37 08    	movupd %xmm0,0x8(%rdi,%rsi,1)
    aa96:	66 0f 11 44 37 18    	movupd %xmm0,0x18(%rdi,%rsi,1)
    aa9c:	48 83 c6 20          	add    $0x20,%rsi
    aaa0:	48 39 f2             	cmp    %rsi,%rdx
    aaa3:	75 eb                	jne    aa90 <fwp_rc_free_obj+0x120>
    aaa5:	48 39 c1             	cmp    %rax,%rcx
    aaa8:	0f 84 8e 00 00 00    	je     ab3c <fwp_rc_free_obj+0x1cc>
    aaae:	48 ba ef be ad de ef 	movabs $0xdeadbeefdeadbeef,%rdx
    aab5:	be ad de 
    aab8:	0f 1f 84 00 00 00 00 	nopl   0x0(%rax,%rax,1)
    aabf:	00 
    aac0:	48 89 54 cf 08       	mov    %rdx,0x8(%rdi,%rcx,8)
    aac5:	48 ff c1             	inc    %rcx
    aac8:	48 39 c8             	cmp    %rcx,%rax
    aacb:	75 f3                	jne    aac0 <fwp_rc_free_obj+0x150>
    aacd:	eb 6d                	jmp    ab3c <fwp_rc_free_obj+0x1cc>
    aacf:	49 89 ff             	mov    %rdi,%r15
    aad2:	48 8d 3d 10 4a 00 00 	lea    0x4a10(%rip),%rdi        # f4e9 <fwp_segv.msg+0x2a9>
    aad9:	e8 52 75 ff ff       	call   2030 <getenv@plt>
    aade:	31 c9                	xor    %ecx,%ecx
    aae0:	48 85 c0             	test   %rax,%rax
    aae3:	74 1b                	je     ab00 <fwp_rc_free_obj+0x190>
    aae5:	80 38 00             	cmpb   $0x0,(%rax)
    aae8:	74 16                	je     ab00 <fwp_rc_free_obj+0x190>
    aaea:	48 8d 35 71 4b 00 00 	lea    0x4b71(%rip),%rsi        # f662 <fwp_segv.msg+0x422>
    aaf1:	48 89 c7             	mov    %rax,%rdi
    aaf4:	e8 87 76 ff ff       	call   2180 <strcmp@plt>
    aaf9:	31 c9                	xor    %ecx,%ecx
    aafb:	85 c0                	test   %eax,%eax
    aafd:	0f 95 c1             	setne  %cl
    ab00:	89 0d 9a 90 00 00    	mov    %ecx,0x909a(%rip)        # 13ba0 <fwp_reuse_verify>
    ab06:	4c 89 ff             	mov    %r15,%rdi
    ab09:	85 c9                	test   %ecx,%ecx
    ab0b:	0f 85 03 ff ff ff    	jne    aa14 <fwp_rc_free_obj+0xa4>
    ab11:	48 8b 1d 68 76 00 00 	mov    0x7668(%rip),%rbx        # 12180 <fwp_gc>
    ab18:	e8 03 fc ff ff       	call   a720 <fwp_mem_free>
    ab1d:	48 8b 05 5c 76 00 00 	mov    0x765c(%rip),%rax        # 12180 <fwp_gc>
    ab24:	48 29 d8             	sub    %rbx,%rax
    ab27:	f2 48 0f 2a c0       	cvtsi2sd %rax,%xmm0
    ab2c:	f2 0f 58 05 54 88 00 	addsd  0x8854(%rip),%xmm0        # 13388 <fwp_gc+0x1208>
    ab33:	00 
    ab34:	f2 0f 11 05 4c 88 00 	movsd  %xmm0,0x884c(%rip)        # 13388 <fwp_gc+0x1208>
    ab3b:	00 
    ab3c:	48 83 c4 08          	add    $0x8,%rsp
    ab40:	5b                   	pop    %rbx
    ab41:	41 5e                	pop    %r14
    ab43:	41 5f                	pop    %r15
    ab45:	5d                   	pop    %rbp
    ab46:	c3                   	ret
    ab47:	66 0f 1f 84 00 00 00 	nopw   0x0(%rax,%rax,1)
    ab4e:	00 00 

000000000000ab50 <fwp_owned_entry49>:
    ab50:	48 8b 3f             	mov    (%rdi),%rdi
    ab53:	e9 f8 f4 ff ff       	jmp    a050 <f49>
    ab58:	0f 1f 84 00 00 00 00 	nopl   0x0(%rax,%rax,1)
    ab5f:	00 

000000000000ab60 <fwp_caps49>:
    ab60:	53                   	push   %rbx
    ab61:	83 7f 04 00          	cmpl   $0x0,0x4(%rdi)
    ab65:	74 56                	je     abbd <fwp_caps49+0x5d>
    ab67:	48 89 fb             	mov    %rdi,%rbx
    ab6a:	48 8b 7f 08          	mov    0x8(%rdi),%rdi
    ab6e:	85 f6                	test   %esi,%esi
    ab70:	74 51                	je     abc3 <fwp_caps49+0x63>
    ab72:	48 2b 3d 37 86 00 00 	sub    0x8637(%rip),%rdi        # 131b0 <fwp_gc+0x1030>
    ab79:	48 8b 05 58 86 00 00 	mov    0x8658(%rip),%rax        # 131d8 <fwp_gc+0x1058>
    ab80:	48 c1 e0 10          	shl    $0x10,%rax
    ab84:	48 39 c7             	cmp    %rax,%rdi
    ab87:	73 38                	jae    abc1 <fwp_caps49+0x61>
    ab89:	48 8b 05 68 86 00 00 	mov    0x8668(%rip),%rax        # 131f8 <fwp_gc+0x1078>
    ab90:	48 89 f9             	mov    %rdi,%rcx
    ab93:	48 c1 e9 10          	shr    $0x10,%rcx
    ab97:	48 69 c9 28 12 00 00 	imul   $0x1228,%rcx,%rcx
    ab9e:	0f b6 14 08          	movzbl (%rax,%rcx,1),%edx
    aba2:	48 81 e7 ff ff 00 00 	and    $0xffff,%rdi
    aba9:	75 26                	jne    abd1 <fwp_caps49+0x71>
    abab:	80 fa 02             	cmp    $0x2,%dl
    abae:	75 21                	jne    abd1 <fwp_caps49+0x71>
    abb0:	48 8d 3c 08          	lea    (%rax,%rcx,1),%rdi
    abb4:	48 81 c7 28 02 00 00 	add    $0x228,%rdi
    abbb:	eb 33                	jmp    abf0 <fwp_caps49+0x90>
    abbd:	85 f6                	test   %esi,%esi
    abbf:	74 0a                	je     abcb <fwp_caps49+0x6b>
    abc1:	5b                   	pop    %rbx
    abc2:	c3                   	ret
    abc3:	e8 08 f7 ff ff       	call   a2d0 <fwp_drop6>
    abc8:	48 89 df             	mov    %rbx,%rdi
    abcb:	5b                   	pop    %rbx
    abcc:	e9 9f fd ff ff       	jmp    a970 <fwp_rc_free_obj>
    abd1:	80 fa 01             	cmp    $0x1,%dl
    abd4:	75 eb                	jne    abc1 <fwp_caps49+0x61>
    abd6:	48 8d 14 08          	lea    (%rax,%rcx,1),%rdx
    abda:	8b 44 08 20          	mov    0x20(%rax,%rcx,1),%eax
    abde:	48 0f af f8          	imul   %rax,%rdi
    abe2:	48 c1 ef 20          	shr    $0x20,%rdi
    abe6:	48 01 d7             	add    %rdx,%rdi
    abe9:	48 81 c7 28 02 00 00 	add    $0x228,%rdi
    abf0:	0f b6 07             	movzbl (%rdi),%eax
    abf3:	84 c0                	test   %al,%al
    abf5:	74 ca                	je     abc1 <fwp_caps49+0x61>
    abf7:	3c fe                	cmp    $0xfe,%al
    abf9:	73 06                	jae    ac01 <fwp_caps49+0xa1>
    abfb:	fe c0                	inc    %al
    abfd:	88 07                	mov    %al,(%rdi)
    abff:	5b                   	pop    %rbx
    ac00:	c3                   	ret
    ac01:	5b                   	pop    %rbx
    ac02:	e9 39 ca ff ff       	jmp    7640 <fwp_rc_wide_dup>
    ac07:	66 0f 1f 84 00 00 00 	nopw   0x0(%rax,%rax,1)
    ac0e:	00 00 

000000000000ac10 <fwp_args49>:
    ac10:	85 f6                	test   %esi,%esi
    ac12:	0f 85 8a 00 00 00    	jne    aca2 <fwp_args49+0x92>
    ac18:	85 d2                	test   %edx,%edx
    ac1a:	0f 84 82 00 00 00    	je     aca2 <fwp_args49+0x92>
    ac20:	48 8b 07             	mov    (%rdi),%rax
    ac23:	48 2b 05 86 85 00 00 	sub    0x8586(%rip),%rax        # 131b0 <fwp_gc+0x1030>
    ac2a:	48 8b 0d a7 85 00 00 	mov    0x85a7(%rip),%rcx        # 131d8 <fwp_gc+0x1058>
    ac31:	48 c1 e1 10          	shl    $0x10,%rcx
    ac35:	48 39 c8             	cmp    %rcx,%rax
    ac38:	73 68                	jae    aca2 <fwp_args49+0x92>
    ac3a:	48 8b 0d b7 85 00 00 	mov    0x85b7(%rip),%rcx        # 131f8 <fwp_gc+0x1078>
    ac41:	48 89 c2             	mov    %rax,%rdx
    ac44:	48 c1 ea 10          	shr    $0x10,%rdx
    ac48:	48 69 d2 28 12 00 00 	imul   $0x1228,%rdx,%rdx
    ac4f:	0f b6 34 11          	movzbl (%rcx,%rdx,1),%esi
    ac53:	48 25 ff ff 00 00    	and    $0xffff,%rax
    ac59:	75 13                	jne    ac6e <fwp_args49+0x5e>
    ac5b:	40 80 fe 02          	cmp    $0x2,%sil
    ac5f:	75 0d                	jne    ac6e <fwp_args49+0x5e>
    ac61:	48 8d 3c 11          	lea    (%rcx,%rdx,1),%rdi
    ac65:	48 81 c7 28 02 00 00 	add    $0x228,%rdi
    ac6c:	eb 21                	jmp    ac8f <fwp_args49+0x7f>
    ac6e:	40 80 fe 01          	cmp    $0x1,%sil
    ac72:	75 2e                	jne    aca2 <fwp_args49+0x92>
    ac74:	48 8d 34 11          	lea    (%rcx,%rdx,1),%rsi
    ac78:	8b 4c 11 20          	mov    0x20(%rcx,%rdx,1),%ecx
    ac7c:	48 0f af c1          	imul   %rcx,%rax
    ac80:	48 c1 e8 20          	shr    $0x20,%rax
    ac84:	48 8d 3c 30          	lea    (%rax,%rsi,1),%rdi
    ac88:	48 81 c7 28 02 00 00 	add    $0x228,%rdi
    ac8f:	0f b6 07             	movzbl (%rdi),%eax
    ac92:	84 c0                	test   %al,%al
    ac94:	74 0c                	je     aca2 <fwp_args49+0x92>
    ac96:	3c fe                	cmp    $0xfe,%al
    ac98:	0f 83 a2 c9 ff ff    	jae    7640 <fwp_rc_wide_dup>
    ac9e:	fe c0                	inc    %al
    aca0:	88 07                	mov    %al,(%rdi)
    aca2:	c3                   	ret
    aca3:	66 66 66 66 2e 0f 1f 	data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    acaa:	84 00 00 00 00 00 

000000000000acb0 <fwp_arg_drop49>:
    acb0:	85 f6                	test   %esi,%esi
    acb2:	75 0c                	jne    acc0 <fwp_arg_drop49+0x10>
    acb4:	85 d2                	test   %edx,%edx
    acb6:	74 08                	je     acc0 <fwp_arg_drop49+0x10>
    acb8:	48 8b 3f             	mov    (%rdi),%rdi
    acbb:	e9 10 f6 ff ff       	jmp    a2d0 <fwp_drop6>
    acc0:	c3                   	ret
    acc1:	66 66 66 66 66 66 2e 	data16 data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    acc8:	0f 1f 84 00 00 00 00 
    accf:	00 

000000000000acd0 <fwp_p_loop_own>:
    acd0:	55                   	push   %rbp
    acd1:	41 57                	push   %r15
    acd3:	41 56                	push   %r14
    acd5:	41 55                	push   %r13
    acd7:	41 54                	push   %r12
    acd9:	53                   	push   %rbx
    acda:	48 83 ec 28          	sub    $0x28,%rsp
    acde:	49 89 d7             	mov    %rdx,%r15
    ace1:	49 89 f4             	mov    %rsi,%r12
    ace4:	49 89 fe             	mov    %rdi,%r14
    ace7:	48 89 74 24 08       	mov    %rsi,0x8(%rsp)
    acec:	48 89 7c 24 10       	mov    %rdi,0x10(%rsp)
    acf1:	48 89 54 24 18       	mov    %rdx,0x18(%rsp)
    acf6:	eb 15                	jmp    ad0d <fwp_p_loop_own+0x3d>
    acf8:	0f 1f 84 00 00 00 00 	nopl   0x0(%rax,%rax,1)
    acff:	00 
    ad00:	4c 89 64 24 08       	mov    %r12,0x8(%rsp)
    ad05:	85 db                	test   %ebx,%ebx
    ad07:	0f 85 f6 03 00 00    	jne    b103 <fwp_p_loop_own+0x433>
    ad0d:	8b 05 dd 8e 00 00    	mov    0x8edd(%rip),%eax        # 13bf0 <fwp_budget>
    ad13:	8d 48 ff             	lea    -0x1(%rax),%ecx
    ad16:	89 0d d4 8e 00 00    	mov    %ecx,0x8ed4(%rip)        # 13bf0 <fwp_budget>
    ad1c:	83 f8 01             	cmp    $0x1,%eax
    ad1f:	0f 8e bf 03 00 00    	jle    b0e4 <fwp_p_loop_own+0x414>
    ad25:	4c 89 64 24 08       	mov    %r12,0x8(%rsp)
    ad2a:	4c 8b 2d 8f 8e 00 00 	mov    0x8e8f(%rip),%r13        # 13bc0 <fwp_fns>
    ad31:	41 8b 06             	mov    (%r14),%eax
    ad34:	48 c1 e0 05          	shl    $0x5,%rax
    ad38:	49 83 7c 05 18 00    	cmpq   $0x0,0x18(%r13,%rax,1)
    ad3e:	0f 84 6c 01 00 00    	je     aeb0 <fwp_p_loop_own+0x1e0>
    ad44:	4e 8d 04 28          	lea    (%rax,%r13,1),%r8
    ad48:	49 83 c0 18          	add    $0x18,%r8
    ad4c:	49 01 c5             	add    %rax,%r13
    ad4f:	bd 01 00 00 00       	mov    $0x1,%ebp
    ad54:	31 f6                	xor    %esi,%esi
    ad56:	4c 89 f0             	mov    %r14,%rax
    ad59:	4c 8d 64 24 08       	lea    0x8(%rsp),%r12
    ad5e:	41 be 01 00 00 00    	mov    $0x1,%r14d
    ad64:	66 66 66 2e 0f 1f 84 	data16 data16 cs nopw 0x0(%rax,%rax,1)
    ad6b:	00 00 00 00 00 
    ad70:	40 f6 c6 01          	test   $0x1,%sil
    ad74:	0f 85 86 00 00 00    	jne    ae00 <fwp_p_loop_own+0x130>
    ad7a:	48 89 c7             	mov    %rax,%rdi
    ad7d:	48 2b 3d 2c 84 00 00 	sub    0x842c(%rip),%rdi        # 131b0 <fwp_gc+0x1030>
    ad84:	48 8b 0d 4d 84 00 00 	mov    0x844d(%rip),%rcx        # 131d8 <fwp_gc+0x1058>
    ad8b:	48 c1 e1 10          	shl    $0x10,%rcx
    ad8f:	48 39 cf             	cmp    %rcx,%rdi
    ad92:	73 6c                	jae    ae00 <fwp_p_loop_own+0x130>
    ad94:	48 8b 0d 5d 84 00 00 	mov    0x845d(%rip),%rcx        # 131f8 <fwp_gc+0x1078>
    ad9b:	48 89 fa             	mov    %rdi,%rdx
    ad9e:	48 c1 ea 10          	shr    $0x10,%rdx
    ada2:	48 69 d2 28 12 00 00 	imul   $0x1228,%rdx,%rdx
    ada9:	0f b6 34 11          	movzbl (%rcx,%rdx,1),%esi
    adad:	48 81 e7 ff ff 00 00 	and    $0xffff,%rdi
    adb4:	75 13                	jne    adc9 <fwp_p_loop_own+0xf9>
    adb6:	40 80 fe 02          	cmp    $0x2,%sil
    adba:	75 0d                	jne    adc9 <fwp_p_loop_own+0xf9>
    adbc:	48 8d 3c 11          	lea    (%rcx,%rdx,1),%rdi
    adc0:	48 81 c7 28 02 00 00 	add    $0x228,%rdi
    adc7:	eb 20                	jmp    ade9 <fwp_p_loop_own+0x119>
    adc9:	40 80 fe 01          	cmp    $0x1,%sil
    adcd:	75 31                	jne    ae00 <fwp_p_loop_own+0x130>
    adcf:	48 8d 34 11          	lea    (%rcx,%rdx,1),%rsi
    add3:	8b 4c 11 20          	mov    0x20(%rcx,%rdx,1),%ecx
    add7:	48 0f af f9          	imul   %rcx,%rdi
    addb:	48 c1 ef 20          	shr    $0x20,%rdi
    addf:	48 01 f7             	add    %rsi,%rdi
    ade2:	48 81 c7 28 02 00 00 	add    $0x228,%rdi
    ade9:	0f b6 0f             	movzbl (%rdi),%ecx
    adec:	84 c9                	test   %cl,%cl
    adee:	74 10                	je     ae00 <fwp_p_loop_own+0x130>
    adf0:	80 f9 fe             	cmp    $0xfe,%cl
    adf3:	0f 83 9f 00 00 00    	jae    ae98 <fwp_p_loop_own+0x1c8>
    adf9:	fe c1                	inc    %cl
    adfb:	88 0f                	mov    %cl,(%rdi)
    adfd:	0f 1f 00             	nopl   (%rax)
    ae00:	41 8b 5d 00          	mov    0x0(%r13),%ebx
    ae04:	8b 70 04             	mov    0x4(%rax),%esi
    ae07:	29 f3                	sub    %esi,%ebx
    ae09:	39 dd                	cmp    %ebx,%ebp
    ae0b:	41 89 dd             	mov    %ebx,%r13d
    ae0e:	44 0f 42 ed          	cmovb  %ebp,%r13d
    ae12:	45 89 ef             	mov    %r13d,%r15d
    ae15:	45 39 ee             	cmp    %r13d,%r14d
    ae18:	45 0f 42 fe          	cmovb  %r14d,%r15d
    ae1c:	73 2d                	jae    ae4b <fwp_p_loop_own+0x17b>
    ae1e:	44 89 ea             	mov    %r13d,%edx
    ae21:	44 29 fa             	sub    %r15d,%edx
    ae24:	4d 8b 00             	mov    (%r8),%r8
    ae27:	44 89 f9             	mov    %r15d,%ecx
    ae2a:	49 8d 3c cc          	lea    (%r12,%rcx,8),%rdi
    ae2e:	44 01 fe             	add    %r15d,%esi
    ae31:	4c 89 64 24 20       	mov    %r12,0x20(%rsp)
    ae36:	41 89 ec             	mov    %ebp,%r12d
    ae39:	48 89 c5             	mov    %rax,%rbp
    ae3c:	41 ff 50 10          	call   *0x10(%r8)
    ae40:	48 89 e8             	mov    %rbp,%rax
    ae43:	44 89 e5             	mov    %r12d,%ebp
    ae46:	4c 8b 64 24 20       	mov    0x20(%rsp),%r12
    ae4b:	48 89 c7             	mov    %rax,%rdi
    ae4e:	44 89 ee             	mov    %r13d,%esi
    ae51:	4c 89 e2             	mov    %r12,%rdx
    ae54:	e8 87 09 00 00       	call   b7e0 <fwp_apply_owned>
    ae59:	39 dd                	cmp    %ebx,%ebp
    ae5b:	0f 86 cf 00 00 00    	jbe    af30 <fwp_p_loop_own+0x260>
    ae61:	44 89 e9             	mov    %r13d,%ecx
    ae64:	4d 8d 24 cc          	lea    (%r12,%rcx,8),%r12
    ae68:	44 29 ed             	sub    %r13d,%ebp
    ae6b:	45 29 fe             	sub    %r15d,%r14d
    ae6e:	48 8b 0d 4b 8d 00 00 	mov    0x8d4b(%rip),%rcx        # 13bc0 <fwp_fns>
    ae75:	8b 10                	mov    (%rax),%edx
    ae77:	48 c1 e2 05          	shl    $0x5,%rdx
    ae7b:	4c 8d 2c 11          	lea    (%rcx,%rdx,1),%r13
    ae7f:	4c 8d 04 11          	lea    (%rcx,%rdx,1),%r8
    ae83:	49 83 c0 18          	add    $0x18,%r8
    ae87:	40 b6 01             	mov    $0x1,%sil
    ae8a:	48 83 7c 11 18 00    	cmpq   $0x0,0x18(%rcx,%rdx,1)
    ae90:	0f 85 da fe ff ff    	jne    ad70 <fwp_p_loop_own+0xa0>
    ae96:	eb 25                	jmp    aebd <fwp_p_loop_own+0x1ed>
    ae98:	48 89 c3             	mov    %rax,%rbx
    ae9b:	4d 89 c7             	mov    %r8,%r15
    ae9e:	e8 9d c7 ff ff       	call   7640 <fwp_rc_wide_dup>
    aea3:	4d 89 f8             	mov    %r15,%r8
    aea6:	48 89 d8             	mov    %rbx,%rax
    aea9:	e9 52 ff ff ff       	jmp    ae00 <fwp_p_loop_own+0x130>
    aeae:	66 90                	xchg   %ax,%ax
    aeb0:	bd 01 00 00 00       	mov    $0x1,%ebp
    aeb5:	4c 8d 64 24 08       	lea    0x8(%rsp),%r12
    aeba:	4c 89 f0             	mov    %r14,%rax
    aebd:	4c 8b 1d ec 82 00 00 	mov    0x82ec(%rip),%r11        # 131b0 <fwp_gc+0x1030>
    aec4:	48 89 c2             	mov    %rax,%rdx
    aec7:	4c 29 da             	sub    %r11,%rdx
    aeca:	48 8b 0d 07 83 00 00 	mov    0x8307(%rip),%rcx        # 131d8 <fwp_gc+0x1058>
    aed1:	48 c1 e1 10          	shl    $0x10,%rcx
    aed5:	48 39 ca             	cmp    %rcx,%rdx
    aed8:	4c 8b 74 24 10       	mov    0x10(%rsp),%r14
    aedd:	0f 83 8d 00 00 00    	jae    af70 <fwp_p_loop_own+0x2a0>
    aee3:	48 8b 35 0e 83 00 00 	mov    0x830e(%rip),%rsi        # 131f8 <fwp_gc+0x1078>
    aeea:	48 89 d7             	mov    %rdx,%rdi
    aeed:	48 c1 ef 10          	shr    $0x10,%rdi
    aef1:	48 69 ff 28 12 00 00 	imul   $0x1228,%rdi,%rdi
    aef8:	44 0f b6 04 3e       	movzbl (%rsi,%rdi,1),%r8d
    aefd:	48 81 e2 ff ff 00 00 	and    $0xffff,%rdx
    af04:	75 34                	jne    af3a <fwp_p_loop_own+0x26a>
    af06:	41 80 f8 02          	cmp    $0x2,%r8b
    af0a:	75 2e                	jne    af3a <fwp_p_loop_own+0x26a>
    af0c:	48 8d 14 3e          	lea    (%rsi,%rdi,1),%rdx
    af10:	48 81 c2 28 02 00 00 	add    $0x228,%rdx
    af17:	80 3a 00             	cmpb   $0x0,(%rdx)
    af1a:	74 54                	je     af70 <fwp_p_loop_own+0x2a0>
    af1c:	e9 f6 01 00 00       	jmp    b117 <fwp_p_loop_own+0x447>
    af21:	66 66 66 66 66 66 2e 	data16 data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    af28:	0f 1f 84 00 00 00 00 
    af2f:	00 
    af30:	4c 8b 74 24 10       	mov    0x10(%rsp),%r14
    af35:	e9 eb 00 00 00       	jmp    b025 <fwp_p_loop_own+0x355>
    af3a:	41 80 f8 01          	cmp    $0x1,%r8b
    af3e:	75 30                	jne    af70 <fwp_p_loop_own+0x2a0>
    af40:	4c 8d 04 3e          	lea    (%rsi,%rdi,1),%r8
    af44:	8b 74 3e 20          	mov    0x20(%rsi,%rdi,1),%esi
    af48:	48 0f af d6          	imul   %rsi,%rdx
    af4c:	48 c1 ea 20          	shr    $0x20,%rdx
    af50:	4c 01 c2             	add    %r8,%rdx
    af53:	48 81 c2 28 02 00 00 	add    $0x228,%rdx
    af5a:	80 3a 00             	cmpb   $0x0,(%rdx)
    af5d:	0f 85 b4 01 00 00    	jne    b117 <fwp_p_loop_own+0x447>
    af63:	66 66 66 66 2e 0f 1f 	data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    af6a:	84 00 00 00 00 00 
    af70:	85 ed                	test   %ebp,%ebp
    af72:	0f 84 a0 00 00 00    	je     b018 <fwp_p_loop_own+0x348>
    af78:	48 8b 15 79 82 00 00 	mov    0x8279(%rip),%rdx        # 131f8 <fwp_gc+0x1078>
    af7f:	89 ee                	mov    %ebp,%esi
    af81:	31 ff                	xor    %edi,%edi
    af83:	eb 2b                	jmp    afb0 <fwp_p_loop_own+0x2e0>
    af85:	66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
    af8c:	00 00 00 00 
    af90:	4e 8d 04 0a          	lea    (%rdx,%r9,1),%r8
    af94:	49 81 c0 28 02 00 00 	add    $0x228,%r8
    af9b:	41 80 38 00          	cmpb   $0x0,(%r8)
    af9f:	74 6f                	je     b010 <fwp_p_loop_own+0x340>
    afa1:	e9 71 01 00 00       	jmp    b117 <fwp_p_loop_own+0x447>
    afa6:	66 2e 0f 1f 84 00 00 	cs nopw 0x0(%rax,%rax,1)
    afad:	00 00 00 
    afb0:	4d 8b 04 fc          	mov    (%r12,%rdi,8),%r8
    afb4:	4d 29 d8             	sub    %r11,%r8
    afb7:	49 39 c8             	cmp    %rcx,%r8
    afba:	73 54                	jae    b010 <fwp_p_loop_own+0x340>
    afbc:	4d 89 c1             	mov    %r8,%r9
    afbf:	49 c1 e9 10          	shr    $0x10,%r9
    afc3:	4d 69 c9 28 12 00 00 	imul   $0x1228,%r9,%r9
    afca:	46 0f b6 14 0a       	movzbl (%rdx,%r9,1),%r10d
    afcf:	49 81 e0 ff ff 00 00 	and    $0xffff,%r8
    afd6:	75 06                	jne    afde <fwp_p_loop_own+0x30e>
    afd8:	41 80 fa 02          	cmp    $0x2,%r10b
    afdc:	74 b2                	je     af90 <fwp_p_loop_own+0x2c0>
    afde:	41 80 fa 01          	cmp    $0x1,%r10b
    afe2:	75 2c                	jne    b010 <fwp_p_loop_own+0x340>
    afe4:	4e 8d 14 0a          	lea    (%rdx,%r9,1),%r10
    afe8:	46 8b 4c 0a 20       	mov    0x20(%rdx,%r9,1),%r9d
    afed:	4d 0f af c1          	imul   %r9,%r8
    aff1:	49 c1 e8 20          	shr    $0x20,%r8
    aff5:	4d 01 d0             	add    %r10,%r8
    aff8:	49 81 c0 28 02 00 00 	add    $0x228,%r8
    afff:	41 80 38 00          	cmpb   $0x0,(%r8)
    b003:	0f 85 0e 01 00 00    	jne    b117 <fwp_p_loop_own+0x447>
    b009:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)
    b010:	48 ff c7             	inc    %rdi
    b013:	48 39 fe             	cmp    %rdi,%rsi
    b016:	75 98                	jne    afb0 <fwp_p_loop_own+0x2e0>
    b018:	48 89 c7             	mov    %rax,%rdi
    b01b:	89 ee                	mov    %ebp,%esi
    b01d:	4c 89 e2             	mov    %r12,%rdx
    b020:	e8 5b 02 00 00       	call   b280 <fwp_apply>
    b025:	48 3d ff 0f 00 00    	cmp    $0xfff,%rax
    b02b:	4c 8b 7c 24 18       	mov    0x18(%rsp),%r15
    b030:	77 0e                	ja     b040 <fwp_p_loop_own+0x370>
    b032:	89 c3                	mov    %eax,%ebx
    b034:	eb 0c                	jmp    b042 <fwp_p_loop_own+0x372>
    b036:	66 2e 0f 1f 84 00 00 	cs nopw 0x0(%rax,%rax,1)
    b03d:	00 00 00 
    b040:	8b 18                	mov    (%rax),%ebx
    b042:	4c 8b 60 08          	mov    0x8(%rax),%r12
    b046:	85 db                	test   %ebx,%ebx
    b048:	0f 85 82 00 00 00    	jne    b0d0 <fwp_p_loop_own+0x400>
    b04e:	4c 89 e7             	mov    %r12,%rdi
    b051:	48 2b 3d 58 81 00 00 	sub    0x8158(%rip),%rdi        # 131b0 <fwp_gc+0x1030>
    b058:	48 8b 0d 79 81 00 00 	mov    0x8179(%rip),%rcx        # 131d8 <fwp_gc+0x1058>
    b05f:	48 c1 e1 10          	shl    $0x10,%rcx
    b063:	48 39 cf             	cmp    %rcx,%rdi
    b066:	73 68                	jae    b0d0 <fwp_p_loop_own+0x400>
    b068:	48 8b 0d 89 81 00 00 	mov    0x8189(%rip),%rcx        # 131f8 <fwp_gc+0x1078>
    b06f:	48 89 fa             	mov    %rdi,%rdx
    b072:	48 c1 ea 10          	shr    $0x10,%rdx
    b076:	48 69 d2 28 12 00 00 	imul   $0x1228,%rdx,%rdx
    b07d:	0f b6 34 11          	movzbl (%rcx,%rdx,1),%esi
    b081:	48 81 e7 ff ff 00 00 	and    $0xffff,%rdi
    b088:	75 13                	jne    b09d <fwp_p_loop_own+0x3cd>
    b08a:	40 80 fe 02          	cmp    $0x2,%sil
    b08e:	75 0d                	jne    b09d <fwp_p_loop_own+0x3cd>
    b090:	48 8d 3c 11          	lea    (%rcx,%rdx,1),%rdi
    b094:	48 81 c7 28 02 00 00 	add    $0x228,%rdi
    b09b:	eb 20                	jmp    b0bd <fwp_p_loop_own+0x3ed>
    b09d:	40 80 fe 01          	cmp    $0x1,%sil
    b0a1:	75 2d                	jne    b0d0 <fwp_p_loop_own+0x400>
    b0a3:	48 8d 34 11          	lea    (%rcx,%rdx,1),%rsi
    b0a7:	8b 4c 11 20          	mov    0x20(%rcx,%rdx,1),%ecx
    b0ab:	48 0f af f9          	imul   %rcx,%rdi
    b0af:	48 c1 ef 20          	shr    $0x20,%rdi
    b0b3:	48 01 f7             	add    %rsi,%rdi
    b0b6:	48 81 c7 28 02 00 00 	add    $0x228,%rdi
    b0bd:	0f b6 0f             	movzbl (%rdi),%ecx
    b0c0:	84 c9                	test   %cl,%cl
    b0c2:	74 0c                	je     b0d0 <fwp_p_loop_own+0x400>
    b0c4:	80 f9 fe             	cmp    $0xfe,%cl
    b0c7:	73 25                	jae    b0ee <fwp_p_loop_own+0x41e>
    b0c9:	fe c1                	inc    %cl
    b0cb:	88 0f                	mov    %cl,(%rdi)
    b0cd:	0f 1f 00             	nopl   (%rax)
    b0d0:	4d 85 ff             	test   %r15,%r15
    b0d3:	0f 84 27 fc ff ff    	je     ad00 <fwp_p_loop_own+0x30>
    b0d9:	48 89 c7             	mov    %rax,%rdi
    b0dc:	41 ff d7             	call   *%r15
    b0df:	e9 1c fc ff ff       	jmp    ad00 <fwp_p_loop_own+0x30>
    b0e4:	e8 27 01 00 00       	call   b210 <fwp_preempt>
    b0e9:	e9 37 fc ff ff       	jmp    ad25 <fwp_p_loop_own+0x55>
    b0ee:	49 89 c5             	mov    %rax,%r13
    b0f1:	e8 4a c5 ff ff       	call   7640 <fwp_rc_wide_dup>
    b0f6:	4c 89 e8             	mov    %r13,%rax
    b0f9:	4d 85 ff             	test   %r15,%r15
    b0fc:	75 db                	jne    b0d9 <fwp_p_loop_own+0x409>
    b0fe:	e9 fd fb ff ff       	jmp    ad00 <fwp_p_loop_own+0x30>
    b103:	48 8b 44 24 08       	mov    0x8(%rsp),%rax
    b108:	48 83 c4 28          	add    $0x28,%rsp
    b10c:	5b                   	pop    %rbx
    b10d:	41 5c                	pop    %r12
    b10f:	41 5d                	pop    %r13
    b111:	41 5e                	pop    %r14
    b113:	41 5f                	pop    %r15
    b115:	5d                   	pop    %rbp
    b116:	c3                   	ret
    b117:	e8 14 b2 ff ff       	call   6330 <fwp_flush>
    b11c:	48 8b 05 bd 6e 00 00 	mov    0x6ebd(%rip),%rax        # 11fe0 <stderr@GLIBC_2.2.5>
    b123:	48 8b 38             	mov    (%rax),%rdi
    b126:	48 8d 35 00 43 00 00 	lea    0x4300(%rip),%rsi        # f42d <fwp_segv.msg+0x1ed>
    b12d:	48 8d 15 cc 42 00 00 	lea    0x42cc(%rip),%rdx        # f400 <fwp_segv.msg+0x1c0>
    b134:	31 c0                	xor    %eax,%eax
    b136:	e8 75 70 ff ff       	call   21b0 <fprintf@plt>
    b13b:	bf 65 00 00 00       	mov    $0x65,%edi
    b140:	e8 4b 71 ff ff       	call   2290 <exit@plt>
    b145:	66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
    b14c:	00 00 00 00 

000000000000b150 <fwp_drop7>:
    b150:	48 89 f8             	mov    %rdi,%rax
    b153:	48 2b 05 56 80 00 00 	sub    0x8056(%rip),%rax        # 131b0 <fwp_gc+0x1030>
    b15a:	48 8b 0d 77 80 00 00 	mov    0x8077(%rip),%rcx        # 131d8 <fwp_gc+0x1058>
    b161:	48 c1 e1 10          	shl    $0x10,%rcx
    b165:	48 39 c8             	cmp    %rcx,%rax
    b168:	0f 83 92 00 00 00    	jae    b200 <fwp_drop7+0xb0>
    b16e:	48 8b 0d 83 80 00 00 	mov    0x8083(%rip),%rcx        # 131f8 <fwp_gc+0x1078>
    b175:	48 89 c2             	mov    %rax,%rdx
    b178:	48 c1 ea 10          	shr    $0x10,%rdx
    b17c:	48 69 d2 28 12 00 00 	imul   $0x1228,%rdx,%rdx
    b183:	0f b6 34 11          	movzbl (%rcx,%rdx,1),%esi
    b187:	48 25 ff ff 00 00    	and    $0xffff,%rax
    b18d:	75 12                	jne    b1a1 <fwp_drop7+0x51>
    b18f:	40 80 fe 02          	cmp    $0x2,%sil
    b193:	75 0c                	jne    b1a1 <fwp_drop7+0x51>
    b195:	48 8d 04 11          	lea    (%rcx,%rdx,1),%rax
    b199:	48 05 28 02 00 00    	add    $0x228,%rax
    b19f:	eb 1f                	jmp    b1c0 <fwp_drop7+0x70>
    b1a1:	40 80 fe 01          	cmp    $0x1,%sil
    b1a5:	75 59                	jne    b200 <fwp_drop7+0xb0>
    b1a7:	48 8d 34 11          	lea    (%rcx,%rdx,1),%rsi
    b1ab:	8b 4c 11 20          	mov    0x20(%rcx,%rdx,1),%ecx
    b1af:	48 0f af c1          	imul   %rcx,%rax
    b1b3:	48 c1 e8 20          	shr    $0x20,%rax
    b1b7:	48 01 f0             	add    %rsi,%rax
    b1ba:	48 05 28 02 00 00    	add    $0x228,%rax
    b1c0:	0f b6 08             	movzbl (%rax),%ecx
    b1c3:	85 c9                	test   %ecx,%ecx
    b1c5:	74 39                	je     b200 <fwp_drop7+0xb0>
    b1c7:	83 f9 01             	cmp    $0x1,%ecx
    b1ca:	75 28                	jne    b1f4 <fwp_drop7+0xa4>
    b1cc:	8b 07                	mov    (%rdi),%eax
    b1ce:	83 f8 01             	cmp    $0x1,%eax
    b1d1:	0f 84 99 f7 ff ff    	je     a970 <fwp_rc_free_obj>
    b1d7:	85 c0                	test   %eax,%eax
    b1d9:	75 25                	jne    b200 <fwp_drop7+0xb0>
    b1db:	53                   	push   %rbx
    b1dc:	48 8b 47 08          	mov    0x8(%rdi),%rax
    b1e0:	48 89 fb             	mov    %rdi,%rbx
    b1e3:	48 89 c7             	mov    %rax,%rdi
    b1e6:	e8 e5 f0 ff ff       	call   a2d0 <fwp_drop6>
    b1eb:	48 89 df             	mov    %rbx,%rdi
    b1ee:	5b                   	pop    %rbx
    b1ef:	e9 7c f7 ff ff       	jmp    a970 <fwp_rc_free_obj>
    b1f4:	81 f9 ff 00 00 00    	cmp    $0xff,%ecx
    b1fa:	74 05                	je     b201 <fwp_drop7+0xb1>
    b1fc:	fe c9                	dec    %cl
    b1fe:	88 08                	mov    %cl,(%rax)
    b200:	c3                   	ret
    b201:	48 89 c7             	mov    %rax,%rdi
    b204:	e9 87 f4 ff ff       	jmp    a690 <fwp_rc_wide_drop>
    b209:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)

000000000000b210 <fwp_preempt>:
    b210:	8b 0d de 89 00 00    	mov    0x89de(%rip),%ecx        # 13bf4 <fwp_slice>
    b216:	85 c9                	test   %ecx,%ecx
    b218:	74 07                	je     b221 <fwp_preempt+0x11>
    b21a:	89 0d d0 89 00 00    	mov    %ecx,0x89d0(%rip)        # 13bf0 <fwp_budget>
    b220:	c3                   	ret
    b221:	50                   	push   %rax
    b222:	48 8d 3d 80 44 00 00 	lea    0x4480(%rip),%rdi        # f6a9 <fwp_segv.msg+0x469>
    b229:	e8 02 6e ff ff       	call   2030 <getenv@plt>
    b22e:	48 89 c7             	mov    %rax,%rdi
    b231:	b8 10 27 00 00       	mov    $0x2710,%eax
    b236:	48 85 ff             	test   %rdi,%rdi
    b239:	74 11                	je     b24c <fwp_preempt+0x3c>
    b23b:	80 3f 00             	cmpb   $0x0,(%rdi)
    b23e:	74 0c                	je     b24c <fwp_preempt+0x3c>
    b240:	31 f6                	xor    %esi,%esi
    b242:	ba 0a 00 00 00       	mov    $0xa,%edx
    b247:	e8 54 6f ff ff       	call   21a0 <strtoll@plt>
    b24c:	48 8d 88 00 00 00 80 	lea    -0x80000000(%rax),%rcx
    b253:	48 81 f9 01 00 00 80 	cmp    $0xffffffff80000001,%rcx
    b25a:	b9 ff ff ff 7f       	mov    $0x7fffffff,%ecx
    b25f:	0f 43 c8             	cmovae %eax,%ecx
    b262:	89 0d 8c 89 00 00    	mov    %ecx,0x898c(%rip)        # 13bf4 <fwp_slice>
    b268:	48 83 c4 08          	add    $0x8,%rsp
    b26c:	89 0d 7e 89 00 00    	mov    %ecx,0x897e(%rip)        # 13bf0 <fwp_budget>
    b272:	c3                   	ret
    b273:	66 66 66 66 2e 0f 1f 	data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    b27a:	84 00 00 00 00 00 

000000000000b280 <fwp_apply>:
    b280:	55                   	push   %rbp
    b281:	48 89 e5             	mov    %rsp,%rbp
    b284:	41 57                	push   %r15
    b286:	41 56                	push   %r14
    b288:	41 55                	push   %r13
    b28a:	41 54                	push   %r12
    b28c:	53                   	push   %rbx
    b28d:	48 83 ec 18          	sub    $0x18,%rsp
    b291:	48 89 d3             	mov    %rdx,%rbx
    b294:	49 89 ff             	mov    %rdi,%r15
    b297:	eb 23                	jmp    b2bc <fwp_apply+0x3c>
    b299:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)
    b2a0:	4a 8d 1c f3          	lea    (%rbx,%r14,8),%rbx
    b2a4:	31 c9                	xor    %ecx,%ecx
    b2a6:	49 89 c7             	mov    %rax,%r15
    b2a9:	4c 8b 75 c8          	mov    -0x38(%rbp),%r14
    b2ad:	48 8b 65 c0          	mov    -0x40(%rbp),%rsp
    b2b1:	89 d6                	mov    %edx,%esi
    b2b3:	83 f9 01             	cmp    $0x1,%ecx
    b2b6:	0f 84 aa 04 00 00    	je     b766 <fwp_apply+0x4e6>
    b2bc:	48 8b 05 fd 88 00 00 	mov    0x88fd(%rip),%rax        # 13bc0 <fwp_fns>
    b2c3:	41 8b 0f             	mov    (%r15),%ecx
    b2c6:	45 8b 6f 04          	mov    0x4(%r15),%r13d
    b2ca:	48 c1 e1 05          	shl    $0x5,%rcx
    b2ce:	44 8b 24 08          	mov    (%rax,%rcx,1),%r12d
    b2d2:	4d 85 ed             	test   %r13,%r13
    b2d5:	75 39                	jne    b310 <fwp_apply+0x90>
    b2d7:	41 8d 54 24 ff       	lea    -0x1(%r12),%edx
    b2dc:	39 f2                	cmp    %esi,%edx
    b2de:	73 30                	jae    b310 <fwp_apply+0x90>
    b2e0:	48 89 df             	mov    %rbx,%rdi
    b2e3:	49 89 f7             	mov    %rsi,%r15
    b2e6:	ff 54 08 08          	call   *0x8(%rax,%rcx,1)
    b2ea:	4c 89 fe             	mov    %r15,%rsi
    b2ed:	49 89 c7             	mov    %rax,%r15
    b2f0:	44 39 e6             	cmp    %r12d,%esi
    b2f3:	0f 84 a4 02 00 00    	je     b59d <fwp_apply+0x31d>
    b2f9:	4a 8d 1c e3          	lea    (%rbx,%r12,8),%rbx
    b2fd:	44 29 e6             	sub    %r12d,%esi
    b300:	b9 03 00 00 00       	mov    $0x3,%ecx
    b305:	83 f9 01             	cmp    $0x1,%ecx
    b308:	75 b2                	jne    b2bc <fwp_apply+0x3c>
    b30a:	e9 57 04 00 00       	jmp    b766 <fwp_apply+0x4e6>
    b30f:	90                   	nop
    b310:	4c 89 75 c8          	mov    %r14,-0x38(%rbp)
    b314:	46 8d 34 2e          	lea    (%rsi,%r13,1),%r14d
    b318:	45 39 e6             	cmp    %r12d,%r14d
    b31b:	48 89 75 d0          	mov    %rsi,-0x30(%rbp)
    b31f:	0f 82 1a 02 00 00    	jb     b53f <fwp_apply+0x2bf>
    b325:	48 89 65 c0          	mov    %rsp,-0x40(%rbp)
    b329:	45 89 e3             	mov    %r12d,%r11d
    b32c:	41 83 fc 02          	cmp    $0x2,%r12d
    b330:	ba 01 00 00 00       	mov    $0x1,%edx
    b335:	41 0f 43 d4          	cmovae %r12d,%edx
    b339:	48 8d 14 d5 0f 00 00 	lea    0xf(,%rdx,8),%rdx
    b340:	00 
    b341:	48 83 e2 f0          	and    $0xfffffffffffffff0,%rdx
    b345:	48 89 e7             	mov    %rsp,%rdi
    b348:	48 29 d7             	sub    %rdx,%rdi
    b34b:	48 89 fc             	mov    %rdi,%rsp
    b34e:	4d 85 ed             	test   %r13,%r13
    b351:	0f 84 c9 00 00 00    	je     b420 <fwp_apply+0x1a0>
    b357:	41 83 fd 04          	cmp    $0x4,%r13d
    b35b:	72 10                	jb     b36d <fwp_apply+0xed>
    b35d:	48 89 fa             	mov    %rdi,%rdx
    b360:	4c 29 fa             	sub    %r15,%rdx
    b363:	48 83 c2 f8          	add    $0xfffffffffffffff8,%rdx
    b367:	48 83 fa 20          	cmp    $0x20,%rdx
    b36b:	73 65                	jae    b3d2 <fwp_apply+0x152>
    b36d:	31 d2                	xor    %edx,%edx
    b36f:	4d 89 e8             	mov    %r13,%r8
    b372:	49 89 d2             	mov    %rdx,%r10
    b375:	49 83 e0 03          	and    $0x3,%r8
    b379:	74 16                	je     b391 <fwp_apply+0x111>
    b37b:	49 89 d2             	mov    %rdx,%r10
    b37e:	66 90                	xchg   %ax,%ax
    b380:	4f 8b 4c d7 08       	mov    0x8(%r15,%r10,8),%r9
    b385:	4e 89 0c d7          	mov    %r9,(%rdi,%r10,8)
    b389:	49 ff c2             	inc    %r10
    b38c:	49 ff c8             	dec    %r8
    b38f:	75 ef                	jne    b380 <fwp_apply+0x100>
    b391:	4c 29 ea             	sub    %r13,%rdx
    b394:	48 83 fa fc          	cmp    $0xfffffffffffffffc,%rdx
    b398:	0f 87 82 00 00 00    	ja     b420 <fwp_apply+0x1a0>
    b39e:	66 90                	xchg   %ax,%ax
    b3a0:	4b 8b 54 d7 08       	mov    0x8(%r15,%r10,8),%rdx
    b3a5:	4a 89 14 d7          	mov    %rdx,(%rdi,%r10,8)
    b3a9:	4b 8b 54 d7 10       	mov    0x10(%r15,%r10,8),%rdx
    b3ae:	4a 89 54 d7 08       	mov    %rdx,0x8(%rdi,%r10,8)
    b3b3:	4b 8b 54 d7 18       	mov    0x18(%r15,%r10,8),%rdx
    b3b8:	4a 89 54 d7 10       	mov    %rdx,0x10(%rdi,%r10,8)
    b3bd:	4b 8b 54 d7 20       	mov    0x20(%r15,%r10,8),%rdx
    b3c2:	4a 89 54 d7 18       	mov    %rdx,0x18(%rdi,%r10,8)
    b3c7:	49 83 c2 04          	add    $0x4,%r10
    b3cb:	4d 39 d5             	cmp    %r10,%r13
    b3ce:	75 d0                	jne    b3a0 <fwp_apply+0x120>
    b3d0:	eb 4e                	jmp    b420 <fwp_apply+0x1a0>
    b3d2:	44 89 ea             	mov    %r13d,%edx
    b3d5:	83 e2 fc             	and    $0xfffffffc,%edx
    b3d8:	4e 8d 0c ed 00 00 00 	lea    0x0(,%r13,8),%r9
    b3df:	00 
    b3e0:	49 83 e1 e0          	and    $0xffffffffffffffe0,%r9
    b3e4:	45 31 c0             	xor    %r8d,%r8d
    b3e7:	66 0f 1f 84 00 00 00 	nopw   0x0(%rax,%rax,1)
    b3ee:	00 00 
    b3f0:	43 0f 10 44 07 08    	movups 0x8(%r15,%r8,1),%xmm0
    b3f6:	43 0f 10 4c 07 18    	movups 0x18(%r15,%r8,1),%xmm1
    b3fc:	42 0f 29 04 07       	movaps %xmm0,(%rdi,%r8,1)
    b401:	42 0f 29 4c 07 10    	movaps %xmm1,0x10(%rdi,%r8,1)
    b407:	49 83 c0 20          	add    $0x20,%r8
    b40b:	4d 39 c1             	cmp    %r8,%r9
    b40e:	75 e0                	jne    b3f0 <fwp_apply+0x170>
    b410:	4c 39 ea             	cmp    %r13,%rdx
    b413:	0f 85 56 ff ff ff    	jne    b36f <fwp_apply+0xef>
    b419:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)
    b420:	45 29 eb             	sub    %r13d,%r11d
    b423:	45 89 de             	mov    %r11d,%r14d
    b426:	45 39 ec             	cmp    %r13d,%r12d
    b429:	0f 84 85 00 00 00    	je     b4b4 <fwp_apply+0x234>
    b42f:	41 83 fb 0e          	cmp    $0xe,%r11d
    b433:	0f 83 a0 00 00 00    	jae    b4d9 <fwp_apply+0x259>
    b439:	31 d2                	xor    %edx,%edx
    b43b:	4d 89 f0             	mov    %r14,%r8
    b43e:	48 89 d6             	mov    %rdx,%rsi
    b441:	49 83 e0 03          	and    $0x3,%r8
    b445:	74 1d                	je     b464 <fwp_apply+0x1e4>
    b447:	48 89 d6             	mov    %rdx,%rsi
    b44a:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)
    b450:	4c 8b 0c f3          	mov    (%rbx,%rsi,8),%r9
    b454:	46 8d 14 2e          	lea    (%rsi,%r13,1),%r10d
    b458:	4e 89 0c d7          	mov    %r9,(%rdi,%r10,8)
    b45c:	48 ff c6             	inc    %rsi
    b45f:	49 ff c8             	dec    %r8
    b462:	75 ec                	jne    b450 <fwp_apply+0x1d0>
    b464:	4c 29 f2             	sub    %r14,%rdx
    b467:	48 83 fa fc          	cmp    $0xfffffffffffffffc,%rdx
    b46b:	77 47                	ja     b4b4 <fwp_apply+0x234>
    b46d:	0f 1f 00             	nopl   (%rax)
    b470:	48 8b 14 f3          	mov    (%rbx,%rsi,8),%rdx
    b474:	46 8d 04 2e          	lea    (%rsi,%r13,1),%r8d
    b478:	4a 89 14 c7          	mov    %rdx,(%rdi,%r8,8)
    b47c:	48 8b 54 f3 08       	mov    0x8(%rbx,%rsi,8),%rdx
    b481:	46 8d 04 2e          	lea    (%rsi,%r13,1),%r8d
    b485:	41 ff c0             	inc    %r8d
    b488:	4a 89 14 c7          	mov    %rdx,(%rdi,%r8,8)
    b48c:	48 8b 54 f3 10       	mov    0x10(%rbx,%rsi,8),%rdx
    b491:	45 8d 44 35 02       	lea    0x2(%r13,%rsi,1),%r8d
    b496:	4a 89 14 c7          	mov    %rdx,(%rdi,%r8,8)
    b49a:	48 8b 54 f3 18       	mov    0x18(%rbx,%rsi,8),%rdx
    b49f:	46 8d 04 2e          	lea    (%rsi,%r13,1),%r8d
    b4a3:	41 83 c0 03          	add    $0x3,%r8d
    b4a7:	4a 89 14 c7          	mov    %rdx,(%rdi,%r8,8)
    b4ab:	48 83 c6 04          	add    $0x4,%rsi
    b4af:	49 39 f6             	cmp    %rsi,%r14
    b4b2:	75 bc                	jne    b470 <fwp_apply+0x1f0>
    b4b4:	45 89 dc             	mov    %r11d,%r12d
    b4b7:	ff 54 08 08          	call   *0x8(%rax,%rcx,1)
    b4bb:	b9 01 00 00 00       	mov    $0x1,%ecx
    b4c0:	48 8b 75 d0          	mov    -0x30(%rbp),%rsi
    b4c4:	89 f2                	mov    %esi,%edx
    b4c6:	44 29 e2             	sub    %r12d,%edx
    b4c9:	0f 85 d1 fd ff ff    	jne    b2a0 <fwp_apply+0x20>
    b4cf:	89 f2                	mov    %esi,%edx
    b4d1:	49 89 c6             	mov    %rax,%r14
    b4d4:	e9 d4 fd ff ff       	jmp    b2ad <fwp_apply+0x2d>
    b4d9:	49 8d 56 ff          	lea    -0x1(%r14),%rdx
    b4dd:	89 d6                	mov    %edx,%esi
    b4df:	44 01 ee             	add    %r13d,%esi
    b4e2:	0f 82 51 ff ff ff    	jb     b439 <fwp_apply+0x1b9>
    b4e8:	48 c1 ea 20          	shr    $0x20,%rdx
    b4ec:	ba 00 00 00 00       	mov    $0x0,%edx
    b4f1:	0f 85 44 ff ff ff    	jne    b43b <fwp_apply+0x1bb>
    b4f7:	4a 8d 14 ef          	lea    (%rdi,%r13,8),%rdx
    b4fb:	48 29 da             	sub    %rbx,%rdx
    b4fe:	48 83 fa 20          	cmp    $0x20,%rdx
    b502:	0f 82 31 ff ff ff    	jb     b439 <fwp_apply+0x1b9>
    b508:	44 89 f2             	mov    %r14d,%edx
    b50b:	83 e2 fc             	and    $0xfffffffc,%edx
    b50e:	31 f6                	xor    %esi,%esi
    b510:	0f 10 04 f3          	movups (%rbx,%rsi,8),%xmm0
    b514:	0f 10 4c f3 10       	movups 0x10(%rbx,%rsi,8),%xmm1
    b519:	46 8d 04 2e          	lea    (%rsi,%r13,1),%r8d
    b51d:	42 0f 11 04 c7       	movups %xmm0,(%rdi,%r8,8)
    b522:	42 0f 11 4c c7 10    	movups %xmm1,0x10(%rdi,%r8,8)
    b528:	48 83 c6 04          	add    $0x4,%rsi
    b52c:	48 39 f2             	cmp    %rsi,%rdx
    b52f:	75 df                	jne    b510 <fwp_apply+0x290>
    b531:	4c 39 f2             	cmp    %r14,%rdx
    b534:	0f 85 01 ff ff ff    	jne    b43b <fwp_apply+0x1bb>
    b53a:	e9 75 ff ff ff       	jmp    b4b4 <fwp_apply+0x234>
    b53f:	44 89 f0             	mov    %r14d,%eax
    b542:	41 81 fe ff 07 00 00 	cmp    $0x7ff,%r14d
    b549:	77 72                	ja     b5bd <fwp_apply+0x33d>
    b54b:	48 8d 14 c5 00 00 00 	lea    0x0(,%rax,8),%rdx
    b552:	00 
    b553:	48 83 c2 17          	add    $0x17,%rdx
    b557:	48 c1 ea 04          	shr    $0x4,%rdx
    b55b:	48 8d 0d 1e 6c 00 00 	lea    0x6c1e(%rip),%rcx        # 12180 <fwp_gc>
    b562:	0f b6 bc 0a e8 0b 00 	movzbl 0xbe8(%rdx,%rcx,1),%edi
    b569:	00 
    b56a:	8b 94 b9 48 0b 00 00 	mov    0xb48(%rcx,%rdi,4),%edx
    b571:	48 29 15 08 6c 00 00 	sub    %rdx,0x6c08(%rip)        # 12180 <fwp_gc>
    b578:	78 43                	js     b5bd <fwp_apply+0x33d>
    b57a:	4c 8d 04 7f          	lea    (%rdi,%rdi,2),%r8
    b57e:	4a 8d 3c c1          	lea    (%rcx,%r8,8),%rdi
    b582:	48 81 c7 88 07 00 00 	add    $0x788,%rdi
    b589:	4c 8b 27             	mov    (%rdi),%r12
    b58c:	4d 85 e4             	test   %r12,%r12
    b58f:	74 14                	je     b5a5 <fwp_apply+0x325>
    b591:	49 8b 04 24          	mov    (%r12),%rax
    b595:	48 f7 d0             	not    %rax
    b598:	48 89 07             	mov    %rax,(%rdi)
    b59b:	eb 48                	jmp    b5e5 <fwp_apply+0x365>
    b59d:	4d 89 fe             	mov    %r15,%r14
    b5a0:	e9 c1 01 00 00       	jmp    b766 <fwp_apply+0x4e6>
    b5a5:	4e 8b a4 c1 90 07 00 	mov    0x790(%rcx,%r8,8),%r12
    b5ac:	00 
    b5ad:	4a 8b bc c1 98 07 00 	mov    0x798(%rcx,%r8,8),%rdi
    b5b4:	00 
    b5b5:	4c 29 e7             	sub    %r12,%rdi
    b5b8:	48 39 d7             	cmp    %rdx,%rdi
    b5bb:	73 17                	jae    b5d4 <fwp_apply+0x354>
    b5bd:	48 8d 3c c5 08 00 00 	lea    0x8(,%rax,8),%rdi
    b5c4:	00 
    b5c5:	be 02 00 00 00       	mov    $0x2,%esi
    b5ca:	e8 b1 b1 ff ff       	call   6780 <fwp_gc_alloc_slow>
    b5cf:	49 89 c4             	mov    %rax,%r12
    b5d2:	eb 1b                	jmp    b5ef <fwp_apply+0x36f>
    b5d4:	4a 8d 04 c1          	lea    (%rcx,%r8,8),%rax
    b5d8:	48 05 90 07 00 00    	add    $0x790,%rax
    b5de:	49 8d 0c 14          	lea    (%r12,%rdx,1),%rcx
    b5e2:	48 89 08             	mov    %rcx,(%rax)
    b5e5:	4c 89 e7             	mov    %r12,%rdi
    b5e8:	31 f6                	xor    %esi,%esi
    b5ea:	e8 41 6b ff ff       	call   2130 <memset@plt>
    b5ef:	41 8b 07             	mov    (%r15),%eax
    b5f2:	41 89 04 24          	mov    %eax,(%r12)
    b5f6:	45 89 74 24 04       	mov    %r14d,0x4(%r12)
    b5fb:	4d 85 ed             	test   %r13,%r13
    b5fe:	4d 89 e6             	mov    %r12,%r14
    b601:	48 8b 7d d0          	mov    -0x30(%rbp),%rdi
    b605:	0f 84 c6 00 00 00    	je     b6d1 <fwp_apply+0x451>
    b60b:	31 c0                	xor    %eax,%eax
    b60d:	41 83 fd 06          	cmp    $0x6,%r13d
    b611:	72 53                	jb     b666 <fwp_apply+0x3e6>
    b613:	4c 89 f1             	mov    %r14,%rcx
    b616:	4c 29 f9             	sub    %r15,%rcx
    b619:	48 83 f9 20          	cmp    $0x20,%rcx
    b61d:	72 47                	jb     b666 <fwp_apply+0x3e6>
    b61f:	44 89 e8             	mov    %r13d,%eax
    b622:	83 e0 fc             	and    $0xfffffffc,%eax
    b625:	4a 8d 0c ed 00 00 00 	lea    0x0(,%r13,8),%rcx
    b62c:	00 
    b62d:	48 83 e1 e0          	and    $0xffffffffffffffe0,%rcx
    b631:	31 d2                	xor    %edx,%edx
    b633:	66 66 66 66 2e 0f 1f 	data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    b63a:	84 00 00 00 00 00 
    b640:	41 0f 10 44 17 08    	movups 0x8(%r15,%rdx,1),%xmm0
    b646:	41 0f 10 4c 17 18    	movups 0x18(%r15,%rdx,1),%xmm1
    b64c:	41 0f 11 44 16 08    	movups %xmm0,0x8(%r14,%rdx,1)
    b652:	41 0f 11 4c 16 18    	movups %xmm1,0x18(%r14,%rdx,1)
    b658:	48 83 c2 20          	add    $0x20,%rdx
    b65c:	48 39 d1             	cmp    %rdx,%rcx
    b65f:	75 df                	jne    b640 <fwp_apply+0x3c0>
    b661:	4c 39 e8             	cmp    %r13,%rax
    b664:	74 6b                	je     b6d1 <fwp_apply+0x451>
    b666:	4c 89 ea             	mov    %r13,%rdx
    b669:	48 89 c1             	mov    %rax,%rcx
    b66c:	48 83 e2 03          	and    $0x3,%rdx
    b670:	74 20                	je     b692 <fwp_apply+0x412>
    b672:	48 89 c1             	mov    %rax,%rcx
    b675:	66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
    b67c:	00 00 00 00 
    b680:	49 8b 74 cf 08       	mov    0x8(%r15,%rcx,8),%rsi
    b685:	49 89 74 ce 08       	mov    %rsi,0x8(%r14,%rcx,8)
    b68a:	48 ff c1             	inc    %rcx
    b68d:	48 ff ca             	dec    %rdx
    b690:	75 ee                	jne    b680 <fwp_apply+0x400>
    b692:	4c 29 e8             	sub    %r13,%rax
    b695:	48 83 f8 fc          	cmp    $0xfffffffffffffffc,%rax
    b699:	77 36                	ja     b6d1 <fwp_apply+0x451>
    b69b:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)
    b6a0:	49 8b 44 cf 08       	mov    0x8(%r15,%rcx,8),%rax
    b6a5:	49 89 44 ce 08       	mov    %rax,0x8(%r14,%rcx,8)
    b6aa:	49 8b 44 cf 10       	mov    0x10(%r15,%rcx,8),%rax
    b6af:	49 89 44 ce 10       	mov    %rax,0x10(%r14,%rcx,8)
    b6b4:	49 8b 44 cf 18       	mov    0x18(%r15,%rcx,8),%rax
    b6b9:	49 89 44 ce 18       	mov    %rax,0x18(%r14,%rcx,8)
    b6be:	49 8b 44 cf 20       	mov    0x20(%r15,%rcx,8),%rax
    b6c3:	49 89 44 ce 20       	mov    %rax,0x20(%r14,%rcx,8)
    b6c8:	48 83 c1 04          	add    $0x4,%rcx
    b6cc:	49 39 cd             	cmp    %rcx,%r13
    b6cf:	75 cf                	jne    b6a0 <fwp_apply+0x420>
    b6d1:	85 ff                	test   %edi,%edi
    b6d3:	0f 84 8d 00 00 00    	je     b766 <fwp_apply+0x4e6>
    b6d9:	89 f8                	mov    %edi,%eax
    b6db:	83 ff 14             	cmp    $0x14,%edi
    b6de:	0f 83 94 00 00 00    	jae    b778 <fwp_apply+0x4f8>
    b6e4:	31 c9                	xor    %ecx,%ecx
    b6e6:	48 89 c6             	mov    %rax,%rsi
    b6e9:	48 89 ca             	mov    %rcx,%rdx
    b6ec:	48 83 e6 03          	and    $0x3,%rsi
    b6f0:	74 23                	je     b715 <fwp_apply+0x495>
    b6f2:	48 89 ca             	mov    %rcx,%rdx
    b6f5:	66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
    b6fc:	00 00 00 00 
    b700:	48 8b 3c d3          	mov    (%rbx,%rdx,8),%rdi
    b704:	46 8d 04 2a          	lea    (%rdx,%r13,1),%r8d
    b708:	4b 89 7c c6 08       	mov    %rdi,0x8(%r14,%r8,8)
    b70d:	48 ff c2             	inc    %rdx
    b710:	48 ff ce             	dec    %rsi
    b713:	75 eb                	jne    b700 <fwp_apply+0x480>
    b715:	48 29 c1             	sub    %rax,%rcx
    b718:	48 83 f9 fc          	cmp    $0xfffffffffffffffc,%rcx
    b71c:	77 48                	ja     b766 <fwp_apply+0x4e6>
    b71e:	66 90                	xchg   %ax,%ax
    b720:	48 8b 0c d3          	mov    (%rbx,%rdx,8),%rcx
    b724:	42 8d 34 2a          	lea    (%rdx,%r13,1),%esi
    b728:	49 89 4c f6 08       	mov    %rcx,0x8(%r14,%rsi,8)
    b72d:	48 8b 4c d3 08       	mov    0x8(%rbx,%rdx,8),%rcx
    b732:	42 8d 34 2a          	lea    (%rdx,%r13,1),%esi
    b736:	ff c6                	inc    %esi
    b738:	49 89 4c f6 08       	mov    %rcx,0x8(%r14,%rsi,8)
    b73d:	48 8b 4c d3 10       	mov    0x10(%rbx,%rdx,8),%rcx
    b742:	41 8d 74 15 02       	lea    0x2(%r13,%rdx,1),%esi
    b747:	49 89 4c f6 08       	mov    %rcx,0x8(%r14,%rsi,8)
    b74c:	48 8b 4c d3 18       	mov    0x18(%rbx,%rdx,8),%rcx
    b751:	42 8d 34 2a          	lea    (%rdx,%r13,1),%esi
    b755:	83 c6 03             	add    $0x3,%esi
    b758:	49 89 4c f6 08       	mov    %rcx,0x8(%r14,%rsi,8)
    b75d:	48 83 c2 04          	add    $0x4,%rdx
    b761:	48 39 d0             	cmp    %rdx,%rax
    b764:	75 ba                	jne    b720 <fwp_apply+0x4a0>
    b766:	4c 89 f0             	mov    %r14,%rax
    b769:	48 8d 65 d8          	lea    -0x28(%rbp),%rsp
    b76d:	5b                   	pop    %rbx
    b76e:	41 5c                	pop    %r12
    b770:	41 5d                	pop    %r13
    b772:	41 5e                	pop    %r14
    b774:	41 5f                	pop    %r15
    b776:	5d                   	pop    %rbp
    b777:	c3                   	ret
    b778:	48 8d 50 ff          	lea    -0x1(%rax),%rdx
    b77c:	31 c9                	xor    %ecx,%ecx
    b77e:	89 d6                	mov    %edx,%esi
    b780:	44 01 ee             	add    %r13d,%esi
    b783:	0f 82 5d ff ff ff    	jb     b6e6 <fwp_apply+0x466>
    b789:	48 c1 ea 20          	shr    $0x20,%rdx
    b78d:	0f 85 53 ff ff ff    	jne    b6e6 <fwp_apply+0x466>
    b793:	4b 8d 0c ee          	lea    (%r14,%r13,8),%rcx
    b797:	48 29 d9             	sub    %rbx,%rcx
    b79a:	48 83 c1 08          	add    $0x8,%rcx
    b79e:	48 83 f9 20          	cmp    $0x20,%rcx
    b7a2:	0f 82 3c ff ff ff    	jb     b6e4 <fwp_apply+0x464>
    b7a8:	89 c1                	mov    %eax,%ecx
    b7aa:	83 e1 fc             	and    $0xfffffffc,%ecx
    b7ad:	31 d2                	xor    %edx,%edx
    b7af:	90                   	nop
    b7b0:	0f 10 04 d3          	movups (%rbx,%rdx,8),%xmm0
    b7b4:	0f 10 4c d3 10       	movups 0x10(%rbx,%rdx,8),%xmm1
    b7b9:	42 8d 34 2a          	lea    (%rdx,%r13,1),%esi
    b7bd:	41 0f 11 44 f6 08    	movups %xmm0,0x8(%r14,%rsi,8)
    b7c3:	41 0f 11 4c f6 18    	movups %xmm1,0x18(%r14,%rsi,8)
    b7c9:	48 83 c2 04          	add    $0x4,%rdx
    b7cd:	48 39 d1             	cmp    %rdx,%rcx
    b7d0:	75 de                	jne    b7b0 <fwp_apply+0x530>
    b7d2:	48 39 c1             	cmp    %rax,%rcx
    b7d5:	0f 85 0b ff ff ff    	jne    b6e6 <fwp_apply+0x466>
    b7db:	eb 89                	jmp    b766 <fwp_apply+0x4e6>
    b7dd:	0f 1f 00             	nopl   (%rax)

000000000000b7e0 <fwp_apply_owned>:
    b7e0:	55                   	push   %rbp
    b7e1:	48 89 e5             	mov    %rsp,%rbp
    b7e4:	41 57                	push   %r15
    b7e6:	41 56                	push   %r14
    b7e8:	41 55                	push   %r13
    b7ea:	41 54                	push   %r12
    b7ec:	53                   	push   %rbx
    b7ed:	48 83 ec 28          	sub    $0x28,%rsp
    b7f1:	48 89 d3             	mov    %rdx,%rbx
    b7f4:	41 89 f5             	mov    %esi,%r13d
    b7f7:	48 8b 05 c2 83 00 00 	mov    0x83c2(%rip),%rax        # 13bc0 <fwp_fns>
    b7fe:	8b 17                	mov    (%rdi),%edx
    b800:	48 89 d6             	mov    %rdx,%rsi
    b803:	48 c1 e6 05          	shl    $0x5,%rsi
    b807:	48 8b 4c 30 18       	mov    0x18(%rax,%rsi,1),%rcx
    b80c:	48 85 c9             	test   %rcx,%rcx
    b80f:	0f 84 ca 02 00 00    	je     badf <fwp_apply_owned+0x2ff>
    b815:	4c 8d 04 30          	lea    (%rax,%rsi,1),%r8
    b819:	49 83 c0 18          	add    $0x18,%r8
    b81d:	49 89 fc             	mov    %rdi,%r12
    b820:	48 89 7d c0          	mov    %rdi,-0x40(%rbp)
    b824:	48 c1 e2 05          	shl    $0x5,%rdx
    b828:	8b 04 10             	mov    (%rax,%rdx,1),%eax
    b82b:	45 8b 74 24 04       	mov    0x4(%r12),%r14d
    b830:	47 8d 3c 2e          	lea    (%r14,%r13,1),%r15d
    b834:	41 39 c7             	cmp    %eax,%r15d
    b837:	0f 82 10 03 00 00    	jb     bb4d <fwp_apply_owned+0x36d>
    b83d:	41 89 c7             	mov    %eax,%r15d
    b840:	45 29 f7             	sub    %r14d,%r15d
    b843:	45 89 fa             	mov    %r15d,%r10d
    b846:	85 c0                	test   %eax,%eax
    b848:	4c 89 55 d0          	mov    %r10,-0x30(%rbp)
    b84c:	74 22                	je     b870 <fwp_apply_owned+0x90>
    b84e:	45 85 f6             	test   %r14d,%r14d
    b851:	75 1d                	jne    b870 <fwp_apply_owned+0x90>
    b853:	48 89 df             	mov    %rbx,%rdi
    b856:	ff 11                	call   *(%rcx)
    b858:	49 89 c4             	mov    %rax,%r12
    b85b:	4c 8b 75 c0          	mov    -0x40(%rbp),%r14
    b85f:	e9 35 02 00 00       	jmp    ba99 <fwp_apply_owned+0x2b9>
    b864:	66 66 66 2e 0f 1f 84 	data16 data16 cs nopw 0x0(%rax,%rax,1)
    b86b:	00 00 00 00 00 
    b870:	4c 89 6d c8          	mov    %r13,-0x38(%rbp)
    b874:	48 89 65 b8          	mov    %rsp,-0x48(%rbp)
    b878:	85 c0                	test   %eax,%eax
    b87a:	b9 01 00 00 00       	mov    $0x1,%ecx
    b87f:	0f 45 c8             	cmovne %eax,%ecx
    b882:	48 8d 0c cd 0f 00 00 	lea    0xf(,%rcx,8),%rcx
    b889:	00 
    b88a:	48 83 e1 f0          	and    $0xfffffffffffffff0,%rcx
    b88e:	49 89 e5             	mov    %rsp,%r13
    b891:	49 29 cd             	sub    %rcx,%r13
    b894:	4c 89 ec             	mov    %r13,%rsp
    b897:	4d 85 f6             	test   %r14,%r14
    b89a:	0f 84 d0 00 00 00    	je     b970 <fwp_apply_owned+0x190>
    b8a0:	41 83 fe 04          	cmp    $0x4,%r14d
    b8a4:	72 10                	jb     b8b6 <fwp_apply_owned+0xd6>
    b8a6:	4c 89 e9             	mov    %r13,%rcx
    b8a9:	4c 29 e1             	sub    %r12,%rcx
    b8ac:	48 83 c1 f8          	add    $0xfffffffffffffff8,%rcx
    b8b0:	48 83 f9 20          	cmp    $0x20,%rcx
    b8b4:	73 6d                	jae    b923 <fwp_apply_owned+0x143>
    b8b6:	31 c9                	xor    %ecx,%ecx
    b8b8:	4c 89 f6             	mov    %r14,%rsi
    b8bb:	48 89 ca             	mov    %rcx,%rdx
    b8be:	48 83 e6 03          	and    $0x3,%rsi
    b8c2:	74 1e                	je     b8e2 <fwp_apply_owned+0x102>
    b8c4:	48 89 ca             	mov    %rcx,%rdx
    b8c7:	66 0f 1f 84 00 00 00 	nopw   0x0(%rax,%rax,1)
    b8ce:	00 00 
    b8d0:	49 8b 7c d4 08       	mov    0x8(%r12,%rdx,8),%rdi
    b8d5:	49 89 7c d5 00       	mov    %rdi,0x0(%r13,%rdx,8)
    b8da:	48 ff c2             	inc    %rdx
    b8dd:	48 ff ce             	dec    %rsi
    b8e0:	75 ee                	jne    b8d0 <fwp_apply_owned+0xf0>
    b8e2:	4c 29 f1             	sub    %r14,%rcx
    b8e5:	48 83 f9 fc          	cmp    $0xfffffffffffffffc,%rcx
    b8e9:	0f 87 81 00 00 00    	ja     b970 <fwp_apply_owned+0x190>
    b8ef:	90                   	nop
    b8f0:	49 8b 4c d4 08       	mov    0x8(%r12,%rdx,8),%rcx
    b8f5:	49 89 4c d5 00       	mov    %rcx,0x0(%r13,%rdx,8)
    b8fa:	49 8b 4c d4 10       	mov    0x10(%r12,%rdx,8),%rcx
    b8ff:	49 89 4c d5 08       	mov    %rcx,0x8(%r13,%rdx,8)
    b904:	49 8b 4c d4 18       	mov    0x18(%r12,%rdx,8),%rcx
    b909:	49 89 4c d5 10       	mov    %rcx,0x10(%r13,%rdx,8)
    b90e:	49 8b 4c d4 20       	mov    0x20(%r12,%rdx,8),%rcx
    b913:	49 89 4c d5 18       	mov    %rcx,0x18(%r13,%rdx,8)
    b918:	48 83 c2 04          	add    $0x4,%rdx
    b91c:	49 39 d6             	cmp    %rdx,%r14
    b91f:	75 cf                	jne    b8f0 <fwp_apply_owned+0x110>
    b921:	eb 4d                	jmp    b970 <fwp_apply_owned+0x190>
    b923:	44 89 f1             	mov    %r14d,%ecx
    b926:	83 e1 fc             	and    $0xfffffffc,%ecx
    b929:	4a 8d 14 f5 00 00 00 	lea    0x0(,%r14,8),%rdx
    b930:	00 
    b931:	48 83 e2 e0          	and    $0xffffffffffffffe0,%rdx
    b935:	31 f6                	xor    %esi,%esi
    b937:	66 0f 1f 84 00 00 00 	nopw   0x0(%rax,%rax,1)
    b93e:	00 00 
    b940:	41 0f 10 44 34 08    	movups 0x8(%r12,%rsi,1),%xmm0
    b946:	41 0f 10 4c 34 18    	movups 0x18(%r12,%rsi,1),%xmm1
    b94c:	41 0f 29 44 35 00    	movaps %xmm0,0x0(%r13,%rsi,1)
    b952:	41 0f 29 4c 35 10    	movaps %xmm1,0x10(%r13,%rsi,1)
    b958:	48 83 c6 20          	add    $0x20,%rsi
    b95c:	48 39 f2             	cmp    %rsi,%rdx
    b95f:	75 df                	jne    b940 <fwp_apply_owned+0x160>
    b961:	4c 39 f1             	cmp    %r14,%rcx
    b964:	0f 85 4e ff ff ff    	jne    b8b8 <fwp_apply_owned+0xd8>
    b96a:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)
    b970:	44 39 f0             	cmp    %r14d,%eax
    b973:	0f 84 f7 00 00 00    	je     ba70 <fwp_apply_owned+0x290>
    b979:	41 83 ff 0a          	cmp    $0xa,%r15d
    b97d:	0f 83 95 00 00 00    	jae    ba18 <fwp_apply_owned+0x238>
    b983:	31 c0                	xor    %eax,%eax
    b985:	4c 89 d2             	mov    %r10,%rdx
    b988:	48 89 c1             	mov    %rax,%rcx
    b98b:	48 83 e2 03          	and    $0x3,%rdx
    b98f:	74 24                	je     b9b5 <fwp_apply_owned+0x1d5>
    b991:	48 89 c1             	mov    %rax,%rcx
    b994:	66 66 66 2e 0f 1f 84 	data16 data16 cs nopw 0x0(%rax,%rax,1)
    b99b:	00 00 00 00 00 
    b9a0:	48 8b 34 cb          	mov    (%rbx,%rcx,8),%rsi
    b9a4:	41 8d 3c 0e          	lea    (%r14,%rcx,1),%edi
    b9a8:	49 89 74 fd 00       	mov    %rsi,0x0(%r13,%rdi,8)
    b9ad:	48 ff c1             	inc    %rcx
    b9b0:	48 ff ca             	dec    %rdx
    b9b3:	75 eb                	jne    b9a0 <fwp_apply_owned+0x1c0>
    b9b5:	4c 29 d0             	sub    %r10,%rax
    b9b8:	48 83 f8 fc          	cmp    $0xfffffffffffffffc,%rax
    b9bc:	0f 87 ae 00 00 00    	ja     ba70 <fwp_apply_owned+0x290>
    b9c2:	66 66 66 66 66 2e 0f 	data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    b9c9:	1f 84 00 00 00 00 00 
    b9d0:	48 8b 04 cb          	mov    (%rbx,%rcx,8),%rax
    b9d4:	41 8d 14 0e          	lea    (%r14,%rcx,1),%edx
    b9d8:	49 89 44 d5 00       	mov    %rax,0x0(%r13,%rdx,8)
    b9dd:	48 8b 44 cb 08       	mov    0x8(%rbx,%rcx,8),%rax
    b9e2:	41 8d 14 0e          	lea    (%r14,%rcx,1),%edx
    b9e6:	ff c2                	inc    %edx
    b9e8:	49 89 44 d5 00       	mov    %rax,0x0(%r13,%rdx,8)
    b9ed:	48 8b 44 cb 10       	mov    0x10(%rbx,%rcx,8),%rax
    b9f2:	41 8d 54 0e 02       	lea    0x2(%r14,%rcx,1),%edx
    b9f7:	49 89 44 d5 00       	mov    %rax,0x0(%r13,%rdx,8)
    b9fc:	48 8b 44 cb 18       	mov    0x18(%rbx,%rcx,8),%rax
    ba01:	41 8d 14 0e          	lea    (%r14,%rcx,1),%edx
    ba05:	83 c2 03             	add    $0x3,%edx
    ba08:	49 89 44 d5 00       	mov    %rax,0x0(%r13,%rdx,8)
    ba0d:	48 83 c1 04          	add    $0x4,%rcx
    ba11:	49 39 ca             	cmp    %rcx,%r10
    ba14:	75 ba                	jne    b9d0 <fwp_apply_owned+0x1f0>
    ba16:	eb 58                	jmp    ba70 <fwp_apply_owned+0x290>
    ba18:	49 8d 42 ff          	lea    -0x1(%r10),%rax
    ba1c:	89 c1                	mov    %eax,%ecx
    ba1e:	44 01 f1             	add    %r14d,%ecx
    ba21:	0f 82 5c ff ff ff    	jb     b983 <fwp_apply_owned+0x1a3>
    ba27:	48 c1 e8 20          	shr    $0x20,%rax
    ba2b:	b8 00 00 00 00       	mov    $0x0,%eax
    ba30:	0f 85 4f ff ff ff    	jne    b985 <fwp_apply_owned+0x1a5>
    ba36:	44 89 d0             	mov    %r10d,%eax
    ba39:	83 e0 fc             	and    $0xfffffffc,%eax
    ba3c:	31 c9                	xor    %ecx,%ecx
    ba3e:	66 90                	xchg   %ax,%ax
    ba40:	0f 10 04 cb          	movups (%rbx,%rcx,8),%xmm0
    ba44:	0f 10 4c cb 10       	movups 0x10(%rbx,%rcx,8),%xmm1
    ba49:	41 8d 14 0e          	lea    (%r14,%rcx,1),%edx
    ba4d:	41 0f 11 44 d5 00    	movups %xmm0,0x0(%r13,%rdx,8)
    ba53:	41 0f 11 4c d5 10    	movups %xmm1,0x10(%r13,%rdx,8)
    ba59:	48 83 c1 04          	add    $0x4,%rcx
    ba5d:	48 39 c8             	cmp    %rcx,%rax
    ba60:	75 de                	jne    ba40 <fwp_apply_owned+0x260>
    ba62:	4c 39 d0             	cmp    %r10,%rax
    ba65:	0f 85 1a ff ff ff    	jne    b985 <fwp_apply_owned+0x1a5>
    ba6b:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)
    ba70:	49 8b 00             	mov    (%r8),%rax
    ba73:	4c 8b 75 c0          	mov    -0x40(%rbp),%r14
    ba77:	4c 89 f7             	mov    %r14,%rdi
    ba7a:	be 01 00 00 00       	mov    $0x1,%esi
    ba7f:	4d 89 c4             	mov    %r8,%r12
    ba82:	ff 50 08             	call   *0x8(%rax)
    ba85:	49 8b 04 24          	mov    (%r12),%rax
    ba89:	4c 89 ef             	mov    %r13,%rdi
    ba8c:	ff 10                	call   *(%rax)
    ba8e:	49 89 c4             	mov    %rax,%r12
    ba91:	48 8b 65 b8          	mov    -0x48(%rbp),%rsp
    ba95:	4c 8b 6d c8          	mov    -0x38(%rbp),%r13
    ba99:	4c 89 f7             	mov    %r14,%rdi
    ba9c:	e8 af 05 00 00       	call   c050 <fwp_closure_drop>
    baa1:	45 29 fd             	sub    %r15d,%r13d
    baa4:	0f 84 89 05 00 00    	je     c033 <fwp_apply_owned+0x853>
    baaa:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
    baae:	48 8d 1c c3          	lea    (%rbx,%rax,8),%rbx
    bab2:	48 8b 05 07 81 00 00 	mov    0x8107(%rip),%rax        # 13bc0 <fwp_fns>
    bab9:	41 8b 14 24          	mov    (%r12),%edx
    babd:	48 89 d1             	mov    %rdx,%rcx
    bac0:	48 c1 e1 05          	shl    $0x5,%rcx
    bac4:	4c 8d 04 08          	lea    (%rax,%rcx,1),%r8
    bac8:	49 83 c0 18          	add    $0x18,%r8
    bacc:	48 8b 4c 08 18       	mov    0x18(%rax,%rcx,1),%rcx
    bad1:	4c 89 e7             	mov    %r12,%rdi
    bad4:	48 85 c9             	test   %rcx,%rcx
    bad7:	0f 85 43 fd ff ff    	jne    b820 <fwp_apply_owned+0x40>
    badd:	eb 03                	jmp    bae2 <fwp_apply_owned+0x302>
    badf:	49 89 fc             	mov    %rdi,%r12
    bae2:	48 8b 05 c7 76 00 00 	mov    0x76c7(%rip),%rax        # 131b0 <fwp_gc+0x1030>
    bae9:	4c 89 e2             	mov    %r12,%rdx
    baec:	48 29 c2             	sub    %rax,%rdx
    baef:	48 8b 0d e2 76 00 00 	mov    0x76e2(%rip),%rcx        # 131d8 <fwp_gc+0x1058>
    baf6:	48 c1 e1 10          	shl    $0x10,%rcx
    bafa:	48 39 ca             	cmp    %rcx,%rdx
    bafd:	0f 83 12 01 00 00    	jae    bc15 <fwp_apply_owned+0x435>
    bb03:	48 8b 35 ee 76 00 00 	mov    0x76ee(%rip),%rsi        # 131f8 <fwp_gc+0x1078>
    bb0a:	48 89 d7             	mov    %rdx,%rdi
    bb0d:	48 c1 ef 10          	shr    $0x10,%rdi
    bb11:	48 69 ff 28 12 00 00 	imul   $0x1228,%rdi,%rdi
    bb18:	44 0f b6 04 3e       	movzbl (%rsi,%rdi,1),%r8d
    bb1d:	48 81 e2 ff ff 00 00 	and    $0xffff,%rdx
    bb24:	0f 85 c2 00 00 00    	jne    bbec <fwp_apply_owned+0x40c>
    bb2a:	41 80 f8 02          	cmp    $0x2,%r8b
    bb2e:	0f 85 b8 00 00 00    	jne    bbec <fwp_apply_owned+0x40c>
    bb34:	48 8d 14 3e          	lea    (%rsi,%rdi,1),%rdx
    bb38:	48 81 c2 28 02 00 00 	add    $0x228,%rdx
    bb3f:	80 3a 00             	cmpb   $0x0,(%rdx)
    bb42:	0f 84 cd 00 00 00    	je     bc15 <fwp_apply_owned+0x435>
    bb48:	e9 55 01 00 00       	jmp    bca2 <fwp_apply_owned+0x4c2>
    bb4d:	4c 89 45 d0          	mov    %r8,-0x30(%rbp)
    bb51:	4c 89 6d c8          	mov    %r13,-0x38(%rbp)
    bb55:	44 89 f9             	mov    %r15d,%ecx
    bb58:	48 8d 3c cd 08 00 00 	lea    0x8(,%rcx,8),%rdi
    bb5f:	00 
    bb60:	41 81 ff ff 07 00 00 	cmp    $0x7ff,%r15d
    bb67:	0f 87 f0 01 00 00    	ja     bd5d <fwp_apply_owned+0x57d>
    bb6d:	48 c1 e1 03          	shl    $0x3,%rcx
    bb71:	4c 8d 41 17          	lea    0x17(%rcx),%r8
    bb75:	49 c1 e8 04          	shr    $0x4,%r8
    bb79:	48 8d 05 00 66 00 00 	lea    0x6600(%rip),%rax        # 12180 <fwp_gc>
    bb80:	41 0f b6 b4 00 e8 0b 	movzbl 0xbe8(%r8,%rax,1),%esi
    bb87:	00 00 
    bb89:	8b 94 b0 48 0b 00 00 	mov    0xb48(%rax,%rsi,4),%edx
    bb90:	4c 8b 0d e9 65 00 00 	mov    0x65e9(%rip),%r9        # 12180 <fwp_gc>
    bb97:	4d 89 ca             	mov    %r9,%r10
    bb9a:	49 29 d2             	sub    %rdx,%r10
    bb9d:	4c 89 15 dc 65 00 00 	mov    %r10,0x65dc(%rip)        # 12180 <fwp_gc>
    bba4:	0f 88 b3 01 00 00    	js     bd5d <fwp_apply_owned+0x57d>
    bbaa:	4c 8d 14 76          	lea    (%rsi,%rsi,2),%r10
    bbae:	4e 8d 1c d0          	lea    (%rax,%r10,8),%r11
    bbb2:	49 83 c3 08          	add    $0x8,%r11
    bbb6:	4d 8b 2b             	mov    (%r11),%r13
    bbb9:	4d 85 ed             	test   %r13,%r13
    bbbc:	0f 84 24 01 00 00    	je     bce6 <fwp_apply_owned+0x506>
    bbc2:	49 8b 45 00          	mov    0x0(%r13),%rax
    bbc6:	48 f7 d0             	not    %rax
    bbc9:	49 89 03             	mov    %rax,(%r11)
    bbcc:	48 39 d7             	cmp    %rdx,%rdi
    bbcf:	0f 83 ad 01 00 00    	jae    bd82 <fwp_apply_owned+0x5a2>
    bbd5:	4c 01 ef             	add    %r13,%rdi
    bbd8:	48 29 ca             	sub    %rcx,%rdx
    bbdb:	48 83 c2 f7          	add    $0xfffffffffffffff7,%rdx
    bbdf:	48 83 e2 f8          	and    $0xfffffffffffffff8,%rdx
    bbe3:	48 83 c2 08          	add    $0x8,%rdx
    bbe7:	e9 8f 01 00 00       	jmp    bd7b <fwp_apply_owned+0x59b>
    bbec:	41 80 f8 01          	cmp    $0x1,%r8b
    bbf0:	75 23                	jne    bc15 <fwp_apply_owned+0x435>
    bbf2:	4c 8d 04 3e          	lea    (%rsi,%rdi,1),%r8
    bbf6:	8b 74 3e 20          	mov    0x20(%rsi,%rdi,1),%esi
    bbfa:	48 0f af d6          	imul   %rsi,%rdx
    bbfe:	48 c1 ea 20          	shr    $0x20,%rdx
    bc02:	4c 01 c2             	add    %r8,%rdx
    bc05:	48 81 c2 28 02 00 00 	add    $0x228,%rdx
    bc0c:	80 3a 00             	cmpb   $0x0,(%rdx)
    bc0f:	0f 85 8d 00 00 00    	jne    bca2 <fwp_apply_owned+0x4c2>
    bc15:	45 85 ed             	test   %r13d,%r13d
    bc18:	0f 84 b2 00 00 00    	je     bcd0 <fwp_apply_owned+0x4f0>
    bc1e:	48 8b 15 d3 75 00 00 	mov    0x75d3(%rip),%rdx        # 131f8 <fwp_gc+0x1078>
    bc25:	44 89 ee             	mov    %r13d,%esi
    bc28:	31 ff                	xor    %edi,%edi
    bc2a:	eb 21                	jmp    bc4d <fwp_apply_owned+0x46d>
    bc2c:	0f 1f 40 00          	nopl   0x0(%rax)
    bc30:	4e 8d 04 0a          	lea    (%rdx,%r9,1),%r8
    bc34:	49 81 c0 28 02 00 00 	add    $0x228,%r8
    bc3b:	41 80 38 00          	cmpb   $0x0,(%r8)
    bc3f:	75 61                	jne    bca2 <fwp_apply_owned+0x4c2>
    bc41:	48 ff c7             	inc    %rdi
    bc44:	48 39 fe             	cmp    %rdi,%rsi
    bc47:	0f 84 83 00 00 00    	je     bcd0 <fwp_apply_owned+0x4f0>
    bc4d:	4c 8b 04 fb          	mov    (%rbx,%rdi,8),%r8
    bc51:	49 29 c0             	sub    %rax,%r8
    bc54:	49 39 c8             	cmp    %rcx,%r8
    bc57:	73 e8                	jae    bc41 <fwp_apply_owned+0x461>
    bc59:	4d 89 c1             	mov    %r8,%r9
    bc5c:	49 c1 e9 10          	shr    $0x10,%r9
    bc60:	4d 69 c9 28 12 00 00 	imul   $0x1228,%r9,%r9
    bc67:	46 0f b6 14 0a       	movzbl (%rdx,%r9,1),%r10d
    bc6c:	49 81 e0 ff ff 00 00 	and    $0xffff,%r8
    bc73:	75 06                	jne    bc7b <fwp_apply_owned+0x49b>
    bc75:	41 80 fa 02          	cmp    $0x2,%r10b
    bc79:	74 b5                	je     bc30 <fwp_apply_owned+0x450>
    bc7b:	41 80 fa 01          	cmp    $0x1,%r10b
    bc7f:	75 c0                	jne    bc41 <fwp_apply_owned+0x461>
    bc81:	4e 8d 14 0a          	lea    (%rdx,%r9,1),%r10
    bc85:	46 8b 4c 0a 20       	mov    0x20(%rdx,%r9,1),%r9d
    bc8a:	4d 0f af c1          	imul   %r9,%r8
    bc8e:	49 c1 e8 20          	shr    $0x20,%r8
    bc92:	4d 01 d0             	add    %r10,%r8
    bc95:	49 81 c0 28 02 00 00 	add    $0x228,%r8
    bc9c:	41 80 38 00          	cmpb   $0x0,(%r8)
    bca0:	74 9f                	je     bc41 <fwp_apply_owned+0x461>
    bca2:	e8 89 a6 ff ff       	call   6330 <fwp_flush>
    bca7:	48 8b 05 32 63 00 00 	mov    0x6332(%rip),%rax        # 11fe0 <stderr@GLIBC_2.2.5>
    bcae:	48 8b 38             	mov    (%rax),%rdi
    bcb1:	48 8d 35 75 37 00 00 	lea    0x3775(%rip),%rsi        # f42d <fwp_segv.msg+0x1ed>
    bcb8:	48 8d 15 41 37 00 00 	lea    0x3741(%rip),%rdx        # f400 <fwp_segv.msg+0x1c0>
    bcbf:	31 c0                	xor    %eax,%eax
    bcc1:	e8 ea 64 ff ff       	call   21b0 <fprintf@plt>
    bcc6:	bf 65 00 00 00       	mov    $0x65,%edi
    bccb:	e8 c0 65 ff ff       	call   2290 <exit@plt>
    bcd0:	4c 89 e7             	mov    %r12,%rdi
    bcd3:	44 89 ee             	mov    %r13d,%esi
    bcd6:	48 89 da             	mov    %rbx,%rdx
    bcd9:	e8 a2 f5 ff ff       	call   b280 <fwp_apply>
    bcde:	49 89 c4             	mov    %rax,%r12
    bce1:	e9 4d 03 00 00       	jmp    c033 <fwp_apply_owned+0x853>
    bce6:	4e 8b 6c d0 10       	mov    0x10(%rax,%r10,8),%r13
    bceb:	4e 8b 5c d0 18       	mov    0x18(%rax,%r10,8),%r11
    bcf0:	4d 29 eb             	sub    %r13,%r11
    bcf3:	49 39 d3             	cmp    %rdx,%r11
    bcf6:	72 34                	jb     bd2c <fwp_apply_owned+0x54c>
    bcf8:	4a 8d 34 d0          	lea    (%rax,%r10,8),%rsi
    bcfc:	48 83 c6 10          	add    $0x10,%rsi
    bd00:	4e 8d 14 2a          	lea    (%rdx,%r13,1),%r10
    bd04:	4c 89 16             	mov    %r10,(%rsi)
    bd07:	4d 85 ed             	test   %r13,%r13
    bd0a:	0f 85 bc fe ff ff    	jne    bbcc <fwp_apply_owned+0x3ec>
    bd10:	41 0f b6 b4 00 e8 0b 	movzbl 0xbe8(%r8,%rax,1),%esi
    bd17:	00 00 
    bd19:	8b 94 b0 48 0b 00 00 	mov    0xb48(%rax,%rsi,4),%edx
    bd20:	49 29 d1             	sub    %rdx,%r9
    bd23:	4c 89 0d 56 64 00 00 	mov    %r9,0x6456(%rip)        # 12180 <fwp_gc>
    bd2a:	78 31                	js     bd5d <fwp_apply_owned+0x57d>
    bd2c:	48 8d 0c 76          	lea    (%rsi,%rsi,2),%rcx
    bd30:	4c 8b 6c c8 08       	mov    0x8(%rax,%rcx,8),%r13
    bd35:	4d 85 ed             	test   %r13,%r13
    bd38:	74 11                	je     bd4b <fwp_apply_owned+0x56b>
    bd3a:	48 8d 04 c8          	lea    (%rax,%rcx,8),%rax
    bd3e:	48 83 c0 08          	add    $0x8,%rax
    bd42:	49 8b 4d 00          	mov    0x0(%r13),%rcx
    bd46:	48 f7 d1             	not    %rcx
    bd49:	eb 2a                	jmp    bd75 <fwp_apply_owned+0x595>
    bd4b:	4c 8b 6c c8 10       	mov    0x10(%rax,%rcx,8),%r13
    bd50:	48 8b 74 c8 18       	mov    0x18(%rax,%rcx,8),%rsi
    bd55:	4c 29 ee             	sub    %r13,%rsi
    bd58:	48 39 d6             	cmp    %rdx,%rsi
    bd5b:	73 0c                	jae    bd69 <fwp_apply_owned+0x589>
    bd5d:	31 f6                	xor    %esi,%esi
    bd5f:	e8 1c aa ff ff       	call   6780 <fwp_gc_alloc_slow>
    bd64:	49 89 c5             	mov    %rax,%r13
    bd67:	eb 19                	jmp    bd82 <fwp_apply_owned+0x5a2>
    bd69:	48 8d 04 c8          	lea    (%rax,%rcx,8),%rax
    bd6d:	48 83 c0 10          	add    $0x10,%rax
    bd71:	4a 8d 0c 2a          	lea    (%rdx,%r13,1),%rcx
    bd75:	48 89 08             	mov    %rcx,(%rax)
    bd78:	4c 89 ef             	mov    %r13,%rdi
    bd7b:	31 f6                	xor    %esi,%esi
    bd7d:	e8 ae 63 ff ff       	call   2130 <memset@plt>
    bd82:	4c 8b 4d d0          	mov    -0x30(%rbp),%r9
    bd86:	41 8b 04 24          	mov    (%r12),%eax
    bd8a:	41 89 45 00          	mov    %eax,0x0(%r13)
    bd8e:	45 89 7d 04          	mov    %r15d,0x4(%r13)
    bd92:	4d 85 f6             	test   %r14,%r14
    bd95:	0f 84 c6 00 00 00    	je     be61 <fwp_apply_owned+0x681>
    bd9b:	31 c0                	xor    %eax,%eax
    bd9d:	41 83 fe 06          	cmp    $0x6,%r14d
    bda1:	72 53                	jb     bdf6 <fwp_apply_owned+0x616>
    bda3:	4c 89 e9             	mov    %r13,%rcx
    bda6:	4c 29 e1             	sub    %r12,%rcx
    bda9:	48 83 f9 20          	cmp    $0x20,%rcx
    bdad:	72 47                	jb     bdf6 <fwp_apply_owned+0x616>
    bdaf:	44 89 f0             	mov    %r14d,%eax
    bdb2:	83 e0 fc             	and    $0xfffffffc,%eax
    bdb5:	4a 8d 0c f5 00 00 00 	lea    0x0(,%r14,8),%rcx
    bdbc:	00 
    bdbd:	48 83 e1 e0          	and    $0xffffffffffffffe0,%rcx
    bdc1:	31 d2                	xor    %edx,%edx
    bdc3:	66 66 66 66 2e 0f 1f 	data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    bdca:	84 00 00 00 00 00 
    bdd0:	41 0f 10 44 14 08    	movups 0x8(%r12,%rdx,1),%xmm0
    bdd6:	41 0f 10 4c 14 18    	movups 0x18(%r12,%rdx,1),%xmm1
    bddc:	41 0f 11 44 15 08    	movups %xmm0,0x8(%r13,%rdx,1)
    bde2:	41 0f 11 4c 15 18    	movups %xmm1,0x18(%r13,%rdx,1)
    bde8:	48 83 c2 20          	add    $0x20,%rdx
    bdec:	48 39 d1             	cmp    %rdx,%rcx
    bdef:	75 df                	jne    bdd0 <fwp_apply_owned+0x5f0>
    bdf1:	4c 39 f0             	cmp    %r14,%rax
    bdf4:	74 6b                	je     be61 <fwp_apply_owned+0x681>
    bdf6:	4c 89 f2             	mov    %r14,%rdx
    bdf9:	48 89 c1             	mov    %rax,%rcx
    bdfc:	48 83 e2 03          	and    $0x3,%rdx
    be00:	74 20                	je     be22 <fwp_apply_owned+0x642>
    be02:	48 89 c1             	mov    %rax,%rcx
    be05:	66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
    be0c:	00 00 00 00 
    be10:	49 8b 74 cc 08       	mov    0x8(%r12,%rcx,8),%rsi
    be15:	49 89 74 cd 08       	mov    %rsi,0x8(%r13,%rcx,8)
    be1a:	48 ff c1             	inc    %rcx
    be1d:	48 ff ca             	dec    %rdx
    be20:	75 ee                	jne    be10 <fwp_apply_owned+0x630>
    be22:	4c 29 f0             	sub    %r14,%rax
    be25:	48 83 f8 fc          	cmp    $0xfffffffffffffffc,%rax
    be29:	77 36                	ja     be61 <fwp_apply_owned+0x681>
    be2b:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)
    be30:	49 8b 44 cc 08       	mov    0x8(%r12,%rcx,8),%rax
    be35:	49 89 44 cd 08       	mov    %rax,0x8(%r13,%rcx,8)
    be3a:	49 8b 44 cc 10       	mov    0x10(%r12,%rcx,8),%rax
    be3f:	49 89 44 cd 10       	mov    %rax,0x10(%r13,%rcx,8)
    be44:	49 8b 44 cc 18       	mov    0x18(%r12,%rcx,8),%rax
    be49:	49 89 44 cd 18       	mov    %rax,0x18(%r13,%rcx,8)
    be4e:	49 8b 44 cc 20       	mov    0x20(%r12,%rcx,8),%rax
    be53:	49 89 44 cd 20       	mov    %rax,0x20(%r13,%rcx,8)
    be58:	48 83 c1 04          	add    $0x4,%rcx
    be5c:	49 39 ce             	cmp    %rcx,%r14
    be5f:	75 cf                	jne    be30 <fwp_apply_owned+0x650>
    be61:	48 8b 4d c8          	mov    -0x38(%rbp),%rcx
    be65:	85 c9                	test   %ecx,%ecx
    be67:	0f 84 89 00 00 00    	je     bef6 <fwp_apply_owned+0x716>
    be6d:	89 c8                	mov    %ecx,%eax
    be6f:	83 f9 14             	cmp    $0x14,%ecx
    be72:	0f 83 fb 00 00 00    	jae    bf73 <fwp_apply_owned+0x793>
    be78:	31 c9                	xor    %ecx,%ecx
    be7a:	48 89 c6             	mov    %rax,%rsi
    be7d:	48 89 ca             	mov    %rcx,%rdx
    be80:	48 83 e6 03          	and    $0x3,%rsi
    be84:	74 1f                	je     bea5 <fwp_apply_owned+0x6c5>
    be86:	48 89 ca             	mov    %rcx,%rdx
    be89:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)
    be90:	48 8b 3c d3          	mov    (%rbx,%rdx,8),%rdi
    be94:	45 8d 04 16          	lea    (%r14,%rdx,1),%r8d
    be98:	4b 89 7c c5 08       	mov    %rdi,0x8(%r13,%r8,8)
    be9d:	48 ff c2             	inc    %rdx
    bea0:	48 ff ce             	dec    %rsi
    bea3:	75 eb                	jne    be90 <fwp_apply_owned+0x6b0>
    bea5:	48 29 c1             	sub    %rax,%rcx
    bea8:	48 83 f9 fc          	cmp    $0xfffffffffffffffc,%rcx
    beac:	77 48                	ja     bef6 <fwp_apply_owned+0x716>
    beae:	66 90                	xchg   %ax,%ax
    beb0:	48 8b 0c d3          	mov    (%rbx,%rdx,8),%rcx
    beb4:	41 8d 34 16          	lea    (%r14,%rdx,1),%esi
    beb8:	49 89 4c f5 08       	mov    %rcx,0x8(%r13,%rsi,8)
    bebd:	48 8b 4c d3 08       	mov    0x8(%rbx,%rdx,8),%rcx
    bec2:	41 8d 34 16          	lea    (%r14,%rdx,1),%esi
    bec6:	ff c6                	inc    %esi
    bec8:	49 89 4c f5 08       	mov    %rcx,0x8(%r13,%rsi,8)
    becd:	48 8b 4c d3 10       	mov    0x10(%rbx,%rdx,8),%rcx
    bed2:	41 8d 74 16 02       	lea    0x2(%r14,%rdx,1),%esi
    bed7:	49 89 4c f5 08       	mov    %rcx,0x8(%r13,%rsi,8)
    bedc:	48 8b 4c d3 18       	mov    0x18(%rbx,%rdx,8),%rcx
    bee1:	41 8d 34 16          	lea    (%r14,%rdx,1),%esi
    bee5:	83 c6 03             	add    $0x3,%esi
    bee8:	49 89 4c f5 08       	mov    %rcx,0x8(%r13,%rsi,8)
    beed:	48 83 c2 04          	add    $0x4,%rdx
    bef1:	48 39 d0             	cmp    %rdx,%rax
    bef4:	75 ba                	jne    beb0 <fwp_apply_owned+0x6d0>
    bef6:	49 8b 01             	mov    (%r9),%rax
    bef9:	4c 8b 75 c0          	mov    -0x40(%rbp),%r14
    befd:	4c 89 f7             	mov    %r14,%rdi
    bf00:	be 01 00 00 00       	mov    $0x1,%esi
    bf05:	ff 50 08             	call   *0x8(%rax)
    bf08:	4c 89 e8             	mov    %r13,%rax
    bf0b:	48 2b 05 9e 72 00 00 	sub    0x729e(%rip),%rax        # 131b0 <fwp_gc+0x1030>
    bf12:	48 8b 0d bf 72 00 00 	mov    0x72bf(%rip),%rcx        # 131d8 <fwp_gc+0x1058>
    bf19:	48 c1 e1 10          	shl    $0x10,%rcx
    bf1d:	48 39 c8             	cmp    %rcx,%rax
    bf20:	0f 83 02 01 00 00    	jae    c028 <fwp_apply_owned+0x848>
    bf26:	48 8b 0d cb 72 00 00 	mov    0x72cb(%rip),%rcx        # 131f8 <fwp_gc+0x1078>
    bf2d:	48 89 c2             	mov    %rax,%rdx
    bf30:	48 c1 ea 10          	shr    $0x10,%rdx
    bf34:	48 69 d2 28 12 00 00 	imul   $0x1228,%rdx,%rdx
    bf3b:	0f b6 34 11          	movzbl (%rcx,%rdx,1),%esi
    bf3f:	48 25 ff ff 00 00    	and    $0xffff,%rax
    bf45:	0f 85 a5 00 00 00    	jne    bff0 <fwp_apply_owned+0x810>
    bf4b:	40 80 fe 02          	cmp    $0x2,%sil
    bf4f:	0f 85 9b 00 00 00    	jne    bff0 <fwp_apply_owned+0x810>
    bf55:	4c 8d 3c 11          	lea    (%rcx,%rdx,1),%r15
    bf59:	49 81 c7 28 02 00 00 	add    $0x228,%r15
    bf60:	41 80 3f ff          	cmpb   $0xff,(%r15)
    bf64:	0f 84 b1 00 00 00    	je     c01b <fwp_apply_owned+0x83b>
    bf6a:	41 c6 07 01          	movb   $0x1,(%r15)
    bf6e:	e9 b5 00 00 00       	jmp    c028 <fwp_apply_owned+0x848>
    bf73:	48 8d 50 ff          	lea    -0x1(%rax),%rdx
    bf77:	31 c9                	xor    %ecx,%ecx
    bf79:	89 d6                	mov    %edx,%esi
    bf7b:	44 01 f6             	add    %r14d,%esi
    bf7e:	0f 82 f6 fe ff ff    	jb     be7a <fwp_apply_owned+0x69a>
    bf84:	48 c1 ea 20          	shr    $0x20,%rdx
    bf88:	0f 85 ec fe ff ff    	jne    be7a <fwp_apply_owned+0x69a>
    bf8e:	4a 8d 0c f5 00 00 00 	lea    0x0(,%r14,8),%rcx
    bf95:	00 
    bf96:	4c 01 e9             	add    %r13,%rcx
    bf99:	48 29 d9             	sub    %rbx,%rcx
    bf9c:	48 83 c1 08          	add    $0x8,%rcx
    bfa0:	48 83 f9 20          	cmp    $0x20,%rcx
    bfa4:	0f 82 ce fe ff ff    	jb     be78 <fwp_apply_owned+0x698>
    bfaa:	89 c1                	mov    %eax,%ecx
    bfac:	83 e1 fc             	and    $0xfffffffc,%ecx
    bfaf:	31 d2                	xor    %edx,%edx
    bfb1:	66 66 66 66 66 66 2e 	data16 data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    bfb8:	0f 1f 84 00 00 00 00 
    bfbf:	00 
    bfc0:	0f 10 04 d3          	movups (%rbx,%rdx,8),%xmm0
    bfc4:	0f 10 4c d3 10       	movups 0x10(%rbx,%rdx,8),%xmm1
    bfc9:	41 8d 34 16          	lea    (%r14,%rdx,1),%esi
    bfcd:	41 0f 11 44 f5 08    	movups %xmm0,0x8(%r13,%rsi,8)
    bfd3:	41 0f 11 4c f5 18    	movups %xmm1,0x18(%r13,%rsi,8)
    bfd9:	48 83 c2 04          	add    $0x4,%rdx
    bfdd:	48 39 d1             	cmp    %rdx,%rcx
    bfe0:	75 de                	jne    bfc0 <fwp_apply_owned+0x7e0>
    bfe2:	48 39 c1             	cmp    %rax,%rcx
    bfe5:	0f 85 8f fe ff ff    	jne    be7a <fwp_apply_owned+0x69a>
    bfeb:	e9 06 ff ff ff       	jmp    bef6 <fwp_apply_owned+0x716>
    bff0:	40 80 fe 01          	cmp    $0x1,%sil
    bff4:	75 32                	jne    c028 <fwp_apply_owned+0x848>
    bff6:	48 8d 34 11          	lea    (%rcx,%rdx,1),%rsi
    bffa:	8b 4c 11 20          	mov    0x20(%rcx,%rdx,1),%ecx
    bffe:	48 0f af c1          	imul   %rcx,%rax
    c002:	48 c1 e8 20          	shr    $0x20,%rax
    c006:	4c 8d 3c 30          	lea    (%rax,%rsi,1),%r15
    c00a:	49 81 c7 28 02 00 00 	add    $0x228,%r15
    c011:	41 80 3f ff          	cmpb   $0xff,(%r15)
    c015:	0f 85 4f ff ff ff    	jne    bf6a <fwp_apply_owned+0x78a>
    c01b:	4c 89 ff             	mov    %r15,%rdi
    c01e:	e8 3d a3 ff ff       	call   6360 <fwp_rc_forget_slot>
    c023:	e9 42 ff ff ff       	jmp    bf6a <fwp_apply_owned+0x78a>
    c028:	4c 89 f7             	mov    %r14,%rdi
    c02b:	e8 20 00 00 00       	call   c050 <fwp_closure_drop>
    c030:	4d 89 ec             	mov    %r13,%r12
    c033:	4c 89 e0             	mov    %r12,%rax
    c036:	48 8d 65 d8          	lea    -0x28(%rbp),%rsp
    c03a:	5b                   	pop    %rbx
    c03b:	41 5c                	pop    %r12
    c03d:	41 5d                	pop    %r13
    c03f:	41 5e                	pop    %r14
    c041:	41 5f                	pop    %r15
    c043:	5d                   	pop    %rbp
    c044:	c3                   	ret
    c045:	66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
    c04c:	00 00 00 00 

000000000000c050 <fwp_closure_drop>:
    c050:	41 57                	push   %r15
    c052:	41 56                	push   %r14
    c054:	53                   	push   %rbx
    c055:	48 81 ec 30 02 00 00 	sub    $0x230,%rsp
    c05c:	48 89 f8             	mov    %rdi,%rax
    c05f:	48 2b 05 4a 71 00 00 	sub    0x714a(%rip),%rax        # 131b0 <fwp_gc+0x1030>
    c066:	48 8b 0d 6b 71 00 00 	mov    0x716b(%rip),%rcx        # 131d8 <fwp_gc+0x1058>
    c06d:	48 c1 e1 10          	shl    $0x10,%rcx
    c071:	48 39 c8             	cmp    %rcx,%rax
    c074:	0f 83 91 00 00 00    	jae    c10b <fwp_closure_drop+0xbb>
    c07a:	48 89 fe             	mov    %rdi,%rsi
    c07d:	48 8b 0d 74 71 00 00 	mov    0x7174(%rip),%rcx        # 131f8 <fwp_gc+0x1078>
    c084:	48 89 c2             	mov    %rax,%rdx
    c087:	48 c1 ea 10          	shr    $0x10,%rdx
    c08b:	48 69 d2 28 12 00 00 	imul   $0x1228,%rdx,%rdx
    c092:	0f b6 3c 11          	movzbl (%rcx,%rdx,1),%edi
    c096:	48 25 ff ff 00 00    	and    $0xffff,%rax
    c09c:	75 13                	jne    c0b1 <fwp_closure_drop+0x61>
    c09e:	40 80 ff 02          	cmp    $0x2,%dil
    c0a2:	75 0d                	jne    c0b1 <fwp_closure_drop+0x61>
    c0a4:	48 8d 3c 11          	lea    (%rcx,%rdx,1),%rdi
    c0a8:	48 81 c7 28 02 00 00 	add    $0x228,%rdi
    c0af:	eb 20                	jmp    c0d1 <fwp_closure_drop+0x81>
    c0b1:	40 80 ff 01          	cmp    $0x1,%dil
    c0b5:	75 54                	jne    c10b <fwp_closure_drop+0xbb>
    c0b7:	48 8d 3c 11          	lea    (%rcx,%rdx,1),%rdi
    c0bb:	8b 4c 11 20          	mov    0x20(%rcx,%rdx,1),%ecx
    c0bf:	48 0f af c1          	imul   %rcx,%rax
    c0c3:	48 c1 e8 20          	shr    $0x20,%rax
    c0c7:	48 01 c7             	add    %rax,%rdi
    c0ca:	48 81 c7 28 02 00 00 	add    $0x228,%rdi
    c0d1:	0f b6 07             	movzbl (%rdi),%eax
    c0d4:	85 c0                	test   %eax,%eax
    c0d6:	74 33                	je     c10b <fwp_closure_drop+0xbb>
    c0d8:	83 f8 01             	cmp    $0x1,%eax
    c0db:	75 1f                	jne    c0fc <fwp_closure_drop+0xac>
    c0dd:	64 48 8b 3c 25 f8 ff 	mov    %fs:0xfffffffffffffff8,%rdi
    c0e4:	ff ff 
    c0e6:	48 85 ff             	test   %rdi,%rdi
    c0e9:	74 2d                	je     c118 <fwp_closure_drop+0xc8>
    c0eb:	48 81 c4 30 02 00 00 	add    $0x230,%rsp
    c0f2:	5b                   	pop    %rbx
    c0f3:	41 5e                	pop    %r14
    c0f5:	41 5f                	pop    %r15
    c0f7:	e9 44 01 00 00       	jmp    c240 <fwp_closure_drop_push>
    c0fc:	3d ff 00 00 00       	cmp    $0xff,%eax
    c101:	0f 84 e7 00 00 00    	je     c1ee <fwp_closure_drop+0x19e>
    c107:	fe c8                	dec    %al
    c109:	88 07                	mov    %al,(%rdi)
    c10b:	48 81 c4 30 02 00 00 	add    $0x230,%rsp
    c112:	5b                   	pop    %rbx
    c113:	41 5e                	pop    %r14
    c115:	41 5f                	pop    %r15
    c117:	c3                   	ret
    c118:	64 48 8b 04 25 00 00 	mov    %fs:0x0,%rax
    c11f:	00 00 
    c121:	4c 8d b0 f8 ff ff ff 	lea    -0x8(%rax),%r14
    c128:	48 8d 5c 24 30       	lea    0x30(%rsp),%rbx
    c12d:	48 89 5c 24 18       	mov    %rbx,0x18(%rsp)
    c132:	48 c7 44 24 20 00 00 	movq   $0x0,0x20(%rsp)
    c139:	00 00 
    c13b:	48 c7 44 24 28 40 00 	movq   $0x40,0x28(%rsp)
    c142:	00 00 
    c144:	48 8b 05 9d 7a 00 00 	mov    0x7a9d(%rip),%rax        # 13be8 <fwp_cleanups>
    c14b:	48 89 04 24          	mov    %rax,(%rsp)
    c14f:	48 8d 05 ca 01 00 00 	lea    0x1ca(%rip),%rax        # c320 <fwp_closure_drop_release>
    c156:	48 89 44 24 08       	mov    %rax,0x8(%rsp)
    c15b:	48 8d 7c 24 18       	lea    0x18(%rsp),%rdi
    c160:	48 89 7c 24 10       	mov    %rdi,0x10(%rsp)
    c165:	49 89 e7             	mov    %rsp,%r15
    c168:	4c 89 3d 79 7a 00 00 	mov    %r15,0x7a79(%rip)        # 13be8 <fwp_cleanups>
    c16f:	49 89 3e             	mov    %rdi,(%r14)
    c172:	e8 c9 00 00 00       	call   c240 <fwp_closure_drop_push>
    c177:	66 0f 1f 84 00 00 00 	nopw   0x0(%rax,%rax,1)
    c17e:	00 00 
    c180:	48 8b 44 24 20       	mov    0x20(%rsp),%rax
    c185:	48 85 c0             	test   %rax,%rax
    c188:	74 31                	je     c1bb <fwp_closure_drop+0x16b>
    c18a:	48 8b 4c 24 18       	mov    0x18(%rsp),%rcx
    c18f:	48 8d 50 ff          	lea    -0x1(%rax),%rdx
    c193:	48 89 54 24 20       	mov    %rdx,0x20(%rsp)
    c198:	48 8b 7c c1 f8       	mov    -0x8(%rcx,%rax,8),%rdi
    c19d:	48 8b 05 1c 7a 00 00 	mov    0x7a1c(%rip),%rax        # 13bc0 <fwp_fns>
    c1a4:	8b 0f                	mov    (%rdi),%ecx
    c1a6:	48 c1 e1 05          	shl    $0x5,%rcx
    c1aa:	48 8b 44 08 18       	mov    0x18(%rax,%rcx,1),%rax
    c1af:	48 85 c0             	test   %rax,%rax
    c1b2:	74 4b                	je     c1ff <fwp_closure_drop+0x1af>
    c1b4:	31 f6                	xor    %esi,%esi
    c1b6:	ff 50 08             	call   *0x8(%rax)
    c1b9:	eb c5                	jmp    c180 <fwp_closure_drop+0x130>
    c1bb:	4c 39 3d 26 7a 00 00 	cmp    %r15,0x7a26(%rip)        # 13be8 <fwp_cleanups>
    c1c2:	75 69                	jne    c22d <fwp_closure_drop+0x1dd>
    c1c4:	48 8b 04 24          	mov    (%rsp),%rax
    c1c8:	48 89 05 19 7a 00 00 	mov    %rax,0x7a19(%rip)        # 13be8 <fwp_cleanups>
    c1cf:	49 c7 06 00 00 00 00 	movq   $0x0,(%r14)
    c1d6:	48 8b 7c 24 18       	mov    0x18(%rsp),%rdi
    c1db:	48 39 df             	cmp    %rbx,%rdi
    c1de:	0f 84 27 ff ff ff    	je     c10b <fwp_closure_drop+0xbb>
    c1e4:	e8 67 5e ff ff       	call   2050 <free@plt>
    c1e9:	e9 1d ff ff ff       	jmp    c10b <fwp_closure_drop+0xbb>
    c1ee:	48 81 c4 30 02 00 00 	add    $0x230,%rsp
    c1f5:	5b                   	pop    %rbx
    c1f6:	41 5e                	pop    %r14
    c1f8:	41 5f                	pop    %r15
    c1fa:	e9 91 e4 ff ff       	jmp    a690 <fwp_rc_wide_drop>
    c1ff:	e8 2c a1 ff ff       	call   6330 <fwp_flush>
    c204:	48 8b 05 d5 5d 00 00 	mov    0x5dd5(%rip),%rax        # 11fe0 <stderr@GLIBC_2.2.5>
    c20b:	48 8b 38             	mov    (%rax),%rdi
    c20e:	48 8d 35 18 32 00 00 	lea    0x3218(%rip),%rsi        # f42d <fwp_segv.msg+0x1ed>
    c215:	48 8d 15 99 34 00 00 	lea    0x3499(%rip),%rdx        # f6b5 <fwp_segv.msg+0x475>
    c21c:	31 c0                	xor    %eax,%eax
    c21e:	e8 8d 5f ff ff       	call   21b0 <fprintf@plt>
    c223:	bf 65 00 00 00       	mov    $0x65,%edi
    c228:	e8 63 60 ff ff       	call   2290 <exit@plt>
    c22d:	e8 2e 5e ff ff       	call   2060 <abort@plt>
    c232:	66 66 66 66 66 2e 0f 	data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    c239:	1f 84 00 00 00 00 00 

000000000000c240 <fwp_closure_drop_push>:
    c240:	55                   	push   %rbp
    c241:	41 57                	push   %r15
    c243:	41 56                	push   %r14
    c245:	41 55                	push   %r13
    c247:	41 54                	push   %r12
    c249:	53                   	push   %rbx
    c24a:	50                   	push   %rax
    c24b:	48 89 f3             	mov    %rsi,%rbx
    c24e:	49 89 fe             	mov    %rdi,%r14
    c251:	4c 8b 6f 08          	mov    0x8(%rdi),%r13
    c255:	4c 3b 6f 10          	cmp    0x10(%rdi),%r13
    c259:	75 59                	jne    c2b4 <fwp_closure_drop_push+0x74>
    c25b:	4c 89 e8             	mov    %r13,%rax
    c25e:	48 c1 e8 3c          	shr    $0x3c,%rax
    c262:	75 6e                	jne    c2d2 <fwp_closure_drop_push+0x92>
    c264:	4c 89 ef             	mov    %r13,%rdi
    c267:	48 c1 e7 04          	shl    $0x4,%rdi
    c26b:	e8 80 5f ff ff       	call   21f0 <malloc@plt>
    c270:	48 85 c0             	test   %rax,%rax
    c273:	74 7c                	je     c2f1 <fwp_closure_drop_push+0xb1>
    c275:	49 89 c7             	mov    %rax,%r15
    c278:	4a 8d 2c 6d 00 00 00 	lea    0x0(,%r13,2),%rbp
    c27f:	00 
    c280:	4d 8b 26             	mov    (%r14),%r12
    c283:	4a 8d 14 ed 00 00 00 	lea    0x0(,%r13,8),%rdx
    c28a:	00 
    c28b:	48 89 c7             	mov    %rax,%rdi
    c28e:	4c 89 e6             	mov    %r12,%rsi
    c291:	e8 4a 5f ff ff       	call   21e0 <memcpy@plt>
    c296:	49 8d 46 18          	lea    0x18(%r14),%rax
    c29a:	49 39 c4             	cmp    %rax,%r12
    c29d:	74 0c                	je     c2ab <fwp_closure_drop_push+0x6b>
    c29f:	4c 89 e7             	mov    %r12,%rdi
    c2a2:	e8 a9 5d ff ff       	call   2050 <free@plt>
    c2a7:	4d 8b 6e 08          	mov    0x8(%r14),%r13
    c2ab:	4d 89 3e             	mov    %r15,(%r14)
    c2ae:	49 89 6e 10          	mov    %rbp,0x10(%r14)
    c2b2:	eb 03                	jmp    c2b7 <fwp_closure_drop_push+0x77>
    c2b4:	4d 8b 3e             	mov    (%r14),%r15
    c2b7:	49 8d 45 01          	lea    0x1(%r13),%rax
    c2bb:	49 89 46 08          	mov    %rax,0x8(%r14)
    c2bf:	4b 89 1c ef          	mov    %rbx,(%r15,%r13,8)
    c2c3:	48 83 c4 08          	add    $0x8,%rsp
    c2c7:	5b                   	pop    %rbx
    c2c8:	41 5c                	pop    %r12
    c2ca:	41 5d                	pop    %r13
    c2cc:	41 5e                	pop    %r14
    c2ce:	41 5f                	pop    %r15
    c2d0:	5d                   	pop    %rbp
    c2d1:	c3                   	ret
    c2d2:	e8 59 a0 ff ff       	call   6330 <fwp_flush>
    c2d7:	48 8b 05 02 5d 00 00 	mov    0x5d02(%rip),%rax        # 11fe0 <stderr@GLIBC_2.2.5>
    c2de:	48 8b 38             	mov    (%rax),%rdi
    c2e1:	48 8d 35 45 31 00 00 	lea    0x3145(%rip),%rsi        # f42d <fwp_segv.msg+0x1ed>
    c2e8:	48 8d 15 f4 33 00 00 	lea    0x33f4(%rip),%rdx        # f6e3 <fwp_segv.msg+0x4a3>
    c2ef:	eb 1d                	jmp    c30e <fwp_closure_drop_push+0xce>
    c2f1:	e8 3a a0 ff ff       	call   6330 <fwp_flush>
    c2f6:	48 8b 05 e3 5c 00 00 	mov    0x5ce3(%rip),%rax        # 11fe0 <stderr@GLIBC_2.2.5>
    c2fd:	48 8b 38             	mov    (%rax),%rdi
    c300:	48 8d 35 26 31 00 00 	lea    0x3126(%rip),%rsi        # f42d <fwp_segv.msg+0x1ed>
    c307:	48 8d 15 ef 33 00 00 	lea    0x33ef(%rip),%rdx        # f6fd <fwp_segv.msg+0x4bd>
    c30e:	31 c0                	xor    %eax,%eax
    c310:	e8 9b 5e ff ff       	call   21b0 <fprintf@plt>
    c315:	bf 65 00 00 00       	mov    $0x65,%edi
    c31a:	e8 71 5f ff ff       	call   2290 <exit@plt>
    c31f:	90                   	nop

000000000000c320 <fwp_closure_drop_release>:
    c320:	41 56                	push   %r14
    c322:	53                   	push   %rbx
    c323:	50                   	push   %rax
    c324:	48 89 fb             	mov    %rdi,%rbx
    c327:	64 48 c7 04 25 f8 ff 	movq   $0x0,%fs:0xfffffffffffffff8
    c32e:	ff ff 00 00 00 00 
    c334:	48 8b 3f             	mov    (%rdi),%rdi
    c337:	4c 8d 73 18          	lea    0x18(%rbx),%r14
    c33b:	4c 39 f7             	cmp    %r14,%rdi
    c33e:	74 05                	je     c345 <fwp_closure_drop_release+0x25>
    c340:	e8 0b 5d ff ff       	call   2050 <free@plt>
    c345:	4c 89 33             	mov    %r14,(%rbx)
    c348:	48 c7 43 08 00 00 00 	movq   $0x0,0x8(%rbx)
    c34f:	00 
    c350:	48 83 c4 08          	add    $0x8,%rsp
    c354:	5b                   	pop    %rbx
    c355:	41 5e                	pop    %r14
    c357:	c3                   	ret
    c358:	0f 1f 84 00 00 00 00 	nopl   0x0(%rax,%rax,1)
    c35f:	00 

000000000000c360 <f52>:
    c360:	41 57                	push   %r15
    c362:	41 56                	push   %r14
    c364:	53                   	push   %rbx
    c365:	48 83 ec 20          	sub    $0x20,%rsp
    c369:	48 89 fb             	mov    %rdi,%rbx
    c36c:	48 8b 47 10          	mov    0x10(%rdi),%rax
    c370:	48 2b 05 39 6e 00 00 	sub    0x6e39(%rip),%rax        # 131b0 <fwp_gc+0x1030>
    c377:	48 8b 0d 5a 6e 00 00 	mov    0x6e5a(%rip),%rcx        # 131d8 <fwp_gc+0x1058>
    c37e:	48 c1 e1 10          	shl    $0x10,%rcx
    c382:	48 39 c8             	cmp    %rcx,%rax
    c385:	73 68                	jae    c3ef <f52+0x8f>
    c387:	48 8b 0d 6a 6e 00 00 	mov    0x6e6a(%rip),%rcx        # 131f8 <fwp_gc+0x1078>
    c38e:	48 89 c2             	mov    %rax,%rdx
    c391:	48 c1 ea 10          	shr    $0x10,%rdx
    c395:	48 69 d2 28 12 00 00 	imul   $0x1228,%rdx,%rdx
    c39c:	0f b6 34 11          	movzbl (%rcx,%rdx,1),%esi
    c3a0:	48 25 ff ff 00 00    	and    $0xffff,%rax
    c3a6:	75 13                	jne    c3bb <f52+0x5b>
    c3a8:	40 80 fe 02          	cmp    $0x2,%sil
    c3ac:	75 0d                	jne    c3bb <f52+0x5b>
    c3ae:	48 8d 3c 11          	lea    (%rcx,%rdx,1),%rdi
    c3b2:	48 81 c7 28 02 00 00 	add    $0x228,%rdi
    c3b9:	eb 21                	jmp    c3dc <f52+0x7c>
    c3bb:	40 80 fe 01          	cmp    $0x1,%sil
    c3bf:	75 2e                	jne    c3ef <f52+0x8f>
    c3c1:	48 8d 34 11          	lea    (%rcx,%rdx,1),%rsi
    c3c5:	8b 4c 11 20          	mov    0x20(%rcx,%rdx,1),%ecx
    c3c9:	48 0f af c1          	imul   %rcx,%rax
    c3cd:	48 c1 e8 20          	shr    $0x20,%rax
    c3d1:	48 8d 3c 30          	lea    (%rax,%rsi,1),%rdi
    c3d5:	48 81 c7 28 02 00 00 	add    $0x228,%rdi
    c3dc:	0f b6 07             	movzbl (%rdi),%eax
    c3df:	84 c0                	test   %al,%al
    c3e1:	74 0c                	je     c3ef <f52+0x8f>
    c3e3:	3c fe                	cmp    $0xfe,%al
    c3e5:	0f 83 e5 02 00 00    	jae    c6d0 <f52+0x370>
    c3eb:	fe c0                	inc    %al
    c3ed:	88 07                	mov    %al,(%rdi)
    c3ef:	4c 8b 7b 08          	mov    0x8(%rbx),%r15
    c3f3:	48 8b 7b 10          	mov    0x10(%rbx),%rdi
    c3f7:	48 8b 43 18          	mov    0x18(%rbx),%rax
    c3fb:	4d 85 ff             	test   %r15,%r15
    c3fe:	78 27                	js     c427 <f52+0xc7>
    c400:	48 8b 0f             	mov    (%rdi),%rcx
    c403:	48 ba ff ff ff ff ff 	movabs $0x7fffffffffffffff,%rdx
    c40a:	ff ff 7f 
    c40d:	48 21 ca             	and    %rcx,%rdx
    c410:	4c 39 fa             	cmp    %r15,%rdx
    c413:	76 12                	jbe    c427 <f52+0xc7>
    c415:	48 85 c9             	test   %rcx,%rcx
    c418:	0f 88 8e 00 00 00    	js     c4ac <f52+0x14c>
    c41e:	48 8d 4f 08          	lea    0x8(%rdi),%rcx
    c422:	e9 89 00 00 00       	jmp    c4b0 <f52+0x150>
    c427:	41 89 c6             	mov    %eax,%r14d
    c42a:	e8 71 03 00 00       	call   c7a0 <fwp_drop8>
    c42f:	48 89 df             	mov    %rbx,%rdi
    c432:	e8 b9 02 00 00       	call   c6f0 <fwp_drop9>
    c437:	48 c7 44 24 08 01 00 	movq   $0x1,0x8(%rsp)
    c43e:	00 00 
    c440:	48 8d 54 24 10       	lea    0x10(%rsp),%rdx
    c445:	4c 89 74 24 10       	mov    %r14,0x10(%rsp)
    c44a:	bf 01 00 00 00       	mov    $0x1,%edi
    c44f:	be 01 00 00 00       	mov    $0x1,%esi
    c454:	e8 d7 d9 ff ff       	call   9e30 <fwp_data>
    c459:	48 89 c1             	mov    %rax,%rcx
    c45c:	48 2b 0d 4d 6d 00 00 	sub    0x6d4d(%rip),%rcx        # 131b0 <fwp_gc+0x1030>
    c463:	48 8b 15 6e 6d 00 00 	mov    0x6d6e(%rip),%rdx        # 131d8 <fwp_gc+0x1058>
    c46a:	48 c1 e2 10          	shl    $0x10,%rdx
    c46e:	48 39 d1             	cmp    %rdx,%rcx
    c471:	0f 83 4f 02 00 00    	jae    c6c6 <f52+0x366>
    c477:	48 8b 15 7a 6d 00 00 	mov    0x6d7a(%rip),%rdx        # 131f8 <fwp_gc+0x1078>
    c47e:	48 89 ce             	mov    %rcx,%rsi
    c481:	48 c1 ee 10          	shr    $0x10,%rsi
    c485:	48 69 f6 28 12 00 00 	imul   $0x1228,%rsi,%rsi
    c48c:	0f b6 3c 32          	movzbl (%rdx,%rsi,1),%edi
    c490:	48 81 e1 ff ff 00 00 	and    $0xffff,%rcx
    c497:	0f 85 f3 01 00 00    	jne    c690 <f52+0x330>
    c49d:	40 80 ff 02          	cmp    $0x2,%dil
    c4a1:	0f 84 d4 01 00 00    	je     c67b <f52+0x31b>
    c4a7:	e9 e4 01 00 00       	jmp    c690 <f52+0x330>
    c4ac:	48 8b 4f 10          	mov    0x10(%rdi),%rcx
    c4b0:	89 44 24 04          	mov    %eax,0x4(%rsp)
    c4b4:	f3 42 0f 10 04 b9    	movss  (%rcx,%r15,4),%xmm0
    c4ba:	f3 0f 59 05 42 2b 00 	mulss  0x2b42(%rip),%xmm0        # f004 <_IO_stdin_used+0x4>
    c4c1:	00 
    c4c2:	f3 0f 58 05 3e 2b 00 	addss  0x2b3e(%rip),%xmm0        # f008 <_IO_stdin_used+0x8>
    c4c9:	00 
    c4ca:	f3 0f 11 04 24       	movss  %xmm0,(%rsp)
    c4cf:	48 89 f8             	mov    %rdi,%rax
    c4d2:	48 2b 05 d7 6c 00 00 	sub    0x6cd7(%rip),%rax        # 131b0 <fwp_gc+0x1030>
    c4d9:	49 ff c7             	inc    %r15
    c4dc:	48 8b 0d f5 6c 00 00 	mov    0x6cf5(%rip),%rcx        # 131d8 <fwp_gc+0x1058>
    c4e3:	48 c1 e1 10          	shl    $0x10,%rcx
    c4e7:	48 39 c8             	cmp    %rcx,%rax
    c4ea:	73 66                	jae    c552 <f52+0x1f2>
    c4ec:	48 8b 0d 05 6d 00 00 	mov    0x6d05(%rip),%rcx        # 131f8 <fwp_gc+0x1078>
    c4f3:	48 89 c2             	mov    %rax,%rdx
    c4f6:	48 c1 ea 10          	shr    $0x10,%rdx
    c4fa:	48 69 d2 28 12 00 00 	imul   $0x1228,%rdx,%rdx
    c501:	0f b6 34 11          	movzbl (%rcx,%rdx,1),%esi
    c505:	48 25 ff ff 00 00    	and    $0xffff,%rax
    c50b:	75 12                	jne    c51f <f52+0x1bf>
    c50d:	40 80 fe 02          	cmp    $0x2,%sil
    c511:	75 0c                	jne    c51f <f52+0x1bf>
    c513:	48 8d 04 11          	lea    (%rcx,%rdx,1),%rax
    c517:	48 05 28 02 00 00    	add    $0x228,%rax
    c51d:	eb 1f                	jmp    c53e <f52+0x1de>
    c51f:	40 80 fe 01          	cmp    $0x1,%sil
    c523:	75 2d                	jne    c552 <f52+0x1f2>
    c525:	48 8d 34 11          	lea    (%rcx,%rdx,1),%rsi
    c529:	8b 4c 11 20          	mov    0x20(%rcx,%rdx,1),%ecx
    c52d:	48 0f af c1          	imul   %rcx,%rax
    c531:	48 c1 e8 20          	shr    $0x20,%rax
    c535:	48 01 f0             	add    %rsi,%rax
    c538:	48 05 28 02 00 00    	add    $0x228,%rax
    c53e:	0f b6 08             	movzbl (%rax),%ecx
    c541:	84 c9                	test   %cl,%cl
    c543:	74 0d                	je     c552 <f52+0x1f2>
    c545:	80 f9 fe             	cmp    $0xfe,%cl
    c548:	0f 83 8c 01 00 00    	jae    c6da <f52+0x37a>
    c54e:	fe c1                	inc    %cl
    c550:	88 08                	mov    %cl,(%rax)
    c552:	49 89 fe             	mov    %rdi,%r14
    c555:	e8 46 02 00 00       	call   c7a0 <fwp_drop8>
    c55a:	f3 0f 10 04 24       	movss  (%rsp),%xmm0
    c55f:	f3 0f 58 44 24 04    	addss  0x4(%rsp),%xmm0
    c565:	66 0f 7e c0          	movd   %xmm0,%eax
    c569:	4c 89 7c 24 08       	mov    %r15,0x8(%rsp)
    c56e:	4c 89 74 24 10       	mov    %r14,0x10(%rsp)
    c573:	48 89 44 24 18       	mov    %rax,0x18(%rsp)
    c578:	48 8d 54 24 08       	lea    0x8(%rsp),%rdx
    c57d:	31 ff                	xor    %edi,%edi
    c57f:	be 03 00 00 00       	mov    $0x3,%esi
    c584:	e8 a7 d8 ff ff       	call   9e30 <fwp_data>
    c589:	49 89 c6             	mov    %rax,%r14
    c58c:	48 2b 05 1d 6c 00 00 	sub    0x6c1d(%rip),%rax        # 131b0 <fwp_gc+0x1030>
    c593:	48 8b 0d 3e 6c 00 00 	mov    0x6c3e(%rip),%rcx        # 131d8 <fwp_gc+0x1058>
    c59a:	48 c1 e1 10          	shl    $0x10,%rcx
    c59e:	48 39 c8             	cmp    %rcx,%rax
    c5a1:	73 6f                	jae    c612 <f52+0x2b2>
    c5a3:	48 8b 0d 4e 6c 00 00 	mov    0x6c4e(%rip),%rcx        # 131f8 <fwp_gc+0x1078>
    c5aa:	48 89 c2             	mov    %rax,%rdx
    c5ad:	48 c1 ea 10          	shr    $0x10,%rdx
    c5b1:	48 69 d2 28 12 00 00 	imul   $0x1228,%rdx,%rdx
    c5b8:	0f b6 34 11          	movzbl (%rcx,%rdx,1),%esi
    c5bc:	48 25 ff ff 00 00    	and    $0xffff,%rax
    c5c2:	75 1d                	jne    c5e1 <f52+0x281>
    c5c4:	40 80 fe 02          	cmp    $0x2,%sil
    c5c8:	75 17                	jne    c5e1 <f52+0x281>
    c5ca:	4c 8d 3c 11          	lea    (%rcx,%rdx,1),%r15
    c5ce:	49 81 c7 28 02 00 00 	add    $0x228,%r15
    c5d5:	41 80 3f ff          	cmpb   $0xff,(%r15)
    c5d9:	74 2d                	je     c608 <f52+0x2a8>
    c5db:	41 c6 07 01          	movb   $0x1,(%r15)
    c5df:	eb 31                	jmp    c612 <f52+0x2b2>
    c5e1:	40 80 fe 01          	cmp    $0x1,%sil
    c5e5:	75 2b                	jne    c612 <f52+0x2b2>
    c5e7:	48 8d 34 11          	lea    (%rcx,%rdx,1),%rsi
    c5eb:	8b 4c 11 20          	mov    0x20(%rcx,%rdx,1),%ecx
    c5ef:	48 0f af c1          	imul   %rcx,%rax
    c5f3:	48 c1 e8 20          	shr    $0x20,%rax
    c5f7:	4c 8d 3c 30          	lea    (%rax,%rsi,1),%r15
    c5fb:	49 81 c7 28 02 00 00 	add    $0x228,%r15
    c602:	41 80 3f ff          	cmpb   $0xff,(%r15)
    c606:	75 d3                	jne    c5db <f52+0x27b>
    c608:	4c 89 ff             	mov    %r15,%rdi
    c60b:	e8 50 9d ff ff       	call   6360 <fwp_rc_forget_slot>
    c610:	eb c9                	jmp    c5db <f52+0x27b>
    c612:	48 89 df             	mov    %rbx,%rdi
    c615:	e8 d6 00 00 00       	call   c6f0 <fwp_drop9>
    c61a:	48 c7 44 24 08 00 00 	movq   $0x0,0x8(%rsp)
    c621:	00 00 
    c623:	48 8d 54 24 10       	lea    0x10(%rsp),%rdx
    c628:	4c 89 74 24 10       	mov    %r14,0x10(%rsp)
    c62d:	31 ff                	xor    %edi,%edi
    c62f:	be 01 00 00 00       	mov    $0x1,%esi
    c634:	e8 f7 d7 ff ff       	call   9e30 <fwp_data>
    c639:	48 89 c1             	mov    %rax,%rcx
    c63c:	48 2b 0d 6d 6b 00 00 	sub    0x6b6d(%rip),%rcx        # 131b0 <fwp_gc+0x1030>
    c643:	48 8b 15 8e 6b 00 00 	mov    0x6b8e(%rip),%rdx        # 131d8 <fwp_gc+0x1058>
    c64a:	48 c1 e2 10          	shl    $0x10,%rdx
    c64e:	48 39 d1             	cmp    %rdx,%rcx
    c651:	73 73                	jae    c6c6 <f52+0x366>
    c653:	48 8b 15 9e 6b 00 00 	mov    0x6b9e(%rip),%rdx        # 131f8 <fwp_gc+0x1078>
    c65a:	48 89 ce             	mov    %rcx,%rsi
    c65d:	48 c1 ee 10          	shr    $0x10,%rsi
    c661:	48 69 f6 28 12 00 00 	imul   $0x1228,%rsi,%rsi
    c668:	0f b6 3c 32          	movzbl (%rdx,%rsi,1),%edi
    c66c:	48 81 e1 ff ff 00 00 	and    $0xffff,%rcx
    c673:	75 1b                	jne    c690 <f52+0x330>
    c675:	40 80 ff 02          	cmp    $0x2,%dil
    c679:	75 15                	jne    c690 <f52+0x330>
    c67b:	48 8d 1c 32          	lea    (%rdx,%rsi,1),%rbx
    c67f:	48 81 c3 28 02 00 00 	add    $0x228,%rbx
    c686:	80 3b ff             	cmpb   $0xff,(%rbx)
    c689:	74 2b                	je     c6b6 <f52+0x356>
    c68b:	c6 03 01             	movb   $0x1,(%rbx)
    c68e:	eb 36                	jmp    c6c6 <f52+0x366>
    c690:	40 80 ff 01          	cmp    $0x1,%dil
    c694:	75 30                	jne    c6c6 <f52+0x366>
    c696:	48 8d 3c 32          	lea    (%rdx,%rsi,1),%rdi
    c69a:	8b 54 32 20          	mov    0x20(%rdx,%rsi,1),%edx
    c69e:	48 0f af ca          	imul   %rdx,%rcx
    c6a2:	48 c1 e9 20          	shr    $0x20,%rcx
    c6a6:	48 8d 1c 39          	lea    (%rcx,%rdi,1),%rbx
    c6aa:	48 81 c3 28 02 00 00 	add    $0x228,%rbx
    c6b1:	80 3b ff             	cmpb   $0xff,(%rbx)
    c6b4:	75 d5                	jne    c68b <f52+0x32b>
    c6b6:	48 89 df             	mov    %rbx,%rdi
    c6b9:	49 89 c6             	mov    %rax,%r14
    c6bc:	e8 9f 9c ff ff       	call   6360 <fwp_rc_forget_slot>
    c6c1:	4c 89 f0             	mov    %r14,%rax
    c6c4:	eb c5                	jmp    c68b <f52+0x32b>
    c6c6:	48 83 c4 20          	add    $0x20,%rsp
    c6ca:	5b                   	pop    %rbx
    c6cb:	41 5e                	pop    %r14
    c6cd:	41 5f                	pop    %r15
    c6cf:	c3                   	ret
    c6d0:	e8 6b af ff ff       	call   7640 <fwp_rc_wide_dup>
    c6d5:	e9 15 fd ff ff       	jmp    c3ef <f52+0x8f>
    c6da:	49 89 fe             	mov    %rdi,%r14
    c6dd:	48 89 c7             	mov    %rax,%rdi
    c6e0:	e8 5b af ff ff       	call   7640 <fwp_rc_wide_dup>
    c6e5:	4c 89 f7             	mov    %r14,%rdi
    c6e8:	e9 65 fe ff ff       	jmp    c552 <f52+0x1f2>
    c6ed:	0f 1f 00             	nopl   (%rax)

000000000000c6f0 <fwp_drop9>:
    c6f0:	48 89 f8             	mov    %rdi,%rax
    c6f3:	48 2b 05 b6 6a 00 00 	sub    0x6ab6(%rip),%rax        # 131b0 <fwp_gc+0x1030>
    c6fa:	48 8b 0d d7 6a 00 00 	mov    0x6ad7(%rip),%rcx        # 131d8 <fwp_gc+0x1058>
    c701:	48 c1 e1 10          	shl    $0x10,%rcx
    c705:	48 39 c8             	cmp    %rcx,%rax
    c708:	0f 83 83 00 00 00    	jae    c791 <fwp_drop9+0xa1>
    c70e:	48 8b 0d e3 6a 00 00 	mov    0x6ae3(%rip),%rcx        # 131f8 <fwp_gc+0x1078>
    c715:	48 89 c2             	mov    %rax,%rdx
    c718:	48 c1 ea 10          	shr    $0x10,%rdx
    c71c:	48 69 d2 28 12 00 00 	imul   $0x1228,%rdx,%rdx
    c723:	0f b6 34 11          	movzbl (%rcx,%rdx,1),%esi
    c727:	48 25 ff ff 00 00    	and    $0xffff,%rax
    c72d:	75 12                	jne    c741 <fwp_drop9+0x51>
    c72f:	40 80 fe 02          	cmp    $0x2,%sil
    c733:	75 0c                	jne    c741 <fwp_drop9+0x51>
    c735:	48 8d 04 11          	lea    (%rcx,%rdx,1),%rax
    c739:	48 05 28 02 00 00    	add    $0x228,%rax
    c73f:	eb 1f                	jmp    c760 <fwp_drop9+0x70>
    c741:	40 80 fe 01          	cmp    $0x1,%sil
    c745:	75 4a                	jne    c791 <fwp_drop9+0xa1>
    c747:	48 8d 34 11          	lea    (%rcx,%rdx,1),%rsi
    c74b:	8b 4c 11 20          	mov    0x20(%rcx,%rdx,1),%ecx
    c74f:	48 0f af c1          	imul   %rcx,%rax
    c753:	48 c1 e8 20          	shr    $0x20,%rax
    c757:	48 01 f0             	add    %rsi,%rax
    c75a:	48 05 28 02 00 00    	add    $0x228,%rax
    c760:	0f b6 08             	movzbl (%rax),%ecx
    c763:	85 c9                	test   %ecx,%ecx
    c765:	74 2a                	je     c791 <fwp_drop9+0xa1>
    c767:	83 f9 01             	cmp    $0x1,%ecx
    c76a:	75 19                	jne    c785 <fwp_drop9+0x95>
    c76c:	53                   	push   %rbx
    c76d:	48 8b 47 10          	mov    0x10(%rdi),%rax
    c771:	48 89 fb             	mov    %rdi,%rbx
    c774:	48 89 c7             	mov    %rax,%rdi
    c777:	e8 24 00 00 00       	call   c7a0 <fwp_drop8>
    c77c:	48 89 df             	mov    %rbx,%rdi
    c77f:	5b                   	pop    %rbx
    c780:	e9 eb e1 ff ff       	jmp    a970 <fwp_rc_free_obj>
    c785:	81 f9 ff 00 00 00    	cmp    $0xff,%ecx
    c78b:	74 05                	je     c792 <fwp_drop9+0xa2>
    c78d:	fe c9                	dec    %cl
    c78f:	88 08                	mov    %cl,(%rax)
    c791:	c3                   	ret
    c792:	48 89 c7             	mov    %rax,%rdi
    c795:	e9 f6 de ff ff       	jmp    a690 <fwp_rc_wide_drop>
    c79a:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)

000000000000c7a0 <fwp_drop8>:
    c7a0:	53                   	push   %rbx
    c7a1:	48 89 f8             	mov    %rdi,%rax
    c7a4:	48 2b 05 05 6a 00 00 	sub    0x6a05(%rip),%rax        # 131b0 <fwp_gc+0x1030>
    c7ab:	48 8b 0d 26 6a 00 00 	mov    0x6a26(%rip),%rcx        # 131d8 <fwp_gc+0x1058>
    c7b2:	48 c1 e1 10          	shl    $0x10,%rcx
    c7b6:	48 39 c8             	cmp    %rcx,%rax
    c7b9:	0f 83 9c 00 00 00    	jae    c85b <fwp_drop8+0xbb>
    c7bf:	48 8b 0d 32 6a 00 00 	mov    0x6a32(%rip),%rcx        # 131f8 <fwp_gc+0x1078>
    c7c6:	48 89 c2             	mov    %rax,%rdx
    c7c9:	48 c1 ea 10          	shr    $0x10,%rdx
    c7cd:	48 69 d2 28 12 00 00 	imul   $0x1228,%rdx,%rdx
    c7d4:	0f b6 34 11          	movzbl (%rcx,%rdx,1),%esi
    c7d8:	48 25 ff ff 00 00    	and    $0xffff,%rax
    c7de:	75 20                	jne    c800 <fwp_drop8+0x60>
    c7e0:	40 80 fe 02          	cmp    $0x2,%sil
    c7e4:	75 1a                	jne    c800 <fwp_drop8+0x60>
    c7e6:	48 8d 04 11          	lea    (%rcx,%rdx,1),%rax
    c7ea:	48 05 28 02 00 00    	add    $0x228,%rax
    c7f0:	eb 2d                	jmp    c81f <fwp_drop8+0x7f>
    c7f2:	66 66 66 66 66 2e 0f 	data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    c7f9:	1f 84 00 00 00 00 00 
    c800:	40 80 fe 01          	cmp    $0x1,%sil
    c804:	75 55                	jne    c85b <fwp_drop8+0xbb>
    c806:	48 8d 34 11          	lea    (%rcx,%rdx,1),%rsi
    c80a:	8b 4c 11 20          	mov    0x20(%rcx,%rdx,1),%ecx
    c80e:	48 0f af c1          	imul   %rcx,%rax
    c812:	48 c1 e8 20          	shr    $0x20,%rax
    c816:	48 01 f0             	add    %rsi,%rax
    c819:	48 05 28 02 00 00    	add    $0x228,%rax
    c81f:	0f b6 08             	movzbl (%rax),%ecx
    c822:	85 c9                	test   %ecx,%ecx
    c824:	74 35                	je     c85b <fwp_drop8+0xbb>
    c826:	83 f9 01             	cmp    $0x1,%ecx
    c829:	75 32                	jne    c85d <fwp_drop8+0xbd>
    c82b:	48 83 3f 00          	cmpq   $0x0,(%rdi)
    c82f:	79 3a                	jns    c86b <fwp_drop8+0xcb>
    c831:	48 8b 5f 08          	mov    0x8(%rdi),%rbx
    c835:	e8 46 dd ff ff       	call   a580 <fwp_rc_free_arr>
    c83a:	48 89 d8             	mov    %rbx,%rax
    c83d:	48 2b 05 6c 69 00 00 	sub    0x696c(%rip),%rax        # 131b0 <fwp_gc+0x1030>
    c844:	48 8b 0d 8d 69 00 00 	mov    0x698d(%rip),%rcx        # 131d8 <fwp_gc+0x1058>
    c84b:	48 c1 e1 10          	shl    $0x10,%rcx
    c84f:	48 89 df             	mov    %rbx,%rdi
    c852:	48 39 c8             	cmp    %rcx,%rax
    c855:	0f 82 64 ff ff ff    	jb     c7bf <fwp_drop8+0x1f>
    c85b:	5b                   	pop    %rbx
    c85c:	c3                   	ret
    c85d:	81 f9 ff 00 00 00    	cmp    $0xff,%ecx
    c863:	74 0c                	je     c871 <fwp_drop8+0xd1>
    c865:	fe c9                	dec    %cl
    c867:	88 08                	mov    %cl,(%rax)
    c869:	5b                   	pop    %rbx
    c86a:	c3                   	ret
    c86b:	5b                   	pop    %rbx
    c86c:	e9 0f dd ff ff       	jmp    a580 <fwp_rc_free_arr>
    c871:	48 89 c7             	mov    %rax,%rdi
    c874:	5b                   	pop    %rbx
    c875:	e9 16 de ff ff       	jmp    a690 <fwp_rc_wide_drop>
    c87a:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)

000000000000c880 <fwp_owned_entry52>:
    c880:	48 8b 3f             	mov    (%rdi),%rdi
    c883:	e9 d8 fa ff ff       	jmp    c360 <f52>
    c888:	0f 1f 84 00 00 00 00 	nopl   0x0(%rax,%rax,1)
    c88f:	00 

000000000000c890 <fwp_caps52>:
    c890:	53                   	push   %rbx
    c891:	83 7f 04 00          	cmpl   $0x0,0x4(%rdi)
    c895:	74 56                	je     c8ed <fwp_caps52+0x5d>
    c897:	48 89 fb             	mov    %rdi,%rbx
    c89a:	48 8b 7f 08          	mov    0x8(%rdi),%rdi
    c89e:	85 f6                	test   %esi,%esi
    c8a0:	74 51                	je     c8f3 <fwp_caps52+0x63>
    c8a2:	48 2b 3d 07 69 00 00 	sub    0x6907(%rip),%rdi        # 131b0 <fwp_gc+0x1030>
    c8a9:	48 8b 05 28 69 00 00 	mov    0x6928(%rip),%rax        # 131d8 <fwp_gc+0x1058>
    c8b0:	48 c1 e0 10          	shl    $0x10,%rax
    c8b4:	48 39 c7             	cmp    %rax,%rdi
    c8b7:	73 38                	jae    c8f1 <fwp_caps52+0x61>
    c8b9:	48 8b 05 38 69 00 00 	mov    0x6938(%rip),%rax        # 131f8 <fwp_gc+0x1078>
    c8c0:	48 89 f9             	mov    %rdi,%rcx
    c8c3:	48 c1 e9 10          	shr    $0x10,%rcx
    c8c7:	48 69 c9 28 12 00 00 	imul   $0x1228,%rcx,%rcx
    c8ce:	0f b6 14 08          	movzbl (%rax,%rcx,1),%edx
    c8d2:	48 81 e7 ff ff 00 00 	and    $0xffff,%rdi
    c8d9:	75 26                	jne    c901 <fwp_caps52+0x71>
    c8db:	80 fa 02             	cmp    $0x2,%dl
    c8de:	75 21                	jne    c901 <fwp_caps52+0x71>
    c8e0:	48 8d 3c 08          	lea    (%rax,%rcx,1),%rdi
    c8e4:	48 81 c7 28 02 00 00 	add    $0x228,%rdi
    c8eb:	eb 33                	jmp    c920 <fwp_caps52+0x90>
    c8ed:	85 f6                	test   %esi,%esi
    c8ef:	74 0a                	je     c8fb <fwp_caps52+0x6b>
    c8f1:	5b                   	pop    %rbx
    c8f2:	c3                   	ret
    c8f3:	e8 f8 fd ff ff       	call   c6f0 <fwp_drop9>
    c8f8:	48 89 df             	mov    %rbx,%rdi
    c8fb:	5b                   	pop    %rbx
    c8fc:	e9 6f e0 ff ff       	jmp    a970 <fwp_rc_free_obj>
    c901:	80 fa 01             	cmp    $0x1,%dl
    c904:	75 eb                	jne    c8f1 <fwp_caps52+0x61>
    c906:	48 8d 14 08          	lea    (%rax,%rcx,1),%rdx
    c90a:	8b 44 08 20          	mov    0x20(%rax,%rcx,1),%eax
    c90e:	48 0f af f8          	imul   %rax,%rdi
    c912:	48 c1 ef 20          	shr    $0x20,%rdi
    c916:	48 01 d7             	add    %rdx,%rdi
    c919:	48 81 c7 28 02 00 00 	add    $0x228,%rdi
    c920:	0f b6 07             	movzbl (%rdi),%eax
    c923:	84 c0                	test   %al,%al
    c925:	74 ca                	je     c8f1 <fwp_caps52+0x61>
    c927:	3c fe                	cmp    $0xfe,%al
    c929:	73 06                	jae    c931 <fwp_caps52+0xa1>
    c92b:	fe c0                	inc    %al
    c92d:	88 07                	mov    %al,(%rdi)
    c92f:	5b                   	pop    %rbx
    c930:	c3                   	ret
    c931:	5b                   	pop    %rbx
    c932:	e9 09 ad ff ff       	jmp    7640 <fwp_rc_wide_dup>
    c937:	66 0f 1f 84 00 00 00 	nopw   0x0(%rax,%rax,1)
    c93e:	00 00 

000000000000c940 <fwp_args52>:
    c940:	85 f6                	test   %esi,%esi
    c942:	0f 85 8a 00 00 00    	jne    c9d2 <fwp_args52+0x92>
    c948:	85 d2                	test   %edx,%edx
    c94a:	0f 84 82 00 00 00    	je     c9d2 <fwp_args52+0x92>
    c950:	48 8b 07             	mov    (%rdi),%rax
    c953:	48 2b 05 56 68 00 00 	sub    0x6856(%rip),%rax        # 131b0 <fwp_gc+0x1030>
    c95a:	48 8b 0d 77 68 00 00 	mov    0x6877(%rip),%rcx        # 131d8 <fwp_gc+0x1058>
    c961:	48 c1 e1 10          	shl    $0x10,%rcx
    c965:	48 39 c8             	cmp    %rcx,%rax
    c968:	73 68                	jae    c9d2 <fwp_args52+0x92>
    c96a:	48 8b 0d 87 68 00 00 	mov    0x6887(%rip),%rcx        # 131f8 <fwp_gc+0x1078>
    c971:	48 89 c2             	mov    %rax,%rdx
    c974:	48 c1 ea 10          	shr    $0x10,%rdx
    c978:	48 69 d2 28 12 00 00 	imul   $0x1228,%rdx,%rdx
    c97f:	0f b6 34 11          	movzbl (%rcx,%rdx,1),%esi
    c983:	48 25 ff ff 00 00    	and    $0xffff,%rax
    c989:	75 13                	jne    c99e <fwp_args52+0x5e>
    c98b:	40 80 fe 02          	cmp    $0x2,%sil
    c98f:	75 0d                	jne    c99e <fwp_args52+0x5e>
    c991:	48 8d 3c 11          	lea    (%rcx,%rdx,1),%rdi
    c995:	48 81 c7 28 02 00 00 	add    $0x228,%rdi
    c99c:	eb 21                	jmp    c9bf <fwp_args52+0x7f>
    c99e:	40 80 fe 01          	cmp    $0x1,%sil
    c9a2:	75 2e                	jne    c9d2 <fwp_args52+0x92>
    c9a4:	48 8d 34 11          	lea    (%rcx,%rdx,1),%rsi
    c9a8:	8b 4c 11 20          	mov    0x20(%rcx,%rdx,1),%ecx
    c9ac:	48 0f af c1          	imul   %rcx,%rax
    c9b0:	48 c1 e8 20          	shr    $0x20,%rax
    c9b4:	48 8d 3c 30          	lea    (%rax,%rsi,1),%rdi
    c9b8:	48 81 c7 28 02 00 00 	add    $0x228,%rdi
    c9bf:	0f b6 07             	movzbl (%rdi),%eax
    c9c2:	84 c0                	test   %al,%al
    c9c4:	74 0c                	je     c9d2 <fwp_args52+0x92>
    c9c6:	3c fe                	cmp    $0xfe,%al
    c9c8:	0f 83 72 ac ff ff    	jae    7640 <fwp_rc_wide_dup>
    c9ce:	fe c0                	inc    %al
    c9d0:	88 07                	mov    %al,(%rdi)
    c9d2:	c3                   	ret
    c9d3:	66 66 66 66 2e 0f 1f 	data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    c9da:	84 00 00 00 00 00 

000000000000c9e0 <fwp_arg_drop52>:
    c9e0:	85 f6                	test   %esi,%esi
    c9e2:	75 0c                	jne    c9f0 <fwp_arg_drop52+0x10>
    c9e4:	85 d2                	test   %edx,%edx
    c9e6:	74 08                	je     c9f0 <fwp_arg_drop52+0x10>
    c9e8:	48 8b 3f             	mov    (%rdi),%rdi
    c9eb:	e9 00 fd ff ff       	jmp    c6f0 <fwp_drop9>
    c9f0:	c3                   	ret
    c9f1:	66 66 66 66 66 66 2e 	data16 data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    c9f8:	0f 1f 84 00 00 00 00 
    c9ff:	00 

000000000000ca00 <fwp_drop10>:
    ca00:	48 89 f8             	mov    %rdi,%rax
    ca03:	48 2b 05 a6 67 00 00 	sub    0x67a6(%rip),%rax        # 131b0 <fwp_gc+0x1030>
    ca0a:	48 8b 0d c7 67 00 00 	mov    0x67c7(%rip),%rcx        # 131d8 <fwp_gc+0x1058>
    ca11:	48 c1 e1 10          	shl    $0x10,%rcx
    ca15:	48 39 c8             	cmp    %rcx,%rax
    ca18:	0f 83 92 00 00 00    	jae    cab0 <fwp_drop10+0xb0>
    ca1e:	48 8b 0d d3 67 00 00 	mov    0x67d3(%rip),%rcx        # 131f8 <fwp_gc+0x1078>
    ca25:	48 89 c2             	mov    %rax,%rdx
    ca28:	48 c1 ea 10          	shr    $0x10,%rdx
    ca2c:	48 69 d2 28 12 00 00 	imul   $0x1228,%rdx,%rdx
    ca33:	0f b6 34 11          	movzbl (%rcx,%rdx,1),%esi
    ca37:	48 25 ff ff 00 00    	and    $0xffff,%rax
    ca3d:	75 12                	jne    ca51 <fwp_drop10+0x51>
    ca3f:	40 80 fe 02          	cmp    $0x2,%sil
    ca43:	75 0c                	jne    ca51 <fwp_drop10+0x51>
    ca45:	48 8d 04 11          	lea    (%rcx,%rdx,1),%rax
    ca49:	48 05 28 02 00 00    	add    $0x228,%rax
    ca4f:	eb 1f                	jmp    ca70 <fwp_drop10+0x70>
    ca51:	40 80 fe 01          	cmp    $0x1,%sil
    ca55:	75 59                	jne    cab0 <fwp_drop10+0xb0>
    ca57:	48 8d 34 11          	lea    (%rcx,%rdx,1),%rsi
    ca5b:	8b 4c 11 20          	mov    0x20(%rcx,%rdx,1),%ecx
    ca5f:	48 0f af c1          	imul   %rcx,%rax
    ca63:	48 c1 e8 20          	shr    $0x20,%rax
    ca67:	48 01 f0             	add    %rsi,%rax
    ca6a:	48 05 28 02 00 00    	add    $0x228,%rax
    ca70:	0f b6 08             	movzbl (%rax),%ecx
    ca73:	85 c9                	test   %ecx,%ecx
    ca75:	74 39                	je     cab0 <fwp_drop10+0xb0>
    ca77:	83 f9 01             	cmp    $0x1,%ecx
    ca7a:	75 28                	jne    caa4 <fwp_drop10+0xa4>
    ca7c:	8b 07                	mov    (%rdi),%eax
    ca7e:	83 f8 01             	cmp    $0x1,%eax
    ca81:	0f 84 e9 de ff ff    	je     a970 <fwp_rc_free_obj>
    ca87:	85 c0                	test   %eax,%eax
    ca89:	75 25                	jne    cab0 <fwp_drop10+0xb0>
    ca8b:	53                   	push   %rbx
    ca8c:	48 8b 47 08          	mov    0x8(%rdi),%rax
    ca90:	48 89 fb             	mov    %rdi,%rbx
    ca93:	48 89 c7             	mov    %rax,%rdi
    ca96:	e8 55 fc ff ff       	call   c6f0 <fwp_drop9>
    ca9b:	48 89 df             	mov    %rbx,%rdi
    ca9e:	5b                   	pop    %rbx
    ca9f:	e9 cc de ff ff       	jmp    a970 <fwp_rc_free_obj>
    caa4:	81 f9 ff 00 00 00    	cmp    $0xff,%ecx
    caaa:	74 05                	je     cab1 <fwp_drop10+0xb1>
    caac:	fe c9                	dec    %cl
    caae:	88 08                	mov    %cl,(%rax)
    cab0:	c3                   	ret
    cab1:	48 89 c7             	mov    %rax,%rdi
    cab4:	e9 d7 db ff ff       	jmp    a690 <fwp_rc_wide_drop>
    cab9:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)

000000000000cac0 <f55>:
    cac0:	41 57                	push   %r15
    cac2:	41 56                	push   %r14
    cac4:	41 54                	push   %r12
    cac6:	53                   	push   %rbx
    cac7:	48 81 ec 88 00 00 00 	sub    $0x88,%rsp
    cace:	48 89 fb             	mov    %rdi,%rbx
    cad1:	48 8b 47 10          	mov    0x10(%rdi),%rax
    cad5:	48 2b 05 d4 66 00 00 	sub    0x66d4(%rip),%rax        # 131b0 <fwp_gc+0x1030>
    cadc:	48 8b 0d f5 66 00 00 	mov    0x66f5(%rip),%rcx        # 131d8 <fwp_gc+0x1058>
    cae3:	48 c1 e1 10          	shl    $0x10,%rcx
    cae7:	48 39 c8             	cmp    %rcx,%rax
    caea:	73 68                	jae    cb54 <f55+0x94>
    caec:	48 8b 0d 05 67 00 00 	mov    0x6705(%rip),%rcx        # 131f8 <fwp_gc+0x1078>
    caf3:	48 89 c2             	mov    %rax,%rdx
    caf6:	48 c1 ea 10          	shr    $0x10,%rdx
    cafa:	48 69 d2 28 12 00 00 	imul   $0x1228,%rdx,%rdx
    cb01:	0f b6 34 11          	movzbl (%rcx,%rdx,1),%esi
    cb05:	48 25 ff ff 00 00    	and    $0xffff,%rax
    cb0b:	75 13                	jne    cb20 <f55+0x60>
    cb0d:	40 80 fe 02          	cmp    $0x2,%sil
    cb11:	75 0d                	jne    cb20 <f55+0x60>
    cb13:	48 8d 3c 11          	lea    (%rcx,%rdx,1),%rdi
    cb17:	48 81 c7 28 02 00 00 	add    $0x228,%rdi
    cb1e:	eb 21                	jmp    cb41 <f55+0x81>
    cb20:	40 80 fe 01          	cmp    $0x1,%sil
    cb24:	75 2e                	jne    cb54 <f55+0x94>
    cb26:	48 8d 34 11          	lea    (%rcx,%rdx,1),%rsi
    cb2a:	8b 4c 11 20          	mov    0x20(%rcx,%rdx,1),%ecx
    cb2e:	48 0f af c1          	imul   %rcx,%rax
    cb32:	48 c1 e8 20          	shr    $0x20,%rax
    cb36:	48 8d 3c 30          	lea    (%rax,%rsi,1),%rdi
    cb3a:	48 81 c7 28 02 00 00 	add    $0x228,%rdi
    cb41:	0f b6 07             	movzbl (%rdi),%eax
    cb44:	84 c0                	test   %al,%al
    cb46:	74 0c                	je     cb54 <f55+0x94>
    cb48:	3c fe                	cmp    $0xfe,%al
    cb4a:	0f 83 dc 02 00 00    	jae    ce2c <f55+0x36c>
    cb50:	fe c0                	inc    %al
    cb52:	88 07                	mov    %al,(%rdi)
    cb54:	4c 8b 63 08          	mov    0x8(%rbx),%r12
    cb58:	4c 8b 73 10          	mov    0x10(%rbx),%r14
    cb5c:	4c 8b 7b 18          	mov    0x18(%rbx),%r15
    cb60:	4d 85 e4             	test   %r12,%r12
    cb63:	78 27                	js     cb8c <f55+0xcc>
    cb65:	49 8b 06             	mov    (%r14),%rax
    cb68:	48 b9 ff ff ff ff ff 	movabs $0x7fffffffffffffff,%rcx
    cb6f:	ff ff 7f 
    cb72:	48 21 c1             	and    %rax,%rcx
    cb75:	4c 39 e1             	cmp    %r12,%rcx
    cb78:	76 12                	jbe    cb8c <f55+0xcc>
    cb7a:	48 85 c0             	test   %rax,%rax
    cb7d:	0f 88 8e 00 00 00    	js     cc11 <f55+0x151>
    cb83:	49 8d 46 08          	lea    0x8(%r14),%rax
    cb87:	e9 89 00 00 00       	jmp    cc15 <f55+0x155>
    cb8c:	4c 89 f7             	mov    %r14,%rdi
    cb8f:	e8 bc 03 00 00       	call   cf50 <fwp_drop11>
    cb94:	48 89 df             	mov    %rbx,%rdi
    cb97:	e8 04 03 00 00       	call   cea0 <fwp_drop12>
    cb9c:	48 c7 44 24 20 01 00 	movq   $0x1,0x20(%rsp)
    cba3:	00 00 
    cba5:	48 8d 54 24 28       	lea    0x28(%rsp),%rdx
    cbaa:	4c 89 7c 24 28       	mov    %r15,0x28(%rsp)
    cbaf:	bf 01 00 00 00       	mov    $0x1,%edi
    cbb4:	be 01 00 00 00       	mov    $0x1,%esi
    cbb9:	e8 72 d2 ff ff       	call   9e30 <fwp_data>
    cbbe:	48 89 c1             	mov    %rax,%rcx
    cbc1:	48 2b 0d e8 65 00 00 	sub    0x65e8(%rip),%rcx        # 131b0 <fwp_gc+0x1030>
    cbc8:	48 8b 15 09 66 00 00 	mov    0x6609(%rip),%rdx        # 131d8 <fwp_gc+0x1058>
    cbcf:	48 c1 e2 10          	shl    $0x10,%rdx
    cbd3:	48 39 d1             	cmp    %rdx,%rcx
    cbd6:	0f 83 41 02 00 00    	jae    ce1d <f55+0x35d>
    cbdc:	48 8b 15 15 66 00 00 	mov    0x6615(%rip),%rdx        # 131f8 <fwp_gc+0x1078>
    cbe3:	48 89 ce             	mov    %rcx,%rsi
    cbe6:	48 c1 ee 10          	shr    $0x10,%rsi
    cbea:	48 69 f6 28 12 00 00 	imul   $0x1228,%rsi,%rsi
    cbf1:	0f b6 3c 32          	movzbl (%rdx,%rsi,1),%edi
    cbf5:	48 81 e1 ff ff 00 00 	and    $0xffff,%rcx
    cbfc:	0f 85 e5 01 00 00    	jne    cde7 <f55+0x327>
    cc02:	40 80 ff 02          	cmp    $0x2,%dil
    cc06:	0f 84 c6 01 00 00    	je     cdd2 <f55+0x312>
    cc0c:	e9 d6 01 00 00       	jmp    cde7 <f55+0x327>
    cc11:	49 8b 46 10          	mov    0x10(%r14),%rax
    cc15:	4a 0f be 04 20       	movsbq (%rax,%r12,1),%rax
    cc1a:	48 83 c0 81          	add    $0xffffffffffffff81,%rax
    cc1e:	48 3d ff fe ff ff    	cmp    $0xfffffffffffffeff,%rax
    cc24:	0f 86 16 02 00 00    	jbe    ce40 <f55+0x380>
    cc2a:	4c 89 f0             	mov    %r14,%rax
    cc2d:	48 2b 05 7c 65 00 00 	sub    0x657c(%rip),%rax        # 131b0 <fwp_gc+0x1030>
    cc34:	48 8b 0d 9d 65 00 00 	mov    0x659d(%rip),%rcx        # 131d8 <fwp_gc+0x1058>
    cc3b:	48 c1 e1 10          	shl    $0x10,%rcx
    cc3f:	48 39 c8             	cmp    %rcx,%rax
    cc42:	73 68                	jae    ccac <f55+0x1ec>
    cc44:	48 8b 0d ad 65 00 00 	mov    0x65ad(%rip),%rcx        # 131f8 <fwp_gc+0x1078>
    cc4b:	48 89 c2             	mov    %rax,%rdx
    cc4e:	48 c1 ea 10          	shr    $0x10,%rdx
    cc52:	48 69 d2 28 12 00 00 	imul   $0x1228,%rdx,%rdx
    cc59:	0f b6 34 11          	movzbl (%rcx,%rdx,1),%esi
    cc5d:	48 25 ff ff 00 00    	and    $0xffff,%rax
    cc63:	75 13                	jne    cc78 <f55+0x1b8>
    cc65:	40 80 fe 02          	cmp    $0x2,%sil
    cc69:	75 0d                	jne    cc78 <f55+0x1b8>
    cc6b:	48 8d 3c 11          	lea    (%rcx,%rdx,1),%rdi
    cc6f:	48 81 c7 28 02 00 00 	add    $0x228,%rdi
    cc76:	eb 21                	jmp    cc99 <f55+0x1d9>
    cc78:	40 80 fe 01          	cmp    $0x1,%sil
    cc7c:	75 2e                	jne    ccac <f55+0x1ec>
    cc7e:	48 8d 34 11          	lea    (%rcx,%rdx,1),%rsi
    cc82:	8b 4c 11 20          	mov    0x20(%rcx,%rdx,1),%ecx
    cc86:	48 0f af c1          	imul   %rcx,%rax
    cc8a:	48 c1 e8 20          	shr    $0x20,%rax
    cc8e:	48 8d 3c 30          	lea    (%rax,%rsi,1),%rdi
    cc92:	48 81 c7 28 02 00 00 	add    $0x228,%rdi
    cc99:	0f b6 07             	movzbl (%rdi),%eax
    cc9c:	84 c0                	test   %al,%al
    cc9e:	74 0c                	je     ccac <f55+0x1ec>
    cca0:	3c fe                	cmp    $0xfe,%al
    cca2:	0f 83 8e 01 00 00    	jae    ce36 <f55+0x376>
    cca8:	fe c0                	inc    %al
    ccaa:	88 07                	mov    %al,(%rdi)
    ccac:	4c 89 f7             	mov    %r14,%rdi
    ccaf:	e8 9c 02 00 00       	call   cf50 <fwp_drop11>
    ccb4:	49 ff c7             	inc    %r15
    ccb7:	0f 80 93 01 00 00    	jo     ce50 <f55+0x390>
    ccbd:	49 ff c4             	inc    %r12
    ccc0:	4c 89 64 24 08       	mov    %r12,0x8(%rsp)
    ccc5:	4c 89 74 24 10       	mov    %r14,0x10(%rsp)
    ccca:	4c 89 7c 24 18       	mov    %r15,0x18(%rsp)
    cccf:	48 8d 54 24 08       	lea    0x8(%rsp),%rdx
    ccd4:	31 ff                	xor    %edi,%edi
    ccd6:	be 03 00 00 00       	mov    $0x3,%esi
    ccdb:	e8 50 d1 ff ff       	call   9e30 <fwp_data>
    cce0:	49 89 c6             	mov    %rax,%r14
    cce3:	48 2b 05 c6 64 00 00 	sub    0x64c6(%rip),%rax        # 131b0 <fwp_gc+0x1030>
    ccea:	48 8b 0d e7 64 00 00 	mov    0x64e7(%rip),%rcx        # 131d8 <fwp_gc+0x1058>
    ccf1:	48 c1 e1 10          	shl    $0x10,%rcx
    ccf5:	48 39 c8             	cmp    %rcx,%rax
    ccf8:	73 6f                	jae    cd69 <f55+0x2a9>
    ccfa:	48 8b 0d f7 64 00 00 	mov    0x64f7(%rip),%rcx        # 131f8 <fwp_gc+0x1078>
    cd01:	48 89 c2             	mov    %rax,%rdx
    cd04:	48 c1 ea 10          	shr    $0x10,%rdx
    cd08:	48 69 d2 28 12 00 00 	imul   $0x1228,%rdx,%rdx
    cd0f:	0f b6 34 11          	movzbl (%rcx,%rdx,1),%esi
    cd13:	48 25 ff ff 00 00    	and    $0xffff,%rax
    cd19:	75 1d                	jne    cd38 <f55+0x278>
    cd1b:	40 80 fe 02          	cmp    $0x2,%sil
    cd1f:	75 17                	jne    cd38 <f55+0x278>
    cd21:	4c 8d 3c 11          	lea    (%rcx,%rdx,1),%r15
    cd25:	49 81 c7 28 02 00 00 	add    $0x228,%r15
    cd2c:	41 80 3f ff          	cmpb   $0xff,(%r15)
    cd30:	74 2d                	je     cd5f <f55+0x29f>
    cd32:	41 c6 07 01          	movb   $0x1,(%r15)
    cd36:	eb 31                	jmp    cd69 <f55+0x2a9>
    cd38:	40 80 fe 01          	cmp    $0x1,%sil
    cd3c:	75 2b                	jne    cd69 <f55+0x2a9>
    cd3e:	48 8d 34 11          	lea    (%rcx,%rdx,1),%rsi
    cd42:	8b 4c 11 20          	mov    0x20(%rcx,%rdx,1),%ecx
    cd46:	48 0f af c1          	imul   %rcx,%rax
    cd4a:	48 c1 e8 20          	shr    $0x20,%rax
    cd4e:	4c 8d 3c 30          	lea    (%rax,%rsi,1),%r15
    cd52:	49 81 c7 28 02 00 00 	add    $0x228,%r15
    cd59:	41 80 3f ff          	cmpb   $0xff,(%r15)
    cd5d:	75 d3                	jne    cd32 <f55+0x272>
    cd5f:	4c 89 ff             	mov    %r15,%rdi
    cd62:	e8 f9 95 ff ff       	call   6360 <fwp_rc_forget_slot>
    cd67:	eb c9                	jmp    cd32 <f55+0x272>
    cd69:	48 89 df             	mov    %rbx,%rdi
    cd6c:	e8 2f 01 00 00       	call   cea0 <fwp_drop12>
    cd71:	48 c7 44 24 20 00 00 	movq   $0x0,0x20(%rsp)
    cd78:	00 00 
    cd7a:	48 8d 54 24 28       	lea    0x28(%rsp),%rdx
    cd7f:	4c 89 74 24 28       	mov    %r14,0x28(%rsp)
    cd84:	31 ff                	xor    %edi,%edi
    cd86:	be 01 00 00 00       	mov    $0x1,%esi
    cd8b:	e8 a0 d0 ff ff       	call   9e30 <fwp_data>
    cd90:	48 89 c1             	mov    %rax,%rcx
    cd93:	48 2b 0d 16 64 00 00 	sub    0x6416(%rip),%rcx        # 131b0 <fwp_gc+0x1030>
    cd9a:	48 8b 15 37 64 00 00 	mov    0x6437(%rip),%rdx        # 131d8 <fwp_gc+0x1058>
    cda1:	48 c1 e2 10          	shl    $0x10,%rdx
    cda5:	48 39 d1             	cmp    %rdx,%rcx
    cda8:	73 73                	jae    ce1d <f55+0x35d>
    cdaa:	48 8b 15 47 64 00 00 	mov    0x6447(%rip),%rdx        # 131f8 <fwp_gc+0x1078>
    cdb1:	48 89 ce             	mov    %rcx,%rsi
    cdb4:	48 c1 ee 10          	shr    $0x10,%rsi
    cdb8:	48 69 f6 28 12 00 00 	imul   $0x1228,%rsi,%rsi
    cdbf:	0f b6 3c 32          	movzbl (%rdx,%rsi,1),%edi
    cdc3:	48 81 e1 ff ff 00 00 	and    $0xffff,%rcx
    cdca:	75 1b                	jne    cde7 <f55+0x327>
    cdcc:	40 80 ff 02          	cmp    $0x2,%dil
    cdd0:	75 15                	jne    cde7 <f55+0x327>
    cdd2:	48 8d 1c 32          	lea    (%rdx,%rsi,1),%rbx
    cdd6:	48 81 c3 28 02 00 00 	add    $0x228,%rbx
    cddd:	80 3b ff             	cmpb   $0xff,(%rbx)
    cde0:	74 2b                	je     ce0d <f55+0x34d>
    cde2:	c6 03 01             	movb   $0x1,(%rbx)
    cde5:	eb 36                	jmp    ce1d <f55+0x35d>
    cde7:	40 80 ff 01          	cmp    $0x1,%dil
    cdeb:	75 30                	jne    ce1d <f55+0x35d>
    cded:	48 8d 3c 32          	lea    (%rdx,%rsi,1),%rdi
    cdf1:	8b 54 32 20          	mov    0x20(%rdx,%rsi,1),%edx
    cdf5:	48 0f af ca          	imul   %rdx,%rcx
    cdf9:	48 c1 e9 20          	shr    $0x20,%rcx
    cdfd:	48 8d 1c 39          	lea    (%rcx,%rdi,1),%rbx
    ce01:	48 81 c3 28 02 00 00 	add    $0x228,%rbx
    ce08:	80 3b ff             	cmpb   $0xff,(%rbx)
    ce0b:	75 d5                	jne    cde2 <f55+0x322>
    ce0d:	48 89 df             	mov    %rbx,%rdi
    ce10:	49 89 c6             	mov    %rax,%r14
    ce13:	e8 48 95 ff ff       	call   6360 <fwp_rc_forget_slot>
    ce18:	4c 89 f0             	mov    %r14,%rax
    ce1b:	eb c5                	jmp    cde2 <f55+0x322>
    ce1d:	48 81 c4 88 00 00 00 	add    $0x88,%rsp
    ce24:	5b                   	pop    %rbx
    ce25:	41 5c                	pop    %r12
    ce27:	41 5e                	pop    %r14
    ce29:	41 5f                	pop    %r15
    ce2b:	c3                   	ret
    ce2c:	e8 0f a8 ff ff       	call   7640 <fwp_rc_wide_dup>
    ce31:	e9 1e fd ff ff       	jmp    cb54 <f55+0x94>
    ce36:	e8 05 a8 ff ff       	call   7640 <fwp_rc_wide_dup>
    ce3b:	e9 6c fe ff ff       	jmp    ccac <f55+0x1ec>
    ce40:	48 8d 15 44 28 00 00 	lea    0x2844(%rip),%rdx        # f68b <fwp_segv.msg+0x44b>
    ce47:	48 8d 0d 55 27 00 00 	lea    0x2755(%rip),%rcx        # f5a3 <fwp_segv.msg+0x363>
    ce4e:	eb 0e                	jmp    ce5e <f55+0x39e>
    ce50:	48 8d 15 34 28 00 00 	lea    0x2834(%rip),%rdx        # f68b <fwp_segv.msg+0x44b>
    ce57:	48 8d 0d 47 28 00 00 	lea    0x2847(%rip),%rcx        # f6a5 <fwp_segv.msg+0x465>
    ce5e:	48 8d 5c 24 20       	lea    0x20(%rsp),%rbx
    ce63:	be 60 00 00 00       	mov    $0x60,%esi
    ce68:	48 89 df             	mov    %rbx,%rdi
    ce6b:	31 c0                	xor    %eax,%eax
    ce6d:	e8 9e 52 ff ff       	call   2110 <snprintf@plt>
    ce72:	e8 b9 94 ff ff       	call   6330 <fwp_flush>
    ce77:	48 8b 05 62 51 00 00 	mov    0x5162(%rip),%rax        # 11fe0 <stderr@GLIBC_2.2.5>
    ce7e:	48 8b 38             	mov    (%rax),%rdi
    ce81:	48 8d 35 a5 25 00 00 	lea    0x25a5(%rip),%rsi        # f42d <fwp_segv.msg+0x1ed>
    ce88:	48 89 da             	mov    %rbx,%rdx
    ce8b:	31 c0                	xor    %eax,%eax
    ce8d:	e8 1e 53 ff ff       	call   21b0 <fprintf@plt>
    ce92:	bf 65 00 00 00       	mov    $0x65,%edi
    ce97:	e8 f4 53 ff ff       	call   2290 <exit@plt>
    ce9c:	0f 1f 40 00          	nopl   0x0(%rax)

000000000000cea0 <fwp_drop12>:
    cea0:	48 89 f8             	mov    %rdi,%rax
    cea3:	48 2b 05 06 63 00 00 	sub    0x6306(%rip),%rax        # 131b0 <fwp_gc+0x1030>
    ceaa:	48 8b 0d 27 63 00 00 	mov    0x6327(%rip),%rcx        # 131d8 <fwp_gc+0x1058>
    ceb1:	48 c1 e1 10          	shl    $0x10,%rcx
    ceb5:	48 39 c8             	cmp    %rcx,%rax
    ceb8:	0f 83 83 00 00 00    	jae    cf41 <fwp_drop12+0xa1>
    cebe:	48 8b 0d 33 63 00 00 	mov    0x6333(%rip),%rcx        # 131f8 <fwp_gc+0x1078>
    cec5:	48 89 c2             	mov    %rax,%rdx
    cec8:	48 c1 ea 10          	shr    $0x10,%rdx
    cecc:	48 69 d2 28 12 00 00 	imul   $0x1228,%rdx,%rdx
    ced3:	0f b6 34 11          	movzbl (%rcx,%rdx,1),%esi
    ced7:	48 25 ff ff 00 00    	and    $0xffff,%rax
    cedd:	75 12                	jne    cef1 <fwp_drop12+0x51>
    cedf:	40 80 fe 02          	cmp    $0x2,%sil
    cee3:	75 0c                	jne    cef1 <fwp_drop12+0x51>
    cee5:	48 8d 04 11          	lea    (%rcx,%rdx,1),%rax
    cee9:	48 05 28 02 00 00    	add    $0x228,%rax
    ceef:	eb 1f                	jmp    cf10 <fwp_drop12+0x70>
    cef1:	40 80 fe 01          	cmp    $0x1,%sil
    cef5:	75 4a                	jne    cf41 <fwp_drop12+0xa1>
    cef7:	48 8d 34 11          	lea    (%rcx,%rdx,1),%rsi
    cefb:	8b 4c 11 20          	mov    0x20(%rcx,%rdx,1),%ecx
    ceff:	48 0f af c1          	imul   %rcx,%rax
    cf03:	48 c1 e8 20          	shr    $0x20,%rax
    cf07:	48 01 f0             	add    %rsi,%rax
    cf0a:	48 05 28 02 00 00    	add    $0x228,%rax
    cf10:	0f b6 08             	movzbl (%rax),%ecx
    cf13:	85 c9                	test   %ecx,%ecx
    cf15:	74 2a                	je     cf41 <fwp_drop12+0xa1>
    cf17:	83 f9 01             	cmp    $0x1,%ecx
    cf1a:	75 19                	jne    cf35 <fwp_drop12+0x95>
    cf1c:	53                   	push   %rbx
    cf1d:	48 8b 47 10          	mov    0x10(%rdi),%rax
    cf21:	48 89 fb             	mov    %rdi,%rbx
    cf24:	48 89 c7             	mov    %rax,%rdi
    cf27:	e8 24 00 00 00       	call   cf50 <fwp_drop11>
    cf2c:	48 89 df             	mov    %rbx,%rdi
    cf2f:	5b                   	pop    %rbx
    cf30:	e9 3b da ff ff       	jmp    a970 <fwp_rc_free_obj>
    cf35:	81 f9 ff 00 00 00    	cmp    $0xff,%ecx
    cf3b:	74 05                	je     cf42 <fwp_drop12+0xa2>
    cf3d:	fe c9                	dec    %cl
    cf3f:	88 08                	mov    %cl,(%rax)
    cf41:	c3                   	ret
    cf42:	48 89 c7             	mov    %rax,%rdi
    cf45:	e9 46 d7 ff ff       	jmp    a690 <fwp_rc_wide_drop>
    cf4a:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)

000000000000cf50 <fwp_drop11>:
    cf50:	53                   	push   %rbx
    cf51:	48 89 f8             	mov    %rdi,%rax
    cf54:	48 2b 05 55 62 00 00 	sub    0x6255(%rip),%rax        # 131b0 <fwp_gc+0x1030>
    cf5b:	48 8b 0d 76 62 00 00 	mov    0x6276(%rip),%rcx        # 131d8 <fwp_gc+0x1058>
    cf62:	48 c1 e1 10          	shl    $0x10,%rcx
    cf66:	48 39 c8             	cmp    %rcx,%rax
    cf69:	0f 83 9c 00 00 00    	jae    d00b <fwp_drop11+0xbb>
    cf6f:	48 8b 0d 82 62 00 00 	mov    0x6282(%rip),%rcx        # 131f8 <fwp_gc+0x1078>
    cf76:	48 89 c2             	mov    %rax,%rdx
    cf79:	48 c1 ea 10          	shr    $0x10,%rdx
    cf7d:	48 69 d2 28 12 00 00 	imul   $0x1228,%rdx,%rdx
    cf84:	0f b6 34 11          	movzbl (%rcx,%rdx,1),%esi
    cf88:	48 25 ff ff 00 00    	and    $0xffff,%rax
    cf8e:	75 20                	jne    cfb0 <fwp_drop11+0x60>
    cf90:	40 80 fe 02          	cmp    $0x2,%sil
    cf94:	75 1a                	jne    cfb0 <fwp_drop11+0x60>
    cf96:	48 8d 04 11          	lea    (%rcx,%rdx,1),%rax
    cf9a:	48 05 28 02 00 00    	add    $0x228,%rax
    cfa0:	eb 2d                	jmp    cfcf <fwp_drop11+0x7f>
    cfa2:	66 66 66 66 66 2e 0f 	data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    cfa9:	1f 84 00 00 00 00 00 
    cfb0:	40 80 fe 01          	cmp    $0x1,%sil
    cfb4:	75 55                	jne    d00b <fwp_drop11+0xbb>
    cfb6:	48 8d 34 11          	lea    (%rcx,%rdx,1),%rsi
    cfba:	8b 4c 11 20          	mov    0x20(%rcx,%rdx,1),%ecx
    cfbe:	48 0f af c1          	imul   %rcx,%rax
    cfc2:	48 c1 e8 20          	shr    $0x20,%rax
    cfc6:	48 01 f0             	add    %rsi,%rax
    cfc9:	48 05 28 02 00 00    	add    $0x228,%rax
    cfcf:	0f b6 08             	movzbl (%rax),%ecx
    cfd2:	85 c9                	test   %ecx,%ecx
    cfd4:	74 35                	je     d00b <fwp_drop11+0xbb>
    cfd6:	83 f9 01             	cmp    $0x1,%ecx
    cfd9:	75 32                	jne    d00d <fwp_drop11+0xbd>
    cfdb:	48 83 3f 00          	cmpq   $0x0,(%rdi)
    cfdf:	79 3a                	jns    d01b <fwp_drop11+0xcb>
    cfe1:	48 8b 5f 08          	mov    0x8(%rdi),%rbx
    cfe5:	e8 96 d5 ff ff       	call   a580 <fwp_rc_free_arr>
    cfea:	48 89 d8             	mov    %rbx,%rax
    cfed:	48 2b 05 bc 61 00 00 	sub    0x61bc(%rip),%rax        # 131b0 <fwp_gc+0x1030>
    cff4:	48 8b 0d dd 61 00 00 	mov    0x61dd(%rip),%rcx        # 131d8 <fwp_gc+0x1058>
    cffb:	48 c1 e1 10          	shl    $0x10,%rcx
    cfff:	48 89 df             	mov    %rbx,%rdi
    d002:	48 39 c8             	cmp    %rcx,%rax
    d005:	0f 82 64 ff ff ff    	jb     cf6f <fwp_drop11+0x1f>
    d00b:	5b                   	pop    %rbx
    d00c:	c3                   	ret
    d00d:	81 f9 ff 00 00 00    	cmp    $0xff,%ecx
    d013:	74 0c                	je     d021 <fwp_drop11+0xd1>
    d015:	fe c9                	dec    %cl
    d017:	88 08                	mov    %cl,(%rax)
    d019:	5b                   	pop    %rbx
    d01a:	c3                   	ret
    d01b:	5b                   	pop    %rbx
    d01c:	e9 5f d5 ff ff       	jmp    a580 <fwp_rc_free_arr>
    d021:	48 89 c7             	mov    %rax,%rdi
    d024:	5b                   	pop    %rbx
    d025:	e9 66 d6 ff ff       	jmp    a690 <fwp_rc_wide_drop>
    d02a:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)

000000000000d030 <fwp_owned_entry55>:
    d030:	48 8b 3f             	mov    (%rdi),%rdi
    d033:	e9 88 fa ff ff       	jmp    cac0 <f55>
    d038:	0f 1f 84 00 00 00 00 	nopl   0x0(%rax,%rax,1)
    d03f:	00 

000000000000d040 <fwp_caps55>:
    d040:	53                   	push   %rbx
    d041:	83 7f 04 00          	cmpl   $0x0,0x4(%rdi)
    d045:	74 56                	je     d09d <fwp_caps55+0x5d>
    d047:	48 89 fb             	mov    %rdi,%rbx
    d04a:	48 8b 7f 08          	mov    0x8(%rdi),%rdi
    d04e:	85 f6                	test   %esi,%esi
    d050:	74 51                	je     d0a3 <fwp_caps55+0x63>
    d052:	48 2b 3d 57 61 00 00 	sub    0x6157(%rip),%rdi        # 131b0 <fwp_gc+0x1030>
    d059:	48 8b 05 78 61 00 00 	mov    0x6178(%rip),%rax        # 131d8 <fwp_gc+0x1058>
    d060:	48 c1 e0 10          	shl    $0x10,%rax
    d064:	48 39 c7             	cmp    %rax,%rdi
    d067:	73 38                	jae    d0a1 <fwp_caps55+0x61>
    d069:	48 8b 05 88 61 00 00 	mov    0x6188(%rip),%rax        # 131f8 <fwp_gc+0x1078>
    d070:	48 89 f9             	mov    %rdi,%rcx
    d073:	48 c1 e9 10          	shr    $0x10,%rcx
    d077:	48 69 c9 28 12 00 00 	imul   $0x1228,%rcx,%rcx
    d07e:	0f b6 14 08          	movzbl (%rax,%rcx,1),%edx
    d082:	48 81 e7 ff ff 00 00 	and    $0xffff,%rdi
    d089:	75 26                	jne    d0b1 <fwp_caps55+0x71>
    d08b:	80 fa 02             	cmp    $0x2,%dl
    d08e:	75 21                	jne    d0b1 <fwp_caps55+0x71>
    d090:	48 8d 3c 08          	lea    (%rax,%rcx,1),%rdi
    d094:	48 81 c7 28 02 00 00 	add    $0x228,%rdi
    d09b:	eb 33                	jmp    d0d0 <fwp_caps55+0x90>
    d09d:	85 f6                	test   %esi,%esi
    d09f:	74 0a                	je     d0ab <fwp_caps55+0x6b>
    d0a1:	5b                   	pop    %rbx
    d0a2:	c3                   	ret
    d0a3:	e8 f8 fd ff ff       	call   cea0 <fwp_drop12>
    d0a8:	48 89 df             	mov    %rbx,%rdi
    d0ab:	5b                   	pop    %rbx
    d0ac:	e9 bf d8 ff ff       	jmp    a970 <fwp_rc_free_obj>
    d0b1:	80 fa 01             	cmp    $0x1,%dl
    d0b4:	75 eb                	jne    d0a1 <fwp_caps55+0x61>
    d0b6:	48 8d 14 08          	lea    (%rax,%rcx,1),%rdx
    d0ba:	8b 44 08 20          	mov    0x20(%rax,%rcx,1),%eax
    d0be:	48 0f af f8          	imul   %rax,%rdi
    d0c2:	48 c1 ef 20          	shr    $0x20,%rdi
    d0c6:	48 01 d7             	add    %rdx,%rdi
    d0c9:	48 81 c7 28 02 00 00 	add    $0x228,%rdi
    d0d0:	0f b6 07             	movzbl (%rdi),%eax
    d0d3:	84 c0                	test   %al,%al
    d0d5:	74 ca                	je     d0a1 <fwp_caps55+0x61>
    d0d7:	3c fe                	cmp    $0xfe,%al
    d0d9:	73 06                	jae    d0e1 <fwp_caps55+0xa1>
    d0db:	fe c0                	inc    %al
    d0dd:	88 07                	mov    %al,(%rdi)
    d0df:	5b                   	pop    %rbx
    d0e0:	c3                   	ret
    d0e1:	5b                   	pop    %rbx
    d0e2:	e9 59 a5 ff ff       	jmp    7640 <fwp_rc_wide_dup>
    d0e7:	66 0f 1f 84 00 00 00 	nopw   0x0(%rax,%rax,1)
    d0ee:	00 00 

000000000000d0f0 <fwp_args55>:
    d0f0:	85 f6                	test   %esi,%esi
    d0f2:	0f 85 8a 00 00 00    	jne    d182 <fwp_args55+0x92>
    d0f8:	85 d2                	test   %edx,%edx
    d0fa:	0f 84 82 00 00 00    	je     d182 <fwp_args55+0x92>
    d100:	48 8b 07             	mov    (%rdi),%rax
    d103:	48 2b 05 a6 60 00 00 	sub    0x60a6(%rip),%rax        # 131b0 <fwp_gc+0x1030>
    d10a:	48 8b 0d c7 60 00 00 	mov    0x60c7(%rip),%rcx        # 131d8 <fwp_gc+0x1058>
    d111:	48 c1 e1 10          	shl    $0x10,%rcx
    d115:	48 39 c8             	cmp    %rcx,%rax
    d118:	73 68                	jae    d182 <fwp_args55+0x92>
    d11a:	48 8b 0d d7 60 00 00 	mov    0x60d7(%rip),%rcx        # 131f8 <fwp_gc+0x1078>
    d121:	48 89 c2             	mov    %rax,%rdx
    d124:	48 c1 ea 10          	shr    $0x10,%rdx
    d128:	48 69 d2 28 12 00 00 	imul   $0x1228,%rdx,%rdx
    d12f:	0f b6 34 11          	movzbl (%rcx,%rdx,1),%esi
    d133:	48 25 ff ff 00 00    	and    $0xffff,%rax
    d139:	75 13                	jne    d14e <fwp_args55+0x5e>
    d13b:	40 80 fe 02          	cmp    $0x2,%sil
    d13f:	75 0d                	jne    d14e <fwp_args55+0x5e>
    d141:	48 8d 3c 11          	lea    (%rcx,%rdx,1),%rdi
    d145:	48 81 c7 28 02 00 00 	add    $0x228,%rdi
    d14c:	eb 21                	jmp    d16f <fwp_args55+0x7f>
    d14e:	40 80 fe 01          	cmp    $0x1,%sil
    d152:	75 2e                	jne    d182 <fwp_args55+0x92>
    d154:	48 8d 34 11          	lea    (%rcx,%rdx,1),%rsi
    d158:	8b 4c 11 20          	mov    0x20(%rcx,%rdx,1),%ecx
    d15c:	48 0f af c1          	imul   %rcx,%rax
    d160:	48 c1 e8 20          	shr    $0x20,%rax
    d164:	48 8d 3c 30          	lea    (%rax,%rsi,1),%rdi
    d168:	48 81 c7 28 02 00 00 	add    $0x228,%rdi
    d16f:	0f b6 07             	movzbl (%rdi),%eax
    d172:	84 c0                	test   %al,%al
    d174:	74 0c                	je     d182 <fwp_args55+0x92>
    d176:	3c fe                	cmp    $0xfe,%al
    d178:	0f 83 c2 a4 ff ff    	jae    7640 <fwp_rc_wide_dup>
    d17e:	fe c0                	inc    %al
    d180:	88 07                	mov    %al,(%rdi)
    d182:	c3                   	ret
    d183:	66 66 66 66 2e 0f 1f 	data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    d18a:	84 00 00 00 00 00 

000000000000d190 <fwp_arg_drop55>:
    d190:	85 f6                	test   %esi,%esi
    d192:	75 0c                	jne    d1a0 <fwp_arg_drop55+0x10>
    d194:	85 d2                	test   %edx,%edx
    d196:	74 08                	je     d1a0 <fwp_arg_drop55+0x10>
    d198:	48 8b 3f             	mov    (%rdi),%rdi
    d19b:	e9 00 fd ff ff       	jmp    cea0 <fwp_drop12>
    d1a0:	c3                   	ret
    d1a1:	66 66 66 66 66 66 2e 	data16 data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    d1a8:	0f 1f 84 00 00 00 00 
    d1af:	00 

000000000000d1b0 <fwp_drop13>:
    d1b0:	48 89 f8             	mov    %rdi,%rax
    d1b3:	48 2b 05 f6 5f 00 00 	sub    0x5ff6(%rip),%rax        # 131b0 <fwp_gc+0x1030>
    d1ba:	48 8b 0d 17 60 00 00 	mov    0x6017(%rip),%rcx        # 131d8 <fwp_gc+0x1058>
    d1c1:	48 c1 e1 10          	shl    $0x10,%rcx
    d1c5:	48 39 c8             	cmp    %rcx,%rax
    d1c8:	0f 83 92 00 00 00    	jae    d260 <fwp_drop13+0xb0>
    d1ce:	48 8b 0d 23 60 00 00 	mov    0x6023(%rip),%rcx        # 131f8 <fwp_gc+0x1078>
    d1d5:	48 89 c2             	mov    %rax,%rdx
    d1d8:	48 c1 ea 10          	shr    $0x10,%rdx
    d1dc:	48 69 d2 28 12 00 00 	imul   $0x1228,%rdx,%rdx
    d1e3:	0f b6 34 11          	movzbl (%rcx,%rdx,1),%esi
    d1e7:	48 25 ff ff 00 00    	and    $0xffff,%rax
    d1ed:	75 12                	jne    d201 <fwp_drop13+0x51>
    d1ef:	40 80 fe 02          	cmp    $0x2,%sil
    d1f3:	75 0c                	jne    d201 <fwp_drop13+0x51>
    d1f5:	48 8d 04 11          	lea    (%rcx,%rdx,1),%rax
    d1f9:	48 05 28 02 00 00    	add    $0x228,%rax
    d1ff:	eb 1f                	jmp    d220 <fwp_drop13+0x70>
    d201:	40 80 fe 01          	cmp    $0x1,%sil
    d205:	75 59                	jne    d260 <fwp_drop13+0xb0>
    d207:	48 8d 34 11          	lea    (%rcx,%rdx,1),%rsi
    d20b:	8b 4c 11 20          	mov    0x20(%rcx,%rdx,1),%ecx
    d20f:	48 0f af c1          	imul   %rcx,%rax
    d213:	48 c1 e8 20          	shr    $0x20,%rax
    d217:	48 01 f0             	add    %rsi,%rax
    d21a:	48 05 28 02 00 00    	add    $0x228,%rax
    d220:	0f b6 08             	movzbl (%rax),%ecx
    d223:	85 c9                	test   %ecx,%ecx
    d225:	74 39                	je     d260 <fwp_drop13+0xb0>
    d227:	83 f9 01             	cmp    $0x1,%ecx
    d22a:	75 28                	jne    d254 <fwp_drop13+0xa4>
    d22c:	8b 07                	mov    (%rdi),%eax
    d22e:	83 f8 01             	cmp    $0x1,%eax
    d231:	0f 84 39 d7 ff ff    	je     a970 <fwp_rc_free_obj>
    d237:	85 c0                	test   %eax,%eax
    d239:	75 25                	jne    d260 <fwp_drop13+0xb0>
    d23b:	53                   	push   %rbx
    d23c:	48 8b 47 08          	mov    0x8(%rdi),%rax
    d240:	48 89 fb             	mov    %rdi,%rbx
    d243:	48 89 c7             	mov    %rax,%rdi
    d246:	e8 55 fc ff ff       	call   cea0 <fwp_drop12>
    d24b:	48 89 df             	mov    %rbx,%rdi
    d24e:	5b                   	pop    %rbx
    d24f:	e9 1c d7 ff ff       	jmp    a970 <fwp_rc_free_obj>
    d254:	81 f9 ff 00 00 00    	cmp    $0xff,%ecx
    d25a:	74 05                	je     d261 <fwp_drop13+0xb1>
    d25c:	fe c9                	dec    %cl
    d25e:	88 08                	mov    %cl,(%rax)
    d260:	c3                   	ret
    d261:	48 89 c7             	mov    %rax,%rdi
    d264:	e9 27 d4 ff ff       	jmp    a690 <fwp_rc_wide_drop>
    d269:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)

000000000000d270 <f57>:
    d270:	41 57                	push   %r15
    d272:	41 56                	push   %r14
    d274:	41 55                	push   %r13
    d276:	41 54                	push   %r12
    d278:	53                   	push   %rbx
    d279:	48 81 ec 80 00 00 00 	sub    $0x80,%rsp
    d280:	48 89 fb             	mov    %rdi,%rbx
    d283:	48 8b 47 10          	mov    0x10(%rdi),%rax
    d287:	48 2b 05 22 5f 00 00 	sub    0x5f22(%rip),%rax        # 131b0 <fwp_gc+0x1030>
    d28e:	48 8b 0d 43 5f 00 00 	mov    0x5f43(%rip),%rcx        # 131d8 <fwp_gc+0x1058>
    d295:	48 c1 e1 10          	shl    $0x10,%rcx
    d299:	48 39 c8             	cmp    %rcx,%rax
    d29c:	73 68                	jae    d306 <f57+0x96>
    d29e:	48 8b 0d 53 5f 00 00 	mov    0x5f53(%rip),%rcx        # 131f8 <fwp_gc+0x1078>
    d2a5:	48 89 c2             	mov    %rax,%rdx
    d2a8:	48 c1 ea 10          	shr    $0x10,%rdx
    d2ac:	48 69 d2 28 12 00 00 	imul   $0x1228,%rdx,%rdx
    d2b3:	0f b6 34 11          	movzbl (%rcx,%rdx,1),%esi
    d2b7:	48 25 ff ff 00 00    	and    $0xffff,%rax
    d2bd:	75 13                	jne    d2d2 <f57+0x62>
    d2bf:	40 80 fe 02          	cmp    $0x2,%sil
    d2c3:	75 0d                	jne    d2d2 <f57+0x62>
    d2c5:	48 8d 3c 11          	lea    (%rcx,%rdx,1),%rdi
    d2c9:	48 81 c7 28 02 00 00 	add    $0x228,%rdi
    d2d0:	eb 21                	jmp    d2f3 <f57+0x83>
    d2d2:	40 80 fe 01          	cmp    $0x1,%sil
    d2d6:	75 2e                	jne    d306 <f57+0x96>
    d2d8:	48 8d 34 11          	lea    (%rcx,%rdx,1),%rsi
    d2dc:	8b 4c 11 20          	mov    0x20(%rcx,%rdx,1),%ecx
    d2e0:	48 0f af c1          	imul   %rcx,%rax
    d2e4:	48 c1 e8 20          	shr    $0x20,%rax
    d2e8:	48 8d 3c 30          	lea    (%rax,%rsi,1),%rdi
    d2ec:	48 81 c7 28 02 00 00 	add    $0x228,%rdi
    d2f3:	0f b6 07             	movzbl (%rdi),%eax
    d2f6:	84 c0                	test   %al,%al
    d2f8:	74 0c                	je     d306 <f57+0x96>
    d2fa:	3c fe                	cmp    $0xfe,%al
    d2fc:	0f 83 ea 02 00 00    	jae    d5ec <f57+0x37c>
    d302:	fe c0                	inc    %al
    d304:	88 07                	mov    %al,(%rdi)
    d306:	4c 8b 63 08          	mov    0x8(%rbx),%r12
    d30a:	4c 8b 73 10          	mov    0x10(%rbx),%r14
    d30e:	4c 0f be 7b 18       	movsbq 0x18(%rbx),%r15
    d313:	4d 85 e4             	test   %r12,%r12
    d316:	78 27                	js     d33f <f57+0xcf>
    d318:	49 8b 06             	mov    (%r14),%rax
    d31b:	48 b9 ff ff ff ff ff 	movabs $0x7fffffffffffffff,%rcx
    d322:	ff ff 7f 
    d325:	48 21 c1             	and    %rax,%rcx
    d328:	4c 39 e1             	cmp    %r12,%rcx
    d32b:	76 12                	jbe    d33f <f57+0xcf>
    d32d:	48 85 c0             	test   %rax,%rax
    d330:	0f 88 8e 00 00 00    	js     d3c4 <f57+0x154>
    d336:	49 8d 46 08          	lea    0x8(%r14),%rax
    d33a:	e9 89 00 00 00       	jmp    d3c8 <f57+0x158>
    d33f:	4c 89 f7             	mov    %r14,%rdi
    d342:	e8 09 fc ff ff       	call   cf50 <fwp_drop11>
    d347:	48 89 df             	mov    %rbx,%rdi
    d34a:	e8 01 03 00 00       	call   d650 <fwp_drop14>
    d34f:	48 c7 44 24 20 01 00 	movq   $0x1,0x20(%rsp)
    d356:	00 00 
    d358:	48 8d 54 24 28       	lea    0x28(%rsp),%rdx
    d35d:	4c 89 7c 24 28       	mov    %r15,0x28(%rsp)
    d362:	bf 01 00 00 00       	mov    $0x1,%edi
    d367:	be 01 00 00 00       	mov    $0x1,%esi
    d36c:	e8 bf ca ff ff       	call   9e30 <fwp_data>
    d371:	48 89 c1             	mov    %rax,%rcx
    d374:	48 2b 0d 35 5e 00 00 	sub    0x5e35(%rip),%rcx        # 131b0 <fwp_gc+0x1030>
    d37b:	48 8b 15 56 5e 00 00 	mov    0x5e56(%rip),%rdx        # 131d8 <fwp_gc+0x1058>
    d382:	48 c1 e2 10          	shl    $0x10,%rdx
    d386:	48 39 d1             	cmp    %rdx,%rcx
    d389:	0f 83 4c 02 00 00    	jae    d5db <f57+0x36b>
    d38f:	48 8b 15 62 5e 00 00 	mov    0x5e62(%rip),%rdx        # 131f8 <fwp_gc+0x1078>
    d396:	48 89 ce             	mov    %rcx,%rsi
    d399:	48 c1 ee 10          	shr    $0x10,%rsi
    d39d:	48 69 f6 28 12 00 00 	imul   $0x1228,%rsi,%rsi
    d3a4:	0f b6 3c 32          	movzbl (%rdx,%rsi,1),%edi
    d3a8:	48 81 e1 ff ff 00 00 	and    $0xffff,%rcx
    d3af:	0f 85 f0 01 00 00    	jne    d5a5 <f57+0x335>
    d3b5:	40 80 ff 02          	cmp    $0x2,%dil
    d3b9:	0f 84 d1 01 00 00    	je     d590 <f57+0x320>
    d3bf:	e9 e1 01 00 00       	jmp    d5a5 <f57+0x335>
    d3c4:	49 8b 46 10          	mov    0x10(%r14),%rax
    d3c8:	4e 0f be 2c 20       	movsbq (%rax,%r12,1),%r13
    d3cd:	49 8d 45 81          	lea    -0x7f(%r13),%rax
    d3d1:	48 3d ff fe ff ff    	cmp    $0xfffffffffffffeff,%rax
    d3d7:	0f 86 23 02 00 00    	jbe    d600 <f57+0x390>
    d3dd:	4c 89 f0             	mov    %r14,%rax
    d3e0:	48 2b 05 c9 5d 00 00 	sub    0x5dc9(%rip),%rax        # 131b0 <fwp_gc+0x1030>
    d3e7:	48 8b 0d ea 5d 00 00 	mov    0x5dea(%rip),%rcx        # 131d8 <fwp_gc+0x1058>
    d3ee:	48 c1 e1 10          	shl    $0x10,%rcx
    d3f2:	48 39 c8             	cmp    %rcx,%rax
    d3f5:	73 68                	jae    d45f <f57+0x1ef>
    d3f7:	48 8b 0d fa 5d 00 00 	mov    0x5dfa(%rip),%rcx        # 131f8 <fwp_gc+0x1078>
    d3fe:	48 89 c2             	mov    %rax,%rdx
    d401:	48 c1 ea 10          	shr    $0x10,%rdx
    d405:	48 69 d2 28 12 00 00 	imul   $0x1228,%rdx,%rdx
    d40c:	0f b6 34 11          	movzbl (%rcx,%rdx,1),%esi
    d410:	48 25 ff ff 00 00    	and    $0xffff,%rax
    d416:	75 13                	jne    d42b <f57+0x1bb>
    d418:	40 80 fe 02          	cmp    $0x2,%sil
    d41c:	75 0d                	jne    d42b <f57+0x1bb>
    d41e:	48 8d 3c 11          	lea    (%rcx,%rdx,1),%rdi
    d422:	48 81 c7 28 02 00 00 	add    $0x228,%rdi
    d429:	eb 21                	jmp    d44c <f57+0x1dc>
    d42b:	40 80 fe 01          	cmp    $0x1,%sil
    d42f:	75 2e                	jne    d45f <f57+0x1ef>
    d431:	48 8d 34 11          	lea    (%rcx,%rdx,1),%rsi
    d435:	8b 4c 11 20          	mov    0x20(%rcx,%rdx,1),%ecx
    d439:	48 0f af c1          	imul   %rcx,%rax
    d43d:	48 c1 e8 20          	shr    $0x20,%rax
    d441:	48 8d 3c 30          	lea    (%rax,%rsi,1),%rdi
    d445:	48 81 c7 28 02 00 00 	add    $0x228,%rdi
    d44c:	0f b6 07             	movzbl (%rdi),%eax
    d44f:	84 c0                	test   %al,%al
    d451:	74 0c                	je     d45f <f57+0x1ef>
    d453:	3c fe                	cmp    $0xfe,%al
    d455:	0f 83 9b 01 00 00    	jae    d5f6 <f57+0x386>
    d45b:	fe c0                	inc    %al
    d45d:	88 07                	mov    %al,(%rdi)
    d45f:	4c 89 f7             	mov    %r14,%rdi
    d462:	e8 e9 fa ff ff       	call   cf50 <fwp_drop11>
    d467:	4b 8d 04 2f          	lea    (%r15,%r13,1),%rax
    d46b:	48 ff c0             	inc    %rax
    d46e:	48 0f be c8          	movsbq %al,%rcx
    d472:	48 39 c1             	cmp    %rax,%rcx
    d475:	0f 85 85 01 00 00    	jne    d600 <f57+0x390>
    d47b:	49 ff c4             	inc    %r12
    d47e:	4c 89 64 24 08       	mov    %r12,0x8(%rsp)
    d483:	4c 89 74 24 10       	mov    %r14,0x10(%rsp)
    d488:	48 89 44 24 18       	mov    %rax,0x18(%rsp)
    d48d:	48 8d 54 24 08       	lea    0x8(%rsp),%rdx
    d492:	31 ff                	xor    %edi,%edi
    d494:	be 03 00 00 00       	mov    $0x3,%esi
    d499:	e8 92 c9 ff ff       	call   9e30 <fwp_data>
    d49e:	49 89 c6             	mov    %rax,%r14
    d4a1:	48 2b 05 08 5d 00 00 	sub    0x5d08(%rip),%rax        # 131b0 <fwp_gc+0x1030>
    d4a8:	48 8b 0d 29 5d 00 00 	mov    0x5d29(%rip),%rcx        # 131d8 <fwp_gc+0x1058>
    d4af:	48 c1 e1 10          	shl    $0x10,%rcx
    d4b3:	48 39 c8             	cmp    %rcx,%rax
    d4b6:	73 6f                	jae    d527 <f57+0x2b7>
    d4b8:	48 8b 0d 39 5d 00 00 	mov    0x5d39(%rip),%rcx        # 131f8 <fwp_gc+0x1078>
    d4bf:	48 89 c2             	mov    %rax,%rdx
    d4c2:	48 c1 ea 10          	shr    $0x10,%rdx
    d4c6:	48 69 d2 28 12 00 00 	imul   $0x1228,%rdx,%rdx
    d4cd:	0f b6 34 11          	movzbl (%rcx,%rdx,1),%esi
    d4d1:	48 25 ff ff 00 00    	and    $0xffff,%rax
    d4d7:	75 1d                	jne    d4f6 <f57+0x286>
    d4d9:	40 80 fe 02          	cmp    $0x2,%sil
    d4dd:	75 17                	jne    d4f6 <f57+0x286>
    d4df:	4c 8d 3c 11          	lea    (%rcx,%rdx,1),%r15
    d4e3:	49 81 c7 28 02 00 00 	add    $0x228,%r15
    d4ea:	41 80 3f ff          	cmpb   $0xff,(%r15)
    d4ee:	74 2d                	je     d51d <f57+0x2ad>
    d4f0:	41 c6 07 01          	movb   $0x1,(%r15)
    d4f4:	eb 31                	jmp    d527 <f57+0x2b7>
    d4f6:	40 80 fe 01          	cmp    $0x1,%sil
    d4fa:	75 2b                	jne    d527 <f57+0x2b7>
    d4fc:	48 8d 34 11          	lea    (%rcx,%rdx,1),%rsi
    d500:	8b 4c 11 20          	mov    0x20(%rcx,%rdx,1),%ecx
    d504:	48 0f af c1          	imul   %rcx,%rax
    d508:	48 c1 e8 20          	shr    $0x20,%rax
    d50c:	4c 8d 3c 30          	lea    (%rax,%rsi,1),%r15
    d510:	49 81 c7 28 02 00 00 	add    $0x228,%r15
    d517:	41 80 3f ff          	cmpb   $0xff,(%r15)
    d51b:	75 d3                	jne    d4f0 <f57+0x280>
    d51d:	4c 89 ff             	mov    %r15,%rdi
    d520:	e8 3b 8e ff ff       	call   6360 <fwp_rc_forget_slot>
    d525:	eb c9                	jmp    d4f0 <f57+0x280>
    d527:	48 89 df             	mov    %rbx,%rdi
    d52a:	e8 21 01 00 00       	call   d650 <fwp_drop14>
    d52f:	48 c7 44 24 20 00 00 	movq   $0x0,0x20(%rsp)
    d536:	00 00 
    d538:	48 8d 54 24 28       	lea    0x28(%rsp),%rdx
    d53d:	4c 89 74 24 28       	mov    %r14,0x28(%rsp)
    d542:	31 ff                	xor    %edi,%edi
    d544:	be 01 00 00 00       	mov    $0x1,%esi
    d549:	e8 e2 c8 ff ff       	call   9e30 <fwp_data>
    d54e:	48 89 c1             	mov    %rax,%rcx
    d551:	48 2b 0d 58 5c 00 00 	sub    0x5c58(%rip),%rcx        # 131b0 <fwp_gc+0x1030>
    d558:	48 8b 15 79 5c 00 00 	mov    0x5c79(%rip),%rdx        # 131d8 <fwp_gc+0x1058>
    d55f:	48 c1 e2 10          	shl    $0x10,%rdx
    d563:	48 39 d1             	cmp    %rdx,%rcx
    d566:	73 73                	jae    d5db <f57+0x36b>
    d568:	48 8b 15 89 5c 00 00 	mov    0x5c89(%rip),%rdx        # 131f8 <fwp_gc+0x1078>
    d56f:	48 89 ce             	mov    %rcx,%rsi
    d572:	48 c1 ee 10          	shr    $0x10,%rsi
    d576:	48 69 f6 28 12 00 00 	imul   $0x1228,%rsi,%rsi
    d57d:	0f b6 3c 32          	movzbl (%rdx,%rsi,1),%edi
    d581:	48 81 e1 ff ff 00 00 	and    $0xffff,%rcx
    d588:	75 1b                	jne    d5a5 <f57+0x335>
    d58a:	40 80 ff 02          	cmp    $0x2,%dil
    d58e:	75 15                	jne    d5a5 <f57+0x335>
    d590:	48 8d 1c 32          	lea    (%rdx,%rsi,1),%rbx
    d594:	48 81 c3 28 02 00 00 	add    $0x228,%rbx
    d59b:	80 3b ff             	cmpb   $0xff,(%rbx)
    d59e:	74 2b                	je     d5cb <f57+0x35b>
    d5a0:	c6 03 01             	movb   $0x1,(%rbx)
    d5a3:	eb 36                	jmp    d5db <f57+0x36b>
    d5a5:	40 80 ff 01          	cmp    $0x1,%dil
    d5a9:	75 30                	jne    d5db <f57+0x36b>
    d5ab:	48 8d 3c 32          	lea    (%rdx,%rsi,1),%rdi
    d5af:	8b 54 32 20          	mov    0x20(%rdx,%rsi,1),%edx
    d5b3:	48 0f af ca          	imul   %rdx,%rcx
    d5b7:	48 c1 e9 20          	shr    $0x20,%rcx
    d5bb:	48 8d 1c 39          	lea    (%rcx,%rdi,1),%rbx
    d5bf:	48 81 c3 28 02 00 00 	add    $0x228,%rbx
    d5c6:	80 3b ff             	cmpb   $0xff,(%rbx)
    d5c9:	75 d5                	jne    d5a0 <f57+0x330>
    d5cb:	48 89 df             	mov    %rbx,%rdi
    d5ce:	49 89 c6             	mov    %rax,%r14
    d5d1:	e8 8a 8d ff ff       	call   6360 <fwp_rc_forget_slot>
    d5d6:	4c 89 f0             	mov    %r14,%rax
    d5d9:	eb c5                	jmp    d5a0 <f57+0x330>
    d5db:	48 81 c4 80 00 00 00 	add    $0x80,%rsp
    d5e2:	5b                   	pop    %rbx
    d5e3:	41 5c                	pop    %r12
    d5e5:	41 5d                	pop    %r13
    d5e7:	41 5e                	pop    %r14
    d5e9:	41 5f                	pop    %r15
    d5eb:	c3                   	ret
    d5ec:	e8 4f a0 ff ff       	call   7640 <fwp_rc_wide_dup>
    d5f1:	e9 10 fd ff ff       	jmp    d306 <f57+0x96>
    d5f6:	e8 45 a0 ff ff       	call   7640 <fwp_rc_wide_dup>
    d5fb:	e9 5f fe ff ff       	jmp    d45f <f57+0x1ef>
    d600:	48 8d 15 84 20 00 00 	lea    0x2084(%rip),%rdx        # f68b <fwp_segv.msg+0x44b>
    d607:	48 8d 0d 95 1f 00 00 	lea    0x1f95(%rip),%rcx        # f5a3 <fwp_segv.msg+0x363>
    d60e:	48 8d 5c 24 20       	lea    0x20(%rsp),%rbx
    d613:	be 60 00 00 00       	mov    $0x60,%esi
    d618:	48 89 df             	mov    %rbx,%rdi
    d61b:	31 c0                	xor    %eax,%eax
    d61d:	e8 ee 4a ff ff       	call   2110 <snprintf@plt>
    d622:	e8 09 8d ff ff       	call   6330 <fwp_flush>
    d627:	48 8b 05 b2 49 00 00 	mov    0x49b2(%rip),%rax        # 11fe0 <stderr@GLIBC_2.2.5>
    d62e:	48 8b 38             	mov    (%rax),%rdi
    d631:	48 8d 35 f5 1d 00 00 	lea    0x1df5(%rip),%rsi        # f42d <fwp_segv.msg+0x1ed>
    d638:	48 89 da             	mov    %rbx,%rdx
    d63b:	31 c0                	xor    %eax,%eax
    d63d:	e8 6e 4b ff ff       	call   21b0 <fprintf@plt>
    d642:	bf 65 00 00 00       	mov    $0x65,%edi
    d647:	e8 44 4c ff ff       	call   2290 <exit@plt>
    d64c:	0f 1f 40 00          	nopl   0x0(%rax)

000000000000d650 <fwp_drop14>:
    d650:	48 89 f8             	mov    %rdi,%rax
    d653:	48 2b 05 56 5b 00 00 	sub    0x5b56(%rip),%rax        # 131b0 <fwp_gc+0x1030>
    d65a:	48 8b 0d 77 5b 00 00 	mov    0x5b77(%rip),%rcx        # 131d8 <fwp_gc+0x1058>
    d661:	48 c1 e1 10          	shl    $0x10,%rcx
    d665:	48 39 c8             	cmp    %rcx,%rax
    d668:	0f 83 83 00 00 00    	jae    d6f1 <fwp_drop14+0xa1>
    d66e:	48 8b 0d 83 5b 00 00 	mov    0x5b83(%rip),%rcx        # 131f8 <fwp_gc+0x1078>
    d675:	48 89 c2             	mov    %rax,%rdx
    d678:	48 c1 ea 10          	shr    $0x10,%rdx
    d67c:	48 69 d2 28 12 00 00 	imul   $0x1228,%rdx,%rdx
    d683:	0f b6 34 11          	movzbl (%rcx,%rdx,1),%esi
    d687:	48 25 ff ff 00 00    	and    $0xffff,%rax
    d68d:	75 12                	jne    d6a1 <fwp_drop14+0x51>
    d68f:	40 80 fe 02          	cmp    $0x2,%sil
    d693:	75 0c                	jne    d6a1 <fwp_drop14+0x51>
    d695:	48 8d 04 11          	lea    (%rcx,%rdx,1),%rax
    d699:	48 05 28 02 00 00    	add    $0x228,%rax
    d69f:	eb 1f                	jmp    d6c0 <fwp_drop14+0x70>
    d6a1:	40 80 fe 01          	cmp    $0x1,%sil
    d6a5:	75 4a                	jne    d6f1 <fwp_drop14+0xa1>
    d6a7:	48 8d 34 11          	lea    (%rcx,%rdx,1),%rsi
    d6ab:	8b 4c 11 20          	mov    0x20(%rcx,%rdx,1),%ecx
    d6af:	48 0f af c1          	imul   %rcx,%rax
    d6b3:	48 c1 e8 20          	shr    $0x20,%rax
    d6b7:	48 01 f0             	add    %rsi,%rax
    d6ba:	48 05 28 02 00 00    	add    $0x228,%rax
    d6c0:	0f b6 08             	movzbl (%rax),%ecx
    d6c3:	85 c9                	test   %ecx,%ecx
    d6c5:	74 2a                	je     d6f1 <fwp_drop14+0xa1>
    d6c7:	83 f9 01             	cmp    $0x1,%ecx
    d6ca:	75 19                	jne    d6e5 <fwp_drop14+0x95>
    d6cc:	53                   	push   %rbx
    d6cd:	48 8b 47 10          	mov    0x10(%rdi),%rax
    d6d1:	48 89 fb             	mov    %rdi,%rbx
    d6d4:	48 89 c7             	mov    %rax,%rdi
    d6d7:	e8 74 f8 ff ff       	call   cf50 <fwp_drop11>
    d6dc:	48 89 df             	mov    %rbx,%rdi
    d6df:	5b                   	pop    %rbx
    d6e0:	e9 8b d2 ff ff       	jmp    a970 <fwp_rc_free_obj>
    d6e5:	81 f9 ff 00 00 00    	cmp    $0xff,%ecx
    d6eb:	74 05                	je     d6f2 <fwp_drop14+0xa2>
    d6ed:	fe c9                	dec    %cl
    d6ef:	88 08                	mov    %cl,(%rax)
    d6f1:	c3                   	ret
    d6f2:	48 89 c7             	mov    %rax,%rdi
    d6f5:	e9 96 cf ff ff       	jmp    a690 <fwp_rc_wide_drop>
    d6fa:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)

000000000000d700 <fwp_owned_entry57>:
    d700:	48 8b 3f             	mov    (%rdi),%rdi
    d703:	e9 68 fb ff ff       	jmp    d270 <f57>
    d708:	0f 1f 84 00 00 00 00 	nopl   0x0(%rax,%rax,1)
    d70f:	00 

000000000000d710 <fwp_caps57>:
    d710:	53                   	push   %rbx
    d711:	83 7f 04 00          	cmpl   $0x0,0x4(%rdi)
    d715:	74 56                	je     d76d <fwp_caps57+0x5d>
    d717:	48 89 fb             	mov    %rdi,%rbx
    d71a:	48 8b 7f 08          	mov    0x8(%rdi),%rdi
    d71e:	85 f6                	test   %esi,%esi
    d720:	74 51                	je     d773 <fwp_caps57+0x63>
    d722:	48 2b 3d 87 5a 00 00 	sub    0x5a87(%rip),%rdi        # 131b0 <fwp_gc+0x1030>
    d729:	48 8b 05 a8 5a 00 00 	mov    0x5aa8(%rip),%rax        # 131d8 <fwp_gc+0x1058>
    d730:	48 c1 e0 10          	shl    $0x10,%rax
    d734:	48 39 c7             	cmp    %rax,%rdi
    d737:	73 38                	jae    d771 <fwp_caps57+0x61>
    d739:	48 8b 05 b8 5a 00 00 	mov    0x5ab8(%rip),%rax        # 131f8 <fwp_gc+0x1078>
    d740:	48 89 f9             	mov    %rdi,%rcx
    d743:	48 c1 e9 10          	shr    $0x10,%rcx
    d747:	48 69 c9 28 12 00 00 	imul   $0x1228,%rcx,%rcx
    d74e:	0f b6 14 08          	movzbl (%rax,%rcx,1),%edx
    d752:	48 81 e7 ff ff 00 00 	and    $0xffff,%rdi
    d759:	75 26                	jne    d781 <fwp_caps57+0x71>
    d75b:	80 fa 02             	cmp    $0x2,%dl
    d75e:	75 21                	jne    d781 <fwp_caps57+0x71>
    d760:	48 8d 3c 08          	lea    (%rax,%rcx,1),%rdi
    d764:	48 81 c7 28 02 00 00 	add    $0x228,%rdi
    d76b:	eb 33                	jmp    d7a0 <fwp_caps57+0x90>
    d76d:	85 f6                	test   %esi,%esi
    d76f:	74 0a                	je     d77b <fwp_caps57+0x6b>
    d771:	5b                   	pop    %rbx
    d772:	c3                   	ret
    d773:	e8 d8 fe ff ff       	call   d650 <fwp_drop14>
    d778:	48 89 df             	mov    %rbx,%rdi
    d77b:	5b                   	pop    %rbx
    d77c:	e9 ef d1 ff ff       	jmp    a970 <fwp_rc_free_obj>
    d781:	80 fa 01             	cmp    $0x1,%dl
    d784:	75 eb                	jne    d771 <fwp_caps57+0x61>
    d786:	48 8d 14 08          	lea    (%rax,%rcx,1),%rdx
    d78a:	8b 44 08 20          	mov    0x20(%rax,%rcx,1),%eax
    d78e:	48 0f af f8          	imul   %rax,%rdi
    d792:	48 c1 ef 20          	shr    $0x20,%rdi
    d796:	48 01 d7             	add    %rdx,%rdi
    d799:	48 81 c7 28 02 00 00 	add    $0x228,%rdi
    d7a0:	0f b6 07             	movzbl (%rdi),%eax
    d7a3:	84 c0                	test   %al,%al
    d7a5:	74 ca                	je     d771 <fwp_caps57+0x61>
    d7a7:	3c fe                	cmp    $0xfe,%al
    d7a9:	73 06                	jae    d7b1 <fwp_caps57+0xa1>
    d7ab:	fe c0                	inc    %al
    d7ad:	88 07                	mov    %al,(%rdi)
    d7af:	5b                   	pop    %rbx
    d7b0:	c3                   	ret
    d7b1:	5b                   	pop    %rbx
    d7b2:	e9 89 9e ff ff       	jmp    7640 <fwp_rc_wide_dup>
    d7b7:	66 0f 1f 84 00 00 00 	nopw   0x0(%rax,%rax,1)
    d7be:	00 00 

000000000000d7c0 <fwp_args57>:
    d7c0:	85 f6                	test   %esi,%esi
    d7c2:	0f 85 8a 00 00 00    	jne    d852 <fwp_args57+0x92>
    d7c8:	85 d2                	test   %edx,%edx
    d7ca:	0f 84 82 00 00 00    	je     d852 <fwp_args57+0x92>
    d7d0:	48 8b 07             	mov    (%rdi),%rax
    d7d3:	48 2b 05 d6 59 00 00 	sub    0x59d6(%rip),%rax        # 131b0 <fwp_gc+0x1030>
    d7da:	48 8b 0d f7 59 00 00 	mov    0x59f7(%rip),%rcx        # 131d8 <fwp_gc+0x1058>
    d7e1:	48 c1 e1 10          	shl    $0x10,%rcx
    d7e5:	48 39 c8             	cmp    %rcx,%rax
    d7e8:	73 68                	jae    d852 <fwp_args57+0x92>
    d7ea:	48 8b 0d 07 5a 00 00 	mov    0x5a07(%rip),%rcx        # 131f8 <fwp_gc+0x1078>
    d7f1:	48 89 c2             	mov    %rax,%rdx
    d7f4:	48 c1 ea 10          	shr    $0x10,%rdx
    d7f8:	48 69 d2 28 12 00 00 	imul   $0x1228,%rdx,%rdx
    d7ff:	0f b6 34 11          	movzbl (%rcx,%rdx,1),%esi
    d803:	48 25 ff ff 00 00    	and    $0xffff,%rax
    d809:	75 13                	jne    d81e <fwp_args57+0x5e>
    d80b:	40 80 fe 02          	cmp    $0x2,%sil
    d80f:	75 0d                	jne    d81e <fwp_args57+0x5e>
    d811:	48 8d 3c 11          	lea    (%rcx,%rdx,1),%rdi
    d815:	48 81 c7 28 02 00 00 	add    $0x228,%rdi
    d81c:	eb 21                	jmp    d83f <fwp_args57+0x7f>
    d81e:	40 80 fe 01          	cmp    $0x1,%sil
    d822:	75 2e                	jne    d852 <fwp_args57+0x92>
    d824:	48 8d 34 11          	lea    (%rcx,%rdx,1),%rsi
    d828:	8b 4c 11 20          	mov    0x20(%rcx,%rdx,1),%ecx
    d82c:	48 0f af c1          	imul   %rcx,%rax
    d830:	48 c1 e8 20          	shr    $0x20,%rax
    d834:	48 8d 3c 30          	lea    (%rax,%rsi,1),%rdi
    d838:	48 81 c7 28 02 00 00 	add    $0x228,%rdi
    d83f:	0f b6 07             	movzbl (%rdi),%eax
    d842:	84 c0                	test   %al,%al
    d844:	74 0c                	je     d852 <fwp_args57+0x92>
    d846:	3c fe                	cmp    $0xfe,%al
    d848:	0f 83 f2 9d ff ff    	jae    7640 <fwp_rc_wide_dup>
    d84e:	fe c0                	inc    %al
    d850:	88 07                	mov    %al,(%rdi)
    d852:	c3                   	ret
    d853:	66 66 66 66 2e 0f 1f 	data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    d85a:	84 00 00 00 00 00 

000000000000d860 <fwp_arg_drop57>:
    d860:	85 f6                	test   %esi,%esi
    d862:	75 0c                	jne    d870 <fwp_arg_drop57+0x10>
    d864:	85 d2                	test   %edx,%edx
    d866:	74 08                	je     d870 <fwp_arg_drop57+0x10>
    d868:	48 8b 3f             	mov    (%rdi),%rdi
    d86b:	e9 e0 fd ff ff       	jmp    d650 <fwp_drop14>
    d870:	c3                   	ret
    d871:	66 66 66 66 66 66 2e 	data16 data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    d878:	0f 1f 84 00 00 00 00 
    d87f:	00 

000000000000d880 <fwp_drop15>:
    d880:	48 89 f8             	mov    %rdi,%rax
    d883:	48 2b 05 26 59 00 00 	sub    0x5926(%rip),%rax        # 131b0 <fwp_gc+0x1030>
    d88a:	48 8b 0d 47 59 00 00 	mov    0x5947(%rip),%rcx        # 131d8 <fwp_gc+0x1058>
    d891:	48 c1 e1 10          	shl    $0x10,%rcx
    d895:	48 39 c8             	cmp    %rcx,%rax
    d898:	0f 83 92 00 00 00    	jae    d930 <fwp_drop15+0xb0>
    d89e:	48 8b 0d 53 59 00 00 	mov    0x5953(%rip),%rcx        # 131f8 <fwp_gc+0x1078>
    d8a5:	48 89 c2             	mov    %rax,%rdx
    d8a8:	48 c1 ea 10          	shr    $0x10,%rdx
    d8ac:	48 69 d2 28 12 00 00 	imul   $0x1228,%rdx,%rdx
    d8b3:	0f b6 34 11          	movzbl (%rcx,%rdx,1),%esi
    d8b7:	48 25 ff ff 00 00    	and    $0xffff,%rax
    d8bd:	75 12                	jne    d8d1 <fwp_drop15+0x51>
    d8bf:	40 80 fe 02          	cmp    $0x2,%sil
    d8c3:	75 0c                	jne    d8d1 <fwp_drop15+0x51>
    d8c5:	48 8d 04 11          	lea    (%rcx,%rdx,1),%rax
    d8c9:	48 05 28 02 00 00    	add    $0x228,%rax
    d8cf:	eb 1f                	jmp    d8f0 <fwp_drop15+0x70>
    d8d1:	40 80 fe 01          	cmp    $0x1,%sil
    d8d5:	75 59                	jne    d930 <fwp_drop15+0xb0>
    d8d7:	48 8d 34 11          	lea    (%rcx,%rdx,1),%rsi
    d8db:	8b 4c 11 20          	mov    0x20(%rcx,%rdx,1),%ecx
    d8df:	48 0f af c1          	imul   %rcx,%rax
    d8e3:	48 c1 e8 20          	shr    $0x20,%rax
    d8e7:	48 01 f0             	add    %rsi,%rax
    d8ea:	48 05 28 02 00 00    	add    $0x228,%rax
    d8f0:	0f b6 08             	movzbl (%rax),%ecx
    d8f3:	85 c9                	test   %ecx,%ecx
    d8f5:	74 39                	je     d930 <fwp_drop15+0xb0>
    d8f7:	83 f9 01             	cmp    $0x1,%ecx
    d8fa:	75 28                	jne    d924 <fwp_drop15+0xa4>
    d8fc:	8b 07                	mov    (%rdi),%eax
    d8fe:	83 f8 01             	cmp    $0x1,%eax
    d901:	0f 84 69 d0 ff ff    	je     a970 <fwp_rc_free_obj>
    d907:	85 c0                	test   %eax,%eax
    d909:	75 25                	jne    d930 <fwp_drop15+0xb0>
    d90b:	53                   	push   %rbx
    d90c:	48 8b 47 08          	mov    0x8(%rdi),%rax
    d910:	48 89 fb             	mov    %rdi,%rbx
    d913:	48 89 c7             	mov    %rax,%rdi
    d916:	e8 35 fd ff ff       	call   d650 <fwp_drop14>
    d91b:	48 89 df             	mov    %rbx,%rdi
    d91e:	5b                   	pop    %rbx
    d91f:	e9 4c d0 ff ff       	jmp    a970 <fwp_rc_free_obj>
    d924:	81 f9 ff 00 00 00    	cmp    $0xff,%ecx
    d92a:	74 05                	je     d931 <fwp_drop15+0xb1>
    d92c:	fe c9                	dec    %cl
    d92e:	88 08                	mov    %cl,(%rax)
    d930:	c3                   	ret
    d931:	48 89 c7             	mov    %rax,%rdi
    d934:	e9 57 cd ff ff       	jmp    a690 <fwp_rc_wide_drop>
    d939:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)

000000000000d940 <f59>:
    d940:	41 57                	push   %r15
    d942:	41 56                	push   %r14
    d944:	53                   	push   %rbx
    d945:	48 83 ec 30          	sub    $0x30,%rsp
    d949:	48 89 fb             	mov    %rdi,%rbx
    d94c:	48 8b 47 10          	mov    0x10(%rdi),%rax
    d950:	48 2b 05 59 58 00 00 	sub    0x5859(%rip),%rax        # 131b0 <fwp_gc+0x1030>
    d957:	48 8b 0d 7a 58 00 00 	mov    0x587a(%rip),%rcx        # 131d8 <fwp_gc+0x1058>
    d95e:	48 c1 e1 10          	shl    $0x10,%rcx
    d962:	48 39 c8             	cmp    %rcx,%rax
    d965:	73 68                	jae    d9cf <f59+0x8f>
    d967:	48 8b 0d 8a 58 00 00 	mov    0x588a(%rip),%rcx        # 131f8 <fwp_gc+0x1078>
    d96e:	48 89 c2             	mov    %rax,%rdx
    d971:	48 c1 ea 10          	shr    $0x10,%rdx
    d975:	48 69 d2 28 12 00 00 	imul   $0x1228,%rdx,%rdx
    d97c:	0f b6 34 11          	movzbl (%rcx,%rdx,1),%esi
    d980:	48 25 ff ff 00 00    	and    $0xffff,%rax
    d986:	75 13                	jne    d99b <f59+0x5b>
    d988:	40 80 fe 02          	cmp    $0x2,%sil
    d98c:	75 0d                	jne    d99b <f59+0x5b>
    d98e:	48 8d 3c 11          	lea    (%rcx,%rdx,1),%rdi
    d992:	48 81 c7 28 02 00 00 	add    $0x228,%rdi
    d999:	eb 21                	jmp    d9bc <f59+0x7c>
    d99b:	40 80 fe 01          	cmp    $0x1,%sil
    d99f:	75 2e                	jne    d9cf <f59+0x8f>
    d9a1:	48 8d 34 11          	lea    (%rcx,%rdx,1),%rsi
    d9a5:	8b 4c 11 20          	mov    0x20(%rcx,%rdx,1),%ecx
    d9a9:	48 0f af c1          	imul   %rcx,%rax
    d9ad:	48 c1 e8 20          	shr    $0x20,%rax
    d9b1:	48 8d 3c 30          	lea    (%rax,%rsi,1),%rdi
    d9b5:	48 81 c7 28 02 00 00 	add    $0x228,%rdi
    d9bc:	0f b6 07             	movzbl (%rdi),%eax
    d9bf:	84 c0                	test   %al,%al
    d9c1:	74 0c                	je     d9cf <f59+0x8f>
    d9c3:	3c fe                	cmp    $0xfe,%al
    d9c5:	0f 83 d8 01 00 00    	jae    dba3 <f59+0x263>
    d9cb:	fe c0                	inc    %al
    d9cd:	88 07                	mov    %al,(%rdi)
    d9cf:	4c 8b 7b 08          	mov    0x8(%rbx),%r15
    d9d3:	48 8b 7b 10          	mov    0x10(%rbx),%rdi
    d9d7:	4c 8b 73 18          	mov    0x18(%rbx),%r14
    d9db:	4d 85 ff             	test   %r15,%r15
    d9de:	78 20                	js     da00 <f59+0xc0>
    d9e0:	48 8b 07             	mov    (%rdi),%rax
    d9e3:	48 b9 ff ff ff ff ff 	movabs $0x7fffffffffffffff,%rcx
    d9ea:	ff ff 7f 
    d9ed:	48 21 c1             	and    %rax,%rcx
    d9f0:	4c 39 f9             	cmp    %r15,%rcx
    d9f3:	76 0b                	jbe    da00 <f59+0xc0>
    d9f5:	48 85 c0             	test   %rax,%rax
    d9f8:	78 2e                	js     da28 <f59+0xe8>
    d9fa:	48 8d 47 08          	lea    0x8(%rdi),%rax
    d9fe:	eb 2c                	jmp    da2c <f59+0xec>
    da00:	e8 9b ca ff ff       	call   a4a0 <fwp_drop1>
    da05:	41 bf 01 00 00 00    	mov    $0x1,%r15d
    da0b:	48 89 df             	mov    %rbx,%rdi
    da0e:	e8 bd c8 ff ff       	call   a2d0 <fwp_drop6>
    da13:	4c 89 ff             	mov    %r15,%rdi
    da16:	4c 89 f6             	mov    %r14,%rsi
    da19:	e8 62 c9 ff ff       	call   a380 <fwp_vbox1>
    da1e:	48 83 c4 30          	add    $0x30,%rsp
    da22:	5b                   	pop    %rbx
    da23:	41 5e                	pop    %r14
    da25:	41 5f                	pop    %r15
    da27:	c3                   	ret
    da28:	48 8b 47 10          	mov    0x10(%rdi),%rax
    da2c:	4c 89 74 24 08       	mov    %r14,0x8(%rsp)
    da31:	f2 42 0f 10 04 f8    	movsd  (%rax,%r15,8),%xmm0
    da37:	f2 0f 59 05 d1 15 00 	mulsd  0x15d1(%rip),%xmm0        # f010 <_IO_stdin_used+0x10>
    da3e:	00 
    da3f:	f2 0f 58 05 d1 15 00 	addsd  0x15d1(%rip),%xmm0        # f018 <_IO_stdin_used+0x18>
    da46:	00 
    da47:	f2 0f 11 44 24 10    	movsd  %xmm0,0x10(%rsp)
    da4d:	48 89 f8             	mov    %rdi,%rax
    da50:	48 2b 05 59 57 00 00 	sub    0x5759(%rip),%rax        # 131b0 <fwp_gc+0x1030>
    da57:	49 ff c7             	inc    %r15
    da5a:	48 8b 0d 77 57 00 00 	mov    0x5777(%rip),%rcx        # 131d8 <fwp_gc+0x1058>
    da61:	48 c1 e1 10          	shl    $0x10,%rcx
    da65:	48 39 c8             	cmp    %rcx,%rax
    da68:	73 66                	jae    dad0 <f59+0x190>
    da6a:	48 8b 0d 87 57 00 00 	mov    0x5787(%rip),%rcx        # 131f8 <fwp_gc+0x1078>
    da71:	48 89 c2             	mov    %rax,%rdx
    da74:	48 c1 ea 10          	shr    $0x10,%rdx
    da78:	48 69 d2 28 12 00 00 	imul   $0x1228,%rdx,%rdx
    da7f:	0f b6 34 11          	movzbl (%rcx,%rdx,1),%esi
    da83:	48 25 ff ff 00 00    	and    $0xffff,%rax
    da89:	75 12                	jne    da9d <f59+0x15d>
    da8b:	40 80 fe 02          	cmp    $0x2,%sil
    da8f:	75 0c                	jne    da9d <f59+0x15d>
    da91:	48 8d 04 11          	lea    (%rcx,%rdx,1),%rax
    da95:	48 05 28 02 00 00    	add    $0x228,%rax
    da9b:	eb 1f                	jmp    dabc <f59+0x17c>
    da9d:	40 80 fe 01          	cmp    $0x1,%sil
    daa1:	75 2d                	jne    dad0 <f59+0x190>
    daa3:	48 8d 34 11          	lea    (%rcx,%rdx,1),%rsi
    daa7:	8b 4c 11 20          	mov    0x20(%rcx,%rdx,1),%ecx
    daab:	48 0f af c1          	imul   %rcx,%rax
    daaf:	48 c1 e8 20          	shr    $0x20,%rax
    dab3:	48 01 f0             	add    %rsi,%rax
    dab6:	48 05 28 02 00 00    	add    $0x228,%rax
    dabc:	0f b6 08             	movzbl (%rax),%ecx
    dabf:	84 c9                	test   %cl,%cl
    dac1:	74 0d                	je     dad0 <f59+0x190>
    dac3:	80 f9 fe             	cmp    $0xfe,%cl
    dac6:	0f 83 e1 00 00 00    	jae    dbad <f59+0x26d>
    dacc:	fe c1                	inc    %cl
    dace:	88 08                	mov    %cl,(%rax)
    dad0:	49 89 fe             	mov    %rdi,%r14
    dad3:	e8 c8 c9 ff ff       	call   a4a0 <fwp_drop1>
    dad8:	f2 0f 10 44 24 10    	movsd  0x10(%rsp),%xmm0
    dade:	f2 0f 58 44 24 08    	addsd  0x8(%rsp),%xmm0
    dae4:	4c 89 7c 24 18       	mov    %r15,0x18(%rsp)
    dae9:	4c 89 74 24 20       	mov    %r14,0x20(%rsp)
    daee:	f2 0f 11 44 24 28    	movsd  %xmm0,0x28(%rsp)
    daf4:	45 31 ff             	xor    %r15d,%r15d
    daf7:	48 8d 54 24 18       	lea    0x18(%rsp),%rdx
    dafc:	31 ff                	xor    %edi,%edi
    dafe:	be 03 00 00 00       	mov    $0x3,%esi
    db03:	e8 28 c3 ff ff       	call   9e30 <fwp_data>
    db08:	49 89 c6             	mov    %rax,%r14
    db0b:	48 2b 05 9e 56 00 00 	sub    0x569e(%rip),%rax        # 131b0 <fwp_gc+0x1030>
    db12:	48 8b 0d bf 56 00 00 	mov    0x56bf(%rip),%rcx        # 131d8 <fwp_gc+0x1058>
    db19:	48 c1 e1 10          	shl    $0x10,%rcx
    db1d:	48 39 c8             	cmp    %rcx,%rax
    db20:	0f 83 e5 fe ff ff    	jae    da0b <f59+0xcb>
    db26:	48 8b 0d cb 56 00 00 	mov    0x56cb(%rip),%rcx        # 131f8 <fwp_gc+0x1078>
    db2d:	48 89 c2             	mov    %rax,%rdx
    db30:	48 c1 ea 10          	shr    $0x10,%rdx
    db34:	48 69 d2 28 12 00 00 	imul   $0x1228,%rdx,%rdx
    db3b:	0f b6 34 11          	movzbl (%rcx,%rdx,1),%esi
    db3f:	48 25 ff ff 00 00    	and    $0xffff,%rax
    db45:	75 23                	jne    db6a <f59+0x22a>
    db47:	40 80 fe 02          	cmp    $0x2,%sil
    db4b:	75 1d                	jne    db6a <f59+0x22a>
    db4d:	4c 8d 3c 11          	lea    (%rcx,%rdx,1),%r15
    db51:	49 81 c7 28 02 00 00 	add    $0x228,%r15
    db58:	41 80 3f ff          	cmpb   $0xff,(%r15)
    db5c:	74 33                	je     db91 <f59+0x251>
    db5e:	41 c6 07 01          	movb   $0x1,(%r15)
    db62:	45 31 ff             	xor    %r15d,%r15d
    db65:	e9 a1 fe ff ff       	jmp    da0b <f59+0xcb>
    db6a:	40 80 fe 01          	cmp    $0x1,%sil
    db6e:	75 2b                	jne    db9b <f59+0x25b>
    db70:	48 8d 34 11          	lea    (%rcx,%rdx,1),%rsi
    db74:	8b 4c 11 20          	mov    0x20(%rcx,%rdx,1),%ecx
    db78:	48 0f af c1          	imul   %rcx,%rax
    db7c:	48 c1 e8 20          	shr    $0x20,%rax
    db80:	4c 8d 3c 30          	lea    (%rax,%rsi,1),%r15
    db84:	49 81 c7 28 02 00 00 	add    $0x228,%r15
    db8b:	41 80 3f ff          	cmpb   $0xff,(%r15)
    db8f:	75 cd                	jne    db5e <f59+0x21e>
    db91:	4c 89 ff             	mov    %r15,%rdi
    db94:	e8 c7 87 ff ff       	call   6360 <fwp_rc_forget_slot>
    db99:	eb c3                	jmp    db5e <f59+0x21e>
    db9b:	45 31 ff             	xor    %r15d,%r15d
    db9e:	e9 68 fe ff ff       	jmp    da0b <f59+0xcb>
    dba3:	e8 98 9a ff ff       	call   7640 <fwp_rc_wide_dup>
    dba8:	e9 22 fe ff ff       	jmp    d9cf <f59+0x8f>
    dbad:	49 89 fe             	mov    %rdi,%r14
    dbb0:	48 89 c7             	mov    %rax,%rdi
    dbb3:	e8 88 9a ff ff       	call   7640 <fwp_rc_wide_dup>
    dbb8:	4c 89 f7             	mov    %r14,%rdi
    dbbb:	e9 10 ff ff ff       	jmp    dad0 <f59+0x190>

000000000000dbc0 <fwp_owned_entry59>:
    dbc0:	48 8b 3f             	mov    (%rdi),%rdi
    dbc3:	e9 78 fd ff ff       	jmp    d940 <f59>
    dbc8:	0f 1f 84 00 00 00 00 	nopl   0x0(%rax,%rax,1)
    dbcf:	00 

000000000000dbd0 <fwp_caps59>:
    dbd0:	53                   	push   %rbx
    dbd1:	83 7f 04 00          	cmpl   $0x0,0x4(%rdi)
    dbd5:	74 56                	je     dc2d <fwp_caps59+0x5d>
    dbd7:	48 89 fb             	mov    %rdi,%rbx
    dbda:	48 8b 7f 08          	mov    0x8(%rdi),%rdi
    dbde:	85 f6                	test   %esi,%esi
    dbe0:	74 51                	je     dc33 <fwp_caps59+0x63>
    dbe2:	48 2b 3d c7 55 00 00 	sub    0x55c7(%rip),%rdi        # 131b0 <fwp_gc+0x1030>
    dbe9:	48 8b 05 e8 55 00 00 	mov    0x55e8(%rip),%rax        # 131d8 <fwp_gc+0x1058>
    dbf0:	48 c1 e0 10          	shl    $0x10,%rax
    dbf4:	48 39 c7             	cmp    %rax,%rdi
    dbf7:	73 38                	jae    dc31 <fwp_caps59+0x61>
    dbf9:	48 8b 05 f8 55 00 00 	mov    0x55f8(%rip),%rax        # 131f8 <fwp_gc+0x1078>
    dc00:	48 89 f9             	mov    %rdi,%rcx
    dc03:	48 c1 e9 10          	shr    $0x10,%rcx
    dc07:	48 69 c9 28 12 00 00 	imul   $0x1228,%rcx,%rcx
    dc0e:	0f b6 14 08          	movzbl (%rax,%rcx,1),%edx
    dc12:	48 81 e7 ff ff 00 00 	and    $0xffff,%rdi
    dc19:	75 26                	jne    dc41 <fwp_caps59+0x71>
    dc1b:	80 fa 02             	cmp    $0x2,%dl
    dc1e:	75 21                	jne    dc41 <fwp_caps59+0x71>
    dc20:	48 8d 3c 08          	lea    (%rax,%rcx,1),%rdi
    dc24:	48 81 c7 28 02 00 00 	add    $0x228,%rdi
    dc2b:	eb 33                	jmp    dc60 <fwp_caps59+0x90>
    dc2d:	85 f6                	test   %esi,%esi
    dc2f:	74 0a                	je     dc3b <fwp_caps59+0x6b>
    dc31:	5b                   	pop    %rbx
    dc32:	c3                   	ret
    dc33:	e8 98 c6 ff ff       	call   a2d0 <fwp_drop6>
    dc38:	48 89 df             	mov    %rbx,%rdi
    dc3b:	5b                   	pop    %rbx
    dc3c:	e9 2f cd ff ff       	jmp    a970 <fwp_rc_free_obj>
    dc41:	80 fa 01             	cmp    $0x1,%dl
    dc44:	75 eb                	jne    dc31 <fwp_caps59+0x61>
    dc46:	48 8d 14 08          	lea    (%rax,%rcx,1),%rdx
    dc4a:	8b 44 08 20          	mov    0x20(%rax,%rcx,1),%eax
    dc4e:	48 0f af f8          	imul   %rax,%rdi
    dc52:	48 c1 ef 20          	shr    $0x20,%rdi
    dc56:	48 01 d7             	add    %rdx,%rdi
    dc59:	48 81 c7 28 02 00 00 	add    $0x228,%rdi
    dc60:	0f b6 07             	movzbl (%rdi),%eax
    dc63:	84 c0                	test   %al,%al
    dc65:	74 ca                	je     dc31 <fwp_caps59+0x61>
    dc67:	3c fe                	cmp    $0xfe,%al
    dc69:	73 06                	jae    dc71 <fwp_caps59+0xa1>
    dc6b:	fe c0                	inc    %al
    dc6d:	88 07                	mov    %al,(%rdi)
    dc6f:	5b                   	pop    %rbx
    dc70:	c3                   	ret
    dc71:	5b                   	pop    %rbx
    dc72:	e9 c9 99 ff ff       	jmp    7640 <fwp_rc_wide_dup>
    dc77:	66 0f 1f 84 00 00 00 	nopw   0x0(%rax,%rax,1)
    dc7e:	00 00 

000000000000dc80 <fwp_args59>:
    dc80:	85 f6                	test   %esi,%esi
    dc82:	0f 85 8a 00 00 00    	jne    dd12 <fwp_args59+0x92>
    dc88:	85 d2                	test   %edx,%edx
    dc8a:	0f 84 82 00 00 00    	je     dd12 <fwp_args59+0x92>
    dc90:	48 8b 07             	mov    (%rdi),%rax
    dc93:	48 2b 05 16 55 00 00 	sub    0x5516(%rip),%rax        # 131b0 <fwp_gc+0x1030>
    dc9a:	48 8b 0d 37 55 00 00 	mov    0x5537(%rip),%rcx        # 131d8 <fwp_gc+0x1058>
    dca1:	48 c1 e1 10          	shl    $0x10,%rcx
    dca5:	48 39 c8             	cmp    %rcx,%rax
    dca8:	73 68                	jae    dd12 <fwp_args59+0x92>
    dcaa:	48 8b 0d 47 55 00 00 	mov    0x5547(%rip),%rcx        # 131f8 <fwp_gc+0x1078>
    dcb1:	48 89 c2             	mov    %rax,%rdx
    dcb4:	48 c1 ea 10          	shr    $0x10,%rdx
    dcb8:	48 69 d2 28 12 00 00 	imul   $0x1228,%rdx,%rdx
    dcbf:	0f b6 34 11          	movzbl (%rcx,%rdx,1),%esi
    dcc3:	48 25 ff ff 00 00    	and    $0xffff,%rax
    dcc9:	75 13                	jne    dcde <fwp_args59+0x5e>
    dccb:	40 80 fe 02          	cmp    $0x2,%sil
    dccf:	75 0d                	jne    dcde <fwp_args59+0x5e>
    dcd1:	48 8d 3c 11          	lea    (%rcx,%rdx,1),%rdi
    dcd5:	48 81 c7 28 02 00 00 	add    $0x228,%rdi
    dcdc:	eb 21                	jmp    dcff <fwp_args59+0x7f>
    dcde:	40 80 fe 01          	cmp    $0x1,%sil
    dce2:	75 2e                	jne    dd12 <fwp_args59+0x92>
    dce4:	48 8d 34 11          	lea    (%rcx,%rdx,1),%rsi
    dce8:	8b 4c 11 20          	mov    0x20(%rcx,%rdx,1),%ecx
    dcec:	48 0f af c1          	imul   %rcx,%rax
    dcf0:	48 c1 e8 20          	shr    $0x20,%rax
    dcf4:	48 8d 3c 30          	lea    (%rax,%rsi,1),%rdi
    dcf8:	48 81 c7 28 02 00 00 	add    $0x228,%rdi
    dcff:	0f b6 07             	movzbl (%rdi),%eax
    dd02:	84 c0                	test   %al,%al
    dd04:	74 0c                	je     dd12 <fwp_args59+0x92>
    dd06:	3c fe                	cmp    $0xfe,%al
    dd08:	0f 83 32 99 ff ff    	jae    7640 <fwp_rc_wide_dup>
    dd0e:	fe c0                	inc    %al
    dd10:	88 07                	mov    %al,(%rdi)
    dd12:	c3                   	ret
    dd13:	66 66 66 66 2e 0f 1f 	data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    dd1a:	84 00 00 00 00 00 

000000000000dd20 <fwp_arg_drop59>:
    dd20:	85 f6                	test   %esi,%esi
    dd22:	75 0c                	jne    dd30 <fwp_arg_drop59+0x10>
    dd24:	85 d2                	test   %edx,%edx
    dd26:	74 08                	je     dd30 <fwp_arg_drop59+0x10>
    dd28:	48 8b 3f             	mov    (%rdi),%rdi
    dd2b:	e9 a0 c5 ff ff       	jmp    a2d0 <fwp_drop6>
    dd30:	c3                   	ret
    dd31:	66 66 66 66 66 66 2e 	data16 data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    dd38:	0f 1f 84 00 00 00 00 
    dd3f:	00 

000000000000dd40 <fwp_gc_find_data>:
    dd40:	0f b7 77 18          	movzwl 0x18(%rdi),%esi
    dd44:	48 85 f6             	test   %rsi,%rsi
    dd47:	0f 84 be 00 00 00    	je     de0b <fwp_gc_find_data+0xcb>
    dd4d:	53                   	push   %rbx
    dd4e:	48 8b 07             	mov    (%rdi),%rax
    dd51:	4c 8b 47 10          	mov    0x10(%rdi),%r8
    dd55:	48 6b ce 38          	imul   $0x38,%rsi,%rcx
    dd59:	45 31 c9             	xor    %r9d,%r9d
    dd5c:	48 8d 15 1d 44 00 00 	lea    0x441d(%rip),%rdx        # 12180 <fwp_gc>
    dd63:	41 bb 01 00 00 00    	mov    $0x1,%r11d
    dd69:	45 31 d2             	xor    %r10d,%r10d
    dd6c:	eb 0b                	jmp    dd79 <fwp_gc_find_data+0x39>
    dd6e:	66 90                	xchg   %ax,%ax
    dd70:	49 83 c1 38          	add    $0x38,%r9
    dd74:	4c 39 c9             	cmp    %r9,%rcx
    dd77:	74 22                	je     dd9b <fwp_gc_find_data+0x5b>
    dd79:	43 83 3c 08 01       	cmpl   $0x1,(%r8,%r9,1)
    dd7e:	75 f0                	jne    dd70 <fwp_gc_find_data+0x30>
    dd80:	4b 8b 5c 08 10       	mov    0x10(%r8,%r9,1),%rbx
    dd85:	48 01 c3             	add    %rax,%rbx
    dd88:	48 39 d3             	cmp    %rdx,%rbx
    dd8b:	77 e3                	ja     dd70 <fwp_gc_find_data+0x30>
    dd8d:	4b 03 5c 08 28       	add    0x28(%r8,%r9,1),%rbx
    dd92:	48 39 d3             	cmp    %rdx,%rbx
    dd95:	45 0f 47 d3          	cmova  %r11d,%r10d
    dd99:	eb d5                	jmp    dd70 <fwp_gc_find_data+0x30>
    dd9b:	31 c0                	xor    %eax,%eax
    dd9d:	45 85 d2             	test   %r10d,%r10d
    dda0:	0f 95 c0             	setne  %al
    dda3:	74 6e                	je     de13 <fwp_gc_find_data+0xd3>
    dda5:	66 85 f6             	test   %si,%si
    dda8:	74 69                	je     de13 <fwp_gc_find_data+0xd3>
    ddaa:	8b 05 60 55 00 00    	mov    0x5560(%rip),%eax        # 13310 <fwp_gc+0x1190>
    ddb0:	48 8b 77 10          	mov    0x10(%rdi),%rsi
    ddb4:	45 31 c0             	xor    %r8d,%r8d
    ddb7:	eb 10                	jmp    ddc9 <fwp_gc_find_data+0x89>
    ddb9:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)
    ddc0:	49 83 c0 38          	add    $0x38,%r8
    ddc4:	4c 39 c1             	cmp    %r8,%rcx
    ddc7:	74 45                	je     de0e <fwp_gc_find_data+0xce>
    ddc9:	42 83 3c 06 01       	cmpl   $0x1,(%rsi,%r8,1)
    ddce:	75 f0                	jne    ddc0 <fwp_gc_find_data+0x80>
    ddd0:	42 f6 44 06 04 02    	testb  $0x2,0x4(%rsi,%r8,1)
    ddd6:	74 e8                	je     ddc0 <fwp_gc_find_data+0x80>
    ddd8:	83 f8 10             	cmp    $0x10,%eax
    dddb:	74 31                	je     de0e <fwp_gc_find_data+0xce>
    dddd:	4e 8b 4c 06 10       	mov    0x10(%rsi,%r8,1),%r9
    dde2:	4c 03 0f             	add    (%rdi),%r9
    dde5:	4c 63 d0             	movslq %eax,%r10
    dde8:	49 c1 e2 04          	shl    $0x4,%r10
    ddec:	4d 89 8c 12 90 10 00 	mov    %r9,0x1090(%r10,%rdx,1)
    ddf3:	00 
    ddf4:	4e 8b 4c 06 28       	mov    0x28(%rsi,%r8,1),%r9
    ddf9:	4d 89 8c 12 98 10 00 	mov    %r9,0x1098(%r10,%rdx,1)
    de00:	00 
    de01:	ff c0                	inc    %eax
    de03:	89 05 07 55 00 00    	mov    %eax,0x5507(%rip)        # 13310 <fwp_gc+0x1190>
    de09:	eb b5                	jmp    ddc0 <fwp_gc_find_data+0x80>
    de0b:	31 c0                	xor    %eax,%eax
    de0d:	c3                   	ret
    de0e:	b8 01 00 00 00       	mov    $0x1,%eax
    de13:	5b                   	pop    %rbx
    de14:	c3                   	ret
    de15:	66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
    de1c:	00 00 00 00 

000000000000de20 <fwp_gc_report>:
    de20:	55                   	push   %rbp
    de21:	41 57                	push   %r15
    de23:	41 56                	push   %r14
    de25:	41 55                	push   %r13
    de27:	41 54                	push   %r12
    de29:	53                   	push   %rbx
    de2a:	48 81 ec 58 01 00 00 	sub    $0x158,%rsp
    de31:	48 8b 05 58 55 00 00 	mov    0x5558(%rip),%rax        # 13390 <fwp_gc+0x1210>
    de38:	48 8b 0d 41 43 00 00 	mov    0x4341(%rip),%rcx        # 12180 <fwp_gc>
    de3f:	48 29 c8             	sub    %rcx,%rax
    de42:	f2 48 0f 2a c0       	cvtsi2sd %rax,%xmm0
    de47:	f2 0f 58 05 19 55 00 	addsd  0x5519(%rip),%xmm0        # 13368 <fwp_gc+0x11e8>
    de4e:	00 
    de4f:	f2 0f 11 44 24 48    	movsd  %xmm0,0x48(%rsp)
    de55:	f2 0f 11 05 0b 55 00 	movsd  %xmm0,0x550b(%rip)        # 13368 <fwp_gc+0x11e8>
    de5c:	00 
    de5d:	48 89 0d 2c 55 00 00 	mov    %rcx,0x552c(%rip)        # 13390 <fwp_gc+0x1210>
    de64:	48 8b 05 75 41 00 00 	mov    0x4175(%rip),%rax        # 11fe0 <stderr@GLIBC_2.2.5>
    de6b:	48 8b 28             	mov    (%rax),%rbp
    de6e:	48 8b 1d e3 54 00 00 	mov    0x54e3(%rip),%rbx        # 13358 <fwp_gc+0x11d8>
    de75:	4c 8b 3d 1c 53 00 00 	mov    0x531c(%rip),%r15        # 13198 <fwp_gc+0x1018>
    de7c:	f2 0f 10 05 04 55 00 	movsd  0x5504(%rip),%xmm0        # 13388 <fwp_gc+0x1208>
    de83:	00 
    de84:	f2 0f 11 44 24 30    	movsd  %xmm0,0x30(%rsp)
    de8a:	48 8b 05 37 53 00 00 	mov    0x5337(%rip),%rax        # 131c8 <fwp_gc+0x1048>
    de91:	48 89 44 24 28       	mov    %rax,0x28(%rsp)
    de96:	48 8b 05 ab 54 00 00 	mov    0x54ab(%rip),%rax        # 13348 <fwp_gc+0x11c8>
    de9d:	48 89 44 24 20       	mov    %rax,0x20(%rsp)
    dea2:	4c 8b 35 a7 54 00 00 	mov    0x54a7(%rip),%r14        # 13350 <fwp_gc+0x11d0>
    dea9:	f2 0f 10 05 bf 54 00 	movsd  0x54bf(%rip),%xmm0        # 13370 <fwp_gc+0x11f0>
    deb0:	00 
    deb1:	f2 0f 11 44 24 40    	movsd  %xmm0,0x40(%rsp)
    deb7:	f2 0f 10 05 b9 54 00 	movsd  0x54b9(%rip),%xmm0        # 13378 <fwp_gc+0x11f8>
    debe:	00 
    debf:	f2 0f 11 44 24 38    	movsd  %xmm0,0x38(%rsp)
    dec5:	48 8d 3d 2b 19 00 00 	lea    0x192b(%rip),%rdi        # f7f7 <fwp_segv.msg+0x5b7>
    decc:	48 8d 35 9e 17 00 00 	lea    0x179e(%rip),%rsi        # f671 <fwp_segv.msg+0x431>
    ded3:	e8 78 43 ff ff       	call   2250 <fopen@plt>
    ded8:	49 c7 c4 ff ff ff ff 	mov    $0xffffffffffffffff,%r12
    dedf:	48 85 c0             	test   %rax,%rax
    dee2:	74 4b                	je     df2f <fwp_gc_report+0x10f>
    dee4:	49 89 c5             	mov    %rax,%r13
    dee7:	48 89 6c 24 08       	mov    %rbp,0x8(%rsp)
    deec:	4c 89 7c 24 10       	mov    %r15,0x10(%rsp)
    def1:	48 89 5c 24 18       	mov    %rbx,0x18(%rsp)
    def6:	48 8d 7c 24 50       	lea    0x50(%rsp),%rdi
    defb:	be 00 01 00 00       	mov    $0x100,%esi
    df00:	48 89 c2             	mov    %rax,%rdx
    df03:	e8 58 42 ff ff       	call   2160 <fgets@plt>
    df08:	49 c7 c4 ff ff ff ff 	mov    $0xffffffffffffffff,%r12
    df0f:	48 85 c0             	test   %rax,%rax
    df12:	0f 85 f1 00 00 00    	jne    e009 <fwp_gc_report+0x1e9>
    df18:	4c 89 ef             	mov    %r13,%rdi
    df1b:	e8 b0 41 ff ff       	call   20d0 <fclose@plt>
    df20:	48 8b 5c 24 18       	mov    0x18(%rsp),%rbx
    df25:	4c 8b 7c 24 10       	mov    0x10(%rsp),%r15
    df2a:	48 8b 6c 24 08       	mov    0x8(%rsp),%rbp
    df2f:	66 49 0f 6e c6       	movq   %r14,%xmm0
    df34:	66 0f 6f 0d c4 11 00 	movdqa 0x11c4(%rip),%xmm1        # f100 <_IO_stdin_used+0x100>
    df3b:	00 
    df3c:	66 0f 62 c1          	punpckldq %xmm1,%xmm0
    df40:	66 0f 28 15 c8 11 00 	movapd 0x11c8(%rip),%xmm2        # f110 <_IO_stdin_used+0x110>
    df47:	00 
    df48:	66 0f 5c c2          	subpd  %xmm2,%xmm0
    df4c:	66 0f 28 e0          	movapd %xmm0,%xmm4
    df50:	66 0f 15 e0          	unpckhpd %xmm0,%xmm4
    df54:	f2 0f 58 e0          	addsd  %xmm0,%xmm4
    df58:	f2 0f 10 35 c8 10 00 	movsd  0x10c8(%rip),%xmm6        # f028 <_IO_stdin_used+0x28>
    df5f:	00 
    df60:	f2 0f 59 e6          	mulsd  %xmm6,%xmm4
    df64:	f3 0f 7e 6c 24 20    	movq   0x20(%rsp),%xmm5
    df6a:	66 0f 62 e9          	punpckldq %xmm1,%xmm5
    df6e:	66 0f 5c ea          	subpd  %xmm2,%xmm5
    df72:	66 0f 28 dd          	movapd %xmm5,%xmm3
    df76:	66 0f 15 dd          	unpckhpd %xmm5,%xmm3
    df7a:	f2 0f 58 dd          	addsd  %xmm5,%xmm3
    df7e:	f2 0f 59 de          	mulsd  %xmm6,%xmm3
    df82:	f3 0f 7e 6c 24 28    	movq   0x28(%rsp),%xmm5
    df88:	66 0f 62 e9          	punpckldq %xmm1,%xmm5
    df8c:	66 0f 5c ea          	subpd  %xmm2,%xmm5
    df90:	66 0f 28 d5          	movapd %xmm5,%xmm2
    df94:	66 0f 15 d5          	unpckhpd %xmm5,%xmm2
    df98:	f2 0f 58 d5          	addsd  %xmm5,%xmm2
    df9c:	f2 0f 59 d6          	mulsd  %xmm6,%xmm2
    dfa0:	f2 0f 10 44 24 48    	movsd  0x48(%rsp),%xmm0
    dfa6:	f2 0f 10 4c 24 30    	movsd  0x30(%rsp),%xmm1
    dfac:	f2 0f 58 c1          	addsd  %xmm1,%xmm0
    dfb0:	f2 0f 59 ce          	mulsd  %xmm6,%xmm1
    dfb4:	f2 0f 59 c6          	mulsd  %xmm6,%xmm0
    dfb8:	83 3d b5 51 00 00 00 	cmpl   $0x0,0x51b5(%rip)        # 13174 <fwp_gc+0xff4>
    dfbf:	48 8d 05 1f 18 00 00 	lea    0x181f(%rip),%rax        # f7e5 <fwp_segv.msg+0x5a5>
    dfc6:	4c 8d 0d 62 17 00 00 	lea    0x1762(%rip),%r9        # f72f <fwp_segv.msg+0x4ef>
    dfcd:	4c 0f 44 c8          	cmove  %rax,%r9
    dfd1:	48 8d 35 58 17 00 00 	lea    0x1758(%rip),%rsi        # f730 <fwp_segv.msg+0x4f0>
    dfd8:	48 89 ef             	mov    %rbp,%rdi
    dfdb:	48 89 da             	mov    %rbx,%rdx
    dfde:	4c 89 f9             	mov    %r15,%rcx
    dfe1:	f2 0f 10 6c 24 40    	movsd  0x40(%rsp),%xmm5
    dfe7:	f2 0f 10 74 24 38    	movsd  0x38(%rsp),%xmm6
    dfed:	4d 89 e0             	mov    %r12,%r8
    dff0:	b0 07                	mov    $0x7,%al
    dff2:	e8 b9 41 ff ff       	call   21b0 <fprintf@plt>
    dff7:	48 81 c4 58 01 00 00 	add    $0x158,%rsp
    dffe:	5b                   	pop    %rbx
    dfff:	41 5c                	pop    %r12
    e001:	41 5d                	pop    %r13
    e003:	41 5e                	pop    %r14
    e005:	41 5f                	pop    %r15
    e007:	5d                   	pop    %rbp
    e008:	c3                   	ret
    e009:	48 8d 6c 24 56       	lea    0x56(%rsp),%rbp
    e00e:	41 bf 56 6d 48 57    	mov    $0x57486d56,%r15d
    e014:	48 8d 5c 24 50       	lea    0x50(%rsp),%rbx
    e019:	eb 1e                	jmp    e039 <fwp_gc_report+0x219>
    e01b:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)
    e020:	48 89 df             	mov    %rbx,%rdi
    e023:	be 00 01 00 00       	mov    $0x100,%esi
    e028:	4c 89 ea             	mov    %r13,%rdx
    e02b:	e8 30 41 ff ff       	call   2160 <fgets@plt>
    e030:	48 85 c0             	test   %rax,%rax
    e033:	0f 84 df fe ff ff    	je     df18 <fwp_gc_report+0xf8>
    e039:	8b 44 24 50          	mov    0x50(%rsp),%eax
    e03d:	44 31 f8             	xor    %r15d,%eax
    e040:	0f b6 4c 24 54       	movzbl 0x54(%rsp),%ecx
    e045:	83 f1 4d             	xor    $0x4d,%ecx
    e048:	09 c1                	or     %eax,%ecx
    e04a:	75 d4                	jne    e020 <fwp_gc_report+0x200>
    e04c:	80 7c 24 55 3a       	cmpb   $0x3a,0x55(%rsp)
    e051:	75 cd                	jne    e020 <fwp_gc_report+0x200>
    e053:	48 89 ef             	mov    %rbp,%rdi
    e056:	31 f6                	xor    %esi,%esi
    e058:	ba 0a 00 00 00       	mov    $0xa,%edx
    e05d:	e8 6e 41 ff ff       	call   21d0 <strtol@plt>
    e062:	49 89 c4             	mov    %rax,%r12
    e065:	eb b9                	jmp    e020 <fwp_gc_report+0x200>
    e067:	66 0f 1f 84 00 00 00 	nopw   0x0(%rax,%rax,1)
    e06e:	00 00 

000000000000e070 <fwp_segv>:
    e070:	48 8b 05 81 5b 00 00 	mov    0x5b81(%rip),%rax        # 13bf8 <fwp_main_stack_top>
    e077:	48 85 c0             	test   %rax,%rax
    e07a:	74 22                	je     e09e <fwp_segv+0x2e>
    e07c:	48 8b 4e 10          	mov    0x10(%rsi),%rcx
    e080:	48 2b 05 79 5b 00 00 	sub    0x5b79(%rip),%rax        # 13c00 <fwp_main_stack_size>
    e087:	48 8d 90 00 00 f0 ff 	lea    -0x100000(%rax),%rdx
    e08e:	48 39 ca             	cmp    %rcx,%rdx
    e091:	77 0b                	ja     e09e <fwp_segv+0x2e>
    e093:	48 05 00 00 10 00    	add    $0x100000,%rax
    e099:	48 39 c8             	cmp    %rcx,%rax
    e09c:	77 07                	ja     e0a5 <fwp_segv+0x35>
    e09e:	31 f6                	xor    %esi,%esi
    e0a0:	e9 eb 40 ff ff       	jmp    2190 <signal@plt>
    e0a5:	50                   	push   %rax
    e0a6:	e8 85 82 ff ff       	call   6330 <fwp_flush>
    e0ab:	48 8d 35 8e 11 00 00 	lea    0x118e(%rip),%rsi        # f240 <fwp_segv.msg>
    e0b2:	ba 1a 00 00 00       	mov    $0x1a,%edx
    e0b7:	bf 02 00 00 00       	mov    $0x2,%edi
    e0bc:	e8 ff 3f ff ff       	call   20c0 <write@plt>
    e0c1:	bf 65 00 00 00       	mov    $0x65,%edi
    e0c6:	e8 a5 3f ff ff       	call   2070 <_exit@plt>
    e0cb:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)

000000000000e0d0 <fwp_drop0>:
    e0d0:	53                   	push   %rbx
    e0d1:	48 89 f8             	mov    %rdi,%rax
    e0d4:	48 2b 05 d5 50 00 00 	sub    0x50d5(%rip),%rax        # 131b0 <fwp_gc+0x1030>
    e0db:	48 8b 0d f6 50 00 00 	mov    0x50f6(%rip),%rcx        # 131d8 <fwp_gc+0x1058>
    e0e2:	48 c1 e1 10          	shl    $0x10,%rcx
    e0e6:	48 39 c8             	cmp    %rcx,%rax
    e0e9:	0f 83 96 00 00 00    	jae    e185 <fwp_drop0+0xb5>
    e0ef:	48 8b 0d 02 51 00 00 	mov    0x5102(%rip),%rcx        # 131f8 <fwp_gc+0x1078>
    e0f6:	48 89 c2             	mov    %rax,%rdx
    e0f9:	48 c1 ea 10          	shr    $0x10,%rdx
    e0fd:	48 69 d2 28 12 00 00 	imul   $0x1228,%rdx,%rdx
    e104:	0f b6 34 11          	movzbl (%rcx,%rdx,1),%esi
    e108:	48 25 ff ff 00 00    	and    $0xffff,%rax
    e10e:	75 20                	jne    e130 <fwp_drop0+0x60>
    e110:	40 80 fe 02          	cmp    $0x2,%sil
    e114:	75 1a                	jne    e130 <fwp_drop0+0x60>
    e116:	48 8d 04 11          	lea    (%rcx,%rdx,1),%rax
    e11a:	48 05 28 02 00 00    	add    $0x228,%rax
    e120:	eb 2d                	jmp    e14f <fwp_drop0+0x7f>
    e122:	66 66 66 66 66 2e 0f 	data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    e129:	1f 84 00 00 00 00 00 
    e130:	40 80 fe 01          	cmp    $0x1,%sil
    e134:	75 4f                	jne    e185 <fwp_drop0+0xb5>
    e136:	48 8d 34 11          	lea    (%rcx,%rdx,1),%rsi
    e13a:	8b 4c 11 20          	mov    0x20(%rcx,%rdx,1),%ecx
    e13e:	48 0f af c1          	imul   %rcx,%rax
    e142:	48 c1 e8 20          	shr    $0x20,%rax
    e146:	48 01 f0             	add    %rsi,%rax
    e149:	48 05 28 02 00 00    	add    $0x228,%rax
    e14f:	0f b6 08             	movzbl (%rax),%ecx
    e152:	85 c9                	test   %ecx,%ecx
    e154:	74 2f                	je     e185 <fwp_drop0+0xb5>
    e156:	83 f9 01             	cmp    $0x1,%ecx
    e159:	75 2c                	jne    e187 <fwp_drop0+0xb7>
    e15b:	48 8b 5f 10          	mov    0x10(%rdi),%rbx
    e15f:	e8 0c c8 ff ff       	call   a970 <fwp_rc_free_obj>
    e164:	48 89 d8             	mov    %rbx,%rax
    e167:	48 2b 05 42 50 00 00 	sub    0x5042(%rip),%rax        # 131b0 <fwp_gc+0x1030>
    e16e:	48 8b 0d 63 50 00 00 	mov    0x5063(%rip),%rcx        # 131d8 <fwp_gc+0x1058>
    e175:	48 c1 e1 10          	shl    $0x10,%rcx
    e179:	48 89 df             	mov    %rbx,%rdi
    e17c:	48 39 c8             	cmp    %rcx,%rax
    e17f:	0f 82 6a ff ff ff    	jb     e0ef <fwp_drop0+0x1f>
    e185:	5b                   	pop    %rbx
    e186:	c3                   	ret
    e187:	81 f9 ff 00 00 00    	cmp    $0xff,%ecx
    e18d:	74 06                	je     e195 <fwp_drop0+0xc5>
    e18f:	fe c9                	dec    %cl
    e191:	88 08                	mov    %cl,(%rax)
    e193:	5b                   	pop    %rbx
    e194:	c3                   	ret
    e195:	48 89 c7             	mov    %rax,%rdi
    e198:	5b                   	pop    %rbx
    e199:	e9 f2 c4 ff ff       	jmp    a690 <fwp_rc_wide_drop>
    e19e:	66 90                	xchg   %ax,%ax

000000000000e1a0 <fwp_drop4>:
    e1a0:	53                   	push   %rbx
    e1a1:	48 89 f8             	mov    %rdi,%rax
    e1a4:	48 2b 05 05 50 00 00 	sub    0x5005(%rip),%rax        # 131b0 <fwp_gc+0x1030>
    e1ab:	48 8b 0d 26 50 00 00 	mov    0x5026(%rip),%rcx        # 131d8 <fwp_gc+0x1058>
    e1b2:	48 c1 e1 10          	shl    $0x10,%rcx
    e1b6:	48 39 c8             	cmp    %rcx,%rax
    e1b9:	0f 83 96 00 00 00    	jae    e255 <fwp_drop4+0xb5>
    e1bf:	48 8b 0d 32 50 00 00 	mov    0x5032(%rip),%rcx        # 131f8 <fwp_gc+0x1078>
    e1c6:	48 89 c2             	mov    %rax,%rdx
    e1c9:	48 c1 ea 10          	shr    $0x10,%rdx
    e1cd:	48 69 d2 28 12 00 00 	imul   $0x1228,%rdx,%rdx
    e1d4:	0f b6 34 11          	movzbl (%rcx,%rdx,1),%esi
    e1d8:	48 25 ff ff 00 00    	and    $0xffff,%rax
    e1de:	75 20                	jne    e200 <fwp_drop4+0x60>
    e1e0:	40 80 fe 02          	cmp    $0x2,%sil
    e1e4:	75 1a                	jne    e200 <fwp_drop4+0x60>
    e1e6:	48 8d 04 11          	lea    (%rcx,%rdx,1),%rax
    e1ea:	48 05 28 02 00 00    	add    $0x228,%rax
    e1f0:	eb 2d                	jmp    e21f <fwp_drop4+0x7f>
    e1f2:	66 66 66 66 66 2e 0f 	data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    e1f9:	1f 84 00 00 00 00 00 
    e200:	40 80 fe 01          	cmp    $0x1,%sil
    e204:	75 4f                	jne    e255 <fwp_drop4+0xb5>
    e206:	48 8d 34 11          	lea    (%rcx,%rdx,1),%rsi
    e20a:	8b 4c 11 20          	mov    0x20(%rcx,%rdx,1),%ecx
    e20e:	48 0f af c1          	imul   %rcx,%rax
    e212:	48 c1 e8 20          	shr    $0x20,%rax
    e216:	48 01 f0             	add    %rsi,%rax
    e219:	48 05 28 02 00 00    	add    $0x228,%rax
    e21f:	0f b6 08             	movzbl (%rax),%ecx
    e222:	85 c9                	test   %ecx,%ecx
    e224:	74 2f                	je     e255 <fwp_drop4+0xb5>
    e226:	83 f9 01             	cmp    $0x1,%ecx
    e229:	75 2c                	jne    e257 <fwp_drop4+0xb7>
    e22b:	48 8b 5f 10          	mov    0x10(%rdi),%rbx
    e22f:	e8 3c c7 ff ff       	call   a970 <fwp_rc_free_obj>
    e234:	48 89 d8             	mov    %rbx,%rax
    e237:	48 2b 05 72 4f 00 00 	sub    0x4f72(%rip),%rax        # 131b0 <fwp_gc+0x1030>
    e23e:	48 8b 0d 93 4f 00 00 	mov    0x4f93(%rip),%rcx        # 131d8 <fwp_gc+0x1058>
    e245:	48 c1 e1 10          	shl    $0x10,%rcx
    e249:	48 89 df             	mov    %rbx,%rdi
    e24c:	48 39 c8             	cmp    %rcx,%rax
    e24f:	0f 82 6a ff ff ff    	jb     e1bf <fwp_drop4+0x1f>
    e255:	5b                   	pop    %rbx
    e256:	c3                   	ret
    e257:	81 f9 ff 00 00 00    	cmp    $0xff,%ecx
    e25d:	74 06                	je     e265 <fwp_drop4+0xc5>
    e25f:	fe c9                	dec    %cl
    e261:	88 08                	mov    %cl,(%rax)
    e263:	5b                   	pop    %rbx
    e264:	c3                   	ret
    e265:	48 89 c7             	mov    %rax,%rdi
    e268:	5b                   	pop    %rbx
    e269:	e9 22 c4 ff ff       	jmp    a690 <fwp_rc_wide_drop>
    e26e:	66 90                	xchg   %ax,%ax

000000000000e270 <__divti3>:
    e270:	f3 0f 1e fa          	endbr64
    e274:	55                   	push   %rbp
    e275:	49 89 f8             	mov    %rdi,%r8
    e278:	49 89 d2             	mov    %rdx,%r10
    e27b:	49 89 cb             	mov    %rcx,%r11
    e27e:	31 ff                	xor    %edi,%edi
    e280:	48 89 e5             	mov    %rsp,%rbp
    e283:	41 56                	push   %r14
    e285:	53                   	push   %rbx
    e286:	48 85 f6             	test   %rsi,%rsi
    e289:	79 13                	jns    e29e <__divti3+0x2e>
    e28b:	45 31 c9             	xor    %r9d,%r9d
    e28e:	49 f7 d8             	neg    %r8
    e291:	48 c7 c7 ff ff ff ff 	mov    $0xffffffffffffffff,%rdi
    e298:	49 19 f1             	sbb    %rsi,%r9
    e29b:	4c 89 ce             	mov    %r9,%rsi
    e29e:	4c 89 da             	mov    %r11,%rdx
    e2a1:	4d 85 db             	test   %r11,%r11
    e2a4:	0f 88 f6 00 00 00    	js     e3a0 <__divti3+0x130>
    e2aa:	4d 89 d6             	mov    %r10,%r14
    e2ad:	75 31                	jne    e2e0 <__divti3+0x70>
    e2af:	4c 39 f6             	cmp    %r14,%rsi
    e2b2:	0f 83 b8 00 00 00    	jae    e370 <__divti3+0x100>
    e2b8:	48 89 f2             	mov    %rsi,%rdx
    e2bb:	31 f6                	xor    %esi,%esi
    e2bd:	4c 89 c0             	mov    %r8,%rax
    e2c0:	49 f7 f6             	div    %r14
    e2c3:	48 89 f2             	mov    %rsi,%rdx
    e2c6:	48 85 ff             	test   %rdi,%rdi
    e2c9:	74 0a                	je     e2d5 <__divti3+0x65>
    e2cb:	48 f7 d8             	neg    %rax
    e2ce:	48 83 d2 00          	adc    $0x0,%rdx
    e2d2:	48 f7 da             	neg    %rdx
    e2d5:	5b                   	pop    %rbx
    e2d6:	41 5e                	pop    %r14
    e2d8:	5d                   	pop    %rbp
    e2d9:	c3                   	ret
    e2da:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)
    e2e0:	4c 39 de             	cmp    %r11,%rsi
    e2e3:	0f 82 d5 00 00 00    	jb     e3be <__divti3+0x14e>
    e2e9:	4d 0f bd d3          	bsr    %r11,%r10
    e2ed:	41 83 f2 3f          	xor    $0x3f,%r10d
    e2f1:	44 89 d1             	mov    %r10d,%ecx
    e2f4:	b8 40 00 00 00       	mov    $0x40,%eax
    e2f9:	4c 89 f3             	mov    %r14,%rbx
    e2fc:	4d 89 f1             	mov    %r14,%r9
    e2ff:	48 d3 e2             	shl    %cl,%rdx
    e302:	49 63 ca             	movslq %r10d,%rcx
    e305:	49 89 f3             	mov    %rsi,%r11
    e308:	48 29 c8             	sub    %rcx,%rax
    e30b:	89 c1                	mov    %eax,%ecx
    e30d:	48 d3 eb             	shr    %cl,%rbx
    e310:	44 89 d1             	mov    %r10d,%ecx
    e313:	49 d3 e1             	shl    %cl,%r9
    e316:	89 c1                	mov    %eax,%ecx
    e318:	48 09 d3             	or     %rdx,%rbx
    e31b:	4c 89 c2             	mov    %r8,%rdx
    e31e:	49 d3 eb             	shr    %cl,%r11
    e321:	44 89 d1             	mov    %r10d,%ecx
    e324:	48 d3 e6             	shl    %cl,%rsi
    e327:	89 c1                	mov    %eax,%ecx
    e329:	48 d3 ea             	shr    %cl,%rdx
    e32c:	48 89 d0             	mov    %rdx,%rax
    e32f:	4c 89 da             	mov    %r11,%rdx
    e332:	48 09 f0             	or     %rsi,%rax
    e335:	48 f7 f3             	div    %rbx
    e338:	49 89 d3             	mov    %rdx,%r11
    e33b:	48 89 c6             	mov    %rax,%rsi
    e33e:	49 f7 e1             	mul    %r9
    e341:	49 39 d3             	cmp    %rdx,%r11
    e344:	0f 82 be 00 00 00    	jb     e408 <__divti3+0x198>
    e34a:	44 89 d1             	mov    %r10d,%ecx
    e34d:	49 d3 e0             	shl    %cl,%r8
    e350:	49 39 c0             	cmp    %rax,%r8
    e353:	73 09                	jae    e35e <__divti3+0xee>
    e355:	49 39 d3             	cmp    %rdx,%r11
    e358:	0f 84 aa 00 00 00    	je     e408 <__divti3+0x198>
    e35e:	48 89 f0             	mov    %rsi,%rax
    e361:	31 f6                	xor    %esi,%esi
    e363:	e9 5b ff ff ff       	jmp    e2c3 <__divti3+0x53>
    e368:	0f 1f 84 00 00 00 00 	nopl   0x0(%rax,%rax,1)
    e36f:	00 
    e370:	4d 85 f6             	test   %r14,%r14
    e373:	75 0d                	jne    e382 <__divti3+0x112>
    e375:	b8 01 00 00 00       	mov    $0x1,%eax
    e37a:	31 d2                	xor    %edx,%edx
    e37c:	49 f7 f6             	div    %r14
    e37f:	49 89 c6             	mov    %rax,%r14
    e382:	48 89 f0             	mov    %rsi,%rax
    e385:	31 d2                	xor    %edx,%edx
    e387:	49 f7 f6             	div    %r14
    e38a:	48 89 c6             	mov    %rax,%rsi
    e38d:	4c 89 c0             	mov    %r8,%rax
    e390:	49 f7 f6             	div    %r14
    e393:	e9 2b ff ff ff       	jmp    e2c3 <__divti3+0x53>
    e398:	0f 1f 84 00 00 00 00 	nopl   0x0(%rax,%rax,1)
    e39f:	00 
    e3a0:	49 f7 da             	neg    %r10
    e3a3:	48 f7 d7             	not    %rdi
    e3a6:	49 83 d3 00          	adc    $0x0,%r11
    e3aa:	4d 89 d6             	mov    %r10,%r14
    e3ad:	49 f7 db             	neg    %r11
    e3b0:	4c 89 da             	mov    %r11,%rdx
    e3b3:	0f 84 f6 fe ff ff    	je     e2af <__divti3+0x3f>
    e3b9:	4c 39 de             	cmp    %r11,%rsi
    e3bc:	73 12                	jae    e3d0 <__divti3+0x160>
    e3be:	31 f6                	xor    %esi,%esi
    e3c0:	31 c0                	xor    %eax,%eax
    e3c2:	e9 fc fe ff ff       	jmp    e2c3 <__divti3+0x53>
    e3c7:	66 0f 1f 84 00 00 00 	nopw   0x0(%rax,%rax,1)
    e3ce:	00 00 
    e3d0:	49 0f bd c3          	bsr    %r11,%rax
    e3d4:	48 83 f0 3f          	xor    $0x3f,%rax
    e3d8:	41 89 c2             	mov    %eax,%r10d
    e3db:	85 c0                	test   %eax,%eax
    e3dd:	0f 85 0e ff ff ff    	jne    e2f1 <__divti3+0x81>
    e3e3:	49 39 f3             	cmp    %rsi,%r11
    e3e6:	72 0d                	jb     e3f5 <__divti3+0x185>
    e3e8:	31 f6                	xor    %esi,%esi
    e3ea:	31 c0                	xor    %eax,%eax
    e3ec:	4d 39 f0             	cmp    %r14,%r8
    e3ef:	0f 82 ce fe ff ff    	jb     e2c3 <__divti3+0x53>
    e3f5:	31 f6                	xor    %esi,%esi
    e3f7:	b8 01 00 00 00       	mov    $0x1,%eax
    e3fc:	e9 c2 fe ff ff       	jmp    e2c3 <__divti3+0x53>
    e401:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)
    e408:	48 8d 46 ff          	lea    -0x1(%rsi),%rax
    e40c:	31 f6                	xor    %esi,%esi
    e40e:	e9 b0 fe ff ff       	jmp    e2c3 <__divti3+0x53>
    e413:	66 2e 0f 1f 84 00 00 	cs nopw 0x0(%rax,%rax,1)
    e41a:	00 00 00 
    e41d:	0f 1f 00             	nopl   (%rax)

000000000000e420 <atexit>:
    e420:	f3 0f 1e fa          	endbr64
    e424:	48 8b 15 45 3d 00 00 	mov    0x3d45(%rip),%rdx        # 12170 <__dso_handle>
    e42b:	31 f6                	xor    %esi,%esi
    e42d:	e9 3e 3e ff ff       	jmp    2270 <__cxa_atexit@plt>

Disassembly of section .fini:

000000000000e434 <_fini>:
    e434:	f3 0f 1e fa          	endbr64
    e438:	48 83 ec 08          	sub    $0x8,%rsp
    e43c:	48 83 c4 08          	add    $0x8,%rsp
    e440:	c3                   	ret
