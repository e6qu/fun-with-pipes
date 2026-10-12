
/tmp/fwp-arc-3169/arrays-0-O2:     file format elf64-x86-64


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
    256d:	e8 5e 43 00 00       	call   68d0 <fwp_gc_init>
    2572:	48 89 2d 8f 0c 01 00 	mov    %rbp,0x10c8f(%rip)        # 13208 <fwp_gc+0x1088>
    2579:	48 8d 3d e0 b4 00 00 	lea    0xb4e0(%rip),%rdi        # da60 <fwp_gc_find_data>
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
    25af:	48 8d 3d 8a b5 00 00 	lea    0xb58a(%rip),%rdi        # db40 <fwp_gc_report>
    25b6:	e8 85 bb 00 00       	call   e140 <atexit>
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
    26a5:	48 8d 05 e4 b6 00 00 	lea    0xb6e4(%rip),%rax        # dd90 <fwp_segv>
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
    2726:	e8 c5 76 00 00       	call   9df0 <fwp_data>
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
    27b1:	e8 6a 3b 00 00       	call   6320 <fwp_rc_forget_slot>
    27b6:	48 89 d8             	mov    %rbx,%rax
    27b9:	eb c3                	jmp    277e <fwp_main_thread+0x22e>
    27bb:	48 b9 00 00 00 00 00 	movabs $0x3fd0000000000000,%rcx
    27c2:	00 d0 3f 
    27c5:	48 89 4d a0          	mov    %rcx,-0x60(%rbp)
    27c9:	48 89 45 a8          	mov    %rax,-0x58(%rbp)
    27cd:	48 8d 55 a0          	lea    -0x60(%rbp),%rdx
    27d1:	bf 01 00 00 00       	mov    $0x1,%edi
    27d6:	be 02 00 00 00       	mov    $0x2,%esi
    27db:	e8 10 76 00 00       	call   9df0 <fwp_data>
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
    2866:	e8 b5 3a 00 00       	call   6320 <fwp_rc_forget_slot>
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
    289d:	e8 4e 75 00 00       	call   9df0 <fwp_data>
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
    2928:	e8 f3 39 00 00       	call   6320 <fwp_rc_forget_slot>
    292d:	48 89 d8             	mov    %rbx,%rax
    2930:	eb c3                	jmp    28f5 <fwp_main_thread+0x3a5>
    2932:	48 b9 00 00 00 00 00 	movabs $0x3ff8000000000000,%rcx
    2939:	00 f8 3f 
    293c:	48 89 8d b0 fe ff ff 	mov    %rcx,-0x150(%rbp)
    2943:	48 89 85 b8 fe ff ff 	mov    %rax,-0x148(%rbp)
    294a:	48 8d 95 b0 fe ff ff 	lea    -0x150(%rbp),%rdx
    2951:	bf 01 00 00 00       	mov    $0x1,%edi
    2956:	be 02 00 00 00       	mov    $0x2,%esi
    295b:	e8 90 74 00 00       	call   9df0 <fwp_data>
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
    29e2:	e8 39 39 00 00       	call   6320 <fwp_rc_forget_slot>
    29e7:	eb c9                	jmp    29b2 <fwp_main_thread+0x462>
    29e9:	48 8d 35 60 f2 00 00 	lea    0xf260(%rip),%rsi        # 11c50 <d0>
    29f0:	4c 89 f7             	mov    %r14,%rdi
    29f3:	e8 d8 39 00 00       	call   63d0 <fwp_p_array_from_list_typed>
    29f8:	49 89 c7             	mov    %rax,%r15
    29fb:	4c 89 f7             	mov    %r14,%rdi
    29fe:	e8 ed b3 00 00       	call   ddf0 <fwp_drop0>
    2a03:	31 db                	xor    %ebx,%ebx
    2a05:	be 04 00 00 00       	mov    $0x4,%esi
    2a0a:	31 ff                	xor    %edi,%edi
    2a0c:	4c 89 fa             	mov    %r15,%rdx
    2a0f:	e8 ac 48 00 00       	call   72c0 <f12>
    2a14:	49 89 c6             	mov    %rax,%r14
    2a17:	4c 89 ff             	mov    %r15,%rdi
    2a1a:	e8 21 7a 00 00       	call   a440 <fwp_drop1>
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
    2a73:	e8 c8 79 00 00       	call   a440 <fwp_drop1>
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
    2ad4:	e8 87 4c 00 00       	call   7760 <fwp_show>
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
    2b5b:	e8 c0 37 00 00       	call   6320 <fwp_rc_forget_slot>
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
    2c0c:	e8 ff 7c 00 00       	call   a910 <fwp_rc_free_obj>
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
    2c52:	e8 99 71 00 00       	call   9df0 <fwp_data>
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
    2cdd:	e8 3e 36 00 00       	call   6320 <fwp_rc_forget_slot>
    2ce2:	48 89 d8             	mov    %rbx,%rax
    2ce5:	eb c3                	jmp    2caa <fwp_main_thread+0x75a>
    2ce7:	48 c7 85 d0 fe ff ff 	movq   $0x3e800000,-0x130(%rbp)
    2cee:	00 00 80 3e 
    2cf2:	48 89 85 d8 fe ff ff 	mov    %rax,-0x128(%rbp)
    2cf9:	48 8d 95 d0 fe ff ff 	lea    -0x130(%rbp),%rdx
    2d00:	bf 01 00 00 00       	mov    $0x1,%edi
    2d05:	be 02 00 00 00       	mov    $0x2,%esi
    2d0a:	e8 e1 70 00 00       	call   9df0 <fwp_data>
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
    2d95:	e8 86 35 00 00       	call   6320 <fwp_rc_forget_slot>
    2d9a:	48 89 d8             	mov    %rbx,%rax
    2d9d:	eb c3                	jmp    2d62 <fwp_main_thread+0x812>
    2d9f:	4c 89 bd e0 fe ff ff 	mov    %r15,-0x120(%rbp)
    2da6:	48 89 85 e8 fe ff ff 	mov    %rax,-0x118(%rbp)
    2dad:	48 8d 95 e0 fe ff ff 	lea    -0x120(%rbp),%rdx
    2db4:	bf 01 00 00 00       	mov    $0x1,%edi
    2db9:	be 02 00 00 00       	mov    $0x2,%esi
    2dbe:	e8 2d 70 00 00       	call   9df0 <fwp_data>
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
    2e49:	e8 d2 34 00 00       	call   6320 <fwp_rc_forget_slot>
    2e4e:	48 89 d8             	mov    %rbx,%rax
    2e51:	eb c3                	jmp    2e16 <fwp_main_thread+0x8c6>
    2e53:	48 c7 85 f0 fe ff ff 	movq   $0x3fc00000,-0x110(%rbp)
    2e5a:	00 00 c0 3f 
    2e5e:	48 89 85 f8 fe ff ff 	mov    %rax,-0x108(%rbp)
    2e65:	48 8d 95 f0 fe ff ff 	lea    -0x110(%rbp),%rdx
    2e6c:	bf 01 00 00 00       	mov    $0x1,%edi
    2e71:	be 02 00 00 00       	mov    $0x2,%esi
    2e76:	e8 75 6f 00 00       	call   9df0 <fwp_data>
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
    2efd:	e8 1e 34 00 00       	call   6320 <fwp_rc_forget_slot>
    2f02:	eb c9                	jmp    2ecd <fwp_main_thread+0x97d>
    2f04:	48 8d 35 05 ee 00 00 	lea    0xee05(%rip),%rsi        # 11d10 <d2>
    2f0b:	4c 89 ff             	mov    %r15,%rdi
    2f0e:	e8 bd 34 00 00       	call   63d0 <fwp_p_array_from_list_typed>
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
    2f9d:	e8 6e 79 00 00       	call   a910 <fwp_rc_free_obj>
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
    2ff3:	e8 48 96 00 00       	call   c640 <fwp_drop7>
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
    3066:	e8 f5 46 00 00       	call   7760 <fwp_show>
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
    30ed:	e8 2e 32 00 00       	call   6320 <fwp_rc_forget_slot>
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
    319e:	e8 6d 77 00 00       	call   a910 <fwp_rc_free_obj>
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
    31db:	e8 10 6c 00 00       	call   9df0 <fwp_data>
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
    3266:	e8 b5 30 00 00       	call   6320 <fwp_rc_forget_slot>
    326b:	48 89 d8             	mov    %rbx,%rax
    326e:	eb c3                	jmp    3233 <fwp_main_thread+0xce3>
    3270:	48 c7 85 10 ff ff ff 	movq   $0x0,-0xf0(%rbp)
    3277:	00 00 00 00 
    327b:	48 89 85 18 ff ff ff 	mov    %rax,-0xe8(%rbp)
    3282:	48 8d 95 10 ff ff ff 	lea    -0xf0(%rbp),%rdx
    3289:	bf 01 00 00 00       	mov    $0x1,%edi
    328e:	be 02 00 00 00       	mov    $0x2,%esi
    3293:	e8 58 6b 00 00       	call   9df0 <fwp_data>
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
    331e:	e8 fd 2f 00 00       	call   6320 <fwp_rc_forget_slot>
    3323:	48 89 d8             	mov    %rbx,%rax
    3326:	eb c3                	jmp    32eb <fwp_main_thread+0xd9b>
    3328:	48 c7 85 20 ff ff ff 	movq   $0xffffffffffffff80,-0xe0(%rbp)
    332f:	80 ff ff ff 
    3333:	48 89 85 28 ff ff ff 	mov    %rax,-0xd8(%rbp)
    333a:	48 8d 95 20 ff ff ff 	lea    -0xe0(%rbp),%rdx
    3341:	bf 01 00 00 00       	mov    $0x1,%edi
    3346:	be 02 00 00 00       	mov    $0x2,%esi
    334b:	e8 a0 6a 00 00       	call   9df0 <fwp_data>
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
    33d2:	e8 49 2f 00 00       	call   6320 <fwp_rc_forget_slot>
    33d7:	eb c9                	jmp    33a2 <fwp_main_thread+0xe52>
    33d9:	48 8d 35 d0 e8 00 00 	lea    0xe8d0(%rip),%rsi        # 11cb0 <d1>
    33e0:	4c 89 ff             	mov    %r15,%rdi
    33e3:	e8 e8 2f 00 00       	call   63d0 <fwp_p_array_from_list_typed>
    33e8:	49 89 c6             	mov    %rax,%r14
    33eb:	4c 89 ff             	mov    %r15,%rdi
    33ee:	e8 cd aa 00 00       	call   dec0 <fwp_drop4>
    33f3:	31 db                	xor    %ebx,%ebx
    33f5:	45 31 ff             	xor    %r15d,%r15d
    33f8:	45 31 e4             	xor    %r12d,%r12d
    33fb:	45 31 ed             	xor    %r13d,%r13d
    33fe:	31 ff                	xor    %edi,%edi
    3400:	eb 22                	jmp    3424 <fwp_main_thread+0xed4>
    3402:	66 66 66 66 66 2e 0f 	data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    3409:	1f 84 00 00 00 00 00 
    3410:	4c 89 f7             	mov    %r14,%rdi
    3413:	e8 f8 98 00 00       	call   cd10 <fwp_drop9>
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
    347b:	e8 d0 66 00 00       	call   9b50 <fwp_show_i64>
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
    3502:	e8 19 2e 00 00       	call   6320 <fwp_rc_forget_slot>
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
    35b3:	e8 58 73 00 00       	call   a910 <fwp_rc_free_obj>
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
    35f0:	e8 fb 67 00 00       	call   9df0 <fwp_data>
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
    367b:	e8 a0 2c 00 00       	call   6320 <fwp_rc_forget_slot>
    3680:	48 89 d8             	mov    %rbx,%rax
    3683:	eb c3                	jmp    3648 <fwp_main_thread+0x10f8>
    3685:	48 c7 85 40 ff ff ff 	movq   $0x2,-0xc0(%rbp)
    368c:	02 00 00 00 
    3690:	48 89 85 48 ff ff ff 	mov    %rax,-0xb8(%rbp)
    3697:	48 8d 95 40 ff ff ff 	lea    -0xc0(%rbp),%rdx
    369e:	bf 01 00 00 00       	mov    $0x1,%edi
    36a3:	be 02 00 00 00       	mov    $0x2,%esi
    36a8:	e8 43 67 00 00       	call   9df0 <fwp_data>
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
    3733:	e8 e8 2b 00 00       	call   6320 <fwp_rc_forget_slot>
    3738:	48 89 d8             	mov    %rbx,%rax
    373b:	eb c3                	jmp    3700 <fwp_main_thread+0x11b0>
    373d:	48 c7 85 50 ff ff ff 	movq   $0x1,-0xb0(%rbp)
    3744:	01 00 00 00 
    3748:	48 89 85 58 ff ff ff 	mov    %rax,-0xa8(%rbp)
    374f:	48 8d 95 50 ff ff ff 	lea    -0xb0(%rbp),%rdx
    3756:	bf 01 00 00 00       	mov    $0x1,%edi
    375b:	be 02 00 00 00       	mov    $0x2,%esi
    3760:	e8 8b 66 00 00       	call   9df0 <fwp_data>
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
    37e7:	e8 34 2b 00 00       	call   6320 <fwp_rc_forget_slot>
    37ec:	eb c9                	jmp    37b7 <fwp_main_thread+0x1267>
    37ee:	48 8d 35 bb e4 00 00 	lea    0xe4bb(%rip),%rsi        # 11cb0 <d1>
    37f5:	4c 89 ff             	mov    %r15,%rdi
    37f8:	e8 d3 2b 00 00       	call   63d0 <fwp_p_array_from_list_typed>
    37fd:	49 89 c6             	mov    %rax,%r14
    3800:	4c 89 ff             	mov    %r15,%rdi
    3803:	e8 b8 a6 00 00       	call   dec0 <fwp_drop4>
    3808:	31 db                	xor    %ebx,%ebx
    380a:	45 31 ff             	xor    %r15d,%r15d
    380d:	45 31 e4             	xor    %r12d,%r12d
    3810:	45 31 ed             	xor    %r13d,%r13d
    3813:	31 ff                	xor    %edi,%edi
    3815:	eb 1d                	jmp    3834 <fwp_main_thread+0x12e4>
    3817:	66 0f 1f 84 00 00 00 	nopw   0x0(%rax,%rax,1)
    381e:	00 00 
    3820:	4c 89 f7             	mov    %r14,%rdi
    3823:	e8 e8 94 00 00       	call   cd10 <fwp_drop9>
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
    3896:	e8 b5 62 00 00       	call   9b50 <fwp_show_i64>
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
    391d:	e8 fe 29 00 00       	call   6320 <fwp_rc_forget_slot>
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
    39ce:	e8 3d 6f 00 00       	call   a910 <fwp_rc_free_obj>
    39d3:	eb 0f                	jmp    39e4 <fwp_main_thread+0x1494>
    39d5:	3d ff 00 00 00       	cmp    $0xff,%eax
    39da:	0f 84 21 07 00 00    	je     4101 <fwp_main_thread+0x1bb1>
    39e0:	fe c8                	dec    %al
    39e2:	88 07                	mov    %al,(%rdi)
    39e4:	48 8d 35 65 e2 00 00 	lea    0xe265(%rip),%rsi        # 11c50 <d0>
    39eb:	31 db                	xor    %ebx,%ebx
    39ed:	31 ff                	xor    %edi,%edi
    39ef:	e8 dc 2a 00 00       	call   64d0 <fwp_array_typed_new>
    39f4:	49 89 c6             	mov    %rax,%r14
    39f7:	31 ff                	xor    %edi,%edi
    39f9:	e8 f2 a3 00 00       	call   ddf0 <fwp_drop0>
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
    3a63:	e8 d8 69 00 00       	call   a440 <fwp_drop1>
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
    3ac4:	e8 97 3c 00 00       	call   7760 <fwp_show>
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
    3b4b:	e8 d0 27 00 00       	call   6320 <fwp_rc_forget_slot>
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
    3bfc:	e8 0f 6d 00 00       	call   a910 <fwp_rc_free_obj>
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
    3c2f:	e8 bc 61 00 00       	call   9df0 <fwp_data>
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
    3cba:	e8 61 26 00 00       	call   6320 <fwp_rc_forget_slot>
    3cbf:	48 89 d8             	mov    %rbx,%rax
    3cc2:	eb c3                	jmp    3c87 <fwp_main_thread+0x1737>
    3cc4:	48 c7 85 60 ff ff ff 	movq   $0x0,-0xa0(%rbp)
    3ccb:	00 00 00 00 
    3ccf:	48 89 85 68 ff ff ff 	mov    %rax,-0x98(%rbp)
    3cd6:	48 8d 95 60 ff ff ff 	lea    -0xa0(%rbp),%rdx
    3cdd:	bf 01 00 00 00       	mov    $0x1,%edi
    3ce2:	be 02 00 00 00       	mov    $0x2,%esi
    3ce7:	e8 04 61 00 00       	call   9df0 <fwp_data>
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
    3d72:	e8 a9 25 00 00       	call   6320 <fwp_rc_forget_slot>
    3d77:	48 89 d8             	mov    %rbx,%rax
    3d7a:	eb c3                	jmp    3d3f <fwp_main_thread+0x17ef>
    3d7c:	48 c7 85 70 ff ff ff 	movq   $0x0,-0x90(%rbp)
    3d83:	00 00 00 00 
    3d87:	48 89 85 78 ff ff ff 	mov    %rax,-0x88(%rbp)
    3d8e:	48 8d 95 70 ff ff ff 	lea    -0x90(%rbp),%rdx
    3d95:	bf 01 00 00 00       	mov    $0x1,%edi
    3d9a:	be 02 00 00 00       	mov    $0x2,%esi
    3d9f:	e8 4c 60 00 00       	call   9df0 <fwp_data>
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
    3e2a:	e8 f1 24 00 00       	call   6320 <fwp_rc_forget_slot>
    3e2f:	48 89 d8             	mov    %rbx,%rax
    3e32:	eb c3                	jmp    3df7 <fwp_main_thread+0x18a7>
    3e34:	48 c7 45 80 00 00 00 	movq   $0x0,-0x80(%rbp)
    3e3b:	00 
    3e3c:	48 89 45 88          	mov    %rax,-0x78(%rbp)
    3e40:	48 8d 55 80          	lea    -0x80(%rbp),%rdx
    3e44:	bf 01 00 00 00       	mov    $0x1,%edi
    3e49:	be 02 00 00 00       	mov    $0x2,%esi
    3e4e:	e8 9d 5f 00 00       	call   9df0 <fwp_data>
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
    3ed9:	e8 42 24 00 00       	call   6320 <fwp_rc_forget_slot>
    3ede:	48 89 d8             	mov    %rbx,%rax
    3ee1:	eb c3                	jmp    3ea6 <fwp_main_thread+0x1956>
    3ee3:	48 c7 45 90 00 00 00 	movq   $0x0,-0x70(%rbp)
    3eea:	00 
    3eeb:	48 89 45 98          	mov    %rax,-0x68(%rbp)
    3eef:	48 8d 55 90          	lea    -0x70(%rbp),%rdx
    3ef3:	bf 01 00 00 00       	mov    $0x1,%edi
    3ef8:	be 02 00 00 00       	mov    $0x2,%esi
    3efd:	e8 ee 5e 00 00       	call   9df0 <fwp_data>
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
    3fad:	e8 6e 23 00 00       	call   6320 <fwp_rc_forget_slot>
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
    4028:	e8 e3 68 00 00       	call   a910 <fwp_rc_free_obj>
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
    40d2:	e8 59 65 00 00       	call   a630 <fwp_rc_wide_drop>
    40d7:	e9 f8 ee ff ff       	jmp    2fd4 <fwp_main_thread+0xa84>
    40dc:	e8 4f 65 00 00       	call   a630 <fwp_rc_wide_drop>
    40e1:	eb 84                	jmp    4067 <fwp_main_thread+0x1b17>
    40e3:	e8 48 65 00 00       	call   a630 <fwp_rc_wide_drop>
    40e8:	e9 35 eb ff ff       	jmp    2c22 <fwp_main_thread+0x6d2>
    40ed:	e8 3e 65 00 00       	call   a630 <fwp_rc_wide_drop>
    40f2:	e9 bd f0 ff ff       	jmp    31b4 <fwp_main_thread+0xc64>
    40f7:	e8 34 65 00 00       	call   a630 <fwp_rc_wide_drop>
    40fc:	e9 c8 f4 ff ff       	jmp    35c9 <fwp_main_thread+0x1079>
    4101:	e8 2a 65 00 00       	call   a630 <fwp_rc_wide_drop>
    4106:	e9 d9 f8 ff ff       	jmp    39e4 <fwp_main_thread+0x1494>
    410b:	e8 20 65 00 00       	call   a630 <fwp_rc_wide_drop>
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
    4149:	e8 a2 21 00 00       	call   62f0 <fwp_flush>
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
    4228:	e8 a3 21 00 00       	call   63d0 <fwp_p_array_from_list_typed>
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
    42a8:	e8 43 20 00 00       	call   62f0 <fwp_flush>
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
    4368:	e8 63 20 00 00       	call   63d0 <fwp_p_array_from_list_typed>
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
    43e8:	e8 03 1f 00 00       	call   62f0 <fwp_flush>
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
    44a8:	e8 23 1f 00 00       	call   63d0 <fwp_p_array_from_list_typed>
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
    4528:	e8 c3 1d 00 00       	call   62f0 <fwp_flush>
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
    45ed:	e8 ce 2c 00 00       	call   72c0 <f12>
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
    466d:	e8 7e 1c 00 00       	call   62f0 <fwp_flush>
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
    46ae:	e8 ad 30 00 00       	call   7760 <fwp_show>
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
    4754:	e8 c7 1b 00 00       	call   6320 <fwp_rc_forget_slot>
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
    47ca:	e8 21 1b 00 00       	call   62f0 <fwp_flush>
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
    4923:	e8 c8 19 00 00       	call   62f0 <fwp_flush>
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
    49eb:	e8 00 19 00 00       	call   62f0 <fwp_flush>
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
    4aab:	e8 40 18 00 00       	call   62f0 <fwp_flush>
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
    4ae7:	e8 64 50 00 00       	call   9b50 <fwp_show_i64>
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
    4b8d:	e8 8e 17 00 00       	call   6320 <fwp_rc_forget_slot>
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
    4c03:	e8 e8 16 00 00       	call   62f0 <fwp_flush>
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
    4cf4:	e8 f7 15 00 00       	call   62f0 <fwp_flush>
    4cf9:	48 8b 05 e0 d2 00 00 	mov    0xd2e0(%rip),%rax        # 11fe0 <stderr@GLIBC_2.2.5>
    4d00:	48 8b 38             	mov    (%rax),%rdi
    4d03:	48 8d 35 23 a7 00 00 	lea    0xa723(%rip),%rsi        # f42d <fwp_segv.msg+0x1ed>
    4d0a:	48 89 da             	mov    %rbx,%rdx
    4d0d:	eb 1d                	jmp    4d2c <e32+0xec>
    4d0f:	e8 dc 15 00 00       	call   62f0 <fwp_flush>
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
    4d47:	e8 04 4e 00 00       	call   9b50 <fwp_show_i64>
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
    4ded:	e8 2e 15 00 00       	call   6320 <fwp_rc_forget_slot>
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
    4e63:	e8 88 14 00 00       	call   62f0 <fwp_flush>
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
    4eae:	e8 ad 28 00 00       	call   7760 <fwp_show>
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
    4f54:	e8 c7 13 00 00       	call   6320 <fwp_rc_forget_slot>
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
    4fca:	e8 21 13 00 00       	call   62f0 <fwp_flush>
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
    5089:	e8 62 12 00 00       	call   62f0 <fwp_flush>
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
    5149:	e8 a2 11 00 00       	call   62f0 <fwp_flush>
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
    520d:	e8 8e 4a 00 00       	call   9ca0 <fwp_p_array_get_typed>
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
    528d:	e8 5e 10 00 00       	call   62f0 <fwp_flush>
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
    536d:	e8 7e 0f 00 00       	call   62f0 <fwp_flush>
    5372:	48 8b 05 67 cc 00 00 	mov    0xcc67(%rip),%rax        # 11fe0 <stderr@GLIBC_2.2.5>
    5379:	48 8b 38             	mov    (%rax),%rdi
    537c:	48 8d 35 aa a0 00 00 	lea    0xa0aa(%rip),%rsi        # f42d <fwp_segv.msg+0x1ed>
    5383:	48 89 da             	mov    %rbx,%rdx
    5386:	eb 1d                	jmp    53a5 <e48+0xe5>
    5388:	e8 63 0f 00 00       	call   62f0 <fwp_flush>
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
    5441:	e8 ca 4b 00 00       	call   a010 <f49>
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
    54c1:	e8 2a 0e 00 00       	call   62f0 <fwp_flush>
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
    554d:	e9 1d 01 00 00       	jmp    566f <e50+0x17f>
    5552:	41 80 fa 01          	cmp    $0x1,%r10b
    5556:	75 24                	jne    557c <e50+0x8c>
    5558:	4f 8d 14 08          	lea    (%r8,%r9,1),%r10
    555c:	47 8b 44 08 20       	mov    0x20(%r8,%r9,1),%r8d
    5561:	49 0f af f0          	imul   %r8,%rsi
    5565:	48 c1 ee 20          	shr    $0x20,%rsi
    5569:	4c 01 d6             	add    %r10,%rsi
    556c:	48 81 c6 28 02 00 00 	add    $0x228,%rsi
    5573:	80 3e 00             	cmpb   $0x0,(%rsi)
    5576:	0f 85 f3 00 00 00    	jne    566f <e50+0x17f>
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
    55c2:	e9 a8 00 00 00       	jmp    566f <e50+0x17f>
    55c7:	41 80 f8 01          	cmp    $0x1,%r8b
    55cb:	75 22                	jne    55ef <e50+0xff>
    55cd:	4c 8d 04 11          	lea    (%rcx,%rdx,1),%r8
    55d1:	8b 4c 11 20          	mov    0x20(%rcx,%rdx,1),%ecx
    55d5:	48 0f af c1          	imul   %rcx,%rax
    55d9:	48 c1 e8 20          	shr    $0x20,%rax
    55dd:	4c 01 c0             	add    %r8,%rax
    55e0:	48 05 28 02 00 00    	add    $0x228,%rax
    55e6:	80 38 00             	cmpb   $0x0,(%rax)
    55e9:	0f 85 80 00 00 00    	jne    566f <e50+0x17f>
    55ef:	e8 7c 56 00 00       	call   ac70 <fwp_p_loop_own>
    55f4:	48 89 c1             	mov    %rax,%rcx
    55f7:	48 2b 0d b2 db 00 00 	sub    0xdbb2(%rip),%rcx        # 131b0 <fwp_gc+0x1030>
    55fe:	48 8b 15 d3 db 00 00 	mov    0xdbd3(%rip),%rdx        # 131d8 <fwp_gc+0x1058>
    5605:	48 c1 e2 10          	shl    $0x10,%rdx
    5609:	48 39 d1             	cmp    %rdx,%rcx
    560c:	73 5f                	jae    566d <e50+0x17d>
    560e:	48 8b 15 e3 db 00 00 	mov    0xdbe3(%rip),%rdx        # 131f8 <fwp_gc+0x1078>
    5615:	48 89 ce             	mov    %rcx,%rsi
    5618:	48 c1 ee 10          	shr    $0x10,%rsi
    561c:	48 69 f6 28 12 00 00 	imul   $0x1228,%rsi,%rsi
    5623:	0f b6 3c 32          	movzbl (%rdx,%rsi,1),%edi
    5627:	48 81 e1 ff ff 00 00 	and    $0xffff,%rcx
    562e:	75 18                	jne    5648 <e50+0x158>
    5630:	40 80 ff 02          	cmp    $0x2,%dil
    5634:	75 12                	jne    5648 <e50+0x158>
    5636:	48 8d 0c 32          	lea    (%rdx,%rsi,1),%rcx
    563a:	48 81 c1 28 02 00 00 	add    $0x228,%rcx
    5641:	80 39 00             	cmpb   $0x0,(%rcx)
    5644:	74 27                	je     566d <e50+0x17d>
    5646:	eb 27                	jmp    566f <e50+0x17f>
    5648:	40 80 ff 01          	cmp    $0x1,%dil
    564c:	75 1f                	jne    566d <e50+0x17d>
    564e:	48 8d 3c 32          	lea    (%rdx,%rsi,1),%rdi
    5652:	8b 54 32 20          	mov    0x20(%rdx,%rsi,1),%edx
    5656:	48 0f af ca          	imul   %rdx,%rcx
    565a:	48 c1 e9 20          	shr    $0x20,%rcx
    565e:	48 01 f9             	add    %rdi,%rcx
    5661:	48 81 c1 28 02 00 00 	add    $0x228,%rcx
    5668:	80 39 00             	cmpb   $0x0,(%rcx)
    566b:	75 02                	jne    566f <e50+0x17f>
    566d:	59                   	pop    %rcx
    566e:	c3                   	ret
    566f:	e8 7c 0c 00 00       	call   62f0 <fwp_flush>
    5674:	48 8b 05 65 c9 00 00 	mov    0xc965(%rip),%rax        # 11fe0 <stderr@GLIBC_2.2.5>
    567b:	48 8b 38             	mov    (%rax),%rdi
    567e:	48 8d 35 a8 9d 00 00 	lea    0x9da8(%rip),%rsi        # f42d <fwp_segv.msg+0x1ed>
    5685:	48 8d 15 74 9d 00 00 	lea    0x9d74(%rip),%rdx        # f400 <fwp_segv.msg+0x1c0>
    568c:	31 c0                	xor    %eax,%eax
    568e:	e8 1d cb ff ff       	call   21b0 <fprintf@plt>
    5693:	bf 65 00 00 00       	mov    $0x65,%edi
    5698:	e8 f3 cb ff ff       	call   2290 <exit@plt>
    569d:	0f 1f 00             	nopl   (%rax)

00000000000056a0 <e51>:
    56a0:	50                   	push   %rax
    56a1:	48 8b 77 08          	mov    0x8(%rdi),%rsi
    56a5:	48 89 f0             	mov    %rsi,%rax
    56a8:	48 2b 05 01 db 00 00 	sub    0xdb01(%rip),%rax        # 131b0 <fwp_gc+0x1030>
    56af:	48 8b 0d 22 db 00 00 	mov    0xdb22(%rip),%rcx        # 131d8 <fwp_gc+0x1058>
    56b6:	48 c1 e1 10          	shl    $0x10,%rcx
    56ba:	48 39 c8             	cmp    %rcx,%rax
    56bd:	73 64                	jae    5723 <e51+0x83>
    56bf:	48 8b 0d 32 db 00 00 	mov    0xdb32(%rip),%rcx        # 131f8 <fwp_gc+0x1078>
    56c6:	48 89 c2             	mov    %rax,%rdx
    56c9:	48 c1 ea 10          	shr    $0x10,%rdx
    56cd:	48 69 d2 28 12 00 00 	imul   $0x1228,%rdx,%rdx
    56d4:	44 0f b6 04 11       	movzbl (%rcx,%rdx,1),%r8d
    56d9:	48 25 ff ff 00 00    	and    $0xffff,%rax
    56df:	75 1a                	jne    56fb <e51+0x5b>
    56e1:	41 80 f8 02          	cmp    $0x2,%r8b
    56e5:	75 14                	jne    56fb <e51+0x5b>
    56e7:	48 8d 04 11          	lea    (%rcx,%rdx,1),%rax
    56eb:	48 05 28 02 00 00    	add    $0x228,%rax
    56f1:	80 38 00             	cmpb   $0x0,(%rax)
    56f4:	74 2d                	je     5723 <e51+0x83>
    56f6:	e9 b2 00 00 00       	jmp    57ad <e51+0x10d>
    56fb:	41 80 f8 01          	cmp    $0x1,%r8b
    56ff:	75 22                	jne    5723 <e51+0x83>
    5701:	4c 8d 04 11          	lea    (%rcx,%rdx,1),%r8
    5705:	8b 4c 11 20          	mov    0x20(%rcx,%rdx,1),%ecx
    5709:	48 0f af c1          	imul   %rcx,%rax
    570d:	48 c1 e8 20          	shr    $0x20,%rax
    5711:	4c 01 c0             	add    %r8,%rax
    5714:	48 05 28 02 00 00    	add    $0x228,%rax
    571a:	80 38 00             	cmpb   $0x0,(%rax)
    571d:	0f 85 8a 00 00 00    	jne    57ad <e51+0x10d>
    5723:	48 8b 3f             	mov    (%rdi),%rdi
    5726:	48 8d 15 e3 c5 00 00 	lea    0xc5e3(%rip),%rdx        # 11d10 <d2>
    572d:	e8 6e 45 00 00       	call   9ca0 <fwp_p_array_get_typed>
    5732:	48 89 c1             	mov    %rax,%rcx
    5735:	48 2b 0d 74 da 00 00 	sub    0xda74(%rip),%rcx        # 131b0 <fwp_gc+0x1030>
    573c:	48 8b 15 95 da 00 00 	mov    0xda95(%rip),%rdx        # 131d8 <fwp_gc+0x1058>
    5743:	48 c1 e2 10          	shl    $0x10,%rdx
    5747:	48 39 d1             	cmp    %rdx,%rcx
    574a:	73 5f                	jae    57ab <e51+0x10b>
    574c:	48 8b 15 a5 da 00 00 	mov    0xdaa5(%rip),%rdx        # 131f8 <fwp_gc+0x1078>
    5753:	48 89 ce             	mov    %rcx,%rsi
    5756:	48 c1 ee 10          	shr    $0x10,%rsi
    575a:	48 69 f6 28 12 00 00 	imul   $0x1228,%rsi,%rsi
    5761:	0f b6 3c 32          	movzbl (%rdx,%rsi,1),%edi
    5765:	48 81 e1 ff ff 00 00 	and    $0xffff,%rcx
    576c:	75 18                	jne    5786 <e51+0xe6>
    576e:	40 80 ff 02          	cmp    $0x2,%dil
    5772:	75 12                	jne    5786 <e51+0xe6>
    5774:	48 8d 0c 32          	lea    (%rdx,%rsi,1),%rcx
    5778:	48 81 c1 28 02 00 00 	add    $0x228,%rcx
    577f:	80 39 00             	cmpb   $0x0,(%rcx)
    5782:	74 27                	je     57ab <e51+0x10b>
    5784:	eb 27                	jmp    57ad <e51+0x10d>
    5786:	40 80 ff 01          	cmp    $0x1,%dil
    578a:	75 1f                	jne    57ab <e51+0x10b>
    578c:	48 8d 3c 32          	lea    (%rdx,%rsi,1),%rdi
    5790:	8b 54 32 20          	mov    0x20(%rdx,%rsi,1),%edx
    5794:	48 0f af ca          	imul   %rdx,%rcx
    5798:	48 c1 e9 20          	shr    $0x20,%rcx
    579c:	48 01 f9             	add    %rdi,%rcx
    579f:	48 81 c1 28 02 00 00 	add    $0x228,%rcx
    57a6:	80 39 00             	cmpb   $0x0,(%rcx)
    57a9:	75 02                	jne    57ad <e51+0x10d>
    57ab:	59                   	pop    %rcx
    57ac:	c3                   	ret
    57ad:	e8 3e 0b 00 00       	call   62f0 <fwp_flush>
    57b2:	48 8b 05 27 c8 00 00 	mov    0xc827(%rip),%rax        # 11fe0 <stderr@GLIBC_2.2.5>
    57b9:	48 8b 38             	mov    (%rax),%rdi
    57bc:	48 8d 35 6a 9c 00 00 	lea    0x9c6a(%rip),%rsi        # f42d <fwp_segv.msg+0x1ed>
    57c3:	48 8d 15 36 9c 00 00 	lea    0x9c36(%rip),%rdx        # f400 <fwp_segv.msg+0x1c0>
    57ca:	31 c0                	xor    %eax,%eax
    57cc:	e8 df c9 ff ff       	call   21b0 <fprintf@plt>
    57d1:	bf 65 00 00 00       	mov    $0x65,%edi
    57d6:	e8 b5 ca ff ff       	call   2290 <exit@plt>
    57db:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)

00000000000057e0 <e52>:
    57e0:	50                   	push   %rax
    57e1:	48 8b 3f             	mov    (%rdi),%rdi
    57e4:	48 89 f8             	mov    %rdi,%rax
    57e7:	48 2b 05 c2 d9 00 00 	sub    0xd9c2(%rip),%rax        # 131b0 <fwp_gc+0x1030>
    57ee:	48 8b 0d e3 d9 00 00 	mov    0xd9e3(%rip),%rcx        # 131d8 <fwp_gc+0x1058>
    57f5:	48 c1 e1 10          	shl    $0x10,%rcx
    57f9:	48 39 c8             	cmp    %rcx,%rax
    57fc:	73 63                	jae    5861 <e52+0x81>
    57fe:	48 8b 0d f3 d9 00 00 	mov    0xd9f3(%rip),%rcx        # 131f8 <fwp_gc+0x1078>
    5805:	48 89 c2             	mov    %rax,%rdx
    5808:	48 c1 ea 10          	shr    $0x10,%rdx
    580c:	48 69 d2 28 12 00 00 	imul   $0x1228,%rdx,%rdx
    5813:	0f b6 34 11          	movzbl (%rcx,%rdx,1),%esi
    5817:	48 25 ff ff 00 00    	and    $0xffff,%rax
    581d:	75 1a                	jne    5839 <e52+0x59>
    581f:	40 80 fe 02          	cmp    $0x2,%sil
    5823:	75 14                	jne    5839 <e52+0x59>
    5825:	48 8d 04 11          	lea    (%rcx,%rdx,1),%rax
    5829:	48 05 28 02 00 00    	add    $0x228,%rax
    582f:	80 38 00             	cmpb   $0x0,(%rax)
    5832:	74 2d                	je     5861 <e52+0x81>
    5834:	e9 a8 00 00 00       	jmp    58e1 <e52+0x101>
    5839:	40 80 fe 01          	cmp    $0x1,%sil
    583d:	75 22                	jne    5861 <e52+0x81>
    583f:	48 8d 34 11          	lea    (%rcx,%rdx,1),%rsi
    5843:	8b 4c 11 20          	mov    0x20(%rcx,%rdx,1),%ecx
    5847:	48 0f af c1          	imul   %rcx,%rax
    584b:	48 c1 e8 20          	shr    $0x20,%rax
    584f:	48 01 f0             	add    %rsi,%rax
    5852:	48 05 28 02 00 00    	add    $0x228,%rax
    5858:	80 38 00             	cmpb   $0x0,(%rax)
    585b:	0f 85 80 00 00 00    	jne    58e1 <e52+0x101>
    5861:	e8 aa 69 00 00       	call   c210 <f52>
    5866:	48 89 c1             	mov    %rax,%rcx
    5869:	48 2b 0d 40 d9 00 00 	sub    0xd940(%rip),%rcx        # 131b0 <fwp_gc+0x1030>
    5870:	48 8b 15 61 d9 00 00 	mov    0xd961(%rip),%rdx        # 131d8 <fwp_gc+0x1058>
    5877:	48 c1 e2 10          	shl    $0x10,%rdx
    587b:	48 39 d1             	cmp    %rdx,%rcx
    587e:	73 5f                	jae    58df <e52+0xff>
    5880:	48 8b 15 71 d9 00 00 	mov    0xd971(%rip),%rdx        # 131f8 <fwp_gc+0x1078>
    5887:	48 89 ce             	mov    %rcx,%rsi
    588a:	48 c1 ee 10          	shr    $0x10,%rsi
    588e:	48 69 f6 28 12 00 00 	imul   $0x1228,%rsi,%rsi
    5895:	0f b6 3c 32          	movzbl (%rdx,%rsi,1),%edi
    5899:	48 81 e1 ff ff 00 00 	and    $0xffff,%rcx
    58a0:	75 18                	jne    58ba <e52+0xda>
    58a2:	40 80 ff 02          	cmp    $0x2,%dil
    58a6:	75 12                	jne    58ba <e52+0xda>
    58a8:	48 8d 0c 32          	lea    (%rdx,%rsi,1),%rcx
    58ac:	48 81 c1 28 02 00 00 	add    $0x228,%rcx
    58b3:	80 39 00             	cmpb   $0x0,(%rcx)
    58b6:	74 27                	je     58df <e52+0xff>
    58b8:	eb 27                	jmp    58e1 <e52+0x101>
    58ba:	40 80 ff 01          	cmp    $0x1,%dil
    58be:	75 1f                	jne    58df <e52+0xff>
    58c0:	48 8d 3c 32          	lea    (%rdx,%rsi,1),%rdi
    58c4:	8b 54 32 20          	mov    0x20(%rdx,%rsi,1),%edx
    58c8:	48 0f af ca          	imul   %rdx,%rcx
    58cc:	48 c1 e9 20          	shr    $0x20,%rcx
    58d0:	48 01 f9             	add    %rdi,%rcx
    58d3:	48 81 c1 28 02 00 00 	add    $0x228,%rcx
    58da:	80 39 00             	cmpb   $0x0,(%rcx)
    58dd:	75 02                	jne    58e1 <e52+0x101>
    58df:	59                   	pop    %rcx
    58e0:	c3                   	ret
    58e1:	e8 0a 0a 00 00       	call   62f0 <fwp_flush>
    58e6:	48 8b 05 f3 c6 00 00 	mov    0xc6f3(%rip),%rax        # 11fe0 <stderr@GLIBC_2.2.5>
    58ed:	48 8b 38             	mov    (%rax),%rdi
    58f0:	48 8d 35 36 9b 00 00 	lea    0x9b36(%rip),%rsi        # f42d <fwp_segv.msg+0x1ed>
    58f7:	48 8d 15 02 9b 00 00 	lea    0x9b02(%rip),%rdx        # f400 <fwp_segv.msg+0x1c0>
    58fe:	31 c0                	xor    %eax,%eax
    5900:	e8 ab c8 ff ff       	call   21b0 <fprintf@plt>
    5905:	bf 65 00 00 00       	mov    $0x65,%edi
    590a:	e8 81 c9 ff ff       	call   2290 <exit@plt>
    590f:	90                   	nop

0000000000005910 <e53>:
    5910:	50                   	push   %rax
    5911:	48 89 f8             	mov    %rdi,%rax
    5914:	48 8b 3f             	mov    (%rdi),%rdi
    5917:	48 8b 0d 92 d8 00 00 	mov    0xd892(%rip),%rcx        # 131b0 <fwp_gc+0x1030>
    591e:	48 89 fe             	mov    %rdi,%rsi
    5921:	48 29 ce             	sub    %rcx,%rsi
    5924:	48 8b 15 ad d8 00 00 	mov    0xd8ad(%rip),%rdx        # 131d8 <fwp_gc+0x1058>
    592b:	48 c1 e2 10          	shl    $0x10,%rdx
    592f:	48 39 d6             	cmp    %rdx,%rsi
    5932:	73 68                	jae    599c <e53+0x8c>
    5934:	4c 8b 05 bd d8 00 00 	mov    0xd8bd(%rip),%r8        # 131f8 <fwp_gc+0x1078>
    593b:	49 89 f1             	mov    %rsi,%r9
    593e:	49 c1 e9 10          	shr    $0x10,%r9
    5942:	4d 69 c9 28 12 00 00 	imul   $0x1228,%r9,%r9
    5949:	47 0f b6 14 08       	movzbl (%r8,%r9,1),%r10d
    594e:	48 81 e6 ff ff 00 00 	and    $0xffff,%rsi
    5955:	75 1b                	jne    5972 <e53+0x62>
    5957:	41 80 fa 02          	cmp    $0x2,%r10b
    595b:	75 15                	jne    5972 <e53+0x62>
    595d:	4b 8d 34 08          	lea    (%r8,%r9,1),%rsi
    5961:	48 81 c6 28 02 00 00 	add    $0x228,%rsi
    5968:	80 3e 00             	cmpb   $0x0,(%rsi)
    596b:	74 2f                	je     599c <e53+0x8c>
    596d:	e9 1d 01 00 00       	jmp    5a8f <e53+0x17f>
    5972:	41 80 fa 01          	cmp    $0x1,%r10b
    5976:	75 24                	jne    599c <e53+0x8c>
    5978:	4f 8d 14 08          	lea    (%r8,%r9,1),%r10
    597c:	47 8b 44 08 20       	mov    0x20(%r8,%r9,1),%r8d
    5981:	49 0f af f0          	imul   %r8,%rsi
    5985:	48 c1 ee 20          	shr    $0x20,%rsi
    5989:	4c 01 d6             	add    %r10,%rsi
    598c:	48 81 c6 28 02 00 00 	add    $0x228,%rsi
    5993:	80 3e 00             	cmpb   $0x0,(%rsi)
    5996:	0f 85 f3 00 00 00    	jne    5a8f <e53+0x17f>
    599c:	48 8b 70 08          	mov    0x8(%rax),%rsi
    59a0:	48 89 f0             	mov    %rsi,%rax
    59a3:	48 29 c8             	sub    %rcx,%rax
    59a6:	48 39 d0             	cmp    %rdx,%rax
    59a9:	73 64                	jae    5a0f <e53+0xff>
    59ab:	48 8b 0d 46 d8 00 00 	mov    0xd846(%rip),%rcx        # 131f8 <fwp_gc+0x1078>
    59b2:	48 89 c2             	mov    %rax,%rdx
    59b5:	48 c1 ea 10          	shr    $0x10,%rdx
    59b9:	48 69 d2 28 12 00 00 	imul   $0x1228,%rdx,%rdx
    59c0:	44 0f b6 04 11       	movzbl (%rcx,%rdx,1),%r8d
    59c5:	48 25 ff ff 00 00    	and    $0xffff,%rax
    59cb:	75 1a                	jne    59e7 <e53+0xd7>
    59cd:	41 80 f8 02          	cmp    $0x2,%r8b
    59d1:	75 14                	jne    59e7 <e53+0xd7>
    59d3:	48 8d 04 11          	lea    (%rcx,%rdx,1),%rax
    59d7:	48 05 28 02 00 00    	add    $0x228,%rax
    59dd:	80 38 00             	cmpb   $0x0,(%rax)
    59e0:	74 2d                	je     5a0f <e53+0xff>
    59e2:	e9 a8 00 00 00       	jmp    5a8f <e53+0x17f>
    59e7:	41 80 f8 01          	cmp    $0x1,%r8b
    59eb:	75 22                	jne    5a0f <e53+0xff>
    59ed:	4c 8d 04 11          	lea    (%rcx,%rdx,1),%r8
    59f1:	8b 4c 11 20          	mov    0x20(%rcx,%rdx,1),%ecx
    59f5:	48 0f af c1          	imul   %rcx,%rax
    59f9:	48 c1 e8 20          	shr    $0x20,%rax
    59fd:	4c 01 c0             	add    %r8,%rax
    5a00:	48 05 28 02 00 00    	add    $0x228,%rax
    5a06:	80 38 00             	cmpb   $0x0,(%rax)
    5a09:	0f 85 80 00 00 00    	jne    5a8f <e53+0x17f>
    5a0f:	e8 5c 52 00 00       	call   ac70 <fwp_p_loop_own>
    5a14:	48 89 c1             	mov    %rax,%rcx
    5a17:	48 2b 0d 92 d7 00 00 	sub    0xd792(%rip),%rcx        # 131b0 <fwp_gc+0x1030>
    5a1e:	48 8b 15 b3 d7 00 00 	mov    0xd7b3(%rip),%rdx        # 131d8 <fwp_gc+0x1058>
    5a25:	48 c1 e2 10          	shl    $0x10,%rdx
    5a29:	48 39 d1             	cmp    %rdx,%rcx
    5a2c:	73 5f                	jae    5a8d <e53+0x17d>
    5a2e:	48 8b 15 c3 d7 00 00 	mov    0xd7c3(%rip),%rdx        # 131f8 <fwp_gc+0x1078>
    5a35:	48 89 ce             	mov    %rcx,%rsi
    5a38:	48 c1 ee 10          	shr    $0x10,%rsi
    5a3c:	48 69 f6 28 12 00 00 	imul   $0x1228,%rsi,%rsi
    5a43:	0f b6 3c 32          	movzbl (%rdx,%rsi,1),%edi
    5a47:	48 81 e1 ff ff 00 00 	and    $0xffff,%rcx
    5a4e:	75 18                	jne    5a68 <e53+0x158>
    5a50:	40 80 ff 02          	cmp    $0x2,%dil
    5a54:	75 12                	jne    5a68 <e53+0x158>
    5a56:	48 8d 0c 32          	lea    (%rdx,%rsi,1),%rcx
    5a5a:	48 81 c1 28 02 00 00 	add    $0x228,%rcx
    5a61:	80 39 00             	cmpb   $0x0,(%rcx)
    5a64:	74 27                	je     5a8d <e53+0x17d>
    5a66:	eb 27                	jmp    5a8f <e53+0x17f>
    5a68:	40 80 ff 01          	cmp    $0x1,%dil
    5a6c:	75 1f                	jne    5a8d <e53+0x17d>
    5a6e:	48 8d 3c 32          	lea    (%rdx,%rsi,1),%rdi
    5a72:	8b 54 32 20          	mov    0x20(%rdx,%rsi,1),%edx
    5a76:	48 0f af ca          	imul   %rdx,%rcx
    5a7a:	48 c1 e9 20          	shr    $0x20,%rcx
    5a7e:	48 01 f9             	add    %rdi,%rcx
    5a81:	48 81 c1 28 02 00 00 	add    $0x228,%rcx
    5a88:	80 39 00             	cmpb   $0x0,(%rcx)
    5a8b:	75 02                	jne    5a8f <e53+0x17f>
    5a8d:	59                   	pop    %rcx
    5a8e:	c3                   	ret
    5a8f:	e8 5c 08 00 00       	call   62f0 <fwp_flush>
    5a94:	48 8b 05 45 c5 00 00 	mov    0xc545(%rip),%rax        # 11fe0 <stderr@GLIBC_2.2.5>
    5a9b:	48 8b 38             	mov    (%rax),%rdi
    5a9e:	48 8d 35 88 99 00 00 	lea    0x9988(%rip),%rsi        # f42d <fwp_segv.msg+0x1ed>
    5aa5:	48 8d 15 54 99 00 00 	lea    0x9954(%rip),%rdx        # f400 <fwp_segv.msg+0x1c0>
    5aac:	31 c0                	xor    %eax,%eax
    5aae:	e8 fd c6 ff ff       	call   21b0 <fprintf@plt>
    5ab3:	bf 65 00 00 00       	mov    $0x65,%edi
    5ab8:	e8 d3 c7 ff ff       	call   2290 <exit@plt>
    5abd:	0f 1f 00             	nopl   (%rax)

0000000000005ac0 <e54>:
    5ac0:	50                   	push   %rax
    5ac1:	48 8b 77 08          	mov    0x8(%rdi),%rsi
    5ac5:	48 89 f0             	mov    %rsi,%rax
    5ac8:	48 2b 05 e1 d6 00 00 	sub    0xd6e1(%rip),%rax        # 131b0 <fwp_gc+0x1030>
    5acf:	48 8b 0d 02 d7 00 00 	mov    0xd702(%rip),%rcx        # 131d8 <fwp_gc+0x1058>
    5ad6:	48 c1 e1 10          	shl    $0x10,%rcx
    5ada:	48 39 c8             	cmp    %rcx,%rax
    5add:	73 64                	jae    5b43 <e54+0x83>
    5adf:	48 8b 0d 12 d7 00 00 	mov    0xd712(%rip),%rcx        # 131f8 <fwp_gc+0x1078>
    5ae6:	48 89 c2             	mov    %rax,%rdx
    5ae9:	48 c1 ea 10          	shr    $0x10,%rdx
    5aed:	48 69 d2 28 12 00 00 	imul   $0x1228,%rdx,%rdx
    5af4:	44 0f b6 04 11       	movzbl (%rcx,%rdx,1),%r8d
    5af9:	48 25 ff ff 00 00    	and    $0xffff,%rax
    5aff:	75 1a                	jne    5b1b <e54+0x5b>
    5b01:	41 80 f8 02          	cmp    $0x2,%r8b
    5b05:	75 14                	jne    5b1b <e54+0x5b>
    5b07:	48 8d 04 11          	lea    (%rcx,%rdx,1),%rax
    5b0b:	48 05 28 02 00 00    	add    $0x228,%rax
    5b11:	80 38 00             	cmpb   $0x0,(%rax)
    5b14:	74 2d                	je     5b43 <e54+0x83>
    5b16:	e9 b2 00 00 00       	jmp    5bcd <e54+0x10d>
    5b1b:	41 80 f8 01          	cmp    $0x1,%r8b
    5b1f:	75 22                	jne    5b43 <e54+0x83>
    5b21:	4c 8d 04 11          	lea    (%rcx,%rdx,1),%r8
    5b25:	8b 4c 11 20          	mov    0x20(%rcx,%rdx,1),%ecx
    5b29:	48 0f af c1          	imul   %rcx,%rax
    5b2d:	48 c1 e8 20          	shr    $0x20,%rax
    5b31:	4c 01 c0             	add    %r8,%rax
    5b34:	48 05 28 02 00 00    	add    $0x228,%rax
    5b3a:	80 38 00             	cmpb   $0x0,(%rax)
    5b3d:	0f 85 8a 00 00 00    	jne    5bcd <e54+0x10d>
    5b43:	48 8b 3f             	mov    (%rdi),%rdi
    5b46:	48 8d 15 63 c1 00 00 	lea    0xc163(%rip),%rdx        # 11cb0 <d1>
    5b4d:	e8 4e 41 00 00       	call   9ca0 <fwp_p_array_get_typed>
    5b52:	48 89 c1             	mov    %rax,%rcx
    5b55:	48 2b 0d 54 d6 00 00 	sub    0xd654(%rip),%rcx        # 131b0 <fwp_gc+0x1030>
    5b5c:	48 8b 15 75 d6 00 00 	mov    0xd675(%rip),%rdx        # 131d8 <fwp_gc+0x1058>
    5b63:	48 c1 e2 10          	shl    $0x10,%rdx
    5b67:	48 39 d1             	cmp    %rdx,%rcx
    5b6a:	73 5f                	jae    5bcb <e54+0x10b>
    5b6c:	48 8b 15 85 d6 00 00 	mov    0xd685(%rip),%rdx        # 131f8 <fwp_gc+0x1078>
    5b73:	48 89 ce             	mov    %rcx,%rsi
    5b76:	48 c1 ee 10          	shr    $0x10,%rsi
    5b7a:	48 69 f6 28 12 00 00 	imul   $0x1228,%rsi,%rsi
    5b81:	0f b6 3c 32          	movzbl (%rdx,%rsi,1),%edi
    5b85:	48 81 e1 ff ff 00 00 	and    $0xffff,%rcx
    5b8c:	75 18                	jne    5ba6 <e54+0xe6>
    5b8e:	40 80 ff 02          	cmp    $0x2,%dil
    5b92:	75 12                	jne    5ba6 <e54+0xe6>
    5b94:	48 8d 0c 32          	lea    (%rdx,%rsi,1),%rcx
    5b98:	48 81 c1 28 02 00 00 	add    $0x228,%rcx
    5b9f:	80 39 00             	cmpb   $0x0,(%rcx)
    5ba2:	74 27                	je     5bcb <e54+0x10b>
    5ba4:	eb 27                	jmp    5bcd <e54+0x10d>
    5ba6:	40 80 ff 01          	cmp    $0x1,%dil
    5baa:	75 1f                	jne    5bcb <e54+0x10b>
    5bac:	48 8d 3c 32          	lea    (%rdx,%rsi,1),%rdi
    5bb0:	8b 54 32 20          	mov    0x20(%rdx,%rsi,1),%edx
    5bb4:	48 0f af ca          	imul   %rdx,%rcx
    5bb8:	48 c1 e9 20          	shr    $0x20,%rcx
    5bbc:	48 01 f9             	add    %rdi,%rcx
    5bbf:	48 81 c1 28 02 00 00 	add    $0x228,%rcx
    5bc6:	80 39 00             	cmpb   $0x0,(%rcx)
    5bc9:	75 02                	jne    5bcd <e54+0x10d>
    5bcb:	59                   	pop    %rcx
    5bcc:	c3                   	ret
    5bcd:	e8 1e 07 00 00       	call   62f0 <fwp_flush>
    5bd2:	48 8b 05 07 c4 00 00 	mov    0xc407(%rip),%rax        # 11fe0 <stderr@GLIBC_2.2.5>
    5bd9:	48 8b 38             	mov    (%rax),%rdi
    5bdc:	48 8d 35 4a 98 00 00 	lea    0x984a(%rip),%rsi        # f42d <fwp_segv.msg+0x1ed>
    5be3:	48 8d 15 16 98 00 00 	lea    0x9816(%rip),%rdx        # f400 <fwp_segv.msg+0x1c0>
    5bea:	31 c0                	xor    %eax,%eax
    5bec:	e8 bf c5 ff ff       	call   21b0 <fprintf@plt>
    5bf1:	bf 65 00 00 00       	mov    $0x65,%edi
    5bf6:	e8 95 c6 ff ff       	call   2290 <exit@plt>
    5bfb:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)

0000000000005c00 <e55>:
    5c00:	50                   	push   %rax
    5c01:	48 8b 3f             	mov    (%rdi),%rdi
    5c04:	48 89 f8             	mov    %rdi,%rax
    5c07:	48 2b 05 a2 d5 00 00 	sub    0xd5a2(%rip),%rax        # 131b0 <fwp_gc+0x1030>
    5c0e:	48 8b 0d c3 d5 00 00 	mov    0xd5c3(%rip),%rcx        # 131d8 <fwp_gc+0x1058>
    5c15:	48 c1 e1 10          	shl    $0x10,%rcx
    5c19:	48 39 c8             	cmp    %rcx,%rax
    5c1c:	73 63                	jae    5c81 <e55+0x81>
    5c1e:	48 8b 0d d3 d5 00 00 	mov    0xd5d3(%rip),%rcx        # 131f8 <fwp_gc+0x1078>
    5c25:	48 89 c2             	mov    %rax,%rdx
    5c28:	48 c1 ea 10          	shr    $0x10,%rdx
    5c2c:	48 69 d2 28 12 00 00 	imul   $0x1228,%rdx,%rdx
    5c33:	0f b6 34 11          	movzbl (%rcx,%rdx,1),%esi
    5c37:	48 25 ff ff 00 00    	and    $0xffff,%rax
    5c3d:	75 1a                	jne    5c59 <e55+0x59>
    5c3f:	40 80 fe 02          	cmp    $0x2,%sil
    5c43:	75 14                	jne    5c59 <e55+0x59>
    5c45:	48 8d 04 11          	lea    (%rcx,%rdx,1),%rax
    5c49:	48 05 28 02 00 00    	add    $0x228,%rax
    5c4f:	80 38 00             	cmpb   $0x0,(%rax)
    5c52:	74 2d                	je     5c81 <e55+0x81>
    5c54:	e9 a8 00 00 00       	jmp    5d01 <e55+0x101>
    5c59:	40 80 fe 01          	cmp    $0x1,%sil
    5c5d:	75 22                	jne    5c81 <e55+0x81>
    5c5f:	48 8d 34 11          	lea    (%rcx,%rdx,1),%rsi
    5c63:	8b 4c 11 20          	mov    0x20(%rcx,%rdx,1),%ecx
    5c67:	48 0f af c1          	imul   %rcx,%rax
    5c6b:	48 c1 e8 20          	shr    $0x20,%rax
    5c6f:	48 01 f0             	add    %rsi,%rax
    5c72:	48 05 28 02 00 00    	add    $0x228,%rax
    5c78:	80 38 00             	cmpb   $0x0,(%rax)
    5c7b:	0f 85 80 00 00 00    	jne    5d01 <e55+0x101>
    5c81:	e8 1a 6c 00 00       	call   c8a0 <f55>
    5c86:	48 89 c1             	mov    %rax,%rcx
    5c89:	48 2b 0d 20 d5 00 00 	sub    0xd520(%rip),%rcx        # 131b0 <fwp_gc+0x1030>
    5c90:	48 8b 15 41 d5 00 00 	mov    0xd541(%rip),%rdx        # 131d8 <fwp_gc+0x1058>
    5c97:	48 c1 e2 10          	shl    $0x10,%rdx
    5c9b:	48 39 d1             	cmp    %rdx,%rcx
    5c9e:	73 5f                	jae    5cff <e55+0xff>
    5ca0:	48 8b 15 51 d5 00 00 	mov    0xd551(%rip),%rdx        # 131f8 <fwp_gc+0x1078>
    5ca7:	48 89 ce             	mov    %rcx,%rsi
    5caa:	48 c1 ee 10          	shr    $0x10,%rsi
    5cae:	48 69 f6 28 12 00 00 	imul   $0x1228,%rsi,%rsi
    5cb5:	0f b6 3c 32          	movzbl (%rdx,%rsi,1),%edi
    5cb9:	48 81 e1 ff ff 00 00 	and    $0xffff,%rcx
    5cc0:	75 18                	jne    5cda <e55+0xda>
    5cc2:	40 80 ff 02          	cmp    $0x2,%dil
    5cc6:	75 12                	jne    5cda <e55+0xda>
    5cc8:	48 8d 0c 32          	lea    (%rdx,%rsi,1),%rcx
    5ccc:	48 81 c1 28 02 00 00 	add    $0x228,%rcx
    5cd3:	80 39 00             	cmpb   $0x0,(%rcx)
    5cd6:	74 27                	je     5cff <e55+0xff>
    5cd8:	eb 27                	jmp    5d01 <e55+0x101>
    5cda:	40 80 ff 01          	cmp    $0x1,%dil
    5cde:	75 1f                	jne    5cff <e55+0xff>
    5ce0:	48 8d 3c 32          	lea    (%rdx,%rsi,1),%rdi
    5ce4:	8b 54 32 20          	mov    0x20(%rdx,%rsi,1),%edx
    5ce8:	48 0f af ca          	imul   %rdx,%rcx
    5cec:	48 c1 e9 20          	shr    $0x20,%rcx
    5cf0:	48 01 f9             	add    %rdi,%rcx
    5cf3:	48 81 c1 28 02 00 00 	add    $0x228,%rcx
    5cfa:	80 39 00             	cmpb   $0x0,(%rcx)
    5cfd:	75 02                	jne    5d01 <e55+0x101>
    5cff:	59                   	pop    %rcx
    5d00:	c3                   	ret
    5d01:	e8 ea 05 00 00       	call   62f0 <fwp_flush>
    5d06:	48 8b 05 d3 c2 00 00 	mov    0xc2d3(%rip),%rax        # 11fe0 <stderr@GLIBC_2.2.5>
    5d0d:	48 8b 38             	mov    (%rax),%rdi
    5d10:	48 8d 35 16 97 00 00 	lea    0x9716(%rip),%rsi        # f42d <fwp_segv.msg+0x1ed>
    5d17:	48 8d 15 e2 96 00 00 	lea    0x96e2(%rip),%rdx        # f400 <fwp_segv.msg+0x1c0>
    5d1e:	31 c0                	xor    %eax,%eax
    5d20:	e8 8b c4 ff ff       	call   21b0 <fprintf@plt>
    5d25:	bf 65 00 00 00       	mov    $0x65,%edi
    5d2a:	e8 61 c5 ff ff       	call   2290 <exit@plt>
    5d2f:	90                   	nop

0000000000005d30 <e56>:
    5d30:	50                   	push   %rax
    5d31:	48 89 f8             	mov    %rdi,%rax
    5d34:	48 8b 3f             	mov    (%rdi),%rdi
    5d37:	48 8b 0d 72 d4 00 00 	mov    0xd472(%rip),%rcx        # 131b0 <fwp_gc+0x1030>
    5d3e:	48 89 fe             	mov    %rdi,%rsi
    5d41:	48 29 ce             	sub    %rcx,%rsi
    5d44:	48 8b 15 8d d4 00 00 	mov    0xd48d(%rip),%rdx        # 131d8 <fwp_gc+0x1058>
    5d4b:	48 c1 e2 10          	shl    $0x10,%rdx
    5d4f:	48 39 d6             	cmp    %rdx,%rsi
    5d52:	73 68                	jae    5dbc <e56+0x8c>
    5d54:	4c 8b 05 9d d4 00 00 	mov    0xd49d(%rip),%r8        # 131f8 <fwp_gc+0x1078>
    5d5b:	49 89 f1             	mov    %rsi,%r9
    5d5e:	49 c1 e9 10          	shr    $0x10,%r9
    5d62:	4d 69 c9 28 12 00 00 	imul   $0x1228,%r9,%r9
    5d69:	47 0f b6 14 08       	movzbl (%r8,%r9,1),%r10d
    5d6e:	48 81 e6 ff ff 00 00 	and    $0xffff,%rsi
    5d75:	75 1b                	jne    5d92 <e56+0x62>
    5d77:	41 80 fa 02          	cmp    $0x2,%r10b
    5d7b:	75 15                	jne    5d92 <e56+0x62>
    5d7d:	4b 8d 34 08          	lea    (%r8,%r9,1),%rsi
    5d81:	48 81 c6 28 02 00 00 	add    $0x228,%rsi
    5d88:	80 3e 00             	cmpb   $0x0,(%rsi)
    5d8b:	74 2f                	je     5dbc <e56+0x8c>
    5d8d:	e9 1d 01 00 00       	jmp    5eaf <e56+0x17f>
    5d92:	41 80 fa 01          	cmp    $0x1,%r10b
    5d96:	75 24                	jne    5dbc <e56+0x8c>
    5d98:	4f 8d 14 08          	lea    (%r8,%r9,1),%r10
    5d9c:	47 8b 44 08 20       	mov    0x20(%r8,%r9,1),%r8d
    5da1:	49 0f af f0          	imul   %r8,%rsi
    5da5:	48 c1 ee 20          	shr    $0x20,%rsi
    5da9:	4c 01 d6             	add    %r10,%rsi
    5dac:	48 81 c6 28 02 00 00 	add    $0x228,%rsi
    5db3:	80 3e 00             	cmpb   $0x0,(%rsi)
    5db6:	0f 85 f3 00 00 00    	jne    5eaf <e56+0x17f>
    5dbc:	48 8b 70 08          	mov    0x8(%rax),%rsi
    5dc0:	48 89 f0             	mov    %rsi,%rax
    5dc3:	48 29 c8             	sub    %rcx,%rax
    5dc6:	48 39 d0             	cmp    %rdx,%rax
    5dc9:	73 64                	jae    5e2f <e56+0xff>
    5dcb:	48 8b 0d 26 d4 00 00 	mov    0xd426(%rip),%rcx        # 131f8 <fwp_gc+0x1078>
    5dd2:	48 89 c2             	mov    %rax,%rdx
    5dd5:	48 c1 ea 10          	shr    $0x10,%rdx
    5dd9:	48 69 d2 28 12 00 00 	imul   $0x1228,%rdx,%rdx
    5de0:	44 0f b6 04 11       	movzbl (%rcx,%rdx,1),%r8d
    5de5:	48 25 ff ff 00 00    	and    $0xffff,%rax
    5deb:	75 1a                	jne    5e07 <e56+0xd7>
    5ded:	41 80 f8 02          	cmp    $0x2,%r8b
    5df1:	75 14                	jne    5e07 <e56+0xd7>
    5df3:	48 8d 04 11          	lea    (%rcx,%rdx,1),%rax
    5df7:	48 05 28 02 00 00    	add    $0x228,%rax
    5dfd:	80 38 00             	cmpb   $0x0,(%rax)
    5e00:	74 2d                	je     5e2f <e56+0xff>
    5e02:	e9 a8 00 00 00       	jmp    5eaf <e56+0x17f>
    5e07:	41 80 f8 01          	cmp    $0x1,%r8b
    5e0b:	75 22                	jne    5e2f <e56+0xff>
    5e0d:	4c 8d 04 11          	lea    (%rcx,%rdx,1),%r8
    5e11:	8b 4c 11 20          	mov    0x20(%rcx,%rdx,1),%ecx
    5e15:	48 0f af c1          	imul   %rcx,%rax
    5e19:	48 c1 e8 20          	shr    $0x20,%rax
    5e1d:	4c 01 c0             	add    %r8,%rax
    5e20:	48 05 28 02 00 00    	add    $0x228,%rax
    5e26:	80 38 00             	cmpb   $0x0,(%rax)
    5e29:	0f 85 80 00 00 00    	jne    5eaf <e56+0x17f>
    5e2f:	e8 3c 4e 00 00       	call   ac70 <fwp_p_loop_own>
    5e34:	48 89 c1             	mov    %rax,%rcx
    5e37:	48 2b 0d 72 d3 00 00 	sub    0xd372(%rip),%rcx        # 131b0 <fwp_gc+0x1030>
    5e3e:	48 8b 15 93 d3 00 00 	mov    0xd393(%rip),%rdx        # 131d8 <fwp_gc+0x1058>
    5e45:	48 c1 e2 10          	shl    $0x10,%rdx
    5e49:	48 39 d1             	cmp    %rdx,%rcx
    5e4c:	73 5f                	jae    5ead <e56+0x17d>
    5e4e:	48 8b 15 a3 d3 00 00 	mov    0xd3a3(%rip),%rdx        # 131f8 <fwp_gc+0x1078>
    5e55:	48 89 ce             	mov    %rcx,%rsi
    5e58:	48 c1 ee 10          	shr    $0x10,%rsi
    5e5c:	48 69 f6 28 12 00 00 	imul   $0x1228,%rsi,%rsi
    5e63:	0f b6 3c 32          	movzbl (%rdx,%rsi,1),%edi
    5e67:	48 81 e1 ff ff 00 00 	and    $0xffff,%rcx
    5e6e:	75 18                	jne    5e88 <e56+0x158>
    5e70:	40 80 ff 02          	cmp    $0x2,%dil
    5e74:	75 12                	jne    5e88 <e56+0x158>
    5e76:	48 8d 0c 32          	lea    (%rdx,%rsi,1),%rcx
    5e7a:	48 81 c1 28 02 00 00 	add    $0x228,%rcx
    5e81:	80 39 00             	cmpb   $0x0,(%rcx)
    5e84:	74 27                	je     5ead <e56+0x17d>
    5e86:	eb 27                	jmp    5eaf <e56+0x17f>
    5e88:	40 80 ff 01          	cmp    $0x1,%dil
    5e8c:	75 1f                	jne    5ead <e56+0x17d>
    5e8e:	48 8d 3c 32          	lea    (%rdx,%rsi,1),%rdi
    5e92:	8b 54 32 20          	mov    0x20(%rdx,%rsi,1),%edx
    5e96:	48 0f af ca          	imul   %rdx,%rcx
    5e9a:	48 c1 e9 20          	shr    $0x20,%rcx
    5e9e:	48 01 f9             	add    %rdi,%rcx
    5ea1:	48 81 c1 28 02 00 00 	add    $0x228,%rcx
    5ea8:	80 39 00             	cmpb   $0x0,(%rcx)
    5eab:	75 02                	jne    5eaf <e56+0x17f>
    5ead:	59                   	pop    %rcx
    5eae:	c3                   	ret
    5eaf:	e8 3c 04 00 00       	call   62f0 <fwp_flush>
    5eb4:	48 8b 05 25 c1 00 00 	mov    0xc125(%rip),%rax        # 11fe0 <stderr@GLIBC_2.2.5>
    5ebb:	48 8b 38             	mov    (%rax),%rdi
    5ebe:	48 8d 35 68 95 00 00 	lea    0x9568(%rip),%rsi        # f42d <fwp_segv.msg+0x1ed>
    5ec5:	48 8d 15 34 95 00 00 	lea    0x9534(%rip),%rdx        # f400 <fwp_segv.msg+0x1c0>
    5ecc:	31 c0                	xor    %eax,%eax
    5ece:	e8 dd c2 ff ff       	call   21b0 <fprintf@plt>
    5ed3:	bf 65 00 00 00       	mov    $0x65,%edi
    5ed8:	e8 b3 c3 ff ff       	call   2290 <exit@plt>
    5edd:	0f 1f 00             	nopl   (%rax)

0000000000005ee0 <e57>:
    5ee0:	50                   	push   %rax
    5ee1:	48 8b 3f             	mov    (%rdi),%rdi
    5ee4:	48 89 f8             	mov    %rdi,%rax
    5ee7:	48 2b 05 c2 d2 00 00 	sub    0xd2c2(%rip),%rax        # 131b0 <fwp_gc+0x1030>
    5eee:	48 8b 0d e3 d2 00 00 	mov    0xd2e3(%rip),%rcx        # 131d8 <fwp_gc+0x1058>
    5ef5:	48 c1 e1 10          	shl    $0x10,%rcx
    5ef9:	48 39 c8             	cmp    %rcx,%rax
    5efc:	73 63                	jae    5f61 <e57+0x81>
    5efe:	48 8b 0d f3 d2 00 00 	mov    0xd2f3(%rip),%rcx        # 131f8 <fwp_gc+0x1078>
    5f05:	48 89 c2             	mov    %rax,%rdx
    5f08:	48 c1 ea 10          	shr    $0x10,%rdx
    5f0c:	48 69 d2 28 12 00 00 	imul   $0x1228,%rdx,%rdx
    5f13:	0f b6 34 11          	movzbl (%rcx,%rdx,1),%esi
    5f17:	48 25 ff ff 00 00    	and    $0xffff,%rax
    5f1d:	75 1a                	jne    5f39 <e57+0x59>
    5f1f:	40 80 fe 02          	cmp    $0x2,%sil
    5f23:	75 14                	jne    5f39 <e57+0x59>
    5f25:	48 8d 04 11          	lea    (%rcx,%rdx,1),%rax
    5f29:	48 05 28 02 00 00    	add    $0x228,%rax
    5f2f:	80 38 00             	cmpb   $0x0,(%rax)
    5f32:	74 2d                	je     5f61 <e57+0x81>
    5f34:	e9 a8 00 00 00       	jmp    5fe1 <e57+0x101>
    5f39:	40 80 fe 01          	cmp    $0x1,%sil
    5f3d:	75 22                	jne    5f61 <e57+0x81>
    5f3f:	48 8d 34 11          	lea    (%rcx,%rdx,1),%rsi
    5f43:	8b 4c 11 20          	mov    0x20(%rcx,%rdx,1),%ecx
    5f47:	48 0f af c1          	imul   %rcx,%rax
    5f4b:	48 c1 e8 20          	shr    $0x20,%rax
    5f4f:	48 01 f0             	add    %rsi,%rax
    5f52:	48 05 28 02 00 00    	add    $0x228,%rax
    5f58:	80 38 00             	cmpb   $0x0,(%rax)
    5f5b:	0f 85 80 00 00 00    	jne    5fe1 <e57+0x101>
    5f61:	e8 0a 70 00 00       	call   cf70 <f57>
    5f66:	48 89 c1             	mov    %rax,%rcx
    5f69:	48 2b 0d 40 d2 00 00 	sub    0xd240(%rip),%rcx        # 131b0 <fwp_gc+0x1030>
    5f70:	48 8b 15 61 d2 00 00 	mov    0xd261(%rip),%rdx        # 131d8 <fwp_gc+0x1058>
    5f77:	48 c1 e2 10          	shl    $0x10,%rdx
    5f7b:	48 39 d1             	cmp    %rdx,%rcx
    5f7e:	73 5f                	jae    5fdf <e57+0xff>
    5f80:	48 8b 15 71 d2 00 00 	mov    0xd271(%rip),%rdx        # 131f8 <fwp_gc+0x1078>
    5f87:	48 89 ce             	mov    %rcx,%rsi
    5f8a:	48 c1 ee 10          	shr    $0x10,%rsi
    5f8e:	48 69 f6 28 12 00 00 	imul   $0x1228,%rsi,%rsi
    5f95:	0f b6 3c 32          	movzbl (%rdx,%rsi,1),%edi
    5f99:	48 81 e1 ff ff 00 00 	and    $0xffff,%rcx
    5fa0:	75 18                	jne    5fba <e57+0xda>
    5fa2:	40 80 ff 02          	cmp    $0x2,%dil
    5fa6:	75 12                	jne    5fba <e57+0xda>
    5fa8:	48 8d 0c 32          	lea    (%rdx,%rsi,1),%rcx
    5fac:	48 81 c1 28 02 00 00 	add    $0x228,%rcx
    5fb3:	80 39 00             	cmpb   $0x0,(%rcx)
    5fb6:	74 27                	je     5fdf <e57+0xff>
    5fb8:	eb 27                	jmp    5fe1 <e57+0x101>
    5fba:	40 80 ff 01          	cmp    $0x1,%dil
    5fbe:	75 1f                	jne    5fdf <e57+0xff>
    5fc0:	48 8d 3c 32          	lea    (%rdx,%rsi,1),%rdi
    5fc4:	8b 54 32 20          	mov    0x20(%rdx,%rsi,1),%edx
    5fc8:	48 0f af ca          	imul   %rdx,%rcx
    5fcc:	48 c1 e9 20          	shr    $0x20,%rcx
    5fd0:	48 01 f9             	add    %rdi,%rcx
    5fd3:	48 81 c1 28 02 00 00 	add    $0x228,%rcx
    5fda:	80 39 00             	cmpb   $0x0,(%rcx)
    5fdd:	75 02                	jne    5fe1 <e57+0x101>
    5fdf:	59                   	pop    %rcx
    5fe0:	c3                   	ret
    5fe1:	e8 0a 03 00 00       	call   62f0 <fwp_flush>
    5fe6:	48 8b 05 f3 bf 00 00 	mov    0xbff3(%rip),%rax        # 11fe0 <stderr@GLIBC_2.2.5>
    5fed:	48 8b 38             	mov    (%rax),%rdi
    5ff0:	48 8d 35 36 94 00 00 	lea    0x9436(%rip),%rsi        # f42d <fwp_segv.msg+0x1ed>
    5ff7:	48 8d 15 02 94 00 00 	lea    0x9402(%rip),%rdx        # f400 <fwp_segv.msg+0x1c0>
    5ffe:	31 c0                	xor    %eax,%eax
    6000:	e8 ab c1 ff ff       	call   21b0 <fprintf@plt>
    6005:	bf 65 00 00 00       	mov    $0x65,%edi
    600a:	e8 81 c2 ff ff       	call   2290 <exit@plt>
    600f:	90                   	nop

0000000000006010 <e58>:
    6010:	50                   	push   %rax
    6011:	48 89 f8             	mov    %rdi,%rax
    6014:	48 8b 3f             	mov    (%rdi),%rdi
    6017:	48 8b 0d 92 d1 00 00 	mov    0xd192(%rip),%rcx        # 131b0 <fwp_gc+0x1030>
    601e:	48 89 fe             	mov    %rdi,%rsi
    6021:	48 29 ce             	sub    %rcx,%rsi
    6024:	48 8b 15 ad d1 00 00 	mov    0xd1ad(%rip),%rdx        # 131d8 <fwp_gc+0x1058>
    602b:	48 c1 e2 10          	shl    $0x10,%rdx
    602f:	48 39 d6             	cmp    %rdx,%rsi
    6032:	73 68                	jae    609c <e58+0x8c>
    6034:	4c 8b 05 bd d1 00 00 	mov    0xd1bd(%rip),%r8        # 131f8 <fwp_gc+0x1078>
    603b:	49 89 f1             	mov    %rsi,%r9
    603e:	49 c1 e9 10          	shr    $0x10,%r9
    6042:	4d 69 c9 28 12 00 00 	imul   $0x1228,%r9,%r9
    6049:	47 0f b6 14 08       	movzbl (%r8,%r9,1),%r10d
    604e:	48 81 e6 ff ff 00 00 	and    $0xffff,%rsi
    6055:	75 1b                	jne    6072 <e58+0x62>
    6057:	41 80 fa 02          	cmp    $0x2,%r10b
    605b:	75 15                	jne    6072 <e58+0x62>
    605d:	4b 8d 34 08          	lea    (%r8,%r9,1),%rsi
    6061:	48 81 c6 28 02 00 00 	add    $0x228,%rsi
    6068:	80 3e 00             	cmpb   $0x0,(%rsi)
    606b:	74 2f                	je     609c <e58+0x8c>
    606d:	e9 1d 01 00 00       	jmp    618f <e58+0x17f>
    6072:	41 80 fa 01          	cmp    $0x1,%r10b
    6076:	75 24                	jne    609c <e58+0x8c>
    6078:	4f 8d 14 08          	lea    (%r8,%r9,1),%r10
    607c:	47 8b 44 08 20       	mov    0x20(%r8,%r9,1),%r8d
    6081:	49 0f af f0          	imul   %r8,%rsi
    6085:	48 c1 ee 20          	shr    $0x20,%rsi
    6089:	4c 01 d6             	add    %r10,%rsi
    608c:	48 81 c6 28 02 00 00 	add    $0x228,%rsi
    6093:	80 3e 00             	cmpb   $0x0,(%rsi)
    6096:	0f 85 f3 00 00 00    	jne    618f <e58+0x17f>
    609c:	48 8b 70 08          	mov    0x8(%rax),%rsi
    60a0:	48 89 f0             	mov    %rsi,%rax
    60a3:	48 29 c8             	sub    %rcx,%rax
    60a6:	48 39 d0             	cmp    %rdx,%rax
    60a9:	73 64                	jae    610f <e58+0xff>
    60ab:	48 8b 0d 46 d1 00 00 	mov    0xd146(%rip),%rcx        # 131f8 <fwp_gc+0x1078>
    60b2:	48 89 c2             	mov    %rax,%rdx
    60b5:	48 c1 ea 10          	shr    $0x10,%rdx
    60b9:	48 69 d2 28 12 00 00 	imul   $0x1228,%rdx,%rdx
    60c0:	44 0f b6 04 11       	movzbl (%rcx,%rdx,1),%r8d
    60c5:	48 25 ff ff 00 00    	and    $0xffff,%rax
    60cb:	75 1a                	jne    60e7 <e58+0xd7>
    60cd:	41 80 f8 02          	cmp    $0x2,%r8b
    60d1:	75 14                	jne    60e7 <e58+0xd7>
    60d3:	48 8d 04 11          	lea    (%rcx,%rdx,1),%rax
    60d7:	48 05 28 02 00 00    	add    $0x228,%rax
    60dd:	80 38 00             	cmpb   $0x0,(%rax)
    60e0:	74 2d                	je     610f <e58+0xff>
    60e2:	e9 a8 00 00 00       	jmp    618f <e58+0x17f>
    60e7:	41 80 f8 01          	cmp    $0x1,%r8b
    60eb:	75 22                	jne    610f <e58+0xff>
    60ed:	4c 8d 04 11          	lea    (%rcx,%rdx,1),%r8
    60f1:	8b 4c 11 20          	mov    0x20(%rcx,%rdx,1),%ecx
    60f5:	48 0f af c1          	imul   %rcx,%rax
    60f9:	48 c1 e8 20          	shr    $0x20,%rax
    60fd:	4c 01 c0             	add    %r8,%rax
    6100:	48 05 28 02 00 00    	add    $0x228,%rax
    6106:	80 38 00             	cmpb   $0x0,(%rax)
    6109:	0f 85 80 00 00 00    	jne    618f <e58+0x17f>
    610f:	e8 5c 4b 00 00       	call   ac70 <fwp_p_loop_own>
    6114:	48 89 c1             	mov    %rax,%rcx
    6117:	48 2b 0d 92 d0 00 00 	sub    0xd092(%rip),%rcx        # 131b0 <fwp_gc+0x1030>
    611e:	48 8b 15 b3 d0 00 00 	mov    0xd0b3(%rip),%rdx        # 131d8 <fwp_gc+0x1058>
    6125:	48 c1 e2 10          	shl    $0x10,%rdx
    6129:	48 39 d1             	cmp    %rdx,%rcx
    612c:	73 5f                	jae    618d <e58+0x17d>
    612e:	48 8b 15 c3 d0 00 00 	mov    0xd0c3(%rip),%rdx        # 131f8 <fwp_gc+0x1078>
    6135:	48 89 ce             	mov    %rcx,%rsi
    6138:	48 c1 ee 10          	shr    $0x10,%rsi
    613c:	48 69 f6 28 12 00 00 	imul   $0x1228,%rsi,%rsi
    6143:	0f b6 3c 32          	movzbl (%rdx,%rsi,1),%edi
    6147:	48 81 e1 ff ff 00 00 	and    $0xffff,%rcx
    614e:	75 18                	jne    6168 <e58+0x158>
    6150:	40 80 ff 02          	cmp    $0x2,%dil
    6154:	75 12                	jne    6168 <e58+0x158>
    6156:	48 8d 0c 32          	lea    (%rdx,%rsi,1),%rcx
    615a:	48 81 c1 28 02 00 00 	add    $0x228,%rcx
    6161:	80 39 00             	cmpb   $0x0,(%rcx)
    6164:	74 27                	je     618d <e58+0x17d>
    6166:	eb 27                	jmp    618f <e58+0x17f>
    6168:	40 80 ff 01          	cmp    $0x1,%dil
    616c:	75 1f                	jne    618d <e58+0x17d>
    616e:	48 8d 3c 32          	lea    (%rdx,%rsi,1),%rdi
    6172:	8b 54 32 20          	mov    0x20(%rdx,%rsi,1),%edx
    6176:	48 0f af ca          	imul   %rdx,%rcx
    617a:	48 c1 e9 20          	shr    $0x20,%rcx
    617e:	48 01 f9             	add    %rdi,%rcx
    6181:	48 81 c1 28 02 00 00 	add    $0x228,%rcx
    6188:	80 39 00             	cmpb   $0x0,(%rcx)
    618b:	75 02                	jne    618f <e58+0x17f>
    618d:	59                   	pop    %rcx
    618e:	c3                   	ret
    618f:	e8 5c 01 00 00       	call   62f0 <fwp_flush>
    6194:	48 8b 05 45 be 00 00 	mov    0xbe45(%rip),%rax        # 11fe0 <stderr@GLIBC_2.2.5>
    619b:	48 8b 38             	mov    (%rax),%rdi
    619e:	48 8d 35 88 92 00 00 	lea    0x9288(%rip),%rsi        # f42d <fwp_segv.msg+0x1ed>
    61a5:	48 8d 15 54 92 00 00 	lea    0x9254(%rip),%rdx        # f400 <fwp_segv.msg+0x1c0>
    61ac:	31 c0                	xor    %eax,%eax
    61ae:	e8 fd bf ff ff       	call   21b0 <fprintf@plt>
    61b3:	bf 65 00 00 00       	mov    $0x65,%edi
    61b8:	e8 d3 c0 ff ff       	call   2290 <exit@plt>
    61bd:	0f 1f 00             	nopl   (%rax)

00000000000061c0 <e59>:
    61c0:	50                   	push   %rax
    61c1:	48 8b 3f             	mov    (%rdi),%rdi
    61c4:	48 89 f8             	mov    %rdi,%rax
    61c7:	48 2b 05 e2 cf 00 00 	sub    0xcfe2(%rip),%rax        # 131b0 <fwp_gc+0x1030>
    61ce:	48 8b 0d 03 d0 00 00 	mov    0xd003(%rip),%rcx        # 131d8 <fwp_gc+0x1058>
    61d5:	48 c1 e1 10          	shl    $0x10,%rcx
    61d9:	48 39 c8             	cmp    %rcx,%rax
    61dc:	73 63                	jae    6241 <e59+0x81>
    61de:	48 8b 0d 13 d0 00 00 	mov    0xd013(%rip),%rcx        # 131f8 <fwp_gc+0x1078>
    61e5:	48 89 c2             	mov    %rax,%rdx
    61e8:	48 c1 ea 10          	shr    $0x10,%rdx
    61ec:	48 69 d2 28 12 00 00 	imul   $0x1228,%rdx,%rdx
    61f3:	0f b6 34 11          	movzbl (%rcx,%rdx,1),%esi
    61f7:	48 25 ff ff 00 00    	and    $0xffff,%rax
    61fd:	75 1a                	jne    6219 <e59+0x59>
    61ff:	40 80 fe 02          	cmp    $0x2,%sil
    6203:	75 14                	jne    6219 <e59+0x59>
    6205:	48 8d 04 11          	lea    (%rcx,%rdx,1),%rax
    6209:	48 05 28 02 00 00    	add    $0x228,%rax
    620f:	80 38 00             	cmpb   $0x0,(%rax)
    6212:	74 2d                	je     6241 <e59+0x81>
    6214:	e9 a8 00 00 00       	jmp    62c1 <e59+0x101>
    6219:	40 80 fe 01          	cmp    $0x1,%sil
    621d:	75 22                	jne    6241 <e59+0x81>
    621f:	48 8d 34 11          	lea    (%rcx,%rdx,1),%rsi
    6223:	8b 4c 11 20          	mov    0x20(%rcx,%rdx,1),%ecx
    6227:	48 0f af c1          	imul   %rcx,%rax
    622b:	48 c1 e8 20          	shr    $0x20,%rax
    622f:	48 01 f0             	add    %rsi,%rax
    6232:	48 05 28 02 00 00    	add    $0x228,%rax
    6238:	80 38 00             	cmpb   $0x0,(%rax)
    623b:	0f 85 80 00 00 00    	jne    62c1 <e59+0x101>
    6241:	e8 1a 73 00 00       	call   d560 <f59>
    6246:	48 89 c1             	mov    %rax,%rcx
    6249:	48 2b 0d 60 cf 00 00 	sub    0xcf60(%rip),%rcx        # 131b0 <fwp_gc+0x1030>
    6250:	48 8b 15 81 cf 00 00 	mov    0xcf81(%rip),%rdx        # 131d8 <fwp_gc+0x1058>
    6257:	48 c1 e2 10          	shl    $0x10,%rdx
    625b:	48 39 d1             	cmp    %rdx,%rcx
    625e:	73 5f                	jae    62bf <e59+0xff>
    6260:	48 8b 15 91 cf 00 00 	mov    0xcf91(%rip),%rdx        # 131f8 <fwp_gc+0x1078>
    6267:	48 89 ce             	mov    %rcx,%rsi
    626a:	48 c1 ee 10          	shr    $0x10,%rsi
    626e:	48 69 f6 28 12 00 00 	imul   $0x1228,%rsi,%rsi
    6275:	0f b6 3c 32          	movzbl (%rdx,%rsi,1),%edi
    6279:	48 81 e1 ff ff 00 00 	and    $0xffff,%rcx
    6280:	75 18                	jne    629a <e59+0xda>
    6282:	40 80 ff 02          	cmp    $0x2,%dil
    6286:	75 12                	jne    629a <e59+0xda>
    6288:	48 8d 0c 32          	lea    (%rdx,%rsi,1),%rcx
    628c:	48 81 c1 28 02 00 00 	add    $0x228,%rcx
    6293:	80 39 00             	cmpb   $0x0,(%rcx)
    6296:	74 27                	je     62bf <e59+0xff>
    6298:	eb 27                	jmp    62c1 <e59+0x101>
    629a:	40 80 ff 01          	cmp    $0x1,%dil
    629e:	75 1f                	jne    62bf <e59+0xff>
    62a0:	48 8d 3c 32          	lea    (%rdx,%rsi,1),%rdi
    62a4:	8b 54 32 20          	mov    0x20(%rdx,%rsi,1),%edx
    62a8:	48 0f af ca          	imul   %rdx,%rcx
    62ac:	48 c1 e9 20          	shr    $0x20,%rcx
    62b0:	48 01 f9             	add    %rdi,%rcx
    62b3:	48 81 c1 28 02 00 00 	add    $0x228,%rcx
    62ba:	80 39 00             	cmpb   $0x0,(%rcx)
    62bd:	75 02                	jne    62c1 <e59+0x101>
    62bf:	59                   	pop    %rcx
    62c0:	c3                   	ret
    62c1:	e8 2a 00 00 00       	call   62f0 <fwp_flush>
    62c6:	48 8b 05 13 bd 00 00 	mov    0xbd13(%rip),%rax        # 11fe0 <stderr@GLIBC_2.2.5>
    62cd:	48 8b 38             	mov    (%rax),%rdi
    62d0:	48 8d 35 56 91 00 00 	lea    0x9156(%rip),%rsi        # f42d <fwp_segv.msg+0x1ed>
    62d7:	48 8d 15 22 91 00 00 	lea    0x9122(%rip),%rdx        # f400 <fwp_segv.msg+0x1c0>
    62de:	31 c0                	xor    %eax,%eax
    62e0:	e8 cb be ff ff       	call   21b0 <fprintf@plt>
    62e5:	bf 65 00 00 00       	mov    $0x65,%edi
    62ea:	e8 a1 bf ff ff       	call   2290 <exit@plt>
    62ef:	90                   	nop

00000000000062f0 <fwp_flush>:
    62f0:	50                   	push   %rax
    62f1:	48 8b 3d d0 d8 00 00 	mov    0xd8d0(%rip),%rdi        # 13bc8 <fwp_prog_out>
    62f8:	48 85 ff             	test   %rdi,%rdi
    62fb:	74 05                	je     6302 <fwp_flush+0x12>
    62fd:	e8 fe be ff ff       	call   2200 <fflush@plt>
    6302:	48 8b 05 b7 bc 00 00 	mov    0xbcb7(%rip),%rax        # 11fc0 <stdout@GLIBC_2.2.5>
    6309:	48 8b 38             	mov    (%rax),%rdi
    630c:	58                   	pop    %rax
    630d:	e9 ee be ff ff       	jmp    2200 <fflush@plt>
    6312:	66 66 66 66 66 2e 0f 	data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    6319:	1f 84 00 00 00 00 00 

0000000000006320 <fwp_rc_forget_slot>:
    6320:	50                   	push   %rax
    6321:	80 3f ff             	cmpb   $0xff,(%rdi)
    6324:	74 02                	je     6328 <fwp_rc_forget_slot+0x8>
    6326:	58                   	pop    %rax
    6327:	c3                   	ret
    6328:	48 89 f8             	mov    %rdi,%rax
    632b:	48 c1 e8 11          	shr    $0x11,%rax
    632f:	31 f8                	xor    %edi,%eax
    6331:	89 c1                	mov    %eax,%ecx
    6333:	c1 e9 09             	shr    $0x9,%ecx
    6336:	31 c1                	xor    %eax,%ecx
    6338:	0f b6 c9             	movzbl %cl,%ecx
    633b:	48 8d 15 3e be 00 00 	lea    0xbe3e(%rip),%rdx        # 12180 <fwp_gc>
    6342:	48 8b 84 ca 18 12 00 	mov    0x1218(%rdx,%rcx,8),%rax
    6349:	00 
    634a:	48 85 c0             	test   %rax,%rax
    634d:	74 4b                	je     639a <fwp_rc_forget_slot+0x7a>
    634f:	48 39 38             	cmp    %rdi,(%rax)
    6352:	74 23                	je     6377 <fwp_rc_forget_slot+0x57>
    6354:	66 66 66 2e 0f 1f 84 	data16 data16 cs nopw 0x0(%rax,%rax,1)
    635b:	00 00 00 00 00 
    6360:	48 89 c1             	mov    %rax,%rcx
    6363:	48 8b 40 10          	mov    0x10(%rax),%rax
    6367:	48 85 c0             	test   %rax,%rax
    636a:	74 2e                	je     639a <fwp_rc_forget_slot+0x7a>
    636c:	48 39 38             	cmp    %rdi,(%rax)
    636f:	75 ef                	jne    6360 <fwp_rc_forget_slot+0x40>
    6371:	48 83 c1 10          	add    $0x10,%rcx
    6375:	eb 0b                	jmp    6382 <fwp_rc_forget_slot+0x62>
    6377:	48 8d 0c ca          	lea    (%rdx,%rcx,8),%rcx
    637b:	48 81 c1 18 12 00 00 	add    $0x1218,%rcx
    6382:	48 8b 50 10          	mov    0x10(%rax),%rdx
    6386:	48 89 11             	mov    %rdx,(%rcx)
    6389:	48 89 c7             	mov    %rax,%rdi
    638c:	e8 bf bc ff ff       	call   2050 <free@plt>
    6391:	48 ff 0d 00 d8 00 00 	decq   0xd800(%rip)        # 13b98 <fwp_gc+0x1a18>
    6398:	58                   	pop    %rax
    6399:	c3                   	ret
    639a:	e8 51 ff ff ff       	call   62f0 <fwp_flush>
    639f:	48 8b 05 3a bc 00 00 	mov    0xbc3a(%rip),%rax        # 11fe0 <stderr@GLIBC_2.2.5>
    63a6:	48 8b 38             	mov    (%rax),%rdi
    63a9:	48 8d 35 7d 90 00 00 	lea    0x907d(%rip),%rsi        # f42d <fwp_segv.msg+0x1ed>
    63b0:	48 8d 15 85 90 00 00 	lea    0x9085(%rip),%rdx        # f43c <fwp_segv.msg+0x1fc>
    63b7:	31 c0                	xor    %eax,%eax
    63b9:	e8 f2 bd ff ff       	call   21b0 <fprintf@plt>
    63be:	bf 65 00 00 00       	mov    $0x65,%edi
    63c3:	e8 c8 be ff ff       	call   2290 <exit@plt>
    63c8:	0f 1f 84 00 00 00 00 	nopl   0x0(%rax,%rax,1)
    63cf:	00 

00000000000063d0 <fwp_p_array_from_list_typed>:
    63d0:	41 56                	push   %r14
    63d2:	53                   	push   %rbx
    63d3:	50                   	push   %rax
    63d4:	48 89 fb             	mov    %rdi,%rbx
    63d7:	48 85 ff             	test   %rdi,%rdi
    63da:	0f 84 ae 00 00 00    	je     648e <fwp_p_array_from_list_typed+0xbe>
    63e0:	31 ff                	xor    %edi,%edi
    63e2:	48 89 d8             	mov    %rbx,%rax
    63e5:	66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
    63ec:	00 00 00 00 
    63f0:	48 ff c7             	inc    %rdi
    63f3:	48 8b 40 10          	mov    0x10(%rax),%rax
    63f7:	48 85 c0             	test   %rax,%rax
    63fa:	75 f4                	jne    63f0 <fwp_p_array_from_list_typed+0x20>
    63fc:	49 89 f6             	mov    %rsi,%r14
    63ff:	e8 cc 00 00 00       	call   64d0 <fwp_array_typed_new>
    6404:	48 85 db             	test   %rbx,%rbx
    6407:	0f 84 88 00 00 00    	je     6495 <fwp_p_array_from_list_typed+0xc5>
    640d:	b9 04 00 00 00       	mov    $0x4,%ecx
    6412:	ba 84 04 00 00       	mov    $0x484,%edx
    6417:	be 21 00 00 00       	mov    $0x21,%esi
    641c:	bf 42 00 00 00       	mov    $0x42,%edi
    6421:	49 89 d8             	mov    %rbx,%r8
    6424:	4d 89 f1             	mov    %r14,%r9
    6427:	eb 18                	jmp    6441 <fwp_p_array_from_list_typed+0x71>
    6429:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)
    6430:	4c 89 54 c8 e8       	mov    %r10,-0x18(%rax,%rcx,8)
    6435:	4d 8b 40 10          	mov    0x10(%r8),%r8
    6439:	48 ff c1             	inc    %rcx
    643c:	4d 85 c0             	test   %r8,%r8
    643f:	74 54                	je     6495 <fwp_p_array_from_list_typed+0xc5>
    6441:	48 83 38 00          	cmpq   $0x0,(%rax)
    6445:	78 56                	js     649d <fwp_p_array_from_list_typed+0xcd>
    6447:	4d 8b 50 08          	mov    0x8(%r8),%r10
    644b:	4d 85 c9             	test   %r9,%r9
    644e:	74 e0                	je     6430 <fwp_p_array_from_list_typed+0x60>
    6450:	45 8b 19             	mov    (%r9),%r11d
    6453:	41 83 fb 0a          	cmp    $0xa,%r11d
    6457:	77 d7                	ja     6430 <fwp_p_array_from_list_typed+0x60>
    6459:	44 0f a3 da          	bt     %r11d,%edx
    645d:	72 21                	jb     6480 <fwp_p_array_from_list_typed+0xb0>
    645f:	44 0f a3 de          	bt     %r11d,%esi
    6463:	72 22                	jb     6487 <fwp_p_array_from_list_typed+0xb7>
    6465:	44 0f a3 df          	bt     %r11d,%edi
    6469:	73 c5                	jae    6430 <fwp_p_array_from_list_typed+0x60>
    646b:	66 44 89 14 48       	mov    %r10w,(%rax,%rcx,2)
    6470:	eb c3                	jmp    6435 <fwp_p_array_from_list_typed+0x65>
    6472:	66 66 66 66 66 2e 0f 	data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    6479:	1f 84 00 00 00 00 00 
    6480:	44 89 54 88 f8       	mov    %r10d,-0x8(%rax,%rcx,4)
    6485:	eb ae                	jmp    6435 <fwp_p_array_from_list_typed+0x65>
    6487:	44 88 54 08 04       	mov    %r10b,0x4(%rax,%rcx,1)
    648c:	eb a7                	jmp    6435 <fwp_p_array_from_list_typed+0x65>
    648e:	31 ff                	xor    %edi,%edi
    6490:	e8 3b 00 00 00       	call   64d0 <fwp_array_typed_new>
    6495:	48 83 c4 08          	add    $0x8,%rsp
    6499:	5b                   	pop    %rbx
    649a:	41 5e                	pop    %r14
    649c:	c3                   	ret
    649d:	e8 4e fe ff ff       	call   62f0 <fwp_flush>
    64a2:	48 8b 05 37 bb 00 00 	mov    0xbb37(%rip),%rax        # 11fe0 <stderr@GLIBC_2.2.5>
    64a9:	48 8b 38             	mov    (%rax),%rdi
    64ac:	48 8d 35 7a 8f 00 00 	lea    0x8f7a(%rip),%rsi        # f42d <fwp_segv.msg+0x1ed>
    64b3:	48 8d 15 c4 90 00 00 	lea    0x90c4(%rip),%rdx        # f57e <fwp_segv.msg+0x33e>
    64ba:	31 c0                	xor    %eax,%eax
    64bc:	e8 ef bc ff ff       	call   21b0 <fprintf@plt>
    64c1:	bf 65 00 00 00       	mov    $0x65,%edi
    64c6:	e8 c5 bd ff ff       	call   2290 <exit@plt>
    64cb:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)

00000000000064d0 <fwp_array_typed_new>:
    64d0:	41 56                	push   %r14
    64d2:	53                   	push   %rbx
    64d3:	50                   	push   %rax
    64d4:	48 b8 ff ff ff ff ff 	movabs $0x1fffffffffffffff,%rax
    64db:	ff ff 1f 
    64de:	48 39 c7             	cmp    %rax,%rdi
    64e1:	0f 83 21 02 00 00    	jae    6708 <fwp_array_typed_new+0x238>
    64e7:	48 89 fb             	mov    %rdi,%rbx
    64ea:	48 85 f6             	test   %rsi,%rsi
    64ed:	74 23                	je     6512 <fwp_array_typed_new+0x42>
    64ef:	8b 06                	mov    (%rsi),%eax
    64f1:	48 83 f8 0a          	cmp    $0xa,%rax
    64f5:	77 0e                	ja     6505 <fwp_array_typed_new+0x35>
    64f7:	b9 e7 04 00 00       	mov    $0x4e7,%ecx
    64fc:	0f a3 c1             	bt     %eax,%ecx
    64ff:	0f 82 93 00 00 00    	jb     6598 <fwp_array_typed_new+0xc8>
    6505:	48 8d 0c dd 00 00 00 	lea    0x0(,%rbx,8),%rcx
    650c:	00 
    650d:	e9 95 00 00 00       	jmp    65a7 <fwp_array_typed_new+0xd7>
    6512:	48 8d 14 dd 08 00 00 	lea    0x8(,%rbx,8),%rdx
    6519:	00 
    651a:	48 81 fa 00 40 00 00 	cmp    $0x4000,%rdx
    6521:	77 68                	ja     658b <fwp_array_typed_new+0xbb>
    6523:	48 8d 42 0f          	lea    0xf(%rdx),%rax
    6527:	48 c1 e8 04          	shr    $0x4,%rax
    652b:	48 8d 0d 4e bc 00 00 	lea    0xbc4e(%rip),%rcx        # 12180 <fwp_gc>
    6532:	0f b6 b4 08 e8 0b 00 	movzbl 0xbe8(%rax,%rcx,1),%esi
    6539:	00 
    653a:	8b 84 b1 48 0b 00 00 	mov    0xb48(%rcx,%rsi,4),%eax
    6541:	48 29 05 38 bc 00 00 	sub    %rax,0xbc38(%rip)        # 12180 <fwp_gc>
    6548:	78 41                	js     658b <fwp_array_typed_new+0xbb>
    654a:	48 8d 34 76          	lea    (%rsi,%rsi,2),%rsi
    654e:	48 8d 3c f1          	lea    (%rcx,%rsi,8),%rdi
    6552:	48 81 c7 88 07 00 00 	add    $0x788,%rdi
    6559:	4c 8b 37             	mov    (%rdi),%r14
    655c:	4d 85 f6             	test   %r14,%r14
    655f:	74 0e                	je     656f <fwp_array_typed_new+0x9f>
    6561:	49 8b 0e             	mov    (%r14),%rcx
    6564:	48 f7 d1             	not    %rcx
    6567:	48 89 0f             	mov    %rcx,(%rdi)
    656a:	e9 f8 00 00 00       	jmp    6667 <fwp_array_typed_new+0x197>
    656f:	4c 8b b4 f1 90 07 00 	mov    0x790(%rcx,%rsi,8),%r14
    6576:	00 
    6577:	48 8b bc f1 98 07 00 	mov    0x798(%rcx,%rsi,8),%rdi
    657e:	00 
    657f:	4c 29 f7             	sub    %r14,%rdi
    6582:	48 39 c7             	cmp    %rax,%rdi
    6585:	0f 83 ca 00 00 00    	jae    6655 <fwp_array_typed_new+0x185>
    658b:	48 89 d7             	mov    %rdx,%rdi
    658e:	be 02 00 00 00       	mov    $0x2,%esi
    6593:	e9 9c 00 00 00       	jmp    6634 <fwp_array_typed_new+0x164>
    6598:	48 8d 0d c1 8c 00 00 	lea    0x8cc1(%rip),%rcx        # f260 <fwp_segv.msg+0x20>
    659f:	48 8b 0c c1          	mov    (%rcx,%rax,8),%rcx
    65a3:	48 0f af cb          	imul   %rbx,%rcx
    65a7:	48 8d 51 08          	lea    0x8(%rcx),%rdx
    65ab:	83 f8 0b             	cmp    $0xb,%eax
    65ae:	0f 87 66 ff ff ff    	ja     651a <fwp_array_typed_new+0x4a>
    65b4:	be ef 0d 00 00       	mov    $0xdef,%esi
    65b9:	0f a3 c6             	bt     %eax,%esi
    65bc:	0f 83 58 ff ff ff    	jae    651a <fwp_array_typed_new+0x4a>
    65c2:	48 81 f9 f8 3f 00 00 	cmp    $0x3ff8,%rcx
    65c9:	77 61                	ja     662c <fwp_array_typed_new+0x15c>
    65cb:	48 83 c1 17          	add    $0x17,%rcx
    65cf:	48 c1 e9 04          	shr    $0x4,%rcx
    65d3:	48 8d 05 a6 bb 00 00 	lea    0xbba6(%rip),%rax        # 12180 <fwp_gc>
    65da:	0f b6 b4 01 e8 0b 00 	movzbl 0xbe8(%rcx,%rax,1),%esi
    65e1:	00 
    65e2:	8b 8c b0 48 0b 00 00 	mov    0xb48(%rax,%rsi,4),%ecx
    65e9:	48 29 0d 90 bb 00 00 	sub    %rcx,0xbb90(%rip)        # 12180 <fwp_gc>
    65f0:	78 3a                	js     662c <fwp_array_typed_new+0x15c>
    65f2:	48 8d 34 76          	lea    (%rsi,%rsi,2),%rsi
    65f6:	48 8d 3c f0          	lea    (%rax,%rsi,8),%rdi
    65fa:	48 81 c7 c8 03 00 00 	add    $0x3c8,%rdi
    6601:	4c 8b 37             	mov    (%rdi),%r14
    6604:	4d 85 f6             	test   %r14,%r14
    6607:	74 0b                	je     6614 <fwp_array_typed_new+0x144>
    6609:	49 8b 06             	mov    (%r14),%rax
    660c:	48 f7 d0             	not    %rax
    660f:	48 89 07             	mov    %rax,(%rdi)
    6612:	eb 3a                	jmp    664e <fwp_array_typed_new+0x17e>
    6614:	4c 8b b4 f0 d0 03 00 	mov    0x3d0(%rax,%rsi,8),%r14
    661b:	00 
    661c:	48 8b bc f0 d8 03 00 	mov    0x3d8(%rax,%rsi,8),%rdi
    6623:	00 
    6624:	4c 29 f7             	sub    %r14,%rdi
    6627:	48 39 cf             	cmp    %rcx,%rdi
    662a:	73 12                	jae    663e <fwp_array_typed_new+0x16e>
    662c:	48 89 d7             	mov    %rdx,%rdi
    662f:	be 01 00 00 00       	mov    $0x1,%esi
    6634:	e8 07 01 00 00       	call   6740 <fwp_gc_alloc_slow>
    6639:	49 89 c6             	mov    %rax,%r14
    663c:	eb 36                	jmp    6674 <fwp_array_typed_new+0x1a4>
    663e:	48 8d 04 f0          	lea    (%rax,%rsi,8),%rax
    6642:	48 05 d0 03 00 00    	add    $0x3d0,%rax
    6648:	4c 01 f1             	add    %r14,%rcx
    664b:	48 89 08             	mov    %rcx,(%rax)
    664e:	4c 89 f7             	mov    %r14,%rdi
    6651:	31 f6                	xor    %esi,%esi
    6653:	eb 1a                	jmp    666f <fwp_array_typed_new+0x19f>
    6655:	48 8d 0c f1          	lea    (%rcx,%rsi,8),%rcx
    6659:	48 81 c1 90 07 00 00 	add    $0x790,%rcx
    6660:	49 8d 14 06          	lea    (%r14,%rax,1),%rdx
    6664:	48 89 11             	mov    %rdx,(%rcx)
    6667:	4c 89 f7             	mov    %r14,%rdi
    666a:	31 f6                	xor    %esi,%esi
    666c:	48 89 c2             	mov    %rax,%rdx
    666f:	e8 bc ba ff ff       	call   2130 <memset@plt>
    6674:	49 89 1e             	mov    %rbx,(%r14)
    6677:	4c 89 f0             	mov    %r14,%rax
    667a:	48 2b 05 2f cb 00 00 	sub    0xcb2f(%rip),%rax        # 131b0 <fwp_gc+0x1030>
    6681:	48 8b 0d 50 cb 00 00 	mov    0xcb50(%rip),%rcx        # 131d8 <fwp_gc+0x1058>
    6688:	48 c1 e1 10          	shl    $0x10,%rcx
    668c:	48 39 c8             	cmp    %rcx,%rax
    668f:	73 6c                	jae    66fd <fwp_array_typed_new+0x22d>
    6691:	48 8b 0d 60 cb 00 00 	mov    0xcb60(%rip),%rcx        # 131f8 <fwp_gc+0x1078>
    6698:	48 89 c2             	mov    %rax,%rdx
    669b:	48 c1 ea 10          	shr    $0x10,%rdx
    669f:	48 69 d2 28 12 00 00 	imul   $0x1228,%rdx,%rdx
    66a6:	0f b6 34 11          	movzbl (%rcx,%rdx,1),%esi
    66aa:	48 25 ff ff 00 00    	and    $0xffff,%rax
    66b0:	75 1b                	jne    66cd <fwp_array_typed_new+0x1fd>
    66b2:	40 80 fe 02          	cmp    $0x2,%sil
    66b6:	75 15                	jne    66cd <fwp_array_typed_new+0x1fd>
    66b8:	48 8d 1c 11          	lea    (%rcx,%rdx,1),%rbx
    66bc:	48 81 c3 28 02 00 00 	add    $0x228,%rbx
    66c3:	80 3b ff             	cmpb   $0xff,(%rbx)
    66c6:	74 2b                	je     66f3 <fwp_array_typed_new+0x223>
    66c8:	c6 03 01             	movb   $0x1,(%rbx)
    66cb:	eb 30                	jmp    66fd <fwp_array_typed_new+0x22d>
    66cd:	40 80 fe 01          	cmp    $0x1,%sil
    66d1:	75 2a                	jne    66fd <fwp_array_typed_new+0x22d>
    66d3:	48 8d 34 11          	lea    (%rcx,%rdx,1),%rsi
    66d7:	8b 4c 11 20          	mov    0x20(%rcx,%rdx,1),%ecx
    66db:	48 0f af c1          	imul   %rcx,%rax
    66df:	48 c1 e8 20          	shr    $0x20,%rax
    66e3:	48 8d 1c 30          	lea    (%rax,%rsi,1),%rbx
    66e7:	48 81 c3 28 02 00 00 	add    $0x228,%rbx
    66ee:	80 3b ff             	cmpb   $0xff,(%rbx)
    66f1:	75 d5                	jne    66c8 <fwp_array_typed_new+0x1f8>
    66f3:	48 89 df             	mov    %rbx,%rdi
    66f6:	e8 25 fc ff ff       	call   6320 <fwp_rc_forget_slot>
    66fb:	eb cb                	jmp    66c8 <fwp_array_typed_new+0x1f8>
    66fd:	4c 89 f0             	mov    %r14,%rax
    6700:	48 83 c4 08          	add    $0x8,%rsp
    6704:	5b                   	pop    %rbx
    6705:	41 5e                	pop    %r14
    6707:	c3                   	ret
    6708:	e8 e3 fb ff ff       	call   62f0 <fwp_flush>
    670d:	48 8b 05 cc b8 00 00 	mov    0xb8cc(%rip),%rax        # 11fe0 <stderr@GLIBC_2.2.5>
    6714:	48 8b 38             	mov    (%rax),%rdi
    6717:	48 8d 35 0f 8d 00 00 	lea    0x8d0f(%rip),%rsi        # f42d <fwp_segv.msg+0x1ed>
    671e:	48 8d 15 3e 8d 00 00 	lea    0x8d3e(%rip),%rdx        # f463 <fwp_segv.msg+0x223>
    6725:	31 c0                	xor    %eax,%eax
    6727:	e8 84 ba ff ff       	call   21b0 <fprintf@plt>
    672c:	bf 65 00 00 00       	mov    $0x65,%edi
    6731:	e8 5a bb ff ff       	call   2290 <exit@plt>
    6736:	66 2e 0f 1f 84 00 00 	cs nopw 0x0(%rax,%rax,1)
    673d:	00 00 00 

0000000000006740 <fwp_gc_alloc_slow>:
    6740:	41 57                	push   %r15
    6742:	41 56                	push   %r14
    6744:	41 55                	push   %r13
    6746:	41 54                	push   %r12
    6748:	53                   	push   %rbx
    6749:	89 f3                	mov    %esi,%ebx
    674b:	83 3d 1a ca 00 00 00 	cmpl   $0x0,0xca1a(%rip)        # 1316c <fwp_gc+0xfec>
    6752:	74 19                	je     676d <fwp_gc_alloc_slow+0x2d>
    6754:	48 81 ff 01 40 00 00 	cmp    $0x4001,%rdi
    675b:	72 24                	jb     6781 <fwp_gc_alloc_slow+0x41>
    675d:	89 de                	mov    %ebx,%esi
    675f:	5b                   	pop    %rbx
    6760:	41 5c                	pop    %r12
    6762:	41 5d                	pop    %r13
    6764:	41 5e                	pop    %r14
    6766:	41 5f                	pop    %r15
    6768:	e9 33 06 00 00       	jmp    6da0 <fwp_gc_alloc_big>
    676d:	49 89 fe             	mov    %rdi,%r14
    6770:	e8 5b 01 00 00       	call   68d0 <fwp_gc_init>
    6775:	4c 89 f7             	mov    %r14,%rdi
    6778:	48 81 ff 01 40 00 00 	cmp    $0x4001,%rdi
    677f:	73 dc                	jae    675d <fwp_gc_alloc_slow+0x1d>
    6781:	48 8d 47 0f          	lea    0xf(%rdi),%rax
    6785:	48 c1 e8 04          	shr    $0x4,%rax
    6789:	4c 8d 3d f0 b9 00 00 	lea    0xb9f0(%rip),%r15        # 12180 <fwp_gc>
    6790:	46 0f b6 b4 38 e8 0b 	movzbl 0xbe8(%rax,%r15,1),%r14d
    6797:	00 00 
    6799:	43 8b 94 b7 48 0b 00 	mov    0xb48(%r15,%r14,4),%edx
    67a0:	00 
    67a1:	48 83 3d d7 b9 00 00 	cmpq   $0x0,0xb9d7(%rip)        # 12180 <fwp_gc>
    67a8:	00 
    67a9:	0f 89 8c 00 00 00    	jns    683b <fwp_gc_alloc_slow+0xfb>
    67af:	83 3d b6 c9 00 00 00 	cmpl   $0x0,0xc9b6(%rip)        # 1316c <fwp_gc+0xfec>
    67b6:	75 11                	jne    67c9 <fwp_gc_alloc_slow+0x89>
    67b8:	49 89 fc             	mov    %rdi,%r12
    67bb:	49 89 d5             	mov    %rdx,%r13
    67be:	e8 0d 01 00 00       	call   68d0 <fwp_gc_init>
    67c3:	4c 89 ea             	mov    %r13,%rdx
    67c6:	4c 89 e7             	mov    %r12,%rdi
    67c9:	8b 0d a5 c9 00 00    	mov    0xc9a5(%rip),%ecx        # 13174 <fwp_gc+0xff4>
    67cf:	85 c9                	test   %ecx,%ecx
    67d1:	74 2a                	je     67fd <fwp_gc_alloc_slow+0xbd>
    67d3:	48 8b 05 c6 c9 00 00 	mov    0xc9c6(%rip),%rax        # 131a0 <fwp_gc+0x1020>
    67da:	48 85 c0             	test   %rax,%rax
    67dd:	74 1e                	je     67fd <fwp_gc_alloc_slow+0xbd>
    67df:	48 8b 0d c2 c9 00 00 	mov    0xc9c2(%rip),%rcx        # 131a8 <fwp_gc+0x1028>
    67e6:	48 ff c1             	inc    %rcx
    67e9:	48 89 0d b8 c9 00 00 	mov    %rcx,0xc9b8(%rip)        # 131a8 <fwp_gc+0x1028>
    67f0:	48 39 c1             	cmp    %rax,%rcx
    67f3:	0f 8d c7 00 00 00    	jge    68c0 <fwp_gc_alloc_slow+0x180>
    67f9:	31 c0                	xor    %eax,%eax
    67fb:	eb 0d                	jmp    680a <fwp_gc_alloc_slow+0xca>
    67fd:	b8 00 00 80 00       	mov    $0x800000,%eax
    6802:	85 c9                	test   %ecx,%ecx
    6804:	0f 85 b1 00 00 00    	jne    68bb <fwp_gc_alloc_slow+0x17b>
    680a:	48 8b 0d 7f cb 00 00 	mov    0xcb7f(%rip),%rcx        # 13390 <fwp_gc+0x1210>
    6811:	48 2b 0d 68 b9 00 00 	sub    0xb968(%rip),%rcx        # 12180 <fwp_gc>
    6818:	f2 48 0f 2a c1       	cvtsi2sd %rcx,%xmm0
    681d:	f2 0f 58 05 43 cb 00 	addsd  0xcb43(%rip),%xmm0        # 13368 <fwp_gc+0x11e8>
    6824:	00 
    6825:	f2 0f 11 05 3b cb 00 	movsd  %xmm0,0xcb3b(%rip)        # 13368 <fwp_gc+0x11e8>
    682c:	00 
    682d:	48 89 05 5c cb 00 00 	mov    %rax,0xcb5c(%rip)        # 13390 <fwp_gc+0x1210>
    6834:	48 89 05 45 b9 00 00 	mov    %rax,0xb945(%rip)        # 12180 <fwp_gc>
    683b:	89 d8                	mov    %ebx,%eax
    683d:	48 69 c0 c0 03 00 00 	imul   $0x3c0,%rax,%rax
    6844:	49 01 c7             	add    %rax,%r15
    6847:	4b 8d 34 76          	lea    (%r14,%r14,2),%rsi
    684b:	49 8d 0c f7          	lea    (%r15,%rsi,8),%rcx
    684f:	48 83 c1 08          	add    $0x8,%rcx
    6853:	49 8b 44 f7 08       	mov    0x8(%r15,%rsi,8),%rax
    6858:	48 85 c0             	test   %rax,%rax
    685b:	74 08                	je     6865 <fwp_gc_alloc_slow+0x125>
    685d:	48 8b 30             	mov    (%rax),%rsi
    6860:	48 f7 d6             	not    %rsi
    6863:	eb 39                	jmp    689e <fwp_gc_alloc_slow+0x15e>
    6865:	49 8b 44 f7 10       	mov    0x10(%r15,%rsi,8),%rax
    686a:	4d 8b 44 f7 18       	mov    0x18(%r15,%rsi,8),%r8
    686f:	49 29 c0             	sub    %rax,%r8
    6872:	49 39 d0             	cmp    %rdx,%r8
    6875:	73 1b                	jae    6892 <fwp_gc_alloc_slow+0x152>
    6877:	49 89 ff             	mov    %rdi,%r15
    687a:	48 89 cf             	mov    %rcx,%rdi
    687d:	44 89 f6             	mov    %r14d,%esi
    6880:	49 89 d6             	mov    %rdx,%r14
    6883:	89 da                	mov    %ebx,%edx
    6885:	e8 46 07 00 00       	call   6fd0 <fwp_gc_refill>
    688a:	4c 89 f2             	mov    %r14,%rdx
    688d:	4c 89 ff             	mov    %r15,%rdi
    6890:	eb 0f                	jmp    68a1 <fwp_gc_alloc_slow+0x161>
    6892:	49 8d 0c f7          	lea    (%r15,%rsi,8),%rcx
    6896:	48 83 c1 10          	add    $0x10,%rcx
    689a:	48 8d 34 10          	lea    (%rax,%rdx,1),%rsi
    689e:	48 89 31             	mov    %rsi,(%rcx)
    68a1:	83 fb 01             	cmp    $0x1,%ebx
    68a4:	48 0f 44 d7          	cmove  %rdi,%rdx
    68a8:	48 89 c7             	mov    %rax,%rdi
    68ab:	31 f6                	xor    %esi,%esi
    68ad:	5b                   	pop    %rbx
    68ae:	41 5c                	pop    %r12
    68b0:	41 5d                	pop    %r13
    68b2:	41 5e                	pop    %r14
    68b4:	41 5f                	pop    %r15
    68b6:	e9 75 b8 ff ff       	jmp    2130 <memset@plt>
    68bb:	e8 d0 09 00 00       	call   7290 <fwp_gc_collect>
    68c0:	48 c7 05 dd c8 00 00 	movq   $0x0,0xc8dd(%rip)        # 131a8 <fwp_gc+0x1028>
    68c7:	00 00 00 00 
    68cb:	e8 c0 09 00 00       	call   7290 <fwp_gc_collect>

00000000000068d0 <fwp_gc_init>:
    68d0:	41 56                	push   %r14
    68d2:	53                   	push   %rbx
    68d3:	50                   	push   %rax
    68d4:	c7 05 8e c8 00 00 01 	movl   $0x1,0xc88e(%rip)        # 1316c <fwp_gc+0xfec>
    68db:	00 00 00 
    68de:	0f 28 05 4b 87 00 00 	movaps 0x874b(%rip),%xmm0        # f030 <_IO_stdin_used+0x30>
    68e5:	0f 11 05 dc c3 00 00 	movups %xmm0,0xc3dc(%rip)        # 12cc8 <fwp_gc+0xb48>
    68ec:	0f 28 05 4d 87 00 00 	movaps 0x874d(%rip),%xmm0        # f040 <_IO_stdin_used+0x40>
    68f3:	0f 11 05 de c3 00 00 	movups %xmm0,0xc3de(%rip)        # 12cd8 <fwp_gc+0xb58>
    68fa:	0f 28 05 4f 87 00 00 	movaps 0x874f(%rip),%xmm0        # f050 <_IO_stdin_used+0x50>
    6901:	0f 11 05 e0 c3 00 00 	movups %xmm0,0xc3e0(%rip)        # 12ce8 <fwp_gc+0xb68>
    6908:	0f 28 05 51 87 00 00 	movaps 0x8751(%rip),%xmm0        # f060 <_IO_stdin_used+0x60>
    690f:	0f 11 05 e2 c3 00 00 	movups %xmm0,0xc3e2(%rip)        # 12cf8 <fwp_gc+0xb78>
    6916:	0f 28 05 53 87 00 00 	movaps 0x8753(%rip),%xmm0        # f070 <_IO_stdin_used+0x70>
    691d:	0f 11 05 e4 c3 00 00 	movups %xmm0,0xc3e4(%rip)        # 12d08 <fwp_gc+0xb88>
    6924:	0f 28 05 55 87 00 00 	movaps 0x8755(%rip),%xmm0        # f080 <_IO_stdin_used+0x80>
    692b:	0f 11 05 e6 c3 00 00 	movups %xmm0,0xc3e6(%rip)        # 12d18 <fwp_gc+0xb98>
    6932:	0f 28 05 57 87 00 00 	movaps 0x8757(%rip),%xmm0        # f090 <_IO_stdin_used+0x90>
    6939:	0f 11 05 e8 c3 00 00 	movups %xmm0,0xc3e8(%rip)        # 12d28 <fwp_gc+0xba8>
    6940:	0f 28 05 59 87 00 00 	movaps 0x8759(%rip),%xmm0        # f0a0 <_IO_stdin_used+0xa0>
    6947:	0f 11 05 ea c3 00 00 	movups %xmm0,0xc3ea(%rip)        # 12d38 <fwp_gc+0xbb8>
    694e:	0f 28 05 5b 87 00 00 	movaps 0x875b(%rip),%xmm0        # f0b0 <_IO_stdin_used+0xb0>
    6955:	0f 11 05 ec c3 00 00 	movups %xmm0,0xc3ec(%rip)        # 12d48 <fwp_gc+0xbc8>
    695c:	0f 28 05 5d 87 00 00 	movaps 0x875d(%rip),%xmm0        # f0c0 <_IO_stdin_used+0xc0>
    6963:	0f 11 05 ee c3 00 00 	movups %xmm0,0xc3ee(%rip)        # 12d58 <fwp_gc+0xbd8>
    696a:	31 c9                	xor    %ecx,%ecx
    696c:	48 8d 05 0d b8 00 00 	lea    0xb80d(%rip),%rax        # 12180 <fwp_gc>
    6973:	31 d2                	xor    %edx,%edx
    6975:	66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
    697c:	00 00 00 00 
    6980:	89 d6                	mov    %edx,%esi
    6982:	c1 e6 04             	shl    $0x4,%esi
    6985:	48 ff c9             	dec    %rcx
    6988:	48 89 cf             	mov    %rcx,%rdi
    698b:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)
    6990:	48 89 f9             	mov    %rdi,%rcx
    6993:	48 ff c7             	inc    %rdi
    6996:	3b b4 88 4c 0b 00 00 	cmp    0xb4c(%rax,%rcx,4),%esi
    699d:	77 f1                	ja     6990 <fwp_gc_init+0xc0>
    699f:	40 88 bc 02 e8 0b 00 	mov    %dil,0xbe8(%rdx,%rax,1)
    69a6:	00 
    69a7:	48 89 d6             	mov    %rdx,%rsi
    69aa:	48 83 ce 01          	or     $0x1,%rsi
    69ae:	48 81 fe 01 04 00 00 	cmp    $0x401,%rsi
    69b5:	74 26                	je     69dd <fwp_gc_init+0x10d>
    69b7:	89 f7                	mov    %esi,%edi
    69b9:	c1 e7 04             	shl    $0x4,%edi
    69bc:	0f 1f 40 00          	nopl   0x0(%rax)
    69c0:	49 89 c8             	mov    %rcx,%r8
    69c3:	48 ff c1             	inc    %rcx
    69c6:	42 3b bc 80 4c 0b 00 	cmp    0xb4c(%rax,%r8,4),%edi
    69cd:	00 
    69ce:	77 f0                	ja     69c0 <fwp_gc_init+0xf0>
    69d0:	88 8c 06 e8 0b 00 00 	mov    %cl,0xbe8(%rsi,%rax,1)
    69d7:	48 83 c2 02          	add    $0x2,%rdx
    69db:	eb a3                	jmp    6980 <fwp_gc_init+0xb0>
    69dd:	48 bb 00 00 00 00 10 	movabs $0x1000000000,%rbx
    69e4:	00 00 00 
    69e7:	48 8d b3 00 00 01 00 	lea    0x10000(%rbx),%rsi
    69ee:	31 ff                	xor    %edi,%edi
    69f0:	31 d2                	xor    %edx,%edx
    69f2:	b9 22 40 00 00       	mov    $0x4022,%ecx
    69f7:	41 b8 ff ff ff ff    	mov    $0xffffffff,%r8d
    69fd:	45 31 c9             	xor    %r9d,%r9d
    6a00:	e8 eb b6 ff ff       	call   20f0 <mmap@plt>
    6a05:	48 83 f8 ff          	cmp    $0xffffffffffffffff,%rax
    6a09:	75 60                	jne    6a6b <fwp_gc_init+0x19b>
    6a0b:	48 bb 00 00 00 00 04 	movabs $0x400000000,%rbx
    6a12:	00 00 00 
    6a15:	48 8d b3 00 00 01 00 	lea    0x10000(%rbx),%rsi
    6a1c:	31 ff                	xor    %edi,%edi
    6a1e:	31 d2                	xor    %edx,%edx
    6a20:	b9 22 40 00 00       	mov    $0x4022,%ecx
    6a25:	41 b8 ff ff ff ff    	mov    $0xffffffff,%r8d
    6a2b:	45 31 c9             	xor    %r9d,%r9d
    6a2e:	e8 bd b6 ff ff       	call   20f0 <mmap@plt>
    6a33:	48 83 f8 ff          	cmp    $0xffffffffffffffff,%rax
    6a37:	75 32                	jne    6a6b <fwp_gc_init+0x19b>
    6a39:	48 bb 00 00 00 00 01 	movabs $0x100000000,%rbx
    6a40:	00 00 00 
    6a43:	48 8d b3 00 00 01 00 	lea    0x10000(%rbx),%rsi
    6a4a:	31 ff                	xor    %edi,%edi
    6a4c:	31 d2                	xor    %edx,%edx
    6a4e:	b9 22 40 00 00       	mov    $0x4022,%ecx
    6a53:	41 b8 ff ff ff ff    	mov    $0xffffffff,%r8d
    6a59:	45 31 c9             	xor    %r9d,%r9d
    6a5c:	e8 8f b6 ff ff       	call   20f0 <mmap@plt>
    6a61:	48 83 f8 ff          	cmp    $0xffffffffffffffff,%rax
    6a65:	0f 84 4e 02 00 00    	je     6cb9 <fwp_gc_init+0x3e9>
    6a6b:	48 85 c0             	test   %rax,%rax
    6a6e:	0f 84 a6 02 00 00    	je     6d1a <fwp_gc_init+0x44a>
    6a74:	48 89 05 3d c7 00 00 	mov    %rax,0xc73d(%rip)        # 131b8 <fwp_gc+0x1038>
    6a7b:	48 89 d9             	mov    %rbx,%rcx
    6a7e:	48 81 c9 00 00 01 00 	or     $0x10000,%rcx
    6a85:	48 89 0d 34 c7 00 00 	mov    %rcx,0xc734(%rip)        # 131c0 <fwp_gc+0x1040>
    6a8c:	48 05 ff ff 00 00    	add    $0xffff,%rax
    6a92:	48 25 00 00 ff ff    	and    $0xffffffffffff0000,%rax
    6a98:	48 89 05 11 c7 00 00 	mov    %rax,0xc711(%rip)        # 131b0 <fwp_gc+0x1030>
    6a9f:	48 c1 eb 10          	shr    $0x10,%rbx
    6aa3:	48 89 1d 26 c7 00 00 	mov    %rbx,0xc726(%rip)        # 131d0 <fwp_gc+0x1050>
    6aaa:	48 69 f3 28 12 00 00 	imul   $0x1228,%rbx,%rsi
    6ab1:	48 89 35 48 c7 00 00 	mov    %rsi,0xc748(%rip)        # 13200 <fwp_gc+0x1080>
    6ab8:	31 ff                	xor    %edi,%edi
    6aba:	31 d2                	xor    %edx,%edx
    6abc:	b9 22 40 00 00       	mov    $0x4022,%ecx
    6ac1:	41 b8 ff ff ff ff    	mov    $0xffffffff,%r8d
    6ac7:	45 31 c9             	xor    %r9d,%r9d
    6aca:	e8 21 b6 ff ff       	call   20f0 <mmap@plt>
    6acf:	48 83 f8 ff          	cmp    $0xffffffffffffffff,%rax
    6ad3:	0f 84 41 02 00 00    	je     6d1a <fwp_gc_init+0x44a>
    6ad9:	48 89 05 18 c7 00 00 	mov    %rax,0xc718(%rip)        # 131f8 <fwp_gc+0x1078>
    6ae0:	48 8d 3d 8c 89 00 00 	lea    0x898c(%rip),%rdi        # f473 <fwp_segv.msg+0x233>
    6ae7:	e8 44 b5 ff ff       	call   2030 <getenv@plt>
    6aec:	48 85 c0             	test   %rax,%rax
    6aef:	74 2e                	je     6b1f <fwp_gc_init+0x24f>
    6af1:	48 89 c3             	mov    %rax,%rbx
    6af4:	48 8d 35 7f 89 00 00 	lea    0x897f(%rip),%rsi        # f47a <fwp_segv.msg+0x23a>
    6afb:	48 89 c7             	mov    %rax,%rdi
    6afe:	e8 7d b6 ff ff       	call   2180 <strcmp@plt>
    6b03:	85 c0                	test   %eax,%eax
    6b05:	74 1f                	je     6b26 <fwp_gc_init+0x256>
    6b07:	48 8d 35 54 8b 00 00 	lea    0x8b54(%rip),%rsi        # f662 <fwp_segv.msg+0x422>
    6b0e:	48 89 df             	mov    %rbx,%rdi
    6b11:	e8 6a b6 ff ff       	call   2180 <strcmp@plt>
    6b16:	31 c9                	xor    %ecx,%ecx
    6b18:	85 c0                	test   %eax,%eax
    6b1a:	0f 95 c1             	setne  %cl
    6b1d:	eb 09                	jmp    6b28 <fwp_gc_init+0x258>
    6b1f:	b9 01 00 00 00       	mov    $0x1,%ecx
    6b24:	eb 02                	jmp    6b28 <fwp_gc_init+0x258>
    6b26:	31 c9                	xor    %ecx,%ecx
    6b28:	89 0d 42 c6 00 00    	mov    %ecx,0xc642(%rip)        # 13170 <fwp_gc+0xff0>
    6b2e:	48 8d 3d 49 89 00 00 	lea    0x8949(%rip),%rdi        # f47e <fwp_segv.msg+0x23e>
    6b35:	e8 f6 b4 ff ff       	call   2030 <getenv@plt>
    6b3a:	31 c9                	xor    %ecx,%ecx
    6b3c:	48 85 c0             	test   %rax,%rax
    6b3f:	74 1b                	je     6b5c <fwp_gc_init+0x28c>
    6b41:	80 38 00             	cmpb   $0x0,(%rax)
    6b44:	74 16                	je     6b5c <fwp_gc_init+0x28c>
    6b46:	48 8d 35 15 8b 00 00 	lea    0x8b15(%rip),%rsi        # f662 <fwp_segv.msg+0x422>
    6b4d:	48 89 c7             	mov    %rax,%rdi
    6b50:	e8 2b b6 ff ff       	call   2180 <strcmp@plt>
    6b55:	31 c9                	xor    %ecx,%ecx
    6b57:	85 c0                	test   %eax,%eax
    6b59:	0f 95 c1             	setne  %cl
    6b5c:	89 0d 1a c6 00 00    	mov    %ecx,0xc61a(%rip)        # 1317c <fwp_gc+0xffc>
    6b62:	48 8d 3d 0a 89 00 00 	lea    0x890a(%rip),%rdi        # f473 <fwp_segv.msg+0x233>
    6b69:	e8 c2 b4 ff ff       	call   2030 <getenv@plt>
    6b6e:	48 85 c0             	test   %rax,%rax
    6b71:	74 18                	je     6b8b <fwp_gc_init+0x2bb>
    6b73:	48 8d 35 11 89 00 00 	lea    0x8911(%rip),%rsi        # f48b <fwp_segv.msg+0x24b>
    6b7a:	48 89 c7             	mov    %rax,%rdi
    6b7d:	e8 fe b5 ff ff       	call   2180 <strcmp@plt>
    6b82:	31 c9                	xor    %ecx,%ecx
    6b84:	85 c0                	test   %eax,%eax
    6b86:	0f 95 c1             	setne  %cl
    6b89:	eb 05                	jmp    6b90 <fwp_gc_init+0x2c0>
    6b8b:	b9 01 00 00 00       	mov    $0x1,%ecx
    6b90:	89 0d ea c5 00 00    	mov    %ecx,0xc5ea(%rip)        # 13180 <fwp_gc+0x1000>
    6b96:	c7 05 e8 c5 00 00 01 	movl   $0x1,0xc5e8(%rip)        # 13188 <fwp_gc+0x1008>
    6b9d:	00 00 00 
    6ba0:	48 8d 3d e9 88 00 00 	lea    0x88e9(%rip),%rdi        # f490 <fwp_segv.msg+0x250>
    6ba7:	e8 84 b4 ff ff       	call   2030 <getenv@plt>
    6bac:	31 c9                	xor    %ecx,%ecx
    6bae:	48 85 c0             	test   %rax,%rax
    6bb1:	74 1b                	je     6bce <fwp_gc_init+0x2fe>
    6bb3:	80 38 00             	cmpb   $0x0,(%rax)
    6bb6:	74 16                	je     6bce <fwp_gc_init+0x2fe>
    6bb8:	48 8d 35 a3 8a 00 00 	lea    0x8aa3(%rip),%rsi        # f662 <fwp_segv.msg+0x422>
    6bbf:	48 89 c7             	mov    %rax,%rdi
    6bc2:	e8 b9 b5 ff ff       	call   2180 <strcmp@plt>
    6bc7:	31 c9                	xor    %ecx,%ecx
    6bc9:	85 c0                	test   %eax,%eax
    6bcb:	0f 95 c1             	setne  %cl
    6bce:	89 0d b0 c5 00 00    	mov    %ecx,0xc5b0(%rip)        # 13184 <fwp_gc+0x1004>
    6bd4:	48 8d 3d c3 88 00 00 	lea    0x88c3(%rip),%rdi        # f49e <fwp_segv.msg+0x25e>
    6bdb:	e8 50 b4 ff ff       	call   2030 <getenv@plt>
    6be0:	48 85 c0             	test   %rax,%rax
    6be3:	74 14                	je     6bf9 <fwp_gc_init+0x329>
    6be5:	48 89 c7             	mov    %rax,%rdi
    6be8:	31 f6                	xor    %esi,%esi
    6bea:	ba 0a 00 00 00       	mov    $0xa,%edx
    6bef:	e8 dc b5 ff ff       	call   21d0 <strtol@plt>
    6bf4:	48 89 c3             	mov    %rax,%rbx
    6bf7:	eb 02                	jmp    6bfb <fwp_gc_init+0x32b>
    6bf9:	31 db                	xor    %ebx,%ebx
    6bfb:	31 c0                	xor    %eax,%eax
    6bfd:	48 85 db             	test   %rbx,%rbx
    6c00:	48 0f 4f c3          	cmovg  %rbx,%rax
    6c04:	48 89 05 95 c5 00 00 	mov    %rax,0xc595(%rip)        # 131a0 <fwp_gc+0x1020>
    6c0b:	48 8d 3d 61 88 00 00 	lea    0x8861(%rip),%rdi        # f473 <fwp_segv.msg+0x233>
    6c12:	e8 19 b4 ff ff       	call   2030 <getenv@plt>
    6c17:	48 85 c0             	test   %rax,%rax
    6c1a:	74 32                	je     6c4e <fwp_gc_init+0x37e>
    6c1c:	49 89 c6             	mov    %rax,%r14
    6c1f:	80 38 00             	cmpb   $0x0,(%rax)
    6c22:	74 2a                	je     6c4e <fwp_gc_init+0x37e>
    6c24:	48 8d 35 4f 88 00 00 	lea    0x884f(%rip),%rsi        # f47a <fwp_segv.msg+0x23a>
    6c2b:	4c 89 f7             	mov    %r14,%rdi
    6c2e:	e8 4d b5 ff ff       	call   2180 <strcmp@plt>
    6c33:	85 c0                	test   %eax,%eax
    6c35:	74 17                	je     6c4e <fwp_gc_init+0x37e>
    6c37:	48 8d 35 24 8a 00 00 	lea    0x8a24(%rip),%rsi        # f662 <fwp_segv.msg+0x422>
    6c3e:	4c 89 f7             	mov    %r14,%rdi
    6c41:	e8 3a b5 ff ff       	call   2180 <strcmp@plt>
    6c46:	85 c0                	test   %eax,%eax
    6c48:	0f 85 f6 00 00 00    	jne    6d44 <fwp_gc_init+0x474>
    6c4e:	48 85 db             	test   %rbx,%rbx
    6c51:	0f 8f ed 00 00 00    	jg     6d44 <fwp_gc_init+0x474>
    6c57:	83 3d 26 c5 00 00 00 	cmpl   $0x0,0xc526(%rip)        # 13184 <fwp_gc+0x1004>
    6c5e:	0f 85 e0 00 00 00    	jne    6d44 <fwp_gc_init+0x474>
    6c64:	48 8d 3d 7e 88 00 00 	lea    0x887e(%rip),%rdi        # f4e9 <fwp_segv.msg+0x2a9>
    6c6b:	e8 c0 b3 ff ff       	call   2030 <getenv@plt>
    6c70:	48 85 c0             	test   %rax,%rax
    6c73:	74 1c                	je     6c91 <fwp_gc_init+0x3c1>
    6c75:	80 38 00             	cmpb   $0x0,(%rax)
    6c78:	74 17                	je     6c91 <fwp_gc_init+0x3c1>
    6c7a:	48 8d 35 e1 89 00 00 	lea    0x89e1(%rip),%rsi        # f662 <fwp_segv.msg+0x422>
    6c81:	48 89 c7             	mov    %rax,%rdi
    6c84:	e8 f7 b4 ff ff       	call   2180 <strcmp@plt>
    6c89:	85 c0                	test   %eax,%eax
    6c8b:	0f 85 e1 00 00 00    	jne    6d72 <fwp_gc_init+0x4a2>
    6c91:	c7 05 d5 c4 00 00 00 	movl   $0x0,0xc4d5(%rip)        # 13170 <fwp_gc+0xff0>
    6c98:	00 00 00 
    6c9b:	48 c7 05 ea c6 00 00 	movq   $0x800000,0xc6ea(%rip)        # 13390 <fwp_gc+0x1210>
    6ca2:	00 00 80 00 
    6ca6:	48 c7 05 cf b4 00 00 	movq   $0x800000,0xb4cf(%rip)        # 12180 <fwp_gc>
    6cad:	00 00 80 00 
    6cb1:	48 83 c4 08          	add    $0x8,%rsp
    6cb5:	5b                   	pop    %rbx
    6cb6:	41 5e                	pop    %r14
    6cb8:	c3                   	ret
    6cb9:	be 00 00 01 40       	mov    $0x40010000,%esi
    6cbe:	31 ff                	xor    %edi,%edi
    6cc0:	31 d2                	xor    %edx,%edx
    6cc2:	b9 22 40 00 00       	mov    $0x4022,%ecx
    6cc7:	41 b8 ff ff ff ff    	mov    $0xffffffff,%r8d
    6ccd:	45 31 c9             	xor    %r9d,%r9d
    6cd0:	e8 1b b4 ff ff       	call   20f0 <mmap@plt>
    6cd5:	48 83 f8 ff          	cmp    $0xffffffffffffffff,%rax
    6cd9:	74 0f                	je     6cea <fwp_gc_init+0x41a>
    6cdb:	48 85 c0             	test   %rax,%rax
    6cde:	74 3a                	je     6d1a <fwp_gc_init+0x44a>
    6ce0:	bb 00 00 00 40       	mov    $0x40000000,%ebx
    6ce5:	e9 8a fd ff ff       	jmp    6a74 <fwp_gc_init+0x1a4>
    6cea:	be 00 00 01 10       	mov    $0x10010000,%esi
    6cef:	31 ff                	xor    %edi,%edi
    6cf1:	31 d2                	xor    %edx,%edx
    6cf3:	b9 22 40 00 00       	mov    $0x4022,%ecx
    6cf8:	41 b8 ff ff ff ff    	mov    $0xffffffff,%r8d
    6cfe:	45 31 c9             	xor    %r9d,%r9d
    6d01:	e8 ea b3 ff ff       	call   20f0 <mmap@plt>
    6d06:	48 8d 48 01          	lea    0x1(%rax),%rcx
    6d0a:	48 83 f9 02          	cmp    $0x2,%rcx
    6d0e:	72 0a                	jb     6d1a <fwp_gc_init+0x44a>
    6d10:	bb 00 00 00 10       	mov    $0x10000000,%ebx
    6d15:	e9 5a fd ff ff       	jmp    6a74 <fwp_gc_init+0x1a4>
    6d1a:	48 8b 05 bf b2 00 00 	mov    0xb2bf(%rip),%rax        # 11fe0 <stderr@GLIBC_2.2.5>
    6d21:	48 8b 08             	mov    (%rax),%rcx
    6d24:	48 8d 3d 0e 88 00 00 	lea    0x880e(%rip),%rdi        # f539 <fwp_segv.msg+0x2f9>
    6d2b:	be 13 00 00 00       	mov    $0x13,%esi
    6d30:	ba 01 00 00 00       	mov    $0x1,%edx
    6d35:	e8 66 b5 ff ff       	call   22a0 <fwrite@plt>
    6d3a:	bf 66 00 00 00       	mov    $0x66,%edi
    6d3f:	e8 4c b5 ff ff       	call   2290 <exit@plt>
    6d44:	e8 a7 f5 ff ff       	call   62f0 <fwp_flush>
    6d49:	48 8b 05 90 b2 00 00 	mov    0xb290(%rip),%rax        # 11fe0 <stderr@GLIBC_2.2.5>
    6d50:	48 8b 38             	mov    (%rax),%rdi
    6d53:	48 8d 35 d3 86 00 00 	lea    0x86d3(%rip),%rsi        # f42d <fwp_segv.msg+0x1ed>
    6d5a:	48 8d 15 4b 87 00 00 	lea    0x874b(%rip),%rdx        # f4ac <fwp_segv.msg+0x26c>
    6d61:	31 c0                	xor    %eax,%eax
    6d63:	e8 48 b4 ff ff       	call   21b0 <fprintf@plt>
    6d68:	bf 65 00 00 00       	mov    $0x65,%edi
    6d6d:	e8 1e b5 ff ff       	call   2290 <exit@plt>
    6d72:	e8 79 f5 ff ff       	call   62f0 <fwp_flush>
    6d77:	48 8b 05 62 b2 00 00 	mov    0xb262(%rip),%rax        # 11fe0 <stderr@GLIBC_2.2.5>
    6d7e:	48 8b 38             	mov    (%rax),%rdi
    6d81:	48 8d 35 a5 86 00 00 	lea    0x86a5(%rip),%rsi        # f42d <fwp_segv.msg+0x1ed>
    6d88:	48 8d 15 6b 87 00 00 	lea    0x876b(%rip),%rdx        # f4fa <fwp_segv.msg+0x2ba>
    6d8f:	eb d0                	jmp    6d61 <fwp_gc_init+0x491>
    6d91:	66 66 66 66 66 66 2e 	data16 data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    6d98:	0f 1f 84 00 00 00 00 
    6d9f:	00 

0000000000006da0 <fwp_gc_alloc_big>:
    6da0:	55                   	push   %rbp
    6da1:	41 57                	push   %r15
    6da3:	41 56                	push   %r14
    6da5:	41 55                	push   %r13
    6da7:	41 54                	push   %r12
    6da9:	53                   	push   %rbx
    6daa:	50                   	push   %rax
    6dab:	48 b8 01 00 00 00 00 	movabs $0x4000000000000001,%rax
    6db2:	00 00 40 
    6db5:	48 39 c7             	cmp    %rax,%rdi
    6db8:	0f 83 ce 01 00 00    	jae    6f8c <fwp_gc_alloc_big+0x1ec>
    6dbe:	89 f5                	mov    %esi,%ebp
    6dc0:	48 89 fb             	mov    %rdi,%rbx
    6dc3:	48 29 3d b6 b3 00 00 	sub    %rdi,0xb3b6(%rip)        # 12180 <fwp_gc>
    6dca:	0f 89 80 00 00 00    	jns    6e50 <fwp_gc_alloc_big+0xb0>
    6dd0:	83 3d 95 c3 00 00 00 	cmpl   $0x0,0xc395(%rip)        # 1316c <fwp_gc+0xfec>
    6dd7:	75 05                	jne    6dde <fwp_gc_alloc_big+0x3e>
    6dd9:	e8 f2 fa ff ff       	call   68d0 <fwp_gc_init>
    6dde:	8b 0d 90 c3 00 00    	mov    0xc390(%rip),%ecx        # 13174 <fwp_gc+0xff4>
    6de4:	85 c9                	test   %ecx,%ecx
    6de6:	74 2a                	je     6e12 <fwp_gc_alloc_big+0x72>
    6de8:	48 8b 05 b1 c3 00 00 	mov    0xc3b1(%rip),%rax        # 131a0 <fwp_gc+0x1020>
    6def:	48 85 c0             	test   %rax,%rax
    6df2:	74 1e                	je     6e12 <fwp_gc_alloc_big+0x72>
    6df4:	48 8b 0d ad c3 00 00 	mov    0xc3ad(%rip),%rcx        # 131a8 <fwp_gc+0x1028>
    6dfb:	48 ff c1             	inc    %rcx
    6dfe:	48 89 0d a3 c3 00 00 	mov    %rcx,0xc3a3(%rip)        # 131a8 <fwp_gc+0x1028>
    6e05:	48 39 c1             	cmp    %rax,%rcx
    6e08:	0f 8d ad 01 00 00    	jge    6fbb <fwp_gc_alloc_big+0x21b>
    6e0e:	31 c0                	xor    %eax,%eax
    6e10:	eb 0d                	jmp    6e1f <fwp_gc_alloc_big+0x7f>
    6e12:	b8 00 00 80 00       	mov    $0x800000,%eax
    6e17:	85 c9                	test   %ecx,%ecx
    6e19:	0f 85 97 01 00 00    	jne    6fb6 <fwp_gc_alloc_big+0x216>
    6e1f:	48 8b 0d 6a c5 00 00 	mov    0xc56a(%rip),%rcx        # 13390 <fwp_gc+0x1210>
    6e26:	48 2b 0d 53 b3 00 00 	sub    0xb353(%rip),%rcx        # 12180 <fwp_gc>
    6e2d:	f2 48 0f 2a c1       	cvtsi2sd %rcx,%xmm0
    6e32:	f2 0f 58 05 2e c5 00 	addsd  0xc52e(%rip),%xmm0        # 13368 <fwp_gc+0x11e8>
    6e39:	00 
    6e3a:	f2 0f 11 05 26 c5 00 	movsd  %xmm0,0xc526(%rip)        # 13368 <fwp_gc+0x11e8>
    6e41:	00 
    6e42:	48 89 05 47 c5 00 00 	mov    %rax,0xc547(%rip)        # 13390 <fwp_gc+0x1210>
    6e49:	48 89 05 30 b3 00 00 	mov    %rax,0xb330(%rip)        # 12180 <fwp_gc>
    6e50:	4c 8d b3 ff ff 00 00 	lea    0xffff(%rbx),%r14
    6e57:	49 c1 ee 10          	shr    $0x10,%r14
    6e5b:	4c 89 f7             	mov    %r14,%rdi
    6e5e:	e8 9d 02 00 00       	call   7100 <fwp_gc_chunks>
    6e63:	48 8b 0d 8e c3 00 00 	mov    0xc38e(%rip),%rcx        # 131f8 <fwp_gc+0x1078>
    6e6a:	4c 69 e0 28 12 00 00 	imul   $0x1228,%rax,%r12
    6e71:	42 c6 04 21 02       	movb   $0x2,(%rcx,%r12,1)
    6e76:	42 88 6c 21 01       	mov    %bpl,0x1(%rcx,%r12,1)
    6e7b:	66 42 c7 44 21 03 00 	movw   $0x100,0x3(%rcx,%r12,1)
    6e82:	01 
    6e83:	46 89 74 21 10       	mov    %r14d,0x10(%rcx,%r12,1)
    6e88:	4a 89 5c 21 18       	mov    %rbx,0x18(%rcx,%r12,1)
    6e8d:	4e 8d 3c 21          	lea    (%rcx,%r12,1),%r15
    6e91:	49 81 c7 28 02 00 00 	add    $0x228,%r15
    6e98:	42 80 bc 21 28 02 00 	cmpb   $0xff,0x228(%rcx,%r12,1)
    6e9f:	00 ff 
    6ea1:	0f 84 d2 00 00 00    	je     6f79 <fwp_gc_alloc_big+0x1d9>
    6ea7:	41 c6 07 00          	movb   $0x0,(%r15)
    6eab:	48 81 fb 01 00 01 00 	cmp    $0x10001,%rbx
    6eb2:	0f 82 9b 00 00 00    	jb     6f53 <fwp_gc_alloc_big+0x1b3>
    6eb8:	49 83 fe 03          	cmp    $0x3,%r14
    6ebc:	ba 02 00 00 00       	mov    $0x2,%edx
    6ec1:	49 0f 43 d6          	cmovae %r14,%rdx
    6ec5:	48 8b 0d 2c c3 00 00 	mov    0xc32c(%rip),%rcx        # 131f8 <fwp_gc+0x1078>
    6ecc:	48 ff ca             	dec    %rdx
    6ecf:	be 01 00 00 00       	mov    $0x1,%esi
    6ed4:	48 81 fb 01 00 02 00 	cmp    $0x20001,%rbx
    6edb:	72 5a                	jb     6f37 <fwp_gc_alloc_big+0x197>
    6edd:	49 8d 3c 0c          	lea    (%r12,%rcx,1),%rdi
    6ee1:	48 81 c7 60 24 00 00 	add    $0x2460,%rdi
    6ee8:	49 89 d0             	mov    %rdx,%r8
    6eeb:	49 83 e0 fe          	and    $0xfffffffffffffffe,%r8
    6eef:	49 f7 d8             	neg    %r8
    6ef2:	66 66 66 66 66 2e 0f 	data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    6ef9:	1f 84 00 00 00 00 00 
    6f00:	c6 87 c8 ed ff ff 03 	movb   $0x3,-0x1238(%rdi)
    6f07:	c6 87 cc ed ff ff 01 	movb   $0x1,-0x1234(%rdi)
    6f0e:	89 87 d8 ed ff ff    	mov    %eax,-0x1228(%rdi)
    6f14:	c6 47 f0 03          	movb   $0x3,-0x10(%rdi)
    6f18:	c6 47 f4 01          	movb   $0x1,-0xc(%rdi)
    6f1c:	89 07                	mov    %eax,(%rdi)
    6f1e:	48 81 c7 50 24 00 00 	add    $0x2450,%rdi
    6f25:	4d 8d 0c 30          	lea    (%r8,%rsi,1),%r9
    6f29:	49 83 c1 02          	add    $0x2,%r9
    6f2d:	48 83 c6 02          	add    $0x2,%rsi
    6f31:	49 83 f9 01          	cmp    $0x1,%r9
    6f35:	75 c9                	jne    6f00 <fwp_gc_alloc_big+0x160>
    6f37:	f6 c2 01             	test   $0x1,%dl
    6f3a:	74 17                	je     6f53 <fwp_gc_alloc_big+0x1b3>
    6f3c:	4c 01 e1             	add    %r12,%rcx
    6f3f:	48 69 d6 28 12 00 00 	imul   $0x1228,%rsi,%rdx
    6f46:	c6 04 11 03          	movb   $0x3,(%rcx,%rdx,1)
    6f4a:	c6 44 11 04 01       	movb   $0x1,0x4(%rcx,%rdx,1)
    6f4f:	89 44 11 10          	mov    %eax,0x10(%rcx,%rdx,1)
    6f53:	48 c1 e0 10          	shl    $0x10,%rax
    6f57:	48 03 05 52 c2 00 00 	add    0xc252(%rip),%rax        # 131b0 <fwp_gc+0x1030>
    6f5e:	48 89 c7             	mov    %rax,%rdi
    6f61:	31 f6                	xor    %esi,%esi
    6f63:	48 89 da             	mov    %rbx,%rdx
    6f66:	48 83 c4 08          	add    $0x8,%rsp
    6f6a:	5b                   	pop    %rbx
    6f6b:	41 5c                	pop    %r12
    6f6d:	41 5d                	pop    %r13
    6f6f:	41 5e                	pop    %r14
    6f71:	41 5f                	pop    %r15
    6f73:	5d                   	pop    %rbp
    6f74:	e9 b7 b1 ff ff       	jmp    2130 <memset@plt>
    6f79:	4c 89 ff             	mov    %r15,%rdi
    6f7c:	49 89 c5             	mov    %rax,%r13
    6f7f:	e8 9c f3 ff ff       	call   6320 <fwp_rc_forget_slot>
    6f84:	4c 89 e8             	mov    %r13,%rax
    6f87:	e9 1b ff ff ff       	jmp    6ea7 <fwp_gc_alloc_big+0x107>
    6f8c:	48 8b 05 4d b0 00 00 	mov    0xb04d(%rip),%rax        # 11fe0 <stderr@GLIBC_2.2.5>
    6f93:	48 8b 08             	mov    (%rax),%rcx
    6f96:	48 8d 3d 9c 85 00 00 	lea    0x859c(%rip),%rdi        # f539 <fwp_segv.msg+0x2f9>
    6f9d:	be 13 00 00 00       	mov    $0x13,%esi
    6fa2:	ba 01 00 00 00       	mov    $0x1,%edx
    6fa7:	e8 f4 b2 ff ff       	call   22a0 <fwrite@plt>
    6fac:	bf 66 00 00 00       	mov    $0x66,%edi
    6fb1:	e8 da b2 ff ff       	call   2290 <exit@plt>
    6fb6:	e8 d5 02 00 00       	call   7290 <fwp_gc_collect>
    6fbb:	48 c7 05 e2 c1 00 00 	movq   $0x0,0xc1e2(%rip)        # 131a8 <fwp_gc+0x1028>
    6fc2:	00 00 00 00 
    6fc6:	e8 c5 02 00 00       	call   7290 <fwp_gc_collect>
    6fcb:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)

0000000000006fd0 <fwp_gc_refill>:
    6fd0:	55                   	push   %rbp
    6fd1:	41 57                	push   %r15
    6fd3:	41 56                	push   %r14
    6fd5:	41 55                	push   %r13
    6fd7:	41 54                	push   %r12
    6fd9:	53                   	push   %rbx
    6fda:	50                   	push   %rax
    6fdb:	89 d5                	mov    %edx,%ebp
    6fdd:	41 89 f7             	mov    %esi,%r15d
    6fe0:	48 89 fb             	mov    %rdi,%rbx
    6fe3:	bf 01 00 00 00       	mov    $0x1,%edi
    6fe8:	e8 13 01 00 00       	call   7100 <fwp_gc_chunks>
    6fed:	49 89 c6             	mov    %rax,%r14
    6ff0:	4c 8b 25 01 c2 00 00 	mov    0xc201(%rip),%r12        # 131f8 <fwp_gc+0x1078>
    6ff7:	48 8d 05 82 b1 00 00 	lea    0xb182(%rip),%rax        # 12180 <fwp_gc>
    6ffe:	4d 69 ee 28 12 00 00 	imul   $0x1228,%r14,%r13
    7005:	43 c6 04 2c 01       	movb   $0x1,(%r12,%r13,1)
    700a:	43 88 6c 2c 01       	mov    %bpl,0x1(%r12,%r13,1)
    700f:	47 88 7c 2c 02       	mov    %r15b,0x2(%r12,%r13,1)
    7014:	43 c6 44 2c 04 01    	movb   $0x1,0x4(%r12,%r13,1)
    701a:	44 89 f9             	mov    %r15d,%ecx
    701d:	8b 8c 88 48 0b 00 00 	mov    0xb48(%rax,%rcx,4),%ecx
    7024:	43 89 4c 2c 08       	mov    %ecx,0x8(%r12,%r13,1)
    7029:	b8 00 00 01 00       	mov    $0x10000,%eax
    702e:	31 d2                	xor    %edx,%edx
    7030:	f7 f1                	div    %ecx
    7032:	43 89 44 2c 0c       	mov    %eax,0xc(%r12,%r13,1)
    7037:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    703c:	48 01 c8             	add    %rcx,%rax
    703f:	48 0f ba e0 20       	bt     $0x20,%rax
    7044:	73 07                	jae    704d <fwp_gc_refill+0x7d>
    7046:	31 d2                	xor    %edx,%edx
    7048:	48 f7 f1             	div    %rcx
    704b:	eb 04                	jmp    7051 <fwp_gc_refill+0x81>
    704d:	31 d2                	xor    %edx,%edx
    704f:	f7 f1                	div    %ecx
    7051:	43 89 44 2c 20       	mov    %eax,0x20(%r12,%r13,1)
    7056:	48 83 3d 3a cb 00 00 	cmpq   $0x0,0xcb3a(%rip)        # 13b98 <fwp_gc+0x1a18>
    705d:	00 
    705e:	74 2e                	je     708e <fwp_gc_refill+0xbe>
    7060:	4f 8d 3c 2c          	lea    (%r12,%r13,1),%r15
    7064:	49 81 c7 28 02 00 00 	add    $0x228,%r15
    706b:	31 ed                	xor    %ebp,%ebp
    706d:	eb 0d                	jmp    707c <fwp_gc_refill+0xac>
    706f:	90                   	nop
    7070:	48 ff c5             	inc    %rbp
    7073:	48 81 fd 00 10 00 00 	cmp    $0x1000,%rbp
    707a:	74 12                	je     708e <fwp_gc_refill+0xbe>
    707c:	41 80 3c 2f ff       	cmpb   $0xff,(%r15,%rbp,1)
    7081:	75 ed                	jne    7070 <fwp_gc_refill+0xa0>
    7083:	49 8d 3c 2f          	lea    (%r15,%rbp,1),%rdi
    7087:	e8 94 f2 ff ff       	call   6320 <fwp_rc_forget_slot>
    708c:	eb e2                	jmp    7070 <fwp_gc_refill+0xa0>
    708e:	4f 8d 3c 2c          	lea    (%r12,%r13,1),%r15
    7092:	49 83 c7 08          	add    $0x8,%r15
    7096:	4b 8d 3c 2c          	lea    (%r12,%r13,1),%rdi
    709a:	48 81 c7 28 02 00 00 	add    $0x228,%rdi
    70a1:	ba 00 10 00 00       	mov    $0x1000,%edx
    70a6:	31 f6                	xor    %esi,%esi
    70a8:	e8 83 b0 ff ff       	call   2130 <memset@plt>
    70ad:	49 c1 e6 10          	shl    $0x10,%r14
    70b1:	4c 03 35 f8 c0 00 00 	add    0xc0f8(%rip),%r14        # 131b0 <fwp_gc+0x1030>
    70b8:	83 3d c5 c0 00 00 00 	cmpl   $0x0,0xc0c5(%rip)        # 13184 <fwp_gc+0x1004>
    70bf:	74 0f                	je     70d0 <fwp_gc_refill+0x100>
    70c1:	ba 00 00 01 00       	mov    $0x10000,%edx
    70c6:	4c 89 f7             	mov    %r14,%rdi
    70c9:	31 f6                	xor    %esi,%esi
    70cb:	e8 60 b0 ff ff       	call   2130 <memset@plt>
    70d0:	41 8b 07             	mov    (%r15),%eax
    70d3:	49 8d 0c 06          	lea    (%r14,%rax,1),%rcx
    70d7:	48 89 4b 08          	mov    %rcx,0x8(%rbx)
    70db:	41 8b 4f 04          	mov    0x4(%r15),%ecx
    70df:	48 0f af c8          	imul   %rax,%rcx
    70e3:	4c 01 f1             	add    %r14,%rcx
    70e6:	48 89 4b 10          	mov    %rcx,0x10(%rbx)
    70ea:	4c 89 f0             	mov    %r14,%rax
    70ed:	48 83 c4 08          	add    $0x8,%rsp
    70f1:	5b                   	pop    %rbx
    70f2:	41 5c                	pop    %r12
    70f4:	41 5d                	pop    %r13
    70f6:	41 5e                	pop    %r14
    70f8:	41 5f                	pop    %r15
    70fa:	5d                   	pop    %rbp
    70fb:	c3                   	ret
    70fc:	0f 1f 40 00          	nopl   0x0(%rax)

0000000000007100 <fwp_gc_chunks>:
    7100:	41 57                	push   %r15
    7102:	41 56                	push   %r14
    7104:	53                   	push   %rbx
    7105:	48 89 fb             	mov    %rdi,%rbx
    7108:	31 d2                	xor    %edx,%edx
    710a:	48 83 ff 01          	cmp    $0x1,%rdi
    710e:	0f 95 c2             	setne  %dl
    7111:	48 8d 0d 68 b0 00 00 	lea    0xb068(%rip),%rcx        # 12180 <fwp_gc>
    7118:	48 8b 84 d1 68 10 00 	mov    0x1068(%rcx,%rdx,8),%rax
    711f:	00 
    7120:	4c 8b 35 b1 c0 00 00 	mov    0xc0b1(%rip),%r14        # 131d8 <fwp_gc+0x1058>
    7127:	48 89 c7             	mov    %rax,%rdi
    712a:	4c 29 f7             	sub    %r14,%rdi
    712d:	73 63                	jae    7192 <fwp_gc_chunks+0x92>
    712f:	48 8d 34 d5 68 10 00 	lea    0x1068(,%rdx,8),%rsi
    7136:	00 
    7137:	4c 69 c0 28 12 00 00 	imul   $0x1228,%rax,%r8
    713e:	4c 03 05 b3 c0 00 00 	add    0xc0b3(%rip),%r8        # 131f8 <fwp_gc+0x1078>
    7145:	31 d2                	xor    %edx,%edx
    7147:	45 31 c9             	xor    %r9d,%r9d
    714a:	eb 16                	jmp    7162 <fwp_gc_chunks+0x62>
    714c:	0f 1f 40 00          	nopl   0x0(%rax)
    7150:	45 31 c9             	xor    %r9d,%r9d
    7153:	48 ff ca             	dec    %rdx
    7156:	49 81 c0 28 12 00 00 	add    $0x1228,%r8
    715d:	48 39 d7             	cmp    %rdx,%rdi
    7160:	74 33                	je     7195 <fwp_gc_chunks+0x95>
    7162:	41 80 38 00          	cmpb   $0x0,(%r8)
    7166:	75 e8                	jne    7150 <fwp_gc_chunks+0x50>
    7168:	49 ff c1             	inc    %r9
    716b:	49 39 d9             	cmp    %rbx,%r9
    716e:	75 e3                	jne    7153 <fwp_gc_chunks+0x53>
    7170:	48 ff c0             	inc    %rax
    7173:	48 89 c7             	mov    %rax,%rdi
    7176:	48 29 d7             	sub    %rdx,%rdi
    7179:	48 89 3c 0e          	mov    %rdi,(%rsi,%rcx,1)
    717d:	48 29 1d dc c1 00 00 	sub    %rbx,0xc1dc(%rip)        # 13360 <fwp_gc+0x11e0>
    7184:	48 29 d8             	sub    %rbx,%rax
    7187:	48 29 d0             	sub    %rdx,%rax
    718a:	49 89 c6             	mov    %rax,%r14
    718d:	e9 ca 00 00 00       	jmp    725c <fwp_gc_chunks+0x15c>
    7192:	45 31 c9             	xor    %r9d,%r9d
    7195:	4c 29 0d c4 c1 00 00 	sub    %r9,0xc1c4(%rip)        # 13360 <fwp_gc+0x11e0>
    719c:	4d 29 ce             	sub    %r9,%r14
    719f:	4c 01 f3             	add    %r14,%rbx
    71a2:	48 8b 3d 37 c0 00 00 	mov    0xc037(%rip),%rdi        # 131e0 <fwp_gc+0x1060>
    71a9:	48 39 df             	cmp    %rbx,%rdi
    71ac:	0f 83 8f 00 00 00    	jae    7241 <fwp_gc_chunks+0x141>
    71b2:	4c 8b 3d 17 c0 00 00 	mov    0xc017(%rip),%r15        # 131d0 <fwp_gc+0x1050>
    71b9:	49 39 df             	cmp    %rbx,%r15
    71bc:	0f 82 a3 00 00 00    	jb     7265 <fwp_gc_chunks+0x165>
    71c2:	48 8d 43 40          	lea    0x40(%rbx),%rax
    71c6:	4c 39 f8             	cmp    %r15,%rax
    71c9:	4c 0f 42 f8          	cmovb  %rax,%r15
    71cd:	4c 89 fe             	mov    %r15,%rsi
    71d0:	48 29 fe             	sub    %rdi,%rsi
    71d3:	48 c1 e7 10          	shl    $0x10,%rdi
    71d7:	48 03 3d d2 bf 00 00 	add    0xbfd2(%rip),%rdi        # 131b0 <fwp_gc+0x1030>
    71de:	48 c1 e6 10          	shl    $0x10,%rsi
    71e2:	ba 03 00 00 00       	mov    $0x3,%edx
    71e7:	e8 54 b0 ff ff       	call   2240 <mprotect@plt>
    71ec:	85 c0                	test   %eax,%eax
    71ee:	75 75                	jne    7265 <fwp_gc_chunks+0x165>
    71f0:	bf 1e 00 00 00       	mov    $0x1e,%edi
    71f5:	e8 66 b0 ff ff       	call   2260 <sysconf@plt>
    71fa:	48 8b 0d f7 bf 00 00 	mov    0xbff7(%rip),%rcx        # 131f8 <fwp_gc+0x1078>
    7201:	48 69 3d d4 bf 00 00 	imul   $0x1228,0xbfd4(%rip),%rdi        # 131e0 <fwp_gc+0x1060>
    7208:	28 12 00 00 
    720c:	48 01 cf             	add    %rcx,%rdi
    720f:	49 69 d7 28 12 00 00 	imul   $0x1228,%r15,%rdx
    7216:	48 01 ca             	add    %rcx,%rdx
    7219:	48 8d 34 10          	lea    (%rax,%rdx,1),%rsi
    721d:	48 ff ce             	dec    %rsi
    7220:	48 f7 d8             	neg    %rax
    7223:	48 21 c7             	and    %rax,%rdi
    7226:	48 21 c6             	and    %rax,%rsi
    7229:	48 29 fe             	sub    %rdi,%rsi
    722c:	ba 03 00 00 00       	mov    $0x3,%edx
    7231:	e8 0a b0 ff ff       	call   2240 <mprotect@plt>
    7236:	85 c0                	test   %eax,%eax
    7238:	75 2b                	jne    7265 <fwp_gc_chunks+0x165>
    723a:	4c 89 3d 9f bf 00 00 	mov    %r15,0xbf9f(%rip)        # 131e0 <fwp_gc+0x1060>
    7241:	48 89 1d 90 bf 00 00 	mov    %rbx,0xbf90(%rip)        # 131d8 <fwp_gc+0x1058>
    7248:	48 c1 e3 10          	shl    $0x10,%rbx
    724c:	48 3b 1d 75 bf 00 00 	cmp    0xbf75(%rip),%rbx        # 131c8 <fwp_gc+0x1048>
    7253:	76 07                	jbe    725c <fwp_gc_chunks+0x15c>
    7255:	48 89 1d 6c bf 00 00 	mov    %rbx,0xbf6c(%rip)        # 131c8 <fwp_gc+0x1048>
    725c:	4c 89 f0             	mov    %r14,%rax
    725f:	5b                   	pop    %rbx
    7260:	41 5e                	pop    %r14
    7262:	41 5f                	pop    %r15
    7264:	c3                   	ret
    7265:	48 8b 05 74 ad 00 00 	mov    0xad74(%rip),%rax        # 11fe0 <stderr@GLIBC_2.2.5>
    726c:	48 8b 08             	mov    (%rax),%rcx
    726f:	48 8d 3d c3 82 00 00 	lea    0x82c3(%rip),%rdi        # f539 <fwp_segv.msg+0x2f9>
    7276:	be 13 00 00 00       	mov    $0x13,%esi
    727b:	ba 01 00 00 00       	mov    $0x1,%edx
    7280:	e8 1b b0 ff ff       	call   22a0 <fwrite@plt>
    7285:	bf 66 00 00 00       	mov    $0x66,%edi
    728a:	e8 01 b0 ff ff       	call   2290 <exit@plt>
    728f:	90                   	nop

0000000000007290 <fwp_gc_collect>:
    7290:	50                   	push   %rax
    7291:	e8 5a f0 ff ff       	call   62f0 <fwp_flush>
    7296:	48 8b 05 43 ad 00 00 	mov    0xad43(%rip),%rax        # 11fe0 <stderr@GLIBC_2.2.5>
    729d:	48 8b 38             	mov    (%rax),%rdi
    72a0:	48 8d 35 86 81 00 00 	lea    0x8186(%rip),%rsi        # f42d <fwp_segv.msg+0x1ed>
    72a7:	48 8d 15 9f 82 00 00 	lea    0x829f(%rip),%rdx        # f54d <fwp_segv.msg+0x30d>
    72ae:	31 c0                	xor    %eax,%eax
    72b0:	e8 fb ae ff ff       	call   21b0 <fprintf@plt>
    72b5:	bf 65 00 00 00       	mov    $0x65,%edi
    72ba:	e8 d1 af ff ff       	call   2290 <exit@plt>
    72bf:	90                   	nop

00000000000072c0 <f12>:
    72c0:	55                   	push   %rbp
    72c1:	41 57                	push   %r15
    72c3:	41 56                	push   %r14
    72c5:	41 55                	push   %r13
    72c7:	41 54                	push   %r12
    72c9:	53                   	push   %rbx
    72ca:	50                   	push   %rax
    72cb:	48 89 d3             	mov    %rdx,%rbx
    72ce:	49 89 ff             	mov    %rdi,%r15
    72d1:	49 bc ff ff ff ff ff 	movabs $0x7fffffffffffffff,%r12
    72d8:	ff ff 7f 
    72db:	48 8b 02             	mov    (%rdx),%rax
    72de:	49 89 c6             	mov    %rax,%r14
    72e1:	4d 21 e6             	and    %r12,%r14
    72e4:	31 c9                	xor    %ecx,%ecx
    72e6:	48 85 ff             	test   %rdi,%rdi
    72e9:	4c 0f 4e f9          	cmovle %rcx,%r15
    72ed:	4d 39 f7             	cmp    %r14,%r15
    72f0:	4d 0f 43 fe          	cmovae %r14,%r15
    72f4:	48 85 f6             	test   %rsi,%rsi
    72f7:	48 0f 4f ce          	cmovg  %rsi,%rcx
    72fb:	4d 29 fe             	sub    %r15,%r14
    72fe:	4c 39 f1             	cmp    %r14,%rcx
    7301:	4c 0f 42 f1          	cmovb  %rcx,%r14
    7305:	4d 85 f6             	test   %r14,%r14
    7308:	74 10                	je     731a <f12+0x5a>
    730a:	48 89 d9             	mov    %rbx,%rcx
    730d:	48 85 c0             	test   %rax,%rax
    7310:	78 1b                	js     732d <f12+0x6d>
    7312:	49 83 fe 04          	cmp    $0x4,%r14
    7316:	73 1f                	jae    7337 <f12+0x77>
    7318:	eb 44                	jmp    735e <f12+0x9e>
    731a:	48 8d 35 2f a9 00 00 	lea    0xa92f(%rip),%rsi        # 11c50 <d0>
    7321:	31 ff                	xor    %edi,%edi
    7323:	e8 a8 f1 ff ff       	call   64d0 <fwp_array_typed_new>
    7328:	e9 7e 00 00 00       	jmp    73ab <f12+0xeb>
    732d:	48 8b 4b 08          	mov    0x8(%rbx),%rcx
    7331:	49 83 fe 04          	cmp    $0x4,%r14
    7335:	72 27                	jb     735e <f12+0x9e>
    7337:	48 8b 09             	mov    (%rcx),%rcx
    733a:	48 89 ca             	mov    %rcx,%rdx
    733d:	48 c1 ea 02          	shr    $0x2,%rdx
    7341:	48 be ff ff ff ff ff 	movabs $0x1fffffffffffffff,%rsi
    7348:	ff ff 1f 
    734b:	48 21 d6             	and    %rdx,%rsi
    734e:	83 e1 03             	and    $0x3,%ecx
    7351:	48 83 f9 01          	cmp    $0x1,%rcx
    7355:	48 83 de ff          	sbb    $0xffffffffffffffff,%rsi
    7359:	4c 39 f6             	cmp    %r14,%rsi
    735c:	76 5c                	jbe    73ba <f12+0xfa>
    735e:	48 8d 35 eb a8 00 00 	lea    0xa8eb(%rip),%rsi        # 11c50 <d0>
    7365:	4c 89 f7             	mov    %r14,%rdi
    7368:	e8 63 f1 ff ff       	call   64d0 <fwp_array_typed_new>
    736d:	48 8d 4b 08          	lea    0x8(%rbx),%rcx
    7371:	49 c1 e7 03          	shl    $0x3,%r15
    7375:	31 d2                	xor    %edx,%edx
    7377:	66 0f 1f 84 00 00 00 	nopw   0x0(%rax,%rax,1)
    737e:	00 00 
    7380:	48 83 3b 00          	cmpq   $0x0,(%rbx)
    7384:	48 89 ce             	mov    %rcx,%rsi
    7387:	79 04                	jns    738d <f12+0xcd>
    7389:	48 8b 73 10          	mov    0x10(%rbx),%rsi
    738d:	48 83 38 00          	cmpq   $0x0,(%rax)
    7391:	0f 88 37 02 00 00    	js     75ce <f12+0x30e>
    7397:	4c 01 fe             	add    %r15,%rsi
    739a:	48 8b 34 d6          	mov    (%rsi,%rdx,8),%rsi
    739e:	48 89 74 d0 08       	mov    %rsi,0x8(%rax,%rdx,8)
    73a3:	48 ff c2             	inc    %rdx
    73a6:	49 39 d6             	cmp    %rdx,%r14
    73a9:	75 d5                	jne    7380 <f12+0xc0>
    73ab:	48 83 c4 08          	add    $0x8,%rsp
    73af:	5b                   	pop    %rbx
    73b0:	41 5c                	pop    %r12
    73b2:	41 5d                	pop    %r13
    73b4:	41 5e                	pop    %r14
    73b6:	41 5f                	pop    %r15
    73b8:	5d                   	pop    %rbp
    73b9:	c3                   	ret
    73ba:	48 85 c0             	test   %rax,%rax
    73bd:	78 09                	js     73c8 <f12+0x108>
    73bf:	48 8d 43 08          	lea    0x8(%rbx),%rax
    73c3:	49 89 dd             	mov    %rbx,%r13
    73c6:	eb 08                	jmp    73d0 <f12+0x110>
    73c8:	4c 8b 6b 08          	mov    0x8(%rbx),%r13
    73cc:	48 8b 43 10          	mov    0x10(%rbx),%rax
    73d0:	4a 8d 2c f8          	lea    (%rax,%r15,8),%rbp
    73d4:	48 8d 0d a5 ad 00 00 	lea    0xada5(%rip),%rcx        # 12180 <fwp_gc>
    73db:	0f b6 05 88 b9 00 00 	movzbl 0xb988(%rip),%eax        # 12d6a <fwp_gc+0xbea>
    73e2:	8b 94 81 48 0b 00 00 	mov    0xb48(%rcx,%rax,4),%edx
    73e9:	48 8b 3d 90 ad 00 00 	mov    0xad90(%rip),%rdi        # 12180 <fwp_gc>
    73f0:	48 29 d7             	sub    %rdx,%rdi
    73f3:	48 89 3d 86 ad 00 00 	mov    %rdi,0xad86(%rip)        # 12180 <fwp_gc>
    73fa:	78 56                	js     7452 <f12+0x192>
    73fc:	48 8d 34 40          	lea    (%rax,%rax,2),%rsi
    7400:	4c 8d 04 f1          	lea    (%rcx,%rsi,8),%r8
    7404:	49 83 c0 08          	add    $0x8,%r8
    7408:	49 8b 00             	mov    (%r8),%rax
    740b:	48 85 c0             	test   %rax,%rax
    740e:	74 25                	je     7435 <f12+0x175>
    7410:	48 8b 08             	mov    (%rax),%rcx
    7413:	48 f7 d1             	not    %rcx
    7416:	49 89 08             	mov    %rcx,(%r8)
    7419:	83 fa 19             	cmp    $0x19,%edx
    741c:	72 7e                	jb     749c <f12+0x1dc>
    741e:	48 8d 78 18          	lea    0x18(%rax),%rdi
    7422:	48 83 c2 e7          	add    $0xffffffffffffffe7,%rdx
    7426:	48 83 e2 f8          	and    $0xfffffffffffffff8,%rdx
    742a:	48 83 c2 08          	add    $0x8,%rdx
    742e:	31 f6                	xor    %esi,%esi
    7430:	49 89 c7             	mov    %rax,%r15
    7433:	eb 5f                	jmp    7494 <f12+0x1d4>
    7435:	48 8b 44 f1 10       	mov    0x10(%rcx,%rsi,8),%rax
    743a:	4c 8b 44 f1 18       	mov    0x18(%rcx,%rsi,8),%r8
    743f:	4d 89 c1             	mov    %r8,%r9
    7442:	49 29 c1             	sub    %rax,%r9
    7445:	49 39 d1             	cmp    %rdx,%r9
    7448:	73 16                	jae    7460 <f12+0x1a0>
    744a:	49 89 c7             	mov    %rax,%r15
    744d:	49 39 d1             	cmp    %rdx,%r9
    7450:	73 34                	jae    7486 <f12+0x1c6>
    7452:	bf 18 00 00 00       	mov    $0x18,%edi
    7457:	31 f6                	xor    %esi,%esi
    7459:	e8 e2 f2 ff ff       	call   6740 <fwp_gc_alloc_slow>
    745e:	eb 3c                	jmp    749c <f12+0x1dc>
    7460:	4c 8d 0c f1          	lea    (%rcx,%rsi,8),%r9
    7464:	49 83 c1 10          	add    $0x10,%r9
    7468:	4c 8d 3c 10          	lea    (%rax,%rdx,1),%r15
    746c:	4d 89 39             	mov    %r15,(%r9)
    746f:	48 85 c0             	test   %rax,%rax
    7472:	75 a5                	jne    7419 <f12+0x159>
    7474:	48 89 3d 05 ad 00 00 	mov    %rdi,0xad05(%rip)        # 12180 <fwp_gc>
    747b:	4d 29 f8             	sub    %r15,%r8
    747e:	4d 89 c1             	mov    %r8,%r9
    7481:	49 39 d1             	cmp    %rdx,%r9
    7484:	72 cc                	jb     7452 <f12+0x192>
    7486:	49 8d 04 17          	lea    (%r15,%rdx,1),%rax
    748a:	48 89 44 f1 10       	mov    %rax,0x10(%rcx,%rsi,8)
    748f:	4c 89 ff             	mov    %r15,%rdi
    7492:	31 f6                	xor    %esi,%esi
    7494:	e8 97 ac ff ff       	call   2130 <memset@plt>
    7499:	4c 89 f8             	mov    %r15,%rax
    749c:	4b 8d 0c 34          	lea    (%r12,%r14,1),%rcx
    74a0:	48 ff c1             	inc    %rcx
    74a3:	48 89 08             	mov    %rcx,(%rax)
    74a6:	4c 89 68 08          	mov    %r13,0x8(%rax)
    74aa:	48 89 68 10          	mov    %rbp,0x10(%rax)
    74ae:	4c 2b 2d fb bc 00 00 	sub    0xbcfb(%rip),%r13        # 131b0 <fwp_gc+0x1030>
    74b5:	48 8b 0d 1c bd 00 00 	mov    0xbd1c(%rip),%rcx        # 131d8 <fwp_gc+0x1058>
    74bc:	48 c1 e1 10          	shl    $0x10,%rcx
    74c0:	49 39 cd             	cmp    %rcx,%r13
    74c3:	73 6a                	jae    752f <f12+0x26f>
    74c5:	48 8b 0d 2c bd 00 00 	mov    0xbd2c(%rip),%rcx        # 131f8 <fwp_gc+0x1078>
    74cc:	4c 89 ea             	mov    %r13,%rdx
    74cf:	48 c1 ea 10          	shr    $0x10,%rdx
    74d3:	48 69 d2 28 12 00 00 	imul   $0x1228,%rdx,%rdx
    74da:	0f b6 34 11          	movzbl (%rcx,%rdx,1),%esi
    74de:	49 81 e5 ff ff 00 00 	and    $0xffff,%r13
    74e5:	75 13                	jne    74fa <f12+0x23a>
    74e7:	40 80 fe 02          	cmp    $0x2,%sil
    74eb:	75 0d                	jne    74fa <f12+0x23a>
    74ed:	48 8d 3c 11          	lea    (%rcx,%rdx,1),%rdi
    74f1:	48 81 c7 28 02 00 00 	add    $0x228,%rdi
    74f8:	eb 21                	jmp    751b <f12+0x25b>
    74fa:	40 80 fe 01          	cmp    $0x1,%sil
    74fe:	75 2f                	jne    752f <f12+0x26f>
    7500:	48 8d 34 11          	lea    (%rcx,%rdx,1),%rsi
    7504:	8b 4c 11 20          	mov    0x20(%rcx,%rdx,1),%ecx
    7508:	4c 0f af e9          	imul   %rcx,%r13
    750c:	49 c1 ed 20          	shr    $0x20,%r13
    7510:	4a 8d 3c 2e          	lea    (%rsi,%r13,1),%rdi
    7514:	48 81 c7 28 02 00 00 	add    $0x228,%rdi
    751b:	0f b6 0f             	movzbl (%rdi),%ecx
    751e:	84 c9                	test   %cl,%cl
    7520:	74 0d                	je     752f <f12+0x26f>
    7522:	80 f9 fe             	cmp    $0xfe,%cl
    7525:	0f 83 93 00 00 00    	jae    75be <f12+0x2fe>
    752b:	fe c1                	inc    %cl
    752d:	88 0f                	mov    %cl,(%rdi)
    752f:	48 89 c1             	mov    %rax,%rcx
    7532:	48 2b 0d 77 bc 00 00 	sub    0xbc77(%rip),%rcx        # 131b0 <fwp_gc+0x1030>
    7539:	48 8b 15 98 bc 00 00 	mov    0xbc98(%rip),%rdx        # 131d8 <fwp_gc+0x1058>
    7540:	48 c1 e2 10          	shl    $0x10,%rdx
    7544:	48 39 d1             	cmp    %rdx,%rcx
    7547:	73 60                	jae    75a9 <f12+0x2e9>
    7549:	48 8b 15 a8 bc 00 00 	mov    0xbca8(%rip),%rdx        # 131f8 <fwp_gc+0x1078>
    7550:	48 89 ce             	mov    %rcx,%rsi
    7553:	48 c1 ee 10          	shr    $0x10,%rsi
    7557:	48 69 f6 28 12 00 00 	imul   $0x1228,%rsi,%rsi
    755e:	0f b6 3c 32          	movzbl (%rdx,%rsi,1),%edi
    7562:	48 81 e1 ff ff 00 00 	and    $0xffff,%rcx
    7569:	75 13                	jne    757e <f12+0x2be>
    756b:	40 80 ff 02          	cmp    $0x2,%dil
    756f:	75 0d                	jne    757e <f12+0x2be>
    7571:	4c 8d 34 32          	lea    (%rdx,%rsi,1),%r14
    7575:	49 81 c6 28 02 00 00 	add    $0x228,%r14
    757c:	eb 21                	jmp    759f <f12+0x2df>
    757e:	40 80 ff 01          	cmp    $0x1,%dil
    7582:	75 25                	jne    75a9 <f12+0x2e9>
    7584:	48 8d 3c 32          	lea    (%rdx,%rsi,1),%rdi
    7588:	8b 54 32 20          	mov    0x20(%rdx,%rsi,1),%edx
    758c:	48 0f af ca          	imul   %rdx,%rcx
    7590:	48 c1 e9 20          	shr    $0x20,%rcx
    7594:	4c 8d 34 39          	lea    (%rcx,%rdi,1),%r14
    7598:	49 81 c6 28 02 00 00 	add    $0x228,%r14
    759f:	41 80 3e ff          	cmpb   $0xff,(%r14)
    75a3:	74 09                	je     75ae <f12+0x2ee>
    75a5:	41 c6 06 01          	movb   $0x1,(%r14)
    75a9:	e9 fd fd ff ff       	jmp    73ab <f12+0xeb>
    75ae:	4c 89 f7             	mov    %r14,%rdi
    75b1:	49 89 c7             	mov    %rax,%r15
    75b4:	e8 67 ed ff ff       	call   6320 <fwp_rc_forget_slot>
    75b9:	4c 89 f8             	mov    %r15,%rax
    75bc:	eb e7                	jmp    75a5 <f12+0x2e5>
    75be:	49 89 c6             	mov    %rax,%r14
    75c1:	e8 3a 00 00 00       	call   7600 <fwp_rc_wide_dup>
    75c6:	4c 89 f0             	mov    %r14,%rax
    75c9:	e9 61 ff ff ff       	jmp    752f <f12+0x26f>
    75ce:	e8 1d ed ff ff       	call   62f0 <fwp_flush>
    75d3:	48 8b 05 06 aa 00 00 	mov    0xaa06(%rip),%rax        # 11fe0 <stderr@GLIBC_2.2.5>
    75da:	48 8b 38             	mov    (%rax),%rdi
    75dd:	48 8d 35 49 7e 00 00 	lea    0x7e49(%rip),%rsi        # f42d <fwp_segv.msg+0x1ed>
    75e4:	48 8d 15 93 7f 00 00 	lea    0x7f93(%rip),%rdx        # f57e <fwp_segv.msg+0x33e>
    75eb:	31 c0                	xor    %eax,%eax
    75ed:	e8 be ab ff ff       	call   21b0 <fprintf@plt>
    75f2:	bf 65 00 00 00       	mov    $0x65,%edi
    75f7:	e8 94 ac ff ff       	call   2290 <exit@plt>
    75fc:	0f 1f 40 00          	nopl   0x0(%rax)

0000000000007600 <fwp_rc_wide_dup>:
    7600:	41 56                	push   %r14
    7602:	53                   	push   %rbx
    7603:	50                   	push   %rax
    7604:	48 89 fb             	mov    %rdi,%rbx
    7607:	48 89 f8             	mov    %rdi,%rax
    760a:	48 c1 e8 11          	shr    $0x11,%rax
    760e:	31 d8                	xor    %ebx,%eax
    7610:	89 c1                	mov    %eax,%ecx
    7612:	c1 e9 09             	shr    $0x9,%ecx
    7615:	31 c1                	xor    %eax,%ecx
    7617:	0f b6 c1             	movzbl %cl,%eax
    761a:	48 8d 0d 5f ab 00 00 	lea    0xab5f(%rip),%rcx        # 12180 <fwp_gc>
    7621:	4c 8d 34 c1          	lea    (%rcx,%rax,8),%r14
    7625:	49 81 c6 18 12 00 00 	add    $0x1218,%r14
    762c:	48 8b 84 c1 18 12 00 	mov    0x1218(%rcx,%rax,8),%rax
    7633:	00 
    7634:	48 85 c0             	test   %rax,%rax
    7637:	74 1a                	je     7653 <fwp_rc_wide_dup+0x53>
    7639:	48 39 18             	cmp    %rbx,(%rax)
    763c:	74 22                	je     7660 <fwp_rc_wide_dup+0x60>
    763e:	66 90                	xchg   %ax,%ax
    7640:	49 89 c6             	mov    %rax,%r14
    7643:	48 8b 40 10          	mov    0x10(%rax),%rax
    7647:	48 85 c0             	test   %rax,%rax
    764a:	74 0e                	je     765a <fwp_rc_wide_dup+0x5a>
    764c:	48 39 18             	cmp    %rbx,(%rax)
    764f:	75 ef                	jne    7640 <fwp_rc_wide_dup+0x40>
    7651:	eb 09                	jmp    765c <fwp_rc_wide_dup+0x5c>
    7653:	80 3b fe             	cmpb   $0xfe,(%rbx)
    7656:	74 16                	je     766e <fwp_rc_wide_dup+0x6e>
    7658:	eb 6d                	jmp    76c7 <fwp_rc_wide_dup+0xc7>
    765a:	31 c0                	xor    %eax,%eax
    765c:	49 83 c6 10          	add    $0x10,%r14
    7660:	80 3b fe             	cmpb   $0xfe,(%rbx)
    7663:	75 41                	jne    76a6 <fwp_rc_wide_dup+0xa6>
    7665:	48 85 c0             	test   %rax,%rax
    7668:	0f 85 a2 00 00 00    	jne    7710 <fwp_rc_wide_dup+0x110>
    766e:	bf 18 00 00 00       	mov    $0x18,%edi
    7673:	e8 78 ab ff ff       	call   21f0 <malloc@plt>
    7678:	48 85 c0             	test   %rax,%rax
    767b:	74 69                	je     76e6 <fwp_rc_wide_dup+0xe6>
    767d:	48 89 18             	mov    %rbx,(%rax)
    7680:	48 c7 40 08 ff 00 00 	movq   $0xff,0x8(%rax)
    7687:	00 
    7688:	48 c7 40 10 00 00 00 	movq   $0x0,0x10(%rax)
    768f:	00 
    7690:	49 89 06             	mov    %rax,(%r14)
    7693:	c6 03 ff             	movb   $0xff,(%rbx)
    7696:	48 8d 05 fb c4 00 00 	lea    0xc4fb(%rip),%rax        # 13b98 <fwp_gc+0x1a18>
    769d:	48 8b 0d f4 c4 00 00 	mov    0xc4f4(%rip),%rcx        # 13b98 <fwp_gc+0x1a18>
    76a4:	eb 13                	jmp    76b9 <fwp_rc_wide_dup+0xb9>
    76a6:	48 85 c0             	test   %rax,%rax
    76a9:	74 1c                	je     76c7 <fwp_rc_wide_dup+0xc7>
    76ab:	48 8b 48 08          	mov    0x8(%rax),%rcx
    76af:	48 83 f9 ff          	cmp    $0xffffffffffffffff,%rcx
    76b3:	74 7a                	je     772f <fwp_rc_wide_dup+0x12f>
    76b5:	48 83 c0 08          	add    $0x8,%rax
    76b9:	48 ff c1             	inc    %rcx
    76bc:	48 89 08             	mov    %rcx,(%rax)
    76bf:	48 83 c4 08          	add    $0x8,%rsp
    76c3:	5b                   	pop    %rbx
    76c4:	41 5e                	pop    %r14
    76c6:	c3                   	ret
    76c7:	e8 24 ec ff ff       	call   62f0 <fwp_flush>
    76cc:	48 8b 05 0d a9 00 00 	mov    0xa90d(%rip),%rax        # 11fe0 <stderr@GLIBC_2.2.5>
    76d3:	48 8b 38             	mov    (%rax),%rdi
    76d6:	48 8d 35 50 7d 00 00 	lea    0x7d50(%rip),%rsi        # f42d <fwp_segv.msg+0x1ed>
    76dd:	48 8d 15 58 7d 00 00 	lea    0x7d58(%rip),%rdx        # f43c <fwp_segv.msg+0x1fc>
    76e4:	eb 66                	jmp    774c <fwp_rc_wide_dup+0x14c>
    76e6:	48 8b 05 f3 a8 00 00 	mov    0xa8f3(%rip),%rax        # 11fe0 <stderr@GLIBC_2.2.5>
    76ed:	48 8b 08             	mov    (%rax),%rcx
    76f0:	48 8d 3d 42 7e 00 00 	lea    0x7e42(%rip),%rdi        # f539 <fwp_segv.msg+0x2f9>
    76f7:	be 13 00 00 00       	mov    $0x13,%esi
    76fc:	ba 01 00 00 00       	mov    $0x1,%edx
    7701:	e8 9a ab ff ff       	call   22a0 <fwrite@plt>
    7706:	bf 66 00 00 00       	mov    $0x66,%edi
    770b:	e8 80 ab ff ff       	call   2290 <exit@plt>
    7710:	e8 db eb ff ff       	call   62f0 <fwp_flush>
    7715:	48 8b 05 c4 a8 00 00 	mov    0xa8c4(%rip),%rax        # 11fe0 <stderr@GLIBC_2.2.5>
    771c:	48 8b 38             	mov    (%rax),%rdi
    771f:	48 8d 35 07 7d 00 00 	lea    0x7d07(%rip),%rsi        # f42d <fwp_segv.msg+0x1ed>
    7726:	48 8d 15 7d 7e 00 00 	lea    0x7e7d(%rip),%rdx        # f5aa <fwp_segv.msg+0x36a>
    772d:	eb 1d                	jmp    774c <fwp_rc_wide_dup+0x14c>
    772f:	e8 bc eb ff ff       	call   62f0 <fwp_flush>
    7734:	48 8b 05 a5 a8 00 00 	mov    0xa8a5(%rip),%rax        # 11fe0 <stderr@GLIBC_2.2.5>
    773b:	48 8b 38             	mov    (%rax),%rdi
    773e:	48 8d 35 e8 7c 00 00 	lea    0x7ce8(%rip),%rsi        # f42d <fwp_segv.msg+0x1ed>
    7745:	48 8d 15 83 7e 00 00 	lea    0x7e83(%rip),%rdx        # f5cf <fwp_segv.msg+0x38f>
    774c:	31 c0                	xor    %eax,%eax
    774e:	e8 5d aa ff ff       	call   21b0 <fprintf@plt>
    7753:	bf 65 00 00 00       	mov    $0x65,%edi
    7758:	e8 33 ab ff ff       	call   2290 <exit@plt>
    775d:	0f 1f 00             	nopl   (%rax)

0000000000007760 <fwp_show>:
    7760:	41 57                	push   %r15
    7762:	41 56                	push   %r14
    7764:	41 54                	push   %r12
    7766:	53                   	push   %rbx
    7767:	48 83 ec 18          	sub    $0x18,%rsp
    776b:	48 89 f2             	mov    %rsi,%rdx
    776e:	48 89 fe             	mov    %rdi,%rsi
    7771:	0f 57 c0             	xorps  %xmm0,%xmm0
    7774:	0f 29 04 24          	movaps %xmm0,(%rsp)
    7778:	48 c7 44 24 10 00 00 	movq   $0x0,0x10(%rsp)
    777f:	00 00 
    7781:	48 89 e7             	mov    %rsp,%rdi
    7784:	b9 01 00 00 00       	mov    $0x1,%ecx
    7789:	e8 e2 00 00 00       	call   7870 <fwp_write>
    778e:	4c 8b 24 24          	mov    (%rsp),%r12
    7792:	48 8b 5c 24 08       	mov    0x8(%rsp),%rbx
    7797:	48 8d 53 09          	lea    0x9(%rbx),%rdx
    779b:	48 81 fa 00 40 00 00 	cmp    $0x4000,%rdx
    77a2:	77 61                	ja     7805 <fwp_show+0xa5>
    77a4:	48 8d 4b 18          	lea    0x18(%rbx),%rcx
    77a8:	48 c1 e9 04          	shr    $0x4,%rcx
    77ac:	48 8d 05 cd a9 00 00 	lea    0xa9cd(%rip),%rax        # 12180 <fwp_gc>
    77b3:	0f b6 b4 01 e8 0b 00 	movzbl 0xbe8(%rcx,%rax,1),%esi
    77ba:	00 
    77bb:	8b 8c b0 48 0b 00 00 	mov    0xb48(%rax,%rsi,4),%ecx
    77c2:	48 29 0d b7 a9 00 00 	sub    %rcx,0xa9b7(%rip)        # 12180 <fwp_gc>
    77c9:	78 3a                	js     7805 <fwp_show+0xa5>
    77cb:	48 8d 34 76          	lea    (%rsi,%rsi,2),%rsi
    77cf:	48 8d 3c f0          	lea    (%rax,%rsi,8),%rdi
    77d3:	48 81 c7 c8 03 00 00 	add    $0x3c8,%rdi
    77da:	4c 8b 37             	mov    (%rdi),%r14
    77dd:	4d 85 f6             	test   %r14,%r14
    77e0:	74 0b                	je     77ed <fwp_show+0x8d>
    77e2:	49 8b 06             	mov    (%r14),%rax
    77e5:	48 f7 d0             	not    %rax
    77e8:	48 89 07             	mov    %rax,(%rdi)
    77eb:	eb 3a                	jmp    7827 <fwp_show+0xc7>
    77ed:	4c 8b b4 f0 d0 03 00 	mov    0x3d0(%rax,%rsi,8),%r14
    77f4:	00 
    77f5:	48 8b bc f0 d8 03 00 	mov    0x3d8(%rax,%rsi,8),%rdi
    77fc:	00 
    77fd:	4c 29 f7             	sub    %r14,%rdi
    7800:	48 39 cf             	cmp    %rcx,%rdi
    7803:	73 12                	jae    7817 <fwp_show+0xb7>
    7805:	48 89 d7             	mov    %rdx,%rdi
    7808:	be 01 00 00 00       	mov    $0x1,%esi
    780d:	e8 2e ef ff ff       	call   6740 <fwp_gc_alloc_slow>
    7812:	49 89 c6             	mov    %rax,%r14
    7815:	eb 1a                	jmp    7831 <fwp_show+0xd1>
    7817:	48 8d 04 f0          	lea    (%rax,%rsi,8),%rax
    781b:	48 05 d0 03 00 00    	add    $0x3d0,%rax
    7821:	4c 01 f1             	add    %r14,%rcx
    7824:	48 89 08             	mov    %rcx,(%rax)
    7827:	4c 89 f7             	mov    %r14,%rdi
    782a:	31 f6                	xor    %esi,%esi
    782c:	e8 ff a8 ff ff       	call   2130 <memset@plt>
    7831:	4d 85 e4             	test   %r12,%r12
    7834:	4c 8d 3d f4 7e 00 00 	lea    0x7ef4(%rip),%r15        # f72f <fwp_segv.msg+0x4ef>
    783b:	4d 0f 45 fc          	cmovne %r12,%r15
    783f:	49 89 1e             	mov    %rbx,(%r14)
    7842:	49 8d 7e 08          	lea    0x8(%r14),%rdi
    7846:	4c 89 fe             	mov    %r15,%rsi
    7849:	48 89 da             	mov    %rbx,%rdx
    784c:	e8 8f a9 ff ff       	call   21e0 <memcpy@plt>
    7851:	41 c6 44 1e 08 00    	movb   $0x0,0x8(%r14,%rbx,1)
    7857:	48 8b 3c 24          	mov    (%rsp),%rdi
    785b:	e8 f0 a7 ff ff       	call   2050 <free@plt>
    7860:	4c 89 f0             	mov    %r14,%rax
    7863:	48 83 c4 18          	add    $0x18,%rsp
    7867:	5b                   	pop    %rbx
    7868:	41 5c                	pop    %r12
    786a:	41 5e                	pop    %r14
    786c:	41 5f                	pop    %r15
    786e:	c3                   	ret
    786f:	90                   	nop

0000000000007870 <fwp_write>:
    7870:	55                   	push   %rbp
    7871:	41 57                	push   %r15
    7873:	41 56                	push   %r14
    7875:	41 55                	push   %r13
    7877:	41 54                	push   %r12
    7879:	53                   	push   %rbx
    787a:	48 81 ec 78 02 00 00 	sub    $0x278,%rsp
    7881:	8b 02                	mov    (%rdx),%eax
    7883:	48 83 f8 19          	cmp    $0x19,%rax
    7887:	0f 87 26 12 00 00    	ja     8ab3 <fwp_write+0x1243>
    788d:	49 89 d7             	mov    %rdx,%r15
    7890:	49 89 f6             	mov    %rsi,%r14
    7893:	48 89 fd             	mov    %rdi,%rbp
    7896:	48 8d 15 83 78 00 00 	lea    0x7883(%rip),%rdx        # f120 <_IO_stdin_used+0x120>
    789d:	48 63 34 82          	movslq (%rdx,%rax,4),%rsi
    78a1:	48 01 d6             	add    %rdx,%rsi
    78a4:	48 89 3c 24          	mov    %rdi,(%rsp)
    78a8:	ff e6                	jmp    *%rsi
    78aa:	48 8d 15 37 7d 00 00 	lea    0x7d37(%rip),%rdx        # f5e8 <fwp_segv.msg+0x3a8>
    78b1:	eb 07                	jmp    78ba <fwp_write+0x4a>
    78b3:	48 8d 15 33 7d 00 00 	lea    0x7d33(%rip),%rdx        # f5ed <fwp_segv.msg+0x3ad>
    78ba:	4c 8d 7c 24 70       	lea    0x70(%rsp),%r15
    78bf:	be 00 02 00 00       	mov    $0x200,%esi
    78c4:	4c 89 ff             	mov    %r15,%rdi
    78c7:	4c 89 f1             	mov    %r14,%rcx
    78ca:	31 c0                	xor    %eax,%eax
    78cc:	e8 3f a8 ff ff       	call   2110 <snprintf@plt>
    78d1:	4c 89 ff             	mov    %r15,%rdi
    78d4:	e8 07 a8 ff ff       	call   20e0 <strlen@plt>
    78d9:	48 89 ef             	mov    %rbp,%rdi
    78dc:	4c 89 fe             	mov    %r15,%rsi
    78df:	e9 c7 11 00 00       	jmp    8aab <fwp_write+0x123b>
    78e4:	83 f8 13             	cmp    $0x13,%eax
    78e7:	48 8d 05 39 7d 00 00 	lea    0x7d39(%rip),%rax        # f627 <fwp_segv.msg+0x3e7>
    78ee:	48 8d 35 37 7d 00 00 	lea    0x7d37(%rip),%rsi        # f62c <fwp_segv.msg+0x3ec>
    78f5:	48 0f 44 f0          	cmove  %rax,%rsi
    78f9:	ba 04 00 00 00       	mov    $0x4,%edx
    78fe:	48 89 ef             	mov    %rbp,%rdi
    7901:	e8 4a 13 00 00       	call   8c50 <buf_put>
    7906:	49 83 3e 00          	cmpq   $0x0,(%r14)
    790a:	0f 84 c3 00 00 00    	je     79d3 <fwp_write+0x163>
    7910:	49 8b 57 38          	mov    0x38(%r15),%rdx
    7914:	49 8b 76 08          	mov    0x8(%r14),%rsi
    7918:	48 8b 1c 24          	mov    (%rsp),%rbx
    791c:	48 89 df             	mov    %rbx,%rdi
    791f:	31 c9                	xor    %ecx,%ecx
    7921:	e8 4a ff ff ff       	call   7870 <fwp_write>
    7926:	41 83 3f 12          	cmpl   $0x12,(%r15)
    792a:	75 26                	jne    7952 <fwp_write+0xe2>
    792c:	48 8d 35 fe 7c 00 00 	lea    0x7cfe(%rip),%rsi        # f631 <fwp_segv.msg+0x3f1>
    7933:	ba 02 00 00 00       	mov    $0x2,%edx
    7938:	48 89 df             	mov    %rbx,%rdi
    793b:	e8 10 13 00 00       	call   8c50 <buf_put>
    7940:	49 8b 76 10          	mov    0x10(%r14),%rsi
    7944:	49 8b 57 40          	mov    0x40(%r15),%rdx
    7948:	48 89 df             	mov    %rbx,%rdi
    794b:	31 c9                	xor    %ecx,%ecx
    794d:	e8 1e ff ff ff       	call   7870 <fwp_write>
    7952:	49 83 3e 02          	cmpq   $0x2,(%r14)
    7956:	72 7b                	jb     79d3 <fwp_write+0x163>
    7958:	49 8d 5e 20          	lea    0x20(%r14),%rbx
    795c:	bd 01 00 00 00       	mov    $0x1,%ebp
    7961:	4c 8d 25 b2 7c 00 00 	lea    0x7cb2(%rip),%r12        # f61a <fwp_segv.msg+0x3da>
    7968:	eb 12                	jmp    797c <fwp_write+0x10c>
    796a:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)
    7970:	48 ff c5             	inc    %rbp
    7973:	48 83 c3 10          	add    $0x10,%rbx
    7977:	49 3b 2e             	cmp    (%r14),%rbp
    797a:	73 57                	jae    79d3 <fwp_write+0x163>
    797c:	ba 02 00 00 00       	mov    $0x2,%edx
    7981:	4c 8b 2c 24          	mov    (%rsp),%r13
    7985:	4c 89 ef             	mov    %r13,%rdi
    7988:	4c 89 e6             	mov    %r12,%rsi
    798b:	e8 c0 12 00 00       	call   8c50 <buf_put>
    7990:	48 8b 73 f8          	mov    -0x8(%rbx),%rsi
    7994:	49 8b 57 38          	mov    0x38(%r15),%rdx
    7998:	4c 89 ef             	mov    %r13,%rdi
    799b:	31 c9                	xor    %ecx,%ecx
    799d:	e8 ce fe ff ff       	call   7870 <fwp_write>
    79a2:	41 83 3f 12          	cmpl   $0x12,(%r15)
    79a6:	75 c8                	jne    7970 <fwp_write+0x100>
    79a8:	ba 02 00 00 00       	mov    $0x2,%edx
    79ad:	4c 8b 2c 24          	mov    (%rsp),%r13
    79b1:	4c 89 ef             	mov    %r13,%rdi
    79b4:	48 8d 35 76 7c 00 00 	lea    0x7c76(%rip),%rsi        # f631 <fwp_segv.msg+0x3f1>
    79bb:	e8 90 12 00 00       	call   8c50 <buf_put>
    79c0:	48 8b 33             	mov    (%rbx),%rsi
    79c3:	49 8b 57 40          	mov    0x40(%r15),%rdx
    79c7:	4c 89 ef             	mov    %r13,%rdi
    79ca:	31 c9                	xor    %ecx,%ecx
    79cc:	e8 9f fe ff ff       	call   7870 <fwp_write>
    79d1:	eb 9d                	jmp    7970 <fwp_write+0x100>
    79d3:	c6 44 24 70 7d       	movb   $0x7d,0x70(%rsp)
    79d8:	48 8d 74 24 70       	lea    0x70(%rsp),%rsi
    79dd:	ba 01 00 00 00       	mov    $0x1,%edx
    79e2:	48 8b 3c 24          	mov    (%rsp),%rdi
    79e6:	e9 c3 10 00 00       	jmp    8aae <fwp_write+0x123e>
    79eb:	4d 8b 67 08          	mov    0x8(%r15),%r12
    79ef:	4d 85 e4             	test   %r12,%r12
    79f2:	0f 84 af 06 00 00    	je     80a7 <fwp_write+0x837>
    79f8:	48 8d 35 35 7c 00 00 	lea    0x7c35(%rip),%rsi        # f634 <fwp_segv.msg+0x3f4>
    79ff:	4c 89 e7             	mov    %r12,%rdi
    7a02:	e8 79 a7 ff ff       	call   2180 <strcmp@plt>
    7a07:	85 c0                	test   %eax,%eax
    7a09:	0f 84 36 0b 00 00    	je     8545 <fwp_write+0xcd5>
    7a0f:	4d 8d 6f 10          	lea    0x10(%r15),%r13
    7a13:	4c 89 e7             	mov    %r12,%rdi
    7a16:	e8 c5 a6 ff ff       	call   20e0 <strlen@plt>
    7a1b:	48 89 ef             	mov    %rbp,%rdi
    7a1e:	4c 89 e6             	mov    %r12,%rsi
    7a21:	48 89 c2             	mov    %rax,%rdx
    7a24:	e8 27 12 00 00       	call   8c50 <buf_put>
    7a29:	c6 44 24 70 20       	movb   $0x20,0x70(%rsp)
    7a2e:	48 8d 74 24 70       	lea    0x70(%rsp),%rsi
    7a33:	ba 01 00 00 00       	mov    $0x1,%edx
    7a38:	48 89 ef             	mov    %rbp,%rdi
    7a3b:	e8 10 12 00 00       	call   8c50 <buf_put>
    7a40:	31 db                	xor    %ebx,%ebx
    7a42:	e9 7f 06 00 00       	jmp    80c6 <fwp_write+0x856>
    7a47:	49 81 fe ff 0f 00 00 	cmp    $0xfff,%r14
    7a4e:	0f 87 00 05 00 00    	ja     7f54 <fwp_write+0x6e4>
    7a54:	44 89 f0             	mov    %r14d,%eax
    7a57:	e9 fb 04 00 00       	jmp    7f57 <fwp_write+0x6e7>
    7a5c:	66 49 0f 6e ce       	movq   %r14,%xmm1
    7a61:	66 0f 2e c9          	ucomisd %xmm1,%xmm1
    7a65:	0f 8a d2 11 00 00    	jp     8c3d <fwp_write+0x13cd>
    7a6b:	66 0f 28 05 5d 76 00 	movapd 0x765d(%rip),%xmm0        # f0d0 <_IO_stdin_used+0xd0>
    7a72:	00 
    7a73:	66 0f 54 c1          	andpd  %xmm1,%xmm0
    7a77:	66 0f 2e 05 a1 75 00 	ucomisd 0x75a1(%rip),%xmm0        # f020 <_IO_stdin_used+0x20>
    7a7e:	00 
    7a7f:	0f 82 66 08 00 00    	jb     82eb <fwp_write+0xa7b>
    7a85:	66 0f 57 c0          	xorpd  %xmm0,%xmm0
    7a89:	66 0f 2e c8          	ucomisd %xmm0,%xmm1
    7a8d:	e9 55 04 00 00       	jmp    7ee7 <fwp_write+0x677>
    7a92:	c6 44 24 70 3c       	movb   $0x3c,0x70(%rsp)
    7a97:	48 8d 74 24 70       	lea    0x70(%rsp),%rsi
    7a9c:	ba 01 00 00 00       	mov    $0x1,%edx
    7aa1:	48 89 ef             	mov    %rbp,%rdi
    7aa4:	e8 a7 11 00 00       	call   8c50 <buf_put>
    7aa9:	4d 8b 77 08          	mov    0x8(%r15),%r14
    7aad:	e9 82 04 00 00       	jmp    7f34 <fwp_write+0x6c4>
    7ab2:	48 8d 35 4a 7b 00 00 	lea    0x7b4a(%rip),%rsi        # f603 <fwp_segv.msg+0x3c3>
    7ab9:	ba 08 00 00 00       	mov    $0x8,%edx
    7abe:	48 89 ef             	mov    %rbp,%rdi
    7ac1:	e9 5c 0d 00 00       	jmp    8822 <fwp_write+0xfb2>
    7ac6:	49 8d 76 08          	lea    0x8(%r14),%rsi
    7aca:	49 8b 16             	mov    (%r14),%rdx
    7acd:	85 c9                	test   %ecx,%ecx
    7acf:	0f 84 13 07 00 00    	je     81e8 <fwp_write+0x978>
    7ad5:	48 89 ef             	mov    %rbp,%rdi
    7ad8:	e9 45 0d 00 00       	jmp    8822 <fwp_write+0xfb2>
    7add:	4d 8b 0e             	mov    (%r14),%r9
    7ae0:	4d 8b 46 08          	mov    0x8(%r14),%r8
    7ae4:	4c 89 c8             	mov    %r9,%rax
    7ae7:	4c 09 c0             	or     %r8,%rax
    7aea:	0f 84 11 07 00 00    	je     8201 <fwp_write+0x991>
    7af0:	31 ff                	xor    %edi,%edi
    7af2:	49 ba cd cc cc cc cc 	movabs $0xcccccccccccccccd,%r10
    7af9:	cc cc cc 
    7afc:	49 bb cc cc cc cc cc 	movabs $0xcccccccccccccccc,%r11
    7b03:	cc cc cc 
    7b06:	4c 89 c3             	mov    %r8,%rbx
    7b09:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)
    7b10:	4c 89 c1             	mov    %r8,%rcx
    7b13:	4c 0f a4 c9 3f       	shld   $0x3f,%r9,%rcx
    7b18:	48 d1 eb             	shr    $1,%rbx
    7b1b:	48 89 ce             	mov    %rcx,%rsi
    7b1e:	48 01 de             	add    %rbx,%rsi
    7b21:	48 83 d6 00          	adc    $0x0,%rsi
    7b25:	48 89 f0             	mov    %rsi,%rax
    7b28:	49 f7 e2             	mul    %r10
    7b2b:	48 c1 ea 02          	shr    $0x2,%rdx
    7b2f:	48 8d 04 92          	lea    (%rdx,%rdx,4),%rax
    7b33:	48 29 c6             	sub    %rax,%rsi
    7b36:	48 29 f1             	sub    %rsi,%rcx
    7b39:	48 83 db 00          	sbb    $0x0,%rbx
    7b3d:	48 89 ce             	mov    %rcx,%rsi
    7b40:	49 0f af f3          	imul   %r11,%rsi
    7b44:	48 89 c8             	mov    %rcx,%rax
    7b47:	49 f7 e2             	mul    %r10
    7b4a:	48 01 f2             	add    %rsi,%rdx
    7b4d:	49 0f af da          	imul   %r10,%rbx
    7b51:	48 01 d3             	add    %rdx,%rbx
    7b54:	48 89 c1             	mov    %rax,%rcx
    7b57:	48 01 c1             	add    %rax,%rcx
    7b5a:	48 8d 0c 89          	lea    (%rcx,%rcx,4),%rcx
    7b5e:	44 89 ca             	mov    %r9d,%edx
    7b61:	29 ca                	sub    %ecx,%edx
    7b63:	80 ca 30             	or     $0x30,%dl
    7b66:	88 54 3c 20          	mov    %dl,0x20(%rsp,%rdi,1)
    7b6a:	48 ff c7             	inc    %rdi
    7b6d:	49 83 f9 0a          	cmp    $0xa,%r9
    7b71:	49 83 d8 00          	sbb    $0x0,%r8
    7b75:	49 89 c1             	mov    %rax,%r9
    7b78:	49 89 d8             	mov    %rbx,%r8
    7b7b:	73 93                	jae    7b10 <fwp_write+0x2a0>
    7b7d:	85 ff                	test   %edi,%edi
    7b7f:	0f 8f 86 06 00 00    	jg     820b <fwp_write+0x99b>
    7b85:	e9 ab 00 00 00       	jmp    7c35 <fwp_write+0x3c5>
    7b8a:	4d 8b 06             	mov    (%r14),%r8
    7b8d:	4d 8b 4e 08          	mov    0x8(%r14),%r9
    7b91:	4d 85 c9             	test   %r9,%r9
    7b94:	0f 88 93 06 00 00    	js     822d <fwp_write+0x9bd>
    7b9a:	4c 89 c0             	mov    %r8,%rax
    7b9d:	4c 09 c8             	or     %r9,%rax
    7ba0:	0f 84 bc 09 00 00    	je     8562 <fwp_write+0xcf2>
    7ba6:	31 ff                	xor    %edi,%edi
    7ba8:	49 ba cd cc cc cc cc 	movabs $0xcccccccccccccccd,%r10
    7baf:	cc cc cc 
    7bb2:	49 bb cc cc cc cc cc 	movabs $0xcccccccccccccccc,%r11
    7bb9:	cc cc cc 
    7bbc:	4c 89 cb             	mov    %r9,%rbx
    7bbf:	90                   	nop
    7bc0:	4c 89 c9             	mov    %r9,%rcx
    7bc3:	4c 0f a4 c1 3f       	shld   $0x3f,%r8,%rcx
    7bc8:	48 d1 eb             	shr    $1,%rbx
    7bcb:	48 89 ce             	mov    %rcx,%rsi
    7bce:	48 01 de             	add    %rbx,%rsi
    7bd1:	48 83 d6 00          	adc    $0x0,%rsi
    7bd5:	48 89 f0             	mov    %rsi,%rax
    7bd8:	49 f7 e2             	mul    %r10
    7bdb:	48 c1 ea 02          	shr    $0x2,%rdx
    7bdf:	48 8d 04 92          	lea    (%rdx,%rdx,4),%rax
    7be3:	48 29 c6             	sub    %rax,%rsi
    7be6:	48 29 f1             	sub    %rsi,%rcx
    7be9:	48 83 db 00          	sbb    $0x0,%rbx
    7bed:	48 89 ce             	mov    %rcx,%rsi
    7bf0:	49 0f af f3          	imul   %r11,%rsi
    7bf4:	48 89 c8             	mov    %rcx,%rax
    7bf7:	49 f7 e2             	mul    %r10
    7bfa:	48 01 f2             	add    %rsi,%rdx
    7bfd:	49 0f af da          	imul   %r10,%rbx
    7c01:	48 01 d3             	add    %rdx,%rbx
    7c04:	48 89 c1             	mov    %rax,%rcx
    7c07:	48 01 c1             	add    %rax,%rcx
    7c0a:	48 8d 0c 89          	lea    (%rcx,%rcx,4),%rcx
    7c0e:	44 89 c2             	mov    %r8d,%edx
    7c11:	29 ca                	sub    %ecx,%edx
    7c13:	80 ca 30             	or     $0x30,%dl
    7c16:	88 54 3c 20          	mov    %dl,0x20(%rsp,%rdi,1)
    7c1a:	48 ff c7             	inc    %rdi
    7c1d:	49 83 f8 0a          	cmp    $0xa,%r8
    7c21:	49 83 d9 00          	sbb    $0x0,%r9
    7c25:	49 89 c0             	mov    %rax,%r8
    7c28:	49 89 d9             	mov    %rbx,%r9
    7c2b:	73 93                	jae    7bc0 <fwp_write+0x350>
    7c2d:	85 ff                	test   %edi,%edi
    7c2f:	0f 8f 37 09 00 00    	jg     856c <fwp_write+0xcfc>
    7c35:	31 c0                	xor    %eax,%eax
    7c37:	e9 57 0e 00 00       	jmp    8a93 <fwp_write+0x1223>
    7c3c:	c6 44 24 70 5b       	movb   $0x5b,0x70(%rsp)
    7c41:	48 8d 74 24 70       	lea    0x70(%rsp),%rsi
    7c46:	ba 01 00 00 00       	mov    $0x1,%edx
    7c4b:	48 89 ef             	mov    %rbp,%rdi
    7c4e:	e8 fd 0f 00 00       	call   8c50 <buf_put>
    7c53:	4d 85 f6             	test   %r14,%r14
    7c56:	0f 84 e6 0c 00 00    	je     8942 <fwp_write+0x10d2>
    7c5c:	49 8b 57 38          	mov    0x38(%r15),%rdx
    7c60:	49 8b 76 08          	mov    0x8(%r14),%rsi
    7c64:	48 89 ef             	mov    %rbp,%rdi
    7c67:	31 c9                	xor    %ecx,%ecx
    7c69:	e8 02 fc ff ff       	call   7870 <fwp_write>
    7c6e:	49 8b 5e 10          	mov    0x10(%r14),%rbx
    7c72:	48 85 db             	test   %rbx,%rbx
    7c75:	0f 84 c7 0c 00 00    	je     8942 <fwp_write+0x10d2>
    7c7b:	4c 8d 35 98 79 00 00 	lea    0x7998(%rip),%r14        # f61a <fwp_segv.msg+0x3da>
    7c82:	66 66 66 66 66 2e 0f 	data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    7c89:	1f 84 00 00 00 00 00 
    7c90:	ba 02 00 00 00       	mov    $0x2,%edx
    7c95:	48 89 ef             	mov    %rbp,%rdi
    7c98:	4c 89 f6             	mov    %r14,%rsi
    7c9b:	e8 b0 0f 00 00       	call   8c50 <buf_put>
    7ca0:	48 8b 73 08          	mov    0x8(%rbx),%rsi
    7ca4:	49 8b 57 38          	mov    0x38(%r15),%rdx
    7ca8:	48 89 ef             	mov    %rbp,%rdi
    7cab:	31 c9                	xor    %ecx,%ecx
    7cad:	e8 be fb ff ff       	call   7870 <fwp_write>
    7cb2:	48 8b 5b 10          	mov    0x10(%rbx),%rbx
    7cb6:	48 85 db             	test   %rbx,%rbx
    7cb9:	75 d5                	jne    7c90 <fwp_write+0x420>
    7cbb:	e9 82 0c 00 00       	jmp    8942 <fwp_write+0x10d2>
    7cc0:	4d 63 67 48          	movslq 0x48(%r15),%r12
    7cc4:	44 89 e3             	mov    %r12d,%ebx
    7cc7:	49 8d 54 24 03       	lea    0x3(%r12),%rdx
    7ccc:	48 81 fa 00 40 00 00 	cmp    $0x4000,%rdx
    7cd3:	0f 87 57 08 00 00    	ja     8530 <fwp_write+0xcc0>
    7cd9:	49 8d 4c 24 12       	lea    0x12(%r12),%rcx
    7cde:	48 c1 e9 04          	shr    $0x4,%rcx
    7ce2:	48 8d 05 97 a4 00 00 	lea    0xa497(%rip),%rax        # 12180 <fwp_gc>
    7ce9:	0f b6 b4 01 e8 0b 00 	movzbl 0xbe8(%rcx,%rax,1),%esi
    7cf0:	00 
    7cf1:	8b 8c b0 48 0b 00 00 	mov    0xb48(%rax,%rsi,4),%ecx
    7cf8:	48 29 0d 81 a4 00 00 	sub    %rcx,0xa481(%rip)        # 12180 <fwp_gc>
    7cff:	0f 88 2b 08 00 00    	js     8530 <fwp_write+0xcc0>
    7d05:	48 8d 34 76          	lea    (%rsi,%rsi,2),%rsi
    7d09:	48 8d 3c f0          	lea    (%rax,%rsi,8),%rdi
    7d0d:	48 81 c7 c8 03 00 00 	add    $0x3c8,%rdi
    7d14:	4c 8b 3f             	mov    (%rdi),%r15
    7d17:	4d 85 ff             	test   %r15,%r15
    7d1a:	0f 84 f4 07 00 00    	je     8514 <fwp_write+0xca4>
    7d20:	49 8b 07             	mov    (%r15),%rax
    7d23:	48 f7 d0             	not    %rax
    7d26:	48 89 07             	mov    %rax,(%rdi)
    7d29:	e9 2d 0a 00 00       	jmp    875b <fwp_write+0xeeb>
    7d2e:	49 83 fe ff          	cmp    $0xffffffffffffffff,%r14
    7d32:	48 8d 05 bc 78 00 00 	lea    0x78bc(%rip),%rax        # f5f5 <fwp_segv.msg+0x3b5>
    7d39:	48 8d 0d 22 79 00 00 	lea    0x7922(%rip),%rcx        # f662 <fwp_segv.msg+0x422>
    7d40:	48 0f 44 c8          	cmove  %rax,%rcx
    7d44:	49 83 fe 01          	cmp    $0x1,%r14
    7d48:	4c 8d 35 a3 78 00 00 	lea    0x78a3(%rip),%r14        # f5f2 <fwp_segv.msg+0x3b2>
    7d4f:	4c 0f 45 f1          	cmovne %rcx,%r14
    7d53:	4c 89 f7             	mov    %r14,%rdi
    7d56:	e8 85 a3 ff ff       	call   20e0 <strlen@plt>
    7d5b:	48 89 ef             	mov    %rbp,%rdi
    7d5e:	4c 89 f6             	mov    %r14,%rsi
    7d61:	e9 b9 0a 00 00       	jmp    881f <fwp_write+0xfaf>
    7d66:	48 8d 35 b3 78 00 00 	lea    0x78b3(%rip),%rsi        # f620 <fwp_segv.msg+0x3e0>
    7d6d:	ba 06 00 00 00       	mov    $0x6,%edx
    7d72:	48 89 ef             	mov    %rbp,%rdi
    7d75:	e8 d6 0e 00 00       	call   8c50 <buf_put>
    7d7a:	49 8b 36             	mov    (%r14),%rsi
    7d7d:	48 8d 04 75 00 00 00 	lea    0x0(,%rsi,2),%rax
    7d84:	00 
    7d85:	48 85 c0             	test   %rax,%rax
    7d88:	0f 84 b4 0b 00 00    	je     8942 <fwp_write+0x10d2>
    7d8e:	49 8b 57 38          	mov    0x38(%r15),%rdx
    7d92:	b8 08 00 00 00       	mov    $0x8,%eax
    7d97:	48 85 d2             	test   %rdx,%rdx
    7d9a:	74 13                	je     7daf <fwp_write+0x53f>
    7d9c:	8b 0a                	mov    (%rdx),%ecx
    7d9e:	48 83 f9 0a          	cmp    $0xa,%rcx
    7da2:	77 0b                	ja     7daf <fwp_write+0x53f>
    7da4:	48 8d 05 0d 75 00 00 	lea    0x750d(%rip),%rax        # f2b8 <fwp_segv.msg+0x78>
    7dab:	48 8b 04 c8          	mov    (%rax,%rcx,8),%rax
    7daf:	4d 8d 6e 08          	lea    0x8(%r14),%r13
    7db3:	4c 89 e9             	mov    %r13,%rcx
    7db6:	48 85 f6             	test   %rsi,%rsi
    7db9:	79 04                	jns    7dbf <fwp_write+0x54f>
    7dbb:	49 8b 4e 10          	mov    0x10(%r14),%rcx
    7dbf:	48 83 f8 01          	cmp    $0x1,%rax
    7dc3:	0f 84 74 0a 00 00    	je     883d <fwp_write+0xfcd>
    7dc9:	48 83 f8 08          	cmp    $0x8,%rax
    7dcd:	0f 84 65 0a 00 00    	je     8838 <fwp_write+0xfc8>
    7dd3:	48 83 f8 02          	cmp    $0x2,%rax
    7dd7:	0f 85 6c 0a 00 00    	jne    8849 <fwp_write+0xfd9>
    7ddd:	83 3a 01             	cmpl   $0x1,(%rdx)
    7de0:	0f b7 01             	movzwl (%rcx),%eax
    7de3:	48 0f bf f0          	movswq %ax,%rsi
    7de7:	e9 65 0a 00 00       	jmp    8851 <fwp_write+0xfe1>
    7dec:	48 8d 35 20 78 00 00 	lea    0x7820(%rip),%rsi        # f613 <fwp_segv.msg+0x3d3>
    7df3:	ba 06 00 00 00       	mov    $0x6,%edx
    7df8:	48 89 ef             	mov    %rbp,%rdi
    7dfb:	e8 50 0e 00 00       	call   8c50 <buf_put>
    7e00:	49 83 3e 00          	cmpq   $0x0,(%r14)
    7e04:	0f 84 a3 00 00 00    	je     7ead <fwp_write+0x63d>
    7e0a:	41 0f b6 4e 08       	movzbl 0x8(%r14),%ecx
    7e0f:	48 8d 15 07 78 00 00 	lea    0x7807(%rip),%rdx        # f61d <fwp_segv.msg+0x3dd>
    7e16:	4c 8d 7c 24 70       	lea    0x70(%rsp),%r15
    7e1b:	be 00 02 00 00       	mov    $0x200,%esi
    7e20:	4c 89 ff             	mov    %r15,%rdi
    7e23:	31 c0                	xor    %eax,%eax
    7e25:	e8 e6 a2 ff ff       	call   2110 <snprintf@plt>
    7e2a:	4c 89 ff             	mov    %r15,%rdi
    7e2d:	e8 ae a2 ff ff       	call   20e0 <strlen@plt>
    7e32:	48 89 ef             	mov    %rbp,%rdi
    7e35:	4c 89 fe             	mov    %r15,%rsi
    7e38:	48 89 c2             	mov    %rax,%rdx
    7e3b:	e8 10 0e 00 00       	call   8c50 <buf_put>
    7e40:	49 83 3e 02          	cmpq   $0x2,(%r14)
    7e44:	72 67                	jb     7ead <fwp_write+0x63d>
    7e46:	bb 09 00 00 00       	mov    $0x9,%ebx
    7e4b:	4c 8d 3d c8 77 00 00 	lea    0x77c8(%rip),%r15        # f61a <fwp_segv.msg+0x3da>
    7e52:	4c 8d 25 c4 77 00 00 	lea    0x77c4(%rip),%r12        # f61d <fwp_segv.msg+0x3dd>
    7e59:	4c 8d 6c 24 70       	lea    0x70(%rsp),%r13
    7e5e:	66 90                	xchg   %ax,%ax
    7e60:	ba 02 00 00 00       	mov    $0x2,%edx
    7e65:	48 89 ef             	mov    %rbp,%rdi
    7e68:	4c 89 fe             	mov    %r15,%rsi
    7e6b:	e8 e0 0d 00 00       	call   8c50 <buf_put>
    7e70:	41 0f b6 0c 1e       	movzbl (%r14,%rbx,1),%ecx
    7e75:	be 00 02 00 00       	mov    $0x200,%esi
    7e7a:	4c 89 ef             	mov    %r13,%rdi
    7e7d:	4c 89 e2             	mov    %r12,%rdx
    7e80:	31 c0                	xor    %eax,%eax
    7e82:	e8 89 a2 ff ff       	call   2110 <snprintf@plt>
    7e87:	4c 89 ef             	mov    %r13,%rdi
    7e8a:	e8 51 a2 ff ff       	call   20e0 <strlen@plt>
    7e8f:	48 89 ef             	mov    %rbp,%rdi
    7e92:	4c 89 ee             	mov    %r13,%rsi
    7e95:	48 89 c2             	mov    %rax,%rdx
    7e98:	e8 b3 0d 00 00       	call   8c50 <buf_put>
    7e9d:	48 8d 43 01          	lea    0x1(%rbx),%rax
    7ea1:	48 83 c3 f9          	add    $0xfffffffffffffff9,%rbx
    7ea5:	49 3b 1e             	cmp    (%r14),%rbx
    7ea8:	48 89 c3             	mov    %rax,%rbx
    7eab:	72 b3                	jb     7e60 <fwp_write+0x5f0>
    7ead:	c6 44 24 20 5d       	movb   $0x5d,0x20(%rsp)
    7eb2:	48 8d 74 24 20       	lea    0x20(%rsp),%rsi
    7eb7:	e9 90 0a 00 00       	jmp    894c <fwp_write+0x10dc>
    7ebc:	66 41 0f 6e ce       	movd   %r14d,%xmm1
    7ec1:	0f 2e c9             	ucomiss %xmm1,%xmm1
    7ec4:	0f 8a 73 0d 00 00    	jp     8c3d <fwp_write+0x13cd>
    7eca:	0f 28 05 0f 72 00 00 	movaps 0x720f(%rip),%xmm0        # f0e0 <_IO_stdin_used+0xe0>
    7ed1:	0f 54 c1             	andps  %xmm1,%xmm0
    7ed4:	0f 2e 05 31 71 00 00 	ucomiss 0x7131(%rip),%xmm0        # f00c <_IO_stdin_used+0xc>
    7edb:	0f 82 6e 04 00 00    	jb     834f <fwp_write+0xadf>
    7ee1:	0f 57 c0             	xorps  %xmm0,%xmm0
    7ee4:	0f 2e c8             	ucomiss %xmm0,%xmm1
    7ee7:	48 8d 05 5b 77 00 00 	lea    0x775b(%rip),%rax        # f649 <fwp_segv.msg+0x409>
    7eee:	48 8d 35 53 77 00 00 	lea    0x7753(%rip),%rsi        # f648 <fwp_segv.msg+0x408>
    7ef5:	48 0f 47 f0          	cmova  %rax,%rsi
    7ef9:	48 8d 7c 24 70       	lea    0x70(%rsp),%rdi
    7efe:	e8 7d a1 ff ff       	call   2080 <strcpy@plt>
    7f03:	e9 90 0b 00 00       	jmp    8a98 <fwp_write+0x1228>
    7f08:	48 8d 35 e9 76 00 00 	lea    0x76e9(%rip),%rsi        # f5f8 <fwp_segv.msg+0x3b8>
    7f0f:	ba 0a 00 00 00       	mov    $0xa,%edx
    7f14:	48 89 ef             	mov    %rbp,%rdi
    7f17:	e9 06 09 00 00       	jmp    8822 <fwp_write+0xfb2>
    7f1c:	48 8d 35 e9 76 00 00 	lea    0x76e9(%rip),%rsi        # f60c <fwp_segv.msg+0x3cc>
    7f23:	ba 06 00 00 00       	mov    $0x6,%edx
    7f28:	48 89 ef             	mov    %rbp,%rdi
    7f2b:	e8 20 0d 00 00       	call   8c50 <buf_put>
    7f30:	49 83 c6 10          	add    $0x10,%r14
    7f34:	4c 89 f7             	mov    %r14,%rdi
    7f37:	e8 a4 a1 ff ff       	call   20e0 <strlen@plt>
    7f3c:	48 89 ef             	mov    %rbp,%rdi
    7f3f:	4c 89 f6             	mov    %r14,%rsi
    7f42:	48 89 c2             	mov    %rax,%rdx
    7f45:	e8 06 0d 00 00       	call   8c50 <buf_put>
    7f4a:	c6 44 24 70 3e       	movb   $0x3e,0x70(%rsp)
    7f4f:	e9 f3 09 00 00       	jmp    8947 <fwp_write+0x10d7>
    7f54:	41 8b 06             	mov    (%r14),%eax
    7f57:	49 8b 4f 18          	mov    0x18(%r15),%rcx
    7f5b:	41 89 c5             	mov    %eax,%r13d
    7f5e:	4e 8b 24 e9          	mov    (%rcx,%r13,8),%r12
    7f62:	4c 89 e7             	mov    %r12,%rdi
    7f65:	e8 76 a1 ff ff       	call   20e0 <strlen@plt>
    7f6a:	48 89 ef             	mov    %rbp,%rdi
    7f6d:	4c 89 e6             	mov    %r12,%rsi
    7f70:	48 89 c2             	mov    %rax,%rdx
    7f73:	e8 d8 0c 00 00       	call   8c50 <buf_put>
    7f78:	49 8b 47 28          	mov    0x28(%r15),%rax
    7f7c:	42 83 3c a8 00       	cmpl   $0x0,(%rax,%r13,4)
    7f81:	0f 8e 2c 0b 00 00    	jle    8ab3 <fwp_write+0x1243>
    7f87:	45 31 e4             	xor    %r12d,%r12d
    7f8a:	4c 89 7c 24 10       	mov    %r15,0x10(%rsp)
    7f8f:	4c 89 6c 24 68       	mov    %r13,0x68(%rsp)
    7f94:	eb 3c                	jmp    7fd2 <fwp_write+0x762>
    7f96:	66 2e 0f 1f 84 00 00 	cs nopw 0x0(%rax,%rax,1)
    7f9d:	00 00 00 
    7fa0:	48 8b 2c 24          	mov    (%rsp),%rbp
    7fa4:	48 89 ef             	mov    %rbp,%rdi
    7fa7:	48 89 de             	mov    %rbx,%rsi
    7faa:	4c 89 ea             	mov    %r13,%rdx
    7fad:	31 c9                	xor    %ecx,%ecx
    7faf:	e8 bc f8 ff ff       	call   7870 <fwp_write>
    7fb4:	49 ff c4             	inc    %r12
    7fb7:	4c 8b 7c 24 10       	mov    0x10(%rsp),%r15
    7fbc:	49 8b 47 28          	mov    0x28(%r15),%rax
    7fc0:	4c 8b 6c 24 68       	mov    0x68(%rsp),%r13
    7fc5:	4a 63 04 a8          	movslq (%rax,%r13,4),%rax
    7fc9:	49 39 c4             	cmp    %rax,%r12
    7fcc:	0f 8d e1 0a 00 00    	jge    8ab3 <fwp_write+0x1243>
    7fd2:	4b 8b 5c e6 08       	mov    0x8(%r14,%r12,8),%rbx
    7fd7:	49 8b 47 30          	mov    0x30(%r15),%rax
    7fdb:	4a 8b 04 e8          	mov    (%rax,%r13,8),%rax
    7fdf:	4e 8b 2c e0          	mov    (%rax,%r12,8),%r13
    7fe3:	c6 44 24 70 20       	movb   $0x20,0x70(%rsp)
    7fe8:	ba 01 00 00 00       	mov    $0x1,%edx
    7fed:	48 89 ef             	mov    %rbp,%rdi
    7ff0:	48 8d 74 24 70       	lea    0x70(%rsp),%rsi
    7ff5:	e8 56 0c 00 00       	call   8c50 <buf_put>
    7ffa:	41 8b 45 00          	mov    0x0(%r13),%eax
    7ffe:	48 83 f8 10          	cmp    $0x10,%rax
    8002:	77 9c                	ja     7fa0 <fwp_write+0x730>
    8004:	48 8d 0d 7d 71 00 00 	lea    0x717d(%rip),%rcx        # f188 <_IO_stdin_used+0x188>
    800b:	48 63 04 81          	movslq (%rcx,%rax,4),%rax
    800f:	48 01 c8             	add    %rcx,%rax
    8012:	ff e0                	jmp    *%rax
    8014:	48 89 d9             	mov    %rbx,%rcx
    8017:	48 c1 e9 3f          	shr    $0x3f,%rcx
    801b:	85 c9                	test   %ecx,%ecx
    801d:	74 81                	je     7fa0 <fwp_write+0x730>
    801f:	c6 44 24 70 28       	movb   $0x28,0x70(%rsp)
    8024:	ba 01 00 00 00       	mov    $0x1,%edx
    8029:	48 8b 2c 24          	mov    (%rsp),%rbp
    802d:	48 89 ef             	mov    %rbp,%rdi
    8030:	4c 8d 7c 24 70       	lea    0x70(%rsp),%r15
    8035:	4c 89 fe             	mov    %r15,%rsi
    8038:	e8 13 0c 00 00       	call   8c50 <buf_put>
    803d:	48 89 ef             	mov    %rbp,%rdi
    8040:	48 89 de             	mov    %rbx,%rsi
    8043:	4c 89 ea             	mov    %r13,%rdx
    8046:	31 c9                	xor    %ecx,%ecx
    8048:	e8 23 f8 ff ff       	call   7870 <fwp_write>
    804d:	c6 44 24 70 29       	movb   $0x29,0x70(%rsp)
    8052:	ba 01 00 00 00       	mov    $0x1,%edx
    8057:	48 89 ef             	mov    %rbp,%rdi
    805a:	4c 89 fe             	mov    %r15,%rsi
    805d:	e8 ee 0b 00 00       	call   8c50 <buf_put>
    8062:	e9 4d ff ff ff       	jmp    7fb4 <fwp_write+0x744>
    8067:	31 c9                	xor    %ecx,%ecx
    8069:	48 81 fb 00 10 00 00 	cmp    $0x1000,%rbx
    8070:	0f 93 c1             	setae  %cl
    8073:	eb a6                	jmp    801b <fwp_write+0x7ab>
    8075:	48 8b 4b 08          	mov    0x8(%rbx),%rcx
    8079:	eb 9c                	jmp    8017 <fwp_write+0x7a7>
    807b:	89 d9                	mov    %ebx,%ecx
    807d:	c1 e9 1f             	shr    $0x1f,%ecx
    8080:	eb 99                	jmp    801b <fwp_write+0x7ab>
    8082:	49 8b 7d 08          	mov    0x8(%r13),%rdi
    8086:	48 85 ff             	test   %rdi,%rdi
    8089:	0f 84 11 ff ff ff    	je     7fa0 <fwp_write+0x730>
    808f:	48 8d 35 9e 75 00 00 	lea    0x759e(%rip),%rsi        # f634 <fwp_segv.msg+0x3f4>
    8096:	e8 e5 a0 ff ff       	call   2180 <strcmp@plt>
    809b:	31 c9                	xor    %ecx,%ecx
    809d:	85 c0                	test   %eax,%eax
    809f:	0f 95 c1             	setne  %cl
    80a2:	e9 74 ff ff ff       	jmp    801b <fwp_write+0x7ab>
    80a7:	41 83 7f 10 00       	cmpl   $0x0,0x10(%r15)
    80ac:	0f 84 a7 08 00 00    	je     8959 <fwp_write+0x10e9>
    80b2:	4d 8d 6f 10          	lea    0x10(%r15),%r13
    80b6:	4d 85 e4             	test   %r12,%r12
    80b9:	0f 94 c0             	sete   %al
    80bc:	41 83 7f 48 00       	cmpl   $0x0,0x48(%r15)
    80c1:	0f 95 c3             	setne  %bl
    80c4:	20 c3                	and    %al,%bl
    80c6:	84 db                	test   %bl,%bl
    80c8:	b8 28 00 00 00       	mov    $0x28,%eax
    80cd:	b9 7b 00 00 00       	mov    $0x7b,%ecx
    80d2:	0f 45 c8             	cmovne %eax,%ecx
    80d5:	88 4c 24 70          	mov    %cl,0x70(%rsp)
    80d9:	48 8d 74 24 70       	lea    0x70(%rsp),%rsi
    80de:	ba 01 00 00 00       	mov    $0x1,%edx
    80e3:	48 89 ef             	mov    %rbp,%rdi
    80e6:	e8 65 0b 00 00       	call   8c50 <buf_put>
    80eb:	41 83 7d 00 00       	cmpl   $0x0,0x0(%r13)
    80f0:	0f 8e da 00 00 00    	jle    81d0 <fwp_write+0x960>
    80f6:	84 db                	test   %bl,%bl
    80f8:	75 31                	jne    812b <fwp_write+0x8bb>
    80fa:	49 8b 47 18          	mov    0x18(%r15),%rax
    80fe:	4c 8b 20             	mov    (%rax),%r12
    8101:	4c 89 e7             	mov    %r12,%rdi
    8104:	e8 d7 9f ff ff       	call   20e0 <strlen@plt>
    8109:	48 89 ef             	mov    %rbp,%rdi
    810c:	4c 89 e6             	mov    %r12,%rsi
    810f:	48 89 c2             	mov    %rax,%rdx
    8112:	e8 39 0b 00 00       	call   8c50 <buf_put>
    8117:	48 8d 35 22 75 00 00 	lea    0x7522(%rip),%rsi        # f640 <fwp_segv.msg+0x400>
    811e:	ba 03 00 00 00       	mov    $0x3,%edx
    8123:	48 89 ef             	mov    %rbp,%rdi
    8126:	e8 25 0b 00 00       	call   8c50 <buf_put>
    812b:	49 8b 76 08          	mov    0x8(%r14),%rsi
    812f:	49 8b 47 20          	mov    0x20(%r15),%rax
    8133:	48 8b 10             	mov    (%rax),%rdx
    8136:	48 89 ef             	mov    %rbp,%rdi
    8139:	31 c9                	xor    %ecx,%ecx
    813b:	e8 30 f7 ff ff       	call   7870 <fwp_write>
    8140:	41 83 7f 10 02       	cmpl   $0x2,0x10(%r15)
    8145:	0f 8c 85 00 00 00    	jl     81d0 <fwp_write+0x960>
    814b:	41 bd 01 00 00 00    	mov    $0x1,%r13d
    8151:	4c 8d 25 c2 74 00 00 	lea    0x74c2(%rip),%r12        # f61a <fwp_segv.msg+0x3da>
    8158:	eb 29                	jmp    8183 <fwp_write+0x913>
    815a:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)
    8160:	4b 8b 74 ee 08       	mov    0x8(%r14,%r13,8),%rsi
    8165:	49 8b 47 20          	mov    0x20(%r15),%rax
    8169:	4a 8b 14 e8          	mov    (%rax,%r13,8),%rdx
    816d:	48 89 ef             	mov    %rbp,%rdi
    8170:	31 c9                	xor    %ecx,%ecx
    8172:	e8 f9 f6 ff ff       	call   7870 <fwp_write>
    8177:	49 ff c5             	inc    %r13
    817a:	49 63 47 10          	movslq 0x10(%r15),%rax
    817e:	49 39 c5             	cmp    %rax,%r13
    8181:	7d 4d                	jge    81d0 <fwp_write+0x960>
    8183:	ba 02 00 00 00       	mov    $0x2,%edx
    8188:	48 89 ef             	mov    %rbp,%rdi
    818b:	4c 89 e6             	mov    %r12,%rsi
    818e:	e8 bd 0a 00 00       	call   8c50 <buf_put>
    8193:	84 db                	test   %bl,%bl
    8195:	75 c9                	jne    8160 <fwp_write+0x8f0>
    8197:	49 8b 47 18          	mov    0x18(%r15),%rax
    819b:	4a 8b 2c e8          	mov    (%rax,%r13,8),%rbp
    819f:	48 89 ef             	mov    %rbp,%rdi
    81a2:	e8 39 9f ff ff       	call   20e0 <strlen@plt>
    81a7:	48 8b 3c 24          	mov    (%rsp),%rdi
    81ab:	48 89 ee             	mov    %rbp,%rsi
    81ae:	48 8b 2c 24          	mov    (%rsp),%rbp
    81b2:	48 89 c2             	mov    %rax,%rdx
    81b5:	e8 96 0a 00 00       	call   8c50 <buf_put>
    81ba:	ba 03 00 00 00       	mov    $0x3,%edx
    81bf:	48 89 ef             	mov    %rbp,%rdi
    81c2:	48 8d 35 77 74 00 00 	lea    0x7477(%rip),%rsi        # f640 <fwp_segv.msg+0x400>
    81c9:	e8 82 0a 00 00       	call   8c50 <buf_put>
    81ce:	eb 90                	jmp    8160 <fwp_write+0x8f0>
    81d0:	84 db                	test   %bl,%bl
    81d2:	b8 29 00 00 00       	mov    $0x29,%eax
    81d7:	b9 7d 00 00 00       	mov    $0x7d,%ecx
    81dc:	0f 45 c8             	cmovne %eax,%ecx
    81df:	88 4c 24 70          	mov    %cl,0x70(%rsp)
    81e3:	e9 5f 07 00 00       	jmp    8947 <fwp_write+0x10d7>
    81e8:	48 89 ef             	mov    %rbp,%rdi
    81eb:	48 81 c4 78 02 00 00 	add    $0x278,%rsp
    81f2:	5b                   	pop    %rbx
    81f3:	41 5c                	pop    %r12
    81f5:	41 5d                	pop    %r13
    81f7:	41 5e                	pop    %r14
    81f9:	41 5f                	pop    %r15
    81fb:	5d                   	pop    %rbp
    81fc:	e9 3f 0b 00 00       	jmp    8d40 <fwp_escape>
    8201:	c6 44 24 20 30       	movb   $0x30,0x20(%rsp)
    8206:	bf 01 00 00 00       	mov    $0x1,%edi
    820b:	89 f8                	mov    %edi,%eax
    820d:	48 83 f8 08          	cmp    $0x8,%rax
    8211:	73 0a                	jae    821d <fwp_write+0x9ad>
    8213:	31 c9                	xor    %ecx,%ecx
    8215:	48 89 c2             	mov    %rax,%rdx
    8218:	e9 7a 04 00 00       	jmp    8697 <fwp_write+0xe27>
    821d:	83 f8 20             	cmp    $0x20,%eax
    8220:	0f 83 68 03 00 00    	jae    858e <fwp_write+0xd1e>
    8226:	31 c9                	xor    %ecx,%ecx
    8228:	e9 10 04 00 00       	jmp    863d <fwp_write+0xdcd>
    822d:	31 ff                	xor    %edi,%edi
    822f:	49 f7 d8             	neg    %r8
    8232:	41 ba 00 00 00 00    	mov    $0x0,%r10d
    8238:	4d 19 ca             	sbb    %r9,%r10
    823b:	c6 44 24 70 2d       	movb   $0x2d,0x70(%rsp)
    8240:	49 b9 cd cc cc cc cc 	movabs $0xcccccccccccccccd,%r9
    8247:	cc cc cc 
    824a:	49 bb cc cc cc cc cc 	movabs $0xcccccccccccccccc,%r11
    8251:	cc cc cc 
    8254:	4c 89 d3             	mov    %r10,%rbx
    8257:	66 0f 1f 84 00 00 00 	nopw   0x0(%rax,%rax,1)
    825e:	00 00 
    8260:	4c 89 d1             	mov    %r10,%rcx
    8263:	4c 0f a4 c1 3f       	shld   $0x3f,%r8,%rcx
    8268:	48 d1 eb             	shr    $1,%rbx
    826b:	48 89 ce             	mov    %rcx,%rsi
    826e:	48 01 de             	add    %rbx,%rsi
    8271:	48 83 d6 00          	adc    $0x0,%rsi
    8275:	48 89 f0             	mov    %rsi,%rax
    8278:	49 f7 e1             	mul    %r9
    827b:	48 c1 ea 02          	shr    $0x2,%rdx
    827f:	48 8d 04 92          	lea    (%rdx,%rdx,4),%rax
    8283:	48 29 c6             	sub    %rax,%rsi
    8286:	48 29 f1             	sub    %rsi,%rcx
    8289:	48 83 db 00          	sbb    $0x0,%rbx
    828d:	48 89 ce             	mov    %rcx,%rsi
    8290:	49 0f af f3          	imul   %r11,%rsi
    8294:	48 89 c8             	mov    %rcx,%rax
    8297:	49 f7 e1             	mul    %r9
    829a:	48 01 f2             	add    %rsi,%rdx
    829d:	49 0f af d9          	imul   %r9,%rbx
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
    82c1:	49 83 da 00          	sbb    $0x0,%r10
    82c5:	49 89 c0             	mov    %rax,%r8
    82c8:	49 89 da             	mov    %rbx,%r10
    82cb:	73 93                	jae    8260 <fwp_write+0x9f0>
    82cd:	85 ff                	test   %edi,%edi
    82cf:	0f 8e 98 06 00 00    	jle    896d <fwp_write+0x10fd>
    82d5:	89 f8                	mov    %edi,%eax
    82d7:	48 83 f8 08          	cmp    $0x8,%rax
    82db:	0f 83 e4 07 00 00    	jae    8ac5 <fwp_write+0x1255>
    82e1:	31 c9                	xor    %ecx,%ecx
    82e3:	48 89 c2             	mov    %rax,%rdx
    82e6:	e9 fc 08 00 00       	jmp    8be7 <fwp_write+0x1377>
    82eb:	bd 01 00 00 00       	mov    $0x1,%ebp
    82f0:	4c 8d 74 24 70       	lea    0x70(%rsp),%r14
    82f5:	0f 29 4c 24 10       	movaps %xmm1,0x10(%rsp)
    82fa:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)
    8300:	4c 89 f7             	mov    %r14,%rdi
    8303:	66 0f 28 c1          	movapd %xmm1,%xmm0
    8307:	89 ee                	mov    %ebp,%esi
    8309:	e8 a2 16 00 00       	call   99b0 <fwp_format_g>
    830e:	4c 89 f7             	mov    %r14,%rdi
    8311:	31 f6                	xor    %esi,%esi
    8313:	e8 88 9d ff ff       	call   20a0 <strtod@plt>
    8318:	66 0f 28 4c 24 10    	movapd 0x10(%rsp),%xmm1
    831e:	66 0f 2e c1          	ucomisd %xmm1,%xmm0
    8322:	75 06                	jne    832a <fwp_write+0xaba>
    8324:	0f 8b 9e 03 00 00    	jnp    86c8 <fwp_write+0xe58>
    832a:	ff c5                	inc    %ebp
    832c:	83 fd 12             	cmp    $0x12,%ebp
    832f:	75 cf                	jne    8300 <fwp_write+0xa90>
    8331:	4c 8d 74 24 70       	lea    0x70(%rsp),%r14
    8336:	4c 89 f7             	mov    %r14,%rdi
    8339:	66 0f 28 c1          	movapd %xmm1,%xmm0
    833d:	be 11 00 00 00       	mov    $0x11,%esi
    8342:	e8 69 16 00 00       	call   99b0 <fwp_format_g>
    8347:	4c 89 f7             	mov    %r14,%rdi
    834a:	e9 7e 03 00 00       	jmp    86cd <fwp_write+0xe5d>
    834f:	0f 57 c0             	xorps  %xmm0,%xmm0
    8352:	f3 0f 5a c1          	cvtss2sd %xmm1,%xmm0
    8356:	4c 8d 74 24 70       	lea    0x70(%rsp),%r14
    835b:	4c 89 f7             	mov    %r14,%rdi
    835e:	f2 0f 11 44 24 10    	movsd  %xmm0,0x10(%rsp)
    8364:	be 01 00 00 00       	mov    $0x1,%esi
    8369:	0f 29 0c 24          	movaps %xmm1,(%rsp)
    836d:	e8 3e 16 00 00       	call   99b0 <fwp_format_g>
    8372:	4c 89 f7             	mov    %r14,%rdi
    8375:	31 f6                	xor    %esi,%esi
    8377:	e8 a4 9d ff ff       	call   2120 <strtof@plt>
    837c:	0f 2e 04 24          	ucomiss (%rsp),%xmm0
    8380:	75 06                	jne    8388 <fwp_write+0xb18>
    8382:	0f 8b 6f 01 00 00    	jnp    84f7 <fwp_write+0xc87>
    8388:	4c 8d 74 24 70       	lea    0x70(%rsp),%r14
    838d:	4c 89 f7             	mov    %r14,%rdi
    8390:	f2 0f 10 44 24 10    	movsd  0x10(%rsp),%xmm0
    8396:	be 02 00 00 00       	mov    $0x2,%esi
    839b:	e8 10 16 00 00       	call   99b0 <fwp_format_g>
    83a0:	4c 89 f7             	mov    %r14,%rdi
    83a3:	31 f6                	xor    %esi,%esi
    83a5:	e8 76 9d ff ff       	call   2120 <strtof@plt>
    83aa:	0f 2e 04 24          	ucomiss (%rsp),%xmm0
    83ae:	75 06                	jne    83b6 <fwp_write+0xb46>
    83b0:	0f 8b 41 01 00 00    	jnp    84f7 <fwp_write+0xc87>
    83b6:	4c 8d 74 24 70       	lea    0x70(%rsp),%r14
    83bb:	4c 89 f7             	mov    %r14,%rdi
    83be:	f2 0f 10 44 24 10    	movsd  0x10(%rsp),%xmm0
    83c4:	be 03 00 00 00       	mov    $0x3,%esi
    83c9:	e8 e2 15 00 00       	call   99b0 <fwp_format_g>
    83ce:	4c 89 f7             	mov    %r14,%rdi
    83d1:	31 f6                	xor    %esi,%esi
    83d3:	e8 48 9d ff ff       	call   2120 <strtof@plt>
    83d8:	0f 2e 04 24          	ucomiss (%rsp),%xmm0
    83dc:	75 06                	jne    83e4 <fwp_write+0xb74>
    83de:	0f 8b 13 01 00 00    	jnp    84f7 <fwp_write+0xc87>
    83e4:	4c 8d 74 24 70       	lea    0x70(%rsp),%r14
    83e9:	4c 89 f7             	mov    %r14,%rdi
    83ec:	f2 0f 10 44 24 10    	movsd  0x10(%rsp),%xmm0
    83f2:	be 04 00 00 00       	mov    $0x4,%esi
    83f7:	e8 b4 15 00 00       	call   99b0 <fwp_format_g>
    83fc:	4c 89 f7             	mov    %r14,%rdi
    83ff:	31 f6                	xor    %esi,%esi
    8401:	e8 1a 9d ff ff       	call   2120 <strtof@plt>
    8406:	0f 2e 04 24          	ucomiss (%rsp),%xmm0
    840a:	75 06                	jne    8412 <fwp_write+0xba2>
    840c:	0f 8b e5 00 00 00    	jnp    84f7 <fwp_write+0xc87>
    8412:	4c 8d 74 24 70       	lea    0x70(%rsp),%r14
    8417:	4c 89 f7             	mov    %r14,%rdi
    841a:	f2 0f 10 44 24 10    	movsd  0x10(%rsp),%xmm0
    8420:	be 05 00 00 00       	mov    $0x5,%esi
    8425:	e8 86 15 00 00       	call   99b0 <fwp_format_g>
    842a:	4c 89 f7             	mov    %r14,%rdi
    842d:	31 f6                	xor    %esi,%esi
    842f:	e8 ec 9c ff ff       	call   2120 <strtof@plt>
    8434:	0f 2e 04 24          	ucomiss (%rsp),%xmm0
    8438:	75 06                	jne    8440 <fwp_write+0xbd0>
    843a:	0f 8b b7 00 00 00    	jnp    84f7 <fwp_write+0xc87>
    8440:	4c 8d 74 24 70       	lea    0x70(%rsp),%r14
    8445:	4c 89 f7             	mov    %r14,%rdi
    8448:	f2 0f 10 44 24 10    	movsd  0x10(%rsp),%xmm0
    844e:	be 06 00 00 00       	mov    $0x6,%esi
    8453:	e8 58 15 00 00       	call   99b0 <fwp_format_g>
    8458:	4c 89 f7             	mov    %r14,%rdi
    845b:	31 f6                	xor    %esi,%esi
    845d:	e8 be 9c ff ff       	call   2120 <strtof@plt>
    8462:	0f 2e 04 24          	ucomiss (%rsp),%xmm0
    8466:	75 06                	jne    846e <fwp_write+0xbfe>
    8468:	0f 8b 89 00 00 00    	jnp    84f7 <fwp_write+0xc87>
    846e:	4c 8d 74 24 70       	lea    0x70(%rsp),%r14
    8473:	4c 89 f7             	mov    %r14,%rdi
    8476:	f2 0f 10 44 24 10    	movsd  0x10(%rsp),%xmm0
    847c:	be 07 00 00 00       	mov    $0x7,%esi
    8481:	e8 2a 15 00 00       	call   99b0 <fwp_format_g>
    8486:	4c 89 f7             	mov    %r14,%rdi
    8489:	31 f6                	xor    %esi,%esi
    848b:	e8 90 9c ff ff       	call   2120 <strtof@plt>
    8490:	0f 2e 04 24          	ucomiss (%rsp),%xmm0
    8494:	75 02                	jne    8498 <fwp_write+0xc28>
    8496:	7b 5f                	jnp    84f7 <fwp_write+0xc87>
    8498:	4c 8d 74 24 70       	lea    0x70(%rsp),%r14
    849d:	4c 89 f7             	mov    %r14,%rdi
    84a0:	f2 0f 10 44 24 10    	movsd  0x10(%rsp),%xmm0
    84a6:	be 08 00 00 00       	mov    $0x8,%esi
    84ab:	e8 00 15 00 00       	call   99b0 <fwp_format_g>
    84b0:	4c 89 f7             	mov    %r14,%rdi
    84b3:	31 f6                	xor    %esi,%esi
    84b5:	e8 66 9c ff ff       	call   2120 <strtof@plt>
    84ba:	0f 28 0c 24          	movaps (%rsp),%xmm1
    84be:	0f 2e c1             	ucomiss %xmm1,%xmm0
    84c1:	75 02                	jne    84c5 <fwp_write+0xc55>
    84c3:	7b 32                	jnp    84f7 <fwp_write+0xc87>
    84c5:	4c 8d 74 24 70       	lea    0x70(%rsp),%r14
    84ca:	4c 89 f7             	mov    %r14,%rdi
    84cd:	f2 0f 10 44 24 10    	movsd  0x10(%rsp),%xmm0
    84d3:	be 09 00 00 00       	mov    $0x9,%esi
    84d8:	e8 d3 14 00 00       	call   99b0 <fwp_format_g>
    84dd:	4c 89 f7             	mov    %r14,%rdi
    84e0:	31 f6                	xor    %esi,%esi
    84e2:	e8 39 9c ff ff       	call   2120 <strtof@plt>
    84e7:	0f 2e 04 24          	ucomiss (%rsp),%xmm0
    84eb:	0f 85 2c 07 00 00    	jne    8c1d <fwp_write+0x13ad>
    84f1:	0f 8a 26 07 00 00    	jp     8c1d <fwp_write+0x13ad>
    84f7:	48 8d 7c 24 70       	lea    0x70(%rsp),%rdi
    84fc:	be 2e 00 00 00       	mov    $0x2e,%esi
    8501:	e8 fa 9b ff ff       	call   2100 <strchr@plt>
    8506:	48 85 c0             	test   %rax,%rax
    8509:	0f 85 89 05 00 00    	jne    8a98 <fwp_write+0x1228>
    850f:	e9 d0 01 00 00       	jmp    86e4 <fwp_write+0xe74>
    8514:	4c 8b bc f0 d0 03 00 	mov    0x3d0(%rax,%rsi,8),%r15
    851b:	00 
    851c:	48 8b bc f0 d8 03 00 	mov    0x3d8(%rax,%rsi,8),%rdi
    8523:	00 
    8524:	4c 29 ff             	sub    %r15,%rdi
    8527:	48 39 cf             	cmp    %rcx,%rdi
    852a:	0f 83 1b 02 00 00    	jae    874b <fwp_write+0xedb>
    8530:	48 89 d7             	mov    %rdx,%rdi
    8533:	be 01 00 00 00       	mov    $0x1,%esi
    8538:	e8 03 e2 ff ff       	call   6740 <fwp_gc_alloc_slow>
    853d:	49 89 c7             	mov    %rax,%r15
    8540:	e9 20 02 00 00       	jmp    8765 <fwp_write+0xef5>
    8545:	49 8b 76 08          	mov    0x8(%r14),%rsi
    8549:	48 89 f2             	mov    %rsi,%rdx
    854c:	48 c1 fa 3f          	sar    $0x3f,%rdx
    8550:	4c 8d 74 24 70       	lea    0x70(%rsp),%r14
    8555:	4c 89 f7             	mov    %r14,%rdi
    8558:	e8 23 09 00 00       	call   8e80 <fwp_fmt_duration>
    855d:	e9 3b 05 00 00       	jmp    8a9d <fwp_write+0x122d>
    8562:	c6 44 24 20 30       	movb   $0x30,0x20(%rsp)
    8567:	bf 01 00 00 00       	mov    $0x1,%edi
    856c:	89 f8                	mov    %edi,%eax
    856e:	48 83 f8 08          	cmp    $0x8,%rax
    8572:	73 0a                	jae    857e <fwp_write+0xd0e>
    8574:	31 c9                	xor    %ecx,%ecx
    8576:	48 89 c2             	mov    %rax,%rdx
    8579:	e9 f2 04 00 00       	jmp    8a70 <fwp_write+0x1200>
    857e:	83 f8 20             	cmp    $0x20,%eax
    8581:	0f 83 f2 03 00 00    	jae    8979 <fwp_write+0x1109>
    8587:	31 c9                	xor    %ecx,%ecx
    8589:	e9 92 04 00 00       	jmp    8a20 <fwp_write+0x11b0>
    858e:	89 fa                	mov    %edi,%edx
    8590:	83 e2 1f             	and    $0x1f,%edx
    8593:	48 89 c1             	mov    %rax,%rcx
    8596:	48 29 d1             	sub    %rdx,%rcx
    8599:	48 8d b4 24 80 00 00 	lea    0x80(%rsp),%rsi
    85a0:	00 
    85a1:	66 0f ef c0          	pxor   %xmm0,%xmm0
    85a5:	49 89 c0             	mov    %rax,%r8
    85a8:	0f 1f 84 00 00 00 00 	nopl   0x0(%rax,%rax,1)
    85af:	00 
    85b0:	f3 42 0f 6f 0c 04    	movdqu (%rsp,%r8,1),%xmm1
    85b6:	f3 42 0f 6f 54 04 10 	movdqu 0x10(%rsp,%r8,1),%xmm2
    85bd:	66 0f 6f da          	movdqa %xmm2,%xmm3
    85c1:	66 0f 60 d8          	punpcklbw %xmm0,%xmm3
    85c5:	66 0f 70 db 4e       	pshufd $0x4e,%xmm3,%xmm3
    85ca:	f2 0f 70 db 1b       	pshuflw $0x1b,%xmm3,%xmm3
    85cf:	f3 0f 70 db 1b       	pshufhw $0x1b,%xmm3,%xmm3
    85d4:	66 0f 68 d0          	punpckhbw %xmm0,%xmm2
    85d8:	66 0f 70 d2 4e       	pshufd $0x4e,%xmm2,%xmm2
    85dd:	f2 0f 70 d2 1b       	pshuflw $0x1b,%xmm2,%xmm2
    85e2:	f3 0f 70 d2 1b       	pshufhw $0x1b,%xmm2,%xmm2
    85e7:	66 0f 67 d3          	packuswb %xmm3,%xmm2
    85eb:	66 0f 6f d9          	movdqa %xmm1,%xmm3
    85ef:	66 0f 60 d8          	punpcklbw %xmm0,%xmm3
    85f3:	66 0f 70 db 4e       	pshufd $0x4e,%xmm3,%xmm3
    85f8:	f2 0f 70 db 1b       	pshuflw $0x1b,%xmm3,%xmm3
    85fd:	f3 0f 70 db 1b       	pshufhw $0x1b,%xmm3,%xmm3
    8602:	66 0f 68 c8          	punpckhbw %xmm0,%xmm1
    8606:	66 0f 70 c9 4e       	pshufd $0x4e,%xmm1,%xmm1
    860b:	f2 0f 70 c9 1b       	pshuflw $0x1b,%xmm1,%xmm1
    8610:	f3 0f 70 c9 1b       	pshufhw $0x1b,%xmm1,%xmm1
    8615:	66 0f 67 cb          	packuswb %xmm3,%xmm1
    8619:	66 0f 7f 56 f0       	movdqa %xmm2,-0x10(%rsi)
    861e:	66 0f 7f 0e          	movdqa %xmm1,(%rsi)
    8622:	49 83 c0 e0          	add    $0xffffffffffffffe0,%r8
    8626:	48 83 c6 20          	add    $0x20,%rsi
    862a:	4c 39 c2             	cmp    %r8,%rdx
    862d:	75 81                	jne    85b0 <fwp_write+0xd40>
    862f:	48 85 d2             	test   %rdx,%rdx
    8632:	0f 84 5b 04 00 00    	je     8a93 <fwp_write+0x1223>
    8638:	83 fa 08             	cmp    $0x8,%edx
    863b:	72 5a                	jb     8697 <fwp_write+0xe27>
    863d:	89 fa                	mov    %edi,%edx
    863f:	83 e2 07             	and    $0x7,%edx
    8642:	48 89 c6             	mov    %rax,%rsi
    8645:	48 29 ce             	sub    %rcx,%rsi
    8648:	48 8d 3c 0c          	lea    (%rsp,%rcx,1),%rdi
    864c:	48 83 c7 70          	add    $0x70,%rdi
    8650:	48 89 c1             	mov    %rax,%rcx
    8653:	48 29 d1             	sub    %rdx,%rcx
    8656:	66 0f ef c0          	pxor   %xmm0,%xmm0
    865a:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)
    8660:	f3 0f 7e 4c 34 18    	movq   0x18(%rsp,%rsi,1),%xmm1
    8666:	66 0f 60 c8          	punpcklbw %xmm0,%xmm1
    866a:	66 0f 70 c9 4e       	pshufd $0x4e,%xmm1,%xmm1
    866f:	f2 0f 70 c9 1b       	pshuflw $0x1b,%xmm1,%xmm1
    8674:	f3 0f 70 c9 1b       	pshufhw $0x1b,%xmm1,%xmm1
    8679:	66 0f 67 c9          	packuswb %xmm1,%xmm1
    867d:	66 0f d6 0f          	movq   %xmm1,(%rdi)
    8681:	48 83 c6 f8          	add    $0xfffffffffffffff8,%rsi
    8685:	48 83 c7 08          	add    $0x8,%rdi
    8689:	48 39 f2             	cmp    %rsi,%rdx
    868c:	75 d2                	jne    8660 <fwp_write+0xdf0>
    868e:	48 85 d2             	test   %rdx,%rdx
    8691:	0f 84 fc 03 00 00    	je     8a93 <fwp_write+0x1223>
    8697:	48 8d 74 24 20       	lea    0x20(%rsp),%rsi
    869c:	48 01 f2             	add    %rsi,%rdx
    869f:	48 ff ca             	dec    %rdx
    86a2:	66 66 66 66 66 2e 0f 	data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    86a9:	1f 84 00 00 00 00 00 
    86b0:	0f b6 32             	movzbl (%rdx),%esi
    86b3:	40 88 74 0c 70       	mov    %sil,0x70(%rsp,%rcx,1)
    86b8:	48 ff c1             	inc    %rcx
    86bb:	48 ff ca             	dec    %rdx
    86be:	48 39 c8             	cmp    %rcx,%rax
    86c1:	75 ed                	jne    86b0 <fwp_write+0xe40>
    86c3:	e9 cb 03 00 00       	jmp    8a93 <fwp_write+0x1223>
    86c8:	48 8d 7c 24 70       	lea    0x70(%rsp),%rdi
    86cd:	be 2e 00 00 00       	mov    $0x2e,%esi
    86d2:	e8 29 9a ff ff       	call   2100 <strchr@plt>
    86d7:	48 85 c0             	test   %rax,%rax
    86da:	48 8b 2c 24          	mov    (%rsp),%rbp
    86de:	0f 85 b4 03 00 00    	jne    8a98 <fwp_write+0x1228>
    86e4:	48 8d 7c 24 70       	lea    0x70(%rsp),%rdi
    86e9:	be 65 00 00 00       	mov    $0x65,%esi
    86ee:	e8 0d 9a ff ff       	call   2100 <strchr@plt>
    86f3:	48 85 c0             	test   %rax,%rax
    86f6:	0f 85 9c 03 00 00    	jne    8a98 <fwp_write+0x1228>
    86fc:	48 8d 35 46 6f 00 00 	lea    0x6f46(%rip),%rsi        # f649 <fwp_segv.msg+0x409>
    8703:	48 8d 7c 24 70       	lea    0x70(%rsp),%rdi
    8708:	e8 d3 9b ff ff       	call   22e0 <strstr@plt>
    870d:	48 85 c0             	test   %rax,%rax
    8710:	0f 85 82 03 00 00    	jne    8a98 <fwp_write+0x1228>
    8716:	48 8d 35 27 6f 00 00 	lea    0x6f27(%rip),%rsi        # f644 <fwp_segv.msg+0x404>
    871d:	48 8d 7c 24 70       	lea    0x70(%rsp),%rdi
    8722:	e8 b9 9b ff ff       	call   22e0 <strstr@plt>
    8727:	48 85 c0             	test   %rax,%rax
    872a:	0f 85 68 03 00 00    	jne    8a98 <fwp_write+0x1228>
    8730:	48 8d 7c 24 70       	lea    0x70(%rsp),%rdi
    8735:	e8 a6 99 ff ff       	call   20e0 <strlen@plt>
    873a:	66 c7 44 04 70 2e 30 	movw   $0x302e,0x70(%rsp,%rax,1)
    8741:	c6 44 04 72 00       	movb   $0x0,0x72(%rsp,%rax,1)
    8746:	e9 4d 03 00 00       	jmp    8a98 <fwp_write+0x1228>
    874b:	48 8d 04 f0          	lea    (%rax,%rsi,8),%rax
    874f:	48 05 d0 03 00 00    	add    $0x3d0,%rax
    8755:	4c 01 f9             	add    %r15,%rcx
    8758:	48 89 08             	mov    %rcx,(%rax)
    875b:	4c 89 ff             	mov    %r15,%rdi
    875e:	31 f6                	xor    %esi,%esi
    8760:	e8 cb 99 ff ff       	call   2130 <memset@plt>
    8765:	66 41 c7 07 30 74    	movw   $0x7430,(%r15)
    876b:	85 db                	test   %ebx,%ebx
    876d:	0f 8e 98 00 00 00    	jle    880b <fwp_write+0xf9b>
    8773:	44 89 e1             	mov    %r12d,%ecx
    8776:	48 f7 d9             	neg    %rcx
    8779:	4a 8d 34 3b          	lea    (%rbx,%r15,1),%rsi
    877d:	48 ff c6             	inc    %rsi
    8780:	31 ff                	xor    %edi,%edi
    8782:	49 b8 56 55 55 55 55 	movabs $0x5555555555555556,%r8
    8789:	55 55 55 
    878c:	eb 2e                	jmp    87bc <fwp_write+0xf4c>
    878e:	66 90                	xchg   %ax,%ax
    8790:	41 b2 30             	mov    $0x30,%r10b
    8793:	44 88 14 3e          	mov    %r10b,(%rsi,%rdi,1)
    8797:	48 85 d2             	test   %rdx,%rdx
    879a:	0f 95 c2             	setne  %dl
    879d:	4d 85 f6             	test   %r14,%r14
    87a0:	41 0f 98 c2          	sets   %r10b
    87a4:	41 20 d2             	and    %dl,%r10b
    87a7:	41 0f b6 d2          	movzbl %r10b,%edx
    87ab:	48 29 d0             	sub    %rdx,%rax
    87ae:	4c 01 c8             	add    %r9,%rax
    87b1:	48 ff cf             	dec    %rdi
    87b4:	49 89 c6             	mov    %rax,%r14
    87b7:	48 39 f9             	cmp    %rdi,%rcx
    87ba:	74 4f                	je     880b <fwp_write+0xf9b>
    87bc:	4c 89 f0             	mov    %r14,%rax
    87bf:	49 f7 e8             	imul   %r8
    87c2:	48 89 d0             	mov    %rdx,%rax
    87c5:	48 c1 e8 3f          	shr    $0x3f,%rax
    87c9:	48 01 d0             	add    %rdx,%rax
    87cc:	4c 8d 0c 40          	lea    (%rax,%rax,2),%r9
    87d0:	4c 89 f2             	mov    %r14,%rdx
    87d3:	4c 29 ca             	sub    %r9,%rdx
    87d6:	49 f7 d9             	neg    %r9
    87d9:	4d 01 f1             	add    %r14,%r9
    87dc:	49 83 c1 03          	add    $0x3,%r9
    87e0:	48 83 fa fd          	cmp    $0xfffffffffffffffd,%rdx
    87e4:	4c 0f 42 ca          	cmovb  %rdx,%r9
    87e8:	4d 85 c9             	test   %r9,%r9
    87eb:	74 a3                	je     8790 <fwp_write+0xf20>
    87ed:	49 83 f9 01          	cmp    $0x1,%r9
    87f1:	75 0d                	jne    8800 <fwp_write+0xf90>
    87f3:	41 b2 2b             	mov    $0x2b,%r10b
    87f6:	45 31 c9             	xor    %r9d,%r9d
    87f9:	eb 98                	jmp    8793 <fwp_write+0xf23>
    87fb:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)
    8800:	41 b2 2d             	mov    $0x2d,%r10b
    8803:	41 b9 01 00 00 00    	mov    $0x1,%r9d
    8809:	eb 88                	jmp    8793 <fwp_write+0xf23>
    880b:	43 c6 44 27 02 00    	movb   $0x0,0x2(%r15,%r12,1)
    8811:	4c 89 ff             	mov    %r15,%rdi
    8814:	e8 c7 98 ff ff       	call   20e0 <strlen@plt>
    8819:	48 89 ef             	mov    %rbp,%rdi
    881c:	4c 89 fe             	mov    %r15,%rsi
    881f:	48 89 c2             	mov    %rax,%rdx
    8822:	48 81 c4 78 02 00 00 	add    $0x278,%rsp
    8829:	5b                   	pop    %rbx
    882a:	41 5c                	pop    %r12
    882c:	41 5d                	pop    %r13
    882e:	41 5e                	pop    %r14
    8830:	41 5f                	pop    %r15
    8832:	5d                   	pop    %rbp
    8833:	e9 18 04 00 00       	jmp    8c50 <buf_put>
    8838:	48 8b 31             	mov    (%rcx),%rsi
    883b:	eb 18                	jmp    8855 <fwp_write+0xfe5>
    883d:	83 3a 00             	cmpl   $0x0,(%rdx)
    8840:	0f b6 01             	movzbl (%rcx),%eax
    8843:	48 0f be f0          	movsbq %al,%rsi
    8847:	eb 08                	jmp    8851 <fwp_write+0xfe1>
    8849:	83 3a 02             	cmpl   $0x2,(%rdx)
    884c:	8b 01                	mov    (%rcx),%eax
    884e:	48 63 f0             	movslq %eax,%rsi
    8851:	48 0f 45 f0          	cmovne %rax,%rsi
    8855:	48 8b 2c 24          	mov    (%rsp),%rbp
    8859:	48 89 ef             	mov    %rbp,%rdi
    885c:	31 c9                	xor    %ecx,%ecx
    885e:	e8 0d f0 ff ff       	call   7870 <fwp_write>
    8863:	48 b8 ff ff ff ff ff 	movabs $0x7fffffffffffffff,%rax
    886a:	ff ff 7f 
    886d:	48 ff c8             	dec    %rax
    8870:	49 85 06             	test   %rax,(%r14)
    8873:	0f 84 c9 00 00 00    	je     8942 <fwp_write+0x10d2>
    8879:	bb 01 00 00 00       	mov    $0x1,%ebx
    887e:	4c 8d 25 95 6d 00 00 	lea    0x6d95(%rip),%r12        # f61a <fwp_segv.msg+0x3da>
    8885:	eb 39                	jmp    88c0 <fwp_write+0x1050>
    8887:	83 3a 01             	cmpl   $0x1,(%rdx)
    888a:	0f b7 04 31          	movzwl (%rcx,%rsi,1),%eax
    888e:	48 0f bf f0          	movswq %ax,%rsi
    8892:	48 0f 45 f0          	cmovne %rax,%rsi
    8896:	48 8b 2c 24          	mov    (%rsp),%rbp
    889a:	48 89 ef             	mov    %rbp,%rdi
    889d:	31 c9                	xor    %ecx,%ecx
    889f:	e8 cc ef ff ff       	call   7870 <fwp_write>
    88a4:	48 ff c3             	inc    %rbx
    88a7:	49 8b 06             	mov    (%r14),%rax
    88aa:	48 b9 ff ff ff ff ff 	movabs $0x7fffffffffffffff,%rcx
    88b1:	ff ff 7f 
    88b4:	48 21 c8             	and    %rcx,%rax
    88b7:	48 39 c3             	cmp    %rax,%rbx
    88ba:	0f 83 82 00 00 00    	jae    8942 <fwp_write+0x10d2>
    88c0:	ba 02 00 00 00       	mov    $0x2,%edx
    88c5:	48 89 ef             	mov    %rbp,%rdi
    88c8:	4c 89 e6             	mov    %r12,%rsi
    88cb:	e8 80 03 00 00       	call   8c50 <buf_put>
    88d0:	49 8b 57 38          	mov    0x38(%r15),%rdx
    88d4:	b8 08 00 00 00       	mov    $0x8,%eax
    88d9:	48 85 d2             	test   %rdx,%rdx
    88dc:	74 13                	je     88f1 <fwp_write+0x1081>
    88de:	8b 0a                	mov    (%rdx),%ecx
    88e0:	48 83 f9 0a          	cmp    $0xa,%rcx
    88e4:	77 0b                	ja     88f1 <fwp_write+0x1081>
    88e6:	48 8d 05 cb 69 00 00 	lea    0x69cb(%rip),%rax        # f2b8 <fwp_segv.msg+0x78>
    88ed:	48 8b 04 c8          	mov    (%rax,%rcx,8),%rax
    88f1:	49 83 3e 00          	cmpq   $0x0,(%r14)
    88f5:	4c 89 e9             	mov    %r13,%rcx
    88f8:	79 04                	jns    88fe <fwp_write+0x108e>
    88fa:	49 8b 4e 10          	mov    0x10(%r14),%rcx
    88fe:	48 89 c6             	mov    %rax,%rsi
    8901:	48 0f af f3          	imul   %rbx,%rsi
    8905:	48 83 f8 01          	cmp    $0x1,%rax
    8909:	74 19                	je     8924 <fwp_write+0x10b4>
    890b:	48 83 f8 02          	cmp    $0x2,%rax
    890f:	0f 84 72 ff ff ff    	je     8887 <fwp_write+0x1017>
    8915:	48 83 f8 08          	cmp    $0x8,%rax
    8919:	75 19                	jne    8934 <fwp_write+0x10c4>
    891b:	48 8b 34 31          	mov    (%rcx,%rsi,1),%rsi
    891f:	e9 72 ff ff ff       	jmp    8896 <fwp_write+0x1026>
    8924:	83 3a 00             	cmpl   $0x0,(%rdx)
    8927:	0f b6 04 31          	movzbl (%rcx,%rsi,1),%eax
    892b:	48 0f be f0          	movsbq %al,%rsi
    892f:	e9 5e ff ff ff       	jmp    8892 <fwp_write+0x1022>
    8934:	83 3a 02             	cmpl   $0x2,(%rdx)
    8937:	8b 04 31             	mov    (%rcx,%rsi,1),%eax
    893a:	48 63 f0             	movslq %eax,%rsi
    893d:	e9 50 ff ff ff       	jmp    8892 <fwp_write+0x1022>
    8942:	c6 44 24 70 5d       	movb   $0x5d,0x70(%rsp)
    8947:	48 8d 74 24 70       	lea    0x70(%rsp),%rsi
    894c:	ba 01 00 00 00       	mov    $0x1,%edx
    8951:	48 89 ef             	mov    %rbp,%rdi
    8954:	e9 55 01 00 00       	jmp    8aae <fwp_write+0x123e>
    8959:	48 8d 35 dd 6c 00 00 	lea    0x6cdd(%rip),%rsi        # f63d <fwp_segv.msg+0x3fd>
    8960:	ba 02 00 00 00       	mov    $0x2,%edx
    8965:	48 89 ef             	mov    %rbp,%rdi
    8968:	e9 b5 fe ff ff       	jmp    8822 <fwp_write+0xfb2>
    896d:	31 c0                	xor    %eax,%eax
    896f:	c6 44 04 71 00       	movb   $0x0,0x71(%rsp,%rax,1)
    8974:	e9 1f 01 00 00       	jmp    8a98 <fwp_write+0x1228>
    8979:	89 fa                	mov    %edi,%edx
    897b:	83 e2 1f             	and    $0x1f,%edx
    897e:	48 89 c1             	mov    %rax,%rcx
    8981:	48 29 d1             	sub    %rdx,%rcx
    8984:	48 8d b4 24 80 00 00 	lea    0x80(%rsp),%rsi
    898b:	00 
    898c:	66 0f ef c0          	pxor   %xmm0,%xmm0
    8990:	49 89 c0             	mov    %rax,%r8
    8993:	f3 42 0f 6f 0c 04    	movdqu (%rsp,%r8,1),%xmm1
    8999:	f3 42 0f 6f 54 04 10 	movdqu 0x10(%rsp,%r8,1),%xmm2
    89a0:	66 0f 6f da          	movdqa %xmm2,%xmm3
    89a4:	66 0f 60 d8          	punpcklbw %xmm0,%xmm3
    89a8:	66 0f 70 db 4e       	pshufd $0x4e,%xmm3,%xmm3
    89ad:	f2 0f 70 db 1b       	pshuflw $0x1b,%xmm3,%xmm3
    89b2:	f3 0f 70 db 1b       	pshufhw $0x1b,%xmm3,%xmm3
    89b7:	66 0f 68 d0          	punpckhbw %xmm0,%xmm2
    89bb:	66 0f 70 d2 4e       	pshufd $0x4e,%xmm2,%xmm2
    89c0:	f2 0f 70 d2 1b       	pshuflw $0x1b,%xmm2,%xmm2
    89c5:	f3 0f 70 d2 1b       	pshufhw $0x1b,%xmm2,%xmm2
    89ca:	66 0f 67 d3          	packuswb %xmm3,%xmm2
    89ce:	66 0f 6f d9          	movdqa %xmm1,%xmm3
    89d2:	66 0f 60 d8          	punpcklbw %xmm0,%xmm3
    89d6:	66 0f 70 db 4e       	pshufd $0x4e,%xmm3,%xmm3
    89db:	f2 0f 70 db 1b       	pshuflw $0x1b,%xmm3,%xmm3
    89e0:	f3 0f 70 db 1b       	pshufhw $0x1b,%xmm3,%xmm3
    89e5:	66 0f 68 c8          	punpckhbw %xmm0,%xmm1
    89e9:	66 0f 70 c9 4e       	pshufd $0x4e,%xmm1,%xmm1
    89ee:	f2 0f 70 c9 1b       	pshuflw $0x1b,%xmm1,%xmm1
    89f3:	f3 0f 70 c9 1b       	pshufhw $0x1b,%xmm1,%xmm1
    89f8:	66 0f 67 cb          	packuswb %xmm3,%xmm1
    89fc:	66 0f 7f 56 f0       	movdqa %xmm2,-0x10(%rsi)
    8a01:	66 0f 7f 0e          	movdqa %xmm1,(%rsi)
    8a05:	49 83 c0 e0          	add    $0xffffffffffffffe0,%r8
    8a09:	48 83 c6 20          	add    $0x20,%rsi
    8a0d:	4c 39 c2             	cmp    %r8,%rdx
    8a10:	75 81                	jne    8993 <fwp_write+0x1123>
    8a12:	48 85 d2             	test   %rdx,%rdx
    8a15:	0f 84 78 00 00 00    	je     8a93 <fwp_write+0x1223>
    8a1b:	83 fa 08             	cmp    $0x8,%edx
    8a1e:	72 50                	jb     8a70 <fwp_write+0x1200>
    8a20:	89 fa                	mov    %edi,%edx
    8a22:	83 e2 07             	and    $0x7,%edx
    8a25:	48 89 c6             	mov    %rax,%rsi
    8a28:	48 29 ce             	sub    %rcx,%rsi
    8a2b:	48 8d 3c 0c          	lea    (%rsp,%rcx,1),%rdi
    8a2f:	48 83 c7 70          	add    $0x70,%rdi
    8a33:	48 89 c1             	mov    %rax,%rcx
    8a36:	48 29 d1             	sub    %rdx,%rcx
    8a39:	66 0f ef c0          	pxor   %xmm0,%xmm0
    8a3d:	f3 0f 7e 4c 34 18    	movq   0x18(%rsp,%rsi,1),%xmm1
    8a43:	66 0f 60 c8          	punpcklbw %xmm0,%xmm1
    8a47:	66 0f 70 c9 4e       	pshufd $0x4e,%xmm1,%xmm1
    8a4c:	f2 0f 70 c9 1b       	pshuflw $0x1b,%xmm1,%xmm1
    8a51:	f3 0f 70 c9 1b       	pshufhw $0x1b,%xmm1,%xmm1
    8a56:	66 0f 67 c9          	packuswb %xmm1,%xmm1
    8a5a:	66 0f d6 0f          	movq   %xmm1,(%rdi)
    8a5e:	48 83 c6 f8          	add    $0xfffffffffffffff8,%rsi
    8a62:	48 83 c7 08          	add    $0x8,%rdi
    8a66:	48 39 f2             	cmp    %rsi,%rdx
    8a69:	75 d2                	jne    8a3d <fwp_write+0x11cd>
    8a6b:	48 85 d2             	test   %rdx,%rdx
    8a6e:	74 23                	je     8a93 <fwp_write+0x1223>
    8a70:	48 8d 74 24 20       	lea    0x20(%rsp),%rsi
    8a75:	48 01 f2             	add    %rsi,%rdx
    8a78:	48 ff ca             	dec    %rdx
    8a7b:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)
    8a80:	0f b6 32             	movzbl (%rdx),%esi
    8a83:	40 88 74 0c 70       	mov    %sil,0x70(%rsp,%rcx,1)
    8a88:	48 ff c1             	inc    %rcx
    8a8b:	48 ff ca             	dec    %rdx
    8a8e:	48 39 c8             	cmp    %rcx,%rax
    8a91:	75 ed                	jne    8a80 <fwp_write+0x1210>
    8a93:	c6 44 04 70 00       	movb   $0x0,0x70(%rsp,%rax,1)
    8a98:	4c 8d 74 24 70       	lea    0x70(%rsp),%r14
    8a9d:	4c 89 f7             	mov    %r14,%rdi
    8aa0:	e8 3b 96 ff ff       	call   20e0 <strlen@plt>
    8aa5:	48 89 ef             	mov    %rbp,%rdi
    8aa8:	4c 89 f6             	mov    %r14,%rsi
    8aab:	48 89 c2             	mov    %rax,%rdx
    8aae:	e8 9d 01 00 00       	call   8c50 <buf_put>
    8ab3:	48 81 c4 78 02 00 00 	add    $0x278,%rsp
    8aba:	5b                   	pop    %rbx
    8abb:	41 5c                	pop    %r12
    8abd:	41 5d                	pop    %r13
    8abf:	41 5e                	pop    %r14
    8ac1:	41 5f                	pop    %r15
    8ac3:	5d                   	pop    %rbp
    8ac4:	c3                   	ret
    8ac5:	83 f8 20             	cmp    $0x20,%eax
    8ac8:	73 07                	jae    8ad1 <fwp_write+0x1261>
    8aca:	31 c9                	xor    %ecx,%ecx
    8acc:	e9 b6 00 00 00       	jmp    8b87 <fwp_write+0x1317>
    8ad1:	89 fe                	mov    %edi,%esi
    8ad3:	89 fa                	mov    %edi,%edx
    8ad5:	83 e2 1f             	and    $0x1f,%edx
    8ad8:	48 89 c1             	mov    %rax,%rcx
    8adb:	48 29 d1             	sub    %rdx,%rcx
    8ade:	4c 8d 04 34          	lea    (%rsp,%rsi,1),%r8
    8ae2:	49 83 c0 10          	add    $0x10,%r8
    8ae6:	48 29 d6             	sub    %rdx,%rsi
    8ae9:	45 31 c9             	xor    %r9d,%r9d
    8aec:	66 0f ef c0          	pxor   %xmm0,%xmm0
    8af0:	f3 41 0f 6f 48 f0    	movdqu -0x10(%r8),%xmm1
    8af6:	f3 41 0f 6f 10       	movdqu (%r8),%xmm2
    8afb:	66 0f 6f da          	movdqa %xmm2,%xmm3
    8aff:	66 0f 60 d8          	punpcklbw %xmm0,%xmm3
    8b03:	66 0f 70 db 4e       	pshufd $0x4e,%xmm3,%xmm3
    8b08:	f2 0f 70 db 1b       	pshuflw $0x1b,%xmm3,%xmm3
    8b0d:	f3 0f 70 db 1b       	pshufhw $0x1b,%xmm3,%xmm3
    8b12:	66 0f 68 d0          	punpckhbw %xmm0,%xmm2
    8b16:	66 0f 70 d2 4e       	pshufd $0x4e,%xmm2,%xmm2
    8b1b:	f2 0f 70 d2 1b       	pshuflw $0x1b,%xmm2,%xmm2
    8b20:	f3 0f 70 d2 1b       	pshufhw $0x1b,%xmm2,%xmm2
    8b25:	66 0f 67 d3          	packuswb %xmm3,%xmm2
    8b29:	66 0f 6f d9          	movdqa %xmm1,%xmm3
    8b2d:	66 0f 60 d8          	punpcklbw %xmm0,%xmm3
    8b31:	66 0f 70 db 4e       	pshufd $0x4e,%xmm3,%xmm3
    8b36:	f2 0f 70 db 1b       	pshuflw $0x1b,%xmm3,%xmm3
    8b3b:	f3 0f 70 db 1b       	pshufhw $0x1b,%xmm3,%xmm3
    8b40:	66 0f 68 c8          	punpckhbw %xmm0,%xmm1
    8b44:	66 0f 70 c9 4e       	pshufd $0x4e,%xmm1,%xmm1
    8b49:	f2 0f 70 c9 1b       	pshuflw $0x1b,%xmm1,%xmm1
    8b4e:	f3 0f 70 c9 1b       	pshufhw $0x1b,%xmm1,%xmm1
    8b53:	66 0f 67 cb          	packuswb %xmm3,%xmm1
    8b57:	f3 42 0f 7f 54 0c 71 	movdqu %xmm2,0x71(%rsp,%r9,1)
    8b5e:	f3 42 0f 7f 8c 0c 81 	movdqu %xmm1,0x81(%rsp,%r9,1)
    8b65:	00 00 00 
    8b68:	49 83 c1 20          	add    $0x20,%r9
    8b6c:	49 83 c0 e0          	add    $0xffffffffffffffe0,%r8
    8b70:	4c 39 ce             	cmp    %r9,%rsi
    8b73:	0f 85 77 ff ff ff    	jne    8af0 <fwp_write+0x1280>
    8b79:	48 85 d2             	test   %rdx,%rdx
    8b7c:	0f 84 91 00 00 00    	je     8c13 <fwp_write+0x13a3>
    8b82:	83 fa 08             	cmp    $0x8,%edx
    8b85:	72 60                	jb     8be7 <fwp_write+0x1377>
    8b87:	48 89 ce             	mov    %rcx,%rsi
    8b8a:	41 89 f8             	mov    %edi,%r8d
    8b8d:	89 fa                	mov    %edi,%edx
    8b8f:	83 e2 07             	and    $0x7,%edx
    8b92:	48 89 c1             	mov    %rax,%rcx
    8b95:	48 29 d1             	sub    %rdx,%rcx
    8b98:	49 89 f1             	mov    %rsi,%r9
    8b9b:	49 f7 d9             	neg    %r9
    8b9e:	49 01 e1             	add    %rsp,%r9
    8ba1:	49 83 c1 20          	add    $0x20,%r9
    8ba5:	4d 01 c1             	add    %r8,%r9
    8ba8:	49 83 c1 f8          	add    $0xfffffffffffffff8,%r9
    8bac:	49 29 d0             	sub    %rdx,%r8
    8baf:	66 0f ef c0          	pxor   %xmm0,%xmm0
    8bb3:	f3 41 0f 7e 09       	movq   (%r9),%xmm1
    8bb8:	66 0f 60 c8          	punpcklbw %xmm0,%xmm1
    8bbc:	66 0f 70 c9 4e       	pshufd $0x4e,%xmm1,%xmm1
    8bc1:	f2 0f 70 c9 1b       	pshuflw $0x1b,%xmm1,%xmm1
    8bc6:	f3 0f 70 c9 1b       	pshufhw $0x1b,%xmm1,%xmm1
    8bcb:	66 0f 67 c9          	packuswb %xmm1,%xmm1
    8bcf:	66 0f d6 4c 34 71    	movq   %xmm1,0x71(%rsp,%rsi,1)
    8bd5:	48 83 c6 08          	add    $0x8,%rsi
    8bd9:	49 83 c1 f8          	add    $0xfffffffffffffff8,%r9
    8bdd:	49 39 f0             	cmp    %rsi,%r8
    8be0:	75 d1                	jne    8bb3 <fwp_write+0x1343>
    8be2:	48 85 d2             	test   %rdx,%rdx
    8be5:	74 2c                	je     8c13 <fwp_write+0x13a3>
    8be7:	48 8d 74 24 20       	lea    0x20(%rsp),%rsi
    8bec:	48 01 f2             	add    %rsi,%rdx
    8bef:	48 ff ca             	dec    %rdx
    8bf2:	89 fe                	mov    %edi,%esi
    8bf4:	66 66 66 2e 0f 1f 84 	data16 data16 cs nopw 0x0(%rax,%rax,1)
    8bfb:	00 00 00 00 00 
    8c00:	0f b6 3a             	movzbl (%rdx),%edi
    8c03:	40 88 7c 0c 71       	mov    %dil,0x71(%rsp,%rcx,1)
    8c08:	48 ff c1             	inc    %rcx
    8c0b:	48 ff ca             	dec    %rdx
    8c0e:	48 39 ce             	cmp    %rcx,%rsi
    8c11:	75 ed                	jne    8c00 <fwp_write+0x1390>
    8c13:	c6 44 04 71 00       	movb   $0x0,0x71(%rsp,%rax,1)
    8c18:	e9 7b fe ff ff       	jmp    8a98 <fwp_write+0x1228>
    8c1d:	4c 8d 74 24 70       	lea    0x70(%rsp),%r14
    8c22:	4c 89 f7             	mov    %r14,%rdi
    8c25:	f2 0f 10 44 24 10    	movsd  0x10(%rsp),%xmm0
    8c2b:	be 09 00 00 00       	mov    $0x9,%esi
    8c30:	e8 7b 0d 00 00       	call   99b0 <fwp_format_g>
    8c35:	4c 89 f7             	mov    %r14,%rdi
    8c38:	e9 bf f8 ff ff       	jmp    84fc <fwp_write+0xc8c>
    8c3d:	c7 44 24 70 4e 61 4e 	movl   $0x4e614e,0x70(%rsp)
    8c44:	00 
    8c45:	e9 4e fe ff ff       	jmp    8a98 <fwp_write+0x1228>
    8c4a:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)

0000000000008c50 <buf_put>:
    8c50:	41 57                	push   %r15
    8c52:	41 56                	push   %r14
    8c54:	41 54                	push   %r12
    8c56:	53                   	push   %rbx
    8c57:	50                   	push   %rax
    8c58:	49 89 fe             	mov    %rdi,%r14
    8c5b:	48 8b 7f 08          	mov    0x8(%rdi),%rdi
    8c5f:	48 83 ff ff          	cmp    $0xffffffffffffffff,%rdi
    8c63:	0f 84 a2 00 00 00    	je     8d0b <buf_put+0xbb>
    8c69:	48 89 d3             	mov    %rdx,%rbx
    8c6c:	48 c7 c0 fe ff ff ff 	mov    $0xfffffffffffffffe,%rax
    8c73:	48 29 f8             	sub    %rdi,%rax
    8c76:	48 39 d0             	cmp    %rdx,%rax
    8c79:	0f 82 8c 00 00 00    	jb     8d0b <buf_put+0xbb>
    8c7f:	48 8d 04 3b          	lea    (%rbx,%rdi,1),%rax
    8c83:	48 ff c0             	inc    %rax
    8c86:	49 8b 4e 10          	mov    0x10(%r14),%rcx
    8c8a:	48 39 c8             	cmp    %rcx,%rax
    8c8d:	76 30                	jbe    8cbf <buf_put+0x6f>
    8c8f:	48 85 c9             	test   %rcx,%rcx
    8c92:	41 bf 40 00 00 00    	mov    $0x40,%r15d
    8c98:	4c 0f 45 f9          	cmovne %rcx,%r15
    8c9c:	49 89 f4             	mov    %rsi,%r12
    8c9f:	49 39 c7             	cmp    %rax,%r15
    8ca2:	73 23                	jae    8cc7 <buf_put+0x77>
    8ca4:	66 66 66 2e 0f 1f 84 	data16 data16 cs nopw 0x0(%rax,%rax,1)
    8cab:	00 00 00 00 00 
    8cb0:	4d 85 ff             	test   %r15,%r15
    8cb3:	78 0f                	js     8cc4 <buf_put+0x74>
    8cb5:	4d 01 ff             	add    %r15,%r15
    8cb8:	49 39 c7             	cmp    %rax,%r15
    8cbb:	72 f3                	jb     8cb0 <buf_put+0x60>
    8cbd:	eb 08                	jmp    8cc7 <buf_put+0x77>
    8cbf:	49 8b 06             	mov    (%r14),%rax
    8cc2:	eb 21                	jmp    8ce5 <buf_put+0x95>
    8cc4:	49 89 c7             	mov    %rax,%r15
    8cc7:	49 8b 3e             	mov    (%r14),%rdi
    8cca:	4c 89 fe             	mov    %r15,%rsi
    8ccd:	e8 3e 95 ff ff       	call   2210 <realloc@plt>
    8cd2:	48 85 c0             	test   %rax,%rax
    8cd5:	74 34                	je     8d0b <buf_put+0xbb>
    8cd7:	49 89 06             	mov    %rax,(%r14)
    8cda:	4d 89 7e 10          	mov    %r15,0x10(%r14)
    8cde:	49 8b 7e 08          	mov    0x8(%r14),%rdi
    8ce2:	4c 89 e6             	mov    %r12,%rsi
    8ce5:	48 01 c7             	add    %rax,%rdi
    8ce8:	48 89 da             	mov    %rbx,%rdx
    8ceb:	e8 f0 94 ff ff       	call   21e0 <memcpy@plt>
    8cf0:	49 03 5e 08          	add    0x8(%r14),%rbx
    8cf4:	49 89 5e 08          	mov    %rbx,0x8(%r14)
    8cf8:	49 8b 06             	mov    (%r14),%rax
    8cfb:	c6 04 18 00          	movb   $0x0,(%rax,%rbx,1)
    8cff:	48 83 c4 08          	add    $0x8,%rsp
    8d03:	5b                   	pop    %rbx
    8d04:	41 5c                	pop    %r12
    8d06:	41 5e                	pop    %r14
    8d08:	41 5f                	pop    %r15
    8d0a:	c3                   	ret
    8d0b:	48 8b 05 ce 92 00 00 	mov    0x92ce(%rip),%rax        # 11fe0 <stderr@GLIBC_2.2.5>
    8d12:	48 8b 08             	mov    (%rax),%rcx
    8d15:	48 8d 3d 1d 68 00 00 	lea    0x681d(%rip),%rdi        # f539 <fwp_segv.msg+0x2f9>
    8d1c:	be 13 00 00 00       	mov    $0x13,%esi
    8d21:	ba 01 00 00 00       	mov    $0x1,%edx
    8d26:	e8 75 95 ff ff       	call   22a0 <fwrite@plt>
    8d2b:	bf 66 00 00 00       	mov    $0x66,%edi
    8d30:	e8 5b 95 ff ff       	call   2290 <exit@plt>
    8d35:	66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
    8d3c:	00 00 00 00 

0000000000008d40 <fwp_escape>:
    8d40:	55                   	push   %rbp
    8d41:	41 57                	push   %r15
    8d43:	41 56                	push   %r14
    8d45:	41 55                	push   %r13
    8d47:	41 54                	push   %r12
    8d49:	53                   	push   %rbx
    8d4a:	48 83 ec 18          	sub    $0x18,%rsp
    8d4e:	49 89 d6             	mov    %rdx,%r14
    8d51:	49 89 f7             	mov    %rsi,%r15
    8d54:	48 89 fb             	mov    %rdi,%rbx
    8d57:	c6 04 24 22          	movb   $0x22,(%rsp)
    8d5b:	48 89 e6             	mov    %rsp,%rsi
    8d5e:	ba 01 00 00 00       	mov    $0x1,%edx
    8d63:	e8 e8 fe ff ff       	call   8c50 <buf_put>
    8d68:	4d 85 f6             	test   %r14,%r14
    8d6b:	0f 84 de 00 00 00    	je     8e4f <fwp_escape+0x10f>
    8d71:	48 89 e5             	mov    %rsp,%rbp
    8d74:	4c 8d 2d 51 64 00 00 	lea    0x6451(%rip),%r13        # f1cc <_IO_stdin_used+0x1cc>
    8d7b:	45 31 e4             	xor    %r12d,%r12d
    8d7e:	eb 21                	jmp    8da1 <fwp_escape+0x61>
    8d80:	ba 02 00 00 00       	mov    $0x2,%edx
    8d85:	48 89 df             	mov    %rbx,%rdi
    8d88:	48 8d 35 e1 68 00 00 	lea    0x68e1(%rip),%rsi        # f670 <fwp_segv.msg+0x430>
    8d8f:	90                   	nop
    8d90:	e8 bb fe ff ff       	call   8c50 <buf_put>
    8d95:	49 ff c4             	inc    %r12
    8d98:	4d 39 e6             	cmp    %r12,%r14
    8d9b:	0f 84 ae 00 00 00    	je     8e4f <fwp_escape+0x10f>
    8da1:	43 0f b6 04 27       	movzbl (%r15,%r12,1),%eax
    8da6:	0f b6 c8             	movzbl %al,%ecx
    8da9:	8d 51 f7             	lea    -0x9(%rcx),%edx
    8dac:	83 fa 19             	cmp    $0x19,%edx
    8daf:	77 1f                	ja     8dd0 <fwp_escape+0x90>
    8db1:	49 63 54 95 00       	movslq 0x0(%r13,%rdx,4),%rdx
    8db6:	4c 01 ea             	add    %r13,%rdx
    8db9:	ff e2                	jmp    *%rdx
    8dbb:	ba 02 00 00 00       	mov    $0x2,%edx
    8dc0:	48 89 df             	mov    %rbx,%rdi
    8dc3:	48 8d 35 a3 68 00 00 	lea    0x68a3(%rip),%rsi        # f66d <fwp_segv.msg+0x42d>
    8dca:	eb c4                	jmp    8d90 <fwp_escape+0x50>
    8dcc:	0f 1f 40 00          	nopl   0x0(%rax)
    8dd0:	83 f9 5c             	cmp    $0x5c,%ecx
    8dd3:	75 11                	jne    8de6 <fwp_escape+0xa6>
    8dd5:	ba 02 00 00 00       	mov    $0x2,%edx
    8dda:	48 89 df             	mov    %rbx,%rdi
    8ddd:	48 8d 35 83 68 00 00 	lea    0x6883(%rip),%rsi        # f667 <fwp_segv.msg+0x427>
    8de4:	eb aa                	jmp    8d90 <fwp_escape+0x50>
    8de6:	3c 20                	cmp    $0x20,%al
    8de8:	72 39                	jb     8e23 <fwp_escape+0xe3>
    8dea:	3c 7f                	cmp    $0x7f,%al
    8dec:	74 35                	je     8e23 <fwp_escape+0xe3>
    8dee:	88 04 24             	mov    %al,(%rsp)
    8df1:	ba 01 00 00 00       	mov    $0x1,%edx
    8df6:	48 89 df             	mov    %rbx,%rdi
    8df9:	48 89 ee             	mov    %rbp,%rsi
    8dfc:	eb 92                	jmp    8d90 <fwp_escape+0x50>
    8dfe:	ba 02 00 00 00       	mov    $0x2,%edx
    8e03:	48 89 df             	mov    %rbx,%rdi
    8e06:	48 8d 35 57 68 00 00 	lea    0x6857(%rip),%rsi        # f664 <fwp_segv.msg+0x424>
    8e0d:	eb 81                	jmp    8d90 <fwp_escape+0x50>
    8e0f:	ba 02 00 00 00       	mov    $0x2,%edx
    8e14:	48 89 df             	mov    %rbx,%rdi
    8e17:	48 8d 35 4c 68 00 00 	lea    0x684c(%rip),%rsi        # f66a <fwp_segv.msg+0x42a>
    8e1e:	e9 6d ff ff ff       	jmp    8d90 <fwp_escape+0x50>
    8e23:	be 10 00 00 00       	mov    $0x10,%esi
    8e28:	48 89 ef             	mov    %rbp,%rdi
    8e2b:	48 8d 15 41 68 00 00 	lea    0x6841(%rip),%rdx        # f673 <fwp_segv.msg+0x433>
    8e32:	31 c0                	xor    %eax,%eax
    8e34:	e8 d7 92 ff ff       	call   2110 <snprintf@plt>
    8e39:	48 89 ef             	mov    %rbp,%rdi
    8e3c:	e8 9f 92 ff ff       	call   20e0 <strlen@plt>
    8e41:	48 89 df             	mov    %rbx,%rdi
    8e44:	48 89 ee             	mov    %rbp,%rsi
    8e47:	48 89 c2             	mov    %rax,%rdx
    8e4a:	e9 41 ff ff ff       	jmp    8d90 <fwp_escape+0x50>
    8e4f:	c6 04 24 22          	movb   $0x22,(%rsp)
    8e53:	48 89 e6             	mov    %rsp,%rsi
    8e56:	ba 01 00 00 00       	mov    $0x1,%edx
    8e5b:	48 89 df             	mov    %rbx,%rdi
    8e5e:	e8 ed fd ff ff       	call   8c50 <buf_put>
    8e63:	48 83 c4 18          	add    $0x18,%rsp
    8e67:	5b                   	pop    %rbx
    8e68:	41 5c                	pop    %r12
    8e6a:	41 5d                	pop    %r13
    8e6c:	41 5e                	pop    %r14
    8e6e:	41 5f                	pop    %r15
    8e70:	5d                   	pop    %rbp
    8e71:	c3                   	ret
    8e72:	66 66 66 66 66 2e 0f 	data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    8e79:	1f 84 00 00 00 00 00 

0000000000008e80 <fwp_fmt_duration>:
    8e80:	41 57                	push   %r15
    8e82:	41 56                	push   %r14
    8e84:	41 54                	push   %r12
    8e86:	53                   	push   %rbx
    8e87:	48 81 ec 88 00 00 00 	sub    $0x88,%rsp
    8e8e:	48 89 f0             	mov    %rsi,%rax
    8e91:	48 09 d0             	or     %rdx,%rax
    8e94:	0f 84 bf 02 00 00    	je     9159 <fwp_fmt_duration+0x2d9>
    8e9a:	49 89 d0             	mov    %rdx,%r8
    8e9d:	48 b9 1d 3f c2 25 d6 	movabs $0xd2fe1d625c23f1d,%rcx
    8ea4:	e1 2f 0d 
    8ea7:	48 0f af ce          	imul   %rsi,%rcx
    8eab:	49 b9 0d b1 f3 e4 99 	movabs $0x1c52799e4f3b10d,%r9
    8eb2:	27 c5 01 
    8eb5:	48 89 f0             	mov    %rsi,%rax
    8eb8:	49 f7 e1             	mul    %r9
    8ebb:	48 01 ca             	add    %rcx,%rdx
    8ebe:	4d 0f af c8          	imul   %r8,%r9
    8ec2:	49 01 d1             	add    %rdx,%r9
    8ec5:	48 b9 00 a0 34 52 a3 	movabs $0x6baf6aa35234a000,%rcx
    8ecc:	6a af 6b 
    8ecf:	48 01 c1             	add    %rax,%rcx
    8ed2:	48 b8 37 f9 ff e2 04 	movabs $0x4e2fff937,%rax
    8ed9:	00 00 00 
    8edc:	4c 11 c8             	adc    %r9,%rax
    8edf:	48 89 c2             	mov    %rax,%rdx
    8ee2:	48 0f ac ca 0d       	shrd   $0xd,%rcx,%rdx
    8ee7:	48 0f a4 c8 33       	shld   $0x33,%rcx,%rax
    8eec:	48 b9 4a 23 35 aa f6 	movabs $0x9376baf6aa35234a,%rcx
    8ef3:	ba 76 93 
    8ef6:	48 39 c1             	cmp    %rax,%rcx
    8ef9:	b8 ff 2f 4e 00       	mov    $0x4e2fff,%eax
    8efe:	48 19 d0             	sbb    %rdx,%rax
    8f01:	0f 83 70 02 00 00    	jae    9177 <fwp_fmt_duration+0x2f7>
    8f07:	48 b9 b3 b2 61 36 8c 	movabs $0xc5ce3b8c3661b2b3,%rcx
    8f0e:	3b ce c5 
    8f11:	49 b9 c3 5f 47 6a 04 	movabs $0x1a8d52046a475fc3,%r9
    8f18:	52 8d 1a 
    8f1b:	48 89 f0             	mov    %rsi,%rax
    8f1e:	49 f7 e1             	mul    %r9
    8f21:	48 0f af ce          	imul   %rsi,%rcx
    8f25:	48 01 ca             	add    %rcx,%rdx
    8f28:	4d 0f af c8          	imul   %r8,%r9
    8f2c:	49 01 d1             	add    %rdx,%r9
    8f2f:	48 b9 00 a8 16 d1 91 	movabs $0x4f473f91d116a800,%rcx
    8f36:	3f 47 4f 
    8f39:	48 01 c1             	add    %rax,%rcx
    8f3c:	48 b8 3f 9a ff 4c 49 	movabs $0x494cff9a3f,%rax
    8f43:	00 00 00 
    8f46:	4c 11 c8             	adc    %r9,%rax
    8f49:	48 89 c2             	mov    %rax,%rdx
    8f4c:	48 0f ac ca 0b       	shrd   $0xb,%rcx,%rdx
    8f51:	48 0f a4 c8 35       	shld   $0x35,%rcx,%rax
    8f56:	48 b9 ab 45 74 e4 cf 	movabs $0x8fd3d1cfe47445ab,%rcx
    8f5d:	d1 d3 8f 
    8f60:	48 39 c8             	cmp    %rcx,%rax
    8f63:	48 81 da e6 3f 53 12 	sbb    $0x12533fe6,%rdx
    8f6a:	0f 82 27 02 00 00    	jb     9197 <fwp_fmt_duration+0x317>
    8f70:	48 b9 7e 78 b9 2f 37 	movabs $0x97157d372fb9787e,%rcx
    8f77:	7d 15 97 
    8f7a:	48 0f af ce          	imul   %rsi,%rcx
    8f7e:	49 b9 6d 9c 2e 3a 42 	movabs $0x8e47ce423a2e9c6d,%r9
    8f85:	ce 47 8e 
    8f88:	48 89 f0             	mov    %rsi,%rax
    8f8b:	49 f7 e1             	mul    %r9
    8f8e:	48 01 ca             	add    %rcx,%rdx
    8f91:	4d 0f af c8          	imul   %r8,%r9
    8f95:	49 01 d1             	add    %rdx,%r9
    8f98:	48 b9 00 46 54 40 8b 	movabs $0xa52cb98b40544600,%rcx
    8f9f:	b9 2c a5 
    8fa2:	48 01 c1             	add    %rax,%rcx
    8fa5:	48 b8 b5 09 fa 82 4b 	movabs $0x44b82fa09b5,%rax
    8fac:	04 00 00 
    8faf:	4c 11 c8             	adc    %r9,%rax
    8fb2:	48 89 c2             	mov    %rax,%rdx
    8fb5:	48 0f ac ca 09       	shrd   $0x9,%rcx,%rdx
    8fba:	48 0f a4 c8 37       	shld   $0x37,%rcx,%rax
    8fbf:	48 b9 47 54 40 8b b9 	movabs $0xb5a52cb98b405447,%rcx
    8fc6:	2c a5 b5 
    8fc9:	48 39 c8             	cmp    %rcx,%rax
    8fcc:	48 b8 09 fa 82 4b 04 	movabs $0x44b82fa09,%rax
    8fd3:	00 00 00 
    8fd6:	48 19 c2             	sbb    %rax,%rdx
    8fd9:	0f 82 0d 03 00 00    	jb     92ec <fwp_fmt_duration+0x46c>
    8fdf:	48 b9 cb d5 8f 4d f2 	movabs $0xc57e23f24d8fd5cb,%rcx
    8fe6:	23 7e c5 
    8fe9:	48 0f af ce          	imul   %rsi,%rcx
    8fed:	49 b9 39 61 c2 68 56 	movabs $0x790fb65668c26139,%r9
    8ff4:	b6 0f 79 
    8ff7:	48 89 f0             	mov    %rsi,%rax
    8ffa:	49 f7 e1             	mul    %r9
    8ffd:	48 01 ca             	add    %rcx,%rdx
    9000:	4d 0f af c8          	imul   %r8,%r9
    9004:	49 01 d1             	add    %rdx,%r9
    9007:	48 b9 00 0b 27 69 fe 	movabs $0xa6d698fe69270b00,%rcx
    900e:	98 d6 a6 
    9011:	48 01 c1             	add    %rax,%rcx
    9014:	48 b8 b1 bd 16 f4 de 	movabs $0x218def416bdb1,%rax
    901b:	18 02 00 
    901e:	4c 11 c8             	adc    %r9,%rax
    9021:	48 89 c2             	mov    %rax,%rdx
    9024:	48 0f ac ca 06       	shrd   $0x6,%rcx,%rdx
    9029:	48 0f a4 c8 3a       	shld   $0x3a,%rcx,%rax
    902e:	48 b9 59 38 49 f3 c7 	movabs $0x8d36b4c7f3493859,%rcx
    9035:	b4 36 8d 
    9038:	48 39 c8             	cmp    %rcx,%rax
    903b:	48 b8 ed b5 a0 f7 c6 	movabs $0x10c6f7a0b5ed,%rax
    9042:	10 00 00 
    9045:	48 19 c2             	sbb    %rax,%rdx
    9048:	0f 82 ad 02 00 00    	jb     92fb <fwp_fmt_duration+0x47b>
    904e:	48 b9 5a 64 3b df 4f 	movabs $0x6e978d4fdf3b645a,%rcx
    9055:	8d 97 6e 
    9058:	48 0f af ce          	imul   %rsi,%rcx
    905c:	49 b9 d5 78 e9 26 31 	movabs $0x1cac083126e978d5,%r9
    9063:	08 ac 1c 
    9066:	48 89 f0             	mov    %rsi,%rax
    9069:	49 f7 e1             	mul    %r9
    906c:	48 01 ca             	add    %rcx,%rdx
    906f:	4d 0f af c8          	imul   %r8,%r9
    9073:	49 01 d1             	add    %rdx,%r9
    9076:	48 b9 48 62 10 58 39 	movabs $0x76c8b43958106248,%rcx
    907d:	b4 c8 76 
    9080:	48 01 c1             	add    %rax,%rcx
    9083:	48 b8 be 9f 1a 2f dd 	movabs $0x10624dd2f1a9fbe,%rax
    908a:	24 06 01 
    908d:	4c 11 c8             	adc    %r9,%rax
    9090:	48 89 c2             	mov    %rax,%rdx
    9093:	48 0f ac ca 03       	shrd   $0x3,%rcx,%rdx
    9098:	48 0f a4 c8 3d       	shld   $0x3d,%rcx,%rax
    909d:	48 b9 93 18 04 56 0e 	movabs $0x9db22d0e56041893,%rcx
    90a4:	2d b2 9d 
    90a7:	48 39 c8             	cmp    %rcx,%rax
    90aa:	48 b8 ef a7 c6 4b 37 	movabs $0x4189374bc6a7ef,%rax
    90b1:	89 41 00 
    90b4:	48 19 c2             	sbb    %rax,%rdx
    90b7:	0f 82 4d 02 00 00    	jb     930a <fwp_fmt_duration+0x48a>
    90bd:	4d 85 c0             	test   %r8,%r8
    90c0:	0f 88 d6 06 00 00    	js     979c <fwp_fmt_duration+0x91c>
    90c6:	45 31 d2             	xor    %r10d,%r10d
    90c9:	49 bb cd cc cc cc cc 	movabs $0xcccccccccccccccd,%r11
    90d0:	cc cc cc 
    90d3:	48 bb cc cc cc cc cc 	movabs $0xcccccccccccccccc,%rbx
    90da:	cc cc cc 
    90dd:	4d 89 c6             	mov    %r8,%r14
    90e0:	4c 89 c1             	mov    %r8,%rcx
    90e3:	48 0f a4 f1 3f       	shld   $0x3f,%rsi,%rcx
    90e8:	49 d1 ee             	shr    $1,%r14
    90eb:	49 89 c9             	mov    %rcx,%r9
    90ee:	4d 01 f1             	add    %r14,%r9
    90f1:	49 83 d1 00          	adc    $0x0,%r9
    90f5:	4c 89 c8             	mov    %r9,%rax
    90f8:	49 f7 e3             	mul    %r11
    90fb:	48 c1 ea 02          	shr    $0x2,%rdx
    90ff:	48 8d 04 92          	lea    (%rdx,%rdx,4),%rax
    9103:	49 29 c1             	sub    %rax,%r9
    9106:	4c 29 c9             	sub    %r9,%rcx
    9109:	49 83 de 00          	sbb    $0x0,%r14
    910d:	49 89 c9             	mov    %rcx,%r9
    9110:	4c 0f af cb          	imul   %rbx,%r9
    9114:	48 89 c8             	mov    %rcx,%rax
    9117:	49 f7 e3             	mul    %r11
    911a:	4c 01 ca             	add    %r9,%rdx
    911d:	4d 0f af f3          	imul   %r11,%r14
    9121:	49 01 d6             	add    %rdx,%r14
    9124:	48 89 c1             	mov    %rax,%rcx
    9127:	48 01 c1             	add    %rax,%rcx
    912a:	48 8d 0c 89          	lea    (%rcx,%rcx,4),%rcx
    912e:	89 f2                	mov    %esi,%edx
    9130:	29 ca                	sub    %ecx,%edx
    9132:	80 ca 30             	or     $0x30,%dl
    9135:	42 88 54 14 40       	mov    %dl,0x40(%rsp,%r10,1)
    913a:	49 ff c2             	inc    %r10
    913d:	48 83 fe 0a          	cmp    $0xa,%rsi
    9141:	49 83 d8 00          	sbb    $0x0,%r8
    9145:	48 89 c6             	mov    %rax,%rsi
    9148:	4d 89 f0             	mov    %r14,%r8
    914b:	73 93                	jae    90e0 <fwp_fmt_duration+0x260>
    914d:	45 85 d2             	test   %r10d,%r10d
    9150:	7f 12                	jg     9164 <fwp_fmt_duration+0x2e4>
    9152:	31 c0                	xor    %eax,%eax
    9154:	e9 79 01 00 00       	jmp    92d2 <fwp_fmt_duration+0x452>
    9159:	c6 44 24 40 30       	movb   $0x30,0x40(%rsp)
    915e:	41 ba 01 00 00 00    	mov    $0x1,%r10d
    9164:	44 89 d0             	mov    %r10d,%eax
    9167:	48 83 f8 08          	cmp    $0x8,%rax
    916b:	73 1e                	jae    918b <fwp_fmt_duration+0x30b>
    916d:	31 c9                	xor    %ecx,%ecx
    916f:	48 89 c2             	mov    %rax,%rdx
    9172:	e9 3d 01 00 00       	jmp    92b4 <fwp_fmt_duration+0x434>
    9177:	49 89 fe             	mov    %rdi,%r14
    917a:	48 ba 00 a0 b8 30 46 	movabs $0x34630b8a000,%rdx
    9181:	03 00 00 
    9184:	31 c0                	xor    %eax,%eax
    9186:	e9 8c 01 00 00       	jmp    9317 <fwp_fmt_duration+0x497>
    918b:	83 f8 20             	cmp    $0x20,%eax
    918e:	73 1e                	jae    91ae <fwp_fmt_duration+0x32e>
    9190:	31 c9                	xor    %ecx,%ecx
    9192:	e9 c3 00 00 00       	jmp    925a <fwp_fmt_duration+0x3da>
    9197:	49 89 fe             	mov    %rdi,%r14
    919a:	48 ba 00 58 47 f8 0d 	movabs $0xdf8475800,%rdx
    91a1:	00 00 00 
    91a4:	b8 01 00 00 00       	mov    $0x1,%eax
    91a9:	e9 69 01 00 00       	jmp    9317 <fwp_fmt_duration+0x497>
    91ae:	44 89 d2             	mov    %r10d,%edx
    91b1:	83 e2 1f             	and    $0x1f,%edx
    91b4:	48 89 c1             	mov    %rax,%rcx
    91b7:	48 29 d1             	sub    %rdx,%rcx
    91ba:	48 8d 74 24 10       	lea    0x10(%rsp),%rsi
    91bf:	66 0f ef c0          	pxor   %xmm0,%xmm0
    91c3:	49 89 c0             	mov    %rax,%r8
    91c6:	66 2e 0f 1f 84 00 00 	cs nopw 0x0(%rax,%rax,1)
    91cd:	00 00 00 
    91d0:	f3 42 0f 6f 4c 04 20 	movdqu 0x20(%rsp,%r8,1),%xmm1
    91d7:	f3 42 0f 6f 54 04 30 	movdqu 0x30(%rsp,%r8,1),%xmm2
    91de:	66 0f 6f da          	movdqa %xmm2,%xmm3
    91e2:	66 0f 60 d8          	punpcklbw %xmm0,%xmm3
    91e6:	66 0f 70 db 4e       	pshufd $0x4e,%xmm3,%xmm3
    91eb:	f2 0f 70 db 1b       	pshuflw $0x1b,%xmm3,%xmm3
    91f0:	f3 0f 70 db 1b       	pshufhw $0x1b,%xmm3,%xmm3
    91f5:	66 0f 68 d0          	punpckhbw %xmm0,%xmm2
    91f9:	66 0f 70 d2 4e       	pshufd $0x4e,%xmm2,%xmm2
    91fe:	f2 0f 70 d2 1b       	pshuflw $0x1b,%xmm2,%xmm2
    9203:	f3 0f 70 d2 1b       	pshufhw $0x1b,%xmm2,%xmm2
    9208:	66 0f 67 d3          	packuswb %xmm3,%xmm2
    920c:	66 0f 6f d9          	movdqa %xmm1,%xmm3
    9210:	66 0f 60 d8          	punpcklbw %xmm0,%xmm3
    9214:	66 0f 70 db 4e       	pshufd $0x4e,%xmm3,%xmm3
    9219:	f2 0f 70 db 1b       	pshuflw $0x1b,%xmm3,%xmm3
    921e:	f3 0f 70 db 1b       	pshufhw $0x1b,%xmm3,%xmm3
    9223:	66 0f 68 c8          	punpckhbw %xmm0,%xmm1
    9227:	66 0f 70 c9 4e       	pshufd $0x4e,%xmm1,%xmm1
    922c:	f2 0f 70 c9 1b       	pshuflw $0x1b,%xmm1,%xmm1
    9231:	f3 0f 70 c9 1b       	pshufhw $0x1b,%xmm1,%xmm1
    9236:	66 0f 67 cb          	packuswb %xmm3,%xmm1
    923a:	66 0f 7f 56 f0       	movdqa %xmm2,-0x10(%rsi)
    923f:	66 0f 7f 0e          	movdqa %xmm1,(%rsi)
    9243:	49 83 c0 e0          	add    $0xffffffffffffffe0,%r8
    9247:	48 83 c6 20          	add    $0x20,%rsi
    924b:	4c 39 c2             	cmp    %r8,%rdx
    924e:	75 80                	jne    91d0 <fwp_fmt_duration+0x350>
    9250:	48 85 d2             	test   %rdx,%rdx
    9253:	74 7d                	je     92d2 <fwp_fmt_duration+0x452>
    9255:	83 fa 08             	cmp    $0x8,%edx
    9258:	72 5a                	jb     92b4 <fwp_fmt_duration+0x434>
    925a:	44 89 d2             	mov    %r10d,%edx
    925d:	83 e2 07             	and    $0x7,%edx
    9260:	48 89 c6             	mov    %rax,%rsi
    9263:	48 29 ce             	sub    %rcx,%rsi
    9266:	4c 8d 04 0c          	lea    (%rsp,%rcx,1),%r8
    926a:	48 89 c1             	mov    %rax,%rcx
    926d:	48 29 d1             	sub    %rdx,%rcx
    9270:	66 0f ef c0          	pxor   %xmm0,%xmm0
    9274:	66 66 66 2e 0f 1f 84 	data16 data16 cs nopw 0x0(%rax,%rax,1)
    927b:	00 00 00 00 00 
    9280:	f3 0f 7e 4c 34 38    	movq   0x38(%rsp,%rsi,1),%xmm1
    9286:	66 0f 60 c8          	punpcklbw %xmm0,%xmm1
    928a:	66 0f 70 c9 4e       	pshufd $0x4e,%xmm1,%xmm1
    928f:	f2 0f 70 c9 1b       	pshuflw $0x1b,%xmm1,%xmm1
    9294:	f3 0f 70 c9 1b       	pshufhw $0x1b,%xmm1,%xmm1
    9299:	66 0f 67 c9          	packuswb %xmm1,%xmm1
    929d:	66 41 0f d6 08       	movq   %xmm1,(%r8)
    92a2:	48 83 c6 f8          	add    $0xfffffffffffffff8,%rsi
    92a6:	49 83 c0 08          	add    $0x8,%r8
    92aa:	48 39 f2             	cmp    %rsi,%rdx
    92ad:	75 d1                	jne    9280 <fwp_fmt_duration+0x400>
    92af:	48 85 d2             	test   %rdx,%rdx
    92b2:	74 1e                	je     92d2 <fwp_fmt_duration+0x452>
    92b4:	48 8d 74 24 40       	lea    0x40(%rsp),%rsi
    92b9:	48 01 f2             	add    %rsi,%rdx
    92bc:	48 ff ca             	dec    %rdx
    92bf:	90                   	nop
    92c0:	0f b6 32             	movzbl (%rdx),%esi
    92c3:	40 88 34 0c          	mov    %sil,(%rsp,%rcx,1)
    92c7:	48 ff c1             	inc    %rcx
    92ca:	48 ff ca             	dec    %rdx
    92cd:	48 39 c8             	cmp    %rcx,%rax
    92d0:	75 ee                	jne    92c0 <fwp_fmt_duration+0x440>
    92d2:	c6 04 04 00          	movb   $0x0,(%rsp,%rax,1)
    92d6:	48 8d 35 a9 63 00 00 	lea    0x63a9(%rip),%rsi        # f686 <fwp_segv.msg+0x446>
    92dd:	48 89 e2             	mov    %rsp,%rdx
    92e0:	31 c0                	xor    %eax,%eax
    92e2:	e8 99 8f ff ff       	call   2280 <sprintf@plt>
    92e7:	e9 a1 04 00 00       	jmp    978d <fwp_fmt_duration+0x90d>
    92ec:	49 89 fe             	mov    %rdi,%r14
    92ef:	ba 00 ca 9a 3b       	mov    $0x3b9aca00,%edx
    92f4:	b8 02 00 00 00       	mov    $0x2,%eax
    92f9:	eb 1c                	jmp    9317 <fwp_fmt_duration+0x497>
    92fb:	49 89 fe             	mov    %rdi,%r14
    92fe:	ba 40 42 0f 00       	mov    $0xf4240,%edx
    9303:	b8 03 00 00 00       	mov    $0x3,%eax
    9308:	eb 0d                	jmp    9317 <fwp_fmt_duration+0x497>
    930a:	49 89 fe             	mov    %rdi,%r14
    930d:	ba e8 03 00 00       	mov    $0x3e8,%edx
    9312:	b8 04 00 00 00       	mov    $0x4,%eax
    9317:	31 c9                	xor    %ecx,%ecx
    9319:	c1 e0 04             	shl    $0x4,%eax
    931c:	48 8d 1d 4d 8a 00 00 	lea    0x8a4d(%rip),%rbx        # 11d70 <fwp_fmt_duration.units>
    9323:	48 01 c3             	add    %rax,%rbx
    9326:	48 89 f7             	mov    %rsi,%rdi
    9329:	4c 89 c6             	mov    %r8,%rsi
    932c:	e8 5f 4c 00 00       	call   df90 <__divti3>
    9331:	48 89 c1             	mov    %rax,%rcx
    9334:	48 89 d6             	mov    %rdx,%rsi
    9337:	48 85 d2             	test   %rdx,%rdx
    933a:	0f 88 b0 00 00 00    	js     93f0 <fwp_fmt_duration+0x570>
    9340:	48 89 c8             	mov    %rcx,%rax
    9343:	48 09 f0             	or     %rsi,%rax
    9346:	0f 84 61 01 00 00    	je     94ad <fwp_fmt_duration+0x62d>
    934c:	45 31 d2             	xor    %r10d,%r10d
    934f:	49 bb cd cc cc cc cc 	movabs $0xcccccccccccccccd,%r11
    9356:	cc cc cc 
    9359:	49 bf cc cc cc cc cc 	movabs $0xcccccccccccccccc,%r15
    9360:	cc cc cc 
    9363:	49 89 f4             	mov    %rsi,%r12
    9366:	4c 89 f7             	mov    %r14,%rdi
    9369:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)
    9370:	49 89 f0             	mov    %rsi,%r8
    9373:	49 0f a4 c8 3f       	shld   $0x3f,%rcx,%r8
    9378:	49 d1 ec             	shr    $1,%r12
    937b:	4d 89 c1             	mov    %r8,%r9
    937e:	4d 01 e1             	add    %r12,%r9
    9381:	49 83 d1 00          	adc    $0x0,%r9
    9385:	4c 89 c8             	mov    %r9,%rax
    9388:	49 f7 e3             	mul    %r11
    938b:	48 c1 ea 02          	shr    $0x2,%rdx
    938f:	48 8d 04 92          	lea    (%rdx,%rdx,4),%rax
    9393:	49 29 c1             	sub    %rax,%r9
    9396:	4d 29 c8             	sub    %r9,%r8
    9399:	49 83 dc 00          	sbb    $0x0,%r12
    939d:	4d 89 c1             	mov    %r8,%r9
    93a0:	4d 0f af cf          	imul   %r15,%r9
    93a4:	4c 89 c0             	mov    %r8,%rax
    93a7:	49 f7 e3             	mul    %r11
    93aa:	4c 01 ca             	add    %r9,%rdx
    93ad:	4d 0f af e3          	imul   %r11,%r12
    93b1:	49 01 d4             	add    %rdx,%r12
    93b4:	48 89 c2             	mov    %rax,%rdx
    93b7:	48 01 c2             	add    %rax,%rdx
    93ba:	48 8d 14 92          	lea    (%rdx,%rdx,4),%rdx
    93be:	41 89 c8             	mov    %ecx,%r8d
    93c1:	41 29 d0             	sub    %edx,%r8d
    93c4:	41 80 c8 30          	or     $0x30,%r8b
    93c8:	46 88 44 14 40       	mov    %r8b,0x40(%rsp,%r10,1)
    93cd:	49 ff c2             	inc    %r10
    93d0:	48 83 f9 0a          	cmp    $0xa,%rcx
    93d4:	48 83 de 00          	sbb    $0x0,%rsi
    93d8:	48 89 c1             	mov    %rax,%rcx
    93db:	4c 89 e6             	mov    %r12,%rsi
    93de:	73 90                	jae    9370 <fwp_fmt_duration+0x4f0>
    93e0:	45 85 d2             	test   %r10d,%r10d
    93e3:	0f 8f d2 00 00 00    	jg     94bb <fwp_fmt_duration+0x63b>
    93e9:	31 c0                	xor    %eax,%eax
    93eb:	e9 12 02 00 00       	jmp    9602 <fwp_fmt_duration+0x782>
    93f0:	45 31 c0             	xor    %r8d,%r8d
    93f3:	48 f7 d9             	neg    %rcx
    93f6:	41 b9 00 00 00 00    	mov    $0x0,%r9d
    93fc:	49 19 f1             	sbb    %rsi,%r9
    93ff:	c6 04 24 2d          	movb   $0x2d,(%rsp)
    9403:	49 ba cd cc cc cc cc 	movabs $0xcccccccccccccccd,%r10
    940a:	cc cc cc 
    940d:	49 bb cc cc cc cc cc 	movabs $0xcccccccccccccccc,%r11
    9414:	cc cc cc 
    9417:	4d 89 cf             	mov    %r9,%r15
    941a:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)
    9420:	4c 89 ce             	mov    %r9,%rsi
    9423:	48 0f a4 ce 3f       	shld   $0x3f,%rcx,%rsi
    9428:	49 d1 ef             	shr    $1,%r15
    942b:	48 89 f7             	mov    %rsi,%rdi
    942e:	4c 01 ff             	add    %r15,%rdi
    9431:	48 83 d7 00          	adc    $0x0,%rdi
    9435:	48 89 f8             	mov    %rdi,%rax
    9438:	49 f7 e2             	mul    %r10
    943b:	48 c1 ea 02          	shr    $0x2,%rdx
    943f:	48 8d 04 92          	lea    (%rdx,%rdx,4),%rax
    9443:	48 29 c7             	sub    %rax,%rdi
    9446:	48 29 fe             	sub    %rdi,%rsi
    9449:	49 83 df 00          	sbb    $0x0,%r15
    944d:	48 89 f7             	mov    %rsi,%rdi
    9450:	49 0f af fb          	imul   %r11,%rdi
    9454:	48 89 f0             	mov    %rsi,%rax
    9457:	49 f7 e2             	mul    %r10
    945a:	48 01 fa             	add    %rdi,%rdx
    945d:	4d 0f af fa          	imul   %r10,%r15
    9461:	49 01 d7             	add    %rdx,%r15
    9464:	48 89 c2             	mov    %rax,%rdx
    9467:	48 01 c2             	add    %rax,%rdx
    946a:	48 8d 14 92          	lea    (%rdx,%rdx,4),%rdx
    946e:	89 ce                	mov    %ecx,%esi
    9470:	29 d6                	sub    %edx,%esi
    9472:	40 80 ce 30          	or     $0x30,%sil
    9476:	42 88 74 04 40       	mov    %sil,0x40(%rsp,%r8,1)
    947b:	49 ff c0             	inc    %r8
    947e:	48 83 f9 0a          	cmp    $0xa,%rcx
    9482:	49 83 d9 00          	sbb    $0x0,%r9
    9486:	48 89 c1             	mov    %rax,%rcx
    9489:	4d 89 f9             	mov    %r15,%r9
    948c:	73 92                	jae    9420 <fwp_fmt_duration+0x5a0>
    948e:	45 85 c0             	test   %r8d,%r8d
    9491:	4c 89 f7             	mov    %r14,%rdi
    9494:	7e 44                	jle    94da <fwp_fmt_duration+0x65a>
    9496:	44 89 c0             	mov    %r8d,%eax
    9499:	48 83 f8 08          	cmp    $0x8,%rax
    949d:	0f 83 68 01 00 00    	jae    960b <fwp_fmt_duration+0x78b>
    94a3:	31 c9                	xor    %ecx,%ecx
    94a5:	48 89 c2             	mov    %rax,%rdx
    94a8:	e9 97 02 00 00       	jmp    9744 <fwp_fmt_duration+0x8c4>
    94ad:	c6 44 24 40 30       	movb   $0x30,0x40(%rsp)
    94b2:	41 ba 01 00 00 00    	mov    $0x1,%r10d
    94b8:	4c 89 f7             	mov    %r14,%rdi
    94bb:	44 89 d0             	mov    %r10d,%eax
    94be:	48 83 f8 08          	cmp    $0x8,%rax
    94c2:	73 0a                	jae    94ce <fwp_fmt_duration+0x64e>
    94c4:	31 c9                	xor    %ecx,%ecx
    94c6:	48 89 c2             	mov    %rax,%rdx
    94c9:	e9 16 01 00 00       	jmp    95e4 <fwp_fmt_duration+0x764>
    94ce:	83 f8 20             	cmp    $0x20,%eax
    94d1:	73 0e                	jae    94e1 <fwp_fmt_duration+0x661>
    94d3:	31 c9                	xor    %ecx,%ecx
    94d5:	e9 b0 00 00 00       	jmp    958a <fwp_fmt_duration+0x70a>
    94da:	31 c0                	xor    %eax,%eax
    94dc:	e9 93 02 00 00       	jmp    9774 <fwp_fmt_duration+0x8f4>
    94e1:	44 89 d2             	mov    %r10d,%edx
    94e4:	83 e2 1f             	and    $0x1f,%edx
    94e7:	48 89 c1             	mov    %rax,%rcx
    94ea:	48 29 d1             	sub    %rdx,%rcx
    94ed:	48 8d 74 24 10       	lea    0x10(%rsp),%rsi
    94f2:	66 0f ef c0          	pxor   %xmm0,%xmm0
    94f6:	49 89 c0             	mov    %rax,%r8
    94f9:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)
    9500:	f3 42 0f 6f 4c 04 20 	movdqu 0x20(%rsp,%r8,1),%xmm1
    9507:	f3 42 0f 6f 54 04 30 	movdqu 0x30(%rsp,%r8,1),%xmm2
    950e:	66 0f 6f da          	movdqa %xmm2,%xmm3
    9512:	66 0f 60 d8          	punpcklbw %xmm0,%xmm3
    9516:	66 0f 70 db 4e       	pshufd $0x4e,%xmm3,%xmm3
    951b:	f2 0f 70 db 1b       	pshuflw $0x1b,%xmm3,%xmm3
    9520:	f3 0f 70 db 1b       	pshufhw $0x1b,%xmm3,%xmm3
    9525:	66 0f 68 d0          	punpckhbw %xmm0,%xmm2
    9529:	66 0f 70 d2 4e       	pshufd $0x4e,%xmm2,%xmm2
    952e:	f2 0f 70 d2 1b       	pshuflw $0x1b,%xmm2,%xmm2
    9533:	f3 0f 70 d2 1b       	pshufhw $0x1b,%xmm2,%xmm2
    9538:	66 0f 67 d3          	packuswb %xmm3,%xmm2
    953c:	66 0f 6f d9          	movdqa %xmm1,%xmm3
    9540:	66 0f 60 d8          	punpcklbw %xmm0,%xmm3
    9544:	66 0f 70 db 4e       	pshufd $0x4e,%xmm3,%xmm3
    9549:	f2 0f 70 db 1b       	pshuflw $0x1b,%xmm3,%xmm3
    954e:	f3 0f 70 db 1b       	pshufhw $0x1b,%xmm3,%xmm3
    9553:	66 0f 68 c8          	punpckhbw %xmm0,%xmm1
    9557:	66 0f 70 c9 4e       	pshufd $0x4e,%xmm1,%xmm1
    955c:	f2 0f 70 c9 1b       	pshuflw $0x1b,%xmm1,%xmm1
    9561:	f3 0f 70 c9 1b       	pshufhw $0x1b,%xmm1,%xmm1
    9566:	66 0f 67 cb          	packuswb %xmm3,%xmm1
    956a:	66 0f 7f 56 f0       	movdqa %xmm2,-0x10(%rsi)
    956f:	66 0f 7f 0e          	movdqa %xmm1,(%rsi)
    9573:	49 83 c0 e0          	add    $0xffffffffffffffe0,%r8
    9577:	48 83 c6 20          	add    $0x20,%rsi
    957b:	4c 39 c2             	cmp    %r8,%rdx
    957e:	75 80                	jne    9500 <fwp_fmt_duration+0x680>
    9580:	48 85 d2             	test   %rdx,%rdx
    9583:	74 7d                	je     9602 <fwp_fmt_duration+0x782>
    9585:	83 fa 08             	cmp    $0x8,%edx
    9588:	72 5a                	jb     95e4 <fwp_fmt_duration+0x764>
    958a:	44 89 d2             	mov    %r10d,%edx
    958d:	83 e2 07             	and    $0x7,%edx
    9590:	48 89 c6             	mov    %rax,%rsi
    9593:	48 29 ce             	sub    %rcx,%rsi
    9596:	4c 8d 04 0c          	lea    (%rsp,%rcx,1),%r8
    959a:	48 89 c1             	mov    %rax,%rcx
    959d:	48 29 d1             	sub    %rdx,%rcx
    95a0:	66 0f ef c0          	pxor   %xmm0,%xmm0
    95a4:	66 66 66 2e 0f 1f 84 	data16 data16 cs nopw 0x0(%rax,%rax,1)
    95ab:	00 00 00 00 00 
    95b0:	f3 0f 7e 4c 34 38    	movq   0x38(%rsp,%rsi,1),%xmm1
    95b6:	66 0f 60 c8          	punpcklbw %xmm0,%xmm1
    95ba:	66 0f 70 c9 4e       	pshufd $0x4e,%xmm1,%xmm1
    95bf:	f2 0f 70 c9 1b       	pshuflw $0x1b,%xmm1,%xmm1
    95c4:	f3 0f 70 c9 1b       	pshufhw $0x1b,%xmm1,%xmm1
    95c9:	66 0f 67 c9          	packuswb %xmm1,%xmm1
    95cd:	66 41 0f d6 08       	movq   %xmm1,(%r8)
    95d2:	48 83 c6 f8          	add    $0xfffffffffffffff8,%rsi
    95d6:	49 83 c0 08          	add    $0x8,%r8
    95da:	48 39 f2             	cmp    %rsi,%rdx
    95dd:	75 d1                	jne    95b0 <fwp_fmt_duration+0x730>
    95df:	48 85 d2             	test   %rdx,%rdx
    95e2:	74 1e                	je     9602 <fwp_fmt_duration+0x782>
    95e4:	48 8d 74 24 40       	lea    0x40(%rsp),%rsi
    95e9:	48 01 f2             	add    %rsi,%rdx
    95ec:	48 ff ca             	dec    %rdx
    95ef:	90                   	nop
    95f0:	0f b6 32             	movzbl (%rdx),%esi
    95f3:	40 88 34 0c          	mov    %sil,(%rsp,%rcx,1)
    95f7:	48 ff c1             	inc    %rcx
    95fa:	48 ff ca             	dec    %rdx
    95fd:	48 39 c8             	cmp    %rcx,%rax
    9600:	75 ee                	jne    95f0 <fwp_fmt_duration+0x770>
    9602:	c6 04 04 00          	movb   $0x0,(%rsp,%rax,1)
    9606:	e9 6e 01 00 00       	jmp    9779 <fwp_fmt_duration+0x8f9>
    960b:	83 f8 20             	cmp    $0x20,%eax
    960e:	73 07                	jae    9617 <fwp_fmt_duration+0x797>
    9610:	31 c9                	xor    %ecx,%ecx
    9612:	e9 bd 00 00 00       	jmp    96d4 <fwp_fmt_duration+0x854>
    9617:	44 89 c6             	mov    %r8d,%esi
    961a:	44 89 c2             	mov    %r8d,%edx
    961d:	83 e2 1f             	and    $0x1f,%edx
    9620:	48 89 c1             	mov    %rax,%rcx
    9623:	48 29 d1             	sub    %rdx,%rcx
    9626:	4c 8d 0c 34          	lea    (%rsp,%rsi,1),%r9
    962a:	49 83 c1 30          	add    $0x30,%r9
    962e:	48 29 d6             	sub    %rdx,%rsi
    9631:	45 31 d2             	xor    %r10d,%r10d
    9634:	66 0f ef c0          	pxor   %xmm0,%xmm0
    9638:	0f 1f 84 00 00 00 00 	nopl   0x0(%rax,%rax,1)
    963f:	00 
    9640:	f3 41 0f 6f 49 f0    	movdqu -0x10(%r9),%xmm1
    9646:	f3 41 0f 6f 11       	movdqu (%r9),%xmm2
    964b:	66 0f 6f da          	movdqa %xmm2,%xmm3
    964f:	66 0f 60 d8          	punpcklbw %xmm0,%xmm3
    9653:	66 0f 70 db 4e       	pshufd $0x4e,%xmm3,%xmm3
    9658:	f2 0f 70 db 1b       	pshuflw $0x1b,%xmm3,%xmm3
    965d:	f3 0f 70 db 1b       	pshufhw $0x1b,%xmm3,%xmm3
    9662:	66 0f 68 d0          	punpckhbw %xmm0,%xmm2
    9666:	66 0f 70 d2 4e       	pshufd $0x4e,%xmm2,%xmm2
    966b:	f2 0f 70 d2 1b       	pshuflw $0x1b,%xmm2,%xmm2
    9670:	f3 0f 70 d2 1b       	pshufhw $0x1b,%xmm2,%xmm2
    9675:	66 0f 67 d3          	packuswb %xmm3,%xmm2
    9679:	66 0f 6f d9          	movdqa %xmm1,%xmm3
    967d:	66 0f 60 d8          	punpcklbw %xmm0,%xmm3
    9681:	66 0f 70 db 4e       	pshufd $0x4e,%xmm3,%xmm3
    9686:	f2 0f 70 db 1b       	pshuflw $0x1b,%xmm3,%xmm3
    968b:	f3 0f 70 db 1b       	pshufhw $0x1b,%xmm3,%xmm3
    9690:	66 0f 68 c8          	punpckhbw %xmm0,%xmm1
    9694:	66 0f 70 c9 4e       	pshufd $0x4e,%xmm1,%xmm1
    9699:	f2 0f 70 c9 1b       	pshuflw $0x1b,%xmm1,%xmm1
    969e:	f3 0f 70 c9 1b       	pshufhw $0x1b,%xmm1,%xmm1
    96a3:	66 0f 67 cb          	packuswb %xmm3,%xmm1
    96a7:	f3 42 0f 7f 54 14 01 	movdqu %xmm2,0x1(%rsp,%r10,1)
    96ae:	f3 42 0f 7f 4c 14 11 	movdqu %xmm1,0x11(%rsp,%r10,1)
    96b5:	49 83 c2 20          	add    $0x20,%r10
    96b9:	49 83 c1 e0          	add    $0xffffffffffffffe0,%r9
    96bd:	4c 39 d6             	cmp    %r10,%rsi
    96c0:	0f 85 7a ff ff ff    	jne    9640 <fwp_fmt_duration+0x7c0>
    96c6:	48 85 d2             	test   %rdx,%rdx
    96c9:	0f 84 a5 00 00 00    	je     9774 <fwp_fmt_duration+0x8f4>
    96cf:	83 fa 08             	cmp    $0x8,%edx
    96d2:	72 70                	jb     9744 <fwp_fmt_duration+0x8c4>
    96d4:	48 89 ce             	mov    %rcx,%rsi
    96d7:	45 89 c1             	mov    %r8d,%r9d
    96da:	44 89 c2             	mov    %r8d,%edx
    96dd:	83 e2 07             	and    $0x7,%edx
    96e0:	48 89 c1             	mov    %rax,%rcx
    96e3:	48 29 d1             	sub    %rdx,%rcx
    96e6:	49 89 f2             	mov    %rsi,%r10
    96e9:	49 f7 da             	neg    %r10
    96ec:	49 01 e2             	add    %rsp,%r10
    96ef:	49 83 c2 40          	add    $0x40,%r10
    96f3:	4d 01 ca             	add    %r9,%r10
    96f6:	49 83 c2 f8          	add    $0xfffffffffffffff8,%r10
    96fa:	49 29 d1             	sub    %rdx,%r9
    96fd:	66 0f ef c0          	pxor   %xmm0,%xmm0
    9701:	66 66 66 66 66 66 2e 	data16 data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    9708:	0f 1f 84 00 00 00 00 
    970f:	00 
    9710:	f3 41 0f 7e 0a       	movq   (%r10),%xmm1
    9715:	66 0f 60 c8          	punpcklbw %xmm0,%xmm1
    9719:	66 0f 70 c9 4e       	pshufd $0x4e,%xmm1,%xmm1
    971e:	f2 0f 70 c9 1b       	pshuflw $0x1b,%xmm1,%xmm1
    9723:	f3 0f 70 c9 1b       	pshufhw $0x1b,%xmm1,%xmm1
    9728:	66 0f 67 c9          	packuswb %xmm1,%xmm1
    972c:	66 0f d6 4c 34 01    	movq   %xmm1,0x1(%rsp,%rsi,1)
    9732:	48 83 c6 08          	add    $0x8,%rsi
    9736:	49 83 c2 f8          	add    $0xfffffffffffffff8,%r10
    973a:	49 39 f1             	cmp    %rsi,%r9
    973d:	75 d1                	jne    9710 <fwp_fmt_duration+0x890>
    973f:	48 85 d2             	test   %rdx,%rdx
    9742:	74 30                	je     9774 <fwp_fmt_duration+0x8f4>
    9744:	48 8d 74 24 40       	lea    0x40(%rsp),%rsi
    9749:	48 01 f2             	add    %rsi,%rdx
    974c:	48 ff ca             	dec    %rdx
    974f:	44 89 c6             	mov    %r8d,%esi
    9752:	66 66 66 66 66 2e 0f 	data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    9759:	1f 84 00 00 00 00 00 
    9760:	44 0f b6 02          	movzbl (%rdx),%r8d
    9764:	44 88 44 0c 01       	mov    %r8b,0x1(%rsp,%rcx,1)
    9769:	48 ff c1             	inc    %rcx
    976c:	48 ff ca             	dec    %rdx
    976f:	48 39 ce             	cmp    %rcx,%rsi
    9772:	75 ec                	jne    9760 <fwp_fmt_duration+0x8e0>
    9774:	c6 44 04 01 00       	movb   $0x0,0x1(%rsp,%rax,1)
    9779:	48 8b 0b             	mov    (%rbx),%rcx
    977c:	48 8d 35 fe 5e 00 00 	lea    0x5efe(%rip),%rsi        # f681 <fwp_segv.msg+0x441>
    9783:	48 89 e2             	mov    %rsp,%rdx
    9786:	31 c0                	xor    %eax,%eax
    9788:	e8 f3 8a ff ff       	call   2280 <sprintf@plt>
    978d:	48 81 c4 88 00 00 00 	add    $0x88,%rsp
    9794:	5b                   	pop    %rbx
    9795:	41 5c                	pop    %r12
    9797:	41 5e                	pop    %r14
    9799:	41 5f                	pop    %r15
    979b:	c3                   	ret
    979c:	45 31 c9             	xor    %r9d,%r9d
    979f:	48 f7 de             	neg    %rsi
    97a2:	41 ba 00 00 00 00    	mov    $0x0,%r10d
    97a8:	4d 19 c2             	sbb    %r8,%r10
    97ab:	c6 04 24 2d          	movb   $0x2d,(%rsp)
    97af:	49 bb cd cc cc cc cc 	movabs $0xcccccccccccccccd,%r11
    97b6:	cc cc cc 
    97b9:	48 bb cc cc cc cc cc 	movabs $0xcccccccccccccccc,%rbx
    97c0:	cc cc cc 
    97c3:	4d 89 d6             	mov    %r10,%r14
    97c6:	66 2e 0f 1f 84 00 00 	cs nopw 0x0(%rax,%rax,1)
    97cd:	00 00 00 
    97d0:	4c 89 d1             	mov    %r10,%rcx
    97d3:	48 0f a4 f1 3f       	shld   $0x3f,%rsi,%rcx
    97d8:	49 d1 ee             	shr    $1,%r14
    97db:	49 89 c8             	mov    %rcx,%r8
    97de:	4d 01 f0             	add    %r14,%r8
    97e1:	49 83 d0 00          	adc    $0x0,%r8
    97e5:	4c 89 c0             	mov    %r8,%rax
    97e8:	49 f7 e3             	mul    %r11
    97eb:	48 c1 ea 02          	shr    $0x2,%rdx
    97ef:	48 8d 04 92          	lea    (%rdx,%rdx,4),%rax
    97f3:	49 29 c0             	sub    %rax,%r8
    97f6:	4c 29 c1             	sub    %r8,%rcx
    97f9:	49 83 de 00          	sbb    $0x0,%r14
    97fd:	49 89 c8             	mov    %rcx,%r8
    9800:	4c 0f af c3          	imul   %rbx,%r8
    9804:	48 89 c8             	mov    %rcx,%rax
    9807:	49 f7 e3             	mul    %r11
    980a:	4c 01 c2             	add    %r8,%rdx
    980d:	4d 0f af f3          	imul   %r11,%r14
    9811:	49 01 d6             	add    %rdx,%r14
    9814:	48 89 c1             	mov    %rax,%rcx
    9817:	48 01 c1             	add    %rax,%rcx
    981a:	48 8d 0c 89          	lea    (%rcx,%rcx,4),%rcx
    981e:	89 f2                	mov    %esi,%edx
    9820:	29 ca                	sub    %ecx,%edx
    9822:	80 ca 30             	or     $0x30,%dl
    9825:	42 88 54 0c 40       	mov    %dl,0x40(%rsp,%r9,1)
    982a:	49 ff c1             	inc    %r9
    982d:	48 83 fe 0a          	cmp    $0xa,%rsi
    9831:	49 83 da 00          	sbb    $0x0,%r10
    9835:	48 89 c6             	mov    %rax,%rsi
    9838:	4d 89 f2             	mov    %r14,%r10
    983b:	73 93                	jae    97d0 <fwp_fmt_duration+0x950>
    983d:	45 85 c9             	test   %r9d,%r9d
    9840:	7e 13                	jle    9855 <fwp_fmt_duration+0x9d5>
    9842:	44 89 c8             	mov    %r9d,%eax
    9845:	48 83 f8 08          	cmp    $0x8,%rax
    9849:	73 11                	jae    985c <fwp_fmt_duration+0x9dc>
    984b:	31 c9                	xor    %ecx,%ecx
    984d:	48 89 c2             	mov    %rax,%rdx
    9850:	e9 29 01 00 00       	jmp    997e <fwp_fmt_duration+0xafe>
    9855:	31 c0                	xor    %eax,%eax
    9857:	e9 48 01 00 00       	jmp    99a4 <fwp_fmt_duration+0xb24>
    985c:	83 f8 20             	cmp    $0x20,%eax
    985f:	73 07                	jae    9868 <fwp_fmt_duration+0x9e8>
    9861:	31 c9                	xor    %ecx,%ecx
    9863:	e9 b5 00 00 00       	jmp    991d <fwp_fmt_duration+0xa9d>
    9868:	44 89 ce             	mov    %r9d,%esi
    986b:	44 89 ca             	mov    %r9d,%edx
    986e:	83 e2 1f             	and    $0x1f,%edx
    9871:	48 89 c1             	mov    %rax,%rcx
    9874:	48 29 d1             	sub    %rdx,%rcx
    9877:	4c 8d 04 34          	lea    (%rsp,%rsi,1),%r8
    987b:	49 83 c0 30          	add    $0x30,%r8
    987f:	48 29 d6             	sub    %rdx,%rsi
    9882:	45 31 d2             	xor    %r10d,%r10d
    9885:	66 0f ef c0          	pxor   %xmm0,%xmm0
    9889:	f3 41 0f 6f 48 f0    	movdqu -0x10(%r8),%xmm1
    988f:	f3 41 0f 6f 10       	movdqu (%r8),%xmm2
    9894:	66 0f 6f da          	movdqa %xmm2,%xmm3
    9898:	66 0f 60 d8          	punpcklbw %xmm0,%xmm3
    989c:	66 0f 70 db 4e       	pshufd $0x4e,%xmm3,%xmm3
    98a1:	f2 0f 70 db 1b       	pshuflw $0x1b,%xmm3,%xmm3
    98a6:	f3 0f 70 db 1b       	pshufhw $0x1b,%xmm3,%xmm3
    98ab:	66 0f 68 d0          	punpckhbw %xmm0,%xmm2
    98af:	66 0f 70 d2 4e       	pshufd $0x4e,%xmm2,%xmm2
    98b4:	f2 0f 70 d2 1b       	pshuflw $0x1b,%xmm2,%xmm2
    98b9:	f3 0f 70 d2 1b       	pshufhw $0x1b,%xmm2,%xmm2
    98be:	66 0f 67 d3          	packuswb %xmm3,%xmm2
    98c2:	66 0f 6f d9          	movdqa %xmm1,%xmm3
    98c6:	66 0f 60 d8          	punpcklbw %xmm0,%xmm3
    98ca:	66 0f 70 db 4e       	pshufd $0x4e,%xmm3,%xmm3
    98cf:	f2 0f 70 db 1b       	pshuflw $0x1b,%xmm3,%xmm3
    98d4:	f3 0f 70 db 1b       	pshufhw $0x1b,%xmm3,%xmm3
    98d9:	66 0f 68 c8          	punpckhbw %xmm0,%xmm1
    98dd:	66 0f 70 c9 4e       	pshufd $0x4e,%xmm1,%xmm1
    98e2:	f2 0f 70 c9 1b       	pshuflw $0x1b,%xmm1,%xmm1
    98e7:	f3 0f 70 c9 1b       	pshufhw $0x1b,%xmm1,%xmm1
    98ec:	66 0f 67 cb          	packuswb %xmm3,%xmm1
    98f0:	f3 42 0f 7f 54 14 01 	movdqu %xmm2,0x1(%rsp,%r10,1)
    98f7:	f3 42 0f 7f 4c 14 11 	movdqu %xmm1,0x11(%rsp,%r10,1)
    98fe:	49 83 c2 20          	add    $0x20,%r10
    9902:	49 83 c0 e0          	add    $0xffffffffffffffe0,%r8
    9906:	4c 39 d6             	cmp    %r10,%rsi
    9909:	0f 85 7a ff ff ff    	jne    9889 <fwp_fmt_duration+0xa09>
    990f:	48 85 d2             	test   %rdx,%rdx
    9912:	0f 84 8c 00 00 00    	je     99a4 <fwp_fmt_duration+0xb24>
    9918:	83 fa 08             	cmp    $0x8,%edx
    991b:	72 61                	jb     997e <fwp_fmt_duration+0xafe>
    991d:	48 89 ce             	mov    %rcx,%rsi
    9920:	45 89 c8             	mov    %r9d,%r8d
    9923:	44 89 ca             	mov    %r9d,%edx
    9926:	83 e2 07             	and    $0x7,%edx
    9929:	48 89 c1             	mov    %rax,%rcx
    992c:	48 29 d1             	sub    %rdx,%rcx
    992f:	49 89 f2             	mov    %rsi,%r10
    9932:	49 f7 da             	neg    %r10
    9935:	49 01 e2             	add    %rsp,%r10
    9938:	49 83 c2 40          	add    $0x40,%r10
    993c:	4d 01 c2             	add    %r8,%r10
    993f:	49 83 c2 f8          	add    $0xfffffffffffffff8,%r10
    9943:	49 29 d0             	sub    %rdx,%r8
    9946:	66 0f ef c0          	pxor   %xmm0,%xmm0
    994a:	f3 41 0f 7e 0a       	movq   (%r10),%xmm1
    994f:	66 0f 60 c8          	punpcklbw %xmm0,%xmm1
    9953:	66 0f 70 c9 4e       	pshufd $0x4e,%xmm1,%xmm1
    9958:	f2 0f 70 c9 1b       	pshuflw $0x1b,%xmm1,%xmm1
    995d:	f3 0f 70 c9 1b       	pshufhw $0x1b,%xmm1,%xmm1
    9962:	66 0f 67 c9          	packuswb %xmm1,%xmm1
    9966:	66 0f d6 4c 34 01    	movq   %xmm1,0x1(%rsp,%rsi,1)
    996c:	48 83 c6 08          	add    $0x8,%rsi
    9970:	49 83 c2 f8          	add    $0xfffffffffffffff8,%r10
    9974:	49 39 f0             	cmp    %rsi,%r8
    9977:	75 d1                	jne    994a <fwp_fmt_duration+0xaca>
    9979:	48 85 d2             	test   %rdx,%rdx
    997c:	74 26                	je     99a4 <fwp_fmt_duration+0xb24>
    997e:	48 8d 74 24 40       	lea    0x40(%rsp),%rsi
    9983:	48 01 f2             	add    %rsi,%rdx
    9986:	48 ff ca             	dec    %rdx
    9989:	44 89 ce             	mov    %r9d,%esi
    998c:	0f 1f 40 00          	nopl   0x0(%rax)
    9990:	44 0f b6 02          	movzbl (%rdx),%r8d
    9994:	44 88 44 0c 01       	mov    %r8b,0x1(%rsp,%rcx,1)
    9999:	48 ff c1             	inc    %rcx
    999c:	48 ff ca             	dec    %rdx
    999f:	48 39 ce             	cmp    %rcx,%rsi
    99a2:	75 ec                	jne    9990 <fwp_fmt_duration+0xb10>
    99a4:	c6 44 04 01 00       	movb   $0x0,0x1(%rsp,%rax,1)
    99a9:	e9 28 f9 ff ff       	jmp    92d6 <fwp_fmt_duration+0x456>
    99ae:	66 90                	xchg   %ax,%ax

00000000000099b0 <fwp_format_g>:
    99b0:	55                   	push   %rbp
    99b1:	41 57                	push   %r15
    99b3:	41 56                	push   %r14
    99b5:	41 55                	push   %r13
    99b7:	41 54                	push   %r12
    99b9:	53                   	push   %rbx
    99ba:	48 81 ec 98 00 00 00 	sub    $0x98,%rsp
    99c1:	89 f5                	mov    %esi,%ebp
    99c3:	48 89 fb             	mov    %rdi,%rbx
    99c6:	ff cd                	dec    %ebp
    99c8:	48 8d 15 7e 5c 00 00 	lea    0x5c7e(%rip),%rdx        # f64d <fwp_segv.msg+0x40d>
    99cf:	4c 8d 64 24 50       	lea    0x50(%rsp),%r12
    99d4:	be 40 00 00 00       	mov    $0x40,%esi
    99d9:	4c 89 e7             	mov    %r12,%rdi
    99dc:	89 e9                	mov    %ebp,%ecx
    99de:	f2 0f 11 44 24 08    	movsd  %xmm0,0x8(%rsp)
    99e4:	b0 01                	mov    $0x1,%al
    99e6:	e8 25 87 ff ff       	call   2110 <snprintf@plt>
    99eb:	4c 89 e7             	mov    %r12,%rdi
    99ee:	be 65 00 00 00       	mov    $0x65,%esi
    99f3:	e8 08 87 ff ff       	call   2100 <strchr@plt>
    99f8:	49 89 c7             	mov    %rax,%r15
    99fb:	48 8d 78 01          	lea    0x1(%rax),%rdi
    99ff:	45 31 ed             	xor    %r13d,%r13d
    9a02:	31 f6                	xor    %esi,%esi
    9a04:	ba 0a 00 00 00       	mov    $0xa,%edx
    9a09:	e8 c2 87 ff ff       	call   21d0 <strtol@plt>
    9a0e:	49 89 c6             	mov    %rax,%r14
    9a11:	83 c0 ef             	add    $0xffffffef,%eax
    9a14:	83 f8 e9             	cmp    $0xffffffe9,%eax
    9a17:	77 5f                	ja     9a78 <fwp_format_g+0xc8>
    9a19:	4d 29 e7             	sub    %r12,%r15
    9a1c:	4c 8d 6c 24 10       	lea    0x10(%rsp),%r13
    9a21:	4c 89 ef             	mov    %r13,%rdi
    9a24:	4c 89 e6             	mov    %r12,%rsi
    9a27:	4c 89 fa             	mov    %r15,%rdx
    9a2a:	e8 b1 87 ff ff       	call   21e0 <memcpy@plt>
    9a2f:	42 c6 44 3c 10 00    	movb   $0x0,0x10(%rsp,%r15,1)
    9a35:	4c 89 ef             	mov    %r13,%rdi
    9a38:	be 2e 00 00 00       	mov    $0x2e,%esi
    9a3d:	e8 be 86 ff ff       	call   2100 <strchr@plt>
    9a42:	48 85 c0             	test   %rax,%rax
    9a45:	0f 84 a8 00 00 00    	je     9af3 <fwp_format_g+0x143>
    9a4b:	4d 85 ff             	test   %r15,%r15
    9a4e:	0f 84 9f 00 00 00    	je     9af3 <fwp_format_g+0x143>
    9a54:	66 66 66 2e 0f 1f 84 	data16 data16 cs nopw 0x0(%rax,%rax,1)
    9a5b:	00 00 00 00 00 
    9a60:	42 0f b6 44 3c 0f    	movzbl 0xf(%rsp,%r15,1),%eax
    9a66:	83 f8 30             	cmp    $0x30,%eax
    9a69:	75 7d                	jne    9ae8 <fwp_format_g+0x138>
    9a6b:	42 c6 44 3c 0f 00    	movb   $0x0,0xf(%rsp,%r15,1)
    9a71:	49 ff cf             	dec    %r15
    9a74:	75 ea                	jne    9a60 <fwp_format_g+0xb0>
    9a76:	eb 7b                	jmp    9af3 <fwp_format_g+0x143>
    9a78:	44 29 f5             	sub    %r14d,%ebp
    9a7b:	85 ed                	test   %ebp,%ebp
    9a7d:	44 0f 4f ed          	cmovg  %ebp,%r13d
    9a81:	48 8d 15 d4 5b 00 00 	lea    0x5bd4(%rip),%rdx        # f65c <fwp_segv.msg+0x41c>
    9a88:	be 90 01 00 00       	mov    $0x190,%esi
    9a8d:	48 89 df             	mov    %rbx,%rdi
    9a90:	44 89 e9             	mov    %r13d,%ecx
    9a93:	f2 0f 10 44 24 08    	movsd  0x8(%rsp),%xmm0
    9a99:	b0 01                	mov    $0x1,%al
    9a9b:	e8 70 86 ff ff       	call   2110 <snprintf@plt>
    9aa0:	48 89 df             	mov    %rbx,%rdi
    9aa3:	e8 38 86 ff ff       	call   20e0 <strlen@plt>
    9aa8:	49 89 c6             	mov    %rax,%r14
    9aab:	48 89 df             	mov    %rbx,%rdi
    9aae:	be 2e 00 00 00       	mov    $0x2e,%esi
    9ab3:	e8 48 86 ff ff       	call   2100 <strchr@plt>
    9ab8:	48 85 c0             	test   %rax,%rax
    9abb:	74 69                	je     9b26 <fwp_format_g+0x176>
    9abd:	4d 85 f6             	test   %r14,%r14
    9ac0:	74 64                	je     9b26 <fwp_format_g+0x176>
    9ac2:	66 66 66 66 66 2e 0f 	data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    9ac9:	1f 84 00 00 00 00 00 
    9ad0:	42 0f b6 44 33 ff    	movzbl -0x1(%rbx,%r14,1),%eax
    9ad6:	83 f8 30             	cmp    $0x30,%eax
    9ad9:	75 5d                	jne    9b38 <fwp_format_g+0x188>
    9adb:	42 c6 44 33 ff 00    	movb   $0x0,-0x1(%rbx,%r14,1)
    9ae1:	49 ff ce             	dec    %r14
    9ae4:	75 ea                	jne    9ad0 <fwp_format_g+0x120>
    9ae6:	eb 3e                	jmp    9b26 <fwp_format_g+0x176>
    9ae8:	83 f8 2e             	cmp    $0x2e,%eax
    9aeb:	75 06                	jne    9af3 <fwp_format_g+0x143>
    9aed:	42 c6 44 3c 0f 00    	movb   $0x0,0xf(%rsp,%r15,1)
    9af3:	44 89 f0             	mov    %r14d,%eax
    9af6:	c1 e8 1f             	shr    $0x1f,%eax
    9af9:	44 8d 04 45 2b 00 00 	lea    0x2b(,%rax,2),%r8d
    9b00:	00 
    9b01:	45 89 f1             	mov    %r14d,%r9d
    9b04:	41 f7 d9             	neg    %r9d
    9b07:	45 0f 48 ce          	cmovs  %r14d,%r9d
    9b0b:	48 8d 15 40 5b 00 00 	lea    0x5b40(%rip),%rdx        # f652 <fwp_segv.msg+0x412>
    9b12:	48 8d 4c 24 10       	lea    0x10(%rsp),%rcx
    9b17:	be 90 01 00 00       	mov    $0x190,%esi
    9b1c:	48 89 df             	mov    %rbx,%rdi
    9b1f:	31 c0                	xor    %eax,%eax
    9b21:	e8 ea 85 ff ff       	call   2110 <snprintf@plt>
    9b26:	48 81 c4 98 00 00 00 	add    $0x98,%rsp
    9b2d:	5b                   	pop    %rbx
    9b2e:	41 5c                	pop    %r12
    9b30:	41 5d                	pop    %r13
    9b32:	41 5e                	pop    %r14
    9b34:	41 5f                	pop    %r15
    9b36:	5d                   	pop    %rbp
    9b37:	c3                   	ret
    9b38:	83 f8 2e             	cmp    $0x2e,%eax
    9b3b:	75 e9                	jne    9b26 <fwp_format_g+0x176>
    9b3d:	42 c6 44 33 ff 00    	movb   $0x0,-0x1(%rbx,%r14,1)
    9b43:	eb e1                	jmp    9b26 <fwp_format_g+0x176>
    9b45:	66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
    9b4c:	00 00 00 00 

0000000000009b50 <fwp_show_i64>:
    9b50:	41 57                	push   %r15
    9b52:	41 56                	push   %r14
    9b54:	53                   	push   %rbx
    9b55:	48 83 ec 20          	sub    $0x20,%rsp
    9b59:	48 be 00 00 00 00 01 	movabs $0x100000000,%rsi
    9b60:	00 00 00 
    9b63:	48 89 f9             	mov    %rdi,%rcx
    9b66:	48 f7 d9             	neg    %rcx
    9b69:	48 0f 48 cf          	cmovs  %rdi,%rcx
    9b6d:	48 8d 5c 24 18       	lea    0x18(%rsp),%rbx
    9b72:	4c 8d 44 24 17       	lea    0x17(%rsp),%r8
    9b77:	45 31 f6             	xor    %r14d,%r14d
    9b7a:	49 b9 cd cc cc cc cc 	movabs $0xcccccccccccccccd,%r9
    9b81:	cc cc cc 
    9b84:	66 66 66 2e 0f 1f 84 	data16 data16 cs nopw 0x0(%rax,%rax,1)
    9b8b:	00 00 00 00 00 
    9b90:	48 89 c8             	mov    %rcx,%rax
    9b93:	49 f7 e1             	mul    %r9
    9b96:	48 c1 ea 03          	shr    $0x3,%rdx
    9b9a:	8d 04 12             	lea    (%rdx,%rdx,1),%eax
    9b9d:	8d 04 80             	lea    (%rax,%rax,4),%eax
    9ba0:	41 89 ca             	mov    %ecx,%r10d
    9ba3:	41 29 c2             	sub    %eax,%r10d
    9ba6:	41 80 ca 30          	or     $0x30,%r10b
    9baa:	45 88 10             	mov    %r10b,(%r8)
    9bad:	49 01 f6             	add    %rsi,%r14
    9bb0:	49 ff c8             	dec    %r8
    9bb3:	48 83 f9 09          	cmp    $0x9,%rcx
    9bb7:	48 89 d1             	mov    %rdx,%rcx
    9bba:	77 d4                	ja     9b90 <fwp_show_i64+0x40>
    9bbc:	48 85 ff             	test   %rdi,%rdi
    9bbf:	78 06                	js     9bc7 <fwp_show_i64+0x77>
    9bc1:	49 c1 fe 20          	sar    $0x20,%r14
    9bc5:	eb 11                	jmp    9bd8 <fwp_show_i64+0x88>
    9bc7:	49 01 f6             	add    %rsi,%r14
    9bca:	49 c1 fe 20          	sar    $0x20,%r14
    9bce:	48 89 e0             	mov    %rsp,%rax
    9bd1:	4c 29 f0             	sub    %r14,%rax
    9bd4:	c6 40 18 2d          	movb   $0x2d,0x18(%rax)
    9bd8:	49 8d 56 09          	lea    0x9(%r14),%rdx
    9bdc:	48 81 fa 00 40 00 00 	cmp    $0x4000,%rdx
    9be3:	77 61                	ja     9c46 <fwp_show_i64+0xf6>
    9be5:	49 8d 4e 18          	lea    0x18(%r14),%rcx
    9be9:	48 c1 e9 04          	shr    $0x4,%rcx
    9bed:	48 8d 05 8c 85 00 00 	lea    0x858c(%rip),%rax        # 12180 <fwp_gc>
    9bf4:	0f b6 b4 01 e8 0b 00 	movzbl 0xbe8(%rcx,%rax,1),%esi
    9bfb:	00 
    9bfc:	8b 8c b0 48 0b 00 00 	mov    0xb48(%rax,%rsi,4),%ecx
    9c03:	48 29 0d 76 85 00 00 	sub    %rcx,0x8576(%rip)        # 12180 <fwp_gc>
    9c0a:	78 3a                	js     9c46 <fwp_show_i64+0xf6>
    9c0c:	48 8d 34 76          	lea    (%rsi,%rsi,2),%rsi
    9c10:	48 8d 3c f0          	lea    (%rax,%rsi,8),%rdi
    9c14:	48 81 c7 c8 03 00 00 	add    $0x3c8,%rdi
    9c1b:	4c 8b 3f             	mov    (%rdi),%r15
    9c1e:	4d 85 ff             	test   %r15,%r15
    9c21:	74 0b                	je     9c2e <fwp_show_i64+0xde>
    9c23:	49 8b 07             	mov    (%r15),%rax
    9c26:	48 f7 d0             	not    %rax
    9c29:	48 89 07             	mov    %rax,(%rdi)
    9c2c:	eb 3a                	jmp    9c68 <fwp_show_i64+0x118>
    9c2e:	4c 8b bc f0 d0 03 00 	mov    0x3d0(%rax,%rsi,8),%r15
    9c35:	00 
    9c36:	48 8b bc f0 d8 03 00 	mov    0x3d8(%rax,%rsi,8),%rdi
    9c3d:	00 
    9c3e:	4c 29 ff             	sub    %r15,%rdi
    9c41:	48 39 cf             	cmp    %rcx,%rdi
    9c44:	73 12                	jae    9c58 <fwp_show_i64+0x108>
    9c46:	48 89 d7             	mov    %rdx,%rdi
    9c49:	be 01 00 00 00       	mov    $0x1,%esi
    9c4e:	e8 ed ca ff ff       	call   6740 <fwp_gc_alloc_slow>
    9c53:	49 89 c7             	mov    %rax,%r15
    9c56:	eb 1a                	jmp    9c72 <fwp_show_i64+0x122>
    9c58:	48 8d 04 f0          	lea    (%rax,%rsi,8),%rax
    9c5c:	48 05 d0 03 00 00    	add    $0x3d0,%rax
    9c62:	4c 01 f9             	add    %r15,%rcx
    9c65:	48 89 08             	mov    %rcx,(%rax)
    9c68:	4c 89 ff             	mov    %r15,%rdi
    9c6b:	31 f6                	xor    %esi,%esi
    9c6d:	e8 be 84 ff ff       	call   2130 <memset@plt>
    9c72:	4c 29 f3             	sub    %r14,%rbx
    9c75:	4d 89 37             	mov    %r14,(%r15)
    9c78:	49 8d 7f 08          	lea    0x8(%r15),%rdi
    9c7c:	48 89 de             	mov    %rbx,%rsi
    9c7f:	4c 89 f2             	mov    %r14,%rdx
    9c82:	e8 59 85 ff ff       	call   21e0 <memcpy@plt>
    9c87:	43 c6 44 37 08 00    	movb   $0x0,0x8(%r15,%r14,1)
    9c8d:	4c 89 f8             	mov    %r15,%rax
    9c90:	48 83 c4 20          	add    $0x20,%rsp
    9c94:	5b                   	pop    %rbx
    9c95:	41 5e                	pop    %r14
    9c97:	41 5f                	pop    %r15
    9c99:	c3                   	ret
    9c9a:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)

0000000000009ca0 <fwp_p_array_get_typed>:
    9ca0:	48 85 ff             	test   %rdi,%rdi
    9ca3:	78 3e                	js     9ce3 <fwp_p_array_get_typed+0x43>
    9ca5:	48 8b 0e             	mov    (%rsi),%rcx
    9ca8:	48 b8 ff ff ff ff ff 	movabs $0x7fffffffffffffff,%rax
    9caf:	ff ff 7f 
    9cb2:	48 21 c8             	and    %rcx,%rax
    9cb5:	48 39 f8             	cmp    %rdi,%rax
    9cb8:	76 29                	jbe    9ce3 <fwp_p_array_get_typed+0x43>
    9cba:	b8 08 00 00 00       	mov    $0x8,%eax
    9cbf:	48 85 d2             	test   %rdx,%rdx
    9cc2:	74 14                	je     9cd8 <fwp_p_array_get_typed+0x38>
    9cc4:	44 8b 02             	mov    (%rdx),%r8d
    9cc7:	49 83 f8 0a          	cmp    $0xa,%r8
    9ccb:	77 0b                	ja     9cd8 <fwp_p_array_get_typed+0x38>
    9ccd:	48 8d 05 e4 55 00 00 	lea    0x55e4(%rip),%rax        # f2b8 <fwp_segv.msg+0x78>
    9cd4:	4a 8b 04 c0          	mov    (%rax,%r8,8),%rax
    9cd8:	48 85 c9             	test   %rcx,%rcx
    9cdb:	78 09                	js     9ce6 <fwp_p_array_get_typed+0x46>
    9cdd:	48 8d 4e 08          	lea    0x8(%rsi),%rcx
    9ce1:	eb 07                	jmp    9cea <fwp_p_array_get_typed+0x4a>
    9ce3:	31 c0                	xor    %eax,%eax
    9ce5:	c3                   	ret
    9ce6:	48 8b 4e 10          	mov    0x10(%rsi),%rcx
    9cea:	41 57                	push   %r15
    9cec:	41 56                	push   %r14
    9cee:	53                   	push   %rbx
    9cef:	48 83 ec 10          	sub    $0x10,%rsp
    9cf3:	48 0f af f8          	imul   %rax,%rdi
    9cf7:	48 83 f8 01          	cmp    $0x1,%rax
    9cfb:	49 89 f6             	mov    %rsi,%r14
    9cfe:	74 1f                	je     9d1f <fwp_p_array_get_typed+0x7f>
    9d00:	48 83 f8 02          	cmp    $0x2,%rax
    9d04:	74 0c                	je     9d12 <fwp_p_array_get_typed+0x72>
    9d06:	48 83 f8 08          	cmp    $0x8,%rax
    9d0a:	75 20                	jne    9d2c <fwp_p_array_get_typed+0x8c>
    9d0c:	48 8b 04 39          	mov    (%rcx,%rdi,1),%rax
    9d10:	eb 27                	jmp    9d39 <fwp_p_array_get_typed+0x99>
    9d12:	83 3a 01             	cmpl   $0x1,(%rdx)
    9d15:	0f b7 0c 39          	movzwl (%rcx,%rdi,1),%ecx
    9d19:	48 0f bf c1          	movswq %cx,%rax
    9d1d:	eb 16                	jmp    9d35 <fwp_p_array_get_typed+0x95>
    9d1f:	83 3a 00             	cmpl   $0x0,(%rdx)
    9d22:	0f b6 0c 39          	movzbl (%rcx,%rdi,1),%ecx
    9d26:	48 0f be c1          	movsbq %cl,%rax
    9d2a:	eb 09                	jmp    9d35 <fwp_p_array_get_typed+0x95>
    9d2c:	83 3a 02             	cmpl   $0x2,(%rdx)
    9d2f:	8b 0c 39             	mov    (%rcx,%rdi,1),%ecx
    9d32:	48 63 c1             	movslq %ecx,%rax
    9d35:	48 0f 45 c1          	cmovne %rcx,%rax
    9d39:	48 89 44 24 08       	mov    %rax,0x8(%rsp)
    9d3e:	48 8d 54 24 08       	lea    0x8(%rsp),%rdx
    9d43:	bf 01 00 00 00       	mov    $0x1,%edi
    9d48:	be 01 00 00 00       	mov    $0x1,%esi
    9d4d:	e8 9e 00 00 00       	call   9df0 <fwp_data>
    9d52:	48 89 c2             	mov    %rax,%rdx
    9d55:	48 2b 15 54 94 00 00 	sub    0x9454(%rip),%rdx        # 131b0 <fwp_gc+0x1030>
    9d5c:	48 8b 0d 75 94 00 00 	mov    0x9475(%rip),%rcx        # 131d8 <fwp_gc+0x1058>
    9d63:	48 c1 e1 10          	shl    $0x10,%rcx
    9d67:	48 39 ca             	cmp    %rcx,%rdx
    9d6a:	4c 89 f1             	mov    %r14,%rcx
    9d6d:	73 77                	jae    9de6 <fwp_p_array_get_typed+0x146>
    9d6f:	48 8b 35 82 94 00 00 	mov    0x9482(%rip),%rsi        # 131f8 <fwp_gc+0x1078>
    9d76:	48 89 d7             	mov    %rdx,%rdi
    9d79:	48 c1 ef 10          	shr    $0x10,%rdi
    9d7d:	48 69 ff 28 12 00 00 	imul   $0x1228,%rdi,%rdi
    9d84:	44 0f b6 04 3e       	movzbl (%rsi,%rdi,1),%r8d
    9d89:	48 81 e2 ff ff 00 00 	and    $0xffff,%rdx
    9d90:	75 1b                	jne    9dad <fwp_p_array_get_typed+0x10d>
    9d92:	41 80 f8 02          	cmp    $0x2,%r8b
    9d96:	75 15                	jne    9dad <fwp_p_array_get_typed+0x10d>
    9d98:	48 8d 1c 3e          	lea    (%rsi,%rdi,1),%rbx
    9d9c:	48 81 c3 28 02 00 00 	add    $0x228,%rbx
    9da3:	80 3b ff             	cmpb   $0xff,(%rbx)
    9da6:	74 2b                	je     9dd3 <fwp_p_array_get_typed+0x133>
    9da8:	c6 03 01             	movb   $0x1,(%rbx)
    9dab:	eb 39                	jmp    9de6 <fwp_p_array_get_typed+0x146>
    9dad:	41 80 f8 01          	cmp    $0x1,%r8b
    9db1:	75 33                	jne    9de6 <fwp_p_array_get_typed+0x146>
    9db3:	4c 8d 04 3e          	lea    (%rsi,%rdi,1),%r8
    9db7:	8b 74 3e 20          	mov    0x20(%rsi,%rdi,1),%esi
    9dbb:	48 0f af d6          	imul   %rsi,%rdx
    9dbf:	48 c1 ea 20          	shr    $0x20,%rdx
    9dc3:	4a 8d 1c 02          	lea    (%rdx,%r8,1),%rbx
    9dc7:	48 81 c3 28 02 00 00 	add    $0x228,%rbx
    9dce:	80 3b ff             	cmpb   $0xff,(%rbx)
    9dd1:	75 d5                	jne    9da8 <fwp_p_array_get_typed+0x108>
    9dd3:	48 89 df             	mov    %rbx,%rdi
    9dd6:	49 89 c7             	mov    %rax,%r15
    9dd9:	e8 42 c5 ff ff       	call   6320 <fwp_rc_forget_slot>
    9dde:	4c 89 f8             	mov    %r15,%rax
    9de1:	4c 89 f1             	mov    %r14,%rcx
    9de4:	eb c2                	jmp    9da8 <fwp_p_array_get_typed+0x108>
    9de6:	48 83 c4 10          	add    $0x10,%rsp
    9dea:	5b                   	pop    %rbx
    9deb:	41 5e                	pop    %r14
    9ded:	41 5f                	pop    %r15
    9def:	c3                   	ret

0000000000009df0 <fwp_data>:
    9df0:	55                   	push   %rbp
    9df1:	41 57                	push   %r15
    9df3:	41 56                	push   %r14
    9df5:	41 55                	push   %r13
    9df7:	41 54                	push   %r12
    9df9:	53                   	push   %rbx
    9dfa:	50                   	push   %rax
    9dfb:	48 89 d3             	mov    %rdx,%rbx
    9dfe:	89 f5                	mov    %esi,%ebp
    9e00:	41 89 ff             	mov    %edi,%r15d
    9e03:	41 89 f4             	mov    %esi,%r12d
    9e06:	4e 8d 2c e5 00 00 00 	lea    0x0(,%r12,8),%r13
    9e0d:	00 
    9e0e:	4a 8d 3c e5 08 00 00 	lea    0x8(,%r12,8),%rdi
    9e15:	00 
    9e16:	81 fe ff 07 00 00    	cmp    $0x7ff,%esi
    9e1c:	0f 87 e6 00 00 00    	ja     9f08 <fwp_data+0x118>
    9e22:	49 8d 75 17          	lea    0x17(%r13),%rsi
    9e26:	48 c1 ee 04          	shr    $0x4,%rsi
    9e2a:	48 8d 05 4f 83 00 00 	lea    0x834f(%rip),%rax        # 12180 <fwp_gc>
    9e31:	0f b6 8c 06 e8 0b 00 	movzbl 0xbe8(%rsi,%rax,1),%ecx
    9e38:	00 
    9e39:	8b 94 88 48 0b 00 00 	mov    0xb48(%rax,%rcx,4),%edx
    9e40:	4c 8b 05 39 83 00 00 	mov    0x8339(%rip),%r8        # 12180 <fwp_gc>
    9e47:	4d 89 c1             	mov    %r8,%r9
    9e4a:	49 29 d1             	sub    %rdx,%r9
    9e4d:	4c 89 0d 2c 83 00 00 	mov    %r9,0x832c(%rip)        # 12180 <fwp_gc>
    9e54:	0f 88 ae 00 00 00    	js     9f08 <fwp_data+0x118>
    9e5a:	4c 8d 0c 49          	lea    (%rcx,%rcx,2),%r9
    9e5e:	4e 8d 14 c8          	lea    (%rax,%r9,8),%r10
    9e62:	49 83 c2 08          	add    $0x8,%r10
    9e66:	4d 8b 32             	mov    (%r10),%r14
    9e69:	4d 85 f6             	test   %r14,%r14
    9e6c:	74 29                	je     9e97 <fwp_data+0xa7>
    9e6e:	49 8b 06             	mov    (%r14),%rax
    9e71:	48 f7 d0             	not    %rax
    9e74:	49 89 02             	mov    %rax,(%r10)
    9e77:	48 39 d7             	cmp    %rdx,%rdi
    9e7a:	0f 83 ad 00 00 00    	jae    9f2d <fwp_data+0x13d>
    9e80:	4c 01 f7             	add    %r14,%rdi
    9e83:	4c 29 ea             	sub    %r13,%rdx
    9e86:	48 83 c2 f7          	add    $0xfffffffffffffff7,%rdx
    9e8a:	48 83 e2 f8          	and    $0xfffffffffffffff8,%rdx
    9e8e:	48 83 c2 08          	add    $0x8,%rdx
    9e92:	e9 8f 00 00 00       	jmp    9f26 <fwp_data+0x136>
    9e97:	4e 8b 74 c8 10       	mov    0x10(%rax,%r9,8),%r14
    9e9c:	4e 8b 54 c8 18       	mov    0x18(%rax,%r9,8),%r10
    9ea1:	4d 29 f2             	sub    %r14,%r10
    9ea4:	49 39 d2             	cmp    %rdx,%r10
    9ea7:	72 2f                	jb     9ed8 <fwp_data+0xe8>
    9ea9:	4a 8d 0c c8          	lea    (%rax,%r9,8),%rcx
    9ead:	48 83 c1 10          	add    $0x10,%rcx
    9eb1:	4d 8d 0c 16          	lea    (%r14,%rdx,1),%r9
    9eb5:	4c 89 09             	mov    %r9,(%rcx)
    9eb8:	4d 85 f6             	test   %r14,%r14
    9ebb:	75 ba                	jne    9e77 <fwp_data+0x87>
    9ebd:	0f b6 8c 06 e8 0b 00 	movzbl 0xbe8(%rsi,%rax,1),%ecx
    9ec4:	00 
    9ec5:	8b 94 88 48 0b 00 00 	mov    0xb48(%rax,%rcx,4),%edx
    9ecc:	49 29 d0             	sub    %rdx,%r8
    9ecf:	4c 89 05 aa 82 00 00 	mov    %r8,0x82aa(%rip)        # 12180 <fwp_gc>
    9ed6:	78 30                	js     9f08 <fwp_data+0x118>
    9ed8:	48 8d 0c 49          	lea    (%rcx,%rcx,2),%rcx
    9edc:	4c 8b 74 c8 08       	mov    0x8(%rax,%rcx,8),%r14
    9ee1:	4d 85 f6             	test   %r14,%r14
    9ee4:	74 10                	je     9ef6 <fwp_data+0x106>
    9ee6:	48 8d 04 c8          	lea    (%rax,%rcx,8),%rax
    9eea:	48 83 c0 08          	add    $0x8,%rax
    9eee:	49 8b 0e             	mov    (%r14),%rcx
    9ef1:	48 f7 d1             	not    %rcx
    9ef4:	eb 2a                	jmp    9f20 <fwp_data+0x130>
    9ef6:	4c 8b 74 c8 10       	mov    0x10(%rax,%rcx,8),%r14
    9efb:	48 8b 74 c8 18       	mov    0x18(%rax,%rcx,8),%rsi
    9f00:	4c 29 f6             	sub    %r14,%rsi
    9f03:	48 39 d6             	cmp    %rdx,%rsi
    9f06:	73 0c                	jae    9f14 <fwp_data+0x124>
    9f08:	31 f6                	xor    %esi,%esi
    9f0a:	e8 31 c8 ff ff       	call   6740 <fwp_gc_alloc_slow>
    9f0f:	49 89 c6             	mov    %rax,%r14
    9f12:	eb 19                	jmp    9f2d <fwp_data+0x13d>
    9f14:	48 8d 04 c8          	lea    (%rax,%rcx,8),%rax
    9f18:	48 83 c0 10          	add    $0x10,%rax
    9f1c:	49 8d 0c 16          	lea    (%r14,%rdx,1),%rcx
    9f20:	48 89 08             	mov    %rcx,(%rax)
    9f23:	4c 89 f7             	mov    %r14,%rdi
    9f26:	31 f6                	xor    %esi,%esi
    9f28:	e8 03 82 ff ff       	call   2130 <memset@plt>
    9f2d:	45 89 3e             	mov    %r15d,(%r14)
    9f30:	41 89 6e 04          	mov    %ebp,0x4(%r14)
    9f34:	85 ed                	test   %ebp,%ebp
    9f36:	0f 84 bb 00 00 00    	je     9ff7 <fwp_data+0x207>
    9f3c:	83 fd 08             	cmp    $0x8,%ebp
    9f3f:	72 10                	jb     9f51 <fwp_data+0x161>
    9f41:	4c 89 f0             	mov    %r14,%rax
    9f44:	48 29 d8             	sub    %rbx,%rax
    9f47:	48 83 c0 08          	add    $0x8,%rax
    9f4b:	48 83 f8 20          	cmp    $0x20,%rax
    9f4f:	73 71                	jae    9fc2 <fwp_data+0x1d2>
    9f51:	31 c0                	xor    %eax,%eax
    9f53:	4c 89 e2             	mov    %r12,%rdx
    9f56:	48 89 c1             	mov    %rax,%rcx
    9f59:	48 83 e2 03          	and    $0x3,%rdx
    9f5d:	74 22                	je     9f81 <fwp_data+0x191>
    9f5f:	48 89 c1             	mov    %rax,%rcx
    9f62:	66 66 66 66 66 2e 0f 	data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    9f69:	1f 84 00 00 00 00 00 
    9f70:	48 8b 34 cb          	mov    (%rbx,%rcx,8),%rsi
    9f74:	49 89 74 ce 08       	mov    %rsi,0x8(%r14,%rcx,8)
    9f79:	48 ff c1             	inc    %rcx
    9f7c:	48 ff ca             	dec    %rdx
    9f7f:	75 ef                	jne    9f70 <fwp_data+0x180>
    9f81:	4c 29 e0             	sub    %r12,%rax
    9f84:	48 83 f8 fc          	cmp    $0xfffffffffffffffc,%rax
    9f88:	77 6d                	ja     9ff7 <fwp_data+0x207>
    9f8a:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)
    9f90:	48 8b 04 cb          	mov    (%rbx,%rcx,8),%rax
    9f94:	49 89 44 ce 08       	mov    %rax,0x8(%r14,%rcx,8)
    9f99:	48 8b 44 cb 08       	mov    0x8(%rbx,%rcx,8),%rax
    9f9e:	49 89 44 ce 10       	mov    %rax,0x10(%r14,%rcx,8)
    9fa3:	48 8b 44 cb 10       	mov    0x10(%rbx,%rcx,8),%rax
    9fa8:	49 89 44 ce 18       	mov    %rax,0x18(%r14,%rcx,8)
    9fad:	48 8b 44 cb 18       	mov    0x18(%rbx,%rcx,8),%rax
    9fb2:	49 89 44 ce 20       	mov    %rax,0x20(%r14,%rcx,8)
    9fb7:	48 83 c1 04          	add    $0x4,%rcx
    9fbb:	49 39 cc             	cmp    %rcx,%r12
    9fbe:	75 d0                	jne    9f90 <fwp_data+0x1a0>
    9fc0:	eb 35                	jmp    9ff7 <fwp_data+0x207>
    9fc2:	44 89 e0             	mov    %r12d,%eax
    9fc5:	83 e0 fc             	and    $0xfffffffc,%eax
    9fc8:	49 83 e5 e0          	and    $0xffffffffffffffe0,%r13
    9fcc:	31 c9                	xor    %ecx,%ecx
    9fce:	66 90                	xchg   %ax,%ax
    9fd0:	0f 10 04 0b          	movups (%rbx,%rcx,1),%xmm0
    9fd4:	0f 10 4c 0b 10       	movups 0x10(%rbx,%rcx,1),%xmm1
    9fd9:	41 0f 11 44 0e 08    	movups %xmm0,0x8(%r14,%rcx,1)
    9fdf:	41 0f 11 4c 0e 18    	movups %xmm1,0x18(%r14,%rcx,1)
    9fe5:	48 83 c1 20          	add    $0x20,%rcx
    9fe9:	49 39 cd             	cmp    %rcx,%r13
    9fec:	75 e2                	jne    9fd0 <fwp_data+0x1e0>
    9fee:	4c 39 e0             	cmp    %r12,%rax
    9ff1:	0f 85 5c ff ff ff    	jne    9f53 <fwp_data+0x163>
    9ff7:	4c 89 f0             	mov    %r14,%rax
    9ffa:	48 83 c4 08          	add    $0x8,%rsp
    9ffe:	5b                   	pop    %rbx
    9fff:	41 5c                	pop    %r12
    a001:	41 5d                	pop    %r13
    a003:	41 5e                	pop    %r14
    a005:	41 5f                	pop    %r15
    a007:	5d                   	pop    %rbp
    a008:	c3                   	ret
    a009:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)

000000000000a010 <f49>:
    a010:	41 57                	push   %r15
    a012:	41 56                	push   %r14
    a014:	53                   	push   %rbx
    a015:	48 83 ec 30          	sub    $0x30,%rsp
    a019:	48 89 fb             	mov    %rdi,%rbx
    a01c:	48 8b 47 10          	mov    0x10(%rdi),%rax
    a020:	48 2b 05 89 91 00 00 	sub    0x9189(%rip),%rax        # 131b0 <fwp_gc+0x1030>
    a027:	48 8b 0d aa 91 00 00 	mov    0x91aa(%rip),%rcx        # 131d8 <fwp_gc+0x1058>
    a02e:	48 c1 e1 10          	shl    $0x10,%rcx
    a032:	48 39 c8             	cmp    %rcx,%rax
    a035:	73 68                	jae    a09f <f49+0x8f>
    a037:	48 8b 0d ba 91 00 00 	mov    0x91ba(%rip),%rcx        # 131f8 <fwp_gc+0x1078>
    a03e:	48 89 c2             	mov    %rax,%rdx
    a041:	48 c1 ea 10          	shr    $0x10,%rdx
    a045:	48 69 d2 28 12 00 00 	imul   $0x1228,%rdx,%rdx
    a04c:	0f b6 34 11          	movzbl (%rcx,%rdx,1),%esi
    a050:	48 25 ff ff 00 00    	and    $0xffff,%rax
    a056:	75 13                	jne    a06b <f49+0x5b>
    a058:	40 80 fe 02          	cmp    $0x2,%sil
    a05c:	75 0d                	jne    a06b <f49+0x5b>
    a05e:	48 8d 3c 11          	lea    (%rcx,%rdx,1),%rdi
    a062:	48 81 c7 28 02 00 00 	add    $0x228,%rdi
    a069:	eb 21                	jmp    a08c <f49+0x7c>
    a06b:	40 80 fe 01          	cmp    $0x1,%sil
    a06f:	75 2e                	jne    a09f <f49+0x8f>
    a071:	48 8d 34 11          	lea    (%rcx,%rdx,1),%rsi
    a075:	8b 4c 11 20          	mov    0x20(%rcx,%rdx,1),%ecx
    a079:	48 0f af c1          	imul   %rcx,%rax
    a07d:	48 c1 e8 20          	shr    $0x20,%rax
    a081:	48 8d 3c 30          	lea    (%rax,%rsi,1),%rdi
    a085:	48 81 c7 28 02 00 00 	add    $0x228,%rdi
    a08c:	0f b6 07             	movzbl (%rdi),%eax
    a08f:	84 c0                	test   %al,%al
    a091:	74 0c                	je     a09f <f49+0x8f>
    a093:	3c fe                	cmp    $0xfe,%al
    a095:	0f 83 cc 02 00 00    	jae    a367 <f49+0x357>
    a09b:	fe c0                	inc    %al
    a09d:	88 07                	mov    %al,(%rdi)
    a09f:	4c 8b 7b 08          	mov    0x8(%rbx),%r15
    a0a3:	48 8b 7b 10          	mov    0x10(%rbx),%rdi
    a0a7:	f2 0f 10 43 18       	movsd  0x18(%rbx),%xmm0
    a0ac:	f2 0f 11 04 24       	movsd  %xmm0,(%rsp)
    a0b1:	4d 85 ff             	test   %r15,%r15
    a0b4:	78 20                	js     a0d6 <f49+0xc6>
    a0b6:	48 8b 07             	mov    (%rdi),%rax
    a0b9:	48 b9 ff ff ff ff ff 	movabs $0x7fffffffffffffff,%rcx
    a0c0:	ff ff 7f 
    a0c3:	48 21 c1             	and    %rax,%rcx
    a0c6:	4c 39 f9             	cmp    %r15,%rcx
    a0c9:	76 0b                	jbe    a0d6 <f49+0xc6>
    a0cb:	48 85 c0             	test   %rax,%rax
    a0ce:	78 7c                	js     a14c <f49+0x13c>
    a0d0:	48 8d 47 08          	lea    0x8(%rdi),%rax
    a0d4:	eb 7a                	jmp    a150 <f49+0x140>
    a0d6:	e8 65 03 00 00       	call   a440 <fwp_drop1>
    a0db:	f2 0f 10 04 24       	movsd  (%rsp),%xmm0
    a0e0:	f2 0f 11 44 24 18    	movsd  %xmm0,0x18(%rsp)
    a0e6:	48 8d 54 24 18       	lea    0x18(%rsp),%rdx
    a0eb:	bf 01 00 00 00       	mov    $0x1,%edi
    a0f0:	be 01 00 00 00       	mov    $0x1,%esi
    a0f5:	e8 f6 fc ff ff       	call   9df0 <fwp_data>
    a0fa:	49 89 c6             	mov    %rax,%r14
    a0fd:	48 2b 05 ac 90 00 00 	sub    0x90ac(%rip),%rax        # 131b0 <fwp_gc+0x1030>
    a104:	48 8b 0d cd 90 00 00 	mov    0x90cd(%rip),%rcx        # 131d8 <fwp_gc+0x1058>
    a10b:	48 c1 e1 10          	shl    $0x10,%rcx
    a10f:	48 39 c8             	cmp    %rcx,%rax
    a112:	0f 83 3a 02 00 00    	jae    a352 <f49+0x342>
    a118:	48 8b 0d d9 90 00 00 	mov    0x90d9(%rip),%rcx        # 131f8 <fwp_gc+0x1078>
    a11f:	48 89 c2             	mov    %rax,%rdx
    a122:	48 c1 ea 10          	shr    $0x10,%rdx
    a126:	48 69 d2 28 12 00 00 	imul   $0x1228,%rdx,%rdx
    a12d:	0f b6 34 11          	movzbl (%rcx,%rdx,1),%esi
    a131:	48 25 ff ff 00 00    	and    $0xffff,%rax
    a137:	0f 85 e4 01 00 00    	jne    a321 <f49+0x311>
    a13d:	40 80 fe 02          	cmp    $0x2,%sil
    a141:	0f 84 c3 01 00 00    	je     a30a <f49+0x2fa>
    a147:	e9 d5 01 00 00       	jmp    a321 <f49+0x311>
    a14c:	48 8b 47 10          	mov    0x10(%rdi),%rax
    a150:	f2 42 0f 10 04 f8    	movsd  (%rax,%r15,8),%xmm0
    a156:	f2 0f 59 05 b2 4e 00 	mulsd  0x4eb2(%rip),%xmm0        # f010 <_IO_stdin_used+0x10>
    a15d:	00 
    a15e:	f2 0f 58 05 b2 4e 00 	addsd  0x4eb2(%rip),%xmm0        # f018 <_IO_stdin_used+0x18>
    a165:	00 
    a166:	f2 0f 11 44 24 08    	movsd  %xmm0,0x8(%rsp)
    a16c:	48 89 f8             	mov    %rdi,%rax
    a16f:	48 2b 05 3a 90 00 00 	sub    0x903a(%rip),%rax        # 131b0 <fwp_gc+0x1030>
    a176:	49 ff c7             	inc    %r15
    a179:	48 8b 0d 58 90 00 00 	mov    0x9058(%rip),%rcx        # 131d8 <fwp_gc+0x1058>
    a180:	48 c1 e1 10          	shl    $0x10,%rcx
    a184:	48 39 c8             	cmp    %rcx,%rax
    a187:	73 66                	jae    a1ef <f49+0x1df>
    a189:	48 8b 0d 68 90 00 00 	mov    0x9068(%rip),%rcx        # 131f8 <fwp_gc+0x1078>
    a190:	48 89 c2             	mov    %rax,%rdx
    a193:	48 c1 ea 10          	shr    $0x10,%rdx
    a197:	48 69 d2 28 12 00 00 	imul   $0x1228,%rdx,%rdx
    a19e:	0f b6 34 11          	movzbl (%rcx,%rdx,1),%esi
    a1a2:	48 25 ff ff 00 00    	and    $0xffff,%rax
    a1a8:	75 12                	jne    a1bc <f49+0x1ac>
    a1aa:	40 80 fe 02          	cmp    $0x2,%sil
    a1ae:	75 0c                	jne    a1bc <f49+0x1ac>
    a1b0:	48 8d 04 11          	lea    (%rcx,%rdx,1),%rax
    a1b4:	48 05 28 02 00 00    	add    $0x228,%rax
    a1ba:	eb 1f                	jmp    a1db <f49+0x1cb>
    a1bc:	40 80 fe 01          	cmp    $0x1,%sil
    a1c0:	75 2d                	jne    a1ef <f49+0x1df>
    a1c2:	48 8d 34 11          	lea    (%rcx,%rdx,1),%rsi
    a1c6:	8b 4c 11 20          	mov    0x20(%rcx,%rdx,1),%ecx
    a1ca:	48 0f af c1          	imul   %rcx,%rax
    a1ce:	48 c1 e8 20          	shr    $0x20,%rax
    a1d2:	48 01 f0             	add    %rsi,%rax
    a1d5:	48 05 28 02 00 00    	add    $0x228,%rax
    a1db:	0f b6 08             	movzbl (%rax),%ecx
    a1de:	84 c9                	test   %cl,%cl
    a1e0:	74 0d                	je     a1ef <f49+0x1df>
    a1e2:	80 f9 fe             	cmp    $0xfe,%cl
    a1e5:	0f 83 86 01 00 00    	jae    a371 <f49+0x361>
    a1eb:	fe c1                	inc    %cl
    a1ed:	88 08                	mov    %cl,(%rax)
    a1ef:	49 89 fe             	mov    %rdi,%r14
    a1f2:	e8 49 02 00 00       	call   a440 <fwp_drop1>
    a1f7:	f2 0f 10 04 24       	movsd  (%rsp),%xmm0
    a1fc:	f2 0f 58 44 24 08    	addsd  0x8(%rsp),%xmm0
    a202:	4c 89 7c 24 18       	mov    %r15,0x18(%rsp)
    a207:	4c 89 74 24 20       	mov    %r14,0x20(%rsp)
    a20c:	f2 0f 11 44 24 28    	movsd  %xmm0,0x28(%rsp)
    a212:	48 8d 54 24 18       	lea    0x18(%rsp),%rdx
    a217:	31 ff                	xor    %edi,%edi
    a219:	be 03 00 00 00       	mov    $0x3,%esi
    a21e:	e8 cd fb ff ff       	call   9df0 <fwp_data>
    a223:	48 89 c1             	mov    %rax,%rcx
    a226:	48 2b 0d 83 8f 00 00 	sub    0x8f83(%rip),%rcx        # 131b0 <fwp_gc+0x1030>
    a22d:	48 8b 15 a4 8f 00 00 	mov    0x8fa4(%rip),%rdx        # 131d8 <fwp_gc+0x1058>
    a234:	48 c1 e2 10          	shl    $0x10,%rdx
    a238:	48 39 d1             	cmp    %rdx,%rcx
    a23b:	73 76                	jae    a2b3 <f49+0x2a3>
    a23d:	48 8b 15 b4 8f 00 00 	mov    0x8fb4(%rip),%rdx        # 131f8 <fwp_gc+0x1078>
    a244:	48 89 ce             	mov    %rcx,%rsi
    a247:	48 c1 ee 10          	shr    $0x10,%rsi
    a24b:	48 69 f6 28 12 00 00 	imul   $0x1228,%rsi,%rsi
    a252:	0f b6 3c 32          	movzbl (%rdx,%rsi,1),%edi
    a256:	48 81 e1 ff ff 00 00 	and    $0xffff,%rcx
    a25d:	75 1d                	jne    a27c <f49+0x26c>
    a25f:	40 80 ff 02          	cmp    $0x2,%dil
    a263:	75 17                	jne    a27c <f49+0x26c>
    a265:	4c 8d 34 32          	lea    (%rdx,%rsi,1),%r14
    a269:	49 81 c6 28 02 00 00 	add    $0x228,%r14
    a270:	41 80 3e ff          	cmpb   $0xff,(%r14)
    a274:	74 2d                	je     a2a3 <f49+0x293>
    a276:	41 c6 06 01          	movb   $0x1,(%r14)
    a27a:	eb 37                	jmp    a2b3 <f49+0x2a3>
    a27c:	40 80 ff 01          	cmp    $0x1,%dil
    a280:	75 31                	jne    a2b3 <f49+0x2a3>
    a282:	48 8d 3c 32          	lea    (%rdx,%rsi,1),%rdi
    a286:	8b 54 32 20          	mov    0x20(%rdx,%rsi,1),%edx
    a28a:	48 0f af ca          	imul   %rdx,%rcx
    a28e:	48 c1 e9 20          	shr    $0x20,%rcx
    a292:	4c 8d 34 39          	lea    (%rcx,%rdi,1),%r14
    a296:	49 81 c6 28 02 00 00 	add    $0x228,%r14
    a29d:	41 80 3e ff          	cmpb   $0xff,(%r14)
    a2a1:	75 d3                	jne    a276 <f49+0x266>
    a2a3:	4c 89 f7             	mov    %r14,%rdi
    a2a6:	49 89 c7             	mov    %rax,%r15
    a2a9:	e8 72 c0 ff ff       	call   6320 <fwp_rc_forget_slot>
    a2ae:	4c 89 f8             	mov    %r15,%rax
    a2b1:	eb c3                	jmp    a276 <f49+0x266>
    a2b3:	48 89 44 24 10       	mov    %rax,0x10(%rsp)
    a2b8:	48 8d 54 24 10       	lea    0x10(%rsp),%rdx
    a2bd:	31 ff                	xor    %edi,%edi
    a2bf:	be 01 00 00 00       	mov    $0x1,%esi
    a2c4:	e8 27 fb ff ff       	call   9df0 <fwp_data>
    a2c9:	49 89 c6             	mov    %rax,%r14
    a2cc:	48 2b 05 dd 8e 00 00 	sub    0x8edd(%rip),%rax        # 131b0 <fwp_gc+0x1030>
    a2d3:	48 8b 0d fe 8e 00 00 	mov    0x8efe(%rip),%rcx        # 131d8 <fwp_gc+0x1058>
    a2da:	48 c1 e1 10          	shl    $0x10,%rcx
    a2de:	48 39 c8             	cmp    %rcx,%rax
    a2e1:	73 6f                	jae    a352 <f49+0x342>
    a2e3:	48 8b 0d 0e 8f 00 00 	mov    0x8f0e(%rip),%rcx        # 131f8 <fwp_gc+0x1078>
    a2ea:	48 89 c2             	mov    %rax,%rdx
    a2ed:	48 c1 ea 10          	shr    $0x10,%rdx
    a2f1:	48 69 d2 28 12 00 00 	imul   $0x1228,%rdx,%rdx
    a2f8:	0f b6 34 11          	movzbl (%rcx,%rdx,1),%esi
    a2fc:	48 25 ff ff 00 00    	and    $0xffff,%rax
    a302:	75 1d                	jne    a321 <f49+0x311>
    a304:	40 80 fe 02          	cmp    $0x2,%sil
    a308:	75 17                	jne    a321 <f49+0x311>
    a30a:	4c 8d 3c 11          	lea    (%rcx,%rdx,1),%r15
    a30e:	49 81 c7 28 02 00 00 	add    $0x228,%r15
    a315:	41 80 3f ff          	cmpb   $0xff,(%r15)
    a319:	74 2d                	je     a348 <f49+0x338>
    a31b:	41 c6 07 01          	movb   $0x1,(%r15)
    a31f:	eb 31                	jmp    a352 <f49+0x342>
    a321:	40 80 fe 01          	cmp    $0x1,%sil
    a325:	75 2b                	jne    a352 <f49+0x342>
    a327:	48 8d 34 11          	lea    (%rcx,%rdx,1),%rsi
    a32b:	8b 4c 11 20          	mov    0x20(%rcx,%rdx,1),%ecx
    a32f:	48 0f af c1          	imul   %rcx,%rax
    a333:	48 c1 e8 20          	shr    $0x20,%rax
    a337:	4c 8d 3c 30          	lea    (%rax,%rsi,1),%r15
    a33b:	49 81 c7 28 02 00 00 	add    $0x228,%r15
    a342:	41 80 3f ff          	cmpb   $0xff,(%r15)
    a346:	75 d3                	jne    a31b <f49+0x30b>
    a348:	4c 89 ff             	mov    %r15,%rdi
    a34b:	e8 d0 bf ff ff       	call   6320 <fwp_rc_forget_slot>
    a350:	eb c9                	jmp    a31b <f49+0x30b>
    a352:	48 89 df             	mov    %rbx,%rdi
    a355:	e8 36 00 00 00       	call   a390 <fwp_drop6>
    a35a:	4c 89 f0             	mov    %r14,%rax
    a35d:	48 83 c4 30          	add    $0x30,%rsp
    a361:	5b                   	pop    %rbx
    a362:	41 5e                	pop    %r14
    a364:	41 5f                	pop    %r15
    a366:	c3                   	ret
    a367:	e8 94 d2 ff ff       	call   7600 <fwp_rc_wide_dup>
    a36c:	e9 2e fd ff ff       	jmp    a09f <f49+0x8f>
    a371:	49 89 fe             	mov    %rdi,%r14
    a374:	48 89 c7             	mov    %rax,%rdi
    a377:	e8 84 d2 ff ff       	call   7600 <fwp_rc_wide_dup>
    a37c:	4c 89 f7             	mov    %r14,%rdi
    a37f:	e9 6b fe ff ff       	jmp    a1ef <f49+0x1df>
    a384:	66 66 66 2e 0f 1f 84 	data16 data16 cs nopw 0x0(%rax,%rax,1)
    a38b:	00 00 00 00 00 

000000000000a390 <fwp_drop6>:
    a390:	48 89 f8             	mov    %rdi,%rax
    a393:	48 2b 05 16 8e 00 00 	sub    0x8e16(%rip),%rax        # 131b0 <fwp_gc+0x1030>
    a39a:	48 8b 0d 37 8e 00 00 	mov    0x8e37(%rip),%rcx        # 131d8 <fwp_gc+0x1058>
    a3a1:	48 c1 e1 10          	shl    $0x10,%rcx
    a3a5:	48 39 c8             	cmp    %rcx,%rax
    a3a8:	0f 83 83 00 00 00    	jae    a431 <fwp_drop6+0xa1>
    a3ae:	48 8b 0d 43 8e 00 00 	mov    0x8e43(%rip),%rcx        # 131f8 <fwp_gc+0x1078>
    a3b5:	48 89 c2             	mov    %rax,%rdx
    a3b8:	48 c1 ea 10          	shr    $0x10,%rdx
    a3bc:	48 69 d2 28 12 00 00 	imul   $0x1228,%rdx,%rdx
    a3c3:	0f b6 34 11          	movzbl (%rcx,%rdx,1),%esi
    a3c7:	48 25 ff ff 00 00    	and    $0xffff,%rax
    a3cd:	75 12                	jne    a3e1 <fwp_drop6+0x51>
    a3cf:	40 80 fe 02          	cmp    $0x2,%sil
    a3d3:	75 0c                	jne    a3e1 <fwp_drop6+0x51>
    a3d5:	48 8d 04 11          	lea    (%rcx,%rdx,1),%rax
    a3d9:	48 05 28 02 00 00    	add    $0x228,%rax
    a3df:	eb 1f                	jmp    a400 <fwp_drop6+0x70>
    a3e1:	40 80 fe 01          	cmp    $0x1,%sil
    a3e5:	75 4a                	jne    a431 <fwp_drop6+0xa1>
    a3e7:	48 8d 34 11          	lea    (%rcx,%rdx,1),%rsi
    a3eb:	8b 4c 11 20          	mov    0x20(%rcx,%rdx,1),%ecx
    a3ef:	48 0f af c1          	imul   %rcx,%rax
    a3f3:	48 c1 e8 20          	shr    $0x20,%rax
    a3f7:	48 01 f0             	add    %rsi,%rax
    a3fa:	48 05 28 02 00 00    	add    $0x228,%rax
    a400:	0f b6 08             	movzbl (%rax),%ecx
    a403:	85 c9                	test   %ecx,%ecx
    a405:	74 2a                	je     a431 <fwp_drop6+0xa1>
    a407:	83 f9 01             	cmp    $0x1,%ecx
    a40a:	75 19                	jne    a425 <fwp_drop6+0x95>
    a40c:	53                   	push   %rbx
    a40d:	48 8b 47 10          	mov    0x10(%rdi),%rax
    a411:	48 89 fb             	mov    %rdi,%rbx
    a414:	48 89 c7             	mov    %rax,%rdi
    a417:	e8 24 00 00 00       	call   a440 <fwp_drop1>
    a41c:	48 89 df             	mov    %rbx,%rdi
    a41f:	5b                   	pop    %rbx
    a420:	e9 eb 04 00 00       	jmp    a910 <fwp_rc_free_obj>
    a425:	81 f9 ff 00 00 00    	cmp    $0xff,%ecx
    a42b:	74 05                	je     a432 <fwp_drop6+0xa2>
    a42d:	fe c9                	dec    %cl
    a42f:	88 08                	mov    %cl,(%rax)
    a431:	c3                   	ret
    a432:	48 89 c7             	mov    %rax,%rdi
    a435:	e9 f6 01 00 00       	jmp    a630 <fwp_rc_wide_drop>
    a43a:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)

000000000000a440 <fwp_drop1>:
    a440:	53                   	push   %rbx
    a441:	48 89 f8             	mov    %rdi,%rax
    a444:	48 2b 05 65 8d 00 00 	sub    0x8d65(%rip),%rax        # 131b0 <fwp_gc+0x1030>
    a44b:	48 8b 0d 86 8d 00 00 	mov    0x8d86(%rip),%rcx        # 131d8 <fwp_gc+0x1058>
    a452:	48 c1 e1 10          	shl    $0x10,%rcx
    a456:	48 39 c8             	cmp    %rcx,%rax
    a459:	0f 83 9c 00 00 00    	jae    a4fb <fwp_drop1+0xbb>
    a45f:	48 8b 0d 92 8d 00 00 	mov    0x8d92(%rip),%rcx        # 131f8 <fwp_gc+0x1078>
    a466:	48 89 c2             	mov    %rax,%rdx
    a469:	48 c1 ea 10          	shr    $0x10,%rdx
    a46d:	48 69 d2 28 12 00 00 	imul   $0x1228,%rdx,%rdx
    a474:	0f b6 34 11          	movzbl (%rcx,%rdx,1),%esi
    a478:	48 25 ff ff 00 00    	and    $0xffff,%rax
    a47e:	75 20                	jne    a4a0 <fwp_drop1+0x60>
    a480:	40 80 fe 02          	cmp    $0x2,%sil
    a484:	75 1a                	jne    a4a0 <fwp_drop1+0x60>
    a486:	48 8d 04 11          	lea    (%rcx,%rdx,1),%rax
    a48a:	48 05 28 02 00 00    	add    $0x228,%rax
    a490:	eb 2d                	jmp    a4bf <fwp_drop1+0x7f>
    a492:	66 66 66 66 66 2e 0f 	data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    a499:	1f 84 00 00 00 00 00 
    a4a0:	40 80 fe 01          	cmp    $0x1,%sil
    a4a4:	75 55                	jne    a4fb <fwp_drop1+0xbb>
    a4a6:	48 8d 34 11          	lea    (%rcx,%rdx,1),%rsi
    a4aa:	8b 4c 11 20          	mov    0x20(%rcx,%rdx,1),%ecx
    a4ae:	48 0f af c1          	imul   %rcx,%rax
    a4b2:	48 c1 e8 20          	shr    $0x20,%rax
    a4b6:	48 01 f0             	add    %rsi,%rax
    a4b9:	48 05 28 02 00 00    	add    $0x228,%rax
    a4bf:	0f b6 08             	movzbl (%rax),%ecx
    a4c2:	85 c9                	test   %ecx,%ecx
    a4c4:	74 35                	je     a4fb <fwp_drop1+0xbb>
    a4c6:	83 f9 01             	cmp    $0x1,%ecx
    a4c9:	75 32                	jne    a4fd <fwp_drop1+0xbd>
    a4cb:	48 83 3f 00          	cmpq   $0x0,(%rdi)
    a4cf:	79 3a                	jns    a50b <fwp_drop1+0xcb>
    a4d1:	48 8b 5f 08          	mov    0x8(%rdi),%rbx
    a4d5:	e8 46 00 00 00       	call   a520 <fwp_rc_free_arr>
    a4da:	48 89 d8             	mov    %rbx,%rax
    a4dd:	48 2b 05 cc 8c 00 00 	sub    0x8ccc(%rip),%rax        # 131b0 <fwp_gc+0x1030>
    a4e4:	48 8b 0d ed 8c 00 00 	mov    0x8ced(%rip),%rcx        # 131d8 <fwp_gc+0x1058>
    a4eb:	48 c1 e1 10          	shl    $0x10,%rcx
    a4ef:	48 89 df             	mov    %rbx,%rdi
    a4f2:	48 39 c8             	cmp    %rcx,%rax
    a4f5:	0f 82 64 ff ff ff    	jb     a45f <fwp_drop1+0x1f>
    a4fb:	5b                   	pop    %rbx
    a4fc:	c3                   	ret
    a4fd:	81 f9 ff 00 00 00    	cmp    $0xff,%ecx
    a503:	74 09                	je     a50e <fwp_drop1+0xce>
    a505:	fe c9                	dec    %cl
    a507:	88 08                	mov    %cl,(%rax)
    a509:	5b                   	pop    %rbx
    a50a:	c3                   	ret
    a50b:	5b                   	pop    %rbx
    a50c:	eb 12                	jmp    a520 <fwp_rc_free_arr>
    a50e:	48 89 c7             	mov    %rax,%rdi
    a511:	5b                   	pop    %rbx
    a512:	e9 19 01 00 00       	jmp    a630 <fwp_rc_wide_drop>
    a517:	66 0f 1f 84 00 00 00 	nopw   0x0(%rax,%rax,1)
    a51e:	00 00 

000000000000a520 <fwp_rc_free_arr>:
    a520:	48 89 f8             	mov    %rdi,%rax
    a523:	48 2b 05 86 8c 00 00 	sub    0x8c86(%rip),%rax        # 131b0 <fwp_gc+0x1030>
    a52a:	48 8b 0d a7 8c 00 00 	mov    0x8ca7(%rip),%rcx        # 131d8 <fwp_gc+0x1058>
    a531:	48 c1 e1 10          	shl    $0x10,%rcx
    a535:	48 39 c8             	cmp    %rcx,%rax
    a538:	0f 83 e9 00 00 00    	jae    a627 <fwp_rc_free_arr+0x107>
    a53e:	53                   	push   %rbx
    a53f:	48 8b 0d b2 8c 00 00 	mov    0x8cb2(%rip),%rcx        # 131f8 <fwp_gc+0x1078>
    a546:	48 89 c2             	mov    %rax,%rdx
    a549:	48 c1 ea 10          	shr    $0x10,%rdx
    a54d:	48 69 d2 28 12 00 00 	imul   $0x1228,%rdx,%rdx
    a554:	0f b6 34 11          	movzbl (%rcx,%rdx,1),%esi
    a558:	48 25 ff ff 00 00    	and    $0xffff,%rax
    a55e:	75 1a                	jne    a57a <fwp_rc_free_arr+0x5a>
    a560:	40 80 fe 02          	cmp    $0x2,%sil
    a564:	75 14                	jne    a57a <fwp_rc_free_arr+0x5a>
    a566:	48 8d 04 11          	lea    (%rcx,%rdx,1),%rax
    a56a:	48 05 28 02 00 00    	add    $0x228,%rax
    a570:	80 38 01             	cmpb   $0x1,(%rax)
    a573:	74 31                	je     a5a6 <fwp_rc_free_arr+0x86>
    a575:	e9 ac 00 00 00       	jmp    a626 <fwp_rc_free_arr+0x106>
    a57a:	40 80 fe 01          	cmp    $0x1,%sil
    a57e:	0f 85 a2 00 00 00    	jne    a626 <fwp_rc_free_arr+0x106>
    a584:	48 8d 34 11          	lea    (%rcx,%rdx,1),%rsi
    a588:	8b 4c 11 20          	mov    0x20(%rcx,%rdx,1),%ecx
    a58c:	48 0f af c1          	imul   %rcx,%rax
    a590:	48 c1 e8 20          	shr    $0x20,%rax
    a594:	48 01 f0             	add    %rsi,%rax
    a597:	48 05 28 02 00 00    	add    $0x228,%rax
    a59d:	80 38 01             	cmpb   $0x1,(%rax)
    a5a0:	0f 85 80 00 00 00    	jne    a626 <fwp_rc_free_arr+0x106>
    a5a6:	8b 0d f4 95 00 00    	mov    0x95f4(%rip),%ecx        # 13ba0 <fwp_reuse_verify>
    a5ac:	85 c9                	test   %ecx,%ecx
    a5ae:	78 0d                	js     a5bd <fwp_rc_free_arr+0x9d>
    a5b0:	85 c9                	test   %ecx,%ecx
    a5b2:	74 47                	je     a5fb <fwp_rc_free_arr+0xdb>
    a5b4:	48 c7 07 00 00 00 00 	movq   $0x0,(%rdi)
    a5bb:	eb 69                	jmp    a626 <fwp_rc_free_arr+0x106>
    a5bd:	48 89 fb             	mov    %rdi,%rbx
    a5c0:	48 8d 3d 22 4f 00 00 	lea    0x4f22(%rip),%rdi        # f4e9 <fwp_segv.msg+0x2a9>
    a5c7:	e8 64 7a ff ff       	call   2030 <getenv@plt>
    a5cc:	31 c9                	xor    %ecx,%ecx
    a5ce:	48 85 c0             	test   %rax,%rax
    a5d1:	74 1b                	je     a5ee <fwp_rc_free_arr+0xce>
    a5d3:	80 38 00             	cmpb   $0x0,(%rax)
    a5d6:	74 16                	je     a5ee <fwp_rc_free_arr+0xce>
    a5d8:	48 8d 35 83 50 00 00 	lea    0x5083(%rip),%rsi        # f662 <fwp_segv.msg+0x422>
    a5df:	48 89 c7             	mov    %rax,%rdi
    a5e2:	e8 99 7b ff ff       	call   2180 <strcmp@plt>
    a5e7:	31 c9                	xor    %ecx,%ecx
    a5e9:	85 c0                	test   %eax,%eax
    a5eb:	0f 95 c1             	setne  %cl
    a5ee:	89 0d ac 95 00 00    	mov    %ecx,0x95ac(%rip)        # 13ba0 <fwp_reuse_verify>
    a5f4:	48 89 df             	mov    %rbx,%rdi
    a5f7:	85 c9                	test   %ecx,%ecx
    a5f9:	75 b9                	jne    a5b4 <fwp_rc_free_arr+0x94>
    a5fb:	48 8b 1d 7e 7b 00 00 	mov    0x7b7e(%rip),%rbx        # 12180 <fwp_gc>
    a602:	e8 b9 00 00 00       	call   a6c0 <fwp_mem_free>
    a607:	48 8b 05 72 7b 00 00 	mov    0x7b72(%rip),%rax        # 12180 <fwp_gc>
    a60e:	48 29 d8             	sub    %rbx,%rax
    a611:	f2 48 0f 2a c0       	cvtsi2sd %rax,%xmm0
    a616:	f2 0f 58 05 6a 8d 00 	addsd  0x8d6a(%rip),%xmm0        # 13388 <fwp_gc+0x1208>
    a61d:	00 
    a61e:	f2 0f 11 05 62 8d 00 	movsd  %xmm0,0x8d62(%rip)        # 13388 <fwp_gc+0x1208>
    a625:	00 
    a626:	5b                   	pop    %rbx
    a627:	c3                   	ret
    a628:	0f 1f 84 00 00 00 00 	nopl   0x0(%rax,%rax,1)
    a62f:	00 

000000000000a630 <fwp_rc_wide_drop>:
    a630:	53                   	push   %rbx
    a631:	48 89 f8             	mov    %rdi,%rax
    a634:	48 c1 e8 11          	shr    $0x11,%rax
    a638:	31 f8                	xor    %edi,%eax
    a63a:	89 c1                	mov    %eax,%ecx
    a63c:	c1 e9 09             	shr    $0x9,%ecx
    a63f:	31 c1                	xor    %eax,%ecx
    a641:	0f b6 c1             	movzbl %cl,%eax
    a644:	48 8d 0d 35 7b 00 00 	lea    0x7b35(%rip),%rcx        # 12180 <fwp_gc>
    a64b:	48 8b 84 c1 18 12 00 	mov    0x1218(%rcx,%rax,8),%rax
    a652:	00 
    a653:	48 85 c0             	test   %rax,%rax
    a656:	74 16                	je     a66e <fwp_rc_wide_drop+0x3e>
    a658:	0f 1f 84 00 00 00 00 	nopl   0x0(%rax,%rax,1)
    a65f:	00 
    a660:	48 39 38             	cmp    %rdi,(%rax)
    a663:	74 37                	je     a69c <fwp_rc_wide_drop+0x6c>
    a665:	48 8b 40 10          	mov    0x10(%rax),%rax
    a669:	48 85 c0             	test   %rax,%rax
    a66c:	75 f2                	jne    a660 <fwp_rc_wide_drop+0x30>
    a66e:	e8 7d bc ff ff       	call   62f0 <fwp_flush>
    a673:	48 8b 05 66 79 00 00 	mov    0x7966(%rip),%rax        # 11fe0 <stderr@GLIBC_2.2.5>
    a67a:	48 8b 38             	mov    (%rax),%rdi
    a67d:	48 8d 35 a9 4d 00 00 	lea    0x4da9(%rip),%rsi        # f42d <fwp_segv.msg+0x1ed>
    a684:	48 8d 15 b1 4d 00 00 	lea    0x4db1(%rip),%rdx        # f43c <fwp_segv.msg+0x1fc>
    a68b:	31 c0                	xor    %eax,%eax
    a68d:	e8 1e 7b ff ff       	call   21b0 <fprintf@plt>
    a692:	bf 65 00 00 00       	mov    $0x65,%edi
    a697:	e8 f4 7b ff ff       	call   2290 <exit@plt>
    a69c:	48 8b 48 08          	mov    0x8(%rax),%rcx
    a6a0:	48 ff c9             	dec    %rcx
    a6a3:	48 89 48 08          	mov    %rcx,0x8(%rax)
    a6a7:	48 81 f9 fe 00 00 00 	cmp    $0xfe,%rcx
    a6ae:	75 0b                	jne    a6bb <fwp_rc_wide_drop+0x8b>
    a6b0:	48 89 fb             	mov    %rdi,%rbx
    a6b3:	e8 68 bc ff ff       	call   6320 <fwp_rc_forget_slot>
    a6b8:	c6 03 fe             	movb   $0xfe,(%rbx)
    a6bb:	5b                   	pop    %rbx
    a6bc:	c3                   	ret
    a6bd:	0f 1f 00             	nopl   (%rax)

000000000000a6c0 <fwp_mem_free>:
    a6c0:	48 85 ff             	test   %rdi,%rdi
    a6c3:	0f 84 17 02 00 00    	je     a8e0 <fwp_mem_free+0x220>
    a6c9:	48 8b 05 e0 8a 00 00 	mov    0x8ae0(%rip),%rax        # 131b0 <fwp_gc+0x1030>
    a6d0:	48 89 f9             	mov    %rdi,%rcx
    a6d3:	48 29 c1             	sub    %rax,%rcx
    a6d6:	48 8b 15 fb 8a 00 00 	mov    0x8afb(%rip),%rdx        # 131d8 <fwp_gc+0x1058>
    a6dd:	48 c1 e2 10          	shl    $0x10,%rdx
    a6e1:	48 39 d1             	cmp    %rdx,%rcx
    a6e4:	0f 83 f6 01 00 00    	jae    a8e0 <fwp_mem_free+0x220>
    a6ea:	41 57                	push   %r15
    a6ec:	41 56                	push   %r14
    a6ee:	41 55                	push   %r13
    a6f0:	41 54                	push   %r12
    a6f2:	53                   	push   %rbx
    a6f3:	4c 8b 25 fe 8a 00 00 	mov    0x8afe(%rip),%r12        # 131f8 <fwp_gc+0x1078>
    a6fa:	4d 85 e4             	test   %r12,%r12
    a6fd:	0f 84 d4 01 00 00    	je     a8d7 <fwp_mem_free+0x217>
    a703:	49 89 cf             	mov    %rcx,%r15
    a706:	49 c1 ef 10          	shr    $0x10,%r15
    a70a:	4d 69 f7 28 12 00 00 	imul   $0x1228,%r15,%r14
    a711:	43 0f b6 14 34       	movzbl (%r12,%r14,1),%edx
    a716:	83 fa 02             	cmp    $0x2,%edx
    a719:	0f 84 b9 00 00 00    	je     a7d8 <fwp_mem_free+0x118>
    a71f:	83 fa 01             	cmp    $0x1,%edx
    a722:	0f 85 af 01 00 00    	jne    a8d7 <fwp_mem_free+0x217>
    a728:	47 0f b6 4c 34 01    	movzbl 0x1(%r12,%r14,1),%r9d
    a72e:	47 0f b6 44 34 02    	movzbl 0x2(%r12,%r14,1),%r8d
    a734:	43 8b 74 34 08       	mov    0x8(%r12,%r14,1),%esi
    a739:	0f b7 c7             	movzwl %di,%eax
    a73c:	31 d2                	xor    %edx,%edx
    a73e:	f7 f6                	div    %esi
    a740:	48 c7 c2 fe ff ff ff 	mov    $0xfffffffffffffffe,%rdx
    a747:	89 c1                	mov    %eax,%ecx
    a749:	48 d3 c2             	rol    %cl,%rdx
    a74c:	4b 8d 0c 34          	lea    (%r12,%r14,1),%rcx
    a750:	41 89 c2             	mov    %eax,%r10d
    a753:	41 c1 ea 03          	shr    $0x3,%r10d
    a757:	41 81 e2 f8 1f 00 00 	and    $0x1ff8,%r10d
    a75e:	49 21 54 0a 28       	and    %rdx,0x28(%r10,%rcx,1)
    a763:	49 69 d1 c0 03 00 00 	imul   $0x3c0,%r9,%rdx
    a76a:	4c 8d 3d 0f 7a 00 00 	lea    0x7a0f(%rip),%r15        # 12180 <fwp_gc>
    a771:	49 01 d7             	add    %rdx,%r15
    a774:	4f 8d 2c 40          	lea    (%r8,%r8,2),%r13
    a778:	4d 01 e6             	add    %r12,%r14
    a77b:	49 83 c6 08          	add    $0x8,%r14
    a77f:	48 8d 1c 08          	lea    (%rax,%rcx,1),%rbx
    a783:	48 81 c3 28 02 00 00 	add    $0x228,%rbx
    a78a:	80 bc 08 28 02 00 00 	cmpb   $0xff,0x228(%rax,%rcx,1)
    a791:	ff 
    a792:	0f 84 49 01 00 00    	je     a8e1 <fwp_mem_free+0x221>
    a798:	4f 8d 3c ef          	lea    (%r15,%r13,8),%r15
    a79c:	49 83 c7 08          	add    $0x8,%r15
    a7a0:	c6 03 00             	movb   $0x0,(%rbx)
    a7a3:	83 3d da 89 00 00 00 	cmpl   $0x0,0x89da(%rip)        # 13184 <fwp_gc+0x1004>
    a7aa:	74 12                	je     a7be <fwp_mem_free+0xfe>
    a7ac:	89 f2                	mov    %esi,%edx
    a7ae:	48 89 fb             	mov    %rdi,%rbx
    a7b1:	31 f6                	xor    %esi,%esi
    a7b3:	e8 78 79 ff ff       	call   2130 <memset@plt>
    a7b8:	48 89 df             	mov    %rbx,%rdi
    a7bb:	41 8b 36             	mov    (%r14),%esi
    a7be:	49 8b 07             	mov    (%r15),%rax
    a7c1:	48 f7 d0             	not    %rax
    a7c4:	48 89 07             	mov    %rax,(%rdi)
    a7c7:	49 89 3f             	mov    %rdi,(%r15)
    a7ca:	89 f0                	mov    %esi,%eax
    a7cc:	48 01 05 ad 79 00 00 	add    %rax,0x79ad(%rip)        # 12180 <fwp_gc>
    a7d3:	e9 ff 00 00 00       	jmp    a8d7 <fwp_mem_free+0x217>
    a7d8:	48 81 e1 00 00 ff ff 	and    $0xffffffffffff0000,%rcx
    a7df:	48 01 c8             	add    %rcx,%rax
    a7e2:	48 39 f8             	cmp    %rdi,%rax
    a7e5:	0f 85 ec 00 00 00    	jne    a8d7 <fwp_mem_free+0x217>
    a7eb:	4b 8b 44 34 18       	mov    0x18(%r12,%r14,1),%rax
    a7f0:	48 01 05 89 79 00 00 	add    %rax,0x7989(%rip)        # 12180 <fwp_gc>
    a7f7:	43 c6 44 34 03 00    	movb   $0x0,0x3(%r12,%r14,1)
    a7fd:	4b 8d 1c 34          	lea    (%r12,%r14,1),%rbx
    a801:	48 81 c3 28 02 00 00 	add    $0x228,%rbx
    a808:	43 80 bc 34 28 02 00 	cmpb   $0xff,0x228(%r12,%r14,1)
    a80f:	00 ff 
    a811:	0f 84 e0 00 00 00    	je     a8f7 <fwp_mem_free+0x237>
    a817:	c6 03 00             	movb   $0x0,(%rbx)
    a81a:	43 8b 44 34 10       	mov    0x10(%r12,%r14,1),%eax
    a81f:	48 85 c0             	test   %rax,%rax
    a822:	0f 84 88 00 00 00    	je     a8b0 <fwp_mem_free+0x1f0>
    a828:	48 8b 0d c9 89 00 00 	mov    0x89c9(%rip),%rcx        # 131f8 <fwp_gc+0x1078>
    a82f:	89 c2                	mov    %eax,%edx
    a831:	83 e2 03             	and    $0x3,%edx
    a834:	83 f8 04             	cmp    $0x4,%eax
    a837:	73 04                	jae    a83d <fwp_mem_free+0x17d>
    a839:	31 f6                	xor    %esi,%esi
    a83b:	eb 3b                	jmp    a878 <fwp_mem_free+0x1b8>
    a83d:	4a 8d 3c 31          	lea    (%rcx,%r14,1),%rdi
    a841:	41 89 c0             	mov    %eax,%r8d
    a844:	41 83 e0 fc          	and    $0xfffffffc,%r8d
    a848:	31 f6                	xor    %esi,%esi
    a84a:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)
    a850:	c6 07 00             	movb   $0x0,(%rdi)
    a853:	c6 87 28 12 00 00 00 	movb   $0x0,0x1228(%rdi)
    a85a:	c6 87 50 24 00 00 00 	movb   $0x0,0x2450(%rdi)
    a861:	c6 87 78 36 00 00 00 	movb   $0x0,0x3678(%rdi)
    a868:	48 83 c6 04          	add    $0x4,%rsi
    a86c:	48 81 c7 a0 48 00 00 	add    $0x48a0,%rdi
    a873:	49 39 f0             	cmp    %rsi,%r8
    a876:	75 d8                	jne    a850 <fwp_mem_free+0x190>
    a878:	48 85 d2             	test   %rdx,%rdx
    a87b:	74 33                	je     a8b0 <fwp_mem_free+0x1f0>
    a87d:	48 69 f6 28 12 00 00 	imul   $0x1228,%rsi,%rsi
    a884:	4c 01 f6             	add    %r14,%rsi
    a887:	48 01 f1             	add    %rsi,%rcx
    a88a:	48 69 d2 28 12 00 00 	imul   $0x1228,%rdx,%rdx
    a891:	31 f6                	xor    %esi,%esi
    a893:	66 66 66 66 2e 0f 1f 	data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    a89a:	84 00 00 00 00 00 
    a8a0:	c6 04 31 00          	movb   $0x0,(%rcx,%rsi,1)
    a8a4:	48 81 c6 28 12 00 00 	add    $0x1228,%rsi
    a8ab:	48 39 f2             	cmp    %rsi,%rdx
    a8ae:	75 f0                	jne    a8a0 <fwp_mem_free+0x1e0>
    a8b0:	48 01 05 a9 8a 00 00 	add    %rax,0x8aa9(%rip)        # 13360 <fwp_gc+0x11e0>
    a8b7:	4c 3b 3d 32 89 00 00 	cmp    0x8932(%rip),%r15        # 131f0 <fwp_gc+0x1070>
    a8be:	73 07                	jae    a8c7 <fwp_mem_free+0x207>
    a8c0:	4c 89 3d 29 89 00 00 	mov    %r15,0x8929(%rip)        # 131f0 <fwp_gc+0x1070>
    a8c7:	4c 3b 3d 1a 89 00 00 	cmp    0x891a(%rip),%r15        # 131e8 <fwp_gc+0x1068>
    a8ce:	73 07                	jae    a8d7 <fwp_mem_free+0x217>
    a8d0:	4c 89 3d 11 89 00 00 	mov    %r15,0x8911(%rip)        # 131e8 <fwp_gc+0x1068>
    a8d7:	5b                   	pop    %rbx
    a8d8:	41 5c                	pop    %r12
    a8da:	41 5d                	pop    %r13
    a8dc:	41 5e                	pop    %r14
    a8de:	41 5f                	pop    %r15
    a8e0:	c3                   	ret
    a8e1:	49 89 fc             	mov    %rdi,%r12
    a8e4:	48 89 df             	mov    %rbx,%rdi
    a8e7:	e8 34 ba ff ff       	call   6320 <fwp_rc_forget_slot>
    a8ec:	4c 89 e7             	mov    %r12,%rdi
    a8ef:	41 8b 36             	mov    (%r14),%esi
    a8f2:	e9 a1 fe ff ff       	jmp    a798 <fwp_mem_free+0xd8>
    a8f7:	48 89 df             	mov    %rbx,%rdi
    a8fa:	e8 21 ba ff ff       	call   6320 <fwp_rc_forget_slot>
    a8ff:	e9 13 ff ff ff       	jmp    a817 <fwp_mem_free+0x157>
    a904:	66 66 66 2e 0f 1f 84 	data16 data16 cs nopw 0x0(%rax,%rax,1)
    a90b:	00 00 00 00 00 

000000000000a910 <fwp_rc_free_obj>:
    a910:	48 89 f8             	mov    %rdi,%rax
    a913:	48 2b 05 96 88 00 00 	sub    0x8896(%rip),%rax        # 131b0 <fwp_gc+0x1030>
    a91a:	48 8b 0d b7 88 00 00 	mov    0x88b7(%rip),%rcx        # 131d8 <fwp_gc+0x1058>
    a921:	48 c1 e1 10          	shl    $0x10,%rcx
    a925:	48 39 c8             	cmp    %rcx,%rax
    a928:	0f 83 b8 01 00 00    	jae    aae6 <fwp_rc_free_obj+0x1d6>
    a92e:	55                   	push   %rbp
    a92f:	41 57                	push   %r15
    a931:	41 56                	push   %r14
    a933:	53                   	push   %rbx
    a934:	50                   	push   %rax
    a935:	48 8b 1d bc 88 00 00 	mov    0x88bc(%rip),%rbx        # 131f8 <fwp_gc+0x1078>
    a93c:	48 89 c1             	mov    %rax,%rcx
    a93f:	48 c1 e9 10          	shr    $0x10,%rcx
    a943:	4c 69 f1 28 12 00 00 	imul   $0x1228,%rcx,%r14
    a94a:	42 0f b6 2c 33       	movzbl (%rbx,%r14,1),%ebp
    a94f:	48 25 ff ff 00 00    	and    $0xffff,%rax
    a955:	75 1a                	jne    a971 <fwp_rc_free_obj+0x61>
    a957:	40 80 fd 02          	cmp    $0x2,%bpl
    a95b:	75 14                	jne    a971 <fwp_rc_free_obj+0x61>
    a95d:	4a 8d 04 33          	lea    (%rbx,%r14,1),%rax
    a961:	48 05 28 02 00 00    	add    $0x228,%rax
    a967:	80 38 01             	cmpb   $0x1,(%rax)
    a96a:	74 32                	je     a99e <fwp_rc_free_obj+0x8e>
    a96c:	e9 6b 01 00 00       	jmp    aadc <fwp_rc_free_obj+0x1cc>
    a971:	40 80 fd 01          	cmp    $0x1,%bpl
    a975:	0f 85 61 01 00 00    	jne    aadc <fwp_rc_free_obj+0x1cc>
    a97b:	4a 8d 0c 33          	lea    (%rbx,%r14,1),%rcx
    a97f:	42 8b 54 33 20       	mov    0x20(%rbx,%r14,1),%edx
    a984:	48 0f af c2          	imul   %rdx,%rax
    a988:	48 c1 e8 20          	shr    $0x20,%rax
    a98c:	48 01 c8             	add    %rcx,%rax
    a98f:	48 05 28 02 00 00    	add    $0x228,%rax
    a995:	80 38 01             	cmpb   $0x1,(%rax)
    a998:	0f 85 3e 01 00 00    	jne    aadc <fwp_rc_free_obj+0x1cc>
    a99e:	8b 0d fc 91 00 00    	mov    0x91fc(%rip),%ecx        # 13ba0 <fwp_reuse_verify>
    a9a4:	85 c9                	test   %ecx,%ecx
    a9a6:	0f 88 c3 00 00 00    	js     aa6f <fwp_rc_free_obj+0x15f>
    a9ac:	85 c9                	test   %ecx,%ecx
    a9ae:	0f 84 fd 00 00 00    	je     aab1 <fwp_rc_free_obj+0x1a1>
    a9b4:	42 80 7c 33 01 01    	cmpb   $0x1,0x1(%rbx,%r14,1)
    a9ba:	75 0d                	jne    a9c9 <fwp_rc_free_obj+0xb9>
    a9bc:	40 80 fd 02          	cmp    $0x2,%bpl
    a9c0:	75 22                	jne    a9e4 <fwp_rc_free_obj+0xd4>
    a9c2:	4a 8b 54 33 18       	mov    0x18(%rbx,%r14,1),%rdx
    a9c7:	eb 20                	jmp    a9e9 <fwp_rc_free_obj+0xd9>
    a9c9:	c7 07 ad de 00 00    	movl   $0xdead,(%rdi)
    a9cf:	8b 47 04             	mov    0x4(%rdi),%eax
    a9d2:	48 85 c0             	test   %rax,%rax
    a9d5:	0f 84 01 01 00 00    	je     aadc <fwp_rc_free_obj+0x1cc>
    a9db:	83 f8 04             	cmp    $0x4,%eax
    a9de:	73 26                	jae    aa06 <fwp_rc_free_obj+0xf6>
    a9e0:	31 c9                	xor    %ecx,%ecx
    a9e2:	eb 6a                	jmp    aa4e <fwp_rc_free_obj+0x13e>
    a9e4:	42 8b 54 33 08       	mov    0x8(%rbx,%r14,1),%edx
    a9e9:	48 89 fb             	mov    %rdi,%rbx
    a9ec:	be dd 00 00 00       	mov    $0xdd,%esi
    a9f1:	e8 3a 77 ff ff       	call   2130 <memset@plt>
    a9f6:	48 c7 03 00 00 00 00 	movq   $0x0,(%rbx)
    a9fd:	c6 43 08 00          	movb   $0x0,0x8(%rbx)
    aa01:	e9 d6 00 00 00       	jmp    aadc <fwp_rc_free_obj+0x1cc>
    aa06:	89 c1                	mov    %eax,%ecx
    aa08:	83 e1 fc             	and    $0xfffffffc,%ecx
    aa0b:	48 8d 14 c5 00 00 00 	lea    0x0(,%rax,8),%rdx
    aa12:	00 
    aa13:	48 83 e2 e0          	and    $0xffffffffffffffe0,%rdx
    aa17:	31 f6                	xor    %esi,%esi
    aa19:	66 0f 28 05 cf 46 00 	movapd 0x46cf(%rip),%xmm0        # f0f0 <_IO_stdin_used+0xf0>
    aa20:	00 
    aa21:	66 66 66 66 66 66 2e 	data16 data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    aa28:	0f 1f 84 00 00 00 00 
    aa2f:	00 
    aa30:	66 0f 11 44 37 08    	movupd %xmm0,0x8(%rdi,%rsi,1)
    aa36:	66 0f 11 44 37 18    	movupd %xmm0,0x18(%rdi,%rsi,1)
    aa3c:	48 83 c6 20          	add    $0x20,%rsi
    aa40:	48 39 f2             	cmp    %rsi,%rdx
    aa43:	75 eb                	jne    aa30 <fwp_rc_free_obj+0x120>
    aa45:	48 39 c1             	cmp    %rax,%rcx
    aa48:	0f 84 8e 00 00 00    	je     aadc <fwp_rc_free_obj+0x1cc>
    aa4e:	48 ba ef be ad de ef 	movabs $0xdeadbeefdeadbeef,%rdx
    aa55:	be ad de 
    aa58:	0f 1f 84 00 00 00 00 	nopl   0x0(%rax,%rax,1)
    aa5f:	00 
    aa60:	48 89 54 cf 08       	mov    %rdx,0x8(%rdi,%rcx,8)
    aa65:	48 ff c1             	inc    %rcx
    aa68:	48 39 c8             	cmp    %rcx,%rax
    aa6b:	75 f3                	jne    aa60 <fwp_rc_free_obj+0x150>
    aa6d:	eb 6d                	jmp    aadc <fwp_rc_free_obj+0x1cc>
    aa6f:	49 89 ff             	mov    %rdi,%r15
    aa72:	48 8d 3d 70 4a 00 00 	lea    0x4a70(%rip),%rdi        # f4e9 <fwp_segv.msg+0x2a9>
    aa79:	e8 b2 75 ff ff       	call   2030 <getenv@plt>
    aa7e:	31 c9                	xor    %ecx,%ecx
    aa80:	48 85 c0             	test   %rax,%rax
    aa83:	74 1b                	je     aaa0 <fwp_rc_free_obj+0x190>
    aa85:	80 38 00             	cmpb   $0x0,(%rax)
    aa88:	74 16                	je     aaa0 <fwp_rc_free_obj+0x190>
    aa8a:	48 8d 35 d1 4b 00 00 	lea    0x4bd1(%rip),%rsi        # f662 <fwp_segv.msg+0x422>
    aa91:	48 89 c7             	mov    %rax,%rdi
    aa94:	e8 e7 76 ff ff       	call   2180 <strcmp@plt>
    aa99:	31 c9                	xor    %ecx,%ecx
    aa9b:	85 c0                	test   %eax,%eax
    aa9d:	0f 95 c1             	setne  %cl
    aaa0:	89 0d fa 90 00 00    	mov    %ecx,0x90fa(%rip)        # 13ba0 <fwp_reuse_verify>
    aaa6:	4c 89 ff             	mov    %r15,%rdi
    aaa9:	85 c9                	test   %ecx,%ecx
    aaab:	0f 85 03 ff ff ff    	jne    a9b4 <fwp_rc_free_obj+0xa4>
    aab1:	48 8b 1d c8 76 00 00 	mov    0x76c8(%rip),%rbx        # 12180 <fwp_gc>
    aab8:	e8 03 fc ff ff       	call   a6c0 <fwp_mem_free>
    aabd:	48 8b 05 bc 76 00 00 	mov    0x76bc(%rip),%rax        # 12180 <fwp_gc>
    aac4:	48 29 d8             	sub    %rbx,%rax
    aac7:	f2 48 0f 2a c0       	cvtsi2sd %rax,%xmm0
    aacc:	f2 0f 58 05 b4 88 00 	addsd  0x88b4(%rip),%xmm0        # 13388 <fwp_gc+0x1208>
    aad3:	00 
    aad4:	f2 0f 11 05 ac 88 00 	movsd  %xmm0,0x88ac(%rip)        # 13388 <fwp_gc+0x1208>
    aadb:	00 
    aadc:	48 83 c4 08          	add    $0x8,%rsp
    aae0:	5b                   	pop    %rbx
    aae1:	41 5e                	pop    %r14
    aae3:	41 5f                	pop    %r15
    aae5:	5d                   	pop    %rbp
    aae6:	c3                   	ret
    aae7:	66 0f 1f 84 00 00 00 	nopw   0x0(%rax,%rax,1)
    aaee:	00 00 

000000000000aaf0 <fwp_owned_entry49>:
    aaf0:	48 8b 3f             	mov    (%rdi),%rdi
    aaf3:	e9 18 f5 ff ff       	jmp    a010 <f49>
    aaf8:	0f 1f 84 00 00 00 00 	nopl   0x0(%rax,%rax,1)
    aaff:	00 

000000000000ab00 <fwp_caps49>:
    ab00:	53                   	push   %rbx
    ab01:	83 7f 04 00          	cmpl   $0x0,0x4(%rdi)
    ab05:	74 56                	je     ab5d <fwp_caps49+0x5d>
    ab07:	48 89 fb             	mov    %rdi,%rbx
    ab0a:	48 8b 7f 08          	mov    0x8(%rdi),%rdi
    ab0e:	85 f6                	test   %esi,%esi
    ab10:	74 51                	je     ab63 <fwp_caps49+0x63>
    ab12:	48 2b 3d 97 86 00 00 	sub    0x8697(%rip),%rdi        # 131b0 <fwp_gc+0x1030>
    ab19:	48 8b 05 b8 86 00 00 	mov    0x86b8(%rip),%rax        # 131d8 <fwp_gc+0x1058>
    ab20:	48 c1 e0 10          	shl    $0x10,%rax
    ab24:	48 39 c7             	cmp    %rax,%rdi
    ab27:	73 38                	jae    ab61 <fwp_caps49+0x61>
    ab29:	48 8b 05 c8 86 00 00 	mov    0x86c8(%rip),%rax        # 131f8 <fwp_gc+0x1078>
    ab30:	48 89 f9             	mov    %rdi,%rcx
    ab33:	48 c1 e9 10          	shr    $0x10,%rcx
    ab37:	48 69 c9 28 12 00 00 	imul   $0x1228,%rcx,%rcx
    ab3e:	0f b6 14 08          	movzbl (%rax,%rcx,1),%edx
    ab42:	48 81 e7 ff ff 00 00 	and    $0xffff,%rdi
    ab49:	75 26                	jne    ab71 <fwp_caps49+0x71>
    ab4b:	80 fa 02             	cmp    $0x2,%dl
    ab4e:	75 21                	jne    ab71 <fwp_caps49+0x71>
    ab50:	48 8d 3c 08          	lea    (%rax,%rcx,1),%rdi
    ab54:	48 81 c7 28 02 00 00 	add    $0x228,%rdi
    ab5b:	eb 33                	jmp    ab90 <fwp_caps49+0x90>
    ab5d:	85 f6                	test   %esi,%esi
    ab5f:	74 0a                	je     ab6b <fwp_caps49+0x6b>
    ab61:	5b                   	pop    %rbx
    ab62:	c3                   	ret
    ab63:	e8 28 f8 ff ff       	call   a390 <fwp_drop6>
    ab68:	48 89 df             	mov    %rbx,%rdi
    ab6b:	5b                   	pop    %rbx
    ab6c:	e9 9f fd ff ff       	jmp    a910 <fwp_rc_free_obj>
    ab71:	80 fa 01             	cmp    $0x1,%dl
    ab74:	75 eb                	jne    ab61 <fwp_caps49+0x61>
    ab76:	48 8d 14 08          	lea    (%rax,%rcx,1),%rdx
    ab7a:	8b 44 08 20          	mov    0x20(%rax,%rcx,1),%eax
    ab7e:	48 0f af f8          	imul   %rax,%rdi
    ab82:	48 c1 ef 20          	shr    $0x20,%rdi
    ab86:	48 01 d7             	add    %rdx,%rdi
    ab89:	48 81 c7 28 02 00 00 	add    $0x228,%rdi
    ab90:	0f b6 07             	movzbl (%rdi),%eax
    ab93:	84 c0                	test   %al,%al
    ab95:	74 ca                	je     ab61 <fwp_caps49+0x61>
    ab97:	3c fe                	cmp    $0xfe,%al
    ab99:	73 06                	jae    aba1 <fwp_caps49+0xa1>
    ab9b:	fe c0                	inc    %al
    ab9d:	88 07                	mov    %al,(%rdi)
    ab9f:	5b                   	pop    %rbx
    aba0:	c3                   	ret
    aba1:	5b                   	pop    %rbx
    aba2:	e9 59 ca ff ff       	jmp    7600 <fwp_rc_wide_dup>
    aba7:	66 0f 1f 84 00 00 00 	nopw   0x0(%rax,%rax,1)
    abae:	00 00 

000000000000abb0 <fwp_args49>:
    abb0:	85 f6                	test   %esi,%esi
    abb2:	0f 85 8a 00 00 00    	jne    ac42 <fwp_args49+0x92>
    abb8:	85 d2                	test   %edx,%edx
    abba:	0f 84 82 00 00 00    	je     ac42 <fwp_args49+0x92>
    abc0:	48 8b 07             	mov    (%rdi),%rax
    abc3:	48 2b 05 e6 85 00 00 	sub    0x85e6(%rip),%rax        # 131b0 <fwp_gc+0x1030>
    abca:	48 8b 0d 07 86 00 00 	mov    0x8607(%rip),%rcx        # 131d8 <fwp_gc+0x1058>
    abd1:	48 c1 e1 10          	shl    $0x10,%rcx
    abd5:	48 39 c8             	cmp    %rcx,%rax
    abd8:	73 68                	jae    ac42 <fwp_args49+0x92>
    abda:	48 8b 0d 17 86 00 00 	mov    0x8617(%rip),%rcx        # 131f8 <fwp_gc+0x1078>
    abe1:	48 89 c2             	mov    %rax,%rdx
    abe4:	48 c1 ea 10          	shr    $0x10,%rdx
    abe8:	48 69 d2 28 12 00 00 	imul   $0x1228,%rdx,%rdx
    abef:	0f b6 34 11          	movzbl (%rcx,%rdx,1),%esi
    abf3:	48 25 ff ff 00 00    	and    $0xffff,%rax
    abf9:	75 13                	jne    ac0e <fwp_args49+0x5e>
    abfb:	40 80 fe 02          	cmp    $0x2,%sil
    abff:	75 0d                	jne    ac0e <fwp_args49+0x5e>
    ac01:	48 8d 3c 11          	lea    (%rcx,%rdx,1),%rdi
    ac05:	48 81 c7 28 02 00 00 	add    $0x228,%rdi
    ac0c:	eb 21                	jmp    ac2f <fwp_args49+0x7f>
    ac0e:	40 80 fe 01          	cmp    $0x1,%sil
    ac12:	75 2e                	jne    ac42 <fwp_args49+0x92>
    ac14:	48 8d 34 11          	lea    (%rcx,%rdx,1),%rsi
    ac18:	8b 4c 11 20          	mov    0x20(%rcx,%rdx,1),%ecx
    ac1c:	48 0f af c1          	imul   %rcx,%rax
    ac20:	48 c1 e8 20          	shr    $0x20,%rax
    ac24:	48 8d 3c 30          	lea    (%rax,%rsi,1),%rdi
    ac28:	48 81 c7 28 02 00 00 	add    $0x228,%rdi
    ac2f:	0f b6 07             	movzbl (%rdi),%eax
    ac32:	84 c0                	test   %al,%al
    ac34:	74 0c                	je     ac42 <fwp_args49+0x92>
    ac36:	3c fe                	cmp    $0xfe,%al
    ac38:	0f 83 c2 c9 ff ff    	jae    7600 <fwp_rc_wide_dup>
    ac3e:	fe c0                	inc    %al
    ac40:	88 07                	mov    %al,(%rdi)
    ac42:	c3                   	ret
    ac43:	66 66 66 66 2e 0f 1f 	data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    ac4a:	84 00 00 00 00 00 

000000000000ac50 <fwp_arg_drop49>:
    ac50:	85 f6                	test   %esi,%esi
    ac52:	75 0c                	jne    ac60 <fwp_arg_drop49+0x10>
    ac54:	85 d2                	test   %edx,%edx
    ac56:	74 08                	je     ac60 <fwp_arg_drop49+0x10>
    ac58:	48 8b 3f             	mov    (%rdi),%rdi
    ac5b:	e9 30 f7 ff ff       	jmp    a390 <fwp_drop6>
    ac60:	c3                   	ret
    ac61:	66 66 66 66 66 66 2e 	data16 data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    ac68:	0f 1f 84 00 00 00 00 
    ac6f:	00 

000000000000ac70 <fwp_p_loop_own>:
    ac70:	55                   	push   %rbp
    ac71:	41 57                	push   %r15
    ac73:	41 56                	push   %r14
    ac75:	41 55                	push   %r13
    ac77:	41 54                	push   %r12
    ac79:	53                   	push   %rbx
    ac7a:	48 83 ec 18          	sub    $0x18,%rsp
    ac7e:	49 89 fe             	mov    %rdi,%r14
    ac81:	48 89 34 24          	mov    %rsi,(%rsp)
    ac85:	48 89 7c 24 08       	mov    %rdi,0x8(%rsp)
    ac8a:	eb 0c                	jmp    ac98 <fwp_p_loop_own+0x28>
    ac8c:	0f 1f 40 00          	nopl   0x0(%rax)
    ac90:	fe c0                	inc    %al
    ac92:	88 07                	mov    %al,(%rdi)
    ac94:	48 89 34 24          	mov    %rsi,(%rsp)
    ac98:	8b 05 52 8f 00 00    	mov    0x8f52(%rip),%eax        # 13bf0 <fwp_budget>
    ac9e:	8d 48 ff             	lea    -0x1(%rax),%ecx
    aca1:	89 0d 49 8f 00 00    	mov    %ecx,0x8f49(%rip)        # 13bf0 <fwp_budget>
    aca7:	83 f8 01             	cmp    $0x1,%eax
    acaa:	0f 8e bb 03 00 00    	jle    b06b <fwp_p_loop_own+0x3fb>
    acb0:	48 89 34 24          	mov    %rsi,(%rsp)
    acb4:	4c 8b 25 05 8f 00 00 	mov    0x8f05(%rip),%r12        # 13bc0 <fwp_fns>
    acbb:	41 8b 06             	mov    (%r14),%eax
    acbe:	48 c1 e0 05          	shl    $0x5,%rax
    acc2:	49 83 7c 04 18 00    	cmpq   $0x0,0x18(%r12,%rax,1)
    acc8:	0f 84 62 01 00 00    	je     ae30 <fwp_p_loop_own+0x1c0>
    acce:	4d 8d 04 04          	lea    (%r12,%rax,1),%r8
    acd2:	49 83 c0 18          	add    $0x18,%r8
    acd6:	49 01 c4             	add    %rax,%r12
    acd9:	bd 01 00 00 00       	mov    $0x1,%ebp
    acde:	31 f6                	xor    %esi,%esi
    ace0:	4c 89 f0             	mov    %r14,%rax
    ace3:	49 89 e7             	mov    %rsp,%r15
    ace6:	41 bd 01 00 00 00    	mov    $0x1,%r13d
    acec:	0f 1f 40 00          	nopl   0x0(%rax)
    acf0:	40 f6 c6 01          	test   $0x1,%sil
    acf4:	0f 85 86 00 00 00    	jne    ad80 <fwp_p_loop_own+0x110>
    acfa:	48 89 c7             	mov    %rax,%rdi
    acfd:	48 2b 3d ac 84 00 00 	sub    0x84ac(%rip),%rdi        # 131b0 <fwp_gc+0x1030>
    ad04:	48 8b 0d cd 84 00 00 	mov    0x84cd(%rip),%rcx        # 131d8 <fwp_gc+0x1058>
    ad0b:	48 c1 e1 10          	shl    $0x10,%rcx
    ad0f:	48 39 cf             	cmp    %rcx,%rdi
    ad12:	73 6c                	jae    ad80 <fwp_p_loop_own+0x110>
    ad14:	48 8b 0d dd 84 00 00 	mov    0x84dd(%rip),%rcx        # 131f8 <fwp_gc+0x1078>
    ad1b:	48 89 fa             	mov    %rdi,%rdx
    ad1e:	48 c1 ea 10          	shr    $0x10,%rdx
    ad22:	48 69 d2 28 12 00 00 	imul   $0x1228,%rdx,%rdx
    ad29:	0f b6 34 11          	movzbl (%rcx,%rdx,1),%esi
    ad2d:	48 81 e7 ff ff 00 00 	and    $0xffff,%rdi
    ad34:	75 13                	jne    ad49 <fwp_p_loop_own+0xd9>
    ad36:	40 80 fe 02          	cmp    $0x2,%sil
    ad3a:	75 0d                	jne    ad49 <fwp_p_loop_own+0xd9>
    ad3c:	48 8d 3c 11          	lea    (%rcx,%rdx,1),%rdi
    ad40:	48 81 c7 28 02 00 00 	add    $0x228,%rdi
    ad47:	eb 20                	jmp    ad69 <fwp_p_loop_own+0xf9>
    ad49:	40 80 fe 01          	cmp    $0x1,%sil
    ad4d:	75 31                	jne    ad80 <fwp_p_loop_own+0x110>
    ad4f:	48 8d 34 11          	lea    (%rcx,%rdx,1),%rsi
    ad53:	8b 4c 11 20          	mov    0x20(%rcx,%rdx,1),%ecx
    ad57:	48 0f af f9          	imul   %rcx,%rdi
    ad5b:	48 c1 ef 20          	shr    $0x20,%rdi
    ad5f:	48 01 f7             	add    %rsi,%rdi
    ad62:	48 81 c7 28 02 00 00 	add    $0x228,%rdi
    ad69:	0f b6 0f             	movzbl (%rdi),%ecx
    ad6c:	84 c9                	test   %cl,%cl
    ad6e:	74 10                	je     ad80 <fwp_p_loop_own+0x110>
    ad70:	80 f9 fe             	cmp    $0xfe,%cl
    ad73:	0f 83 9f 00 00 00    	jae    ae18 <fwp_p_loop_own+0x1a8>
    ad79:	fe c1                	inc    %cl
    ad7b:	88 0f                	mov    %cl,(%rdi)
    ad7d:	0f 1f 00             	nopl   (%rax)
    ad80:	41 8b 1c 24          	mov    (%r12),%ebx
    ad84:	8b 70 04             	mov    0x4(%rax),%esi
    ad87:	29 f3                	sub    %esi,%ebx
    ad89:	39 dd                	cmp    %ebx,%ebp
    ad8b:	41 89 dc             	mov    %ebx,%r12d
    ad8e:	44 0f 42 e5          	cmovb  %ebp,%r12d
    ad92:	45 89 e6             	mov    %r12d,%r14d
    ad95:	45 39 e5             	cmp    %r12d,%r13d
    ad98:	45 0f 42 f5          	cmovb  %r13d,%r14d
    ad9c:	73 2d                	jae    adcb <fwp_p_loop_own+0x15b>
    ad9e:	44 89 e2             	mov    %r12d,%edx
    ada1:	44 29 f2             	sub    %r14d,%edx
    ada4:	4d 8b 00             	mov    (%r8),%r8
    ada7:	44 89 f1             	mov    %r14d,%ecx
    adaa:	49 8d 3c cf          	lea    (%r15,%rcx,8),%rdi
    adae:	44 01 f6             	add    %r14d,%esi
    adb1:	4c 89 7c 24 10       	mov    %r15,0x10(%rsp)
    adb6:	41 89 ef             	mov    %ebp,%r15d
    adb9:	48 89 c5             	mov    %rax,%rbp
    adbc:	41 ff 50 10          	call   *0x10(%r8)
    adc0:	48 89 e8             	mov    %rbp,%rax
    adc3:	44 89 fd             	mov    %r15d,%ebp
    adc6:	4c 8b 7c 24 10       	mov    0x10(%rsp),%r15
    adcb:	48 89 c7             	mov    %rax,%rdi
    adce:	44 89 e6             	mov    %r12d,%esi
    add1:	4c 89 fa             	mov    %r15,%rdx
    add4:	e8 b7 08 00 00       	call   b690 <fwp_apply_owned>
    add9:	39 dd                	cmp    %ebx,%ebp
    addb:	0f 86 bf 00 00 00    	jbe    aea0 <fwp_p_loop_own+0x230>
    ade1:	44 89 e1             	mov    %r12d,%ecx
    ade4:	4d 8d 3c cf          	lea    (%r15,%rcx,8),%r15
    ade8:	44 29 e5             	sub    %r12d,%ebp
    adeb:	45 29 f5             	sub    %r14d,%r13d
    adee:	48 8b 0d cb 8d 00 00 	mov    0x8dcb(%rip),%rcx        # 13bc0 <fwp_fns>
    adf5:	8b 10                	mov    (%rax),%edx
    adf7:	48 c1 e2 05          	shl    $0x5,%rdx
    adfb:	4c 8d 24 11          	lea    (%rcx,%rdx,1),%r12
    adff:	4c 8d 04 11          	lea    (%rcx,%rdx,1),%r8
    ae03:	49 83 c0 18          	add    $0x18,%r8
    ae07:	40 b6 01             	mov    $0x1,%sil
    ae0a:	48 83 7c 11 18 00    	cmpq   $0x0,0x18(%rcx,%rdx,1)
    ae10:	0f 85 da fe ff ff    	jne    acf0 <fwp_p_loop_own+0x80>
    ae16:	eb 23                	jmp    ae3b <fwp_p_loop_own+0x1cb>
    ae18:	48 89 c3             	mov    %rax,%rbx
    ae1b:	4d 89 c6             	mov    %r8,%r14
    ae1e:	e8 dd c7 ff ff       	call   7600 <fwp_rc_wide_dup>
    ae23:	4d 89 f0             	mov    %r14,%r8
    ae26:	48 89 d8             	mov    %rbx,%rax
    ae29:	e9 52 ff ff ff       	jmp    ad80 <fwp_p_loop_own+0x110>
    ae2e:	66 90                	xchg   %ax,%ax
    ae30:	bd 01 00 00 00       	mov    $0x1,%ebp
    ae35:	49 89 e7             	mov    %rsp,%r15
    ae38:	4c 89 f0             	mov    %r14,%rax
    ae3b:	4c 8b 1d 6e 83 00 00 	mov    0x836e(%rip),%r11        # 131b0 <fwp_gc+0x1030>
    ae42:	48 89 c2             	mov    %rax,%rdx
    ae45:	4c 29 da             	sub    %r11,%rdx
    ae48:	48 8b 0d 89 83 00 00 	mov    0x8389(%rip),%rcx        # 131d8 <fwp_gc+0x1058>
    ae4f:	48 c1 e1 10          	shl    $0x10,%rcx
    ae53:	48 39 ca             	cmp    %rcx,%rdx
    ae56:	4c 8b 74 24 08       	mov    0x8(%rsp),%r14
    ae5b:	0f 83 8f 00 00 00    	jae    aef0 <fwp_p_loop_own+0x280>
    ae61:	48 8b 35 90 83 00 00 	mov    0x8390(%rip),%rsi        # 131f8 <fwp_gc+0x1078>
    ae68:	48 89 d7             	mov    %rdx,%rdi
    ae6b:	48 c1 ef 10          	shr    $0x10,%rdi
    ae6f:	48 69 ff 28 12 00 00 	imul   $0x1228,%rdi,%rdi
    ae76:	44 0f b6 04 3e       	movzbl (%rsi,%rdi,1),%r8d
    ae7b:	48 81 e2 ff ff 00 00 	and    $0xffff,%rdx
    ae82:	75 34                	jne    aeb8 <fwp_p_loop_own+0x248>
    ae84:	41 80 f8 02          	cmp    $0x2,%r8b
    ae88:	75 2e                	jne    aeb8 <fwp_p_loop_own+0x248>
    ae8a:	48 8d 14 3e          	lea    (%rsi,%rdi,1),%rdx
    ae8e:	48 81 c2 28 02 00 00 	add    $0x228,%rdx
    ae95:	80 3a 00             	cmpb   $0x0,(%rdx)
    ae98:	74 56                	je     aef0 <fwp_p_loop_own+0x280>
    ae9a:	e9 f3 01 00 00       	jmp    b092 <fwp_p_loop_own+0x422>
    ae9f:	90                   	nop
    aea0:	4c 8b 74 24 08       	mov    0x8(%rsp),%r14
    aea5:	48 3d ff 0f 00 00    	cmp    $0xfff,%rax
    aeab:	0f 86 00 01 00 00    	jbe    afb1 <fwp_p_loop_own+0x341>
    aeb1:	8b 08                	mov    (%rax),%ecx
    aeb3:	e9 fb 00 00 00       	jmp    afb3 <fwp_p_loop_own+0x343>
    aeb8:	41 80 f8 01          	cmp    $0x1,%r8b
    aebc:	75 32                	jne    aef0 <fwp_p_loop_own+0x280>
    aebe:	4c 8d 04 3e          	lea    (%rsi,%rdi,1),%r8
    aec2:	8b 74 3e 20          	mov    0x20(%rsi,%rdi,1),%esi
    aec6:	48 0f af d6          	imul   %rsi,%rdx
    aeca:	48 c1 ea 20          	shr    $0x20,%rdx
    aece:	4c 01 c2             	add    %r8,%rdx
    aed1:	48 81 c2 28 02 00 00 	add    $0x228,%rdx
    aed8:	80 3a 00             	cmpb   $0x0,(%rdx)
    aedb:	0f 85 b1 01 00 00    	jne    b092 <fwp_p_loop_own+0x422>
    aee1:	66 66 66 66 66 66 2e 	data16 data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    aee8:	0f 1f 84 00 00 00 00 
    aeef:	00 
    aef0:	85 ed                	test   %ebp,%ebp
    aef2:	0f 84 a0 00 00 00    	je     af98 <fwp_p_loop_own+0x328>
    aef8:	48 8b 15 f9 82 00 00 	mov    0x82f9(%rip),%rdx        # 131f8 <fwp_gc+0x1078>
    aeff:	89 ee                	mov    %ebp,%esi
    af01:	31 ff                	xor    %edi,%edi
    af03:	eb 2b                	jmp    af30 <fwp_p_loop_own+0x2c0>
    af05:	66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
    af0c:	00 00 00 00 
    af10:	4e 8d 04 0a          	lea    (%rdx,%r9,1),%r8
    af14:	49 81 c0 28 02 00 00 	add    $0x228,%r8
    af1b:	41 80 38 00          	cmpb   $0x0,(%r8)
    af1f:	74 6f                	je     af90 <fwp_p_loop_own+0x320>
    af21:	e9 6c 01 00 00       	jmp    b092 <fwp_p_loop_own+0x422>
    af26:	66 2e 0f 1f 84 00 00 	cs nopw 0x0(%rax,%rax,1)
    af2d:	00 00 00 
    af30:	4d 8b 04 ff          	mov    (%r15,%rdi,8),%r8
    af34:	4d 29 d8             	sub    %r11,%r8
    af37:	49 39 c8             	cmp    %rcx,%r8
    af3a:	73 54                	jae    af90 <fwp_p_loop_own+0x320>
    af3c:	4d 89 c1             	mov    %r8,%r9
    af3f:	49 c1 e9 10          	shr    $0x10,%r9
    af43:	4d 69 c9 28 12 00 00 	imul   $0x1228,%r9,%r9
    af4a:	46 0f b6 14 0a       	movzbl (%rdx,%r9,1),%r10d
    af4f:	49 81 e0 ff ff 00 00 	and    $0xffff,%r8
    af56:	75 06                	jne    af5e <fwp_p_loop_own+0x2ee>
    af58:	41 80 fa 02          	cmp    $0x2,%r10b
    af5c:	74 b2                	je     af10 <fwp_p_loop_own+0x2a0>
    af5e:	41 80 fa 01          	cmp    $0x1,%r10b
    af62:	75 2c                	jne    af90 <fwp_p_loop_own+0x320>
    af64:	4e 8d 14 0a          	lea    (%rdx,%r9,1),%r10
    af68:	46 8b 4c 0a 20       	mov    0x20(%rdx,%r9,1),%r9d
    af6d:	4d 0f af c1          	imul   %r9,%r8
    af71:	49 c1 e8 20          	shr    $0x20,%r8
    af75:	4d 01 d0             	add    %r10,%r8
    af78:	49 81 c0 28 02 00 00 	add    $0x228,%r8
    af7f:	41 80 38 00          	cmpb   $0x0,(%r8)
    af83:	0f 85 09 01 00 00    	jne    b092 <fwp_p_loop_own+0x422>
    af89:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)
    af90:	48 ff c7             	inc    %rdi
    af93:	48 39 fe             	cmp    %rdi,%rsi
    af96:	75 98                	jne    af30 <fwp_p_loop_own+0x2c0>
    af98:	48 89 c7             	mov    %rax,%rdi
    af9b:	89 ee                	mov    %ebp,%esi
    af9d:	4c 89 fa             	mov    %r15,%rdx
    afa0:	e8 8b 01 00 00       	call   b130 <fwp_apply>
    afa5:	48 3d ff 0f 00 00    	cmp    $0xfff,%rax
    afab:	0f 87 00 ff ff ff    	ja     aeb1 <fwp_p_loop_own+0x241>
    afb1:	89 c1                	mov    %eax,%ecx
    afb3:	48 8b 70 08          	mov    0x8(%rax),%rsi
    afb7:	85 c9                	test   %ecx,%ecx
    afb9:	0f 85 bc 00 00 00    	jne    b07b <fwp_p_loop_own+0x40b>
    afbf:	48 89 f0             	mov    %rsi,%rax
    afc2:	48 2b 05 e7 81 00 00 	sub    0x81e7(%rip),%rax        # 131b0 <fwp_gc+0x1030>
    afc9:	48 8b 0d 08 82 00 00 	mov    0x8208(%rip),%rcx        # 131d8 <fwp_gc+0x1058>
    afd0:	48 c1 e1 10          	shl    $0x10,%rcx
    afd4:	48 39 c8             	cmp    %rcx,%rax
    afd7:	0f 83 b7 fc ff ff    	jae    ac94 <fwp_p_loop_own+0x24>
    afdd:	48 8b 0d 14 82 00 00 	mov    0x8214(%rip),%rcx        # 131f8 <fwp_gc+0x1078>
    afe4:	48 89 c2             	mov    %rax,%rdx
    afe7:	48 c1 ea 10          	shr    $0x10,%rdx
    afeb:	48 69 d2 28 12 00 00 	imul   $0x1228,%rdx,%rdx
    aff2:	0f b6 3c 11          	movzbl (%rcx,%rdx,1),%edi
    aff6:	48 25 ff ff 00 00    	and    $0xffff,%rax
    affc:	75 22                	jne    b020 <fwp_p_loop_own+0x3b0>
    affe:	40 80 ff 02          	cmp    $0x2,%dil
    b002:	75 1c                	jne    b020 <fwp_p_loop_own+0x3b0>
    b004:	48 8d 3c 11          	lea    (%rcx,%rdx,1),%rdi
    b008:	48 81 c7 28 02 00 00 	add    $0x228,%rdi
    b00f:	eb 33                	jmp    b044 <fwp_p_loop_own+0x3d4>
    b011:	66 66 66 66 66 66 2e 	data16 data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    b018:	0f 1f 84 00 00 00 00 
    b01f:	00 
    b020:	40 80 ff 01          	cmp    $0x1,%dil
    b024:	0f 85 6a fc ff ff    	jne    ac94 <fwp_p_loop_own+0x24>
    b02a:	48 8d 3c 11          	lea    (%rcx,%rdx,1),%rdi
    b02e:	8b 4c 11 20          	mov    0x20(%rcx,%rdx,1),%ecx
    b032:	48 0f af c1          	imul   %rcx,%rax
    b036:	48 c1 e8 20          	shr    $0x20,%rax
    b03a:	48 01 c7             	add    %rax,%rdi
    b03d:	48 81 c7 28 02 00 00 	add    $0x228,%rdi
    b044:	0f b6 07             	movzbl (%rdi),%eax
    b047:	84 c0                	test   %al,%al
    b049:	0f 84 45 fc ff ff    	je     ac94 <fwp_p_loop_own+0x24>
    b04f:	3c fe                	cmp    $0xfe,%al
    b051:	0f 82 39 fc ff ff    	jb     ac90 <fwp_p_loop_own+0x20>
    b057:	48 89 f3             	mov    %rsi,%rbx
    b05a:	e8 a1 c5 ff ff       	call   7600 <fwp_rc_wide_dup>
    b05f:	48 89 de             	mov    %rbx,%rsi
    b062:	48 89 1c 24          	mov    %rbx,(%rsp)
    b066:	e9 2d fc ff ff       	jmp    ac98 <fwp_p_loop_own+0x28>
    b06b:	48 89 f3             	mov    %rsi,%rbx
    b06e:	e8 4d 00 00 00       	call   b0c0 <fwp_preempt>
    b073:	48 89 de             	mov    %rbx,%rsi
    b076:	e9 35 fc ff ff       	jmp    acb0 <fwp_p_loop_own+0x40>
    b07b:	48 89 34 24          	mov    %rsi,(%rsp)
    b07f:	48 8b 04 24          	mov    (%rsp),%rax
    b083:	48 83 c4 18          	add    $0x18,%rsp
    b087:	5b                   	pop    %rbx
    b088:	41 5c                	pop    %r12
    b08a:	41 5d                	pop    %r13
    b08c:	41 5e                	pop    %r14
    b08e:	41 5f                	pop    %r15
    b090:	5d                   	pop    %rbp
    b091:	c3                   	ret
    b092:	e8 59 b2 ff ff       	call   62f0 <fwp_flush>
    b097:	48 8b 05 42 6f 00 00 	mov    0x6f42(%rip),%rax        # 11fe0 <stderr@GLIBC_2.2.5>
    b09e:	48 8b 38             	mov    (%rax),%rdi
    b0a1:	48 8d 35 85 43 00 00 	lea    0x4385(%rip),%rsi        # f42d <fwp_segv.msg+0x1ed>
    b0a8:	48 8d 15 51 43 00 00 	lea    0x4351(%rip),%rdx        # f400 <fwp_segv.msg+0x1c0>
    b0af:	31 c0                	xor    %eax,%eax
    b0b1:	e8 fa 70 ff ff       	call   21b0 <fprintf@plt>
    b0b6:	bf 65 00 00 00       	mov    $0x65,%edi
    b0bb:	e8 d0 71 ff ff       	call   2290 <exit@plt>

000000000000b0c0 <fwp_preempt>:
    b0c0:	8b 0d 2e 8b 00 00    	mov    0x8b2e(%rip),%ecx        # 13bf4 <fwp_slice>
    b0c6:	85 c9                	test   %ecx,%ecx
    b0c8:	74 07                	je     b0d1 <fwp_preempt+0x11>
    b0ca:	89 0d 20 8b 00 00    	mov    %ecx,0x8b20(%rip)        # 13bf0 <fwp_budget>
    b0d0:	c3                   	ret
    b0d1:	50                   	push   %rax
    b0d2:	48 8d 3d d0 45 00 00 	lea    0x45d0(%rip),%rdi        # f6a9 <fwp_segv.msg+0x469>
    b0d9:	e8 52 6f ff ff       	call   2030 <getenv@plt>
    b0de:	48 89 c7             	mov    %rax,%rdi
    b0e1:	b8 10 27 00 00       	mov    $0x2710,%eax
    b0e6:	48 85 ff             	test   %rdi,%rdi
    b0e9:	74 11                	je     b0fc <fwp_preempt+0x3c>
    b0eb:	80 3f 00             	cmpb   $0x0,(%rdi)
    b0ee:	74 0c                	je     b0fc <fwp_preempt+0x3c>
    b0f0:	31 f6                	xor    %esi,%esi
    b0f2:	ba 0a 00 00 00       	mov    $0xa,%edx
    b0f7:	e8 a4 70 ff ff       	call   21a0 <strtoll@plt>
    b0fc:	48 8d 88 00 00 00 80 	lea    -0x80000000(%rax),%rcx
    b103:	48 81 f9 01 00 00 80 	cmp    $0xffffffff80000001,%rcx
    b10a:	b9 ff ff ff 7f       	mov    $0x7fffffff,%ecx
    b10f:	0f 43 c8             	cmovae %eax,%ecx
    b112:	89 0d dc 8a 00 00    	mov    %ecx,0x8adc(%rip)        # 13bf4 <fwp_slice>
    b118:	48 83 c4 08          	add    $0x8,%rsp
    b11c:	89 0d ce 8a 00 00    	mov    %ecx,0x8ace(%rip)        # 13bf0 <fwp_budget>
    b122:	c3                   	ret
    b123:	66 66 66 66 2e 0f 1f 	data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    b12a:	84 00 00 00 00 00 

000000000000b130 <fwp_apply>:
    b130:	55                   	push   %rbp
    b131:	48 89 e5             	mov    %rsp,%rbp
    b134:	41 57                	push   %r15
    b136:	41 56                	push   %r14
    b138:	41 55                	push   %r13
    b13a:	41 54                	push   %r12
    b13c:	53                   	push   %rbx
    b13d:	48 83 ec 18          	sub    $0x18,%rsp
    b141:	48 89 d3             	mov    %rdx,%rbx
    b144:	49 89 ff             	mov    %rdi,%r15
    b147:	eb 23                	jmp    b16c <fwp_apply+0x3c>
    b149:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)
    b150:	4a 8d 1c f3          	lea    (%rbx,%r14,8),%rbx
    b154:	31 c9                	xor    %ecx,%ecx
    b156:	49 89 c7             	mov    %rax,%r15
    b159:	4c 8b 75 c8          	mov    -0x38(%rbp),%r14
    b15d:	48 8b 65 c0          	mov    -0x40(%rbp),%rsp
    b161:	89 d6                	mov    %edx,%esi
    b163:	83 f9 01             	cmp    $0x1,%ecx
    b166:	0f 84 aa 04 00 00    	je     b616 <fwp_apply+0x4e6>
    b16c:	48 8b 05 4d 8a 00 00 	mov    0x8a4d(%rip),%rax        # 13bc0 <fwp_fns>
    b173:	41 8b 0f             	mov    (%r15),%ecx
    b176:	45 8b 6f 04          	mov    0x4(%r15),%r13d
    b17a:	48 c1 e1 05          	shl    $0x5,%rcx
    b17e:	44 8b 24 08          	mov    (%rax,%rcx,1),%r12d
    b182:	4d 85 ed             	test   %r13,%r13
    b185:	75 39                	jne    b1c0 <fwp_apply+0x90>
    b187:	41 8d 54 24 ff       	lea    -0x1(%r12),%edx
    b18c:	39 f2                	cmp    %esi,%edx
    b18e:	73 30                	jae    b1c0 <fwp_apply+0x90>
    b190:	48 89 df             	mov    %rbx,%rdi
    b193:	49 89 f7             	mov    %rsi,%r15
    b196:	ff 54 08 08          	call   *0x8(%rax,%rcx,1)
    b19a:	4c 89 fe             	mov    %r15,%rsi
    b19d:	49 89 c7             	mov    %rax,%r15
    b1a0:	44 39 e6             	cmp    %r12d,%esi
    b1a3:	0f 84 a4 02 00 00    	je     b44d <fwp_apply+0x31d>
    b1a9:	4a 8d 1c e3          	lea    (%rbx,%r12,8),%rbx
    b1ad:	44 29 e6             	sub    %r12d,%esi
    b1b0:	b9 03 00 00 00       	mov    $0x3,%ecx
    b1b5:	83 f9 01             	cmp    $0x1,%ecx
    b1b8:	75 b2                	jne    b16c <fwp_apply+0x3c>
    b1ba:	e9 57 04 00 00       	jmp    b616 <fwp_apply+0x4e6>
    b1bf:	90                   	nop
    b1c0:	4c 89 75 c8          	mov    %r14,-0x38(%rbp)
    b1c4:	46 8d 34 2e          	lea    (%rsi,%r13,1),%r14d
    b1c8:	45 39 e6             	cmp    %r12d,%r14d
    b1cb:	48 89 75 d0          	mov    %rsi,-0x30(%rbp)
    b1cf:	0f 82 1a 02 00 00    	jb     b3ef <fwp_apply+0x2bf>
    b1d5:	48 89 65 c0          	mov    %rsp,-0x40(%rbp)
    b1d9:	45 89 e3             	mov    %r12d,%r11d
    b1dc:	41 83 fc 02          	cmp    $0x2,%r12d
    b1e0:	ba 01 00 00 00       	mov    $0x1,%edx
    b1e5:	41 0f 43 d4          	cmovae %r12d,%edx
    b1e9:	48 8d 14 d5 0f 00 00 	lea    0xf(,%rdx,8),%rdx
    b1f0:	00 
    b1f1:	48 83 e2 f0          	and    $0xfffffffffffffff0,%rdx
    b1f5:	48 89 e7             	mov    %rsp,%rdi
    b1f8:	48 29 d7             	sub    %rdx,%rdi
    b1fb:	48 89 fc             	mov    %rdi,%rsp
    b1fe:	4d 85 ed             	test   %r13,%r13
    b201:	0f 84 c9 00 00 00    	je     b2d0 <fwp_apply+0x1a0>
    b207:	41 83 fd 04          	cmp    $0x4,%r13d
    b20b:	72 10                	jb     b21d <fwp_apply+0xed>
    b20d:	48 89 fa             	mov    %rdi,%rdx
    b210:	4c 29 fa             	sub    %r15,%rdx
    b213:	48 83 c2 f8          	add    $0xfffffffffffffff8,%rdx
    b217:	48 83 fa 20          	cmp    $0x20,%rdx
    b21b:	73 65                	jae    b282 <fwp_apply+0x152>
    b21d:	31 d2                	xor    %edx,%edx
    b21f:	4d 89 e8             	mov    %r13,%r8
    b222:	49 89 d2             	mov    %rdx,%r10
    b225:	49 83 e0 03          	and    $0x3,%r8
    b229:	74 16                	je     b241 <fwp_apply+0x111>
    b22b:	49 89 d2             	mov    %rdx,%r10
    b22e:	66 90                	xchg   %ax,%ax
    b230:	4f 8b 4c d7 08       	mov    0x8(%r15,%r10,8),%r9
    b235:	4e 89 0c d7          	mov    %r9,(%rdi,%r10,8)
    b239:	49 ff c2             	inc    %r10
    b23c:	49 ff c8             	dec    %r8
    b23f:	75 ef                	jne    b230 <fwp_apply+0x100>
    b241:	4c 29 ea             	sub    %r13,%rdx
    b244:	48 83 fa fc          	cmp    $0xfffffffffffffffc,%rdx
    b248:	0f 87 82 00 00 00    	ja     b2d0 <fwp_apply+0x1a0>
    b24e:	66 90                	xchg   %ax,%ax
    b250:	4b 8b 54 d7 08       	mov    0x8(%r15,%r10,8),%rdx
    b255:	4a 89 14 d7          	mov    %rdx,(%rdi,%r10,8)
    b259:	4b 8b 54 d7 10       	mov    0x10(%r15,%r10,8),%rdx
    b25e:	4a 89 54 d7 08       	mov    %rdx,0x8(%rdi,%r10,8)
    b263:	4b 8b 54 d7 18       	mov    0x18(%r15,%r10,8),%rdx
    b268:	4a 89 54 d7 10       	mov    %rdx,0x10(%rdi,%r10,8)
    b26d:	4b 8b 54 d7 20       	mov    0x20(%r15,%r10,8),%rdx
    b272:	4a 89 54 d7 18       	mov    %rdx,0x18(%rdi,%r10,8)
    b277:	49 83 c2 04          	add    $0x4,%r10
    b27b:	4d 39 d5             	cmp    %r10,%r13
    b27e:	75 d0                	jne    b250 <fwp_apply+0x120>
    b280:	eb 4e                	jmp    b2d0 <fwp_apply+0x1a0>
    b282:	44 89 ea             	mov    %r13d,%edx
    b285:	83 e2 fc             	and    $0xfffffffc,%edx
    b288:	4e 8d 0c ed 00 00 00 	lea    0x0(,%r13,8),%r9
    b28f:	00 
    b290:	49 83 e1 e0          	and    $0xffffffffffffffe0,%r9
    b294:	45 31 c0             	xor    %r8d,%r8d
    b297:	66 0f 1f 84 00 00 00 	nopw   0x0(%rax,%rax,1)
    b29e:	00 00 
    b2a0:	43 0f 10 44 07 08    	movups 0x8(%r15,%r8,1),%xmm0
    b2a6:	43 0f 10 4c 07 18    	movups 0x18(%r15,%r8,1),%xmm1
    b2ac:	42 0f 29 04 07       	movaps %xmm0,(%rdi,%r8,1)
    b2b1:	42 0f 29 4c 07 10    	movaps %xmm1,0x10(%rdi,%r8,1)
    b2b7:	49 83 c0 20          	add    $0x20,%r8
    b2bb:	4d 39 c1             	cmp    %r8,%r9
    b2be:	75 e0                	jne    b2a0 <fwp_apply+0x170>
    b2c0:	4c 39 ea             	cmp    %r13,%rdx
    b2c3:	0f 85 56 ff ff ff    	jne    b21f <fwp_apply+0xef>
    b2c9:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)
    b2d0:	45 29 eb             	sub    %r13d,%r11d
    b2d3:	45 89 de             	mov    %r11d,%r14d
    b2d6:	45 39 ec             	cmp    %r13d,%r12d
    b2d9:	0f 84 85 00 00 00    	je     b364 <fwp_apply+0x234>
    b2df:	41 83 fb 0e          	cmp    $0xe,%r11d
    b2e3:	0f 83 a0 00 00 00    	jae    b389 <fwp_apply+0x259>
    b2e9:	31 d2                	xor    %edx,%edx
    b2eb:	4d 89 f0             	mov    %r14,%r8
    b2ee:	48 89 d6             	mov    %rdx,%rsi
    b2f1:	49 83 e0 03          	and    $0x3,%r8
    b2f5:	74 1d                	je     b314 <fwp_apply+0x1e4>
    b2f7:	48 89 d6             	mov    %rdx,%rsi
    b2fa:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)
    b300:	4c 8b 0c f3          	mov    (%rbx,%rsi,8),%r9
    b304:	46 8d 14 2e          	lea    (%rsi,%r13,1),%r10d
    b308:	4e 89 0c d7          	mov    %r9,(%rdi,%r10,8)
    b30c:	48 ff c6             	inc    %rsi
    b30f:	49 ff c8             	dec    %r8
    b312:	75 ec                	jne    b300 <fwp_apply+0x1d0>
    b314:	4c 29 f2             	sub    %r14,%rdx
    b317:	48 83 fa fc          	cmp    $0xfffffffffffffffc,%rdx
    b31b:	77 47                	ja     b364 <fwp_apply+0x234>
    b31d:	0f 1f 00             	nopl   (%rax)
    b320:	48 8b 14 f3          	mov    (%rbx,%rsi,8),%rdx
    b324:	46 8d 04 2e          	lea    (%rsi,%r13,1),%r8d
    b328:	4a 89 14 c7          	mov    %rdx,(%rdi,%r8,8)
    b32c:	48 8b 54 f3 08       	mov    0x8(%rbx,%rsi,8),%rdx
    b331:	46 8d 04 2e          	lea    (%rsi,%r13,1),%r8d
    b335:	41 ff c0             	inc    %r8d
    b338:	4a 89 14 c7          	mov    %rdx,(%rdi,%r8,8)
    b33c:	48 8b 54 f3 10       	mov    0x10(%rbx,%rsi,8),%rdx
    b341:	45 8d 44 35 02       	lea    0x2(%r13,%rsi,1),%r8d
    b346:	4a 89 14 c7          	mov    %rdx,(%rdi,%r8,8)
    b34a:	48 8b 54 f3 18       	mov    0x18(%rbx,%rsi,8),%rdx
    b34f:	46 8d 04 2e          	lea    (%rsi,%r13,1),%r8d
    b353:	41 83 c0 03          	add    $0x3,%r8d
    b357:	4a 89 14 c7          	mov    %rdx,(%rdi,%r8,8)
    b35b:	48 83 c6 04          	add    $0x4,%rsi
    b35f:	49 39 f6             	cmp    %rsi,%r14
    b362:	75 bc                	jne    b320 <fwp_apply+0x1f0>
    b364:	45 89 dc             	mov    %r11d,%r12d
    b367:	ff 54 08 08          	call   *0x8(%rax,%rcx,1)
    b36b:	b9 01 00 00 00       	mov    $0x1,%ecx
    b370:	48 8b 75 d0          	mov    -0x30(%rbp),%rsi
    b374:	89 f2                	mov    %esi,%edx
    b376:	44 29 e2             	sub    %r12d,%edx
    b379:	0f 85 d1 fd ff ff    	jne    b150 <fwp_apply+0x20>
    b37f:	89 f2                	mov    %esi,%edx
    b381:	49 89 c6             	mov    %rax,%r14
    b384:	e9 d4 fd ff ff       	jmp    b15d <fwp_apply+0x2d>
    b389:	49 8d 56 ff          	lea    -0x1(%r14),%rdx
    b38d:	89 d6                	mov    %edx,%esi
    b38f:	44 01 ee             	add    %r13d,%esi
    b392:	0f 82 51 ff ff ff    	jb     b2e9 <fwp_apply+0x1b9>
    b398:	48 c1 ea 20          	shr    $0x20,%rdx
    b39c:	ba 00 00 00 00       	mov    $0x0,%edx
    b3a1:	0f 85 44 ff ff ff    	jne    b2eb <fwp_apply+0x1bb>
    b3a7:	4a 8d 14 ef          	lea    (%rdi,%r13,8),%rdx
    b3ab:	48 29 da             	sub    %rbx,%rdx
    b3ae:	48 83 fa 20          	cmp    $0x20,%rdx
    b3b2:	0f 82 31 ff ff ff    	jb     b2e9 <fwp_apply+0x1b9>
    b3b8:	44 89 f2             	mov    %r14d,%edx
    b3bb:	83 e2 fc             	and    $0xfffffffc,%edx
    b3be:	31 f6                	xor    %esi,%esi
    b3c0:	0f 10 04 f3          	movups (%rbx,%rsi,8),%xmm0
    b3c4:	0f 10 4c f3 10       	movups 0x10(%rbx,%rsi,8),%xmm1
    b3c9:	46 8d 04 2e          	lea    (%rsi,%r13,1),%r8d
    b3cd:	42 0f 11 04 c7       	movups %xmm0,(%rdi,%r8,8)
    b3d2:	42 0f 11 4c c7 10    	movups %xmm1,0x10(%rdi,%r8,8)
    b3d8:	48 83 c6 04          	add    $0x4,%rsi
    b3dc:	48 39 f2             	cmp    %rsi,%rdx
    b3df:	75 df                	jne    b3c0 <fwp_apply+0x290>
    b3e1:	4c 39 f2             	cmp    %r14,%rdx
    b3e4:	0f 85 01 ff ff ff    	jne    b2eb <fwp_apply+0x1bb>
    b3ea:	e9 75 ff ff ff       	jmp    b364 <fwp_apply+0x234>
    b3ef:	44 89 f0             	mov    %r14d,%eax
    b3f2:	41 81 fe ff 07 00 00 	cmp    $0x7ff,%r14d
    b3f9:	77 72                	ja     b46d <fwp_apply+0x33d>
    b3fb:	48 8d 14 c5 00 00 00 	lea    0x0(,%rax,8),%rdx
    b402:	00 
    b403:	48 83 c2 17          	add    $0x17,%rdx
    b407:	48 c1 ea 04          	shr    $0x4,%rdx
    b40b:	48 8d 0d 6e 6d 00 00 	lea    0x6d6e(%rip),%rcx        # 12180 <fwp_gc>
    b412:	0f b6 bc 0a e8 0b 00 	movzbl 0xbe8(%rdx,%rcx,1),%edi
    b419:	00 
    b41a:	8b 94 b9 48 0b 00 00 	mov    0xb48(%rcx,%rdi,4),%edx
    b421:	48 29 15 58 6d 00 00 	sub    %rdx,0x6d58(%rip)        # 12180 <fwp_gc>
    b428:	78 43                	js     b46d <fwp_apply+0x33d>
    b42a:	4c 8d 04 7f          	lea    (%rdi,%rdi,2),%r8
    b42e:	4a 8d 3c c1          	lea    (%rcx,%r8,8),%rdi
    b432:	48 81 c7 88 07 00 00 	add    $0x788,%rdi
    b439:	4c 8b 27             	mov    (%rdi),%r12
    b43c:	4d 85 e4             	test   %r12,%r12
    b43f:	74 14                	je     b455 <fwp_apply+0x325>
    b441:	49 8b 04 24          	mov    (%r12),%rax
    b445:	48 f7 d0             	not    %rax
    b448:	48 89 07             	mov    %rax,(%rdi)
    b44b:	eb 48                	jmp    b495 <fwp_apply+0x365>
    b44d:	4d 89 fe             	mov    %r15,%r14
    b450:	e9 c1 01 00 00       	jmp    b616 <fwp_apply+0x4e6>
    b455:	4e 8b a4 c1 90 07 00 	mov    0x790(%rcx,%r8,8),%r12
    b45c:	00 
    b45d:	4a 8b bc c1 98 07 00 	mov    0x798(%rcx,%r8,8),%rdi
    b464:	00 
    b465:	4c 29 e7             	sub    %r12,%rdi
    b468:	48 39 d7             	cmp    %rdx,%rdi
    b46b:	73 17                	jae    b484 <fwp_apply+0x354>
    b46d:	48 8d 3c c5 08 00 00 	lea    0x8(,%rax,8),%rdi
    b474:	00 
    b475:	be 02 00 00 00       	mov    $0x2,%esi
    b47a:	e8 c1 b2 ff ff       	call   6740 <fwp_gc_alloc_slow>
    b47f:	49 89 c4             	mov    %rax,%r12
    b482:	eb 1b                	jmp    b49f <fwp_apply+0x36f>
    b484:	4a 8d 04 c1          	lea    (%rcx,%r8,8),%rax
    b488:	48 05 90 07 00 00    	add    $0x790,%rax
    b48e:	49 8d 0c 14          	lea    (%r12,%rdx,1),%rcx
    b492:	48 89 08             	mov    %rcx,(%rax)
    b495:	4c 89 e7             	mov    %r12,%rdi
    b498:	31 f6                	xor    %esi,%esi
    b49a:	e8 91 6c ff ff       	call   2130 <memset@plt>
    b49f:	41 8b 07             	mov    (%r15),%eax
    b4a2:	41 89 04 24          	mov    %eax,(%r12)
    b4a6:	45 89 74 24 04       	mov    %r14d,0x4(%r12)
    b4ab:	4d 85 ed             	test   %r13,%r13
    b4ae:	4d 89 e6             	mov    %r12,%r14
    b4b1:	48 8b 7d d0          	mov    -0x30(%rbp),%rdi
    b4b5:	0f 84 c6 00 00 00    	je     b581 <fwp_apply+0x451>
    b4bb:	31 c0                	xor    %eax,%eax
    b4bd:	41 83 fd 06          	cmp    $0x6,%r13d
    b4c1:	72 53                	jb     b516 <fwp_apply+0x3e6>
    b4c3:	4c 89 f1             	mov    %r14,%rcx
    b4c6:	4c 29 f9             	sub    %r15,%rcx
    b4c9:	48 83 f9 20          	cmp    $0x20,%rcx
    b4cd:	72 47                	jb     b516 <fwp_apply+0x3e6>
    b4cf:	44 89 e8             	mov    %r13d,%eax
    b4d2:	83 e0 fc             	and    $0xfffffffc,%eax
    b4d5:	4a 8d 0c ed 00 00 00 	lea    0x0(,%r13,8),%rcx
    b4dc:	00 
    b4dd:	48 83 e1 e0          	and    $0xffffffffffffffe0,%rcx
    b4e1:	31 d2                	xor    %edx,%edx
    b4e3:	66 66 66 66 2e 0f 1f 	data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    b4ea:	84 00 00 00 00 00 
    b4f0:	41 0f 10 44 17 08    	movups 0x8(%r15,%rdx,1),%xmm0
    b4f6:	41 0f 10 4c 17 18    	movups 0x18(%r15,%rdx,1),%xmm1
    b4fc:	41 0f 11 44 16 08    	movups %xmm0,0x8(%r14,%rdx,1)
    b502:	41 0f 11 4c 16 18    	movups %xmm1,0x18(%r14,%rdx,1)
    b508:	48 83 c2 20          	add    $0x20,%rdx
    b50c:	48 39 d1             	cmp    %rdx,%rcx
    b50f:	75 df                	jne    b4f0 <fwp_apply+0x3c0>
    b511:	4c 39 e8             	cmp    %r13,%rax
    b514:	74 6b                	je     b581 <fwp_apply+0x451>
    b516:	4c 89 ea             	mov    %r13,%rdx
    b519:	48 89 c1             	mov    %rax,%rcx
    b51c:	48 83 e2 03          	and    $0x3,%rdx
    b520:	74 20                	je     b542 <fwp_apply+0x412>
    b522:	48 89 c1             	mov    %rax,%rcx
    b525:	66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
    b52c:	00 00 00 00 
    b530:	49 8b 74 cf 08       	mov    0x8(%r15,%rcx,8),%rsi
    b535:	49 89 74 ce 08       	mov    %rsi,0x8(%r14,%rcx,8)
    b53a:	48 ff c1             	inc    %rcx
    b53d:	48 ff ca             	dec    %rdx
    b540:	75 ee                	jne    b530 <fwp_apply+0x400>
    b542:	4c 29 e8             	sub    %r13,%rax
    b545:	48 83 f8 fc          	cmp    $0xfffffffffffffffc,%rax
    b549:	77 36                	ja     b581 <fwp_apply+0x451>
    b54b:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)
    b550:	49 8b 44 cf 08       	mov    0x8(%r15,%rcx,8),%rax
    b555:	49 89 44 ce 08       	mov    %rax,0x8(%r14,%rcx,8)
    b55a:	49 8b 44 cf 10       	mov    0x10(%r15,%rcx,8),%rax
    b55f:	49 89 44 ce 10       	mov    %rax,0x10(%r14,%rcx,8)
    b564:	49 8b 44 cf 18       	mov    0x18(%r15,%rcx,8),%rax
    b569:	49 89 44 ce 18       	mov    %rax,0x18(%r14,%rcx,8)
    b56e:	49 8b 44 cf 20       	mov    0x20(%r15,%rcx,8),%rax
    b573:	49 89 44 ce 20       	mov    %rax,0x20(%r14,%rcx,8)
    b578:	48 83 c1 04          	add    $0x4,%rcx
    b57c:	49 39 cd             	cmp    %rcx,%r13
    b57f:	75 cf                	jne    b550 <fwp_apply+0x420>
    b581:	85 ff                	test   %edi,%edi
    b583:	0f 84 8d 00 00 00    	je     b616 <fwp_apply+0x4e6>
    b589:	89 f8                	mov    %edi,%eax
    b58b:	83 ff 14             	cmp    $0x14,%edi
    b58e:	0f 83 94 00 00 00    	jae    b628 <fwp_apply+0x4f8>
    b594:	31 c9                	xor    %ecx,%ecx
    b596:	48 89 c6             	mov    %rax,%rsi
    b599:	48 89 ca             	mov    %rcx,%rdx
    b59c:	48 83 e6 03          	and    $0x3,%rsi
    b5a0:	74 23                	je     b5c5 <fwp_apply+0x495>
    b5a2:	48 89 ca             	mov    %rcx,%rdx
    b5a5:	66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
    b5ac:	00 00 00 00 
    b5b0:	48 8b 3c d3          	mov    (%rbx,%rdx,8),%rdi
    b5b4:	46 8d 04 2a          	lea    (%rdx,%r13,1),%r8d
    b5b8:	4b 89 7c c6 08       	mov    %rdi,0x8(%r14,%r8,8)
    b5bd:	48 ff c2             	inc    %rdx
    b5c0:	48 ff ce             	dec    %rsi
    b5c3:	75 eb                	jne    b5b0 <fwp_apply+0x480>
    b5c5:	48 29 c1             	sub    %rax,%rcx
    b5c8:	48 83 f9 fc          	cmp    $0xfffffffffffffffc,%rcx
    b5cc:	77 48                	ja     b616 <fwp_apply+0x4e6>
    b5ce:	66 90                	xchg   %ax,%ax
    b5d0:	48 8b 0c d3          	mov    (%rbx,%rdx,8),%rcx
    b5d4:	42 8d 34 2a          	lea    (%rdx,%r13,1),%esi
    b5d8:	49 89 4c f6 08       	mov    %rcx,0x8(%r14,%rsi,8)
    b5dd:	48 8b 4c d3 08       	mov    0x8(%rbx,%rdx,8),%rcx
    b5e2:	42 8d 34 2a          	lea    (%rdx,%r13,1),%esi
    b5e6:	ff c6                	inc    %esi
    b5e8:	49 89 4c f6 08       	mov    %rcx,0x8(%r14,%rsi,8)
    b5ed:	48 8b 4c d3 10       	mov    0x10(%rbx,%rdx,8),%rcx
    b5f2:	41 8d 74 15 02       	lea    0x2(%r13,%rdx,1),%esi
    b5f7:	49 89 4c f6 08       	mov    %rcx,0x8(%r14,%rsi,8)
    b5fc:	48 8b 4c d3 18       	mov    0x18(%rbx,%rdx,8),%rcx
    b601:	42 8d 34 2a          	lea    (%rdx,%r13,1),%esi
    b605:	83 c6 03             	add    $0x3,%esi
    b608:	49 89 4c f6 08       	mov    %rcx,0x8(%r14,%rsi,8)
    b60d:	48 83 c2 04          	add    $0x4,%rdx
    b611:	48 39 d0             	cmp    %rdx,%rax
    b614:	75 ba                	jne    b5d0 <fwp_apply+0x4a0>
    b616:	4c 89 f0             	mov    %r14,%rax
    b619:	48 8d 65 d8          	lea    -0x28(%rbp),%rsp
    b61d:	5b                   	pop    %rbx
    b61e:	41 5c                	pop    %r12
    b620:	41 5d                	pop    %r13
    b622:	41 5e                	pop    %r14
    b624:	41 5f                	pop    %r15
    b626:	5d                   	pop    %rbp
    b627:	c3                   	ret
    b628:	48 8d 50 ff          	lea    -0x1(%rax),%rdx
    b62c:	31 c9                	xor    %ecx,%ecx
    b62e:	89 d6                	mov    %edx,%esi
    b630:	44 01 ee             	add    %r13d,%esi
    b633:	0f 82 5d ff ff ff    	jb     b596 <fwp_apply+0x466>
    b639:	48 c1 ea 20          	shr    $0x20,%rdx
    b63d:	0f 85 53 ff ff ff    	jne    b596 <fwp_apply+0x466>
    b643:	4b 8d 0c ee          	lea    (%r14,%r13,8),%rcx
    b647:	48 29 d9             	sub    %rbx,%rcx
    b64a:	48 83 c1 08          	add    $0x8,%rcx
    b64e:	48 83 f9 20          	cmp    $0x20,%rcx
    b652:	0f 82 3c ff ff ff    	jb     b594 <fwp_apply+0x464>
    b658:	89 c1                	mov    %eax,%ecx
    b65a:	83 e1 fc             	and    $0xfffffffc,%ecx
    b65d:	31 d2                	xor    %edx,%edx
    b65f:	90                   	nop
    b660:	0f 10 04 d3          	movups (%rbx,%rdx,8),%xmm0
    b664:	0f 10 4c d3 10       	movups 0x10(%rbx,%rdx,8),%xmm1
    b669:	42 8d 34 2a          	lea    (%rdx,%r13,1),%esi
    b66d:	41 0f 11 44 f6 08    	movups %xmm0,0x8(%r14,%rsi,8)
    b673:	41 0f 11 4c f6 18    	movups %xmm1,0x18(%r14,%rsi,8)
    b679:	48 83 c2 04          	add    $0x4,%rdx
    b67d:	48 39 d1             	cmp    %rdx,%rcx
    b680:	75 de                	jne    b660 <fwp_apply+0x530>
    b682:	48 39 c1             	cmp    %rax,%rcx
    b685:	0f 85 0b ff ff ff    	jne    b596 <fwp_apply+0x466>
    b68b:	eb 89                	jmp    b616 <fwp_apply+0x4e6>
    b68d:	0f 1f 00             	nopl   (%rax)

000000000000b690 <fwp_apply_owned>:
    b690:	55                   	push   %rbp
    b691:	48 89 e5             	mov    %rsp,%rbp
    b694:	41 57                	push   %r15
    b696:	41 56                	push   %r14
    b698:	41 55                	push   %r13
    b69a:	41 54                	push   %r12
    b69c:	53                   	push   %rbx
    b69d:	48 83 ec 28          	sub    $0x28,%rsp
    b6a1:	48 89 d3             	mov    %rdx,%rbx
    b6a4:	41 89 f5             	mov    %esi,%r13d
    b6a7:	48 8b 05 12 85 00 00 	mov    0x8512(%rip),%rax        # 13bc0 <fwp_fns>
    b6ae:	8b 17                	mov    (%rdi),%edx
    b6b0:	48 89 d6             	mov    %rdx,%rsi
    b6b3:	48 c1 e6 05          	shl    $0x5,%rsi
    b6b7:	48 8b 4c 30 18       	mov    0x18(%rax,%rsi,1),%rcx
    b6bc:	48 85 c9             	test   %rcx,%rcx
    b6bf:	0f 84 ca 02 00 00    	je     b98f <fwp_apply_owned+0x2ff>
    b6c5:	4c 8d 04 30          	lea    (%rax,%rsi,1),%r8
    b6c9:	49 83 c0 18          	add    $0x18,%r8
    b6cd:	49 89 fc             	mov    %rdi,%r12
    b6d0:	48 89 7d c0          	mov    %rdi,-0x40(%rbp)
    b6d4:	48 c1 e2 05          	shl    $0x5,%rdx
    b6d8:	8b 04 10             	mov    (%rax,%rdx,1),%eax
    b6db:	45 8b 74 24 04       	mov    0x4(%r12),%r14d
    b6e0:	47 8d 3c 2e          	lea    (%r14,%r13,1),%r15d
    b6e4:	41 39 c7             	cmp    %eax,%r15d
    b6e7:	0f 82 10 03 00 00    	jb     b9fd <fwp_apply_owned+0x36d>
    b6ed:	41 89 c7             	mov    %eax,%r15d
    b6f0:	45 29 f7             	sub    %r14d,%r15d
    b6f3:	45 89 fa             	mov    %r15d,%r10d
    b6f6:	85 c0                	test   %eax,%eax
    b6f8:	4c 89 55 d0          	mov    %r10,-0x30(%rbp)
    b6fc:	74 22                	je     b720 <fwp_apply_owned+0x90>
    b6fe:	45 85 f6             	test   %r14d,%r14d
    b701:	75 1d                	jne    b720 <fwp_apply_owned+0x90>
    b703:	48 89 df             	mov    %rbx,%rdi
    b706:	ff 11                	call   *(%rcx)
    b708:	49 89 c4             	mov    %rax,%r12
    b70b:	4c 8b 75 c0          	mov    -0x40(%rbp),%r14
    b70f:	e9 35 02 00 00       	jmp    b949 <fwp_apply_owned+0x2b9>
    b714:	66 66 66 2e 0f 1f 84 	data16 data16 cs nopw 0x0(%rax,%rax,1)
    b71b:	00 00 00 00 00 
    b720:	4c 89 6d c8          	mov    %r13,-0x38(%rbp)
    b724:	48 89 65 b8          	mov    %rsp,-0x48(%rbp)
    b728:	85 c0                	test   %eax,%eax
    b72a:	b9 01 00 00 00       	mov    $0x1,%ecx
    b72f:	0f 45 c8             	cmovne %eax,%ecx
    b732:	48 8d 0c cd 0f 00 00 	lea    0xf(,%rcx,8),%rcx
    b739:	00 
    b73a:	48 83 e1 f0          	and    $0xfffffffffffffff0,%rcx
    b73e:	49 89 e5             	mov    %rsp,%r13
    b741:	49 29 cd             	sub    %rcx,%r13
    b744:	4c 89 ec             	mov    %r13,%rsp
    b747:	4d 85 f6             	test   %r14,%r14
    b74a:	0f 84 d0 00 00 00    	je     b820 <fwp_apply_owned+0x190>
    b750:	41 83 fe 04          	cmp    $0x4,%r14d
    b754:	72 10                	jb     b766 <fwp_apply_owned+0xd6>
    b756:	4c 89 e9             	mov    %r13,%rcx
    b759:	4c 29 e1             	sub    %r12,%rcx
    b75c:	48 83 c1 f8          	add    $0xfffffffffffffff8,%rcx
    b760:	48 83 f9 20          	cmp    $0x20,%rcx
    b764:	73 6d                	jae    b7d3 <fwp_apply_owned+0x143>
    b766:	31 c9                	xor    %ecx,%ecx
    b768:	4c 89 f6             	mov    %r14,%rsi
    b76b:	48 89 ca             	mov    %rcx,%rdx
    b76e:	48 83 e6 03          	and    $0x3,%rsi
    b772:	74 1e                	je     b792 <fwp_apply_owned+0x102>
    b774:	48 89 ca             	mov    %rcx,%rdx
    b777:	66 0f 1f 84 00 00 00 	nopw   0x0(%rax,%rax,1)
    b77e:	00 00 
    b780:	49 8b 7c d4 08       	mov    0x8(%r12,%rdx,8),%rdi
    b785:	49 89 7c d5 00       	mov    %rdi,0x0(%r13,%rdx,8)
    b78a:	48 ff c2             	inc    %rdx
    b78d:	48 ff ce             	dec    %rsi
    b790:	75 ee                	jne    b780 <fwp_apply_owned+0xf0>
    b792:	4c 29 f1             	sub    %r14,%rcx
    b795:	48 83 f9 fc          	cmp    $0xfffffffffffffffc,%rcx
    b799:	0f 87 81 00 00 00    	ja     b820 <fwp_apply_owned+0x190>
    b79f:	90                   	nop
    b7a0:	49 8b 4c d4 08       	mov    0x8(%r12,%rdx,8),%rcx
    b7a5:	49 89 4c d5 00       	mov    %rcx,0x0(%r13,%rdx,8)
    b7aa:	49 8b 4c d4 10       	mov    0x10(%r12,%rdx,8),%rcx
    b7af:	49 89 4c d5 08       	mov    %rcx,0x8(%r13,%rdx,8)
    b7b4:	49 8b 4c d4 18       	mov    0x18(%r12,%rdx,8),%rcx
    b7b9:	49 89 4c d5 10       	mov    %rcx,0x10(%r13,%rdx,8)
    b7be:	49 8b 4c d4 20       	mov    0x20(%r12,%rdx,8),%rcx
    b7c3:	49 89 4c d5 18       	mov    %rcx,0x18(%r13,%rdx,8)
    b7c8:	48 83 c2 04          	add    $0x4,%rdx
    b7cc:	49 39 d6             	cmp    %rdx,%r14
    b7cf:	75 cf                	jne    b7a0 <fwp_apply_owned+0x110>
    b7d1:	eb 4d                	jmp    b820 <fwp_apply_owned+0x190>
    b7d3:	44 89 f1             	mov    %r14d,%ecx
    b7d6:	83 e1 fc             	and    $0xfffffffc,%ecx
    b7d9:	4a 8d 14 f5 00 00 00 	lea    0x0(,%r14,8),%rdx
    b7e0:	00 
    b7e1:	48 83 e2 e0          	and    $0xffffffffffffffe0,%rdx
    b7e5:	31 f6                	xor    %esi,%esi
    b7e7:	66 0f 1f 84 00 00 00 	nopw   0x0(%rax,%rax,1)
    b7ee:	00 00 
    b7f0:	41 0f 10 44 34 08    	movups 0x8(%r12,%rsi,1),%xmm0
    b7f6:	41 0f 10 4c 34 18    	movups 0x18(%r12,%rsi,1),%xmm1
    b7fc:	41 0f 29 44 35 00    	movaps %xmm0,0x0(%r13,%rsi,1)
    b802:	41 0f 29 4c 35 10    	movaps %xmm1,0x10(%r13,%rsi,1)
    b808:	48 83 c6 20          	add    $0x20,%rsi
    b80c:	48 39 f2             	cmp    %rsi,%rdx
    b80f:	75 df                	jne    b7f0 <fwp_apply_owned+0x160>
    b811:	4c 39 f1             	cmp    %r14,%rcx
    b814:	0f 85 4e ff ff ff    	jne    b768 <fwp_apply_owned+0xd8>
    b81a:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)
    b820:	44 39 f0             	cmp    %r14d,%eax
    b823:	0f 84 f7 00 00 00    	je     b920 <fwp_apply_owned+0x290>
    b829:	41 83 ff 0a          	cmp    $0xa,%r15d
    b82d:	0f 83 95 00 00 00    	jae    b8c8 <fwp_apply_owned+0x238>
    b833:	31 c0                	xor    %eax,%eax
    b835:	4c 89 d2             	mov    %r10,%rdx
    b838:	48 89 c1             	mov    %rax,%rcx
    b83b:	48 83 e2 03          	and    $0x3,%rdx
    b83f:	74 24                	je     b865 <fwp_apply_owned+0x1d5>
    b841:	48 89 c1             	mov    %rax,%rcx
    b844:	66 66 66 2e 0f 1f 84 	data16 data16 cs nopw 0x0(%rax,%rax,1)
    b84b:	00 00 00 00 00 
    b850:	48 8b 34 cb          	mov    (%rbx,%rcx,8),%rsi
    b854:	41 8d 3c 0e          	lea    (%r14,%rcx,1),%edi
    b858:	49 89 74 fd 00       	mov    %rsi,0x0(%r13,%rdi,8)
    b85d:	48 ff c1             	inc    %rcx
    b860:	48 ff ca             	dec    %rdx
    b863:	75 eb                	jne    b850 <fwp_apply_owned+0x1c0>
    b865:	4c 29 d0             	sub    %r10,%rax
    b868:	48 83 f8 fc          	cmp    $0xfffffffffffffffc,%rax
    b86c:	0f 87 ae 00 00 00    	ja     b920 <fwp_apply_owned+0x290>
    b872:	66 66 66 66 66 2e 0f 	data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    b879:	1f 84 00 00 00 00 00 
    b880:	48 8b 04 cb          	mov    (%rbx,%rcx,8),%rax
    b884:	41 8d 14 0e          	lea    (%r14,%rcx,1),%edx
    b888:	49 89 44 d5 00       	mov    %rax,0x0(%r13,%rdx,8)
    b88d:	48 8b 44 cb 08       	mov    0x8(%rbx,%rcx,8),%rax
    b892:	41 8d 14 0e          	lea    (%r14,%rcx,1),%edx
    b896:	ff c2                	inc    %edx
    b898:	49 89 44 d5 00       	mov    %rax,0x0(%r13,%rdx,8)
    b89d:	48 8b 44 cb 10       	mov    0x10(%rbx,%rcx,8),%rax
    b8a2:	41 8d 54 0e 02       	lea    0x2(%r14,%rcx,1),%edx
    b8a7:	49 89 44 d5 00       	mov    %rax,0x0(%r13,%rdx,8)
    b8ac:	48 8b 44 cb 18       	mov    0x18(%rbx,%rcx,8),%rax
    b8b1:	41 8d 14 0e          	lea    (%r14,%rcx,1),%edx
    b8b5:	83 c2 03             	add    $0x3,%edx
    b8b8:	49 89 44 d5 00       	mov    %rax,0x0(%r13,%rdx,8)
    b8bd:	48 83 c1 04          	add    $0x4,%rcx
    b8c1:	49 39 ca             	cmp    %rcx,%r10
    b8c4:	75 ba                	jne    b880 <fwp_apply_owned+0x1f0>
    b8c6:	eb 58                	jmp    b920 <fwp_apply_owned+0x290>
    b8c8:	49 8d 42 ff          	lea    -0x1(%r10),%rax
    b8cc:	89 c1                	mov    %eax,%ecx
    b8ce:	44 01 f1             	add    %r14d,%ecx
    b8d1:	0f 82 5c ff ff ff    	jb     b833 <fwp_apply_owned+0x1a3>
    b8d7:	48 c1 e8 20          	shr    $0x20,%rax
    b8db:	b8 00 00 00 00       	mov    $0x0,%eax
    b8e0:	0f 85 4f ff ff ff    	jne    b835 <fwp_apply_owned+0x1a5>
    b8e6:	44 89 d0             	mov    %r10d,%eax
    b8e9:	83 e0 fc             	and    $0xfffffffc,%eax
    b8ec:	31 c9                	xor    %ecx,%ecx
    b8ee:	66 90                	xchg   %ax,%ax
    b8f0:	0f 10 04 cb          	movups (%rbx,%rcx,8),%xmm0
    b8f4:	0f 10 4c cb 10       	movups 0x10(%rbx,%rcx,8),%xmm1
    b8f9:	41 8d 14 0e          	lea    (%r14,%rcx,1),%edx
    b8fd:	41 0f 11 44 d5 00    	movups %xmm0,0x0(%r13,%rdx,8)
    b903:	41 0f 11 4c d5 10    	movups %xmm1,0x10(%r13,%rdx,8)
    b909:	48 83 c1 04          	add    $0x4,%rcx
    b90d:	48 39 c8             	cmp    %rcx,%rax
    b910:	75 de                	jne    b8f0 <fwp_apply_owned+0x260>
    b912:	4c 39 d0             	cmp    %r10,%rax
    b915:	0f 85 1a ff ff ff    	jne    b835 <fwp_apply_owned+0x1a5>
    b91b:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)
    b920:	49 8b 00             	mov    (%r8),%rax
    b923:	4c 8b 75 c0          	mov    -0x40(%rbp),%r14
    b927:	4c 89 f7             	mov    %r14,%rdi
    b92a:	be 01 00 00 00       	mov    $0x1,%esi
    b92f:	4d 89 c4             	mov    %r8,%r12
    b932:	ff 50 08             	call   *0x8(%rax)
    b935:	49 8b 04 24          	mov    (%r12),%rax
    b939:	4c 89 ef             	mov    %r13,%rdi
    b93c:	ff 10                	call   *(%rax)
    b93e:	49 89 c4             	mov    %rax,%r12
    b941:	48 8b 65 b8          	mov    -0x48(%rbp),%rsp
    b945:	4c 8b 6d c8          	mov    -0x38(%rbp),%r13
    b949:	4c 89 f7             	mov    %r14,%rdi
    b94c:	e8 af 05 00 00       	call   bf00 <fwp_closure_drop>
    b951:	45 29 fd             	sub    %r15d,%r13d
    b954:	0f 84 89 05 00 00    	je     bee3 <fwp_apply_owned+0x853>
    b95a:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
    b95e:	48 8d 1c c3          	lea    (%rbx,%rax,8),%rbx
    b962:	48 8b 05 57 82 00 00 	mov    0x8257(%rip),%rax        # 13bc0 <fwp_fns>
    b969:	41 8b 14 24          	mov    (%r12),%edx
    b96d:	48 89 d1             	mov    %rdx,%rcx
    b970:	48 c1 e1 05          	shl    $0x5,%rcx
    b974:	4c 8d 04 08          	lea    (%rax,%rcx,1),%r8
    b978:	49 83 c0 18          	add    $0x18,%r8
    b97c:	48 8b 4c 08 18       	mov    0x18(%rax,%rcx,1),%rcx
    b981:	4c 89 e7             	mov    %r12,%rdi
    b984:	48 85 c9             	test   %rcx,%rcx
    b987:	0f 85 43 fd ff ff    	jne    b6d0 <fwp_apply_owned+0x40>
    b98d:	eb 03                	jmp    b992 <fwp_apply_owned+0x302>
    b98f:	49 89 fc             	mov    %rdi,%r12
    b992:	48 8b 05 17 78 00 00 	mov    0x7817(%rip),%rax        # 131b0 <fwp_gc+0x1030>
    b999:	4c 89 e2             	mov    %r12,%rdx
    b99c:	48 29 c2             	sub    %rax,%rdx
    b99f:	48 8b 0d 32 78 00 00 	mov    0x7832(%rip),%rcx        # 131d8 <fwp_gc+0x1058>
    b9a6:	48 c1 e1 10          	shl    $0x10,%rcx
    b9aa:	48 39 ca             	cmp    %rcx,%rdx
    b9ad:	0f 83 12 01 00 00    	jae    bac5 <fwp_apply_owned+0x435>
    b9b3:	48 8b 35 3e 78 00 00 	mov    0x783e(%rip),%rsi        # 131f8 <fwp_gc+0x1078>
    b9ba:	48 89 d7             	mov    %rdx,%rdi
    b9bd:	48 c1 ef 10          	shr    $0x10,%rdi
    b9c1:	48 69 ff 28 12 00 00 	imul   $0x1228,%rdi,%rdi
    b9c8:	44 0f b6 04 3e       	movzbl (%rsi,%rdi,1),%r8d
    b9cd:	48 81 e2 ff ff 00 00 	and    $0xffff,%rdx
    b9d4:	0f 85 c2 00 00 00    	jne    ba9c <fwp_apply_owned+0x40c>
    b9da:	41 80 f8 02          	cmp    $0x2,%r8b
    b9de:	0f 85 b8 00 00 00    	jne    ba9c <fwp_apply_owned+0x40c>
    b9e4:	48 8d 14 3e          	lea    (%rsi,%rdi,1),%rdx
    b9e8:	48 81 c2 28 02 00 00 	add    $0x228,%rdx
    b9ef:	80 3a 00             	cmpb   $0x0,(%rdx)
    b9f2:	0f 84 cd 00 00 00    	je     bac5 <fwp_apply_owned+0x435>
    b9f8:	e9 55 01 00 00       	jmp    bb52 <fwp_apply_owned+0x4c2>
    b9fd:	4c 89 45 d0          	mov    %r8,-0x30(%rbp)
    ba01:	4c 89 6d c8          	mov    %r13,-0x38(%rbp)
    ba05:	44 89 f9             	mov    %r15d,%ecx
    ba08:	48 8d 3c cd 08 00 00 	lea    0x8(,%rcx,8),%rdi
    ba0f:	00 
    ba10:	41 81 ff ff 07 00 00 	cmp    $0x7ff,%r15d
    ba17:	0f 87 f0 01 00 00    	ja     bc0d <fwp_apply_owned+0x57d>
    ba1d:	48 c1 e1 03          	shl    $0x3,%rcx
    ba21:	4c 8d 41 17          	lea    0x17(%rcx),%r8
    ba25:	49 c1 e8 04          	shr    $0x4,%r8
    ba29:	48 8d 05 50 67 00 00 	lea    0x6750(%rip),%rax        # 12180 <fwp_gc>
    ba30:	41 0f b6 b4 00 e8 0b 	movzbl 0xbe8(%r8,%rax,1),%esi
    ba37:	00 00 
    ba39:	8b 94 b0 48 0b 00 00 	mov    0xb48(%rax,%rsi,4),%edx
    ba40:	4c 8b 0d 39 67 00 00 	mov    0x6739(%rip),%r9        # 12180 <fwp_gc>
    ba47:	4d 89 ca             	mov    %r9,%r10
    ba4a:	49 29 d2             	sub    %rdx,%r10
    ba4d:	4c 89 15 2c 67 00 00 	mov    %r10,0x672c(%rip)        # 12180 <fwp_gc>
    ba54:	0f 88 b3 01 00 00    	js     bc0d <fwp_apply_owned+0x57d>
    ba5a:	4c 8d 14 76          	lea    (%rsi,%rsi,2),%r10
    ba5e:	4e 8d 1c d0          	lea    (%rax,%r10,8),%r11
    ba62:	49 83 c3 08          	add    $0x8,%r11
    ba66:	4d 8b 2b             	mov    (%r11),%r13
    ba69:	4d 85 ed             	test   %r13,%r13
    ba6c:	0f 84 24 01 00 00    	je     bb96 <fwp_apply_owned+0x506>
    ba72:	49 8b 45 00          	mov    0x0(%r13),%rax
    ba76:	48 f7 d0             	not    %rax
    ba79:	49 89 03             	mov    %rax,(%r11)
    ba7c:	48 39 d7             	cmp    %rdx,%rdi
    ba7f:	0f 83 ad 01 00 00    	jae    bc32 <fwp_apply_owned+0x5a2>
    ba85:	4c 01 ef             	add    %r13,%rdi
    ba88:	48 29 ca             	sub    %rcx,%rdx
    ba8b:	48 83 c2 f7          	add    $0xfffffffffffffff7,%rdx
    ba8f:	48 83 e2 f8          	and    $0xfffffffffffffff8,%rdx
    ba93:	48 83 c2 08          	add    $0x8,%rdx
    ba97:	e9 8f 01 00 00       	jmp    bc2b <fwp_apply_owned+0x59b>
    ba9c:	41 80 f8 01          	cmp    $0x1,%r8b
    baa0:	75 23                	jne    bac5 <fwp_apply_owned+0x435>
    baa2:	4c 8d 04 3e          	lea    (%rsi,%rdi,1),%r8
    baa6:	8b 74 3e 20          	mov    0x20(%rsi,%rdi,1),%esi
    baaa:	48 0f af d6          	imul   %rsi,%rdx
    baae:	48 c1 ea 20          	shr    $0x20,%rdx
    bab2:	4c 01 c2             	add    %r8,%rdx
    bab5:	48 81 c2 28 02 00 00 	add    $0x228,%rdx
    babc:	80 3a 00             	cmpb   $0x0,(%rdx)
    babf:	0f 85 8d 00 00 00    	jne    bb52 <fwp_apply_owned+0x4c2>
    bac5:	45 85 ed             	test   %r13d,%r13d
    bac8:	0f 84 b2 00 00 00    	je     bb80 <fwp_apply_owned+0x4f0>
    bace:	48 8b 15 23 77 00 00 	mov    0x7723(%rip),%rdx        # 131f8 <fwp_gc+0x1078>
    bad5:	44 89 ee             	mov    %r13d,%esi
    bad8:	31 ff                	xor    %edi,%edi
    bada:	eb 21                	jmp    bafd <fwp_apply_owned+0x46d>
    badc:	0f 1f 40 00          	nopl   0x0(%rax)
    bae0:	4e 8d 04 0a          	lea    (%rdx,%r9,1),%r8
    bae4:	49 81 c0 28 02 00 00 	add    $0x228,%r8
    baeb:	41 80 38 00          	cmpb   $0x0,(%r8)
    baef:	75 61                	jne    bb52 <fwp_apply_owned+0x4c2>
    baf1:	48 ff c7             	inc    %rdi
    baf4:	48 39 fe             	cmp    %rdi,%rsi
    baf7:	0f 84 83 00 00 00    	je     bb80 <fwp_apply_owned+0x4f0>
    bafd:	4c 8b 04 fb          	mov    (%rbx,%rdi,8),%r8
    bb01:	49 29 c0             	sub    %rax,%r8
    bb04:	49 39 c8             	cmp    %rcx,%r8
    bb07:	73 e8                	jae    baf1 <fwp_apply_owned+0x461>
    bb09:	4d 89 c1             	mov    %r8,%r9
    bb0c:	49 c1 e9 10          	shr    $0x10,%r9
    bb10:	4d 69 c9 28 12 00 00 	imul   $0x1228,%r9,%r9
    bb17:	46 0f b6 14 0a       	movzbl (%rdx,%r9,1),%r10d
    bb1c:	49 81 e0 ff ff 00 00 	and    $0xffff,%r8
    bb23:	75 06                	jne    bb2b <fwp_apply_owned+0x49b>
    bb25:	41 80 fa 02          	cmp    $0x2,%r10b
    bb29:	74 b5                	je     bae0 <fwp_apply_owned+0x450>
    bb2b:	41 80 fa 01          	cmp    $0x1,%r10b
    bb2f:	75 c0                	jne    baf1 <fwp_apply_owned+0x461>
    bb31:	4e 8d 14 0a          	lea    (%rdx,%r9,1),%r10
    bb35:	46 8b 4c 0a 20       	mov    0x20(%rdx,%r9,1),%r9d
    bb3a:	4d 0f af c1          	imul   %r9,%r8
    bb3e:	49 c1 e8 20          	shr    $0x20,%r8
    bb42:	4d 01 d0             	add    %r10,%r8
    bb45:	49 81 c0 28 02 00 00 	add    $0x228,%r8
    bb4c:	41 80 38 00          	cmpb   $0x0,(%r8)
    bb50:	74 9f                	je     baf1 <fwp_apply_owned+0x461>
    bb52:	e8 99 a7 ff ff       	call   62f0 <fwp_flush>
    bb57:	48 8b 05 82 64 00 00 	mov    0x6482(%rip),%rax        # 11fe0 <stderr@GLIBC_2.2.5>
    bb5e:	48 8b 38             	mov    (%rax),%rdi
    bb61:	48 8d 35 c5 38 00 00 	lea    0x38c5(%rip),%rsi        # f42d <fwp_segv.msg+0x1ed>
    bb68:	48 8d 15 91 38 00 00 	lea    0x3891(%rip),%rdx        # f400 <fwp_segv.msg+0x1c0>
    bb6f:	31 c0                	xor    %eax,%eax
    bb71:	e8 3a 66 ff ff       	call   21b0 <fprintf@plt>
    bb76:	bf 65 00 00 00       	mov    $0x65,%edi
    bb7b:	e8 10 67 ff ff       	call   2290 <exit@plt>
    bb80:	4c 89 e7             	mov    %r12,%rdi
    bb83:	44 89 ee             	mov    %r13d,%esi
    bb86:	48 89 da             	mov    %rbx,%rdx
    bb89:	e8 a2 f5 ff ff       	call   b130 <fwp_apply>
    bb8e:	49 89 c4             	mov    %rax,%r12
    bb91:	e9 4d 03 00 00       	jmp    bee3 <fwp_apply_owned+0x853>
    bb96:	4e 8b 6c d0 10       	mov    0x10(%rax,%r10,8),%r13
    bb9b:	4e 8b 5c d0 18       	mov    0x18(%rax,%r10,8),%r11
    bba0:	4d 29 eb             	sub    %r13,%r11
    bba3:	49 39 d3             	cmp    %rdx,%r11
    bba6:	72 34                	jb     bbdc <fwp_apply_owned+0x54c>
    bba8:	4a 8d 34 d0          	lea    (%rax,%r10,8),%rsi
    bbac:	48 83 c6 10          	add    $0x10,%rsi
    bbb0:	4e 8d 14 2a          	lea    (%rdx,%r13,1),%r10
    bbb4:	4c 89 16             	mov    %r10,(%rsi)
    bbb7:	4d 85 ed             	test   %r13,%r13
    bbba:	0f 85 bc fe ff ff    	jne    ba7c <fwp_apply_owned+0x3ec>
    bbc0:	41 0f b6 b4 00 e8 0b 	movzbl 0xbe8(%r8,%rax,1),%esi
    bbc7:	00 00 
    bbc9:	8b 94 b0 48 0b 00 00 	mov    0xb48(%rax,%rsi,4),%edx
    bbd0:	49 29 d1             	sub    %rdx,%r9
    bbd3:	4c 89 0d a6 65 00 00 	mov    %r9,0x65a6(%rip)        # 12180 <fwp_gc>
    bbda:	78 31                	js     bc0d <fwp_apply_owned+0x57d>
    bbdc:	48 8d 0c 76          	lea    (%rsi,%rsi,2),%rcx
    bbe0:	4c 8b 6c c8 08       	mov    0x8(%rax,%rcx,8),%r13
    bbe5:	4d 85 ed             	test   %r13,%r13
    bbe8:	74 11                	je     bbfb <fwp_apply_owned+0x56b>
    bbea:	48 8d 04 c8          	lea    (%rax,%rcx,8),%rax
    bbee:	48 83 c0 08          	add    $0x8,%rax
    bbf2:	49 8b 4d 00          	mov    0x0(%r13),%rcx
    bbf6:	48 f7 d1             	not    %rcx
    bbf9:	eb 2a                	jmp    bc25 <fwp_apply_owned+0x595>
    bbfb:	4c 8b 6c c8 10       	mov    0x10(%rax,%rcx,8),%r13
    bc00:	48 8b 74 c8 18       	mov    0x18(%rax,%rcx,8),%rsi
    bc05:	4c 29 ee             	sub    %r13,%rsi
    bc08:	48 39 d6             	cmp    %rdx,%rsi
    bc0b:	73 0c                	jae    bc19 <fwp_apply_owned+0x589>
    bc0d:	31 f6                	xor    %esi,%esi
    bc0f:	e8 2c ab ff ff       	call   6740 <fwp_gc_alloc_slow>
    bc14:	49 89 c5             	mov    %rax,%r13
    bc17:	eb 19                	jmp    bc32 <fwp_apply_owned+0x5a2>
    bc19:	48 8d 04 c8          	lea    (%rax,%rcx,8),%rax
    bc1d:	48 83 c0 10          	add    $0x10,%rax
    bc21:	4a 8d 0c 2a          	lea    (%rdx,%r13,1),%rcx
    bc25:	48 89 08             	mov    %rcx,(%rax)
    bc28:	4c 89 ef             	mov    %r13,%rdi
    bc2b:	31 f6                	xor    %esi,%esi
    bc2d:	e8 fe 64 ff ff       	call   2130 <memset@plt>
    bc32:	4c 8b 4d d0          	mov    -0x30(%rbp),%r9
    bc36:	41 8b 04 24          	mov    (%r12),%eax
    bc3a:	41 89 45 00          	mov    %eax,0x0(%r13)
    bc3e:	45 89 7d 04          	mov    %r15d,0x4(%r13)
    bc42:	4d 85 f6             	test   %r14,%r14
    bc45:	0f 84 c6 00 00 00    	je     bd11 <fwp_apply_owned+0x681>
    bc4b:	31 c0                	xor    %eax,%eax
    bc4d:	41 83 fe 06          	cmp    $0x6,%r14d
    bc51:	72 53                	jb     bca6 <fwp_apply_owned+0x616>
    bc53:	4c 89 e9             	mov    %r13,%rcx
    bc56:	4c 29 e1             	sub    %r12,%rcx
    bc59:	48 83 f9 20          	cmp    $0x20,%rcx
    bc5d:	72 47                	jb     bca6 <fwp_apply_owned+0x616>
    bc5f:	44 89 f0             	mov    %r14d,%eax
    bc62:	83 e0 fc             	and    $0xfffffffc,%eax
    bc65:	4a 8d 0c f5 00 00 00 	lea    0x0(,%r14,8),%rcx
    bc6c:	00 
    bc6d:	48 83 e1 e0          	and    $0xffffffffffffffe0,%rcx
    bc71:	31 d2                	xor    %edx,%edx
    bc73:	66 66 66 66 2e 0f 1f 	data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    bc7a:	84 00 00 00 00 00 
    bc80:	41 0f 10 44 14 08    	movups 0x8(%r12,%rdx,1),%xmm0
    bc86:	41 0f 10 4c 14 18    	movups 0x18(%r12,%rdx,1),%xmm1
    bc8c:	41 0f 11 44 15 08    	movups %xmm0,0x8(%r13,%rdx,1)
    bc92:	41 0f 11 4c 15 18    	movups %xmm1,0x18(%r13,%rdx,1)
    bc98:	48 83 c2 20          	add    $0x20,%rdx
    bc9c:	48 39 d1             	cmp    %rdx,%rcx
    bc9f:	75 df                	jne    bc80 <fwp_apply_owned+0x5f0>
    bca1:	4c 39 f0             	cmp    %r14,%rax
    bca4:	74 6b                	je     bd11 <fwp_apply_owned+0x681>
    bca6:	4c 89 f2             	mov    %r14,%rdx
    bca9:	48 89 c1             	mov    %rax,%rcx
    bcac:	48 83 e2 03          	and    $0x3,%rdx
    bcb0:	74 20                	je     bcd2 <fwp_apply_owned+0x642>
    bcb2:	48 89 c1             	mov    %rax,%rcx
    bcb5:	66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
    bcbc:	00 00 00 00 
    bcc0:	49 8b 74 cc 08       	mov    0x8(%r12,%rcx,8),%rsi
    bcc5:	49 89 74 cd 08       	mov    %rsi,0x8(%r13,%rcx,8)
    bcca:	48 ff c1             	inc    %rcx
    bccd:	48 ff ca             	dec    %rdx
    bcd0:	75 ee                	jne    bcc0 <fwp_apply_owned+0x630>
    bcd2:	4c 29 f0             	sub    %r14,%rax
    bcd5:	48 83 f8 fc          	cmp    $0xfffffffffffffffc,%rax
    bcd9:	77 36                	ja     bd11 <fwp_apply_owned+0x681>
    bcdb:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)
    bce0:	49 8b 44 cc 08       	mov    0x8(%r12,%rcx,8),%rax
    bce5:	49 89 44 cd 08       	mov    %rax,0x8(%r13,%rcx,8)
    bcea:	49 8b 44 cc 10       	mov    0x10(%r12,%rcx,8),%rax
    bcef:	49 89 44 cd 10       	mov    %rax,0x10(%r13,%rcx,8)
    bcf4:	49 8b 44 cc 18       	mov    0x18(%r12,%rcx,8),%rax
    bcf9:	49 89 44 cd 18       	mov    %rax,0x18(%r13,%rcx,8)
    bcfe:	49 8b 44 cc 20       	mov    0x20(%r12,%rcx,8),%rax
    bd03:	49 89 44 cd 20       	mov    %rax,0x20(%r13,%rcx,8)
    bd08:	48 83 c1 04          	add    $0x4,%rcx
    bd0c:	49 39 ce             	cmp    %rcx,%r14
    bd0f:	75 cf                	jne    bce0 <fwp_apply_owned+0x650>
    bd11:	48 8b 4d c8          	mov    -0x38(%rbp),%rcx
    bd15:	85 c9                	test   %ecx,%ecx
    bd17:	0f 84 89 00 00 00    	je     bda6 <fwp_apply_owned+0x716>
    bd1d:	89 c8                	mov    %ecx,%eax
    bd1f:	83 f9 14             	cmp    $0x14,%ecx
    bd22:	0f 83 fb 00 00 00    	jae    be23 <fwp_apply_owned+0x793>
    bd28:	31 c9                	xor    %ecx,%ecx
    bd2a:	48 89 c6             	mov    %rax,%rsi
    bd2d:	48 89 ca             	mov    %rcx,%rdx
    bd30:	48 83 e6 03          	and    $0x3,%rsi
    bd34:	74 1f                	je     bd55 <fwp_apply_owned+0x6c5>
    bd36:	48 89 ca             	mov    %rcx,%rdx
    bd39:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)
    bd40:	48 8b 3c d3          	mov    (%rbx,%rdx,8),%rdi
    bd44:	45 8d 04 16          	lea    (%r14,%rdx,1),%r8d
    bd48:	4b 89 7c c5 08       	mov    %rdi,0x8(%r13,%r8,8)
    bd4d:	48 ff c2             	inc    %rdx
    bd50:	48 ff ce             	dec    %rsi
    bd53:	75 eb                	jne    bd40 <fwp_apply_owned+0x6b0>
    bd55:	48 29 c1             	sub    %rax,%rcx
    bd58:	48 83 f9 fc          	cmp    $0xfffffffffffffffc,%rcx
    bd5c:	77 48                	ja     bda6 <fwp_apply_owned+0x716>
    bd5e:	66 90                	xchg   %ax,%ax
    bd60:	48 8b 0c d3          	mov    (%rbx,%rdx,8),%rcx
    bd64:	41 8d 34 16          	lea    (%r14,%rdx,1),%esi
    bd68:	49 89 4c f5 08       	mov    %rcx,0x8(%r13,%rsi,8)
    bd6d:	48 8b 4c d3 08       	mov    0x8(%rbx,%rdx,8),%rcx
    bd72:	41 8d 34 16          	lea    (%r14,%rdx,1),%esi
    bd76:	ff c6                	inc    %esi
    bd78:	49 89 4c f5 08       	mov    %rcx,0x8(%r13,%rsi,8)
    bd7d:	48 8b 4c d3 10       	mov    0x10(%rbx,%rdx,8),%rcx
    bd82:	41 8d 74 16 02       	lea    0x2(%r14,%rdx,1),%esi
    bd87:	49 89 4c f5 08       	mov    %rcx,0x8(%r13,%rsi,8)
    bd8c:	48 8b 4c d3 18       	mov    0x18(%rbx,%rdx,8),%rcx
    bd91:	41 8d 34 16          	lea    (%r14,%rdx,1),%esi
    bd95:	83 c6 03             	add    $0x3,%esi
    bd98:	49 89 4c f5 08       	mov    %rcx,0x8(%r13,%rsi,8)
    bd9d:	48 83 c2 04          	add    $0x4,%rdx
    bda1:	48 39 d0             	cmp    %rdx,%rax
    bda4:	75 ba                	jne    bd60 <fwp_apply_owned+0x6d0>
    bda6:	49 8b 01             	mov    (%r9),%rax
    bda9:	4c 8b 75 c0          	mov    -0x40(%rbp),%r14
    bdad:	4c 89 f7             	mov    %r14,%rdi
    bdb0:	be 01 00 00 00       	mov    $0x1,%esi
    bdb5:	ff 50 08             	call   *0x8(%rax)
    bdb8:	4c 89 e8             	mov    %r13,%rax
    bdbb:	48 2b 05 ee 73 00 00 	sub    0x73ee(%rip),%rax        # 131b0 <fwp_gc+0x1030>
    bdc2:	48 8b 0d 0f 74 00 00 	mov    0x740f(%rip),%rcx        # 131d8 <fwp_gc+0x1058>
    bdc9:	48 c1 e1 10          	shl    $0x10,%rcx
    bdcd:	48 39 c8             	cmp    %rcx,%rax
    bdd0:	0f 83 02 01 00 00    	jae    bed8 <fwp_apply_owned+0x848>
    bdd6:	48 8b 0d 1b 74 00 00 	mov    0x741b(%rip),%rcx        # 131f8 <fwp_gc+0x1078>
    bddd:	48 89 c2             	mov    %rax,%rdx
    bde0:	48 c1 ea 10          	shr    $0x10,%rdx
    bde4:	48 69 d2 28 12 00 00 	imul   $0x1228,%rdx,%rdx
    bdeb:	0f b6 34 11          	movzbl (%rcx,%rdx,1),%esi
    bdef:	48 25 ff ff 00 00    	and    $0xffff,%rax
    bdf5:	0f 85 a5 00 00 00    	jne    bea0 <fwp_apply_owned+0x810>
    bdfb:	40 80 fe 02          	cmp    $0x2,%sil
    bdff:	0f 85 9b 00 00 00    	jne    bea0 <fwp_apply_owned+0x810>
    be05:	4c 8d 3c 11          	lea    (%rcx,%rdx,1),%r15
    be09:	49 81 c7 28 02 00 00 	add    $0x228,%r15
    be10:	41 80 3f ff          	cmpb   $0xff,(%r15)
    be14:	0f 84 b1 00 00 00    	je     becb <fwp_apply_owned+0x83b>
    be1a:	41 c6 07 01          	movb   $0x1,(%r15)
    be1e:	e9 b5 00 00 00       	jmp    bed8 <fwp_apply_owned+0x848>
    be23:	48 8d 50 ff          	lea    -0x1(%rax),%rdx
    be27:	31 c9                	xor    %ecx,%ecx
    be29:	89 d6                	mov    %edx,%esi
    be2b:	44 01 f6             	add    %r14d,%esi
    be2e:	0f 82 f6 fe ff ff    	jb     bd2a <fwp_apply_owned+0x69a>
    be34:	48 c1 ea 20          	shr    $0x20,%rdx
    be38:	0f 85 ec fe ff ff    	jne    bd2a <fwp_apply_owned+0x69a>
    be3e:	4a 8d 0c f5 00 00 00 	lea    0x0(,%r14,8),%rcx
    be45:	00 
    be46:	4c 01 e9             	add    %r13,%rcx
    be49:	48 29 d9             	sub    %rbx,%rcx
    be4c:	48 83 c1 08          	add    $0x8,%rcx
    be50:	48 83 f9 20          	cmp    $0x20,%rcx
    be54:	0f 82 ce fe ff ff    	jb     bd28 <fwp_apply_owned+0x698>
    be5a:	89 c1                	mov    %eax,%ecx
    be5c:	83 e1 fc             	and    $0xfffffffc,%ecx
    be5f:	31 d2                	xor    %edx,%edx
    be61:	66 66 66 66 66 66 2e 	data16 data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    be68:	0f 1f 84 00 00 00 00 
    be6f:	00 
    be70:	0f 10 04 d3          	movups (%rbx,%rdx,8),%xmm0
    be74:	0f 10 4c d3 10       	movups 0x10(%rbx,%rdx,8),%xmm1
    be79:	41 8d 34 16          	lea    (%r14,%rdx,1),%esi
    be7d:	41 0f 11 44 f5 08    	movups %xmm0,0x8(%r13,%rsi,8)
    be83:	41 0f 11 4c f5 18    	movups %xmm1,0x18(%r13,%rsi,8)
    be89:	48 83 c2 04          	add    $0x4,%rdx
    be8d:	48 39 d1             	cmp    %rdx,%rcx
    be90:	75 de                	jne    be70 <fwp_apply_owned+0x7e0>
    be92:	48 39 c1             	cmp    %rax,%rcx
    be95:	0f 85 8f fe ff ff    	jne    bd2a <fwp_apply_owned+0x69a>
    be9b:	e9 06 ff ff ff       	jmp    bda6 <fwp_apply_owned+0x716>
    bea0:	40 80 fe 01          	cmp    $0x1,%sil
    bea4:	75 32                	jne    bed8 <fwp_apply_owned+0x848>
    bea6:	48 8d 34 11          	lea    (%rcx,%rdx,1),%rsi
    beaa:	8b 4c 11 20          	mov    0x20(%rcx,%rdx,1),%ecx
    beae:	48 0f af c1          	imul   %rcx,%rax
    beb2:	48 c1 e8 20          	shr    $0x20,%rax
    beb6:	4c 8d 3c 30          	lea    (%rax,%rsi,1),%r15
    beba:	49 81 c7 28 02 00 00 	add    $0x228,%r15
    bec1:	41 80 3f ff          	cmpb   $0xff,(%r15)
    bec5:	0f 85 4f ff ff ff    	jne    be1a <fwp_apply_owned+0x78a>
    becb:	4c 89 ff             	mov    %r15,%rdi
    bece:	e8 4d a4 ff ff       	call   6320 <fwp_rc_forget_slot>
    bed3:	e9 42 ff ff ff       	jmp    be1a <fwp_apply_owned+0x78a>
    bed8:	4c 89 f7             	mov    %r14,%rdi
    bedb:	e8 20 00 00 00       	call   bf00 <fwp_closure_drop>
    bee0:	4d 89 ec             	mov    %r13,%r12
    bee3:	4c 89 e0             	mov    %r12,%rax
    bee6:	48 8d 65 d8          	lea    -0x28(%rbp),%rsp
    beea:	5b                   	pop    %rbx
    beeb:	41 5c                	pop    %r12
    beed:	41 5d                	pop    %r13
    beef:	41 5e                	pop    %r14
    bef1:	41 5f                	pop    %r15
    bef3:	5d                   	pop    %rbp
    bef4:	c3                   	ret
    bef5:	66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
    befc:	00 00 00 00 

000000000000bf00 <fwp_closure_drop>:
    bf00:	41 57                	push   %r15
    bf02:	41 56                	push   %r14
    bf04:	53                   	push   %rbx
    bf05:	48 81 ec 30 02 00 00 	sub    $0x230,%rsp
    bf0c:	48 89 f8             	mov    %rdi,%rax
    bf0f:	48 2b 05 9a 72 00 00 	sub    0x729a(%rip),%rax        # 131b0 <fwp_gc+0x1030>
    bf16:	48 8b 0d bb 72 00 00 	mov    0x72bb(%rip),%rcx        # 131d8 <fwp_gc+0x1058>
    bf1d:	48 c1 e1 10          	shl    $0x10,%rcx
    bf21:	48 39 c8             	cmp    %rcx,%rax
    bf24:	0f 83 91 00 00 00    	jae    bfbb <fwp_closure_drop+0xbb>
    bf2a:	48 89 fe             	mov    %rdi,%rsi
    bf2d:	48 8b 0d c4 72 00 00 	mov    0x72c4(%rip),%rcx        # 131f8 <fwp_gc+0x1078>
    bf34:	48 89 c2             	mov    %rax,%rdx
    bf37:	48 c1 ea 10          	shr    $0x10,%rdx
    bf3b:	48 69 d2 28 12 00 00 	imul   $0x1228,%rdx,%rdx
    bf42:	0f b6 3c 11          	movzbl (%rcx,%rdx,1),%edi
    bf46:	48 25 ff ff 00 00    	and    $0xffff,%rax
    bf4c:	75 13                	jne    bf61 <fwp_closure_drop+0x61>
    bf4e:	40 80 ff 02          	cmp    $0x2,%dil
    bf52:	75 0d                	jne    bf61 <fwp_closure_drop+0x61>
    bf54:	48 8d 3c 11          	lea    (%rcx,%rdx,1),%rdi
    bf58:	48 81 c7 28 02 00 00 	add    $0x228,%rdi
    bf5f:	eb 20                	jmp    bf81 <fwp_closure_drop+0x81>
    bf61:	40 80 ff 01          	cmp    $0x1,%dil
    bf65:	75 54                	jne    bfbb <fwp_closure_drop+0xbb>
    bf67:	48 8d 3c 11          	lea    (%rcx,%rdx,1),%rdi
    bf6b:	8b 4c 11 20          	mov    0x20(%rcx,%rdx,1),%ecx
    bf6f:	48 0f af c1          	imul   %rcx,%rax
    bf73:	48 c1 e8 20          	shr    $0x20,%rax
    bf77:	48 01 c7             	add    %rax,%rdi
    bf7a:	48 81 c7 28 02 00 00 	add    $0x228,%rdi
    bf81:	0f b6 07             	movzbl (%rdi),%eax
    bf84:	85 c0                	test   %eax,%eax
    bf86:	74 33                	je     bfbb <fwp_closure_drop+0xbb>
    bf88:	83 f8 01             	cmp    $0x1,%eax
    bf8b:	75 1f                	jne    bfac <fwp_closure_drop+0xac>
    bf8d:	64 48 8b 3c 25 f8 ff 	mov    %fs:0xfffffffffffffff8,%rdi
    bf94:	ff ff 
    bf96:	48 85 ff             	test   %rdi,%rdi
    bf99:	74 2d                	je     bfc8 <fwp_closure_drop+0xc8>
    bf9b:	48 81 c4 30 02 00 00 	add    $0x230,%rsp
    bfa2:	5b                   	pop    %rbx
    bfa3:	41 5e                	pop    %r14
    bfa5:	41 5f                	pop    %r15
    bfa7:	e9 44 01 00 00       	jmp    c0f0 <fwp_closure_drop_push>
    bfac:	3d ff 00 00 00       	cmp    $0xff,%eax
    bfb1:	0f 84 e7 00 00 00    	je     c09e <fwp_closure_drop+0x19e>
    bfb7:	fe c8                	dec    %al
    bfb9:	88 07                	mov    %al,(%rdi)
    bfbb:	48 81 c4 30 02 00 00 	add    $0x230,%rsp
    bfc2:	5b                   	pop    %rbx
    bfc3:	41 5e                	pop    %r14
    bfc5:	41 5f                	pop    %r15
    bfc7:	c3                   	ret
    bfc8:	64 48 8b 04 25 00 00 	mov    %fs:0x0,%rax
    bfcf:	00 00 
    bfd1:	4c 8d b0 f8 ff ff ff 	lea    -0x8(%rax),%r14
    bfd8:	48 8d 5c 24 30       	lea    0x30(%rsp),%rbx
    bfdd:	48 89 5c 24 18       	mov    %rbx,0x18(%rsp)
    bfe2:	48 c7 44 24 20 00 00 	movq   $0x0,0x20(%rsp)
    bfe9:	00 00 
    bfeb:	48 c7 44 24 28 40 00 	movq   $0x40,0x28(%rsp)
    bff2:	00 00 
    bff4:	48 8b 05 ed 7b 00 00 	mov    0x7bed(%rip),%rax        # 13be8 <fwp_cleanups>
    bffb:	48 89 04 24          	mov    %rax,(%rsp)
    bfff:	48 8d 05 ca 01 00 00 	lea    0x1ca(%rip),%rax        # c1d0 <fwp_closure_drop_release>
    c006:	48 89 44 24 08       	mov    %rax,0x8(%rsp)
    c00b:	48 8d 7c 24 18       	lea    0x18(%rsp),%rdi
    c010:	48 89 7c 24 10       	mov    %rdi,0x10(%rsp)
    c015:	49 89 e7             	mov    %rsp,%r15
    c018:	4c 89 3d c9 7b 00 00 	mov    %r15,0x7bc9(%rip)        # 13be8 <fwp_cleanups>
    c01f:	49 89 3e             	mov    %rdi,(%r14)
    c022:	e8 c9 00 00 00       	call   c0f0 <fwp_closure_drop_push>
    c027:	66 0f 1f 84 00 00 00 	nopw   0x0(%rax,%rax,1)
    c02e:	00 00 
    c030:	48 8b 44 24 20       	mov    0x20(%rsp),%rax
    c035:	48 85 c0             	test   %rax,%rax
    c038:	74 31                	je     c06b <fwp_closure_drop+0x16b>
    c03a:	48 8b 4c 24 18       	mov    0x18(%rsp),%rcx
    c03f:	48 8d 50 ff          	lea    -0x1(%rax),%rdx
    c043:	48 89 54 24 20       	mov    %rdx,0x20(%rsp)
    c048:	48 8b 7c c1 f8       	mov    -0x8(%rcx,%rax,8),%rdi
    c04d:	48 8b 05 6c 7b 00 00 	mov    0x7b6c(%rip),%rax        # 13bc0 <fwp_fns>
    c054:	8b 0f                	mov    (%rdi),%ecx
    c056:	48 c1 e1 05          	shl    $0x5,%rcx
    c05a:	48 8b 44 08 18       	mov    0x18(%rax,%rcx,1),%rax
    c05f:	48 85 c0             	test   %rax,%rax
    c062:	74 4b                	je     c0af <fwp_closure_drop+0x1af>
    c064:	31 f6                	xor    %esi,%esi
    c066:	ff 50 08             	call   *0x8(%rax)
    c069:	eb c5                	jmp    c030 <fwp_closure_drop+0x130>
    c06b:	4c 39 3d 76 7b 00 00 	cmp    %r15,0x7b76(%rip)        # 13be8 <fwp_cleanups>
    c072:	75 69                	jne    c0dd <fwp_closure_drop+0x1dd>
    c074:	48 8b 04 24          	mov    (%rsp),%rax
    c078:	48 89 05 69 7b 00 00 	mov    %rax,0x7b69(%rip)        # 13be8 <fwp_cleanups>
    c07f:	49 c7 06 00 00 00 00 	movq   $0x0,(%r14)
    c086:	48 8b 7c 24 18       	mov    0x18(%rsp),%rdi
    c08b:	48 39 df             	cmp    %rbx,%rdi
    c08e:	0f 84 27 ff ff ff    	je     bfbb <fwp_closure_drop+0xbb>
    c094:	e8 b7 5f ff ff       	call   2050 <free@plt>
    c099:	e9 1d ff ff ff       	jmp    bfbb <fwp_closure_drop+0xbb>
    c09e:	48 81 c4 30 02 00 00 	add    $0x230,%rsp
    c0a5:	5b                   	pop    %rbx
    c0a6:	41 5e                	pop    %r14
    c0a8:	41 5f                	pop    %r15
    c0aa:	e9 81 e5 ff ff       	jmp    a630 <fwp_rc_wide_drop>
    c0af:	e8 3c a2 ff ff       	call   62f0 <fwp_flush>
    c0b4:	48 8b 05 25 5f 00 00 	mov    0x5f25(%rip),%rax        # 11fe0 <stderr@GLIBC_2.2.5>
    c0bb:	48 8b 38             	mov    (%rax),%rdi
    c0be:	48 8d 35 68 33 00 00 	lea    0x3368(%rip),%rsi        # f42d <fwp_segv.msg+0x1ed>
    c0c5:	48 8d 15 e9 35 00 00 	lea    0x35e9(%rip),%rdx        # f6b5 <fwp_segv.msg+0x475>
    c0cc:	31 c0                	xor    %eax,%eax
    c0ce:	e8 dd 60 ff ff       	call   21b0 <fprintf@plt>
    c0d3:	bf 65 00 00 00       	mov    $0x65,%edi
    c0d8:	e8 b3 61 ff ff       	call   2290 <exit@plt>
    c0dd:	e8 7e 5f ff ff       	call   2060 <abort@plt>
    c0e2:	66 66 66 66 66 2e 0f 	data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    c0e9:	1f 84 00 00 00 00 00 

000000000000c0f0 <fwp_closure_drop_push>:
    c0f0:	55                   	push   %rbp
    c0f1:	41 57                	push   %r15
    c0f3:	41 56                	push   %r14
    c0f5:	41 55                	push   %r13
    c0f7:	41 54                	push   %r12
    c0f9:	53                   	push   %rbx
    c0fa:	50                   	push   %rax
    c0fb:	48 89 f3             	mov    %rsi,%rbx
    c0fe:	49 89 fe             	mov    %rdi,%r14
    c101:	4c 8b 6f 08          	mov    0x8(%rdi),%r13
    c105:	4c 3b 6f 10          	cmp    0x10(%rdi),%r13
    c109:	75 59                	jne    c164 <fwp_closure_drop_push+0x74>
    c10b:	4c 89 e8             	mov    %r13,%rax
    c10e:	48 c1 e8 3c          	shr    $0x3c,%rax
    c112:	75 6e                	jne    c182 <fwp_closure_drop_push+0x92>
    c114:	4c 89 ef             	mov    %r13,%rdi
    c117:	48 c1 e7 04          	shl    $0x4,%rdi
    c11b:	e8 d0 60 ff ff       	call   21f0 <malloc@plt>
    c120:	48 85 c0             	test   %rax,%rax
    c123:	74 7c                	je     c1a1 <fwp_closure_drop_push+0xb1>
    c125:	49 89 c7             	mov    %rax,%r15
    c128:	4a 8d 2c 6d 00 00 00 	lea    0x0(,%r13,2),%rbp
    c12f:	00 
    c130:	4d 8b 26             	mov    (%r14),%r12
    c133:	4a 8d 14 ed 00 00 00 	lea    0x0(,%r13,8),%rdx
    c13a:	00 
    c13b:	48 89 c7             	mov    %rax,%rdi
    c13e:	4c 89 e6             	mov    %r12,%rsi
    c141:	e8 9a 60 ff ff       	call   21e0 <memcpy@plt>
    c146:	49 8d 46 18          	lea    0x18(%r14),%rax
    c14a:	49 39 c4             	cmp    %rax,%r12
    c14d:	74 0c                	je     c15b <fwp_closure_drop_push+0x6b>
    c14f:	4c 89 e7             	mov    %r12,%rdi
    c152:	e8 f9 5e ff ff       	call   2050 <free@plt>
    c157:	4d 8b 6e 08          	mov    0x8(%r14),%r13
    c15b:	4d 89 3e             	mov    %r15,(%r14)
    c15e:	49 89 6e 10          	mov    %rbp,0x10(%r14)
    c162:	eb 03                	jmp    c167 <fwp_closure_drop_push+0x77>
    c164:	4d 8b 3e             	mov    (%r14),%r15
    c167:	49 8d 45 01          	lea    0x1(%r13),%rax
    c16b:	49 89 46 08          	mov    %rax,0x8(%r14)
    c16f:	4b 89 1c ef          	mov    %rbx,(%r15,%r13,8)
    c173:	48 83 c4 08          	add    $0x8,%rsp
    c177:	5b                   	pop    %rbx
    c178:	41 5c                	pop    %r12
    c17a:	41 5d                	pop    %r13
    c17c:	41 5e                	pop    %r14
    c17e:	41 5f                	pop    %r15
    c180:	5d                   	pop    %rbp
    c181:	c3                   	ret
    c182:	e8 69 a1 ff ff       	call   62f0 <fwp_flush>
    c187:	48 8b 05 52 5e 00 00 	mov    0x5e52(%rip),%rax        # 11fe0 <stderr@GLIBC_2.2.5>
    c18e:	48 8b 38             	mov    (%rax),%rdi
    c191:	48 8d 35 95 32 00 00 	lea    0x3295(%rip),%rsi        # f42d <fwp_segv.msg+0x1ed>
    c198:	48 8d 15 44 35 00 00 	lea    0x3544(%rip),%rdx        # f6e3 <fwp_segv.msg+0x4a3>
    c19f:	eb 1d                	jmp    c1be <fwp_closure_drop_push+0xce>
    c1a1:	e8 4a a1 ff ff       	call   62f0 <fwp_flush>
    c1a6:	48 8b 05 33 5e 00 00 	mov    0x5e33(%rip),%rax        # 11fe0 <stderr@GLIBC_2.2.5>
    c1ad:	48 8b 38             	mov    (%rax),%rdi
    c1b0:	48 8d 35 76 32 00 00 	lea    0x3276(%rip),%rsi        # f42d <fwp_segv.msg+0x1ed>
    c1b7:	48 8d 15 3f 35 00 00 	lea    0x353f(%rip),%rdx        # f6fd <fwp_segv.msg+0x4bd>
    c1be:	31 c0                	xor    %eax,%eax
    c1c0:	e8 eb 5f ff ff       	call   21b0 <fprintf@plt>
    c1c5:	bf 65 00 00 00       	mov    $0x65,%edi
    c1ca:	e8 c1 60 ff ff       	call   2290 <exit@plt>
    c1cf:	90                   	nop

000000000000c1d0 <fwp_closure_drop_release>:
    c1d0:	41 56                	push   %r14
    c1d2:	53                   	push   %rbx
    c1d3:	50                   	push   %rax
    c1d4:	48 89 fb             	mov    %rdi,%rbx
    c1d7:	64 48 c7 04 25 f8 ff 	movq   $0x0,%fs:0xfffffffffffffff8
    c1de:	ff ff 00 00 00 00 
    c1e4:	48 8b 3f             	mov    (%rdi),%rdi
    c1e7:	4c 8d 73 18          	lea    0x18(%rbx),%r14
    c1eb:	4c 39 f7             	cmp    %r14,%rdi
    c1ee:	74 05                	je     c1f5 <fwp_closure_drop_release+0x25>
    c1f0:	e8 5b 5e ff ff       	call   2050 <free@plt>
    c1f5:	4c 89 33             	mov    %r14,(%rbx)
    c1f8:	48 c7 43 08 00 00 00 	movq   $0x0,0x8(%rbx)
    c1ff:	00 
    c200:	48 83 c4 08          	add    $0x8,%rsp
    c204:	5b                   	pop    %rbx
    c205:	41 5e                	pop    %r14
    c207:	c3                   	ret
    c208:	0f 1f 84 00 00 00 00 	nopl   0x0(%rax,%rax,1)
    c20f:	00 

000000000000c210 <f52>:
    c210:	41 57                	push   %r15
    c212:	41 56                	push   %r14
    c214:	53                   	push   %rbx
    c215:	48 83 ec 30          	sub    $0x30,%rsp
    c219:	48 89 fb             	mov    %rdi,%rbx
    c21c:	48 8b 47 10          	mov    0x10(%rdi),%rax
    c220:	48 2b 05 89 6f 00 00 	sub    0x6f89(%rip),%rax        # 131b0 <fwp_gc+0x1030>
    c227:	48 8b 0d aa 6f 00 00 	mov    0x6faa(%rip),%rcx        # 131d8 <fwp_gc+0x1058>
    c22e:	48 c1 e1 10          	shl    $0x10,%rcx
    c232:	48 39 c8             	cmp    %rcx,%rax
    c235:	73 68                	jae    c29f <f52+0x8f>
    c237:	48 8b 0d ba 6f 00 00 	mov    0x6fba(%rip),%rcx        # 131f8 <fwp_gc+0x1078>
    c23e:	48 89 c2             	mov    %rax,%rdx
    c241:	48 c1 ea 10          	shr    $0x10,%rdx
    c245:	48 69 d2 28 12 00 00 	imul   $0x1228,%rdx,%rdx
    c24c:	0f b6 34 11          	movzbl (%rcx,%rdx,1),%esi
    c250:	48 25 ff ff 00 00    	and    $0xffff,%rax
    c256:	75 13                	jne    c26b <f52+0x5b>
    c258:	40 80 fe 02          	cmp    $0x2,%sil
    c25c:	75 0d                	jne    c26b <f52+0x5b>
    c25e:	48 8d 3c 11          	lea    (%rcx,%rdx,1),%rdi
    c262:	48 81 c7 28 02 00 00 	add    $0x228,%rdi
    c269:	eb 21                	jmp    c28c <f52+0x7c>
    c26b:	40 80 fe 01          	cmp    $0x1,%sil
    c26f:	75 2e                	jne    c29f <f52+0x8f>
    c271:	48 8d 34 11          	lea    (%rcx,%rdx,1),%rsi
    c275:	8b 4c 11 20          	mov    0x20(%rcx,%rdx,1),%ecx
    c279:	48 0f af c1          	imul   %rcx,%rax
    c27d:	48 c1 e8 20          	shr    $0x20,%rax
    c281:	48 8d 3c 30          	lea    (%rax,%rsi,1),%rdi
    c285:	48 81 c7 28 02 00 00 	add    $0x228,%rdi
    c28c:	0f b6 07             	movzbl (%rdi),%eax
    c28f:	84 c0                	test   %al,%al
    c291:	74 0c                	je     c29f <f52+0x8f>
    c293:	3c fe                	cmp    $0xfe,%al
    c295:	0f 83 cb 02 00 00    	jae    c566 <f52+0x356>
    c29b:	fe c0                	inc    %al
    c29d:	88 07                	mov    %al,(%rdi)
    c29f:	4c 8b 7b 08          	mov    0x8(%rbx),%r15
    c2a3:	48 8b 7b 10          	mov    0x10(%rbx),%rdi
    c2a7:	48 8b 43 18          	mov    0x18(%rbx),%rax
    c2ab:	4d 85 ff             	test   %r15,%r15
    c2ae:	78 20                	js     c2d0 <f52+0xc0>
    c2b0:	48 8b 0f             	mov    (%rdi),%rcx
    c2b3:	48 ba ff ff ff ff ff 	movabs $0x7fffffffffffffff,%rdx
    c2ba:	ff ff 7f 
    c2bd:	48 21 ca             	and    %rcx,%rdx
    c2c0:	4c 39 fa             	cmp    %r15,%rdx
    c2c3:	76 0b                	jbe    c2d0 <f52+0xc0>
    c2c5:	48 85 c9             	test   %rcx,%rcx
    c2c8:	78 79                	js     c343 <f52+0x133>
    c2ca:	48 8d 4f 08          	lea    0x8(%rdi),%rcx
    c2ce:	eb 77                	jmp    c347 <f52+0x137>
    c2d0:	41 89 c6             	mov    %eax,%r14d
    c2d3:	e8 68 03 00 00       	call   c640 <fwp_drop7>
    c2d8:	4c 89 74 24 18       	mov    %r14,0x18(%rsp)
    c2dd:	48 8d 54 24 18       	lea    0x18(%rsp),%rdx
    c2e2:	bf 01 00 00 00       	mov    $0x1,%edi
    c2e7:	be 01 00 00 00       	mov    $0x1,%esi
    c2ec:	e8 ff da ff ff       	call   9df0 <fwp_data>
    c2f1:	49 89 c6             	mov    %rax,%r14
    c2f4:	48 2b 05 b5 6e 00 00 	sub    0x6eb5(%rip),%rax        # 131b0 <fwp_gc+0x1030>
    c2fb:	48 8b 0d d6 6e 00 00 	mov    0x6ed6(%rip),%rcx        # 131d8 <fwp_gc+0x1058>
    c302:	48 c1 e1 10          	shl    $0x10,%rcx
    c306:	48 39 c8             	cmp    %rcx,%rax
    c309:	0f 83 42 02 00 00    	jae    c551 <f52+0x341>
    c30f:	48 8b 0d e2 6e 00 00 	mov    0x6ee2(%rip),%rcx        # 131f8 <fwp_gc+0x1078>
    c316:	48 89 c2             	mov    %rax,%rdx
    c319:	48 c1 ea 10          	shr    $0x10,%rdx
    c31d:	48 69 d2 28 12 00 00 	imul   $0x1228,%rdx,%rdx
    c324:	0f b6 34 11          	movzbl (%rcx,%rdx,1),%esi
    c328:	48 25 ff ff 00 00    	and    $0xffff,%rax
    c32e:	0f 85 ec 01 00 00    	jne    c520 <f52+0x310>
    c334:	40 80 fe 02          	cmp    $0x2,%sil
    c338:	0f 84 cb 01 00 00    	je     c509 <f52+0x2f9>
    c33e:	e9 dd 01 00 00       	jmp    c520 <f52+0x310>
    c343:	48 8b 4f 10          	mov    0x10(%rdi),%rcx
    c347:	89 44 24 0c          	mov    %eax,0xc(%rsp)
    c34b:	f3 42 0f 10 04 b9    	movss  (%rcx,%r15,4),%xmm0
    c351:	f3 0f 59 05 ab 2c 00 	mulss  0x2cab(%rip),%xmm0        # f004 <_IO_stdin_used+0x4>
    c358:	00 
    c359:	f3 0f 58 05 a7 2c 00 	addss  0x2ca7(%rip),%xmm0        # f008 <_IO_stdin_used+0x8>
    c360:	00 
    c361:	f3 0f 11 44 24 08    	movss  %xmm0,0x8(%rsp)
    c367:	48 89 f8             	mov    %rdi,%rax
    c36a:	48 2b 05 3f 6e 00 00 	sub    0x6e3f(%rip),%rax        # 131b0 <fwp_gc+0x1030>
    c371:	49 ff c7             	inc    %r15
    c374:	48 8b 0d 5d 6e 00 00 	mov    0x6e5d(%rip),%rcx        # 131d8 <fwp_gc+0x1058>
    c37b:	48 c1 e1 10          	shl    $0x10,%rcx
    c37f:	48 39 c8             	cmp    %rcx,%rax
    c382:	73 66                	jae    c3ea <f52+0x1da>
    c384:	48 8b 0d 6d 6e 00 00 	mov    0x6e6d(%rip),%rcx        # 131f8 <fwp_gc+0x1078>
    c38b:	48 89 c2             	mov    %rax,%rdx
    c38e:	48 c1 ea 10          	shr    $0x10,%rdx
    c392:	48 69 d2 28 12 00 00 	imul   $0x1228,%rdx,%rdx
    c399:	0f b6 34 11          	movzbl (%rcx,%rdx,1),%esi
    c39d:	48 25 ff ff 00 00    	and    $0xffff,%rax
    c3a3:	75 12                	jne    c3b7 <f52+0x1a7>
    c3a5:	40 80 fe 02          	cmp    $0x2,%sil
    c3a9:	75 0c                	jne    c3b7 <f52+0x1a7>
    c3ab:	48 8d 04 11          	lea    (%rcx,%rdx,1),%rax
    c3af:	48 05 28 02 00 00    	add    $0x228,%rax
    c3b5:	eb 1f                	jmp    c3d6 <f52+0x1c6>
    c3b7:	40 80 fe 01          	cmp    $0x1,%sil
    c3bb:	75 2d                	jne    c3ea <f52+0x1da>
    c3bd:	48 8d 34 11          	lea    (%rcx,%rdx,1),%rsi
    c3c1:	8b 4c 11 20          	mov    0x20(%rcx,%rdx,1),%ecx
    c3c5:	48 0f af c1          	imul   %rcx,%rax
    c3c9:	48 c1 e8 20          	shr    $0x20,%rax
    c3cd:	48 01 f0             	add    %rsi,%rax
    c3d0:	48 05 28 02 00 00    	add    $0x228,%rax
    c3d6:	0f b6 08             	movzbl (%rax),%ecx
    c3d9:	84 c9                	test   %cl,%cl
    c3db:	74 0d                	je     c3ea <f52+0x1da>
    c3dd:	80 f9 fe             	cmp    $0xfe,%cl
    c3e0:	0f 83 8a 01 00 00    	jae    c570 <f52+0x360>
    c3e6:	fe c1                	inc    %cl
    c3e8:	88 08                	mov    %cl,(%rax)
    c3ea:	49 89 fe             	mov    %rdi,%r14
    c3ed:	e8 4e 02 00 00       	call   c640 <fwp_drop7>
    c3f2:	f3 0f 10 44 24 08    	movss  0x8(%rsp),%xmm0
    c3f8:	f3 0f 58 44 24 0c    	addss  0xc(%rsp),%xmm0
    c3fe:	66 0f 7e c0          	movd   %xmm0,%eax
    c402:	4c 89 7c 24 18       	mov    %r15,0x18(%rsp)
    c407:	4c 89 74 24 20       	mov    %r14,0x20(%rsp)
    c40c:	48 89 44 24 28       	mov    %rax,0x28(%rsp)
    c411:	48 8d 54 24 18       	lea    0x18(%rsp),%rdx
    c416:	31 ff                	xor    %edi,%edi
    c418:	be 03 00 00 00       	mov    $0x3,%esi
    c41d:	e8 ce d9 ff ff       	call   9df0 <fwp_data>
    c422:	48 89 c1             	mov    %rax,%rcx
    c425:	48 2b 0d 84 6d 00 00 	sub    0x6d84(%rip),%rcx        # 131b0 <fwp_gc+0x1030>
    c42c:	48 8b 15 a5 6d 00 00 	mov    0x6da5(%rip),%rdx        # 131d8 <fwp_gc+0x1058>
    c433:	48 c1 e2 10          	shl    $0x10,%rdx
    c437:	48 39 d1             	cmp    %rdx,%rcx
    c43a:	73 76                	jae    c4b2 <f52+0x2a2>
    c43c:	48 8b 15 b5 6d 00 00 	mov    0x6db5(%rip),%rdx        # 131f8 <fwp_gc+0x1078>
    c443:	48 89 ce             	mov    %rcx,%rsi
    c446:	48 c1 ee 10          	shr    $0x10,%rsi
    c44a:	48 69 f6 28 12 00 00 	imul   $0x1228,%rsi,%rsi
    c451:	0f b6 3c 32          	movzbl (%rdx,%rsi,1),%edi
    c455:	48 81 e1 ff ff 00 00 	and    $0xffff,%rcx
    c45c:	75 1d                	jne    c47b <f52+0x26b>
    c45e:	40 80 ff 02          	cmp    $0x2,%dil
    c462:	75 17                	jne    c47b <f52+0x26b>
    c464:	4c 8d 34 32          	lea    (%rdx,%rsi,1),%r14
    c468:	49 81 c6 28 02 00 00 	add    $0x228,%r14
    c46f:	41 80 3e ff          	cmpb   $0xff,(%r14)
    c473:	74 2d                	je     c4a2 <f52+0x292>
    c475:	41 c6 06 01          	movb   $0x1,(%r14)
    c479:	eb 37                	jmp    c4b2 <f52+0x2a2>
    c47b:	40 80 ff 01          	cmp    $0x1,%dil
    c47f:	75 31                	jne    c4b2 <f52+0x2a2>
    c481:	48 8d 3c 32          	lea    (%rdx,%rsi,1),%rdi
    c485:	8b 54 32 20          	mov    0x20(%rdx,%rsi,1),%edx
    c489:	48 0f af ca          	imul   %rdx,%rcx
    c48d:	48 c1 e9 20          	shr    $0x20,%rcx
    c491:	4c 8d 34 39          	lea    (%rcx,%rdi,1),%r14
    c495:	49 81 c6 28 02 00 00 	add    $0x228,%r14
    c49c:	41 80 3e ff          	cmpb   $0xff,(%r14)
    c4a0:	75 d3                	jne    c475 <f52+0x265>
    c4a2:	4c 89 f7             	mov    %r14,%rdi
    c4a5:	49 89 c7             	mov    %rax,%r15
    c4a8:	e8 73 9e ff ff       	call   6320 <fwp_rc_forget_slot>
    c4ad:	4c 89 f8             	mov    %r15,%rax
    c4b0:	eb c3                	jmp    c475 <f52+0x265>
    c4b2:	48 89 44 24 10       	mov    %rax,0x10(%rsp)
    c4b7:	48 8d 54 24 10       	lea    0x10(%rsp),%rdx
    c4bc:	31 ff                	xor    %edi,%edi
    c4be:	be 01 00 00 00       	mov    $0x1,%esi
    c4c3:	e8 28 d9 ff ff       	call   9df0 <fwp_data>
    c4c8:	49 89 c6             	mov    %rax,%r14
    c4cb:	48 2b 05 de 6c 00 00 	sub    0x6cde(%rip),%rax        # 131b0 <fwp_gc+0x1030>
    c4d2:	48 8b 0d ff 6c 00 00 	mov    0x6cff(%rip),%rcx        # 131d8 <fwp_gc+0x1058>
    c4d9:	48 c1 e1 10          	shl    $0x10,%rcx
    c4dd:	48 39 c8             	cmp    %rcx,%rax
    c4e0:	73 6f                	jae    c551 <f52+0x341>
    c4e2:	48 8b 0d 0f 6d 00 00 	mov    0x6d0f(%rip),%rcx        # 131f8 <fwp_gc+0x1078>
    c4e9:	48 89 c2             	mov    %rax,%rdx
    c4ec:	48 c1 ea 10          	shr    $0x10,%rdx
    c4f0:	48 69 d2 28 12 00 00 	imul   $0x1228,%rdx,%rdx
    c4f7:	0f b6 34 11          	movzbl (%rcx,%rdx,1),%esi
    c4fb:	48 25 ff ff 00 00    	and    $0xffff,%rax
    c501:	75 1d                	jne    c520 <f52+0x310>
    c503:	40 80 fe 02          	cmp    $0x2,%sil
    c507:	75 17                	jne    c520 <f52+0x310>
    c509:	4c 8d 3c 11          	lea    (%rcx,%rdx,1),%r15
    c50d:	49 81 c7 28 02 00 00 	add    $0x228,%r15
    c514:	41 80 3f ff          	cmpb   $0xff,(%r15)
    c518:	74 2d                	je     c547 <f52+0x337>
    c51a:	41 c6 07 01          	movb   $0x1,(%r15)
    c51e:	eb 31                	jmp    c551 <f52+0x341>
    c520:	40 80 fe 01          	cmp    $0x1,%sil
    c524:	75 2b                	jne    c551 <f52+0x341>
    c526:	48 8d 34 11          	lea    (%rcx,%rdx,1),%rsi
    c52a:	8b 4c 11 20          	mov    0x20(%rcx,%rdx,1),%ecx
    c52e:	48 0f af c1          	imul   %rcx,%rax
    c532:	48 c1 e8 20          	shr    $0x20,%rax
    c536:	4c 8d 3c 30          	lea    (%rax,%rsi,1),%r15
    c53a:	49 81 c7 28 02 00 00 	add    $0x228,%r15
    c541:	41 80 3f ff          	cmpb   $0xff,(%r15)
    c545:	75 d3                	jne    c51a <f52+0x30a>
    c547:	4c 89 ff             	mov    %r15,%rdi
    c54a:	e8 d1 9d ff ff       	call   6320 <fwp_rc_forget_slot>
    c54f:	eb c9                	jmp    c51a <f52+0x30a>
    c551:	48 89 df             	mov    %rbx,%rdi
    c554:	e8 37 00 00 00       	call   c590 <fwp_drop8>
    c559:	4c 89 f0             	mov    %r14,%rax
    c55c:	48 83 c4 30          	add    $0x30,%rsp
    c560:	5b                   	pop    %rbx
    c561:	41 5e                	pop    %r14
    c563:	41 5f                	pop    %r15
    c565:	c3                   	ret
    c566:	e8 95 b0 ff ff       	call   7600 <fwp_rc_wide_dup>
    c56b:	e9 2f fd ff ff       	jmp    c29f <f52+0x8f>
    c570:	49 89 fe             	mov    %rdi,%r14
    c573:	48 89 c7             	mov    %rax,%rdi
    c576:	e8 85 b0 ff ff       	call   7600 <fwp_rc_wide_dup>
    c57b:	4c 89 f7             	mov    %r14,%rdi
    c57e:	e9 67 fe ff ff       	jmp    c3ea <f52+0x1da>
    c583:	66 66 66 66 2e 0f 1f 	data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    c58a:	84 00 00 00 00 00 

000000000000c590 <fwp_drop8>:
    c590:	48 89 f8             	mov    %rdi,%rax
    c593:	48 2b 05 16 6c 00 00 	sub    0x6c16(%rip),%rax        # 131b0 <fwp_gc+0x1030>
    c59a:	48 8b 0d 37 6c 00 00 	mov    0x6c37(%rip),%rcx        # 131d8 <fwp_gc+0x1058>
    c5a1:	48 c1 e1 10          	shl    $0x10,%rcx
    c5a5:	48 39 c8             	cmp    %rcx,%rax
    c5a8:	0f 83 83 00 00 00    	jae    c631 <fwp_drop8+0xa1>
    c5ae:	48 8b 0d 43 6c 00 00 	mov    0x6c43(%rip),%rcx        # 131f8 <fwp_gc+0x1078>
    c5b5:	48 89 c2             	mov    %rax,%rdx
    c5b8:	48 c1 ea 10          	shr    $0x10,%rdx
    c5bc:	48 69 d2 28 12 00 00 	imul   $0x1228,%rdx,%rdx
    c5c3:	0f b6 34 11          	movzbl (%rcx,%rdx,1),%esi
    c5c7:	48 25 ff ff 00 00    	and    $0xffff,%rax
    c5cd:	75 12                	jne    c5e1 <fwp_drop8+0x51>
    c5cf:	40 80 fe 02          	cmp    $0x2,%sil
    c5d3:	75 0c                	jne    c5e1 <fwp_drop8+0x51>
    c5d5:	48 8d 04 11          	lea    (%rcx,%rdx,1),%rax
    c5d9:	48 05 28 02 00 00    	add    $0x228,%rax
    c5df:	eb 1f                	jmp    c600 <fwp_drop8+0x70>
    c5e1:	40 80 fe 01          	cmp    $0x1,%sil
    c5e5:	75 4a                	jne    c631 <fwp_drop8+0xa1>
    c5e7:	48 8d 34 11          	lea    (%rcx,%rdx,1),%rsi
    c5eb:	8b 4c 11 20          	mov    0x20(%rcx,%rdx,1),%ecx
    c5ef:	48 0f af c1          	imul   %rcx,%rax
    c5f3:	48 c1 e8 20          	shr    $0x20,%rax
    c5f7:	48 01 f0             	add    %rsi,%rax
    c5fa:	48 05 28 02 00 00    	add    $0x228,%rax
    c600:	0f b6 08             	movzbl (%rax),%ecx
    c603:	85 c9                	test   %ecx,%ecx
    c605:	74 2a                	je     c631 <fwp_drop8+0xa1>
    c607:	83 f9 01             	cmp    $0x1,%ecx
    c60a:	75 19                	jne    c625 <fwp_drop8+0x95>
    c60c:	53                   	push   %rbx
    c60d:	48 8b 47 10          	mov    0x10(%rdi),%rax
    c611:	48 89 fb             	mov    %rdi,%rbx
    c614:	48 89 c7             	mov    %rax,%rdi
    c617:	e8 24 00 00 00       	call   c640 <fwp_drop7>
    c61c:	48 89 df             	mov    %rbx,%rdi
    c61f:	5b                   	pop    %rbx
    c620:	e9 eb e2 ff ff       	jmp    a910 <fwp_rc_free_obj>
    c625:	81 f9 ff 00 00 00    	cmp    $0xff,%ecx
    c62b:	74 05                	je     c632 <fwp_drop8+0xa2>
    c62d:	fe c9                	dec    %cl
    c62f:	88 08                	mov    %cl,(%rax)
    c631:	c3                   	ret
    c632:	48 89 c7             	mov    %rax,%rdi
    c635:	e9 f6 df ff ff       	jmp    a630 <fwp_rc_wide_drop>
    c63a:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)

000000000000c640 <fwp_drop7>:
    c640:	53                   	push   %rbx
    c641:	48 89 f8             	mov    %rdi,%rax
    c644:	48 2b 05 65 6b 00 00 	sub    0x6b65(%rip),%rax        # 131b0 <fwp_gc+0x1030>
    c64b:	48 8b 0d 86 6b 00 00 	mov    0x6b86(%rip),%rcx        # 131d8 <fwp_gc+0x1058>
    c652:	48 c1 e1 10          	shl    $0x10,%rcx
    c656:	48 39 c8             	cmp    %rcx,%rax
    c659:	0f 83 9c 00 00 00    	jae    c6fb <fwp_drop7+0xbb>
    c65f:	48 8b 0d 92 6b 00 00 	mov    0x6b92(%rip),%rcx        # 131f8 <fwp_gc+0x1078>
    c666:	48 89 c2             	mov    %rax,%rdx
    c669:	48 c1 ea 10          	shr    $0x10,%rdx
    c66d:	48 69 d2 28 12 00 00 	imul   $0x1228,%rdx,%rdx
    c674:	0f b6 34 11          	movzbl (%rcx,%rdx,1),%esi
    c678:	48 25 ff ff 00 00    	and    $0xffff,%rax
    c67e:	75 20                	jne    c6a0 <fwp_drop7+0x60>
    c680:	40 80 fe 02          	cmp    $0x2,%sil
    c684:	75 1a                	jne    c6a0 <fwp_drop7+0x60>
    c686:	48 8d 04 11          	lea    (%rcx,%rdx,1),%rax
    c68a:	48 05 28 02 00 00    	add    $0x228,%rax
    c690:	eb 2d                	jmp    c6bf <fwp_drop7+0x7f>
    c692:	66 66 66 66 66 2e 0f 	data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    c699:	1f 84 00 00 00 00 00 
    c6a0:	40 80 fe 01          	cmp    $0x1,%sil
    c6a4:	75 55                	jne    c6fb <fwp_drop7+0xbb>
    c6a6:	48 8d 34 11          	lea    (%rcx,%rdx,1),%rsi
    c6aa:	8b 4c 11 20          	mov    0x20(%rcx,%rdx,1),%ecx
    c6ae:	48 0f af c1          	imul   %rcx,%rax
    c6b2:	48 c1 e8 20          	shr    $0x20,%rax
    c6b6:	48 01 f0             	add    %rsi,%rax
    c6b9:	48 05 28 02 00 00    	add    $0x228,%rax
    c6bf:	0f b6 08             	movzbl (%rax),%ecx
    c6c2:	85 c9                	test   %ecx,%ecx
    c6c4:	74 35                	je     c6fb <fwp_drop7+0xbb>
    c6c6:	83 f9 01             	cmp    $0x1,%ecx
    c6c9:	75 32                	jne    c6fd <fwp_drop7+0xbd>
    c6cb:	48 83 3f 00          	cmpq   $0x0,(%rdi)
    c6cf:	79 3a                	jns    c70b <fwp_drop7+0xcb>
    c6d1:	48 8b 5f 08          	mov    0x8(%rdi),%rbx
    c6d5:	e8 46 de ff ff       	call   a520 <fwp_rc_free_arr>
    c6da:	48 89 d8             	mov    %rbx,%rax
    c6dd:	48 2b 05 cc 6a 00 00 	sub    0x6acc(%rip),%rax        # 131b0 <fwp_gc+0x1030>
    c6e4:	48 8b 0d ed 6a 00 00 	mov    0x6aed(%rip),%rcx        # 131d8 <fwp_gc+0x1058>
    c6eb:	48 c1 e1 10          	shl    $0x10,%rcx
    c6ef:	48 89 df             	mov    %rbx,%rdi
    c6f2:	48 39 c8             	cmp    %rcx,%rax
    c6f5:	0f 82 64 ff ff ff    	jb     c65f <fwp_drop7+0x1f>
    c6fb:	5b                   	pop    %rbx
    c6fc:	c3                   	ret
    c6fd:	81 f9 ff 00 00 00    	cmp    $0xff,%ecx
    c703:	74 0c                	je     c711 <fwp_drop7+0xd1>
    c705:	fe c9                	dec    %cl
    c707:	88 08                	mov    %cl,(%rax)
    c709:	5b                   	pop    %rbx
    c70a:	c3                   	ret
    c70b:	5b                   	pop    %rbx
    c70c:	e9 0f de ff ff       	jmp    a520 <fwp_rc_free_arr>
    c711:	48 89 c7             	mov    %rax,%rdi
    c714:	5b                   	pop    %rbx
    c715:	e9 16 df ff ff       	jmp    a630 <fwp_rc_wide_drop>
    c71a:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)

000000000000c720 <fwp_owned_entry52>:
    c720:	48 8b 3f             	mov    (%rdi),%rdi
    c723:	e9 e8 fa ff ff       	jmp    c210 <f52>
    c728:	0f 1f 84 00 00 00 00 	nopl   0x0(%rax,%rax,1)
    c72f:	00 

000000000000c730 <fwp_caps52>:
    c730:	53                   	push   %rbx
    c731:	83 7f 04 00          	cmpl   $0x0,0x4(%rdi)
    c735:	74 56                	je     c78d <fwp_caps52+0x5d>
    c737:	48 89 fb             	mov    %rdi,%rbx
    c73a:	48 8b 7f 08          	mov    0x8(%rdi),%rdi
    c73e:	85 f6                	test   %esi,%esi
    c740:	74 51                	je     c793 <fwp_caps52+0x63>
    c742:	48 2b 3d 67 6a 00 00 	sub    0x6a67(%rip),%rdi        # 131b0 <fwp_gc+0x1030>
    c749:	48 8b 05 88 6a 00 00 	mov    0x6a88(%rip),%rax        # 131d8 <fwp_gc+0x1058>
    c750:	48 c1 e0 10          	shl    $0x10,%rax
    c754:	48 39 c7             	cmp    %rax,%rdi
    c757:	73 38                	jae    c791 <fwp_caps52+0x61>
    c759:	48 8b 05 98 6a 00 00 	mov    0x6a98(%rip),%rax        # 131f8 <fwp_gc+0x1078>
    c760:	48 89 f9             	mov    %rdi,%rcx
    c763:	48 c1 e9 10          	shr    $0x10,%rcx
    c767:	48 69 c9 28 12 00 00 	imul   $0x1228,%rcx,%rcx
    c76e:	0f b6 14 08          	movzbl (%rax,%rcx,1),%edx
    c772:	48 81 e7 ff ff 00 00 	and    $0xffff,%rdi
    c779:	75 26                	jne    c7a1 <fwp_caps52+0x71>
    c77b:	80 fa 02             	cmp    $0x2,%dl
    c77e:	75 21                	jne    c7a1 <fwp_caps52+0x71>
    c780:	48 8d 3c 08          	lea    (%rax,%rcx,1),%rdi
    c784:	48 81 c7 28 02 00 00 	add    $0x228,%rdi
    c78b:	eb 33                	jmp    c7c0 <fwp_caps52+0x90>
    c78d:	85 f6                	test   %esi,%esi
    c78f:	74 0a                	je     c79b <fwp_caps52+0x6b>
    c791:	5b                   	pop    %rbx
    c792:	c3                   	ret
    c793:	e8 f8 fd ff ff       	call   c590 <fwp_drop8>
    c798:	48 89 df             	mov    %rbx,%rdi
    c79b:	5b                   	pop    %rbx
    c79c:	e9 6f e1 ff ff       	jmp    a910 <fwp_rc_free_obj>
    c7a1:	80 fa 01             	cmp    $0x1,%dl
    c7a4:	75 eb                	jne    c791 <fwp_caps52+0x61>
    c7a6:	48 8d 14 08          	lea    (%rax,%rcx,1),%rdx
    c7aa:	8b 44 08 20          	mov    0x20(%rax,%rcx,1),%eax
    c7ae:	48 0f af f8          	imul   %rax,%rdi
    c7b2:	48 c1 ef 20          	shr    $0x20,%rdi
    c7b6:	48 01 d7             	add    %rdx,%rdi
    c7b9:	48 81 c7 28 02 00 00 	add    $0x228,%rdi
    c7c0:	0f b6 07             	movzbl (%rdi),%eax
    c7c3:	84 c0                	test   %al,%al
    c7c5:	74 ca                	je     c791 <fwp_caps52+0x61>
    c7c7:	3c fe                	cmp    $0xfe,%al
    c7c9:	73 06                	jae    c7d1 <fwp_caps52+0xa1>
    c7cb:	fe c0                	inc    %al
    c7cd:	88 07                	mov    %al,(%rdi)
    c7cf:	5b                   	pop    %rbx
    c7d0:	c3                   	ret
    c7d1:	5b                   	pop    %rbx
    c7d2:	e9 29 ae ff ff       	jmp    7600 <fwp_rc_wide_dup>
    c7d7:	66 0f 1f 84 00 00 00 	nopw   0x0(%rax,%rax,1)
    c7de:	00 00 

000000000000c7e0 <fwp_args52>:
    c7e0:	85 f6                	test   %esi,%esi
    c7e2:	0f 85 8a 00 00 00    	jne    c872 <fwp_args52+0x92>
    c7e8:	85 d2                	test   %edx,%edx
    c7ea:	0f 84 82 00 00 00    	je     c872 <fwp_args52+0x92>
    c7f0:	48 8b 07             	mov    (%rdi),%rax
    c7f3:	48 2b 05 b6 69 00 00 	sub    0x69b6(%rip),%rax        # 131b0 <fwp_gc+0x1030>
    c7fa:	48 8b 0d d7 69 00 00 	mov    0x69d7(%rip),%rcx        # 131d8 <fwp_gc+0x1058>
    c801:	48 c1 e1 10          	shl    $0x10,%rcx
    c805:	48 39 c8             	cmp    %rcx,%rax
    c808:	73 68                	jae    c872 <fwp_args52+0x92>
    c80a:	48 8b 0d e7 69 00 00 	mov    0x69e7(%rip),%rcx        # 131f8 <fwp_gc+0x1078>
    c811:	48 89 c2             	mov    %rax,%rdx
    c814:	48 c1 ea 10          	shr    $0x10,%rdx
    c818:	48 69 d2 28 12 00 00 	imul   $0x1228,%rdx,%rdx
    c81f:	0f b6 34 11          	movzbl (%rcx,%rdx,1),%esi
    c823:	48 25 ff ff 00 00    	and    $0xffff,%rax
    c829:	75 13                	jne    c83e <fwp_args52+0x5e>
    c82b:	40 80 fe 02          	cmp    $0x2,%sil
    c82f:	75 0d                	jne    c83e <fwp_args52+0x5e>
    c831:	48 8d 3c 11          	lea    (%rcx,%rdx,1),%rdi
    c835:	48 81 c7 28 02 00 00 	add    $0x228,%rdi
    c83c:	eb 21                	jmp    c85f <fwp_args52+0x7f>
    c83e:	40 80 fe 01          	cmp    $0x1,%sil
    c842:	75 2e                	jne    c872 <fwp_args52+0x92>
    c844:	48 8d 34 11          	lea    (%rcx,%rdx,1),%rsi
    c848:	8b 4c 11 20          	mov    0x20(%rcx,%rdx,1),%ecx
    c84c:	48 0f af c1          	imul   %rcx,%rax
    c850:	48 c1 e8 20          	shr    $0x20,%rax
    c854:	48 8d 3c 30          	lea    (%rax,%rsi,1),%rdi
    c858:	48 81 c7 28 02 00 00 	add    $0x228,%rdi
    c85f:	0f b6 07             	movzbl (%rdi),%eax
    c862:	84 c0                	test   %al,%al
    c864:	74 0c                	je     c872 <fwp_args52+0x92>
    c866:	3c fe                	cmp    $0xfe,%al
    c868:	0f 83 92 ad ff ff    	jae    7600 <fwp_rc_wide_dup>
    c86e:	fe c0                	inc    %al
    c870:	88 07                	mov    %al,(%rdi)
    c872:	c3                   	ret
    c873:	66 66 66 66 2e 0f 1f 	data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    c87a:	84 00 00 00 00 00 

000000000000c880 <fwp_arg_drop52>:
    c880:	85 f6                	test   %esi,%esi
    c882:	75 0c                	jne    c890 <fwp_arg_drop52+0x10>
    c884:	85 d2                	test   %edx,%edx
    c886:	74 08                	je     c890 <fwp_arg_drop52+0x10>
    c888:	48 8b 3f             	mov    (%rdi),%rdi
    c88b:	e9 00 fd ff ff       	jmp    c590 <fwp_drop8>
    c890:	c3                   	ret
    c891:	66 66 66 66 66 66 2e 	data16 data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    c898:	0f 1f 84 00 00 00 00 
    c89f:	00 

000000000000c8a0 <f55>:
    c8a0:	41 57                	push   %r15
    c8a2:	41 56                	push   %r14
    c8a4:	41 54                	push   %r12
    c8a6:	53                   	push   %rbx
    c8a7:	48 83 ec 78          	sub    $0x78,%rsp
    c8ab:	48 89 fb             	mov    %rdi,%rbx
    c8ae:	48 8b 47 10          	mov    0x10(%rdi),%rax
    c8b2:	48 2b 05 f7 68 00 00 	sub    0x68f7(%rip),%rax        # 131b0 <fwp_gc+0x1030>
    c8b9:	48 8b 0d 18 69 00 00 	mov    0x6918(%rip),%rcx        # 131d8 <fwp_gc+0x1058>
    c8c0:	48 c1 e1 10          	shl    $0x10,%rcx
    c8c4:	48 39 c8             	cmp    %rcx,%rax
    c8c7:	73 68                	jae    c931 <f55+0x91>
    c8c9:	48 8b 0d 28 69 00 00 	mov    0x6928(%rip),%rcx        # 131f8 <fwp_gc+0x1078>
    c8d0:	48 89 c2             	mov    %rax,%rdx
    c8d3:	48 c1 ea 10          	shr    $0x10,%rdx
    c8d7:	48 69 d2 28 12 00 00 	imul   $0x1228,%rdx,%rdx
    c8de:	0f b6 34 11          	movzbl (%rcx,%rdx,1),%esi
    c8e2:	48 25 ff ff 00 00    	and    $0xffff,%rax
    c8e8:	75 13                	jne    c8fd <f55+0x5d>
    c8ea:	40 80 fe 02          	cmp    $0x2,%sil
    c8ee:	75 0d                	jne    c8fd <f55+0x5d>
    c8f0:	48 8d 3c 11          	lea    (%rcx,%rdx,1),%rdi
    c8f4:	48 81 c7 28 02 00 00 	add    $0x228,%rdi
    c8fb:	eb 21                	jmp    c91e <f55+0x7e>
    c8fd:	40 80 fe 01          	cmp    $0x1,%sil
    c901:	75 2e                	jne    c931 <f55+0x91>
    c903:	48 8d 34 11          	lea    (%rcx,%rdx,1),%rsi
    c907:	8b 4c 11 20          	mov    0x20(%rcx,%rdx,1),%ecx
    c90b:	48 0f af c1          	imul   %rcx,%rax
    c90f:	48 c1 e8 20          	shr    $0x20,%rax
    c913:	48 8d 3c 30          	lea    (%rax,%rsi,1),%rdi
    c917:	48 81 c7 28 02 00 00 	add    $0x228,%rdi
    c91e:	0f b6 07             	movzbl (%rdi),%eax
    c921:	84 c0                	test   %al,%al
    c923:	74 0c                	je     c931 <f55+0x91>
    c925:	3c fe                	cmp    $0xfe,%al
    c927:	0f 83 bd 02 00 00    	jae    cbea <f55+0x34a>
    c92d:	fe c0                	inc    %al
    c92f:	88 07                	mov    %al,(%rdi)
    c931:	4c 8b 63 08          	mov    0x8(%rbx),%r12
    c935:	4c 8b 73 10          	mov    0x10(%rbx),%r14
    c939:	4c 8b 7b 18          	mov    0x18(%rbx),%r15
    c93d:	4d 85 e4             	test   %r12,%r12
    c940:	78 20                	js     c962 <f55+0xc2>
    c942:	49 8b 06             	mov    (%r14),%rax
    c945:	48 b9 ff ff ff ff ff 	movabs $0x7fffffffffffffff,%rcx
    c94c:	ff ff 7f 
    c94f:	48 21 c1             	and    %rax,%rcx
    c952:	4c 39 e1             	cmp    %r12,%rcx
    c955:	76 0b                	jbe    c962 <f55+0xc2>
    c957:	48 85 c0             	test   %rax,%rax
    c95a:	78 79                	js     c9d5 <f55+0x135>
    c95c:	49 8d 46 08          	lea    0x8(%r14),%rax
    c960:	eb 77                	jmp    c9d9 <f55+0x139>
    c962:	4c 89 f7             	mov    %r14,%rdi
    c965:	e8 a6 03 00 00       	call   cd10 <fwp_drop9>
    c96a:	4c 89 7c 24 10       	mov    %r15,0x10(%rsp)
    c96f:	48 8d 54 24 10       	lea    0x10(%rsp),%rdx
    c974:	bf 01 00 00 00       	mov    $0x1,%edi
    c979:	be 01 00 00 00       	mov    $0x1,%esi
    c97e:	e8 6d d4 ff ff       	call   9df0 <fwp_data>
    c983:	49 89 c6             	mov    %rax,%r14
    c986:	48 2b 05 23 68 00 00 	sub    0x6823(%rip),%rax        # 131b0 <fwp_gc+0x1030>
    c98d:	48 8b 0d 44 68 00 00 	mov    0x6844(%rip),%rcx        # 131d8 <fwp_gc+0x1058>
    c994:	48 c1 e1 10          	shl    $0x10,%rcx
    c998:	48 39 c8             	cmp    %rcx,%rax
    c99b:	0f 83 32 02 00 00    	jae    cbd3 <f55+0x333>
    c9a1:	48 8b 0d 50 68 00 00 	mov    0x6850(%rip),%rcx        # 131f8 <fwp_gc+0x1078>
    c9a8:	48 89 c2             	mov    %rax,%rdx
    c9ab:	48 c1 ea 10          	shr    $0x10,%rdx
    c9af:	48 69 d2 28 12 00 00 	imul   $0x1228,%rdx,%rdx
    c9b6:	0f b6 34 11          	movzbl (%rcx,%rdx,1),%esi
    c9ba:	48 25 ff ff 00 00    	and    $0xffff,%rax
    c9c0:	0f 85 dc 01 00 00    	jne    cba2 <f55+0x302>
    c9c6:	40 80 fe 02          	cmp    $0x2,%sil
    c9ca:	0f 84 bb 01 00 00    	je     cb8b <f55+0x2eb>
    c9d0:	e9 cd 01 00 00       	jmp    cba2 <f55+0x302>
    c9d5:	49 8b 46 10          	mov    0x10(%r14),%rax
    c9d9:	4a 0f be 04 20       	movsbq (%rax,%r12,1),%rax
    c9de:	48 83 c0 81          	add    $0xffffffffffffff81,%rax
    c9e2:	48 3d ff fe ff ff    	cmp    $0xfffffffffffffeff,%rax
    c9e8:	0f 86 10 02 00 00    	jbe    cbfe <f55+0x35e>
    c9ee:	4c 89 f0             	mov    %r14,%rax
    c9f1:	48 2b 05 b8 67 00 00 	sub    0x67b8(%rip),%rax        # 131b0 <fwp_gc+0x1030>
    c9f8:	48 8b 0d d9 67 00 00 	mov    0x67d9(%rip),%rcx        # 131d8 <fwp_gc+0x1058>
    c9ff:	48 c1 e1 10          	shl    $0x10,%rcx
    ca03:	48 39 c8             	cmp    %rcx,%rax
    ca06:	73 68                	jae    ca70 <f55+0x1d0>
    ca08:	48 8b 0d e9 67 00 00 	mov    0x67e9(%rip),%rcx        # 131f8 <fwp_gc+0x1078>
    ca0f:	48 89 c2             	mov    %rax,%rdx
    ca12:	48 c1 ea 10          	shr    $0x10,%rdx
    ca16:	48 69 d2 28 12 00 00 	imul   $0x1228,%rdx,%rdx
    ca1d:	0f b6 34 11          	movzbl (%rcx,%rdx,1),%esi
    ca21:	48 25 ff ff 00 00    	and    $0xffff,%rax
    ca27:	75 13                	jne    ca3c <f55+0x19c>
    ca29:	40 80 fe 02          	cmp    $0x2,%sil
    ca2d:	75 0d                	jne    ca3c <f55+0x19c>
    ca2f:	48 8d 3c 11          	lea    (%rcx,%rdx,1),%rdi
    ca33:	48 81 c7 28 02 00 00 	add    $0x228,%rdi
    ca3a:	eb 21                	jmp    ca5d <f55+0x1bd>
    ca3c:	40 80 fe 01          	cmp    $0x1,%sil
    ca40:	75 2e                	jne    ca70 <f55+0x1d0>
    ca42:	48 8d 34 11          	lea    (%rcx,%rdx,1),%rsi
    ca46:	8b 4c 11 20          	mov    0x20(%rcx,%rdx,1),%ecx
    ca4a:	48 0f af c1          	imul   %rcx,%rax
    ca4e:	48 c1 e8 20          	shr    $0x20,%rax
    ca52:	48 8d 3c 30          	lea    (%rax,%rsi,1),%rdi
    ca56:	48 81 c7 28 02 00 00 	add    $0x228,%rdi
    ca5d:	0f b6 07             	movzbl (%rdi),%eax
    ca60:	84 c0                	test   %al,%al
    ca62:	74 0c                	je     ca70 <f55+0x1d0>
    ca64:	3c fe                	cmp    $0xfe,%al
    ca66:	0f 83 88 01 00 00    	jae    cbf4 <f55+0x354>
    ca6c:	fe c0                	inc    %al
    ca6e:	88 07                	mov    %al,(%rdi)
    ca70:	4c 89 f7             	mov    %r14,%rdi
    ca73:	e8 98 02 00 00       	call   cd10 <fwp_drop9>
    ca78:	49 ff c7             	inc    %r15
    ca7b:	0f 80 8d 01 00 00    	jo     cc0e <f55+0x36e>
    ca81:	49 ff c4             	inc    %r12
    ca84:	4c 89 64 24 10       	mov    %r12,0x10(%rsp)
    ca89:	4c 89 74 24 18       	mov    %r14,0x18(%rsp)
    ca8e:	4c 89 7c 24 20       	mov    %r15,0x20(%rsp)
    ca93:	48 8d 54 24 10       	lea    0x10(%rsp),%rdx
    ca98:	31 ff                	xor    %edi,%edi
    ca9a:	be 03 00 00 00       	mov    $0x3,%esi
    ca9f:	e8 4c d3 ff ff       	call   9df0 <fwp_data>
    caa4:	48 89 c1             	mov    %rax,%rcx
    caa7:	48 2b 0d 02 67 00 00 	sub    0x6702(%rip),%rcx        # 131b0 <fwp_gc+0x1030>
    caae:	48 8b 15 23 67 00 00 	mov    0x6723(%rip),%rdx        # 131d8 <fwp_gc+0x1058>
    cab5:	48 c1 e2 10          	shl    $0x10,%rdx
    cab9:	48 39 d1             	cmp    %rdx,%rcx
    cabc:	73 76                	jae    cb34 <f55+0x294>
    cabe:	48 8b 15 33 67 00 00 	mov    0x6733(%rip),%rdx        # 131f8 <fwp_gc+0x1078>
    cac5:	48 89 ce             	mov    %rcx,%rsi
    cac8:	48 c1 ee 10          	shr    $0x10,%rsi
    cacc:	48 69 f6 28 12 00 00 	imul   $0x1228,%rsi,%rsi
    cad3:	0f b6 3c 32          	movzbl (%rdx,%rsi,1),%edi
    cad7:	48 81 e1 ff ff 00 00 	and    $0xffff,%rcx
    cade:	75 1d                	jne    cafd <f55+0x25d>
    cae0:	40 80 ff 02          	cmp    $0x2,%dil
    cae4:	75 17                	jne    cafd <f55+0x25d>
    cae6:	4c 8d 34 32          	lea    (%rdx,%rsi,1),%r14
    caea:	49 81 c6 28 02 00 00 	add    $0x228,%r14
    caf1:	41 80 3e ff          	cmpb   $0xff,(%r14)
    caf5:	74 2d                	je     cb24 <f55+0x284>
    caf7:	41 c6 06 01          	movb   $0x1,(%r14)
    cafb:	eb 37                	jmp    cb34 <f55+0x294>
    cafd:	40 80 ff 01          	cmp    $0x1,%dil
    cb01:	75 31                	jne    cb34 <f55+0x294>
    cb03:	48 8d 3c 32          	lea    (%rdx,%rsi,1),%rdi
    cb07:	8b 54 32 20          	mov    0x20(%rdx,%rsi,1),%edx
    cb0b:	48 0f af ca          	imul   %rdx,%rcx
    cb0f:	48 c1 e9 20          	shr    $0x20,%rcx
    cb13:	4c 8d 34 39          	lea    (%rcx,%rdi,1),%r14
    cb17:	49 81 c6 28 02 00 00 	add    $0x228,%r14
    cb1e:	41 80 3e ff          	cmpb   $0xff,(%r14)
    cb22:	75 d3                	jne    caf7 <f55+0x257>
    cb24:	4c 89 f7             	mov    %r14,%rdi
    cb27:	49 89 c7             	mov    %rax,%r15
    cb2a:	e8 f1 97 ff ff       	call   6320 <fwp_rc_forget_slot>
    cb2f:	4c 89 f8             	mov    %r15,%rax
    cb32:	eb c3                	jmp    caf7 <f55+0x257>
    cb34:	48 89 44 24 08       	mov    %rax,0x8(%rsp)
    cb39:	48 8d 54 24 08       	lea    0x8(%rsp),%rdx
    cb3e:	31 ff                	xor    %edi,%edi
    cb40:	be 01 00 00 00       	mov    $0x1,%esi
    cb45:	e8 a6 d2 ff ff       	call   9df0 <fwp_data>
    cb4a:	49 89 c6             	mov    %rax,%r14
    cb4d:	48 2b 05 5c 66 00 00 	sub    0x665c(%rip),%rax        # 131b0 <fwp_gc+0x1030>
    cb54:	48 8b 0d 7d 66 00 00 	mov    0x667d(%rip),%rcx        # 131d8 <fwp_gc+0x1058>
    cb5b:	48 c1 e1 10          	shl    $0x10,%rcx
    cb5f:	48 39 c8             	cmp    %rcx,%rax
    cb62:	73 6f                	jae    cbd3 <f55+0x333>
    cb64:	48 8b 0d 8d 66 00 00 	mov    0x668d(%rip),%rcx        # 131f8 <fwp_gc+0x1078>
    cb6b:	48 89 c2             	mov    %rax,%rdx
    cb6e:	48 c1 ea 10          	shr    $0x10,%rdx
    cb72:	48 69 d2 28 12 00 00 	imul   $0x1228,%rdx,%rdx
    cb79:	0f b6 34 11          	movzbl (%rcx,%rdx,1),%esi
    cb7d:	48 25 ff ff 00 00    	and    $0xffff,%rax
    cb83:	75 1d                	jne    cba2 <f55+0x302>
    cb85:	40 80 fe 02          	cmp    $0x2,%sil
    cb89:	75 17                	jne    cba2 <f55+0x302>
    cb8b:	4c 8d 3c 11          	lea    (%rcx,%rdx,1),%r15
    cb8f:	49 81 c7 28 02 00 00 	add    $0x228,%r15
    cb96:	41 80 3f ff          	cmpb   $0xff,(%r15)
    cb9a:	74 2d                	je     cbc9 <f55+0x329>
    cb9c:	41 c6 07 01          	movb   $0x1,(%r15)
    cba0:	eb 31                	jmp    cbd3 <f55+0x333>
    cba2:	40 80 fe 01          	cmp    $0x1,%sil
    cba6:	75 2b                	jne    cbd3 <f55+0x333>
    cba8:	48 8d 34 11          	lea    (%rcx,%rdx,1),%rsi
    cbac:	8b 4c 11 20          	mov    0x20(%rcx,%rdx,1),%ecx
    cbb0:	48 0f af c1          	imul   %rcx,%rax
    cbb4:	48 c1 e8 20          	shr    $0x20,%rax
    cbb8:	4c 8d 3c 30          	lea    (%rax,%rsi,1),%r15
    cbbc:	49 81 c7 28 02 00 00 	add    $0x228,%r15
    cbc3:	41 80 3f ff          	cmpb   $0xff,(%r15)
    cbc7:	75 d3                	jne    cb9c <f55+0x2fc>
    cbc9:	4c 89 ff             	mov    %r15,%rdi
    cbcc:	e8 4f 97 ff ff       	call   6320 <fwp_rc_forget_slot>
    cbd1:	eb c9                	jmp    cb9c <f55+0x2fc>
    cbd3:	48 89 df             	mov    %rbx,%rdi
    cbd6:	e8 85 00 00 00       	call   cc60 <fwp_drop10>
    cbdb:	4c 89 f0             	mov    %r14,%rax
    cbde:	48 83 c4 78          	add    $0x78,%rsp
    cbe2:	5b                   	pop    %rbx
    cbe3:	41 5c                	pop    %r12
    cbe5:	41 5e                	pop    %r14
    cbe7:	41 5f                	pop    %r15
    cbe9:	c3                   	ret
    cbea:	e8 11 aa ff ff       	call   7600 <fwp_rc_wide_dup>
    cbef:	e9 3d fd ff ff       	jmp    c931 <f55+0x91>
    cbf4:	e8 07 aa ff ff       	call   7600 <fwp_rc_wide_dup>
    cbf9:	e9 72 fe ff ff       	jmp    ca70 <f55+0x1d0>
    cbfe:	48 8d 15 86 2a 00 00 	lea    0x2a86(%rip),%rdx        # f68b <fwp_segv.msg+0x44b>
    cc05:	48 8d 0d 97 29 00 00 	lea    0x2997(%rip),%rcx        # f5a3 <fwp_segv.msg+0x363>
    cc0c:	eb 0e                	jmp    cc1c <f55+0x37c>
    cc0e:	48 8d 15 76 2a 00 00 	lea    0x2a76(%rip),%rdx        # f68b <fwp_segv.msg+0x44b>
    cc15:	48 8d 0d 89 2a 00 00 	lea    0x2a89(%rip),%rcx        # f6a5 <fwp_segv.msg+0x465>
    cc1c:	48 8d 5c 24 10       	lea    0x10(%rsp),%rbx
    cc21:	be 60 00 00 00       	mov    $0x60,%esi
    cc26:	48 89 df             	mov    %rbx,%rdi
    cc29:	31 c0                	xor    %eax,%eax
    cc2b:	e8 e0 54 ff ff       	call   2110 <snprintf@plt>
    cc30:	e8 bb 96 ff ff       	call   62f0 <fwp_flush>
    cc35:	48 8b 05 a4 53 00 00 	mov    0x53a4(%rip),%rax        # 11fe0 <stderr@GLIBC_2.2.5>
    cc3c:	48 8b 38             	mov    (%rax),%rdi
    cc3f:	48 8d 35 e7 27 00 00 	lea    0x27e7(%rip),%rsi        # f42d <fwp_segv.msg+0x1ed>
    cc46:	48 89 da             	mov    %rbx,%rdx
    cc49:	31 c0                	xor    %eax,%eax
    cc4b:	e8 60 55 ff ff       	call   21b0 <fprintf@plt>
    cc50:	bf 65 00 00 00       	mov    $0x65,%edi
    cc55:	e8 36 56 ff ff       	call   2290 <exit@plt>
    cc5a:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)

000000000000cc60 <fwp_drop10>:
    cc60:	48 89 f8             	mov    %rdi,%rax
    cc63:	48 2b 05 46 65 00 00 	sub    0x6546(%rip),%rax        # 131b0 <fwp_gc+0x1030>
    cc6a:	48 8b 0d 67 65 00 00 	mov    0x6567(%rip),%rcx        # 131d8 <fwp_gc+0x1058>
    cc71:	48 c1 e1 10          	shl    $0x10,%rcx
    cc75:	48 39 c8             	cmp    %rcx,%rax
    cc78:	0f 83 83 00 00 00    	jae    cd01 <fwp_drop10+0xa1>
    cc7e:	48 8b 0d 73 65 00 00 	mov    0x6573(%rip),%rcx        # 131f8 <fwp_gc+0x1078>
    cc85:	48 89 c2             	mov    %rax,%rdx
    cc88:	48 c1 ea 10          	shr    $0x10,%rdx
    cc8c:	48 69 d2 28 12 00 00 	imul   $0x1228,%rdx,%rdx
    cc93:	0f b6 34 11          	movzbl (%rcx,%rdx,1),%esi
    cc97:	48 25 ff ff 00 00    	and    $0xffff,%rax
    cc9d:	75 12                	jne    ccb1 <fwp_drop10+0x51>
    cc9f:	40 80 fe 02          	cmp    $0x2,%sil
    cca3:	75 0c                	jne    ccb1 <fwp_drop10+0x51>
    cca5:	48 8d 04 11          	lea    (%rcx,%rdx,1),%rax
    cca9:	48 05 28 02 00 00    	add    $0x228,%rax
    ccaf:	eb 1f                	jmp    ccd0 <fwp_drop10+0x70>
    ccb1:	40 80 fe 01          	cmp    $0x1,%sil
    ccb5:	75 4a                	jne    cd01 <fwp_drop10+0xa1>
    ccb7:	48 8d 34 11          	lea    (%rcx,%rdx,1),%rsi
    ccbb:	8b 4c 11 20          	mov    0x20(%rcx,%rdx,1),%ecx
    ccbf:	48 0f af c1          	imul   %rcx,%rax
    ccc3:	48 c1 e8 20          	shr    $0x20,%rax
    ccc7:	48 01 f0             	add    %rsi,%rax
    ccca:	48 05 28 02 00 00    	add    $0x228,%rax
    ccd0:	0f b6 08             	movzbl (%rax),%ecx
    ccd3:	85 c9                	test   %ecx,%ecx
    ccd5:	74 2a                	je     cd01 <fwp_drop10+0xa1>
    ccd7:	83 f9 01             	cmp    $0x1,%ecx
    ccda:	75 19                	jne    ccf5 <fwp_drop10+0x95>
    ccdc:	53                   	push   %rbx
    ccdd:	48 8b 47 10          	mov    0x10(%rdi),%rax
    cce1:	48 89 fb             	mov    %rdi,%rbx
    cce4:	48 89 c7             	mov    %rax,%rdi
    cce7:	e8 24 00 00 00       	call   cd10 <fwp_drop9>
    ccec:	48 89 df             	mov    %rbx,%rdi
    ccef:	5b                   	pop    %rbx
    ccf0:	e9 1b dc ff ff       	jmp    a910 <fwp_rc_free_obj>
    ccf5:	81 f9 ff 00 00 00    	cmp    $0xff,%ecx
    ccfb:	74 05                	je     cd02 <fwp_drop10+0xa2>
    ccfd:	fe c9                	dec    %cl
    ccff:	88 08                	mov    %cl,(%rax)
    cd01:	c3                   	ret
    cd02:	48 89 c7             	mov    %rax,%rdi
    cd05:	e9 26 d9 ff ff       	jmp    a630 <fwp_rc_wide_drop>
    cd0a:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)

000000000000cd10 <fwp_drop9>:
    cd10:	53                   	push   %rbx
    cd11:	48 89 f8             	mov    %rdi,%rax
    cd14:	48 2b 05 95 64 00 00 	sub    0x6495(%rip),%rax        # 131b0 <fwp_gc+0x1030>
    cd1b:	48 8b 0d b6 64 00 00 	mov    0x64b6(%rip),%rcx        # 131d8 <fwp_gc+0x1058>
    cd22:	48 c1 e1 10          	shl    $0x10,%rcx
    cd26:	48 39 c8             	cmp    %rcx,%rax
    cd29:	0f 83 9c 00 00 00    	jae    cdcb <fwp_drop9+0xbb>
    cd2f:	48 8b 0d c2 64 00 00 	mov    0x64c2(%rip),%rcx        # 131f8 <fwp_gc+0x1078>
    cd36:	48 89 c2             	mov    %rax,%rdx
    cd39:	48 c1 ea 10          	shr    $0x10,%rdx
    cd3d:	48 69 d2 28 12 00 00 	imul   $0x1228,%rdx,%rdx
    cd44:	0f b6 34 11          	movzbl (%rcx,%rdx,1),%esi
    cd48:	48 25 ff ff 00 00    	and    $0xffff,%rax
    cd4e:	75 20                	jne    cd70 <fwp_drop9+0x60>
    cd50:	40 80 fe 02          	cmp    $0x2,%sil
    cd54:	75 1a                	jne    cd70 <fwp_drop9+0x60>
    cd56:	48 8d 04 11          	lea    (%rcx,%rdx,1),%rax
    cd5a:	48 05 28 02 00 00    	add    $0x228,%rax
    cd60:	eb 2d                	jmp    cd8f <fwp_drop9+0x7f>
    cd62:	66 66 66 66 66 2e 0f 	data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    cd69:	1f 84 00 00 00 00 00 
    cd70:	40 80 fe 01          	cmp    $0x1,%sil
    cd74:	75 55                	jne    cdcb <fwp_drop9+0xbb>
    cd76:	48 8d 34 11          	lea    (%rcx,%rdx,1),%rsi
    cd7a:	8b 4c 11 20          	mov    0x20(%rcx,%rdx,1),%ecx
    cd7e:	48 0f af c1          	imul   %rcx,%rax
    cd82:	48 c1 e8 20          	shr    $0x20,%rax
    cd86:	48 01 f0             	add    %rsi,%rax
    cd89:	48 05 28 02 00 00    	add    $0x228,%rax
    cd8f:	0f b6 08             	movzbl (%rax),%ecx
    cd92:	85 c9                	test   %ecx,%ecx
    cd94:	74 35                	je     cdcb <fwp_drop9+0xbb>
    cd96:	83 f9 01             	cmp    $0x1,%ecx
    cd99:	75 32                	jne    cdcd <fwp_drop9+0xbd>
    cd9b:	48 83 3f 00          	cmpq   $0x0,(%rdi)
    cd9f:	79 3a                	jns    cddb <fwp_drop9+0xcb>
    cda1:	48 8b 5f 08          	mov    0x8(%rdi),%rbx
    cda5:	e8 76 d7 ff ff       	call   a520 <fwp_rc_free_arr>
    cdaa:	48 89 d8             	mov    %rbx,%rax
    cdad:	48 2b 05 fc 63 00 00 	sub    0x63fc(%rip),%rax        # 131b0 <fwp_gc+0x1030>
    cdb4:	48 8b 0d 1d 64 00 00 	mov    0x641d(%rip),%rcx        # 131d8 <fwp_gc+0x1058>
    cdbb:	48 c1 e1 10          	shl    $0x10,%rcx
    cdbf:	48 89 df             	mov    %rbx,%rdi
    cdc2:	48 39 c8             	cmp    %rcx,%rax
    cdc5:	0f 82 64 ff ff ff    	jb     cd2f <fwp_drop9+0x1f>
    cdcb:	5b                   	pop    %rbx
    cdcc:	c3                   	ret
    cdcd:	81 f9 ff 00 00 00    	cmp    $0xff,%ecx
    cdd3:	74 0c                	je     cde1 <fwp_drop9+0xd1>
    cdd5:	fe c9                	dec    %cl
    cdd7:	88 08                	mov    %cl,(%rax)
    cdd9:	5b                   	pop    %rbx
    cdda:	c3                   	ret
    cddb:	5b                   	pop    %rbx
    cddc:	e9 3f d7 ff ff       	jmp    a520 <fwp_rc_free_arr>
    cde1:	48 89 c7             	mov    %rax,%rdi
    cde4:	5b                   	pop    %rbx
    cde5:	e9 46 d8 ff ff       	jmp    a630 <fwp_rc_wide_drop>
    cdea:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)

000000000000cdf0 <fwp_owned_entry55>:
    cdf0:	48 8b 3f             	mov    (%rdi),%rdi
    cdf3:	e9 a8 fa ff ff       	jmp    c8a0 <f55>
    cdf8:	0f 1f 84 00 00 00 00 	nopl   0x0(%rax,%rax,1)
    cdff:	00 

000000000000ce00 <fwp_caps55>:
    ce00:	53                   	push   %rbx
    ce01:	83 7f 04 00          	cmpl   $0x0,0x4(%rdi)
    ce05:	74 56                	je     ce5d <fwp_caps55+0x5d>
    ce07:	48 89 fb             	mov    %rdi,%rbx
    ce0a:	48 8b 7f 08          	mov    0x8(%rdi),%rdi
    ce0e:	85 f6                	test   %esi,%esi
    ce10:	74 51                	je     ce63 <fwp_caps55+0x63>
    ce12:	48 2b 3d 97 63 00 00 	sub    0x6397(%rip),%rdi        # 131b0 <fwp_gc+0x1030>
    ce19:	48 8b 05 b8 63 00 00 	mov    0x63b8(%rip),%rax        # 131d8 <fwp_gc+0x1058>
    ce20:	48 c1 e0 10          	shl    $0x10,%rax
    ce24:	48 39 c7             	cmp    %rax,%rdi
    ce27:	73 38                	jae    ce61 <fwp_caps55+0x61>
    ce29:	48 8b 05 c8 63 00 00 	mov    0x63c8(%rip),%rax        # 131f8 <fwp_gc+0x1078>
    ce30:	48 89 f9             	mov    %rdi,%rcx
    ce33:	48 c1 e9 10          	shr    $0x10,%rcx
    ce37:	48 69 c9 28 12 00 00 	imul   $0x1228,%rcx,%rcx
    ce3e:	0f b6 14 08          	movzbl (%rax,%rcx,1),%edx
    ce42:	48 81 e7 ff ff 00 00 	and    $0xffff,%rdi
    ce49:	75 26                	jne    ce71 <fwp_caps55+0x71>
    ce4b:	80 fa 02             	cmp    $0x2,%dl
    ce4e:	75 21                	jne    ce71 <fwp_caps55+0x71>
    ce50:	48 8d 3c 08          	lea    (%rax,%rcx,1),%rdi
    ce54:	48 81 c7 28 02 00 00 	add    $0x228,%rdi
    ce5b:	eb 33                	jmp    ce90 <fwp_caps55+0x90>
    ce5d:	85 f6                	test   %esi,%esi
    ce5f:	74 0a                	je     ce6b <fwp_caps55+0x6b>
    ce61:	5b                   	pop    %rbx
    ce62:	c3                   	ret
    ce63:	e8 f8 fd ff ff       	call   cc60 <fwp_drop10>
    ce68:	48 89 df             	mov    %rbx,%rdi
    ce6b:	5b                   	pop    %rbx
    ce6c:	e9 9f da ff ff       	jmp    a910 <fwp_rc_free_obj>
    ce71:	80 fa 01             	cmp    $0x1,%dl
    ce74:	75 eb                	jne    ce61 <fwp_caps55+0x61>
    ce76:	48 8d 14 08          	lea    (%rax,%rcx,1),%rdx
    ce7a:	8b 44 08 20          	mov    0x20(%rax,%rcx,1),%eax
    ce7e:	48 0f af f8          	imul   %rax,%rdi
    ce82:	48 c1 ef 20          	shr    $0x20,%rdi
    ce86:	48 01 d7             	add    %rdx,%rdi
    ce89:	48 81 c7 28 02 00 00 	add    $0x228,%rdi
    ce90:	0f b6 07             	movzbl (%rdi),%eax
    ce93:	84 c0                	test   %al,%al
    ce95:	74 ca                	je     ce61 <fwp_caps55+0x61>
    ce97:	3c fe                	cmp    $0xfe,%al
    ce99:	73 06                	jae    cea1 <fwp_caps55+0xa1>
    ce9b:	fe c0                	inc    %al
    ce9d:	88 07                	mov    %al,(%rdi)
    ce9f:	5b                   	pop    %rbx
    cea0:	c3                   	ret
    cea1:	5b                   	pop    %rbx
    cea2:	e9 59 a7 ff ff       	jmp    7600 <fwp_rc_wide_dup>
    cea7:	66 0f 1f 84 00 00 00 	nopw   0x0(%rax,%rax,1)
    ceae:	00 00 

000000000000ceb0 <fwp_args55>:
    ceb0:	85 f6                	test   %esi,%esi
    ceb2:	0f 85 8a 00 00 00    	jne    cf42 <fwp_args55+0x92>
    ceb8:	85 d2                	test   %edx,%edx
    ceba:	0f 84 82 00 00 00    	je     cf42 <fwp_args55+0x92>
    cec0:	48 8b 07             	mov    (%rdi),%rax
    cec3:	48 2b 05 e6 62 00 00 	sub    0x62e6(%rip),%rax        # 131b0 <fwp_gc+0x1030>
    ceca:	48 8b 0d 07 63 00 00 	mov    0x6307(%rip),%rcx        # 131d8 <fwp_gc+0x1058>
    ced1:	48 c1 e1 10          	shl    $0x10,%rcx
    ced5:	48 39 c8             	cmp    %rcx,%rax
    ced8:	73 68                	jae    cf42 <fwp_args55+0x92>
    ceda:	48 8b 0d 17 63 00 00 	mov    0x6317(%rip),%rcx        # 131f8 <fwp_gc+0x1078>
    cee1:	48 89 c2             	mov    %rax,%rdx
    cee4:	48 c1 ea 10          	shr    $0x10,%rdx
    cee8:	48 69 d2 28 12 00 00 	imul   $0x1228,%rdx,%rdx
    ceef:	0f b6 34 11          	movzbl (%rcx,%rdx,1),%esi
    cef3:	48 25 ff ff 00 00    	and    $0xffff,%rax
    cef9:	75 13                	jne    cf0e <fwp_args55+0x5e>
    cefb:	40 80 fe 02          	cmp    $0x2,%sil
    ceff:	75 0d                	jne    cf0e <fwp_args55+0x5e>
    cf01:	48 8d 3c 11          	lea    (%rcx,%rdx,1),%rdi
    cf05:	48 81 c7 28 02 00 00 	add    $0x228,%rdi
    cf0c:	eb 21                	jmp    cf2f <fwp_args55+0x7f>
    cf0e:	40 80 fe 01          	cmp    $0x1,%sil
    cf12:	75 2e                	jne    cf42 <fwp_args55+0x92>
    cf14:	48 8d 34 11          	lea    (%rcx,%rdx,1),%rsi
    cf18:	8b 4c 11 20          	mov    0x20(%rcx,%rdx,1),%ecx
    cf1c:	48 0f af c1          	imul   %rcx,%rax
    cf20:	48 c1 e8 20          	shr    $0x20,%rax
    cf24:	48 8d 3c 30          	lea    (%rax,%rsi,1),%rdi
    cf28:	48 81 c7 28 02 00 00 	add    $0x228,%rdi
    cf2f:	0f b6 07             	movzbl (%rdi),%eax
    cf32:	84 c0                	test   %al,%al
    cf34:	74 0c                	je     cf42 <fwp_args55+0x92>
    cf36:	3c fe                	cmp    $0xfe,%al
    cf38:	0f 83 c2 a6 ff ff    	jae    7600 <fwp_rc_wide_dup>
    cf3e:	fe c0                	inc    %al
    cf40:	88 07                	mov    %al,(%rdi)
    cf42:	c3                   	ret
    cf43:	66 66 66 66 2e 0f 1f 	data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    cf4a:	84 00 00 00 00 00 

000000000000cf50 <fwp_arg_drop55>:
    cf50:	85 f6                	test   %esi,%esi
    cf52:	75 0c                	jne    cf60 <fwp_arg_drop55+0x10>
    cf54:	85 d2                	test   %edx,%edx
    cf56:	74 08                	je     cf60 <fwp_arg_drop55+0x10>
    cf58:	48 8b 3f             	mov    (%rdi),%rdi
    cf5b:	e9 00 fd ff ff       	jmp    cc60 <fwp_drop10>
    cf60:	c3                   	ret
    cf61:	66 66 66 66 66 66 2e 	data16 data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    cf68:	0f 1f 84 00 00 00 00 
    cf6f:	00 

000000000000cf70 <f57>:
    cf70:	41 57                	push   %r15
    cf72:	41 56                	push   %r14
    cf74:	41 55                	push   %r13
    cf76:	41 54                	push   %r12
    cf78:	53                   	push   %rbx
    cf79:	48 83 ec 70          	sub    $0x70,%rsp
    cf7d:	48 89 fb             	mov    %rdi,%rbx
    cf80:	48 8b 47 10          	mov    0x10(%rdi),%rax
    cf84:	48 2b 05 25 62 00 00 	sub    0x6225(%rip),%rax        # 131b0 <fwp_gc+0x1030>
    cf8b:	48 8b 0d 46 62 00 00 	mov    0x6246(%rip),%rcx        # 131d8 <fwp_gc+0x1058>
    cf92:	48 c1 e1 10          	shl    $0x10,%rcx
    cf96:	48 39 c8             	cmp    %rcx,%rax
    cf99:	73 68                	jae    d003 <f57+0x93>
    cf9b:	48 8b 0d 56 62 00 00 	mov    0x6256(%rip),%rcx        # 131f8 <fwp_gc+0x1078>
    cfa2:	48 89 c2             	mov    %rax,%rdx
    cfa5:	48 c1 ea 10          	shr    $0x10,%rdx
    cfa9:	48 69 d2 28 12 00 00 	imul   $0x1228,%rdx,%rdx
    cfb0:	0f b6 34 11          	movzbl (%rcx,%rdx,1),%esi
    cfb4:	48 25 ff ff 00 00    	and    $0xffff,%rax
    cfba:	75 13                	jne    cfcf <f57+0x5f>
    cfbc:	40 80 fe 02          	cmp    $0x2,%sil
    cfc0:	75 0d                	jne    cfcf <f57+0x5f>
    cfc2:	48 8d 3c 11          	lea    (%rcx,%rdx,1),%rdi
    cfc6:	48 81 c7 28 02 00 00 	add    $0x228,%rdi
    cfcd:	eb 21                	jmp    cff0 <f57+0x80>
    cfcf:	40 80 fe 01          	cmp    $0x1,%sil
    cfd3:	75 2e                	jne    d003 <f57+0x93>
    cfd5:	48 8d 34 11          	lea    (%rcx,%rdx,1),%rsi
    cfd9:	8b 4c 11 20          	mov    0x20(%rcx,%rdx,1),%ecx
    cfdd:	48 0f af c1          	imul   %rcx,%rax
    cfe1:	48 c1 e8 20          	shr    $0x20,%rax
    cfe5:	48 8d 3c 30          	lea    (%rax,%rsi,1),%rdi
    cfe9:	48 81 c7 28 02 00 00 	add    $0x228,%rdi
    cff0:	0f b6 07             	movzbl (%rdi),%eax
    cff3:	84 c0                	test   %al,%al
    cff5:	74 0c                	je     d003 <f57+0x93>
    cff7:	3c fe                	cmp    $0xfe,%al
    cff9:	0f 83 cb 02 00 00    	jae    d2ca <f57+0x35a>
    cfff:	fe c0                	inc    %al
    d001:	88 07                	mov    %al,(%rdi)
    d003:	4c 8b 7b 08          	mov    0x8(%rbx),%r15
    d007:	4c 8b 73 10          	mov    0x10(%rbx),%r14
    d00b:	4c 0f be 63 18       	movsbq 0x18(%rbx),%r12
    d010:	4d 85 ff             	test   %r15,%r15
    d013:	78 20                	js     d035 <f57+0xc5>
    d015:	49 8b 06             	mov    (%r14),%rax
    d018:	48 b9 ff ff ff ff ff 	movabs $0x7fffffffffffffff,%rcx
    d01f:	ff ff 7f 
    d022:	48 21 c1             	and    %rax,%rcx
    d025:	4c 39 f9             	cmp    %r15,%rcx
    d028:	76 0b                	jbe    d035 <f57+0xc5>
    d02a:	48 85 c0             	test   %rax,%rax
    d02d:	78 79                	js     d0a8 <f57+0x138>
    d02f:	49 8d 46 08          	lea    0x8(%r14),%rax
    d033:	eb 77                	jmp    d0ac <f57+0x13c>
    d035:	4c 89 f7             	mov    %r14,%rdi
    d038:	e8 d3 fc ff ff       	call   cd10 <fwp_drop9>
    d03d:	4c 89 64 24 10       	mov    %r12,0x10(%rsp)
    d042:	48 8d 54 24 10       	lea    0x10(%rsp),%rdx
    d047:	bf 01 00 00 00       	mov    $0x1,%edi
    d04c:	be 01 00 00 00       	mov    $0x1,%esi
    d051:	e8 9a cd ff ff       	call   9df0 <fwp_data>
    d056:	49 89 c6             	mov    %rax,%r14
    d059:	48 2b 05 50 61 00 00 	sub    0x6150(%rip),%rax        # 131b0 <fwp_gc+0x1030>
    d060:	48 8b 0d 71 61 00 00 	mov    0x6171(%rip),%rcx        # 131d8 <fwp_gc+0x1058>
    d067:	48 c1 e1 10          	shl    $0x10,%rcx
    d06b:	48 39 c8             	cmp    %rcx,%rax
    d06e:	0f 83 3d 02 00 00    	jae    d2b1 <f57+0x341>
    d074:	48 8b 0d 7d 61 00 00 	mov    0x617d(%rip),%rcx        # 131f8 <fwp_gc+0x1078>
    d07b:	48 89 c2             	mov    %rax,%rdx
    d07e:	48 c1 ea 10          	shr    $0x10,%rdx
    d082:	48 69 d2 28 12 00 00 	imul   $0x1228,%rdx,%rdx
    d089:	0f b6 34 11          	movzbl (%rcx,%rdx,1),%esi
    d08d:	48 25 ff ff 00 00    	and    $0xffff,%rax
    d093:	0f 85 e7 01 00 00    	jne    d280 <f57+0x310>
    d099:	40 80 fe 02          	cmp    $0x2,%sil
    d09d:	0f 84 c6 01 00 00    	je     d269 <f57+0x2f9>
    d0a3:	e9 d8 01 00 00       	jmp    d280 <f57+0x310>
    d0a8:	49 8b 46 10          	mov    0x10(%r14),%rax
    d0ac:	4e 0f be 2c 38       	movsbq (%rax,%r15,1),%r13
    d0b1:	49 8d 45 81          	lea    -0x7f(%r13),%rax
    d0b5:	48 3d ff fe ff ff    	cmp    $0xfffffffffffffeff,%rax
    d0bb:	0f 86 1d 02 00 00    	jbe    d2de <f57+0x36e>
    d0c1:	4c 89 f0             	mov    %r14,%rax
    d0c4:	48 2b 05 e5 60 00 00 	sub    0x60e5(%rip),%rax        # 131b0 <fwp_gc+0x1030>
    d0cb:	48 8b 0d 06 61 00 00 	mov    0x6106(%rip),%rcx        # 131d8 <fwp_gc+0x1058>
    d0d2:	48 c1 e1 10          	shl    $0x10,%rcx
    d0d6:	48 39 c8             	cmp    %rcx,%rax
    d0d9:	73 68                	jae    d143 <f57+0x1d3>
    d0db:	48 8b 0d 16 61 00 00 	mov    0x6116(%rip),%rcx        # 131f8 <fwp_gc+0x1078>
    d0e2:	48 89 c2             	mov    %rax,%rdx
    d0e5:	48 c1 ea 10          	shr    $0x10,%rdx
    d0e9:	48 69 d2 28 12 00 00 	imul   $0x1228,%rdx,%rdx
    d0f0:	0f b6 34 11          	movzbl (%rcx,%rdx,1),%esi
    d0f4:	48 25 ff ff 00 00    	and    $0xffff,%rax
    d0fa:	75 13                	jne    d10f <f57+0x19f>
    d0fc:	40 80 fe 02          	cmp    $0x2,%sil
    d100:	75 0d                	jne    d10f <f57+0x19f>
    d102:	48 8d 3c 11          	lea    (%rcx,%rdx,1),%rdi
    d106:	48 81 c7 28 02 00 00 	add    $0x228,%rdi
    d10d:	eb 21                	jmp    d130 <f57+0x1c0>
    d10f:	40 80 fe 01          	cmp    $0x1,%sil
    d113:	75 2e                	jne    d143 <f57+0x1d3>
    d115:	48 8d 34 11          	lea    (%rcx,%rdx,1),%rsi
    d119:	8b 4c 11 20          	mov    0x20(%rcx,%rdx,1),%ecx
    d11d:	48 0f af c1          	imul   %rcx,%rax
    d121:	48 c1 e8 20          	shr    $0x20,%rax
    d125:	48 8d 3c 30          	lea    (%rax,%rsi,1),%rdi
    d129:	48 81 c7 28 02 00 00 	add    $0x228,%rdi
    d130:	0f b6 07             	movzbl (%rdi),%eax
    d133:	84 c0                	test   %al,%al
    d135:	74 0c                	je     d143 <f57+0x1d3>
    d137:	3c fe                	cmp    $0xfe,%al
    d139:	0f 83 95 01 00 00    	jae    d2d4 <f57+0x364>
    d13f:	fe c0                	inc    %al
    d141:	88 07                	mov    %al,(%rdi)
    d143:	4c 89 f7             	mov    %r14,%rdi
    d146:	e8 c5 fb ff ff       	call   cd10 <fwp_drop9>
    d14b:	4b 8d 04 2c          	lea    (%r12,%r13,1),%rax
    d14f:	48 ff c0             	inc    %rax
    d152:	48 0f be c8          	movsbq %al,%rcx
    d156:	48 39 c1             	cmp    %rax,%rcx
    d159:	0f 85 7f 01 00 00    	jne    d2de <f57+0x36e>
    d15f:	49 ff c7             	inc    %r15
    d162:	4c 89 7c 24 10       	mov    %r15,0x10(%rsp)
    d167:	4c 89 74 24 18       	mov    %r14,0x18(%rsp)
    d16c:	48 89 44 24 20       	mov    %rax,0x20(%rsp)
    d171:	48 8d 54 24 10       	lea    0x10(%rsp),%rdx
    d176:	31 ff                	xor    %edi,%edi
    d178:	be 03 00 00 00       	mov    $0x3,%esi
    d17d:	e8 6e cc ff ff       	call   9df0 <fwp_data>
    d182:	48 89 c1             	mov    %rax,%rcx
    d185:	48 2b 0d 24 60 00 00 	sub    0x6024(%rip),%rcx        # 131b0 <fwp_gc+0x1030>
    d18c:	48 8b 15 45 60 00 00 	mov    0x6045(%rip),%rdx        # 131d8 <fwp_gc+0x1058>
    d193:	48 c1 e2 10          	shl    $0x10,%rdx
    d197:	48 39 d1             	cmp    %rdx,%rcx
    d19a:	73 76                	jae    d212 <f57+0x2a2>
    d19c:	48 8b 15 55 60 00 00 	mov    0x6055(%rip),%rdx        # 131f8 <fwp_gc+0x1078>
    d1a3:	48 89 ce             	mov    %rcx,%rsi
    d1a6:	48 c1 ee 10          	shr    $0x10,%rsi
    d1aa:	48 69 f6 28 12 00 00 	imul   $0x1228,%rsi,%rsi
    d1b1:	0f b6 3c 32          	movzbl (%rdx,%rsi,1),%edi
    d1b5:	48 81 e1 ff ff 00 00 	and    $0xffff,%rcx
    d1bc:	75 1d                	jne    d1db <f57+0x26b>
    d1be:	40 80 ff 02          	cmp    $0x2,%dil
    d1c2:	75 17                	jne    d1db <f57+0x26b>
    d1c4:	4c 8d 34 32          	lea    (%rdx,%rsi,1),%r14
    d1c8:	49 81 c6 28 02 00 00 	add    $0x228,%r14
    d1cf:	41 80 3e ff          	cmpb   $0xff,(%r14)
    d1d3:	74 2d                	je     d202 <f57+0x292>
    d1d5:	41 c6 06 01          	movb   $0x1,(%r14)
    d1d9:	eb 37                	jmp    d212 <f57+0x2a2>
    d1db:	40 80 ff 01          	cmp    $0x1,%dil
    d1df:	75 31                	jne    d212 <f57+0x2a2>
    d1e1:	48 8d 3c 32          	lea    (%rdx,%rsi,1),%rdi
    d1e5:	8b 54 32 20          	mov    0x20(%rdx,%rsi,1),%edx
    d1e9:	48 0f af ca          	imul   %rdx,%rcx
    d1ed:	48 c1 e9 20          	shr    $0x20,%rcx
    d1f1:	4c 8d 34 39          	lea    (%rcx,%rdi,1),%r14
    d1f5:	49 81 c6 28 02 00 00 	add    $0x228,%r14
    d1fc:	41 80 3e ff          	cmpb   $0xff,(%r14)
    d200:	75 d3                	jne    d1d5 <f57+0x265>
    d202:	4c 89 f7             	mov    %r14,%rdi
    d205:	49 89 c7             	mov    %rax,%r15
    d208:	e8 13 91 ff ff       	call   6320 <fwp_rc_forget_slot>
    d20d:	4c 89 f8             	mov    %r15,%rax
    d210:	eb c3                	jmp    d1d5 <f57+0x265>
    d212:	48 89 44 24 08       	mov    %rax,0x8(%rsp)
    d217:	48 8d 54 24 08       	lea    0x8(%rsp),%rdx
    d21c:	31 ff                	xor    %edi,%edi
    d21e:	be 01 00 00 00       	mov    $0x1,%esi
    d223:	e8 c8 cb ff ff       	call   9df0 <fwp_data>
    d228:	49 89 c6             	mov    %rax,%r14
    d22b:	48 2b 05 7e 5f 00 00 	sub    0x5f7e(%rip),%rax        # 131b0 <fwp_gc+0x1030>
    d232:	48 8b 0d 9f 5f 00 00 	mov    0x5f9f(%rip),%rcx        # 131d8 <fwp_gc+0x1058>
    d239:	48 c1 e1 10          	shl    $0x10,%rcx
    d23d:	48 39 c8             	cmp    %rcx,%rax
    d240:	73 6f                	jae    d2b1 <f57+0x341>
    d242:	48 8b 0d af 5f 00 00 	mov    0x5faf(%rip),%rcx        # 131f8 <fwp_gc+0x1078>
    d249:	48 89 c2             	mov    %rax,%rdx
    d24c:	48 c1 ea 10          	shr    $0x10,%rdx
    d250:	48 69 d2 28 12 00 00 	imul   $0x1228,%rdx,%rdx
    d257:	0f b6 34 11          	movzbl (%rcx,%rdx,1),%esi
    d25b:	48 25 ff ff 00 00    	and    $0xffff,%rax
    d261:	75 1d                	jne    d280 <f57+0x310>
    d263:	40 80 fe 02          	cmp    $0x2,%sil
    d267:	75 17                	jne    d280 <f57+0x310>
    d269:	4c 8d 3c 11          	lea    (%rcx,%rdx,1),%r15
    d26d:	49 81 c7 28 02 00 00 	add    $0x228,%r15
    d274:	41 80 3f ff          	cmpb   $0xff,(%r15)
    d278:	74 2d                	je     d2a7 <f57+0x337>
    d27a:	41 c6 07 01          	movb   $0x1,(%r15)
    d27e:	eb 31                	jmp    d2b1 <f57+0x341>
    d280:	40 80 fe 01          	cmp    $0x1,%sil
    d284:	75 2b                	jne    d2b1 <f57+0x341>
    d286:	48 8d 34 11          	lea    (%rcx,%rdx,1),%rsi
    d28a:	8b 4c 11 20          	mov    0x20(%rcx,%rdx,1),%ecx
    d28e:	48 0f af c1          	imul   %rcx,%rax
    d292:	48 c1 e8 20          	shr    $0x20,%rax
    d296:	4c 8d 3c 30          	lea    (%rax,%rsi,1),%r15
    d29a:	49 81 c7 28 02 00 00 	add    $0x228,%r15
    d2a1:	41 80 3f ff          	cmpb   $0xff,(%r15)
    d2a5:	75 d3                	jne    d27a <f57+0x30a>
    d2a7:	4c 89 ff             	mov    %r15,%rdi
    d2aa:	e8 71 90 ff ff       	call   6320 <fwp_rc_forget_slot>
    d2af:	eb c9                	jmp    d27a <f57+0x30a>
    d2b1:	48 89 df             	mov    %rbx,%rdi
    d2b4:	e8 77 00 00 00       	call   d330 <fwp_drop11>
    d2b9:	4c 89 f0             	mov    %r14,%rax
    d2bc:	48 83 c4 70          	add    $0x70,%rsp
    d2c0:	5b                   	pop    %rbx
    d2c1:	41 5c                	pop    %r12
    d2c3:	41 5d                	pop    %r13
    d2c5:	41 5e                	pop    %r14
    d2c7:	41 5f                	pop    %r15
    d2c9:	c3                   	ret
    d2ca:	e8 31 a3 ff ff       	call   7600 <fwp_rc_wide_dup>
    d2cf:	e9 2f fd ff ff       	jmp    d003 <f57+0x93>
    d2d4:	e8 27 a3 ff ff       	call   7600 <fwp_rc_wide_dup>
    d2d9:	e9 65 fe ff ff       	jmp    d143 <f57+0x1d3>
    d2de:	48 8d 15 a6 23 00 00 	lea    0x23a6(%rip),%rdx        # f68b <fwp_segv.msg+0x44b>
    d2e5:	48 8d 0d b7 22 00 00 	lea    0x22b7(%rip),%rcx        # f5a3 <fwp_segv.msg+0x363>
    d2ec:	48 8d 5c 24 10       	lea    0x10(%rsp),%rbx
    d2f1:	be 60 00 00 00       	mov    $0x60,%esi
    d2f6:	48 89 df             	mov    %rbx,%rdi
    d2f9:	31 c0                	xor    %eax,%eax
    d2fb:	e8 10 4e ff ff       	call   2110 <snprintf@plt>
    d300:	e8 eb 8f ff ff       	call   62f0 <fwp_flush>
    d305:	48 8b 05 d4 4c 00 00 	mov    0x4cd4(%rip),%rax        # 11fe0 <stderr@GLIBC_2.2.5>
    d30c:	48 8b 38             	mov    (%rax),%rdi
    d30f:	48 8d 35 17 21 00 00 	lea    0x2117(%rip),%rsi        # f42d <fwp_segv.msg+0x1ed>
    d316:	48 89 da             	mov    %rbx,%rdx
    d319:	31 c0                	xor    %eax,%eax
    d31b:	e8 90 4e ff ff       	call   21b0 <fprintf@plt>
    d320:	bf 65 00 00 00       	mov    $0x65,%edi
    d325:	e8 66 4f ff ff       	call   2290 <exit@plt>
    d32a:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)

000000000000d330 <fwp_drop11>:
    d330:	48 89 f8             	mov    %rdi,%rax
    d333:	48 2b 05 76 5e 00 00 	sub    0x5e76(%rip),%rax        # 131b0 <fwp_gc+0x1030>
    d33a:	48 8b 0d 97 5e 00 00 	mov    0x5e97(%rip),%rcx        # 131d8 <fwp_gc+0x1058>
    d341:	48 c1 e1 10          	shl    $0x10,%rcx
    d345:	48 39 c8             	cmp    %rcx,%rax
    d348:	0f 83 83 00 00 00    	jae    d3d1 <fwp_drop11+0xa1>
    d34e:	48 8b 0d a3 5e 00 00 	mov    0x5ea3(%rip),%rcx        # 131f8 <fwp_gc+0x1078>
    d355:	48 89 c2             	mov    %rax,%rdx
    d358:	48 c1 ea 10          	shr    $0x10,%rdx
    d35c:	48 69 d2 28 12 00 00 	imul   $0x1228,%rdx,%rdx
    d363:	0f b6 34 11          	movzbl (%rcx,%rdx,1),%esi
    d367:	48 25 ff ff 00 00    	and    $0xffff,%rax
    d36d:	75 12                	jne    d381 <fwp_drop11+0x51>
    d36f:	40 80 fe 02          	cmp    $0x2,%sil
    d373:	75 0c                	jne    d381 <fwp_drop11+0x51>
    d375:	48 8d 04 11          	lea    (%rcx,%rdx,1),%rax
    d379:	48 05 28 02 00 00    	add    $0x228,%rax
    d37f:	eb 1f                	jmp    d3a0 <fwp_drop11+0x70>
    d381:	40 80 fe 01          	cmp    $0x1,%sil
    d385:	75 4a                	jne    d3d1 <fwp_drop11+0xa1>
    d387:	48 8d 34 11          	lea    (%rcx,%rdx,1),%rsi
    d38b:	8b 4c 11 20          	mov    0x20(%rcx,%rdx,1),%ecx
    d38f:	48 0f af c1          	imul   %rcx,%rax
    d393:	48 c1 e8 20          	shr    $0x20,%rax
    d397:	48 01 f0             	add    %rsi,%rax
    d39a:	48 05 28 02 00 00    	add    $0x228,%rax
    d3a0:	0f b6 08             	movzbl (%rax),%ecx
    d3a3:	85 c9                	test   %ecx,%ecx
    d3a5:	74 2a                	je     d3d1 <fwp_drop11+0xa1>
    d3a7:	83 f9 01             	cmp    $0x1,%ecx
    d3aa:	75 19                	jne    d3c5 <fwp_drop11+0x95>
    d3ac:	53                   	push   %rbx
    d3ad:	48 8b 47 10          	mov    0x10(%rdi),%rax
    d3b1:	48 89 fb             	mov    %rdi,%rbx
    d3b4:	48 89 c7             	mov    %rax,%rdi
    d3b7:	e8 54 f9 ff ff       	call   cd10 <fwp_drop9>
    d3bc:	48 89 df             	mov    %rbx,%rdi
    d3bf:	5b                   	pop    %rbx
    d3c0:	e9 4b d5 ff ff       	jmp    a910 <fwp_rc_free_obj>
    d3c5:	81 f9 ff 00 00 00    	cmp    $0xff,%ecx
    d3cb:	74 05                	je     d3d2 <fwp_drop11+0xa2>
    d3cd:	fe c9                	dec    %cl
    d3cf:	88 08                	mov    %cl,(%rax)
    d3d1:	c3                   	ret
    d3d2:	48 89 c7             	mov    %rax,%rdi
    d3d5:	e9 56 d2 ff ff       	jmp    a630 <fwp_rc_wide_drop>
    d3da:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)

000000000000d3e0 <fwp_owned_entry57>:
    d3e0:	48 8b 3f             	mov    (%rdi),%rdi
    d3e3:	e9 88 fb ff ff       	jmp    cf70 <f57>
    d3e8:	0f 1f 84 00 00 00 00 	nopl   0x0(%rax,%rax,1)
    d3ef:	00 

000000000000d3f0 <fwp_caps57>:
    d3f0:	53                   	push   %rbx
    d3f1:	83 7f 04 00          	cmpl   $0x0,0x4(%rdi)
    d3f5:	74 56                	je     d44d <fwp_caps57+0x5d>
    d3f7:	48 89 fb             	mov    %rdi,%rbx
    d3fa:	48 8b 7f 08          	mov    0x8(%rdi),%rdi
    d3fe:	85 f6                	test   %esi,%esi
    d400:	74 51                	je     d453 <fwp_caps57+0x63>
    d402:	48 2b 3d a7 5d 00 00 	sub    0x5da7(%rip),%rdi        # 131b0 <fwp_gc+0x1030>
    d409:	48 8b 05 c8 5d 00 00 	mov    0x5dc8(%rip),%rax        # 131d8 <fwp_gc+0x1058>
    d410:	48 c1 e0 10          	shl    $0x10,%rax
    d414:	48 39 c7             	cmp    %rax,%rdi
    d417:	73 38                	jae    d451 <fwp_caps57+0x61>
    d419:	48 8b 05 d8 5d 00 00 	mov    0x5dd8(%rip),%rax        # 131f8 <fwp_gc+0x1078>
    d420:	48 89 f9             	mov    %rdi,%rcx
    d423:	48 c1 e9 10          	shr    $0x10,%rcx
    d427:	48 69 c9 28 12 00 00 	imul   $0x1228,%rcx,%rcx
    d42e:	0f b6 14 08          	movzbl (%rax,%rcx,1),%edx
    d432:	48 81 e7 ff ff 00 00 	and    $0xffff,%rdi
    d439:	75 26                	jne    d461 <fwp_caps57+0x71>
    d43b:	80 fa 02             	cmp    $0x2,%dl
    d43e:	75 21                	jne    d461 <fwp_caps57+0x71>
    d440:	48 8d 3c 08          	lea    (%rax,%rcx,1),%rdi
    d444:	48 81 c7 28 02 00 00 	add    $0x228,%rdi
    d44b:	eb 33                	jmp    d480 <fwp_caps57+0x90>
    d44d:	85 f6                	test   %esi,%esi
    d44f:	74 0a                	je     d45b <fwp_caps57+0x6b>
    d451:	5b                   	pop    %rbx
    d452:	c3                   	ret
    d453:	e8 d8 fe ff ff       	call   d330 <fwp_drop11>
    d458:	48 89 df             	mov    %rbx,%rdi
    d45b:	5b                   	pop    %rbx
    d45c:	e9 af d4 ff ff       	jmp    a910 <fwp_rc_free_obj>
    d461:	80 fa 01             	cmp    $0x1,%dl
    d464:	75 eb                	jne    d451 <fwp_caps57+0x61>
    d466:	48 8d 14 08          	lea    (%rax,%rcx,1),%rdx
    d46a:	8b 44 08 20          	mov    0x20(%rax,%rcx,1),%eax
    d46e:	48 0f af f8          	imul   %rax,%rdi
    d472:	48 c1 ef 20          	shr    $0x20,%rdi
    d476:	48 01 d7             	add    %rdx,%rdi
    d479:	48 81 c7 28 02 00 00 	add    $0x228,%rdi
    d480:	0f b6 07             	movzbl (%rdi),%eax
    d483:	84 c0                	test   %al,%al
    d485:	74 ca                	je     d451 <fwp_caps57+0x61>
    d487:	3c fe                	cmp    $0xfe,%al
    d489:	73 06                	jae    d491 <fwp_caps57+0xa1>
    d48b:	fe c0                	inc    %al
    d48d:	88 07                	mov    %al,(%rdi)
    d48f:	5b                   	pop    %rbx
    d490:	c3                   	ret
    d491:	5b                   	pop    %rbx
    d492:	e9 69 a1 ff ff       	jmp    7600 <fwp_rc_wide_dup>
    d497:	66 0f 1f 84 00 00 00 	nopw   0x0(%rax,%rax,1)
    d49e:	00 00 

000000000000d4a0 <fwp_args57>:
    d4a0:	85 f6                	test   %esi,%esi
    d4a2:	0f 85 8a 00 00 00    	jne    d532 <fwp_args57+0x92>
    d4a8:	85 d2                	test   %edx,%edx
    d4aa:	0f 84 82 00 00 00    	je     d532 <fwp_args57+0x92>
    d4b0:	48 8b 07             	mov    (%rdi),%rax
    d4b3:	48 2b 05 f6 5c 00 00 	sub    0x5cf6(%rip),%rax        # 131b0 <fwp_gc+0x1030>
    d4ba:	48 8b 0d 17 5d 00 00 	mov    0x5d17(%rip),%rcx        # 131d8 <fwp_gc+0x1058>
    d4c1:	48 c1 e1 10          	shl    $0x10,%rcx
    d4c5:	48 39 c8             	cmp    %rcx,%rax
    d4c8:	73 68                	jae    d532 <fwp_args57+0x92>
    d4ca:	48 8b 0d 27 5d 00 00 	mov    0x5d27(%rip),%rcx        # 131f8 <fwp_gc+0x1078>
    d4d1:	48 89 c2             	mov    %rax,%rdx
    d4d4:	48 c1 ea 10          	shr    $0x10,%rdx
    d4d8:	48 69 d2 28 12 00 00 	imul   $0x1228,%rdx,%rdx
    d4df:	0f b6 34 11          	movzbl (%rcx,%rdx,1),%esi
    d4e3:	48 25 ff ff 00 00    	and    $0xffff,%rax
    d4e9:	75 13                	jne    d4fe <fwp_args57+0x5e>
    d4eb:	40 80 fe 02          	cmp    $0x2,%sil
    d4ef:	75 0d                	jne    d4fe <fwp_args57+0x5e>
    d4f1:	48 8d 3c 11          	lea    (%rcx,%rdx,1),%rdi
    d4f5:	48 81 c7 28 02 00 00 	add    $0x228,%rdi
    d4fc:	eb 21                	jmp    d51f <fwp_args57+0x7f>
    d4fe:	40 80 fe 01          	cmp    $0x1,%sil
    d502:	75 2e                	jne    d532 <fwp_args57+0x92>
    d504:	48 8d 34 11          	lea    (%rcx,%rdx,1),%rsi
    d508:	8b 4c 11 20          	mov    0x20(%rcx,%rdx,1),%ecx
    d50c:	48 0f af c1          	imul   %rcx,%rax
    d510:	48 c1 e8 20          	shr    $0x20,%rax
    d514:	48 8d 3c 30          	lea    (%rax,%rsi,1),%rdi
    d518:	48 81 c7 28 02 00 00 	add    $0x228,%rdi
    d51f:	0f b6 07             	movzbl (%rdi),%eax
    d522:	84 c0                	test   %al,%al
    d524:	74 0c                	je     d532 <fwp_args57+0x92>
    d526:	3c fe                	cmp    $0xfe,%al
    d528:	0f 83 d2 a0 ff ff    	jae    7600 <fwp_rc_wide_dup>
    d52e:	fe c0                	inc    %al
    d530:	88 07                	mov    %al,(%rdi)
    d532:	c3                   	ret
    d533:	66 66 66 66 2e 0f 1f 	data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    d53a:	84 00 00 00 00 00 

000000000000d540 <fwp_arg_drop57>:
    d540:	85 f6                	test   %esi,%esi
    d542:	75 0c                	jne    d550 <fwp_arg_drop57+0x10>
    d544:	85 d2                	test   %edx,%edx
    d546:	74 08                	je     d550 <fwp_arg_drop57+0x10>
    d548:	48 8b 3f             	mov    (%rdi),%rdi
    d54b:	e9 e0 fd ff ff       	jmp    d330 <fwp_drop11>
    d550:	c3                   	ret
    d551:	66 66 66 66 66 66 2e 	data16 data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    d558:	0f 1f 84 00 00 00 00 
    d55f:	00 

000000000000d560 <f59>:
    d560:	41 57                	push   %r15
    d562:	41 56                	push   %r14
    d564:	53                   	push   %rbx
    d565:	48 83 ec 30          	sub    $0x30,%rsp
    d569:	48 89 fb             	mov    %rdi,%rbx
    d56c:	48 8b 47 10          	mov    0x10(%rdi),%rax
    d570:	48 2b 05 39 5c 00 00 	sub    0x5c39(%rip),%rax        # 131b0 <fwp_gc+0x1030>
    d577:	48 8b 0d 5a 5c 00 00 	mov    0x5c5a(%rip),%rcx        # 131d8 <fwp_gc+0x1058>
    d57e:	48 c1 e1 10          	shl    $0x10,%rcx
    d582:	48 39 c8             	cmp    %rcx,%rax
    d585:	73 68                	jae    d5ef <f59+0x8f>
    d587:	48 8b 0d 6a 5c 00 00 	mov    0x5c6a(%rip),%rcx        # 131f8 <fwp_gc+0x1078>
    d58e:	48 89 c2             	mov    %rax,%rdx
    d591:	48 c1 ea 10          	shr    $0x10,%rdx
    d595:	48 69 d2 28 12 00 00 	imul   $0x1228,%rdx,%rdx
    d59c:	0f b6 34 11          	movzbl (%rcx,%rdx,1),%esi
    d5a0:	48 25 ff ff 00 00    	and    $0xffff,%rax
    d5a6:	75 13                	jne    d5bb <f59+0x5b>
    d5a8:	40 80 fe 02          	cmp    $0x2,%sil
    d5ac:	75 0d                	jne    d5bb <f59+0x5b>
    d5ae:	48 8d 3c 11          	lea    (%rcx,%rdx,1),%rdi
    d5b2:	48 81 c7 28 02 00 00 	add    $0x228,%rdi
    d5b9:	eb 21                	jmp    d5dc <f59+0x7c>
    d5bb:	40 80 fe 01          	cmp    $0x1,%sil
    d5bf:	75 2e                	jne    d5ef <f59+0x8f>
    d5c1:	48 8d 34 11          	lea    (%rcx,%rdx,1),%rsi
    d5c5:	8b 4c 11 20          	mov    0x20(%rcx,%rdx,1),%ecx
    d5c9:	48 0f af c1          	imul   %rcx,%rax
    d5cd:	48 c1 e8 20          	shr    $0x20,%rax
    d5d1:	48 8d 3c 30          	lea    (%rax,%rsi,1),%rdi
    d5d5:	48 81 c7 28 02 00 00 	add    $0x228,%rdi
    d5dc:	0f b6 07             	movzbl (%rdi),%eax
    d5df:	84 c0                	test   %al,%al
    d5e1:	74 0c                	je     d5ef <f59+0x8f>
    d5e3:	3c fe                	cmp    $0xfe,%al
    d5e5:	0f 83 cc 02 00 00    	jae    d8b7 <f59+0x357>
    d5eb:	fe c0                	inc    %al
    d5ed:	88 07                	mov    %al,(%rdi)
    d5ef:	4c 8b 7b 08          	mov    0x8(%rbx),%r15
    d5f3:	48 8b 7b 10          	mov    0x10(%rbx),%rdi
    d5f7:	f2 0f 10 43 18       	movsd  0x18(%rbx),%xmm0
    d5fc:	f2 0f 11 04 24       	movsd  %xmm0,(%rsp)
    d601:	4d 85 ff             	test   %r15,%r15
    d604:	78 20                	js     d626 <f59+0xc6>
    d606:	48 8b 07             	mov    (%rdi),%rax
    d609:	48 b9 ff ff ff ff ff 	movabs $0x7fffffffffffffff,%rcx
    d610:	ff ff 7f 
    d613:	48 21 c1             	and    %rax,%rcx
    d616:	4c 39 f9             	cmp    %r15,%rcx
    d619:	76 0b                	jbe    d626 <f59+0xc6>
    d61b:	48 85 c0             	test   %rax,%rax
    d61e:	78 7c                	js     d69c <f59+0x13c>
    d620:	48 8d 47 08          	lea    0x8(%rdi),%rax
    d624:	eb 7a                	jmp    d6a0 <f59+0x140>
    d626:	e8 15 ce ff ff       	call   a440 <fwp_drop1>
    d62b:	f2 0f 10 04 24       	movsd  (%rsp),%xmm0
    d630:	f2 0f 11 44 24 18    	movsd  %xmm0,0x18(%rsp)
    d636:	48 8d 54 24 18       	lea    0x18(%rsp),%rdx
    d63b:	bf 01 00 00 00       	mov    $0x1,%edi
    d640:	be 01 00 00 00       	mov    $0x1,%esi
    d645:	e8 a6 c7 ff ff       	call   9df0 <fwp_data>
    d64a:	49 89 c6             	mov    %rax,%r14
    d64d:	48 2b 05 5c 5b 00 00 	sub    0x5b5c(%rip),%rax        # 131b0 <fwp_gc+0x1030>
    d654:	48 8b 0d 7d 5b 00 00 	mov    0x5b7d(%rip),%rcx        # 131d8 <fwp_gc+0x1058>
    d65b:	48 c1 e1 10          	shl    $0x10,%rcx
    d65f:	48 39 c8             	cmp    %rcx,%rax
    d662:	0f 83 3a 02 00 00    	jae    d8a2 <f59+0x342>
    d668:	48 8b 0d 89 5b 00 00 	mov    0x5b89(%rip),%rcx        # 131f8 <fwp_gc+0x1078>
    d66f:	48 89 c2             	mov    %rax,%rdx
    d672:	48 c1 ea 10          	shr    $0x10,%rdx
    d676:	48 69 d2 28 12 00 00 	imul   $0x1228,%rdx,%rdx
    d67d:	0f b6 34 11          	movzbl (%rcx,%rdx,1),%esi
    d681:	48 25 ff ff 00 00    	and    $0xffff,%rax
    d687:	0f 85 e4 01 00 00    	jne    d871 <f59+0x311>
    d68d:	40 80 fe 02          	cmp    $0x2,%sil
    d691:	0f 84 c3 01 00 00    	je     d85a <f59+0x2fa>
    d697:	e9 d5 01 00 00       	jmp    d871 <f59+0x311>
    d69c:	48 8b 47 10          	mov    0x10(%rdi),%rax
    d6a0:	f2 42 0f 10 04 f8    	movsd  (%rax,%r15,8),%xmm0
    d6a6:	f2 0f 59 05 62 19 00 	mulsd  0x1962(%rip),%xmm0        # f010 <_IO_stdin_used+0x10>
    d6ad:	00 
    d6ae:	f2 0f 58 05 62 19 00 	addsd  0x1962(%rip),%xmm0        # f018 <_IO_stdin_used+0x18>
    d6b5:	00 
    d6b6:	f2 0f 11 44 24 08    	movsd  %xmm0,0x8(%rsp)
    d6bc:	48 89 f8             	mov    %rdi,%rax
    d6bf:	48 2b 05 ea 5a 00 00 	sub    0x5aea(%rip),%rax        # 131b0 <fwp_gc+0x1030>
    d6c6:	49 ff c7             	inc    %r15
    d6c9:	48 8b 0d 08 5b 00 00 	mov    0x5b08(%rip),%rcx        # 131d8 <fwp_gc+0x1058>
    d6d0:	48 c1 e1 10          	shl    $0x10,%rcx
    d6d4:	48 39 c8             	cmp    %rcx,%rax
    d6d7:	73 66                	jae    d73f <f59+0x1df>
    d6d9:	48 8b 0d 18 5b 00 00 	mov    0x5b18(%rip),%rcx        # 131f8 <fwp_gc+0x1078>
    d6e0:	48 89 c2             	mov    %rax,%rdx
    d6e3:	48 c1 ea 10          	shr    $0x10,%rdx
    d6e7:	48 69 d2 28 12 00 00 	imul   $0x1228,%rdx,%rdx
    d6ee:	0f b6 34 11          	movzbl (%rcx,%rdx,1),%esi
    d6f2:	48 25 ff ff 00 00    	and    $0xffff,%rax
    d6f8:	75 12                	jne    d70c <f59+0x1ac>
    d6fa:	40 80 fe 02          	cmp    $0x2,%sil
    d6fe:	75 0c                	jne    d70c <f59+0x1ac>
    d700:	48 8d 04 11          	lea    (%rcx,%rdx,1),%rax
    d704:	48 05 28 02 00 00    	add    $0x228,%rax
    d70a:	eb 1f                	jmp    d72b <f59+0x1cb>
    d70c:	40 80 fe 01          	cmp    $0x1,%sil
    d710:	75 2d                	jne    d73f <f59+0x1df>
    d712:	48 8d 34 11          	lea    (%rcx,%rdx,1),%rsi
    d716:	8b 4c 11 20          	mov    0x20(%rcx,%rdx,1),%ecx
    d71a:	48 0f af c1          	imul   %rcx,%rax
    d71e:	48 c1 e8 20          	shr    $0x20,%rax
    d722:	48 01 f0             	add    %rsi,%rax
    d725:	48 05 28 02 00 00    	add    $0x228,%rax
    d72b:	0f b6 08             	movzbl (%rax),%ecx
    d72e:	84 c9                	test   %cl,%cl
    d730:	74 0d                	je     d73f <f59+0x1df>
    d732:	80 f9 fe             	cmp    $0xfe,%cl
    d735:	0f 83 86 01 00 00    	jae    d8c1 <f59+0x361>
    d73b:	fe c1                	inc    %cl
    d73d:	88 08                	mov    %cl,(%rax)
    d73f:	49 89 fe             	mov    %rdi,%r14
    d742:	e8 f9 cc ff ff       	call   a440 <fwp_drop1>
    d747:	f2 0f 10 04 24       	movsd  (%rsp),%xmm0
    d74c:	f2 0f 58 44 24 08    	addsd  0x8(%rsp),%xmm0
    d752:	4c 89 7c 24 18       	mov    %r15,0x18(%rsp)
    d757:	4c 89 74 24 20       	mov    %r14,0x20(%rsp)
    d75c:	f2 0f 11 44 24 28    	movsd  %xmm0,0x28(%rsp)
    d762:	48 8d 54 24 18       	lea    0x18(%rsp),%rdx
    d767:	31 ff                	xor    %edi,%edi
    d769:	be 03 00 00 00       	mov    $0x3,%esi
    d76e:	e8 7d c6 ff ff       	call   9df0 <fwp_data>
    d773:	48 89 c1             	mov    %rax,%rcx
    d776:	48 2b 0d 33 5a 00 00 	sub    0x5a33(%rip),%rcx        # 131b0 <fwp_gc+0x1030>
    d77d:	48 8b 15 54 5a 00 00 	mov    0x5a54(%rip),%rdx        # 131d8 <fwp_gc+0x1058>
    d784:	48 c1 e2 10          	shl    $0x10,%rdx
    d788:	48 39 d1             	cmp    %rdx,%rcx
    d78b:	73 76                	jae    d803 <f59+0x2a3>
    d78d:	48 8b 15 64 5a 00 00 	mov    0x5a64(%rip),%rdx        # 131f8 <fwp_gc+0x1078>
    d794:	48 89 ce             	mov    %rcx,%rsi
    d797:	48 c1 ee 10          	shr    $0x10,%rsi
    d79b:	48 69 f6 28 12 00 00 	imul   $0x1228,%rsi,%rsi
    d7a2:	0f b6 3c 32          	movzbl (%rdx,%rsi,1),%edi
    d7a6:	48 81 e1 ff ff 00 00 	and    $0xffff,%rcx
    d7ad:	75 1d                	jne    d7cc <f59+0x26c>
    d7af:	40 80 ff 02          	cmp    $0x2,%dil
    d7b3:	75 17                	jne    d7cc <f59+0x26c>
    d7b5:	4c 8d 34 32          	lea    (%rdx,%rsi,1),%r14
    d7b9:	49 81 c6 28 02 00 00 	add    $0x228,%r14
    d7c0:	41 80 3e ff          	cmpb   $0xff,(%r14)
    d7c4:	74 2d                	je     d7f3 <f59+0x293>
    d7c6:	41 c6 06 01          	movb   $0x1,(%r14)
    d7ca:	eb 37                	jmp    d803 <f59+0x2a3>
    d7cc:	40 80 ff 01          	cmp    $0x1,%dil
    d7d0:	75 31                	jne    d803 <f59+0x2a3>
    d7d2:	48 8d 3c 32          	lea    (%rdx,%rsi,1),%rdi
    d7d6:	8b 54 32 20          	mov    0x20(%rdx,%rsi,1),%edx
    d7da:	48 0f af ca          	imul   %rdx,%rcx
    d7de:	48 c1 e9 20          	shr    $0x20,%rcx
    d7e2:	4c 8d 34 39          	lea    (%rcx,%rdi,1),%r14
    d7e6:	49 81 c6 28 02 00 00 	add    $0x228,%r14
    d7ed:	41 80 3e ff          	cmpb   $0xff,(%r14)
    d7f1:	75 d3                	jne    d7c6 <f59+0x266>
    d7f3:	4c 89 f7             	mov    %r14,%rdi
    d7f6:	49 89 c7             	mov    %rax,%r15
    d7f9:	e8 22 8b ff ff       	call   6320 <fwp_rc_forget_slot>
    d7fe:	4c 89 f8             	mov    %r15,%rax
    d801:	eb c3                	jmp    d7c6 <f59+0x266>
    d803:	48 89 44 24 10       	mov    %rax,0x10(%rsp)
    d808:	48 8d 54 24 10       	lea    0x10(%rsp),%rdx
    d80d:	31 ff                	xor    %edi,%edi
    d80f:	be 01 00 00 00       	mov    $0x1,%esi
    d814:	e8 d7 c5 ff ff       	call   9df0 <fwp_data>
    d819:	49 89 c6             	mov    %rax,%r14
    d81c:	48 2b 05 8d 59 00 00 	sub    0x598d(%rip),%rax        # 131b0 <fwp_gc+0x1030>
    d823:	48 8b 0d ae 59 00 00 	mov    0x59ae(%rip),%rcx        # 131d8 <fwp_gc+0x1058>
    d82a:	48 c1 e1 10          	shl    $0x10,%rcx
    d82e:	48 39 c8             	cmp    %rcx,%rax
    d831:	73 6f                	jae    d8a2 <f59+0x342>
    d833:	48 8b 0d be 59 00 00 	mov    0x59be(%rip),%rcx        # 131f8 <fwp_gc+0x1078>
    d83a:	48 89 c2             	mov    %rax,%rdx
    d83d:	48 c1 ea 10          	shr    $0x10,%rdx
    d841:	48 69 d2 28 12 00 00 	imul   $0x1228,%rdx,%rdx
    d848:	0f b6 34 11          	movzbl (%rcx,%rdx,1),%esi
    d84c:	48 25 ff ff 00 00    	and    $0xffff,%rax
    d852:	75 1d                	jne    d871 <f59+0x311>
    d854:	40 80 fe 02          	cmp    $0x2,%sil
    d858:	75 17                	jne    d871 <f59+0x311>
    d85a:	4c 8d 3c 11          	lea    (%rcx,%rdx,1),%r15
    d85e:	49 81 c7 28 02 00 00 	add    $0x228,%r15
    d865:	41 80 3f ff          	cmpb   $0xff,(%r15)
    d869:	74 2d                	je     d898 <f59+0x338>
    d86b:	41 c6 07 01          	movb   $0x1,(%r15)
    d86f:	eb 31                	jmp    d8a2 <f59+0x342>
    d871:	40 80 fe 01          	cmp    $0x1,%sil
    d875:	75 2b                	jne    d8a2 <f59+0x342>
    d877:	48 8d 34 11          	lea    (%rcx,%rdx,1),%rsi
    d87b:	8b 4c 11 20          	mov    0x20(%rcx,%rdx,1),%ecx
    d87f:	48 0f af c1          	imul   %rcx,%rax
    d883:	48 c1 e8 20          	shr    $0x20,%rax
    d887:	4c 8d 3c 30          	lea    (%rax,%rsi,1),%r15
    d88b:	49 81 c7 28 02 00 00 	add    $0x228,%r15
    d892:	41 80 3f ff          	cmpb   $0xff,(%r15)
    d896:	75 d3                	jne    d86b <f59+0x30b>
    d898:	4c 89 ff             	mov    %r15,%rdi
    d89b:	e8 80 8a ff ff       	call   6320 <fwp_rc_forget_slot>
    d8a0:	eb c9                	jmp    d86b <f59+0x30b>
    d8a2:	48 89 df             	mov    %rbx,%rdi
    d8a5:	e8 e6 ca ff ff       	call   a390 <fwp_drop6>
    d8aa:	4c 89 f0             	mov    %r14,%rax
    d8ad:	48 83 c4 30          	add    $0x30,%rsp
    d8b1:	5b                   	pop    %rbx
    d8b2:	41 5e                	pop    %r14
    d8b4:	41 5f                	pop    %r15
    d8b6:	c3                   	ret
    d8b7:	e8 44 9d ff ff       	call   7600 <fwp_rc_wide_dup>
    d8bc:	e9 2e fd ff ff       	jmp    d5ef <f59+0x8f>
    d8c1:	49 89 fe             	mov    %rdi,%r14
    d8c4:	48 89 c7             	mov    %rax,%rdi
    d8c7:	e8 34 9d ff ff       	call   7600 <fwp_rc_wide_dup>
    d8cc:	4c 89 f7             	mov    %r14,%rdi
    d8cf:	e9 6b fe ff ff       	jmp    d73f <f59+0x1df>
    d8d4:	66 66 66 2e 0f 1f 84 	data16 data16 cs nopw 0x0(%rax,%rax,1)
    d8db:	00 00 00 00 00 

000000000000d8e0 <fwp_owned_entry59>:
    d8e0:	48 8b 3f             	mov    (%rdi),%rdi
    d8e3:	e9 78 fc ff ff       	jmp    d560 <f59>
    d8e8:	0f 1f 84 00 00 00 00 	nopl   0x0(%rax,%rax,1)
    d8ef:	00 

000000000000d8f0 <fwp_caps59>:
    d8f0:	53                   	push   %rbx
    d8f1:	83 7f 04 00          	cmpl   $0x0,0x4(%rdi)
    d8f5:	74 56                	je     d94d <fwp_caps59+0x5d>
    d8f7:	48 89 fb             	mov    %rdi,%rbx
    d8fa:	48 8b 7f 08          	mov    0x8(%rdi),%rdi
    d8fe:	85 f6                	test   %esi,%esi
    d900:	74 51                	je     d953 <fwp_caps59+0x63>
    d902:	48 2b 3d a7 58 00 00 	sub    0x58a7(%rip),%rdi        # 131b0 <fwp_gc+0x1030>
    d909:	48 8b 05 c8 58 00 00 	mov    0x58c8(%rip),%rax        # 131d8 <fwp_gc+0x1058>
    d910:	48 c1 e0 10          	shl    $0x10,%rax
    d914:	48 39 c7             	cmp    %rax,%rdi
    d917:	73 38                	jae    d951 <fwp_caps59+0x61>
    d919:	48 8b 05 d8 58 00 00 	mov    0x58d8(%rip),%rax        # 131f8 <fwp_gc+0x1078>
    d920:	48 89 f9             	mov    %rdi,%rcx
    d923:	48 c1 e9 10          	shr    $0x10,%rcx
    d927:	48 69 c9 28 12 00 00 	imul   $0x1228,%rcx,%rcx
    d92e:	0f b6 14 08          	movzbl (%rax,%rcx,1),%edx
    d932:	48 81 e7 ff ff 00 00 	and    $0xffff,%rdi
    d939:	75 26                	jne    d961 <fwp_caps59+0x71>
    d93b:	80 fa 02             	cmp    $0x2,%dl
    d93e:	75 21                	jne    d961 <fwp_caps59+0x71>
    d940:	48 8d 3c 08          	lea    (%rax,%rcx,1),%rdi
    d944:	48 81 c7 28 02 00 00 	add    $0x228,%rdi
    d94b:	eb 33                	jmp    d980 <fwp_caps59+0x90>
    d94d:	85 f6                	test   %esi,%esi
    d94f:	74 0a                	je     d95b <fwp_caps59+0x6b>
    d951:	5b                   	pop    %rbx
    d952:	c3                   	ret
    d953:	e8 38 ca ff ff       	call   a390 <fwp_drop6>
    d958:	48 89 df             	mov    %rbx,%rdi
    d95b:	5b                   	pop    %rbx
    d95c:	e9 af cf ff ff       	jmp    a910 <fwp_rc_free_obj>
    d961:	80 fa 01             	cmp    $0x1,%dl
    d964:	75 eb                	jne    d951 <fwp_caps59+0x61>
    d966:	48 8d 14 08          	lea    (%rax,%rcx,1),%rdx
    d96a:	8b 44 08 20          	mov    0x20(%rax,%rcx,1),%eax
    d96e:	48 0f af f8          	imul   %rax,%rdi
    d972:	48 c1 ef 20          	shr    $0x20,%rdi
    d976:	48 01 d7             	add    %rdx,%rdi
    d979:	48 81 c7 28 02 00 00 	add    $0x228,%rdi
    d980:	0f b6 07             	movzbl (%rdi),%eax
    d983:	84 c0                	test   %al,%al
    d985:	74 ca                	je     d951 <fwp_caps59+0x61>
    d987:	3c fe                	cmp    $0xfe,%al
    d989:	73 06                	jae    d991 <fwp_caps59+0xa1>
    d98b:	fe c0                	inc    %al
    d98d:	88 07                	mov    %al,(%rdi)
    d98f:	5b                   	pop    %rbx
    d990:	c3                   	ret
    d991:	5b                   	pop    %rbx
    d992:	e9 69 9c ff ff       	jmp    7600 <fwp_rc_wide_dup>
    d997:	66 0f 1f 84 00 00 00 	nopw   0x0(%rax,%rax,1)
    d99e:	00 00 

000000000000d9a0 <fwp_args59>:
    d9a0:	85 f6                	test   %esi,%esi
    d9a2:	0f 85 8a 00 00 00    	jne    da32 <fwp_args59+0x92>
    d9a8:	85 d2                	test   %edx,%edx
    d9aa:	0f 84 82 00 00 00    	je     da32 <fwp_args59+0x92>
    d9b0:	48 8b 07             	mov    (%rdi),%rax
    d9b3:	48 2b 05 f6 57 00 00 	sub    0x57f6(%rip),%rax        # 131b0 <fwp_gc+0x1030>
    d9ba:	48 8b 0d 17 58 00 00 	mov    0x5817(%rip),%rcx        # 131d8 <fwp_gc+0x1058>
    d9c1:	48 c1 e1 10          	shl    $0x10,%rcx
    d9c5:	48 39 c8             	cmp    %rcx,%rax
    d9c8:	73 68                	jae    da32 <fwp_args59+0x92>
    d9ca:	48 8b 0d 27 58 00 00 	mov    0x5827(%rip),%rcx        # 131f8 <fwp_gc+0x1078>
    d9d1:	48 89 c2             	mov    %rax,%rdx
    d9d4:	48 c1 ea 10          	shr    $0x10,%rdx
    d9d8:	48 69 d2 28 12 00 00 	imul   $0x1228,%rdx,%rdx
    d9df:	0f b6 34 11          	movzbl (%rcx,%rdx,1),%esi
    d9e3:	48 25 ff ff 00 00    	and    $0xffff,%rax
    d9e9:	75 13                	jne    d9fe <fwp_args59+0x5e>
    d9eb:	40 80 fe 02          	cmp    $0x2,%sil
    d9ef:	75 0d                	jne    d9fe <fwp_args59+0x5e>
    d9f1:	48 8d 3c 11          	lea    (%rcx,%rdx,1),%rdi
    d9f5:	48 81 c7 28 02 00 00 	add    $0x228,%rdi
    d9fc:	eb 21                	jmp    da1f <fwp_args59+0x7f>
    d9fe:	40 80 fe 01          	cmp    $0x1,%sil
    da02:	75 2e                	jne    da32 <fwp_args59+0x92>
    da04:	48 8d 34 11          	lea    (%rcx,%rdx,1),%rsi
    da08:	8b 4c 11 20          	mov    0x20(%rcx,%rdx,1),%ecx
    da0c:	48 0f af c1          	imul   %rcx,%rax
    da10:	48 c1 e8 20          	shr    $0x20,%rax
    da14:	48 8d 3c 30          	lea    (%rax,%rsi,1),%rdi
    da18:	48 81 c7 28 02 00 00 	add    $0x228,%rdi
    da1f:	0f b6 07             	movzbl (%rdi),%eax
    da22:	84 c0                	test   %al,%al
    da24:	74 0c                	je     da32 <fwp_args59+0x92>
    da26:	3c fe                	cmp    $0xfe,%al
    da28:	0f 83 d2 9b ff ff    	jae    7600 <fwp_rc_wide_dup>
    da2e:	fe c0                	inc    %al
    da30:	88 07                	mov    %al,(%rdi)
    da32:	c3                   	ret
    da33:	66 66 66 66 2e 0f 1f 	data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    da3a:	84 00 00 00 00 00 

000000000000da40 <fwp_arg_drop59>:
    da40:	85 f6                	test   %esi,%esi
    da42:	75 0c                	jne    da50 <fwp_arg_drop59+0x10>
    da44:	85 d2                	test   %edx,%edx
    da46:	74 08                	je     da50 <fwp_arg_drop59+0x10>
    da48:	48 8b 3f             	mov    (%rdi),%rdi
    da4b:	e9 40 c9 ff ff       	jmp    a390 <fwp_drop6>
    da50:	c3                   	ret
    da51:	66 66 66 66 66 66 2e 	data16 data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    da58:	0f 1f 84 00 00 00 00 
    da5f:	00 

000000000000da60 <fwp_gc_find_data>:
    da60:	0f b7 77 18          	movzwl 0x18(%rdi),%esi
    da64:	48 85 f6             	test   %rsi,%rsi
    da67:	0f 84 be 00 00 00    	je     db2b <fwp_gc_find_data+0xcb>
    da6d:	53                   	push   %rbx
    da6e:	48 8b 07             	mov    (%rdi),%rax
    da71:	4c 8b 47 10          	mov    0x10(%rdi),%r8
    da75:	48 6b ce 38          	imul   $0x38,%rsi,%rcx
    da79:	45 31 c9             	xor    %r9d,%r9d
    da7c:	48 8d 15 fd 46 00 00 	lea    0x46fd(%rip),%rdx        # 12180 <fwp_gc>
    da83:	41 bb 01 00 00 00    	mov    $0x1,%r11d
    da89:	45 31 d2             	xor    %r10d,%r10d
    da8c:	eb 0b                	jmp    da99 <fwp_gc_find_data+0x39>
    da8e:	66 90                	xchg   %ax,%ax
    da90:	49 83 c1 38          	add    $0x38,%r9
    da94:	4c 39 c9             	cmp    %r9,%rcx
    da97:	74 22                	je     dabb <fwp_gc_find_data+0x5b>
    da99:	43 83 3c 08 01       	cmpl   $0x1,(%r8,%r9,1)
    da9e:	75 f0                	jne    da90 <fwp_gc_find_data+0x30>
    daa0:	4b 8b 5c 08 10       	mov    0x10(%r8,%r9,1),%rbx
    daa5:	48 01 c3             	add    %rax,%rbx
    daa8:	48 39 d3             	cmp    %rdx,%rbx
    daab:	77 e3                	ja     da90 <fwp_gc_find_data+0x30>
    daad:	4b 03 5c 08 28       	add    0x28(%r8,%r9,1),%rbx
    dab2:	48 39 d3             	cmp    %rdx,%rbx
    dab5:	45 0f 47 d3          	cmova  %r11d,%r10d
    dab9:	eb d5                	jmp    da90 <fwp_gc_find_data+0x30>
    dabb:	31 c0                	xor    %eax,%eax
    dabd:	45 85 d2             	test   %r10d,%r10d
    dac0:	0f 95 c0             	setne  %al
    dac3:	74 6e                	je     db33 <fwp_gc_find_data+0xd3>
    dac5:	66 85 f6             	test   %si,%si
    dac8:	74 69                	je     db33 <fwp_gc_find_data+0xd3>
    daca:	8b 05 40 58 00 00    	mov    0x5840(%rip),%eax        # 13310 <fwp_gc+0x1190>
    dad0:	48 8b 77 10          	mov    0x10(%rdi),%rsi
    dad4:	45 31 c0             	xor    %r8d,%r8d
    dad7:	eb 10                	jmp    dae9 <fwp_gc_find_data+0x89>
    dad9:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)
    dae0:	49 83 c0 38          	add    $0x38,%r8
    dae4:	4c 39 c1             	cmp    %r8,%rcx
    dae7:	74 45                	je     db2e <fwp_gc_find_data+0xce>
    dae9:	42 83 3c 06 01       	cmpl   $0x1,(%rsi,%r8,1)
    daee:	75 f0                	jne    dae0 <fwp_gc_find_data+0x80>
    daf0:	42 f6 44 06 04 02    	testb  $0x2,0x4(%rsi,%r8,1)
    daf6:	74 e8                	je     dae0 <fwp_gc_find_data+0x80>
    daf8:	83 f8 10             	cmp    $0x10,%eax
    dafb:	74 31                	je     db2e <fwp_gc_find_data+0xce>
    dafd:	4e 8b 4c 06 10       	mov    0x10(%rsi,%r8,1),%r9
    db02:	4c 03 0f             	add    (%rdi),%r9
    db05:	4c 63 d0             	movslq %eax,%r10
    db08:	49 c1 e2 04          	shl    $0x4,%r10
    db0c:	4d 89 8c 12 90 10 00 	mov    %r9,0x1090(%r10,%rdx,1)
    db13:	00 
    db14:	4e 8b 4c 06 28       	mov    0x28(%rsi,%r8,1),%r9
    db19:	4d 89 8c 12 98 10 00 	mov    %r9,0x1098(%r10,%rdx,1)
    db20:	00 
    db21:	ff c0                	inc    %eax
    db23:	89 05 e7 57 00 00    	mov    %eax,0x57e7(%rip)        # 13310 <fwp_gc+0x1190>
    db29:	eb b5                	jmp    dae0 <fwp_gc_find_data+0x80>
    db2b:	31 c0                	xor    %eax,%eax
    db2d:	c3                   	ret
    db2e:	b8 01 00 00 00       	mov    $0x1,%eax
    db33:	5b                   	pop    %rbx
    db34:	c3                   	ret
    db35:	66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
    db3c:	00 00 00 00 

000000000000db40 <fwp_gc_report>:
    db40:	55                   	push   %rbp
    db41:	41 57                	push   %r15
    db43:	41 56                	push   %r14
    db45:	41 55                	push   %r13
    db47:	41 54                	push   %r12
    db49:	53                   	push   %rbx
    db4a:	48 81 ec 58 01 00 00 	sub    $0x158,%rsp
    db51:	48 8b 05 38 58 00 00 	mov    0x5838(%rip),%rax        # 13390 <fwp_gc+0x1210>
    db58:	48 8b 0d 21 46 00 00 	mov    0x4621(%rip),%rcx        # 12180 <fwp_gc>
    db5f:	48 29 c8             	sub    %rcx,%rax
    db62:	f2 48 0f 2a c0       	cvtsi2sd %rax,%xmm0
    db67:	f2 0f 58 05 f9 57 00 	addsd  0x57f9(%rip),%xmm0        # 13368 <fwp_gc+0x11e8>
    db6e:	00 
    db6f:	f2 0f 11 44 24 48    	movsd  %xmm0,0x48(%rsp)
    db75:	f2 0f 11 05 eb 57 00 	movsd  %xmm0,0x57eb(%rip)        # 13368 <fwp_gc+0x11e8>
    db7c:	00 
    db7d:	48 89 0d 0c 58 00 00 	mov    %rcx,0x580c(%rip)        # 13390 <fwp_gc+0x1210>
    db84:	48 8b 05 55 44 00 00 	mov    0x4455(%rip),%rax        # 11fe0 <stderr@GLIBC_2.2.5>
    db8b:	48 8b 28             	mov    (%rax),%rbp
    db8e:	48 8b 1d c3 57 00 00 	mov    0x57c3(%rip),%rbx        # 13358 <fwp_gc+0x11d8>
    db95:	4c 8b 3d fc 55 00 00 	mov    0x55fc(%rip),%r15        # 13198 <fwp_gc+0x1018>
    db9c:	f2 0f 10 05 e4 57 00 	movsd  0x57e4(%rip),%xmm0        # 13388 <fwp_gc+0x1208>
    dba3:	00 
    dba4:	f2 0f 11 44 24 30    	movsd  %xmm0,0x30(%rsp)
    dbaa:	48 8b 05 17 56 00 00 	mov    0x5617(%rip),%rax        # 131c8 <fwp_gc+0x1048>
    dbb1:	48 89 44 24 28       	mov    %rax,0x28(%rsp)
    dbb6:	48 8b 05 8b 57 00 00 	mov    0x578b(%rip),%rax        # 13348 <fwp_gc+0x11c8>
    dbbd:	48 89 44 24 20       	mov    %rax,0x20(%rsp)
    dbc2:	4c 8b 35 87 57 00 00 	mov    0x5787(%rip),%r14        # 13350 <fwp_gc+0x11d0>
    dbc9:	f2 0f 10 05 9f 57 00 	movsd  0x579f(%rip),%xmm0        # 13370 <fwp_gc+0x11f0>
    dbd0:	00 
    dbd1:	f2 0f 11 44 24 40    	movsd  %xmm0,0x40(%rsp)
    dbd7:	f2 0f 10 05 99 57 00 	movsd  0x5799(%rip),%xmm0        # 13378 <fwp_gc+0x11f8>
    dbde:	00 
    dbdf:	f2 0f 11 44 24 38    	movsd  %xmm0,0x38(%rsp)
    dbe5:	48 8d 3d 0b 1c 00 00 	lea    0x1c0b(%rip),%rdi        # f7f7 <fwp_segv.msg+0x5b7>
    dbec:	48 8d 35 7e 1a 00 00 	lea    0x1a7e(%rip),%rsi        # f671 <fwp_segv.msg+0x431>
    dbf3:	e8 58 46 ff ff       	call   2250 <fopen@plt>
    dbf8:	49 c7 c4 ff ff ff ff 	mov    $0xffffffffffffffff,%r12
    dbff:	48 85 c0             	test   %rax,%rax
    dc02:	74 4b                	je     dc4f <fwp_gc_report+0x10f>
    dc04:	49 89 c5             	mov    %rax,%r13
    dc07:	48 89 6c 24 08       	mov    %rbp,0x8(%rsp)
    dc0c:	4c 89 7c 24 10       	mov    %r15,0x10(%rsp)
    dc11:	48 89 5c 24 18       	mov    %rbx,0x18(%rsp)
    dc16:	48 8d 7c 24 50       	lea    0x50(%rsp),%rdi
    dc1b:	be 00 01 00 00       	mov    $0x100,%esi
    dc20:	48 89 c2             	mov    %rax,%rdx
    dc23:	e8 38 45 ff ff       	call   2160 <fgets@plt>
    dc28:	49 c7 c4 ff ff ff ff 	mov    $0xffffffffffffffff,%r12
    dc2f:	48 85 c0             	test   %rax,%rax
    dc32:	0f 85 f1 00 00 00    	jne    dd29 <fwp_gc_report+0x1e9>
    dc38:	4c 89 ef             	mov    %r13,%rdi
    dc3b:	e8 90 44 ff ff       	call   20d0 <fclose@plt>
    dc40:	48 8b 5c 24 18       	mov    0x18(%rsp),%rbx
    dc45:	4c 8b 7c 24 10       	mov    0x10(%rsp),%r15
    dc4a:	48 8b 6c 24 08       	mov    0x8(%rsp),%rbp
    dc4f:	66 49 0f 6e c6       	movq   %r14,%xmm0
    dc54:	66 0f 6f 0d a4 14 00 	movdqa 0x14a4(%rip),%xmm1        # f100 <_IO_stdin_used+0x100>
    dc5b:	00 
    dc5c:	66 0f 62 c1          	punpckldq %xmm1,%xmm0
    dc60:	66 0f 28 15 a8 14 00 	movapd 0x14a8(%rip),%xmm2        # f110 <_IO_stdin_used+0x110>
    dc67:	00 
    dc68:	66 0f 5c c2          	subpd  %xmm2,%xmm0
    dc6c:	66 0f 28 e0          	movapd %xmm0,%xmm4
    dc70:	66 0f 15 e0          	unpckhpd %xmm0,%xmm4
    dc74:	f2 0f 58 e0          	addsd  %xmm0,%xmm4
    dc78:	f2 0f 10 35 a8 13 00 	movsd  0x13a8(%rip),%xmm6        # f028 <_IO_stdin_used+0x28>
    dc7f:	00 
    dc80:	f2 0f 59 e6          	mulsd  %xmm6,%xmm4
    dc84:	f3 0f 7e 6c 24 20    	movq   0x20(%rsp),%xmm5
    dc8a:	66 0f 62 e9          	punpckldq %xmm1,%xmm5
    dc8e:	66 0f 5c ea          	subpd  %xmm2,%xmm5
    dc92:	66 0f 28 dd          	movapd %xmm5,%xmm3
    dc96:	66 0f 15 dd          	unpckhpd %xmm5,%xmm3
    dc9a:	f2 0f 58 dd          	addsd  %xmm5,%xmm3
    dc9e:	f2 0f 59 de          	mulsd  %xmm6,%xmm3
    dca2:	f3 0f 7e 6c 24 28    	movq   0x28(%rsp),%xmm5
    dca8:	66 0f 62 e9          	punpckldq %xmm1,%xmm5
    dcac:	66 0f 5c ea          	subpd  %xmm2,%xmm5
    dcb0:	66 0f 28 d5          	movapd %xmm5,%xmm2
    dcb4:	66 0f 15 d5          	unpckhpd %xmm5,%xmm2
    dcb8:	f2 0f 58 d5          	addsd  %xmm5,%xmm2
    dcbc:	f2 0f 59 d6          	mulsd  %xmm6,%xmm2
    dcc0:	f2 0f 10 44 24 48    	movsd  0x48(%rsp),%xmm0
    dcc6:	f2 0f 10 4c 24 30    	movsd  0x30(%rsp),%xmm1
    dccc:	f2 0f 58 c1          	addsd  %xmm1,%xmm0
    dcd0:	f2 0f 59 ce          	mulsd  %xmm6,%xmm1
    dcd4:	f2 0f 59 c6          	mulsd  %xmm6,%xmm0
    dcd8:	83 3d 95 54 00 00 00 	cmpl   $0x0,0x5495(%rip)        # 13174 <fwp_gc+0xff4>
    dcdf:	48 8d 05 ff 1a 00 00 	lea    0x1aff(%rip),%rax        # f7e5 <fwp_segv.msg+0x5a5>
    dce6:	4c 8d 0d 42 1a 00 00 	lea    0x1a42(%rip),%r9        # f72f <fwp_segv.msg+0x4ef>
    dced:	4c 0f 44 c8          	cmove  %rax,%r9
    dcf1:	48 8d 35 38 1a 00 00 	lea    0x1a38(%rip),%rsi        # f730 <fwp_segv.msg+0x4f0>
    dcf8:	48 89 ef             	mov    %rbp,%rdi
    dcfb:	48 89 da             	mov    %rbx,%rdx
    dcfe:	4c 89 f9             	mov    %r15,%rcx
    dd01:	f2 0f 10 6c 24 40    	movsd  0x40(%rsp),%xmm5
    dd07:	f2 0f 10 74 24 38    	movsd  0x38(%rsp),%xmm6
    dd0d:	4d 89 e0             	mov    %r12,%r8
    dd10:	b0 07                	mov    $0x7,%al
    dd12:	e8 99 44 ff ff       	call   21b0 <fprintf@plt>
    dd17:	48 81 c4 58 01 00 00 	add    $0x158,%rsp
    dd1e:	5b                   	pop    %rbx
    dd1f:	41 5c                	pop    %r12
    dd21:	41 5d                	pop    %r13
    dd23:	41 5e                	pop    %r14
    dd25:	41 5f                	pop    %r15
    dd27:	5d                   	pop    %rbp
    dd28:	c3                   	ret
    dd29:	48 8d 6c 24 56       	lea    0x56(%rsp),%rbp
    dd2e:	41 bf 56 6d 48 57    	mov    $0x57486d56,%r15d
    dd34:	48 8d 5c 24 50       	lea    0x50(%rsp),%rbx
    dd39:	eb 1e                	jmp    dd59 <fwp_gc_report+0x219>
    dd3b:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)
    dd40:	48 89 df             	mov    %rbx,%rdi
    dd43:	be 00 01 00 00       	mov    $0x100,%esi
    dd48:	4c 89 ea             	mov    %r13,%rdx
    dd4b:	e8 10 44 ff ff       	call   2160 <fgets@plt>
    dd50:	48 85 c0             	test   %rax,%rax
    dd53:	0f 84 df fe ff ff    	je     dc38 <fwp_gc_report+0xf8>
    dd59:	8b 44 24 50          	mov    0x50(%rsp),%eax
    dd5d:	44 31 f8             	xor    %r15d,%eax
    dd60:	0f b6 4c 24 54       	movzbl 0x54(%rsp),%ecx
    dd65:	83 f1 4d             	xor    $0x4d,%ecx
    dd68:	09 c1                	or     %eax,%ecx
    dd6a:	75 d4                	jne    dd40 <fwp_gc_report+0x200>
    dd6c:	80 7c 24 55 3a       	cmpb   $0x3a,0x55(%rsp)
    dd71:	75 cd                	jne    dd40 <fwp_gc_report+0x200>
    dd73:	48 89 ef             	mov    %rbp,%rdi
    dd76:	31 f6                	xor    %esi,%esi
    dd78:	ba 0a 00 00 00       	mov    $0xa,%edx
    dd7d:	e8 4e 44 ff ff       	call   21d0 <strtol@plt>
    dd82:	49 89 c4             	mov    %rax,%r12
    dd85:	eb b9                	jmp    dd40 <fwp_gc_report+0x200>
    dd87:	66 0f 1f 84 00 00 00 	nopw   0x0(%rax,%rax,1)
    dd8e:	00 00 

000000000000dd90 <fwp_segv>:
    dd90:	48 8b 05 61 5e 00 00 	mov    0x5e61(%rip),%rax        # 13bf8 <fwp_main_stack_top>
    dd97:	48 85 c0             	test   %rax,%rax
    dd9a:	74 22                	je     ddbe <fwp_segv+0x2e>
    dd9c:	48 8b 4e 10          	mov    0x10(%rsi),%rcx
    dda0:	48 2b 05 59 5e 00 00 	sub    0x5e59(%rip),%rax        # 13c00 <fwp_main_stack_size>
    dda7:	48 8d 90 00 00 f0 ff 	lea    -0x100000(%rax),%rdx
    ddae:	48 39 ca             	cmp    %rcx,%rdx
    ddb1:	77 0b                	ja     ddbe <fwp_segv+0x2e>
    ddb3:	48 05 00 00 10 00    	add    $0x100000,%rax
    ddb9:	48 39 c8             	cmp    %rcx,%rax
    ddbc:	77 07                	ja     ddc5 <fwp_segv+0x35>
    ddbe:	31 f6                	xor    %esi,%esi
    ddc0:	e9 cb 43 ff ff       	jmp    2190 <signal@plt>
    ddc5:	50                   	push   %rax
    ddc6:	e8 25 85 ff ff       	call   62f0 <fwp_flush>
    ddcb:	48 8d 35 6e 14 00 00 	lea    0x146e(%rip),%rsi        # f240 <fwp_segv.msg>
    ddd2:	ba 1a 00 00 00       	mov    $0x1a,%edx
    ddd7:	bf 02 00 00 00       	mov    $0x2,%edi
    dddc:	e8 df 42 ff ff       	call   20c0 <write@plt>
    dde1:	bf 65 00 00 00       	mov    $0x65,%edi
    dde6:	e8 85 42 ff ff       	call   2070 <_exit@plt>
    ddeb:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)

000000000000ddf0 <fwp_drop0>:
    ddf0:	53                   	push   %rbx
    ddf1:	48 89 f8             	mov    %rdi,%rax
    ddf4:	48 2b 05 b5 53 00 00 	sub    0x53b5(%rip),%rax        # 131b0 <fwp_gc+0x1030>
    ddfb:	48 8b 0d d6 53 00 00 	mov    0x53d6(%rip),%rcx        # 131d8 <fwp_gc+0x1058>
    de02:	48 c1 e1 10          	shl    $0x10,%rcx
    de06:	48 39 c8             	cmp    %rcx,%rax
    de09:	0f 83 96 00 00 00    	jae    dea5 <fwp_drop0+0xb5>
    de0f:	48 8b 0d e2 53 00 00 	mov    0x53e2(%rip),%rcx        # 131f8 <fwp_gc+0x1078>
    de16:	48 89 c2             	mov    %rax,%rdx
    de19:	48 c1 ea 10          	shr    $0x10,%rdx
    de1d:	48 69 d2 28 12 00 00 	imul   $0x1228,%rdx,%rdx
    de24:	0f b6 34 11          	movzbl (%rcx,%rdx,1),%esi
    de28:	48 25 ff ff 00 00    	and    $0xffff,%rax
    de2e:	75 20                	jne    de50 <fwp_drop0+0x60>
    de30:	40 80 fe 02          	cmp    $0x2,%sil
    de34:	75 1a                	jne    de50 <fwp_drop0+0x60>
    de36:	48 8d 04 11          	lea    (%rcx,%rdx,1),%rax
    de3a:	48 05 28 02 00 00    	add    $0x228,%rax
    de40:	eb 2d                	jmp    de6f <fwp_drop0+0x7f>
    de42:	66 66 66 66 66 2e 0f 	data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    de49:	1f 84 00 00 00 00 00 
    de50:	40 80 fe 01          	cmp    $0x1,%sil
    de54:	75 4f                	jne    dea5 <fwp_drop0+0xb5>
    de56:	48 8d 34 11          	lea    (%rcx,%rdx,1),%rsi
    de5a:	8b 4c 11 20          	mov    0x20(%rcx,%rdx,1),%ecx
    de5e:	48 0f af c1          	imul   %rcx,%rax
    de62:	48 c1 e8 20          	shr    $0x20,%rax
    de66:	48 01 f0             	add    %rsi,%rax
    de69:	48 05 28 02 00 00    	add    $0x228,%rax
    de6f:	0f b6 08             	movzbl (%rax),%ecx
    de72:	85 c9                	test   %ecx,%ecx
    de74:	74 2f                	je     dea5 <fwp_drop0+0xb5>
    de76:	83 f9 01             	cmp    $0x1,%ecx
    de79:	75 2c                	jne    dea7 <fwp_drop0+0xb7>
    de7b:	48 8b 5f 10          	mov    0x10(%rdi),%rbx
    de7f:	e8 8c ca ff ff       	call   a910 <fwp_rc_free_obj>
    de84:	48 89 d8             	mov    %rbx,%rax
    de87:	48 2b 05 22 53 00 00 	sub    0x5322(%rip),%rax        # 131b0 <fwp_gc+0x1030>
    de8e:	48 8b 0d 43 53 00 00 	mov    0x5343(%rip),%rcx        # 131d8 <fwp_gc+0x1058>
    de95:	48 c1 e1 10          	shl    $0x10,%rcx
    de99:	48 89 df             	mov    %rbx,%rdi
    de9c:	48 39 c8             	cmp    %rcx,%rax
    de9f:	0f 82 6a ff ff ff    	jb     de0f <fwp_drop0+0x1f>
    dea5:	5b                   	pop    %rbx
    dea6:	c3                   	ret
    dea7:	81 f9 ff 00 00 00    	cmp    $0xff,%ecx
    dead:	74 06                	je     deb5 <fwp_drop0+0xc5>
    deaf:	fe c9                	dec    %cl
    deb1:	88 08                	mov    %cl,(%rax)
    deb3:	5b                   	pop    %rbx
    deb4:	c3                   	ret
    deb5:	48 89 c7             	mov    %rax,%rdi
    deb8:	5b                   	pop    %rbx
    deb9:	e9 72 c7 ff ff       	jmp    a630 <fwp_rc_wide_drop>
    debe:	66 90                	xchg   %ax,%ax

000000000000dec0 <fwp_drop4>:
    dec0:	53                   	push   %rbx
    dec1:	48 89 f8             	mov    %rdi,%rax
    dec4:	48 2b 05 e5 52 00 00 	sub    0x52e5(%rip),%rax        # 131b0 <fwp_gc+0x1030>
    decb:	48 8b 0d 06 53 00 00 	mov    0x5306(%rip),%rcx        # 131d8 <fwp_gc+0x1058>
    ded2:	48 c1 e1 10          	shl    $0x10,%rcx
    ded6:	48 39 c8             	cmp    %rcx,%rax
    ded9:	0f 83 96 00 00 00    	jae    df75 <fwp_drop4+0xb5>
    dedf:	48 8b 0d 12 53 00 00 	mov    0x5312(%rip),%rcx        # 131f8 <fwp_gc+0x1078>
    dee6:	48 89 c2             	mov    %rax,%rdx
    dee9:	48 c1 ea 10          	shr    $0x10,%rdx
    deed:	48 69 d2 28 12 00 00 	imul   $0x1228,%rdx,%rdx
    def4:	0f b6 34 11          	movzbl (%rcx,%rdx,1),%esi
    def8:	48 25 ff ff 00 00    	and    $0xffff,%rax
    defe:	75 20                	jne    df20 <fwp_drop4+0x60>
    df00:	40 80 fe 02          	cmp    $0x2,%sil
    df04:	75 1a                	jne    df20 <fwp_drop4+0x60>
    df06:	48 8d 04 11          	lea    (%rcx,%rdx,1),%rax
    df0a:	48 05 28 02 00 00    	add    $0x228,%rax
    df10:	eb 2d                	jmp    df3f <fwp_drop4+0x7f>
    df12:	66 66 66 66 66 2e 0f 	data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    df19:	1f 84 00 00 00 00 00 
    df20:	40 80 fe 01          	cmp    $0x1,%sil
    df24:	75 4f                	jne    df75 <fwp_drop4+0xb5>
    df26:	48 8d 34 11          	lea    (%rcx,%rdx,1),%rsi
    df2a:	8b 4c 11 20          	mov    0x20(%rcx,%rdx,1),%ecx
    df2e:	48 0f af c1          	imul   %rcx,%rax
    df32:	48 c1 e8 20          	shr    $0x20,%rax
    df36:	48 01 f0             	add    %rsi,%rax
    df39:	48 05 28 02 00 00    	add    $0x228,%rax
    df3f:	0f b6 08             	movzbl (%rax),%ecx
    df42:	85 c9                	test   %ecx,%ecx
    df44:	74 2f                	je     df75 <fwp_drop4+0xb5>
    df46:	83 f9 01             	cmp    $0x1,%ecx
    df49:	75 2c                	jne    df77 <fwp_drop4+0xb7>
    df4b:	48 8b 5f 10          	mov    0x10(%rdi),%rbx
    df4f:	e8 bc c9 ff ff       	call   a910 <fwp_rc_free_obj>
    df54:	48 89 d8             	mov    %rbx,%rax
    df57:	48 2b 05 52 52 00 00 	sub    0x5252(%rip),%rax        # 131b0 <fwp_gc+0x1030>
    df5e:	48 8b 0d 73 52 00 00 	mov    0x5273(%rip),%rcx        # 131d8 <fwp_gc+0x1058>
    df65:	48 c1 e1 10          	shl    $0x10,%rcx
    df69:	48 89 df             	mov    %rbx,%rdi
    df6c:	48 39 c8             	cmp    %rcx,%rax
    df6f:	0f 82 6a ff ff ff    	jb     dedf <fwp_drop4+0x1f>
    df75:	5b                   	pop    %rbx
    df76:	c3                   	ret
    df77:	81 f9 ff 00 00 00    	cmp    $0xff,%ecx
    df7d:	74 06                	je     df85 <fwp_drop4+0xc5>
    df7f:	fe c9                	dec    %cl
    df81:	88 08                	mov    %cl,(%rax)
    df83:	5b                   	pop    %rbx
    df84:	c3                   	ret
    df85:	48 89 c7             	mov    %rax,%rdi
    df88:	5b                   	pop    %rbx
    df89:	e9 a2 c6 ff ff       	jmp    a630 <fwp_rc_wide_drop>
    df8e:	66 90                	xchg   %ax,%ax

000000000000df90 <__divti3>:
    df90:	f3 0f 1e fa          	endbr64
    df94:	55                   	push   %rbp
    df95:	49 89 f8             	mov    %rdi,%r8
    df98:	49 89 d2             	mov    %rdx,%r10
    df9b:	49 89 cb             	mov    %rcx,%r11
    df9e:	31 ff                	xor    %edi,%edi
    dfa0:	48 89 e5             	mov    %rsp,%rbp
    dfa3:	41 56                	push   %r14
    dfa5:	53                   	push   %rbx
    dfa6:	48 85 f6             	test   %rsi,%rsi
    dfa9:	79 13                	jns    dfbe <__divti3+0x2e>
    dfab:	45 31 c9             	xor    %r9d,%r9d
    dfae:	49 f7 d8             	neg    %r8
    dfb1:	48 c7 c7 ff ff ff ff 	mov    $0xffffffffffffffff,%rdi
    dfb8:	49 19 f1             	sbb    %rsi,%r9
    dfbb:	4c 89 ce             	mov    %r9,%rsi
    dfbe:	4c 89 da             	mov    %r11,%rdx
    dfc1:	4d 85 db             	test   %r11,%r11
    dfc4:	0f 88 f6 00 00 00    	js     e0c0 <__divti3+0x130>
    dfca:	4d 89 d6             	mov    %r10,%r14
    dfcd:	75 31                	jne    e000 <__divti3+0x70>
    dfcf:	4c 39 f6             	cmp    %r14,%rsi
    dfd2:	0f 83 b8 00 00 00    	jae    e090 <__divti3+0x100>
    dfd8:	48 89 f2             	mov    %rsi,%rdx
    dfdb:	31 f6                	xor    %esi,%esi
    dfdd:	4c 89 c0             	mov    %r8,%rax
    dfe0:	49 f7 f6             	div    %r14
    dfe3:	48 89 f2             	mov    %rsi,%rdx
    dfe6:	48 85 ff             	test   %rdi,%rdi
    dfe9:	74 0a                	je     dff5 <__divti3+0x65>
    dfeb:	48 f7 d8             	neg    %rax
    dfee:	48 83 d2 00          	adc    $0x0,%rdx
    dff2:	48 f7 da             	neg    %rdx
    dff5:	5b                   	pop    %rbx
    dff6:	41 5e                	pop    %r14
    dff8:	5d                   	pop    %rbp
    dff9:	c3                   	ret
    dffa:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)
    e000:	4c 39 de             	cmp    %r11,%rsi
    e003:	0f 82 d5 00 00 00    	jb     e0de <__divti3+0x14e>
    e009:	4d 0f bd d3          	bsr    %r11,%r10
    e00d:	41 83 f2 3f          	xor    $0x3f,%r10d
    e011:	44 89 d1             	mov    %r10d,%ecx
    e014:	b8 40 00 00 00       	mov    $0x40,%eax
    e019:	4c 89 f3             	mov    %r14,%rbx
    e01c:	4d 89 f1             	mov    %r14,%r9
    e01f:	48 d3 e2             	shl    %cl,%rdx
    e022:	49 63 ca             	movslq %r10d,%rcx
    e025:	49 89 f3             	mov    %rsi,%r11
    e028:	48 29 c8             	sub    %rcx,%rax
    e02b:	89 c1                	mov    %eax,%ecx
    e02d:	48 d3 eb             	shr    %cl,%rbx
    e030:	44 89 d1             	mov    %r10d,%ecx
    e033:	49 d3 e1             	shl    %cl,%r9
    e036:	89 c1                	mov    %eax,%ecx
    e038:	48 09 d3             	or     %rdx,%rbx
    e03b:	4c 89 c2             	mov    %r8,%rdx
    e03e:	49 d3 eb             	shr    %cl,%r11
    e041:	44 89 d1             	mov    %r10d,%ecx
    e044:	48 d3 e6             	shl    %cl,%rsi
    e047:	89 c1                	mov    %eax,%ecx
    e049:	48 d3 ea             	shr    %cl,%rdx
    e04c:	48 89 d0             	mov    %rdx,%rax
    e04f:	4c 89 da             	mov    %r11,%rdx
    e052:	48 09 f0             	or     %rsi,%rax
    e055:	48 f7 f3             	div    %rbx
    e058:	49 89 d3             	mov    %rdx,%r11
    e05b:	48 89 c6             	mov    %rax,%rsi
    e05e:	49 f7 e1             	mul    %r9
    e061:	49 39 d3             	cmp    %rdx,%r11
    e064:	0f 82 be 00 00 00    	jb     e128 <__divti3+0x198>
    e06a:	44 89 d1             	mov    %r10d,%ecx
    e06d:	49 d3 e0             	shl    %cl,%r8
    e070:	49 39 c0             	cmp    %rax,%r8
    e073:	73 09                	jae    e07e <__divti3+0xee>
    e075:	49 39 d3             	cmp    %rdx,%r11
    e078:	0f 84 aa 00 00 00    	je     e128 <__divti3+0x198>
    e07e:	48 89 f0             	mov    %rsi,%rax
    e081:	31 f6                	xor    %esi,%esi
    e083:	e9 5b ff ff ff       	jmp    dfe3 <__divti3+0x53>
    e088:	0f 1f 84 00 00 00 00 	nopl   0x0(%rax,%rax,1)
    e08f:	00 
    e090:	4d 85 f6             	test   %r14,%r14
    e093:	75 0d                	jne    e0a2 <__divti3+0x112>
    e095:	b8 01 00 00 00       	mov    $0x1,%eax
    e09a:	31 d2                	xor    %edx,%edx
    e09c:	49 f7 f6             	div    %r14
    e09f:	49 89 c6             	mov    %rax,%r14
    e0a2:	48 89 f0             	mov    %rsi,%rax
    e0a5:	31 d2                	xor    %edx,%edx
    e0a7:	49 f7 f6             	div    %r14
    e0aa:	48 89 c6             	mov    %rax,%rsi
    e0ad:	4c 89 c0             	mov    %r8,%rax
    e0b0:	49 f7 f6             	div    %r14
    e0b3:	e9 2b ff ff ff       	jmp    dfe3 <__divti3+0x53>
    e0b8:	0f 1f 84 00 00 00 00 	nopl   0x0(%rax,%rax,1)
    e0bf:	00 
    e0c0:	49 f7 da             	neg    %r10
    e0c3:	48 f7 d7             	not    %rdi
    e0c6:	49 83 d3 00          	adc    $0x0,%r11
    e0ca:	4d 89 d6             	mov    %r10,%r14
    e0cd:	49 f7 db             	neg    %r11
    e0d0:	4c 89 da             	mov    %r11,%rdx
    e0d3:	0f 84 f6 fe ff ff    	je     dfcf <__divti3+0x3f>
    e0d9:	4c 39 de             	cmp    %r11,%rsi
    e0dc:	73 12                	jae    e0f0 <__divti3+0x160>
    e0de:	31 f6                	xor    %esi,%esi
    e0e0:	31 c0                	xor    %eax,%eax
    e0e2:	e9 fc fe ff ff       	jmp    dfe3 <__divti3+0x53>
    e0e7:	66 0f 1f 84 00 00 00 	nopw   0x0(%rax,%rax,1)
    e0ee:	00 00 
    e0f0:	49 0f bd c3          	bsr    %r11,%rax
    e0f4:	48 83 f0 3f          	xor    $0x3f,%rax
    e0f8:	41 89 c2             	mov    %eax,%r10d
    e0fb:	85 c0                	test   %eax,%eax
    e0fd:	0f 85 0e ff ff ff    	jne    e011 <__divti3+0x81>
    e103:	49 39 f3             	cmp    %rsi,%r11
    e106:	72 0d                	jb     e115 <__divti3+0x185>
    e108:	31 f6                	xor    %esi,%esi
    e10a:	31 c0                	xor    %eax,%eax
    e10c:	4d 39 f0             	cmp    %r14,%r8
    e10f:	0f 82 ce fe ff ff    	jb     dfe3 <__divti3+0x53>
    e115:	31 f6                	xor    %esi,%esi
    e117:	b8 01 00 00 00       	mov    $0x1,%eax
    e11c:	e9 c2 fe ff ff       	jmp    dfe3 <__divti3+0x53>
    e121:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)
    e128:	48 8d 46 ff          	lea    -0x1(%rsi),%rax
    e12c:	31 f6                	xor    %esi,%esi
    e12e:	e9 b0 fe ff ff       	jmp    dfe3 <__divti3+0x53>
    e133:	66 2e 0f 1f 84 00 00 	cs nopw 0x0(%rax,%rax,1)
    e13a:	00 00 00 
    e13d:	0f 1f 00             	nopl   (%rax)

000000000000e140 <atexit>:
    e140:	f3 0f 1e fa          	endbr64
    e144:	48 8b 15 25 40 00 00 	mov    0x4025(%rip),%rdx        # 12170 <__dso_handle>
    e14b:	31 f6                	xor    %esi,%esi
    e14d:	e9 1e 41 ff ff       	jmp    2270 <__cxa_atexit@plt>

Disassembly of section .fini:

000000000000e154 <_fini>:
    e154:	f3 0f 1e fa          	endbr64
    e158:	48 83 ec 08          	sub    $0x8,%rsp
    e15c:	48 83 c4 08          	add    $0x8,%rsp
    e160:	c3                   	ret
