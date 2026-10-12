
/tmp/fwp-arc-3169/arrays-1-O2:     file format elf64-x86-64


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
    256d:	e8 8e 42 00 00       	call   6800 <fwp_gc_init>
    2572:	48 89 2d 8f 0c 01 00 	mov    %rbp,0x10c8f(%rip)        # 13208 <fwp_gc+0x1088>
    2579:	48 8d 3d 10 b4 00 00 	lea    0xb410(%rip),%rdi        # d990 <fwp_gc_find_data>
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
    25af:	48 8d 3d ba b4 00 00 	lea    0xb4ba(%rip),%rdi        # da70 <fwp_gc_report>
    25b6:	e8 b5 ba 00 00       	call   e070 <atexit>
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
    26a5:	48 8d 05 14 b6 00 00 	lea    0xb614(%rip),%rax        # dcc0 <fwp_segv>
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
    2726:	e8 f5 75 00 00       	call   9d20 <fwp_data>
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
    27b1:	e8 9a 3a 00 00       	call   6250 <fwp_rc_forget_slot>
    27b6:	48 89 d8             	mov    %rbx,%rax
    27b9:	eb c3                	jmp    277e <fwp_main_thread+0x22e>
    27bb:	48 b9 00 00 00 00 00 	movabs $0x3fd0000000000000,%rcx
    27c2:	00 d0 3f 
    27c5:	48 89 4d a0          	mov    %rcx,-0x60(%rbp)
    27c9:	48 89 45 a8          	mov    %rax,-0x58(%rbp)
    27cd:	48 8d 55 a0          	lea    -0x60(%rbp),%rdx
    27d1:	bf 01 00 00 00       	mov    $0x1,%edi
    27d6:	be 02 00 00 00       	mov    $0x2,%esi
    27db:	e8 40 75 00 00       	call   9d20 <fwp_data>
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
    2866:	e8 e5 39 00 00       	call   6250 <fwp_rc_forget_slot>
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
    289d:	e8 7e 74 00 00       	call   9d20 <fwp_data>
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
    2928:	e8 23 39 00 00       	call   6250 <fwp_rc_forget_slot>
    292d:	48 89 d8             	mov    %rbx,%rax
    2930:	eb c3                	jmp    28f5 <fwp_main_thread+0x3a5>
    2932:	48 b9 00 00 00 00 00 	movabs $0x3ff8000000000000,%rcx
    2939:	00 f8 3f 
    293c:	48 89 8d c0 fe ff ff 	mov    %rcx,-0x140(%rbp)
    2943:	48 89 85 c8 fe ff ff 	mov    %rax,-0x138(%rbp)
    294a:	48 8d 95 c0 fe ff ff 	lea    -0x140(%rbp),%rdx
    2951:	bf 01 00 00 00       	mov    $0x1,%edi
    2956:	be 02 00 00 00       	mov    $0x2,%esi
    295b:	e8 c0 73 00 00       	call   9d20 <fwp_data>
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
    29e2:	e8 69 38 00 00       	call   6250 <fwp_rc_forget_slot>
    29e7:	eb c9                	jmp    29b2 <fwp_main_thread+0x462>
    29e9:	48 8d 35 60 f2 00 00 	lea    0xf260(%rip),%rsi        # 11c50 <d0>
    29f0:	4c 89 f7             	mov    %r14,%rdi
    29f3:	e8 08 39 00 00       	call   6300 <fwp_p_array_from_list_typed>
    29f8:	49 89 c7             	mov    %rax,%r15
    29fb:	4c 89 f7             	mov    %r14,%rdi
    29fe:	e8 1d b3 00 00       	call   dd20 <fwp_drop0>
    2a03:	31 db                	xor    %ebx,%ebx
    2a05:	be 04 00 00 00       	mov    $0x4,%esi
    2a0a:	31 ff                	xor    %edi,%edi
    2a0c:	4c 89 fa             	mov    %r15,%rdx
    2a0f:	e8 dc 47 00 00       	call   71f0 <f12>
    2a14:	49 89 c6             	mov    %rax,%r14
    2a17:	4c 89 ff             	mov    %r15,%rdi
    2a1a:	e8 51 79 00 00       	call   a370 <fwp_drop1>
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
    2a73:	e8 f8 78 00 00       	call   a370 <fwp_drop1>
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
    2ad4:	e8 b7 4b 00 00       	call   7690 <fwp_show>
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
    2b5b:	e8 f0 36 00 00       	call   6250 <fwp_rc_forget_slot>
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
    2c0c:	e8 2f 7c 00 00       	call   a840 <fwp_rc_free_obj>
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
    2c52:	e8 c9 70 00 00       	call   9d20 <fwp_data>
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
    2cdd:	e8 6e 35 00 00       	call   6250 <fwp_rc_forget_slot>
    2ce2:	48 89 d8             	mov    %rbx,%rax
    2ce5:	eb c3                	jmp    2caa <fwp_main_thread+0x75a>
    2ce7:	48 c7 85 e0 fe ff ff 	movq   $0x3e800000,-0x120(%rbp)
    2cee:	00 00 80 3e 
    2cf2:	48 89 85 e8 fe ff ff 	mov    %rax,-0x118(%rbp)
    2cf9:	48 8d 95 e0 fe ff ff 	lea    -0x120(%rbp),%rdx
    2d00:	bf 01 00 00 00       	mov    $0x1,%edi
    2d05:	be 02 00 00 00       	mov    $0x2,%esi
    2d0a:	e8 11 70 00 00       	call   9d20 <fwp_data>
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
    2d95:	e8 b6 34 00 00       	call   6250 <fwp_rc_forget_slot>
    2d9a:	48 89 d8             	mov    %rbx,%rax
    2d9d:	eb c3                	jmp    2d62 <fwp_main_thread+0x812>
    2d9f:	4c 89 bd f0 fe ff ff 	mov    %r15,-0x110(%rbp)
    2da6:	48 89 85 f8 fe ff ff 	mov    %rax,-0x108(%rbp)
    2dad:	48 8d 95 f0 fe ff ff 	lea    -0x110(%rbp),%rdx
    2db4:	bf 01 00 00 00       	mov    $0x1,%edi
    2db9:	be 02 00 00 00       	mov    $0x2,%esi
    2dbe:	e8 5d 6f 00 00       	call   9d20 <fwp_data>
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
    2e49:	e8 02 34 00 00       	call   6250 <fwp_rc_forget_slot>
    2e4e:	48 89 d8             	mov    %rbx,%rax
    2e51:	eb c3                	jmp    2e16 <fwp_main_thread+0x8c6>
    2e53:	48 c7 85 00 ff ff ff 	movq   $0x3fc00000,-0x100(%rbp)
    2e5a:	00 00 c0 3f 
    2e5e:	48 89 85 08 ff ff ff 	mov    %rax,-0xf8(%rbp)
    2e65:	48 8d 95 00 ff ff ff 	lea    -0x100(%rbp),%rdx
    2e6c:	bf 01 00 00 00       	mov    $0x1,%edi
    2e71:	be 02 00 00 00       	mov    $0x2,%esi
    2e76:	e8 a5 6e 00 00       	call   9d20 <fwp_data>
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
    2efd:	e8 4e 33 00 00       	call   6250 <fwp_rc_forget_slot>
    2f02:	eb c9                	jmp    2ecd <fwp_main_thread+0x97d>
    2f04:	48 8d 35 05 ee 00 00 	lea    0xee05(%rip),%rsi        # 11d10 <d2>
    2f0b:	4c 89 ff             	mov    %r15,%rdi
    2f0e:	e8 ed 33 00 00       	call   6300 <fwp_p_array_from_list_typed>
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
    2f9d:	e8 9e 78 00 00       	call   a840 <fwp_rc_free_obj>
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
    2ff3:	e8 78 95 00 00       	call   c570 <fwp_drop7>
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
    3066:	e8 25 46 00 00       	call   7690 <fwp_show>
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
    30ed:	e8 5e 31 00 00       	call   6250 <fwp_rc_forget_slot>
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
    319e:	e8 9d 76 00 00       	call   a840 <fwp_rc_free_obj>
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
    31db:	e8 40 6b 00 00       	call   9d20 <fwp_data>
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
    3266:	e8 e5 2f 00 00       	call   6250 <fwp_rc_forget_slot>
    326b:	48 89 d8             	mov    %rbx,%rax
    326e:	eb c3                	jmp    3233 <fwp_main_thread+0xce3>
    3270:	48 c7 85 20 ff ff ff 	movq   $0x0,-0xe0(%rbp)
    3277:	00 00 00 00 
    327b:	48 89 85 28 ff ff ff 	mov    %rax,-0xd8(%rbp)
    3282:	48 8d 95 20 ff ff ff 	lea    -0xe0(%rbp),%rdx
    3289:	bf 01 00 00 00       	mov    $0x1,%edi
    328e:	be 02 00 00 00       	mov    $0x2,%esi
    3293:	e8 88 6a 00 00       	call   9d20 <fwp_data>
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
    331e:	e8 2d 2f 00 00       	call   6250 <fwp_rc_forget_slot>
    3323:	48 89 d8             	mov    %rbx,%rax
    3326:	eb c3                	jmp    32eb <fwp_main_thread+0xd9b>
    3328:	48 c7 85 30 ff ff ff 	movq   $0xffffffffffffff80,-0xd0(%rbp)
    332f:	80 ff ff ff 
    3333:	48 89 85 38 ff ff ff 	mov    %rax,-0xc8(%rbp)
    333a:	48 8d 95 30 ff ff ff 	lea    -0xd0(%rbp),%rdx
    3341:	bf 01 00 00 00       	mov    $0x1,%edi
    3346:	be 02 00 00 00       	mov    $0x2,%esi
    334b:	e8 d0 69 00 00       	call   9d20 <fwp_data>
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
    33d2:	e8 79 2e 00 00       	call   6250 <fwp_rc_forget_slot>
    33d7:	eb c9                	jmp    33a2 <fwp_main_thread+0xe52>
    33d9:	48 8d 35 d0 e8 00 00 	lea    0xe8d0(%rip),%rsi        # 11cb0 <d1>
    33e0:	4c 89 ff             	mov    %r15,%rdi
    33e3:	e8 18 2f 00 00       	call   6300 <fwp_p_array_from_list_typed>
    33e8:	49 89 c6             	mov    %rax,%r14
    33eb:	4c 89 ff             	mov    %r15,%rdi
    33ee:	e8 fd a9 00 00       	call   ddf0 <fwp_drop4>
    33f3:	31 db                	xor    %ebx,%ebx
    33f5:	45 31 ff             	xor    %r15d,%r15d
    33f8:	45 31 e4             	xor    %r12d,%r12d
    33fb:	45 31 ed             	xor    %r13d,%r13d
    33fe:	31 ff                	xor    %edi,%edi
    3400:	eb 22                	jmp    3424 <fwp_main_thread+0xed4>
    3402:	66 66 66 66 66 2e 0f 	data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    3409:	1f 84 00 00 00 00 00 
    3410:	4c 89 f7             	mov    %r14,%rdi
    3413:	e8 28 98 00 00       	call   cc40 <fwp_drop9>
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
    347b:	e8 00 66 00 00       	call   9a80 <fwp_show_i64>
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
    3502:	e8 49 2d 00 00       	call   6250 <fwp_rc_forget_slot>
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
    35b3:	e8 88 72 00 00       	call   a840 <fwp_rc_free_obj>
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
    35f0:	e8 2b 67 00 00       	call   9d20 <fwp_data>
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
    367b:	e8 d0 2b 00 00       	call   6250 <fwp_rc_forget_slot>
    3680:	48 89 d8             	mov    %rbx,%rax
    3683:	eb c3                	jmp    3648 <fwp_main_thread+0x10f8>
    3685:	48 c7 85 50 ff ff ff 	movq   $0x2,-0xb0(%rbp)
    368c:	02 00 00 00 
    3690:	48 89 85 58 ff ff ff 	mov    %rax,-0xa8(%rbp)
    3697:	48 8d 95 50 ff ff ff 	lea    -0xb0(%rbp),%rdx
    369e:	bf 01 00 00 00       	mov    $0x1,%edi
    36a3:	be 02 00 00 00       	mov    $0x2,%esi
    36a8:	e8 73 66 00 00       	call   9d20 <fwp_data>
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
    3733:	e8 18 2b 00 00       	call   6250 <fwp_rc_forget_slot>
    3738:	48 89 d8             	mov    %rbx,%rax
    373b:	eb c3                	jmp    3700 <fwp_main_thread+0x11b0>
    373d:	48 c7 85 60 ff ff ff 	movq   $0x1,-0xa0(%rbp)
    3744:	01 00 00 00 
    3748:	48 89 85 68 ff ff ff 	mov    %rax,-0x98(%rbp)
    374f:	48 8d 95 60 ff ff ff 	lea    -0xa0(%rbp),%rdx
    3756:	bf 01 00 00 00       	mov    $0x1,%edi
    375b:	be 02 00 00 00       	mov    $0x2,%esi
    3760:	e8 bb 65 00 00       	call   9d20 <fwp_data>
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
    37e7:	e8 64 2a 00 00       	call   6250 <fwp_rc_forget_slot>
    37ec:	eb c9                	jmp    37b7 <fwp_main_thread+0x1267>
    37ee:	48 8d 35 bb e4 00 00 	lea    0xe4bb(%rip),%rsi        # 11cb0 <d1>
    37f5:	4c 89 ff             	mov    %r15,%rdi
    37f8:	e8 03 2b 00 00       	call   6300 <fwp_p_array_from_list_typed>
    37fd:	49 89 c6             	mov    %rax,%r14
    3800:	4c 89 ff             	mov    %r15,%rdi
    3803:	e8 e8 a5 00 00       	call   ddf0 <fwp_drop4>
    3808:	31 db                	xor    %ebx,%ebx
    380a:	45 31 ff             	xor    %r15d,%r15d
    380d:	45 31 e4             	xor    %r12d,%r12d
    3810:	45 31 ed             	xor    %r13d,%r13d
    3813:	31 ff                	xor    %edi,%edi
    3815:	eb 1d                	jmp    3834 <fwp_main_thread+0x12e4>
    3817:	66 0f 1f 84 00 00 00 	nopw   0x0(%rax,%rax,1)
    381e:	00 00 
    3820:	4c 89 f7             	mov    %r14,%rdi
    3823:	e8 18 94 00 00       	call   cc40 <fwp_drop9>
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
    3896:	e8 e5 61 00 00       	call   9a80 <fwp_show_i64>
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
    391d:	e8 2e 29 00 00       	call   6250 <fwp_rc_forget_slot>
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
    39ce:	e8 6d 6e 00 00       	call   a840 <fwp_rc_free_obj>
    39d3:	eb 0f                	jmp    39e4 <fwp_main_thread+0x1494>
    39d5:	3d ff 00 00 00       	cmp    $0xff,%eax
    39da:	0f 84 4e 06 00 00    	je     402e <fwp_main_thread+0x1ade>
    39e0:	fe c8                	dec    %al
    39e2:	88 07                	mov    %al,(%rdi)
    39e4:	48 8d 35 65 e2 00 00 	lea    0xe265(%rip),%rsi        # 11c50 <d0>
    39eb:	31 db                	xor    %ebx,%ebx
    39ed:	31 ff                	xor    %edi,%edi
    39ef:	e8 0c 2a 00 00       	call   6400 <fwp_array_typed_new>
    39f4:	49 89 c6             	mov    %rax,%r14
    39f7:	31 ff                	xor    %edi,%edi
    39f9:	e8 22 a3 00 00       	call   dd20 <fwp_drop0>
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
    3a63:	e8 08 69 00 00       	call   a370 <fwp_drop1>
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
    3ac4:	e8 c7 3b 00 00       	call   7690 <fwp_show>
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
    3b4b:	e8 00 27 00 00       	call   6250 <fwp_rc_forget_slot>
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
    3bfc:	e8 3f 6c 00 00       	call   a840 <fwp_rc_free_obj>
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
    3c2f:	e8 ec 60 00 00       	call   9d20 <fwp_data>
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
    3cba:	e8 91 25 00 00       	call   6250 <fwp_rc_forget_slot>
    3cbf:	48 89 d8             	mov    %rbx,%rax
    3cc2:	eb c3                	jmp    3c87 <fwp_main_thread+0x1737>
    3cc4:	48 c7 85 70 ff ff ff 	movq   $0x0,-0x90(%rbp)
    3ccb:	00 00 00 00 
    3ccf:	48 89 85 78 ff ff ff 	mov    %rax,-0x88(%rbp)
    3cd6:	48 8d 95 70 ff ff ff 	lea    -0x90(%rbp),%rdx
    3cdd:	bf 01 00 00 00       	mov    $0x1,%edi
    3ce2:	be 02 00 00 00       	mov    $0x2,%esi
    3ce7:	e8 34 60 00 00       	call   9d20 <fwp_data>
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
    3d72:	e8 d9 24 00 00       	call   6250 <fwp_rc_forget_slot>
    3d77:	48 89 d8             	mov    %rbx,%rax
    3d7a:	eb c3                	jmp    3d3f <fwp_main_thread+0x17ef>
    3d7c:	48 c7 45 80 00 00 00 	movq   $0x0,-0x80(%rbp)
    3d83:	00 
    3d84:	48 89 45 88          	mov    %rax,-0x78(%rbp)
    3d88:	48 8d 55 80          	lea    -0x80(%rbp),%rdx
    3d8c:	bf 01 00 00 00       	mov    $0x1,%edi
    3d91:	be 02 00 00 00       	mov    $0x2,%esi
    3d96:	e8 85 5f 00 00       	call   9d20 <fwp_data>
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
    3e21:	e8 2a 24 00 00       	call   6250 <fwp_rc_forget_slot>
    3e26:	48 89 d8             	mov    %rbx,%rax
    3e29:	eb c3                	jmp    3dee <fwp_main_thread+0x189e>
    3e2b:	48 c7 45 90 00 00 00 	movq   $0x0,-0x70(%rbp)
    3e32:	00 
    3e33:	48 89 45 98          	mov    %rax,-0x68(%rbp)
    3e37:	48 8d 55 90          	lea    -0x70(%rbp),%rdx
    3e3b:	bf 01 00 00 00       	mov    $0x1,%edi
    3e40:	be 02 00 00 00       	mov    $0x2,%esi
    3e45:	e8 d6 5e 00 00       	call   9d20 <fwp_data>
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
    3ed0:	e8 7b 23 00 00       	call   6250 <fwp_rc_forget_slot>
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
    3f60:	e8 db 68 00 00       	call   a840 <fwp_rc_free_obj>
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
    3fff:	e8 5c 65 00 00       	call   a560 <fwp_rc_wide_drop>
    4004:	e9 cb ef ff ff       	jmp    2fd4 <fwp_main_thread+0xa84>
    4009:	e8 52 65 00 00       	call   a560 <fwp_rc_wide_drop>
    400e:	eb 84                	jmp    3f94 <fwp_main_thread+0x1a44>
    4010:	e8 4b 65 00 00       	call   a560 <fwp_rc_wide_drop>
    4015:	e9 08 ec ff ff       	jmp    2c22 <fwp_main_thread+0x6d2>
    401a:	e8 41 65 00 00       	call   a560 <fwp_rc_wide_drop>
    401f:	e9 90 f1 ff ff       	jmp    31b4 <fwp_main_thread+0xc64>
    4024:	e8 37 65 00 00       	call   a560 <fwp_rc_wide_drop>
    4029:	e9 9b f5 ff ff       	jmp    35c9 <fwp_main_thread+0x1079>
    402e:	e8 2d 65 00 00       	call   a560 <fwp_rc_wide_drop>
    4033:	e9 ac f9 ff ff       	jmp    39e4 <fwp_main_thread+0x1494>
    4038:	e8 23 65 00 00       	call   a560 <fwp_rc_wide_drop>
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
    4076:	e8 a5 21 00 00       	call   6220 <fwp_flush>
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
    4158:	e8 a3 21 00 00       	call   6300 <fwp_p_array_from_list_typed>
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
    41d8:	e8 43 20 00 00       	call   6220 <fwp_flush>
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
    4298:	e8 63 20 00 00       	call   6300 <fwp_p_array_from_list_typed>
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
    4318:	e8 03 1f 00 00       	call   6220 <fwp_flush>
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
    43d8:	e8 23 1f 00 00       	call   6300 <fwp_p_array_from_list_typed>
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
    4458:	e8 c3 1d 00 00       	call   6220 <fwp_flush>
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
    451d:	e8 ce 2c 00 00       	call   71f0 <f12>
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
    459d:	e8 7e 1c 00 00       	call   6220 <fwp_flush>
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
    45de:	e8 ad 30 00 00       	call   7690 <fwp_show>
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
    4684:	e8 c7 1b 00 00       	call   6250 <fwp_rc_forget_slot>
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
    46fa:	e8 21 1b 00 00       	call   6220 <fwp_flush>
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
    4853:	e8 c8 19 00 00       	call   6220 <fwp_flush>
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
    491b:	e8 00 19 00 00       	call   6220 <fwp_flush>
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
    49db:	e8 40 18 00 00       	call   6220 <fwp_flush>
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
    4a17:	e8 64 50 00 00       	call   9a80 <fwp_show_i64>
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
    4abd:	e8 8e 17 00 00       	call   6250 <fwp_rc_forget_slot>
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
    4b33:	e8 e8 16 00 00       	call   6220 <fwp_flush>
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
    4c24:	e8 f7 15 00 00       	call   6220 <fwp_flush>
    4c29:	48 8b 05 b0 d3 00 00 	mov    0xd3b0(%rip),%rax        # 11fe0 <stderr@GLIBC_2.2.5>
    4c30:	48 8b 38             	mov    (%rax),%rdi
    4c33:	48 8d 35 f3 a7 00 00 	lea    0xa7f3(%rip),%rsi        # f42d <fwp_segv.msg+0x1ed>
    4c3a:	48 89 da             	mov    %rbx,%rdx
    4c3d:	eb 1d                	jmp    4c5c <e32+0xec>
    4c3f:	e8 dc 15 00 00       	call   6220 <fwp_flush>
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
    4c77:	e8 04 4e 00 00       	call   9a80 <fwp_show_i64>
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
    4d1d:	e8 2e 15 00 00       	call   6250 <fwp_rc_forget_slot>
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
    4d93:	e8 88 14 00 00       	call   6220 <fwp_flush>
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
    4dde:	e8 ad 28 00 00       	call   7690 <fwp_show>
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
    4e84:	e8 c7 13 00 00       	call   6250 <fwp_rc_forget_slot>
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
    4efa:	e8 21 13 00 00       	call   6220 <fwp_flush>
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
    4fb9:	e8 62 12 00 00       	call   6220 <fwp_flush>
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
    5079:	e8 a2 11 00 00       	call   6220 <fwp_flush>
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
    513d:	e8 8e 4a 00 00       	call   9bd0 <fwp_p_array_get_typed>
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
    51bd:	e8 5e 10 00 00       	call   6220 <fwp_flush>
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
    529d:	e8 7e 0f 00 00       	call   6220 <fwp_flush>
    52a2:	48 8b 05 37 cd 00 00 	mov    0xcd37(%rip),%rax        # 11fe0 <stderr@GLIBC_2.2.5>
    52a9:	48 8b 38             	mov    (%rax),%rdi
    52ac:	48 8d 35 7a a1 00 00 	lea    0xa17a(%rip),%rsi        # f42d <fwp_segv.msg+0x1ed>
    52b3:	48 89 da             	mov    %rbx,%rdx
    52b6:	eb 1d                	jmp    52d5 <e48+0xe5>
    52b8:	e8 63 0f 00 00       	call   6220 <fwp_flush>
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
    5371:	e8 ca 4b 00 00       	call   9f40 <f49>
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
    53f1:	e8 2a 0e 00 00       	call   6220 <fwp_flush>
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
    547d:	e9 1d 01 00 00       	jmp    559f <e50+0x17f>
    5482:	41 80 fa 01          	cmp    $0x1,%r10b
    5486:	75 24                	jne    54ac <e50+0x8c>
    5488:	4f 8d 14 08          	lea    (%r8,%r9,1),%r10
    548c:	47 8b 44 08 20       	mov    0x20(%r8,%r9,1),%r8d
    5491:	49 0f af f0          	imul   %r8,%rsi
    5495:	48 c1 ee 20          	shr    $0x20,%rsi
    5499:	4c 01 d6             	add    %r10,%rsi
    549c:	48 81 c6 28 02 00 00 	add    $0x228,%rsi
    54a3:	80 3e 00             	cmpb   $0x0,(%rsi)
    54a6:	0f 85 f3 00 00 00    	jne    559f <e50+0x17f>
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
    54f2:	e9 a8 00 00 00       	jmp    559f <e50+0x17f>
    54f7:	41 80 f8 01          	cmp    $0x1,%r8b
    54fb:	75 22                	jne    551f <e50+0xff>
    54fd:	4c 8d 04 11          	lea    (%rcx,%rdx,1),%r8
    5501:	8b 4c 11 20          	mov    0x20(%rcx,%rdx,1),%ecx
    5505:	48 0f af c1          	imul   %rcx,%rax
    5509:	48 c1 e8 20          	shr    $0x20,%rax
    550d:	4c 01 c0             	add    %r8,%rax
    5510:	48 05 28 02 00 00    	add    $0x228,%rax
    5516:	80 38 00             	cmpb   $0x0,(%rax)
    5519:	0f 85 80 00 00 00    	jne    559f <e50+0x17f>
    551f:	e8 7c 56 00 00       	call   aba0 <fwp_p_loop_own>
    5524:	48 89 c1             	mov    %rax,%rcx
    5527:	48 2b 0d 82 dc 00 00 	sub    0xdc82(%rip),%rcx        # 131b0 <fwp_gc+0x1030>
    552e:	48 8b 15 a3 dc 00 00 	mov    0xdca3(%rip),%rdx        # 131d8 <fwp_gc+0x1058>
    5535:	48 c1 e2 10          	shl    $0x10,%rdx
    5539:	48 39 d1             	cmp    %rdx,%rcx
    553c:	73 5f                	jae    559d <e50+0x17d>
    553e:	48 8b 15 b3 dc 00 00 	mov    0xdcb3(%rip),%rdx        # 131f8 <fwp_gc+0x1078>
    5545:	48 89 ce             	mov    %rcx,%rsi
    5548:	48 c1 ee 10          	shr    $0x10,%rsi
    554c:	48 69 f6 28 12 00 00 	imul   $0x1228,%rsi,%rsi
    5553:	0f b6 3c 32          	movzbl (%rdx,%rsi,1),%edi
    5557:	48 81 e1 ff ff 00 00 	and    $0xffff,%rcx
    555e:	75 18                	jne    5578 <e50+0x158>
    5560:	40 80 ff 02          	cmp    $0x2,%dil
    5564:	75 12                	jne    5578 <e50+0x158>
    5566:	48 8d 0c 32          	lea    (%rdx,%rsi,1),%rcx
    556a:	48 81 c1 28 02 00 00 	add    $0x228,%rcx
    5571:	80 39 00             	cmpb   $0x0,(%rcx)
    5574:	74 27                	je     559d <e50+0x17d>
    5576:	eb 27                	jmp    559f <e50+0x17f>
    5578:	40 80 ff 01          	cmp    $0x1,%dil
    557c:	75 1f                	jne    559d <e50+0x17d>
    557e:	48 8d 3c 32          	lea    (%rdx,%rsi,1),%rdi
    5582:	8b 54 32 20          	mov    0x20(%rdx,%rsi,1),%edx
    5586:	48 0f af ca          	imul   %rdx,%rcx
    558a:	48 c1 e9 20          	shr    $0x20,%rcx
    558e:	48 01 f9             	add    %rdi,%rcx
    5591:	48 81 c1 28 02 00 00 	add    $0x228,%rcx
    5598:	80 39 00             	cmpb   $0x0,(%rcx)
    559b:	75 02                	jne    559f <e50+0x17f>
    559d:	59                   	pop    %rcx
    559e:	c3                   	ret
    559f:	e8 7c 0c 00 00       	call   6220 <fwp_flush>
    55a4:	48 8b 05 35 ca 00 00 	mov    0xca35(%rip),%rax        # 11fe0 <stderr@GLIBC_2.2.5>
    55ab:	48 8b 38             	mov    (%rax),%rdi
    55ae:	48 8d 35 78 9e 00 00 	lea    0x9e78(%rip),%rsi        # f42d <fwp_segv.msg+0x1ed>
    55b5:	48 8d 15 44 9e 00 00 	lea    0x9e44(%rip),%rdx        # f400 <fwp_segv.msg+0x1c0>
    55bc:	31 c0                	xor    %eax,%eax
    55be:	e8 ed cb ff ff       	call   21b0 <fprintf@plt>
    55c3:	bf 65 00 00 00       	mov    $0x65,%edi
    55c8:	e8 c3 cc ff ff       	call   2290 <exit@plt>
    55cd:	0f 1f 00             	nopl   (%rax)

00000000000055d0 <e51>:
    55d0:	50                   	push   %rax
    55d1:	48 8b 77 08          	mov    0x8(%rdi),%rsi
    55d5:	48 89 f0             	mov    %rsi,%rax
    55d8:	48 2b 05 d1 db 00 00 	sub    0xdbd1(%rip),%rax        # 131b0 <fwp_gc+0x1030>
    55df:	48 8b 0d f2 db 00 00 	mov    0xdbf2(%rip),%rcx        # 131d8 <fwp_gc+0x1058>
    55e6:	48 c1 e1 10          	shl    $0x10,%rcx
    55ea:	48 39 c8             	cmp    %rcx,%rax
    55ed:	73 64                	jae    5653 <e51+0x83>
    55ef:	48 8b 0d 02 dc 00 00 	mov    0xdc02(%rip),%rcx        # 131f8 <fwp_gc+0x1078>
    55f6:	48 89 c2             	mov    %rax,%rdx
    55f9:	48 c1 ea 10          	shr    $0x10,%rdx
    55fd:	48 69 d2 28 12 00 00 	imul   $0x1228,%rdx,%rdx
    5604:	44 0f b6 04 11       	movzbl (%rcx,%rdx,1),%r8d
    5609:	48 25 ff ff 00 00    	and    $0xffff,%rax
    560f:	75 1a                	jne    562b <e51+0x5b>
    5611:	41 80 f8 02          	cmp    $0x2,%r8b
    5615:	75 14                	jne    562b <e51+0x5b>
    5617:	48 8d 04 11          	lea    (%rcx,%rdx,1),%rax
    561b:	48 05 28 02 00 00    	add    $0x228,%rax
    5621:	80 38 00             	cmpb   $0x0,(%rax)
    5624:	74 2d                	je     5653 <e51+0x83>
    5626:	e9 b2 00 00 00       	jmp    56dd <e51+0x10d>
    562b:	41 80 f8 01          	cmp    $0x1,%r8b
    562f:	75 22                	jne    5653 <e51+0x83>
    5631:	4c 8d 04 11          	lea    (%rcx,%rdx,1),%r8
    5635:	8b 4c 11 20          	mov    0x20(%rcx,%rdx,1),%ecx
    5639:	48 0f af c1          	imul   %rcx,%rax
    563d:	48 c1 e8 20          	shr    $0x20,%rax
    5641:	4c 01 c0             	add    %r8,%rax
    5644:	48 05 28 02 00 00    	add    $0x228,%rax
    564a:	80 38 00             	cmpb   $0x0,(%rax)
    564d:	0f 85 8a 00 00 00    	jne    56dd <e51+0x10d>
    5653:	48 8b 3f             	mov    (%rdi),%rdi
    5656:	48 8d 15 b3 c6 00 00 	lea    0xc6b3(%rip),%rdx        # 11d10 <d2>
    565d:	e8 6e 45 00 00       	call   9bd0 <fwp_p_array_get_typed>
    5662:	48 89 c1             	mov    %rax,%rcx
    5665:	48 2b 0d 44 db 00 00 	sub    0xdb44(%rip),%rcx        # 131b0 <fwp_gc+0x1030>
    566c:	48 8b 15 65 db 00 00 	mov    0xdb65(%rip),%rdx        # 131d8 <fwp_gc+0x1058>
    5673:	48 c1 e2 10          	shl    $0x10,%rdx
    5677:	48 39 d1             	cmp    %rdx,%rcx
    567a:	73 5f                	jae    56db <e51+0x10b>
    567c:	48 8b 15 75 db 00 00 	mov    0xdb75(%rip),%rdx        # 131f8 <fwp_gc+0x1078>
    5683:	48 89 ce             	mov    %rcx,%rsi
    5686:	48 c1 ee 10          	shr    $0x10,%rsi
    568a:	48 69 f6 28 12 00 00 	imul   $0x1228,%rsi,%rsi
    5691:	0f b6 3c 32          	movzbl (%rdx,%rsi,1),%edi
    5695:	48 81 e1 ff ff 00 00 	and    $0xffff,%rcx
    569c:	75 18                	jne    56b6 <e51+0xe6>
    569e:	40 80 ff 02          	cmp    $0x2,%dil
    56a2:	75 12                	jne    56b6 <e51+0xe6>
    56a4:	48 8d 0c 32          	lea    (%rdx,%rsi,1),%rcx
    56a8:	48 81 c1 28 02 00 00 	add    $0x228,%rcx
    56af:	80 39 00             	cmpb   $0x0,(%rcx)
    56b2:	74 27                	je     56db <e51+0x10b>
    56b4:	eb 27                	jmp    56dd <e51+0x10d>
    56b6:	40 80 ff 01          	cmp    $0x1,%dil
    56ba:	75 1f                	jne    56db <e51+0x10b>
    56bc:	48 8d 3c 32          	lea    (%rdx,%rsi,1),%rdi
    56c0:	8b 54 32 20          	mov    0x20(%rdx,%rsi,1),%edx
    56c4:	48 0f af ca          	imul   %rdx,%rcx
    56c8:	48 c1 e9 20          	shr    $0x20,%rcx
    56cc:	48 01 f9             	add    %rdi,%rcx
    56cf:	48 81 c1 28 02 00 00 	add    $0x228,%rcx
    56d6:	80 39 00             	cmpb   $0x0,(%rcx)
    56d9:	75 02                	jne    56dd <e51+0x10d>
    56db:	59                   	pop    %rcx
    56dc:	c3                   	ret
    56dd:	e8 3e 0b 00 00       	call   6220 <fwp_flush>
    56e2:	48 8b 05 f7 c8 00 00 	mov    0xc8f7(%rip),%rax        # 11fe0 <stderr@GLIBC_2.2.5>
    56e9:	48 8b 38             	mov    (%rax),%rdi
    56ec:	48 8d 35 3a 9d 00 00 	lea    0x9d3a(%rip),%rsi        # f42d <fwp_segv.msg+0x1ed>
    56f3:	48 8d 15 06 9d 00 00 	lea    0x9d06(%rip),%rdx        # f400 <fwp_segv.msg+0x1c0>
    56fa:	31 c0                	xor    %eax,%eax
    56fc:	e8 af ca ff ff       	call   21b0 <fprintf@plt>
    5701:	bf 65 00 00 00       	mov    $0x65,%edi
    5706:	e8 85 cb ff ff       	call   2290 <exit@plt>
    570b:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)

0000000000005710 <e52>:
    5710:	50                   	push   %rax
    5711:	48 8b 3f             	mov    (%rdi),%rdi
    5714:	48 89 f8             	mov    %rdi,%rax
    5717:	48 2b 05 92 da 00 00 	sub    0xda92(%rip),%rax        # 131b0 <fwp_gc+0x1030>
    571e:	48 8b 0d b3 da 00 00 	mov    0xdab3(%rip),%rcx        # 131d8 <fwp_gc+0x1058>
    5725:	48 c1 e1 10          	shl    $0x10,%rcx
    5729:	48 39 c8             	cmp    %rcx,%rax
    572c:	73 63                	jae    5791 <e52+0x81>
    572e:	48 8b 0d c3 da 00 00 	mov    0xdac3(%rip),%rcx        # 131f8 <fwp_gc+0x1078>
    5735:	48 89 c2             	mov    %rax,%rdx
    5738:	48 c1 ea 10          	shr    $0x10,%rdx
    573c:	48 69 d2 28 12 00 00 	imul   $0x1228,%rdx,%rdx
    5743:	0f b6 34 11          	movzbl (%rcx,%rdx,1),%esi
    5747:	48 25 ff ff 00 00    	and    $0xffff,%rax
    574d:	75 1a                	jne    5769 <e52+0x59>
    574f:	40 80 fe 02          	cmp    $0x2,%sil
    5753:	75 14                	jne    5769 <e52+0x59>
    5755:	48 8d 04 11          	lea    (%rcx,%rdx,1),%rax
    5759:	48 05 28 02 00 00    	add    $0x228,%rax
    575f:	80 38 00             	cmpb   $0x0,(%rax)
    5762:	74 2d                	je     5791 <e52+0x81>
    5764:	e9 a8 00 00 00       	jmp    5811 <e52+0x101>
    5769:	40 80 fe 01          	cmp    $0x1,%sil
    576d:	75 22                	jne    5791 <e52+0x81>
    576f:	48 8d 34 11          	lea    (%rcx,%rdx,1),%rsi
    5773:	8b 4c 11 20          	mov    0x20(%rcx,%rdx,1),%ecx
    5777:	48 0f af c1          	imul   %rcx,%rax
    577b:	48 c1 e8 20          	shr    $0x20,%rax
    577f:	48 01 f0             	add    %rsi,%rax
    5782:	48 05 28 02 00 00    	add    $0x228,%rax
    5788:	80 38 00             	cmpb   $0x0,(%rax)
    578b:	0f 85 80 00 00 00    	jne    5811 <e52+0x101>
    5791:	e8 aa 69 00 00       	call   c140 <f52>
    5796:	48 89 c1             	mov    %rax,%rcx
    5799:	48 2b 0d 10 da 00 00 	sub    0xda10(%rip),%rcx        # 131b0 <fwp_gc+0x1030>
    57a0:	48 8b 15 31 da 00 00 	mov    0xda31(%rip),%rdx        # 131d8 <fwp_gc+0x1058>
    57a7:	48 c1 e2 10          	shl    $0x10,%rdx
    57ab:	48 39 d1             	cmp    %rdx,%rcx
    57ae:	73 5f                	jae    580f <e52+0xff>
    57b0:	48 8b 15 41 da 00 00 	mov    0xda41(%rip),%rdx        # 131f8 <fwp_gc+0x1078>
    57b7:	48 89 ce             	mov    %rcx,%rsi
    57ba:	48 c1 ee 10          	shr    $0x10,%rsi
    57be:	48 69 f6 28 12 00 00 	imul   $0x1228,%rsi,%rsi
    57c5:	0f b6 3c 32          	movzbl (%rdx,%rsi,1),%edi
    57c9:	48 81 e1 ff ff 00 00 	and    $0xffff,%rcx
    57d0:	75 18                	jne    57ea <e52+0xda>
    57d2:	40 80 ff 02          	cmp    $0x2,%dil
    57d6:	75 12                	jne    57ea <e52+0xda>
    57d8:	48 8d 0c 32          	lea    (%rdx,%rsi,1),%rcx
    57dc:	48 81 c1 28 02 00 00 	add    $0x228,%rcx
    57e3:	80 39 00             	cmpb   $0x0,(%rcx)
    57e6:	74 27                	je     580f <e52+0xff>
    57e8:	eb 27                	jmp    5811 <e52+0x101>
    57ea:	40 80 ff 01          	cmp    $0x1,%dil
    57ee:	75 1f                	jne    580f <e52+0xff>
    57f0:	48 8d 3c 32          	lea    (%rdx,%rsi,1),%rdi
    57f4:	8b 54 32 20          	mov    0x20(%rdx,%rsi,1),%edx
    57f8:	48 0f af ca          	imul   %rdx,%rcx
    57fc:	48 c1 e9 20          	shr    $0x20,%rcx
    5800:	48 01 f9             	add    %rdi,%rcx
    5803:	48 81 c1 28 02 00 00 	add    $0x228,%rcx
    580a:	80 39 00             	cmpb   $0x0,(%rcx)
    580d:	75 02                	jne    5811 <e52+0x101>
    580f:	59                   	pop    %rcx
    5810:	c3                   	ret
    5811:	e8 0a 0a 00 00       	call   6220 <fwp_flush>
    5816:	48 8b 05 c3 c7 00 00 	mov    0xc7c3(%rip),%rax        # 11fe0 <stderr@GLIBC_2.2.5>
    581d:	48 8b 38             	mov    (%rax),%rdi
    5820:	48 8d 35 06 9c 00 00 	lea    0x9c06(%rip),%rsi        # f42d <fwp_segv.msg+0x1ed>
    5827:	48 8d 15 d2 9b 00 00 	lea    0x9bd2(%rip),%rdx        # f400 <fwp_segv.msg+0x1c0>
    582e:	31 c0                	xor    %eax,%eax
    5830:	e8 7b c9 ff ff       	call   21b0 <fprintf@plt>
    5835:	bf 65 00 00 00       	mov    $0x65,%edi
    583a:	e8 51 ca ff ff       	call   2290 <exit@plt>
    583f:	90                   	nop

0000000000005840 <e53>:
    5840:	50                   	push   %rax
    5841:	48 89 f8             	mov    %rdi,%rax
    5844:	48 8b 3f             	mov    (%rdi),%rdi
    5847:	48 8b 0d 62 d9 00 00 	mov    0xd962(%rip),%rcx        # 131b0 <fwp_gc+0x1030>
    584e:	48 89 fe             	mov    %rdi,%rsi
    5851:	48 29 ce             	sub    %rcx,%rsi
    5854:	48 8b 15 7d d9 00 00 	mov    0xd97d(%rip),%rdx        # 131d8 <fwp_gc+0x1058>
    585b:	48 c1 e2 10          	shl    $0x10,%rdx
    585f:	48 39 d6             	cmp    %rdx,%rsi
    5862:	73 68                	jae    58cc <e53+0x8c>
    5864:	4c 8b 05 8d d9 00 00 	mov    0xd98d(%rip),%r8        # 131f8 <fwp_gc+0x1078>
    586b:	49 89 f1             	mov    %rsi,%r9
    586e:	49 c1 e9 10          	shr    $0x10,%r9
    5872:	4d 69 c9 28 12 00 00 	imul   $0x1228,%r9,%r9
    5879:	47 0f b6 14 08       	movzbl (%r8,%r9,1),%r10d
    587e:	48 81 e6 ff ff 00 00 	and    $0xffff,%rsi
    5885:	75 1b                	jne    58a2 <e53+0x62>
    5887:	41 80 fa 02          	cmp    $0x2,%r10b
    588b:	75 15                	jne    58a2 <e53+0x62>
    588d:	4b 8d 34 08          	lea    (%r8,%r9,1),%rsi
    5891:	48 81 c6 28 02 00 00 	add    $0x228,%rsi
    5898:	80 3e 00             	cmpb   $0x0,(%rsi)
    589b:	74 2f                	je     58cc <e53+0x8c>
    589d:	e9 1d 01 00 00       	jmp    59bf <e53+0x17f>
    58a2:	41 80 fa 01          	cmp    $0x1,%r10b
    58a6:	75 24                	jne    58cc <e53+0x8c>
    58a8:	4f 8d 14 08          	lea    (%r8,%r9,1),%r10
    58ac:	47 8b 44 08 20       	mov    0x20(%r8,%r9,1),%r8d
    58b1:	49 0f af f0          	imul   %r8,%rsi
    58b5:	48 c1 ee 20          	shr    $0x20,%rsi
    58b9:	4c 01 d6             	add    %r10,%rsi
    58bc:	48 81 c6 28 02 00 00 	add    $0x228,%rsi
    58c3:	80 3e 00             	cmpb   $0x0,(%rsi)
    58c6:	0f 85 f3 00 00 00    	jne    59bf <e53+0x17f>
    58cc:	48 8b 70 08          	mov    0x8(%rax),%rsi
    58d0:	48 89 f0             	mov    %rsi,%rax
    58d3:	48 29 c8             	sub    %rcx,%rax
    58d6:	48 39 d0             	cmp    %rdx,%rax
    58d9:	73 64                	jae    593f <e53+0xff>
    58db:	48 8b 0d 16 d9 00 00 	mov    0xd916(%rip),%rcx        # 131f8 <fwp_gc+0x1078>
    58e2:	48 89 c2             	mov    %rax,%rdx
    58e5:	48 c1 ea 10          	shr    $0x10,%rdx
    58e9:	48 69 d2 28 12 00 00 	imul   $0x1228,%rdx,%rdx
    58f0:	44 0f b6 04 11       	movzbl (%rcx,%rdx,1),%r8d
    58f5:	48 25 ff ff 00 00    	and    $0xffff,%rax
    58fb:	75 1a                	jne    5917 <e53+0xd7>
    58fd:	41 80 f8 02          	cmp    $0x2,%r8b
    5901:	75 14                	jne    5917 <e53+0xd7>
    5903:	48 8d 04 11          	lea    (%rcx,%rdx,1),%rax
    5907:	48 05 28 02 00 00    	add    $0x228,%rax
    590d:	80 38 00             	cmpb   $0x0,(%rax)
    5910:	74 2d                	je     593f <e53+0xff>
    5912:	e9 a8 00 00 00       	jmp    59bf <e53+0x17f>
    5917:	41 80 f8 01          	cmp    $0x1,%r8b
    591b:	75 22                	jne    593f <e53+0xff>
    591d:	4c 8d 04 11          	lea    (%rcx,%rdx,1),%r8
    5921:	8b 4c 11 20          	mov    0x20(%rcx,%rdx,1),%ecx
    5925:	48 0f af c1          	imul   %rcx,%rax
    5929:	48 c1 e8 20          	shr    $0x20,%rax
    592d:	4c 01 c0             	add    %r8,%rax
    5930:	48 05 28 02 00 00    	add    $0x228,%rax
    5936:	80 38 00             	cmpb   $0x0,(%rax)
    5939:	0f 85 80 00 00 00    	jne    59bf <e53+0x17f>
    593f:	e8 5c 52 00 00       	call   aba0 <fwp_p_loop_own>
    5944:	48 89 c1             	mov    %rax,%rcx
    5947:	48 2b 0d 62 d8 00 00 	sub    0xd862(%rip),%rcx        # 131b0 <fwp_gc+0x1030>
    594e:	48 8b 15 83 d8 00 00 	mov    0xd883(%rip),%rdx        # 131d8 <fwp_gc+0x1058>
    5955:	48 c1 e2 10          	shl    $0x10,%rdx
    5959:	48 39 d1             	cmp    %rdx,%rcx
    595c:	73 5f                	jae    59bd <e53+0x17d>
    595e:	48 8b 15 93 d8 00 00 	mov    0xd893(%rip),%rdx        # 131f8 <fwp_gc+0x1078>
    5965:	48 89 ce             	mov    %rcx,%rsi
    5968:	48 c1 ee 10          	shr    $0x10,%rsi
    596c:	48 69 f6 28 12 00 00 	imul   $0x1228,%rsi,%rsi
    5973:	0f b6 3c 32          	movzbl (%rdx,%rsi,1),%edi
    5977:	48 81 e1 ff ff 00 00 	and    $0xffff,%rcx
    597e:	75 18                	jne    5998 <e53+0x158>
    5980:	40 80 ff 02          	cmp    $0x2,%dil
    5984:	75 12                	jne    5998 <e53+0x158>
    5986:	48 8d 0c 32          	lea    (%rdx,%rsi,1),%rcx
    598a:	48 81 c1 28 02 00 00 	add    $0x228,%rcx
    5991:	80 39 00             	cmpb   $0x0,(%rcx)
    5994:	74 27                	je     59bd <e53+0x17d>
    5996:	eb 27                	jmp    59bf <e53+0x17f>
    5998:	40 80 ff 01          	cmp    $0x1,%dil
    599c:	75 1f                	jne    59bd <e53+0x17d>
    599e:	48 8d 3c 32          	lea    (%rdx,%rsi,1),%rdi
    59a2:	8b 54 32 20          	mov    0x20(%rdx,%rsi,1),%edx
    59a6:	48 0f af ca          	imul   %rdx,%rcx
    59aa:	48 c1 e9 20          	shr    $0x20,%rcx
    59ae:	48 01 f9             	add    %rdi,%rcx
    59b1:	48 81 c1 28 02 00 00 	add    $0x228,%rcx
    59b8:	80 39 00             	cmpb   $0x0,(%rcx)
    59bb:	75 02                	jne    59bf <e53+0x17f>
    59bd:	59                   	pop    %rcx
    59be:	c3                   	ret
    59bf:	e8 5c 08 00 00       	call   6220 <fwp_flush>
    59c4:	48 8b 05 15 c6 00 00 	mov    0xc615(%rip),%rax        # 11fe0 <stderr@GLIBC_2.2.5>
    59cb:	48 8b 38             	mov    (%rax),%rdi
    59ce:	48 8d 35 58 9a 00 00 	lea    0x9a58(%rip),%rsi        # f42d <fwp_segv.msg+0x1ed>
    59d5:	48 8d 15 24 9a 00 00 	lea    0x9a24(%rip),%rdx        # f400 <fwp_segv.msg+0x1c0>
    59dc:	31 c0                	xor    %eax,%eax
    59de:	e8 cd c7 ff ff       	call   21b0 <fprintf@plt>
    59e3:	bf 65 00 00 00       	mov    $0x65,%edi
    59e8:	e8 a3 c8 ff ff       	call   2290 <exit@plt>
    59ed:	0f 1f 00             	nopl   (%rax)

00000000000059f0 <e54>:
    59f0:	50                   	push   %rax
    59f1:	48 8b 77 08          	mov    0x8(%rdi),%rsi
    59f5:	48 89 f0             	mov    %rsi,%rax
    59f8:	48 2b 05 b1 d7 00 00 	sub    0xd7b1(%rip),%rax        # 131b0 <fwp_gc+0x1030>
    59ff:	48 8b 0d d2 d7 00 00 	mov    0xd7d2(%rip),%rcx        # 131d8 <fwp_gc+0x1058>
    5a06:	48 c1 e1 10          	shl    $0x10,%rcx
    5a0a:	48 39 c8             	cmp    %rcx,%rax
    5a0d:	73 64                	jae    5a73 <e54+0x83>
    5a0f:	48 8b 0d e2 d7 00 00 	mov    0xd7e2(%rip),%rcx        # 131f8 <fwp_gc+0x1078>
    5a16:	48 89 c2             	mov    %rax,%rdx
    5a19:	48 c1 ea 10          	shr    $0x10,%rdx
    5a1d:	48 69 d2 28 12 00 00 	imul   $0x1228,%rdx,%rdx
    5a24:	44 0f b6 04 11       	movzbl (%rcx,%rdx,1),%r8d
    5a29:	48 25 ff ff 00 00    	and    $0xffff,%rax
    5a2f:	75 1a                	jne    5a4b <e54+0x5b>
    5a31:	41 80 f8 02          	cmp    $0x2,%r8b
    5a35:	75 14                	jne    5a4b <e54+0x5b>
    5a37:	48 8d 04 11          	lea    (%rcx,%rdx,1),%rax
    5a3b:	48 05 28 02 00 00    	add    $0x228,%rax
    5a41:	80 38 00             	cmpb   $0x0,(%rax)
    5a44:	74 2d                	je     5a73 <e54+0x83>
    5a46:	e9 b2 00 00 00       	jmp    5afd <e54+0x10d>
    5a4b:	41 80 f8 01          	cmp    $0x1,%r8b
    5a4f:	75 22                	jne    5a73 <e54+0x83>
    5a51:	4c 8d 04 11          	lea    (%rcx,%rdx,1),%r8
    5a55:	8b 4c 11 20          	mov    0x20(%rcx,%rdx,1),%ecx
    5a59:	48 0f af c1          	imul   %rcx,%rax
    5a5d:	48 c1 e8 20          	shr    $0x20,%rax
    5a61:	4c 01 c0             	add    %r8,%rax
    5a64:	48 05 28 02 00 00    	add    $0x228,%rax
    5a6a:	80 38 00             	cmpb   $0x0,(%rax)
    5a6d:	0f 85 8a 00 00 00    	jne    5afd <e54+0x10d>
    5a73:	48 8b 3f             	mov    (%rdi),%rdi
    5a76:	48 8d 15 33 c2 00 00 	lea    0xc233(%rip),%rdx        # 11cb0 <d1>
    5a7d:	e8 4e 41 00 00       	call   9bd0 <fwp_p_array_get_typed>
    5a82:	48 89 c1             	mov    %rax,%rcx
    5a85:	48 2b 0d 24 d7 00 00 	sub    0xd724(%rip),%rcx        # 131b0 <fwp_gc+0x1030>
    5a8c:	48 8b 15 45 d7 00 00 	mov    0xd745(%rip),%rdx        # 131d8 <fwp_gc+0x1058>
    5a93:	48 c1 e2 10          	shl    $0x10,%rdx
    5a97:	48 39 d1             	cmp    %rdx,%rcx
    5a9a:	73 5f                	jae    5afb <e54+0x10b>
    5a9c:	48 8b 15 55 d7 00 00 	mov    0xd755(%rip),%rdx        # 131f8 <fwp_gc+0x1078>
    5aa3:	48 89 ce             	mov    %rcx,%rsi
    5aa6:	48 c1 ee 10          	shr    $0x10,%rsi
    5aaa:	48 69 f6 28 12 00 00 	imul   $0x1228,%rsi,%rsi
    5ab1:	0f b6 3c 32          	movzbl (%rdx,%rsi,1),%edi
    5ab5:	48 81 e1 ff ff 00 00 	and    $0xffff,%rcx
    5abc:	75 18                	jne    5ad6 <e54+0xe6>
    5abe:	40 80 ff 02          	cmp    $0x2,%dil
    5ac2:	75 12                	jne    5ad6 <e54+0xe6>
    5ac4:	48 8d 0c 32          	lea    (%rdx,%rsi,1),%rcx
    5ac8:	48 81 c1 28 02 00 00 	add    $0x228,%rcx
    5acf:	80 39 00             	cmpb   $0x0,(%rcx)
    5ad2:	74 27                	je     5afb <e54+0x10b>
    5ad4:	eb 27                	jmp    5afd <e54+0x10d>
    5ad6:	40 80 ff 01          	cmp    $0x1,%dil
    5ada:	75 1f                	jne    5afb <e54+0x10b>
    5adc:	48 8d 3c 32          	lea    (%rdx,%rsi,1),%rdi
    5ae0:	8b 54 32 20          	mov    0x20(%rdx,%rsi,1),%edx
    5ae4:	48 0f af ca          	imul   %rdx,%rcx
    5ae8:	48 c1 e9 20          	shr    $0x20,%rcx
    5aec:	48 01 f9             	add    %rdi,%rcx
    5aef:	48 81 c1 28 02 00 00 	add    $0x228,%rcx
    5af6:	80 39 00             	cmpb   $0x0,(%rcx)
    5af9:	75 02                	jne    5afd <e54+0x10d>
    5afb:	59                   	pop    %rcx
    5afc:	c3                   	ret
    5afd:	e8 1e 07 00 00       	call   6220 <fwp_flush>
    5b02:	48 8b 05 d7 c4 00 00 	mov    0xc4d7(%rip),%rax        # 11fe0 <stderr@GLIBC_2.2.5>
    5b09:	48 8b 38             	mov    (%rax),%rdi
    5b0c:	48 8d 35 1a 99 00 00 	lea    0x991a(%rip),%rsi        # f42d <fwp_segv.msg+0x1ed>
    5b13:	48 8d 15 e6 98 00 00 	lea    0x98e6(%rip),%rdx        # f400 <fwp_segv.msg+0x1c0>
    5b1a:	31 c0                	xor    %eax,%eax
    5b1c:	e8 8f c6 ff ff       	call   21b0 <fprintf@plt>
    5b21:	bf 65 00 00 00       	mov    $0x65,%edi
    5b26:	e8 65 c7 ff ff       	call   2290 <exit@plt>
    5b2b:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)

0000000000005b30 <e55>:
    5b30:	50                   	push   %rax
    5b31:	48 8b 3f             	mov    (%rdi),%rdi
    5b34:	48 89 f8             	mov    %rdi,%rax
    5b37:	48 2b 05 72 d6 00 00 	sub    0xd672(%rip),%rax        # 131b0 <fwp_gc+0x1030>
    5b3e:	48 8b 0d 93 d6 00 00 	mov    0xd693(%rip),%rcx        # 131d8 <fwp_gc+0x1058>
    5b45:	48 c1 e1 10          	shl    $0x10,%rcx
    5b49:	48 39 c8             	cmp    %rcx,%rax
    5b4c:	73 63                	jae    5bb1 <e55+0x81>
    5b4e:	48 8b 0d a3 d6 00 00 	mov    0xd6a3(%rip),%rcx        # 131f8 <fwp_gc+0x1078>
    5b55:	48 89 c2             	mov    %rax,%rdx
    5b58:	48 c1 ea 10          	shr    $0x10,%rdx
    5b5c:	48 69 d2 28 12 00 00 	imul   $0x1228,%rdx,%rdx
    5b63:	0f b6 34 11          	movzbl (%rcx,%rdx,1),%esi
    5b67:	48 25 ff ff 00 00    	and    $0xffff,%rax
    5b6d:	75 1a                	jne    5b89 <e55+0x59>
    5b6f:	40 80 fe 02          	cmp    $0x2,%sil
    5b73:	75 14                	jne    5b89 <e55+0x59>
    5b75:	48 8d 04 11          	lea    (%rcx,%rdx,1),%rax
    5b79:	48 05 28 02 00 00    	add    $0x228,%rax
    5b7f:	80 38 00             	cmpb   $0x0,(%rax)
    5b82:	74 2d                	je     5bb1 <e55+0x81>
    5b84:	e9 a8 00 00 00       	jmp    5c31 <e55+0x101>
    5b89:	40 80 fe 01          	cmp    $0x1,%sil
    5b8d:	75 22                	jne    5bb1 <e55+0x81>
    5b8f:	48 8d 34 11          	lea    (%rcx,%rdx,1),%rsi
    5b93:	8b 4c 11 20          	mov    0x20(%rcx,%rdx,1),%ecx
    5b97:	48 0f af c1          	imul   %rcx,%rax
    5b9b:	48 c1 e8 20          	shr    $0x20,%rax
    5b9f:	48 01 f0             	add    %rsi,%rax
    5ba2:	48 05 28 02 00 00    	add    $0x228,%rax
    5ba8:	80 38 00             	cmpb   $0x0,(%rax)
    5bab:	0f 85 80 00 00 00    	jne    5c31 <e55+0x101>
    5bb1:	e8 1a 6c 00 00       	call   c7d0 <f55>
    5bb6:	48 89 c1             	mov    %rax,%rcx
    5bb9:	48 2b 0d f0 d5 00 00 	sub    0xd5f0(%rip),%rcx        # 131b0 <fwp_gc+0x1030>
    5bc0:	48 8b 15 11 d6 00 00 	mov    0xd611(%rip),%rdx        # 131d8 <fwp_gc+0x1058>
    5bc7:	48 c1 e2 10          	shl    $0x10,%rdx
    5bcb:	48 39 d1             	cmp    %rdx,%rcx
    5bce:	73 5f                	jae    5c2f <e55+0xff>
    5bd0:	48 8b 15 21 d6 00 00 	mov    0xd621(%rip),%rdx        # 131f8 <fwp_gc+0x1078>
    5bd7:	48 89 ce             	mov    %rcx,%rsi
    5bda:	48 c1 ee 10          	shr    $0x10,%rsi
    5bde:	48 69 f6 28 12 00 00 	imul   $0x1228,%rsi,%rsi
    5be5:	0f b6 3c 32          	movzbl (%rdx,%rsi,1),%edi
    5be9:	48 81 e1 ff ff 00 00 	and    $0xffff,%rcx
    5bf0:	75 18                	jne    5c0a <e55+0xda>
    5bf2:	40 80 ff 02          	cmp    $0x2,%dil
    5bf6:	75 12                	jne    5c0a <e55+0xda>
    5bf8:	48 8d 0c 32          	lea    (%rdx,%rsi,1),%rcx
    5bfc:	48 81 c1 28 02 00 00 	add    $0x228,%rcx
    5c03:	80 39 00             	cmpb   $0x0,(%rcx)
    5c06:	74 27                	je     5c2f <e55+0xff>
    5c08:	eb 27                	jmp    5c31 <e55+0x101>
    5c0a:	40 80 ff 01          	cmp    $0x1,%dil
    5c0e:	75 1f                	jne    5c2f <e55+0xff>
    5c10:	48 8d 3c 32          	lea    (%rdx,%rsi,1),%rdi
    5c14:	8b 54 32 20          	mov    0x20(%rdx,%rsi,1),%edx
    5c18:	48 0f af ca          	imul   %rdx,%rcx
    5c1c:	48 c1 e9 20          	shr    $0x20,%rcx
    5c20:	48 01 f9             	add    %rdi,%rcx
    5c23:	48 81 c1 28 02 00 00 	add    $0x228,%rcx
    5c2a:	80 39 00             	cmpb   $0x0,(%rcx)
    5c2d:	75 02                	jne    5c31 <e55+0x101>
    5c2f:	59                   	pop    %rcx
    5c30:	c3                   	ret
    5c31:	e8 ea 05 00 00       	call   6220 <fwp_flush>
    5c36:	48 8b 05 a3 c3 00 00 	mov    0xc3a3(%rip),%rax        # 11fe0 <stderr@GLIBC_2.2.5>
    5c3d:	48 8b 38             	mov    (%rax),%rdi
    5c40:	48 8d 35 e6 97 00 00 	lea    0x97e6(%rip),%rsi        # f42d <fwp_segv.msg+0x1ed>
    5c47:	48 8d 15 b2 97 00 00 	lea    0x97b2(%rip),%rdx        # f400 <fwp_segv.msg+0x1c0>
    5c4e:	31 c0                	xor    %eax,%eax
    5c50:	e8 5b c5 ff ff       	call   21b0 <fprintf@plt>
    5c55:	bf 65 00 00 00       	mov    $0x65,%edi
    5c5a:	e8 31 c6 ff ff       	call   2290 <exit@plt>
    5c5f:	90                   	nop

0000000000005c60 <e56>:
    5c60:	50                   	push   %rax
    5c61:	48 89 f8             	mov    %rdi,%rax
    5c64:	48 8b 3f             	mov    (%rdi),%rdi
    5c67:	48 8b 0d 42 d5 00 00 	mov    0xd542(%rip),%rcx        # 131b0 <fwp_gc+0x1030>
    5c6e:	48 89 fe             	mov    %rdi,%rsi
    5c71:	48 29 ce             	sub    %rcx,%rsi
    5c74:	48 8b 15 5d d5 00 00 	mov    0xd55d(%rip),%rdx        # 131d8 <fwp_gc+0x1058>
    5c7b:	48 c1 e2 10          	shl    $0x10,%rdx
    5c7f:	48 39 d6             	cmp    %rdx,%rsi
    5c82:	73 68                	jae    5cec <e56+0x8c>
    5c84:	4c 8b 05 6d d5 00 00 	mov    0xd56d(%rip),%r8        # 131f8 <fwp_gc+0x1078>
    5c8b:	49 89 f1             	mov    %rsi,%r9
    5c8e:	49 c1 e9 10          	shr    $0x10,%r9
    5c92:	4d 69 c9 28 12 00 00 	imul   $0x1228,%r9,%r9
    5c99:	47 0f b6 14 08       	movzbl (%r8,%r9,1),%r10d
    5c9e:	48 81 e6 ff ff 00 00 	and    $0xffff,%rsi
    5ca5:	75 1b                	jne    5cc2 <e56+0x62>
    5ca7:	41 80 fa 02          	cmp    $0x2,%r10b
    5cab:	75 15                	jne    5cc2 <e56+0x62>
    5cad:	4b 8d 34 08          	lea    (%r8,%r9,1),%rsi
    5cb1:	48 81 c6 28 02 00 00 	add    $0x228,%rsi
    5cb8:	80 3e 00             	cmpb   $0x0,(%rsi)
    5cbb:	74 2f                	je     5cec <e56+0x8c>
    5cbd:	e9 1d 01 00 00       	jmp    5ddf <e56+0x17f>
    5cc2:	41 80 fa 01          	cmp    $0x1,%r10b
    5cc6:	75 24                	jne    5cec <e56+0x8c>
    5cc8:	4f 8d 14 08          	lea    (%r8,%r9,1),%r10
    5ccc:	47 8b 44 08 20       	mov    0x20(%r8,%r9,1),%r8d
    5cd1:	49 0f af f0          	imul   %r8,%rsi
    5cd5:	48 c1 ee 20          	shr    $0x20,%rsi
    5cd9:	4c 01 d6             	add    %r10,%rsi
    5cdc:	48 81 c6 28 02 00 00 	add    $0x228,%rsi
    5ce3:	80 3e 00             	cmpb   $0x0,(%rsi)
    5ce6:	0f 85 f3 00 00 00    	jne    5ddf <e56+0x17f>
    5cec:	48 8b 70 08          	mov    0x8(%rax),%rsi
    5cf0:	48 89 f0             	mov    %rsi,%rax
    5cf3:	48 29 c8             	sub    %rcx,%rax
    5cf6:	48 39 d0             	cmp    %rdx,%rax
    5cf9:	73 64                	jae    5d5f <e56+0xff>
    5cfb:	48 8b 0d f6 d4 00 00 	mov    0xd4f6(%rip),%rcx        # 131f8 <fwp_gc+0x1078>
    5d02:	48 89 c2             	mov    %rax,%rdx
    5d05:	48 c1 ea 10          	shr    $0x10,%rdx
    5d09:	48 69 d2 28 12 00 00 	imul   $0x1228,%rdx,%rdx
    5d10:	44 0f b6 04 11       	movzbl (%rcx,%rdx,1),%r8d
    5d15:	48 25 ff ff 00 00    	and    $0xffff,%rax
    5d1b:	75 1a                	jne    5d37 <e56+0xd7>
    5d1d:	41 80 f8 02          	cmp    $0x2,%r8b
    5d21:	75 14                	jne    5d37 <e56+0xd7>
    5d23:	48 8d 04 11          	lea    (%rcx,%rdx,1),%rax
    5d27:	48 05 28 02 00 00    	add    $0x228,%rax
    5d2d:	80 38 00             	cmpb   $0x0,(%rax)
    5d30:	74 2d                	je     5d5f <e56+0xff>
    5d32:	e9 a8 00 00 00       	jmp    5ddf <e56+0x17f>
    5d37:	41 80 f8 01          	cmp    $0x1,%r8b
    5d3b:	75 22                	jne    5d5f <e56+0xff>
    5d3d:	4c 8d 04 11          	lea    (%rcx,%rdx,1),%r8
    5d41:	8b 4c 11 20          	mov    0x20(%rcx,%rdx,1),%ecx
    5d45:	48 0f af c1          	imul   %rcx,%rax
    5d49:	48 c1 e8 20          	shr    $0x20,%rax
    5d4d:	4c 01 c0             	add    %r8,%rax
    5d50:	48 05 28 02 00 00    	add    $0x228,%rax
    5d56:	80 38 00             	cmpb   $0x0,(%rax)
    5d59:	0f 85 80 00 00 00    	jne    5ddf <e56+0x17f>
    5d5f:	e8 3c 4e 00 00       	call   aba0 <fwp_p_loop_own>
    5d64:	48 89 c1             	mov    %rax,%rcx
    5d67:	48 2b 0d 42 d4 00 00 	sub    0xd442(%rip),%rcx        # 131b0 <fwp_gc+0x1030>
    5d6e:	48 8b 15 63 d4 00 00 	mov    0xd463(%rip),%rdx        # 131d8 <fwp_gc+0x1058>
    5d75:	48 c1 e2 10          	shl    $0x10,%rdx
    5d79:	48 39 d1             	cmp    %rdx,%rcx
    5d7c:	73 5f                	jae    5ddd <e56+0x17d>
    5d7e:	48 8b 15 73 d4 00 00 	mov    0xd473(%rip),%rdx        # 131f8 <fwp_gc+0x1078>
    5d85:	48 89 ce             	mov    %rcx,%rsi
    5d88:	48 c1 ee 10          	shr    $0x10,%rsi
    5d8c:	48 69 f6 28 12 00 00 	imul   $0x1228,%rsi,%rsi
    5d93:	0f b6 3c 32          	movzbl (%rdx,%rsi,1),%edi
    5d97:	48 81 e1 ff ff 00 00 	and    $0xffff,%rcx
    5d9e:	75 18                	jne    5db8 <e56+0x158>
    5da0:	40 80 ff 02          	cmp    $0x2,%dil
    5da4:	75 12                	jne    5db8 <e56+0x158>
    5da6:	48 8d 0c 32          	lea    (%rdx,%rsi,1),%rcx
    5daa:	48 81 c1 28 02 00 00 	add    $0x228,%rcx
    5db1:	80 39 00             	cmpb   $0x0,(%rcx)
    5db4:	74 27                	je     5ddd <e56+0x17d>
    5db6:	eb 27                	jmp    5ddf <e56+0x17f>
    5db8:	40 80 ff 01          	cmp    $0x1,%dil
    5dbc:	75 1f                	jne    5ddd <e56+0x17d>
    5dbe:	48 8d 3c 32          	lea    (%rdx,%rsi,1),%rdi
    5dc2:	8b 54 32 20          	mov    0x20(%rdx,%rsi,1),%edx
    5dc6:	48 0f af ca          	imul   %rdx,%rcx
    5dca:	48 c1 e9 20          	shr    $0x20,%rcx
    5dce:	48 01 f9             	add    %rdi,%rcx
    5dd1:	48 81 c1 28 02 00 00 	add    $0x228,%rcx
    5dd8:	80 39 00             	cmpb   $0x0,(%rcx)
    5ddb:	75 02                	jne    5ddf <e56+0x17f>
    5ddd:	59                   	pop    %rcx
    5dde:	c3                   	ret
    5ddf:	e8 3c 04 00 00       	call   6220 <fwp_flush>
    5de4:	48 8b 05 f5 c1 00 00 	mov    0xc1f5(%rip),%rax        # 11fe0 <stderr@GLIBC_2.2.5>
    5deb:	48 8b 38             	mov    (%rax),%rdi
    5dee:	48 8d 35 38 96 00 00 	lea    0x9638(%rip),%rsi        # f42d <fwp_segv.msg+0x1ed>
    5df5:	48 8d 15 04 96 00 00 	lea    0x9604(%rip),%rdx        # f400 <fwp_segv.msg+0x1c0>
    5dfc:	31 c0                	xor    %eax,%eax
    5dfe:	e8 ad c3 ff ff       	call   21b0 <fprintf@plt>
    5e03:	bf 65 00 00 00       	mov    $0x65,%edi
    5e08:	e8 83 c4 ff ff       	call   2290 <exit@plt>
    5e0d:	0f 1f 00             	nopl   (%rax)

0000000000005e10 <e57>:
    5e10:	50                   	push   %rax
    5e11:	48 8b 3f             	mov    (%rdi),%rdi
    5e14:	48 89 f8             	mov    %rdi,%rax
    5e17:	48 2b 05 92 d3 00 00 	sub    0xd392(%rip),%rax        # 131b0 <fwp_gc+0x1030>
    5e1e:	48 8b 0d b3 d3 00 00 	mov    0xd3b3(%rip),%rcx        # 131d8 <fwp_gc+0x1058>
    5e25:	48 c1 e1 10          	shl    $0x10,%rcx
    5e29:	48 39 c8             	cmp    %rcx,%rax
    5e2c:	73 63                	jae    5e91 <e57+0x81>
    5e2e:	48 8b 0d c3 d3 00 00 	mov    0xd3c3(%rip),%rcx        # 131f8 <fwp_gc+0x1078>
    5e35:	48 89 c2             	mov    %rax,%rdx
    5e38:	48 c1 ea 10          	shr    $0x10,%rdx
    5e3c:	48 69 d2 28 12 00 00 	imul   $0x1228,%rdx,%rdx
    5e43:	0f b6 34 11          	movzbl (%rcx,%rdx,1),%esi
    5e47:	48 25 ff ff 00 00    	and    $0xffff,%rax
    5e4d:	75 1a                	jne    5e69 <e57+0x59>
    5e4f:	40 80 fe 02          	cmp    $0x2,%sil
    5e53:	75 14                	jne    5e69 <e57+0x59>
    5e55:	48 8d 04 11          	lea    (%rcx,%rdx,1),%rax
    5e59:	48 05 28 02 00 00    	add    $0x228,%rax
    5e5f:	80 38 00             	cmpb   $0x0,(%rax)
    5e62:	74 2d                	je     5e91 <e57+0x81>
    5e64:	e9 a8 00 00 00       	jmp    5f11 <e57+0x101>
    5e69:	40 80 fe 01          	cmp    $0x1,%sil
    5e6d:	75 22                	jne    5e91 <e57+0x81>
    5e6f:	48 8d 34 11          	lea    (%rcx,%rdx,1),%rsi
    5e73:	8b 4c 11 20          	mov    0x20(%rcx,%rdx,1),%ecx
    5e77:	48 0f af c1          	imul   %rcx,%rax
    5e7b:	48 c1 e8 20          	shr    $0x20,%rax
    5e7f:	48 01 f0             	add    %rsi,%rax
    5e82:	48 05 28 02 00 00    	add    $0x228,%rax
    5e88:	80 38 00             	cmpb   $0x0,(%rax)
    5e8b:	0f 85 80 00 00 00    	jne    5f11 <e57+0x101>
    5e91:	e8 0a 70 00 00       	call   cea0 <f57>
    5e96:	48 89 c1             	mov    %rax,%rcx
    5e99:	48 2b 0d 10 d3 00 00 	sub    0xd310(%rip),%rcx        # 131b0 <fwp_gc+0x1030>
    5ea0:	48 8b 15 31 d3 00 00 	mov    0xd331(%rip),%rdx        # 131d8 <fwp_gc+0x1058>
    5ea7:	48 c1 e2 10          	shl    $0x10,%rdx
    5eab:	48 39 d1             	cmp    %rdx,%rcx
    5eae:	73 5f                	jae    5f0f <e57+0xff>
    5eb0:	48 8b 15 41 d3 00 00 	mov    0xd341(%rip),%rdx        # 131f8 <fwp_gc+0x1078>
    5eb7:	48 89 ce             	mov    %rcx,%rsi
    5eba:	48 c1 ee 10          	shr    $0x10,%rsi
    5ebe:	48 69 f6 28 12 00 00 	imul   $0x1228,%rsi,%rsi
    5ec5:	0f b6 3c 32          	movzbl (%rdx,%rsi,1),%edi
    5ec9:	48 81 e1 ff ff 00 00 	and    $0xffff,%rcx
    5ed0:	75 18                	jne    5eea <e57+0xda>
    5ed2:	40 80 ff 02          	cmp    $0x2,%dil
    5ed6:	75 12                	jne    5eea <e57+0xda>
    5ed8:	48 8d 0c 32          	lea    (%rdx,%rsi,1),%rcx
    5edc:	48 81 c1 28 02 00 00 	add    $0x228,%rcx
    5ee3:	80 39 00             	cmpb   $0x0,(%rcx)
    5ee6:	74 27                	je     5f0f <e57+0xff>
    5ee8:	eb 27                	jmp    5f11 <e57+0x101>
    5eea:	40 80 ff 01          	cmp    $0x1,%dil
    5eee:	75 1f                	jne    5f0f <e57+0xff>
    5ef0:	48 8d 3c 32          	lea    (%rdx,%rsi,1),%rdi
    5ef4:	8b 54 32 20          	mov    0x20(%rdx,%rsi,1),%edx
    5ef8:	48 0f af ca          	imul   %rdx,%rcx
    5efc:	48 c1 e9 20          	shr    $0x20,%rcx
    5f00:	48 01 f9             	add    %rdi,%rcx
    5f03:	48 81 c1 28 02 00 00 	add    $0x228,%rcx
    5f0a:	80 39 00             	cmpb   $0x0,(%rcx)
    5f0d:	75 02                	jne    5f11 <e57+0x101>
    5f0f:	59                   	pop    %rcx
    5f10:	c3                   	ret
    5f11:	e8 0a 03 00 00       	call   6220 <fwp_flush>
    5f16:	48 8b 05 c3 c0 00 00 	mov    0xc0c3(%rip),%rax        # 11fe0 <stderr@GLIBC_2.2.5>
    5f1d:	48 8b 38             	mov    (%rax),%rdi
    5f20:	48 8d 35 06 95 00 00 	lea    0x9506(%rip),%rsi        # f42d <fwp_segv.msg+0x1ed>
    5f27:	48 8d 15 d2 94 00 00 	lea    0x94d2(%rip),%rdx        # f400 <fwp_segv.msg+0x1c0>
    5f2e:	31 c0                	xor    %eax,%eax
    5f30:	e8 7b c2 ff ff       	call   21b0 <fprintf@plt>
    5f35:	bf 65 00 00 00       	mov    $0x65,%edi
    5f3a:	e8 51 c3 ff ff       	call   2290 <exit@plt>
    5f3f:	90                   	nop

0000000000005f40 <e58>:
    5f40:	50                   	push   %rax
    5f41:	48 89 f8             	mov    %rdi,%rax
    5f44:	48 8b 3f             	mov    (%rdi),%rdi
    5f47:	48 8b 0d 62 d2 00 00 	mov    0xd262(%rip),%rcx        # 131b0 <fwp_gc+0x1030>
    5f4e:	48 89 fe             	mov    %rdi,%rsi
    5f51:	48 29 ce             	sub    %rcx,%rsi
    5f54:	48 8b 15 7d d2 00 00 	mov    0xd27d(%rip),%rdx        # 131d8 <fwp_gc+0x1058>
    5f5b:	48 c1 e2 10          	shl    $0x10,%rdx
    5f5f:	48 39 d6             	cmp    %rdx,%rsi
    5f62:	73 68                	jae    5fcc <e58+0x8c>
    5f64:	4c 8b 05 8d d2 00 00 	mov    0xd28d(%rip),%r8        # 131f8 <fwp_gc+0x1078>
    5f6b:	49 89 f1             	mov    %rsi,%r9
    5f6e:	49 c1 e9 10          	shr    $0x10,%r9
    5f72:	4d 69 c9 28 12 00 00 	imul   $0x1228,%r9,%r9
    5f79:	47 0f b6 14 08       	movzbl (%r8,%r9,1),%r10d
    5f7e:	48 81 e6 ff ff 00 00 	and    $0xffff,%rsi
    5f85:	75 1b                	jne    5fa2 <e58+0x62>
    5f87:	41 80 fa 02          	cmp    $0x2,%r10b
    5f8b:	75 15                	jne    5fa2 <e58+0x62>
    5f8d:	4b 8d 34 08          	lea    (%r8,%r9,1),%rsi
    5f91:	48 81 c6 28 02 00 00 	add    $0x228,%rsi
    5f98:	80 3e 00             	cmpb   $0x0,(%rsi)
    5f9b:	74 2f                	je     5fcc <e58+0x8c>
    5f9d:	e9 1d 01 00 00       	jmp    60bf <e58+0x17f>
    5fa2:	41 80 fa 01          	cmp    $0x1,%r10b
    5fa6:	75 24                	jne    5fcc <e58+0x8c>
    5fa8:	4f 8d 14 08          	lea    (%r8,%r9,1),%r10
    5fac:	47 8b 44 08 20       	mov    0x20(%r8,%r9,1),%r8d
    5fb1:	49 0f af f0          	imul   %r8,%rsi
    5fb5:	48 c1 ee 20          	shr    $0x20,%rsi
    5fb9:	4c 01 d6             	add    %r10,%rsi
    5fbc:	48 81 c6 28 02 00 00 	add    $0x228,%rsi
    5fc3:	80 3e 00             	cmpb   $0x0,(%rsi)
    5fc6:	0f 85 f3 00 00 00    	jne    60bf <e58+0x17f>
    5fcc:	48 8b 70 08          	mov    0x8(%rax),%rsi
    5fd0:	48 89 f0             	mov    %rsi,%rax
    5fd3:	48 29 c8             	sub    %rcx,%rax
    5fd6:	48 39 d0             	cmp    %rdx,%rax
    5fd9:	73 64                	jae    603f <e58+0xff>
    5fdb:	48 8b 0d 16 d2 00 00 	mov    0xd216(%rip),%rcx        # 131f8 <fwp_gc+0x1078>
    5fe2:	48 89 c2             	mov    %rax,%rdx
    5fe5:	48 c1 ea 10          	shr    $0x10,%rdx
    5fe9:	48 69 d2 28 12 00 00 	imul   $0x1228,%rdx,%rdx
    5ff0:	44 0f b6 04 11       	movzbl (%rcx,%rdx,1),%r8d
    5ff5:	48 25 ff ff 00 00    	and    $0xffff,%rax
    5ffb:	75 1a                	jne    6017 <e58+0xd7>
    5ffd:	41 80 f8 02          	cmp    $0x2,%r8b
    6001:	75 14                	jne    6017 <e58+0xd7>
    6003:	48 8d 04 11          	lea    (%rcx,%rdx,1),%rax
    6007:	48 05 28 02 00 00    	add    $0x228,%rax
    600d:	80 38 00             	cmpb   $0x0,(%rax)
    6010:	74 2d                	je     603f <e58+0xff>
    6012:	e9 a8 00 00 00       	jmp    60bf <e58+0x17f>
    6017:	41 80 f8 01          	cmp    $0x1,%r8b
    601b:	75 22                	jne    603f <e58+0xff>
    601d:	4c 8d 04 11          	lea    (%rcx,%rdx,1),%r8
    6021:	8b 4c 11 20          	mov    0x20(%rcx,%rdx,1),%ecx
    6025:	48 0f af c1          	imul   %rcx,%rax
    6029:	48 c1 e8 20          	shr    $0x20,%rax
    602d:	4c 01 c0             	add    %r8,%rax
    6030:	48 05 28 02 00 00    	add    $0x228,%rax
    6036:	80 38 00             	cmpb   $0x0,(%rax)
    6039:	0f 85 80 00 00 00    	jne    60bf <e58+0x17f>
    603f:	e8 5c 4b 00 00       	call   aba0 <fwp_p_loop_own>
    6044:	48 89 c1             	mov    %rax,%rcx
    6047:	48 2b 0d 62 d1 00 00 	sub    0xd162(%rip),%rcx        # 131b0 <fwp_gc+0x1030>
    604e:	48 8b 15 83 d1 00 00 	mov    0xd183(%rip),%rdx        # 131d8 <fwp_gc+0x1058>
    6055:	48 c1 e2 10          	shl    $0x10,%rdx
    6059:	48 39 d1             	cmp    %rdx,%rcx
    605c:	73 5f                	jae    60bd <e58+0x17d>
    605e:	48 8b 15 93 d1 00 00 	mov    0xd193(%rip),%rdx        # 131f8 <fwp_gc+0x1078>
    6065:	48 89 ce             	mov    %rcx,%rsi
    6068:	48 c1 ee 10          	shr    $0x10,%rsi
    606c:	48 69 f6 28 12 00 00 	imul   $0x1228,%rsi,%rsi
    6073:	0f b6 3c 32          	movzbl (%rdx,%rsi,1),%edi
    6077:	48 81 e1 ff ff 00 00 	and    $0xffff,%rcx
    607e:	75 18                	jne    6098 <e58+0x158>
    6080:	40 80 ff 02          	cmp    $0x2,%dil
    6084:	75 12                	jne    6098 <e58+0x158>
    6086:	48 8d 0c 32          	lea    (%rdx,%rsi,1),%rcx
    608a:	48 81 c1 28 02 00 00 	add    $0x228,%rcx
    6091:	80 39 00             	cmpb   $0x0,(%rcx)
    6094:	74 27                	je     60bd <e58+0x17d>
    6096:	eb 27                	jmp    60bf <e58+0x17f>
    6098:	40 80 ff 01          	cmp    $0x1,%dil
    609c:	75 1f                	jne    60bd <e58+0x17d>
    609e:	48 8d 3c 32          	lea    (%rdx,%rsi,1),%rdi
    60a2:	8b 54 32 20          	mov    0x20(%rdx,%rsi,1),%edx
    60a6:	48 0f af ca          	imul   %rdx,%rcx
    60aa:	48 c1 e9 20          	shr    $0x20,%rcx
    60ae:	48 01 f9             	add    %rdi,%rcx
    60b1:	48 81 c1 28 02 00 00 	add    $0x228,%rcx
    60b8:	80 39 00             	cmpb   $0x0,(%rcx)
    60bb:	75 02                	jne    60bf <e58+0x17f>
    60bd:	59                   	pop    %rcx
    60be:	c3                   	ret
    60bf:	e8 5c 01 00 00       	call   6220 <fwp_flush>
    60c4:	48 8b 05 15 bf 00 00 	mov    0xbf15(%rip),%rax        # 11fe0 <stderr@GLIBC_2.2.5>
    60cb:	48 8b 38             	mov    (%rax),%rdi
    60ce:	48 8d 35 58 93 00 00 	lea    0x9358(%rip),%rsi        # f42d <fwp_segv.msg+0x1ed>
    60d5:	48 8d 15 24 93 00 00 	lea    0x9324(%rip),%rdx        # f400 <fwp_segv.msg+0x1c0>
    60dc:	31 c0                	xor    %eax,%eax
    60de:	e8 cd c0 ff ff       	call   21b0 <fprintf@plt>
    60e3:	bf 65 00 00 00       	mov    $0x65,%edi
    60e8:	e8 a3 c1 ff ff       	call   2290 <exit@plt>
    60ed:	0f 1f 00             	nopl   (%rax)

00000000000060f0 <e59>:
    60f0:	50                   	push   %rax
    60f1:	48 8b 3f             	mov    (%rdi),%rdi
    60f4:	48 89 f8             	mov    %rdi,%rax
    60f7:	48 2b 05 b2 d0 00 00 	sub    0xd0b2(%rip),%rax        # 131b0 <fwp_gc+0x1030>
    60fe:	48 8b 0d d3 d0 00 00 	mov    0xd0d3(%rip),%rcx        # 131d8 <fwp_gc+0x1058>
    6105:	48 c1 e1 10          	shl    $0x10,%rcx
    6109:	48 39 c8             	cmp    %rcx,%rax
    610c:	73 63                	jae    6171 <e59+0x81>
    610e:	48 8b 0d e3 d0 00 00 	mov    0xd0e3(%rip),%rcx        # 131f8 <fwp_gc+0x1078>
    6115:	48 89 c2             	mov    %rax,%rdx
    6118:	48 c1 ea 10          	shr    $0x10,%rdx
    611c:	48 69 d2 28 12 00 00 	imul   $0x1228,%rdx,%rdx
    6123:	0f b6 34 11          	movzbl (%rcx,%rdx,1),%esi
    6127:	48 25 ff ff 00 00    	and    $0xffff,%rax
    612d:	75 1a                	jne    6149 <e59+0x59>
    612f:	40 80 fe 02          	cmp    $0x2,%sil
    6133:	75 14                	jne    6149 <e59+0x59>
    6135:	48 8d 04 11          	lea    (%rcx,%rdx,1),%rax
    6139:	48 05 28 02 00 00    	add    $0x228,%rax
    613f:	80 38 00             	cmpb   $0x0,(%rax)
    6142:	74 2d                	je     6171 <e59+0x81>
    6144:	e9 a8 00 00 00       	jmp    61f1 <e59+0x101>
    6149:	40 80 fe 01          	cmp    $0x1,%sil
    614d:	75 22                	jne    6171 <e59+0x81>
    614f:	48 8d 34 11          	lea    (%rcx,%rdx,1),%rsi
    6153:	8b 4c 11 20          	mov    0x20(%rcx,%rdx,1),%ecx
    6157:	48 0f af c1          	imul   %rcx,%rax
    615b:	48 c1 e8 20          	shr    $0x20,%rax
    615f:	48 01 f0             	add    %rsi,%rax
    6162:	48 05 28 02 00 00    	add    $0x228,%rax
    6168:	80 38 00             	cmpb   $0x0,(%rax)
    616b:	0f 85 80 00 00 00    	jne    61f1 <e59+0x101>
    6171:	e8 1a 73 00 00       	call   d490 <f59>
    6176:	48 89 c1             	mov    %rax,%rcx
    6179:	48 2b 0d 30 d0 00 00 	sub    0xd030(%rip),%rcx        # 131b0 <fwp_gc+0x1030>
    6180:	48 8b 15 51 d0 00 00 	mov    0xd051(%rip),%rdx        # 131d8 <fwp_gc+0x1058>
    6187:	48 c1 e2 10          	shl    $0x10,%rdx
    618b:	48 39 d1             	cmp    %rdx,%rcx
    618e:	73 5f                	jae    61ef <e59+0xff>
    6190:	48 8b 15 61 d0 00 00 	mov    0xd061(%rip),%rdx        # 131f8 <fwp_gc+0x1078>
    6197:	48 89 ce             	mov    %rcx,%rsi
    619a:	48 c1 ee 10          	shr    $0x10,%rsi
    619e:	48 69 f6 28 12 00 00 	imul   $0x1228,%rsi,%rsi
    61a5:	0f b6 3c 32          	movzbl (%rdx,%rsi,1),%edi
    61a9:	48 81 e1 ff ff 00 00 	and    $0xffff,%rcx
    61b0:	75 18                	jne    61ca <e59+0xda>
    61b2:	40 80 ff 02          	cmp    $0x2,%dil
    61b6:	75 12                	jne    61ca <e59+0xda>
    61b8:	48 8d 0c 32          	lea    (%rdx,%rsi,1),%rcx
    61bc:	48 81 c1 28 02 00 00 	add    $0x228,%rcx
    61c3:	80 39 00             	cmpb   $0x0,(%rcx)
    61c6:	74 27                	je     61ef <e59+0xff>
    61c8:	eb 27                	jmp    61f1 <e59+0x101>
    61ca:	40 80 ff 01          	cmp    $0x1,%dil
    61ce:	75 1f                	jne    61ef <e59+0xff>
    61d0:	48 8d 3c 32          	lea    (%rdx,%rsi,1),%rdi
    61d4:	8b 54 32 20          	mov    0x20(%rdx,%rsi,1),%edx
    61d8:	48 0f af ca          	imul   %rdx,%rcx
    61dc:	48 c1 e9 20          	shr    $0x20,%rcx
    61e0:	48 01 f9             	add    %rdi,%rcx
    61e3:	48 81 c1 28 02 00 00 	add    $0x228,%rcx
    61ea:	80 39 00             	cmpb   $0x0,(%rcx)
    61ed:	75 02                	jne    61f1 <e59+0x101>
    61ef:	59                   	pop    %rcx
    61f0:	c3                   	ret
    61f1:	e8 2a 00 00 00       	call   6220 <fwp_flush>
    61f6:	48 8b 05 e3 bd 00 00 	mov    0xbde3(%rip),%rax        # 11fe0 <stderr@GLIBC_2.2.5>
    61fd:	48 8b 38             	mov    (%rax),%rdi
    6200:	48 8d 35 26 92 00 00 	lea    0x9226(%rip),%rsi        # f42d <fwp_segv.msg+0x1ed>
    6207:	48 8d 15 f2 91 00 00 	lea    0x91f2(%rip),%rdx        # f400 <fwp_segv.msg+0x1c0>
    620e:	31 c0                	xor    %eax,%eax
    6210:	e8 9b bf ff ff       	call   21b0 <fprintf@plt>
    6215:	bf 65 00 00 00       	mov    $0x65,%edi
    621a:	e8 71 c0 ff ff       	call   2290 <exit@plt>
    621f:	90                   	nop

0000000000006220 <fwp_flush>:
    6220:	50                   	push   %rax
    6221:	48 8b 3d a0 d9 00 00 	mov    0xd9a0(%rip),%rdi        # 13bc8 <fwp_prog_out>
    6228:	48 85 ff             	test   %rdi,%rdi
    622b:	74 05                	je     6232 <fwp_flush+0x12>
    622d:	e8 ce bf ff ff       	call   2200 <fflush@plt>
    6232:	48 8b 05 87 bd 00 00 	mov    0xbd87(%rip),%rax        # 11fc0 <stdout@GLIBC_2.2.5>
    6239:	48 8b 38             	mov    (%rax),%rdi
    623c:	58                   	pop    %rax
    623d:	e9 be bf ff ff       	jmp    2200 <fflush@plt>
    6242:	66 66 66 66 66 2e 0f 	data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    6249:	1f 84 00 00 00 00 00 

0000000000006250 <fwp_rc_forget_slot>:
    6250:	50                   	push   %rax
    6251:	80 3f ff             	cmpb   $0xff,(%rdi)
    6254:	74 02                	je     6258 <fwp_rc_forget_slot+0x8>
    6256:	58                   	pop    %rax
    6257:	c3                   	ret
    6258:	48 89 f8             	mov    %rdi,%rax
    625b:	48 c1 e8 11          	shr    $0x11,%rax
    625f:	31 f8                	xor    %edi,%eax
    6261:	89 c1                	mov    %eax,%ecx
    6263:	c1 e9 09             	shr    $0x9,%ecx
    6266:	31 c1                	xor    %eax,%ecx
    6268:	0f b6 c9             	movzbl %cl,%ecx
    626b:	48 8d 15 0e bf 00 00 	lea    0xbf0e(%rip),%rdx        # 12180 <fwp_gc>
    6272:	48 8b 84 ca 18 12 00 	mov    0x1218(%rdx,%rcx,8),%rax
    6279:	00 
    627a:	48 85 c0             	test   %rax,%rax
    627d:	74 4b                	je     62ca <fwp_rc_forget_slot+0x7a>
    627f:	48 39 38             	cmp    %rdi,(%rax)
    6282:	74 23                	je     62a7 <fwp_rc_forget_slot+0x57>
    6284:	66 66 66 2e 0f 1f 84 	data16 data16 cs nopw 0x0(%rax,%rax,1)
    628b:	00 00 00 00 00 
    6290:	48 89 c1             	mov    %rax,%rcx
    6293:	48 8b 40 10          	mov    0x10(%rax),%rax
    6297:	48 85 c0             	test   %rax,%rax
    629a:	74 2e                	je     62ca <fwp_rc_forget_slot+0x7a>
    629c:	48 39 38             	cmp    %rdi,(%rax)
    629f:	75 ef                	jne    6290 <fwp_rc_forget_slot+0x40>
    62a1:	48 83 c1 10          	add    $0x10,%rcx
    62a5:	eb 0b                	jmp    62b2 <fwp_rc_forget_slot+0x62>
    62a7:	48 8d 0c ca          	lea    (%rdx,%rcx,8),%rcx
    62ab:	48 81 c1 18 12 00 00 	add    $0x1218,%rcx
    62b2:	48 8b 50 10          	mov    0x10(%rax),%rdx
    62b6:	48 89 11             	mov    %rdx,(%rcx)
    62b9:	48 89 c7             	mov    %rax,%rdi
    62bc:	e8 8f bd ff ff       	call   2050 <free@plt>
    62c1:	48 ff 0d d0 d8 00 00 	decq   0xd8d0(%rip)        # 13b98 <fwp_gc+0x1a18>
    62c8:	58                   	pop    %rax
    62c9:	c3                   	ret
    62ca:	e8 51 ff ff ff       	call   6220 <fwp_flush>
    62cf:	48 8b 05 0a bd 00 00 	mov    0xbd0a(%rip),%rax        # 11fe0 <stderr@GLIBC_2.2.5>
    62d6:	48 8b 38             	mov    (%rax),%rdi
    62d9:	48 8d 35 4d 91 00 00 	lea    0x914d(%rip),%rsi        # f42d <fwp_segv.msg+0x1ed>
    62e0:	48 8d 15 55 91 00 00 	lea    0x9155(%rip),%rdx        # f43c <fwp_segv.msg+0x1fc>
    62e7:	31 c0                	xor    %eax,%eax
    62e9:	e8 c2 be ff ff       	call   21b0 <fprintf@plt>
    62ee:	bf 65 00 00 00       	mov    $0x65,%edi
    62f3:	e8 98 bf ff ff       	call   2290 <exit@plt>
    62f8:	0f 1f 84 00 00 00 00 	nopl   0x0(%rax,%rax,1)
    62ff:	00 

0000000000006300 <fwp_p_array_from_list_typed>:
    6300:	41 56                	push   %r14
    6302:	53                   	push   %rbx
    6303:	50                   	push   %rax
    6304:	48 89 fb             	mov    %rdi,%rbx
    6307:	48 85 ff             	test   %rdi,%rdi
    630a:	0f 84 ae 00 00 00    	je     63be <fwp_p_array_from_list_typed+0xbe>
    6310:	31 ff                	xor    %edi,%edi
    6312:	48 89 d8             	mov    %rbx,%rax
    6315:	66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
    631c:	00 00 00 00 
    6320:	48 ff c7             	inc    %rdi
    6323:	48 8b 40 10          	mov    0x10(%rax),%rax
    6327:	48 85 c0             	test   %rax,%rax
    632a:	75 f4                	jne    6320 <fwp_p_array_from_list_typed+0x20>
    632c:	49 89 f6             	mov    %rsi,%r14
    632f:	e8 cc 00 00 00       	call   6400 <fwp_array_typed_new>
    6334:	48 85 db             	test   %rbx,%rbx
    6337:	0f 84 88 00 00 00    	je     63c5 <fwp_p_array_from_list_typed+0xc5>
    633d:	b9 04 00 00 00       	mov    $0x4,%ecx
    6342:	ba 84 04 00 00       	mov    $0x484,%edx
    6347:	be 21 00 00 00       	mov    $0x21,%esi
    634c:	bf 42 00 00 00       	mov    $0x42,%edi
    6351:	49 89 d8             	mov    %rbx,%r8
    6354:	4d 89 f1             	mov    %r14,%r9
    6357:	eb 18                	jmp    6371 <fwp_p_array_from_list_typed+0x71>
    6359:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)
    6360:	4c 89 54 c8 e8       	mov    %r10,-0x18(%rax,%rcx,8)
    6365:	4d 8b 40 10          	mov    0x10(%r8),%r8
    6369:	48 ff c1             	inc    %rcx
    636c:	4d 85 c0             	test   %r8,%r8
    636f:	74 54                	je     63c5 <fwp_p_array_from_list_typed+0xc5>
    6371:	48 83 38 00          	cmpq   $0x0,(%rax)
    6375:	78 56                	js     63cd <fwp_p_array_from_list_typed+0xcd>
    6377:	4d 8b 50 08          	mov    0x8(%r8),%r10
    637b:	4d 85 c9             	test   %r9,%r9
    637e:	74 e0                	je     6360 <fwp_p_array_from_list_typed+0x60>
    6380:	45 8b 19             	mov    (%r9),%r11d
    6383:	41 83 fb 0a          	cmp    $0xa,%r11d
    6387:	77 d7                	ja     6360 <fwp_p_array_from_list_typed+0x60>
    6389:	44 0f a3 da          	bt     %r11d,%edx
    638d:	72 21                	jb     63b0 <fwp_p_array_from_list_typed+0xb0>
    638f:	44 0f a3 de          	bt     %r11d,%esi
    6393:	72 22                	jb     63b7 <fwp_p_array_from_list_typed+0xb7>
    6395:	44 0f a3 df          	bt     %r11d,%edi
    6399:	73 c5                	jae    6360 <fwp_p_array_from_list_typed+0x60>
    639b:	66 44 89 14 48       	mov    %r10w,(%rax,%rcx,2)
    63a0:	eb c3                	jmp    6365 <fwp_p_array_from_list_typed+0x65>
    63a2:	66 66 66 66 66 2e 0f 	data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    63a9:	1f 84 00 00 00 00 00 
    63b0:	44 89 54 88 f8       	mov    %r10d,-0x8(%rax,%rcx,4)
    63b5:	eb ae                	jmp    6365 <fwp_p_array_from_list_typed+0x65>
    63b7:	44 88 54 08 04       	mov    %r10b,0x4(%rax,%rcx,1)
    63bc:	eb a7                	jmp    6365 <fwp_p_array_from_list_typed+0x65>
    63be:	31 ff                	xor    %edi,%edi
    63c0:	e8 3b 00 00 00       	call   6400 <fwp_array_typed_new>
    63c5:	48 83 c4 08          	add    $0x8,%rsp
    63c9:	5b                   	pop    %rbx
    63ca:	41 5e                	pop    %r14
    63cc:	c3                   	ret
    63cd:	e8 4e fe ff ff       	call   6220 <fwp_flush>
    63d2:	48 8b 05 07 bc 00 00 	mov    0xbc07(%rip),%rax        # 11fe0 <stderr@GLIBC_2.2.5>
    63d9:	48 8b 38             	mov    (%rax),%rdi
    63dc:	48 8d 35 4a 90 00 00 	lea    0x904a(%rip),%rsi        # f42d <fwp_segv.msg+0x1ed>
    63e3:	48 8d 15 94 91 00 00 	lea    0x9194(%rip),%rdx        # f57e <fwp_segv.msg+0x33e>
    63ea:	31 c0                	xor    %eax,%eax
    63ec:	e8 bf bd ff ff       	call   21b0 <fprintf@plt>
    63f1:	bf 65 00 00 00       	mov    $0x65,%edi
    63f6:	e8 95 be ff ff       	call   2290 <exit@plt>
    63fb:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)

0000000000006400 <fwp_array_typed_new>:
    6400:	41 56                	push   %r14
    6402:	53                   	push   %rbx
    6403:	50                   	push   %rax
    6404:	48 b8 ff ff ff ff ff 	movabs $0x1fffffffffffffff,%rax
    640b:	ff ff 1f 
    640e:	48 39 c7             	cmp    %rax,%rdi
    6411:	0f 83 21 02 00 00    	jae    6638 <fwp_array_typed_new+0x238>
    6417:	48 89 fb             	mov    %rdi,%rbx
    641a:	48 85 f6             	test   %rsi,%rsi
    641d:	74 23                	je     6442 <fwp_array_typed_new+0x42>
    641f:	8b 06                	mov    (%rsi),%eax
    6421:	48 83 f8 0a          	cmp    $0xa,%rax
    6425:	77 0e                	ja     6435 <fwp_array_typed_new+0x35>
    6427:	b9 e7 04 00 00       	mov    $0x4e7,%ecx
    642c:	0f a3 c1             	bt     %eax,%ecx
    642f:	0f 82 93 00 00 00    	jb     64c8 <fwp_array_typed_new+0xc8>
    6435:	48 8d 0c dd 00 00 00 	lea    0x0(,%rbx,8),%rcx
    643c:	00 
    643d:	e9 95 00 00 00       	jmp    64d7 <fwp_array_typed_new+0xd7>
    6442:	48 8d 14 dd 08 00 00 	lea    0x8(,%rbx,8),%rdx
    6449:	00 
    644a:	48 81 fa 00 40 00 00 	cmp    $0x4000,%rdx
    6451:	77 68                	ja     64bb <fwp_array_typed_new+0xbb>
    6453:	48 8d 42 0f          	lea    0xf(%rdx),%rax
    6457:	48 c1 e8 04          	shr    $0x4,%rax
    645b:	48 8d 0d 1e bd 00 00 	lea    0xbd1e(%rip),%rcx        # 12180 <fwp_gc>
    6462:	0f b6 b4 08 e8 0b 00 	movzbl 0xbe8(%rax,%rcx,1),%esi
    6469:	00 
    646a:	8b 84 b1 48 0b 00 00 	mov    0xb48(%rcx,%rsi,4),%eax
    6471:	48 29 05 08 bd 00 00 	sub    %rax,0xbd08(%rip)        # 12180 <fwp_gc>
    6478:	78 41                	js     64bb <fwp_array_typed_new+0xbb>
    647a:	48 8d 34 76          	lea    (%rsi,%rsi,2),%rsi
    647e:	48 8d 3c f1          	lea    (%rcx,%rsi,8),%rdi
    6482:	48 81 c7 88 07 00 00 	add    $0x788,%rdi
    6489:	4c 8b 37             	mov    (%rdi),%r14
    648c:	4d 85 f6             	test   %r14,%r14
    648f:	74 0e                	je     649f <fwp_array_typed_new+0x9f>
    6491:	49 8b 0e             	mov    (%r14),%rcx
    6494:	48 f7 d1             	not    %rcx
    6497:	48 89 0f             	mov    %rcx,(%rdi)
    649a:	e9 f8 00 00 00       	jmp    6597 <fwp_array_typed_new+0x197>
    649f:	4c 8b b4 f1 90 07 00 	mov    0x790(%rcx,%rsi,8),%r14
    64a6:	00 
    64a7:	48 8b bc f1 98 07 00 	mov    0x798(%rcx,%rsi,8),%rdi
    64ae:	00 
    64af:	4c 29 f7             	sub    %r14,%rdi
    64b2:	48 39 c7             	cmp    %rax,%rdi
    64b5:	0f 83 ca 00 00 00    	jae    6585 <fwp_array_typed_new+0x185>
    64bb:	48 89 d7             	mov    %rdx,%rdi
    64be:	be 02 00 00 00       	mov    $0x2,%esi
    64c3:	e9 9c 00 00 00       	jmp    6564 <fwp_array_typed_new+0x164>
    64c8:	48 8d 0d 91 8d 00 00 	lea    0x8d91(%rip),%rcx        # f260 <fwp_segv.msg+0x20>
    64cf:	48 8b 0c c1          	mov    (%rcx,%rax,8),%rcx
    64d3:	48 0f af cb          	imul   %rbx,%rcx
    64d7:	48 8d 51 08          	lea    0x8(%rcx),%rdx
    64db:	83 f8 0b             	cmp    $0xb,%eax
    64de:	0f 87 66 ff ff ff    	ja     644a <fwp_array_typed_new+0x4a>
    64e4:	be ef 0d 00 00       	mov    $0xdef,%esi
    64e9:	0f a3 c6             	bt     %eax,%esi
    64ec:	0f 83 58 ff ff ff    	jae    644a <fwp_array_typed_new+0x4a>
    64f2:	48 81 f9 f8 3f 00 00 	cmp    $0x3ff8,%rcx
    64f9:	77 61                	ja     655c <fwp_array_typed_new+0x15c>
    64fb:	48 83 c1 17          	add    $0x17,%rcx
    64ff:	48 c1 e9 04          	shr    $0x4,%rcx
    6503:	48 8d 05 76 bc 00 00 	lea    0xbc76(%rip),%rax        # 12180 <fwp_gc>
    650a:	0f b6 b4 01 e8 0b 00 	movzbl 0xbe8(%rcx,%rax,1),%esi
    6511:	00 
    6512:	8b 8c b0 48 0b 00 00 	mov    0xb48(%rax,%rsi,4),%ecx
    6519:	48 29 0d 60 bc 00 00 	sub    %rcx,0xbc60(%rip)        # 12180 <fwp_gc>
    6520:	78 3a                	js     655c <fwp_array_typed_new+0x15c>
    6522:	48 8d 34 76          	lea    (%rsi,%rsi,2),%rsi
    6526:	48 8d 3c f0          	lea    (%rax,%rsi,8),%rdi
    652a:	48 81 c7 c8 03 00 00 	add    $0x3c8,%rdi
    6531:	4c 8b 37             	mov    (%rdi),%r14
    6534:	4d 85 f6             	test   %r14,%r14
    6537:	74 0b                	je     6544 <fwp_array_typed_new+0x144>
    6539:	49 8b 06             	mov    (%r14),%rax
    653c:	48 f7 d0             	not    %rax
    653f:	48 89 07             	mov    %rax,(%rdi)
    6542:	eb 3a                	jmp    657e <fwp_array_typed_new+0x17e>
    6544:	4c 8b b4 f0 d0 03 00 	mov    0x3d0(%rax,%rsi,8),%r14
    654b:	00 
    654c:	48 8b bc f0 d8 03 00 	mov    0x3d8(%rax,%rsi,8),%rdi
    6553:	00 
    6554:	4c 29 f7             	sub    %r14,%rdi
    6557:	48 39 cf             	cmp    %rcx,%rdi
    655a:	73 12                	jae    656e <fwp_array_typed_new+0x16e>
    655c:	48 89 d7             	mov    %rdx,%rdi
    655f:	be 01 00 00 00       	mov    $0x1,%esi
    6564:	e8 07 01 00 00       	call   6670 <fwp_gc_alloc_slow>
    6569:	49 89 c6             	mov    %rax,%r14
    656c:	eb 36                	jmp    65a4 <fwp_array_typed_new+0x1a4>
    656e:	48 8d 04 f0          	lea    (%rax,%rsi,8),%rax
    6572:	48 05 d0 03 00 00    	add    $0x3d0,%rax
    6578:	4c 01 f1             	add    %r14,%rcx
    657b:	48 89 08             	mov    %rcx,(%rax)
    657e:	4c 89 f7             	mov    %r14,%rdi
    6581:	31 f6                	xor    %esi,%esi
    6583:	eb 1a                	jmp    659f <fwp_array_typed_new+0x19f>
    6585:	48 8d 0c f1          	lea    (%rcx,%rsi,8),%rcx
    6589:	48 81 c1 90 07 00 00 	add    $0x790,%rcx
    6590:	49 8d 14 06          	lea    (%r14,%rax,1),%rdx
    6594:	48 89 11             	mov    %rdx,(%rcx)
    6597:	4c 89 f7             	mov    %r14,%rdi
    659a:	31 f6                	xor    %esi,%esi
    659c:	48 89 c2             	mov    %rax,%rdx
    659f:	e8 8c bb ff ff       	call   2130 <memset@plt>
    65a4:	49 89 1e             	mov    %rbx,(%r14)
    65a7:	4c 89 f0             	mov    %r14,%rax
    65aa:	48 2b 05 ff cb 00 00 	sub    0xcbff(%rip),%rax        # 131b0 <fwp_gc+0x1030>
    65b1:	48 8b 0d 20 cc 00 00 	mov    0xcc20(%rip),%rcx        # 131d8 <fwp_gc+0x1058>
    65b8:	48 c1 e1 10          	shl    $0x10,%rcx
    65bc:	48 39 c8             	cmp    %rcx,%rax
    65bf:	73 6c                	jae    662d <fwp_array_typed_new+0x22d>
    65c1:	48 8b 0d 30 cc 00 00 	mov    0xcc30(%rip),%rcx        # 131f8 <fwp_gc+0x1078>
    65c8:	48 89 c2             	mov    %rax,%rdx
    65cb:	48 c1 ea 10          	shr    $0x10,%rdx
    65cf:	48 69 d2 28 12 00 00 	imul   $0x1228,%rdx,%rdx
    65d6:	0f b6 34 11          	movzbl (%rcx,%rdx,1),%esi
    65da:	48 25 ff ff 00 00    	and    $0xffff,%rax
    65e0:	75 1b                	jne    65fd <fwp_array_typed_new+0x1fd>
    65e2:	40 80 fe 02          	cmp    $0x2,%sil
    65e6:	75 15                	jne    65fd <fwp_array_typed_new+0x1fd>
    65e8:	48 8d 1c 11          	lea    (%rcx,%rdx,1),%rbx
    65ec:	48 81 c3 28 02 00 00 	add    $0x228,%rbx
    65f3:	80 3b ff             	cmpb   $0xff,(%rbx)
    65f6:	74 2b                	je     6623 <fwp_array_typed_new+0x223>
    65f8:	c6 03 01             	movb   $0x1,(%rbx)
    65fb:	eb 30                	jmp    662d <fwp_array_typed_new+0x22d>
    65fd:	40 80 fe 01          	cmp    $0x1,%sil
    6601:	75 2a                	jne    662d <fwp_array_typed_new+0x22d>
    6603:	48 8d 34 11          	lea    (%rcx,%rdx,1),%rsi
    6607:	8b 4c 11 20          	mov    0x20(%rcx,%rdx,1),%ecx
    660b:	48 0f af c1          	imul   %rcx,%rax
    660f:	48 c1 e8 20          	shr    $0x20,%rax
    6613:	48 8d 1c 30          	lea    (%rax,%rsi,1),%rbx
    6617:	48 81 c3 28 02 00 00 	add    $0x228,%rbx
    661e:	80 3b ff             	cmpb   $0xff,(%rbx)
    6621:	75 d5                	jne    65f8 <fwp_array_typed_new+0x1f8>
    6623:	48 89 df             	mov    %rbx,%rdi
    6626:	e8 25 fc ff ff       	call   6250 <fwp_rc_forget_slot>
    662b:	eb cb                	jmp    65f8 <fwp_array_typed_new+0x1f8>
    662d:	4c 89 f0             	mov    %r14,%rax
    6630:	48 83 c4 08          	add    $0x8,%rsp
    6634:	5b                   	pop    %rbx
    6635:	41 5e                	pop    %r14
    6637:	c3                   	ret
    6638:	e8 e3 fb ff ff       	call   6220 <fwp_flush>
    663d:	48 8b 05 9c b9 00 00 	mov    0xb99c(%rip),%rax        # 11fe0 <stderr@GLIBC_2.2.5>
    6644:	48 8b 38             	mov    (%rax),%rdi
    6647:	48 8d 35 df 8d 00 00 	lea    0x8ddf(%rip),%rsi        # f42d <fwp_segv.msg+0x1ed>
    664e:	48 8d 15 0e 8e 00 00 	lea    0x8e0e(%rip),%rdx        # f463 <fwp_segv.msg+0x223>
    6655:	31 c0                	xor    %eax,%eax
    6657:	e8 54 bb ff ff       	call   21b0 <fprintf@plt>
    665c:	bf 65 00 00 00       	mov    $0x65,%edi
    6661:	e8 2a bc ff ff       	call   2290 <exit@plt>
    6666:	66 2e 0f 1f 84 00 00 	cs nopw 0x0(%rax,%rax,1)
    666d:	00 00 00 

0000000000006670 <fwp_gc_alloc_slow>:
    6670:	41 57                	push   %r15
    6672:	41 56                	push   %r14
    6674:	41 55                	push   %r13
    6676:	41 54                	push   %r12
    6678:	53                   	push   %rbx
    6679:	89 f3                	mov    %esi,%ebx
    667b:	83 3d ea ca 00 00 00 	cmpl   $0x0,0xcaea(%rip)        # 1316c <fwp_gc+0xfec>
    6682:	74 19                	je     669d <fwp_gc_alloc_slow+0x2d>
    6684:	48 81 ff 01 40 00 00 	cmp    $0x4001,%rdi
    668b:	72 24                	jb     66b1 <fwp_gc_alloc_slow+0x41>
    668d:	89 de                	mov    %ebx,%esi
    668f:	5b                   	pop    %rbx
    6690:	41 5c                	pop    %r12
    6692:	41 5d                	pop    %r13
    6694:	41 5e                	pop    %r14
    6696:	41 5f                	pop    %r15
    6698:	e9 33 06 00 00       	jmp    6cd0 <fwp_gc_alloc_big>
    669d:	49 89 fe             	mov    %rdi,%r14
    66a0:	e8 5b 01 00 00       	call   6800 <fwp_gc_init>
    66a5:	4c 89 f7             	mov    %r14,%rdi
    66a8:	48 81 ff 01 40 00 00 	cmp    $0x4001,%rdi
    66af:	73 dc                	jae    668d <fwp_gc_alloc_slow+0x1d>
    66b1:	48 8d 47 0f          	lea    0xf(%rdi),%rax
    66b5:	48 c1 e8 04          	shr    $0x4,%rax
    66b9:	4c 8d 3d c0 ba 00 00 	lea    0xbac0(%rip),%r15        # 12180 <fwp_gc>
    66c0:	46 0f b6 b4 38 e8 0b 	movzbl 0xbe8(%rax,%r15,1),%r14d
    66c7:	00 00 
    66c9:	43 8b 94 b7 48 0b 00 	mov    0xb48(%r15,%r14,4),%edx
    66d0:	00 
    66d1:	48 83 3d a7 ba 00 00 	cmpq   $0x0,0xbaa7(%rip)        # 12180 <fwp_gc>
    66d8:	00 
    66d9:	0f 89 8c 00 00 00    	jns    676b <fwp_gc_alloc_slow+0xfb>
    66df:	83 3d 86 ca 00 00 00 	cmpl   $0x0,0xca86(%rip)        # 1316c <fwp_gc+0xfec>
    66e6:	75 11                	jne    66f9 <fwp_gc_alloc_slow+0x89>
    66e8:	49 89 fc             	mov    %rdi,%r12
    66eb:	49 89 d5             	mov    %rdx,%r13
    66ee:	e8 0d 01 00 00       	call   6800 <fwp_gc_init>
    66f3:	4c 89 ea             	mov    %r13,%rdx
    66f6:	4c 89 e7             	mov    %r12,%rdi
    66f9:	8b 0d 75 ca 00 00    	mov    0xca75(%rip),%ecx        # 13174 <fwp_gc+0xff4>
    66ff:	85 c9                	test   %ecx,%ecx
    6701:	74 2a                	je     672d <fwp_gc_alloc_slow+0xbd>
    6703:	48 8b 05 96 ca 00 00 	mov    0xca96(%rip),%rax        # 131a0 <fwp_gc+0x1020>
    670a:	48 85 c0             	test   %rax,%rax
    670d:	74 1e                	je     672d <fwp_gc_alloc_slow+0xbd>
    670f:	48 8b 0d 92 ca 00 00 	mov    0xca92(%rip),%rcx        # 131a8 <fwp_gc+0x1028>
    6716:	48 ff c1             	inc    %rcx
    6719:	48 89 0d 88 ca 00 00 	mov    %rcx,0xca88(%rip)        # 131a8 <fwp_gc+0x1028>
    6720:	48 39 c1             	cmp    %rax,%rcx
    6723:	0f 8d c7 00 00 00    	jge    67f0 <fwp_gc_alloc_slow+0x180>
    6729:	31 c0                	xor    %eax,%eax
    672b:	eb 0d                	jmp    673a <fwp_gc_alloc_slow+0xca>
    672d:	b8 00 00 80 00       	mov    $0x800000,%eax
    6732:	85 c9                	test   %ecx,%ecx
    6734:	0f 85 b1 00 00 00    	jne    67eb <fwp_gc_alloc_slow+0x17b>
    673a:	48 8b 0d 4f cc 00 00 	mov    0xcc4f(%rip),%rcx        # 13390 <fwp_gc+0x1210>
    6741:	48 2b 0d 38 ba 00 00 	sub    0xba38(%rip),%rcx        # 12180 <fwp_gc>
    6748:	f2 48 0f 2a c1       	cvtsi2sd %rcx,%xmm0
    674d:	f2 0f 58 05 13 cc 00 	addsd  0xcc13(%rip),%xmm0        # 13368 <fwp_gc+0x11e8>
    6754:	00 
    6755:	f2 0f 11 05 0b cc 00 	movsd  %xmm0,0xcc0b(%rip)        # 13368 <fwp_gc+0x11e8>
    675c:	00 
    675d:	48 89 05 2c cc 00 00 	mov    %rax,0xcc2c(%rip)        # 13390 <fwp_gc+0x1210>
    6764:	48 89 05 15 ba 00 00 	mov    %rax,0xba15(%rip)        # 12180 <fwp_gc>
    676b:	89 d8                	mov    %ebx,%eax
    676d:	48 69 c0 c0 03 00 00 	imul   $0x3c0,%rax,%rax
    6774:	49 01 c7             	add    %rax,%r15
    6777:	4b 8d 34 76          	lea    (%r14,%r14,2),%rsi
    677b:	49 8d 0c f7          	lea    (%r15,%rsi,8),%rcx
    677f:	48 83 c1 08          	add    $0x8,%rcx
    6783:	49 8b 44 f7 08       	mov    0x8(%r15,%rsi,8),%rax
    6788:	48 85 c0             	test   %rax,%rax
    678b:	74 08                	je     6795 <fwp_gc_alloc_slow+0x125>
    678d:	48 8b 30             	mov    (%rax),%rsi
    6790:	48 f7 d6             	not    %rsi
    6793:	eb 39                	jmp    67ce <fwp_gc_alloc_slow+0x15e>
    6795:	49 8b 44 f7 10       	mov    0x10(%r15,%rsi,8),%rax
    679a:	4d 8b 44 f7 18       	mov    0x18(%r15,%rsi,8),%r8
    679f:	49 29 c0             	sub    %rax,%r8
    67a2:	49 39 d0             	cmp    %rdx,%r8
    67a5:	73 1b                	jae    67c2 <fwp_gc_alloc_slow+0x152>
    67a7:	49 89 ff             	mov    %rdi,%r15
    67aa:	48 89 cf             	mov    %rcx,%rdi
    67ad:	44 89 f6             	mov    %r14d,%esi
    67b0:	49 89 d6             	mov    %rdx,%r14
    67b3:	89 da                	mov    %ebx,%edx
    67b5:	e8 46 07 00 00       	call   6f00 <fwp_gc_refill>
    67ba:	4c 89 f2             	mov    %r14,%rdx
    67bd:	4c 89 ff             	mov    %r15,%rdi
    67c0:	eb 0f                	jmp    67d1 <fwp_gc_alloc_slow+0x161>
    67c2:	49 8d 0c f7          	lea    (%r15,%rsi,8),%rcx
    67c6:	48 83 c1 10          	add    $0x10,%rcx
    67ca:	48 8d 34 10          	lea    (%rax,%rdx,1),%rsi
    67ce:	48 89 31             	mov    %rsi,(%rcx)
    67d1:	83 fb 01             	cmp    $0x1,%ebx
    67d4:	48 0f 44 d7          	cmove  %rdi,%rdx
    67d8:	48 89 c7             	mov    %rax,%rdi
    67db:	31 f6                	xor    %esi,%esi
    67dd:	5b                   	pop    %rbx
    67de:	41 5c                	pop    %r12
    67e0:	41 5d                	pop    %r13
    67e2:	41 5e                	pop    %r14
    67e4:	41 5f                	pop    %r15
    67e6:	e9 45 b9 ff ff       	jmp    2130 <memset@plt>
    67eb:	e8 d0 09 00 00       	call   71c0 <fwp_gc_collect>
    67f0:	48 c7 05 ad c9 00 00 	movq   $0x0,0xc9ad(%rip)        # 131a8 <fwp_gc+0x1028>
    67f7:	00 00 00 00 
    67fb:	e8 c0 09 00 00       	call   71c0 <fwp_gc_collect>

0000000000006800 <fwp_gc_init>:
    6800:	41 56                	push   %r14
    6802:	53                   	push   %rbx
    6803:	50                   	push   %rax
    6804:	c7 05 5e c9 00 00 01 	movl   $0x1,0xc95e(%rip)        # 1316c <fwp_gc+0xfec>
    680b:	00 00 00 
    680e:	0f 28 05 1b 88 00 00 	movaps 0x881b(%rip),%xmm0        # f030 <_IO_stdin_used+0x30>
    6815:	0f 11 05 ac c4 00 00 	movups %xmm0,0xc4ac(%rip)        # 12cc8 <fwp_gc+0xb48>
    681c:	0f 28 05 1d 88 00 00 	movaps 0x881d(%rip),%xmm0        # f040 <_IO_stdin_used+0x40>
    6823:	0f 11 05 ae c4 00 00 	movups %xmm0,0xc4ae(%rip)        # 12cd8 <fwp_gc+0xb58>
    682a:	0f 28 05 1f 88 00 00 	movaps 0x881f(%rip),%xmm0        # f050 <_IO_stdin_used+0x50>
    6831:	0f 11 05 b0 c4 00 00 	movups %xmm0,0xc4b0(%rip)        # 12ce8 <fwp_gc+0xb68>
    6838:	0f 28 05 21 88 00 00 	movaps 0x8821(%rip),%xmm0        # f060 <_IO_stdin_used+0x60>
    683f:	0f 11 05 b2 c4 00 00 	movups %xmm0,0xc4b2(%rip)        # 12cf8 <fwp_gc+0xb78>
    6846:	0f 28 05 23 88 00 00 	movaps 0x8823(%rip),%xmm0        # f070 <_IO_stdin_used+0x70>
    684d:	0f 11 05 b4 c4 00 00 	movups %xmm0,0xc4b4(%rip)        # 12d08 <fwp_gc+0xb88>
    6854:	0f 28 05 25 88 00 00 	movaps 0x8825(%rip),%xmm0        # f080 <_IO_stdin_used+0x80>
    685b:	0f 11 05 b6 c4 00 00 	movups %xmm0,0xc4b6(%rip)        # 12d18 <fwp_gc+0xb98>
    6862:	0f 28 05 27 88 00 00 	movaps 0x8827(%rip),%xmm0        # f090 <_IO_stdin_used+0x90>
    6869:	0f 11 05 b8 c4 00 00 	movups %xmm0,0xc4b8(%rip)        # 12d28 <fwp_gc+0xba8>
    6870:	0f 28 05 29 88 00 00 	movaps 0x8829(%rip),%xmm0        # f0a0 <_IO_stdin_used+0xa0>
    6877:	0f 11 05 ba c4 00 00 	movups %xmm0,0xc4ba(%rip)        # 12d38 <fwp_gc+0xbb8>
    687e:	0f 28 05 2b 88 00 00 	movaps 0x882b(%rip),%xmm0        # f0b0 <_IO_stdin_used+0xb0>
    6885:	0f 11 05 bc c4 00 00 	movups %xmm0,0xc4bc(%rip)        # 12d48 <fwp_gc+0xbc8>
    688c:	0f 28 05 2d 88 00 00 	movaps 0x882d(%rip),%xmm0        # f0c0 <_IO_stdin_used+0xc0>
    6893:	0f 11 05 be c4 00 00 	movups %xmm0,0xc4be(%rip)        # 12d58 <fwp_gc+0xbd8>
    689a:	31 c9                	xor    %ecx,%ecx
    689c:	48 8d 05 dd b8 00 00 	lea    0xb8dd(%rip),%rax        # 12180 <fwp_gc>
    68a3:	31 d2                	xor    %edx,%edx
    68a5:	66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
    68ac:	00 00 00 00 
    68b0:	89 d6                	mov    %edx,%esi
    68b2:	c1 e6 04             	shl    $0x4,%esi
    68b5:	48 ff c9             	dec    %rcx
    68b8:	48 89 cf             	mov    %rcx,%rdi
    68bb:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)
    68c0:	48 89 f9             	mov    %rdi,%rcx
    68c3:	48 ff c7             	inc    %rdi
    68c6:	3b b4 88 4c 0b 00 00 	cmp    0xb4c(%rax,%rcx,4),%esi
    68cd:	77 f1                	ja     68c0 <fwp_gc_init+0xc0>
    68cf:	40 88 bc 02 e8 0b 00 	mov    %dil,0xbe8(%rdx,%rax,1)
    68d6:	00 
    68d7:	48 89 d6             	mov    %rdx,%rsi
    68da:	48 83 ce 01          	or     $0x1,%rsi
    68de:	48 81 fe 01 04 00 00 	cmp    $0x401,%rsi
    68e5:	74 26                	je     690d <fwp_gc_init+0x10d>
    68e7:	89 f7                	mov    %esi,%edi
    68e9:	c1 e7 04             	shl    $0x4,%edi
    68ec:	0f 1f 40 00          	nopl   0x0(%rax)
    68f0:	49 89 c8             	mov    %rcx,%r8
    68f3:	48 ff c1             	inc    %rcx
    68f6:	42 3b bc 80 4c 0b 00 	cmp    0xb4c(%rax,%r8,4),%edi
    68fd:	00 
    68fe:	77 f0                	ja     68f0 <fwp_gc_init+0xf0>
    6900:	88 8c 06 e8 0b 00 00 	mov    %cl,0xbe8(%rsi,%rax,1)
    6907:	48 83 c2 02          	add    $0x2,%rdx
    690b:	eb a3                	jmp    68b0 <fwp_gc_init+0xb0>
    690d:	48 bb 00 00 00 00 10 	movabs $0x1000000000,%rbx
    6914:	00 00 00 
    6917:	48 8d b3 00 00 01 00 	lea    0x10000(%rbx),%rsi
    691e:	31 ff                	xor    %edi,%edi
    6920:	31 d2                	xor    %edx,%edx
    6922:	b9 22 40 00 00       	mov    $0x4022,%ecx
    6927:	41 b8 ff ff ff ff    	mov    $0xffffffff,%r8d
    692d:	45 31 c9             	xor    %r9d,%r9d
    6930:	e8 bb b7 ff ff       	call   20f0 <mmap@plt>
    6935:	48 83 f8 ff          	cmp    $0xffffffffffffffff,%rax
    6939:	75 60                	jne    699b <fwp_gc_init+0x19b>
    693b:	48 bb 00 00 00 00 04 	movabs $0x400000000,%rbx
    6942:	00 00 00 
    6945:	48 8d b3 00 00 01 00 	lea    0x10000(%rbx),%rsi
    694c:	31 ff                	xor    %edi,%edi
    694e:	31 d2                	xor    %edx,%edx
    6950:	b9 22 40 00 00       	mov    $0x4022,%ecx
    6955:	41 b8 ff ff ff ff    	mov    $0xffffffff,%r8d
    695b:	45 31 c9             	xor    %r9d,%r9d
    695e:	e8 8d b7 ff ff       	call   20f0 <mmap@plt>
    6963:	48 83 f8 ff          	cmp    $0xffffffffffffffff,%rax
    6967:	75 32                	jne    699b <fwp_gc_init+0x19b>
    6969:	48 bb 00 00 00 00 01 	movabs $0x100000000,%rbx
    6970:	00 00 00 
    6973:	48 8d b3 00 00 01 00 	lea    0x10000(%rbx),%rsi
    697a:	31 ff                	xor    %edi,%edi
    697c:	31 d2                	xor    %edx,%edx
    697e:	b9 22 40 00 00       	mov    $0x4022,%ecx
    6983:	41 b8 ff ff ff ff    	mov    $0xffffffff,%r8d
    6989:	45 31 c9             	xor    %r9d,%r9d
    698c:	e8 5f b7 ff ff       	call   20f0 <mmap@plt>
    6991:	48 83 f8 ff          	cmp    $0xffffffffffffffff,%rax
    6995:	0f 84 4e 02 00 00    	je     6be9 <fwp_gc_init+0x3e9>
    699b:	48 85 c0             	test   %rax,%rax
    699e:	0f 84 a6 02 00 00    	je     6c4a <fwp_gc_init+0x44a>
    69a4:	48 89 05 0d c8 00 00 	mov    %rax,0xc80d(%rip)        # 131b8 <fwp_gc+0x1038>
    69ab:	48 89 d9             	mov    %rbx,%rcx
    69ae:	48 81 c9 00 00 01 00 	or     $0x10000,%rcx
    69b5:	48 89 0d 04 c8 00 00 	mov    %rcx,0xc804(%rip)        # 131c0 <fwp_gc+0x1040>
    69bc:	48 05 ff ff 00 00    	add    $0xffff,%rax
    69c2:	48 25 00 00 ff ff    	and    $0xffffffffffff0000,%rax
    69c8:	48 89 05 e1 c7 00 00 	mov    %rax,0xc7e1(%rip)        # 131b0 <fwp_gc+0x1030>
    69cf:	48 c1 eb 10          	shr    $0x10,%rbx
    69d3:	48 89 1d f6 c7 00 00 	mov    %rbx,0xc7f6(%rip)        # 131d0 <fwp_gc+0x1050>
    69da:	48 69 f3 28 12 00 00 	imul   $0x1228,%rbx,%rsi
    69e1:	48 89 35 18 c8 00 00 	mov    %rsi,0xc818(%rip)        # 13200 <fwp_gc+0x1080>
    69e8:	31 ff                	xor    %edi,%edi
    69ea:	31 d2                	xor    %edx,%edx
    69ec:	b9 22 40 00 00       	mov    $0x4022,%ecx
    69f1:	41 b8 ff ff ff ff    	mov    $0xffffffff,%r8d
    69f7:	45 31 c9             	xor    %r9d,%r9d
    69fa:	e8 f1 b6 ff ff       	call   20f0 <mmap@plt>
    69ff:	48 83 f8 ff          	cmp    $0xffffffffffffffff,%rax
    6a03:	0f 84 41 02 00 00    	je     6c4a <fwp_gc_init+0x44a>
    6a09:	48 89 05 e8 c7 00 00 	mov    %rax,0xc7e8(%rip)        # 131f8 <fwp_gc+0x1078>
    6a10:	48 8d 3d 5c 8a 00 00 	lea    0x8a5c(%rip),%rdi        # f473 <fwp_segv.msg+0x233>
    6a17:	e8 14 b6 ff ff       	call   2030 <getenv@plt>
    6a1c:	48 85 c0             	test   %rax,%rax
    6a1f:	74 2e                	je     6a4f <fwp_gc_init+0x24f>
    6a21:	48 89 c3             	mov    %rax,%rbx
    6a24:	48 8d 35 4f 8a 00 00 	lea    0x8a4f(%rip),%rsi        # f47a <fwp_segv.msg+0x23a>
    6a2b:	48 89 c7             	mov    %rax,%rdi
    6a2e:	e8 4d b7 ff ff       	call   2180 <strcmp@plt>
    6a33:	85 c0                	test   %eax,%eax
    6a35:	74 1f                	je     6a56 <fwp_gc_init+0x256>
    6a37:	48 8d 35 24 8c 00 00 	lea    0x8c24(%rip),%rsi        # f662 <fwp_segv.msg+0x422>
    6a3e:	48 89 df             	mov    %rbx,%rdi
    6a41:	e8 3a b7 ff ff       	call   2180 <strcmp@plt>
    6a46:	31 c9                	xor    %ecx,%ecx
    6a48:	85 c0                	test   %eax,%eax
    6a4a:	0f 95 c1             	setne  %cl
    6a4d:	eb 09                	jmp    6a58 <fwp_gc_init+0x258>
    6a4f:	b9 01 00 00 00       	mov    $0x1,%ecx
    6a54:	eb 02                	jmp    6a58 <fwp_gc_init+0x258>
    6a56:	31 c9                	xor    %ecx,%ecx
    6a58:	89 0d 12 c7 00 00    	mov    %ecx,0xc712(%rip)        # 13170 <fwp_gc+0xff0>
    6a5e:	48 8d 3d 19 8a 00 00 	lea    0x8a19(%rip),%rdi        # f47e <fwp_segv.msg+0x23e>
    6a65:	e8 c6 b5 ff ff       	call   2030 <getenv@plt>
    6a6a:	31 c9                	xor    %ecx,%ecx
    6a6c:	48 85 c0             	test   %rax,%rax
    6a6f:	74 1b                	je     6a8c <fwp_gc_init+0x28c>
    6a71:	80 38 00             	cmpb   $0x0,(%rax)
    6a74:	74 16                	je     6a8c <fwp_gc_init+0x28c>
    6a76:	48 8d 35 e5 8b 00 00 	lea    0x8be5(%rip),%rsi        # f662 <fwp_segv.msg+0x422>
    6a7d:	48 89 c7             	mov    %rax,%rdi
    6a80:	e8 fb b6 ff ff       	call   2180 <strcmp@plt>
    6a85:	31 c9                	xor    %ecx,%ecx
    6a87:	85 c0                	test   %eax,%eax
    6a89:	0f 95 c1             	setne  %cl
    6a8c:	89 0d ea c6 00 00    	mov    %ecx,0xc6ea(%rip)        # 1317c <fwp_gc+0xffc>
    6a92:	48 8d 3d da 89 00 00 	lea    0x89da(%rip),%rdi        # f473 <fwp_segv.msg+0x233>
    6a99:	e8 92 b5 ff ff       	call   2030 <getenv@plt>
    6a9e:	48 85 c0             	test   %rax,%rax
    6aa1:	74 18                	je     6abb <fwp_gc_init+0x2bb>
    6aa3:	48 8d 35 e1 89 00 00 	lea    0x89e1(%rip),%rsi        # f48b <fwp_segv.msg+0x24b>
    6aaa:	48 89 c7             	mov    %rax,%rdi
    6aad:	e8 ce b6 ff ff       	call   2180 <strcmp@plt>
    6ab2:	31 c9                	xor    %ecx,%ecx
    6ab4:	85 c0                	test   %eax,%eax
    6ab6:	0f 95 c1             	setne  %cl
    6ab9:	eb 05                	jmp    6ac0 <fwp_gc_init+0x2c0>
    6abb:	b9 01 00 00 00       	mov    $0x1,%ecx
    6ac0:	89 0d ba c6 00 00    	mov    %ecx,0xc6ba(%rip)        # 13180 <fwp_gc+0x1000>
    6ac6:	c7 05 b8 c6 00 00 01 	movl   $0x1,0xc6b8(%rip)        # 13188 <fwp_gc+0x1008>
    6acd:	00 00 00 
    6ad0:	48 8d 3d b9 89 00 00 	lea    0x89b9(%rip),%rdi        # f490 <fwp_segv.msg+0x250>
    6ad7:	e8 54 b5 ff ff       	call   2030 <getenv@plt>
    6adc:	31 c9                	xor    %ecx,%ecx
    6ade:	48 85 c0             	test   %rax,%rax
    6ae1:	74 1b                	je     6afe <fwp_gc_init+0x2fe>
    6ae3:	80 38 00             	cmpb   $0x0,(%rax)
    6ae6:	74 16                	je     6afe <fwp_gc_init+0x2fe>
    6ae8:	48 8d 35 73 8b 00 00 	lea    0x8b73(%rip),%rsi        # f662 <fwp_segv.msg+0x422>
    6aef:	48 89 c7             	mov    %rax,%rdi
    6af2:	e8 89 b6 ff ff       	call   2180 <strcmp@plt>
    6af7:	31 c9                	xor    %ecx,%ecx
    6af9:	85 c0                	test   %eax,%eax
    6afb:	0f 95 c1             	setne  %cl
    6afe:	89 0d 80 c6 00 00    	mov    %ecx,0xc680(%rip)        # 13184 <fwp_gc+0x1004>
    6b04:	48 8d 3d 93 89 00 00 	lea    0x8993(%rip),%rdi        # f49e <fwp_segv.msg+0x25e>
    6b0b:	e8 20 b5 ff ff       	call   2030 <getenv@plt>
    6b10:	48 85 c0             	test   %rax,%rax
    6b13:	74 14                	je     6b29 <fwp_gc_init+0x329>
    6b15:	48 89 c7             	mov    %rax,%rdi
    6b18:	31 f6                	xor    %esi,%esi
    6b1a:	ba 0a 00 00 00       	mov    $0xa,%edx
    6b1f:	e8 ac b6 ff ff       	call   21d0 <strtol@plt>
    6b24:	48 89 c3             	mov    %rax,%rbx
    6b27:	eb 02                	jmp    6b2b <fwp_gc_init+0x32b>
    6b29:	31 db                	xor    %ebx,%ebx
    6b2b:	31 c0                	xor    %eax,%eax
    6b2d:	48 85 db             	test   %rbx,%rbx
    6b30:	48 0f 4f c3          	cmovg  %rbx,%rax
    6b34:	48 89 05 65 c6 00 00 	mov    %rax,0xc665(%rip)        # 131a0 <fwp_gc+0x1020>
    6b3b:	48 8d 3d 31 89 00 00 	lea    0x8931(%rip),%rdi        # f473 <fwp_segv.msg+0x233>
    6b42:	e8 e9 b4 ff ff       	call   2030 <getenv@plt>
    6b47:	48 85 c0             	test   %rax,%rax
    6b4a:	74 32                	je     6b7e <fwp_gc_init+0x37e>
    6b4c:	49 89 c6             	mov    %rax,%r14
    6b4f:	80 38 00             	cmpb   $0x0,(%rax)
    6b52:	74 2a                	je     6b7e <fwp_gc_init+0x37e>
    6b54:	48 8d 35 1f 89 00 00 	lea    0x891f(%rip),%rsi        # f47a <fwp_segv.msg+0x23a>
    6b5b:	4c 89 f7             	mov    %r14,%rdi
    6b5e:	e8 1d b6 ff ff       	call   2180 <strcmp@plt>
    6b63:	85 c0                	test   %eax,%eax
    6b65:	74 17                	je     6b7e <fwp_gc_init+0x37e>
    6b67:	48 8d 35 f4 8a 00 00 	lea    0x8af4(%rip),%rsi        # f662 <fwp_segv.msg+0x422>
    6b6e:	4c 89 f7             	mov    %r14,%rdi
    6b71:	e8 0a b6 ff ff       	call   2180 <strcmp@plt>
    6b76:	85 c0                	test   %eax,%eax
    6b78:	0f 85 f6 00 00 00    	jne    6c74 <fwp_gc_init+0x474>
    6b7e:	48 85 db             	test   %rbx,%rbx
    6b81:	0f 8f ed 00 00 00    	jg     6c74 <fwp_gc_init+0x474>
    6b87:	83 3d f6 c5 00 00 00 	cmpl   $0x0,0xc5f6(%rip)        # 13184 <fwp_gc+0x1004>
    6b8e:	0f 85 e0 00 00 00    	jne    6c74 <fwp_gc_init+0x474>
    6b94:	48 8d 3d 4e 89 00 00 	lea    0x894e(%rip),%rdi        # f4e9 <fwp_segv.msg+0x2a9>
    6b9b:	e8 90 b4 ff ff       	call   2030 <getenv@plt>
    6ba0:	48 85 c0             	test   %rax,%rax
    6ba3:	74 1c                	je     6bc1 <fwp_gc_init+0x3c1>
    6ba5:	80 38 00             	cmpb   $0x0,(%rax)
    6ba8:	74 17                	je     6bc1 <fwp_gc_init+0x3c1>
    6baa:	48 8d 35 b1 8a 00 00 	lea    0x8ab1(%rip),%rsi        # f662 <fwp_segv.msg+0x422>
    6bb1:	48 89 c7             	mov    %rax,%rdi
    6bb4:	e8 c7 b5 ff ff       	call   2180 <strcmp@plt>
    6bb9:	85 c0                	test   %eax,%eax
    6bbb:	0f 85 e1 00 00 00    	jne    6ca2 <fwp_gc_init+0x4a2>
    6bc1:	c7 05 a5 c5 00 00 00 	movl   $0x0,0xc5a5(%rip)        # 13170 <fwp_gc+0xff0>
    6bc8:	00 00 00 
    6bcb:	48 c7 05 ba c7 00 00 	movq   $0x800000,0xc7ba(%rip)        # 13390 <fwp_gc+0x1210>
    6bd2:	00 00 80 00 
    6bd6:	48 c7 05 9f b5 00 00 	movq   $0x800000,0xb59f(%rip)        # 12180 <fwp_gc>
    6bdd:	00 00 80 00 
    6be1:	48 83 c4 08          	add    $0x8,%rsp
    6be5:	5b                   	pop    %rbx
    6be6:	41 5e                	pop    %r14
    6be8:	c3                   	ret
    6be9:	be 00 00 01 40       	mov    $0x40010000,%esi
    6bee:	31 ff                	xor    %edi,%edi
    6bf0:	31 d2                	xor    %edx,%edx
    6bf2:	b9 22 40 00 00       	mov    $0x4022,%ecx
    6bf7:	41 b8 ff ff ff ff    	mov    $0xffffffff,%r8d
    6bfd:	45 31 c9             	xor    %r9d,%r9d
    6c00:	e8 eb b4 ff ff       	call   20f0 <mmap@plt>
    6c05:	48 83 f8 ff          	cmp    $0xffffffffffffffff,%rax
    6c09:	74 0f                	je     6c1a <fwp_gc_init+0x41a>
    6c0b:	48 85 c0             	test   %rax,%rax
    6c0e:	74 3a                	je     6c4a <fwp_gc_init+0x44a>
    6c10:	bb 00 00 00 40       	mov    $0x40000000,%ebx
    6c15:	e9 8a fd ff ff       	jmp    69a4 <fwp_gc_init+0x1a4>
    6c1a:	be 00 00 01 10       	mov    $0x10010000,%esi
    6c1f:	31 ff                	xor    %edi,%edi
    6c21:	31 d2                	xor    %edx,%edx
    6c23:	b9 22 40 00 00       	mov    $0x4022,%ecx
    6c28:	41 b8 ff ff ff ff    	mov    $0xffffffff,%r8d
    6c2e:	45 31 c9             	xor    %r9d,%r9d
    6c31:	e8 ba b4 ff ff       	call   20f0 <mmap@plt>
    6c36:	48 8d 48 01          	lea    0x1(%rax),%rcx
    6c3a:	48 83 f9 02          	cmp    $0x2,%rcx
    6c3e:	72 0a                	jb     6c4a <fwp_gc_init+0x44a>
    6c40:	bb 00 00 00 10       	mov    $0x10000000,%ebx
    6c45:	e9 5a fd ff ff       	jmp    69a4 <fwp_gc_init+0x1a4>
    6c4a:	48 8b 05 8f b3 00 00 	mov    0xb38f(%rip),%rax        # 11fe0 <stderr@GLIBC_2.2.5>
    6c51:	48 8b 08             	mov    (%rax),%rcx
    6c54:	48 8d 3d de 88 00 00 	lea    0x88de(%rip),%rdi        # f539 <fwp_segv.msg+0x2f9>
    6c5b:	be 13 00 00 00       	mov    $0x13,%esi
    6c60:	ba 01 00 00 00       	mov    $0x1,%edx
    6c65:	e8 36 b6 ff ff       	call   22a0 <fwrite@plt>
    6c6a:	bf 66 00 00 00       	mov    $0x66,%edi
    6c6f:	e8 1c b6 ff ff       	call   2290 <exit@plt>
    6c74:	e8 a7 f5 ff ff       	call   6220 <fwp_flush>
    6c79:	48 8b 05 60 b3 00 00 	mov    0xb360(%rip),%rax        # 11fe0 <stderr@GLIBC_2.2.5>
    6c80:	48 8b 38             	mov    (%rax),%rdi
    6c83:	48 8d 35 a3 87 00 00 	lea    0x87a3(%rip),%rsi        # f42d <fwp_segv.msg+0x1ed>
    6c8a:	48 8d 15 1b 88 00 00 	lea    0x881b(%rip),%rdx        # f4ac <fwp_segv.msg+0x26c>
    6c91:	31 c0                	xor    %eax,%eax
    6c93:	e8 18 b5 ff ff       	call   21b0 <fprintf@plt>
    6c98:	bf 65 00 00 00       	mov    $0x65,%edi
    6c9d:	e8 ee b5 ff ff       	call   2290 <exit@plt>
    6ca2:	e8 79 f5 ff ff       	call   6220 <fwp_flush>
    6ca7:	48 8b 05 32 b3 00 00 	mov    0xb332(%rip),%rax        # 11fe0 <stderr@GLIBC_2.2.5>
    6cae:	48 8b 38             	mov    (%rax),%rdi
    6cb1:	48 8d 35 75 87 00 00 	lea    0x8775(%rip),%rsi        # f42d <fwp_segv.msg+0x1ed>
    6cb8:	48 8d 15 3b 88 00 00 	lea    0x883b(%rip),%rdx        # f4fa <fwp_segv.msg+0x2ba>
    6cbf:	eb d0                	jmp    6c91 <fwp_gc_init+0x491>
    6cc1:	66 66 66 66 66 66 2e 	data16 data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    6cc8:	0f 1f 84 00 00 00 00 
    6ccf:	00 

0000000000006cd0 <fwp_gc_alloc_big>:
    6cd0:	55                   	push   %rbp
    6cd1:	41 57                	push   %r15
    6cd3:	41 56                	push   %r14
    6cd5:	41 55                	push   %r13
    6cd7:	41 54                	push   %r12
    6cd9:	53                   	push   %rbx
    6cda:	50                   	push   %rax
    6cdb:	48 b8 01 00 00 00 00 	movabs $0x4000000000000001,%rax
    6ce2:	00 00 40 
    6ce5:	48 39 c7             	cmp    %rax,%rdi
    6ce8:	0f 83 ce 01 00 00    	jae    6ebc <fwp_gc_alloc_big+0x1ec>
    6cee:	89 f5                	mov    %esi,%ebp
    6cf0:	48 89 fb             	mov    %rdi,%rbx
    6cf3:	48 29 3d 86 b4 00 00 	sub    %rdi,0xb486(%rip)        # 12180 <fwp_gc>
    6cfa:	0f 89 80 00 00 00    	jns    6d80 <fwp_gc_alloc_big+0xb0>
    6d00:	83 3d 65 c4 00 00 00 	cmpl   $0x0,0xc465(%rip)        # 1316c <fwp_gc+0xfec>
    6d07:	75 05                	jne    6d0e <fwp_gc_alloc_big+0x3e>
    6d09:	e8 f2 fa ff ff       	call   6800 <fwp_gc_init>
    6d0e:	8b 0d 60 c4 00 00    	mov    0xc460(%rip),%ecx        # 13174 <fwp_gc+0xff4>
    6d14:	85 c9                	test   %ecx,%ecx
    6d16:	74 2a                	je     6d42 <fwp_gc_alloc_big+0x72>
    6d18:	48 8b 05 81 c4 00 00 	mov    0xc481(%rip),%rax        # 131a0 <fwp_gc+0x1020>
    6d1f:	48 85 c0             	test   %rax,%rax
    6d22:	74 1e                	je     6d42 <fwp_gc_alloc_big+0x72>
    6d24:	48 8b 0d 7d c4 00 00 	mov    0xc47d(%rip),%rcx        # 131a8 <fwp_gc+0x1028>
    6d2b:	48 ff c1             	inc    %rcx
    6d2e:	48 89 0d 73 c4 00 00 	mov    %rcx,0xc473(%rip)        # 131a8 <fwp_gc+0x1028>
    6d35:	48 39 c1             	cmp    %rax,%rcx
    6d38:	0f 8d ad 01 00 00    	jge    6eeb <fwp_gc_alloc_big+0x21b>
    6d3e:	31 c0                	xor    %eax,%eax
    6d40:	eb 0d                	jmp    6d4f <fwp_gc_alloc_big+0x7f>
    6d42:	b8 00 00 80 00       	mov    $0x800000,%eax
    6d47:	85 c9                	test   %ecx,%ecx
    6d49:	0f 85 97 01 00 00    	jne    6ee6 <fwp_gc_alloc_big+0x216>
    6d4f:	48 8b 0d 3a c6 00 00 	mov    0xc63a(%rip),%rcx        # 13390 <fwp_gc+0x1210>
    6d56:	48 2b 0d 23 b4 00 00 	sub    0xb423(%rip),%rcx        # 12180 <fwp_gc>
    6d5d:	f2 48 0f 2a c1       	cvtsi2sd %rcx,%xmm0
    6d62:	f2 0f 58 05 fe c5 00 	addsd  0xc5fe(%rip),%xmm0        # 13368 <fwp_gc+0x11e8>
    6d69:	00 
    6d6a:	f2 0f 11 05 f6 c5 00 	movsd  %xmm0,0xc5f6(%rip)        # 13368 <fwp_gc+0x11e8>
    6d71:	00 
    6d72:	48 89 05 17 c6 00 00 	mov    %rax,0xc617(%rip)        # 13390 <fwp_gc+0x1210>
    6d79:	48 89 05 00 b4 00 00 	mov    %rax,0xb400(%rip)        # 12180 <fwp_gc>
    6d80:	4c 8d b3 ff ff 00 00 	lea    0xffff(%rbx),%r14
    6d87:	49 c1 ee 10          	shr    $0x10,%r14
    6d8b:	4c 89 f7             	mov    %r14,%rdi
    6d8e:	e8 9d 02 00 00       	call   7030 <fwp_gc_chunks>
    6d93:	48 8b 0d 5e c4 00 00 	mov    0xc45e(%rip),%rcx        # 131f8 <fwp_gc+0x1078>
    6d9a:	4c 69 e0 28 12 00 00 	imul   $0x1228,%rax,%r12
    6da1:	42 c6 04 21 02       	movb   $0x2,(%rcx,%r12,1)
    6da6:	42 88 6c 21 01       	mov    %bpl,0x1(%rcx,%r12,1)
    6dab:	66 42 c7 44 21 03 00 	movw   $0x100,0x3(%rcx,%r12,1)
    6db2:	01 
    6db3:	46 89 74 21 10       	mov    %r14d,0x10(%rcx,%r12,1)
    6db8:	4a 89 5c 21 18       	mov    %rbx,0x18(%rcx,%r12,1)
    6dbd:	4e 8d 3c 21          	lea    (%rcx,%r12,1),%r15
    6dc1:	49 81 c7 28 02 00 00 	add    $0x228,%r15
    6dc8:	42 80 bc 21 28 02 00 	cmpb   $0xff,0x228(%rcx,%r12,1)
    6dcf:	00 ff 
    6dd1:	0f 84 d2 00 00 00    	je     6ea9 <fwp_gc_alloc_big+0x1d9>
    6dd7:	41 c6 07 00          	movb   $0x0,(%r15)
    6ddb:	48 81 fb 01 00 01 00 	cmp    $0x10001,%rbx
    6de2:	0f 82 9b 00 00 00    	jb     6e83 <fwp_gc_alloc_big+0x1b3>
    6de8:	49 83 fe 03          	cmp    $0x3,%r14
    6dec:	ba 02 00 00 00       	mov    $0x2,%edx
    6df1:	49 0f 43 d6          	cmovae %r14,%rdx
    6df5:	48 8b 0d fc c3 00 00 	mov    0xc3fc(%rip),%rcx        # 131f8 <fwp_gc+0x1078>
    6dfc:	48 ff ca             	dec    %rdx
    6dff:	be 01 00 00 00       	mov    $0x1,%esi
    6e04:	48 81 fb 01 00 02 00 	cmp    $0x20001,%rbx
    6e0b:	72 5a                	jb     6e67 <fwp_gc_alloc_big+0x197>
    6e0d:	49 8d 3c 0c          	lea    (%r12,%rcx,1),%rdi
    6e11:	48 81 c7 60 24 00 00 	add    $0x2460,%rdi
    6e18:	49 89 d0             	mov    %rdx,%r8
    6e1b:	49 83 e0 fe          	and    $0xfffffffffffffffe,%r8
    6e1f:	49 f7 d8             	neg    %r8
    6e22:	66 66 66 66 66 2e 0f 	data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    6e29:	1f 84 00 00 00 00 00 
    6e30:	c6 87 c8 ed ff ff 03 	movb   $0x3,-0x1238(%rdi)
    6e37:	c6 87 cc ed ff ff 01 	movb   $0x1,-0x1234(%rdi)
    6e3e:	89 87 d8 ed ff ff    	mov    %eax,-0x1228(%rdi)
    6e44:	c6 47 f0 03          	movb   $0x3,-0x10(%rdi)
    6e48:	c6 47 f4 01          	movb   $0x1,-0xc(%rdi)
    6e4c:	89 07                	mov    %eax,(%rdi)
    6e4e:	48 81 c7 50 24 00 00 	add    $0x2450,%rdi
    6e55:	4d 8d 0c 30          	lea    (%r8,%rsi,1),%r9
    6e59:	49 83 c1 02          	add    $0x2,%r9
    6e5d:	48 83 c6 02          	add    $0x2,%rsi
    6e61:	49 83 f9 01          	cmp    $0x1,%r9
    6e65:	75 c9                	jne    6e30 <fwp_gc_alloc_big+0x160>
    6e67:	f6 c2 01             	test   $0x1,%dl
    6e6a:	74 17                	je     6e83 <fwp_gc_alloc_big+0x1b3>
    6e6c:	4c 01 e1             	add    %r12,%rcx
    6e6f:	48 69 d6 28 12 00 00 	imul   $0x1228,%rsi,%rdx
    6e76:	c6 04 11 03          	movb   $0x3,(%rcx,%rdx,1)
    6e7a:	c6 44 11 04 01       	movb   $0x1,0x4(%rcx,%rdx,1)
    6e7f:	89 44 11 10          	mov    %eax,0x10(%rcx,%rdx,1)
    6e83:	48 c1 e0 10          	shl    $0x10,%rax
    6e87:	48 03 05 22 c3 00 00 	add    0xc322(%rip),%rax        # 131b0 <fwp_gc+0x1030>
    6e8e:	48 89 c7             	mov    %rax,%rdi
    6e91:	31 f6                	xor    %esi,%esi
    6e93:	48 89 da             	mov    %rbx,%rdx
    6e96:	48 83 c4 08          	add    $0x8,%rsp
    6e9a:	5b                   	pop    %rbx
    6e9b:	41 5c                	pop    %r12
    6e9d:	41 5d                	pop    %r13
    6e9f:	41 5e                	pop    %r14
    6ea1:	41 5f                	pop    %r15
    6ea3:	5d                   	pop    %rbp
    6ea4:	e9 87 b2 ff ff       	jmp    2130 <memset@plt>
    6ea9:	4c 89 ff             	mov    %r15,%rdi
    6eac:	49 89 c5             	mov    %rax,%r13
    6eaf:	e8 9c f3 ff ff       	call   6250 <fwp_rc_forget_slot>
    6eb4:	4c 89 e8             	mov    %r13,%rax
    6eb7:	e9 1b ff ff ff       	jmp    6dd7 <fwp_gc_alloc_big+0x107>
    6ebc:	48 8b 05 1d b1 00 00 	mov    0xb11d(%rip),%rax        # 11fe0 <stderr@GLIBC_2.2.5>
    6ec3:	48 8b 08             	mov    (%rax),%rcx
    6ec6:	48 8d 3d 6c 86 00 00 	lea    0x866c(%rip),%rdi        # f539 <fwp_segv.msg+0x2f9>
    6ecd:	be 13 00 00 00       	mov    $0x13,%esi
    6ed2:	ba 01 00 00 00       	mov    $0x1,%edx
    6ed7:	e8 c4 b3 ff ff       	call   22a0 <fwrite@plt>
    6edc:	bf 66 00 00 00       	mov    $0x66,%edi
    6ee1:	e8 aa b3 ff ff       	call   2290 <exit@plt>
    6ee6:	e8 d5 02 00 00       	call   71c0 <fwp_gc_collect>
    6eeb:	48 c7 05 b2 c2 00 00 	movq   $0x0,0xc2b2(%rip)        # 131a8 <fwp_gc+0x1028>
    6ef2:	00 00 00 00 
    6ef6:	e8 c5 02 00 00       	call   71c0 <fwp_gc_collect>
    6efb:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)

0000000000006f00 <fwp_gc_refill>:
    6f00:	55                   	push   %rbp
    6f01:	41 57                	push   %r15
    6f03:	41 56                	push   %r14
    6f05:	41 55                	push   %r13
    6f07:	41 54                	push   %r12
    6f09:	53                   	push   %rbx
    6f0a:	50                   	push   %rax
    6f0b:	89 d5                	mov    %edx,%ebp
    6f0d:	41 89 f7             	mov    %esi,%r15d
    6f10:	48 89 fb             	mov    %rdi,%rbx
    6f13:	bf 01 00 00 00       	mov    $0x1,%edi
    6f18:	e8 13 01 00 00       	call   7030 <fwp_gc_chunks>
    6f1d:	49 89 c6             	mov    %rax,%r14
    6f20:	4c 8b 25 d1 c2 00 00 	mov    0xc2d1(%rip),%r12        # 131f8 <fwp_gc+0x1078>
    6f27:	48 8d 05 52 b2 00 00 	lea    0xb252(%rip),%rax        # 12180 <fwp_gc>
    6f2e:	4d 69 ee 28 12 00 00 	imul   $0x1228,%r14,%r13
    6f35:	43 c6 04 2c 01       	movb   $0x1,(%r12,%r13,1)
    6f3a:	43 88 6c 2c 01       	mov    %bpl,0x1(%r12,%r13,1)
    6f3f:	47 88 7c 2c 02       	mov    %r15b,0x2(%r12,%r13,1)
    6f44:	43 c6 44 2c 04 01    	movb   $0x1,0x4(%r12,%r13,1)
    6f4a:	44 89 f9             	mov    %r15d,%ecx
    6f4d:	8b 8c 88 48 0b 00 00 	mov    0xb48(%rax,%rcx,4),%ecx
    6f54:	43 89 4c 2c 08       	mov    %ecx,0x8(%r12,%r13,1)
    6f59:	b8 00 00 01 00       	mov    $0x10000,%eax
    6f5e:	31 d2                	xor    %edx,%edx
    6f60:	f7 f1                	div    %ecx
    6f62:	43 89 44 2c 0c       	mov    %eax,0xc(%r12,%r13,1)
    6f67:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    6f6c:	48 01 c8             	add    %rcx,%rax
    6f6f:	48 0f ba e0 20       	bt     $0x20,%rax
    6f74:	73 07                	jae    6f7d <fwp_gc_refill+0x7d>
    6f76:	31 d2                	xor    %edx,%edx
    6f78:	48 f7 f1             	div    %rcx
    6f7b:	eb 04                	jmp    6f81 <fwp_gc_refill+0x81>
    6f7d:	31 d2                	xor    %edx,%edx
    6f7f:	f7 f1                	div    %ecx
    6f81:	43 89 44 2c 20       	mov    %eax,0x20(%r12,%r13,1)
    6f86:	48 83 3d 0a cc 00 00 	cmpq   $0x0,0xcc0a(%rip)        # 13b98 <fwp_gc+0x1a18>
    6f8d:	00 
    6f8e:	74 2e                	je     6fbe <fwp_gc_refill+0xbe>
    6f90:	4f 8d 3c 2c          	lea    (%r12,%r13,1),%r15
    6f94:	49 81 c7 28 02 00 00 	add    $0x228,%r15
    6f9b:	31 ed                	xor    %ebp,%ebp
    6f9d:	eb 0d                	jmp    6fac <fwp_gc_refill+0xac>
    6f9f:	90                   	nop
    6fa0:	48 ff c5             	inc    %rbp
    6fa3:	48 81 fd 00 10 00 00 	cmp    $0x1000,%rbp
    6faa:	74 12                	je     6fbe <fwp_gc_refill+0xbe>
    6fac:	41 80 3c 2f ff       	cmpb   $0xff,(%r15,%rbp,1)
    6fb1:	75 ed                	jne    6fa0 <fwp_gc_refill+0xa0>
    6fb3:	49 8d 3c 2f          	lea    (%r15,%rbp,1),%rdi
    6fb7:	e8 94 f2 ff ff       	call   6250 <fwp_rc_forget_slot>
    6fbc:	eb e2                	jmp    6fa0 <fwp_gc_refill+0xa0>
    6fbe:	4f 8d 3c 2c          	lea    (%r12,%r13,1),%r15
    6fc2:	49 83 c7 08          	add    $0x8,%r15
    6fc6:	4b 8d 3c 2c          	lea    (%r12,%r13,1),%rdi
    6fca:	48 81 c7 28 02 00 00 	add    $0x228,%rdi
    6fd1:	ba 00 10 00 00       	mov    $0x1000,%edx
    6fd6:	31 f6                	xor    %esi,%esi
    6fd8:	e8 53 b1 ff ff       	call   2130 <memset@plt>
    6fdd:	49 c1 e6 10          	shl    $0x10,%r14
    6fe1:	4c 03 35 c8 c1 00 00 	add    0xc1c8(%rip),%r14        # 131b0 <fwp_gc+0x1030>
    6fe8:	83 3d 95 c1 00 00 00 	cmpl   $0x0,0xc195(%rip)        # 13184 <fwp_gc+0x1004>
    6fef:	74 0f                	je     7000 <fwp_gc_refill+0x100>
    6ff1:	ba 00 00 01 00       	mov    $0x10000,%edx
    6ff6:	4c 89 f7             	mov    %r14,%rdi
    6ff9:	31 f6                	xor    %esi,%esi
    6ffb:	e8 30 b1 ff ff       	call   2130 <memset@plt>
    7000:	41 8b 07             	mov    (%r15),%eax
    7003:	49 8d 0c 06          	lea    (%r14,%rax,1),%rcx
    7007:	48 89 4b 08          	mov    %rcx,0x8(%rbx)
    700b:	41 8b 4f 04          	mov    0x4(%r15),%ecx
    700f:	48 0f af c8          	imul   %rax,%rcx
    7013:	4c 01 f1             	add    %r14,%rcx
    7016:	48 89 4b 10          	mov    %rcx,0x10(%rbx)
    701a:	4c 89 f0             	mov    %r14,%rax
    701d:	48 83 c4 08          	add    $0x8,%rsp
    7021:	5b                   	pop    %rbx
    7022:	41 5c                	pop    %r12
    7024:	41 5d                	pop    %r13
    7026:	41 5e                	pop    %r14
    7028:	41 5f                	pop    %r15
    702a:	5d                   	pop    %rbp
    702b:	c3                   	ret
    702c:	0f 1f 40 00          	nopl   0x0(%rax)

0000000000007030 <fwp_gc_chunks>:
    7030:	41 57                	push   %r15
    7032:	41 56                	push   %r14
    7034:	53                   	push   %rbx
    7035:	48 89 fb             	mov    %rdi,%rbx
    7038:	31 d2                	xor    %edx,%edx
    703a:	48 83 ff 01          	cmp    $0x1,%rdi
    703e:	0f 95 c2             	setne  %dl
    7041:	48 8d 0d 38 b1 00 00 	lea    0xb138(%rip),%rcx        # 12180 <fwp_gc>
    7048:	48 8b 84 d1 68 10 00 	mov    0x1068(%rcx,%rdx,8),%rax
    704f:	00 
    7050:	4c 8b 35 81 c1 00 00 	mov    0xc181(%rip),%r14        # 131d8 <fwp_gc+0x1058>
    7057:	48 89 c7             	mov    %rax,%rdi
    705a:	4c 29 f7             	sub    %r14,%rdi
    705d:	73 63                	jae    70c2 <fwp_gc_chunks+0x92>
    705f:	48 8d 34 d5 68 10 00 	lea    0x1068(,%rdx,8),%rsi
    7066:	00 
    7067:	4c 69 c0 28 12 00 00 	imul   $0x1228,%rax,%r8
    706e:	4c 03 05 83 c1 00 00 	add    0xc183(%rip),%r8        # 131f8 <fwp_gc+0x1078>
    7075:	31 d2                	xor    %edx,%edx
    7077:	45 31 c9             	xor    %r9d,%r9d
    707a:	eb 16                	jmp    7092 <fwp_gc_chunks+0x62>
    707c:	0f 1f 40 00          	nopl   0x0(%rax)
    7080:	45 31 c9             	xor    %r9d,%r9d
    7083:	48 ff ca             	dec    %rdx
    7086:	49 81 c0 28 12 00 00 	add    $0x1228,%r8
    708d:	48 39 d7             	cmp    %rdx,%rdi
    7090:	74 33                	je     70c5 <fwp_gc_chunks+0x95>
    7092:	41 80 38 00          	cmpb   $0x0,(%r8)
    7096:	75 e8                	jne    7080 <fwp_gc_chunks+0x50>
    7098:	49 ff c1             	inc    %r9
    709b:	49 39 d9             	cmp    %rbx,%r9
    709e:	75 e3                	jne    7083 <fwp_gc_chunks+0x53>
    70a0:	48 ff c0             	inc    %rax
    70a3:	48 89 c7             	mov    %rax,%rdi
    70a6:	48 29 d7             	sub    %rdx,%rdi
    70a9:	48 89 3c 0e          	mov    %rdi,(%rsi,%rcx,1)
    70ad:	48 29 1d ac c2 00 00 	sub    %rbx,0xc2ac(%rip)        # 13360 <fwp_gc+0x11e0>
    70b4:	48 29 d8             	sub    %rbx,%rax
    70b7:	48 29 d0             	sub    %rdx,%rax
    70ba:	49 89 c6             	mov    %rax,%r14
    70bd:	e9 ca 00 00 00       	jmp    718c <fwp_gc_chunks+0x15c>
    70c2:	45 31 c9             	xor    %r9d,%r9d
    70c5:	4c 29 0d 94 c2 00 00 	sub    %r9,0xc294(%rip)        # 13360 <fwp_gc+0x11e0>
    70cc:	4d 29 ce             	sub    %r9,%r14
    70cf:	4c 01 f3             	add    %r14,%rbx
    70d2:	48 8b 3d 07 c1 00 00 	mov    0xc107(%rip),%rdi        # 131e0 <fwp_gc+0x1060>
    70d9:	48 39 df             	cmp    %rbx,%rdi
    70dc:	0f 83 8f 00 00 00    	jae    7171 <fwp_gc_chunks+0x141>
    70e2:	4c 8b 3d e7 c0 00 00 	mov    0xc0e7(%rip),%r15        # 131d0 <fwp_gc+0x1050>
    70e9:	49 39 df             	cmp    %rbx,%r15
    70ec:	0f 82 a3 00 00 00    	jb     7195 <fwp_gc_chunks+0x165>
    70f2:	48 8d 43 40          	lea    0x40(%rbx),%rax
    70f6:	4c 39 f8             	cmp    %r15,%rax
    70f9:	4c 0f 42 f8          	cmovb  %rax,%r15
    70fd:	4c 89 fe             	mov    %r15,%rsi
    7100:	48 29 fe             	sub    %rdi,%rsi
    7103:	48 c1 e7 10          	shl    $0x10,%rdi
    7107:	48 03 3d a2 c0 00 00 	add    0xc0a2(%rip),%rdi        # 131b0 <fwp_gc+0x1030>
    710e:	48 c1 e6 10          	shl    $0x10,%rsi
    7112:	ba 03 00 00 00       	mov    $0x3,%edx
    7117:	e8 24 b1 ff ff       	call   2240 <mprotect@plt>
    711c:	85 c0                	test   %eax,%eax
    711e:	75 75                	jne    7195 <fwp_gc_chunks+0x165>
    7120:	bf 1e 00 00 00       	mov    $0x1e,%edi
    7125:	e8 36 b1 ff ff       	call   2260 <sysconf@plt>
    712a:	48 8b 0d c7 c0 00 00 	mov    0xc0c7(%rip),%rcx        # 131f8 <fwp_gc+0x1078>
    7131:	48 69 3d a4 c0 00 00 	imul   $0x1228,0xc0a4(%rip),%rdi        # 131e0 <fwp_gc+0x1060>
    7138:	28 12 00 00 
    713c:	48 01 cf             	add    %rcx,%rdi
    713f:	49 69 d7 28 12 00 00 	imul   $0x1228,%r15,%rdx
    7146:	48 01 ca             	add    %rcx,%rdx
    7149:	48 8d 34 10          	lea    (%rax,%rdx,1),%rsi
    714d:	48 ff ce             	dec    %rsi
    7150:	48 f7 d8             	neg    %rax
    7153:	48 21 c7             	and    %rax,%rdi
    7156:	48 21 c6             	and    %rax,%rsi
    7159:	48 29 fe             	sub    %rdi,%rsi
    715c:	ba 03 00 00 00       	mov    $0x3,%edx
    7161:	e8 da b0 ff ff       	call   2240 <mprotect@plt>
    7166:	85 c0                	test   %eax,%eax
    7168:	75 2b                	jne    7195 <fwp_gc_chunks+0x165>
    716a:	4c 89 3d 6f c0 00 00 	mov    %r15,0xc06f(%rip)        # 131e0 <fwp_gc+0x1060>
    7171:	48 89 1d 60 c0 00 00 	mov    %rbx,0xc060(%rip)        # 131d8 <fwp_gc+0x1058>
    7178:	48 c1 e3 10          	shl    $0x10,%rbx
    717c:	48 3b 1d 45 c0 00 00 	cmp    0xc045(%rip),%rbx        # 131c8 <fwp_gc+0x1048>
    7183:	76 07                	jbe    718c <fwp_gc_chunks+0x15c>
    7185:	48 89 1d 3c c0 00 00 	mov    %rbx,0xc03c(%rip)        # 131c8 <fwp_gc+0x1048>
    718c:	4c 89 f0             	mov    %r14,%rax
    718f:	5b                   	pop    %rbx
    7190:	41 5e                	pop    %r14
    7192:	41 5f                	pop    %r15
    7194:	c3                   	ret
    7195:	48 8b 05 44 ae 00 00 	mov    0xae44(%rip),%rax        # 11fe0 <stderr@GLIBC_2.2.5>
    719c:	48 8b 08             	mov    (%rax),%rcx
    719f:	48 8d 3d 93 83 00 00 	lea    0x8393(%rip),%rdi        # f539 <fwp_segv.msg+0x2f9>
    71a6:	be 13 00 00 00       	mov    $0x13,%esi
    71ab:	ba 01 00 00 00       	mov    $0x1,%edx
    71b0:	e8 eb b0 ff ff       	call   22a0 <fwrite@plt>
    71b5:	bf 66 00 00 00       	mov    $0x66,%edi
    71ba:	e8 d1 b0 ff ff       	call   2290 <exit@plt>
    71bf:	90                   	nop

00000000000071c0 <fwp_gc_collect>:
    71c0:	50                   	push   %rax
    71c1:	e8 5a f0 ff ff       	call   6220 <fwp_flush>
    71c6:	48 8b 05 13 ae 00 00 	mov    0xae13(%rip),%rax        # 11fe0 <stderr@GLIBC_2.2.5>
    71cd:	48 8b 38             	mov    (%rax),%rdi
    71d0:	48 8d 35 56 82 00 00 	lea    0x8256(%rip),%rsi        # f42d <fwp_segv.msg+0x1ed>
    71d7:	48 8d 15 6f 83 00 00 	lea    0x836f(%rip),%rdx        # f54d <fwp_segv.msg+0x30d>
    71de:	31 c0                	xor    %eax,%eax
    71e0:	e8 cb af ff ff       	call   21b0 <fprintf@plt>
    71e5:	bf 65 00 00 00       	mov    $0x65,%edi
    71ea:	e8 a1 b0 ff ff       	call   2290 <exit@plt>
    71ef:	90                   	nop

00000000000071f0 <f12>:
    71f0:	55                   	push   %rbp
    71f1:	41 57                	push   %r15
    71f3:	41 56                	push   %r14
    71f5:	41 55                	push   %r13
    71f7:	41 54                	push   %r12
    71f9:	53                   	push   %rbx
    71fa:	50                   	push   %rax
    71fb:	48 89 d3             	mov    %rdx,%rbx
    71fe:	49 89 ff             	mov    %rdi,%r15
    7201:	49 bc ff ff ff ff ff 	movabs $0x7fffffffffffffff,%r12
    7208:	ff ff 7f 
    720b:	48 8b 02             	mov    (%rdx),%rax
    720e:	49 89 c6             	mov    %rax,%r14
    7211:	4d 21 e6             	and    %r12,%r14
    7214:	31 c9                	xor    %ecx,%ecx
    7216:	48 85 ff             	test   %rdi,%rdi
    7219:	4c 0f 4e f9          	cmovle %rcx,%r15
    721d:	4d 39 f7             	cmp    %r14,%r15
    7220:	4d 0f 43 fe          	cmovae %r14,%r15
    7224:	48 85 f6             	test   %rsi,%rsi
    7227:	48 0f 4f ce          	cmovg  %rsi,%rcx
    722b:	4d 29 fe             	sub    %r15,%r14
    722e:	4c 39 f1             	cmp    %r14,%rcx
    7231:	4c 0f 42 f1          	cmovb  %rcx,%r14
    7235:	4d 85 f6             	test   %r14,%r14
    7238:	74 10                	je     724a <f12+0x5a>
    723a:	48 89 d9             	mov    %rbx,%rcx
    723d:	48 85 c0             	test   %rax,%rax
    7240:	78 1b                	js     725d <f12+0x6d>
    7242:	49 83 fe 04          	cmp    $0x4,%r14
    7246:	73 1f                	jae    7267 <f12+0x77>
    7248:	eb 44                	jmp    728e <f12+0x9e>
    724a:	48 8d 35 ff a9 00 00 	lea    0xa9ff(%rip),%rsi        # 11c50 <d0>
    7251:	31 ff                	xor    %edi,%edi
    7253:	e8 a8 f1 ff ff       	call   6400 <fwp_array_typed_new>
    7258:	e9 7e 00 00 00       	jmp    72db <f12+0xeb>
    725d:	48 8b 4b 08          	mov    0x8(%rbx),%rcx
    7261:	49 83 fe 04          	cmp    $0x4,%r14
    7265:	72 27                	jb     728e <f12+0x9e>
    7267:	48 8b 09             	mov    (%rcx),%rcx
    726a:	48 89 ca             	mov    %rcx,%rdx
    726d:	48 c1 ea 02          	shr    $0x2,%rdx
    7271:	48 be ff ff ff ff ff 	movabs $0x1fffffffffffffff,%rsi
    7278:	ff ff 1f 
    727b:	48 21 d6             	and    %rdx,%rsi
    727e:	83 e1 03             	and    $0x3,%ecx
    7281:	48 83 f9 01          	cmp    $0x1,%rcx
    7285:	48 83 de ff          	sbb    $0xffffffffffffffff,%rsi
    7289:	4c 39 f6             	cmp    %r14,%rsi
    728c:	76 5c                	jbe    72ea <f12+0xfa>
    728e:	48 8d 35 bb a9 00 00 	lea    0xa9bb(%rip),%rsi        # 11c50 <d0>
    7295:	4c 89 f7             	mov    %r14,%rdi
    7298:	e8 63 f1 ff ff       	call   6400 <fwp_array_typed_new>
    729d:	48 8d 4b 08          	lea    0x8(%rbx),%rcx
    72a1:	49 c1 e7 03          	shl    $0x3,%r15
    72a5:	31 d2                	xor    %edx,%edx
    72a7:	66 0f 1f 84 00 00 00 	nopw   0x0(%rax,%rax,1)
    72ae:	00 00 
    72b0:	48 83 3b 00          	cmpq   $0x0,(%rbx)
    72b4:	48 89 ce             	mov    %rcx,%rsi
    72b7:	79 04                	jns    72bd <f12+0xcd>
    72b9:	48 8b 73 10          	mov    0x10(%rbx),%rsi
    72bd:	48 83 38 00          	cmpq   $0x0,(%rax)
    72c1:	0f 88 37 02 00 00    	js     74fe <f12+0x30e>
    72c7:	4c 01 fe             	add    %r15,%rsi
    72ca:	48 8b 34 d6          	mov    (%rsi,%rdx,8),%rsi
    72ce:	48 89 74 d0 08       	mov    %rsi,0x8(%rax,%rdx,8)
    72d3:	48 ff c2             	inc    %rdx
    72d6:	49 39 d6             	cmp    %rdx,%r14
    72d9:	75 d5                	jne    72b0 <f12+0xc0>
    72db:	48 83 c4 08          	add    $0x8,%rsp
    72df:	5b                   	pop    %rbx
    72e0:	41 5c                	pop    %r12
    72e2:	41 5d                	pop    %r13
    72e4:	41 5e                	pop    %r14
    72e6:	41 5f                	pop    %r15
    72e8:	5d                   	pop    %rbp
    72e9:	c3                   	ret
    72ea:	48 85 c0             	test   %rax,%rax
    72ed:	78 09                	js     72f8 <f12+0x108>
    72ef:	48 8d 43 08          	lea    0x8(%rbx),%rax
    72f3:	49 89 dd             	mov    %rbx,%r13
    72f6:	eb 08                	jmp    7300 <f12+0x110>
    72f8:	4c 8b 6b 08          	mov    0x8(%rbx),%r13
    72fc:	48 8b 43 10          	mov    0x10(%rbx),%rax
    7300:	4a 8d 2c f8          	lea    (%rax,%r15,8),%rbp
    7304:	48 8d 0d 75 ae 00 00 	lea    0xae75(%rip),%rcx        # 12180 <fwp_gc>
    730b:	0f b6 05 58 ba 00 00 	movzbl 0xba58(%rip),%eax        # 12d6a <fwp_gc+0xbea>
    7312:	8b 94 81 48 0b 00 00 	mov    0xb48(%rcx,%rax,4),%edx
    7319:	48 8b 3d 60 ae 00 00 	mov    0xae60(%rip),%rdi        # 12180 <fwp_gc>
    7320:	48 29 d7             	sub    %rdx,%rdi
    7323:	48 89 3d 56 ae 00 00 	mov    %rdi,0xae56(%rip)        # 12180 <fwp_gc>
    732a:	78 56                	js     7382 <f12+0x192>
    732c:	48 8d 34 40          	lea    (%rax,%rax,2),%rsi
    7330:	4c 8d 04 f1          	lea    (%rcx,%rsi,8),%r8
    7334:	49 83 c0 08          	add    $0x8,%r8
    7338:	49 8b 00             	mov    (%r8),%rax
    733b:	48 85 c0             	test   %rax,%rax
    733e:	74 25                	je     7365 <f12+0x175>
    7340:	48 8b 08             	mov    (%rax),%rcx
    7343:	48 f7 d1             	not    %rcx
    7346:	49 89 08             	mov    %rcx,(%r8)
    7349:	83 fa 19             	cmp    $0x19,%edx
    734c:	72 7e                	jb     73cc <f12+0x1dc>
    734e:	48 8d 78 18          	lea    0x18(%rax),%rdi
    7352:	48 83 c2 e7          	add    $0xffffffffffffffe7,%rdx
    7356:	48 83 e2 f8          	and    $0xfffffffffffffff8,%rdx
    735a:	48 83 c2 08          	add    $0x8,%rdx
    735e:	31 f6                	xor    %esi,%esi
    7360:	49 89 c7             	mov    %rax,%r15
    7363:	eb 5f                	jmp    73c4 <f12+0x1d4>
    7365:	48 8b 44 f1 10       	mov    0x10(%rcx,%rsi,8),%rax
    736a:	4c 8b 44 f1 18       	mov    0x18(%rcx,%rsi,8),%r8
    736f:	4d 89 c1             	mov    %r8,%r9
    7372:	49 29 c1             	sub    %rax,%r9
    7375:	49 39 d1             	cmp    %rdx,%r9
    7378:	73 16                	jae    7390 <f12+0x1a0>
    737a:	49 89 c7             	mov    %rax,%r15
    737d:	49 39 d1             	cmp    %rdx,%r9
    7380:	73 34                	jae    73b6 <f12+0x1c6>
    7382:	bf 18 00 00 00       	mov    $0x18,%edi
    7387:	31 f6                	xor    %esi,%esi
    7389:	e8 e2 f2 ff ff       	call   6670 <fwp_gc_alloc_slow>
    738e:	eb 3c                	jmp    73cc <f12+0x1dc>
    7390:	4c 8d 0c f1          	lea    (%rcx,%rsi,8),%r9
    7394:	49 83 c1 10          	add    $0x10,%r9
    7398:	4c 8d 3c 10          	lea    (%rax,%rdx,1),%r15
    739c:	4d 89 39             	mov    %r15,(%r9)
    739f:	48 85 c0             	test   %rax,%rax
    73a2:	75 a5                	jne    7349 <f12+0x159>
    73a4:	48 89 3d d5 ad 00 00 	mov    %rdi,0xadd5(%rip)        # 12180 <fwp_gc>
    73ab:	4d 29 f8             	sub    %r15,%r8
    73ae:	4d 89 c1             	mov    %r8,%r9
    73b1:	49 39 d1             	cmp    %rdx,%r9
    73b4:	72 cc                	jb     7382 <f12+0x192>
    73b6:	49 8d 04 17          	lea    (%r15,%rdx,1),%rax
    73ba:	48 89 44 f1 10       	mov    %rax,0x10(%rcx,%rsi,8)
    73bf:	4c 89 ff             	mov    %r15,%rdi
    73c2:	31 f6                	xor    %esi,%esi
    73c4:	e8 67 ad ff ff       	call   2130 <memset@plt>
    73c9:	4c 89 f8             	mov    %r15,%rax
    73cc:	4b 8d 0c 34          	lea    (%r12,%r14,1),%rcx
    73d0:	48 ff c1             	inc    %rcx
    73d3:	48 89 08             	mov    %rcx,(%rax)
    73d6:	4c 89 68 08          	mov    %r13,0x8(%rax)
    73da:	48 89 68 10          	mov    %rbp,0x10(%rax)
    73de:	4c 2b 2d cb bd 00 00 	sub    0xbdcb(%rip),%r13        # 131b0 <fwp_gc+0x1030>
    73e5:	48 8b 0d ec bd 00 00 	mov    0xbdec(%rip),%rcx        # 131d8 <fwp_gc+0x1058>
    73ec:	48 c1 e1 10          	shl    $0x10,%rcx
    73f0:	49 39 cd             	cmp    %rcx,%r13
    73f3:	73 6a                	jae    745f <f12+0x26f>
    73f5:	48 8b 0d fc bd 00 00 	mov    0xbdfc(%rip),%rcx        # 131f8 <fwp_gc+0x1078>
    73fc:	4c 89 ea             	mov    %r13,%rdx
    73ff:	48 c1 ea 10          	shr    $0x10,%rdx
    7403:	48 69 d2 28 12 00 00 	imul   $0x1228,%rdx,%rdx
    740a:	0f b6 34 11          	movzbl (%rcx,%rdx,1),%esi
    740e:	49 81 e5 ff ff 00 00 	and    $0xffff,%r13
    7415:	75 13                	jne    742a <f12+0x23a>
    7417:	40 80 fe 02          	cmp    $0x2,%sil
    741b:	75 0d                	jne    742a <f12+0x23a>
    741d:	48 8d 3c 11          	lea    (%rcx,%rdx,1),%rdi
    7421:	48 81 c7 28 02 00 00 	add    $0x228,%rdi
    7428:	eb 21                	jmp    744b <f12+0x25b>
    742a:	40 80 fe 01          	cmp    $0x1,%sil
    742e:	75 2f                	jne    745f <f12+0x26f>
    7430:	48 8d 34 11          	lea    (%rcx,%rdx,1),%rsi
    7434:	8b 4c 11 20          	mov    0x20(%rcx,%rdx,1),%ecx
    7438:	4c 0f af e9          	imul   %rcx,%r13
    743c:	49 c1 ed 20          	shr    $0x20,%r13
    7440:	4a 8d 3c 2e          	lea    (%rsi,%r13,1),%rdi
    7444:	48 81 c7 28 02 00 00 	add    $0x228,%rdi
    744b:	0f b6 0f             	movzbl (%rdi),%ecx
    744e:	84 c9                	test   %cl,%cl
    7450:	74 0d                	je     745f <f12+0x26f>
    7452:	80 f9 fe             	cmp    $0xfe,%cl
    7455:	0f 83 93 00 00 00    	jae    74ee <f12+0x2fe>
    745b:	fe c1                	inc    %cl
    745d:	88 0f                	mov    %cl,(%rdi)
    745f:	48 89 c1             	mov    %rax,%rcx
    7462:	48 2b 0d 47 bd 00 00 	sub    0xbd47(%rip),%rcx        # 131b0 <fwp_gc+0x1030>
    7469:	48 8b 15 68 bd 00 00 	mov    0xbd68(%rip),%rdx        # 131d8 <fwp_gc+0x1058>
    7470:	48 c1 e2 10          	shl    $0x10,%rdx
    7474:	48 39 d1             	cmp    %rdx,%rcx
    7477:	73 60                	jae    74d9 <f12+0x2e9>
    7479:	48 8b 15 78 bd 00 00 	mov    0xbd78(%rip),%rdx        # 131f8 <fwp_gc+0x1078>
    7480:	48 89 ce             	mov    %rcx,%rsi
    7483:	48 c1 ee 10          	shr    $0x10,%rsi
    7487:	48 69 f6 28 12 00 00 	imul   $0x1228,%rsi,%rsi
    748e:	0f b6 3c 32          	movzbl (%rdx,%rsi,1),%edi
    7492:	48 81 e1 ff ff 00 00 	and    $0xffff,%rcx
    7499:	75 13                	jne    74ae <f12+0x2be>
    749b:	40 80 ff 02          	cmp    $0x2,%dil
    749f:	75 0d                	jne    74ae <f12+0x2be>
    74a1:	4c 8d 34 32          	lea    (%rdx,%rsi,1),%r14
    74a5:	49 81 c6 28 02 00 00 	add    $0x228,%r14
    74ac:	eb 21                	jmp    74cf <f12+0x2df>
    74ae:	40 80 ff 01          	cmp    $0x1,%dil
    74b2:	75 25                	jne    74d9 <f12+0x2e9>
    74b4:	48 8d 3c 32          	lea    (%rdx,%rsi,1),%rdi
    74b8:	8b 54 32 20          	mov    0x20(%rdx,%rsi,1),%edx
    74bc:	48 0f af ca          	imul   %rdx,%rcx
    74c0:	48 c1 e9 20          	shr    $0x20,%rcx
    74c4:	4c 8d 34 39          	lea    (%rcx,%rdi,1),%r14
    74c8:	49 81 c6 28 02 00 00 	add    $0x228,%r14
    74cf:	41 80 3e ff          	cmpb   $0xff,(%r14)
    74d3:	74 09                	je     74de <f12+0x2ee>
    74d5:	41 c6 06 01          	movb   $0x1,(%r14)
    74d9:	e9 fd fd ff ff       	jmp    72db <f12+0xeb>
    74de:	4c 89 f7             	mov    %r14,%rdi
    74e1:	49 89 c7             	mov    %rax,%r15
    74e4:	e8 67 ed ff ff       	call   6250 <fwp_rc_forget_slot>
    74e9:	4c 89 f8             	mov    %r15,%rax
    74ec:	eb e7                	jmp    74d5 <f12+0x2e5>
    74ee:	49 89 c6             	mov    %rax,%r14
    74f1:	e8 3a 00 00 00       	call   7530 <fwp_rc_wide_dup>
    74f6:	4c 89 f0             	mov    %r14,%rax
    74f9:	e9 61 ff ff ff       	jmp    745f <f12+0x26f>
    74fe:	e8 1d ed ff ff       	call   6220 <fwp_flush>
    7503:	48 8b 05 d6 aa 00 00 	mov    0xaad6(%rip),%rax        # 11fe0 <stderr@GLIBC_2.2.5>
    750a:	48 8b 38             	mov    (%rax),%rdi
    750d:	48 8d 35 19 7f 00 00 	lea    0x7f19(%rip),%rsi        # f42d <fwp_segv.msg+0x1ed>
    7514:	48 8d 15 63 80 00 00 	lea    0x8063(%rip),%rdx        # f57e <fwp_segv.msg+0x33e>
    751b:	31 c0                	xor    %eax,%eax
    751d:	e8 8e ac ff ff       	call   21b0 <fprintf@plt>
    7522:	bf 65 00 00 00       	mov    $0x65,%edi
    7527:	e8 64 ad ff ff       	call   2290 <exit@plt>
    752c:	0f 1f 40 00          	nopl   0x0(%rax)

0000000000007530 <fwp_rc_wide_dup>:
    7530:	41 56                	push   %r14
    7532:	53                   	push   %rbx
    7533:	50                   	push   %rax
    7534:	48 89 fb             	mov    %rdi,%rbx
    7537:	48 89 f8             	mov    %rdi,%rax
    753a:	48 c1 e8 11          	shr    $0x11,%rax
    753e:	31 d8                	xor    %ebx,%eax
    7540:	89 c1                	mov    %eax,%ecx
    7542:	c1 e9 09             	shr    $0x9,%ecx
    7545:	31 c1                	xor    %eax,%ecx
    7547:	0f b6 c1             	movzbl %cl,%eax
    754a:	48 8d 0d 2f ac 00 00 	lea    0xac2f(%rip),%rcx        # 12180 <fwp_gc>
    7551:	4c 8d 34 c1          	lea    (%rcx,%rax,8),%r14
    7555:	49 81 c6 18 12 00 00 	add    $0x1218,%r14
    755c:	48 8b 84 c1 18 12 00 	mov    0x1218(%rcx,%rax,8),%rax
    7563:	00 
    7564:	48 85 c0             	test   %rax,%rax
    7567:	74 1a                	je     7583 <fwp_rc_wide_dup+0x53>
    7569:	48 39 18             	cmp    %rbx,(%rax)
    756c:	74 22                	je     7590 <fwp_rc_wide_dup+0x60>
    756e:	66 90                	xchg   %ax,%ax
    7570:	49 89 c6             	mov    %rax,%r14
    7573:	48 8b 40 10          	mov    0x10(%rax),%rax
    7577:	48 85 c0             	test   %rax,%rax
    757a:	74 0e                	je     758a <fwp_rc_wide_dup+0x5a>
    757c:	48 39 18             	cmp    %rbx,(%rax)
    757f:	75 ef                	jne    7570 <fwp_rc_wide_dup+0x40>
    7581:	eb 09                	jmp    758c <fwp_rc_wide_dup+0x5c>
    7583:	80 3b fe             	cmpb   $0xfe,(%rbx)
    7586:	74 16                	je     759e <fwp_rc_wide_dup+0x6e>
    7588:	eb 6d                	jmp    75f7 <fwp_rc_wide_dup+0xc7>
    758a:	31 c0                	xor    %eax,%eax
    758c:	49 83 c6 10          	add    $0x10,%r14
    7590:	80 3b fe             	cmpb   $0xfe,(%rbx)
    7593:	75 41                	jne    75d6 <fwp_rc_wide_dup+0xa6>
    7595:	48 85 c0             	test   %rax,%rax
    7598:	0f 85 a2 00 00 00    	jne    7640 <fwp_rc_wide_dup+0x110>
    759e:	bf 18 00 00 00       	mov    $0x18,%edi
    75a3:	e8 48 ac ff ff       	call   21f0 <malloc@plt>
    75a8:	48 85 c0             	test   %rax,%rax
    75ab:	74 69                	je     7616 <fwp_rc_wide_dup+0xe6>
    75ad:	48 89 18             	mov    %rbx,(%rax)
    75b0:	48 c7 40 08 ff 00 00 	movq   $0xff,0x8(%rax)
    75b7:	00 
    75b8:	48 c7 40 10 00 00 00 	movq   $0x0,0x10(%rax)
    75bf:	00 
    75c0:	49 89 06             	mov    %rax,(%r14)
    75c3:	c6 03 ff             	movb   $0xff,(%rbx)
    75c6:	48 8d 05 cb c5 00 00 	lea    0xc5cb(%rip),%rax        # 13b98 <fwp_gc+0x1a18>
    75cd:	48 8b 0d c4 c5 00 00 	mov    0xc5c4(%rip),%rcx        # 13b98 <fwp_gc+0x1a18>
    75d4:	eb 13                	jmp    75e9 <fwp_rc_wide_dup+0xb9>
    75d6:	48 85 c0             	test   %rax,%rax
    75d9:	74 1c                	je     75f7 <fwp_rc_wide_dup+0xc7>
    75db:	48 8b 48 08          	mov    0x8(%rax),%rcx
    75df:	48 83 f9 ff          	cmp    $0xffffffffffffffff,%rcx
    75e3:	74 7a                	je     765f <fwp_rc_wide_dup+0x12f>
    75e5:	48 83 c0 08          	add    $0x8,%rax
    75e9:	48 ff c1             	inc    %rcx
    75ec:	48 89 08             	mov    %rcx,(%rax)
    75ef:	48 83 c4 08          	add    $0x8,%rsp
    75f3:	5b                   	pop    %rbx
    75f4:	41 5e                	pop    %r14
    75f6:	c3                   	ret
    75f7:	e8 24 ec ff ff       	call   6220 <fwp_flush>
    75fc:	48 8b 05 dd a9 00 00 	mov    0xa9dd(%rip),%rax        # 11fe0 <stderr@GLIBC_2.2.5>
    7603:	48 8b 38             	mov    (%rax),%rdi
    7606:	48 8d 35 20 7e 00 00 	lea    0x7e20(%rip),%rsi        # f42d <fwp_segv.msg+0x1ed>
    760d:	48 8d 15 28 7e 00 00 	lea    0x7e28(%rip),%rdx        # f43c <fwp_segv.msg+0x1fc>
    7614:	eb 66                	jmp    767c <fwp_rc_wide_dup+0x14c>
    7616:	48 8b 05 c3 a9 00 00 	mov    0xa9c3(%rip),%rax        # 11fe0 <stderr@GLIBC_2.2.5>
    761d:	48 8b 08             	mov    (%rax),%rcx
    7620:	48 8d 3d 12 7f 00 00 	lea    0x7f12(%rip),%rdi        # f539 <fwp_segv.msg+0x2f9>
    7627:	be 13 00 00 00       	mov    $0x13,%esi
    762c:	ba 01 00 00 00       	mov    $0x1,%edx
    7631:	e8 6a ac ff ff       	call   22a0 <fwrite@plt>
    7636:	bf 66 00 00 00       	mov    $0x66,%edi
    763b:	e8 50 ac ff ff       	call   2290 <exit@plt>
    7640:	e8 db eb ff ff       	call   6220 <fwp_flush>
    7645:	48 8b 05 94 a9 00 00 	mov    0xa994(%rip),%rax        # 11fe0 <stderr@GLIBC_2.2.5>
    764c:	48 8b 38             	mov    (%rax),%rdi
    764f:	48 8d 35 d7 7d 00 00 	lea    0x7dd7(%rip),%rsi        # f42d <fwp_segv.msg+0x1ed>
    7656:	48 8d 15 4d 7f 00 00 	lea    0x7f4d(%rip),%rdx        # f5aa <fwp_segv.msg+0x36a>
    765d:	eb 1d                	jmp    767c <fwp_rc_wide_dup+0x14c>
    765f:	e8 bc eb ff ff       	call   6220 <fwp_flush>
    7664:	48 8b 05 75 a9 00 00 	mov    0xa975(%rip),%rax        # 11fe0 <stderr@GLIBC_2.2.5>
    766b:	48 8b 38             	mov    (%rax),%rdi
    766e:	48 8d 35 b8 7d 00 00 	lea    0x7db8(%rip),%rsi        # f42d <fwp_segv.msg+0x1ed>
    7675:	48 8d 15 53 7f 00 00 	lea    0x7f53(%rip),%rdx        # f5cf <fwp_segv.msg+0x38f>
    767c:	31 c0                	xor    %eax,%eax
    767e:	e8 2d ab ff ff       	call   21b0 <fprintf@plt>
    7683:	bf 65 00 00 00       	mov    $0x65,%edi
    7688:	e8 03 ac ff ff       	call   2290 <exit@plt>
    768d:	0f 1f 00             	nopl   (%rax)

0000000000007690 <fwp_show>:
    7690:	41 57                	push   %r15
    7692:	41 56                	push   %r14
    7694:	41 54                	push   %r12
    7696:	53                   	push   %rbx
    7697:	48 83 ec 18          	sub    $0x18,%rsp
    769b:	48 89 f2             	mov    %rsi,%rdx
    769e:	48 89 fe             	mov    %rdi,%rsi
    76a1:	0f 57 c0             	xorps  %xmm0,%xmm0
    76a4:	0f 29 04 24          	movaps %xmm0,(%rsp)
    76a8:	48 c7 44 24 10 00 00 	movq   $0x0,0x10(%rsp)
    76af:	00 00 
    76b1:	48 89 e7             	mov    %rsp,%rdi
    76b4:	b9 01 00 00 00       	mov    $0x1,%ecx
    76b9:	e8 e2 00 00 00       	call   77a0 <fwp_write>
    76be:	4c 8b 24 24          	mov    (%rsp),%r12
    76c2:	48 8b 5c 24 08       	mov    0x8(%rsp),%rbx
    76c7:	48 8d 53 09          	lea    0x9(%rbx),%rdx
    76cb:	48 81 fa 00 40 00 00 	cmp    $0x4000,%rdx
    76d2:	77 61                	ja     7735 <fwp_show+0xa5>
    76d4:	48 8d 4b 18          	lea    0x18(%rbx),%rcx
    76d8:	48 c1 e9 04          	shr    $0x4,%rcx
    76dc:	48 8d 05 9d aa 00 00 	lea    0xaa9d(%rip),%rax        # 12180 <fwp_gc>
    76e3:	0f b6 b4 01 e8 0b 00 	movzbl 0xbe8(%rcx,%rax,1),%esi
    76ea:	00 
    76eb:	8b 8c b0 48 0b 00 00 	mov    0xb48(%rax,%rsi,4),%ecx
    76f2:	48 29 0d 87 aa 00 00 	sub    %rcx,0xaa87(%rip)        # 12180 <fwp_gc>
    76f9:	78 3a                	js     7735 <fwp_show+0xa5>
    76fb:	48 8d 34 76          	lea    (%rsi,%rsi,2),%rsi
    76ff:	48 8d 3c f0          	lea    (%rax,%rsi,8),%rdi
    7703:	48 81 c7 c8 03 00 00 	add    $0x3c8,%rdi
    770a:	4c 8b 37             	mov    (%rdi),%r14
    770d:	4d 85 f6             	test   %r14,%r14
    7710:	74 0b                	je     771d <fwp_show+0x8d>
    7712:	49 8b 06             	mov    (%r14),%rax
    7715:	48 f7 d0             	not    %rax
    7718:	48 89 07             	mov    %rax,(%rdi)
    771b:	eb 3a                	jmp    7757 <fwp_show+0xc7>
    771d:	4c 8b b4 f0 d0 03 00 	mov    0x3d0(%rax,%rsi,8),%r14
    7724:	00 
    7725:	48 8b bc f0 d8 03 00 	mov    0x3d8(%rax,%rsi,8),%rdi
    772c:	00 
    772d:	4c 29 f7             	sub    %r14,%rdi
    7730:	48 39 cf             	cmp    %rcx,%rdi
    7733:	73 12                	jae    7747 <fwp_show+0xb7>
    7735:	48 89 d7             	mov    %rdx,%rdi
    7738:	be 01 00 00 00       	mov    $0x1,%esi
    773d:	e8 2e ef ff ff       	call   6670 <fwp_gc_alloc_slow>
    7742:	49 89 c6             	mov    %rax,%r14
    7745:	eb 1a                	jmp    7761 <fwp_show+0xd1>
    7747:	48 8d 04 f0          	lea    (%rax,%rsi,8),%rax
    774b:	48 05 d0 03 00 00    	add    $0x3d0,%rax
    7751:	4c 01 f1             	add    %r14,%rcx
    7754:	48 89 08             	mov    %rcx,(%rax)
    7757:	4c 89 f7             	mov    %r14,%rdi
    775a:	31 f6                	xor    %esi,%esi
    775c:	e8 cf a9 ff ff       	call   2130 <memset@plt>
    7761:	4d 85 e4             	test   %r12,%r12
    7764:	4c 8d 3d c4 7f 00 00 	lea    0x7fc4(%rip),%r15        # f72f <fwp_segv.msg+0x4ef>
    776b:	4d 0f 45 fc          	cmovne %r12,%r15
    776f:	49 89 1e             	mov    %rbx,(%r14)
    7772:	49 8d 7e 08          	lea    0x8(%r14),%rdi
    7776:	4c 89 fe             	mov    %r15,%rsi
    7779:	48 89 da             	mov    %rbx,%rdx
    777c:	e8 5f aa ff ff       	call   21e0 <memcpy@plt>
    7781:	41 c6 44 1e 08 00    	movb   $0x0,0x8(%r14,%rbx,1)
    7787:	48 8b 3c 24          	mov    (%rsp),%rdi
    778b:	e8 c0 a8 ff ff       	call   2050 <free@plt>
    7790:	4c 89 f0             	mov    %r14,%rax
    7793:	48 83 c4 18          	add    $0x18,%rsp
    7797:	5b                   	pop    %rbx
    7798:	41 5c                	pop    %r12
    779a:	41 5e                	pop    %r14
    779c:	41 5f                	pop    %r15
    779e:	c3                   	ret
    779f:	90                   	nop

00000000000077a0 <fwp_write>:
    77a0:	55                   	push   %rbp
    77a1:	41 57                	push   %r15
    77a3:	41 56                	push   %r14
    77a5:	41 55                	push   %r13
    77a7:	41 54                	push   %r12
    77a9:	53                   	push   %rbx
    77aa:	48 81 ec 78 02 00 00 	sub    $0x278,%rsp
    77b1:	8b 02                	mov    (%rdx),%eax
    77b3:	48 83 f8 19          	cmp    $0x19,%rax
    77b7:	0f 87 26 12 00 00    	ja     89e3 <fwp_write+0x1243>
    77bd:	49 89 d7             	mov    %rdx,%r15
    77c0:	49 89 f6             	mov    %rsi,%r14
    77c3:	48 89 fd             	mov    %rdi,%rbp
    77c6:	48 8d 15 53 79 00 00 	lea    0x7953(%rip),%rdx        # f120 <_IO_stdin_used+0x120>
    77cd:	48 63 34 82          	movslq (%rdx,%rax,4),%rsi
    77d1:	48 01 d6             	add    %rdx,%rsi
    77d4:	48 89 3c 24          	mov    %rdi,(%rsp)
    77d8:	ff e6                	jmp    *%rsi
    77da:	48 8d 15 07 7e 00 00 	lea    0x7e07(%rip),%rdx        # f5e8 <fwp_segv.msg+0x3a8>
    77e1:	eb 07                	jmp    77ea <fwp_write+0x4a>
    77e3:	48 8d 15 03 7e 00 00 	lea    0x7e03(%rip),%rdx        # f5ed <fwp_segv.msg+0x3ad>
    77ea:	4c 8d 7c 24 70       	lea    0x70(%rsp),%r15
    77ef:	be 00 02 00 00       	mov    $0x200,%esi
    77f4:	4c 89 ff             	mov    %r15,%rdi
    77f7:	4c 89 f1             	mov    %r14,%rcx
    77fa:	31 c0                	xor    %eax,%eax
    77fc:	e8 0f a9 ff ff       	call   2110 <snprintf@plt>
    7801:	4c 89 ff             	mov    %r15,%rdi
    7804:	e8 d7 a8 ff ff       	call   20e0 <strlen@plt>
    7809:	48 89 ef             	mov    %rbp,%rdi
    780c:	4c 89 fe             	mov    %r15,%rsi
    780f:	e9 c7 11 00 00       	jmp    89db <fwp_write+0x123b>
    7814:	83 f8 13             	cmp    $0x13,%eax
    7817:	48 8d 05 09 7e 00 00 	lea    0x7e09(%rip),%rax        # f627 <fwp_segv.msg+0x3e7>
    781e:	48 8d 35 07 7e 00 00 	lea    0x7e07(%rip),%rsi        # f62c <fwp_segv.msg+0x3ec>
    7825:	48 0f 44 f0          	cmove  %rax,%rsi
    7829:	ba 04 00 00 00       	mov    $0x4,%edx
    782e:	48 89 ef             	mov    %rbp,%rdi
    7831:	e8 4a 13 00 00       	call   8b80 <buf_put>
    7836:	49 83 3e 00          	cmpq   $0x0,(%r14)
    783a:	0f 84 c3 00 00 00    	je     7903 <fwp_write+0x163>
    7840:	49 8b 57 38          	mov    0x38(%r15),%rdx
    7844:	49 8b 76 08          	mov    0x8(%r14),%rsi
    7848:	48 8b 1c 24          	mov    (%rsp),%rbx
    784c:	48 89 df             	mov    %rbx,%rdi
    784f:	31 c9                	xor    %ecx,%ecx
    7851:	e8 4a ff ff ff       	call   77a0 <fwp_write>
    7856:	41 83 3f 12          	cmpl   $0x12,(%r15)
    785a:	75 26                	jne    7882 <fwp_write+0xe2>
    785c:	48 8d 35 ce 7d 00 00 	lea    0x7dce(%rip),%rsi        # f631 <fwp_segv.msg+0x3f1>
    7863:	ba 02 00 00 00       	mov    $0x2,%edx
    7868:	48 89 df             	mov    %rbx,%rdi
    786b:	e8 10 13 00 00       	call   8b80 <buf_put>
    7870:	49 8b 76 10          	mov    0x10(%r14),%rsi
    7874:	49 8b 57 40          	mov    0x40(%r15),%rdx
    7878:	48 89 df             	mov    %rbx,%rdi
    787b:	31 c9                	xor    %ecx,%ecx
    787d:	e8 1e ff ff ff       	call   77a0 <fwp_write>
    7882:	49 83 3e 02          	cmpq   $0x2,(%r14)
    7886:	72 7b                	jb     7903 <fwp_write+0x163>
    7888:	49 8d 5e 20          	lea    0x20(%r14),%rbx
    788c:	bd 01 00 00 00       	mov    $0x1,%ebp
    7891:	4c 8d 25 82 7d 00 00 	lea    0x7d82(%rip),%r12        # f61a <fwp_segv.msg+0x3da>
    7898:	eb 12                	jmp    78ac <fwp_write+0x10c>
    789a:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)
    78a0:	48 ff c5             	inc    %rbp
    78a3:	48 83 c3 10          	add    $0x10,%rbx
    78a7:	49 3b 2e             	cmp    (%r14),%rbp
    78aa:	73 57                	jae    7903 <fwp_write+0x163>
    78ac:	ba 02 00 00 00       	mov    $0x2,%edx
    78b1:	4c 8b 2c 24          	mov    (%rsp),%r13
    78b5:	4c 89 ef             	mov    %r13,%rdi
    78b8:	4c 89 e6             	mov    %r12,%rsi
    78bb:	e8 c0 12 00 00       	call   8b80 <buf_put>
    78c0:	48 8b 73 f8          	mov    -0x8(%rbx),%rsi
    78c4:	49 8b 57 38          	mov    0x38(%r15),%rdx
    78c8:	4c 89 ef             	mov    %r13,%rdi
    78cb:	31 c9                	xor    %ecx,%ecx
    78cd:	e8 ce fe ff ff       	call   77a0 <fwp_write>
    78d2:	41 83 3f 12          	cmpl   $0x12,(%r15)
    78d6:	75 c8                	jne    78a0 <fwp_write+0x100>
    78d8:	ba 02 00 00 00       	mov    $0x2,%edx
    78dd:	4c 8b 2c 24          	mov    (%rsp),%r13
    78e1:	4c 89 ef             	mov    %r13,%rdi
    78e4:	48 8d 35 46 7d 00 00 	lea    0x7d46(%rip),%rsi        # f631 <fwp_segv.msg+0x3f1>
    78eb:	e8 90 12 00 00       	call   8b80 <buf_put>
    78f0:	48 8b 33             	mov    (%rbx),%rsi
    78f3:	49 8b 57 40          	mov    0x40(%r15),%rdx
    78f7:	4c 89 ef             	mov    %r13,%rdi
    78fa:	31 c9                	xor    %ecx,%ecx
    78fc:	e8 9f fe ff ff       	call   77a0 <fwp_write>
    7901:	eb 9d                	jmp    78a0 <fwp_write+0x100>
    7903:	c6 44 24 70 7d       	movb   $0x7d,0x70(%rsp)
    7908:	48 8d 74 24 70       	lea    0x70(%rsp),%rsi
    790d:	ba 01 00 00 00       	mov    $0x1,%edx
    7912:	48 8b 3c 24          	mov    (%rsp),%rdi
    7916:	e9 c3 10 00 00       	jmp    89de <fwp_write+0x123e>
    791b:	4d 8b 67 08          	mov    0x8(%r15),%r12
    791f:	4d 85 e4             	test   %r12,%r12
    7922:	0f 84 af 06 00 00    	je     7fd7 <fwp_write+0x837>
    7928:	48 8d 35 05 7d 00 00 	lea    0x7d05(%rip),%rsi        # f634 <fwp_segv.msg+0x3f4>
    792f:	4c 89 e7             	mov    %r12,%rdi
    7932:	e8 49 a8 ff ff       	call   2180 <strcmp@plt>
    7937:	85 c0                	test   %eax,%eax
    7939:	0f 84 36 0b 00 00    	je     8475 <fwp_write+0xcd5>
    793f:	4d 8d 6f 10          	lea    0x10(%r15),%r13
    7943:	4c 89 e7             	mov    %r12,%rdi
    7946:	e8 95 a7 ff ff       	call   20e0 <strlen@plt>
    794b:	48 89 ef             	mov    %rbp,%rdi
    794e:	4c 89 e6             	mov    %r12,%rsi
    7951:	48 89 c2             	mov    %rax,%rdx
    7954:	e8 27 12 00 00       	call   8b80 <buf_put>
    7959:	c6 44 24 70 20       	movb   $0x20,0x70(%rsp)
    795e:	48 8d 74 24 70       	lea    0x70(%rsp),%rsi
    7963:	ba 01 00 00 00       	mov    $0x1,%edx
    7968:	48 89 ef             	mov    %rbp,%rdi
    796b:	e8 10 12 00 00       	call   8b80 <buf_put>
    7970:	31 db                	xor    %ebx,%ebx
    7972:	e9 7f 06 00 00       	jmp    7ff6 <fwp_write+0x856>
    7977:	49 81 fe ff 0f 00 00 	cmp    $0xfff,%r14
    797e:	0f 87 00 05 00 00    	ja     7e84 <fwp_write+0x6e4>
    7984:	44 89 f0             	mov    %r14d,%eax
    7987:	e9 fb 04 00 00       	jmp    7e87 <fwp_write+0x6e7>
    798c:	66 49 0f 6e ce       	movq   %r14,%xmm1
    7991:	66 0f 2e c9          	ucomisd %xmm1,%xmm1
    7995:	0f 8a d2 11 00 00    	jp     8b6d <fwp_write+0x13cd>
    799b:	66 0f 28 05 2d 77 00 	movapd 0x772d(%rip),%xmm0        # f0d0 <_IO_stdin_used+0xd0>
    79a2:	00 
    79a3:	66 0f 54 c1          	andpd  %xmm1,%xmm0
    79a7:	66 0f 2e 05 71 76 00 	ucomisd 0x7671(%rip),%xmm0        # f020 <_IO_stdin_used+0x20>
    79ae:	00 
    79af:	0f 82 66 08 00 00    	jb     821b <fwp_write+0xa7b>
    79b5:	66 0f 57 c0          	xorpd  %xmm0,%xmm0
    79b9:	66 0f 2e c8          	ucomisd %xmm0,%xmm1
    79bd:	e9 55 04 00 00       	jmp    7e17 <fwp_write+0x677>
    79c2:	c6 44 24 70 3c       	movb   $0x3c,0x70(%rsp)
    79c7:	48 8d 74 24 70       	lea    0x70(%rsp),%rsi
    79cc:	ba 01 00 00 00       	mov    $0x1,%edx
    79d1:	48 89 ef             	mov    %rbp,%rdi
    79d4:	e8 a7 11 00 00       	call   8b80 <buf_put>
    79d9:	4d 8b 77 08          	mov    0x8(%r15),%r14
    79dd:	e9 82 04 00 00       	jmp    7e64 <fwp_write+0x6c4>
    79e2:	48 8d 35 1a 7c 00 00 	lea    0x7c1a(%rip),%rsi        # f603 <fwp_segv.msg+0x3c3>
    79e9:	ba 08 00 00 00       	mov    $0x8,%edx
    79ee:	48 89 ef             	mov    %rbp,%rdi
    79f1:	e9 5c 0d 00 00       	jmp    8752 <fwp_write+0xfb2>
    79f6:	49 8d 76 08          	lea    0x8(%r14),%rsi
    79fa:	49 8b 16             	mov    (%r14),%rdx
    79fd:	85 c9                	test   %ecx,%ecx
    79ff:	0f 84 13 07 00 00    	je     8118 <fwp_write+0x978>
    7a05:	48 89 ef             	mov    %rbp,%rdi
    7a08:	e9 45 0d 00 00       	jmp    8752 <fwp_write+0xfb2>
    7a0d:	4d 8b 0e             	mov    (%r14),%r9
    7a10:	4d 8b 46 08          	mov    0x8(%r14),%r8
    7a14:	4c 89 c8             	mov    %r9,%rax
    7a17:	4c 09 c0             	or     %r8,%rax
    7a1a:	0f 84 11 07 00 00    	je     8131 <fwp_write+0x991>
    7a20:	31 ff                	xor    %edi,%edi
    7a22:	49 ba cd cc cc cc cc 	movabs $0xcccccccccccccccd,%r10
    7a29:	cc cc cc 
    7a2c:	49 bb cc cc cc cc cc 	movabs $0xcccccccccccccccc,%r11
    7a33:	cc cc cc 
    7a36:	4c 89 c3             	mov    %r8,%rbx
    7a39:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)
    7a40:	4c 89 c1             	mov    %r8,%rcx
    7a43:	4c 0f a4 c9 3f       	shld   $0x3f,%r9,%rcx
    7a48:	48 d1 eb             	shr    $1,%rbx
    7a4b:	48 89 ce             	mov    %rcx,%rsi
    7a4e:	48 01 de             	add    %rbx,%rsi
    7a51:	48 83 d6 00          	adc    $0x0,%rsi
    7a55:	48 89 f0             	mov    %rsi,%rax
    7a58:	49 f7 e2             	mul    %r10
    7a5b:	48 c1 ea 02          	shr    $0x2,%rdx
    7a5f:	48 8d 04 92          	lea    (%rdx,%rdx,4),%rax
    7a63:	48 29 c6             	sub    %rax,%rsi
    7a66:	48 29 f1             	sub    %rsi,%rcx
    7a69:	48 83 db 00          	sbb    $0x0,%rbx
    7a6d:	48 89 ce             	mov    %rcx,%rsi
    7a70:	49 0f af f3          	imul   %r11,%rsi
    7a74:	48 89 c8             	mov    %rcx,%rax
    7a77:	49 f7 e2             	mul    %r10
    7a7a:	48 01 f2             	add    %rsi,%rdx
    7a7d:	49 0f af da          	imul   %r10,%rbx
    7a81:	48 01 d3             	add    %rdx,%rbx
    7a84:	48 89 c1             	mov    %rax,%rcx
    7a87:	48 01 c1             	add    %rax,%rcx
    7a8a:	48 8d 0c 89          	lea    (%rcx,%rcx,4),%rcx
    7a8e:	44 89 ca             	mov    %r9d,%edx
    7a91:	29 ca                	sub    %ecx,%edx
    7a93:	80 ca 30             	or     $0x30,%dl
    7a96:	88 54 3c 20          	mov    %dl,0x20(%rsp,%rdi,1)
    7a9a:	48 ff c7             	inc    %rdi
    7a9d:	49 83 f9 0a          	cmp    $0xa,%r9
    7aa1:	49 83 d8 00          	sbb    $0x0,%r8
    7aa5:	49 89 c1             	mov    %rax,%r9
    7aa8:	49 89 d8             	mov    %rbx,%r8
    7aab:	73 93                	jae    7a40 <fwp_write+0x2a0>
    7aad:	85 ff                	test   %edi,%edi
    7aaf:	0f 8f 86 06 00 00    	jg     813b <fwp_write+0x99b>
    7ab5:	e9 ab 00 00 00       	jmp    7b65 <fwp_write+0x3c5>
    7aba:	4d 8b 06             	mov    (%r14),%r8
    7abd:	4d 8b 4e 08          	mov    0x8(%r14),%r9
    7ac1:	4d 85 c9             	test   %r9,%r9
    7ac4:	0f 88 93 06 00 00    	js     815d <fwp_write+0x9bd>
    7aca:	4c 89 c0             	mov    %r8,%rax
    7acd:	4c 09 c8             	or     %r9,%rax
    7ad0:	0f 84 bc 09 00 00    	je     8492 <fwp_write+0xcf2>
    7ad6:	31 ff                	xor    %edi,%edi
    7ad8:	49 ba cd cc cc cc cc 	movabs $0xcccccccccccccccd,%r10
    7adf:	cc cc cc 
    7ae2:	49 bb cc cc cc cc cc 	movabs $0xcccccccccccccccc,%r11
    7ae9:	cc cc cc 
    7aec:	4c 89 cb             	mov    %r9,%rbx
    7aef:	90                   	nop
    7af0:	4c 89 c9             	mov    %r9,%rcx
    7af3:	4c 0f a4 c1 3f       	shld   $0x3f,%r8,%rcx
    7af8:	48 d1 eb             	shr    $1,%rbx
    7afb:	48 89 ce             	mov    %rcx,%rsi
    7afe:	48 01 de             	add    %rbx,%rsi
    7b01:	48 83 d6 00          	adc    $0x0,%rsi
    7b05:	48 89 f0             	mov    %rsi,%rax
    7b08:	49 f7 e2             	mul    %r10
    7b0b:	48 c1 ea 02          	shr    $0x2,%rdx
    7b0f:	48 8d 04 92          	lea    (%rdx,%rdx,4),%rax
    7b13:	48 29 c6             	sub    %rax,%rsi
    7b16:	48 29 f1             	sub    %rsi,%rcx
    7b19:	48 83 db 00          	sbb    $0x0,%rbx
    7b1d:	48 89 ce             	mov    %rcx,%rsi
    7b20:	49 0f af f3          	imul   %r11,%rsi
    7b24:	48 89 c8             	mov    %rcx,%rax
    7b27:	49 f7 e2             	mul    %r10
    7b2a:	48 01 f2             	add    %rsi,%rdx
    7b2d:	49 0f af da          	imul   %r10,%rbx
    7b31:	48 01 d3             	add    %rdx,%rbx
    7b34:	48 89 c1             	mov    %rax,%rcx
    7b37:	48 01 c1             	add    %rax,%rcx
    7b3a:	48 8d 0c 89          	lea    (%rcx,%rcx,4),%rcx
    7b3e:	44 89 c2             	mov    %r8d,%edx
    7b41:	29 ca                	sub    %ecx,%edx
    7b43:	80 ca 30             	or     $0x30,%dl
    7b46:	88 54 3c 20          	mov    %dl,0x20(%rsp,%rdi,1)
    7b4a:	48 ff c7             	inc    %rdi
    7b4d:	49 83 f8 0a          	cmp    $0xa,%r8
    7b51:	49 83 d9 00          	sbb    $0x0,%r9
    7b55:	49 89 c0             	mov    %rax,%r8
    7b58:	49 89 d9             	mov    %rbx,%r9
    7b5b:	73 93                	jae    7af0 <fwp_write+0x350>
    7b5d:	85 ff                	test   %edi,%edi
    7b5f:	0f 8f 37 09 00 00    	jg     849c <fwp_write+0xcfc>
    7b65:	31 c0                	xor    %eax,%eax
    7b67:	e9 57 0e 00 00       	jmp    89c3 <fwp_write+0x1223>
    7b6c:	c6 44 24 70 5b       	movb   $0x5b,0x70(%rsp)
    7b71:	48 8d 74 24 70       	lea    0x70(%rsp),%rsi
    7b76:	ba 01 00 00 00       	mov    $0x1,%edx
    7b7b:	48 89 ef             	mov    %rbp,%rdi
    7b7e:	e8 fd 0f 00 00       	call   8b80 <buf_put>
    7b83:	4d 85 f6             	test   %r14,%r14
    7b86:	0f 84 e6 0c 00 00    	je     8872 <fwp_write+0x10d2>
    7b8c:	49 8b 57 38          	mov    0x38(%r15),%rdx
    7b90:	49 8b 76 08          	mov    0x8(%r14),%rsi
    7b94:	48 89 ef             	mov    %rbp,%rdi
    7b97:	31 c9                	xor    %ecx,%ecx
    7b99:	e8 02 fc ff ff       	call   77a0 <fwp_write>
    7b9e:	49 8b 5e 10          	mov    0x10(%r14),%rbx
    7ba2:	48 85 db             	test   %rbx,%rbx
    7ba5:	0f 84 c7 0c 00 00    	je     8872 <fwp_write+0x10d2>
    7bab:	4c 8d 35 68 7a 00 00 	lea    0x7a68(%rip),%r14        # f61a <fwp_segv.msg+0x3da>
    7bb2:	66 66 66 66 66 2e 0f 	data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    7bb9:	1f 84 00 00 00 00 00 
    7bc0:	ba 02 00 00 00       	mov    $0x2,%edx
    7bc5:	48 89 ef             	mov    %rbp,%rdi
    7bc8:	4c 89 f6             	mov    %r14,%rsi
    7bcb:	e8 b0 0f 00 00       	call   8b80 <buf_put>
    7bd0:	48 8b 73 08          	mov    0x8(%rbx),%rsi
    7bd4:	49 8b 57 38          	mov    0x38(%r15),%rdx
    7bd8:	48 89 ef             	mov    %rbp,%rdi
    7bdb:	31 c9                	xor    %ecx,%ecx
    7bdd:	e8 be fb ff ff       	call   77a0 <fwp_write>
    7be2:	48 8b 5b 10          	mov    0x10(%rbx),%rbx
    7be6:	48 85 db             	test   %rbx,%rbx
    7be9:	75 d5                	jne    7bc0 <fwp_write+0x420>
    7beb:	e9 82 0c 00 00       	jmp    8872 <fwp_write+0x10d2>
    7bf0:	4d 63 67 48          	movslq 0x48(%r15),%r12
    7bf4:	44 89 e3             	mov    %r12d,%ebx
    7bf7:	49 8d 54 24 03       	lea    0x3(%r12),%rdx
    7bfc:	48 81 fa 00 40 00 00 	cmp    $0x4000,%rdx
    7c03:	0f 87 57 08 00 00    	ja     8460 <fwp_write+0xcc0>
    7c09:	49 8d 4c 24 12       	lea    0x12(%r12),%rcx
    7c0e:	48 c1 e9 04          	shr    $0x4,%rcx
    7c12:	48 8d 05 67 a5 00 00 	lea    0xa567(%rip),%rax        # 12180 <fwp_gc>
    7c19:	0f b6 b4 01 e8 0b 00 	movzbl 0xbe8(%rcx,%rax,1),%esi
    7c20:	00 
    7c21:	8b 8c b0 48 0b 00 00 	mov    0xb48(%rax,%rsi,4),%ecx
    7c28:	48 29 0d 51 a5 00 00 	sub    %rcx,0xa551(%rip)        # 12180 <fwp_gc>
    7c2f:	0f 88 2b 08 00 00    	js     8460 <fwp_write+0xcc0>
    7c35:	48 8d 34 76          	lea    (%rsi,%rsi,2),%rsi
    7c39:	48 8d 3c f0          	lea    (%rax,%rsi,8),%rdi
    7c3d:	48 81 c7 c8 03 00 00 	add    $0x3c8,%rdi
    7c44:	4c 8b 3f             	mov    (%rdi),%r15
    7c47:	4d 85 ff             	test   %r15,%r15
    7c4a:	0f 84 f4 07 00 00    	je     8444 <fwp_write+0xca4>
    7c50:	49 8b 07             	mov    (%r15),%rax
    7c53:	48 f7 d0             	not    %rax
    7c56:	48 89 07             	mov    %rax,(%rdi)
    7c59:	e9 2d 0a 00 00       	jmp    868b <fwp_write+0xeeb>
    7c5e:	49 83 fe ff          	cmp    $0xffffffffffffffff,%r14
    7c62:	48 8d 05 8c 79 00 00 	lea    0x798c(%rip),%rax        # f5f5 <fwp_segv.msg+0x3b5>
    7c69:	48 8d 0d f2 79 00 00 	lea    0x79f2(%rip),%rcx        # f662 <fwp_segv.msg+0x422>
    7c70:	48 0f 44 c8          	cmove  %rax,%rcx
    7c74:	49 83 fe 01          	cmp    $0x1,%r14
    7c78:	4c 8d 35 73 79 00 00 	lea    0x7973(%rip),%r14        # f5f2 <fwp_segv.msg+0x3b2>
    7c7f:	4c 0f 45 f1          	cmovne %rcx,%r14
    7c83:	4c 89 f7             	mov    %r14,%rdi
    7c86:	e8 55 a4 ff ff       	call   20e0 <strlen@plt>
    7c8b:	48 89 ef             	mov    %rbp,%rdi
    7c8e:	4c 89 f6             	mov    %r14,%rsi
    7c91:	e9 b9 0a 00 00       	jmp    874f <fwp_write+0xfaf>
    7c96:	48 8d 35 83 79 00 00 	lea    0x7983(%rip),%rsi        # f620 <fwp_segv.msg+0x3e0>
    7c9d:	ba 06 00 00 00       	mov    $0x6,%edx
    7ca2:	48 89 ef             	mov    %rbp,%rdi
    7ca5:	e8 d6 0e 00 00       	call   8b80 <buf_put>
    7caa:	49 8b 36             	mov    (%r14),%rsi
    7cad:	48 8d 04 75 00 00 00 	lea    0x0(,%rsi,2),%rax
    7cb4:	00 
    7cb5:	48 85 c0             	test   %rax,%rax
    7cb8:	0f 84 b4 0b 00 00    	je     8872 <fwp_write+0x10d2>
    7cbe:	49 8b 57 38          	mov    0x38(%r15),%rdx
    7cc2:	b8 08 00 00 00       	mov    $0x8,%eax
    7cc7:	48 85 d2             	test   %rdx,%rdx
    7cca:	74 13                	je     7cdf <fwp_write+0x53f>
    7ccc:	8b 0a                	mov    (%rdx),%ecx
    7cce:	48 83 f9 0a          	cmp    $0xa,%rcx
    7cd2:	77 0b                	ja     7cdf <fwp_write+0x53f>
    7cd4:	48 8d 05 dd 75 00 00 	lea    0x75dd(%rip),%rax        # f2b8 <fwp_segv.msg+0x78>
    7cdb:	48 8b 04 c8          	mov    (%rax,%rcx,8),%rax
    7cdf:	4d 8d 6e 08          	lea    0x8(%r14),%r13
    7ce3:	4c 89 e9             	mov    %r13,%rcx
    7ce6:	48 85 f6             	test   %rsi,%rsi
    7ce9:	79 04                	jns    7cef <fwp_write+0x54f>
    7ceb:	49 8b 4e 10          	mov    0x10(%r14),%rcx
    7cef:	48 83 f8 01          	cmp    $0x1,%rax
    7cf3:	0f 84 74 0a 00 00    	je     876d <fwp_write+0xfcd>
    7cf9:	48 83 f8 08          	cmp    $0x8,%rax
    7cfd:	0f 84 65 0a 00 00    	je     8768 <fwp_write+0xfc8>
    7d03:	48 83 f8 02          	cmp    $0x2,%rax
    7d07:	0f 85 6c 0a 00 00    	jne    8779 <fwp_write+0xfd9>
    7d0d:	83 3a 01             	cmpl   $0x1,(%rdx)
    7d10:	0f b7 01             	movzwl (%rcx),%eax
    7d13:	48 0f bf f0          	movswq %ax,%rsi
    7d17:	e9 65 0a 00 00       	jmp    8781 <fwp_write+0xfe1>
    7d1c:	48 8d 35 f0 78 00 00 	lea    0x78f0(%rip),%rsi        # f613 <fwp_segv.msg+0x3d3>
    7d23:	ba 06 00 00 00       	mov    $0x6,%edx
    7d28:	48 89 ef             	mov    %rbp,%rdi
    7d2b:	e8 50 0e 00 00       	call   8b80 <buf_put>
    7d30:	49 83 3e 00          	cmpq   $0x0,(%r14)
    7d34:	0f 84 a3 00 00 00    	je     7ddd <fwp_write+0x63d>
    7d3a:	41 0f b6 4e 08       	movzbl 0x8(%r14),%ecx
    7d3f:	48 8d 15 d7 78 00 00 	lea    0x78d7(%rip),%rdx        # f61d <fwp_segv.msg+0x3dd>
    7d46:	4c 8d 7c 24 70       	lea    0x70(%rsp),%r15
    7d4b:	be 00 02 00 00       	mov    $0x200,%esi
    7d50:	4c 89 ff             	mov    %r15,%rdi
    7d53:	31 c0                	xor    %eax,%eax
    7d55:	e8 b6 a3 ff ff       	call   2110 <snprintf@plt>
    7d5a:	4c 89 ff             	mov    %r15,%rdi
    7d5d:	e8 7e a3 ff ff       	call   20e0 <strlen@plt>
    7d62:	48 89 ef             	mov    %rbp,%rdi
    7d65:	4c 89 fe             	mov    %r15,%rsi
    7d68:	48 89 c2             	mov    %rax,%rdx
    7d6b:	e8 10 0e 00 00       	call   8b80 <buf_put>
    7d70:	49 83 3e 02          	cmpq   $0x2,(%r14)
    7d74:	72 67                	jb     7ddd <fwp_write+0x63d>
    7d76:	bb 09 00 00 00       	mov    $0x9,%ebx
    7d7b:	4c 8d 3d 98 78 00 00 	lea    0x7898(%rip),%r15        # f61a <fwp_segv.msg+0x3da>
    7d82:	4c 8d 25 94 78 00 00 	lea    0x7894(%rip),%r12        # f61d <fwp_segv.msg+0x3dd>
    7d89:	4c 8d 6c 24 70       	lea    0x70(%rsp),%r13
    7d8e:	66 90                	xchg   %ax,%ax
    7d90:	ba 02 00 00 00       	mov    $0x2,%edx
    7d95:	48 89 ef             	mov    %rbp,%rdi
    7d98:	4c 89 fe             	mov    %r15,%rsi
    7d9b:	e8 e0 0d 00 00       	call   8b80 <buf_put>
    7da0:	41 0f b6 0c 1e       	movzbl (%r14,%rbx,1),%ecx
    7da5:	be 00 02 00 00       	mov    $0x200,%esi
    7daa:	4c 89 ef             	mov    %r13,%rdi
    7dad:	4c 89 e2             	mov    %r12,%rdx
    7db0:	31 c0                	xor    %eax,%eax
    7db2:	e8 59 a3 ff ff       	call   2110 <snprintf@plt>
    7db7:	4c 89 ef             	mov    %r13,%rdi
    7dba:	e8 21 a3 ff ff       	call   20e0 <strlen@plt>
    7dbf:	48 89 ef             	mov    %rbp,%rdi
    7dc2:	4c 89 ee             	mov    %r13,%rsi
    7dc5:	48 89 c2             	mov    %rax,%rdx
    7dc8:	e8 b3 0d 00 00       	call   8b80 <buf_put>
    7dcd:	48 8d 43 01          	lea    0x1(%rbx),%rax
    7dd1:	48 83 c3 f9          	add    $0xfffffffffffffff9,%rbx
    7dd5:	49 3b 1e             	cmp    (%r14),%rbx
    7dd8:	48 89 c3             	mov    %rax,%rbx
    7ddb:	72 b3                	jb     7d90 <fwp_write+0x5f0>
    7ddd:	c6 44 24 20 5d       	movb   $0x5d,0x20(%rsp)
    7de2:	48 8d 74 24 20       	lea    0x20(%rsp),%rsi
    7de7:	e9 90 0a 00 00       	jmp    887c <fwp_write+0x10dc>
    7dec:	66 41 0f 6e ce       	movd   %r14d,%xmm1
    7df1:	0f 2e c9             	ucomiss %xmm1,%xmm1
    7df4:	0f 8a 73 0d 00 00    	jp     8b6d <fwp_write+0x13cd>
    7dfa:	0f 28 05 df 72 00 00 	movaps 0x72df(%rip),%xmm0        # f0e0 <_IO_stdin_used+0xe0>
    7e01:	0f 54 c1             	andps  %xmm1,%xmm0
    7e04:	0f 2e 05 01 72 00 00 	ucomiss 0x7201(%rip),%xmm0        # f00c <_IO_stdin_used+0xc>
    7e0b:	0f 82 6e 04 00 00    	jb     827f <fwp_write+0xadf>
    7e11:	0f 57 c0             	xorps  %xmm0,%xmm0
    7e14:	0f 2e c8             	ucomiss %xmm0,%xmm1
    7e17:	48 8d 05 2b 78 00 00 	lea    0x782b(%rip),%rax        # f649 <fwp_segv.msg+0x409>
    7e1e:	48 8d 35 23 78 00 00 	lea    0x7823(%rip),%rsi        # f648 <fwp_segv.msg+0x408>
    7e25:	48 0f 47 f0          	cmova  %rax,%rsi
    7e29:	48 8d 7c 24 70       	lea    0x70(%rsp),%rdi
    7e2e:	e8 4d a2 ff ff       	call   2080 <strcpy@plt>
    7e33:	e9 90 0b 00 00       	jmp    89c8 <fwp_write+0x1228>
    7e38:	48 8d 35 b9 77 00 00 	lea    0x77b9(%rip),%rsi        # f5f8 <fwp_segv.msg+0x3b8>
    7e3f:	ba 0a 00 00 00       	mov    $0xa,%edx
    7e44:	48 89 ef             	mov    %rbp,%rdi
    7e47:	e9 06 09 00 00       	jmp    8752 <fwp_write+0xfb2>
    7e4c:	48 8d 35 b9 77 00 00 	lea    0x77b9(%rip),%rsi        # f60c <fwp_segv.msg+0x3cc>
    7e53:	ba 06 00 00 00       	mov    $0x6,%edx
    7e58:	48 89 ef             	mov    %rbp,%rdi
    7e5b:	e8 20 0d 00 00       	call   8b80 <buf_put>
    7e60:	49 83 c6 10          	add    $0x10,%r14
    7e64:	4c 89 f7             	mov    %r14,%rdi
    7e67:	e8 74 a2 ff ff       	call   20e0 <strlen@plt>
    7e6c:	48 89 ef             	mov    %rbp,%rdi
    7e6f:	4c 89 f6             	mov    %r14,%rsi
    7e72:	48 89 c2             	mov    %rax,%rdx
    7e75:	e8 06 0d 00 00       	call   8b80 <buf_put>
    7e7a:	c6 44 24 70 3e       	movb   $0x3e,0x70(%rsp)
    7e7f:	e9 f3 09 00 00       	jmp    8877 <fwp_write+0x10d7>
    7e84:	41 8b 06             	mov    (%r14),%eax
    7e87:	49 8b 4f 18          	mov    0x18(%r15),%rcx
    7e8b:	41 89 c5             	mov    %eax,%r13d
    7e8e:	4e 8b 24 e9          	mov    (%rcx,%r13,8),%r12
    7e92:	4c 89 e7             	mov    %r12,%rdi
    7e95:	e8 46 a2 ff ff       	call   20e0 <strlen@plt>
    7e9a:	48 89 ef             	mov    %rbp,%rdi
    7e9d:	4c 89 e6             	mov    %r12,%rsi
    7ea0:	48 89 c2             	mov    %rax,%rdx
    7ea3:	e8 d8 0c 00 00       	call   8b80 <buf_put>
    7ea8:	49 8b 47 28          	mov    0x28(%r15),%rax
    7eac:	42 83 3c a8 00       	cmpl   $0x0,(%rax,%r13,4)
    7eb1:	0f 8e 2c 0b 00 00    	jle    89e3 <fwp_write+0x1243>
    7eb7:	45 31 e4             	xor    %r12d,%r12d
    7eba:	4c 89 7c 24 10       	mov    %r15,0x10(%rsp)
    7ebf:	4c 89 6c 24 68       	mov    %r13,0x68(%rsp)
    7ec4:	eb 3c                	jmp    7f02 <fwp_write+0x762>
    7ec6:	66 2e 0f 1f 84 00 00 	cs nopw 0x0(%rax,%rax,1)
    7ecd:	00 00 00 
    7ed0:	48 8b 2c 24          	mov    (%rsp),%rbp
    7ed4:	48 89 ef             	mov    %rbp,%rdi
    7ed7:	48 89 de             	mov    %rbx,%rsi
    7eda:	4c 89 ea             	mov    %r13,%rdx
    7edd:	31 c9                	xor    %ecx,%ecx
    7edf:	e8 bc f8 ff ff       	call   77a0 <fwp_write>
    7ee4:	49 ff c4             	inc    %r12
    7ee7:	4c 8b 7c 24 10       	mov    0x10(%rsp),%r15
    7eec:	49 8b 47 28          	mov    0x28(%r15),%rax
    7ef0:	4c 8b 6c 24 68       	mov    0x68(%rsp),%r13
    7ef5:	4a 63 04 a8          	movslq (%rax,%r13,4),%rax
    7ef9:	49 39 c4             	cmp    %rax,%r12
    7efc:	0f 8d e1 0a 00 00    	jge    89e3 <fwp_write+0x1243>
    7f02:	4b 8b 5c e6 08       	mov    0x8(%r14,%r12,8),%rbx
    7f07:	49 8b 47 30          	mov    0x30(%r15),%rax
    7f0b:	4a 8b 04 e8          	mov    (%rax,%r13,8),%rax
    7f0f:	4e 8b 2c e0          	mov    (%rax,%r12,8),%r13
    7f13:	c6 44 24 70 20       	movb   $0x20,0x70(%rsp)
    7f18:	ba 01 00 00 00       	mov    $0x1,%edx
    7f1d:	48 89 ef             	mov    %rbp,%rdi
    7f20:	48 8d 74 24 70       	lea    0x70(%rsp),%rsi
    7f25:	e8 56 0c 00 00       	call   8b80 <buf_put>
    7f2a:	41 8b 45 00          	mov    0x0(%r13),%eax
    7f2e:	48 83 f8 10          	cmp    $0x10,%rax
    7f32:	77 9c                	ja     7ed0 <fwp_write+0x730>
    7f34:	48 8d 0d 4d 72 00 00 	lea    0x724d(%rip),%rcx        # f188 <_IO_stdin_used+0x188>
    7f3b:	48 63 04 81          	movslq (%rcx,%rax,4),%rax
    7f3f:	48 01 c8             	add    %rcx,%rax
    7f42:	ff e0                	jmp    *%rax
    7f44:	48 89 d9             	mov    %rbx,%rcx
    7f47:	48 c1 e9 3f          	shr    $0x3f,%rcx
    7f4b:	85 c9                	test   %ecx,%ecx
    7f4d:	74 81                	je     7ed0 <fwp_write+0x730>
    7f4f:	c6 44 24 70 28       	movb   $0x28,0x70(%rsp)
    7f54:	ba 01 00 00 00       	mov    $0x1,%edx
    7f59:	48 8b 2c 24          	mov    (%rsp),%rbp
    7f5d:	48 89 ef             	mov    %rbp,%rdi
    7f60:	4c 8d 7c 24 70       	lea    0x70(%rsp),%r15
    7f65:	4c 89 fe             	mov    %r15,%rsi
    7f68:	e8 13 0c 00 00       	call   8b80 <buf_put>
    7f6d:	48 89 ef             	mov    %rbp,%rdi
    7f70:	48 89 de             	mov    %rbx,%rsi
    7f73:	4c 89 ea             	mov    %r13,%rdx
    7f76:	31 c9                	xor    %ecx,%ecx
    7f78:	e8 23 f8 ff ff       	call   77a0 <fwp_write>
    7f7d:	c6 44 24 70 29       	movb   $0x29,0x70(%rsp)
    7f82:	ba 01 00 00 00       	mov    $0x1,%edx
    7f87:	48 89 ef             	mov    %rbp,%rdi
    7f8a:	4c 89 fe             	mov    %r15,%rsi
    7f8d:	e8 ee 0b 00 00       	call   8b80 <buf_put>
    7f92:	e9 4d ff ff ff       	jmp    7ee4 <fwp_write+0x744>
    7f97:	31 c9                	xor    %ecx,%ecx
    7f99:	48 81 fb 00 10 00 00 	cmp    $0x1000,%rbx
    7fa0:	0f 93 c1             	setae  %cl
    7fa3:	eb a6                	jmp    7f4b <fwp_write+0x7ab>
    7fa5:	48 8b 4b 08          	mov    0x8(%rbx),%rcx
    7fa9:	eb 9c                	jmp    7f47 <fwp_write+0x7a7>
    7fab:	89 d9                	mov    %ebx,%ecx
    7fad:	c1 e9 1f             	shr    $0x1f,%ecx
    7fb0:	eb 99                	jmp    7f4b <fwp_write+0x7ab>
    7fb2:	49 8b 7d 08          	mov    0x8(%r13),%rdi
    7fb6:	48 85 ff             	test   %rdi,%rdi
    7fb9:	0f 84 11 ff ff ff    	je     7ed0 <fwp_write+0x730>
    7fbf:	48 8d 35 6e 76 00 00 	lea    0x766e(%rip),%rsi        # f634 <fwp_segv.msg+0x3f4>
    7fc6:	e8 b5 a1 ff ff       	call   2180 <strcmp@plt>
    7fcb:	31 c9                	xor    %ecx,%ecx
    7fcd:	85 c0                	test   %eax,%eax
    7fcf:	0f 95 c1             	setne  %cl
    7fd2:	e9 74 ff ff ff       	jmp    7f4b <fwp_write+0x7ab>
    7fd7:	41 83 7f 10 00       	cmpl   $0x0,0x10(%r15)
    7fdc:	0f 84 a7 08 00 00    	je     8889 <fwp_write+0x10e9>
    7fe2:	4d 8d 6f 10          	lea    0x10(%r15),%r13
    7fe6:	4d 85 e4             	test   %r12,%r12
    7fe9:	0f 94 c0             	sete   %al
    7fec:	41 83 7f 48 00       	cmpl   $0x0,0x48(%r15)
    7ff1:	0f 95 c3             	setne  %bl
    7ff4:	20 c3                	and    %al,%bl
    7ff6:	84 db                	test   %bl,%bl
    7ff8:	b8 28 00 00 00       	mov    $0x28,%eax
    7ffd:	b9 7b 00 00 00       	mov    $0x7b,%ecx
    8002:	0f 45 c8             	cmovne %eax,%ecx
    8005:	88 4c 24 70          	mov    %cl,0x70(%rsp)
    8009:	48 8d 74 24 70       	lea    0x70(%rsp),%rsi
    800e:	ba 01 00 00 00       	mov    $0x1,%edx
    8013:	48 89 ef             	mov    %rbp,%rdi
    8016:	e8 65 0b 00 00       	call   8b80 <buf_put>
    801b:	41 83 7d 00 00       	cmpl   $0x0,0x0(%r13)
    8020:	0f 8e da 00 00 00    	jle    8100 <fwp_write+0x960>
    8026:	84 db                	test   %bl,%bl
    8028:	75 31                	jne    805b <fwp_write+0x8bb>
    802a:	49 8b 47 18          	mov    0x18(%r15),%rax
    802e:	4c 8b 20             	mov    (%rax),%r12
    8031:	4c 89 e7             	mov    %r12,%rdi
    8034:	e8 a7 a0 ff ff       	call   20e0 <strlen@plt>
    8039:	48 89 ef             	mov    %rbp,%rdi
    803c:	4c 89 e6             	mov    %r12,%rsi
    803f:	48 89 c2             	mov    %rax,%rdx
    8042:	e8 39 0b 00 00       	call   8b80 <buf_put>
    8047:	48 8d 35 f2 75 00 00 	lea    0x75f2(%rip),%rsi        # f640 <fwp_segv.msg+0x400>
    804e:	ba 03 00 00 00       	mov    $0x3,%edx
    8053:	48 89 ef             	mov    %rbp,%rdi
    8056:	e8 25 0b 00 00       	call   8b80 <buf_put>
    805b:	49 8b 76 08          	mov    0x8(%r14),%rsi
    805f:	49 8b 47 20          	mov    0x20(%r15),%rax
    8063:	48 8b 10             	mov    (%rax),%rdx
    8066:	48 89 ef             	mov    %rbp,%rdi
    8069:	31 c9                	xor    %ecx,%ecx
    806b:	e8 30 f7 ff ff       	call   77a0 <fwp_write>
    8070:	41 83 7f 10 02       	cmpl   $0x2,0x10(%r15)
    8075:	0f 8c 85 00 00 00    	jl     8100 <fwp_write+0x960>
    807b:	41 bd 01 00 00 00    	mov    $0x1,%r13d
    8081:	4c 8d 25 92 75 00 00 	lea    0x7592(%rip),%r12        # f61a <fwp_segv.msg+0x3da>
    8088:	eb 29                	jmp    80b3 <fwp_write+0x913>
    808a:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)
    8090:	4b 8b 74 ee 08       	mov    0x8(%r14,%r13,8),%rsi
    8095:	49 8b 47 20          	mov    0x20(%r15),%rax
    8099:	4a 8b 14 e8          	mov    (%rax,%r13,8),%rdx
    809d:	48 89 ef             	mov    %rbp,%rdi
    80a0:	31 c9                	xor    %ecx,%ecx
    80a2:	e8 f9 f6 ff ff       	call   77a0 <fwp_write>
    80a7:	49 ff c5             	inc    %r13
    80aa:	49 63 47 10          	movslq 0x10(%r15),%rax
    80ae:	49 39 c5             	cmp    %rax,%r13
    80b1:	7d 4d                	jge    8100 <fwp_write+0x960>
    80b3:	ba 02 00 00 00       	mov    $0x2,%edx
    80b8:	48 89 ef             	mov    %rbp,%rdi
    80bb:	4c 89 e6             	mov    %r12,%rsi
    80be:	e8 bd 0a 00 00       	call   8b80 <buf_put>
    80c3:	84 db                	test   %bl,%bl
    80c5:	75 c9                	jne    8090 <fwp_write+0x8f0>
    80c7:	49 8b 47 18          	mov    0x18(%r15),%rax
    80cb:	4a 8b 2c e8          	mov    (%rax,%r13,8),%rbp
    80cf:	48 89 ef             	mov    %rbp,%rdi
    80d2:	e8 09 a0 ff ff       	call   20e0 <strlen@plt>
    80d7:	48 8b 3c 24          	mov    (%rsp),%rdi
    80db:	48 89 ee             	mov    %rbp,%rsi
    80de:	48 8b 2c 24          	mov    (%rsp),%rbp
    80e2:	48 89 c2             	mov    %rax,%rdx
    80e5:	e8 96 0a 00 00       	call   8b80 <buf_put>
    80ea:	ba 03 00 00 00       	mov    $0x3,%edx
    80ef:	48 89 ef             	mov    %rbp,%rdi
    80f2:	48 8d 35 47 75 00 00 	lea    0x7547(%rip),%rsi        # f640 <fwp_segv.msg+0x400>
    80f9:	e8 82 0a 00 00       	call   8b80 <buf_put>
    80fe:	eb 90                	jmp    8090 <fwp_write+0x8f0>
    8100:	84 db                	test   %bl,%bl
    8102:	b8 29 00 00 00       	mov    $0x29,%eax
    8107:	b9 7d 00 00 00       	mov    $0x7d,%ecx
    810c:	0f 45 c8             	cmovne %eax,%ecx
    810f:	88 4c 24 70          	mov    %cl,0x70(%rsp)
    8113:	e9 5f 07 00 00       	jmp    8877 <fwp_write+0x10d7>
    8118:	48 89 ef             	mov    %rbp,%rdi
    811b:	48 81 c4 78 02 00 00 	add    $0x278,%rsp
    8122:	5b                   	pop    %rbx
    8123:	41 5c                	pop    %r12
    8125:	41 5d                	pop    %r13
    8127:	41 5e                	pop    %r14
    8129:	41 5f                	pop    %r15
    812b:	5d                   	pop    %rbp
    812c:	e9 3f 0b 00 00       	jmp    8c70 <fwp_escape>
    8131:	c6 44 24 20 30       	movb   $0x30,0x20(%rsp)
    8136:	bf 01 00 00 00       	mov    $0x1,%edi
    813b:	89 f8                	mov    %edi,%eax
    813d:	48 83 f8 08          	cmp    $0x8,%rax
    8141:	73 0a                	jae    814d <fwp_write+0x9ad>
    8143:	31 c9                	xor    %ecx,%ecx
    8145:	48 89 c2             	mov    %rax,%rdx
    8148:	e9 7a 04 00 00       	jmp    85c7 <fwp_write+0xe27>
    814d:	83 f8 20             	cmp    $0x20,%eax
    8150:	0f 83 68 03 00 00    	jae    84be <fwp_write+0xd1e>
    8156:	31 c9                	xor    %ecx,%ecx
    8158:	e9 10 04 00 00       	jmp    856d <fwp_write+0xdcd>
    815d:	31 ff                	xor    %edi,%edi
    815f:	49 f7 d8             	neg    %r8
    8162:	41 ba 00 00 00 00    	mov    $0x0,%r10d
    8168:	4d 19 ca             	sbb    %r9,%r10
    816b:	c6 44 24 70 2d       	movb   $0x2d,0x70(%rsp)
    8170:	49 b9 cd cc cc cc cc 	movabs $0xcccccccccccccccd,%r9
    8177:	cc cc cc 
    817a:	49 bb cc cc cc cc cc 	movabs $0xcccccccccccccccc,%r11
    8181:	cc cc cc 
    8184:	4c 89 d3             	mov    %r10,%rbx
    8187:	66 0f 1f 84 00 00 00 	nopw   0x0(%rax,%rax,1)
    818e:	00 00 
    8190:	4c 89 d1             	mov    %r10,%rcx
    8193:	4c 0f a4 c1 3f       	shld   $0x3f,%r8,%rcx
    8198:	48 d1 eb             	shr    $1,%rbx
    819b:	48 89 ce             	mov    %rcx,%rsi
    819e:	48 01 de             	add    %rbx,%rsi
    81a1:	48 83 d6 00          	adc    $0x0,%rsi
    81a5:	48 89 f0             	mov    %rsi,%rax
    81a8:	49 f7 e1             	mul    %r9
    81ab:	48 c1 ea 02          	shr    $0x2,%rdx
    81af:	48 8d 04 92          	lea    (%rdx,%rdx,4),%rax
    81b3:	48 29 c6             	sub    %rax,%rsi
    81b6:	48 29 f1             	sub    %rsi,%rcx
    81b9:	48 83 db 00          	sbb    $0x0,%rbx
    81bd:	48 89 ce             	mov    %rcx,%rsi
    81c0:	49 0f af f3          	imul   %r11,%rsi
    81c4:	48 89 c8             	mov    %rcx,%rax
    81c7:	49 f7 e1             	mul    %r9
    81ca:	48 01 f2             	add    %rsi,%rdx
    81cd:	49 0f af d9          	imul   %r9,%rbx
    81d1:	48 01 d3             	add    %rdx,%rbx
    81d4:	48 89 c1             	mov    %rax,%rcx
    81d7:	48 01 c1             	add    %rax,%rcx
    81da:	48 8d 0c 89          	lea    (%rcx,%rcx,4),%rcx
    81de:	44 89 c2             	mov    %r8d,%edx
    81e1:	29 ca                	sub    %ecx,%edx
    81e3:	80 ca 30             	or     $0x30,%dl
    81e6:	88 54 3c 20          	mov    %dl,0x20(%rsp,%rdi,1)
    81ea:	48 ff c7             	inc    %rdi
    81ed:	49 83 f8 0a          	cmp    $0xa,%r8
    81f1:	49 83 da 00          	sbb    $0x0,%r10
    81f5:	49 89 c0             	mov    %rax,%r8
    81f8:	49 89 da             	mov    %rbx,%r10
    81fb:	73 93                	jae    8190 <fwp_write+0x9f0>
    81fd:	85 ff                	test   %edi,%edi
    81ff:	0f 8e 98 06 00 00    	jle    889d <fwp_write+0x10fd>
    8205:	89 f8                	mov    %edi,%eax
    8207:	48 83 f8 08          	cmp    $0x8,%rax
    820b:	0f 83 e4 07 00 00    	jae    89f5 <fwp_write+0x1255>
    8211:	31 c9                	xor    %ecx,%ecx
    8213:	48 89 c2             	mov    %rax,%rdx
    8216:	e9 fc 08 00 00       	jmp    8b17 <fwp_write+0x1377>
    821b:	bd 01 00 00 00       	mov    $0x1,%ebp
    8220:	4c 8d 74 24 70       	lea    0x70(%rsp),%r14
    8225:	0f 29 4c 24 10       	movaps %xmm1,0x10(%rsp)
    822a:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)
    8230:	4c 89 f7             	mov    %r14,%rdi
    8233:	66 0f 28 c1          	movapd %xmm1,%xmm0
    8237:	89 ee                	mov    %ebp,%esi
    8239:	e8 a2 16 00 00       	call   98e0 <fwp_format_g>
    823e:	4c 89 f7             	mov    %r14,%rdi
    8241:	31 f6                	xor    %esi,%esi
    8243:	e8 58 9e ff ff       	call   20a0 <strtod@plt>
    8248:	66 0f 28 4c 24 10    	movapd 0x10(%rsp),%xmm1
    824e:	66 0f 2e c1          	ucomisd %xmm1,%xmm0
    8252:	75 06                	jne    825a <fwp_write+0xaba>
    8254:	0f 8b 9e 03 00 00    	jnp    85f8 <fwp_write+0xe58>
    825a:	ff c5                	inc    %ebp
    825c:	83 fd 12             	cmp    $0x12,%ebp
    825f:	75 cf                	jne    8230 <fwp_write+0xa90>
    8261:	4c 8d 74 24 70       	lea    0x70(%rsp),%r14
    8266:	4c 89 f7             	mov    %r14,%rdi
    8269:	66 0f 28 c1          	movapd %xmm1,%xmm0
    826d:	be 11 00 00 00       	mov    $0x11,%esi
    8272:	e8 69 16 00 00       	call   98e0 <fwp_format_g>
    8277:	4c 89 f7             	mov    %r14,%rdi
    827a:	e9 7e 03 00 00       	jmp    85fd <fwp_write+0xe5d>
    827f:	0f 57 c0             	xorps  %xmm0,%xmm0
    8282:	f3 0f 5a c1          	cvtss2sd %xmm1,%xmm0
    8286:	4c 8d 74 24 70       	lea    0x70(%rsp),%r14
    828b:	4c 89 f7             	mov    %r14,%rdi
    828e:	f2 0f 11 44 24 10    	movsd  %xmm0,0x10(%rsp)
    8294:	be 01 00 00 00       	mov    $0x1,%esi
    8299:	0f 29 0c 24          	movaps %xmm1,(%rsp)
    829d:	e8 3e 16 00 00       	call   98e0 <fwp_format_g>
    82a2:	4c 89 f7             	mov    %r14,%rdi
    82a5:	31 f6                	xor    %esi,%esi
    82a7:	e8 74 9e ff ff       	call   2120 <strtof@plt>
    82ac:	0f 2e 04 24          	ucomiss (%rsp),%xmm0
    82b0:	75 06                	jne    82b8 <fwp_write+0xb18>
    82b2:	0f 8b 6f 01 00 00    	jnp    8427 <fwp_write+0xc87>
    82b8:	4c 8d 74 24 70       	lea    0x70(%rsp),%r14
    82bd:	4c 89 f7             	mov    %r14,%rdi
    82c0:	f2 0f 10 44 24 10    	movsd  0x10(%rsp),%xmm0
    82c6:	be 02 00 00 00       	mov    $0x2,%esi
    82cb:	e8 10 16 00 00       	call   98e0 <fwp_format_g>
    82d0:	4c 89 f7             	mov    %r14,%rdi
    82d3:	31 f6                	xor    %esi,%esi
    82d5:	e8 46 9e ff ff       	call   2120 <strtof@plt>
    82da:	0f 2e 04 24          	ucomiss (%rsp),%xmm0
    82de:	75 06                	jne    82e6 <fwp_write+0xb46>
    82e0:	0f 8b 41 01 00 00    	jnp    8427 <fwp_write+0xc87>
    82e6:	4c 8d 74 24 70       	lea    0x70(%rsp),%r14
    82eb:	4c 89 f7             	mov    %r14,%rdi
    82ee:	f2 0f 10 44 24 10    	movsd  0x10(%rsp),%xmm0
    82f4:	be 03 00 00 00       	mov    $0x3,%esi
    82f9:	e8 e2 15 00 00       	call   98e0 <fwp_format_g>
    82fe:	4c 89 f7             	mov    %r14,%rdi
    8301:	31 f6                	xor    %esi,%esi
    8303:	e8 18 9e ff ff       	call   2120 <strtof@plt>
    8308:	0f 2e 04 24          	ucomiss (%rsp),%xmm0
    830c:	75 06                	jne    8314 <fwp_write+0xb74>
    830e:	0f 8b 13 01 00 00    	jnp    8427 <fwp_write+0xc87>
    8314:	4c 8d 74 24 70       	lea    0x70(%rsp),%r14
    8319:	4c 89 f7             	mov    %r14,%rdi
    831c:	f2 0f 10 44 24 10    	movsd  0x10(%rsp),%xmm0
    8322:	be 04 00 00 00       	mov    $0x4,%esi
    8327:	e8 b4 15 00 00       	call   98e0 <fwp_format_g>
    832c:	4c 89 f7             	mov    %r14,%rdi
    832f:	31 f6                	xor    %esi,%esi
    8331:	e8 ea 9d ff ff       	call   2120 <strtof@plt>
    8336:	0f 2e 04 24          	ucomiss (%rsp),%xmm0
    833a:	75 06                	jne    8342 <fwp_write+0xba2>
    833c:	0f 8b e5 00 00 00    	jnp    8427 <fwp_write+0xc87>
    8342:	4c 8d 74 24 70       	lea    0x70(%rsp),%r14
    8347:	4c 89 f7             	mov    %r14,%rdi
    834a:	f2 0f 10 44 24 10    	movsd  0x10(%rsp),%xmm0
    8350:	be 05 00 00 00       	mov    $0x5,%esi
    8355:	e8 86 15 00 00       	call   98e0 <fwp_format_g>
    835a:	4c 89 f7             	mov    %r14,%rdi
    835d:	31 f6                	xor    %esi,%esi
    835f:	e8 bc 9d ff ff       	call   2120 <strtof@plt>
    8364:	0f 2e 04 24          	ucomiss (%rsp),%xmm0
    8368:	75 06                	jne    8370 <fwp_write+0xbd0>
    836a:	0f 8b b7 00 00 00    	jnp    8427 <fwp_write+0xc87>
    8370:	4c 8d 74 24 70       	lea    0x70(%rsp),%r14
    8375:	4c 89 f7             	mov    %r14,%rdi
    8378:	f2 0f 10 44 24 10    	movsd  0x10(%rsp),%xmm0
    837e:	be 06 00 00 00       	mov    $0x6,%esi
    8383:	e8 58 15 00 00       	call   98e0 <fwp_format_g>
    8388:	4c 89 f7             	mov    %r14,%rdi
    838b:	31 f6                	xor    %esi,%esi
    838d:	e8 8e 9d ff ff       	call   2120 <strtof@plt>
    8392:	0f 2e 04 24          	ucomiss (%rsp),%xmm0
    8396:	75 06                	jne    839e <fwp_write+0xbfe>
    8398:	0f 8b 89 00 00 00    	jnp    8427 <fwp_write+0xc87>
    839e:	4c 8d 74 24 70       	lea    0x70(%rsp),%r14
    83a3:	4c 89 f7             	mov    %r14,%rdi
    83a6:	f2 0f 10 44 24 10    	movsd  0x10(%rsp),%xmm0
    83ac:	be 07 00 00 00       	mov    $0x7,%esi
    83b1:	e8 2a 15 00 00       	call   98e0 <fwp_format_g>
    83b6:	4c 89 f7             	mov    %r14,%rdi
    83b9:	31 f6                	xor    %esi,%esi
    83bb:	e8 60 9d ff ff       	call   2120 <strtof@plt>
    83c0:	0f 2e 04 24          	ucomiss (%rsp),%xmm0
    83c4:	75 02                	jne    83c8 <fwp_write+0xc28>
    83c6:	7b 5f                	jnp    8427 <fwp_write+0xc87>
    83c8:	4c 8d 74 24 70       	lea    0x70(%rsp),%r14
    83cd:	4c 89 f7             	mov    %r14,%rdi
    83d0:	f2 0f 10 44 24 10    	movsd  0x10(%rsp),%xmm0
    83d6:	be 08 00 00 00       	mov    $0x8,%esi
    83db:	e8 00 15 00 00       	call   98e0 <fwp_format_g>
    83e0:	4c 89 f7             	mov    %r14,%rdi
    83e3:	31 f6                	xor    %esi,%esi
    83e5:	e8 36 9d ff ff       	call   2120 <strtof@plt>
    83ea:	0f 28 0c 24          	movaps (%rsp),%xmm1
    83ee:	0f 2e c1             	ucomiss %xmm1,%xmm0
    83f1:	75 02                	jne    83f5 <fwp_write+0xc55>
    83f3:	7b 32                	jnp    8427 <fwp_write+0xc87>
    83f5:	4c 8d 74 24 70       	lea    0x70(%rsp),%r14
    83fa:	4c 89 f7             	mov    %r14,%rdi
    83fd:	f2 0f 10 44 24 10    	movsd  0x10(%rsp),%xmm0
    8403:	be 09 00 00 00       	mov    $0x9,%esi
    8408:	e8 d3 14 00 00       	call   98e0 <fwp_format_g>
    840d:	4c 89 f7             	mov    %r14,%rdi
    8410:	31 f6                	xor    %esi,%esi
    8412:	e8 09 9d ff ff       	call   2120 <strtof@plt>
    8417:	0f 2e 04 24          	ucomiss (%rsp),%xmm0
    841b:	0f 85 2c 07 00 00    	jne    8b4d <fwp_write+0x13ad>
    8421:	0f 8a 26 07 00 00    	jp     8b4d <fwp_write+0x13ad>
    8427:	48 8d 7c 24 70       	lea    0x70(%rsp),%rdi
    842c:	be 2e 00 00 00       	mov    $0x2e,%esi
    8431:	e8 ca 9c ff ff       	call   2100 <strchr@plt>
    8436:	48 85 c0             	test   %rax,%rax
    8439:	0f 85 89 05 00 00    	jne    89c8 <fwp_write+0x1228>
    843f:	e9 d0 01 00 00       	jmp    8614 <fwp_write+0xe74>
    8444:	4c 8b bc f0 d0 03 00 	mov    0x3d0(%rax,%rsi,8),%r15
    844b:	00 
    844c:	48 8b bc f0 d8 03 00 	mov    0x3d8(%rax,%rsi,8),%rdi
    8453:	00 
    8454:	4c 29 ff             	sub    %r15,%rdi
    8457:	48 39 cf             	cmp    %rcx,%rdi
    845a:	0f 83 1b 02 00 00    	jae    867b <fwp_write+0xedb>
    8460:	48 89 d7             	mov    %rdx,%rdi
    8463:	be 01 00 00 00       	mov    $0x1,%esi
    8468:	e8 03 e2 ff ff       	call   6670 <fwp_gc_alloc_slow>
    846d:	49 89 c7             	mov    %rax,%r15
    8470:	e9 20 02 00 00       	jmp    8695 <fwp_write+0xef5>
    8475:	49 8b 76 08          	mov    0x8(%r14),%rsi
    8479:	48 89 f2             	mov    %rsi,%rdx
    847c:	48 c1 fa 3f          	sar    $0x3f,%rdx
    8480:	4c 8d 74 24 70       	lea    0x70(%rsp),%r14
    8485:	4c 89 f7             	mov    %r14,%rdi
    8488:	e8 23 09 00 00       	call   8db0 <fwp_fmt_duration>
    848d:	e9 3b 05 00 00       	jmp    89cd <fwp_write+0x122d>
    8492:	c6 44 24 20 30       	movb   $0x30,0x20(%rsp)
    8497:	bf 01 00 00 00       	mov    $0x1,%edi
    849c:	89 f8                	mov    %edi,%eax
    849e:	48 83 f8 08          	cmp    $0x8,%rax
    84a2:	73 0a                	jae    84ae <fwp_write+0xd0e>
    84a4:	31 c9                	xor    %ecx,%ecx
    84a6:	48 89 c2             	mov    %rax,%rdx
    84a9:	e9 f2 04 00 00       	jmp    89a0 <fwp_write+0x1200>
    84ae:	83 f8 20             	cmp    $0x20,%eax
    84b1:	0f 83 f2 03 00 00    	jae    88a9 <fwp_write+0x1109>
    84b7:	31 c9                	xor    %ecx,%ecx
    84b9:	e9 92 04 00 00       	jmp    8950 <fwp_write+0x11b0>
    84be:	89 fa                	mov    %edi,%edx
    84c0:	83 e2 1f             	and    $0x1f,%edx
    84c3:	48 89 c1             	mov    %rax,%rcx
    84c6:	48 29 d1             	sub    %rdx,%rcx
    84c9:	48 8d b4 24 80 00 00 	lea    0x80(%rsp),%rsi
    84d0:	00 
    84d1:	66 0f ef c0          	pxor   %xmm0,%xmm0
    84d5:	49 89 c0             	mov    %rax,%r8
    84d8:	0f 1f 84 00 00 00 00 	nopl   0x0(%rax,%rax,1)
    84df:	00 
    84e0:	f3 42 0f 6f 0c 04    	movdqu (%rsp,%r8,1),%xmm1
    84e6:	f3 42 0f 6f 54 04 10 	movdqu 0x10(%rsp,%r8,1),%xmm2
    84ed:	66 0f 6f da          	movdqa %xmm2,%xmm3
    84f1:	66 0f 60 d8          	punpcklbw %xmm0,%xmm3
    84f5:	66 0f 70 db 4e       	pshufd $0x4e,%xmm3,%xmm3
    84fa:	f2 0f 70 db 1b       	pshuflw $0x1b,%xmm3,%xmm3
    84ff:	f3 0f 70 db 1b       	pshufhw $0x1b,%xmm3,%xmm3
    8504:	66 0f 68 d0          	punpckhbw %xmm0,%xmm2
    8508:	66 0f 70 d2 4e       	pshufd $0x4e,%xmm2,%xmm2
    850d:	f2 0f 70 d2 1b       	pshuflw $0x1b,%xmm2,%xmm2
    8512:	f3 0f 70 d2 1b       	pshufhw $0x1b,%xmm2,%xmm2
    8517:	66 0f 67 d3          	packuswb %xmm3,%xmm2
    851b:	66 0f 6f d9          	movdqa %xmm1,%xmm3
    851f:	66 0f 60 d8          	punpcklbw %xmm0,%xmm3
    8523:	66 0f 70 db 4e       	pshufd $0x4e,%xmm3,%xmm3
    8528:	f2 0f 70 db 1b       	pshuflw $0x1b,%xmm3,%xmm3
    852d:	f3 0f 70 db 1b       	pshufhw $0x1b,%xmm3,%xmm3
    8532:	66 0f 68 c8          	punpckhbw %xmm0,%xmm1
    8536:	66 0f 70 c9 4e       	pshufd $0x4e,%xmm1,%xmm1
    853b:	f2 0f 70 c9 1b       	pshuflw $0x1b,%xmm1,%xmm1
    8540:	f3 0f 70 c9 1b       	pshufhw $0x1b,%xmm1,%xmm1
    8545:	66 0f 67 cb          	packuswb %xmm3,%xmm1
    8549:	66 0f 7f 56 f0       	movdqa %xmm2,-0x10(%rsi)
    854e:	66 0f 7f 0e          	movdqa %xmm1,(%rsi)
    8552:	49 83 c0 e0          	add    $0xffffffffffffffe0,%r8
    8556:	48 83 c6 20          	add    $0x20,%rsi
    855a:	4c 39 c2             	cmp    %r8,%rdx
    855d:	75 81                	jne    84e0 <fwp_write+0xd40>
    855f:	48 85 d2             	test   %rdx,%rdx
    8562:	0f 84 5b 04 00 00    	je     89c3 <fwp_write+0x1223>
    8568:	83 fa 08             	cmp    $0x8,%edx
    856b:	72 5a                	jb     85c7 <fwp_write+0xe27>
    856d:	89 fa                	mov    %edi,%edx
    856f:	83 e2 07             	and    $0x7,%edx
    8572:	48 89 c6             	mov    %rax,%rsi
    8575:	48 29 ce             	sub    %rcx,%rsi
    8578:	48 8d 3c 0c          	lea    (%rsp,%rcx,1),%rdi
    857c:	48 83 c7 70          	add    $0x70,%rdi
    8580:	48 89 c1             	mov    %rax,%rcx
    8583:	48 29 d1             	sub    %rdx,%rcx
    8586:	66 0f ef c0          	pxor   %xmm0,%xmm0
    858a:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)
    8590:	f3 0f 7e 4c 34 18    	movq   0x18(%rsp,%rsi,1),%xmm1
    8596:	66 0f 60 c8          	punpcklbw %xmm0,%xmm1
    859a:	66 0f 70 c9 4e       	pshufd $0x4e,%xmm1,%xmm1
    859f:	f2 0f 70 c9 1b       	pshuflw $0x1b,%xmm1,%xmm1
    85a4:	f3 0f 70 c9 1b       	pshufhw $0x1b,%xmm1,%xmm1
    85a9:	66 0f 67 c9          	packuswb %xmm1,%xmm1
    85ad:	66 0f d6 0f          	movq   %xmm1,(%rdi)
    85b1:	48 83 c6 f8          	add    $0xfffffffffffffff8,%rsi
    85b5:	48 83 c7 08          	add    $0x8,%rdi
    85b9:	48 39 f2             	cmp    %rsi,%rdx
    85bc:	75 d2                	jne    8590 <fwp_write+0xdf0>
    85be:	48 85 d2             	test   %rdx,%rdx
    85c1:	0f 84 fc 03 00 00    	je     89c3 <fwp_write+0x1223>
    85c7:	48 8d 74 24 20       	lea    0x20(%rsp),%rsi
    85cc:	48 01 f2             	add    %rsi,%rdx
    85cf:	48 ff ca             	dec    %rdx
    85d2:	66 66 66 66 66 2e 0f 	data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    85d9:	1f 84 00 00 00 00 00 
    85e0:	0f b6 32             	movzbl (%rdx),%esi
    85e3:	40 88 74 0c 70       	mov    %sil,0x70(%rsp,%rcx,1)
    85e8:	48 ff c1             	inc    %rcx
    85eb:	48 ff ca             	dec    %rdx
    85ee:	48 39 c8             	cmp    %rcx,%rax
    85f1:	75 ed                	jne    85e0 <fwp_write+0xe40>
    85f3:	e9 cb 03 00 00       	jmp    89c3 <fwp_write+0x1223>
    85f8:	48 8d 7c 24 70       	lea    0x70(%rsp),%rdi
    85fd:	be 2e 00 00 00       	mov    $0x2e,%esi
    8602:	e8 f9 9a ff ff       	call   2100 <strchr@plt>
    8607:	48 85 c0             	test   %rax,%rax
    860a:	48 8b 2c 24          	mov    (%rsp),%rbp
    860e:	0f 85 b4 03 00 00    	jne    89c8 <fwp_write+0x1228>
    8614:	48 8d 7c 24 70       	lea    0x70(%rsp),%rdi
    8619:	be 65 00 00 00       	mov    $0x65,%esi
    861e:	e8 dd 9a ff ff       	call   2100 <strchr@plt>
    8623:	48 85 c0             	test   %rax,%rax
    8626:	0f 85 9c 03 00 00    	jne    89c8 <fwp_write+0x1228>
    862c:	48 8d 35 16 70 00 00 	lea    0x7016(%rip),%rsi        # f649 <fwp_segv.msg+0x409>
    8633:	48 8d 7c 24 70       	lea    0x70(%rsp),%rdi
    8638:	e8 a3 9c ff ff       	call   22e0 <strstr@plt>
    863d:	48 85 c0             	test   %rax,%rax
    8640:	0f 85 82 03 00 00    	jne    89c8 <fwp_write+0x1228>
    8646:	48 8d 35 f7 6f 00 00 	lea    0x6ff7(%rip),%rsi        # f644 <fwp_segv.msg+0x404>
    864d:	48 8d 7c 24 70       	lea    0x70(%rsp),%rdi
    8652:	e8 89 9c ff ff       	call   22e0 <strstr@plt>
    8657:	48 85 c0             	test   %rax,%rax
    865a:	0f 85 68 03 00 00    	jne    89c8 <fwp_write+0x1228>
    8660:	48 8d 7c 24 70       	lea    0x70(%rsp),%rdi
    8665:	e8 76 9a ff ff       	call   20e0 <strlen@plt>
    866a:	66 c7 44 04 70 2e 30 	movw   $0x302e,0x70(%rsp,%rax,1)
    8671:	c6 44 04 72 00       	movb   $0x0,0x72(%rsp,%rax,1)
    8676:	e9 4d 03 00 00       	jmp    89c8 <fwp_write+0x1228>
    867b:	48 8d 04 f0          	lea    (%rax,%rsi,8),%rax
    867f:	48 05 d0 03 00 00    	add    $0x3d0,%rax
    8685:	4c 01 f9             	add    %r15,%rcx
    8688:	48 89 08             	mov    %rcx,(%rax)
    868b:	4c 89 ff             	mov    %r15,%rdi
    868e:	31 f6                	xor    %esi,%esi
    8690:	e8 9b 9a ff ff       	call   2130 <memset@plt>
    8695:	66 41 c7 07 30 74    	movw   $0x7430,(%r15)
    869b:	85 db                	test   %ebx,%ebx
    869d:	0f 8e 98 00 00 00    	jle    873b <fwp_write+0xf9b>
    86a3:	44 89 e1             	mov    %r12d,%ecx
    86a6:	48 f7 d9             	neg    %rcx
    86a9:	4a 8d 34 3b          	lea    (%rbx,%r15,1),%rsi
    86ad:	48 ff c6             	inc    %rsi
    86b0:	31 ff                	xor    %edi,%edi
    86b2:	49 b8 56 55 55 55 55 	movabs $0x5555555555555556,%r8
    86b9:	55 55 55 
    86bc:	eb 2e                	jmp    86ec <fwp_write+0xf4c>
    86be:	66 90                	xchg   %ax,%ax
    86c0:	41 b2 30             	mov    $0x30,%r10b
    86c3:	44 88 14 3e          	mov    %r10b,(%rsi,%rdi,1)
    86c7:	48 85 d2             	test   %rdx,%rdx
    86ca:	0f 95 c2             	setne  %dl
    86cd:	4d 85 f6             	test   %r14,%r14
    86d0:	41 0f 98 c2          	sets   %r10b
    86d4:	41 20 d2             	and    %dl,%r10b
    86d7:	41 0f b6 d2          	movzbl %r10b,%edx
    86db:	48 29 d0             	sub    %rdx,%rax
    86de:	4c 01 c8             	add    %r9,%rax
    86e1:	48 ff cf             	dec    %rdi
    86e4:	49 89 c6             	mov    %rax,%r14
    86e7:	48 39 f9             	cmp    %rdi,%rcx
    86ea:	74 4f                	je     873b <fwp_write+0xf9b>
    86ec:	4c 89 f0             	mov    %r14,%rax
    86ef:	49 f7 e8             	imul   %r8
    86f2:	48 89 d0             	mov    %rdx,%rax
    86f5:	48 c1 e8 3f          	shr    $0x3f,%rax
    86f9:	48 01 d0             	add    %rdx,%rax
    86fc:	4c 8d 0c 40          	lea    (%rax,%rax,2),%r9
    8700:	4c 89 f2             	mov    %r14,%rdx
    8703:	4c 29 ca             	sub    %r9,%rdx
    8706:	49 f7 d9             	neg    %r9
    8709:	4d 01 f1             	add    %r14,%r9
    870c:	49 83 c1 03          	add    $0x3,%r9
    8710:	48 83 fa fd          	cmp    $0xfffffffffffffffd,%rdx
    8714:	4c 0f 42 ca          	cmovb  %rdx,%r9
    8718:	4d 85 c9             	test   %r9,%r9
    871b:	74 a3                	je     86c0 <fwp_write+0xf20>
    871d:	49 83 f9 01          	cmp    $0x1,%r9
    8721:	75 0d                	jne    8730 <fwp_write+0xf90>
    8723:	41 b2 2b             	mov    $0x2b,%r10b
    8726:	45 31 c9             	xor    %r9d,%r9d
    8729:	eb 98                	jmp    86c3 <fwp_write+0xf23>
    872b:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)
    8730:	41 b2 2d             	mov    $0x2d,%r10b
    8733:	41 b9 01 00 00 00    	mov    $0x1,%r9d
    8739:	eb 88                	jmp    86c3 <fwp_write+0xf23>
    873b:	43 c6 44 27 02 00    	movb   $0x0,0x2(%r15,%r12,1)
    8741:	4c 89 ff             	mov    %r15,%rdi
    8744:	e8 97 99 ff ff       	call   20e0 <strlen@plt>
    8749:	48 89 ef             	mov    %rbp,%rdi
    874c:	4c 89 fe             	mov    %r15,%rsi
    874f:	48 89 c2             	mov    %rax,%rdx
    8752:	48 81 c4 78 02 00 00 	add    $0x278,%rsp
    8759:	5b                   	pop    %rbx
    875a:	41 5c                	pop    %r12
    875c:	41 5d                	pop    %r13
    875e:	41 5e                	pop    %r14
    8760:	41 5f                	pop    %r15
    8762:	5d                   	pop    %rbp
    8763:	e9 18 04 00 00       	jmp    8b80 <buf_put>
    8768:	48 8b 31             	mov    (%rcx),%rsi
    876b:	eb 18                	jmp    8785 <fwp_write+0xfe5>
    876d:	83 3a 00             	cmpl   $0x0,(%rdx)
    8770:	0f b6 01             	movzbl (%rcx),%eax
    8773:	48 0f be f0          	movsbq %al,%rsi
    8777:	eb 08                	jmp    8781 <fwp_write+0xfe1>
    8779:	83 3a 02             	cmpl   $0x2,(%rdx)
    877c:	8b 01                	mov    (%rcx),%eax
    877e:	48 63 f0             	movslq %eax,%rsi
    8781:	48 0f 45 f0          	cmovne %rax,%rsi
    8785:	48 8b 2c 24          	mov    (%rsp),%rbp
    8789:	48 89 ef             	mov    %rbp,%rdi
    878c:	31 c9                	xor    %ecx,%ecx
    878e:	e8 0d f0 ff ff       	call   77a0 <fwp_write>
    8793:	48 b8 ff ff ff ff ff 	movabs $0x7fffffffffffffff,%rax
    879a:	ff ff 7f 
    879d:	48 ff c8             	dec    %rax
    87a0:	49 85 06             	test   %rax,(%r14)
    87a3:	0f 84 c9 00 00 00    	je     8872 <fwp_write+0x10d2>
    87a9:	bb 01 00 00 00       	mov    $0x1,%ebx
    87ae:	4c 8d 25 65 6e 00 00 	lea    0x6e65(%rip),%r12        # f61a <fwp_segv.msg+0x3da>
    87b5:	eb 39                	jmp    87f0 <fwp_write+0x1050>
    87b7:	83 3a 01             	cmpl   $0x1,(%rdx)
    87ba:	0f b7 04 31          	movzwl (%rcx,%rsi,1),%eax
    87be:	48 0f bf f0          	movswq %ax,%rsi
    87c2:	48 0f 45 f0          	cmovne %rax,%rsi
    87c6:	48 8b 2c 24          	mov    (%rsp),%rbp
    87ca:	48 89 ef             	mov    %rbp,%rdi
    87cd:	31 c9                	xor    %ecx,%ecx
    87cf:	e8 cc ef ff ff       	call   77a0 <fwp_write>
    87d4:	48 ff c3             	inc    %rbx
    87d7:	49 8b 06             	mov    (%r14),%rax
    87da:	48 b9 ff ff ff ff ff 	movabs $0x7fffffffffffffff,%rcx
    87e1:	ff ff 7f 
    87e4:	48 21 c8             	and    %rcx,%rax
    87e7:	48 39 c3             	cmp    %rax,%rbx
    87ea:	0f 83 82 00 00 00    	jae    8872 <fwp_write+0x10d2>
    87f0:	ba 02 00 00 00       	mov    $0x2,%edx
    87f5:	48 89 ef             	mov    %rbp,%rdi
    87f8:	4c 89 e6             	mov    %r12,%rsi
    87fb:	e8 80 03 00 00       	call   8b80 <buf_put>
    8800:	49 8b 57 38          	mov    0x38(%r15),%rdx
    8804:	b8 08 00 00 00       	mov    $0x8,%eax
    8809:	48 85 d2             	test   %rdx,%rdx
    880c:	74 13                	je     8821 <fwp_write+0x1081>
    880e:	8b 0a                	mov    (%rdx),%ecx
    8810:	48 83 f9 0a          	cmp    $0xa,%rcx
    8814:	77 0b                	ja     8821 <fwp_write+0x1081>
    8816:	48 8d 05 9b 6a 00 00 	lea    0x6a9b(%rip),%rax        # f2b8 <fwp_segv.msg+0x78>
    881d:	48 8b 04 c8          	mov    (%rax,%rcx,8),%rax
    8821:	49 83 3e 00          	cmpq   $0x0,(%r14)
    8825:	4c 89 e9             	mov    %r13,%rcx
    8828:	79 04                	jns    882e <fwp_write+0x108e>
    882a:	49 8b 4e 10          	mov    0x10(%r14),%rcx
    882e:	48 89 c6             	mov    %rax,%rsi
    8831:	48 0f af f3          	imul   %rbx,%rsi
    8835:	48 83 f8 01          	cmp    $0x1,%rax
    8839:	74 19                	je     8854 <fwp_write+0x10b4>
    883b:	48 83 f8 02          	cmp    $0x2,%rax
    883f:	0f 84 72 ff ff ff    	je     87b7 <fwp_write+0x1017>
    8845:	48 83 f8 08          	cmp    $0x8,%rax
    8849:	75 19                	jne    8864 <fwp_write+0x10c4>
    884b:	48 8b 34 31          	mov    (%rcx,%rsi,1),%rsi
    884f:	e9 72 ff ff ff       	jmp    87c6 <fwp_write+0x1026>
    8854:	83 3a 00             	cmpl   $0x0,(%rdx)
    8857:	0f b6 04 31          	movzbl (%rcx,%rsi,1),%eax
    885b:	48 0f be f0          	movsbq %al,%rsi
    885f:	e9 5e ff ff ff       	jmp    87c2 <fwp_write+0x1022>
    8864:	83 3a 02             	cmpl   $0x2,(%rdx)
    8867:	8b 04 31             	mov    (%rcx,%rsi,1),%eax
    886a:	48 63 f0             	movslq %eax,%rsi
    886d:	e9 50 ff ff ff       	jmp    87c2 <fwp_write+0x1022>
    8872:	c6 44 24 70 5d       	movb   $0x5d,0x70(%rsp)
    8877:	48 8d 74 24 70       	lea    0x70(%rsp),%rsi
    887c:	ba 01 00 00 00       	mov    $0x1,%edx
    8881:	48 89 ef             	mov    %rbp,%rdi
    8884:	e9 55 01 00 00       	jmp    89de <fwp_write+0x123e>
    8889:	48 8d 35 ad 6d 00 00 	lea    0x6dad(%rip),%rsi        # f63d <fwp_segv.msg+0x3fd>
    8890:	ba 02 00 00 00       	mov    $0x2,%edx
    8895:	48 89 ef             	mov    %rbp,%rdi
    8898:	e9 b5 fe ff ff       	jmp    8752 <fwp_write+0xfb2>
    889d:	31 c0                	xor    %eax,%eax
    889f:	c6 44 04 71 00       	movb   $0x0,0x71(%rsp,%rax,1)
    88a4:	e9 1f 01 00 00       	jmp    89c8 <fwp_write+0x1228>
    88a9:	89 fa                	mov    %edi,%edx
    88ab:	83 e2 1f             	and    $0x1f,%edx
    88ae:	48 89 c1             	mov    %rax,%rcx
    88b1:	48 29 d1             	sub    %rdx,%rcx
    88b4:	48 8d b4 24 80 00 00 	lea    0x80(%rsp),%rsi
    88bb:	00 
    88bc:	66 0f ef c0          	pxor   %xmm0,%xmm0
    88c0:	49 89 c0             	mov    %rax,%r8
    88c3:	f3 42 0f 6f 0c 04    	movdqu (%rsp,%r8,1),%xmm1
    88c9:	f3 42 0f 6f 54 04 10 	movdqu 0x10(%rsp,%r8,1),%xmm2
    88d0:	66 0f 6f da          	movdqa %xmm2,%xmm3
    88d4:	66 0f 60 d8          	punpcklbw %xmm0,%xmm3
    88d8:	66 0f 70 db 4e       	pshufd $0x4e,%xmm3,%xmm3
    88dd:	f2 0f 70 db 1b       	pshuflw $0x1b,%xmm3,%xmm3
    88e2:	f3 0f 70 db 1b       	pshufhw $0x1b,%xmm3,%xmm3
    88e7:	66 0f 68 d0          	punpckhbw %xmm0,%xmm2
    88eb:	66 0f 70 d2 4e       	pshufd $0x4e,%xmm2,%xmm2
    88f0:	f2 0f 70 d2 1b       	pshuflw $0x1b,%xmm2,%xmm2
    88f5:	f3 0f 70 d2 1b       	pshufhw $0x1b,%xmm2,%xmm2
    88fa:	66 0f 67 d3          	packuswb %xmm3,%xmm2
    88fe:	66 0f 6f d9          	movdqa %xmm1,%xmm3
    8902:	66 0f 60 d8          	punpcklbw %xmm0,%xmm3
    8906:	66 0f 70 db 4e       	pshufd $0x4e,%xmm3,%xmm3
    890b:	f2 0f 70 db 1b       	pshuflw $0x1b,%xmm3,%xmm3
    8910:	f3 0f 70 db 1b       	pshufhw $0x1b,%xmm3,%xmm3
    8915:	66 0f 68 c8          	punpckhbw %xmm0,%xmm1
    8919:	66 0f 70 c9 4e       	pshufd $0x4e,%xmm1,%xmm1
    891e:	f2 0f 70 c9 1b       	pshuflw $0x1b,%xmm1,%xmm1
    8923:	f3 0f 70 c9 1b       	pshufhw $0x1b,%xmm1,%xmm1
    8928:	66 0f 67 cb          	packuswb %xmm3,%xmm1
    892c:	66 0f 7f 56 f0       	movdqa %xmm2,-0x10(%rsi)
    8931:	66 0f 7f 0e          	movdqa %xmm1,(%rsi)
    8935:	49 83 c0 e0          	add    $0xffffffffffffffe0,%r8
    8939:	48 83 c6 20          	add    $0x20,%rsi
    893d:	4c 39 c2             	cmp    %r8,%rdx
    8940:	75 81                	jne    88c3 <fwp_write+0x1123>
    8942:	48 85 d2             	test   %rdx,%rdx
    8945:	0f 84 78 00 00 00    	je     89c3 <fwp_write+0x1223>
    894b:	83 fa 08             	cmp    $0x8,%edx
    894e:	72 50                	jb     89a0 <fwp_write+0x1200>
    8950:	89 fa                	mov    %edi,%edx
    8952:	83 e2 07             	and    $0x7,%edx
    8955:	48 89 c6             	mov    %rax,%rsi
    8958:	48 29 ce             	sub    %rcx,%rsi
    895b:	48 8d 3c 0c          	lea    (%rsp,%rcx,1),%rdi
    895f:	48 83 c7 70          	add    $0x70,%rdi
    8963:	48 89 c1             	mov    %rax,%rcx
    8966:	48 29 d1             	sub    %rdx,%rcx
    8969:	66 0f ef c0          	pxor   %xmm0,%xmm0
    896d:	f3 0f 7e 4c 34 18    	movq   0x18(%rsp,%rsi,1),%xmm1
    8973:	66 0f 60 c8          	punpcklbw %xmm0,%xmm1
    8977:	66 0f 70 c9 4e       	pshufd $0x4e,%xmm1,%xmm1
    897c:	f2 0f 70 c9 1b       	pshuflw $0x1b,%xmm1,%xmm1
    8981:	f3 0f 70 c9 1b       	pshufhw $0x1b,%xmm1,%xmm1
    8986:	66 0f 67 c9          	packuswb %xmm1,%xmm1
    898a:	66 0f d6 0f          	movq   %xmm1,(%rdi)
    898e:	48 83 c6 f8          	add    $0xfffffffffffffff8,%rsi
    8992:	48 83 c7 08          	add    $0x8,%rdi
    8996:	48 39 f2             	cmp    %rsi,%rdx
    8999:	75 d2                	jne    896d <fwp_write+0x11cd>
    899b:	48 85 d2             	test   %rdx,%rdx
    899e:	74 23                	je     89c3 <fwp_write+0x1223>
    89a0:	48 8d 74 24 20       	lea    0x20(%rsp),%rsi
    89a5:	48 01 f2             	add    %rsi,%rdx
    89a8:	48 ff ca             	dec    %rdx
    89ab:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)
    89b0:	0f b6 32             	movzbl (%rdx),%esi
    89b3:	40 88 74 0c 70       	mov    %sil,0x70(%rsp,%rcx,1)
    89b8:	48 ff c1             	inc    %rcx
    89bb:	48 ff ca             	dec    %rdx
    89be:	48 39 c8             	cmp    %rcx,%rax
    89c1:	75 ed                	jne    89b0 <fwp_write+0x1210>
    89c3:	c6 44 04 70 00       	movb   $0x0,0x70(%rsp,%rax,1)
    89c8:	4c 8d 74 24 70       	lea    0x70(%rsp),%r14
    89cd:	4c 89 f7             	mov    %r14,%rdi
    89d0:	e8 0b 97 ff ff       	call   20e0 <strlen@plt>
    89d5:	48 89 ef             	mov    %rbp,%rdi
    89d8:	4c 89 f6             	mov    %r14,%rsi
    89db:	48 89 c2             	mov    %rax,%rdx
    89de:	e8 9d 01 00 00       	call   8b80 <buf_put>
    89e3:	48 81 c4 78 02 00 00 	add    $0x278,%rsp
    89ea:	5b                   	pop    %rbx
    89eb:	41 5c                	pop    %r12
    89ed:	41 5d                	pop    %r13
    89ef:	41 5e                	pop    %r14
    89f1:	41 5f                	pop    %r15
    89f3:	5d                   	pop    %rbp
    89f4:	c3                   	ret
    89f5:	83 f8 20             	cmp    $0x20,%eax
    89f8:	73 07                	jae    8a01 <fwp_write+0x1261>
    89fa:	31 c9                	xor    %ecx,%ecx
    89fc:	e9 b6 00 00 00       	jmp    8ab7 <fwp_write+0x1317>
    8a01:	89 fe                	mov    %edi,%esi
    8a03:	89 fa                	mov    %edi,%edx
    8a05:	83 e2 1f             	and    $0x1f,%edx
    8a08:	48 89 c1             	mov    %rax,%rcx
    8a0b:	48 29 d1             	sub    %rdx,%rcx
    8a0e:	4c 8d 04 34          	lea    (%rsp,%rsi,1),%r8
    8a12:	49 83 c0 10          	add    $0x10,%r8
    8a16:	48 29 d6             	sub    %rdx,%rsi
    8a19:	45 31 c9             	xor    %r9d,%r9d
    8a1c:	66 0f ef c0          	pxor   %xmm0,%xmm0
    8a20:	f3 41 0f 6f 48 f0    	movdqu -0x10(%r8),%xmm1
    8a26:	f3 41 0f 6f 10       	movdqu (%r8),%xmm2
    8a2b:	66 0f 6f da          	movdqa %xmm2,%xmm3
    8a2f:	66 0f 60 d8          	punpcklbw %xmm0,%xmm3
    8a33:	66 0f 70 db 4e       	pshufd $0x4e,%xmm3,%xmm3
    8a38:	f2 0f 70 db 1b       	pshuflw $0x1b,%xmm3,%xmm3
    8a3d:	f3 0f 70 db 1b       	pshufhw $0x1b,%xmm3,%xmm3
    8a42:	66 0f 68 d0          	punpckhbw %xmm0,%xmm2
    8a46:	66 0f 70 d2 4e       	pshufd $0x4e,%xmm2,%xmm2
    8a4b:	f2 0f 70 d2 1b       	pshuflw $0x1b,%xmm2,%xmm2
    8a50:	f3 0f 70 d2 1b       	pshufhw $0x1b,%xmm2,%xmm2
    8a55:	66 0f 67 d3          	packuswb %xmm3,%xmm2
    8a59:	66 0f 6f d9          	movdqa %xmm1,%xmm3
    8a5d:	66 0f 60 d8          	punpcklbw %xmm0,%xmm3
    8a61:	66 0f 70 db 4e       	pshufd $0x4e,%xmm3,%xmm3
    8a66:	f2 0f 70 db 1b       	pshuflw $0x1b,%xmm3,%xmm3
    8a6b:	f3 0f 70 db 1b       	pshufhw $0x1b,%xmm3,%xmm3
    8a70:	66 0f 68 c8          	punpckhbw %xmm0,%xmm1
    8a74:	66 0f 70 c9 4e       	pshufd $0x4e,%xmm1,%xmm1
    8a79:	f2 0f 70 c9 1b       	pshuflw $0x1b,%xmm1,%xmm1
    8a7e:	f3 0f 70 c9 1b       	pshufhw $0x1b,%xmm1,%xmm1
    8a83:	66 0f 67 cb          	packuswb %xmm3,%xmm1
    8a87:	f3 42 0f 7f 54 0c 71 	movdqu %xmm2,0x71(%rsp,%r9,1)
    8a8e:	f3 42 0f 7f 8c 0c 81 	movdqu %xmm1,0x81(%rsp,%r9,1)
    8a95:	00 00 00 
    8a98:	49 83 c1 20          	add    $0x20,%r9
    8a9c:	49 83 c0 e0          	add    $0xffffffffffffffe0,%r8
    8aa0:	4c 39 ce             	cmp    %r9,%rsi
    8aa3:	0f 85 77 ff ff ff    	jne    8a20 <fwp_write+0x1280>
    8aa9:	48 85 d2             	test   %rdx,%rdx
    8aac:	0f 84 91 00 00 00    	je     8b43 <fwp_write+0x13a3>
    8ab2:	83 fa 08             	cmp    $0x8,%edx
    8ab5:	72 60                	jb     8b17 <fwp_write+0x1377>
    8ab7:	48 89 ce             	mov    %rcx,%rsi
    8aba:	41 89 f8             	mov    %edi,%r8d
    8abd:	89 fa                	mov    %edi,%edx
    8abf:	83 e2 07             	and    $0x7,%edx
    8ac2:	48 89 c1             	mov    %rax,%rcx
    8ac5:	48 29 d1             	sub    %rdx,%rcx
    8ac8:	49 89 f1             	mov    %rsi,%r9
    8acb:	49 f7 d9             	neg    %r9
    8ace:	49 01 e1             	add    %rsp,%r9
    8ad1:	49 83 c1 20          	add    $0x20,%r9
    8ad5:	4d 01 c1             	add    %r8,%r9
    8ad8:	49 83 c1 f8          	add    $0xfffffffffffffff8,%r9
    8adc:	49 29 d0             	sub    %rdx,%r8
    8adf:	66 0f ef c0          	pxor   %xmm0,%xmm0
    8ae3:	f3 41 0f 7e 09       	movq   (%r9),%xmm1
    8ae8:	66 0f 60 c8          	punpcklbw %xmm0,%xmm1
    8aec:	66 0f 70 c9 4e       	pshufd $0x4e,%xmm1,%xmm1
    8af1:	f2 0f 70 c9 1b       	pshuflw $0x1b,%xmm1,%xmm1
    8af6:	f3 0f 70 c9 1b       	pshufhw $0x1b,%xmm1,%xmm1
    8afb:	66 0f 67 c9          	packuswb %xmm1,%xmm1
    8aff:	66 0f d6 4c 34 71    	movq   %xmm1,0x71(%rsp,%rsi,1)
    8b05:	48 83 c6 08          	add    $0x8,%rsi
    8b09:	49 83 c1 f8          	add    $0xfffffffffffffff8,%r9
    8b0d:	49 39 f0             	cmp    %rsi,%r8
    8b10:	75 d1                	jne    8ae3 <fwp_write+0x1343>
    8b12:	48 85 d2             	test   %rdx,%rdx
    8b15:	74 2c                	je     8b43 <fwp_write+0x13a3>
    8b17:	48 8d 74 24 20       	lea    0x20(%rsp),%rsi
    8b1c:	48 01 f2             	add    %rsi,%rdx
    8b1f:	48 ff ca             	dec    %rdx
    8b22:	89 fe                	mov    %edi,%esi
    8b24:	66 66 66 2e 0f 1f 84 	data16 data16 cs nopw 0x0(%rax,%rax,1)
    8b2b:	00 00 00 00 00 
    8b30:	0f b6 3a             	movzbl (%rdx),%edi
    8b33:	40 88 7c 0c 71       	mov    %dil,0x71(%rsp,%rcx,1)
    8b38:	48 ff c1             	inc    %rcx
    8b3b:	48 ff ca             	dec    %rdx
    8b3e:	48 39 ce             	cmp    %rcx,%rsi
    8b41:	75 ed                	jne    8b30 <fwp_write+0x1390>
    8b43:	c6 44 04 71 00       	movb   $0x0,0x71(%rsp,%rax,1)
    8b48:	e9 7b fe ff ff       	jmp    89c8 <fwp_write+0x1228>
    8b4d:	4c 8d 74 24 70       	lea    0x70(%rsp),%r14
    8b52:	4c 89 f7             	mov    %r14,%rdi
    8b55:	f2 0f 10 44 24 10    	movsd  0x10(%rsp),%xmm0
    8b5b:	be 09 00 00 00       	mov    $0x9,%esi
    8b60:	e8 7b 0d 00 00       	call   98e0 <fwp_format_g>
    8b65:	4c 89 f7             	mov    %r14,%rdi
    8b68:	e9 bf f8 ff ff       	jmp    842c <fwp_write+0xc8c>
    8b6d:	c7 44 24 70 4e 61 4e 	movl   $0x4e614e,0x70(%rsp)
    8b74:	00 
    8b75:	e9 4e fe ff ff       	jmp    89c8 <fwp_write+0x1228>
    8b7a:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)

0000000000008b80 <buf_put>:
    8b80:	41 57                	push   %r15
    8b82:	41 56                	push   %r14
    8b84:	41 54                	push   %r12
    8b86:	53                   	push   %rbx
    8b87:	50                   	push   %rax
    8b88:	49 89 fe             	mov    %rdi,%r14
    8b8b:	48 8b 7f 08          	mov    0x8(%rdi),%rdi
    8b8f:	48 83 ff ff          	cmp    $0xffffffffffffffff,%rdi
    8b93:	0f 84 a2 00 00 00    	je     8c3b <buf_put+0xbb>
    8b99:	48 89 d3             	mov    %rdx,%rbx
    8b9c:	48 c7 c0 fe ff ff ff 	mov    $0xfffffffffffffffe,%rax
    8ba3:	48 29 f8             	sub    %rdi,%rax
    8ba6:	48 39 d0             	cmp    %rdx,%rax
    8ba9:	0f 82 8c 00 00 00    	jb     8c3b <buf_put+0xbb>
    8baf:	48 8d 04 3b          	lea    (%rbx,%rdi,1),%rax
    8bb3:	48 ff c0             	inc    %rax
    8bb6:	49 8b 4e 10          	mov    0x10(%r14),%rcx
    8bba:	48 39 c8             	cmp    %rcx,%rax
    8bbd:	76 30                	jbe    8bef <buf_put+0x6f>
    8bbf:	48 85 c9             	test   %rcx,%rcx
    8bc2:	41 bf 40 00 00 00    	mov    $0x40,%r15d
    8bc8:	4c 0f 45 f9          	cmovne %rcx,%r15
    8bcc:	49 89 f4             	mov    %rsi,%r12
    8bcf:	49 39 c7             	cmp    %rax,%r15
    8bd2:	73 23                	jae    8bf7 <buf_put+0x77>
    8bd4:	66 66 66 2e 0f 1f 84 	data16 data16 cs nopw 0x0(%rax,%rax,1)
    8bdb:	00 00 00 00 00 
    8be0:	4d 85 ff             	test   %r15,%r15
    8be3:	78 0f                	js     8bf4 <buf_put+0x74>
    8be5:	4d 01 ff             	add    %r15,%r15
    8be8:	49 39 c7             	cmp    %rax,%r15
    8beb:	72 f3                	jb     8be0 <buf_put+0x60>
    8bed:	eb 08                	jmp    8bf7 <buf_put+0x77>
    8bef:	49 8b 06             	mov    (%r14),%rax
    8bf2:	eb 21                	jmp    8c15 <buf_put+0x95>
    8bf4:	49 89 c7             	mov    %rax,%r15
    8bf7:	49 8b 3e             	mov    (%r14),%rdi
    8bfa:	4c 89 fe             	mov    %r15,%rsi
    8bfd:	e8 0e 96 ff ff       	call   2210 <realloc@plt>
    8c02:	48 85 c0             	test   %rax,%rax
    8c05:	74 34                	je     8c3b <buf_put+0xbb>
    8c07:	49 89 06             	mov    %rax,(%r14)
    8c0a:	4d 89 7e 10          	mov    %r15,0x10(%r14)
    8c0e:	49 8b 7e 08          	mov    0x8(%r14),%rdi
    8c12:	4c 89 e6             	mov    %r12,%rsi
    8c15:	48 01 c7             	add    %rax,%rdi
    8c18:	48 89 da             	mov    %rbx,%rdx
    8c1b:	e8 c0 95 ff ff       	call   21e0 <memcpy@plt>
    8c20:	49 03 5e 08          	add    0x8(%r14),%rbx
    8c24:	49 89 5e 08          	mov    %rbx,0x8(%r14)
    8c28:	49 8b 06             	mov    (%r14),%rax
    8c2b:	c6 04 18 00          	movb   $0x0,(%rax,%rbx,1)
    8c2f:	48 83 c4 08          	add    $0x8,%rsp
    8c33:	5b                   	pop    %rbx
    8c34:	41 5c                	pop    %r12
    8c36:	41 5e                	pop    %r14
    8c38:	41 5f                	pop    %r15
    8c3a:	c3                   	ret
    8c3b:	48 8b 05 9e 93 00 00 	mov    0x939e(%rip),%rax        # 11fe0 <stderr@GLIBC_2.2.5>
    8c42:	48 8b 08             	mov    (%rax),%rcx
    8c45:	48 8d 3d ed 68 00 00 	lea    0x68ed(%rip),%rdi        # f539 <fwp_segv.msg+0x2f9>
    8c4c:	be 13 00 00 00       	mov    $0x13,%esi
    8c51:	ba 01 00 00 00       	mov    $0x1,%edx
    8c56:	e8 45 96 ff ff       	call   22a0 <fwrite@plt>
    8c5b:	bf 66 00 00 00       	mov    $0x66,%edi
    8c60:	e8 2b 96 ff ff       	call   2290 <exit@plt>
    8c65:	66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
    8c6c:	00 00 00 00 

0000000000008c70 <fwp_escape>:
    8c70:	55                   	push   %rbp
    8c71:	41 57                	push   %r15
    8c73:	41 56                	push   %r14
    8c75:	41 55                	push   %r13
    8c77:	41 54                	push   %r12
    8c79:	53                   	push   %rbx
    8c7a:	48 83 ec 18          	sub    $0x18,%rsp
    8c7e:	49 89 d6             	mov    %rdx,%r14
    8c81:	49 89 f7             	mov    %rsi,%r15
    8c84:	48 89 fb             	mov    %rdi,%rbx
    8c87:	c6 04 24 22          	movb   $0x22,(%rsp)
    8c8b:	48 89 e6             	mov    %rsp,%rsi
    8c8e:	ba 01 00 00 00       	mov    $0x1,%edx
    8c93:	e8 e8 fe ff ff       	call   8b80 <buf_put>
    8c98:	4d 85 f6             	test   %r14,%r14
    8c9b:	0f 84 de 00 00 00    	je     8d7f <fwp_escape+0x10f>
    8ca1:	48 89 e5             	mov    %rsp,%rbp
    8ca4:	4c 8d 2d 21 65 00 00 	lea    0x6521(%rip),%r13        # f1cc <_IO_stdin_used+0x1cc>
    8cab:	45 31 e4             	xor    %r12d,%r12d
    8cae:	eb 21                	jmp    8cd1 <fwp_escape+0x61>
    8cb0:	ba 02 00 00 00       	mov    $0x2,%edx
    8cb5:	48 89 df             	mov    %rbx,%rdi
    8cb8:	48 8d 35 b1 69 00 00 	lea    0x69b1(%rip),%rsi        # f670 <fwp_segv.msg+0x430>
    8cbf:	90                   	nop
    8cc0:	e8 bb fe ff ff       	call   8b80 <buf_put>
    8cc5:	49 ff c4             	inc    %r12
    8cc8:	4d 39 e6             	cmp    %r12,%r14
    8ccb:	0f 84 ae 00 00 00    	je     8d7f <fwp_escape+0x10f>
    8cd1:	43 0f b6 04 27       	movzbl (%r15,%r12,1),%eax
    8cd6:	0f b6 c8             	movzbl %al,%ecx
    8cd9:	8d 51 f7             	lea    -0x9(%rcx),%edx
    8cdc:	83 fa 19             	cmp    $0x19,%edx
    8cdf:	77 1f                	ja     8d00 <fwp_escape+0x90>
    8ce1:	49 63 54 95 00       	movslq 0x0(%r13,%rdx,4),%rdx
    8ce6:	4c 01 ea             	add    %r13,%rdx
    8ce9:	ff e2                	jmp    *%rdx
    8ceb:	ba 02 00 00 00       	mov    $0x2,%edx
    8cf0:	48 89 df             	mov    %rbx,%rdi
    8cf3:	48 8d 35 73 69 00 00 	lea    0x6973(%rip),%rsi        # f66d <fwp_segv.msg+0x42d>
    8cfa:	eb c4                	jmp    8cc0 <fwp_escape+0x50>
    8cfc:	0f 1f 40 00          	nopl   0x0(%rax)
    8d00:	83 f9 5c             	cmp    $0x5c,%ecx
    8d03:	75 11                	jne    8d16 <fwp_escape+0xa6>
    8d05:	ba 02 00 00 00       	mov    $0x2,%edx
    8d0a:	48 89 df             	mov    %rbx,%rdi
    8d0d:	48 8d 35 53 69 00 00 	lea    0x6953(%rip),%rsi        # f667 <fwp_segv.msg+0x427>
    8d14:	eb aa                	jmp    8cc0 <fwp_escape+0x50>
    8d16:	3c 20                	cmp    $0x20,%al
    8d18:	72 39                	jb     8d53 <fwp_escape+0xe3>
    8d1a:	3c 7f                	cmp    $0x7f,%al
    8d1c:	74 35                	je     8d53 <fwp_escape+0xe3>
    8d1e:	88 04 24             	mov    %al,(%rsp)
    8d21:	ba 01 00 00 00       	mov    $0x1,%edx
    8d26:	48 89 df             	mov    %rbx,%rdi
    8d29:	48 89 ee             	mov    %rbp,%rsi
    8d2c:	eb 92                	jmp    8cc0 <fwp_escape+0x50>
    8d2e:	ba 02 00 00 00       	mov    $0x2,%edx
    8d33:	48 89 df             	mov    %rbx,%rdi
    8d36:	48 8d 35 27 69 00 00 	lea    0x6927(%rip),%rsi        # f664 <fwp_segv.msg+0x424>
    8d3d:	eb 81                	jmp    8cc0 <fwp_escape+0x50>
    8d3f:	ba 02 00 00 00       	mov    $0x2,%edx
    8d44:	48 89 df             	mov    %rbx,%rdi
    8d47:	48 8d 35 1c 69 00 00 	lea    0x691c(%rip),%rsi        # f66a <fwp_segv.msg+0x42a>
    8d4e:	e9 6d ff ff ff       	jmp    8cc0 <fwp_escape+0x50>
    8d53:	be 10 00 00 00       	mov    $0x10,%esi
    8d58:	48 89 ef             	mov    %rbp,%rdi
    8d5b:	48 8d 15 11 69 00 00 	lea    0x6911(%rip),%rdx        # f673 <fwp_segv.msg+0x433>
    8d62:	31 c0                	xor    %eax,%eax
    8d64:	e8 a7 93 ff ff       	call   2110 <snprintf@plt>
    8d69:	48 89 ef             	mov    %rbp,%rdi
    8d6c:	e8 6f 93 ff ff       	call   20e0 <strlen@plt>
    8d71:	48 89 df             	mov    %rbx,%rdi
    8d74:	48 89 ee             	mov    %rbp,%rsi
    8d77:	48 89 c2             	mov    %rax,%rdx
    8d7a:	e9 41 ff ff ff       	jmp    8cc0 <fwp_escape+0x50>
    8d7f:	c6 04 24 22          	movb   $0x22,(%rsp)
    8d83:	48 89 e6             	mov    %rsp,%rsi
    8d86:	ba 01 00 00 00       	mov    $0x1,%edx
    8d8b:	48 89 df             	mov    %rbx,%rdi
    8d8e:	e8 ed fd ff ff       	call   8b80 <buf_put>
    8d93:	48 83 c4 18          	add    $0x18,%rsp
    8d97:	5b                   	pop    %rbx
    8d98:	41 5c                	pop    %r12
    8d9a:	41 5d                	pop    %r13
    8d9c:	41 5e                	pop    %r14
    8d9e:	41 5f                	pop    %r15
    8da0:	5d                   	pop    %rbp
    8da1:	c3                   	ret
    8da2:	66 66 66 66 66 2e 0f 	data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    8da9:	1f 84 00 00 00 00 00 

0000000000008db0 <fwp_fmt_duration>:
    8db0:	41 57                	push   %r15
    8db2:	41 56                	push   %r14
    8db4:	41 54                	push   %r12
    8db6:	53                   	push   %rbx
    8db7:	48 81 ec 88 00 00 00 	sub    $0x88,%rsp
    8dbe:	48 89 f0             	mov    %rsi,%rax
    8dc1:	48 09 d0             	or     %rdx,%rax
    8dc4:	0f 84 bf 02 00 00    	je     9089 <fwp_fmt_duration+0x2d9>
    8dca:	49 89 d0             	mov    %rdx,%r8
    8dcd:	48 b9 1d 3f c2 25 d6 	movabs $0xd2fe1d625c23f1d,%rcx
    8dd4:	e1 2f 0d 
    8dd7:	48 0f af ce          	imul   %rsi,%rcx
    8ddb:	49 b9 0d b1 f3 e4 99 	movabs $0x1c52799e4f3b10d,%r9
    8de2:	27 c5 01 
    8de5:	48 89 f0             	mov    %rsi,%rax
    8de8:	49 f7 e1             	mul    %r9
    8deb:	48 01 ca             	add    %rcx,%rdx
    8dee:	4d 0f af c8          	imul   %r8,%r9
    8df2:	49 01 d1             	add    %rdx,%r9
    8df5:	48 b9 00 a0 34 52 a3 	movabs $0x6baf6aa35234a000,%rcx
    8dfc:	6a af 6b 
    8dff:	48 01 c1             	add    %rax,%rcx
    8e02:	48 b8 37 f9 ff e2 04 	movabs $0x4e2fff937,%rax
    8e09:	00 00 00 
    8e0c:	4c 11 c8             	adc    %r9,%rax
    8e0f:	48 89 c2             	mov    %rax,%rdx
    8e12:	48 0f ac ca 0d       	shrd   $0xd,%rcx,%rdx
    8e17:	48 0f a4 c8 33       	shld   $0x33,%rcx,%rax
    8e1c:	48 b9 4a 23 35 aa f6 	movabs $0x9376baf6aa35234a,%rcx
    8e23:	ba 76 93 
    8e26:	48 39 c1             	cmp    %rax,%rcx
    8e29:	b8 ff 2f 4e 00       	mov    $0x4e2fff,%eax
    8e2e:	48 19 d0             	sbb    %rdx,%rax
    8e31:	0f 83 70 02 00 00    	jae    90a7 <fwp_fmt_duration+0x2f7>
    8e37:	48 b9 b3 b2 61 36 8c 	movabs $0xc5ce3b8c3661b2b3,%rcx
    8e3e:	3b ce c5 
    8e41:	49 b9 c3 5f 47 6a 04 	movabs $0x1a8d52046a475fc3,%r9
    8e48:	52 8d 1a 
    8e4b:	48 89 f0             	mov    %rsi,%rax
    8e4e:	49 f7 e1             	mul    %r9
    8e51:	48 0f af ce          	imul   %rsi,%rcx
    8e55:	48 01 ca             	add    %rcx,%rdx
    8e58:	4d 0f af c8          	imul   %r8,%r9
    8e5c:	49 01 d1             	add    %rdx,%r9
    8e5f:	48 b9 00 a8 16 d1 91 	movabs $0x4f473f91d116a800,%rcx
    8e66:	3f 47 4f 
    8e69:	48 01 c1             	add    %rax,%rcx
    8e6c:	48 b8 3f 9a ff 4c 49 	movabs $0x494cff9a3f,%rax
    8e73:	00 00 00 
    8e76:	4c 11 c8             	adc    %r9,%rax
    8e79:	48 89 c2             	mov    %rax,%rdx
    8e7c:	48 0f ac ca 0b       	shrd   $0xb,%rcx,%rdx
    8e81:	48 0f a4 c8 35       	shld   $0x35,%rcx,%rax
    8e86:	48 b9 ab 45 74 e4 cf 	movabs $0x8fd3d1cfe47445ab,%rcx
    8e8d:	d1 d3 8f 
    8e90:	48 39 c8             	cmp    %rcx,%rax
    8e93:	48 81 da e6 3f 53 12 	sbb    $0x12533fe6,%rdx
    8e9a:	0f 82 27 02 00 00    	jb     90c7 <fwp_fmt_duration+0x317>
    8ea0:	48 b9 7e 78 b9 2f 37 	movabs $0x97157d372fb9787e,%rcx
    8ea7:	7d 15 97 
    8eaa:	48 0f af ce          	imul   %rsi,%rcx
    8eae:	49 b9 6d 9c 2e 3a 42 	movabs $0x8e47ce423a2e9c6d,%r9
    8eb5:	ce 47 8e 
    8eb8:	48 89 f0             	mov    %rsi,%rax
    8ebb:	49 f7 e1             	mul    %r9
    8ebe:	48 01 ca             	add    %rcx,%rdx
    8ec1:	4d 0f af c8          	imul   %r8,%r9
    8ec5:	49 01 d1             	add    %rdx,%r9
    8ec8:	48 b9 00 46 54 40 8b 	movabs $0xa52cb98b40544600,%rcx
    8ecf:	b9 2c a5 
    8ed2:	48 01 c1             	add    %rax,%rcx
    8ed5:	48 b8 b5 09 fa 82 4b 	movabs $0x44b82fa09b5,%rax
    8edc:	04 00 00 
    8edf:	4c 11 c8             	adc    %r9,%rax
    8ee2:	48 89 c2             	mov    %rax,%rdx
    8ee5:	48 0f ac ca 09       	shrd   $0x9,%rcx,%rdx
    8eea:	48 0f a4 c8 37       	shld   $0x37,%rcx,%rax
    8eef:	48 b9 47 54 40 8b b9 	movabs $0xb5a52cb98b405447,%rcx
    8ef6:	2c a5 b5 
    8ef9:	48 39 c8             	cmp    %rcx,%rax
    8efc:	48 b8 09 fa 82 4b 04 	movabs $0x44b82fa09,%rax
    8f03:	00 00 00 
    8f06:	48 19 c2             	sbb    %rax,%rdx
    8f09:	0f 82 0d 03 00 00    	jb     921c <fwp_fmt_duration+0x46c>
    8f0f:	48 b9 cb d5 8f 4d f2 	movabs $0xc57e23f24d8fd5cb,%rcx
    8f16:	23 7e c5 
    8f19:	48 0f af ce          	imul   %rsi,%rcx
    8f1d:	49 b9 39 61 c2 68 56 	movabs $0x790fb65668c26139,%r9
    8f24:	b6 0f 79 
    8f27:	48 89 f0             	mov    %rsi,%rax
    8f2a:	49 f7 e1             	mul    %r9
    8f2d:	48 01 ca             	add    %rcx,%rdx
    8f30:	4d 0f af c8          	imul   %r8,%r9
    8f34:	49 01 d1             	add    %rdx,%r9
    8f37:	48 b9 00 0b 27 69 fe 	movabs $0xa6d698fe69270b00,%rcx
    8f3e:	98 d6 a6 
    8f41:	48 01 c1             	add    %rax,%rcx
    8f44:	48 b8 b1 bd 16 f4 de 	movabs $0x218def416bdb1,%rax
    8f4b:	18 02 00 
    8f4e:	4c 11 c8             	adc    %r9,%rax
    8f51:	48 89 c2             	mov    %rax,%rdx
    8f54:	48 0f ac ca 06       	shrd   $0x6,%rcx,%rdx
    8f59:	48 0f a4 c8 3a       	shld   $0x3a,%rcx,%rax
    8f5e:	48 b9 59 38 49 f3 c7 	movabs $0x8d36b4c7f3493859,%rcx
    8f65:	b4 36 8d 
    8f68:	48 39 c8             	cmp    %rcx,%rax
    8f6b:	48 b8 ed b5 a0 f7 c6 	movabs $0x10c6f7a0b5ed,%rax
    8f72:	10 00 00 
    8f75:	48 19 c2             	sbb    %rax,%rdx
    8f78:	0f 82 ad 02 00 00    	jb     922b <fwp_fmt_duration+0x47b>
    8f7e:	48 b9 5a 64 3b df 4f 	movabs $0x6e978d4fdf3b645a,%rcx
    8f85:	8d 97 6e 
    8f88:	48 0f af ce          	imul   %rsi,%rcx
    8f8c:	49 b9 d5 78 e9 26 31 	movabs $0x1cac083126e978d5,%r9
    8f93:	08 ac 1c 
    8f96:	48 89 f0             	mov    %rsi,%rax
    8f99:	49 f7 e1             	mul    %r9
    8f9c:	48 01 ca             	add    %rcx,%rdx
    8f9f:	4d 0f af c8          	imul   %r8,%r9
    8fa3:	49 01 d1             	add    %rdx,%r9
    8fa6:	48 b9 48 62 10 58 39 	movabs $0x76c8b43958106248,%rcx
    8fad:	b4 c8 76 
    8fb0:	48 01 c1             	add    %rax,%rcx
    8fb3:	48 b8 be 9f 1a 2f dd 	movabs $0x10624dd2f1a9fbe,%rax
    8fba:	24 06 01 
    8fbd:	4c 11 c8             	adc    %r9,%rax
    8fc0:	48 89 c2             	mov    %rax,%rdx
    8fc3:	48 0f ac ca 03       	shrd   $0x3,%rcx,%rdx
    8fc8:	48 0f a4 c8 3d       	shld   $0x3d,%rcx,%rax
    8fcd:	48 b9 93 18 04 56 0e 	movabs $0x9db22d0e56041893,%rcx
    8fd4:	2d b2 9d 
    8fd7:	48 39 c8             	cmp    %rcx,%rax
    8fda:	48 b8 ef a7 c6 4b 37 	movabs $0x4189374bc6a7ef,%rax
    8fe1:	89 41 00 
    8fe4:	48 19 c2             	sbb    %rax,%rdx
    8fe7:	0f 82 4d 02 00 00    	jb     923a <fwp_fmt_duration+0x48a>
    8fed:	4d 85 c0             	test   %r8,%r8
    8ff0:	0f 88 d6 06 00 00    	js     96cc <fwp_fmt_duration+0x91c>
    8ff6:	45 31 d2             	xor    %r10d,%r10d
    8ff9:	49 bb cd cc cc cc cc 	movabs $0xcccccccccccccccd,%r11
    9000:	cc cc cc 
    9003:	48 bb cc cc cc cc cc 	movabs $0xcccccccccccccccc,%rbx
    900a:	cc cc cc 
    900d:	4d 89 c6             	mov    %r8,%r14
    9010:	4c 89 c1             	mov    %r8,%rcx
    9013:	48 0f a4 f1 3f       	shld   $0x3f,%rsi,%rcx
    9018:	49 d1 ee             	shr    $1,%r14
    901b:	49 89 c9             	mov    %rcx,%r9
    901e:	4d 01 f1             	add    %r14,%r9
    9021:	49 83 d1 00          	adc    $0x0,%r9
    9025:	4c 89 c8             	mov    %r9,%rax
    9028:	49 f7 e3             	mul    %r11
    902b:	48 c1 ea 02          	shr    $0x2,%rdx
    902f:	48 8d 04 92          	lea    (%rdx,%rdx,4),%rax
    9033:	49 29 c1             	sub    %rax,%r9
    9036:	4c 29 c9             	sub    %r9,%rcx
    9039:	49 83 de 00          	sbb    $0x0,%r14
    903d:	49 89 c9             	mov    %rcx,%r9
    9040:	4c 0f af cb          	imul   %rbx,%r9
    9044:	48 89 c8             	mov    %rcx,%rax
    9047:	49 f7 e3             	mul    %r11
    904a:	4c 01 ca             	add    %r9,%rdx
    904d:	4d 0f af f3          	imul   %r11,%r14
    9051:	49 01 d6             	add    %rdx,%r14
    9054:	48 89 c1             	mov    %rax,%rcx
    9057:	48 01 c1             	add    %rax,%rcx
    905a:	48 8d 0c 89          	lea    (%rcx,%rcx,4),%rcx
    905e:	89 f2                	mov    %esi,%edx
    9060:	29 ca                	sub    %ecx,%edx
    9062:	80 ca 30             	or     $0x30,%dl
    9065:	42 88 54 14 40       	mov    %dl,0x40(%rsp,%r10,1)
    906a:	49 ff c2             	inc    %r10
    906d:	48 83 fe 0a          	cmp    $0xa,%rsi
    9071:	49 83 d8 00          	sbb    $0x0,%r8
    9075:	48 89 c6             	mov    %rax,%rsi
    9078:	4d 89 f0             	mov    %r14,%r8
    907b:	73 93                	jae    9010 <fwp_fmt_duration+0x260>
    907d:	45 85 d2             	test   %r10d,%r10d
    9080:	7f 12                	jg     9094 <fwp_fmt_duration+0x2e4>
    9082:	31 c0                	xor    %eax,%eax
    9084:	e9 79 01 00 00       	jmp    9202 <fwp_fmt_duration+0x452>
    9089:	c6 44 24 40 30       	movb   $0x30,0x40(%rsp)
    908e:	41 ba 01 00 00 00    	mov    $0x1,%r10d
    9094:	44 89 d0             	mov    %r10d,%eax
    9097:	48 83 f8 08          	cmp    $0x8,%rax
    909b:	73 1e                	jae    90bb <fwp_fmt_duration+0x30b>
    909d:	31 c9                	xor    %ecx,%ecx
    909f:	48 89 c2             	mov    %rax,%rdx
    90a2:	e9 3d 01 00 00       	jmp    91e4 <fwp_fmt_duration+0x434>
    90a7:	49 89 fe             	mov    %rdi,%r14
    90aa:	48 ba 00 a0 b8 30 46 	movabs $0x34630b8a000,%rdx
    90b1:	03 00 00 
    90b4:	31 c0                	xor    %eax,%eax
    90b6:	e9 8c 01 00 00       	jmp    9247 <fwp_fmt_duration+0x497>
    90bb:	83 f8 20             	cmp    $0x20,%eax
    90be:	73 1e                	jae    90de <fwp_fmt_duration+0x32e>
    90c0:	31 c9                	xor    %ecx,%ecx
    90c2:	e9 c3 00 00 00       	jmp    918a <fwp_fmt_duration+0x3da>
    90c7:	49 89 fe             	mov    %rdi,%r14
    90ca:	48 ba 00 58 47 f8 0d 	movabs $0xdf8475800,%rdx
    90d1:	00 00 00 
    90d4:	b8 01 00 00 00       	mov    $0x1,%eax
    90d9:	e9 69 01 00 00       	jmp    9247 <fwp_fmt_duration+0x497>
    90de:	44 89 d2             	mov    %r10d,%edx
    90e1:	83 e2 1f             	and    $0x1f,%edx
    90e4:	48 89 c1             	mov    %rax,%rcx
    90e7:	48 29 d1             	sub    %rdx,%rcx
    90ea:	48 8d 74 24 10       	lea    0x10(%rsp),%rsi
    90ef:	66 0f ef c0          	pxor   %xmm0,%xmm0
    90f3:	49 89 c0             	mov    %rax,%r8
    90f6:	66 2e 0f 1f 84 00 00 	cs nopw 0x0(%rax,%rax,1)
    90fd:	00 00 00 
    9100:	f3 42 0f 6f 4c 04 20 	movdqu 0x20(%rsp,%r8,1),%xmm1
    9107:	f3 42 0f 6f 54 04 30 	movdqu 0x30(%rsp,%r8,1),%xmm2
    910e:	66 0f 6f da          	movdqa %xmm2,%xmm3
    9112:	66 0f 60 d8          	punpcklbw %xmm0,%xmm3
    9116:	66 0f 70 db 4e       	pshufd $0x4e,%xmm3,%xmm3
    911b:	f2 0f 70 db 1b       	pshuflw $0x1b,%xmm3,%xmm3
    9120:	f3 0f 70 db 1b       	pshufhw $0x1b,%xmm3,%xmm3
    9125:	66 0f 68 d0          	punpckhbw %xmm0,%xmm2
    9129:	66 0f 70 d2 4e       	pshufd $0x4e,%xmm2,%xmm2
    912e:	f2 0f 70 d2 1b       	pshuflw $0x1b,%xmm2,%xmm2
    9133:	f3 0f 70 d2 1b       	pshufhw $0x1b,%xmm2,%xmm2
    9138:	66 0f 67 d3          	packuswb %xmm3,%xmm2
    913c:	66 0f 6f d9          	movdqa %xmm1,%xmm3
    9140:	66 0f 60 d8          	punpcklbw %xmm0,%xmm3
    9144:	66 0f 70 db 4e       	pshufd $0x4e,%xmm3,%xmm3
    9149:	f2 0f 70 db 1b       	pshuflw $0x1b,%xmm3,%xmm3
    914e:	f3 0f 70 db 1b       	pshufhw $0x1b,%xmm3,%xmm3
    9153:	66 0f 68 c8          	punpckhbw %xmm0,%xmm1
    9157:	66 0f 70 c9 4e       	pshufd $0x4e,%xmm1,%xmm1
    915c:	f2 0f 70 c9 1b       	pshuflw $0x1b,%xmm1,%xmm1
    9161:	f3 0f 70 c9 1b       	pshufhw $0x1b,%xmm1,%xmm1
    9166:	66 0f 67 cb          	packuswb %xmm3,%xmm1
    916a:	66 0f 7f 56 f0       	movdqa %xmm2,-0x10(%rsi)
    916f:	66 0f 7f 0e          	movdqa %xmm1,(%rsi)
    9173:	49 83 c0 e0          	add    $0xffffffffffffffe0,%r8
    9177:	48 83 c6 20          	add    $0x20,%rsi
    917b:	4c 39 c2             	cmp    %r8,%rdx
    917e:	75 80                	jne    9100 <fwp_fmt_duration+0x350>
    9180:	48 85 d2             	test   %rdx,%rdx
    9183:	74 7d                	je     9202 <fwp_fmt_duration+0x452>
    9185:	83 fa 08             	cmp    $0x8,%edx
    9188:	72 5a                	jb     91e4 <fwp_fmt_duration+0x434>
    918a:	44 89 d2             	mov    %r10d,%edx
    918d:	83 e2 07             	and    $0x7,%edx
    9190:	48 89 c6             	mov    %rax,%rsi
    9193:	48 29 ce             	sub    %rcx,%rsi
    9196:	4c 8d 04 0c          	lea    (%rsp,%rcx,1),%r8
    919a:	48 89 c1             	mov    %rax,%rcx
    919d:	48 29 d1             	sub    %rdx,%rcx
    91a0:	66 0f ef c0          	pxor   %xmm0,%xmm0
    91a4:	66 66 66 2e 0f 1f 84 	data16 data16 cs nopw 0x0(%rax,%rax,1)
    91ab:	00 00 00 00 00 
    91b0:	f3 0f 7e 4c 34 38    	movq   0x38(%rsp,%rsi,1),%xmm1
    91b6:	66 0f 60 c8          	punpcklbw %xmm0,%xmm1
    91ba:	66 0f 70 c9 4e       	pshufd $0x4e,%xmm1,%xmm1
    91bf:	f2 0f 70 c9 1b       	pshuflw $0x1b,%xmm1,%xmm1
    91c4:	f3 0f 70 c9 1b       	pshufhw $0x1b,%xmm1,%xmm1
    91c9:	66 0f 67 c9          	packuswb %xmm1,%xmm1
    91cd:	66 41 0f d6 08       	movq   %xmm1,(%r8)
    91d2:	48 83 c6 f8          	add    $0xfffffffffffffff8,%rsi
    91d6:	49 83 c0 08          	add    $0x8,%r8
    91da:	48 39 f2             	cmp    %rsi,%rdx
    91dd:	75 d1                	jne    91b0 <fwp_fmt_duration+0x400>
    91df:	48 85 d2             	test   %rdx,%rdx
    91e2:	74 1e                	je     9202 <fwp_fmt_duration+0x452>
    91e4:	48 8d 74 24 40       	lea    0x40(%rsp),%rsi
    91e9:	48 01 f2             	add    %rsi,%rdx
    91ec:	48 ff ca             	dec    %rdx
    91ef:	90                   	nop
    91f0:	0f b6 32             	movzbl (%rdx),%esi
    91f3:	40 88 34 0c          	mov    %sil,(%rsp,%rcx,1)
    91f7:	48 ff c1             	inc    %rcx
    91fa:	48 ff ca             	dec    %rdx
    91fd:	48 39 c8             	cmp    %rcx,%rax
    9200:	75 ee                	jne    91f0 <fwp_fmt_duration+0x440>
    9202:	c6 04 04 00          	movb   $0x0,(%rsp,%rax,1)
    9206:	48 8d 35 79 64 00 00 	lea    0x6479(%rip),%rsi        # f686 <fwp_segv.msg+0x446>
    920d:	48 89 e2             	mov    %rsp,%rdx
    9210:	31 c0                	xor    %eax,%eax
    9212:	e8 69 90 ff ff       	call   2280 <sprintf@plt>
    9217:	e9 a1 04 00 00       	jmp    96bd <fwp_fmt_duration+0x90d>
    921c:	49 89 fe             	mov    %rdi,%r14
    921f:	ba 00 ca 9a 3b       	mov    $0x3b9aca00,%edx
    9224:	b8 02 00 00 00       	mov    $0x2,%eax
    9229:	eb 1c                	jmp    9247 <fwp_fmt_duration+0x497>
    922b:	49 89 fe             	mov    %rdi,%r14
    922e:	ba 40 42 0f 00       	mov    $0xf4240,%edx
    9233:	b8 03 00 00 00       	mov    $0x3,%eax
    9238:	eb 0d                	jmp    9247 <fwp_fmt_duration+0x497>
    923a:	49 89 fe             	mov    %rdi,%r14
    923d:	ba e8 03 00 00       	mov    $0x3e8,%edx
    9242:	b8 04 00 00 00       	mov    $0x4,%eax
    9247:	31 c9                	xor    %ecx,%ecx
    9249:	c1 e0 04             	shl    $0x4,%eax
    924c:	48 8d 1d 1d 8b 00 00 	lea    0x8b1d(%rip),%rbx        # 11d70 <fwp_fmt_duration.units>
    9253:	48 01 c3             	add    %rax,%rbx
    9256:	48 89 f7             	mov    %rsi,%rdi
    9259:	4c 89 c6             	mov    %r8,%rsi
    925c:	e8 5f 4c 00 00       	call   dec0 <__divti3>
    9261:	48 89 c1             	mov    %rax,%rcx
    9264:	48 89 d6             	mov    %rdx,%rsi
    9267:	48 85 d2             	test   %rdx,%rdx
    926a:	0f 88 b0 00 00 00    	js     9320 <fwp_fmt_duration+0x570>
    9270:	48 89 c8             	mov    %rcx,%rax
    9273:	48 09 f0             	or     %rsi,%rax
    9276:	0f 84 61 01 00 00    	je     93dd <fwp_fmt_duration+0x62d>
    927c:	45 31 d2             	xor    %r10d,%r10d
    927f:	49 bb cd cc cc cc cc 	movabs $0xcccccccccccccccd,%r11
    9286:	cc cc cc 
    9289:	49 bf cc cc cc cc cc 	movabs $0xcccccccccccccccc,%r15
    9290:	cc cc cc 
    9293:	49 89 f4             	mov    %rsi,%r12
    9296:	4c 89 f7             	mov    %r14,%rdi
    9299:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)
    92a0:	49 89 f0             	mov    %rsi,%r8
    92a3:	49 0f a4 c8 3f       	shld   $0x3f,%rcx,%r8
    92a8:	49 d1 ec             	shr    $1,%r12
    92ab:	4d 89 c1             	mov    %r8,%r9
    92ae:	4d 01 e1             	add    %r12,%r9
    92b1:	49 83 d1 00          	adc    $0x0,%r9
    92b5:	4c 89 c8             	mov    %r9,%rax
    92b8:	49 f7 e3             	mul    %r11
    92bb:	48 c1 ea 02          	shr    $0x2,%rdx
    92bf:	48 8d 04 92          	lea    (%rdx,%rdx,4),%rax
    92c3:	49 29 c1             	sub    %rax,%r9
    92c6:	4d 29 c8             	sub    %r9,%r8
    92c9:	49 83 dc 00          	sbb    $0x0,%r12
    92cd:	4d 89 c1             	mov    %r8,%r9
    92d0:	4d 0f af cf          	imul   %r15,%r9
    92d4:	4c 89 c0             	mov    %r8,%rax
    92d7:	49 f7 e3             	mul    %r11
    92da:	4c 01 ca             	add    %r9,%rdx
    92dd:	4d 0f af e3          	imul   %r11,%r12
    92e1:	49 01 d4             	add    %rdx,%r12
    92e4:	48 89 c2             	mov    %rax,%rdx
    92e7:	48 01 c2             	add    %rax,%rdx
    92ea:	48 8d 14 92          	lea    (%rdx,%rdx,4),%rdx
    92ee:	41 89 c8             	mov    %ecx,%r8d
    92f1:	41 29 d0             	sub    %edx,%r8d
    92f4:	41 80 c8 30          	or     $0x30,%r8b
    92f8:	46 88 44 14 40       	mov    %r8b,0x40(%rsp,%r10,1)
    92fd:	49 ff c2             	inc    %r10
    9300:	48 83 f9 0a          	cmp    $0xa,%rcx
    9304:	48 83 de 00          	sbb    $0x0,%rsi
    9308:	48 89 c1             	mov    %rax,%rcx
    930b:	4c 89 e6             	mov    %r12,%rsi
    930e:	73 90                	jae    92a0 <fwp_fmt_duration+0x4f0>
    9310:	45 85 d2             	test   %r10d,%r10d
    9313:	0f 8f d2 00 00 00    	jg     93eb <fwp_fmt_duration+0x63b>
    9319:	31 c0                	xor    %eax,%eax
    931b:	e9 12 02 00 00       	jmp    9532 <fwp_fmt_duration+0x782>
    9320:	45 31 c0             	xor    %r8d,%r8d
    9323:	48 f7 d9             	neg    %rcx
    9326:	41 b9 00 00 00 00    	mov    $0x0,%r9d
    932c:	49 19 f1             	sbb    %rsi,%r9
    932f:	c6 04 24 2d          	movb   $0x2d,(%rsp)
    9333:	49 ba cd cc cc cc cc 	movabs $0xcccccccccccccccd,%r10
    933a:	cc cc cc 
    933d:	49 bb cc cc cc cc cc 	movabs $0xcccccccccccccccc,%r11
    9344:	cc cc cc 
    9347:	4d 89 cf             	mov    %r9,%r15
    934a:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)
    9350:	4c 89 ce             	mov    %r9,%rsi
    9353:	48 0f a4 ce 3f       	shld   $0x3f,%rcx,%rsi
    9358:	49 d1 ef             	shr    $1,%r15
    935b:	48 89 f7             	mov    %rsi,%rdi
    935e:	4c 01 ff             	add    %r15,%rdi
    9361:	48 83 d7 00          	adc    $0x0,%rdi
    9365:	48 89 f8             	mov    %rdi,%rax
    9368:	49 f7 e2             	mul    %r10
    936b:	48 c1 ea 02          	shr    $0x2,%rdx
    936f:	48 8d 04 92          	lea    (%rdx,%rdx,4),%rax
    9373:	48 29 c7             	sub    %rax,%rdi
    9376:	48 29 fe             	sub    %rdi,%rsi
    9379:	49 83 df 00          	sbb    $0x0,%r15
    937d:	48 89 f7             	mov    %rsi,%rdi
    9380:	49 0f af fb          	imul   %r11,%rdi
    9384:	48 89 f0             	mov    %rsi,%rax
    9387:	49 f7 e2             	mul    %r10
    938a:	48 01 fa             	add    %rdi,%rdx
    938d:	4d 0f af fa          	imul   %r10,%r15
    9391:	49 01 d7             	add    %rdx,%r15
    9394:	48 89 c2             	mov    %rax,%rdx
    9397:	48 01 c2             	add    %rax,%rdx
    939a:	48 8d 14 92          	lea    (%rdx,%rdx,4),%rdx
    939e:	89 ce                	mov    %ecx,%esi
    93a0:	29 d6                	sub    %edx,%esi
    93a2:	40 80 ce 30          	or     $0x30,%sil
    93a6:	42 88 74 04 40       	mov    %sil,0x40(%rsp,%r8,1)
    93ab:	49 ff c0             	inc    %r8
    93ae:	48 83 f9 0a          	cmp    $0xa,%rcx
    93b2:	49 83 d9 00          	sbb    $0x0,%r9
    93b6:	48 89 c1             	mov    %rax,%rcx
    93b9:	4d 89 f9             	mov    %r15,%r9
    93bc:	73 92                	jae    9350 <fwp_fmt_duration+0x5a0>
    93be:	45 85 c0             	test   %r8d,%r8d
    93c1:	4c 89 f7             	mov    %r14,%rdi
    93c4:	7e 44                	jle    940a <fwp_fmt_duration+0x65a>
    93c6:	44 89 c0             	mov    %r8d,%eax
    93c9:	48 83 f8 08          	cmp    $0x8,%rax
    93cd:	0f 83 68 01 00 00    	jae    953b <fwp_fmt_duration+0x78b>
    93d3:	31 c9                	xor    %ecx,%ecx
    93d5:	48 89 c2             	mov    %rax,%rdx
    93d8:	e9 97 02 00 00       	jmp    9674 <fwp_fmt_duration+0x8c4>
    93dd:	c6 44 24 40 30       	movb   $0x30,0x40(%rsp)
    93e2:	41 ba 01 00 00 00    	mov    $0x1,%r10d
    93e8:	4c 89 f7             	mov    %r14,%rdi
    93eb:	44 89 d0             	mov    %r10d,%eax
    93ee:	48 83 f8 08          	cmp    $0x8,%rax
    93f2:	73 0a                	jae    93fe <fwp_fmt_duration+0x64e>
    93f4:	31 c9                	xor    %ecx,%ecx
    93f6:	48 89 c2             	mov    %rax,%rdx
    93f9:	e9 16 01 00 00       	jmp    9514 <fwp_fmt_duration+0x764>
    93fe:	83 f8 20             	cmp    $0x20,%eax
    9401:	73 0e                	jae    9411 <fwp_fmt_duration+0x661>
    9403:	31 c9                	xor    %ecx,%ecx
    9405:	e9 b0 00 00 00       	jmp    94ba <fwp_fmt_duration+0x70a>
    940a:	31 c0                	xor    %eax,%eax
    940c:	e9 93 02 00 00       	jmp    96a4 <fwp_fmt_duration+0x8f4>
    9411:	44 89 d2             	mov    %r10d,%edx
    9414:	83 e2 1f             	and    $0x1f,%edx
    9417:	48 89 c1             	mov    %rax,%rcx
    941a:	48 29 d1             	sub    %rdx,%rcx
    941d:	48 8d 74 24 10       	lea    0x10(%rsp),%rsi
    9422:	66 0f ef c0          	pxor   %xmm0,%xmm0
    9426:	49 89 c0             	mov    %rax,%r8
    9429:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)
    9430:	f3 42 0f 6f 4c 04 20 	movdqu 0x20(%rsp,%r8,1),%xmm1
    9437:	f3 42 0f 6f 54 04 30 	movdqu 0x30(%rsp,%r8,1),%xmm2
    943e:	66 0f 6f da          	movdqa %xmm2,%xmm3
    9442:	66 0f 60 d8          	punpcklbw %xmm0,%xmm3
    9446:	66 0f 70 db 4e       	pshufd $0x4e,%xmm3,%xmm3
    944b:	f2 0f 70 db 1b       	pshuflw $0x1b,%xmm3,%xmm3
    9450:	f3 0f 70 db 1b       	pshufhw $0x1b,%xmm3,%xmm3
    9455:	66 0f 68 d0          	punpckhbw %xmm0,%xmm2
    9459:	66 0f 70 d2 4e       	pshufd $0x4e,%xmm2,%xmm2
    945e:	f2 0f 70 d2 1b       	pshuflw $0x1b,%xmm2,%xmm2
    9463:	f3 0f 70 d2 1b       	pshufhw $0x1b,%xmm2,%xmm2
    9468:	66 0f 67 d3          	packuswb %xmm3,%xmm2
    946c:	66 0f 6f d9          	movdqa %xmm1,%xmm3
    9470:	66 0f 60 d8          	punpcklbw %xmm0,%xmm3
    9474:	66 0f 70 db 4e       	pshufd $0x4e,%xmm3,%xmm3
    9479:	f2 0f 70 db 1b       	pshuflw $0x1b,%xmm3,%xmm3
    947e:	f3 0f 70 db 1b       	pshufhw $0x1b,%xmm3,%xmm3
    9483:	66 0f 68 c8          	punpckhbw %xmm0,%xmm1
    9487:	66 0f 70 c9 4e       	pshufd $0x4e,%xmm1,%xmm1
    948c:	f2 0f 70 c9 1b       	pshuflw $0x1b,%xmm1,%xmm1
    9491:	f3 0f 70 c9 1b       	pshufhw $0x1b,%xmm1,%xmm1
    9496:	66 0f 67 cb          	packuswb %xmm3,%xmm1
    949a:	66 0f 7f 56 f0       	movdqa %xmm2,-0x10(%rsi)
    949f:	66 0f 7f 0e          	movdqa %xmm1,(%rsi)
    94a3:	49 83 c0 e0          	add    $0xffffffffffffffe0,%r8
    94a7:	48 83 c6 20          	add    $0x20,%rsi
    94ab:	4c 39 c2             	cmp    %r8,%rdx
    94ae:	75 80                	jne    9430 <fwp_fmt_duration+0x680>
    94b0:	48 85 d2             	test   %rdx,%rdx
    94b3:	74 7d                	je     9532 <fwp_fmt_duration+0x782>
    94b5:	83 fa 08             	cmp    $0x8,%edx
    94b8:	72 5a                	jb     9514 <fwp_fmt_duration+0x764>
    94ba:	44 89 d2             	mov    %r10d,%edx
    94bd:	83 e2 07             	and    $0x7,%edx
    94c0:	48 89 c6             	mov    %rax,%rsi
    94c3:	48 29 ce             	sub    %rcx,%rsi
    94c6:	4c 8d 04 0c          	lea    (%rsp,%rcx,1),%r8
    94ca:	48 89 c1             	mov    %rax,%rcx
    94cd:	48 29 d1             	sub    %rdx,%rcx
    94d0:	66 0f ef c0          	pxor   %xmm0,%xmm0
    94d4:	66 66 66 2e 0f 1f 84 	data16 data16 cs nopw 0x0(%rax,%rax,1)
    94db:	00 00 00 00 00 
    94e0:	f3 0f 7e 4c 34 38    	movq   0x38(%rsp,%rsi,1),%xmm1
    94e6:	66 0f 60 c8          	punpcklbw %xmm0,%xmm1
    94ea:	66 0f 70 c9 4e       	pshufd $0x4e,%xmm1,%xmm1
    94ef:	f2 0f 70 c9 1b       	pshuflw $0x1b,%xmm1,%xmm1
    94f4:	f3 0f 70 c9 1b       	pshufhw $0x1b,%xmm1,%xmm1
    94f9:	66 0f 67 c9          	packuswb %xmm1,%xmm1
    94fd:	66 41 0f d6 08       	movq   %xmm1,(%r8)
    9502:	48 83 c6 f8          	add    $0xfffffffffffffff8,%rsi
    9506:	49 83 c0 08          	add    $0x8,%r8
    950a:	48 39 f2             	cmp    %rsi,%rdx
    950d:	75 d1                	jne    94e0 <fwp_fmt_duration+0x730>
    950f:	48 85 d2             	test   %rdx,%rdx
    9512:	74 1e                	je     9532 <fwp_fmt_duration+0x782>
    9514:	48 8d 74 24 40       	lea    0x40(%rsp),%rsi
    9519:	48 01 f2             	add    %rsi,%rdx
    951c:	48 ff ca             	dec    %rdx
    951f:	90                   	nop
    9520:	0f b6 32             	movzbl (%rdx),%esi
    9523:	40 88 34 0c          	mov    %sil,(%rsp,%rcx,1)
    9527:	48 ff c1             	inc    %rcx
    952a:	48 ff ca             	dec    %rdx
    952d:	48 39 c8             	cmp    %rcx,%rax
    9530:	75 ee                	jne    9520 <fwp_fmt_duration+0x770>
    9532:	c6 04 04 00          	movb   $0x0,(%rsp,%rax,1)
    9536:	e9 6e 01 00 00       	jmp    96a9 <fwp_fmt_duration+0x8f9>
    953b:	83 f8 20             	cmp    $0x20,%eax
    953e:	73 07                	jae    9547 <fwp_fmt_duration+0x797>
    9540:	31 c9                	xor    %ecx,%ecx
    9542:	e9 bd 00 00 00       	jmp    9604 <fwp_fmt_duration+0x854>
    9547:	44 89 c6             	mov    %r8d,%esi
    954a:	44 89 c2             	mov    %r8d,%edx
    954d:	83 e2 1f             	and    $0x1f,%edx
    9550:	48 89 c1             	mov    %rax,%rcx
    9553:	48 29 d1             	sub    %rdx,%rcx
    9556:	4c 8d 0c 34          	lea    (%rsp,%rsi,1),%r9
    955a:	49 83 c1 30          	add    $0x30,%r9
    955e:	48 29 d6             	sub    %rdx,%rsi
    9561:	45 31 d2             	xor    %r10d,%r10d
    9564:	66 0f ef c0          	pxor   %xmm0,%xmm0
    9568:	0f 1f 84 00 00 00 00 	nopl   0x0(%rax,%rax,1)
    956f:	00 
    9570:	f3 41 0f 6f 49 f0    	movdqu -0x10(%r9),%xmm1
    9576:	f3 41 0f 6f 11       	movdqu (%r9),%xmm2
    957b:	66 0f 6f da          	movdqa %xmm2,%xmm3
    957f:	66 0f 60 d8          	punpcklbw %xmm0,%xmm3
    9583:	66 0f 70 db 4e       	pshufd $0x4e,%xmm3,%xmm3
    9588:	f2 0f 70 db 1b       	pshuflw $0x1b,%xmm3,%xmm3
    958d:	f3 0f 70 db 1b       	pshufhw $0x1b,%xmm3,%xmm3
    9592:	66 0f 68 d0          	punpckhbw %xmm0,%xmm2
    9596:	66 0f 70 d2 4e       	pshufd $0x4e,%xmm2,%xmm2
    959b:	f2 0f 70 d2 1b       	pshuflw $0x1b,%xmm2,%xmm2
    95a0:	f3 0f 70 d2 1b       	pshufhw $0x1b,%xmm2,%xmm2
    95a5:	66 0f 67 d3          	packuswb %xmm3,%xmm2
    95a9:	66 0f 6f d9          	movdqa %xmm1,%xmm3
    95ad:	66 0f 60 d8          	punpcklbw %xmm0,%xmm3
    95b1:	66 0f 70 db 4e       	pshufd $0x4e,%xmm3,%xmm3
    95b6:	f2 0f 70 db 1b       	pshuflw $0x1b,%xmm3,%xmm3
    95bb:	f3 0f 70 db 1b       	pshufhw $0x1b,%xmm3,%xmm3
    95c0:	66 0f 68 c8          	punpckhbw %xmm0,%xmm1
    95c4:	66 0f 70 c9 4e       	pshufd $0x4e,%xmm1,%xmm1
    95c9:	f2 0f 70 c9 1b       	pshuflw $0x1b,%xmm1,%xmm1
    95ce:	f3 0f 70 c9 1b       	pshufhw $0x1b,%xmm1,%xmm1
    95d3:	66 0f 67 cb          	packuswb %xmm3,%xmm1
    95d7:	f3 42 0f 7f 54 14 01 	movdqu %xmm2,0x1(%rsp,%r10,1)
    95de:	f3 42 0f 7f 4c 14 11 	movdqu %xmm1,0x11(%rsp,%r10,1)
    95e5:	49 83 c2 20          	add    $0x20,%r10
    95e9:	49 83 c1 e0          	add    $0xffffffffffffffe0,%r9
    95ed:	4c 39 d6             	cmp    %r10,%rsi
    95f0:	0f 85 7a ff ff ff    	jne    9570 <fwp_fmt_duration+0x7c0>
    95f6:	48 85 d2             	test   %rdx,%rdx
    95f9:	0f 84 a5 00 00 00    	je     96a4 <fwp_fmt_duration+0x8f4>
    95ff:	83 fa 08             	cmp    $0x8,%edx
    9602:	72 70                	jb     9674 <fwp_fmt_duration+0x8c4>
    9604:	48 89 ce             	mov    %rcx,%rsi
    9607:	45 89 c1             	mov    %r8d,%r9d
    960a:	44 89 c2             	mov    %r8d,%edx
    960d:	83 e2 07             	and    $0x7,%edx
    9610:	48 89 c1             	mov    %rax,%rcx
    9613:	48 29 d1             	sub    %rdx,%rcx
    9616:	49 89 f2             	mov    %rsi,%r10
    9619:	49 f7 da             	neg    %r10
    961c:	49 01 e2             	add    %rsp,%r10
    961f:	49 83 c2 40          	add    $0x40,%r10
    9623:	4d 01 ca             	add    %r9,%r10
    9626:	49 83 c2 f8          	add    $0xfffffffffffffff8,%r10
    962a:	49 29 d1             	sub    %rdx,%r9
    962d:	66 0f ef c0          	pxor   %xmm0,%xmm0
    9631:	66 66 66 66 66 66 2e 	data16 data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    9638:	0f 1f 84 00 00 00 00 
    963f:	00 
    9640:	f3 41 0f 7e 0a       	movq   (%r10),%xmm1
    9645:	66 0f 60 c8          	punpcklbw %xmm0,%xmm1
    9649:	66 0f 70 c9 4e       	pshufd $0x4e,%xmm1,%xmm1
    964e:	f2 0f 70 c9 1b       	pshuflw $0x1b,%xmm1,%xmm1
    9653:	f3 0f 70 c9 1b       	pshufhw $0x1b,%xmm1,%xmm1
    9658:	66 0f 67 c9          	packuswb %xmm1,%xmm1
    965c:	66 0f d6 4c 34 01    	movq   %xmm1,0x1(%rsp,%rsi,1)
    9662:	48 83 c6 08          	add    $0x8,%rsi
    9666:	49 83 c2 f8          	add    $0xfffffffffffffff8,%r10
    966a:	49 39 f1             	cmp    %rsi,%r9
    966d:	75 d1                	jne    9640 <fwp_fmt_duration+0x890>
    966f:	48 85 d2             	test   %rdx,%rdx
    9672:	74 30                	je     96a4 <fwp_fmt_duration+0x8f4>
    9674:	48 8d 74 24 40       	lea    0x40(%rsp),%rsi
    9679:	48 01 f2             	add    %rsi,%rdx
    967c:	48 ff ca             	dec    %rdx
    967f:	44 89 c6             	mov    %r8d,%esi
    9682:	66 66 66 66 66 2e 0f 	data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    9689:	1f 84 00 00 00 00 00 
    9690:	44 0f b6 02          	movzbl (%rdx),%r8d
    9694:	44 88 44 0c 01       	mov    %r8b,0x1(%rsp,%rcx,1)
    9699:	48 ff c1             	inc    %rcx
    969c:	48 ff ca             	dec    %rdx
    969f:	48 39 ce             	cmp    %rcx,%rsi
    96a2:	75 ec                	jne    9690 <fwp_fmt_duration+0x8e0>
    96a4:	c6 44 04 01 00       	movb   $0x0,0x1(%rsp,%rax,1)
    96a9:	48 8b 0b             	mov    (%rbx),%rcx
    96ac:	48 8d 35 ce 5f 00 00 	lea    0x5fce(%rip),%rsi        # f681 <fwp_segv.msg+0x441>
    96b3:	48 89 e2             	mov    %rsp,%rdx
    96b6:	31 c0                	xor    %eax,%eax
    96b8:	e8 c3 8b ff ff       	call   2280 <sprintf@plt>
    96bd:	48 81 c4 88 00 00 00 	add    $0x88,%rsp
    96c4:	5b                   	pop    %rbx
    96c5:	41 5c                	pop    %r12
    96c7:	41 5e                	pop    %r14
    96c9:	41 5f                	pop    %r15
    96cb:	c3                   	ret
    96cc:	45 31 c9             	xor    %r9d,%r9d
    96cf:	48 f7 de             	neg    %rsi
    96d2:	41 ba 00 00 00 00    	mov    $0x0,%r10d
    96d8:	4d 19 c2             	sbb    %r8,%r10
    96db:	c6 04 24 2d          	movb   $0x2d,(%rsp)
    96df:	49 bb cd cc cc cc cc 	movabs $0xcccccccccccccccd,%r11
    96e6:	cc cc cc 
    96e9:	48 bb cc cc cc cc cc 	movabs $0xcccccccccccccccc,%rbx
    96f0:	cc cc cc 
    96f3:	4d 89 d6             	mov    %r10,%r14
    96f6:	66 2e 0f 1f 84 00 00 	cs nopw 0x0(%rax,%rax,1)
    96fd:	00 00 00 
    9700:	4c 89 d1             	mov    %r10,%rcx
    9703:	48 0f a4 f1 3f       	shld   $0x3f,%rsi,%rcx
    9708:	49 d1 ee             	shr    $1,%r14
    970b:	49 89 c8             	mov    %rcx,%r8
    970e:	4d 01 f0             	add    %r14,%r8
    9711:	49 83 d0 00          	adc    $0x0,%r8
    9715:	4c 89 c0             	mov    %r8,%rax
    9718:	49 f7 e3             	mul    %r11
    971b:	48 c1 ea 02          	shr    $0x2,%rdx
    971f:	48 8d 04 92          	lea    (%rdx,%rdx,4),%rax
    9723:	49 29 c0             	sub    %rax,%r8
    9726:	4c 29 c1             	sub    %r8,%rcx
    9729:	49 83 de 00          	sbb    $0x0,%r14
    972d:	49 89 c8             	mov    %rcx,%r8
    9730:	4c 0f af c3          	imul   %rbx,%r8
    9734:	48 89 c8             	mov    %rcx,%rax
    9737:	49 f7 e3             	mul    %r11
    973a:	4c 01 c2             	add    %r8,%rdx
    973d:	4d 0f af f3          	imul   %r11,%r14
    9741:	49 01 d6             	add    %rdx,%r14
    9744:	48 89 c1             	mov    %rax,%rcx
    9747:	48 01 c1             	add    %rax,%rcx
    974a:	48 8d 0c 89          	lea    (%rcx,%rcx,4),%rcx
    974e:	89 f2                	mov    %esi,%edx
    9750:	29 ca                	sub    %ecx,%edx
    9752:	80 ca 30             	or     $0x30,%dl
    9755:	42 88 54 0c 40       	mov    %dl,0x40(%rsp,%r9,1)
    975a:	49 ff c1             	inc    %r9
    975d:	48 83 fe 0a          	cmp    $0xa,%rsi
    9761:	49 83 da 00          	sbb    $0x0,%r10
    9765:	48 89 c6             	mov    %rax,%rsi
    9768:	4d 89 f2             	mov    %r14,%r10
    976b:	73 93                	jae    9700 <fwp_fmt_duration+0x950>
    976d:	45 85 c9             	test   %r9d,%r9d
    9770:	7e 13                	jle    9785 <fwp_fmt_duration+0x9d5>
    9772:	44 89 c8             	mov    %r9d,%eax
    9775:	48 83 f8 08          	cmp    $0x8,%rax
    9779:	73 11                	jae    978c <fwp_fmt_duration+0x9dc>
    977b:	31 c9                	xor    %ecx,%ecx
    977d:	48 89 c2             	mov    %rax,%rdx
    9780:	e9 29 01 00 00       	jmp    98ae <fwp_fmt_duration+0xafe>
    9785:	31 c0                	xor    %eax,%eax
    9787:	e9 48 01 00 00       	jmp    98d4 <fwp_fmt_duration+0xb24>
    978c:	83 f8 20             	cmp    $0x20,%eax
    978f:	73 07                	jae    9798 <fwp_fmt_duration+0x9e8>
    9791:	31 c9                	xor    %ecx,%ecx
    9793:	e9 b5 00 00 00       	jmp    984d <fwp_fmt_duration+0xa9d>
    9798:	44 89 ce             	mov    %r9d,%esi
    979b:	44 89 ca             	mov    %r9d,%edx
    979e:	83 e2 1f             	and    $0x1f,%edx
    97a1:	48 89 c1             	mov    %rax,%rcx
    97a4:	48 29 d1             	sub    %rdx,%rcx
    97a7:	4c 8d 04 34          	lea    (%rsp,%rsi,1),%r8
    97ab:	49 83 c0 30          	add    $0x30,%r8
    97af:	48 29 d6             	sub    %rdx,%rsi
    97b2:	45 31 d2             	xor    %r10d,%r10d
    97b5:	66 0f ef c0          	pxor   %xmm0,%xmm0
    97b9:	f3 41 0f 6f 48 f0    	movdqu -0x10(%r8),%xmm1
    97bf:	f3 41 0f 6f 10       	movdqu (%r8),%xmm2
    97c4:	66 0f 6f da          	movdqa %xmm2,%xmm3
    97c8:	66 0f 60 d8          	punpcklbw %xmm0,%xmm3
    97cc:	66 0f 70 db 4e       	pshufd $0x4e,%xmm3,%xmm3
    97d1:	f2 0f 70 db 1b       	pshuflw $0x1b,%xmm3,%xmm3
    97d6:	f3 0f 70 db 1b       	pshufhw $0x1b,%xmm3,%xmm3
    97db:	66 0f 68 d0          	punpckhbw %xmm0,%xmm2
    97df:	66 0f 70 d2 4e       	pshufd $0x4e,%xmm2,%xmm2
    97e4:	f2 0f 70 d2 1b       	pshuflw $0x1b,%xmm2,%xmm2
    97e9:	f3 0f 70 d2 1b       	pshufhw $0x1b,%xmm2,%xmm2
    97ee:	66 0f 67 d3          	packuswb %xmm3,%xmm2
    97f2:	66 0f 6f d9          	movdqa %xmm1,%xmm3
    97f6:	66 0f 60 d8          	punpcklbw %xmm0,%xmm3
    97fa:	66 0f 70 db 4e       	pshufd $0x4e,%xmm3,%xmm3
    97ff:	f2 0f 70 db 1b       	pshuflw $0x1b,%xmm3,%xmm3
    9804:	f3 0f 70 db 1b       	pshufhw $0x1b,%xmm3,%xmm3
    9809:	66 0f 68 c8          	punpckhbw %xmm0,%xmm1
    980d:	66 0f 70 c9 4e       	pshufd $0x4e,%xmm1,%xmm1
    9812:	f2 0f 70 c9 1b       	pshuflw $0x1b,%xmm1,%xmm1
    9817:	f3 0f 70 c9 1b       	pshufhw $0x1b,%xmm1,%xmm1
    981c:	66 0f 67 cb          	packuswb %xmm3,%xmm1
    9820:	f3 42 0f 7f 54 14 01 	movdqu %xmm2,0x1(%rsp,%r10,1)
    9827:	f3 42 0f 7f 4c 14 11 	movdqu %xmm1,0x11(%rsp,%r10,1)
    982e:	49 83 c2 20          	add    $0x20,%r10
    9832:	49 83 c0 e0          	add    $0xffffffffffffffe0,%r8
    9836:	4c 39 d6             	cmp    %r10,%rsi
    9839:	0f 85 7a ff ff ff    	jne    97b9 <fwp_fmt_duration+0xa09>
    983f:	48 85 d2             	test   %rdx,%rdx
    9842:	0f 84 8c 00 00 00    	je     98d4 <fwp_fmt_duration+0xb24>
    9848:	83 fa 08             	cmp    $0x8,%edx
    984b:	72 61                	jb     98ae <fwp_fmt_duration+0xafe>
    984d:	48 89 ce             	mov    %rcx,%rsi
    9850:	45 89 c8             	mov    %r9d,%r8d
    9853:	44 89 ca             	mov    %r9d,%edx
    9856:	83 e2 07             	and    $0x7,%edx
    9859:	48 89 c1             	mov    %rax,%rcx
    985c:	48 29 d1             	sub    %rdx,%rcx
    985f:	49 89 f2             	mov    %rsi,%r10
    9862:	49 f7 da             	neg    %r10
    9865:	49 01 e2             	add    %rsp,%r10
    9868:	49 83 c2 40          	add    $0x40,%r10
    986c:	4d 01 c2             	add    %r8,%r10
    986f:	49 83 c2 f8          	add    $0xfffffffffffffff8,%r10
    9873:	49 29 d0             	sub    %rdx,%r8
    9876:	66 0f ef c0          	pxor   %xmm0,%xmm0
    987a:	f3 41 0f 7e 0a       	movq   (%r10),%xmm1
    987f:	66 0f 60 c8          	punpcklbw %xmm0,%xmm1
    9883:	66 0f 70 c9 4e       	pshufd $0x4e,%xmm1,%xmm1
    9888:	f2 0f 70 c9 1b       	pshuflw $0x1b,%xmm1,%xmm1
    988d:	f3 0f 70 c9 1b       	pshufhw $0x1b,%xmm1,%xmm1
    9892:	66 0f 67 c9          	packuswb %xmm1,%xmm1
    9896:	66 0f d6 4c 34 01    	movq   %xmm1,0x1(%rsp,%rsi,1)
    989c:	48 83 c6 08          	add    $0x8,%rsi
    98a0:	49 83 c2 f8          	add    $0xfffffffffffffff8,%r10
    98a4:	49 39 f0             	cmp    %rsi,%r8
    98a7:	75 d1                	jne    987a <fwp_fmt_duration+0xaca>
    98a9:	48 85 d2             	test   %rdx,%rdx
    98ac:	74 26                	je     98d4 <fwp_fmt_duration+0xb24>
    98ae:	48 8d 74 24 40       	lea    0x40(%rsp),%rsi
    98b3:	48 01 f2             	add    %rsi,%rdx
    98b6:	48 ff ca             	dec    %rdx
    98b9:	44 89 ce             	mov    %r9d,%esi
    98bc:	0f 1f 40 00          	nopl   0x0(%rax)
    98c0:	44 0f b6 02          	movzbl (%rdx),%r8d
    98c4:	44 88 44 0c 01       	mov    %r8b,0x1(%rsp,%rcx,1)
    98c9:	48 ff c1             	inc    %rcx
    98cc:	48 ff ca             	dec    %rdx
    98cf:	48 39 ce             	cmp    %rcx,%rsi
    98d2:	75 ec                	jne    98c0 <fwp_fmt_duration+0xb10>
    98d4:	c6 44 04 01 00       	movb   $0x0,0x1(%rsp,%rax,1)
    98d9:	e9 28 f9 ff ff       	jmp    9206 <fwp_fmt_duration+0x456>
    98de:	66 90                	xchg   %ax,%ax

00000000000098e0 <fwp_format_g>:
    98e0:	55                   	push   %rbp
    98e1:	41 57                	push   %r15
    98e3:	41 56                	push   %r14
    98e5:	41 55                	push   %r13
    98e7:	41 54                	push   %r12
    98e9:	53                   	push   %rbx
    98ea:	48 81 ec 98 00 00 00 	sub    $0x98,%rsp
    98f1:	89 f5                	mov    %esi,%ebp
    98f3:	48 89 fb             	mov    %rdi,%rbx
    98f6:	ff cd                	dec    %ebp
    98f8:	48 8d 15 4e 5d 00 00 	lea    0x5d4e(%rip),%rdx        # f64d <fwp_segv.msg+0x40d>
    98ff:	4c 8d 64 24 50       	lea    0x50(%rsp),%r12
    9904:	be 40 00 00 00       	mov    $0x40,%esi
    9909:	4c 89 e7             	mov    %r12,%rdi
    990c:	89 e9                	mov    %ebp,%ecx
    990e:	f2 0f 11 44 24 08    	movsd  %xmm0,0x8(%rsp)
    9914:	b0 01                	mov    $0x1,%al
    9916:	e8 f5 87 ff ff       	call   2110 <snprintf@plt>
    991b:	4c 89 e7             	mov    %r12,%rdi
    991e:	be 65 00 00 00       	mov    $0x65,%esi
    9923:	e8 d8 87 ff ff       	call   2100 <strchr@plt>
    9928:	49 89 c7             	mov    %rax,%r15
    992b:	48 8d 78 01          	lea    0x1(%rax),%rdi
    992f:	45 31 ed             	xor    %r13d,%r13d
    9932:	31 f6                	xor    %esi,%esi
    9934:	ba 0a 00 00 00       	mov    $0xa,%edx
    9939:	e8 92 88 ff ff       	call   21d0 <strtol@plt>
    993e:	49 89 c6             	mov    %rax,%r14
    9941:	83 c0 ef             	add    $0xffffffef,%eax
    9944:	83 f8 e9             	cmp    $0xffffffe9,%eax
    9947:	77 5f                	ja     99a8 <fwp_format_g+0xc8>
    9949:	4d 29 e7             	sub    %r12,%r15
    994c:	4c 8d 6c 24 10       	lea    0x10(%rsp),%r13
    9951:	4c 89 ef             	mov    %r13,%rdi
    9954:	4c 89 e6             	mov    %r12,%rsi
    9957:	4c 89 fa             	mov    %r15,%rdx
    995a:	e8 81 88 ff ff       	call   21e0 <memcpy@plt>
    995f:	42 c6 44 3c 10 00    	movb   $0x0,0x10(%rsp,%r15,1)
    9965:	4c 89 ef             	mov    %r13,%rdi
    9968:	be 2e 00 00 00       	mov    $0x2e,%esi
    996d:	e8 8e 87 ff ff       	call   2100 <strchr@plt>
    9972:	48 85 c0             	test   %rax,%rax
    9975:	0f 84 a8 00 00 00    	je     9a23 <fwp_format_g+0x143>
    997b:	4d 85 ff             	test   %r15,%r15
    997e:	0f 84 9f 00 00 00    	je     9a23 <fwp_format_g+0x143>
    9984:	66 66 66 2e 0f 1f 84 	data16 data16 cs nopw 0x0(%rax,%rax,1)
    998b:	00 00 00 00 00 
    9990:	42 0f b6 44 3c 0f    	movzbl 0xf(%rsp,%r15,1),%eax
    9996:	83 f8 30             	cmp    $0x30,%eax
    9999:	75 7d                	jne    9a18 <fwp_format_g+0x138>
    999b:	42 c6 44 3c 0f 00    	movb   $0x0,0xf(%rsp,%r15,1)
    99a1:	49 ff cf             	dec    %r15
    99a4:	75 ea                	jne    9990 <fwp_format_g+0xb0>
    99a6:	eb 7b                	jmp    9a23 <fwp_format_g+0x143>
    99a8:	44 29 f5             	sub    %r14d,%ebp
    99ab:	85 ed                	test   %ebp,%ebp
    99ad:	44 0f 4f ed          	cmovg  %ebp,%r13d
    99b1:	48 8d 15 a4 5c 00 00 	lea    0x5ca4(%rip),%rdx        # f65c <fwp_segv.msg+0x41c>
    99b8:	be 90 01 00 00       	mov    $0x190,%esi
    99bd:	48 89 df             	mov    %rbx,%rdi
    99c0:	44 89 e9             	mov    %r13d,%ecx
    99c3:	f2 0f 10 44 24 08    	movsd  0x8(%rsp),%xmm0
    99c9:	b0 01                	mov    $0x1,%al
    99cb:	e8 40 87 ff ff       	call   2110 <snprintf@plt>
    99d0:	48 89 df             	mov    %rbx,%rdi
    99d3:	e8 08 87 ff ff       	call   20e0 <strlen@plt>
    99d8:	49 89 c6             	mov    %rax,%r14
    99db:	48 89 df             	mov    %rbx,%rdi
    99de:	be 2e 00 00 00       	mov    $0x2e,%esi
    99e3:	e8 18 87 ff ff       	call   2100 <strchr@plt>
    99e8:	48 85 c0             	test   %rax,%rax
    99eb:	74 69                	je     9a56 <fwp_format_g+0x176>
    99ed:	4d 85 f6             	test   %r14,%r14
    99f0:	74 64                	je     9a56 <fwp_format_g+0x176>
    99f2:	66 66 66 66 66 2e 0f 	data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    99f9:	1f 84 00 00 00 00 00 
    9a00:	42 0f b6 44 33 ff    	movzbl -0x1(%rbx,%r14,1),%eax
    9a06:	83 f8 30             	cmp    $0x30,%eax
    9a09:	75 5d                	jne    9a68 <fwp_format_g+0x188>
    9a0b:	42 c6 44 33 ff 00    	movb   $0x0,-0x1(%rbx,%r14,1)
    9a11:	49 ff ce             	dec    %r14
    9a14:	75 ea                	jne    9a00 <fwp_format_g+0x120>
    9a16:	eb 3e                	jmp    9a56 <fwp_format_g+0x176>
    9a18:	83 f8 2e             	cmp    $0x2e,%eax
    9a1b:	75 06                	jne    9a23 <fwp_format_g+0x143>
    9a1d:	42 c6 44 3c 0f 00    	movb   $0x0,0xf(%rsp,%r15,1)
    9a23:	44 89 f0             	mov    %r14d,%eax
    9a26:	c1 e8 1f             	shr    $0x1f,%eax
    9a29:	44 8d 04 45 2b 00 00 	lea    0x2b(,%rax,2),%r8d
    9a30:	00 
    9a31:	45 89 f1             	mov    %r14d,%r9d
    9a34:	41 f7 d9             	neg    %r9d
    9a37:	45 0f 48 ce          	cmovs  %r14d,%r9d
    9a3b:	48 8d 15 10 5c 00 00 	lea    0x5c10(%rip),%rdx        # f652 <fwp_segv.msg+0x412>
    9a42:	48 8d 4c 24 10       	lea    0x10(%rsp),%rcx
    9a47:	be 90 01 00 00       	mov    $0x190,%esi
    9a4c:	48 89 df             	mov    %rbx,%rdi
    9a4f:	31 c0                	xor    %eax,%eax
    9a51:	e8 ba 86 ff ff       	call   2110 <snprintf@plt>
    9a56:	48 81 c4 98 00 00 00 	add    $0x98,%rsp
    9a5d:	5b                   	pop    %rbx
    9a5e:	41 5c                	pop    %r12
    9a60:	41 5d                	pop    %r13
    9a62:	41 5e                	pop    %r14
    9a64:	41 5f                	pop    %r15
    9a66:	5d                   	pop    %rbp
    9a67:	c3                   	ret
    9a68:	83 f8 2e             	cmp    $0x2e,%eax
    9a6b:	75 e9                	jne    9a56 <fwp_format_g+0x176>
    9a6d:	42 c6 44 33 ff 00    	movb   $0x0,-0x1(%rbx,%r14,1)
    9a73:	eb e1                	jmp    9a56 <fwp_format_g+0x176>
    9a75:	66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
    9a7c:	00 00 00 00 

0000000000009a80 <fwp_show_i64>:
    9a80:	41 57                	push   %r15
    9a82:	41 56                	push   %r14
    9a84:	53                   	push   %rbx
    9a85:	48 83 ec 20          	sub    $0x20,%rsp
    9a89:	48 be 00 00 00 00 01 	movabs $0x100000000,%rsi
    9a90:	00 00 00 
    9a93:	48 89 f9             	mov    %rdi,%rcx
    9a96:	48 f7 d9             	neg    %rcx
    9a99:	48 0f 48 cf          	cmovs  %rdi,%rcx
    9a9d:	48 8d 5c 24 18       	lea    0x18(%rsp),%rbx
    9aa2:	4c 8d 44 24 17       	lea    0x17(%rsp),%r8
    9aa7:	45 31 f6             	xor    %r14d,%r14d
    9aaa:	49 b9 cd cc cc cc cc 	movabs $0xcccccccccccccccd,%r9
    9ab1:	cc cc cc 
    9ab4:	66 66 66 2e 0f 1f 84 	data16 data16 cs nopw 0x0(%rax,%rax,1)
    9abb:	00 00 00 00 00 
    9ac0:	48 89 c8             	mov    %rcx,%rax
    9ac3:	49 f7 e1             	mul    %r9
    9ac6:	48 c1 ea 03          	shr    $0x3,%rdx
    9aca:	8d 04 12             	lea    (%rdx,%rdx,1),%eax
    9acd:	8d 04 80             	lea    (%rax,%rax,4),%eax
    9ad0:	41 89 ca             	mov    %ecx,%r10d
    9ad3:	41 29 c2             	sub    %eax,%r10d
    9ad6:	41 80 ca 30          	or     $0x30,%r10b
    9ada:	45 88 10             	mov    %r10b,(%r8)
    9add:	49 01 f6             	add    %rsi,%r14
    9ae0:	49 ff c8             	dec    %r8
    9ae3:	48 83 f9 09          	cmp    $0x9,%rcx
    9ae7:	48 89 d1             	mov    %rdx,%rcx
    9aea:	77 d4                	ja     9ac0 <fwp_show_i64+0x40>
    9aec:	48 85 ff             	test   %rdi,%rdi
    9aef:	78 06                	js     9af7 <fwp_show_i64+0x77>
    9af1:	49 c1 fe 20          	sar    $0x20,%r14
    9af5:	eb 11                	jmp    9b08 <fwp_show_i64+0x88>
    9af7:	49 01 f6             	add    %rsi,%r14
    9afa:	49 c1 fe 20          	sar    $0x20,%r14
    9afe:	48 89 e0             	mov    %rsp,%rax
    9b01:	4c 29 f0             	sub    %r14,%rax
    9b04:	c6 40 18 2d          	movb   $0x2d,0x18(%rax)
    9b08:	49 8d 56 09          	lea    0x9(%r14),%rdx
    9b0c:	48 81 fa 00 40 00 00 	cmp    $0x4000,%rdx
    9b13:	77 61                	ja     9b76 <fwp_show_i64+0xf6>
    9b15:	49 8d 4e 18          	lea    0x18(%r14),%rcx
    9b19:	48 c1 e9 04          	shr    $0x4,%rcx
    9b1d:	48 8d 05 5c 86 00 00 	lea    0x865c(%rip),%rax        # 12180 <fwp_gc>
    9b24:	0f b6 b4 01 e8 0b 00 	movzbl 0xbe8(%rcx,%rax,1),%esi
    9b2b:	00 
    9b2c:	8b 8c b0 48 0b 00 00 	mov    0xb48(%rax,%rsi,4),%ecx
    9b33:	48 29 0d 46 86 00 00 	sub    %rcx,0x8646(%rip)        # 12180 <fwp_gc>
    9b3a:	78 3a                	js     9b76 <fwp_show_i64+0xf6>
    9b3c:	48 8d 34 76          	lea    (%rsi,%rsi,2),%rsi
    9b40:	48 8d 3c f0          	lea    (%rax,%rsi,8),%rdi
    9b44:	48 81 c7 c8 03 00 00 	add    $0x3c8,%rdi
    9b4b:	4c 8b 3f             	mov    (%rdi),%r15
    9b4e:	4d 85 ff             	test   %r15,%r15
    9b51:	74 0b                	je     9b5e <fwp_show_i64+0xde>
    9b53:	49 8b 07             	mov    (%r15),%rax
    9b56:	48 f7 d0             	not    %rax
    9b59:	48 89 07             	mov    %rax,(%rdi)
    9b5c:	eb 3a                	jmp    9b98 <fwp_show_i64+0x118>
    9b5e:	4c 8b bc f0 d0 03 00 	mov    0x3d0(%rax,%rsi,8),%r15
    9b65:	00 
    9b66:	48 8b bc f0 d8 03 00 	mov    0x3d8(%rax,%rsi,8),%rdi
    9b6d:	00 
    9b6e:	4c 29 ff             	sub    %r15,%rdi
    9b71:	48 39 cf             	cmp    %rcx,%rdi
    9b74:	73 12                	jae    9b88 <fwp_show_i64+0x108>
    9b76:	48 89 d7             	mov    %rdx,%rdi
    9b79:	be 01 00 00 00       	mov    $0x1,%esi
    9b7e:	e8 ed ca ff ff       	call   6670 <fwp_gc_alloc_slow>
    9b83:	49 89 c7             	mov    %rax,%r15
    9b86:	eb 1a                	jmp    9ba2 <fwp_show_i64+0x122>
    9b88:	48 8d 04 f0          	lea    (%rax,%rsi,8),%rax
    9b8c:	48 05 d0 03 00 00    	add    $0x3d0,%rax
    9b92:	4c 01 f9             	add    %r15,%rcx
    9b95:	48 89 08             	mov    %rcx,(%rax)
    9b98:	4c 89 ff             	mov    %r15,%rdi
    9b9b:	31 f6                	xor    %esi,%esi
    9b9d:	e8 8e 85 ff ff       	call   2130 <memset@plt>
    9ba2:	4c 29 f3             	sub    %r14,%rbx
    9ba5:	4d 89 37             	mov    %r14,(%r15)
    9ba8:	49 8d 7f 08          	lea    0x8(%r15),%rdi
    9bac:	48 89 de             	mov    %rbx,%rsi
    9baf:	4c 89 f2             	mov    %r14,%rdx
    9bb2:	e8 29 86 ff ff       	call   21e0 <memcpy@plt>
    9bb7:	43 c6 44 37 08 00    	movb   $0x0,0x8(%r15,%r14,1)
    9bbd:	4c 89 f8             	mov    %r15,%rax
    9bc0:	48 83 c4 20          	add    $0x20,%rsp
    9bc4:	5b                   	pop    %rbx
    9bc5:	41 5e                	pop    %r14
    9bc7:	41 5f                	pop    %r15
    9bc9:	c3                   	ret
    9bca:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)

0000000000009bd0 <fwp_p_array_get_typed>:
    9bd0:	48 85 ff             	test   %rdi,%rdi
    9bd3:	78 3e                	js     9c13 <fwp_p_array_get_typed+0x43>
    9bd5:	48 8b 0e             	mov    (%rsi),%rcx
    9bd8:	48 b8 ff ff ff ff ff 	movabs $0x7fffffffffffffff,%rax
    9bdf:	ff ff 7f 
    9be2:	48 21 c8             	and    %rcx,%rax
    9be5:	48 39 f8             	cmp    %rdi,%rax
    9be8:	76 29                	jbe    9c13 <fwp_p_array_get_typed+0x43>
    9bea:	b8 08 00 00 00       	mov    $0x8,%eax
    9bef:	48 85 d2             	test   %rdx,%rdx
    9bf2:	74 14                	je     9c08 <fwp_p_array_get_typed+0x38>
    9bf4:	44 8b 02             	mov    (%rdx),%r8d
    9bf7:	49 83 f8 0a          	cmp    $0xa,%r8
    9bfb:	77 0b                	ja     9c08 <fwp_p_array_get_typed+0x38>
    9bfd:	48 8d 05 b4 56 00 00 	lea    0x56b4(%rip),%rax        # f2b8 <fwp_segv.msg+0x78>
    9c04:	4a 8b 04 c0          	mov    (%rax,%r8,8),%rax
    9c08:	48 85 c9             	test   %rcx,%rcx
    9c0b:	78 09                	js     9c16 <fwp_p_array_get_typed+0x46>
    9c0d:	48 8d 4e 08          	lea    0x8(%rsi),%rcx
    9c11:	eb 07                	jmp    9c1a <fwp_p_array_get_typed+0x4a>
    9c13:	31 c0                	xor    %eax,%eax
    9c15:	c3                   	ret
    9c16:	48 8b 4e 10          	mov    0x10(%rsi),%rcx
    9c1a:	41 57                	push   %r15
    9c1c:	41 56                	push   %r14
    9c1e:	53                   	push   %rbx
    9c1f:	48 83 ec 10          	sub    $0x10,%rsp
    9c23:	48 0f af f8          	imul   %rax,%rdi
    9c27:	48 83 f8 01          	cmp    $0x1,%rax
    9c2b:	49 89 f6             	mov    %rsi,%r14
    9c2e:	74 1f                	je     9c4f <fwp_p_array_get_typed+0x7f>
    9c30:	48 83 f8 02          	cmp    $0x2,%rax
    9c34:	74 0c                	je     9c42 <fwp_p_array_get_typed+0x72>
    9c36:	48 83 f8 08          	cmp    $0x8,%rax
    9c3a:	75 20                	jne    9c5c <fwp_p_array_get_typed+0x8c>
    9c3c:	48 8b 04 39          	mov    (%rcx,%rdi,1),%rax
    9c40:	eb 27                	jmp    9c69 <fwp_p_array_get_typed+0x99>
    9c42:	83 3a 01             	cmpl   $0x1,(%rdx)
    9c45:	0f b7 0c 39          	movzwl (%rcx,%rdi,1),%ecx
    9c49:	48 0f bf c1          	movswq %cx,%rax
    9c4d:	eb 16                	jmp    9c65 <fwp_p_array_get_typed+0x95>
    9c4f:	83 3a 00             	cmpl   $0x0,(%rdx)
    9c52:	0f b6 0c 39          	movzbl (%rcx,%rdi,1),%ecx
    9c56:	48 0f be c1          	movsbq %cl,%rax
    9c5a:	eb 09                	jmp    9c65 <fwp_p_array_get_typed+0x95>
    9c5c:	83 3a 02             	cmpl   $0x2,(%rdx)
    9c5f:	8b 0c 39             	mov    (%rcx,%rdi,1),%ecx
    9c62:	48 63 c1             	movslq %ecx,%rax
    9c65:	48 0f 45 c1          	cmovne %rcx,%rax
    9c69:	48 89 44 24 08       	mov    %rax,0x8(%rsp)
    9c6e:	48 8d 54 24 08       	lea    0x8(%rsp),%rdx
    9c73:	bf 01 00 00 00       	mov    $0x1,%edi
    9c78:	be 01 00 00 00       	mov    $0x1,%esi
    9c7d:	e8 9e 00 00 00       	call   9d20 <fwp_data>
    9c82:	48 89 c2             	mov    %rax,%rdx
    9c85:	48 2b 15 24 95 00 00 	sub    0x9524(%rip),%rdx        # 131b0 <fwp_gc+0x1030>
    9c8c:	48 8b 0d 45 95 00 00 	mov    0x9545(%rip),%rcx        # 131d8 <fwp_gc+0x1058>
    9c93:	48 c1 e1 10          	shl    $0x10,%rcx
    9c97:	48 39 ca             	cmp    %rcx,%rdx
    9c9a:	4c 89 f1             	mov    %r14,%rcx
    9c9d:	73 77                	jae    9d16 <fwp_p_array_get_typed+0x146>
    9c9f:	48 8b 35 52 95 00 00 	mov    0x9552(%rip),%rsi        # 131f8 <fwp_gc+0x1078>
    9ca6:	48 89 d7             	mov    %rdx,%rdi
    9ca9:	48 c1 ef 10          	shr    $0x10,%rdi
    9cad:	48 69 ff 28 12 00 00 	imul   $0x1228,%rdi,%rdi
    9cb4:	44 0f b6 04 3e       	movzbl (%rsi,%rdi,1),%r8d
    9cb9:	48 81 e2 ff ff 00 00 	and    $0xffff,%rdx
    9cc0:	75 1b                	jne    9cdd <fwp_p_array_get_typed+0x10d>
    9cc2:	41 80 f8 02          	cmp    $0x2,%r8b
    9cc6:	75 15                	jne    9cdd <fwp_p_array_get_typed+0x10d>
    9cc8:	48 8d 1c 3e          	lea    (%rsi,%rdi,1),%rbx
    9ccc:	48 81 c3 28 02 00 00 	add    $0x228,%rbx
    9cd3:	80 3b ff             	cmpb   $0xff,(%rbx)
    9cd6:	74 2b                	je     9d03 <fwp_p_array_get_typed+0x133>
    9cd8:	c6 03 01             	movb   $0x1,(%rbx)
    9cdb:	eb 39                	jmp    9d16 <fwp_p_array_get_typed+0x146>
    9cdd:	41 80 f8 01          	cmp    $0x1,%r8b
    9ce1:	75 33                	jne    9d16 <fwp_p_array_get_typed+0x146>
    9ce3:	4c 8d 04 3e          	lea    (%rsi,%rdi,1),%r8
    9ce7:	8b 74 3e 20          	mov    0x20(%rsi,%rdi,1),%esi
    9ceb:	48 0f af d6          	imul   %rsi,%rdx
    9cef:	48 c1 ea 20          	shr    $0x20,%rdx
    9cf3:	4a 8d 1c 02          	lea    (%rdx,%r8,1),%rbx
    9cf7:	48 81 c3 28 02 00 00 	add    $0x228,%rbx
    9cfe:	80 3b ff             	cmpb   $0xff,(%rbx)
    9d01:	75 d5                	jne    9cd8 <fwp_p_array_get_typed+0x108>
    9d03:	48 89 df             	mov    %rbx,%rdi
    9d06:	49 89 c7             	mov    %rax,%r15
    9d09:	e8 42 c5 ff ff       	call   6250 <fwp_rc_forget_slot>
    9d0e:	4c 89 f8             	mov    %r15,%rax
    9d11:	4c 89 f1             	mov    %r14,%rcx
    9d14:	eb c2                	jmp    9cd8 <fwp_p_array_get_typed+0x108>
    9d16:	48 83 c4 10          	add    $0x10,%rsp
    9d1a:	5b                   	pop    %rbx
    9d1b:	41 5e                	pop    %r14
    9d1d:	41 5f                	pop    %r15
    9d1f:	c3                   	ret

0000000000009d20 <fwp_data>:
    9d20:	55                   	push   %rbp
    9d21:	41 57                	push   %r15
    9d23:	41 56                	push   %r14
    9d25:	41 55                	push   %r13
    9d27:	41 54                	push   %r12
    9d29:	53                   	push   %rbx
    9d2a:	50                   	push   %rax
    9d2b:	48 89 d3             	mov    %rdx,%rbx
    9d2e:	89 f5                	mov    %esi,%ebp
    9d30:	41 89 ff             	mov    %edi,%r15d
    9d33:	41 89 f4             	mov    %esi,%r12d
    9d36:	4e 8d 2c e5 00 00 00 	lea    0x0(,%r12,8),%r13
    9d3d:	00 
    9d3e:	4a 8d 3c e5 08 00 00 	lea    0x8(,%r12,8),%rdi
    9d45:	00 
    9d46:	81 fe ff 07 00 00    	cmp    $0x7ff,%esi
    9d4c:	0f 87 e6 00 00 00    	ja     9e38 <fwp_data+0x118>
    9d52:	49 8d 75 17          	lea    0x17(%r13),%rsi
    9d56:	48 c1 ee 04          	shr    $0x4,%rsi
    9d5a:	48 8d 05 1f 84 00 00 	lea    0x841f(%rip),%rax        # 12180 <fwp_gc>
    9d61:	0f b6 8c 06 e8 0b 00 	movzbl 0xbe8(%rsi,%rax,1),%ecx
    9d68:	00 
    9d69:	8b 94 88 48 0b 00 00 	mov    0xb48(%rax,%rcx,4),%edx
    9d70:	4c 8b 05 09 84 00 00 	mov    0x8409(%rip),%r8        # 12180 <fwp_gc>
    9d77:	4d 89 c1             	mov    %r8,%r9
    9d7a:	49 29 d1             	sub    %rdx,%r9
    9d7d:	4c 89 0d fc 83 00 00 	mov    %r9,0x83fc(%rip)        # 12180 <fwp_gc>
    9d84:	0f 88 ae 00 00 00    	js     9e38 <fwp_data+0x118>
    9d8a:	4c 8d 0c 49          	lea    (%rcx,%rcx,2),%r9
    9d8e:	4e 8d 14 c8          	lea    (%rax,%r9,8),%r10
    9d92:	49 83 c2 08          	add    $0x8,%r10
    9d96:	4d 8b 32             	mov    (%r10),%r14
    9d99:	4d 85 f6             	test   %r14,%r14
    9d9c:	74 29                	je     9dc7 <fwp_data+0xa7>
    9d9e:	49 8b 06             	mov    (%r14),%rax
    9da1:	48 f7 d0             	not    %rax
    9da4:	49 89 02             	mov    %rax,(%r10)
    9da7:	48 39 d7             	cmp    %rdx,%rdi
    9daa:	0f 83 ad 00 00 00    	jae    9e5d <fwp_data+0x13d>
    9db0:	4c 01 f7             	add    %r14,%rdi
    9db3:	4c 29 ea             	sub    %r13,%rdx
    9db6:	48 83 c2 f7          	add    $0xfffffffffffffff7,%rdx
    9dba:	48 83 e2 f8          	and    $0xfffffffffffffff8,%rdx
    9dbe:	48 83 c2 08          	add    $0x8,%rdx
    9dc2:	e9 8f 00 00 00       	jmp    9e56 <fwp_data+0x136>
    9dc7:	4e 8b 74 c8 10       	mov    0x10(%rax,%r9,8),%r14
    9dcc:	4e 8b 54 c8 18       	mov    0x18(%rax,%r9,8),%r10
    9dd1:	4d 29 f2             	sub    %r14,%r10
    9dd4:	49 39 d2             	cmp    %rdx,%r10
    9dd7:	72 2f                	jb     9e08 <fwp_data+0xe8>
    9dd9:	4a 8d 0c c8          	lea    (%rax,%r9,8),%rcx
    9ddd:	48 83 c1 10          	add    $0x10,%rcx
    9de1:	4d 8d 0c 16          	lea    (%r14,%rdx,1),%r9
    9de5:	4c 89 09             	mov    %r9,(%rcx)
    9de8:	4d 85 f6             	test   %r14,%r14
    9deb:	75 ba                	jne    9da7 <fwp_data+0x87>
    9ded:	0f b6 8c 06 e8 0b 00 	movzbl 0xbe8(%rsi,%rax,1),%ecx
    9df4:	00 
    9df5:	8b 94 88 48 0b 00 00 	mov    0xb48(%rax,%rcx,4),%edx
    9dfc:	49 29 d0             	sub    %rdx,%r8
    9dff:	4c 89 05 7a 83 00 00 	mov    %r8,0x837a(%rip)        # 12180 <fwp_gc>
    9e06:	78 30                	js     9e38 <fwp_data+0x118>
    9e08:	48 8d 0c 49          	lea    (%rcx,%rcx,2),%rcx
    9e0c:	4c 8b 74 c8 08       	mov    0x8(%rax,%rcx,8),%r14
    9e11:	4d 85 f6             	test   %r14,%r14
    9e14:	74 10                	je     9e26 <fwp_data+0x106>
    9e16:	48 8d 04 c8          	lea    (%rax,%rcx,8),%rax
    9e1a:	48 83 c0 08          	add    $0x8,%rax
    9e1e:	49 8b 0e             	mov    (%r14),%rcx
    9e21:	48 f7 d1             	not    %rcx
    9e24:	eb 2a                	jmp    9e50 <fwp_data+0x130>
    9e26:	4c 8b 74 c8 10       	mov    0x10(%rax,%rcx,8),%r14
    9e2b:	48 8b 74 c8 18       	mov    0x18(%rax,%rcx,8),%rsi
    9e30:	4c 29 f6             	sub    %r14,%rsi
    9e33:	48 39 d6             	cmp    %rdx,%rsi
    9e36:	73 0c                	jae    9e44 <fwp_data+0x124>
    9e38:	31 f6                	xor    %esi,%esi
    9e3a:	e8 31 c8 ff ff       	call   6670 <fwp_gc_alloc_slow>
    9e3f:	49 89 c6             	mov    %rax,%r14
    9e42:	eb 19                	jmp    9e5d <fwp_data+0x13d>
    9e44:	48 8d 04 c8          	lea    (%rax,%rcx,8),%rax
    9e48:	48 83 c0 10          	add    $0x10,%rax
    9e4c:	49 8d 0c 16          	lea    (%r14,%rdx,1),%rcx
    9e50:	48 89 08             	mov    %rcx,(%rax)
    9e53:	4c 89 f7             	mov    %r14,%rdi
    9e56:	31 f6                	xor    %esi,%esi
    9e58:	e8 d3 82 ff ff       	call   2130 <memset@plt>
    9e5d:	45 89 3e             	mov    %r15d,(%r14)
    9e60:	41 89 6e 04          	mov    %ebp,0x4(%r14)
    9e64:	85 ed                	test   %ebp,%ebp
    9e66:	0f 84 bb 00 00 00    	je     9f27 <fwp_data+0x207>
    9e6c:	83 fd 08             	cmp    $0x8,%ebp
    9e6f:	72 10                	jb     9e81 <fwp_data+0x161>
    9e71:	4c 89 f0             	mov    %r14,%rax
    9e74:	48 29 d8             	sub    %rbx,%rax
    9e77:	48 83 c0 08          	add    $0x8,%rax
    9e7b:	48 83 f8 20          	cmp    $0x20,%rax
    9e7f:	73 71                	jae    9ef2 <fwp_data+0x1d2>
    9e81:	31 c0                	xor    %eax,%eax
    9e83:	4c 89 e2             	mov    %r12,%rdx
    9e86:	48 89 c1             	mov    %rax,%rcx
    9e89:	48 83 e2 03          	and    $0x3,%rdx
    9e8d:	74 22                	je     9eb1 <fwp_data+0x191>
    9e8f:	48 89 c1             	mov    %rax,%rcx
    9e92:	66 66 66 66 66 2e 0f 	data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    9e99:	1f 84 00 00 00 00 00 
    9ea0:	48 8b 34 cb          	mov    (%rbx,%rcx,8),%rsi
    9ea4:	49 89 74 ce 08       	mov    %rsi,0x8(%r14,%rcx,8)
    9ea9:	48 ff c1             	inc    %rcx
    9eac:	48 ff ca             	dec    %rdx
    9eaf:	75 ef                	jne    9ea0 <fwp_data+0x180>
    9eb1:	4c 29 e0             	sub    %r12,%rax
    9eb4:	48 83 f8 fc          	cmp    $0xfffffffffffffffc,%rax
    9eb8:	77 6d                	ja     9f27 <fwp_data+0x207>
    9eba:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)
    9ec0:	48 8b 04 cb          	mov    (%rbx,%rcx,8),%rax
    9ec4:	49 89 44 ce 08       	mov    %rax,0x8(%r14,%rcx,8)
    9ec9:	48 8b 44 cb 08       	mov    0x8(%rbx,%rcx,8),%rax
    9ece:	49 89 44 ce 10       	mov    %rax,0x10(%r14,%rcx,8)
    9ed3:	48 8b 44 cb 10       	mov    0x10(%rbx,%rcx,8),%rax
    9ed8:	49 89 44 ce 18       	mov    %rax,0x18(%r14,%rcx,8)
    9edd:	48 8b 44 cb 18       	mov    0x18(%rbx,%rcx,8),%rax
    9ee2:	49 89 44 ce 20       	mov    %rax,0x20(%r14,%rcx,8)
    9ee7:	48 83 c1 04          	add    $0x4,%rcx
    9eeb:	49 39 cc             	cmp    %rcx,%r12
    9eee:	75 d0                	jne    9ec0 <fwp_data+0x1a0>
    9ef0:	eb 35                	jmp    9f27 <fwp_data+0x207>
    9ef2:	44 89 e0             	mov    %r12d,%eax
    9ef5:	83 e0 fc             	and    $0xfffffffc,%eax
    9ef8:	49 83 e5 e0          	and    $0xffffffffffffffe0,%r13
    9efc:	31 c9                	xor    %ecx,%ecx
    9efe:	66 90                	xchg   %ax,%ax
    9f00:	0f 10 04 0b          	movups (%rbx,%rcx,1),%xmm0
    9f04:	0f 10 4c 0b 10       	movups 0x10(%rbx,%rcx,1),%xmm1
    9f09:	41 0f 11 44 0e 08    	movups %xmm0,0x8(%r14,%rcx,1)
    9f0f:	41 0f 11 4c 0e 18    	movups %xmm1,0x18(%r14,%rcx,1)
    9f15:	48 83 c1 20          	add    $0x20,%rcx
    9f19:	49 39 cd             	cmp    %rcx,%r13
    9f1c:	75 e2                	jne    9f00 <fwp_data+0x1e0>
    9f1e:	4c 39 e0             	cmp    %r12,%rax
    9f21:	0f 85 5c ff ff ff    	jne    9e83 <fwp_data+0x163>
    9f27:	4c 89 f0             	mov    %r14,%rax
    9f2a:	48 83 c4 08          	add    $0x8,%rsp
    9f2e:	5b                   	pop    %rbx
    9f2f:	41 5c                	pop    %r12
    9f31:	41 5d                	pop    %r13
    9f33:	41 5e                	pop    %r14
    9f35:	41 5f                	pop    %r15
    9f37:	5d                   	pop    %rbp
    9f38:	c3                   	ret
    9f39:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)

0000000000009f40 <f49>:
    9f40:	41 57                	push   %r15
    9f42:	41 56                	push   %r14
    9f44:	53                   	push   %rbx
    9f45:	48 83 ec 30          	sub    $0x30,%rsp
    9f49:	48 89 fb             	mov    %rdi,%rbx
    9f4c:	48 8b 47 10          	mov    0x10(%rdi),%rax
    9f50:	48 2b 05 59 92 00 00 	sub    0x9259(%rip),%rax        # 131b0 <fwp_gc+0x1030>
    9f57:	48 8b 0d 7a 92 00 00 	mov    0x927a(%rip),%rcx        # 131d8 <fwp_gc+0x1058>
    9f5e:	48 c1 e1 10          	shl    $0x10,%rcx
    9f62:	48 39 c8             	cmp    %rcx,%rax
    9f65:	73 68                	jae    9fcf <f49+0x8f>
    9f67:	48 8b 0d 8a 92 00 00 	mov    0x928a(%rip),%rcx        # 131f8 <fwp_gc+0x1078>
    9f6e:	48 89 c2             	mov    %rax,%rdx
    9f71:	48 c1 ea 10          	shr    $0x10,%rdx
    9f75:	48 69 d2 28 12 00 00 	imul   $0x1228,%rdx,%rdx
    9f7c:	0f b6 34 11          	movzbl (%rcx,%rdx,1),%esi
    9f80:	48 25 ff ff 00 00    	and    $0xffff,%rax
    9f86:	75 13                	jne    9f9b <f49+0x5b>
    9f88:	40 80 fe 02          	cmp    $0x2,%sil
    9f8c:	75 0d                	jne    9f9b <f49+0x5b>
    9f8e:	48 8d 3c 11          	lea    (%rcx,%rdx,1),%rdi
    9f92:	48 81 c7 28 02 00 00 	add    $0x228,%rdi
    9f99:	eb 21                	jmp    9fbc <f49+0x7c>
    9f9b:	40 80 fe 01          	cmp    $0x1,%sil
    9f9f:	75 2e                	jne    9fcf <f49+0x8f>
    9fa1:	48 8d 34 11          	lea    (%rcx,%rdx,1),%rsi
    9fa5:	8b 4c 11 20          	mov    0x20(%rcx,%rdx,1),%ecx
    9fa9:	48 0f af c1          	imul   %rcx,%rax
    9fad:	48 c1 e8 20          	shr    $0x20,%rax
    9fb1:	48 8d 3c 30          	lea    (%rax,%rsi,1),%rdi
    9fb5:	48 81 c7 28 02 00 00 	add    $0x228,%rdi
    9fbc:	0f b6 07             	movzbl (%rdi),%eax
    9fbf:	84 c0                	test   %al,%al
    9fc1:	74 0c                	je     9fcf <f49+0x8f>
    9fc3:	3c fe                	cmp    $0xfe,%al
    9fc5:	0f 83 cc 02 00 00    	jae    a297 <f49+0x357>
    9fcb:	fe c0                	inc    %al
    9fcd:	88 07                	mov    %al,(%rdi)
    9fcf:	4c 8b 7b 08          	mov    0x8(%rbx),%r15
    9fd3:	48 8b 7b 10          	mov    0x10(%rbx),%rdi
    9fd7:	f2 0f 10 43 18       	movsd  0x18(%rbx),%xmm0
    9fdc:	f2 0f 11 04 24       	movsd  %xmm0,(%rsp)
    9fe1:	4d 85 ff             	test   %r15,%r15
    9fe4:	78 20                	js     a006 <f49+0xc6>
    9fe6:	48 8b 07             	mov    (%rdi),%rax
    9fe9:	48 b9 ff ff ff ff ff 	movabs $0x7fffffffffffffff,%rcx
    9ff0:	ff ff 7f 
    9ff3:	48 21 c1             	and    %rax,%rcx
    9ff6:	4c 39 f9             	cmp    %r15,%rcx
    9ff9:	76 0b                	jbe    a006 <f49+0xc6>
    9ffb:	48 85 c0             	test   %rax,%rax
    9ffe:	78 7c                	js     a07c <f49+0x13c>
    a000:	48 8d 47 08          	lea    0x8(%rdi),%rax
    a004:	eb 7a                	jmp    a080 <f49+0x140>
    a006:	e8 65 03 00 00       	call   a370 <fwp_drop1>
    a00b:	f2 0f 10 04 24       	movsd  (%rsp),%xmm0
    a010:	f2 0f 11 44 24 18    	movsd  %xmm0,0x18(%rsp)
    a016:	48 8d 54 24 18       	lea    0x18(%rsp),%rdx
    a01b:	bf 01 00 00 00       	mov    $0x1,%edi
    a020:	be 01 00 00 00       	mov    $0x1,%esi
    a025:	e8 f6 fc ff ff       	call   9d20 <fwp_data>
    a02a:	49 89 c6             	mov    %rax,%r14
    a02d:	48 2b 05 7c 91 00 00 	sub    0x917c(%rip),%rax        # 131b0 <fwp_gc+0x1030>
    a034:	48 8b 0d 9d 91 00 00 	mov    0x919d(%rip),%rcx        # 131d8 <fwp_gc+0x1058>
    a03b:	48 c1 e1 10          	shl    $0x10,%rcx
    a03f:	48 39 c8             	cmp    %rcx,%rax
    a042:	0f 83 3a 02 00 00    	jae    a282 <f49+0x342>
    a048:	48 8b 0d a9 91 00 00 	mov    0x91a9(%rip),%rcx        # 131f8 <fwp_gc+0x1078>
    a04f:	48 89 c2             	mov    %rax,%rdx
    a052:	48 c1 ea 10          	shr    $0x10,%rdx
    a056:	48 69 d2 28 12 00 00 	imul   $0x1228,%rdx,%rdx
    a05d:	0f b6 34 11          	movzbl (%rcx,%rdx,1),%esi
    a061:	48 25 ff ff 00 00    	and    $0xffff,%rax
    a067:	0f 85 e4 01 00 00    	jne    a251 <f49+0x311>
    a06d:	40 80 fe 02          	cmp    $0x2,%sil
    a071:	0f 84 c3 01 00 00    	je     a23a <f49+0x2fa>
    a077:	e9 d5 01 00 00       	jmp    a251 <f49+0x311>
    a07c:	48 8b 47 10          	mov    0x10(%rdi),%rax
    a080:	f2 42 0f 10 04 f8    	movsd  (%rax,%r15,8),%xmm0
    a086:	f2 0f 59 05 82 4f 00 	mulsd  0x4f82(%rip),%xmm0        # f010 <_IO_stdin_used+0x10>
    a08d:	00 
    a08e:	f2 0f 58 05 82 4f 00 	addsd  0x4f82(%rip),%xmm0        # f018 <_IO_stdin_used+0x18>
    a095:	00 
    a096:	f2 0f 11 44 24 08    	movsd  %xmm0,0x8(%rsp)
    a09c:	48 89 f8             	mov    %rdi,%rax
    a09f:	48 2b 05 0a 91 00 00 	sub    0x910a(%rip),%rax        # 131b0 <fwp_gc+0x1030>
    a0a6:	49 ff c7             	inc    %r15
    a0a9:	48 8b 0d 28 91 00 00 	mov    0x9128(%rip),%rcx        # 131d8 <fwp_gc+0x1058>
    a0b0:	48 c1 e1 10          	shl    $0x10,%rcx
    a0b4:	48 39 c8             	cmp    %rcx,%rax
    a0b7:	73 66                	jae    a11f <f49+0x1df>
    a0b9:	48 8b 0d 38 91 00 00 	mov    0x9138(%rip),%rcx        # 131f8 <fwp_gc+0x1078>
    a0c0:	48 89 c2             	mov    %rax,%rdx
    a0c3:	48 c1 ea 10          	shr    $0x10,%rdx
    a0c7:	48 69 d2 28 12 00 00 	imul   $0x1228,%rdx,%rdx
    a0ce:	0f b6 34 11          	movzbl (%rcx,%rdx,1),%esi
    a0d2:	48 25 ff ff 00 00    	and    $0xffff,%rax
    a0d8:	75 12                	jne    a0ec <f49+0x1ac>
    a0da:	40 80 fe 02          	cmp    $0x2,%sil
    a0de:	75 0c                	jne    a0ec <f49+0x1ac>
    a0e0:	48 8d 04 11          	lea    (%rcx,%rdx,1),%rax
    a0e4:	48 05 28 02 00 00    	add    $0x228,%rax
    a0ea:	eb 1f                	jmp    a10b <f49+0x1cb>
    a0ec:	40 80 fe 01          	cmp    $0x1,%sil
    a0f0:	75 2d                	jne    a11f <f49+0x1df>
    a0f2:	48 8d 34 11          	lea    (%rcx,%rdx,1),%rsi
    a0f6:	8b 4c 11 20          	mov    0x20(%rcx,%rdx,1),%ecx
    a0fa:	48 0f af c1          	imul   %rcx,%rax
    a0fe:	48 c1 e8 20          	shr    $0x20,%rax
    a102:	48 01 f0             	add    %rsi,%rax
    a105:	48 05 28 02 00 00    	add    $0x228,%rax
    a10b:	0f b6 08             	movzbl (%rax),%ecx
    a10e:	84 c9                	test   %cl,%cl
    a110:	74 0d                	je     a11f <f49+0x1df>
    a112:	80 f9 fe             	cmp    $0xfe,%cl
    a115:	0f 83 86 01 00 00    	jae    a2a1 <f49+0x361>
    a11b:	fe c1                	inc    %cl
    a11d:	88 08                	mov    %cl,(%rax)
    a11f:	49 89 fe             	mov    %rdi,%r14
    a122:	e8 49 02 00 00       	call   a370 <fwp_drop1>
    a127:	f2 0f 10 04 24       	movsd  (%rsp),%xmm0
    a12c:	f2 0f 58 44 24 08    	addsd  0x8(%rsp),%xmm0
    a132:	4c 89 7c 24 18       	mov    %r15,0x18(%rsp)
    a137:	4c 89 74 24 20       	mov    %r14,0x20(%rsp)
    a13c:	f2 0f 11 44 24 28    	movsd  %xmm0,0x28(%rsp)
    a142:	48 8d 54 24 18       	lea    0x18(%rsp),%rdx
    a147:	31 ff                	xor    %edi,%edi
    a149:	be 03 00 00 00       	mov    $0x3,%esi
    a14e:	e8 cd fb ff ff       	call   9d20 <fwp_data>
    a153:	48 89 c1             	mov    %rax,%rcx
    a156:	48 2b 0d 53 90 00 00 	sub    0x9053(%rip),%rcx        # 131b0 <fwp_gc+0x1030>
    a15d:	48 8b 15 74 90 00 00 	mov    0x9074(%rip),%rdx        # 131d8 <fwp_gc+0x1058>
    a164:	48 c1 e2 10          	shl    $0x10,%rdx
    a168:	48 39 d1             	cmp    %rdx,%rcx
    a16b:	73 76                	jae    a1e3 <f49+0x2a3>
    a16d:	48 8b 15 84 90 00 00 	mov    0x9084(%rip),%rdx        # 131f8 <fwp_gc+0x1078>
    a174:	48 89 ce             	mov    %rcx,%rsi
    a177:	48 c1 ee 10          	shr    $0x10,%rsi
    a17b:	48 69 f6 28 12 00 00 	imul   $0x1228,%rsi,%rsi
    a182:	0f b6 3c 32          	movzbl (%rdx,%rsi,1),%edi
    a186:	48 81 e1 ff ff 00 00 	and    $0xffff,%rcx
    a18d:	75 1d                	jne    a1ac <f49+0x26c>
    a18f:	40 80 ff 02          	cmp    $0x2,%dil
    a193:	75 17                	jne    a1ac <f49+0x26c>
    a195:	4c 8d 34 32          	lea    (%rdx,%rsi,1),%r14
    a199:	49 81 c6 28 02 00 00 	add    $0x228,%r14
    a1a0:	41 80 3e ff          	cmpb   $0xff,(%r14)
    a1a4:	74 2d                	je     a1d3 <f49+0x293>
    a1a6:	41 c6 06 01          	movb   $0x1,(%r14)
    a1aa:	eb 37                	jmp    a1e3 <f49+0x2a3>
    a1ac:	40 80 ff 01          	cmp    $0x1,%dil
    a1b0:	75 31                	jne    a1e3 <f49+0x2a3>
    a1b2:	48 8d 3c 32          	lea    (%rdx,%rsi,1),%rdi
    a1b6:	8b 54 32 20          	mov    0x20(%rdx,%rsi,1),%edx
    a1ba:	48 0f af ca          	imul   %rdx,%rcx
    a1be:	48 c1 e9 20          	shr    $0x20,%rcx
    a1c2:	4c 8d 34 39          	lea    (%rcx,%rdi,1),%r14
    a1c6:	49 81 c6 28 02 00 00 	add    $0x228,%r14
    a1cd:	41 80 3e ff          	cmpb   $0xff,(%r14)
    a1d1:	75 d3                	jne    a1a6 <f49+0x266>
    a1d3:	4c 89 f7             	mov    %r14,%rdi
    a1d6:	49 89 c7             	mov    %rax,%r15
    a1d9:	e8 72 c0 ff ff       	call   6250 <fwp_rc_forget_slot>
    a1de:	4c 89 f8             	mov    %r15,%rax
    a1e1:	eb c3                	jmp    a1a6 <f49+0x266>
    a1e3:	48 89 44 24 10       	mov    %rax,0x10(%rsp)
    a1e8:	48 8d 54 24 10       	lea    0x10(%rsp),%rdx
    a1ed:	31 ff                	xor    %edi,%edi
    a1ef:	be 01 00 00 00       	mov    $0x1,%esi
    a1f4:	e8 27 fb ff ff       	call   9d20 <fwp_data>
    a1f9:	49 89 c6             	mov    %rax,%r14
    a1fc:	48 2b 05 ad 8f 00 00 	sub    0x8fad(%rip),%rax        # 131b0 <fwp_gc+0x1030>
    a203:	48 8b 0d ce 8f 00 00 	mov    0x8fce(%rip),%rcx        # 131d8 <fwp_gc+0x1058>
    a20a:	48 c1 e1 10          	shl    $0x10,%rcx
    a20e:	48 39 c8             	cmp    %rcx,%rax
    a211:	73 6f                	jae    a282 <f49+0x342>
    a213:	48 8b 0d de 8f 00 00 	mov    0x8fde(%rip),%rcx        # 131f8 <fwp_gc+0x1078>
    a21a:	48 89 c2             	mov    %rax,%rdx
    a21d:	48 c1 ea 10          	shr    $0x10,%rdx
    a221:	48 69 d2 28 12 00 00 	imul   $0x1228,%rdx,%rdx
    a228:	0f b6 34 11          	movzbl (%rcx,%rdx,1),%esi
    a22c:	48 25 ff ff 00 00    	and    $0xffff,%rax
    a232:	75 1d                	jne    a251 <f49+0x311>
    a234:	40 80 fe 02          	cmp    $0x2,%sil
    a238:	75 17                	jne    a251 <f49+0x311>
    a23a:	4c 8d 3c 11          	lea    (%rcx,%rdx,1),%r15
    a23e:	49 81 c7 28 02 00 00 	add    $0x228,%r15
    a245:	41 80 3f ff          	cmpb   $0xff,(%r15)
    a249:	74 2d                	je     a278 <f49+0x338>
    a24b:	41 c6 07 01          	movb   $0x1,(%r15)
    a24f:	eb 31                	jmp    a282 <f49+0x342>
    a251:	40 80 fe 01          	cmp    $0x1,%sil
    a255:	75 2b                	jne    a282 <f49+0x342>
    a257:	48 8d 34 11          	lea    (%rcx,%rdx,1),%rsi
    a25b:	8b 4c 11 20          	mov    0x20(%rcx,%rdx,1),%ecx
    a25f:	48 0f af c1          	imul   %rcx,%rax
    a263:	48 c1 e8 20          	shr    $0x20,%rax
    a267:	4c 8d 3c 30          	lea    (%rax,%rsi,1),%r15
    a26b:	49 81 c7 28 02 00 00 	add    $0x228,%r15
    a272:	41 80 3f ff          	cmpb   $0xff,(%r15)
    a276:	75 d3                	jne    a24b <f49+0x30b>
    a278:	4c 89 ff             	mov    %r15,%rdi
    a27b:	e8 d0 bf ff ff       	call   6250 <fwp_rc_forget_slot>
    a280:	eb c9                	jmp    a24b <f49+0x30b>
    a282:	48 89 df             	mov    %rbx,%rdi
    a285:	e8 36 00 00 00       	call   a2c0 <fwp_drop6>
    a28a:	4c 89 f0             	mov    %r14,%rax
    a28d:	48 83 c4 30          	add    $0x30,%rsp
    a291:	5b                   	pop    %rbx
    a292:	41 5e                	pop    %r14
    a294:	41 5f                	pop    %r15
    a296:	c3                   	ret
    a297:	e8 94 d2 ff ff       	call   7530 <fwp_rc_wide_dup>
    a29c:	e9 2e fd ff ff       	jmp    9fcf <f49+0x8f>
    a2a1:	49 89 fe             	mov    %rdi,%r14
    a2a4:	48 89 c7             	mov    %rax,%rdi
    a2a7:	e8 84 d2 ff ff       	call   7530 <fwp_rc_wide_dup>
    a2ac:	4c 89 f7             	mov    %r14,%rdi
    a2af:	e9 6b fe ff ff       	jmp    a11f <f49+0x1df>
    a2b4:	66 66 66 2e 0f 1f 84 	data16 data16 cs nopw 0x0(%rax,%rax,1)
    a2bb:	00 00 00 00 00 

000000000000a2c0 <fwp_drop6>:
    a2c0:	48 89 f8             	mov    %rdi,%rax
    a2c3:	48 2b 05 e6 8e 00 00 	sub    0x8ee6(%rip),%rax        # 131b0 <fwp_gc+0x1030>
    a2ca:	48 8b 0d 07 8f 00 00 	mov    0x8f07(%rip),%rcx        # 131d8 <fwp_gc+0x1058>
    a2d1:	48 c1 e1 10          	shl    $0x10,%rcx
    a2d5:	48 39 c8             	cmp    %rcx,%rax
    a2d8:	0f 83 83 00 00 00    	jae    a361 <fwp_drop6+0xa1>
    a2de:	48 8b 0d 13 8f 00 00 	mov    0x8f13(%rip),%rcx        # 131f8 <fwp_gc+0x1078>
    a2e5:	48 89 c2             	mov    %rax,%rdx
    a2e8:	48 c1 ea 10          	shr    $0x10,%rdx
    a2ec:	48 69 d2 28 12 00 00 	imul   $0x1228,%rdx,%rdx
    a2f3:	0f b6 34 11          	movzbl (%rcx,%rdx,1),%esi
    a2f7:	48 25 ff ff 00 00    	and    $0xffff,%rax
    a2fd:	75 12                	jne    a311 <fwp_drop6+0x51>
    a2ff:	40 80 fe 02          	cmp    $0x2,%sil
    a303:	75 0c                	jne    a311 <fwp_drop6+0x51>
    a305:	48 8d 04 11          	lea    (%rcx,%rdx,1),%rax
    a309:	48 05 28 02 00 00    	add    $0x228,%rax
    a30f:	eb 1f                	jmp    a330 <fwp_drop6+0x70>
    a311:	40 80 fe 01          	cmp    $0x1,%sil
    a315:	75 4a                	jne    a361 <fwp_drop6+0xa1>
    a317:	48 8d 34 11          	lea    (%rcx,%rdx,1),%rsi
    a31b:	8b 4c 11 20          	mov    0x20(%rcx,%rdx,1),%ecx
    a31f:	48 0f af c1          	imul   %rcx,%rax
    a323:	48 c1 e8 20          	shr    $0x20,%rax
    a327:	48 01 f0             	add    %rsi,%rax
    a32a:	48 05 28 02 00 00    	add    $0x228,%rax
    a330:	0f b6 08             	movzbl (%rax),%ecx
    a333:	85 c9                	test   %ecx,%ecx
    a335:	74 2a                	je     a361 <fwp_drop6+0xa1>
    a337:	83 f9 01             	cmp    $0x1,%ecx
    a33a:	75 19                	jne    a355 <fwp_drop6+0x95>
    a33c:	53                   	push   %rbx
    a33d:	48 8b 47 10          	mov    0x10(%rdi),%rax
    a341:	48 89 fb             	mov    %rdi,%rbx
    a344:	48 89 c7             	mov    %rax,%rdi
    a347:	e8 24 00 00 00       	call   a370 <fwp_drop1>
    a34c:	48 89 df             	mov    %rbx,%rdi
    a34f:	5b                   	pop    %rbx
    a350:	e9 eb 04 00 00       	jmp    a840 <fwp_rc_free_obj>
    a355:	81 f9 ff 00 00 00    	cmp    $0xff,%ecx
    a35b:	74 05                	je     a362 <fwp_drop6+0xa2>
    a35d:	fe c9                	dec    %cl
    a35f:	88 08                	mov    %cl,(%rax)
    a361:	c3                   	ret
    a362:	48 89 c7             	mov    %rax,%rdi
    a365:	e9 f6 01 00 00       	jmp    a560 <fwp_rc_wide_drop>
    a36a:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)

000000000000a370 <fwp_drop1>:
    a370:	53                   	push   %rbx
    a371:	48 89 f8             	mov    %rdi,%rax
    a374:	48 2b 05 35 8e 00 00 	sub    0x8e35(%rip),%rax        # 131b0 <fwp_gc+0x1030>
    a37b:	48 8b 0d 56 8e 00 00 	mov    0x8e56(%rip),%rcx        # 131d8 <fwp_gc+0x1058>
    a382:	48 c1 e1 10          	shl    $0x10,%rcx
    a386:	48 39 c8             	cmp    %rcx,%rax
    a389:	0f 83 9c 00 00 00    	jae    a42b <fwp_drop1+0xbb>
    a38f:	48 8b 0d 62 8e 00 00 	mov    0x8e62(%rip),%rcx        # 131f8 <fwp_gc+0x1078>
    a396:	48 89 c2             	mov    %rax,%rdx
    a399:	48 c1 ea 10          	shr    $0x10,%rdx
    a39d:	48 69 d2 28 12 00 00 	imul   $0x1228,%rdx,%rdx
    a3a4:	0f b6 34 11          	movzbl (%rcx,%rdx,1),%esi
    a3a8:	48 25 ff ff 00 00    	and    $0xffff,%rax
    a3ae:	75 20                	jne    a3d0 <fwp_drop1+0x60>
    a3b0:	40 80 fe 02          	cmp    $0x2,%sil
    a3b4:	75 1a                	jne    a3d0 <fwp_drop1+0x60>
    a3b6:	48 8d 04 11          	lea    (%rcx,%rdx,1),%rax
    a3ba:	48 05 28 02 00 00    	add    $0x228,%rax
    a3c0:	eb 2d                	jmp    a3ef <fwp_drop1+0x7f>
    a3c2:	66 66 66 66 66 2e 0f 	data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    a3c9:	1f 84 00 00 00 00 00 
    a3d0:	40 80 fe 01          	cmp    $0x1,%sil
    a3d4:	75 55                	jne    a42b <fwp_drop1+0xbb>
    a3d6:	48 8d 34 11          	lea    (%rcx,%rdx,1),%rsi
    a3da:	8b 4c 11 20          	mov    0x20(%rcx,%rdx,1),%ecx
    a3de:	48 0f af c1          	imul   %rcx,%rax
    a3e2:	48 c1 e8 20          	shr    $0x20,%rax
    a3e6:	48 01 f0             	add    %rsi,%rax
    a3e9:	48 05 28 02 00 00    	add    $0x228,%rax
    a3ef:	0f b6 08             	movzbl (%rax),%ecx
    a3f2:	85 c9                	test   %ecx,%ecx
    a3f4:	74 35                	je     a42b <fwp_drop1+0xbb>
    a3f6:	83 f9 01             	cmp    $0x1,%ecx
    a3f9:	75 32                	jne    a42d <fwp_drop1+0xbd>
    a3fb:	48 83 3f 00          	cmpq   $0x0,(%rdi)
    a3ff:	79 3a                	jns    a43b <fwp_drop1+0xcb>
    a401:	48 8b 5f 08          	mov    0x8(%rdi),%rbx
    a405:	e8 46 00 00 00       	call   a450 <fwp_rc_free_arr>
    a40a:	48 89 d8             	mov    %rbx,%rax
    a40d:	48 2b 05 9c 8d 00 00 	sub    0x8d9c(%rip),%rax        # 131b0 <fwp_gc+0x1030>
    a414:	48 8b 0d bd 8d 00 00 	mov    0x8dbd(%rip),%rcx        # 131d8 <fwp_gc+0x1058>
    a41b:	48 c1 e1 10          	shl    $0x10,%rcx
    a41f:	48 89 df             	mov    %rbx,%rdi
    a422:	48 39 c8             	cmp    %rcx,%rax
    a425:	0f 82 64 ff ff ff    	jb     a38f <fwp_drop1+0x1f>
    a42b:	5b                   	pop    %rbx
    a42c:	c3                   	ret
    a42d:	81 f9 ff 00 00 00    	cmp    $0xff,%ecx
    a433:	74 09                	je     a43e <fwp_drop1+0xce>
    a435:	fe c9                	dec    %cl
    a437:	88 08                	mov    %cl,(%rax)
    a439:	5b                   	pop    %rbx
    a43a:	c3                   	ret
    a43b:	5b                   	pop    %rbx
    a43c:	eb 12                	jmp    a450 <fwp_rc_free_arr>
    a43e:	48 89 c7             	mov    %rax,%rdi
    a441:	5b                   	pop    %rbx
    a442:	e9 19 01 00 00       	jmp    a560 <fwp_rc_wide_drop>
    a447:	66 0f 1f 84 00 00 00 	nopw   0x0(%rax,%rax,1)
    a44e:	00 00 

000000000000a450 <fwp_rc_free_arr>:
    a450:	48 89 f8             	mov    %rdi,%rax
    a453:	48 2b 05 56 8d 00 00 	sub    0x8d56(%rip),%rax        # 131b0 <fwp_gc+0x1030>
    a45a:	48 8b 0d 77 8d 00 00 	mov    0x8d77(%rip),%rcx        # 131d8 <fwp_gc+0x1058>
    a461:	48 c1 e1 10          	shl    $0x10,%rcx
    a465:	48 39 c8             	cmp    %rcx,%rax
    a468:	0f 83 e9 00 00 00    	jae    a557 <fwp_rc_free_arr+0x107>
    a46e:	53                   	push   %rbx
    a46f:	48 8b 0d 82 8d 00 00 	mov    0x8d82(%rip),%rcx        # 131f8 <fwp_gc+0x1078>
    a476:	48 89 c2             	mov    %rax,%rdx
    a479:	48 c1 ea 10          	shr    $0x10,%rdx
    a47d:	48 69 d2 28 12 00 00 	imul   $0x1228,%rdx,%rdx
    a484:	0f b6 34 11          	movzbl (%rcx,%rdx,1),%esi
    a488:	48 25 ff ff 00 00    	and    $0xffff,%rax
    a48e:	75 1a                	jne    a4aa <fwp_rc_free_arr+0x5a>
    a490:	40 80 fe 02          	cmp    $0x2,%sil
    a494:	75 14                	jne    a4aa <fwp_rc_free_arr+0x5a>
    a496:	48 8d 04 11          	lea    (%rcx,%rdx,1),%rax
    a49a:	48 05 28 02 00 00    	add    $0x228,%rax
    a4a0:	80 38 01             	cmpb   $0x1,(%rax)
    a4a3:	74 31                	je     a4d6 <fwp_rc_free_arr+0x86>
    a4a5:	e9 ac 00 00 00       	jmp    a556 <fwp_rc_free_arr+0x106>
    a4aa:	40 80 fe 01          	cmp    $0x1,%sil
    a4ae:	0f 85 a2 00 00 00    	jne    a556 <fwp_rc_free_arr+0x106>
    a4b4:	48 8d 34 11          	lea    (%rcx,%rdx,1),%rsi
    a4b8:	8b 4c 11 20          	mov    0x20(%rcx,%rdx,1),%ecx
    a4bc:	48 0f af c1          	imul   %rcx,%rax
    a4c0:	48 c1 e8 20          	shr    $0x20,%rax
    a4c4:	48 01 f0             	add    %rsi,%rax
    a4c7:	48 05 28 02 00 00    	add    $0x228,%rax
    a4cd:	80 38 01             	cmpb   $0x1,(%rax)
    a4d0:	0f 85 80 00 00 00    	jne    a556 <fwp_rc_free_arr+0x106>
    a4d6:	8b 0d c4 96 00 00    	mov    0x96c4(%rip),%ecx        # 13ba0 <fwp_reuse_verify>
    a4dc:	85 c9                	test   %ecx,%ecx
    a4de:	78 0d                	js     a4ed <fwp_rc_free_arr+0x9d>
    a4e0:	85 c9                	test   %ecx,%ecx
    a4e2:	74 47                	je     a52b <fwp_rc_free_arr+0xdb>
    a4e4:	48 c7 07 00 00 00 00 	movq   $0x0,(%rdi)
    a4eb:	eb 69                	jmp    a556 <fwp_rc_free_arr+0x106>
    a4ed:	48 89 fb             	mov    %rdi,%rbx
    a4f0:	48 8d 3d f2 4f 00 00 	lea    0x4ff2(%rip),%rdi        # f4e9 <fwp_segv.msg+0x2a9>
    a4f7:	e8 34 7b ff ff       	call   2030 <getenv@plt>
    a4fc:	31 c9                	xor    %ecx,%ecx
    a4fe:	48 85 c0             	test   %rax,%rax
    a501:	74 1b                	je     a51e <fwp_rc_free_arr+0xce>
    a503:	80 38 00             	cmpb   $0x0,(%rax)
    a506:	74 16                	je     a51e <fwp_rc_free_arr+0xce>
    a508:	48 8d 35 53 51 00 00 	lea    0x5153(%rip),%rsi        # f662 <fwp_segv.msg+0x422>
    a50f:	48 89 c7             	mov    %rax,%rdi
    a512:	e8 69 7c ff ff       	call   2180 <strcmp@plt>
    a517:	31 c9                	xor    %ecx,%ecx
    a519:	85 c0                	test   %eax,%eax
    a51b:	0f 95 c1             	setne  %cl
    a51e:	89 0d 7c 96 00 00    	mov    %ecx,0x967c(%rip)        # 13ba0 <fwp_reuse_verify>
    a524:	48 89 df             	mov    %rbx,%rdi
    a527:	85 c9                	test   %ecx,%ecx
    a529:	75 b9                	jne    a4e4 <fwp_rc_free_arr+0x94>
    a52b:	48 8b 1d 4e 7c 00 00 	mov    0x7c4e(%rip),%rbx        # 12180 <fwp_gc>
    a532:	e8 b9 00 00 00       	call   a5f0 <fwp_mem_free>
    a537:	48 8b 05 42 7c 00 00 	mov    0x7c42(%rip),%rax        # 12180 <fwp_gc>
    a53e:	48 29 d8             	sub    %rbx,%rax
    a541:	f2 48 0f 2a c0       	cvtsi2sd %rax,%xmm0
    a546:	f2 0f 58 05 3a 8e 00 	addsd  0x8e3a(%rip),%xmm0        # 13388 <fwp_gc+0x1208>
    a54d:	00 
    a54e:	f2 0f 11 05 32 8e 00 	movsd  %xmm0,0x8e32(%rip)        # 13388 <fwp_gc+0x1208>
    a555:	00 
    a556:	5b                   	pop    %rbx
    a557:	c3                   	ret
    a558:	0f 1f 84 00 00 00 00 	nopl   0x0(%rax,%rax,1)
    a55f:	00 

000000000000a560 <fwp_rc_wide_drop>:
    a560:	53                   	push   %rbx
    a561:	48 89 f8             	mov    %rdi,%rax
    a564:	48 c1 e8 11          	shr    $0x11,%rax
    a568:	31 f8                	xor    %edi,%eax
    a56a:	89 c1                	mov    %eax,%ecx
    a56c:	c1 e9 09             	shr    $0x9,%ecx
    a56f:	31 c1                	xor    %eax,%ecx
    a571:	0f b6 c1             	movzbl %cl,%eax
    a574:	48 8d 0d 05 7c 00 00 	lea    0x7c05(%rip),%rcx        # 12180 <fwp_gc>
    a57b:	48 8b 84 c1 18 12 00 	mov    0x1218(%rcx,%rax,8),%rax
    a582:	00 
    a583:	48 85 c0             	test   %rax,%rax
    a586:	74 16                	je     a59e <fwp_rc_wide_drop+0x3e>
    a588:	0f 1f 84 00 00 00 00 	nopl   0x0(%rax,%rax,1)
    a58f:	00 
    a590:	48 39 38             	cmp    %rdi,(%rax)
    a593:	74 37                	je     a5cc <fwp_rc_wide_drop+0x6c>
    a595:	48 8b 40 10          	mov    0x10(%rax),%rax
    a599:	48 85 c0             	test   %rax,%rax
    a59c:	75 f2                	jne    a590 <fwp_rc_wide_drop+0x30>
    a59e:	e8 7d bc ff ff       	call   6220 <fwp_flush>
    a5a3:	48 8b 05 36 7a 00 00 	mov    0x7a36(%rip),%rax        # 11fe0 <stderr@GLIBC_2.2.5>
    a5aa:	48 8b 38             	mov    (%rax),%rdi
    a5ad:	48 8d 35 79 4e 00 00 	lea    0x4e79(%rip),%rsi        # f42d <fwp_segv.msg+0x1ed>
    a5b4:	48 8d 15 81 4e 00 00 	lea    0x4e81(%rip),%rdx        # f43c <fwp_segv.msg+0x1fc>
    a5bb:	31 c0                	xor    %eax,%eax
    a5bd:	e8 ee 7b ff ff       	call   21b0 <fprintf@plt>
    a5c2:	bf 65 00 00 00       	mov    $0x65,%edi
    a5c7:	e8 c4 7c ff ff       	call   2290 <exit@plt>
    a5cc:	48 8b 48 08          	mov    0x8(%rax),%rcx
    a5d0:	48 ff c9             	dec    %rcx
    a5d3:	48 89 48 08          	mov    %rcx,0x8(%rax)
    a5d7:	48 81 f9 fe 00 00 00 	cmp    $0xfe,%rcx
    a5de:	75 0b                	jne    a5eb <fwp_rc_wide_drop+0x8b>
    a5e0:	48 89 fb             	mov    %rdi,%rbx
    a5e3:	e8 68 bc ff ff       	call   6250 <fwp_rc_forget_slot>
    a5e8:	c6 03 fe             	movb   $0xfe,(%rbx)
    a5eb:	5b                   	pop    %rbx
    a5ec:	c3                   	ret
    a5ed:	0f 1f 00             	nopl   (%rax)

000000000000a5f0 <fwp_mem_free>:
    a5f0:	48 85 ff             	test   %rdi,%rdi
    a5f3:	0f 84 17 02 00 00    	je     a810 <fwp_mem_free+0x220>
    a5f9:	48 8b 05 b0 8b 00 00 	mov    0x8bb0(%rip),%rax        # 131b0 <fwp_gc+0x1030>
    a600:	48 89 f9             	mov    %rdi,%rcx
    a603:	48 29 c1             	sub    %rax,%rcx
    a606:	48 8b 15 cb 8b 00 00 	mov    0x8bcb(%rip),%rdx        # 131d8 <fwp_gc+0x1058>
    a60d:	48 c1 e2 10          	shl    $0x10,%rdx
    a611:	48 39 d1             	cmp    %rdx,%rcx
    a614:	0f 83 f6 01 00 00    	jae    a810 <fwp_mem_free+0x220>
    a61a:	41 57                	push   %r15
    a61c:	41 56                	push   %r14
    a61e:	41 55                	push   %r13
    a620:	41 54                	push   %r12
    a622:	53                   	push   %rbx
    a623:	4c 8b 25 ce 8b 00 00 	mov    0x8bce(%rip),%r12        # 131f8 <fwp_gc+0x1078>
    a62a:	4d 85 e4             	test   %r12,%r12
    a62d:	0f 84 d4 01 00 00    	je     a807 <fwp_mem_free+0x217>
    a633:	49 89 cf             	mov    %rcx,%r15
    a636:	49 c1 ef 10          	shr    $0x10,%r15
    a63a:	4d 69 f7 28 12 00 00 	imul   $0x1228,%r15,%r14
    a641:	43 0f b6 14 34       	movzbl (%r12,%r14,1),%edx
    a646:	83 fa 02             	cmp    $0x2,%edx
    a649:	0f 84 b9 00 00 00    	je     a708 <fwp_mem_free+0x118>
    a64f:	83 fa 01             	cmp    $0x1,%edx
    a652:	0f 85 af 01 00 00    	jne    a807 <fwp_mem_free+0x217>
    a658:	47 0f b6 4c 34 01    	movzbl 0x1(%r12,%r14,1),%r9d
    a65e:	47 0f b6 44 34 02    	movzbl 0x2(%r12,%r14,1),%r8d
    a664:	43 8b 74 34 08       	mov    0x8(%r12,%r14,1),%esi
    a669:	0f b7 c7             	movzwl %di,%eax
    a66c:	31 d2                	xor    %edx,%edx
    a66e:	f7 f6                	div    %esi
    a670:	48 c7 c2 fe ff ff ff 	mov    $0xfffffffffffffffe,%rdx
    a677:	89 c1                	mov    %eax,%ecx
    a679:	48 d3 c2             	rol    %cl,%rdx
    a67c:	4b 8d 0c 34          	lea    (%r12,%r14,1),%rcx
    a680:	41 89 c2             	mov    %eax,%r10d
    a683:	41 c1 ea 03          	shr    $0x3,%r10d
    a687:	41 81 e2 f8 1f 00 00 	and    $0x1ff8,%r10d
    a68e:	49 21 54 0a 28       	and    %rdx,0x28(%r10,%rcx,1)
    a693:	49 69 d1 c0 03 00 00 	imul   $0x3c0,%r9,%rdx
    a69a:	4c 8d 3d df 7a 00 00 	lea    0x7adf(%rip),%r15        # 12180 <fwp_gc>
    a6a1:	49 01 d7             	add    %rdx,%r15
    a6a4:	4f 8d 2c 40          	lea    (%r8,%r8,2),%r13
    a6a8:	4d 01 e6             	add    %r12,%r14
    a6ab:	49 83 c6 08          	add    $0x8,%r14
    a6af:	48 8d 1c 08          	lea    (%rax,%rcx,1),%rbx
    a6b3:	48 81 c3 28 02 00 00 	add    $0x228,%rbx
    a6ba:	80 bc 08 28 02 00 00 	cmpb   $0xff,0x228(%rax,%rcx,1)
    a6c1:	ff 
    a6c2:	0f 84 49 01 00 00    	je     a811 <fwp_mem_free+0x221>
    a6c8:	4f 8d 3c ef          	lea    (%r15,%r13,8),%r15
    a6cc:	49 83 c7 08          	add    $0x8,%r15
    a6d0:	c6 03 00             	movb   $0x0,(%rbx)
    a6d3:	83 3d aa 8a 00 00 00 	cmpl   $0x0,0x8aaa(%rip)        # 13184 <fwp_gc+0x1004>
    a6da:	74 12                	je     a6ee <fwp_mem_free+0xfe>
    a6dc:	89 f2                	mov    %esi,%edx
    a6de:	48 89 fb             	mov    %rdi,%rbx
    a6e1:	31 f6                	xor    %esi,%esi
    a6e3:	e8 48 7a ff ff       	call   2130 <memset@plt>
    a6e8:	48 89 df             	mov    %rbx,%rdi
    a6eb:	41 8b 36             	mov    (%r14),%esi
    a6ee:	49 8b 07             	mov    (%r15),%rax
    a6f1:	48 f7 d0             	not    %rax
    a6f4:	48 89 07             	mov    %rax,(%rdi)
    a6f7:	49 89 3f             	mov    %rdi,(%r15)
    a6fa:	89 f0                	mov    %esi,%eax
    a6fc:	48 01 05 7d 7a 00 00 	add    %rax,0x7a7d(%rip)        # 12180 <fwp_gc>
    a703:	e9 ff 00 00 00       	jmp    a807 <fwp_mem_free+0x217>
    a708:	48 81 e1 00 00 ff ff 	and    $0xffffffffffff0000,%rcx
    a70f:	48 01 c8             	add    %rcx,%rax
    a712:	48 39 f8             	cmp    %rdi,%rax
    a715:	0f 85 ec 00 00 00    	jne    a807 <fwp_mem_free+0x217>
    a71b:	4b 8b 44 34 18       	mov    0x18(%r12,%r14,1),%rax
    a720:	48 01 05 59 7a 00 00 	add    %rax,0x7a59(%rip)        # 12180 <fwp_gc>
    a727:	43 c6 44 34 03 00    	movb   $0x0,0x3(%r12,%r14,1)
    a72d:	4b 8d 1c 34          	lea    (%r12,%r14,1),%rbx
    a731:	48 81 c3 28 02 00 00 	add    $0x228,%rbx
    a738:	43 80 bc 34 28 02 00 	cmpb   $0xff,0x228(%r12,%r14,1)
    a73f:	00 ff 
    a741:	0f 84 e0 00 00 00    	je     a827 <fwp_mem_free+0x237>
    a747:	c6 03 00             	movb   $0x0,(%rbx)
    a74a:	43 8b 44 34 10       	mov    0x10(%r12,%r14,1),%eax
    a74f:	48 85 c0             	test   %rax,%rax
    a752:	0f 84 88 00 00 00    	je     a7e0 <fwp_mem_free+0x1f0>
    a758:	48 8b 0d 99 8a 00 00 	mov    0x8a99(%rip),%rcx        # 131f8 <fwp_gc+0x1078>
    a75f:	89 c2                	mov    %eax,%edx
    a761:	83 e2 03             	and    $0x3,%edx
    a764:	83 f8 04             	cmp    $0x4,%eax
    a767:	73 04                	jae    a76d <fwp_mem_free+0x17d>
    a769:	31 f6                	xor    %esi,%esi
    a76b:	eb 3b                	jmp    a7a8 <fwp_mem_free+0x1b8>
    a76d:	4a 8d 3c 31          	lea    (%rcx,%r14,1),%rdi
    a771:	41 89 c0             	mov    %eax,%r8d
    a774:	41 83 e0 fc          	and    $0xfffffffc,%r8d
    a778:	31 f6                	xor    %esi,%esi
    a77a:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)
    a780:	c6 07 00             	movb   $0x0,(%rdi)
    a783:	c6 87 28 12 00 00 00 	movb   $0x0,0x1228(%rdi)
    a78a:	c6 87 50 24 00 00 00 	movb   $0x0,0x2450(%rdi)
    a791:	c6 87 78 36 00 00 00 	movb   $0x0,0x3678(%rdi)
    a798:	48 83 c6 04          	add    $0x4,%rsi
    a79c:	48 81 c7 a0 48 00 00 	add    $0x48a0,%rdi
    a7a3:	49 39 f0             	cmp    %rsi,%r8
    a7a6:	75 d8                	jne    a780 <fwp_mem_free+0x190>
    a7a8:	48 85 d2             	test   %rdx,%rdx
    a7ab:	74 33                	je     a7e0 <fwp_mem_free+0x1f0>
    a7ad:	48 69 f6 28 12 00 00 	imul   $0x1228,%rsi,%rsi
    a7b4:	4c 01 f6             	add    %r14,%rsi
    a7b7:	48 01 f1             	add    %rsi,%rcx
    a7ba:	48 69 d2 28 12 00 00 	imul   $0x1228,%rdx,%rdx
    a7c1:	31 f6                	xor    %esi,%esi
    a7c3:	66 66 66 66 2e 0f 1f 	data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    a7ca:	84 00 00 00 00 00 
    a7d0:	c6 04 31 00          	movb   $0x0,(%rcx,%rsi,1)
    a7d4:	48 81 c6 28 12 00 00 	add    $0x1228,%rsi
    a7db:	48 39 f2             	cmp    %rsi,%rdx
    a7de:	75 f0                	jne    a7d0 <fwp_mem_free+0x1e0>
    a7e0:	48 01 05 79 8b 00 00 	add    %rax,0x8b79(%rip)        # 13360 <fwp_gc+0x11e0>
    a7e7:	4c 3b 3d 02 8a 00 00 	cmp    0x8a02(%rip),%r15        # 131f0 <fwp_gc+0x1070>
    a7ee:	73 07                	jae    a7f7 <fwp_mem_free+0x207>
    a7f0:	4c 89 3d f9 89 00 00 	mov    %r15,0x89f9(%rip)        # 131f0 <fwp_gc+0x1070>
    a7f7:	4c 3b 3d ea 89 00 00 	cmp    0x89ea(%rip),%r15        # 131e8 <fwp_gc+0x1068>
    a7fe:	73 07                	jae    a807 <fwp_mem_free+0x217>
    a800:	4c 89 3d e1 89 00 00 	mov    %r15,0x89e1(%rip)        # 131e8 <fwp_gc+0x1068>
    a807:	5b                   	pop    %rbx
    a808:	41 5c                	pop    %r12
    a80a:	41 5d                	pop    %r13
    a80c:	41 5e                	pop    %r14
    a80e:	41 5f                	pop    %r15
    a810:	c3                   	ret
    a811:	49 89 fc             	mov    %rdi,%r12
    a814:	48 89 df             	mov    %rbx,%rdi
    a817:	e8 34 ba ff ff       	call   6250 <fwp_rc_forget_slot>
    a81c:	4c 89 e7             	mov    %r12,%rdi
    a81f:	41 8b 36             	mov    (%r14),%esi
    a822:	e9 a1 fe ff ff       	jmp    a6c8 <fwp_mem_free+0xd8>
    a827:	48 89 df             	mov    %rbx,%rdi
    a82a:	e8 21 ba ff ff       	call   6250 <fwp_rc_forget_slot>
    a82f:	e9 13 ff ff ff       	jmp    a747 <fwp_mem_free+0x157>
    a834:	66 66 66 2e 0f 1f 84 	data16 data16 cs nopw 0x0(%rax,%rax,1)
    a83b:	00 00 00 00 00 

000000000000a840 <fwp_rc_free_obj>:
    a840:	48 89 f8             	mov    %rdi,%rax
    a843:	48 2b 05 66 89 00 00 	sub    0x8966(%rip),%rax        # 131b0 <fwp_gc+0x1030>
    a84a:	48 8b 0d 87 89 00 00 	mov    0x8987(%rip),%rcx        # 131d8 <fwp_gc+0x1058>
    a851:	48 c1 e1 10          	shl    $0x10,%rcx
    a855:	48 39 c8             	cmp    %rcx,%rax
    a858:	0f 83 b8 01 00 00    	jae    aa16 <fwp_rc_free_obj+0x1d6>
    a85e:	55                   	push   %rbp
    a85f:	41 57                	push   %r15
    a861:	41 56                	push   %r14
    a863:	53                   	push   %rbx
    a864:	50                   	push   %rax
    a865:	48 8b 1d 8c 89 00 00 	mov    0x898c(%rip),%rbx        # 131f8 <fwp_gc+0x1078>
    a86c:	48 89 c1             	mov    %rax,%rcx
    a86f:	48 c1 e9 10          	shr    $0x10,%rcx
    a873:	4c 69 f1 28 12 00 00 	imul   $0x1228,%rcx,%r14
    a87a:	42 0f b6 2c 33       	movzbl (%rbx,%r14,1),%ebp
    a87f:	48 25 ff ff 00 00    	and    $0xffff,%rax
    a885:	75 1a                	jne    a8a1 <fwp_rc_free_obj+0x61>
    a887:	40 80 fd 02          	cmp    $0x2,%bpl
    a88b:	75 14                	jne    a8a1 <fwp_rc_free_obj+0x61>
    a88d:	4a 8d 04 33          	lea    (%rbx,%r14,1),%rax
    a891:	48 05 28 02 00 00    	add    $0x228,%rax
    a897:	80 38 01             	cmpb   $0x1,(%rax)
    a89a:	74 32                	je     a8ce <fwp_rc_free_obj+0x8e>
    a89c:	e9 6b 01 00 00       	jmp    aa0c <fwp_rc_free_obj+0x1cc>
    a8a1:	40 80 fd 01          	cmp    $0x1,%bpl
    a8a5:	0f 85 61 01 00 00    	jne    aa0c <fwp_rc_free_obj+0x1cc>
    a8ab:	4a 8d 0c 33          	lea    (%rbx,%r14,1),%rcx
    a8af:	42 8b 54 33 20       	mov    0x20(%rbx,%r14,1),%edx
    a8b4:	48 0f af c2          	imul   %rdx,%rax
    a8b8:	48 c1 e8 20          	shr    $0x20,%rax
    a8bc:	48 01 c8             	add    %rcx,%rax
    a8bf:	48 05 28 02 00 00    	add    $0x228,%rax
    a8c5:	80 38 01             	cmpb   $0x1,(%rax)
    a8c8:	0f 85 3e 01 00 00    	jne    aa0c <fwp_rc_free_obj+0x1cc>
    a8ce:	8b 0d cc 92 00 00    	mov    0x92cc(%rip),%ecx        # 13ba0 <fwp_reuse_verify>
    a8d4:	85 c9                	test   %ecx,%ecx
    a8d6:	0f 88 c3 00 00 00    	js     a99f <fwp_rc_free_obj+0x15f>
    a8dc:	85 c9                	test   %ecx,%ecx
    a8de:	0f 84 fd 00 00 00    	je     a9e1 <fwp_rc_free_obj+0x1a1>
    a8e4:	42 80 7c 33 01 01    	cmpb   $0x1,0x1(%rbx,%r14,1)
    a8ea:	75 0d                	jne    a8f9 <fwp_rc_free_obj+0xb9>
    a8ec:	40 80 fd 02          	cmp    $0x2,%bpl
    a8f0:	75 22                	jne    a914 <fwp_rc_free_obj+0xd4>
    a8f2:	4a 8b 54 33 18       	mov    0x18(%rbx,%r14,1),%rdx
    a8f7:	eb 20                	jmp    a919 <fwp_rc_free_obj+0xd9>
    a8f9:	c7 07 ad de 00 00    	movl   $0xdead,(%rdi)
    a8ff:	8b 47 04             	mov    0x4(%rdi),%eax
    a902:	48 85 c0             	test   %rax,%rax
    a905:	0f 84 01 01 00 00    	je     aa0c <fwp_rc_free_obj+0x1cc>
    a90b:	83 f8 04             	cmp    $0x4,%eax
    a90e:	73 26                	jae    a936 <fwp_rc_free_obj+0xf6>
    a910:	31 c9                	xor    %ecx,%ecx
    a912:	eb 6a                	jmp    a97e <fwp_rc_free_obj+0x13e>
    a914:	42 8b 54 33 08       	mov    0x8(%rbx,%r14,1),%edx
    a919:	48 89 fb             	mov    %rdi,%rbx
    a91c:	be dd 00 00 00       	mov    $0xdd,%esi
    a921:	e8 0a 78 ff ff       	call   2130 <memset@plt>
    a926:	48 c7 03 00 00 00 00 	movq   $0x0,(%rbx)
    a92d:	c6 43 08 00          	movb   $0x0,0x8(%rbx)
    a931:	e9 d6 00 00 00       	jmp    aa0c <fwp_rc_free_obj+0x1cc>
    a936:	89 c1                	mov    %eax,%ecx
    a938:	83 e1 fc             	and    $0xfffffffc,%ecx
    a93b:	48 8d 14 c5 00 00 00 	lea    0x0(,%rax,8),%rdx
    a942:	00 
    a943:	48 83 e2 e0          	and    $0xffffffffffffffe0,%rdx
    a947:	31 f6                	xor    %esi,%esi
    a949:	66 0f 28 05 9f 47 00 	movapd 0x479f(%rip),%xmm0        # f0f0 <_IO_stdin_used+0xf0>
    a950:	00 
    a951:	66 66 66 66 66 66 2e 	data16 data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    a958:	0f 1f 84 00 00 00 00 
    a95f:	00 
    a960:	66 0f 11 44 37 08    	movupd %xmm0,0x8(%rdi,%rsi,1)
    a966:	66 0f 11 44 37 18    	movupd %xmm0,0x18(%rdi,%rsi,1)
    a96c:	48 83 c6 20          	add    $0x20,%rsi
    a970:	48 39 f2             	cmp    %rsi,%rdx
    a973:	75 eb                	jne    a960 <fwp_rc_free_obj+0x120>
    a975:	48 39 c1             	cmp    %rax,%rcx
    a978:	0f 84 8e 00 00 00    	je     aa0c <fwp_rc_free_obj+0x1cc>
    a97e:	48 ba ef be ad de ef 	movabs $0xdeadbeefdeadbeef,%rdx
    a985:	be ad de 
    a988:	0f 1f 84 00 00 00 00 	nopl   0x0(%rax,%rax,1)
    a98f:	00 
    a990:	48 89 54 cf 08       	mov    %rdx,0x8(%rdi,%rcx,8)
    a995:	48 ff c1             	inc    %rcx
    a998:	48 39 c8             	cmp    %rcx,%rax
    a99b:	75 f3                	jne    a990 <fwp_rc_free_obj+0x150>
    a99d:	eb 6d                	jmp    aa0c <fwp_rc_free_obj+0x1cc>
    a99f:	49 89 ff             	mov    %rdi,%r15
    a9a2:	48 8d 3d 40 4b 00 00 	lea    0x4b40(%rip),%rdi        # f4e9 <fwp_segv.msg+0x2a9>
    a9a9:	e8 82 76 ff ff       	call   2030 <getenv@plt>
    a9ae:	31 c9                	xor    %ecx,%ecx
    a9b0:	48 85 c0             	test   %rax,%rax
    a9b3:	74 1b                	je     a9d0 <fwp_rc_free_obj+0x190>
    a9b5:	80 38 00             	cmpb   $0x0,(%rax)
    a9b8:	74 16                	je     a9d0 <fwp_rc_free_obj+0x190>
    a9ba:	48 8d 35 a1 4c 00 00 	lea    0x4ca1(%rip),%rsi        # f662 <fwp_segv.msg+0x422>
    a9c1:	48 89 c7             	mov    %rax,%rdi
    a9c4:	e8 b7 77 ff ff       	call   2180 <strcmp@plt>
    a9c9:	31 c9                	xor    %ecx,%ecx
    a9cb:	85 c0                	test   %eax,%eax
    a9cd:	0f 95 c1             	setne  %cl
    a9d0:	89 0d ca 91 00 00    	mov    %ecx,0x91ca(%rip)        # 13ba0 <fwp_reuse_verify>
    a9d6:	4c 89 ff             	mov    %r15,%rdi
    a9d9:	85 c9                	test   %ecx,%ecx
    a9db:	0f 85 03 ff ff ff    	jne    a8e4 <fwp_rc_free_obj+0xa4>
    a9e1:	48 8b 1d 98 77 00 00 	mov    0x7798(%rip),%rbx        # 12180 <fwp_gc>
    a9e8:	e8 03 fc ff ff       	call   a5f0 <fwp_mem_free>
    a9ed:	48 8b 05 8c 77 00 00 	mov    0x778c(%rip),%rax        # 12180 <fwp_gc>
    a9f4:	48 29 d8             	sub    %rbx,%rax
    a9f7:	f2 48 0f 2a c0       	cvtsi2sd %rax,%xmm0
    a9fc:	f2 0f 58 05 84 89 00 	addsd  0x8984(%rip),%xmm0        # 13388 <fwp_gc+0x1208>
    aa03:	00 
    aa04:	f2 0f 11 05 7c 89 00 	movsd  %xmm0,0x897c(%rip)        # 13388 <fwp_gc+0x1208>
    aa0b:	00 
    aa0c:	48 83 c4 08          	add    $0x8,%rsp
    aa10:	5b                   	pop    %rbx
    aa11:	41 5e                	pop    %r14
    aa13:	41 5f                	pop    %r15
    aa15:	5d                   	pop    %rbp
    aa16:	c3                   	ret
    aa17:	66 0f 1f 84 00 00 00 	nopw   0x0(%rax,%rax,1)
    aa1e:	00 00 

000000000000aa20 <fwp_owned_entry49>:
    aa20:	48 8b 3f             	mov    (%rdi),%rdi
    aa23:	e9 18 f5 ff ff       	jmp    9f40 <f49>
    aa28:	0f 1f 84 00 00 00 00 	nopl   0x0(%rax,%rax,1)
    aa2f:	00 

000000000000aa30 <fwp_caps49>:
    aa30:	53                   	push   %rbx
    aa31:	83 7f 04 00          	cmpl   $0x0,0x4(%rdi)
    aa35:	74 56                	je     aa8d <fwp_caps49+0x5d>
    aa37:	48 89 fb             	mov    %rdi,%rbx
    aa3a:	48 8b 7f 08          	mov    0x8(%rdi),%rdi
    aa3e:	85 f6                	test   %esi,%esi
    aa40:	74 51                	je     aa93 <fwp_caps49+0x63>
    aa42:	48 2b 3d 67 87 00 00 	sub    0x8767(%rip),%rdi        # 131b0 <fwp_gc+0x1030>
    aa49:	48 8b 05 88 87 00 00 	mov    0x8788(%rip),%rax        # 131d8 <fwp_gc+0x1058>
    aa50:	48 c1 e0 10          	shl    $0x10,%rax
    aa54:	48 39 c7             	cmp    %rax,%rdi
    aa57:	73 38                	jae    aa91 <fwp_caps49+0x61>
    aa59:	48 8b 05 98 87 00 00 	mov    0x8798(%rip),%rax        # 131f8 <fwp_gc+0x1078>
    aa60:	48 89 f9             	mov    %rdi,%rcx
    aa63:	48 c1 e9 10          	shr    $0x10,%rcx
    aa67:	48 69 c9 28 12 00 00 	imul   $0x1228,%rcx,%rcx
    aa6e:	0f b6 14 08          	movzbl (%rax,%rcx,1),%edx
    aa72:	48 81 e7 ff ff 00 00 	and    $0xffff,%rdi
    aa79:	75 26                	jne    aaa1 <fwp_caps49+0x71>
    aa7b:	80 fa 02             	cmp    $0x2,%dl
    aa7e:	75 21                	jne    aaa1 <fwp_caps49+0x71>
    aa80:	48 8d 3c 08          	lea    (%rax,%rcx,1),%rdi
    aa84:	48 81 c7 28 02 00 00 	add    $0x228,%rdi
    aa8b:	eb 33                	jmp    aac0 <fwp_caps49+0x90>
    aa8d:	85 f6                	test   %esi,%esi
    aa8f:	74 0a                	je     aa9b <fwp_caps49+0x6b>
    aa91:	5b                   	pop    %rbx
    aa92:	c3                   	ret
    aa93:	e8 28 f8 ff ff       	call   a2c0 <fwp_drop6>
    aa98:	48 89 df             	mov    %rbx,%rdi
    aa9b:	5b                   	pop    %rbx
    aa9c:	e9 9f fd ff ff       	jmp    a840 <fwp_rc_free_obj>
    aaa1:	80 fa 01             	cmp    $0x1,%dl
    aaa4:	75 eb                	jne    aa91 <fwp_caps49+0x61>
    aaa6:	48 8d 14 08          	lea    (%rax,%rcx,1),%rdx
    aaaa:	8b 44 08 20          	mov    0x20(%rax,%rcx,1),%eax
    aaae:	48 0f af f8          	imul   %rax,%rdi
    aab2:	48 c1 ef 20          	shr    $0x20,%rdi
    aab6:	48 01 d7             	add    %rdx,%rdi
    aab9:	48 81 c7 28 02 00 00 	add    $0x228,%rdi
    aac0:	0f b6 07             	movzbl (%rdi),%eax
    aac3:	84 c0                	test   %al,%al
    aac5:	74 ca                	je     aa91 <fwp_caps49+0x61>
    aac7:	3c fe                	cmp    $0xfe,%al
    aac9:	73 06                	jae    aad1 <fwp_caps49+0xa1>
    aacb:	fe c0                	inc    %al
    aacd:	88 07                	mov    %al,(%rdi)
    aacf:	5b                   	pop    %rbx
    aad0:	c3                   	ret
    aad1:	5b                   	pop    %rbx
    aad2:	e9 59 ca ff ff       	jmp    7530 <fwp_rc_wide_dup>
    aad7:	66 0f 1f 84 00 00 00 	nopw   0x0(%rax,%rax,1)
    aade:	00 00 

000000000000aae0 <fwp_args49>:
    aae0:	85 f6                	test   %esi,%esi
    aae2:	0f 85 8a 00 00 00    	jne    ab72 <fwp_args49+0x92>
    aae8:	85 d2                	test   %edx,%edx
    aaea:	0f 84 82 00 00 00    	je     ab72 <fwp_args49+0x92>
    aaf0:	48 8b 07             	mov    (%rdi),%rax
    aaf3:	48 2b 05 b6 86 00 00 	sub    0x86b6(%rip),%rax        # 131b0 <fwp_gc+0x1030>
    aafa:	48 8b 0d d7 86 00 00 	mov    0x86d7(%rip),%rcx        # 131d8 <fwp_gc+0x1058>
    ab01:	48 c1 e1 10          	shl    $0x10,%rcx
    ab05:	48 39 c8             	cmp    %rcx,%rax
    ab08:	73 68                	jae    ab72 <fwp_args49+0x92>
    ab0a:	48 8b 0d e7 86 00 00 	mov    0x86e7(%rip),%rcx        # 131f8 <fwp_gc+0x1078>
    ab11:	48 89 c2             	mov    %rax,%rdx
    ab14:	48 c1 ea 10          	shr    $0x10,%rdx
    ab18:	48 69 d2 28 12 00 00 	imul   $0x1228,%rdx,%rdx
    ab1f:	0f b6 34 11          	movzbl (%rcx,%rdx,1),%esi
    ab23:	48 25 ff ff 00 00    	and    $0xffff,%rax
    ab29:	75 13                	jne    ab3e <fwp_args49+0x5e>
    ab2b:	40 80 fe 02          	cmp    $0x2,%sil
    ab2f:	75 0d                	jne    ab3e <fwp_args49+0x5e>
    ab31:	48 8d 3c 11          	lea    (%rcx,%rdx,1),%rdi
    ab35:	48 81 c7 28 02 00 00 	add    $0x228,%rdi
    ab3c:	eb 21                	jmp    ab5f <fwp_args49+0x7f>
    ab3e:	40 80 fe 01          	cmp    $0x1,%sil
    ab42:	75 2e                	jne    ab72 <fwp_args49+0x92>
    ab44:	48 8d 34 11          	lea    (%rcx,%rdx,1),%rsi
    ab48:	8b 4c 11 20          	mov    0x20(%rcx,%rdx,1),%ecx
    ab4c:	48 0f af c1          	imul   %rcx,%rax
    ab50:	48 c1 e8 20          	shr    $0x20,%rax
    ab54:	48 8d 3c 30          	lea    (%rax,%rsi,1),%rdi
    ab58:	48 81 c7 28 02 00 00 	add    $0x228,%rdi
    ab5f:	0f b6 07             	movzbl (%rdi),%eax
    ab62:	84 c0                	test   %al,%al
    ab64:	74 0c                	je     ab72 <fwp_args49+0x92>
    ab66:	3c fe                	cmp    $0xfe,%al
    ab68:	0f 83 c2 c9 ff ff    	jae    7530 <fwp_rc_wide_dup>
    ab6e:	fe c0                	inc    %al
    ab70:	88 07                	mov    %al,(%rdi)
    ab72:	c3                   	ret
    ab73:	66 66 66 66 2e 0f 1f 	data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    ab7a:	84 00 00 00 00 00 

000000000000ab80 <fwp_arg_drop49>:
    ab80:	85 f6                	test   %esi,%esi
    ab82:	75 0c                	jne    ab90 <fwp_arg_drop49+0x10>
    ab84:	85 d2                	test   %edx,%edx
    ab86:	74 08                	je     ab90 <fwp_arg_drop49+0x10>
    ab88:	48 8b 3f             	mov    (%rdi),%rdi
    ab8b:	e9 30 f7 ff ff       	jmp    a2c0 <fwp_drop6>
    ab90:	c3                   	ret
    ab91:	66 66 66 66 66 66 2e 	data16 data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    ab98:	0f 1f 84 00 00 00 00 
    ab9f:	00 

000000000000aba0 <fwp_p_loop_own>:
    aba0:	55                   	push   %rbp
    aba1:	41 57                	push   %r15
    aba3:	41 56                	push   %r14
    aba5:	41 55                	push   %r13
    aba7:	41 54                	push   %r12
    aba9:	53                   	push   %rbx
    abaa:	48 83 ec 18          	sub    $0x18,%rsp
    abae:	49 89 fe             	mov    %rdi,%r14
    abb1:	48 89 34 24          	mov    %rsi,(%rsp)
    abb5:	48 89 7c 24 08       	mov    %rdi,0x8(%rsp)
    abba:	eb 0c                	jmp    abc8 <fwp_p_loop_own+0x28>
    abbc:	0f 1f 40 00          	nopl   0x0(%rax)
    abc0:	fe c0                	inc    %al
    abc2:	88 07                	mov    %al,(%rdi)
    abc4:	48 89 34 24          	mov    %rsi,(%rsp)
    abc8:	8b 05 22 90 00 00    	mov    0x9022(%rip),%eax        # 13bf0 <fwp_budget>
    abce:	8d 48 ff             	lea    -0x1(%rax),%ecx
    abd1:	89 0d 19 90 00 00    	mov    %ecx,0x9019(%rip)        # 13bf0 <fwp_budget>
    abd7:	83 f8 01             	cmp    $0x1,%eax
    abda:	0f 8e bb 03 00 00    	jle    af9b <fwp_p_loop_own+0x3fb>
    abe0:	48 89 34 24          	mov    %rsi,(%rsp)
    abe4:	4c 8b 25 d5 8f 00 00 	mov    0x8fd5(%rip),%r12        # 13bc0 <fwp_fns>
    abeb:	41 8b 06             	mov    (%r14),%eax
    abee:	48 c1 e0 05          	shl    $0x5,%rax
    abf2:	49 83 7c 04 18 00    	cmpq   $0x0,0x18(%r12,%rax,1)
    abf8:	0f 84 62 01 00 00    	je     ad60 <fwp_p_loop_own+0x1c0>
    abfe:	4d 8d 04 04          	lea    (%r12,%rax,1),%r8
    ac02:	49 83 c0 18          	add    $0x18,%r8
    ac06:	49 01 c4             	add    %rax,%r12
    ac09:	bd 01 00 00 00       	mov    $0x1,%ebp
    ac0e:	31 f6                	xor    %esi,%esi
    ac10:	4c 89 f0             	mov    %r14,%rax
    ac13:	49 89 e7             	mov    %rsp,%r15
    ac16:	41 bd 01 00 00 00    	mov    $0x1,%r13d
    ac1c:	0f 1f 40 00          	nopl   0x0(%rax)
    ac20:	40 f6 c6 01          	test   $0x1,%sil
    ac24:	0f 85 86 00 00 00    	jne    acb0 <fwp_p_loop_own+0x110>
    ac2a:	48 89 c7             	mov    %rax,%rdi
    ac2d:	48 2b 3d 7c 85 00 00 	sub    0x857c(%rip),%rdi        # 131b0 <fwp_gc+0x1030>
    ac34:	48 8b 0d 9d 85 00 00 	mov    0x859d(%rip),%rcx        # 131d8 <fwp_gc+0x1058>
    ac3b:	48 c1 e1 10          	shl    $0x10,%rcx
    ac3f:	48 39 cf             	cmp    %rcx,%rdi
    ac42:	73 6c                	jae    acb0 <fwp_p_loop_own+0x110>
    ac44:	48 8b 0d ad 85 00 00 	mov    0x85ad(%rip),%rcx        # 131f8 <fwp_gc+0x1078>
    ac4b:	48 89 fa             	mov    %rdi,%rdx
    ac4e:	48 c1 ea 10          	shr    $0x10,%rdx
    ac52:	48 69 d2 28 12 00 00 	imul   $0x1228,%rdx,%rdx
    ac59:	0f b6 34 11          	movzbl (%rcx,%rdx,1),%esi
    ac5d:	48 81 e7 ff ff 00 00 	and    $0xffff,%rdi
    ac64:	75 13                	jne    ac79 <fwp_p_loop_own+0xd9>
    ac66:	40 80 fe 02          	cmp    $0x2,%sil
    ac6a:	75 0d                	jne    ac79 <fwp_p_loop_own+0xd9>
    ac6c:	48 8d 3c 11          	lea    (%rcx,%rdx,1),%rdi
    ac70:	48 81 c7 28 02 00 00 	add    $0x228,%rdi
    ac77:	eb 20                	jmp    ac99 <fwp_p_loop_own+0xf9>
    ac79:	40 80 fe 01          	cmp    $0x1,%sil
    ac7d:	75 31                	jne    acb0 <fwp_p_loop_own+0x110>
    ac7f:	48 8d 34 11          	lea    (%rcx,%rdx,1),%rsi
    ac83:	8b 4c 11 20          	mov    0x20(%rcx,%rdx,1),%ecx
    ac87:	48 0f af f9          	imul   %rcx,%rdi
    ac8b:	48 c1 ef 20          	shr    $0x20,%rdi
    ac8f:	48 01 f7             	add    %rsi,%rdi
    ac92:	48 81 c7 28 02 00 00 	add    $0x228,%rdi
    ac99:	0f b6 0f             	movzbl (%rdi),%ecx
    ac9c:	84 c9                	test   %cl,%cl
    ac9e:	74 10                	je     acb0 <fwp_p_loop_own+0x110>
    aca0:	80 f9 fe             	cmp    $0xfe,%cl
    aca3:	0f 83 9f 00 00 00    	jae    ad48 <fwp_p_loop_own+0x1a8>
    aca9:	fe c1                	inc    %cl
    acab:	88 0f                	mov    %cl,(%rdi)
    acad:	0f 1f 00             	nopl   (%rax)
    acb0:	41 8b 1c 24          	mov    (%r12),%ebx
    acb4:	8b 70 04             	mov    0x4(%rax),%esi
    acb7:	29 f3                	sub    %esi,%ebx
    acb9:	39 dd                	cmp    %ebx,%ebp
    acbb:	41 89 dc             	mov    %ebx,%r12d
    acbe:	44 0f 42 e5          	cmovb  %ebp,%r12d
    acc2:	45 89 e6             	mov    %r12d,%r14d
    acc5:	45 39 e5             	cmp    %r12d,%r13d
    acc8:	45 0f 42 f5          	cmovb  %r13d,%r14d
    accc:	73 2d                	jae    acfb <fwp_p_loop_own+0x15b>
    acce:	44 89 e2             	mov    %r12d,%edx
    acd1:	44 29 f2             	sub    %r14d,%edx
    acd4:	4d 8b 00             	mov    (%r8),%r8
    acd7:	44 89 f1             	mov    %r14d,%ecx
    acda:	49 8d 3c cf          	lea    (%r15,%rcx,8),%rdi
    acde:	44 01 f6             	add    %r14d,%esi
    ace1:	4c 89 7c 24 10       	mov    %r15,0x10(%rsp)
    ace6:	41 89 ef             	mov    %ebp,%r15d
    ace9:	48 89 c5             	mov    %rax,%rbp
    acec:	41 ff 50 10          	call   *0x10(%r8)
    acf0:	48 89 e8             	mov    %rbp,%rax
    acf3:	44 89 fd             	mov    %r15d,%ebp
    acf6:	4c 8b 7c 24 10       	mov    0x10(%rsp),%r15
    acfb:	48 89 c7             	mov    %rax,%rdi
    acfe:	44 89 e6             	mov    %r12d,%esi
    ad01:	4c 89 fa             	mov    %r15,%rdx
    ad04:	e8 b7 08 00 00       	call   b5c0 <fwp_apply_owned>
    ad09:	39 dd                	cmp    %ebx,%ebp
    ad0b:	0f 86 bf 00 00 00    	jbe    add0 <fwp_p_loop_own+0x230>
    ad11:	44 89 e1             	mov    %r12d,%ecx
    ad14:	4d 8d 3c cf          	lea    (%r15,%rcx,8),%r15
    ad18:	44 29 e5             	sub    %r12d,%ebp
    ad1b:	45 29 f5             	sub    %r14d,%r13d
    ad1e:	48 8b 0d 9b 8e 00 00 	mov    0x8e9b(%rip),%rcx        # 13bc0 <fwp_fns>
    ad25:	8b 10                	mov    (%rax),%edx
    ad27:	48 c1 e2 05          	shl    $0x5,%rdx
    ad2b:	4c 8d 24 11          	lea    (%rcx,%rdx,1),%r12
    ad2f:	4c 8d 04 11          	lea    (%rcx,%rdx,1),%r8
    ad33:	49 83 c0 18          	add    $0x18,%r8
    ad37:	40 b6 01             	mov    $0x1,%sil
    ad3a:	48 83 7c 11 18 00    	cmpq   $0x0,0x18(%rcx,%rdx,1)
    ad40:	0f 85 da fe ff ff    	jne    ac20 <fwp_p_loop_own+0x80>
    ad46:	eb 23                	jmp    ad6b <fwp_p_loop_own+0x1cb>
    ad48:	48 89 c3             	mov    %rax,%rbx
    ad4b:	4d 89 c6             	mov    %r8,%r14
    ad4e:	e8 dd c7 ff ff       	call   7530 <fwp_rc_wide_dup>
    ad53:	4d 89 f0             	mov    %r14,%r8
    ad56:	48 89 d8             	mov    %rbx,%rax
    ad59:	e9 52 ff ff ff       	jmp    acb0 <fwp_p_loop_own+0x110>
    ad5e:	66 90                	xchg   %ax,%ax
    ad60:	bd 01 00 00 00       	mov    $0x1,%ebp
    ad65:	49 89 e7             	mov    %rsp,%r15
    ad68:	4c 89 f0             	mov    %r14,%rax
    ad6b:	4c 8b 1d 3e 84 00 00 	mov    0x843e(%rip),%r11        # 131b0 <fwp_gc+0x1030>
    ad72:	48 89 c2             	mov    %rax,%rdx
    ad75:	4c 29 da             	sub    %r11,%rdx
    ad78:	48 8b 0d 59 84 00 00 	mov    0x8459(%rip),%rcx        # 131d8 <fwp_gc+0x1058>
    ad7f:	48 c1 e1 10          	shl    $0x10,%rcx
    ad83:	48 39 ca             	cmp    %rcx,%rdx
    ad86:	4c 8b 74 24 08       	mov    0x8(%rsp),%r14
    ad8b:	0f 83 8f 00 00 00    	jae    ae20 <fwp_p_loop_own+0x280>
    ad91:	48 8b 35 60 84 00 00 	mov    0x8460(%rip),%rsi        # 131f8 <fwp_gc+0x1078>
    ad98:	48 89 d7             	mov    %rdx,%rdi
    ad9b:	48 c1 ef 10          	shr    $0x10,%rdi
    ad9f:	48 69 ff 28 12 00 00 	imul   $0x1228,%rdi,%rdi
    ada6:	44 0f b6 04 3e       	movzbl (%rsi,%rdi,1),%r8d
    adab:	48 81 e2 ff ff 00 00 	and    $0xffff,%rdx
    adb2:	75 34                	jne    ade8 <fwp_p_loop_own+0x248>
    adb4:	41 80 f8 02          	cmp    $0x2,%r8b
    adb8:	75 2e                	jne    ade8 <fwp_p_loop_own+0x248>
    adba:	48 8d 14 3e          	lea    (%rsi,%rdi,1),%rdx
    adbe:	48 81 c2 28 02 00 00 	add    $0x228,%rdx
    adc5:	80 3a 00             	cmpb   $0x0,(%rdx)
    adc8:	74 56                	je     ae20 <fwp_p_loop_own+0x280>
    adca:	e9 f3 01 00 00       	jmp    afc2 <fwp_p_loop_own+0x422>
    adcf:	90                   	nop
    add0:	4c 8b 74 24 08       	mov    0x8(%rsp),%r14
    add5:	48 3d ff 0f 00 00    	cmp    $0xfff,%rax
    addb:	0f 86 00 01 00 00    	jbe    aee1 <fwp_p_loop_own+0x341>
    ade1:	8b 08                	mov    (%rax),%ecx
    ade3:	e9 fb 00 00 00       	jmp    aee3 <fwp_p_loop_own+0x343>
    ade8:	41 80 f8 01          	cmp    $0x1,%r8b
    adec:	75 32                	jne    ae20 <fwp_p_loop_own+0x280>
    adee:	4c 8d 04 3e          	lea    (%rsi,%rdi,1),%r8
    adf2:	8b 74 3e 20          	mov    0x20(%rsi,%rdi,1),%esi
    adf6:	48 0f af d6          	imul   %rsi,%rdx
    adfa:	48 c1 ea 20          	shr    $0x20,%rdx
    adfe:	4c 01 c2             	add    %r8,%rdx
    ae01:	48 81 c2 28 02 00 00 	add    $0x228,%rdx
    ae08:	80 3a 00             	cmpb   $0x0,(%rdx)
    ae0b:	0f 85 b1 01 00 00    	jne    afc2 <fwp_p_loop_own+0x422>
    ae11:	66 66 66 66 66 66 2e 	data16 data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    ae18:	0f 1f 84 00 00 00 00 
    ae1f:	00 
    ae20:	85 ed                	test   %ebp,%ebp
    ae22:	0f 84 a0 00 00 00    	je     aec8 <fwp_p_loop_own+0x328>
    ae28:	48 8b 15 c9 83 00 00 	mov    0x83c9(%rip),%rdx        # 131f8 <fwp_gc+0x1078>
    ae2f:	89 ee                	mov    %ebp,%esi
    ae31:	31 ff                	xor    %edi,%edi
    ae33:	eb 2b                	jmp    ae60 <fwp_p_loop_own+0x2c0>
    ae35:	66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
    ae3c:	00 00 00 00 
    ae40:	4e 8d 04 0a          	lea    (%rdx,%r9,1),%r8
    ae44:	49 81 c0 28 02 00 00 	add    $0x228,%r8
    ae4b:	41 80 38 00          	cmpb   $0x0,(%r8)
    ae4f:	74 6f                	je     aec0 <fwp_p_loop_own+0x320>
    ae51:	e9 6c 01 00 00       	jmp    afc2 <fwp_p_loop_own+0x422>
    ae56:	66 2e 0f 1f 84 00 00 	cs nopw 0x0(%rax,%rax,1)
    ae5d:	00 00 00 
    ae60:	4d 8b 04 ff          	mov    (%r15,%rdi,8),%r8
    ae64:	4d 29 d8             	sub    %r11,%r8
    ae67:	49 39 c8             	cmp    %rcx,%r8
    ae6a:	73 54                	jae    aec0 <fwp_p_loop_own+0x320>
    ae6c:	4d 89 c1             	mov    %r8,%r9
    ae6f:	49 c1 e9 10          	shr    $0x10,%r9
    ae73:	4d 69 c9 28 12 00 00 	imul   $0x1228,%r9,%r9
    ae7a:	46 0f b6 14 0a       	movzbl (%rdx,%r9,1),%r10d
    ae7f:	49 81 e0 ff ff 00 00 	and    $0xffff,%r8
    ae86:	75 06                	jne    ae8e <fwp_p_loop_own+0x2ee>
    ae88:	41 80 fa 02          	cmp    $0x2,%r10b
    ae8c:	74 b2                	je     ae40 <fwp_p_loop_own+0x2a0>
    ae8e:	41 80 fa 01          	cmp    $0x1,%r10b
    ae92:	75 2c                	jne    aec0 <fwp_p_loop_own+0x320>
    ae94:	4e 8d 14 0a          	lea    (%rdx,%r9,1),%r10
    ae98:	46 8b 4c 0a 20       	mov    0x20(%rdx,%r9,1),%r9d
    ae9d:	4d 0f af c1          	imul   %r9,%r8
    aea1:	49 c1 e8 20          	shr    $0x20,%r8
    aea5:	4d 01 d0             	add    %r10,%r8
    aea8:	49 81 c0 28 02 00 00 	add    $0x228,%r8
    aeaf:	41 80 38 00          	cmpb   $0x0,(%r8)
    aeb3:	0f 85 09 01 00 00    	jne    afc2 <fwp_p_loop_own+0x422>
    aeb9:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)
    aec0:	48 ff c7             	inc    %rdi
    aec3:	48 39 fe             	cmp    %rdi,%rsi
    aec6:	75 98                	jne    ae60 <fwp_p_loop_own+0x2c0>
    aec8:	48 89 c7             	mov    %rax,%rdi
    aecb:	89 ee                	mov    %ebp,%esi
    aecd:	4c 89 fa             	mov    %r15,%rdx
    aed0:	e8 8b 01 00 00       	call   b060 <fwp_apply>
    aed5:	48 3d ff 0f 00 00    	cmp    $0xfff,%rax
    aedb:	0f 87 00 ff ff ff    	ja     ade1 <fwp_p_loop_own+0x241>
    aee1:	89 c1                	mov    %eax,%ecx
    aee3:	48 8b 70 08          	mov    0x8(%rax),%rsi
    aee7:	85 c9                	test   %ecx,%ecx
    aee9:	0f 85 bc 00 00 00    	jne    afab <fwp_p_loop_own+0x40b>
    aeef:	48 89 f0             	mov    %rsi,%rax
    aef2:	48 2b 05 b7 82 00 00 	sub    0x82b7(%rip),%rax        # 131b0 <fwp_gc+0x1030>
    aef9:	48 8b 0d d8 82 00 00 	mov    0x82d8(%rip),%rcx        # 131d8 <fwp_gc+0x1058>
    af00:	48 c1 e1 10          	shl    $0x10,%rcx
    af04:	48 39 c8             	cmp    %rcx,%rax
    af07:	0f 83 b7 fc ff ff    	jae    abc4 <fwp_p_loop_own+0x24>
    af0d:	48 8b 0d e4 82 00 00 	mov    0x82e4(%rip),%rcx        # 131f8 <fwp_gc+0x1078>
    af14:	48 89 c2             	mov    %rax,%rdx
    af17:	48 c1 ea 10          	shr    $0x10,%rdx
    af1b:	48 69 d2 28 12 00 00 	imul   $0x1228,%rdx,%rdx
    af22:	0f b6 3c 11          	movzbl (%rcx,%rdx,1),%edi
    af26:	48 25 ff ff 00 00    	and    $0xffff,%rax
    af2c:	75 22                	jne    af50 <fwp_p_loop_own+0x3b0>
    af2e:	40 80 ff 02          	cmp    $0x2,%dil
    af32:	75 1c                	jne    af50 <fwp_p_loop_own+0x3b0>
    af34:	48 8d 3c 11          	lea    (%rcx,%rdx,1),%rdi
    af38:	48 81 c7 28 02 00 00 	add    $0x228,%rdi
    af3f:	eb 33                	jmp    af74 <fwp_p_loop_own+0x3d4>
    af41:	66 66 66 66 66 66 2e 	data16 data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    af48:	0f 1f 84 00 00 00 00 
    af4f:	00 
    af50:	40 80 ff 01          	cmp    $0x1,%dil
    af54:	0f 85 6a fc ff ff    	jne    abc4 <fwp_p_loop_own+0x24>
    af5a:	48 8d 3c 11          	lea    (%rcx,%rdx,1),%rdi
    af5e:	8b 4c 11 20          	mov    0x20(%rcx,%rdx,1),%ecx
    af62:	48 0f af c1          	imul   %rcx,%rax
    af66:	48 c1 e8 20          	shr    $0x20,%rax
    af6a:	48 01 c7             	add    %rax,%rdi
    af6d:	48 81 c7 28 02 00 00 	add    $0x228,%rdi
    af74:	0f b6 07             	movzbl (%rdi),%eax
    af77:	84 c0                	test   %al,%al
    af79:	0f 84 45 fc ff ff    	je     abc4 <fwp_p_loop_own+0x24>
    af7f:	3c fe                	cmp    $0xfe,%al
    af81:	0f 82 39 fc ff ff    	jb     abc0 <fwp_p_loop_own+0x20>
    af87:	48 89 f3             	mov    %rsi,%rbx
    af8a:	e8 a1 c5 ff ff       	call   7530 <fwp_rc_wide_dup>
    af8f:	48 89 de             	mov    %rbx,%rsi
    af92:	48 89 1c 24          	mov    %rbx,(%rsp)
    af96:	e9 2d fc ff ff       	jmp    abc8 <fwp_p_loop_own+0x28>
    af9b:	48 89 f3             	mov    %rsi,%rbx
    af9e:	e8 4d 00 00 00       	call   aff0 <fwp_preempt>
    afa3:	48 89 de             	mov    %rbx,%rsi
    afa6:	e9 35 fc ff ff       	jmp    abe0 <fwp_p_loop_own+0x40>
    afab:	48 89 34 24          	mov    %rsi,(%rsp)
    afaf:	48 8b 04 24          	mov    (%rsp),%rax
    afb3:	48 83 c4 18          	add    $0x18,%rsp
    afb7:	5b                   	pop    %rbx
    afb8:	41 5c                	pop    %r12
    afba:	41 5d                	pop    %r13
    afbc:	41 5e                	pop    %r14
    afbe:	41 5f                	pop    %r15
    afc0:	5d                   	pop    %rbp
    afc1:	c3                   	ret
    afc2:	e8 59 b2 ff ff       	call   6220 <fwp_flush>
    afc7:	48 8b 05 12 70 00 00 	mov    0x7012(%rip),%rax        # 11fe0 <stderr@GLIBC_2.2.5>
    afce:	48 8b 38             	mov    (%rax),%rdi
    afd1:	48 8d 35 55 44 00 00 	lea    0x4455(%rip),%rsi        # f42d <fwp_segv.msg+0x1ed>
    afd8:	48 8d 15 21 44 00 00 	lea    0x4421(%rip),%rdx        # f400 <fwp_segv.msg+0x1c0>
    afdf:	31 c0                	xor    %eax,%eax
    afe1:	e8 ca 71 ff ff       	call   21b0 <fprintf@plt>
    afe6:	bf 65 00 00 00       	mov    $0x65,%edi
    afeb:	e8 a0 72 ff ff       	call   2290 <exit@plt>

000000000000aff0 <fwp_preempt>:
    aff0:	8b 0d fe 8b 00 00    	mov    0x8bfe(%rip),%ecx        # 13bf4 <fwp_slice>
    aff6:	85 c9                	test   %ecx,%ecx
    aff8:	74 07                	je     b001 <fwp_preempt+0x11>
    affa:	89 0d f0 8b 00 00    	mov    %ecx,0x8bf0(%rip)        # 13bf0 <fwp_budget>
    b000:	c3                   	ret
    b001:	50                   	push   %rax
    b002:	48 8d 3d a0 46 00 00 	lea    0x46a0(%rip),%rdi        # f6a9 <fwp_segv.msg+0x469>
    b009:	e8 22 70 ff ff       	call   2030 <getenv@plt>
    b00e:	48 89 c7             	mov    %rax,%rdi
    b011:	b8 10 27 00 00       	mov    $0x2710,%eax
    b016:	48 85 ff             	test   %rdi,%rdi
    b019:	74 11                	je     b02c <fwp_preempt+0x3c>
    b01b:	80 3f 00             	cmpb   $0x0,(%rdi)
    b01e:	74 0c                	je     b02c <fwp_preempt+0x3c>
    b020:	31 f6                	xor    %esi,%esi
    b022:	ba 0a 00 00 00       	mov    $0xa,%edx
    b027:	e8 74 71 ff ff       	call   21a0 <strtoll@plt>
    b02c:	48 8d 88 00 00 00 80 	lea    -0x80000000(%rax),%rcx
    b033:	48 81 f9 01 00 00 80 	cmp    $0xffffffff80000001,%rcx
    b03a:	b9 ff ff ff 7f       	mov    $0x7fffffff,%ecx
    b03f:	0f 43 c8             	cmovae %eax,%ecx
    b042:	89 0d ac 8b 00 00    	mov    %ecx,0x8bac(%rip)        # 13bf4 <fwp_slice>
    b048:	48 83 c4 08          	add    $0x8,%rsp
    b04c:	89 0d 9e 8b 00 00    	mov    %ecx,0x8b9e(%rip)        # 13bf0 <fwp_budget>
    b052:	c3                   	ret
    b053:	66 66 66 66 2e 0f 1f 	data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    b05a:	84 00 00 00 00 00 

000000000000b060 <fwp_apply>:
    b060:	55                   	push   %rbp
    b061:	48 89 e5             	mov    %rsp,%rbp
    b064:	41 57                	push   %r15
    b066:	41 56                	push   %r14
    b068:	41 55                	push   %r13
    b06a:	41 54                	push   %r12
    b06c:	53                   	push   %rbx
    b06d:	48 83 ec 18          	sub    $0x18,%rsp
    b071:	48 89 d3             	mov    %rdx,%rbx
    b074:	49 89 ff             	mov    %rdi,%r15
    b077:	eb 23                	jmp    b09c <fwp_apply+0x3c>
    b079:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)
    b080:	4a 8d 1c f3          	lea    (%rbx,%r14,8),%rbx
    b084:	31 c9                	xor    %ecx,%ecx
    b086:	49 89 c7             	mov    %rax,%r15
    b089:	4c 8b 75 c8          	mov    -0x38(%rbp),%r14
    b08d:	48 8b 65 c0          	mov    -0x40(%rbp),%rsp
    b091:	89 d6                	mov    %edx,%esi
    b093:	83 f9 01             	cmp    $0x1,%ecx
    b096:	0f 84 aa 04 00 00    	je     b546 <fwp_apply+0x4e6>
    b09c:	48 8b 05 1d 8b 00 00 	mov    0x8b1d(%rip),%rax        # 13bc0 <fwp_fns>
    b0a3:	41 8b 0f             	mov    (%r15),%ecx
    b0a6:	45 8b 6f 04          	mov    0x4(%r15),%r13d
    b0aa:	48 c1 e1 05          	shl    $0x5,%rcx
    b0ae:	44 8b 24 08          	mov    (%rax,%rcx,1),%r12d
    b0b2:	4d 85 ed             	test   %r13,%r13
    b0b5:	75 39                	jne    b0f0 <fwp_apply+0x90>
    b0b7:	41 8d 54 24 ff       	lea    -0x1(%r12),%edx
    b0bc:	39 f2                	cmp    %esi,%edx
    b0be:	73 30                	jae    b0f0 <fwp_apply+0x90>
    b0c0:	48 89 df             	mov    %rbx,%rdi
    b0c3:	49 89 f7             	mov    %rsi,%r15
    b0c6:	ff 54 08 08          	call   *0x8(%rax,%rcx,1)
    b0ca:	4c 89 fe             	mov    %r15,%rsi
    b0cd:	49 89 c7             	mov    %rax,%r15
    b0d0:	44 39 e6             	cmp    %r12d,%esi
    b0d3:	0f 84 a4 02 00 00    	je     b37d <fwp_apply+0x31d>
    b0d9:	4a 8d 1c e3          	lea    (%rbx,%r12,8),%rbx
    b0dd:	44 29 e6             	sub    %r12d,%esi
    b0e0:	b9 03 00 00 00       	mov    $0x3,%ecx
    b0e5:	83 f9 01             	cmp    $0x1,%ecx
    b0e8:	75 b2                	jne    b09c <fwp_apply+0x3c>
    b0ea:	e9 57 04 00 00       	jmp    b546 <fwp_apply+0x4e6>
    b0ef:	90                   	nop
    b0f0:	4c 89 75 c8          	mov    %r14,-0x38(%rbp)
    b0f4:	46 8d 34 2e          	lea    (%rsi,%r13,1),%r14d
    b0f8:	45 39 e6             	cmp    %r12d,%r14d
    b0fb:	48 89 75 d0          	mov    %rsi,-0x30(%rbp)
    b0ff:	0f 82 1a 02 00 00    	jb     b31f <fwp_apply+0x2bf>
    b105:	48 89 65 c0          	mov    %rsp,-0x40(%rbp)
    b109:	45 89 e3             	mov    %r12d,%r11d
    b10c:	41 83 fc 02          	cmp    $0x2,%r12d
    b110:	ba 01 00 00 00       	mov    $0x1,%edx
    b115:	41 0f 43 d4          	cmovae %r12d,%edx
    b119:	48 8d 14 d5 0f 00 00 	lea    0xf(,%rdx,8),%rdx
    b120:	00 
    b121:	48 83 e2 f0          	and    $0xfffffffffffffff0,%rdx
    b125:	48 89 e7             	mov    %rsp,%rdi
    b128:	48 29 d7             	sub    %rdx,%rdi
    b12b:	48 89 fc             	mov    %rdi,%rsp
    b12e:	4d 85 ed             	test   %r13,%r13
    b131:	0f 84 c9 00 00 00    	je     b200 <fwp_apply+0x1a0>
    b137:	41 83 fd 04          	cmp    $0x4,%r13d
    b13b:	72 10                	jb     b14d <fwp_apply+0xed>
    b13d:	48 89 fa             	mov    %rdi,%rdx
    b140:	4c 29 fa             	sub    %r15,%rdx
    b143:	48 83 c2 f8          	add    $0xfffffffffffffff8,%rdx
    b147:	48 83 fa 20          	cmp    $0x20,%rdx
    b14b:	73 65                	jae    b1b2 <fwp_apply+0x152>
    b14d:	31 d2                	xor    %edx,%edx
    b14f:	4d 89 e8             	mov    %r13,%r8
    b152:	49 89 d2             	mov    %rdx,%r10
    b155:	49 83 e0 03          	and    $0x3,%r8
    b159:	74 16                	je     b171 <fwp_apply+0x111>
    b15b:	49 89 d2             	mov    %rdx,%r10
    b15e:	66 90                	xchg   %ax,%ax
    b160:	4f 8b 4c d7 08       	mov    0x8(%r15,%r10,8),%r9
    b165:	4e 89 0c d7          	mov    %r9,(%rdi,%r10,8)
    b169:	49 ff c2             	inc    %r10
    b16c:	49 ff c8             	dec    %r8
    b16f:	75 ef                	jne    b160 <fwp_apply+0x100>
    b171:	4c 29 ea             	sub    %r13,%rdx
    b174:	48 83 fa fc          	cmp    $0xfffffffffffffffc,%rdx
    b178:	0f 87 82 00 00 00    	ja     b200 <fwp_apply+0x1a0>
    b17e:	66 90                	xchg   %ax,%ax
    b180:	4b 8b 54 d7 08       	mov    0x8(%r15,%r10,8),%rdx
    b185:	4a 89 14 d7          	mov    %rdx,(%rdi,%r10,8)
    b189:	4b 8b 54 d7 10       	mov    0x10(%r15,%r10,8),%rdx
    b18e:	4a 89 54 d7 08       	mov    %rdx,0x8(%rdi,%r10,8)
    b193:	4b 8b 54 d7 18       	mov    0x18(%r15,%r10,8),%rdx
    b198:	4a 89 54 d7 10       	mov    %rdx,0x10(%rdi,%r10,8)
    b19d:	4b 8b 54 d7 20       	mov    0x20(%r15,%r10,8),%rdx
    b1a2:	4a 89 54 d7 18       	mov    %rdx,0x18(%rdi,%r10,8)
    b1a7:	49 83 c2 04          	add    $0x4,%r10
    b1ab:	4d 39 d5             	cmp    %r10,%r13
    b1ae:	75 d0                	jne    b180 <fwp_apply+0x120>
    b1b0:	eb 4e                	jmp    b200 <fwp_apply+0x1a0>
    b1b2:	44 89 ea             	mov    %r13d,%edx
    b1b5:	83 e2 fc             	and    $0xfffffffc,%edx
    b1b8:	4e 8d 0c ed 00 00 00 	lea    0x0(,%r13,8),%r9
    b1bf:	00 
    b1c0:	49 83 e1 e0          	and    $0xffffffffffffffe0,%r9
    b1c4:	45 31 c0             	xor    %r8d,%r8d
    b1c7:	66 0f 1f 84 00 00 00 	nopw   0x0(%rax,%rax,1)
    b1ce:	00 00 
    b1d0:	43 0f 10 44 07 08    	movups 0x8(%r15,%r8,1),%xmm0
    b1d6:	43 0f 10 4c 07 18    	movups 0x18(%r15,%r8,1),%xmm1
    b1dc:	42 0f 29 04 07       	movaps %xmm0,(%rdi,%r8,1)
    b1e1:	42 0f 29 4c 07 10    	movaps %xmm1,0x10(%rdi,%r8,1)
    b1e7:	49 83 c0 20          	add    $0x20,%r8
    b1eb:	4d 39 c1             	cmp    %r8,%r9
    b1ee:	75 e0                	jne    b1d0 <fwp_apply+0x170>
    b1f0:	4c 39 ea             	cmp    %r13,%rdx
    b1f3:	0f 85 56 ff ff ff    	jne    b14f <fwp_apply+0xef>
    b1f9:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)
    b200:	45 29 eb             	sub    %r13d,%r11d
    b203:	45 89 de             	mov    %r11d,%r14d
    b206:	45 39 ec             	cmp    %r13d,%r12d
    b209:	0f 84 85 00 00 00    	je     b294 <fwp_apply+0x234>
    b20f:	41 83 fb 0e          	cmp    $0xe,%r11d
    b213:	0f 83 a0 00 00 00    	jae    b2b9 <fwp_apply+0x259>
    b219:	31 d2                	xor    %edx,%edx
    b21b:	4d 89 f0             	mov    %r14,%r8
    b21e:	48 89 d6             	mov    %rdx,%rsi
    b221:	49 83 e0 03          	and    $0x3,%r8
    b225:	74 1d                	je     b244 <fwp_apply+0x1e4>
    b227:	48 89 d6             	mov    %rdx,%rsi
    b22a:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)
    b230:	4c 8b 0c f3          	mov    (%rbx,%rsi,8),%r9
    b234:	46 8d 14 2e          	lea    (%rsi,%r13,1),%r10d
    b238:	4e 89 0c d7          	mov    %r9,(%rdi,%r10,8)
    b23c:	48 ff c6             	inc    %rsi
    b23f:	49 ff c8             	dec    %r8
    b242:	75 ec                	jne    b230 <fwp_apply+0x1d0>
    b244:	4c 29 f2             	sub    %r14,%rdx
    b247:	48 83 fa fc          	cmp    $0xfffffffffffffffc,%rdx
    b24b:	77 47                	ja     b294 <fwp_apply+0x234>
    b24d:	0f 1f 00             	nopl   (%rax)
    b250:	48 8b 14 f3          	mov    (%rbx,%rsi,8),%rdx
    b254:	46 8d 04 2e          	lea    (%rsi,%r13,1),%r8d
    b258:	4a 89 14 c7          	mov    %rdx,(%rdi,%r8,8)
    b25c:	48 8b 54 f3 08       	mov    0x8(%rbx,%rsi,8),%rdx
    b261:	46 8d 04 2e          	lea    (%rsi,%r13,1),%r8d
    b265:	41 ff c0             	inc    %r8d
    b268:	4a 89 14 c7          	mov    %rdx,(%rdi,%r8,8)
    b26c:	48 8b 54 f3 10       	mov    0x10(%rbx,%rsi,8),%rdx
    b271:	45 8d 44 35 02       	lea    0x2(%r13,%rsi,1),%r8d
    b276:	4a 89 14 c7          	mov    %rdx,(%rdi,%r8,8)
    b27a:	48 8b 54 f3 18       	mov    0x18(%rbx,%rsi,8),%rdx
    b27f:	46 8d 04 2e          	lea    (%rsi,%r13,1),%r8d
    b283:	41 83 c0 03          	add    $0x3,%r8d
    b287:	4a 89 14 c7          	mov    %rdx,(%rdi,%r8,8)
    b28b:	48 83 c6 04          	add    $0x4,%rsi
    b28f:	49 39 f6             	cmp    %rsi,%r14
    b292:	75 bc                	jne    b250 <fwp_apply+0x1f0>
    b294:	45 89 dc             	mov    %r11d,%r12d
    b297:	ff 54 08 08          	call   *0x8(%rax,%rcx,1)
    b29b:	b9 01 00 00 00       	mov    $0x1,%ecx
    b2a0:	48 8b 75 d0          	mov    -0x30(%rbp),%rsi
    b2a4:	89 f2                	mov    %esi,%edx
    b2a6:	44 29 e2             	sub    %r12d,%edx
    b2a9:	0f 85 d1 fd ff ff    	jne    b080 <fwp_apply+0x20>
    b2af:	89 f2                	mov    %esi,%edx
    b2b1:	49 89 c6             	mov    %rax,%r14
    b2b4:	e9 d4 fd ff ff       	jmp    b08d <fwp_apply+0x2d>
    b2b9:	49 8d 56 ff          	lea    -0x1(%r14),%rdx
    b2bd:	89 d6                	mov    %edx,%esi
    b2bf:	44 01 ee             	add    %r13d,%esi
    b2c2:	0f 82 51 ff ff ff    	jb     b219 <fwp_apply+0x1b9>
    b2c8:	48 c1 ea 20          	shr    $0x20,%rdx
    b2cc:	ba 00 00 00 00       	mov    $0x0,%edx
    b2d1:	0f 85 44 ff ff ff    	jne    b21b <fwp_apply+0x1bb>
    b2d7:	4a 8d 14 ef          	lea    (%rdi,%r13,8),%rdx
    b2db:	48 29 da             	sub    %rbx,%rdx
    b2de:	48 83 fa 20          	cmp    $0x20,%rdx
    b2e2:	0f 82 31 ff ff ff    	jb     b219 <fwp_apply+0x1b9>
    b2e8:	44 89 f2             	mov    %r14d,%edx
    b2eb:	83 e2 fc             	and    $0xfffffffc,%edx
    b2ee:	31 f6                	xor    %esi,%esi
    b2f0:	0f 10 04 f3          	movups (%rbx,%rsi,8),%xmm0
    b2f4:	0f 10 4c f3 10       	movups 0x10(%rbx,%rsi,8),%xmm1
    b2f9:	46 8d 04 2e          	lea    (%rsi,%r13,1),%r8d
    b2fd:	42 0f 11 04 c7       	movups %xmm0,(%rdi,%r8,8)
    b302:	42 0f 11 4c c7 10    	movups %xmm1,0x10(%rdi,%r8,8)
    b308:	48 83 c6 04          	add    $0x4,%rsi
    b30c:	48 39 f2             	cmp    %rsi,%rdx
    b30f:	75 df                	jne    b2f0 <fwp_apply+0x290>
    b311:	4c 39 f2             	cmp    %r14,%rdx
    b314:	0f 85 01 ff ff ff    	jne    b21b <fwp_apply+0x1bb>
    b31a:	e9 75 ff ff ff       	jmp    b294 <fwp_apply+0x234>
    b31f:	44 89 f0             	mov    %r14d,%eax
    b322:	41 81 fe ff 07 00 00 	cmp    $0x7ff,%r14d
    b329:	77 72                	ja     b39d <fwp_apply+0x33d>
    b32b:	48 8d 14 c5 00 00 00 	lea    0x0(,%rax,8),%rdx
    b332:	00 
    b333:	48 83 c2 17          	add    $0x17,%rdx
    b337:	48 c1 ea 04          	shr    $0x4,%rdx
    b33b:	48 8d 0d 3e 6e 00 00 	lea    0x6e3e(%rip),%rcx        # 12180 <fwp_gc>
    b342:	0f b6 bc 0a e8 0b 00 	movzbl 0xbe8(%rdx,%rcx,1),%edi
    b349:	00 
    b34a:	8b 94 b9 48 0b 00 00 	mov    0xb48(%rcx,%rdi,4),%edx
    b351:	48 29 15 28 6e 00 00 	sub    %rdx,0x6e28(%rip)        # 12180 <fwp_gc>
    b358:	78 43                	js     b39d <fwp_apply+0x33d>
    b35a:	4c 8d 04 7f          	lea    (%rdi,%rdi,2),%r8
    b35e:	4a 8d 3c c1          	lea    (%rcx,%r8,8),%rdi
    b362:	48 81 c7 88 07 00 00 	add    $0x788,%rdi
    b369:	4c 8b 27             	mov    (%rdi),%r12
    b36c:	4d 85 e4             	test   %r12,%r12
    b36f:	74 14                	je     b385 <fwp_apply+0x325>
    b371:	49 8b 04 24          	mov    (%r12),%rax
    b375:	48 f7 d0             	not    %rax
    b378:	48 89 07             	mov    %rax,(%rdi)
    b37b:	eb 48                	jmp    b3c5 <fwp_apply+0x365>
    b37d:	4d 89 fe             	mov    %r15,%r14
    b380:	e9 c1 01 00 00       	jmp    b546 <fwp_apply+0x4e6>
    b385:	4e 8b a4 c1 90 07 00 	mov    0x790(%rcx,%r8,8),%r12
    b38c:	00 
    b38d:	4a 8b bc c1 98 07 00 	mov    0x798(%rcx,%r8,8),%rdi
    b394:	00 
    b395:	4c 29 e7             	sub    %r12,%rdi
    b398:	48 39 d7             	cmp    %rdx,%rdi
    b39b:	73 17                	jae    b3b4 <fwp_apply+0x354>
    b39d:	48 8d 3c c5 08 00 00 	lea    0x8(,%rax,8),%rdi
    b3a4:	00 
    b3a5:	be 02 00 00 00       	mov    $0x2,%esi
    b3aa:	e8 c1 b2 ff ff       	call   6670 <fwp_gc_alloc_slow>
    b3af:	49 89 c4             	mov    %rax,%r12
    b3b2:	eb 1b                	jmp    b3cf <fwp_apply+0x36f>
    b3b4:	4a 8d 04 c1          	lea    (%rcx,%r8,8),%rax
    b3b8:	48 05 90 07 00 00    	add    $0x790,%rax
    b3be:	49 8d 0c 14          	lea    (%r12,%rdx,1),%rcx
    b3c2:	48 89 08             	mov    %rcx,(%rax)
    b3c5:	4c 89 e7             	mov    %r12,%rdi
    b3c8:	31 f6                	xor    %esi,%esi
    b3ca:	e8 61 6d ff ff       	call   2130 <memset@plt>
    b3cf:	41 8b 07             	mov    (%r15),%eax
    b3d2:	41 89 04 24          	mov    %eax,(%r12)
    b3d6:	45 89 74 24 04       	mov    %r14d,0x4(%r12)
    b3db:	4d 85 ed             	test   %r13,%r13
    b3de:	4d 89 e6             	mov    %r12,%r14
    b3e1:	48 8b 7d d0          	mov    -0x30(%rbp),%rdi
    b3e5:	0f 84 c6 00 00 00    	je     b4b1 <fwp_apply+0x451>
    b3eb:	31 c0                	xor    %eax,%eax
    b3ed:	41 83 fd 06          	cmp    $0x6,%r13d
    b3f1:	72 53                	jb     b446 <fwp_apply+0x3e6>
    b3f3:	4c 89 f1             	mov    %r14,%rcx
    b3f6:	4c 29 f9             	sub    %r15,%rcx
    b3f9:	48 83 f9 20          	cmp    $0x20,%rcx
    b3fd:	72 47                	jb     b446 <fwp_apply+0x3e6>
    b3ff:	44 89 e8             	mov    %r13d,%eax
    b402:	83 e0 fc             	and    $0xfffffffc,%eax
    b405:	4a 8d 0c ed 00 00 00 	lea    0x0(,%r13,8),%rcx
    b40c:	00 
    b40d:	48 83 e1 e0          	and    $0xffffffffffffffe0,%rcx
    b411:	31 d2                	xor    %edx,%edx
    b413:	66 66 66 66 2e 0f 1f 	data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    b41a:	84 00 00 00 00 00 
    b420:	41 0f 10 44 17 08    	movups 0x8(%r15,%rdx,1),%xmm0
    b426:	41 0f 10 4c 17 18    	movups 0x18(%r15,%rdx,1),%xmm1
    b42c:	41 0f 11 44 16 08    	movups %xmm0,0x8(%r14,%rdx,1)
    b432:	41 0f 11 4c 16 18    	movups %xmm1,0x18(%r14,%rdx,1)
    b438:	48 83 c2 20          	add    $0x20,%rdx
    b43c:	48 39 d1             	cmp    %rdx,%rcx
    b43f:	75 df                	jne    b420 <fwp_apply+0x3c0>
    b441:	4c 39 e8             	cmp    %r13,%rax
    b444:	74 6b                	je     b4b1 <fwp_apply+0x451>
    b446:	4c 89 ea             	mov    %r13,%rdx
    b449:	48 89 c1             	mov    %rax,%rcx
    b44c:	48 83 e2 03          	and    $0x3,%rdx
    b450:	74 20                	je     b472 <fwp_apply+0x412>
    b452:	48 89 c1             	mov    %rax,%rcx
    b455:	66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
    b45c:	00 00 00 00 
    b460:	49 8b 74 cf 08       	mov    0x8(%r15,%rcx,8),%rsi
    b465:	49 89 74 ce 08       	mov    %rsi,0x8(%r14,%rcx,8)
    b46a:	48 ff c1             	inc    %rcx
    b46d:	48 ff ca             	dec    %rdx
    b470:	75 ee                	jne    b460 <fwp_apply+0x400>
    b472:	4c 29 e8             	sub    %r13,%rax
    b475:	48 83 f8 fc          	cmp    $0xfffffffffffffffc,%rax
    b479:	77 36                	ja     b4b1 <fwp_apply+0x451>
    b47b:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)
    b480:	49 8b 44 cf 08       	mov    0x8(%r15,%rcx,8),%rax
    b485:	49 89 44 ce 08       	mov    %rax,0x8(%r14,%rcx,8)
    b48a:	49 8b 44 cf 10       	mov    0x10(%r15,%rcx,8),%rax
    b48f:	49 89 44 ce 10       	mov    %rax,0x10(%r14,%rcx,8)
    b494:	49 8b 44 cf 18       	mov    0x18(%r15,%rcx,8),%rax
    b499:	49 89 44 ce 18       	mov    %rax,0x18(%r14,%rcx,8)
    b49e:	49 8b 44 cf 20       	mov    0x20(%r15,%rcx,8),%rax
    b4a3:	49 89 44 ce 20       	mov    %rax,0x20(%r14,%rcx,8)
    b4a8:	48 83 c1 04          	add    $0x4,%rcx
    b4ac:	49 39 cd             	cmp    %rcx,%r13
    b4af:	75 cf                	jne    b480 <fwp_apply+0x420>
    b4b1:	85 ff                	test   %edi,%edi
    b4b3:	0f 84 8d 00 00 00    	je     b546 <fwp_apply+0x4e6>
    b4b9:	89 f8                	mov    %edi,%eax
    b4bb:	83 ff 14             	cmp    $0x14,%edi
    b4be:	0f 83 94 00 00 00    	jae    b558 <fwp_apply+0x4f8>
    b4c4:	31 c9                	xor    %ecx,%ecx
    b4c6:	48 89 c6             	mov    %rax,%rsi
    b4c9:	48 89 ca             	mov    %rcx,%rdx
    b4cc:	48 83 e6 03          	and    $0x3,%rsi
    b4d0:	74 23                	je     b4f5 <fwp_apply+0x495>
    b4d2:	48 89 ca             	mov    %rcx,%rdx
    b4d5:	66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
    b4dc:	00 00 00 00 
    b4e0:	48 8b 3c d3          	mov    (%rbx,%rdx,8),%rdi
    b4e4:	46 8d 04 2a          	lea    (%rdx,%r13,1),%r8d
    b4e8:	4b 89 7c c6 08       	mov    %rdi,0x8(%r14,%r8,8)
    b4ed:	48 ff c2             	inc    %rdx
    b4f0:	48 ff ce             	dec    %rsi
    b4f3:	75 eb                	jne    b4e0 <fwp_apply+0x480>
    b4f5:	48 29 c1             	sub    %rax,%rcx
    b4f8:	48 83 f9 fc          	cmp    $0xfffffffffffffffc,%rcx
    b4fc:	77 48                	ja     b546 <fwp_apply+0x4e6>
    b4fe:	66 90                	xchg   %ax,%ax
    b500:	48 8b 0c d3          	mov    (%rbx,%rdx,8),%rcx
    b504:	42 8d 34 2a          	lea    (%rdx,%r13,1),%esi
    b508:	49 89 4c f6 08       	mov    %rcx,0x8(%r14,%rsi,8)
    b50d:	48 8b 4c d3 08       	mov    0x8(%rbx,%rdx,8),%rcx
    b512:	42 8d 34 2a          	lea    (%rdx,%r13,1),%esi
    b516:	ff c6                	inc    %esi
    b518:	49 89 4c f6 08       	mov    %rcx,0x8(%r14,%rsi,8)
    b51d:	48 8b 4c d3 10       	mov    0x10(%rbx,%rdx,8),%rcx
    b522:	41 8d 74 15 02       	lea    0x2(%r13,%rdx,1),%esi
    b527:	49 89 4c f6 08       	mov    %rcx,0x8(%r14,%rsi,8)
    b52c:	48 8b 4c d3 18       	mov    0x18(%rbx,%rdx,8),%rcx
    b531:	42 8d 34 2a          	lea    (%rdx,%r13,1),%esi
    b535:	83 c6 03             	add    $0x3,%esi
    b538:	49 89 4c f6 08       	mov    %rcx,0x8(%r14,%rsi,8)
    b53d:	48 83 c2 04          	add    $0x4,%rdx
    b541:	48 39 d0             	cmp    %rdx,%rax
    b544:	75 ba                	jne    b500 <fwp_apply+0x4a0>
    b546:	4c 89 f0             	mov    %r14,%rax
    b549:	48 8d 65 d8          	lea    -0x28(%rbp),%rsp
    b54d:	5b                   	pop    %rbx
    b54e:	41 5c                	pop    %r12
    b550:	41 5d                	pop    %r13
    b552:	41 5e                	pop    %r14
    b554:	41 5f                	pop    %r15
    b556:	5d                   	pop    %rbp
    b557:	c3                   	ret
    b558:	48 8d 50 ff          	lea    -0x1(%rax),%rdx
    b55c:	31 c9                	xor    %ecx,%ecx
    b55e:	89 d6                	mov    %edx,%esi
    b560:	44 01 ee             	add    %r13d,%esi
    b563:	0f 82 5d ff ff ff    	jb     b4c6 <fwp_apply+0x466>
    b569:	48 c1 ea 20          	shr    $0x20,%rdx
    b56d:	0f 85 53 ff ff ff    	jne    b4c6 <fwp_apply+0x466>
    b573:	4b 8d 0c ee          	lea    (%r14,%r13,8),%rcx
    b577:	48 29 d9             	sub    %rbx,%rcx
    b57a:	48 83 c1 08          	add    $0x8,%rcx
    b57e:	48 83 f9 20          	cmp    $0x20,%rcx
    b582:	0f 82 3c ff ff ff    	jb     b4c4 <fwp_apply+0x464>
    b588:	89 c1                	mov    %eax,%ecx
    b58a:	83 e1 fc             	and    $0xfffffffc,%ecx
    b58d:	31 d2                	xor    %edx,%edx
    b58f:	90                   	nop
    b590:	0f 10 04 d3          	movups (%rbx,%rdx,8),%xmm0
    b594:	0f 10 4c d3 10       	movups 0x10(%rbx,%rdx,8),%xmm1
    b599:	42 8d 34 2a          	lea    (%rdx,%r13,1),%esi
    b59d:	41 0f 11 44 f6 08    	movups %xmm0,0x8(%r14,%rsi,8)
    b5a3:	41 0f 11 4c f6 18    	movups %xmm1,0x18(%r14,%rsi,8)
    b5a9:	48 83 c2 04          	add    $0x4,%rdx
    b5ad:	48 39 d1             	cmp    %rdx,%rcx
    b5b0:	75 de                	jne    b590 <fwp_apply+0x530>
    b5b2:	48 39 c1             	cmp    %rax,%rcx
    b5b5:	0f 85 0b ff ff ff    	jne    b4c6 <fwp_apply+0x466>
    b5bb:	eb 89                	jmp    b546 <fwp_apply+0x4e6>
    b5bd:	0f 1f 00             	nopl   (%rax)

000000000000b5c0 <fwp_apply_owned>:
    b5c0:	55                   	push   %rbp
    b5c1:	48 89 e5             	mov    %rsp,%rbp
    b5c4:	41 57                	push   %r15
    b5c6:	41 56                	push   %r14
    b5c8:	41 55                	push   %r13
    b5ca:	41 54                	push   %r12
    b5cc:	53                   	push   %rbx
    b5cd:	48 83 ec 28          	sub    $0x28,%rsp
    b5d1:	48 89 d3             	mov    %rdx,%rbx
    b5d4:	41 89 f5             	mov    %esi,%r13d
    b5d7:	48 8b 05 e2 85 00 00 	mov    0x85e2(%rip),%rax        # 13bc0 <fwp_fns>
    b5de:	8b 17                	mov    (%rdi),%edx
    b5e0:	48 89 d6             	mov    %rdx,%rsi
    b5e3:	48 c1 e6 05          	shl    $0x5,%rsi
    b5e7:	48 8b 4c 30 18       	mov    0x18(%rax,%rsi,1),%rcx
    b5ec:	48 85 c9             	test   %rcx,%rcx
    b5ef:	0f 84 ca 02 00 00    	je     b8bf <fwp_apply_owned+0x2ff>
    b5f5:	4c 8d 04 30          	lea    (%rax,%rsi,1),%r8
    b5f9:	49 83 c0 18          	add    $0x18,%r8
    b5fd:	49 89 fc             	mov    %rdi,%r12
    b600:	48 89 7d c0          	mov    %rdi,-0x40(%rbp)
    b604:	48 c1 e2 05          	shl    $0x5,%rdx
    b608:	8b 04 10             	mov    (%rax,%rdx,1),%eax
    b60b:	45 8b 74 24 04       	mov    0x4(%r12),%r14d
    b610:	47 8d 3c 2e          	lea    (%r14,%r13,1),%r15d
    b614:	41 39 c7             	cmp    %eax,%r15d
    b617:	0f 82 10 03 00 00    	jb     b92d <fwp_apply_owned+0x36d>
    b61d:	41 89 c7             	mov    %eax,%r15d
    b620:	45 29 f7             	sub    %r14d,%r15d
    b623:	45 89 fa             	mov    %r15d,%r10d
    b626:	85 c0                	test   %eax,%eax
    b628:	4c 89 55 d0          	mov    %r10,-0x30(%rbp)
    b62c:	74 22                	je     b650 <fwp_apply_owned+0x90>
    b62e:	45 85 f6             	test   %r14d,%r14d
    b631:	75 1d                	jne    b650 <fwp_apply_owned+0x90>
    b633:	48 89 df             	mov    %rbx,%rdi
    b636:	ff 11                	call   *(%rcx)
    b638:	49 89 c4             	mov    %rax,%r12
    b63b:	4c 8b 75 c0          	mov    -0x40(%rbp),%r14
    b63f:	e9 35 02 00 00       	jmp    b879 <fwp_apply_owned+0x2b9>
    b644:	66 66 66 2e 0f 1f 84 	data16 data16 cs nopw 0x0(%rax,%rax,1)
    b64b:	00 00 00 00 00 
    b650:	4c 89 6d c8          	mov    %r13,-0x38(%rbp)
    b654:	48 89 65 b8          	mov    %rsp,-0x48(%rbp)
    b658:	85 c0                	test   %eax,%eax
    b65a:	b9 01 00 00 00       	mov    $0x1,%ecx
    b65f:	0f 45 c8             	cmovne %eax,%ecx
    b662:	48 8d 0c cd 0f 00 00 	lea    0xf(,%rcx,8),%rcx
    b669:	00 
    b66a:	48 83 e1 f0          	and    $0xfffffffffffffff0,%rcx
    b66e:	49 89 e5             	mov    %rsp,%r13
    b671:	49 29 cd             	sub    %rcx,%r13
    b674:	4c 89 ec             	mov    %r13,%rsp
    b677:	4d 85 f6             	test   %r14,%r14
    b67a:	0f 84 d0 00 00 00    	je     b750 <fwp_apply_owned+0x190>
    b680:	41 83 fe 04          	cmp    $0x4,%r14d
    b684:	72 10                	jb     b696 <fwp_apply_owned+0xd6>
    b686:	4c 89 e9             	mov    %r13,%rcx
    b689:	4c 29 e1             	sub    %r12,%rcx
    b68c:	48 83 c1 f8          	add    $0xfffffffffffffff8,%rcx
    b690:	48 83 f9 20          	cmp    $0x20,%rcx
    b694:	73 6d                	jae    b703 <fwp_apply_owned+0x143>
    b696:	31 c9                	xor    %ecx,%ecx
    b698:	4c 89 f6             	mov    %r14,%rsi
    b69b:	48 89 ca             	mov    %rcx,%rdx
    b69e:	48 83 e6 03          	and    $0x3,%rsi
    b6a2:	74 1e                	je     b6c2 <fwp_apply_owned+0x102>
    b6a4:	48 89 ca             	mov    %rcx,%rdx
    b6a7:	66 0f 1f 84 00 00 00 	nopw   0x0(%rax,%rax,1)
    b6ae:	00 00 
    b6b0:	49 8b 7c d4 08       	mov    0x8(%r12,%rdx,8),%rdi
    b6b5:	49 89 7c d5 00       	mov    %rdi,0x0(%r13,%rdx,8)
    b6ba:	48 ff c2             	inc    %rdx
    b6bd:	48 ff ce             	dec    %rsi
    b6c0:	75 ee                	jne    b6b0 <fwp_apply_owned+0xf0>
    b6c2:	4c 29 f1             	sub    %r14,%rcx
    b6c5:	48 83 f9 fc          	cmp    $0xfffffffffffffffc,%rcx
    b6c9:	0f 87 81 00 00 00    	ja     b750 <fwp_apply_owned+0x190>
    b6cf:	90                   	nop
    b6d0:	49 8b 4c d4 08       	mov    0x8(%r12,%rdx,8),%rcx
    b6d5:	49 89 4c d5 00       	mov    %rcx,0x0(%r13,%rdx,8)
    b6da:	49 8b 4c d4 10       	mov    0x10(%r12,%rdx,8),%rcx
    b6df:	49 89 4c d5 08       	mov    %rcx,0x8(%r13,%rdx,8)
    b6e4:	49 8b 4c d4 18       	mov    0x18(%r12,%rdx,8),%rcx
    b6e9:	49 89 4c d5 10       	mov    %rcx,0x10(%r13,%rdx,8)
    b6ee:	49 8b 4c d4 20       	mov    0x20(%r12,%rdx,8),%rcx
    b6f3:	49 89 4c d5 18       	mov    %rcx,0x18(%r13,%rdx,8)
    b6f8:	48 83 c2 04          	add    $0x4,%rdx
    b6fc:	49 39 d6             	cmp    %rdx,%r14
    b6ff:	75 cf                	jne    b6d0 <fwp_apply_owned+0x110>
    b701:	eb 4d                	jmp    b750 <fwp_apply_owned+0x190>
    b703:	44 89 f1             	mov    %r14d,%ecx
    b706:	83 e1 fc             	and    $0xfffffffc,%ecx
    b709:	4a 8d 14 f5 00 00 00 	lea    0x0(,%r14,8),%rdx
    b710:	00 
    b711:	48 83 e2 e0          	and    $0xffffffffffffffe0,%rdx
    b715:	31 f6                	xor    %esi,%esi
    b717:	66 0f 1f 84 00 00 00 	nopw   0x0(%rax,%rax,1)
    b71e:	00 00 
    b720:	41 0f 10 44 34 08    	movups 0x8(%r12,%rsi,1),%xmm0
    b726:	41 0f 10 4c 34 18    	movups 0x18(%r12,%rsi,1),%xmm1
    b72c:	41 0f 29 44 35 00    	movaps %xmm0,0x0(%r13,%rsi,1)
    b732:	41 0f 29 4c 35 10    	movaps %xmm1,0x10(%r13,%rsi,1)
    b738:	48 83 c6 20          	add    $0x20,%rsi
    b73c:	48 39 f2             	cmp    %rsi,%rdx
    b73f:	75 df                	jne    b720 <fwp_apply_owned+0x160>
    b741:	4c 39 f1             	cmp    %r14,%rcx
    b744:	0f 85 4e ff ff ff    	jne    b698 <fwp_apply_owned+0xd8>
    b74a:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)
    b750:	44 39 f0             	cmp    %r14d,%eax
    b753:	0f 84 f7 00 00 00    	je     b850 <fwp_apply_owned+0x290>
    b759:	41 83 ff 0a          	cmp    $0xa,%r15d
    b75d:	0f 83 95 00 00 00    	jae    b7f8 <fwp_apply_owned+0x238>
    b763:	31 c0                	xor    %eax,%eax
    b765:	4c 89 d2             	mov    %r10,%rdx
    b768:	48 89 c1             	mov    %rax,%rcx
    b76b:	48 83 e2 03          	and    $0x3,%rdx
    b76f:	74 24                	je     b795 <fwp_apply_owned+0x1d5>
    b771:	48 89 c1             	mov    %rax,%rcx
    b774:	66 66 66 2e 0f 1f 84 	data16 data16 cs nopw 0x0(%rax,%rax,1)
    b77b:	00 00 00 00 00 
    b780:	48 8b 34 cb          	mov    (%rbx,%rcx,8),%rsi
    b784:	41 8d 3c 0e          	lea    (%r14,%rcx,1),%edi
    b788:	49 89 74 fd 00       	mov    %rsi,0x0(%r13,%rdi,8)
    b78d:	48 ff c1             	inc    %rcx
    b790:	48 ff ca             	dec    %rdx
    b793:	75 eb                	jne    b780 <fwp_apply_owned+0x1c0>
    b795:	4c 29 d0             	sub    %r10,%rax
    b798:	48 83 f8 fc          	cmp    $0xfffffffffffffffc,%rax
    b79c:	0f 87 ae 00 00 00    	ja     b850 <fwp_apply_owned+0x290>
    b7a2:	66 66 66 66 66 2e 0f 	data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    b7a9:	1f 84 00 00 00 00 00 
    b7b0:	48 8b 04 cb          	mov    (%rbx,%rcx,8),%rax
    b7b4:	41 8d 14 0e          	lea    (%r14,%rcx,1),%edx
    b7b8:	49 89 44 d5 00       	mov    %rax,0x0(%r13,%rdx,8)
    b7bd:	48 8b 44 cb 08       	mov    0x8(%rbx,%rcx,8),%rax
    b7c2:	41 8d 14 0e          	lea    (%r14,%rcx,1),%edx
    b7c6:	ff c2                	inc    %edx
    b7c8:	49 89 44 d5 00       	mov    %rax,0x0(%r13,%rdx,8)
    b7cd:	48 8b 44 cb 10       	mov    0x10(%rbx,%rcx,8),%rax
    b7d2:	41 8d 54 0e 02       	lea    0x2(%r14,%rcx,1),%edx
    b7d7:	49 89 44 d5 00       	mov    %rax,0x0(%r13,%rdx,8)
    b7dc:	48 8b 44 cb 18       	mov    0x18(%rbx,%rcx,8),%rax
    b7e1:	41 8d 14 0e          	lea    (%r14,%rcx,1),%edx
    b7e5:	83 c2 03             	add    $0x3,%edx
    b7e8:	49 89 44 d5 00       	mov    %rax,0x0(%r13,%rdx,8)
    b7ed:	48 83 c1 04          	add    $0x4,%rcx
    b7f1:	49 39 ca             	cmp    %rcx,%r10
    b7f4:	75 ba                	jne    b7b0 <fwp_apply_owned+0x1f0>
    b7f6:	eb 58                	jmp    b850 <fwp_apply_owned+0x290>
    b7f8:	49 8d 42 ff          	lea    -0x1(%r10),%rax
    b7fc:	89 c1                	mov    %eax,%ecx
    b7fe:	44 01 f1             	add    %r14d,%ecx
    b801:	0f 82 5c ff ff ff    	jb     b763 <fwp_apply_owned+0x1a3>
    b807:	48 c1 e8 20          	shr    $0x20,%rax
    b80b:	b8 00 00 00 00       	mov    $0x0,%eax
    b810:	0f 85 4f ff ff ff    	jne    b765 <fwp_apply_owned+0x1a5>
    b816:	44 89 d0             	mov    %r10d,%eax
    b819:	83 e0 fc             	and    $0xfffffffc,%eax
    b81c:	31 c9                	xor    %ecx,%ecx
    b81e:	66 90                	xchg   %ax,%ax
    b820:	0f 10 04 cb          	movups (%rbx,%rcx,8),%xmm0
    b824:	0f 10 4c cb 10       	movups 0x10(%rbx,%rcx,8),%xmm1
    b829:	41 8d 14 0e          	lea    (%r14,%rcx,1),%edx
    b82d:	41 0f 11 44 d5 00    	movups %xmm0,0x0(%r13,%rdx,8)
    b833:	41 0f 11 4c d5 10    	movups %xmm1,0x10(%r13,%rdx,8)
    b839:	48 83 c1 04          	add    $0x4,%rcx
    b83d:	48 39 c8             	cmp    %rcx,%rax
    b840:	75 de                	jne    b820 <fwp_apply_owned+0x260>
    b842:	4c 39 d0             	cmp    %r10,%rax
    b845:	0f 85 1a ff ff ff    	jne    b765 <fwp_apply_owned+0x1a5>
    b84b:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)
    b850:	49 8b 00             	mov    (%r8),%rax
    b853:	4c 8b 75 c0          	mov    -0x40(%rbp),%r14
    b857:	4c 89 f7             	mov    %r14,%rdi
    b85a:	be 01 00 00 00       	mov    $0x1,%esi
    b85f:	4d 89 c4             	mov    %r8,%r12
    b862:	ff 50 08             	call   *0x8(%rax)
    b865:	49 8b 04 24          	mov    (%r12),%rax
    b869:	4c 89 ef             	mov    %r13,%rdi
    b86c:	ff 10                	call   *(%rax)
    b86e:	49 89 c4             	mov    %rax,%r12
    b871:	48 8b 65 b8          	mov    -0x48(%rbp),%rsp
    b875:	4c 8b 6d c8          	mov    -0x38(%rbp),%r13
    b879:	4c 89 f7             	mov    %r14,%rdi
    b87c:	e8 af 05 00 00       	call   be30 <fwp_closure_drop>
    b881:	45 29 fd             	sub    %r15d,%r13d
    b884:	0f 84 89 05 00 00    	je     be13 <fwp_apply_owned+0x853>
    b88a:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
    b88e:	48 8d 1c c3          	lea    (%rbx,%rax,8),%rbx
    b892:	48 8b 05 27 83 00 00 	mov    0x8327(%rip),%rax        # 13bc0 <fwp_fns>
    b899:	41 8b 14 24          	mov    (%r12),%edx
    b89d:	48 89 d1             	mov    %rdx,%rcx
    b8a0:	48 c1 e1 05          	shl    $0x5,%rcx
    b8a4:	4c 8d 04 08          	lea    (%rax,%rcx,1),%r8
    b8a8:	49 83 c0 18          	add    $0x18,%r8
    b8ac:	48 8b 4c 08 18       	mov    0x18(%rax,%rcx,1),%rcx
    b8b1:	4c 89 e7             	mov    %r12,%rdi
    b8b4:	48 85 c9             	test   %rcx,%rcx
    b8b7:	0f 85 43 fd ff ff    	jne    b600 <fwp_apply_owned+0x40>
    b8bd:	eb 03                	jmp    b8c2 <fwp_apply_owned+0x302>
    b8bf:	49 89 fc             	mov    %rdi,%r12
    b8c2:	48 8b 05 e7 78 00 00 	mov    0x78e7(%rip),%rax        # 131b0 <fwp_gc+0x1030>
    b8c9:	4c 89 e2             	mov    %r12,%rdx
    b8cc:	48 29 c2             	sub    %rax,%rdx
    b8cf:	48 8b 0d 02 79 00 00 	mov    0x7902(%rip),%rcx        # 131d8 <fwp_gc+0x1058>
    b8d6:	48 c1 e1 10          	shl    $0x10,%rcx
    b8da:	48 39 ca             	cmp    %rcx,%rdx
    b8dd:	0f 83 12 01 00 00    	jae    b9f5 <fwp_apply_owned+0x435>
    b8e3:	48 8b 35 0e 79 00 00 	mov    0x790e(%rip),%rsi        # 131f8 <fwp_gc+0x1078>
    b8ea:	48 89 d7             	mov    %rdx,%rdi
    b8ed:	48 c1 ef 10          	shr    $0x10,%rdi
    b8f1:	48 69 ff 28 12 00 00 	imul   $0x1228,%rdi,%rdi
    b8f8:	44 0f b6 04 3e       	movzbl (%rsi,%rdi,1),%r8d
    b8fd:	48 81 e2 ff ff 00 00 	and    $0xffff,%rdx
    b904:	0f 85 c2 00 00 00    	jne    b9cc <fwp_apply_owned+0x40c>
    b90a:	41 80 f8 02          	cmp    $0x2,%r8b
    b90e:	0f 85 b8 00 00 00    	jne    b9cc <fwp_apply_owned+0x40c>
    b914:	48 8d 14 3e          	lea    (%rsi,%rdi,1),%rdx
    b918:	48 81 c2 28 02 00 00 	add    $0x228,%rdx
    b91f:	80 3a 00             	cmpb   $0x0,(%rdx)
    b922:	0f 84 cd 00 00 00    	je     b9f5 <fwp_apply_owned+0x435>
    b928:	e9 55 01 00 00       	jmp    ba82 <fwp_apply_owned+0x4c2>
    b92d:	4c 89 45 d0          	mov    %r8,-0x30(%rbp)
    b931:	4c 89 6d c8          	mov    %r13,-0x38(%rbp)
    b935:	44 89 f9             	mov    %r15d,%ecx
    b938:	48 8d 3c cd 08 00 00 	lea    0x8(,%rcx,8),%rdi
    b93f:	00 
    b940:	41 81 ff ff 07 00 00 	cmp    $0x7ff,%r15d
    b947:	0f 87 f0 01 00 00    	ja     bb3d <fwp_apply_owned+0x57d>
    b94d:	48 c1 e1 03          	shl    $0x3,%rcx
    b951:	4c 8d 41 17          	lea    0x17(%rcx),%r8
    b955:	49 c1 e8 04          	shr    $0x4,%r8
    b959:	48 8d 05 20 68 00 00 	lea    0x6820(%rip),%rax        # 12180 <fwp_gc>
    b960:	41 0f b6 b4 00 e8 0b 	movzbl 0xbe8(%r8,%rax,1),%esi
    b967:	00 00 
    b969:	8b 94 b0 48 0b 00 00 	mov    0xb48(%rax,%rsi,4),%edx
    b970:	4c 8b 0d 09 68 00 00 	mov    0x6809(%rip),%r9        # 12180 <fwp_gc>
    b977:	4d 89 ca             	mov    %r9,%r10
    b97a:	49 29 d2             	sub    %rdx,%r10
    b97d:	4c 89 15 fc 67 00 00 	mov    %r10,0x67fc(%rip)        # 12180 <fwp_gc>
    b984:	0f 88 b3 01 00 00    	js     bb3d <fwp_apply_owned+0x57d>
    b98a:	4c 8d 14 76          	lea    (%rsi,%rsi,2),%r10
    b98e:	4e 8d 1c d0          	lea    (%rax,%r10,8),%r11
    b992:	49 83 c3 08          	add    $0x8,%r11
    b996:	4d 8b 2b             	mov    (%r11),%r13
    b999:	4d 85 ed             	test   %r13,%r13
    b99c:	0f 84 24 01 00 00    	je     bac6 <fwp_apply_owned+0x506>
    b9a2:	49 8b 45 00          	mov    0x0(%r13),%rax
    b9a6:	48 f7 d0             	not    %rax
    b9a9:	49 89 03             	mov    %rax,(%r11)
    b9ac:	48 39 d7             	cmp    %rdx,%rdi
    b9af:	0f 83 ad 01 00 00    	jae    bb62 <fwp_apply_owned+0x5a2>
    b9b5:	4c 01 ef             	add    %r13,%rdi
    b9b8:	48 29 ca             	sub    %rcx,%rdx
    b9bb:	48 83 c2 f7          	add    $0xfffffffffffffff7,%rdx
    b9bf:	48 83 e2 f8          	and    $0xfffffffffffffff8,%rdx
    b9c3:	48 83 c2 08          	add    $0x8,%rdx
    b9c7:	e9 8f 01 00 00       	jmp    bb5b <fwp_apply_owned+0x59b>
    b9cc:	41 80 f8 01          	cmp    $0x1,%r8b
    b9d0:	75 23                	jne    b9f5 <fwp_apply_owned+0x435>
    b9d2:	4c 8d 04 3e          	lea    (%rsi,%rdi,1),%r8
    b9d6:	8b 74 3e 20          	mov    0x20(%rsi,%rdi,1),%esi
    b9da:	48 0f af d6          	imul   %rsi,%rdx
    b9de:	48 c1 ea 20          	shr    $0x20,%rdx
    b9e2:	4c 01 c2             	add    %r8,%rdx
    b9e5:	48 81 c2 28 02 00 00 	add    $0x228,%rdx
    b9ec:	80 3a 00             	cmpb   $0x0,(%rdx)
    b9ef:	0f 85 8d 00 00 00    	jne    ba82 <fwp_apply_owned+0x4c2>
    b9f5:	45 85 ed             	test   %r13d,%r13d
    b9f8:	0f 84 b2 00 00 00    	je     bab0 <fwp_apply_owned+0x4f0>
    b9fe:	48 8b 15 f3 77 00 00 	mov    0x77f3(%rip),%rdx        # 131f8 <fwp_gc+0x1078>
    ba05:	44 89 ee             	mov    %r13d,%esi
    ba08:	31 ff                	xor    %edi,%edi
    ba0a:	eb 21                	jmp    ba2d <fwp_apply_owned+0x46d>
    ba0c:	0f 1f 40 00          	nopl   0x0(%rax)
    ba10:	4e 8d 04 0a          	lea    (%rdx,%r9,1),%r8
    ba14:	49 81 c0 28 02 00 00 	add    $0x228,%r8
    ba1b:	41 80 38 00          	cmpb   $0x0,(%r8)
    ba1f:	75 61                	jne    ba82 <fwp_apply_owned+0x4c2>
    ba21:	48 ff c7             	inc    %rdi
    ba24:	48 39 fe             	cmp    %rdi,%rsi
    ba27:	0f 84 83 00 00 00    	je     bab0 <fwp_apply_owned+0x4f0>
    ba2d:	4c 8b 04 fb          	mov    (%rbx,%rdi,8),%r8
    ba31:	49 29 c0             	sub    %rax,%r8
    ba34:	49 39 c8             	cmp    %rcx,%r8
    ba37:	73 e8                	jae    ba21 <fwp_apply_owned+0x461>
    ba39:	4d 89 c1             	mov    %r8,%r9
    ba3c:	49 c1 e9 10          	shr    $0x10,%r9
    ba40:	4d 69 c9 28 12 00 00 	imul   $0x1228,%r9,%r9
    ba47:	46 0f b6 14 0a       	movzbl (%rdx,%r9,1),%r10d
    ba4c:	49 81 e0 ff ff 00 00 	and    $0xffff,%r8
    ba53:	75 06                	jne    ba5b <fwp_apply_owned+0x49b>
    ba55:	41 80 fa 02          	cmp    $0x2,%r10b
    ba59:	74 b5                	je     ba10 <fwp_apply_owned+0x450>
    ba5b:	41 80 fa 01          	cmp    $0x1,%r10b
    ba5f:	75 c0                	jne    ba21 <fwp_apply_owned+0x461>
    ba61:	4e 8d 14 0a          	lea    (%rdx,%r9,1),%r10
    ba65:	46 8b 4c 0a 20       	mov    0x20(%rdx,%r9,1),%r9d
    ba6a:	4d 0f af c1          	imul   %r9,%r8
    ba6e:	49 c1 e8 20          	shr    $0x20,%r8
    ba72:	4d 01 d0             	add    %r10,%r8
    ba75:	49 81 c0 28 02 00 00 	add    $0x228,%r8
    ba7c:	41 80 38 00          	cmpb   $0x0,(%r8)
    ba80:	74 9f                	je     ba21 <fwp_apply_owned+0x461>
    ba82:	e8 99 a7 ff ff       	call   6220 <fwp_flush>
    ba87:	48 8b 05 52 65 00 00 	mov    0x6552(%rip),%rax        # 11fe0 <stderr@GLIBC_2.2.5>
    ba8e:	48 8b 38             	mov    (%rax),%rdi
    ba91:	48 8d 35 95 39 00 00 	lea    0x3995(%rip),%rsi        # f42d <fwp_segv.msg+0x1ed>
    ba98:	48 8d 15 61 39 00 00 	lea    0x3961(%rip),%rdx        # f400 <fwp_segv.msg+0x1c0>
    ba9f:	31 c0                	xor    %eax,%eax
    baa1:	e8 0a 67 ff ff       	call   21b0 <fprintf@plt>
    baa6:	bf 65 00 00 00       	mov    $0x65,%edi
    baab:	e8 e0 67 ff ff       	call   2290 <exit@plt>
    bab0:	4c 89 e7             	mov    %r12,%rdi
    bab3:	44 89 ee             	mov    %r13d,%esi
    bab6:	48 89 da             	mov    %rbx,%rdx
    bab9:	e8 a2 f5 ff ff       	call   b060 <fwp_apply>
    babe:	49 89 c4             	mov    %rax,%r12
    bac1:	e9 4d 03 00 00       	jmp    be13 <fwp_apply_owned+0x853>
    bac6:	4e 8b 6c d0 10       	mov    0x10(%rax,%r10,8),%r13
    bacb:	4e 8b 5c d0 18       	mov    0x18(%rax,%r10,8),%r11
    bad0:	4d 29 eb             	sub    %r13,%r11
    bad3:	49 39 d3             	cmp    %rdx,%r11
    bad6:	72 34                	jb     bb0c <fwp_apply_owned+0x54c>
    bad8:	4a 8d 34 d0          	lea    (%rax,%r10,8),%rsi
    badc:	48 83 c6 10          	add    $0x10,%rsi
    bae0:	4e 8d 14 2a          	lea    (%rdx,%r13,1),%r10
    bae4:	4c 89 16             	mov    %r10,(%rsi)
    bae7:	4d 85 ed             	test   %r13,%r13
    baea:	0f 85 bc fe ff ff    	jne    b9ac <fwp_apply_owned+0x3ec>
    baf0:	41 0f b6 b4 00 e8 0b 	movzbl 0xbe8(%r8,%rax,1),%esi
    baf7:	00 00 
    baf9:	8b 94 b0 48 0b 00 00 	mov    0xb48(%rax,%rsi,4),%edx
    bb00:	49 29 d1             	sub    %rdx,%r9
    bb03:	4c 89 0d 76 66 00 00 	mov    %r9,0x6676(%rip)        # 12180 <fwp_gc>
    bb0a:	78 31                	js     bb3d <fwp_apply_owned+0x57d>
    bb0c:	48 8d 0c 76          	lea    (%rsi,%rsi,2),%rcx
    bb10:	4c 8b 6c c8 08       	mov    0x8(%rax,%rcx,8),%r13
    bb15:	4d 85 ed             	test   %r13,%r13
    bb18:	74 11                	je     bb2b <fwp_apply_owned+0x56b>
    bb1a:	48 8d 04 c8          	lea    (%rax,%rcx,8),%rax
    bb1e:	48 83 c0 08          	add    $0x8,%rax
    bb22:	49 8b 4d 00          	mov    0x0(%r13),%rcx
    bb26:	48 f7 d1             	not    %rcx
    bb29:	eb 2a                	jmp    bb55 <fwp_apply_owned+0x595>
    bb2b:	4c 8b 6c c8 10       	mov    0x10(%rax,%rcx,8),%r13
    bb30:	48 8b 74 c8 18       	mov    0x18(%rax,%rcx,8),%rsi
    bb35:	4c 29 ee             	sub    %r13,%rsi
    bb38:	48 39 d6             	cmp    %rdx,%rsi
    bb3b:	73 0c                	jae    bb49 <fwp_apply_owned+0x589>
    bb3d:	31 f6                	xor    %esi,%esi
    bb3f:	e8 2c ab ff ff       	call   6670 <fwp_gc_alloc_slow>
    bb44:	49 89 c5             	mov    %rax,%r13
    bb47:	eb 19                	jmp    bb62 <fwp_apply_owned+0x5a2>
    bb49:	48 8d 04 c8          	lea    (%rax,%rcx,8),%rax
    bb4d:	48 83 c0 10          	add    $0x10,%rax
    bb51:	4a 8d 0c 2a          	lea    (%rdx,%r13,1),%rcx
    bb55:	48 89 08             	mov    %rcx,(%rax)
    bb58:	4c 89 ef             	mov    %r13,%rdi
    bb5b:	31 f6                	xor    %esi,%esi
    bb5d:	e8 ce 65 ff ff       	call   2130 <memset@plt>
    bb62:	4c 8b 4d d0          	mov    -0x30(%rbp),%r9
    bb66:	41 8b 04 24          	mov    (%r12),%eax
    bb6a:	41 89 45 00          	mov    %eax,0x0(%r13)
    bb6e:	45 89 7d 04          	mov    %r15d,0x4(%r13)
    bb72:	4d 85 f6             	test   %r14,%r14
    bb75:	0f 84 c6 00 00 00    	je     bc41 <fwp_apply_owned+0x681>
    bb7b:	31 c0                	xor    %eax,%eax
    bb7d:	41 83 fe 06          	cmp    $0x6,%r14d
    bb81:	72 53                	jb     bbd6 <fwp_apply_owned+0x616>
    bb83:	4c 89 e9             	mov    %r13,%rcx
    bb86:	4c 29 e1             	sub    %r12,%rcx
    bb89:	48 83 f9 20          	cmp    $0x20,%rcx
    bb8d:	72 47                	jb     bbd6 <fwp_apply_owned+0x616>
    bb8f:	44 89 f0             	mov    %r14d,%eax
    bb92:	83 e0 fc             	and    $0xfffffffc,%eax
    bb95:	4a 8d 0c f5 00 00 00 	lea    0x0(,%r14,8),%rcx
    bb9c:	00 
    bb9d:	48 83 e1 e0          	and    $0xffffffffffffffe0,%rcx
    bba1:	31 d2                	xor    %edx,%edx
    bba3:	66 66 66 66 2e 0f 1f 	data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    bbaa:	84 00 00 00 00 00 
    bbb0:	41 0f 10 44 14 08    	movups 0x8(%r12,%rdx,1),%xmm0
    bbb6:	41 0f 10 4c 14 18    	movups 0x18(%r12,%rdx,1),%xmm1
    bbbc:	41 0f 11 44 15 08    	movups %xmm0,0x8(%r13,%rdx,1)
    bbc2:	41 0f 11 4c 15 18    	movups %xmm1,0x18(%r13,%rdx,1)
    bbc8:	48 83 c2 20          	add    $0x20,%rdx
    bbcc:	48 39 d1             	cmp    %rdx,%rcx
    bbcf:	75 df                	jne    bbb0 <fwp_apply_owned+0x5f0>
    bbd1:	4c 39 f0             	cmp    %r14,%rax
    bbd4:	74 6b                	je     bc41 <fwp_apply_owned+0x681>
    bbd6:	4c 89 f2             	mov    %r14,%rdx
    bbd9:	48 89 c1             	mov    %rax,%rcx
    bbdc:	48 83 e2 03          	and    $0x3,%rdx
    bbe0:	74 20                	je     bc02 <fwp_apply_owned+0x642>
    bbe2:	48 89 c1             	mov    %rax,%rcx
    bbe5:	66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
    bbec:	00 00 00 00 
    bbf0:	49 8b 74 cc 08       	mov    0x8(%r12,%rcx,8),%rsi
    bbf5:	49 89 74 cd 08       	mov    %rsi,0x8(%r13,%rcx,8)
    bbfa:	48 ff c1             	inc    %rcx
    bbfd:	48 ff ca             	dec    %rdx
    bc00:	75 ee                	jne    bbf0 <fwp_apply_owned+0x630>
    bc02:	4c 29 f0             	sub    %r14,%rax
    bc05:	48 83 f8 fc          	cmp    $0xfffffffffffffffc,%rax
    bc09:	77 36                	ja     bc41 <fwp_apply_owned+0x681>
    bc0b:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)
    bc10:	49 8b 44 cc 08       	mov    0x8(%r12,%rcx,8),%rax
    bc15:	49 89 44 cd 08       	mov    %rax,0x8(%r13,%rcx,8)
    bc1a:	49 8b 44 cc 10       	mov    0x10(%r12,%rcx,8),%rax
    bc1f:	49 89 44 cd 10       	mov    %rax,0x10(%r13,%rcx,8)
    bc24:	49 8b 44 cc 18       	mov    0x18(%r12,%rcx,8),%rax
    bc29:	49 89 44 cd 18       	mov    %rax,0x18(%r13,%rcx,8)
    bc2e:	49 8b 44 cc 20       	mov    0x20(%r12,%rcx,8),%rax
    bc33:	49 89 44 cd 20       	mov    %rax,0x20(%r13,%rcx,8)
    bc38:	48 83 c1 04          	add    $0x4,%rcx
    bc3c:	49 39 ce             	cmp    %rcx,%r14
    bc3f:	75 cf                	jne    bc10 <fwp_apply_owned+0x650>
    bc41:	48 8b 4d c8          	mov    -0x38(%rbp),%rcx
    bc45:	85 c9                	test   %ecx,%ecx
    bc47:	0f 84 89 00 00 00    	je     bcd6 <fwp_apply_owned+0x716>
    bc4d:	89 c8                	mov    %ecx,%eax
    bc4f:	83 f9 14             	cmp    $0x14,%ecx
    bc52:	0f 83 fb 00 00 00    	jae    bd53 <fwp_apply_owned+0x793>
    bc58:	31 c9                	xor    %ecx,%ecx
    bc5a:	48 89 c6             	mov    %rax,%rsi
    bc5d:	48 89 ca             	mov    %rcx,%rdx
    bc60:	48 83 e6 03          	and    $0x3,%rsi
    bc64:	74 1f                	je     bc85 <fwp_apply_owned+0x6c5>
    bc66:	48 89 ca             	mov    %rcx,%rdx
    bc69:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)
    bc70:	48 8b 3c d3          	mov    (%rbx,%rdx,8),%rdi
    bc74:	45 8d 04 16          	lea    (%r14,%rdx,1),%r8d
    bc78:	4b 89 7c c5 08       	mov    %rdi,0x8(%r13,%r8,8)
    bc7d:	48 ff c2             	inc    %rdx
    bc80:	48 ff ce             	dec    %rsi
    bc83:	75 eb                	jne    bc70 <fwp_apply_owned+0x6b0>
    bc85:	48 29 c1             	sub    %rax,%rcx
    bc88:	48 83 f9 fc          	cmp    $0xfffffffffffffffc,%rcx
    bc8c:	77 48                	ja     bcd6 <fwp_apply_owned+0x716>
    bc8e:	66 90                	xchg   %ax,%ax
    bc90:	48 8b 0c d3          	mov    (%rbx,%rdx,8),%rcx
    bc94:	41 8d 34 16          	lea    (%r14,%rdx,1),%esi
    bc98:	49 89 4c f5 08       	mov    %rcx,0x8(%r13,%rsi,8)
    bc9d:	48 8b 4c d3 08       	mov    0x8(%rbx,%rdx,8),%rcx
    bca2:	41 8d 34 16          	lea    (%r14,%rdx,1),%esi
    bca6:	ff c6                	inc    %esi
    bca8:	49 89 4c f5 08       	mov    %rcx,0x8(%r13,%rsi,8)
    bcad:	48 8b 4c d3 10       	mov    0x10(%rbx,%rdx,8),%rcx
    bcb2:	41 8d 74 16 02       	lea    0x2(%r14,%rdx,1),%esi
    bcb7:	49 89 4c f5 08       	mov    %rcx,0x8(%r13,%rsi,8)
    bcbc:	48 8b 4c d3 18       	mov    0x18(%rbx,%rdx,8),%rcx
    bcc1:	41 8d 34 16          	lea    (%r14,%rdx,1),%esi
    bcc5:	83 c6 03             	add    $0x3,%esi
    bcc8:	49 89 4c f5 08       	mov    %rcx,0x8(%r13,%rsi,8)
    bccd:	48 83 c2 04          	add    $0x4,%rdx
    bcd1:	48 39 d0             	cmp    %rdx,%rax
    bcd4:	75 ba                	jne    bc90 <fwp_apply_owned+0x6d0>
    bcd6:	49 8b 01             	mov    (%r9),%rax
    bcd9:	4c 8b 75 c0          	mov    -0x40(%rbp),%r14
    bcdd:	4c 89 f7             	mov    %r14,%rdi
    bce0:	be 01 00 00 00       	mov    $0x1,%esi
    bce5:	ff 50 08             	call   *0x8(%rax)
    bce8:	4c 89 e8             	mov    %r13,%rax
    bceb:	48 2b 05 be 74 00 00 	sub    0x74be(%rip),%rax        # 131b0 <fwp_gc+0x1030>
    bcf2:	48 8b 0d df 74 00 00 	mov    0x74df(%rip),%rcx        # 131d8 <fwp_gc+0x1058>
    bcf9:	48 c1 e1 10          	shl    $0x10,%rcx
    bcfd:	48 39 c8             	cmp    %rcx,%rax
    bd00:	0f 83 02 01 00 00    	jae    be08 <fwp_apply_owned+0x848>
    bd06:	48 8b 0d eb 74 00 00 	mov    0x74eb(%rip),%rcx        # 131f8 <fwp_gc+0x1078>
    bd0d:	48 89 c2             	mov    %rax,%rdx
    bd10:	48 c1 ea 10          	shr    $0x10,%rdx
    bd14:	48 69 d2 28 12 00 00 	imul   $0x1228,%rdx,%rdx
    bd1b:	0f b6 34 11          	movzbl (%rcx,%rdx,1),%esi
    bd1f:	48 25 ff ff 00 00    	and    $0xffff,%rax
    bd25:	0f 85 a5 00 00 00    	jne    bdd0 <fwp_apply_owned+0x810>
    bd2b:	40 80 fe 02          	cmp    $0x2,%sil
    bd2f:	0f 85 9b 00 00 00    	jne    bdd0 <fwp_apply_owned+0x810>
    bd35:	4c 8d 3c 11          	lea    (%rcx,%rdx,1),%r15
    bd39:	49 81 c7 28 02 00 00 	add    $0x228,%r15
    bd40:	41 80 3f ff          	cmpb   $0xff,(%r15)
    bd44:	0f 84 b1 00 00 00    	je     bdfb <fwp_apply_owned+0x83b>
    bd4a:	41 c6 07 01          	movb   $0x1,(%r15)
    bd4e:	e9 b5 00 00 00       	jmp    be08 <fwp_apply_owned+0x848>
    bd53:	48 8d 50 ff          	lea    -0x1(%rax),%rdx
    bd57:	31 c9                	xor    %ecx,%ecx
    bd59:	89 d6                	mov    %edx,%esi
    bd5b:	44 01 f6             	add    %r14d,%esi
    bd5e:	0f 82 f6 fe ff ff    	jb     bc5a <fwp_apply_owned+0x69a>
    bd64:	48 c1 ea 20          	shr    $0x20,%rdx
    bd68:	0f 85 ec fe ff ff    	jne    bc5a <fwp_apply_owned+0x69a>
    bd6e:	4a 8d 0c f5 00 00 00 	lea    0x0(,%r14,8),%rcx
    bd75:	00 
    bd76:	4c 01 e9             	add    %r13,%rcx
    bd79:	48 29 d9             	sub    %rbx,%rcx
    bd7c:	48 83 c1 08          	add    $0x8,%rcx
    bd80:	48 83 f9 20          	cmp    $0x20,%rcx
    bd84:	0f 82 ce fe ff ff    	jb     bc58 <fwp_apply_owned+0x698>
    bd8a:	89 c1                	mov    %eax,%ecx
    bd8c:	83 e1 fc             	and    $0xfffffffc,%ecx
    bd8f:	31 d2                	xor    %edx,%edx
    bd91:	66 66 66 66 66 66 2e 	data16 data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    bd98:	0f 1f 84 00 00 00 00 
    bd9f:	00 
    bda0:	0f 10 04 d3          	movups (%rbx,%rdx,8),%xmm0
    bda4:	0f 10 4c d3 10       	movups 0x10(%rbx,%rdx,8),%xmm1
    bda9:	41 8d 34 16          	lea    (%r14,%rdx,1),%esi
    bdad:	41 0f 11 44 f5 08    	movups %xmm0,0x8(%r13,%rsi,8)
    bdb3:	41 0f 11 4c f5 18    	movups %xmm1,0x18(%r13,%rsi,8)
    bdb9:	48 83 c2 04          	add    $0x4,%rdx
    bdbd:	48 39 d1             	cmp    %rdx,%rcx
    bdc0:	75 de                	jne    bda0 <fwp_apply_owned+0x7e0>
    bdc2:	48 39 c1             	cmp    %rax,%rcx
    bdc5:	0f 85 8f fe ff ff    	jne    bc5a <fwp_apply_owned+0x69a>
    bdcb:	e9 06 ff ff ff       	jmp    bcd6 <fwp_apply_owned+0x716>
    bdd0:	40 80 fe 01          	cmp    $0x1,%sil
    bdd4:	75 32                	jne    be08 <fwp_apply_owned+0x848>
    bdd6:	48 8d 34 11          	lea    (%rcx,%rdx,1),%rsi
    bdda:	8b 4c 11 20          	mov    0x20(%rcx,%rdx,1),%ecx
    bdde:	48 0f af c1          	imul   %rcx,%rax
    bde2:	48 c1 e8 20          	shr    $0x20,%rax
    bde6:	4c 8d 3c 30          	lea    (%rax,%rsi,1),%r15
    bdea:	49 81 c7 28 02 00 00 	add    $0x228,%r15
    bdf1:	41 80 3f ff          	cmpb   $0xff,(%r15)
    bdf5:	0f 85 4f ff ff ff    	jne    bd4a <fwp_apply_owned+0x78a>
    bdfb:	4c 89 ff             	mov    %r15,%rdi
    bdfe:	e8 4d a4 ff ff       	call   6250 <fwp_rc_forget_slot>
    be03:	e9 42 ff ff ff       	jmp    bd4a <fwp_apply_owned+0x78a>
    be08:	4c 89 f7             	mov    %r14,%rdi
    be0b:	e8 20 00 00 00       	call   be30 <fwp_closure_drop>
    be10:	4d 89 ec             	mov    %r13,%r12
    be13:	4c 89 e0             	mov    %r12,%rax
    be16:	48 8d 65 d8          	lea    -0x28(%rbp),%rsp
    be1a:	5b                   	pop    %rbx
    be1b:	41 5c                	pop    %r12
    be1d:	41 5d                	pop    %r13
    be1f:	41 5e                	pop    %r14
    be21:	41 5f                	pop    %r15
    be23:	5d                   	pop    %rbp
    be24:	c3                   	ret
    be25:	66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
    be2c:	00 00 00 00 

000000000000be30 <fwp_closure_drop>:
    be30:	41 57                	push   %r15
    be32:	41 56                	push   %r14
    be34:	53                   	push   %rbx
    be35:	48 81 ec 30 02 00 00 	sub    $0x230,%rsp
    be3c:	48 89 f8             	mov    %rdi,%rax
    be3f:	48 2b 05 6a 73 00 00 	sub    0x736a(%rip),%rax        # 131b0 <fwp_gc+0x1030>
    be46:	48 8b 0d 8b 73 00 00 	mov    0x738b(%rip),%rcx        # 131d8 <fwp_gc+0x1058>
    be4d:	48 c1 e1 10          	shl    $0x10,%rcx
    be51:	48 39 c8             	cmp    %rcx,%rax
    be54:	0f 83 91 00 00 00    	jae    beeb <fwp_closure_drop+0xbb>
    be5a:	48 89 fe             	mov    %rdi,%rsi
    be5d:	48 8b 0d 94 73 00 00 	mov    0x7394(%rip),%rcx        # 131f8 <fwp_gc+0x1078>
    be64:	48 89 c2             	mov    %rax,%rdx
    be67:	48 c1 ea 10          	shr    $0x10,%rdx
    be6b:	48 69 d2 28 12 00 00 	imul   $0x1228,%rdx,%rdx
    be72:	0f b6 3c 11          	movzbl (%rcx,%rdx,1),%edi
    be76:	48 25 ff ff 00 00    	and    $0xffff,%rax
    be7c:	75 13                	jne    be91 <fwp_closure_drop+0x61>
    be7e:	40 80 ff 02          	cmp    $0x2,%dil
    be82:	75 0d                	jne    be91 <fwp_closure_drop+0x61>
    be84:	48 8d 3c 11          	lea    (%rcx,%rdx,1),%rdi
    be88:	48 81 c7 28 02 00 00 	add    $0x228,%rdi
    be8f:	eb 20                	jmp    beb1 <fwp_closure_drop+0x81>
    be91:	40 80 ff 01          	cmp    $0x1,%dil
    be95:	75 54                	jne    beeb <fwp_closure_drop+0xbb>
    be97:	48 8d 3c 11          	lea    (%rcx,%rdx,1),%rdi
    be9b:	8b 4c 11 20          	mov    0x20(%rcx,%rdx,1),%ecx
    be9f:	48 0f af c1          	imul   %rcx,%rax
    bea3:	48 c1 e8 20          	shr    $0x20,%rax
    bea7:	48 01 c7             	add    %rax,%rdi
    beaa:	48 81 c7 28 02 00 00 	add    $0x228,%rdi
    beb1:	0f b6 07             	movzbl (%rdi),%eax
    beb4:	85 c0                	test   %eax,%eax
    beb6:	74 33                	je     beeb <fwp_closure_drop+0xbb>
    beb8:	83 f8 01             	cmp    $0x1,%eax
    bebb:	75 1f                	jne    bedc <fwp_closure_drop+0xac>
    bebd:	64 48 8b 3c 25 f8 ff 	mov    %fs:0xfffffffffffffff8,%rdi
    bec4:	ff ff 
    bec6:	48 85 ff             	test   %rdi,%rdi
    bec9:	74 2d                	je     bef8 <fwp_closure_drop+0xc8>
    becb:	48 81 c4 30 02 00 00 	add    $0x230,%rsp
    bed2:	5b                   	pop    %rbx
    bed3:	41 5e                	pop    %r14
    bed5:	41 5f                	pop    %r15
    bed7:	e9 44 01 00 00       	jmp    c020 <fwp_closure_drop_push>
    bedc:	3d ff 00 00 00       	cmp    $0xff,%eax
    bee1:	0f 84 e7 00 00 00    	je     bfce <fwp_closure_drop+0x19e>
    bee7:	fe c8                	dec    %al
    bee9:	88 07                	mov    %al,(%rdi)
    beeb:	48 81 c4 30 02 00 00 	add    $0x230,%rsp
    bef2:	5b                   	pop    %rbx
    bef3:	41 5e                	pop    %r14
    bef5:	41 5f                	pop    %r15
    bef7:	c3                   	ret
    bef8:	64 48 8b 04 25 00 00 	mov    %fs:0x0,%rax
    beff:	00 00 
    bf01:	4c 8d b0 f8 ff ff ff 	lea    -0x8(%rax),%r14
    bf08:	48 8d 5c 24 30       	lea    0x30(%rsp),%rbx
    bf0d:	48 89 5c 24 18       	mov    %rbx,0x18(%rsp)
    bf12:	48 c7 44 24 20 00 00 	movq   $0x0,0x20(%rsp)
    bf19:	00 00 
    bf1b:	48 c7 44 24 28 40 00 	movq   $0x40,0x28(%rsp)
    bf22:	00 00 
    bf24:	48 8b 05 bd 7c 00 00 	mov    0x7cbd(%rip),%rax        # 13be8 <fwp_cleanups>
    bf2b:	48 89 04 24          	mov    %rax,(%rsp)
    bf2f:	48 8d 05 ca 01 00 00 	lea    0x1ca(%rip),%rax        # c100 <fwp_closure_drop_release>
    bf36:	48 89 44 24 08       	mov    %rax,0x8(%rsp)
    bf3b:	48 8d 7c 24 18       	lea    0x18(%rsp),%rdi
    bf40:	48 89 7c 24 10       	mov    %rdi,0x10(%rsp)
    bf45:	49 89 e7             	mov    %rsp,%r15
    bf48:	4c 89 3d 99 7c 00 00 	mov    %r15,0x7c99(%rip)        # 13be8 <fwp_cleanups>
    bf4f:	49 89 3e             	mov    %rdi,(%r14)
    bf52:	e8 c9 00 00 00       	call   c020 <fwp_closure_drop_push>
    bf57:	66 0f 1f 84 00 00 00 	nopw   0x0(%rax,%rax,1)
    bf5e:	00 00 
    bf60:	48 8b 44 24 20       	mov    0x20(%rsp),%rax
    bf65:	48 85 c0             	test   %rax,%rax
    bf68:	74 31                	je     bf9b <fwp_closure_drop+0x16b>
    bf6a:	48 8b 4c 24 18       	mov    0x18(%rsp),%rcx
    bf6f:	48 8d 50 ff          	lea    -0x1(%rax),%rdx
    bf73:	48 89 54 24 20       	mov    %rdx,0x20(%rsp)
    bf78:	48 8b 7c c1 f8       	mov    -0x8(%rcx,%rax,8),%rdi
    bf7d:	48 8b 05 3c 7c 00 00 	mov    0x7c3c(%rip),%rax        # 13bc0 <fwp_fns>
    bf84:	8b 0f                	mov    (%rdi),%ecx
    bf86:	48 c1 e1 05          	shl    $0x5,%rcx
    bf8a:	48 8b 44 08 18       	mov    0x18(%rax,%rcx,1),%rax
    bf8f:	48 85 c0             	test   %rax,%rax
    bf92:	74 4b                	je     bfdf <fwp_closure_drop+0x1af>
    bf94:	31 f6                	xor    %esi,%esi
    bf96:	ff 50 08             	call   *0x8(%rax)
    bf99:	eb c5                	jmp    bf60 <fwp_closure_drop+0x130>
    bf9b:	4c 39 3d 46 7c 00 00 	cmp    %r15,0x7c46(%rip)        # 13be8 <fwp_cleanups>
    bfa2:	75 69                	jne    c00d <fwp_closure_drop+0x1dd>
    bfa4:	48 8b 04 24          	mov    (%rsp),%rax
    bfa8:	48 89 05 39 7c 00 00 	mov    %rax,0x7c39(%rip)        # 13be8 <fwp_cleanups>
    bfaf:	49 c7 06 00 00 00 00 	movq   $0x0,(%r14)
    bfb6:	48 8b 7c 24 18       	mov    0x18(%rsp),%rdi
    bfbb:	48 39 df             	cmp    %rbx,%rdi
    bfbe:	0f 84 27 ff ff ff    	je     beeb <fwp_closure_drop+0xbb>
    bfc4:	e8 87 60 ff ff       	call   2050 <free@plt>
    bfc9:	e9 1d ff ff ff       	jmp    beeb <fwp_closure_drop+0xbb>
    bfce:	48 81 c4 30 02 00 00 	add    $0x230,%rsp
    bfd5:	5b                   	pop    %rbx
    bfd6:	41 5e                	pop    %r14
    bfd8:	41 5f                	pop    %r15
    bfda:	e9 81 e5 ff ff       	jmp    a560 <fwp_rc_wide_drop>
    bfdf:	e8 3c a2 ff ff       	call   6220 <fwp_flush>
    bfe4:	48 8b 05 f5 5f 00 00 	mov    0x5ff5(%rip),%rax        # 11fe0 <stderr@GLIBC_2.2.5>
    bfeb:	48 8b 38             	mov    (%rax),%rdi
    bfee:	48 8d 35 38 34 00 00 	lea    0x3438(%rip),%rsi        # f42d <fwp_segv.msg+0x1ed>
    bff5:	48 8d 15 b9 36 00 00 	lea    0x36b9(%rip),%rdx        # f6b5 <fwp_segv.msg+0x475>
    bffc:	31 c0                	xor    %eax,%eax
    bffe:	e8 ad 61 ff ff       	call   21b0 <fprintf@plt>
    c003:	bf 65 00 00 00       	mov    $0x65,%edi
    c008:	e8 83 62 ff ff       	call   2290 <exit@plt>
    c00d:	e8 4e 60 ff ff       	call   2060 <abort@plt>
    c012:	66 66 66 66 66 2e 0f 	data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    c019:	1f 84 00 00 00 00 00 

000000000000c020 <fwp_closure_drop_push>:
    c020:	55                   	push   %rbp
    c021:	41 57                	push   %r15
    c023:	41 56                	push   %r14
    c025:	41 55                	push   %r13
    c027:	41 54                	push   %r12
    c029:	53                   	push   %rbx
    c02a:	50                   	push   %rax
    c02b:	48 89 f3             	mov    %rsi,%rbx
    c02e:	49 89 fe             	mov    %rdi,%r14
    c031:	4c 8b 6f 08          	mov    0x8(%rdi),%r13
    c035:	4c 3b 6f 10          	cmp    0x10(%rdi),%r13
    c039:	75 59                	jne    c094 <fwp_closure_drop_push+0x74>
    c03b:	4c 89 e8             	mov    %r13,%rax
    c03e:	48 c1 e8 3c          	shr    $0x3c,%rax
    c042:	75 6e                	jne    c0b2 <fwp_closure_drop_push+0x92>
    c044:	4c 89 ef             	mov    %r13,%rdi
    c047:	48 c1 e7 04          	shl    $0x4,%rdi
    c04b:	e8 a0 61 ff ff       	call   21f0 <malloc@plt>
    c050:	48 85 c0             	test   %rax,%rax
    c053:	74 7c                	je     c0d1 <fwp_closure_drop_push+0xb1>
    c055:	49 89 c7             	mov    %rax,%r15
    c058:	4a 8d 2c 6d 00 00 00 	lea    0x0(,%r13,2),%rbp
    c05f:	00 
    c060:	4d 8b 26             	mov    (%r14),%r12
    c063:	4a 8d 14 ed 00 00 00 	lea    0x0(,%r13,8),%rdx
    c06a:	00 
    c06b:	48 89 c7             	mov    %rax,%rdi
    c06e:	4c 89 e6             	mov    %r12,%rsi
    c071:	e8 6a 61 ff ff       	call   21e0 <memcpy@plt>
    c076:	49 8d 46 18          	lea    0x18(%r14),%rax
    c07a:	49 39 c4             	cmp    %rax,%r12
    c07d:	74 0c                	je     c08b <fwp_closure_drop_push+0x6b>
    c07f:	4c 89 e7             	mov    %r12,%rdi
    c082:	e8 c9 5f ff ff       	call   2050 <free@plt>
    c087:	4d 8b 6e 08          	mov    0x8(%r14),%r13
    c08b:	4d 89 3e             	mov    %r15,(%r14)
    c08e:	49 89 6e 10          	mov    %rbp,0x10(%r14)
    c092:	eb 03                	jmp    c097 <fwp_closure_drop_push+0x77>
    c094:	4d 8b 3e             	mov    (%r14),%r15
    c097:	49 8d 45 01          	lea    0x1(%r13),%rax
    c09b:	49 89 46 08          	mov    %rax,0x8(%r14)
    c09f:	4b 89 1c ef          	mov    %rbx,(%r15,%r13,8)
    c0a3:	48 83 c4 08          	add    $0x8,%rsp
    c0a7:	5b                   	pop    %rbx
    c0a8:	41 5c                	pop    %r12
    c0aa:	41 5d                	pop    %r13
    c0ac:	41 5e                	pop    %r14
    c0ae:	41 5f                	pop    %r15
    c0b0:	5d                   	pop    %rbp
    c0b1:	c3                   	ret
    c0b2:	e8 69 a1 ff ff       	call   6220 <fwp_flush>
    c0b7:	48 8b 05 22 5f 00 00 	mov    0x5f22(%rip),%rax        # 11fe0 <stderr@GLIBC_2.2.5>
    c0be:	48 8b 38             	mov    (%rax),%rdi
    c0c1:	48 8d 35 65 33 00 00 	lea    0x3365(%rip),%rsi        # f42d <fwp_segv.msg+0x1ed>
    c0c8:	48 8d 15 14 36 00 00 	lea    0x3614(%rip),%rdx        # f6e3 <fwp_segv.msg+0x4a3>
    c0cf:	eb 1d                	jmp    c0ee <fwp_closure_drop_push+0xce>
    c0d1:	e8 4a a1 ff ff       	call   6220 <fwp_flush>
    c0d6:	48 8b 05 03 5f 00 00 	mov    0x5f03(%rip),%rax        # 11fe0 <stderr@GLIBC_2.2.5>
    c0dd:	48 8b 38             	mov    (%rax),%rdi
    c0e0:	48 8d 35 46 33 00 00 	lea    0x3346(%rip),%rsi        # f42d <fwp_segv.msg+0x1ed>
    c0e7:	48 8d 15 0f 36 00 00 	lea    0x360f(%rip),%rdx        # f6fd <fwp_segv.msg+0x4bd>
    c0ee:	31 c0                	xor    %eax,%eax
    c0f0:	e8 bb 60 ff ff       	call   21b0 <fprintf@plt>
    c0f5:	bf 65 00 00 00       	mov    $0x65,%edi
    c0fa:	e8 91 61 ff ff       	call   2290 <exit@plt>
    c0ff:	90                   	nop

000000000000c100 <fwp_closure_drop_release>:
    c100:	41 56                	push   %r14
    c102:	53                   	push   %rbx
    c103:	50                   	push   %rax
    c104:	48 89 fb             	mov    %rdi,%rbx
    c107:	64 48 c7 04 25 f8 ff 	movq   $0x0,%fs:0xfffffffffffffff8
    c10e:	ff ff 00 00 00 00 
    c114:	48 8b 3f             	mov    (%rdi),%rdi
    c117:	4c 8d 73 18          	lea    0x18(%rbx),%r14
    c11b:	4c 39 f7             	cmp    %r14,%rdi
    c11e:	74 05                	je     c125 <fwp_closure_drop_release+0x25>
    c120:	e8 2b 5f ff ff       	call   2050 <free@plt>
    c125:	4c 89 33             	mov    %r14,(%rbx)
    c128:	48 c7 43 08 00 00 00 	movq   $0x0,0x8(%rbx)
    c12f:	00 
    c130:	48 83 c4 08          	add    $0x8,%rsp
    c134:	5b                   	pop    %rbx
    c135:	41 5e                	pop    %r14
    c137:	c3                   	ret
    c138:	0f 1f 84 00 00 00 00 	nopl   0x0(%rax,%rax,1)
    c13f:	00 

000000000000c140 <f52>:
    c140:	41 57                	push   %r15
    c142:	41 56                	push   %r14
    c144:	53                   	push   %rbx
    c145:	48 83 ec 30          	sub    $0x30,%rsp
    c149:	48 89 fb             	mov    %rdi,%rbx
    c14c:	48 8b 47 10          	mov    0x10(%rdi),%rax
    c150:	48 2b 05 59 70 00 00 	sub    0x7059(%rip),%rax        # 131b0 <fwp_gc+0x1030>
    c157:	48 8b 0d 7a 70 00 00 	mov    0x707a(%rip),%rcx        # 131d8 <fwp_gc+0x1058>
    c15e:	48 c1 e1 10          	shl    $0x10,%rcx
    c162:	48 39 c8             	cmp    %rcx,%rax
    c165:	73 68                	jae    c1cf <f52+0x8f>
    c167:	48 8b 0d 8a 70 00 00 	mov    0x708a(%rip),%rcx        # 131f8 <fwp_gc+0x1078>
    c16e:	48 89 c2             	mov    %rax,%rdx
    c171:	48 c1 ea 10          	shr    $0x10,%rdx
    c175:	48 69 d2 28 12 00 00 	imul   $0x1228,%rdx,%rdx
    c17c:	0f b6 34 11          	movzbl (%rcx,%rdx,1),%esi
    c180:	48 25 ff ff 00 00    	and    $0xffff,%rax
    c186:	75 13                	jne    c19b <f52+0x5b>
    c188:	40 80 fe 02          	cmp    $0x2,%sil
    c18c:	75 0d                	jne    c19b <f52+0x5b>
    c18e:	48 8d 3c 11          	lea    (%rcx,%rdx,1),%rdi
    c192:	48 81 c7 28 02 00 00 	add    $0x228,%rdi
    c199:	eb 21                	jmp    c1bc <f52+0x7c>
    c19b:	40 80 fe 01          	cmp    $0x1,%sil
    c19f:	75 2e                	jne    c1cf <f52+0x8f>
    c1a1:	48 8d 34 11          	lea    (%rcx,%rdx,1),%rsi
    c1a5:	8b 4c 11 20          	mov    0x20(%rcx,%rdx,1),%ecx
    c1a9:	48 0f af c1          	imul   %rcx,%rax
    c1ad:	48 c1 e8 20          	shr    $0x20,%rax
    c1b1:	48 8d 3c 30          	lea    (%rax,%rsi,1),%rdi
    c1b5:	48 81 c7 28 02 00 00 	add    $0x228,%rdi
    c1bc:	0f b6 07             	movzbl (%rdi),%eax
    c1bf:	84 c0                	test   %al,%al
    c1c1:	74 0c                	je     c1cf <f52+0x8f>
    c1c3:	3c fe                	cmp    $0xfe,%al
    c1c5:	0f 83 cb 02 00 00    	jae    c496 <f52+0x356>
    c1cb:	fe c0                	inc    %al
    c1cd:	88 07                	mov    %al,(%rdi)
    c1cf:	4c 8b 7b 08          	mov    0x8(%rbx),%r15
    c1d3:	48 8b 7b 10          	mov    0x10(%rbx),%rdi
    c1d7:	48 8b 43 18          	mov    0x18(%rbx),%rax
    c1db:	4d 85 ff             	test   %r15,%r15
    c1de:	78 20                	js     c200 <f52+0xc0>
    c1e0:	48 8b 0f             	mov    (%rdi),%rcx
    c1e3:	48 ba ff ff ff ff ff 	movabs $0x7fffffffffffffff,%rdx
    c1ea:	ff ff 7f 
    c1ed:	48 21 ca             	and    %rcx,%rdx
    c1f0:	4c 39 fa             	cmp    %r15,%rdx
    c1f3:	76 0b                	jbe    c200 <f52+0xc0>
    c1f5:	48 85 c9             	test   %rcx,%rcx
    c1f8:	78 79                	js     c273 <f52+0x133>
    c1fa:	48 8d 4f 08          	lea    0x8(%rdi),%rcx
    c1fe:	eb 77                	jmp    c277 <f52+0x137>
    c200:	41 89 c6             	mov    %eax,%r14d
    c203:	e8 68 03 00 00       	call   c570 <fwp_drop7>
    c208:	4c 89 74 24 18       	mov    %r14,0x18(%rsp)
    c20d:	48 8d 54 24 18       	lea    0x18(%rsp),%rdx
    c212:	bf 01 00 00 00       	mov    $0x1,%edi
    c217:	be 01 00 00 00       	mov    $0x1,%esi
    c21c:	e8 ff da ff ff       	call   9d20 <fwp_data>
    c221:	49 89 c6             	mov    %rax,%r14
    c224:	48 2b 05 85 6f 00 00 	sub    0x6f85(%rip),%rax        # 131b0 <fwp_gc+0x1030>
    c22b:	48 8b 0d a6 6f 00 00 	mov    0x6fa6(%rip),%rcx        # 131d8 <fwp_gc+0x1058>
    c232:	48 c1 e1 10          	shl    $0x10,%rcx
    c236:	48 39 c8             	cmp    %rcx,%rax
    c239:	0f 83 42 02 00 00    	jae    c481 <f52+0x341>
    c23f:	48 8b 0d b2 6f 00 00 	mov    0x6fb2(%rip),%rcx        # 131f8 <fwp_gc+0x1078>
    c246:	48 89 c2             	mov    %rax,%rdx
    c249:	48 c1 ea 10          	shr    $0x10,%rdx
    c24d:	48 69 d2 28 12 00 00 	imul   $0x1228,%rdx,%rdx
    c254:	0f b6 34 11          	movzbl (%rcx,%rdx,1),%esi
    c258:	48 25 ff ff 00 00    	and    $0xffff,%rax
    c25e:	0f 85 ec 01 00 00    	jne    c450 <f52+0x310>
    c264:	40 80 fe 02          	cmp    $0x2,%sil
    c268:	0f 84 cb 01 00 00    	je     c439 <f52+0x2f9>
    c26e:	e9 dd 01 00 00       	jmp    c450 <f52+0x310>
    c273:	48 8b 4f 10          	mov    0x10(%rdi),%rcx
    c277:	89 44 24 0c          	mov    %eax,0xc(%rsp)
    c27b:	f3 42 0f 10 04 b9    	movss  (%rcx,%r15,4),%xmm0
    c281:	f3 0f 59 05 7b 2d 00 	mulss  0x2d7b(%rip),%xmm0        # f004 <_IO_stdin_used+0x4>
    c288:	00 
    c289:	f3 0f 58 05 77 2d 00 	addss  0x2d77(%rip),%xmm0        # f008 <_IO_stdin_used+0x8>
    c290:	00 
    c291:	f3 0f 11 44 24 08    	movss  %xmm0,0x8(%rsp)
    c297:	48 89 f8             	mov    %rdi,%rax
    c29a:	48 2b 05 0f 6f 00 00 	sub    0x6f0f(%rip),%rax        # 131b0 <fwp_gc+0x1030>
    c2a1:	49 ff c7             	inc    %r15
    c2a4:	48 8b 0d 2d 6f 00 00 	mov    0x6f2d(%rip),%rcx        # 131d8 <fwp_gc+0x1058>
    c2ab:	48 c1 e1 10          	shl    $0x10,%rcx
    c2af:	48 39 c8             	cmp    %rcx,%rax
    c2b2:	73 66                	jae    c31a <f52+0x1da>
    c2b4:	48 8b 0d 3d 6f 00 00 	mov    0x6f3d(%rip),%rcx        # 131f8 <fwp_gc+0x1078>
    c2bb:	48 89 c2             	mov    %rax,%rdx
    c2be:	48 c1 ea 10          	shr    $0x10,%rdx
    c2c2:	48 69 d2 28 12 00 00 	imul   $0x1228,%rdx,%rdx
    c2c9:	0f b6 34 11          	movzbl (%rcx,%rdx,1),%esi
    c2cd:	48 25 ff ff 00 00    	and    $0xffff,%rax
    c2d3:	75 12                	jne    c2e7 <f52+0x1a7>
    c2d5:	40 80 fe 02          	cmp    $0x2,%sil
    c2d9:	75 0c                	jne    c2e7 <f52+0x1a7>
    c2db:	48 8d 04 11          	lea    (%rcx,%rdx,1),%rax
    c2df:	48 05 28 02 00 00    	add    $0x228,%rax
    c2e5:	eb 1f                	jmp    c306 <f52+0x1c6>
    c2e7:	40 80 fe 01          	cmp    $0x1,%sil
    c2eb:	75 2d                	jne    c31a <f52+0x1da>
    c2ed:	48 8d 34 11          	lea    (%rcx,%rdx,1),%rsi
    c2f1:	8b 4c 11 20          	mov    0x20(%rcx,%rdx,1),%ecx
    c2f5:	48 0f af c1          	imul   %rcx,%rax
    c2f9:	48 c1 e8 20          	shr    $0x20,%rax
    c2fd:	48 01 f0             	add    %rsi,%rax
    c300:	48 05 28 02 00 00    	add    $0x228,%rax
    c306:	0f b6 08             	movzbl (%rax),%ecx
    c309:	84 c9                	test   %cl,%cl
    c30b:	74 0d                	je     c31a <f52+0x1da>
    c30d:	80 f9 fe             	cmp    $0xfe,%cl
    c310:	0f 83 8a 01 00 00    	jae    c4a0 <f52+0x360>
    c316:	fe c1                	inc    %cl
    c318:	88 08                	mov    %cl,(%rax)
    c31a:	49 89 fe             	mov    %rdi,%r14
    c31d:	e8 4e 02 00 00       	call   c570 <fwp_drop7>
    c322:	f3 0f 10 44 24 08    	movss  0x8(%rsp),%xmm0
    c328:	f3 0f 58 44 24 0c    	addss  0xc(%rsp),%xmm0
    c32e:	66 0f 7e c0          	movd   %xmm0,%eax
    c332:	4c 89 7c 24 18       	mov    %r15,0x18(%rsp)
    c337:	4c 89 74 24 20       	mov    %r14,0x20(%rsp)
    c33c:	48 89 44 24 28       	mov    %rax,0x28(%rsp)
    c341:	48 8d 54 24 18       	lea    0x18(%rsp),%rdx
    c346:	31 ff                	xor    %edi,%edi
    c348:	be 03 00 00 00       	mov    $0x3,%esi
    c34d:	e8 ce d9 ff ff       	call   9d20 <fwp_data>
    c352:	48 89 c1             	mov    %rax,%rcx
    c355:	48 2b 0d 54 6e 00 00 	sub    0x6e54(%rip),%rcx        # 131b0 <fwp_gc+0x1030>
    c35c:	48 8b 15 75 6e 00 00 	mov    0x6e75(%rip),%rdx        # 131d8 <fwp_gc+0x1058>
    c363:	48 c1 e2 10          	shl    $0x10,%rdx
    c367:	48 39 d1             	cmp    %rdx,%rcx
    c36a:	73 76                	jae    c3e2 <f52+0x2a2>
    c36c:	48 8b 15 85 6e 00 00 	mov    0x6e85(%rip),%rdx        # 131f8 <fwp_gc+0x1078>
    c373:	48 89 ce             	mov    %rcx,%rsi
    c376:	48 c1 ee 10          	shr    $0x10,%rsi
    c37a:	48 69 f6 28 12 00 00 	imul   $0x1228,%rsi,%rsi
    c381:	0f b6 3c 32          	movzbl (%rdx,%rsi,1),%edi
    c385:	48 81 e1 ff ff 00 00 	and    $0xffff,%rcx
    c38c:	75 1d                	jne    c3ab <f52+0x26b>
    c38e:	40 80 ff 02          	cmp    $0x2,%dil
    c392:	75 17                	jne    c3ab <f52+0x26b>
    c394:	4c 8d 34 32          	lea    (%rdx,%rsi,1),%r14
    c398:	49 81 c6 28 02 00 00 	add    $0x228,%r14
    c39f:	41 80 3e ff          	cmpb   $0xff,(%r14)
    c3a3:	74 2d                	je     c3d2 <f52+0x292>
    c3a5:	41 c6 06 01          	movb   $0x1,(%r14)
    c3a9:	eb 37                	jmp    c3e2 <f52+0x2a2>
    c3ab:	40 80 ff 01          	cmp    $0x1,%dil
    c3af:	75 31                	jne    c3e2 <f52+0x2a2>
    c3b1:	48 8d 3c 32          	lea    (%rdx,%rsi,1),%rdi
    c3b5:	8b 54 32 20          	mov    0x20(%rdx,%rsi,1),%edx
    c3b9:	48 0f af ca          	imul   %rdx,%rcx
    c3bd:	48 c1 e9 20          	shr    $0x20,%rcx
    c3c1:	4c 8d 34 39          	lea    (%rcx,%rdi,1),%r14
    c3c5:	49 81 c6 28 02 00 00 	add    $0x228,%r14
    c3cc:	41 80 3e ff          	cmpb   $0xff,(%r14)
    c3d0:	75 d3                	jne    c3a5 <f52+0x265>
    c3d2:	4c 89 f7             	mov    %r14,%rdi
    c3d5:	49 89 c7             	mov    %rax,%r15
    c3d8:	e8 73 9e ff ff       	call   6250 <fwp_rc_forget_slot>
    c3dd:	4c 89 f8             	mov    %r15,%rax
    c3e0:	eb c3                	jmp    c3a5 <f52+0x265>
    c3e2:	48 89 44 24 10       	mov    %rax,0x10(%rsp)
    c3e7:	48 8d 54 24 10       	lea    0x10(%rsp),%rdx
    c3ec:	31 ff                	xor    %edi,%edi
    c3ee:	be 01 00 00 00       	mov    $0x1,%esi
    c3f3:	e8 28 d9 ff ff       	call   9d20 <fwp_data>
    c3f8:	49 89 c6             	mov    %rax,%r14
    c3fb:	48 2b 05 ae 6d 00 00 	sub    0x6dae(%rip),%rax        # 131b0 <fwp_gc+0x1030>
    c402:	48 8b 0d cf 6d 00 00 	mov    0x6dcf(%rip),%rcx        # 131d8 <fwp_gc+0x1058>
    c409:	48 c1 e1 10          	shl    $0x10,%rcx
    c40d:	48 39 c8             	cmp    %rcx,%rax
    c410:	73 6f                	jae    c481 <f52+0x341>
    c412:	48 8b 0d df 6d 00 00 	mov    0x6ddf(%rip),%rcx        # 131f8 <fwp_gc+0x1078>
    c419:	48 89 c2             	mov    %rax,%rdx
    c41c:	48 c1 ea 10          	shr    $0x10,%rdx
    c420:	48 69 d2 28 12 00 00 	imul   $0x1228,%rdx,%rdx
    c427:	0f b6 34 11          	movzbl (%rcx,%rdx,1),%esi
    c42b:	48 25 ff ff 00 00    	and    $0xffff,%rax
    c431:	75 1d                	jne    c450 <f52+0x310>
    c433:	40 80 fe 02          	cmp    $0x2,%sil
    c437:	75 17                	jne    c450 <f52+0x310>
    c439:	4c 8d 3c 11          	lea    (%rcx,%rdx,1),%r15
    c43d:	49 81 c7 28 02 00 00 	add    $0x228,%r15
    c444:	41 80 3f ff          	cmpb   $0xff,(%r15)
    c448:	74 2d                	je     c477 <f52+0x337>
    c44a:	41 c6 07 01          	movb   $0x1,(%r15)
    c44e:	eb 31                	jmp    c481 <f52+0x341>
    c450:	40 80 fe 01          	cmp    $0x1,%sil
    c454:	75 2b                	jne    c481 <f52+0x341>
    c456:	48 8d 34 11          	lea    (%rcx,%rdx,1),%rsi
    c45a:	8b 4c 11 20          	mov    0x20(%rcx,%rdx,1),%ecx
    c45e:	48 0f af c1          	imul   %rcx,%rax
    c462:	48 c1 e8 20          	shr    $0x20,%rax
    c466:	4c 8d 3c 30          	lea    (%rax,%rsi,1),%r15
    c46a:	49 81 c7 28 02 00 00 	add    $0x228,%r15
    c471:	41 80 3f ff          	cmpb   $0xff,(%r15)
    c475:	75 d3                	jne    c44a <f52+0x30a>
    c477:	4c 89 ff             	mov    %r15,%rdi
    c47a:	e8 d1 9d ff ff       	call   6250 <fwp_rc_forget_slot>
    c47f:	eb c9                	jmp    c44a <f52+0x30a>
    c481:	48 89 df             	mov    %rbx,%rdi
    c484:	e8 37 00 00 00       	call   c4c0 <fwp_drop8>
    c489:	4c 89 f0             	mov    %r14,%rax
    c48c:	48 83 c4 30          	add    $0x30,%rsp
    c490:	5b                   	pop    %rbx
    c491:	41 5e                	pop    %r14
    c493:	41 5f                	pop    %r15
    c495:	c3                   	ret
    c496:	e8 95 b0 ff ff       	call   7530 <fwp_rc_wide_dup>
    c49b:	e9 2f fd ff ff       	jmp    c1cf <f52+0x8f>
    c4a0:	49 89 fe             	mov    %rdi,%r14
    c4a3:	48 89 c7             	mov    %rax,%rdi
    c4a6:	e8 85 b0 ff ff       	call   7530 <fwp_rc_wide_dup>
    c4ab:	4c 89 f7             	mov    %r14,%rdi
    c4ae:	e9 67 fe ff ff       	jmp    c31a <f52+0x1da>
    c4b3:	66 66 66 66 2e 0f 1f 	data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    c4ba:	84 00 00 00 00 00 

000000000000c4c0 <fwp_drop8>:
    c4c0:	48 89 f8             	mov    %rdi,%rax
    c4c3:	48 2b 05 e6 6c 00 00 	sub    0x6ce6(%rip),%rax        # 131b0 <fwp_gc+0x1030>
    c4ca:	48 8b 0d 07 6d 00 00 	mov    0x6d07(%rip),%rcx        # 131d8 <fwp_gc+0x1058>
    c4d1:	48 c1 e1 10          	shl    $0x10,%rcx
    c4d5:	48 39 c8             	cmp    %rcx,%rax
    c4d8:	0f 83 83 00 00 00    	jae    c561 <fwp_drop8+0xa1>
    c4de:	48 8b 0d 13 6d 00 00 	mov    0x6d13(%rip),%rcx        # 131f8 <fwp_gc+0x1078>
    c4e5:	48 89 c2             	mov    %rax,%rdx
    c4e8:	48 c1 ea 10          	shr    $0x10,%rdx
    c4ec:	48 69 d2 28 12 00 00 	imul   $0x1228,%rdx,%rdx
    c4f3:	0f b6 34 11          	movzbl (%rcx,%rdx,1),%esi
    c4f7:	48 25 ff ff 00 00    	and    $0xffff,%rax
    c4fd:	75 12                	jne    c511 <fwp_drop8+0x51>
    c4ff:	40 80 fe 02          	cmp    $0x2,%sil
    c503:	75 0c                	jne    c511 <fwp_drop8+0x51>
    c505:	48 8d 04 11          	lea    (%rcx,%rdx,1),%rax
    c509:	48 05 28 02 00 00    	add    $0x228,%rax
    c50f:	eb 1f                	jmp    c530 <fwp_drop8+0x70>
    c511:	40 80 fe 01          	cmp    $0x1,%sil
    c515:	75 4a                	jne    c561 <fwp_drop8+0xa1>
    c517:	48 8d 34 11          	lea    (%rcx,%rdx,1),%rsi
    c51b:	8b 4c 11 20          	mov    0x20(%rcx,%rdx,1),%ecx
    c51f:	48 0f af c1          	imul   %rcx,%rax
    c523:	48 c1 e8 20          	shr    $0x20,%rax
    c527:	48 01 f0             	add    %rsi,%rax
    c52a:	48 05 28 02 00 00    	add    $0x228,%rax
    c530:	0f b6 08             	movzbl (%rax),%ecx
    c533:	85 c9                	test   %ecx,%ecx
    c535:	74 2a                	je     c561 <fwp_drop8+0xa1>
    c537:	83 f9 01             	cmp    $0x1,%ecx
    c53a:	75 19                	jne    c555 <fwp_drop8+0x95>
    c53c:	53                   	push   %rbx
    c53d:	48 8b 47 10          	mov    0x10(%rdi),%rax
    c541:	48 89 fb             	mov    %rdi,%rbx
    c544:	48 89 c7             	mov    %rax,%rdi
    c547:	e8 24 00 00 00       	call   c570 <fwp_drop7>
    c54c:	48 89 df             	mov    %rbx,%rdi
    c54f:	5b                   	pop    %rbx
    c550:	e9 eb e2 ff ff       	jmp    a840 <fwp_rc_free_obj>
    c555:	81 f9 ff 00 00 00    	cmp    $0xff,%ecx
    c55b:	74 05                	je     c562 <fwp_drop8+0xa2>
    c55d:	fe c9                	dec    %cl
    c55f:	88 08                	mov    %cl,(%rax)
    c561:	c3                   	ret
    c562:	48 89 c7             	mov    %rax,%rdi
    c565:	e9 f6 df ff ff       	jmp    a560 <fwp_rc_wide_drop>
    c56a:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)

000000000000c570 <fwp_drop7>:
    c570:	53                   	push   %rbx
    c571:	48 89 f8             	mov    %rdi,%rax
    c574:	48 2b 05 35 6c 00 00 	sub    0x6c35(%rip),%rax        # 131b0 <fwp_gc+0x1030>
    c57b:	48 8b 0d 56 6c 00 00 	mov    0x6c56(%rip),%rcx        # 131d8 <fwp_gc+0x1058>
    c582:	48 c1 e1 10          	shl    $0x10,%rcx
    c586:	48 39 c8             	cmp    %rcx,%rax
    c589:	0f 83 9c 00 00 00    	jae    c62b <fwp_drop7+0xbb>
    c58f:	48 8b 0d 62 6c 00 00 	mov    0x6c62(%rip),%rcx        # 131f8 <fwp_gc+0x1078>
    c596:	48 89 c2             	mov    %rax,%rdx
    c599:	48 c1 ea 10          	shr    $0x10,%rdx
    c59d:	48 69 d2 28 12 00 00 	imul   $0x1228,%rdx,%rdx
    c5a4:	0f b6 34 11          	movzbl (%rcx,%rdx,1),%esi
    c5a8:	48 25 ff ff 00 00    	and    $0xffff,%rax
    c5ae:	75 20                	jne    c5d0 <fwp_drop7+0x60>
    c5b0:	40 80 fe 02          	cmp    $0x2,%sil
    c5b4:	75 1a                	jne    c5d0 <fwp_drop7+0x60>
    c5b6:	48 8d 04 11          	lea    (%rcx,%rdx,1),%rax
    c5ba:	48 05 28 02 00 00    	add    $0x228,%rax
    c5c0:	eb 2d                	jmp    c5ef <fwp_drop7+0x7f>
    c5c2:	66 66 66 66 66 2e 0f 	data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    c5c9:	1f 84 00 00 00 00 00 
    c5d0:	40 80 fe 01          	cmp    $0x1,%sil
    c5d4:	75 55                	jne    c62b <fwp_drop7+0xbb>
    c5d6:	48 8d 34 11          	lea    (%rcx,%rdx,1),%rsi
    c5da:	8b 4c 11 20          	mov    0x20(%rcx,%rdx,1),%ecx
    c5de:	48 0f af c1          	imul   %rcx,%rax
    c5e2:	48 c1 e8 20          	shr    $0x20,%rax
    c5e6:	48 01 f0             	add    %rsi,%rax
    c5e9:	48 05 28 02 00 00    	add    $0x228,%rax
    c5ef:	0f b6 08             	movzbl (%rax),%ecx
    c5f2:	85 c9                	test   %ecx,%ecx
    c5f4:	74 35                	je     c62b <fwp_drop7+0xbb>
    c5f6:	83 f9 01             	cmp    $0x1,%ecx
    c5f9:	75 32                	jne    c62d <fwp_drop7+0xbd>
    c5fb:	48 83 3f 00          	cmpq   $0x0,(%rdi)
    c5ff:	79 3a                	jns    c63b <fwp_drop7+0xcb>
    c601:	48 8b 5f 08          	mov    0x8(%rdi),%rbx
    c605:	e8 46 de ff ff       	call   a450 <fwp_rc_free_arr>
    c60a:	48 89 d8             	mov    %rbx,%rax
    c60d:	48 2b 05 9c 6b 00 00 	sub    0x6b9c(%rip),%rax        # 131b0 <fwp_gc+0x1030>
    c614:	48 8b 0d bd 6b 00 00 	mov    0x6bbd(%rip),%rcx        # 131d8 <fwp_gc+0x1058>
    c61b:	48 c1 e1 10          	shl    $0x10,%rcx
    c61f:	48 89 df             	mov    %rbx,%rdi
    c622:	48 39 c8             	cmp    %rcx,%rax
    c625:	0f 82 64 ff ff ff    	jb     c58f <fwp_drop7+0x1f>
    c62b:	5b                   	pop    %rbx
    c62c:	c3                   	ret
    c62d:	81 f9 ff 00 00 00    	cmp    $0xff,%ecx
    c633:	74 0c                	je     c641 <fwp_drop7+0xd1>
    c635:	fe c9                	dec    %cl
    c637:	88 08                	mov    %cl,(%rax)
    c639:	5b                   	pop    %rbx
    c63a:	c3                   	ret
    c63b:	5b                   	pop    %rbx
    c63c:	e9 0f de ff ff       	jmp    a450 <fwp_rc_free_arr>
    c641:	48 89 c7             	mov    %rax,%rdi
    c644:	5b                   	pop    %rbx
    c645:	e9 16 df ff ff       	jmp    a560 <fwp_rc_wide_drop>
    c64a:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)

000000000000c650 <fwp_owned_entry52>:
    c650:	48 8b 3f             	mov    (%rdi),%rdi
    c653:	e9 e8 fa ff ff       	jmp    c140 <f52>
    c658:	0f 1f 84 00 00 00 00 	nopl   0x0(%rax,%rax,1)
    c65f:	00 

000000000000c660 <fwp_caps52>:
    c660:	53                   	push   %rbx
    c661:	83 7f 04 00          	cmpl   $0x0,0x4(%rdi)
    c665:	74 56                	je     c6bd <fwp_caps52+0x5d>
    c667:	48 89 fb             	mov    %rdi,%rbx
    c66a:	48 8b 7f 08          	mov    0x8(%rdi),%rdi
    c66e:	85 f6                	test   %esi,%esi
    c670:	74 51                	je     c6c3 <fwp_caps52+0x63>
    c672:	48 2b 3d 37 6b 00 00 	sub    0x6b37(%rip),%rdi        # 131b0 <fwp_gc+0x1030>
    c679:	48 8b 05 58 6b 00 00 	mov    0x6b58(%rip),%rax        # 131d8 <fwp_gc+0x1058>
    c680:	48 c1 e0 10          	shl    $0x10,%rax
    c684:	48 39 c7             	cmp    %rax,%rdi
    c687:	73 38                	jae    c6c1 <fwp_caps52+0x61>
    c689:	48 8b 05 68 6b 00 00 	mov    0x6b68(%rip),%rax        # 131f8 <fwp_gc+0x1078>
    c690:	48 89 f9             	mov    %rdi,%rcx
    c693:	48 c1 e9 10          	shr    $0x10,%rcx
    c697:	48 69 c9 28 12 00 00 	imul   $0x1228,%rcx,%rcx
    c69e:	0f b6 14 08          	movzbl (%rax,%rcx,1),%edx
    c6a2:	48 81 e7 ff ff 00 00 	and    $0xffff,%rdi
    c6a9:	75 26                	jne    c6d1 <fwp_caps52+0x71>
    c6ab:	80 fa 02             	cmp    $0x2,%dl
    c6ae:	75 21                	jne    c6d1 <fwp_caps52+0x71>
    c6b0:	48 8d 3c 08          	lea    (%rax,%rcx,1),%rdi
    c6b4:	48 81 c7 28 02 00 00 	add    $0x228,%rdi
    c6bb:	eb 33                	jmp    c6f0 <fwp_caps52+0x90>
    c6bd:	85 f6                	test   %esi,%esi
    c6bf:	74 0a                	je     c6cb <fwp_caps52+0x6b>
    c6c1:	5b                   	pop    %rbx
    c6c2:	c3                   	ret
    c6c3:	e8 f8 fd ff ff       	call   c4c0 <fwp_drop8>
    c6c8:	48 89 df             	mov    %rbx,%rdi
    c6cb:	5b                   	pop    %rbx
    c6cc:	e9 6f e1 ff ff       	jmp    a840 <fwp_rc_free_obj>
    c6d1:	80 fa 01             	cmp    $0x1,%dl
    c6d4:	75 eb                	jne    c6c1 <fwp_caps52+0x61>
    c6d6:	48 8d 14 08          	lea    (%rax,%rcx,1),%rdx
    c6da:	8b 44 08 20          	mov    0x20(%rax,%rcx,1),%eax
    c6de:	48 0f af f8          	imul   %rax,%rdi
    c6e2:	48 c1 ef 20          	shr    $0x20,%rdi
    c6e6:	48 01 d7             	add    %rdx,%rdi
    c6e9:	48 81 c7 28 02 00 00 	add    $0x228,%rdi
    c6f0:	0f b6 07             	movzbl (%rdi),%eax
    c6f3:	84 c0                	test   %al,%al
    c6f5:	74 ca                	je     c6c1 <fwp_caps52+0x61>
    c6f7:	3c fe                	cmp    $0xfe,%al
    c6f9:	73 06                	jae    c701 <fwp_caps52+0xa1>
    c6fb:	fe c0                	inc    %al
    c6fd:	88 07                	mov    %al,(%rdi)
    c6ff:	5b                   	pop    %rbx
    c700:	c3                   	ret
    c701:	5b                   	pop    %rbx
    c702:	e9 29 ae ff ff       	jmp    7530 <fwp_rc_wide_dup>
    c707:	66 0f 1f 84 00 00 00 	nopw   0x0(%rax,%rax,1)
    c70e:	00 00 

000000000000c710 <fwp_args52>:
    c710:	85 f6                	test   %esi,%esi
    c712:	0f 85 8a 00 00 00    	jne    c7a2 <fwp_args52+0x92>
    c718:	85 d2                	test   %edx,%edx
    c71a:	0f 84 82 00 00 00    	je     c7a2 <fwp_args52+0x92>
    c720:	48 8b 07             	mov    (%rdi),%rax
    c723:	48 2b 05 86 6a 00 00 	sub    0x6a86(%rip),%rax        # 131b0 <fwp_gc+0x1030>
    c72a:	48 8b 0d a7 6a 00 00 	mov    0x6aa7(%rip),%rcx        # 131d8 <fwp_gc+0x1058>
    c731:	48 c1 e1 10          	shl    $0x10,%rcx
    c735:	48 39 c8             	cmp    %rcx,%rax
    c738:	73 68                	jae    c7a2 <fwp_args52+0x92>
    c73a:	48 8b 0d b7 6a 00 00 	mov    0x6ab7(%rip),%rcx        # 131f8 <fwp_gc+0x1078>
    c741:	48 89 c2             	mov    %rax,%rdx
    c744:	48 c1 ea 10          	shr    $0x10,%rdx
    c748:	48 69 d2 28 12 00 00 	imul   $0x1228,%rdx,%rdx
    c74f:	0f b6 34 11          	movzbl (%rcx,%rdx,1),%esi
    c753:	48 25 ff ff 00 00    	and    $0xffff,%rax
    c759:	75 13                	jne    c76e <fwp_args52+0x5e>
    c75b:	40 80 fe 02          	cmp    $0x2,%sil
    c75f:	75 0d                	jne    c76e <fwp_args52+0x5e>
    c761:	48 8d 3c 11          	lea    (%rcx,%rdx,1),%rdi
    c765:	48 81 c7 28 02 00 00 	add    $0x228,%rdi
    c76c:	eb 21                	jmp    c78f <fwp_args52+0x7f>
    c76e:	40 80 fe 01          	cmp    $0x1,%sil
    c772:	75 2e                	jne    c7a2 <fwp_args52+0x92>
    c774:	48 8d 34 11          	lea    (%rcx,%rdx,1),%rsi
    c778:	8b 4c 11 20          	mov    0x20(%rcx,%rdx,1),%ecx
    c77c:	48 0f af c1          	imul   %rcx,%rax
    c780:	48 c1 e8 20          	shr    $0x20,%rax
    c784:	48 8d 3c 30          	lea    (%rax,%rsi,1),%rdi
    c788:	48 81 c7 28 02 00 00 	add    $0x228,%rdi
    c78f:	0f b6 07             	movzbl (%rdi),%eax
    c792:	84 c0                	test   %al,%al
    c794:	74 0c                	je     c7a2 <fwp_args52+0x92>
    c796:	3c fe                	cmp    $0xfe,%al
    c798:	0f 83 92 ad ff ff    	jae    7530 <fwp_rc_wide_dup>
    c79e:	fe c0                	inc    %al
    c7a0:	88 07                	mov    %al,(%rdi)
    c7a2:	c3                   	ret
    c7a3:	66 66 66 66 2e 0f 1f 	data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    c7aa:	84 00 00 00 00 00 

000000000000c7b0 <fwp_arg_drop52>:
    c7b0:	85 f6                	test   %esi,%esi
    c7b2:	75 0c                	jne    c7c0 <fwp_arg_drop52+0x10>
    c7b4:	85 d2                	test   %edx,%edx
    c7b6:	74 08                	je     c7c0 <fwp_arg_drop52+0x10>
    c7b8:	48 8b 3f             	mov    (%rdi),%rdi
    c7bb:	e9 00 fd ff ff       	jmp    c4c0 <fwp_drop8>
    c7c0:	c3                   	ret
    c7c1:	66 66 66 66 66 66 2e 	data16 data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    c7c8:	0f 1f 84 00 00 00 00 
    c7cf:	00 

000000000000c7d0 <f55>:
    c7d0:	41 57                	push   %r15
    c7d2:	41 56                	push   %r14
    c7d4:	41 54                	push   %r12
    c7d6:	53                   	push   %rbx
    c7d7:	48 83 ec 78          	sub    $0x78,%rsp
    c7db:	48 89 fb             	mov    %rdi,%rbx
    c7de:	48 8b 47 10          	mov    0x10(%rdi),%rax
    c7e2:	48 2b 05 c7 69 00 00 	sub    0x69c7(%rip),%rax        # 131b0 <fwp_gc+0x1030>
    c7e9:	48 8b 0d e8 69 00 00 	mov    0x69e8(%rip),%rcx        # 131d8 <fwp_gc+0x1058>
    c7f0:	48 c1 e1 10          	shl    $0x10,%rcx
    c7f4:	48 39 c8             	cmp    %rcx,%rax
    c7f7:	73 68                	jae    c861 <f55+0x91>
    c7f9:	48 8b 0d f8 69 00 00 	mov    0x69f8(%rip),%rcx        # 131f8 <fwp_gc+0x1078>
    c800:	48 89 c2             	mov    %rax,%rdx
    c803:	48 c1 ea 10          	shr    $0x10,%rdx
    c807:	48 69 d2 28 12 00 00 	imul   $0x1228,%rdx,%rdx
    c80e:	0f b6 34 11          	movzbl (%rcx,%rdx,1),%esi
    c812:	48 25 ff ff 00 00    	and    $0xffff,%rax
    c818:	75 13                	jne    c82d <f55+0x5d>
    c81a:	40 80 fe 02          	cmp    $0x2,%sil
    c81e:	75 0d                	jne    c82d <f55+0x5d>
    c820:	48 8d 3c 11          	lea    (%rcx,%rdx,1),%rdi
    c824:	48 81 c7 28 02 00 00 	add    $0x228,%rdi
    c82b:	eb 21                	jmp    c84e <f55+0x7e>
    c82d:	40 80 fe 01          	cmp    $0x1,%sil
    c831:	75 2e                	jne    c861 <f55+0x91>
    c833:	48 8d 34 11          	lea    (%rcx,%rdx,1),%rsi
    c837:	8b 4c 11 20          	mov    0x20(%rcx,%rdx,1),%ecx
    c83b:	48 0f af c1          	imul   %rcx,%rax
    c83f:	48 c1 e8 20          	shr    $0x20,%rax
    c843:	48 8d 3c 30          	lea    (%rax,%rsi,1),%rdi
    c847:	48 81 c7 28 02 00 00 	add    $0x228,%rdi
    c84e:	0f b6 07             	movzbl (%rdi),%eax
    c851:	84 c0                	test   %al,%al
    c853:	74 0c                	je     c861 <f55+0x91>
    c855:	3c fe                	cmp    $0xfe,%al
    c857:	0f 83 bd 02 00 00    	jae    cb1a <f55+0x34a>
    c85d:	fe c0                	inc    %al
    c85f:	88 07                	mov    %al,(%rdi)
    c861:	4c 8b 63 08          	mov    0x8(%rbx),%r12
    c865:	4c 8b 73 10          	mov    0x10(%rbx),%r14
    c869:	4c 8b 7b 18          	mov    0x18(%rbx),%r15
    c86d:	4d 85 e4             	test   %r12,%r12
    c870:	78 20                	js     c892 <f55+0xc2>
    c872:	49 8b 06             	mov    (%r14),%rax
    c875:	48 b9 ff ff ff ff ff 	movabs $0x7fffffffffffffff,%rcx
    c87c:	ff ff 7f 
    c87f:	48 21 c1             	and    %rax,%rcx
    c882:	4c 39 e1             	cmp    %r12,%rcx
    c885:	76 0b                	jbe    c892 <f55+0xc2>
    c887:	48 85 c0             	test   %rax,%rax
    c88a:	78 79                	js     c905 <f55+0x135>
    c88c:	49 8d 46 08          	lea    0x8(%r14),%rax
    c890:	eb 77                	jmp    c909 <f55+0x139>
    c892:	4c 89 f7             	mov    %r14,%rdi
    c895:	e8 a6 03 00 00       	call   cc40 <fwp_drop9>
    c89a:	4c 89 7c 24 10       	mov    %r15,0x10(%rsp)
    c89f:	48 8d 54 24 10       	lea    0x10(%rsp),%rdx
    c8a4:	bf 01 00 00 00       	mov    $0x1,%edi
    c8a9:	be 01 00 00 00       	mov    $0x1,%esi
    c8ae:	e8 6d d4 ff ff       	call   9d20 <fwp_data>
    c8b3:	49 89 c6             	mov    %rax,%r14
    c8b6:	48 2b 05 f3 68 00 00 	sub    0x68f3(%rip),%rax        # 131b0 <fwp_gc+0x1030>
    c8bd:	48 8b 0d 14 69 00 00 	mov    0x6914(%rip),%rcx        # 131d8 <fwp_gc+0x1058>
    c8c4:	48 c1 e1 10          	shl    $0x10,%rcx
    c8c8:	48 39 c8             	cmp    %rcx,%rax
    c8cb:	0f 83 32 02 00 00    	jae    cb03 <f55+0x333>
    c8d1:	48 8b 0d 20 69 00 00 	mov    0x6920(%rip),%rcx        # 131f8 <fwp_gc+0x1078>
    c8d8:	48 89 c2             	mov    %rax,%rdx
    c8db:	48 c1 ea 10          	shr    $0x10,%rdx
    c8df:	48 69 d2 28 12 00 00 	imul   $0x1228,%rdx,%rdx
    c8e6:	0f b6 34 11          	movzbl (%rcx,%rdx,1),%esi
    c8ea:	48 25 ff ff 00 00    	and    $0xffff,%rax
    c8f0:	0f 85 dc 01 00 00    	jne    cad2 <f55+0x302>
    c8f6:	40 80 fe 02          	cmp    $0x2,%sil
    c8fa:	0f 84 bb 01 00 00    	je     cabb <f55+0x2eb>
    c900:	e9 cd 01 00 00       	jmp    cad2 <f55+0x302>
    c905:	49 8b 46 10          	mov    0x10(%r14),%rax
    c909:	4a 0f be 04 20       	movsbq (%rax,%r12,1),%rax
    c90e:	48 83 c0 81          	add    $0xffffffffffffff81,%rax
    c912:	48 3d ff fe ff ff    	cmp    $0xfffffffffffffeff,%rax
    c918:	0f 86 10 02 00 00    	jbe    cb2e <f55+0x35e>
    c91e:	4c 89 f0             	mov    %r14,%rax
    c921:	48 2b 05 88 68 00 00 	sub    0x6888(%rip),%rax        # 131b0 <fwp_gc+0x1030>
    c928:	48 8b 0d a9 68 00 00 	mov    0x68a9(%rip),%rcx        # 131d8 <fwp_gc+0x1058>
    c92f:	48 c1 e1 10          	shl    $0x10,%rcx
    c933:	48 39 c8             	cmp    %rcx,%rax
    c936:	73 68                	jae    c9a0 <f55+0x1d0>
    c938:	48 8b 0d b9 68 00 00 	mov    0x68b9(%rip),%rcx        # 131f8 <fwp_gc+0x1078>
    c93f:	48 89 c2             	mov    %rax,%rdx
    c942:	48 c1 ea 10          	shr    $0x10,%rdx
    c946:	48 69 d2 28 12 00 00 	imul   $0x1228,%rdx,%rdx
    c94d:	0f b6 34 11          	movzbl (%rcx,%rdx,1),%esi
    c951:	48 25 ff ff 00 00    	and    $0xffff,%rax
    c957:	75 13                	jne    c96c <f55+0x19c>
    c959:	40 80 fe 02          	cmp    $0x2,%sil
    c95d:	75 0d                	jne    c96c <f55+0x19c>
    c95f:	48 8d 3c 11          	lea    (%rcx,%rdx,1),%rdi
    c963:	48 81 c7 28 02 00 00 	add    $0x228,%rdi
    c96a:	eb 21                	jmp    c98d <f55+0x1bd>
    c96c:	40 80 fe 01          	cmp    $0x1,%sil
    c970:	75 2e                	jne    c9a0 <f55+0x1d0>
    c972:	48 8d 34 11          	lea    (%rcx,%rdx,1),%rsi
    c976:	8b 4c 11 20          	mov    0x20(%rcx,%rdx,1),%ecx
    c97a:	48 0f af c1          	imul   %rcx,%rax
    c97e:	48 c1 e8 20          	shr    $0x20,%rax
    c982:	48 8d 3c 30          	lea    (%rax,%rsi,1),%rdi
    c986:	48 81 c7 28 02 00 00 	add    $0x228,%rdi
    c98d:	0f b6 07             	movzbl (%rdi),%eax
    c990:	84 c0                	test   %al,%al
    c992:	74 0c                	je     c9a0 <f55+0x1d0>
    c994:	3c fe                	cmp    $0xfe,%al
    c996:	0f 83 88 01 00 00    	jae    cb24 <f55+0x354>
    c99c:	fe c0                	inc    %al
    c99e:	88 07                	mov    %al,(%rdi)
    c9a0:	4c 89 f7             	mov    %r14,%rdi
    c9a3:	e8 98 02 00 00       	call   cc40 <fwp_drop9>
    c9a8:	49 ff c7             	inc    %r15
    c9ab:	0f 80 8d 01 00 00    	jo     cb3e <f55+0x36e>
    c9b1:	49 ff c4             	inc    %r12
    c9b4:	4c 89 64 24 10       	mov    %r12,0x10(%rsp)
    c9b9:	4c 89 74 24 18       	mov    %r14,0x18(%rsp)
    c9be:	4c 89 7c 24 20       	mov    %r15,0x20(%rsp)
    c9c3:	48 8d 54 24 10       	lea    0x10(%rsp),%rdx
    c9c8:	31 ff                	xor    %edi,%edi
    c9ca:	be 03 00 00 00       	mov    $0x3,%esi
    c9cf:	e8 4c d3 ff ff       	call   9d20 <fwp_data>
    c9d4:	48 89 c1             	mov    %rax,%rcx
    c9d7:	48 2b 0d d2 67 00 00 	sub    0x67d2(%rip),%rcx        # 131b0 <fwp_gc+0x1030>
    c9de:	48 8b 15 f3 67 00 00 	mov    0x67f3(%rip),%rdx        # 131d8 <fwp_gc+0x1058>
    c9e5:	48 c1 e2 10          	shl    $0x10,%rdx
    c9e9:	48 39 d1             	cmp    %rdx,%rcx
    c9ec:	73 76                	jae    ca64 <f55+0x294>
    c9ee:	48 8b 15 03 68 00 00 	mov    0x6803(%rip),%rdx        # 131f8 <fwp_gc+0x1078>
    c9f5:	48 89 ce             	mov    %rcx,%rsi
    c9f8:	48 c1 ee 10          	shr    $0x10,%rsi
    c9fc:	48 69 f6 28 12 00 00 	imul   $0x1228,%rsi,%rsi
    ca03:	0f b6 3c 32          	movzbl (%rdx,%rsi,1),%edi
    ca07:	48 81 e1 ff ff 00 00 	and    $0xffff,%rcx
    ca0e:	75 1d                	jne    ca2d <f55+0x25d>
    ca10:	40 80 ff 02          	cmp    $0x2,%dil
    ca14:	75 17                	jne    ca2d <f55+0x25d>
    ca16:	4c 8d 34 32          	lea    (%rdx,%rsi,1),%r14
    ca1a:	49 81 c6 28 02 00 00 	add    $0x228,%r14
    ca21:	41 80 3e ff          	cmpb   $0xff,(%r14)
    ca25:	74 2d                	je     ca54 <f55+0x284>
    ca27:	41 c6 06 01          	movb   $0x1,(%r14)
    ca2b:	eb 37                	jmp    ca64 <f55+0x294>
    ca2d:	40 80 ff 01          	cmp    $0x1,%dil
    ca31:	75 31                	jne    ca64 <f55+0x294>
    ca33:	48 8d 3c 32          	lea    (%rdx,%rsi,1),%rdi
    ca37:	8b 54 32 20          	mov    0x20(%rdx,%rsi,1),%edx
    ca3b:	48 0f af ca          	imul   %rdx,%rcx
    ca3f:	48 c1 e9 20          	shr    $0x20,%rcx
    ca43:	4c 8d 34 39          	lea    (%rcx,%rdi,1),%r14
    ca47:	49 81 c6 28 02 00 00 	add    $0x228,%r14
    ca4e:	41 80 3e ff          	cmpb   $0xff,(%r14)
    ca52:	75 d3                	jne    ca27 <f55+0x257>
    ca54:	4c 89 f7             	mov    %r14,%rdi
    ca57:	49 89 c7             	mov    %rax,%r15
    ca5a:	e8 f1 97 ff ff       	call   6250 <fwp_rc_forget_slot>
    ca5f:	4c 89 f8             	mov    %r15,%rax
    ca62:	eb c3                	jmp    ca27 <f55+0x257>
    ca64:	48 89 44 24 08       	mov    %rax,0x8(%rsp)
    ca69:	48 8d 54 24 08       	lea    0x8(%rsp),%rdx
    ca6e:	31 ff                	xor    %edi,%edi
    ca70:	be 01 00 00 00       	mov    $0x1,%esi
    ca75:	e8 a6 d2 ff ff       	call   9d20 <fwp_data>
    ca7a:	49 89 c6             	mov    %rax,%r14
    ca7d:	48 2b 05 2c 67 00 00 	sub    0x672c(%rip),%rax        # 131b0 <fwp_gc+0x1030>
    ca84:	48 8b 0d 4d 67 00 00 	mov    0x674d(%rip),%rcx        # 131d8 <fwp_gc+0x1058>
    ca8b:	48 c1 e1 10          	shl    $0x10,%rcx
    ca8f:	48 39 c8             	cmp    %rcx,%rax
    ca92:	73 6f                	jae    cb03 <f55+0x333>
    ca94:	48 8b 0d 5d 67 00 00 	mov    0x675d(%rip),%rcx        # 131f8 <fwp_gc+0x1078>
    ca9b:	48 89 c2             	mov    %rax,%rdx
    ca9e:	48 c1 ea 10          	shr    $0x10,%rdx
    caa2:	48 69 d2 28 12 00 00 	imul   $0x1228,%rdx,%rdx
    caa9:	0f b6 34 11          	movzbl (%rcx,%rdx,1),%esi
    caad:	48 25 ff ff 00 00    	and    $0xffff,%rax
    cab3:	75 1d                	jne    cad2 <f55+0x302>
    cab5:	40 80 fe 02          	cmp    $0x2,%sil
    cab9:	75 17                	jne    cad2 <f55+0x302>
    cabb:	4c 8d 3c 11          	lea    (%rcx,%rdx,1),%r15
    cabf:	49 81 c7 28 02 00 00 	add    $0x228,%r15
    cac6:	41 80 3f ff          	cmpb   $0xff,(%r15)
    caca:	74 2d                	je     caf9 <f55+0x329>
    cacc:	41 c6 07 01          	movb   $0x1,(%r15)
    cad0:	eb 31                	jmp    cb03 <f55+0x333>
    cad2:	40 80 fe 01          	cmp    $0x1,%sil
    cad6:	75 2b                	jne    cb03 <f55+0x333>
    cad8:	48 8d 34 11          	lea    (%rcx,%rdx,1),%rsi
    cadc:	8b 4c 11 20          	mov    0x20(%rcx,%rdx,1),%ecx
    cae0:	48 0f af c1          	imul   %rcx,%rax
    cae4:	48 c1 e8 20          	shr    $0x20,%rax
    cae8:	4c 8d 3c 30          	lea    (%rax,%rsi,1),%r15
    caec:	49 81 c7 28 02 00 00 	add    $0x228,%r15
    caf3:	41 80 3f ff          	cmpb   $0xff,(%r15)
    caf7:	75 d3                	jne    cacc <f55+0x2fc>
    caf9:	4c 89 ff             	mov    %r15,%rdi
    cafc:	e8 4f 97 ff ff       	call   6250 <fwp_rc_forget_slot>
    cb01:	eb c9                	jmp    cacc <f55+0x2fc>
    cb03:	48 89 df             	mov    %rbx,%rdi
    cb06:	e8 85 00 00 00       	call   cb90 <fwp_drop10>
    cb0b:	4c 89 f0             	mov    %r14,%rax
    cb0e:	48 83 c4 78          	add    $0x78,%rsp
    cb12:	5b                   	pop    %rbx
    cb13:	41 5c                	pop    %r12
    cb15:	41 5e                	pop    %r14
    cb17:	41 5f                	pop    %r15
    cb19:	c3                   	ret
    cb1a:	e8 11 aa ff ff       	call   7530 <fwp_rc_wide_dup>
    cb1f:	e9 3d fd ff ff       	jmp    c861 <f55+0x91>
    cb24:	e8 07 aa ff ff       	call   7530 <fwp_rc_wide_dup>
    cb29:	e9 72 fe ff ff       	jmp    c9a0 <f55+0x1d0>
    cb2e:	48 8d 15 56 2b 00 00 	lea    0x2b56(%rip),%rdx        # f68b <fwp_segv.msg+0x44b>
    cb35:	48 8d 0d 67 2a 00 00 	lea    0x2a67(%rip),%rcx        # f5a3 <fwp_segv.msg+0x363>
    cb3c:	eb 0e                	jmp    cb4c <f55+0x37c>
    cb3e:	48 8d 15 46 2b 00 00 	lea    0x2b46(%rip),%rdx        # f68b <fwp_segv.msg+0x44b>
    cb45:	48 8d 0d 59 2b 00 00 	lea    0x2b59(%rip),%rcx        # f6a5 <fwp_segv.msg+0x465>
    cb4c:	48 8d 5c 24 10       	lea    0x10(%rsp),%rbx
    cb51:	be 60 00 00 00       	mov    $0x60,%esi
    cb56:	48 89 df             	mov    %rbx,%rdi
    cb59:	31 c0                	xor    %eax,%eax
    cb5b:	e8 b0 55 ff ff       	call   2110 <snprintf@plt>
    cb60:	e8 bb 96 ff ff       	call   6220 <fwp_flush>
    cb65:	48 8b 05 74 54 00 00 	mov    0x5474(%rip),%rax        # 11fe0 <stderr@GLIBC_2.2.5>
    cb6c:	48 8b 38             	mov    (%rax),%rdi
    cb6f:	48 8d 35 b7 28 00 00 	lea    0x28b7(%rip),%rsi        # f42d <fwp_segv.msg+0x1ed>
    cb76:	48 89 da             	mov    %rbx,%rdx
    cb79:	31 c0                	xor    %eax,%eax
    cb7b:	e8 30 56 ff ff       	call   21b0 <fprintf@plt>
    cb80:	bf 65 00 00 00       	mov    $0x65,%edi
    cb85:	e8 06 57 ff ff       	call   2290 <exit@plt>
    cb8a:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)

000000000000cb90 <fwp_drop10>:
    cb90:	48 89 f8             	mov    %rdi,%rax
    cb93:	48 2b 05 16 66 00 00 	sub    0x6616(%rip),%rax        # 131b0 <fwp_gc+0x1030>
    cb9a:	48 8b 0d 37 66 00 00 	mov    0x6637(%rip),%rcx        # 131d8 <fwp_gc+0x1058>
    cba1:	48 c1 e1 10          	shl    $0x10,%rcx
    cba5:	48 39 c8             	cmp    %rcx,%rax
    cba8:	0f 83 83 00 00 00    	jae    cc31 <fwp_drop10+0xa1>
    cbae:	48 8b 0d 43 66 00 00 	mov    0x6643(%rip),%rcx        # 131f8 <fwp_gc+0x1078>
    cbb5:	48 89 c2             	mov    %rax,%rdx
    cbb8:	48 c1 ea 10          	shr    $0x10,%rdx
    cbbc:	48 69 d2 28 12 00 00 	imul   $0x1228,%rdx,%rdx
    cbc3:	0f b6 34 11          	movzbl (%rcx,%rdx,1),%esi
    cbc7:	48 25 ff ff 00 00    	and    $0xffff,%rax
    cbcd:	75 12                	jne    cbe1 <fwp_drop10+0x51>
    cbcf:	40 80 fe 02          	cmp    $0x2,%sil
    cbd3:	75 0c                	jne    cbe1 <fwp_drop10+0x51>
    cbd5:	48 8d 04 11          	lea    (%rcx,%rdx,1),%rax
    cbd9:	48 05 28 02 00 00    	add    $0x228,%rax
    cbdf:	eb 1f                	jmp    cc00 <fwp_drop10+0x70>
    cbe1:	40 80 fe 01          	cmp    $0x1,%sil
    cbe5:	75 4a                	jne    cc31 <fwp_drop10+0xa1>
    cbe7:	48 8d 34 11          	lea    (%rcx,%rdx,1),%rsi
    cbeb:	8b 4c 11 20          	mov    0x20(%rcx,%rdx,1),%ecx
    cbef:	48 0f af c1          	imul   %rcx,%rax
    cbf3:	48 c1 e8 20          	shr    $0x20,%rax
    cbf7:	48 01 f0             	add    %rsi,%rax
    cbfa:	48 05 28 02 00 00    	add    $0x228,%rax
    cc00:	0f b6 08             	movzbl (%rax),%ecx
    cc03:	85 c9                	test   %ecx,%ecx
    cc05:	74 2a                	je     cc31 <fwp_drop10+0xa1>
    cc07:	83 f9 01             	cmp    $0x1,%ecx
    cc0a:	75 19                	jne    cc25 <fwp_drop10+0x95>
    cc0c:	53                   	push   %rbx
    cc0d:	48 8b 47 10          	mov    0x10(%rdi),%rax
    cc11:	48 89 fb             	mov    %rdi,%rbx
    cc14:	48 89 c7             	mov    %rax,%rdi
    cc17:	e8 24 00 00 00       	call   cc40 <fwp_drop9>
    cc1c:	48 89 df             	mov    %rbx,%rdi
    cc1f:	5b                   	pop    %rbx
    cc20:	e9 1b dc ff ff       	jmp    a840 <fwp_rc_free_obj>
    cc25:	81 f9 ff 00 00 00    	cmp    $0xff,%ecx
    cc2b:	74 05                	je     cc32 <fwp_drop10+0xa2>
    cc2d:	fe c9                	dec    %cl
    cc2f:	88 08                	mov    %cl,(%rax)
    cc31:	c3                   	ret
    cc32:	48 89 c7             	mov    %rax,%rdi
    cc35:	e9 26 d9 ff ff       	jmp    a560 <fwp_rc_wide_drop>
    cc3a:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)

000000000000cc40 <fwp_drop9>:
    cc40:	53                   	push   %rbx
    cc41:	48 89 f8             	mov    %rdi,%rax
    cc44:	48 2b 05 65 65 00 00 	sub    0x6565(%rip),%rax        # 131b0 <fwp_gc+0x1030>
    cc4b:	48 8b 0d 86 65 00 00 	mov    0x6586(%rip),%rcx        # 131d8 <fwp_gc+0x1058>
    cc52:	48 c1 e1 10          	shl    $0x10,%rcx
    cc56:	48 39 c8             	cmp    %rcx,%rax
    cc59:	0f 83 9c 00 00 00    	jae    ccfb <fwp_drop9+0xbb>
    cc5f:	48 8b 0d 92 65 00 00 	mov    0x6592(%rip),%rcx        # 131f8 <fwp_gc+0x1078>
    cc66:	48 89 c2             	mov    %rax,%rdx
    cc69:	48 c1 ea 10          	shr    $0x10,%rdx
    cc6d:	48 69 d2 28 12 00 00 	imul   $0x1228,%rdx,%rdx
    cc74:	0f b6 34 11          	movzbl (%rcx,%rdx,1),%esi
    cc78:	48 25 ff ff 00 00    	and    $0xffff,%rax
    cc7e:	75 20                	jne    cca0 <fwp_drop9+0x60>
    cc80:	40 80 fe 02          	cmp    $0x2,%sil
    cc84:	75 1a                	jne    cca0 <fwp_drop9+0x60>
    cc86:	48 8d 04 11          	lea    (%rcx,%rdx,1),%rax
    cc8a:	48 05 28 02 00 00    	add    $0x228,%rax
    cc90:	eb 2d                	jmp    ccbf <fwp_drop9+0x7f>
    cc92:	66 66 66 66 66 2e 0f 	data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    cc99:	1f 84 00 00 00 00 00 
    cca0:	40 80 fe 01          	cmp    $0x1,%sil
    cca4:	75 55                	jne    ccfb <fwp_drop9+0xbb>
    cca6:	48 8d 34 11          	lea    (%rcx,%rdx,1),%rsi
    ccaa:	8b 4c 11 20          	mov    0x20(%rcx,%rdx,1),%ecx
    ccae:	48 0f af c1          	imul   %rcx,%rax
    ccb2:	48 c1 e8 20          	shr    $0x20,%rax
    ccb6:	48 01 f0             	add    %rsi,%rax
    ccb9:	48 05 28 02 00 00    	add    $0x228,%rax
    ccbf:	0f b6 08             	movzbl (%rax),%ecx
    ccc2:	85 c9                	test   %ecx,%ecx
    ccc4:	74 35                	je     ccfb <fwp_drop9+0xbb>
    ccc6:	83 f9 01             	cmp    $0x1,%ecx
    ccc9:	75 32                	jne    ccfd <fwp_drop9+0xbd>
    cccb:	48 83 3f 00          	cmpq   $0x0,(%rdi)
    cccf:	79 3a                	jns    cd0b <fwp_drop9+0xcb>
    ccd1:	48 8b 5f 08          	mov    0x8(%rdi),%rbx
    ccd5:	e8 76 d7 ff ff       	call   a450 <fwp_rc_free_arr>
    ccda:	48 89 d8             	mov    %rbx,%rax
    ccdd:	48 2b 05 cc 64 00 00 	sub    0x64cc(%rip),%rax        # 131b0 <fwp_gc+0x1030>
    cce4:	48 8b 0d ed 64 00 00 	mov    0x64ed(%rip),%rcx        # 131d8 <fwp_gc+0x1058>
    cceb:	48 c1 e1 10          	shl    $0x10,%rcx
    ccef:	48 89 df             	mov    %rbx,%rdi
    ccf2:	48 39 c8             	cmp    %rcx,%rax
    ccf5:	0f 82 64 ff ff ff    	jb     cc5f <fwp_drop9+0x1f>
    ccfb:	5b                   	pop    %rbx
    ccfc:	c3                   	ret
    ccfd:	81 f9 ff 00 00 00    	cmp    $0xff,%ecx
    cd03:	74 0c                	je     cd11 <fwp_drop9+0xd1>
    cd05:	fe c9                	dec    %cl
    cd07:	88 08                	mov    %cl,(%rax)
    cd09:	5b                   	pop    %rbx
    cd0a:	c3                   	ret
    cd0b:	5b                   	pop    %rbx
    cd0c:	e9 3f d7 ff ff       	jmp    a450 <fwp_rc_free_arr>
    cd11:	48 89 c7             	mov    %rax,%rdi
    cd14:	5b                   	pop    %rbx
    cd15:	e9 46 d8 ff ff       	jmp    a560 <fwp_rc_wide_drop>
    cd1a:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)

000000000000cd20 <fwp_owned_entry55>:
    cd20:	48 8b 3f             	mov    (%rdi),%rdi
    cd23:	e9 a8 fa ff ff       	jmp    c7d0 <f55>
    cd28:	0f 1f 84 00 00 00 00 	nopl   0x0(%rax,%rax,1)
    cd2f:	00 

000000000000cd30 <fwp_caps55>:
    cd30:	53                   	push   %rbx
    cd31:	83 7f 04 00          	cmpl   $0x0,0x4(%rdi)
    cd35:	74 56                	je     cd8d <fwp_caps55+0x5d>
    cd37:	48 89 fb             	mov    %rdi,%rbx
    cd3a:	48 8b 7f 08          	mov    0x8(%rdi),%rdi
    cd3e:	85 f6                	test   %esi,%esi
    cd40:	74 51                	je     cd93 <fwp_caps55+0x63>
    cd42:	48 2b 3d 67 64 00 00 	sub    0x6467(%rip),%rdi        # 131b0 <fwp_gc+0x1030>
    cd49:	48 8b 05 88 64 00 00 	mov    0x6488(%rip),%rax        # 131d8 <fwp_gc+0x1058>
    cd50:	48 c1 e0 10          	shl    $0x10,%rax
    cd54:	48 39 c7             	cmp    %rax,%rdi
    cd57:	73 38                	jae    cd91 <fwp_caps55+0x61>
    cd59:	48 8b 05 98 64 00 00 	mov    0x6498(%rip),%rax        # 131f8 <fwp_gc+0x1078>
    cd60:	48 89 f9             	mov    %rdi,%rcx
    cd63:	48 c1 e9 10          	shr    $0x10,%rcx
    cd67:	48 69 c9 28 12 00 00 	imul   $0x1228,%rcx,%rcx
    cd6e:	0f b6 14 08          	movzbl (%rax,%rcx,1),%edx
    cd72:	48 81 e7 ff ff 00 00 	and    $0xffff,%rdi
    cd79:	75 26                	jne    cda1 <fwp_caps55+0x71>
    cd7b:	80 fa 02             	cmp    $0x2,%dl
    cd7e:	75 21                	jne    cda1 <fwp_caps55+0x71>
    cd80:	48 8d 3c 08          	lea    (%rax,%rcx,1),%rdi
    cd84:	48 81 c7 28 02 00 00 	add    $0x228,%rdi
    cd8b:	eb 33                	jmp    cdc0 <fwp_caps55+0x90>
    cd8d:	85 f6                	test   %esi,%esi
    cd8f:	74 0a                	je     cd9b <fwp_caps55+0x6b>
    cd91:	5b                   	pop    %rbx
    cd92:	c3                   	ret
    cd93:	e8 f8 fd ff ff       	call   cb90 <fwp_drop10>
    cd98:	48 89 df             	mov    %rbx,%rdi
    cd9b:	5b                   	pop    %rbx
    cd9c:	e9 9f da ff ff       	jmp    a840 <fwp_rc_free_obj>
    cda1:	80 fa 01             	cmp    $0x1,%dl
    cda4:	75 eb                	jne    cd91 <fwp_caps55+0x61>
    cda6:	48 8d 14 08          	lea    (%rax,%rcx,1),%rdx
    cdaa:	8b 44 08 20          	mov    0x20(%rax,%rcx,1),%eax
    cdae:	48 0f af f8          	imul   %rax,%rdi
    cdb2:	48 c1 ef 20          	shr    $0x20,%rdi
    cdb6:	48 01 d7             	add    %rdx,%rdi
    cdb9:	48 81 c7 28 02 00 00 	add    $0x228,%rdi
    cdc0:	0f b6 07             	movzbl (%rdi),%eax
    cdc3:	84 c0                	test   %al,%al
    cdc5:	74 ca                	je     cd91 <fwp_caps55+0x61>
    cdc7:	3c fe                	cmp    $0xfe,%al
    cdc9:	73 06                	jae    cdd1 <fwp_caps55+0xa1>
    cdcb:	fe c0                	inc    %al
    cdcd:	88 07                	mov    %al,(%rdi)
    cdcf:	5b                   	pop    %rbx
    cdd0:	c3                   	ret
    cdd1:	5b                   	pop    %rbx
    cdd2:	e9 59 a7 ff ff       	jmp    7530 <fwp_rc_wide_dup>
    cdd7:	66 0f 1f 84 00 00 00 	nopw   0x0(%rax,%rax,1)
    cdde:	00 00 

000000000000cde0 <fwp_args55>:
    cde0:	85 f6                	test   %esi,%esi
    cde2:	0f 85 8a 00 00 00    	jne    ce72 <fwp_args55+0x92>
    cde8:	85 d2                	test   %edx,%edx
    cdea:	0f 84 82 00 00 00    	je     ce72 <fwp_args55+0x92>
    cdf0:	48 8b 07             	mov    (%rdi),%rax
    cdf3:	48 2b 05 b6 63 00 00 	sub    0x63b6(%rip),%rax        # 131b0 <fwp_gc+0x1030>
    cdfa:	48 8b 0d d7 63 00 00 	mov    0x63d7(%rip),%rcx        # 131d8 <fwp_gc+0x1058>
    ce01:	48 c1 e1 10          	shl    $0x10,%rcx
    ce05:	48 39 c8             	cmp    %rcx,%rax
    ce08:	73 68                	jae    ce72 <fwp_args55+0x92>
    ce0a:	48 8b 0d e7 63 00 00 	mov    0x63e7(%rip),%rcx        # 131f8 <fwp_gc+0x1078>
    ce11:	48 89 c2             	mov    %rax,%rdx
    ce14:	48 c1 ea 10          	shr    $0x10,%rdx
    ce18:	48 69 d2 28 12 00 00 	imul   $0x1228,%rdx,%rdx
    ce1f:	0f b6 34 11          	movzbl (%rcx,%rdx,1),%esi
    ce23:	48 25 ff ff 00 00    	and    $0xffff,%rax
    ce29:	75 13                	jne    ce3e <fwp_args55+0x5e>
    ce2b:	40 80 fe 02          	cmp    $0x2,%sil
    ce2f:	75 0d                	jne    ce3e <fwp_args55+0x5e>
    ce31:	48 8d 3c 11          	lea    (%rcx,%rdx,1),%rdi
    ce35:	48 81 c7 28 02 00 00 	add    $0x228,%rdi
    ce3c:	eb 21                	jmp    ce5f <fwp_args55+0x7f>
    ce3e:	40 80 fe 01          	cmp    $0x1,%sil
    ce42:	75 2e                	jne    ce72 <fwp_args55+0x92>
    ce44:	48 8d 34 11          	lea    (%rcx,%rdx,1),%rsi
    ce48:	8b 4c 11 20          	mov    0x20(%rcx,%rdx,1),%ecx
    ce4c:	48 0f af c1          	imul   %rcx,%rax
    ce50:	48 c1 e8 20          	shr    $0x20,%rax
    ce54:	48 8d 3c 30          	lea    (%rax,%rsi,1),%rdi
    ce58:	48 81 c7 28 02 00 00 	add    $0x228,%rdi
    ce5f:	0f b6 07             	movzbl (%rdi),%eax
    ce62:	84 c0                	test   %al,%al
    ce64:	74 0c                	je     ce72 <fwp_args55+0x92>
    ce66:	3c fe                	cmp    $0xfe,%al
    ce68:	0f 83 c2 a6 ff ff    	jae    7530 <fwp_rc_wide_dup>
    ce6e:	fe c0                	inc    %al
    ce70:	88 07                	mov    %al,(%rdi)
    ce72:	c3                   	ret
    ce73:	66 66 66 66 2e 0f 1f 	data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    ce7a:	84 00 00 00 00 00 

000000000000ce80 <fwp_arg_drop55>:
    ce80:	85 f6                	test   %esi,%esi
    ce82:	75 0c                	jne    ce90 <fwp_arg_drop55+0x10>
    ce84:	85 d2                	test   %edx,%edx
    ce86:	74 08                	je     ce90 <fwp_arg_drop55+0x10>
    ce88:	48 8b 3f             	mov    (%rdi),%rdi
    ce8b:	e9 00 fd ff ff       	jmp    cb90 <fwp_drop10>
    ce90:	c3                   	ret
    ce91:	66 66 66 66 66 66 2e 	data16 data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    ce98:	0f 1f 84 00 00 00 00 
    ce9f:	00 

000000000000cea0 <f57>:
    cea0:	41 57                	push   %r15
    cea2:	41 56                	push   %r14
    cea4:	41 55                	push   %r13
    cea6:	41 54                	push   %r12
    cea8:	53                   	push   %rbx
    cea9:	48 83 ec 70          	sub    $0x70,%rsp
    cead:	48 89 fb             	mov    %rdi,%rbx
    ceb0:	48 8b 47 10          	mov    0x10(%rdi),%rax
    ceb4:	48 2b 05 f5 62 00 00 	sub    0x62f5(%rip),%rax        # 131b0 <fwp_gc+0x1030>
    cebb:	48 8b 0d 16 63 00 00 	mov    0x6316(%rip),%rcx        # 131d8 <fwp_gc+0x1058>
    cec2:	48 c1 e1 10          	shl    $0x10,%rcx
    cec6:	48 39 c8             	cmp    %rcx,%rax
    cec9:	73 68                	jae    cf33 <f57+0x93>
    cecb:	48 8b 0d 26 63 00 00 	mov    0x6326(%rip),%rcx        # 131f8 <fwp_gc+0x1078>
    ced2:	48 89 c2             	mov    %rax,%rdx
    ced5:	48 c1 ea 10          	shr    $0x10,%rdx
    ced9:	48 69 d2 28 12 00 00 	imul   $0x1228,%rdx,%rdx
    cee0:	0f b6 34 11          	movzbl (%rcx,%rdx,1),%esi
    cee4:	48 25 ff ff 00 00    	and    $0xffff,%rax
    ceea:	75 13                	jne    ceff <f57+0x5f>
    ceec:	40 80 fe 02          	cmp    $0x2,%sil
    cef0:	75 0d                	jne    ceff <f57+0x5f>
    cef2:	48 8d 3c 11          	lea    (%rcx,%rdx,1),%rdi
    cef6:	48 81 c7 28 02 00 00 	add    $0x228,%rdi
    cefd:	eb 21                	jmp    cf20 <f57+0x80>
    ceff:	40 80 fe 01          	cmp    $0x1,%sil
    cf03:	75 2e                	jne    cf33 <f57+0x93>
    cf05:	48 8d 34 11          	lea    (%rcx,%rdx,1),%rsi
    cf09:	8b 4c 11 20          	mov    0x20(%rcx,%rdx,1),%ecx
    cf0d:	48 0f af c1          	imul   %rcx,%rax
    cf11:	48 c1 e8 20          	shr    $0x20,%rax
    cf15:	48 8d 3c 30          	lea    (%rax,%rsi,1),%rdi
    cf19:	48 81 c7 28 02 00 00 	add    $0x228,%rdi
    cf20:	0f b6 07             	movzbl (%rdi),%eax
    cf23:	84 c0                	test   %al,%al
    cf25:	74 0c                	je     cf33 <f57+0x93>
    cf27:	3c fe                	cmp    $0xfe,%al
    cf29:	0f 83 cb 02 00 00    	jae    d1fa <f57+0x35a>
    cf2f:	fe c0                	inc    %al
    cf31:	88 07                	mov    %al,(%rdi)
    cf33:	4c 8b 7b 08          	mov    0x8(%rbx),%r15
    cf37:	4c 8b 73 10          	mov    0x10(%rbx),%r14
    cf3b:	4c 0f be 63 18       	movsbq 0x18(%rbx),%r12
    cf40:	4d 85 ff             	test   %r15,%r15
    cf43:	78 20                	js     cf65 <f57+0xc5>
    cf45:	49 8b 06             	mov    (%r14),%rax
    cf48:	48 b9 ff ff ff ff ff 	movabs $0x7fffffffffffffff,%rcx
    cf4f:	ff ff 7f 
    cf52:	48 21 c1             	and    %rax,%rcx
    cf55:	4c 39 f9             	cmp    %r15,%rcx
    cf58:	76 0b                	jbe    cf65 <f57+0xc5>
    cf5a:	48 85 c0             	test   %rax,%rax
    cf5d:	78 79                	js     cfd8 <f57+0x138>
    cf5f:	49 8d 46 08          	lea    0x8(%r14),%rax
    cf63:	eb 77                	jmp    cfdc <f57+0x13c>
    cf65:	4c 89 f7             	mov    %r14,%rdi
    cf68:	e8 d3 fc ff ff       	call   cc40 <fwp_drop9>
    cf6d:	4c 89 64 24 10       	mov    %r12,0x10(%rsp)
    cf72:	48 8d 54 24 10       	lea    0x10(%rsp),%rdx
    cf77:	bf 01 00 00 00       	mov    $0x1,%edi
    cf7c:	be 01 00 00 00       	mov    $0x1,%esi
    cf81:	e8 9a cd ff ff       	call   9d20 <fwp_data>
    cf86:	49 89 c6             	mov    %rax,%r14
    cf89:	48 2b 05 20 62 00 00 	sub    0x6220(%rip),%rax        # 131b0 <fwp_gc+0x1030>
    cf90:	48 8b 0d 41 62 00 00 	mov    0x6241(%rip),%rcx        # 131d8 <fwp_gc+0x1058>
    cf97:	48 c1 e1 10          	shl    $0x10,%rcx
    cf9b:	48 39 c8             	cmp    %rcx,%rax
    cf9e:	0f 83 3d 02 00 00    	jae    d1e1 <f57+0x341>
    cfa4:	48 8b 0d 4d 62 00 00 	mov    0x624d(%rip),%rcx        # 131f8 <fwp_gc+0x1078>
    cfab:	48 89 c2             	mov    %rax,%rdx
    cfae:	48 c1 ea 10          	shr    $0x10,%rdx
    cfb2:	48 69 d2 28 12 00 00 	imul   $0x1228,%rdx,%rdx
    cfb9:	0f b6 34 11          	movzbl (%rcx,%rdx,1),%esi
    cfbd:	48 25 ff ff 00 00    	and    $0xffff,%rax
    cfc3:	0f 85 e7 01 00 00    	jne    d1b0 <f57+0x310>
    cfc9:	40 80 fe 02          	cmp    $0x2,%sil
    cfcd:	0f 84 c6 01 00 00    	je     d199 <f57+0x2f9>
    cfd3:	e9 d8 01 00 00       	jmp    d1b0 <f57+0x310>
    cfd8:	49 8b 46 10          	mov    0x10(%r14),%rax
    cfdc:	4e 0f be 2c 38       	movsbq (%rax,%r15,1),%r13
    cfe1:	49 8d 45 81          	lea    -0x7f(%r13),%rax
    cfe5:	48 3d ff fe ff ff    	cmp    $0xfffffffffffffeff,%rax
    cfeb:	0f 86 1d 02 00 00    	jbe    d20e <f57+0x36e>
    cff1:	4c 89 f0             	mov    %r14,%rax
    cff4:	48 2b 05 b5 61 00 00 	sub    0x61b5(%rip),%rax        # 131b0 <fwp_gc+0x1030>
    cffb:	48 8b 0d d6 61 00 00 	mov    0x61d6(%rip),%rcx        # 131d8 <fwp_gc+0x1058>
    d002:	48 c1 e1 10          	shl    $0x10,%rcx
    d006:	48 39 c8             	cmp    %rcx,%rax
    d009:	73 68                	jae    d073 <f57+0x1d3>
    d00b:	48 8b 0d e6 61 00 00 	mov    0x61e6(%rip),%rcx        # 131f8 <fwp_gc+0x1078>
    d012:	48 89 c2             	mov    %rax,%rdx
    d015:	48 c1 ea 10          	shr    $0x10,%rdx
    d019:	48 69 d2 28 12 00 00 	imul   $0x1228,%rdx,%rdx
    d020:	0f b6 34 11          	movzbl (%rcx,%rdx,1),%esi
    d024:	48 25 ff ff 00 00    	and    $0xffff,%rax
    d02a:	75 13                	jne    d03f <f57+0x19f>
    d02c:	40 80 fe 02          	cmp    $0x2,%sil
    d030:	75 0d                	jne    d03f <f57+0x19f>
    d032:	48 8d 3c 11          	lea    (%rcx,%rdx,1),%rdi
    d036:	48 81 c7 28 02 00 00 	add    $0x228,%rdi
    d03d:	eb 21                	jmp    d060 <f57+0x1c0>
    d03f:	40 80 fe 01          	cmp    $0x1,%sil
    d043:	75 2e                	jne    d073 <f57+0x1d3>
    d045:	48 8d 34 11          	lea    (%rcx,%rdx,1),%rsi
    d049:	8b 4c 11 20          	mov    0x20(%rcx,%rdx,1),%ecx
    d04d:	48 0f af c1          	imul   %rcx,%rax
    d051:	48 c1 e8 20          	shr    $0x20,%rax
    d055:	48 8d 3c 30          	lea    (%rax,%rsi,1),%rdi
    d059:	48 81 c7 28 02 00 00 	add    $0x228,%rdi
    d060:	0f b6 07             	movzbl (%rdi),%eax
    d063:	84 c0                	test   %al,%al
    d065:	74 0c                	je     d073 <f57+0x1d3>
    d067:	3c fe                	cmp    $0xfe,%al
    d069:	0f 83 95 01 00 00    	jae    d204 <f57+0x364>
    d06f:	fe c0                	inc    %al
    d071:	88 07                	mov    %al,(%rdi)
    d073:	4c 89 f7             	mov    %r14,%rdi
    d076:	e8 c5 fb ff ff       	call   cc40 <fwp_drop9>
    d07b:	4b 8d 04 2c          	lea    (%r12,%r13,1),%rax
    d07f:	48 ff c0             	inc    %rax
    d082:	48 0f be c8          	movsbq %al,%rcx
    d086:	48 39 c1             	cmp    %rax,%rcx
    d089:	0f 85 7f 01 00 00    	jne    d20e <f57+0x36e>
    d08f:	49 ff c7             	inc    %r15
    d092:	4c 89 7c 24 10       	mov    %r15,0x10(%rsp)
    d097:	4c 89 74 24 18       	mov    %r14,0x18(%rsp)
    d09c:	48 89 44 24 20       	mov    %rax,0x20(%rsp)
    d0a1:	48 8d 54 24 10       	lea    0x10(%rsp),%rdx
    d0a6:	31 ff                	xor    %edi,%edi
    d0a8:	be 03 00 00 00       	mov    $0x3,%esi
    d0ad:	e8 6e cc ff ff       	call   9d20 <fwp_data>
    d0b2:	48 89 c1             	mov    %rax,%rcx
    d0b5:	48 2b 0d f4 60 00 00 	sub    0x60f4(%rip),%rcx        # 131b0 <fwp_gc+0x1030>
    d0bc:	48 8b 15 15 61 00 00 	mov    0x6115(%rip),%rdx        # 131d8 <fwp_gc+0x1058>
    d0c3:	48 c1 e2 10          	shl    $0x10,%rdx
    d0c7:	48 39 d1             	cmp    %rdx,%rcx
    d0ca:	73 76                	jae    d142 <f57+0x2a2>
    d0cc:	48 8b 15 25 61 00 00 	mov    0x6125(%rip),%rdx        # 131f8 <fwp_gc+0x1078>
    d0d3:	48 89 ce             	mov    %rcx,%rsi
    d0d6:	48 c1 ee 10          	shr    $0x10,%rsi
    d0da:	48 69 f6 28 12 00 00 	imul   $0x1228,%rsi,%rsi
    d0e1:	0f b6 3c 32          	movzbl (%rdx,%rsi,1),%edi
    d0e5:	48 81 e1 ff ff 00 00 	and    $0xffff,%rcx
    d0ec:	75 1d                	jne    d10b <f57+0x26b>
    d0ee:	40 80 ff 02          	cmp    $0x2,%dil
    d0f2:	75 17                	jne    d10b <f57+0x26b>
    d0f4:	4c 8d 34 32          	lea    (%rdx,%rsi,1),%r14
    d0f8:	49 81 c6 28 02 00 00 	add    $0x228,%r14
    d0ff:	41 80 3e ff          	cmpb   $0xff,(%r14)
    d103:	74 2d                	je     d132 <f57+0x292>
    d105:	41 c6 06 01          	movb   $0x1,(%r14)
    d109:	eb 37                	jmp    d142 <f57+0x2a2>
    d10b:	40 80 ff 01          	cmp    $0x1,%dil
    d10f:	75 31                	jne    d142 <f57+0x2a2>
    d111:	48 8d 3c 32          	lea    (%rdx,%rsi,1),%rdi
    d115:	8b 54 32 20          	mov    0x20(%rdx,%rsi,1),%edx
    d119:	48 0f af ca          	imul   %rdx,%rcx
    d11d:	48 c1 e9 20          	shr    $0x20,%rcx
    d121:	4c 8d 34 39          	lea    (%rcx,%rdi,1),%r14
    d125:	49 81 c6 28 02 00 00 	add    $0x228,%r14
    d12c:	41 80 3e ff          	cmpb   $0xff,(%r14)
    d130:	75 d3                	jne    d105 <f57+0x265>
    d132:	4c 89 f7             	mov    %r14,%rdi
    d135:	49 89 c7             	mov    %rax,%r15
    d138:	e8 13 91 ff ff       	call   6250 <fwp_rc_forget_slot>
    d13d:	4c 89 f8             	mov    %r15,%rax
    d140:	eb c3                	jmp    d105 <f57+0x265>
    d142:	48 89 44 24 08       	mov    %rax,0x8(%rsp)
    d147:	48 8d 54 24 08       	lea    0x8(%rsp),%rdx
    d14c:	31 ff                	xor    %edi,%edi
    d14e:	be 01 00 00 00       	mov    $0x1,%esi
    d153:	e8 c8 cb ff ff       	call   9d20 <fwp_data>
    d158:	49 89 c6             	mov    %rax,%r14
    d15b:	48 2b 05 4e 60 00 00 	sub    0x604e(%rip),%rax        # 131b0 <fwp_gc+0x1030>
    d162:	48 8b 0d 6f 60 00 00 	mov    0x606f(%rip),%rcx        # 131d8 <fwp_gc+0x1058>
    d169:	48 c1 e1 10          	shl    $0x10,%rcx
    d16d:	48 39 c8             	cmp    %rcx,%rax
    d170:	73 6f                	jae    d1e1 <f57+0x341>
    d172:	48 8b 0d 7f 60 00 00 	mov    0x607f(%rip),%rcx        # 131f8 <fwp_gc+0x1078>
    d179:	48 89 c2             	mov    %rax,%rdx
    d17c:	48 c1 ea 10          	shr    $0x10,%rdx
    d180:	48 69 d2 28 12 00 00 	imul   $0x1228,%rdx,%rdx
    d187:	0f b6 34 11          	movzbl (%rcx,%rdx,1),%esi
    d18b:	48 25 ff ff 00 00    	and    $0xffff,%rax
    d191:	75 1d                	jne    d1b0 <f57+0x310>
    d193:	40 80 fe 02          	cmp    $0x2,%sil
    d197:	75 17                	jne    d1b0 <f57+0x310>
    d199:	4c 8d 3c 11          	lea    (%rcx,%rdx,1),%r15
    d19d:	49 81 c7 28 02 00 00 	add    $0x228,%r15
    d1a4:	41 80 3f ff          	cmpb   $0xff,(%r15)
    d1a8:	74 2d                	je     d1d7 <f57+0x337>
    d1aa:	41 c6 07 01          	movb   $0x1,(%r15)
    d1ae:	eb 31                	jmp    d1e1 <f57+0x341>
    d1b0:	40 80 fe 01          	cmp    $0x1,%sil
    d1b4:	75 2b                	jne    d1e1 <f57+0x341>
    d1b6:	48 8d 34 11          	lea    (%rcx,%rdx,1),%rsi
    d1ba:	8b 4c 11 20          	mov    0x20(%rcx,%rdx,1),%ecx
    d1be:	48 0f af c1          	imul   %rcx,%rax
    d1c2:	48 c1 e8 20          	shr    $0x20,%rax
    d1c6:	4c 8d 3c 30          	lea    (%rax,%rsi,1),%r15
    d1ca:	49 81 c7 28 02 00 00 	add    $0x228,%r15
    d1d1:	41 80 3f ff          	cmpb   $0xff,(%r15)
    d1d5:	75 d3                	jne    d1aa <f57+0x30a>
    d1d7:	4c 89 ff             	mov    %r15,%rdi
    d1da:	e8 71 90 ff ff       	call   6250 <fwp_rc_forget_slot>
    d1df:	eb c9                	jmp    d1aa <f57+0x30a>
    d1e1:	48 89 df             	mov    %rbx,%rdi
    d1e4:	e8 77 00 00 00       	call   d260 <fwp_drop11>
    d1e9:	4c 89 f0             	mov    %r14,%rax
    d1ec:	48 83 c4 70          	add    $0x70,%rsp
    d1f0:	5b                   	pop    %rbx
    d1f1:	41 5c                	pop    %r12
    d1f3:	41 5d                	pop    %r13
    d1f5:	41 5e                	pop    %r14
    d1f7:	41 5f                	pop    %r15
    d1f9:	c3                   	ret
    d1fa:	e8 31 a3 ff ff       	call   7530 <fwp_rc_wide_dup>
    d1ff:	e9 2f fd ff ff       	jmp    cf33 <f57+0x93>
    d204:	e8 27 a3 ff ff       	call   7530 <fwp_rc_wide_dup>
    d209:	e9 65 fe ff ff       	jmp    d073 <f57+0x1d3>
    d20e:	48 8d 15 76 24 00 00 	lea    0x2476(%rip),%rdx        # f68b <fwp_segv.msg+0x44b>
    d215:	48 8d 0d 87 23 00 00 	lea    0x2387(%rip),%rcx        # f5a3 <fwp_segv.msg+0x363>
    d21c:	48 8d 5c 24 10       	lea    0x10(%rsp),%rbx
    d221:	be 60 00 00 00       	mov    $0x60,%esi
    d226:	48 89 df             	mov    %rbx,%rdi
    d229:	31 c0                	xor    %eax,%eax
    d22b:	e8 e0 4e ff ff       	call   2110 <snprintf@plt>
    d230:	e8 eb 8f ff ff       	call   6220 <fwp_flush>
    d235:	48 8b 05 a4 4d 00 00 	mov    0x4da4(%rip),%rax        # 11fe0 <stderr@GLIBC_2.2.5>
    d23c:	48 8b 38             	mov    (%rax),%rdi
    d23f:	48 8d 35 e7 21 00 00 	lea    0x21e7(%rip),%rsi        # f42d <fwp_segv.msg+0x1ed>
    d246:	48 89 da             	mov    %rbx,%rdx
    d249:	31 c0                	xor    %eax,%eax
    d24b:	e8 60 4f ff ff       	call   21b0 <fprintf@plt>
    d250:	bf 65 00 00 00       	mov    $0x65,%edi
    d255:	e8 36 50 ff ff       	call   2290 <exit@plt>
    d25a:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)

000000000000d260 <fwp_drop11>:
    d260:	48 89 f8             	mov    %rdi,%rax
    d263:	48 2b 05 46 5f 00 00 	sub    0x5f46(%rip),%rax        # 131b0 <fwp_gc+0x1030>
    d26a:	48 8b 0d 67 5f 00 00 	mov    0x5f67(%rip),%rcx        # 131d8 <fwp_gc+0x1058>
    d271:	48 c1 e1 10          	shl    $0x10,%rcx
    d275:	48 39 c8             	cmp    %rcx,%rax
    d278:	0f 83 83 00 00 00    	jae    d301 <fwp_drop11+0xa1>
    d27e:	48 8b 0d 73 5f 00 00 	mov    0x5f73(%rip),%rcx        # 131f8 <fwp_gc+0x1078>
    d285:	48 89 c2             	mov    %rax,%rdx
    d288:	48 c1 ea 10          	shr    $0x10,%rdx
    d28c:	48 69 d2 28 12 00 00 	imul   $0x1228,%rdx,%rdx
    d293:	0f b6 34 11          	movzbl (%rcx,%rdx,1),%esi
    d297:	48 25 ff ff 00 00    	and    $0xffff,%rax
    d29d:	75 12                	jne    d2b1 <fwp_drop11+0x51>
    d29f:	40 80 fe 02          	cmp    $0x2,%sil
    d2a3:	75 0c                	jne    d2b1 <fwp_drop11+0x51>
    d2a5:	48 8d 04 11          	lea    (%rcx,%rdx,1),%rax
    d2a9:	48 05 28 02 00 00    	add    $0x228,%rax
    d2af:	eb 1f                	jmp    d2d0 <fwp_drop11+0x70>
    d2b1:	40 80 fe 01          	cmp    $0x1,%sil
    d2b5:	75 4a                	jne    d301 <fwp_drop11+0xa1>
    d2b7:	48 8d 34 11          	lea    (%rcx,%rdx,1),%rsi
    d2bb:	8b 4c 11 20          	mov    0x20(%rcx,%rdx,1),%ecx
    d2bf:	48 0f af c1          	imul   %rcx,%rax
    d2c3:	48 c1 e8 20          	shr    $0x20,%rax
    d2c7:	48 01 f0             	add    %rsi,%rax
    d2ca:	48 05 28 02 00 00    	add    $0x228,%rax
    d2d0:	0f b6 08             	movzbl (%rax),%ecx
    d2d3:	85 c9                	test   %ecx,%ecx
    d2d5:	74 2a                	je     d301 <fwp_drop11+0xa1>
    d2d7:	83 f9 01             	cmp    $0x1,%ecx
    d2da:	75 19                	jne    d2f5 <fwp_drop11+0x95>
    d2dc:	53                   	push   %rbx
    d2dd:	48 8b 47 10          	mov    0x10(%rdi),%rax
    d2e1:	48 89 fb             	mov    %rdi,%rbx
    d2e4:	48 89 c7             	mov    %rax,%rdi
    d2e7:	e8 54 f9 ff ff       	call   cc40 <fwp_drop9>
    d2ec:	48 89 df             	mov    %rbx,%rdi
    d2ef:	5b                   	pop    %rbx
    d2f0:	e9 4b d5 ff ff       	jmp    a840 <fwp_rc_free_obj>
    d2f5:	81 f9 ff 00 00 00    	cmp    $0xff,%ecx
    d2fb:	74 05                	je     d302 <fwp_drop11+0xa2>
    d2fd:	fe c9                	dec    %cl
    d2ff:	88 08                	mov    %cl,(%rax)
    d301:	c3                   	ret
    d302:	48 89 c7             	mov    %rax,%rdi
    d305:	e9 56 d2 ff ff       	jmp    a560 <fwp_rc_wide_drop>
    d30a:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)

000000000000d310 <fwp_owned_entry57>:
    d310:	48 8b 3f             	mov    (%rdi),%rdi
    d313:	e9 88 fb ff ff       	jmp    cea0 <f57>
    d318:	0f 1f 84 00 00 00 00 	nopl   0x0(%rax,%rax,1)
    d31f:	00 

000000000000d320 <fwp_caps57>:
    d320:	53                   	push   %rbx
    d321:	83 7f 04 00          	cmpl   $0x0,0x4(%rdi)
    d325:	74 56                	je     d37d <fwp_caps57+0x5d>
    d327:	48 89 fb             	mov    %rdi,%rbx
    d32a:	48 8b 7f 08          	mov    0x8(%rdi),%rdi
    d32e:	85 f6                	test   %esi,%esi
    d330:	74 51                	je     d383 <fwp_caps57+0x63>
    d332:	48 2b 3d 77 5e 00 00 	sub    0x5e77(%rip),%rdi        # 131b0 <fwp_gc+0x1030>
    d339:	48 8b 05 98 5e 00 00 	mov    0x5e98(%rip),%rax        # 131d8 <fwp_gc+0x1058>
    d340:	48 c1 e0 10          	shl    $0x10,%rax
    d344:	48 39 c7             	cmp    %rax,%rdi
    d347:	73 38                	jae    d381 <fwp_caps57+0x61>
    d349:	48 8b 05 a8 5e 00 00 	mov    0x5ea8(%rip),%rax        # 131f8 <fwp_gc+0x1078>
    d350:	48 89 f9             	mov    %rdi,%rcx
    d353:	48 c1 e9 10          	shr    $0x10,%rcx
    d357:	48 69 c9 28 12 00 00 	imul   $0x1228,%rcx,%rcx
    d35e:	0f b6 14 08          	movzbl (%rax,%rcx,1),%edx
    d362:	48 81 e7 ff ff 00 00 	and    $0xffff,%rdi
    d369:	75 26                	jne    d391 <fwp_caps57+0x71>
    d36b:	80 fa 02             	cmp    $0x2,%dl
    d36e:	75 21                	jne    d391 <fwp_caps57+0x71>
    d370:	48 8d 3c 08          	lea    (%rax,%rcx,1),%rdi
    d374:	48 81 c7 28 02 00 00 	add    $0x228,%rdi
    d37b:	eb 33                	jmp    d3b0 <fwp_caps57+0x90>
    d37d:	85 f6                	test   %esi,%esi
    d37f:	74 0a                	je     d38b <fwp_caps57+0x6b>
    d381:	5b                   	pop    %rbx
    d382:	c3                   	ret
    d383:	e8 d8 fe ff ff       	call   d260 <fwp_drop11>
    d388:	48 89 df             	mov    %rbx,%rdi
    d38b:	5b                   	pop    %rbx
    d38c:	e9 af d4 ff ff       	jmp    a840 <fwp_rc_free_obj>
    d391:	80 fa 01             	cmp    $0x1,%dl
    d394:	75 eb                	jne    d381 <fwp_caps57+0x61>
    d396:	48 8d 14 08          	lea    (%rax,%rcx,1),%rdx
    d39a:	8b 44 08 20          	mov    0x20(%rax,%rcx,1),%eax
    d39e:	48 0f af f8          	imul   %rax,%rdi
    d3a2:	48 c1 ef 20          	shr    $0x20,%rdi
    d3a6:	48 01 d7             	add    %rdx,%rdi
    d3a9:	48 81 c7 28 02 00 00 	add    $0x228,%rdi
    d3b0:	0f b6 07             	movzbl (%rdi),%eax
    d3b3:	84 c0                	test   %al,%al
    d3b5:	74 ca                	je     d381 <fwp_caps57+0x61>
    d3b7:	3c fe                	cmp    $0xfe,%al
    d3b9:	73 06                	jae    d3c1 <fwp_caps57+0xa1>
    d3bb:	fe c0                	inc    %al
    d3bd:	88 07                	mov    %al,(%rdi)
    d3bf:	5b                   	pop    %rbx
    d3c0:	c3                   	ret
    d3c1:	5b                   	pop    %rbx
    d3c2:	e9 69 a1 ff ff       	jmp    7530 <fwp_rc_wide_dup>
    d3c7:	66 0f 1f 84 00 00 00 	nopw   0x0(%rax,%rax,1)
    d3ce:	00 00 

000000000000d3d0 <fwp_args57>:
    d3d0:	85 f6                	test   %esi,%esi
    d3d2:	0f 85 8a 00 00 00    	jne    d462 <fwp_args57+0x92>
    d3d8:	85 d2                	test   %edx,%edx
    d3da:	0f 84 82 00 00 00    	je     d462 <fwp_args57+0x92>
    d3e0:	48 8b 07             	mov    (%rdi),%rax
    d3e3:	48 2b 05 c6 5d 00 00 	sub    0x5dc6(%rip),%rax        # 131b0 <fwp_gc+0x1030>
    d3ea:	48 8b 0d e7 5d 00 00 	mov    0x5de7(%rip),%rcx        # 131d8 <fwp_gc+0x1058>
    d3f1:	48 c1 e1 10          	shl    $0x10,%rcx
    d3f5:	48 39 c8             	cmp    %rcx,%rax
    d3f8:	73 68                	jae    d462 <fwp_args57+0x92>
    d3fa:	48 8b 0d f7 5d 00 00 	mov    0x5df7(%rip),%rcx        # 131f8 <fwp_gc+0x1078>
    d401:	48 89 c2             	mov    %rax,%rdx
    d404:	48 c1 ea 10          	shr    $0x10,%rdx
    d408:	48 69 d2 28 12 00 00 	imul   $0x1228,%rdx,%rdx
    d40f:	0f b6 34 11          	movzbl (%rcx,%rdx,1),%esi
    d413:	48 25 ff ff 00 00    	and    $0xffff,%rax
    d419:	75 13                	jne    d42e <fwp_args57+0x5e>
    d41b:	40 80 fe 02          	cmp    $0x2,%sil
    d41f:	75 0d                	jne    d42e <fwp_args57+0x5e>
    d421:	48 8d 3c 11          	lea    (%rcx,%rdx,1),%rdi
    d425:	48 81 c7 28 02 00 00 	add    $0x228,%rdi
    d42c:	eb 21                	jmp    d44f <fwp_args57+0x7f>
    d42e:	40 80 fe 01          	cmp    $0x1,%sil
    d432:	75 2e                	jne    d462 <fwp_args57+0x92>
    d434:	48 8d 34 11          	lea    (%rcx,%rdx,1),%rsi
    d438:	8b 4c 11 20          	mov    0x20(%rcx,%rdx,1),%ecx
    d43c:	48 0f af c1          	imul   %rcx,%rax
    d440:	48 c1 e8 20          	shr    $0x20,%rax
    d444:	48 8d 3c 30          	lea    (%rax,%rsi,1),%rdi
    d448:	48 81 c7 28 02 00 00 	add    $0x228,%rdi
    d44f:	0f b6 07             	movzbl (%rdi),%eax
    d452:	84 c0                	test   %al,%al
    d454:	74 0c                	je     d462 <fwp_args57+0x92>
    d456:	3c fe                	cmp    $0xfe,%al
    d458:	0f 83 d2 a0 ff ff    	jae    7530 <fwp_rc_wide_dup>
    d45e:	fe c0                	inc    %al
    d460:	88 07                	mov    %al,(%rdi)
    d462:	c3                   	ret
    d463:	66 66 66 66 2e 0f 1f 	data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    d46a:	84 00 00 00 00 00 

000000000000d470 <fwp_arg_drop57>:
    d470:	85 f6                	test   %esi,%esi
    d472:	75 0c                	jne    d480 <fwp_arg_drop57+0x10>
    d474:	85 d2                	test   %edx,%edx
    d476:	74 08                	je     d480 <fwp_arg_drop57+0x10>
    d478:	48 8b 3f             	mov    (%rdi),%rdi
    d47b:	e9 e0 fd ff ff       	jmp    d260 <fwp_drop11>
    d480:	c3                   	ret
    d481:	66 66 66 66 66 66 2e 	data16 data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    d488:	0f 1f 84 00 00 00 00 
    d48f:	00 

000000000000d490 <f59>:
    d490:	41 57                	push   %r15
    d492:	41 56                	push   %r14
    d494:	53                   	push   %rbx
    d495:	48 83 ec 30          	sub    $0x30,%rsp
    d499:	48 89 fb             	mov    %rdi,%rbx
    d49c:	48 8b 47 10          	mov    0x10(%rdi),%rax
    d4a0:	48 2b 05 09 5d 00 00 	sub    0x5d09(%rip),%rax        # 131b0 <fwp_gc+0x1030>
    d4a7:	48 8b 0d 2a 5d 00 00 	mov    0x5d2a(%rip),%rcx        # 131d8 <fwp_gc+0x1058>
    d4ae:	48 c1 e1 10          	shl    $0x10,%rcx
    d4b2:	48 39 c8             	cmp    %rcx,%rax
    d4b5:	73 68                	jae    d51f <f59+0x8f>
    d4b7:	48 8b 0d 3a 5d 00 00 	mov    0x5d3a(%rip),%rcx        # 131f8 <fwp_gc+0x1078>
    d4be:	48 89 c2             	mov    %rax,%rdx
    d4c1:	48 c1 ea 10          	shr    $0x10,%rdx
    d4c5:	48 69 d2 28 12 00 00 	imul   $0x1228,%rdx,%rdx
    d4cc:	0f b6 34 11          	movzbl (%rcx,%rdx,1),%esi
    d4d0:	48 25 ff ff 00 00    	and    $0xffff,%rax
    d4d6:	75 13                	jne    d4eb <f59+0x5b>
    d4d8:	40 80 fe 02          	cmp    $0x2,%sil
    d4dc:	75 0d                	jne    d4eb <f59+0x5b>
    d4de:	48 8d 3c 11          	lea    (%rcx,%rdx,1),%rdi
    d4e2:	48 81 c7 28 02 00 00 	add    $0x228,%rdi
    d4e9:	eb 21                	jmp    d50c <f59+0x7c>
    d4eb:	40 80 fe 01          	cmp    $0x1,%sil
    d4ef:	75 2e                	jne    d51f <f59+0x8f>
    d4f1:	48 8d 34 11          	lea    (%rcx,%rdx,1),%rsi
    d4f5:	8b 4c 11 20          	mov    0x20(%rcx,%rdx,1),%ecx
    d4f9:	48 0f af c1          	imul   %rcx,%rax
    d4fd:	48 c1 e8 20          	shr    $0x20,%rax
    d501:	48 8d 3c 30          	lea    (%rax,%rsi,1),%rdi
    d505:	48 81 c7 28 02 00 00 	add    $0x228,%rdi
    d50c:	0f b6 07             	movzbl (%rdi),%eax
    d50f:	84 c0                	test   %al,%al
    d511:	74 0c                	je     d51f <f59+0x8f>
    d513:	3c fe                	cmp    $0xfe,%al
    d515:	0f 83 cc 02 00 00    	jae    d7e7 <f59+0x357>
    d51b:	fe c0                	inc    %al
    d51d:	88 07                	mov    %al,(%rdi)
    d51f:	4c 8b 7b 08          	mov    0x8(%rbx),%r15
    d523:	48 8b 7b 10          	mov    0x10(%rbx),%rdi
    d527:	f2 0f 10 43 18       	movsd  0x18(%rbx),%xmm0
    d52c:	f2 0f 11 04 24       	movsd  %xmm0,(%rsp)
    d531:	4d 85 ff             	test   %r15,%r15
    d534:	78 20                	js     d556 <f59+0xc6>
    d536:	48 8b 07             	mov    (%rdi),%rax
    d539:	48 b9 ff ff ff ff ff 	movabs $0x7fffffffffffffff,%rcx
    d540:	ff ff 7f 
    d543:	48 21 c1             	and    %rax,%rcx
    d546:	4c 39 f9             	cmp    %r15,%rcx
    d549:	76 0b                	jbe    d556 <f59+0xc6>
    d54b:	48 85 c0             	test   %rax,%rax
    d54e:	78 7c                	js     d5cc <f59+0x13c>
    d550:	48 8d 47 08          	lea    0x8(%rdi),%rax
    d554:	eb 7a                	jmp    d5d0 <f59+0x140>
    d556:	e8 15 ce ff ff       	call   a370 <fwp_drop1>
    d55b:	f2 0f 10 04 24       	movsd  (%rsp),%xmm0
    d560:	f2 0f 11 44 24 18    	movsd  %xmm0,0x18(%rsp)
    d566:	48 8d 54 24 18       	lea    0x18(%rsp),%rdx
    d56b:	bf 01 00 00 00       	mov    $0x1,%edi
    d570:	be 01 00 00 00       	mov    $0x1,%esi
    d575:	e8 a6 c7 ff ff       	call   9d20 <fwp_data>
    d57a:	49 89 c6             	mov    %rax,%r14
    d57d:	48 2b 05 2c 5c 00 00 	sub    0x5c2c(%rip),%rax        # 131b0 <fwp_gc+0x1030>
    d584:	48 8b 0d 4d 5c 00 00 	mov    0x5c4d(%rip),%rcx        # 131d8 <fwp_gc+0x1058>
    d58b:	48 c1 e1 10          	shl    $0x10,%rcx
    d58f:	48 39 c8             	cmp    %rcx,%rax
    d592:	0f 83 3a 02 00 00    	jae    d7d2 <f59+0x342>
    d598:	48 8b 0d 59 5c 00 00 	mov    0x5c59(%rip),%rcx        # 131f8 <fwp_gc+0x1078>
    d59f:	48 89 c2             	mov    %rax,%rdx
    d5a2:	48 c1 ea 10          	shr    $0x10,%rdx
    d5a6:	48 69 d2 28 12 00 00 	imul   $0x1228,%rdx,%rdx
    d5ad:	0f b6 34 11          	movzbl (%rcx,%rdx,1),%esi
    d5b1:	48 25 ff ff 00 00    	and    $0xffff,%rax
    d5b7:	0f 85 e4 01 00 00    	jne    d7a1 <f59+0x311>
    d5bd:	40 80 fe 02          	cmp    $0x2,%sil
    d5c1:	0f 84 c3 01 00 00    	je     d78a <f59+0x2fa>
    d5c7:	e9 d5 01 00 00       	jmp    d7a1 <f59+0x311>
    d5cc:	48 8b 47 10          	mov    0x10(%rdi),%rax
    d5d0:	f2 42 0f 10 04 f8    	movsd  (%rax,%r15,8),%xmm0
    d5d6:	f2 0f 59 05 32 1a 00 	mulsd  0x1a32(%rip),%xmm0        # f010 <_IO_stdin_used+0x10>
    d5dd:	00 
    d5de:	f2 0f 58 05 32 1a 00 	addsd  0x1a32(%rip),%xmm0        # f018 <_IO_stdin_used+0x18>
    d5e5:	00 
    d5e6:	f2 0f 11 44 24 08    	movsd  %xmm0,0x8(%rsp)
    d5ec:	48 89 f8             	mov    %rdi,%rax
    d5ef:	48 2b 05 ba 5b 00 00 	sub    0x5bba(%rip),%rax        # 131b0 <fwp_gc+0x1030>
    d5f6:	49 ff c7             	inc    %r15
    d5f9:	48 8b 0d d8 5b 00 00 	mov    0x5bd8(%rip),%rcx        # 131d8 <fwp_gc+0x1058>
    d600:	48 c1 e1 10          	shl    $0x10,%rcx
    d604:	48 39 c8             	cmp    %rcx,%rax
    d607:	73 66                	jae    d66f <f59+0x1df>
    d609:	48 8b 0d e8 5b 00 00 	mov    0x5be8(%rip),%rcx        # 131f8 <fwp_gc+0x1078>
    d610:	48 89 c2             	mov    %rax,%rdx
    d613:	48 c1 ea 10          	shr    $0x10,%rdx
    d617:	48 69 d2 28 12 00 00 	imul   $0x1228,%rdx,%rdx
    d61e:	0f b6 34 11          	movzbl (%rcx,%rdx,1),%esi
    d622:	48 25 ff ff 00 00    	and    $0xffff,%rax
    d628:	75 12                	jne    d63c <f59+0x1ac>
    d62a:	40 80 fe 02          	cmp    $0x2,%sil
    d62e:	75 0c                	jne    d63c <f59+0x1ac>
    d630:	48 8d 04 11          	lea    (%rcx,%rdx,1),%rax
    d634:	48 05 28 02 00 00    	add    $0x228,%rax
    d63a:	eb 1f                	jmp    d65b <f59+0x1cb>
    d63c:	40 80 fe 01          	cmp    $0x1,%sil
    d640:	75 2d                	jne    d66f <f59+0x1df>
    d642:	48 8d 34 11          	lea    (%rcx,%rdx,1),%rsi
    d646:	8b 4c 11 20          	mov    0x20(%rcx,%rdx,1),%ecx
    d64a:	48 0f af c1          	imul   %rcx,%rax
    d64e:	48 c1 e8 20          	shr    $0x20,%rax
    d652:	48 01 f0             	add    %rsi,%rax
    d655:	48 05 28 02 00 00    	add    $0x228,%rax
    d65b:	0f b6 08             	movzbl (%rax),%ecx
    d65e:	84 c9                	test   %cl,%cl
    d660:	74 0d                	je     d66f <f59+0x1df>
    d662:	80 f9 fe             	cmp    $0xfe,%cl
    d665:	0f 83 86 01 00 00    	jae    d7f1 <f59+0x361>
    d66b:	fe c1                	inc    %cl
    d66d:	88 08                	mov    %cl,(%rax)
    d66f:	49 89 fe             	mov    %rdi,%r14
    d672:	e8 f9 cc ff ff       	call   a370 <fwp_drop1>
    d677:	f2 0f 10 04 24       	movsd  (%rsp),%xmm0
    d67c:	f2 0f 58 44 24 08    	addsd  0x8(%rsp),%xmm0
    d682:	4c 89 7c 24 18       	mov    %r15,0x18(%rsp)
    d687:	4c 89 74 24 20       	mov    %r14,0x20(%rsp)
    d68c:	f2 0f 11 44 24 28    	movsd  %xmm0,0x28(%rsp)
    d692:	48 8d 54 24 18       	lea    0x18(%rsp),%rdx
    d697:	31 ff                	xor    %edi,%edi
    d699:	be 03 00 00 00       	mov    $0x3,%esi
    d69e:	e8 7d c6 ff ff       	call   9d20 <fwp_data>
    d6a3:	48 89 c1             	mov    %rax,%rcx
    d6a6:	48 2b 0d 03 5b 00 00 	sub    0x5b03(%rip),%rcx        # 131b0 <fwp_gc+0x1030>
    d6ad:	48 8b 15 24 5b 00 00 	mov    0x5b24(%rip),%rdx        # 131d8 <fwp_gc+0x1058>
    d6b4:	48 c1 e2 10          	shl    $0x10,%rdx
    d6b8:	48 39 d1             	cmp    %rdx,%rcx
    d6bb:	73 76                	jae    d733 <f59+0x2a3>
    d6bd:	48 8b 15 34 5b 00 00 	mov    0x5b34(%rip),%rdx        # 131f8 <fwp_gc+0x1078>
    d6c4:	48 89 ce             	mov    %rcx,%rsi
    d6c7:	48 c1 ee 10          	shr    $0x10,%rsi
    d6cb:	48 69 f6 28 12 00 00 	imul   $0x1228,%rsi,%rsi
    d6d2:	0f b6 3c 32          	movzbl (%rdx,%rsi,1),%edi
    d6d6:	48 81 e1 ff ff 00 00 	and    $0xffff,%rcx
    d6dd:	75 1d                	jne    d6fc <f59+0x26c>
    d6df:	40 80 ff 02          	cmp    $0x2,%dil
    d6e3:	75 17                	jne    d6fc <f59+0x26c>
    d6e5:	4c 8d 34 32          	lea    (%rdx,%rsi,1),%r14
    d6e9:	49 81 c6 28 02 00 00 	add    $0x228,%r14
    d6f0:	41 80 3e ff          	cmpb   $0xff,(%r14)
    d6f4:	74 2d                	je     d723 <f59+0x293>
    d6f6:	41 c6 06 01          	movb   $0x1,(%r14)
    d6fa:	eb 37                	jmp    d733 <f59+0x2a3>
    d6fc:	40 80 ff 01          	cmp    $0x1,%dil
    d700:	75 31                	jne    d733 <f59+0x2a3>
    d702:	48 8d 3c 32          	lea    (%rdx,%rsi,1),%rdi
    d706:	8b 54 32 20          	mov    0x20(%rdx,%rsi,1),%edx
    d70a:	48 0f af ca          	imul   %rdx,%rcx
    d70e:	48 c1 e9 20          	shr    $0x20,%rcx
    d712:	4c 8d 34 39          	lea    (%rcx,%rdi,1),%r14
    d716:	49 81 c6 28 02 00 00 	add    $0x228,%r14
    d71d:	41 80 3e ff          	cmpb   $0xff,(%r14)
    d721:	75 d3                	jne    d6f6 <f59+0x266>
    d723:	4c 89 f7             	mov    %r14,%rdi
    d726:	49 89 c7             	mov    %rax,%r15
    d729:	e8 22 8b ff ff       	call   6250 <fwp_rc_forget_slot>
    d72e:	4c 89 f8             	mov    %r15,%rax
    d731:	eb c3                	jmp    d6f6 <f59+0x266>
    d733:	48 89 44 24 10       	mov    %rax,0x10(%rsp)
    d738:	48 8d 54 24 10       	lea    0x10(%rsp),%rdx
    d73d:	31 ff                	xor    %edi,%edi
    d73f:	be 01 00 00 00       	mov    $0x1,%esi
    d744:	e8 d7 c5 ff ff       	call   9d20 <fwp_data>
    d749:	49 89 c6             	mov    %rax,%r14
    d74c:	48 2b 05 5d 5a 00 00 	sub    0x5a5d(%rip),%rax        # 131b0 <fwp_gc+0x1030>
    d753:	48 8b 0d 7e 5a 00 00 	mov    0x5a7e(%rip),%rcx        # 131d8 <fwp_gc+0x1058>
    d75a:	48 c1 e1 10          	shl    $0x10,%rcx
    d75e:	48 39 c8             	cmp    %rcx,%rax
    d761:	73 6f                	jae    d7d2 <f59+0x342>
    d763:	48 8b 0d 8e 5a 00 00 	mov    0x5a8e(%rip),%rcx        # 131f8 <fwp_gc+0x1078>
    d76a:	48 89 c2             	mov    %rax,%rdx
    d76d:	48 c1 ea 10          	shr    $0x10,%rdx
    d771:	48 69 d2 28 12 00 00 	imul   $0x1228,%rdx,%rdx
    d778:	0f b6 34 11          	movzbl (%rcx,%rdx,1),%esi
    d77c:	48 25 ff ff 00 00    	and    $0xffff,%rax
    d782:	75 1d                	jne    d7a1 <f59+0x311>
    d784:	40 80 fe 02          	cmp    $0x2,%sil
    d788:	75 17                	jne    d7a1 <f59+0x311>
    d78a:	4c 8d 3c 11          	lea    (%rcx,%rdx,1),%r15
    d78e:	49 81 c7 28 02 00 00 	add    $0x228,%r15
    d795:	41 80 3f ff          	cmpb   $0xff,(%r15)
    d799:	74 2d                	je     d7c8 <f59+0x338>
    d79b:	41 c6 07 01          	movb   $0x1,(%r15)
    d79f:	eb 31                	jmp    d7d2 <f59+0x342>
    d7a1:	40 80 fe 01          	cmp    $0x1,%sil
    d7a5:	75 2b                	jne    d7d2 <f59+0x342>
    d7a7:	48 8d 34 11          	lea    (%rcx,%rdx,1),%rsi
    d7ab:	8b 4c 11 20          	mov    0x20(%rcx,%rdx,1),%ecx
    d7af:	48 0f af c1          	imul   %rcx,%rax
    d7b3:	48 c1 e8 20          	shr    $0x20,%rax
    d7b7:	4c 8d 3c 30          	lea    (%rax,%rsi,1),%r15
    d7bb:	49 81 c7 28 02 00 00 	add    $0x228,%r15
    d7c2:	41 80 3f ff          	cmpb   $0xff,(%r15)
    d7c6:	75 d3                	jne    d79b <f59+0x30b>
    d7c8:	4c 89 ff             	mov    %r15,%rdi
    d7cb:	e8 80 8a ff ff       	call   6250 <fwp_rc_forget_slot>
    d7d0:	eb c9                	jmp    d79b <f59+0x30b>
    d7d2:	48 89 df             	mov    %rbx,%rdi
    d7d5:	e8 e6 ca ff ff       	call   a2c0 <fwp_drop6>
    d7da:	4c 89 f0             	mov    %r14,%rax
    d7dd:	48 83 c4 30          	add    $0x30,%rsp
    d7e1:	5b                   	pop    %rbx
    d7e2:	41 5e                	pop    %r14
    d7e4:	41 5f                	pop    %r15
    d7e6:	c3                   	ret
    d7e7:	e8 44 9d ff ff       	call   7530 <fwp_rc_wide_dup>
    d7ec:	e9 2e fd ff ff       	jmp    d51f <f59+0x8f>
    d7f1:	49 89 fe             	mov    %rdi,%r14
    d7f4:	48 89 c7             	mov    %rax,%rdi
    d7f7:	e8 34 9d ff ff       	call   7530 <fwp_rc_wide_dup>
    d7fc:	4c 89 f7             	mov    %r14,%rdi
    d7ff:	e9 6b fe ff ff       	jmp    d66f <f59+0x1df>
    d804:	66 66 66 2e 0f 1f 84 	data16 data16 cs nopw 0x0(%rax,%rax,1)
    d80b:	00 00 00 00 00 

000000000000d810 <fwp_owned_entry59>:
    d810:	48 8b 3f             	mov    (%rdi),%rdi
    d813:	e9 78 fc ff ff       	jmp    d490 <f59>
    d818:	0f 1f 84 00 00 00 00 	nopl   0x0(%rax,%rax,1)
    d81f:	00 

000000000000d820 <fwp_caps59>:
    d820:	53                   	push   %rbx
    d821:	83 7f 04 00          	cmpl   $0x0,0x4(%rdi)
    d825:	74 56                	je     d87d <fwp_caps59+0x5d>
    d827:	48 89 fb             	mov    %rdi,%rbx
    d82a:	48 8b 7f 08          	mov    0x8(%rdi),%rdi
    d82e:	85 f6                	test   %esi,%esi
    d830:	74 51                	je     d883 <fwp_caps59+0x63>
    d832:	48 2b 3d 77 59 00 00 	sub    0x5977(%rip),%rdi        # 131b0 <fwp_gc+0x1030>
    d839:	48 8b 05 98 59 00 00 	mov    0x5998(%rip),%rax        # 131d8 <fwp_gc+0x1058>
    d840:	48 c1 e0 10          	shl    $0x10,%rax
    d844:	48 39 c7             	cmp    %rax,%rdi
    d847:	73 38                	jae    d881 <fwp_caps59+0x61>
    d849:	48 8b 05 a8 59 00 00 	mov    0x59a8(%rip),%rax        # 131f8 <fwp_gc+0x1078>
    d850:	48 89 f9             	mov    %rdi,%rcx
    d853:	48 c1 e9 10          	shr    $0x10,%rcx
    d857:	48 69 c9 28 12 00 00 	imul   $0x1228,%rcx,%rcx
    d85e:	0f b6 14 08          	movzbl (%rax,%rcx,1),%edx
    d862:	48 81 e7 ff ff 00 00 	and    $0xffff,%rdi
    d869:	75 26                	jne    d891 <fwp_caps59+0x71>
    d86b:	80 fa 02             	cmp    $0x2,%dl
    d86e:	75 21                	jne    d891 <fwp_caps59+0x71>
    d870:	48 8d 3c 08          	lea    (%rax,%rcx,1),%rdi
    d874:	48 81 c7 28 02 00 00 	add    $0x228,%rdi
    d87b:	eb 33                	jmp    d8b0 <fwp_caps59+0x90>
    d87d:	85 f6                	test   %esi,%esi
    d87f:	74 0a                	je     d88b <fwp_caps59+0x6b>
    d881:	5b                   	pop    %rbx
    d882:	c3                   	ret
    d883:	e8 38 ca ff ff       	call   a2c0 <fwp_drop6>
    d888:	48 89 df             	mov    %rbx,%rdi
    d88b:	5b                   	pop    %rbx
    d88c:	e9 af cf ff ff       	jmp    a840 <fwp_rc_free_obj>
    d891:	80 fa 01             	cmp    $0x1,%dl
    d894:	75 eb                	jne    d881 <fwp_caps59+0x61>
    d896:	48 8d 14 08          	lea    (%rax,%rcx,1),%rdx
    d89a:	8b 44 08 20          	mov    0x20(%rax,%rcx,1),%eax
    d89e:	48 0f af f8          	imul   %rax,%rdi
    d8a2:	48 c1 ef 20          	shr    $0x20,%rdi
    d8a6:	48 01 d7             	add    %rdx,%rdi
    d8a9:	48 81 c7 28 02 00 00 	add    $0x228,%rdi
    d8b0:	0f b6 07             	movzbl (%rdi),%eax
    d8b3:	84 c0                	test   %al,%al
    d8b5:	74 ca                	je     d881 <fwp_caps59+0x61>
    d8b7:	3c fe                	cmp    $0xfe,%al
    d8b9:	73 06                	jae    d8c1 <fwp_caps59+0xa1>
    d8bb:	fe c0                	inc    %al
    d8bd:	88 07                	mov    %al,(%rdi)
    d8bf:	5b                   	pop    %rbx
    d8c0:	c3                   	ret
    d8c1:	5b                   	pop    %rbx
    d8c2:	e9 69 9c ff ff       	jmp    7530 <fwp_rc_wide_dup>
    d8c7:	66 0f 1f 84 00 00 00 	nopw   0x0(%rax,%rax,1)
    d8ce:	00 00 

000000000000d8d0 <fwp_args59>:
    d8d0:	85 f6                	test   %esi,%esi
    d8d2:	0f 85 8a 00 00 00    	jne    d962 <fwp_args59+0x92>
    d8d8:	85 d2                	test   %edx,%edx
    d8da:	0f 84 82 00 00 00    	je     d962 <fwp_args59+0x92>
    d8e0:	48 8b 07             	mov    (%rdi),%rax
    d8e3:	48 2b 05 c6 58 00 00 	sub    0x58c6(%rip),%rax        # 131b0 <fwp_gc+0x1030>
    d8ea:	48 8b 0d e7 58 00 00 	mov    0x58e7(%rip),%rcx        # 131d8 <fwp_gc+0x1058>
    d8f1:	48 c1 e1 10          	shl    $0x10,%rcx
    d8f5:	48 39 c8             	cmp    %rcx,%rax
    d8f8:	73 68                	jae    d962 <fwp_args59+0x92>
    d8fa:	48 8b 0d f7 58 00 00 	mov    0x58f7(%rip),%rcx        # 131f8 <fwp_gc+0x1078>
    d901:	48 89 c2             	mov    %rax,%rdx
    d904:	48 c1 ea 10          	shr    $0x10,%rdx
    d908:	48 69 d2 28 12 00 00 	imul   $0x1228,%rdx,%rdx
    d90f:	0f b6 34 11          	movzbl (%rcx,%rdx,1),%esi
    d913:	48 25 ff ff 00 00    	and    $0xffff,%rax
    d919:	75 13                	jne    d92e <fwp_args59+0x5e>
    d91b:	40 80 fe 02          	cmp    $0x2,%sil
    d91f:	75 0d                	jne    d92e <fwp_args59+0x5e>
    d921:	48 8d 3c 11          	lea    (%rcx,%rdx,1),%rdi
    d925:	48 81 c7 28 02 00 00 	add    $0x228,%rdi
    d92c:	eb 21                	jmp    d94f <fwp_args59+0x7f>
    d92e:	40 80 fe 01          	cmp    $0x1,%sil
    d932:	75 2e                	jne    d962 <fwp_args59+0x92>
    d934:	48 8d 34 11          	lea    (%rcx,%rdx,1),%rsi
    d938:	8b 4c 11 20          	mov    0x20(%rcx,%rdx,1),%ecx
    d93c:	48 0f af c1          	imul   %rcx,%rax
    d940:	48 c1 e8 20          	shr    $0x20,%rax
    d944:	48 8d 3c 30          	lea    (%rax,%rsi,1),%rdi
    d948:	48 81 c7 28 02 00 00 	add    $0x228,%rdi
    d94f:	0f b6 07             	movzbl (%rdi),%eax
    d952:	84 c0                	test   %al,%al
    d954:	74 0c                	je     d962 <fwp_args59+0x92>
    d956:	3c fe                	cmp    $0xfe,%al
    d958:	0f 83 d2 9b ff ff    	jae    7530 <fwp_rc_wide_dup>
    d95e:	fe c0                	inc    %al
    d960:	88 07                	mov    %al,(%rdi)
    d962:	c3                   	ret
    d963:	66 66 66 66 2e 0f 1f 	data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    d96a:	84 00 00 00 00 00 

000000000000d970 <fwp_arg_drop59>:
    d970:	85 f6                	test   %esi,%esi
    d972:	75 0c                	jne    d980 <fwp_arg_drop59+0x10>
    d974:	85 d2                	test   %edx,%edx
    d976:	74 08                	je     d980 <fwp_arg_drop59+0x10>
    d978:	48 8b 3f             	mov    (%rdi),%rdi
    d97b:	e9 40 c9 ff ff       	jmp    a2c0 <fwp_drop6>
    d980:	c3                   	ret
    d981:	66 66 66 66 66 66 2e 	data16 data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    d988:	0f 1f 84 00 00 00 00 
    d98f:	00 

000000000000d990 <fwp_gc_find_data>:
    d990:	0f b7 77 18          	movzwl 0x18(%rdi),%esi
    d994:	48 85 f6             	test   %rsi,%rsi
    d997:	0f 84 be 00 00 00    	je     da5b <fwp_gc_find_data+0xcb>
    d99d:	53                   	push   %rbx
    d99e:	48 8b 07             	mov    (%rdi),%rax
    d9a1:	4c 8b 47 10          	mov    0x10(%rdi),%r8
    d9a5:	48 6b ce 38          	imul   $0x38,%rsi,%rcx
    d9a9:	45 31 c9             	xor    %r9d,%r9d
    d9ac:	48 8d 15 cd 47 00 00 	lea    0x47cd(%rip),%rdx        # 12180 <fwp_gc>
    d9b3:	41 bb 01 00 00 00    	mov    $0x1,%r11d
    d9b9:	45 31 d2             	xor    %r10d,%r10d
    d9bc:	eb 0b                	jmp    d9c9 <fwp_gc_find_data+0x39>
    d9be:	66 90                	xchg   %ax,%ax
    d9c0:	49 83 c1 38          	add    $0x38,%r9
    d9c4:	4c 39 c9             	cmp    %r9,%rcx
    d9c7:	74 22                	je     d9eb <fwp_gc_find_data+0x5b>
    d9c9:	43 83 3c 08 01       	cmpl   $0x1,(%r8,%r9,1)
    d9ce:	75 f0                	jne    d9c0 <fwp_gc_find_data+0x30>
    d9d0:	4b 8b 5c 08 10       	mov    0x10(%r8,%r9,1),%rbx
    d9d5:	48 01 c3             	add    %rax,%rbx
    d9d8:	48 39 d3             	cmp    %rdx,%rbx
    d9db:	77 e3                	ja     d9c0 <fwp_gc_find_data+0x30>
    d9dd:	4b 03 5c 08 28       	add    0x28(%r8,%r9,1),%rbx
    d9e2:	48 39 d3             	cmp    %rdx,%rbx
    d9e5:	45 0f 47 d3          	cmova  %r11d,%r10d
    d9e9:	eb d5                	jmp    d9c0 <fwp_gc_find_data+0x30>
    d9eb:	31 c0                	xor    %eax,%eax
    d9ed:	45 85 d2             	test   %r10d,%r10d
    d9f0:	0f 95 c0             	setne  %al
    d9f3:	74 6e                	je     da63 <fwp_gc_find_data+0xd3>
    d9f5:	66 85 f6             	test   %si,%si
    d9f8:	74 69                	je     da63 <fwp_gc_find_data+0xd3>
    d9fa:	8b 05 10 59 00 00    	mov    0x5910(%rip),%eax        # 13310 <fwp_gc+0x1190>
    da00:	48 8b 77 10          	mov    0x10(%rdi),%rsi
    da04:	45 31 c0             	xor    %r8d,%r8d
    da07:	eb 10                	jmp    da19 <fwp_gc_find_data+0x89>
    da09:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)
    da10:	49 83 c0 38          	add    $0x38,%r8
    da14:	4c 39 c1             	cmp    %r8,%rcx
    da17:	74 45                	je     da5e <fwp_gc_find_data+0xce>
    da19:	42 83 3c 06 01       	cmpl   $0x1,(%rsi,%r8,1)
    da1e:	75 f0                	jne    da10 <fwp_gc_find_data+0x80>
    da20:	42 f6 44 06 04 02    	testb  $0x2,0x4(%rsi,%r8,1)
    da26:	74 e8                	je     da10 <fwp_gc_find_data+0x80>
    da28:	83 f8 10             	cmp    $0x10,%eax
    da2b:	74 31                	je     da5e <fwp_gc_find_data+0xce>
    da2d:	4e 8b 4c 06 10       	mov    0x10(%rsi,%r8,1),%r9
    da32:	4c 03 0f             	add    (%rdi),%r9
    da35:	4c 63 d0             	movslq %eax,%r10
    da38:	49 c1 e2 04          	shl    $0x4,%r10
    da3c:	4d 89 8c 12 90 10 00 	mov    %r9,0x1090(%r10,%rdx,1)
    da43:	00 
    da44:	4e 8b 4c 06 28       	mov    0x28(%rsi,%r8,1),%r9
    da49:	4d 89 8c 12 98 10 00 	mov    %r9,0x1098(%r10,%rdx,1)
    da50:	00 
    da51:	ff c0                	inc    %eax
    da53:	89 05 b7 58 00 00    	mov    %eax,0x58b7(%rip)        # 13310 <fwp_gc+0x1190>
    da59:	eb b5                	jmp    da10 <fwp_gc_find_data+0x80>
    da5b:	31 c0                	xor    %eax,%eax
    da5d:	c3                   	ret
    da5e:	b8 01 00 00 00       	mov    $0x1,%eax
    da63:	5b                   	pop    %rbx
    da64:	c3                   	ret
    da65:	66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
    da6c:	00 00 00 00 

000000000000da70 <fwp_gc_report>:
    da70:	55                   	push   %rbp
    da71:	41 57                	push   %r15
    da73:	41 56                	push   %r14
    da75:	41 55                	push   %r13
    da77:	41 54                	push   %r12
    da79:	53                   	push   %rbx
    da7a:	48 81 ec 58 01 00 00 	sub    $0x158,%rsp
    da81:	48 8b 05 08 59 00 00 	mov    0x5908(%rip),%rax        # 13390 <fwp_gc+0x1210>
    da88:	48 8b 0d f1 46 00 00 	mov    0x46f1(%rip),%rcx        # 12180 <fwp_gc>
    da8f:	48 29 c8             	sub    %rcx,%rax
    da92:	f2 48 0f 2a c0       	cvtsi2sd %rax,%xmm0
    da97:	f2 0f 58 05 c9 58 00 	addsd  0x58c9(%rip),%xmm0        # 13368 <fwp_gc+0x11e8>
    da9e:	00 
    da9f:	f2 0f 11 44 24 48    	movsd  %xmm0,0x48(%rsp)
    daa5:	f2 0f 11 05 bb 58 00 	movsd  %xmm0,0x58bb(%rip)        # 13368 <fwp_gc+0x11e8>
    daac:	00 
    daad:	48 89 0d dc 58 00 00 	mov    %rcx,0x58dc(%rip)        # 13390 <fwp_gc+0x1210>
    dab4:	48 8b 05 25 45 00 00 	mov    0x4525(%rip),%rax        # 11fe0 <stderr@GLIBC_2.2.5>
    dabb:	48 8b 28             	mov    (%rax),%rbp
    dabe:	48 8b 1d 93 58 00 00 	mov    0x5893(%rip),%rbx        # 13358 <fwp_gc+0x11d8>
    dac5:	4c 8b 3d cc 56 00 00 	mov    0x56cc(%rip),%r15        # 13198 <fwp_gc+0x1018>
    dacc:	f2 0f 10 05 b4 58 00 	movsd  0x58b4(%rip),%xmm0        # 13388 <fwp_gc+0x1208>
    dad3:	00 
    dad4:	f2 0f 11 44 24 30    	movsd  %xmm0,0x30(%rsp)
    dada:	48 8b 05 e7 56 00 00 	mov    0x56e7(%rip),%rax        # 131c8 <fwp_gc+0x1048>
    dae1:	48 89 44 24 28       	mov    %rax,0x28(%rsp)
    dae6:	48 8b 05 5b 58 00 00 	mov    0x585b(%rip),%rax        # 13348 <fwp_gc+0x11c8>
    daed:	48 89 44 24 20       	mov    %rax,0x20(%rsp)
    daf2:	4c 8b 35 57 58 00 00 	mov    0x5857(%rip),%r14        # 13350 <fwp_gc+0x11d0>
    daf9:	f2 0f 10 05 6f 58 00 	movsd  0x586f(%rip),%xmm0        # 13370 <fwp_gc+0x11f0>
    db00:	00 
    db01:	f2 0f 11 44 24 40    	movsd  %xmm0,0x40(%rsp)
    db07:	f2 0f 10 05 69 58 00 	movsd  0x5869(%rip),%xmm0        # 13378 <fwp_gc+0x11f8>
    db0e:	00 
    db0f:	f2 0f 11 44 24 38    	movsd  %xmm0,0x38(%rsp)
    db15:	48 8d 3d db 1c 00 00 	lea    0x1cdb(%rip),%rdi        # f7f7 <fwp_segv.msg+0x5b7>
    db1c:	48 8d 35 4e 1b 00 00 	lea    0x1b4e(%rip),%rsi        # f671 <fwp_segv.msg+0x431>
    db23:	e8 28 47 ff ff       	call   2250 <fopen@plt>
    db28:	49 c7 c4 ff ff ff ff 	mov    $0xffffffffffffffff,%r12
    db2f:	48 85 c0             	test   %rax,%rax
    db32:	74 4b                	je     db7f <fwp_gc_report+0x10f>
    db34:	49 89 c5             	mov    %rax,%r13
    db37:	48 89 6c 24 08       	mov    %rbp,0x8(%rsp)
    db3c:	4c 89 7c 24 10       	mov    %r15,0x10(%rsp)
    db41:	48 89 5c 24 18       	mov    %rbx,0x18(%rsp)
    db46:	48 8d 7c 24 50       	lea    0x50(%rsp),%rdi
    db4b:	be 00 01 00 00       	mov    $0x100,%esi
    db50:	48 89 c2             	mov    %rax,%rdx
    db53:	e8 08 46 ff ff       	call   2160 <fgets@plt>
    db58:	49 c7 c4 ff ff ff ff 	mov    $0xffffffffffffffff,%r12
    db5f:	48 85 c0             	test   %rax,%rax
    db62:	0f 85 f1 00 00 00    	jne    dc59 <fwp_gc_report+0x1e9>
    db68:	4c 89 ef             	mov    %r13,%rdi
    db6b:	e8 60 45 ff ff       	call   20d0 <fclose@plt>
    db70:	48 8b 5c 24 18       	mov    0x18(%rsp),%rbx
    db75:	4c 8b 7c 24 10       	mov    0x10(%rsp),%r15
    db7a:	48 8b 6c 24 08       	mov    0x8(%rsp),%rbp
    db7f:	66 49 0f 6e c6       	movq   %r14,%xmm0
    db84:	66 0f 6f 0d 74 15 00 	movdqa 0x1574(%rip),%xmm1        # f100 <_IO_stdin_used+0x100>
    db8b:	00 
    db8c:	66 0f 62 c1          	punpckldq %xmm1,%xmm0
    db90:	66 0f 28 15 78 15 00 	movapd 0x1578(%rip),%xmm2        # f110 <_IO_stdin_used+0x110>
    db97:	00 
    db98:	66 0f 5c c2          	subpd  %xmm2,%xmm0
    db9c:	66 0f 28 e0          	movapd %xmm0,%xmm4
    dba0:	66 0f 15 e0          	unpckhpd %xmm0,%xmm4
    dba4:	f2 0f 58 e0          	addsd  %xmm0,%xmm4
    dba8:	f2 0f 10 35 78 14 00 	movsd  0x1478(%rip),%xmm6        # f028 <_IO_stdin_used+0x28>
    dbaf:	00 
    dbb0:	f2 0f 59 e6          	mulsd  %xmm6,%xmm4
    dbb4:	f3 0f 7e 6c 24 20    	movq   0x20(%rsp),%xmm5
    dbba:	66 0f 62 e9          	punpckldq %xmm1,%xmm5
    dbbe:	66 0f 5c ea          	subpd  %xmm2,%xmm5
    dbc2:	66 0f 28 dd          	movapd %xmm5,%xmm3
    dbc6:	66 0f 15 dd          	unpckhpd %xmm5,%xmm3
    dbca:	f2 0f 58 dd          	addsd  %xmm5,%xmm3
    dbce:	f2 0f 59 de          	mulsd  %xmm6,%xmm3
    dbd2:	f3 0f 7e 6c 24 28    	movq   0x28(%rsp),%xmm5
    dbd8:	66 0f 62 e9          	punpckldq %xmm1,%xmm5
    dbdc:	66 0f 5c ea          	subpd  %xmm2,%xmm5
    dbe0:	66 0f 28 d5          	movapd %xmm5,%xmm2
    dbe4:	66 0f 15 d5          	unpckhpd %xmm5,%xmm2
    dbe8:	f2 0f 58 d5          	addsd  %xmm5,%xmm2
    dbec:	f2 0f 59 d6          	mulsd  %xmm6,%xmm2
    dbf0:	f2 0f 10 44 24 48    	movsd  0x48(%rsp),%xmm0
    dbf6:	f2 0f 10 4c 24 30    	movsd  0x30(%rsp),%xmm1
    dbfc:	f2 0f 58 c1          	addsd  %xmm1,%xmm0
    dc00:	f2 0f 59 ce          	mulsd  %xmm6,%xmm1
    dc04:	f2 0f 59 c6          	mulsd  %xmm6,%xmm0
    dc08:	83 3d 65 55 00 00 00 	cmpl   $0x0,0x5565(%rip)        # 13174 <fwp_gc+0xff4>
    dc0f:	48 8d 05 cf 1b 00 00 	lea    0x1bcf(%rip),%rax        # f7e5 <fwp_segv.msg+0x5a5>
    dc16:	4c 8d 0d 12 1b 00 00 	lea    0x1b12(%rip),%r9        # f72f <fwp_segv.msg+0x4ef>
    dc1d:	4c 0f 44 c8          	cmove  %rax,%r9
    dc21:	48 8d 35 08 1b 00 00 	lea    0x1b08(%rip),%rsi        # f730 <fwp_segv.msg+0x4f0>
    dc28:	48 89 ef             	mov    %rbp,%rdi
    dc2b:	48 89 da             	mov    %rbx,%rdx
    dc2e:	4c 89 f9             	mov    %r15,%rcx
    dc31:	f2 0f 10 6c 24 40    	movsd  0x40(%rsp),%xmm5
    dc37:	f2 0f 10 74 24 38    	movsd  0x38(%rsp),%xmm6
    dc3d:	4d 89 e0             	mov    %r12,%r8
    dc40:	b0 07                	mov    $0x7,%al
    dc42:	e8 69 45 ff ff       	call   21b0 <fprintf@plt>
    dc47:	48 81 c4 58 01 00 00 	add    $0x158,%rsp
    dc4e:	5b                   	pop    %rbx
    dc4f:	41 5c                	pop    %r12
    dc51:	41 5d                	pop    %r13
    dc53:	41 5e                	pop    %r14
    dc55:	41 5f                	pop    %r15
    dc57:	5d                   	pop    %rbp
    dc58:	c3                   	ret
    dc59:	48 8d 6c 24 56       	lea    0x56(%rsp),%rbp
    dc5e:	41 bf 56 6d 48 57    	mov    $0x57486d56,%r15d
    dc64:	48 8d 5c 24 50       	lea    0x50(%rsp),%rbx
    dc69:	eb 1e                	jmp    dc89 <fwp_gc_report+0x219>
    dc6b:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)
    dc70:	48 89 df             	mov    %rbx,%rdi
    dc73:	be 00 01 00 00       	mov    $0x100,%esi
    dc78:	4c 89 ea             	mov    %r13,%rdx
    dc7b:	e8 e0 44 ff ff       	call   2160 <fgets@plt>
    dc80:	48 85 c0             	test   %rax,%rax
    dc83:	0f 84 df fe ff ff    	je     db68 <fwp_gc_report+0xf8>
    dc89:	8b 44 24 50          	mov    0x50(%rsp),%eax
    dc8d:	44 31 f8             	xor    %r15d,%eax
    dc90:	0f b6 4c 24 54       	movzbl 0x54(%rsp),%ecx
    dc95:	83 f1 4d             	xor    $0x4d,%ecx
    dc98:	09 c1                	or     %eax,%ecx
    dc9a:	75 d4                	jne    dc70 <fwp_gc_report+0x200>
    dc9c:	80 7c 24 55 3a       	cmpb   $0x3a,0x55(%rsp)
    dca1:	75 cd                	jne    dc70 <fwp_gc_report+0x200>
    dca3:	48 89 ef             	mov    %rbp,%rdi
    dca6:	31 f6                	xor    %esi,%esi
    dca8:	ba 0a 00 00 00       	mov    $0xa,%edx
    dcad:	e8 1e 45 ff ff       	call   21d0 <strtol@plt>
    dcb2:	49 89 c4             	mov    %rax,%r12
    dcb5:	eb b9                	jmp    dc70 <fwp_gc_report+0x200>
    dcb7:	66 0f 1f 84 00 00 00 	nopw   0x0(%rax,%rax,1)
    dcbe:	00 00 

000000000000dcc0 <fwp_segv>:
    dcc0:	48 8b 05 31 5f 00 00 	mov    0x5f31(%rip),%rax        # 13bf8 <fwp_main_stack_top>
    dcc7:	48 85 c0             	test   %rax,%rax
    dcca:	74 22                	je     dcee <fwp_segv+0x2e>
    dccc:	48 8b 4e 10          	mov    0x10(%rsi),%rcx
    dcd0:	48 2b 05 29 5f 00 00 	sub    0x5f29(%rip),%rax        # 13c00 <fwp_main_stack_size>
    dcd7:	48 8d 90 00 00 f0 ff 	lea    -0x100000(%rax),%rdx
    dcde:	48 39 ca             	cmp    %rcx,%rdx
    dce1:	77 0b                	ja     dcee <fwp_segv+0x2e>
    dce3:	48 05 00 00 10 00    	add    $0x100000,%rax
    dce9:	48 39 c8             	cmp    %rcx,%rax
    dcec:	77 07                	ja     dcf5 <fwp_segv+0x35>
    dcee:	31 f6                	xor    %esi,%esi
    dcf0:	e9 9b 44 ff ff       	jmp    2190 <signal@plt>
    dcf5:	50                   	push   %rax
    dcf6:	e8 25 85 ff ff       	call   6220 <fwp_flush>
    dcfb:	48 8d 35 3e 15 00 00 	lea    0x153e(%rip),%rsi        # f240 <fwp_segv.msg>
    dd02:	ba 1a 00 00 00       	mov    $0x1a,%edx
    dd07:	bf 02 00 00 00       	mov    $0x2,%edi
    dd0c:	e8 af 43 ff ff       	call   20c0 <write@plt>
    dd11:	bf 65 00 00 00       	mov    $0x65,%edi
    dd16:	e8 55 43 ff ff       	call   2070 <_exit@plt>
    dd1b:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)

000000000000dd20 <fwp_drop0>:
    dd20:	53                   	push   %rbx
    dd21:	48 89 f8             	mov    %rdi,%rax
    dd24:	48 2b 05 85 54 00 00 	sub    0x5485(%rip),%rax        # 131b0 <fwp_gc+0x1030>
    dd2b:	48 8b 0d a6 54 00 00 	mov    0x54a6(%rip),%rcx        # 131d8 <fwp_gc+0x1058>
    dd32:	48 c1 e1 10          	shl    $0x10,%rcx
    dd36:	48 39 c8             	cmp    %rcx,%rax
    dd39:	0f 83 96 00 00 00    	jae    ddd5 <fwp_drop0+0xb5>
    dd3f:	48 8b 0d b2 54 00 00 	mov    0x54b2(%rip),%rcx        # 131f8 <fwp_gc+0x1078>
    dd46:	48 89 c2             	mov    %rax,%rdx
    dd49:	48 c1 ea 10          	shr    $0x10,%rdx
    dd4d:	48 69 d2 28 12 00 00 	imul   $0x1228,%rdx,%rdx
    dd54:	0f b6 34 11          	movzbl (%rcx,%rdx,1),%esi
    dd58:	48 25 ff ff 00 00    	and    $0xffff,%rax
    dd5e:	75 20                	jne    dd80 <fwp_drop0+0x60>
    dd60:	40 80 fe 02          	cmp    $0x2,%sil
    dd64:	75 1a                	jne    dd80 <fwp_drop0+0x60>
    dd66:	48 8d 04 11          	lea    (%rcx,%rdx,1),%rax
    dd6a:	48 05 28 02 00 00    	add    $0x228,%rax
    dd70:	eb 2d                	jmp    dd9f <fwp_drop0+0x7f>
    dd72:	66 66 66 66 66 2e 0f 	data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    dd79:	1f 84 00 00 00 00 00 
    dd80:	40 80 fe 01          	cmp    $0x1,%sil
    dd84:	75 4f                	jne    ddd5 <fwp_drop0+0xb5>
    dd86:	48 8d 34 11          	lea    (%rcx,%rdx,1),%rsi
    dd8a:	8b 4c 11 20          	mov    0x20(%rcx,%rdx,1),%ecx
    dd8e:	48 0f af c1          	imul   %rcx,%rax
    dd92:	48 c1 e8 20          	shr    $0x20,%rax
    dd96:	48 01 f0             	add    %rsi,%rax
    dd99:	48 05 28 02 00 00    	add    $0x228,%rax
    dd9f:	0f b6 08             	movzbl (%rax),%ecx
    dda2:	85 c9                	test   %ecx,%ecx
    dda4:	74 2f                	je     ddd5 <fwp_drop0+0xb5>
    dda6:	83 f9 01             	cmp    $0x1,%ecx
    dda9:	75 2c                	jne    ddd7 <fwp_drop0+0xb7>
    ddab:	48 8b 5f 10          	mov    0x10(%rdi),%rbx
    ddaf:	e8 8c ca ff ff       	call   a840 <fwp_rc_free_obj>
    ddb4:	48 89 d8             	mov    %rbx,%rax
    ddb7:	48 2b 05 f2 53 00 00 	sub    0x53f2(%rip),%rax        # 131b0 <fwp_gc+0x1030>
    ddbe:	48 8b 0d 13 54 00 00 	mov    0x5413(%rip),%rcx        # 131d8 <fwp_gc+0x1058>
    ddc5:	48 c1 e1 10          	shl    $0x10,%rcx
    ddc9:	48 89 df             	mov    %rbx,%rdi
    ddcc:	48 39 c8             	cmp    %rcx,%rax
    ddcf:	0f 82 6a ff ff ff    	jb     dd3f <fwp_drop0+0x1f>
    ddd5:	5b                   	pop    %rbx
    ddd6:	c3                   	ret
    ddd7:	81 f9 ff 00 00 00    	cmp    $0xff,%ecx
    dddd:	74 06                	je     dde5 <fwp_drop0+0xc5>
    dddf:	fe c9                	dec    %cl
    dde1:	88 08                	mov    %cl,(%rax)
    dde3:	5b                   	pop    %rbx
    dde4:	c3                   	ret
    dde5:	48 89 c7             	mov    %rax,%rdi
    dde8:	5b                   	pop    %rbx
    dde9:	e9 72 c7 ff ff       	jmp    a560 <fwp_rc_wide_drop>
    ddee:	66 90                	xchg   %ax,%ax

000000000000ddf0 <fwp_drop4>:
    ddf0:	53                   	push   %rbx
    ddf1:	48 89 f8             	mov    %rdi,%rax
    ddf4:	48 2b 05 b5 53 00 00 	sub    0x53b5(%rip),%rax        # 131b0 <fwp_gc+0x1030>
    ddfb:	48 8b 0d d6 53 00 00 	mov    0x53d6(%rip),%rcx        # 131d8 <fwp_gc+0x1058>
    de02:	48 c1 e1 10          	shl    $0x10,%rcx
    de06:	48 39 c8             	cmp    %rcx,%rax
    de09:	0f 83 96 00 00 00    	jae    dea5 <fwp_drop4+0xb5>
    de0f:	48 8b 0d e2 53 00 00 	mov    0x53e2(%rip),%rcx        # 131f8 <fwp_gc+0x1078>
    de16:	48 89 c2             	mov    %rax,%rdx
    de19:	48 c1 ea 10          	shr    $0x10,%rdx
    de1d:	48 69 d2 28 12 00 00 	imul   $0x1228,%rdx,%rdx
    de24:	0f b6 34 11          	movzbl (%rcx,%rdx,1),%esi
    de28:	48 25 ff ff 00 00    	and    $0xffff,%rax
    de2e:	75 20                	jne    de50 <fwp_drop4+0x60>
    de30:	40 80 fe 02          	cmp    $0x2,%sil
    de34:	75 1a                	jne    de50 <fwp_drop4+0x60>
    de36:	48 8d 04 11          	lea    (%rcx,%rdx,1),%rax
    de3a:	48 05 28 02 00 00    	add    $0x228,%rax
    de40:	eb 2d                	jmp    de6f <fwp_drop4+0x7f>
    de42:	66 66 66 66 66 2e 0f 	data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    de49:	1f 84 00 00 00 00 00 
    de50:	40 80 fe 01          	cmp    $0x1,%sil
    de54:	75 4f                	jne    dea5 <fwp_drop4+0xb5>
    de56:	48 8d 34 11          	lea    (%rcx,%rdx,1),%rsi
    de5a:	8b 4c 11 20          	mov    0x20(%rcx,%rdx,1),%ecx
    de5e:	48 0f af c1          	imul   %rcx,%rax
    de62:	48 c1 e8 20          	shr    $0x20,%rax
    de66:	48 01 f0             	add    %rsi,%rax
    de69:	48 05 28 02 00 00    	add    $0x228,%rax
    de6f:	0f b6 08             	movzbl (%rax),%ecx
    de72:	85 c9                	test   %ecx,%ecx
    de74:	74 2f                	je     dea5 <fwp_drop4+0xb5>
    de76:	83 f9 01             	cmp    $0x1,%ecx
    de79:	75 2c                	jne    dea7 <fwp_drop4+0xb7>
    de7b:	48 8b 5f 10          	mov    0x10(%rdi),%rbx
    de7f:	e8 bc c9 ff ff       	call   a840 <fwp_rc_free_obj>
    de84:	48 89 d8             	mov    %rbx,%rax
    de87:	48 2b 05 22 53 00 00 	sub    0x5322(%rip),%rax        # 131b0 <fwp_gc+0x1030>
    de8e:	48 8b 0d 43 53 00 00 	mov    0x5343(%rip),%rcx        # 131d8 <fwp_gc+0x1058>
    de95:	48 c1 e1 10          	shl    $0x10,%rcx
    de99:	48 89 df             	mov    %rbx,%rdi
    de9c:	48 39 c8             	cmp    %rcx,%rax
    de9f:	0f 82 6a ff ff ff    	jb     de0f <fwp_drop4+0x1f>
    dea5:	5b                   	pop    %rbx
    dea6:	c3                   	ret
    dea7:	81 f9 ff 00 00 00    	cmp    $0xff,%ecx
    dead:	74 06                	je     deb5 <fwp_drop4+0xc5>
    deaf:	fe c9                	dec    %cl
    deb1:	88 08                	mov    %cl,(%rax)
    deb3:	5b                   	pop    %rbx
    deb4:	c3                   	ret
    deb5:	48 89 c7             	mov    %rax,%rdi
    deb8:	5b                   	pop    %rbx
    deb9:	e9 a2 c6 ff ff       	jmp    a560 <fwp_rc_wide_drop>
    debe:	66 90                	xchg   %ax,%ax

000000000000dec0 <__divti3>:
    dec0:	f3 0f 1e fa          	endbr64
    dec4:	55                   	push   %rbp
    dec5:	49 89 f8             	mov    %rdi,%r8
    dec8:	49 89 d2             	mov    %rdx,%r10
    decb:	49 89 cb             	mov    %rcx,%r11
    dece:	31 ff                	xor    %edi,%edi
    ded0:	48 89 e5             	mov    %rsp,%rbp
    ded3:	41 56                	push   %r14
    ded5:	53                   	push   %rbx
    ded6:	48 85 f6             	test   %rsi,%rsi
    ded9:	79 13                	jns    deee <__divti3+0x2e>
    dedb:	45 31 c9             	xor    %r9d,%r9d
    dede:	49 f7 d8             	neg    %r8
    dee1:	48 c7 c7 ff ff ff ff 	mov    $0xffffffffffffffff,%rdi
    dee8:	49 19 f1             	sbb    %rsi,%r9
    deeb:	4c 89 ce             	mov    %r9,%rsi
    deee:	4c 89 da             	mov    %r11,%rdx
    def1:	4d 85 db             	test   %r11,%r11
    def4:	0f 88 f6 00 00 00    	js     dff0 <__divti3+0x130>
    defa:	4d 89 d6             	mov    %r10,%r14
    defd:	75 31                	jne    df30 <__divti3+0x70>
    deff:	4c 39 f6             	cmp    %r14,%rsi
    df02:	0f 83 b8 00 00 00    	jae    dfc0 <__divti3+0x100>
    df08:	48 89 f2             	mov    %rsi,%rdx
    df0b:	31 f6                	xor    %esi,%esi
    df0d:	4c 89 c0             	mov    %r8,%rax
    df10:	49 f7 f6             	div    %r14
    df13:	48 89 f2             	mov    %rsi,%rdx
    df16:	48 85 ff             	test   %rdi,%rdi
    df19:	74 0a                	je     df25 <__divti3+0x65>
    df1b:	48 f7 d8             	neg    %rax
    df1e:	48 83 d2 00          	adc    $0x0,%rdx
    df22:	48 f7 da             	neg    %rdx
    df25:	5b                   	pop    %rbx
    df26:	41 5e                	pop    %r14
    df28:	5d                   	pop    %rbp
    df29:	c3                   	ret
    df2a:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)
    df30:	4c 39 de             	cmp    %r11,%rsi
    df33:	0f 82 d5 00 00 00    	jb     e00e <__divti3+0x14e>
    df39:	4d 0f bd d3          	bsr    %r11,%r10
    df3d:	41 83 f2 3f          	xor    $0x3f,%r10d
    df41:	44 89 d1             	mov    %r10d,%ecx
    df44:	b8 40 00 00 00       	mov    $0x40,%eax
    df49:	4c 89 f3             	mov    %r14,%rbx
    df4c:	4d 89 f1             	mov    %r14,%r9
    df4f:	48 d3 e2             	shl    %cl,%rdx
    df52:	49 63 ca             	movslq %r10d,%rcx
    df55:	49 89 f3             	mov    %rsi,%r11
    df58:	48 29 c8             	sub    %rcx,%rax
    df5b:	89 c1                	mov    %eax,%ecx
    df5d:	48 d3 eb             	shr    %cl,%rbx
    df60:	44 89 d1             	mov    %r10d,%ecx
    df63:	49 d3 e1             	shl    %cl,%r9
    df66:	89 c1                	mov    %eax,%ecx
    df68:	48 09 d3             	or     %rdx,%rbx
    df6b:	4c 89 c2             	mov    %r8,%rdx
    df6e:	49 d3 eb             	shr    %cl,%r11
    df71:	44 89 d1             	mov    %r10d,%ecx
    df74:	48 d3 e6             	shl    %cl,%rsi
    df77:	89 c1                	mov    %eax,%ecx
    df79:	48 d3 ea             	shr    %cl,%rdx
    df7c:	48 89 d0             	mov    %rdx,%rax
    df7f:	4c 89 da             	mov    %r11,%rdx
    df82:	48 09 f0             	or     %rsi,%rax
    df85:	48 f7 f3             	div    %rbx
    df88:	49 89 d3             	mov    %rdx,%r11
    df8b:	48 89 c6             	mov    %rax,%rsi
    df8e:	49 f7 e1             	mul    %r9
    df91:	49 39 d3             	cmp    %rdx,%r11
    df94:	0f 82 be 00 00 00    	jb     e058 <__divti3+0x198>
    df9a:	44 89 d1             	mov    %r10d,%ecx
    df9d:	49 d3 e0             	shl    %cl,%r8
    dfa0:	49 39 c0             	cmp    %rax,%r8
    dfa3:	73 09                	jae    dfae <__divti3+0xee>
    dfa5:	49 39 d3             	cmp    %rdx,%r11
    dfa8:	0f 84 aa 00 00 00    	je     e058 <__divti3+0x198>
    dfae:	48 89 f0             	mov    %rsi,%rax
    dfb1:	31 f6                	xor    %esi,%esi
    dfb3:	e9 5b ff ff ff       	jmp    df13 <__divti3+0x53>
    dfb8:	0f 1f 84 00 00 00 00 	nopl   0x0(%rax,%rax,1)
    dfbf:	00 
    dfc0:	4d 85 f6             	test   %r14,%r14
    dfc3:	75 0d                	jne    dfd2 <__divti3+0x112>
    dfc5:	b8 01 00 00 00       	mov    $0x1,%eax
    dfca:	31 d2                	xor    %edx,%edx
    dfcc:	49 f7 f6             	div    %r14
    dfcf:	49 89 c6             	mov    %rax,%r14
    dfd2:	48 89 f0             	mov    %rsi,%rax
    dfd5:	31 d2                	xor    %edx,%edx
    dfd7:	49 f7 f6             	div    %r14
    dfda:	48 89 c6             	mov    %rax,%rsi
    dfdd:	4c 89 c0             	mov    %r8,%rax
    dfe0:	49 f7 f6             	div    %r14
    dfe3:	e9 2b ff ff ff       	jmp    df13 <__divti3+0x53>
    dfe8:	0f 1f 84 00 00 00 00 	nopl   0x0(%rax,%rax,1)
    dfef:	00 
    dff0:	49 f7 da             	neg    %r10
    dff3:	48 f7 d7             	not    %rdi
    dff6:	49 83 d3 00          	adc    $0x0,%r11
    dffa:	4d 89 d6             	mov    %r10,%r14
    dffd:	49 f7 db             	neg    %r11
    e000:	4c 89 da             	mov    %r11,%rdx
    e003:	0f 84 f6 fe ff ff    	je     deff <__divti3+0x3f>
    e009:	4c 39 de             	cmp    %r11,%rsi
    e00c:	73 12                	jae    e020 <__divti3+0x160>
    e00e:	31 f6                	xor    %esi,%esi
    e010:	31 c0                	xor    %eax,%eax
    e012:	e9 fc fe ff ff       	jmp    df13 <__divti3+0x53>
    e017:	66 0f 1f 84 00 00 00 	nopw   0x0(%rax,%rax,1)
    e01e:	00 00 
    e020:	49 0f bd c3          	bsr    %r11,%rax
    e024:	48 83 f0 3f          	xor    $0x3f,%rax
    e028:	41 89 c2             	mov    %eax,%r10d
    e02b:	85 c0                	test   %eax,%eax
    e02d:	0f 85 0e ff ff ff    	jne    df41 <__divti3+0x81>
    e033:	49 39 f3             	cmp    %rsi,%r11
    e036:	72 0d                	jb     e045 <__divti3+0x185>
    e038:	31 f6                	xor    %esi,%esi
    e03a:	31 c0                	xor    %eax,%eax
    e03c:	4d 39 f0             	cmp    %r14,%r8
    e03f:	0f 82 ce fe ff ff    	jb     df13 <__divti3+0x53>
    e045:	31 f6                	xor    %esi,%esi
    e047:	b8 01 00 00 00       	mov    $0x1,%eax
    e04c:	e9 c2 fe ff ff       	jmp    df13 <__divti3+0x53>
    e051:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)
    e058:	48 8d 46 ff          	lea    -0x1(%rsi),%rax
    e05c:	31 f6                	xor    %esi,%esi
    e05e:	e9 b0 fe ff ff       	jmp    df13 <__divti3+0x53>
    e063:	66 2e 0f 1f 84 00 00 	cs nopw 0x0(%rax,%rax,1)
    e06a:	00 00 00 
    e06d:	0f 1f 00             	nopl   (%rax)

000000000000e070 <atexit>:
    e070:	f3 0f 1e fa          	endbr64
    e074:	48 8b 15 f5 40 00 00 	mov    0x40f5(%rip),%rdx        # 12170 <__dso_handle>
    e07b:	31 f6                	xor    %esi,%esi
    e07d:	e9 ee 41 ff ff       	jmp    2270 <__cxa_atexit@plt>

Disassembly of section .fini:

000000000000e084 <_fini>:
    e084:	f3 0f 1e fa          	endbr64
    e088:	48 83 ec 08          	sub    $0x8,%rsp
    e08c:	48 83 c4 08          	add    $0x8,%rsp
    e090:	c3                   	ret
