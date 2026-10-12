
/tmp/fwp-arc-4399/arrays-1-dynamic-O2:     file format elf64-x86-64


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
    255d:	48 81 ec c8 01 00 00 	sub    $0x1c8,%rsp
    2564:	83 3d 01 0c 01 00 00 	cmpl   $0x0,0x10c01(%rip)        # 1316c <fwp_gc+0xfec>
    256b:	75 05                	jne    2572 <fwp_main_thread+0x22>
    256d:	e8 ce 42 00 00       	call   6840 <fwp_gc_init>
    2572:	48 89 2d 8f 0c 01 00 	mov    %rbp,0x10c8f(%rip)        # 13208 <fwp_gc+0x1088>
    2579:	48 8d 3d f0 b6 00 00 	lea    0xb6f0(%rip),%rdi        # dc70 <fwp_gc_find_data>
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
    25af:	48 8d 3d 9a b7 00 00 	lea    0xb79a(%rip),%rdi        # dd50 <fwp_gc_report>
    25b6:	e8 95 bd 00 00       	call   e350 <atexit>
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
    2652:	48 8d bd 18 fe ff ff 	lea    -0x1e8(%rbp),%rdi
    2659:	66 0f 57 c0          	xorpd  %xmm0,%xmm0
    265d:	66 0f 11 85 98 fe ff 	movupd %xmm0,-0x168(%rbp)
    2664:	ff 
    2665:	66 0f 11 85 88 fe ff 	movupd %xmm0,-0x178(%rbp)
    266c:	ff 
    266d:	66 0f 11 85 78 fe ff 	movupd %xmm0,-0x188(%rbp)
    2674:	ff 
    2675:	66 0f 11 85 68 fe ff 	movupd %xmm0,-0x198(%rbp)
    267c:	ff 
    267d:	66 0f 11 85 58 fe ff 	movupd %xmm0,-0x1a8(%rbp)
    2684:	ff 
    2685:	66 0f 11 85 48 fe ff 	movupd %xmm0,-0x1b8(%rbp)
    268c:	ff 
    268d:	66 0f 11 85 38 fe ff 	movupd %xmm0,-0x1c8(%rbp)
    2694:	ff 
    2695:	66 0f 11 85 28 fe ff 	movupd %xmm0,-0x1d8(%rbp)
    269c:	ff 
    269d:	66 0f 11 85 18 fe ff 	movupd %xmm0,-0x1e8(%rbp)
    26a4:	ff 
    26a5:	48 8d 05 f4 b8 00 00 	lea    0xb8f4(%rip),%rax        # dfa0 <fwp_segv>
    26ac:	48 89 85 10 fe ff ff 	mov    %rax,-0x1f0(%rbp)
    26b3:	c7 85 98 fe ff ff 04 	movl   $0x8000004,-0x168(%rbp)
    26ba:	00 00 08 
    26bd:	e8 fe fa ff ff       	call   21c0 <sigemptyset@plt>
    26c2:	48 8d 9d 10 fe ff ff 	lea    -0x1f0(%rbp),%rbx
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
    26f8:	0f 85 a8 18 00 00    	jne    3fa6 <fwp_main_thread+0x1a56>
    26fe:	48 89 55 b0          	mov    %rdx,-0x50(%rbp)
    2702:	48 b8 00 00 00 00 00 	movabs $0xc000000000000000,%rax
    2709:	00 00 c0 
    270c:	48 89 45 b8          	mov    %rax,-0x48(%rbp)
    2710:	48 c7 45 c0 00 00 00 	movq   $0x0,-0x40(%rbp)
    2717:	00 
    2718:	48 8d 55 b8          	lea    -0x48(%rbp),%rdx
    271c:	bf 01 00 00 00       	mov    $0x1,%edi
    2721:	be 02 00 00 00       	mov    $0x2,%esi
    2726:	e8 35 76 00 00       	call   9d60 <fwp_data>
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
    27b1:	e8 da 3a 00 00       	call   6290 <fwp_rc_forget_slot>
    27b6:	48 89 d8             	mov    %rbx,%rax
    27b9:	eb c3                	jmp    277e <fwp_main_thread+0x22e>
    27bb:	48 b9 00 00 00 00 00 	movabs $0x3fd0000000000000,%rcx
    27c2:	00 d0 3f 
    27c5:	48 89 4d a0          	mov    %rcx,-0x60(%rbp)
    27c9:	48 89 45 a8          	mov    %rax,-0x58(%rbp)
    27cd:	48 8d 55 a0          	lea    -0x60(%rbp),%rdx
    27d1:	bf 01 00 00 00       	mov    $0x1,%edi
    27d6:	be 02 00 00 00       	mov    $0x2,%esi
    27db:	e8 80 75 00 00       	call   9d60 <fwp_data>
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
    2866:	e8 25 3a 00 00       	call   6290 <fwp_rc_forget_slot>
    286b:	48 89 d8             	mov    %rbx,%rax
    286e:	eb c3                	jmp    2833 <fwp_main_thread+0x2e3>
    2870:	48 b9 ff ff ff ff ff 	movabs $0x7fffffffffffffff,%rcx
    2877:	ff ff 7f 
    287a:	4c 8d 69 01          	lea    0x1(%rcx),%r13
    287e:	4c 89 ad b0 fe ff ff 	mov    %r13,-0x150(%rbp)
    2885:	48 89 85 b8 fe ff ff 	mov    %rax,-0x148(%rbp)
    288c:	48 8d 95 b0 fe ff ff 	lea    -0x150(%rbp),%rdx
    2893:	bf 01 00 00 00       	mov    $0x1,%edi
    2898:	be 02 00 00 00       	mov    $0x2,%esi
    289d:	e8 be 74 00 00       	call   9d60 <fwp_data>
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
    2928:	e8 63 39 00 00       	call   6290 <fwp_rc_forget_slot>
    292d:	48 89 d8             	mov    %rbx,%rax
    2930:	eb c3                	jmp    28f5 <fwp_main_thread+0x3a5>
    2932:	48 b9 00 00 00 00 00 	movabs $0x3ff8000000000000,%rcx
    2939:	00 f8 3f 
    293c:	48 89 8d c0 fe ff ff 	mov    %rcx,-0x140(%rbp)
    2943:	48 89 85 c8 fe ff ff 	mov    %rax,-0x138(%rbp)
    294a:	48 8d 95 c0 fe ff ff 	lea    -0x140(%rbp),%rdx
    2951:	bf 01 00 00 00       	mov    $0x1,%edi
    2956:	be 02 00 00 00       	mov    $0x2,%esi
    295b:	e8 00 74 00 00       	call   9d60 <fwp_data>
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
    29e2:	e8 a9 38 00 00       	call   6290 <fwp_rc_forget_slot>
    29e7:	eb c9                	jmp    29b2 <fwp_main_thread+0x462>
    29e9:	48 8d 35 60 f2 00 00 	lea    0xf260(%rip),%rsi        # 11c50 <d0>
    29f0:	4c 89 f7             	mov    %r14,%rdi
    29f3:	e8 48 39 00 00       	call   6340 <fwp_p_array_from_list_typed>
    29f8:	49 89 c7             	mov    %rax,%r15
    29fb:	4c 89 f7             	mov    %r14,%rdi
    29fe:	e8 fd b5 00 00       	call   e000 <fwp_drop0>
    2a03:	31 db                	xor    %ebx,%ebx
    2a05:	be 04 00 00 00       	mov    $0x4,%esi
    2a0a:	31 ff                	xor    %edi,%edi
    2a0c:	4c 89 fa             	mov    %r15,%rdx
    2a0f:	e8 1c 48 00 00       	call   7230 <f12>
    2a14:	49 89 c6             	mov    %rax,%r14
    2a17:	4c 89 ff             	mov    %r15,%rdi
    2a1a:	e8 b1 79 00 00       	call   a3d0 <fwp_drop1>
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
    2a73:	e8 58 79 00 00       	call   a3d0 <fwp_drop1>
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
    2ad4:	e8 f7 4b 00 00       	call   76d0 <fwp_show>
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
    2b5b:	e8 30 37 00 00       	call   6290 <fwp_rc_forget_slot>
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
    2c0c:	e8 8f 7c 00 00       	call   a8a0 <fwp_rc_free_obj>
    2c11:	eb 0f                	jmp    2c22 <fwp_main_thread+0x6d2>
    2c13:	3d ff 00 00 00       	cmp    $0xff,%eax
    2c18:	0f 84 f2 13 00 00    	je     4010 <fwp_main_thread+0x1ac0>
    2c1e:	fe c8                	dec    %al
    2c20:	88 07                	mov    %al,(%rdi)
    2c22:	41 bf 00 00 00 80    	mov    $0x80000000,%r15d
    2c28:	49 8d 87 00 00 00 40 	lea    0x40000000(%r15),%rax
    2c2f:	48 89 85 d0 fe ff ff 	mov    %rax,-0x130(%rbp)
    2c36:	48 c7 85 d8 fe ff ff 	movq   $0x0,-0x128(%rbp)
    2c3d:	00 00 00 00 
    2c41:	48 8d 95 d0 fe ff ff 	lea    -0x130(%rbp),%rdx
    2c48:	bf 01 00 00 00       	mov    $0x1,%edi
    2c4d:	be 02 00 00 00       	mov    $0x2,%esi
    2c52:	e8 09 71 00 00       	call   9d60 <fwp_data>
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
    2cdd:	e8 ae 35 00 00       	call   6290 <fwp_rc_forget_slot>
    2ce2:	48 89 d8             	mov    %rbx,%rax
    2ce5:	eb c3                	jmp    2caa <fwp_main_thread+0x75a>
    2ce7:	48 c7 85 e0 fe ff ff 	movq   $0x3e800000,-0x120(%rbp)
    2cee:	00 00 80 3e 
    2cf2:	48 89 85 e8 fe ff ff 	mov    %rax,-0x118(%rbp)
    2cf9:	48 8d 95 e0 fe ff ff 	lea    -0x120(%rbp),%rdx
    2d00:	bf 01 00 00 00       	mov    $0x1,%edi
    2d05:	be 02 00 00 00       	mov    $0x2,%esi
    2d0a:	e8 51 70 00 00       	call   9d60 <fwp_data>
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
    2d95:	e8 f6 34 00 00       	call   6290 <fwp_rc_forget_slot>
    2d9a:	48 89 d8             	mov    %rbx,%rax
    2d9d:	eb c3                	jmp    2d62 <fwp_main_thread+0x812>
    2d9f:	4c 89 bd f0 fe ff ff 	mov    %r15,-0x110(%rbp)
    2da6:	48 89 85 f8 fe ff ff 	mov    %rax,-0x108(%rbp)
    2dad:	48 8d 95 f0 fe ff ff 	lea    -0x110(%rbp),%rdx
    2db4:	bf 01 00 00 00       	mov    $0x1,%edi
    2db9:	be 02 00 00 00       	mov    $0x2,%esi
    2dbe:	e8 9d 6f 00 00       	call   9d60 <fwp_data>
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
    2e49:	e8 42 34 00 00       	call   6290 <fwp_rc_forget_slot>
    2e4e:	48 89 d8             	mov    %rbx,%rax
    2e51:	eb c3                	jmp    2e16 <fwp_main_thread+0x8c6>
    2e53:	48 c7 85 00 ff ff ff 	movq   $0x3fc00000,-0x100(%rbp)
    2e5a:	00 00 c0 3f 
    2e5e:	48 89 85 08 ff ff ff 	mov    %rax,-0xf8(%rbp)
    2e65:	48 8d 95 00 ff ff ff 	lea    -0x100(%rbp),%rdx
    2e6c:	bf 01 00 00 00       	mov    $0x1,%edi
    2e71:	be 02 00 00 00       	mov    $0x2,%esi
    2e76:	e8 e5 6e 00 00       	call   9d60 <fwp_data>
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
    2efd:	e8 8e 33 00 00       	call   6290 <fwp_rc_forget_slot>
    2f02:	eb c9                	jmp    2ecd <fwp_main_thread+0x97d>
    2f04:	48 8d 35 05 ee 00 00 	lea    0xee05(%rip),%rsi        # 11d10 <d2>
    2f0b:	4c 89 ff             	mov    %r15,%rdi
    2f0e:	e8 2d 34 00 00       	call   6340 <fwp_p_array_from_list_typed>
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
    2f9d:	e8 fe 78 00 00       	call   a8a0 <fwp_rc_free_obj>
    2fa2:	48 89 d9             	mov    %rbx,%rcx
    2fa5:	48 2b 0d 04 02 01 00 	sub    0x10204(%rip),%rcx        # 131b0 <fwp_gc+0x1030>
    2fac:	48 8b 05 25 02 01 00 	mov    0x10225(%rip),%rax        # 131d8 <fwp_gc+0x1058>
    2fb3:	48 c1 e0 10          	shl    $0x10,%rax
    2fb7:	49 89 df             	mov    %rbx,%r15
    2fba:	48 39 c1             	cmp    %rax,%rcx
    2fbd:	0f 82 71 ff ff ff    	jb     2f34 <fwp_main_thread+0x9e4>
    2fc3:	eb 0f                	jmp    2fd4 <fwp_main_thread+0xa84>
    2fc5:	3d ff 00 00 00       	cmp    $0xff,%eax
    2fca:	0f 84 2f 10 00 00    	je     3fff <fwp_main_thread+0x1aaf>
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
    2ff3:	e8 d8 96 00 00       	call   c6d0 <fwp_drop8>
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
    3066:	e8 65 46 00 00       	call   76d0 <fwp_show>
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
    30ed:	e8 9e 31 00 00       	call   6290 <fwp_rc_forget_slot>
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
    319e:	e8 fd 76 00 00       	call   a8a0 <fwp_rc_free_obj>
    31a3:	eb 0f                	jmp    31b4 <fwp_main_thread+0xc64>
    31a5:	3d ff 00 00 00       	cmp    $0xff,%eax
    31aa:	0f 84 6a 0e 00 00    	je     401a <fwp_main_thread+0x1aca>
    31b0:	fe c8                	dec    %al
    31b2:	88 07                	mov    %al,(%rdi)
    31b4:	48 c7 85 10 ff ff ff 	movq   $0xc,-0xf0(%rbp)
    31bb:	0c 00 00 00 
    31bf:	48 c7 85 18 ff ff ff 	movq   $0x0,-0xe8(%rbp)
    31c6:	00 00 00 00 
    31ca:	48 8d 95 10 ff ff ff 	lea    -0xf0(%rbp),%rdx
    31d1:	bf 01 00 00 00       	mov    $0x1,%edi
    31d6:	be 02 00 00 00       	mov    $0x2,%esi
    31db:	e8 80 6b 00 00       	call   9d60 <fwp_data>
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
    3266:	e8 25 30 00 00       	call   6290 <fwp_rc_forget_slot>
    326b:	48 89 d8             	mov    %rbx,%rax
    326e:	eb c3                	jmp    3233 <fwp_main_thread+0xce3>
    3270:	48 c7 85 20 ff ff ff 	movq   $0x0,-0xe0(%rbp)
    3277:	00 00 00 00 
    327b:	48 89 85 28 ff ff ff 	mov    %rax,-0xd8(%rbp)
    3282:	48 8d 95 20 ff ff ff 	lea    -0xe0(%rbp),%rdx
    3289:	bf 01 00 00 00       	mov    $0x1,%edi
    328e:	be 02 00 00 00       	mov    $0x2,%esi
    3293:	e8 c8 6a 00 00       	call   9d60 <fwp_data>
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
    331e:	e8 6d 2f 00 00       	call   6290 <fwp_rc_forget_slot>
    3323:	48 89 d8             	mov    %rbx,%rax
    3326:	eb c3                	jmp    32eb <fwp_main_thread+0xd9b>
    3328:	48 c7 85 30 ff ff ff 	movq   $0xffffffffffffff80,-0xd0(%rbp)
    332f:	80 ff ff ff 
    3333:	48 89 85 38 ff ff ff 	mov    %rax,-0xc8(%rbp)
    333a:	48 8d 95 30 ff ff ff 	lea    -0xd0(%rbp),%rdx
    3341:	bf 01 00 00 00       	mov    $0x1,%edi
    3346:	be 02 00 00 00       	mov    $0x2,%esi
    334b:	e8 10 6a 00 00       	call   9d60 <fwp_data>
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
    33d2:	e8 b9 2e 00 00       	call   6290 <fwp_rc_forget_slot>
    33d7:	eb c9                	jmp    33a2 <fwp_main_thread+0xe52>
    33d9:	48 8d 35 d0 e8 00 00 	lea    0xe8d0(%rip),%rsi        # 11cb0 <d1>
    33e0:	4c 89 ff             	mov    %r15,%rdi
    33e3:	e8 58 2f 00 00       	call   6340 <fwp_p_array_from_list_typed>
    33e8:	49 89 c6             	mov    %rax,%r14
    33eb:	4c 89 ff             	mov    %r15,%rdi
    33ee:	e8 dd ac 00 00       	call   e0d0 <fwp_drop4>
    33f3:	31 db                	xor    %ebx,%ebx
    33f5:	45 31 ff             	xor    %r15d,%r15d
    33f8:	45 31 e4             	xor    %r12d,%r12d
    33fb:	45 31 ed             	xor    %r13d,%r13d
    33fe:	31 ff                	xor    %edi,%edi
    3400:	eb 22                	jmp    3424 <fwp_main_thread+0xed4>
    3402:	66 66 66 66 66 2e 0f 	data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    3409:	1f 84 00 00 00 00 00 
    3410:	4c 89 f7             	mov    %r14,%rdi
    3413:	e8 68 9a 00 00       	call   ce80 <fwp_drop11>
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
    345f:	0f 86 dd 0b 00 00    	jbe    4042 <fwp_main_thread+0x1af2>
    3465:	48 ff c3             	inc    %rbx
    3468:	0f 80 e4 0b 00 00    	jo     4052 <fwp_main_thread+0x1b02>
    346e:	49 ff c7             	inc    %r15
    3471:	b0 01                	mov    $0x1,%al
    3473:	4d 89 f4             	mov    %r14,%r12
    3476:	4d 89 f5             	mov    %r14,%r13
    3479:	eb a2                	jmp    341d <fwp_main_thread+0xecd>
    347b:	e8 40 66 00 00       	call   9ac0 <fwp_show_i64>
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
    3502:	e8 89 2d 00 00       	call   6290 <fwp_rc_forget_slot>
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
    35b3:	e8 e8 72 00 00       	call   a8a0 <fwp_rc_free_obj>
    35b8:	eb 0f                	jmp    35c9 <fwp_main_thread+0x1079>
    35ba:	3d ff 00 00 00       	cmp    $0xff,%eax
    35bf:	0f 84 5f 0a 00 00    	je     4024 <fwp_main_thread+0x1ad4>
    35c5:	fe c8                	dec    %al
    35c7:	88 07                	mov    %al,(%rdi)
    35c9:	48 c7 85 40 ff ff ff 	movq   $0x3,-0xc0(%rbp)
    35d0:	03 00 00 00 
    35d4:	48 c7 85 48 ff ff ff 	movq   $0x0,-0xb8(%rbp)
    35db:	00 00 00 00 
    35df:	48 8d 95 40 ff ff ff 	lea    -0xc0(%rbp),%rdx
    35e6:	bf 01 00 00 00       	mov    $0x1,%edi
    35eb:	be 02 00 00 00       	mov    $0x2,%esi
    35f0:	e8 6b 67 00 00       	call   9d60 <fwp_data>
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
    367b:	e8 10 2c 00 00       	call   6290 <fwp_rc_forget_slot>
    3680:	48 89 d8             	mov    %rbx,%rax
    3683:	eb c3                	jmp    3648 <fwp_main_thread+0x10f8>
    3685:	48 c7 85 50 ff ff ff 	movq   $0x2,-0xb0(%rbp)
    368c:	02 00 00 00 
    3690:	48 89 85 58 ff ff ff 	mov    %rax,-0xa8(%rbp)
    3697:	48 8d 95 50 ff ff ff 	lea    -0xb0(%rbp),%rdx
    369e:	bf 01 00 00 00       	mov    $0x1,%edi
    36a3:	be 02 00 00 00       	mov    $0x2,%esi
    36a8:	e8 b3 66 00 00       	call   9d60 <fwp_data>
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
    3733:	e8 58 2b 00 00       	call   6290 <fwp_rc_forget_slot>
    3738:	48 89 d8             	mov    %rbx,%rax
    373b:	eb c3                	jmp    3700 <fwp_main_thread+0x11b0>
    373d:	48 c7 85 60 ff ff ff 	movq   $0x1,-0xa0(%rbp)
    3744:	01 00 00 00 
    3748:	48 89 85 68 ff ff ff 	mov    %rax,-0x98(%rbp)
    374f:	48 8d 95 60 ff ff ff 	lea    -0xa0(%rbp),%rdx
    3756:	bf 01 00 00 00       	mov    $0x1,%edi
    375b:	be 02 00 00 00       	mov    $0x2,%esi
    3760:	e8 fb 65 00 00       	call   9d60 <fwp_data>
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
    37e7:	e8 a4 2a 00 00       	call   6290 <fwp_rc_forget_slot>
    37ec:	eb c9                	jmp    37b7 <fwp_main_thread+0x1267>
    37ee:	48 8d 35 bb e4 00 00 	lea    0xe4bb(%rip),%rsi        # 11cb0 <d1>
    37f5:	4c 89 ff             	mov    %r15,%rdi
    37f8:	e8 43 2b 00 00       	call   6340 <fwp_p_array_from_list_typed>
    37fd:	49 89 c6             	mov    %rax,%r14
    3800:	4c 89 ff             	mov    %r15,%rdi
    3803:	e8 c8 a8 00 00       	call   e0d0 <fwp_drop4>
    3808:	31 db                	xor    %ebx,%ebx
    380a:	45 31 ff             	xor    %r15d,%r15d
    380d:	45 31 e4             	xor    %r12d,%r12d
    3810:	45 31 ed             	xor    %r13d,%r13d
    3813:	31 ff                	xor    %edi,%edi
    3815:	eb 1d                	jmp    3834 <fwp_main_thread+0x12e4>
    3817:	66 0f 1f 84 00 00 00 	nopw   0x0(%rax,%rax,1)
    381e:	00 00 
    3820:	4c 89 f7             	mov    %r14,%rdi
    3823:	e8 58 96 00 00       	call   ce80 <fwp_drop11>
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
    3870:	0f 86 cc 07 00 00    	jbe    4042 <fwp_main_thread+0x1af2>
    3876:	48 01 c3             	add    %rax,%rbx
    3879:	48 ff c3             	inc    %rbx
    387c:	48 0f be c3          	movsbq %bl,%rax
    3880:	48 39 d8             	cmp    %rbx,%rax
    3883:	0f 85 b9 07 00 00    	jne    4042 <fwp_main_thread+0x1af2>
    3889:	49 ff c7             	inc    %r15
    388c:	b0 01                	mov    $0x1,%al
    388e:	4d 89 f4             	mov    %r14,%r12
    3891:	4d 89 f5             	mov    %r14,%r13
    3894:	eb 97                	jmp    382d <fwp_main_thread+0x12dd>
    3896:	e8 25 62 00 00       	call   9ac0 <fwp_show_i64>
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
    391d:	e8 6e 29 00 00       	call   6290 <fwp_rc_forget_slot>
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
    39ce:	e8 cd 6e 00 00       	call   a8a0 <fwp_rc_free_obj>
    39d3:	eb 0f                	jmp    39e4 <fwp_main_thread+0x1494>
    39d5:	3d ff 00 00 00       	cmp    $0xff,%eax
    39da:	0f 84 4e 06 00 00    	je     402e <fwp_main_thread+0x1ade>
    39e0:	fe c8                	dec    %al
    39e2:	88 07                	mov    %al,(%rdi)
    39e4:	48 8d 35 65 e2 00 00 	lea    0xe265(%rip),%rsi        # 11c50 <d0>
    39eb:	31 db                	xor    %ebx,%ebx
    39ed:	31 ff                	xor    %edi,%edi
    39ef:	e8 4c 2a 00 00       	call   6440 <fwp_array_typed_new>
    39f4:	49 89 c6             	mov    %rax,%r14
    39f7:	31 ff                	xor    %edi,%edi
    39f9:	e8 02 a6 00 00       	call   e000 <fwp_drop0>
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
    3a63:	e8 68 69 00 00       	call   a3d0 <fwp_drop1>
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
    3ac4:	e8 07 3c 00 00       	call   76d0 <fwp_show>
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
    3b4b:	e8 40 27 00 00       	call   6290 <fwp_rc_forget_slot>
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
    3bfc:	e8 9f 6c 00 00       	call   a8a0 <fwp_rc_free_obj>
    3c01:	eb 0f                	jmp    3c12 <fwp_main_thread+0x16c2>
    3c03:	3d ff 00 00 00       	cmp    $0xff,%eax
    3c08:	0f 84 2a 04 00 00    	je     4038 <fwp_main_thread+0x1ae8>
    3c0e:	fe c8                	dec    %al
    3c10:	88 07                	mov    %al,(%rdi)
    3c12:	66 0f 57 c0          	xorpd  %xmm0,%xmm0
    3c16:	66 0f 29 85 10 fe ff 	movapd %xmm0,-0x1f0(%rbp)
    3c1d:	ff 
    3c1e:	48 8d 95 10 fe ff ff 	lea    -0x1f0(%rbp),%rdx
    3c25:	bf 01 00 00 00       	mov    $0x1,%edi
    3c2a:	be 02 00 00 00       	mov    $0x2,%esi
    3c2f:	e8 2c 61 00 00       	call   9d60 <fwp_data>
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
    3cba:	e8 d1 25 00 00       	call   6290 <fwp_rc_forget_slot>
    3cbf:	48 89 d8             	mov    %rbx,%rax
    3cc2:	eb c3                	jmp    3c87 <fwp_main_thread+0x1737>
    3cc4:	48 c7 85 70 ff ff ff 	movq   $0x0,-0x90(%rbp)
    3ccb:	00 00 00 00 
    3ccf:	48 89 85 78 ff ff ff 	mov    %rax,-0x88(%rbp)
    3cd6:	48 8d 95 70 ff ff ff 	lea    -0x90(%rbp),%rdx
    3cdd:	bf 01 00 00 00       	mov    $0x1,%edi
    3ce2:	be 02 00 00 00       	mov    $0x2,%esi
    3ce7:	e8 74 60 00 00       	call   9d60 <fwp_data>
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
    3d72:	e8 19 25 00 00       	call   6290 <fwp_rc_forget_slot>
    3d77:	48 89 d8             	mov    %rbx,%rax
    3d7a:	eb c3                	jmp    3d3f <fwp_main_thread+0x17ef>
    3d7c:	48 c7 45 80 00 00 00 	movq   $0x0,-0x80(%rbp)
    3d83:	00 
    3d84:	48 89 45 88          	mov    %rax,-0x78(%rbp)
    3d88:	48 8d 55 80          	lea    -0x80(%rbp),%rdx
    3d8c:	bf 01 00 00 00       	mov    $0x1,%edi
    3d91:	be 02 00 00 00       	mov    $0x2,%esi
    3d96:	e8 c5 5f 00 00       	call   9d60 <fwp_data>
    3d9b:	48 89 c1             	mov    %rax,%rcx
    3d9e:	48 2b 0d 0b f4 00 00 	sub    0xf40b(%rip),%rcx        # 131b0 <fwp_gc+0x1030>
    3da5:	48 8b 15 2c f4 00 00 	mov    0xf42c(%rip),%rdx        # 131d8 <fwp_gc+0x1058>
    3dac:	48 c1 e2 10          	shl    $0x10,%rdx
    3db0:	48 39 d1             	cmp    %rdx,%rcx
    3db3:	73 76                	jae    3e2b <fwp_main_thread+0x18db>
    3db5:	48 8b 15 3c f4 00 00 	mov    0xf43c(%rip),%rdx        # 131f8 <fwp_gc+0x1078>
    3dbc:	48 89 ce             	mov    %rcx,%rsi
    3dbf:	48 c1 ee 10          	shr    $0x10,%rsi
    3dc3:	48 69 f6 28 12 00 00 	imul   $0x1228,%rsi,%rsi
    3dca:	0f b6 3c 32          	movzbl (%rdx,%rsi,1),%edi
    3dce:	48 81 e1 ff ff 00 00 	and    $0xffff,%rcx
    3dd5:	75 1d                	jne    3df4 <fwp_main_thread+0x18a4>
    3dd7:	40 80 ff 02          	cmp    $0x2,%dil
    3ddb:	75 17                	jne    3df4 <fwp_main_thread+0x18a4>
    3ddd:	4c 8d 34 32          	lea    (%rdx,%rsi,1),%r14
    3de1:	49 81 c6 28 02 00 00 	add    $0x228,%r14
    3de8:	41 80 3e ff          	cmpb   $0xff,(%r14)
    3dec:	74 2d                	je     3e1b <fwp_main_thread+0x18cb>
    3dee:	41 c6 06 01          	movb   $0x1,(%r14)
    3df2:	eb 37                	jmp    3e2b <fwp_main_thread+0x18db>
    3df4:	40 80 ff 01          	cmp    $0x1,%dil
    3df8:	75 31                	jne    3e2b <fwp_main_thread+0x18db>
    3dfa:	48 8d 3c 32          	lea    (%rdx,%rsi,1),%rdi
    3dfe:	8b 54 32 20          	mov    0x20(%rdx,%rsi,1),%edx
    3e02:	48 0f af ca          	imul   %rdx,%rcx
    3e06:	48 c1 e9 20          	shr    $0x20,%rcx
    3e0a:	4c 8d 34 39          	lea    (%rcx,%rdi,1),%r14
    3e0e:	49 81 c6 28 02 00 00 	add    $0x228,%r14
    3e15:	41 80 3e ff          	cmpb   $0xff,(%r14)
    3e19:	75 d3                	jne    3dee <fwp_main_thread+0x189e>
    3e1b:	4c 89 f7             	mov    %r14,%rdi
    3e1e:	48 89 c3             	mov    %rax,%rbx
    3e21:	e8 6a 24 00 00       	call   6290 <fwp_rc_forget_slot>
    3e26:	48 89 d8             	mov    %rbx,%rax
    3e29:	eb c3                	jmp    3dee <fwp_main_thread+0x189e>
    3e2b:	48 c7 45 90 00 00 00 	movq   $0x0,-0x70(%rbp)
    3e32:	00 
    3e33:	48 89 45 98          	mov    %rax,-0x68(%rbp)
    3e37:	48 8d 55 90          	lea    -0x70(%rbp),%rdx
    3e3b:	bf 01 00 00 00       	mov    $0x1,%edi
    3e40:	be 02 00 00 00       	mov    $0x2,%esi
    3e45:	e8 16 5f 00 00       	call   9d60 <fwp_data>
    3e4a:	48 89 c1             	mov    %rax,%rcx
    3e4d:	48 2b 0d 5c f3 00 00 	sub    0xf35c(%rip),%rcx        # 131b0 <fwp_gc+0x1030>
    3e54:	48 8b 15 7d f3 00 00 	mov    0xf37d(%rip),%rdx        # 131d8 <fwp_gc+0x1058>
    3e5b:	48 c1 e2 10          	shl    $0x10,%rdx
    3e5f:	48 39 d1             	cmp    %rdx,%rcx
    3e62:	73 76                	jae    3eda <fwp_main_thread+0x198a>
    3e64:	48 8b 15 8d f3 00 00 	mov    0xf38d(%rip),%rdx        # 131f8 <fwp_gc+0x1078>
    3e6b:	48 89 ce             	mov    %rcx,%rsi
    3e6e:	48 c1 ee 10          	shr    $0x10,%rsi
    3e72:	48 69 f6 28 12 00 00 	imul   $0x1228,%rsi,%rsi
    3e79:	0f b6 3c 32          	movzbl (%rdx,%rsi,1),%edi
    3e7d:	48 81 e1 ff ff 00 00 	and    $0xffff,%rcx
    3e84:	75 1d                	jne    3ea3 <fwp_main_thread+0x1953>
    3e86:	40 80 ff 02          	cmp    $0x2,%dil
    3e8a:	75 17                	jne    3ea3 <fwp_main_thread+0x1953>
    3e8c:	4c 8d 34 32          	lea    (%rdx,%rsi,1),%r14
    3e90:	49 81 c6 28 02 00 00 	add    $0x228,%r14
    3e97:	41 80 3e ff          	cmpb   $0xff,(%r14)
    3e9b:	74 2d                	je     3eca <fwp_main_thread+0x197a>
    3e9d:	41 c6 06 01          	movb   $0x1,(%r14)
    3ea1:	eb 37                	jmp    3eda <fwp_main_thread+0x198a>
    3ea3:	40 80 ff 01          	cmp    $0x1,%dil
    3ea7:	75 31                	jne    3eda <fwp_main_thread+0x198a>
    3ea9:	48 8d 3c 32          	lea    (%rdx,%rsi,1),%rdi
    3ead:	8b 54 32 20          	mov    0x20(%rdx,%rsi,1),%edx
    3eb1:	48 0f af ca          	imul   %rdx,%rcx
    3eb5:	48 c1 e9 20          	shr    $0x20,%rcx
    3eb9:	4c 8d 34 39          	lea    (%rcx,%rdi,1),%r14
    3ebd:	49 81 c6 28 02 00 00 	add    $0x228,%r14
    3ec4:	41 80 3e ff          	cmpb   $0xff,(%r14)
    3ec8:	75 d3                	jne    3e9d <fwp_main_thread+0x194d>
    3eca:	4c 89 f7             	mov    %r14,%rdi
    3ecd:	48 89 c3             	mov    %rax,%rbx
    3ed0:	e8 bb 23 00 00       	call   6290 <fwp_rc_forget_slot>
    3ed5:	48 89 d8             	mov    %rbx,%rax
    3ed8:	eb c3                	jmp    3e9d <fwp_main_thread+0x194d>
    3eda:	48 89 c1             	mov    %rax,%rcx
    3edd:	48 2b 0d cc f2 00 00 	sub    0xf2cc(%rip),%rcx        # 131b0 <fwp_gc+0x1030>
    3ee4:	48 8b 15 ed f2 00 00 	mov    0xf2ed(%rip),%rdx        # 131d8 <fwp_gc+0x1058>
    3eeb:	48 c1 e2 10          	shl    $0x10,%rdx
    3eef:	48 39 d1             	cmp    %rdx,%rcx
    3ef2:	0f 83 9c 00 00 00    	jae    3f94 <fwp_main_thread+0x1a44>
    3ef8:	48 8b 15 f9 f2 00 00 	mov    0xf2f9(%rip),%rdx        # 131f8 <fwp_gc+0x1078>
    3eff:	48 89 ce             	mov    %rcx,%rsi
    3f02:	48 c1 ee 10          	shr    $0x10,%rsi
    3f06:	48 69 f6 28 12 00 00 	imul   $0x1228,%rsi,%rsi
    3f0d:	0f b6 3c 32          	movzbl (%rdx,%rsi,1),%edi
    3f11:	48 81 e1 ff ff 00 00 	and    $0xffff,%rcx
    3f18:	75 13                	jne    3f2d <fwp_main_thread+0x19dd>
    3f1a:	40 80 ff 02          	cmp    $0x2,%dil
    3f1e:	75 0d                	jne    3f2d <fwp_main_thread+0x19dd>
    3f20:	48 8d 3c 32          	lea    (%rdx,%rsi,1),%rdi
    3f24:	48 81 c7 28 02 00 00 	add    $0x228,%rdi
    3f2b:	eb 20                	jmp    3f4d <fwp_main_thread+0x19fd>
    3f2d:	40 80 ff 01          	cmp    $0x1,%dil
    3f31:	75 61                	jne    3f94 <fwp_main_thread+0x1a44>
    3f33:	48 8d 3c 32          	lea    (%rdx,%rsi,1),%rdi
    3f37:	8b 54 32 20          	mov    0x20(%rdx,%rsi,1),%edx
    3f3b:	48 0f af ca          	imul   %rdx,%rcx
    3f3f:	48 c1 e9 20          	shr    $0x20,%rcx
    3f43:	48 01 cf             	add    %rcx,%rdi
    3f46:	48 81 c7 28 02 00 00 	add    $0x228,%rdi
    3f4d:	0f b6 0f             	movzbl (%rdi),%ecx
    3f50:	85 c9                	test   %ecx,%ecx
    3f52:	74 40                	je     3f94 <fwp_main_thread+0x1a44>
    3f54:	83 f9 01             	cmp    $0x1,%ecx
    3f57:	75 2f                	jne    3f88 <fwp_main_thread+0x1a38>
    3f59:	48 8b 58 10          	mov    0x10(%rax),%rbx
    3f5d:	48 89 c7             	mov    %rax,%rdi
    3f60:	e8 3b 69 00 00       	call   a8a0 <fwp_rc_free_obj>
    3f65:	48 89 d9             	mov    %rbx,%rcx
    3f68:	48 2b 0d 41 f2 00 00 	sub    0xf241(%rip),%rcx        # 131b0 <fwp_gc+0x1030>
    3f6f:	48 8b 15 62 f2 00 00 	mov    0xf262(%rip),%rdx        # 131d8 <fwp_gc+0x1058>
    3f76:	48 c1 e2 10          	shl    $0x10,%rdx
    3f7a:	48 89 d8             	mov    %rbx,%rax
    3f7d:	48 39 d1             	cmp    %rdx,%rcx
    3f80:	0f 82 72 ff ff ff    	jb     3ef8 <fwp_main_thread+0x19a8>
    3f86:	eb 0c                	jmp    3f94 <fwp_main_thread+0x1a44>
    3f88:	81 f9 ff 00 00 00    	cmp    $0xff,%ecx
    3f8e:	74 79                	je     4009 <fwp_main_thread+0x1ab9>
    3f90:	fe c9                	dec    %cl
    3f92:	88 0f                	mov    %cl,(%rdi)
    3f94:	c6 05 75 fc 01 00 01 	movb   $0x1,0x1fc75(%rip)        # 23c10 <caf0.st>
    3f9b:	48 8b 05 de e1 00 00 	mov    0xe1de(%rip),%rax        # 12180 <fwp_gc>
    3fa2:	48 8b 55 b0          	mov    -0x50(%rbp),%rdx
    3fa6:	48 83 3d aa f3 00 00 	cmpq   $0x0,0xf3aa(%rip)        # 13358 <fwp_gc+0x11d8>
    3fad:	00 
    3fae:	0f 85 ec 00 00 00    	jne    40a0 <fwp_main_thread+0x1b50>
    3fb4:	83 3d b5 f1 00 00 00 	cmpl   $0x0,0xf1b5(%rip)        # 13170 <fwp_gc+0xff0>
    3fbb:	0f 85 df 00 00 00    	jne    40a0 <fwp_main_thread+0x1b50>
    3fc1:	48 39 c2             	cmp    %rax,%rdx
    3fc4:	0f 8f d6 00 00 00    	jg     40a0 <fwp_main_thread+0x1b50>
    3fca:	66 0f 57 c0          	xorpd  %xmm0,%xmm0
    3fce:	66 0f 2e 05 b2 f3 00 	ucomisd 0xf3b2(%rip),%xmm0        # 13388 <fwp_gc+0x1208>
    3fd5:	00 
    3fd6:	0f 83 c4 00 00 00    	jae    40a0 <fwp_main_thread+0x1b50>
    3fdc:	48 8b 05 dd df 00 00 	mov    0xdfdd(%rip),%rax        # 11fc0 <stdout@GLIBC_2.2.5>
    3fe3:	48 8b 38             	mov    (%rax),%rdi
    3fe6:	e8 15 e2 ff ff       	call   2200 <fflush@plt>
    3feb:	31 c0                	xor    %eax,%eax
    3fed:	48 81 c4 c8 01 00 00 	add    $0x1c8,%rsp
    3ff4:	5b                   	pop    %rbx
    3ff5:	41 5c                	pop    %r12
    3ff7:	41 5d                	pop    %r13
    3ff9:	41 5e                	pop    %r14
    3ffb:	41 5f                	pop    %r15
    3ffd:	5d                   	pop    %rbp
    3ffe:	c3                   	ret
    3fff:	e8 bc 65 00 00       	call   a5c0 <fwp_rc_wide_drop>
    4004:	e9 cb ef ff ff       	jmp    2fd4 <fwp_main_thread+0xa84>
    4009:	e8 b2 65 00 00       	call   a5c0 <fwp_rc_wide_drop>
    400e:	eb 84                	jmp    3f94 <fwp_main_thread+0x1a44>
    4010:	e8 ab 65 00 00       	call   a5c0 <fwp_rc_wide_drop>
    4015:	e9 08 ec ff ff       	jmp    2c22 <fwp_main_thread+0x6d2>
    401a:	e8 a1 65 00 00       	call   a5c0 <fwp_rc_wide_drop>
    401f:	e9 90 f1 ff ff       	jmp    31b4 <fwp_main_thread+0xc64>
    4024:	e8 97 65 00 00       	call   a5c0 <fwp_rc_wide_drop>
    4029:	e9 9b f5 ff ff       	jmp    35c9 <fwp_main_thread+0x1079>
    402e:	e8 8d 65 00 00       	call   a5c0 <fwp_rc_wide_drop>
    4033:	e9 ac f9 ff ff       	jmp    39e4 <fwp_main_thread+0x1494>
    4038:	e8 83 65 00 00       	call   a5c0 <fwp_rc_wide_drop>
    403d:	e9 d0 fb ff ff       	jmp    3c12 <fwp_main_thread+0x16c2>
    4042:	48 8d 15 42 b6 00 00 	lea    0xb642(%rip),%rdx        # f68b <fwp_segv.msg+0x44b>
    4049:	48 8d 0d 53 b5 00 00 	lea    0xb553(%rip),%rcx        # f5a3 <fwp_segv.msg+0x363>
    4050:	eb 0e                	jmp    4060 <fwp_main_thread+0x1b10>
    4052:	48 8d 15 32 b6 00 00 	lea    0xb632(%rip),%rdx        # f68b <fwp_segv.msg+0x44b>
    4059:	48 8d 0d 45 b6 00 00 	lea    0xb645(%rip),%rcx        # f6a5 <fwp_segv.msg+0x465>
    4060:	48 8d 9d 10 fe ff ff 	lea    -0x1f0(%rbp),%rbx
    4067:	be 60 00 00 00       	mov    $0x60,%esi
    406c:	48 89 df             	mov    %rbx,%rdi
    406f:	31 c0                	xor    %eax,%eax
    4071:	e8 9a e0 ff ff       	call   2110 <snprintf@plt>
    4076:	e8 e5 21 00 00       	call   6260 <fwp_flush>
    407b:	48 8b 05 5e df 00 00 	mov    0xdf5e(%rip),%rax        # 11fe0 <stderr@GLIBC_2.2.5>
    4082:	48 8b 38             	mov    (%rax),%rdi
    4085:	48 8d 35 a1 b3 00 00 	lea    0xb3a1(%rip),%rsi        # f42d <fwp_segv.msg+0x1ed>
    408c:	48 89 da             	mov    %rbx,%rdx
    408f:	31 c0                	xor    %eax,%eax
    4091:	e8 1a e1 ff ff       	call   21b0 <fprintf@plt>
    4096:	bf 65 00 00 00       	mov    $0x65,%edi
    409b:	e8 f0 e1 ff ff       	call   2290 <exit@plt>
    40a0:	48 8b 0d 39 df 00 00 	mov    0xdf39(%rip),%rcx        # 11fe0 <stderr@GLIBC_2.2.5>
    40a7:	48 8b 39             	mov    (%rcx),%rdi
    40aa:	48 29 c2             	sub    %rax,%rdx
    40ad:	48 8d 35 60 b6 00 00 	lea    0xb660(%rip),%rsi        # f714 <fwp_segv.msg+0x4d4>
    40b4:	31 c0                	xor    %eax,%eax
    40b6:	e8 f5 e0 ff ff       	call   21b0 <fprintf@plt>
    40bb:	bf c1 00 00 00       	mov    $0xc1,%edi
    40c0:	e8 cb e1 ff ff       	call   2290 <exit@plt>
    40c5:	66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
    40cc:	00 00 00 00 

00000000000040d0 <e1>:
    40d0:	50                   	push   %rax
    40d1:	48 8b 3f             	mov    (%rdi),%rdi
    40d4:	48 89 f8             	mov    %rdi,%rax
    40d7:	48 2b 05 d2 f0 00 00 	sub    0xf0d2(%rip),%rax        # 131b0 <fwp_gc+0x1030>
    40de:	48 8b 0d f3 f0 00 00 	mov    0xf0f3(%rip),%rcx        # 131d8 <fwp_gc+0x1058>
    40e5:	48 c1 e1 10          	shl    $0x10,%rcx
    40e9:	48 39 c8             	cmp    %rcx,%rax
    40ec:	73 63                	jae    4151 <e1+0x81>
    40ee:	48 8b 0d 03 f1 00 00 	mov    0xf103(%rip),%rcx        # 131f8 <fwp_gc+0x1078>
    40f5:	48 89 c2             	mov    %rax,%rdx
    40f8:	48 c1 ea 10          	shr    $0x10,%rdx
    40fc:	48 69 d2 28 12 00 00 	imul   $0x1228,%rdx,%rdx
    4103:	0f b6 34 11          	movzbl (%rcx,%rdx,1),%esi
    4107:	48 25 ff ff 00 00    	and    $0xffff,%rax
    410d:	75 1a                	jne    4129 <e1+0x59>
    410f:	40 80 fe 02          	cmp    $0x2,%sil
    4113:	75 14                	jne    4129 <e1+0x59>
    4115:	48 8d 04 11          	lea    (%rcx,%rdx,1),%rax
    4119:	48 05 28 02 00 00    	add    $0x228,%rax
    411f:	80 38 00             	cmpb   $0x0,(%rax)
    4122:	74 2d                	je     4151 <e1+0x81>
    4124:	e9 af 00 00 00       	jmp    41d8 <e1+0x108>
    4129:	40 80 fe 01          	cmp    $0x1,%sil
    412d:	75 22                	jne    4151 <e1+0x81>
    412f:	48 8d 34 11          	lea    (%rcx,%rdx,1),%rsi
    4133:	8b 4c 11 20          	mov    0x20(%rcx,%rdx,1),%ecx
    4137:	48 0f af c1          	imul   %rcx,%rax
    413b:	48 c1 e8 20          	shr    $0x20,%rax
    413f:	48 01 f0             	add    %rsi,%rax
    4142:	48 05 28 02 00 00    	add    $0x228,%rax
    4148:	80 38 00             	cmpb   $0x0,(%rax)
    414b:	0f 85 87 00 00 00    	jne    41d8 <e1+0x108>
    4151:	48 8d 35 f8 da 00 00 	lea    0xdaf8(%rip),%rsi        # 11c50 <d0>
    4158:	e8 e3 21 00 00       	call   6340 <fwp_p_array_from_list_typed>
    415d:	48 89 c1             	mov    %rax,%rcx
    4160:	48 2b 0d 49 f0 00 00 	sub    0xf049(%rip),%rcx        # 131b0 <fwp_gc+0x1030>
    4167:	48 8b 15 6a f0 00 00 	mov    0xf06a(%rip),%rdx        # 131d8 <fwp_gc+0x1058>
    416e:	48 c1 e2 10          	shl    $0x10,%rdx
    4172:	48 39 d1             	cmp    %rdx,%rcx
    4175:	73 5f                	jae    41d6 <e1+0x106>
    4177:	48 8b 15 7a f0 00 00 	mov    0xf07a(%rip),%rdx        # 131f8 <fwp_gc+0x1078>
    417e:	48 89 ce             	mov    %rcx,%rsi
    4181:	48 c1 ee 10          	shr    $0x10,%rsi
    4185:	48 69 f6 28 12 00 00 	imul   $0x1228,%rsi,%rsi
    418c:	0f b6 3c 32          	movzbl (%rdx,%rsi,1),%edi
    4190:	48 81 e1 ff ff 00 00 	and    $0xffff,%rcx
    4197:	75 18                	jne    41b1 <e1+0xe1>
    4199:	40 80 ff 02          	cmp    $0x2,%dil
    419d:	75 12                	jne    41b1 <e1+0xe1>
    419f:	48 8d 0c 32          	lea    (%rdx,%rsi,1),%rcx
    41a3:	48 81 c1 28 02 00 00 	add    $0x228,%rcx
    41aa:	80 39 00             	cmpb   $0x0,(%rcx)
    41ad:	74 27                	je     41d6 <e1+0x106>
    41af:	eb 27                	jmp    41d8 <e1+0x108>
    41b1:	40 80 ff 01          	cmp    $0x1,%dil
    41b5:	75 1f                	jne    41d6 <e1+0x106>
    41b7:	48 8d 3c 32          	lea    (%rdx,%rsi,1),%rdi
    41bb:	8b 54 32 20          	mov    0x20(%rdx,%rsi,1),%edx
    41bf:	48 0f af ca          	imul   %rdx,%rcx
    41c3:	48 c1 e9 20          	shr    $0x20,%rcx
    41c7:	48 01 f9             	add    %rdi,%rcx
    41ca:	48 81 c1 28 02 00 00 	add    $0x228,%rcx
    41d1:	80 39 00             	cmpb   $0x0,(%rcx)
    41d4:	75 02                	jne    41d8 <e1+0x108>
    41d6:	59                   	pop    %rcx
    41d7:	c3                   	ret
    41d8:	e8 83 20 00 00       	call   6260 <fwp_flush>
    41dd:	48 8b 05 fc dd 00 00 	mov    0xddfc(%rip),%rax        # 11fe0 <stderr@GLIBC_2.2.5>
    41e4:	48 8b 38             	mov    (%rax),%rdi
    41e7:	48 8d 35 3f b2 00 00 	lea    0xb23f(%rip),%rsi        # f42d <fwp_segv.msg+0x1ed>
    41ee:	48 8d 15 0b b2 00 00 	lea    0xb20b(%rip),%rdx        # f400 <fwp_segv.msg+0x1c0>
    41f5:	31 c0                	xor    %eax,%eax
    41f7:	e8 b4 df ff ff       	call   21b0 <fprintf@plt>
    41fc:	bf 65 00 00 00       	mov    $0x65,%edi
    4201:	e8 8a e0 ff ff       	call   2290 <exit@plt>
    4206:	66 2e 0f 1f 84 00 00 	cs nopw 0x0(%rax,%rax,1)
    420d:	00 00 00 

0000000000004210 <e4>:
    4210:	50                   	push   %rax
    4211:	48 8b 3f             	mov    (%rdi),%rdi
    4214:	48 89 f8             	mov    %rdi,%rax
    4217:	48 2b 05 92 ef 00 00 	sub    0xef92(%rip),%rax        # 131b0 <fwp_gc+0x1030>
    421e:	48 8b 0d b3 ef 00 00 	mov    0xefb3(%rip),%rcx        # 131d8 <fwp_gc+0x1058>
    4225:	48 c1 e1 10          	shl    $0x10,%rcx
    4229:	48 39 c8             	cmp    %rcx,%rax
    422c:	73 63                	jae    4291 <e4+0x81>
    422e:	48 8b 0d c3 ef 00 00 	mov    0xefc3(%rip),%rcx        # 131f8 <fwp_gc+0x1078>
    4235:	48 89 c2             	mov    %rax,%rdx
    4238:	48 c1 ea 10          	shr    $0x10,%rdx
    423c:	48 69 d2 28 12 00 00 	imul   $0x1228,%rdx,%rdx
    4243:	0f b6 34 11          	movzbl (%rcx,%rdx,1),%esi
    4247:	48 25 ff ff 00 00    	and    $0xffff,%rax
    424d:	75 1a                	jne    4269 <e4+0x59>
    424f:	40 80 fe 02          	cmp    $0x2,%sil
    4253:	75 14                	jne    4269 <e4+0x59>
    4255:	48 8d 04 11          	lea    (%rcx,%rdx,1),%rax
    4259:	48 05 28 02 00 00    	add    $0x228,%rax
    425f:	80 38 00             	cmpb   $0x0,(%rax)
    4262:	74 2d                	je     4291 <e4+0x81>
    4264:	e9 af 00 00 00       	jmp    4318 <e4+0x108>
    4269:	40 80 fe 01          	cmp    $0x1,%sil
    426d:	75 22                	jne    4291 <e4+0x81>
    426f:	48 8d 34 11          	lea    (%rcx,%rdx,1),%rsi
    4273:	8b 4c 11 20          	mov    0x20(%rcx,%rdx,1),%ecx
    4277:	48 0f af c1          	imul   %rcx,%rax
    427b:	48 c1 e8 20          	shr    $0x20,%rax
    427f:	48 01 f0             	add    %rsi,%rax
    4282:	48 05 28 02 00 00    	add    $0x228,%rax
    4288:	80 38 00             	cmpb   $0x0,(%rax)
    428b:	0f 85 87 00 00 00    	jne    4318 <e4+0x108>
    4291:	48 8d 35 18 da 00 00 	lea    0xda18(%rip),%rsi        # 11cb0 <d1>
    4298:	e8 a3 20 00 00       	call   6340 <fwp_p_array_from_list_typed>
    429d:	48 89 c1             	mov    %rax,%rcx
    42a0:	48 2b 0d 09 ef 00 00 	sub    0xef09(%rip),%rcx        # 131b0 <fwp_gc+0x1030>
    42a7:	48 8b 15 2a ef 00 00 	mov    0xef2a(%rip),%rdx        # 131d8 <fwp_gc+0x1058>
    42ae:	48 c1 e2 10          	shl    $0x10,%rdx
    42b2:	48 39 d1             	cmp    %rdx,%rcx
    42b5:	73 5f                	jae    4316 <e4+0x106>
    42b7:	48 8b 15 3a ef 00 00 	mov    0xef3a(%rip),%rdx        # 131f8 <fwp_gc+0x1078>
    42be:	48 89 ce             	mov    %rcx,%rsi
    42c1:	48 c1 ee 10          	shr    $0x10,%rsi
    42c5:	48 69 f6 28 12 00 00 	imul   $0x1228,%rsi,%rsi
    42cc:	0f b6 3c 32          	movzbl (%rdx,%rsi,1),%edi
    42d0:	48 81 e1 ff ff 00 00 	and    $0xffff,%rcx
    42d7:	75 18                	jne    42f1 <e4+0xe1>
    42d9:	40 80 ff 02          	cmp    $0x2,%dil
    42dd:	75 12                	jne    42f1 <e4+0xe1>
    42df:	48 8d 0c 32          	lea    (%rdx,%rsi,1),%rcx
    42e3:	48 81 c1 28 02 00 00 	add    $0x228,%rcx
    42ea:	80 39 00             	cmpb   $0x0,(%rcx)
    42ed:	74 27                	je     4316 <e4+0x106>
    42ef:	eb 27                	jmp    4318 <e4+0x108>
    42f1:	40 80 ff 01          	cmp    $0x1,%dil
    42f5:	75 1f                	jne    4316 <e4+0x106>
    42f7:	48 8d 3c 32          	lea    (%rdx,%rsi,1),%rdi
    42fb:	8b 54 32 20          	mov    0x20(%rdx,%rsi,1),%edx
    42ff:	48 0f af ca          	imul   %rdx,%rcx
    4303:	48 c1 e9 20          	shr    $0x20,%rcx
    4307:	48 01 f9             	add    %rdi,%rcx
    430a:	48 81 c1 28 02 00 00 	add    $0x228,%rcx
    4311:	80 39 00             	cmpb   $0x0,(%rcx)
    4314:	75 02                	jne    4318 <e4+0x108>
    4316:	59                   	pop    %rcx
    4317:	c3                   	ret
    4318:	e8 43 1f 00 00       	call   6260 <fwp_flush>
    431d:	48 8b 05 bc dc 00 00 	mov    0xdcbc(%rip),%rax        # 11fe0 <stderr@GLIBC_2.2.5>
    4324:	48 8b 38             	mov    (%rax),%rdi
    4327:	48 8d 35 ff b0 00 00 	lea    0xb0ff(%rip),%rsi        # f42d <fwp_segv.msg+0x1ed>
    432e:	48 8d 15 cb b0 00 00 	lea    0xb0cb(%rip),%rdx        # f400 <fwp_segv.msg+0x1c0>
    4335:	31 c0                	xor    %eax,%eax
    4337:	e8 74 de ff ff       	call   21b0 <fprintf@plt>
    433c:	bf 65 00 00 00       	mov    $0x65,%edi
    4341:	e8 4a df ff ff       	call   2290 <exit@plt>
    4346:	66 2e 0f 1f 84 00 00 	cs nopw 0x0(%rax,%rax,1)
    434d:	00 00 00 

0000000000004350 <e9>:
    4350:	50                   	push   %rax
    4351:	48 8b 3f             	mov    (%rdi),%rdi
    4354:	48 89 f8             	mov    %rdi,%rax
    4357:	48 2b 05 52 ee 00 00 	sub    0xee52(%rip),%rax        # 131b0 <fwp_gc+0x1030>
    435e:	48 8b 0d 73 ee 00 00 	mov    0xee73(%rip),%rcx        # 131d8 <fwp_gc+0x1058>
    4365:	48 c1 e1 10          	shl    $0x10,%rcx
    4369:	48 39 c8             	cmp    %rcx,%rax
    436c:	73 63                	jae    43d1 <e9+0x81>
    436e:	48 8b 0d 83 ee 00 00 	mov    0xee83(%rip),%rcx        # 131f8 <fwp_gc+0x1078>
    4375:	48 89 c2             	mov    %rax,%rdx
    4378:	48 c1 ea 10          	shr    $0x10,%rdx
    437c:	48 69 d2 28 12 00 00 	imul   $0x1228,%rdx,%rdx
    4383:	0f b6 34 11          	movzbl (%rcx,%rdx,1),%esi
    4387:	48 25 ff ff 00 00    	and    $0xffff,%rax
    438d:	75 1a                	jne    43a9 <e9+0x59>
    438f:	40 80 fe 02          	cmp    $0x2,%sil
    4393:	75 14                	jne    43a9 <e9+0x59>
    4395:	48 8d 04 11          	lea    (%rcx,%rdx,1),%rax
    4399:	48 05 28 02 00 00    	add    $0x228,%rax
    439f:	80 38 00             	cmpb   $0x0,(%rax)
    43a2:	74 2d                	je     43d1 <e9+0x81>
    43a4:	e9 af 00 00 00       	jmp    4458 <e9+0x108>
    43a9:	40 80 fe 01          	cmp    $0x1,%sil
    43ad:	75 22                	jne    43d1 <e9+0x81>
    43af:	48 8d 34 11          	lea    (%rcx,%rdx,1),%rsi
    43b3:	8b 4c 11 20          	mov    0x20(%rcx,%rdx,1),%ecx
    43b7:	48 0f af c1          	imul   %rcx,%rax
    43bb:	48 c1 e8 20          	shr    $0x20,%rax
    43bf:	48 01 f0             	add    %rsi,%rax
    43c2:	48 05 28 02 00 00    	add    $0x228,%rax
    43c8:	80 38 00             	cmpb   $0x0,(%rax)
    43cb:	0f 85 87 00 00 00    	jne    4458 <e9+0x108>
    43d1:	48 8d 35 38 d9 00 00 	lea    0xd938(%rip),%rsi        # 11d10 <d2>
    43d8:	e8 63 1f 00 00       	call   6340 <fwp_p_array_from_list_typed>
    43dd:	48 89 c1             	mov    %rax,%rcx
    43e0:	48 2b 0d c9 ed 00 00 	sub    0xedc9(%rip),%rcx        # 131b0 <fwp_gc+0x1030>
    43e7:	48 8b 15 ea ed 00 00 	mov    0xedea(%rip),%rdx        # 131d8 <fwp_gc+0x1058>
    43ee:	48 c1 e2 10          	shl    $0x10,%rdx
    43f2:	48 39 d1             	cmp    %rdx,%rcx
    43f5:	73 5f                	jae    4456 <e9+0x106>
    43f7:	48 8b 15 fa ed 00 00 	mov    0xedfa(%rip),%rdx        # 131f8 <fwp_gc+0x1078>
    43fe:	48 89 ce             	mov    %rcx,%rsi
    4401:	48 c1 ee 10          	shr    $0x10,%rsi
    4405:	48 69 f6 28 12 00 00 	imul   $0x1228,%rsi,%rsi
    440c:	0f b6 3c 32          	movzbl (%rdx,%rsi,1),%edi
    4410:	48 81 e1 ff ff 00 00 	and    $0xffff,%rcx
    4417:	75 18                	jne    4431 <e9+0xe1>
    4419:	40 80 ff 02          	cmp    $0x2,%dil
    441d:	75 12                	jne    4431 <e9+0xe1>
    441f:	48 8d 0c 32          	lea    (%rdx,%rsi,1),%rcx
    4423:	48 81 c1 28 02 00 00 	add    $0x228,%rcx
    442a:	80 39 00             	cmpb   $0x0,(%rcx)
    442d:	74 27                	je     4456 <e9+0x106>
    442f:	eb 27                	jmp    4458 <e9+0x108>
    4431:	40 80 ff 01          	cmp    $0x1,%dil
    4435:	75 1f                	jne    4456 <e9+0x106>
    4437:	48 8d 3c 32          	lea    (%rdx,%rsi,1),%rdi
    443b:	8b 54 32 20          	mov    0x20(%rdx,%rsi,1),%edx
    443f:	48 0f af ca          	imul   %rdx,%rcx
    4443:	48 c1 e9 20          	shr    $0x20,%rcx
    4447:	48 01 f9             	add    %rdi,%rcx
    444a:	48 81 c1 28 02 00 00 	add    $0x228,%rcx
    4451:	80 39 00             	cmpb   $0x0,(%rcx)
    4454:	75 02                	jne    4458 <e9+0x108>
    4456:	59                   	pop    %rcx
    4457:	c3                   	ret
    4458:	e8 03 1e 00 00       	call   6260 <fwp_flush>
    445d:	48 8b 05 7c db 00 00 	mov    0xdb7c(%rip),%rax        # 11fe0 <stderr@GLIBC_2.2.5>
    4464:	48 8b 38             	mov    (%rax),%rdi
    4467:	48 8d 35 bf af 00 00 	lea    0xafbf(%rip),%rsi        # f42d <fwp_segv.msg+0x1ed>
    446e:	48 8d 15 8b af 00 00 	lea    0xaf8b(%rip),%rdx        # f400 <fwp_segv.msg+0x1c0>
    4475:	31 c0                	xor    %eax,%eax
    4477:	e8 34 dd ff ff       	call   21b0 <fprintf@plt>
    447c:	bf 65 00 00 00       	mov    $0x65,%edi
    4481:	e8 0a de ff ff       	call   2290 <exit@plt>
    4486:	66 2e 0f 1f 84 00 00 	cs nopw 0x0(%rax,%rax,1)
    448d:	00 00 00 

0000000000004490 <e12>:
    4490:	50                   	push   %rax
    4491:	48 8b 57 10          	mov    0x10(%rdi),%rdx
    4495:	48 89 d0             	mov    %rdx,%rax
    4498:	48 2b 05 11 ed 00 00 	sub    0xed11(%rip),%rax        # 131b0 <fwp_gc+0x1030>
    449f:	48 8b 0d 32 ed 00 00 	mov    0xed32(%rip),%rcx        # 131d8 <fwp_gc+0x1058>
    44a6:	48 c1 e1 10          	shl    $0x10,%rcx
    44aa:	48 39 c8             	cmp    %rcx,%rax
    44ad:	73 64                	jae    4513 <e12+0x83>
    44af:	48 8b 0d 42 ed 00 00 	mov    0xed42(%rip),%rcx        # 131f8 <fwp_gc+0x1078>
    44b6:	48 89 c6             	mov    %rax,%rsi
    44b9:	48 c1 ee 10          	shr    $0x10,%rsi
    44bd:	48 69 f6 28 12 00 00 	imul   $0x1228,%rsi,%rsi
    44c4:	44 0f b6 04 31       	movzbl (%rcx,%rsi,1),%r8d
    44c9:	48 25 ff ff 00 00    	and    $0xffff,%rax
    44cf:	75 1a                	jne    44eb <e12+0x5b>
    44d1:	41 80 f8 02          	cmp    $0x2,%r8b
    44d5:	75 14                	jne    44eb <e12+0x5b>
    44d7:	48 8d 04 31          	lea    (%rcx,%rsi,1),%rax
    44db:	48 05 28 02 00 00    	add    $0x228,%rax
    44e1:	80 38 00             	cmpb   $0x0,(%rax)
    44e4:	74 2d                	je     4513 <e12+0x83>
    44e6:	e9 b2 00 00 00       	jmp    459d <e12+0x10d>
    44eb:	41 80 f8 01          	cmp    $0x1,%r8b
    44ef:	75 22                	jne    4513 <e12+0x83>
    44f1:	4c 8d 04 31          	lea    (%rcx,%rsi,1),%r8
    44f5:	8b 4c 31 20          	mov    0x20(%rcx,%rsi,1),%ecx
    44f9:	48 0f af c1          	imul   %rcx,%rax
    44fd:	48 c1 e8 20          	shr    $0x20,%rax
    4501:	4c 01 c0             	add    %r8,%rax
    4504:	48 05 28 02 00 00    	add    $0x228,%rax
    450a:	80 38 00             	cmpb   $0x0,(%rax)
    450d:	0f 85 8a 00 00 00    	jne    459d <e12+0x10d>
    4513:	48 8b 07             	mov    (%rdi),%rax
    4516:	48 8b 77 08          	mov    0x8(%rdi),%rsi
    451a:	48 89 c7             	mov    %rax,%rdi
    451d:	e8 0e 2d 00 00       	call   7230 <f12>
    4522:	48 89 c1             	mov    %rax,%rcx
    4525:	48 2b 0d 84 ec 00 00 	sub    0xec84(%rip),%rcx        # 131b0 <fwp_gc+0x1030>
    452c:	48 8b 15 a5 ec 00 00 	mov    0xeca5(%rip),%rdx        # 131d8 <fwp_gc+0x1058>
    4533:	48 c1 e2 10          	shl    $0x10,%rdx
    4537:	48 39 d1             	cmp    %rdx,%rcx
    453a:	73 5f                	jae    459b <e12+0x10b>
    453c:	48 8b 15 b5 ec 00 00 	mov    0xecb5(%rip),%rdx        # 131f8 <fwp_gc+0x1078>
    4543:	48 89 ce             	mov    %rcx,%rsi
    4546:	48 c1 ee 10          	shr    $0x10,%rsi
    454a:	48 69 f6 28 12 00 00 	imul   $0x1228,%rsi,%rsi
    4551:	0f b6 3c 32          	movzbl (%rdx,%rsi,1),%edi
    4555:	48 81 e1 ff ff 00 00 	and    $0xffff,%rcx
    455c:	75 18                	jne    4576 <e12+0xe6>
    455e:	40 80 ff 02          	cmp    $0x2,%dil
    4562:	75 12                	jne    4576 <e12+0xe6>
    4564:	48 8d 0c 32          	lea    (%rdx,%rsi,1),%rcx
    4568:	48 81 c1 28 02 00 00 	add    $0x228,%rcx
    456f:	80 39 00             	cmpb   $0x0,(%rcx)
    4572:	74 27                	je     459b <e12+0x10b>
    4574:	eb 27                	jmp    459d <e12+0x10d>
    4576:	40 80 ff 01          	cmp    $0x1,%dil
    457a:	75 1f                	jne    459b <e12+0x10b>
    457c:	48 8d 3c 32          	lea    (%rdx,%rsi,1),%rdi
    4580:	8b 54 32 20          	mov    0x20(%rdx,%rsi,1),%edx
    4584:	48 0f af ca          	imul   %rdx,%rcx
    4588:	48 c1 e9 20          	shr    $0x20,%rcx
    458c:	48 01 f9             	add    %rdi,%rcx
    458f:	48 81 c1 28 02 00 00 	add    $0x228,%rcx
    4596:	80 39 00             	cmpb   $0x0,(%rcx)
    4599:	75 02                	jne    459d <e12+0x10d>
    459b:	59                   	pop    %rcx
    459c:	c3                   	ret
    459d:	e8 be 1c 00 00       	call   6260 <fwp_flush>
    45a2:	48 8b 05 37 da 00 00 	mov    0xda37(%rip),%rax        # 11fe0 <stderr@GLIBC_2.2.5>
    45a9:	48 8b 38             	mov    (%rax),%rdi
    45ac:	48 8d 35 7a ae 00 00 	lea    0xae7a(%rip),%rsi        # f42d <fwp_segv.msg+0x1ed>
    45b3:	48 8d 15 46 ae 00 00 	lea    0xae46(%rip),%rdx        # f400 <fwp_segv.msg+0x1c0>
    45ba:	31 c0                	xor    %eax,%eax
    45bc:	e8 ef db ff ff       	call   21b0 <fprintf@plt>
    45c1:	bf 65 00 00 00       	mov    $0x65,%edi
    45c6:	e8 c5 dc ff ff       	call   2290 <exit@plt>
    45cb:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)

00000000000045d0 <e15>:
    45d0:	41 56                	push   %r14
    45d2:	53                   	push   %rbx
    45d3:	50                   	push   %rax
    45d4:	48 8b 3f             	mov    (%rdi),%rdi
    45d7:	48 8d 35 32 d7 00 00 	lea    0xd732(%rip),%rsi        # 11d10 <d2>
    45de:	e8 ed 30 00 00       	call   76d0 <fwp_show>
    45e3:	48 89 c1             	mov    %rax,%rcx
    45e6:	48 2b 0d c3 eb 00 00 	sub    0xebc3(%rip),%rcx        # 131b0 <fwp_gc+0x1030>
    45ed:	48 8b 15 e4 eb 00 00 	mov    0xebe4(%rip),%rdx        # 131d8 <fwp_gc+0x1058>
    45f4:	48 c1 e2 10          	shl    $0x10,%rdx
    45f8:	48 39 d1             	cmp    %rdx,%rcx
    45fb:	0f 83 8d 00 00 00    	jae    468e <e15+0xbe>
    4601:	48 8b 35 f0 eb 00 00 	mov    0xebf0(%rip),%rsi        # 131f8 <fwp_gc+0x1078>
    4608:	48 89 cf             	mov    %rcx,%rdi
    460b:	48 c1 ef 10          	shr    $0x10,%rdi
    460f:	4c 69 c7 28 12 00 00 	imul   $0x1228,%rdi,%r8
    4616:	46 0f b6 0c 06       	movzbl (%rsi,%r8,1),%r9d
    461b:	48 89 cf             	mov    %rcx,%rdi
    461e:	48 81 e7 ff ff 00 00 	and    $0xffff,%rdi
    4625:	75 30                	jne    4657 <e15+0x87>
    4627:	41 80 f9 02          	cmp    $0x2,%r9b
    462b:	75 2a                	jne    4657 <e15+0x87>
    462d:	4a 8d 1c 06          	lea    (%rsi,%r8,1),%rbx
    4631:	48 81 c3 28 02 00 00 	add    $0x228,%rbx
    4638:	80 3b ff             	cmpb   $0xff,(%rbx)
    463b:	74 41                	je     467e <e15+0xae>
    463d:	c6 03 01             	movb   $0x1,(%rbx)
    4640:	48 8b 15 91 eb 00 00 	mov    0xeb91(%rip),%rdx        # 131d8 <fwp_gc+0x1058>
    4647:	48 89 c1             	mov    %rax,%rcx
    464a:	48 2b 0d 5f eb 00 00 	sub    0xeb5f(%rip),%rcx        # 131b0 <fwp_gc+0x1030>
    4651:	48 c1 e2 10          	shl    $0x10,%rdx
    4655:	eb 37                	jmp    468e <e15+0xbe>
    4657:	41 80 f9 01          	cmp    $0x1,%r9b
    465b:	75 31                	jne    468e <e15+0xbe>
    465d:	4a 8d 0c 06          	lea    (%rsi,%r8,1),%rcx
    4661:	42 8b 54 06 20       	mov    0x20(%rsi,%r8,1),%edx
    4666:	48 0f af fa          	imul   %rdx,%rdi
    466a:	48 c1 ef 20          	shr    $0x20,%rdi
    466e:	48 8d 1c 0f          	lea    (%rdi,%rcx,1),%rbx
    4672:	48 81 c3 28 02 00 00 	add    $0x228,%rbx
    4679:	80 3b ff             	cmpb   $0xff,(%rbx)
    467c:	75 bf                	jne    463d <e15+0x6d>
    467e:	48 89 df             	mov    %rbx,%rdi
    4681:	49 89 c6             	mov    %rax,%r14
    4684:	e8 07 1c 00 00       	call   6290 <fwp_rc_forget_slot>
    4689:	4c 89 f0             	mov    %r14,%rax
    468c:	eb af                	jmp    463d <e15+0x6d>
    468e:	48 39 d1             	cmp    %rdx,%rcx
    4691:	73 5f                	jae    46f2 <e15+0x122>
    4693:	48 8b 15 5e eb 00 00 	mov    0xeb5e(%rip),%rdx        # 131f8 <fwp_gc+0x1078>
    469a:	48 89 ce             	mov    %rcx,%rsi
    469d:	48 c1 ee 10          	shr    $0x10,%rsi
    46a1:	48 69 f6 28 12 00 00 	imul   $0x1228,%rsi,%rsi
    46a8:	0f b6 3c 32          	movzbl (%rdx,%rsi,1),%edi
    46ac:	48 81 e1 ff ff 00 00 	and    $0xffff,%rcx
    46b3:	75 18                	jne    46cd <e15+0xfd>
    46b5:	40 80 ff 02          	cmp    $0x2,%dil
    46b9:	75 12                	jne    46cd <e15+0xfd>
    46bb:	48 8d 0c 32          	lea    (%rdx,%rsi,1),%rcx
    46bf:	48 81 c1 28 02 00 00 	add    $0x228,%rcx
    46c6:	80 39 00             	cmpb   $0x0,(%rcx)
    46c9:	74 27                	je     46f2 <e15+0x122>
    46cb:	eb 2d                	jmp    46fa <e15+0x12a>
    46cd:	40 80 ff 01          	cmp    $0x1,%dil
    46d1:	75 1f                	jne    46f2 <e15+0x122>
    46d3:	48 8d 3c 32          	lea    (%rdx,%rsi,1),%rdi
    46d7:	8b 54 32 20          	mov    0x20(%rdx,%rsi,1),%edx
    46db:	48 0f af ca          	imul   %rdx,%rcx
    46df:	48 c1 e9 20          	shr    $0x20,%rcx
    46e3:	48 01 f9             	add    %rdi,%rcx
    46e6:	48 81 c1 28 02 00 00 	add    $0x228,%rcx
    46ed:	80 39 00             	cmpb   $0x0,(%rcx)
    46f0:	75 08                	jne    46fa <e15+0x12a>
    46f2:	48 83 c4 08          	add    $0x8,%rsp
    46f6:	5b                   	pop    %rbx
    46f7:	41 5e                	pop    %r14
    46f9:	c3                   	ret
    46fa:	e8 61 1b 00 00       	call   6260 <fwp_flush>
    46ff:	48 8b 05 da d8 00 00 	mov    0xd8da(%rip),%rax        # 11fe0 <stderr@GLIBC_2.2.5>
    4706:	48 8b 38             	mov    (%rax),%rdi
    4709:	48 8d 35 1d ad 00 00 	lea    0xad1d(%rip),%rsi        # f42d <fwp_segv.msg+0x1ed>
    4710:	48 8d 15 e9 ac 00 00 	lea    0xace9(%rip),%rdx        # f400 <fwp_segv.msg+0x1c0>
    4717:	31 c0                	xor    %eax,%eax
    4719:	e8 92 da ff ff       	call   21b0 <fprintf@plt>
    471e:	bf 65 00 00 00       	mov    $0x65,%edi
    4723:	e8 68 db ff ff       	call   2290 <exit@plt>
    4728:	0f 1f 84 00 00 00 00 	nopl   0x0(%rax,%rax,1)
    472f:	00 

0000000000004730 <e16>:
    4730:	50                   	push   %rax
    4731:	48 8b 3f             	mov    (%rdi),%rdi
    4734:	48 89 f8             	mov    %rdi,%rax
    4737:	48 2b 05 72 ea 00 00 	sub    0xea72(%rip),%rax        # 131b0 <fwp_gc+0x1030>
    473e:	48 8b 0d 93 ea 00 00 	mov    0xea93(%rip),%rcx        # 131d8 <fwp_gc+0x1058>
    4745:	48 c1 e1 10          	shl    $0x10,%rcx
    4749:	48 39 c8             	cmp    %rcx,%rax
    474c:	73 63                	jae    47b1 <e16+0x81>
    474e:	48 8b 0d a3 ea 00 00 	mov    0xeaa3(%rip),%rcx        # 131f8 <fwp_gc+0x1078>
    4755:	48 89 c2             	mov    %rax,%rdx
    4758:	48 c1 ea 10          	shr    $0x10,%rdx
    475c:	48 69 d2 28 12 00 00 	imul   $0x1228,%rdx,%rdx
    4763:	0f b6 34 11          	movzbl (%rcx,%rdx,1),%esi
    4767:	48 25 ff ff 00 00    	and    $0xffff,%rax
    476d:	75 1a                	jne    4789 <e16+0x59>
    476f:	40 80 fe 02          	cmp    $0x2,%sil
    4773:	75 14                	jne    4789 <e16+0x59>
    4775:	48 8d 04 11          	lea    (%rcx,%rdx,1),%rax
    4779:	48 05 28 02 00 00    	add    $0x228,%rax
    477f:	80 38 00             	cmpb   $0x0,(%rax)
    4782:	74 2d                	je     47b1 <e16+0x81>
    4784:	e9 ca 00 00 00       	jmp    4853 <e16+0x123>
    4789:	40 80 fe 01          	cmp    $0x1,%sil
    478d:	75 22                	jne    47b1 <e16+0x81>
    478f:	48 8d 34 11          	lea    (%rcx,%rdx,1),%rsi
    4793:	8b 4c 11 20          	mov    0x20(%rcx,%rdx,1),%ecx
    4797:	48 0f af c1          	imul   %rcx,%rax
    479b:	48 c1 e8 20          	shr    $0x20,%rax
    479f:	48 01 f0             	add    %rsi,%rax
    47a2:	48 05 28 02 00 00    	add    $0x228,%rax
    47a8:	80 38 00             	cmpb   $0x0,(%rax)
    47ab:	0f 85 a2 00 00 00    	jne    4853 <e16+0x123>
    47b1:	48 8b 17             	mov    (%rdi),%rdx
    47b4:	48 83 c7 08          	add    $0x8,%rdi
    47b8:	48 8b 0d 09 f4 00 00 	mov    0xf409(%rip),%rcx        # 13bc8 <fwp_prog_out>
    47bf:	be 01 00 00 00       	mov    $0x1,%esi
    47c4:	e8 d7 da ff ff       	call   22a0 <fwrite@plt>
    47c9:	48 8b 35 f8 f3 00 00 	mov    0xf3f8(%rip),%rsi        # 13bc8 <fwp_prog_out>
    47d0:	bf 0a 00 00 00       	mov    $0xa,%edi
    47d5:	e8 66 d9 ff ff       	call   2140 <fputc@plt>
    47da:	31 c0                	xor    %eax,%eax
    47dc:	48 2b 05 cd e9 00 00 	sub    0xe9cd(%rip),%rax        # 131b0 <fwp_gc+0x1030>
    47e3:	48 8b 0d ee e9 00 00 	mov    0xe9ee(%rip),%rcx        # 131d8 <fwp_gc+0x1058>
    47ea:	48 c1 e1 10          	shl    $0x10,%rcx
    47ee:	48 39 c1             	cmp    %rax,%rcx
    47f1:	76 5c                	jbe    484f <e16+0x11f>
    47f3:	48 8b 0d fe e9 00 00 	mov    0xe9fe(%rip),%rcx        # 131f8 <fwp_gc+0x1078>
    47fa:	48 89 c2             	mov    %rax,%rdx
    47fd:	48 c1 ea 10          	shr    $0x10,%rdx
    4801:	48 69 d2 28 12 00 00 	imul   $0x1228,%rdx,%rdx
    4808:	0f b6 34 11          	movzbl (%rcx,%rdx,1),%esi
    480c:	48 25 ff ff 00 00    	and    $0xffff,%rax
    4812:	75 17                	jne    482b <e16+0xfb>
    4814:	40 80 fe 02          	cmp    $0x2,%sil
    4818:	75 11                	jne    482b <e16+0xfb>
    481a:	48 8d 04 11          	lea    (%rcx,%rdx,1),%rax
    481e:	48 05 28 02 00 00    	add    $0x228,%rax
    4824:	80 38 00             	cmpb   $0x0,(%rax)
    4827:	74 26                	je     484f <e16+0x11f>
    4829:	eb 28                	jmp    4853 <e16+0x123>
    482b:	40 80 fe 01          	cmp    $0x1,%sil
    482f:	75 1e                	jne    484f <e16+0x11f>
    4831:	48 8d 34 11          	lea    (%rcx,%rdx,1),%rsi
    4835:	8b 4c 11 20          	mov    0x20(%rcx,%rdx,1),%ecx
    4839:	48 0f af c1          	imul   %rcx,%rax
    483d:	48 c1 e8 20          	shr    $0x20,%rax
    4841:	48 01 f0             	add    %rsi,%rax
    4844:	48 05 28 02 00 00    	add    $0x228,%rax
    484a:	80 38 00             	cmpb   $0x0,(%rax)
    484d:	75 04                	jne    4853 <e16+0x123>
    484f:	31 c0                	xor    %eax,%eax
    4851:	59                   	pop    %rcx
    4852:	c3                   	ret
    4853:	e8 08 1a 00 00       	call   6260 <fwp_flush>
    4858:	48 8b 05 81 d7 00 00 	mov    0xd781(%rip),%rax        # 11fe0 <stderr@GLIBC_2.2.5>
    485f:	48 8b 38             	mov    (%rax),%rdi
    4862:	48 8d 35 c4 ab 00 00 	lea    0xabc4(%rip),%rsi        # f42d <fwp_segv.msg+0x1ed>
    4869:	48 8d 15 90 ab 00 00 	lea    0xab90(%rip),%rdx        # f400 <fwp_segv.msg+0x1c0>
    4870:	31 c0                	xor    %eax,%eax
    4872:	e8 39 d9 ff ff       	call   21b0 <fprintf@plt>
    4877:	bf 65 00 00 00       	mov    $0x65,%edi
    487c:	e8 0f da ff ff       	call   2290 <exit@plt>
    4881:	66 66 66 66 66 66 2e 	data16 data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    4888:	0f 1f 84 00 00 00 00 
    488f:	00 

0000000000004890 <e24>:
    4890:	f3 0f 6f 07          	movdqu (%rdi),%xmm0
    4894:	66 0f 70 c8 aa       	pshufd $0xaa,%xmm0,%xmm1
    4899:	0f 58 c8             	addps  %xmm0,%xmm1
    489c:	66 0f 7e c8          	movd   %xmm1,%eax
    48a0:	48 89 c1             	mov    %rax,%rcx
    48a3:	48 2b 0d 06 e9 00 00 	sub    0xe906(%rip),%rcx        # 131b0 <fwp_gc+0x1030>
    48aa:	48 8b 15 27 e9 00 00 	mov    0xe927(%rip),%rdx        # 131d8 <fwp_gc+0x1058>
    48b1:	48 c1 e2 10          	shl    $0x10,%rdx
    48b5:	48 39 d1             	cmp    %rdx,%rcx
    48b8:	73 5f                	jae    4919 <e24+0x89>
    48ba:	48 8b 15 37 e9 00 00 	mov    0xe937(%rip),%rdx        # 131f8 <fwp_gc+0x1078>
    48c1:	48 89 ce             	mov    %rcx,%rsi
    48c4:	48 c1 ee 10          	shr    $0x10,%rsi
    48c8:	48 69 f6 28 12 00 00 	imul   $0x1228,%rsi,%rsi
    48cf:	0f b6 3c 32          	movzbl (%rdx,%rsi,1),%edi
    48d3:	48 81 e1 ff ff 00 00 	and    $0xffff,%rcx
    48da:	75 18                	jne    48f4 <e24+0x64>
    48dc:	40 80 ff 02          	cmp    $0x2,%dil
    48e0:	75 12                	jne    48f4 <e24+0x64>
    48e2:	48 8d 0c 32          	lea    (%rdx,%rsi,1),%rcx
    48e6:	48 81 c1 28 02 00 00 	add    $0x228,%rcx
    48ed:	80 39 00             	cmpb   $0x0,(%rcx)
    48f0:	74 27                	je     4919 <e24+0x89>
    48f2:	eb 26                	jmp    491a <e24+0x8a>
    48f4:	40 80 ff 01          	cmp    $0x1,%dil
    48f8:	75 1f                	jne    4919 <e24+0x89>
    48fa:	48 8d 3c 32          	lea    (%rdx,%rsi,1),%rdi
    48fe:	8b 54 32 20          	mov    0x20(%rdx,%rsi,1),%edx
    4902:	48 0f af ca          	imul   %rdx,%rcx
    4906:	48 c1 e9 20          	shr    $0x20,%rcx
    490a:	48 01 f9             	add    %rdi,%rcx
    490d:	48 81 c1 28 02 00 00 	add    $0x228,%rcx
    4914:	80 39 00             	cmpb   $0x0,(%rcx)
    4917:	75 01                	jne    491a <e24+0x8a>
    4919:	c3                   	ret
    491a:	50                   	push   %rax
    491b:	e8 40 19 00 00       	call   6260 <fwp_flush>
    4920:	48 8b 05 b9 d6 00 00 	mov    0xd6b9(%rip),%rax        # 11fe0 <stderr@GLIBC_2.2.5>
    4927:	48 8b 38             	mov    (%rax),%rdi
    492a:	48 8d 35 fc aa 00 00 	lea    0xaafc(%rip),%rsi        # f42d <fwp_segv.msg+0x1ed>
    4931:	48 8d 15 c8 aa 00 00 	lea    0xaac8(%rip),%rdx        # f400 <fwp_segv.msg+0x1c0>
    4938:	31 c0                	xor    %eax,%eax
    493a:	e8 71 d8 ff ff       	call   21b0 <fprintf@plt>
    493f:	bf 65 00 00 00       	mov    $0x65,%edi
    4944:	e8 47 d9 ff ff       	call   2290 <exit@plt>
    4949:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)

0000000000004950 <e25>:
    4950:	f3 0f 6f 07          	movdqu (%rdi),%xmm0
    4954:	66 0f 70 c8 aa       	pshufd $0xaa,%xmm0,%xmm1
    4959:	0f 59 c8             	mulps  %xmm0,%xmm1
    495c:	66 0f 7e c8          	movd   %xmm1,%eax
    4960:	48 89 c1             	mov    %rax,%rcx
    4963:	48 2b 0d 46 e8 00 00 	sub    0xe846(%rip),%rcx        # 131b0 <fwp_gc+0x1030>
    496a:	48 8b 15 67 e8 00 00 	mov    0xe867(%rip),%rdx        # 131d8 <fwp_gc+0x1058>
    4971:	48 c1 e2 10          	shl    $0x10,%rdx
    4975:	48 39 d1             	cmp    %rdx,%rcx
    4978:	73 5f                	jae    49d9 <e25+0x89>
    497a:	48 8b 15 77 e8 00 00 	mov    0xe877(%rip),%rdx        # 131f8 <fwp_gc+0x1078>
    4981:	48 89 ce             	mov    %rcx,%rsi
    4984:	48 c1 ee 10          	shr    $0x10,%rsi
    4988:	48 69 f6 28 12 00 00 	imul   $0x1228,%rsi,%rsi
    498f:	0f b6 3c 32          	movzbl (%rdx,%rsi,1),%edi
    4993:	48 81 e1 ff ff 00 00 	and    $0xffff,%rcx
    499a:	75 18                	jne    49b4 <e25+0x64>
    499c:	40 80 ff 02          	cmp    $0x2,%dil
    49a0:	75 12                	jne    49b4 <e25+0x64>
    49a2:	48 8d 0c 32          	lea    (%rdx,%rsi,1),%rcx
    49a6:	48 81 c1 28 02 00 00 	add    $0x228,%rcx
    49ad:	80 39 00             	cmpb   $0x0,(%rcx)
    49b0:	74 27                	je     49d9 <e25+0x89>
    49b2:	eb 26                	jmp    49da <e25+0x8a>
    49b4:	40 80 ff 01          	cmp    $0x1,%dil
    49b8:	75 1f                	jne    49d9 <e25+0x89>
    49ba:	48 8d 3c 32          	lea    (%rdx,%rsi,1),%rdi
    49be:	8b 54 32 20          	mov    0x20(%rdx,%rsi,1),%edx
    49c2:	48 0f af ca          	imul   %rdx,%rcx
    49c6:	48 c1 e9 20          	shr    $0x20,%rcx
    49ca:	48 01 f9             	add    %rdi,%rcx
    49cd:	48 81 c1 28 02 00 00 	add    $0x228,%rcx
    49d4:	80 39 00             	cmpb   $0x0,(%rcx)
    49d7:	75 01                	jne    49da <e25+0x8a>
    49d9:	c3                   	ret
    49da:	50                   	push   %rax
    49db:	e8 80 18 00 00       	call   6260 <fwp_flush>
    49e0:	48 8b 05 f9 d5 00 00 	mov    0xd5f9(%rip),%rax        # 11fe0 <stderr@GLIBC_2.2.5>
    49e7:	48 8b 38             	mov    (%rax),%rdi
    49ea:	48 8d 35 3c aa 00 00 	lea    0xaa3c(%rip),%rsi        # f42d <fwp_segv.msg+0x1ed>
    49f1:	48 8d 15 08 aa 00 00 	lea    0xaa08(%rip),%rdx        # f400 <fwp_segv.msg+0x1c0>
    49f8:	31 c0                	xor    %eax,%eax
    49fa:	e8 b1 d7 ff ff       	call   21b0 <fprintf@plt>
    49ff:	bf 65 00 00 00       	mov    $0x65,%edi
    4a04:	e8 87 d8 ff ff       	call   2290 <exit@plt>
    4a09:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)

0000000000004a10 <e26>:
    4a10:	41 56                	push   %r14
    4a12:	53                   	push   %rbx
    4a13:	50                   	push   %rax
    4a14:	48 8b 3f             	mov    (%rdi),%rdi
    4a17:	e8 a4 50 00 00       	call   9ac0 <fwp_show_i64>
    4a1c:	48 89 c1             	mov    %rax,%rcx
    4a1f:	48 2b 0d 8a e7 00 00 	sub    0xe78a(%rip),%rcx        # 131b0 <fwp_gc+0x1030>
    4a26:	48 8b 15 ab e7 00 00 	mov    0xe7ab(%rip),%rdx        # 131d8 <fwp_gc+0x1058>
    4a2d:	48 c1 e2 10          	shl    $0x10,%rdx
    4a31:	48 39 d1             	cmp    %rdx,%rcx
    4a34:	0f 83 8d 00 00 00    	jae    4ac7 <e26+0xb7>
    4a3a:	48 8b 35 b7 e7 00 00 	mov    0xe7b7(%rip),%rsi        # 131f8 <fwp_gc+0x1078>
    4a41:	48 89 cf             	mov    %rcx,%rdi
    4a44:	48 c1 ef 10          	shr    $0x10,%rdi
    4a48:	4c 69 c7 28 12 00 00 	imul   $0x1228,%rdi,%r8
    4a4f:	46 0f b6 0c 06       	movzbl (%rsi,%r8,1),%r9d
    4a54:	48 89 cf             	mov    %rcx,%rdi
    4a57:	48 81 e7 ff ff 00 00 	and    $0xffff,%rdi
    4a5e:	75 30                	jne    4a90 <e26+0x80>
    4a60:	41 80 f9 02          	cmp    $0x2,%r9b
    4a64:	75 2a                	jne    4a90 <e26+0x80>
    4a66:	4a 8d 1c 06          	lea    (%rsi,%r8,1),%rbx
    4a6a:	48 81 c3 28 02 00 00 	add    $0x228,%rbx
    4a71:	80 3b ff             	cmpb   $0xff,(%rbx)
    4a74:	74 41                	je     4ab7 <e26+0xa7>
    4a76:	c6 03 01             	movb   $0x1,(%rbx)
    4a79:	48 8b 15 58 e7 00 00 	mov    0xe758(%rip),%rdx        # 131d8 <fwp_gc+0x1058>
    4a80:	48 89 c1             	mov    %rax,%rcx
    4a83:	48 2b 0d 26 e7 00 00 	sub    0xe726(%rip),%rcx        # 131b0 <fwp_gc+0x1030>
    4a8a:	48 c1 e2 10          	shl    $0x10,%rdx
    4a8e:	eb 37                	jmp    4ac7 <e26+0xb7>
    4a90:	41 80 f9 01          	cmp    $0x1,%r9b
    4a94:	75 31                	jne    4ac7 <e26+0xb7>
    4a96:	4a 8d 0c 06          	lea    (%rsi,%r8,1),%rcx
    4a9a:	42 8b 54 06 20       	mov    0x20(%rsi,%r8,1),%edx
    4a9f:	48 0f af fa          	imul   %rdx,%rdi
    4aa3:	48 c1 ef 20          	shr    $0x20,%rdi
    4aa7:	48 8d 1c 0f          	lea    (%rdi,%rcx,1),%rbx
    4aab:	48 81 c3 28 02 00 00 	add    $0x228,%rbx
    4ab2:	80 3b ff             	cmpb   $0xff,(%rbx)
    4ab5:	75 bf                	jne    4a76 <e26+0x66>
    4ab7:	48 89 df             	mov    %rbx,%rdi
    4aba:	49 89 c6             	mov    %rax,%r14
    4abd:	e8 ce 17 00 00       	call   6290 <fwp_rc_forget_slot>
    4ac2:	4c 89 f0             	mov    %r14,%rax
    4ac5:	eb af                	jmp    4a76 <e26+0x66>
    4ac7:	48 39 d1             	cmp    %rdx,%rcx
    4aca:	73 5f                	jae    4b2b <e26+0x11b>
    4acc:	48 8b 15 25 e7 00 00 	mov    0xe725(%rip),%rdx        # 131f8 <fwp_gc+0x1078>
    4ad3:	48 89 ce             	mov    %rcx,%rsi
    4ad6:	48 c1 ee 10          	shr    $0x10,%rsi
    4ada:	48 69 f6 28 12 00 00 	imul   $0x1228,%rsi,%rsi
    4ae1:	0f b6 3c 32          	movzbl (%rdx,%rsi,1),%edi
    4ae5:	48 81 e1 ff ff 00 00 	and    $0xffff,%rcx
    4aec:	75 18                	jne    4b06 <e26+0xf6>
    4aee:	40 80 ff 02          	cmp    $0x2,%dil
    4af2:	75 12                	jne    4b06 <e26+0xf6>
    4af4:	48 8d 0c 32          	lea    (%rdx,%rsi,1),%rcx
    4af8:	48 81 c1 28 02 00 00 	add    $0x228,%rcx
    4aff:	80 39 00             	cmpb   $0x0,(%rcx)
    4b02:	74 27                	je     4b2b <e26+0x11b>
    4b04:	eb 2d                	jmp    4b33 <e26+0x123>
    4b06:	40 80 ff 01          	cmp    $0x1,%dil
    4b0a:	75 1f                	jne    4b2b <e26+0x11b>
    4b0c:	48 8d 3c 32          	lea    (%rdx,%rsi,1),%rdi
    4b10:	8b 54 32 20          	mov    0x20(%rdx,%rsi,1),%edx
    4b14:	48 0f af ca          	imul   %rdx,%rcx
    4b18:	48 c1 e9 20          	shr    $0x20,%rcx
    4b1c:	48 01 f9             	add    %rdi,%rcx
    4b1f:	48 81 c1 28 02 00 00 	add    $0x228,%rcx
    4b26:	80 39 00             	cmpb   $0x0,(%rcx)
    4b29:	75 08                	jne    4b33 <e26+0x123>
    4b2b:	48 83 c4 08          	add    $0x8,%rsp
    4b2f:	5b                   	pop    %rbx
    4b30:	41 5e                	pop    %r14
    4b32:	c3                   	ret
    4b33:	e8 28 17 00 00       	call   6260 <fwp_flush>
    4b38:	48 8b 05 a1 d4 00 00 	mov    0xd4a1(%rip),%rax        # 11fe0 <stderr@GLIBC_2.2.5>
    4b3f:	48 8b 38             	mov    (%rax),%rdi
    4b42:	48 8d 35 e4 a8 00 00 	lea    0xa8e4(%rip),%rsi        # f42d <fwp_segv.msg+0x1ed>
    4b49:	48 8d 15 b0 a8 00 00 	lea    0xa8b0(%rip),%rdx        # f400 <fwp_segv.msg+0x1c0>
    4b50:	31 c0                	xor    %eax,%eax
    4b52:	e8 59 d6 ff ff       	call   21b0 <fprintf@plt>
    4b57:	bf 65 00 00 00       	mov    $0x65,%edi
    4b5c:	e8 2f d7 ff ff       	call   2290 <exit@plt>
    4b61:	66 66 66 66 66 66 2e 	data16 data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    4b68:	0f 1f 84 00 00 00 00 
    4b6f:	00 

0000000000004b70 <e32>:
    4b70:	53                   	push   %rbx
    4b71:	48 83 ec 60          	sub    $0x60,%rsp
    4b75:	48 8b 47 08          	mov    0x8(%rdi),%rax
    4b79:	48 03 07             	add    (%rdi),%rax
    4b7c:	48 0f be c8          	movsbq %al,%rcx
    4b80:	48 39 c1             	cmp    %rax,%rcx
    4b83:	75 7f                	jne    4c04 <e32+0x94>
    4b85:	48 89 c1             	mov    %rax,%rcx
    4b88:	48 2b 0d 21 e6 00 00 	sub    0xe621(%rip),%rcx        # 131b0 <fwp_gc+0x1030>
    4b8f:	48 8b 15 42 e6 00 00 	mov    0xe642(%rip),%rdx        # 131d8 <fwp_gc+0x1058>
    4b96:	48 c1 e2 10          	shl    $0x10,%rdx
    4b9a:	48 39 d1             	cmp    %rdx,%rcx
    4b9d:	73 5f                	jae    4bfe <e32+0x8e>
    4b9f:	48 8b 15 52 e6 00 00 	mov    0xe652(%rip),%rdx        # 131f8 <fwp_gc+0x1078>
    4ba6:	48 89 ce             	mov    %rcx,%rsi
    4ba9:	48 c1 ee 10          	shr    $0x10,%rsi
    4bad:	48 69 f6 28 12 00 00 	imul   $0x1228,%rsi,%rsi
    4bb4:	0f b6 3c 32          	movzbl (%rdx,%rsi,1),%edi
    4bb8:	48 81 e1 ff ff 00 00 	and    $0xffff,%rcx
    4bbf:	75 18                	jne    4bd9 <e32+0x69>
    4bc1:	40 80 ff 02          	cmp    $0x2,%dil
    4bc5:	75 12                	jne    4bd9 <e32+0x69>
    4bc7:	48 8d 0c 32          	lea    (%rdx,%rsi,1),%rcx
    4bcb:	48 81 c1 28 02 00 00 	add    $0x228,%rcx
    4bd2:	80 39 00             	cmpb   $0x0,(%rcx)
    4bd5:	74 27                	je     4bfe <e32+0x8e>
    4bd7:	eb 66                	jmp    4c3f <e32+0xcf>
    4bd9:	40 80 ff 01          	cmp    $0x1,%dil
    4bdd:	75 1f                	jne    4bfe <e32+0x8e>
    4bdf:	48 8d 3c 32          	lea    (%rdx,%rsi,1),%rdi
    4be3:	8b 54 32 20          	mov    0x20(%rdx,%rsi,1),%edx
    4be7:	48 0f af ca          	imul   %rdx,%rcx
    4beb:	48 c1 e9 20          	shr    $0x20,%rcx
    4bef:	48 01 f9             	add    %rdi,%rcx
    4bf2:	48 81 c1 28 02 00 00 	add    $0x228,%rcx
    4bf9:	80 39 00             	cmpb   $0x0,(%rcx)
    4bfc:	75 41                	jne    4c3f <e32+0xcf>
    4bfe:	48 83 c4 60          	add    $0x60,%rsp
    4c02:	5b                   	pop    %rbx
    4c03:	c3                   	ret
    4c04:	48 8d 15 80 aa 00 00 	lea    0xaa80(%rip),%rdx        # f68b <fwp_segv.msg+0x44b>
    4c0b:	48 8d 0d 91 a9 00 00 	lea    0xa991(%rip),%rcx        # f5a3 <fwp_segv.msg+0x363>
    4c12:	48 89 e3             	mov    %rsp,%rbx
    4c15:	be 60 00 00 00       	mov    $0x60,%esi
    4c1a:	48 89 df             	mov    %rbx,%rdi
    4c1d:	31 c0                	xor    %eax,%eax
    4c1f:	e8 ec d4 ff ff       	call   2110 <snprintf@plt>
    4c24:	e8 37 16 00 00       	call   6260 <fwp_flush>
    4c29:	48 8b 05 b0 d3 00 00 	mov    0xd3b0(%rip),%rax        # 11fe0 <stderr@GLIBC_2.2.5>
    4c30:	48 8b 38             	mov    (%rax),%rdi
    4c33:	48 8d 35 f3 a7 00 00 	lea    0xa7f3(%rip),%rsi        # f42d <fwp_segv.msg+0x1ed>
    4c3a:	48 89 da             	mov    %rbx,%rdx
    4c3d:	eb 1d                	jmp    4c5c <e32+0xec>
    4c3f:	e8 1c 16 00 00       	call   6260 <fwp_flush>
    4c44:	48 8b 05 95 d3 00 00 	mov    0xd395(%rip),%rax        # 11fe0 <stderr@GLIBC_2.2.5>
    4c4b:	48 8b 38             	mov    (%rax),%rdi
    4c4e:	48 8d 35 d8 a7 00 00 	lea    0xa7d8(%rip),%rsi        # f42d <fwp_segv.msg+0x1ed>
    4c55:	48 8d 15 a4 a7 00 00 	lea    0xa7a4(%rip),%rdx        # f400 <fwp_segv.msg+0x1c0>
    4c5c:	31 c0                	xor    %eax,%eax
    4c5e:	e8 4d d5 ff ff       	call   21b0 <fprintf@plt>
    4c63:	bf 65 00 00 00       	mov    $0x65,%edi
    4c68:	e8 23 d6 ff ff       	call   2290 <exit@plt>
    4c6d:	0f 1f 00             	nopl   (%rax)

0000000000004c70 <e33>:
    4c70:	41 56                	push   %r14
    4c72:	53                   	push   %rbx
    4c73:	50                   	push   %rax
    4c74:	48 8b 3f             	mov    (%rdi),%rdi
    4c77:	e8 44 4e 00 00       	call   9ac0 <fwp_show_i64>
    4c7c:	48 89 c1             	mov    %rax,%rcx
    4c7f:	48 2b 0d 2a e5 00 00 	sub    0xe52a(%rip),%rcx        # 131b0 <fwp_gc+0x1030>
    4c86:	48 8b 15 4b e5 00 00 	mov    0xe54b(%rip),%rdx        # 131d8 <fwp_gc+0x1058>
    4c8d:	48 c1 e2 10          	shl    $0x10,%rdx
    4c91:	48 39 d1             	cmp    %rdx,%rcx
    4c94:	0f 83 8d 00 00 00    	jae    4d27 <e33+0xb7>
    4c9a:	48 8b 35 57 e5 00 00 	mov    0xe557(%rip),%rsi        # 131f8 <fwp_gc+0x1078>
    4ca1:	48 89 cf             	mov    %rcx,%rdi
    4ca4:	48 c1 ef 10          	shr    $0x10,%rdi
    4ca8:	4c 69 c7 28 12 00 00 	imul   $0x1228,%rdi,%r8
    4caf:	46 0f b6 0c 06       	movzbl (%rsi,%r8,1),%r9d
    4cb4:	48 89 cf             	mov    %rcx,%rdi
    4cb7:	48 81 e7 ff ff 00 00 	and    $0xffff,%rdi
    4cbe:	75 30                	jne    4cf0 <e33+0x80>
    4cc0:	41 80 f9 02          	cmp    $0x2,%r9b
    4cc4:	75 2a                	jne    4cf0 <e33+0x80>
    4cc6:	4a 8d 1c 06          	lea    (%rsi,%r8,1),%rbx
    4cca:	48 81 c3 28 02 00 00 	add    $0x228,%rbx
    4cd1:	80 3b ff             	cmpb   $0xff,(%rbx)
    4cd4:	74 41                	je     4d17 <e33+0xa7>
    4cd6:	c6 03 01             	movb   $0x1,(%rbx)
    4cd9:	48 8b 15 f8 e4 00 00 	mov    0xe4f8(%rip),%rdx        # 131d8 <fwp_gc+0x1058>
    4ce0:	48 89 c1             	mov    %rax,%rcx
    4ce3:	48 2b 0d c6 e4 00 00 	sub    0xe4c6(%rip),%rcx        # 131b0 <fwp_gc+0x1030>
    4cea:	48 c1 e2 10          	shl    $0x10,%rdx
    4cee:	eb 37                	jmp    4d27 <e33+0xb7>
    4cf0:	41 80 f9 01          	cmp    $0x1,%r9b
    4cf4:	75 31                	jne    4d27 <e33+0xb7>
    4cf6:	4a 8d 0c 06          	lea    (%rsi,%r8,1),%rcx
    4cfa:	42 8b 54 06 20       	mov    0x20(%rsi,%r8,1),%edx
    4cff:	48 0f af fa          	imul   %rdx,%rdi
    4d03:	48 c1 ef 20          	shr    $0x20,%rdi
    4d07:	48 8d 1c 0f          	lea    (%rdi,%rcx,1),%rbx
    4d0b:	48 81 c3 28 02 00 00 	add    $0x228,%rbx
    4d12:	80 3b ff             	cmpb   $0xff,(%rbx)
    4d15:	75 bf                	jne    4cd6 <e33+0x66>
    4d17:	48 89 df             	mov    %rbx,%rdi
    4d1a:	49 89 c6             	mov    %rax,%r14
    4d1d:	e8 6e 15 00 00       	call   6290 <fwp_rc_forget_slot>
    4d22:	4c 89 f0             	mov    %r14,%rax
    4d25:	eb af                	jmp    4cd6 <e33+0x66>
    4d27:	48 39 d1             	cmp    %rdx,%rcx
    4d2a:	73 5f                	jae    4d8b <e33+0x11b>
    4d2c:	48 8b 15 c5 e4 00 00 	mov    0xe4c5(%rip),%rdx        # 131f8 <fwp_gc+0x1078>
    4d33:	48 89 ce             	mov    %rcx,%rsi
    4d36:	48 c1 ee 10          	shr    $0x10,%rsi
    4d3a:	48 69 f6 28 12 00 00 	imul   $0x1228,%rsi,%rsi
    4d41:	0f b6 3c 32          	movzbl (%rdx,%rsi,1),%edi
    4d45:	48 81 e1 ff ff 00 00 	and    $0xffff,%rcx
    4d4c:	75 18                	jne    4d66 <e33+0xf6>
    4d4e:	40 80 ff 02          	cmp    $0x2,%dil
    4d52:	75 12                	jne    4d66 <e33+0xf6>
    4d54:	48 8d 0c 32          	lea    (%rdx,%rsi,1),%rcx
    4d58:	48 81 c1 28 02 00 00 	add    $0x228,%rcx
    4d5f:	80 39 00             	cmpb   $0x0,(%rcx)
    4d62:	74 27                	je     4d8b <e33+0x11b>
    4d64:	eb 2d                	jmp    4d93 <e33+0x123>
    4d66:	40 80 ff 01          	cmp    $0x1,%dil
    4d6a:	75 1f                	jne    4d8b <e33+0x11b>
    4d6c:	48 8d 3c 32          	lea    (%rdx,%rsi,1),%rdi
    4d70:	8b 54 32 20          	mov    0x20(%rdx,%rsi,1),%edx
    4d74:	48 0f af ca          	imul   %rdx,%rcx
    4d78:	48 c1 e9 20          	shr    $0x20,%rcx
    4d7c:	48 01 f9             	add    %rdi,%rcx
    4d7f:	48 81 c1 28 02 00 00 	add    $0x228,%rcx
    4d86:	80 39 00             	cmpb   $0x0,(%rcx)
    4d89:	75 08                	jne    4d93 <e33+0x123>
    4d8b:	48 83 c4 08          	add    $0x8,%rsp
    4d8f:	5b                   	pop    %rbx
    4d90:	41 5e                	pop    %r14
    4d92:	c3                   	ret
    4d93:	e8 c8 14 00 00       	call   6260 <fwp_flush>
    4d98:	48 8b 05 41 d2 00 00 	mov    0xd241(%rip),%rax        # 11fe0 <stderr@GLIBC_2.2.5>
    4d9f:	48 8b 38             	mov    (%rax),%rdi
    4da2:	48 8d 35 84 a6 00 00 	lea    0xa684(%rip),%rsi        # f42d <fwp_segv.msg+0x1ed>
    4da9:	48 8d 15 50 a6 00 00 	lea    0xa650(%rip),%rdx        # f400 <fwp_segv.msg+0x1c0>
    4db0:	31 c0                	xor    %eax,%eax
    4db2:	e8 f9 d3 ff ff       	call   21b0 <fprintf@plt>
    4db7:	bf 65 00 00 00       	mov    $0x65,%edi
    4dbc:	e8 cf d4 ff ff       	call   2290 <exit@plt>
    4dc1:	66 66 66 66 66 66 2e 	data16 data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    4dc8:	0f 1f 84 00 00 00 00 
    4dcf:	00 

0000000000004dd0 <e37>:
    4dd0:	41 56                	push   %r14
    4dd2:	53                   	push   %rbx
    4dd3:	50                   	push   %rax
    4dd4:	48 8b 3f             	mov    (%rdi),%rdi
    4dd7:	48 8d 35 72 ce 00 00 	lea    0xce72(%rip),%rsi        # 11c50 <d0>
    4dde:	e8 ed 28 00 00       	call   76d0 <fwp_show>
    4de3:	48 89 c1             	mov    %rax,%rcx
    4de6:	48 2b 0d c3 e3 00 00 	sub    0xe3c3(%rip),%rcx        # 131b0 <fwp_gc+0x1030>
    4ded:	48 8b 15 e4 e3 00 00 	mov    0xe3e4(%rip),%rdx        # 131d8 <fwp_gc+0x1058>
    4df4:	48 c1 e2 10          	shl    $0x10,%rdx
    4df8:	48 39 d1             	cmp    %rdx,%rcx
    4dfb:	0f 83 8d 00 00 00    	jae    4e8e <e37+0xbe>
    4e01:	48 8b 35 f0 e3 00 00 	mov    0xe3f0(%rip),%rsi        # 131f8 <fwp_gc+0x1078>
    4e08:	48 89 cf             	mov    %rcx,%rdi
    4e0b:	48 c1 ef 10          	shr    $0x10,%rdi
    4e0f:	4c 69 c7 28 12 00 00 	imul   $0x1228,%rdi,%r8
    4e16:	46 0f b6 0c 06       	movzbl (%rsi,%r8,1),%r9d
    4e1b:	48 89 cf             	mov    %rcx,%rdi
    4e1e:	48 81 e7 ff ff 00 00 	and    $0xffff,%rdi
    4e25:	75 30                	jne    4e57 <e37+0x87>
    4e27:	41 80 f9 02          	cmp    $0x2,%r9b
    4e2b:	75 2a                	jne    4e57 <e37+0x87>
    4e2d:	4a 8d 1c 06          	lea    (%rsi,%r8,1),%rbx
    4e31:	48 81 c3 28 02 00 00 	add    $0x228,%rbx
    4e38:	80 3b ff             	cmpb   $0xff,(%rbx)
    4e3b:	74 41                	je     4e7e <e37+0xae>
    4e3d:	c6 03 01             	movb   $0x1,(%rbx)
    4e40:	48 8b 15 91 e3 00 00 	mov    0xe391(%rip),%rdx        # 131d8 <fwp_gc+0x1058>
    4e47:	48 89 c1             	mov    %rax,%rcx
    4e4a:	48 2b 0d 5f e3 00 00 	sub    0xe35f(%rip),%rcx        # 131b0 <fwp_gc+0x1030>
    4e51:	48 c1 e2 10          	shl    $0x10,%rdx
    4e55:	eb 37                	jmp    4e8e <e37+0xbe>
    4e57:	41 80 f9 01          	cmp    $0x1,%r9b
    4e5b:	75 31                	jne    4e8e <e37+0xbe>
    4e5d:	4a 8d 0c 06          	lea    (%rsi,%r8,1),%rcx
    4e61:	42 8b 54 06 20       	mov    0x20(%rsi,%r8,1),%edx
    4e66:	48 0f af fa          	imul   %rdx,%rdi
    4e6a:	48 c1 ef 20          	shr    $0x20,%rdi
    4e6e:	48 8d 1c 0f          	lea    (%rdi,%rcx,1),%rbx
    4e72:	48 81 c3 28 02 00 00 	add    $0x228,%rbx
    4e79:	80 3b ff             	cmpb   $0xff,(%rbx)
    4e7c:	75 bf                	jne    4e3d <e37+0x6d>
    4e7e:	48 89 df             	mov    %rbx,%rdi
    4e81:	49 89 c6             	mov    %rax,%r14
    4e84:	e8 07 14 00 00       	call   6290 <fwp_rc_forget_slot>
    4e89:	4c 89 f0             	mov    %r14,%rax
    4e8c:	eb af                	jmp    4e3d <e37+0x6d>
    4e8e:	48 39 d1             	cmp    %rdx,%rcx
    4e91:	73 5f                	jae    4ef2 <e37+0x122>
    4e93:	48 8b 15 5e e3 00 00 	mov    0xe35e(%rip),%rdx        # 131f8 <fwp_gc+0x1078>
    4e9a:	48 89 ce             	mov    %rcx,%rsi
    4e9d:	48 c1 ee 10          	shr    $0x10,%rsi
    4ea1:	48 69 f6 28 12 00 00 	imul   $0x1228,%rsi,%rsi
    4ea8:	0f b6 3c 32          	movzbl (%rdx,%rsi,1),%edi
    4eac:	48 81 e1 ff ff 00 00 	and    $0xffff,%rcx
    4eb3:	75 18                	jne    4ecd <e37+0xfd>
    4eb5:	40 80 ff 02          	cmp    $0x2,%dil
    4eb9:	75 12                	jne    4ecd <e37+0xfd>
    4ebb:	48 8d 0c 32          	lea    (%rdx,%rsi,1),%rcx
    4ebf:	48 81 c1 28 02 00 00 	add    $0x228,%rcx
    4ec6:	80 39 00             	cmpb   $0x0,(%rcx)
    4ec9:	74 27                	je     4ef2 <e37+0x122>
    4ecb:	eb 2d                	jmp    4efa <e37+0x12a>
    4ecd:	40 80 ff 01          	cmp    $0x1,%dil
    4ed1:	75 1f                	jne    4ef2 <e37+0x122>
    4ed3:	48 8d 3c 32          	lea    (%rdx,%rsi,1),%rdi
    4ed7:	8b 54 32 20          	mov    0x20(%rdx,%rsi,1),%edx
    4edb:	48 0f af ca          	imul   %rdx,%rcx
    4edf:	48 c1 e9 20          	shr    $0x20,%rcx
    4ee3:	48 01 f9             	add    %rdi,%rcx
    4ee6:	48 81 c1 28 02 00 00 	add    $0x228,%rcx
    4eed:	80 39 00             	cmpb   $0x0,(%rcx)
    4ef0:	75 08                	jne    4efa <e37+0x12a>
    4ef2:	48 83 c4 08          	add    $0x8,%rsp
    4ef6:	5b                   	pop    %rbx
    4ef7:	41 5e                	pop    %r14
    4ef9:	c3                   	ret
    4efa:	e8 61 13 00 00       	call   6260 <fwp_flush>
    4eff:	48 8b 05 da d0 00 00 	mov    0xd0da(%rip),%rax        # 11fe0 <stderr@GLIBC_2.2.5>
    4f06:	48 8b 38             	mov    (%rax),%rdi
    4f09:	48 8d 35 1d a5 00 00 	lea    0xa51d(%rip),%rsi        # f42d <fwp_segv.msg+0x1ed>
    4f10:	48 8d 15 e9 a4 00 00 	lea    0xa4e9(%rip),%rdx        # f400 <fwp_segv.msg+0x1c0>
    4f17:	31 c0                	xor    %eax,%eax
    4f19:	e8 92 d2 ff ff       	call   21b0 <fprintf@plt>
    4f1e:	bf 65 00 00 00       	mov    $0x65,%edi
    4f23:	e8 68 d3 ff ff       	call   2290 <exit@plt>
    4f28:	0f 1f 84 00 00 00 00 	nopl   0x0(%rax,%rax,1)
    4f2f:	00 

0000000000004f30 <e45>:
    4f30:	f2 0f 10 07          	movsd  (%rdi),%xmm0
    4f34:	f2 0f 58 47 08       	addsd  0x8(%rdi),%xmm0
    4f39:	66 48 0f 7e c0       	movq   %xmm0,%rax
    4f3e:	48 89 c1             	mov    %rax,%rcx
    4f41:	48 2b 0d 68 e2 00 00 	sub    0xe268(%rip),%rcx        # 131b0 <fwp_gc+0x1030>
    4f48:	48 8b 15 89 e2 00 00 	mov    0xe289(%rip),%rdx        # 131d8 <fwp_gc+0x1058>
    4f4f:	48 c1 e2 10          	shl    $0x10,%rdx
    4f53:	48 39 d1             	cmp    %rdx,%rcx
    4f56:	73 5f                	jae    4fb7 <e45+0x87>
    4f58:	48 8b 15 99 e2 00 00 	mov    0xe299(%rip),%rdx        # 131f8 <fwp_gc+0x1078>
    4f5f:	48 89 ce             	mov    %rcx,%rsi
    4f62:	48 c1 ee 10          	shr    $0x10,%rsi
    4f66:	48 69 f6 28 12 00 00 	imul   $0x1228,%rsi,%rsi
    4f6d:	0f b6 3c 32          	movzbl (%rdx,%rsi,1),%edi
    4f71:	48 81 e1 ff ff 00 00 	and    $0xffff,%rcx
    4f78:	75 18                	jne    4f92 <e45+0x62>
    4f7a:	40 80 ff 02          	cmp    $0x2,%dil
    4f7e:	75 12                	jne    4f92 <e45+0x62>
    4f80:	48 8d 0c 32          	lea    (%rdx,%rsi,1),%rcx
    4f84:	48 81 c1 28 02 00 00 	add    $0x228,%rcx
    4f8b:	80 39 00             	cmpb   $0x0,(%rcx)
    4f8e:	74 27                	je     4fb7 <e45+0x87>
    4f90:	eb 26                	jmp    4fb8 <e45+0x88>
    4f92:	40 80 ff 01          	cmp    $0x1,%dil
    4f96:	75 1f                	jne    4fb7 <e45+0x87>
    4f98:	48 8d 3c 32          	lea    (%rdx,%rsi,1),%rdi
    4f9c:	8b 54 32 20          	mov    0x20(%rdx,%rsi,1),%edx
    4fa0:	48 0f af ca          	imul   %rdx,%rcx
    4fa4:	48 c1 e9 20          	shr    $0x20,%rcx
    4fa8:	48 01 f9             	add    %rdi,%rcx
    4fab:	48 81 c1 28 02 00 00 	add    $0x228,%rcx
    4fb2:	80 39 00             	cmpb   $0x0,(%rcx)
    4fb5:	75 01                	jne    4fb8 <e45+0x88>
    4fb7:	c3                   	ret
    4fb8:	50                   	push   %rax
    4fb9:	e8 a2 12 00 00       	call   6260 <fwp_flush>
    4fbe:	48 8b 05 1b d0 00 00 	mov    0xd01b(%rip),%rax        # 11fe0 <stderr@GLIBC_2.2.5>
    4fc5:	48 8b 38             	mov    (%rax),%rdi
    4fc8:	48 8d 35 5e a4 00 00 	lea    0xa45e(%rip),%rsi        # f42d <fwp_segv.msg+0x1ed>
    4fcf:	48 8d 15 2a a4 00 00 	lea    0xa42a(%rip),%rdx        # f400 <fwp_segv.msg+0x1c0>
    4fd6:	31 c0                	xor    %eax,%eax
    4fd8:	e8 d3 d1 ff ff       	call   21b0 <fprintf@plt>
    4fdd:	bf 65 00 00 00       	mov    $0x65,%edi
    4fe2:	e8 a9 d2 ff ff       	call   2290 <exit@plt>
    4fe7:	66 0f 1f 84 00 00 00 	nopw   0x0(%rax,%rax,1)
    4fee:	00 00 

0000000000004ff0 <e46>:
    4ff0:	f2 0f 10 07          	movsd  (%rdi),%xmm0
    4ff4:	f2 0f 59 47 08       	mulsd  0x8(%rdi),%xmm0
    4ff9:	66 48 0f 7e c0       	movq   %xmm0,%rax
    4ffe:	48 89 c1             	mov    %rax,%rcx
    5001:	48 2b 0d a8 e1 00 00 	sub    0xe1a8(%rip),%rcx        # 131b0 <fwp_gc+0x1030>
    5008:	48 8b 15 c9 e1 00 00 	mov    0xe1c9(%rip),%rdx        # 131d8 <fwp_gc+0x1058>
    500f:	48 c1 e2 10          	shl    $0x10,%rdx
    5013:	48 39 d1             	cmp    %rdx,%rcx
    5016:	73 5f                	jae    5077 <e46+0x87>
    5018:	48 8b 15 d9 e1 00 00 	mov    0xe1d9(%rip),%rdx        # 131f8 <fwp_gc+0x1078>
    501f:	48 89 ce             	mov    %rcx,%rsi
    5022:	48 c1 ee 10          	shr    $0x10,%rsi
    5026:	48 69 f6 28 12 00 00 	imul   $0x1228,%rsi,%rsi
    502d:	0f b6 3c 32          	movzbl (%rdx,%rsi,1),%edi
    5031:	48 81 e1 ff ff 00 00 	and    $0xffff,%rcx
    5038:	75 18                	jne    5052 <e46+0x62>
    503a:	40 80 ff 02          	cmp    $0x2,%dil
    503e:	75 12                	jne    5052 <e46+0x62>
    5040:	48 8d 0c 32          	lea    (%rdx,%rsi,1),%rcx
    5044:	48 81 c1 28 02 00 00 	add    $0x228,%rcx
    504b:	80 39 00             	cmpb   $0x0,(%rcx)
    504e:	74 27                	je     5077 <e46+0x87>
    5050:	eb 26                	jmp    5078 <e46+0x88>
    5052:	40 80 ff 01          	cmp    $0x1,%dil
    5056:	75 1f                	jne    5077 <e46+0x87>
    5058:	48 8d 3c 32          	lea    (%rdx,%rsi,1),%rdi
    505c:	8b 54 32 20          	mov    0x20(%rdx,%rsi,1),%edx
    5060:	48 0f af ca          	imul   %rdx,%rcx
    5064:	48 c1 e9 20          	shr    $0x20,%rcx
    5068:	48 01 f9             	add    %rdi,%rcx
    506b:	48 81 c1 28 02 00 00 	add    $0x228,%rcx
    5072:	80 39 00             	cmpb   $0x0,(%rcx)
    5075:	75 01                	jne    5078 <e46+0x88>
    5077:	c3                   	ret
    5078:	50                   	push   %rax
    5079:	e8 e2 11 00 00       	call   6260 <fwp_flush>
    507e:	48 8b 05 5b cf 00 00 	mov    0xcf5b(%rip),%rax        # 11fe0 <stderr@GLIBC_2.2.5>
    5085:	48 8b 38             	mov    (%rax),%rdi
    5088:	48 8d 35 9e a3 00 00 	lea    0xa39e(%rip),%rsi        # f42d <fwp_segv.msg+0x1ed>
    508f:	48 8d 15 6a a3 00 00 	lea    0xa36a(%rip),%rdx        # f400 <fwp_segv.msg+0x1c0>
    5096:	31 c0                	xor    %eax,%eax
    5098:	e8 13 d1 ff ff       	call   21b0 <fprintf@plt>
    509d:	bf 65 00 00 00       	mov    $0x65,%edi
    50a2:	e8 e9 d1 ff ff       	call   2290 <exit@plt>
    50a7:	66 0f 1f 84 00 00 00 	nopw   0x0(%rax,%rax,1)
    50ae:	00 00 

00000000000050b0 <e47>:
    50b0:	50                   	push   %rax
    50b1:	48 8b 77 08          	mov    0x8(%rdi),%rsi
    50b5:	48 89 f0             	mov    %rsi,%rax
    50b8:	48 2b 05 f1 e0 00 00 	sub    0xe0f1(%rip),%rax        # 131b0 <fwp_gc+0x1030>
    50bf:	48 8b 0d 12 e1 00 00 	mov    0xe112(%rip),%rcx        # 131d8 <fwp_gc+0x1058>
    50c6:	48 c1 e1 10          	shl    $0x10,%rcx
    50ca:	48 39 c8             	cmp    %rcx,%rax
    50cd:	73 64                	jae    5133 <e47+0x83>
    50cf:	48 8b 0d 22 e1 00 00 	mov    0xe122(%rip),%rcx        # 131f8 <fwp_gc+0x1078>
    50d6:	48 89 c2             	mov    %rax,%rdx
    50d9:	48 c1 ea 10          	shr    $0x10,%rdx
    50dd:	48 69 d2 28 12 00 00 	imul   $0x1228,%rdx,%rdx
    50e4:	44 0f b6 04 11       	movzbl (%rcx,%rdx,1),%r8d
    50e9:	48 25 ff ff 00 00    	and    $0xffff,%rax
    50ef:	75 1a                	jne    510b <e47+0x5b>
    50f1:	41 80 f8 02          	cmp    $0x2,%r8b
    50f5:	75 14                	jne    510b <e47+0x5b>
    50f7:	48 8d 04 11          	lea    (%rcx,%rdx,1),%rax
    50fb:	48 05 28 02 00 00    	add    $0x228,%rax
    5101:	80 38 00             	cmpb   $0x0,(%rax)
    5104:	74 2d                	je     5133 <e47+0x83>
    5106:	e9 b2 00 00 00       	jmp    51bd <e47+0x10d>
    510b:	41 80 f8 01          	cmp    $0x1,%r8b
    510f:	75 22                	jne    5133 <e47+0x83>
    5111:	4c 8d 04 11          	lea    (%rcx,%rdx,1),%r8
    5115:	8b 4c 11 20          	mov    0x20(%rcx,%rdx,1),%ecx
    5119:	48 0f af c1          	imul   %rcx,%rax
    511d:	48 c1 e8 20          	shr    $0x20,%rax
    5121:	4c 01 c0             	add    %r8,%rax
    5124:	48 05 28 02 00 00    	add    $0x228,%rax
    512a:	80 38 00             	cmpb   $0x0,(%rax)
    512d:	0f 85 8a 00 00 00    	jne    51bd <e47+0x10d>
    5133:	48 8b 3f             	mov    (%rdi),%rdi
    5136:	48 8d 15 13 cb 00 00 	lea    0xcb13(%rip),%rdx        # 11c50 <d0>
    513d:	e8 ce 4a 00 00       	call   9c10 <fwp_p_array_get_typed>
    5142:	48 89 c1             	mov    %rax,%rcx
    5145:	48 2b 0d 64 e0 00 00 	sub    0xe064(%rip),%rcx        # 131b0 <fwp_gc+0x1030>
    514c:	48 8b 15 85 e0 00 00 	mov    0xe085(%rip),%rdx        # 131d8 <fwp_gc+0x1058>
    5153:	48 c1 e2 10          	shl    $0x10,%rdx
    5157:	48 39 d1             	cmp    %rdx,%rcx
    515a:	73 5f                	jae    51bb <e47+0x10b>
    515c:	48 8b 15 95 e0 00 00 	mov    0xe095(%rip),%rdx        # 131f8 <fwp_gc+0x1078>
    5163:	48 89 ce             	mov    %rcx,%rsi
    5166:	48 c1 ee 10          	shr    $0x10,%rsi
    516a:	48 69 f6 28 12 00 00 	imul   $0x1228,%rsi,%rsi
    5171:	0f b6 3c 32          	movzbl (%rdx,%rsi,1),%edi
    5175:	48 81 e1 ff ff 00 00 	and    $0xffff,%rcx
    517c:	75 18                	jne    5196 <e47+0xe6>
    517e:	40 80 ff 02          	cmp    $0x2,%dil
    5182:	75 12                	jne    5196 <e47+0xe6>
    5184:	48 8d 0c 32          	lea    (%rdx,%rsi,1),%rcx
    5188:	48 81 c1 28 02 00 00 	add    $0x228,%rcx
    518f:	80 39 00             	cmpb   $0x0,(%rcx)
    5192:	74 27                	je     51bb <e47+0x10b>
    5194:	eb 27                	jmp    51bd <e47+0x10d>
    5196:	40 80 ff 01          	cmp    $0x1,%dil
    519a:	75 1f                	jne    51bb <e47+0x10b>
    519c:	48 8d 3c 32          	lea    (%rdx,%rsi,1),%rdi
    51a0:	8b 54 32 20          	mov    0x20(%rdx,%rsi,1),%edx
    51a4:	48 0f af ca          	imul   %rdx,%rcx
    51a8:	48 c1 e9 20          	shr    $0x20,%rcx
    51ac:	48 01 f9             	add    %rdi,%rcx
    51af:	48 81 c1 28 02 00 00 	add    $0x228,%rcx
    51b6:	80 39 00             	cmpb   $0x0,(%rcx)
    51b9:	75 02                	jne    51bd <e47+0x10d>
    51bb:	59                   	pop    %rcx
    51bc:	c3                   	ret
    51bd:	e8 9e 10 00 00       	call   6260 <fwp_flush>
    51c2:	48 8b 05 17 ce 00 00 	mov    0xce17(%rip),%rax        # 11fe0 <stderr@GLIBC_2.2.5>
    51c9:	48 8b 38             	mov    (%rax),%rdi
    51cc:	48 8d 35 5a a2 00 00 	lea    0xa25a(%rip),%rsi        # f42d <fwp_segv.msg+0x1ed>
    51d3:	48 8d 15 26 a2 00 00 	lea    0xa226(%rip),%rdx        # f400 <fwp_segv.msg+0x1c0>
    51da:	31 c0                	xor    %eax,%eax
    51dc:	e8 cf cf ff ff       	call   21b0 <fprintf@plt>
    51e1:	bf 65 00 00 00       	mov    $0x65,%edi
    51e6:	e8 a5 d0 ff ff       	call   2290 <exit@plt>
    51eb:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)

00000000000051f0 <e48>:
    51f0:	53                   	push   %rbx
    51f1:	48 83 ec 60          	sub    $0x60,%rsp
    51f5:	48 8b 47 08          	mov    0x8(%rdi),%rax
    51f9:	48 03 07             	add    (%rdi),%rax
    51fc:	70 7f                	jo     527d <e48+0x8d>
    51fe:	48 89 c1             	mov    %rax,%rcx
    5201:	48 2b 0d a8 df 00 00 	sub    0xdfa8(%rip),%rcx        # 131b0 <fwp_gc+0x1030>
    5208:	48 8b 15 c9 df 00 00 	mov    0xdfc9(%rip),%rdx        # 131d8 <fwp_gc+0x1058>
    520f:	48 c1 e2 10          	shl    $0x10,%rdx
    5213:	48 39 d1             	cmp    %rdx,%rcx
    5216:	73 5f                	jae    5277 <e48+0x87>
    5218:	48 8b 15 d9 df 00 00 	mov    0xdfd9(%rip),%rdx        # 131f8 <fwp_gc+0x1078>
    521f:	48 89 ce             	mov    %rcx,%rsi
    5222:	48 c1 ee 10          	shr    $0x10,%rsi
    5226:	48 69 f6 28 12 00 00 	imul   $0x1228,%rsi,%rsi
    522d:	0f b6 3c 32          	movzbl (%rdx,%rsi,1),%edi
    5231:	48 81 e1 ff ff 00 00 	and    $0xffff,%rcx
    5238:	75 18                	jne    5252 <e48+0x62>
    523a:	40 80 ff 02          	cmp    $0x2,%dil
    523e:	75 12                	jne    5252 <e48+0x62>
    5240:	48 8d 0c 32          	lea    (%rdx,%rsi,1),%rcx
    5244:	48 81 c1 28 02 00 00 	add    $0x228,%rcx
    524b:	80 39 00             	cmpb   $0x0,(%rcx)
    524e:	74 27                	je     5277 <e48+0x87>
    5250:	eb 66                	jmp    52b8 <e48+0xc8>
    5252:	40 80 ff 01          	cmp    $0x1,%dil
    5256:	75 1f                	jne    5277 <e48+0x87>
    5258:	48 8d 3c 32          	lea    (%rdx,%rsi,1),%rdi
    525c:	8b 54 32 20          	mov    0x20(%rdx,%rsi,1),%edx
    5260:	48 0f af ca          	imul   %rdx,%rcx
    5264:	48 c1 e9 20          	shr    $0x20,%rcx
    5268:	48 01 f9             	add    %rdi,%rcx
    526b:	48 81 c1 28 02 00 00 	add    $0x228,%rcx
    5272:	80 39 00             	cmpb   $0x0,(%rcx)
    5275:	75 41                	jne    52b8 <e48+0xc8>
    5277:	48 83 c4 60          	add    $0x60,%rsp
    527b:	5b                   	pop    %rbx
    527c:	c3                   	ret
    527d:	48 8d 15 07 a4 00 00 	lea    0xa407(%rip),%rdx        # f68b <fwp_segv.msg+0x44b>
    5284:	48 8d 0d 1a a4 00 00 	lea    0xa41a(%rip),%rcx        # f6a5 <fwp_segv.msg+0x465>
    528b:	48 89 e3             	mov    %rsp,%rbx
    528e:	be 60 00 00 00       	mov    $0x60,%esi
    5293:	48 89 df             	mov    %rbx,%rdi
    5296:	31 c0                	xor    %eax,%eax
    5298:	e8 73 ce ff ff       	call   2110 <snprintf@plt>
    529d:	e8 be 0f 00 00       	call   6260 <fwp_flush>
    52a2:	48 8b 05 37 cd 00 00 	mov    0xcd37(%rip),%rax        # 11fe0 <stderr@GLIBC_2.2.5>
    52a9:	48 8b 38             	mov    (%rax),%rdi
    52ac:	48 8d 35 7a a1 00 00 	lea    0xa17a(%rip),%rsi        # f42d <fwp_segv.msg+0x1ed>
    52b3:	48 89 da             	mov    %rbx,%rdx
    52b6:	eb 1d                	jmp    52d5 <e48+0xe5>
    52b8:	e8 a3 0f 00 00       	call   6260 <fwp_flush>
    52bd:	48 8b 05 1c cd 00 00 	mov    0xcd1c(%rip),%rax        # 11fe0 <stderr@GLIBC_2.2.5>
    52c4:	48 8b 38             	mov    (%rax),%rdi
    52c7:	48 8d 35 5f a1 00 00 	lea    0xa15f(%rip),%rsi        # f42d <fwp_segv.msg+0x1ed>
    52ce:	48 8d 15 2b a1 00 00 	lea    0xa12b(%rip),%rdx        # f400 <fwp_segv.msg+0x1c0>
    52d5:	31 c0                	xor    %eax,%eax
    52d7:	e8 d4 ce ff ff       	call   21b0 <fprintf@plt>
    52dc:	bf 65 00 00 00       	mov    $0x65,%edi
    52e1:	e8 aa cf ff ff       	call   2290 <exit@plt>
    52e6:	66 2e 0f 1f 84 00 00 	cs nopw 0x0(%rax,%rax,1)
    52ed:	00 00 00 

00000000000052f0 <e49>:
    52f0:	50                   	push   %rax
    52f1:	48 8b 3f             	mov    (%rdi),%rdi
    52f4:	48 89 f8             	mov    %rdi,%rax
    52f7:	48 2b 05 b2 de 00 00 	sub    0xdeb2(%rip),%rax        # 131b0 <fwp_gc+0x1030>
    52fe:	48 8b 0d d3 de 00 00 	mov    0xded3(%rip),%rcx        # 131d8 <fwp_gc+0x1058>
    5305:	48 c1 e1 10          	shl    $0x10,%rcx
    5309:	48 39 c8             	cmp    %rcx,%rax
    530c:	73 63                	jae    5371 <e49+0x81>
    530e:	48 8b 0d e3 de 00 00 	mov    0xdee3(%rip),%rcx        # 131f8 <fwp_gc+0x1078>
    5315:	48 89 c2             	mov    %rax,%rdx
    5318:	48 c1 ea 10          	shr    $0x10,%rdx
    531c:	48 69 d2 28 12 00 00 	imul   $0x1228,%rdx,%rdx
    5323:	0f b6 34 11          	movzbl (%rcx,%rdx,1),%esi
    5327:	48 25 ff ff 00 00    	and    $0xffff,%rax
    532d:	75 1a                	jne    5349 <e49+0x59>
    532f:	40 80 fe 02          	cmp    $0x2,%sil
    5333:	75 14                	jne    5349 <e49+0x59>
    5335:	48 8d 04 11          	lea    (%rcx,%rdx,1),%rax
    5339:	48 05 28 02 00 00    	add    $0x228,%rax
    533f:	80 38 00             	cmpb   $0x0,(%rax)
    5342:	74 2d                	je     5371 <e49+0x81>
    5344:	e9 a8 00 00 00       	jmp    53f1 <e49+0x101>
    5349:	40 80 fe 01          	cmp    $0x1,%sil
    534d:	75 22                	jne    5371 <e49+0x81>
    534f:	48 8d 34 11          	lea    (%rcx,%rdx,1),%rsi
    5353:	8b 4c 11 20          	mov    0x20(%rcx,%rdx,1),%ecx
    5357:	48 0f af c1          	imul   %rcx,%rax
    535b:	48 c1 e8 20          	shr    $0x20,%rax
    535f:	48 01 f0             	add    %rsi,%rax
    5362:	48 05 28 02 00 00    	add    $0x228,%rax
    5368:	80 38 00             	cmpb   $0x0,(%rax)
    536b:	0f 85 80 00 00 00    	jne    53f1 <e49+0x101>
    5371:	e8 0a 4c 00 00       	call   9f80 <f49>
    5376:	48 89 c1             	mov    %rax,%rcx
    5379:	48 2b 0d 30 de 00 00 	sub    0xde30(%rip),%rcx        # 131b0 <fwp_gc+0x1030>
    5380:	48 8b 15 51 de 00 00 	mov    0xde51(%rip),%rdx        # 131d8 <fwp_gc+0x1058>
    5387:	48 c1 e2 10          	shl    $0x10,%rdx
    538b:	48 39 d1             	cmp    %rdx,%rcx
    538e:	73 5f                	jae    53ef <e49+0xff>
    5390:	48 8b 15 61 de 00 00 	mov    0xde61(%rip),%rdx        # 131f8 <fwp_gc+0x1078>
    5397:	48 89 ce             	mov    %rcx,%rsi
    539a:	48 c1 ee 10          	shr    $0x10,%rsi
    539e:	48 69 f6 28 12 00 00 	imul   $0x1228,%rsi,%rsi
    53a5:	0f b6 3c 32          	movzbl (%rdx,%rsi,1),%edi
    53a9:	48 81 e1 ff ff 00 00 	and    $0xffff,%rcx
    53b0:	75 18                	jne    53ca <e49+0xda>
    53b2:	40 80 ff 02          	cmp    $0x2,%dil
    53b6:	75 12                	jne    53ca <e49+0xda>
    53b8:	48 8d 0c 32          	lea    (%rdx,%rsi,1),%rcx
    53bc:	48 81 c1 28 02 00 00 	add    $0x228,%rcx
    53c3:	80 39 00             	cmpb   $0x0,(%rcx)
    53c6:	74 27                	je     53ef <e49+0xff>
    53c8:	eb 27                	jmp    53f1 <e49+0x101>
    53ca:	40 80 ff 01          	cmp    $0x1,%dil
    53ce:	75 1f                	jne    53ef <e49+0xff>
    53d0:	48 8d 3c 32          	lea    (%rdx,%rsi,1),%rdi
    53d4:	8b 54 32 20          	mov    0x20(%rdx,%rsi,1),%edx
    53d8:	48 0f af ca          	imul   %rdx,%rcx
    53dc:	48 c1 e9 20          	shr    $0x20,%rcx
    53e0:	48 01 f9             	add    %rdi,%rcx
    53e3:	48 81 c1 28 02 00 00 	add    $0x228,%rcx
    53ea:	80 39 00             	cmpb   $0x0,(%rcx)
    53ed:	75 02                	jne    53f1 <e49+0x101>
    53ef:	59                   	pop    %rcx
    53f0:	c3                   	ret
    53f1:	e8 6a 0e 00 00       	call   6260 <fwp_flush>
    53f6:	48 8b 05 e3 cb 00 00 	mov    0xcbe3(%rip),%rax        # 11fe0 <stderr@GLIBC_2.2.5>
    53fd:	48 8b 38             	mov    (%rax),%rdi
    5400:	48 8d 35 26 a0 00 00 	lea    0xa026(%rip),%rsi        # f42d <fwp_segv.msg+0x1ed>
    5407:	48 8d 15 f2 9f 00 00 	lea    0x9ff2(%rip),%rdx        # f400 <fwp_segv.msg+0x1c0>
    540e:	31 c0                	xor    %eax,%eax
    5410:	e8 9b cd ff ff       	call   21b0 <fprintf@plt>
    5415:	bf 65 00 00 00       	mov    $0x65,%edi
    541a:	e8 71 ce ff ff       	call   2290 <exit@plt>
    541f:	90                   	nop

0000000000005420 <e50>:
    5420:	50                   	push   %rax
    5421:	48 89 f8             	mov    %rdi,%rax
    5424:	48 8b 3f             	mov    (%rdi),%rdi
    5427:	48 8b 0d 82 dd 00 00 	mov    0xdd82(%rip),%rcx        # 131b0 <fwp_gc+0x1030>
    542e:	48 89 fe             	mov    %rdi,%rsi
    5431:	48 29 ce             	sub    %rcx,%rsi
    5434:	48 8b 15 9d dd 00 00 	mov    0xdd9d(%rip),%rdx        # 131d8 <fwp_gc+0x1058>
    543b:	48 c1 e2 10          	shl    $0x10,%rdx
    543f:	48 39 d6             	cmp    %rdx,%rsi
    5442:	73 68                	jae    54ac <e50+0x8c>
    5444:	4c 8b 05 ad dd 00 00 	mov    0xddad(%rip),%r8        # 131f8 <fwp_gc+0x1078>
    544b:	49 89 f1             	mov    %rsi,%r9
    544e:	49 c1 e9 10          	shr    $0x10,%r9
    5452:	4d 69 c9 28 12 00 00 	imul   $0x1228,%r9,%r9
    5459:	47 0f b6 14 08       	movzbl (%r8,%r9,1),%r10d
    545e:	48 81 e6 ff ff 00 00 	and    $0xffff,%rsi
    5465:	75 1b                	jne    5482 <e50+0x62>
    5467:	41 80 fa 02          	cmp    $0x2,%r10b
    546b:	75 15                	jne    5482 <e50+0x62>
    546d:	4b 8d 34 08          	lea    (%r8,%r9,1),%rsi
    5471:	48 81 c6 28 02 00 00 	add    $0x228,%rsi
    5478:	80 3e 00             	cmpb   $0x0,(%rsi)
    547b:	74 2f                	je     54ac <e50+0x8c>
    547d:	e9 24 01 00 00       	jmp    55a6 <e50+0x186>
    5482:	41 80 fa 01          	cmp    $0x1,%r10b
    5486:	75 24                	jne    54ac <e50+0x8c>
    5488:	4f 8d 14 08          	lea    (%r8,%r9,1),%r10
    548c:	47 8b 44 08 20       	mov    0x20(%r8,%r9,1),%r8d
    5491:	49 0f af f0          	imul   %r8,%rsi
    5495:	48 c1 ee 20          	shr    $0x20,%rsi
    5499:	4c 01 d6             	add    %r10,%rsi
    549c:	48 81 c6 28 02 00 00 	add    $0x228,%rsi
    54a3:	80 3e 00             	cmpb   $0x0,(%rsi)
    54a6:	0f 85 fa 00 00 00    	jne    55a6 <e50+0x186>
    54ac:	48 8b 70 08          	mov    0x8(%rax),%rsi
    54b0:	48 89 f0             	mov    %rsi,%rax
    54b3:	48 29 c8             	sub    %rcx,%rax
    54b6:	48 39 d0             	cmp    %rdx,%rax
    54b9:	73 64                	jae    551f <e50+0xff>
    54bb:	48 8b 0d 36 dd 00 00 	mov    0xdd36(%rip),%rcx        # 131f8 <fwp_gc+0x1078>
    54c2:	48 89 c2             	mov    %rax,%rdx
    54c5:	48 c1 ea 10          	shr    $0x10,%rdx
    54c9:	48 69 d2 28 12 00 00 	imul   $0x1228,%rdx,%rdx
    54d0:	44 0f b6 04 11       	movzbl (%rcx,%rdx,1),%r8d
    54d5:	48 25 ff ff 00 00    	and    $0xffff,%rax
    54db:	75 1a                	jne    54f7 <e50+0xd7>
    54dd:	41 80 f8 02          	cmp    $0x2,%r8b
    54e1:	75 14                	jne    54f7 <e50+0xd7>
    54e3:	48 8d 04 11          	lea    (%rcx,%rdx,1),%rax
    54e7:	48 05 28 02 00 00    	add    $0x228,%rax
    54ed:	80 38 00             	cmpb   $0x0,(%rax)
    54f0:	74 2d                	je     551f <e50+0xff>
    54f2:	e9 af 00 00 00       	jmp    55a6 <e50+0x186>
    54f7:	41 80 f8 01          	cmp    $0x1,%r8b
    54fb:	75 22                	jne    551f <e50+0xff>
    54fd:	4c 8d 04 11          	lea    (%rcx,%rdx,1),%r8
    5501:	8b 4c 11 20          	mov    0x20(%rcx,%rdx,1),%ecx
    5505:	48 0f af c1          	imul   %rcx,%rax
    5509:	48 c1 e8 20          	shr    $0x20,%rax
    550d:	4c 01 c0             	add    %r8,%rax
    5510:	48 05 28 02 00 00    	add    $0x228,%rax
    5516:	80 38 00             	cmpb   $0x0,(%rax)
    5519:	0f 85 87 00 00 00    	jne    55a6 <e50+0x186>
    551f:	48 8d 15 5a 5b 00 00 	lea    0x5b5a(%rip),%rdx        # b080 <fwp_drop7>
    5526:	e8 d5 56 00 00       	call   ac00 <fwp_p_loop_own>
    552b:	48 89 c1             	mov    %rax,%rcx
    552e:	48 2b 0d 7b dc 00 00 	sub    0xdc7b(%rip),%rcx        # 131b0 <fwp_gc+0x1030>
    5535:	48 8b 15 9c dc 00 00 	mov    0xdc9c(%rip),%rdx        # 131d8 <fwp_gc+0x1058>
    553c:	48 c1 e2 10          	shl    $0x10,%rdx
    5540:	48 39 d1             	cmp    %rdx,%rcx
    5543:	73 5f                	jae    55a4 <e50+0x184>
    5545:	48 8b 15 ac dc 00 00 	mov    0xdcac(%rip),%rdx        # 131f8 <fwp_gc+0x1078>
    554c:	48 89 ce             	mov    %rcx,%rsi
    554f:	48 c1 ee 10          	shr    $0x10,%rsi
    5553:	48 69 f6 28 12 00 00 	imul   $0x1228,%rsi,%rsi
    555a:	0f b6 3c 32          	movzbl (%rdx,%rsi,1),%edi
    555e:	48 81 e1 ff ff 00 00 	and    $0xffff,%rcx
    5565:	75 18                	jne    557f <e50+0x15f>
    5567:	40 80 ff 02          	cmp    $0x2,%dil
    556b:	75 12                	jne    557f <e50+0x15f>
    556d:	48 8d 0c 32          	lea    (%rdx,%rsi,1),%rcx
    5571:	48 81 c1 28 02 00 00 	add    $0x228,%rcx
    5578:	80 39 00             	cmpb   $0x0,(%rcx)
    557b:	74 27                	je     55a4 <e50+0x184>
    557d:	eb 27                	jmp    55a6 <e50+0x186>
    557f:	40 80 ff 01          	cmp    $0x1,%dil
    5583:	75 1f                	jne    55a4 <e50+0x184>
    5585:	48 8d 3c 32          	lea    (%rdx,%rsi,1),%rdi
    5589:	8b 54 32 20          	mov    0x20(%rdx,%rsi,1),%edx
    558d:	48 0f af ca          	imul   %rdx,%rcx
    5591:	48 c1 e9 20          	shr    $0x20,%rcx
    5595:	48 01 f9             	add    %rdi,%rcx
    5598:	48 81 c1 28 02 00 00 	add    $0x228,%rcx
    559f:	80 39 00             	cmpb   $0x0,(%rcx)
    55a2:	75 02                	jne    55a6 <e50+0x186>
    55a4:	59                   	pop    %rcx
    55a5:	c3                   	ret
    55a6:	e8 b5 0c 00 00       	call   6260 <fwp_flush>
    55ab:	48 8b 05 2e ca 00 00 	mov    0xca2e(%rip),%rax        # 11fe0 <stderr@GLIBC_2.2.5>
    55b2:	48 8b 38             	mov    (%rax),%rdi
    55b5:	48 8d 35 71 9e 00 00 	lea    0x9e71(%rip),%rsi        # f42d <fwp_segv.msg+0x1ed>
    55bc:	48 8d 15 3d 9e 00 00 	lea    0x9e3d(%rip),%rdx        # f400 <fwp_segv.msg+0x1c0>
    55c3:	31 c0                	xor    %eax,%eax
    55c5:	e8 e6 cb ff ff       	call   21b0 <fprintf@plt>
    55ca:	bf 65 00 00 00       	mov    $0x65,%edi
    55cf:	e8 bc cc ff ff       	call   2290 <exit@plt>
    55d4:	66 66 66 2e 0f 1f 84 	data16 data16 cs nopw 0x0(%rax,%rax,1)
    55db:	00 00 00 00 00 

00000000000055e0 <e51>:
    55e0:	50                   	push   %rax
    55e1:	48 8b 77 08          	mov    0x8(%rdi),%rsi
    55e5:	48 89 f0             	mov    %rsi,%rax
    55e8:	48 2b 05 c1 db 00 00 	sub    0xdbc1(%rip),%rax        # 131b0 <fwp_gc+0x1030>
    55ef:	48 8b 0d e2 db 00 00 	mov    0xdbe2(%rip),%rcx        # 131d8 <fwp_gc+0x1058>
    55f6:	48 c1 e1 10          	shl    $0x10,%rcx
    55fa:	48 39 c8             	cmp    %rcx,%rax
    55fd:	73 64                	jae    5663 <e51+0x83>
    55ff:	48 8b 0d f2 db 00 00 	mov    0xdbf2(%rip),%rcx        # 131f8 <fwp_gc+0x1078>
    5606:	48 89 c2             	mov    %rax,%rdx
    5609:	48 c1 ea 10          	shr    $0x10,%rdx
    560d:	48 69 d2 28 12 00 00 	imul   $0x1228,%rdx,%rdx
    5614:	44 0f b6 04 11       	movzbl (%rcx,%rdx,1),%r8d
    5619:	48 25 ff ff 00 00    	and    $0xffff,%rax
    561f:	75 1a                	jne    563b <e51+0x5b>
    5621:	41 80 f8 02          	cmp    $0x2,%r8b
    5625:	75 14                	jne    563b <e51+0x5b>
    5627:	48 8d 04 11          	lea    (%rcx,%rdx,1),%rax
    562b:	48 05 28 02 00 00    	add    $0x228,%rax
    5631:	80 38 00             	cmpb   $0x0,(%rax)
    5634:	74 2d                	je     5663 <e51+0x83>
    5636:	e9 b2 00 00 00       	jmp    56ed <e51+0x10d>
    563b:	41 80 f8 01          	cmp    $0x1,%r8b
    563f:	75 22                	jne    5663 <e51+0x83>
    5641:	4c 8d 04 11          	lea    (%rcx,%rdx,1),%r8
    5645:	8b 4c 11 20          	mov    0x20(%rcx,%rdx,1),%ecx
    5649:	48 0f af c1          	imul   %rcx,%rax
    564d:	48 c1 e8 20          	shr    $0x20,%rax
    5651:	4c 01 c0             	add    %r8,%rax
    5654:	48 05 28 02 00 00    	add    $0x228,%rax
    565a:	80 38 00             	cmpb   $0x0,(%rax)
    565d:	0f 85 8a 00 00 00    	jne    56ed <e51+0x10d>
    5663:	48 8b 3f             	mov    (%rdi),%rdi
    5666:	48 8d 15 a3 c6 00 00 	lea    0xc6a3(%rip),%rdx        # 11d10 <d2>
    566d:	e8 9e 45 00 00       	call   9c10 <fwp_p_array_get_typed>
    5672:	48 89 c1             	mov    %rax,%rcx
    5675:	48 2b 0d 34 db 00 00 	sub    0xdb34(%rip),%rcx        # 131b0 <fwp_gc+0x1030>
    567c:	48 8b 15 55 db 00 00 	mov    0xdb55(%rip),%rdx        # 131d8 <fwp_gc+0x1058>
    5683:	48 c1 e2 10          	shl    $0x10,%rdx
    5687:	48 39 d1             	cmp    %rdx,%rcx
    568a:	73 5f                	jae    56eb <e51+0x10b>
    568c:	48 8b 15 65 db 00 00 	mov    0xdb65(%rip),%rdx        # 131f8 <fwp_gc+0x1078>
    5693:	48 89 ce             	mov    %rcx,%rsi
    5696:	48 c1 ee 10          	shr    $0x10,%rsi
    569a:	48 69 f6 28 12 00 00 	imul   $0x1228,%rsi,%rsi
    56a1:	0f b6 3c 32          	movzbl (%rdx,%rsi,1),%edi
    56a5:	48 81 e1 ff ff 00 00 	and    $0xffff,%rcx
    56ac:	75 18                	jne    56c6 <e51+0xe6>
    56ae:	40 80 ff 02          	cmp    $0x2,%dil
    56b2:	75 12                	jne    56c6 <e51+0xe6>
    56b4:	48 8d 0c 32          	lea    (%rdx,%rsi,1),%rcx
    56b8:	48 81 c1 28 02 00 00 	add    $0x228,%rcx
    56bf:	80 39 00             	cmpb   $0x0,(%rcx)
    56c2:	74 27                	je     56eb <e51+0x10b>
    56c4:	eb 27                	jmp    56ed <e51+0x10d>
    56c6:	40 80 ff 01          	cmp    $0x1,%dil
    56ca:	75 1f                	jne    56eb <e51+0x10b>
    56cc:	48 8d 3c 32          	lea    (%rdx,%rsi,1),%rdi
    56d0:	8b 54 32 20          	mov    0x20(%rdx,%rsi,1),%edx
    56d4:	48 0f af ca          	imul   %rdx,%rcx
    56d8:	48 c1 e9 20          	shr    $0x20,%rcx
    56dc:	48 01 f9             	add    %rdi,%rcx
    56df:	48 81 c1 28 02 00 00 	add    $0x228,%rcx
    56e6:	80 39 00             	cmpb   $0x0,(%rcx)
    56e9:	75 02                	jne    56ed <e51+0x10d>
    56eb:	59                   	pop    %rcx
    56ec:	c3                   	ret
    56ed:	e8 6e 0b 00 00       	call   6260 <fwp_flush>
    56f2:	48 8b 05 e7 c8 00 00 	mov    0xc8e7(%rip),%rax        # 11fe0 <stderr@GLIBC_2.2.5>
    56f9:	48 8b 38             	mov    (%rax),%rdi
    56fc:	48 8d 35 2a 9d 00 00 	lea    0x9d2a(%rip),%rsi        # f42d <fwp_segv.msg+0x1ed>
    5703:	48 8d 15 f6 9c 00 00 	lea    0x9cf6(%rip),%rdx        # f400 <fwp_segv.msg+0x1c0>
    570a:	31 c0                	xor    %eax,%eax
    570c:	e8 9f ca ff ff       	call   21b0 <fprintf@plt>
    5711:	bf 65 00 00 00       	mov    $0x65,%edi
    5716:	e8 75 cb ff ff       	call   2290 <exit@plt>
    571b:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)

0000000000005720 <e52>:
    5720:	50                   	push   %rax
    5721:	48 8b 3f             	mov    (%rdi),%rdi
    5724:	48 89 f8             	mov    %rdi,%rax
    5727:	48 2b 05 82 da 00 00 	sub    0xda82(%rip),%rax        # 131b0 <fwp_gc+0x1030>
    572e:	48 8b 0d a3 da 00 00 	mov    0xdaa3(%rip),%rcx        # 131d8 <fwp_gc+0x1058>
    5735:	48 c1 e1 10          	shl    $0x10,%rcx
    5739:	48 39 c8             	cmp    %rcx,%rax
    573c:	73 63                	jae    57a1 <e52+0x81>
    573e:	48 8b 0d b3 da 00 00 	mov    0xdab3(%rip),%rcx        # 131f8 <fwp_gc+0x1078>
    5745:	48 89 c2             	mov    %rax,%rdx
    5748:	48 c1 ea 10          	shr    $0x10,%rdx
    574c:	48 69 d2 28 12 00 00 	imul   $0x1228,%rdx,%rdx
    5753:	0f b6 34 11          	movzbl (%rcx,%rdx,1),%esi
    5757:	48 25 ff ff 00 00    	and    $0xffff,%rax
    575d:	75 1a                	jne    5779 <e52+0x59>
    575f:	40 80 fe 02          	cmp    $0x2,%sil
    5763:	75 14                	jne    5779 <e52+0x59>
    5765:	48 8d 04 11          	lea    (%rcx,%rdx,1),%rax
    5769:	48 05 28 02 00 00    	add    $0x228,%rax
    576f:	80 38 00             	cmpb   $0x0,(%rax)
    5772:	74 2d                	je     57a1 <e52+0x81>
    5774:	e9 a8 00 00 00       	jmp    5821 <e52+0x101>
    5779:	40 80 fe 01          	cmp    $0x1,%sil
    577d:	75 22                	jne    57a1 <e52+0x81>
    577f:	48 8d 34 11          	lea    (%rcx,%rdx,1),%rsi
    5783:	8b 4c 11 20          	mov    0x20(%rcx,%rdx,1),%ecx
    5787:	48 0f af c1          	imul   %rcx,%rax
    578b:	48 c1 e8 20          	shr    $0x20,%rax
    578f:	48 01 f0             	add    %rsi,%rax
    5792:	48 05 28 02 00 00    	add    $0x228,%rax
    5798:	80 38 00             	cmpb   $0x0,(%rax)
    579b:	0f 85 80 00 00 00    	jne    5821 <e52+0x101>
    57a1:	e8 ea 6a 00 00       	call   c290 <f52>
    57a6:	48 89 c1             	mov    %rax,%rcx
    57a9:	48 2b 0d 00 da 00 00 	sub    0xda00(%rip),%rcx        # 131b0 <fwp_gc+0x1030>
    57b0:	48 8b 15 21 da 00 00 	mov    0xda21(%rip),%rdx        # 131d8 <fwp_gc+0x1058>
    57b7:	48 c1 e2 10          	shl    $0x10,%rdx
    57bb:	48 39 d1             	cmp    %rdx,%rcx
    57be:	73 5f                	jae    581f <e52+0xff>
    57c0:	48 8b 15 31 da 00 00 	mov    0xda31(%rip),%rdx        # 131f8 <fwp_gc+0x1078>
    57c7:	48 89 ce             	mov    %rcx,%rsi
    57ca:	48 c1 ee 10          	shr    $0x10,%rsi
    57ce:	48 69 f6 28 12 00 00 	imul   $0x1228,%rsi,%rsi
    57d5:	0f b6 3c 32          	movzbl (%rdx,%rsi,1),%edi
    57d9:	48 81 e1 ff ff 00 00 	and    $0xffff,%rcx
    57e0:	75 18                	jne    57fa <e52+0xda>
    57e2:	40 80 ff 02          	cmp    $0x2,%dil
    57e6:	75 12                	jne    57fa <e52+0xda>
    57e8:	48 8d 0c 32          	lea    (%rdx,%rsi,1),%rcx
    57ec:	48 81 c1 28 02 00 00 	add    $0x228,%rcx
    57f3:	80 39 00             	cmpb   $0x0,(%rcx)
    57f6:	74 27                	je     581f <e52+0xff>
    57f8:	eb 27                	jmp    5821 <e52+0x101>
    57fa:	40 80 ff 01          	cmp    $0x1,%dil
    57fe:	75 1f                	jne    581f <e52+0xff>
    5800:	48 8d 3c 32          	lea    (%rdx,%rsi,1),%rdi
    5804:	8b 54 32 20          	mov    0x20(%rdx,%rsi,1),%edx
    5808:	48 0f af ca          	imul   %rdx,%rcx
    580c:	48 c1 e9 20          	shr    $0x20,%rcx
    5810:	48 01 f9             	add    %rdi,%rcx
    5813:	48 81 c1 28 02 00 00 	add    $0x228,%rcx
    581a:	80 39 00             	cmpb   $0x0,(%rcx)
    581d:	75 02                	jne    5821 <e52+0x101>
    581f:	59                   	pop    %rcx
    5820:	c3                   	ret
    5821:	e8 3a 0a 00 00       	call   6260 <fwp_flush>
    5826:	48 8b 05 b3 c7 00 00 	mov    0xc7b3(%rip),%rax        # 11fe0 <stderr@GLIBC_2.2.5>
    582d:	48 8b 38             	mov    (%rax),%rdi
    5830:	48 8d 35 f6 9b 00 00 	lea    0x9bf6(%rip),%rsi        # f42d <fwp_segv.msg+0x1ed>
    5837:	48 8d 15 c2 9b 00 00 	lea    0x9bc2(%rip),%rdx        # f400 <fwp_segv.msg+0x1c0>
    583e:	31 c0                	xor    %eax,%eax
    5840:	e8 6b c9 ff ff       	call   21b0 <fprintf@plt>
    5845:	bf 65 00 00 00       	mov    $0x65,%edi
    584a:	e8 41 ca ff ff       	call   2290 <exit@plt>
    584f:	90                   	nop

0000000000005850 <e53>:
    5850:	50                   	push   %rax
    5851:	48 89 f8             	mov    %rdi,%rax
    5854:	48 8b 3f             	mov    (%rdi),%rdi
    5857:	48 8b 0d 52 d9 00 00 	mov    0xd952(%rip),%rcx        # 131b0 <fwp_gc+0x1030>
    585e:	48 89 fe             	mov    %rdi,%rsi
    5861:	48 29 ce             	sub    %rcx,%rsi
    5864:	48 8b 15 6d d9 00 00 	mov    0xd96d(%rip),%rdx        # 131d8 <fwp_gc+0x1058>
    586b:	48 c1 e2 10          	shl    $0x10,%rdx
    586f:	48 39 d6             	cmp    %rdx,%rsi
    5872:	73 68                	jae    58dc <e53+0x8c>
    5874:	4c 8b 05 7d d9 00 00 	mov    0xd97d(%rip),%r8        # 131f8 <fwp_gc+0x1078>
    587b:	49 89 f1             	mov    %rsi,%r9
    587e:	49 c1 e9 10          	shr    $0x10,%r9
    5882:	4d 69 c9 28 12 00 00 	imul   $0x1228,%r9,%r9
    5889:	47 0f b6 14 08       	movzbl (%r8,%r9,1),%r10d
    588e:	48 81 e6 ff ff 00 00 	and    $0xffff,%rsi
    5895:	75 1b                	jne    58b2 <e53+0x62>
    5897:	41 80 fa 02          	cmp    $0x2,%r10b
    589b:	75 15                	jne    58b2 <e53+0x62>
    589d:	4b 8d 34 08          	lea    (%r8,%r9,1),%rsi
    58a1:	48 81 c6 28 02 00 00 	add    $0x228,%rsi
    58a8:	80 3e 00             	cmpb   $0x0,(%rsi)
    58ab:	74 2f                	je     58dc <e53+0x8c>
    58ad:	e9 24 01 00 00       	jmp    59d6 <e53+0x186>
    58b2:	41 80 fa 01          	cmp    $0x1,%r10b
    58b6:	75 24                	jne    58dc <e53+0x8c>
    58b8:	4f 8d 14 08          	lea    (%r8,%r9,1),%r10
    58bc:	47 8b 44 08 20       	mov    0x20(%r8,%r9,1),%r8d
    58c1:	49 0f af f0          	imul   %r8,%rsi
    58c5:	48 c1 ee 20          	shr    $0x20,%rsi
    58c9:	4c 01 d6             	add    %r10,%rsi
    58cc:	48 81 c6 28 02 00 00 	add    $0x228,%rsi
    58d3:	80 3e 00             	cmpb   $0x0,(%rsi)
    58d6:	0f 85 fa 00 00 00    	jne    59d6 <e53+0x186>
    58dc:	48 8b 70 08          	mov    0x8(%rax),%rsi
    58e0:	48 89 f0             	mov    %rsi,%rax
    58e3:	48 29 c8             	sub    %rcx,%rax
    58e6:	48 39 d0             	cmp    %rdx,%rax
    58e9:	73 64                	jae    594f <e53+0xff>
    58eb:	48 8b 0d 06 d9 00 00 	mov    0xd906(%rip),%rcx        # 131f8 <fwp_gc+0x1078>
    58f2:	48 89 c2             	mov    %rax,%rdx
    58f5:	48 c1 ea 10          	shr    $0x10,%rdx
    58f9:	48 69 d2 28 12 00 00 	imul   $0x1228,%rdx,%rdx
    5900:	44 0f b6 04 11       	movzbl (%rcx,%rdx,1),%r8d
    5905:	48 25 ff ff 00 00    	and    $0xffff,%rax
    590b:	75 1a                	jne    5927 <e53+0xd7>
    590d:	41 80 f8 02          	cmp    $0x2,%r8b
    5911:	75 14                	jne    5927 <e53+0xd7>
    5913:	48 8d 04 11          	lea    (%rcx,%rdx,1),%rax
    5917:	48 05 28 02 00 00    	add    $0x228,%rax
    591d:	80 38 00             	cmpb   $0x0,(%rax)
    5920:	74 2d                	je     594f <e53+0xff>
    5922:	e9 af 00 00 00       	jmp    59d6 <e53+0x186>
    5927:	41 80 f8 01          	cmp    $0x1,%r8b
    592b:	75 22                	jne    594f <e53+0xff>
    592d:	4c 8d 04 11          	lea    (%rcx,%rdx,1),%r8
    5931:	8b 4c 11 20          	mov    0x20(%rcx,%rdx,1),%ecx
    5935:	48 0f af c1          	imul   %rcx,%rax
    5939:	48 c1 e8 20          	shr    $0x20,%rax
    593d:	4c 01 c0             	add    %r8,%rax
    5940:	48 05 28 02 00 00    	add    $0x228,%rax
    5946:	80 38 00             	cmpb   $0x0,(%rax)
    5949:	0f 85 87 00 00 00    	jne    59d6 <e53+0x186>
    594f:	48 8d 15 da 6f 00 00 	lea    0x6fda(%rip),%rdx        # c930 <fwp_drop10>
    5956:	e8 a5 52 00 00       	call   ac00 <fwp_p_loop_own>
    595b:	48 89 c1             	mov    %rax,%rcx
    595e:	48 2b 0d 4b d8 00 00 	sub    0xd84b(%rip),%rcx        # 131b0 <fwp_gc+0x1030>
    5965:	48 8b 15 6c d8 00 00 	mov    0xd86c(%rip),%rdx        # 131d8 <fwp_gc+0x1058>
    596c:	48 c1 e2 10          	shl    $0x10,%rdx
    5970:	48 39 d1             	cmp    %rdx,%rcx
    5973:	73 5f                	jae    59d4 <e53+0x184>
    5975:	48 8b 15 7c d8 00 00 	mov    0xd87c(%rip),%rdx        # 131f8 <fwp_gc+0x1078>
    597c:	48 89 ce             	mov    %rcx,%rsi
    597f:	48 c1 ee 10          	shr    $0x10,%rsi
    5983:	48 69 f6 28 12 00 00 	imul   $0x1228,%rsi,%rsi
    598a:	0f b6 3c 32          	movzbl (%rdx,%rsi,1),%edi
    598e:	48 81 e1 ff ff 00 00 	and    $0xffff,%rcx
    5995:	75 18                	jne    59af <e53+0x15f>
    5997:	40 80 ff 02          	cmp    $0x2,%dil
    599b:	75 12                	jne    59af <e53+0x15f>
    599d:	48 8d 0c 32          	lea    (%rdx,%rsi,1),%rcx
    59a1:	48 81 c1 28 02 00 00 	add    $0x228,%rcx
    59a8:	80 39 00             	cmpb   $0x0,(%rcx)
    59ab:	74 27                	je     59d4 <e53+0x184>
    59ad:	eb 27                	jmp    59d6 <e53+0x186>
    59af:	40 80 ff 01          	cmp    $0x1,%dil
    59b3:	75 1f                	jne    59d4 <e53+0x184>
    59b5:	48 8d 3c 32          	lea    (%rdx,%rsi,1),%rdi
    59b9:	8b 54 32 20          	mov    0x20(%rdx,%rsi,1),%edx
    59bd:	48 0f af ca          	imul   %rdx,%rcx
    59c1:	48 c1 e9 20          	shr    $0x20,%rcx
    59c5:	48 01 f9             	add    %rdi,%rcx
    59c8:	48 81 c1 28 02 00 00 	add    $0x228,%rcx
    59cf:	80 39 00             	cmpb   $0x0,(%rcx)
    59d2:	75 02                	jne    59d6 <e53+0x186>
    59d4:	59                   	pop    %rcx
    59d5:	c3                   	ret
    59d6:	e8 85 08 00 00       	call   6260 <fwp_flush>
    59db:	48 8b 05 fe c5 00 00 	mov    0xc5fe(%rip),%rax        # 11fe0 <stderr@GLIBC_2.2.5>
    59e2:	48 8b 38             	mov    (%rax),%rdi
    59e5:	48 8d 35 41 9a 00 00 	lea    0x9a41(%rip),%rsi        # f42d <fwp_segv.msg+0x1ed>
    59ec:	48 8d 15 0d 9a 00 00 	lea    0x9a0d(%rip),%rdx        # f400 <fwp_segv.msg+0x1c0>
    59f3:	31 c0                	xor    %eax,%eax
    59f5:	e8 b6 c7 ff ff       	call   21b0 <fprintf@plt>
    59fa:	bf 65 00 00 00       	mov    $0x65,%edi
    59ff:	e8 8c c8 ff ff       	call   2290 <exit@plt>
    5a04:	66 66 66 2e 0f 1f 84 	data16 data16 cs nopw 0x0(%rax,%rax,1)
    5a0b:	00 00 00 00 00 

0000000000005a10 <e54>:
    5a10:	50                   	push   %rax
    5a11:	48 8b 77 08          	mov    0x8(%rdi),%rsi
    5a15:	48 89 f0             	mov    %rsi,%rax
    5a18:	48 2b 05 91 d7 00 00 	sub    0xd791(%rip),%rax        # 131b0 <fwp_gc+0x1030>
    5a1f:	48 8b 0d b2 d7 00 00 	mov    0xd7b2(%rip),%rcx        # 131d8 <fwp_gc+0x1058>
    5a26:	48 c1 e1 10          	shl    $0x10,%rcx
    5a2a:	48 39 c8             	cmp    %rcx,%rax
    5a2d:	73 64                	jae    5a93 <e54+0x83>
    5a2f:	48 8b 0d c2 d7 00 00 	mov    0xd7c2(%rip),%rcx        # 131f8 <fwp_gc+0x1078>
    5a36:	48 89 c2             	mov    %rax,%rdx
    5a39:	48 c1 ea 10          	shr    $0x10,%rdx
    5a3d:	48 69 d2 28 12 00 00 	imul   $0x1228,%rdx,%rdx
    5a44:	44 0f b6 04 11       	movzbl (%rcx,%rdx,1),%r8d
    5a49:	48 25 ff ff 00 00    	and    $0xffff,%rax
    5a4f:	75 1a                	jne    5a6b <e54+0x5b>
    5a51:	41 80 f8 02          	cmp    $0x2,%r8b
    5a55:	75 14                	jne    5a6b <e54+0x5b>
    5a57:	48 8d 04 11          	lea    (%rcx,%rdx,1),%rax
    5a5b:	48 05 28 02 00 00    	add    $0x228,%rax
    5a61:	80 38 00             	cmpb   $0x0,(%rax)
    5a64:	74 2d                	je     5a93 <e54+0x83>
    5a66:	e9 b2 00 00 00       	jmp    5b1d <e54+0x10d>
    5a6b:	41 80 f8 01          	cmp    $0x1,%r8b
    5a6f:	75 22                	jne    5a93 <e54+0x83>
    5a71:	4c 8d 04 11          	lea    (%rcx,%rdx,1),%r8
    5a75:	8b 4c 11 20          	mov    0x20(%rcx,%rdx,1),%ecx
    5a79:	48 0f af c1          	imul   %rcx,%rax
    5a7d:	48 c1 e8 20          	shr    $0x20,%rax
    5a81:	4c 01 c0             	add    %r8,%rax
    5a84:	48 05 28 02 00 00    	add    $0x228,%rax
    5a8a:	80 38 00             	cmpb   $0x0,(%rax)
    5a8d:	0f 85 8a 00 00 00    	jne    5b1d <e54+0x10d>
    5a93:	48 8b 3f             	mov    (%rdi),%rdi
    5a96:	48 8d 15 13 c2 00 00 	lea    0xc213(%rip),%rdx        # 11cb0 <d1>
    5a9d:	e8 6e 41 00 00       	call   9c10 <fwp_p_array_get_typed>
    5aa2:	48 89 c1             	mov    %rax,%rcx
    5aa5:	48 2b 0d 04 d7 00 00 	sub    0xd704(%rip),%rcx        # 131b0 <fwp_gc+0x1030>
    5aac:	48 8b 15 25 d7 00 00 	mov    0xd725(%rip),%rdx        # 131d8 <fwp_gc+0x1058>
    5ab3:	48 c1 e2 10          	shl    $0x10,%rdx
    5ab7:	48 39 d1             	cmp    %rdx,%rcx
    5aba:	73 5f                	jae    5b1b <e54+0x10b>
    5abc:	48 8b 15 35 d7 00 00 	mov    0xd735(%rip),%rdx        # 131f8 <fwp_gc+0x1078>
    5ac3:	48 89 ce             	mov    %rcx,%rsi
    5ac6:	48 c1 ee 10          	shr    $0x10,%rsi
    5aca:	48 69 f6 28 12 00 00 	imul   $0x1228,%rsi,%rsi
    5ad1:	0f b6 3c 32          	movzbl (%rdx,%rsi,1),%edi
    5ad5:	48 81 e1 ff ff 00 00 	and    $0xffff,%rcx
    5adc:	75 18                	jne    5af6 <e54+0xe6>
    5ade:	40 80 ff 02          	cmp    $0x2,%dil
    5ae2:	75 12                	jne    5af6 <e54+0xe6>
    5ae4:	48 8d 0c 32          	lea    (%rdx,%rsi,1),%rcx
    5ae8:	48 81 c1 28 02 00 00 	add    $0x228,%rcx
    5aef:	80 39 00             	cmpb   $0x0,(%rcx)
    5af2:	74 27                	je     5b1b <e54+0x10b>
    5af4:	eb 27                	jmp    5b1d <e54+0x10d>
    5af6:	40 80 ff 01          	cmp    $0x1,%dil
    5afa:	75 1f                	jne    5b1b <e54+0x10b>
    5afc:	48 8d 3c 32          	lea    (%rdx,%rsi,1),%rdi
    5b00:	8b 54 32 20          	mov    0x20(%rdx,%rsi,1),%edx
    5b04:	48 0f af ca          	imul   %rdx,%rcx
    5b08:	48 c1 e9 20          	shr    $0x20,%rcx
    5b0c:	48 01 f9             	add    %rdi,%rcx
    5b0f:	48 81 c1 28 02 00 00 	add    $0x228,%rcx
    5b16:	80 39 00             	cmpb   $0x0,(%rcx)
    5b19:	75 02                	jne    5b1d <e54+0x10d>
    5b1b:	59                   	pop    %rcx
    5b1c:	c3                   	ret
    5b1d:	e8 3e 07 00 00       	call   6260 <fwp_flush>
    5b22:	48 8b 05 b7 c4 00 00 	mov    0xc4b7(%rip),%rax        # 11fe0 <stderr@GLIBC_2.2.5>
    5b29:	48 8b 38             	mov    (%rax),%rdi
    5b2c:	48 8d 35 fa 98 00 00 	lea    0x98fa(%rip),%rsi        # f42d <fwp_segv.msg+0x1ed>
    5b33:	48 8d 15 c6 98 00 00 	lea    0x98c6(%rip),%rdx        # f400 <fwp_segv.msg+0x1c0>
    5b3a:	31 c0                	xor    %eax,%eax
    5b3c:	e8 6f c6 ff ff       	call   21b0 <fprintf@plt>
    5b41:	bf 65 00 00 00       	mov    $0x65,%edi
    5b46:	e8 45 c7 ff ff       	call   2290 <exit@plt>
    5b4b:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)

0000000000005b50 <e55>:
    5b50:	50                   	push   %rax
    5b51:	48 8b 3f             	mov    (%rdi),%rdi
    5b54:	48 89 f8             	mov    %rdi,%rax
    5b57:	48 2b 05 52 d6 00 00 	sub    0xd652(%rip),%rax        # 131b0 <fwp_gc+0x1030>
    5b5e:	48 8b 0d 73 d6 00 00 	mov    0xd673(%rip),%rcx        # 131d8 <fwp_gc+0x1058>
    5b65:	48 c1 e1 10          	shl    $0x10,%rcx
    5b69:	48 39 c8             	cmp    %rcx,%rax
    5b6c:	73 63                	jae    5bd1 <e55+0x81>
    5b6e:	48 8b 0d 83 d6 00 00 	mov    0xd683(%rip),%rcx        # 131f8 <fwp_gc+0x1078>
    5b75:	48 89 c2             	mov    %rax,%rdx
    5b78:	48 c1 ea 10          	shr    $0x10,%rdx
    5b7c:	48 69 d2 28 12 00 00 	imul   $0x1228,%rdx,%rdx
    5b83:	0f b6 34 11          	movzbl (%rcx,%rdx,1),%esi
    5b87:	48 25 ff ff 00 00    	and    $0xffff,%rax
    5b8d:	75 1a                	jne    5ba9 <e55+0x59>
    5b8f:	40 80 fe 02          	cmp    $0x2,%sil
    5b93:	75 14                	jne    5ba9 <e55+0x59>
    5b95:	48 8d 04 11          	lea    (%rcx,%rdx,1),%rax
    5b99:	48 05 28 02 00 00    	add    $0x228,%rax
    5b9f:	80 38 00             	cmpb   $0x0,(%rax)
    5ba2:	74 2d                	je     5bd1 <e55+0x81>
    5ba4:	e9 a8 00 00 00       	jmp    5c51 <e55+0x101>
    5ba9:	40 80 fe 01          	cmp    $0x1,%sil
    5bad:	75 22                	jne    5bd1 <e55+0x81>
    5baf:	48 8d 34 11          	lea    (%rcx,%rdx,1),%rsi
    5bb3:	8b 4c 11 20          	mov    0x20(%rcx,%rdx,1),%ecx
    5bb7:	48 0f af c1          	imul   %rcx,%rax
    5bbb:	48 c1 e8 20          	shr    $0x20,%rax
    5bbf:	48 01 f0             	add    %rsi,%rax
    5bc2:	48 05 28 02 00 00    	add    $0x228,%rax
    5bc8:	80 38 00             	cmpb   $0x0,(%rax)
    5bcb:	0f 85 80 00 00 00    	jne    5c51 <e55+0x101>
    5bd1:	e8 1a 6e 00 00       	call   c9f0 <f55>
    5bd6:	48 89 c1             	mov    %rax,%rcx
    5bd9:	48 2b 0d d0 d5 00 00 	sub    0xd5d0(%rip),%rcx        # 131b0 <fwp_gc+0x1030>
    5be0:	48 8b 15 f1 d5 00 00 	mov    0xd5f1(%rip),%rdx        # 131d8 <fwp_gc+0x1058>
    5be7:	48 c1 e2 10          	shl    $0x10,%rdx
    5beb:	48 39 d1             	cmp    %rdx,%rcx
    5bee:	73 5f                	jae    5c4f <e55+0xff>
    5bf0:	48 8b 15 01 d6 00 00 	mov    0xd601(%rip),%rdx        # 131f8 <fwp_gc+0x1078>
    5bf7:	48 89 ce             	mov    %rcx,%rsi
    5bfa:	48 c1 ee 10          	shr    $0x10,%rsi
    5bfe:	48 69 f6 28 12 00 00 	imul   $0x1228,%rsi,%rsi
    5c05:	0f b6 3c 32          	movzbl (%rdx,%rsi,1),%edi
    5c09:	48 81 e1 ff ff 00 00 	and    $0xffff,%rcx
    5c10:	75 18                	jne    5c2a <e55+0xda>
    5c12:	40 80 ff 02          	cmp    $0x2,%dil
    5c16:	75 12                	jne    5c2a <e55+0xda>
    5c18:	48 8d 0c 32          	lea    (%rdx,%rsi,1),%rcx
    5c1c:	48 81 c1 28 02 00 00 	add    $0x228,%rcx
    5c23:	80 39 00             	cmpb   $0x0,(%rcx)
    5c26:	74 27                	je     5c4f <e55+0xff>
    5c28:	eb 27                	jmp    5c51 <e55+0x101>
    5c2a:	40 80 ff 01          	cmp    $0x1,%dil
    5c2e:	75 1f                	jne    5c4f <e55+0xff>
    5c30:	48 8d 3c 32          	lea    (%rdx,%rsi,1),%rdi
    5c34:	8b 54 32 20          	mov    0x20(%rdx,%rsi,1),%edx
    5c38:	48 0f af ca          	imul   %rdx,%rcx
    5c3c:	48 c1 e9 20          	shr    $0x20,%rcx
    5c40:	48 01 f9             	add    %rdi,%rcx
    5c43:	48 81 c1 28 02 00 00 	add    $0x228,%rcx
    5c4a:	80 39 00             	cmpb   $0x0,(%rcx)
    5c4d:	75 02                	jne    5c51 <e55+0x101>
    5c4f:	59                   	pop    %rcx
    5c50:	c3                   	ret
    5c51:	e8 0a 06 00 00       	call   6260 <fwp_flush>
    5c56:	48 8b 05 83 c3 00 00 	mov    0xc383(%rip),%rax        # 11fe0 <stderr@GLIBC_2.2.5>
    5c5d:	48 8b 38             	mov    (%rax),%rdi
    5c60:	48 8d 35 c6 97 00 00 	lea    0x97c6(%rip),%rsi        # f42d <fwp_segv.msg+0x1ed>
    5c67:	48 8d 15 92 97 00 00 	lea    0x9792(%rip),%rdx        # f400 <fwp_segv.msg+0x1c0>
    5c6e:	31 c0                	xor    %eax,%eax
    5c70:	e8 3b c5 ff ff       	call   21b0 <fprintf@plt>
    5c75:	bf 65 00 00 00       	mov    $0x65,%edi
    5c7a:	e8 11 c6 ff ff       	call   2290 <exit@plt>
    5c7f:	90                   	nop

0000000000005c80 <e56>:
    5c80:	50                   	push   %rax
    5c81:	48 89 f8             	mov    %rdi,%rax
    5c84:	48 8b 3f             	mov    (%rdi),%rdi
    5c87:	48 8b 0d 22 d5 00 00 	mov    0xd522(%rip),%rcx        # 131b0 <fwp_gc+0x1030>
    5c8e:	48 89 fe             	mov    %rdi,%rsi
    5c91:	48 29 ce             	sub    %rcx,%rsi
    5c94:	48 8b 15 3d d5 00 00 	mov    0xd53d(%rip),%rdx        # 131d8 <fwp_gc+0x1058>
    5c9b:	48 c1 e2 10          	shl    $0x10,%rdx
    5c9f:	48 39 d6             	cmp    %rdx,%rsi
    5ca2:	73 68                	jae    5d0c <e56+0x8c>
    5ca4:	4c 8b 05 4d d5 00 00 	mov    0xd54d(%rip),%r8        # 131f8 <fwp_gc+0x1078>
    5cab:	49 89 f1             	mov    %rsi,%r9
    5cae:	49 c1 e9 10          	shr    $0x10,%r9
    5cb2:	4d 69 c9 28 12 00 00 	imul   $0x1228,%r9,%r9
    5cb9:	47 0f b6 14 08       	movzbl (%r8,%r9,1),%r10d
    5cbe:	48 81 e6 ff ff 00 00 	and    $0xffff,%rsi
    5cc5:	75 1b                	jne    5ce2 <e56+0x62>
    5cc7:	41 80 fa 02          	cmp    $0x2,%r10b
    5ccb:	75 15                	jne    5ce2 <e56+0x62>
    5ccd:	4b 8d 34 08          	lea    (%r8,%r9,1),%rsi
    5cd1:	48 81 c6 28 02 00 00 	add    $0x228,%rsi
    5cd8:	80 3e 00             	cmpb   $0x0,(%rsi)
    5cdb:	74 2f                	je     5d0c <e56+0x8c>
    5cdd:	e9 24 01 00 00       	jmp    5e06 <e56+0x186>
    5ce2:	41 80 fa 01          	cmp    $0x1,%r10b
    5ce6:	75 24                	jne    5d0c <e56+0x8c>
    5ce8:	4f 8d 14 08          	lea    (%r8,%r9,1),%r10
    5cec:	47 8b 44 08 20       	mov    0x20(%r8,%r9,1),%r8d
    5cf1:	49 0f af f0          	imul   %r8,%rsi
    5cf5:	48 c1 ee 20          	shr    $0x20,%rsi
    5cf9:	4c 01 d6             	add    %r10,%rsi
    5cfc:	48 81 c6 28 02 00 00 	add    $0x228,%rsi
    5d03:	80 3e 00             	cmpb   $0x0,(%rsi)
    5d06:	0f 85 fa 00 00 00    	jne    5e06 <e56+0x186>
    5d0c:	48 8b 70 08          	mov    0x8(%rax),%rsi
    5d10:	48 89 f0             	mov    %rsi,%rax
    5d13:	48 29 c8             	sub    %rcx,%rax
    5d16:	48 39 d0             	cmp    %rdx,%rax
    5d19:	73 64                	jae    5d7f <e56+0xff>
    5d1b:	48 8b 0d d6 d4 00 00 	mov    0xd4d6(%rip),%rcx        # 131f8 <fwp_gc+0x1078>
    5d22:	48 89 c2             	mov    %rax,%rdx
    5d25:	48 c1 ea 10          	shr    $0x10,%rdx
    5d29:	48 69 d2 28 12 00 00 	imul   $0x1228,%rdx,%rdx
    5d30:	44 0f b6 04 11       	movzbl (%rcx,%rdx,1),%r8d
    5d35:	48 25 ff ff 00 00    	and    $0xffff,%rax
    5d3b:	75 1a                	jne    5d57 <e56+0xd7>
    5d3d:	41 80 f8 02          	cmp    $0x2,%r8b
    5d41:	75 14                	jne    5d57 <e56+0xd7>
    5d43:	48 8d 04 11          	lea    (%rcx,%rdx,1),%rax
    5d47:	48 05 28 02 00 00    	add    $0x228,%rax
    5d4d:	80 38 00             	cmpb   $0x0,(%rax)
    5d50:	74 2d                	je     5d7f <e56+0xff>
    5d52:	e9 af 00 00 00       	jmp    5e06 <e56+0x186>
    5d57:	41 80 f8 01          	cmp    $0x1,%r8b
    5d5b:	75 22                	jne    5d7f <e56+0xff>
    5d5d:	4c 8d 04 11          	lea    (%rcx,%rdx,1),%r8
    5d61:	8b 4c 11 20          	mov    0x20(%rcx,%rdx,1),%ecx
    5d65:	48 0f af c1          	imul   %rcx,%rax
    5d69:	48 c1 e8 20          	shr    $0x20,%rax
    5d6d:	4c 01 c0             	add    %r8,%rax
    5d70:	48 05 28 02 00 00    	add    $0x228,%rax
    5d76:	80 38 00             	cmpb   $0x0,(%rax)
    5d79:	0f 85 87 00 00 00    	jne    5e06 <e56+0x186>
    5d7f:	48 8d 15 5a 73 00 00 	lea    0x735a(%rip),%rdx        # d0e0 <fwp_drop13>
    5d86:	e8 75 4e 00 00       	call   ac00 <fwp_p_loop_own>
    5d8b:	48 89 c1             	mov    %rax,%rcx
    5d8e:	48 2b 0d 1b d4 00 00 	sub    0xd41b(%rip),%rcx        # 131b0 <fwp_gc+0x1030>
    5d95:	48 8b 15 3c d4 00 00 	mov    0xd43c(%rip),%rdx        # 131d8 <fwp_gc+0x1058>
    5d9c:	48 c1 e2 10          	shl    $0x10,%rdx
    5da0:	48 39 d1             	cmp    %rdx,%rcx
    5da3:	73 5f                	jae    5e04 <e56+0x184>
    5da5:	48 8b 15 4c d4 00 00 	mov    0xd44c(%rip),%rdx        # 131f8 <fwp_gc+0x1078>
    5dac:	48 89 ce             	mov    %rcx,%rsi
    5daf:	48 c1 ee 10          	shr    $0x10,%rsi
    5db3:	48 69 f6 28 12 00 00 	imul   $0x1228,%rsi,%rsi
    5dba:	0f b6 3c 32          	movzbl (%rdx,%rsi,1),%edi
    5dbe:	48 81 e1 ff ff 00 00 	and    $0xffff,%rcx
    5dc5:	75 18                	jne    5ddf <e56+0x15f>
    5dc7:	40 80 ff 02          	cmp    $0x2,%dil
    5dcb:	75 12                	jne    5ddf <e56+0x15f>
    5dcd:	48 8d 0c 32          	lea    (%rdx,%rsi,1),%rcx
    5dd1:	48 81 c1 28 02 00 00 	add    $0x228,%rcx
    5dd8:	80 39 00             	cmpb   $0x0,(%rcx)
    5ddb:	74 27                	je     5e04 <e56+0x184>
    5ddd:	eb 27                	jmp    5e06 <e56+0x186>
    5ddf:	40 80 ff 01          	cmp    $0x1,%dil
    5de3:	75 1f                	jne    5e04 <e56+0x184>
    5de5:	48 8d 3c 32          	lea    (%rdx,%rsi,1),%rdi
    5de9:	8b 54 32 20          	mov    0x20(%rdx,%rsi,1),%edx
    5ded:	48 0f af ca          	imul   %rdx,%rcx
    5df1:	48 c1 e9 20          	shr    $0x20,%rcx
    5df5:	48 01 f9             	add    %rdi,%rcx
    5df8:	48 81 c1 28 02 00 00 	add    $0x228,%rcx
    5dff:	80 39 00             	cmpb   $0x0,(%rcx)
    5e02:	75 02                	jne    5e06 <e56+0x186>
    5e04:	59                   	pop    %rcx
    5e05:	c3                   	ret
    5e06:	e8 55 04 00 00       	call   6260 <fwp_flush>
    5e0b:	48 8b 05 ce c1 00 00 	mov    0xc1ce(%rip),%rax        # 11fe0 <stderr@GLIBC_2.2.5>
    5e12:	48 8b 38             	mov    (%rax),%rdi
    5e15:	48 8d 35 11 96 00 00 	lea    0x9611(%rip),%rsi        # f42d <fwp_segv.msg+0x1ed>
    5e1c:	48 8d 15 dd 95 00 00 	lea    0x95dd(%rip),%rdx        # f400 <fwp_segv.msg+0x1c0>
    5e23:	31 c0                	xor    %eax,%eax
    5e25:	e8 86 c3 ff ff       	call   21b0 <fprintf@plt>
    5e2a:	bf 65 00 00 00       	mov    $0x65,%edi
    5e2f:	e8 5c c4 ff ff       	call   2290 <exit@plt>
    5e34:	66 66 66 2e 0f 1f 84 	data16 data16 cs nopw 0x0(%rax,%rax,1)
    5e3b:	00 00 00 00 00 

0000000000005e40 <e57>:
    5e40:	50                   	push   %rax
    5e41:	48 8b 3f             	mov    (%rdi),%rdi
    5e44:	48 89 f8             	mov    %rdi,%rax
    5e47:	48 2b 05 62 d3 00 00 	sub    0xd362(%rip),%rax        # 131b0 <fwp_gc+0x1030>
    5e4e:	48 8b 0d 83 d3 00 00 	mov    0xd383(%rip),%rcx        # 131d8 <fwp_gc+0x1058>
    5e55:	48 c1 e1 10          	shl    $0x10,%rcx
    5e59:	48 39 c8             	cmp    %rcx,%rax
    5e5c:	73 63                	jae    5ec1 <e57+0x81>
    5e5e:	48 8b 0d 93 d3 00 00 	mov    0xd393(%rip),%rcx        # 131f8 <fwp_gc+0x1078>
    5e65:	48 89 c2             	mov    %rax,%rdx
    5e68:	48 c1 ea 10          	shr    $0x10,%rdx
    5e6c:	48 69 d2 28 12 00 00 	imul   $0x1228,%rdx,%rdx
    5e73:	0f b6 34 11          	movzbl (%rcx,%rdx,1),%esi
    5e77:	48 25 ff ff 00 00    	and    $0xffff,%rax
    5e7d:	75 1a                	jne    5e99 <e57+0x59>
    5e7f:	40 80 fe 02          	cmp    $0x2,%sil
    5e83:	75 14                	jne    5e99 <e57+0x59>
    5e85:	48 8d 04 11          	lea    (%rcx,%rdx,1),%rax
    5e89:	48 05 28 02 00 00    	add    $0x228,%rax
    5e8f:	80 38 00             	cmpb   $0x0,(%rax)
    5e92:	74 2d                	je     5ec1 <e57+0x81>
    5e94:	e9 a8 00 00 00       	jmp    5f41 <e57+0x101>
    5e99:	40 80 fe 01          	cmp    $0x1,%sil
    5e9d:	75 22                	jne    5ec1 <e57+0x81>
    5e9f:	48 8d 34 11          	lea    (%rcx,%rdx,1),%rsi
    5ea3:	8b 4c 11 20          	mov    0x20(%rcx,%rdx,1),%ecx
    5ea7:	48 0f af c1          	imul   %rcx,%rax
    5eab:	48 c1 e8 20          	shr    $0x20,%rax
    5eaf:	48 01 f0             	add    %rsi,%rax
    5eb2:	48 05 28 02 00 00    	add    $0x228,%rax
    5eb8:	80 38 00             	cmpb   $0x0,(%rax)
    5ebb:	0f 85 80 00 00 00    	jne    5f41 <e57+0x101>
    5ec1:	e8 da 72 00 00       	call   d1a0 <f57>
    5ec6:	48 89 c1             	mov    %rax,%rcx
    5ec9:	48 2b 0d e0 d2 00 00 	sub    0xd2e0(%rip),%rcx        # 131b0 <fwp_gc+0x1030>
    5ed0:	48 8b 15 01 d3 00 00 	mov    0xd301(%rip),%rdx        # 131d8 <fwp_gc+0x1058>
    5ed7:	48 c1 e2 10          	shl    $0x10,%rdx
    5edb:	48 39 d1             	cmp    %rdx,%rcx
    5ede:	73 5f                	jae    5f3f <e57+0xff>
    5ee0:	48 8b 15 11 d3 00 00 	mov    0xd311(%rip),%rdx        # 131f8 <fwp_gc+0x1078>
    5ee7:	48 89 ce             	mov    %rcx,%rsi
    5eea:	48 c1 ee 10          	shr    $0x10,%rsi
    5eee:	48 69 f6 28 12 00 00 	imul   $0x1228,%rsi,%rsi
    5ef5:	0f b6 3c 32          	movzbl (%rdx,%rsi,1),%edi
    5ef9:	48 81 e1 ff ff 00 00 	and    $0xffff,%rcx
    5f00:	75 18                	jne    5f1a <e57+0xda>
    5f02:	40 80 ff 02          	cmp    $0x2,%dil
    5f06:	75 12                	jne    5f1a <e57+0xda>
    5f08:	48 8d 0c 32          	lea    (%rdx,%rsi,1),%rcx
    5f0c:	48 81 c1 28 02 00 00 	add    $0x228,%rcx
    5f13:	80 39 00             	cmpb   $0x0,(%rcx)
    5f16:	74 27                	je     5f3f <e57+0xff>
    5f18:	eb 27                	jmp    5f41 <e57+0x101>
    5f1a:	40 80 ff 01          	cmp    $0x1,%dil
    5f1e:	75 1f                	jne    5f3f <e57+0xff>
    5f20:	48 8d 3c 32          	lea    (%rdx,%rsi,1),%rdi
    5f24:	8b 54 32 20          	mov    0x20(%rdx,%rsi,1),%edx
    5f28:	48 0f af ca          	imul   %rdx,%rcx
    5f2c:	48 c1 e9 20          	shr    $0x20,%rcx
    5f30:	48 01 f9             	add    %rdi,%rcx
    5f33:	48 81 c1 28 02 00 00 	add    $0x228,%rcx
    5f3a:	80 39 00             	cmpb   $0x0,(%rcx)
    5f3d:	75 02                	jne    5f41 <e57+0x101>
    5f3f:	59                   	pop    %rcx
    5f40:	c3                   	ret
    5f41:	e8 1a 03 00 00       	call   6260 <fwp_flush>
    5f46:	48 8b 05 93 c0 00 00 	mov    0xc093(%rip),%rax        # 11fe0 <stderr@GLIBC_2.2.5>
    5f4d:	48 8b 38             	mov    (%rax),%rdi
    5f50:	48 8d 35 d6 94 00 00 	lea    0x94d6(%rip),%rsi        # f42d <fwp_segv.msg+0x1ed>
    5f57:	48 8d 15 a2 94 00 00 	lea    0x94a2(%rip),%rdx        # f400 <fwp_segv.msg+0x1c0>
    5f5e:	31 c0                	xor    %eax,%eax
    5f60:	e8 4b c2 ff ff       	call   21b0 <fprintf@plt>
    5f65:	bf 65 00 00 00       	mov    $0x65,%edi
    5f6a:	e8 21 c3 ff ff       	call   2290 <exit@plt>
    5f6f:	90                   	nop

0000000000005f70 <e58>:
    5f70:	50                   	push   %rax
    5f71:	48 89 f8             	mov    %rdi,%rax
    5f74:	48 8b 3f             	mov    (%rdi),%rdi
    5f77:	48 8b 0d 32 d2 00 00 	mov    0xd232(%rip),%rcx        # 131b0 <fwp_gc+0x1030>
    5f7e:	48 89 fe             	mov    %rdi,%rsi
    5f81:	48 29 ce             	sub    %rcx,%rsi
    5f84:	48 8b 15 4d d2 00 00 	mov    0xd24d(%rip),%rdx        # 131d8 <fwp_gc+0x1058>
    5f8b:	48 c1 e2 10          	shl    $0x10,%rdx
    5f8f:	48 39 d6             	cmp    %rdx,%rsi
    5f92:	73 68                	jae    5ffc <e58+0x8c>
    5f94:	4c 8b 05 5d d2 00 00 	mov    0xd25d(%rip),%r8        # 131f8 <fwp_gc+0x1078>
    5f9b:	49 89 f1             	mov    %rsi,%r9
    5f9e:	49 c1 e9 10          	shr    $0x10,%r9
    5fa2:	4d 69 c9 28 12 00 00 	imul   $0x1228,%r9,%r9
    5fa9:	47 0f b6 14 08       	movzbl (%r8,%r9,1),%r10d
    5fae:	48 81 e6 ff ff 00 00 	and    $0xffff,%rsi
    5fb5:	75 1b                	jne    5fd2 <e58+0x62>
    5fb7:	41 80 fa 02          	cmp    $0x2,%r10b
    5fbb:	75 15                	jne    5fd2 <e58+0x62>
    5fbd:	4b 8d 34 08          	lea    (%r8,%r9,1),%rsi
    5fc1:	48 81 c6 28 02 00 00 	add    $0x228,%rsi
    5fc8:	80 3e 00             	cmpb   $0x0,(%rsi)
    5fcb:	74 2f                	je     5ffc <e58+0x8c>
    5fcd:	e9 24 01 00 00       	jmp    60f6 <e58+0x186>
    5fd2:	41 80 fa 01          	cmp    $0x1,%r10b
    5fd6:	75 24                	jne    5ffc <e58+0x8c>
    5fd8:	4f 8d 14 08          	lea    (%r8,%r9,1),%r10
    5fdc:	47 8b 44 08 20       	mov    0x20(%r8,%r9,1),%r8d
    5fe1:	49 0f af f0          	imul   %r8,%rsi
    5fe5:	48 c1 ee 20          	shr    $0x20,%rsi
    5fe9:	4c 01 d6             	add    %r10,%rsi
    5fec:	48 81 c6 28 02 00 00 	add    $0x228,%rsi
    5ff3:	80 3e 00             	cmpb   $0x0,(%rsi)
    5ff6:	0f 85 fa 00 00 00    	jne    60f6 <e58+0x186>
    5ffc:	48 8b 70 08          	mov    0x8(%rax),%rsi
    6000:	48 89 f0             	mov    %rsi,%rax
    6003:	48 29 c8             	sub    %rcx,%rax
    6006:	48 39 d0             	cmp    %rdx,%rax
    6009:	73 64                	jae    606f <e58+0xff>
    600b:	48 8b 0d e6 d1 00 00 	mov    0xd1e6(%rip),%rcx        # 131f8 <fwp_gc+0x1078>
    6012:	48 89 c2             	mov    %rax,%rdx
    6015:	48 c1 ea 10          	shr    $0x10,%rdx
    6019:	48 69 d2 28 12 00 00 	imul   $0x1228,%rdx,%rdx
    6020:	44 0f b6 04 11       	movzbl (%rcx,%rdx,1),%r8d
    6025:	48 25 ff ff 00 00    	and    $0xffff,%rax
    602b:	75 1a                	jne    6047 <e58+0xd7>
    602d:	41 80 f8 02          	cmp    $0x2,%r8b
    6031:	75 14                	jne    6047 <e58+0xd7>
    6033:	48 8d 04 11          	lea    (%rcx,%rdx,1),%rax
    6037:	48 05 28 02 00 00    	add    $0x228,%rax
    603d:	80 38 00             	cmpb   $0x0,(%rax)
    6040:	74 2d                	je     606f <e58+0xff>
    6042:	e9 af 00 00 00       	jmp    60f6 <e58+0x186>
    6047:	41 80 f8 01          	cmp    $0x1,%r8b
    604b:	75 22                	jne    606f <e58+0xff>
    604d:	4c 8d 04 11          	lea    (%rcx,%rdx,1),%r8
    6051:	8b 4c 11 20          	mov    0x20(%rcx,%rdx,1),%ecx
    6055:	48 0f af c1          	imul   %rcx,%rax
    6059:	48 c1 e8 20          	shr    $0x20,%rax
    605d:	4c 01 c0             	add    %r8,%rax
    6060:	48 05 28 02 00 00    	add    $0x228,%rax
    6066:	80 38 00             	cmpb   $0x0,(%rax)
    6069:	0f 85 87 00 00 00    	jne    60f6 <e58+0x186>
    606f:	48 8d 15 3a 77 00 00 	lea    0x773a(%rip),%rdx        # d7b0 <fwp_drop15>
    6076:	e8 85 4b 00 00       	call   ac00 <fwp_p_loop_own>
    607b:	48 89 c1             	mov    %rax,%rcx
    607e:	48 2b 0d 2b d1 00 00 	sub    0xd12b(%rip),%rcx        # 131b0 <fwp_gc+0x1030>
    6085:	48 8b 15 4c d1 00 00 	mov    0xd14c(%rip),%rdx        # 131d8 <fwp_gc+0x1058>
    608c:	48 c1 e2 10          	shl    $0x10,%rdx
    6090:	48 39 d1             	cmp    %rdx,%rcx
    6093:	73 5f                	jae    60f4 <e58+0x184>
    6095:	48 8b 15 5c d1 00 00 	mov    0xd15c(%rip),%rdx        # 131f8 <fwp_gc+0x1078>
    609c:	48 89 ce             	mov    %rcx,%rsi
    609f:	48 c1 ee 10          	shr    $0x10,%rsi
    60a3:	48 69 f6 28 12 00 00 	imul   $0x1228,%rsi,%rsi
    60aa:	0f b6 3c 32          	movzbl (%rdx,%rsi,1),%edi
    60ae:	48 81 e1 ff ff 00 00 	and    $0xffff,%rcx
    60b5:	75 18                	jne    60cf <e58+0x15f>
    60b7:	40 80 ff 02          	cmp    $0x2,%dil
    60bb:	75 12                	jne    60cf <e58+0x15f>
    60bd:	48 8d 0c 32          	lea    (%rdx,%rsi,1),%rcx
    60c1:	48 81 c1 28 02 00 00 	add    $0x228,%rcx
    60c8:	80 39 00             	cmpb   $0x0,(%rcx)
    60cb:	74 27                	je     60f4 <e58+0x184>
    60cd:	eb 27                	jmp    60f6 <e58+0x186>
    60cf:	40 80 ff 01          	cmp    $0x1,%dil
    60d3:	75 1f                	jne    60f4 <e58+0x184>
    60d5:	48 8d 3c 32          	lea    (%rdx,%rsi,1),%rdi
    60d9:	8b 54 32 20          	mov    0x20(%rdx,%rsi,1),%edx
    60dd:	48 0f af ca          	imul   %rdx,%rcx
    60e1:	48 c1 e9 20          	shr    $0x20,%rcx
    60e5:	48 01 f9             	add    %rdi,%rcx
    60e8:	48 81 c1 28 02 00 00 	add    $0x228,%rcx
    60ef:	80 39 00             	cmpb   $0x0,(%rcx)
    60f2:	75 02                	jne    60f6 <e58+0x186>
    60f4:	59                   	pop    %rcx
    60f5:	c3                   	ret
    60f6:	e8 65 01 00 00       	call   6260 <fwp_flush>
    60fb:	48 8b 05 de be 00 00 	mov    0xbede(%rip),%rax        # 11fe0 <stderr@GLIBC_2.2.5>
    6102:	48 8b 38             	mov    (%rax),%rdi
    6105:	48 8d 35 21 93 00 00 	lea    0x9321(%rip),%rsi        # f42d <fwp_segv.msg+0x1ed>
    610c:	48 8d 15 ed 92 00 00 	lea    0x92ed(%rip),%rdx        # f400 <fwp_segv.msg+0x1c0>
    6113:	31 c0                	xor    %eax,%eax
    6115:	e8 96 c0 ff ff       	call   21b0 <fprintf@plt>
    611a:	bf 65 00 00 00       	mov    $0x65,%edi
    611f:	e8 6c c1 ff ff       	call   2290 <exit@plt>
    6124:	66 66 66 2e 0f 1f 84 	data16 data16 cs nopw 0x0(%rax,%rax,1)
    612b:	00 00 00 00 00 

0000000000006130 <e59>:
    6130:	50                   	push   %rax
    6131:	48 8b 3f             	mov    (%rdi),%rdi
    6134:	48 89 f8             	mov    %rdi,%rax
    6137:	48 2b 05 72 d0 00 00 	sub    0xd072(%rip),%rax        # 131b0 <fwp_gc+0x1030>
    613e:	48 8b 0d 93 d0 00 00 	mov    0xd093(%rip),%rcx        # 131d8 <fwp_gc+0x1058>
    6145:	48 c1 e1 10          	shl    $0x10,%rcx
    6149:	48 39 c8             	cmp    %rcx,%rax
    614c:	73 63                	jae    61b1 <e59+0x81>
    614e:	48 8b 0d a3 d0 00 00 	mov    0xd0a3(%rip),%rcx        # 131f8 <fwp_gc+0x1078>
    6155:	48 89 c2             	mov    %rax,%rdx
    6158:	48 c1 ea 10          	shr    $0x10,%rdx
    615c:	48 69 d2 28 12 00 00 	imul   $0x1228,%rdx,%rdx
    6163:	0f b6 34 11          	movzbl (%rcx,%rdx,1),%esi
    6167:	48 25 ff ff 00 00    	and    $0xffff,%rax
    616d:	75 1a                	jne    6189 <e59+0x59>
    616f:	40 80 fe 02          	cmp    $0x2,%sil
    6173:	75 14                	jne    6189 <e59+0x59>
    6175:	48 8d 04 11          	lea    (%rcx,%rdx,1),%rax
    6179:	48 05 28 02 00 00    	add    $0x228,%rax
    617f:	80 38 00             	cmpb   $0x0,(%rax)
    6182:	74 2d                	je     61b1 <e59+0x81>
    6184:	e9 a8 00 00 00       	jmp    6231 <e59+0x101>
    6189:	40 80 fe 01          	cmp    $0x1,%sil
    618d:	75 22                	jne    61b1 <e59+0x81>
    618f:	48 8d 34 11          	lea    (%rcx,%rdx,1),%rsi
    6193:	8b 4c 11 20          	mov    0x20(%rcx,%rdx,1),%ecx
    6197:	48 0f af c1          	imul   %rcx,%rax
    619b:	48 c1 e8 20          	shr    $0x20,%rax
    619f:	48 01 f0             	add    %rsi,%rax
    61a2:	48 05 28 02 00 00    	add    $0x228,%rax
    61a8:	80 38 00             	cmpb   $0x0,(%rax)
    61ab:	0f 85 80 00 00 00    	jne    6231 <e59+0x101>
    61b1:	e8 ba 76 00 00       	call   d870 <f59>
    61b6:	48 89 c1             	mov    %rax,%rcx
    61b9:	48 2b 0d f0 cf 00 00 	sub    0xcff0(%rip),%rcx        # 131b0 <fwp_gc+0x1030>
    61c0:	48 8b 15 11 d0 00 00 	mov    0xd011(%rip),%rdx        # 131d8 <fwp_gc+0x1058>
    61c7:	48 c1 e2 10          	shl    $0x10,%rdx
    61cb:	48 39 d1             	cmp    %rdx,%rcx
    61ce:	73 5f                	jae    622f <e59+0xff>
    61d0:	48 8b 15 21 d0 00 00 	mov    0xd021(%rip),%rdx        # 131f8 <fwp_gc+0x1078>
    61d7:	48 89 ce             	mov    %rcx,%rsi
    61da:	48 c1 ee 10          	shr    $0x10,%rsi
    61de:	48 69 f6 28 12 00 00 	imul   $0x1228,%rsi,%rsi
    61e5:	0f b6 3c 32          	movzbl (%rdx,%rsi,1),%edi
    61e9:	48 81 e1 ff ff 00 00 	and    $0xffff,%rcx
    61f0:	75 18                	jne    620a <e59+0xda>
    61f2:	40 80 ff 02          	cmp    $0x2,%dil
    61f6:	75 12                	jne    620a <e59+0xda>
    61f8:	48 8d 0c 32          	lea    (%rdx,%rsi,1),%rcx
    61fc:	48 81 c1 28 02 00 00 	add    $0x228,%rcx
    6203:	80 39 00             	cmpb   $0x0,(%rcx)
    6206:	74 27                	je     622f <e59+0xff>
    6208:	eb 27                	jmp    6231 <e59+0x101>
    620a:	40 80 ff 01          	cmp    $0x1,%dil
    620e:	75 1f                	jne    622f <e59+0xff>
    6210:	48 8d 3c 32          	lea    (%rdx,%rsi,1),%rdi
    6214:	8b 54 32 20          	mov    0x20(%rdx,%rsi,1),%edx
    6218:	48 0f af ca          	imul   %rdx,%rcx
    621c:	48 c1 e9 20          	shr    $0x20,%rcx
    6220:	48 01 f9             	add    %rdi,%rcx
    6223:	48 81 c1 28 02 00 00 	add    $0x228,%rcx
    622a:	80 39 00             	cmpb   $0x0,(%rcx)
    622d:	75 02                	jne    6231 <e59+0x101>
    622f:	59                   	pop    %rcx
    6230:	c3                   	ret
    6231:	e8 2a 00 00 00       	call   6260 <fwp_flush>
    6236:	48 8b 05 a3 bd 00 00 	mov    0xbda3(%rip),%rax        # 11fe0 <stderr@GLIBC_2.2.5>
    623d:	48 8b 38             	mov    (%rax),%rdi
    6240:	48 8d 35 e6 91 00 00 	lea    0x91e6(%rip),%rsi        # f42d <fwp_segv.msg+0x1ed>
    6247:	48 8d 15 b2 91 00 00 	lea    0x91b2(%rip),%rdx        # f400 <fwp_segv.msg+0x1c0>
    624e:	31 c0                	xor    %eax,%eax
    6250:	e8 5b bf ff ff       	call   21b0 <fprintf@plt>
    6255:	bf 65 00 00 00       	mov    $0x65,%edi
    625a:	e8 31 c0 ff ff       	call   2290 <exit@plt>
    625f:	90                   	nop

0000000000006260 <fwp_flush>:
    6260:	50                   	push   %rax
    6261:	48 8b 3d 60 d9 00 00 	mov    0xd960(%rip),%rdi        # 13bc8 <fwp_prog_out>
    6268:	48 85 ff             	test   %rdi,%rdi
    626b:	74 05                	je     6272 <fwp_flush+0x12>
    626d:	e8 8e bf ff ff       	call   2200 <fflush@plt>
    6272:	48 8b 05 47 bd 00 00 	mov    0xbd47(%rip),%rax        # 11fc0 <stdout@GLIBC_2.2.5>
    6279:	48 8b 38             	mov    (%rax),%rdi
    627c:	58                   	pop    %rax
    627d:	e9 7e bf ff ff       	jmp    2200 <fflush@plt>
    6282:	66 66 66 66 66 2e 0f 	data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    6289:	1f 84 00 00 00 00 00 

0000000000006290 <fwp_rc_forget_slot>:
    6290:	50                   	push   %rax
    6291:	80 3f ff             	cmpb   $0xff,(%rdi)
    6294:	74 02                	je     6298 <fwp_rc_forget_slot+0x8>
    6296:	58                   	pop    %rax
    6297:	c3                   	ret
    6298:	48 89 f8             	mov    %rdi,%rax
    629b:	48 c1 e8 11          	shr    $0x11,%rax
    629f:	31 f8                	xor    %edi,%eax
    62a1:	89 c1                	mov    %eax,%ecx
    62a3:	c1 e9 09             	shr    $0x9,%ecx
    62a6:	31 c1                	xor    %eax,%ecx
    62a8:	0f b6 c9             	movzbl %cl,%ecx
    62ab:	48 8d 15 ce be 00 00 	lea    0xbece(%rip),%rdx        # 12180 <fwp_gc>
    62b2:	48 8b 84 ca 18 12 00 	mov    0x1218(%rdx,%rcx,8),%rax
    62b9:	00 
    62ba:	48 85 c0             	test   %rax,%rax
    62bd:	74 4b                	je     630a <fwp_rc_forget_slot+0x7a>
    62bf:	48 39 38             	cmp    %rdi,(%rax)
    62c2:	74 23                	je     62e7 <fwp_rc_forget_slot+0x57>
    62c4:	66 66 66 2e 0f 1f 84 	data16 data16 cs nopw 0x0(%rax,%rax,1)
    62cb:	00 00 00 00 00 
    62d0:	48 89 c1             	mov    %rax,%rcx
    62d3:	48 8b 40 10          	mov    0x10(%rax),%rax
    62d7:	48 85 c0             	test   %rax,%rax
    62da:	74 2e                	je     630a <fwp_rc_forget_slot+0x7a>
    62dc:	48 39 38             	cmp    %rdi,(%rax)
    62df:	75 ef                	jne    62d0 <fwp_rc_forget_slot+0x40>
    62e1:	48 83 c1 10          	add    $0x10,%rcx
    62e5:	eb 0b                	jmp    62f2 <fwp_rc_forget_slot+0x62>
    62e7:	48 8d 0c ca          	lea    (%rdx,%rcx,8),%rcx
    62eb:	48 81 c1 18 12 00 00 	add    $0x1218,%rcx
    62f2:	48 8b 50 10          	mov    0x10(%rax),%rdx
    62f6:	48 89 11             	mov    %rdx,(%rcx)
    62f9:	48 89 c7             	mov    %rax,%rdi
    62fc:	e8 4f bd ff ff       	call   2050 <free@plt>
    6301:	48 ff 0d 90 d8 00 00 	decq   0xd890(%rip)        # 13b98 <fwp_gc+0x1a18>
    6308:	58                   	pop    %rax
    6309:	c3                   	ret
    630a:	e8 51 ff ff ff       	call   6260 <fwp_flush>
    630f:	48 8b 05 ca bc 00 00 	mov    0xbcca(%rip),%rax        # 11fe0 <stderr@GLIBC_2.2.5>
    6316:	48 8b 38             	mov    (%rax),%rdi
    6319:	48 8d 35 0d 91 00 00 	lea    0x910d(%rip),%rsi        # f42d <fwp_segv.msg+0x1ed>
    6320:	48 8d 15 15 91 00 00 	lea    0x9115(%rip),%rdx        # f43c <fwp_segv.msg+0x1fc>
    6327:	31 c0                	xor    %eax,%eax
    6329:	e8 82 be ff ff       	call   21b0 <fprintf@plt>
    632e:	bf 65 00 00 00       	mov    $0x65,%edi
    6333:	e8 58 bf ff ff       	call   2290 <exit@plt>
    6338:	0f 1f 84 00 00 00 00 	nopl   0x0(%rax,%rax,1)
    633f:	00 

0000000000006340 <fwp_p_array_from_list_typed>:
    6340:	41 56                	push   %r14
    6342:	53                   	push   %rbx
    6343:	50                   	push   %rax
    6344:	48 89 fb             	mov    %rdi,%rbx
    6347:	48 85 ff             	test   %rdi,%rdi
    634a:	0f 84 ae 00 00 00    	je     63fe <fwp_p_array_from_list_typed+0xbe>
    6350:	31 ff                	xor    %edi,%edi
    6352:	48 89 d8             	mov    %rbx,%rax
    6355:	66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
    635c:	00 00 00 00 
    6360:	48 ff c7             	inc    %rdi
    6363:	48 8b 40 10          	mov    0x10(%rax),%rax
    6367:	48 85 c0             	test   %rax,%rax
    636a:	75 f4                	jne    6360 <fwp_p_array_from_list_typed+0x20>
    636c:	49 89 f6             	mov    %rsi,%r14
    636f:	e8 cc 00 00 00       	call   6440 <fwp_array_typed_new>
    6374:	48 85 db             	test   %rbx,%rbx
    6377:	0f 84 88 00 00 00    	je     6405 <fwp_p_array_from_list_typed+0xc5>
    637d:	b9 04 00 00 00       	mov    $0x4,%ecx
    6382:	ba 84 04 00 00       	mov    $0x484,%edx
    6387:	be 21 00 00 00       	mov    $0x21,%esi
    638c:	bf 42 00 00 00       	mov    $0x42,%edi
    6391:	49 89 d8             	mov    %rbx,%r8
    6394:	4d 89 f1             	mov    %r14,%r9
    6397:	eb 18                	jmp    63b1 <fwp_p_array_from_list_typed+0x71>
    6399:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)
    63a0:	4c 89 54 c8 e8       	mov    %r10,-0x18(%rax,%rcx,8)
    63a5:	4d 8b 40 10          	mov    0x10(%r8),%r8
    63a9:	48 ff c1             	inc    %rcx
    63ac:	4d 85 c0             	test   %r8,%r8
    63af:	74 54                	je     6405 <fwp_p_array_from_list_typed+0xc5>
    63b1:	48 83 38 00          	cmpq   $0x0,(%rax)
    63b5:	78 56                	js     640d <fwp_p_array_from_list_typed+0xcd>
    63b7:	4d 8b 50 08          	mov    0x8(%r8),%r10
    63bb:	4d 85 c9             	test   %r9,%r9
    63be:	74 e0                	je     63a0 <fwp_p_array_from_list_typed+0x60>
    63c0:	45 8b 19             	mov    (%r9),%r11d
    63c3:	41 83 fb 0a          	cmp    $0xa,%r11d
    63c7:	77 d7                	ja     63a0 <fwp_p_array_from_list_typed+0x60>
    63c9:	44 0f a3 da          	bt     %r11d,%edx
    63cd:	72 21                	jb     63f0 <fwp_p_array_from_list_typed+0xb0>
    63cf:	44 0f a3 de          	bt     %r11d,%esi
    63d3:	72 22                	jb     63f7 <fwp_p_array_from_list_typed+0xb7>
    63d5:	44 0f a3 df          	bt     %r11d,%edi
    63d9:	73 c5                	jae    63a0 <fwp_p_array_from_list_typed+0x60>
    63db:	66 44 89 14 48       	mov    %r10w,(%rax,%rcx,2)
    63e0:	eb c3                	jmp    63a5 <fwp_p_array_from_list_typed+0x65>
    63e2:	66 66 66 66 66 2e 0f 	data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    63e9:	1f 84 00 00 00 00 00 
    63f0:	44 89 54 88 f8       	mov    %r10d,-0x8(%rax,%rcx,4)
    63f5:	eb ae                	jmp    63a5 <fwp_p_array_from_list_typed+0x65>
    63f7:	44 88 54 08 04       	mov    %r10b,0x4(%rax,%rcx,1)
    63fc:	eb a7                	jmp    63a5 <fwp_p_array_from_list_typed+0x65>
    63fe:	31 ff                	xor    %edi,%edi
    6400:	e8 3b 00 00 00       	call   6440 <fwp_array_typed_new>
    6405:	48 83 c4 08          	add    $0x8,%rsp
    6409:	5b                   	pop    %rbx
    640a:	41 5e                	pop    %r14
    640c:	c3                   	ret
    640d:	e8 4e fe ff ff       	call   6260 <fwp_flush>
    6412:	48 8b 05 c7 bb 00 00 	mov    0xbbc7(%rip),%rax        # 11fe0 <stderr@GLIBC_2.2.5>
    6419:	48 8b 38             	mov    (%rax),%rdi
    641c:	48 8d 35 0a 90 00 00 	lea    0x900a(%rip),%rsi        # f42d <fwp_segv.msg+0x1ed>
    6423:	48 8d 15 54 91 00 00 	lea    0x9154(%rip),%rdx        # f57e <fwp_segv.msg+0x33e>
    642a:	31 c0                	xor    %eax,%eax
    642c:	e8 7f bd ff ff       	call   21b0 <fprintf@plt>
    6431:	bf 65 00 00 00       	mov    $0x65,%edi
    6436:	e8 55 be ff ff       	call   2290 <exit@plt>
    643b:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)

0000000000006440 <fwp_array_typed_new>:
    6440:	41 56                	push   %r14
    6442:	53                   	push   %rbx
    6443:	50                   	push   %rax
    6444:	48 b8 ff ff ff ff ff 	movabs $0x1fffffffffffffff,%rax
    644b:	ff ff 1f 
    644e:	48 39 c7             	cmp    %rax,%rdi
    6451:	0f 83 21 02 00 00    	jae    6678 <fwp_array_typed_new+0x238>
    6457:	48 89 fb             	mov    %rdi,%rbx
    645a:	48 85 f6             	test   %rsi,%rsi
    645d:	74 23                	je     6482 <fwp_array_typed_new+0x42>
    645f:	8b 06                	mov    (%rsi),%eax
    6461:	48 83 f8 0a          	cmp    $0xa,%rax
    6465:	77 0e                	ja     6475 <fwp_array_typed_new+0x35>
    6467:	b9 e7 04 00 00       	mov    $0x4e7,%ecx
    646c:	0f a3 c1             	bt     %eax,%ecx
    646f:	0f 82 93 00 00 00    	jb     6508 <fwp_array_typed_new+0xc8>
    6475:	48 8d 0c dd 00 00 00 	lea    0x0(,%rbx,8),%rcx
    647c:	00 
    647d:	e9 95 00 00 00       	jmp    6517 <fwp_array_typed_new+0xd7>
    6482:	48 8d 14 dd 08 00 00 	lea    0x8(,%rbx,8),%rdx
    6489:	00 
    648a:	48 81 fa 00 40 00 00 	cmp    $0x4000,%rdx
    6491:	77 68                	ja     64fb <fwp_array_typed_new+0xbb>
    6493:	48 8d 42 0f          	lea    0xf(%rdx),%rax
    6497:	48 c1 e8 04          	shr    $0x4,%rax
    649b:	48 8d 0d de bc 00 00 	lea    0xbcde(%rip),%rcx        # 12180 <fwp_gc>
    64a2:	0f b6 b4 08 e8 0b 00 	movzbl 0xbe8(%rax,%rcx,1),%esi
    64a9:	00 
    64aa:	8b 84 b1 48 0b 00 00 	mov    0xb48(%rcx,%rsi,4),%eax
    64b1:	48 29 05 c8 bc 00 00 	sub    %rax,0xbcc8(%rip)        # 12180 <fwp_gc>
    64b8:	78 41                	js     64fb <fwp_array_typed_new+0xbb>
    64ba:	48 8d 34 76          	lea    (%rsi,%rsi,2),%rsi
    64be:	48 8d 3c f1          	lea    (%rcx,%rsi,8),%rdi
    64c2:	48 81 c7 88 07 00 00 	add    $0x788,%rdi
    64c9:	4c 8b 37             	mov    (%rdi),%r14
    64cc:	4d 85 f6             	test   %r14,%r14
    64cf:	74 0e                	je     64df <fwp_array_typed_new+0x9f>
    64d1:	49 8b 0e             	mov    (%r14),%rcx
    64d4:	48 f7 d1             	not    %rcx
    64d7:	48 89 0f             	mov    %rcx,(%rdi)
    64da:	e9 f8 00 00 00       	jmp    65d7 <fwp_array_typed_new+0x197>
    64df:	4c 8b b4 f1 90 07 00 	mov    0x790(%rcx,%rsi,8),%r14
    64e6:	00 
    64e7:	48 8b bc f1 98 07 00 	mov    0x798(%rcx,%rsi,8),%rdi
    64ee:	00 
    64ef:	4c 29 f7             	sub    %r14,%rdi
    64f2:	48 39 c7             	cmp    %rax,%rdi
    64f5:	0f 83 ca 00 00 00    	jae    65c5 <fwp_array_typed_new+0x185>
    64fb:	48 89 d7             	mov    %rdx,%rdi
    64fe:	be 02 00 00 00       	mov    $0x2,%esi
    6503:	e9 9c 00 00 00       	jmp    65a4 <fwp_array_typed_new+0x164>
    6508:	48 8d 0d 51 8d 00 00 	lea    0x8d51(%rip),%rcx        # f260 <fwp_segv.msg+0x20>
    650f:	48 8b 0c c1          	mov    (%rcx,%rax,8),%rcx
    6513:	48 0f af cb          	imul   %rbx,%rcx
    6517:	48 8d 51 08          	lea    0x8(%rcx),%rdx
    651b:	83 f8 0b             	cmp    $0xb,%eax
    651e:	0f 87 66 ff ff ff    	ja     648a <fwp_array_typed_new+0x4a>
    6524:	be ef 0d 00 00       	mov    $0xdef,%esi
    6529:	0f a3 c6             	bt     %eax,%esi
    652c:	0f 83 58 ff ff ff    	jae    648a <fwp_array_typed_new+0x4a>
    6532:	48 81 f9 f8 3f 00 00 	cmp    $0x3ff8,%rcx
    6539:	77 61                	ja     659c <fwp_array_typed_new+0x15c>
    653b:	48 83 c1 17          	add    $0x17,%rcx
    653f:	48 c1 e9 04          	shr    $0x4,%rcx
    6543:	48 8d 05 36 bc 00 00 	lea    0xbc36(%rip),%rax        # 12180 <fwp_gc>
    654a:	0f b6 b4 01 e8 0b 00 	movzbl 0xbe8(%rcx,%rax,1),%esi
    6551:	00 
    6552:	8b 8c b0 48 0b 00 00 	mov    0xb48(%rax,%rsi,4),%ecx
    6559:	48 29 0d 20 bc 00 00 	sub    %rcx,0xbc20(%rip)        # 12180 <fwp_gc>
    6560:	78 3a                	js     659c <fwp_array_typed_new+0x15c>
    6562:	48 8d 34 76          	lea    (%rsi,%rsi,2),%rsi
    6566:	48 8d 3c f0          	lea    (%rax,%rsi,8),%rdi
    656a:	48 81 c7 c8 03 00 00 	add    $0x3c8,%rdi
    6571:	4c 8b 37             	mov    (%rdi),%r14
    6574:	4d 85 f6             	test   %r14,%r14
    6577:	74 0b                	je     6584 <fwp_array_typed_new+0x144>
    6579:	49 8b 06             	mov    (%r14),%rax
    657c:	48 f7 d0             	not    %rax
    657f:	48 89 07             	mov    %rax,(%rdi)
    6582:	eb 3a                	jmp    65be <fwp_array_typed_new+0x17e>
    6584:	4c 8b b4 f0 d0 03 00 	mov    0x3d0(%rax,%rsi,8),%r14
    658b:	00 
    658c:	48 8b bc f0 d8 03 00 	mov    0x3d8(%rax,%rsi,8),%rdi
    6593:	00 
    6594:	4c 29 f7             	sub    %r14,%rdi
    6597:	48 39 cf             	cmp    %rcx,%rdi
    659a:	73 12                	jae    65ae <fwp_array_typed_new+0x16e>
    659c:	48 89 d7             	mov    %rdx,%rdi
    659f:	be 01 00 00 00       	mov    $0x1,%esi
    65a4:	e8 07 01 00 00       	call   66b0 <fwp_gc_alloc_slow>
    65a9:	49 89 c6             	mov    %rax,%r14
    65ac:	eb 36                	jmp    65e4 <fwp_array_typed_new+0x1a4>
    65ae:	48 8d 04 f0          	lea    (%rax,%rsi,8),%rax
    65b2:	48 05 d0 03 00 00    	add    $0x3d0,%rax
    65b8:	4c 01 f1             	add    %r14,%rcx
    65bb:	48 89 08             	mov    %rcx,(%rax)
    65be:	4c 89 f7             	mov    %r14,%rdi
    65c1:	31 f6                	xor    %esi,%esi
    65c3:	eb 1a                	jmp    65df <fwp_array_typed_new+0x19f>
    65c5:	48 8d 0c f1          	lea    (%rcx,%rsi,8),%rcx
    65c9:	48 81 c1 90 07 00 00 	add    $0x790,%rcx
    65d0:	49 8d 14 06          	lea    (%r14,%rax,1),%rdx
    65d4:	48 89 11             	mov    %rdx,(%rcx)
    65d7:	4c 89 f7             	mov    %r14,%rdi
    65da:	31 f6                	xor    %esi,%esi
    65dc:	48 89 c2             	mov    %rax,%rdx
    65df:	e8 4c bb ff ff       	call   2130 <memset@plt>
    65e4:	49 89 1e             	mov    %rbx,(%r14)
    65e7:	4c 89 f0             	mov    %r14,%rax
    65ea:	48 2b 05 bf cb 00 00 	sub    0xcbbf(%rip),%rax        # 131b0 <fwp_gc+0x1030>
    65f1:	48 8b 0d e0 cb 00 00 	mov    0xcbe0(%rip),%rcx        # 131d8 <fwp_gc+0x1058>
    65f8:	48 c1 e1 10          	shl    $0x10,%rcx
    65fc:	48 39 c8             	cmp    %rcx,%rax
    65ff:	73 6c                	jae    666d <fwp_array_typed_new+0x22d>
    6601:	48 8b 0d f0 cb 00 00 	mov    0xcbf0(%rip),%rcx        # 131f8 <fwp_gc+0x1078>
    6608:	48 89 c2             	mov    %rax,%rdx
    660b:	48 c1 ea 10          	shr    $0x10,%rdx
    660f:	48 69 d2 28 12 00 00 	imul   $0x1228,%rdx,%rdx
    6616:	0f b6 34 11          	movzbl (%rcx,%rdx,1),%esi
    661a:	48 25 ff ff 00 00    	and    $0xffff,%rax
    6620:	75 1b                	jne    663d <fwp_array_typed_new+0x1fd>
    6622:	40 80 fe 02          	cmp    $0x2,%sil
    6626:	75 15                	jne    663d <fwp_array_typed_new+0x1fd>
    6628:	48 8d 1c 11          	lea    (%rcx,%rdx,1),%rbx
    662c:	48 81 c3 28 02 00 00 	add    $0x228,%rbx
    6633:	80 3b ff             	cmpb   $0xff,(%rbx)
    6636:	74 2b                	je     6663 <fwp_array_typed_new+0x223>
    6638:	c6 03 01             	movb   $0x1,(%rbx)
    663b:	eb 30                	jmp    666d <fwp_array_typed_new+0x22d>
    663d:	40 80 fe 01          	cmp    $0x1,%sil
    6641:	75 2a                	jne    666d <fwp_array_typed_new+0x22d>
    6643:	48 8d 34 11          	lea    (%rcx,%rdx,1),%rsi
    6647:	8b 4c 11 20          	mov    0x20(%rcx,%rdx,1),%ecx
    664b:	48 0f af c1          	imul   %rcx,%rax
    664f:	48 c1 e8 20          	shr    $0x20,%rax
    6653:	48 8d 1c 30          	lea    (%rax,%rsi,1),%rbx
    6657:	48 81 c3 28 02 00 00 	add    $0x228,%rbx
    665e:	80 3b ff             	cmpb   $0xff,(%rbx)
    6661:	75 d5                	jne    6638 <fwp_array_typed_new+0x1f8>
    6663:	48 89 df             	mov    %rbx,%rdi
    6666:	e8 25 fc ff ff       	call   6290 <fwp_rc_forget_slot>
    666b:	eb cb                	jmp    6638 <fwp_array_typed_new+0x1f8>
    666d:	4c 89 f0             	mov    %r14,%rax
    6670:	48 83 c4 08          	add    $0x8,%rsp
    6674:	5b                   	pop    %rbx
    6675:	41 5e                	pop    %r14
    6677:	c3                   	ret
    6678:	e8 e3 fb ff ff       	call   6260 <fwp_flush>
    667d:	48 8b 05 5c b9 00 00 	mov    0xb95c(%rip),%rax        # 11fe0 <stderr@GLIBC_2.2.5>
    6684:	48 8b 38             	mov    (%rax),%rdi
    6687:	48 8d 35 9f 8d 00 00 	lea    0x8d9f(%rip),%rsi        # f42d <fwp_segv.msg+0x1ed>
    668e:	48 8d 15 ce 8d 00 00 	lea    0x8dce(%rip),%rdx        # f463 <fwp_segv.msg+0x223>
    6695:	31 c0                	xor    %eax,%eax
    6697:	e8 14 bb ff ff       	call   21b0 <fprintf@plt>
    669c:	bf 65 00 00 00       	mov    $0x65,%edi
    66a1:	e8 ea bb ff ff       	call   2290 <exit@plt>
    66a6:	66 2e 0f 1f 84 00 00 	cs nopw 0x0(%rax,%rax,1)
    66ad:	00 00 00 

00000000000066b0 <fwp_gc_alloc_slow>:
    66b0:	41 57                	push   %r15
    66b2:	41 56                	push   %r14
    66b4:	41 55                	push   %r13
    66b6:	41 54                	push   %r12
    66b8:	53                   	push   %rbx
    66b9:	89 f3                	mov    %esi,%ebx
    66bb:	83 3d aa ca 00 00 00 	cmpl   $0x0,0xcaaa(%rip)        # 1316c <fwp_gc+0xfec>
    66c2:	74 19                	je     66dd <fwp_gc_alloc_slow+0x2d>
    66c4:	48 81 ff 01 40 00 00 	cmp    $0x4001,%rdi
    66cb:	72 24                	jb     66f1 <fwp_gc_alloc_slow+0x41>
    66cd:	89 de                	mov    %ebx,%esi
    66cf:	5b                   	pop    %rbx
    66d0:	41 5c                	pop    %r12
    66d2:	41 5d                	pop    %r13
    66d4:	41 5e                	pop    %r14
    66d6:	41 5f                	pop    %r15
    66d8:	e9 33 06 00 00       	jmp    6d10 <fwp_gc_alloc_big>
    66dd:	49 89 fe             	mov    %rdi,%r14
    66e0:	e8 5b 01 00 00       	call   6840 <fwp_gc_init>
    66e5:	4c 89 f7             	mov    %r14,%rdi
    66e8:	48 81 ff 01 40 00 00 	cmp    $0x4001,%rdi
    66ef:	73 dc                	jae    66cd <fwp_gc_alloc_slow+0x1d>
    66f1:	48 8d 47 0f          	lea    0xf(%rdi),%rax
    66f5:	48 c1 e8 04          	shr    $0x4,%rax
    66f9:	4c 8d 3d 80 ba 00 00 	lea    0xba80(%rip),%r15        # 12180 <fwp_gc>
    6700:	46 0f b6 b4 38 e8 0b 	movzbl 0xbe8(%rax,%r15,1),%r14d
    6707:	00 00 
    6709:	43 8b 94 b7 48 0b 00 	mov    0xb48(%r15,%r14,4),%edx
    6710:	00 
    6711:	48 83 3d 67 ba 00 00 	cmpq   $0x0,0xba67(%rip)        # 12180 <fwp_gc>
    6718:	00 
    6719:	0f 89 8c 00 00 00    	jns    67ab <fwp_gc_alloc_slow+0xfb>
    671f:	83 3d 46 ca 00 00 00 	cmpl   $0x0,0xca46(%rip)        # 1316c <fwp_gc+0xfec>
    6726:	75 11                	jne    6739 <fwp_gc_alloc_slow+0x89>
    6728:	49 89 fc             	mov    %rdi,%r12
    672b:	49 89 d5             	mov    %rdx,%r13
    672e:	e8 0d 01 00 00       	call   6840 <fwp_gc_init>
    6733:	4c 89 ea             	mov    %r13,%rdx
    6736:	4c 89 e7             	mov    %r12,%rdi
    6739:	8b 0d 35 ca 00 00    	mov    0xca35(%rip),%ecx        # 13174 <fwp_gc+0xff4>
    673f:	85 c9                	test   %ecx,%ecx
    6741:	74 2a                	je     676d <fwp_gc_alloc_slow+0xbd>
    6743:	48 8b 05 56 ca 00 00 	mov    0xca56(%rip),%rax        # 131a0 <fwp_gc+0x1020>
    674a:	48 85 c0             	test   %rax,%rax
    674d:	74 1e                	je     676d <fwp_gc_alloc_slow+0xbd>
    674f:	48 8b 0d 52 ca 00 00 	mov    0xca52(%rip),%rcx        # 131a8 <fwp_gc+0x1028>
    6756:	48 ff c1             	inc    %rcx
    6759:	48 89 0d 48 ca 00 00 	mov    %rcx,0xca48(%rip)        # 131a8 <fwp_gc+0x1028>
    6760:	48 39 c1             	cmp    %rax,%rcx
    6763:	0f 8d c7 00 00 00    	jge    6830 <fwp_gc_alloc_slow+0x180>
    6769:	31 c0                	xor    %eax,%eax
    676b:	eb 0d                	jmp    677a <fwp_gc_alloc_slow+0xca>
    676d:	b8 00 00 80 00       	mov    $0x800000,%eax
    6772:	85 c9                	test   %ecx,%ecx
    6774:	0f 85 b1 00 00 00    	jne    682b <fwp_gc_alloc_slow+0x17b>
    677a:	48 8b 0d 0f cc 00 00 	mov    0xcc0f(%rip),%rcx        # 13390 <fwp_gc+0x1210>
    6781:	48 2b 0d f8 b9 00 00 	sub    0xb9f8(%rip),%rcx        # 12180 <fwp_gc>
    6788:	f2 48 0f 2a c1       	cvtsi2sd %rcx,%xmm0
    678d:	f2 0f 58 05 d3 cb 00 	addsd  0xcbd3(%rip),%xmm0        # 13368 <fwp_gc+0x11e8>
    6794:	00 
    6795:	f2 0f 11 05 cb cb 00 	movsd  %xmm0,0xcbcb(%rip)        # 13368 <fwp_gc+0x11e8>
    679c:	00 
    679d:	48 89 05 ec cb 00 00 	mov    %rax,0xcbec(%rip)        # 13390 <fwp_gc+0x1210>
    67a4:	48 89 05 d5 b9 00 00 	mov    %rax,0xb9d5(%rip)        # 12180 <fwp_gc>
    67ab:	89 d8                	mov    %ebx,%eax
    67ad:	48 69 c0 c0 03 00 00 	imul   $0x3c0,%rax,%rax
    67b4:	49 01 c7             	add    %rax,%r15
    67b7:	4b 8d 34 76          	lea    (%r14,%r14,2),%rsi
    67bb:	49 8d 0c f7          	lea    (%r15,%rsi,8),%rcx
    67bf:	48 83 c1 08          	add    $0x8,%rcx
    67c3:	49 8b 44 f7 08       	mov    0x8(%r15,%rsi,8),%rax
    67c8:	48 85 c0             	test   %rax,%rax
    67cb:	74 08                	je     67d5 <fwp_gc_alloc_slow+0x125>
    67cd:	48 8b 30             	mov    (%rax),%rsi
    67d0:	48 f7 d6             	not    %rsi
    67d3:	eb 39                	jmp    680e <fwp_gc_alloc_slow+0x15e>
    67d5:	49 8b 44 f7 10       	mov    0x10(%r15,%rsi,8),%rax
    67da:	4d 8b 44 f7 18       	mov    0x18(%r15,%rsi,8),%r8
    67df:	49 29 c0             	sub    %rax,%r8
    67e2:	49 39 d0             	cmp    %rdx,%r8
    67e5:	73 1b                	jae    6802 <fwp_gc_alloc_slow+0x152>
    67e7:	49 89 ff             	mov    %rdi,%r15
    67ea:	48 89 cf             	mov    %rcx,%rdi
    67ed:	44 89 f6             	mov    %r14d,%esi
    67f0:	49 89 d6             	mov    %rdx,%r14
    67f3:	89 da                	mov    %ebx,%edx
    67f5:	e8 46 07 00 00       	call   6f40 <fwp_gc_refill>
    67fa:	4c 89 f2             	mov    %r14,%rdx
    67fd:	4c 89 ff             	mov    %r15,%rdi
    6800:	eb 0f                	jmp    6811 <fwp_gc_alloc_slow+0x161>
    6802:	49 8d 0c f7          	lea    (%r15,%rsi,8),%rcx
    6806:	48 83 c1 10          	add    $0x10,%rcx
    680a:	48 8d 34 10          	lea    (%rax,%rdx,1),%rsi
    680e:	48 89 31             	mov    %rsi,(%rcx)
    6811:	83 fb 01             	cmp    $0x1,%ebx
    6814:	48 0f 44 d7          	cmove  %rdi,%rdx
    6818:	48 89 c7             	mov    %rax,%rdi
    681b:	31 f6                	xor    %esi,%esi
    681d:	5b                   	pop    %rbx
    681e:	41 5c                	pop    %r12
    6820:	41 5d                	pop    %r13
    6822:	41 5e                	pop    %r14
    6824:	41 5f                	pop    %r15
    6826:	e9 05 b9 ff ff       	jmp    2130 <memset@plt>
    682b:	e8 d0 09 00 00       	call   7200 <fwp_gc_collect>
    6830:	48 c7 05 6d c9 00 00 	movq   $0x0,0xc96d(%rip)        # 131a8 <fwp_gc+0x1028>
    6837:	00 00 00 00 
    683b:	e8 c0 09 00 00       	call   7200 <fwp_gc_collect>

0000000000006840 <fwp_gc_init>:
    6840:	41 56                	push   %r14
    6842:	53                   	push   %rbx
    6843:	50                   	push   %rax
    6844:	c7 05 1e c9 00 00 01 	movl   $0x1,0xc91e(%rip)        # 1316c <fwp_gc+0xfec>
    684b:	00 00 00 
    684e:	0f 28 05 db 87 00 00 	movaps 0x87db(%rip),%xmm0        # f030 <_IO_stdin_used+0x30>
    6855:	0f 11 05 6c c4 00 00 	movups %xmm0,0xc46c(%rip)        # 12cc8 <fwp_gc+0xb48>
    685c:	0f 28 05 dd 87 00 00 	movaps 0x87dd(%rip),%xmm0        # f040 <_IO_stdin_used+0x40>
    6863:	0f 11 05 6e c4 00 00 	movups %xmm0,0xc46e(%rip)        # 12cd8 <fwp_gc+0xb58>
    686a:	0f 28 05 df 87 00 00 	movaps 0x87df(%rip),%xmm0        # f050 <_IO_stdin_used+0x50>
    6871:	0f 11 05 70 c4 00 00 	movups %xmm0,0xc470(%rip)        # 12ce8 <fwp_gc+0xb68>
    6878:	0f 28 05 e1 87 00 00 	movaps 0x87e1(%rip),%xmm0        # f060 <_IO_stdin_used+0x60>
    687f:	0f 11 05 72 c4 00 00 	movups %xmm0,0xc472(%rip)        # 12cf8 <fwp_gc+0xb78>
    6886:	0f 28 05 e3 87 00 00 	movaps 0x87e3(%rip),%xmm0        # f070 <_IO_stdin_used+0x70>
    688d:	0f 11 05 74 c4 00 00 	movups %xmm0,0xc474(%rip)        # 12d08 <fwp_gc+0xb88>
    6894:	0f 28 05 e5 87 00 00 	movaps 0x87e5(%rip),%xmm0        # f080 <_IO_stdin_used+0x80>
    689b:	0f 11 05 76 c4 00 00 	movups %xmm0,0xc476(%rip)        # 12d18 <fwp_gc+0xb98>
    68a2:	0f 28 05 e7 87 00 00 	movaps 0x87e7(%rip),%xmm0        # f090 <_IO_stdin_used+0x90>
    68a9:	0f 11 05 78 c4 00 00 	movups %xmm0,0xc478(%rip)        # 12d28 <fwp_gc+0xba8>
    68b0:	0f 28 05 e9 87 00 00 	movaps 0x87e9(%rip),%xmm0        # f0a0 <_IO_stdin_used+0xa0>
    68b7:	0f 11 05 7a c4 00 00 	movups %xmm0,0xc47a(%rip)        # 12d38 <fwp_gc+0xbb8>
    68be:	0f 28 05 eb 87 00 00 	movaps 0x87eb(%rip),%xmm0        # f0b0 <_IO_stdin_used+0xb0>
    68c5:	0f 11 05 7c c4 00 00 	movups %xmm0,0xc47c(%rip)        # 12d48 <fwp_gc+0xbc8>
    68cc:	0f 28 05 ed 87 00 00 	movaps 0x87ed(%rip),%xmm0        # f0c0 <_IO_stdin_used+0xc0>
    68d3:	0f 11 05 7e c4 00 00 	movups %xmm0,0xc47e(%rip)        # 12d58 <fwp_gc+0xbd8>
    68da:	31 c9                	xor    %ecx,%ecx
    68dc:	48 8d 05 9d b8 00 00 	lea    0xb89d(%rip),%rax        # 12180 <fwp_gc>
    68e3:	31 d2                	xor    %edx,%edx
    68e5:	66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
    68ec:	00 00 00 00 
    68f0:	89 d6                	mov    %edx,%esi
    68f2:	c1 e6 04             	shl    $0x4,%esi
    68f5:	48 ff c9             	dec    %rcx
    68f8:	48 89 cf             	mov    %rcx,%rdi
    68fb:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)
    6900:	48 89 f9             	mov    %rdi,%rcx
    6903:	48 ff c7             	inc    %rdi
    6906:	3b b4 88 4c 0b 00 00 	cmp    0xb4c(%rax,%rcx,4),%esi
    690d:	77 f1                	ja     6900 <fwp_gc_init+0xc0>
    690f:	40 88 bc 02 e8 0b 00 	mov    %dil,0xbe8(%rdx,%rax,1)
    6916:	00 
    6917:	48 89 d6             	mov    %rdx,%rsi
    691a:	48 83 ce 01          	or     $0x1,%rsi
    691e:	48 81 fe 01 04 00 00 	cmp    $0x401,%rsi
    6925:	74 26                	je     694d <fwp_gc_init+0x10d>
    6927:	89 f7                	mov    %esi,%edi
    6929:	c1 e7 04             	shl    $0x4,%edi
    692c:	0f 1f 40 00          	nopl   0x0(%rax)
    6930:	49 89 c8             	mov    %rcx,%r8
    6933:	48 ff c1             	inc    %rcx
    6936:	42 3b bc 80 4c 0b 00 	cmp    0xb4c(%rax,%r8,4),%edi
    693d:	00 
    693e:	77 f0                	ja     6930 <fwp_gc_init+0xf0>
    6940:	88 8c 06 e8 0b 00 00 	mov    %cl,0xbe8(%rsi,%rax,1)
    6947:	48 83 c2 02          	add    $0x2,%rdx
    694b:	eb a3                	jmp    68f0 <fwp_gc_init+0xb0>
    694d:	48 bb 00 00 00 00 10 	movabs $0x1000000000,%rbx
    6954:	00 00 00 
    6957:	48 8d b3 00 00 01 00 	lea    0x10000(%rbx),%rsi
    695e:	31 ff                	xor    %edi,%edi
    6960:	31 d2                	xor    %edx,%edx
    6962:	b9 22 40 00 00       	mov    $0x4022,%ecx
    6967:	41 b8 ff ff ff ff    	mov    $0xffffffff,%r8d
    696d:	45 31 c9             	xor    %r9d,%r9d
    6970:	e8 7b b7 ff ff       	call   20f0 <mmap@plt>
    6975:	48 83 f8 ff          	cmp    $0xffffffffffffffff,%rax
    6979:	75 60                	jne    69db <fwp_gc_init+0x19b>
    697b:	48 bb 00 00 00 00 04 	movabs $0x400000000,%rbx
    6982:	00 00 00 
    6985:	48 8d b3 00 00 01 00 	lea    0x10000(%rbx),%rsi
    698c:	31 ff                	xor    %edi,%edi
    698e:	31 d2                	xor    %edx,%edx
    6990:	b9 22 40 00 00       	mov    $0x4022,%ecx
    6995:	41 b8 ff ff ff ff    	mov    $0xffffffff,%r8d
    699b:	45 31 c9             	xor    %r9d,%r9d
    699e:	e8 4d b7 ff ff       	call   20f0 <mmap@plt>
    69a3:	48 83 f8 ff          	cmp    $0xffffffffffffffff,%rax
    69a7:	75 32                	jne    69db <fwp_gc_init+0x19b>
    69a9:	48 bb 00 00 00 00 01 	movabs $0x100000000,%rbx
    69b0:	00 00 00 
    69b3:	48 8d b3 00 00 01 00 	lea    0x10000(%rbx),%rsi
    69ba:	31 ff                	xor    %edi,%edi
    69bc:	31 d2                	xor    %edx,%edx
    69be:	b9 22 40 00 00       	mov    $0x4022,%ecx
    69c3:	41 b8 ff ff ff ff    	mov    $0xffffffff,%r8d
    69c9:	45 31 c9             	xor    %r9d,%r9d
    69cc:	e8 1f b7 ff ff       	call   20f0 <mmap@plt>
    69d1:	48 83 f8 ff          	cmp    $0xffffffffffffffff,%rax
    69d5:	0f 84 4e 02 00 00    	je     6c29 <fwp_gc_init+0x3e9>
    69db:	48 85 c0             	test   %rax,%rax
    69de:	0f 84 a6 02 00 00    	je     6c8a <fwp_gc_init+0x44a>
    69e4:	48 89 05 cd c7 00 00 	mov    %rax,0xc7cd(%rip)        # 131b8 <fwp_gc+0x1038>
    69eb:	48 89 d9             	mov    %rbx,%rcx
    69ee:	48 81 c9 00 00 01 00 	or     $0x10000,%rcx
    69f5:	48 89 0d c4 c7 00 00 	mov    %rcx,0xc7c4(%rip)        # 131c0 <fwp_gc+0x1040>
    69fc:	48 05 ff ff 00 00    	add    $0xffff,%rax
    6a02:	48 25 00 00 ff ff    	and    $0xffffffffffff0000,%rax
    6a08:	48 89 05 a1 c7 00 00 	mov    %rax,0xc7a1(%rip)        # 131b0 <fwp_gc+0x1030>
    6a0f:	48 c1 eb 10          	shr    $0x10,%rbx
    6a13:	48 89 1d b6 c7 00 00 	mov    %rbx,0xc7b6(%rip)        # 131d0 <fwp_gc+0x1050>
    6a1a:	48 69 f3 28 12 00 00 	imul   $0x1228,%rbx,%rsi
    6a21:	48 89 35 d8 c7 00 00 	mov    %rsi,0xc7d8(%rip)        # 13200 <fwp_gc+0x1080>
    6a28:	31 ff                	xor    %edi,%edi
    6a2a:	31 d2                	xor    %edx,%edx
    6a2c:	b9 22 40 00 00       	mov    $0x4022,%ecx
    6a31:	41 b8 ff ff ff ff    	mov    $0xffffffff,%r8d
    6a37:	45 31 c9             	xor    %r9d,%r9d
    6a3a:	e8 b1 b6 ff ff       	call   20f0 <mmap@plt>
    6a3f:	48 83 f8 ff          	cmp    $0xffffffffffffffff,%rax
    6a43:	0f 84 41 02 00 00    	je     6c8a <fwp_gc_init+0x44a>
    6a49:	48 89 05 a8 c7 00 00 	mov    %rax,0xc7a8(%rip)        # 131f8 <fwp_gc+0x1078>
    6a50:	48 8d 3d 1c 8a 00 00 	lea    0x8a1c(%rip),%rdi        # f473 <fwp_segv.msg+0x233>
    6a57:	e8 d4 b5 ff ff       	call   2030 <getenv@plt>
    6a5c:	48 85 c0             	test   %rax,%rax
    6a5f:	74 2e                	je     6a8f <fwp_gc_init+0x24f>
    6a61:	48 89 c3             	mov    %rax,%rbx
    6a64:	48 8d 35 0f 8a 00 00 	lea    0x8a0f(%rip),%rsi        # f47a <fwp_segv.msg+0x23a>
    6a6b:	48 89 c7             	mov    %rax,%rdi
    6a6e:	e8 0d b7 ff ff       	call   2180 <strcmp@plt>
    6a73:	85 c0                	test   %eax,%eax
    6a75:	74 1f                	je     6a96 <fwp_gc_init+0x256>
    6a77:	48 8d 35 e4 8b 00 00 	lea    0x8be4(%rip),%rsi        # f662 <fwp_segv.msg+0x422>
    6a7e:	48 89 df             	mov    %rbx,%rdi
    6a81:	e8 fa b6 ff ff       	call   2180 <strcmp@plt>
    6a86:	31 c9                	xor    %ecx,%ecx
    6a88:	85 c0                	test   %eax,%eax
    6a8a:	0f 95 c1             	setne  %cl
    6a8d:	eb 09                	jmp    6a98 <fwp_gc_init+0x258>
    6a8f:	b9 01 00 00 00       	mov    $0x1,%ecx
    6a94:	eb 02                	jmp    6a98 <fwp_gc_init+0x258>
    6a96:	31 c9                	xor    %ecx,%ecx
    6a98:	89 0d d2 c6 00 00    	mov    %ecx,0xc6d2(%rip)        # 13170 <fwp_gc+0xff0>
    6a9e:	48 8d 3d d9 89 00 00 	lea    0x89d9(%rip),%rdi        # f47e <fwp_segv.msg+0x23e>
    6aa5:	e8 86 b5 ff ff       	call   2030 <getenv@plt>
    6aaa:	31 c9                	xor    %ecx,%ecx
    6aac:	48 85 c0             	test   %rax,%rax
    6aaf:	74 1b                	je     6acc <fwp_gc_init+0x28c>
    6ab1:	80 38 00             	cmpb   $0x0,(%rax)
    6ab4:	74 16                	je     6acc <fwp_gc_init+0x28c>
    6ab6:	48 8d 35 a5 8b 00 00 	lea    0x8ba5(%rip),%rsi        # f662 <fwp_segv.msg+0x422>
    6abd:	48 89 c7             	mov    %rax,%rdi
    6ac0:	e8 bb b6 ff ff       	call   2180 <strcmp@plt>
    6ac5:	31 c9                	xor    %ecx,%ecx
    6ac7:	85 c0                	test   %eax,%eax
    6ac9:	0f 95 c1             	setne  %cl
    6acc:	89 0d aa c6 00 00    	mov    %ecx,0xc6aa(%rip)        # 1317c <fwp_gc+0xffc>
    6ad2:	48 8d 3d 9a 89 00 00 	lea    0x899a(%rip),%rdi        # f473 <fwp_segv.msg+0x233>
    6ad9:	e8 52 b5 ff ff       	call   2030 <getenv@plt>
    6ade:	48 85 c0             	test   %rax,%rax
    6ae1:	74 18                	je     6afb <fwp_gc_init+0x2bb>
    6ae3:	48 8d 35 a1 89 00 00 	lea    0x89a1(%rip),%rsi        # f48b <fwp_segv.msg+0x24b>
    6aea:	48 89 c7             	mov    %rax,%rdi
    6aed:	e8 8e b6 ff ff       	call   2180 <strcmp@plt>
    6af2:	31 c9                	xor    %ecx,%ecx
    6af4:	85 c0                	test   %eax,%eax
    6af6:	0f 95 c1             	setne  %cl
    6af9:	eb 05                	jmp    6b00 <fwp_gc_init+0x2c0>
    6afb:	b9 01 00 00 00       	mov    $0x1,%ecx
    6b00:	89 0d 7a c6 00 00    	mov    %ecx,0xc67a(%rip)        # 13180 <fwp_gc+0x1000>
    6b06:	c7 05 78 c6 00 00 01 	movl   $0x1,0xc678(%rip)        # 13188 <fwp_gc+0x1008>
    6b0d:	00 00 00 
    6b10:	48 8d 3d 79 89 00 00 	lea    0x8979(%rip),%rdi        # f490 <fwp_segv.msg+0x250>
    6b17:	e8 14 b5 ff ff       	call   2030 <getenv@plt>
    6b1c:	31 c9                	xor    %ecx,%ecx
    6b1e:	48 85 c0             	test   %rax,%rax
    6b21:	74 1b                	je     6b3e <fwp_gc_init+0x2fe>
    6b23:	80 38 00             	cmpb   $0x0,(%rax)
    6b26:	74 16                	je     6b3e <fwp_gc_init+0x2fe>
    6b28:	48 8d 35 33 8b 00 00 	lea    0x8b33(%rip),%rsi        # f662 <fwp_segv.msg+0x422>
    6b2f:	48 89 c7             	mov    %rax,%rdi
    6b32:	e8 49 b6 ff ff       	call   2180 <strcmp@plt>
    6b37:	31 c9                	xor    %ecx,%ecx
    6b39:	85 c0                	test   %eax,%eax
    6b3b:	0f 95 c1             	setne  %cl
    6b3e:	89 0d 40 c6 00 00    	mov    %ecx,0xc640(%rip)        # 13184 <fwp_gc+0x1004>
    6b44:	48 8d 3d 53 89 00 00 	lea    0x8953(%rip),%rdi        # f49e <fwp_segv.msg+0x25e>
    6b4b:	e8 e0 b4 ff ff       	call   2030 <getenv@plt>
    6b50:	48 85 c0             	test   %rax,%rax
    6b53:	74 14                	je     6b69 <fwp_gc_init+0x329>
    6b55:	48 89 c7             	mov    %rax,%rdi
    6b58:	31 f6                	xor    %esi,%esi
    6b5a:	ba 0a 00 00 00       	mov    $0xa,%edx
    6b5f:	e8 6c b6 ff ff       	call   21d0 <strtol@plt>
    6b64:	48 89 c3             	mov    %rax,%rbx
    6b67:	eb 02                	jmp    6b6b <fwp_gc_init+0x32b>
    6b69:	31 db                	xor    %ebx,%ebx
    6b6b:	31 c0                	xor    %eax,%eax
    6b6d:	48 85 db             	test   %rbx,%rbx
    6b70:	48 0f 4f c3          	cmovg  %rbx,%rax
    6b74:	48 89 05 25 c6 00 00 	mov    %rax,0xc625(%rip)        # 131a0 <fwp_gc+0x1020>
    6b7b:	48 8d 3d f1 88 00 00 	lea    0x88f1(%rip),%rdi        # f473 <fwp_segv.msg+0x233>
    6b82:	e8 a9 b4 ff ff       	call   2030 <getenv@plt>
    6b87:	48 85 c0             	test   %rax,%rax
    6b8a:	74 32                	je     6bbe <fwp_gc_init+0x37e>
    6b8c:	49 89 c6             	mov    %rax,%r14
    6b8f:	80 38 00             	cmpb   $0x0,(%rax)
    6b92:	74 2a                	je     6bbe <fwp_gc_init+0x37e>
    6b94:	48 8d 35 df 88 00 00 	lea    0x88df(%rip),%rsi        # f47a <fwp_segv.msg+0x23a>
    6b9b:	4c 89 f7             	mov    %r14,%rdi
    6b9e:	e8 dd b5 ff ff       	call   2180 <strcmp@plt>
    6ba3:	85 c0                	test   %eax,%eax
    6ba5:	74 17                	je     6bbe <fwp_gc_init+0x37e>
    6ba7:	48 8d 35 b4 8a 00 00 	lea    0x8ab4(%rip),%rsi        # f662 <fwp_segv.msg+0x422>
    6bae:	4c 89 f7             	mov    %r14,%rdi
    6bb1:	e8 ca b5 ff ff       	call   2180 <strcmp@plt>
    6bb6:	85 c0                	test   %eax,%eax
    6bb8:	0f 85 f6 00 00 00    	jne    6cb4 <fwp_gc_init+0x474>
    6bbe:	48 85 db             	test   %rbx,%rbx
    6bc1:	0f 8f ed 00 00 00    	jg     6cb4 <fwp_gc_init+0x474>
    6bc7:	83 3d b6 c5 00 00 00 	cmpl   $0x0,0xc5b6(%rip)        # 13184 <fwp_gc+0x1004>
    6bce:	0f 85 e0 00 00 00    	jne    6cb4 <fwp_gc_init+0x474>
    6bd4:	48 8d 3d 0e 89 00 00 	lea    0x890e(%rip),%rdi        # f4e9 <fwp_segv.msg+0x2a9>
    6bdb:	e8 50 b4 ff ff       	call   2030 <getenv@plt>
    6be0:	48 85 c0             	test   %rax,%rax
    6be3:	74 1c                	je     6c01 <fwp_gc_init+0x3c1>
    6be5:	80 38 00             	cmpb   $0x0,(%rax)
    6be8:	74 17                	je     6c01 <fwp_gc_init+0x3c1>
    6bea:	48 8d 35 71 8a 00 00 	lea    0x8a71(%rip),%rsi        # f662 <fwp_segv.msg+0x422>
    6bf1:	48 89 c7             	mov    %rax,%rdi
    6bf4:	e8 87 b5 ff ff       	call   2180 <strcmp@plt>
    6bf9:	85 c0                	test   %eax,%eax
    6bfb:	0f 85 e1 00 00 00    	jne    6ce2 <fwp_gc_init+0x4a2>
    6c01:	c7 05 65 c5 00 00 00 	movl   $0x0,0xc565(%rip)        # 13170 <fwp_gc+0xff0>
    6c08:	00 00 00 
    6c0b:	48 c7 05 7a c7 00 00 	movq   $0x800000,0xc77a(%rip)        # 13390 <fwp_gc+0x1210>
    6c12:	00 00 80 00 
    6c16:	48 c7 05 5f b5 00 00 	movq   $0x800000,0xb55f(%rip)        # 12180 <fwp_gc>
    6c1d:	00 00 80 00 
    6c21:	48 83 c4 08          	add    $0x8,%rsp
    6c25:	5b                   	pop    %rbx
    6c26:	41 5e                	pop    %r14
    6c28:	c3                   	ret
    6c29:	be 00 00 01 40       	mov    $0x40010000,%esi
    6c2e:	31 ff                	xor    %edi,%edi
    6c30:	31 d2                	xor    %edx,%edx
    6c32:	b9 22 40 00 00       	mov    $0x4022,%ecx
    6c37:	41 b8 ff ff ff ff    	mov    $0xffffffff,%r8d
    6c3d:	45 31 c9             	xor    %r9d,%r9d
    6c40:	e8 ab b4 ff ff       	call   20f0 <mmap@plt>
    6c45:	48 83 f8 ff          	cmp    $0xffffffffffffffff,%rax
    6c49:	74 0f                	je     6c5a <fwp_gc_init+0x41a>
    6c4b:	48 85 c0             	test   %rax,%rax
    6c4e:	74 3a                	je     6c8a <fwp_gc_init+0x44a>
    6c50:	bb 00 00 00 40       	mov    $0x40000000,%ebx
    6c55:	e9 8a fd ff ff       	jmp    69e4 <fwp_gc_init+0x1a4>
    6c5a:	be 00 00 01 10       	mov    $0x10010000,%esi
    6c5f:	31 ff                	xor    %edi,%edi
    6c61:	31 d2                	xor    %edx,%edx
    6c63:	b9 22 40 00 00       	mov    $0x4022,%ecx
    6c68:	41 b8 ff ff ff ff    	mov    $0xffffffff,%r8d
    6c6e:	45 31 c9             	xor    %r9d,%r9d
    6c71:	e8 7a b4 ff ff       	call   20f0 <mmap@plt>
    6c76:	48 8d 48 01          	lea    0x1(%rax),%rcx
    6c7a:	48 83 f9 02          	cmp    $0x2,%rcx
    6c7e:	72 0a                	jb     6c8a <fwp_gc_init+0x44a>
    6c80:	bb 00 00 00 10       	mov    $0x10000000,%ebx
    6c85:	e9 5a fd ff ff       	jmp    69e4 <fwp_gc_init+0x1a4>
    6c8a:	48 8b 05 4f b3 00 00 	mov    0xb34f(%rip),%rax        # 11fe0 <stderr@GLIBC_2.2.5>
    6c91:	48 8b 08             	mov    (%rax),%rcx
    6c94:	48 8d 3d 9e 88 00 00 	lea    0x889e(%rip),%rdi        # f539 <fwp_segv.msg+0x2f9>
    6c9b:	be 13 00 00 00       	mov    $0x13,%esi
    6ca0:	ba 01 00 00 00       	mov    $0x1,%edx
    6ca5:	e8 f6 b5 ff ff       	call   22a0 <fwrite@plt>
    6caa:	bf 66 00 00 00       	mov    $0x66,%edi
    6caf:	e8 dc b5 ff ff       	call   2290 <exit@plt>
    6cb4:	e8 a7 f5 ff ff       	call   6260 <fwp_flush>
    6cb9:	48 8b 05 20 b3 00 00 	mov    0xb320(%rip),%rax        # 11fe0 <stderr@GLIBC_2.2.5>
    6cc0:	48 8b 38             	mov    (%rax),%rdi
    6cc3:	48 8d 35 63 87 00 00 	lea    0x8763(%rip),%rsi        # f42d <fwp_segv.msg+0x1ed>
    6cca:	48 8d 15 db 87 00 00 	lea    0x87db(%rip),%rdx        # f4ac <fwp_segv.msg+0x26c>
    6cd1:	31 c0                	xor    %eax,%eax
    6cd3:	e8 d8 b4 ff ff       	call   21b0 <fprintf@plt>
    6cd8:	bf 65 00 00 00       	mov    $0x65,%edi
    6cdd:	e8 ae b5 ff ff       	call   2290 <exit@plt>
    6ce2:	e8 79 f5 ff ff       	call   6260 <fwp_flush>
    6ce7:	48 8b 05 f2 b2 00 00 	mov    0xb2f2(%rip),%rax        # 11fe0 <stderr@GLIBC_2.2.5>
    6cee:	48 8b 38             	mov    (%rax),%rdi
    6cf1:	48 8d 35 35 87 00 00 	lea    0x8735(%rip),%rsi        # f42d <fwp_segv.msg+0x1ed>
    6cf8:	48 8d 15 fb 87 00 00 	lea    0x87fb(%rip),%rdx        # f4fa <fwp_segv.msg+0x2ba>
    6cff:	eb d0                	jmp    6cd1 <fwp_gc_init+0x491>
    6d01:	66 66 66 66 66 66 2e 	data16 data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    6d08:	0f 1f 84 00 00 00 00 
    6d0f:	00 

0000000000006d10 <fwp_gc_alloc_big>:
    6d10:	55                   	push   %rbp
    6d11:	41 57                	push   %r15
    6d13:	41 56                	push   %r14
    6d15:	41 55                	push   %r13
    6d17:	41 54                	push   %r12
    6d19:	53                   	push   %rbx
    6d1a:	50                   	push   %rax
    6d1b:	48 b8 01 00 00 00 00 	movabs $0x4000000000000001,%rax
    6d22:	00 00 40 
    6d25:	48 39 c7             	cmp    %rax,%rdi
    6d28:	0f 83 ce 01 00 00    	jae    6efc <fwp_gc_alloc_big+0x1ec>
    6d2e:	89 f5                	mov    %esi,%ebp
    6d30:	48 89 fb             	mov    %rdi,%rbx
    6d33:	48 29 3d 46 b4 00 00 	sub    %rdi,0xb446(%rip)        # 12180 <fwp_gc>
    6d3a:	0f 89 80 00 00 00    	jns    6dc0 <fwp_gc_alloc_big+0xb0>
    6d40:	83 3d 25 c4 00 00 00 	cmpl   $0x0,0xc425(%rip)        # 1316c <fwp_gc+0xfec>
    6d47:	75 05                	jne    6d4e <fwp_gc_alloc_big+0x3e>
    6d49:	e8 f2 fa ff ff       	call   6840 <fwp_gc_init>
    6d4e:	8b 0d 20 c4 00 00    	mov    0xc420(%rip),%ecx        # 13174 <fwp_gc+0xff4>
    6d54:	85 c9                	test   %ecx,%ecx
    6d56:	74 2a                	je     6d82 <fwp_gc_alloc_big+0x72>
    6d58:	48 8b 05 41 c4 00 00 	mov    0xc441(%rip),%rax        # 131a0 <fwp_gc+0x1020>
    6d5f:	48 85 c0             	test   %rax,%rax
    6d62:	74 1e                	je     6d82 <fwp_gc_alloc_big+0x72>
    6d64:	48 8b 0d 3d c4 00 00 	mov    0xc43d(%rip),%rcx        # 131a8 <fwp_gc+0x1028>
    6d6b:	48 ff c1             	inc    %rcx
    6d6e:	48 89 0d 33 c4 00 00 	mov    %rcx,0xc433(%rip)        # 131a8 <fwp_gc+0x1028>
    6d75:	48 39 c1             	cmp    %rax,%rcx
    6d78:	0f 8d ad 01 00 00    	jge    6f2b <fwp_gc_alloc_big+0x21b>
    6d7e:	31 c0                	xor    %eax,%eax
    6d80:	eb 0d                	jmp    6d8f <fwp_gc_alloc_big+0x7f>
    6d82:	b8 00 00 80 00       	mov    $0x800000,%eax
    6d87:	85 c9                	test   %ecx,%ecx
    6d89:	0f 85 97 01 00 00    	jne    6f26 <fwp_gc_alloc_big+0x216>
    6d8f:	48 8b 0d fa c5 00 00 	mov    0xc5fa(%rip),%rcx        # 13390 <fwp_gc+0x1210>
    6d96:	48 2b 0d e3 b3 00 00 	sub    0xb3e3(%rip),%rcx        # 12180 <fwp_gc>
    6d9d:	f2 48 0f 2a c1       	cvtsi2sd %rcx,%xmm0
    6da2:	f2 0f 58 05 be c5 00 	addsd  0xc5be(%rip),%xmm0        # 13368 <fwp_gc+0x11e8>
    6da9:	00 
    6daa:	f2 0f 11 05 b6 c5 00 	movsd  %xmm0,0xc5b6(%rip)        # 13368 <fwp_gc+0x11e8>
    6db1:	00 
    6db2:	48 89 05 d7 c5 00 00 	mov    %rax,0xc5d7(%rip)        # 13390 <fwp_gc+0x1210>
    6db9:	48 89 05 c0 b3 00 00 	mov    %rax,0xb3c0(%rip)        # 12180 <fwp_gc>
    6dc0:	4c 8d b3 ff ff 00 00 	lea    0xffff(%rbx),%r14
    6dc7:	49 c1 ee 10          	shr    $0x10,%r14
    6dcb:	4c 89 f7             	mov    %r14,%rdi
    6dce:	e8 9d 02 00 00       	call   7070 <fwp_gc_chunks>
    6dd3:	48 8b 0d 1e c4 00 00 	mov    0xc41e(%rip),%rcx        # 131f8 <fwp_gc+0x1078>
    6dda:	4c 69 e0 28 12 00 00 	imul   $0x1228,%rax,%r12
    6de1:	42 c6 04 21 02       	movb   $0x2,(%rcx,%r12,1)
    6de6:	42 88 6c 21 01       	mov    %bpl,0x1(%rcx,%r12,1)
    6deb:	66 42 c7 44 21 03 00 	movw   $0x100,0x3(%rcx,%r12,1)
    6df2:	01 
    6df3:	46 89 74 21 10       	mov    %r14d,0x10(%rcx,%r12,1)
    6df8:	4a 89 5c 21 18       	mov    %rbx,0x18(%rcx,%r12,1)
    6dfd:	4e 8d 3c 21          	lea    (%rcx,%r12,1),%r15
    6e01:	49 81 c7 28 02 00 00 	add    $0x228,%r15
    6e08:	42 80 bc 21 28 02 00 	cmpb   $0xff,0x228(%rcx,%r12,1)
    6e0f:	00 ff 
    6e11:	0f 84 d2 00 00 00    	je     6ee9 <fwp_gc_alloc_big+0x1d9>
    6e17:	41 c6 07 00          	movb   $0x0,(%r15)
    6e1b:	48 81 fb 01 00 01 00 	cmp    $0x10001,%rbx
    6e22:	0f 82 9b 00 00 00    	jb     6ec3 <fwp_gc_alloc_big+0x1b3>
    6e28:	49 83 fe 03          	cmp    $0x3,%r14
    6e2c:	ba 02 00 00 00       	mov    $0x2,%edx
    6e31:	49 0f 43 d6          	cmovae %r14,%rdx
    6e35:	48 8b 0d bc c3 00 00 	mov    0xc3bc(%rip),%rcx        # 131f8 <fwp_gc+0x1078>
    6e3c:	48 ff ca             	dec    %rdx
    6e3f:	be 01 00 00 00       	mov    $0x1,%esi
    6e44:	48 81 fb 01 00 02 00 	cmp    $0x20001,%rbx
    6e4b:	72 5a                	jb     6ea7 <fwp_gc_alloc_big+0x197>
    6e4d:	49 8d 3c 0c          	lea    (%r12,%rcx,1),%rdi
    6e51:	48 81 c7 60 24 00 00 	add    $0x2460,%rdi
    6e58:	49 89 d0             	mov    %rdx,%r8
    6e5b:	49 83 e0 fe          	and    $0xfffffffffffffffe,%r8
    6e5f:	49 f7 d8             	neg    %r8
    6e62:	66 66 66 66 66 2e 0f 	data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    6e69:	1f 84 00 00 00 00 00 
    6e70:	c6 87 c8 ed ff ff 03 	movb   $0x3,-0x1238(%rdi)
    6e77:	c6 87 cc ed ff ff 01 	movb   $0x1,-0x1234(%rdi)
    6e7e:	89 87 d8 ed ff ff    	mov    %eax,-0x1228(%rdi)
    6e84:	c6 47 f0 03          	movb   $0x3,-0x10(%rdi)
    6e88:	c6 47 f4 01          	movb   $0x1,-0xc(%rdi)
    6e8c:	89 07                	mov    %eax,(%rdi)
    6e8e:	48 81 c7 50 24 00 00 	add    $0x2450,%rdi
    6e95:	4d 8d 0c 30          	lea    (%r8,%rsi,1),%r9
    6e99:	49 83 c1 02          	add    $0x2,%r9
    6e9d:	48 83 c6 02          	add    $0x2,%rsi
    6ea1:	49 83 f9 01          	cmp    $0x1,%r9
    6ea5:	75 c9                	jne    6e70 <fwp_gc_alloc_big+0x160>
    6ea7:	f6 c2 01             	test   $0x1,%dl
    6eaa:	74 17                	je     6ec3 <fwp_gc_alloc_big+0x1b3>
    6eac:	4c 01 e1             	add    %r12,%rcx
    6eaf:	48 69 d6 28 12 00 00 	imul   $0x1228,%rsi,%rdx
    6eb6:	c6 04 11 03          	movb   $0x3,(%rcx,%rdx,1)
    6eba:	c6 44 11 04 01       	movb   $0x1,0x4(%rcx,%rdx,1)
    6ebf:	89 44 11 10          	mov    %eax,0x10(%rcx,%rdx,1)
    6ec3:	48 c1 e0 10          	shl    $0x10,%rax
    6ec7:	48 03 05 e2 c2 00 00 	add    0xc2e2(%rip),%rax        # 131b0 <fwp_gc+0x1030>
    6ece:	48 89 c7             	mov    %rax,%rdi
    6ed1:	31 f6                	xor    %esi,%esi
    6ed3:	48 89 da             	mov    %rbx,%rdx
    6ed6:	48 83 c4 08          	add    $0x8,%rsp
    6eda:	5b                   	pop    %rbx
    6edb:	41 5c                	pop    %r12
    6edd:	41 5d                	pop    %r13
    6edf:	41 5e                	pop    %r14
    6ee1:	41 5f                	pop    %r15
    6ee3:	5d                   	pop    %rbp
    6ee4:	e9 47 b2 ff ff       	jmp    2130 <memset@plt>
    6ee9:	4c 89 ff             	mov    %r15,%rdi
    6eec:	49 89 c5             	mov    %rax,%r13
    6eef:	e8 9c f3 ff ff       	call   6290 <fwp_rc_forget_slot>
    6ef4:	4c 89 e8             	mov    %r13,%rax
    6ef7:	e9 1b ff ff ff       	jmp    6e17 <fwp_gc_alloc_big+0x107>
    6efc:	48 8b 05 dd b0 00 00 	mov    0xb0dd(%rip),%rax        # 11fe0 <stderr@GLIBC_2.2.5>
    6f03:	48 8b 08             	mov    (%rax),%rcx
    6f06:	48 8d 3d 2c 86 00 00 	lea    0x862c(%rip),%rdi        # f539 <fwp_segv.msg+0x2f9>
    6f0d:	be 13 00 00 00       	mov    $0x13,%esi
    6f12:	ba 01 00 00 00       	mov    $0x1,%edx
    6f17:	e8 84 b3 ff ff       	call   22a0 <fwrite@plt>
    6f1c:	bf 66 00 00 00       	mov    $0x66,%edi
    6f21:	e8 6a b3 ff ff       	call   2290 <exit@plt>
    6f26:	e8 d5 02 00 00       	call   7200 <fwp_gc_collect>
    6f2b:	48 c7 05 72 c2 00 00 	movq   $0x0,0xc272(%rip)        # 131a8 <fwp_gc+0x1028>
    6f32:	00 00 00 00 
    6f36:	e8 c5 02 00 00       	call   7200 <fwp_gc_collect>
    6f3b:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)

0000000000006f40 <fwp_gc_refill>:
    6f40:	55                   	push   %rbp
    6f41:	41 57                	push   %r15
    6f43:	41 56                	push   %r14
    6f45:	41 55                	push   %r13
    6f47:	41 54                	push   %r12
    6f49:	53                   	push   %rbx
    6f4a:	50                   	push   %rax
    6f4b:	89 d5                	mov    %edx,%ebp
    6f4d:	41 89 f7             	mov    %esi,%r15d
    6f50:	48 89 fb             	mov    %rdi,%rbx
    6f53:	bf 01 00 00 00       	mov    $0x1,%edi
    6f58:	e8 13 01 00 00       	call   7070 <fwp_gc_chunks>
    6f5d:	49 89 c6             	mov    %rax,%r14
    6f60:	4c 8b 25 91 c2 00 00 	mov    0xc291(%rip),%r12        # 131f8 <fwp_gc+0x1078>
    6f67:	48 8d 05 12 b2 00 00 	lea    0xb212(%rip),%rax        # 12180 <fwp_gc>
    6f6e:	4d 69 ee 28 12 00 00 	imul   $0x1228,%r14,%r13
    6f75:	43 c6 04 2c 01       	movb   $0x1,(%r12,%r13,1)
    6f7a:	43 88 6c 2c 01       	mov    %bpl,0x1(%r12,%r13,1)
    6f7f:	47 88 7c 2c 02       	mov    %r15b,0x2(%r12,%r13,1)
    6f84:	43 c6 44 2c 04 01    	movb   $0x1,0x4(%r12,%r13,1)
    6f8a:	44 89 f9             	mov    %r15d,%ecx
    6f8d:	8b 8c 88 48 0b 00 00 	mov    0xb48(%rax,%rcx,4),%ecx
    6f94:	43 89 4c 2c 08       	mov    %ecx,0x8(%r12,%r13,1)
    6f99:	b8 00 00 01 00       	mov    $0x10000,%eax
    6f9e:	31 d2                	xor    %edx,%edx
    6fa0:	f7 f1                	div    %ecx
    6fa2:	43 89 44 2c 0c       	mov    %eax,0xc(%r12,%r13,1)
    6fa7:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    6fac:	48 01 c8             	add    %rcx,%rax
    6faf:	48 0f ba e0 20       	bt     $0x20,%rax
    6fb4:	73 07                	jae    6fbd <fwp_gc_refill+0x7d>
    6fb6:	31 d2                	xor    %edx,%edx
    6fb8:	48 f7 f1             	div    %rcx
    6fbb:	eb 04                	jmp    6fc1 <fwp_gc_refill+0x81>
    6fbd:	31 d2                	xor    %edx,%edx
    6fbf:	f7 f1                	div    %ecx
    6fc1:	43 89 44 2c 20       	mov    %eax,0x20(%r12,%r13,1)
    6fc6:	48 83 3d ca cb 00 00 	cmpq   $0x0,0xcbca(%rip)        # 13b98 <fwp_gc+0x1a18>
    6fcd:	00 
    6fce:	74 2e                	je     6ffe <fwp_gc_refill+0xbe>
    6fd0:	4f 8d 3c 2c          	lea    (%r12,%r13,1),%r15
    6fd4:	49 81 c7 28 02 00 00 	add    $0x228,%r15
    6fdb:	31 ed                	xor    %ebp,%ebp
    6fdd:	eb 0d                	jmp    6fec <fwp_gc_refill+0xac>
    6fdf:	90                   	nop
    6fe0:	48 ff c5             	inc    %rbp
    6fe3:	48 81 fd 00 10 00 00 	cmp    $0x1000,%rbp
    6fea:	74 12                	je     6ffe <fwp_gc_refill+0xbe>
    6fec:	41 80 3c 2f ff       	cmpb   $0xff,(%r15,%rbp,1)
    6ff1:	75 ed                	jne    6fe0 <fwp_gc_refill+0xa0>
    6ff3:	49 8d 3c 2f          	lea    (%r15,%rbp,1),%rdi
    6ff7:	e8 94 f2 ff ff       	call   6290 <fwp_rc_forget_slot>
    6ffc:	eb e2                	jmp    6fe0 <fwp_gc_refill+0xa0>
    6ffe:	4f 8d 3c 2c          	lea    (%r12,%r13,1),%r15
    7002:	49 83 c7 08          	add    $0x8,%r15
    7006:	4b 8d 3c 2c          	lea    (%r12,%r13,1),%rdi
    700a:	48 81 c7 28 02 00 00 	add    $0x228,%rdi
    7011:	ba 00 10 00 00       	mov    $0x1000,%edx
    7016:	31 f6                	xor    %esi,%esi
    7018:	e8 13 b1 ff ff       	call   2130 <memset@plt>
    701d:	49 c1 e6 10          	shl    $0x10,%r14
    7021:	4c 03 35 88 c1 00 00 	add    0xc188(%rip),%r14        # 131b0 <fwp_gc+0x1030>
    7028:	83 3d 55 c1 00 00 00 	cmpl   $0x0,0xc155(%rip)        # 13184 <fwp_gc+0x1004>
    702f:	74 0f                	je     7040 <fwp_gc_refill+0x100>
    7031:	ba 00 00 01 00       	mov    $0x10000,%edx
    7036:	4c 89 f7             	mov    %r14,%rdi
    7039:	31 f6                	xor    %esi,%esi
    703b:	e8 f0 b0 ff ff       	call   2130 <memset@plt>
    7040:	41 8b 07             	mov    (%r15),%eax
    7043:	49 8d 0c 06          	lea    (%r14,%rax,1),%rcx
    7047:	48 89 4b 08          	mov    %rcx,0x8(%rbx)
    704b:	41 8b 4f 04          	mov    0x4(%r15),%ecx
    704f:	48 0f af c8          	imul   %rax,%rcx
    7053:	4c 01 f1             	add    %r14,%rcx
    7056:	48 89 4b 10          	mov    %rcx,0x10(%rbx)
    705a:	4c 89 f0             	mov    %r14,%rax
    705d:	48 83 c4 08          	add    $0x8,%rsp
    7061:	5b                   	pop    %rbx
    7062:	41 5c                	pop    %r12
    7064:	41 5d                	pop    %r13
    7066:	41 5e                	pop    %r14
    7068:	41 5f                	pop    %r15
    706a:	5d                   	pop    %rbp
    706b:	c3                   	ret
    706c:	0f 1f 40 00          	nopl   0x0(%rax)

0000000000007070 <fwp_gc_chunks>:
    7070:	41 57                	push   %r15
    7072:	41 56                	push   %r14
    7074:	53                   	push   %rbx
    7075:	48 89 fb             	mov    %rdi,%rbx
    7078:	31 d2                	xor    %edx,%edx
    707a:	48 83 ff 01          	cmp    $0x1,%rdi
    707e:	0f 95 c2             	setne  %dl
    7081:	48 8d 0d f8 b0 00 00 	lea    0xb0f8(%rip),%rcx        # 12180 <fwp_gc>
    7088:	48 8b 84 d1 68 10 00 	mov    0x1068(%rcx,%rdx,8),%rax
    708f:	00 
    7090:	4c 8b 35 41 c1 00 00 	mov    0xc141(%rip),%r14        # 131d8 <fwp_gc+0x1058>
    7097:	48 89 c7             	mov    %rax,%rdi
    709a:	4c 29 f7             	sub    %r14,%rdi
    709d:	73 63                	jae    7102 <fwp_gc_chunks+0x92>
    709f:	48 8d 34 d5 68 10 00 	lea    0x1068(,%rdx,8),%rsi
    70a6:	00 
    70a7:	4c 69 c0 28 12 00 00 	imul   $0x1228,%rax,%r8
    70ae:	4c 03 05 43 c1 00 00 	add    0xc143(%rip),%r8        # 131f8 <fwp_gc+0x1078>
    70b5:	31 d2                	xor    %edx,%edx
    70b7:	45 31 c9             	xor    %r9d,%r9d
    70ba:	eb 16                	jmp    70d2 <fwp_gc_chunks+0x62>
    70bc:	0f 1f 40 00          	nopl   0x0(%rax)
    70c0:	45 31 c9             	xor    %r9d,%r9d
    70c3:	48 ff ca             	dec    %rdx
    70c6:	49 81 c0 28 12 00 00 	add    $0x1228,%r8
    70cd:	48 39 d7             	cmp    %rdx,%rdi
    70d0:	74 33                	je     7105 <fwp_gc_chunks+0x95>
    70d2:	41 80 38 00          	cmpb   $0x0,(%r8)
    70d6:	75 e8                	jne    70c0 <fwp_gc_chunks+0x50>
    70d8:	49 ff c1             	inc    %r9
    70db:	49 39 d9             	cmp    %rbx,%r9
    70de:	75 e3                	jne    70c3 <fwp_gc_chunks+0x53>
    70e0:	48 ff c0             	inc    %rax
    70e3:	48 89 c7             	mov    %rax,%rdi
    70e6:	48 29 d7             	sub    %rdx,%rdi
    70e9:	48 89 3c 0e          	mov    %rdi,(%rsi,%rcx,1)
    70ed:	48 29 1d 6c c2 00 00 	sub    %rbx,0xc26c(%rip)        # 13360 <fwp_gc+0x11e0>
    70f4:	48 29 d8             	sub    %rbx,%rax
    70f7:	48 29 d0             	sub    %rdx,%rax
    70fa:	49 89 c6             	mov    %rax,%r14
    70fd:	e9 ca 00 00 00       	jmp    71cc <fwp_gc_chunks+0x15c>
    7102:	45 31 c9             	xor    %r9d,%r9d
    7105:	4c 29 0d 54 c2 00 00 	sub    %r9,0xc254(%rip)        # 13360 <fwp_gc+0x11e0>
    710c:	4d 29 ce             	sub    %r9,%r14
    710f:	4c 01 f3             	add    %r14,%rbx
    7112:	48 8b 3d c7 c0 00 00 	mov    0xc0c7(%rip),%rdi        # 131e0 <fwp_gc+0x1060>
    7119:	48 39 df             	cmp    %rbx,%rdi
    711c:	0f 83 8f 00 00 00    	jae    71b1 <fwp_gc_chunks+0x141>
    7122:	4c 8b 3d a7 c0 00 00 	mov    0xc0a7(%rip),%r15        # 131d0 <fwp_gc+0x1050>
    7129:	49 39 df             	cmp    %rbx,%r15
    712c:	0f 82 a3 00 00 00    	jb     71d5 <fwp_gc_chunks+0x165>
    7132:	48 8d 43 40          	lea    0x40(%rbx),%rax
    7136:	4c 39 f8             	cmp    %r15,%rax
    7139:	4c 0f 42 f8          	cmovb  %rax,%r15
    713d:	4c 89 fe             	mov    %r15,%rsi
    7140:	48 29 fe             	sub    %rdi,%rsi
    7143:	48 c1 e7 10          	shl    $0x10,%rdi
    7147:	48 03 3d 62 c0 00 00 	add    0xc062(%rip),%rdi        # 131b0 <fwp_gc+0x1030>
    714e:	48 c1 e6 10          	shl    $0x10,%rsi
    7152:	ba 03 00 00 00       	mov    $0x3,%edx
    7157:	e8 e4 b0 ff ff       	call   2240 <mprotect@plt>
    715c:	85 c0                	test   %eax,%eax
    715e:	75 75                	jne    71d5 <fwp_gc_chunks+0x165>
    7160:	bf 1e 00 00 00       	mov    $0x1e,%edi
    7165:	e8 f6 b0 ff ff       	call   2260 <sysconf@plt>
    716a:	48 8b 0d 87 c0 00 00 	mov    0xc087(%rip),%rcx        # 131f8 <fwp_gc+0x1078>
    7171:	48 69 3d 64 c0 00 00 	imul   $0x1228,0xc064(%rip),%rdi        # 131e0 <fwp_gc+0x1060>
    7178:	28 12 00 00 
    717c:	48 01 cf             	add    %rcx,%rdi
    717f:	49 69 d7 28 12 00 00 	imul   $0x1228,%r15,%rdx
    7186:	48 01 ca             	add    %rcx,%rdx
    7189:	48 8d 34 10          	lea    (%rax,%rdx,1),%rsi
    718d:	48 ff ce             	dec    %rsi
    7190:	48 f7 d8             	neg    %rax
    7193:	48 21 c7             	and    %rax,%rdi
    7196:	48 21 c6             	and    %rax,%rsi
    7199:	48 29 fe             	sub    %rdi,%rsi
    719c:	ba 03 00 00 00       	mov    $0x3,%edx
    71a1:	e8 9a b0 ff ff       	call   2240 <mprotect@plt>
    71a6:	85 c0                	test   %eax,%eax
    71a8:	75 2b                	jne    71d5 <fwp_gc_chunks+0x165>
    71aa:	4c 89 3d 2f c0 00 00 	mov    %r15,0xc02f(%rip)        # 131e0 <fwp_gc+0x1060>
    71b1:	48 89 1d 20 c0 00 00 	mov    %rbx,0xc020(%rip)        # 131d8 <fwp_gc+0x1058>
    71b8:	48 c1 e3 10          	shl    $0x10,%rbx
    71bc:	48 3b 1d 05 c0 00 00 	cmp    0xc005(%rip),%rbx        # 131c8 <fwp_gc+0x1048>
    71c3:	76 07                	jbe    71cc <fwp_gc_chunks+0x15c>
    71c5:	48 89 1d fc bf 00 00 	mov    %rbx,0xbffc(%rip)        # 131c8 <fwp_gc+0x1048>
    71cc:	4c 89 f0             	mov    %r14,%rax
    71cf:	5b                   	pop    %rbx
    71d0:	41 5e                	pop    %r14
    71d2:	41 5f                	pop    %r15
    71d4:	c3                   	ret
    71d5:	48 8b 05 04 ae 00 00 	mov    0xae04(%rip),%rax        # 11fe0 <stderr@GLIBC_2.2.5>
    71dc:	48 8b 08             	mov    (%rax),%rcx
    71df:	48 8d 3d 53 83 00 00 	lea    0x8353(%rip),%rdi        # f539 <fwp_segv.msg+0x2f9>
    71e6:	be 13 00 00 00       	mov    $0x13,%esi
    71eb:	ba 01 00 00 00       	mov    $0x1,%edx
    71f0:	e8 ab b0 ff ff       	call   22a0 <fwrite@plt>
    71f5:	bf 66 00 00 00       	mov    $0x66,%edi
    71fa:	e8 91 b0 ff ff       	call   2290 <exit@plt>
    71ff:	90                   	nop

0000000000007200 <fwp_gc_collect>:
    7200:	50                   	push   %rax
    7201:	e8 5a f0 ff ff       	call   6260 <fwp_flush>
    7206:	48 8b 05 d3 ad 00 00 	mov    0xadd3(%rip),%rax        # 11fe0 <stderr@GLIBC_2.2.5>
    720d:	48 8b 38             	mov    (%rax),%rdi
    7210:	48 8d 35 16 82 00 00 	lea    0x8216(%rip),%rsi        # f42d <fwp_segv.msg+0x1ed>
    7217:	48 8d 15 2f 83 00 00 	lea    0x832f(%rip),%rdx        # f54d <fwp_segv.msg+0x30d>
    721e:	31 c0                	xor    %eax,%eax
    7220:	e8 8b af ff ff       	call   21b0 <fprintf@plt>
    7225:	bf 65 00 00 00       	mov    $0x65,%edi
    722a:	e8 61 b0 ff ff       	call   2290 <exit@plt>
    722f:	90                   	nop

0000000000007230 <f12>:
    7230:	55                   	push   %rbp
    7231:	41 57                	push   %r15
    7233:	41 56                	push   %r14
    7235:	41 55                	push   %r13
    7237:	41 54                	push   %r12
    7239:	53                   	push   %rbx
    723a:	50                   	push   %rax
    723b:	48 89 d3             	mov    %rdx,%rbx
    723e:	49 89 ff             	mov    %rdi,%r15
    7241:	49 bc ff ff ff ff ff 	movabs $0x7fffffffffffffff,%r12
    7248:	ff ff 7f 
    724b:	48 8b 02             	mov    (%rdx),%rax
    724e:	49 89 c6             	mov    %rax,%r14
    7251:	4d 21 e6             	and    %r12,%r14
    7254:	31 c9                	xor    %ecx,%ecx
    7256:	48 85 ff             	test   %rdi,%rdi
    7259:	4c 0f 4e f9          	cmovle %rcx,%r15
    725d:	4d 39 f7             	cmp    %r14,%r15
    7260:	4d 0f 43 fe          	cmovae %r14,%r15
    7264:	48 85 f6             	test   %rsi,%rsi
    7267:	48 0f 4f ce          	cmovg  %rsi,%rcx
    726b:	4d 29 fe             	sub    %r15,%r14
    726e:	4c 39 f1             	cmp    %r14,%rcx
    7271:	4c 0f 42 f1          	cmovb  %rcx,%r14
    7275:	4d 85 f6             	test   %r14,%r14
    7278:	74 10                	je     728a <f12+0x5a>
    727a:	48 89 d9             	mov    %rbx,%rcx
    727d:	48 85 c0             	test   %rax,%rax
    7280:	78 1b                	js     729d <f12+0x6d>
    7282:	49 83 fe 04          	cmp    $0x4,%r14
    7286:	73 1f                	jae    72a7 <f12+0x77>
    7288:	eb 44                	jmp    72ce <f12+0x9e>
    728a:	48 8d 35 bf a9 00 00 	lea    0xa9bf(%rip),%rsi        # 11c50 <d0>
    7291:	31 ff                	xor    %edi,%edi
    7293:	e8 a8 f1 ff ff       	call   6440 <fwp_array_typed_new>
    7298:	e9 7e 00 00 00       	jmp    731b <f12+0xeb>
    729d:	48 8b 4b 08          	mov    0x8(%rbx),%rcx
    72a1:	49 83 fe 04          	cmp    $0x4,%r14
    72a5:	72 27                	jb     72ce <f12+0x9e>
    72a7:	48 8b 09             	mov    (%rcx),%rcx
    72aa:	48 89 ca             	mov    %rcx,%rdx
    72ad:	48 c1 ea 02          	shr    $0x2,%rdx
    72b1:	48 be ff ff ff ff ff 	movabs $0x1fffffffffffffff,%rsi
    72b8:	ff ff 1f 
    72bb:	48 21 d6             	and    %rdx,%rsi
    72be:	83 e1 03             	and    $0x3,%ecx
    72c1:	48 83 f9 01          	cmp    $0x1,%rcx
    72c5:	48 83 de ff          	sbb    $0xffffffffffffffff,%rsi
    72c9:	4c 39 f6             	cmp    %r14,%rsi
    72cc:	76 5c                	jbe    732a <f12+0xfa>
    72ce:	48 8d 35 7b a9 00 00 	lea    0xa97b(%rip),%rsi        # 11c50 <d0>
    72d5:	4c 89 f7             	mov    %r14,%rdi
    72d8:	e8 63 f1 ff ff       	call   6440 <fwp_array_typed_new>
    72dd:	48 8d 4b 08          	lea    0x8(%rbx),%rcx
    72e1:	49 c1 e7 03          	shl    $0x3,%r15
    72e5:	31 d2                	xor    %edx,%edx
    72e7:	66 0f 1f 84 00 00 00 	nopw   0x0(%rax,%rax,1)
    72ee:	00 00 
    72f0:	48 83 3b 00          	cmpq   $0x0,(%rbx)
    72f4:	48 89 ce             	mov    %rcx,%rsi
    72f7:	79 04                	jns    72fd <f12+0xcd>
    72f9:	48 8b 73 10          	mov    0x10(%rbx),%rsi
    72fd:	48 83 38 00          	cmpq   $0x0,(%rax)
    7301:	0f 88 37 02 00 00    	js     753e <f12+0x30e>
    7307:	4c 01 fe             	add    %r15,%rsi
    730a:	48 8b 34 d6          	mov    (%rsi,%rdx,8),%rsi
    730e:	48 89 74 d0 08       	mov    %rsi,0x8(%rax,%rdx,8)
    7313:	48 ff c2             	inc    %rdx
    7316:	49 39 d6             	cmp    %rdx,%r14
    7319:	75 d5                	jne    72f0 <f12+0xc0>
    731b:	48 83 c4 08          	add    $0x8,%rsp
    731f:	5b                   	pop    %rbx
    7320:	41 5c                	pop    %r12
    7322:	41 5d                	pop    %r13
    7324:	41 5e                	pop    %r14
    7326:	41 5f                	pop    %r15
    7328:	5d                   	pop    %rbp
    7329:	c3                   	ret
    732a:	48 85 c0             	test   %rax,%rax
    732d:	78 09                	js     7338 <f12+0x108>
    732f:	48 8d 43 08          	lea    0x8(%rbx),%rax
    7333:	49 89 dd             	mov    %rbx,%r13
    7336:	eb 08                	jmp    7340 <f12+0x110>
    7338:	4c 8b 6b 08          	mov    0x8(%rbx),%r13
    733c:	48 8b 43 10          	mov    0x10(%rbx),%rax
    7340:	4a 8d 2c f8          	lea    (%rax,%r15,8),%rbp
    7344:	48 8d 0d 35 ae 00 00 	lea    0xae35(%rip),%rcx        # 12180 <fwp_gc>
    734b:	0f b6 05 18 ba 00 00 	movzbl 0xba18(%rip),%eax        # 12d6a <fwp_gc+0xbea>
    7352:	8b 94 81 48 0b 00 00 	mov    0xb48(%rcx,%rax,4),%edx
    7359:	48 8b 3d 20 ae 00 00 	mov    0xae20(%rip),%rdi        # 12180 <fwp_gc>
    7360:	48 29 d7             	sub    %rdx,%rdi
    7363:	48 89 3d 16 ae 00 00 	mov    %rdi,0xae16(%rip)        # 12180 <fwp_gc>
    736a:	78 56                	js     73c2 <f12+0x192>
    736c:	48 8d 34 40          	lea    (%rax,%rax,2),%rsi
    7370:	4c 8d 04 f1          	lea    (%rcx,%rsi,8),%r8
    7374:	49 83 c0 08          	add    $0x8,%r8
    7378:	49 8b 00             	mov    (%r8),%rax
    737b:	48 85 c0             	test   %rax,%rax
    737e:	74 25                	je     73a5 <f12+0x175>
    7380:	48 8b 08             	mov    (%rax),%rcx
    7383:	48 f7 d1             	not    %rcx
    7386:	49 89 08             	mov    %rcx,(%r8)
    7389:	83 fa 19             	cmp    $0x19,%edx
    738c:	72 7e                	jb     740c <f12+0x1dc>
    738e:	48 8d 78 18          	lea    0x18(%rax),%rdi
    7392:	48 83 c2 e7          	add    $0xffffffffffffffe7,%rdx
    7396:	48 83 e2 f8          	and    $0xfffffffffffffff8,%rdx
    739a:	48 83 c2 08          	add    $0x8,%rdx
    739e:	31 f6                	xor    %esi,%esi
    73a0:	49 89 c7             	mov    %rax,%r15
    73a3:	eb 5f                	jmp    7404 <f12+0x1d4>
    73a5:	48 8b 44 f1 10       	mov    0x10(%rcx,%rsi,8),%rax
    73aa:	4c 8b 44 f1 18       	mov    0x18(%rcx,%rsi,8),%r8
    73af:	4d 89 c1             	mov    %r8,%r9
    73b2:	49 29 c1             	sub    %rax,%r9
    73b5:	49 39 d1             	cmp    %rdx,%r9
    73b8:	73 16                	jae    73d0 <f12+0x1a0>
    73ba:	49 89 c7             	mov    %rax,%r15
    73bd:	49 39 d1             	cmp    %rdx,%r9
    73c0:	73 34                	jae    73f6 <f12+0x1c6>
    73c2:	bf 18 00 00 00       	mov    $0x18,%edi
    73c7:	31 f6                	xor    %esi,%esi
    73c9:	e8 e2 f2 ff ff       	call   66b0 <fwp_gc_alloc_slow>
    73ce:	eb 3c                	jmp    740c <f12+0x1dc>
    73d0:	4c 8d 0c f1          	lea    (%rcx,%rsi,8),%r9
    73d4:	49 83 c1 10          	add    $0x10,%r9
    73d8:	4c 8d 3c 10          	lea    (%rax,%rdx,1),%r15
    73dc:	4d 89 39             	mov    %r15,(%r9)
    73df:	48 85 c0             	test   %rax,%rax
    73e2:	75 a5                	jne    7389 <f12+0x159>
    73e4:	48 89 3d 95 ad 00 00 	mov    %rdi,0xad95(%rip)        # 12180 <fwp_gc>
    73eb:	4d 29 f8             	sub    %r15,%r8
    73ee:	4d 89 c1             	mov    %r8,%r9
    73f1:	49 39 d1             	cmp    %rdx,%r9
    73f4:	72 cc                	jb     73c2 <f12+0x192>
    73f6:	49 8d 04 17          	lea    (%r15,%rdx,1),%rax
    73fa:	48 89 44 f1 10       	mov    %rax,0x10(%rcx,%rsi,8)
    73ff:	4c 89 ff             	mov    %r15,%rdi
    7402:	31 f6                	xor    %esi,%esi
    7404:	e8 27 ad ff ff       	call   2130 <memset@plt>
    7409:	4c 89 f8             	mov    %r15,%rax
    740c:	4b 8d 0c 34          	lea    (%r12,%r14,1),%rcx
    7410:	48 ff c1             	inc    %rcx
    7413:	48 89 08             	mov    %rcx,(%rax)
    7416:	4c 89 68 08          	mov    %r13,0x8(%rax)
    741a:	48 89 68 10          	mov    %rbp,0x10(%rax)
    741e:	4c 2b 2d 8b bd 00 00 	sub    0xbd8b(%rip),%r13        # 131b0 <fwp_gc+0x1030>
    7425:	48 8b 0d ac bd 00 00 	mov    0xbdac(%rip),%rcx        # 131d8 <fwp_gc+0x1058>
    742c:	48 c1 e1 10          	shl    $0x10,%rcx
    7430:	49 39 cd             	cmp    %rcx,%r13
    7433:	73 6a                	jae    749f <f12+0x26f>
    7435:	48 8b 0d bc bd 00 00 	mov    0xbdbc(%rip),%rcx        # 131f8 <fwp_gc+0x1078>
    743c:	4c 89 ea             	mov    %r13,%rdx
    743f:	48 c1 ea 10          	shr    $0x10,%rdx
    7443:	48 69 d2 28 12 00 00 	imul   $0x1228,%rdx,%rdx
    744a:	0f b6 34 11          	movzbl (%rcx,%rdx,1),%esi
    744e:	49 81 e5 ff ff 00 00 	and    $0xffff,%r13
    7455:	75 13                	jne    746a <f12+0x23a>
    7457:	40 80 fe 02          	cmp    $0x2,%sil
    745b:	75 0d                	jne    746a <f12+0x23a>
    745d:	48 8d 3c 11          	lea    (%rcx,%rdx,1),%rdi
    7461:	48 81 c7 28 02 00 00 	add    $0x228,%rdi
    7468:	eb 21                	jmp    748b <f12+0x25b>
    746a:	40 80 fe 01          	cmp    $0x1,%sil
    746e:	75 2f                	jne    749f <f12+0x26f>
    7470:	48 8d 34 11          	lea    (%rcx,%rdx,1),%rsi
    7474:	8b 4c 11 20          	mov    0x20(%rcx,%rdx,1),%ecx
    7478:	4c 0f af e9          	imul   %rcx,%r13
    747c:	49 c1 ed 20          	shr    $0x20,%r13
    7480:	4a 8d 3c 2e          	lea    (%rsi,%r13,1),%rdi
    7484:	48 81 c7 28 02 00 00 	add    $0x228,%rdi
    748b:	0f b6 0f             	movzbl (%rdi),%ecx
    748e:	84 c9                	test   %cl,%cl
    7490:	74 0d                	je     749f <f12+0x26f>
    7492:	80 f9 fe             	cmp    $0xfe,%cl
    7495:	0f 83 93 00 00 00    	jae    752e <f12+0x2fe>
    749b:	fe c1                	inc    %cl
    749d:	88 0f                	mov    %cl,(%rdi)
    749f:	48 89 c1             	mov    %rax,%rcx
    74a2:	48 2b 0d 07 bd 00 00 	sub    0xbd07(%rip),%rcx        # 131b0 <fwp_gc+0x1030>
    74a9:	48 8b 15 28 bd 00 00 	mov    0xbd28(%rip),%rdx        # 131d8 <fwp_gc+0x1058>
    74b0:	48 c1 e2 10          	shl    $0x10,%rdx
    74b4:	48 39 d1             	cmp    %rdx,%rcx
    74b7:	73 60                	jae    7519 <f12+0x2e9>
    74b9:	48 8b 15 38 bd 00 00 	mov    0xbd38(%rip),%rdx        # 131f8 <fwp_gc+0x1078>
    74c0:	48 89 ce             	mov    %rcx,%rsi
    74c3:	48 c1 ee 10          	shr    $0x10,%rsi
    74c7:	48 69 f6 28 12 00 00 	imul   $0x1228,%rsi,%rsi
    74ce:	0f b6 3c 32          	movzbl (%rdx,%rsi,1),%edi
    74d2:	48 81 e1 ff ff 00 00 	and    $0xffff,%rcx
    74d9:	75 13                	jne    74ee <f12+0x2be>
    74db:	40 80 ff 02          	cmp    $0x2,%dil
    74df:	75 0d                	jne    74ee <f12+0x2be>
    74e1:	4c 8d 34 32          	lea    (%rdx,%rsi,1),%r14
    74e5:	49 81 c6 28 02 00 00 	add    $0x228,%r14
    74ec:	eb 21                	jmp    750f <f12+0x2df>
    74ee:	40 80 ff 01          	cmp    $0x1,%dil
    74f2:	75 25                	jne    7519 <f12+0x2e9>
    74f4:	48 8d 3c 32          	lea    (%rdx,%rsi,1),%rdi
    74f8:	8b 54 32 20          	mov    0x20(%rdx,%rsi,1),%edx
    74fc:	48 0f af ca          	imul   %rdx,%rcx
    7500:	48 c1 e9 20          	shr    $0x20,%rcx
    7504:	4c 8d 34 39          	lea    (%rcx,%rdi,1),%r14
    7508:	49 81 c6 28 02 00 00 	add    $0x228,%r14
    750f:	41 80 3e ff          	cmpb   $0xff,(%r14)
    7513:	74 09                	je     751e <f12+0x2ee>
    7515:	41 c6 06 01          	movb   $0x1,(%r14)
    7519:	e9 fd fd ff ff       	jmp    731b <f12+0xeb>
    751e:	4c 89 f7             	mov    %r14,%rdi
    7521:	49 89 c7             	mov    %rax,%r15
    7524:	e8 67 ed ff ff       	call   6290 <fwp_rc_forget_slot>
    7529:	4c 89 f8             	mov    %r15,%rax
    752c:	eb e7                	jmp    7515 <f12+0x2e5>
    752e:	49 89 c6             	mov    %rax,%r14
    7531:	e8 3a 00 00 00       	call   7570 <fwp_rc_wide_dup>
    7536:	4c 89 f0             	mov    %r14,%rax
    7539:	e9 61 ff ff ff       	jmp    749f <f12+0x26f>
    753e:	e8 1d ed ff ff       	call   6260 <fwp_flush>
    7543:	48 8b 05 96 aa 00 00 	mov    0xaa96(%rip),%rax        # 11fe0 <stderr@GLIBC_2.2.5>
    754a:	48 8b 38             	mov    (%rax),%rdi
    754d:	48 8d 35 d9 7e 00 00 	lea    0x7ed9(%rip),%rsi        # f42d <fwp_segv.msg+0x1ed>
    7554:	48 8d 15 23 80 00 00 	lea    0x8023(%rip),%rdx        # f57e <fwp_segv.msg+0x33e>
    755b:	31 c0                	xor    %eax,%eax
    755d:	e8 4e ac ff ff       	call   21b0 <fprintf@plt>
    7562:	bf 65 00 00 00       	mov    $0x65,%edi
    7567:	e8 24 ad ff ff       	call   2290 <exit@plt>
    756c:	0f 1f 40 00          	nopl   0x0(%rax)

0000000000007570 <fwp_rc_wide_dup>:
    7570:	41 56                	push   %r14
    7572:	53                   	push   %rbx
    7573:	50                   	push   %rax
    7574:	48 89 fb             	mov    %rdi,%rbx
    7577:	48 89 f8             	mov    %rdi,%rax
    757a:	48 c1 e8 11          	shr    $0x11,%rax
    757e:	31 d8                	xor    %ebx,%eax
    7580:	89 c1                	mov    %eax,%ecx
    7582:	c1 e9 09             	shr    $0x9,%ecx
    7585:	31 c1                	xor    %eax,%ecx
    7587:	0f b6 c1             	movzbl %cl,%eax
    758a:	48 8d 0d ef ab 00 00 	lea    0xabef(%rip),%rcx        # 12180 <fwp_gc>
    7591:	4c 8d 34 c1          	lea    (%rcx,%rax,8),%r14
    7595:	49 81 c6 18 12 00 00 	add    $0x1218,%r14
    759c:	48 8b 84 c1 18 12 00 	mov    0x1218(%rcx,%rax,8),%rax
    75a3:	00 
    75a4:	48 85 c0             	test   %rax,%rax
    75a7:	74 1a                	je     75c3 <fwp_rc_wide_dup+0x53>
    75a9:	48 39 18             	cmp    %rbx,(%rax)
    75ac:	74 22                	je     75d0 <fwp_rc_wide_dup+0x60>
    75ae:	66 90                	xchg   %ax,%ax
    75b0:	49 89 c6             	mov    %rax,%r14
    75b3:	48 8b 40 10          	mov    0x10(%rax),%rax
    75b7:	48 85 c0             	test   %rax,%rax
    75ba:	74 0e                	je     75ca <fwp_rc_wide_dup+0x5a>
    75bc:	48 39 18             	cmp    %rbx,(%rax)
    75bf:	75 ef                	jne    75b0 <fwp_rc_wide_dup+0x40>
    75c1:	eb 09                	jmp    75cc <fwp_rc_wide_dup+0x5c>
    75c3:	80 3b fe             	cmpb   $0xfe,(%rbx)
    75c6:	74 16                	je     75de <fwp_rc_wide_dup+0x6e>
    75c8:	eb 6d                	jmp    7637 <fwp_rc_wide_dup+0xc7>
    75ca:	31 c0                	xor    %eax,%eax
    75cc:	49 83 c6 10          	add    $0x10,%r14
    75d0:	80 3b fe             	cmpb   $0xfe,(%rbx)
    75d3:	75 41                	jne    7616 <fwp_rc_wide_dup+0xa6>
    75d5:	48 85 c0             	test   %rax,%rax
    75d8:	0f 85 a2 00 00 00    	jne    7680 <fwp_rc_wide_dup+0x110>
    75de:	bf 18 00 00 00       	mov    $0x18,%edi
    75e3:	e8 08 ac ff ff       	call   21f0 <malloc@plt>
    75e8:	48 85 c0             	test   %rax,%rax
    75eb:	74 69                	je     7656 <fwp_rc_wide_dup+0xe6>
    75ed:	48 89 18             	mov    %rbx,(%rax)
    75f0:	48 c7 40 08 ff 00 00 	movq   $0xff,0x8(%rax)
    75f7:	00 
    75f8:	48 c7 40 10 00 00 00 	movq   $0x0,0x10(%rax)
    75ff:	00 
    7600:	49 89 06             	mov    %rax,(%r14)
    7603:	c6 03 ff             	movb   $0xff,(%rbx)
    7606:	48 8d 05 8b c5 00 00 	lea    0xc58b(%rip),%rax        # 13b98 <fwp_gc+0x1a18>
    760d:	48 8b 0d 84 c5 00 00 	mov    0xc584(%rip),%rcx        # 13b98 <fwp_gc+0x1a18>
    7614:	eb 13                	jmp    7629 <fwp_rc_wide_dup+0xb9>
    7616:	48 85 c0             	test   %rax,%rax
    7619:	74 1c                	je     7637 <fwp_rc_wide_dup+0xc7>
    761b:	48 8b 48 08          	mov    0x8(%rax),%rcx
    761f:	48 83 f9 ff          	cmp    $0xffffffffffffffff,%rcx
    7623:	74 7a                	je     769f <fwp_rc_wide_dup+0x12f>
    7625:	48 83 c0 08          	add    $0x8,%rax
    7629:	48 ff c1             	inc    %rcx
    762c:	48 89 08             	mov    %rcx,(%rax)
    762f:	48 83 c4 08          	add    $0x8,%rsp
    7633:	5b                   	pop    %rbx
    7634:	41 5e                	pop    %r14
    7636:	c3                   	ret
    7637:	e8 24 ec ff ff       	call   6260 <fwp_flush>
    763c:	48 8b 05 9d a9 00 00 	mov    0xa99d(%rip),%rax        # 11fe0 <stderr@GLIBC_2.2.5>
    7643:	48 8b 38             	mov    (%rax),%rdi
    7646:	48 8d 35 e0 7d 00 00 	lea    0x7de0(%rip),%rsi        # f42d <fwp_segv.msg+0x1ed>
    764d:	48 8d 15 e8 7d 00 00 	lea    0x7de8(%rip),%rdx        # f43c <fwp_segv.msg+0x1fc>
    7654:	eb 66                	jmp    76bc <fwp_rc_wide_dup+0x14c>
    7656:	48 8b 05 83 a9 00 00 	mov    0xa983(%rip),%rax        # 11fe0 <stderr@GLIBC_2.2.5>
    765d:	48 8b 08             	mov    (%rax),%rcx
    7660:	48 8d 3d d2 7e 00 00 	lea    0x7ed2(%rip),%rdi        # f539 <fwp_segv.msg+0x2f9>
    7667:	be 13 00 00 00       	mov    $0x13,%esi
    766c:	ba 01 00 00 00       	mov    $0x1,%edx
    7671:	e8 2a ac ff ff       	call   22a0 <fwrite@plt>
    7676:	bf 66 00 00 00       	mov    $0x66,%edi
    767b:	e8 10 ac ff ff       	call   2290 <exit@plt>
    7680:	e8 db eb ff ff       	call   6260 <fwp_flush>
    7685:	48 8b 05 54 a9 00 00 	mov    0xa954(%rip),%rax        # 11fe0 <stderr@GLIBC_2.2.5>
    768c:	48 8b 38             	mov    (%rax),%rdi
    768f:	48 8d 35 97 7d 00 00 	lea    0x7d97(%rip),%rsi        # f42d <fwp_segv.msg+0x1ed>
    7696:	48 8d 15 0d 7f 00 00 	lea    0x7f0d(%rip),%rdx        # f5aa <fwp_segv.msg+0x36a>
    769d:	eb 1d                	jmp    76bc <fwp_rc_wide_dup+0x14c>
    769f:	e8 bc eb ff ff       	call   6260 <fwp_flush>
    76a4:	48 8b 05 35 a9 00 00 	mov    0xa935(%rip),%rax        # 11fe0 <stderr@GLIBC_2.2.5>
    76ab:	48 8b 38             	mov    (%rax),%rdi
    76ae:	48 8d 35 78 7d 00 00 	lea    0x7d78(%rip),%rsi        # f42d <fwp_segv.msg+0x1ed>
    76b5:	48 8d 15 13 7f 00 00 	lea    0x7f13(%rip),%rdx        # f5cf <fwp_segv.msg+0x38f>
    76bc:	31 c0                	xor    %eax,%eax
    76be:	e8 ed aa ff ff       	call   21b0 <fprintf@plt>
    76c3:	bf 65 00 00 00       	mov    $0x65,%edi
    76c8:	e8 c3 ab ff ff       	call   2290 <exit@plt>
    76cd:	0f 1f 00             	nopl   (%rax)

00000000000076d0 <fwp_show>:
    76d0:	41 57                	push   %r15
    76d2:	41 56                	push   %r14
    76d4:	41 54                	push   %r12
    76d6:	53                   	push   %rbx
    76d7:	48 83 ec 18          	sub    $0x18,%rsp
    76db:	48 89 f2             	mov    %rsi,%rdx
    76de:	48 89 fe             	mov    %rdi,%rsi
    76e1:	0f 57 c0             	xorps  %xmm0,%xmm0
    76e4:	0f 29 04 24          	movaps %xmm0,(%rsp)
    76e8:	48 c7 44 24 10 00 00 	movq   $0x0,0x10(%rsp)
    76ef:	00 00 
    76f1:	48 89 e7             	mov    %rsp,%rdi
    76f4:	b9 01 00 00 00       	mov    $0x1,%ecx
    76f9:	e8 e2 00 00 00       	call   77e0 <fwp_write>
    76fe:	4c 8b 24 24          	mov    (%rsp),%r12
    7702:	48 8b 5c 24 08       	mov    0x8(%rsp),%rbx
    7707:	48 8d 53 09          	lea    0x9(%rbx),%rdx
    770b:	48 81 fa 00 40 00 00 	cmp    $0x4000,%rdx
    7712:	77 61                	ja     7775 <fwp_show+0xa5>
    7714:	48 8d 4b 18          	lea    0x18(%rbx),%rcx
    7718:	48 c1 e9 04          	shr    $0x4,%rcx
    771c:	48 8d 05 5d aa 00 00 	lea    0xaa5d(%rip),%rax        # 12180 <fwp_gc>
    7723:	0f b6 b4 01 e8 0b 00 	movzbl 0xbe8(%rcx,%rax,1),%esi
    772a:	00 
    772b:	8b 8c b0 48 0b 00 00 	mov    0xb48(%rax,%rsi,4),%ecx
    7732:	48 29 0d 47 aa 00 00 	sub    %rcx,0xaa47(%rip)        # 12180 <fwp_gc>
    7739:	78 3a                	js     7775 <fwp_show+0xa5>
    773b:	48 8d 34 76          	lea    (%rsi,%rsi,2),%rsi
    773f:	48 8d 3c f0          	lea    (%rax,%rsi,8),%rdi
    7743:	48 81 c7 c8 03 00 00 	add    $0x3c8,%rdi
    774a:	4c 8b 37             	mov    (%rdi),%r14
    774d:	4d 85 f6             	test   %r14,%r14
    7750:	74 0b                	je     775d <fwp_show+0x8d>
    7752:	49 8b 06             	mov    (%r14),%rax
    7755:	48 f7 d0             	not    %rax
    7758:	48 89 07             	mov    %rax,(%rdi)
    775b:	eb 3a                	jmp    7797 <fwp_show+0xc7>
    775d:	4c 8b b4 f0 d0 03 00 	mov    0x3d0(%rax,%rsi,8),%r14
    7764:	00 
    7765:	48 8b bc f0 d8 03 00 	mov    0x3d8(%rax,%rsi,8),%rdi
    776c:	00 
    776d:	4c 29 f7             	sub    %r14,%rdi
    7770:	48 39 cf             	cmp    %rcx,%rdi
    7773:	73 12                	jae    7787 <fwp_show+0xb7>
    7775:	48 89 d7             	mov    %rdx,%rdi
    7778:	be 01 00 00 00       	mov    $0x1,%esi
    777d:	e8 2e ef ff ff       	call   66b0 <fwp_gc_alloc_slow>
    7782:	49 89 c6             	mov    %rax,%r14
    7785:	eb 1a                	jmp    77a1 <fwp_show+0xd1>
    7787:	48 8d 04 f0          	lea    (%rax,%rsi,8),%rax
    778b:	48 05 d0 03 00 00    	add    $0x3d0,%rax
    7791:	4c 01 f1             	add    %r14,%rcx
    7794:	48 89 08             	mov    %rcx,(%rax)
    7797:	4c 89 f7             	mov    %r14,%rdi
    779a:	31 f6                	xor    %esi,%esi
    779c:	e8 8f a9 ff ff       	call   2130 <memset@plt>
    77a1:	4d 85 e4             	test   %r12,%r12
    77a4:	4c 8d 3d 84 7f 00 00 	lea    0x7f84(%rip),%r15        # f72f <fwp_segv.msg+0x4ef>
    77ab:	4d 0f 45 fc          	cmovne %r12,%r15
    77af:	49 89 1e             	mov    %rbx,(%r14)
    77b2:	49 8d 7e 08          	lea    0x8(%r14),%rdi
    77b6:	4c 89 fe             	mov    %r15,%rsi
    77b9:	48 89 da             	mov    %rbx,%rdx
    77bc:	e8 1f aa ff ff       	call   21e0 <memcpy@plt>
    77c1:	41 c6 44 1e 08 00    	movb   $0x0,0x8(%r14,%rbx,1)
    77c7:	48 8b 3c 24          	mov    (%rsp),%rdi
    77cb:	e8 80 a8 ff ff       	call   2050 <free@plt>
    77d0:	4c 89 f0             	mov    %r14,%rax
    77d3:	48 83 c4 18          	add    $0x18,%rsp
    77d7:	5b                   	pop    %rbx
    77d8:	41 5c                	pop    %r12
    77da:	41 5e                	pop    %r14
    77dc:	41 5f                	pop    %r15
    77de:	c3                   	ret
    77df:	90                   	nop

00000000000077e0 <fwp_write>:
    77e0:	55                   	push   %rbp
    77e1:	41 57                	push   %r15
    77e3:	41 56                	push   %r14
    77e5:	41 55                	push   %r13
    77e7:	41 54                	push   %r12
    77e9:	53                   	push   %rbx
    77ea:	48 81 ec 78 02 00 00 	sub    $0x278,%rsp
    77f1:	8b 02                	mov    (%rdx),%eax
    77f3:	48 83 f8 19          	cmp    $0x19,%rax
    77f7:	0f 87 26 12 00 00    	ja     8a23 <fwp_write+0x1243>
    77fd:	49 89 d7             	mov    %rdx,%r15
    7800:	49 89 f6             	mov    %rsi,%r14
    7803:	48 89 fd             	mov    %rdi,%rbp
    7806:	48 8d 15 13 79 00 00 	lea    0x7913(%rip),%rdx        # f120 <_IO_stdin_used+0x120>
    780d:	48 63 34 82          	movslq (%rdx,%rax,4),%rsi
    7811:	48 01 d6             	add    %rdx,%rsi
    7814:	48 89 3c 24          	mov    %rdi,(%rsp)
    7818:	ff e6                	jmp    *%rsi
    781a:	48 8d 15 c7 7d 00 00 	lea    0x7dc7(%rip),%rdx        # f5e8 <fwp_segv.msg+0x3a8>
    7821:	eb 07                	jmp    782a <fwp_write+0x4a>
    7823:	48 8d 15 c3 7d 00 00 	lea    0x7dc3(%rip),%rdx        # f5ed <fwp_segv.msg+0x3ad>
    782a:	4c 8d 7c 24 70       	lea    0x70(%rsp),%r15
    782f:	be 00 02 00 00       	mov    $0x200,%esi
    7834:	4c 89 ff             	mov    %r15,%rdi
    7837:	4c 89 f1             	mov    %r14,%rcx
    783a:	31 c0                	xor    %eax,%eax
    783c:	e8 cf a8 ff ff       	call   2110 <snprintf@plt>
    7841:	4c 89 ff             	mov    %r15,%rdi
    7844:	e8 97 a8 ff ff       	call   20e0 <strlen@plt>
    7849:	48 89 ef             	mov    %rbp,%rdi
    784c:	4c 89 fe             	mov    %r15,%rsi
    784f:	e9 c7 11 00 00       	jmp    8a1b <fwp_write+0x123b>
    7854:	83 f8 13             	cmp    $0x13,%eax
    7857:	48 8d 05 c9 7d 00 00 	lea    0x7dc9(%rip),%rax        # f627 <fwp_segv.msg+0x3e7>
    785e:	48 8d 35 c7 7d 00 00 	lea    0x7dc7(%rip),%rsi        # f62c <fwp_segv.msg+0x3ec>
    7865:	48 0f 44 f0          	cmove  %rax,%rsi
    7869:	ba 04 00 00 00       	mov    $0x4,%edx
    786e:	48 89 ef             	mov    %rbp,%rdi
    7871:	e8 4a 13 00 00       	call   8bc0 <buf_put>
    7876:	49 83 3e 00          	cmpq   $0x0,(%r14)
    787a:	0f 84 c3 00 00 00    	je     7943 <fwp_write+0x163>
    7880:	49 8b 57 38          	mov    0x38(%r15),%rdx
    7884:	49 8b 76 08          	mov    0x8(%r14),%rsi
    7888:	48 8b 1c 24          	mov    (%rsp),%rbx
    788c:	48 89 df             	mov    %rbx,%rdi
    788f:	31 c9                	xor    %ecx,%ecx
    7891:	e8 4a ff ff ff       	call   77e0 <fwp_write>
    7896:	41 83 3f 12          	cmpl   $0x12,(%r15)
    789a:	75 26                	jne    78c2 <fwp_write+0xe2>
    789c:	48 8d 35 8e 7d 00 00 	lea    0x7d8e(%rip),%rsi        # f631 <fwp_segv.msg+0x3f1>
    78a3:	ba 02 00 00 00       	mov    $0x2,%edx
    78a8:	48 89 df             	mov    %rbx,%rdi
    78ab:	e8 10 13 00 00       	call   8bc0 <buf_put>
    78b0:	49 8b 76 10          	mov    0x10(%r14),%rsi
    78b4:	49 8b 57 40          	mov    0x40(%r15),%rdx
    78b8:	48 89 df             	mov    %rbx,%rdi
    78bb:	31 c9                	xor    %ecx,%ecx
    78bd:	e8 1e ff ff ff       	call   77e0 <fwp_write>
    78c2:	49 83 3e 02          	cmpq   $0x2,(%r14)
    78c6:	72 7b                	jb     7943 <fwp_write+0x163>
    78c8:	49 8d 5e 20          	lea    0x20(%r14),%rbx
    78cc:	bd 01 00 00 00       	mov    $0x1,%ebp
    78d1:	4c 8d 25 42 7d 00 00 	lea    0x7d42(%rip),%r12        # f61a <fwp_segv.msg+0x3da>
    78d8:	eb 12                	jmp    78ec <fwp_write+0x10c>
    78da:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)
    78e0:	48 ff c5             	inc    %rbp
    78e3:	48 83 c3 10          	add    $0x10,%rbx
    78e7:	49 3b 2e             	cmp    (%r14),%rbp
    78ea:	73 57                	jae    7943 <fwp_write+0x163>
    78ec:	ba 02 00 00 00       	mov    $0x2,%edx
    78f1:	4c 8b 2c 24          	mov    (%rsp),%r13
    78f5:	4c 89 ef             	mov    %r13,%rdi
    78f8:	4c 89 e6             	mov    %r12,%rsi
    78fb:	e8 c0 12 00 00       	call   8bc0 <buf_put>
    7900:	48 8b 73 f8          	mov    -0x8(%rbx),%rsi
    7904:	49 8b 57 38          	mov    0x38(%r15),%rdx
    7908:	4c 89 ef             	mov    %r13,%rdi
    790b:	31 c9                	xor    %ecx,%ecx
    790d:	e8 ce fe ff ff       	call   77e0 <fwp_write>
    7912:	41 83 3f 12          	cmpl   $0x12,(%r15)
    7916:	75 c8                	jne    78e0 <fwp_write+0x100>
    7918:	ba 02 00 00 00       	mov    $0x2,%edx
    791d:	4c 8b 2c 24          	mov    (%rsp),%r13
    7921:	4c 89 ef             	mov    %r13,%rdi
    7924:	48 8d 35 06 7d 00 00 	lea    0x7d06(%rip),%rsi        # f631 <fwp_segv.msg+0x3f1>
    792b:	e8 90 12 00 00       	call   8bc0 <buf_put>
    7930:	48 8b 33             	mov    (%rbx),%rsi
    7933:	49 8b 57 40          	mov    0x40(%r15),%rdx
    7937:	4c 89 ef             	mov    %r13,%rdi
    793a:	31 c9                	xor    %ecx,%ecx
    793c:	e8 9f fe ff ff       	call   77e0 <fwp_write>
    7941:	eb 9d                	jmp    78e0 <fwp_write+0x100>
    7943:	c6 44 24 70 7d       	movb   $0x7d,0x70(%rsp)
    7948:	48 8d 74 24 70       	lea    0x70(%rsp),%rsi
    794d:	ba 01 00 00 00       	mov    $0x1,%edx
    7952:	48 8b 3c 24          	mov    (%rsp),%rdi
    7956:	e9 c3 10 00 00       	jmp    8a1e <fwp_write+0x123e>
    795b:	4d 8b 67 08          	mov    0x8(%r15),%r12
    795f:	4d 85 e4             	test   %r12,%r12
    7962:	0f 84 af 06 00 00    	je     8017 <fwp_write+0x837>
    7968:	48 8d 35 c5 7c 00 00 	lea    0x7cc5(%rip),%rsi        # f634 <fwp_segv.msg+0x3f4>
    796f:	4c 89 e7             	mov    %r12,%rdi
    7972:	e8 09 a8 ff ff       	call   2180 <strcmp@plt>
    7977:	85 c0                	test   %eax,%eax
    7979:	0f 84 36 0b 00 00    	je     84b5 <fwp_write+0xcd5>
    797f:	4d 8d 6f 10          	lea    0x10(%r15),%r13
    7983:	4c 89 e7             	mov    %r12,%rdi
    7986:	e8 55 a7 ff ff       	call   20e0 <strlen@plt>
    798b:	48 89 ef             	mov    %rbp,%rdi
    798e:	4c 89 e6             	mov    %r12,%rsi
    7991:	48 89 c2             	mov    %rax,%rdx
    7994:	e8 27 12 00 00       	call   8bc0 <buf_put>
    7999:	c6 44 24 70 20       	movb   $0x20,0x70(%rsp)
    799e:	48 8d 74 24 70       	lea    0x70(%rsp),%rsi
    79a3:	ba 01 00 00 00       	mov    $0x1,%edx
    79a8:	48 89 ef             	mov    %rbp,%rdi
    79ab:	e8 10 12 00 00       	call   8bc0 <buf_put>
    79b0:	31 db                	xor    %ebx,%ebx
    79b2:	e9 7f 06 00 00       	jmp    8036 <fwp_write+0x856>
    79b7:	49 81 fe ff 0f 00 00 	cmp    $0xfff,%r14
    79be:	0f 87 00 05 00 00    	ja     7ec4 <fwp_write+0x6e4>
    79c4:	44 89 f0             	mov    %r14d,%eax
    79c7:	e9 fb 04 00 00       	jmp    7ec7 <fwp_write+0x6e7>
    79cc:	66 49 0f 6e ce       	movq   %r14,%xmm1
    79d1:	66 0f 2e c9          	ucomisd %xmm1,%xmm1
    79d5:	0f 8a d2 11 00 00    	jp     8bad <fwp_write+0x13cd>
    79db:	66 0f 28 05 ed 76 00 	movapd 0x76ed(%rip),%xmm0        # f0d0 <_IO_stdin_used+0xd0>
    79e2:	00 
    79e3:	66 0f 54 c1          	andpd  %xmm1,%xmm0
    79e7:	66 0f 2e 05 31 76 00 	ucomisd 0x7631(%rip),%xmm0        # f020 <_IO_stdin_used+0x20>
    79ee:	00 
    79ef:	0f 82 66 08 00 00    	jb     825b <fwp_write+0xa7b>
    79f5:	66 0f 57 c0          	xorpd  %xmm0,%xmm0
    79f9:	66 0f 2e c8          	ucomisd %xmm0,%xmm1
    79fd:	e9 55 04 00 00       	jmp    7e57 <fwp_write+0x677>
    7a02:	c6 44 24 70 3c       	movb   $0x3c,0x70(%rsp)
    7a07:	48 8d 74 24 70       	lea    0x70(%rsp),%rsi
    7a0c:	ba 01 00 00 00       	mov    $0x1,%edx
    7a11:	48 89 ef             	mov    %rbp,%rdi
    7a14:	e8 a7 11 00 00       	call   8bc0 <buf_put>
    7a19:	4d 8b 77 08          	mov    0x8(%r15),%r14
    7a1d:	e9 82 04 00 00       	jmp    7ea4 <fwp_write+0x6c4>
    7a22:	48 8d 35 da 7b 00 00 	lea    0x7bda(%rip),%rsi        # f603 <fwp_segv.msg+0x3c3>
    7a29:	ba 08 00 00 00       	mov    $0x8,%edx
    7a2e:	48 89 ef             	mov    %rbp,%rdi
    7a31:	e9 5c 0d 00 00       	jmp    8792 <fwp_write+0xfb2>
    7a36:	49 8d 76 08          	lea    0x8(%r14),%rsi
    7a3a:	49 8b 16             	mov    (%r14),%rdx
    7a3d:	85 c9                	test   %ecx,%ecx
    7a3f:	0f 84 13 07 00 00    	je     8158 <fwp_write+0x978>
    7a45:	48 89 ef             	mov    %rbp,%rdi
    7a48:	e9 45 0d 00 00       	jmp    8792 <fwp_write+0xfb2>
    7a4d:	4d 8b 0e             	mov    (%r14),%r9
    7a50:	4d 8b 46 08          	mov    0x8(%r14),%r8
    7a54:	4c 89 c8             	mov    %r9,%rax
    7a57:	4c 09 c0             	or     %r8,%rax
    7a5a:	0f 84 11 07 00 00    	je     8171 <fwp_write+0x991>
    7a60:	31 ff                	xor    %edi,%edi
    7a62:	49 ba cd cc cc cc cc 	movabs $0xcccccccccccccccd,%r10
    7a69:	cc cc cc 
    7a6c:	49 bb cc cc cc cc cc 	movabs $0xcccccccccccccccc,%r11
    7a73:	cc cc cc 
    7a76:	4c 89 c3             	mov    %r8,%rbx
    7a79:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)
    7a80:	4c 89 c1             	mov    %r8,%rcx
    7a83:	4c 0f a4 c9 3f       	shld   $0x3f,%r9,%rcx
    7a88:	48 d1 eb             	shr    $1,%rbx
    7a8b:	48 89 ce             	mov    %rcx,%rsi
    7a8e:	48 01 de             	add    %rbx,%rsi
    7a91:	48 83 d6 00          	adc    $0x0,%rsi
    7a95:	48 89 f0             	mov    %rsi,%rax
    7a98:	49 f7 e2             	mul    %r10
    7a9b:	48 c1 ea 02          	shr    $0x2,%rdx
    7a9f:	48 8d 04 92          	lea    (%rdx,%rdx,4),%rax
    7aa3:	48 29 c6             	sub    %rax,%rsi
    7aa6:	48 29 f1             	sub    %rsi,%rcx
    7aa9:	48 83 db 00          	sbb    $0x0,%rbx
    7aad:	48 89 ce             	mov    %rcx,%rsi
    7ab0:	49 0f af f3          	imul   %r11,%rsi
    7ab4:	48 89 c8             	mov    %rcx,%rax
    7ab7:	49 f7 e2             	mul    %r10
    7aba:	48 01 f2             	add    %rsi,%rdx
    7abd:	49 0f af da          	imul   %r10,%rbx
    7ac1:	48 01 d3             	add    %rdx,%rbx
    7ac4:	48 89 c1             	mov    %rax,%rcx
    7ac7:	48 01 c1             	add    %rax,%rcx
    7aca:	48 8d 0c 89          	lea    (%rcx,%rcx,4),%rcx
    7ace:	44 89 ca             	mov    %r9d,%edx
    7ad1:	29 ca                	sub    %ecx,%edx
    7ad3:	80 ca 30             	or     $0x30,%dl
    7ad6:	88 54 3c 20          	mov    %dl,0x20(%rsp,%rdi,1)
    7ada:	48 ff c7             	inc    %rdi
    7add:	49 83 f9 0a          	cmp    $0xa,%r9
    7ae1:	49 83 d8 00          	sbb    $0x0,%r8
    7ae5:	49 89 c1             	mov    %rax,%r9
    7ae8:	49 89 d8             	mov    %rbx,%r8
    7aeb:	73 93                	jae    7a80 <fwp_write+0x2a0>
    7aed:	85 ff                	test   %edi,%edi
    7aef:	0f 8f 86 06 00 00    	jg     817b <fwp_write+0x99b>
    7af5:	e9 ab 00 00 00       	jmp    7ba5 <fwp_write+0x3c5>
    7afa:	4d 8b 06             	mov    (%r14),%r8
    7afd:	4d 8b 4e 08          	mov    0x8(%r14),%r9
    7b01:	4d 85 c9             	test   %r9,%r9
    7b04:	0f 88 93 06 00 00    	js     819d <fwp_write+0x9bd>
    7b0a:	4c 89 c0             	mov    %r8,%rax
    7b0d:	4c 09 c8             	or     %r9,%rax
    7b10:	0f 84 bc 09 00 00    	je     84d2 <fwp_write+0xcf2>
    7b16:	31 ff                	xor    %edi,%edi
    7b18:	49 ba cd cc cc cc cc 	movabs $0xcccccccccccccccd,%r10
    7b1f:	cc cc cc 
    7b22:	49 bb cc cc cc cc cc 	movabs $0xcccccccccccccccc,%r11
    7b29:	cc cc cc 
    7b2c:	4c 89 cb             	mov    %r9,%rbx
    7b2f:	90                   	nop
    7b30:	4c 89 c9             	mov    %r9,%rcx
    7b33:	4c 0f a4 c1 3f       	shld   $0x3f,%r8,%rcx
    7b38:	48 d1 eb             	shr    $1,%rbx
    7b3b:	48 89 ce             	mov    %rcx,%rsi
    7b3e:	48 01 de             	add    %rbx,%rsi
    7b41:	48 83 d6 00          	adc    $0x0,%rsi
    7b45:	48 89 f0             	mov    %rsi,%rax
    7b48:	49 f7 e2             	mul    %r10
    7b4b:	48 c1 ea 02          	shr    $0x2,%rdx
    7b4f:	48 8d 04 92          	lea    (%rdx,%rdx,4),%rax
    7b53:	48 29 c6             	sub    %rax,%rsi
    7b56:	48 29 f1             	sub    %rsi,%rcx
    7b59:	48 83 db 00          	sbb    $0x0,%rbx
    7b5d:	48 89 ce             	mov    %rcx,%rsi
    7b60:	49 0f af f3          	imul   %r11,%rsi
    7b64:	48 89 c8             	mov    %rcx,%rax
    7b67:	49 f7 e2             	mul    %r10
    7b6a:	48 01 f2             	add    %rsi,%rdx
    7b6d:	49 0f af da          	imul   %r10,%rbx
    7b71:	48 01 d3             	add    %rdx,%rbx
    7b74:	48 89 c1             	mov    %rax,%rcx
    7b77:	48 01 c1             	add    %rax,%rcx
    7b7a:	48 8d 0c 89          	lea    (%rcx,%rcx,4),%rcx
    7b7e:	44 89 c2             	mov    %r8d,%edx
    7b81:	29 ca                	sub    %ecx,%edx
    7b83:	80 ca 30             	or     $0x30,%dl
    7b86:	88 54 3c 20          	mov    %dl,0x20(%rsp,%rdi,1)
    7b8a:	48 ff c7             	inc    %rdi
    7b8d:	49 83 f8 0a          	cmp    $0xa,%r8
    7b91:	49 83 d9 00          	sbb    $0x0,%r9
    7b95:	49 89 c0             	mov    %rax,%r8
    7b98:	49 89 d9             	mov    %rbx,%r9
    7b9b:	73 93                	jae    7b30 <fwp_write+0x350>
    7b9d:	85 ff                	test   %edi,%edi
    7b9f:	0f 8f 37 09 00 00    	jg     84dc <fwp_write+0xcfc>
    7ba5:	31 c0                	xor    %eax,%eax
    7ba7:	e9 57 0e 00 00       	jmp    8a03 <fwp_write+0x1223>
    7bac:	c6 44 24 70 5b       	movb   $0x5b,0x70(%rsp)
    7bb1:	48 8d 74 24 70       	lea    0x70(%rsp),%rsi
    7bb6:	ba 01 00 00 00       	mov    $0x1,%edx
    7bbb:	48 89 ef             	mov    %rbp,%rdi
    7bbe:	e8 fd 0f 00 00       	call   8bc0 <buf_put>
    7bc3:	4d 85 f6             	test   %r14,%r14
    7bc6:	0f 84 e6 0c 00 00    	je     88b2 <fwp_write+0x10d2>
    7bcc:	49 8b 57 38          	mov    0x38(%r15),%rdx
    7bd0:	49 8b 76 08          	mov    0x8(%r14),%rsi
    7bd4:	48 89 ef             	mov    %rbp,%rdi
    7bd7:	31 c9                	xor    %ecx,%ecx
    7bd9:	e8 02 fc ff ff       	call   77e0 <fwp_write>
    7bde:	49 8b 5e 10          	mov    0x10(%r14),%rbx
    7be2:	48 85 db             	test   %rbx,%rbx
    7be5:	0f 84 c7 0c 00 00    	je     88b2 <fwp_write+0x10d2>
    7beb:	4c 8d 35 28 7a 00 00 	lea    0x7a28(%rip),%r14        # f61a <fwp_segv.msg+0x3da>
    7bf2:	66 66 66 66 66 2e 0f 	data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    7bf9:	1f 84 00 00 00 00 00 
    7c00:	ba 02 00 00 00       	mov    $0x2,%edx
    7c05:	48 89 ef             	mov    %rbp,%rdi
    7c08:	4c 89 f6             	mov    %r14,%rsi
    7c0b:	e8 b0 0f 00 00       	call   8bc0 <buf_put>
    7c10:	48 8b 73 08          	mov    0x8(%rbx),%rsi
    7c14:	49 8b 57 38          	mov    0x38(%r15),%rdx
    7c18:	48 89 ef             	mov    %rbp,%rdi
    7c1b:	31 c9                	xor    %ecx,%ecx
    7c1d:	e8 be fb ff ff       	call   77e0 <fwp_write>
    7c22:	48 8b 5b 10          	mov    0x10(%rbx),%rbx
    7c26:	48 85 db             	test   %rbx,%rbx
    7c29:	75 d5                	jne    7c00 <fwp_write+0x420>
    7c2b:	e9 82 0c 00 00       	jmp    88b2 <fwp_write+0x10d2>
    7c30:	4d 63 67 48          	movslq 0x48(%r15),%r12
    7c34:	44 89 e3             	mov    %r12d,%ebx
    7c37:	49 8d 54 24 03       	lea    0x3(%r12),%rdx
    7c3c:	48 81 fa 00 40 00 00 	cmp    $0x4000,%rdx
    7c43:	0f 87 57 08 00 00    	ja     84a0 <fwp_write+0xcc0>
    7c49:	49 8d 4c 24 12       	lea    0x12(%r12),%rcx
    7c4e:	48 c1 e9 04          	shr    $0x4,%rcx
    7c52:	48 8d 05 27 a5 00 00 	lea    0xa527(%rip),%rax        # 12180 <fwp_gc>
    7c59:	0f b6 b4 01 e8 0b 00 	movzbl 0xbe8(%rcx,%rax,1),%esi
    7c60:	00 
    7c61:	8b 8c b0 48 0b 00 00 	mov    0xb48(%rax,%rsi,4),%ecx
    7c68:	48 29 0d 11 a5 00 00 	sub    %rcx,0xa511(%rip)        # 12180 <fwp_gc>
    7c6f:	0f 88 2b 08 00 00    	js     84a0 <fwp_write+0xcc0>
    7c75:	48 8d 34 76          	lea    (%rsi,%rsi,2),%rsi
    7c79:	48 8d 3c f0          	lea    (%rax,%rsi,8),%rdi
    7c7d:	48 81 c7 c8 03 00 00 	add    $0x3c8,%rdi
    7c84:	4c 8b 3f             	mov    (%rdi),%r15
    7c87:	4d 85 ff             	test   %r15,%r15
    7c8a:	0f 84 f4 07 00 00    	je     8484 <fwp_write+0xca4>
    7c90:	49 8b 07             	mov    (%r15),%rax
    7c93:	48 f7 d0             	not    %rax
    7c96:	48 89 07             	mov    %rax,(%rdi)
    7c99:	e9 2d 0a 00 00       	jmp    86cb <fwp_write+0xeeb>
    7c9e:	49 83 fe ff          	cmp    $0xffffffffffffffff,%r14
    7ca2:	48 8d 05 4c 79 00 00 	lea    0x794c(%rip),%rax        # f5f5 <fwp_segv.msg+0x3b5>
    7ca9:	48 8d 0d b2 79 00 00 	lea    0x79b2(%rip),%rcx        # f662 <fwp_segv.msg+0x422>
    7cb0:	48 0f 44 c8          	cmove  %rax,%rcx
    7cb4:	49 83 fe 01          	cmp    $0x1,%r14
    7cb8:	4c 8d 35 33 79 00 00 	lea    0x7933(%rip),%r14        # f5f2 <fwp_segv.msg+0x3b2>
    7cbf:	4c 0f 45 f1          	cmovne %rcx,%r14
    7cc3:	4c 89 f7             	mov    %r14,%rdi
    7cc6:	e8 15 a4 ff ff       	call   20e0 <strlen@plt>
    7ccb:	48 89 ef             	mov    %rbp,%rdi
    7cce:	4c 89 f6             	mov    %r14,%rsi
    7cd1:	e9 b9 0a 00 00       	jmp    878f <fwp_write+0xfaf>
    7cd6:	48 8d 35 43 79 00 00 	lea    0x7943(%rip),%rsi        # f620 <fwp_segv.msg+0x3e0>
    7cdd:	ba 06 00 00 00       	mov    $0x6,%edx
    7ce2:	48 89 ef             	mov    %rbp,%rdi
    7ce5:	e8 d6 0e 00 00       	call   8bc0 <buf_put>
    7cea:	49 8b 36             	mov    (%r14),%rsi
    7ced:	48 8d 04 75 00 00 00 	lea    0x0(,%rsi,2),%rax
    7cf4:	00 
    7cf5:	48 85 c0             	test   %rax,%rax
    7cf8:	0f 84 b4 0b 00 00    	je     88b2 <fwp_write+0x10d2>
    7cfe:	49 8b 57 38          	mov    0x38(%r15),%rdx
    7d02:	b8 08 00 00 00       	mov    $0x8,%eax
    7d07:	48 85 d2             	test   %rdx,%rdx
    7d0a:	74 13                	je     7d1f <fwp_write+0x53f>
    7d0c:	8b 0a                	mov    (%rdx),%ecx
    7d0e:	48 83 f9 0a          	cmp    $0xa,%rcx
    7d12:	77 0b                	ja     7d1f <fwp_write+0x53f>
    7d14:	48 8d 05 9d 75 00 00 	lea    0x759d(%rip),%rax        # f2b8 <fwp_segv.msg+0x78>
    7d1b:	48 8b 04 c8          	mov    (%rax,%rcx,8),%rax
    7d1f:	4d 8d 6e 08          	lea    0x8(%r14),%r13
    7d23:	4c 89 e9             	mov    %r13,%rcx
    7d26:	48 85 f6             	test   %rsi,%rsi
    7d29:	79 04                	jns    7d2f <fwp_write+0x54f>
    7d2b:	49 8b 4e 10          	mov    0x10(%r14),%rcx
    7d2f:	48 83 f8 01          	cmp    $0x1,%rax
    7d33:	0f 84 74 0a 00 00    	je     87ad <fwp_write+0xfcd>
    7d39:	48 83 f8 08          	cmp    $0x8,%rax
    7d3d:	0f 84 65 0a 00 00    	je     87a8 <fwp_write+0xfc8>
    7d43:	48 83 f8 02          	cmp    $0x2,%rax
    7d47:	0f 85 6c 0a 00 00    	jne    87b9 <fwp_write+0xfd9>
    7d4d:	83 3a 01             	cmpl   $0x1,(%rdx)
    7d50:	0f b7 01             	movzwl (%rcx),%eax
    7d53:	48 0f bf f0          	movswq %ax,%rsi
    7d57:	e9 65 0a 00 00       	jmp    87c1 <fwp_write+0xfe1>
    7d5c:	48 8d 35 b0 78 00 00 	lea    0x78b0(%rip),%rsi        # f613 <fwp_segv.msg+0x3d3>
    7d63:	ba 06 00 00 00       	mov    $0x6,%edx
    7d68:	48 89 ef             	mov    %rbp,%rdi
    7d6b:	e8 50 0e 00 00       	call   8bc0 <buf_put>
    7d70:	49 83 3e 00          	cmpq   $0x0,(%r14)
    7d74:	0f 84 a3 00 00 00    	je     7e1d <fwp_write+0x63d>
    7d7a:	41 0f b6 4e 08       	movzbl 0x8(%r14),%ecx
    7d7f:	48 8d 15 97 78 00 00 	lea    0x7897(%rip),%rdx        # f61d <fwp_segv.msg+0x3dd>
    7d86:	4c 8d 7c 24 70       	lea    0x70(%rsp),%r15
    7d8b:	be 00 02 00 00       	mov    $0x200,%esi
    7d90:	4c 89 ff             	mov    %r15,%rdi
    7d93:	31 c0                	xor    %eax,%eax
    7d95:	e8 76 a3 ff ff       	call   2110 <snprintf@plt>
    7d9a:	4c 89 ff             	mov    %r15,%rdi
    7d9d:	e8 3e a3 ff ff       	call   20e0 <strlen@plt>
    7da2:	48 89 ef             	mov    %rbp,%rdi
    7da5:	4c 89 fe             	mov    %r15,%rsi
    7da8:	48 89 c2             	mov    %rax,%rdx
    7dab:	e8 10 0e 00 00       	call   8bc0 <buf_put>
    7db0:	49 83 3e 02          	cmpq   $0x2,(%r14)
    7db4:	72 67                	jb     7e1d <fwp_write+0x63d>
    7db6:	bb 09 00 00 00       	mov    $0x9,%ebx
    7dbb:	4c 8d 3d 58 78 00 00 	lea    0x7858(%rip),%r15        # f61a <fwp_segv.msg+0x3da>
    7dc2:	4c 8d 25 54 78 00 00 	lea    0x7854(%rip),%r12        # f61d <fwp_segv.msg+0x3dd>
    7dc9:	4c 8d 6c 24 70       	lea    0x70(%rsp),%r13
    7dce:	66 90                	xchg   %ax,%ax
    7dd0:	ba 02 00 00 00       	mov    $0x2,%edx
    7dd5:	48 89 ef             	mov    %rbp,%rdi
    7dd8:	4c 89 fe             	mov    %r15,%rsi
    7ddb:	e8 e0 0d 00 00       	call   8bc0 <buf_put>
    7de0:	41 0f b6 0c 1e       	movzbl (%r14,%rbx,1),%ecx
    7de5:	be 00 02 00 00       	mov    $0x200,%esi
    7dea:	4c 89 ef             	mov    %r13,%rdi
    7ded:	4c 89 e2             	mov    %r12,%rdx
    7df0:	31 c0                	xor    %eax,%eax
    7df2:	e8 19 a3 ff ff       	call   2110 <snprintf@plt>
    7df7:	4c 89 ef             	mov    %r13,%rdi
    7dfa:	e8 e1 a2 ff ff       	call   20e0 <strlen@plt>
    7dff:	48 89 ef             	mov    %rbp,%rdi
    7e02:	4c 89 ee             	mov    %r13,%rsi
    7e05:	48 89 c2             	mov    %rax,%rdx
    7e08:	e8 b3 0d 00 00       	call   8bc0 <buf_put>
    7e0d:	48 8d 43 01          	lea    0x1(%rbx),%rax
    7e11:	48 83 c3 f9          	add    $0xfffffffffffffff9,%rbx
    7e15:	49 3b 1e             	cmp    (%r14),%rbx
    7e18:	48 89 c3             	mov    %rax,%rbx
    7e1b:	72 b3                	jb     7dd0 <fwp_write+0x5f0>
    7e1d:	c6 44 24 20 5d       	movb   $0x5d,0x20(%rsp)
    7e22:	48 8d 74 24 20       	lea    0x20(%rsp),%rsi
    7e27:	e9 90 0a 00 00       	jmp    88bc <fwp_write+0x10dc>
    7e2c:	66 41 0f 6e ce       	movd   %r14d,%xmm1
    7e31:	0f 2e c9             	ucomiss %xmm1,%xmm1
    7e34:	0f 8a 73 0d 00 00    	jp     8bad <fwp_write+0x13cd>
    7e3a:	0f 28 05 9f 72 00 00 	movaps 0x729f(%rip),%xmm0        # f0e0 <_IO_stdin_used+0xe0>
    7e41:	0f 54 c1             	andps  %xmm1,%xmm0
    7e44:	0f 2e 05 c1 71 00 00 	ucomiss 0x71c1(%rip),%xmm0        # f00c <_IO_stdin_used+0xc>
    7e4b:	0f 82 6e 04 00 00    	jb     82bf <fwp_write+0xadf>
    7e51:	0f 57 c0             	xorps  %xmm0,%xmm0
    7e54:	0f 2e c8             	ucomiss %xmm0,%xmm1
    7e57:	48 8d 05 eb 77 00 00 	lea    0x77eb(%rip),%rax        # f649 <fwp_segv.msg+0x409>
    7e5e:	48 8d 35 e3 77 00 00 	lea    0x77e3(%rip),%rsi        # f648 <fwp_segv.msg+0x408>
    7e65:	48 0f 47 f0          	cmova  %rax,%rsi
    7e69:	48 8d 7c 24 70       	lea    0x70(%rsp),%rdi
    7e6e:	e8 0d a2 ff ff       	call   2080 <strcpy@plt>
    7e73:	e9 90 0b 00 00       	jmp    8a08 <fwp_write+0x1228>
    7e78:	48 8d 35 79 77 00 00 	lea    0x7779(%rip),%rsi        # f5f8 <fwp_segv.msg+0x3b8>
    7e7f:	ba 0a 00 00 00       	mov    $0xa,%edx
    7e84:	48 89 ef             	mov    %rbp,%rdi
    7e87:	e9 06 09 00 00       	jmp    8792 <fwp_write+0xfb2>
    7e8c:	48 8d 35 79 77 00 00 	lea    0x7779(%rip),%rsi        # f60c <fwp_segv.msg+0x3cc>
    7e93:	ba 06 00 00 00       	mov    $0x6,%edx
    7e98:	48 89 ef             	mov    %rbp,%rdi
    7e9b:	e8 20 0d 00 00       	call   8bc0 <buf_put>
    7ea0:	49 83 c6 10          	add    $0x10,%r14
    7ea4:	4c 89 f7             	mov    %r14,%rdi
    7ea7:	e8 34 a2 ff ff       	call   20e0 <strlen@plt>
    7eac:	48 89 ef             	mov    %rbp,%rdi
    7eaf:	4c 89 f6             	mov    %r14,%rsi
    7eb2:	48 89 c2             	mov    %rax,%rdx
    7eb5:	e8 06 0d 00 00       	call   8bc0 <buf_put>
    7eba:	c6 44 24 70 3e       	movb   $0x3e,0x70(%rsp)
    7ebf:	e9 f3 09 00 00       	jmp    88b7 <fwp_write+0x10d7>
    7ec4:	41 8b 06             	mov    (%r14),%eax
    7ec7:	49 8b 4f 18          	mov    0x18(%r15),%rcx
    7ecb:	41 89 c5             	mov    %eax,%r13d
    7ece:	4e 8b 24 e9          	mov    (%rcx,%r13,8),%r12
    7ed2:	4c 89 e7             	mov    %r12,%rdi
    7ed5:	e8 06 a2 ff ff       	call   20e0 <strlen@plt>
    7eda:	48 89 ef             	mov    %rbp,%rdi
    7edd:	4c 89 e6             	mov    %r12,%rsi
    7ee0:	48 89 c2             	mov    %rax,%rdx
    7ee3:	e8 d8 0c 00 00       	call   8bc0 <buf_put>
    7ee8:	49 8b 47 28          	mov    0x28(%r15),%rax
    7eec:	42 83 3c a8 00       	cmpl   $0x0,(%rax,%r13,4)
    7ef1:	0f 8e 2c 0b 00 00    	jle    8a23 <fwp_write+0x1243>
    7ef7:	45 31 e4             	xor    %r12d,%r12d
    7efa:	4c 89 7c 24 10       	mov    %r15,0x10(%rsp)
    7eff:	4c 89 6c 24 68       	mov    %r13,0x68(%rsp)
    7f04:	eb 3c                	jmp    7f42 <fwp_write+0x762>
    7f06:	66 2e 0f 1f 84 00 00 	cs nopw 0x0(%rax,%rax,1)
    7f0d:	00 00 00 
    7f10:	48 8b 2c 24          	mov    (%rsp),%rbp
    7f14:	48 89 ef             	mov    %rbp,%rdi
    7f17:	48 89 de             	mov    %rbx,%rsi
    7f1a:	4c 89 ea             	mov    %r13,%rdx
    7f1d:	31 c9                	xor    %ecx,%ecx
    7f1f:	e8 bc f8 ff ff       	call   77e0 <fwp_write>
    7f24:	49 ff c4             	inc    %r12
    7f27:	4c 8b 7c 24 10       	mov    0x10(%rsp),%r15
    7f2c:	49 8b 47 28          	mov    0x28(%r15),%rax
    7f30:	4c 8b 6c 24 68       	mov    0x68(%rsp),%r13
    7f35:	4a 63 04 a8          	movslq (%rax,%r13,4),%rax
    7f39:	49 39 c4             	cmp    %rax,%r12
    7f3c:	0f 8d e1 0a 00 00    	jge    8a23 <fwp_write+0x1243>
    7f42:	4b 8b 5c e6 08       	mov    0x8(%r14,%r12,8),%rbx
    7f47:	49 8b 47 30          	mov    0x30(%r15),%rax
    7f4b:	4a 8b 04 e8          	mov    (%rax,%r13,8),%rax
    7f4f:	4e 8b 2c e0          	mov    (%rax,%r12,8),%r13
    7f53:	c6 44 24 70 20       	movb   $0x20,0x70(%rsp)
    7f58:	ba 01 00 00 00       	mov    $0x1,%edx
    7f5d:	48 89 ef             	mov    %rbp,%rdi
    7f60:	48 8d 74 24 70       	lea    0x70(%rsp),%rsi
    7f65:	e8 56 0c 00 00       	call   8bc0 <buf_put>
    7f6a:	41 8b 45 00          	mov    0x0(%r13),%eax
    7f6e:	48 83 f8 10          	cmp    $0x10,%rax
    7f72:	77 9c                	ja     7f10 <fwp_write+0x730>
    7f74:	48 8d 0d 0d 72 00 00 	lea    0x720d(%rip),%rcx        # f188 <_IO_stdin_used+0x188>
    7f7b:	48 63 04 81          	movslq (%rcx,%rax,4),%rax
    7f7f:	48 01 c8             	add    %rcx,%rax
    7f82:	ff e0                	jmp    *%rax
    7f84:	48 89 d9             	mov    %rbx,%rcx
    7f87:	48 c1 e9 3f          	shr    $0x3f,%rcx
    7f8b:	85 c9                	test   %ecx,%ecx
    7f8d:	74 81                	je     7f10 <fwp_write+0x730>
    7f8f:	c6 44 24 70 28       	movb   $0x28,0x70(%rsp)
    7f94:	ba 01 00 00 00       	mov    $0x1,%edx
    7f99:	48 8b 2c 24          	mov    (%rsp),%rbp
    7f9d:	48 89 ef             	mov    %rbp,%rdi
    7fa0:	4c 8d 7c 24 70       	lea    0x70(%rsp),%r15
    7fa5:	4c 89 fe             	mov    %r15,%rsi
    7fa8:	e8 13 0c 00 00       	call   8bc0 <buf_put>
    7fad:	48 89 ef             	mov    %rbp,%rdi
    7fb0:	48 89 de             	mov    %rbx,%rsi
    7fb3:	4c 89 ea             	mov    %r13,%rdx
    7fb6:	31 c9                	xor    %ecx,%ecx
    7fb8:	e8 23 f8 ff ff       	call   77e0 <fwp_write>
    7fbd:	c6 44 24 70 29       	movb   $0x29,0x70(%rsp)
    7fc2:	ba 01 00 00 00       	mov    $0x1,%edx
    7fc7:	48 89 ef             	mov    %rbp,%rdi
    7fca:	4c 89 fe             	mov    %r15,%rsi
    7fcd:	e8 ee 0b 00 00       	call   8bc0 <buf_put>
    7fd2:	e9 4d ff ff ff       	jmp    7f24 <fwp_write+0x744>
    7fd7:	31 c9                	xor    %ecx,%ecx
    7fd9:	48 81 fb 00 10 00 00 	cmp    $0x1000,%rbx
    7fe0:	0f 93 c1             	setae  %cl
    7fe3:	eb a6                	jmp    7f8b <fwp_write+0x7ab>
    7fe5:	48 8b 4b 08          	mov    0x8(%rbx),%rcx
    7fe9:	eb 9c                	jmp    7f87 <fwp_write+0x7a7>
    7feb:	89 d9                	mov    %ebx,%ecx
    7fed:	c1 e9 1f             	shr    $0x1f,%ecx
    7ff0:	eb 99                	jmp    7f8b <fwp_write+0x7ab>
    7ff2:	49 8b 7d 08          	mov    0x8(%r13),%rdi
    7ff6:	48 85 ff             	test   %rdi,%rdi
    7ff9:	0f 84 11 ff ff ff    	je     7f10 <fwp_write+0x730>
    7fff:	48 8d 35 2e 76 00 00 	lea    0x762e(%rip),%rsi        # f634 <fwp_segv.msg+0x3f4>
    8006:	e8 75 a1 ff ff       	call   2180 <strcmp@plt>
    800b:	31 c9                	xor    %ecx,%ecx
    800d:	85 c0                	test   %eax,%eax
    800f:	0f 95 c1             	setne  %cl
    8012:	e9 74 ff ff ff       	jmp    7f8b <fwp_write+0x7ab>
    8017:	41 83 7f 10 00       	cmpl   $0x0,0x10(%r15)
    801c:	0f 84 a7 08 00 00    	je     88c9 <fwp_write+0x10e9>
    8022:	4d 8d 6f 10          	lea    0x10(%r15),%r13
    8026:	4d 85 e4             	test   %r12,%r12
    8029:	0f 94 c0             	sete   %al
    802c:	41 83 7f 48 00       	cmpl   $0x0,0x48(%r15)
    8031:	0f 95 c3             	setne  %bl
    8034:	20 c3                	and    %al,%bl
    8036:	84 db                	test   %bl,%bl
    8038:	b8 28 00 00 00       	mov    $0x28,%eax
    803d:	b9 7b 00 00 00       	mov    $0x7b,%ecx
    8042:	0f 45 c8             	cmovne %eax,%ecx
    8045:	88 4c 24 70          	mov    %cl,0x70(%rsp)
    8049:	48 8d 74 24 70       	lea    0x70(%rsp),%rsi
    804e:	ba 01 00 00 00       	mov    $0x1,%edx
    8053:	48 89 ef             	mov    %rbp,%rdi
    8056:	e8 65 0b 00 00       	call   8bc0 <buf_put>
    805b:	41 83 7d 00 00       	cmpl   $0x0,0x0(%r13)
    8060:	0f 8e da 00 00 00    	jle    8140 <fwp_write+0x960>
    8066:	84 db                	test   %bl,%bl
    8068:	75 31                	jne    809b <fwp_write+0x8bb>
    806a:	49 8b 47 18          	mov    0x18(%r15),%rax
    806e:	4c 8b 20             	mov    (%rax),%r12
    8071:	4c 89 e7             	mov    %r12,%rdi
    8074:	e8 67 a0 ff ff       	call   20e0 <strlen@plt>
    8079:	48 89 ef             	mov    %rbp,%rdi
    807c:	4c 89 e6             	mov    %r12,%rsi
    807f:	48 89 c2             	mov    %rax,%rdx
    8082:	e8 39 0b 00 00       	call   8bc0 <buf_put>
    8087:	48 8d 35 b2 75 00 00 	lea    0x75b2(%rip),%rsi        # f640 <fwp_segv.msg+0x400>
    808e:	ba 03 00 00 00       	mov    $0x3,%edx
    8093:	48 89 ef             	mov    %rbp,%rdi
    8096:	e8 25 0b 00 00       	call   8bc0 <buf_put>
    809b:	49 8b 76 08          	mov    0x8(%r14),%rsi
    809f:	49 8b 47 20          	mov    0x20(%r15),%rax
    80a3:	48 8b 10             	mov    (%rax),%rdx
    80a6:	48 89 ef             	mov    %rbp,%rdi
    80a9:	31 c9                	xor    %ecx,%ecx
    80ab:	e8 30 f7 ff ff       	call   77e0 <fwp_write>
    80b0:	41 83 7f 10 02       	cmpl   $0x2,0x10(%r15)
    80b5:	0f 8c 85 00 00 00    	jl     8140 <fwp_write+0x960>
    80bb:	41 bd 01 00 00 00    	mov    $0x1,%r13d
    80c1:	4c 8d 25 52 75 00 00 	lea    0x7552(%rip),%r12        # f61a <fwp_segv.msg+0x3da>
    80c8:	eb 29                	jmp    80f3 <fwp_write+0x913>
    80ca:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)
    80d0:	4b 8b 74 ee 08       	mov    0x8(%r14,%r13,8),%rsi
    80d5:	49 8b 47 20          	mov    0x20(%r15),%rax
    80d9:	4a 8b 14 e8          	mov    (%rax,%r13,8),%rdx
    80dd:	48 89 ef             	mov    %rbp,%rdi
    80e0:	31 c9                	xor    %ecx,%ecx
    80e2:	e8 f9 f6 ff ff       	call   77e0 <fwp_write>
    80e7:	49 ff c5             	inc    %r13
    80ea:	49 63 47 10          	movslq 0x10(%r15),%rax
    80ee:	49 39 c5             	cmp    %rax,%r13
    80f1:	7d 4d                	jge    8140 <fwp_write+0x960>
    80f3:	ba 02 00 00 00       	mov    $0x2,%edx
    80f8:	48 89 ef             	mov    %rbp,%rdi
    80fb:	4c 89 e6             	mov    %r12,%rsi
    80fe:	e8 bd 0a 00 00       	call   8bc0 <buf_put>
    8103:	84 db                	test   %bl,%bl
    8105:	75 c9                	jne    80d0 <fwp_write+0x8f0>
    8107:	49 8b 47 18          	mov    0x18(%r15),%rax
    810b:	4a 8b 2c e8          	mov    (%rax,%r13,8),%rbp
    810f:	48 89 ef             	mov    %rbp,%rdi
    8112:	e8 c9 9f ff ff       	call   20e0 <strlen@plt>
    8117:	48 8b 3c 24          	mov    (%rsp),%rdi
    811b:	48 89 ee             	mov    %rbp,%rsi
    811e:	48 8b 2c 24          	mov    (%rsp),%rbp
    8122:	48 89 c2             	mov    %rax,%rdx
    8125:	e8 96 0a 00 00       	call   8bc0 <buf_put>
    812a:	ba 03 00 00 00       	mov    $0x3,%edx
    812f:	48 89 ef             	mov    %rbp,%rdi
    8132:	48 8d 35 07 75 00 00 	lea    0x7507(%rip),%rsi        # f640 <fwp_segv.msg+0x400>
    8139:	e8 82 0a 00 00       	call   8bc0 <buf_put>
    813e:	eb 90                	jmp    80d0 <fwp_write+0x8f0>
    8140:	84 db                	test   %bl,%bl
    8142:	b8 29 00 00 00       	mov    $0x29,%eax
    8147:	b9 7d 00 00 00       	mov    $0x7d,%ecx
    814c:	0f 45 c8             	cmovne %eax,%ecx
    814f:	88 4c 24 70          	mov    %cl,0x70(%rsp)
    8153:	e9 5f 07 00 00       	jmp    88b7 <fwp_write+0x10d7>
    8158:	48 89 ef             	mov    %rbp,%rdi
    815b:	48 81 c4 78 02 00 00 	add    $0x278,%rsp
    8162:	5b                   	pop    %rbx
    8163:	41 5c                	pop    %r12
    8165:	41 5d                	pop    %r13
    8167:	41 5e                	pop    %r14
    8169:	41 5f                	pop    %r15
    816b:	5d                   	pop    %rbp
    816c:	e9 3f 0b 00 00       	jmp    8cb0 <fwp_escape>
    8171:	c6 44 24 20 30       	movb   $0x30,0x20(%rsp)
    8176:	bf 01 00 00 00       	mov    $0x1,%edi
    817b:	89 f8                	mov    %edi,%eax
    817d:	48 83 f8 08          	cmp    $0x8,%rax
    8181:	73 0a                	jae    818d <fwp_write+0x9ad>
    8183:	31 c9                	xor    %ecx,%ecx
    8185:	48 89 c2             	mov    %rax,%rdx
    8188:	e9 7a 04 00 00       	jmp    8607 <fwp_write+0xe27>
    818d:	83 f8 20             	cmp    $0x20,%eax
    8190:	0f 83 68 03 00 00    	jae    84fe <fwp_write+0xd1e>
    8196:	31 c9                	xor    %ecx,%ecx
    8198:	e9 10 04 00 00       	jmp    85ad <fwp_write+0xdcd>
    819d:	31 ff                	xor    %edi,%edi
    819f:	49 f7 d8             	neg    %r8
    81a2:	41 ba 00 00 00 00    	mov    $0x0,%r10d
    81a8:	4d 19 ca             	sbb    %r9,%r10
    81ab:	c6 44 24 70 2d       	movb   $0x2d,0x70(%rsp)
    81b0:	49 b9 cd cc cc cc cc 	movabs $0xcccccccccccccccd,%r9
    81b7:	cc cc cc 
    81ba:	49 bb cc cc cc cc cc 	movabs $0xcccccccccccccccc,%r11
    81c1:	cc cc cc 
    81c4:	4c 89 d3             	mov    %r10,%rbx
    81c7:	66 0f 1f 84 00 00 00 	nopw   0x0(%rax,%rax,1)
    81ce:	00 00 
    81d0:	4c 89 d1             	mov    %r10,%rcx
    81d3:	4c 0f a4 c1 3f       	shld   $0x3f,%r8,%rcx
    81d8:	48 d1 eb             	shr    $1,%rbx
    81db:	48 89 ce             	mov    %rcx,%rsi
    81de:	48 01 de             	add    %rbx,%rsi
    81e1:	48 83 d6 00          	adc    $0x0,%rsi
    81e5:	48 89 f0             	mov    %rsi,%rax
    81e8:	49 f7 e1             	mul    %r9
    81eb:	48 c1 ea 02          	shr    $0x2,%rdx
    81ef:	48 8d 04 92          	lea    (%rdx,%rdx,4),%rax
    81f3:	48 29 c6             	sub    %rax,%rsi
    81f6:	48 29 f1             	sub    %rsi,%rcx
    81f9:	48 83 db 00          	sbb    $0x0,%rbx
    81fd:	48 89 ce             	mov    %rcx,%rsi
    8200:	49 0f af f3          	imul   %r11,%rsi
    8204:	48 89 c8             	mov    %rcx,%rax
    8207:	49 f7 e1             	mul    %r9
    820a:	48 01 f2             	add    %rsi,%rdx
    820d:	49 0f af d9          	imul   %r9,%rbx
    8211:	48 01 d3             	add    %rdx,%rbx
    8214:	48 89 c1             	mov    %rax,%rcx
    8217:	48 01 c1             	add    %rax,%rcx
    821a:	48 8d 0c 89          	lea    (%rcx,%rcx,4),%rcx
    821e:	44 89 c2             	mov    %r8d,%edx
    8221:	29 ca                	sub    %ecx,%edx
    8223:	80 ca 30             	or     $0x30,%dl
    8226:	88 54 3c 20          	mov    %dl,0x20(%rsp,%rdi,1)
    822a:	48 ff c7             	inc    %rdi
    822d:	49 83 f8 0a          	cmp    $0xa,%r8
    8231:	49 83 da 00          	sbb    $0x0,%r10
    8235:	49 89 c0             	mov    %rax,%r8
    8238:	49 89 da             	mov    %rbx,%r10
    823b:	73 93                	jae    81d0 <fwp_write+0x9f0>
    823d:	85 ff                	test   %edi,%edi
    823f:	0f 8e 98 06 00 00    	jle    88dd <fwp_write+0x10fd>
    8245:	89 f8                	mov    %edi,%eax
    8247:	48 83 f8 08          	cmp    $0x8,%rax
    824b:	0f 83 e4 07 00 00    	jae    8a35 <fwp_write+0x1255>
    8251:	31 c9                	xor    %ecx,%ecx
    8253:	48 89 c2             	mov    %rax,%rdx
    8256:	e9 fc 08 00 00       	jmp    8b57 <fwp_write+0x1377>
    825b:	bd 01 00 00 00       	mov    $0x1,%ebp
    8260:	4c 8d 74 24 70       	lea    0x70(%rsp),%r14
    8265:	0f 29 4c 24 10       	movaps %xmm1,0x10(%rsp)
    826a:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)
    8270:	4c 89 f7             	mov    %r14,%rdi
    8273:	66 0f 28 c1          	movapd %xmm1,%xmm0
    8277:	89 ee                	mov    %ebp,%esi
    8279:	e8 a2 16 00 00       	call   9920 <fwp_format_g>
    827e:	4c 89 f7             	mov    %r14,%rdi
    8281:	31 f6                	xor    %esi,%esi
    8283:	e8 18 9e ff ff       	call   20a0 <strtod@plt>
    8288:	66 0f 28 4c 24 10    	movapd 0x10(%rsp),%xmm1
    828e:	66 0f 2e c1          	ucomisd %xmm1,%xmm0
    8292:	75 06                	jne    829a <fwp_write+0xaba>
    8294:	0f 8b 9e 03 00 00    	jnp    8638 <fwp_write+0xe58>
    829a:	ff c5                	inc    %ebp
    829c:	83 fd 12             	cmp    $0x12,%ebp
    829f:	75 cf                	jne    8270 <fwp_write+0xa90>
    82a1:	4c 8d 74 24 70       	lea    0x70(%rsp),%r14
    82a6:	4c 89 f7             	mov    %r14,%rdi
    82a9:	66 0f 28 c1          	movapd %xmm1,%xmm0
    82ad:	be 11 00 00 00       	mov    $0x11,%esi
    82b2:	e8 69 16 00 00       	call   9920 <fwp_format_g>
    82b7:	4c 89 f7             	mov    %r14,%rdi
    82ba:	e9 7e 03 00 00       	jmp    863d <fwp_write+0xe5d>
    82bf:	0f 57 c0             	xorps  %xmm0,%xmm0
    82c2:	f3 0f 5a c1          	cvtss2sd %xmm1,%xmm0
    82c6:	4c 8d 74 24 70       	lea    0x70(%rsp),%r14
    82cb:	4c 89 f7             	mov    %r14,%rdi
    82ce:	f2 0f 11 44 24 10    	movsd  %xmm0,0x10(%rsp)
    82d4:	be 01 00 00 00       	mov    $0x1,%esi
    82d9:	0f 29 0c 24          	movaps %xmm1,(%rsp)
    82dd:	e8 3e 16 00 00       	call   9920 <fwp_format_g>
    82e2:	4c 89 f7             	mov    %r14,%rdi
    82e5:	31 f6                	xor    %esi,%esi
    82e7:	e8 34 9e ff ff       	call   2120 <strtof@plt>
    82ec:	0f 2e 04 24          	ucomiss (%rsp),%xmm0
    82f0:	75 06                	jne    82f8 <fwp_write+0xb18>
    82f2:	0f 8b 6f 01 00 00    	jnp    8467 <fwp_write+0xc87>
    82f8:	4c 8d 74 24 70       	lea    0x70(%rsp),%r14
    82fd:	4c 89 f7             	mov    %r14,%rdi
    8300:	f2 0f 10 44 24 10    	movsd  0x10(%rsp),%xmm0
    8306:	be 02 00 00 00       	mov    $0x2,%esi
    830b:	e8 10 16 00 00       	call   9920 <fwp_format_g>
    8310:	4c 89 f7             	mov    %r14,%rdi
    8313:	31 f6                	xor    %esi,%esi
    8315:	e8 06 9e ff ff       	call   2120 <strtof@plt>
    831a:	0f 2e 04 24          	ucomiss (%rsp),%xmm0
    831e:	75 06                	jne    8326 <fwp_write+0xb46>
    8320:	0f 8b 41 01 00 00    	jnp    8467 <fwp_write+0xc87>
    8326:	4c 8d 74 24 70       	lea    0x70(%rsp),%r14
    832b:	4c 89 f7             	mov    %r14,%rdi
    832e:	f2 0f 10 44 24 10    	movsd  0x10(%rsp),%xmm0
    8334:	be 03 00 00 00       	mov    $0x3,%esi
    8339:	e8 e2 15 00 00       	call   9920 <fwp_format_g>
    833e:	4c 89 f7             	mov    %r14,%rdi
    8341:	31 f6                	xor    %esi,%esi
    8343:	e8 d8 9d ff ff       	call   2120 <strtof@plt>
    8348:	0f 2e 04 24          	ucomiss (%rsp),%xmm0
    834c:	75 06                	jne    8354 <fwp_write+0xb74>
    834e:	0f 8b 13 01 00 00    	jnp    8467 <fwp_write+0xc87>
    8354:	4c 8d 74 24 70       	lea    0x70(%rsp),%r14
    8359:	4c 89 f7             	mov    %r14,%rdi
    835c:	f2 0f 10 44 24 10    	movsd  0x10(%rsp),%xmm0
    8362:	be 04 00 00 00       	mov    $0x4,%esi
    8367:	e8 b4 15 00 00       	call   9920 <fwp_format_g>
    836c:	4c 89 f7             	mov    %r14,%rdi
    836f:	31 f6                	xor    %esi,%esi
    8371:	e8 aa 9d ff ff       	call   2120 <strtof@plt>
    8376:	0f 2e 04 24          	ucomiss (%rsp),%xmm0
    837a:	75 06                	jne    8382 <fwp_write+0xba2>
    837c:	0f 8b e5 00 00 00    	jnp    8467 <fwp_write+0xc87>
    8382:	4c 8d 74 24 70       	lea    0x70(%rsp),%r14
    8387:	4c 89 f7             	mov    %r14,%rdi
    838a:	f2 0f 10 44 24 10    	movsd  0x10(%rsp),%xmm0
    8390:	be 05 00 00 00       	mov    $0x5,%esi
    8395:	e8 86 15 00 00       	call   9920 <fwp_format_g>
    839a:	4c 89 f7             	mov    %r14,%rdi
    839d:	31 f6                	xor    %esi,%esi
    839f:	e8 7c 9d ff ff       	call   2120 <strtof@plt>
    83a4:	0f 2e 04 24          	ucomiss (%rsp),%xmm0
    83a8:	75 06                	jne    83b0 <fwp_write+0xbd0>
    83aa:	0f 8b b7 00 00 00    	jnp    8467 <fwp_write+0xc87>
    83b0:	4c 8d 74 24 70       	lea    0x70(%rsp),%r14
    83b5:	4c 89 f7             	mov    %r14,%rdi
    83b8:	f2 0f 10 44 24 10    	movsd  0x10(%rsp),%xmm0
    83be:	be 06 00 00 00       	mov    $0x6,%esi
    83c3:	e8 58 15 00 00       	call   9920 <fwp_format_g>
    83c8:	4c 89 f7             	mov    %r14,%rdi
    83cb:	31 f6                	xor    %esi,%esi
    83cd:	e8 4e 9d ff ff       	call   2120 <strtof@plt>
    83d2:	0f 2e 04 24          	ucomiss (%rsp),%xmm0
    83d6:	75 06                	jne    83de <fwp_write+0xbfe>
    83d8:	0f 8b 89 00 00 00    	jnp    8467 <fwp_write+0xc87>
    83de:	4c 8d 74 24 70       	lea    0x70(%rsp),%r14
    83e3:	4c 89 f7             	mov    %r14,%rdi
    83e6:	f2 0f 10 44 24 10    	movsd  0x10(%rsp),%xmm0
    83ec:	be 07 00 00 00       	mov    $0x7,%esi
    83f1:	e8 2a 15 00 00       	call   9920 <fwp_format_g>
    83f6:	4c 89 f7             	mov    %r14,%rdi
    83f9:	31 f6                	xor    %esi,%esi
    83fb:	e8 20 9d ff ff       	call   2120 <strtof@plt>
    8400:	0f 2e 04 24          	ucomiss (%rsp),%xmm0
    8404:	75 02                	jne    8408 <fwp_write+0xc28>
    8406:	7b 5f                	jnp    8467 <fwp_write+0xc87>
    8408:	4c 8d 74 24 70       	lea    0x70(%rsp),%r14
    840d:	4c 89 f7             	mov    %r14,%rdi
    8410:	f2 0f 10 44 24 10    	movsd  0x10(%rsp),%xmm0
    8416:	be 08 00 00 00       	mov    $0x8,%esi
    841b:	e8 00 15 00 00       	call   9920 <fwp_format_g>
    8420:	4c 89 f7             	mov    %r14,%rdi
    8423:	31 f6                	xor    %esi,%esi
    8425:	e8 f6 9c ff ff       	call   2120 <strtof@plt>
    842a:	0f 28 0c 24          	movaps (%rsp),%xmm1
    842e:	0f 2e c1             	ucomiss %xmm1,%xmm0
    8431:	75 02                	jne    8435 <fwp_write+0xc55>
    8433:	7b 32                	jnp    8467 <fwp_write+0xc87>
    8435:	4c 8d 74 24 70       	lea    0x70(%rsp),%r14
    843a:	4c 89 f7             	mov    %r14,%rdi
    843d:	f2 0f 10 44 24 10    	movsd  0x10(%rsp),%xmm0
    8443:	be 09 00 00 00       	mov    $0x9,%esi
    8448:	e8 d3 14 00 00       	call   9920 <fwp_format_g>
    844d:	4c 89 f7             	mov    %r14,%rdi
    8450:	31 f6                	xor    %esi,%esi
    8452:	e8 c9 9c ff ff       	call   2120 <strtof@plt>
    8457:	0f 2e 04 24          	ucomiss (%rsp),%xmm0
    845b:	0f 85 2c 07 00 00    	jne    8b8d <fwp_write+0x13ad>
    8461:	0f 8a 26 07 00 00    	jp     8b8d <fwp_write+0x13ad>
    8467:	48 8d 7c 24 70       	lea    0x70(%rsp),%rdi
    846c:	be 2e 00 00 00       	mov    $0x2e,%esi
    8471:	e8 8a 9c ff ff       	call   2100 <strchr@plt>
    8476:	48 85 c0             	test   %rax,%rax
    8479:	0f 85 89 05 00 00    	jne    8a08 <fwp_write+0x1228>
    847f:	e9 d0 01 00 00       	jmp    8654 <fwp_write+0xe74>
    8484:	4c 8b bc f0 d0 03 00 	mov    0x3d0(%rax,%rsi,8),%r15
    848b:	00 
    848c:	48 8b bc f0 d8 03 00 	mov    0x3d8(%rax,%rsi,8),%rdi
    8493:	00 
    8494:	4c 29 ff             	sub    %r15,%rdi
    8497:	48 39 cf             	cmp    %rcx,%rdi
    849a:	0f 83 1b 02 00 00    	jae    86bb <fwp_write+0xedb>
    84a0:	48 89 d7             	mov    %rdx,%rdi
    84a3:	be 01 00 00 00       	mov    $0x1,%esi
    84a8:	e8 03 e2 ff ff       	call   66b0 <fwp_gc_alloc_slow>
    84ad:	49 89 c7             	mov    %rax,%r15
    84b0:	e9 20 02 00 00       	jmp    86d5 <fwp_write+0xef5>
    84b5:	49 8b 76 08          	mov    0x8(%r14),%rsi
    84b9:	48 89 f2             	mov    %rsi,%rdx
    84bc:	48 c1 fa 3f          	sar    $0x3f,%rdx
    84c0:	4c 8d 74 24 70       	lea    0x70(%rsp),%r14
    84c5:	4c 89 f7             	mov    %r14,%rdi
    84c8:	e8 23 09 00 00       	call   8df0 <fwp_fmt_duration>
    84cd:	e9 3b 05 00 00       	jmp    8a0d <fwp_write+0x122d>
    84d2:	c6 44 24 20 30       	movb   $0x30,0x20(%rsp)
    84d7:	bf 01 00 00 00       	mov    $0x1,%edi
    84dc:	89 f8                	mov    %edi,%eax
    84de:	48 83 f8 08          	cmp    $0x8,%rax
    84e2:	73 0a                	jae    84ee <fwp_write+0xd0e>
    84e4:	31 c9                	xor    %ecx,%ecx
    84e6:	48 89 c2             	mov    %rax,%rdx
    84e9:	e9 f2 04 00 00       	jmp    89e0 <fwp_write+0x1200>
    84ee:	83 f8 20             	cmp    $0x20,%eax
    84f1:	0f 83 f2 03 00 00    	jae    88e9 <fwp_write+0x1109>
    84f7:	31 c9                	xor    %ecx,%ecx
    84f9:	e9 92 04 00 00       	jmp    8990 <fwp_write+0x11b0>
    84fe:	89 fa                	mov    %edi,%edx
    8500:	83 e2 1f             	and    $0x1f,%edx
    8503:	48 89 c1             	mov    %rax,%rcx
    8506:	48 29 d1             	sub    %rdx,%rcx
    8509:	48 8d b4 24 80 00 00 	lea    0x80(%rsp),%rsi
    8510:	00 
    8511:	66 0f ef c0          	pxor   %xmm0,%xmm0
    8515:	49 89 c0             	mov    %rax,%r8
    8518:	0f 1f 84 00 00 00 00 	nopl   0x0(%rax,%rax,1)
    851f:	00 
    8520:	f3 42 0f 6f 0c 04    	movdqu (%rsp,%r8,1),%xmm1
    8526:	f3 42 0f 6f 54 04 10 	movdqu 0x10(%rsp,%r8,1),%xmm2
    852d:	66 0f 6f da          	movdqa %xmm2,%xmm3
    8531:	66 0f 60 d8          	punpcklbw %xmm0,%xmm3
    8535:	66 0f 70 db 4e       	pshufd $0x4e,%xmm3,%xmm3
    853a:	f2 0f 70 db 1b       	pshuflw $0x1b,%xmm3,%xmm3
    853f:	f3 0f 70 db 1b       	pshufhw $0x1b,%xmm3,%xmm3
    8544:	66 0f 68 d0          	punpckhbw %xmm0,%xmm2
    8548:	66 0f 70 d2 4e       	pshufd $0x4e,%xmm2,%xmm2
    854d:	f2 0f 70 d2 1b       	pshuflw $0x1b,%xmm2,%xmm2
    8552:	f3 0f 70 d2 1b       	pshufhw $0x1b,%xmm2,%xmm2
    8557:	66 0f 67 d3          	packuswb %xmm3,%xmm2
    855b:	66 0f 6f d9          	movdqa %xmm1,%xmm3
    855f:	66 0f 60 d8          	punpcklbw %xmm0,%xmm3
    8563:	66 0f 70 db 4e       	pshufd $0x4e,%xmm3,%xmm3
    8568:	f2 0f 70 db 1b       	pshuflw $0x1b,%xmm3,%xmm3
    856d:	f3 0f 70 db 1b       	pshufhw $0x1b,%xmm3,%xmm3
    8572:	66 0f 68 c8          	punpckhbw %xmm0,%xmm1
    8576:	66 0f 70 c9 4e       	pshufd $0x4e,%xmm1,%xmm1
    857b:	f2 0f 70 c9 1b       	pshuflw $0x1b,%xmm1,%xmm1
    8580:	f3 0f 70 c9 1b       	pshufhw $0x1b,%xmm1,%xmm1
    8585:	66 0f 67 cb          	packuswb %xmm3,%xmm1
    8589:	66 0f 7f 56 f0       	movdqa %xmm2,-0x10(%rsi)
    858e:	66 0f 7f 0e          	movdqa %xmm1,(%rsi)
    8592:	49 83 c0 e0          	add    $0xffffffffffffffe0,%r8
    8596:	48 83 c6 20          	add    $0x20,%rsi
    859a:	4c 39 c2             	cmp    %r8,%rdx
    859d:	75 81                	jne    8520 <fwp_write+0xd40>
    859f:	48 85 d2             	test   %rdx,%rdx
    85a2:	0f 84 5b 04 00 00    	je     8a03 <fwp_write+0x1223>
    85a8:	83 fa 08             	cmp    $0x8,%edx
    85ab:	72 5a                	jb     8607 <fwp_write+0xe27>
    85ad:	89 fa                	mov    %edi,%edx
    85af:	83 e2 07             	and    $0x7,%edx
    85b2:	48 89 c6             	mov    %rax,%rsi
    85b5:	48 29 ce             	sub    %rcx,%rsi
    85b8:	48 8d 3c 0c          	lea    (%rsp,%rcx,1),%rdi
    85bc:	48 83 c7 70          	add    $0x70,%rdi
    85c0:	48 89 c1             	mov    %rax,%rcx
    85c3:	48 29 d1             	sub    %rdx,%rcx
    85c6:	66 0f ef c0          	pxor   %xmm0,%xmm0
    85ca:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)
    85d0:	f3 0f 7e 4c 34 18    	movq   0x18(%rsp,%rsi,1),%xmm1
    85d6:	66 0f 60 c8          	punpcklbw %xmm0,%xmm1
    85da:	66 0f 70 c9 4e       	pshufd $0x4e,%xmm1,%xmm1
    85df:	f2 0f 70 c9 1b       	pshuflw $0x1b,%xmm1,%xmm1
    85e4:	f3 0f 70 c9 1b       	pshufhw $0x1b,%xmm1,%xmm1
    85e9:	66 0f 67 c9          	packuswb %xmm1,%xmm1
    85ed:	66 0f d6 0f          	movq   %xmm1,(%rdi)
    85f1:	48 83 c6 f8          	add    $0xfffffffffffffff8,%rsi
    85f5:	48 83 c7 08          	add    $0x8,%rdi
    85f9:	48 39 f2             	cmp    %rsi,%rdx
    85fc:	75 d2                	jne    85d0 <fwp_write+0xdf0>
    85fe:	48 85 d2             	test   %rdx,%rdx
    8601:	0f 84 fc 03 00 00    	je     8a03 <fwp_write+0x1223>
    8607:	48 8d 74 24 20       	lea    0x20(%rsp),%rsi
    860c:	48 01 f2             	add    %rsi,%rdx
    860f:	48 ff ca             	dec    %rdx
    8612:	66 66 66 66 66 2e 0f 	data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    8619:	1f 84 00 00 00 00 00 
    8620:	0f b6 32             	movzbl (%rdx),%esi
    8623:	40 88 74 0c 70       	mov    %sil,0x70(%rsp,%rcx,1)
    8628:	48 ff c1             	inc    %rcx
    862b:	48 ff ca             	dec    %rdx
    862e:	48 39 c8             	cmp    %rcx,%rax
    8631:	75 ed                	jne    8620 <fwp_write+0xe40>
    8633:	e9 cb 03 00 00       	jmp    8a03 <fwp_write+0x1223>
    8638:	48 8d 7c 24 70       	lea    0x70(%rsp),%rdi
    863d:	be 2e 00 00 00       	mov    $0x2e,%esi
    8642:	e8 b9 9a ff ff       	call   2100 <strchr@plt>
    8647:	48 85 c0             	test   %rax,%rax
    864a:	48 8b 2c 24          	mov    (%rsp),%rbp
    864e:	0f 85 b4 03 00 00    	jne    8a08 <fwp_write+0x1228>
    8654:	48 8d 7c 24 70       	lea    0x70(%rsp),%rdi
    8659:	be 65 00 00 00       	mov    $0x65,%esi
    865e:	e8 9d 9a ff ff       	call   2100 <strchr@plt>
    8663:	48 85 c0             	test   %rax,%rax
    8666:	0f 85 9c 03 00 00    	jne    8a08 <fwp_write+0x1228>
    866c:	48 8d 35 d6 6f 00 00 	lea    0x6fd6(%rip),%rsi        # f649 <fwp_segv.msg+0x409>
    8673:	48 8d 7c 24 70       	lea    0x70(%rsp),%rdi
    8678:	e8 63 9c ff ff       	call   22e0 <strstr@plt>
    867d:	48 85 c0             	test   %rax,%rax
    8680:	0f 85 82 03 00 00    	jne    8a08 <fwp_write+0x1228>
    8686:	48 8d 35 b7 6f 00 00 	lea    0x6fb7(%rip),%rsi        # f644 <fwp_segv.msg+0x404>
    868d:	48 8d 7c 24 70       	lea    0x70(%rsp),%rdi
    8692:	e8 49 9c ff ff       	call   22e0 <strstr@plt>
    8697:	48 85 c0             	test   %rax,%rax
    869a:	0f 85 68 03 00 00    	jne    8a08 <fwp_write+0x1228>
    86a0:	48 8d 7c 24 70       	lea    0x70(%rsp),%rdi
    86a5:	e8 36 9a ff ff       	call   20e0 <strlen@plt>
    86aa:	66 c7 44 04 70 2e 30 	movw   $0x302e,0x70(%rsp,%rax,1)
    86b1:	c6 44 04 72 00       	movb   $0x0,0x72(%rsp,%rax,1)
    86b6:	e9 4d 03 00 00       	jmp    8a08 <fwp_write+0x1228>
    86bb:	48 8d 04 f0          	lea    (%rax,%rsi,8),%rax
    86bf:	48 05 d0 03 00 00    	add    $0x3d0,%rax
    86c5:	4c 01 f9             	add    %r15,%rcx
    86c8:	48 89 08             	mov    %rcx,(%rax)
    86cb:	4c 89 ff             	mov    %r15,%rdi
    86ce:	31 f6                	xor    %esi,%esi
    86d0:	e8 5b 9a ff ff       	call   2130 <memset@plt>
    86d5:	66 41 c7 07 30 74    	movw   $0x7430,(%r15)
    86db:	85 db                	test   %ebx,%ebx
    86dd:	0f 8e 98 00 00 00    	jle    877b <fwp_write+0xf9b>
    86e3:	44 89 e1             	mov    %r12d,%ecx
    86e6:	48 f7 d9             	neg    %rcx
    86e9:	4a 8d 34 3b          	lea    (%rbx,%r15,1),%rsi
    86ed:	48 ff c6             	inc    %rsi
    86f0:	31 ff                	xor    %edi,%edi
    86f2:	49 b8 56 55 55 55 55 	movabs $0x5555555555555556,%r8
    86f9:	55 55 55 
    86fc:	eb 2e                	jmp    872c <fwp_write+0xf4c>
    86fe:	66 90                	xchg   %ax,%ax
    8700:	41 b2 30             	mov    $0x30,%r10b
    8703:	44 88 14 3e          	mov    %r10b,(%rsi,%rdi,1)
    8707:	48 85 d2             	test   %rdx,%rdx
    870a:	0f 95 c2             	setne  %dl
    870d:	4d 85 f6             	test   %r14,%r14
    8710:	41 0f 98 c2          	sets   %r10b
    8714:	41 20 d2             	and    %dl,%r10b
    8717:	41 0f b6 d2          	movzbl %r10b,%edx
    871b:	48 29 d0             	sub    %rdx,%rax
    871e:	4c 01 c8             	add    %r9,%rax
    8721:	48 ff cf             	dec    %rdi
    8724:	49 89 c6             	mov    %rax,%r14
    8727:	48 39 f9             	cmp    %rdi,%rcx
    872a:	74 4f                	je     877b <fwp_write+0xf9b>
    872c:	4c 89 f0             	mov    %r14,%rax
    872f:	49 f7 e8             	imul   %r8
    8732:	48 89 d0             	mov    %rdx,%rax
    8735:	48 c1 e8 3f          	shr    $0x3f,%rax
    8739:	48 01 d0             	add    %rdx,%rax
    873c:	4c 8d 0c 40          	lea    (%rax,%rax,2),%r9
    8740:	4c 89 f2             	mov    %r14,%rdx
    8743:	4c 29 ca             	sub    %r9,%rdx
    8746:	49 f7 d9             	neg    %r9
    8749:	4d 01 f1             	add    %r14,%r9
    874c:	49 83 c1 03          	add    $0x3,%r9
    8750:	48 83 fa fd          	cmp    $0xfffffffffffffffd,%rdx
    8754:	4c 0f 42 ca          	cmovb  %rdx,%r9
    8758:	4d 85 c9             	test   %r9,%r9
    875b:	74 a3                	je     8700 <fwp_write+0xf20>
    875d:	49 83 f9 01          	cmp    $0x1,%r9
    8761:	75 0d                	jne    8770 <fwp_write+0xf90>
    8763:	41 b2 2b             	mov    $0x2b,%r10b
    8766:	45 31 c9             	xor    %r9d,%r9d
    8769:	eb 98                	jmp    8703 <fwp_write+0xf23>
    876b:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)
    8770:	41 b2 2d             	mov    $0x2d,%r10b
    8773:	41 b9 01 00 00 00    	mov    $0x1,%r9d
    8779:	eb 88                	jmp    8703 <fwp_write+0xf23>
    877b:	43 c6 44 27 02 00    	movb   $0x0,0x2(%r15,%r12,1)
    8781:	4c 89 ff             	mov    %r15,%rdi
    8784:	e8 57 99 ff ff       	call   20e0 <strlen@plt>
    8789:	48 89 ef             	mov    %rbp,%rdi
    878c:	4c 89 fe             	mov    %r15,%rsi
    878f:	48 89 c2             	mov    %rax,%rdx
    8792:	48 81 c4 78 02 00 00 	add    $0x278,%rsp
    8799:	5b                   	pop    %rbx
    879a:	41 5c                	pop    %r12
    879c:	41 5d                	pop    %r13
    879e:	41 5e                	pop    %r14
    87a0:	41 5f                	pop    %r15
    87a2:	5d                   	pop    %rbp
    87a3:	e9 18 04 00 00       	jmp    8bc0 <buf_put>
    87a8:	48 8b 31             	mov    (%rcx),%rsi
    87ab:	eb 18                	jmp    87c5 <fwp_write+0xfe5>
    87ad:	83 3a 00             	cmpl   $0x0,(%rdx)
    87b0:	0f b6 01             	movzbl (%rcx),%eax
    87b3:	48 0f be f0          	movsbq %al,%rsi
    87b7:	eb 08                	jmp    87c1 <fwp_write+0xfe1>
    87b9:	83 3a 02             	cmpl   $0x2,(%rdx)
    87bc:	8b 01                	mov    (%rcx),%eax
    87be:	48 63 f0             	movslq %eax,%rsi
    87c1:	48 0f 45 f0          	cmovne %rax,%rsi
    87c5:	48 8b 2c 24          	mov    (%rsp),%rbp
    87c9:	48 89 ef             	mov    %rbp,%rdi
    87cc:	31 c9                	xor    %ecx,%ecx
    87ce:	e8 0d f0 ff ff       	call   77e0 <fwp_write>
    87d3:	48 b8 ff ff ff ff ff 	movabs $0x7fffffffffffffff,%rax
    87da:	ff ff 7f 
    87dd:	48 ff c8             	dec    %rax
    87e0:	49 85 06             	test   %rax,(%r14)
    87e3:	0f 84 c9 00 00 00    	je     88b2 <fwp_write+0x10d2>
    87e9:	bb 01 00 00 00       	mov    $0x1,%ebx
    87ee:	4c 8d 25 25 6e 00 00 	lea    0x6e25(%rip),%r12        # f61a <fwp_segv.msg+0x3da>
    87f5:	eb 39                	jmp    8830 <fwp_write+0x1050>
    87f7:	83 3a 01             	cmpl   $0x1,(%rdx)
    87fa:	0f b7 04 31          	movzwl (%rcx,%rsi,1),%eax
    87fe:	48 0f bf f0          	movswq %ax,%rsi
    8802:	48 0f 45 f0          	cmovne %rax,%rsi
    8806:	48 8b 2c 24          	mov    (%rsp),%rbp
    880a:	48 89 ef             	mov    %rbp,%rdi
    880d:	31 c9                	xor    %ecx,%ecx
    880f:	e8 cc ef ff ff       	call   77e0 <fwp_write>
    8814:	48 ff c3             	inc    %rbx
    8817:	49 8b 06             	mov    (%r14),%rax
    881a:	48 b9 ff ff ff ff ff 	movabs $0x7fffffffffffffff,%rcx
    8821:	ff ff 7f 
    8824:	48 21 c8             	and    %rcx,%rax
    8827:	48 39 c3             	cmp    %rax,%rbx
    882a:	0f 83 82 00 00 00    	jae    88b2 <fwp_write+0x10d2>
    8830:	ba 02 00 00 00       	mov    $0x2,%edx
    8835:	48 89 ef             	mov    %rbp,%rdi
    8838:	4c 89 e6             	mov    %r12,%rsi
    883b:	e8 80 03 00 00       	call   8bc0 <buf_put>
    8840:	49 8b 57 38          	mov    0x38(%r15),%rdx
    8844:	b8 08 00 00 00       	mov    $0x8,%eax
    8849:	48 85 d2             	test   %rdx,%rdx
    884c:	74 13                	je     8861 <fwp_write+0x1081>
    884e:	8b 0a                	mov    (%rdx),%ecx
    8850:	48 83 f9 0a          	cmp    $0xa,%rcx
    8854:	77 0b                	ja     8861 <fwp_write+0x1081>
    8856:	48 8d 05 5b 6a 00 00 	lea    0x6a5b(%rip),%rax        # f2b8 <fwp_segv.msg+0x78>
    885d:	48 8b 04 c8          	mov    (%rax,%rcx,8),%rax
    8861:	49 83 3e 00          	cmpq   $0x0,(%r14)
    8865:	4c 89 e9             	mov    %r13,%rcx
    8868:	79 04                	jns    886e <fwp_write+0x108e>
    886a:	49 8b 4e 10          	mov    0x10(%r14),%rcx
    886e:	48 89 c6             	mov    %rax,%rsi
    8871:	48 0f af f3          	imul   %rbx,%rsi
    8875:	48 83 f8 01          	cmp    $0x1,%rax
    8879:	74 19                	je     8894 <fwp_write+0x10b4>
    887b:	48 83 f8 02          	cmp    $0x2,%rax
    887f:	0f 84 72 ff ff ff    	je     87f7 <fwp_write+0x1017>
    8885:	48 83 f8 08          	cmp    $0x8,%rax
    8889:	75 19                	jne    88a4 <fwp_write+0x10c4>
    888b:	48 8b 34 31          	mov    (%rcx,%rsi,1),%rsi
    888f:	e9 72 ff ff ff       	jmp    8806 <fwp_write+0x1026>
    8894:	83 3a 00             	cmpl   $0x0,(%rdx)
    8897:	0f b6 04 31          	movzbl (%rcx,%rsi,1),%eax
    889b:	48 0f be f0          	movsbq %al,%rsi
    889f:	e9 5e ff ff ff       	jmp    8802 <fwp_write+0x1022>
    88a4:	83 3a 02             	cmpl   $0x2,(%rdx)
    88a7:	8b 04 31             	mov    (%rcx,%rsi,1),%eax
    88aa:	48 63 f0             	movslq %eax,%rsi
    88ad:	e9 50 ff ff ff       	jmp    8802 <fwp_write+0x1022>
    88b2:	c6 44 24 70 5d       	movb   $0x5d,0x70(%rsp)
    88b7:	48 8d 74 24 70       	lea    0x70(%rsp),%rsi
    88bc:	ba 01 00 00 00       	mov    $0x1,%edx
    88c1:	48 89 ef             	mov    %rbp,%rdi
    88c4:	e9 55 01 00 00       	jmp    8a1e <fwp_write+0x123e>
    88c9:	48 8d 35 6d 6d 00 00 	lea    0x6d6d(%rip),%rsi        # f63d <fwp_segv.msg+0x3fd>
    88d0:	ba 02 00 00 00       	mov    $0x2,%edx
    88d5:	48 89 ef             	mov    %rbp,%rdi
    88d8:	e9 b5 fe ff ff       	jmp    8792 <fwp_write+0xfb2>
    88dd:	31 c0                	xor    %eax,%eax
    88df:	c6 44 04 71 00       	movb   $0x0,0x71(%rsp,%rax,1)
    88e4:	e9 1f 01 00 00       	jmp    8a08 <fwp_write+0x1228>
    88e9:	89 fa                	mov    %edi,%edx
    88eb:	83 e2 1f             	and    $0x1f,%edx
    88ee:	48 89 c1             	mov    %rax,%rcx
    88f1:	48 29 d1             	sub    %rdx,%rcx
    88f4:	48 8d b4 24 80 00 00 	lea    0x80(%rsp),%rsi
    88fb:	00 
    88fc:	66 0f ef c0          	pxor   %xmm0,%xmm0
    8900:	49 89 c0             	mov    %rax,%r8
    8903:	f3 42 0f 6f 0c 04    	movdqu (%rsp,%r8,1),%xmm1
    8909:	f3 42 0f 6f 54 04 10 	movdqu 0x10(%rsp,%r8,1),%xmm2
    8910:	66 0f 6f da          	movdqa %xmm2,%xmm3
    8914:	66 0f 60 d8          	punpcklbw %xmm0,%xmm3
    8918:	66 0f 70 db 4e       	pshufd $0x4e,%xmm3,%xmm3
    891d:	f2 0f 70 db 1b       	pshuflw $0x1b,%xmm3,%xmm3
    8922:	f3 0f 70 db 1b       	pshufhw $0x1b,%xmm3,%xmm3
    8927:	66 0f 68 d0          	punpckhbw %xmm0,%xmm2
    892b:	66 0f 70 d2 4e       	pshufd $0x4e,%xmm2,%xmm2
    8930:	f2 0f 70 d2 1b       	pshuflw $0x1b,%xmm2,%xmm2
    8935:	f3 0f 70 d2 1b       	pshufhw $0x1b,%xmm2,%xmm2
    893a:	66 0f 67 d3          	packuswb %xmm3,%xmm2
    893e:	66 0f 6f d9          	movdqa %xmm1,%xmm3
    8942:	66 0f 60 d8          	punpcklbw %xmm0,%xmm3
    8946:	66 0f 70 db 4e       	pshufd $0x4e,%xmm3,%xmm3
    894b:	f2 0f 70 db 1b       	pshuflw $0x1b,%xmm3,%xmm3
    8950:	f3 0f 70 db 1b       	pshufhw $0x1b,%xmm3,%xmm3
    8955:	66 0f 68 c8          	punpckhbw %xmm0,%xmm1
    8959:	66 0f 70 c9 4e       	pshufd $0x4e,%xmm1,%xmm1
    895e:	f2 0f 70 c9 1b       	pshuflw $0x1b,%xmm1,%xmm1
    8963:	f3 0f 70 c9 1b       	pshufhw $0x1b,%xmm1,%xmm1
    8968:	66 0f 67 cb          	packuswb %xmm3,%xmm1
    896c:	66 0f 7f 56 f0       	movdqa %xmm2,-0x10(%rsi)
    8971:	66 0f 7f 0e          	movdqa %xmm1,(%rsi)
    8975:	49 83 c0 e0          	add    $0xffffffffffffffe0,%r8
    8979:	48 83 c6 20          	add    $0x20,%rsi
    897d:	4c 39 c2             	cmp    %r8,%rdx
    8980:	75 81                	jne    8903 <fwp_write+0x1123>
    8982:	48 85 d2             	test   %rdx,%rdx
    8985:	0f 84 78 00 00 00    	je     8a03 <fwp_write+0x1223>
    898b:	83 fa 08             	cmp    $0x8,%edx
    898e:	72 50                	jb     89e0 <fwp_write+0x1200>
    8990:	89 fa                	mov    %edi,%edx
    8992:	83 e2 07             	and    $0x7,%edx
    8995:	48 89 c6             	mov    %rax,%rsi
    8998:	48 29 ce             	sub    %rcx,%rsi
    899b:	48 8d 3c 0c          	lea    (%rsp,%rcx,1),%rdi
    899f:	48 83 c7 70          	add    $0x70,%rdi
    89a3:	48 89 c1             	mov    %rax,%rcx
    89a6:	48 29 d1             	sub    %rdx,%rcx
    89a9:	66 0f ef c0          	pxor   %xmm0,%xmm0
    89ad:	f3 0f 7e 4c 34 18    	movq   0x18(%rsp,%rsi,1),%xmm1
    89b3:	66 0f 60 c8          	punpcklbw %xmm0,%xmm1
    89b7:	66 0f 70 c9 4e       	pshufd $0x4e,%xmm1,%xmm1
    89bc:	f2 0f 70 c9 1b       	pshuflw $0x1b,%xmm1,%xmm1
    89c1:	f3 0f 70 c9 1b       	pshufhw $0x1b,%xmm1,%xmm1
    89c6:	66 0f 67 c9          	packuswb %xmm1,%xmm1
    89ca:	66 0f d6 0f          	movq   %xmm1,(%rdi)
    89ce:	48 83 c6 f8          	add    $0xfffffffffffffff8,%rsi
    89d2:	48 83 c7 08          	add    $0x8,%rdi
    89d6:	48 39 f2             	cmp    %rsi,%rdx
    89d9:	75 d2                	jne    89ad <fwp_write+0x11cd>
    89db:	48 85 d2             	test   %rdx,%rdx
    89de:	74 23                	je     8a03 <fwp_write+0x1223>
    89e0:	48 8d 74 24 20       	lea    0x20(%rsp),%rsi
    89e5:	48 01 f2             	add    %rsi,%rdx
    89e8:	48 ff ca             	dec    %rdx
    89eb:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)
    89f0:	0f b6 32             	movzbl (%rdx),%esi
    89f3:	40 88 74 0c 70       	mov    %sil,0x70(%rsp,%rcx,1)
    89f8:	48 ff c1             	inc    %rcx
    89fb:	48 ff ca             	dec    %rdx
    89fe:	48 39 c8             	cmp    %rcx,%rax
    8a01:	75 ed                	jne    89f0 <fwp_write+0x1210>
    8a03:	c6 44 04 70 00       	movb   $0x0,0x70(%rsp,%rax,1)
    8a08:	4c 8d 74 24 70       	lea    0x70(%rsp),%r14
    8a0d:	4c 89 f7             	mov    %r14,%rdi
    8a10:	e8 cb 96 ff ff       	call   20e0 <strlen@plt>
    8a15:	48 89 ef             	mov    %rbp,%rdi
    8a18:	4c 89 f6             	mov    %r14,%rsi
    8a1b:	48 89 c2             	mov    %rax,%rdx
    8a1e:	e8 9d 01 00 00       	call   8bc0 <buf_put>
    8a23:	48 81 c4 78 02 00 00 	add    $0x278,%rsp
    8a2a:	5b                   	pop    %rbx
    8a2b:	41 5c                	pop    %r12
    8a2d:	41 5d                	pop    %r13
    8a2f:	41 5e                	pop    %r14
    8a31:	41 5f                	pop    %r15
    8a33:	5d                   	pop    %rbp
    8a34:	c3                   	ret
    8a35:	83 f8 20             	cmp    $0x20,%eax
    8a38:	73 07                	jae    8a41 <fwp_write+0x1261>
    8a3a:	31 c9                	xor    %ecx,%ecx
    8a3c:	e9 b6 00 00 00       	jmp    8af7 <fwp_write+0x1317>
    8a41:	89 fe                	mov    %edi,%esi
    8a43:	89 fa                	mov    %edi,%edx
    8a45:	83 e2 1f             	and    $0x1f,%edx
    8a48:	48 89 c1             	mov    %rax,%rcx
    8a4b:	48 29 d1             	sub    %rdx,%rcx
    8a4e:	4c 8d 04 34          	lea    (%rsp,%rsi,1),%r8
    8a52:	49 83 c0 10          	add    $0x10,%r8
    8a56:	48 29 d6             	sub    %rdx,%rsi
    8a59:	45 31 c9             	xor    %r9d,%r9d
    8a5c:	66 0f ef c0          	pxor   %xmm0,%xmm0
    8a60:	f3 41 0f 6f 48 f0    	movdqu -0x10(%r8),%xmm1
    8a66:	f3 41 0f 6f 10       	movdqu (%r8),%xmm2
    8a6b:	66 0f 6f da          	movdqa %xmm2,%xmm3
    8a6f:	66 0f 60 d8          	punpcklbw %xmm0,%xmm3
    8a73:	66 0f 70 db 4e       	pshufd $0x4e,%xmm3,%xmm3
    8a78:	f2 0f 70 db 1b       	pshuflw $0x1b,%xmm3,%xmm3
    8a7d:	f3 0f 70 db 1b       	pshufhw $0x1b,%xmm3,%xmm3
    8a82:	66 0f 68 d0          	punpckhbw %xmm0,%xmm2
    8a86:	66 0f 70 d2 4e       	pshufd $0x4e,%xmm2,%xmm2
    8a8b:	f2 0f 70 d2 1b       	pshuflw $0x1b,%xmm2,%xmm2
    8a90:	f3 0f 70 d2 1b       	pshufhw $0x1b,%xmm2,%xmm2
    8a95:	66 0f 67 d3          	packuswb %xmm3,%xmm2
    8a99:	66 0f 6f d9          	movdqa %xmm1,%xmm3
    8a9d:	66 0f 60 d8          	punpcklbw %xmm0,%xmm3
    8aa1:	66 0f 70 db 4e       	pshufd $0x4e,%xmm3,%xmm3
    8aa6:	f2 0f 70 db 1b       	pshuflw $0x1b,%xmm3,%xmm3
    8aab:	f3 0f 70 db 1b       	pshufhw $0x1b,%xmm3,%xmm3
    8ab0:	66 0f 68 c8          	punpckhbw %xmm0,%xmm1
    8ab4:	66 0f 70 c9 4e       	pshufd $0x4e,%xmm1,%xmm1
    8ab9:	f2 0f 70 c9 1b       	pshuflw $0x1b,%xmm1,%xmm1
    8abe:	f3 0f 70 c9 1b       	pshufhw $0x1b,%xmm1,%xmm1
    8ac3:	66 0f 67 cb          	packuswb %xmm3,%xmm1
    8ac7:	f3 42 0f 7f 54 0c 71 	movdqu %xmm2,0x71(%rsp,%r9,1)
    8ace:	f3 42 0f 7f 8c 0c 81 	movdqu %xmm1,0x81(%rsp,%r9,1)
    8ad5:	00 00 00 
    8ad8:	49 83 c1 20          	add    $0x20,%r9
    8adc:	49 83 c0 e0          	add    $0xffffffffffffffe0,%r8
    8ae0:	4c 39 ce             	cmp    %r9,%rsi
    8ae3:	0f 85 77 ff ff ff    	jne    8a60 <fwp_write+0x1280>
    8ae9:	48 85 d2             	test   %rdx,%rdx
    8aec:	0f 84 91 00 00 00    	je     8b83 <fwp_write+0x13a3>
    8af2:	83 fa 08             	cmp    $0x8,%edx
    8af5:	72 60                	jb     8b57 <fwp_write+0x1377>
    8af7:	48 89 ce             	mov    %rcx,%rsi
    8afa:	41 89 f8             	mov    %edi,%r8d
    8afd:	89 fa                	mov    %edi,%edx
    8aff:	83 e2 07             	and    $0x7,%edx
    8b02:	48 89 c1             	mov    %rax,%rcx
    8b05:	48 29 d1             	sub    %rdx,%rcx
    8b08:	49 89 f1             	mov    %rsi,%r9
    8b0b:	49 f7 d9             	neg    %r9
    8b0e:	49 01 e1             	add    %rsp,%r9
    8b11:	49 83 c1 20          	add    $0x20,%r9
    8b15:	4d 01 c1             	add    %r8,%r9
    8b18:	49 83 c1 f8          	add    $0xfffffffffffffff8,%r9
    8b1c:	49 29 d0             	sub    %rdx,%r8
    8b1f:	66 0f ef c0          	pxor   %xmm0,%xmm0
    8b23:	f3 41 0f 7e 09       	movq   (%r9),%xmm1
    8b28:	66 0f 60 c8          	punpcklbw %xmm0,%xmm1
    8b2c:	66 0f 70 c9 4e       	pshufd $0x4e,%xmm1,%xmm1
    8b31:	f2 0f 70 c9 1b       	pshuflw $0x1b,%xmm1,%xmm1
    8b36:	f3 0f 70 c9 1b       	pshufhw $0x1b,%xmm1,%xmm1
    8b3b:	66 0f 67 c9          	packuswb %xmm1,%xmm1
    8b3f:	66 0f d6 4c 34 71    	movq   %xmm1,0x71(%rsp,%rsi,1)
    8b45:	48 83 c6 08          	add    $0x8,%rsi
    8b49:	49 83 c1 f8          	add    $0xfffffffffffffff8,%r9
    8b4d:	49 39 f0             	cmp    %rsi,%r8
    8b50:	75 d1                	jne    8b23 <fwp_write+0x1343>
    8b52:	48 85 d2             	test   %rdx,%rdx
    8b55:	74 2c                	je     8b83 <fwp_write+0x13a3>
    8b57:	48 8d 74 24 20       	lea    0x20(%rsp),%rsi
    8b5c:	48 01 f2             	add    %rsi,%rdx
    8b5f:	48 ff ca             	dec    %rdx
    8b62:	89 fe                	mov    %edi,%esi
    8b64:	66 66 66 2e 0f 1f 84 	data16 data16 cs nopw 0x0(%rax,%rax,1)
    8b6b:	00 00 00 00 00 
    8b70:	0f b6 3a             	movzbl (%rdx),%edi
    8b73:	40 88 7c 0c 71       	mov    %dil,0x71(%rsp,%rcx,1)
    8b78:	48 ff c1             	inc    %rcx
    8b7b:	48 ff ca             	dec    %rdx
    8b7e:	48 39 ce             	cmp    %rcx,%rsi
    8b81:	75 ed                	jne    8b70 <fwp_write+0x1390>
    8b83:	c6 44 04 71 00       	movb   $0x0,0x71(%rsp,%rax,1)
    8b88:	e9 7b fe ff ff       	jmp    8a08 <fwp_write+0x1228>
    8b8d:	4c 8d 74 24 70       	lea    0x70(%rsp),%r14
    8b92:	4c 89 f7             	mov    %r14,%rdi
    8b95:	f2 0f 10 44 24 10    	movsd  0x10(%rsp),%xmm0
    8b9b:	be 09 00 00 00       	mov    $0x9,%esi
    8ba0:	e8 7b 0d 00 00       	call   9920 <fwp_format_g>
    8ba5:	4c 89 f7             	mov    %r14,%rdi
    8ba8:	e9 bf f8 ff ff       	jmp    846c <fwp_write+0xc8c>
    8bad:	c7 44 24 70 4e 61 4e 	movl   $0x4e614e,0x70(%rsp)
    8bb4:	00 
    8bb5:	e9 4e fe ff ff       	jmp    8a08 <fwp_write+0x1228>
    8bba:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)

0000000000008bc0 <buf_put>:
    8bc0:	41 57                	push   %r15
    8bc2:	41 56                	push   %r14
    8bc4:	41 54                	push   %r12
    8bc6:	53                   	push   %rbx
    8bc7:	50                   	push   %rax
    8bc8:	49 89 fe             	mov    %rdi,%r14
    8bcb:	48 8b 7f 08          	mov    0x8(%rdi),%rdi
    8bcf:	48 83 ff ff          	cmp    $0xffffffffffffffff,%rdi
    8bd3:	0f 84 a2 00 00 00    	je     8c7b <buf_put+0xbb>
    8bd9:	48 89 d3             	mov    %rdx,%rbx
    8bdc:	48 c7 c0 fe ff ff ff 	mov    $0xfffffffffffffffe,%rax
    8be3:	48 29 f8             	sub    %rdi,%rax
    8be6:	48 39 d0             	cmp    %rdx,%rax
    8be9:	0f 82 8c 00 00 00    	jb     8c7b <buf_put+0xbb>
    8bef:	48 8d 04 3b          	lea    (%rbx,%rdi,1),%rax
    8bf3:	48 ff c0             	inc    %rax
    8bf6:	49 8b 4e 10          	mov    0x10(%r14),%rcx
    8bfa:	48 39 c8             	cmp    %rcx,%rax
    8bfd:	76 30                	jbe    8c2f <buf_put+0x6f>
    8bff:	48 85 c9             	test   %rcx,%rcx
    8c02:	41 bf 40 00 00 00    	mov    $0x40,%r15d
    8c08:	4c 0f 45 f9          	cmovne %rcx,%r15
    8c0c:	49 89 f4             	mov    %rsi,%r12
    8c0f:	49 39 c7             	cmp    %rax,%r15
    8c12:	73 23                	jae    8c37 <buf_put+0x77>
    8c14:	66 66 66 2e 0f 1f 84 	data16 data16 cs nopw 0x0(%rax,%rax,1)
    8c1b:	00 00 00 00 00 
    8c20:	4d 85 ff             	test   %r15,%r15
    8c23:	78 0f                	js     8c34 <buf_put+0x74>
    8c25:	4d 01 ff             	add    %r15,%r15
    8c28:	49 39 c7             	cmp    %rax,%r15
    8c2b:	72 f3                	jb     8c20 <buf_put+0x60>
    8c2d:	eb 08                	jmp    8c37 <buf_put+0x77>
    8c2f:	49 8b 06             	mov    (%r14),%rax
    8c32:	eb 21                	jmp    8c55 <buf_put+0x95>
    8c34:	49 89 c7             	mov    %rax,%r15
    8c37:	49 8b 3e             	mov    (%r14),%rdi
    8c3a:	4c 89 fe             	mov    %r15,%rsi
    8c3d:	e8 ce 95 ff ff       	call   2210 <realloc@plt>
    8c42:	48 85 c0             	test   %rax,%rax
    8c45:	74 34                	je     8c7b <buf_put+0xbb>
    8c47:	49 89 06             	mov    %rax,(%r14)
    8c4a:	4d 89 7e 10          	mov    %r15,0x10(%r14)
    8c4e:	49 8b 7e 08          	mov    0x8(%r14),%rdi
    8c52:	4c 89 e6             	mov    %r12,%rsi
    8c55:	48 01 c7             	add    %rax,%rdi
    8c58:	48 89 da             	mov    %rbx,%rdx
    8c5b:	e8 80 95 ff ff       	call   21e0 <memcpy@plt>
    8c60:	49 03 5e 08          	add    0x8(%r14),%rbx
    8c64:	49 89 5e 08          	mov    %rbx,0x8(%r14)
    8c68:	49 8b 06             	mov    (%r14),%rax
    8c6b:	c6 04 18 00          	movb   $0x0,(%rax,%rbx,1)
    8c6f:	48 83 c4 08          	add    $0x8,%rsp
    8c73:	5b                   	pop    %rbx
    8c74:	41 5c                	pop    %r12
    8c76:	41 5e                	pop    %r14
    8c78:	41 5f                	pop    %r15
    8c7a:	c3                   	ret
    8c7b:	48 8b 05 5e 93 00 00 	mov    0x935e(%rip),%rax        # 11fe0 <stderr@GLIBC_2.2.5>
    8c82:	48 8b 08             	mov    (%rax),%rcx
    8c85:	48 8d 3d ad 68 00 00 	lea    0x68ad(%rip),%rdi        # f539 <fwp_segv.msg+0x2f9>
    8c8c:	be 13 00 00 00       	mov    $0x13,%esi
    8c91:	ba 01 00 00 00       	mov    $0x1,%edx
    8c96:	e8 05 96 ff ff       	call   22a0 <fwrite@plt>
    8c9b:	bf 66 00 00 00       	mov    $0x66,%edi
    8ca0:	e8 eb 95 ff ff       	call   2290 <exit@plt>
    8ca5:	66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
    8cac:	00 00 00 00 

0000000000008cb0 <fwp_escape>:
    8cb0:	55                   	push   %rbp
    8cb1:	41 57                	push   %r15
    8cb3:	41 56                	push   %r14
    8cb5:	41 55                	push   %r13
    8cb7:	41 54                	push   %r12
    8cb9:	53                   	push   %rbx
    8cba:	48 83 ec 18          	sub    $0x18,%rsp
    8cbe:	49 89 d6             	mov    %rdx,%r14
    8cc1:	49 89 f7             	mov    %rsi,%r15
    8cc4:	48 89 fb             	mov    %rdi,%rbx
    8cc7:	c6 04 24 22          	movb   $0x22,(%rsp)
    8ccb:	48 89 e6             	mov    %rsp,%rsi
    8cce:	ba 01 00 00 00       	mov    $0x1,%edx
    8cd3:	e8 e8 fe ff ff       	call   8bc0 <buf_put>
    8cd8:	4d 85 f6             	test   %r14,%r14
    8cdb:	0f 84 de 00 00 00    	je     8dbf <fwp_escape+0x10f>
    8ce1:	48 89 e5             	mov    %rsp,%rbp
    8ce4:	4c 8d 2d e1 64 00 00 	lea    0x64e1(%rip),%r13        # f1cc <_IO_stdin_used+0x1cc>
    8ceb:	45 31 e4             	xor    %r12d,%r12d
    8cee:	eb 21                	jmp    8d11 <fwp_escape+0x61>
    8cf0:	ba 02 00 00 00       	mov    $0x2,%edx
    8cf5:	48 89 df             	mov    %rbx,%rdi
    8cf8:	48 8d 35 71 69 00 00 	lea    0x6971(%rip),%rsi        # f670 <fwp_segv.msg+0x430>
    8cff:	90                   	nop
    8d00:	e8 bb fe ff ff       	call   8bc0 <buf_put>
    8d05:	49 ff c4             	inc    %r12
    8d08:	4d 39 e6             	cmp    %r12,%r14
    8d0b:	0f 84 ae 00 00 00    	je     8dbf <fwp_escape+0x10f>
    8d11:	43 0f b6 04 27       	movzbl (%r15,%r12,1),%eax
    8d16:	0f b6 c8             	movzbl %al,%ecx
    8d19:	8d 51 f7             	lea    -0x9(%rcx),%edx
    8d1c:	83 fa 19             	cmp    $0x19,%edx
    8d1f:	77 1f                	ja     8d40 <fwp_escape+0x90>
    8d21:	49 63 54 95 00       	movslq 0x0(%r13,%rdx,4),%rdx
    8d26:	4c 01 ea             	add    %r13,%rdx
    8d29:	ff e2                	jmp    *%rdx
    8d2b:	ba 02 00 00 00       	mov    $0x2,%edx
    8d30:	48 89 df             	mov    %rbx,%rdi
    8d33:	48 8d 35 33 69 00 00 	lea    0x6933(%rip),%rsi        # f66d <fwp_segv.msg+0x42d>
    8d3a:	eb c4                	jmp    8d00 <fwp_escape+0x50>
    8d3c:	0f 1f 40 00          	nopl   0x0(%rax)
    8d40:	83 f9 5c             	cmp    $0x5c,%ecx
    8d43:	75 11                	jne    8d56 <fwp_escape+0xa6>
    8d45:	ba 02 00 00 00       	mov    $0x2,%edx
    8d4a:	48 89 df             	mov    %rbx,%rdi
    8d4d:	48 8d 35 13 69 00 00 	lea    0x6913(%rip),%rsi        # f667 <fwp_segv.msg+0x427>
    8d54:	eb aa                	jmp    8d00 <fwp_escape+0x50>
    8d56:	3c 20                	cmp    $0x20,%al
    8d58:	72 39                	jb     8d93 <fwp_escape+0xe3>
    8d5a:	3c 7f                	cmp    $0x7f,%al
    8d5c:	74 35                	je     8d93 <fwp_escape+0xe3>
    8d5e:	88 04 24             	mov    %al,(%rsp)
    8d61:	ba 01 00 00 00       	mov    $0x1,%edx
    8d66:	48 89 df             	mov    %rbx,%rdi
    8d69:	48 89 ee             	mov    %rbp,%rsi
    8d6c:	eb 92                	jmp    8d00 <fwp_escape+0x50>
    8d6e:	ba 02 00 00 00       	mov    $0x2,%edx
    8d73:	48 89 df             	mov    %rbx,%rdi
    8d76:	48 8d 35 e7 68 00 00 	lea    0x68e7(%rip),%rsi        # f664 <fwp_segv.msg+0x424>
    8d7d:	eb 81                	jmp    8d00 <fwp_escape+0x50>
    8d7f:	ba 02 00 00 00       	mov    $0x2,%edx
    8d84:	48 89 df             	mov    %rbx,%rdi
    8d87:	48 8d 35 dc 68 00 00 	lea    0x68dc(%rip),%rsi        # f66a <fwp_segv.msg+0x42a>
    8d8e:	e9 6d ff ff ff       	jmp    8d00 <fwp_escape+0x50>
    8d93:	be 10 00 00 00       	mov    $0x10,%esi
    8d98:	48 89 ef             	mov    %rbp,%rdi
    8d9b:	48 8d 15 d1 68 00 00 	lea    0x68d1(%rip),%rdx        # f673 <fwp_segv.msg+0x433>
    8da2:	31 c0                	xor    %eax,%eax
    8da4:	e8 67 93 ff ff       	call   2110 <snprintf@plt>
    8da9:	48 89 ef             	mov    %rbp,%rdi
    8dac:	e8 2f 93 ff ff       	call   20e0 <strlen@plt>
    8db1:	48 89 df             	mov    %rbx,%rdi
    8db4:	48 89 ee             	mov    %rbp,%rsi
    8db7:	48 89 c2             	mov    %rax,%rdx
    8dba:	e9 41 ff ff ff       	jmp    8d00 <fwp_escape+0x50>
    8dbf:	c6 04 24 22          	movb   $0x22,(%rsp)
    8dc3:	48 89 e6             	mov    %rsp,%rsi
    8dc6:	ba 01 00 00 00       	mov    $0x1,%edx
    8dcb:	48 89 df             	mov    %rbx,%rdi
    8dce:	e8 ed fd ff ff       	call   8bc0 <buf_put>
    8dd3:	48 83 c4 18          	add    $0x18,%rsp
    8dd7:	5b                   	pop    %rbx
    8dd8:	41 5c                	pop    %r12
    8dda:	41 5d                	pop    %r13
    8ddc:	41 5e                	pop    %r14
    8dde:	41 5f                	pop    %r15
    8de0:	5d                   	pop    %rbp
    8de1:	c3                   	ret
    8de2:	66 66 66 66 66 2e 0f 	data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    8de9:	1f 84 00 00 00 00 00 

0000000000008df0 <fwp_fmt_duration>:
    8df0:	41 57                	push   %r15
    8df2:	41 56                	push   %r14
    8df4:	41 54                	push   %r12
    8df6:	53                   	push   %rbx
    8df7:	48 81 ec 88 00 00 00 	sub    $0x88,%rsp
    8dfe:	48 89 f0             	mov    %rsi,%rax
    8e01:	48 09 d0             	or     %rdx,%rax
    8e04:	0f 84 bf 02 00 00    	je     90c9 <fwp_fmt_duration+0x2d9>
    8e0a:	49 89 d0             	mov    %rdx,%r8
    8e0d:	48 b9 1d 3f c2 25 d6 	movabs $0xd2fe1d625c23f1d,%rcx
    8e14:	e1 2f 0d 
    8e17:	48 0f af ce          	imul   %rsi,%rcx
    8e1b:	49 b9 0d b1 f3 e4 99 	movabs $0x1c52799e4f3b10d,%r9
    8e22:	27 c5 01 
    8e25:	48 89 f0             	mov    %rsi,%rax
    8e28:	49 f7 e1             	mul    %r9
    8e2b:	48 01 ca             	add    %rcx,%rdx
    8e2e:	4d 0f af c8          	imul   %r8,%r9
    8e32:	49 01 d1             	add    %rdx,%r9
    8e35:	48 b9 00 a0 34 52 a3 	movabs $0x6baf6aa35234a000,%rcx
    8e3c:	6a af 6b 
    8e3f:	48 01 c1             	add    %rax,%rcx
    8e42:	48 b8 37 f9 ff e2 04 	movabs $0x4e2fff937,%rax
    8e49:	00 00 00 
    8e4c:	4c 11 c8             	adc    %r9,%rax
    8e4f:	48 89 c2             	mov    %rax,%rdx
    8e52:	48 0f ac ca 0d       	shrd   $0xd,%rcx,%rdx
    8e57:	48 0f a4 c8 33       	shld   $0x33,%rcx,%rax
    8e5c:	48 b9 4a 23 35 aa f6 	movabs $0x9376baf6aa35234a,%rcx
    8e63:	ba 76 93 
    8e66:	48 39 c1             	cmp    %rax,%rcx
    8e69:	b8 ff 2f 4e 00       	mov    $0x4e2fff,%eax
    8e6e:	48 19 d0             	sbb    %rdx,%rax
    8e71:	0f 83 70 02 00 00    	jae    90e7 <fwp_fmt_duration+0x2f7>
    8e77:	48 b9 b3 b2 61 36 8c 	movabs $0xc5ce3b8c3661b2b3,%rcx
    8e7e:	3b ce c5 
    8e81:	49 b9 c3 5f 47 6a 04 	movabs $0x1a8d52046a475fc3,%r9
    8e88:	52 8d 1a 
    8e8b:	48 89 f0             	mov    %rsi,%rax
    8e8e:	49 f7 e1             	mul    %r9
    8e91:	48 0f af ce          	imul   %rsi,%rcx
    8e95:	48 01 ca             	add    %rcx,%rdx
    8e98:	4d 0f af c8          	imul   %r8,%r9
    8e9c:	49 01 d1             	add    %rdx,%r9
    8e9f:	48 b9 00 a8 16 d1 91 	movabs $0x4f473f91d116a800,%rcx
    8ea6:	3f 47 4f 
    8ea9:	48 01 c1             	add    %rax,%rcx
    8eac:	48 b8 3f 9a ff 4c 49 	movabs $0x494cff9a3f,%rax
    8eb3:	00 00 00 
    8eb6:	4c 11 c8             	adc    %r9,%rax
    8eb9:	48 89 c2             	mov    %rax,%rdx
    8ebc:	48 0f ac ca 0b       	shrd   $0xb,%rcx,%rdx
    8ec1:	48 0f a4 c8 35       	shld   $0x35,%rcx,%rax
    8ec6:	48 b9 ab 45 74 e4 cf 	movabs $0x8fd3d1cfe47445ab,%rcx
    8ecd:	d1 d3 8f 
    8ed0:	48 39 c8             	cmp    %rcx,%rax
    8ed3:	48 81 da e6 3f 53 12 	sbb    $0x12533fe6,%rdx
    8eda:	0f 82 27 02 00 00    	jb     9107 <fwp_fmt_duration+0x317>
    8ee0:	48 b9 7e 78 b9 2f 37 	movabs $0x97157d372fb9787e,%rcx
    8ee7:	7d 15 97 
    8eea:	48 0f af ce          	imul   %rsi,%rcx
    8eee:	49 b9 6d 9c 2e 3a 42 	movabs $0x8e47ce423a2e9c6d,%r9
    8ef5:	ce 47 8e 
    8ef8:	48 89 f0             	mov    %rsi,%rax
    8efb:	49 f7 e1             	mul    %r9
    8efe:	48 01 ca             	add    %rcx,%rdx
    8f01:	4d 0f af c8          	imul   %r8,%r9
    8f05:	49 01 d1             	add    %rdx,%r9
    8f08:	48 b9 00 46 54 40 8b 	movabs $0xa52cb98b40544600,%rcx
    8f0f:	b9 2c a5 
    8f12:	48 01 c1             	add    %rax,%rcx
    8f15:	48 b8 b5 09 fa 82 4b 	movabs $0x44b82fa09b5,%rax
    8f1c:	04 00 00 
    8f1f:	4c 11 c8             	adc    %r9,%rax
    8f22:	48 89 c2             	mov    %rax,%rdx
    8f25:	48 0f ac ca 09       	shrd   $0x9,%rcx,%rdx
    8f2a:	48 0f a4 c8 37       	shld   $0x37,%rcx,%rax
    8f2f:	48 b9 47 54 40 8b b9 	movabs $0xb5a52cb98b405447,%rcx
    8f36:	2c a5 b5 
    8f39:	48 39 c8             	cmp    %rcx,%rax
    8f3c:	48 b8 09 fa 82 4b 04 	movabs $0x44b82fa09,%rax
    8f43:	00 00 00 
    8f46:	48 19 c2             	sbb    %rax,%rdx
    8f49:	0f 82 0d 03 00 00    	jb     925c <fwp_fmt_duration+0x46c>
    8f4f:	48 b9 cb d5 8f 4d f2 	movabs $0xc57e23f24d8fd5cb,%rcx
    8f56:	23 7e c5 
    8f59:	48 0f af ce          	imul   %rsi,%rcx
    8f5d:	49 b9 39 61 c2 68 56 	movabs $0x790fb65668c26139,%r9
    8f64:	b6 0f 79 
    8f67:	48 89 f0             	mov    %rsi,%rax
    8f6a:	49 f7 e1             	mul    %r9
    8f6d:	48 01 ca             	add    %rcx,%rdx
    8f70:	4d 0f af c8          	imul   %r8,%r9
    8f74:	49 01 d1             	add    %rdx,%r9
    8f77:	48 b9 00 0b 27 69 fe 	movabs $0xa6d698fe69270b00,%rcx
    8f7e:	98 d6 a6 
    8f81:	48 01 c1             	add    %rax,%rcx
    8f84:	48 b8 b1 bd 16 f4 de 	movabs $0x218def416bdb1,%rax
    8f8b:	18 02 00 
    8f8e:	4c 11 c8             	adc    %r9,%rax
    8f91:	48 89 c2             	mov    %rax,%rdx
    8f94:	48 0f ac ca 06       	shrd   $0x6,%rcx,%rdx
    8f99:	48 0f a4 c8 3a       	shld   $0x3a,%rcx,%rax
    8f9e:	48 b9 59 38 49 f3 c7 	movabs $0x8d36b4c7f3493859,%rcx
    8fa5:	b4 36 8d 
    8fa8:	48 39 c8             	cmp    %rcx,%rax
    8fab:	48 b8 ed b5 a0 f7 c6 	movabs $0x10c6f7a0b5ed,%rax
    8fb2:	10 00 00 
    8fb5:	48 19 c2             	sbb    %rax,%rdx
    8fb8:	0f 82 ad 02 00 00    	jb     926b <fwp_fmt_duration+0x47b>
    8fbe:	48 b9 5a 64 3b df 4f 	movabs $0x6e978d4fdf3b645a,%rcx
    8fc5:	8d 97 6e 
    8fc8:	48 0f af ce          	imul   %rsi,%rcx
    8fcc:	49 b9 d5 78 e9 26 31 	movabs $0x1cac083126e978d5,%r9
    8fd3:	08 ac 1c 
    8fd6:	48 89 f0             	mov    %rsi,%rax
    8fd9:	49 f7 e1             	mul    %r9
    8fdc:	48 01 ca             	add    %rcx,%rdx
    8fdf:	4d 0f af c8          	imul   %r8,%r9
    8fe3:	49 01 d1             	add    %rdx,%r9
    8fe6:	48 b9 48 62 10 58 39 	movabs $0x76c8b43958106248,%rcx
    8fed:	b4 c8 76 
    8ff0:	48 01 c1             	add    %rax,%rcx
    8ff3:	48 b8 be 9f 1a 2f dd 	movabs $0x10624dd2f1a9fbe,%rax
    8ffa:	24 06 01 
    8ffd:	4c 11 c8             	adc    %r9,%rax
    9000:	48 89 c2             	mov    %rax,%rdx
    9003:	48 0f ac ca 03       	shrd   $0x3,%rcx,%rdx
    9008:	48 0f a4 c8 3d       	shld   $0x3d,%rcx,%rax
    900d:	48 b9 93 18 04 56 0e 	movabs $0x9db22d0e56041893,%rcx
    9014:	2d b2 9d 
    9017:	48 39 c8             	cmp    %rcx,%rax
    901a:	48 b8 ef a7 c6 4b 37 	movabs $0x4189374bc6a7ef,%rax
    9021:	89 41 00 
    9024:	48 19 c2             	sbb    %rax,%rdx
    9027:	0f 82 4d 02 00 00    	jb     927a <fwp_fmt_duration+0x48a>
    902d:	4d 85 c0             	test   %r8,%r8
    9030:	0f 88 d6 06 00 00    	js     970c <fwp_fmt_duration+0x91c>
    9036:	45 31 d2             	xor    %r10d,%r10d
    9039:	49 bb cd cc cc cc cc 	movabs $0xcccccccccccccccd,%r11
    9040:	cc cc cc 
    9043:	48 bb cc cc cc cc cc 	movabs $0xcccccccccccccccc,%rbx
    904a:	cc cc cc 
    904d:	4d 89 c6             	mov    %r8,%r14
    9050:	4c 89 c1             	mov    %r8,%rcx
    9053:	48 0f a4 f1 3f       	shld   $0x3f,%rsi,%rcx
    9058:	49 d1 ee             	shr    $1,%r14
    905b:	49 89 c9             	mov    %rcx,%r9
    905e:	4d 01 f1             	add    %r14,%r9
    9061:	49 83 d1 00          	adc    $0x0,%r9
    9065:	4c 89 c8             	mov    %r9,%rax
    9068:	49 f7 e3             	mul    %r11
    906b:	48 c1 ea 02          	shr    $0x2,%rdx
    906f:	48 8d 04 92          	lea    (%rdx,%rdx,4),%rax
    9073:	49 29 c1             	sub    %rax,%r9
    9076:	4c 29 c9             	sub    %r9,%rcx
    9079:	49 83 de 00          	sbb    $0x0,%r14
    907d:	49 89 c9             	mov    %rcx,%r9
    9080:	4c 0f af cb          	imul   %rbx,%r9
    9084:	48 89 c8             	mov    %rcx,%rax
    9087:	49 f7 e3             	mul    %r11
    908a:	4c 01 ca             	add    %r9,%rdx
    908d:	4d 0f af f3          	imul   %r11,%r14
    9091:	49 01 d6             	add    %rdx,%r14
    9094:	48 89 c1             	mov    %rax,%rcx
    9097:	48 01 c1             	add    %rax,%rcx
    909a:	48 8d 0c 89          	lea    (%rcx,%rcx,4),%rcx
    909e:	89 f2                	mov    %esi,%edx
    90a0:	29 ca                	sub    %ecx,%edx
    90a2:	80 ca 30             	or     $0x30,%dl
    90a5:	42 88 54 14 40       	mov    %dl,0x40(%rsp,%r10,1)
    90aa:	49 ff c2             	inc    %r10
    90ad:	48 83 fe 0a          	cmp    $0xa,%rsi
    90b1:	49 83 d8 00          	sbb    $0x0,%r8
    90b5:	48 89 c6             	mov    %rax,%rsi
    90b8:	4d 89 f0             	mov    %r14,%r8
    90bb:	73 93                	jae    9050 <fwp_fmt_duration+0x260>
    90bd:	45 85 d2             	test   %r10d,%r10d
    90c0:	7f 12                	jg     90d4 <fwp_fmt_duration+0x2e4>
    90c2:	31 c0                	xor    %eax,%eax
    90c4:	e9 79 01 00 00       	jmp    9242 <fwp_fmt_duration+0x452>
    90c9:	c6 44 24 40 30       	movb   $0x30,0x40(%rsp)
    90ce:	41 ba 01 00 00 00    	mov    $0x1,%r10d
    90d4:	44 89 d0             	mov    %r10d,%eax
    90d7:	48 83 f8 08          	cmp    $0x8,%rax
    90db:	73 1e                	jae    90fb <fwp_fmt_duration+0x30b>
    90dd:	31 c9                	xor    %ecx,%ecx
    90df:	48 89 c2             	mov    %rax,%rdx
    90e2:	e9 3d 01 00 00       	jmp    9224 <fwp_fmt_duration+0x434>
    90e7:	49 89 fe             	mov    %rdi,%r14
    90ea:	48 ba 00 a0 b8 30 46 	movabs $0x34630b8a000,%rdx
    90f1:	03 00 00 
    90f4:	31 c0                	xor    %eax,%eax
    90f6:	e9 8c 01 00 00       	jmp    9287 <fwp_fmt_duration+0x497>
    90fb:	83 f8 20             	cmp    $0x20,%eax
    90fe:	73 1e                	jae    911e <fwp_fmt_duration+0x32e>
    9100:	31 c9                	xor    %ecx,%ecx
    9102:	e9 c3 00 00 00       	jmp    91ca <fwp_fmt_duration+0x3da>
    9107:	49 89 fe             	mov    %rdi,%r14
    910a:	48 ba 00 58 47 f8 0d 	movabs $0xdf8475800,%rdx
    9111:	00 00 00 
    9114:	b8 01 00 00 00       	mov    $0x1,%eax
    9119:	e9 69 01 00 00       	jmp    9287 <fwp_fmt_duration+0x497>
    911e:	44 89 d2             	mov    %r10d,%edx
    9121:	83 e2 1f             	and    $0x1f,%edx
    9124:	48 89 c1             	mov    %rax,%rcx
    9127:	48 29 d1             	sub    %rdx,%rcx
    912a:	48 8d 74 24 10       	lea    0x10(%rsp),%rsi
    912f:	66 0f ef c0          	pxor   %xmm0,%xmm0
    9133:	49 89 c0             	mov    %rax,%r8
    9136:	66 2e 0f 1f 84 00 00 	cs nopw 0x0(%rax,%rax,1)
    913d:	00 00 00 
    9140:	f3 42 0f 6f 4c 04 20 	movdqu 0x20(%rsp,%r8,1),%xmm1
    9147:	f3 42 0f 6f 54 04 30 	movdqu 0x30(%rsp,%r8,1),%xmm2
    914e:	66 0f 6f da          	movdqa %xmm2,%xmm3
    9152:	66 0f 60 d8          	punpcklbw %xmm0,%xmm3
    9156:	66 0f 70 db 4e       	pshufd $0x4e,%xmm3,%xmm3
    915b:	f2 0f 70 db 1b       	pshuflw $0x1b,%xmm3,%xmm3
    9160:	f3 0f 70 db 1b       	pshufhw $0x1b,%xmm3,%xmm3
    9165:	66 0f 68 d0          	punpckhbw %xmm0,%xmm2
    9169:	66 0f 70 d2 4e       	pshufd $0x4e,%xmm2,%xmm2
    916e:	f2 0f 70 d2 1b       	pshuflw $0x1b,%xmm2,%xmm2
    9173:	f3 0f 70 d2 1b       	pshufhw $0x1b,%xmm2,%xmm2
    9178:	66 0f 67 d3          	packuswb %xmm3,%xmm2
    917c:	66 0f 6f d9          	movdqa %xmm1,%xmm3
    9180:	66 0f 60 d8          	punpcklbw %xmm0,%xmm3
    9184:	66 0f 70 db 4e       	pshufd $0x4e,%xmm3,%xmm3
    9189:	f2 0f 70 db 1b       	pshuflw $0x1b,%xmm3,%xmm3
    918e:	f3 0f 70 db 1b       	pshufhw $0x1b,%xmm3,%xmm3
    9193:	66 0f 68 c8          	punpckhbw %xmm0,%xmm1
    9197:	66 0f 70 c9 4e       	pshufd $0x4e,%xmm1,%xmm1
    919c:	f2 0f 70 c9 1b       	pshuflw $0x1b,%xmm1,%xmm1
    91a1:	f3 0f 70 c9 1b       	pshufhw $0x1b,%xmm1,%xmm1
    91a6:	66 0f 67 cb          	packuswb %xmm3,%xmm1
    91aa:	66 0f 7f 56 f0       	movdqa %xmm2,-0x10(%rsi)
    91af:	66 0f 7f 0e          	movdqa %xmm1,(%rsi)
    91b3:	49 83 c0 e0          	add    $0xffffffffffffffe0,%r8
    91b7:	48 83 c6 20          	add    $0x20,%rsi
    91bb:	4c 39 c2             	cmp    %r8,%rdx
    91be:	75 80                	jne    9140 <fwp_fmt_duration+0x350>
    91c0:	48 85 d2             	test   %rdx,%rdx
    91c3:	74 7d                	je     9242 <fwp_fmt_duration+0x452>
    91c5:	83 fa 08             	cmp    $0x8,%edx
    91c8:	72 5a                	jb     9224 <fwp_fmt_duration+0x434>
    91ca:	44 89 d2             	mov    %r10d,%edx
    91cd:	83 e2 07             	and    $0x7,%edx
    91d0:	48 89 c6             	mov    %rax,%rsi
    91d3:	48 29 ce             	sub    %rcx,%rsi
    91d6:	4c 8d 04 0c          	lea    (%rsp,%rcx,1),%r8
    91da:	48 89 c1             	mov    %rax,%rcx
    91dd:	48 29 d1             	sub    %rdx,%rcx
    91e0:	66 0f ef c0          	pxor   %xmm0,%xmm0
    91e4:	66 66 66 2e 0f 1f 84 	data16 data16 cs nopw 0x0(%rax,%rax,1)
    91eb:	00 00 00 00 00 
    91f0:	f3 0f 7e 4c 34 38    	movq   0x38(%rsp,%rsi,1),%xmm1
    91f6:	66 0f 60 c8          	punpcklbw %xmm0,%xmm1
    91fa:	66 0f 70 c9 4e       	pshufd $0x4e,%xmm1,%xmm1
    91ff:	f2 0f 70 c9 1b       	pshuflw $0x1b,%xmm1,%xmm1
    9204:	f3 0f 70 c9 1b       	pshufhw $0x1b,%xmm1,%xmm1
    9209:	66 0f 67 c9          	packuswb %xmm1,%xmm1
    920d:	66 41 0f d6 08       	movq   %xmm1,(%r8)
    9212:	48 83 c6 f8          	add    $0xfffffffffffffff8,%rsi
    9216:	49 83 c0 08          	add    $0x8,%r8
    921a:	48 39 f2             	cmp    %rsi,%rdx
    921d:	75 d1                	jne    91f0 <fwp_fmt_duration+0x400>
    921f:	48 85 d2             	test   %rdx,%rdx
    9222:	74 1e                	je     9242 <fwp_fmt_duration+0x452>
    9224:	48 8d 74 24 40       	lea    0x40(%rsp),%rsi
    9229:	48 01 f2             	add    %rsi,%rdx
    922c:	48 ff ca             	dec    %rdx
    922f:	90                   	nop
    9230:	0f b6 32             	movzbl (%rdx),%esi
    9233:	40 88 34 0c          	mov    %sil,(%rsp,%rcx,1)
    9237:	48 ff c1             	inc    %rcx
    923a:	48 ff ca             	dec    %rdx
    923d:	48 39 c8             	cmp    %rcx,%rax
    9240:	75 ee                	jne    9230 <fwp_fmt_duration+0x440>
    9242:	c6 04 04 00          	movb   $0x0,(%rsp,%rax,1)
    9246:	48 8d 35 39 64 00 00 	lea    0x6439(%rip),%rsi        # f686 <fwp_segv.msg+0x446>
    924d:	48 89 e2             	mov    %rsp,%rdx
    9250:	31 c0                	xor    %eax,%eax
    9252:	e8 29 90 ff ff       	call   2280 <sprintf@plt>
    9257:	e9 a1 04 00 00       	jmp    96fd <fwp_fmt_duration+0x90d>
    925c:	49 89 fe             	mov    %rdi,%r14
    925f:	ba 00 ca 9a 3b       	mov    $0x3b9aca00,%edx
    9264:	b8 02 00 00 00       	mov    $0x2,%eax
    9269:	eb 1c                	jmp    9287 <fwp_fmt_duration+0x497>
    926b:	49 89 fe             	mov    %rdi,%r14
    926e:	ba 40 42 0f 00       	mov    $0xf4240,%edx
    9273:	b8 03 00 00 00       	mov    $0x3,%eax
    9278:	eb 0d                	jmp    9287 <fwp_fmt_duration+0x497>
    927a:	49 89 fe             	mov    %rdi,%r14
    927d:	ba e8 03 00 00       	mov    $0x3e8,%edx
    9282:	b8 04 00 00 00       	mov    $0x4,%eax
    9287:	31 c9                	xor    %ecx,%ecx
    9289:	c1 e0 04             	shl    $0x4,%eax
    928c:	48 8d 1d dd 8a 00 00 	lea    0x8add(%rip),%rbx        # 11d70 <fwp_fmt_duration.units>
    9293:	48 01 c3             	add    %rax,%rbx
    9296:	48 89 f7             	mov    %rsi,%rdi
    9299:	4c 89 c6             	mov    %r8,%rsi
    929c:	e8 ff 4e 00 00       	call   e1a0 <__divti3>
    92a1:	48 89 c1             	mov    %rax,%rcx
    92a4:	48 89 d6             	mov    %rdx,%rsi
    92a7:	48 85 d2             	test   %rdx,%rdx
    92aa:	0f 88 b0 00 00 00    	js     9360 <fwp_fmt_duration+0x570>
    92b0:	48 89 c8             	mov    %rcx,%rax
    92b3:	48 09 f0             	or     %rsi,%rax
    92b6:	0f 84 61 01 00 00    	je     941d <fwp_fmt_duration+0x62d>
    92bc:	45 31 d2             	xor    %r10d,%r10d
    92bf:	49 bb cd cc cc cc cc 	movabs $0xcccccccccccccccd,%r11
    92c6:	cc cc cc 
    92c9:	49 bf cc cc cc cc cc 	movabs $0xcccccccccccccccc,%r15
    92d0:	cc cc cc 
    92d3:	49 89 f4             	mov    %rsi,%r12
    92d6:	4c 89 f7             	mov    %r14,%rdi
    92d9:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)
    92e0:	49 89 f0             	mov    %rsi,%r8
    92e3:	49 0f a4 c8 3f       	shld   $0x3f,%rcx,%r8
    92e8:	49 d1 ec             	shr    $1,%r12
    92eb:	4d 89 c1             	mov    %r8,%r9
    92ee:	4d 01 e1             	add    %r12,%r9
    92f1:	49 83 d1 00          	adc    $0x0,%r9
    92f5:	4c 89 c8             	mov    %r9,%rax
    92f8:	49 f7 e3             	mul    %r11
    92fb:	48 c1 ea 02          	shr    $0x2,%rdx
    92ff:	48 8d 04 92          	lea    (%rdx,%rdx,4),%rax
    9303:	49 29 c1             	sub    %rax,%r9
    9306:	4d 29 c8             	sub    %r9,%r8
    9309:	49 83 dc 00          	sbb    $0x0,%r12
    930d:	4d 89 c1             	mov    %r8,%r9
    9310:	4d 0f af cf          	imul   %r15,%r9
    9314:	4c 89 c0             	mov    %r8,%rax
    9317:	49 f7 e3             	mul    %r11
    931a:	4c 01 ca             	add    %r9,%rdx
    931d:	4d 0f af e3          	imul   %r11,%r12
    9321:	49 01 d4             	add    %rdx,%r12
    9324:	48 89 c2             	mov    %rax,%rdx
    9327:	48 01 c2             	add    %rax,%rdx
    932a:	48 8d 14 92          	lea    (%rdx,%rdx,4),%rdx
    932e:	41 89 c8             	mov    %ecx,%r8d
    9331:	41 29 d0             	sub    %edx,%r8d
    9334:	41 80 c8 30          	or     $0x30,%r8b
    9338:	46 88 44 14 40       	mov    %r8b,0x40(%rsp,%r10,1)
    933d:	49 ff c2             	inc    %r10
    9340:	48 83 f9 0a          	cmp    $0xa,%rcx
    9344:	48 83 de 00          	sbb    $0x0,%rsi
    9348:	48 89 c1             	mov    %rax,%rcx
    934b:	4c 89 e6             	mov    %r12,%rsi
    934e:	73 90                	jae    92e0 <fwp_fmt_duration+0x4f0>
    9350:	45 85 d2             	test   %r10d,%r10d
    9353:	0f 8f d2 00 00 00    	jg     942b <fwp_fmt_duration+0x63b>
    9359:	31 c0                	xor    %eax,%eax
    935b:	e9 12 02 00 00       	jmp    9572 <fwp_fmt_duration+0x782>
    9360:	45 31 c0             	xor    %r8d,%r8d
    9363:	48 f7 d9             	neg    %rcx
    9366:	41 b9 00 00 00 00    	mov    $0x0,%r9d
    936c:	49 19 f1             	sbb    %rsi,%r9
    936f:	c6 04 24 2d          	movb   $0x2d,(%rsp)
    9373:	49 ba cd cc cc cc cc 	movabs $0xcccccccccccccccd,%r10
    937a:	cc cc cc 
    937d:	49 bb cc cc cc cc cc 	movabs $0xcccccccccccccccc,%r11
    9384:	cc cc cc 
    9387:	4d 89 cf             	mov    %r9,%r15
    938a:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)
    9390:	4c 89 ce             	mov    %r9,%rsi
    9393:	48 0f a4 ce 3f       	shld   $0x3f,%rcx,%rsi
    9398:	49 d1 ef             	shr    $1,%r15
    939b:	48 89 f7             	mov    %rsi,%rdi
    939e:	4c 01 ff             	add    %r15,%rdi
    93a1:	48 83 d7 00          	adc    $0x0,%rdi
    93a5:	48 89 f8             	mov    %rdi,%rax
    93a8:	49 f7 e2             	mul    %r10
    93ab:	48 c1 ea 02          	shr    $0x2,%rdx
    93af:	48 8d 04 92          	lea    (%rdx,%rdx,4),%rax
    93b3:	48 29 c7             	sub    %rax,%rdi
    93b6:	48 29 fe             	sub    %rdi,%rsi
    93b9:	49 83 df 00          	sbb    $0x0,%r15
    93bd:	48 89 f7             	mov    %rsi,%rdi
    93c0:	49 0f af fb          	imul   %r11,%rdi
    93c4:	48 89 f0             	mov    %rsi,%rax
    93c7:	49 f7 e2             	mul    %r10
    93ca:	48 01 fa             	add    %rdi,%rdx
    93cd:	4d 0f af fa          	imul   %r10,%r15
    93d1:	49 01 d7             	add    %rdx,%r15
    93d4:	48 89 c2             	mov    %rax,%rdx
    93d7:	48 01 c2             	add    %rax,%rdx
    93da:	48 8d 14 92          	lea    (%rdx,%rdx,4),%rdx
    93de:	89 ce                	mov    %ecx,%esi
    93e0:	29 d6                	sub    %edx,%esi
    93e2:	40 80 ce 30          	or     $0x30,%sil
    93e6:	42 88 74 04 40       	mov    %sil,0x40(%rsp,%r8,1)
    93eb:	49 ff c0             	inc    %r8
    93ee:	48 83 f9 0a          	cmp    $0xa,%rcx
    93f2:	49 83 d9 00          	sbb    $0x0,%r9
    93f6:	48 89 c1             	mov    %rax,%rcx
    93f9:	4d 89 f9             	mov    %r15,%r9
    93fc:	73 92                	jae    9390 <fwp_fmt_duration+0x5a0>
    93fe:	45 85 c0             	test   %r8d,%r8d
    9401:	4c 89 f7             	mov    %r14,%rdi
    9404:	7e 44                	jle    944a <fwp_fmt_duration+0x65a>
    9406:	44 89 c0             	mov    %r8d,%eax
    9409:	48 83 f8 08          	cmp    $0x8,%rax
    940d:	0f 83 68 01 00 00    	jae    957b <fwp_fmt_duration+0x78b>
    9413:	31 c9                	xor    %ecx,%ecx
    9415:	48 89 c2             	mov    %rax,%rdx
    9418:	e9 97 02 00 00       	jmp    96b4 <fwp_fmt_duration+0x8c4>
    941d:	c6 44 24 40 30       	movb   $0x30,0x40(%rsp)
    9422:	41 ba 01 00 00 00    	mov    $0x1,%r10d
    9428:	4c 89 f7             	mov    %r14,%rdi
    942b:	44 89 d0             	mov    %r10d,%eax
    942e:	48 83 f8 08          	cmp    $0x8,%rax
    9432:	73 0a                	jae    943e <fwp_fmt_duration+0x64e>
    9434:	31 c9                	xor    %ecx,%ecx
    9436:	48 89 c2             	mov    %rax,%rdx
    9439:	e9 16 01 00 00       	jmp    9554 <fwp_fmt_duration+0x764>
    943e:	83 f8 20             	cmp    $0x20,%eax
    9441:	73 0e                	jae    9451 <fwp_fmt_duration+0x661>
    9443:	31 c9                	xor    %ecx,%ecx
    9445:	e9 b0 00 00 00       	jmp    94fa <fwp_fmt_duration+0x70a>
    944a:	31 c0                	xor    %eax,%eax
    944c:	e9 93 02 00 00       	jmp    96e4 <fwp_fmt_duration+0x8f4>
    9451:	44 89 d2             	mov    %r10d,%edx
    9454:	83 e2 1f             	and    $0x1f,%edx
    9457:	48 89 c1             	mov    %rax,%rcx
    945a:	48 29 d1             	sub    %rdx,%rcx
    945d:	48 8d 74 24 10       	lea    0x10(%rsp),%rsi
    9462:	66 0f ef c0          	pxor   %xmm0,%xmm0
    9466:	49 89 c0             	mov    %rax,%r8
    9469:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)
    9470:	f3 42 0f 6f 4c 04 20 	movdqu 0x20(%rsp,%r8,1),%xmm1
    9477:	f3 42 0f 6f 54 04 30 	movdqu 0x30(%rsp,%r8,1),%xmm2
    947e:	66 0f 6f da          	movdqa %xmm2,%xmm3
    9482:	66 0f 60 d8          	punpcklbw %xmm0,%xmm3
    9486:	66 0f 70 db 4e       	pshufd $0x4e,%xmm3,%xmm3
    948b:	f2 0f 70 db 1b       	pshuflw $0x1b,%xmm3,%xmm3
    9490:	f3 0f 70 db 1b       	pshufhw $0x1b,%xmm3,%xmm3
    9495:	66 0f 68 d0          	punpckhbw %xmm0,%xmm2
    9499:	66 0f 70 d2 4e       	pshufd $0x4e,%xmm2,%xmm2
    949e:	f2 0f 70 d2 1b       	pshuflw $0x1b,%xmm2,%xmm2
    94a3:	f3 0f 70 d2 1b       	pshufhw $0x1b,%xmm2,%xmm2
    94a8:	66 0f 67 d3          	packuswb %xmm3,%xmm2
    94ac:	66 0f 6f d9          	movdqa %xmm1,%xmm3
    94b0:	66 0f 60 d8          	punpcklbw %xmm0,%xmm3
    94b4:	66 0f 70 db 4e       	pshufd $0x4e,%xmm3,%xmm3
    94b9:	f2 0f 70 db 1b       	pshuflw $0x1b,%xmm3,%xmm3
    94be:	f3 0f 70 db 1b       	pshufhw $0x1b,%xmm3,%xmm3
    94c3:	66 0f 68 c8          	punpckhbw %xmm0,%xmm1
    94c7:	66 0f 70 c9 4e       	pshufd $0x4e,%xmm1,%xmm1
    94cc:	f2 0f 70 c9 1b       	pshuflw $0x1b,%xmm1,%xmm1
    94d1:	f3 0f 70 c9 1b       	pshufhw $0x1b,%xmm1,%xmm1
    94d6:	66 0f 67 cb          	packuswb %xmm3,%xmm1
    94da:	66 0f 7f 56 f0       	movdqa %xmm2,-0x10(%rsi)
    94df:	66 0f 7f 0e          	movdqa %xmm1,(%rsi)
    94e3:	49 83 c0 e0          	add    $0xffffffffffffffe0,%r8
    94e7:	48 83 c6 20          	add    $0x20,%rsi
    94eb:	4c 39 c2             	cmp    %r8,%rdx
    94ee:	75 80                	jne    9470 <fwp_fmt_duration+0x680>
    94f0:	48 85 d2             	test   %rdx,%rdx
    94f3:	74 7d                	je     9572 <fwp_fmt_duration+0x782>
    94f5:	83 fa 08             	cmp    $0x8,%edx
    94f8:	72 5a                	jb     9554 <fwp_fmt_duration+0x764>
    94fa:	44 89 d2             	mov    %r10d,%edx
    94fd:	83 e2 07             	and    $0x7,%edx
    9500:	48 89 c6             	mov    %rax,%rsi
    9503:	48 29 ce             	sub    %rcx,%rsi
    9506:	4c 8d 04 0c          	lea    (%rsp,%rcx,1),%r8
    950a:	48 89 c1             	mov    %rax,%rcx
    950d:	48 29 d1             	sub    %rdx,%rcx
    9510:	66 0f ef c0          	pxor   %xmm0,%xmm0
    9514:	66 66 66 2e 0f 1f 84 	data16 data16 cs nopw 0x0(%rax,%rax,1)
    951b:	00 00 00 00 00 
    9520:	f3 0f 7e 4c 34 38    	movq   0x38(%rsp,%rsi,1),%xmm1
    9526:	66 0f 60 c8          	punpcklbw %xmm0,%xmm1
    952a:	66 0f 70 c9 4e       	pshufd $0x4e,%xmm1,%xmm1
    952f:	f2 0f 70 c9 1b       	pshuflw $0x1b,%xmm1,%xmm1
    9534:	f3 0f 70 c9 1b       	pshufhw $0x1b,%xmm1,%xmm1
    9539:	66 0f 67 c9          	packuswb %xmm1,%xmm1
    953d:	66 41 0f d6 08       	movq   %xmm1,(%r8)
    9542:	48 83 c6 f8          	add    $0xfffffffffffffff8,%rsi
    9546:	49 83 c0 08          	add    $0x8,%r8
    954a:	48 39 f2             	cmp    %rsi,%rdx
    954d:	75 d1                	jne    9520 <fwp_fmt_duration+0x730>
    954f:	48 85 d2             	test   %rdx,%rdx
    9552:	74 1e                	je     9572 <fwp_fmt_duration+0x782>
    9554:	48 8d 74 24 40       	lea    0x40(%rsp),%rsi
    9559:	48 01 f2             	add    %rsi,%rdx
    955c:	48 ff ca             	dec    %rdx
    955f:	90                   	nop
    9560:	0f b6 32             	movzbl (%rdx),%esi
    9563:	40 88 34 0c          	mov    %sil,(%rsp,%rcx,1)
    9567:	48 ff c1             	inc    %rcx
    956a:	48 ff ca             	dec    %rdx
    956d:	48 39 c8             	cmp    %rcx,%rax
    9570:	75 ee                	jne    9560 <fwp_fmt_duration+0x770>
    9572:	c6 04 04 00          	movb   $0x0,(%rsp,%rax,1)
    9576:	e9 6e 01 00 00       	jmp    96e9 <fwp_fmt_duration+0x8f9>
    957b:	83 f8 20             	cmp    $0x20,%eax
    957e:	73 07                	jae    9587 <fwp_fmt_duration+0x797>
    9580:	31 c9                	xor    %ecx,%ecx
    9582:	e9 bd 00 00 00       	jmp    9644 <fwp_fmt_duration+0x854>
    9587:	44 89 c6             	mov    %r8d,%esi
    958a:	44 89 c2             	mov    %r8d,%edx
    958d:	83 e2 1f             	and    $0x1f,%edx
    9590:	48 89 c1             	mov    %rax,%rcx
    9593:	48 29 d1             	sub    %rdx,%rcx
    9596:	4c 8d 0c 34          	lea    (%rsp,%rsi,1),%r9
    959a:	49 83 c1 30          	add    $0x30,%r9
    959e:	48 29 d6             	sub    %rdx,%rsi
    95a1:	45 31 d2             	xor    %r10d,%r10d
    95a4:	66 0f ef c0          	pxor   %xmm0,%xmm0
    95a8:	0f 1f 84 00 00 00 00 	nopl   0x0(%rax,%rax,1)
    95af:	00 
    95b0:	f3 41 0f 6f 49 f0    	movdqu -0x10(%r9),%xmm1
    95b6:	f3 41 0f 6f 11       	movdqu (%r9),%xmm2
    95bb:	66 0f 6f da          	movdqa %xmm2,%xmm3
    95bf:	66 0f 60 d8          	punpcklbw %xmm0,%xmm3
    95c3:	66 0f 70 db 4e       	pshufd $0x4e,%xmm3,%xmm3
    95c8:	f2 0f 70 db 1b       	pshuflw $0x1b,%xmm3,%xmm3
    95cd:	f3 0f 70 db 1b       	pshufhw $0x1b,%xmm3,%xmm3
    95d2:	66 0f 68 d0          	punpckhbw %xmm0,%xmm2
    95d6:	66 0f 70 d2 4e       	pshufd $0x4e,%xmm2,%xmm2
    95db:	f2 0f 70 d2 1b       	pshuflw $0x1b,%xmm2,%xmm2
    95e0:	f3 0f 70 d2 1b       	pshufhw $0x1b,%xmm2,%xmm2
    95e5:	66 0f 67 d3          	packuswb %xmm3,%xmm2
    95e9:	66 0f 6f d9          	movdqa %xmm1,%xmm3
    95ed:	66 0f 60 d8          	punpcklbw %xmm0,%xmm3
    95f1:	66 0f 70 db 4e       	pshufd $0x4e,%xmm3,%xmm3
    95f6:	f2 0f 70 db 1b       	pshuflw $0x1b,%xmm3,%xmm3
    95fb:	f3 0f 70 db 1b       	pshufhw $0x1b,%xmm3,%xmm3
    9600:	66 0f 68 c8          	punpckhbw %xmm0,%xmm1
    9604:	66 0f 70 c9 4e       	pshufd $0x4e,%xmm1,%xmm1
    9609:	f2 0f 70 c9 1b       	pshuflw $0x1b,%xmm1,%xmm1
    960e:	f3 0f 70 c9 1b       	pshufhw $0x1b,%xmm1,%xmm1
    9613:	66 0f 67 cb          	packuswb %xmm3,%xmm1
    9617:	f3 42 0f 7f 54 14 01 	movdqu %xmm2,0x1(%rsp,%r10,1)
    961e:	f3 42 0f 7f 4c 14 11 	movdqu %xmm1,0x11(%rsp,%r10,1)
    9625:	49 83 c2 20          	add    $0x20,%r10
    9629:	49 83 c1 e0          	add    $0xffffffffffffffe0,%r9
    962d:	4c 39 d6             	cmp    %r10,%rsi
    9630:	0f 85 7a ff ff ff    	jne    95b0 <fwp_fmt_duration+0x7c0>
    9636:	48 85 d2             	test   %rdx,%rdx
    9639:	0f 84 a5 00 00 00    	je     96e4 <fwp_fmt_duration+0x8f4>
    963f:	83 fa 08             	cmp    $0x8,%edx
    9642:	72 70                	jb     96b4 <fwp_fmt_duration+0x8c4>
    9644:	48 89 ce             	mov    %rcx,%rsi
    9647:	45 89 c1             	mov    %r8d,%r9d
    964a:	44 89 c2             	mov    %r8d,%edx
    964d:	83 e2 07             	and    $0x7,%edx
    9650:	48 89 c1             	mov    %rax,%rcx
    9653:	48 29 d1             	sub    %rdx,%rcx
    9656:	49 89 f2             	mov    %rsi,%r10
    9659:	49 f7 da             	neg    %r10
    965c:	49 01 e2             	add    %rsp,%r10
    965f:	49 83 c2 40          	add    $0x40,%r10
    9663:	4d 01 ca             	add    %r9,%r10
    9666:	49 83 c2 f8          	add    $0xfffffffffffffff8,%r10
    966a:	49 29 d1             	sub    %rdx,%r9
    966d:	66 0f ef c0          	pxor   %xmm0,%xmm0
    9671:	66 66 66 66 66 66 2e 	data16 data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    9678:	0f 1f 84 00 00 00 00 
    967f:	00 
    9680:	f3 41 0f 7e 0a       	movq   (%r10),%xmm1
    9685:	66 0f 60 c8          	punpcklbw %xmm0,%xmm1
    9689:	66 0f 70 c9 4e       	pshufd $0x4e,%xmm1,%xmm1
    968e:	f2 0f 70 c9 1b       	pshuflw $0x1b,%xmm1,%xmm1
    9693:	f3 0f 70 c9 1b       	pshufhw $0x1b,%xmm1,%xmm1
    9698:	66 0f 67 c9          	packuswb %xmm1,%xmm1
    969c:	66 0f d6 4c 34 01    	movq   %xmm1,0x1(%rsp,%rsi,1)
    96a2:	48 83 c6 08          	add    $0x8,%rsi
    96a6:	49 83 c2 f8          	add    $0xfffffffffffffff8,%r10
    96aa:	49 39 f1             	cmp    %rsi,%r9
    96ad:	75 d1                	jne    9680 <fwp_fmt_duration+0x890>
    96af:	48 85 d2             	test   %rdx,%rdx
    96b2:	74 30                	je     96e4 <fwp_fmt_duration+0x8f4>
    96b4:	48 8d 74 24 40       	lea    0x40(%rsp),%rsi
    96b9:	48 01 f2             	add    %rsi,%rdx
    96bc:	48 ff ca             	dec    %rdx
    96bf:	44 89 c6             	mov    %r8d,%esi
    96c2:	66 66 66 66 66 2e 0f 	data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    96c9:	1f 84 00 00 00 00 00 
    96d0:	44 0f b6 02          	movzbl (%rdx),%r8d
    96d4:	44 88 44 0c 01       	mov    %r8b,0x1(%rsp,%rcx,1)
    96d9:	48 ff c1             	inc    %rcx
    96dc:	48 ff ca             	dec    %rdx
    96df:	48 39 ce             	cmp    %rcx,%rsi
    96e2:	75 ec                	jne    96d0 <fwp_fmt_duration+0x8e0>
    96e4:	c6 44 04 01 00       	movb   $0x0,0x1(%rsp,%rax,1)
    96e9:	48 8b 0b             	mov    (%rbx),%rcx
    96ec:	48 8d 35 8e 5f 00 00 	lea    0x5f8e(%rip),%rsi        # f681 <fwp_segv.msg+0x441>
    96f3:	48 89 e2             	mov    %rsp,%rdx
    96f6:	31 c0                	xor    %eax,%eax
    96f8:	e8 83 8b ff ff       	call   2280 <sprintf@plt>
    96fd:	48 81 c4 88 00 00 00 	add    $0x88,%rsp
    9704:	5b                   	pop    %rbx
    9705:	41 5c                	pop    %r12
    9707:	41 5e                	pop    %r14
    9709:	41 5f                	pop    %r15
    970b:	c3                   	ret
    970c:	45 31 c9             	xor    %r9d,%r9d
    970f:	48 f7 de             	neg    %rsi
    9712:	41 ba 00 00 00 00    	mov    $0x0,%r10d
    9718:	4d 19 c2             	sbb    %r8,%r10
    971b:	c6 04 24 2d          	movb   $0x2d,(%rsp)
    971f:	49 bb cd cc cc cc cc 	movabs $0xcccccccccccccccd,%r11
    9726:	cc cc cc 
    9729:	48 bb cc cc cc cc cc 	movabs $0xcccccccccccccccc,%rbx
    9730:	cc cc cc 
    9733:	4d 89 d6             	mov    %r10,%r14
    9736:	66 2e 0f 1f 84 00 00 	cs nopw 0x0(%rax,%rax,1)
    973d:	00 00 00 
    9740:	4c 89 d1             	mov    %r10,%rcx
    9743:	48 0f a4 f1 3f       	shld   $0x3f,%rsi,%rcx
    9748:	49 d1 ee             	shr    $1,%r14
    974b:	49 89 c8             	mov    %rcx,%r8
    974e:	4d 01 f0             	add    %r14,%r8
    9751:	49 83 d0 00          	adc    $0x0,%r8
    9755:	4c 89 c0             	mov    %r8,%rax
    9758:	49 f7 e3             	mul    %r11
    975b:	48 c1 ea 02          	shr    $0x2,%rdx
    975f:	48 8d 04 92          	lea    (%rdx,%rdx,4),%rax
    9763:	49 29 c0             	sub    %rax,%r8
    9766:	4c 29 c1             	sub    %r8,%rcx
    9769:	49 83 de 00          	sbb    $0x0,%r14
    976d:	49 89 c8             	mov    %rcx,%r8
    9770:	4c 0f af c3          	imul   %rbx,%r8
    9774:	48 89 c8             	mov    %rcx,%rax
    9777:	49 f7 e3             	mul    %r11
    977a:	4c 01 c2             	add    %r8,%rdx
    977d:	4d 0f af f3          	imul   %r11,%r14
    9781:	49 01 d6             	add    %rdx,%r14
    9784:	48 89 c1             	mov    %rax,%rcx
    9787:	48 01 c1             	add    %rax,%rcx
    978a:	48 8d 0c 89          	lea    (%rcx,%rcx,4),%rcx
    978e:	89 f2                	mov    %esi,%edx
    9790:	29 ca                	sub    %ecx,%edx
    9792:	80 ca 30             	or     $0x30,%dl
    9795:	42 88 54 0c 40       	mov    %dl,0x40(%rsp,%r9,1)
    979a:	49 ff c1             	inc    %r9
    979d:	48 83 fe 0a          	cmp    $0xa,%rsi
    97a1:	49 83 da 00          	sbb    $0x0,%r10
    97a5:	48 89 c6             	mov    %rax,%rsi
    97a8:	4d 89 f2             	mov    %r14,%r10
    97ab:	73 93                	jae    9740 <fwp_fmt_duration+0x950>
    97ad:	45 85 c9             	test   %r9d,%r9d
    97b0:	7e 13                	jle    97c5 <fwp_fmt_duration+0x9d5>
    97b2:	44 89 c8             	mov    %r9d,%eax
    97b5:	48 83 f8 08          	cmp    $0x8,%rax
    97b9:	73 11                	jae    97cc <fwp_fmt_duration+0x9dc>
    97bb:	31 c9                	xor    %ecx,%ecx
    97bd:	48 89 c2             	mov    %rax,%rdx
    97c0:	e9 29 01 00 00       	jmp    98ee <fwp_fmt_duration+0xafe>
    97c5:	31 c0                	xor    %eax,%eax
    97c7:	e9 48 01 00 00       	jmp    9914 <fwp_fmt_duration+0xb24>
    97cc:	83 f8 20             	cmp    $0x20,%eax
    97cf:	73 07                	jae    97d8 <fwp_fmt_duration+0x9e8>
    97d1:	31 c9                	xor    %ecx,%ecx
    97d3:	e9 b5 00 00 00       	jmp    988d <fwp_fmt_duration+0xa9d>
    97d8:	44 89 ce             	mov    %r9d,%esi
    97db:	44 89 ca             	mov    %r9d,%edx
    97de:	83 e2 1f             	and    $0x1f,%edx
    97e1:	48 89 c1             	mov    %rax,%rcx
    97e4:	48 29 d1             	sub    %rdx,%rcx
    97e7:	4c 8d 04 34          	lea    (%rsp,%rsi,1),%r8
    97eb:	49 83 c0 30          	add    $0x30,%r8
    97ef:	48 29 d6             	sub    %rdx,%rsi
    97f2:	45 31 d2             	xor    %r10d,%r10d
    97f5:	66 0f ef c0          	pxor   %xmm0,%xmm0
    97f9:	f3 41 0f 6f 48 f0    	movdqu -0x10(%r8),%xmm1
    97ff:	f3 41 0f 6f 10       	movdqu (%r8),%xmm2
    9804:	66 0f 6f da          	movdqa %xmm2,%xmm3
    9808:	66 0f 60 d8          	punpcklbw %xmm0,%xmm3
    980c:	66 0f 70 db 4e       	pshufd $0x4e,%xmm3,%xmm3
    9811:	f2 0f 70 db 1b       	pshuflw $0x1b,%xmm3,%xmm3
    9816:	f3 0f 70 db 1b       	pshufhw $0x1b,%xmm3,%xmm3
    981b:	66 0f 68 d0          	punpckhbw %xmm0,%xmm2
    981f:	66 0f 70 d2 4e       	pshufd $0x4e,%xmm2,%xmm2
    9824:	f2 0f 70 d2 1b       	pshuflw $0x1b,%xmm2,%xmm2
    9829:	f3 0f 70 d2 1b       	pshufhw $0x1b,%xmm2,%xmm2
    982e:	66 0f 67 d3          	packuswb %xmm3,%xmm2
    9832:	66 0f 6f d9          	movdqa %xmm1,%xmm3
    9836:	66 0f 60 d8          	punpcklbw %xmm0,%xmm3
    983a:	66 0f 70 db 4e       	pshufd $0x4e,%xmm3,%xmm3
    983f:	f2 0f 70 db 1b       	pshuflw $0x1b,%xmm3,%xmm3
    9844:	f3 0f 70 db 1b       	pshufhw $0x1b,%xmm3,%xmm3
    9849:	66 0f 68 c8          	punpckhbw %xmm0,%xmm1
    984d:	66 0f 70 c9 4e       	pshufd $0x4e,%xmm1,%xmm1
    9852:	f2 0f 70 c9 1b       	pshuflw $0x1b,%xmm1,%xmm1
    9857:	f3 0f 70 c9 1b       	pshufhw $0x1b,%xmm1,%xmm1
    985c:	66 0f 67 cb          	packuswb %xmm3,%xmm1
    9860:	f3 42 0f 7f 54 14 01 	movdqu %xmm2,0x1(%rsp,%r10,1)
    9867:	f3 42 0f 7f 4c 14 11 	movdqu %xmm1,0x11(%rsp,%r10,1)
    986e:	49 83 c2 20          	add    $0x20,%r10
    9872:	49 83 c0 e0          	add    $0xffffffffffffffe0,%r8
    9876:	4c 39 d6             	cmp    %r10,%rsi
    9879:	0f 85 7a ff ff ff    	jne    97f9 <fwp_fmt_duration+0xa09>
    987f:	48 85 d2             	test   %rdx,%rdx
    9882:	0f 84 8c 00 00 00    	je     9914 <fwp_fmt_duration+0xb24>
    9888:	83 fa 08             	cmp    $0x8,%edx
    988b:	72 61                	jb     98ee <fwp_fmt_duration+0xafe>
    988d:	48 89 ce             	mov    %rcx,%rsi
    9890:	45 89 c8             	mov    %r9d,%r8d
    9893:	44 89 ca             	mov    %r9d,%edx
    9896:	83 e2 07             	and    $0x7,%edx
    9899:	48 89 c1             	mov    %rax,%rcx
    989c:	48 29 d1             	sub    %rdx,%rcx
    989f:	49 89 f2             	mov    %rsi,%r10
    98a2:	49 f7 da             	neg    %r10
    98a5:	49 01 e2             	add    %rsp,%r10
    98a8:	49 83 c2 40          	add    $0x40,%r10
    98ac:	4d 01 c2             	add    %r8,%r10
    98af:	49 83 c2 f8          	add    $0xfffffffffffffff8,%r10
    98b3:	49 29 d0             	sub    %rdx,%r8
    98b6:	66 0f ef c0          	pxor   %xmm0,%xmm0
    98ba:	f3 41 0f 7e 0a       	movq   (%r10),%xmm1
    98bf:	66 0f 60 c8          	punpcklbw %xmm0,%xmm1
    98c3:	66 0f 70 c9 4e       	pshufd $0x4e,%xmm1,%xmm1
    98c8:	f2 0f 70 c9 1b       	pshuflw $0x1b,%xmm1,%xmm1
    98cd:	f3 0f 70 c9 1b       	pshufhw $0x1b,%xmm1,%xmm1
    98d2:	66 0f 67 c9          	packuswb %xmm1,%xmm1
    98d6:	66 0f d6 4c 34 01    	movq   %xmm1,0x1(%rsp,%rsi,1)
    98dc:	48 83 c6 08          	add    $0x8,%rsi
    98e0:	49 83 c2 f8          	add    $0xfffffffffffffff8,%r10
    98e4:	49 39 f0             	cmp    %rsi,%r8
    98e7:	75 d1                	jne    98ba <fwp_fmt_duration+0xaca>
    98e9:	48 85 d2             	test   %rdx,%rdx
    98ec:	74 26                	je     9914 <fwp_fmt_duration+0xb24>
    98ee:	48 8d 74 24 40       	lea    0x40(%rsp),%rsi
    98f3:	48 01 f2             	add    %rsi,%rdx
    98f6:	48 ff ca             	dec    %rdx
    98f9:	44 89 ce             	mov    %r9d,%esi
    98fc:	0f 1f 40 00          	nopl   0x0(%rax)
    9900:	44 0f b6 02          	movzbl (%rdx),%r8d
    9904:	44 88 44 0c 01       	mov    %r8b,0x1(%rsp,%rcx,1)
    9909:	48 ff c1             	inc    %rcx
    990c:	48 ff ca             	dec    %rdx
    990f:	48 39 ce             	cmp    %rcx,%rsi
    9912:	75 ec                	jne    9900 <fwp_fmt_duration+0xb10>
    9914:	c6 44 04 01 00       	movb   $0x0,0x1(%rsp,%rax,1)
    9919:	e9 28 f9 ff ff       	jmp    9246 <fwp_fmt_duration+0x456>
    991e:	66 90                	xchg   %ax,%ax

0000000000009920 <fwp_format_g>:
    9920:	55                   	push   %rbp
    9921:	41 57                	push   %r15
    9923:	41 56                	push   %r14
    9925:	41 55                	push   %r13
    9927:	41 54                	push   %r12
    9929:	53                   	push   %rbx
    992a:	48 81 ec 98 00 00 00 	sub    $0x98,%rsp
    9931:	89 f5                	mov    %esi,%ebp
    9933:	48 89 fb             	mov    %rdi,%rbx
    9936:	ff cd                	dec    %ebp
    9938:	48 8d 15 0e 5d 00 00 	lea    0x5d0e(%rip),%rdx        # f64d <fwp_segv.msg+0x40d>
    993f:	4c 8d 64 24 50       	lea    0x50(%rsp),%r12
    9944:	be 40 00 00 00       	mov    $0x40,%esi
    9949:	4c 89 e7             	mov    %r12,%rdi
    994c:	89 e9                	mov    %ebp,%ecx
    994e:	f2 0f 11 44 24 08    	movsd  %xmm0,0x8(%rsp)
    9954:	b0 01                	mov    $0x1,%al
    9956:	e8 b5 87 ff ff       	call   2110 <snprintf@plt>
    995b:	4c 89 e7             	mov    %r12,%rdi
    995e:	be 65 00 00 00       	mov    $0x65,%esi
    9963:	e8 98 87 ff ff       	call   2100 <strchr@plt>
    9968:	49 89 c7             	mov    %rax,%r15
    996b:	48 8d 78 01          	lea    0x1(%rax),%rdi
    996f:	45 31 ed             	xor    %r13d,%r13d
    9972:	31 f6                	xor    %esi,%esi
    9974:	ba 0a 00 00 00       	mov    $0xa,%edx
    9979:	e8 52 88 ff ff       	call   21d0 <strtol@plt>
    997e:	49 89 c6             	mov    %rax,%r14
    9981:	83 c0 ef             	add    $0xffffffef,%eax
    9984:	83 f8 e9             	cmp    $0xffffffe9,%eax
    9987:	77 5f                	ja     99e8 <fwp_format_g+0xc8>
    9989:	4d 29 e7             	sub    %r12,%r15
    998c:	4c 8d 6c 24 10       	lea    0x10(%rsp),%r13
    9991:	4c 89 ef             	mov    %r13,%rdi
    9994:	4c 89 e6             	mov    %r12,%rsi
    9997:	4c 89 fa             	mov    %r15,%rdx
    999a:	e8 41 88 ff ff       	call   21e0 <memcpy@plt>
    999f:	42 c6 44 3c 10 00    	movb   $0x0,0x10(%rsp,%r15,1)
    99a5:	4c 89 ef             	mov    %r13,%rdi
    99a8:	be 2e 00 00 00       	mov    $0x2e,%esi
    99ad:	e8 4e 87 ff ff       	call   2100 <strchr@plt>
    99b2:	48 85 c0             	test   %rax,%rax
    99b5:	0f 84 a8 00 00 00    	je     9a63 <fwp_format_g+0x143>
    99bb:	4d 85 ff             	test   %r15,%r15
    99be:	0f 84 9f 00 00 00    	je     9a63 <fwp_format_g+0x143>
    99c4:	66 66 66 2e 0f 1f 84 	data16 data16 cs nopw 0x0(%rax,%rax,1)
    99cb:	00 00 00 00 00 
    99d0:	42 0f b6 44 3c 0f    	movzbl 0xf(%rsp,%r15,1),%eax
    99d6:	83 f8 30             	cmp    $0x30,%eax
    99d9:	75 7d                	jne    9a58 <fwp_format_g+0x138>
    99db:	42 c6 44 3c 0f 00    	movb   $0x0,0xf(%rsp,%r15,1)
    99e1:	49 ff cf             	dec    %r15
    99e4:	75 ea                	jne    99d0 <fwp_format_g+0xb0>
    99e6:	eb 7b                	jmp    9a63 <fwp_format_g+0x143>
    99e8:	44 29 f5             	sub    %r14d,%ebp
    99eb:	85 ed                	test   %ebp,%ebp
    99ed:	44 0f 4f ed          	cmovg  %ebp,%r13d
    99f1:	48 8d 15 64 5c 00 00 	lea    0x5c64(%rip),%rdx        # f65c <fwp_segv.msg+0x41c>
    99f8:	be 90 01 00 00       	mov    $0x190,%esi
    99fd:	48 89 df             	mov    %rbx,%rdi
    9a00:	44 89 e9             	mov    %r13d,%ecx
    9a03:	f2 0f 10 44 24 08    	movsd  0x8(%rsp),%xmm0
    9a09:	b0 01                	mov    $0x1,%al
    9a0b:	e8 00 87 ff ff       	call   2110 <snprintf@plt>
    9a10:	48 89 df             	mov    %rbx,%rdi
    9a13:	e8 c8 86 ff ff       	call   20e0 <strlen@plt>
    9a18:	49 89 c6             	mov    %rax,%r14
    9a1b:	48 89 df             	mov    %rbx,%rdi
    9a1e:	be 2e 00 00 00       	mov    $0x2e,%esi
    9a23:	e8 d8 86 ff ff       	call   2100 <strchr@plt>
    9a28:	48 85 c0             	test   %rax,%rax
    9a2b:	74 69                	je     9a96 <fwp_format_g+0x176>
    9a2d:	4d 85 f6             	test   %r14,%r14
    9a30:	74 64                	je     9a96 <fwp_format_g+0x176>
    9a32:	66 66 66 66 66 2e 0f 	data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    9a39:	1f 84 00 00 00 00 00 
    9a40:	42 0f b6 44 33 ff    	movzbl -0x1(%rbx,%r14,1),%eax
    9a46:	83 f8 30             	cmp    $0x30,%eax
    9a49:	75 5d                	jne    9aa8 <fwp_format_g+0x188>
    9a4b:	42 c6 44 33 ff 00    	movb   $0x0,-0x1(%rbx,%r14,1)
    9a51:	49 ff ce             	dec    %r14
    9a54:	75 ea                	jne    9a40 <fwp_format_g+0x120>
    9a56:	eb 3e                	jmp    9a96 <fwp_format_g+0x176>
    9a58:	83 f8 2e             	cmp    $0x2e,%eax
    9a5b:	75 06                	jne    9a63 <fwp_format_g+0x143>
    9a5d:	42 c6 44 3c 0f 00    	movb   $0x0,0xf(%rsp,%r15,1)
    9a63:	44 89 f0             	mov    %r14d,%eax
    9a66:	c1 e8 1f             	shr    $0x1f,%eax
    9a69:	44 8d 04 45 2b 00 00 	lea    0x2b(,%rax,2),%r8d
    9a70:	00 
    9a71:	45 89 f1             	mov    %r14d,%r9d
    9a74:	41 f7 d9             	neg    %r9d
    9a77:	45 0f 48 ce          	cmovs  %r14d,%r9d
    9a7b:	48 8d 15 d0 5b 00 00 	lea    0x5bd0(%rip),%rdx        # f652 <fwp_segv.msg+0x412>
    9a82:	48 8d 4c 24 10       	lea    0x10(%rsp),%rcx
    9a87:	be 90 01 00 00       	mov    $0x190,%esi
    9a8c:	48 89 df             	mov    %rbx,%rdi
    9a8f:	31 c0                	xor    %eax,%eax
    9a91:	e8 7a 86 ff ff       	call   2110 <snprintf@plt>
    9a96:	48 81 c4 98 00 00 00 	add    $0x98,%rsp
    9a9d:	5b                   	pop    %rbx
    9a9e:	41 5c                	pop    %r12
    9aa0:	41 5d                	pop    %r13
    9aa2:	41 5e                	pop    %r14
    9aa4:	41 5f                	pop    %r15
    9aa6:	5d                   	pop    %rbp
    9aa7:	c3                   	ret
    9aa8:	83 f8 2e             	cmp    $0x2e,%eax
    9aab:	75 e9                	jne    9a96 <fwp_format_g+0x176>
    9aad:	42 c6 44 33 ff 00    	movb   $0x0,-0x1(%rbx,%r14,1)
    9ab3:	eb e1                	jmp    9a96 <fwp_format_g+0x176>
    9ab5:	66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
    9abc:	00 00 00 00 

0000000000009ac0 <fwp_show_i64>:
    9ac0:	41 57                	push   %r15
    9ac2:	41 56                	push   %r14
    9ac4:	53                   	push   %rbx
    9ac5:	48 83 ec 20          	sub    $0x20,%rsp
    9ac9:	48 be 00 00 00 00 01 	movabs $0x100000000,%rsi
    9ad0:	00 00 00 
    9ad3:	48 89 f9             	mov    %rdi,%rcx
    9ad6:	48 f7 d9             	neg    %rcx
    9ad9:	48 0f 48 cf          	cmovs  %rdi,%rcx
    9add:	48 8d 5c 24 18       	lea    0x18(%rsp),%rbx
    9ae2:	4c 8d 44 24 17       	lea    0x17(%rsp),%r8
    9ae7:	45 31 f6             	xor    %r14d,%r14d
    9aea:	49 b9 cd cc cc cc cc 	movabs $0xcccccccccccccccd,%r9
    9af1:	cc cc cc 
    9af4:	66 66 66 2e 0f 1f 84 	data16 data16 cs nopw 0x0(%rax,%rax,1)
    9afb:	00 00 00 00 00 
    9b00:	48 89 c8             	mov    %rcx,%rax
    9b03:	49 f7 e1             	mul    %r9
    9b06:	48 c1 ea 03          	shr    $0x3,%rdx
    9b0a:	8d 04 12             	lea    (%rdx,%rdx,1),%eax
    9b0d:	8d 04 80             	lea    (%rax,%rax,4),%eax
    9b10:	41 89 ca             	mov    %ecx,%r10d
    9b13:	41 29 c2             	sub    %eax,%r10d
    9b16:	41 80 ca 30          	or     $0x30,%r10b
    9b1a:	45 88 10             	mov    %r10b,(%r8)
    9b1d:	49 01 f6             	add    %rsi,%r14
    9b20:	49 ff c8             	dec    %r8
    9b23:	48 83 f9 09          	cmp    $0x9,%rcx
    9b27:	48 89 d1             	mov    %rdx,%rcx
    9b2a:	77 d4                	ja     9b00 <fwp_show_i64+0x40>
    9b2c:	48 85 ff             	test   %rdi,%rdi
    9b2f:	78 06                	js     9b37 <fwp_show_i64+0x77>
    9b31:	49 c1 fe 20          	sar    $0x20,%r14
    9b35:	eb 11                	jmp    9b48 <fwp_show_i64+0x88>
    9b37:	49 01 f6             	add    %rsi,%r14
    9b3a:	49 c1 fe 20          	sar    $0x20,%r14
    9b3e:	48 89 e0             	mov    %rsp,%rax
    9b41:	4c 29 f0             	sub    %r14,%rax
    9b44:	c6 40 18 2d          	movb   $0x2d,0x18(%rax)
    9b48:	49 8d 56 09          	lea    0x9(%r14),%rdx
    9b4c:	48 81 fa 00 40 00 00 	cmp    $0x4000,%rdx
    9b53:	77 61                	ja     9bb6 <fwp_show_i64+0xf6>
    9b55:	49 8d 4e 18          	lea    0x18(%r14),%rcx
    9b59:	48 c1 e9 04          	shr    $0x4,%rcx
    9b5d:	48 8d 05 1c 86 00 00 	lea    0x861c(%rip),%rax        # 12180 <fwp_gc>
    9b64:	0f b6 b4 01 e8 0b 00 	movzbl 0xbe8(%rcx,%rax,1),%esi
    9b6b:	00 
    9b6c:	8b 8c b0 48 0b 00 00 	mov    0xb48(%rax,%rsi,4),%ecx
    9b73:	48 29 0d 06 86 00 00 	sub    %rcx,0x8606(%rip)        # 12180 <fwp_gc>
    9b7a:	78 3a                	js     9bb6 <fwp_show_i64+0xf6>
    9b7c:	48 8d 34 76          	lea    (%rsi,%rsi,2),%rsi
    9b80:	48 8d 3c f0          	lea    (%rax,%rsi,8),%rdi
    9b84:	48 81 c7 c8 03 00 00 	add    $0x3c8,%rdi
    9b8b:	4c 8b 3f             	mov    (%rdi),%r15
    9b8e:	4d 85 ff             	test   %r15,%r15
    9b91:	74 0b                	je     9b9e <fwp_show_i64+0xde>
    9b93:	49 8b 07             	mov    (%r15),%rax
    9b96:	48 f7 d0             	not    %rax
    9b99:	48 89 07             	mov    %rax,(%rdi)
    9b9c:	eb 3a                	jmp    9bd8 <fwp_show_i64+0x118>
    9b9e:	4c 8b bc f0 d0 03 00 	mov    0x3d0(%rax,%rsi,8),%r15
    9ba5:	00 
    9ba6:	48 8b bc f0 d8 03 00 	mov    0x3d8(%rax,%rsi,8),%rdi
    9bad:	00 
    9bae:	4c 29 ff             	sub    %r15,%rdi
    9bb1:	48 39 cf             	cmp    %rcx,%rdi
    9bb4:	73 12                	jae    9bc8 <fwp_show_i64+0x108>
    9bb6:	48 89 d7             	mov    %rdx,%rdi
    9bb9:	be 01 00 00 00       	mov    $0x1,%esi
    9bbe:	e8 ed ca ff ff       	call   66b0 <fwp_gc_alloc_slow>
    9bc3:	49 89 c7             	mov    %rax,%r15
    9bc6:	eb 1a                	jmp    9be2 <fwp_show_i64+0x122>
    9bc8:	48 8d 04 f0          	lea    (%rax,%rsi,8),%rax
    9bcc:	48 05 d0 03 00 00    	add    $0x3d0,%rax
    9bd2:	4c 01 f9             	add    %r15,%rcx
    9bd5:	48 89 08             	mov    %rcx,(%rax)
    9bd8:	4c 89 ff             	mov    %r15,%rdi
    9bdb:	31 f6                	xor    %esi,%esi
    9bdd:	e8 4e 85 ff ff       	call   2130 <memset@plt>
    9be2:	4c 29 f3             	sub    %r14,%rbx
    9be5:	4d 89 37             	mov    %r14,(%r15)
    9be8:	49 8d 7f 08          	lea    0x8(%r15),%rdi
    9bec:	48 89 de             	mov    %rbx,%rsi
    9bef:	4c 89 f2             	mov    %r14,%rdx
    9bf2:	e8 e9 85 ff ff       	call   21e0 <memcpy@plt>
    9bf7:	43 c6 44 37 08 00    	movb   $0x0,0x8(%r15,%r14,1)
    9bfd:	4c 89 f8             	mov    %r15,%rax
    9c00:	48 83 c4 20          	add    $0x20,%rsp
    9c04:	5b                   	pop    %rbx
    9c05:	41 5e                	pop    %r14
    9c07:	41 5f                	pop    %r15
    9c09:	c3                   	ret
    9c0a:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)

0000000000009c10 <fwp_p_array_get_typed>:
    9c10:	48 85 ff             	test   %rdi,%rdi
    9c13:	78 3e                	js     9c53 <fwp_p_array_get_typed+0x43>
    9c15:	48 8b 0e             	mov    (%rsi),%rcx
    9c18:	48 b8 ff ff ff ff ff 	movabs $0x7fffffffffffffff,%rax
    9c1f:	ff ff 7f 
    9c22:	48 21 c8             	and    %rcx,%rax
    9c25:	48 39 f8             	cmp    %rdi,%rax
    9c28:	76 29                	jbe    9c53 <fwp_p_array_get_typed+0x43>
    9c2a:	b8 08 00 00 00       	mov    $0x8,%eax
    9c2f:	48 85 d2             	test   %rdx,%rdx
    9c32:	74 14                	je     9c48 <fwp_p_array_get_typed+0x38>
    9c34:	44 8b 02             	mov    (%rdx),%r8d
    9c37:	49 83 f8 0a          	cmp    $0xa,%r8
    9c3b:	77 0b                	ja     9c48 <fwp_p_array_get_typed+0x38>
    9c3d:	48 8d 05 74 56 00 00 	lea    0x5674(%rip),%rax        # f2b8 <fwp_segv.msg+0x78>
    9c44:	4a 8b 04 c0          	mov    (%rax,%r8,8),%rax
    9c48:	48 85 c9             	test   %rcx,%rcx
    9c4b:	78 09                	js     9c56 <fwp_p_array_get_typed+0x46>
    9c4d:	48 8d 4e 08          	lea    0x8(%rsi),%rcx
    9c51:	eb 07                	jmp    9c5a <fwp_p_array_get_typed+0x4a>
    9c53:	31 c0                	xor    %eax,%eax
    9c55:	c3                   	ret
    9c56:	48 8b 4e 10          	mov    0x10(%rsi),%rcx
    9c5a:	41 57                	push   %r15
    9c5c:	41 56                	push   %r14
    9c5e:	53                   	push   %rbx
    9c5f:	48 83 ec 10          	sub    $0x10,%rsp
    9c63:	48 0f af f8          	imul   %rax,%rdi
    9c67:	48 83 f8 01          	cmp    $0x1,%rax
    9c6b:	49 89 f6             	mov    %rsi,%r14
    9c6e:	74 1f                	je     9c8f <fwp_p_array_get_typed+0x7f>
    9c70:	48 83 f8 02          	cmp    $0x2,%rax
    9c74:	74 0c                	je     9c82 <fwp_p_array_get_typed+0x72>
    9c76:	48 83 f8 08          	cmp    $0x8,%rax
    9c7a:	75 20                	jne    9c9c <fwp_p_array_get_typed+0x8c>
    9c7c:	48 8b 04 39          	mov    (%rcx,%rdi,1),%rax
    9c80:	eb 27                	jmp    9ca9 <fwp_p_array_get_typed+0x99>
    9c82:	83 3a 01             	cmpl   $0x1,(%rdx)
    9c85:	0f b7 0c 39          	movzwl (%rcx,%rdi,1),%ecx
    9c89:	48 0f bf c1          	movswq %cx,%rax
    9c8d:	eb 16                	jmp    9ca5 <fwp_p_array_get_typed+0x95>
    9c8f:	83 3a 00             	cmpl   $0x0,(%rdx)
    9c92:	0f b6 0c 39          	movzbl (%rcx,%rdi,1),%ecx
    9c96:	48 0f be c1          	movsbq %cl,%rax
    9c9a:	eb 09                	jmp    9ca5 <fwp_p_array_get_typed+0x95>
    9c9c:	83 3a 02             	cmpl   $0x2,(%rdx)
    9c9f:	8b 0c 39             	mov    (%rcx,%rdi,1),%ecx
    9ca2:	48 63 c1             	movslq %ecx,%rax
    9ca5:	48 0f 45 c1          	cmovne %rcx,%rax
    9ca9:	48 89 44 24 08       	mov    %rax,0x8(%rsp)
    9cae:	48 8d 54 24 08       	lea    0x8(%rsp),%rdx
    9cb3:	bf 01 00 00 00       	mov    $0x1,%edi
    9cb8:	be 01 00 00 00       	mov    $0x1,%esi
    9cbd:	e8 9e 00 00 00       	call   9d60 <fwp_data>
    9cc2:	48 89 c2             	mov    %rax,%rdx
    9cc5:	48 2b 15 e4 94 00 00 	sub    0x94e4(%rip),%rdx        # 131b0 <fwp_gc+0x1030>
    9ccc:	48 8b 0d 05 95 00 00 	mov    0x9505(%rip),%rcx        # 131d8 <fwp_gc+0x1058>
    9cd3:	48 c1 e1 10          	shl    $0x10,%rcx
    9cd7:	48 39 ca             	cmp    %rcx,%rdx
    9cda:	4c 89 f1             	mov    %r14,%rcx
    9cdd:	73 77                	jae    9d56 <fwp_p_array_get_typed+0x146>
    9cdf:	48 8b 35 12 95 00 00 	mov    0x9512(%rip),%rsi        # 131f8 <fwp_gc+0x1078>
    9ce6:	48 89 d7             	mov    %rdx,%rdi
    9ce9:	48 c1 ef 10          	shr    $0x10,%rdi
    9ced:	48 69 ff 28 12 00 00 	imul   $0x1228,%rdi,%rdi
    9cf4:	44 0f b6 04 3e       	movzbl (%rsi,%rdi,1),%r8d
    9cf9:	48 81 e2 ff ff 00 00 	and    $0xffff,%rdx
    9d00:	75 1b                	jne    9d1d <fwp_p_array_get_typed+0x10d>
    9d02:	41 80 f8 02          	cmp    $0x2,%r8b
    9d06:	75 15                	jne    9d1d <fwp_p_array_get_typed+0x10d>
    9d08:	48 8d 1c 3e          	lea    (%rsi,%rdi,1),%rbx
    9d0c:	48 81 c3 28 02 00 00 	add    $0x228,%rbx
    9d13:	80 3b ff             	cmpb   $0xff,(%rbx)
    9d16:	74 2b                	je     9d43 <fwp_p_array_get_typed+0x133>
    9d18:	c6 03 01             	movb   $0x1,(%rbx)
    9d1b:	eb 39                	jmp    9d56 <fwp_p_array_get_typed+0x146>
    9d1d:	41 80 f8 01          	cmp    $0x1,%r8b
    9d21:	75 33                	jne    9d56 <fwp_p_array_get_typed+0x146>
    9d23:	4c 8d 04 3e          	lea    (%rsi,%rdi,1),%r8
    9d27:	8b 74 3e 20          	mov    0x20(%rsi,%rdi,1),%esi
    9d2b:	48 0f af d6          	imul   %rsi,%rdx
    9d2f:	48 c1 ea 20          	shr    $0x20,%rdx
    9d33:	4a 8d 1c 02          	lea    (%rdx,%r8,1),%rbx
    9d37:	48 81 c3 28 02 00 00 	add    $0x228,%rbx
    9d3e:	80 3b ff             	cmpb   $0xff,(%rbx)
    9d41:	75 d5                	jne    9d18 <fwp_p_array_get_typed+0x108>
    9d43:	48 89 df             	mov    %rbx,%rdi
    9d46:	49 89 c7             	mov    %rax,%r15
    9d49:	e8 42 c5 ff ff       	call   6290 <fwp_rc_forget_slot>
    9d4e:	4c 89 f8             	mov    %r15,%rax
    9d51:	4c 89 f1             	mov    %r14,%rcx
    9d54:	eb c2                	jmp    9d18 <fwp_p_array_get_typed+0x108>
    9d56:	48 83 c4 10          	add    $0x10,%rsp
    9d5a:	5b                   	pop    %rbx
    9d5b:	41 5e                	pop    %r14
    9d5d:	41 5f                	pop    %r15
    9d5f:	c3                   	ret

0000000000009d60 <fwp_data>:
    9d60:	55                   	push   %rbp
    9d61:	41 57                	push   %r15
    9d63:	41 56                	push   %r14
    9d65:	41 55                	push   %r13
    9d67:	41 54                	push   %r12
    9d69:	53                   	push   %rbx
    9d6a:	50                   	push   %rax
    9d6b:	48 89 d3             	mov    %rdx,%rbx
    9d6e:	89 f5                	mov    %esi,%ebp
    9d70:	41 89 ff             	mov    %edi,%r15d
    9d73:	41 89 f4             	mov    %esi,%r12d
    9d76:	4e 8d 2c e5 00 00 00 	lea    0x0(,%r12,8),%r13
    9d7d:	00 
    9d7e:	4a 8d 3c e5 08 00 00 	lea    0x8(,%r12,8),%rdi
    9d85:	00 
    9d86:	81 fe ff 07 00 00    	cmp    $0x7ff,%esi
    9d8c:	0f 87 e6 00 00 00    	ja     9e78 <fwp_data+0x118>
    9d92:	49 8d 75 17          	lea    0x17(%r13),%rsi
    9d96:	48 c1 ee 04          	shr    $0x4,%rsi
    9d9a:	48 8d 05 df 83 00 00 	lea    0x83df(%rip),%rax        # 12180 <fwp_gc>
    9da1:	0f b6 8c 06 e8 0b 00 	movzbl 0xbe8(%rsi,%rax,1),%ecx
    9da8:	00 
    9da9:	8b 94 88 48 0b 00 00 	mov    0xb48(%rax,%rcx,4),%edx
    9db0:	4c 8b 05 c9 83 00 00 	mov    0x83c9(%rip),%r8        # 12180 <fwp_gc>
    9db7:	4d 89 c1             	mov    %r8,%r9
    9dba:	49 29 d1             	sub    %rdx,%r9
    9dbd:	4c 89 0d bc 83 00 00 	mov    %r9,0x83bc(%rip)        # 12180 <fwp_gc>
    9dc4:	0f 88 ae 00 00 00    	js     9e78 <fwp_data+0x118>
    9dca:	4c 8d 0c 49          	lea    (%rcx,%rcx,2),%r9
    9dce:	4e 8d 14 c8          	lea    (%rax,%r9,8),%r10
    9dd2:	49 83 c2 08          	add    $0x8,%r10
    9dd6:	4d 8b 32             	mov    (%r10),%r14
    9dd9:	4d 85 f6             	test   %r14,%r14
    9ddc:	74 29                	je     9e07 <fwp_data+0xa7>
    9dde:	49 8b 06             	mov    (%r14),%rax
    9de1:	48 f7 d0             	not    %rax
    9de4:	49 89 02             	mov    %rax,(%r10)
    9de7:	48 39 d7             	cmp    %rdx,%rdi
    9dea:	0f 83 ad 00 00 00    	jae    9e9d <fwp_data+0x13d>
    9df0:	4c 01 f7             	add    %r14,%rdi
    9df3:	4c 29 ea             	sub    %r13,%rdx
    9df6:	48 83 c2 f7          	add    $0xfffffffffffffff7,%rdx
    9dfa:	48 83 e2 f8          	and    $0xfffffffffffffff8,%rdx
    9dfe:	48 83 c2 08          	add    $0x8,%rdx
    9e02:	e9 8f 00 00 00       	jmp    9e96 <fwp_data+0x136>
    9e07:	4e 8b 74 c8 10       	mov    0x10(%rax,%r9,8),%r14
    9e0c:	4e 8b 54 c8 18       	mov    0x18(%rax,%r9,8),%r10
    9e11:	4d 29 f2             	sub    %r14,%r10
    9e14:	49 39 d2             	cmp    %rdx,%r10
    9e17:	72 2f                	jb     9e48 <fwp_data+0xe8>
    9e19:	4a 8d 0c c8          	lea    (%rax,%r9,8),%rcx
    9e1d:	48 83 c1 10          	add    $0x10,%rcx
    9e21:	4d 8d 0c 16          	lea    (%r14,%rdx,1),%r9
    9e25:	4c 89 09             	mov    %r9,(%rcx)
    9e28:	4d 85 f6             	test   %r14,%r14
    9e2b:	75 ba                	jne    9de7 <fwp_data+0x87>
    9e2d:	0f b6 8c 06 e8 0b 00 	movzbl 0xbe8(%rsi,%rax,1),%ecx
    9e34:	00 
    9e35:	8b 94 88 48 0b 00 00 	mov    0xb48(%rax,%rcx,4),%edx
    9e3c:	49 29 d0             	sub    %rdx,%r8
    9e3f:	4c 89 05 3a 83 00 00 	mov    %r8,0x833a(%rip)        # 12180 <fwp_gc>
    9e46:	78 30                	js     9e78 <fwp_data+0x118>
    9e48:	48 8d 0c 49          	lea    (%rcx,%rcx,2),%rcx
    9e4c:	4c 8b 74 c8 08       	mov    0x8(%rax,%rcx,8),%r14
    9e51:	4d 85 f6             	test   %r14,%r14
    9e54:	74 10                	je     9e66 <fwp_data+0x106>
    9e56:	48 8d 04 c8          	lea    (%rax,%rcx,8),%rax
    9e5a:	48 83 c0 08          	add    $0x8,%rax
    9e5e:	49 8b 0e             	mov    (%r14),%rcx
    9e61:	48 f7 d1             	not    %rcx
    9e64:	eb 2a                	jmp    9e90 <fwp_data+0x130>
    9e66:	4c 8b 74 c8 10       	mov    0x10(%rax,%rcx,8),%r14
    9e6b:	48 8b 74 c8 18       	mov    0x18(%rax,%rcx,8),%rsi
    9e70:	4c 29 f6             	sub    %r14,%rsi
    9e73:	48 39 d6             	cmp    %rdx,%rsi
    9e76:	73 0c                	jae    9e84 <fwp_data+0x124>
    9e78:	31 f6                	xor    %esi,%esi
    9e7a:	e8 31 c8 ff ff       	call   66b0 <fwp_gc_alloc_slow>
    9e7f:	49 89 c6             	mov    %rax,%r14
    9e82:	eb 19                	jmp    9e9d <fwp_data+0x13d>
    9e84:	48 8d 04 c8          	lea    (%rax,%rcx,8),%rax
    9e88:	48 83 c0 10          	add    $0x10,%rax
    9e8c:	49 8d 0c 16          	lea    (%r14,%rdx,1),%rcx
    9e90:	48 89 08             	mov    %rcx,(%rax)
    9e93:	4c 89 f7             	mov    %r14,%rdi
    9e96:	31 f6                	xor    %esi,%esi
    9e98:	e8 93 82 ff ff       	call   2130 <memset@plt>
    9e9d:	45 89 3e             	mov    %r15d,(%r14)
    9ea0:	41 89 6e 04          	mov    %ebp,0x4(%r14)
    9ea4:	85 ed                	test   %ebp,%ebp
    9ea6:	0f 84 bb 00 00 00    	je     9f67 <fwp_data+0x207>
    9eac:	83 fd 08             	cmp    $0x8,%ebp
    9eaf:	72 10                	jb     9ec1 <fwp_data+0x161>
    9eb1:	4c 89 f0             	mov    %r14,%rax
    9eb4:	48 29 d8             	sub    %rbx,%rax
    9eb7:	48 83 c0 08          	add    $0x8,%rax
    9ebb:	48 83 f8 20          	cmp    $0x20,%rax
    9ebf:	73 71                	jae    9f32 <fwp_data+0x1d2>
    9ec1:	31 c0                	xor    %eax,%eax
    9ec3:	4c 89 e2             	mov    %r12,%rdx
    9ec6:	48 89 c1             	mov    %rax,%rcx
    9ec9:	48 83 e2 03          	and    $0x3,%rdx
    9ecd:	74 22                	je     9ef1 <fwp_data+0x191>
    9ecf:	48 89 c1             	mov    %rax,%rcx
    9ed2:	66 66 66 66 66 2e 0f 	data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    9ed9:	1f 84 00 00 00 00 00 
    9ee0:	48 8b 34 cb          	mov    (%rbx,%rcx,8),%rsi
    9ee4:	49 89 74 ce 08       	mov    %rsi,0x8(%r14,%rcx,8)
    9ee9:	48 ff c1             	inc    %rcx
    9eec:	48 ff ca             	dec    %rdx
    9eef:	75 ef                	jne    9ee0 <fwp_data+0x180>
    9ef1:	4c 29 e0             	sub    %r12,%rax
    9ef4:	48 83 f8 fc          	cmp    $0xfffffffffffffffc,%rax
    9ef8:	77 6d                	ja     9f67 <fwp_data+0x207>
    9efa:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)
    9f00:	48 8b 04 cb          	mov    (%rbx,%rcx,8),%rax
    9f04:	49 89 44 ce 08       	mov    %rax,0x8(%r14,%rcx,8)
    9f09:	48 8b 44 cb 08       	mov    0x8(%rbx,%rcx,8),%rax
    9f0e:	49 89 44 ce 10       	mov    %rax,0x10(%r14,%rcx,8)
    9f13:	48 8b 44 cb 10       	mov    0x10(%rbx,%rcx,8),%rax
    9f18:	49 89 44 ce 18       	mov    %rax,0x18(%r14,%rcx,8)
    9f1d:	48 8b 44 cb 18       	mov    0x18(%rbx,%rcx,8),%rax
    9f22:	49 89 44 ce 20       	mov    %rax,0x20(%r14,%rcx,8)
    9f27:	48 83 c1 04          	add    $0x4,%rcx
    9f2b:	49 39 cc             	cmp    %rcx,%r12
    9f2e:	75 d0                	jne    9f00 <fwp_data+0x1a0>
    9f30:	eb 35                	jmp    9f67 <fwp_data+0x207>
    9f32:	44 89 e0             	mov    %r12d,%eax
    9f35:	83 e0 fc             	and    $0xfffffffc,%eax
    9f38:	49 83 e5 e0          	and    $0xffffffffffffffe0,%r13
    9f3c:	31 c9                	xor    %ecx,%ecx
    9f3e:	66 90                	xchg   %ax,%ax
    9f40:	0f 10 04 0b          	movups (%rbx,%rcx,1),%xmm0
    9f44:	0f 10 4c 0b 10       	movups 0x10(%rbx,%rcx,1),%xmm1
    9f49:	41 0f 11 44 0e 08    	movups %xmm0,0x8(%r14,%rcx,1)
    9f4f:	41 0f 11 4c 0e 18    	movups %xmm1,0x18(%r14,%rcx,1)
    9f55:	48 83 c1 20          	add    $0x20,%rcx
    9f59:	49 39 cd             	cmp    %rcx,%r13
    9f5c:	75 e2                	jne    9f40 <fwp_data+0x1e0>
    9f5e:	4c 39 e0             	cmp    %r12,%rax
    9f61:	0f 85 5c ff ff ff    	jne    9ec3 <fwp_data+0x163>
    9f67:	4c 89 f0             	mov    %r14,%rax
    9f6a:	48 83 c4 08          	add    $0x8,%rsp
    9f6e:	5b                   	pop    %rbx
    9f6f:	41 5c                	pop    %r12
    9f71:	41 5d                	pop    %r13
    9f73:	41 5e                	pop    %r14
    9f75:	41 5f                	pop    %r15
    9f77:	5d                   	pop    %rbp
    9f78:	c3                   	ret
    9f79:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)

0000000000009f80 <f49>:
    9f80:	41 57                	push   %r15
    9f82:	41 56                	push   %r14
    9f84:	53                   	push   %rbx
    9f85:	48 83 ec 30          	sub    $0x30,%rsp
    9f89:	48 89 fb             	mov    %rdi,%rbx
    9f8c:	48 8b 47 10          	mov    0x10(%rdi),%rax
    9f90:	48 2b 05 19 92 00 00 	sub    0x9219(%rip),%rax        # 131b0 <fwp_gc+0x1030>
    9f97:	48 8b 0d 3a 92 00 00 	mov    0x923a(%rip),%rcx        # 131d8 <fwp_gc+0x1058>
    9f9e:	48 c1 e1 10          	shl    $0x10,%rcx
    9fa2:	48 39 c8             	cmp    %rcx,%rax
    9fa5:	73 68                	jae    a00f <f49+0x8f>
    9fa7:	48 8b 0d 4a 92 00 00 	mov    0x924a(%rip),%rcx        # 131f8 <fwp_gc+0x1078>
    9fae:	48 89 c2             	mov    %rax,%rdx
    9fb1:	48 c1 ea 10          	shr    $0x10,%rdx
    9fb5:	48 69 d2 28 12 00 00 	imul   $0x1228,%rdx,%rdx
    9fbc:	0f b6 34 11          	movzbl (%rcx,%rdx,1),%esi
    9fc0:	48 25 ff ff 00 00    	and    $0xffff,%rax
    9fc6:	75 13                	jne    9fdb <f49+0x5b>
    9fc8:	40 80 fe 02          	cmp    $0x2,%sil
    9fcc:	75 0d                	jne    9fdb <f49+0x5b>
    9fce:	48 8d 3c 11          	lea    (%rcx,%rdx,1),%rdi
    9fd2:	48 81 c7 28 02 00 00 	add    $0x228,%rdi
    9fd9:	eb 21                	jmp    9ffc <f49+0x7c>
    9fdb:	40 80 fe 01          	cmp    $0x1,%sil
    9fdf:	75 2e                	jne    a00f <f49+0x8f>
    9fe1:	48 8d 34 11          	lea    (%rcx,%rdx,1),%rsi
    9fe5:	8b 4c 11 20          	mov    0x20(%rcx,%rdx,1),%ecx
    9fe9:	48 0f af c1          	imul   %rcx,%rax
    9fed:	48 c1 e8 20          	shr    $0x20,%rax
    9ff1:	48 8d 3c 30          	lea    (%rax,%rsi,1),%rdi
    9ff5:	48 81 c7 28 02 00 00 	add    $0x228,%rdi
    9ffc:	0f b6 07             	movzbl (%rdi),%eax
    9fff:	84 c0                	test   %al,%al
    a001:	74 0c                	je     a00f <f49+0x8f>
    a003:	3c fe                	cmp    $0xfe,%al
    a005:	0f 83 d8 01 00 00    	jae    a1e3 <f49+0x263>
    a00b:	fe c0                	inc    %al
    a00d:	88 07                	mov    %al,(%rdi)
    a00f:	4c 8b 7b 08          	mov    0x8(%rbx),%r15
    a013:	48 8b 7b 10          	mov    0x10(%rbx),%rdi
    a017:	4c 8b 73 18          	mov    0x18(%rbx),%r14
    a01b:	4d 85 ff             	test   %r15,%r15
    a01e:	78 20                	js     a040 <f49+0xc0>
    a020:	48 8b 07             	mov    (%rdi),%rax
    a023:	48 b9 ff ff ff ff ff 	movabs $0x7fffffffffffffff,%rcx
    a02a:	ff ff 7f 
    a02d:	48 21 c1             	and    %rax,%rcx
    a030:	4c 39 f9             	cmp    %r15,%rcx
    a033:	76 0b                	jbe    a040 <f49+0xc0>
    a035:	48 85 c0             	test   %rax,%rax
    a038:	78 2e                	js     a068 <f49+0xe8>
    a03a:	48 8d 47 08          	lea    0x8(%rdi),%rax
    a03e:	eb 2c                	jmp    a06c <f49+0xec>
    a040:	e8 8b 03 00 00       	call   a3d0 <fwp_drop1>
    a045:	41 bf 01 00 00 00    	mov    $0x1,%r15d
    a04b:	48 89 df             	mov    %rbx,%rdi
    a04e:	e8 ad 01 00 00       	call   a200 <fwp_drop6>
    a053:	4c 89 ff             	mov    %r15,%rdi
    a056:	4c 89 f6             	mov    %r14,%rsi
    a059:	e8 52 02 00 00       	call   a2b0 <fwp_vbox1>
    a05e:	48 83 c4 30          	add    $0x30,%rsp
    a062:	5b                   	pop    %rbx
    a063:	41 5e                	pop    %r14
    a065:	41 5f                	pop    %r15
    a067:	c3                   	ret
    a068:	48 8b 47 10          	mov    0x10(%rdi),%rax
    a06c:	4c 89 74 24 08       	mov    %r14,0x8(%rsp)
    a071:	f2 42 0f 10 04 f8    	movsd  (%rax,%r15,8),%xmm0
    a077:	f2 0f 59 05 91 4f 00 	mulsd  0x4f91(%rip),%xmm0        # f010 <_IO_stdin_used+0x10>
    a07e:	00 
    a07f:	f2 0f 58 05 91 4f 00 	addsd  0x4f91(%rip),%xmm0        # f018 <_IO_stdin_used+0x18>
    a086:	00 
    a087:	f2 0f 11 44 24 10    	movsd  %xmm0,0x10(%rsp)
    a08d:	48 89 f8             	mov    %rdi,%rax
    a090:	48 2b 05 19 91 00 00 	sub    0x9119(%rip),%rax        # 131b0 <fwp_gc+0x1030>
    a097:	49 ff c7             	inc    %r15
    a09a:	48 8b 0d 37 91 00 00 	mov    0x9137(%rip),%rcx        # 131d8 <fwp_gc+0x1058>
    a0a1:	48 c1 e1 10          	shl    $0x10,%rcx
    a0a5:	48 39 c8             	cmp    %rcx,%rax
    a0a8:	73 66                	jae    a110 <f49+0x190>
    a0aa:	48 8b 0d 47 91 00 00 	mov    0x9147(%rip),%rcx        # 131f8 <fwp_gc+0x1078>
    a0b1:	48 89 c2             	mov    %rax,%rdx
    a0b4:	48 c1 ea 10          	shr    $0x10,%rdx
    a0b8:	48 69 d2 28 12 00 00 	imul   $0x1228,%rdx,%rdx
    a0bf:	0f b6 34 11          	movzbl (%rcx,%rdx,1),%esi
    a0c3:	48 25 ff ff 00 00    	and    $0xffff,%rax
    a0c9:	75 12                	jne    a0dd <f49+0x15d>
    a0cb:	40 80 fe 02          	cmp    $0x2,%sil
    a0cf:	75 0c                	jne    a0dd <f49+0x15d>
    a0d1:	48 8d 04 11          	lea    (%rcx,%rdx,1),%rax
    a0d5:	48 05 28 02 00 00    	add    $0x228,%rax
    a0db:	eb 1f                	jmp    a0fc <f49+0x17c>
    a0dd:	40 80 fe 01          	cmp    $0x1,%sil
    a0e1:	75 2d                	jne    a110 <f49+0x190>
    a0e3:	48 8d 34 11          	lea    (%rcx,%rdx,1),%rsi
    a0e7:	8b 4c 11 20          	mov    0x20(%rcx,%rdx,1),%ecx
    a0eb:	48 0f af c1          	imul   %rcx,%rax
    a0ef:	48 c1 e8 20          	shr    $0x20,%rax
    a0f3:	48 01 f0             	add    %rsi,%rax
    a0f6:	48 05 28 02 00 00    	add    $0x228,%rax
    a0fc:	0f b6 08             	movzbl (%rax),%ecx
    a0ff:	84 c9                	test   %cl,%cl
    a101:	74 0d                	je     a110 <f49+0x190>
    a103:	80 f9 fe             	cmp    $0xfe,%cl
    a106:	0f 83 e1 00 00 00    	jae    a1ed <f49+0x26d>
    a10c:	fe c1                	inc    %cl
    a10e:	88 08                	mov    %cl,(%rax)
    a110:	49 89 fe             	mov    %rdi,%r14
    a113:	e8 b8 02 00 00       	call   a3d0 <fwp_drop1>
    a118:	f2 0f 10 44 24 10    	movsd  0x10(%rsp),%xmm0
    a11e:	f2 0f 58 44 24 08    	addsd  0x8(%rsp),%xmm0
    a124:	4c 89 7c 24 18       	mov    %r15,0x18(%rsp)
    a129:	4c 89 74 24 20       	mov    %r14,0x20(%rsp)
    a12e:	f2 0f 11 44 24 28    	movsd  %xmm0,0x28(%rsp)
    a134:	45 31 ff             	xor    %r15d,%r15d
    a137:	48 8d 54 24 18       	lea    0x18(%rsp),%rdx
    a13c:	31 ff                	xor    %edi,%edi
    a13e:	be 03 00 00 00       	mov    $0x3,%esi
    a143:	e8 18 fc ff ff       	call   9d60 <fwp_data>
    a148:	49 89 c6             	mov    %rax,%r14
    a14b:	48 2b 05 5e 90 00 00 	sub    0x905e(%rip),%rax        # 131b0 <fwp_gc+0x1030>
    a152:	48 8b 0d 7f 90 00 00 	mov    0x907f(%rip),%rcx        # 131d8 <fwp_gc+0x1058>
    a159:	48 c1 e1 10          	shl    $0x10,%rcx
    a15d:	48 39 c8             	cmp    %rcx,%rax
    a160:	0f 83 e5 fe ff ff    	jae    a04b <f49+0xcb>
    a166:	48 8b 0d 8b 90 00 00 	mov    0x908b(%rip),%rcx        # 131f8 <fwp_gc+0x1078>
    a16d:	48 89 c2             	mov    %rax,%rdx
    a170:	48 c1 ea 10          	shr    $0x10,%rdx
    a174:	48 69 d2 28 12 00 00 	imul   $0x1228,%rdx,%rdx
    a17b:	0f b6 34 11          	movzbl (%rcx,%rdx,1),%esi
    a17f:	48 25 ff ff 00 00    	and    $0xffff,%rax
    a185:	75 23                	jne    a1aa <f49+0x22a>
    a187:	40 80 fe 02          	cmp    $0x2,%sil
    a18b:	75 1d                	jne    a1aa <f49+0x22a>
    a18d:	4c 8d 3c 11          	lea    (%rcx,%rdx,1),%r15
    a191:	49 81 c7 28 02 00 00 	add    $0x228,%r15
    a198:	41 80 3f ff          	cmpb   $0xff,(%r15)
    a19c:	74 33                	je     a1d1 <f49+0x251>
    a19e:	41 c6 07 01          	movb   $0x1,(%r15)
    a1a2:	45 31 ff             	xor    %r15d,%r15d
    a1a5:	e9 a1 fe ff ff       	jmp    a04b <f49+0xcb>
    a1aa:	40 80 fe 01          	cmp    $0x1,%sil
    a1ae:	75 2b                	jne    a1db <f49+0x25b>
    a1b0:	48 8d 34 11          	lea    (%rcx,%rdx,1),%rsi
    a1b4:	8b 4c 11 20          	mov    0x20(%rcx,%rdx,1),%ecx
    a1b8:	48 0f af c1          	imul   %rcx,%rax
    a1bc:	48 c1 e8 20          	shr    $0x20,%rax
    a1c0:	4c 8d 3c 30          	lea    (%rax,%rsi,1),%r15
    a1c4:	49 81 c7 28 02 00 00 	add    $0x228,%r15
    a1cb:	41 80 3f ff          	cmpb   $0xff,(%r15)
    a1cf:	75 cd                	jne    a19e <f49+0x21e>
    a1d1:	4c 89 ff             	mov    %r15,%rdi
    a1d4:	e8 b7 c0 ff ff       	call   6290 <fwp_rc_forget_slot>
    a1d9:	eb c3                	jmp    a19e <f49+0x21e>
    a1db:	45 31 ff             	xor    %r15d,%r15d
    a1de:	e9 68 fe ff ff       	jmp    a04b <f49+0xcb>
    a1e3:	e8 88 d3 ff ff       	call   7570 <fwp_rc_wide_dup>
    a1e8:	e9 22 fe ff ff       	jmp    a00f <f49+0x8f>
    a1ed:	49 89 fe             	mov    %rdi,%r14
    a1f0:	48 89 c7             	mov    %rax,%rdi
    a1f3:	e8 78 d3 ff ff       	call   7570 <fwp_rc_wide_dup>
    a1f8:	4c 89 f7             	mov    %r14,%rdi
    a1fb:	e9 10 ff ff ff       	jmp    a110 <f49+0x190>

000000000000a200 <fwp_drop6>:
    a200:	48 89 f8             	mov    %rdi,%rax
    a203:	48 2b 05 a6 8f 00 00 	sub    0x8fa6(%rip),%rax        # 131b0 <fwp_gc+0x1030>
    a20a:	48 8b 0d c7 8f 00 00 	mov    0x8fc7(%rip),%rcx        # 131d8 <fwp_gc+0x1058>
    a211:	48 c1 e1 10          	shl    $0x10,%rcx
    a215:	48 39 c8             	cmp    %rcx,%rax
    a218:	0f 83 83 00 00 00    	jae    a2a1 <fwp_drop6+0xa1>
    a21e:	48 8b 0d d3 8f 00 00 	mov    0x8fd3(%rip),%rcx        # 131f8 <fwp_gc+0x1078>
    a225:	48 89 c2             	mov    %rax,%rdx
    a228:	48 c1 ea 10          	shr    $0x10,%rdx
    a22c:	48 69 d2 28 12 00 00 	imul   $0x1228,%rdx,%rdx
    a233:	0f b6 34 11          	movzbl (%rcx,%rdx,1),%esi
    a237:	48 25 ff ff 00 00    	and    $0xffff,%rax
    a23d:	75 12                	jne    a251 <fwp_drop6+0x51>
    a23f:	40 80 fe 02          	cmp    $0x2,%sil
    a243:	75 0c                	jne    a251 <fwp_drop6+0x51>
    a245:	48 8d 04 11          	lea    (%rcx,%rdx,1),%rax
    a249:	48 05 28 02 00 00    	add    $0x228,%rax
    a24f:	eb 1f                	jmp    a270 <fwp_drop6+0x70>
    a251:	40 80 fe 01          	cmp    $0x1,%sil
    a255:	75 4a                	jne    a2a1 <fwp_drop6+0xa1>
    a257:	48 8d 34 11          	lea    (%rcx,%rdx,1),%rsi
    a25b:	8b 4c 11 20          	mov    0x20(%rcx,%rdx,1),%ecx
    a25f:	48 0f af c1          	imul   %rcx,%rax
    a263:	48 c1 e8 20          	shr    $0x20,%rax
    a267:	48 01 f0             	add    %rsi,%rax
    a26a:	48 05 28 02 00 00    	add    $0x228,%rax
    a270:	0f b6 08             	movzbl (%rax),%ecx
    a273:	85 c9                	test   %ecx,%ecx
    a275:	74 2a                	je     a2a1 <fwp_drop6+0xa1>
    a277:	83 f9 01             	cmp    $0x1,%ecx
    a27a:	75 19                	jne    a295 <fwp_drop6+0x95>
    a27c:	53                   	push   %rbx
    a27d:	48 8b 47 10          	mov    0x10(%rdi),%rax
    a281:	48 89 fb             	mov    %rdi,%rbx
    a284:	48 89 c7             	mov    %rax,%rdi
    a287:	e8 44 01 00 00       	call   a3d0 <fwp_drop1>
    a28c:	48 89 df             	mov    %rbx,%rdi
    a28f:	5b                   	pop    %rbx
    a290:	e9 0b 06 00 00       	jmp    a8a0 <fwp_rc_free_obj>
    a295:	81 f9 ff 00 00 00    	cmp    $0xff,%ecx
    a29b:	74 05                	je     a2a2 <fwp_drop6+0xa2>
    a29d:	fe c9                	dec    %cl
    a29f:	88 08                	mov    %cl,(%rax)
    a2a1:	c3                   	ret
    a2a2:	48 89 c7             	mov    %rax,%rdi
    a2a5:	e9 16 03 00 00       	jmp    a5c0 <fwp_rc_wide_drop>
    a2aa:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)

000000000000a2b0 <fwp_vbox1>:
    a2b0:	41 56                	push   %r14
    a2b2:	53                   	push   %rbx
    a2b3:	48 83 ec 18          	sub    $0x18,%rsp
    a2b7:	48 89 7c 24 08       	mov    %rdi,0x8(%rsp)
    a2bc:	48 8d 54 24 10       	lea    0x10(%rsp),%rdx
    a2c1:	48 89 74 24 10       	mov    %rsi,0x10(%rsp)
    a2c6:	83 ff 01             	cmp    $0x1,%edi
    a2c9:	74 5c                	je     a327 <fwp_vbox1+0x77>
    a2cb:	85 ff                	test   %edi,%edi
    a2cd:	0f 85 ba 00 00 00    	jne    a38d <fwp_vbox1+0xdd>
    a2d3:	31 ff                	xor    %edi,%edi
    a2d5:	be 01 00 00 00       	mov    $0x1,%esi
    a2da:	e8 81 fa ff ff       	call   9d60 <fwp_data>
    a2df:	48 89 c1             	mov    %rax,%rcx
    a2e2:	48 2b 0d c7 8e 00 00 	sub    0x8ec7(%rip),%rcx        # 131b0 <fwp_gc+0x1030>
    a2e9:	48 8b 15 e8 8e 00 00 	mov    0x8ee8(%rip),%rdx        # 131d8 <fwp_gc+0x1058>
    a2f0:	48 c1 e2 10          	shl    $0x10,%rdx
    a2f4:	48 39 d1             	cmp    %rdx,%rcx
    a2f7:	0f 83 ca 00 00 00    	jae    a3c7 <fwp_vbox1+0x117>
    a2fd:	48 8b 15 f4 8e 00 00 	mov    0x8ef4(%rip),%rdx        # 131f8 <fwp_gc+0x1078>
    a304:	48 89 ce             	mov    %rcx,%rsi
    a307:	48 c1 ee 10          	shr    $0x10,%rsi
    a30b:	48 69 f6 28 12 00 00 	imul   $0x1228,%rsi,%rsi
    a312:	0f b6 3c 32          	movzbl (%rdx,%rsi,1),%edi
    a316:	48 81 e1 ff ff 00 00 	and    $0xffff,%rcx
    a31d:	75 72                	jne    a391 <fwp_vbox1+0xe1>
    a31f:	40 80 ff 02          	cmp    $0x2,%dil
    a323:	74 53                	je     a378 <fwp_vbox1+0xc8>
    a325:	eb 6a                	jmp    a391 <fwp_vbox1+0xe1>
    a327:	bf 01 00 00 00       	mov    $0x1,%edi
    a32c:	be 01 00 00 00       	mov    $0x1,%esi
    a331:	e8 2a fa ff ff       	call   9d60 <fwp_data>
    a336:	48 89 c1             	mov    %rax,%rcx
    a339:	48 2b 0d 70 8e 00 00 	sub    0x8e70(%rip),%rcx        # 131b0 <fwp_gc+0x1030>
    a340:	48 8b 15 91 8e 00 00 	mov    0x8e91(%rip),%rdx        # 131d8 <fwp_gc+0x1058>
    a347:	48 c1 e2 10          	shl    $0x10,%rdx
    a34b:	48 39 d1             	cmp    %rdx,%rcx
    a34e:	73 77                	jae    a3c7 <fwp_vbox1+0x117>
    a350:	48 8b 15 a1 8e 00 00 	mov    0x8ea1(%rip),%rdx        # 131f8 <fwp_gc+0x1078>
    a357:	48 89 ce             	mov    %rcx,%rsi
    a35a:	48 c1 ee 10          	shr    $0x10,%rsi
    a35e:	48 69 f6 28 12 00 00 	imul   $0x1228,%rsi,%rsi
    a365:	0f b6 3c 32          	movzbl (%rdx,%rsi,1),%edi
    a369:	48 81 e1 ff ff 00 00 	and    $0xffff,%rcx
    a370:	75 1f                	jne    a391 <fwp_vbox1+0xe1>
    a372:	40 80 ff 02          	cmp    $0x2,%dil
    a376:	75 19                	jne    a391 <fwp_vbox1+0xe1>
    a378:	48 8d 1c 32          	lea    (%rdx,%rsi,1),%rbx
    a37c:	48 81 c3 28 02 00 00 	add    $0x228,%rbx
    a383:	80 3b ff             	cmpb   $0xff,(%rbx)
    a386:	74 2f                	je     a3b7 <fwp_vbox1+0x107>
    a388:	c6 03 01             	movb   $0x1,(%rbx)
    a38b:	eb 3a                	jmp    a3c7 <fwp_vbox1+0x117>
    a38d:	31 c0                	xor    %eax,%eax
    a38f:	eb 36                	jmp    a3c7 <fwp_vbox1+0x117>
    a391:	40 80 ff 01          	cmp    $0x1,%dil
    a395:	75 30                	jne    a3c7 <fwp_vbox1+0x117>
    a397:	48 8d 3c 32          	lea    (%rdx,%rsi,1),%rdi
    a39b:	8b 54 32 20          	mov    0x20(%rdx,%rsi,1),%edx
    a39f:	48 0f af ca          	imul   %rdx,%rcx
    a3a3:	48 c1 e9 20          	shr    $0x20,%rcx
    a3a7:	48 8d 1c 39          	lea    (%rcx,%rdi,1),%rbx
    a3ab:	48 81 c3 28 02 00 00 	add    $0x228,%rbx
    a3b2:	80 3b ff             	cmpb   $0xff,(%rbx)
    a3b5:	75 d1                	jne    a388 <fwp_vbox1+0xd8>
    a3b7:	48 89 df             	mov    %rbx,%rdi
    a3ba:	49 89 c6             	mov    %rax,%r14
    a3bd:	e8 ce be ff ff       	call   6290 <fwp_rc_forget_slot>
    a3c2:	4c 89 f0             	mov    %r14,%rax
    a3c5:	eb c1                	jmp    a388 <fwp_vbox1+0xd8>
    a3c7:	48 83 c4 18          	add    $0x18,%rsp
    a3cb:	5b                   	pop    %rbx
    a3cc:	41 5e                	pop    %r14
    a3ce:	c3                   	ret
    a3cf:	90                   	nop

000000000000a3d0 <fwp_drop1>:
    a3d0:	53                   	push   %rbx
    a3d1:	48 89 f8             	mov    %rdi,%rax
    a3d4:	48 2b 05 d5 8d 00 00 	sub    0x8dd5(%rip),%rax        # 131b0 <fwp_gc+0x1030>
    a3db:	48 8b 0d f6 8d 00 00 	mov    0x8df6(%rip),%rcx        # 131d8 <fwp_gc+0x1058>
    a3e2:	48 c1 e1 10          	shl    $0x10,%rcx
    a3e6:	48 39 c8             	cmp    %rcx,%rax
    a3e9:	0f 83 9c 00 00 00    	jae    a48b <fwp_drop1+0xbb>
    a3ef:	48 8b 0d 02 8e 00 00 	mov    0x8e02(%rip),%rcx        # 131f8 <fwp_gc+0x1078>
    a3f6:	48 89 c2             	mov    %rax,%rdx
    a3f9:	48 c1 ea 10          	shr    $0x10,%rdx
    a3fd:	48 69 d2 28 12 00 00 	imul   $0x1228,%rdx,%rdx
    a404:	0f b6 34 11          	movzbl (%rcx,%rdx,1),%esi
    a408:	48 25 ff ff 00 00    	and    $0xffff,%rax
    a40e:	75 20                	jne    a430 <fwp_drop1+0x60>
    a410:	40 80 fe 02          	cmp    $0x2,%sil
    a414:	75 1a                	jne    a430 <fwp_drop1+0x60>
    a416:	48 8d 04 11          	lea    (%rcx,%rdx,1),%rax
    a41a:	48 05 28 02 00 00    	add    $0x228,%rax
    a420:	eb 2d                	jmp    a44f <fwp_drop1+0x7f>
    a422:	66 66 66 66 66 2e 0f 	data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    a429:	1f 84 00 00 00 00 00 
    a430:	40 80 fe 01          	cmp    $0x1,%sil
    a434:	75 55                	jne    a48b <fwp_drop1+0xbb>
    a436:	48 8d 34 11          	lea    (%rcx,%rdx,1),%rsi
    a43a:	8b 4c 11 20          	mov    0x20(%rcx,%rdx,1),%ecx
    a43e:	48 0f af c1          	imul   %rcx,%rax
    a442:	48 c1 e8 20          	shr    $0x20,%rax
    a446:	48 01 f0             	add    %rsi,%rax
    a449:	48 05 28 02 00 00    	add    $0x228,%rax
    a44f:	0f b6 08             	movzbl (%rax),%ecx
    a452:	85 c9                	test   %ecx,%ecx
    a454:	74 35                	je     a48b <fwp_drop1+0xbb>
    a456:	83 f9 01             	cmp    $0x1,%ecx
    a459:	75 32                	jne    a48d <fwp_drop1+0xbd>
    a45b:	48 83 3f 00          	cmpq   $0x0,(%rdi)
    a45f:	79 3a                	jns    a49b <fwp_drop1+0xcb>
    a461:	48 8b 5f 08          	mov    0x8(%rdi),%rbx
    a465:	e8 46 00 00 00       	call   a4b0 <fwp_rc_free_arr>
    a46a:	48 89 d8             	mov    %rbx,%rax
    a46d:	48 2b 05 3c 8d 00 00 	sub    0x8d3c(%rip),%rax        # 131b0 <fwp_gc+0x1030>
    a474:	48 8b 0d 5d 8d 00 00 	mov    0x8d5d(%rip),%rcx        # 131d8 <fwp_gc+0x1058>
    a47b:	48 c1 e1 10          	shl    $0x10,%rcx
    a47f:	48 89 df             	mov    %rbx,%rdi
    a482:	48 39 c8             	cmp    %rcx,%rax
    a485:	0f 82 64 ff ff ff    	jb     a3ef <fwp_drop1+0x1f>
    a48b:	5b                   	pop    %rbx
    a48c:	c3                   	ret
    a48d:	81 f9 ff 00 00 00    	cmp    $0xff,%ecx
    a493:	74 09                	je     a49e <fwp_drop1+0xce>
    a495:	fe c9                	dec    %cl
    a497:	88 08                	mov    %cl,(%rax)
    a499:	5b                   	pop    %rbx
    a49a:	c3                   	ret
    a49b:	5b                   	pop    %rbx
    a49c:	eb 12                	jmp    a4b0 <fwp_rc_free_arr>
    a49e:	48 89 c7             	mov    %rax,%rdi
    a4a1:	5b                   	pop    %rbx
    a4a2:	e9 19 01 00 00       	jmp    a5c0 <fwp_rc_wide_drop>
    a4a7:	66 0f 1f 84 00 00 00 	nopw   0x0(%rax,%rax,1)
    a4ae:	00 00 

000000000000a4b0 <fwp_rc_free_arr>:
    a4b0:	48 89 f8             	mov    %rdi,%rax
    a4b3:	48 2b 05 f6 8c 00 00 	sub    0x8cf6(%rip),%rax        # 131b0 <fwp_gc+0x1030>
    a4ba:	48 8b 0d 17 8d 00 00 	mov    0x8d17(%rip),%rcx        # 131d8 <fwp_gc+0x1058>
    a4c1:	48 c1 e1 10          	shl    $0x10,%rcx
    a4c5:	48 39 c8             	cmp    %rcx,%rax
    a4c8:	0f 83 e9 00 00 00    	jae    a5b7 <fwp_rc_free_arr+0x107>
    a4ce:	53                   	push   %rbx
    a4cf:	48 8b 0d 22 8d 00 00 	mov    0x8d22(%rip),%rcx        # 131f8 <fwp_gc+0x1078>
    a4d6:	48 89 c2             	mov    %rax,%rdx
    a4d9:	48 c1 ea 10          	shr    $0x10,%rdx
    a4dd:	48 69 d2 28 12 00 00 	imul   $0x1228,%rdx,%rdx
    a4e4:	0f b6 34 11          	movzbl (%rcx,%rdx,1),%esi
    a4e8:	48 25 ff ff 00 00    	and    $0xffff,%rax
    a4ee:	75 1a                	jne    a50a <fwp_rc_free_arr+0x5a>
    a4f0:	40 80 fe 02          	cmp    $0x2,%sil
    a4f4:	75 14                	jne    a50a <fwp_rc_free_arr+0x5a>
    a4f6:	48 8d 04 11          	lea    (%rcx,%rdx,1),%rax
    a4fa:	48 05 28 02 00 00    	add    $0x228,%rax
    a500:	80 38 01             	cmpb   $0x1,(%rax)
    a503:	74 31                	je     a536 <fwp_rc_free_arr+0x86>
    a505:	e9 ac 00 00 00       	jmp    a5b6 <fwp_rc_free_arr+0x106>
    a50a:	40 80 fe 01          	cmp    $0x1,%sil
    a50e:	0f 85 a2 00 00 00    	jne    a5b6 <fwp_rc_free_arr+0x106>
    a514:	48 8d 34 11          	lea    (%rcx,%rdx,1),%rsi
    a518:	8b 4c 11 20          	mov    0x20(%rcx,%rdx,1),%ecx
    a51c:	48 0f af c1          	imul   %rcx,%rax
    a520:	48 c1 e8 20          	shr    $0x20,%rax
    a524:	48 01 f0             	add    %rsi,%rax
    a527:	48 05 28 02 00 00    	add    $0x228,%rax
    a52d:	80 38 01             	cmpb   $0x1,(%rax)
    a530:	0f 85 80 00 00 00    	jne    a5b6 <fwp_rc_free_arr+0x106>
    a536:	8b 0d 64 96 00 00    	mov    0x9664(%rip),%ecx        # 13ba0 <fwp_reuse_verify>
    a53c:	85 c9                	test   %ecx,%ecx
    a53e:	78 0d                	js     a54d <fwp_rc_free_arr+0x9d>
    a540:	85 c9                	test   %ecx,%ecx
    a542:	74 47                	je     a58b <fwp_rc_free_arr+0xdb>
    a544:	48 c7 07 00 00 00 00 	movq   $0x0,(%rdi)
    a54b:	eb 69                	jmp    a5b6 <fwp_rc_free_arr+0x106>
    a54d:	48 89 fb             	mov    %rdi,%rbx
    a550:	48 8d 3d 92 4f 00 00 	lea    0x4f92(%rip),%rdi        # f4e9 <fwp_segv.msg+0x2a9>
    a557:	e8 d4 7a ff ff       	call   2030 <getenv@plt>
    a55c:	31 c9                	xor    %ecx,%ecx
    a55e:	48 85 c0             	test   %rax,%rax
    a561:	74 1b                	je     a57e <fwp_rc_free_arr+0xce>
    a563:	80 38 00             	cmpb   $0x0,(%rax)
    a566:	74 16                	je     a57e <fwp_rc_free_arr+0xce>
    a568:	48 8d 35 f3 50 00 00 	lea    0x50f3(%rip),%rsi        # f662 <fwp_segv.msg+0x422>
    a56f:	48 89 c7             	mov    %rax,%rdi
    a572:	e8 09 7c ff ff       	call   2180 <strcmp@plt>
    a577:	31 c9                	xor    %ecx,%ecx
    a579:	85 c0                	test   %eax,%eax
    a57b:	0f 95 c1             	setne  %cl
    a57e:	89 0d 1c 96 00 00    	mov    %ecx,0x961c(%rip)        # 13ba0 <fwp_reuse_verify>
    a584:	48 89 df             	mov    %rbx,%rdi
    a587:	85 c9                	test   %ecx,%ecx
    a589:	75 b9                	jne    a544 <fwp_rc_free_arr+0x94>
    a58b:	48 8b 1d ee 7b 00 00 	mov    0x7bee(%rip),%rbx        # 12180 <fwp_gc>
    a592:	e8 b9 00 00 00       	call   a650 <fwp_mem_free>
    a597:	48 8b 05 e2 7b 00 00 	mov    0x7be2(%rip),%rax        # 12180 <fwp_gc>
    a59e:	48 29 d8             	sub    %rbx,%rax
    a5a1:	f2 48 0f 2a c0       	cvtsi2sd %rax,%xmm0
    a5a6:	f2 0f 58 05 da 8d 00 	addsd  0x8dda(%rip),%xmm0        # 13388 <fwp_gc+0x1208>
    a5ad:	00 
    a5ae:	f2 0f 11 05 d2 8d 00 	movsd  %xmm0,0x8dd2(%rip)        # 13388 <fwp_gc+0x1208>
    a5b5:	00 
    a5b6:	5b                   	pop    %rbx
    a5b7:	c3                   	ret
    a5b8:	0f 1f 84 00 00 00 00 	nopl   0x0(%rax,%rax,1)
    a5bf:	00 

000000000000a5c0 <fwp_rc_wide_drop>:
    a5c0:	53                   	push   %rbx
    a5c1:	48 89 f8             	mov    %rdi,%rax
    a5c4:	48 c1 e8 11          	shr    $0x11,%rax
    a5c8:	31 f8                	xor    %edi,%eax
    a5ca:	89 c1                	mov    %eax,%ecx
    a5cc:	c1 e9 09             	shr    $0x9,%ecx
    a5cf:	31 c1                	xor    %eax,%ecx
    a5d1:	0f b6 c1             	movzbl %cl,%eax
    a5d4:	48 8d 0d a5 7b 00 00 	lea    0x7ba5(%rip),%rcx        # 12180 <fwp_gc>
    a5db:	48 8b 84 c1 18 12 00 	mov    0x1218(%rcx,%rax,8),%rax
    a5e2:	00 
    a5e3:	48 85 c0             	test   %rax,%rax
    a5e6:	74 16                	je     a5fe <fwp_rc_wide_drop+0x3e>
    a5e8:	0f 1f 84 00 00 00 00 	nopl   0x0(%rax,%rax,1)
    a5ef:	00 
    a5f0:	48 39 38             	cmp    %rdi,(%rax)
    a5f3:	74 37                	je     a62c <fwp_rc_wide_drop+0x6c>
    a5f5:	48 8b 40 10          	mov    0x10(%rax),%rax
    a5f9:	48 85 c0             	test   %rax,%rax
    a5fc:	75 f2                	jne    a5f0 <fwp_rc_wide_drop+0x30>
    a5fe:	e8 5d bc ff ff       	call   6260 <fwp_flush>
    a603:	48 8b 05 d6 79 00 00 	mov    0x79d6(%rip),%rax        # 11fe0 <stderr@GLIBC_2.2.5>
    a60a:	48 8b 38             	mov    (%rax),%rdi
    a60d:	48 8d 35 19 4e 00 00 	lea    0x4e19(%rip),%rsi        # f42d <fwp_segv.msg+0x1ed>
    a614:	48 8d 15 21 4e 00 00 	lea    0x4e21(%rip),%rdx        # f43c <fwp_segv.msg+0x1fc>
    a61b:	31 c0                	xor    %eax,%eax
    a61d:	e8 8e 7b ff ff       	call   21b0 <fprintf@plt>
    a622:	bf 65 00 00 00       	mov    $0x65,%edi
    a627:	e8 64 7c ff ff       	call   2290 <exit@plt>
    a62c:	48 8b 48 08          	mov    0x8(%rax),%rcx
    a630:	48 ff c9             	dec    %rcx
    a633:	48 89 48 08          	mov    %rcx,0x8(%rax)
    a637:	48 81 f9 fe 00 00 00 	cmp    $0xfe,%rcx
    a63e:	75 0b                	jne    a64b <fwp_rc_wide_drop+0x8b>
    a640:	48 89 fb             	mov    %rdi,%rbx
    a643:	e8 48 bc ff ff       	call   6290 <fwp_rc_forget_slot>
    a648:	c6 03 fe             	movb   $0xfe,(%rbx)
    a64b:	5b                   	pop    %rbx
    a64c:	c3                   	ret
    a64d:	0f 1f 00             	nopl   (%rax)

000000000000a650 <fwp_mem_free>:
    a650:	48 85 ff             	test   %rdi,%rdi
    a653:	0f 84 17 02 00 00    	je     a870 <fwp_mem_free+0x220>
    a659:	48 8b 05 50 8b 00 00 	mov    0x8b50(%rip),%rax        # 131b0 <fwp_gc+0x1030>
    a660:	48 89 f9             	mov    %rdi,%rcx
    a663:	48 29 c1             	sub    %rax,%rcx
    a666:	48 8b 15 6b 8b 00 00 	mov    0x8b6b(%rip),%rdx        # 131d8 <fwp_gc+0x1058>
    a66d:	48 c1 e2 10          	shl    $0x10,%rdx
    a671:	48 39 d1             	cmp    %rdx,%rcx
    a674:	0f 83 f6 01 00 00    	jae    a870 <fwp_mem_free+0x220>
    a67a:	41 57                	push   %r15
    a67c:	41 56                	push   %r14
    a67e:	41 55                	push   %r13
    a680:	41 54                	push   %r12
    a682:	53                   	push   %rbx
    a683:	4c 8b 25 6e 8b 00 00 	mov    0x8b6e(%rip),%r12        # 131f8 <fwp_gc+0x1078>
    a68a:	4d 85 e4             	test   %r12,%r12
    a68d:	0f 84 d4 01 00 00    	je     a867 <fwp_mem_free+0x217>
    a693:	49 89 cf             	mov    %rcx,%r15
    a696:	49 c1 ef 10          	shr    $0x10,%r15
    a69a:	4d 69 f7 28 12 00 00 	imul   $0x1228,%r15,%r14
    a6a1:	43 0f b6 14 34       	movzbl (%r12,%r14,1),%edx
    a6a6:	83 fa 02             	cmp    $0x2,%edx
    a6a9:	0f 84 b9 00 00 00    	je     a768 <fwp_mem_free+0x118>
    a6af:	83 fa 01             	cmp    $0x1,%edx
    a6b2:	0f 85 af 01 00 00    	jne    a867 <fwp_mem_free+0x217>
    a6b8:	47 0f b6 4c 34 01    	movzbl 0x1(%r12,%r14,1),%r9d
    a6be:	47 0f b6 44 34 02    	movzbl 0x2(%r12,%r14,1),%r8d
    a6c4:	43 8b 74 34 08       	mov    0x8(%r12,%r14,1),%esi
    a6c9:	0f b7 c7             	movzwl %di,%eax
    a6cc:	31 d2                	xor    %edx,%edx
    a6ce:	f7 f6                	div    %esi
    a6d0:	48 c7 c2 fe ff ff ff 	mov    $0xfffffffffffffffe,%rdx
    a6d7:	89 c1                	mov    %eax,%ecx
    a6d9:	48 d3 c2             	rol    %cl,%rdx
    a6dc:	4b 8d 0c 34          	lea    (%r12,%r14,1),%rcx
    a6e0:	41 89 c2             	mov    %eax,%r10d
    a6e3:	41 c1 ea 03          	shr    $0x3,%r10d
    a6e7:	41 81 e2 f8 1f 00 00 	and    $0x1ff8,%r10d
    a6ee:	49 21 54 0a 28       	and    %rdx,0x28(%r10,%rcx,1)
    a6f3:	49 69 d1 c0 03 00 00 	imul   $0x3c0,%r9,%rdx
    a6fa:	4c 8d 3d 7f 7a 00 00 	lea    0x7a7f(%rip),%r15        # 12180 <fwp_gc>
    a701:	49 01 d7             	add    %rdx,%r15
    a704:	4f 8d 2c 40          	lea    (%r8,%r8,2),%r13
    a708:	4d 01 e6             	add    %r12,%r14
    a70b:	49 83 c6 08          	add    $0x8,%r14
    a70f:	48 8d 1c 08          	lea    (%rax,%rcx,1),%rbx
    a713:	48 81 c3 28 02 00 00 	add    $0x228,%rbx
    a71a:	80 bc 08 28 02 00 00 	cmpb   $0xff,0x228(%rax,%rcx,1)
    a721:	ff 
    a722:	0f 84 49 01 00 00    	je     a871 <fwp_mem_free+0x221>
    a728:	4f 8d 3c ef          	lea    (%r15,%r13,8),%r15
    a72c:	49 83 c7 08          	add    $0x8,%r15
    a730:	c6 03 00             	movb   $0x0,(%rbx)
    a733:	83 3d 4a 8a 00 00 00 	cmpl   $0x0,0x8a4a(%rip)        # 13184 <fwp_gc+0x1004>
    a73a:	74 12                	je     a74e <fwp_mem_free+0xfe>
    a73c:	89 f2                	mov    %esi,%edx
    a73e:	48 89 fb             	mov    %rdi,%rbx
    a741:	31 f6                	xor    %esi,%esi
    a743:	e8 e8 79 ff ff       	call   2130 <memset@plt>
    a748:	48 89 df             	mov    %rbx,%rdi
    a74b:	41 8b 36             	mov    (%r14),%esi
    a74e:	49 8b 07             	mov    (%r15),%rax
    a751:	48 f7 d0             	not    %rax
    a754:	48 89 07             	mov    %rax,(%rdi)
    a757:	49 89 3f             	mov    %rdi,(%r15)
    a75a:	89 f0                	mov    %esi,%eax
    a75c:	48 01 05 1d 7a 00 00 	add    %rax,0x7a1d(%rip)        # 12180 <fwp_gc>
    a763:	e9 ff 00 00 00       	jmp    a867 <fwp_mem_free+0x217>
    a768:	48 81 e1 00 00 ff ff 	and    $0xffffffffffff0000,%rcx
    a76f:	48 01 c8             	add    %rcx,%rax
    a772:	48 39 f8             	cmp    %rdi,%rax
    a775:	0f 85 ec 00 00 00    	jne    a867 <fwp_mem_free+0x217>
    a77b:	4b 8b 44 34 18       	mov    0x18(%r12,%r14,1),%rax
    a780:	48 01 05 f9 79 00 00 	add    %rax,0x79f9(%rip)        # 12180 <fwp_gc>
    a787:	43 c6 44 34 03 00    	movb   $0x0,0x3(%r12,%r14,1)
    a78d:	4b 8d 1c 34          	lea    (%r12,%r14,1),%rbx
    a791:	48 81 c3 28 02 00 00 	add    $0x228,%rbx
    a798:	43 80 bc 34 28 02 00 	cmpb   $0xff,0x228(%r12,%r14,1)
    a79f:	00 ff 
    a7a1:	0f 84 e0 00 00 00    	je     a887 <fwp_mem_free+0x237>
    a7a7:	c6 03 00             	movb   $0x0,(%rbx)
    a7aa:	43 8b 44 34 10       	mov    0x10(%r12,%r14,1),%eax
    a7af:	48 85 c0             	test   %rax,%rax
    a7b2:	0f 84 88 00 00 00    	je     a840 <fwp_mem_free+0x1f0>
    a7b8:	48 8b 0d 39 8a 00 00 	mov    0x8a39(%rip),%rcx        # 131f8 <fwp_gc+0x1078>
    a7bf:	89 c2                	mov    %eax,%edx
    a7c1:	83 e2 03             	and    $0x3,%edx
    a7c4:	83 f8 04             	cmp    $0x4,%eax
    a7c7:	73 04                	jae    a7cd <fwp_mem_free+0x17d>
    a7c9:	31 f6                	xor    %esi,%esi
    a7cb:	eb 3b                	jmp    a808 <fwp_mem_free+0x1b8>
    a7cd:	4a 8d 3c 31          	lea    (%rcx,%r14,1),%rdi
    a7d1:	41 89 c0             	mov    %eax,%r8d
    a7d4:	41 83 e0 fc          	and    $0xfffffffc,%r8d
    a7d8:	31 f6                	xor    %esi,%esi
    a7da:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)
    a7e0:	c6 07 00             	movb   $0x0,(%rdi)
    a7e3:	c6 87 28 12 00 00 00 	movb   $0x0,0x1228(%rdi)
    a7ea:	c6 87 50 24 00 00 00 	movb   $0x0,0x2450(%rdi)
    a7f1:	c6 87 78 36 00 00 00 	movb   $0x0,0x3678(%rdi)
    a7f8:	48 83 c6 04          	add    $0x4,%rsi
    a7fc:	48 81 c7 a0 48 00 00 	add    $0x48a0,%rdi
    a803:	49 39 f0             	cmp    %rsi,%r8
    a806:	75 d8                	jne    a7e0 <fwp_mem_free+0x190>
    a808:	48 85 d2             	test   %rdx,%rdx
    a80b:	74 33                	je     a840 <fwp_mem_free+0x1f0>
    a80d:	48 69 f6 28 12 00 00 	imul   $0x1228,%rsi,%rsi
    a814:	4c 01 f6             	add    %r14,%rsi
    a817:	48 01 f1             	add    %rsi,%rcx
    a81a:	48 69 d2 28 12 00 00 	imul   $0x1228,%rdx,%rdx
    a821:	31 f6                	xor    %esi,%esi
    a823:	66 66 66 66 2e 0f 1f 	data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    a82a:	84 00 00 00 00 00 
    a830:	c6 04 31 00          	movb   $0x0,(%rcx,%rsi,1)
    a834:	48 81 c6 28 12 00 00 	add    $0x1228,%rsi
    a83b:	48 39 f2             	cmp    %rsi,%rdx
    a83e:	75 f0                	jne    a830 <fwp_mem_free+0x1e0>
    a840:	48 01 05 19 8b 00 00 	add    %rax,0x8b19(%rip)        # 13360 <fwp_gc+0x11e0>
    a847:	4c 3b 3d a2 89 00 00 	cmp    0x89a2(%rip),%r15        # 131f0 <fwp_gc+0x1070>
    a84e:	73 07                	jae    a857 <fwp_mem_free+0x207>
    a850:	4c 89 3d 99 89 00 00 	mov    %r15,0x8999(%rip)        # 131f0 <fwp_gc+0x1070>
    a857:	4c 3b 3d 8a 89 00 00 	cmp    0x898a(%rip),%r15        # 131e8 <fwp_gc+0x1068>
    a85e:	73 07                	jae    a867 <fwp_mem_free+0x217>
    a860:	4c 89 3d 81 89 00 00 	mov    %r15,0x8981(%rip)        # 131e8 <fwp_gc+0x1068>
    a867:	5b                   	pop    %rbx
    a868:	41 5c                	pop    %r12
    a86a:	41 5d                	pop    %r13
    a86c:	41 5e                	pop    %r14
    a86e:	41 5f                	pop    %r15
    a870:	c3                   	ret
    a871:	49 89 fc             	mov    %rdi,%r12
    a874:	48 89 df             	mov    %rbx,%rdi
    a877:	e8 14 ba ff ff       	call   6290 <fwp_rc_forget_slot>
    a87c:	4c 89 e7             	mov    %r12,%rdi
    a87f:	41 8b 36             	mov    (%r14),%esi
    a882:	e9 a1 fe ff ff       	jmp    a728 <fwp_mem_free+0xd8>
    a887:	48 89 df             	mov    %rbx,%rdi
    a88a:	e8 01 ba ff ff       	call   6290 <fwp_rc_forget_slot>
    a88f:	e9 13 ff ff ff       	jmp    a7a7 <fwp_mem_free+0x157>
    a894:	66 66 66 2e 0f 1f 84 	data16 data16 cs nopw 0x0(%rax,%rax,1)
    a89b:	00 00 00 00 00 

000000000000a8a0 <fwp_rc_free_obj>:
    a8a0:	48 89 f8             	mov    %rdi,%rax
    a8a3:	48 2b 05 06 89 00 00 	sub    0x8906(%rip),%rax        # 131b0 <fwp_gc+0x1030>
    a8aa:	48 8b 0d 27 89 00 00 	mov    0x8927(%rip),%rcx        # 131d8 <fwp_gc+0x1058>
    a8b1:	48 c1 e1 10          	shl    $0x10,%rcx
    a8b5:	48 39 c8             	cmp    %rcx,%rax
    a8b8:	0f 83 b8 01 00 00    	jae    aa76 <fwp_rc_free_obj+0x1d6>
    a8be:	55                   	push   %rbp
    a8bf:	41 57                	push   %r15
    a8c1:	41 56                	push   %r14
    a8c3:	53                   	push   %rbx
    a8c4:	50                   	push   %rax
    a8c5:	48 8b 1d 2c 89 00 00 	mov    0x892c(%rip),%rbx        # 131f8 <fwp_gc+0x1078>
    a8cc:	48 89 c1             	mov    %rax,%rcx
    a8cf:	48 c1 e9 10          	shr    $0x10,%rcx
    a8d3:	4c 69 f1 28 12 00 00 	imul   $0x1228,%rcx,%r14
    a8da:	42 0f b6 2c 33       	movzbl (%rbx,%r14,1),%ebp
    a8df:	48 25 ff ff 00 00    	and    $0xffff,%rax
    a8e5:	75 1a                	jne    a901 <fwp_rc_free_obj+0x61>
    a8e7:	40 80 fd 02          	cmp    $0x2,%bpl
    a8eb:	75 14                	jne    a901 <fwp_rc_free_obj+0x61>
    a8ed:	4a 8d 04 33          	lea    (%rbx,%r14,1),%rax
    a8f1:	48 05 28 02 00 00    	add    $0x228,%rax
    a8f7:	80 38 01             	cmpb   $0x1,(%rax)
    a8fa:	74 32                	je     a92e <fwp_rc_free_obj+0x8e>
    a8fc:	e9 6b 01 00 00       	jmp    aa6c <fwp_rc_free_obj+0x1cc>
    a901:	40 80 fd 01          	cmp    $0x1,%bpl
    a905:	0f 85 61 01 00 00    	jne    aa6c <fwp_rc_free_obj+0x1cc>
    a90b:	4a 8d 0c 33          	lea    (%rbx,%r14,1),%rcx
    a90f:	42 8b 54 33 20       	mov    0x20(%rbx,%r14,1),%edx
    a914:	48 0f af c2          	imul   %rdx,%rax
    a918:	48 c1 e8 20          	shr    $0x20,%rax
    a91c:	48 01 c8             	add    %rcx,%rax
    a91f:	48 05 28 02 00 00    	add    $0x228,%rax
    a925:	80 38 01             	cmpb   $0x1,(%rax)
    a928:	0f 85 3e 01 00 00    	jne    aa6c <fwp_rc_free_obj+0x1cc>
    a92e:	8b 0d 6c 92 00 00    	mov    0x926c(%rip),%ecx        # 13ba0 <fwp_reuse_verify>
    a934:	85 c9                	test   %ecx,%ecx
    a936:	0f 88 c3 00 00 00    	js     a9ff <fwp_rc_free_obj+0x15f>
    a93c:	85 c9                	test   %ecx,%ecx
    a93e:	0f 84 fd 00 00 00    	je     aa41 <fwp_rc_free_obj+0x1a1>
    a944:	42 80 7c 33 01 01    	cmpb   $0x1,0x1(%rbx,%r14,1)
    a94a:	75 0d                	jne    a959 <fwp_rc_free_obj+0xb9>
    a94c:	40 80 fd 02          	cmp    $0x2,%bpl
    a950:	75 22                	jne    a974 <fwp_rc_free_obj+0xd4>
    a952:	4a 8b 54 33 18       	mov    0x18(%rbx,%r14,1),%rdx
    a957:	eb 20                	jmp    a979 <fwp_rc_free_obj+0xd9>
    a959:	c7 07 ad de 00 00    	movl   $0xdead,(%rdi)
    a95f:	8b 47 04             	mov    0x4(%rdi),%eax
    a962:	48 85 c0             	test   %rax,%rax
    a965:	0f 84 01 01 00 00    	je     aa6c <fwp_rc_free_obj+0x1cc>
    a96b:	83 f8 04             	cmp    $0x4,%eax
    a96e:	73 26                	jae    a996 <fwp_rc_free_obj+0xf6>
    a970:	31 c9                	xor    %ecx,%ecx
    a972:	eb 6a                	jmp    a9de <fwp_rc_free_obj+0x13e>
    a974:	42 8b 54 33 08       	mov    0x8(%rbx,%r14,1),%edx
    a979:	48 89 fb             	mov    %rdi,%rbx
    a97c:	be dd 00 00 00       	mov    $0xdd,%esi
    a981:	e8 aa 77 ff ff       	call   2130 <memset@plt>
    a986:	48 c7 03 00 00 00 00 	movq   $0x0,(%rbx)
    a98d:	c6 43 08 00          	movb   $0x0,0x8(%rbx)
    a991:	e9 d6 00 00 00       	jmp    aa6c <fwp_rc_free_obj+0x1cc>
    a996:	89 c1                	mov    %eax,%ecx
    a998:	83 e1 fc             	and    $0xfffffffc,%ecx
    a99b:	48 8d 14 c5 00 00 00 	lea    0x0(,%rax,8),%rdx
    a9a2:	00 
    a9a3:	48 83 e2 e0          	and    $0xffffffffffffffe0,%rdx
    a9a7:	31 f6                	xor    %esi,%esi
    a9a9:	66 0f 28 05 3f 47 00 	movapd 0x473f(%rip),%xmm0        # f0f0 <_IO_stdin_used+0xf0>
    a9b0:	00 
    a9b1:	66 66 66 66 66 66 2e 	data16 data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    a9b8:	0f 1f 84 00 00 00 00 
    a9bf:	00 
    a9c0:	66 0f 11 44 37 08    	movupd %xmm0,0x8(%rdi,%rsi,1)
    a9c6:	66 0f 11 44 37 18    	movupd %xmm0,0x18(%rdi,%rsi,1)
    a9cc:	48 83 c6 20          	add    $0x20,%rsi
    a9d0:	48 39 f2             	cmp    %rsi,%rdx
    a9d3:	75 eb                	jne    a9c0 <fwp_rc_free_obj+0x120>
    a9d5:	48 39 c1             	cmp    %rax,%rcx
    a9d8:	0f 84 8e 00 00 00    	je     aa6c <fwp_rc_free_obj+0x1cc>
    a9de:	48 ba ef be ad de ef 	movabs $0xdeadbeefdeadbeef,%rdx
    a9e5:	be ad de 
    a9e8:	0f 1f 84 00 00 00 00 	nopl   0x0(%rax,%rax,1)
    a9ef:	00 
    a9f0:	48 89 54 cf 08       	mov    %rdx,0x8(%rdi,%rcx,8)
    a9f5:	48 ff c1             	inc    %rcx
    a9f8:	48 39 c8             	cmp    %rcx,%rax
    a9fb:	75 f3                	jne    a9f0 <fwp_rc_free_obj+0x150>
    a9fd:	eb 6d                	jmp    aa6c <fwp_rc_free_obj+0x1cc>
    a9ff:	49 89 ff             	mov    %rdi,%r15
    aa02:	48 8d 3d e0 4a 00 00 	lea    0x4ae0(%rip),%rdi        # f4e9 <fwp_segv.msg+0x2a9>
    aa09:	e8 22 76 ff ff       	call   2030 <getenv@plt>
    aa0e:	31 c9                	xor    %ecx,%ecx
    aa10:	48 85 c0             	test   %rax,%rax
    aa13:	74 1b                	je     aa30 <fwp_rc_free_obj+0x190>
    aa15:	80 38 00             	cmpb   $0x0,(%rax)
    aa18:	74 16                	je     aa30 <fwp_rc_free_obj+0x190>
    aa1a:	48 8d 35 41 4c 00 00 	lea    0x4c41(%rip),%rsi        # f662 <fwp_segv.msg+0x422>
    aa21:	48 89 c7             	mov    %rax,%rdi
    aa24:	e8 57 77 ff ff       	call   2180 <strcmp@plt>
    aa29:	31 c9                	xor    %ecx,%ecx
    aa2b:	85 c0                	test   %eax,%eax
    aa2d:	0f 95 c1             	setne  %cl
    aa30:	89 0d 6a 91 00 00    	mov    %ecx,0x916a(%rip)        # 13ba0 <fwp_reuse_verify>
    aa36:	4c 89 ff             	mov    %r15,%rdi
    aa39:	85 c9                	test   %ecx,%ecx
    aa3b:	0f 85 03 ff ff ff    	jne    a944 <fwp_rc_free_obj+0xa4>
    aa41:	48 8b 1d 38 77 00 00 	mov    0x7738(%rip),%rbx        # 12180 <fwp_gc>
    aa48:	e8 03 fc ff ff       	call   a650 <fwp_mem_free>
    aa4d:	48 8b 05 2c 77 00 00 	mov    0x772c(%rip),%rax        # 12180 <fwp_gc>
    aa54:	48 29 d8             	sub    %rbx,%rax
    aa57:	f2 48 0f 2a c0       	cvtsi2sd %rax,%xmm0
    aa5c:	f2 0f 58 05 24 89 00 	addsd  0x8924(%rip),%xmm0        # 13388 <fwp_gc+0x1208>
    aa63:	00 
    aa64:	f2 0f 11 05 1c 89 00 	movsd  %xmm0,0x891c(%rip)        # 13388 <fwp_gc+0x1208>
    aa6b:	00 
    aa6c:	48 83 c4 08          	add    $0x8,%rsp
    aa70:	5b                   	pop    %rbx
    aa71:	41 5e                	pop    %r14
    aa73:	41 5f                	pop    %r15
    aa75:	5d                   	pop    %rbp
    aa76:	c3                   	ret
    aa77:	66 0f 1f 84 00 00 00 	nopw   0x0(%rax,%rax,1)
    aa7e:	00 00 

000000000000aa80 <fwp_owned_entry49>:
    aa80:	48 8b 3f             	mov    (%rdi),%rdi
    aa83:	e9 f8 f4 ff ff       	jmp    9f80 <f49>
    aa88:	0f 1f 84 00 00 00 00 	nopl   0x0(%rax,%rax,1)
    aa8f:	00 

000000000000aa90 <fwp_caps49>:
    aa90:	53                   	push   %rbx
    aa91:	83 7f 04 00          	cmpl   $0x0,0x4(%rdi)
    aa95:	74 56                	je     aaed <fwp_caps49+0x5d>
    aa97:	48 89 fb             	mov    %rdi,%rbx
    aa9a:	48 8b 7f 08          	mov    0x8(%rdi),%rdi
    aa9e:	85 f6                	test   %esi,%esi
    aaa0:	74 51                	je     aaf3 <fwp_caps49+0x63>
    aaa2:	48 2b 3d 07 87 00 00 	sub    0x8707(%rip),%rdi        # 131b0 <fwp_gc+0x1030>
    aaa9:	48 8b 05 28 87 00 00 	mov    0x8728(%rip),%rax        # 131d8 <fwp_gc+0x1058>
    aab0:	48 c1 e0 10          	shl    $0x10,%rax
    aab4:	48 39 c7             	cmp    %rax,%rdi
    aab7:	73 38                	jae    aaf1 <fwp_caps49+0x61>
    aab9:	48 8b 05 38 87 00 00 	mov    0x8738(%rip),%rax        # 131f8 <fwp_gc+0x1078>
    aac0:	48 89 f9             	mov    %rdi,%rcx
    aac3:	48 c1 e9 10          	shr    $0x10,%rcx
    aac7:	48 69 c9 28 12 00 00 	imul   $0x1228,%rcx,%rcx
    aace:	0f b6 14 08          	movzbl (%rax,%rcx,1),%edx
    aad2:	48 81 e7 ff ff 00 00 	and    $0xffff,%rdi
    aad9:	75 26                	jne    ab01 <fwp_caps49+0x71>
    aadb:	80 fa 02             	cmp    $0x2,%dl
    aade:	75 21                	jne    ab01 <fwp_caps49+0x71>
    aae0:	48 8d 3c 08          	lea    (%rax,%rcx,1),%rdi
    aae4:	48 81 c7 28 02 00 00 	add    $0x228,%rdi
    aaeb:	eb 33                	jmp    ab20 <fwp_caps49+0x90>
    aaed:	85 f6                	test   %esi,%esi
    aaef:	74 0a                	je     aafb <fwp_caps49+0x6b>
    aaf1:	5b                   	pop    %rbx
    aaf2:	c3                   	ret
    aaf3:	e8 08 f7 ff ff       	call   a200 <fwp_drop6>
    aaf8:	48 89 df             	mov    %rbx,%rdi
    aafb:	5b                   	pop    %rbx
    aafc:	e9 9f fd ff ff       	jmp    a8a0 <fwp_rc_free_obj>
    ab01:	80 fa 01             	cmp    $0x1,%dl
    ab04:	75 eb                	jne    aaf1 <fwp_caps49+0x61>
    ab06:	48 8d 14 08          	lea    (%rax,%rcx,1),%rdx
    ab0a:	8b 44 08 20          	mov    0x20(%rax,%rcx,1),%eax
    ab0e:	48 0f af f8          	imul   %rax,%rdi
    ab12:	48 c1 ef 20          	shr    $0x20,%rdi
    ab16:	48 01 d7             	add    %rdx,%rdi
    ab19:	48 81 c7 28 02 00 00 	add    $0x228,%rdi
    ab20:	0f b6 07             	movzbl (%rdi),%eax
    ab23:	84 c0                	test   %al,%al
    ab25:	74 ca                	je     aaf1 <fwp_caps49+0x61>
    ab27:	3c fe                	cmp    $0xfe,%al
    ab29:	73 06                	jae    ab31 <fwp_caps49+0xa1>
    ab2b:	fe c0                	inc    %al
    ab2d:	88 07                	mov    %al,(%rdi)
    ab2f:	5b                   	pop    %rbx
    ab30:	c3                   	ret
    ab31:	5b                   	pop    %rbx
    ab32:	e9 39 ca ff ff       	jmp    7570 <fwp_rc_wide_dup>
    ab37:	66 0f 1f 84 00 00 00 	nopw   0x0(%rax,%rax,1)
    ab3e:	00 00 

000000000000ab40 <fwp_args49>:
    ab40:	85 f6                	test   %esi,%esi
    ab42:	0f 85 8a 00 00 00    	jne    abd2 <fwp_args49+0x92>
    ab48:	85 d2                	test   %edx,%edx
    ab4a:	0f 84 82 00 00 00    	je     abd2 <fwp_args49+0x92>
    ab50:	48 8b 07             	mov    (%rdi),%rax
    ab53:	48 2b 05 56 86 00 00 	sub    0x8656(%rip),%rax        # 131b0 <fwp_gc+0x1030>
    ab5a:	48 8b 0d 77 86 00 00 	mov    0x8677(%rip),%rcx        # 131d8 <fwp_gc+0x1058>
    ab61:	48 c1 e1 10          	shl    $0x10,%rcx
    ab65:	48 39 c8             	cmp    %rcx,%rax
    ab68:	73 68                	jae    abd2 <fwp_args49+0x92>
    ab6a:	48 8b 0d 87 86 00 00 	mov    0x8687(%rip),%rcx        # 131f8 <fwp_gc+0x1078>
    ab71:	48 89 c2             	mov    %rax,%rdx
    ab74:	48 c1 ea 10          	shr    $0x10,%rdx
    ab78:	48 69 d2 28 12 00 00 	imul   $0x1228,%rdx,%rdx
    ab7f:	0f b6 34 11          	movzbl (%rcx,%rdx,1),%esi
    ab83:	48 25 ff ff 00 00    	and    $0xffff,%rax
    ab89:	75 13                	jne    ab9e <fwp_args49+0x5e>
    ab8b:	40 80 fe 02          	cmp    $0x2,%sil
    ab8f:	75 0d                	jne    ab9e <fwp_args49+0x5e>
    ab91:	48 8d 3c 11          	lea    (%rcx,%rdx,1),%rdi
    ab95:	48 81 c7 28 02 00 00 	add    $0x228,%rdi
    ab9c:	eb 21                	jmp    abbf <fwp_args49+0x7f>
    ab9e:	40 80 fe 01          	cmp    $0x1,%sil
    aba2:	75 2e                	jne    abd2 <fwp_args49+0x92>
    aba4:	48 8d 34 11          	lea    (%rcx,%rdx,1),%rsi
    aba8:	8b 4c 11 20          	mov    0x20(%rcx,%rdx,1),%ecx
    abac:	48 0f af c1          	imul   %rcx,%rax
    abb0:	48 c1 e8 20          	shr    $0x20,%rax
    abb4:	48 8d 3c 30          	lea    (%rax,%rsi,1),%rdi
    abb8:	48 81 c7 28 02 00 00 	add    $0x228,%rdi
    abbf:	0f b6 07             	movzbl (%rdi),%eax
    abc2:	84 c0                	test   %al,%al
    abc4:	74 0c                	je     abd2 <fwp_args49+0x92>
    abc6:	3c fe                	cmp    $0xfe,%al
    abc8:	0f 83 a2 c9 ff ff    	jae    7570 <fwp_rc_wide_dup>
    abce:	fe c0                	inc    %al
    abd0:	88 07                	mov    %al,(%rdi)
    abd2:	c3                   	ret
    abd3:	66 66 66 66 2e 0f 1f 	data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    abda:	84 00 00 00 00 00 

000000000000abe0 <fwp_arg_drop49>:
    abe0:	85 f6                	test   %esi,%esi
    abe2:	75 0c                	jne    abf0 <fwp_arg_drop49+0x10>
    abe4:	85 d2                	test   %edx,%edx
    abe6:	74 08                	je     abf0 <fwp_arg_drop49+0x10>
    abe8:	48 8b 3f             	mov    (%rdi),%rdi
    abeb:	e9 10 f6 ff ff       	jmp    a200 <fwp_drop6>
    abf0:	c3                   	ret
    abf1:	66 66 66 66 66 66 2e 	data16 data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    abf8:	0f 1f 84 00 00 00 00 
    abff:	00 

000000000000ac00 <fwp_p_loop_own>:
    ac00:	55                   	push   %rbp
    ac01:	41 57                	push   %r15
    ac03:	41 56                	push   %r14
    ac05:	41 55                	push   %r13
    ac07:	41 54                	push   %r12
    ac09:	53                   	push   %rbx
    ac0a:	48 83 ec 28          	sub    $0x28,%rsp
    ac0e:	49 89 d7             	mov    %rdx,%r15
    ac11:	49 89 f4             	mov    %rsi,%r12
    ac14:	49 89 fe             	mov    %rdi,%r14
    ac17:	48 89 74 24 08       	mov    %rsi,0x8(%rsp)
    ac1c:	48 89 7c 24 10       	mov    %rdi,0x10(%rsp)
    ac21:	48 89 54 24 18       	mov    %rdx,0x18(%rsp)
    ac26:	eb 15                	jmp    ac3d <fwp_p_loop_own+0x3d>
    ac28:	0f 1f 84 00 00 00 00 	nopl   0x0(%rax,%rax,1)
    ac2f:	00 
    ac30:	4c 89 64 24 08       	mov    %r12,0x8(%rsp)
    ac35:	85 db                	test   %ebx,%ebx
    ac37:	0f 85 f6 03 00 00    	jne    b033 <fwp_p_loop_own+0x433>
    ac3d:	8b 05 ad 8f 00 00    	mov    0x8fad(%rip),%eax        # 13bf0 <fwp_budget>
    ac43:	8d 48 ff             	lea    -0x1(%rax),%ecx
    ac46:	89 0d a4 8f 00 00    	mov    %ecx,0x8fa4(%rip)        # 13bf0 <fwp_budget>
    ac4c:	83 f8 01             	cmp    $0x1,%eax
    ac4f:	0f 8e bf 03 00 00    	jle    b014 <fwp_p_loop_own+0x414>
    ac55:	4c 89 64 24 08       	mov    %r12,0x8(%rsp)
    ac5a:	4c 8b 2d 5f 8f 00 00 	mov    0x8f5f(%rip),%r13        # 13bc0 <fwp_fns>
    ac61:	41 8b 06             	mov    (%r14),%eax
    ac64:	48 c1 e0 05          	shl    $0x5,%rax
    ac68:	49 83 7c 05 18 00    	cmpq   $0x0,0x18(%r13,%rax,1)
    ac6e:	0f 84 6c 01 00 00    	je     ade0 <fwp_p_loop_own+0x1e0>
    ac74:	4e 8d 04 28          	lea    (%rax,%r13,1),%r8
    ac78:	49 83 c0 18          	add    $0x18,%r8
    ac7c:	49 01 c5             	add    %rax,%r13
    ac7f:	bd 01 00 00 00       	mov    $0x1,%ebp
    ac84:	31 f6                	xor    %esi,%esi
    ac86:	4c 89 f0             	mov    %r14,%rax
    ac89:	4c 8d 64 24 08       	lea    0x8(%rsp),%r12
    ac8e:	41 be 01 00 00 00    	mov    $0x1,%r14d
    ac94:	66 66 66 2e 0f 1f 84 	data16 data16 cs nopw 0x0(%rax,%rax,1)
    ac9b:	00 00 00 00 00 
    aca0:	40 f6 c6 01          	test   $0x1,%sil
    aca4:	0f 85 86 00 00 00    	jne    ad30 <fwp_p_loop_own+0x130>
    acaa:	48 89 c7             	mov    %rax,%rdi
    acad:	48 2b 3d fc 84 00 00 	sub    0x84fc(%rip),%rdi        # 131b0 <fwp_gc+0x1030>
    acb4:	48 8b 0d 1d 85 00 00 	mov    0x851d(%rip),%rcx        # 131d8 <fwp_gc+0x1058>
    acbb:	48 c1 e1 10          	shl    $0x10,%rcx
    acbf:	48 39 cf             	cmp    %rcx,%rdi
    acc2:	73 6c                	jae    ad30 <fwp_p_loop_own+0x130>
    acc4:	48 8b 0d 2d 85 00 00 	mov    0x852d(%rip),%rcx        # 131f8 <fwp_gc+0x1078>
    accb:	48 89 fa             	mov    %rdi,%rdx
    acce:	48 c1 ea 10          	shr    $0x10,%rdx
    acd2:	48 69 d2 28 12 00 00 	imul   $0x1228,%rdx,%rdx
    acd9:	0f b6 34 11          	movzbl (%rcx,%rdx,1),%esi
    acdd:	48 81 e7 ff ff 00 00 	and    $0xffff,%rdi
    ace4:	75 13                	jne    acf9 <fwp_p_loop_own+0xf9>
    ace6:	40 80 fe 02          	cmp    $0x2,%sil
    acea:	75 0d                	jne    acf9 <fwp_p_loop_own+0xf9>
    acec:	48 8d 3c 11          	lea    (%rcx,%rdx,1),%rdi
    acf0:	48 81 c7 28 02 00 00 	add    $0x228,%rdi
    acf7:	eb 20                	jmp    ad19 <fwp_p_loop_own+0x119>
    acf9:	40 80 fe 01          	cmp    $0x1,%sil
    acfd:	75 31                	jne    ad30 <fwp_p_loop_own+0x130>
    acff:	48 8d 34 11          	lea    (%rcx,%rdx,1),%rsi
    ad03:	8b 4c 11 20          	mov    0x20(%rcx,%rdx,1),%ecx
    ad07:	48 0f af f9          	imul   %rcx,%rdi
    ad0b:	48 c1 ef 20          	shr    $0x20,%rdi
    ad0f:	48 01 f7             	add    %rsi,%rdi
    ad12:	48 81 c7 28 02 00 00 	add    $0x228,%rdi
    ad19:	0f b6 0f             	movzbl (%rdi),%ecx
    ad1c:	84 c9                	test   %cl,%cl
    ad1e:	74 10                	je     ad30 <fwp_p_loop_own+0x130>
    ad20:	80 f9 fe             	cmp    $0xfe,%cl
    ad23:	0f 83 9f 00 00 00    	jae    adc8 <fwp_p_loop_own+0x1c8>
    ad29:	fe c1                	inc    %cl
    ad2b:	88 0f                	mov    %cl,(%rdi)
    ad2d:	0f 1f 00             	nopl   (%rax)
    ad30:	41 8b 5d 00          	mov    0x0(%r13),%ebx
    ad34:	8b 70 04             	mov    0x4(%rax),%esi
    ad37:	29 f3                	sub    %esi,%ebx
    ad39:	39 dd                	cmp    %ebx,%ebp
    ad3b:	41 89 dd             	mov    %ebx,%r13d
    ad3e:	44 0f 42 ed          	cmovb  %ebp,%r13d
    ad42:	45 89 ef             	mov    %r13d,%r15d
    ad45:	45 39 ee             	cmp    %r13d,%r14d
    ad48:	45 0f 42 fe          	cmovb  %r14d,%r15d
    ad4c:	73 2d                	jae    ad7b <fwp_p_loop_own+0x17b>
    ad4e:	44 89 ea             	mov    %r13d,%edx
    ad51:	44 29 fa             	sub    %r15d,%edx
    ad54:	4d 8b 00             	mov    (%r8),%r8
    ad57:	44 89 f9             	mov    %r15d,%ecx
    ad5a:	49 8d 3c cc          	lea    (%r12,%rcx,8),%rdi
    ad5e:	44 01 fe             	add    %r15d,%esi
    ad61:	4c 89 64 24 20       	mov    %r12,0x20(%rsp)
    ad66:	41 89 ec             	mov    %ebp,%r12d
    ad69:	48 89 c5             	mov    %rax,%rbp
    ad6c:	41 ff 50 10          	call   *0x10(%r8)
    ad70:	48 89 e8             	mov    %rbp,%rax
    ad73:	44 89 e5             	mov    %r12d,%ebp
    ad76:	4c 8b 64 24 20       	mov    0x20(%rsp),%r12
    ad7b:	48 89 c7             	mov    %rax,%rdi
    ad7e:	44 89 ee             	mov    %r13d,%esi
    ad81:	4c 89 e2             	mov    %r12,%rdx
    ad84:	e8 87 09 00 00       	call   b710 <fwp_apply_owned>
    ad89:	39 dd                	cmp    %ebx,%ebp
    ad8b:	0f 86 cf 00 00 00    	jbe    ae60 <fwp_p_loop_own+0x260>
    ad91:	44 89 e9             	mov    %r13d,%ecx
    ad94:	4d 8d 24 cc          	lea    (%r12,%rcx,8),%r12
    ad98:	44 29 ed             	sub    %r13d,%ebp
    ad9b:	45 29 fe             	sub    %r15d,%r14d
    ad9e:	48 8b 0d 1b 8e 00 00 	mov    0x8e1b(%rip),%rcx        # 13bc0 <fwp_fns>
    ada5:	8b 10                	mov    (%rax),%edx
    ada7:	48 c1 e2 05          	shl    $0x5,%rdx
    adab:	4c 8d 2c 11          	lea    (%rcx,%rdx,1),%r13
    adaf:	4c 8d 04 11          	lea    (%rcx,%rdx,1),%r8
    adb3:	49 83 c0 18          	add    $0x18,%r8
    adb7:	40 b6 01             	mov    $0x1,%sil
    adba:	48 83 7c 11 18 00    	cmpq   $0x0,0x18(%rcx,%rdx,1)
    adc0:	0f 85 da fe ff ff    	jne    aca0 <fwp_p_loop_own+0xa0>
    adc6:	eb 25                	jmp    aded <fwp_p_loop_own+0x1ed>
    adc8:	48 89 c3             	mov    %rax,%rbx
    adcb:	4d 89 c7             	mov    %r8,%r15
    adce:	e8 9d c7 ff ff       	call   7570 <fwp_rc_wide_dup>
    add3:	4d 89 f8             	mov    %r15,%r8
    add6:	48 89 d8             	mov    %rbx,%rax
    add9:	e9 52 ff ff ff       	jmp    ad30 <fwp_p_loop_own+0x130>
    adde:	66 90                	xchg   %ax,%ax
    ade0:	bd 01 00 00 00       	mov    $0x1,%ebp
    ade5:	4c 8d 64 24 08       	lea    0x8(%rsp),%r12
    adea:	4c 89 f0             	mov    %r14,%rax
    aded:	4c 8b 1d bc 83 00 00 	mov    0x83bc(%rip),%r11        # 131b0 <fwp_gc+0x1030>
    adf4:	48 89 c2             	mov    %rax,%rdx
    adf7:	4c 29 da             	sub    %r11,%rdx
    adfa:	48 8b 0d d7 83 00 00 	mov    0x83d7(%rip),%rcx        # 131d8 <fwp_gc+0x1058>
    ae01:	48 c1 e1 10          	shl    $0x10,%rcx
    ae05:	48 39 ca             	cmp    %rcx,%rdx
    ae08:	4c 8b 74 24 10       	mov    0x10(%rsp),%r14
    ae0d:	0f 83 8d 00 00 00    	jae    aea0 <fwp_p_loop_own+0x2a0>
    ae13:	48 8b 35 de 83 00 00 	mov    0x83de(%rip),%rsi        # 131f8 <fwp_gc+0x1078>
    ae1a:	48 89 d7             	mov    %rdx,%rdi
    ae1d:	48 c1 ef 10          	shr    $0x10,%rdi
    ae21:	48 69 ff 28 12 00 00 	imul   $0x1228,%rdi,%rdi
    ae28:	44 0f b6 04 3e       	movzbl (%rsi,%rdi,1),%r8d
    ae2d:	48 81 e2 ff ff 00 00 	and    $0xffff,%rdx
    ae34:	75 34                	jne    ae6a <fwp_p_loop_own+0x26a>
    ae36:	41 80 f8 02          	cmp    $0x2,%r8b
    ae3a:	75 2e                	jne    ae6a <fwp_p_loop_own+0x26a>
    ae3c:	48 8d 14 3e          	lea    (%rsi,%rdi,1),%rdx
    ae40:	48 81 c2 28 02 00 00 	add    $0x228,%rdx
    ae47:	80 3a 00             	cmpb   $0x0,(%rdx)
    ae4a:	74 54                	je     aea0 <fwp_p_loop_own+0x2a0>
    ae4c:	e9 f6 01 00 00       	jmp    b047 <fwp_p_loop_own+0x447>
    ae51:	66 66 66 66 66 66 2e 	data16 data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    ae58:	0f 1f 84 00 00 00 00 
    ae5f:	00 
    ae60:	4c 8b 74 24 10       	mov    0x10(%rsp),%r14
    ae65:	e9 eb 00 00 00       	jmp    af55 <fwp_p_loop_own+0x355>
    ae6a:	41 80 f8 01          	cmp    $0x1,%r8b
    ae6e:	75 30                	jne    aea0 <fwp_p_loop_own+0x2a0>
    ae70:	4c 8d 04 3e          	lea    (%rsi,%rdi,1),%r8
    ae74:	8b 74 3e 20          	mov    0x20(%rsi,%rdi,1),%esi
    ae78:	48 0f af d6          	imul   %rsi,%rdx
    ae7c:	48 c1 ea 20          	shr    $0x20,%rdx
    ae80:	4c 01 c2             	add    %r8,%rdx
    ae83:	48 81 c2 28 02 00 00 	add    $0x228,%rdx
    ae8a:	80 3a 00             	cmpb   $0x0,(%rdx)
    ae8d:	0f 85 b4 01 00 00    	jne    b047 <fwp_p_loop_own+0x447>
    ae93:	66 66 66 66 2e 0f 1f 	data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    ae9a:	84 00 00 00 00 00 
    aea0:	85 ed                	test   %ebp,%ebp
    aea2:	0f 84 a0 00 00 00    	je     af48 <fwp_p_loop_own+0x348>
    aea8:	48 8b 15 49 83 00 00 	mov    0x8349(%rip),%rdx        # 131f8 <fwp_gc+0x1078>
    aeaf:	89 ee                	mov    %ebp,%esi
    aeb1:	31 ff                	xor    %edi,%edi
    aeb3:	eb 2b                	jmp    aee0 <fwp_p_loop_own+0x2e0>
    aeb5:	66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
    aebc:	00 00 00 00 
    aec0:	4e 8d 04 0a          	lea    (%rdx,%r9,1),%r8
    aec4:	49 81 c0 28 02 00 00 	add    $0x228,%r8
    aecb:	41 80 38 00          	cmpb   $0x0,(%r8)
    aecf:	74 6f                	je     af40 <fwp_p_loop_own+0x340>
    aed1:	e9 71 01 00 00       	jmp    b047 <fwp_p_loop_own+0x447>
    aed6:	66 2e 0f 1f 84 00 00 	cs nopw 0x0(%rax,%rax,1)
    aedd:	00 00 00 
    aee0:	4d 8b 04 fc          	mov    (%r12,%rdi,8),%r8
    aee4:	4d 29 d8             	sub    %r11,%r8
    aee7:	49 39 c8             	cmp    %rcx,%r8
    aeea:	73 54                	jae    af40 <fwp_p_loop_own+0x340>
    aeec:	4d 89 c1             	mov    %r8,%r9
    aeef:	49 c1 e9 10          	shr    $0x10,%r9
    aef3:	4d 69 c9 28 12 00 00 	imul   $0x1228,%r9,%r9
    aefa:	46 0f b6 14 0a       	movzbl (%rdx,%r9,1),%r10d
    aeff:	49 81 e0 ff ff 00 00 	and    $0xffff,%r8
    af06:	75 06                	jne    af0e <fwp_p_loop_own+0x30e>
    af08:	41 80 fa 02          	cmp    $0x2,%r10b
    af0c:	74 b2                	je     aec0 <fwp_p_loop_own+0x2c0>
    af0e:	41 80 fa 01          	cmp    $0x1,%r10b
    af12:	75 2c                	jne    af40 <fwp_p_loop_own+0x340>
    af14:	4e 8d 14 0a          	lea    (%rdx,%r9,1),%r10
    af18:	46 8b 4c 0a 20       	mov    0x20(%rdx,%r9,1),%r9d
    af1d:	4d 0f af c1          	imul   %r9,%r8
    af21:	49 c1 e8 20          	shr    $0x20,%r8
    af25:	4d 01 d0             	add    %r10,%r8
    af28:	49 81 c0 28 02 00 00 	add    $0x228,%r8
    af2f:	41 80 38 00          	cmpb   $0x0,(%r8)
    af33:	0f 85 0e 01 00 00    	jne    b047 <fwp_p_loop_own+0x447>
    af39:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)
    af40:	48 ff c7             	inc    %rdi
    af43:	48 39 fe             	cmp    %rdi,%rsi
    af46:	75 98                	jne    aee0 <fwp_p_loop_own+0x2e0>
    af48:	48 89 c7             	mov    %rax,%rdi
    af4b:	89 ee                	mov    %ebp,%esi
    af4d:	4c 89 e2             	mov    %r12,%rdx
    af50:	e8 5b 02 00 00       	call   b1b0 <fwp_apply>
    af55:	48 3d ff 0f 00 00    	cmp    $0xfff,%rax
    af5b:	4c 8b 7c 24 18       	mov    0x18(%rsp),%r15
    af60:	77 0e                	ja     af70 <fwp_p_loop_own+0x370>
    af62:	89 c3                	mov    %eax,%ebx
    af64:	eb 0c                	jmp    af72 <fwp_p_loop_own+0x372>
    af66:	66 2e 0f 1f 84 00 00 	cs nopw 0x0(%rax,%rax,1)
    af6d:	00 00 00 
    af70:	8b 18                	mov    (%rax),%ebx
    af72:	4c 8b 60 08          	mov    0x8(%rax),%r12
    af76:	85 db                	test   %ebx,%ebx
    af78:	0f 85 82 00 00 00    	jne    b000 <fwp_p_loop_own+0x400>
    af7e:	4c 89 e7             	mov    %r12,%rdi
    af81:	48 2b 3d 28 82 00 00 	sub    0x8228(%rip),%rdi        # 131b0 <fwp_gc+0x1030>
    af88:	48 8b 0d 49 82 00 00 	mov    0x8249(%rip),%rcx        # 131d8 <fwp_gc+0x1058>
    af8f:	48 c1 e1 10          	shl    $0x10,%rcx
    af93:	48 39 cf             	cmp    %rcx,%rdi
    af96:	73 68                	jae    b000 <fwp_p_loop_own+0x400>
    af98:	48 8b 0d 59 82 00 00 	mov    0x8259(%rip),%rcx        # 131f8 <fwp_gc+0x1078>
    af9f:	48 89 fa             	mov    %rdi,%rdx
    afa2:	48 c1 ea 10          	shr    $0x10,%rdx
    afa6:	48 69 d2 28 12 00 00 	imul   $0x1228,%rdx,%rdx
    afad:	0f b6 34 11          	movzbl (%rcx,%rdx,1),%esi
    afb1:	48 81 e7 ff ff 00 00 	and    $0xffff,%rdi
    afb8:	75 13                	jne    afcd <fwp_p_loop_own+0x3cd>
    afba:	40 80 fe 02          	cmp    $0x2,%sil
    afbe:	75 0d                	jne    afcd <fwp_p_loop_own+0x3cd>
    afc0:	48 8d 3c 11          	lea    (%rcx,%rdx,1),%rdi
    afc4:	48 81 c7 28 02 00 00 	add    $0x228,%rdi
    afcb:	eb 20                	jmp    afed <fwp_p_loop_own+0x3ed>
    afcd:	40 80 fe 01          	cmp    $0x1,%sil
    afd1:	75 2d                	jne    b000 <fwp_p_loop_own+0x400>
    afd3:	48 8d 34 11          	lea    (%rcx,%rdx,1),%rsi
    afd7:	8b 4c 11 20          	mov    0x20(%rcx,%rdx,1),%ecx
    afdb:	48 0f af f9          	imul   %rcx,%rdi
    afdf:	48 c1 ef 20          	shr    $0x20,%rdi
    afe3:	48 01 f7             	add    %rsi,%rdi
    afe6:	48 81 c7 28 02 00 00 	add    $0x228,%rdi
    afed:	0f b6 0f             	movzbl (%rdi),%ecx
    aff0:	84 c9                	test   %cl,%cl
    aff2:	74 0c                	je     b000 <fwp_p_loop_own+0x400>
    aff4:	80 f9 fe             	cmp    $0xfe,%cl
    aff7:	73 25                	jae    b01e <fwp_p_loop_own+0x41e>
    aff9:	fe c1                	inc    %cl
    affb:	88 0f                	mov    %cl,(%rdi)
    affd:	0f 1f 00             	nopl   (%rax)
    b000:	4d 85 ff             	test   %r15,%r15
    b003:	0f 84 27 fc ff ff    	je     ac30 <fwp_p_loop_own+0x30>
    b009:	48 89 c7             	mov    %rax,%rdi
    b00c:	41 ff d7             	call   *%r15
    b00f:	e9 1c fc ff ff       	jmp    ac30 <fwp_p_loop_own+0x30>
    b014:	e8 27 01 00 00       	call   b140 <fwp_preempt>
    b019:	e9 37 fc ff ff       	jmp    ac55 <fwp_p_loop_own+0x55>
    b01e:	49 89 c5             	mov    %rax,%r13
    b021:	e8 4a c5 ff ff       	call   7570 <fwp_rc_wide_dup>
    b026:	4c 89 e8             	mov    %r13,%rax
    b029:	4d 85 ff             	test   %r15,%r15
    b02c:	75 db                	jne    b009 <fwp_p_loop_own+0x409>
    b02e:	e9 fd fb ff ff       	jmp    ac30 <fwp_p_loop_own+0x30>
    b033:	48 8b 44 24 08       	mov    0x8(%rsp),%rax
    b038:	48 83 c4 28          	add    $0x28,%rsp
    b03c:	5b                   	pop    %rbx
    b03d:	41 5c                	pop    %r12
    b03f:	41 5d                	pop    %r13
    b041:	41 5e                	pop    %r14
    b043:	41 5f                	pop    %r15
    b045:	5d                   	pop    %rbp
    b046:	c3                   	ret
    b047:	e8 14 b2 ff ff       	call   6260 <fwp_flush>
    b04c:	48 8b 05 8d 6f 00 00 	mov    0x6f8d(%rip),%rax        # 11fe0 <stderr@GLIBC_2.2.5>
    b053:	48 8b 38             	mov    (%rax),%rdi
    b056:	48 8d 35 d0 43 00 00 	lea    0x43d0(%rip),%rsi        # f42d <fwp_segv.msg+0x1ed>
    b05d:	48 8d 15 9c 43 00 00 	lea    0x439c(%rip),%rdx        # f400 <fwp_segv.msg+0x1c0>
    b064:	31 c0                	xor    %eax,%eax
    b066:	e8 45 71 ff ff       	call   21b0 <fprintf@plt>
    b06b:	bf 65 00 00 00       	mov    $0x65,%edi
    b070:	e8 1b 72 ff ff       	call   2290 <exit@plt>
    b075:	66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
    b07c:	00 00 00 00 

000000000000b080 <fwp_drop7>:
    b080:	48 89 f8             	mov    %rdi,%rax
    b083:	48 2b 05 26 81 00 00 	sub    0x8126(%rip),%rax        # 131b0 <fwp_gc+0x1030>
    b08a:	48 8b 0d 47 81 00 00 	mov    0x8147(%rip),%rcx        # 131d8 <fwp_gc+0x1058>
    b091:	48 c1 e1 10          	shl    $0x10,%rcx
    b095:	48 39 c8             	cmp    %rcx,%rax
    b098:	0f 83 92 00 00 00    	jae    b130 <fwp_drop7+0xb0>
    b09e:	48 8b 0d 53 81 00 00 	mov    0x8153(%rip),%rcx        # 131f8 <fwp_gc+0x1078>
    b0a5:	48 89 c2             	mov    %rax,%rdx
    b0a8:	48 c1 ea 10          	shr    $0x10,%rdx
    b0ac:	48 69 d2 28 12 00 00 	imul   $0x1228,%rdx,%rdx
    b0b3:	0f b6 34 11          	movzbl (%rcx,%rdx,1),%esi
    b0b7:	48 25 ff ff 00 00    	and    $0xffff,%rax
    b0bd:	75 12                	jne    b0d1 <fwp_drop7+0x51>
    b0bf:	40 80 fe 02          	cmp    $0x2,%sil
    b0c3:	75 0c                	jne    b0d1 <fwp_drop7+0x51>
    b0c5:	48 8d 04 11          	lea    (%rcx,%rdx,1),%rax
    b0c9:	48 05 28 02 00 00    	add    $0x228,%rax
    b0cf:	eb 1f                	jmp    b0f0 <fwp_drop7+0x70>
    b0d1:	40 80 fe 01          	cmp    $0x1,%sil
    b0d5:	75 59                	jne    b130 <fwp_drop7+0xb0>
    b0d7:	48 8d 34 11          	lea    (%rcx,%rdx,1),%rsi
    b0db:	8b 4c 11 20          	mov    0x20(%rcx,%rdx,1),%ecx
    b0df:	48 0f af c1          	imul   %rcx,%rax
    b0e3:	48 c1 e8 20          	shr    $0x20,%rax
    b0e7:	48 01 f0             	add    %rsi,%rax
    b0ea:	48 05 28 02 00 00    	add    $0x228,%rax
    b0f0:	0f b6 08             	movzbl (%rax),%ecx
    b0f3:	85 c9                	test   %ecx,%ecx
    b0f5:	74 39                	je     b130 <fwp_drop7+0xb0>
    b0f7:	83 f9 01             	cmp    $0x1,%ecx
    b0fa:	75 28                	jne    b124 <fwp_drop7+0xa4>
    b0fc:	8b 07                	mov    (%rdi),%eax
    b0fe:	83 f8 01             	cmp    $0x1,%eax
    b101:	0f 84 99 f7 ff ff    	je     a8a0 <fwp_rc_free_obj>
    b107:	85 c0                	test   %eax,%eax
    b109:	75 25                	jne    b130 <fwp_drop7+0xb0>
    b10b:	53                   	push   %rbx
    b10c:	48 8b 47 08          	mov    0x8(%rdi),%rax
    b110:	48 89 fb             	mov    %rdi,%rbx
    b113:	48 89 c7             	mov    %rax,%rdi
    b116:	e8 e5 f0 ff ff       	call   a200 <fwp_drop6>
    b11b:	48 89 df             	mov    %rbx,%rdi
    b11e:	5b                   	pop    %rbx
    b11f:	e9 7c f7 ff ff       	jmp    a8a0 <fwp_rc_free_obj>
    b124:	81 f9 ff 00 00 00    	cmp    $0xff,%ecx
    b12a:	74 05                	je     b131 <fwp_drop7+0xb1>
    b12c:	fe c9                	dec    %cl
    b12e:	88 08                	mov    %cl,(%rax)
    b130:	c3                   	ret
    b131:	48 89 c7             	mov    %rax,%rdi
    b134:	e9 87 f4 ff ff       	jmp    a5c0 <fwp_rc_wide_drop>
    b139:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)

000000000000b140 <fwp_preempt>:
    b140:	8b 0d ae 8a 00 00    	mov    0x8aae(%rip),%ecx        # 13bf4 <fwp_slice>
    b146:	85 c9                	test   %ecx,%ecx
    b148:	74 07                	je     b151 <fwp_preempt+0x11>
    b14a:	89 0d a0 8a 00 00    	mov    %ecx,0x8aa0(%rip)        # 13bf0 <fwp_budget>
    b150:	c3                   	ret
    b151:	50                   	push   %rax
    b152:	48 8d 3d 50 45 00 00 	lea    0x4550(%rip),%rdi        # f6a9 <fwp_segv.msg+0x469>
    b159:	e8 d2 6e ff ff       	call   2030 <getenv@plt>
    b15e:	48 89 c7             	mov    %rax,%rdi
    b161:	b8 10 27 00 00       	mov    $0x2710,%eax
    b166:	48 85 ff             	test   %rdi,%rdi
    b169:	74 11                	je     b17c <fwp_preempt+0x3c>
    b16b:	80 3f 00             	cmpb   $0x0,(%rdi)
    b16e:	74 0c                	je     b17c <fwp_preempt+0x3c>
    b170:	31 f6                	xor    %esi,%esi
    b172:	ba 0a 00 00 00       	mov    $0xa,%edx
    b177:	e8 24 70 ff ff       	call   21a0 <strtoll@plt>
    b17c:	48 8d 88 00 00 00 80 	lea    -0x80000000(%rax),%rcx
    b183:	48 81 f9 01 00 00 80 	cmp    $0xffffffff80000001,%rcx
    b18a:	b9 ff ff ff 7f       	mov    $0x7fffffff,%ecx
    b18f:	0f 43 c8             	cmovae %eax,%ecx
    b192:	89 0d 5c 8a 00 00    	mov    %ecx,0x8a5c(%rip)        # 13bf4 <fwp_slice>
    b198:	48 83 c4 08          	add    $0x8,%rsp
    b19c:	89 0d 4e 8a 00 00    	mov    %ecx,0x8a4e(%rip)        # 13bf0 <fwp_budget>
    b1a2:	c3                   	ret
    b1a3:	66 66 66 66 2e 0f 1f 	data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    b1aa:	84 00 00 00 00 00 

000000000000b1b0 <fwp_apply>:
    b1b0:	55                   	push   %rbp
    b1b1:	48 89 e5             	mov    %rsp,%rbp
    b1b4:	41 57                	push   %r15
    b1b6:	41 56                	push   %r14
    b1b8:	41 55                	push   %r13
    b1ba:	41 54                	push   %r12
    b1bc:	53                   	push   %rbx
    b1bd:	48 83 ec 18          	sub    $0x18,%rsp
    b1c1:	48 89 d3             	mov    %rdx,%rbx
    b1c4:	49 89 ff             	mov    %rdi,%r15
    b1c7:	eb 23                	jmp    b1ec <fwp_apply+0x3c>
    b1c9:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)
    b1d0:	4a 8d 1c f3          	lea    (%rbx,%r14,8),%rbx
    b1d4:	31 c9                	xor    %ecx,%ecx
    b1d6:	49 89 c7             	mov    %rax,%r15
    b1d9:	4c 8b 75 c8          	mov    -0x38(%rbp),%r14
    b1dd:	48 8b 65 c0          	mov    -0x40(%rbp),%rsp
    b1e1:	89 d6                	mov    %edx,%esi
    b1e3:	83 f9 01             	cmp    $0x1,%ecx
    b1e6:	0f 84 aa 04 00 00    	je     b696 <fwp_apply+0x4e6>
    b1ec:	48 8b 05 cd 89 00 00 	mov    0x89cd(%rip),%rax        # 13bc0 <fwp_fns>
    b1f3:	41 8b 0f             	mov    (%r15),%ecx
    b1f6:	45 8b 6f 04          	mov    0x4(%r15),%r13d
    b1fa:	48 c1 e1 05          	shl    $0x5,%rcx
    b1fe:	44 8b 24 08          	mov    (%rax,%rcx,1),%r12d
    b202:	4d 85 ed             	test   %r13,%r13
    b205:	75 39                	jne    b240 <fwp_apply+0x90>
    b207:	41 8d 54 24 ff       	lea    -0x1(%r12),%edx
    b20c:	39 f2                	cmp    %esi,%edx
    b20e:	73 30                	jae    b240 <fwp_apply+0x90>
    b210:	48 89 df             	mov    %rbx,%rdi
    b213:	49 89 f7             	mov    %rsi,%r15
    b216:	ff 54 08 08          	call   *0x8(%rax,%rcx,1)
    b21a:	4c 89 fe             	mov    %r15,%rsi
    b21d:	49 89 c7             	mov    %rax,%r15
    b220:	44 39 e6             	cmp    %r12d,%esi
    b223:	0f 84 a4 02 00 00    	je     b4cd <fwp_apply+0x31d>
    b229:	4a 8d 1c e3          	lea    (%rbx,%r12,8),%rbx
    b22d:	44 29 e6             	sub    %r12d,%esi
    b230:	b9 03 00 00 00       	mov    $0x3,%ecx
    b235:	83 f9 01             	cmp    $0x1,%ecx
    b238:	75 b2                	jne    b1ec <fwp_apply+0x3c>
    b23a:	e9 57 04 00 00       	jmp    b696 <fwp_apply+0x4e6>
    b23f:	90                   	nop
    b240:	4c 89 75 c8          	mov    %r14,-0x38(%rbp)
    b244:	46 8d 34 2e          	lea    (%rsi,%r13,1),%r14d
    b248:	45 39 e6             	cmp    %r12d,%r14d
    b24b:	48 89 75 d0          	mov    %rsi,-0x30(%rbp)
    b24f:	0f 82 1a 02 00 00    	jb     b46f <fwp_apply+0x2bf>
    b255:	48 89 65 c0          	mov    %rsp,-0x40(%rbp)
    b259:	45 89 e3             	mov    %r12d,%r11d
    b25c:	41 83 fc 02          	cmp    $0x2,%r12d
    b260:	ba 01 00 00 00       	mov    $0x1,%edx
    b265:	41 0f 43 d4          	cmovae %r12d,%edx
    b269:	48 8d 14 d5 0f 00 00 	lea    0xf(,%rdx,8),%rdx
    b270:	00 
    b271:	48 83 e2 f0          	and    $0xfffffffffffffff0,%rdx
    b275:	48 89 e7             	mov    %rsp,%rdi
    b278:	48 29 d7             	sub    %rdx,%rdi
    b27b:	48 89 fc             	mov    %rdi,%rsp
    b27e:	4d 85 ed             	test   %r13,%r13
    b281:	0f 84 c9 00 00 00    	je     b350 <fwp_apply+0x1a0>
    b287:	41 83 fd 04          	cmp    $0x4,%r13d
    b28b:	72 10                	jb     b29d <fwp_apply+0xed>
    b28d:	48 89 fa             	mov    %rdi,%rdx
    b290:	4c 29 fa             	sub    %r15,%rdx
    b293:	48 83 c2 f8          	add    $0xfffffffffffffff8,%rdx
    b297:	48 83 fa 20          	cmp    $0x20,%rdx
    b29b:	73 65                	jae    b302 <fwp_apply+0x152>
    b29d:	31 d2                	xor    %edx,%edx
    b29f:	4d 89 e8             	mov    %r13,%r8
    b2a2:	49 89 d2             	mov    %rdx,%r10
    b2a5:	49 83 e0 03          	and    $0x3,%r8
    b2a9:	74 16                	je     b2c1 <fwp_apply+0x111>
    b2ab:	49 89 d2             	mov    %rdx,%r10
    b2ae:	66 90                	xchg   %ax,%ax
    b2b0:	4f 8b 4c d7 08       	mov    0x8(%r15,%r10,8),%r9
    b2b5:	4e 89 0c d7          	mov    %r9,(%rdi,%r10,8)
    b2b9:	49 ff c2             	inc    %r10
    b2bc:	49 ff c8             	dec    %r8
    b2bf:	75 ef                	jne    b2b0 <fwp_apply+0x100>
    b2c1:	4c 29 ea             	sub    %r13,%rdx
    b2c4:	48 83 fa fc          	cmp    $0xfffffffffffffffc,%rdx
    b2c8:	0f 87 82 00 00 00    	ja     b350 <fwp_apply+0x1a0>
    b2ce:	66 90                	xchg   %ax,%ax
    b2d0:	4b 8b 54 d7 08       	mov    0x8(%r15,%r10,8),%rdx
    b2d5:	4a 89 14 d7          	mov    %rdx,(%rdi,%r10,8)
    b2d9:	4b 8b 54 d7 10       	mov    0x10(%r15,%r10,8),%rdx
    b2de:	4a 89 54 d7 08       	mov    %rdx,0x8(%rdi,%r10,8)
    b2e3:	4b 8b 54 d7 18       	mov    0x18(%r15,%r10,8),%rdx
    b2e8:	4a 89 54 d7 10       	mov    %rdx,0x10(%rdi,%r10,8)
    b2ed:	4b 8b 54 d7 20       	mov    0x20(%r15,%r10,8),%rdx
    b2f2:	4a 89 54 d7 18       	mov    %rdx,0x18(%rdi,%r10,8)
    b2f7:	49 83 c2 04          	add    $0x4,%r10
    b2fb:	4d 39 d5             	cmp    %r10,%r13
    b2fe:	75 d0                	jne    b2d0 <fwp_apply+0x120>
    b300:	eb 4e                	jmp    b350 <fwp_apply+0x1a0>
    b302:	44 89 ea             	mov    %r13d,%edx
    b305:	83 e2 fc             	and    $0xfffffffc,%edx
    b308:	4e 8d 0c ed 00 00 00 	lea    0x0(,%r13,8),%r9
    b30f:	00 
    b310:	49 83 e1 e0          	and    $0xffffffffffffffe0,%r9
    b314:	45 31 c0             	xor    %r8d,%r8d
    b317:	66 0f 1f 84 00 00 00 	nopw   0x0(%rax,%rax,1)
    b31e:	00 00 
    b320:	43 0f 10 44 07 08    	movups 0x8(%r15,%r8,1),%xmm0
    b326:	43 0f 10 4c 07 18    	movups 0x18(%r15,%r8,1),%xmm1
    b32c:	42 0f 29 04 07       	movaps %xmm0,(%rdi,%r8,1)
    b331:	42 0f 29 4c 07 10    	movaps %xmm1,0x10(%rdi,%r8,1)
    b337:	49 83 c0 20          	add    $0x20,%r8
    b33b:	4d 39 c1             	cmp    %r8,%r9
    b33e:	75 e0                	jne    b320 <fwp_apply+0x170>
    b340:	4c 39 ea             	cmp    %r13,%rdx
    b343:	0f 85 56 ff ff ff    	jne    b29f <fwp_apply+0xef>
    b349:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)
    b350:	45 29 eb             	sub    %r13d,%r11d
    b353:	45 89 de             	mov    %r11d,%r14d
    b356:	45 39 ec             	cmp    %r13d,%r12d
    b359:	0f 84 85 00 00 00    	je     b3e4 <fwp_apply+0x234>
    b35f:	41 83 fb 0e          	cmp    $0xe,%r11d
    b363:	0f 83 a0 00 00 00    	jae    b409 <fwp_apply+0x259>
    b369:	31 d2                	xor    %edx,%edx
    b36b:	4d 89 f0             	mov    %r14,%r8
    b36e:	48 89 d6             	mov    %rdx,%rsi
    b371:	49 83 e0 03          	and    $0x3,%r8
    b375:	74 1d                	je     b394 <fwp_apply+0x1e4>
    b377:	48 89 d6             	mov    %rdx,%rsi
    b37a:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)
    b380:	4c 8b 0c f3          	mov    (%rbx,%rsi,8),%r9
    b384:	46 8d 14 2e          	lea    (%rsi,%r13,1),%r10d
    b388:	4e 89 0c d7          	mov    %r9,(%rdi,%r10,8)
    b38c:	48 ff c6             	inc    %rsi
    b38f:	49 ff c8             	dec    %r8
    b392:	75 ec                	jne    b380 <fwp_apply+0x1d0>
    b394:	4c 29 f2             	sub    %r14,%rdx
    b397:	48 83 fa fc          	cmp    $0xfffffffffffffffc,%rdx
    b39b:	77 47                	ja     b3e4 <fwp_apply+0x234>
    b39d:	0f 1f 00             	nopl   (%rax)
    b3a0:	48 8b 14 f3          	mov    (%rbx,%rsi,8),%rdx
    b3a4:	46 8d 04 2e          	lea    (%rsi,%r13,1),%r8d
    b3a8:	4a 89 14 c7          	mov    %rdx,(%rdi,%r8,8)
    b3ac:	48 8b 54 f3 08       	mov    0x8(%rbx,%rsi,8),%rdx
    b3b1:	46 8d 04 2e          	lea    (%rsi,%r13,1),%r8d
    b3b5:	41 ff c0             	inc    %r8d
    b3b8:	4a 89 14 c7          	mov    %rdx,(%rdi,%r8,8)
    b3bc:	48 8b 54 f3 10       	mov    0x10(%rbx,%rsi,8),%rdx
    b3c1:	45 8d 44 35 02       	lea    0x2(%r13,%rsi,1),%r8d
    b3c6:	4a 89 14 c7          	mov    %rdx,(%rdi,%r8,8)
    b3ca:	48 8b 54 f3 18       	mov    0x18(%rbx,%rsi,8),%rdx
    b3cf:	46 8d 04 2e          	lea    (%rsi,%r13,1),%r8d
    b3d3:	41 83 c0 03          	add    $0x3,%r8d
    b3d7:	4a 89 14 c7          	mov    %rdx,(%rdi,%r8,8)
    b3db:	48 83 c6 04          	add    $0x4,%rsi
    b3df:	49 39 f6             	cmp    %rsi,%r14
    b3e2:	75 bc                	jne    b3a0 <fwp_apply+0x1f0>
    b3e4:	45 89 dc             	mov    %r11d,%r12d
    b3e7:	ff 54 08 08          	call   *0x8(%rax,%rcx,1)
    b3eb:	b9 01 00 00 00       	mov    $0x1,%ecx
    b3f0:	48 8b 75 d0          	mov    -0x30(%rbp),%rsi
    b3f4:	89 f2                	mov    %esi,%edx
    b3f6:	44 29 e2             	sub    %r12d,%edx
    b3f9:	0f 85 d1 fd ff ff    	jne    b1d0 <fwp_apply+0x20>
    b3ff:	89 f2                	mov    %esi,%edx
    b401:	49 89 c6             	mov    %rax,%r14
    b404:	e9 d4 fd ff ff       	jmp    b1dd <fwp_apply+0x2d>
    b409:	49 8d 56 ff          	lea    -0x1(%r14),%rdx
    b40d:	89 d6                	mov    %edx,%esi
    b40f:	44 01 ee             	add    %r13d,%esi
    b412:	0f 82 51 ff ff ff    	jb     b369 <fwp_apply+0x1b9>
    b418:	48 c1 ea 20          	shr    $0x20,%rdx
    b41c:	ba 00 00 00 00       	mov    $0x0,%edx
    b421:	0f 85 44 ff ff ff    	jne    b36b <fwp_apply+0x1bb>
    b427:	4a 8d 14 ef          	lea    (%rdi,%r13,8),%rdx
    b42b:	48 29 da             	sub    %rbx,%rdx
    b42e:	48 83 fa 20          	cmp    $0x20,%rdx
    b432:	0f 82 31 ff ff ff    	jb     b369 <fwp_apply+0x1b9>
    b438:	44 89 f2             	mov    %r14d,%edx
    b43b:	83 e2 fc             	and    $0xfffffffc,%edx
    b43e:	31 f6                	xor    %esi,%esi
    b440:	0f 10 04 f3          	movups (%rbx,%rsi,8),%xmm0
    b444:	0f 10 4c f3 10       	movups 0x10(%rbx,%rsi,8),%xmm1
    b449:	46 8d 04 2e          	lea    (%rsi,%r13,1),%r8d
    b44d:	42 0f 11 04 c7       	movups %xmm0,(%rdi,%r8,8)
    b452:	42 0f 11 4c c7 10    	movups %xmm1,0x10(%rdi,%r8,8)
    b458:	48 83 c6 04          	add    $0x4,%rsi
    b45c:	48 39 f2             	cmp    %rsi,%rdx
    b45f:	75 df                	jne    b440 <fwp_apply+0x290>
    b461:	4c 39 f2             	cmp    %r14,%rdx
    b464:	0f 85 01 ff ff ff    	jne    b36b <fwp_apply+0x1bb>
    b46a:	e9 75 ff ff ff       	jmp    b3e4 <fwp_apply+0x234>
    b46f:	44 89 f0             	mov    %r14d,%eax
    b472:	41 81 fe ff 07 00 00 	cmp    $0x7ff,%r14d
    b479:	77 72                	ja     b4ed <fwp_apply+0x33d>
    b47b:	48 8d 14 c5 00 00 00 	lea    0x0(,%rax,8),%rdx
    b482:	00 
    b483:	48 83 c2 17          	add    $0x17,%rdx
    b487:	48 c1 ea 04          	shr    $0x4,%rdx
    b48b:	48 8d 0d ee 6c 00 00 	lea    0x6cee(%rip),%rcx        # 12180 <fwp_gc>
    b492:	0f b6 bc 0a e8 0b 00 	movzbl 0xbe8(%rdx,%rcx,1),%edi
    b499:	00 
    b49a:	8b 94 b9 48 0b 00 00 	mov    0xb48(%rcx,%rdi,4),%edx
    b4a1:	48 29 15 d8 6c 00 00 	sub    %rdx,0x6cd8(%rip)        # 12180 <fwp_gc>
    b4a8:	78 43                	js     b4ed <fwp_apply+0x33d>
    b4aa:	4c 8d 04 7f          	lea    (%rdi,%rdi,2),%r8
    b4ae:	4a 8d 3c c1          	lea    (%rcx,%r8,8),%rdi
    b4b2:	48 81 c7 88 07 00 00 	add    $0x788,%rdi
    b4b9:	4c 8b 27             	mov    (%rdi),%r12
    b4bc:	4d 85 e4             	test   %r12,%r12
    b4bf:	74 14                	je     b4d5 <fwp_apply+0x325>
    b4c1:	49 8b 04 24          	mov    (%r12),%rax
    b4c5:	48 f7 d0             	not    %rax
    b4c8:	48 89 07             	mov    %rax,(%rdi)
    b4cb:	eb 48                	jmp    b515 <fwp_apply+0x365>
    b4cd:	4d 89 fe             	mov    %r15,%r14
    b4d0:	e9 c1 01 00 00       	jmp    b696 <fwp_apply+0x4e6>
    b4d5:	4e 8b a4 c1 90 07 00 	mov    0x790(%rcx,%r8,8),%r12
    b4dc:	00 
    b4dd:	4a 8b bc c1 98 07 00 	mov    0x798(%rcx,%r8,8),%rdi
    b4e4:	00 
    b4e5:	4c 29 e7             	sub    %r12,%rdi
    b4e8:	48 39 d7             	cmp    %rdx,%rdi
    b4eb:	73 17                	jae    b504 <fwp_apply+0x354>
    b4ed:	48 8d 3c c5 08 00 00 	lea    0x8(,%rax,8),%rdi
    b4f4:	00 
    b4f5:	be 02 00 00 00       	mov    $0x2,%esi
    b4fa:	e8 b1 b1 ff ff       	call   66b0 <fwp_gc_alloc_slow>
    b4ff:	49 89 c4             	mov    %rax,%r12
    b502:	eb 1b                	jmp    b51f <fwp_apply+0x36f>
    b504:	4a 8d 04 c1          	lea    (%rcx,%r8,8),%rax
    b508:	48 05 90 07 00 00    	add    $0x790,%rax
    b50e:	49 8d 0c 14          	lea    (%r12,%rdx,1),%rcx
    b512:	48 89 08             	mov    %rcx,(%rax)
    b515:	4c 89 e7             	mov    %r12,%rdi
    b518:	31 f6                	xor    %esi,%esi
    b51a:	e8 11 6c ff ff       	call   2130 <memset@plt>
    b51f:	41 8b 07             	mov    (%r15),%eax
    b522:	41 89 04 24          	mov    %eax,(%r12)
    b526:	45 89 74 24 04       	mov    %r14d,0x4(%r12)
    b52b:	4d 85 ed             	test   %r13,%r13
    b52e:	4d 89 e6             	mov    %r12,%r14
    b531:	48 8b 7d d0          	mov    -0x30(%rbp),%rdi
    b535:	0f 84 c6 00 00 00    	je     b601 <fwp_apply+0x451>
    b53b:	31 c0                	xor    %eax,%eax
    b53d:	41 83 fd 06          	cmp    $0x6,%r13d
    b541:	72 53                	jb     b596 <fwp_apply+0x3e6>
    b543:	4c 89 f1             	mov    %r14,%rcx
    b546:	4c 29 f9             	sub    %r15,%rcx
    b549:	48 83 f9 20          	cmp    $0x20,%rcx
    b54d:	72 47                	jb     b596 <fwp_apply+0x3e6>
    b54f:	44 89 e8             	mov    %r13d,%eax
    b552:	83 e0 fc             	and    $0xfffffffc,%eax
    b555:	4a 8d 0c ed 00 00 00 	lea    0x0(,%r13,8),%rcx
    b55c:	00 
    b55d:	48 83 e1 e0          	and    $0xffffffffffffffe0,%rcx
    b561:	31 d2                	xor    %edx,%edx
    b563:	66 66 66 66 2e 0f 1f 	data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    b56a:	84 00 00 00 00 00 
    b570:	41 0f 10 44 17 08    	movups 0x8(%r15,%rdx,1),%xmm0
    b576:	41 0f 10 4c 17 18    	movups 0x18(%r15,%rdx,1),%xmm1
    b57c:	41 0f 11 44 16 08    	movups %xmm0,0x8(%r14,%rdx,1)
    b582:	41 0f 11 4c 16 18    	movups %xmm1,0x18(%r14,%rdx,1)
    b588:	48 83 c2 20          	add    $0x20,%rdx
    b58c:	48 39 d1             	cmp    %rdx,%rcx
    b58f:	75 df                	jne    b570 <fwp_apply+0x3c0>
    b591:	4c 39 e8             	cmp    %r13,%rax
    b594:	74 6b                	je     b601 <fwp_apply+0x451>
    b596:	4c 89 ea             	mov    %r13,%rdx
    b599:	48 89 c1             	mov    %rax,%rcx
    b59c:	48 83 e2 03          	and    $0x3,%rdx
    b5a0:	74 20                	je     b5c2 <fwp_apply+0x412>
    b5a2:	48 89 c1             	mov    %rax,%rcx
    b5a5:	66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
    b5ac:	00 00 00 00 
    b5b0:	49 8b 74 cf 08       	mov    0x8(%r15,%rcx,8),%rsi
    b5b5:	49 89 74 ce 08       	mov    %rsi,0x8(%r14,%rcx,8)
    b5ba:	48 ff c1             	inc    %rcx
    b5bd:	48 ff ca             	dec    %rdx
    b5c0:	75 ee                	jne    b5b0 <fwp_apply+0x400>
    b5c2:	4c 29 e8             	sub    %r13,%rax
    b5c5:	48 83 f8 fc          	cmp    $0xfffffffffffffffc,%rax
    b5c9:	77 36                	ja     b601 <fwp_apply+0x451>
    b5cb:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)
    b5d0:	49 8b 44 cf 08       	mov    0x8(%r15,%rcx,8),%rax
    b5d5:	49 89 44 ce 08       	mov    %rax,0x8(%r14,%rcx,8)
    b5da:	49 8b 44 cf 10       	mov    0x10(%r15,%rcx,8),%rax
    b5df:	49 89 44 ce 10       	mov    %rax,0x10(%r14,%rcx,8)
    b5e4:	49 8b 44 cf 18       	mov    0x18(%r15,%rcx,8),%rax
    b5e9:	49 89 44 ce 18       	mov    %rax,0x18(%r14,%rcx,8)
    b5ee:	49 8b 44 cf 20       	mov    0x20(%r15,%rcx,8),%rax
    b5f3:	49 89 44 ce 20       	mov    %rax,0x20(%r14,%rcx,8)
    b5f8:	48 83 c1 04          	add    $0x4,%rcx
    b5fc:	49 39 cd             	cmp    %rcx,%r13
    b5ff:	75 cf                	jne    b5d0 <fwp_apply+0x420>
    b601:	85 ff                	test   %edi,%edi
    b603:	0f 84 8d 00 00 00    	je     b696 <fwp_apply+0x4e6>
    b609:	89 f8                	mov    %edi,%eax
    b60b:	83 ff 14             	cmp    $0x14,%edi
    b60e:	0f 83 94 00 00 00    	jae    b6a8 <fwp_apply+0x4f8>
    b614:	31 c9                	xor    %ecx,%ecx
    b616:	48 89 c6             	mov    %rax,%rsi
    b619:	48 89 ca             	mov    %rcx,%rdx
    b61c:	48 83 e6 03          	and    $0x3,%rsi
    b620:	74 23                	je     b645 <fwp_apply+0x495>
    b622:	48 89 ca             	mov    %rcx,%rdx
    b625:	66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
    b62c:	00 00 00 00 
    b630:	48 8b 3c d3          	mov    (%rbx,%rdx,8),%rdi
    b634:	46 8d 04 2a          	lea    (%rdx,%r13,1),%r8d
    b638:	4b 89 7c c6 08       	mov    %rdi,0x8(%r14,%r8,8)
    b63d:	48 ff c2             	inc    %rdx
    b640:	48 ff ce             	dec    %rsi
    b643:	75 eb                	jne    b630 <fwp_apply+0x480>
    b645:	48 29 c1             	sub    %rax,%rcx
    b648:	48 83 f9 fc          	cmp    $0xfffffffffffffffc,%rcx
    b64c:	77 48                	ja     b696 <fwp_apply+0x4e6>
    b64e:	66 90                	xchg   %ax,%ax
    b650:	48 8b 0c d3          	mov    (%rbx,%rdx,8),%rcx
    b654:	42 8d 34 2a          	lea    (%rdx,%r13,1),%esi
    b658:	49 89 4c f6 08       	mov    %rcx,0x8(%r14,%rsi,8)
    b65d:	48 8b 4c d3 08       	mov    0x8(%rbx,%rdx,8),%rcx
    b662:	42 8d 34 2a          	lea    (%rdx,%r13,1),%esi
    b666:	ff c6                	inc    %esi
    b668:	49 89 4c f6 08       	mov    %rcx,0x8(%r14,%rsi,8)
    b66d:	48 8b 4c d3 10       	mov    0x10(%rbx,%rdx,8),%rcx
    b672:	41 8d 74 15 02       	lea    0x2(%r13,%rdx,1),%esi
    b677:	49 89 4c f6 08       	mov    %rcx,0x8(%r14,%rsi,8)
    b67c:	48 8b 4c d3 18       	mov    0x18(%rbx,%rdx,8),%rcx
    b681:	42 8d 34 2a          	lea    (%rdx,%r13,1),%esi
    b685:	83 c6 03             	add    $0x3,%esi
    b688:	49 89 4c f6 08       	mov    %rcx,0x8(%r14,%rsi,8)
    b68d:	48 83 c2 04          	add    $0x4,%rdx
    b691:	48 39 d0             	cmp    %rdx,%rax
    b694:	75 ba                	jne    b650 <fwp_apply+0x4a0>
    b696:	4c 89 f0             	mov    %r14,%rax
    b699:	48 8d 65 d8          	lea    -0x28(%rbp),%rsp
    b69d:	5b                   	pop    %rbx
    b69e:	41 5c                	pop    %r12
    b6a0:	41 5d                	pop    %r13
    b6a2:	41 5e                	pop    %r14
    b6a4:	41 5f                	pop    %r15
    b6a6:	5d                   	pop    %rbp
    b6a7:	c3                   	ret
    b6a8:	48 8d 50 ff          	lea    -0x1(%rax),%rdx
    b6ac:	31 c9                	xor    %ecx,%ecx
    b6ae:	89 d6                	mov    %edx,%esi
    b6b0:	44 01 ee             	add    %r13d,%esi
    b6b3:	0f 82 5d ff ff ff    	jb     b616 <fwp_apply+0x466>
    b6b9:	48 c1 ea 20          	shr    $0x20,%rdx
    b6bd:	0f 85 53 ff ff ff    	jne    b616 <fwp_apply+0x466>
    b6c3:	4b 8d 0c ee          	lea    (%r14,%r13,8),%rcx
    b6c7:	48 29 d9             	sub    %rbx,%rcx
    b6ca:	48 83 c1 08          	add    $0x8,%rcx
    b6ce:	48 83 f9 20          	cmp    $0x20,%rcx
    b6d2:	0f 82 3c ff ff ff    	jb     b614 <fwp_apply+0x464>
    b6d8:	89 c1                	mov    %eax,%ecx
    b6da:	83 e1 fc             	and    $0xfffffffc,%ecx
    b6dd:	31 d2                	xor    %edx,%edx
    b6df:	90                   	nop
    b6e0:	0f 10 04 d3          	movups (%rbx,%rdx,8),%xmm0
    b6e4:	0f 10 4c d3 10       	movups 0x10(%rbx,%rdx,8),%xmm1
    b6e9:	42 8d 34 2a          	lea    (%rdx,%r13,1),%esi
    b6ed:	41 0f 11 44 f6 08    	movups %xmm0,0x8(%r14,%rsi,8)
    b6f3:	41 0f 11 4c f6 18    	movups %xmm1,0x18(%r14,%rsi,8)
    b6f9:	48 83 c2 04          	add    $0x4,%rdx
    b6fd:	48 39 d1             	cmp    %rdx,%rcx
    b700:	75 de                	jne    b6e0 <fwp_apply+0x530>
    b702:	48 39 c1             	cmp    %rax,%rcx
    b705:	0f 85 0b ff ff ff    	jne    b616 <fwp_apply+0x466>
    b70b:	eb 89                	jmp    b696 <fwp_apply+0x4e6>
    b70d:	0f 1f 00             	nopl   (%rax)

000000000000b710 <fwp_apply_owned>:
    b710:	55                   	push   %rbp
    b711:	48 89 e5             	mov    %rsp,%rbp
    b714:	41 57                	push   %r15
    b716:	41 56                	push   %r14
    b718:	41 55                	push   %r13
    b71a:	41 54                	push   %r12
    b71c:	53                   	push   %rbx
    b71d:	48 83 ec 28          	sub    $0x28,%rsp
    b721:	48 89 d3             	mov    %rdx,%rbx
    b724:	41 89 f5             	mov    %esi,%r13d
    b727:	48 8b 05 92 84 00 00 	mov    0x8492(%rip),%rax        # 13bc0 <fwp_fns>
    b72e:	8b 17                	mov    (%rdi),%edx
    b730:	48 89 d6             	mov    %rdx,%rsi
    b733:	48 c1 e6 05          	shl    $0x5,%rsi
    b737:	48 8b 4c 30 18       	mov    0x18(%rax,%rsi,1),%rcx
    b73c:	48 85 c9             	test   %rcx,%rcx
    b73f:	0f 84 ca 02 00 00    	je     ba0f <fwp_apply_owned+0x2ff>
    b745:	4c 8d 04 30          	lea    (%rax,%rsi,1),%r8
    b749:	49 83 c0 18          	add    $0x18,%r8
    b74d:	49 89 fc             	mov    %rdi,%r12
    b750:	48 89 7d c0          	mov    %rdi,-0x40(%rbp)
    b754:	48 c1 e2 05          	shl    $0x5,%rdx
    b758:	8b 04 10             	mov    (%rax,%rdx,1),%eax
    b75b:	45 8b 74 24 04       	mov    0x4(%r12),%r14d
    b760:	47 8d 3c 2e          	lea    (%r14,%r13,1),%r15d
    b764:	41 39 c7             	cmp    %eax,%r15d
    b767:	0f 82 10 03 00 00    	jb     ba7d <fwp_apply_owned+0x36d>
    b76d:	41 89 c7             	mov    %eax,%r15d
    b770:	45 29 f7             	sub    %r14d,%r15d
    b773:	45 89 fa             	mov    %r15d,%r10d
    b776:	85 c0                	test   %eax,%eax
    b778:	4c 89 55 d0          	mov    %r10,-0x30(%rbp)
    b77c:	74 22                	je     b7a0 <fwp_apply_owned+0x90>
    b77e:	45 85 f6             	test   %r14d,%r14d
    b781:	75 1d                	jne    b7a0 <fwp_apply_owned+0x90>
    b783:	48 89 df             	mov    %rbx,%rdi
    b786:	ff 11                	call   *(%rcx)
    b788:	49 89 c4             	mov    %rax,%r12
    b78b:	4c 8b 75 c0          	mov    -0x40(%rbp),%r14
    b78f:	e9 35 02 00 00       	jmp    b9c9 <fwp_apply_owned+0x2b9>
    b794:	66 66 66 2e 0f 1f 84 	data16 data16 cs nopw 0x0(%rax,%rax,1)
    b79b:	00 00 00 00 00 
    b7a0:	4c 89 6d c8          	mov    %r13,-0x38(%rbp)
    b7a4:	48 89 65 b8          	mov    %rsp,-0x48(%rbp)
    b7a8:	85 c0                	test   %eax,%eax
    b7aa:	b9 01 00 00 00       	mov    $0x1,%ecx
    b7af:	0f 45 c8             	cmovne %eax,%ecx
    b7b2:	48 8d 0c cd 0f 00 00 	lea    0xf(,%rcx,8),%rcx
    b7b9:	00 
    b7ba:	48 83 e1 f0          	and    $0xfffffffffffffff0,%rcx
    b7be:	49 89 e5             	mov    %rsp,%r13
    b7c1:	49 29 cd             	sub    %rcx,%r13
    b7c4:	4c 89 ec             	mov    %r13,%rsp
    b7c7:	4d 85 f6             	test   %r14,%r14
    b7ca:	0f 84 d0 00 00 00    	je     b8a0 <fwp_apply_owned+0x190>
    b7d0:	41 83 fe 04          	cmp    $0x4,%r14d
    b7d4:	72 10                	jb     b7e6 <fwp_apply_owned+0xd6>
    b7d6:	4c 89 e9             	mov    %r13,%rcx
    b7d9:	4c 29 e1             	sub    %r12,%rcx
    b7dc:	48 83 c1 f8          	add    $0xfffffffffffffff8,%rcx
    b7e0:	48 83 f9 20          	cmp    $0x20,%rcx
    b7e4:	73 6d                	jae    b853 <fwp_apply_owned+0x143>
    b7e6:	31 c9                	xor    %ecx,%ecx
    b7e8:	4c 89 f6             	mov    %r14,%rsi
    b7eb:	48 89 ca             	mov    %rcx,%rdx
    b7ee:	48 83 e6 03          	and    $0x3,%rsi
    b7f2:	74 1e                	je     b812 <fwp_apply_owned+0x102>
    b7f4:	48 89 ca             	mov    %rcx,%rdx
    b7f7:	66 0f 1f 84 00 00 00 	nopw   0x0(%rax,%rax,1)
    b7fe:	00 00 
    b800:	49 8b 7c d4 08       	mov    0x8(%r12,%rdx,8),%rdi
    b805:	49 89 7c d5 00       	mov    %rdi,0x0(%r13,%rdx,8)
    b80a:	48 ff c2             	inc    %rdx
    b80d:	48 ff ce             	dec    %rsi
    b810:	75 ee                	jne    b800 <fwp_apply_owned+0xf0>
    b812:	4c 29 f1             	sub    %r14,%rcx
    b815:	48 83 f9 fc          	cmp    $0xfffffffffffffffc,%rcx
    b819:	0f 87 81 00 00 00    	ja     b8a0 <fwp_apply_owned+0x190>
    b81f:	90                   	nop
    b820:	49 8b 4c d4 08       	mov    0x8(%r12,%rdx,8),%rcx
    b825:	49 89 4c d5 00       	mov    %rcx,0x0(%r13,%rdx,8)
    b82a:	49 8b 4c d4 10       	mov    0x10(%r12,%rdx,8),%rcx
    b82f:	49 89 4c d5 08       	mov    %rcx,0x8(%r13,%rdx,8)
    b834:	49 8b 4c d4 18       	mov    0x18(%r12,%rdx,8),%rcx
    b839:	49 89 4c d5 10       	mov    %rcx,0x10(%r13,%rdx,8)
    b83e:	49 8b 4c d4 20       	mov    0x20(%r12,%rdx,8),%rcx
    b843:	49 89 4c d5 18       	mov    %rcx,0x18(%r13,%rdx,8)
    b848:	48 83 c2 04          	add    $0x4,%rdx
    b84c:	49 39 d6             	cmp    %rdx,%r14
    b84f:	75 cf                	jne    b820 <fwp_apply_owned+0x110>
    b851:	eb 4d                	jmp    b8a0 <fwp_apply_owned+0x190>
    b853:	44 89 f1             	mov    %r14d,%ecx
    b856:	83 e1 fc             	and    $0xfffffffc,%ecx
    b859:	4a 8d 14 f5 00 00 00 	lea    0x0(,%r14,8),%rdx
    b860:	00 
    b861:	48 83 e2 e0          	and    $0xffffffffffffffe0,%rdx
    b865:	31 f6                	xor    %esi,%esi
    b867:	66 0f 1f 84 00 00 00 	nopw   0x0(%rax,%rax,1)
    b86e:	00 00 
    b870:	41 0f 10 44 34 08    	movups 0x8(%r12,%rsi,1),%xmm0
    b876:	41 0f 10 4c 34 18    	movups 0x18(%r12,%rsi,1),%xmm1
    b87c:	41 0f 29 44 35 00    	movaps %xmm0,0x0(%r13,%rsi,1)
    b882:	41 0f 29 4c 35 10    	movaps %xmm1,0x10(%r13,%rsi,1)
    b888:	48 83 c6 20          	add    $0x20,%rsi
    b88c:	48 39 f2             	cmp    %rsi,%rdx
    b88f:	75 df                	jne    b870 <fwp_apply_owned+0x160>
    b891:	4c 39 f1             	cmp    %r14,%rcx
    b894:	0f 85 4e ff ff ff    	jne    b7e8 <fwp_apply_owned+0xd8>
    b89a:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)
    b8a0:	44 39 f0             	cmp    %r14d,%eax
    b8a3:	0f 84 f7 00 00 00    	je     b9a0 <fwp_apply_owned+0x290>
    b8a9:	41 83 ff 0a          	cmp    $0xa,%r15d
    b8ad:	0f 83 95 00 00 00    	jae    b948 <fwp_apply_owned+0x238>
    b8b3:	31 c0                	xor    %eax,%eax
    b8b5:	4c 89 d2             	mov    %r10,%rdx
    b8b8:	48 89 c1             	mov    %rax,%rcx
    b8bb:	48 83 e2 03          	and    $0x3,%rdx
    b8bf:	74 24                	je     b8e5 <fwp_apply_owned+0x1d5>
    b8c1:	48 89 c1             	mov    %rax,%rcx
    b8c4:	66 66 66 2e 0f 1f 84 	data16 data16 cs nopw 0x0(%rax,%rax,1)
    b8cb:	00 00 00 00 00 
    b8d0:	48 8b 34 cb          	mov    (%rbx,%rcx,8),%rsi
    b8d4:	41 8d 3c 0e          	lea    (%r14,%rcx,1),%edi
    b8d8:	49 89 74 fd 00       	mov    %rsi,0x0(%r13,%rdi,8)
    b8dd:	48 ff c1             	inc    %rcx
    b8e0:	48 ff ca             	dec    %rdx
    b8e3:	75 eb                	jne    b8d0 <fwp_apply_owned+0x1c0>
    b8e5:	4c 29 d0             	sub    %r10,%rax
    b8e8:	48 83 f8 fc          	cmp    $0xfffffffffffffffc,%rax
    b8ec:	0f 87 ae 00 00 00    	ja     b9a0 <fwp_apply_owned+0x290>
    b8f2:	66 66 66 66 66 2e 0f 	data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    b8f9:	1f 84 00 00 00 00 00 
    b900:	48 8b 04 cb          	mov    (%rbx,%rcx,8),%rax
    b904:	41 8d 14 0e          	lea    (%r14,%rcx,1),%edx
    b908:	49 89 44 d5 00       	mov    %rax,0x0(%r13,%rdx,8)
    b90d:	48 8b 44 cb 08       	mov    0x8(%rbx,%rcx,8),%rax
    b912:	41 8d 14 0e          	lea    (%r14,%rcx,1),%edx
    b916:	ff c2                	inc    %edx
    b918:	49 89 44 d5 00       	mov    %rax,0x0(%r13,%rdx,8)
    b91d:	48 8b 44 cb 10       	mov    0x10(%rbx,%rcx,8),%rax
    b922:	41 8d 54 0e 02       	lea    0x2(%r14,%rcx,1),%edx
    b927:	49 89 44 d5 00       	mov    %rax,0x0(%r13,%rdx,8)
    b92c:	48 8b 44 cb 18       	mov    0x18(%rbx,%rcx,8),%rax
    b931:	41 8d 14 0e          	lea    (%r14,%rcx,1),%edx
    b935:	83 c2 03             	add    $0x3,%edx
    b938:	49 89 44 d5 00       	mov    %rax,0x0(%r13,%rdx,8)
    b93d:	48 83 c1 04          	add    $0x4,%rcx
    b941:	49 39 ca             	cmp    %rcx,%r10
    b944:	75 ba                	jne    b900 <fwp_apply_owned+0x1f0>
    b946:	eb 58                	jmp    b9a0 <fwp_apply_owned+0x290>
    b948:	49 8d 42 ff          	lea    -0x1(%r10),%rax
    b94c:	89 c1                	mov    %eax,%ecx
    b94e:	44 01 f1             	add    %r14d,%ecx
    b951:	0f 82 5c ff ff ff    	jb     b8b3 <fwp_apply_owned+0x1a3>
    b957:	48 c1 e8 20          	shr    $0x20,%rax
    b95b:	b8 00 00 00 00       	mov    $0x0,%eax
    b960:	0f 85 4f ff ff ff    	jne    b8b5 <fwp_apply_owned+0x1a5>
    b966:	44 89 d0             	mov    %r10d,%eax
    b969:	83 e0 fc             	and    $0xfffffffc,%eax
    b96c:	31 c9                	xor    %ecx,%ecx
    b96e:	66 90                	xchg   %ax,%ax
    b970:	0f 10 04 cb          	movups (%rbx,%rcx,8),%xmm0
    b974:	0f 10 4c cb 10       	movups 0x10(%rbx,%rcx,8),%xmm1
    b979:	41 8d 14 0e          	lea    (%r14,%rcx,1),%edx
    b97d:	41 0f 11 44 d5 00    	movups %xmm0,0x0(%r13,%rdx,8)
    b983:	41 0f 11 4c d5 10    	movups %xmm1,0x10(%r13,%rdx,8)
    b989:	48 83 c1 04          	add    $0x4,%rcx
    b98d:	48 39 c8             	cmp    %rcx,%rax
    b990:	75 de                	jne    b970 <fwp_apply_owned+0x260>
    b992:	4c 39 d0             	cmp    %r10,%rax
    b995:	0f 85 1a ff ff ff    	jne    b8b5 <fwp_apply_owned+0x1a5>
    b99b:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)
    b9a0:	49 8b 00             	mov    (%r8),%rax
    b9a3:	4c 8b 75 c0          	mov    -0x40(%rbp),%r14
    b9a7:	4c 89 f7             	mov    %r14,%rdi
    b9aa:	be 01 00 00 00       	mov    $0x1,%esi
    b9af:	4d 89 c4             	mov    %r8,%r12
    b9b2:	ff 50 08             	call   *0x8(%rax)
    b9b5:	49 8b 04 24          	mov    (%r12),%rax
    b9b9:	4c 89 ef             	mov    %r13,%rdi
    b9bc:	ff 10                	call   *(%rax)
    b9be:	49 89 c4             	mov    %rax,%r12
    b9c1:	48 8b 65 b8          	mov    -0x48(%rbp),%rsp
    b9c5:	4c 8b 6d c8          	mov    -0x38(%rbp),%r13
    b9c9:	4c 89 f7             	mov    %r14,%rdi
    b9cc:	e8 af 05 00 00       	call   bf80 <fwp_closure_drop>
    b9d1:	45 29 fd             	sub    %r15d,%r13d
    b9d4:	0f 84 89 05 00 00    	je     bf63 <fwp_apply_owned+0x853>
    b9da:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
    b9de:	48 8d 1c c3          	lea    (%rbx,%rax,8),%rbx
    b9e2:	48 8b 05 d7 81 00 00 	mov    0x81d7(%rip),%rax        # 13bc0 <fwp_fns>
    b9e9:	41 8b 14 24          	mov    (%r12),%edx
    b9ed:	48 89 d1             	mov    %rdx,%rcx
    b9f0:	48 c1 e1 05          	shl    $0x5,%rcx
    b9f4:	4c 8d 04 08          	lea    (%rax,%rcx,1),%r8
    b9f8:	49 83 c0 18          	add    $0x18,%r8
    b9fc:	48 8b 4c 08 18       	mov    0x18(%rax,%rcx,1),%rcx
    ba01:	4c 89 e7             	mov    %r12,%rdi
    ba04:	48 85 c9             	test   %rcx,%rcx
    ba07:	0f 85 43 fd ff ff    	jne    b750 <fwp_apply_owned+0x40>
    ba0d:	eb 03                	jmp    ba12 <fwp_apply_owned+0x302>
    ba0f:	49 89 fc             	mov    %rdi,%r12
    ba12:	48 8b 05 97 77 00 00 	mov    0x7797(%rip),%rax        # 131b0 <fwp_gc+0x1030>
    ba19:	4c 89 e2             	mov    %r12,%rdx
    ba1c:	48 29 c2             	sub    %rax,%rdx
    ba1f:	48 8b 0d b2 77 00 00 	mov    0x77b2(%rip),%rcx        # 131d8 <fwp_gc+0x1058>
    ba26:	48 c1 e1 10          	shl    $0x10,%rcx
    ba2a:	48 39 ca             	cmp    %rcx,%rdx
    ba2d:	0f 83 12 01 00 00    	jae    bb45 <fwp_apply_owned+0x435>
    ba33:	48 8b 35 be 77 00 00 	mov    0x77be(%rip),%rsi        # 131f8 <fwp_gc+0x1078>
    ba3a:	48 89 d7             	mov    %rdx,%rdi
    ba3d:	48 c1 ef 10          	shr    $0x10,%rdi
    ba41:	48 69 ff 28 12 00 00 	imul   $0x1228,%rdi,%rdi
    ba48:	44 0f b6 04 3e       	movzbl (%rsi,%rdi,1),%r8d
    ba4d:	48 81 e2 ff ff 00 00 	and    $0xffff,%rdx
    ba54:	0f 85 c2 00 00 00    	jne    bb1c <fwp_apply_owned+0x40c>
    ba5a:	41 80 f8 02          	cmp    $0x2,%r8b
    ba5e:	0f 85 b8 00 00 00    	jne    bb1c <fwp_apply_owned+0x40c>
    ba64:	48 8d 14 3e          	lea    (%rsi,%rdi,1),%rdx
    ba68:	48 81 c2 28 02 00 00 	add    $0x228,%rdx
    ba6f:	80 3a 00             	cmpb   $0x0,(%rdx)
    ba72:	0f 84 cd 00 00 00    	je     bb45 <fwp_apply_owned+0x435>
    ba78:	e9 55 01 00 00       	jmp    bbd2 <fwp_apply_owned+0x4c2>
    ba7d:	4c 89 45 d0          	mov    %r8,-0x30(%rbp)
    ba81:	4c 89 6d c8          	mov    %r13,-0x38(%rbp)
    ba85:	44 89 f9             	mov    %r15d,%ecx
    ba88:	48 8d 3c cd 08 00 00 	lea    0x8(,%rcx,8),%rdi
    ba8f:	00 
    ba90:	41 81 ff ff 07 00 00 	cmp    $0x7ff,%r15d
    ba97:	0f 87 f0 01 00 00    	ja     bc8d <fwp_apply_owned+0x57d>
    ba9d:	48 c1 e1 03          	shl    $0x3,%rcx
    baa1:	4c 8d 41 17          	lea    0x17(%rcx),%r8
    baa5:	49 c1 e8 04          	shr    $0x4,%r8
    baa9:	48 8d 05 d0 66 00 00 	lea    0x66d0(%rip),%rax        # 12180 <fwp_gc>
    bab0:	41 0f b6 b4 00 e8 0b 	movzbl 0xbe8(%r8,%rax,1),%esi
    bab7:	00 00 
    bab9:	8b 94 b0 48 0b 00 00 	mov    0xb48(%rax,%rsi,4),%edx
    bac0:	4c 8b 0d b9 66 00 00 	mov    0x66b9(%rip),%r9        # 12180 <fwp_gc>
    bac7:	4d 89 ca             	mov    %r9,%r10
    baca:	49 29 d2             	sub    %rdx,%r10
    bacd:	4c 89 15 ac 66 00 00 	mov    %r10,0x66ac(%rip)        # 12180 <fwp_gc>
    bad4:	0f 88 b3 01 00 00    	js     bc8d <fwp_apply_owned+0x57d>
    bada:	4c 8d 14 76          	lea    (%rsi,%rsi,2),%r10
    bade:	4e 8d 1c d0          	lea    (%rax,%r10,8),%r11
    bae2:	49 83 c3 08          	add    $0x8,%r11
    bae6:	4d 8b 2b             	mov    (%r11),%r13
    bae9:	4d 85 ed             	test   %r13,%r13
    baec:	0f 84 24 01 00 00    	je     bc16 <fwp_apply_owned+0x506>
    baf2:	49 8b 45 00          	mov    0x0(%r13),%rax
    baf6:	48 f7 d0             	not    %rax
    baf9:	49 89 03             	mov    %rax,(%r11)
    bafc:	48 39 d7             	cmp    %rdx,%rdi
    baff:	0f 83 ad 01 00 00    	jae    bcb2 <fwp_apply_owned+0x5a2>
    bb05:	4c 01 ef             	add    %r13,%rdi
    bb08:	48 29 ca             	sub    %rcx,%rdx
    bb0b:	48 83 c2 f7          	add    $0xfffffffffffffff7,%rdx
    bb0f:	48 83 e2 f8          	and    $0xfffffffffffffff8,%rdx
    bb13:	48 83 c2 08          	add    $0x8,%rdx
    bb17:	e9 8f 01 00 00       	jmp    bcab <fwp_apply_owned+0x59b>
    bb1c:	41 80 f8 01          	cmp    $0x1,%r8b
    bb20:	75 23                	jne    bb45 <fwp_apply_owned+0x435>
    bb22:	4c 8d 04 3e          	lea    (%rsi,%rdi,1),%r8
    bb26:	8b 74 3e 20          	mov    0x20(%rsi,%rdi,1),%esi
    bb2a:	48 0f af d6          	imul   %rsi,%rdx
    bb2e:	48 c1 ea 20          	shr    $0x20,%rdx
    bb32:	4c 01 c2             	add    %r8,%rdx
    bb35:	48 81 c2 28 02 00 00 	add    $0x228,%rdx
    bb3c:	80 3a 00             	cmpb   $0x0,(%rdx)
    bb3f:	0f 85 8d 00 00 00    	jne    bbd2 <fwp_apply_owned+0x4c2>
    bb45:	45 85 ed             	test   %r13d,%r13d
    bb48:	0f 84 b2 00 00 00    	je     bc00 <fwp_apply_owned+0x4f0>
    bb4e:	48 8b 15 a3 76 00 00 	mov    0x76a3(%rip),%rdx        # 131f8 <fwp_gc+0x1078>
    bb55:	44 89 ee             	mov    %r13d,%esi
    bb58:	31 ff                	xor    %edi,%edi
    bb5a:	eb 21                	jmp    bb7d <fwp_apply_owned+0x46d>
    bb5c:	0f 1f 40 00          	nopl   0x0(%rax)
    bb60:	4e 8d 04 0a          	lea    (%rdx,%r9,1),%r8
    bb64:	49 81 c0 28 02 00 00 	add    $0x228,%r8
    bb6b:	41 80 38 00          	cmpb   $0x0,(%r8)
    bb6f:	75 61                	jne    bbd2 <fwp_apply_owned+0x4c2>
    bb71:	48 ff c7             	inc    %rdi
    bb74:	48 39 fe             	cmp    %rdi,%rsi
    bb77:	0f 84 83 00 00 00    	je     bc00 <fwp_apply_owned+0x4f0>
    bb7d:	4c 8b 04 fb          	mov    (%rbx,%rdi,8),%r8
    bb81:	49 29 c0             	sub    %rax,%r8
    bb84:	49 39 c8             	cmp    %rcx,%r8
    bb87:	73 e8                	jae    bb71 <fwp_apply_owned+0x461>
    bb89:	4d 89 c1             	mov    %r8,%r9
    bb8c:	49 c1 e9 10          	shr    $0x10,%r9
    bb90:	4d 69 c9 28 12 00 00 	imul   $0x1228,%r9,%r9
    bb97:	46 0f b6 14 0a       	movzbl (%rdx,%r9,1),%r10d
    bb9c:	49 81 e0 ff ff 00 00 	and    $0xffff,%r8
    bba3:	75 06                	jne    bbab <fwp_apply_owned+0x49b>
    bba5:	41 80 fa 02          	cmp    $0x2,%r10b
    bba9:	74 b5                	je     bb60 <fwp_apply_owned+0x450>
    bbab:	41 80 fa 01          	cmp    $0x1,%r10b
    bbaf:	75 c0                	jne    bb71 <fwp_apply_owned+0x461>
    bbb1:	4e 8d 14 0a          	lea    (%rdx,%r9,1),%r10
    bbb5:	46 8b 4c 0a 20       	mov    0x20(%rdx,%r9,1),%r9d
    bbba:	4d 0f af c1          	imul   %r9,%r8
    bbbe:	49 c1 e8 20          	shr    $0x20,%r8
    bbc2:	4d 01 d0             	add    %r10,%r8
    bbc5:	49 81 c0 28 02 00 00 	add    $0x228,%r8
    bbcc:	41 80 38 00          	cmpb   $0x0,(%r8)
    bbd0:	74 9f                	je     bb71 <fwp_apply_owned+0x461>
    bbd2:	e8 89 a6 ff ff       	call   6260 <fwp_flush>
    bbd7:	48 8b 05 02 64 00 00 	mov    0x6402(%rip),%rax        # 11fe0 <stderr@GLIBC_2.2.5>
    bbde:	48 8b 38             	mov    (%rax),%rdi
    bbe1:	48 8d 35 45 38 00 00 	lea    0x3845(%rip),%rsi        # f42d <fwp_segv.msg+0x1ed>
    bbe8:	48 8d 15 11 38 00 00 	lea    0x3811(%rip),%rdx        # f400 <fwp_segv.msg+0x1c0>
    bbef:	31 c0                	xor    %eax,%eax
    bbf1:	e8 ba 65 ff ff       	call   21b0 <fprintf@plt>
    bbf6:	bf 65 00 00 00       	mov    $0x65,%edi
    bbfb:	e8 90 66 ff ff       	call   2290 <exit@plt>
    bc00:	4c 89 e7             	mov    %r12,%rdi
    bc03:	44 89 ee             	mov    %r13d,%esi
    bc06:	48 89 da             	mov    %rbx,%rdx
    bc09:	e8 a2 f5 ff ff       	call   b1b0 <fwp_apply>
    bc0e:	49 89 c4             	mov    %rax,%r12
    bc11:	e9 4d 03 00 00       	jmp    bf63 <fwp_apply_owned+0x853>
    bc16:	4e 8b 6c d0 10       	mov    0x10(%rax,%r10,8),%r13
    bc1b:	4e 8b 5c d0 18       	mov    0x18(%rax,%r10,8),%r11
    bc20:	4d 29 eb             	sub    %r13,%r11
    bc23:	49 39 d3             	cmp    %rdx,%r11
    bc26:	72 34                	jb     bc5c <fwp_apply_owned+0x54c>
    bc28:	4a 8d 34 d0          	lea    (%rax,%r10,8),%rsi
    bc2c:	48 83 c6 10          	add    $0x10,%rsi
    bc30:	4e 8d 14 2a          	lea    (%rdx,%r13,1),%r10
    bc34:	4c 89 16             	mov    %r10,(%rsi)
    bc37:	4d 85 ed             	test   %r13,%r13
    bc3a:	0f 85 bc fe ff ff    	jne    bafc <fwp_apply_owned+0x3ec>
    bc40:	41 0f b6 b4 00 e8 0b 	movzbl 0xbe8(%r8,%rax,1),%esi
    bc47:	00 00 
    bc49:	8b 94 b0 48 0b 00 00 	mov    0xb48(%rax,%rsi,4),%edx
    bc50:	49 29 d1             	sub    %rdx,%r9
    bc53:	4c 89 0d 26 65 00 00 	mov    %r9,0x6526(%rip)        # 12180 <fwp_gc>
    bc5a:	78 31                	js     bc8d <fwp_apply_owned+0x57d>
    bc5c:	48 8d 0c 76          	lea    (%rsi,%rsi,2),%rcx
    bc60:	4c 8b 6c c8 08       	mov    0x8(%rax,%rcx,8),%r13
    bc65:	4d 85 ed             	test   %r13,%r13
    bc68:	74 11                	je     bc7b <fwp_apply_owned+0x56b>
    bc6a:	48 8d 04 c8          	lea    (%rax,%rcx,8),%rax
    bc6e:	48 83 c0 08          	add    $0x8,%rax
    bc72:	49 8b 4d 00          	mov    0x0(%r13),%rcx
    bc76:	48 f7 d1             	not    %rcx
    bc79:	eb 2a                	jmp    bca5 <fwp_apply_owned+0x595>
    bc7b:	4c 8b 6c c8 10       	mov    0x10(%rax,%rcx,8),%r13
    bc80:	48 8b 74 c8 18       	mov    0x18(%rax,%rcx,8),%rsi
    bc85:	4c 29 ee             	sub    %r13,%rsi
    bc88:	48 39 d6             	cmp    %rdx,%rsi
    bc8b:	73 0c                	jae    bc99 <fwp_apply_owned+0x589>
    bc8d:	31 f6                	xor    %esi,%esi
    bc8f:	e8 1c aa ff ff       	call   66b0 <fwp_gc_alloc_slow>
    bc94:	49 89 c5             	mov    %rax,%r13
    bc97:	eb 19                	jmp    bcb2 <fwp_apply_owned+0x5a2>
    bc99:	48 8d 04 c8          	lea    (%rax,%rcx,8),%rax
    bc9d:	48 83 c0 10          	add    $0x10,%rax
    bca1:	4a 8d 0c 2a          	lea    (%rdx,%r13,1),%rcx
    bca5:	48 89 08             	mov    %rcx,(%rax)
    bca8:	4c 89 ef             	mov    %r13,%rdi
    bcab:	31 f6                	xor    %esi,%esi
    bcad:	e8 7e 64 ff ff       	call   2130 <memset@plt>
    bcb2:	4c 8b 4d d0          	mov    -0x30(%rbp),%r9
    bcb6:	41 8b 04 24          	mov    (%r12),%eax
    bcba:	41 89 45 00          	mov    %eax,0x0(%r13)
    bcbe:	45 89 7d 04          	mov    %r15d,0x4(%r13)
    bcc2:	4d 85 f6             	test   %r14,%r14
    bcc5:	0f 84 c6 00 00 00    	je     bd91 <fwp_apply_owned+0x681>
    bccb:	31 c0                	xor    %eax,%eax
    bccd:	41 83 fe 06          	cmp    $0x6,%r14d
    bcd1:	72 53                	jb     bd26 <fwp_apply_owned+0x616>
    bcd3:	4c 89 e9             	mov    %r13,%rcx
    bcd6:	4c 29 e1             	sub    %r12,%rcx
    bcd9:	48 83 f9 20          	cmp    $0x20,%rcx
    bcdd:	72 47                	jb     bd26 <fwp_apply_owned+0x616>
    bcdf:	44 89 f0             	mov    %r14d,%eax
    bce2:	83 e0 fc             	and    $0xfffffffc,%eax
    bce5:	4a 8d 0c f5 00 00 00 	lea    0x0(,%r14,8),%rcx
    bcec:	00 
    bced:	48 83 e1 e0          	and    $0xffffffffffffffe0,%rcx
    bcf1:	31 d2                	xor    %edx,%edx
    bcf3:	66 66 66 66 2e 0f 1f 	data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    bcfa:	84 00 00 00 00 00 
    bd00:	41 0f 10 44 14 08    	movups 0x8(%r12,%rdx,1),%xmm0
    bd06:	41 0f 10 4c 14 18    	movups 0x18(%r12,%rdx,1),%xmm1
    bd0c:	41 0f 11 44 15 08    	movups %xmm0,0x8(%r13,%rdx,1)
    bd12:	41 0f 11 4c 15 18    	movups %xmm1,0x18(%r13,%rdx,1)
    bd18:	48 83 c2 20          	add    $0x20,%rdx
    bd1c:	48 39 d1             	cmp    %rdx,%rcx
    bd1f:	75 df                	jne    bd00 <fwp_apply_owned+0x5f0>
    bd21:	4c 39 f0             	cmp    %r14,%rax
    bd24:	74 6b                	je     bd91 <fwp_apply_owned+0x681>
    bd26:	4c 89 f2             	mov    %r14,%rdx
    bd29:	48 89 c1             	mov    %rax,%rcx
    bd2c:	48 83 e2 03          	and    $0x3,%rdx
    bd30:	74 20                	je     bd52 <fwp_apply_owned+0x642>
    bd32:	48 89 c1             	mov    %rax,%rcx
    bd35:	66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
    bd3c:	00 00 00 00 
    bd40:	49 8b 74 cc 08       	mov    0x8(%r12,%rcx,8),%rsi
    bd45:	49 89 74 cd 08       	mov    %rsi,0x8(%r13,%rcx,8)
    bd4a:	48 ff c1             	inc    %rcx
    bd4d:	48 ff ca             	dec    %rdx
    bd50:	75 ee                	jne    bd40 <fwp_apply_owned+0x630>
    bd52:	4c 29 f0             	sub    %r14,%rax
    bd55:	48 83 f8 fc          	cmp    $0xfffffffffffffffc,%rax
    bd59:	77 36                	ja     bd91 <fwp_apply_owned+0x681>
    bd5b:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)
    bd60:	49 8b 44 cc 08       	mov    0x8(%r12,%rcx,8),%rax
    bd65:	49 89 44 cd 08       	mov    %rax,0x8(%r13,%rcx,8)
    bd6a:	49 8b 44 cc 10       	mov    0x10(%r12,%rcx,8),%rax
    bd6f:	49 89 44 cd 10       	mov    %rax,0x10(%r13,%rcx,8)
    bd74:	49 8b 44 cc 18       	mov    0x18(%r12,%rcx,8),%rax
    bd79:	49 89 44 cd 18       	mov    %rax,0x18(%r13,%rcx,8)
    bd7e:	49 8b 44 cc 20       	mov    0x20(%r12,%rcx,8),%rax
    bd83:	49 89 44 cd 20       	mov    %rax,0x20(%r13,%rcx,8)
    bd88:	48 83 c1 04          	add    $0x4,%rcx
    bd8c:	49 39 ce             	cmp    %rcx,%r14
    bd8f:	75 cf                	jne    bd60 <fwp_apply_owned+0x650>
    bd91:	48 8b 4d c8          	mov    -0x38(%rbp),%rcx
    bd95:	85 c9                	test   %ecx,%ecx
    bd97:	0f 84 89 00 00 00    	je     be26 <fwp_apply_owned+0x716>
    bd9d:	89 c8                	mov    %ecx,%eax
    bd9f:	83 f9 14             	cmp    $0x14,%ecx
    bda2:	0f 83 fb 00 00 00    	jae    bea3 <fwp_apply_owned+0x793>
    bda8:	31 c9                	xor    %ecx,%ecx
    bdaa:	48 89 c6             	mov    %rax,%rsi
    bdad:	48 89 ca             	mov    %rcx,%rdx
    bdb0:	48 83 e6 03          	and    $0x3,%rsi
    bdb4:	74 1f                	je     bdd5 <fwp_apply_owned+0x6c5>
    bdb6:	48 89 ca             	mov    %rcx,%rdx
    bdb9:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)
    bdc0:	48 8b 3c d3          	mov    (%rbx,%rdx,8),%rdi
    bdc4:	45 8d 04 16          	lea    (%r14,%rdx,1),%r8d
    bdc8:	4b 89 7c c5 08       	mov    %rdi,0x8(%r13,%r8,8)
    bdcd:	48 ff c2             	inc    %rdx
    bdd0:	48 ff ce             	dec    %rsi
    bdd3:	75 eb                	jne    bdc0 <fwp_apply_owned+0x6b0>
    bdd5:	48 29 c1             	sub    %rax,%rcx
    bdd8:	48 83 f9 fc          	cmp    $0xfffffffffffffffc,%rcx
    bddc:	77 48                	ja     be26 <fwp_apply_owned+0x716>
    bdde:	66 90                	xchg   %ax,%ax
    bde0:	48 8b 0c d3          	mov    (%rbx,%rdx,8),%rcx
    bde4:	41 8d 34 16          	lea    (%r14,%rdx,1),%esi
    bde8:	49 89 4c f5 08       	mov    %rcx,0x8(%r13,%rsi,8)
    bded:	48 8b 4c d3 08       	mov    0x8(%rbx,%rdx,8),%rcx
    bdf2:	41 8d 34 16          	lea    (%r14,%rdx,1),%esi
    bdf6:	ff c6                	inc    %esi
    bdf8:	49 89 4c f5 08       	mov    %rcx,0x8(%r13,%rsi,8)
    bdfd:	48 8b 4c d3 10       	mov    0x10(%rbx,%rdx,8),%rcx
    be02:	41 8d 74 16 02       	lea    0x2(%r14,%rdx,1),%esi
    be07:	49 89 4c f5 08       	mov    %rcx,0x8(%r13,%rsi,8)
    be0c:	48 8b 4c d3 18       	mov    0x18(%rbx,%rdx,8),%rcx
    be11:	41 8d 34 16          	lea    (%r14,%rdx,1),%esi
    be15:	83 c6 03             	add    $0x3,%esi
    be18:	49 89 4c f5 08       	mov    %rcx,0x8(%r13,%rsi,8)
    be1d:	48 83 c2 04          	add    $0x4,%rdx
    be21:	48 39 d0             	cmp    %rdx,%rax
    be24:	75 ba                	jne    bde0 <fwp_apply_owned+0x6d0>
    be26:	49 8b 01             	mov    (%r9),%rax
    be29:	4c 8b 75 c0          	mov    -0x40(%rbp),%r14
    be2d:	4c 89 f7             	mov    %r14,%rdi
    be30:	be 01 00 00 00       	mov    $0x1,%esi
    be35:	ff 50 08             	call   *0x8(%rax)
    be38:	4c 89 e8             	mov    %r13,%rax
    be3b:	48 2b 05 6e 73 00 00 	sub    0x736e(%rip),%rax        # 131b0 <fwp_gc+0x1030>
    be42:	48 8b 0d 8f 73 00 00 	mov    0x738f(%rip),%rcx        # 131d8 <fwp_gc+0x1058>
    be49:	48 c1 e1 10          	shl    $0x10,%rcx
    be4d:	48 39 c8             	cmp    %rcx,%rax
    be50:	0f 83 02 01 00 00    	jae    bf58 <fwp_apply_owned+0x848>
    be56:	48 8b 0d 9b 73 00 00 	mov    0x739b(%rip),%rcx        # 131f8 <fwp_gc+0x1078>
    be5d:	48 89 c2             	mov    %rax,%rdx
    be60:	48 c1 ea 10          	shr    $0x10,%rdx
    be64:	48 69 d2 28 12 00 00 	imul   $0x1228,%rdx,%rdx
    be6b:	0f b6 34 11          	movzbl (%rcx,%rdx,1),%esi
    be6f:	48 25 ff ff 00 00    	and    $0xffff,%rax
    be75:	0f 85 a5 00 00 00    	jne    bf20 <fwp_apply_owned+0x810>
    be7b:	40 80 fe 02          	cmp    $0x2,%sil
    be7f:	0f 85 9b 00 00 00    	jne    bf20 <fwp_apply_owned+0x810>
    be85:	4c 8d 3c 11          	lea    (%rcx,%rdx,1),%r15
    be89:	49 81 c7 28 02 00 00 	add    $0x228,%r15
    be90:	41 80 3f ff          	cmpb   $0xff,(%r15)
    be94:	0f 84 b1 00 00 00    	je     bf4b <fwp_apply_owned+0x83b>
    be9a:	41 c6 07 01          	movb   $0x1,(%r15)
    be9e:	e9 b5 00 00 00       	jmp    bf58 <fwp_apply_owned+0x848>
    bea3:	48 8d 50 ff          	lea    -0x1(%rax),%rdx
    bea7:	31 c9                	xor    %ecx,%ecx
    bea9:	89 d6                	mov    %edx,%esi
    beab:	44 01 f6             	add    %r14d,%esi
    beae:	0f 82 f6 fe ff ff    	jb     bdaa <fwp_apply_owned+0x69a>
    beb4:	48 c1 ea 20          	shr    $0x20,%rdx
    beb8:	0f 85 ec fe ff ff    	jne    bdaa <fwp_apply_owned+0x69a>
    bebe:	4a 8d 0c f5 00 00 00 	lea    0x0(,%r14,8),%rcx
    bec5:	00 
    bec6:	4c 01 e9             	add    %r13,%rcx
    bec9:	48 29 d9             	sub    %rbx,%rcx
    becc:	48 83 c1 08          	add    $0x8,%rcx
    bed0:	48 83 f9 20          	cmp    $0x20,%rcx
    bed4:	0f 82 ce fe ff ff    	jb     bda8 <fwp_apply_owned+0x698>
    beda:	89 c1                	mov    %eax,%ecx
    bedc:	83 e1 fc             	and    $0xfffffffc,%ecx
    bedf:	31 d2                	xor    %edx,%edx
    bee1:	66 66 66 66 66 66 2e 	data16 data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    bee8:	0f 1f 84 00 00 00 00 
    beef:	00 
    bef0:	0f 10 04 d3          	movups (%rbx,%rdx,8),%xmm0
    bef4:	0f 10 4c d3 10       	movups 0x10(%rbx,%rdx,8),%xmm1
    bef9:	41 8d 34 16          	lea    (%r14,%rdx,1),%esi
    befd:	41 0f 11 44 f5 08    	movups %xmm0,0x8(%r13,%rsi,8)
    bf03:	41 0f 11 4c f5 18    	movups %xmm1,0x18(%r13,%rsi,8)
    bf09:	48 83 c2 04          	add    $0x4,%rdx
    bf0d:	48 39 d1             	cmp    %rdx,%rcx
    bf10:	75 de                	jne    bef0 <fwp_apply_owned+0x7e0>
    bf12:	48 39 c1             	cmp    %rax,%rcx
    bf15:	0f 85 8f fe ff ff    	jne    bdaa <fwp_apply_owned+0x69a>
    bf1b:	e9 06 ff ff ff       	jmp    be26 <fwp_apply_owned+0x716>
    bf20:	40 80 fe 01          	cmp    $0x1,%sil
    bf24:	75 32                	jne    bf58 <fwp_apply_owned+0x848>
    bf26:	48 8d 34 11          	lea    (%rcx,%rdx,1),%rsi
    bf2a:	8b 4c 11 20          	mov    0x20(%rcx,%rdx,1),%ecx
    bf2e:	48 0f af c1          	imul   %rcx,%rax
    bf32:	48 c1 e8 20          	shr    $0x20,%rax
    bf36:	4c 8d 3c 30          	lea    (%rax,%rsi,1),%r15
    bf3a:	49 81 c7 28 02 00 00 	add    $0x228,%r15
    bf41:	41 80 3f ff          	cmpb   $0xff,(%r15)
    bf45:	0f 85 4f ff ff ff    	jne    be9a <fwp_apply_owned+0x78a>
    bf4b:	4c 89 ff             	mov    %r15,%rdi
    bf4e:	e8 3d a3 ff ff       	call   6290 <fwp_rc_forget_slot>
    bf53:	e9 42 ff ff ff       	jmp    be9a <fwp_apply_owned+0x78a>
    bf58:	4c 89 f7             	mov    %r14,%rdi
    bf5b:	e8 20 00 00 00       	call   bf80 <fwp_closure_drop>
    bf60:	4d 89 ec             	mov    %r13,%r12
    bf63:	4c 89 e0             	mov    %r12,%rax
    bf66:	48 8d 65 d8          	lea    -0x28(%rbp),%rsp
    bf6a:	5b                   	pop    %rbx
    bf6b:	41 5c                	pop    %r12
    bf6d:	41 5d                	pop    %r13
    bf6f:	41 5e                	pop    %r14
    bf71:	41 5f                	pop    %r15
    bf73:	5d                   	pop    %rbp
    bf74:	c3                   	ret
    bf75:	66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
    bf7c:	00 00 00 00 

000000000000bf80 <fwp_closure_drop>:
    bf80:	41 57                	push   %r15
    bf82:	41 56                	push   %r14
    bf84:	53                   	push   %rbx
    bf85:	48 81 ec 30 02 00 00 	sub    $0x230,%rsp
    bf8c:	48 89 f8             	mov    %rdi,%rax
    bf8f:	48 2b 05 1a 72 00 00 	sub    0x721a(%rip),%rax        # 131b0 <fwp_gc+0x1030>
    bf96:	48 8b 0d 3b 72 00 00 	mov    0x723b(%rip),%rcx        # 131d8 <fwp_gc+0x1058>
    bf9d:	48 c1 e1 10          	shl    $0x10,%rcx
    bfa1:	48 39 c8             	cmp    %rcx,%rax
    bfa4:	0f 83 91 00 00 00    	jae    c03b <fwp_closure_drop+0xbb>
    bfaa:	48 89 fe             	mov    %rdi,%rsi
    bfad:	48 8b 0d 44 72 00 00 	mov    0x7244(%rip),%rcx        # 131f8 <fwp_gc+0x1078>
    bfb4:	48 89 c2             	mov    %rax,%rdx
    bfb7:	48 c1 ea 10          	shr    $0x10,%rdx
    bfbb:	48 69 d2 28 12 00 00 	imul   $0x1228,%rdx,%rdx
    bfc2:	0f b6 3c 11          	movzbl (%rcx,%rdx,1),%edi
    bfc6:	48 25 ff ff 00 00    	and    $0xffff,%rax
    bfcc:	75 13                	jne    bfe1 <fwp_closure_drop+0x61>
    bfce:	40 80 ff 02          	cmp    $0x2,%dil
    bfd2:	75 0d                	jne    bfe1 <fwp_closure_drop+0x61>
    bfd4:	48 8d 3c 11          	lea    (%rcx,%rdx,1),%rdi
    bfd8:	48 81 c7 28 02 00 00 	add    $0x228,%rdi
    bfdf:	eb 20                	jmp    c001 <fwp_closure_drop+0x81>
    bfe1:	40 80 ff 01          	cmp    $0x1,%dil
    bfe5:	75 54                	jne    c03b <fwp_closure_drop+0xbb>
    bfe7:	48 8d 3c 11          	lea    (%rcx,%rdx,1),%rdi
    bfeb:	8b 4c 11 20          	mov    0x20(%rcx,%rdx,1),%ecx
    bfef:	48 0f af c1          	imul   %rcx,%rax
    bff3:	48 c1 e8 20          	shr    $0x20,%rax
    bff7:	48 01 c7             	add    %rax,%rdi
    bffa:	48 81 c7 28 02 00 00 	add    $0x228,%rdi
    c001:	0f b6 07             	movzbl (%rdi),%eax
    c004:	85 c0                	test   %eax,%eax
    c006:	74 33                	je     c03b <fwp_closure_drop+0xbb>
    c008:	83 f8 01             	cmp    $0x1,%eax
    c00b:	75 1f                	jne    c02c <fwp_closure_drop+0xac>
    c00d:	64 48 8b 3c 25 f8 ff 	mov    %fs:0xfffffffffffffff8,%rdi
    c014:	ff ff 
    c016:	48 85 ff             	test   %rdi,%rdi
    c019:	74 2d                	je     c048 <fwp_closure_drop+0xc8>
    c01b:	48 81 c4 30 02 00 00 	add    $0x230,%rsp
    c022:	5b                   	pop    %rbx
    c023:	41 5e                	pop    %r14
    c025:	41 5f                	pop    %r15
    c027:	e9 44 01 00 00       	jmp    c170 <fwp_closure_drop_push>
    c02c:	3d ff 00 00 00       	cmp    $0xff,%eax
    c031:	0f 84 e7 00 00 00    	je     c11e <fwp_closure_drop+0x19e>
    c037:	fe c8                	dec    %al
    c039:	88 07                	mov    %al,(%rdi)
    c03b:	48 81 c4 30 02 00 00 	add    $0x230,%rsp
    c042:	5b                   	pop    %rbx
    c043:	41 5e                	pop    %r14
    c045:	41 5f                	pop    %r15
    c047:	c3                   	ret
    c048:	64 48 8b 04 25 00 00 	mov    %fs:0x0,%rax
    c04f:	00 00 
    c051:	4c 8d b0 f8 ff ff ff 	lea    -0x8(%rax),%r14
    c058:	48 8d 5c 24 30       	lea    0x30(%rsp),%rbx
    c05d:	48 89 5c 24 18       	mov    %rbx,0x18(%rsp)
    c062:	48 c7 44 24 20 00 00 	movq   $0x0,0x20(%rsp)
    c069:	00 00 
    c06b:	48 c7 44 24 28 40 00 	movq   $0x40,0x28(%rsp)
    c072:	00 00 
    c074:	48 8b 05 6d 7b 00 00 	mov    0x7b6d(%rip),%rax        # 13be8 <fwp_cleanups>
    c07b:	48 89 04 24          	mov    %rax,(%rsp)
    c07f:	48 8d 05 ca 01 00 00 	lea    0x1ca(%rip),%rax        # c250 <fwp_closure_drop_release>
    c086:	48 89 44 24 08       	mov    %rax,0x8(%rsp)
    c08b:	48 8d 7c 24 18       	lea    0x18(%rsp),%rdi
    c090:	48 89 7c 24 10       	mov    %rdi,0x10(%rsp)
    c095:	49 89 e7             	mov    %rsp,%r15
    c098:	4c 89 3d 49 7b 00 00 	mov    %r15,0x7b49(%rip)        # 13be8 <fwp_cleanups>
    c09f:	49 89 3e             	mov    %rdi,(%r14)
    c0a2:	e8 c9 00 00 00       	call   c170 <fwp_closure_drop_push>
    c0a7:	66 0f 1f 84 00 00 00 	nopw   0x0(%rax,%rax,1)
    c0ae:	00 00 
    c0b0:	48 8b 44 24 20       	mov    0x20(%rsp),%rax
    c0b5:	48 85 c0             	test   %rax,%rax
    c0b8:	74 31                	je     c0eb <fwp_closure_drop+0x16b>
    c0ba:	48 8b 4c 24 18       	mov    0x18(%rsp),%rcx
    c0bf:	48 8d 50 ff          	lea    -0x1(%rax),%rdx
    c0c3:	48 89 54 24 20       	mov    %rdx,0x20(%rsp)
    c0c8:	48 8b 7c c1 f8       	mov    -0x8(%rcx,%rax,8),%rdi
    c0cd:	48 8b 05 ec 7a 00 00 	mov    0x7aec(%rip),%rax        # 13bc0 <fwp_fns>
    c0d4:	8b 0f                	mov    (%rdi),%ecx
    c0d6:	48 c1 e1 05          	shl    $0x5,%rcx
    c0da:	48 8b 44 08 18       	mov    0x18(%rax,%rcx,1),%rax
    c0df:	48 85 c0             	test   %rax,%rax
    c0e2:	74 4b                	je     c12f <fwp_closure_drop+0x1af>
    c0e4:	31 f6                	xor    %esi,%esi
    c0e6:	ff 50 08             	call   *0x8(%rax)
    c0e9:	eb c5                	jmp    c0b0 <fwp_closure_drop+0x130>
    c0eb:	4c 39 3d f6 7a 00 00 	cmp    %r15,0x7af6(%rip)        # 13be8 <fwp_cleanups>
    c0f2:	75 69                	jne    c15d <fwp_closure_drop+0x1dd>
    c0f4:	48 8b 04 24          	mov    (%rsp),%rax
    c0f8:	48 89 05 e9 7a 00 00 	mov    %rax,0x7ae9(%rip)        # 13be8 <fwp_cleanups>
    c0ff:	49 c7 06 00 00 00 00 	movq   $0x0,(%r14)
    c106:	48 8b 7c 24 18       	mov    0x18(%rsp),%rdi
    c10b:	48 39 df             	cmp    %rbx,%rdi
    c10e:	0f 84 27 ff ff ff    	je     c03b <fwp_closure_drop+0xbb>
    c114:	e8 37 5f ff ff       	call   2050 <free@plt>
    c119:	e9 1d ff ff ff       	jmp    c03b <fwp_closure_drop+0xbb>
    c11e:	48 81 c4 30 02 00 00 	add    $0x230,%rsp
    c125:	5b                   	pop    %rbx
    c126:	41 5e                	pop    %r14
    c128:	41 5f                	pop    %r15
    c12a:	e9 91 e4 ff ff       	jmp    a5c0 <fwp_rc_wide_drop>
    c12f:	e8 2c a1 ff ff       	call   6260 <fwp_flush>
    c134:	48 8b 05 a5 5e 00 00 	mov    0x5ea5(%rip),%rax        # 11fe0 <stderr@GLIBC_2.2.5>
    c13b:	48 8b 38             	mov    (%rax),%rdi
    c13e:	48 8d 35 e8 32 00 00 	lea    0x32e8(%rip),%rsi        # f42d <fwp_segv.msg+0x1ed>
    c145:	48 8d 15 69 35 00 00 	lea    0x3569(%rip),%rdx        # f6b5 <fwp_segv.msg+0x475>
    c14c:	31 c0                	xor    %eax,%eax
    c14e:	e8 5d 60 ff ff       	call   21b0 <fprintf@plt>
    c153:	bf 65 00 00 00       	mov    $0x65,%edi
    c158:	e8 33 61 ff ff       	call   2290 <exit@plt>
    c15d:	e8 fe 5e ff ff       	call   2060 <abort@plt>
    c162:	66 66 66 66 66 2e 0f 	data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    c169:	1f 84 00 00 00 00 00 

000000000000c170 <fwp_closure_drop_push>:
    c170:	55                   	push   %rbp
    c171:	41 57                	push   %r15
    c173:	41 56                	push   %r14
    c175:	41 55                	push   %r13
    c177:	41 54                	push   %r12
    c179:	53                   	push   %rbx
    c17a:	50                   	push   %rax
    c17b:	48 89 f3             	mov    %rsi,%rbx
    c17e:	49 89 fe             	mov    %rdi,%r14
    c181:	4c 8b 6f 08          	mov    0x8(%rdi),%r13
    c185:	4c 3b 6f 10          	cmp    0x10(%rdi),%r13
    c189:	75 59                	jne    c1e4 <fwp_closure_drop_push+0x74>
    c18b:	4c 89 e8             	mov    %r13,%rax
    c18e:	48 c1 e8 3c          	shr    $0x3c,%rax
    c192:	75 6e                	jne    c202 <fwp_closure_drop_push+0x92>
    c194:	4c 89 ef             	mov    %r13,%rdi
    c197:	48 c1 e7 04          	shl    $0x4,%rdi
    c19b:	e8 50 60 ff ff       	call   21f0 <malloc@plt>
    c1a0:	48 85 c0             	test   %rax,%rax
    c1a3:	74 7c                	je     c221 <fwp_closure_drop_push+0xb1>
    c1a5:	49 89 c7             	mov    %rax,%r15
    c1a8:	4a 8d 2c 6d 00 00 00 	lea    0x0(,%r13,2),%rbp
    c1af:	00 
    c1b0:	4d 8b 26             	mov    (%r14),%r12
    c1b3:	4a 8d 14 ed 00 00 00 	lea    0x0(,%r13,8),%rdx
    c1ba:	00 
    c1bb:	48 89 c7             	mov    %rax,%rdi
    c1be:	4c 89 e6             	mov    %r12,%rsi
    c1c1:	e8 1a 60 ff ff       	call   21e0 <memcpy@plt>
    c1c6:	49 8d 46 18          	lea    0x18(%r14),%rax
    c1ca:	49 39 c4             	cmp    %rax,%r12
    c1cd:	74 0c                	je     c1db <fwp_closure_drop_push+0x6b>
    c1cf:	4c 89 e7             	mov    %r12,%rdi
    c1d2:	e8 79 5e ff ff       	call   2050 <free@plt>
    c1d7:	4d 8b 6e 08          	mov    0x8(%r14),%r13
    c1db:	4d 89 3e             	mov    %r15,(%r14)
    c1de:	49 89 6e 10          	mov    %rbp,0x10(%r14)
    c1e2:	eb 03                	jmp    c1e7 <fwp_closure_drop_push+0x77>
    c1e4:	4d 8b 3e             	mov    (%r14),%r15
    c1e7:	49 8d 45 01          	lea    0x1(%r13),%rax
    c1eb:	49 89 46 08          	mov    %rax,0x8(%r14)
    c1ef:	4b 89 1c ef          	mov    %rbx,(%r15,%r13,8)
    c1f3:	48 83 c4 08          	add    $0x8,%rsp
    c1f7:	5b                   	pop    %rbx
    c1f8:	41 5c                	pop    %r12
    c1fa:	41 5d                	pop    %r13
    c1fc:	41 5e                	pop    %r14
    c1fe:	41 5f                	pop    %r15
    c200:	5d                   	pop    %rbp
    c201:	c3                   	ret
    c202:	e8 59 a0 ff ff       	call   6260 <fwp_flush>
    c207:	48 8b 05 d2 5d 00 00 	mov    0x5dd2(%rip),%rax        # 11fe0 <stderr@GLIBC_2.2.5>
    c20e:	48 8b 38             	mov    (%rax),%rdi
    c211:	48 8d 35 15 32 00 00 	lea    0x3215(%rip),%rsi        # f42d <fwp_segv.msg+0x1ed>
    c218:	48 8d 15 c4 34 00 00 	lea    0x34c4(%rip),%rdx        # f6e3 <fwp_segv.msg+0x4a3>
    c21f:	eb 1d                	jmp    c23e <fwp_closure_drop_push+0xce>
    c221:	e8 3a a0 ff ff       	call   6260 <fwp_flush>
    c226:	48 8b 05 b3 5d 00 00 	mov    0x5db3(%rip),%rax        # 11fe0 <stderr@GLIBC_2.2.5>
    c22d:	48 8b 38             	mov    (%rax),%rdi
    c230:	48 8d 35 f6 31 00 00 	lea    0x31f6(%rip),%rsi        # f42d <fwp_segv.msg+0x1ed>
    c237:	48 8d 15 bf 34 00 00 	lea    0x34bf(%rip),%rdx        # f6fd <fwp_segv.msg+0x4bd>
    c23e:	31 c0                	xor    %eax,%eax
    c240:	e8 6b 5f ff ff       	call   21b0 <fprintf@plt>
    c245:	bf 65 00 00 00       	mov    $0x65,%edi
    c24a:	e8 41 60 ff ff       	call   2290 <exit@plt>
    c24f:	90                   	nop

000000000000c250 <fwp_closure_drop_release>:
    c250:	41 56                	push   %r14
    c252:	53                   	push   %rbx
    c253:	50                   	push   %rax
    c254:	48 89 fb             	mov    %rdi,%rbx
    c257:	64 48 c7 04 25 f8 ff 	movq   $0x0,%fs:0xfffffffffffffff8
    c25e:	ff ff 00 00 00 00 
    c264:	48 8b 3f             	mov    (%rdi),%rdi
    c267:	4c 8d 73 18          	lea    0x18(%rbx),%r14
    c26b:	4c 39 f7             	cmp    %r14,%rdi
    c26e:	74 05                	je     c275 <fwp_closure_drop_release+0x25>
    c270:	e8 db 5d ff ff       	call   2050 <free@plt>
    c275:	4c 89 33             	mov    %r14,(%rbx)
    c278:	48 c7 43 08 00 00 00 	movq   $0x0,0x8(%rbx)
    c27f:	00 
    c280:	48 83 c4 08          	add    $0x8,%rsp
    c284:	5b                   	pop    %rbx
    c285:	41 5e                	pop    %r14
    c287:	c3                   	ret
    c288:	0f 1f 84 00 00 00 00 	nopl   0x0(%rax,%rax,1)
    c28f:	00 

000000000000c290 <f52>:
    c290:	41 57                	push   %r15
    c292:	41 56                	push   %r14
    c294:	53                   	push   %rbx
    c295:	48 83 ec 20          	sub    $0x20,%rsp
    c299:	48 89 fb             	mov    %rdi,%rbx
    c29c:	48 8b 47 10          	mov    0x10(%rdi),%rax
    c2a0:	48 2b 05 09 6f 00 00 	sub    0x6f09(%rip),%rax        # 131b0 <fwp_gc+0x1030>
    c2a7:	48 8b 0d 2a 6f 00 00 	mov    0x6f2a(%rip),%rcx        # 131d8 <fwp_gc+0x1058>
    c2ae:	48 c1 e1 10          	shl    $0x10,%rcx
    c2b2:	48 39 c8             	cmp    %rcx,%rax
    c2b5:	73 68                	jae    c31f <f52+0x8f>
    c2b7:	48 8b 0d 3a 6f 00 00 	mov    0x6f3a(%rip),%rcx        # 131f8 <fwp_gc+0x1078>
    c2be:	48 89 c2             	mov    %rax,%rdx
    c2c1:	48 c1 ea 10          	shr    $0x10,%rdx
    c2c5:	48 69 d2 28 12 00 00 	imul   $0x1228,%rdx,%rdx
    c2cc:	0f b6 34 11          	movzbl (%rcx,%rdx,1),%esi
    c2d0:	48 25 ff ff 00 00    	and    $0xffff,%rax
    c2d6:	75 13                	jne    c2eb <f52+0x5b>
    c2d8:	40 80 fe 02          	cmp    $0x2,%sil
    c2dc:	75 0d                	jne    c2eb <f52+0x5b>
    c2de:	48 8d 3c 11          	lea    (%rcx,%rdx,1),%rdi
    c2e2:	48 81 c7 28 02 00 00 	add    $0x228,%rdi
    c2e9:	eb 21                	jmp    c30c <f52+0x7c>
    c2eb:	40 80 fe 01          	cmp    $0x1,%sil
    c2ef:	75 2e                	jne    c31f <f52+0x8f>
    c2f1:	48 8d 34 11          	lea    (%rcx,%rdx,1),%rsi
    c2f5:	8b 4c 11 20          	mov    0x20(%rcx,%rdx,1),%ecx
    c2f9:	48 0f af c1          	imul   %rcx,%rax
    c2fd:	48 c1 e8 20          	shr    $0x20,%rax
    c301:	48 8d 3c 30          	lea    (%rax,%rsi,1),%rdi
    c305:	48 81 c7 28 02 00 00 	add    $0x228,%rdi
    c30c:	0f b6 07             	movzbl (%rdi),%eax
    c30f:	84 c0                	test   %al,%al
    c311:	74 0c                	je     c31f <f52+0x8f>
    c313:	3c fe                	cmp    $0xfe,%al
    c315:	0f 83 e5 02 00 00    	jae    c600 <f52+0x370>
    c31b:	fe c0                	inc    %al
    c31d:	88 07                	mov    %al,(%rdi)
    c31f:	4c 8b 7b 08          	mov    0x8(%rbx),%r15
    c323:	48 8b 7b 10          	mov    0x10(%rbx),%rdi
    c327:	48 8b 43 18          	mov    0x18(%rbx),%rax
    c32b:	4d 85 ff             	test   %r15,%r15
    c32e:	78 27                	js     c357 <f52+0xc7>
    c330:	48 8b 0f             	mov    (%rdi),%rcx
    c333:	48 ba ff ff ff ff ff 	movabs $0x7fffffffffffffff,%rdx
    c33a:	ff ff 7f 
    c33d:	48 21 ca             	and    %rcx,%rdx
    c340:	4c 39 fa             	cmp    %r15,%rdx
    c343:	76 12                	jbe    c357 <f52+0xc7>
    c345:	48 85 c9             	test   %rcx,%rcx
    c348:	0f 88 8e 00 00 00    	js     c3dc <f52+0x14c>
    c34e:	48 8d 4f 08          	lea    0x8(%rdi),%rcx
    c352:	e9 89 00 00 00       	jmp    c3e0 <f52+0x150>
    c357:	41 89 c6             	mov    %eax,%r14d
    c35a:	e8 71 03 00 00       	call   c6d0 <fwp_drop8>
    c35f:	48 89 df             	mov    %rbx,%rdi
    c362:	e8 b9 02 00 00       	call   c620 <fwp_drop9>
    c367:	48 c7 44 24 08 01 00 	movq   $0x1,0x8(%rsp)
    c36e:	00 00 
    c370:	48 8d 54 24 10       	lea    0x10(%rsp),%rdx
    c375:	4c 89 74 24 10       	mov    %r14,0x10(%rsp)
    c37a:	bf 01 00 00 00       	mov    $0x1,%edi
    c37f:	be 01 00 00 00       	mov    $0x1,%esi
    c384:	e8 d7 d9 ff ff       	call   9d60 <fwp_data>
    c389:	48 89 c1             	mov    %rax,%rcx
    c38c:	48 2b 0d 1d 6e 00 00 	sub    0x6e1d(%rip),%rcx        # 131b0 <fwp_gc+0x1030>
    c393:	48 8b 15 3e 6e 00 00 	mov    0x6e3e(%rip),%rdx        # 131d8 <fwp_gc+0x1058>
    c39a:	48 c1 e2 10          	shl    $0x10,%rdx
    c39e:	48 39 d1             	cmp    %rdx,%rcx
    c3a1:	0f 83 4f 02 00 00    	jae    c5f6 <f52+0x366>
    c3a7:	48 8b 15 4a 6e 00 00 	mov    0x6e4a(%rip),%rdx        # 131f8 <fwp_gc+0x1078>
    c3ae:	48 89 ce             	mov    %rcx,%rsi
    c3b1:	48 c1 ee 10          	shr    $0x10,%rsi
    c3b5:	48 69 f6 28 12 00 00 	imul   $0x1228,%rsi,%rsi
    c3bc:	0f b6 3c 32          	movzbl (%rdx,%rsi,1),%edi
    c3c0:	48 81 e1 ff ff 00 00 	and    $0xffff,%rcx
    c3c7:	0f 85 f3 01 00 00    	jne    c5c0 <f52+0x330>
    c3cd:	40 80 ff 02          	cmp    $0x2,%dil
    c3d1:	0f 84 d4 01 00 00    	je     c5ab <f52+0x31b>
    c3d7:	e9 e4 01 00 00       	jmp    c5c0 <f52+0x330>
    c3dc:	48 8b 4f 10          	mov    0x10(%rdi),%rcx
    c3e0:	89 44 24 04          	mov    %eax,0x4(%rsp)
    c3e4:	f3 42 0f 10 04 b9    	movss  (%rcx,%r15,4),%xmm0
    c3ea:	f3 0f 59 05 12 2c 00 	mulss  0x2c12(%rip),%xmm0        # f004 <_IO_stdin_used+0x4>
    c3f1:	00 
    c3f2:	f3 0f 58 05 0e 2c 00 	addss  0x2c0e(%rip),%xmm0        # f008 <_IO_stdin_used+0x8>
    c3f9:	00 
    c3fa:	f3 0f 11 04 24       	movss  %xmm0,(%rsp)
    c3ff:	48 89 f8             	mov    %rdi,%rax
    c402:	48 2b 05 a7 6d 00 00 	sub    0x6da7(%rip),%rax        # 131b0 <fwp_gc+0x1030>
    c409:	49 ff c7             	inc    %r15
    c40c:	48 8b 0d c5 6d 00 00 	mov    0x6dc5(%rip),%rcx        # 131d8 <fwp_gc+0x1058>
    c413:	48 c1 e1 10          	shl    $0x10,%rcx
    c417:	48 39 c8             	cmp    %rcx,%rax
    c41a:	73 66                	jae    c482 <f52+0x1f2>
    c41c:	48 8b 0d d5 6d 00 00 	mov    0x6dd5(%rip),%rcx        # 131f8 <fwp_gc+0x1078>
    c423:	48 89 c2             	mov    %rax,%rdx
    c426:	48 c1 ea 10          	shr    $0x10,%rdx
    c42a:	48 69 d2 28 12 00 00 	imul   $0x1228,%rdx,%rdx
    c431:	0f b6 34 11          	movzbl (%rcx,%rdx,1),%esi
    c435:	48 25 ff ff 00 00    	and    $0xffff,%rax
    c43b:	75 12                	jne    c44f <f52+0x1bf>
    c43d:	40 80 fe 02          	cmp    $0x2,%sil
    c441:	75 0c                	jne    c44f <f52+0x1bf>
    c443:	48 8d 04 11          	lea    (%rcx,%rdx,1),%rax
    c447:	48 05 28 02 00 00    	add    $0x228,%rax
    c44d:	eb 1f                	jmp    c46e <f52+0x1de>
    c44f:	40 80 fe 01          	cmp    $0x1,%sil
    c453:	75 2d                	jne    c482 <f52+0x1f2>
    c455:	48 8d 34 11          	lea    (%rcx,%rdx,1),%rsi
    c459:	8b 4c 11 20          	mov    0x20(%rcx,%rdx,1),%ecx
    c45d:	48 0f af c1          	imul   %rcx,%rax
    c461:	48 c1 e8 20          	shr    $0x20,%rax
    c465:	48 01 f0             	add    %rsi,%rax
    c468:	48 05 28 02 00 00    	add    $0x228,%rax
    c46e:	0f b6 08             	movzbl (%rax),%ecx
    c471:	84 c9                	test   %cl,%cl
    c473:	74 0d                	je     c482 <f52+0x1f2>
    c475:	80 f9 fe             	cmp    $0xfe,%cl
    c478:	0f 83 8c 01 00 00    	jae    c60a <f52+0x37a>
    c47e:	fe c1                	inc    %cl
    c480:	88 08                	mov    %cl,(%rax)
    c482:	49 89 fe             	mov    %rdi,%r14
    c485:	e8 46 02 00 00       	call   c6d0 <fwp_drop8>
    c48a:	f3 0f 10 04 24       	movss  (%rsp),%xmm0
    c48f:	f3 0f 58 44 24 04    	addss  0x4(%rsp),%xmm0
    c495:	66 0f 7e c0          	movd   %xmm0,%eax
    c499:	4c 89 7c 24 08       	mov    %r15,0x8(%rsp)
    c49e:	4c 89 74 24 10       	mov    %r14,0x10(%rsp)
    c4a3:	48 89 44 24 18       	mov    %rax,0x18(%rsp)
    c4a8:	48 8d 54 24 08       	lea    0x8(%rsp),%rdx
    c4ad:	31 ff                	xor    %edi,%edi
    c4af:	be 03 00 00 00       	mov    $0x3,%esi
    c4b4:	e8 a7 d8 ff ff       	call   9d60 <fwp_data>
    c4b9:	49 89 c6             	mov    %rax,%r14
    c4bc:	48 2b 05 ed 6c 00 00 	sub    0x6ced(%rip),%rax        # 131b0 <fwp_gc+0x1030>
    c4c3:	48 8b 0d 0e 6d 00 00 	mov    0x6d0e(%rip),%rcx        # 131d8 <fwp_gc+0x1058>
    c4ca:	48 c1 e1 10          	shl    $0x10,%rcx
    c4ce:	48 39 c8             	cmp    %rcx,%rax
    c4d1:	73 6f                	jae    c542 <f52+0x2b2>
    c4d3:	48 8b 0d 1e 6d 00 00 	mov    0x6d1e(%rip),%rcx        # 131f8 <fwp_gc+0x1078>
    c4da:	48 89 c2             	mov    %rax,%rdx
    c4dd:	48 c1 ea 10          	shr    $0x10,%rdx
    c4e1:	48 69 d2 28 12 00 00 	imul   $0x1228,%rdx,%rdx
    c4e8:	0f b6 34 11          	movzbl (%rcx,%rdx,1),%esi
    c4ec:	48 25 ff ff 00 00    	and    $0xffff,%rax
    c4f2:	75 1d                	jne    c511 <f52+0x281>
    c4f4:	40 80 fe 02          	cmp    $0x2,%sil
    c4f8:	75 17                	jne    c511 <f52+0x281>
    c4fa:	4c 8d 3c 11          	lea    (%rcx,%rdx,1),%r15
    c4fe:	49 81 c7 28 02 00 00 	add    $0x228,%r15
    c505:	41 80 3f ff          	cmpb   $0xff,(%r15)
    c509:	74 2d                	je     c538 <f52+0x2a8>
    c50b:	41 c6 07 01          	movb   $0x1,(%r15)
    c50f:	eb 31                	jmp    c542 <f52+0x2b2>
    c511:	40 80 fe 01          	cmp    $0x1,%sil
    c515:	75 2b                	jne    c542 <f52+0x2b2>
    c517:	48 8d 34 11          	lea    (%rcx,%rdx,1),%rsi
    c51b:	8b 4c 11 20          	mov    0x20(%rcx,%rdx,1),%ecx
    c51f:	48 0f af c1          	imul   %rcx,%rax
    c523:	48 c1 e8 20          	shr    $0x20,%rax
    c527:	4c 8d 3c 30          	lea    (%rax,%rsi,1),%r15
    c52b:	49 81 c7 28 02 00 00 	add    $0x228,%r15
    c532:	41 80 3f ff          	cmpb   $0xff,(%r15)
    c536:	75 d3                	jne    c50b <f52+0x27b>
    c538:	4c 89 ff             	mov    %r15,%rdi
    c53b:	e8 50 9d ff ff       	call   6290 <fwp_rc_forget_slot>
    c540:	eb c9                	jmp    c50b <f52+0x27b>
    c542:	48 89 df             	mov    %rbx,%rdi
    c545:	e8 d6 00 00 00       	call   c620 <fwp_drop9>
    c54a:	48 c7 44 24 08 00 00 	movq   $0x0,0x8(%rsp)
    c551:	00 00 
    c553:	48 8d 54 24 10       	lea    0x10(%rsp),%rdx
    c558:	4c 89 74 24 10       	mov    %r14,0x10(%rsp)
    c55d:	31 ff                	xor    %edi,%edi
    c55f:	be 01 00 00 00       	mov    $0x1,%esi
    c564:	e8 f7 d7 ff ff       	call   9d60 <fwp_data>
    c569:	48 89 c1             	mov    %rax,%rcx
    c56c:	48 2b 0d 3d 6c 00 00 	sub    0x6c3d(%rip),%rcx        # 131b0 <fwp_gc+0x1030>
    c573:	48 8b 15 5e 6c 00 00 	mov    0x6c5e(%rip),%rdx        # 131d8 <fwp_gc+0x1058>
    c57a:	48 c1 e2 10          	shl    $0x10,%rdx
    c57e:	48 39 d1             	cmp    %rdx,%rcx
    c581:	73 73                	jae    c5f6 <f52+0x366>
    c583:	48 8b 15 6e 6c 00 00 	mov    0x6c6e(%rip),%rdx        # 131f8 <fwp_gc+0x1078>
    c58a:	48 89 ce             	mov    %rcx,%rsi
    c58d:	48 c1 ee 10          	shr    $0x10,%rsi
    c591:	48 69 f6 28 12 00 00 	imul   $0x1228,%rsi,%rsi
    c598:	0f b6 3c 32          	movzbl (%rdx,%rsi,1),%edi
    c59c:	48 81 e1 ff ff 00 00 	and    $0xffff,%rcx
    c5a3:	75 1b                	jne    c5c0 <f52+0x330>
    c5a5:	40 80 ff 02          	cmp    $0x2,%dil
    c5a9:	75 15                	jne    c5c0 <f52+0x330>
    c5ab:	48 8d 1c 32          	lea    (%rdx,%rsi,1),%rbx
    c5af:	48 81 c3 28 02 00 00 	add    $0x228,%rbx
    c5b6:	80 3b ff             	cmpb   $0xff,(%rbx)
    c5b9:	74 2b                	je     c5e6 <f52+0x356>
    c5bb:	c6 03 01             	movb   $0x1,(%rbx)
    c5be:	eb 36                	jmp    c5f6 <f52+0x366>
    c5c0:	40 80 ff 01          	cmp    $0x1,%dil
    c5c4:	75 30                	jne    c5f6 <f52+0x366>
    c5c6:	48 8d 3c 32          	lea    (%rdx,%rsi,1),%rdi
    c5ca:	8b 54 32 20          	mov    0x20(%rdx,%rsi,1),%edx
    c5ce:	48 0f af ca          	imul   %rdx,%rcx
    c5d2:	48 c1 e9 20          	shr    $0x20,%rcx
    c5d6:	48 8d 1c 39          	lea    (%rcx,%rdi,1),%rbx
    c5da:	48 81 c3 28 02 00 00 	add    $0x228,%rbx
    c5e1:	80 3b ff             	cmpb   $0xff,(%rbx)
    c5e4:	75 d5                	jne    c5bb <f52+0x32b>
    c5e6:	48 89 df             	mov    %rbx,%rdi
    c5e9:	49 89 c6             	mov    %rax,%r14
    c5ec:	e8 9f 9c ff ff       	call   6290 <fwp_rc_forget_slot>
    c5f1:	4c 89 f0             	mov    %r14,%rax
    c5f4:	eb c5                	jmp    c5bb <f52+0x32b>
    c5f6:	48 83 c4 20          	add    $0x20,%rsp
    c5fa:	5b                   	pop    %rbx
    c5fb:	41 5e                	pop    %r14
    c5fd:	41 5f                	pop    %r15
    c5ff:	c3                   	ret
    c600:	e8 6b af ff ff       	call   7570 <fwp_rc_wide_dup>
    c605:	e9 15 fd ff ff       	jmp    c31f <f52+0x8f>
    c60a:	49 89 fe             	mov    %rdi,%r14
    c60d:	48 89 c7             	mov    %rax,%rdi
    c610:	e8 5b af ff ff       	call   7570 <fwp_rc_wide_dup>
    c615:	4c 89 f7             	mov    %r14,%rdi
    c618:	e9 65 fe ff ff       	jmp    c482 <f52+0x1f2>
    c61d:	0f 1f 00             	nopl   (%rax)

000000000000c620 <fwp_drop9>:
    c620:	48 89 f8             	mov    %rdi,%rax
    c623:	48 2b 05 86 6b 00 00 	sub    0x6b86(%rip),%rax        # 131b0 <fwp_gc+0x1030>
    c62a:	48 8b 0d a7 6b 00 00 	mov    0x6ba7(%rip),%rcx        # 131d8 <fwp_gc+0x1058>
    c631:	48 c1 e1 10          	shl    $0x10,%rcx
    c635:	48 39 c8             	cmp    %rcx,%rax
    c638:	0f 83 83 00 00 00    	jae    c6c1 <fwp_drop9+0xa1>
    c63e:	48 8b 0d b3 6b 00 00 	mov    0x6bb3(%rip),%rcx        # 131f8 <fwp_gc+0x1078>
    c645:	48 89 c2             	mov    %rax,%rdx
    c648:	48 c1 ea 10          	shr    $0x10,%rdx
    c64c:	48 69 d2 28 12 00 00 	imul   $0x1228,%rdx,%rdx
    c653:	0f b6 34 11          	movzbl (%rcx,%rdx,1),%esi
    c657:	48 25 ff ff 00 00    	and    $0xffff,%rax
    c65d:	75 12                	jne    c671 <fwp_drop9+0x51>
    c65f:	40 80 fe 02          	cmp    $0x2,%sil
    c663:	75 0c                	jne    c671 <fwp_drop9+0x51>
    c665:	48 8d 04 11          	lea    (%rcx,%rdx,1),%rax
    c669:	48 05 28 02 00 00    	add    $0x228,%rax
    c66f:	eb 1f                	jmp    c690 <fwp_drop9+0x70>
    c671:	40 80 fe 01          	cmp    $0x1,%sil
    c675:	75 4a                	jne    c6c1 <fwp_drop9+0xa1>
    c677:	48 8d 34 11          	lea    (%rcx,%rdx,1),%rsi
    c67b:	8b 4c 11 20          	mov    0x20(%rcx,%rdx,1),%ecx
    c67f:	48 0f af c1          	imul   %rcx,%rax
    c683:	48 c1 e8 20          	shr    $0x20,%rax
    c687:	48 01 f0             	add    %rsi,%rax
    c68a:	48 05 28 02 00 00    	add    $0x228,%rax
    c690:	0f b6 08             	movzbl (%rax),%ecx
    c693:	85 c9                	test   %ecx,%ecx
    c695:	74 2a                	je     c6c1 <fwp_drop9+0xa1>
    c697:	83 f9 01             	cmp    $0x1,%ecx
    c69a:	75 19                	jne    c6b5 <fwp_drop9+0x95>
    c69c:	53                   	push   %rbx
    c69d:	48 8b 47 10          	mov    0x10(%rdi),%rax
    c6a1:	48 89 fb             	mov    %rdi,%rbx
    c6a4:	48 89 c7             	mov    %rax,%rdi
    c6a7:	e8 24 00 00 00       	call   c6d0 <fwp_drop8>
    c6ac:	48 89 df             	mov    %rbx,%rdi
    c6af:	5b                   	pop    %rbx
    c6b0:	e9 eb e1 ff ff       	jmp    a8a0 <fwp_rc_free_obj>
    c6b5:	81 f9 ff 00 00 00    	cmp    $0xff,%ecx
    c6bb:	74 05                	je     c6c2 <fwp_drop9+0xa2>
    c6bd:	fe c9                	dec    %cl
    c6bf:	88 08                	mov    %cl,(%rax)
    c6c1:	c3                   	ret
    c6c2:	48 89 c7             	mov    %rax,%rdi
    c6c5:	e9 f6 de ff ff       	jmp    a5c0 <fwp_rc_wide_drop>
    c6ca:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)

000000000000c6d0 <fwp_drop8>:
    c6d0:	53                   	push   %rbx
    c6d1:	48 89 f8             	mov    %rdi,%rax
    c6d4:	48 2b 05 d5 6a 00 00 	sub    0x6ad5(%rip),%rax        # 131b0 <fwp_gc+0x1030>
    c6db:	48 8b 0d f6 6a 00 00 	mov    0x6af6(%rip),%rcx        # 131d8 <fwp_gc+0x1058>
    c6e2:	48 c1 e1 10          	shl    $0x10,%rcx
    c6e6:	48 39 c8             	cmp    %rcx,%rax
    c6e9:	0f 83 9c 00 00 00    	jae    c78b <fwp_drop8+0xbb>
    c6ef:	48 8b 0d 02 6b 00 00 	mov    0x6b02(%rip),%rcx        # 131f8 <fwp_gc+0x1078>
    c6f6:	48 89 c2             	mov    %rax,%rdx
    c6f9:	48 c1 ea 10          	shr    $0x10,%rdx
    c6fd:	48 69 d2 28 12 00 00 	imul   $0x1228,%rdx,%rdx
    c704:	0f b6 34 11          	movzbl (%rcx,%rdx,1),%esi
    c708:	48 25 ff ff 00 00    	and    $0xffff,%rax
    c70e:	75 20                	jne    c730 <fwp_drop8+0x60>
    c710:	40 80 fe 02          	cmp    $0x2,%sil
    c714:	75 1a                	jne    c730 <fwp_drop8+0x60>
    c716:	48 8d 04 11          	lea    (%rcx,%rdx,1),%rax
    c71a:	48 05 28 02 00 00    	add    $0x228,%rax
    c720:	eb 2d                	jmp    c74f <fwp_drop8+0x7f>
    c722:	66 66 66 66 66 2e 0f 	data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    c729:	1f 84 00 00 00 00 00 
    c730:	40 80 fe 01          	cmp    $0x1,%sil
    c734:	75 55                	jne    c78b <fwp_drop8+0xbb>
    c736:	48 8d 34 11          	lea    (%rcx,%rdx,1),%rsi
    c73a:	8b 4c 11 20          	mov    0x20(%rcx,%rdx,1),%ecx
    c73e:	48 0f af c1          	imul   %rcx,%rax
    c742:	48 c1 e8 20          	shr    $0x20,%rax
    c746:	48 01 f0             	add    %rsi,%rax
    c749:	48 05 28 02 00 00    	add    $0x228,%rax
    c74f:	0f b6 08             	movzbl (%rax),%ecx
    c752:	85 c9                	test   %ecx,%ecx
    c754:	74 35                	je     c78b <fwp_drop8+0xbb>
    c756:	83 f9 01             	cmp    $0x1,%ecx
    c759:	75 32                	jne    c78d <fwp_drop8+0xbd>
    c75b:	48 83 3f 00          	cmpq   $0x0,(%rdi)
    c75f:	79 3a                	jns    c79b <fwp_drop8+0xcb>
    c761:	48 8b 5f 08          	mov    0x8(%rdi),%rbx
    c765:	e8 46 dd ff ff       	call   a4b0 <fwp_rc_free_arr>
    c76a:	48 89 d8             	mov    %rbx,%rax
    c76d:	48 2b 05 3c 6a 00 00 	sub    0x6a3c(%rip),%rax        # 131b0 <fwp_gc+0x1030>
    c774:	48 8b 0d 5d 6a 00 00 	mov    0x6a5d(%rip),%rcx        # 131d8 <fwp_gc+0x1058>
    c77b:	48 c1 e1 10          	shl    $0x10,%rcx
    c77f:	48 89 df             	mov    %rbx,%rdi
    c782:	48 39 c8             	cmp    %rcx,%rax
    c785:	0f 82 64 ff ff ff    	jb     c6ef <fwp_drop8+0x1f>
    c78b:	5b                   	pop    %rbx
    c78c:	c3                   	ret
    c78d:	81 f9 ff 00 00 00    	cmp    $0xff,%ecx
    c793:	74 0c                	je     c7a1 <fwp_drop8+0xd1>
    c795:	fe c9                	dec    %cl
    c797:	88 08                	mov    %cl,(%rax)
    c799:	5b                   	pop    %rbx
    c79a:	c3                   	ret
    c79b:	5b                   	pop    %rbx
    c79c:	e9 0f dd ff ff       	jmp    a4b0 <fwp_rc_free_arr>
    c7a1:	48 89 c7             	mov    %rax,%rdi
    c7a4:	5b                   	pop    %rbx
    c7a5:	e9 16 de ff ff       	jmp    a5c0 <fwp_rc_wide_drop>
    c7aa:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)

000000000000c7b0 <fwp_owned_entry52>:
    c7b0:	48 8b 3f             	mov    (%rdi),%rdi
    c7b3:	e9 d8 fa ff ff       	jmp    c290 <f52>
    c7b8:	0f 1f 84 00 00 00 00 	nopl   0x0(%rax,%rax,1)
    c7bf:	00 

000000000000c7c0 <fwp_caps52>:
    c7c0:	53                   	push   %rbx
    c7c1:	83 7f 04 00          	cmpl   $0x0,0x4(%rdi)
    c7c5:	74 56                	je     c81d <fwp_caps52+0x5d>
    c7c7:	48 89 fb             	mov    %rdi,%rbx
    c7ca:	48 8b 7f 08          	mov    0x8(%rdi),%rdi
    c7ce:	85 f6                	test   %esi,%esi
    c7d0:	74 51                	je     c823 <fwp_caps52+0x63>
    c7d2:	48 2b 3d d7 69 00 00 	sub    0x69d7(%rip),%rdi        # 131b0 <fwp_gc+0x1030>
    c7d9:	48 8b 05 f8 69 00 00 	mov    0x69f8(%rip),%rax        # 131d8 <fwp_gc+0x1058>
    c7e0:	48 c1 e0 10          	shl    $0x10,%rax
    c7e4:	48 39 c7             	cmp    %rax,%rdi
    c7e7:	73 38                	jae    c821 <fwp_caps52+0x61>
    c7e9:	48 8b 05 08 6a 00 00 	mov    0x6a08(%rip),%rax        # 131f8 <fwp_gc+0x1078>
    c7f0:	48 89 f9             	mov    %rdi,%rcx
    c7f3:	48 c1 e9 10          	shr    $0x10,%rcx
    c7f7:	48 69 c9 28 12 00 00 	imul   $0x1228,%rcx,%rcx
    c7fe:	0f b6 14 08          	movzbl (%rax,%rcx,1),%edx
    c802:	48 81 e7 ff ff 00 00 	and    $0xffff,%rdi
    c809:	75 26                	jne    c831 <fwp_caps52+0x71>
    c80b:	80 fa 02             	cmp    $0x2,%dl
    c80e:	75 21                	jne    c831 <fwp_caps52+0x71>
    c810:	48 8d 3c 08          	lea    (%rax,%rcx,1),%rdi
    c814:	48 81 c7 28 02 00 00 	add    $0x228,%rdi
    c81b:	eb 33                	jmp    c850 <fwp_caps52+0x90>
    c81d:	85 f6                	test   %esi,%esi
    c81f:	74 0a                	je     c82b <fwp_caps52+0x6b>
    c821:	5b                   	pop    %rbx
    c822:	c3                   	ret
    c823:	e8 f8 fd ff ff       	call   c620 <fwp_drop9>
    c828:	48 89 df             	mov    %rbx,%rdi
    c82b:	5b                   	pop    %rbx
    c82c:	e9 6f e0 ff ff       	jmp    a8a0 <fwp_rc_free_obj>
    c831:	80 fa 01             	cmp    $0x1,%dl
    c834:	75 eb                	jne    c821 <fwp_caps52+0x61>
    c836:	48 8d 14 08          	lea    (%rax,%rcx,1),%rdx
    c83a:	8b 44 08 20          	mov    0x20(%rax,%rcx,1),%eax
    c83e:	48 0f af f8          	imul   %rax,%rdi
    c842:	48 c1 ef 20          	shr    $0x20,%rdi
    c846:	48 01 d7             	add    %rdx,%rdi
    c849:	48 81 c7 28 02 00 00 	add    $0x228,%rdi
    c850:	0f b6 07             	movzbl (%rdi),%eax
    c853:	84 c0                	test   %al,%al
    c855:	74 ca                	je     c821 <fwp_caps52+0x61>
    c857:	3c fe                	cmp    $0xfe,%al
    c859:	73 06                	jae    c861 <fwp_caps52+0xa1>
    c85b:	fe c0                	inc    %al
    c85d:	88 07                	mov    %al,(%rdi)
    c85f:	5b                   	pop    %rbx
    c860:	c3                   	ret
    c861:	5b                   	pop    %rbx
    c862:	e9 09 ad ff ff       	jmp    7570 <fwp_rc_wide_dup>
    c867:	66 0f 1f 84 00 00 00 	nopw   0x0(%rax,%rax,1)
    c86e:	00 00 

000000000000c870 <fwp_args52>:
    c870:	85 f6                	test   %esi,%esi
    c872:	0f 85 8a 00 00 00    	jne    c902 <fwp_args52+0x92>
    c878:	85 d2                	test   %edx,%edx
    c87a:	0f 84 82 00 00 00    	je     c902 <fwp_args52+0x92>
    c880:	48 8b 07             	mov    (%rdi),%rax
    c883:	48 2b 05 26 69 00 00 	sub    0x6926(%rip),%rax        # 131b0 <fwp_gc+0x1030>
    c88a:	48 8b 0d 47 69 00 00 	mov    0x6947(%rip),%rcx        # 131d8 <fwp_gc+0x1058>
    c891:	48 c1 e1 10          	shl    $0x10,%rcx
    c895:	48 39 c8             	cmp    %rcx,%rax
    c898:	73 68                	jae    c902 <fwp_args52+0x92>
    c89a:	48 8b 0d 57 69 00 00 	mov    0x6957(%rip),%rcx        # 131f8 <fwp_gc+0x1078>
    c8a1:	48 89 c2             	mov    %rax,%rdx
    c8a4:	48 c1 ea 10          	shr    $0x10,%rdx
    c8a8:	48 69 d2 28 12 00 00 	imul   $0x1228,%rdx,%rdx
    c8af:	0f b6 34 11          	movzbl (%rcx,%rdx,1),%esi
    c8b3:	48 25 ff ff 00 00    	and    $0xffff,%rax
    c8b9:	75 13                	jne    c8ce <fwp_args52+0x5e>
    c8bb:	40 80 fe 02          	cmp    $0x2,%sil
    c8bf:	75 0d                	jne    c8ce <fwp_args52+0x5e>
    c8c1:	48 8d 3c 11          	lea    (%rcx,%rdx,1),%rdi
    c8c5:	48 81 c7 28 02 00 00 	add    $0x228,%rdi
    c8cc:	eb 21                	jmp    c8ef <fwp_args52+0x7f>
    c8ce:	40 80 fe 01          	cmp    $0x1,%sil
    c8d2:	75 2e                	jne    c902 <fwp_args52+0x92>
    c8d4:	48 8d 34 11          	lea    (%rcx,%rdx,1),%rsi
    c8d8:	8b 4c 11 20          	mov    0x20(%rcx,%rdx,1),%ecx
    c8dc:	48 0f af c1          	imul   %rcx,%rax
    c8e0:	48 c1 e8 20          	shr    $0x20,%rax
    c8e4:	48 8d 3c 30          	lea    (%rax,%rsi,1),%rdi
    c8e8:	48 81 c7 28 02 00 00 	add    $0x228,%rdi
    c8ef:	0f b6 07             	movzbl (%rdi),%eax
    c8f2:	84 c0                	test   %al,%al
    c8f4:	74 0c                	je     c902 <fwp_args52+0x92>
    c8f6:	3c fe                	cmp    $0xfe,%al
    c8f8:	0f 83 72 ac ff ff    	jae    7570 <fwp_rc_wide_dup>
    c8fe:	fe c0                	inc    %al
    c900:	88 07                	mov    %al,(%rdi)
    c902:	c3                   	ret
    c903:	66 66 66 66 2e 0f 1f 	data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    c90a:	84 00 00 00 00 00 

000000000000c910 <fwp_arg_drop52>:
    c910:	85 f6                	test   %esi,%esi
    c912:	75 0c                	jne    c920 <fwp_arg_drop52+0x10>
    c914:	85 d2                	test   %edx,%edx
    c916:	74 08                	je     c920 <fwp_arg_drop52+0x10>
    c918:	48 8b 3f             	mov    (%rdi),%rdi
    c91b:	e9 00 fd ff ff       	jmp    c620 <fwp_drop9>
    c920:	c3                   	ret
    c921:	66 66 66 66 66 66 2e 	data16 data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    c928:	0f 1f 84 00 00 00 00 
    c92f:	00 

000000000000c930 <fwp_drop10>:
    c930:	48 89 f8             	mov    %rdi,%rax
    c933:	48 2b 05 76 68 00 00 	sub    0x6876(%rip),%rax        # 131b0 <fwp_gc+0x1030>
    c93a:	48 8b 0d 97 68 00 00 	mov    0x6897(%rip),%rcx        # 131d8 <fwp_gc+0x1058>
    c941:	48 c1 e1 10          	shl    $0x10,%rcx
    c945:	48 39 c8             	cmp    %rcx,%rax
    c948:	0f 83 92 00 00 00    	jae    c9e0 <fwp_drop10+0xb0>
    c94e:	48 8b 0d a3 68 00 00 	mov    0x68a3(%rip),%rcx        # 131f8 <fwp_gc+0x1078>
    c955:	48 89 c2             	mov    %rax,%rdx
    c958:	48 c1 ea 10          	shr    $0x10,%rdx
    c95c:	48 69 d2 28 12 00 00 	imul   $0x1228,%rdx,%rdx
    c963:	0f b6 34 11          	movzbl (%rcx,%rdx,1),%esi
    c967:	48 25 ff ff 00 00    	and    $0xffff,%rax
    c96d:	75 12                	jne    c981 <fwp_drop10+0x51>
    c96f:	40 80 fe 02          	cmp    $0x2,%sil
    c973:	75 0c                	jne    c981 <fwp_drop10+0x51>
    c975:	48 8d 04 11          	lea    (%rcx,%rdx,1),%rax
    c979:	48 05 28 02 00 00    	add    $0x228,%rax
    c97f:	eb 1f                	jmp    c9a0 <fwp_drop10+0x70>
    c981:	40 80 fe 01          	cmp    $0x1,%sil
    c985:	75 59                	jne    c9e0 <fwp_drop10+0xb0>
    c987:	48 8d 34 11          	lea    (%rcx,%rdx,1),%rsi
    c98b:	8b 4c 11 20          	mov    0x20(%rcx,%rdx,1),%ecx
    c98f:	48 0f af c1          	imul   %rcx,%rax
    c993:	48 c1 e8 20          	shr    $0x20,%rax
    c997:	48 01 f0             	add    %rsi,%rax
    c99a:	48 05 28 02 00 00    	add    $0x228,%rax
    c9a0:	0f b6 08             	movzbl (%rax),%ecx
    c9a3:	85 c9                	test   %ecx,%ecx
    c9a5:	74 39                	je     c9e0 <fwp_drop10+0xb0>
    c9a7:	83 f9 01             	cmp    $0x1,%ecx
    c9aa:	75 28                	jne    c9d4 <fwp_drop10+0xa4>
    c9ac:	8b 07                	mov    (%rdi),%eax
    c9ae:	83 f8 01             	cmp    $0x1,%eax
    c9b1:	0f 84 e9 de ff ff    	je     a8a0 <fwp_rc_free_obj>
    c9b7:	85 c0                	test   %eax,%eax
    c9b9:	75 25                	jne    c9e0 <fwp_drop10+0xb0>
    c9bb:	53                   	push   %rbx
    c9bc:	48 8b 47 08          	mov    0x8(%rdi),%rax
    c9c0:	48 89 fb             	mov    %rdi,%rbx
    c9c3:	48 89 c7             	mov    %rax,%rdi
    c9c6:	e8 55 fc ff ff       	call   c620 <fwp_drop9>
    c9cb:	48 89 df             	mov    %rbx,%rdi
    c9ce:	5b                   	pop    %rbx
    c9cf:	e9 cc de ff ff       	jmp    a8a0 <fwp_rc_free_obj>
    c9d4:	81 f9 ff 00 00 00    	cmp    $0xff,%ecx
    c9da:	74 05                	je     c9e1 <fwp_drop10+0xb1>
    c9dc:	fe c9                	dec    %cl
    c9de:	88 08                	mov    %cl,(%rax)
    c9e0:	c3                   	ret
    c9e1:	48 89 c7             	mov    %rax,%rdi
    c9e4:	e9 d7 db ff ff       	jmp    a5c0 <fwp_rc_wide_drop>
    c9e9:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)

000000000000c9f0 <f55>:
    c9f0:	41 57                	push   %r15
    c9f2:	41 56                	push   %r14
    c9f4:	41 54                	push   %r12
    c9f6:	53                   	push   %rbx
    c9f7:	48 81 ec 88 00 00 00 	sub    $0x88,%rsp
    c9fe:	48 89 fb             	mov    %rdi,%rbx
    ca01:	48 8b 47 10          	mov    0x10(%rdi),%rax
    ca05:	48 2b 05 a4 67 00 00 	sub    0x67a4(%rip),%rax        # 131b0 <fwp_gc+0x1030>
    ca0c:	48 8b 0d c5 67 00 00 	mov    0x67c5(%rip),%rcx        # 131d8 <fwp_gc+0x1058>
    ca13:	48 c1 e1 10          	shl    $0x10,%rcx
    ca17:	48 39 c8             	cmp    %rcx,%rax
    ca1a:	73 68                	jae    ca84 <f55+0x94>
    ca1c:	48 8b 0d d5 67 00 00 	mov    0x67d5(%rip),%rcx        # 131f8 <fwp_gc+0x1078>
    ca23:	48 89 c2             	mov    %rax,%rdx
    ca26:	48 c1 ea 10          	shr    $0x10,%rdx
    ca2a:	48 69 d2 28 12 00 00 	imul   $0x1228,%rdx,%rdx
    ca31:	0f b6 34 11          	movzbl (%rcx,%rdx,1),%esi
    ca35:	48 25 ff ff 00 00    	and    $0xffff,%rax
    ca3b:	75 13                	jne    ca50 <f55+0x60>
    ca3d:	40 80 fe 02          	cmp    $0x2,%sil
    ca41:	75 0d                	jne    ca50 <f55+0x60>
    ca43:	48 8d 3c 11          	lea    (%rcx,%rdx,1),%rdi
    ca47:	48 81 c7 28 02 00 00 	add    $0x228,%rdi
    ca4e:	eb 21                	jmp    ca71 <f55+0x81>
    ca50:	40 80 fe 01          	cmp    $0x1,%sil
    ca54:	75 2e                	jne    ca84 <f55+0x94>
    ca56:	48 8d 34 11          	lea    (%rcx,%rdx,1),%rsi
    ca5a:	8b 4c 11 20          	mov    0x20(%rcx,%rdx,1),%ecx
    ca5e:	48 0f af c1          	imul   %rcx,%rax
    ca62:	48 c1 e8 20          	shr    $0x20,%rax
    ca66:	48 8d 3c 30          	lea    (%rax,%rsi,1),%rdi
    ca6a:	48 81 c7 28 02 00 00 	add    $0x228,%rdi
    ca71:	0f b6 07             	movzbl (%rdi),%eax
    ca74:	84 c0                	test   %al,%al
    ca76:	74 0c                	je     ca84 <f55+0x94>
    ca78:	3c fe                	cmp    $0xfe,%al
    ca7a:	0f 83 dc 02 00 00    	jae    cd5c <f55+0x36c>
    ca80:	fe c0                	inc    %al
    ca82:	88 07                	mov    %al,(%rdi)
    ca84:	4c 8b 63 08          	mov    0x8(%rbx),%r12
    ca88:	4c 8b 73 10          	mov    0x10(%rbx),%r14
    ca8c:	4c 8b 7b 18          	mov    0x18(%rbx),%r15
    ca90:	4d 85 e4             	test   %r12,%r12
    ca93:	78 27                	js     cabc <f55+0xcc>
    ca95:	49 8b 06             	mov    (%r14),%rax
    ca98:	48 b9 ff ff ff ff ff 	movabs $0x7fffffffffffffff,%rcx
    ca9f:	ff ff 7f 
    caa2:	48 21 c1             	and    %rax,%rcx
    caa5:	4c 39 e1             	cmp    %r12,%rcx
    caa8:	76 12                	jbe    cabc <f55+0xcc>
    caaa:	48 85 c0             	test   %rax,%rax
    caad:	0f 88 8e 00 00 00    	js     cb41 <f55+0x151>
    cab3:	49 8d 46 08          	lea    0x8(%r14),%rax
    cab7:	e9 89 00 00 00       	jmp    cb45 <f55+0x155>
    cabc:	4c 89 f7             	mov    %r14,%rdi
    cabf:	e8 bc 03 00 00       	call   ce80 <fwp_drop11>
    cac4:	48 89 df             	mov    %rbx,%rdi
    cac7:	e8 04 03 00 00       	call   cdd0 <fwp_drop12>
    cacc:	48 c7 44 24 20 01 00 	movq   $0x1,0x20(%rsp)
    cad3:	00 00 
    cad5:	48 8d 54 24 28       	lea    0x28(%rsp),%rdx
    cada:	4c 89 7c 24 28       	mov    %r15,0x28(%rsp)
    cadf:	bf 01 00 00 00       	mov    $0x1,%edi
    cae4:	be 01 00 00 00       	mov    $0x1,%esi
    cae9:	e8 72 d2 ff ff       	call   9d60 <fwp_data>
    caee:	48 89 c1             	mov    %rax,%rcx
    caf1:	48 2b 0d b8 66 00 00 	sub    0x66b8(%rip),%rcx        # 131b0 <fwp_gc+0x1030>
    caf8:	48 8b 15 d9 66 00 00 	mov    0x66d9(%rip),%rdx        # 131d8 <fwp_gc+0x1058>
    caff:	48 c1 e2 10          	shl    $0x10,%rdx
    cb03:	48 39 d1             	cmp    %rdx,%rcx
    cb06:	0f 83 41 02 00 00    	jae    cd4d <f55+0x35d>
    cb0c:	48 8b 15 e5 66 00 00 	mov    0x66e5(%rip),%rdx        # 131f8 <fwp_gc+0x1078>
    cb13:	48 89 ce             	mov    %rcx,%rsi
    cb16:	48 c1 ee 10          	shr    $0x10,%rsi
    cb1a:	48 69 f6 28 12 00 00 	imul   $0x1228,%rsi,%rsi
    cb21:	0f b6 3c 32          	movzbl (%rdx,%rsi,1),%edi
    cb25:	48 81 e1 ff ff 00 00 	and    $0xffff,%rcx
    cb2c:	0f 85 e5 01 00 00    	jne    cd17 <f55+0x327>
    cb32:	40 80 ff 02          	cmp    $0x2,%dil
    cb36:	0f 84 c6 01 00 00    	je     cd02 <f55+0x312>
    cb3c:	e9 d6 01 00 00       	jmp    cd17 <f55+0x327>
    cb41:	49 8b 46 10          	mov    0x10(%r14),%rax
    cb45:	4a 0f be 04 20       	movsbq (%rax,%r12,1),%rax
    cb4a:	48 83 c0 81          	add    $0xffffffffffffff81,%rax
    cb4e:	48 3d ff fe ff ff    	cmp    $0xfffffffffffffeff,%rax
    cb54:	0f 86 16 02 00 00    	jbe    cd70 <f55+0x380>
    cb5a:	4c 89 f0             	mov    %r14,%rax
    cb5d:	48 2b 05 4c 66 00 00 	sub    0x664c(%rip),%rax        # 131b0 <fwp_gc+0x1030>
    cb64:	48 8b 0d 6d 66 00 00 	mov    0x666d(%rip),%rcx        # 131d8 <fwp_gc+0x1058>
    cb6b:	48 c1 e1 10          	shl    $0x10,%rcx
    cb6f:	48 39 c8             	cmp    %rcx,%rax
    cb72:	73 68                	jae    cbdc <f55+0x1ec>
    cb74:	48 8b 0d 7d 66 00 00 	mov    0x667d(%rip),%rcx        # 131f8 <fwp_gc+0x1078>
    cb7b:	48 89 c2             	mov    %rax,%rdx
    cb7e:	48 c1 ea 10          	shr    $0x10,%rdx
    cb82:	48 69 d2 28 12 00 00 	imul   $0x1228,%rdx,%rdx
    cb89:	0f b6 34 11          	movzbl (%rcx,%rdx,1),%esi
    cb8d:	48 25 ff ff 00 00    	and    $0xffff,%rax
    cb93:	75 13                	jne    cba8 <f55+0x1b8>
    cb95:	40 80 fe 02          	cmp    $0x2,%sil
    cb99:	75 0d                	jne    cba8 <f55+0x1b8>
    cb9b:	48 8d 3c 11          	lea    (%rcx,%rdx,1),%rdi
    cb9f:	48 81 c7 28 02 00 00 	add    $0x228,%rdi
    cba6:	eb 21                	jmp    cbc9 <f55+0x1d9>
    cba8:	40 80 fe 01          	cmp    $0x1,%sil
    cbac:	75 2e                	jne    cbdc <f55+0x1ec>
    cbae:	48 8d 34 11          	lea    (%rcx,%rdx,1),%rsi
    cbb2:	8b 4c 11 20          	mov    0x20(%rcx,%rdx,1),%ecx
    cbb6:	48 0f af c1          	imul   %rcx,%rax
    cbba:	48 c1 e8 20          	shr    $0x20,%rax
    cbbe:	48 8d 3c 30          	lea    (%rax,%rsi,1),%rdi
    cbc2:	48 81 c7 28 02 00 00 	add    $0x228,%rdi
    cbc9:	0f b6 07             	movzbl (%rdi),%eax
    cbcc:	84 c0                	test   %al,%al
    cbce:	74 0c                	je     cbdc <f55+0x1ec>
    cbd0:	3c fe                	cmp    $0xfe,%al
    cbd2:	0f 83 8e 01 00 00    	jae    cd66 <f55+0x376>
    cbd8:	fe c0                	inc    %al
    cbda:	88 07                	mov    %al,(%rdi)
    cbdc:	4c 89 f7             	mov    %r14,%rdi
    cbdf:	e8 9c 02 00 00       	call   ce80 <fwp_drop11>
    cbe4:	49 ff c7             	inc    %r15
    cbe7:	0f 80 93 01 00 00    	jo     cd80 <f55+0x390>
    cbed:	49 ff c4             	inc    %r12
    cbf0:	4c 89 64 24 08       	mov    %r12,0x8(%rsp)
    cbf5:	4c 89 74 24 10       	mov    %r14,0x10(%rsp)
    cbfa:	4c 89 7c 24 18       	mov    %r15,0x18(%rsp)
    cbff:	48 8d 54 24 08       	lea    0x8(%rsp),%rdx
    cc04:	31 ff                	xor    %edi,%edi
    cc06:	be 03 00 00 00       	mov    $0x3,%esi
    cc0b:	e8 50 d1 ff ff       	call   9d60 <fwp_data>
    cc10:	49 89 c6             	mov    %rax,%r14
    cc13:	48 2b 05 96 65 00 00 	sub    0x6596(%rip),%rax        # 131b0 <fwp_gc+0x1030>
    cc1a:	48 8b 0d b7 65 00 00 	mov    0x65b7(%rip),%rcx        # 131d8 <fwp_gc+0x1058>
    cc21:	48 c1 e1 10          	shl    $0x10,%rcx
    cc25:	48 39 c8             	cmp    %rcx,%rax
    cc28:	73 6f                	jae    cc99 <f55+0x2a9>
    cc2a:	48 8b 0d c7 65 00 00 	mov    0x65c7(%rip),%rcx        # 131f8 <fwp_gc+0x1078>
    cc31:	48 89 c2             	mov    %rax,%rdx
    cc34:	48 c1 ea 10          	shr    $0x10,%rdx
    cc38:	48 69 d2 28 12 00 00 	imul   $0x1228,%rdx,%rdx
    cc3f:	0f b6 34 11          	movzbl (%rcx,%rdx,1),%esi
    cc43:	48 25 ff ff 00 00    	and    $0xffff,%rax
    cc49:	75 1d                	jne    cc68 <f55+0x278>
    cc4b:	40 80 fe 02          	cmp    $0x2,%sil
    cc4f:	75 17                	jne    cc68 <f55+0x278>
    cc51:	4c 8d 3c 11          	lea    (%rcx,%rdx,1),%r15
    cc55:	49 81 c7 28 02 00 00 	add    $0x228,%r15
    cc5c:	41 80 3f ff          	cmpb   $0xff,(%r15)
    cc60:	74 2d                	je     cc8f <f55+0x29f>
    cc62:	41 c6 07 01          	movb   $0x1,(%r15)
    cc66:	eb 31                	jmp    cc99 <f55+0x2a9>
    cc68:	40 80 fe 01          	cmp    $0x1,%sil
    cc6c:	75 2b                	jne    cc99 <f55+0x2a9>
    cc6e:	48 8d 34 11          	lea    (%rcx,%rdx,1),%rsi
    cc72:	8b 4c 11 20          	mov    0x20(%rcx,%rdx,1),%ecx
    cc76:	48 0f af c1          	imul   %rcx,%rax
    cc7a:	48 c1 e8 20          	shr    $0x20,%rax
    cc7e:	4c 8d 3c 30          	lea    (%rax,%rsi,1),%r15
    cc82:	49 81 c7 28 02 00 00 	add    $0x228,%r15
    cc89:	41 80 3f ff          	cmpb   $0xff,(%r15)
    cc8d:	75 d3                	jne    cc62 <f55+0x272>
    cc8f:	4c 89 ff             	mov    %r15,%rdi
    cc92:	e8 f9 95 ff ff       	call   6290 <fwp_rc_forget_slot>
    cc97:	eb c9                	jmp    cc62 <f55+0x272>
    cc99:	48 89 df             	mov    %rbx,%rdi
    cc9c:	e8 2f 01 00 00       	call   cdd0 <fwp_drop12>
    cca1:	48 c7 44 24 20 00 00 	movq   $0x0,0x20(%rsp)
    cca8:	00 00 
    ccaa:	48 8d 54 24 28       	lea    0x28(%rsp),%rdx
    ccaf:	4c 89 74 24 28       	mov    %r14,0x28(%rsp)
    ccb4:	31 ff                	xor    %edi,%edi
    ccb6:	be 01 00 00 00       	mov    $0x1,%esi
    ccbb:	e8 a0 d0 ff ff       	call   9d60 <fwp_data>
    ccc0:	48 89 c1             	mov    %rax,%rcx
    ccc3:	48 2b 0d e6 64 00 00 	sub    0x64e6(%rip),%rcx        # 131b0 <fwp_gc+0x1030>
    ccca:	48 8b 15 07 65 00 00 	mov    0x6507(%rip),%rdx        # 131d8 <fwp_gc+0x1058>
    ccd1:	48 c1 e2 10          	shl    $0x10,%rdx
    ccd5:	48 39 d1             	cmp    %rdx,%rcx
    ccd8:	73 73                	jae    cd4d <f55+0x35d>
    ccda:	48 8b 15 17 65 00 00 	mov    0x6517(%rip),%rdx        # 131f8 <fwp_gc+0x1078>
    cce1:	48 89 ce             	mov    %rcx,%rsi
    cce4:	48 c1 ee 10          	shr    $0x10,%rsi
    cce8:	48 69 f6 28 12 00 00 	imul   $0x1228,%rsi,%rsi
    ccef:	0f b6 3c 32          	movzbl (%rdx,%rsi,1),%edi
    ccf3:	48 81 e1 ff ff 00 00 	and    $0xffff,%rcx
    ccfa:	75 1b                	jne    cd17 <f55+0x327>
    ccfc:	40 80 ff 02          	cmp    $0x2,%dil
    cd00:	75 15                	jne    cd17 <f55+0x327>
    cd02:	48 8d 1c 32          	lea    (%rdx,%rsi,1),%rbx
    cd06:	48 81 c3 28 02 00 00 	add    $0x228,%rbx
    cd0d:	80 3b ff             	cmpb   $0xff,(%rbx)
    cd10:	74 2b                	je     cd3d <f55+0x34d>
    cd12:	c6 03 01             	movb   $0x1,(%rbx)
    cd15:	eb 36                	jmp    cd4d <f55+0x35d>
    cd17:	40 80 ff 01          	cmp    $0x1,%dil
    cd1b:	75 30                	jne    cd4d <f55+0x35d>
    cd1d:	48 8d 3c 32          	lea    (%rdx,%rsi,1),%rdi
    cd21:	8b 54 32 20          	mov    0x20(%rdx,%rsi,1),%edx
    cd25:	48 0f af ca          	imul   %rdx,%rcx
    cd29:	48 c1 e9 20          	shr    $0x20,%rcx
    cd2d:	48 8d 1c 39          	lea    (%rcx,%rdi,1),%rbx
    cd31:	48 81 c3 28 02 00 00 	add    $0x228,%rbx
    cd38:	80 3b ff             	cmpb   $0xff,(%rbx)
    cd3b:	75 d5                	jne    cd12 <f55+0x322>
    cd3d:	48 89 df             	mov    %rbx,%rdi
    cd40:	49 89 c6             	mov    %rax,%r14
    cd43:	e8 48 95 ff ff       	call   6290 <fwp_rc_forget_slot>
    cd48:	4c 89 f0             	mov    %r14,%rax
    cd4b:	eb c5                	jmp    cd12 <f55+0x322>
    cd4d:	48 81 c4 88 00 00 00 	add    $0x88,%rsp
    cd54:	5b                   	pop    %rbx
    cd55:	41 5c                	pop    %r12
    cd57:	41 5e                	pop    %r14
    cd59:	41 5f                	pop    %r15
    cd5b:	c3                   	ret
    cd5c:	e8 0f a8 ff ff       	call   7570 <fwp_rc_wide_dup>
    cd61:	e9 1e fd ff ff       	jmp    ca84 <f55+0x94>
    cd66:	e8 05 a8 ff ff       	call   7570 <fwp_rc_wide_dup>
    cd6b:	e9 6c fe ff ff       	jmp    cbdc <f55+0x1ec>
    cd70:	48 8d 15 14 29 00 00 	lea    0x2914(%rip),%rdx        # f68b <fwp_segv.msg+0x44b>
    cd77:	48 8d 0d 25 28 00 00 	lea    0x2825(%rip),%rcx        # f5a3 <fwp_segv.msg+0x363>
    cd7e:	eb 0e                	jmp    cd8e <f55+0x39e>
    cd80:	48 8d 15 04 29 00 00 	lea    0x2904(%rip),%rdx        # f68b <fwp_segv.msg+0x44b>
    cd87:	48 8d 0d 17 29 00 00 	lea    0x2917(%rip),%rcx        # f6a5 <fwp_segv.msg+0x465>
    cd8e:	48 8d 5c 24 20       	lea    0x20(%rsp),%rbx
    cd93:	be 60 00 00 00       	mov    $0x60,%esi
    cd98:	48 89 df             	mov    %rbx,%rdi
    cd9b:	31 c0                	xor    %eax,%eax
    cd9d:	e8 6e 53 ff ff       	call   2110 <snprintf@plt>
    cda2:	e8 b9 94 ff ff       	call   6260 <fwp_flush>
    cda7:	48 8b 05 32 52 00 00 	mov    0x5232(%rip),%rax        # 11fe0 <stderr@GLIBC_2.2.5>
    cdae:	48 8b 38             	mov    (%rax),%rdi
    cdb1:	48 8d 35 75 26 00 00 	lea    0x2675(%rip),%rsi        # f42d <fwp_segv.msg+0x1ed>
    cdb8:	48 89 da             	mov    %rbx,%rdx
    cdbb:	31 c0                	xor    %eax,%eax
    cdbd:	e8 ee 53 ff ff       	call   21b0 <fprintf@plt>
    cdc2:	bf 65 00 00 00       	mov    $0x65,%edi
    cdc7:	e8 c4 54 ff ff       	call   2290 <exit@plt>
    cdcc:	0f 1f 40 00          	nopl   0x0(%rax)

000000000000cdd0 <fwp_drop12>:
    cdd0:	48 89 f8             	mov    %rdi,%rax
    cdd3:	48 2b 05 d6 63 00 00 	sub    0x63d6(%rip),%rax        # 131b0 <fwp_gc+0x1030>
    cdda:	48 8b 0d f7 63 00 00 	mov    0x63f7(%rip),%rcx        # 131d8 <fwp_gc+0x1058>
    cde1:	48 c1 e1 10          	shl    $0x10,%rcx
    cde5:	48 39 c8             	cmp    %rcx,%rax
    cde8:	0f 83 83 00 00 00    	jae    ce71 <fwp_drop12+0xa1>
    cdee:	48 8b 0d 03 64 00 00 	mov    0x6403(%rip),%rcx        # 131f8 <fwp_gc+0x1078>
    cdf5:	48 89 c2             	mov    %rax,%rdx
    cdf8:	48 c1 ea 10          	shr    $0x10,%rdx
    cdfc:	48 69 d2 28 12 00 00 	imul   $0x1228,%rdx,%rdx
    ce03:	0f b6 34 11          	movzbl (%rcx,%rdx,1),%esi
    ce07:	48 25 ff ff 00 00    	and    $0xffff,%rax
    ce0d:	75 12                	jne    ce21 <fwp_drop12+0x51>
    ce0f:	40 80 fe 02          	cmp    $0x2,%sil
    ce13:	75 0c                	jne    ce21 <fwp_drop12+0x51>
    ce15:	48 8d 04 11          	lea    (%rcx,%rdx,1),%rax
    ce19:	48 05 28 02 00 00    	add    $0x228,%rax
    ce1f:	eb 1f                	jmp    ce40 <fwp_drop12+0x70>
    ce21:	40 80 fe 01          	cmp    $0x1,%sil
    ce25:	75 4a                	jne    ce71 <fwp_drop12+0xa1>
    ce27:	48 8d 34 11          	lea    (%rcx,%rdx,1),%rsi
    ce2b:	8b 4c 11 20          	mov    0x20(%rcx,%rdx,1),%ecx
    ce2f:	48 0f af c1          	imul   %rcx,%rax
    ce33:	48 c1 e8 20          	shr    $0x20,%rax
    ce37:	48 01 f0             	add    %rsi,%rax
    ce3a:	48 05 28 02 00 00    	add    $0x228,%rax
    ce40:	0f b6 08             	movzbl (%rax),%ecx
    ce43:	85 c9                	test   %ecx,%ecx
    ce45:	74 2a                	je     ce71 <fwp_drop12+0xa1>
    ce47:	83 f9 01             	cmp    $0x1,%ecx
    ce4a:	75 19                	jne    ce65 <fwp_drop12+0x95>
    ce4c:	53                   	push   %rbx
    ce4d:	48 8b 47 10          	mov    0x10(%rdi),%rax
    ce51:	48 89 fb             	mov    %rdi,%rbx
    ce54:	48 89 c7             	mov    %rax,%rdi
    ce57:	e8 24 00 00 00       	call   ce80 <fwp_drop11>
    ce5c:	48 89 df             	mov    %rbx,%rdi
    ce5f:	5b                   	pop    %rbx
    ce60:	e9 3b da ff ff       	jmp    a8a0 <fwp_rc_free_obj>
    ce65:	81 f9 ff 00 00 00    	cmp    $0xff,%ecx
    ce6b:	74 05                	je     ce72 <fwp_drop12+0xa2>
    ce6d:	fe c9                	dec    %cl
    ce6f:	88 08                	mov    %cl,(%rax)
    ce71:	c3                   	ret
    ce72:	48 89 c7             	mov    %rax,%rdi
    ce75:	e9 46 d7 ff ff       	jmp    a5c0 <fwp_rc_wide_drop>
    ce7a:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)

000000000000ce80 <fwp_drop11>:
    ce80:	53                   	push   %rbx
    ce81:	48 89 f8             	mov    %rdi,%rax
    ce84:	48 2b 05 25 63 00 00 	sub    0x6325(%rip),%rax        # 131b0 <fwp_gc+0x1030>
    ce8b:	48 8b 0d 46 63 00 00 	mov    0x6346(%rip),%rcx        # 131d8 <fwp_gc+0x1058>
    ce92:	48 c1 e1 10          	shl    $0x10,%rcx
    ce96:	48 39 c8             	cmp    %rcx,%rax
    ce99:	0f 83 9c 00 00 00    	jae    cf3b <fwp_drop11+0xbb>
    ce9f:	48 8b 0d 52 63 00 00 	mov    0x6352(%rip),%rcx        # 131f8 <fwp_gc+0x1078>
    cea6:	48 89 c2             	mov    %rax,%rdx
    cea9:	48 c1 ea 10          	shr    $0x10,%rdx
    cead:	48 69 d2 28 12 00 00 	imul   $0x1228,%rdx,%rdx
    ceb4:	0f b6 34 11          	movzbl (%rcx,%rdx,1),%esi
    ceb8:	48 25 ff ff 00 00    	and    $0xffff,%rax
    cebe:	75 20                	jne    cee0 <fwp_drop11+0x60>
    cec0:	40 80 fe 02          	cmp    $0x2,%sil
    cec4:	75 1a                	jne    cee0 <fwp_drop11+0x60>
    cec6:	48 8d 04 11          	lea    (%rcx,%rdx,1),%rax
    ceca:	48 05 28 02 00 00    	add    $0x228,%rax
    ced0:	eb 2d                	jmp    ceff <fwp_drop11+0x7f>
    ced2:	66 66 66 66 66 2e 0f 	data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    ced9:	1f 84 00 00 00 00 00 
    cee0:	40 80 fe 01          	cmp    $0x1,%sil
    cee4:	75 55                	jne    cf3b <fwp_drop11+0xbb>
    cee6:	48 8d 34 11          	lea    (%rcx,%rdx,1),%rsi
    ceea:	8b 4c 11 20          	mov    0x20(%rcx,%rdx,1),%ecx
    ceee:	48 0f af c1          	imul   %rcx,%rax
    cef2:	48 c1 e8 20          	shr    $0x20,%rax
    cef6:	48 01 f0             	add    %rsi,%rax
    cef9:	48 05 28 02 00 00    	add    $0x228,%rax
    ceff:	0f b6 08             	movzbl (%rax),%ecx
    cf02:	85 c9                	test   %ecx,%ecx
    cf04:	74 35                	je     cf3b <fwp_drop11+0xbb>
    cf06:	83 f9 01             	cmp    $0x1,%ecx
    cf09:	75 32                	jne    cf3d <fwp_drop11+0xbd>
    cf0b:	48 83 3f 00          	cmpq   $0x0,(%rdi)
    cf0f:	79 3a                	jns    cf4b <fwp_drop11+0xcb>
    cf11:	48 8b 5f 08          	mov    0x8(%rdi),%rbx
    cf15:	e8 96 d5 ff ff       	call   a4b0 <fwp_rc_free_arr>
    cf1a:	48 89 d8             	mov    %rbx,%rax
    cf1d:	48 2b 05 8c 62 00 00 	sub    0x628c(%rip),%rax        # 131b0 <fwp_gc+0x1030>
    cf24:	48 8b 0d ad 62 00 00 	mov    0x62ad(%rip),%rcx        # 131d8 <fwp_gc+0x1058>
    cf2b:	48 c1 e1 10          	shl    $0x10,%rcx
    cf2f:	48 89 df             	mov    %rbx,%rdi
    cf32:	48 39 c8             	cmp    %rcx,%rax
    cf35:	0f 82 64 ff ff ff    	jb     ce9f <fwp_drop11+0x1f>
    cf3b:	5b                   	pop    %rbx
    cf3c:	c3                   	ret
    cf3d:	81 f9 ff 00 00 00    	cmp    $0xff,%ecx
    cf43:	74 0c                	je     cf51 <fwp_drop11+0xd1>
    cf45:	fe c9                	dec    %cl
    cf47:	88 08                	mov    %cl,(%rax)
    cf49:	5b                   	pop    %rbx
    cf4a:	c3                   	ret
    cf4b:	5b                   	pop    %rbx
    cf4c:	e9 5f d5 ff ff       	jmp    a4b0 <fwp_rc_free_arr>
    cf51:	48 89 c7             	mov    %rax,%rdi
    cf54:	5b                   	pop    %rbx
    cf55:	e9 66 d6 ff ff       	jmp    a5c0 <fwp_rc_wide_drop>
    cf5a:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)

000000000000cf60 <fwp_owned_entry55>:
    cf60:	48 8b 3f             	mov    (%rdi),%rdi
    cf63:	e9 88 fa ff ff       	jmp    c9f0 <f55>
    cf68:	0f 1f 84 00 00 00 00 	nopl   0x0(%rax,%rax,1)
    cf6f:	00 

000000000000cf70 <fwp_caps55>:
    cf70:	53                   	push   %rbx
    cf71:	83 7f 04 00          	cmpl   $0x0,0x4(%rdi)
    cf75:	74 56                	je     cfcd <fwp_caps55+0x5d>
    cf77:	48 89 fb             	mov    %rdi,%rbx
    cf7a:	48 8b 7f 08          	mov    0x8(%rdi),%rdi
    cf7e:	85 f6                	test   %esi,%esi
    cf80:	74 51                	je     cfd3 <fwp_caps55+0x63>
    cf82:	48 2b 3d 27 62 00 00 	sub    0x6227(%rip),%rdi        # 131b0 <fwp_gc+0x1030>
    cf89:	48 8b 05 48 62 00 00 	mov    0x6248(%rip),%rax        # 131d8 <fwp_gc+0x1058>
    cf90:	48 c1 e0 10          	shl    $0x10,%rax
    cf94:	48 39 c7             	cmp    %rax,%rdi
    cf97:	73 38                	jae    cfd1 <fwp_caps55+0x61>
    cf99:	48 8b 05 58 62 00 00 	mov    0x6258(%rip),%rax        # 131f8 <fwp_gc+0x1078>
    cfa0:	48 89 f9             	mov    %rdi,%rcx
    cfa3:	48 c1 e9 10          	shr    $0x10,%rcx
    cfa7:	48 69 c9 28 12 00 00 	imul   $0x1228,%rcx,%rcx
    cfae:	0f b6 14 08          	movzbl (%rax,%rcx,1),%edx
    cfb2:	48 81 e7 ff ff 00 00 	and    $0xffff,%rdi
    cfb9:	75 26                	jne    cfe1 <fwp_caps55+0x71>
    cfbb:	80 fa 02             	cmp    $0x2,%dl
    cfbe:	75 21                	jne    cfe1 <fwp_caps55+0x71>
    cfc0:	48 8d 3c 08          	lea    (%rax,%rcx,1),%rdi
    cfc4:	48 81 c7 28 02 00 00 	add    $0x228,%rdi
    cfcb:	eb 33                	jmp    d000 <fwp_caps55+0x90>
    cfcd:	85 f6                	test   %esi,%esi
    cfcf:	74 0a                	je     cfdb <fwp_caps55+0x6b>
    cfd1:	5b                   	pop    %rbx
    cfd2:	c3                   	ret
    cfd3:	e8 f8 fd ff ff       	call   cdd0 <fwp_drop12>
    cfd8:	48 89 df             	mov    %rbx,%rdi
    cfdb:	5b                   	pop    %rbx
    cfdc:	e9 bf d8 ff ff       	jmp    a8a0 <fwp_rc_free_obj>
    cfe1:	80 fa 01             	cmp    $0x1,%dl
    cfe4:	75 eb                	jne    cfd1 <fwp_caps55+0x61>
    cfe6:	48 8d 14 08          	lea    (%rax,%rcx,1),%rdx
    cfea:	8b 44 08 20          	mov    0x20(%rax,%rcx,1),%eax
    cfee:	48 0f af f8          	imul   %rax,%rdi
    cff2:	48 c1 ef 20          	shr    $0x20,%rdi
    cff6:	48 01 d7             	add    %rdx,%rdi
    cff9:	48 81 c7 28 02 00 00 	add    $0x228,%rdi
    d000:	0f b6 07             	movzbl (%rdi),%eax
    d003:	84 c0                	test   %al,%al
    d005:	74 ca                	je     cfd1 <fwp_caps55+0x61>
    d007:	3c fe                	cmp    $0xfe,%al
    d009:	73 06                	jae    d011 <fwp_caps55+0xa1>
    d00b:	fe c0                	inc    %al
    d00d:	88 07                	mov    %al,(%rdi)
    d00f:	5b                   	pop    %rbx
    d010:	c3                   	ret
    d011:	5b                   	pop    %rbx
    d012:	e9 59 a5 ff ff       	jmp    7570 <fwp_rc_wide_dup>
    d017:	66 0f 1f 84 00 00 00 	nopw   0x0(%rax,%rax,1)
    d01e:	00 00 

000000000000d020 <fwp_args55>:
    d020:	85 f6                	test   %esi,%esi
    d022:	0f 85 8a 00 00 00    	jne    d0b2 <fwp_args55+0x92>
    d028:	85 d2                	test   %edx,%edx
    d02a:	0f 84 82 00 00 00    	je     d0b2 <fwp_args55+0x92>
    d030:	48 8b 07             	mov    (%rdi),%rax
    d033:	48 2b 05 76 61 00 00 	sub    0x6176(%rip),%rax        # 131b0 <fwp_gc+0x1030>
    d03a:	48 8b 0d 97 61 00 00 	mov    0x6197(%rip),%rcx        # 131d8 <fwp_gc+0x1058>
    d041:	48 c1 e1 10          	shl    $0x10,%rcx
    d045:	48 39 c8             	cmp    %rcx,%rax
    d048:	73 68                	jae    d0b2 <fwp_args55+0x92>
    d04a:	48 8b 0d a7 61 00 00 	mov    0x61a7(%rip),%rcx        # 131f8 <fwp_gc+0x1078>
    d051:	48 89 c2             	mov    %rax,%rdx
    d054:	48 c1 ea 10          	shr    $0x10,%rdx
    d058:	48 69 d2 28 12 00 00 	imul   $0x1228,%rdx,%rdx
    d05f:	0f b6 34 11          	movzbl (%rcx,%rdx,1),%esi
    d063:	48 25 ff ff 00 00    	and    $0xffff,%rax
    d069:	75 13                	jne    d07e <fwp_args55+0x5e>
    d06b:	40 80 fe 02          	cmp    $0x2,%sil
    d06f:	75 0d                	jne    d07e <fwp_args55+0x5e>
    d071:	48 8d 3c 11          	lea    (%rcx,%rdx,1),%rdi
    d075:	48 81 c7 28 02 00 00 	add    $0x228,%rdi
    d07c:	eb 21                	jmp    d09f <fwp_args55+0x7f>
    d07e:	40 80 fe 01          	cmp    $0x1,%sil
    d082:	75 2e                	jne    d0b2 <fwp_args55+0x92>
    d084:	48 8d 34 11          	lea    (%rcx,%rdx,1),%rsi
    d088:	8b 4c 11 20          	mov    0x20(%rcx,%rdx,1),%ecx
    d08c:	48 0f af c1          	imul   %rcx,%rax
    d090:	48 c1 e8 20          	shr    $0x20,%rax
    d094:	48 8d 3c 30          	lea    (%rax,%rsi,1),%rdi
    d098:	48 81 c7 28 02 00 00 	add    $0x228,%rdi
    d09f:	0f b6 07             	movzbl (%rdi),%eax
    d0a2:	84 c0                	test   %al,%al
    d0a4:	74 0c                	je     d0b2 <fwp_args55+0x92>
    d0a6:	3c fe                	cmp    $0xfe,%al
    d0a8:	0f 83 c2 a4 ff ff    	jae    7570 <fwp_rc_wide_dup>
    d0ae:	fe c0                	inc    %al
    d0b0:	88 07                	mov    %al,(%rdi)
    d0b2:	c3                   	ret
    d0b3:	66 66 66 66 2e 0f 1f 	data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    d0ba:	84 00 00 00 00 00 

000000000000d0c0 <fwp_arg_drop55>:
    d0c0:	85 f6                	test   %esi,%esi
    d0c2:	75 0c                	jne    d0d0 <fwp_arg_drop55+0x10>
    d0c4:	85 d2                	test   %edx,%edx
    d0c6:	74 08                	je     d0d0 <fwp_arg_drop55+0x10>
    d0c8:	48 8b 3f             	mov    (%rdi),%rdi
    d0cb:	e9 00 fd ff ff       	jmp    cdd0 <fwp_drop12>
    d0d0:	c3                   	ret
    d0d1:	66 66 66 66 66 66 2e 	data16 data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    d0d8:	0f 1f 84 00 00 00 00 
    d0df:	00 

000000000000d0e0 <fwp_drop13>:
    d0e0:	48 89 f8             	mov    %rdi,%rax
    d0e3:	48 2b 05 c6 60 00 00 	sub    0x60c6(%rip),%rax        # 131b0 <fwp_gc+0x1030>
    d0ea:	48 8b 0d e7 60 00 00 	mov    0x60e7(%rip),%rcx        # 131d8 <fwp_gc+0x1058>
    d0f1:	48 c1 e1 10          	shl    $0x10,%rcx
    d0f5:	48 39 c8             	cmp    %rcx,%rax
    d0f8:	0f 83 92 00 00 00    	jae    d190 <fwp_drop13+0xb0>
    d0fe:	48 8b 0d f3 60 00 00 	mov    0x60f3(%rip),%rcx        # 131f8 <fwp_gc+0x1078>
    d105:	48 89 c2             	mov    %rax,%rdx
    d108:	48 c1 ea 10          	shr    $0x10,%rdx
    d10c:	48 69 d2 28 12 00 00 	imul   $0x1228,%rdx,%rdx
    d113:	0f b6 34 11          	movzbl (%rcx,%rdx,1),%esi
    d117:	48 25 ff ff 00 00    	and    $0xffff,%rax
    d11d:	75 12                	jne    d131 <fwp_drop13+0x51>
    d11f:	40 80 fe 02          	cmp    $0x2,%sil
    d123:	75 0c                	jne    d131 <fwp_drop13+0x51>
    d125:	48 8d 04 11          	lea    (%rcx,%rdx,1),%rax
    d129:	48 05 28 02 00 00    	add    $0x228,%rax
    d12f:	eb 1f                	jmp    d150 <fwp_drop13+0x70>
    d131:	40 80 fe 01          	cmp    $0x1,%sil
    d135:	75 59                	jne    d190 <fwp_drop13+0xb0>
    d137:	48 8d 34 11          	lea    (%rcx,%rdx,1),%rsi
    d13b:	8b 4c 11 20          	mov    0x20(%rcx,%rdx,1),%ecx
    d13f:	48 0f af c1          	imul   %rcx,%rax
    d143:	48 c1 e8 20          	shr    $0x20,%rax
    d147:	48 01 f0             	add    %rsi,%rax
    d14a:	48 05 28 02 00 00    	add    $0x228,%rax
    d150:	0f b6 08             	movzbl (%rax),%ecx
    d153:	85 c9                	test   %ecx,%ecx
    d155:	74 39                	je     d190 <fwp_drop13+0xb0>
    d157:	83 f9 01             	cmp    $0x1,%ecx
    d15a:	75 28                	jne    d184 <fwp_drop13+0xa4>
    d15c:	8b 07                	mov    (%rdi),%eax
    d15e:	83 f8 01             	cmp    $0x1,%eax
    d161:	0f 84 39 d7 ff ff    	je     a8a0 <fwp_rc_free_obj>
    d167:	85 c0                	test   %eax,%eax
    d169:	75 25                	jne    d190 <fwp_drop13+0xb0>
    d16b:	53                   	push   %rbx
    d16c:	48 8b 47 08          	mov    0x8(%rdi),%rax
    d170:	48 89 fb             	mov    %rdi,%rbx
    d173:	48 89 c7             	mov    %rax,%rdi
    d176:	e8 55 fc ff ff       	call   cdd0 <fwp_drop12>
    d17b:	48 89 df             	mov    %rbx,%rdi
    d17e:	5b                   	pop    %rbx
    d17f:	e9 1c d7 ff ff       	jmp    a8a0 <fwp_rc_free_obj>
    d184:	81 f9 ff 00 00 00    	cmp    $0xff,%ecx
    d18a:	74 05                	je     d191 <fwp_drop13+0xb1>
    d18c:	fe c9                	dec    %cl
    d18e:	88 08                	mov    %cl,(%rax)
    d190:	c3                   	ret
    d191:	48 89 c7             	mov    %rax,%rdi
    d194:	e9 27 d4 ff ff       	jmp    a5c0 <fwp_rc_wide_drop>
    d199:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)

000000000000d1a0 <f57>:
    d1a0:	41 57                	push   %r15
    d1a2:	41 56                	push   %r14
    d1a4:	41 55                	push   %r13
    d1a6:	41 54                	push   %r12
    d1a8:	53                   	push   %rbx
    d1a9:	48 81 ec 80 00 00 00 	sub    $0x80,%rsp
    d1b0:	48 89 fb             	mov    %rdi,%rbx
    d1b3:	48 8b 47 10          	mov    0x10(%rdi),%rax
    d1b7:	48 2b 05 f2 5f 00 00 	sub    0x5ff2(%rip),%rax        # 131b0 <fwp_gc+0x1030>
    d1be:	48 8b 0d 13 60 00 00 	mov    0x6013(%rip),%rcx        # 131d8 <fwp_gc+0x1058>
    d1c5:	48 c1 e1 10          	shl    $0x10,%rcx
    d1c9:	48 39 c8             	cmp    %rcx,%rax
    d1cc:	73 68                	jae    d236 <f57+0x96>
    d1ce:	48 8b 0d 23 60 00 00 	mov    0x6023(%rip),%rcx        # 131f8 <fwp_gc+0x1078>
    d1d5:	48 89 c2             	mov    %rax,%rdx
    d1d8:	48 c1 ea 10          	shr    $0x10,%rdx
    d1dc:	48 69 d2 28 12 00 00 	imul   $0x1228,%rdx,%rdx
    d1e3:	0f b6 34 11          	movzbl (%rcx,%rdx,1),%esi
    d1e7:	48 25 ff ff 00 00    	and    $0xffff,%rax
    d1ed:	75 13                	jne    d202 <f57+0x62>
    d1ef:	40 80 fe 02          	cmp    $0x2,%sil
    d1f3:	75 0d                	jne    d202 <f57+0x62>
    d1f5:	48 8d 3c 11          	lea    (%rcx,%rdx,1),%rdi
    d1f9:	48 81 c7 28 02 00 00 	add    $0x228,%rdi
    d200:	eb 21                	jmp    d223 <f57+0x83>
    d202:	40 80 fe 01          	cmp    $0x1,%sil
    d206:	75 2e                	jne    d236 <f57+0x96>
    d208:	48 8d 34 11          	lea    (%rcx,%rdx,1),%rsi
    d20c:	8b 4c 11 20          	mov    0x20(%rcx,%rdx,1),%ecx
    d210:	48 0f af c1          	imul   %rcx,%rax
    d214:	48 c1 e8 20          	shr    $0x20,%rax
    d218:	48 8d 3c 30          	lea    (%rax,%rsi,1),%rdi
    d21c:	48 81 c7 28 02 00 00 	add    $0x228,%rdi
    d223:	0f b6 07             	movzbl (%rdi),%eax
    d226:	84 c0                	test   %al,%al
    d228:	74 0c                	je     d236 <f57+0x96>
    d22a:	3c fe                	cmp    $0xfe,%al
    d22c:	0f 83 ea 02 00 00    	jae    d51c <f57+0x37c>
    d232:	fe c0                	inc    %al
    d234:	88 07                	mov    %al,(%rdi)
    d236:	4c 8b 63 08          	mov    0x8(%rbx),%r12
    d23a:	4c 8b 73 10          	mov    0x10(%rbx),%r14
    d23e:	4c 0f be 7b 18       	movsbq 0x18(%rbx),%r15
    d243:	4d 85 e4             	test   %r12,%r12
    d246:	78 27                	js     d26f <f57+0xcf>
    d248:	49 8b 06             	mov    (%r14),%rax
    d24b:	48 b9 ff ff ff ff ff 	movabs $0x7fffffffffffffff,%rcx
    d252:	ff ff 7f 
    d255:	48 21 c1             	and    %rax,%rcx
    d258:	4c 39 e1             	cmp    %r12,%rcx
    d25b:	76 12                	jbe    d26f <f57+0xcf>
    d25d:	48 85 c0             	test   %rax,%rax
    d260:	0f 88 8e 00 00 00    	js     d2f4 <f57+0x154>
    d266:	49 8d 46 08          	lea    0x8(%r14),%rax
    d26a:	e9 89 00 00 00       	jmp    d2f8 <f57+0x158>
    d26f:	4c 89 f7             	mov    %r14,%rdi
    d272:	e8 09 fc ff ff       	call   ce80 <fwp_drop11>
    d277:	48 89 df             	mov    %rbx,%rdi
    d27a:	e8 01 03 00 00       	call   d580 <fwp_drop14>
    d27f:	48 c7 44 24 20 01 00 	movq   $0x1,0x20(%rsp)
    d286:	00 00 
    d288:	48 8d 54 24 28       	lea    0x28(%rsp),%rdx
    d28d:	4c 89 7c 24 28       	mov    %r15,0x28(%rsp)
    d292:	bf 01 00 00 00       	mov    $0x1,%edi
    d297:	be 01 00 00 00       	mov    $0x1,%esi
    d29c:	e8 bf ca ff ff       	call   9d60 <fwp_data>
    d2a1:	48 89 c1             	mov    %rax,%rcx
    d2a4:	48 2b 0d 05 5f 00 00 	sub    0x5f05(%rip),%rcx        # 131b0 <fwp_gc+0x1030>
    d2ab:	48 8b 15 26 5f 00 00 	mov    0x5f26(%rip),%rdx        # 131d8 <fwp_gc+0x1058>
    d2b2:	48 c1 e2 10          	shl    $0x10,%rdx
    d2b6:	48 39 d1             	cmp    %rdx,%rcx
    d2b9:	0f 83 4c 02 00 00    	jae    d50b <f57+0x36b>
    d2bf:	48 8b 15 32 5f 00 00 	mov    0x5f32(%rip),%rdx        # 131f8 <fwp_gc+0x1078>
    d2c6:	48 89 ce             	mov    %rcx,%rsi
    d2c9:	48 c1 ee 10          	shr    $0x10,%rsi
    d2cd:	48 69 f6 28 12 00 00 	imul   $0x1228,%rsi,%rsi
    d2d4:	0f b6 3c 32          	movzbl (%rdx,%rsi,1),%edi
    d2d8:	48 81 e1 ff ff 00 00 	and    $0xffff,%rcx
    d2df:	0f 85 f0 01 00 00    	jne    d4d5 <f57+0x335>
    d2e5:	40 80 ff 02          	cmp    $0x2,%dil
    d2e9:	0f 84 d1 01 00 00    	je     d4c0 <f57+0x320>
    d2ef:	e9 e1 01 00 00       	jmp    d4d5 <f57+0x335>
    d2f4:	49 8b 46 10          	mov    0x10(%r14),%rax
    d2f8:	4e 0f be 2c 20       	movsbq (%rax,%r12,1),%r13
    d2fd:	49 8d 45 81          	lea    -0x7f(%r13),%rax
    d301:	48 3d ff fe ff ff    	cmp    $0xfffffffffffffeff,%rax
    d307:	0f 86 23 02 00 00    	jbe    d530 <f57+0x390>
    d30d:	4c 89 f0             	mov    %r14,%rax
    d310:	48 2b 05 99 5e 00 00 	sub    0x5e99(%rip),%rax        # 131b0 <fwp_gc+0x1030>
    d317:	48 8b 0d ba 5e 00 00 	mov    0x5eba(%rip),%rcx        # 131d8 <fwp_gc+0x1058>
    d31e:	48 c1 e1 10          	shl    $0x10,%rcx
    d322:	48 39 c8             	cmp    %rcx,%rax
    d325:	73 68                	jae    d38f <f57+0x1ef>
    d327:	48 8b 0d ca 5e 00 00 	mov    0x5eca(%rip),%rcx        # 131f8 <fwp_gc+0x1078>
    d32e:	48 89 c2             	mov    %rax,%rdx
    d331:	48 c1 ea 10          	shr    $0x10,%rdx
    d335:	48 69 d2 28 12 00 00 	imul   $0x1228,%rdx,%rdx
    d33c:	0f b6 34 11          	movzbl (%rcx,%rdx,1),%esi
    d340:	48 25 ff ff 00 00    	and    $0xffff,%rax
    d346:	75 13                	jne    d35b <f57+0x1bb>
    d348:	40 80 fe 02          	cmp    $0x2,%sil
    d34c:	75 0d                	jne    d35b <f57+0x1bb>
    d34e:	48 8d 3c 11          	lea    (%rcx,%rdx,1),%rdi
    d352:	48 81 c7 28 02 00 00 	add    $0x228,%rdi
    d359:	eb 21                	jmp    d37c <f57+0x1dc>
    d35b:	40 80 fe 01          	cmp    $0x1,%sil
    d35f:	75 2e                	jne    d38f <f57+0x1ef>
    d361:	48 8d 34 11          	lea    (%rcx,%rdx,1),%rsi
    d365:	8b 4c 11 20          	mov    0x20(%rcx,%rdx,1),%ecx
    d369:	48 0f af c1          	imul   %rcx,%rax
    d36d:	48 c1 e8 20          	shr    $0x20,%rax
    d371:	48 8d 3c 30          	lea    (%rax,%rsi,1),%rdi
    d375:	48 81 c7 28 02 00 00 	add    $0x228,%rdi
    d37c:	0f b6 07             	movzbl (%rdi),%eax
    d37f:	84 c0                	test   %al,%al
    d381:	74 0c                	je     d38f <f57+0x1ef>
    d383:	3c fe                	cmp    $0xfe,%al
    d385:	0f 83 9b 01 00 00    	jae    d526 <f57+0x386>
    d38b:	fe c0                	inc    %al
    d38d:	88 07                	mov    %al,(%rdi)
    d38f:	4c 89 f7             	mov    %r14,%rdi
    d392:	e8 e9 fa ff ff       	call   ce80 <fwp_drop11>
    d397:	4b 8d 04 2f          	lea    (%r15,%r13,1),%rax
    d39b:	48 ff c0             	inc    %rax
    d39e:	48 0f be c8          	movsbq %al,%rcx
    d3a2:	48 39 c1             	cmp    %rax,%rcx
    d3a5:	0f 85 85 01 00 00    	jne    d530 <f57+0x390>
    d3ab:	49 ff c4             	inc    %r12
    d3ae:	4c 89 64 24 08       	mov    %r12,0x8(%rsp)
    d3b3:	4c 89 74 24 10       	mov    %r14,0x10(%rsp)
    d3b8:	48 89 44 24 18       	mov    %rax,0x18(%rsp)
    d3bd:	48 8d 54 24 08       	lea    0x8(%rsp),%rdx
    d3c2:	31 ff                	xor    %edi,%edi
    d3c4:	be 03 00 00 00       	mov    $0x3,%esi
    d3c9:	e8 92 c9 ff ff       	call   9d60 <fwp_data>
    d3ce:	49 89 c6             	mov    %rax,%r14
    d3d1:	48 2b 05 d8 5d 00 00 	sub    0x5dd8(%rip),%rax        # 131b0 <fwp_gc+0x1030>
    d3d8:	48 8b 0d f9 5d 00 00 	mov    0x5df9(%rip),%rcx        # 131d8 <fwp_gc+0x1058>
    d3df:	48 c1 e1 10          	shl    $0x10,%rcx
    d3e3:	48 39 c8             	cmp    %rcx,%rax
    d3e6:	73 6f                	jae    d457 <f57+0x2b7>
    d3e8:	48 8b 0d 09 5e 00 00 	mov    0x5e09(%rip),%rcx        # 131f8 <fwp_gc+0x1078>
    d3ef:	48 89 c2             	mov    %rax,%rdx
    d3f2:	48 c1 ea 10          	shr    $0x10,%rdx
    d3f6:	48 69 d2 28 12 00 00 	imul   $0x1228,%rdx,%rdx
    d3fd:	0f b6 34 11          	movzbl (%rcx,%rdx,1),%esi
    d401:	48 25 ff ff 00 00    	and    $0xffff,%rax
    d407:	75 1d                	jne    d426 <f57+0x286>
    d409:	40 80 fe 02          	cmp    $0x2,%sil
    d40d:	75 17                	jne    d426 <f57+0x286>
    d40f:	4c 8d 3c 11          	lea    (%rcx,%rdx,1),%r15
    d413:	49 81 c7 28 02 00 00 	add    $0x228,%r15
    d41a:	41 80 3f ff          	cmpb   $0xff,(%r15)
    d41e:	74 2d                	je     d44d <f57+0x2ad>
    d420:	41 c6 07 01          	movb   $0x1,(%r15)
    d424:	eb 31                	jmp    d457 <f57+0x2b7>
    d426:	40 80 fe 01          	cmp    $0x1,%sil
    d42a:	75 2b                	jne    d457 <f57+0x2b7>
    d42c:	48 8d 34 11          	lea    (%rcx,%rdx,1),%rsi
    d430:	8b 4c 11 20          	mov    0x20(%rcx,%rdx,1),%ecx
    d434:	48 0f af c1          	imul   %rcx,%rax
    d438:	48 c1 e8 20          	shr    $0x20,%rax
    d43c:	4c 8d 3c 30          	lea    (%rax,%rsi,1),%r15
    d440:	49 81 c7 28 02 00 00 	add    $0x228,%r15
    d447:	41 80 3f ff          	cmpb   $0xff,(%r15)
    d44b:	75 d3                	jne    d420 <f57+0x280>
    d44d:	4c 89 ff             	mov    %r15,%rdi
    d450:	e8 3b 8e ff ff       	call   6290 <fwp_rc_forget_slot>
    d455:	eb c9                	jmp    d420 <f57+0x280>
    d457:	48 89 df             	mov    %rbx,%rdi
    d45a:	e8 21 01 00 00       	call   d580 <fwp_drop14>
    d45f:	48 c7 44 24 20 00 00 	movq   $0x0,0x20(%rsp)
    d466:	00 00 
    d468:	48 8d 54 24 28       	lea    0x28(%rsp),%rdx
    d46d:	4c 89 74 24 28       	mov    %r14,0x28(%rsp)
    d472:	31 ff                	xor    %edi,%edi
    d474:	be 01 00 00 00       	mov    $0x1,%esi
    d479:	e8 e2 c8 ff ff       	call   9d60 <fwp_data>
    d47e:	48 89 c1             	mov    %rax,%rcx
    d481:	48 2b 0d 28 5d 00 00 	sub    0x5d28(%rip),%rcx        # 131b0 <fwp_gc+0x1030>
    d488:	48 8b 15 49 5d 00 00 	mov    0x5d49(%rip),%rdx        # 131d8 <fwp_gc+0x1058>
    d48f:	48 c1 e2 10          	shl    $0x10,%rdx
    d493:	48 39 d1             	cmp    %rdx,%rcx
    d496:	73 73                	jae    d50b <f57+0x36b>
    d498:	48 8b 15 59 5d 00 00 	mov    0x5d59(%rip),%rdx        # 131f8 <fwp_gc+0x1078>
    d49f:	48 89 ce             	mov    %rcx,%rsi
    d4a2:	48 c1 ee 10          	shr    $0x10,%rsi
    d4a6:	48 69 f6 28 12 00 00 	imul   $0x1228,%rsi,%rsi
    d4ad:	0f b6 3c 32          	movzbl (%rdx,%rsi,1),%edi
    d4b1:	48 81 e1 ff ff 00 00 	and    $0xffff,%rcx
    d4b8:	75 1b                	jne    d4d5 <f57+0x335>
    d4ba:	40 80 ff 02          	cmp    $0x2,%dil
    d4be:	75 15                	jne    d4d5 <f57+0x335>
    d4c0:	48 8d 1c 32          	lea    (%rdx,%rsi,1),%rbx
    d4c4:	48 81 c3 28 02 00 00 	add    $0x228,%rbx
    d4cb:	80 3b ff             	cmpb   $0xff,(%rbx)
    d4ce:	74 2b                	je     d4fb <f57+0x35b>
    d4d0:	c6 03 01             	movb   $0x1,(%rbx)
    d4d3:	eb 36                	jmp    d50b <f57+0x36b>
    d4d5:	40 80 ff 01          	cmp    $0x1,%dil
    d4d9:	75 30                	jne    d50b <f57+0x36b>
    d4db:	48 8d 3c 32          	lea    (%rdx,%rsi,1),%rdi
    d4df:	8b 54 32 20          	mov    0x20(%rdx,%rsi,1),%edx
    d4e3:	48 0f af ca          	imul   %rdx,%rcx
    d4e7:	48 c1 e9 20          	shr    $0x20,%rcx
    d4eb:	48 8d 1c 39          	lea    (%rcx,%rdi,1),%rbx
    d4ef:	48 81 c3 28 02 00 00 	add    $0x228,%rbx
    d4f6:	80 3b ff             	cmpb   $0xff,(%rbx)
    d4f9:	75 d5                	jne    d4d0 <f57+0x330>
    d4fb:	48 89 df             	mov    %rbx,%rdi
    d4fe:	49 89 c6             	mov    %rax,%r14
    d501:	e8 8a 8d ff ff       	call   6290 <fwp_rc_forget_slot>
    d506:	4c 89 f0             	mov    %r14,%rax
    d509:	eb c5                	jmp    d4d0 <f57+0x330>
    d50b:	48 81 c4 80 00 00 00 	add    $0x80,%rsp
    d512:	5b                   	pop    %rbx
    d513:	41 5c                	pop    %r12
    d515:	41 5d                	pop    %r13
    d517:	41 5e                	pop    %r14
    d519:	41 5f                	pop    %r15
    d51b:	c3                   	ret
    d51c:	e8 4f a0 ff ff       	call   7570 <fwp_rc_wide_dup>
    d521:	e9 10 fd ff ff       	jmp    d236 <f57+0x96>
    d526:	e8 45 a0 ff ff       	call   7570 <fwp_rc_wide_dup>
    d52b:	e9 5f fe ff ff       	jmp    d38f <f57+0x1ef>
    d530:	48 8d 15 54 21 00 00 	lea    0x2154(%rip),%rdx        # f68b <fwp_segv.msg+0x44b>
    d537:	48 8d 0d 65 20 00 00 	lea    0x2065(%rip),%rcx        # f5a3 <fwp_segv.msg+0x363>
    d53e:	48 8d 5c 24 20       	lea    0x20(%rsp),%rbx
    d543:	be 60 00 00 00       	mov    $0x60,%esi
    d548:	48 89 df             	mov    %rbx,%rdi
    d54b:	31 c0                	xor    %eax,%eax
    d54d:	e8 be 4b ff ff       	call   2110 <snprintf@plt>
    d552:	e8 09 8d ff ff       	call   6260 <fwp_flush>
    d557:	48 8b 05 82 4a 00 00 	mov    0x4a82(%rip),%rax        # 11fe0 <stderr@GLIBC_2.2.5>
    d55e:	48 8b 38             	mov    (%rax),%rdi
    d561:	48 8d 35 c5 1e 00 00 	lea    0x1ec5(%rip),%rsi        # f42d <fwp_segv.msg+0x1ed>
    d568:	48 89 da             	mov    %rbx,%rdx
    d56b:	31 c0                	xor    %eax,%eax
    d56d:	e8 3e 4c ff ff       	call   21b0 <fprintf@plt>
    d572:	bf 65 00 00 00       	mov    $0x65,%edi
    d577:	e8 14 4d ff ff       	call   2290 <exit@plt>
    d57c:	0f 1f 40 00          	nopl   0x0(%rax)

000000000000d580 <fwp_drop14>:
    d580:	48 89 f8             	mov    %rdi,%rax
    d583:	48 2b 05 26 5c 00 00 	sub    0x5c26(%rip),%rax        # 131b0 <fwp_gc+0x1030>
    d58a:	48 8b 0d 47 5c 00 00 	mov    0x5c47(%rip),%rcx        # 131d8 <fwp_gc+0x1058>
    d591:	48 c1 e1 10          	shl    $0x10,%rcx
    d595:	48 39 c8             	cmp    %rcx,%rax
    d598:	0f 83 83 00 00 00    	jae    d621 <fwp_drop14+0xa1>
    d59e:	48 8b 0d 53 5c 00 00 	mov    0x5c53(%rip),%rcx        # 131f8 <fwp_gc+0x1078>
    d5a5:	48 89 c2             	mov    %rax,%rdx
    d5a8:	48 c1 ea 10          	shr    $0x10,%rdx
    d5ac:	48 69 d2 28 12 00 00 	imul   $0x1228,%rdx,%rdx
    d5b3:	0f b6 34 11          	movzbl (%rcx,%rdx,1),%esi
    d5b7:	48 25 ff ff 00 00    	and    $0xffff,%rax
    d5bd:	75 12                	jne    d5d1 <fwp_drop14+0x51>
    d5bf:	40 80 fe 02          	cmp    $0x2,%sil
    d5c3:	75 0c                	jne    d5d1 <fwp_drop14+0x51>
    d5c5:	48 8d 04 11          	lea    (%rcx,%rdx,1),%rax
    d5c9:	48 05 28 02 00 00    	add    $0x228,%rax
    d5cf:	eb 1f                	jmp    d5f0 <fwp_drop14+0x70>
    d5d1:	40 80 fe 01          	cmp    $0x1,%sil
    d5d5:	75 4a                	jne    d621 <fwp_drop14+0xa1>
    d5d7:	48 8d 34 11          	lea    (%rcx,%rdx,1),%rsi
    d5db:	8b 4c 11 20          	mov    0x20(%rcx,%rdx,1),%ecx
    d5df:	48 0f af c1          	imul   %rcx,%rax
    d5e3:	48 c1 e8 20          	shr    $0x20,%rax
    d5e7:	48 01 f0             	add    %rsi,%rax
    d5ea:	48 05 28 02 00 00    	add    $0x228,%rax
    d5f0:	0f b6 08             	movzbl (%rax),%ecx
    d5f3:	85 c9                	test   %ecx,%ecx
    d5f5:	74 2a                	je     d621 <fwp_drop14+0xa1>
    d5f7:	83 f9 01             	cmp    $0x1,%ecx
    d5fa:	75 19                	jne    d615 <fwp_drop14+0x95>
    d5fc:	53                   	push   %rbx
    d5fd:	48 8b 47 10          	mov    0x10(%rdi),%rax
    d601:	48 89 fb             	mov    %rdi,%rbx
    d604:	48 89 c7             	mov    %rax,%rdi
    d607:	e8 74 f8 ff ff       	call   ce80 <fwp_drop11>
    d60c:	48 89 df             	mov    %rbx,%rdi
    d60f:	5b                   	pop    %rbx
    d610:	e9 8b d2 ff ff       	jmp    a8a0 <fwp_rc_free_obj>
    d615:	81 f9 ff 00 00 00    	cmp    $0xff,%ecx
    d61b:	74 05                	je     d622 <fwp_drop14+0xa2>
    d61d:	fe c9                	dec    %cl
    d61f:	88 08                	mov    %cl,(%rax)
    d621:	c3                   	ret
    d622:	48 89 c7             	mov    %rax,%rdi
    d625:	e9 96 cf ff ff       	jmp    a5c0 <fwp_rc_wide_drop>
    d62a:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)

000000000000d630 <fwp_owned_entry57>:
    d630:	48 8b 3f             	mov    (%rdi),%rdi
    d633:	e9 68 fb ff ff       	jmp    d1a0 <f57>
    d638:	0f 1f 84 00 00 00 00 	nopl   0x0(%rax,%rax,1)
    d63f:	00 

000000000000d640 <fwp_caps57>:
    d640:	53                   	push   %rbx
    d641:	83 7f 04 00          	cmpl   $0x0,0x4(%rdi)
    d645:	74 56                	je     d69d <fwp_caps57+0x5d>
    d647:	48 89 fb             	mov    %rdi,%rbx
    d64a:	48 8b 7f 08          	mov    0x8(%rdi),%rdi
    d64e:	85 f6                	test   %esi,%esi
    d650:	74 51                	je     d6a3 <fwp_caps57+0x63>
    d652:	48 2b 3d 57 5b 00 00 	sub    0x5b57(%rip),%rdi        # 131b0 <fwp_gc+0x1030>
    d659:	48 8b 05 78 5b 00 00 	mov    0x5b78(%rip),%rax        # 131d8 <fwp_gc+0x1058>
    d660:	48 c1 e0 10          	shl    $0x10,%rax
    d664:	48 39 c7             	cmp    %rax,%rdi
    d667:	73 38                	jae    d6a1 <fwp_caps57+0x61>
    d669:	48 8b 05 88 5b 00 00 	mov    0x5b88(%rip),%rax        # 131f8 <fwp_gc+0x1078>
    d670:	48 89 f9             	mov    %rdi,%rcx
    d673:	48 c1 e9 10          	shr    $0x10,%rcx
    d677:	48 69 c9 28 12 00 00 	imul   $0x1228,%rcx,%rcx
    d67e:	0f b6 14 08          	movzbl (%rax,%rcx,1),%edx
    d682:	48 81 e7 ff ff 00 00 	and    $0xffff,%rdi
    d689:	75 26                	jne    d6b1 <fwp_caps57+0x71>
    d68b:	80 fa 02             	cmp    $0x2,%dl
    d68e:	75 21                	jne    d6b1 <fwp_caps57+0x71>
    d690:	48 8d 3c 08          	lea    (%rax,%rcx,1),%rdi
    d694:	48 81 c7 28 02 00 00 	add    $0x228,%rdi
    d69b:	eb 33                	jmp    d6d0 <fwp_caps57+0x90>
    d69d:	85 f6                	test   %esi,%esi
    d69f:	74 0a                	je     d6ab <fwp_caps57+0x6b>
    d6a1:	5b                   	pop    %rbx
    d6a2:	c3                   	ret
    d6a3:	e8 d8 fe ff ff       	call   d580 <fwp_drop14>
    d6a8:	48 89 df             	mov    %rbx,%rdi
    d6ab:	5b                   	pop    %rbx
    d6ac:	e9 ef d1 ff ff       	jmp    a8a0 <fwp_rc_free_obj>
    d6b1:	80 fa 01             	cmp    $0x1,%dl
    d6b4:	75 eb                	jne    d6a1 <fwp_caps57+0x61>
    d6b6:	48 8d 14 08          	lea    (%rax,%rcx,1),%rdx
    d6ba:	8b 44 08 20          	mov    0x20(%rax,%rcx,1),%eax
    d6be:	48 0f af f8          	imul   %rax,%rdi
    d6c2:	48 c1 ef 20          	shr    $0x20,%rdi
    d6c6:	48 01 d7             	add    %rdx,%rdi
    d6c9:	48 81 c7 28 02 00 00 	add    $0x228,%rdi
    d6d0:	0f b6 07             	movzbl (%rdi),%eax
    d6d3:	84 c0                	test   %al,%al
    d6d5:	74 ca                	je     d6a1 <fwp_caps57+0x61>
    d6d7:	3c fe                	cmp    $0xfe,%al
    d6d9:	73 06                	jae    d6e1 <fwp_caps57+0xa1>
    d6db:	fe c0                	inc    %al
    d6dd:	88 07                	mov    %al,(%rdi)
    d6df:	5b                   	pop    %rbx
    d6e0:	c3                   	ret
    d6e1:	5b                   	pop    %rbx
    d6e2:	e9 89 9e ff ff       	jmp    7570 <fwp_rc_wide_dup>
    d6e7:	66 0f 1f 84 00 00 00 	nopw   0x0(%rax,%rax,1)
    d6ee:	00 00 

000000000000d6f0 <fwp_args57>:
    d6f0:	85 f6                	test   %esi,%esi
    d6f2:	0f 85 8a 00 00 00    	jne    d782 <fwp_args57+0x92>
    d6f8:	85 d2                	test   %edx,%edx
    d6fa:	0f 84 82 00 00 00    	je     d782 <fwp_args57+0x92>
    d700:	48 8b 07             	mov    (%rdi),%rax
    d703:	48 2b 05 a6 5a 00 00 	sub    0x5aa6(%rip),%rax        # 131b0 <fwp_gc+0x1030>
    d70a:	48 8b 0d c7 5a 00 00 	mov    0x5ac7(%rip),%rcx        # 131d8 <fwp_gc+0x1058>
    d711:	48 c1 e1 10          	shl    $0x10,%rcx
    d715:	48 39 c8             	cmp    %rcx,%rax
    d718:	73 68                	jae    d782 <fwp_args57+0x92>
    d71a:	48 8b 0d d7 5a 00 00 	mov    0x5ad7(%rip),%rcx        # 131f8 <fwp_gc+0x1078>
    d721:	48 89 c2             	mov    %rax,%rdx
    d724:	48 c1 ea 10          	shr    $0x10,%rdx
    d728:	48 69 d2 28 12 00 00 	imul   $0x1228,%rdx,%rdx
    d72f:	0f b6 34 11          	movzbl (%rcx,%rdx,1),%esi
    d733:	48 25 ff ff 00 00    	and    $0xffff,%rax
    d739:	75 13                	jne    d74e <fwp_args57+0x5e>
    d73b:	40 80 fe 02          	cmp    $0x2,%sil
    d73f:	75 0d                	jne    d74e <fwp_args57+0x5e>
    d741:	48 8d 3c 11          	lea    (%rcx,%rdx,1),%rdi
    d745:	48 81 c7 28 02 00 00 	add    $0x228,%rdi
    d74c:	eb 21                	jmp    d76f <fwp_args57+0x7f>
    d74e:	40 80 fe 01          	cmp    $0x1,%sil
    d752:	75 2e                	jne    d782 <fwp_args57+0x92>
    d754:	48 8d 34 11          	lea    (%rcx,%rdx,1),%rsi
    d758:	8b 4c 11 20          	mov    0x20(%rcx,%rdx,1),%ecx
    d75c:	48 0f af c1          	imul   %rcx,%rax
    d760:	48 c1 e8 20          	shr    $0x20,%rax
    d764:	48 8d 3c 30          	lea    (%rax,%rsi,1),%rdi
    d768:	48 81 c7 28 02 00 00 	add    $0x228,%rdi
    d76f:	0f b6 07             	movzbl (%rdi),%eax
    d772:	84 c0                	test   %al,%al
    d774:	74 0c                	je     d782 <fwp_args57+0x92>
    d776:	3c fe                	cmp    $0xfe,%al
    d778:	0f 83 f2 9d ff ff    	jae    7570 <fwp_rc_wide_dup>
    d77e:	fe c0                	inc    %al
    d780:	88 07                	mov    %al,(%rdi)
    d782:	c3                   	ret
    d783:	66 66 66 66 2e 0f 1f 	data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    d78a:	84 00 00 00 00 00 

000000000000d790 <fwp_arg_drop57>:
    d790:	85 f6                	test   %esi,%esi
    d792:	75 0c                	jne    d7a0 <fwp_arg_drop57+0x10>
    d794:	85 d2                	test   %edx,%edx
    d796:	74 08                	je     d7a0 <fwp_arg_drop57+0x10>
    d798:	48 8b 3f             	mov    (%rdi),%rdi
    d79b:	e9 e0 fd ff ff       	jmp    d580 <fwp_drop14>
    d7a0:	c3                   	ret
    d7a1:	66 66 66 66 66 66 2e 	data16 data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    d7a8:	0f 1f 84 00 00 00 00 
    d7af:	00 

000000000000d7b0 <fwp_drop15>:
    d7b0:	48 89 f8             	mov    %rdi,%rax
    d7b3:	48 2b 05 f6 59 00 00 	sub    0x59f6(%rip),%rax        # 131b0 <fwp_gc+0x1030>
    d7ba:	48 8b 0d 17 5a 00 00 	mov    0x5a17(%rip),%rcx        # 131d8 <fwp_gc+0x1058>
    d7c1:	48 c1 e1 10          	shl    $0x10,%rcx
    d7c5:	48 39 c8             	cmp    %rcx,%rax
    d7c8:	0f 83 92 00 00 00    	jae    d860 <fwp_drop15+0xb0>
    d7ce:	48 8b 0d 23 5a 00 00 	mov    0x5a23(%rip),%rcx        # 131f8 <fwp_gc+0x1078>
    d7d5:	48 89 c2             	mov    %rax,%rdx
    d7d8:	48 c1 ea 10          	shr    $0x10,%rdx
    d7dc:	48 69 d2 28 12 00 00 	imul   $0x1228,%rdx,%rdx
    d7e3:	0f b6 34 11          	movzbl (%rcx,%rdx,1),%esi
    d7e7:	48 25 ff ff 00 00    	and    $0xffff,%rax
    d7ed:	75 12                	jne    d801 <fwp_drop15+0x51>
    d7ef:	40 80 fe 02          	cmp    $0x2,%sil
    d7f3:	75 0c                	jne    d801 <fwp_drop15+0x51>
    d7f5:	48 8d 04 11          	lea    (%rcx,%rdx,1),%rax
    d7f9:	48 05 28 02 00 00    	add    $0x228,%rax
    d7ff:	eb 1f                	jmp    d820 <fwp_drop15+0x70>
    d801:	40 80 fe 01          	cmp    $0x1,%sil
    d805:	75 59                	jne    d860 <fwp_drop15+0xb0>
    d807:	48 8d 34 11          	lea    (%rcx,%rdx,1),%rsi
    d80b:	8b 4c 11 20          	mov    0x20(%rcx,%rdx,1),%ecx
    d80f:	48 0f af c1          	imul   %rcx,%rax
    d813:	48 c1 e8 20          	shr    $0x20,%rax
    d817:	48 01 f0             	add    %rsi,%rax
    d81a:	48 05 28 02 00 00    	add    $0x228,%rax
    d820:	0f b6 08             	movzbl (%rax),%ecx
    d823:	85 c9                	test   %ecx,%ecx
    d825:	74 39                	je     d860 <fwp_drop15+0xb0>
    d827:	83 f9 01             	cmp    $0x1,%ecx
    d82a:	75 28                	jne    d854 <fwp_drop15+0xa4>
    d82c:	8b 07                	mov    (%rdi),%eax
    d82e:	83 f8 01             	cmp    $0x1,%eax
    d831:	0f 84 69 d0 ff ff    	je     a8a0 <fwp_rc_free_obj>
    d837:	85 c0                	test   %eax,%eax
    d839:	75 25                	jne    d860 <fwp_drop15+0xb0>
    d83b:	53                   	push   %rbx
    d83c:	48 8b 47 08          	mov    0x8(%rdi),%rax
    d840:	48 89 fb             	mov    %rdi,%rbx
    d843:	48 89 c7             	mov    %rax,%rdi
    d846:	e8 35 fd ff ff       	call   d580 <fwp_drop14>
    d84b:	48 89 df             	mov    %rbx,%rdi
    d84e:	5b                   	pop    %rbx
    d84f:	e9 4c d0 ff ff       	jmp    a8a0 <fwp_rc_free_obj>
    d854:	81 f9 ff 00 00 00    	cmp    $0xff,%ecx
    d85a:	74 05                	je     d861 <fwp_drop15+0xb1>
    d85c:	fe c9                	dec    %cl
    d85e:	88 08                	mov    %cl,(%rax)
    d860:	c3                   	ret
    d861:	48 89 c7             	mov    %rax,%rdi
    d864:	e9 57 cd ff ff       	jmp    a5c0 <fwp_rc_wide_drop>
    d869:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)

000000000000d870 <f59>:
    d870:	41 57                	push   %r15
    d872:	41 56                	push   %r14
    d874:	53                   	push   %rbx
    d875:	48 83 ec 30          	sub    $0x30,%rsp
    d879:	48 89 fb             	mov    %rdi,%rbx
    d87c:	48 8b 47 10          	mov    0x10(%rdi),%rax
    d880:	48 2b 05 29 59 00 00 	sub    0x5929(%rip),%rax        # 131b0 <fwp_gc+0x1030>
    d887:	48 8b 0d 4a 59 00 00 	mov    0x594a(%rip),%rcx        # 131d8 <fwp_gc+0x1058>
    d88e:	48 c1 e1 10          	shl    $0x10,%rcx
    d892:	48 39 c8             	cmp    %rcx,%rax
    d895:	73 68                	jae    d8ff <f59+0x8f>
    d897:	48 8b 0d 5a 59 00 00 	mov    0x595a(%rip),%rcx        # 131f8 <fwp_gc+0x1078>
    d89e:	48 89 c2             	mov    %rax,%rdx
    d8a1:	48 c1 ea 10          	shr    $0x10,%rdx
    d8a5:	48 69 d2 28 12 00 00 	imul   $0x1228,%rdx,%rdx
    d8ac:	0f b6 34 11          	movzbl (%rcx,%rdx,1),%esi
    d8b0:	48 25 ff ff 00 00    	and    $0xffff,%rax
    d8b6:	75 13                	jne    d8cb <f59+0x5b>
    d8b8:	40 80 fe 02          	cmp    $0x2,%sil
    d8bc:	75 0d                	jne    d8cb <f59+0x5b>
    d8be:	48 8d 3c 11          	lea    (%rcx,%rdx,1),%rdi
    d8c2:	48 81 c7 28 02 00 00 	add    $0x228,%rdi
    d8c9:	eb 21                	jmp    d8ec <f59+0x7c>
    d8cb:	40 80 fe 01          	cmp    $0x1,%sil
    d8cf:	75 2e                	jne    d8ff <f59+0x8f>
    d8d1:	48 8d 34 11          	lea    (%rcx,%rdx,1),%rsi
    d8d5:	8b 4c 11 20          	mov    0x20(%rcx,%rdx,1),%ecx
    d8d9:	48 0f af c1          	imul   %rcx,%rax
    d8dd:	48 c1 e8 20          	shr    $0x20,%rax
    d8e1:	48 8d 3c 30          	lea    (%rax,%rsi,1),%rdi
    d8e5:	48 81 c7 28 02 00 00 	add    $0x228,%rdi
    d8ec:	0f b6 07             	movzbl (%rdi),%eax
    d8ef:	84 c0                	test   %al,%al
    d8f1:	74 0c                	je     d8ff <f59+0x8f>
    d8f3:	3c fe                	cmp    $0xfe,%al
    d8f5:	0f 83 d8 01 00 00    	jae    dad3 <f59+0x263>
    d8fb:	fe c0                	inc    %al
    d8fd:	88 07                	mov    %al,(%rdi)
    d8ff:	4c 8b 7b 08          	mov    0x8(%rbx),%r15
    d903:	48 8b 7b 10          	mov    0x10(%rbx),%rdi
    d907:	4c 8b 73 18          	mov    0x18(%rbx),%r14
    d90b:	4d 85 ff             	test   %r15,%r15
    d90e:	78 20                	js     d930 <f59+0xc0>
    d910:	48 8b 07             	mov    (%rdi),%rax
    d913:	48 b9 ff ff ff ff ff 	movabs $0x7fffffffffffffff,%rcx
    d91a:	ff ff 7f 
    d91d:	48 21 c1             	and    %rax,%rcx
    d920:	4c 39 f9             	cmp    %r15,%rcx
    d923:	76 0b                	jbe    d930 <f59+0xc0>
    d925:	48 85 c0             	test   %rax,%rax
    d928:	78 2e                	js     d958 <f59+0xe8>
    d92a:	48 8d 47 08          	lea    0x8(%rdi),%rax
    d92e:	eb 2c                	jmp    d95c <f59+0xec>
    d930:	e8 9b ca ff ff       	call   a3d0 <fwp_drop1>
    d935:	41 bf 01 00 00 00    	mov    $0x1,%r15d
    d93b:	48 89 df             	mov    %rbx,%rdi
    d93e:	e8 bd c8 ff ff       	call   a200 <fwp_drop6>
    d943:	4c 89 ff             	mov    %r15,%rdi
    d946:	4c 89 f6             	mov    %r14,%rsi
    d949:	e8 62 c9 ff ff       	call   a2b0 <fwp_vbox1>
    d94e:	48 83 c4 30          	add    $0x30,%rsp
    d952:	5b                   	pop    %rbx
    d953:	41 5e                	pop    %r14
    d955:	41 5f                	pop    %r15
    d957:	c3                   	ret
    d958:	48 8b 47 10          	mov    0x10(%rdi),%rax
    d95c:	4c 89 74 24 08       	mov    %r14,0x8(%rsp)
    d961:	f2 42 0f 10 04 f8    	movsd  (%rax,%r15,8),%xmm0
    d967:	f2 0f 59 05 a1 16 00 	mulsd  0x16a1(%rip),%xmm0        # f010 <_IO_stdin_used+0x10>
    d96e:	00 
    d96f:	f2 0f 58 05 a1 16 00 	addsd  0x16a1(%rip),%xmm0        # f018 <_IO_stdin_used+0x18>
    d976:	00 
    d977:	f2 0f 11 44 24 10    	movsd  %xmm0,0x10(%rsp)
    d97d:	48 89 f8             	mov    %rdi,%rax
    d980:	48 2b 05 29 58 00 00 	sub    0x5829(%rip),%rax        # 131b0 <fwp_gc+0x1030>
    d987:	49 ff c7             	inc    %r15
    d98a:	48 8b 0d 47 58 00 00 	mov    0x5847(%rip),%rcx        # 131d8 <fwp_gc+0x1058>
    d991:	48 c1 e1 10          	shl    $0x10,%rcx
    d995:	48 39 c8             	cmp    %rcx,%rax
    d998:	73 66                	jae    da00 <f59+0x190>
    d99a:	48 8b 0d 57 58 00 00 	mov    0x5857(%rip),%rcx        # 131f8 <fwp_gc+0x1078>
    d9a1:	48 89 c2             	mov    %rax,%rdx
    d9a4:	48 c1 ea 10          	shr    $0x10,%rdx
    d9a8:	48 69 d2 28 12 00 00 	imul   $0x1228,%rdx,%rdx
    d9af:	0f b6 34 11          	movzbl (%rcx,%rdx,1),%esi
    d9b3:	48 25 ff ff 00 00    	and    $0xffff,%rax
    d9b9:	75 12                	jne    d9cd <f59+0x15d>
    d9bb:	40 80 fe 02          	cmp    $0x2,%sil
    d9bf:	75 0c                	jne    d9cd <f59+0x15d>
    d9c1:	48 8d 04 11          	lea    (%rcx,%rdx,1),%rax
    d9c5:	48 05 28 02 00 00    	add    $0x228,%rax
    d9cb:	eb 1f                	jmp    d9ec <f59+0x17c>
    d9cd:	40 80 fe 01          	cmp    $0x1,%sil
    d9d1:	75 2d                	jne    da00 <f59+0x190>
    d9d3:	48 8d 34 11          	lea    (%rcx,%rdx,1),%rsi
    d9d7:	8b 4c 11 20          	mov    0x20(%rcx,%rdx,1),%ecx
    d9db:	48 0f af c1          	imul   %rcx,%rax
    d9df:	48 c1 e8 20          	shr    $0x20,%rax
    d9e3:	48 01 f0             	add    %rsi,%rax
    d9e6:	48 05 28 02 00 00    	add    $0x228,%rax
    d9ec:	0f b6 08             	movzbl (%rax),%ecx
    d9ef:	84 c9                	test   %cl,%cl
    d9f1:	74 0d                	je     da00 <f59+0x190>
    d9f3:	80 f9 fe             	cmp    $0xfe,%cl
    d9f6:	0f 83 e1 00 00 00    	jae    dadd <f59+0x26d>
    d9fc:	fe c1                	inc    %cl
    d9fe:	88 08                	mov    %cl,(%rax)
    da00:	49 89 fe             	mov    %rdi,%r14
    da03:	e8 c8 c9 ff ff       	call   a3d0 <fwp_drop1>
    da08:	f2 0f 10 44 24 10    	movsd  0x10(%rsp),%xmm0
    da0e:	f2 0f 58 44 24 08    	addsd  0x8(%rsp),%xmm0
    da14:	4c 89 7c 24 18       	mov    %r15,0x18(%rsp)
    da19:	4c 89 74 24 20       	mov    %r14,0x20(%rsp)
    da1e:	f2 0f 11 44 24 28    	movsd  %xmm0,0x28(%rsp)
    da24:	45 31 ff             	xor    %r15d,%r15d
    da27:	48 8d 54 24 18       	lea    0x18(%rsp),%rdx
    da2c:	31 ff                	xor    %edi,%edi
    da2e:	be 03 00 00 00       	mov    $0x3,%esi
    da33:	e8 28 c3 ff ff       	call   9d60 <fwp_data>
    da38:	49 89 c6             	mov    %rax,%r14
    da3b:	48 2b 05 6e 57 00 00 	sub    0x576e(%rip),%rax        # 131b0 <fwp_gc+0x1030>
    da42:	48 8b 0d 8f 57 00 00 	mov    0x578f(%rip),%rcx        # 131d8 <fwp_gc+0x1058>
    da49:	48 c1 e1 10          	shl    $0x10,%rcx
    da4d:	48 39 c8             	cmp    %rcx,%rax
    da50:	0f 83 e5 fe ff ff    	jae    d93b <f59+0xcb>
    da56:	48 8b 0d 9b 57 00 00 	mov    0x579b(%rip),%rcx        # 131f8 <fwp_gc+0x1078>
    da5d:	48 89 c2             	mov    %rax,%rdx
    da60:	48 c1 ea 10          	shr    $0x10,%rdx
    da64:	48 69 d2 28 12 00 00 	imul   $0x1228,%rdx,%rdx
    da6b:	0f b6 34 11          	movzbl (%rcx,%rdx,1),%esi
    da6f:	48 25 ff ff 00 00    	and    $0xffff,%rax
    da75:	75 23                	jne    da9a <f59+0x22a>
    da77:	40 80 fe 02          	cmp    $0x2,%sil
    da7b:	75 1d                	jne    da9a <f59+0x22a>
    da7d:	4c 8d 3c 11          	lea    (%rcx,%rdx,1),%r15
    da81:	49 81 c7 28 02 00 00 	add    $0x228,%r15
    da88:	41 80 3f ff          	cmpb   $0xff,(%r15)
    da8c:	74 33                	je     dac1 <f59+0x251>
    da8e:	41 c6 07 01          	movb   $0x1,(%r15)
    da92:	45 31 ff             	xor    %r15d,%r15d
    da95:	e9 a1 fe ff ff       	jmp    d93b <f59+0xcb>
    da9a:	40 80 fe 01          	cmp    $0x1,%sil
    da9e:	75 2b                	jne    dacb <f59+0x25b>
    daa0:	48 8d 34 11          	lea    (%rcx,%rdx,1),%rsi
    daa4:	8b 4c 11 20          	mov    0x20(%rcx,%rdx,1),%ecx
    daa8:	48 0f af c1          	imul   %rcx,%rax
    daac:	48 c1 e8 20          	shr    $0x20,%rax
    dab0:	4c 8d 3c 30          	lea    (%rax,%rsi,1),%r15
    dab4:	49 81 c7 28 02 00 00 	add    $0x228,%r15
    dabb:	41 80 3f ff          	cmpb   $0xff,(%r15)
    dabf:	75 cd                	jne    da8e <f59+0x21e>
    dac1:	4c 89 ff             	mov    %r15,%rdi
    dac4:	e8 c7 87 ff ff       	call   6290 <fwp_rc_forget_slot>
    dac9:	eb c3                	jmp    da8e <f59+0x21e>
    dacb:	45 31 ff             	xor    %r15d,%r15d
    dace:	e9 68 fe ff ff       	jmp    d93b <f59+0xcb>
    dad3:	e8 98 9a ff ff       	call   7570 <fwp_rc_wide_dup>
    dad8:	e9 22 fe ff ff       	jmp    d8ff <f59+0x8f>
    dadd:	49 89 fe             	mov    %rdi,%r14
    dae0:	48 89 c7             	mov    %rax,%rdi
    dae3:	e8 88 9a ff ff       	call   7570 <fwp_rc_wide_dup>
    dae8:	4c 89 f7             	mov    %r14,%rdi
    daeb:	e9 10 ff ff ff       	jmp    da00 <f59+0x190>

000000000000daf0 <fwp_owned_entry59>:
    daf0:	48 8b 3f             	mov    (%rdi),%rdi
    daf3:	e9 78 fd ff ff       	jmp    d870 <f59>
    daf8:	0f 1f 84 00 00 00 00 	nopl   0x0(%rax,%rax,1)
    daff:	00 

000000000000db00 <fwp_caps59>:
    db00:	53                   	push   %rbx
    db01:	83 7f 04 00          	cmpl   $0x0,0x4(%rdi)
    db05:	74 56                	je     db5d <fwp_caps59+0x5d>
    db07:	48 89 fb             	mov    %rdi,%rbx
    db0a:	48 8b 7f 08          	mov    0x8(%rdi),%rdi
    db0e:	85 f6                	test   %esi,%esi
    db10:	74 51                	je     db63 <fwp_caps59+0x63>
    db12:	48 2b 3d 97 56 00 00 	sub    0x5697(%rip),%rdi        # 131b0 <fwp_gc+0x1030>
    db19:	48 8b 05 b8 56 00 00 	mov    0x56b8(%rip),%rax        # 131d8 <fwp_gc+0x1058>
    db20:	48 c1 e0 10          	shl    $0x10,%rax
    db24:	48 39 c7             	cmp    %rax,%rdi
    db27:	73 38                	jae    db61 <fwp_caps59+0x61>
    db29:	48 8b 05 c8 56 00 00 	mov    0x56c8(%rip),%rax        # 131f8 <fwp_gc+0x1078>
    db30:	48 89 f9             	mov    %rdi,%rcx
    db33:	48 c1 e9 10          	shr    $0x10,%rcx
    db37:	48 69 c9 28 12 00 00 	imul   $0x1228,%rcx,%rcx
    db3e:	0f b6 14 08          	movzbl (%rax,%rcx,1),%edx
    db42:	48 81 e7 ff ff 00 00 	and    $0xffff,%rdi
    db49:	75 26                	jne    db71 <fwp_caps59+0x71>
    db4b:	80 fa 02             	cmp    $0x2,%dl
    db4e:	75 21                	jne    db71 <fwp_caps59+0x71>
    db50:	48 8d 3c 08          	lea    (%rax,%rcx,1),%rdi
    db54:	48 81 c7 28 02 00 00 	add    $0x228,%rdi
    db5b:	eb 33                	jmp    db90 <fwp_caps59+0x90>
    db5d:	85 f6                	test   %esi,%esi
    db5f:	74 0a                	je     db6b <fwp_caps59+0x6b>
    db61:	5b                   	pop    %rbx
    db62:	c3                   	ret
    db63:	e8 98 c6 ff ff       	call   a200 <fwp_drop6>
    db68:	48 89 df             	mov    %rbx,%rdi
    db6b:	5b                   	pop    %rbx
    db6c:	e9 2f cd ff ff       	jmp    a8a0 <fwp_rc_free_obj>
    db71:	80 fa 01             	cmp    $0x1,%dl
    db74:	75 eb                	jne    db61 <fwp_caps59+0x61>
    db76:	48 8d 14 08          	lea    (%rax,%rcx,1),%rdx
    db7a:	8b 44 08 20          	mov    0x20(%rax,%rcx,1),%eax
    db7e:	48 0f af f8          	imul   %rax,%rdi
    db82:	48 c1 ef 20          	shr    $0x20,%rdi
    db86:	48 01 d7             	add    %rdx,%rdi
    db89:	48 81 c7 28 02 00 00 	add    $0x228,%rdi
    db90:	0f b6 07             	movzbl (%rdi),%eax
    db93:	84 c0                	test   %al,%al
    db95:	74 ca                	je     db61 <fwp_caps59+0x61>
    db97:	3c fe                	cmp    $0xfe,%al
    db99:	73 06                	jae    dba1 <fwp_caps59+0xa1>
    db9b:	fe c0                	inc    %al
    db9d:	88 07                	mov    %al,(%rdi)
    db9f:	5b                   	pop    %rbx
    dba0:	c3                   	ret
    dba1:	5b                   	pop    %rbx
    dba2:	e9 c9 99 ff ff       	jmp    7570 <fwp_rc_wide_dup>
    dba7:	66 0f 1f 84 00 00 00 	nopw   0x0(%rax,%rax,1)
    dbae:	00 00 

000000000000dbb0 <fwp_args59>:
    dbb0:	85 f6                	test   %esi,%esi
    dbb2:	0f 85 8a 00 00 00    	jne    dc42 <fwp_args59+0x92>
    dbb8:	85 d2                	test   %edx,%edx
    dbba:	0f 84 82 00 00 00    	je     dc42 <fwp_args59+0x92>
    dbc0:	48 8b 07             	mov    (%rdi),%rax
    dbc3:	48 2b 05 e6 55 00 00 	sub    0x55e6(%rip),%rax        # 131b0 <fwp_gc+0x1030>
    dbca:	48 8b 0d 07 56 00 00 	mov    0x5607(%rip),%rcx        # 131d8 <fwp_gc+0x1058>
    dbd1:	48 c1 e1 10          	shl    $0x10,%rcx
    dbd5:	48 39 c8             	cmp    %rcx,%rax
    dbd8:	73 68                	jae    dc42 <fwp_args59+0x92>
    dbda:	48 8b 0d 17 56 00 00 	mov    0x5617(%rip),%rcx        # 131f8 <fwp_gc+0x1078>
    dbe1:	48 89 c2             	mov    %rax,%rdx
    dbe4:	48 c1 ea 10          	shr    $0x10,%rdx
    dbe8:	48 69 d2 28 12 00 00 	imul   $0x1228,%rdx,%rdx
    dbef:	0f b6 34 11          	movzbl (%rcx,%rdx,1),%esi
    dbf3:	48 25 ff ff 00 00    	and    $0xffff,%rax
    dbf9:	75 13                	jne    dc0e <fwp_args59+0x5e>
    dbfb:	40 80 fe 02          	cmp    $0x2,%sil
    dbff:	75 0d                	jne    dc0e <fwp_args59+0x5e>
    dc01:	48 8d 3c 11          	lea    (%rcx,%rdx,1),%rdi
    dc05:	48 81 c7 28 02 00 00 	add    $0x228,%rdi
    dc0c:	eb 21                	jmp    dc2f <fwp_args59+0x7f>
    dc0e:	40 80 fe 01          	cmp    $0x1,%sil
    dc12:	75 2e                	jne    dc42 <fwp_args59+0x92>
    dc14:	48 8d 34 11          	lea    (%rcx,%rdx,1),%rsi
    dc18:	8b 4c 11 20          	mov    0x20(%rcx,%rdx,1),%ecx
    dc1c:	48 0f af c1          	imul   %rcx,%rax
    dc20:	48 c1 e8 20          	shr    $0x20,%rax
    dc24:	48 8d 3c 30          	lea    (%rax,%rsi,1),%rdi
    dc28:	48 81 c7 28 02 00 00 	add    $0x228,%rdi
    dc2f:	0f b6 07             	movzbl (%rdi),%eax
    dc32:	84 c0                	test   %al,%al
    dc34:	74 0c                	je     dc42 <fwp_args59+0x92>
    dc36:	3c fe                	cmp    $0xfe,%al
    dc38:	0f 83 32 99 ff ff    	jae    7570 <fwp_rc_wide_dup>
    dc3e:	fe c0                	inc    %al
    dc40:	88 07                	mov    %al,(%rdi)
    dc42:	c3                   	ret
    dc43:	66 66 66 66 2e 0f 1f 	data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    dc4a:	84 00 00 00 00 00 

000000000000dc50 <fwp_arg_drop59>:
    dc50:	85 f6                	test   %esi,%esi
    dc52:	75 0c                	jne    dc60 <fwp_arg_drop59+0x10>
    dc54:	85 d2                	test   %edx,%edx
    dc56:	74 08                	je     dc60 <fwp_arg_drop59+0x10>
    dc58:	48 8b 3f             	mov    (%rdi),%rdi
    dc5b:	e9 a0 c5 ff ff       	jmp    a200 <fwp_drop6>
    dc60:	c3                   	ret
    dc61:	66 66 66 66 66 66 2e 	data16 data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    dc68:	0f 1f 84 00 00 00 00 
    dc6f:	00 

000000000000dc70 <fwp_gc_find_data>:
    dc70:	0f b7 77 18          	movzwl 0x18(%rdi),%esi
    dc74:	48 85 f6             	test   %rsi,%rsi
    dc77:	0f 84 be 00 00 00    	je     dd3b <fwp_gc_find_data+0xcb>
    dc7d:	53                   	push   %rbx
    dc7e:	48 8b 07             	mov    (%rdi),%rax
    dc81:	4c 8b 47 10          	mov    0x10(%rdi),%r8
    dc85:	48 6b ce 38          	imul   $0x38,%rsi,%rcx
    dc89:	45 31 c9             	xor    %r9d,%r9d
    dc8c:	48 8d 15 ed 44 00 00 	lea    0x44ed(%rip),%rdx        # 12180 <fwp_gc>
    dc93:	41 bb 01 00 00 00    	mov    $0x1,%r11d
    dc99:	45 31 d2             	xor    %r10d,%r10d
    dc9c:	eb 0b                	jmp    dca9 <fwp_gc_find_data+0x39>
    dc9e:	66 90                	xchg   %ax,%ax
    dca0:	49 83 c1 38          	add    $0x38,%r9
    dca4:	4c 39 c9             	cmp    %r9,%rcx
    dca7:	74 22                	je     dccb <fwp_gc_find_data+0x5b>
    dca9:	43 83 3c 08 01       	cmpl   $0x1,(%r8,%r9,1)
    dcae:	75 f0                	jne    dca0 <fwp_gc_find_data+0x30>
    dcb0:	4b 8b 5c 08 10       	mov    0x10(%r8,%r9,1),%rbx
    dcb5:	48 01 c3             	add    %rax,%rbx
    dcb8:	48 39 d3             	cmp    %rdx,%rbx
    dcbb:	77 e3                	ja     dca0 <fwp_gc_find_data+0x30>
    dcbd:	4b 03 5c 08 28       	add    0x28(%r8,%r9,1),%rbx
    dcc2:	48 39 d3             	cmp    %rdx,%rbx
    dcc5:	45 0f 47 d3          	cmova  %r11d,%r10d
    dcc9:	eb d5                	jmp    dca0 <fwp_gc_find_data+0x30>
    dccb:	31 c0                	xor    %eax,%eax
    dccd:	45 85 d2             	test   %r10d,%r10d
    dcd0:	0f 95 c0             	setne  %al
    dcd3:	74 6e                	je     dd43 <fwp_gc_find_data+0xd3>
    dcd5:	66 85 f6             	test   %si,%si
    dcd8:	74 69                	je     dd43 <fwp_gc_find_data+0xd3>
    dcda:	8b 05 30 56 00 00    	mov    0x5630(%rip),%eax        # 13310 <fwp_gc+0x1190>
    dce0:	48 8b 77 10          	mov    0x10(%rdi),%rsi
    dce4:	45 31 c0             	xor    %r8d,%r8d
    dce7:	eb 10                	jmp    dcf9 <fwp_gc_find_data+0x89>
    dce9:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)
    dcf0:	49 83 c0 38          	add    $0x38,%r8
    dcf4:	4c 39 c1             	cmp    %r8,%rcx
    dcf7:	74 45                	je     dd3e <fwp_gc_find_data+0xce>
    dcf9:	42 83 3c 06 01       	cmpl   $0x1,(%rsi,%r8,1)
    dcfe:	75 f0                	jne    dcf0 <fwp_gc_find_data+0x80>
    dd00:	42 f6 44 06 04 02    	testb  $0x2,0x4(%rsi,%r8,1)
    dd06:	74 e8                	je     dcf0 <fwp_gc_find_data+0x80>
    dd08:	83 f8 10             	cmp    $0x10,%eax
    dd0b:	74 31                	je     dd3e <fwp_gc_find_data+0xce>
    dd0d:	4e 8b 4c 06 10       	mov    0x10(%rsi,%r8,1),%r9
    dd12:	4c 03 0f             	add    (%rdi),%r9
    dd15:	4c 63 d0             	movslq %eax,%r10
    dd18:	49 c1 e2 04          	shl    $0x4,%r10
    dd1c:	4d 89 8c 12 90 10 00 	mov    %r9,0x1090(%r10,%rdx,1)
    dd23:	00 
    dd24:	4e 8b 4c 06 28       	mov    0x28(%rsi,%r8,1),%r9
    dd29:	4d 89 8c 12 98 10 00 	mov    %r9,0x1098(%r10,%rdx,1)
    dd30:	00 
    dd31:	ff c0                	inc    %eax
    dd33:	89 05 d7 55 00 00    	mov    %eax,0x55d7(%rip)        # 13310 <fwp_gc+0x1190>
    dd39:	eb b5                	jmp    dcf0 <fwp_gc_find_data+0x80>
    dd3b:	31 c0                	xor    %eax,%eax
    dd3d:	c3                   	ret
    dd3e:	b8 01 00 00 00       	mov    $0x1,%eax
    dd43:	5b                   	pop    %rbx
    dd44:	c3                   	ret
    dd45:	66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
    dd4c:	00 00 00 00 

000000000000dd50 <fwp_gc_report>:
    dd50:	55                   	push   %rbp
    dd51:	41 57                	push   %r15
    dd53:	41 56                	push   %r14
    dd55:	41 55                	push   %r13
    dd57:	41 54                	push   %r12
    dd59:	53                   	push   %rbx
    dd5a:	48 81 ec 58 01 00 00 	sub    $0x158,%rsp
    dd61:	48 8b 05 28 56 00 00 	mov    0x5628(%rip),%rax        # 13390 <fwp_gc+0x1210>
    dd68:	48 8b 0d 11 44 00 00 	mov    0x4411(%rip),%rcx        # 12180 <fwp_gc>
    dd6f:	48 29 c8             	sub    %rcx,%rax
    dd72:	f2 48 0f 2a c0       	cvtsi2sd %rax,%xmm0
    dd77:	f2 0f 58 05 e9 55 00 	addsd  0x55e9(%rip),%xmm0        # 13368 <fwp_gc+0x11e8>
    dd7e:	00 
    dd7f:	f2 0f 11 44 24 48    	movsd  %xmm0,0x48(%rsp)
    dd85:	f2 0f 11 05 db 55 00 	movsd  %xmm0,0x55db(%rip)        # 13368 <fwp_gc+0x11e8>
    dd8c:	00 
    dd8d:	48 89 0d fc 55 00 00 	mov    %rcx,0x55fc(%rip)        # 13390 <fwp_gc+0x1210>
    dd94:	48 8b 05 45 42 00 00 	mov    0x4245(%rip),%rax        # 11fe0 <stderr@GLIBC_2.2.5>
    dd9b:	48 8b 28             	mov    (%rax),%rbp
    dd9e:	48 8b 1d b3 55 00 00 	mov    0x55b3(%rip),%rbx        # 13358 <fwp_gc+0x11d8>
    dda5:	4c 8b 3d ec 53 00 00 	mov    0x53ec(%rip),%r15        # 13198 <fwp_gc+0x1018>
    ddac:	f2 0f 10 05 d4 55 00 	movsd  0x55d4(%rip),%xmm0        # 13388 <fwp_gc+0x1208>
    ddb3:	00 
    ddb4:	f2 0f 11 44 24 30    	movsd  %xmm0,0x30(%rsp)
    ddba:	48 8b 05 07 54 00 00 	mov    0x5407(%rip),%rax        # 131c8 <fwp_gc+0x1048>
    ddc1:	48 89 44 24 28       	mov    %rax,0x28(%rsp)
    ddc6:	48 8b 05 7b 55 00 00 	mov    0x557b(%rip),%rax        # 13348 <fwp_gc+0x11c8>
    ddcd:	48 89 44 24 20       	mov    %rax,0x20(%rsp)
    ddd2:	4c 8b 35 77 55 00 00 	mov    0x5577(%rip),%r14        # 13350 <fwp_gc+0x11d0>
    ddd9:	f2 0f 10 05 8f 55 00 	movsd  0x558f(%rip),%xmm0        # 13370 <fwp_gc+0x11f0>
    dde0:	00 
    dde1:	f2 0f 11 44 24 40    	movsd  %xmm0,0x40(%rsp)
    dde7:	f2 0f 10 05 89 55 00 	movsd  0x5589(%rip),%xmm0        # 13378 <fwp_gc+0x11f8>
    ddee:	00 
    ddef:	f2 0f 11 44 24 38    	movsd  %xmm0,0x38(%rsp)
    ddf5:	48 8d 3d fb 19 00 00 	lea    0x19fb(%rip),%rdi        # f7f7 <fwp_segv.msg+0x5b7>
    ddfc:	48 8d 35 6e 18 00 00 	lea    0x186e(%rip),%rsi        # f671 <fwp_segv.msg+0x431>
    de03:	e8 48 44 ff ff       	call   2250 <fopen@plt>
    de08:	49 c7 c4 ff ff ff ff 	mov    $0xffffffffffffffff,%r12
    de0f:	48 85 c0             	test   %rax,%rax
    de12:	74 4b                	je     de5f <fwp_gc_report+0x10f>
    de14:	49 89 c5             	mov    %rax,%r13
    de17:	48 89 6c 24 08       	mov    %rbp,0x8(%rsp)
    de1c:	4c 89 7c 24 10       	mov    %r15,0x10(%rsp)
    de21:	48 89 5c 24 18       	mov    %rbx,0x18(%rsp)
    de26:	48 8d 7c 24 50       	lea    0x50(%rsp),%rdi
    de2b:	be 00 01 00 00       	mov    $0x100,%esi
    de30:	48 89 c2             	mov    %rax,%rdx
    de33:	e8 28 43 ff ff       	call   2160 <fgets@plt>
    de38:	49 c7 c4 ff ff ff ff 	mov    $0xffffffffffffffff,%r12
    de3f:	48 85 c0             	test   %rax,%rax
    de42:	0f 85 f1 00 00 00    	jne    df39 <fwp_gc_report+0x1e9>
    de48:	4c 89 ef             	mov    %r13,%rdi
    de4b:	e8 80 42 ff ff       	call   20d0 <fclose@plt>
    de50:	48 8b 5c 24 18       	mov    0x18(%rsp),%rbx
    de55:	4c 8b 7c 24 10       	mov    0x10(%rsp),%r15
    de5a:	48 8b 6c 24 08       	mov    0x8(%rsp),%rbp
    de5f:	66 49 0f 6e c6       	movq   %r14,%xmm0
    de64:	66 0f 6f 0d 94 12 00 	movdqa 0x1294(%rip),%xmm1        # f100 <_IO_stdin_used+0x100>
    de6b:	00 
    de6c:	66 0f 62 c1          	punpckldq %xmm1,%xmm0
    de70:	66 0f 28 15 98 12 00 	movapd 0x1298(%rip),%xmm2        # f110 <_IO_stdin_used+0x110>
    de77:	00 
    de78:	66 0f 5c c2          	subpd  %xmm2,%xmm0
    de7c:	66 0f 28 e0          	movapd %xmm0,%xmm4
    de80:	66 0f 15 e0          	unpckhpd %xmm0,%xmm4
    de84:	f2 0f 58 e0          	addsd  %xmm0,%xmm4
    de88:	f2 0f 10 35 98 11 00 	movsd  0x1198(%rip),%xmm6        # f028 <_IO_stdin_used+0x28>
    de8f:	00 
    de90:	f2 0f 59 e6          	mulsd  %xmm6,%xmm4
    de94:	f3 0f 7e 6c 24 20    	movq   0x20(%rsp),%xmm5
    de9a:	66 0f 62 e9          	punpckldq %xmm1,%xmm5
    de9e:	66 0f 5c ea          	subpd  %xmm2,%xmm5
    dea2:	66 0f 28 dd          	movapd %xmm5,%xmm3
    dea6:	66 0f 15 dd          	unpckhpd %xmm5,%xmm3
    deaa:	f2 0f 58 dd          	addsd  %xmm5,%xmm3
    deae:	f2 0f 59 de          	mulsd  %xmm6,%xmm3
    deb2:	f3 0f 7e 6c 24 28    	movq   0x28(%rsp),%xmm5
    deb8:	66 0f 62 e9          	punpckldq %xmm1,%xmm5
    debc:	66 0f 5c ea          	subpd  %xmm2,%xmm5
    dec0:	66 0f 28 d5          	movapd %xmm5,%xmm2
    dec4:	66 0f 15 d5          	unpckhpd %xmm5,%xmm2
    dec8:	f2 0f 58 d5          	addsd  %xmm5,%xmm2
    decc:	f2 0f 59 d6          	mulsd  %xmm6,%xmm2
    ded0:	f2 0f 10 44 24 48    	movsd  0x48(%rsp),%xmm0
    ded6:	f2 0f 10 4c 24 30    	movsd  0x30(%rsp),%xmm1
    dedc:	f2 0f 58 c1          	addsd  %xmm1,%xmm0
    dee0:	f2 0f 59 ce          	mulsd  %xmm6,%xmm1
    dee4:	f2 0f 59 c6          	mulsd  %xmm6,%xmm0
    dee8:	83 3d 85 52 00 00 00 	cmpl   $0x0,0x5285(%rip)        # 13174 <fwp_gc+0xff4>
    deef:	48 8d 05 ef 18 00 00 	lea    0x18ef(%rip),%rax        # f7e5 <fwp_segv.msg+0x5a5>
    def6:	4c 8d 0d 32 18 00 00 	lea    0x1832(%rip),%r9        # f72f <fwp_segv.msg+0x4ef>
    defd:	4c 0f 44 c8          	cmove  %rax,%r9
    df01:	48 8d 35 28 18 00 00 	lea    0x1828(%rip),%rsi        # f730 <fwp_segv.msg+0x4f0>
    df08:	48 89 ef             	mov    %rbp,%rdi
    df0b:	48 89 da             	mov    %rbx,%rdx
    df0e:	4c 89 f9             	mov    %r15,%rcx
    df11:	f2 0f 10 6c 24 40    	movsd  0x40(%rsp),%xmm5
    df17:	f2 0f 10 74 24 38    	movsd  0x38(%rsp),%xmm6
    df1d:	4d 89 e0             	mov    %r12,%r8
    df20:	b0 07                	mov    $0x7,%al
    df22:	e8 89 42 ff ff       	call   21b0 <fprintf@plt>
    df27:	48 81 c4 58 01 00 00 	add    $0x158,%rsp
    df2e:	5b                   	pop    %rbx
    df2f:	41 5c                	pop    %r12
    df31:	41 5d                	pop    %r13
    df33:	41 5e                	pop    %r14
    df35:	41 5f                	pop    %r15
    df37:	5d                   	pop    %rbp
    df38:	c3                   	ret
    df39:	48 8d 6c 24 56       	lea    0x56(%rsp),%rbp
    df3e:	41 bf 56 6d 48 57    	mov    $0x57486d56,%r15d
    df44:	48 8d 5c 24 50       	lea    0x50(%rsp),%rbx
    df49:	eb 1e                	jmp    df69 <fwp_gc_report+0x219>
    df4b:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)
    df50:	48 89 df             	mov    %rbx,%rdi
    df53:	be 00 01 00 00       	mov    $0x100,%esi
    df58:	4c 89 ea             	mov    %r13,%rdx
    df5b:	e8 00 42 ff ff       	call   2160 <fgets@plt>
    df60:	48 85 c0             	test   %rax,%rax
    df63:	0f 84 df fe ff ff    	je     de48 <fwp_gc_report+0xf8>
    df69:	8b 44 24 50          	mov    0x50(%rsp),%eax
    df6d:	44 31 f8             	xor    %r15d,%eax
    df70:	0f b6 4c 24 54       	movzbl 0x54(%rsp),%ecx
    df75:	83 f1 4d             	xor    $0x4d,%ecx
    df78:	09 c1                	or     %eax,%ecx
    df7a:	75 d4                	jne    df50 <fwp_gc_report+0x200>
    df7c:	80 7c 24 55 3a       	cmpb   $0x3a,0x55(%rsp)
    df81:	75 cd                	jne    df50 <fwp_gc_report+0x200>
    df83:	48 89 ef             	mov    %rbp,%rdi
    df86:	31 f6                	xor    %esi,%esi
    df88:	ba 0a 00 00 00       	mov    $0xa,%edx
    df8d:	e8 3e 42 ff ff       	call   21d0 <strtol@plt>
    df92:	49 89 c4             	mov    %rax,%r12
    df95:	eb b9                	jmp    df50 <fwp_gc_report+0x200>
    df97:	66 0f 1f 84 00 00 00 	nopw   0x0(%rax,%rax,1)
    df9e:	00 00 

000000000000dfa0 <fwp_segv>:
    dfa0:	48 8b 05 51 5c 00 00 	mov    0x5c51(%rip),%rax        # 13bf8 <fwp_main_stack_top>
    dfa7:	48 85 c0             	test   %rax,%rax
    dfaa:	74 22                	je     dfce <fwp_segv+0x2e>
    dfac:	48 8b 4e 10          	mov    0x10(%rsi),%rcx
    dfb0:	48 2b 05 49 5c 00 00 	sub    0x5c49(%rip),%rax        # 13c00 <fwp_main_stack_size>
    dfb7:	48 8d 90 00 00 f0 ff 	lea    -0x100000(%rax),%rdx
    dfbe:	48 39 ca             	cmp    %rcx,%rdx
    dfc1:	77 0b                	ja     dfce <fwp_segv+0x2e>
    dfc3:	48 05 00 00 10 00    	add    $0x100000,%rax
    dfc9:	48 39 c8             	cmp    %rcx,%rax
    dfcc:	77 07                	ja     dfd5 <fwp_segv+0x35>
    dfce:	31 f6                	xor    %esi,%esi
    dfd0:	e9 bb 41 ff ff       	jmp    2190 <signal@plt>
    dfd5:	50                   	push   %rax
    dfd6:	e8 85 82 ff ff       	call   6260 <fwp_flush>
    dfdb:	48 8d 35 5e 12 00 00 	lea    0x125e(%rip),%rsi        # f240 <fwp_segv.msg>
    dfe2:	ba 1a 00 00 00       	mov    $0x1a,%edx
    dfe7:	bf 02 00 00 00       	mov    $0x2,%edi
    dfec:	e8 cf 40 ff ff       	call   20c0 <write@plt>
    dff1:	bf 65 00 00 00       	mov    $0x65,%edi
    dff6:	e8 75 40 ff ff       	call   2070 <_exit@plt>
    dffb:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)

000000000000e000 <fwp_drop0>:
    e000:	53                   	push   %rbx
    e001:	48 89 f8             	mov    %rdi,%rax
    e004:	48 2b 05 a5 51 00 00 	sub    0x51a5(%rip),%rax        # 131b0 <fwp_gc+0x1030>
    e00b:	48 8b 0d c6 51 00 00 	mov    0x51c6(%rip),%rcx        # 131d8 <fwp_gc+0x1058>
    e012:	48 c1 e1 10          	shl    $0x10,%rcx
    e016:	48 39 c8             	cmp    %rcx,%rax
    e019:	0f 83 96 00 00 00    	jae    e0b5 <fwp_drop0+0xb5>
    e01f:	48 8b 0d d2 51 00 00 	mov    0x51d2(%rip),%rcx        # 131f8 <fwp_gc+0x1078>
    e026:	48 89 c2             	mov    %rax,%rdx
    e029:	48 c1 ea 10          	shr    $0x10,%rdx
    e02d:	48 69 d2 28 12 00 00 	imul   $0x1228,%rdx,%rdx
    e034:	0f b6 34 11          	movzbl (%rcx,%rdx,1),%esi
    e038:	48 25 ff ff 00 00    	and    $0xffff,%rax
    e03e:	75 20                	jne    e060 <fwp_drop0+0x60>
    e040:	40 80 fe 02          	cmp    $0x2,%sil
    e044:	75 1a                	jne    e060 <fwp_drop0+0x60>
    e046:	48 8d 04 11          	lea    (%rcx,%rdx,1),%rax
    e04a:	48 05 28 02 00 00    	add    $0x228,%rax
    e050:	eb 2d                	jmp    e07f <fwp_drop0+0x7f>
    e052:	66 66 66 66 66 2e 0f 	data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    e059:	1f 84 00 00 00 00 00 
    e060:	40 80 fe 01          	cmp    $0x1,%sil
    e064:	75 4f                	jne    e0b5 <fwp_drop0+0xb5>
    e066:	48 8d 34 11          	lea    (%rcx,%rdx,1),%rsi
    e06a:	8b 4c 11 20          	mov    0x20(%rcx,%rdx,1),%ecx
    e06e:	48 0f af c1          	imul   %rcx,%rax
    e072:	48 c1 e8 20          	shr    $0x20,%rax
    e076:	48 01 f0             	add    %rsi,%rax
    e079:	48 05 28 02 00 00    	add    $0x228,%rax
    e07f:	0f b6 08             	movzbl (%rax),%ecx
    e082:	85 c9                	test   %ecx,%ecx
    e084:	74 2f                	je     e0b5 <fwp_drop0+0xb5>
    e086:	83 f9 01             	cmp    $0x1,%ecx
    e089:	75 2c                	jne    e0b7 <fwp_drop0+0xb7>
    e08b:	48 8b 5f 10          	mov    0x10(%rdi),%rbx
    e08f:	e8 0c c8 ff ff       	call   a8a0 <fwp_rc_free_obj>
    e094:	48 89 d8             	mov    %rbx,%rax
    e097:	48 2b 05 12 51 00 00 	sub    0x5112(%rip),%rax        # 131b0 <fwp_gc+0x1030>
    e09e:	48 8b 0d 33 51 00 00 	mov    0x5133(%rip),%rcx        # 131d8 <fwp_gc+0x1058>
    e0a5:	48 c1 e1 10          	shl    $0x10,%rcx
    e0a9:	48 89 df             	mov    %rbx,%rdi
    e0ac:	48 39 c8             	cmp    %rcx,%rax
    e0af:	0f 82 6a ff ff ff    	jb     e01f <fwp_drop0+0x1f>
    e0b5:	5b                   	pop    %rbx
    e0b6:	c3                   	ret
    e0b7:	81 f9 ff 00 00 00    	cmp    $0xff,%ecx
    e0bd:	74 06                	je     e0c5 <fwp_drop0+0xc5>
    e0bf:	fe c9                	dec    %cl
    e0c1:	88 08                	mov    %cl,(%rax)
    e0c3:	5b                   	pop    %rbx
    e0c4:	c3                   	ret
    e0c5:	48 89 c7             	mov    %rax,%rdi
    e0c8:	5b                   	pop    %rbx
    e0c9:	e9 f2 c4 ff ff       	jmp    a5c0 <fwp_rc_wide_drop>
    e0ce:	66 90                	xchg   %ax,%ax

000000000000e0d0 <fwp_drop4>:
    e0d0:	53                   	push   %rbx
    e0d1:	48 89 f8             	mov    %rdi,%rax
    e0d4:	48 2b 05 d5 50 00 00 	sub    0x50d5(%rip),%rax        # 131b0 <fwp_gc+0x1030>
    e0db:	48 8b 0d f6 50 00 00 	mov    0x50f6(%rip),%rcx        # 131d8 <fwp_gc+0x1058>
    e0e2:	48 c1 e1 10          	shl    $0x10,%rcx
    e0e6:	48 39 c8             	cmp    %rcx,%rax
    e0e9:	0f 83 96 00 00 00    	jae    e185 <fwp_drop4+0xb5>
    e0ef:	48 8b 0d 02 51 00 00 	mov    0x5102(%rip),%rcx        # 131f8 <fwp_gc+0x1078>
    e0f6:	48 89 c2             	mov    %rax,%rdx
    e0f9:	48 c1 ea 10          	shr    $0x10,%rdx
    e0fd:	48 69 d2 28 12 00 00 	imul   $0x1228,%rdx,%rdx
    e104:	0f b6 34 11          	movzbl (%rcx,%rdx,1),%esi
    e108:	48 25 ff ff 00 00    	and    $0xffff,%rax
    e10e:	75 20                	jne    e130 <fwp_drop4+0x60>
    e110:	40 80 fe 02          	cmp    $0x2,%sil
    e114:	75 1a                	jne    e130 <fwp_drop4+0x60>
    e116:	48 8d 04 11          	lea    (%rcx,%rdx,1),%rax
    e11a:	48 05 28 02 00 00    	add    $0x228,%rax
    e120:	eb 2d                	jmp    e14f <fwp_drop4+0x7f>
    e122:	66 66 66 66 66 2e 0f 	data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    e129:	1f 84 00 00 00 00 00 
    e130:	40 80 fe 01          	cmp    $0x1,%sil
    e134:	75 4f                	jne    e185 <fwp_drop4+0xb5>
    e136:	48 8d 34 11          	lea    (%rcx,%rdx,1),%rsi
    e13a:	8b 4c 11 20          	mov    0x20(%rcx,%rdx,1),%ecx
    e13e:	48 0f af c1          	imul   %rcx,%rax
    e142:	48 c1 e8 20          	shr    $0x20,%rax
    e146:	48 01 f0             	add    %rsi,%rax
    e149:	48 05 28 02 00 00    	add    $0x228,%rax
    e14f:	0f b6 08             	movzbl (%rax),%ecx
    e152:	85 c9                	test   %ecx,%ecx
    e154:	74 2f                	je     e185 <fwp_drop4+0xb5>
    e156:	83 f9 01             	cmp    $0x1,%ecx
    e159:	75 2c                	jne    e187 <fwp_drop4+0xb7>
    e15b:	48 8b 5f 10          	mov    0x10(%rdi),%rbx
    e15f:	e8 3c c7 ff ff       	call   a8a0 <fwp_rc_free_obj>
    e164:	48 89 d8             	mov    %rbx,%rax
    e167:	48 2b 05 42 50 00 00 	sub    0x5042(%rip),%rax        # 131b0 <fwp_gc+0x1030>
    e16e:	48 8b 0d 63 50 00 00 	mov    0x5063(%rip),%rcx        # 131d8 <fwp_gc+0x1058>
    e175:	48 c1 e1 10          	shl    $0x10,%rcx
    e179:	48 89 df             	mov    %rbx,%rdi
    e17c:	48 39 c8             	cmp    %rcx,%rax
    e17f:	0f 82 6a ff ff ff    	jb     e0ef <fwp_drop4+0x1f>
    e185:	5b                   	pop    %rbx
    e186:	c3                   	ret
    e187:	81 f9 ff 00 00 00    	cmp    $0xff,%ecx
    e18d:	74 06                	je     e195 <fwp_drop4+0xc5>
    e18f:	fe c9                	dec    %cl
    e191:	88 08                	mov    %cl,(%rax)
    e193:	5b                   	pop    %rbx
    e194:	c3                   	ret
    e195:	48 89 c7             	mov    %rax,%rdi
    e198:	5b                   	pop    %rbx
    e199:	e9 22 c4 ff ff       	jmp    a5c0 <fwp_rc_wide_drop>
    e19e:	66 90                	xchg   %ax,%ax

000000000000e1a0 <__divti3>:
    e1a0:	f3 0f 1e fa          	endbr64
    e1a4:	55                   	push   %rbp
    e1a5:	49 89 f8             	mov    %rdi,%r8
    e1a8:	49 89 d2             	mov    %rdx,%r10
    e1ab:	49 89 cb             	mov    %rcx,%r11
    e1ae:	31 ff                	xor    %edi,%edi
    e1b0:	48 89 e5             	mov    %rsp,%rbp
    e1b3:	41 56                	push   %r14
    e1b5:	53                   	push   %rbx
    e1b6:	48 85 f6             	test   %rsi,%rsi
    e1b9:	79 13                	jns    e1ce <__divti3+0x2e>
    e1bb:	45 31 c9             	xor    %r9d,%r9d
    e1be:	49 f7 d8             	neg    %r8
    e1c1:	48 c7 c7 ff ff ff ff 	mov    $0xffffffffffffffff,%rdi
    e1c8:	49 19 f1             	sbb    %rsi,%r9
    e1cb:	4c 89 ce             	mov    %r9,%rsi
    e1ce:	4c 89 da             	mov    %r11,%rdx
    e1d1:	4d 85 db             	test   %r11,%r11
    e1d4:	0f 88 f6 00 00 00    	js     e2d0 <__divti3+0x130>
    e1da:	4d 89 d6             	mov    %r10,%r14
    e1dd:	75 31                	jne    e210 <__divti3+0x70>
    e1df:	4c 39 f6             	cmp    %r14,%rsi
    e1e2:	0f 83 b8 00 00 00    	jae    e2a0 <__divti3+0x100>
    e1e8:	48 89 f2             	mov    %rsi,%rdx
    e1eb:	31 f6                	xor    %esi,%esi
    e1ed:	4c 89 c0             	mov    %r8,%rax
    e1f0:	49 f7 f6             	div    %r14
    e1f3:	48 89 f2             	mov    %rsi,%rdx
    e1f6:	48 85 ff             	test   %rdi,%rdi
    e1f9:	74 0a                	je     e205 <__divti3+0x65>
    e1fb:	48 f7 d8             	neg    %rax
    e1fe:	48 83 d2 00          	adc    $0x0,%rdx
    e202:	48 f7 da             	neg    %rdx
    e205:	5b                   	pop    %rbx
    e206:	41 5e                	pop    %r14
    e208:	5d                   	pop    %rbp
    e209:	c3                   	ret
    e20a:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)
    e210:	4c 39 de             	cmp    %r11,%rsi
    e213:	0f 82 d5 00 00 00    	jb     e2ee <__divti3+0x14e>
    e219:	4d 0f bd d3          	bsr    %r11,%r10
    e21d:	41 83 f2 3f          	xor    $0x3f,%r10d
    e221:	44 89 d1             	mov    %r10d,%ecx
    e224:	b8 40 00 00 00       	mov    $0x40,%eax
    e229:	4c 89 f3             	mov    %r14,%rbx
    e22c:	4d 89 f1             	mov    %r14,%r9
    e22f:	48 d3 e2             	shl    %cl,%rdx
    e232:	49 63 ca             	movslq %r10d,%rcx
    e235:	49 89 f3             	mov    %rsi,%r11
    e238:	48 29 c8             	sub    %rcx,%rax
    e23b:	89 c1                	mov    %eax,%ecx
    e23d:	48 d3 eb             	shr    %cl,%rbx
    e240:	44 89 d1             	mov    %r10d,%ecx
    e243:	49 d3 e1             	shl    %cl,%r9
    e246:	89 c1                	mov    %eax,%ecx
    e248:	48 09 d3             	or     %rdx,%rbx
    e24b:	4c 89 c2             	mov    %r8,%rdx
    e24e:	49 d3 eb             	shr    %cl,%r11
    e251:	44 89 d1             	mov    %r10d,%ecx
    e254:	48 d3 e6             	shl    %cl,%rsi
    e257:	89 c1                	mov    %eax,%ecx
    e259:	48 d3 ea             	shr    %cl,%rdx
    e25c:	48 89 d0             	mov    %rdx,%rax
    e25f:	4c 89 da             	mov    %r11,%rdx
    e262:	48 09 f0             	or     %rsi,%rax
    e265:	48 f7 f3             	div    %rbx
    e268:	49 89 d3             	mov    %rdx,%r11
    e26b:	48 89 c6             	mov    %rax,%rsi
    e26e:	49 f7 e1             	mul    %r9
    e271:	49 39 d3             	cmp    %rdx,%r11
    e274:	0f 82 be 00 00 00    	jb     e338 <__divti3+0x198>
    e27a:	44 89 d1             	mov    %r10d,%ecx
    e27d:	49 d3 e0             	shl    %cl,%r8
    e280:	49 39 c0             	cmp    %rax,%r8
    e283:	73 09                	jae    e28e <__divti3+0xee>
    e285:	49 39 d3             	cmp    %rdx,%r11
    e288:	0f 84 aa 00 00 00    	je     e338 <__divti3+0x198>
    e28e:	48 89 f0             	mov    %rsi,%rax
    e291:	31 f6                	xor    %esi,%esi
    e293:	e9 5b ff ff ff       	jmp    e1f3 <__divti3+0x53>
    e298:	0f 1f 84 00 00 00 00 	nopl   0x0(%rax,%rax,1)
    e29f:	00 
    e2a0:	4d 85 f6             	test   %r14,%r14
    e2a3:	75 0d                	jne    e2b2 <__divti3+0x112>
    e2a5:	b8 01 00 00 00       	mov    $0x1,%eax
    e2aa:	31 d2                	xor    %edx,%edx
    e2ac:	49 f7 f6             	div    %r14
    e2af:	49 89 c6             	mov    %rax,%r14
    e2b2:	48 89 f0             	mov    %rsi,%rax
    e2b5:	31 d2                	xor    %edx,%edx
    e2b7:	49 f7 f6             	div    %r14
    e2ba:	48 89 c6             	mov    %rax,%rsi
    e2bd:	4c 89 c0             	mov    %r8,%rax
    e2c0:	49 f7 f6             	div    %r14
    e2c3:	e9 2b ff ff ff       	jmp    e1f3 <__divti3+0x53>
    e2c8:	0f 1f 84 00 00 00 00 	nopl   0x0(%rax,%rax,1)
    e2cf:	00 
    e2d0:	49 f7 da             	neg    %r10
    e2d3:	48 f7 d7             	not    %rdi
    e2d6:	49 83 d3 00          	adc    $0x0,%r11
    e2da:	4d 89 d6             	mov    %r10,%r14
    e2dd:	49 f7 db             	neg    %r11
    e2e0:	4c 89 da             	mov    %r11,%rdx
    e2e3:	0f 84 f6 fe ff ff    	je     e1df <__divti3+0x3f>
    e2e9:	4c 39 de             	cmp    %r11,%rsi
    e2ec:	73 12                	jae    e300 <__divti3+0x160>
    e2ee:	31 f6                	xor    %esi,%esi
    e2f0:	31 c0                	xor    %eax,%eax
    e2f2:	e9 fc fe ff ff       	jmp    e1f3 <__divti3+0x53>
    e2f7:	66 0f 1f 84 00 00 00 	nopw   0x0(%rax,%rax,1)
    e2fe:	00 00 
    e300:	49 0f bd c3          	bsr    %r11,%rax
    e304:	48 83 f0 3f          	xor    $0x3f,%rax
    e308:	41 89 c2             	mov    %eax,%r10d
    e30b:	85 c0                	test   %eax,%eax
    e30d:	0f 85 0e ff ff ff    	jne    e221 <__divti3+0x81>
    e313:	49 39 f3             	cmp    %rsi,%r11
    e316:	72 0d                	jb     e325 <__divti3+0x185>
    e318:	31 f6                	xor    %esi,%esi
    e31a:	31 c0                	xor    %eax,%eax
    e31c:	4d 39 f0             	cmp    %r14,%r8
    e31f:	0f 82 ce fe ff ff    	jb     e1f3 <__divti3+0x53>
    e325:	31 f6                	xor    %esi,%esi
    e327:	b8 01 00 00 00       	mov    $0x1,%eax
    e32c:	e9 c2 fe ff ff       	jmp    e1f3 <__divti3+0x53>
    e331:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)
    e338:	48 8d 46 ff          	lea    -0x1(%rsi),%rax
    e33c:	31 f6                	xor    %esi,%esi
    e33e:	e9 b0 fe ff ff       	jmp    e1f3 <__divti3+0x53>
    e343:	66 2e 0f 1f 84 00 00 	cs nopw 0x0(%rax,%rax,1)
    e34a:	00 00 00 
    e34d:	0f 1f 00             	nopl   (%rax)

000000000000e350 <atexit>:
    e350:	f3 0f 1e fa          	endbr64
    e354:	48 8b 15 15 3e 00 00 	mov    0x3e15(%rip),%rdx        # 12170 <__dso_handle>
    e35b:	31 f6                	xor    %esi,%esi
    e35d:	e9 0e 3f ff ff       	jmp    2270 <__cxa_atexit@plt>

Disassembly of section .fini:

000000000000e364 <_fini>:
    e364:	f3 0f 1e fa          	endbr64
    e368:	48 83 ec 08          	sub    $0x8,%rsp
    e36c:	48 83 c4 08          	add    $0x8,%rsp
    e370:	c3                   	ret
