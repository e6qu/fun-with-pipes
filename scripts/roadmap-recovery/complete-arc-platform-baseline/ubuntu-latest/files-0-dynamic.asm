
/tmp/fwp-arc-3991/files-0-dynamic-O2:     file format elf64-x86-64


Disassembly of section .init:

0000000000002000 <_init>:
    2000:	f3 0f 1e fa          	endbr64
    2004:	48 83 ec 08          	sub    $0x8,%rsp
    2008:	48 8b 05 b9 cf 00 00 	mov    0xcfb9(%rip),%rax        # efc8 <__gmon_start__@Base>
    200f:	48 85 c0             	test   %rax,%rax
    2012:	74 02                	je     2016 <_init+0x16>
    2014:	ff d0                	call   *%rax
    2016:	48 83 c4 08          	add    $0x8,%rsp
    201a:	c3                   	ret

Disassembly of section .plt:

0000000000002020 <getenv@plt-0x10>:
    2020:	ff 35 ca cf 00 00    	push   0xcfca(%rip)        # eff0 <_GLOBAL_OFFSET_TABLE_+0x8>
    2026:	ff 25 cc cf 00 00    	jmp    *0xcfcc(%rip)        # eff8 <_GLOBAL_OFFSET_TABLE_+0x10>
    202c:	0f 1f 40 00          	nopl   0x0(%rax)

0000000000002030 <getenv@plt>:
    2030:	ff 25 ca cf 00 00    	jmp    *0xcfca(%rip)        # f000 <getenv@GLIBC_2.2.5>
    2036:	68 00 00 00 00       	push   $0x0
    203b:	e9 e0 ff ff ff       	jmp    2020 <_init+0x20>

0000000000002040 <dl_iterate_phdr@plt>:
    2040:	ff 25 c2 cf 00 00    	jmp    *0xcfc2(%rip)        # f008 <dl_iterate_phdr@GLIBC_2.2.5>
    2046:	68 01 00 00 00       	push   $0x1
    204b:	e9 d0 ff ff ff       	jmp    2020 <_init+0x20>

0000000000002050 <free@plt>:
    2050:	ff 25 ba cf 00 00    	jmp    *0xcfba(%rip)        # f010 <free@GLIBC_2.2.5>
    2056:	68 02 00 00 00       	push   $0x2
    205b:	e9 c0 ff ff ff       	jmp    2020 <_init+0x20>

0000000000002060 <abort@plt>:
    2060:	ff 25 b2 cf 00 00    	jmp    *0xcfb2(%rip)        # f018 <abort@GLIBC_2.2.5>
    2066:	68 03 00 00 00       	push   $0x3
    206b:	e9 b0 ff ff ff       	jmp    2020 <_init+0x20>

0000000000002070 <__errno_location@plt>:
    2070:	ff 25 aa cf 00 00    	jmp    *0xcfaa(%rip)        # f020 <__errno_location@GLIBC_2.2.5>
    2076:	68 04 00 00 00       	push   $0x4
    207b:	e9 a0 ff ff ff       	jmp    2020 <_init+0x20>

0000000000002080 <_exit@plt>:
    2080:	ff 25 a2 cf 00 00    	jmp    *0xcfa2(%rip)        # f028 <_exit@GLIBC_2.2.5>
    2086:	68 05 00 00 00       	push   $0x5
    208b:	e9 90 ff ff ff       	jmp    2020 <_init+0x20>

0000000000002090 <strcpy@plt>:
    2090:	ff 25 9a cf 00 00    	jmp    *0xcf9a(%rip)        # f030 <strcpy@GLIBC_2.2.5>
    2096:	68 06 00 00 00       	push   $0x6
    209b:	e9 80 ff ff ff       	jmp    2020 <_init+0x20>

00000000000020a0 <ferror@plt>:
    20a0:	ff 25 92 cf 00 00    	jmp    *0xcf92(%rip)        # f038 <ferror@GLIBC_2.2.5>
    20a6:	68 07 00 00 00       	push   $0x7
    20ab:	e9 70 ff ff ff       	jmp    2020 <_init+0x20>

00000000000020b0 <sigaction@plt>:
    20b0:	ff 25 8a cf 00 00    	jmp    *0xcf8a(%rip)        # f040 <sigaction@GLIBC_2.2.5>
    20b6:	68 08 00 00 00       	push   $0x8
    20bb:	e9 60 ff ff ff       	jmp    2020 <_init+0x20>

00000000000020c0 <fread@plt>:
    20c0:	ff 25 82 cf 00 00    	jmp    *0xcf82(%rip)        # f048 <fread@GLIBC_2.2.5>
    20c6:	68 09 00 00 00       	push   $0x9
    20cb:	e9 50 ff ff ff       	jmp    2020 <_init+0x20>

00000000000020d0 <strtod@plt>:
    20d0:	ff 25 7a cf 00 00    	jmp    *0xcf7a(%rip)        # f050 <strtod@GLIBC_2.2.5>
    20d6:	68 0a 00 00 00       	push   $0xa
    20db:	e9 40 ff ff ff       	jmp    2020 <_init+0x20>

00000000000020e0 <clock_gettime@plt>:
    20e0:	ff 25 72 cf 00 00    	jmp    *0xcf72(%rip)        # f058 <clock_gettime@GLIBC_2.17>
    20e6:	68 0b 00 00 00       	push   $0xb
    20eb:	e9 30 ff ff ff       	jmp    2020 <_init+0x20>

00000000000020f0 <write@plt>:
    20f0:	ff 25 6a cf 00 00    	jmp    *0xcf6a(%rip)        # f060 <write@GLIBC_2.2.5>
    20f6:	68 0c 00 00 00       	push   $0xc
    20fb:	e9 20 ff ff ff       	jmp    2020 <_init+0x20>

0000000000002100 <fclose@plt>:
    2100:	ff 25 62 cf 00 00    	jmp    *0xcf62(%rip)        # f068 <fclose@GLIBC_2.2.5>
    2106:	68 0d 00 00 00       	push   $0xd
    210b:	e9 10 ff ff ff       	jmp    2020 <_init+0x20>

0000000000002110 <strlen@plt>:
    2110:	ff 25 5a cf 00 00    	jmp    *0xcf5a(%rip)        # f070 <strlen@GLIBC_2.2.5>
    2116:	68 0e 00 00 00       	push   $0xe
    211b:	e9 00 ff ff ff       	jmp    2020 <_init+0x20>

0000000000002120 <mmap@plt>:
    2120:	ff 25 52 cf 00 00    	jmp    *0xcf52(%rip)        # f078 <mmap@GLIBC_2.2.5>
    2126:	68 0f 00 00 00       	push   $0xf
    212b:	e9 f0 fe ff ff       	jmp    2020 <_init+0x20>

0000000000002130 <strchr@plt>:
    2130:	ff 25 4a cf 00 00    	jmp    *0xcf4a(%rip)        # f080 <strchr@GLIBC_2.2.5>
    2136:	68 10 00 00 00       	push   $0x10
    213b:	e9 e0 fe ff ff       	jmp    2020 <_init+0x20>

0000000000002140 <snprintf@plt>:
    2140:	ff 25 42 cf 00 00    	jmp    *0xcf42(%rip)        # f088 <snprintf@GLIBC_2.2.5>
    2146:	68 11 00 00 00       	push   $0x11
    214b:	e9 d0 fe ff ff       	jmp    2020 <_init+0x20>

0000000000002150 <strtof@plt>:
    2150:	ff 25 3a cf 00 00    	jmp    *0xcf3a(%rip)        # f090 <strtof@GLIBC_2.2.5>
    2156:	68 12 00 00 00       	push   $0x12
    215b:	e9 c0 fe ff ff       	jmp    2020 <_init+0x20>

0000000000002160 <memset@plt>:
    2160:	ff 25 32 cf 00 00    	jmp    *0xcf32(%rip)        # f098 <memset@GLIBC_2.2.5>
    2166:	68 13 00 00 00       	push   $0x13
    216b:	e9 b0 fe ff ff       	jmp    2020 <_init+0x20>

0000000000002170 <fputc@plt>:
    2170:	ff 25 2a cf 00 00    	jmp    *0xcf2a(%rip)        # f0a0 <fputc@GLIBC_2.2.5>
    2176:	68 14 00 00 00       	push   $0x14
    217b:	e9 a0 fe ff ff       	jmp    2020 <_init+0x20>

0000000000002180 <pthread_attr_init@plt>:
    2180:	ff 25 22 cf 00 00    	jmp    *0xcf22(%rip)        # f0a8 <pthread_attr_init@GLIBC_2.2.5>
    2186:	68 15 00 00 00       	push   $0x15
    218b:	e9 90 fe ff ff       	jmp    2020 <_init+0x20>

0000000000002190 <fgets@plt>:
    2190:	ff 25 1a cf 00 00    	jmp    *0xcf1a(%rip)        # f0b0 <fgets@GLIBC_2.2.5>
    2196:	68 16 00 00 00       	push   $0x16
    219b:	e9 80 fe ff ff       	jmp    2020 <_init+0x20>

00000000000021a0 <_setjmp@plt>:
    21a0:	ff 25 12 cf 00 00    	jmp    *0xcf12(%rip)        # f0b8 <_setjmp@GLIBC_2.2.5>
    21a6:	68 17 00 00 00       	push   $0x17
    21ab:	e9 70 fe ff ff       	jmp    2020 <_init+0x20>

00000000000021b0 <strtoull@plt>:
    21b0:	ff 25 0a cf 00 00    	jmp    *0xcf0a(%rip)        # f0c0 <strtoull@GLIBC_2.2.5>
    21b6:	68 18 00 00 00       	push   $0x18
    21bb:	e9 60 fe ff ff       	jmp    2020 <_init+0x20>

00000000000021c0 <strcmp@plt>:
    21c0:	ff 25 02 cf 00 00    	jmp    *0xcf02(%rip)        # f0c8 <strcmp@GLIBC_2.2.5>
    21c6:	68 19 00 00 00       	push   $0x19
    21cb:	e9 50 fe ff ff       	jmp    2020 <_init+0x20>

00000000000021d0 <signal@plt>:
    21d0:	ff 25 fa ce 00 00    	jmp    *0xcefa(%rip)        # f0d0 <signal@GLIBC_2.2.5>
    21d6:	68 1a 00 00 00       	push   $0x1a
    21db:	e9 40 fe ff ff       	jmp    2020 <_init+0x20>

00000000000021e0 <fprintf@plt>:
    21e0:	ff 25 f2 ce 00 00    	jmp    *0xcef2(%rip)        # f0d8 <fprintf@GLIBC_2.2.5>
    21e6:	68 1b 00 00 00       	push   $0x1b
    21eb:	e9 30 fe ff ff       	jmp    2020 <_init+0x20>

00000000000021f0 <sigemptyset@plt>:
    21f0:	ff 25 ea ce 00 00    	jmp    *0xceea(%rip)        # f0e0 <sigemptyset@GLIBC_2.2.5>
    21f6:	68 1c 00 00 00       	push   $0x1c
    21fb:	e9 20 fe ff ff       	jmp    2020 <_init+0x20>

0000000000002200 <strtol@plt>:
    2200:	ff 25 e2 ce 00 00    	jmp    *0xcee2(%rip)        # f0e8 <strtol@GLIBC_2.2.5>
    2206:	68 1d 00 00 00       	push   $0x1d
    220b:	e9 10 fe ff ff       	jmp    2020 <_init+0x20>

0000000000002210 <memcpy@plt>:
    2210:	ff 25 da ce 00 00    	jmp    *0xceda(%rip)        # f0f0 <memcpy@GLIBC_2.14>
    2216:	68 1e 00 00 00       	push   $0x1e
    221b:	e9 00 fe ff ff       	jmp    2020 <_init+0x20>

0000000000002220 <malloc@plt>:
    2220:	ff 25 d2 ce 00 00    	jmp    *0xced2(%rip)        # f0f8 <malloc@GLIBC_2.2.5>
    2226:	68 1f 00 00 00       	push   $0x1f
    222b:	e9 f0 fd ff ff       	jmp    2020 <_init+0x20>

0000000000002230 <fflush@plt>:
    2230:	ff 25 ca ce 00 00    	jmp    *0xceca(%rip)        # f100 <fflush@GLIBC_2.2.5>
    2236:	68 20 00 00 00       	push   $0x20
    223b:	e9 e0 fd ff ff       	jmp    2020 <_init+0x20>

0000000000002240 <realloc@plt>:
    2240:	ff 25 c2 ce 00 00    	jmp    *0xcec2(%rip)        # f108 <realloc@GLIBC_2.2.5>
    2246:	68 21 00 00 00       	push   $0x21
    224b:	e9 d0 fd ff ff       	jmp    2020 <_init+0x20>

0000000000002250 <setvbuf@plt>:
    2250:	ff 25 ba ce 00 00    	jmp    *0xceba(%rip)        # f110 <setvbuf@GLIBC_2.2.5>
    2256:	68 22 00 00 00       	push   $0x22
    225b:	e9 c0 fd ff ff       	jmp    2020 <_init+0x20>

0000000000002260 <pthread_create@plt>:
    2260:	ff 25 b2 ce 00 00    	jmp    *0xceb2(%rip)        # f118 <pthread_create@GLIBC_2.34>
    2266:	68 23 00 00 00       	push   $0x23
    226b:	e9 b0 fd ff ff       	jmp    2020 <_init+0x20>

0000000000002270 <longjmp@plt>:
    2270:	ff 25 aa ce 00 00    	jmp    *0xceaa(%rip)        # f120 <longjmp@GLIBC_2.2.5>
    2276:	68 24 00 00 00       	push   $0x24
    227b:	e9 a0 fd ff ff       	jmp    2020 <_init+0x20>

0000000000002280 <mprotect@plt>:
    2280:	ff 25 a2 ce 00 00    	jmp    *0xcea2(%rip)        # f128 <mprotect@GLIBC_2.2.5>
    2286:	68 25 00 00 00       	push   $0x25
    228b:	e9 90 fd ff ff       	jmp    2020 <_init+0x20>

0000000000002290 <fopen@plt>:
    2290:	ff 25 9a ce 00 00    	jmp    *0xce9a(%rip)        # f130 <fopen@GLIBC_2.2.5>
    2296:	68 26 00 00 00       	push   $0x26
    229b:	e9 80 fd ff ff       	jmp    2020 <_init+0x20>

00000000000022a0 <sysconf@plt>:
    22a0:	ff 25 92 ce 00 00    	jmp    *0xce92(%rip)        # f138 <sysconf@GLIBC_2.2.5>
    22a6:	68 27 00 00 00       	push   $0x27
    22ab:	e9 70 fd ff ff       	jmp    2020 <_init+0x20>

00000000000022b0 <__cxa_atexit@plt>:
    22b0:	ff 25 8a ce 00 00    	jmp    *0xce8a(%rip)        # f140 <__cxa_atexit@GLIBC_2.2.5>
    22b6:	68 28 00 00 00       	push   $0x28
    22bb:	e9 60 fd ff ff       	jmp    2020 <_init+0x20>

00000000000022c0 <sprintf@plt>:
    22c0:	ff 25 82 ce 00 00    	jmp    *0xce82(%rip)        # f148 <sprintf@GLIBC_2.2.5>
    22c6:	68 29 00 00 00       	push   $0x29
    22cb:	e9 50 fd ff ff       	jmp    2020 <_init+0x20>

00000000000022d0 <exit@plt>:
    22d0:	ff 25 7a ce 00 00    	jmp    *0xce7a(%rip)        # f150 <exit@GLIBC_2.2.5>
    22d6:	68 2a 00 00 00       	push   $0x2a
    22db:	e9 40 fd ff ff       	jmp    2020 <_init+0x20>

00000000000022e0 <fwrite@plt>:
    22e0:	ff 25 72 ce 00 00    	jmp    *0xce72(%rip)        # f158 <fwrite@GLIBC_2.2.5>
    22e6:	68 2b 00 00 00       	push   $0x2b
    22eb:	e9 30 fd ff ff       	jmp    2020 <_init+0x20>

00000000000022f0 <getrlimit@plt>:
    22f0:	ff 25 6a ce 00 00    	jmp    *0xce6a(%rip)        # f160 <getrlimit@GLIBC_2.2.5>
    22f6:	68 2c 00 00 00       	push   $0x2c
    22fb:	e9 20 fd ff ff       	jmp    2020 <_init+0x20>

0000000000002300 <pthread_join@plt>:
    2300:	ff 25 62 ce 00 00    	jmp    *0xce62(%rip)        # f168 <pthread_join@GLIBC_2.34>
    2306:	68 2d 00 00 00       	push   $0x2d
    230b:	e9 10 fd ff ff       	jmp    2020 <_init+0x20>

0000000000002310 <sigaltstack@plt>:
    2310:	ff 25 5a ce 00 00    	jmp    *0xce5a(%rip)        # f170 <sigaltstack@GLIBC_2.2.5>
    2316:	68 2e 00 00 00       	push   $0x2e
    231b:	e9 00 fd ff ff       	jmp    2020 <_init+0x20>

0000000000002320 <strerror@plt>:
    2320:	ff 25 52 ce 00 00    	jmp    *0xce52(%rip)        # f178 <strerror@GLIBC_2.2.5>
    2326:	68 2f 00 00 00       	push   $0x2f
    232b:	e9 f0 fc ff ff       	jmp    2020 <_init+0x20>

0000000000002330 <strstr@plt>:
    2330:	ff 25 4a ce 00 00    	jmp    *0xce4a(%rip)        # f180 <strstr@GLIBC_2.2.5>
    2336:	68 30 00 00 00       	push   $0x30
    233b:	e9 e0 fc ff ff       	jmp    2020 <_init+0x20>

0000000000002340 <pthread_attr_setstacksize@plt>:
    2340:	ff 25 42 ce 00 00    	jmp    *0xce42(%rip)        # f188 <pthread_attr_setstacksize@GLIBC_2.34>
    2346:	68 31 00 00 00       	push   $0x31
    234b:	e9 d0 fc ff ff       	jmp    2020 <_init+0x20>

Disassembly of section .plt.got:

0000000000002350 <__cxa_finalize@plt>:
    2350:	ff 25 82 cc 00 00    	jmp    *0xcc82(%rip)        # efd8 <__cxa_finalize@GLIBC_2.2.5>
    2356:	66 90                	xchg   %ax,%ax

Disassembly of section .text:

0000000000002360 <_start>:
    2360:	f3 0f 1e fa          	endbr64
    2364:	31 ed                	xor    %ebp,%ebp
    2366:	49 89 d1             	mov    %rdx,%r9
    2369:	5e                   	pop    %rsi
    236a:	48 89 e2             	mov    %rsp,%rdx
    236d:	48 83 e4 f0          	and    $0xfffffffffffffff0,%rsp
    2371:	50                   	push   %rax
    2372:	54                   	push   %rsp
    2373:	45 31 c0             	xor    %r8d,%r8d
    2376:	31 c9                	xor    %ecx,%ecx
    2378:	48 8d 3d d1 00 00 00 	lea    0xd1(%rip),%rdi        # 2450 <main>
    237f:	ff 15 2b cc 00 00    	call   *0xcc2b(%rip)        # efb0 <__libc_start_main@GLIBC_2.34>
    2385:	f4                   	hlt
    2386:	66 2e 0f 1f 84 00 00 	cs nopw 0x0(%rax,%rax,1)
    238d:	00 00 00 

0000000000002390 <deregister_tm_clones>:
    2390:	48 8d 3d a1 e8 00 00 	lea    0xe8a1(%rip),%rdi        # 10c38 <__TMC_END__>
    2397:	48 8d 05 9a e8 00 00 	lea    0xe89a(%rip),%rax        # 10c38 <__TMC_END__>
    239e:	48 39 f8             	cmp    %rdi,%rax
    23a1:	74 15                	je     23b8 <deregister_tm_clones+0x28>
    23a3:	48 8b 05 0e cc 00 00 	mov    0xcc0e(%rip),%rax        # efb8 <_ITM_deregisterTMCloneTable@Base>
    23aa:	48 85 c0             	test   %rax,%rax
    23ad:	74 09                	je     23b8 <deregister_tm_clones+0x28>
    23af:	ff e0                	jmp    *%rax
    23b1:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)
    23b8:	c3                   	ret
    23b9:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)

00000000000023c0 <register_tm_clones>:
    23c0:	48 8d 3d 71 e8 00 00 	lea    0xe871(%rip),%rdi        # 10c38 <__TMC_END__>
    23c7:	48 8d 35 6a e8 00 00 	lea    0xe86a(%rip),%rsi        # 10c38 <__TMC_END__>
    23ce:	48 29 fe             	sub    %rdi,%rsi
    23d1:	48 89 f0             	mov    %rsi,%rax
    23d4:	48 c1 ee 3f          	shr    $0x3f,%rsi
    23d8:	48 c1 f8 03          	sar    $0x3,%rax
    23dc:	48 01 c6             	add    %rax,%rsi
    23df:	48 d1 fe             	sar    $1,%rsi
    23e2:	74 14                	je     23f8 <register_tm_clones+0x38>
    23e4:	48 8b 05 e5 cb 00 00 	mov    0xcbe5(%rip),%rax        # efd0 <_ITM_registerTMCloneTable@Base>
    23eb:	48 85 c0             	test   %rax,%rax
    23ee:	74 08                	je     23f8 <register_tm_clones+0x38>
    23f0:	ff e0                	jmp    *%rax
    23f2:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)
    23f8:	c3                   	ret
    23f9:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)

0000000000002400 <__do_global_dtors_aux>:
    2400:	f3 0f 1e fa          	endbr64
    2404:	80 3d 35 e8 00 00 00 	cmpb   $0x0,0xe835(%rip)        # 10c40 <completed.0>
    240b:	75 2b                	jne    2438 <__do_global_dtors_aux+0x38>
    240d:	55                   	push   %rbp
    240e:	48 83 3d c2 cb 00 00 	cmpq   $0x0,0xcbc2(%rip)        # efd8 <__cxa_finalize@GLIBC_2.2.5>
    2415:	00 
    2416:	48 89 e5             	mov    %rsp,%rbp
    2419:	74 0c                	je     2427 <__do_global_dtors_aux+0x27>
    241b:	48 8b 3d 76 cd 00 00 	mov    0xcd76(%rip),%rdi        # f198 <__dso_handle>
    2422:	e8 29 ff ff ff       	call   2350 <__cxa_finalize@plt>
    2427:	e8 64 ff ff ff       	call   2390 <deregister_tm_clones>
    242c:	c6 05 0d e8 00 00 01 	movb   $0x1,0xe80d(%rip)        # 10c40 <completed.0>
    2433:	5d                   	pop    %rbp
    2434:	c3                   	ret
    2435:	0f 1f 00             	nopl   (%rax)
    2438:	c3                   	ret
    2439:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)

0000000000002440 <frame_dummy>:
    2440:	f3 0f 1e fa          	endbr64
    2444:	e9 77 ff ff ff       	jmp    23c0 <register_tm_clones>
    2449:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)

0000000000002450 <main>:
    2450:	41 56                	push   %r14
    2452:	53                   	push   %rbx
    2453:	48 83 ec 58          	sub    $0x58,%rsp
    2457:	48 8d 05 e2 c5 00 00 	lea    0xc5e2(%rip),%rax        # ea40 <fwp_fn_table>
    245e:	48 89 05 eb e7 00 00 	mov    %rax,0xe7eb(%rip)        # 10c50 <fwp_fns>
    2465:	4c 8b 35 54 cb 00 00 	mov    0xcb54(%rip),%r14        # efc0 <stdout@GLIBC_2.2.5>
    246c:	49 8b 06             	mov    (%r14),%rax
    246f:	48 89 05 e2 e7 00 00 	mov    %rax,0xe7e2(%rip)        # 10c58 <fwp_prog_out>
    2476:	48 89 35 e3 e7 00 00 	mov    %rsi,0xe7e3(%rip)        # 10c60 <fwp_argv>
    247d:	48 8d 35 e4 e7 00 00 	lea    0xe7e4(%rip),%rsi        # 10c68 <fwp_start_time>
    2484:	bf 01 00 00 00       	mov    $0x1,%edi
    2489:	e8 52 fc ff ff       	call   20e0 <clock_gettime@plt>
    248e:	48 8d 3d b8 a1 00 00 	lea    0xa1b8(%rip),%rdi        # c64d <fwp_segv.msg+0x40d>
    2495:	e8 96 fb ff ff       	call   2030 <getenv@plt>
    249a:	48 85 c0             	test   %rax,%rax
    249d:	74 28                	je     24c7 <main+0x77>
    249f:	48 89 c3             	mov    %rax,%rbx
    24a2:	80 38 00             	cmpb   $0x0,(%rax)
    24a5:	74 20                	je     24c7 <main+0x77>
    24a7:	48 8d 74 24 08       	lea    0x8(%rsp),%rsi
    24ac:	48 89 df             	mov    %rbx,%rdi
    24af:	ba 0a 00 00 00       	mov    $0xa,%edx
    24b4:	e8 f7 fc ff ff       	call   21b0 <strtoull@plt>
    24b9:	48 8b 44 24 08       	mov    0x8(%rsp),%rax
    24be:	80 38 00             	cmpb   $0x0,(%rax)
    24c1:	0f 84 b5 00 00 00    	je     257c <main+0x12c>
    24c7:	48 8d 74 24 20       	lea    0x20(%rsp),%rsi
    24cc:	31 ff                	xor    %edi,%edi
    24ce:	e8 0d fc ff ff       	call   20e0 <clock_gettime@plt>
    24d3:	49 8b 3e             	mov    (%r14),%rdi
    24d6:	b9 00 00 01 00       	mov    $0x10000,%ecx
    24db:	31 f6                	xor    %esi,%esi
    24dd:	31 d2                	xor    %edx,%edx
    24df:	e8 6c fd ff ff       	call   2250 <setvbuf@plt>
    24e4:	be 01 00 00 00       	mov    $0x1,%esi
    24e9:	bf 0d 00 00 00       	mov    $0xd,%edi
    24ee:	e8 dd fc ff ff       	call   21d0 <signal@plt>
    24f3:	48 8d 5c 24 20       	lea    0x20(%rsp),%rbx
    24f8:	48 89 df             	mov    %rbx,%rdi
    24fb:	e8 80 fc ff ff       	call   2180 <pthread_attr_init@plt>
    2500:	48 8b 35 99 cc 00 00 	mov    0xcc99(%rip),%rsi        # f1a0 <fwp_main_stack>
    2507:	48 89 df             	mov    %rbx,%rdi
    250a:	e8 31 fe ff ff       	call   2340 <pthread_attr_setstacksize@plt>
    250f:	48 8d 15 8a 00 00 00 	lea    0x8a(%rip),%rdx        # 25a0 <fwp_main_thread>
    2516:	48 8d 7c 24 18       	lea    0x18(%rsp),%rdi
    251b:	48 89 de             	mov    %rbx,%rsi
    251e:	31 c9                	xor    %ecx,%ecx
    2520:	e8 3b fd ff ff       	call   2260 <pthread_create@plt>
    2525:	85 c0                	test   %eax,%eax
    2527:	74 35                	je     255e <main+0x10e>
    2529:	48 8d 74 24 08       	lea    0x8(%rsp),%rsi
    252e:	bf 03 00 00 00       	mov    $0x3,%edi
    2533:	e8 b8 fd ff ff       	call   22f0 <getrlimit@plt>
    2538:	48 8b 4c 24 08       	mov    0x8(%rsp),%rcx
    253d:	48 83 f9 ff          	cmp    $0xffffffffffffffff,%rcx
    2541:	ba 00 00 80 00       	mov    $0x800000,%edx
    2546:	48 0f 44 ca          	cmove  %rdx,%rcx
    254a:	85 c0                	test   %eax,%eax
    254c:	48 0f 45 ca          	cmovne %rdx,%rcx
    2550:	48 89 0d 49 cc 00 00 	mov    %rcx,0xcc49(%rip)        # f1a0 <fwp_main_stack>
    2557:	e8 44 00 00 00       	call   25a0 <fwp_main_thread>
    255c:	eb 0c                	jmp    256a <main+0x11a>
    255e:	48 8b 7c 24 18       	mov    0x18(%rsp),%rdi
    2563:	31 f6                	xor    %esi,%esi
    2565:	e8 96 fd ff ff       	call   2300 <pthread_join@plt>
    256a:	49 8b 3e             	mov    (%r14),%rdi
    256d:	e8 be fc ff ff       	call   2230 <fflush@plt>
    2572:	31 c0                	xor    %eax,%eax
    2574:	48 83 c4 58          	add    $0x58,%rsp
    2578:	5b                   	pop    %rbx
    2579:	41 5e                	pop    %r14
    257b:	c3                   	ret
    257c:	0f b6 03             	movzbl (%rbx),%eax
    257f:	83 f8 2d             	cmp    $0x2d,%eax
    2582:	0f 84 3f ff ff ff    	je     24c7 <main+0x77>
    2588:	83 f8 2b             	cmp    $0x2b,%eax
    258b:	0f 84 36 ff ff ff    	je     24c7 <main+0x77>
    2591:	e9 3d ff ff ff       	jmp    24d3 <main+0x83>
    2596:	66 2e 0f 1f 84 00 00 	cs nopw 0x0(%rax,%rax,1)
    259d:	00 00 00 

00000000000025a0 <fwp_main_thread>:
    25a0:	55                   	push   %rbp
    25a1:	48 89 e5             	mov    %rsp,%rbp
    25a4:	41 57                	push   %r15
    25a6:	41 56                	push   %r14
    25a8:	41 55                	push   %r13
    25aa:	41 54                	push   %r12
    25ac:	53                   	push   %rbx
    25ad:	48 81 ec d8 01 00 00 	sub    $0x1d8,%rsp
    25b4:	83 3d d9 db 00 00 00 	cmpl   $0x0,0xdbd9(%rip)        # 10194 <fwp_gc+0xfec>
    25bb:	75 05                	jne    25c2 <fwp_main_thread+0x22>
    25bd:	e8 3e 31 00 00       	call   5700 <fwp_gc_init>
    25c2:	48 89 2d 67 dc 00 00 	mov    %rbp,0xdc67(%rip)        # 10230 <fwp_gc+0x1088>
    25c9:	48 8d 3d a0 84 00 00 	lea    0x84a0(%rip),%rdi        # aa70 <fwp_gc_find_data>
    25d0:	31 f6                	xor    %esi,%esi
    25d2:	e8 69 fa ff ff       	call   2040 <dl_iterate_phdr@plt>
    25d7:	83 3d ba db 00 00 00 	cmpl   $0x0,0xdbba(%rip)        # 10198 <fwp_gc+0xff0>
    25de:	0f 95 c1             	setne  %cl
    25e1:	83 3d 50 dd 00 00 00 	cmpl   $0x0,0xdd50(%rip)        # 10338 <fwp_gc+0x1190>
    25e8:	0f 9f c0             	setg   %al
    25eb:	20 c8                	and    %cl,%al
    25ed:	0f b6 c8             	movzbl %al,%ecx
    25f0:	89 0d a6 db 00 00    	mov    %ecx,0xdba6(%rip)        # 1019c <fwp_gc+0xff4>
    25f6:	83 3d a7 db 00 00 00 	cmpl   $0x0,0xdba7(%rip)        # 101a4 <fwp_gc+0xffc>
    25fd:	74 16                	je     2615 <fwp_main_thread+0x75>
    25ff:	48 8d 3d 4a 85 00 00 	lea    0x854a(%rip),%rdi        # ab50 <fwp_gc_report>
    2606:	e8 b5 8d 00 00       	call   b3c0 <atexit>
    260b:	83 3d 8a db 00 00 00 	cmpl   $0x0,0xdb8a(%rip)        # 1019c <fwp_gc+0xff4>
    2612:	0f 95 c0             	setne  %al
    2615:	84 c0                	test   %al,%al
    2617:	74 43                	je     265c <fwp_main_thread+0xbc>
    2619:	48 83 3d a7 db 00 00 	cmpq   $0x0,0xdba7(%rip)        # 101c8 <fwp_gc+0x1020>
    2620:	00 
    2621:	74 39                	je     265c <fwp_main_thread+0xbc>
    2623:	48 8b 05 8e dd 00 00 	mov    0xdd8e(%rip),%rax        # 103b8 <fwp_gc+0x1210>
    262a:	48 2b 05 77 cb 00 00 	sub    0xcb77(%rip),%rax        # f1a8 <fwp_gc>
    2631:	f2 48 0f 2a c0       	cvtsi2sd %rax,%xmm0
    2636:	f2 0f 58 05 52 dd 00 	addsd  0xdd52(%rip),%xmm0        # 10390 <fwp_gc+0x11e8>
    263d:	00 
    263e:	f2 0f 11 05 4a dd 00 	movsd  %xmm0,0xdd4a(%rip)        # 10390 <fwp_gc+0x11e8>
    2645:	00 
    2646:	48 c7 05 67 dd 00 00 	movq   $0x0,0xdd67(%rip)        # 103b8 <fwp_gc+0x1210>
    264d:	00 00 00 00 
    2651:	48 c7 05 4c cb 00 00 	movq   $0x0,0xcb4c(%rip)        # f1a8 <fwp_gc>
    2658:	00 00 00 00 
    265c:	48 8b 05 3d cb 00 00 	mov    0xcb3d(%rip),%rax        # f1a0 <fwp_main_stack>
    2663:	4c 8d ad e8 fe ff ff 	lea    -0x118(%rbp),%r13
    266a:	4c 89 2d 1f e6 00 00 	mov    %r13,0xe61f(%rip)        # 10c90 <fwp_main_stack_top>
    2671:	48 89 05 20 e6 00 00 	mov    %rax,0xe620(%rip)        # 10c98 <fwp_main_stack_size>
    2678:	48 8d 05 21 e6 00 00 	lea    0xe621(%rip),%rax        # 10ca0 <fwp_stack_guard_init.alt>
    267f:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
    2683:	48 c7 45 d0 00 00 01 	movq   $0x10000,-0x30(%rbp)
    268a:	00 
    268b:	c7 45 c8 00 00 00 00 	movl   $0x0,-0x38(%rbp)
    2692:	4c 8d 75 c0          	lea    -0x40(%rbp),%r14
    2696:	4c 89 f7             	mov    %r14,%rdi
    2699:	31 f6                	xor    %esi,%esi
    269b:	e8 70 fc ff ff       	call   2310 <sigaltstack@plt>
    26a0:	85 c0                	test   %eax,%eax
    26a2:	0f 85 95 00 00 00    	jne    273d <fwp_main_thread+0x19d>
    26a8:	48 8d bd 10 fe ff ff 	lea    -0x1f0(%rbp),%rdi
    26af:	66 0f 57 c0          	xorpd  %xmm0,%xmm0
    26b3:	66 0f 11 85 90 fe ff 	movupd %xmm0,-0x170(%rbp)
    26ba:	ff 
    26bb:	66 0f 11 85 80 fe ff 	movupd %xmm0,-0x180(%rbp)
    26c2:	ff 
    26c3:	66 0f 11 85 70 fe ff 	movupd %xmm0,-0x190(%rbp)
    26ca:	ff 
    26cb:	66 0f 11 85 60 fe ff 	movupd %xmm0,-0x1a0(%rbp)
    26d2:	ff 
    26d3:	66 0f 11 85 50 fe ff 	movupd %xmm0,-0x1b0(%rbp)
    26da:	ff 
    26db:	66 0f 11 85 40 fe ff 	movupd %xmm0,-0x1c0(%rbp)
    26e2:	ff 
    26e3:	66 0f 11 85 30 fe ff 	movupd %xmm0,-0x1d0(%rbp)
    26ea:	ff 
    26eb:	66 0f 11 85 20 fe ff 	movupd %xmm0,-0x1e0(%rbp)
    26f2:	ff 
    26f3:	66 0f 11 85 10 fe ff 	movupd %xmm0,-0x1f0(%rbp)
    26fa:	ff 
    26fb:	48 8d 05 9e 86 00 00 	lea    0x869e(%rip),%rax        # ada0 <fwp_segv>
    2702:	48 89 85 08 fe ff ff 	mov    %rax,-0x1f8(%rbp)
    2709:	c7 85 90 fe ff ff 04 	movl   $0x8000004,-0x170(%rbp)
    2710:	00 00 08 
    2713:	e8 d8 fa ff ff       	call   21f0 <sigemptyset@plt>
    2718:	48 8d 9d 08 fe ff ff 	lea    -0x1f8(%rbp),%rbx
    271f:	bf 0b 00 00 00       	mov    $0xb,%edi
    2724:	48 89 de             	mov    %rbx,%rsi
    2727:	31 d2                	xor    %edx,%edx
    2729:	e8 82 f9 ff ff       	call   20b0 <sigaction@plt>
    272e:	bf 07 00 00 00       	mov    $0x7,%edi
    2733:	48 89 de             	mov    %rbx,%rsi
    2736:	31 d2                	xor    %edx,%edx
    2738:	e8 73 f9 ff ff       	call   20b0 <sigaction@plt>
    273d:	48 8b 15 64 ca 00 00 	mov    0xca64(%rip),%rdx        # f1a8 <fwp_gc>
    2744:	80 3d 55 e5 01 00 00 	cmpb   $0x0,0x1e555(%rip)        # 20ca0 <caf0.st>
    274b:	48 89 d0             	mov    %rdx,%rax
    274e:	0f 85 12 07 00 00    	jne    2e66 <fwp_main_thread+0x8c6>
    2754:	48 89 55 b8          	mov    %rdx,-0x48(%rbp)
    2758:	48 8d 05 79 e4 00 00 	lea    0xe479(%rip),%rax        # 10bd8 <fc3>
    275f:	48 89 85 b8 fe ff ff 	mov    %rax,-0x148(%rbp)
    2766:	48 8d 05 73 e4 00 00 	lea    0xe473(%rip),%rax        # 10be0 <fc4>
    276d:	48 89 85 c0 fe ff ff 	mov    %rax,-0x140(%rbp)
    2774:	48 8d 3d 55 e4 00 00 	lea    0xe455(%rip),%rdi        # 10bd0 <fc2>
    277b:	48 8d 95 b8 fe ff ff 	lea    -0x148(%rbp),%rdx
    2782:	be 02 00 00 00       	mov    $0x2,%esi
    2787:	e8 34 23 00 00       	call   4ac0 <fwp_apply_owned>
    278c:	49 89 c7             	mov    %rax,%r15
    278f:	48 89 85 78 ff ff ff 	mov    %rax,-0x88(%rbp)
    2796:	48 8b 05 db e4 00 00 	mov    0xe4db(%rip),%rax        # 10c78 <fwp_cleanups>
    279d:	48 89 85 08 fe ff ff 	mov    %rax,-0x1f8(%rbp)
    27a4:	48 8d 05 55 86 00 00 	lea    0x8655(%rip),%rax        # ae00 <fwp_owner_release0>
    27ab:	48 89 85 10 fe ff ff 	mov    %rax,-0x1f0(%rbp)
    27b2:	48 8d 85 78 ff ff ff 	lea    -0x88(%rbp),%rax
    27b9:	48 89 85 18 fe ff ff 	mov    %rax,-0x1e8(%rbp)
    27c0:	48 8d 9d 08 fe ff ff 	lea    -0x1f8(%rbp),%rbx
    27c7:	48 89 1d aa e4 00 00 	mov    %rbx,0xe4aa(%rip)        # 10c78 <fwp_cleanups>
    27ce:	48 8d 35 13 e4 00 00 	lea    0xe413(%rip),%rsi        # 10be8 <s0>
    27d5:	4c 89 ff             	mov    %r15,%rdi
    27d8:	e8 b3 11 00 00       	call   3990 <fwp_p_attempt_owned>
    27dd:	48 39 1d 94 e4 00 00 	cmp    %rbx,0xe494(%rip)        # 10c78 <fwp_cleanups>
    27e4:	0f 85 e0 06 00 00    	jne    2eca <fwp_main_thread+0x92a>
    27ea:	49 89 c4             	mov    %rax,%r12
    27ed:	48 8b 85 08 fe ff ff 	mov    -0x1f8(%rbp),%rax
    27f4:	48 89 05 7d e4 00 00 	mov    %rax,0xe47d(%rip)        # 10c78 <fwp_cleanups>
    27fb:	48 8d 05 e6 e3 00 00 	lea    0xe3e6(%rip),%rax        # 10be8 <s0>
    2802:	4c 89 ff             	mov    %r15,%rdi
    2805:	e8 e6 38 00 00       	call   60f0 <fwp_closure_drop>
    280a:	4c 89 65 80          	mov    %r12,-0x80(%rbp)
    280e:	48 8b 05 63 e4 00 00 	mov    0xe463(%rip),%rax        # 10c78 <fwp_cleanups>
    2815:	48 89 45 c0          	mov    %rax,-0x40(%rbp)
    2819:	48 8d 05 f0 85 00 00 	lea    0x85f0(%rip),%rax        # ae10 <fwp_owner_release1>
    2820:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
    2824:	48 8d 45 80          	lea    -0x80(%rbp),%rax
    2828:	48 89 45 d0          	mov    %rax,-0x30(%rbp)
    282c:	4c 89 35 45 e4 00 00 	mov    %r14,0xe445(%rip)        # 10c78 <fwp_cleanups>
    2833:	4c 89 e7             	mov    %r12,%rdi
    2836:	e8 65 81 00 00       	call   a9a0 <f8>
    283b:	4c 39 35 36 e4 00 00 	cmp    %r14,0xe436(%rip)        # 10c78 <fwp_cleanups>
    2842:	0f 85 82 06 00 00    	jne    2eca <fwp_main_thread+0x92a>
    2848:	49 89 c7             	mov    %rax,%r15
    284b:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
    284f:	48 89 05 22 e4 00 00 	mov    %rax,0xe422(%rip)        # 10c78 <fwp_cleanups>
    2856:	4c 89 e7             	mov    %r12,%rdi
    2859:	e8 c2 85 00 00       	call   ae20 <fwp_drop1>
    285e:	4c 89 7d 88          	mov    %r15,-0x78(%rbp)
    2862:	48 8b 05 0f e4 00 00 	mov    0xe40f(%rip),%rax        # 10c78 <fwp_cleanups>
    2869:	48 89 85 e8 fe ff ff 	mov    %rax,-0x118(%rbp)
    2870:	48 8d 05 19 87 00 00 	lea    0x8719(%rip),%rax        # af90 <fwp_owner_release2>
    2877:	48 89 85 f0 fe ff ff 	mov    %rax,-0x110(%rbp)
    287e:	48 8d 45 88          	lea    -0x78(%rbp),%rax
    2882:	48 89 85 f8 fe ff ff 	mov    %rax,-0x108(%rbp)
    2889:	4c 89 2d e8 e3 00 00 	mov    %r13,0xe3e8(%rip)        # 10c78 <fwp_cleanups>
    2890:	4c 89 ff             	mov    %r15,%rdi
    2893:	48 83 c7 08          	add    $0x8,%rdi
    2897:	49 8b 17             	mov    (%r15),%rdx
    289a:	48 8b 0d b7 e3 00 00 	mov    0xe3b7(%rip),%rcx        # 10c58 <fwp_prog_out>
    28a1:	be 01 00 00 00       	mov    $0x1,%esi
    28a6:	e8 35 fa ff ff       	call   22e0 <fwrite@plt>
    28ab:	48 8b 35 a6 e3 00 00 	mov    0xe3a6(%rip),%rsi        # 10c58 <fwp_prog_out>
    28b2:	bf 0a 00 00 00       	mov    $0xa,%edi
    28b7:	e8 b4 f8 ff ff       	call   2170 <fputc@plt>
    28bc:	4c 39 2d b5 e3 00 00 	cmp    %r13,0xe3b5(%rip)        # 10c78 <fwp_cleanups>
    28c3:	0f 85 01 06 00 00    	jne    2eca <fwp_main_thread+0x92a>
    28c9:	48 8b 85 e8 fe ff ff 	mov    -0x118(%rbp),%rax
    28d0:	48 89 05 a1 e3 00 00 	mov    %rax,0xe3a1(%rip)        # 10c78 <fwp_cleanups>
    28d7:	4c 89 f8             	mov    %r15,%rax
    28da:	48 2b 05 f7 d8 00 00 	sub    0xd8f7(%rip),%rax        # 101d8 <fwp_gc+0x1030>
    28e1:	48 8b 0d 18 d9 00 00 	mov    0xd918(%rip),%rcx        # 10200 <fwp_gc+0x1058>
    28e8:	48 c1 e1 10          	shl    $0x10,%rcx
    28ec:	48 39 c8             	cmp    %rcx,%rax
    28ef:	73 7a                	jae    296b <fwp_main_thread+0x3cb>
    28f1:	48 8b 0d 28 d9 00 00 	mov    0xd928(%rip),%rcx        # 10220 <fwp_gc+0x1078>
    28f8:	48 89 c2             	mov    %rax,%rdx
    28fb:	48 c1 ea 10          	shr    $0x10,%rdx
    28ff:	48 69 d2 28 12 00 00 	imul   $0x1228,%rdx,%rdx
    2906:	0f b6 34 11          	movzbl (%rcx,%rdx,1),%esi
    290a:	48 25 ff ff 00 00    	and    $0xffff,%rax
    2910:	75 13                	jne    2925 <fwp_main_thread+0x385>
    2912:	40 80 fe 02          	cmp    $0x2,%sil
    2916:	75 0d                	jne    2925 <fwp_main_thread+0x385>
    2918:	48 8d 3c 11          	lea    (%rcx,%rdx,1),%rdi
    291c:	48 81 c7 28 02 00 00 	add    $0x228,%rdi
    2923:	eb 21                	jmp    2946 <fwp_main_thread+0x3a6>
    2925:	40 80 fe 01          	cmp    $0x1,%sil
    2929:	75 40                	jne    296b <fwp_main_thread+0x3cb>
    292b:	48 8d 34 11          	lea    (%rcx,%rdx,1),%rsi
    292f:	8b 4c 11 20          	mov    0x20(%rcx,%rdx,1),%ecx
    2933:	48 0f af c1          	imul   %rcx,%rax
    2937:	48 c1 e8 20          	shr    $0x20,%rax
    293b:	48 8d 3c 30          	lea    (%rax,%rsi,1),%rdi
    293f:	48 81 c7 28 02 00 00 	add    $0x228,%rdi
    2946:	0f b6 07             	movzbl (%rdi),%eax
    2949:	85 c0                	test   %eax,%eax
    294b:	74 1e                	je     296b <fwp_main_thread+0x3cb>
    294d:	83 f8 01             	cmp    $0x1,%eax
    2950:	75 0a                	jne    295c <fwp_main_thread+0x3bc>
    2952:	4c 89 ff             	mov    %r15,%rdi
    2955:	e8 b6 3c 00 00       	call   6610 <fwp_rc_free_obj>
    295a:	eb 0f                	jmp    296b <fwp_main_thread+0x3cb>
    295c:	3d ff 00 00 00       	cmp    $0xff,%eax
    2961:	0f 84 4f 05 00 00    	je     2eb6 <fwp_main_thread+0x916>
    2967:	fe c8                	dec    %al
    2969:	88 07                	mov    %al,(%rdi)
    296b:	48 8d 05 66 e2 00 00 	lea    0xe266(%rip),%rax        # 10bd8 <fc3>
    2972:	48 89 85 c8 fe ff ff 	mov    %rax,-0x138(%rbp)
    2979:	48 8d 05 60 e2 00 00 	lea    0xe260(%rip),%rax        # 10be0 <fc4>
    2980:	48 89 85 d0 fe ff ff 	mov    %rax,-0x130(%rbp)
    2987:	48 8d 3d 42 e2 00 00 	lea    0xe242(%rip),%rdi        # 10bd0 <fc2>
    298e:	48 8d 95 c8 fe ff ff 	lea    -0x138(%rbp),%rdx
    2995:	be 02 00 00 00       	mov    $0x2,%esi
    299a:	e8 21 21 00 00       	call   4ac0 <fwp_apply_owned>
    299f:	49 89 c6             	mov    %rax,%r14
    29a2:	48 89 45 90          	mov    %rax,-0x70(%rbp)
    29a6:	48 8b 05 cb e2 00 00 	mov    0xe2cb(%rip),%rax        # 10c78 <fwp_cleanups>
    29ad:	48 89 85 00 ff ff ff 	mov    %rax,-0x100(%rbp)
    29b4:	48 8d 05 75 86 00 00 	lea    0x8675(%rip),%rax        # b030 <fwp_owner_release3>
    29bb:	48 89 85 08 ff ff ff 	mov    %rax,-0xf8(%rbp)
    29c2:	48 8d 45 90          	lea    -0x70(%rbp),%rax
    29c6:	48 89 85 10 ff ff ff 	mov    %rax,-0xf0(%rbp)
    29cd:	48 8d 9d 00 ff ff ff 	lea    -0x100(%rbp),%rbx
    29d4:	48 89 1d 9d e2 00 00 	mov    %rbx,0xe29d(%rip)        # 10c78 <fwp_cleanups>
    29db:	48 8d 35 2e e2 00 00 	lea    0xe22e(%rip),%rsi        # 10c10 <s1>
    29e2:	4c 89 f7             	mov    %r14,%rdi
    29e5:	e8 a6 0f 00 00       	call   3990 <fwp_p_attempt_owned>
    29ea:	48 39 1d 87 e2 00 00 	cmp    %rbx,0xe287(%rip)        # 10c78 <fwp_cleanups>
    29f1:	0f 85 d3 04 00 00    	jne    2eca <fwp_main_thread+0x92a>
    29f7:	49 89 c7             	mov    %rax,%r15
    29fa:	48 8b 85 00 ff ff ff 	mov    -0x100(%rbp),%rax
    2a01:	48 89 05 70 e2 00 00 	mov    %rax,0xe270(%rip)        # 10c78 <fwp_cleanups>
    2a08:	48 8d 05 01 e2 00 00 	lea    0xe201(%rip),%rax        # 10c10 <s1>
    2a0f:	4c 89 f7             	mov    %r14,%rdi
    2a12:	e8 d9 36 00 00       	call   60f0 <fwp_closure_drop>
    2a17:	4c 89 7d 98          	mov    %r15,-0x68(%rbp)
    2a1b:	48 8b 05 56 e2 00 00 	mov    0xe256(%rip),%rax        # 10c78 <fwp_cleanups>
    2a22:	48 89 85 18 ff ff ff 	mov    %rax,-0xe8(%rbp)
    2a29:	48 8d 05 10 86 00 00 	lea    0x8610(%rip),%rax        # b040 <fwp_owner_release4>
    2a30:	48 89 85 20 ff ff ff 	mov    %rax,-0xe0(%rbp)
    2a37:	48 8d 45 98          	lea    -0x68(%rbp),%rax
    2a3b:	48 89 85 28 ff ff ff 	mov    %rax,-0xd8(%rbp)
    2a42:	48 8d 9d 18 ff ff ff 	lea    -0xe8(%rbp),%rbx
    2a49:	48 89 1d 28 e2 00 00 	mov    %rbx,0xe228(%rip)        # 10c78 <fwp_cleanups>
    2a50:	4c 89 ff             	mov    %r15,%rdi
    2a53:	e8 48 7f 00 00       	call   a9a0 <f8>
    2a58:	48 39 1d 19 e2 00 00 	cmp    %rbx,0xe219(%rip)        # 10c78 <fwp_cleanups>
    2a5f:	0f 85 65 04 00 00    	jne    2eca <fwp_main_thread+0x92a>
    2a65:	49 89 c6             	mov    %rax,%r14
    2a68:	48 8b 85 18 ff ff ff 	mov    -0xe8(%rbp),%rax
    2a6f:	48 89 05 02 e2 00 00 	mov    %rax,0xe202(%rip)        # 10c78 <fwp_cleanups>
    2a76:	4c 89 ff             	mov    %r15,%rdi
    2a79:	e8 a2 83 00 00       	call   ae20 <fwp_drop1>
    2a7e:	4c 89 75 a0          	mov    %r14,-0x60(%rbp)
    2a82:	48 8b 05 ef e1 00 00 	mov    0xe1ef(%rip),%rax        # 10c78 <fwp_cleanups>
    2a89:	48 89 85 30 ff ff ff 	mov    %rax,-0xd0(%rbp)
    2a90:	48 8d 05 b9 85 00 00 	lea    0x85b9(%rip),%rax        # b050 <fwp_owner_release5>
    2a97:	48 89 85 38 ff ff ff 	mov    %rax,-0xc8(%rbp)
    2a9e:	48 8d 45 a0          	lea    -0x60(%rbp),%rax
    2aa2:	48 89 85 40 ff ff ff 	mov    %rax,-0xc0(%rbp)
    2aa9:	48 8d 9d 30 ff ff ff 	lea    -0xd0(%rbp),%rbx
    2ab0:	48 89 1d c1 e1 00 00 	mov    %rbx,0xe1c1(%rip)        # 10c78 <fwp_cleanups>
    2ab7:	4c 89 f7             	mov    %r14,%rdi
    2aba:	48 83 c7 08          	add    $0x8,%rdi
    2abe:	49 8b 16             	mov    (%r14),%rdx
    2ac1:	48 8b 0d 90 e1 00 00 	mov    0xe190(%rip),%rcx        # 10c58 <fwp_prog_out>
    2ac8:	be 01 00 00 00       	mov    $0x1,%esi
    2acd:	e8 0e f8 ff ff       	call   22e0 <fwrite@plt>
    2ad2:	48 8b 35 7f e1 00 00 	mov    0xe17f(%rip),%rsi        # 10c58 <fwp_prog_out>
    2ad9:	bf 0a 00 00 00       	mov    $0xa,%edi
    2ade:	e8 8d f6 ff ff       	call   2170 <fputc@plt>
    2ae3:	48 39 1d 8e e1 00 00 	cmp    %rbx,0xe18e(%rip)        # 10c78 <fwp_cleanups>
    2aea:	0f 85 da 03 00 00    	jne    2eca <fwp_main_thread+0x92a>
    2af0:	48 8b 85 30 ff ff ff 	mov    -0xd0(%rbp),%rax
    2af7:	48 89 05 7a e1 00 00 	mov    %rax,0xe17a(%rip)        # 10c78 <fwp_cleanups>
    2afe:	4c 89 f0             	mov    %r14,%rax
    2b01:	48 2b 05 d0 d6 00 00 	sub    0xd6d0(%rip),%rax        # 101d8 <fwp_gc+0x1030>
    2b08:	48 8b 0d f1 d6 00 00 	mov    0xd6f1(%rip),%rcx        # 10200 <fwp_gc+0x1058>
    2b0f:	48 c1 e1 10          	shl    $0x10,%rcx
    2b13:	48 39 c8             	cmp    %rcx,%rax
    2b16:	73 7a                	jae    2b92 <fwp_main_thread+0x5f2>
    2b18:	48 8b 0d 01 d7 00 00 	mov    0xd701(%rip),%rcx        # 10220 <fwp_gc+0x1078>
    2b1f:	48 89 c2             	mov    %rax,%rdx
    2b22:	48 c1 ea 10          	shr    $0x10,%rdx
    2b26:	48 69 d2 28 12 00 00 	imul   $0x1228,%rdx,%rdx
    2b2d:	0f b6 34 11          	movzbl (%rcx,%rdx,1),%esi
    2b31:	48 25 ff ff 00 00    	and    $0xffff,%rax
    2b37:	75 13                	jne    2b4c <fwp_main_thread+0x5ac>
    2b39:	40 80 fe 02          	cmp    $0x2,%sil
    2b3d:	75 0d                	jne    2b4c <fwp_main_thread+0x5ac>
    2b3f:	48 8d 3c 11          	lea    (%rcx,%rdx,1),%rdi
    2b43:	48 81 c7 28 02 00 00 	add    $0x228,%rdi
    2b4a:	eb 21                	jmp    2b6d <fwp_main_thread+0x5cd>
    2b4c:	40 80 fe 01          	cmp    $0x1,%sil
    2b50:	75 40                	jne    2b92 <fwp_main_thread+0x5f2>
    2b52:	48 8d 34 11          	lea    (%rcx,%rdx,1),%rsi
    2b56:	8b 4c 11 20          	mov    0x20(%rcx,%rdx,1),%ecx
    2b5a:	48 0f af c1          	imul   %rcx,%rax
    2b5e:	48 c1 e8 20          	shr    $0x20,%rax
    2b62:	48 8d 3c 30          	lea    (%rax,%rsi,1),%rdi
    2b66:	48 81 c7 28 02 00 00 	add    $0x228,%rdi
    2b6d:	0f b6 07             	movzbl (%rdi),%eax
    2b70:	85 c0                	test   %eax,%eax
    2b72:	74 1e                	je     2b92 <fwp_main_thread+0x5f2>
    2b74:	83 f8 01             	cmp    $0x1,%eax
    2b77:	75 0a                	jne    2b83 <fwp_main_thread+0x5e3>
    2b79:	4c 89 f7             	mov    %r14,%rdi
    2b7c:	e8 8f 3a 00 00       	call   6610 <fwp_rc_free_obj>
    2b81:	eb 0f                	jmp    2b92 <fwp_main_thread+0x5f2>
    2b83:	3d ff 00 00 00       	cmp    $0xff,%eax
    2b88:	0f 84 32 03 00 00    	je     2ec0 <fwp_main_thread+0x920>
    2b8e:	fe c8                	dec    %al
    2b90:	88 07                	mov    %al,(%rdi)
    2b92:	48 c7 45 a8 00 00 00 	movq   $0x0,-0x58(%rbp)
    2b99:	00 
    2b9a:	48 8b 05 d7 e0 00 00 	mov    0xe0d7(%rip),%rax        # 10c78 <fwp_cleanups>
    2ba1:	48 89 85 48 ff ff ff 	mov    %rax,-0xb8(%rbp)
    2ba8:	48 8d 05 41 85 00 00 	lea    0x8541(%rip),%rax        # b0f0 <fwp_owner_release6>
    2baf:	48 89 85 50 ff ff ff 	mov    %rax,-0xb0(%rbp)
    2bb6:	48 8d 45 a8          	lea    -0x58(%rbp),%rax
    2bba:	48 89 85 58 ff ff ff 	mov    %rax,-0xa8(%rbp)
    2bc1:	4c 8d bd 48 ff ff ff 	lea    -0xb8(%rbp),%r15
    2bc8:	4c 89 3d a9 e0 00 00 	mov    %r15,0xe0a9(%rip)        # 10c78 <fwp_cleanups>
    2bcf:	66 0f 57 c0          	xorpd  %xmm0,%xmm0
    2bd3:	66 0f 29 85 a0 fe ff 	movapd %xmm0,-0x160(%rbp)
    2bda:	ff 
    2bdb:	48 8d 95 a0 fe ff ff 	lea    -0x160(%rbp),%rdx
    2be2:	bf 01 00 00 00       	mov    $0x1,%edi
    2be7:	be 02 00 00 00       	mov    $0x2,%esi
    2bec:	e8 df 16 00 00       	call   42d0 <fwp_data>
    2bf1:	48 89 c1             	mov    %rax,%rcx
    2bf4:	48 2b 0d dd d5 00 00 	sub    0xd5dd(%rip),%rcx        # 101d8 <fwp_gc+0x1030>
    2bfb:	48 8b 15 fe d5 00 00 	mov    0xd5fe(%rip),%rdx        # 10200 <fwp_gc+0x1058>
    2c02:	48 c1 e2 10          	shl    $0x10,%rdx
    2c06:	48 39 d1             	cmp    %rdx,%rcx
    2c09:	73 76                	jae    2c81 <fwp_main_thread+0x6e1>
    2c0b:	48 8b 15 0e d6 00 00 	mov    0xd60e(%rip),%rdx        # 10220 <fwp_gc+0x1078>
    2c12:	48 89 ce             	mov    %rcx,%rsi
    2c15:	48 c1 ee 10          	shr    $0x10,%rsi
    2c19:	48 69 f6 28 12 00 00 	imul   $0x1228,%rsi,%rsi
    2c20:	0f b6 3c 32          	movzbl (%rdx,%rsi,1),%edi
    2c24:	48 81 e1 ff ff 00 00 	and    $0xffff,%rcx
    2c2b:	75 1d                	jne    2c4a <fwp_main_thread+0x6aa>
    2c2d:	40 80 ff 02          	cmp    $0x2,%dil
    2c31:	75 17                	jne    2c4a <fwp_main_thread+0x6aa>
    2c33:	4c 8d 34 32          	lea    (%rdx,%rsi,1),%r14
    2c37:	49 81 c6 28 02 00 00 	add    $0x228,%r14
    2c3e:	41 80 3e ff          	cmpb   $0xff,(%r14)
    2c42:	74 2d                	je     2c71 <fwp_main_thread+0x6d1>
    2c44:	41 c6 06 01          	movb   $0x1,(%r14)
    2c48:	eb 37                	jmp    2c81 <fwp_main_thread+0x6e1>
    2c4a:	40 80 ff 01          	cmp    $0x1,%dil
    2c4e:	75 31                	jne    2c81 <fwp_main_thread+0x6e1>
    2c50:	48 8d 3c 32          	lea    (%rdx,%rsi,1),%rdi
    2c54:	8b 54 32 20          	mov    0x20(%rdx,%rsi,1),%edx
    2c58:	48 0f af ca          	imul   %rdx,%rcx
    2c5c:	48 c1 e9 20          	shr    $0x20,%rcx
    2c60:	4c 8d 34 39          	lea    (%rcx,%rdi,1),%r14
    2c64:	49 81 c6 28 02 00 00 	add    $0x228,%r14
    2c6b:	41 80 3e ff          	cmpb   $0xff,(%r14)
    2c6f:	75 d3                	jne    2c44 <fwp_main_thread+0x6a4>
    2c71:	4c 89 f7             	mov    %r14,%rdi
    2c74:	49 89 c4             	mov    %rax,%r12
    2c77:	e8 64 0c 00 00       	call   38e0 <fwp_rc_forget_slot>
    2c7c:	4c 89 e0             	mov    %r12,%rax
    2c7f:	eb c3                	jmp    2c44 <fwp_main_thread+0x6a4>
    2c81:	4c 39 3d f0 df 00 00 	cmp    %r15,0xdff0(%rip)        # 10c78 <fwp_cleanups>
    2c88:	0f 85 3c 02 00 00    	jne    2eca <fwp_main_thread+0x92a>
    2c8e:	48 8b 8d 48 ff ff ff 	mov    -0xb8(%rbp),%rcx
    2c95:	48 89 45 b0          	mov    %rax,-0x50(%rbp)
    2c99:	48 89 8d 60 ff ff ff 	mov    %rcx,-0xa0(%rbp)
    2ca0:	48 8d 0d d9 84 00 00 	lea    0x84d9(%rip),%rcx        # b180 <fwp_owner_release7>
    2ca7:	48 89 8d 68 ff ff ff 	mov    %rcx,-0x98(%rbp)
    2cae:	48 8d 4d b0          	lea    -0x50(%rbp),%rcx
    2cb2:	48 89 8d 70 ff ff ff 	mov    %rcx,-0x90(%rbp)
    2cb9:	4c 8d bd 60 ff ff ff 	lea    -0xa0(%rbp),%r15
    2cc0:	4c 89 3d b1 df 00 00 	mov    %r15,0xdfb1(%rip)        # 10c78 <fwp_cleanups>
    2cc7:	48 c7 85 d8 fe ff ff 	movq   $0x0,-0x128(%rbp)
    2cce:	00 00 00 00 
    2cd2:	48 89 85 e0 fe ff ff 	mov    %rax,-0x120(%rbp)
    2cd9:	48 8d 95 d8 fe ff ff 	lea    -0x128(%rbp),%rdx
    2ce0:	bf 01 00 00 00       	mov    $0x1,%edi
    2ce5:	be 02 00 00 00       	mov    $0x2,%esi
    2cea:	e8 e1 15 00 00       	call   42d0 <fwp_data>
    2cef:	48 89 c1             	mov    %rax,%rcx
    2cf2:	48 2b 0d df d4 00 00 	sub    0xd4df(%rip),%rcx        # 101d8 <fwp_gc+0x1030>
    2cf9:	48 8b 15 00 d5 00 00 	mov    0xd500(%rip),%rdx        # 10200 <fwp_gc+0x1058>
    2d00:	48 c1 e2 10          	shl    $0x10,%rdx
    2d04:	48 39 d1             	cmp    %rdx,%rcx
    2d07:	73 76                	jae    2d7f <fwp_main_thread+0x7df>
    2d09:	48 8b 15 10 d5 00 00 	mov    0xd510(%rip),%rdx        # 10220 <fwp_gc+0x1078>
    2d10:	48 89 ce             	mov    %rcx,%rsi
    2d13:	48 c1 ee 10          	shr    $0x10,%rsi
    2d17:	48 69 f6 28 12 00 00 	imul   $0x1228,%rsi,%rsi
    2d1e:	0f b6 3c 32          	movzbl (%rdx,%rsi,1),%edi
    2d22:	48 81 e1 ff ff 00 00 	and    $0xffff,%rcx
    2d29:	75 1d                	jne    2d48 <fwp_main_thread+0x7a8>
    2d2b:	40 80 ff 02          	cmp    $0x2,%dil
    2d2f:	75 17                	jne    2d48 <fwp_main_thread+0x7a8>
    2d31:	4c 8d 34 32          	lea    (%rdx,%rsi,1),%r14
    2d35:	49 81 c6 28 02 00 00 	add    $0x228,%r14
    2d3c:	41 80 3e ff          	cmpb   $0xff,(%r14)
    2d40:	74 2d                	je     2d6f <fwp_main_thread+0x7cf>
    2d42:	41 c6 06 01          	movb   $0x1,(%r14)
    2d46:	eb 37                	jmp    2d7f <fwp_main_thread+0x7df>
    2d48:	40 80 ff 01          	cmp    $0x1,%dil
    2d4c:	75 31                	jne    2d7f <fwp_main_thread+0x7df>
    2d4e:	48 8d 3c 32          	lea    (%rdx,%rsi,1),%rdi
    2d52:	8b 54 32 20          	mov    0x20(%rdx,%rsi,1),%edx
    2d56:	48 0f af ca          	imul   %rdx,%rcx
    2d5a:	48 c1 e9 20          	shr    $0x20,%rcx
    2d5e:	4c 8d 34 39          	lea    (%rcx,%rdi,1),%r14
    2d62:	49 81 c6 28 02 00 00 	add    $0x228,%r14
    2d69:	41 80 3e ff          	cmpb   $0xff,(%r14)
    2d6d:	75 d3                	jne    2d42 <fwp_main_thread+0x7a2>
    2d6f:	4c 89 f7             	mov    %r14,%rdi
    2d72:	49 89 c4             	mov    %rax,%r12
    2d75:	e8 66 0b 00 00       	call   38e0 <fwp_rc_forget_slot>
    2d7a:	4c 89 e0             	mov    %r12,%rax
    2d7d:	eb c3                	jmp    2d42 <fwp_main_thread+0x7a2>
    2d7f:	4c 39 3d f2 de 00 00 	cmp    %r15,0xdef2(%rip)        # 10c78 <fwp_cleanups>
    2d86:	0f 85 3e 01 00 00    	jne    2eca <fwp_main_thread+0x92a>
    2d8c:	48 8b 95 60 ff ff ff 	mov    -0xa0(%rbp),%rdx
    2d93:	48 89 c1             	mov    %rax,%rcx
    2d96:	48 2b 0d 3b d4 00 00 	sub    0xd43b(%rip),%rcx        # 101d8 <fwp_gc+0x1030>
    2d9d:	48 89 15 d4 de 00 00 	mov    %rdx,0xded4(%rip)        # 10c78 <fwp_cleanups>
    2da4:	48 8b 15 55 d4 00 00 	mov    0xd455(%rip),%rdx        # 10200 <fwp_gc+0x1058>
    2dab:	48 c1 e2 10          	shl    $0x10,%rdx
    2daf:	48 39 d1             	cmp    %rdx,%rcx
    2db2:	0f 83 9c 00 00 00    	jae    2e54 <fwp_main_thread+0x8b4>
    2db8:	48 8b 15 61 d4 00 00 	mov    0xd461(%rip),%rdx        # 10220 <fwp_gc+0x1078>
    2dbf:	48 89 ce             	mov    %rcx,%rsi
    2dc2:	48 c1 ee 10          	shr    $0x10,%rsi
    2dc6:	48 69 f6 28 12 00 00 	imul   $0x1228,%rsi,%rsi
    2dcd:	0f b6 3c 32          	movzbl (%rdx,%rsi,1),%edi
    2dd1:	48 81 e1 ff ff 00 00 	and    $0xffff,%rcx
    2dd8:	75 13                	jne    2ded <fwp_main_thread+0x84d>
    2dda:	40 80 ff 02          	cmp    $0x2,%dil
    2dde:	75 0d                	jne    2ded <fwp_main_thread+0x84d>
    2de0:	48 8d 3c 32          	lea    (%rdx,%rsi,1),%rdi
    2de4:	48 81 c7 28 02 00 00 	add    $0x228,%rdi
    2deb:	eb 20                	jmp    2e0d <fwp_main_thread+0x86d>
    2ded:	40 80 ff 01          	cmp    $0x1,%dil
    2df1:	75 61                	jne    2e54 <fwp_main_thread+0x8b4>
    2df3:	48 8d 3c 32          	lea    (%rdx,%rsi,1),%rdi
    2df7:	8b 54 32 20          	mov    0x20(%rdx,%rsi,1),%edx
    2dfb:	48 0f af ca          	imul   %rdx,%rcx
    2dff:	48 c1 e9 20          	shr    $0x20,%rcx
    2e03:	48 01 cf             	add    %rcx,%rdi
    2e06:	48 81 c7 28 02 00 00 	add    $0x228,%rdi
    2e0d:	0f b6 0f             	movzbl (%rdi),%ecx
    2e10:	85 c9                	test   %ecx,%ecx
    2e12:	74 40                	je     2e54 <fwp_main_thread+0x8b4>
    2e14:	83 f9 01             	cmp    $0x1,%ecx
    2e17:	75 2f                	jne    2e48 <fwp_main_thread+0x8a8>
    2e19:	48 8b 58 10          	mov    0x10(%rax),%rbx
    2e1d:	48 89 c7             	mov    %rax,%rdi
    2e20:	e8 eb 37 00 00       	call   6610 <fwp_rc_free_obj>
    2e25:	48 89 d9             	mov    %rbx,%rcx
    2e28:	48 2b 0d a9 d3 00 00 	sub    0xd3a9(%rip),%rcx        # 101d8 <fwp_gc+0x1030>
    2e2f:	48 8b 15 ca d3 00 00 	mov    0xd3ca(%rip),%rdx        # 10200 <fwp_gc+0x1058>
    2e36:	48 c1 e2 10          	shl    $0x10,%rdx
    2e3a:	48 89 d8             	mov    %rbx,%rax
    2e3d:	48 39 d1             	cmp    %rdx,%rcx
    2e40:	0f 82 72 ff ff ff    	jb     2db8 <fwp_main_thread+0x818>
    2e46:	eb 0c                	jmp    2e54 <fwp_main_thread+0x8b4>
    2e48:	81 f9 ff 00 00 00    	cmp    $0xff,%ecx
    2e4e:	74 5f                	je     2eaf <fwp_main_thread+0x90f>
    2e50:	fe c9                	dec    %cl
    2e52:	88 0f                	mov    %cl,(%rdi)
    2e54:	c6 05 45 de 01 00 01 	movb   $0x1,0x1de45(%rip)        # 20ca0 <caf0.st>
    2e5b:	48 8b 05 46 c3 00 00 	mov    0xc346(%rip),%rax        # f1a8 <fwp_gc>
    2e62:	48 8b 55 b8          	mov    -0x48(%rbp),%rdx
    2e66:	48 83 3d 12 d5 00 00 	cmpq   $0x0,0xd512(%rip)        # 10380 <fwp_gc+0x11d8>
    2e6d:	00 
    2e6e:	75 5f                	jne    2ecf <fwp_main_thread+0x92f>
    2e70:	83 3d 21 d3 00 00 00 	cmpl   $0x0,0xd321(%rip)        # 10198 <fwp_gc+0xff0>
    2e77:	75 56                	jne    2ecf <fwp_main_thread+0x92f>
    2e79:	48 39 c2             	cmp    %rax,%rdx
    2e7c:	7f 51                	jg     2ecf <fwp_main_thread+0x92f>
    2e7e:	66 0f 57 c0          	xorpd  %xmm0,%xmm0
    2e82:	66 0f 2e 05 26 d5 00 	ucomisd 0xd526(%rip),%xmm0        # 103b0 <fwp_gc+0x1208>
    2e89:	00 
    2e8a:	73 43                	jae    2ecf <fwp_main_thread+0x92f>
    2e8c:	48 8b 05 2d c1 00 00 	mov    0xc12d(%rip),%rax        # efc0 <stdout@GLIBC_2.2.5>
    2e93:	48 8b 38             	mov    (%rax),%rdi
    2e96:	e8 95 f3 ff ff       	call   2230 <fflush@plt>
    2e9b:	31 c0                	xor    %eax,%eax
    2e9d:	48 81 c4 d8 01 00 00 	add    $0x1d8,%rsp
    2ea4:	5b                   	pop    %rbx
    2ea5:	41 5c                	pop    %r12
    2ea7:	41 5d                	pop    %r13
    2ea9:	41 5e                	pop    %r14
    2eab:	41 5f                	pop    %r15
    2ead:	5d                   	pop    %rbp
    2eae:	c3                   	ret
    2eaf:	e8 4c 35 00 00       	call   6400 <fwp_rc_wide_drop>
    2eb4:	eb 9e                	jmp    2e54 <fwp_main_thread+0x8b4>
    2eb6:	e8 45 35 00 00       	call   6400 <fwp_rc_wide_drop>
    2ebb:	e9 ab fa ff ff       	jmp    296b <fwp_main_thread+0x3cb>
    2ec0:	e8 3b 35 00 00       	call   6400 <fwp_rc_wide_drop>
    2ec5:	e9 c8 fc ff ff       	jmp    2b92 <fwp_main_thread+0x5f2>
    2eca:	e8 91 f1 ff ff       	call   2060 <abort@plt>
    2ecf:	48 8b 0d 0a c1 00 00 	mov    0xc10a(%rip),%rcx        # efe0 <stderr@GLIBC_2.2.5>
    2ed6:	48 8b 39             	mov    (%rcx),%rdi
    2ed9:	48 29 c2             	sub    %rax,%rdx
    2edc:	48 8d 35 73 97 00 00 	lea    0x9773(%rip),%rsi        # c656 <fwp_segv.msg+0x416>
    2ee3:	31 c0                	xor    %eax,%eax
    2ee5:	e8 f6 f2 ff ff       	call   21e0 <fprintf@plt>
    2eea:	bf c1 00 00 00       	mov    $0xc1,%edi
    2eef:	e8 dc f3 ff ff       	call   22d0 <exit@plt>
    2ef4:	66 66 66 2e 0f 1f 84 	data16 data16 cs nopw 0x0(%rax,%rax,1)
    2efb:	00 00 00 00 00 

0000000000002f00 <e1>:
    2f00:	50                   	push   %rax
    2f01:	48 89 f8             	mov    %rdi,%rax
    2f04:	48 8b 3f             	mov    (%rdi),%rdi
    2f07:	48 8b 0d ca d2 00 00 	mov    0xd2ca(%rip),%rcx        # 101d8 <fwp_gc+0x1030>
    2f0e:	48 89 fe             	mov    %rdi,%rsi
    2f11:	48 29 ce             	sub    %rcx,%rsi
    2f14:	48 8b 15 e5 d2 00 00 	mov    0xd2e5(%rip),%rdx        # 10200 <fwp_gc+0x1058>
    2f1b:	48 c1 e2 10          	shl    $0x10,%rdx
    2f1f:	48 39 d6             	cmp    %rdx,%rsi
    2f22:	73 68                	jae    2f8c <e1+0x8c>
    2f24:	4c 8b 05 f5 d2 00 00 	mov    0xd2f5(%rip),%r8        # 10220 <fwp_gc+0x1078>
    2f2b:	49 89 f1             	mov    %rsi,%r9
    2f2e:	49 c1 e9 10          	shr    $0x10,%r9
    2f32:	4d 69 c9 28 12 00 00 	imul   $0x1228,%r9,%r9
    2f39:	47 0f b6 14 08       	movzbl (%r8,%r9,1),%r10d
    2f3e:	48 81 e6 ff ff 00 00 	and    $0xffff,%rsi
    2f45:	75 1b                	jne    2f62 <e1+0x62>
    2f47:	41 80 fa 02          	cmp    $0x2,%r10b
    2f4b:	75 15                	jne    2f62 <e1+0x62>
    2f4d:	4b 8d 34 08          	lea    (%r8,%r9,1),%rsi
    2f51:	48 81 c6 28 02 00 00 	add    $0x228,%rsi
    2f58:	80 3e 00             	cmpb   $0x0,(%rsi)
    2f5b:	74 2f                	je     2f8c <e1+0x8c>
    2f5d:	e9 1d 01 00 00       	jmp    307f <e1+0x17f>
    2f62:	41 80 fa 01          	cmp    $0x1,%r10b
    2f66:	75 24                	jne    2f8c <e1+0x8c>
    2f68:	4f 8d 14 08          	lea    (%r8,%r9,1),%r10
    2f6c:	47 8b 44 08 20       	mov    0x20(%r8,%r9,1),%r8d
    2f71:	49 0f af f0          	imul   %r8,%rsi
    2f75:	48 c1 ee 20          	shr    $0x20,%rsi
    2f79:	4c 01 d6             	add    %r10,%rsi
    2f7c:	48 81 c6 28 02 00 00 	add    $0x228,%rsi
    2f83:	80 3e 00             	cmpb   $0x0,(%rsi)
    2f86:	0f 85 f3 00 00 00    	jne    307f <e1+0x17f>
    2f8c:	48 8b 70 08          	mov    0x8(%rax),%rsi
    2f90:	48 89 f0             	mov    %rsi,%rax
    2f93:	48 29 c8             	sub    %rcx,%rax
    2f96:	48 39 d0             	cmp    %rdx,%rax
    2f99:	73 64                	jae    2fff <e1+0xff>
    2f9b:	48 8b 0d 7e d2 00 00 	mov    0xd27e(%rip),%rcx        # 10220 <fwp_gc+0x1078>
    2fa2:	48 89 c2             	mov    %rax,%rdx
    2fa5:	48 c1 ea 10          	shr    $0x10,%rdx
    2fa9:	48 69 d2 28 12 00 00 	imul   $0x1228,%rdx,%rdx
    2fb0:	44 0f b6 04 11       	movzbl (%rcx,%rdx,1),%r8d
    2fb5:	48 25 ff ff 00 00    	and    $0xffff,%rax
    2fbb:	75 1a                	jne    2fd7 <e1+0xd7>
    2fbd:	41 80 f8 02          	cmp    $0x2,%r8b
    2fc1:	75 14                	jne    2fd7 <e1+0xd7>
    2fc3:	48 8d 04 11          	lea    (%rcx,%rdx,1),%rax
    2fc7:	48 05 28 02 00 00    	add    $0x228,%rax
    2fcd:	80 38 00             	cmpb   $0x0,(%rax)
    2fd0:	74 2d                	je     2fff <e1+0xff>
    2fd2:	e9 a8 00 00 00       	jmp    307f <e1+0x17f>
    2fd7:	41 80 f8 01          	cmp    $0x1,%r8b
    2fdb:	75 22                	jne    2fff <e1+0xff>
    2fdd:	4c 8d 04 11          	lea    (%rcx,%rdx,1),%r8
    2fe1:	8b 4c 11 20          	mov    0x20(%rcx,%rdx,1),%ecx
    2fe5:	48 0f af c1          	imul   %rcx,%rax
    2fe9:	48 c1 e8 20          	shr    $0x20,%rax
    2fed:	4c 01 c0             	add    %r8,%rax
    2ff0:	48 05 28 02 00 00    	add    $0x228,%rax
    2ff6:	80 38 00             	cmpb   $0x0,(%rax)
    2ff9:	0f 85 80 00 00 00    	jne    307f <e1+0x17f>
    2fff:	e8 8c 09 00 00       	call   3990 <fwp_p_attempt_owned>
    3004:	48 89 c1             	mov    %rax,%rcx
    3007:	48 2b 0d ca d1 00 00 	sub    0xd1ca(%rip),%rcx        # 101d8 <fwp_gc+0x1030>
    300e:	48 8b 15 eb d1 00 00 	mov    0xd1eb(%rip),%rdx        # 10200 <fwp_gc+0x1058>
    3015:	48 c1 e2 10          	shl    $0x10,%rdx
    3019:	48 39 d1             	cmp    %rdx,%rcx
    301c:	73 5f                	jae    307d <e1+0x17d>
    301e:	48 8b 15 fb d1 00 00 	mov    0xd1fb(%rip),%rdx        # 10220 <fwp_gc+0x1078>
    3025:	48 89 ce             	mov    %rcx,%rsi
    3028:	48 c1 ee 10          	shr    $0x10,%rsi
    302c:	48 69 f6 28 12 00 00 	imul   $0x1228,%rsi,%rsi
    3033:	0f b6 3c 32          	movzbl (%rdx,%rsi,1),%edi
    3037:	48 81 e1 ff ff 00 00 	and    $0xffff,%rcx
    303e:	75 18                	jne    3058 <e1+0x158>
    3040:	40 80 ff 02          	cmp    $0x2,%dil
    3044:	75 12                	jne    3058 <e1+0x158>
    3046:	48 8d 0c 32          	lea    (%rdx,%rsi,1),%rcx
    304a:	48 81 c1 28 02 00 00 	add    $0x228,%rcx
    3051:	80 39 00             	cmpb   $0x0,(%rcx)
    3054:	74 27                	je     307d <e1+0x17d>
    3056:	eb 27                	jmp    307f <e1+0x17f>
    3058:	40 80 ff 01          	cmp    $0x1,%dil
    305c:	75 1f                	jne    307d <e1+0x17d>
    305e:	48 8d 3c 32          	lea    (%rdx,%rsi,1),%rdi
    3062:	8b 54 32 20          	mov    0x20(%rdx,%rsi,1),%edx
    3066:	48 0f af ca          	imul   %rdx,%rcx
    306a:	48 c1 e9 20          	shr    $0x20,%rcx
    306e:	48 01 f9             	add    %rdi,%rcx
    3071:	48 81 c1 28 02 00 00 	add    $0x228,%rcx
    3078:	80 39 00             	cmpb   $0x0,(%rcx)
    307b:	75 02                	jne    307f <e1+0x17f>
    307d:	59                   	pop    %rcx
    307e:	c3                   	ret
    307f:	e8 2c 08 00 00       	call   38b0 <fwp_flush>
    3084:	48 8b 05 55 bf 00 00 	mov    0xbf55(%rip),%rax        # efe0 <stderr@GLIBC_2.2.5>
    308b:	48 8b 38             	mov    (%rax),%rdi
    308e:	48 8d 35 9f 92 00 00 	lea    0x929f(%rip),%rsi        # c334 <fwp_segv.msg+0xf4>
    3095:	48 8d 15 6b 92 00 00 	lea    0x926b(%rip),%rdx        # c307 <fwp_segv.msg+0xc7>
    309c:	31 c0                	xor    %eax,%eax
    309e:	e8 3d f1 ff ff       	call   21e0 <fprintf@plt>
    30a3:	bf 65 00 00 00       	mov    $0x65,%edi
    30a8:	e8 23 f2 ff ff       	call   22d0 <exit@plt>
    30ad:	0f 1f 00             	nopl   (%rax)

00000000000030b0 <e2>:
    30b0:	48 83 ec 18          	sub    $0x18,%rsp
    30b4:	48 89 f8             	mov    %rdi,%rax
    30b7:	48 8b 3f             	mov    (%rdi),%rdi
    30ba:	48 8b 0d 17 d1 00 00 	mov    0xd117(%rip),%rcx        # 101d8 <fwp_gc+0x1030>
    30c1:	48 89 fe             	mov    %rdi,%rsi
    30c4:	48 29 ce             	sub    %rcx,%rsi
    30c7:	48 8b 15 32 d1 00 00 	mov    0xd132(%rip),%rdx        # 10200 <fwp_gc+0x1058>
    30ce:	48 c1 e2 10          	shl    $0x10,%rdx
    30d2:	48 39 d6             	cmp    %rdx,%rsi
    30d5:	73 68                	jae    313f <e2+0x8f>
    30d7:	4c 8b 05 42 d1 00 00 	mov    0xd142(%rip),%r8        # 10220 <fwp_gc+0x1078>
    30de:	49 89 f1             	mov    %rsi,%r9
    30e1:	49 c1 e9 10          	shr    $0x10,%r9
    30e5:	4d 69 c9 28 12 00 00 	imul   $0x1228,%r9,%r9
    30ec:	47 0f b6 14 08       	movzbl (%r8,%r9,1),%r10d
    30f1:	48 81 e6 ff ff 00 00 	and    $0xffff,%rsi
    30f8:	75 1b                	jne    3115 <e2+0x65>
    30fa:	41 80 fa 02          	cmp    $0x2,%r10b
    30fe:	75 15                	jne    3115 <e2+0x65>
    3100:	4b 8d 34 08          	lea    (%r8,%r9,1),%rsi
    3104:	48 81 c6 28 02 00 00 	add    $0x228,%rsi
    310b:	80 3e 00             	cmpb   $0x0,(%rsi)
    310e:	74 2f                	je     313f <e2+0x8f>
    3110:	e9 b0 01 00 00       	jmp    32c5 <e2+0x215>
    3115:	41 80 fa 01          	cmp    $0x1,%r10b
    3119:	75 24                	jne    313f <e2+0x8f>
    311b:	4f 8d 14 08          	lea    (%r8,%r9,1),%r10
    311f:	47 8b 44 08 20       	mov    0x20(%r8,%r9,1),%r8d
    3124:	49 0f af f0          	imul   %r8,%rsi
    3128:	48 c1 ee 20          	shr    $0x20,%rsi
    312c:	4c 01 d6             	add    %r10,%rsi
    312f:	48 81 c6 28 02 00 00 	add    $0x228,%rsi
    3136:	80 3e 00             	cmpb   $0x0,(%rsi)
    3139:	0f 85 86 01 00 00    	jne    32c5 <e2+0x215>
    313f:	48 8b 70 08          	mov    0x8(%rax),%rsi
    3143:	49 89 f0             	mov    %rsi,%r8
    3146:	49 29 c8             	sub    %rcx,%r8
    3149:	49 39 d0             	cmp    %rdx,%r8
    314c:	73 6a                	jae    31b8 <e2+0x108>
    314e:	4c 8b 0d cb d0 00 00 	mov    0xd0cb(%rip),%r9        # 10220 <fwp_gc+0x1078>
    3155:	4d 89 c2             	mov    %r8,%r10
    3158:	49 c1 ea 10          	shr    $0x10,%r10
    315c:	4d 69 d2 28 12 00 00 	imul   $0x1228,%r10,%r10
    3163:	47 0f b6 1c 11       	movzbl (%r9,%r10,1),%r11d
    3168:	49 81 e0 ff ff 00 00 	and    $0xffff,%r8
    316f:	75 1c                	jne    318d <e2+0xdd>
    3171:	41 80 fb 02          	cmp    $0x2,%r11b
    3175:	75 16                	jne    318d <e2+0xdd>
    3177:	4f 8d 04 11          	lea    (%r9,%r10,1),%r8
    317b:	49 81 c0 28 02 00 00 	add    $0x228,%r8
    3182:	41 80 38 00          	cmpb   $0x0,(%r8)
    3186:	74 30                	je     31b8 <e2+0x108>
    3188:	e9 38 01 00 00       	jmp    32c5 <e2+0x215>
    318d:	41 80 fb 01          	cmp    $0x1,%r11b
    3191:	75 25                	jne    31b8 <e2+0x108>
    3193:	4f 8d 1c 11          	lea    (%r9,%r10,1),%r11
    3197:	47 8b 4c 11 20       	mov    0x20(%r9,%r10,1),%r9d
    319c:	4d 0f af c1          	imul   %r9,%r8
    31a0:	49 c1 e8 20          	shr    $0x20,%r8
    31a4:	4d 01 d8             	add    %r11,%r8
    31a7:	49 81 c0 28 02 00 00 	add    $0x228,%r8
    31ae:	41 80 38 00          	cmpb   $0x0,(%r8)
    31b2:	0f 85 0d 01 00 00    	jne    32c5 <e2+0x215>
    31b8:	48 8b 40 10          	mov    0x10(%rax),%rax
    31bc:	49 89 c0             	mov    %rax,%r8
    31bf:	49 29 c8             	sub    %rcx,%r8
    31c2:	49 39 d0             	cmp    %rdx,%r8
    31c5:	73 67                	jae    322e <e2+0x17e>
    31c7:	48 8b 0d 52 d0 00 00 	mov    0xd052(%rip),%rcx        # 10220 <fwp_gc+0x1078>
    31ce:	4c 89 c2             	mov    %r8,%rdx
    31d1:	48 c1 ea 10          	shr    $0x10,%rdx
    31d5:	48 69 d2 28 12 00 00 	imul   $0x1228,%rdx,%rdx
    31dc:	44 0f b6 0c 11       	movzbl (%rcx,%rdx,1),%r9d
    31e1:	49 81 e0 ff ff 00 00 	and    $0xffff,%r8
    31e8:	75 1a                	jne    3204 <e2+0x154>
    31ea:	41 80 f9 02          	cmp    $0x2,%r9b
    31ee:	75 14                	jne    3204 <e2+0x154>
    31f0:	48 01 d1             	add    %rdx,%rcx
    31f3:	48 81 c1 28 02 00 00 	add    $0x228,%rcx
    31fa:	80 39 00             	cmpb   $0x0,(%rcx)
    31fd:	74 2f                	je     322e <e2+0x17e>
    31ff:	e9 c1 00 00 00       	jmp    32c5 <e2+0x215>
    3204:	41 80 f9 01          	cmp    $0x1,%r9b
    3208:	75 24                	jne    322e <e2+0x17e>
    320a:	4c 8d 0c 11          	lea    (%rcx,%rdx,1),%r9
    320e:	8b 4c 11 20          	mov    0x20(%rcx,%rdx,1),%ecx
    3212:	4c 0f af c1          	imul   %rcx,%r8
    3216:	49 c1 e8 20          	shr    $0x20,%r8
    321a:	4b 8d 0c 08          	lea    (%r8,%r9,1),%rcx
    321e:	48 81 c1 28 02 00 00 	add    $0x228,%rcx
    3225:	80 39 00             	cmpb   $0x0,(%rcx)
    3228:	0f 85 97 00 00 00    	jne    32c5 <e2+0x215>
    322e:	48 89 44 24 08       	mov    %rax,0x8(%rsp)
    3233:	48 89 74 24 10       	mov    %rsi,0x10(%rsp)
    3238:	48 8d 54 24 08       	lea    0x8(%rsp),%rdx
    323d:	be 02 00 00 00       	mov    $0x2,%esi
    3242:	e8 79 18 00 00       	call   4ac0 <fwp_apply_owned>
    3247:	48 89 c1             	mov    %rax,%rcx
    324a:	48 2b 0d 87 cf 00 00 	sub    0xcf87(%rip),%rcx        # 101d8 <fwp_gc+0x1030>
    3251:	48 8b 15 a8 cf 00 00 	mov    0xcfa8(%rip),%rdx        # 10200 <fwp_gc+0x1058>
    3258:	48 c1 e2 10          	shl    $0x10,%rdx
    325c:	48 39 d1             	cmp    %rdx,%rcx
    325f:	73 5f                	jae    32c0 <e2+0x210>
    3261:	48 8b 15 b8 cf 00 00 	mov    0xcfb8(%rip),%rdx        # 10220 <fwp_gc+0x1078>
    3268:	48 89 ce             	mov    %rcx,%rsi
    326b:	48 c1 ee 10          	shr    $0x10,%rsi
    326f:	48 69 f6 28 12 00 00 	imul   $0x1228,%rsi,%rsi
    3276:	0f b6 3c 32          	movzbl (%rdx,%rsi,1),%edi
    327a:	48 81 e1 ff ff 00 00 	and    $0xffff,%rcx
    3281:	75 18                	jne    329b <e2+0x1eb>
    3283:	40 80 ff 02          	cmp    $0x2,%dil
    3287:	75 12                	jne    329b <e2+0x1eb>
    3289:	48 8d 0c 32          	lea    (%rdx,%rsi,1),%rcx
    328d:	48 81 c1 28 02 00 00 	add    $0x228,%rcx
    3294:	80 39 00             	cmpb   $0x0,(%rcx)
    3297:	74 27                	je     32c0 <e2+0x210>
    3299:	eb 2a                	jmp    32c5 <e2+0x215>
    329b:	40 80 ff 01          	cmp    $0x1,%dil
    329f:	75 1f                	jne    32c0 <e2+0x210>
    32a1:	48 8d 3c 32          	lea    (%rdx,%rsi,1),%rdi
    32a5:	8b 54 32 20          	mov    0x20(%rdx,%rsi,1),%edx
    32a9:	48 0f af ca          	imul   %rdx,%rcx
    32ad:	48 c1 e9 20          	shr    $0x20,%rcx
    32b1:	48 01 f9             	add    %rdi,%rcx
    32b4:	48 81 c1 28 02 00 00 	add    $0x228,%rcx
    32bb:	80 39 00             	cmpb   $0x0,(%rcx)
    32be:	75 05                	jne    32c5 <e2+0x215>
    32c0:	48 83 c4 18          	add    $0x18,%rsp
    32c4:	c3                   	ret
    32c5:	e8 e6 05 00 00       	call   38b0 <fwp_flush>
    32ca:	48 8b 05 0f bd 00 00 	mov    0xbd0f(%rip),%rax        # efe0 <stderr@GLIBC_2.2.5>
    32d1:	48 8b 38             	mov    (%rax),%rdi
    32d4:	48 8d 35 59 90 00 00 	lea    0x9059(%rip),%rsi        # c334 <fwp_segv.msg+0xf4>
    32db:	48 8d 15 25 90 00 00 	lea    0x9025(%rip),%rdx        # c307 <fwp_segv.msg+0xc7>
    32e2:	31 c0                	xor    %eax,%eax
    32e4:	e8 f7 ee ff ff       	call   21e0 <fprintf@plt>
    32e9:	bf 65 00 00 00       	mov    $0x65,%edi
    32ee:	e8 dd ef ff ff       	call   22d0 <exit@plt>
    32f3:	66 66 66 66 2e 0f 1f 	data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    32fa:	84 00 00 00 00 00 

0000000000003300 <e3>:
    3300:	50                   	push   %rax
    3301:	48 89 f8             	mov    %rdi,%rax
    3304:	48 8b 3f             	mov    (%rdi),%rdi
    3307:	48 8b 0d ca ce 00 00 	mov    0xceca(%rip),%rcx        # 101d8 <fwp_gc+0x1030>
    330e:	48 89 fe             	mov    %rdi,%rsi
    3311:	48 29 ce             	sub    %rcx,%rsi
    3314:	48 8b 15 e5 ce 00 00 	mov    0xcee5(%rip),%rdx        # 10200 <fwp_gc+0x1058>
    331b:	48 c1 e2 10          	shl    $0x10,%rdx
    331f:	48 39 d6             	cmp    %rdx,%rsi
    3322:	73 68                	jae    338c <e3+0x8c>
    3324:	4c 8b 05 f5 ce 00 00 	mov    0xcef5(%rip),%r8        # 10220 <fwp_gc+0x1078>
    332b:	49 89 f1             	mov    %rsi,%r9
    332e:	49 c1 e9 10          	shr    $0x10,%r9
    3332:	4d 69 c9 28 12 00 00 	imul   $0x1228,%r9,%r9
    3339:	47 0f b6 14 08       	movzbl (%r8,%r9,1),%r10d
    333e:	48 81 e6 ff ff 00 00 	and    $0xffff,%rsi
    3345:	75 1b                	jne    3362 <e3+0x62>
    3347:	41 80 fa 02          	cmp    $0x2,%r10b
    334b:	75 15                	jne    3362 <e3+0x62>
    334d:	4b 8d 34 08          	lea    (%r8,%r9,1),%rsi
    3351:	48 81 c6 28 02 00 00 	add    $0x228,%rsi
    3358:	80 3e 00             	cmpb   $0x0,(%rsi)
    335b:	74 2f                	je     338c <e3+0x8c>
    335d:	e9 1d 01 00 00       	jmp    347f <e3+0x17f>
    3362:	41 80 fa 01          	cmp    $0x1,%r10b
    3366:	75 24                	jne    338c <e3+0x8c>
    3368:	4f 8d 14 08          	lea    (%r8,%r9,1),%r10
    336c:	47 8b 44 08 20       	mov    0x20(%r8,%r9,1),%r8d
    3371:	49 0f af f0          	imul   %r8,%rsi
    3375:	48 c1 ee 20          	shr    $0x20,%rsi
    3379:	4c 01 d6             	add    %r10,%rsi
    337c:	48 81 c6 28 02 00 00 	add    $0x228,%rsi
    3383:	80 3e 00             	cmpb   $0x0,(%rsi)
    3386:	0f 85 f3 00 00 00    	jne    347f <e3+0x17f>
    338c:	48 8b 70 08          	mov    0x8(%rax),%rsi
    3390:	48 89 f0             	mov    %rsi,%rax
    3393:	48 29 c8             	sub    %rcx,%rax
    3396:	48 39 d0             	cmp    %rdx,%rax
    3399:	73 64                	jae    33ff <e3+0xff>
    339b:	48 8b 0d 7e ce 00 00 	mov    0xce7e(%rip),%rcx        # 10220 <fwp_gc+0x1078>
    33a2:	48 89 c2             	mov    %rax,%rdx
    33a5:	48 c1 ea 10          	shr    $0x10,%rdx
    33a9:	48 69 d2 28 12 00 00 	imul   $0x1228,%rdx,%rdx
    33b0:	44 0f b6 04 11       	movzbl (%rcx,%rdx,1),%r8d
    33b5:	48 25 ff ff 00 00    	and    $0xffff,%rax
    33bb:	75 1a                	jne    33d7 <e3+0xd7>
    33bd:	41 80 f8 02          	cmp    $0x2,%r8b
    33c1:	75 14                	jne    33d7 <e3+0xd7>
    33c3:	48 8d 04 11          	lea    (%rcx,%rdx,1),%rax
    33c7:	48 05 28 02 00 00    	add    $0x228,%rax
    33cd:	80 38 00             	cmpb   $0x0,(%rax)
    33d0:	74 2d                	je     33ff <e3+0xff>
    33d2:	e9 a8 00 00 00       	jmp    347f <e3+0x17f>
    33d7:	41 80 f8 01          	cmp    $0x1,%r8b
    33db:	75 22                	jne    33ff <e3+0xff>
    33dd:	4c 8d 04 11          	lea    (%rcx,%rdx,1),%r8
    33e1:	8b 4c 11 20          	mov    0x20(%rcx,%rdx,1),%ecx
    33e5:	48 0f af c1          	imul   %rcx,%rax
    33e9:	48 c1 e8 20          	shr    $0x20,%rax
    33ed:	4c 01 c0             	add    %r8,%rax
    33f0:	48 05 28 02 00 00    	add    $0x228,%rax
    33f6:	80 38 00             	cmpb   $0x0,(%rax)
    33f9:	0f 85 80 00 00 00    	jne    347f <e3+0x17f>
    33ff:	e8 4c 3b 00 00       	call   6f50 <fwp_p_file_with_owned>
    3404:	48 89 c1             	mov    %rax,%rcx
    3407:	48 2b 0d ca cd 00 00 	sub    0xcdca(%rip),%rcx        # 101d8 <fwp_gc+0x1030>
    340e:	48 8b 15 eb cd 00 00 	mov    0xcdeb(%rip),%rdx        # 10200 <fwp_gc+0x1058>
    3415:	48 c1 e2 10          	shl    $0x10,%rdx
    3419:	48 39 d1             	cmp    %rdx,%rcx
    341c:	73 5f                	jae    347d <e3+0x17d>
    341e:	48 8b 15 fb cd 00 00 	mov    0xcdfb(%rip),%rdx        # 10220 <fwp_gc+0x1078>
    3425:	48 89 ce             	mov    %rcx,%rsi
    3428:	48 c1 ee 10          	shr    $0x10,%rsi
    342c:	48 69 f6 28 12 00 00 	imul   $0x1228,%rsi,%rsi
    3433:	0f b6 3c 32          	movzbl (%rdx,%rsi,1),%edi
    3437:	48 81 e1 ff ff 00 00 	and    $0xffff,%rcx
    343e:	75 18                	jne    3458 <e3+0x158>
    3440:	40 80 ff 02          	cmp    $0x2,%dil
    3444:	75 12                	jne    3458 <e3+0x158>
    3446:	48 8d 0c 32          	lea    (%rdx,%rsi,1),%rcx
    344a:	48 81 c1 28 02 00 00 	add    $0x228,%rcx
    3451:	80 39 00             	cmpb   $0x0,(%rcx)
    3454:	74 27                	je     347d <e3+0x17d>
    3456:	eb 27                	jmp    347f <e3+0x17f>
    3458:	40 80 ff 01          	cmp    $0x1,%dil
    345c:	75 1f                	jne    347d <e3+0x17d>
    345e:	48 8d 3c 32          	lea    (%rdx,%rsi,1),%rdi
    3462:	8b 54 32 20          	mov    0x20(%rdx,%rsi,1),%edx
    3466:	48 0f af ca          	imul   %rdx,%rcx
    346a:	48 c1 e9 20          	shr    $0x20,%rcx
    346e:	48 01 f9             	add    %rdi,%rcx
    3471:	48 81 c1 28 02 00 00 	add    $0x228,%rcx
    3478:	80 39 00             	cmpb   $0x0,(%rcx)
    347b:	75 02                	jne    347f <e3+0x17f>
    347d:	59                   	pop    %rcx
    347e:	c3                   	ret
    347f:	e8 2c 04 00 00       	call   38b0 <fwp_flush>
    3484:	48 8b 05 55 bb 00 00 	mov    0xbb55(%rip),%rax        # efe0 <stderr@GLIBC_2.2.5>
    348b:	48 8b 38             	mov    (%rax),%rdi
    348e:	48 8d 35 9f 8e 00 00 	lea    0x8e9f(%rip),%rsi        # c334 <fwp_segv.msg+0xf4>
    3495:	48 8d 15 6b 8e 00 00 	lea    0x8e6b(%rip),%rdx        # c307 <fwp_segv.msg+0xc7>
    349c:	31 c0                	xor    %eax,%eax
    349e:	e8 3d ed ff ff       	call   21e0 <fprintf@plt>
    34a3:	bf 65 00 00 00       	mov    $0x65,%edi
    34a8:	e8 23 ee ff ff       	call   22d0 <exit@plt>
    34ad:	0f 1f 00             	nopl   (%rax)

00000000000034b0 <e4>:
    34b0:	50                   	push   %rax
    34b1:	48 8b 3f             	mov    (%rdi),%rdi
    34b4:	48 89 f8             	mov    %rdi,%rax
    34b7:	48 2b 05 1a cd 00 00 	sub    0xcd1a(%rip),%rax        # 101d8 <fwp_gc+0x1030>
    34be:	48 8b 0d 3b cd 00 00 	mov    0xcd3b(%rip),%rcx        # 10200 <fwp_gc+0x1058>
    34c5:	48 c1 e1 10          	shl    $0x10,%rcx
    34c9:	48 39 c8             	cmp    %rcx,%rax
    34cc:	73 63                	jae    3531 <e4+0x81>
    34ce:	48 8b 0d 4b cd 00 00 	mov    0xcd4b(%rip),%rcx        # 10220 <fwp_gc+0x1078>
    34d5:	48 89 c2             	mov    %rax,%rdx
    34d8:	48 c1 ea 10          	shr    $0x10,%rdx
    34dc:	48 69 d2 28 12 00 00 	imul   $0x1228,%rdx,%rdx
    34e3:	0f b6 34 11          	movzbl (%rcx,%rdx,1),%esi
    34e7:	48 25 ff ff 00 00    	and    $0xffff,%rax
    34ed:	75 1a                	jne    3509 <e4+0x59>
    34ef:	40 80 fe 02          	cmp    $0x2,%sil
    34f3:	75 14                	jne    3509 <e4+0x59>
    34f5:	48 8d 04 11          	lea    (%rcx,%rdx,1),%rax
    34f9:	48 05 28 02 00 00    	add    $0x228,%rax
    34ff:	80 38 00             	cmpb   $0x0,(%rax)
    3502:	74 2d                	je     3531 <e4+0x81>
    3504:	e9 a8 00 00 00       	jmp    35b1 <e4+0x101>
    3509:	40 80 fe 01          	cmp    $0x1,%sil
    350d:	75 22                	jne    3531 <e4+0x81>
    350f:	48 8d 34 11          	lea    (%rcx,%rdx,1),%rsi
    3513:	8b 4c 11 20          	mov    0x20(%rcx,%rdx,1),%ecx
    3517:	48 0f af c1          	imul   %rcx,%rax
    351b:	48 c1 e8 20          	shr    $0x20,%rax
    351f:	48 01 f0             	add    %rsi,%rax
    3522:	48 05 28 02 00 00    	add    $0x228,%rax
    3528:	80 38 00             	cmpb   $0x0,(%rax)
    352b:	0f 85 80 00 00 00    	jne    35b1 <e4+0x101>
    3531:	e8 da 6c 00 00       	call   a210 <f4>
    3536:	48 89 c1             	mov    %rax,%rcx
    3539:	48 2b 0d 98 cc 00 00 	sub    0xcc98(%rip),%rcx        # 101d8 <fwp_gc+0x1030>
    3540:	48 8b 15 b9 cc 00 00 	mov    0xccb9(%rip),%rdx        # 10200 <fwp_gc+0x1058>
    3547:	48 c1 e2 10          	shl    $0x10,%rdx
    354b:	48 39 d1             	cmp    %rdx,%rcx
    354e:	73 5f                	jae    35af <e4+0xff>
    3550:	48 8b 15 c9 cc 00 00 	mov    0xccc9(%rip),%rdx        # 10220 <fwp_gc+0x1078>
    3557:	48 89 ce             	mov    %rcx,%rsi
    355a:	48 c1 ee 10          	shr    $0x10,%rsi
    355e:	48 69 f6 28 12 00 00 	imul   $0x1228,%rsi,%rsi
    3565:	0f b6 3c 32          	movzbl (%rdx,%rsi,1),%edi
    3569:	48 81 e1 ff ff 00 00 	and    $0xffff,%rcx
    3570:	75 18                	jne    358a <e4+0xda>
    3572:	40 80 ff 02          	cmp    $0x2,%dil
    3576:	75 12                	jne    358a <e4+0xda>
    3578:	48 8d 0c 32          	lea    (%rdx,%rsi,1),%rcx
    357c:	48 81 c1 28 02 00 00 	add    $0x228,%rcx
    3583:	80 39 00             	cmpb   $0x0,(%rcx)
    3586:	74 27                	je     35af <e4+0xff>
    3588:	eb 27                	jmp    35b1 <e4+0x101>
    358a:	40 80 ff 01          	cmp    $0x1,%dil
    358e:	75 1f                	jne    35af <e4+0xff>
    3590:	48 8d 3c 32          	lea    (%rdx,%rsi,1),%rdi
    3594:	8b 54 32 20          	mov    0x20(%rdx,%rsi,1),%edx
    3598:	48 0f af ca          	imul   %rdx,%rcx
    359c:	48 c1 e9 20          	shr    $0x20,%rcx
    35a0:	48 01 f9             	add    %rdi,%rcx
    35a3:	48 81 c1 28 02 00 00 	add    $0x228,%rcx
    35aa:	80 39 00             	cmpb   $0x0,(%rcx)
    35ad:	75 02                	jne    35b1 <e4+0x101>
    35af:	59                   	pop    %rcx
    35b0:	c3                   	ret
    35b1:	e8 fa 02 00 00       	call   38b0 <fwp_flush>
    35b6:	48 8b 05 23 ba 00 00 	mov    0xba23(%rip),%rax        # efe0 <stderr@GLIBC_2.2.5>
    35bd:	48 8b 38             	mov    (%rax),%rdi
    35c0:	48 8d 35 6d 8d 00 00 	lea    0x8d6d(%rip),%rsi        # c334 <fwp_segv.msg+0xf4>
    35c7:	48 8d 15 39 8d 00 00 	lea    0x8d39(%rip),%rdx        # c307 <fwp_segv.msg+0xc7>
    35ce:	31 c0                	xor    %eax,%eax
    35d0:	e8 0b ec ff ff       	call   21e0 <fprintf@plt>
    35d5:	bf 65 00 00 00       	mov    $0x65,%edi
    35da:	e8 f1 ec ff ff       	call   22d0 <exit@plt>
    35df:	90                   	nop

00000000000035e0 <e8>:
    35e0:	50                   	push   %rax
    35e1:	48 8b 3f             	mov    (%rdi),%rdi
    35e4:	48 89 f8             	mov    %rdi,%rax
    35e7:	48 2b 05 ea cb 00 00 	sub    0xcbea(%rip),%rax        # 101d8 <fwp_gc+0x1030>
    35ee:	48 8b 0d 0b cc 00 00 	mov    0xcc0b(%rip),%rcx        # 10200 <fwp_gc+0x1058>
    35f5:	48 c1 e1 10          	shl    $0x10,%rcx
    35f9:	48 39 c8             	cmp    %rcx,%rax
    35fc:	73 63                	jae    3661 <e8+0x81>
    35fe:	48 8b 0d 1b cc 00 00 	mov    0xcc1b(%rip),%rcx        # 10220 <fwp_gc+0x1078>
    3605:	48 89 c2             	mov    %rax,%rdx
    3608:	48 c1 ea 10          	shr    $0x10,%rdx
    360c:	48 69 d2 28 12 00 00 	imul   $0x1228,%rdx,%rdx
    3613:	0f b6 34 11          	movzbl (%rcx,%rdx,1),%esi
    3617:	48 25 ff ff 00 00    	and    $0xffff,%rax
    361d:	75 1a                	jne    3639 <e8+0x59>
    361f:	40 80 fe 02          	cmp    $0x2,%sil
    3623:	75 14                	jne    3639 <e8+0x59>
    3625:	48 8d 04 11          	lea    (%rcx,%rdx,1),%rax
    3629:	48 05 28 02 00 00    	add    $0x228,%rax
    362f:	80 38 00             	cmpb   $0x0,(%rax)
    3632:	74 2d                	je     3661 <e8+0x81>
    3634:	e9 a8 00 00 00       	jmp    36e1 <e8+0x101>
    3639:	40 80 fe 01          	cmp    $0x1,%sil
    363d:	75 22                	jne    3661 <e8+0x81>
    363f:	48 8d 34 11          	lea    (%rcx,%rdx,1),%rsi
    3643:	8b 4c 11 20          	mov    0x20(%rcx,%rdx,1),%ecx
    3647:	48 0f af c1          	imul   %rcx,%rax
    364b:	48 c1 e8 20          	shr    $0x20,%rax
    364f:	48 01 f0             	add    %rsi,%rax
    3652:	48 05 28 02 00 00    	add    $0x228,%rax
    3658:	80 38 00             	cmpb   $0x0,(%rax)
    365b:	0f 85 80 00 00 00    	jne    36e1 <e8+0x101>
    3661:	e8 3a 73 00 00       	call   a9a0 <f8>
    3666:	48 89 c1             	mov    %rax,%rcx
    3669:	48 2b 0d 68 cb 00 00 	sub    0xcb68(%rip),%rcx        # 101d8 <fwp_gc+0x1030>
    3670:	48 8b 15 89 cb 00 00 	mov    0xcb89(%rip),%rdx        # 10200 <fwp_gc+0x1058>
    3677:	48 c1 e2 10          	shl    $0x10,%rdx
    367b:	48 39 d1             	cmp    %rdx,%rcx
    367e:	73 5f                	jae    36df <e8+0xff>
    3680:	48 8b 15 99 cb 00 00 	mov    0xcb99(%rip),%rdx        # 10220 <fwp_gc+0x1078>
    3687:	48 89 ce             	mov    %rcx,%rsi
    368a:	48 c1 ee 10          	shr    $0x10,%rsi
    368e:	48 69 f6 28 12 00 00 	imul   $0x1228,%rsi,%rsi
    3695:	0f b6 3c 32          	movzbl (%rdx,%rsi,1),%edi
    3699:	48 81 e1 ff ff 00 00 	and    $0xffff,%rcx
    36a0:	75 18                	jne    36ba <e8+0xda>
    36a2:	40 80 ff 02          	cmp    $0x2,%dil
    36a6:	75 12                	jne    36ba <e8+0xda>
    36a8:	48 8d 0c 32          	lea    (%rdx,%rsi,1),%rcx
    36ac:	48 81 c1 28 02 00 00 	add    $0x228,%rcx
    36b3:	80 39 00             	cmpb   $0x0,(%rcx)
    36b6:	74 27                	je     36df <e8+0xff>
    36b8:	eb 27                	jmp    36e1 <e8+0x101>
    36ba:	40 80 ff 01          	cmp    $0x1,%dil
    36be:	75 1f                	jne    36df <e8+0xff>
    36c0:	48 8d 3c 32          	lea    (%rdx,%rsi,1),%rdi
    36c4:	8b 54 32 20          	mov    0x20(%rdx,%rsi,1),%edx
    36c8:	48 0f af ca          	imul   %rdx,%rcx
    36cc:	48 c1 e9 20          	shr    $0x20,%rcx
    36d0:	48 01 f9             	add    %rdi,%rcx
    36d3:	48 81 c1 28 02 00 00 	add    $0x228,%rcx
    36da:	80 39 00             	cmpb   $0x0,(%rcx)
    36dd:	75 02                	jne    36e1 <e8+0x101>
    36df:	59                   	pop    %rcx
    36e0:	c3                   	ret
    36e1:	e8 ca 01 00 00       	call   38b0 <fwp_flush>
    36e6:	48 8b 05 f3 b8 00 00 	mov    0xb8f3(%rip),%rax        # efe0 <stderr@GLIBC_2.2.5>
    36ed:	48 8b 38             	mov    (%rax),%rdi
    36f0:	48 8d 35 3d 8c 00 00 	lea    0x8c3d(%rip),%rsi        # c334 <fwp_segv.msg+0xf4>
    36f7:	48 8d 15 09 8c 00 00 	lea    0x8c09(%rip),%rdx        # c307 <fwp_segv.msg+0xc7>
    36fe:	31 c0                	xor    %eax,%eax
    3700:	e8 db ea ff ff       	call   21e0 <fprintf@plt>
    3705:	bf 65 00 00 00       	mov    $0x65,%edi
    370a:	e8 c1 eb ff ff       	call   22d0 <exit@plt>
    370f:	90                   	nop

0000000000003710 <e9>:
    3710:	50                   	push   %rax
    3711:	48 8b 3f             	mov    (%rdi),%rdi
    3714:	48 89 f8             	mov    %rdi,%rax
    3717:	48 2b 05 ba ca 00 00 	sub    0xcaba(%rip),%rax        # 101d8 <fwp_gc+0x1030>
    371e:	48 8b 0d db ca 00 00 	mov    0xcadb(%rip),%rcx        # 10200 <fwp_gc+0x1058>
    3725:	48 c1 e1 10          	shl    $0x10,%rcx
    3729:	48 39 c8             	cmp    %rcx,%rax
    372c:	73 63                	jae    3791 <e9+0x81>
    372e:	48 8b 0d eb ca 00 00 	mov    0xcaeb(%rip),%rcx        # 10220 <fwp_gc+0x1078>
    3735:	48 89 c2             	mov    %rax,%rdx
    3738:	48 c1 ea 10          	shr    $0x10,%rdx
    373c:	48 69 d2 28 12 00 00 	imul   $0x1228,%rdx,%rdx
    3743:	0f b6 34 11          	movzbl (%rcx,%rdx,1),%esi
    3747:	48 25 ff ff 00 00    	and    $0xffff,%rax
    374d:	75 1a                	jne    3769 <e9+0x59>
    374f:	40 80 fe 02          	cmp    $0x2,%sil
    3753:	75 14                	jne    3769 <e9+0x59>
    3755:	48 8d 04 11          	lea    (%rcx,%rdx,1),%rax
    3759:	48 05 28 02 00 00    	add    $0x228,%rax
    375f:	80 38 00             	cmpb   $0x0,(%rax)
    3762:	74 2d                	je     3791 <e9+0x81>
    3764:	e9 ca 00 00 00       	jmp    3833 <e9+0x123>
    3769:	40 80 fe 01          	cmp    $0x1,%sil
    376d:	75 22                	jne    3791 <e9+0x81>
    376f:	48 8d 34 11          	lea    (%rcx,%rdx,1),%rsi
    3773:	8b 4c 11 20          	mov    0x20(%rcx,%rdx,1),%ecx
    3777:	48 0f af c1          	imul   %rcx,%rax
    377b:	48 c1 e8 20          	shr    $0x20,%rax
    377f:	48 01 f0             	add    %rsi,%rax
    3782:	48 05 28 02 00 00    	add    $0x228,%rax
    3788:	80 38 00             	cmpb   $0x0,(%rax)
    378b:	0f 85 a2 00 00 00    	jne    3833 <e9+0x123>
    3791:	48 8b 17             	mov    (%rdi),%rdx
    3794:	48 83 c7 08          	add    $0x8,%rdi
    3798:	48 8b 0d b9 d4 00 00 	mov    0xd4b9(%rip),%rcx        # 10c58 <fwp_prog_out>
    379f:	be 01 00 00 00       	mov    $0x1,%esi
    37a4:	e8 37 eb ff ff       	call   22e0 <fwrite@plt>
    37a9:	48 8b 35 a8 d4 00 00 	mov    0xd4a8(%rip),%rsi        # 10c58 <fwp_prog_out>
    37b0:	bf 0a 00 00 00       	mov    $0xa,%edi
    37b5:	e8 b6 e9 ff ff       	call   2170 <fputc@plt>
    37ba:	31 c0                	xor    %eax,%eax
    37bc:	48 2b 05 15 ca 00 00 	sub    0xca15(%rip),%rax        # 101d8 <fwp_gc+0x1030>
    37c3:	48 8b 0d 36 ca 00 00 	mov    0xca36(%rip),%rcx        # 10200 <fwp_gc+0x1058>
    37ca:	48 c1 e1 10          	shl    $0x10,%rcx
    37ce:	48 39 c1             	cmp    %rax,%rcx
    37d1:	76 5c                	jbe    382f <e9+0x11f>
    37d3:	48 8b 0d 46 ca 00 00 	mov    0xca46(%rip),%rcx        # 10220 <fwp_gc+0x1078>
    37da:	48 89 c2             	mov    %rax,%rdx
    37dd:	48 c1 ea 10          	shr    $0x10,%rdx
    37e1:	48 69 d2 28 12 00 00 	imul   $0x1228,%rdx,%rdx
    37e8:	0f b6 34 11          	movzbl (%rcx,%rdx,1),%esi
    37ec:	48 25 ff ff 00 00    	and    $0xffff,%rax
    37f2:	75 17                	jne    380b <e9+0xfb>
    37f4:	40 80 fe 02          	cmp    $0x2,%sil
    37f8:	75 11                	jne    380b <e9+0xfb>
    37fa:	48 8d 04 11          	lea    (%rcx,%rdx,1),%rax
    37fe:	48 05 28 02 00 00    	add    $0x228,%rax
    3804:	80 38 00             	cmpb   $0x0,(%rax)
    3807:	74 26                	je     382f <e9+0x11f>
    3809:	eb 28                	jmp    3833 <e9+0x123>
    380b:	40 80 fe 01          	cmp    $0x1,%sil
    380f:	75 1e                	jne    382f <e9+0x11f>
    3811:	48 8d 34 11          	lea    (%rcx,%rdx,1),%rsi
    3815:	8b 4c 11 20          	mov    0x20(%rcx,%rdx,1),%ecx
    3819:	48 0f af c1          	imul   %rcx,%rax
    381d:	48 c1 e8 20          	shr    $0x20,%rax
    3821:	48 01 f0             	add    %rsi,%rax
    3824:	48 05 28 02 00 00    	add    $0x228,%rax
    382a:	80 38 00             	cmpb   $0x0,(%rax)
    382d:	75 04                	jne    3833 <e9+0x123>
    382f:	31 c0                	xor    %eax,%eax
    3831:	59                   	pop    %rcx
    3832:	c3                   	ret
    3833:	e8 78 00 00 00       	call   38b0 <fwp_flush>
    3838:	48 8b 05 a1 b7 00 00 	mov    0xb7a1(%rip),%rax        # efe0 <stderr@GLIBC_2.2.5>
    383f:	48 8b 38             	mov    (%rax),%rdi
    3842:	48 8d 35 eb 8a 00 00 	lea    0x8aeb(%rip),%rsi        # c334 <fwp_segv.msg+0xf4>
    3849:	48 8d 15 b7 8a 00 00 	lea    0x8ab7(%rip),%rdx        # c307 <fwp_segv.msg+0xc7>
    3850:	31 c0                	xor    %eax,%eax
    3852:	e8 89 e9 ff ff       	call   21e0 <fprintf@plt>
    3857:	bf 65 00 00 00       	mov    $0x65,%edi
    385c:	e8 6f ea ff ff       	call   22d0 <exit@plt>
    3861:	66 66 66 66 66 66 2e 	data16 data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    3868:	0f 1f 84 00 00 00 00 
    386f:	00 

0000000000003870 <fwp_cleanup_unwind>:
    3870:	53                   	push   %rbx
    3871:	48 8b 05 00 d4 00 00 	mov    0xd400(%rip),%rax        # 10c78 <fwp_cleanups>
    3878:	48 39 f8             	cmp    %rdi,%rax
    387b:	74 25                	je     38a2 <fwp_cleanup_unwind+0x32>
    387d:	48 89 fb             	mov    %rdi,%rbx
    3880:	48 85 c0             	test   %rax,%rax
    3883:	74 1f                	je     38a4 <fwp_cleanup_unwind+0x34>
    3885:	48 8b 08             	mov    (%rax),%rcx
    3888:	48 89 0d e9 d3 00 00 	mov    %rcx,0xd3e9(%rip)        # 10c78 <fwp_cleanups>
    388f:	48 8b 78 10          	mov    0x10(%rax),%rdi
    3893:	ff 50 08             	call   *0x8(%rax)
    3896:	48 8b 05 db d3 00 00 	mov    0xd3db(%rip),%rax        # 10c78 <fwp_cleanups>
    389d:	48 39 d8             	cmp    %rbx,%rax
    38a0:	75 de                	jne    3880 <fwp_cleanup_unwind+0x10>
    38a2:	5b                   	pop    %rbx
    38a3:	c3                   	ret
    38a4:	e8 b7 e7 ff ff       	call   2060 <abort@plt>
    38a9:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)

00000000000038b0 <fwp_flush>:
    38b0:	50                   	push   %rax
    38b1:	48 8b 3d a0 d3 00 00 	mov    0xd3a0(%rip),%rdi        # 10c58 <fwp_prog_out>
    38b8:	48 85 ff             	test   %rdi,%rdi
    38bb:	74 05                	je     38c2 <fwp_flush+0x12>
    38bd:	e8 6e e9 ff ff       	call   2230 <fflush@plt>
    38c2:	48 8b 05 f7 b6 00 00 	mov    0xb6f7(%rip),%rax        # efc0 <stdout@GLIBC_2.2.5>
    38c9:	48 8b 38             	mov    (%rax),%rdi
    38cc:	58                   	pop    %rax
    38cd:	e9 5e e9 ff ff       	jmp    2230 <fflush@plt>
    38d2:	66 66 66 66 66 2e 0f 	data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    38d9:	1f 84 00 00 00 00 00 

00000000000038e0 <fwp_rc_forget_slot>:
    38e0:	50                   	push   %rax
    38e1:	80 3f ff             	cmpb   $0xff,(%rdi)
    38e4:	74 02                	je     38e8 <fwp_rc_forget_slot+0x8>
    38e6:	58                   	pop    %rax
    38e7:	c3                   	ret
    38e8:	48 89 f8             	mov    %rdi,%rax
    38eb:	48 c1 e8 11          	shr    $0x11,%rax
    38ef:	31 f8                	xor    %edi,%eax
    38f1:	89 c1                	mov    %eax,%ecx
    38f3:	c1 e9 09             	shr    $0x9,%ecx
    38f6:	31 c1                	xor    %eax,%ecx
    38f8:	0f b6 c9             	movzbl %cl,%ecx
    38fb:	48 8d 15 a6 b8 00 00 	lea    0xb8a6(%rip),%rdx        # f1a8 <fwp_gc>
    3902:	48 8b 84 ca 18 12 00 	mov    0x1218(%rdx,%rcx,8),%rax
    3909:	00 
    390a:	48 85 c0             	test   %rax,%rax
    390d:	74 4b                	je     395a <fwp_rc_forget_slot+0x7a>
    390f:	48 39 38             	cmp    %rdi,(%rax)
    3912:	74 23                	je     3937 <fwp_rc_forget_slot+0x57>
    3914:	66 66 66 2e 0f 1f 84 	data16 data16 cs nopw 0x0(%rax,%rax,1)
    391b:	00 00 00 00 00 
    3920:	48 89 c1             	mov    %rax,%rcx
    3923:	48 8b 40 10          	mov    0x10(%rax),%rax
    3927:	48 85 c0             	test   %rax,%rax
    392a:	74 2e                	je     395a <fwp_rc_forget_slot+0x7a>
    392c:	48 39 38             	cmp    %rdi,(%rax)
    392f:	75 ef                	jne    3920 <fwp_rc_forget_slot+0x40>
    3931:	48 83 c1 10          	add    $0x10,%rcx
    3935:	eb 0b                	jmp    3942 <fwp_rc_forget_slot+0x62>
    3937:	48 8d 0c ca          	lea    (%rdx,%rcx,8),%rcx
    393b:	48 81 c1 18 12 00 00 	add    $0x1218,%rcx
    3942:	48 8b 50 10          	mov    0x10(%rax),%rdx
    3946:	48 89 11             	mov    %rdx,(%rcx)
    3949:	48 89 c7             	mov    %rax,%rdi
    394c:	e8 ff e6 ff ff       	call   2050 <free@plt>
    3951:	48 ff 0d 68 d2 00 00 	decq   0xd268(%rip)        # 10bc0 <fwp_gc+0x1a18>
    3958:	58                   	pop    %rax
    3959:	c3                   	ret
    395a:	e8 51 ff ff ff       	call   38b0 <fwp_flush>
    395f:	48 8b 05 7a b6 00 00 	mov    0xb67a(%rip),%rax        # efe0 <stderr@GLIBC_2.2.5>
    3966:	48 8b 38             	mov    (%rax),%rdi
    3969:	48 8d 35 c4 89 00 00 	lea    0x89c4(%rip),%rsi        # c334 <fwp_segv.msg+0xf4>
    3970:	48 8d 15 cc 89 00 00 	lea    0x89cc(%rip),%rdx        # c343 <fwp_segv.msg+0x103>
    3977:	31 c0                	xor    %eax,%eax
    3979:	e8 62 e8 ff ff       	call   21e0 <fprintf@plt>
    397e:	bf 65 00 00 00       	mov    $0x65,%edi
    3983:	e8 48 e9 ff ff       	call   22d0 <exit@plt>
    3988:	0f 1f 84 00 00 00 00 	nopl   0x0(%rax,%rax,1)
    398f:	00 

0000000000003990 <fwp_p_attempt_owned>:
    3990:	41 57                	push   %r15
    3992:	41 56                	push   %r14
    3994:	41 54                	push   %r12
    3996:	53                   	push   %rbx
    3997:	48 81 ec 28 01 00 00 	sub    $0x128,%rsp
    399e:	48 89 fb             	mov    %rdi,%rbx
    39a1:	48 89 34 24          	mov    %rsi,(%rsp)
    39a5:	48 8b 05 d4 d2 00 00 	mov    0xd2d4(%rip),%rax        # 10c80 <fwp_handlers>
    39ac:	48 89 84 24 00 01 00 	mov    %rax,0x100(%rsp)
    39b3:	00 
    39b4:	48 8b 05 cd d2 00 00 	mov    0xd2cd(%rip),%rax        # 10c88 <fwp_state_len>
    39bb:	48 89 84 24 18 01 00 	mov    %rax,0x118(%rsp)
    39c2:	00 
    39c3:	48 8b 05 ae d2 00 00 	mov    0xd2ae(%rip),%rax        # 10c78 <fwp_cleanups>
    39ca:	48 89 84 24 20 01 00 	mov    %rax,0x120(%rsp)
    39d1:	00 
    39d2:	48 8d 7c 24 38       	lea    0x38(%rsp),%rdi
    39d7:	48 89 3d a2 d2 00 00 	mov    %rdi,0xd2a2(%rip)        # 10c80 <fwp_handlers>
    39de:	e8 bd e7 ff ff       	call   21a0 <_setjmp@plt>
    39e3:	85 c0                	test   %eax,%eax
    39e5:	74 25                	je     3a0c <fwp_p_attempt_owned+0x7c>
    39e7:	48 8b 8c 24 08 01 00 	mov    0x108(%rsp),%rcx
    39ee:	00 
    39ef:	48 8b 84 24 18 01 00 	mov    0x118(%rsp),%rax
    39f6:	00 
    39f7:	48 89 05 8a d2 00 00 	mov    %rax,0xd28a(%rip)        # 10c88 <fwp_state_len>
    39fe:	bf 01 00 00 00       	mov    $0x1,%edi
    3a03:	48 8d 05 e6 01 00 00 	lea    0x1e6(%rip),%rax        # 3bf0 <fwp_drop3>
    3a0a:	eb 1d                	jmp    3a29 <fwp_p_attempt_owned+0x99>
    3a0c:	48 89 e6             	mov    %rsp,%rsi
    3a0f:	48 89 df             	mov    %rbx,%rdi
    3a12:	e8 d9 03 00 00       	call   3df0 <fwp_apply_borrowed>
    3a17:	31 ff                	xor    %edi,%edi
    3a19:	48 8d 0d 30 01 00 00 	lea    0x130(%rip),%rcx        # 3b50 <fwp_drop2>
    3a20:	48 89 c2             	mov    %rax,%rdx
    3a23:	48 89 c8             	mov    %rcx,%rax
    3a26:	48 89 d1             	mov    %rdx,%rcx
    3a29:	48 89 4c 24 18       	mov    %rcx,0x18(%rsp)
    3a2e:	48 8b 94 24 00 01 00 	mov    0x100(%rsp),%rdx
    3a35:	00 
    3a36:	48 89 15 43 d2 00 00 	mov    %rdx,0xd243(%rip)        # 10c80 <fwp_handlers>
    3a3d:	48 89 4c 24 08       	mov    %rcx,0x8(%rsp)
    3a42:	48 89 44 24 10       	mov    %rax,0x10(%rsp)
    3a47:	48 8b 05 2a d2 00 00 	mov    0xd22a(%rip),%rax        # 10c78 <fwp_cleanups>
    3a4e:	48 89 44 24 20       	mov    %rax,0x20(%rsp)
    3a53:	48 8d 05 e6 2f 00 00 	lea    0x2fe6(%rip),%rax        # 6a40 <fwp_value_release>
    3a5a:	48 89 44 24 28       	mov    %rax,0x28(%rsp)
    3a5f:	48 8d 44 24 08       	lea    0x8(%rsp),%rax
    3a64:	48 89 44 24 30       	mov    %rax,0x30(%rsp)
    3a69:	4c 8d 7c 24 20       	lea    0x20(%rsp),%r15
    3a6e:	4c 89 3d 03 d2 00 00 	mov    %r15,0xd203(%rip)        # 10c78 <fwp_cleanups>
    3a75:	48 8d 54 24 18       	lea    0x18(%rsp),%rdx
    3a7a:	be 01 00 00 00       	mov    $0x1,%esi
    3a7f:	e8 4c 08 00 00       	call   42d0 <fwp_data>
    3a84:	48 89 c6             	mov    %rax,%rsi
    3a87:	48 2b 35 4a c7 00 00 	sub    0xc74a(%rip),%rsi        # 101d8 <fwp_gc+0x1030>
    3a8e:	48 8b 0d 6b c7 00 00 	mov    0xc76b(%rip),%rcx        # 10200 <fwp_gc+0x1058>
    3a95:	48 c1 e1 10          	shl    $0x10,%rcx
    3a99:	48 39 ce             	cmp    %rcx,%rsi
    3a9c:	73 76                	jae    3b14 <fwp_p_attempt_owned+0x184>
    3a9e:	48 8b 0d 7b c7 00 00 	mov    0xc77b(%rip),%rcx        # 10220 <fwp_gc+0x1078>
    3aa5:	48 89 f2             	mov    %rsi,%rdx
    3aa8:	48 c1 ea 10          	shr    $0x10,%rdx
    3aac:	48 69 d2 28 12 00 00 	imul   $0x1228,%rdx,%rdx
    3ab3:	0f b6 3c 11          	movzbl (%rcx,%rdx,1),%edi
    3ab7:	48 81 e6 ff ff 00 00 	and    $0xffff,%rsi
    3abe:	75 1d                	jne    3add <fwp_p_attempt_owned+0x14d>
    3ac0:	40 80 ff 02          	cmp    $0x2,%dil
    3ac4:	75 17                	jne    3add <fwp_p_attempt_owned+0x14d>
    3ac6:	4c 8d 34 11          	lea    (%rcx,%rdx,1),%r14
    3aca:	49 81 c6 28 02 00 00 	add    $0x228,%r14
    3ad1:	41 80 3e ff          	cmpb   $0xff,(%r14)
    3ad5:	74 2d                	je     3b04 <fwp_p_attempt_owned+0x174>
    3ad7:	41 c6 06 01          	movb   $0x1,(%r14)
    3adb:	eb 37                	jmp    3b14 <fwp_p_attempt_owned+0x184>
    3add:	40 80 ff 01          	cmp    $0x1,%dil
    3ae1:	75 31                	jne    3b14 <fwp_p_attempt_owned+0x184>
    3ae3:	48 8d 3c 11          	lea    (%rcx,%rdx,1),%rdi
    3ae7:	8b 4c 11 20          	mov    0x20(%rcx,%rdx,1),%ecx
    3aeb:	48 0f af f1          	imul   %rcx,%rsi
    3aef:	48 c1 ee 20          	shr    $0x20,%rsi
    3af3:	4c 8d 34 3e          	lea    (%rsi,%rdi,1),%r14
    3af7:	49 81 c6 28 02 00 00 	add    $0x228,%r14
    3afe:	41 80 3e ff          	cmpb   $0xff,(%r14)
    3b02:	75 d3                	jne    3ad7 <fwp_p_attempt_owned+0x147>
    3b04:	4c 89 f7             	mov    %r14,%rdi
    3b07:	49 89 c4             	mov    %rax,%r12
    3b0a:	e8 d1 fd ff ff       	call   38e0 <fwp_rc_forget_slot>
    3b0f:	4c 89 e0             	mov    %r12,%rax
    3b12:	eb c3                	jmp    3ad7 <fwp_p_attempt_owned+0x147>
    3b14:	48 8b 0c 24          	mov    (%rsp),%rcx
    3b18:	48 83 7c 24 10 00    	cmpq   $0x0,0x10(%rsp)
    3b1e:	74 15                	je     3b35 <fwp_p_attempt_owned+0x1a5>
    3b20:	4c 39 3d 51 d1 00 00 	cmp    %r15,0xd151(%rip)        # 10c78 <fwp_cleanups>
    3b27:	75 1b                	jne    3b44 <fwp_p_attempt_owned+0x1b4>
    3b29:	48 8b 4c 24 20       	mov    0x20(%rsp),%rcx
    3b2e:	48 89 0d 43 d1 00 00 	mov    %rcx,0xd143(%rip)        # 10c78 <fwp_cleanups>
    3b35:	48 81 c4 28 01 00 00 	add    $0x128,%rsp
    3b3c:	5b                   	pop    %rbx
    3b3d:	41 5c                	pop    %r12
    3b3f:	41 5e                	pop    %r14
    3b41:	41 5f                	pop    %r15
    3b43:	c3                   	ret
    3b44:	e8 17 e5 ff ff       	call   2060 <abort@plt>
    3b49:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)

0000000000003b50 <fwp_drop2>:
    3b50:	48 89 f8             	mov    %rdi,%rax
    3b53:	48 2b 05 7e c6 00 00 	sub    0xc67e(%rip),%rax        # 101d8 <fwp_gc+0x1030>
    3b5a:	48 8b 0d 9f c6 00 00 	mov    0xc69f(%rip),%rcx        # 10200 <fwp_gc+0x1058>
    3b61:	48 c1 e1 10          	shl    $0x10,%rcx
    3b65:	48 39 c8             	cmp    %rcx,%rax
    3b68:	73 6e                	jae    3bd8 <fwp_drop2+0x88>
    3b6a:	48 8b 0d af c6 00 00 	mov    0xc6af(%rip),%rcx        # 10220 <fwp_gc+0x1078>
    3b71:	48 89 c2             	mov    %rax,%rdx
    3b74:	48 c1 ea 10          	shr    $0x10,%rdx
    3b78:	48 69 d2 28 12 00 00 	imul   $0x1228,%rdx,%rdx
    3b7f:	0f b6 34 11          	movzbl (%rcx,%rdx,1),%esi
    3b83:	48 25 ff ff 00 00    	and    $0xffff,%rax
    3b89:	75 12                	jne    3b9d <fwp_drop2+0x4d>
    3b8b:	40 80 fe 02          	cmp    $0x2,%sil
    3b8f:	75 0c                	jne    3b9d <fwp_drop2+0x4d>
    3b91:	48 8d 04 11          	lea    (%rcx,%rdx,1),%rax
    3b95:	48 05 28 02 00 00    	add    $0x228,%rax
    3b9b:	eb 1f                	jmp    3bbc <fwp_drop2+0x6c>
    3b9d:	40 80 fe 01          	cmp    $0x1,%sil
    3ba1:	75 35                	jne    3bd8 <fwp_drop2+0x88>
    3ba3:	48 8d 34 11          	lea    (%rcx,%rdx,1),%rsi
    3ba7:	8b 4c 11 20          	mov    0x20(%rcx,%rdx,1),%ecx
    3bab:	48 0f af c1          	imul   %rcx,%rax
    3baf:	48 c1 e8 20          	shr    $0x20,%rax
    3bb3:	48 01 f0             	add    %rsi,%rax
    3bb6:	48 05 28 02 00 00    	add    $0x228,%rax
    3bbc:	0f b6 08             	movzbl (%rax),%ecx
    3bbf:	85 c9                	test   %ecx,%ecx
    3bc1:	74 15                	je     3bd8 <fwp_drop2+0x88>
    3bc3:	83 f9 01             	cmp    $0x1,%ecx
    3bc6:	0f 84 44 2a 00 00    	je     6610 <fwp_rc_free_obj>
    3bcc:	81 f9 ff 00 00 00    	cmp    $0xff,%ecx
    3bd2:	74 05                	je     3bd9 <fwp_drop2+0x89>
    3bd4:	fe c9                	dec    %cl
    3bd6:	88 08                	mov    %cl,(%rax)
    3bd8:	c3                   	ret
    3bd9:	48 89 c7             	mov    %rax,%rdi
    3bdc:	e9 1f 28 00 00       	jmp    6400 <fwp_rc_wide_drop>
    3be1:	66 66 66 66 66 66 2e 	data16 data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    3be8:	0f 1f 84 00 00 00 00 
    3bef:	00 

0000000000003bf0 <fwp_drop3>:
    3bf0:	48 8b 15 e1 c5 00 00 	mov    0xc5e1(%rip),%rdx        # 101d8 <fwp_gc+0x1030>
    3bf7:	48 89 f8             	mov    %rdi,%rax
    3bfa:	48 29 d0             	sub    %rdx,%rax
    3bfd:	48 8b 35 fc c5 00 00 	mov    0xc5fc(%rip),%rsi        # 10200 <fwp_gc+0x1058>
    3c04:	48 c1 e6 10          	shl    $0x10,%rsi
    3c08:	48 39 f0             	cmp    %rsi,%rax
    3c0b:	0f 83 b7 00 00 00    	jae    3cc8 <fwp_drop3+0xd8>
    3c11:	48 8b 0d 08 c6 00 00 	mov    0xc608(%rip),%rcx        # 10220 <fwp_gc+0x1078>
    3c18:	49 89 c0             	mov    %rax,%r8
    3c1b:	49 c1 e8 10          	shr    $0x10,%r8
    3c1f:	4d 69 c0 28 12 00 00 	imul   $0x1228,%r8,%r8
    3c26:	46 0f b6 0c 01       	movzbl (%rcx,%r8,1),%r9d
    3c2b:	48 25 ff ff 00 00    	and    $0xffff,%rax
    3c31:	75 12                	jne    3c45 <fwp_drop3+0x55>
    3c33:	41 80 f9 02          	cmp    $0x2,%r9b
    3c37:	75 0c                	jne    3c45 <fwp_drop3+0x55>
    3c39:	4a 8d 04 01          	lea    (%rcx,%r8,1),%rax
    3c3d:	48 05 28 02 00 00    	add    $0x228,%rax
    3c43:	eb 20                	jmp    3c65 <fwp_drop3+0x75>
    3c45:	41 80 f9 01          	cmp    $0x1,%r9b
    3c49:	75 7d                	jne    3cc8 <fwp_drop3+0xd8>
    3c4b:	4e 8d 0c 01          	lea    (%rcx,%r8,1),%r9
    3c4f:	46 8b 44 01 20       	mov    0x20(%rcx,%r8,1),%r8d
    3c54:	49 0f af c0          	imul   %r8,%rax
    3c58:	48 c1 e8 20          	shr    $0x20,%rax
    3c5c:	4c 01 c8             	add    %r9,%rax
    3c5f:	48 05 28 02 00 00    	add    $0x228,%rax
    3c65:	44 0f b6 00          	movzbl (%rax),%r8d
    3c69:	45 85 c0             	test   %r8d,%r8d
    3c6c:	74 5a                	je     3cc8 <fwp_drop3+0xd8>
    3c6e:	41 83 f8 01          	cmp    $0x1,%r8d
    3c72:	75 41                	jne    3cb5 <fwp_drop3+0xc5>
    3c74:	53                   	push   %rbx
    3c75:	48 8b 47 08          	mov    0x8(%rdi),%rax
    3c79:	49 89 c0             	mov    %rax,%r8
    3c7c:	49 29 d0             	sub    %rdx,%r8
    3c7f:	49 39 f0             	cmp    %rsi,%r8
    3c82:	0f 83 8e 00 00 00    	jae    3d16 <fwp_drop3+0x126>
    3c88:	4c 89 c2             	mov    %r8,%rdx
    3c8b:	48 c1 ea 10          	shr    $0x10,%rdx
    3c8f:	48 69 d2 28 12 00 00 	imul   $0x1228,%rdx,%rdx
    3c96:	0f b6 34 11          	movzbl (%rcx,%rdx,1),%esi
    3c9a:	49 81 e0 ff ff 00 00 	and    $0xffff,%r8
    3ca1:	75 26                	jne    3cc9 <fwp_drop3+0xd9>
    3ca3:	40 80 fe 02          	cmp    $0x2,%sil
    3ca7:	75 20                	jne    3cc9 <fwp_drop3+0xd9>
    3ca9:	48 01 d1             	add    %rdx,%rcx
    3cac:	48 81 c1 28 02 00 00 	add    $0x228,%rcx
    3cb3:	eb 35                	jmp    3cea <fwp_drop3+0xfa>
    3cb5:	41 81 f8 ff 00 00 00 	cmp    $0xff,%r8d
    3cbc:	0f 84 fa 00 00 00    	je     3dbc <fwp_drop3+0x1cc>
    3cc2:	41 fe c8             	dec    %r8b
    3cc5:	44 88 00             	mov    %r8b,(%rax)
    3cc8:	c3                   	ret
    3cc9:	40 80 fe 01          	cmp    $0x1,%sil
    3ccd:	75 47                	jne    3d16 <fwp_drop3+0x126>
    3ccf:	48 8d 34 11          	lea    (%rcx,%rdx,1),%rsi
    3cd3:	8b 4c 11 20          	mov    0x20(%rcx,%rdx,1),%ecx
    3cd7:	4c 0f af c1          	imul   %rcx,%r8
    3cdb:	49 c1 e8 20          	shr    $0x20,%r8
    3cdf:	49 8d 0c 30          	lea    (%r8,%rsi,1),%rcx
    3ce3:	48 81 c1 28 02 00 00 	add    $0x228,%rcx
    3cea:	0f b6 11             	movzbl (%rcx),%edx
    3ced:	85 d2                	test   %edx,%edx
    3cef:	74 25                	je     3d16 <fwp_drop3+0x126>
    3cf1:	83 fa 01             	cmp    $0x1,%edx
    3cf4:	75 10                	jne    3d06 <fwp_drop3+0x116>
    3cf6:	48 89 fb             	mov    %rdi,%rbx
    3cf9:	48 89 c7             	mov    %rax,%rdi
    3cfc:	e8 0f 29 00 00       	call   6610 <fwp_rc_free_obj>
    3d01:	48 89 df             	mov    %rbx,%rdi
    3d04:	eb 10                	jmp    3d16 <fwp_drop3+0x126>
    3d06:	81 fa ff 00 00 00    	cmp    $0xff,%edx
    3d0c:	0f 84 b2 00 00 00    	je     3dc4 <fwp_drop3+0x1d4>
    3d12:	fe ca                	dec    %dl
    3d14:	88 11                	mov    %dl,(%rcx)
    3d16:	48 8b 47 10          	mov    0x10(%rdi),%rax
    3d1a:	48 89 c1             	mov    %rax,%rcx
    3d1d:	48 2b 0d b4 c4 00 00 	sub    0xc4b4(%rip),%rcx        # 101d8 <fwp_gc+0x1030>
    3d24:	48 8b 15 d5 c4 00 00 	mov    0xc4d5(%rip),%rdx        # 10200 <fwp_gc+0x1058>
    3d2b:	48 c1 e2 10          	shl    $0x10,%rdx
    3d2f:	48 39 d1             	cmp    %rdx,%rcx
    3d32:	73 70                	jae    3da4 <fwp_drop3+0x1b4>
    3d34:	48 8b 15 e5 c4 00 00 	mov    0xc4e5(%rip),%rdx        # 10220 <fwp_gc+0x1078>
    3d3b:	48 89 ce             	mov    %rcx,%rsi
    3d3e:	48 c1 ee 10          	shr    $0x10,%rsi
    3d42:	48 69 f6 28 12 00 00 	imul   $0x1228,%rsi,%rsi
    3d49:	44 0f b6 04 32       	movzbl (%rdx,%rsi,1),%r8d
    3d4e:	48 81 e1 ff ff 00 00 	and    $0xffff,%rcx
    3d55:	75 13                	jne    3d6a <fwp_drop3+0x17a>
    3d57:	41 80 f8 02          	cmp    $0x2,%r8b
    3d5b:	75 0d                	jne    3d6a <fwp_drop3+0x17a>
    3d5d:	48 8d 0c 32          	lea    (%rdx,%rsi,1),%rcx
    3d61:	48 81 c1 28 02 00 00 	add    $0x228,%rcx
    3d68:	eb 20                	jmp    3d8a <fwp_drop3+0x19a>
    3d6a:	41 80 f8 01          	cmp    $0x1,%r8b
    3d6e:	75 34                	jne    3da4 <fwp_drop3+0x1b4>
    3d70:	4c 8d 04 32          	lea    (%rdx,%rsi,1),%r8
    3d74:	8b 54 32 20          	mov    0x20(%rdx,%rsi,1),%edx
    3d78:	48 0f af ca          	imul   %rdx,%rcx
    3d7c:	48 c1 e9 20          	shr    $0x20,%rcx
    3d80:	4c 01 c1             	add    %r8,%rcx
    3d83:	48 81 c1 28 02 00 00 	add    $0x228,%rcx
    3d8a:	0f b6 11             	movzbl (%rcx),%edx
    3d8d:	85 d2                	test   %edx,%edx
    3d8f:	74 13                	je     3da4 <fwp_drop3+0x1b4>
    3d91:	83 fa 01             	cmp    $0x1,%edx
    3d94:	75 14                	jne    3daa <fwp_drop3+0x1ba>
    3d96:	48 89 fb             	mov    %rdi,%rbx
    3d99:	48 89 c7             	mov    %rax,%rdi
    3d9c:	e8 6f 28 00 00       	call   6610 <fwp_rc_free_obj>
    3da1:	48 89 df             	mov    %rbx,%rdi
    3da4:	5b                   	pop    %rbx
    3da5:	e9 66 28 00 00       	jmp    6610 <fwp_rc_free_obj>
    3daa:	81 fa ff 00 00 00    	cmp    $0xff,%edx
    3db0:	74 22                	je     3dd4 <fwp_drop3+0x1e4>
    3db2:	fe ca                	dec    %dl
    3db4:	88 11                	mov    %dl,(%rcx)
    3db6:	5b                   	pop    %rbx
    3db7:	e9 54 28 00 00       	jmp    6610 <fwp_rc_free_obj>
    3dbc:	48 89 c7             	mov    %rax,%rdi
    3dbf:	e9 3c 26 00 00       	jmp    6400 <fwp_rc_wide_drop>
    3dc4:	48 89 fb             	mov    %rdi,%rbx
    3dc7:	48 89 cf             	mov    %rcx,%rdi
    3dca:	e8 31 26 00 00       	call   6400 <fwp_rc_wide_drop>
    3dcf:	e9 2d ff ff ff       	jmp    3d01 <fwp_drop3+0x111>
    3dd4:	48 89 fb             	mov    %rdi,%rbx
    3dd7:	48 89 cf             	mov    %rcx,%rdi
    3dda:	e8 21 26 00 00       	call   6400 <fwp_rc_wide_drop>
    3ddf:	eb c0                	jmp    3da1 <fwp_drop3+0x1b1>
    3de1:	66 66 66 66 66 66 2e 	data16 data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    3de8:	0f 1f 84 00 00 00 00 
    3def:	00 

0000000000003df0 <fwp_apply_borrowed>:
    3df0:	55                   	push   %rbp
    3df1:	41 57                	push   %r15
    3df3:	41 56                	push   %r14
    3df5:	41 55                	push   %r13
    3df7:	41 54                	push   %r12
    3df9:	53                   	push   %rbx
    3dfa:	48 81 ec 98 00 00 00 	sub    $0x98,%rsp
    3e01:	49 89 f4             	mov    %rsi,%r12
    3e04:	48 89 fb             	mov    %rdi,%rbx
    3e07:	4c 8b 3d 42 ce 00 00 	mov    0xce42(%rip),%r15        # 10c50 <fwp_fns>
    3e0e:	8b 0f                	mov    (%rdi),%ecx
    3e10:	48 c1 e1 05          	shl    $0x5,%rcx
    3e14:	49 8b 44 0f 18       	mov    0x18(%r15,%rcx,1),%rax
    3e19:	48 85 c0             	test   %rax,%rax
    3e1c:	0f 84 29 03 00 00    	je     414b <fwp_apply_borrowed+0x35b>
    3e22:	4d 8d 2c 0f          	lea    (%r15,%rcx,1),%r13
    3e26:	49 83 c5 18          	add    $0x18,%r13
    3e2a:	49 01 cf             	add    %rcx,%r15
    3e2d:	bd 01 00 00 00       	mov    $0x1,%ebp
    3e32:	31 c9                	xor    %ecx,%ecx
    3e34:	66 66 66 2e 0f 1f 84 	data16 data16 cs nopw 0x0(%rax,%rax,1)
    3e3b:	00 00 00 00 00 
    3e40:	f6 c1 01             	test   $0x1,%cl
    3e43:	ba 00 00 00 00       	mov    $0x0,%edx
    3e48:	48 0f 45 d3          	cmovne %rbx,%rdx
    3e4c:	48 89 54 24 70       	mov    %rdx,0x70(%rsp)
    3e51:	4c 89 64 24 78       	mov    %r12,0x78(%rsp)
    3e56:	48 89 84 24 80 00 00 	mov    %rax,0x80(%rsp)
    3e5d:	00 
    3e5e:	c7 84 24 88 00 00 00 	movl   $0x0,0x88(%rsp)
    3e65:	00 00 00 00 
    3e69:	8b 53 04             	mov    0x4(%rbx),%edx
    3e6c:	89 94 24 8c 00 00 00 	mov    %edx,0x8c(%rsp)
    3e73:	48 89 da             	mov    %rbx,%rdx
    3e76:	48 2b 15 5b c3 00 00 	sub    0xc35b(%rip),%rdx        # 101d8 <fwp_gc+0x1030>
    3e7d:	c7 84 24 90 00 00 00 	movl   $0x0,0x90(%rsp)
    3e84:	00 00 00 00 
    3e88:	48 8b 35 71 c3 00 00 	mov    0xc371(%rip),%rsi        # 10200 <fwp_gc+0x1058>
    3e8f:	48 c1 e6 10          	shl    $0x10,%rsi
    3e93:	48 39 f2             	cmp    %rsi,%rdx
    3e96:	0f 83 c4 00 00 00    	jae    3f60 <fwp_apply_borrowed+0x170>
    3e9c:	48 8b 35 7d c3 00 00 	mov    0xc37d(%rip),%rsi        # 10220 <fwp_gc+0x1078>
    3ea3:	48 89 d7             	mov    %rdx,%rdi
    3ea6:	48 c1 ef 10          	shr    $0x10,%rdi
    3eaa:	48 69 ff 28 12 00 00 	imul   $0x1228,%rdi,%rdi
    3eb1:	44 0f b6 04 3e       	movzbl (%rsi,%rdi,1),%r8d
    3eb6:	41 80 f8 02          	cmp    $0x2,%r8b
    3eba:	41 0f 94 c2          	sete   %r10b
    3ebe:	48 81 e2 ff ff 00 00 	and    $0xffff,%rdx
    3ec5:	41 0f 94 c1          	sete   %r9b
    3ec9:	45 20 d1             	and    %r10b,%r9b
    3ecc:	41 80 f9 01          	cmp    $0x1,%r9b
    3ed0:	75 0e                	jne    3ee0 <fwp_apply_borrowed+0xf0>
    3ed2:	4c 8d 14 3e          	lea    (%rsi,%rdi,1),%r10
    3ed6:	49 81 c2 28 02 00 00 	add    $0x228,%r10
    3edd:	eb 22                	jmp    3f01 <fwp_apply_borrowed+0x111>
    3edf:	90                   	nop
    3ee0:	41 80 f8 01          	cmp    $0x1,%r8b
    3ee4:	75 7a                	jne    3f60 <fwp_apply_borrowed+0x170>
    3ee6:	4c 8d 14 3e          	lea    (%rsi,%rdi,1),%r10
    3eea:	44 8b 5c 3e 20       	mov    0x20(%rsi,%rdi,1),%r11d
    3eef:	4c 0f af da          	imul   %rdx,%r11
    3ef3:	49 c1 eb 20          	shr    $0x20,%r11
    3ef7:	4d 01 da             	add    %r11,%r10
    3efa:	49 81 c2 28 02 00 00 	add    $0x228,%r10
    3f01:	41 80 3a 00          	cmpb   $0x0,(%r10)
    3f05:	41 0f 95 c3          	setne  %r11b
    3f09:	74 2e                	je     3f39 <fwp_apply_borrowed+0x149>
    3f0b:	4c 8b 15 66 cd 00 00 	mov    0xcd66(%rip),%r10        # 10c78 <fwp_cleanups>
    3f12:	4c 89 54 24 58       	mov    %r10,0x58(%rsp)
    3f17:	4c 8d 15 32 0b 00 00 	lea    0xb32(%rip),%r10        # 4a50 <fwp_apply_release>
    3f1e:	4c 89 54 24 60       	mov    %r10,0x60(%rsp)
    3f23:	4c 8d 54 24 70       	lea    0x70(%rsp),%r10
    3f28:	4c 89 54 24 68       	mov    %r10,0x68(%rsp)
    3f2d:	4c 8d 54 24 58       	lea    0x58(%rsp),%r10
    3f32:	4c 89 15 3f cd 00 00 	mov    %r10,0xcd3f(%rip)        # 10c78 <fwp_cleanups>
    3f39:	f6 c1 01             	test   $0x1,%cl
    3f3c:	44 89 1c 24          	mov    %r11d,(%rsp)
    3f40:	75 77                	jne    3fb9 <fwp_apply_borrowed+0x1c9>
    3f42:	45 84 c9             	test   %r9b,%r9b
    3f45:	74 27                	je     3f6e <fwp_apply_borrowed+0x17e>
    3f47:	48 01 f7             	add    %rsi,%rdi
    3f4a:	48 81 c7 28 02 00 00 	add    $0x228,%rdi
    3f51:	eb 3c                	jmp    3f8f <fwp_apply_borrowed+0x19f>
    3f53:	66 66 66 66 2e 0f 1f 	data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    3f5a:	84 00 00 00 00 00 
    3f60:	c7 04 24 00 00 00 00 	movl   $0x0,(%rsp)
    3f67:	f6 c1 01             	test   $0x1,%cl
    3f6a:	74 44                	je     3fb0 <fwp_apply_borrowed+0x1c0>
    3f6c:	eb 4b                	jmp    3fb9 <fwp_apply_borrowed+0x1c9>
    3f6e:	41 80 f8 01          	cmp    $0x1,%r8b
    3f72:	75 3c                	jne    3fb0 <fwp_apply_borrowed+0x1c0>
    3f74:	48 8d 04 3e          	lea    (%rsi,%rdi,1),%rax
    3f78:	8b 4c 3e 20          	mov    0x20(%rsi,%rdi,1),%ecx
    3f7c:	48 0f af d1          	imul   %rcx,%rdx
    3f80:	48 c1 ea 20          	shr    $0x20,%rdx
    3f84:	48 8d 3c 02          	lea    (%rdx,%rax,1),%rdi
    3f88:	48 81 c7 28 02 00 00 	add    $0x228,%rdi
    3f8f:	0f b6 07             	movzbl (%rdi),%eax
    3f92:	84 c0                	test   %al,%al
    3f94:	74 1a                	je     3fb0 <fwp_apply_borrowed+0x1c0>
    3f96:	3c fe                	cmp    $0xfe,%al
    3f98:	0f 83 a3 01 00 00    	jae    4141 <fwp_apply_borrowed+0x351>
    3f9e:	fe c0                	inc    %al
    3fa0:	88 07                	mov    %al,(%rdi)
    3fa2:	66 66 66 66 66 2e 0f 	data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    3fa9:	1f 84 00 00 00 00 00 
    3fb0:	48 89 5c 24 70       	mov    %rbx,0x70(%rsp)
    3fb5:	49 8b 45 00          	mov    0x0(%r13),%rax
    3fb9:	45 8b 3f             	mov    (%r15),%r15d
    3fbc:	44 2b 7b 04          	sub    0x4(%rbx),%r15d
    3fc0:	44 39 fd             	cmp    %r15d,%ebp
    3fc3:	44 89 7c 24 0c       	mov    %r15d,0xc(%rsp)
    3fc8:	44 0f 42 fd          	cmovb  %ebp,%r15d
    3fcc:	48 c7 44 24 30 00 00 	movq   $0x0,0x30(%rsp)
    3fd3:	00 00 
    3fd5:	4c 89 64 24 38       	mov    %r12,0x38(%rsp)
    3fda:	48 89 44 24 40       	mov    %rax,0x40(%rsp)
    3fdf:	c7 44 24 48 00 00 00 	movl   $0x0,0x48(%rsp)
    3fe6:	00 
    3fe7:	8b 4b 04             	mov    0x4(%rbx),%ecx
    3fea:	89 4c 24 4c          	mov    %ecx,0x4c(%rsp)
    3fee:	c7 44 24 50 00 00 00 	movl   $0x0,0x50(%rsp)
    3ff5:	00 
    3ff6:	45 89 fe             	mov    %r15d,%r14d
    3ff9:	45 85 ff             	test   %r15d,%r15d
    3ffc:	0f 84 8e 00 00 00    	je     4090 <fwp_apply_borrowed+0x2a0>
    4002:	89 6c 24 08          	mov    %ebp,0x8(%rsp)
    4006:	48 83 78 18 00       	cmpq   $0x0,0x18(%rax)
    400b:	0f 95 c0             	setne  %al
    400e:	89 44 24 04          	mov    %eax,0x4(%rsp)
    4012:	74 2e                	je     4042 <fwp_apply_borrowed+0x252>
    4014:	48 8b 05 5d cc 00 00 	mov    0xcc5d(%rip),%rax        # 10c78 <fwp_cleanups>
    401b:	48 89 44 24 18       	mov    %rax,0x18(%rsp)
    4020:	48 8d 05 29 0a 00 00 	lea    0xa29(%rip),%rax        # 4a50 <fwp_apply_release>
    4027:	48 89 44 24 20       	mov    %rax,0x20(%rsp)
    402c:	48 8d 44 24 30       	lea    0x30(%rsp),%rax
    4031:	48 89 44 24 28       	mov    %rax,0x28(%rsp)
    4036:	48 8d 44 24 18       	lea    0x18(%rsp),%rax
    403b:	48 89 05 36 cc 00 00 	mov    %rax,0xcc36(%rip)        # 10c78 <fwp_cleanups>
    4042:	4c 89 64 24 10       	mov    %r12,0x10(%rsp)
    4047:	31 ed                	xor    %ebp,%ebp
    4049:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)
    4050:	49 8b 45 00          	mov    0x0(%r13),%rax
    4054:	8b 73 04             	mov    0x4(%rbx),%esi
    4057:	01 ee                	add    %ebp,%esi
    4059:	4c 89 e7             	mov    %r12,%rdi
    405c:	ba 01 00 00 00       	mov    $0x1,%edx
    4061:	ff 50 10             	call   *0x10(%rax)
    4064:	8b 44 24 50          	mov    0x50(%rsp),%eax
    4068:	ff c0                	inc    %eax
    406a:	89 44 24 50          	mov    %eax,0x50(%rsp)
    406e:	48 ff c5             	inc    %rbp
    4071:	49 83 c4 08          	add    $0x8,%r12
    4075:	49 39 ee             	cmp    %rbp,%r14
    4078:	75 d6                	jne    4050 <fwp_apply_borrowed+0x260>
    407a:	4c 8b 64 24 10       	mov    0x10(%rsp),%r12
    407f:	8b 6c 24 08          	mov    0x8(%rsp),%ebp
    4083:	44 8b 6c 24 04       	mov    0x4(%rsp),%r13d
    4088:	eb 0b                	jmp    4095 <fwp_apply_borrowed+0x2a5>
    408a:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)
    4090:	45 31 ed             	xor    %r13d,%r13d
    4093:	31 c0                	xor    %eax,%eax
    4095:	89 44 24 48          	mov    %eax,0x48(%rsp)
    4099:	48 c7 44 24 70 00 00 	movq   $0x0,0x70(%rsp)
    40a0:	00 00 
    40a2:	c7 84 24 88 00 00 00 	movl   $0x0,0x88(%rsp)
    40a9:	00 00 00 00 
    40ad:	48 89 df             	mov    %rbx,%rdi
    40b0:	44 89 fe             	mov    %r15d,%esi
    40b3:	4c 89 e2             	mov    %r12,%rdx
    40b6:	e8 05 0a 00 00       	call   4ac0 <fwp_apply_owned>
    40bb:	48 89 c3             	mov    %rax,%rbx
    40be:	45 84 ed             	test   %r13b,%r13b
    40c1:	74 1e                	je     40e1 <fwp_apply_borrowed+0x2f1>
    40c3:	48 8d 44 24 18       	lea    0x18(%rsp),%rax
    40c8:	48 39 05 a9 cb 00 00 	cmp    %rax,0xcba9(%rip)        # 10c78 <fwp_cleanups>
    40cf:	0f 85 c8 01 00 00    	jne    429d <fwp_apply_borrowed+0x4ad>
    40d5:	48 8b 44 24 18       	mov    0x18(%rsp),%rax
    40da:	48 89 05 97 cb 00 00 	mov    %rax,0xcb97(%rip)        # 10c78 <fwp_cleanups>
    40e1:	80 3c 24 00          	cmpb   $0x0,(%rsp)
    40e5:	74 1e                	je     4105 <fwp_apply_borrowed+0x315>
    40e7:	48 8d 44 24 58       	lea    0x58(%rsp),%rax
    40ec:	48 39 05 85 cb 00 00 	cmp    %rax,0xcb85(%rip)        # 10c78 <fwp_cleanups>
    40f3:	0f 85 a4 01 00 00    	jne    429d <fwp_apply_borrowed+0x4ad>
    40f9:	48 8b 44 24 58       	mov    0x58(%rsp),%rax
    40fe:	48 89 05 73 cb 00 00 	mov    %rax,0xcb73(%rip)        # 10c78 <fwp_cleanups>
    4105:	3b 6c 24 0c          	cmp    0xc(%rsp),%ebp
    4109:	0f 86 79 01 00 00    	jbe    4288 <fwp_apply_borrowed+0x498>
    410f:	4f 8d 24 f4          	lea    (%r12,%r14,8),%r12
    4113:	44 29 fd             	sub    %r15d,%ebp
    4116:	48 8b 05 33 cb 00 00 	mov    0xcb33(%rip),%rax        # 10c50 <fwp_fns>
    411d:	8b 0b                	mov    (%rbx),%ecx
    411f:	48 c1 e1 05          	shl    $0x5,%rcx
    4123:	4c 8d 3c 08          	lea    (%rax,%rcx,1),%r15
    4127:	4c 8d 2c 08          	lea    (%rax,%rcx,1),%r13
    412b:	49 83 c5 18          	add    $0x18,%r13
    412f:	48 8b 44 08 18       	mov    0x18(%rax,%rcx,1),%rax
    4134:	b1 01                	mov    $0x1,%cl
    4136:	48 85 c0             	test   %rax,%rax
    4139:	0f 85 01 fd ff ff    	jne    3e40 <fwp_apply_borrowed+0x50>
    413f:	eb 0f                	jmp    4150 <fwp_apply_borrowed+0x360>
    4141:	e8 4a 23 00 00       	call   6490 <fwp_rc_wide_dup>
    4146:	e9 65 fe ff ff       	jmp    3fb0 <fwp_apply_borrowed+0x1c0>
    414b:	bd 01 00 00 00       	mov    $0x1,%ebp
    4150:	48 8b 05 81 c0 00 00 	mov    0xc081(%rip),%rax        # 101d8 <fwp_gc+0x1030>
    4157:	48 89 da             	mov    %rbx,%rdx
    415a:	48 29 c2             	sub    %rax,%rdx
    415d:	48 8b 0d 9c c0 00 00 	mov    0xc09c(%rip),%rcx        # 10200 <fwp_gc+0x1058>
    4164:	48 c1 e1 10          	shl    $0x10,%rcx
    4168:	48 39 ca             	cmp    %rcx,%rdx
    416b:	73 67                	jae    41d4 <fwp_apply_borrowed+0x3e4>
    416d:	48 8b 35 ac c0 00 00 	mov    0xc0ac(%rip),%rsi        # 10220 <fwp_gc+0x1078>
    4174:	48 89 d7             	mov    %rdx,%rdi
    4177:	48 c1 ef 10          	shr    $0x10,%rdi
    417b:	48 69 ff 28 12 00 00 	imul   $0x1228,%rdi,%rdi
    4182:	44 0f b6 04 3e       	movzbl (%rsi,%rdi,1),%r8d
    4187:	48 81 e2 ff ff 00 00 	and    $0xffff,%rdx
    418e:	75 1b                	jne    41ab <fwp_apply_borrowed+0x3bb>
    4190:	41 80 f8 02          	cmp    $0x2,%r8b
    4194:	75 15                	jne    41ab <fwp_apply_borrowed+0x3bb>
    4196:	48 8d 14 3e          	lea    (%rsi,%rdi,1),%rdx
    419a:	48 81 c2 28 02 00 00 	add    $0x228,%rdx
    41a1:	80 3a 00             	cmpb   $0x0,(%rdx)
    41a4:	74 2e                	je     41d4 <fwp_apply_borrowed+0x3e4>
    41a6:	e9 f7 00 00 00       	jmp    42a2 <fwp_apply_borrowed+0x4b2>
    41ab:	41 80 f8 01          	cmp    $0x1,%r8b
    41af:	75 23                	jne    41d4 <fwp_apply_borrowed+0x3e4>
    41b1:	4c 8d 04 3e          	lea    (%rsi,%rdi,1),%r8
    41b5:	8b 74 3e 20          	mov    0x20(%rsi,%rdi,1),%esi
    41b9:	48 0f af d6          	imul   %rsi,%rdx
    41bd:	48 c1 ea 20          	shr    $0x20,%rdx
    41c1:	4c 01 c2             	add    %r8,%rdx
    41c4:	48 81 c2 28 02 00 00 	add    $0x228,%rdx
    41cb:	80 3a 00             	cmpb   $0x0,(%rdx)
    41ce:	0f 85 ce 00 00 00    	jne    42a2 <fwp_apply_borrowed+0x4b2>
    41d4:	85 ed                	test   %ebp,%ebp
    41d6:	0f 84 9c 00 00 00    	je     4278 <fwp_apply_borrowed+0x488>
    41dc:	48 8b 15 3d c0 00 00 	mov    0xc03d(%rip),%rdx        # 10220 <fwp_gc+0x1078>
    41e3:	89 ee                	mov    %ebp,%esi
    41e5:	31 ff                	xor    %edi,%edi
    41e7:	eb 27                	jmp    4210 <fwp_apply_borrowed+0x420>
    41e9:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)
    41f0:	4e 8d 04 0a          	lea    (%rdx,%r9,1),%r8
    41f4:	49 81 c0 28 02 00 00 	add    $0x228,%r8
    41fb:	41 80 38 00          	cmpb   $0x0,(%r8)
    41ff:	74 6f                	je     4270 <fwp_apply_borrowed+0x480>
    4201:	e9 9c 00 00 00       	jmp    42a2 <fwp_apply_borrowed+0x4b2>
    4206:	66 2e 0f 1f 84 00 00 	cs nopw 0x0(%rax,%rax,1)
    420d:	00 00 00 
    4210:	4d 8b 04 fc          	mov    (%r12,%rdi,8),%r8
    4214:	49 29 c0             	sub    %rax,%r8
    4217:	49 39 c8             	cmp    %rcx,%r8
    421a:	73 54                	jae    4270 <fwp_apply_borrowed+0x480>
    421c:	4d 89 c1             	mov    %r8,%r9
    421f:	49 c1 e9 10          	shr    $0x10,%r9
    4223:	4d 69 c9 28 12 00 00 	imul   $0x1228,%r9,%r9
    422a:	46 0f b6 14 0a       	movzbl (%rdx,%r9,1),%r10d
    422f:	49 81 e0 ff ff 00 00 	and    $0xffff,%r8
    4236:	75 06                	jne    423e <fwp_apply_borrowed+0x44e>
    4238:	41 80 fa 02          	cmp    $0x2,%r10b
    423c:	74 b2                	je     41f0 <fwp_apply_borrowed+0x400>
    423e:	41 80 fa 01          	cmp    $0x1,%r10b
    4242:	75 2c                	jne    4270 <fwp_apply_borrowed+0x480>
    4244:	4e 8d 14 0a          	lea    (%rdx,%r9,1),%r10
    4248:	46 8b 4c 0a 20       	mov    0x20(%rdx,%r9,1),%r9d
    424d:	4d 0f af c1          	imul   %r9,%r8
    4251:	49 c1 e8 20          	shr    $0x20,%r8
    4255:	4d 01 d0             	add    %r10,%r8
    4258:	49 81 c0 28 02 00 00 	add    $0x228,%r8
    425f:	41 80 38 00          	cmpb   $0x0,(%r8)
    4263:	75 3d                	jne    42a2 <fwp_apply_borrowed+0x4b2>
    4265:	66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
    426c:	00 00 00 00 
    4270:	48 ff c7             	inc    %rdi
    4273:	48 39 fe             	cmp    %rdi,%rsi
    4276:	75 98                	jne    4210 <fwp_apply_borrowed+0x420>
    4278:	48 89 df             	mov    %rbx,%rdi
    427b:	89 ee                	mov    %ebp,%esi
    427d:	4c 89 e2             	mov    %r12,%rdx
    4280:	e8 6b 02 00 00       	call   44f0 <fwp_apply>
    4285:	48 89 c3             	mov    %rax,%rbx
    4288:	48 89 d8             	mov    %rbx,%rax
    428b:	48 81 c4 98 00 00 00 	add    $0x98,%rsp
    4292:	5b                   	pop    %rbx
    4293:	41 5c                	pop    %r12
    4295:	41 5d                	pop    %r13
    4297:	41 5e                	pop    %r14
    4299:	41 5f                	pop    %r15
    429b:	5d                   	pop    %rbp
    429c:	c3                   	ret
    429d:	e8 be dd ff ff       	call   2060 <abort@plt>
    42a2:	e8 09 f6 ff ff       	call   38b0 <fwp_flush>
    42a7:	48 8b 05 32 ad 00 00 	mov    0xad32(%rip),%rax        # efe0 <stderr@GLIBC_2.2.5>
    42ae:	48 8b 38             	mov    (%rax),%rdi
    42b1:	48 8d 35 7c 80 00 00 	lea    0x807c(%rip),%rsi        # c334 <fwp_segv.msg+0xf4>
    42b8:	48 8d 15 48 80 00 00 	lea    0x8048(%rip),%rdx        # c307 <fwp_segv.msg+0xc7>
    42bf:	31 c0                	xor    %eax,%eax
    42c1:	e8 1a df ff ff       	call   21e0 <fprintf@plt>
    42c6:	bf 65 00 00 00       	mov    $0x65,%edi
    42cb:	e8 00 e0 ff ff       	call   22d0 <exit@plt>

00000000000042d0 <fwp_data>:
    42d0:	55                   	push   %rbp
    42d1:	41 57                	push   %r15
    42d3:	41 56                	push   %r14
    42d5:	41 55                	push   %r13
    42d7:	41 54                	push   %r12
    42d9:	53                   	push   %rbx
    42da:	50                   	push   %rax
    42db:	48 89 d3             	mov    %rdx,%rbx
    42de:	89 f5                	mov    %esi,%ebp
    42e0:	41 89 ff             	mov    %edi,%r15d
    42e3:	41 89 f4             	mov    %esi,%r12d
    42e6:	4e 8d 2c e5 00 00 00 	lea    0x0(,%r12,8),%r13
    42ed:	00 
    42ee:	4a 8d 3c e5 08 00 00 	lea    0x8(,%r12,8),%rdi
    42f5:	00 
    42f6:	81 fe ff 07 00 00    	cmp    $0x7ff,%esi
    42fc:	0f 87 e6 00 00 00    	ja     43e8 <fwp_data+0x118>
    4302:	49 8d 75 17          	lea    0x17(%r13),%rsi
    4306:	48 c1 ee 04          	shr    $0x4,%rsi
    430a:	48 8d 05 97 ae 00 00 	lea    0xae97(%rip),%rax        # f1a8 <fwp_gc>
    4311:	0f b6 8c 06 e8 0b 00 	movzbl 0xbe8(%rsi,%rax,1),%ecx
    4318:	00 
    4319:	8b 94 88 48 0b 00 00 	mov    0xb48(%rax,%rcx,4),%edx
    4320:	4c 8b 05 81 ae 00 00 	mov    0xae81(%rip),%r8        # f1a8 <fwp_gc>
    4327:	4d 89 c1             	mov    %r8,%r9
    432a:	49 29 d1             	sub    %rdx,%r9
    432d:	4c 89 0d 74 ae 00 00 	mov    %r9,0xae74(%rip)        # f1a8 <fwp_gc>
    4334:	0f 88 ae 00 00 00    	js     43e8 <fwp_data+0x118>
    433a:	4c 8d 0c 49          	lea    (%rcx,%rcx,2),%r9
    433e:	4e 8d 14 c8          	lea    (%rax,%r9,8),%r10
    4342:	49 83 c2 08          	add    $0x8,%r10
    4346:	4d 8b 32             	mov    (%r10),%r14
    4349:	4d 85 f6             	test   %r14,%r14
    434c:	74 29                	je     4377 <fwp_data+0xa7>
    434e:	49 8b 06             	mov    (%r14),%rax
    4351:	48 f7 d0             	not    %rax
    4354:	49 89 02             	mov    %rax,(%r10)
    4357:	48 39 d7             	cmp    %rdx,%rdi
    435a:	0f 83 ad 00 00 00    	jae    440d <fwp_data+0x13d>
    4360:	4c 01 f7             	add    %r14,%rdi
    4363:	4c 29 ea             	sub    %r13,%rdx
    4366:	48 83 c2 f7          	add    $0xfffffffffffffff7,%rdx
    436a:	48 83 e2 f8          	and    $0xfffffffffffffff8,%rdx
    436e:	48 83 c2 08          	add    $0x8,%rdx
    4372:	e9 8f 00 00 00       	jmp    4406 <fwp_data+0x136>
    4377:	4e 8b 74 c8 10       	mov    0x10(%rax,%r9,8),%r14
    437c:	4e 8b 54 c8 18       	mov    0x18(%rax,%r9,8),%r10
    4381:	4d 29 f2             	sub    %r14,%r10
    4384:	49 39 d2             	cmp    %rdx,%r10
    4387:	72 2f                	jb     43b8 <fwp_data+0xe8>
    4389:	4a 8d 0c c8          	lea    (%rax,%r9,8),%rcx
    438d:	48 83 c1 10          	add    $0x10,%rcx
    4391:	4d 8d 0c 16          	lea    (%r14,%rdx,1),%r9
    4395:	4c 89 09             	mov    %r9,(%rcx)
    4398:	4d 85 f6             	test   %r14,%r14
    439b:	75 ba                	jne    4357 <fwp_data+0x87>
    439d:	0f b6 8c 06 e8 0b 00 	movzbl 0xbe8(%rsi,%rax,1),%ecx
    43a4:	00 
    43a5:	8b 94 88 48 0b 00 00 	mov    0xb48(%rax,%rcx,4),%edx
    43ac:	49 29 d0             	sub    %rdx,%r8
    43af:	4c 89 05 f2 ad 00 00 	mov    %r8,0xadf2(%rip)        # f1a8 <fwp_gc>
    43b6:	78 30                	js     43e8 <fwp_data+0x118>
    43b8:	48 8d 0c 49          	lea    (%rcx,%rcx,2),%rcx
    43bc:	4c 8b 74 c8 08       	mov    0x8(%rax,%rcx,8),%r14
    43c1:	4d 85 f6             	test   %r14,%r14
    43c4:	74 10                	je     43d6 <fwp_data+0x106>
    43c6:	48 8d 04 c8          	lea    (%rax,%rcx,8),%rax
    43ca:	48 83 c0 08          	add    $0x8,%rax
    43ce:	49 8b 0e             	mov    (%r14),%rcx
    43d1:	48 f7 d1             	not    %rcx
    43d4:	eb 2a                	jmp    4400 <fwp_data+0x130>
    43d6:	4c 8b 74 c8 10       	mov    0x10(%rax,%rcx,8),%r14
    43db:	48 8b 74 c8 18       	mov    0x18(%rax,%rcx,8),%rsi
    43e0:	4c 29 f6             	sub    %r14,%rsi
    43e3:	48 39 d6             	cmp    %rdx,%rsi
    43e6:	73 0c                	jae    43f4 <fwp_data+0x124>
    43e8:	31 f6                	xor    %esi,%esi
    43ea:	e8 81 11 00 00       	call   5570 <fwp_gc_alloc_slow>
    43ef:	49 89 c6             	mov    %rax,%r14
    43f2:	eb 19                	jmp    440d <fwp_data+0x13d>
    43f4:	48 8d 04 c8          	lea    (%rax,%rcx,8),%rax
    43f8:	48 83 c0 10          	add    $0x10,%rax
    43fc:	49 8d 0c 16          	lea    (%r14,%rdx,1),%rcx
    4400:	48 89 08             	mov    %rcx,(%rax)
    4403:	4c 89 f7             	mov    %r14,%rdi
    4406:	31 f6                	xor    %esi,%esi
    4408:	e8 53 dd ff ff       	call   2160 <memset@plt>
    440d:	45 89 3e             	mov    %r15d,(%r14)
    4410:	41 89 6e 04          	mov    %ebp,0x4(%r14)
    4414:	85 ed                	test   %ebp,%ebp
    4416:	0f 84 bb 00 00 00    	je     44d7 <fwp_data+0x207>
    441c:	83 fd 08             	cmp    $0x8,%ebp
    441f:	72 10                	jb     4431 <fwp_data+0x161>
    4421:	4c 89 f0             	mov    %r14,%rax
    4424:	48 29 d8             	sub    %rbx,%rax
    4427:	48 83 c0 08          	add    $0x8,%rax
    442b:	48 83 f8 20          	cmp    $0x20,%rax
    442f:	73 71                	jae    44a2 <fwp_data+0x1d2>
    4431:	31 c0                	xor    %eax,%eax
    4433:	4c 89 e2             	mov    %r12,%rdx
    4436:	48 89 c1             	mov    %rax,%rcx
    4439:	48 83 e2 03          	and    $0x3,%rdx
    443d:	74 22                	je     4461 <fwp_data+0x191>
    443f:	48 89 c1             	mov    %rax,%rcx
    4442:	66 66 66 66 66 2e 0f 	data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    4449:	1f 84 00 00 00 00 00 
    4450:	48 8b 34 cb          	mov    (%rbx,%rcx,8),%rsi
    4454:	49 89 74 ce 08       	mov    %rsi,0x8(%r14,%rcx,8)
    4459:	48 ff c1             	inc    %rcx
    445c:	48 ff ca             	dec    %rdx
    445f:	75 ef                	jne    4450 <fwp_data+0x180>
    4461:	4c 29 e0             	sub    %r12,%rax
    4464:	48 83 f8 fc          	cmp    $0xfffffffffffffffc,%rax
    4468:	77 6d                	ja     44d7 <fwp_data+0x207>
    446a:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)
    4470:	48 8b 04 cb          	mov    (%rbx,%rcx,8),%rax
    4474:	49 89 44 ce 08       	mov    %rax,0x8(%r14,%rcx,8)
    4479:	48 8b 44 cb 08       	mov    0x8(%rbx,%rcx,8),%rax
    447e:	49 89 44 ce 10       	mov    %rax,0x10(%r14,%rcx,8)
    4483:	48 8b 44 cb 10       	mov    0x10(%rbx,%rcx,8),%rax
    4488:	49 89 44 ce 18       	mov    %rax,0x18(%r14,%rcx,8)
    448d:	48 8b 44 cb 18       	mov    0x18(%rbx,%rcx,8),%rax
    4492:	49 89 44 ce 20       	mov    %rax,0x20(%r14,%rcx,8)
    4497:	48 83 c1 04          	add    $0x4,%rcx
    449b:	49 39 cc             	cmp    %rcx,%r12
    449e:	75 d0                	jne    4470 <fwp_data+0x1a0>
    44a0:	eb 35                	jmp    44d7 <fwp_data+0x207>
    44a2:	44 89 e0             	mov    %r12d,%eax
    44a5:	83 e0 fc             	and    $0xfffffffc,%eax
    44a8:	49 83 e5 e0          	and    $0xffffffffffffffe0,%r13
    44ac:	31 c9                	xor    %ecx,%ecx
    44ae:	66 90                	xchg   %ax,%ax
    44b0:	0f 10 04 0b          	movups (%rbx,%rcx,1),%xmm0
    44b4:	0f 10 4c 0b 10       	movups 0x10(%rbx,%rcx,1),%xmm1
    44b9:	41 0f 11 44 0e 08    	movups %xmm0,0x8(%r14,%rcx,1)
    44bf:	41 0f 11 4c 0e 18    	movups %xmm1,0x18(%r14,%rcx,1)
    44c5:	48 83 c1 20          	add    $0x20,%rcx
    44c9:	49 39 cd             	cmp    %rcx,%r13
    44cc:	75 e2                	jne    44b0 <fwp_data+0x1e0>
    44ce:	4c 39 e0             	cmp    %r12,%rax
    44d1:	0f 85 5c ff ff ff    	jne    4433 <fwp_data+0x163>
    44d7:	4c 89 f0             	mov    %r14,%rax
    44da:	48 83 c4 08          	add    $0x8,%rsp
    44de:	5b                   	pop    %rbx
    44df:	41 5c                	pop    %r12
    44e1:	41 5d                	pop    %r13
    44e3:	41 5e                	pop    %r14
    44e5:	41 5f                	pop    %r15
    44e7:	5d                   	pop    %rbp
    44e8:	c3                   	ret
    44e9:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)

00000000000044f0 <fwp_apply>:
    44f0:	55                   	push   %rbp
    44f1:	48 89 e5             	mov    %rsp,%rbp
    44f4:	41 57                	push   %r15
    44f6:	41 56                	push   %r14
    44f8:	41 55                	push   %r13
    44fa:	41 54                	push   %r12
    44fc:	53                   	push   %rbx
    44fd:	48 83 ec 18          	sub    $0x18,%rsp
    4501:	48 89 d3             	mov    %rdx,%rbx
    4504:	49 89 ff             	mov    %rdi,%r15
    4507:	eb 23                	jmp    452c <fwp_apply+0x3c>
    4509:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)
    4510:	4a 8d 1c f3          	lea    (%rbx,%r14,8),%rbx
    4514:	31 c9                	xor    %ecx,%ecx
    4516:	49 89 c7             	mov    %rax,%r15
    4519:	4c 8b 75 c8          	mov    -0x38(%rbp),%r14
    451d:	48 8b 65 c0          	mov    -0x40(%rbp),%rsp
    4521:	89 d6                	mov    %edx,%esi
    4523:	83 f9 01             	cmp    $0x1,%ecx
    4526:	0f 84 aa 04 00 00    	je     49d6 <fwp_apply+0x4e6>
    452c:	48 8b 05 1d c7 00 00 	mov    0xc71d(%rip),%rax        # 10c50 <fwp_fns>
    4533:	41 8b 0f             	mov    (%r15),%ecx
    4536:	45 8b 6f 04          	mov    0x4(%r15),%r13d
    453a:	48 c1 e1 05          	shl    $0x5,%rcx
    453e:	44 8b 24 08          	mov    (%rax,%rcx,1),%r12d
    4542:	4d 85 ed             	test   %r13,%r13
    4545:	75 39                	jne    4580 <fwp_apply+0x90>
    4547:	41 8d 54 24 ff       	lea    -0x1(%r12),%edx
    454c:	39 f2                	cmp    %esi,%edx
    454e:	73 30                	jae    4580 <fwp_apply+0x90>
    4550:	48 89 df             	mov    %rbx,%rdi
    4553:	49 89 f7             	mov    %rsi,%r15
    4556:	ff 54 08 08          	call   *0x8(%rax,%rcx,1)
    455a:	4c 89 fe             	mov    %r15,%rsi
    455d:	49 89 c7             	mov    %rax,%r15
    4560:	44 39 e6             	cmp    %r12d,%esi
    4563:	0f 84 a4 02 00 00    	je     480d <fwp_apply+0x31d>
    4569:	4a 8d 1c e3          	lea    (%rbx,%r12,8),%rbx
    456d:	44 29 e6             	sub    %r12d,%esi
    4570:	b9 03 00 00 00       	mov    $0x3,%ecx
    4575:	83 f9 01             	cmp    $0x1,%ecx
    4578:	75 b2                	jne    452c <fwp_apply+0x3c>
    457a:	e9 57 04 00 00       	jmp    49d6 <fwp_apply+0x4e6>
    457f:	90                   	nop
    4580:	4c 89 75 c8          	mov    %r14,-0x38(%rbp)
    4584:	46 8d 34 2e          	lea    (%rsi,%r13,1),%r14d
    4588:	45 39 e6             	cmp    %r12d,%r14d
    458b:	48 89 75 d0          	mov    %rsi,-0x30(%rbp)
    458f:	0f 82 1a 02 00 00    	jb     47af <fwp_apply+0x2bf>
    4595:	48 89 65 c0          	mov    %rsp,-0x40(%rbp)
    4599:	45 89 e3             	mov    %r12d,%r11d
    459c:	41 83 fc 02          	cmp    $0x2,%r12d
    45a0:	ba 01 00 00 00       	mov    $0x1,%edx
    45a5:	41 0f 43 d4          	cmovae %r12d,%edx
    45a9:	48 8d 14 d5 0f 00 00 	lea    0xf(,%rdx,8),%rdx
    45b0:	00 
    45b1:	48 83 e2 f0          	and    $0xfffffffffffffff0,%rdx
    45b5:	48 89 e7             	mov    %rsp,%rdi
    45b8:	48 29 d7             	sub    %rdx,%rdi
    45bb:	48 89 fc             	mov    %rdi,%rsp
    45be:	4d 85 ed             	test   %r13,%r13
    45c1:	0f 84 c9 00 00 00    	je     4690 <fwp_apply+0x1a0>
    45c7:	41 83 fd 04          	cmp    $0x4,%r13d
    45cb:	72 10                	jb     45dd <fwp_apply+0xed>
    45cd:	48 89 fa             	mov    %rdi,%rdx
    45d0:	4c 29 fa             	sub    %r15,%rdx
    45d3:	48 83 c2 f8          	add    $0xfffffffffffffff8,%rdx
    45d7:	48 83 fa 20          	cmp    $0x20,%rdx
    45db:	73 65                	jae    4642 <fwp_apply+0x152>
    45dd:	31 d2                	xor    %edx,%edx
    45df:	4d 89 e8             	mov    %r13,%r8
    45e2:	49 89 d2             	mov    %rdx,%r10
    45e5:	49 83 e0 03          	and    $0x3,%r8
    45e9:	74 16                	je     4601 <fwp_apply+0x111>
    45eb:	49 89 d2             	mov    %rdx,%r10
    45ee:	66 90                	xchg   %ax,%ax
    45f0:	4f 8b 4c d7 08       	mov    0x8(%r15,%r10,8),%r9
    45f5:	4e 89 0c d7          	mov    %r9,(%rdi,%r10,8)
    45f9:	49 ff c2             	inc    %r10
    45fc:	49 ff c8             	dec    %r8
    45ff:	75 ef                	jne    45f0 <fwp_apply+0x100>
    4601:	4c 29 ea             	sub    %r13,%rdx
    4604:	48 83 fa fc          	cmp    $0xfffffffffffffffc,%rdx
    4608:	0f 87 82 00 00 00    	ja     4690 <fwp_apply+0x1a0>
    460e:	66 90                	xchg   %ax,%ax
    4610:	4b 8b 54 d7 08       	mov    0x8(%r15,%r10,8),%rdx
    4615:	4a 89 14 d7          	mov    %rdx,(%rdi,%r10,8)
    4619:	4b 8b 54 d7 10       	mov    0x10(%r15,%r10,8),%rdx
    461e:	4a 89 54 d7 08       	mov    %rdx,0x8(%rdi,%r10,8)
    4623:	4b 8b 54 d7 18       	mov    0x18(%r15,%r10,8),%rdx
    4628:	4a 89 54 d7 10       	mov    %rdx,0x10(%rdi,%r10,8)
    462d:	4b 8b 54 d7 20       	mov    0x20(%r15,%r10,8),%rdx
    4632:	4a 89 54 d7 18       	mov    %rdx,0x18(%rdi,%r10,8)
    4637:	49 83 c2 04          	add    $0x4,%r10
    463b:	4d 39 d5             	cmp    %r10,%r13
    463e:	75 d0                	jne    4610 <fwp_apply+0x120>
    4640:	eb 4e                	jmp    4690 <fwp_apply+0x1a0>
    4642:	44 89 ea             	mov    %r13d,%edx
    4645:	83 e2 fc             	and    $0xfffffffc,%edx
    4648:	4e 8d 0c ed 00 00 00 	lea    0x0(,%r13,8),%r9
    464f:	00 
    4650:	49 83 e1 e0          	and    $0xffffffffffffffe0,%r9
    4654:	45 31 c0             	xor    %r8d,%r8d
    4657:	66 0f 1f 84 00 00 00 	nopw   0x0(%rax,%rax,1)
    465e:	00 00 
    4660:	43 0f 10 44 07 08    	movups 0x8(%r15,%r8,1),%xmm0
    4666:	43 0f 10 4c 07 18    	movups 0x18(%r15,%r8,1),%xmm1
    466c:	42 0f 29 04 07       	movaps %xmm0,(%rdi,%r8,1)
    4671:	42 0f 29 4c 07 10    	movaps %xmm1,0x10(%rdi,%r8,1)
    4677:	49 83 c0 20          	add    $0x20,%r8
    467b:	4d 39 c1             	cmp    %r8,%r9
    467e:	75 e0                	jne    4660 <fwp_apply+0x170>
    4680:	4c 39 ea             	cmp    %r13,%rdx
    4683:	0f 85 56 ff ff ff    	jne    45df <fwp_apply+0xef>
    4689:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)
    4690:	45 29 eb             	sub    %r13d,%r11d
    4693:	45 89 de             	mov    %r11d,%r14d
    4696:	45 39 ec             	cmp    %r13d,%r12d
    4699:	0f 84 85 00 00 00    	je     4724 <fwp_apply+0x234>
    469f:	41 83 fb 0e          	cmp    $0xe,%r11d
    46a3:	0f 83 a0 00 00 00    	jae    4749 <fwp_apply+0x259>
    46a9:	31 d2                	xor    %edx,%edx
    46ab:	4d 89 f0             	mov    %r14,%r8
    46ae:	48 89 d6             	mov    %rdx,%rsi
    46b1:	49 83 e0 03          	and    $0x3,%r8
    46b5:	74 1d                	je     46d4 <fwp_apply+0x1e4>
    46b7:	48 89 d6             	mov    %rdx,%rsi
    46ba:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)
    46c0:	4c 8b 0c f3          	mov    (%rbx,%rsi,8),%r9
    46c4:	46 8d 14 2e          	lea    (%rsi,%r13,1),%r10d
    46c8:	4e 89 0c d7          	mov    %r9,(%rdi,%r10,8)
    46cc:	48 ff c6             	inc    %rsi
    46cf:	49 ff c8             	dec    %r8
    46d2:	75 ec                	jne    46c0 <fwp_apply+0x1d0>
    46d4:	4c 29 f2             	sub    %r14,%rdx
    46d7:	48 83 fa fc          	cmp    $0xfffffffffffffffc,%rdx
    46db:	77 47                	ja     4724 <fwp_apply+0x234>
    46dd:	0f 1f 00             	nopl   (%rax)
    46e0:	48 8b 14 f3          	mov    (%rbx,%rsi,8),%rdx
    46e4:	46 8d 04 2e          	lea    (%rsi,%r13,1),%r8d
    46e8:	4a 89 14 c7          	mov    %rdx,(%rdi,%r8,8)
    46ec:	48 8b 54 f3 08       	mov    0x8(%rbx,%rsi,8),%rdx
    46f1:	46 8d 04 2e          	lea    (%rsi,%r13,1),%r8d
    46f5:	41 ff c0             	inc    %r8d
    46f8:	4a 89 14 c7          	mov    %rdx,(%rdi,%r8,8)
    46fc:	48 8b 54 f3 10       	mov    0x10(%rbx,%rsi,8),%rdx
    4701:	45 8d 44 35 02       	lea    0x2(%r13,%rsi,1),%r8d
    4706:	4a 89 14 c7          	mov    %rdx,(%rdi,%r8,8)
    470a:	48 8b 54 f3 18       	mov    0x18(%rbx,%rsi,8),%rdx
    470f:	46 8d 04 2e          	lea    (%rsi,%r13,1),%r8d
    4713:	41 83 c0 03          	add    $0x3,%r8d
    4717:	4a 89 14 c7          	mov    %rdx,(%rdi,%r8,8)
    471b:	48 83 c6 04          	add    $0x4,%rsi
    471f:	49 39 f6             	cmp    %rsi,%r14
    4722:	75 bc                	jne    46e0 <fwp_apply+0x1f0>
    4724:	45 89 dc             	mov    %r11d,%r12d
    4727:	ff 54 08 08          	call   *0x8(%rax,%rcx,1)
    472b:	b9 01 00 00 00       	mov    $0x1,%ecx
    4730:	48 8b 75 d0          	mov    -0x30(%rbp),%rsi
    4734:	89 f2                	mov    %esi,%edx
    4736:	44 29 e2             	sub    %r12d,%edx
    4739:	0f 85 d1 fd ff ff    	jne    4510 <fwp_apply+0x20>
    473f:	89 f2                	mov    %esi,%edx
    4741:	49 89 c6             	mov    %rax,%r14
    4744:	e9 d4 fd ff ff       	jmp    451d <fwp_apply+0x2d>
    4749:	49 8d 56 ff          	lea    -0x1(%r14),%rdx
    474d:	89 d6                	mov    %edx,%esi
    474f:	44 01 ee             	add    %r13d,%esi
    4752:	0f 82 51 ff ff ff    	jb     46a9 <fwp_apply+0x1b9>
    4758:	48 c1 ea 20          	shr    $0x20,%rdx
    475c:	ba 00 00 00 00       	mov    $0x0,%edx
    4761:	0f 85 44 ff ff ff    	jne    46ab <fwp_apply+0x1bb>
    4767:	4a 8d 14 ef          	lea    (%rdi,%r13,8),%rdx
    476b:	48 29 da             	sub    %rbx,%rdx
    476e:	48 83 fa 20          	cmp    $0x20,%rdx
    4772:	0f 82 31 ff ff ff    	jb     46a9 <fwp_apply+0x1b9>
    4778:	44 89 f2             	mov    %r14d,%edx
    477b:	83 e2 fc             	and    $0xfffffffc,%edx
    477e:	31 f6                	xor    %esi,%esi
    4780:	0f 10 04 f3          	movups (%rbx,%rsi,8),%xmm0
    4784:	0f 10 4c f3 10       	movups 0x10(%rbx,%rsi,8),%xmm1
    4789:	46 8d 04 2e          	lea    (%rsi,%r13,1),%r8d
    478d:	42 0f 11 04 c7       	movups %xmm0,(%rdi,%r8,8)
    4792:	42 0f 11 4c c7 10    	movups %xmm1,0x10(%rdi,%r8,8)
    4798:	48 83 c6 04          	add    $0x4,%rsi
    479c:	48 39 f2             	cmp    %rsi,%rdx
    479f:	75 df                	jne    4780 <fwp_apply+0x290>
    47a1:	4c 39 f2             	cmp    %r14,%rdx
    47a4:	0f 85 01 ff ff ff    	jne    46ab <fwp_apply+0x1bb>
    47aa:	e9 75 ff ff ff       	jmp    4724 <fwp_apply+0x234>
    47af:	44 89 f0             	mov    %r14d,%eax
    47b2:	41 81 fe ff 07 00 00 	cmp    $0x7ff,%r14d
    47b9:	77 72                	ja     482d <fwp_apply+0x33d>
    47bb:	48 8d 14 c5 00 00 00 	lea    0x0(,%rax,8),%rdx
    47c2:	00 
    47c3:	48 83 c2 17          	add    $0x17,%rdx
    47c7:	48 c1 ea 04          	shr    $0x4,%rdx
    47cb:	48 8d 0d d6 a9 00 00 	lea    0xa9d6(%rip),%rcx        # f1a8 <fwp_gc>
    47d2:	0f b6 bc 0a e8 0b 00 	movzbl 0xbe8(%rdx,%rcx,1),%edi
    47d9:	00 
    47da:	8b 94 b9 48 0b 00 00 	mov    0xb48(%rcx,%rdi,4),%edx
    47e1:	48 29 15 c0 a9 00 00 	sub    %rdx,0xa9c0(%rip)        # f1a8 <fwp_gc>
    47e8:	78 43                	js     482d <fwp_apply+0x33d>
    47ea:	4c 8d 04 7f          	lea    (%rdi,%rdi,2),%r8
    47ee:	4a 8d 3c c1          	lea    (%rcx,%r8,8),%rdi
    47f2:	48 81 c7 88 07 00 00 	add    $0x788,%rdi
    47f9:	4c 8b 27             	mov    (%rdi),%r12
    47fc:	4d 85 e4             	test   %r12,%r12
    47ff:	74 14                	je     4815 <fwp_apply+0x325>
    4801:	49 8b 04 24          	mov    (%r12),%rax
    4805:	48 f7 d0             	not    %rax
    4808:	48 89 07             	mov    %rax,(%rdi)
    480b:	eb 48                	jmp    4855 <fwp_apply+0x365>
    480d:	4d 89 fe             	mov    %r15,%r14
    4810:	e9 c1 01 00 00       	jmp    49d6 <fwp_apply+0x4e6>
    4815:	4e 8b a4 c1 90 07 00 	mov    0x790(%rcx,%r8,8),%r12
    481c:	00 
    481d:	4a 8b bc c1 98 07 00 	mov    0x798(%rcx,%r8,8),%rdi
    4824:	00 
    4825:	4c 29 e7             	sub    %r12,%rdi
    4828:	48 39 d7             	cmp    %rdx,%rdi
    482b:	73 17                	jae    4844 <fwp_apply+0x354>
    482d:	48 8d 3c c5 08 00 00 	lea    0x8(,%rax,8),%rdi
    4834:	00 
    4835:	be 02 00 00 00       	mov    $0x2,%esi
    483a:	e8 31 0d 00 00       	call   5570 <fwp_gc_alloc_slow>
    483f:	49 89 c4             	mov    %rax,%r12
    4842:	eb 1b                	jmp    485f <fwp_apply+0x36f>
    4844:	4a 8d 04 c1          	lea    (%rcx,%r8,8),%rax
    4848:	48 05 90 07 00 00    	add    $0x790,%rax
    484e:	49 8d 0c 14          	lea    (%r12,%rdx,1),%rcx
    4852:	48 89 08             	mov    %rcx,(%rax)
    4855:	4c 89 e7             	mov    %r12,%rdi
    4858:	31 f6                	xor    %esi,%esi
    485a:	e8 01 d9 ff ff       	call   2160 <memset@plt>
    485f:	41 8b 07             	mov    (%r15),%eax
    4862:	41 89 04 24          	mov    %eax,(%r12)
    4866:	45 89 74 24 04       	mov    %r14d,0x4(%r12)
    486b:	4d 85 ed             	test   %r13,%r13
    486e:	4d 89 e6             	mov    %r12,%r14
    4871:	48 8b 7d d0          	mov    -0x30(%rbp),%rdi
    4875:	0f 84 c6 00 00 00    	je     4941 <fwp_apply+0x451>
    487b:	31 c0                	xor    %eax,%eax
    487d:	41 83 fd 06          	cmp    $0x6,%r13d
    4881:	72 53                	jb     48d6 <fwp_apply+0x3e6>
    4883:	4c 89 f1             	mov    %r14,%rcx
    4886:	4c 29 f9             	sub    %r15,%rcx
    4889:	48 83 f9 20          	cmp    $0x20,%rcx
    488d:	72 47                	jb     48d6 <fwp_apply+0x3e6>
    488f:	44 89 e8             	mov    %r13d,%eax
    4892:	83 e0 fc             	and    $0xfffffffc,%eax
    4895:	4a 8d 0c ed 00 00 00 	lea    0x0(,%r13,8),%rcx
    489c:	00 
    489d:	48 83 e1 e0          	and    $0xffffffffffffffe0,%rcx
    48a1:	31 d2                	xor    %edx,%edx
    48a3:	66 66 66 66 2e 0f 1f 	data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    48aa:	84 00 00 00 00 00 
    48b0:	41 0f 10 44 17 08    	movups 0x8(%r15,%rdx,1),%xmm0
    48b6:	41 0f 10 4c 17 18    	movups 0x18(%r15,%rdx,1),%xmm1
    48bc:	41 0f 11 44 16 08    	movups %xmm0,0x8(%r14,%rdx,1)
    48c2:	41 0f 11 4c 16 18    	movups %xmm1,0x18(%r14,%rdx,1)
    48c8:	48 83 c2 20          	add    $0x20,%rdx
    48cc:	48 39 d1             	cmp    %rdx,%rcx
    48cf:	75 df                	jne    48b0 <fwp_apply+0x3c0>
    48d1:	4c 39 e8             	cmp    %r13,%rax
    48d4:	74 6b                	je     4941 <fwp_apply+0x451>
    48d6:	4c 89 ea             	mov    %r13,%rdx
    48d9:	48 89 c1             	mov    %rax,%rcx
    48dc:	48 83 e2 03          	and    $0x3,%rdx
    48e0:	74 20                	je     4902 <fwp_apply+0x412>
    48e2:	48 89 c1             	mov    %rax,%rcx
    48e5:	66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
    48ec:	00 00 00 00 
    48f0:	49 8b 74 cf 08       	mov    0x8(%r15,%rcx,8),%rsi
    48f5:	49 89 74 ce 08       	mov    %rsi,0x8(%r14,%rcx,8)
    48fa:	48 ff c1             	inc    %rcx
    48fd:	48 ff ca             	dec    %rdx
    4900:	75 ee                	jne    48f0 <fwp_apply+0x400>
    4902:	4c 29 e8             	sub    %r13,%rax
    4905:	48 83 f8 fc          	cmp    $0xfffffffffffffffc,%rax
    4909:	77 36                	ja     4941 <fwp_apply+0x451>
    490b:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)
    4910:	49 8b 44 cf 08       	mov    0x8(%r15,%rcx,8),%rax
    4915:	49 89 44 ce 08       	mov    %rax,0x8(%r14,%rcx,8)
    491a:	49 8b 44 cf 10       	mov    0x10(%r15,%rcx,8),%rax
    491f:	49 89 44 ce 10       	mov    %rax,0x10(%r14,%rcx,8)
    4924:	49 8b 44 cf 18       	mov    0x18(%r15,%rcx,8),%rax
    4929:	49 89 44 ce 18       	mov    %rax,0x18(%r14,%rcx,8)
    492e:	49 8b 44 cf 20       	mov    0x20(%r15,%rcx,8),%rax
    4933:	49 89 44 ce 20       	mov    %rax,0x20(%r14,%rcx,8)
    4938:	48 83 c1 04          	add    $0x4,%rcx
    493c:	49 39 cd             	cmp    %rcx,%r13
    493f:	75 cf                	jne    4910 <fwp_apply+0x420>
    4941:	85 ff                	test   %edi,%edi
    4943:	0f 84 8d 00 00 00    	je     49d6 <fwp_apply+0x4e6>
    4949:	89 f8                	mov    %edi,%eax
    494b:	83 ff 14             	cmp    $0x14,%edi
    494e:	0f 83 94 00 00 00    	jae    49e8 <fwp_apply+0x4f8>
    4954:	31 c9                	xor    %ecx,%ecx
    4956:	48 89 c6             	mov    %rax,%rsi
    4959:	48 89 ca             	mov    %rcx,%rdx
    495c:	48 83 e6 03          	and    $0x3,%rsi
    4960:	74 23                	je     4985 <fwp_apply+0x495>
    4962:	48 89 ca             	mov    %rcx,%rdx
    4965:	66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
    496c:	00 00 00 00 
    4970:	48 8b 3c d3          	mov    (%rbx,%rdx,8),%rdi
    4974:	46 8d 04 2a          	lea    (%rdx,%r13,1),%r8d
    4978:	4b 89 7c c6 08       	mov    %rdi,0x8(%r14,%r8,8)
    497d:	48 ff c2             	inc    %rdx
    4980:	48 ff ce             	dec    %rsi
    4983:	75 eb                	jne    4970 <fwp_apply+0x480>
    4985:	48 29 c1             	sub    %rax,%rcx
    4988:	48 83 f9 fc          	cmp    $0xfffffffffffffffc,%rcx
    498c:	77 48                	ja     49d6 <fwp_apply+0x4e6>
    498e:	66 90                	xchg   %ax,%ax
    4990:	48 8b 0c d3          	mov    (%rbx,%rdx,8),%rcx
    4994:	42 8d 34 2a          	lea    (%rdx,%r13,1),%esi
    4998:	49 89 4c f6 08       	mov    %rcx,0x8(%r14,%rsi,8)
    499d:	48 8b 4c d3 08       	mov    0x8(%rbx,%rdx,8),%rcx
    49a2:	42 8d 34 2a          	lea    (%rdx,%r13,1),%esi
    49a6:	ff c6                	inc    %esi
    49a8:	49 89 4c f6 08       	mov    %rcx,0x8(%r14,%rsi,8)
    49ad:	48 8b 4c d3 10       	mov    0x10(%rbx,%rdx,8),%rcx
    49b2:	41 8d 74 15 02       	lea    0x2(%r13,%rdx,1),%esi
    49b7:	49 89 4c f6 08       	mov    %rcx,0x8(%r14,%rsi,8)
    49bc:	48 8b 4c d3 18       	mov    0x18(%rbx,%rdx,8),%rcx
    49c1:	42 8d 34 2a          	lea    (%rdx,%r13,1),%esi
    49c5:	83 c6 03             	add    $0x3,%esi
    49c8:	49 89 4c f6 08       	mov    %rcx,0x8(%r14,%rsi,8)
    49cd:	48 83 c2 04          	add    $0x4,%rdx
    49d1:	48 39 d0             	cmp    %rdx,%rax
    49d4:	75 ba                	jne    4990 <fwp_apply+0x4a0>
    49d6:	4c 89 f0             	mov    %r14,%rax
    49d9:	48 8d 65 d8          	lea    -0x28(%rbp),%rsp
    49dd:	5b                   	pop    %rbx
    49de:	41 5c                	pop    %r12
    49e0:	41 5d                	pop    %r13
    49e2:	41 5e                	pop    %r14
    49e4:	41 5f                	pop    %r15
    49e6:	5d                   	pop    %rbp
    49e7:	c3                   	ret
    49e8:	48 8d 50 ff          	lea    -0x1(%rax),%rdx
    49ec:	31 c9                	xor    %ecx,%ecx
    49ee:	89 d6                	mov    %edx,%esi
    49f0:	44 01 ee             	add    %r13d,%esi
    49f3:	0f 82 5d ff ff ff    	jb     4956 <fwp_apply+0x466>
    49f9:	48 c1 ea 20          	shr    $0x20,%rdx
    49fd:	0f 85 53 ff ff ff    	jne    4956 <fwp_apply+0x466>
    4a03:	4b 8d 0c ee          	lea    (%r14,%r13,8),%rcx
    4a07:	48 29 d9             	sub    %rbx,%rcx
    4a0a:	48 83 c1 08          	add    $0x8,%rcx
    4a0e:	48 83 f9 20          	cmp    $0x20,%rcx
    4a12:	0f 82 3c ff ff ff    	jb     4954 <fwp_apply+0x464>
    4a18:	89 c1                	mov    %eax,%ecx
    4a1a:	83 e1 fc             	and    $0xfffffffc,%ecx
    4a1d:	31 d2                	xor    %edx,%edx
    4a1f:	90                   	nop
    4a20:	0f 10 04 d3          	movups (%rbx,%rdx,8),%xmm0
    4a24:	0f 10 4c d3 10       	movups 0x10(%rbx,%rdx,8),%xmm1
    4a29:	42 8d 34 2a          	lea    (%rdx,%r13,1),%esi
    4a2d:	41 0f 11 44 f6 08    	movups %xmm0,0x8(%r14,%rsi,8)
    4a33:	41 0f 11 4c f6 18    	movups %xmm1,0x18(%r14,%rsi,8)
    4a39:	48 83 c2 04          	add    $0x4,%rdx
    4a3d:	48 39 d1             	cmp    %rdx,%rcx
    4a40:	75 de                	jne    4a20 <fwp_apply+0x530>
    4a42:	48 39 c1             	cmp    %rax,%rcx
    4a45:	0f 85 0b ff ff ff    	jne    4956 <fwp_apply+0x466>
    4a4b:	eb 89                	jmp    49d6 <fwp_apply+0x4e6>
    4a4d:	0f 1f 00             	nopl   (%rax)

0000000000004a50 <fwp_apply_release>:
    4a50:	41 56                	push   %r14
    4a52:	53                   	push   %rbx
    4a53:	50                   	push   %rax
    4a54:	48 8b 1f             	mov    (%rdi),%rbx
    4a57:	48 c7 07 00 00 00 00 	movq   $0x0,(%rdi)
    4a5e:	8b 47 20             	mov    0x20(%rdi),%eax
    4a61:	8b 4f 18             	mov    0x18(%rdi),%ecx
    4a64:	89 c2                	mov    %eax,%edx
    4a66:	29 ca                	sub    %ecx,%edx
    4a68:	74 2d                	je     4a97 <fwp_apply_release+0x47>
    4a6a:	48 8b 77 10          	mov    0x10(%rdi),%rsi
    4a6e:	4c 8b 46 18          	mov    0x18(%rsi),%r8
    4a72:	4d 85 c0             	test   %r8,%r8
    4a75:	74 20                	je     4a97 <fwp_apply_release+0x47>
    4a77:	48 89 c8             	mov    %rcx,%rax
    4a7a:	48 c1 e0 03          	shl    $0x3,%rax
    4a7e:	48 03 47 08          	add    0x8(%rdi),%rax
    4a82:	8b 77 1c             	mov    0x1c(%rdi),%esi
    4a85:	01 ce                	add    %ecx,%esi
    4a87:	49 89 fe             	mov    %rdi,%r14
    4a8a:	48 89 c7             	mov    %rax,%rdi
    4a8d:	41 ff d0             	call   *%r8
    4a90:	4c 89 f7             	mov    %r14,%rdi
    4a93:	41 8b 46 20          	mov    0x20(%r14),%eax
    4a97:	89 47 18             	mov    %eax,0x18(%rdi)
    4a9a:	48 85 db             	test   %rbx,%rbx
    4a9d:	74 0f                	je     4aae <fwp_apply_release+0x5e>
    4a9f:	48 89 df             	mov    %rbx,%rdi
    4aa2:	48 83 c4 08          	add    $0x8,%rsp
    4aa6:	5b                   	pop    %rbx
    4aa7:	41 5e                	pop    %r14
    4aa9:	e9 42 16 00 00       	jmp    60f0 <fwp_closure_drop>
    4aae:	48 83 c4 08          	add    $0x8,%rsp
    4ab2:	5b                   	pop    %rbx
    4ab3:	41 5e                	pop    %r14
    4ab5:	c3                   	ret
    4ab6:	66 2e 0f 1f 84 00 00 	cs nopw 0x0(%rax,%rax,1)
    4abd:	00 00 00 

0000000000004ac0 <fwp_apply_owned>:
    4ac0:	55                   	push   %rbp
    4ac1:	48 89 e5             	mov    %rsp,%rbp
    4ac4:	41 57                	push   %r15
    4ac6:	41 56                	push   %r14
    4ac8:	41 55                	push   %r13
    4aca:	41 54                	push   %r12
    4acc:	53                   	push   %rbx
    4acd:	48 81 ec 88 00 00 00 	sub    $0x88,%rsp
    4ad4:	48 89 d3             	mov    %rdx,%rbx
    4ad7:	41 89 f5             	mov    %esi,%r13d
    4ada:	48 8b 05 6f c1 00 00 	mov    0xc16f(%rip),%rax        # 10c50 <fwp_fns>
    4ae1:	8b 17                	mov    (%rdi),%edx
    4ae3:	48 89 d6             	mov    %rdx,%rsi
    4ae6:	48 c1 e6 05          	shl    $0x5,%rsi
    4aea:	48 8b 4c 30 18       	mov    0x18(%rax,%rsi,1),%rcx
    4aef:	48 85 c9             	test   %rcx,%rcx
    4af2:	0f 84 fc 03 00 00    	je     4ef4 <fwp_apply_owned+0x434>
    4af8:	4c 8d 14 30          	lea    (%rax,%rsi,1),%r10
    4afc:	49 83 c2 18          	add    $0x18,%r10
    4b00:	49 89 fc             	mov    %rdi,%r12
    4b03:	66 66 66 66 2e 0f 1f 	data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    4b0a:	84 00 00 00 00 00 
    4b10:	48 c1 e2 05          	shl    $0x5,%rdx
    4b14:	8b 04 10             	mov    (%rax,%rdx,1),%eax
    4b17:	45 8b 7c 24 04       	mov    0x4(%r12),%r15d
    4b1c:	48 89 bd 68 ff ff ff 	mov    %rdi,-0x98(%rbp)
    4b23:	48 89 9d 70 ff ff ff 	mov    %rbx,-0x90(%rbp)
    4b2a:	48 89 8d 78 ff ff ff 	mov    %rcx,-0x88(%rbp)
    4b31:	c7 45 80 00 00 00 00 	movl   $0x0,-0x80(%rbp)
    4b38:	44 89 7d 84          	mov    %r15d,-0x7c(%rbp)
    4b3c:	48 89 fa             	mov    %rdi,%rdx
    4b3f:	48 2b 15 92 b6 00 00 	sub    0xb692(%rip),%rdx        # 101d8 <fwp_gc+0x1030>
    4b46:	44 89 6d 88          	mov    %r13d,-0x78(%rbp)
    4b4a:	48 8b 35 af b6 00 00 	mov    0xb6af(%rip),%rsi        # 10200 <fwp_gc+0x1058>
    4b51:	48 c1 e6 10          	shl    $0x10,%rsi
    4b55:	48 39 f2             	cmp    %rsi,%rdx
    4b58:	73 76                	jae    4bd0 <fwp_apply_owned+0x110>
    4b5a:	48 8b 35 bf b6 00 00 	mov    0xb6bf(%rip),%rsi        # 10220 <fwp_gc+0x1078>
    4b61:	49 89 d0             	mov    %rdx,%r8
    4b64:	49 c1 e8 10          	shr    $0x10,%r8
    4b68:	4d 69 c8 28 12 00 00 	imul   $0x1228,%r8,%r9
    4b6f:	46 0f b6 04 0e       	movzbl (%rsi,%r9,1),%r8d
    4b74:	48 81 e2 ff ff 00 00 	and    $0xffff,%rdx
    4b7b:	75 23                	jne    4ba0 <fwp_apply_owned+0xe0>
    4b7d:	41 80 f8 02          	cmp    $0x2,%r8b
    4b81:	75 1d                	jne    4ba0 <fwp_apply_owned+0xe0>
    4b83:	4a 8d 14 0e          	lea    (%rsi,%r9,1),%rdx
    4b87:	48 81 c2 28 02 00 00 	add    $0x228,%rdx
    4b8e:	80 3a 00             	cmpb   $0x0,(%rdx)
    4b91:	75 52                	jne    4be5 <fwp_apply_owned+0x125>
    4b93:	eb 3b                	jmp    4bd0 <fwp_apply_owned+0x110>
    4b95:	66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
    4b9c:	00 00 00 00 
    4ba0:	41 80 f8 01          	cmp    $0x1,%r8b
    4ba4:	75 2a                	jne    4bd0 <fwp_apply_owned+0x110>
    4ba6:	4e 8d 04 0e          	lea    (%rsi,%r9,1),%r8
    4baa:	42 8b 74 0e 20       	mov    0x20(%rsi,%r9,1),%esi
    4baf:	48 0f af d6          	imul   %rsi,%rdx
    4bb3:	48 c1 ea 20          	shr    $0x20,%rdx
    4bb7:	4c 01 c2             	add    %r8,%rdx
    4bba:	48 81 c2 28 02 00 00 	add    $0x228,%rdx
    4bc1:	80 3a 00             	cmpb   $0x0,(%rdx)
    4bc4:	75 1f                	jne    4be5 <fwp_apply_owned+0x125>
    4bc6:	66 2e 0f 1f 84 00 00 	cs nopw 0x0(%rax,%rax,1)
    4bcd:	00 00 00 
    4bd0:	48 83 79 18 00       	cmpq   $0x0,0x18(%rcx)
    4bd5:	74 49                	je     4c20 <fwp_apply_owned+0x160>
    4bd7:	4d 85 ff             	test   %r15,%r15
    4bda:	75 09                	jne    4be5 <fwp_apply_owned+0x125>
    4bdc:	31 d2                	xor    %edx,%edx
    4bde:	41 39 c5             	cmp    %eax,%r13d
    4be1:	72 02                	jb     4be5 <fwp_apply_owned+0x125>
    4be3:	76 3d                	jbe    4c22 <fwp_apply_owned+0x162>
    4be5:	48 8b 15 8c c0 00 00 	mov    0xc08c(%rip),%rdx        # 10c78 <fwp_cleanups>
    4bec:	48 89 55 98          	mov    %rdx,-0x68(%rbp)
    4bf0:	48 8d 15 59 fe ff ff 	lea    -0x1a7(%rip),%rdx        # 4a50 <fwp_apply_release>
    4bf7:	48 89 55 a0          	mov    %rdx,-0x60(%rbp)
    4bfb:	48 8d 95 68 ff ff ff 	lea    -0x98(%rbp),%rdx
    4c02:	48 89 55 a8          	mov    %rdx,-0x58(%rbp)
    4c06:	48 8d 55 98          	lea    -0x68(%rbp),%rdx
    4c0a:	48 89 15 67 c0 00 00 	mov    %rdx,0xc067(%rip)        # 10c78 <fwp_cleanups>
    4c11:	b2 01                	mov    $0x1,%dl
    4c13:	eb 0d                	jmp    4c22 <fwp_apply_owned+0x162>
    4c15:	66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
    4c1c:	00 00 00 00 
    4c20:	31 d2                	xor    %edx,%edx
    4c22:	47 8d 34 2f          	lea    (%r15,%r13,1),%r14d
    4c26:	41 39 c6             	cmp    %eax,%r14d
    4c29:	48 89 7d c8          	mov    %rdi,-0x38(%rbp)
    4c2d:	89 55 bc             	mov    %edx,-0x44(%rbp)
    4c30:	0f 82 2c 03 00 00    	jb     4f62 <fwp_apply_owned+0x4a2>
    4c36:	41 89 c3             	mov    %eax,%r11d
    4c39:	45 29 fb             	sub    %r15d,%r11d
    4c3c:	45 89 d9             	mov    %r11d,%r9d
    4c3f:	4d 85 ff             	test   %r15,%r15
    4c42:	4c 89 4d d0          	mov    %r9,-0x30(%rbp)
    4c46:	75 18                	jne    4c60 <fwp_apply_owned+0x1a0>
    4c48:	85 c0                	test   %eax,%eax
    4c4a:	74 14                	je     4c60 <fwp_apply_owned+0x1a0>
    4c4c:	45 89 de             	mov    %r11d,%r14d
    4c4f:	44 89 5d 80          	mov    %r11d,-0x80(%rbp)
    4c53:	48 89 df             	mov    %rbx,%rdi
    4c56:	ff 11                	call   *(%rcx)
    4c58:	49 89 c4             	mov    %rax,%r12
    4c5b:	e9 2b 02 00 00       	jmp    4e8b <fwp_apply_owned+0x3cb>
    4c60:	4c 89 6d c0          	mov    %r13,-0x40(%rbp)
    4c64:	48 89 65 90          	mov    %rsp,-0x70(%rbp)
    4c68:	85 c0                	test   %eax,%eax
    4c6a:	b9 01 00 00 00       	mov    $0x1,%ecx
    4c6f:	0f 45 c8             	cmovne %eax,%ecx
    4c72:	48 8d 0c cd 0f 00 00 	lea    0xf(,%rcx,8),%rcx
    4c79:	00 
    4c7a:	48 83 e1 f0          	and    $0xfffffffffffffff0,%rcx
    4c7e:	49 89 e5             	mov    %rsp,%r13
    4c81:	49 29 cd             	sub    %rcx,%r13
    4c84:	4c 89 ec             	mov    %r13,%rsp
    4c87:	4d 85 ff             	test   %r15,%r15
    4c8a:	0f 84 d0 00 00 00    	je     4d60 <fwp_apply_owned+0x2a0>
    4c90:	41 83 ff 04          	cmp    $0x4,%r15d
    4c94:	72 10                	jb     4ca6 <fwp_apply_owned+0x1e6>
    4c96:	4c 89 e9             	mov    %r13,%rcx
    4c99:	4c 29 e1             	sub    %r12,%rcx
    4c9c:	48 83 c1 f8          	add    $0xfffffffffffffff8,%rcx
    4ca0:	48 83 f9 20          	cmp    $0x20,%rcx
    4ca4:	73 6d                	jae    4d13 <fwp_apply_owned+0x253>
    4ca6:	31 c9                	xor    %ecx,%ecx
    4ca8:	4c 89 fe             	mov    %r15,%rsi
    4cab:	48 89 ca             	mov    %rcx,%rdx
    4cae:	48 83 e6 03          	and    $0x3,%rsi
    4cb2:	74 1e                	je     4cd2 <fwp_apply_owned+0x212>
    4cb4:	48 89 ca             	mov    %rcx,%rdx
    4cb7:	66 0f 1f 84 00 00 00 	nopw   0x0(%rax,%rax,1)
    4cbe:	00 00 
    4cc0:	4d 8b 44 d4 08       	mov    0x8(%r12,%rdx,8),%r8
    4cc5:	4d 89 44 d5 00       	mov    %r8,0x0(%r13,%rdx,8)
    4cca:	48 ff c2             	inc    %rdx
    4ccd:	48 ff ce             	dec    %rsi
    4cd0:	75 ee                	jne    4cc0 <fwp_apply_owned+0x200>
    4cd2:	4c 29 f9             	sub    %r15,%rcx
    4cd5:	48 83 f9 fc          	cmp    $0xfffffffffffffffc,%rcx
    4cd9:	0f 87 81 00 00 00    	ja     4d60 <fwp_apply_owned+0x2a0>
    4cdf:	90                   	nop
    4ce0:	49 8b 4c d4 08       	mov    0x8(%r12,%rdx,8),%rcx
    4ce5:	49 89 4c d5 00       	mov    %rcx,0x0(%r13,%rdx,8)
    4cea:	49 8b 4c d4 10       	mov    0x10(%r12,%rdx,8),%rcx
    4cef:	49 89 4c d5 08       	mov    %rcx,0x8(%r13,%rdx,8)
    4cf4:	49 8b 4c d4 18       	mov    0x18(%r12,%rdx,8),%rcx
    4cf9:	49 89 4c d5 10       	mov    %rcx,0x10(%r13,%rdx,8)
    4cfe:	49 8b 4c d4 20       	mov    0x20(%r12,%rdx,8),%rcx
    4d03:	49 89 4c d5 18       	mov    %rcx,0x18(%r13,%rdx,8)
    4d08:	48 83 c2 04          	add    $0x4,%rdx
    4d0c:	49 39 d7             	cmp    %rdx,%r15
    4d0f:	75 cf                	jne    4ce0 <fwp_apply_owned+0x220>
    4d11:	eb 4d                	jmp    4d60 <fwp_apply_owned+0x2a0>
    4d13:	44 89 f9             	mov    %r15d,%ecx
    4d16:	83 e1 fc             	and    $0xfffffffc,%ecx
    4d19:	4a 8d 14 fd 00 00 00 	lea    0x0(,%r15,8),%rdx
    4d20:	00 
    4d21:	48 83 e2 e0          	and    $0xffffffffffffffe0,%rdx
    4d25:	31 f6                	xor    %esi,%esi
    4d27:	66 0f 1f 84 00 00 00 	nopw   0x0(%rax,%rax,1)
    4d2e:	00 00 
    4d30:	41 0f 10 44 34 08    	movups 0x8(%r12,%rsi,1),%xmm0
    4d36:	41 0f 10 4c 34 18    	movups 0x18(%r12,%rsi,1),%xmm1
    4d3c:	41 0f 29 44 35 00    	movaps %xmm0,0x0(%r13,%rsi,1)
    4d42:	41 0f 29 4c 35 10    	movaps %xmm1,0x10(%r13,%rsi,1)
    4d48:	48 83 c6 20          	add    $0x20,%rsi
    4d4c:	48 39 f2             	cmp    %rsi,%rdx
    4d4f:	75 df                	jne    4d30 <fwp_apply_owned+0x270>
    4d51:	4c 39 f9             	cmp    %r15,%rcx
    4d54:	0f 85 4e ff ff ff    	jne    4ca8 <fwp_apply_owned+0x1e8>
    4d5a:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)
    4d60:	44 39 f8             	cmp    %r15d,%eax
    4d63:	0f 84 f7 00 00 00    	je     4e60 <fwp_apply_owned+0x3a0>
    4d69:	41 83 fb 0a          	cmp    $0xa,%r11d
    4d6d:	0f 83 95 00 00 00    	jae    4e08 <fwp_apply_owned+0x348>
    4d73:	31 c0                	xor    %eax,%eax
    4d75:	4c 89 ca             	mov    %r9,%rdx
    4d78:	48 89 c1             	mov    %rax,%rcx
    4d7b:	48 83 e2 03          	and    $0x3,%rdx
    4d7f:	74 24                	je     4da5 <fwp_apply_owned+0x2e5>
    4d81:	48 89 c1             	mov    %rax,%rcx
    4d84:	66 66 66 2e 0f 1f 84 	data16 data16 cs nopw 0x0(%rax,%rax,1)
    4d8b:	00 00 00 00 00 
    4d90:	48 8b 34 cb          	mov    (%rbx,%rcx,8),%rsi
    4d94:	45 8d 04 0f          	lea    (%r15,%rcx,1),%r8d
    4d98:	4b 89 74 c5 00       	mov    %rsi,0x0(%r13,%r8,8)
    4d9d:	48 ff c1             	inc    %rcx
    4da0:	48 ff ca             	dec    %rdx
    4da3:	75 eb                	jne    4d90 <fwp_apply_owned+0x2d0>
    4da5:	4c 29 c8             	sub    %r9,%rax
    4da8:	48 83 f8 fc          	cmp    $0xfffffffffffffffc,%rax
    4dac:	0f 87 ae 00 00 00    	ja     4e60 <fwp_apply_owned+0x3a0>
    4db2:	66 66 66 66 66 2e 0f 	data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    4db9:	1f 84 00 00 00 00 00 
    4dc0:	48 8b 04 cb          	mov    (%rbx,%rcx,8),%rax
    4dc4:	41 8d 14 0f          	lea    (%r15,%rcx,1),%edx
    4dc8:	49 89 44 d5 00       	mov    %rax,0x0(%r13,%rdx,8)
    4dcd:	48 8b 44 cb 08       	mov    0x8(%rbx,%rcx,8),%rax
    4dd2:	41 8d 14 0f          	lea    (%r15,%rcx,1),%edx
    4dd6:	ff c2                	inc    %edx
    4dd8:	49 89 44 d5 00       	mov    %rax,0x0(%r13,%rdx,8)
    4ddd:	48 8b 44 cb 10       	mov    0x10(%rbx,%rcx,8),%rax
    4de2:	41 8d 54 0f 02       	lea    0x2(%r15,%rcx,1),%edx
    4de7:	49 89 44 d5 00       	mov    %rax,0x0(%r13,%rdx,8)
    4dec:	48 8b 44 cb 18       	mov    0x18(%rbx,%rcx,8),%rax
    4df1:	41 8d 14 0f          	lea    (%r15,%rcx,1),%edx
    4df5:	83 c2 03             	add    $0x3,%edx
    4df8:	49 89 44 d5 00       	mov    %rax,0x0(%r13,%rdx,8)
    4dfd:	48 83 c1 04          	add    $0x4,%rcx
    4e01:	49 39 c9             	cmp    %rcx,%r9
    4e04:	75 ba                	jne    4dc0 <fwp_apply_owned+0x300>
    4e06:	eb 58                	jmp    4e60 <fwp_apply_owned+0x3a0>
    4e08:	49 8d 41 ff          	lea    -0x1(%r9),%rax
    4e0c:	89 c1                	mov    %eax,%ecx
    4e0e:	44 01 f9             	add    %r15d,%ecx
    4e11:	0f 82 5c ff ff ff    	jb     4d73 <fwp_apply_owned+0x2b3>
    4e17:	48 c1 e8 20          	shr    $0x20,%rax
    4e1b:	b8 00 00 00 00       	mov    $0x0,%eax
    4e20:	0f 85 4f ff ff ff    	jne    4d75 <fwp_apply_owned+0x2b5>
    4e26:	44 89 c8             	mov    %r9d,%eax
    4e29:	83 e0 fc             	and    $0xfffffffc,%eax
    4e2c:	31 c9                	xor    %ecx,%ecx
    4e2e:	66 90                	xchg   %ax,%ax
    4e30:	0f 10 04 cb          	movups (%rbx,%rcx,8),%xmm0
    4e34:	0f 10 4c cb 10       	movups 0x10(%rbx,%rcx,8),%xmm1
    4e39:	41 8d 14 0f          	lea    (%r15,%rcx,1),%edx
    4e3d:	41 0f 11 44 d5 00    	movups %xmm0,0x0(%r13,%rdx,8)
    4e43:	41 0f 11 4c d5 10    	movups %xmm1,0x10(%r13,%rdx,8)
    4e49:	48 83 c1 04          	add    $0x4,%rcx
    4e4d:	48 39 c8             	cmp    %rcx,%rax
    4e50:	75 de                	jne    4e30 <fwp_apply_owned+0x370>
    4e52:	4c 39 c8             	cmp    %r9,%rax
    4e55:	0f 85 1a ff ff ff    	jne    4d75 <fwp_apply_owned+0x2b5>
    4e5b:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)
    4e60:	49 8b 02             	mov    (%r10),%rax
    4e63:	be 01 00 00 00       	mov    $0x1,%esi
    4e68:	4d 89 d7             	mov    %r10,%r15
    4e6b:	45 89 dc             	mov    %r11d,%r12d
    4e6e:	ff 50 08             	call   *0x8(%rax)
    4e71:	45 89 e6             	mov    %r12d,%r14d
    4e74:	44 89 65 80          	mov    %r12d,-0x80(%rbp)
    4e78:	49 8b 07             	mov    (%r15),%rax
    4e7b:	4c 89 ef             	mov    %r13,%rdi
    4e7e:	ff 10                	call   *(%rax)
    4e80:	49 89 c4             	mov    %rax,%r12
    4e83:	48 8b 65 90          	mov    -0x70(%rbp),%rsp
    4e87:	4c 8b 6d c0          	mov    -0x40(%rbp),%r13
    4e8b:	80 7d bc 00          	cmpb   $0x0,-0x44(%rbp)
    4e8f:	48 8b 7d c8          	mov    -0x38(%rbp),%rdi
    4e93:	74 1c                	je     4eb1 <fwp_apply_owned+0x3f1>
    4e95:	48 8d 45 98          	lea    -0x68(%rbp),%rax
    4e99:	48 39 05 d8 bd 00 00 	cmp    %rax,0xbdd8(%rip)        # 10c78 <fwp_cleanups>
    4ea0:	0f 85 c1 06 00 00    	jne    5567 <fwp_apply_owned+0xaa7>
    4ea6:	48 8b 45 98          	mov    -0x68(%rbp),%rax
    4eaa:	48 89 05 c7 bd 00 00 	mov    %rax,0xbdc7(%rip)        # 10c78 <fwp_cleanups>
    4eb1:	e8 3a 12 00 00       	call   60f0 <fwp_closure_drop>
    4eb6:	45 29 f5             	sub    %r14d,%r13d
    4eb9:	0f 84 96 06 00 00    	je     5555 <fwp_apply_owned+0xa95>
    4ebf:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
    4ec3:	48 8d 1c c3          	lea    (%rbx,%rax,8),%rbx
    4ec7:	48 8b 05 82 bd 00 00 	mov    0xbd82(%rip),%rax        # 10c50 <fwp_fns>
    4ece:	41 8b 14 24          	mov    (%r12),%edx
    4ed2:	48 89 d1             	mov    %rdx,%rcx
    4ed5:	48 c1 e1 05          	shl    $0x5,%rcx
    4ed9:	4c 8d 14 08          	lea    (%rax,%rcx,1),%r10
    4edd:	49 83 c2 18          	add    $0x18,%r10
    4ee1:	48 8b 4c 08 18       	mov    0x18(%rax,%rcx,1),%rcx
    4ee6:	4c 89 e7             	mov    %r12,%rdi
    4ee9:	48 85 c9             	test   %rcx,%rcx
    4eec:	0f 85 1e fc ff ff    	jne    4b10 <fwp_apply_owned+0x50>
    4ef2:	eb 03                	jmp    4ef7 <fwp_apply_owned+0x437>
    4ef4:	49 89 fc             	mov    %rdi,%r12
    4ef7:	48 8b 05 da b2 00 00 	mov    0xb2da(%rip),%rax        # 101d8 <fwp_gc+0x1030>
    4efe:	4c 89 e2             	mov    %r12,%rdx
    4f01:	48 29 c2             	sub    %rax,%rdx
    4f04:	48 8b 0d f5 b2 00 00 	mov    0xb2f5(%rip),%rcx        # 10200 <fwp_gc+0x1058>
    4f0b:	48 c1 e1 10          	shl    $0x10,%rcx
    4f0f:	48 39 ca             	cmp    %rcx,%rdx
    4f12:	0f 83 12 01 00 00    	jae    502a <fwp_apply_owned+0x56a>
    4f18:	48 8b 35 01 b3 00 00 	mov    0xb301(%rip),%rsi        # 10220 <fwp_gc+0x1078>
    4f1f:	48 89 d7             	mov    %rdx,%rdi
    4f22:	48 c1 ef 10          	shr    $0x10,%rdi
    4f26:	48 69 ff 28 12 00 00 	imul   $0x1228,%rdi,%rdi
    4f2d:	44 0f b6 04 3e       	movzbl (%rsi,%rdi,1),%r8d
    4f32:	48 81 e2 ff ff 00 00 	and    $0xffff,%rdx
    4f39:	0f 85 c2 00 00 00    	jne    5001 <fwp_apply_owned+0x541>
    4f3f:	41 80 f8 02          	cmp    $0x2,%r8b
    4f43:	0f 85 b8 00 00 00    	jne    5001 <fwp_apply_owned+0x541>
    4f49:	48 8d 14 3e          	lea    (%rsi,%rdi,1),%rdx
    4f4d:	48 81 c2 28 02 00 00 	add    $0x228,%rdx
    4f54:	80 3a 00             	cmpb   $0x0,(%rdx)
    4f57:	0f 84 cd 00 00 00    	je     502a <fwp_apply_owned+0x56a>
    4f5d:	e9 60 01 00 00       	jmp    50c2 <fwp_apply_owned+0x602>
    4f62:	4c 89 55 d0          	mov    %r10,-0x30(%rbp)
    4f66:	4c 89 6d c0          	mov    %r13,-0x40(%rbp)
    4f6a:	44 89 f1             	mov    %r14d,%ecx
    4f6d:	48 8d 3c cd 08 00 00 	lea    0x8(,%rcx,8),%rdi
    4f74:	00 
    4f75:	41 81 fe ff 07 00 00 	cmp    $0x7ff,%r14d
    4f7c:	0f 87 fb 01 00 00    	ja     517d <fwp_apply_owned+0x6bd>
    4f82:	48 c1 e1 03          	shl    $0x3,%rcx
    4f86:	4c 8d 41 17          	lea    0x17(%rcx),%r8
    4f8a:	49 c1 e8 04          	shr    $0x4,%r8
    4f8e:	48 8d 05 13 a2 00 00 	lea    0xa213(%rip),%rax        # f1a8 <fwp_gc>
    4f95:	41 0f b6 b4 00 e8 0b 	movzbl 0xbe8(%r8,%rax,1),%esi
    4f9c:	00 00 
    4f9e:	8b 94 b0 48 0b 00 00 	mov    0xb48(%rax,%rsi,4),%edx
    4fa5:	4c 8b 0d fc a1 00 00 	mov    0xa1fc(%rip),%r9        # f1a8 <fwp_gc>
    4fac:	4d 89 ca             	mov    %r9,%r10
    4faf:	49 29 d2             	sub    %rdx,%r10
    4fb2:	4c 89 15 ef a1 00 00 	mov    %r10,0xa1ef(%rip)        # f1a8 <fwp_gc>
    4fb9:	0f 88 be 01 00 00    	js     517d <fwp_apply_owned+0x6bd>
    4fbf:	4c 8d 14 76          	lea    (%rsi,%rsi,2),%r10
    4fc3:	4e 8d 1c d0          	lea    (%rax,%r10,8),%r11
    4fc7:	49 83 c3 08          	add    $0x8,%r11
    4fcb:	4d 8b 2b             	mov    (%r11),%r13
    4fce:	4d 85 ed             	test   %r13,%r13
    4fd1:	0f 84 2f 01 00 00    	je     5106 <fwp_apply_owned+0x646>
    4fd7:	49 8b 45 00          	mov    0x0(%r13),%rax
    4fdb:	48 f7 d0             	not    %rax
    4fde:	49 89 03             	mov    %rax,(%r11)
    4fe1:	48 39 d7             	cmp    %rdx,%rdi
    4fe4:	0f 83 b8 01 00 00    	jae    51a2 <fwp_apply_owned+0x6e2>
    4fea:	4c 01 ef             	add    %r13,%rdi
    4fed:	48 29 ca             	sub    %rcx,%rdx
    4ff0:	48 83 c2 f7          	add    $0xfffffffffffffff7,%rdx
    4ff4:	48 83 e2 f8          	and    $0xfffffffffffffff8,%rdx
    4ff8:	48 83 c2 08          	add    $0x8,%rdx
    4ffc:	e9 9a 01 00 00       	jmp    519b <fwp_apply_owned+0x6db>
    5001:	41 80 f8 01          	cmp    $0x1,%r8b
    5005:	75 23                	jne    502a <fwp_apply_owned+0x56a>
    5007:	4c 8d 04 3e          	lea    (%rsi,%rdi,1),%r8
    500b:	8b 74 3e 20          	mov    0x20(%rsi,%rdi,1),%esi
    500f:	48 0f af d6          	imul   %rsi,%rdx
    5013:	48 c1 ea 20          	shr    $0x20,%rdx
    5017:	4c 01 c2             	add    %r8,%rdx
    501a:	48 81 c2 28 02 00 00 	add    $0x228,%rdx
    5021:	80 3a 00             	cmpb   $0x0,(%rdx)
    5024:	0f 85 98 00 00 00    	jne    50c2 <fwp_apply_owned+0x602>
    502a:	45 85 ed             	test   %r13d,%r13d
    502d:	0f 84 bd 00 00 00    	je     50f0 <fwp_apply_owned+0x630>
    5033:	48 8b 15 e6 b1 00 00 	mov    0xb1e6(%rip),%rdx        # 10220 <fwp_gc+0x1078>
    503a:	44 89 ee             	mov    %r13d,%esi
    503d:	31 ff                	xor    %edi,%edi
    503f:	eb 2c                	jmp    506d <fwp_apply_owned+0x5ad>
    5041:	66 66 66 66 66 66 2e 	data16 data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    5048:	0f 1f 84 00 00 00 00 
    504f:	00 
    5050:	4e 8d 04 0a          	lea    (%rdx,%r9,1),%r8
    5054:	49 81 c0 28 02 00 00 	add    $0x228,%r8
    505b:	41 80 38 00          	cmpb   $0x0,(%r8)
    505f:	75 61                	jne    50c2 <fwp_apply_owned+0x602>
    5061:	48 ff c7             	inc    %rdi
    5064:	48 39 fe             	cmp    %rdi,%rsi
    5067:	0f 84 83 00 00 00    	je     50f0 <fwp_apply_owned+0x630>
    506d:	4c 8b 04 fb          	mov    (%rbx,%rdi,8),%r8
    5071:	49 29 c0             	sub    %rax,%r8
    5074:	49 39 c8             	cmp    %rcx,%r8
    5077:	73 e8                	jae    5061 <fwp_apply_owned+0x5a1>
    5079:	4d 89 c1             	mov    %r8,%r9
    507c:	49 c1 e9 10          	shr    $0x10,%r9
    5080:	4d 69 c9 28 12 00 00 	imul   $0x1228,%r9,%r9
    5087:	46 0f b6 14 0a       	movzbl (%rdx,%r9,1),%r10d
    508c:	49 81 e0 ff ff 00 00 	and    $0xffff,%r8
    5093:	75 06                	jne    509b <fwp_apply_owned+0x5db>
    5095:	41 80 fa 02          	cmp    $0x2,%r10b
    5099:	74 b5                	je     5050 <fwp_apply_owned+0x590>
    509b:	41 80 fa 01          	cmp    $0x1,%r10b
    509f:	75 c0                	jne    5061 <fwp_apply_owned+0x5a1>
    50a1:	4e 8d 14 0a          	lea    (%rdx,%r9,1),%r10
    50a5:	46 8b 4c 0a 20       	mov    0x20(%rdx,%r9,1),%r9d
    50aa:	4d 0f af c1          	imul   %r9,%r8
    50ae:	49 c1 e8 20          	shr    $0x20,%r8
    50b2:	4d 01 d0             	add    %r10,%r8
    50b5:	49 81 c0 28 02 00 00 	add    $0x228,%r8
    50bc:	41 80 38 00          	cmpb   $0x0,(%r8)
    50c0:	74 9f                	je     5061 <fwp_apply_owned+0x5a1>
    50c2:	e8 e9 e7 ff ff       	call   38b0 <fwp_flush>
    50c7:	48 8b 05 12 9f 00 00 	mov    0x9f12(%rip),%rax        # efe0 <stderr@GLIBC_2.2.5>
    50ce:	48 8b 38             	mov    (%rax),%rdi
    50d1:	48 8d 35 5c 72 00 00 	lea    0x725c(%rip),%rsi        # c334 <fwp_segv.msg+0xf4>
    50d8:	48 8d 15 28 72 00 00 	lea    0x7228(%rip),%rdx        # c307 <fwp_segv.msg+0xc7>
    50df:	31 c0                	xor    %eax,%eax
    50e1:	e8 fa d0 ff ff       	call   21e0 <fprintf@plt>
    50e6:	bf 65 00 00 00       	mov    $0x65,%edi
    50eb:	e8 e0 d1 ff ff       	call   22d0 <exit@plt>
    50f0:	4c 89 e7             	mov    %r12,%rdi
    50f3:	44 89 ee             	mov    %r13d,%esi
    50f6:	48 89 da             	mov    %rbx,%rdx
    50f9:	e8 f2 f3 ff ff       	call   44f0 <fwp_apply>
    50fe:	49 89 c4             	mov    %rax,%r12
    5101:	e9 4f 04 00 00       	jmp    5555 <fwp_apply_owned+0xa95>
    5106:	4e 8b 6c d0 10       	mov    0x10(%rax,%r10,8),%r13
    510b:	4e 8b 5c d0 18       	mov    0x18(%rax,%r10,8),%r11
    5110:	4d 29 eb             	sub    %r13,%r11
    5113:	49 39 d3             	cmp    %rdx,%r11
    5116:	72 34                	jb     514c <fwp_apply_owned+0x68c>
    5118:	4a 8d 34 d0          	lea    (%rax,%r10,8),%rsi
    511c:	48 83 c6 10          	add    $0x10,%rsi
    5120:	4e 8d 14 2a          	lea    (%rdx,%r13,1),%r10
    5124:	4c 89 16             	mov    %r10,(%rsi)
    5127:	4d 85 ed             	test   %r13,%r13
    512a:	0f 85 b1 fe ff ff    	jne    4fe1 <fwp_apply_owned+0x521>
    5130:	41 0f b6 b4 00 e8 0b 	movzbl 0xbe8(%r8,%rax,1),%esi
    5137:	00 00 
    5139:	8b 94 b0 48 0b 00 00 	mov    0xb48(%rax,%rsi,4),%edx
    5140:	49 29 d1             	sub    %rdx,%r9
    5143:	4c 89 0d 5e a0 00 00 	mov    %r9,0xa05e(%rip)        # f1a8 <fwp_gc>
    514a:	78 31                	js     517d <fwp_apply_owned+0x6bd>
    514c:	48 8d 0c 76          	lea    (%rsi,%rsi,2),%rcx
    5150:	4c 8b 6c c8 08       	mov    0x8(%rax,%rcx,8),%r13
    5155:	4d 85 ed             	test   %r13,%r13
    5158:	74 11                	je     516b <fwp_apply_owned+0x6ab>
    515a:	48 8d 04 c8          	lea    (%rax,%rcx,8),%rax
    515e:	48 83 c0 08          	add    $0x8,%rax
    5162:	49 8b 4d 00          	mov    0x0(%r13),%rcx
    5166:	48 f7 d1             	not    %rcx
    5169:	eb 2a                	jmp    5195 <fwp_apply_owned+0x6d5>
    516b:	4c 8b 6c c8 10       	mov    0x10(%rax,%rcx,8),%r13
    5170:	48 8b 74 c8 18       	mov    0x18(%rax,%rcx,8),%rsi
    5175:	4c 29 ee             	sub    %r13,%rsi
    5178:	48 39 d6             	cmp    %rdx,%rsi
    517b:	73 0c                	jae    5189 <fwp_apply_owned+0x6c9>
    517d:	31 f6                	xor    %esi,%esi
    517f:	e8 ec 03 00 00       	call   5570 <fwp_gc_alloc_slow>
    5184:	49 89 c5             	mov    %rax,%r13
    5187:	eb 19                	jmp    51a2 <fwp_apply_owned+0x6e2>
    5189:	48 8d 04 c8          	lea    (%rax,%rcx,8),%rax
    518d:	48 83 c0 10          	add    $0x10,%rax
    5191:	4a 8d 0c 2a          	lea    (%rdx,%r13,1),%rcx
    5195:	48 89 08             	mov    %rcx,(%rax)
    5198:	4c 89 ef             	mov    %r13,%rdi
    519b:	31 f6                	xor    %esi,%esi
    519d:	e8 be cf ff ff       	call   2160 <memset@plt>
    51a2:	48 8b 7d c8          	mov    -0x38(%rbp),%rdi
    51a6:	4c 8b 55 d0          	mov    -0x30(%rbp),%r10
    51aa:	41 8b 04 24          	mov    (%r12),%eax
    51ae:	41 89 45 00          	mov    %eax,0x0(%r13)
    51b2:	45 89 75 04          	mov    %r14d,0x4(%r13)
    51b6:	4c 89 e8             	mov    %r13,%rax
    51b9:	48 2b 05 18 b0 00 00 	sub    0xb018(%rip),%rax        # 101d8 <fwp_gc+0x1030>
    51c0:	48 8b 0d 39 b0 00 00 	mov    0xb039(%rip),%rcx        # 10200 <fwp_gc+0x1058>
    51c7:	48 c1 e1 10          	shl    $0x10,%rcx
    51cb:	48 39 c8             	cmp    %rcx,%rax
    51ce:	73 77                	jae    5247 <fwp_apply_owned+0x787>
    51d0:	48 8b 0d 49 b0 00 00 	mov    0xb049(%rip),%rcx        # 10220 <fwp_gc+0x1078>
    51d7:	48 89 c2             	mov    %rax,%rdx
    51da:	48 c1 ea 10          	shr    $0x10,%rdx
    51de:	48 69 d2 28 12 00 00 	imul   $0x1228,%rdx,%rdx
    51e5:	0f b6 34 11          	movzbl (%rcx,%rdx,1),%esi
    51e9:	48 25 ff ff 00 00    	and    $0xffff,%rax
    51ef:	75 1d                	jne    520e <fwp_apply_owned+0x74e>
    51f1:	40 80 fe 02          	cmp    $0x2,%sil
    51f5:	75 17                	jne    520e <fwp_apply_owned+0x74e>
    51f7:	4c 8d 34 11          	lea    (%rcx,%rdx,1),%r14
    51fb:	49 81 c6 28 02 00 00 	add    $0x228,%r14
    5202:	41 80 3e ff          	cmpb   $0xff,(%r14)
    5206:	74 2d                	je     5235 <fwp_apply_owned+0x775>
    5208:	41 c6 06 01          	movb   $0x1,(%r14)
    520c:	eb 39                	jmp    5247 <fwp_apply_owned+0x787>
    520e:	40 80 fe 01          	cmp    $0x1,%sil
    5212:	75 33                	jne    5247 <fwp_apply_owned+0x787>
    5214:	48 8d 34 11          	lea    (%rcx,%rdx,1),%rsi
    5218:	8b 4c 11 20          	mov    0x20(%rcx,%rdx,1),%ecx
    521c:	48 0f af c1          	imul   %rcx,%rax
    5220:	48 c1 e8 20          	shr    $0x20,%rax
    5224:	4c 8d 34 30          	lea    (%rax,%rsi,1),%r14
    5228:	49 81 c6 28 02 00 00 	add    $0x228,%r14
    522f:	41 80 3e ff          	cmpb   $0xff,(%r14)
    5233:	75 d3                	jne    5208 <fwp_apply_owned+0x748>
    5235:	4c 89 f7             	mov    %r14,%rdi
    5238:	e8 a3 e6 ff ff       	call   38e0 <fwp_rc_forget_slot>
    523d:	4c 8b 55 d0          	mov    -0x30(%rbp),%r10
    5241:	48 8b 7d c8          	mov    -0x38(%rbp),%rdi
    5245:	eb c1                	jmp    5208 <fwp_apply_owned+0x748>
    5247:	4c 89 6d b0          	mov    %r13,-0x50(%rbp)
    524b:	48 8b 05 26 ba 00 00 	mov    0xba26(%rip),%rax        # 10c78 <fwp_cleanups>
    5252:	48 89 85 50 ff ff ff 	mov    %rax,-0xb0(%rbp)
    5259:	48 8d 05 90 13 00 00 	lea    0x1390(%rip),%rax        # 65f0 <fwp_rc_cleanup_cell>
    5260:	48 89 85 58 ff ff ff 	mov    %rax,-0xa8(%rbp)
    5267:	48 8d 45 b0          	lea    -0x50(%rbp),%rax
    526b:	48 89 85 60 ff ff ff 	mov    %rax,-0xa0(%rbp)
    5272:	4c 8d b5 50 ff ff ff 	lea    -0xb0(%rbp),%r14
    5279:	4c 89 35 f8 b9 00 00 	mov    %r14,0xb9f8(%rip)        # 10c78 <fwp_cleanups>
    5280:	4d 85 ff             	test   %r15,%r15
    5283:	0f 84 c8 00 00 00    	je     5351 <fwp_apply_owned+0x891>
    5289:	31 c0                	xor    %eax,%eax
    528b:	41 83 ff 06          	cmp    $0x6,%r15d
    528f:	72 55                	jb     52e6 <fwp_apply_owned+0x826>
    5291:	4c 89 e9             	mov    %r13,%rcx
    5294:	4c 29 e1             	sub    %r12,%rcx
    5297:	48 83 f9 20          	cmp    $0x20,%rcx
    529b:	72 49                	jb     52e6 <fwp_apply_owned+0x826>
    529d:	44 89 f8             	mov    %r15d,%eax
    52a0:	83 e0 fc             	and    $0xfffffffc,%eax
    52a3:	4a 8d 0c fd 00 00 00 	lea    0x0(,%r15,8),%rcx
    52aa:	00 
    52ab:	48 83 e1 e0          	and    $0xffffffffffffffe0,%rcx
    52af:	31 d2                	xor    %edx,%edx
    52b1:	66 66 66 66 66 66 2e 	data16 data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    52b8:	0f 1f 84 00 00 00 00 
    52bf:	00 
    52c0:	41 0f 10 44 14 08    	movups 0x8(%r12,%rdx,1),%xmm0
    52c6:	41 0f 10 4c 14 18    	movups 0x18(%r12,%rdx,1),%xmm1
    52cc:	41 0f 11 44 15 08    	movups %xmm0,0x8(%r13,%rdx,1)
    52d2:	41 0f 11 4c 15 18    	movups %xmm1,0x18(%r13,%rdx,1)
    52d8:	48 83 c2 20          	add    $0x20,%rdx
    52dc:	48 39 d1             	cmp    %rdx,%rcx
    52df:	75 df                	jne    52c0 <fwp_apply_owned+0x800>
    52e1:	4c 39 f8             	cmp    %r15,%rax
    52e4:	74 6b                	je     5351 <fwp_apply_owned+0x891>
    52e6:	4c 89 fa             	mov    %r15,%rdx
    52e9:	48 89 c1             	mov    %rax,%rcx
    52ec:	48 83 e2 03          	and    $0x3,%rdx
    52f0:	74 20                	je     5312 <fwp_apply_owned+0x852>
    52f2:	48 89 c1             	mov    %rax,%rcx
    52f5:	66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
    52fc:	00 00 00 00 
    5300:	49 8b 74 cc 08       	mov    0x8(%r12,%rcx,8),%rsi
    5305:	49 89 74 cd 08       	mov    %rsi,0x8(%r13,%rcx,8)
    530a:	48 ff c1             	inc    %rcx
    530d:	48 ff ca             	dec    %rdx
    5310:	75 ee                	jne    5300 <fwp_apply_owned+0x840>
    5312:	4c 29 f8             	sub    %r15,%rax
    5315:	48 83 f8 fc          	cmp    $0xfffffffffffffffc,%rax
    5319:	77 36                	ja     5351 <fwp_apply_owned+0x891>
    531b:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)
    5320:	49 8b 44 cc 08       	mov    0x8(%r12,%rcx,8),%rax
    5325:	49 89 44 cd 08       	mov    %rax,0x8(%r13,%rcx,8)
    532a:	49 8b 44 cc 10       	mov    0x10(%r12,%rcx,8),%rax
    532f:	49 89 44 cd 10       	mov    %rax,0x10(%r13,%rcx,8)
    5334:	49 8b 44 cc 18       	mov    0x18(%r12,%rcx,8),%rax
    5339:	49 89 44 cd 18       	mov    %rax,0x18(%r13,%rcx,8)
    533e:	49 8b 44 cc 20       	mov    0x20(%r12,%rcx,8),%rax
    5343:	49 89 44 cd 20       	mov    %rax,0x20(%r13,%rcx,8)
    5348:	48 83 c1 04          	add    $0x4,%rcx
    534c:	49 39 cf             	cmp    %rcx,%r15
    534f:	75 cf                	jne    5320 <fwp_apply_owned+0x860>
    5351:	83 7d c0 00          	cmpl   $0x0,-0x40(%rbp)
    5355:	0f 84 8b 00 00 00    	je     53e6 <fwp_apply_owned+0x926>
    535b:	48 8b 4d c0          	mov    -0x40(%rbp),%rcx
    535f:	89 c8                	mov    %ecx,%eax
    5361:	83 f9 14             	cmp    $0x14,%ecx
    5364:	0f 83 f4 00 00 00    	jae    545e <fwp_apply_owned+0x99e>
    536a:	31 c9                	xor    %ecx,%ecx
    536c:	48 89 c6             	mov    %rax,%rsi
    536f:	48 89 ca             	mov    %rcx,%rdx
    5372:	48 83 e6 03          	and    $0x3,%rsi
    5376:	74 1d                	je     5395 <fwp_apply_owned+0x8d5>
    5378:	48 89 ca             	mov    %rcx,%rdx
    537b:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)
    5380:	4c 8b 0c d3          	mov    (%rbx,%rdx,8),%r9
    5384:	45 8d 04 17          	lea    (%r15,%rdx,1),%r8d
    5388:	4f 89 4c c5 08       	mov    %r9,0x8(%r13,%r8,8)
    538d:	48 ff c2             	inc    %rdx
    5390:	48 ff ce             	dec    %rsi
    5393:	75 eb                	jne    5380 <fwp_apply_owned+0x8c0>
    5395:	48 29 c1             	sub    %rax,%rcx
    5398:	48 83 f9 fc          	cmp    $0xfffffffffffffffc,%rcx
    539c:	77 48                	ja     53e6 <fwp_apply_owned+0x926>
    539e:	66 90                	xchg   %ax,%ax
    53a0:	48 8b 0c d3          	mov    (%rbx,%rdx,8),%rcx
    53a4:	41 8d 34 17          	lea    (%r15,%rdx,1),%esi
    53a8:	49 89 4c f5 08       	mov    %rcx,0x8(%r13,%rsi,8)
    53ad:	48 8b 4c d3 08       	mov    0x8(%rbx,%rdx,8),%rcx
    53b2:	41 8d 34 17          	lea    (%r15,%rdx,1),%esi
    53b6:	ff c6                	inc    %esi
    53b8:	49 89 4c f5 08       	mov    %rcx,0x8(%r13,%rsi,8)
    53bd:	48 8b 4c d3 10       	mov    0x10(%rbx,%rdx,8),%rcx
    53c2:	41 8d 74 17 02       	lea    0x2(%r15,%rdx,1),%esi
    53c7:	49 89 4c f5 08       	mov    %rcx,0x8(%r13,%rsi,8)
    53cc:	48 8b 4c d3 18       	mov    0x18(%rbx,%rdx,8),%rcx
    53d1:	41 8d 34 17          	lea    (%r15,%rdx,1),%esi
    53d5:	83 c6 03             	add    $0x3,%esi
    53d8:	49 89 4c f5 08       	mov    %rcx,0x8(%r13,%rsi,8)
    53dd:	48 83 c2 04          	add    $0x4,%rdx
    53e1:	48 39 d0             	cmp    %rdx,%rax
    53e4:	75 ba                	jne    53a0 <fwp_apply_owned+0x8e0>
    53e6:	49 8b 02             	mov    (%r10),%rax
    53e9:	be 01 00 00 00       	mov    $0x1,%esi
    53ee:	ff 50 08             	call   *0x8(%rax)
    53f1:	4c 89 e8             	mov    %r13,%rax
    53f4:	48 2b 05 dd ad 00 00 	sub    0xaddd(%rip),%rax        # 101d8 <fwp_gc+0x1030>
    53fb:	48 8b 0d fe ad 00 00 	mov    0xadfe(%rip),%rcx        # 10200 <fwp_gc+0x1058>
    5402:	48 c1 e1 10          	shl    $0x10,%rcx
    5406:	48 39 c8             	cmp    %rcx,%rax
    5409:	0f 83 fa 00 00 00    	jae    5509 <fwp_apply_owned+0xa49>
    540f:	48 8b 0d 0a ae 00 00 	mov    0xae0a(%rip),%rcx        # 10220 <fwp_gc+0x1078>
    5416:	48 89 c2             	mov    %rax,%rdx
    5419:	48 c1 ea 10          	shr    $0x10,%rdx
    541d:	48 69 d2 28 12 00 00 	imul   $0x1228,%rdx,%rdx
    5424:	0f b6 34 11          	movzbl (%rcx,%rdx,1),%esi
    5428:	48 25 ff ff 00 00    	and    $0xffff,%rax
    542e:	0f 85 9c 00 00 00    	jne    54d0 <fwp_apply_owned+0xa10>
    5434:	40 80 fe 02          	cmp    $0x2,%sil
    5438:	0f 85 92 00 00 00    	jne    54d0 <fwp_apply_owned+0xa10>
    543e:	4c 8d 24 11          	lea    (%rcx,%rdx,1),%r12
    5442:	49 81 c4 28 02 00 00 	add    $0x228,%r12
    5449:	41 80 3c 24 ff       	cmpb   $0xff,(%r12)
    544e:	0f 84 a8 00 00 00    	je     54fc <fwp_apply_owned+0xa3c>
    5454:	41 c6 04 24 01       	movb   $0x1,(%r12)
    5459:	e9 ab 00 00 00       	jmp    5509 <fwp_apply_owned+0xa49>
    545e:	48 8d 50 ff          	lea    -0x1(%rax),%rdx
    5462:	31 c9                	xor    %ecx,%ecx
    5464:	89 d6                	mov    %edx,%esi
    5466:	44 01 fe             	add    %r15d,%esi
    5469:	0f 82 fd fe ff ff    	jb     536c <fwp_apply_owned+0x8ac>
    546f:	48 c1 ea 20          	shr    $0x20,%rdx
    5473:	0f 85 f3 fe ff ff    	jne    536c <fwp_apply_owned+0x8ac>
    5479:	4a 8d 0c fd 00 00 00 	lea    0x0(,%r15,8),%rcx
    5480:	00 
    5481:	4c 01 e9             	add    %r13,%rcx
    5484:	48 29 d9             	sub    %rbx,%rcx
    5487:	48 83 c1 08          	add    $0x8,%rcx
    548b:	48 83 f9 20          	cmp    $0x20,%rcx
    548f:	0f 82 d5 fe ff ff    	jb     536a <fwp_apply_owned+0x8aa>
    5495:	89 c1                	mov    %eax,%ecx
    5497:	83 e1 fc             	and    $0xfffffffc,%ecx
    549a:	31 d2                	xor    %edx,%edx
    549c:	0f 1f 40 00          	nopl   0x0(%rax)
    54a0:	0f 10 04 d3          	movups (%rbx,%rdx,8),%xmm0
    54a4:	0f 10 4c d3 10       	movups 0x10(%rbx,%rdx,8),%xmm1
    54a9:	41 8d 34 17          	lea    (%r15,%rdx,1),%esi
    54ad:	41 0f 11 44 f5 08    	movups %xmm0,0x8(%r13,%rsi,8)
    54b3:	41 0f 11 4c f5 18    	movups %xmm1,0x18(%r13,%rsi,8)
    54b9:	48 83 c2 04          	add    $0x4,%rdx
    54bd:	48 39 d1             	cmp    %rdx,%rcx
    54c0:	75 de                	jne    54a0 <fwp_apply_owned+0x9e0>
    54c2:	48 39 c1             	cmp    %rax,%rcx
    54c5:	0f 85 a1 fe ff ff    	jne    536c <fwp_apply_owned+0x8ac>
    54cb:	e9 16 ff ff ff       	jmp    53e6 <fwp_apply_owned+0x926>
    54d0:	40 80 fe 01          	cmp    $0x1,%sil
    54d4:	75 33                	jne    5509 <fwp_apply_owned+0xa49>
    54d6:	48 8d 34 11          	lea    (%rcx,%rdx,1),%rsi
    54da:	8b 4c 11 20          	mov    0x20(%rcx,%rdx,1),%ecx
    54de:	48 0f af c1          	imul   %rcx,%rax
    54e2:	48 c1 e8 20          	shr    $0x20,%rax
    54e6:	4c 8d 24 30          	lea    (%rax,%rsi,1),%r12
    54ea:	49 81 c4 28 02 00 00 	add    $0x228,%r12
    54f1:	41 80 3c 24 ff       	cmpb   $0xff,(%r12)
    54f6:	0f 85 58 ff ff ff    	jne    5454 <fwp_apply_owned+0x994>
    54fc:	4c 89 e7             	mov    %r12,%rdi
    54ff:	e8 dc e3 ff ff       	call   38e0 <fwp_rc_forget_slot>
    5504:	e9 4b ff ff ff       	jmp    5454 <fwp_apply_owned+0x994>
    5509:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
    550d:	89 45 80             	mov    %eax,-0x80(%rbp)
    5510:	48 c7 45 b0 00 00 00 	movq   $0x0,-0x50(%rbp)
    5517:	00 
    5518:	4c 39 35 59 b7 00 00 	cmp    %r14,0xb759(%rip)        # 10c78 <fwp_cleanups>
    551f:	75 46                	jne    5567 <fwp_apply_owned+0xaa7>
    5521:	48 8b 85 50 ff ff ff 	mov    -0xb0(%rbp),%rax
    5528:	48 89 05 49 b7 00 00 	mov    %rax,0xb749(%rip)        # 10c78 <fwp_cleanups>
    552f:	80 7d bc 00          	cmpb   $0x0,-0x44(%rbp)
    5533:	48 8b 7d c8          	mov    -0x38(%rbp),%rdi
    5537:	74 14                	je     554d <fwp_apply_owned+0xa8d>
    5539:	48 8d 4d 98          	lea    -0x68(%rbp),%rcx
    553d:	48 39 c8             	cmp    %rcx,%rax
    5540:	75 25                	jne    5567 <fwp_apply_owned+0xaa7>
    5542:	48 8b 45 98          	mov    -0x68(%rbp),%rax
    5546:	48 89 05 2b b7 00 00 	mov    %rax,0xb72b(%rip)        # 10c78 <fwp_cleanups>
    554d:	e8 9e 0b 00 00       	call   60f0 <fwp_closure_drop>
    5552:	4d 89 ec             	mov    %r13,%r12
    5555:	4c 89 e0             	mov    %r12,%rax
    5558:	48 8d 65 d8          	lea    -0x28(%rbp),%rsp
    555c:	5b                   	pop    %rbx
    555d:	41 5c                	pop    %r12
    555f:	41 5d                	pop    %r13
    5561:	41 5e                	pop    %r14
    5563:	41 5f                	pop    %r15
    5565:	5d                   	pop    %rbp
    5566:	c3                   	ret
    5567:	e8 f4 ca ff ff       	call   2060 <abort@plt>
    556c:	0f 1f 40 00          	nopl   0x0(%rax)

0000000000005570 <fwp_gc_alloc_slow>:
    5570:	41 57                	push   %r15
    5572:	41 56                	push   %r14
    5574:	41 55                	push   %r13
    5576:	41 54                	push   %r12
    5578:	53                   	push   %rbx
    5579:	89 f3                	mov    %esi,%ebx
    557b:	83 3d 12 ac 00 00 00 	cmpl   $0x0,0xac12(%rip)        # 10194 <fwp_gc+0xfec>
    5582:	74 19                	je     559d <fwp_gc_alloc_slow+0x2d>
    5584:	48 81 ff 01 40 00 00 	cmp    $0x4001,%rdi
    558b:	72 24                	jb     55b1 <fwp_gc_alloc_slow+0x41>
    558d:	89 de                	mov    %ebx,%esi
    558f:	5b                   	pop    %rbx
    5590:	41 5c                	pop    %r12
    5592:	41 5d                	pop    %r13
    5594:	41 5e                	pop    %r14
    5596:	41 5f                	pop    %r15
    5598:	e9 33 06 00 00       	jmp    5bd0 <fwp_gc_alloc_big>
    559d:	49 89 fe             	mov    %rdi,%r14
    55a0:	e8 5b 01 00 00       	call   5700 <fwp_gc_init>
    55a5:	4c 89 f7             	mov    %r14,%rdi
    55a8:	48 81 ff 01 40 00 00 	cmp    $0x4001,%rdi
    55af:	73 dc                	jae    558d <fwp_gc_alloc_slow+0x1d>
    55b1:	48 8d 47 0f          	lea    0xf(%rdi),%rax
    55b5:	48 c1 e8 04          	shr    $0x4,%rax
    55b9:	4c 8d 3d e8 9b 00 00 	lea    0x9be8(%rip),%r15        # f1a8 <fwp_gc>
    55c0:	46 0f b6 b4 38 e8 0b 	movzbl 0xbe8(%rax,%r15,1),%r14d
    55c7:	00 00 
    55c9:	43 8b 94 b7 48 0b 00 	mov    0xb48(%r15,%r14,4),%edx
    55d0:	00 
    55d1:	48 83 3d cf 9b 00 00 	cmpq   $0x0,0x9bcf(%rip)        # f1a8 <fwp_gc>
    55d8:	00 
    55d9:	0f 89 8c 00 00 00    	jns    566b <fwp_gc_alloc_slow+0xfb>
    55df:	83 3d ae ab 00 00 00 	cmpl   $0x0,0xabae(%rip)        # 10194 <fwp_gc+0xfec>
    55e6:	75 11                	jne    55f9 <fwp_gc_alloc_slow+0x89>
    55e8:	49 89 fc             	mov    %rdi,%r12
    55eb:	49 89 d5             	mov    %rdx,%r13
    55ee:	e8 0d 01 00 00       	call   5700 <fwp_gc_init>
    55f3:	4c 89 ea             	mov    %r13,%rdx
    55f6:	4c 89 e7             	mov    %r12,%rdi
    55f9:	8b 0d 9d ab 00 00    	mov    0xab9d(%rip),%ecx        # 1019c <fwp_gc+0xff4>
    55ff:	85 c9                	test   %ecx,%ecx
    5601:	74 2a                	je     562d <fwp_gc_alloc_slow+0xbd>
    5603:	48 8b 05 be ab 00 00 	mov    0xabbe(%rip),%rax        # 101c8 <fwp_gc+0x1020>
    560a:	48 85 c0             	test   %rax,%rax
    560d:	74 1e                	je     562d <fwp_gc_alloc_slow+0xbd>
    560f:	48 8b 0d ba ab 00 00 	mov    0xabba(%rip),%rcx        # 101d0 <fwp_gc+0x1028>
    5616:	48 ff c1             	inc    %rcx
    5619:	48 89 0d b0 ab 00 00 	mov    %rcx,0xabb0(%rip)        # 101d0 <fwp_gc+0x1028>
    5620:	48 39 c1             	cmp    %rax,%rcx
    5623:	0f 8d c7 00 00 00    	jge    56f0 <fwp_gc_alloc_slow+0x180>
    5629:	31 c0                	xor    %eax,%eax
    562b:	eb 0d                	jmp    563a <fwp_gc_alloc_slow+0xca>
    562d:	b8 00 00 80 00       	mov    $0x800000,%eax
    5632:	85 c9                	test   %ecx,%ecx
    5634:	0f 85 b1 00 00 00    	jne    56eb <fwp_gc_alloc_slow+0x17b>
    563a:	48 8b 0d 77 ad 00 00 	mov    0xad77(%rip),%rcx        # 103b8 <fwp_gc+0x1210>
    5641:	48 2b 0d 60 9b 00 00 	sub    0x9b60(%rip),%rcx        # f1a8 <fwp_gc>
    5648:	f2 48 0f 2a c1       	cvtsi2sd %rcx,%xmm0
    564d:	f2 0f 58 05 3b ad 00 	addsd  0xad3b(%rip),%xmm0        # 10390 <fwp_gc+0x11e8>
    5654:	00 
    5655:	f2 0f 11 05 33 ad 00 	movsd  %xmm0,0xad33(%rip)        # 10390 <fwp_gc+0x11e8>
    565c:	00 
    565d:	48 89 05 54 ad 00 00 	mov    %rax,0xad54(%rip)        # 103b8 <fwp_gc+0x1210>
    5664:	48 89 05 3d 9b 00 00 	mov    %rax,0x9b3d(%rip)        # f1a8 <fwp_gc>
    566b:	89 d8                	mov    %ebx,%eax
    566d:	48 69 c0 c0 03 00 00 	imul   $0x3c0,%rax,%rax
    5674:	49 01 c7             	add    %rax,%r15
    5677:	4b 8d 34 76          	lea    (%r14,%r14,2),%rsi
    567b:	49 8d 0c f7          	lea    (%r15,%rsi,8),%rcx
    567f:	48 83 c1 08          	add    $0x8,%rcx
    5683:	49 8b 44 f7 08       	mov    0x8(%r15,%rsi,8),%rax
    5688:	48 85 c0             	test   %rax,%rax
    568b:	74 08                	je     5695 <fwp_gc_alloc_slow+0x125>
    568d:	48 8b 30             	mov    (%rax),%rsi
    5690:	48 f7 d6             	not    %rsi
    5693:	eb 39                	jmp    56ce <fwp_gc_alloc_slow+0x15e>
    5695:	49 8b 44 f7 10       	mov    0x10(%r15,%rsi,8),%rax
    569a:	4d 8b 44 f7 18       	mov    0x18(%r15,%rsi,8),%r8
    569f:	49 29 c0             	sub    %rax,%r8
    56a2:	49 39 d0             	cmp    %rdx,%r8
    56a5:	73 1b                	jae    56c2 <fwp_gc_alloc_slow+0x152>
    56a7:	49 89 ff             	mov    %rdi,%r15
    56aa:	48 89 cf             	mov    %rcx,%rdi
    56ad:	44 89 f6             	mov    %r14d,%esi
    56b0:	49 89 d6             	mov    %rdx,%r14
    56b3:	89 da                	mov    %ebx,%edx
    56b5:	e8 46 07 00 00       	call   5e00 <fwp_gc_refill>
    56ba:	4c 89 f2             	mov    %r14,%rdx
    56bd:	4c 89 ff             	mov    %r15,%rdi
    56c0:	eb 0f                	jmp    56d1 <fwp_gc_alloc_slow+0x161>
    56c2:	49 8d 0c f7          	lea    (%r15,%rsi,8),%rcx
    56c6:	48 83 c1 10          	add    $0x10,%rcx
    56ca:	48 8d 34 10          	lea    (%rax,%rdx,1),%rsi
    56ce:	48 89 31             	mov    %rsi,(%rcx)
    56d1:	83 fb 01             	cmp    $0x1,%ebx
    56d4:	48 0f 44 d7          	cmove  %rdi,%rdx
    56d8:	48 89 c7             	mov    %rax,%rdi
    56db:	31 f6                	xor    %esi,%esi
    56dd:	5b                   	pop    %rbx
    56de:	41 5c                	pop    %r12
    56e0:	41 5d                	pop    %r13
    56e2:	41 5e                	pop    %r14
    56e4:	41 5f                	pop    %r15
    56e6:	e9 75 ca ff ff       	jmp    2160 <memset@plt>
    56eb:	e8 d0 09 00 00       	call   60c0 <fwp_gc_collect>
    56f0:	48 c7 05 d5 aa 00 00 	movq   $0x0,0xaad5(%rip)        # 101d0 <fwp_gc+0x1028>
    56f7:	00 00 00 00 
    56fb:	e8 c0 09 00 00       	call   60c0 <fwp_gc_collect>

0000000000005700 <fwp_gc_init>:
    5700:	41 56                	push   %r14
    5702:	53                   	push   %rbx
    5703:	50                   	push   %rax
    5704:	c7 05 86 aa 00 00 01 	movl   $0x1,0xaa86(%rip)        # 10194 <fwp_gc+0xfec>
    570b:	00 00 00 
    570e:	0f 28 05 fb 68 00 00 	movaps 0x68fb(%rip),%xmm0        # c010 <_IO_stdin_used+0x10>
    5715:	0f 11 05 d4 a5 00 00 	movups %xmm0,0xa5d4(%rip)        # fcf0 <fwp_gc+0xb48>
    571c:	0f 28 05 fd 68 00 00 	movaps 0x68fd(%rip),%xmm0        # c020 <_IO_stdin_used+0x20>
    5723:	0f 11 05 d6 a5 00 00 	movups %xmm0,0xa5d6(%rip)        # fd00 <fwp_gc+0xb58>
    572a:	0f 28 05 ff 68 00 00 	movaps 0x68ff(%rip),%xmm0        # c030 <_IO_stdin_used+0x30>
    5731:	0f 11 05 d8 a5 00 00 	movups %xmm0,0xa5d8(%rip)        # fd10 <fwp_gc+0xb68>
    5738:	0f 28 05 01 69 00 00 	movaps 0x6901(%rip),%xmm0        # c040 <_IO_stdin_used+0x40>
    573f:	0f 11 05 da a5 00 00 	movups %xmm0,0xa5da(%rip)        # fd20 <fwp_gc+0xb78>
    5746:	0f 28 05 03 69 00 00 	movaps 0x6903(%rip),%xmm0        # c050 <_IO_stdin_used+0x50>
    574d:	0f 11 05 dc a5 00 00 	movups %xmm0,0xa5dc(%rip)        # fd30 <fwp_gc+0xb88>
    5754:	0f 28 05 05 69 00 00 	movaps 0x6905(%rip),%xmm0        # c060 <_IO_stdin_used+0x60>
    575b:	0f 11 05 de a5 00 00 	movups %xmm0,0xa5de(%rip)        # fd40 <fwp_gc+0xb98>
    5762:	0f 28 05 07 69 00 00 	movaps 0x6907(%rip),%xmm0        # c070 <_IO_stdin_used+0x70>
    5769:	0f 11 05 e0 a5 00 00 	movups %xmm0,0xa5e0(%rip)        # fd50 <fwp_gc+0xba8>
    5770:	0f 28 05 09 69 00 00 	movaps 0x6909(%rip),%xmm0        # c080 <_IO_stdin_used+0x80>
    5777:	0f 11 05 e2 a5 00 00 	movups %xmm0,0xa5e2(%rip)        # fd60 <fwp_gc+0xbb8>
    577e:	0f 28 05 0b 69 00 00 	movaps 0x690b(%rip),%xmm0        # c090 <_IO_stdin_used+0x90>
    5785:	0f 11 05 e4 a5 00 00 	movups %xmm0,0xa5e4(%rip)        # fd70 <fwp_gc+0xbc8>
    578c:	0f 28 05 0d 69 00 00 	movaps 0x690d(%rip),%xmm0        # c0a0 <_IO_stdin_used+0xa0>
    5793:	0f 11 05 e6 a5 00 00 	movups %xmm0,0xa5e6(%rip)        # fd80 <fwp_gc+0xbd8>
    579a:	31 c9                	xor    %ecx,%ecx
    579c:	48 8d 05 05 9a 00 00 	lea    0x9a05(%rip),%rax        # f1a8 <fwp_gc>
    57a3:	31 d2                	xor    %edx,%edx
    57a5:	66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
    57ac:	00 00 00 00 
    57b0:	89 d6                	mov    %edx,%esi
    57b2:	c1 e6 04             	shl    $0x4,%esi
    57b5:	48 ff c9             	dec    %rcx
    57b8:	48 89 cf             	mov    %rcx,%rdi
    57bb:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)
    57c0:	48 89 f9             	mov    %rdi,%rcx
    57c3:	48 ff c7             	inc    %rdi
    57c6:	3b b4 88 4c 0b 00 00 	cmp    0xb4c(%rax,%rcx,4),%esi
    57cd:	77 f1                	ja     57c0 <fwp_gc_init+0xc0>
    57cf:	40 88 bc 02 e8 0b 00 	mov    %dil,0xbe8(%rdx,%rax,1)
    57d6:	00 
    57d7:	48 89 d6             	mov    %rdx,%rsi
    57da:	48 83 ce 01          	or     $0x1,%rsi
    57de:	48 81 fe 01 04 00 00 	cmp    $0x401,%rsi
    57e5:	74 26                	je     580d <fwp_gc_init+0x10d>
    57e7:	89 f7                	mov    %esi,%edi
    57e9:	c1 e7 04             	shl    $0x4,%edi
    57ec:	0f 1f 40 00          	nopl   0x0(%rax)
    57f0:	49 89 c8             	mov    %rcx,%r8
    57f3:	48 ff c1             	inc    %rcx
    57f6:	42 3b bc 80 4c 0b 00 	cmp    0xb4c(%rax,%r8,4),%edi
    57fd:	00 
    57fe:	77 f0                	ja     57f0 <fwp_gc_init+0xf0>
    5800:	88 8c 06 e8 0b 00 00 	mov    %cl,0xbe8(%rsi,%rax,1)
    5807:	48 83 c2 02          	add    $0x2,%rdx
    580b:	eb a3                	jmp    57b0 <fwp_gc_init+0xb0>
    580d:	48 bb 00 00 00 00 10 	movabs $0x1000000000,%rbx
    5814:	00 00 00 
    5817:	48 8d b3 00 00 01 00 	lea    0x10000(%rbx),%rsi
    581e:	31 ff                	xor    %edi,%edi
    5820:	31 d2                	xor    %edx,%edx
    5822:	b9 22 40 00 00       	mov    $0x4022,%ecx
    5827:	41 b8 ff ff ff ff    	mov    $0xffffffff,%r8d
    582d:	45 31 c9             	xor    %r9d,%r9d
    5830:	e8 eb c8 ff ff       	call   2120 <mmap@plt>
    5835:	48 83 f8 ff          	cmp    $0xffffffffffffffff,%rax
    5839:	75 60                	jne    589b <fwp_gc_init+0x19b>
    583b:	48 bb 00 00 00 00 04 	movabs $0x400000000,%rbx
    5842:	00 00 00 
    5845:	48 8d b3 00 00 01 00 	lea    0x10000(%rbx),%rsi
    584c:	31 ff                	xor    %edi,%edi
    584e:	31 d2                	xor    %edx,%edx
    5850:	b9 22 40 00 00       	mov    $0x4022,%ecx
    5855:	41 b8 ff ff ff ff    	mov    $0xffffffff,%r8d
    585b:	45 31 c9             	xor    %r9d,%r9d
    585e:	e8 bd c8 ff ff       	call   2120 <mmap@plt>
    5863:	48 83 f8 ff          	cmp    $0xffffffffffffffff,%rax
    5867:	75 32                	jne    589b <fwp_gc_init+0x19b>
    5869:	48 bb 00 00 00 00 01 	movabs $0x100000000,%rbx
    5870:	00 00 00 
    5873:	48 8d b3 00 00 01 00 	lea    0x10000(%rbx),%rsi
    587a:	31 ff                	xor    %edi,%edi
    587c:	31 d2                	xor    %edx,%edx
    587e:	b9 22 40 00 00       	mov    $0x4022,%ecx
    5883:	41 b8 ff ff ff ff    	mov    $0xffffffff,%r8d
    5889:	45 31 c9             	xor    %r9d,%r9d
    588c:	e8 8f c8 ff ff       	call   2120 <mmap@plt>
    5891:	48 83 f8 ff          	cmp    $0xffffffffffffffff,%rax
    5895:	0f 84 4e 02 00 00    	je     5ae9 <fwp_gc_init+0x3e9>
    589b:	48 85 c0             	test   %rax,%rax
    589e:	0f 84 a6 02 00 00    	je     5b4a <fwp_gc_init+0x44a>
    58a4:	48 89 05 35 a9 00 00 	mov    %rax,0xa935(%rip)        # 101e0 <fwp_gc+0x1038>
    58ab:	48 89 d9             	mov    %rbx,%rcx
    58ae:	48 81 c9 00 00 01 00 	or     $0x10000,%rcx
    58b5:	48 89 0d 2c a9 00 00 	mov    %rcx,0xa92c(%rip)        # 101e8 <fwp_gc+0x1040>
    58bc:	48 05 ff ff 00 00    	add    $0xffff,%rax
    58c2:	48 25 00 00 ff ff    	and    $0xffffffffffff0000,%rax
    58c8:	48 89 05 09 a9 00 00 	mov    %rax,0xa909(%rip)        # 101d8 <fwp_gc+0x1030>
    58cf:	48 c1 eb 10          	shr    $0x10,%rbx
    58d3:	48 89 1d 1e a9 00 00 	mov    %rbx,0xa91e(%rip)        # 101f8 <fwp_gc+0x1050>
    58da:	48 69 f3 28 12 00 00 	imul   $0x1228,%rbx,%rsi
    58e1:	48 89 35 40 a9 00 00 	mov    %rsi,0xa940(%rip)        # 10228 <fwp_gc+0x1080>
    58e8:	31 ff                	xor    %edi,%edi
    58ea:	31 d2                	xor    %edx,%edx
    58ec:	b9 22 40 00 00       	mov    $0x4022,%ecx
    58f1:	41 b8 ff ff ff ff    	mov    $0xffffffff,%r8d
    58f7:	45 31 c9             	xor    %r9d,%r9d
    58fa:	e8 21 c8 ff ff       	call   2120 <mmap@plt>
    58ff:	48 83 f8 ff          	cmp    $0xffffffffffffffff,%rax
    5903:	0f 84 41 02 00 00    	je     5b4a <fwp_gc_init+0x44a>
    5909:	48 89 05 10 a9 00 00 	mov    %rax,0xa910(%rip)        # 10220 <fwp_gc+0x1078>
    5910:	48 8d 3d 53 6a 00 00 	lea    0x6a53(%rip),%rdi        # c36a <fwp_segv.msg+0x12a>
    5917:	e8 14 c7 ff ff       	call   2030 <getenv@plt>
    591c:	48 85 c0             	test   %rax,%rax
    591f:	74 2e                	je     594f <fwp_gc_init+0x24f>
    5921:	48 89 c3             	mov    %rax,%rbx
    5924:	48 8d 35 46 6a 00 00 	lea    0x6a46(%rip),%rsi        # c371 <fwp_segv.msg+0x131>
    592b:	48 89 c7             	mov    %rax,%rdi
    592e:	e8 8d c8 ff ff       	call   21c0 <strcmp@plt>
    5933:	85 c0                	test   %eax,%eax
    5935:	74 1f                	je     5956 <fwp_gc_init+0x256>
    5937:	48 8d 35 71 6c 00 00 	lea    0x6c71(%rip),%rsi        # c5af <fwp_segv.msg+0x36f>
    593e:	48 89 df             	mov    %rbx,%rdi
    5941:	e8 7a c8 ff ff       	call   21c0 <strcmp@plt>
    5946:	31 c9                	xor    %ecx,%ecx
    5948:	85 c0                	test   %eax,%eax
    594a:	0f 95 c1             	setne  %cl
    594d:	eb 09                	jmp    5958 <fwp_gc_init+0x258>
    594f:	b9 01 00 00 00       	mov    $0x1,%ecx
    5954:	eb 02                	jmp    5958 <fwp_gc_init+0x258>
    5956:	31 c9                	xor    %ecx,%ecx
    5958:	89 0d 3a a8 00 00    	mov    %ecx,0xa83a(%rip)        # 10198 <fwp_gc+0xff0>
    595e:	48 8d 3d 10 6a 00 00 	lea    0x6a10(%rip),%rdi        # c375 <fwp_segv.msg+0x135>
    5965:	e8 c6 c6 ff ff       	call   2030 <getenv@plt>
    596a:	31 c9                	xor    %ecx,%ecx
    596c:	48 85 c0             	test   %rax,%rax
    596f:	74 1b                	je     598c <fwp_gc_init+0x28c>
    5971:	80 38 00             	cmpb   $0x0,(%rax)
    5974:	74 16                	je     598c <fwp_gc_init+0x28c>
    5976:	48 8d 35 32 6c 00 00 	lea    0x6c32(%rip),%rsi        # c5af <fwp_segv.msg+0x36f>
    597d:	48 89 c7             	mov    %rax,%rdi
    5980:	e8 3b c8 ff ff       	call   21c0 <strcmp@plt>
    5985:	31 c9                	xor    %ecx,%ecx
    5987:	85 c0                	test   %eax,%eax
    5989:	0f 95 c1             	setne  %cl
    598c:	89 0d 12 a8 00 00    	mov    %ecx,0xa812(%rip)        # 101a4 <fwp_gc+0xffc>
    5992:	48 8d 3d d1 69 00 00 	lea    0x69d1(%rip),%rdi        # c36a <fwp_segv.msg+0x12a>
    5999:	e8 92 c6 ff ff       	call   2030 <getenv@plt>
    599e:	48 85 c0             	test   %rax,%rax
    59a1:	74 18                	je     59bb <fwp_gc_init+0x2bb>
    59a3:	48 8d 35 d8 69 00 00 	lea    0x69d8(%rip),%rsi        # c382 <fwp_segv.msg+0x142>
    59aa:	48 89 c7             	mov    %rax,%rdi
    59ad:	e8 0e c8 ff ff       	call   21c0 <strcmp@plt>
    59b2:	31 c9                	xor    %ecx,%ecx
    59b4:	85 c0                	test   %eax,%eax
    59b6:	0f 95 c1             	setne  %cl
    59b9:	eb 05                	jmp    59c0 <fwp_gc_init+0x2c0>
    59bb:	b9 01 00 00 00       	mov    $0x1,%ecx
    59c0:	89 0d e2 a7 00 00    	mov    %ecx,0xa7e2(%rip)        # 101a8 <fwp_gc+0x1000>
    59c6:	c7 05 e0 a7 00 00 01 	movl   $0x1,0xa7e0(%rip)        # 101b0 <fwp_gc+0x1008>
    59cd:	00 00 00 
    59d0:	48 8d 3d b0 69 00 00 	lea    0x69b0(%rip),%rdi        # c387 <fwp_segv.msg+0x147>
    59d7:	e8 54 c6 ff ff       	call   2030 <getenv@plt>
    59dc:	31 c9                	xor    %ecx,%ecx
    59de:	48 85 c0             	test   %rax,%rax
    59e1:	74 1b                	je     59fe <fwp_gc_init+0x2fe>
    59e3:	80 38 00             	cmpb   $0x0,(%rax)
    59e6:	74 16                	je     59fe <fwp_gc_init+0x2fe>
    59e8:	48 8d 35 c0 6b 00 00 	lea    0x6bc0(%rip),%rsi        # c5af <fwp_segv.msg+0x36f>
    59ef:	48 89 c7             	mov    %rax,%rdi
    59f2:	e8 c9 c7 ff ff       	call   21c0 <strcmp@plt>
    59f7:	31 c9                	xor    %ecx,%ecx
    59f9:	85 c0                	test   %eax,%eax
    59fb:	0f 95 c1             	setne  %cl
    59fe:	89 0d a8 a7 00 00    	mov    %ecx,0xa7a8(%rip)        # 101ac <fwp_gc+0x1004>
    5a04:	48 8d 3d 8a 69 00 00 	lea    0x698a(%rip),%rdi        # c395 <fwp_segv.msg+0x155>
    5a0b:	e8 20 c6 ff ff       	call   2030 <getenv@plt>
    5a10:	48 85 c0             	test   %rax,%rax
    5a13:	74 14                	je     5a29 <fwp_gc_init+0x329>
    5a15:	48 89 c7             	mov    %rax,%rdi
    5a18:	31 f6                	xor    %esi,%esi
    5a1a:	ba 0a 00 00 00       	mov    $0xa,%edx
    5a1f:	e8 dc c7 ff ff       	call   2200 <strtol@plt>
    5a24:	48 89 c3             	mov    %rax,%rbx
    5a27:	eb 02                	jmp    5a2b <fwp_gc_init+0x32b>
    5a29:	31 db                	xor    %ebx,%ebx
    5a2b:	31 c0                	xor    %eax,%eax
    5a2d:	48 85 db             	test   %rbx,%rbx
    5a30:	48 0f 4f c3          	cmovg  %rbx,%rax
    5a34:	48 89 05 8d a7 00 00 	mov    %rax,0xa78d(%rip)        # 101c8 <fwp_gc+0x1020>
    5a3b:	48 8d 3d 28 69 00 00 	lea    0x6928(%rip),%rdi        # c36a <fwp_segv.msg+0x12a>
    5a42:	e8 e9 c5 ff ff       	call   2030 <getenv@plt>
    5a47:	48 85 c0             	test   %rax,%rax
    5a4a:	74 32                	je     5a7e <fwp_gc_init+0x37e>
    5a4c:	49 89 c6             	mov    %rax,%r14
    5a4f:	80 38 00             	cmpb   $0x0,(%rax)
    5a52:	74 2a                	je     5a7e <fwp_gc_init+0x37e>
    5a54:	48 8d 35 16 69 00 00 	lea    0x6916(%rip),%rsi        # c371 <fwp_segv.msg+0x131>
    5a5b:	4c 89 f7             	mov    %r14,%rdi
    5a5e:	e8 5d c7 ff ff       	call   21c0 <strcmp@plt>
    5a63:	85 c0                	test   %eax,%eax
    5a65:	74 17                	je     5a7e <fwp_gc_init+0x37e>
    5a67:	48 8d 35 41 6b 00 00 	lea    0x6b41(%rip),%rsi        # c5af <fwp_segv.msg+0x36f>
    5a6e:	4c 89 f7             	mov    %r14,%rdi
    5a71:	e8 4a c7 ff ff       	call   21c0 <strcmp@plt>
    5a76:	85 c0                	test   %eax,%eax
    5a78:	0f 85 f6 00 00 00    	jne    5b74 <fwp_gc_init+0x474>
    5a7e:	48 85 db             	test   %rbx,%rbx
    5a81:	0f 8f ed 00 00 00    	jg     5b74 <fwp_gc_init+0x474>
    5a87:	83 3d 1e a7 00 00 00 	cmpl   $0x0,0xa71e(%rip)        # 101ac <fwp_gc+0x1004>
    5a8e:	0f 85 e0 00 00 00    	jne    5b74 <fwp_gc_init+0x474>
    5a94:	48 8d 3d 45 69 00 00 	lea    0x6945(%rip),%rdi        # c3e0 <fwp_segv.msg+0x1a0>
    5a9b:	e8 90 c5 ff ff       	call   2030 <getenv@plt>
    5aa0:	48 85 c0             	test   %rax,%rax
    5aa3:	74 1c                	je     5ac1 <fwp_gc_init+0x3c1>
    5aa5:	80 38 00             	cmpb   $0x0,(%rax)
    5aa8:	74 17                	je     5ac1 <fwp_gc_init+0x3c1>
    5aaa:	48 8d 35 fe 6a 00 00 	lea    0x6afe(%rip),%rsi        # c5af <fwp_segv.msg+0x36f>
    5ab1:	48 89 c7             	mov    %rax,%rdi
    5ab4:	e8 07 c7 ff ff       	call   21c0 <strcmp@plt>
    5ab9:	85 c0                	test   %eax,%eax
    5abb:	0f 85 e1 00 00 00    	jne    5ba2 <fwp_gc_init+0x4a2>
    5ac1:	c7 05 cd a6 00 00 00 	movl   $0x0,0xa6cd(%rip)        # 10198 <fwp_gc+0xff0>
    5ac8:	00 00 00 
    5acb:	48 c7 05 e2 a8 00 00 	movq   $0x800000,0xa8e2(%rip)        # 103b8 <fwp_gc+0x1210>
    5ad2:	00 00 80 00 
    5ad6:	48 c7 05 c7 96 00 00 	movq   $0x800000,0x96c7(%rip)        # f1a8 <fwp_gc>
    5add:	00 00 80 00 
    5ae1:	48 83 c4 08          	add    $0x8,%rsp
    5ae5:	5b                   	pop    %rbx
    5ae6:	41 5e                	pop    %r14
    5ae8:	c3                   	ret
    5ae9:	be 00 00 01 40       	mov    $0x40010000,%esi
    5aee:	31 ff                	xor    %edi,%edi
    5af0:	31 d2                	xor    %edx,%edx
    5af2:	b9 22 40 00 00       	mov    $0x4022,%ecx
    5af7:	41 b8 ff ff ff ff    	mov    $0xffffffff,%r8d
    5afd:	45 31 c9             	xor    %r9d,%r9d
    5b00:	e8 1b c6 ff ff       	call   2120 <mmap@plt>
    5b05:	48 83 f8 ff          	cmp    $0xffffffffffffffff,%rax
    5b09:	74 0f                	je     5b1a <fwp_gc_init+0x41a>
    5b0b:	48 85 c0             	test   %rax,%rax
    5b0e:	74 3a                	je     5b4a <fwp_gc_init+0x44a>
    5b10:	bb 00 00 00 40       	mov    $0x40000000,%ebx
    5b15:	e9 8a fd ff ff       	jmp    58a4 <fwp_gc_init+0x1a4>
    5b1a:	be 00 00 01 10       	mov    $0x10010000,%esi
    5b1f:	31 ff                	xor    %edi,%edi
    5b21:	31 d2                	xor    %edx,%edx
    5b23:	b9 22 40 00 00       	mov    $0x4022,%ecx
    5b28:	41 b8 ff ff ff ff    	mov    $0xffffffff,%r8d
    5b2e:	45 31 c9             	xor    %r9d,%r9d
    5b31:	e8 ea c5 ff ff       	call   2120 <mmap@plt>
    5b36:	48 8d 48 01          	lea    0x1(%rax),%rcx
    5b3a:	48 83 f9 02          	cmp    $0x2,%rcx
    5b3e:	72 0a                	jb     5b4a <fwp_gc_init+0x44a>
    5b40:	bb 00 00 00 10       	mov    $0x10000000,%ebx
    5b45:	e9 5a fd ff ff       	jmp    58a4 <fwp_gc_init+0x1a4>
    5b4a:	48 8b 05 8f 94 00 00 	mov    0x948f(%rip),%rax        # efe0 <stderr@GLIBC_2.2.5>
    5b51:	48 8b 08             	mov    (%rax),%rcx
    5b54:	48 8d 3d d5 68 00 00 	lea    0x68d5(%rip),%rdi        # c430 <fwp_segv.msg+0x1f0>
    5b5b:	be 13 00 00 00       	mov    $0x13,%esi
    5b60:	ba 01 00 00 00       	mov    $0x1,%edx
    5b65:	e8 76 c7 ff ff       	call   22e0 <fwrite@plt>
    5b6a:	bf 66 00 00 00       	mov    $0x66,%edi
    5b6f:	e8 5c c7 ff ff       	call   22d0 <exit@plt>
    5b74:	e8 37 dd ff ff       	call   38b0 <fwp_flush>
    5b79:	48 8b 05 60 94 00 00 	mov    0x9460(%rip),%rax        # efe0 <stderr@GLIBC_2.2.5>
    5b80:	48 8b 38             	mov    (%rax),%rdi
    5b83:	48 8d 35 aa 67 00 00 	lea    0x67aa(%rip),%rsi        # c334 <fwp_segv.msg+0xf4>
    5b8a:	48 8d 15 12 68 00 00 	lea    0x6812(%rip),%rdx        # c3a3 <fwp_segv.msg+0x163>
    5b91:	31 c0                	xor    %eax,%eax
    5b93:	e8 48 c6 ff ff       	call   21e0 <fprintf@plt>
    5b98:	bf 65 00 00 00       	mov    $0x65,%edi
    5b9d:	e8 2e c7 ff ff       	call   22d0 <exit@plt>
    5ba2:	e8 09 dd ff ff       	call   38b0 <fwp_flush>
    5ba7:	48 8b 05 32 94 00 00 	mov    0x9432(%rip),%rax        # efe0 <stderr@GLIBC_2.2.5>
    5bae:	48 8b 38             	mov    (%rax),%rdi
    5bb1:	48 8d 35 7c 67 00 00 	lea    0x677c(%rip),%rsi        # c334 <fwp_segv.msg+0xf4>
    5bb8:	48 8d 15 32 68 00 00 	lea    0x6832(%rip),%rdx        # c3f1 <fwp_segv.msg+0x1b1>
    5bbf:	eb d0                	jmp    5b91 <fwp_gc_init+0x491>
    5bc1:	66 66 66 66 66 66 2e 	data16 data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    5bc8:	0f 1f 84 00 00 00 00 
    5bcf:	00 

0000000000005bd0 <fwp_gc_alloc_big>:
    5bd0:	55                   	push   %rbp
    5bd1:	41 57                	push   %r15
    5bd3:	41 56                	push   %r14
    5bd5:	41 55                	push   %r13
    5bd7:	41 54                	push   %r12
    5bd9:	53                   	push   %rbx
    5bda:	50                   	push   %rax
    5bdb:	48 b8 01 00 00 00 00 	movabs $0x4000000000000001,%rax
    5be2:	00 00 40 
    5be5:	48 39 c7             	cmp    %rax,%rdi
    5be8:	0f 83 ce 01 00 00    	jae    5dbc <fwp_gc_alloc_big+0x1ec>
    5bee:	89 f5                	mov    %esi,%ebp
    5bf0:	48 89 fb             	mov    %rdi,%rbx
    5bf3:	48 29 3d ae 95 00 00 	sub    %rdi,0x95ae(%rip)        # f1a8 <fwp_gc>
    5bfa:	0f 89 80 00 00 00    	jns    5c80 <fwp_gc_alloc_big+0xb0>
    5c00:	83 3d 8d a5 00 00 00 	cmpl   $0x0,0xa58d(%rip)        # 10194 <fwp_gc+0xfec>
    5c07:	75 05                	jne    5c0e <fwp_gc_alloc_big+0x3e>
    5c09:	e8 f2 fa ff ff       	call   5700 <fwp_gc_init>
    5c0e:	8b 0d 88 a5 00 00    	mov    0xa588(%rip),%ecx        # 1019c <fwp_gc+0xff4>
    5c14:	85 c9                	test   %ecx,%ecx
    5c16:	74 2a                	je     5c42 <fwp_gc_alloc_big+0x72>
    5c18:	48 8b 05 a9 a5 00 00 	mov    0xa5a9(%rip),%rax        # 101c8 <fwp_gc+0x1020>
    5c1f:	48 85 c0             	test   %rax,%rax
    5c22:	74 1e                	je     5c42 <fwp_gc_alloc_big+0x72>
    5c24:	48 8b 0d a5 a5 00 00 	mov    0xa5a5(%rip),%rcx        # 101d0 <fwp_gc+0x1028>
    5c2b:	48 ff c1             	inc    %rcx
    5c2e:	48 89 0d 9b a5 00 00 	mov    %rcx,0xa59b(%rip)        # 101d0 <fwp_gc+0x1028>
    5c35:	48 39 c1             	cmp    %rax,%rcx
    5c38:	0f 8d ad 01 00 00    	jge    5deb <fwp_gc_alloc_big+0x21b>
    5c3e:	31 c0                	xor    %eax,%eax
    5c40:	eb 0d                	jmp    5c4f <fwp_gc_alloc_big+0x7f>
    5c42:	b8 00 00 80 00       	mov    $0x800000,%eax
    5c47:	85 c9                	test   %ecx,%ecx
    5c49:	0f 85 97 01 00 00    	jne    5de6 <fwp_gc_alloc_big+0x216>
    5c4f:	48 8b 0d 62 a7 00 00 	mov    0xa762(%rip),%rcx        # 103b8 <fwp_gc+0x1210>
    5c56:	48 2b 0d 4b 95 00 00 	sub    0x954b(%rip),%rcx        # f1a8 <fwp_gc>
    5c5d:	f2 48 0f 2a c1       	cvtsi2sd %rcx,%xmm0
    5c62:	f2 0f 58 05 26 a7 00 	addsd  0xa726(%rip),%xmm0        # 10390 <fwp_gc+0x11e8>
    5c69:	00 
    5c6a:	f2 0f 11 05 1e a7 00 	movsd  %xmm0,0xa71e(%rip)        # 10390 <fwp_gc+0x11e8>
    5c71:	00 
    5c72:	48 89 05 3f a7 00 00 	mov    %rax,0xa73f(%rip)        # 103b8 <fwp_gc+0x1210>
    5c79:	48 89 05 28 95 00 00 	mov    %rax,0x9528(%rip)        # f1a8 <fwp_gc>
    5c80:	4c 8d b3 ff ff 00 00 	lea    0xffff(%rbx),%r14
    5c87:	49 c1 ee 10          	shr    $0x10,%r14
    5c8b:	4c 89 f7             	mov    %r14,%rdi
    5c8e:	e8 9d 02 00 00       	call   5f30 <fwp_gc_chunks>
    5c93:	48 8b 0d 86 a5 00 00 	mov    0xa586(%rip),%rcx        # 10220 <fwp_gc+0x1078>
    5c9a:	4c 69 e0 28 12 00 00 	imul   $0x1228,%rax,%r12
    5ca1:	42 c6 04 21 02       	movb   $0x2,(%rcx,%r12,1)
    5ca6:	42 88 6c 21 01       	mov    %bpl,0x1(%rcx,%r12,1)
    5cab:	66 42 c7 44 21 03 00 	movw   $0x100,0x3(%rcx,%r12,1)
    5cb2:	01 
    5cb3:	46 89 74 21 10       	mov    %r14d,0x10(%rcx,%r12,1)
    5cb8:	4a 89 5c 21 18       	mov    %rbx,0x18(%rcx,%r12,1)
    5cbd:	4e 8d 3c 21          	lea    (%rcx,%r12,1),%r15
    5cc1:	49 81 c7 28 02 00 00 	add    $0x228,%r15
    5cc8:	42 80 bc 21 28 02 00 	cmpb   $0xff,0x228(%rcx,%r12,1)
    5ccf:	00 ff 
    5cd1:	0f 84 d2 00 00 00    	je     5da9 <fwp_gc_alloc_big+0x1d9>
    5cd7:	41 c6 07 00          	movb   $0x0,(%r15)
    5cdb:	48 81 fb 01 00 01 00 	cmp    $0x10001,%rbx
    5ce2:	0f 82 9b 00 00 00    	jb     5d83 <fwp_gc_alloc_big+0x1b3>
    5ce8:	49 83 fe 03          	cmp    $0x3,%r14
    5cec:	ba 02 00 00 00       	mov    $0x2,%edx
    5cf1:	49 0f 43 d6          	cmovae %r14,%rdx
    5cf5:	48 8b 0d 24 a5 00 00 	mov    0xa524(%rip),%rcx        # 10220 <fwp_gc+0x1078>
    5cfc:	48 ff ca             	dec    %rdx
    5cff:	be 01 00 00 00       	mov    $0x1,%esi
    5d04:	48 81 fb 01 00 02 00 	cmp    $0x20001,%rbx
    5d0b:	72 5a                	jb     5d67 <fwp_gc_alloc_big+0x197>
    5d0d:	49 8d 3c 0c          	lea    (%r12,%rcx,1),%rdi
    5d11:	48 81 c7 60 24 00 00 	add    $0x2460,%rdi
    5d18:	49 89 d0             	mov    %rdx,%r8
    5d1b:	49 83 e0 fe          	and    $0xfffffffffffffffe,%r8
    5d1f:	49 f7 d8             	neg    %r8
    5d22:	66 66 66 66 66 2e 0f 	data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    5d29:	1f 84 00 00 00 00 00 
    5d30:	c6 87 c8 ed ff ff 03 	movb   $0x3,-0x1238(%rdi)
    5d37:	c6 87 cc ed ff ff 01 	movb   $0x1,-0x1234(%rdi)
    5d3e:	89 87 d8 ed ff ff    	mov    %eax,-0x1228(%rdi)
    5d44:	c6 47 f0 03          	movb   $0x3,-0x10(%rdi)
    5d48:	c6 47 f4 01          	movb   $0x1,-0xc(%rdi)
    5d4c:	89 07                	mov    %eax,(%rdi)
    5d4e:	48 81 c7 50 24 00 00 	add    $0x2450,%rdi
    5d55:	4d 8d 0c 30          	lea    (%r8,%rsi,1),%r9
    5d59:	49 83 c1 02          	add    $0x2,%r9
    5d5d:	48 83 c6 02          	add    $0x2,%rsi
    5d61:	49 83 f9 01          	cmp    $0x1,%r9
    5d65:	75 c9                	jne    5d30 <fwp_gc_alloc_big+0x160>
    5d67:	f6 c2 01             	test   $0x1,%dl
    5d6a:	74 17                	je     5d83 <fwp_gc_alloc_big+0x1b3>
    5d6c:	4c 01 e1             	add    %r12,%rcx
    5d6f:	48 69 d6 28 12 00 00 	imul   $0x1228,%rsi,%rdx
    5d76:	c6 04 11 03          	movb   $0x3,(%rcx,%rdx,1)
    5d7a:	c6 44 11 04 01       	movb   $0x1,0x4(%rcx,%rdx,1)
    5d7f:	89 44 11 10          	mov    %eax,0x10(%rcx,%rdx,1)
    5d83:	48 c1 e0 10          	shl    $0x10,%rax
    5d87:	48 03 05 4a a4 00 00 	add    0xa44a(%rip),%rax        # 101d8 <fwp_gc+0x1030>
    5d8e:	48 89 c7             	mov    %rax,%rdi
    5d91:	31 f6                	xor    %esi,%esi
    5d93:	48 89 da             	mov    %rbx,%rdx
    5d96:	48 83 c4 08          	add    $0x8,%rsp
    5d9a:	5b                   	pop    %rbx
    5d9b:	41 5c                	pop    %r12
    5d9d:	41 5d                	pop    %r13
    5d9f:	41 5e                	pop    %r14
    5da1:	41 5f                	pop    %r15
    5da3:	5d                   	pop    %rbp
    5da4:	e9 b7 c3 ff ff       	jmp    2160 <memset@plt>
    5da9:	4c 89 ff             	mov    %r15,%rdi
    5dac:	49 89 c5             	mov    %rax,%r13
    5daf:	e8 2c db ff ff       	call   38e0 <fwp_rc_forget_slot>
    5db4:	4c 89 e8             	mov    %r13,%rax
    5db7:	e9 1b ff ff ff       	jmp    5cd7 <fwp_gc_alloc_big+0x107>
    5dbc:	48 8b 05 1d 92 00 00 	mov    0x921d(%rip),%rax        # efe0 <stderr@GLIBC_2.2.5>
    5dc3:	48 8b 08             	mov    (%rax),%rcx
    5dc6:	48 8d 3d 63 66 00 00 	lea    0x6663(%rip),%rdi        # c430 <fwp_segv.msg+0x1f0>
    5dcd:	be 13 00 00 00       	mov    $0x13,%esi
    5dd2:	ba 01 00 00 00       	mov    $0x1,%edx
    5dd7:	e8 04 c5 ff ff       	call   22e0 <fwrite@plt>
    5ddc:	bf 66 00 00 00       	mov    $0x66,%edi
    5de1:	e8 ea c4 ff ff       	call   22d0 <exit@plt>
    5de6:	e8 d5 02 00 00       	call   60c0 <fwp_gc_collect>
    5deb:	48 c7 05 da a3 00 00 	movq   $0x0,0xa3da(%rip)        # 101d0 <fwp_gc+0x1028>
    5df2:	00 00 00 00 
    5df6:	e8 c5 02 00 00       	call   60c0 <fwp_gc_collect>
    5dfb:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)

0000000000005e00 <fwp_gc_refill>:
    5e00:	55                   	push   %rbp
    5e01:	41 57                	push   %r15
    5e03:	41 56                	push   %r14
    5e05:	41 55                	push   %r13
    5e07:	41 54                	push   %r12
    5e09:	53                   	push   %rbx
    5e0a:	50                   	push   %rax
    5e0b:	89 d5                	mov    %edx,%ebp
    5e0d:	41 89 f7             	mov    %esi,%r15d
    5e10:	48 89 fb             	mov    %rdi,%rbx
    5e13:	bf 01 00 00 00       	mov    $0x1,%edi
    5e18:	e8 13 01 00 00       	call   5f30 <fwp_gc_chunks>
    5e1d:	49 89 c6             	mov    %rax,%r14
    5e20:	4c 8b 25 f9 a3 00 00 	mov    0xa3f9(%rip),%r12        # 10220 <fwp_gc+0x1078>
    5e27:	48 8d 05 7a 93 00 00 	lea    0x937a(%rip),%rax        # f1a8 <fwp_gc>
    5e2e:	4d 69 ee 28 12 00 00 	imul   $0x1228,%r14,%r13
    5e35:	43 c6 04 2c 01       	movb   $0x1,(%r12,%r13,1)
    5e3a:	43 88 6c 2c 01       	mov    %bpl,0x1(%r12,%r13,1)
    5e3f:	47 88 7c 2c 02       	mov    %r15b,0x2(%r12,%r13,1)
    5e44:	43 c6 44 2c 04 01    	movb   $0x1,0x4(%r12,%r13,1)
    5e4a:	44 89 f9             	mov    %r15d,%ecx
    5e4d:	8b 8c 88 48 0b 00 00 	mov    0xb48(%rax,%rcx,4),%ecx
    5e54:	43 89 4c 2c 08       	mov    %ecx,0x8(%r12,%r13,1)
    5e59:	b8 00 00 01 00       	mov    $0x10000,%eax
    5e5e:	31 d2                	xor    %edx,%edx
    5e60:	f7 f1                	div    %ecx
    5e62:	43 89 44 2c 0c       	mov    %eax,0xc(%r12,%r13,1)
    5e67:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    5e6c:	48 01 c8             	add    %rcx,%rax
    5e6f:	48 0f ba e0 20       	bt     $0x20,%rax
    5e74:	73 07                	jae    5e7d <fwp_gc_refill+0x7d>
    5e76:	31 d2                	xor    %edx,%edx
    5e78:	48 f7 f1             	div    %rcx
    5e7b:	eb 04                	jmp    5e81 <fwp_gc_refill+0x81>
    5e7d:	31 d2                	xor    %edx,%edx
    5e7f:	f7 f1                	div    %ecx
    5e81:	43 89 44 2c 20       	mov    %eax,0x20(%r12,%r13,1)
    5e86:	48 83 3d 32 ad 00 00 	cmpq   $0x0,0xad32(%rip)        # 10bc0 <fwp_gc+0x1a18>
    5e8d:	00 
    5e8e:	74 2e                	je     5ebe <fwp_gc_refill+0xbe>
    5e90:	4f 8d 3c 2c          	lea    (%r12,%r13,1),%r15
    5e94:	49 81 c7 28 02 00 00 	add    $0x228,%r15
    5e9b:	31 ed                	xor    %ebp,%ebp
    5e9d:	eb 0d                	jmp    5eac <fwp_gc_refill+0xac>
    5e9f:	90                   	nop
    5ea0:	48 ff c5             	inc    %rbp
    5ea3:	48 81 fd 00 10 00 00 	cmp    $0x1000,%rbp
    5eaa:	74 12                	je     5ebe <fwp_gc_refill+0xbe>
    5eac:	41 80 3c 2f ff       	cmpb   $0xff,(%r15,%rbp,1)
    5eb1:	75 ed                	jne    5ea0 <fwp_gc_refill+0xa0>
    5eb3:	49 8d 3c 2f          	lea    (%r15,%rbp,1),%rdi
    5eb7:	e8 24 da ff ff       	call   38e0 <fwp_rc_forget_slot>
    5ebc:	eb e2                	jmp    5ea0 <fwp_gc_refill+0xa0>
    5ebe:	4f 8d 3c 2c          	lea    (%r12,%r13,1),%r15
    5ec2:	49 83 c7 08          	add    $0x8,%r15
    5ec6:	4b 8d 3c 2c          	lea    (%r12,%r13,1),%rdi
    5eca:	48 81 c7 28 02 00 00 	add    $0x228,%rdi
    5ed1:	ba 00 10 00 00       	mov    $0x1000,%edx
    5ed6:	31 f6                	xor    %esi,%esi
    5ed8:	e8 83 c2 ff ff       	call   2160 <memset@plt>
    5edd:	49 c1 e6 10          	shl    $0x10,%r14
    5ee1:	4c 03 35 f0 a2 00 00 	add    0xa2f0(%rip),%r14        # 101d8 <fwp_gc+0x1030>
    5ee8:	83 3d bd a2 00 00 00 	cmpl   $0x0,0xa2bd(%rip)        # 101ac <fwp_gc+0x1004>
    5eef:	74 0f                	je     5f00 <fwp_gc_refill+0x100>
    5ef1:	ba 00 00 01 00       	mov    $0x10000,%edx
    5ef6:	4c 89 f7             	mov    %r14,%rdi
    5ef9:	31 f6                	xor    %esi,%esi
    5efb:	e8 60 c2 ff ff       	call   2160 <memset@plt>
    5f00:	41 8b 07             	mov    (%r15),%eax
    5f03:	49 8d 0c 06          	lea    (%r14,%rax,1),%rcx
    5f07:	48 89 4b 08          	mov    %rcx,0x8(%rbx)
    5f0b:	41 8b 4f 04          	mov    0x4(%r15),%ecx
    5f0f:	48 0f af c8          	imul   %rax,%rcx
    5f13:	4c 01 f1             	add    %r14,%rcx
    5f16:	48 89 4b 10          	mov    %rcx,0x10(%rbx)
    5f1a:	4c 89 f0             	mov    %r14,%rax
    5f1d:	48 83 c4 08          	add    $0x8,%rsp
    5f21:	5b                   	pop    %rbx
    5f22:	41 5c                	pop    %r12
    5f24:	41 5d                	pop    %r13
    5f26:	41 5e                	pop    %r14
    5f28:	41 5f                	pop    %r15
    5f2a:	5d                   	pop    %rbp
    5f2b:	c3                   	ret
    5f2c:	0f 1f 40 00          	nopl   0x0(%rax)

0000000000005f30 <fwp_gc_chunks>:
    5f30:	41 57                	push   %r15
    5f32:	41 56                	push   %r14
    5f34:	53                   	push   %rbx
    5f35:	48 89 fb             	mov    %rdi,%rbx
    5f38:	31 d2                	xor    %edx,%edx
    5f3a:	48 83 ff 01          	cmp    $0x1,%rdi
    5f3e:	0f 95 c2             	setne  %dl
    5f41:	48 8d 0d 60 92 00 00 	lea    0x9260(%rip),%rcx        # f1a8 <fwp_gc>
    5f48:	48 8b 84 d1 68 10 00 	mov    0x1068(%rcx,%rdx,8),%rax
    5f4f:	00 
    5f50:	4c 8b 35 a9 a2 00 00 	mov    0xa2a9(%rip),%r14        # 10200 <fwp_gc+0x1058>
    5f57:	48 89 c7             	mov    %rax,%rdi
    5f5a:	4c 29 f7             	sub    %r14,%rdi
    5f5d:	73 63                	jae    5fc2 <fwp_gc_chunks+0x92>
    5f5f:	48 8d 34 d5 68 10 00 	lea    0x1068(,%rdx,8),%rsi
    5f66:	00 
    5f67:	4c 69 c0 28 12 00 00 	imul   $0x1228,%rax,%r8
    5f6e:	4c 03 05 ab a2 00 00 	add    0xa2ab(%rip),%r8        # 10220 <fwp_gc+0x1078>
    5f75:	31 d2                	xor    %edx,%edx
    5f77:	45 31 c9             	xor    %r9d,%r9d
    5f7a:	eb 16                	jmp    5f92 <fwp_gc_chunks+0x62>
    5f7c:	0f 1f 40 00          	nopl   0x0(%rax)
    5f80:	45 31 c9             	xor    %r9d,%r9d
    5f83:	48 ff ca             	dec    %rdx
    5f86:	49 81 c0 28 12 00 00 	add    $0x1228,%r8
    5f8d:	48 39 d7             	cmp    %rdx,%rdi
    5f90:	74 33                	je     5fc5 <fwp_gc_chunks+0x95>
    5f92:	41 80 38 00          	cmpb   $0x0,(%r8)
    5f96:	75 e8                	jne    5f80 <fwp_gc_chunks+0x50>
    5f98:	49 ff c1             	inc    %r9
    5f9b:	49 39 d9             	cmp    %rbx,%r9
    5f9e:	75 e3                	jne    5f83 <fwp_gc_chunks+0x53>
    5fa0:	48 ff c0             	inc    %rax
    5fa3:	48 89 c7             	mov    %rax,%rdi
    5fa6:	48 29 d7             	sub    %rdx,%rdi
    5fa9:	48 89 3c 0e          	mov    %rdi,(%rsi,%rcx,1)
    5fad:	48 29 1d d4 a3 00 00 	sub    %rbx,0xa3d4(%rip)        # 10388 <fwp_gc+0x11e0>
    5fb4:	48 29 d8             	sub    %rbx,%rax
    5fb7:	48 29 d0             	sub    %rdx,%rax
    5fba:	49 89 c6             	mov    %rax,%r14
    5fbd:	e9 ca 00 00 00       	jmp    608c <fwp_gc_chunks+0x15c>
    5fc2:	45 31 c9             	xor    %r9d,%r9d
    5fc5:	4c 29 0d bc a3 00 00 	sub    %r9,0xa3bc(%rip)        # 10388 <fwp_gc+0x11e0>
    5fcc:	4d 29 ce             	sub    %r9,%r14
    5fcf:	4c 01 f3             	add    %r14,%rbx
    5fd2:	48 8b 3d 2f a2 00 00 	mov    0xa22f(%rip),%rdi        # 10208 <fwp_gc+0x1060>
    5fd9:	48 39 df             	cmp    %rbx,%rdi
    5fdc:	0f 83 8f 00 00 00    	jae    6071 <fwp_gc_chunks+0x141>
    5fe2:	4c 8b 3d 0f a2 00 00 	mov    0xa20f(%rip),%r15        # 101f8 <fwp_gc+0x1050>
    5fe9:	49 39 df             	cmp    %rbx,%r15
    5fec:	0f 82 a3 00 00 00    	jb     6095 <fwp_gc_chunks+0x165>
    5ff2:	48 8d 43 40          	lea    0x40(%rbx),%rax
    5ff6:	4c 39 f8             	cmp    %r15,%rax
    5ff9:	4c 0f 42 f8          	cmovb  %rax,%r15
    5ffd:	4c 89 fe             	mov    %r15,%rsi
    6000:	48 29 fe             	sub    %rdi,%rsi
    6003:	48 c1 e7 10          	shl    $0x10,%rdi
    6007:	48 03 3d ca a1 00 00 	add    0xa1ca(%rip),%rdi        # 101d8 <fwp_gc+0x1030>
    600e:	48 c1 e6 10          	shl    $0x10,%rsi
    6012:	ba 03 00 00 00       	mov    $0x3,%edx
    6017:	e8 64 c2 ff ff       	call   2280 <mprotect@plt>
    601c:	85 c0                	test   %eax,%eax
    601e:	75 75                	jne    6095 <fwp_gc_chunks+0x165>
    6020:	bf 1e 00 00 00       	mov    $0x1e,%edi
    6025:	e8 76 c2 ff ff       	call   22a0 <sysconf@plt>
    602a:	48 8b 0d ef a1 00 00 	mov    0xa1ef(%rip),%rcx        # 10220 <fwp_gc+0x1078>
    6031:	48 69 3d cc a1 00 00 	imul   $0x1228,0xa1cc(%rip),%rdi        # 10208 <fwp_gc+0x1060>
    6038:	28 12 00 00 
    603c:	48 01 cf             	add    %rcx,%rdi
    603f:	49 69 d7 28 12 00 00 	imul   $0x1228,%r15,%rdx
    6046:	48 01 ca             	add    %rcx,%rdx
    6049:	48 8d 34 10          	lea    (%rax,%rdx,1),%rsi
    604d:	48 ff ce             	dec    %rsi
    6050:	48 f7 d8             	neg    %rax
    6053:	48 21 c7             	and    %rax,%rdi
    6056:	48 21 c6             	and    %rax,%rsi
    6059:	48 29 fe             	sub    %rdi,%rsi
    605c:	ba 03 00 00 00       	mov    $0x3,%edx
    6061:	e8 1a c2 ff ff       	call   2280 <mprotect@plt>
    6066:	85 c0                	test   %eax,%eax
    6068:	75 2b                	jne    6095 <fwp_gc_chunks+0x165>
    606a:	4c 89 3d 97 a1 00 00 	mov    %r15,0xa197(%rip)        # 10208 <fwp_gc+0x1060>
    6071:	48 89 1d 88 a1 00 00 	mov    %rbx,0xa188(%rip)        # 10200 <fwp_gc+0x1058>
    6078:	48 c1 e3 10          	shl    $0x10,%rbx
    607c:	48 3b 1d 6d a1 00 00 	cmp    0xa16d(%rip),%rbx        # 101f0 <fwp_gc+0x1048>
    6083:	76 07                	jbe    608c <fwp_gc_chunks+0x15c>
    6085:	48 89 1d 64 a1 00 00 	mov    %rbx,0xa164(%rip)        # 101f0 <fwp_gc+0x1048>
    608c:	4c 89 f0             	mov    %r14,%rax
    608f:	5b                   	pop    %rbx
    6090:	41 5e                	pop    %r14
    6092:	41 5f                	pop    %r15
    6094:	c3                   	ret
    6095:	48 8b 05 44 8f 00 00 	mov    0x8f44(%rip),%rax        # efe0 <stderr@GLIBC_2.2.5>
    609c:	48 8b 08             	mov    (%rax),%rcx
    609f:	48 8d 3d 8a 63 00 00 	lea    0x638a(%rip),%rdi        # c430 <fwp_segv.msg+0x1f0>
    60a6:	be 13 00 00 00       	mov    $0x13,%esi
    60ab:	ba 01 00 00 00       	mov    $0x1,%edx
    60b0:	e8 2b c2 ff ff       	call   22e0 <fwrite@plt>
    60b5:	bf 66 00 00 00       	mov    $0x66,%edi
    60ba:	e8 11 c2 ff ff       	call   22d0 <exit@plt>
    60bf:	90                   	nop

00000000000060c0 <fwp_gc_collect>:
    60c0:	50                   	push   %rax
    60c1:	e8 ea d7 ff ff       	call   38b0 <fwp_flush>
    60c6:	48 8b 05 13 8f 00 00 	mov    0x8f13(%rip),%rax        # efe0 <stderr@GLIBC_2.2.5>
    60cd:	48 8b 38             	mov    (%rax),%rdi
    60d0:	48 8d 35 5d 62 00 00 	lea    0x625d(%rip),%rsi        # c334 <fwp_segv.msg+0xf4>
    60d7:	48 8d 15 66 63 00 00 	lea    0x6366(%rip),%rdx        # c444 <fwp_segv.msg+0x204>
    60de:	31 c0                	xor    %eax,%eax
    60e0:	e8 fb c0 ff ff       	call   21e0 <fprintf@plt>
    60e5:	bf 65 00 00 00       	mov    $0x65,%edi
    60ea:	e8 e1 c1 ff ff       	call   22d0 <exit@plt>
    60ef:	90                   	nop

00000000000060f0 <fwp_closure_drop>:
    60f0:	41 57                	push   %r15
    60f2:	41 56                	push   %r14
    60f4:	53                   	push   %rbx
    60f5:	48 81 ec 30 02 00 00 	sub    $0x230,%rsp
    60fc:	48 89 f8             	mov    %rdi,%rax
    60ff:	48 2b 05 d2 a0 00 00 	sub    0xa0d2(%rip),%rax        # 101d8 <fwp_gc+0x1030>
    6106:	48 8b 0d f3 a0 00 00 	mov    0xa0f3(%rip),%rcx        # 10200 <fwp_gc+0x1058>
    610d:	48 c1 e1 10          	shl    $0x10,%rcx
    6111:	48 39 c8             	cmp    %rcx,%rax
    6114:	0f 83 91 00 00 00    	jae    61ab <fwp_closure_drop+0xbb>
    611a:	48 89 fe             	mov    %rdi,%rsi
    611d:	48 8b 0d fc a0 00 00 	mov    0xa0fc(%rip),%rcx        # 10220 <fwp_gc+0x1078>
    6124:	48 89 c2             	mov    %rax,%rdx
    6127:	48 c1 ea 10          	shr    $0x10,%rdx
    612b:	48 69 d2 28 12 00 00 	imul   $0x1228,%rdx,%rdx
    6132:	0f b6 3c 11          	movzbl (%rcx,%rdx,1),%edi
    6136:	48 25 ff ff 00 00    	and    $0xffff,%rax
    613c:	75 13                	jne    6151 <fwp_closure_drop+0x61>
    613e:	40 80 ff 02          	cmp    $0x2,%dil
    6142:	75 0d                	jne    6151 <fwp_closure_drop+0x61>
    6144:	48 8d 3c 11          	lea    (%rcx,%rdx,1),%rdi
    6148:	48 81 c7 28 02 00 00 	add    $0x228,%rdi
    614f:	eb 20                	jmp    6171 <fwp_closure_drop+0x81>
    6151:	40 80 ff 01          	cmp    $0x1,%dil
    6155:	75 54                	jne    61ab <fwp_closure_drop+0xbb>
    6157:	48 8d 3c 11          	lea    (%rcx,%rdx,1),%rdi
    615b:	8b 4c 11 20          	mov    0x20(%rcx,%rdx,1),%ecx
    615f:	48 0f af c1          	imul   %rcx,%rax
    6163:	48 c1 e8 20          	shr    $0x20,%rax
    6167:	48 01 c7             	add    %rax,%rdi
    616a:	48 81 c7 28 02 00 00 	add    $0x228,%rdi
    6171:	0f b6 07             	movzbl (%rdi),%eax
    6174:	85 c0                	test   %eax,%eax
    6176:	74 33                	je     61ab <fwp_closure_drop+0xbb>
    6178:	83 f8 01             	cmp    $0x1,%eax
    617b:	75 1f                	jne    619c <fwp_closure_drop+0xac>
    617d:	64 48 8b 3c 25 f8 ff 	mov    %fs:0xfffffffffffffff8,%rdi
    6184:	ff ff 
    6186:	48 85 ff             	test   %rdi,%rdi
    6189:	74 2d                	je     61b8 <fwp_closure_drop+0xc8>
    618b:	48 81 c4 30 02 00 00 	add    $0x230,%rsp
    6192:	5b                   	pop    %rbx
    6193:	41 5e                	pop    %r14
    6195:	41 5f                	pop    %r15
    6197:	e9 44 01 00 00       	jmp    62e0 <fwp_closure_drop_push>
    619c:	3d ff 00 00 00       	cmp    $0xff,%eax
    61a1:	0f 84 e7 00 00 00    	je     628e <fwp_closure_drop+0x19e>
    61a7:	fe c8                	dec    %al
    61a9:	88 07                	mov    %al,(%rdi)
    61ab:	48 81 c4 30 02 00 00 	add    $0x230,%rsp
    61b2:	5b                   	pop    %rbx
    61b3:	41 5e                	pop    %r14
    61b5:	41 5f                	pop    %r15
    61b7:	c3                   	ret
    61b8:	64 48 8b 04 25 00 00 	mov    %fs:0x0,%rax
    61bf:	00 00 
    61c1:	4c 8d b0 f8 ff ff ff 	lea    -0x8(%rax),%r14
    61c8:	48 8d 5c 24 30       	lea    0x30(%rsp),%rbx
    61cd:	48 89 5c 24 18       	mov    %rbx,0x18(%rsp)
    61d2:	48 c7 44 24 20 00 00 	movq   $0x0,0x20(%rsp)
    61d9:	00 00 
    61db:	48 c7 44 24 28 40 00 	movq   $0x40,0x28(%rsp)
    61e2:	00 00 
    61e4:	48 8b 05 8d aa 00 00 	mov    0xaa8d(%rip),%rax        # 10c78 <fwp_cleanups>
    61eb:	48 89 04 24          	mov    %rax,(%rsp)
    61ef:	48 8d 05 ca 01 00 00 	lea    0x1ca(%rip),%rax        # 63c0 <fwp_closure_drop_release>
    61f6:	48 89 44 24 08       	mov    %rax,0x8(%rsp)
    61fb:	48 8d 7c 24 18       	lea    0x18(%rsp),%rdi
    6200:	48 89 7c 24 10       	mov    %rdi,0x10(%rsp)
    6205:	49 89 e7             	mov    %rsp,%r15
    6208:	4c 89 3d 69 aa 00 00 	mov    %r15,0xaa69(%rip)        # 10c78 <fwp_cleanups>
    620f:	49 89 3e             	mov    %rdi,(%r14)
    6212:	e8 c9 00 00 00       	call   62e0 <fwp_closure_drop_push>
    6217:	66 0f 1f 84 00 00 00 	nopw   0x0(%rax,%rax,1)
    621e:	00 00 
    6220:	48 8b 44 24 20       	mov    0x20(%rsp),%rax
    6225:	48 85 c0             	test   %rax,%rax
    6228:	74 31                	je     625b <fwp_closure_drop+0x16b>
    622a:	48 8b 4c 24 18       	mov    0x18(%rsp),%rcx
    622f:	48 8d 50 ff          	lea    -0x1(%rax),%rdx
    6233:	48 89 54 24 20       	mov    %rdx,0x20(%rsp)
    6238:	48 8b 7c c1 f8       	mov    -0x8(%rcx,%rax,8),%rdi
    623d:	48 8b 05 0c aa 00 00 	mov    0xaa0c(%rip),%rax        # 10c50 <fwp_fns>
    6244:	8b 0f                	mov    (%rdi),%ecx
    6246:	48 c1 e1 05          	shl    $0x5,%rcx
    624a:	48 8b 44 08 18       	mov    0x18(%rax,%rcx,1),%rax
    624f:	48 85 c0             	test   %rax,%rax
    6252:	74 4b                	je     629f <fwp_closure_drop+0x1af>
    6254:	31 f6                	xor    %esi,%esi
    6256:	ff 50 08             	call   *0x8(%rax)
    6259:	eb c5                	jmp    6220 <fwp_closure_drop+0x130>
    625b:	4c 39 3d 16 aa 00 00 	cmp    %r15,0xaa16(%rip)        # 10c78 <fwp_cleanups>
    6262:	75 69                	jne    62cd <fwp_closure_drop+0x1dd>
    6264:	48 8b 04 24          	mov    (%rsp),%rax
    6268:	48 89 05 09 aa 00 00 	mov    %rax,0xaa09(%rip)        # 10c78 <fwp_cleanups>
    626f:	49 c7 06 00 00 00 00 	movq   $0x0,(%r14)
    6276:	48 8b 7c 24 18       	mov    0x18(%rsp),%rdi
    627b:	48 39 df             	cmp    %rbx,%rdi
    627e:	0f 84 27 ff ff ff    	je     61ab <fwp_closure_drop+0xbb>
    6284:	e8 c7 bd ff ff       	call   2050 <free@plt>
    6289:	e9 1d ff ff ff       	jmp    61ab <fwp_closure_drop+0xbb>
    628e:	48 81 c4 30 02 00 00 	add    $0x230,%rsp
    6295:	5b                   	pop    %rbx
    6296:	41 5e                	pop    %r14
    6298:	41 5f                	pop    %r15
    629a:	e9 61 01 00 00       	jmp    6400 <fwp_rc_wide_drop>
    629f:	e8 0c d6 ff ff       	call   38b0 <fwp_flush>
    62a4:	48 8b 05 35 8d 00 00 	mov    0x8d35(%rip),%rax        # efe0 <stderr@GLIBC_2.2.5>
    62ab:	48 8b 38             	mov    (%rax),%rdi
    62ae:	48 8d 35 7f 60 00 00 	lea    0x607f(%rip),%rsi        # c334 <fwp_segv.msg+0xf4>
    62b5:	48 8d 15 b9 61 00 00 	lea    0x61b9(%rip),%rdx        # c475 <fwp_segv.msg+0x235>
    62bc:	31 c0                	xor    %eax,%eax
    62be:	e8 1d bf ff ff       	call   21e0 <fprintf@plt>
    62c3:	bf 65 00 00 00       	mov    $0x65,%edi
    62c8:	e8 03 c0 ff ff       	call   22d0 <exit@plt>
    62cd:	e8 8e bd ff ff       	call   2060 <abort@plt>
    62d2:	66 66 66 66 66 2e 0f 	data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    62d9:	1f 84 00 00 00 00 00 

00000000000062e0 <fwp_closure_drop_push>:
    62e0:	55                   	push   %rbp
    62e1:	41 57                	push   %r15
    62e3:	41 56                	push   %r14
    62e5:	41 55                	push   %r13
    62e7:	41 54                	push   %r12
    62e9:	53                   	push   %rbx
    62ea:	50                   	push   %rax
    62eb:	48 89 f3             	mov    %rsi,%rbx
    62ee:	49 89 fe             	mov    %rdi,%r14
    62f1:	4c 8b 6f 08          	mov    0x8(%rdi),%r13
    62f5:	4c 3b 6f 10          	cmp    0x10(%rdi),%r13
    62f9:	75 59                	jne    6354 <fwp_closure_drop_push+0x74>
    62fb:	4c 89 e8             	mov    %r13,%rax
    62fe:	48 c1 e8 3c          	shr    $0x3c,%rax
    6302:	75 6e                	jne    6372 <fwp_closure_drop_push+0x92>
    6304:	4c 89 ef             	mov    %r13,%rdi
    6307:	48 c1 e7 04          	shl    $0x4,%rdi
    630b:	e8 10 bf ff ff       	call   2220 <malloc@plt>
    6310:	48 85 c0             	test   %rax,%rax
    6313:	74 7c                	je     6391 <fwp_closure_drop_push+0xb1>
    6315:	49 89 c7             	mov    %rax,%r15
    6318:	4a 8d 2c 6d 00 00 00 	lea    0x0(,%r13,2),%rbp
    631f:	00 
    6320:	4d 8b 26             	mov    (%r14),%r12
    6323:	4a 8d 14 ed 00 00 00 	lea    0x0(,%r13,8),%rdx
    632a:	00 
    632b:	48 89 c7             	mov    %rax,%rdi
    632e:	4c 89 e6             	mov    %r12,%rsi
    6331:	e8 da be ff ff       	call   2210 <memcpy@plt>
    6336:	49 8d 46 18          	lea    0x18(%r14),%rax
    633a:	49 39 c4             	cmp    %rax,%r12
    633d:	74 0c                	je     634b <fwp_closure_drop_push+0x6b>
    633f:	4c 89 e7             	mov    %r12,%rdi
    6342:	e8 09 bd ff ff       	call   2050 <free@plt>
    6347:	4d 8b 6e 08          	mov    0x8(%r14),%r13
    634b:	4d 89 3e             	mov    %r15,(%r14)
    634e:	49 89 6e 10          	mov    %rbp,0x10(%r14)
    6352:	eb 03                	jmp    6357 <fwp_closure_drop_push+0x77>
    6354:	4d 8b 3e             	mov    (%r14),%r15
    6357:	49 8d 45 01          	lea    0x1(%r13),%rax
    635b:	49 89 46 08          	mov    %rax,0x8(%r14)
    635f:	4b 89 1c ef          	mov    %rbx,(%r15,%r13,8)
    6363:	48 83 c4 08          	add    $0x8,%rsp
    6367:	5b                   	pop    %rbx
    6368:	41 5c                	pop    %r12
    636a:	41 5d                	pop    %r13
    636c:	41 5e                	pop    %r14
    636e:	41 5f                	pop    %r15
    6370:	5d                   	pop    %rbp
    6371:	c3                   	ret
    6372:	e8 39 d5 ff ff       	call   38b0 <fwp_flush>
    6377:	48 8b 05 62 8c 00 00 	mov    0x8c62(%rip),%rax        # efe0 <stderr@GLIBC_2.2.5>
    637e:	48 8b 38             	mov    (%rax),%rdi
    6381:	48 8d 35 ac 5f 00 00 	lea    0x5fac(%rip),%rsi        # c334 <fwp_segv.msg+0xf4>
    6388:	48 8d 15 14 61 00 00 	lea    0x6114(%rip),%rdx        # c4a3 <fwp_segv.msg+0x263>
    638f:	eb 1d                	jmp    63ae <fwp_closure_drop_push+0xce>
    6391:	e8 1a d5 ff ff       	call   38b0 <fwp_flush>
    6396:	48 8b 05 43 8c 00 00 	mov    0x8c43(%rip),%rax        # efe0 <stderr@GLIBC_2.2.5>
    639d:	48 8b 38             	mov    (%rax),%rdi
    63a0:	48 8d 35 8d 5f 00 00 	lea    0x5f8d(%rip),%rsi        # c334 <fwp_segv.msg+0xf4>
    63a7:	48 8d 15 0f 61 00 00 	lea    0x610f(%rip),%rdx        # c4bd <fwp_segv.msg+0x27d>
    63ae:	31 c0                	xor    %eax,%eax
    63b0:	e8 2b be ff ff       	call   21e0 <fprintf@plt>
    63b5:	bf 65 00 00 00       	mov    $0x65,%edi
    63ba:	e8 11 bf ff ff       	call   22d0 <exit@plt>
    63bf:	90                   	nop

00000000000063c0 <fwp_closure_drop_release>:
    63c0:	41 56                	push   %r14
    63c2:	53                   	push   %rbx
    63c3:	50                   	push   %rax
    63c4:	48 89 fb             	mov    %rdi,%rbx
    63c7:	64 48 c7 04 25 f8 ff 	movq   $0x0,%fs:0xfffffffffffffff8
    63ce:	ff ff 00 00 00 00 
    63d4:	48 8b 3f             	mov    (%rdi),%rdi
    63d7:	4c 8d 73 18          	lea    0x18(%rbx),%r14
    63db:	4c 39 f7             	cmp    %r14,%rdi
    63de:	74 05                	je     63e5 <fwp_closure_drop_release+0x25>
    63e0:	e8 6b bc ff ff       	call   2050 <free@plt>
    63e5:	4c 89 33             	mov    %r14,(%rbx)
    63e8:	48 c7 43 08 00 00 00 	movq   $0x0,0x8(%rbx)
    63ef:	00 
    63f0:	48 83 c4 08          	add    $0x8,%rsp
    63f4:	5b                   	pop    %rbx
    63f5:	41 5e                	pop    %r14
    63f7:	c3                   	ret
    63f8:	0f 1f 84 00 00 00 00 	nopl   0x0(%rax,%rax,1)
    63ff:	00 

0000000000006400 <fwp_rc_wide_drop>:
    6400:	53                   	push   %rbx
    6401:	48 89 f8             	mov    %rdi,%rax
    6404:	48 c1 e8 11          	shr    $0x11,%rax
    6408:	31 f8                	xor    %edi,%eax
    640a:	89 c1                	mov    %eax,%ecx
    640c:	c1 e9 09             	shr    $0x9,%ecx
    640f:	31 c1                	xor    %eax,%ecx
    6411:	0f b6 c1             	movzbl %cl,%eax
    6414:	48 8d 0d 8d 8d 00 00 	lea    0x8d8d(%rip),%rcx        # f1a8 <fwp_gc>
    641b:	48 8b 84 c1 18 12 00 	mov    0x1218(%rcx,%rax,8),%rax
    6422:	00 
    6423:	48 85 c0             	test   %rax,%rax
    6426:	74 16                	je     643e <fwp_rc_wide_drop+0x3e>
    6428:	0f 1f 84 00 00 00 00 	nopl   0x0(%rax,%rax,1)
    642f:	00 
    6430:	48 39 38             	cmp    %rdi,(%rax)
    6433:	74 37                	je     646c <fwp_rc_wide_drop+0x6c>
    6435:	48 8b 40 10          	mov    0x10(%rax),%rax
    6439:	48 85 c0             	test   %rax,%rax
    643c:	75 f2                	jne    6430 <fwp_rc_wide_drop+0x30>
    643e:	e8 6d d4 ff ff       	call   38b0 <fwp_flush>
    6443:	48 8b 05 96 8b 00 00 	mov    0x8b96(%rip),%rax        # efe0 <stderr@GLIBC_2.2.5>
    644a:	48 8b 38             	mov    (%rax),%rdi
    644d:	48 8d 35 e0 5e 00 00 	lea    0x5ee0(%rip),%rsi        # c334 <fwp_segv.msg+0xf4>
    6454:	48 8d 15 e8 5e 00 00 	lea    0x5ee8(%rip),%rdx        # c343 <fwp_segv.msg+0x103>
    645b:	31 c0                	xor    %eax,%eax
    645d:	e8 7e bd ff ff       	call   21e0 <fprintf@plt>
    6462:	bf 65 00 00 00       	mov    $0x65,%edi
    6467:	e8 64 be ff ff       	call   22d0 <exit@plt>
    646c:	48 8b 48 08          	mov    0x8(%rax),%rcx
    6470:	48 ff c9             	dec    %rcx
    6473:	48 89 48 08          	mov    %rcx,0x8(%rax)
    6477:	48 81 f9 fe 00 00 00 	cmp    $0xfe,%rcx
    647e:	75 0b                	jne    648b <fwp_rc_wide_drop+0x8b>
    6480:	48 89 fb             	mov    %rdi,%rbx
    6483:	e8 58 d4 ff ff       	call   38e0 <fwp_rc_forget_slot>
    6488:	c6 03 fe             	movb   $0xfe,(%rbx)
    648b:	5b                   	pop    %rbx
    648c:	c3                   	ret
    648d:	0f 1f 00             	nopl   (%rax)

0000000000006490 <fwp_rc_wide_dup>:
    6490:	41 56                	push   %r14
    6492:	53                   	push   %rbx
    6493:	50                   	push   %rax
    6494:	48 89 fb             	mov    %rdi,%rbx
    6497:	48 89 f8             	mov    %rdi,%rax
    649a:	48 c1 e8 11          	shr    $0x11,%rax
    649e:	31 d8                	xor    %ebx,%eax
    64a0:	89 c1                	mov    %eax,%ecx
    64a2:	c1 e9 09             	shr    $0x9,%ecx
    64a5:	31 c1                	xor    %eax,%ecx
    64a7:	0f b6 c1             	movzbl %cl,%eax
    64aa:	48 8d 0d f7 8c 00 00 	lea    0x8cf7(%rip),%rcx        # f1a8 <fwp_gc>
    64b1:	4c 8d 34 c1          	lea    (%rcx,%rax,8),%r14
    64b5:	49 81 c6 18 12 00 00 	add    $0x1218,%r14
    64bc:	48 8b 84 c1 18 12 00 	mov    0x1218(%rcx,%rax,8),%rax
    64c3:	00 
    64c4:	48 85 c0             	test   %rax,%rax
    64c7:	74 1a                	je     64e3 <fwp_rc_wide_dup+0x53>
    64c9:	48 39 18             	cmp    %rbx,(%rax)
    64cc:	74 22                	je     64f0 <fwp_rc_wide_dup+0x60>
    64ce:	66 90                	xchg   %ax,%ax
    64d0:	49 89 c6             	mov    %rax,%r14
    64d3:	48 8b 40 10          	mov    0x10(%rax),%rax
    64d7:	48 85 c0             	test   %rax,%rax
    64da:	74 0e                	je     64ea <fwp_rc_wide_dup+0x5a>
    64dc:	48 39 18             	cmp    %rbx,(%rax)
    64df:	75 ef                	jne    64d0 <fwp_rc_wide_dup+0x40>
    64e1:	eb 09                	jmp    64ec <fwp_rc_wide_dup+0x5c>
    64e3:	80 3b fe             	cmpb   $0xfe,(%rbx)
    64e6:	74 16                	je     64fe <fwp_rc_wide_dup+0x6e>
    64e8:	eb 6d                	jmp    6557 <fwp_rc_wide_dup+0xc7>
    64ea:	31 c0                	xor    %eax,%eax
    64ec:	49 83 c6 10          	add    $0x10,%r14
    64f0:	80 3b fe             	cmpb   $0xfe,(%rbx)
    64f3:	75 41                	jne    6536 <fwp_rc_wide_dup+0xa6>
    64f5:	48 85 c0             	test   %rax,%rax
    64f8:	0f 85 a2 00 00 00    	jne    65a0 <fwp_rc_wide_dup+0x110>
    64fe:	bf 18 00 00 00       	mov    $0x18,%edi
    6503:	e8 18 bd ff ff       	call   2220 <malloc@plt>
    6508:	48 85 c0             	test   %rax,%rax
    650b:	74 69                	je     6576 <fwp_rc_wide_dup+0xe6>
    650d:	48 89 18             	mov    %rbx,(%rax)
    6510:	48 c7 40 08 ff 00 00 	movq   $0xff,0x8(%rax)
    6517:	00 
    6518:	48 c7 40 10 00 00 00 	movq   $0x0,0x10(%rax)
    651f:	00 
    6520:	49 89 06             	mov    %rax,(%r14)
    6523:	c6 03 ff             	movb   $0xff,(%rbx)
    6526:	48 8d 05 93 a6 00 00 	lea    0xa693(%rip),%rax        # 10bc0 <fwp_gc+0x1a18>
    652d:	48 8b 0d 8c a6 00 00 	mov    0xa68c(%rip),%rcx        # 10bc0 <fwp_gc+0x1a18>
    6534:	eb 13                	jmp    6549 <fwp_rc_wide_dup+0xb9>
    6536:	48 85 c0             	test   %rax,%rax
    6539:	74 1c                	je     6557 <fwp_rc_wide_dup+0xc7>
    653b:	48 8b 48 08          	mov    0x8(%rax),%rcx
    653f:	48 83 f9 ff          	cmp    $0xffffffffffffffff,%rcx
    6543:	74 7a                	je     65bf <fwp_rc_wide_dup+0x12f>
    6545:	48 83 c0 08          	add    $0x8,%rax
    6549:	48 ff c1             	inc    %rcx
    654c:	48 89 08             	mov    %rcx,(%rax)
    654f:	48 83 c4 08          	add    $0x8,%rsp
    6553:	5b                   	pop    %rbx
    6554:	41 5e                	pop    %r14
    6556:	c3                   	ret
    6557:	e8 54 d3 ff ff       	call   38b0 <fwp_flush>
    655c:	48 8b 05 7d 8a 00 00 	mov    0x8a7d(%rip),%rax        # efe0 <stderr@GLIBC_2.2.5>
    6563:	48 8b 38             	mov    (%rax),%rdi
    6566:	48 8d 35 c7 5d 00 00 	lea    0x5dc7(%rip),%rsi        # c334 <fwp_segv.msg+0xf4>
    656d:	48 8d 15 cf 5d 00 00 	lea    0x5dcf(%rip),%rdx        # c343 <fwp_segv.msg+0x103>
    6574:	eb 66                	jmp    65dc <fwp_rc_wide_dup+0x14c>
    6576:	48 8b 05 63 8a 00 00 	mov    0x8a63(%rip),%rax        # efe0 <stderr@GLIBC_2.2.5>
    657d:	48 8b 08             	mov    (%rax),%rcx
    6580:	48 8d 3d a9 5e 00 00 	lea    0x5ea9(%rip),%rdi        # c430 <fwp_segv.msg+0x1f0>
    6587:	be 13 00 00 00       	mov    $0x13,%esi
    658c:	ba 01 00 00 00       	mov    $0x1,%edx
    6591:	e8 4a bd ff ff       	call   22e0 <fwrite@plt>
    6596:	bf 66 00 00 00       	mov    $0x66,%edi
    659b:	e8 30 bd ff ff       	call   22d0 <exit@plt>
    65a0:	e8 0b d3 ff ff       	call   38b0 <fwp_flush>
    65a5:	48 8b 05 34 8a 00 00 	mov    0x8a34(%rip),%rax        # efe0 <stderr@GLIBC_2.2.5>
    65ac:	48 8b 38             	mov    (%rax),%rdi
    65af:	48 8d 35 7e 5d 00 00 	lea    0x5d7e(%rip),%rsi        # c334 <fwp_segv.msg+0xf4>
    65b6:	48 8d 15 0e 5f 00 00 	lea    0x5f0e(%rip),%rdx        # c4cb <fwp_segv.msg+0x28b>
    65bd:	eb 1d                	jmp    65dc <fwp_rc_wide_dup+0x14c>
    65bf:	e8 ec d2 ff ff       	call   38b0 <fwp_flush>
    65c4:	48 8b 05 15 8a 00 00 	mov    0x8a15(%rip),%rax        # efe0 <stderr@GLIBC_2.2.5>
    65cb:	48 8b 38             	mov    (%rax),%rdi
    65ce:	48 8d 35 5f 5d 00 00 	lea    0x5d5f(%rip),%rsi        # c334 <fwp_segv.msg+0xf4>
    65d5:	48 8d 15 14 5f 00 00 	lea    0x5f14(%rip),%rdx        # c4f0 <fwp_segv.msg+0x2b0>
    65dc:	31 c0                	xor    %eax,%eax
    65de:	e8 fd bb ff ff       	call   21e0 <fprintf@plt>
    65e3:	bf 65 00 00 00       	mov    $0x65,%edi
    65e8:	e8 e3 bc ff ff       	call   22d0 <exit@plt>
    65ed:	0f 1f 00             	nopl   (%rax)

00000000000065f0 <fwp_rc_cleanup_cell>:
    65f0:	48 89 f8             	mov    %rdi,%rax
    65f3:	48 8b 3f             	mov    (%rdi),%rdi
    65f6:	48 c7 00 00 00 00 00 	movq   $0x0,(%rax)
    65fd:	48 85 ff             	test   %rdi,%rdi
    6600:	75 0e                	jne    6610 <fwp_rc_free_obj>
    6602:	c3                   	ret
    6603:	66 66 66 66 2e 0f 1f 	data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    660a:	84 00 00 00 00 00 

0000000000006610 <fwp_rc_free_obj>:
    6610:	48 89 f8             	mov    %rdi,%rax
    6613:	48 2b 05 be 9b 00 00 	sub    0x9bbe(%rip),%rax        # 101d8 <fwp_gc+0x1030>
    661a:	48 8b 0d df 9b 00 00 	mov    0x9bdf(%rip),%rcx        # 10200 <fwp_gc+0x1058>
    6621:	48 c1 e1 10          	shl    $0x10,%rcx
    6625:	48 39 c8             	cmp    %rcx,%rax
    6628:	0f 83 b8 01 00 00    	jae    67e6 <fwp_rc_free_obj+0x1d6>
    662e:	55                   	push   %rbp
    662f:	41 57                	push   %r15
    6631:	41 56                	push   %r14
    6633:	53                   	push   %rbx
    6634:	50                   	push   %rax
    6635:	48 8b 1d e4 9b 00 00 	mov    0x9be4(%rip),%rbx        # 10220 <fwp_gc+0x1078>
    663c:	48 89 c1             	mov    %rax,%rcx
    663f:	48 c1 e9 10          	shr    $0x10,%rcx
    6643:	4c 69 f1 28 12 00 00 	imul   $0x1228,%rcx,%r14
    664a:	42 0f b6 2c 33       	movzbl (%rbx,%r14,1),%ebp
    664f:	48 25 ff ff 00 00    	and    $0xffff,%rax
    6655:	75 1a                	jne    6671 <fwp_rc_free_obj+0x61>
    6657:	40 80 fd 02          	cmp    $0x2,%bpl
    665b:	75 14                	jne    6671 <fwp_rc_free_obj+0x61>
    665d:	4a 8d 04 33          	lea    (%rbx,%r14,1),%rax
    6661:	48 05 28 02 00 00    	add    $0x228,%rax
    6667:	80 38 01             	cmpb   $0x1,(%rax)
    666a:	74 32                	je     669e <fwp_rc_free_obj+0x8e>
    666c:	e9 6b 01 00 00       	jmp    67dc <fwp_rc_free_obj+0x1cc>
    6671:	40 80 fd 01          	cmp    $0x1,%bpl
    6675:	0f 85 61 01 00 00    	jne    67dc <fwp_rc_free_obj+0x1cc>
    667b:	4a 8d 0c 33          	lea    (%rbx,%r14,1),%rcx
    667f:	42 8b 54 33 20       	mov    0x20(%rbx,%r14,1),%edx
    6684:	48 0f af c2          	imul   %rdx,%rax
    6688:	48 c1 e8 20          	shr    $0x20,%rax
    668c:	48 01 c8             	add    %rcx,%rax
    668f:	48 05 28 02 00 00    	add    $0x228,%rax
    6695:	80 38 01             	cmpb   $0x1,(%rax)
    6698:	0f 85 3e 01 00 00    	jne    67dc <fwp_rc_free_obj+0x1cc>
    669e:	8b 0d 24 a5 00 00    	mov    0xa524(%rip),%ecx        # 10bc8 <fwp_reuse_verify>
    66a4:	85 c9                	test   %ecx,%ecx
    66a6:	0f 88 c3 00 00 00    	js     676f <fwp_rc_free_obj+0x15f>
    66ac:	85 c9                	test   %ecx,%ecx
    66ae:	0f 84 fd 00 00 00    	je     67b1 <fwp_rc_free_obj+0x1a1>
    66b4:	42 80 7c 33 01 01    	cmpb   $0x1,0x1(%rbx,%r14,1)
    66ba:	75 0d                	jne    66c9 <fwp_rc_free_obj+0xb9>
    66bc:	40 80 fd 02          	cmp    $0x2,%bpl
    66c0:	75 22                	jne    66e4 <fwp_rc_free_obj+0xd4>
    66c2:	4a 8b 54 33 18       	mov    0x18(%rbx,%r14,1),%rdx
    66c7:	eb 20                	jmp    66e9 <fwp_rc_free_obj+0xd9>
    66c9:	c7 07 ad de 00 00    	movl   $0xdead,(%rdi)
    66cf:	8b 47 04             	mov    0x4(%rdi),%eax
    66d2:	48 85 c0             	test   %rax,%rax
    66d5:	0f 84 01 01 00 00    	je     67dc <fwp_rc_free_obj+0x1cc>
    66db:	83 f8 04             	cmp    $0x4,%eax
    66de:	73 26                	jae    6706 <fwp_rc_free_obj+0xf6>
    66e0:	31 c9                	xor    %ecx,%ecx
    66e2:	eb 6a                	jmp    674e <fwp_rc_free_obj+0x13e>
    66e4:	42 8b 54 33 08       	mov    0x8(%rbx,%r14,1),%edx
    66e9:	48 89 fb             	mov    %rdi,%rbx
    66ec:	be dd 00 00 00       	mov    $0xdd,%esi
    66f1:	e8 6a ba ff ff       	call   2160 <memset@plt>
    66f6:	48 c7 03 00 00 00 00 	movq   $0x0,(%rbx)
    66fd:	c6 43 08 00          	movb   $0x0,0x8(%rbx)
    6701:	e9 d6 00 00 00       	jmp    67dc <fwp_rc_free_obj+0x1cc>
    6706:	89 c1                	mov    %eax,%ecx
    6708:	83 e1 fc             	and    $0xfffffffc,%ecx
    670b:	48 8d 14 c5 00 00 00 	lea    0x0(,%rax,8),%rdx
    6712:	00 
    6713:	48 83 e2 e0          	and    $0xffffffffffffffe0,%rdx
    6717:	31 f6                	xor    %esi,%esi
    6719:	66 0f 28 05 8f 59 00 	movapd 0x598f(%rip),%xmm0        # c0b0 <_IO_stdin_used+0xb0>
    6720:	00 
    6721:	66 66 66 66 66 66 2e 	data16 data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    6728:	0f 1f 84 00 00 00 00 
    672f:	00 
    6730:	66 0f 11 44 37 08    	movupd %xmm0,0x8(%rdi,%rsi,1)
    6736:	66 0f 11 44 37 18    	movupd %xmm0,0x18(%rdi,%rsi,1)
    673c:	48 83 c6 20          	add    $0x20,%rsi
    6740:	48 39 f2             	cmp    %rsi,%rdx
    6743:	75 eb                	jne    6730 <fwp_rc_free_obj+0x120>
    6745:	48 39 c1             	cmp    %rax,%rcx
    6748:	0f 84 8e 00 00 00    	je     67dc <fwp_rc_free_obj+0x1cc>
    674e:	48 ba ef be ad de ef 	movabs $0xdeadbeefdeadbeef,%rdx
    6755:	be ad de 
    6758:	0f 1f 84 00 00 00 00 	nopl   0x0(%rax,%rax,1)
    675f:	00 
    6760:	48 89 54 cf 08       	mov    %rdx,0x8(%rdi,%rcx,8)
    6765:	48 ff c1             	inc    %rcx
    6768:	48 39 c8             	cmp    %rcx,%rax
    676b:	75 f3                	jne    6760 <fwp_rc_free_obj+0x150>
    676d:	eb 6d                	jmp    67dc <fwp_rc_free_obj+0x1cc>
    676f:	49 89 ff             	mov    %rdi,%r15
    6772:	48 8d 3d 67 5c 00 00 	lea    0x5c67(%rip),%rdi        # c3e0 <fwp_segv.msg+0x1a0>
    6779:	e8 b2 b8 ff ff       	call   2030 <getenv@plt>
    677e:	31 c9                	xor    %ecx,%ecx
    6780:	48 85 c0             	test   %rax,%rax
    6783:	74 1b                	je     67a0 <fwp_rc_free_obj+0x190>
    6785:	80 38 00             	cmpb   $0x0,(%rax)
    6788:	74 16                	je     67a0 <fwp_rc_free_obj+0x190>
    678a:	48 8d 35 1e 5e 00 00 	lea    0x5e1e(%rip),%rsi        # c5af <fwp_segv.msg+0x36f>
    6791:	48 89 c7             	mov    %rax,%rdi
    6794:	e8 27 ba ff ff       	call   21c0 <strcmp@plt>
    6799:	31 c9                	xor    %ecx,%ecx
    679b:	85 c0                	test   %eax,%eax
    679d:	0f 95 c1             	setne  %cl
    67a0:	89 0d 22 a4 00 00    	mov    %ecx,0xa422(%rip)        # 10bc8 <fwp_reuse_verify>
    67a6:	4c 89 ff             	mov    %r15,%rdi
    67a9:	85 c9                	test   %ecx,%ecx
    67ab:	0f 85 03 ff ff ff    	jne    66b4 <fwp_rc_free_obj+0xa4>
    67b1:	48 8b 1d f0 89 00 00 	mov    0x89f0(%rip),%rbx        # f1a8 <fwp_gc>
    67b8:	e8 33 00 00 00       	call   67f0 <fwp_mem_free>
    67bd:	48 8b 05 e4 89 00 00 	mov    0x89e4(%rip),%rax        # f1a8 <fwp_gc>
    67c4:	48 29 d8             	sub    %rbx,%rax
    67c7:	f2 48 0f 2a c0       	cvtsi2sd %rax,%xmm0
    67cc:	f2 0f 58 05 dc 9b 00 	addsd  0x9bdc(%rip),%xmm0        # 103b0 <fwp_gc+0x1208>
    67d3:	00 
    67d4:	f2 0f 11 05 d4 9b 00 	movsd  %xmm0,0x9bd4(%rip)        # 103b0 <fwp_gc+0x1208>
    67db:	00 
    67dc:	48 83 c4 08          	add    $0x8,%rsp
    67e0:	5b                   	pop    %rbx
    67e1:	41 5e                	pop    %r14
    67e3:	41 5f                	pop    %r15
    67e5:	5d                   	pop    %rbp
    67e6:	c3                   	ret
    67e7:	66 0f 1f 84 00 00 00 	nopw   0x0(%rax,%rax,1)
    67ee:	00 00 

00000000000067f0 <fwp_mem_free>:
    67f0:	48 85 ff             	test   %rdi,%rdi
    67f3:	0f 84 17 02 00 00    	je     6a10 <fwp_mem_free+0x220>
    67f9:	48 8b 05 d8 99 00 00 	mov    0x99d8(%rip),%rax        # 101d8 <fwp_gc+0x1030>
    6800:	48 89 f9             	mov    %rdi,%rcx
    6803:	48 29 c1             	sub    %rax,%rcx
    6806:	48 8b 15 f3 99 00 00 	mov    0x99f3(%rip),%rdx        # 10200 <fwp_gc+0x1058>
    680d:	48 c1 e2 10          	shl    $0x10,%rdx
    6811:	48 39 d1             	cmp    %rdx,%rcx
    6814:	0f 83 f6 01 00 00    	jae    6a10 <fwp_mem_free+0x220>
    681a:	41 57                	push   %r15
    681c:	41 56                	push   %r14
    681e:	41 55                	push   %r13
    6820:	41 54                	push   %r12
    6822:	53                   	push   %rbx
    6823:	4c 8b 25 f6 99 00 00 	mov    0x99f6(%rip),%r12        # 10220 <fwp_gc+0x1078>
    682a:	4d 85 e4             	test   %r12,%r12
    682d:	0f 84 d4 01 00 00    	je     6a07 <fwp_mem_free+0x217>
    6833:	49 89 cf             	mov    %rcx,%r15
    6836:	49 c1 ef 10          	shr    $0x10,%r15
    683a:	4d 69 f7 28 12 00 00 	imul   $0x1228,%r15,%r14
    6841:	43 0f b6 14 34       	movzbl (%r12,%r14,1),%edx
    6846:	83 fa 02             	cmp    $0x2,%edx
    6849:	0f 84 b9 00 00 00    	je     6908 <fwp_mem_free+0x118>
    684f:	83 fa 01             	cmp    $0x1,%edx
    6852:	0f 85 af 01 00 00    	jne    6a07 <fwp_mem_free+0x217>
    6858:	47 0f b6 4c 34 01    	movzbl 0x1(%r12,%r14,1),%r9d
    685e:	47 0f b6 44 34 02    	movzbl 0x2(%r12,%r14,1),%r8d
    6864:	43 8b 74 34 08       	mov    0x8(%r12,%r14,1),%esi
    6869:	0f b7 c7             	movzwl %di,%eax
    686c:	31 d2                	xor    %edx,%edx
    686e:	f7 f6                	div    %esi
    6870:	48 c7 c2 fe ff ff ff 	mov    $0xfffffffffffffffe,%rdx
    6877:	89 c1                	mov    %eax,%ecx
    6879:	48 d3 c2             	rol    %cl,%rdx
    687c:	4b 8d 0c 34          	lea    (%r12,%r14,1),%rcx
    6880:	41 89 c2             	mov    %eax,%r10d
    6883:	41 c1 ea 03          	shr    $0x3,%r10d
    6887:	41 81 e2 f8 1f 00 00 	and    $0x1ff8,%r10d
    688e:	49 21 54 0a 28       	and    %rdx,0x28(%r10,%rcx,1)
    6893:	49 69 d1 c0 03 00 00 	imul   $0x3c0,%r9,%rdx
    689a:	4c 8d 3d 07 89 00 00 	lea    0x8907(%rip),%r15        # f1a8 <fwp_gc>
    68a1:	49 01 d7             	add    %rdx,%r15
    68a4:	4f 8d 2c 40          	lea    (%r8,%r8,2),%r13
    68a8:	4d 01 e6             	add    %r12,%r14
    68ab:	49 83 c6 08          	add    $0x8,%r14
    68af:	48 8d 1c 08          	lea    (%rax,%rcx,1),%rbx
    68b3:	48 81 c3 28 02 00 00 	add    $0x228,%rbx
    68ba:	80 bc 08 28 02 00 00 	cmpb   $0xff,0x228(%rax,%rcx,1)
    68c1:	ff 
    68c2:	0f 84 49 01 00 00    	je     6a11 <fwp_mem_free+0x221>
    68c8:	4f 8d 3c ef          	lea    (%r15,%r13,8),%r15
    68cc:	49 83 c7 08          	add    $0x8,%r15
    68d0:	c6 03 00             	movb   $0x0,(%rbx)
    68d3:	83 3d d2 98 00 00 00 	cmpl   $0x0,0x98d2(%rip)        # 101ac <fwp_gc+0x1004>
    68da:	74 12                	je     68ee <fwp_mem_free+0xfe>
    68dc:	89 f2                	mov    %esi,%edx
    68de:	48 89 fb             	mov    %rdi,%rbx
    68e1:	31 f6                	xor    %esi,%esi
    68e3:	e8 78 b8 ff ff       	call   2160 <memset@plt>
    68e8:	48 89 df             	mov    %rbx,%rdi
    68eb:	41 8b 36             	mov    (%r14),%esi
    68ee:	49 8b 07             	mov    (%r15),%rax
    68f1:	48 f7 d0             	not    %rax
    68f4:	48 89 07             	mov    %rax,(%rdi)
    68f7:	49 89 3f             	mov    %rdi,(%r15)
    68fa:	89 f0                	mov    %esi,%eax
    68fc:	48 01 05 a5 88 00 00 	add    %rax,0x88a5(%rip)        # f1a8 <fwp_gc>
    6903:	e9 ff 00 00 00       	jmp    6a07 <fwp_mem_free+0x217>
    6908:	48 81 e1 00 00 ff ff 	and    $0xffffffffffff0000,%rcx
    690f:	48 01 c8             	add    %rcx,%rax
    6912:	48 39 f8             	cmp    %rdi,%rax
    6915:	0f 85 ec 00 00 00    	jne    6a07 <fwp_mem_free+0x217>
    691b:	4b 8b 44 34 18       	mov    0x18(%r12,%r14,1),%rax
    6920:	48 01 05 81 88 00 00 	add    %rax,0x8881(%rip)        # f1a8 <fwp_gc>
    6927:	43 c6 44 34 03 00    	movb   $0x0,0x3(%r12,%r14,1)
    692d:	4b 8d 1c 34          	lea    (%r12,%r14,1),%rbx
    6931:	48 81 c3 28 02 00 00 	add    $0x228,%rbx
    6938:	43 80 bc 34 28 02 00 	cmpb   $0xff,0x228(%r12,%r14,1)
    693f:	00 ff 
    6941:	0f 84 e0 00 00 00    	je     6a27 <fwp_mem_free+0x237>
    6947:	c6 03 00             	movb   $0x0,(%rbx)
    694a:	43 8b 44 34 10       	mov    0x10(%r12,%r14,1),%eax
    694f:	48 85 c0             	test   %rax,%rax
    6952:	0f 84 88 00 00 00    	je     69e0 <fwp_mem_free+0x1f0>
    6958:	48 8b 0d c1 98 00 00 	mov    0x98c1(%rip),%rcx        # 10220 <fwp_gc+0x1078>
    695f:	89 c2                	mov    %eax,%edx
    6961:	83 e2 03             	and    $0x3,%edx
    6964:	83 f8 04             	cmp    $0x4,%eax
    6967:	73 04                	jae    696d <fwp_mem_free+0x17d>
    6969:	31 f6                	xor    %esi,%esi
    696b:	eb 3b                	jmp    69a8 <fwp_mem_free+0x1b8>
    696d:	4a 8d 3c 31          	lea    (%rcx,%r14,1),%rdi
    6971:	41 89 c0             	mov    %eax,%r8d
    6974:	41 83 e0 fc          	and    $0xfffffffc,%r8d
    6978:	31 f6                	xor    %esi,%esi
    697a:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)
    6980:	c6 07 00             	movb   $0x0,(%rdi)
    6983:	c6 87 28 12 00 00 00 	movb   $0x0,0x1228(%rdi)
    698a:	c6 87 50 24 00 00 00 	movb   $0x0,0x2450(%rdi)
    6991:	c6 87 78 36 00 00 00 	movb   $0x0,0x3678(%rdi)
    6998:	48 83 c6 04          	add    $0x4,%rsi
    699c:	48 81 c7 a0 48 00 00 	add    $0x48a0,%rdi
    69a3:	49 39 f0             	cmp    %rsi,%r8
    69a6:	75 d8                	jne    6980 <fwp_mem_free+0x190>
    69a8:	48 85 d2             	test   %rdx,%rdx
    69ab:	74 33                	je     69e0 <fwp_mem_free+0x1f0>
    69ad:	48 69 f6 28 12 00 00 	imul   $0x1228,%rsi,%rsi
    69b4:	4c 01 f6             	add    %r14,%rsi
    69b7:	48 01 f1             	add    %rsi,%rcx
    69ba:	48 69 d2 28 12 00 00 	imul   $0x1228,%rdx,%rdx
    69c1:	31 f6                	xor    %esi,%esi
    69c3:	66 66 66 66 2e 0f 1f 	data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    69ca:	84 00 00 00 00 00 
    69d0:	c6 04 31 00          	movb   $0x0,(%rcx,%rsi,1)
    69d4:	48 81 c6 28 12 00 00 	add    $0x1228,%rsi
    69db:	48 39 f2             	cmp    %rsi,%rdx
    69de:	75 f0                	jne    69d0 <fwp_mem_free+0x1e0>
    69e0:	48 01 05 a1 99 00 00 	add    %rax,0x99a1(%rip)        # 10388 <fwp_gc+0x11e0>
    69e7:	4c 3b 3d 2a 98 00 00 	cmp    0x982a(%rip),%r15        # 10218 <fwp_gc+0x1070>
    69ee:	73 07                	jae    69f7 <fwp_mem_free+0x207>
    69f0:	4c 89 3d 21 98 00 00 	mov    %r15,0x9821(%rip)        # 10218 <fwp_gc+0x1070>
    69f7:	4c 3b 3d 12 98 00 00 	cmp    0x9812(%rip),%r15        # 10210 <fwp_gc+0x1068>
    69fe:	73 07                	jae    6a07 <fwp_mem_free+0x217>
    6a00:	4c 89 3d 09 98 00 00 	mov    %r15,0x9809(%rip)        # 10210 <fwp_gc+0x1068>
    6a07:	5b                   	pop    %rbx
    6a08:	41 5c                	pop    %r12
    6a0a:	41 5d                	pop    %r13
    6a0c:	41 5e                	pop    %r14
    6a0e:	41 5f                	pop    %r15
    6a10:	c3                   	ret
    6a11:	49 89 fc             	mov    %rdi,%r12
    6a14:	48 89 df             	mov    %rbx,%rdi
    6a17:	e8 c4 ce ff ff       	call   38e0 <fwp_rc_forget_slot>
    6a1c:	4c 89 e7             	mov    %r12,%rdi
    6a1f:	41 8b 36             	mov    (%r14),%esi
    6a22:	e9 a1 fe ff ff       	jmp    68c8 <fwp_mem_free+0xd8>
    6a27:	48 89 df             	mov    %rbx,%rdi
    6a2a:	e8 b1 ce ff ff       	call   38e0 <fwp_rc_forget_slot>
    6a2f:	e9 13 ff ff ff       	jmp    6947 <fwp_mem_free+0x157>
    6a34:	66 66 66 2e 0f 1f 84 	data16 data16 cs nopw 0x0(%rax,%rax,1)
    6a3b:	00 00 00 00 00 

0000000000006a40 <fwp_value_release>:
    6a40:	48 89 f8             	mov    %rdi,%rax
    6a43:	48 8b 3f             	mov    (%rdi),%rdi
    6a46:	48 8b 48 08          	mov    0x8(%rax),%rcx
    6a4a:	48 c7 00 00 00 00 00 	movq   $0x0,(%rax)
    6a51:	48 85 c9             	test   %rcx,%rcx
    6a54:	74 07                	je     6a5d <fwp_value_release+0x1d>
    6a56:	48 85 ff             	test   %rdi,%rdi
    6a59:	74 02                	je     6a5d <fwp_value_release+0x1d>
    6a5b:	ff e1                	jmp    *%rcx
    6a5d:	c3                   	ret
    6a5e:	66 90                	xchg   %ax,%ax

0000000000006a60 <fwp_owned_entry2>:
    6a60:	48 83 ec 18          	sub    $0x18,%rsp
    6a64:	48 8b 07             	mov    (%rdi),%rax
    6a67:	f3 0f 6f 47 08       	movdqu 0x8(%rdi),%xmm0
    6a6c:	66 0f 70 c0 4e       	pshufd $0x4e,%xmm0,%xmm0
    6a71:	66 0f 7f 04 24       	movdqa %xmm0,(%rsp)
    6a76:	48 89 e2             	mov    %rsp,%rdx
    6a79:	48 89 c7             	mov    %rax,%rdi
    6a7c:	be 02 00 00 00       	mov    $0x2,%esi
    6a81:	e8 3a e0 ff ff       	call   4ac0 <fwp_apply_owned>
    6a86:	48 83 c4 18          	add    $0x18,%rsp
    6a8a:	c3                   	ret
    6a8b:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)

0000000000006a90 <fwp_caps2>:
    6a90:	85 f6                	test   %esi,%esi
    6a92:	74 0e                	je     6aa2 <fwp_caps2+0x12>
    6a94:	8b 57 04             	mov    0x4(%rdi),%edx
    6a97:	48 83 c7 08          	add    $0x8,%rdi
    6a9b:	31 f6                	xor    %esi,%esi
    6a9d:	e9 ee 00 00 00       	jmp    6b90 <fwp_args2>
    6aa2:	53                   	push   %rbx
    6aa3:	83 7f 04 00          	cmpl   $0x0,0x4(%rdi)
    6aa7:	0f 84 bd 00 00 00    	je     6b6a <fwp_caps2+0xda>
    6aad:	48 8b 47 08          	mov    0x8(%rdi),%rax
    6ab1:	48 89 fb             	mov    %rdi,%rbx
    6ab4:	48 89 c7             	mov    %rax,%rdi
    6ab7:	e8 34 f6 ff ff       	call   60f0 <fwp_closure_drop>
    6abc:	48 89 df             	mov    %rbx,%rdi
    6abf:	83 7b 04 02          	cmpl   $0x2,0x4(%rbx)
    6ac3:	0f 82 a1 00 00 00    	jb     6b6a <fwp_caps2+0xda>
    6ac9:	48 8b 7f 10          	mov    0x10(%rdi),%rdi
    6acd:	e8 1e f6 ff ff       	call   60f0 <fwp_closure_drop>
    6ad2:	48 89 df             	mov    %rbx,%rdi
    6ad5:	83 7b 04 03          	cmpl   $0x3,0x4(%rbx)
    6ad9:	0f 82 8b 00 00 00    	jb     6b6a <fwp_caps2+0xda>
    6adf:	48 8b 47 18          	mov    0x18(%rdi),%rax
    6ae3:	48 89 c1             	mov    %rax,%rcx
    6ae6:	48 2b 0d eb 96 00 00 	sub    0x96eb(%rip),%rcx        # 101d8 <fwp_gc+0x1030>
    6aed:	48 8b 15 0c 97 00 00 	mov    0x970c(%rip),%rdx        # 10200 <fwp_gc+0x1058>
    6af4:	48 c1 e2 10          	shl    $0x10,%rdx
    6af8:	48 39 d1             	cmp    %rdx,%rcx
    6afb:	73 6d                	jae    6b6a <fwp_caps2+0xda>
    6afd:	48 8b 15 1c 97 00 00 	mov    0x971c(%rip),%rdx        # 10220 <fwp_gc+0x1078>
    6b04:	48 89 ce             	mov    %rcx,%rsi
    6b07:	48 c1 ee 10          	shr    $0x10,%rsi
    6b0b:	48 69 f6 28 12 00 00 	imul   $0x1228,%rsi,%rsi
    6b12:	44 0f b6 04 32       	movzbl (%rdx,%rsi,1),%r8d
    6b17:	48 81 e1 ff ff 00 00 	and    $0xffff,%rcx
    6b1e:	75 13                	jne    6b33 <fwp_caps2+0xa3>
    6b20:	41 80 f8 02          	cmp    $0x2,%r8b
    6b24:	75 0d                	jne    6b33 <fwp_caps2+0xa3>
    6b26:	48 8d 0c 32          	lea    (%rdx,%rsi,1),%rcx
    6b2a:	48 81 c1 28 02 00 00 	add    $0x228,%rcx
    6b31:	eb 20                	jmp    6b53 <fwp_caps2+0xc3>
    6b33:	41 80 f8 01          	cmp    $0x1,%r8b
    6b37:	75 31                	jne    6b6a <fwp_caps2+0xda>
    6b39:	4c 8d 04 32          	lea    (%rdx,%rsi,1),%r8
    6b3d:	8b 54 32 20          	mov    0x20(%rdx,%rsi,1),%edx
    6b41:	48 0f af ca          	imul   %rdx,%rcx
    6b45:	48 c1 e9 20          	shr    $0x20,%rcx
    6b49:	4c 01 c1             	add    %r8,%rcx
    6b4c:	48 81 c1 28 02 00 00 	add    $0x228,%rcx
    6b53:	0f b6 11             	movzbl (%rcx),%edx
    6b56:	85 d2                	test   %edx,%edx
    6b58:	74 10                	je     6b6a <fwp_caps2+0xda>
    6b5a:	83 fa 01             	cmp    $0x1,%edx
    6b5d:	75 11                	jne    6b70 <fwp_caps2+0xe0>
    6b5f:	48 89 c7             	mov    %rax,%rdi
    6b62:	e8 a9 fa ff ff       	call   6610 <fwp_rc_free_obj>
    6b67:	48 89 df             	mov    %rbx,%rdi
    6b6a:	5b                   	pop    %rbx
    6b6b:	e9 a0 fa ff ff       	jmp    6610 <fwp_rc_free_obj>
    6b70:	81 fa ff 00 00 00    	cmp    $0xff,%edx
    6b76:	74 0a                	je     6b82 <fwp_caps2+0xf2>
    6b78:	fe ca                	dec    %dl
    6b7a:	88 11                	mov    %dl,(%rcx)
    6b7c:	5b                   	pop    %rbx
    6b7d:	e9 8e fa ff ff       	jmp    6610 <fwp_rc_free_obj>
    6b82:	48 89 cf             	mov    %rcx,%rdi
    6b85:	e8 76 f8 ff ff       	call   6400 <fwp_rc_wide_drop>
    6b8a:	eb db                	jmp    6b67 <fwp_caps2+0xd7>
    6b8c:	0f 1f 40 00          	nopl   0x0(%rax)

0000000000006b90 <fwp_args2>:
    6b90:	55                   	push   %rbp
    6b91:	41 57                	push   %r15
    6b93:	41 56                	push   %r14
    6b95:	53                   	push   %rbx
    6b96:	48 83 ec 38          	sub    $0x38,%rsp
    6b9a:	48 89 7c 24 08       	mov    %rdi,0x8(%rsp)
    6b9f:	48 8d 05 8a 02 00 00 	lea    0x28a(%rip),%rax        # 6e30 <fwp_arg_drop2>
    6ba6:	48 89 44 24 10       	mov    %rax,0x10(%rsp)
    6bab:	89 74 24 18          	mov    %esi,0x18(%rsp)
    6baf:	c7 44 24 1c 00 00 00 	movl   $0x0,0x1c(%rsp)
    6bb6:	00 
    6bb7:	48 8b 05 ba a0 00 00 	mov    0xa0ba(%rip),%rax        # 10c78 <fwp_cleanups>
    6bbe:	48 89 44 24 20       	mov    %rax,0x20(%rsp)
    6bc3:	48 8d 05 66 03 00 00 	lea    0x366(%rip),%rax        # 6f30 <fwp_args_release>
    6bca:	48 89 44 24 28       	mov    %rax,0x28(%rsp)
    6bcf:	48 8d 44 24 08       	lea    0x8(%rsp),%rax
    6bd4:	48 89 44 24 30       	mov    %rax,0x30(%rsp)
    6bd9:	48 8d 5c 24 20       	lea    0x20(%rsp),%rbx
    6bde:	48 89 1d 93 a0 00 00 	mov    %rbx,0xa093(%rip)        # 10c78 <fwp_cleanups>
    6be5:	85 f6                	test   %esi,%esi
    6be7:	75 52                	jne    6c3b <fwp_args2+0xab>
    6be9:	85 d2                	test   %edx,%edx
    6beb:	74 4e                	je     6c3b <fwp_args2+0xab>
    6bed:	48 8b 07             	mov    (%rdi),%rax
    6bf0:	48 2b 05 e1 95 00 00 	sub    0x95e1(%rip),%rax        # 101d8 <fwp_gc+0x1030>
    6bf7:	48 8b 0d 02 96 00 00 	mov    0x9602(%rip),%rcx        # 10200 <fwp_gc+0x1058>
    6bfe:	48 c1 e1 10          	shl    $0x10,%rcx
    6c02:	48 39 c8             	cmp    %rcx,%rax
    6c05:	73 7b                	jae    6c82 <fwp_args2+0xf2>
    6c07:	48 8b 0d 12 96 00 00 	mov    0x9612(%rip),%rcx        # 10220 <fwp_gc+0x1078>
    6c0e:	49 89 c0             	mov    %rax,%r8
    6c11:	49 c1 e8 10          	shr    $0x10,%r8
    6c15:	4d 69 c0 28 12 00 00 	imul   $0x1228,%r8,%r8
    6c1c:	46 0f b6 0c 01       	movzbl (%rcx,%r8,1),%r9d
    6c21:	48 25 ff ff 00 00    	and    $0xffff,%rax
    6c27:	75 25                	jne    6c4e <fwp_args2+0xbe>
    6c29:	41 80 f9 02          	cmp    $0x2,%r9b
    6c2d:	75 1f                	jne    6c4e <fwp_args2+0xbe>
    6c2f:	4a 8d 04 01          	lea    (%rcx,%r8,1),%rax
    6c33:	48 05 28 02 00 00    	add    $0x228,%rax
    6c39:	eb 33                	jmp    6c6e <fwp_args2+0xde>
    6c3b:	83 fe 01             	cmp    $0x1,%esi
    6c3e:	76 4a                	jbe    6c8a <fwp_args2+0xfa>
    6c40:	83 fe 02             	cmp    $0x2,%esi
    6c43:	0f 84 de 00 00 00    	je     6d27 <fwp_args2+0x197>
    6c49:	e9 6f 01 00 00       	jmp    6dbd <fwp_args2+0x22d>
    6c4e:	41 80 f9 01          	cmp    $0x1,%r9b
    6c52:	75 2e                	jne    6c82 <fwp_args2+0xf2>
    6c54:	4e 8d 0c 01          	lea    (%rcx,%r8,1),%r9
    6c58:	42 8b 4c 01 20       	mov    0x20(%rcx,%r8,1),%ecx
    6c5d:	48 0f af c1          	imul   %rcx,%rax
    6c61:	48 c1 e8 20          	shr    $0x20,%rax
    6c65:	4c 01 c8             	add    %r9,%rax
    6c68:	48 05 28 02 00 00    	add    $0x228,%rax
    6c6e:	0f b6 08             	movzbl (%rax),%ecx
    6c71:	84 c9                	test   %cl,%cl
    6c73:	74 0d                	je     6c82 <fwp_args2+0xf2>
    6c75:	80 f9 fe             	cmp    $0xfe,%cl
    6c78:	0f 83 5f 01 00 00    	jae    6ddd <fwp_args2+0x24d>
    6c7e:	fe c1                	inc    %cl
    6c80:	88 08                	mov    %cl,(%rax)
    6c82:	c7 44 24 1c 01 00 00 	movl   $0x1,0x1c(%rsp)
    6c89:	00 
    6c8a:	89 f0                	mov    %esi,%eax
    6c8c:	83 f0 01             	xor    $0x1,%eax
    6c8f:	39 d0                	cmp    %edx,%eax
    6c91:	0f 83 90 00 00 00    	jae    6d27 <fwp_args2+0x197>
    6c97:	89 c0                	mov    %eax,%eax
    6c99:	48 8b 04 c7          	mov    (%rdi,%rax,8),%rax
    6c9d:	48 2b 05 34 95 00 00 	sub    0x9534(%rip),%rax        # 101d8 <fwp_gc+0x1030>
    6ca4:	48 8b 0d 55 95 00 00 	mov    0x9555(%rip),%rcx        # 10200 <fwp_gc+0x1058>
    6cab:	48 c1 e1 10          	shl    $0x10,%rcx
    6caf:	48 39 c8             	cmp    %rcx,%rax
    6cb2:	73 68                	jae    6d1c <fwp_args2+0x18c>
    6cb4:	48 8b 0d 65 95 00 00 	mov    0x9565(%rip),%rcx        # 10220 <fwp_gc+0x1078>
    6cbb:	49 89 c0             	mov    %rax,%r8
    6cbe:	49 c1 e8 10          	shr    $0x10,%r8
    6cc2:	4d 69 c0 28 12 00 00 	imul   $0x1228,%r8,%r8
    6cc9:	46 0f b6 0c 01       	movzbl (%rcx,%r8,1),%r9d
    6cce:	48 25 ff ff 00 00    	and    $0xffff,%rax
    6cd4:	75 12                	jne    6ce8 <fwp_args2+0x158>
    6cd6:	41 80 f9 02          	cmp    $0x2,%r9b
    6cda:	75 0c                	jne    6ce8 <fwp_args2+0x158>
    6cdc:	4a 8d 04 01          	lea    (%rcx,%r8,1),%rax
    6ce0:	48 05 28 02 00 00    	add    $0x228,%rax
    6ce6:	eb 20                	jmp    6d08 <fwp_args2+0x178>
    6ce8:	41 80 f9 01          	cmp    $0x1,%r9b
    6cec:	75 2e                	jne    6d1c <fwp_args2+0x18c>
    6cee:	4e 8d 0c 01          	lea    (%rcx,%r8,1),%r9
    6cf2:	42 8b 4c 01 20       	mov    0x20(%rcx,%r8,1),%ecx
    6cf7:	48 0f af c1          	imul   %rcx,%rax
    6cfb:	48 c1 e8 20          	shr    $0x20,%rax
    6cff:	4c 01 c8             	add    %r9,%rax
    6d02:	48 05 28 02 00 00    	add    $0x228,%rax
    6d08:	0f b6 08             	movzbl (%rax),%ecx
    6d0b:	84 c9                	test   %cl,%cl
    6d0d:	74 0d                	je     6d1c <fwp_args2+0x18c>
    6d0f:	80 f9 fe             	cmp    $0xfe,%cl
    6d12:	0f 83 ed 00 00 00    	jae    6e05 <fwp_args2+0x275>
    6d18:	fe c1                	inc    %cl
    6d1a:	88 08                	mov    %cl,(%rax)
    6d1c:	b8 02 00 00 00       	mov    $0x2,%eax
    6d21:	29 f0                	sub    %esi,%eax
    6d23:	89 44 24 1c          	mov    %eax,0x1c(%rsp)
    6d27:	b8 02 00 00 00       	mov    $0x2,%eax
    6d2c:	29 f0                	sub    %esi,%eax
    6d2e:	39 d0                	cmp    %edx,%eax
    6d30:	0f 83 87 00 00 00    	jae    6dbd <fwp_args2+0x22d>
    6d36:	89 c0                	mov    %eax,%eax
    6d38:	48 8b 04 c7          	mov    (%rdi,%rax,8),%rax
    6d3c:	48 2b 05 95 94 00 00 	sub    0x9495(%rip),%rax        # 101d8 <fwp_gc+0x1030>
    6d43:	48 8b 0d b6 94 00 00 	mov    0x94b6(%rip),%rcx        # 10200 <fwp_gc+0x1058>
    6d4a:	48 c1 e1 10          	shl    $0x10,%rcx
    6d4e:	48 39 c8             	cmp    %rcx,%rax
    6d51:	73 63                	jae    6db6 <fwp_args2+0x226>
    6d53:	48 8b 0d c6 94 00 00 	mov    0x94c6(%rip),%rcx        # 10220 <fwp_gc+0x1078>
    6d5a:	48 89 c2             	mov    %rax,%rdx
    6d5d:	48 c1 ea 10          	shr    $0x10,%rdx
    6d61:	48 69 d2 28 12 00 00 	imul   $0x1228,%rdx,%rdx
    6d68:	0f b6 3c 11          	movzbl (%rcx,%rdx,1),%edi
    6d6c:	48 25 ff ff 00 00    	and    $0xffff,%rax
    6d72:	75 13                	jne    6d87 <fwp_args2+0x1f7>
    6d74:	40 80 ff 02          	cmp    $0x2,%dil
    6d78:	75 0d                	jne    6d87 <fwp_args2+0x1f7>
    6d7a:	48 8d 3c 11          	lea    (%rcx,%rdx,1),%rdi
    6d7e:	48 81 c7 28 02 00 00 	add    $0x228,%rdi
    6d85:	eb 20                	jmp    6da7 <fwp_args2+0x217>
    6d87:	40 80 ff 01          	cmp    $0x1,%dil
    6d8b:	75 29                	jne    6db6 <fwp_args2+0x226>
    6d8d:	48 8d 3c 11          	lea    (%rcx,%rdx,1),%rdi
    6d91:	8b 4c 11 20          	mov    0x20(%rcx,%rdx,1),%ecx
    6d95:	48 0f af c1          	imul   %rcx,%rax
    6d99:	48 c1 e8 20          	shr    $0x20,%rax
    6d9d:	48 01 c7             	add    %rax,%rdi
    6da0:	48 81 c7 28 02 00 00 	add    $0x228,%rdi
    6da7:	0f b6 07             	movzbl (%rdi),%eax
    6daa:	84 c0                	test   %al,%al
    6dac:	74 08                	je     6db6 <fwp_args2+0x226>
    6dae:	3c fe                	cmp    $0xfe,%al
    6db0:	73 48                	jae    6dfa <fwp_args2+0x26a>
    6db2:	fe c0                	inc    %al
    6db4:	88 07                	mov    %al,(%rdi)
    6db6:	83 f6 03             	xor    $0x3,%esi
    6db9:	89 74 24 1c          	mov    %esi,0x1c(%rsp)
    6dbd:	48 39 1d b4 9e 00 00 	cmp    %rbx,0x9eb4(%rip)        # 10c78 <fwp_cleanups>
    6dc4:	75 5c                	jne    6e22 <fwp_args2+0x292>
    6dc6:	48 8b 44 24 20       	mov    0x20(%rsp),%rax
    6dcb:	48 89 05 a6 9e 00 00 	mov    %rax,0x9ea6(%rip)        # 10c78 <fwp_cleanups>
    6dd2:	48 83 c4 38          	add    $0x38,%rsp
    6dd6:	5b                   	pop    %rbx
    6dd7:	41 5e                	pop    %r14
    6dd9:	41 5f                	pop    %r15
    6ddb:	5d                   	pop    %rbp
    6ddc:	c3                   	ret
    6ddd:	49 89 fe             	mov    %rdi,%r14
    6de0:	48 89 c7             	mov    %rax,%rdi
    6de3:	89 f5                	mov    %esi,%ebp
    6de5:	41 89 d7             	mov    %edx,%r15d
    6de8:	e8 a3 f6 ff ff       	call   6490 <fwp_rc_wide_dup>
    6ded:	44 89 fa             	mov    %r15d,%edx
    6df0:	4c 89 f7             	mov    %r14,%rdi
    6df3:	89 ee                	mov    %ebp,%esi
    6df5:	e9 88 fe ff ff       	jmp    6c82 <fwp_args2+0xf2>
    6dfa:	89 f5                	mov    %esi,%ebp
    6dfc:	e8 8f f6 ff ff       	call   6490 <fwp_rc_wide_dup>
    6e01:	89 ee                	mov    %ebp,%esi
    6e03:	eb b1                	jmp    6db6 <fwp_args2+0x226>
    6e05:	49 89 fe             	mov    %rdi,%r14
    6e08:	48 89 c7             	mov    %rax,%rdi
    6e0b:	89 f5                	mov    %esi,%ebp
    6e0d:	41 89 d7             	mov    %edx,%r15d
    6e10:	e8 7b f6 ff ff       	call   6490 <fwp_rc_wide_dup>
    6e15:	44 89 fa             	mov    %r15d,%edx
    6e18:	4c 89 f7             	mov    %r14,%rdi
    6e1b:	89 ee                	mov    %ebp,%esi
    6e1d:	e9 fa fe ff ff       	jmp    6d1c <fwp_args2+0x18c>
    6e22:	e8 39 b2 ff ff       	call   2060 <abort@plt>
    6e27:	66 0f 1f 84 00 00 00 	nopw   0x0(%rax,%rax,1)
    6e2e:	00 00 

0000000000006e30 <fwp_arg_drop2>:
    6e30:	55                   	push   %rbp
    6e31:	41 56                	push   %r14
    6e33:	53                   	push   %rbx
    6e34:	89 d5                	mov    %edx,%ebp
    6e36:	41 89 f6             	mov    %esi,%r14d
    6e39:	48 89 fb             	mov    %rdi,%rbx
    6e3c:	85 f6                	test   %esi,%esi
    6e3e:	75 0e                	jne    6e4e <fwp_arg_drop2+0x1e>
    6e40:	85 ed                	test   %ebp,%ebp
    6e42:	74 0a                	je     6e4e <fwp_arg_drop2+0x1e>
    6e44:	48 8b 3b             	mov    (%rbx),%rdi
    6e47:	e8 a4 f2 ff ff       	call   60f0 <fwp_closure_drop>
    6e4c:	eb 06                	jmp    6e54 <fwp_arg_drop2+0x24>
    6e4e:	41 83 fe 01          	cmp    $0x1,%r14d
    6e52:	77 17                	ja     6e6b <fwp_arg_drop2+0x3b>
    6e54:	44 89 f0             	mov    %r14d,%eax
    6e57:	83 f0 01             	xor    $0x1,%eax
    6e5a:	39 e8                	cmp    %ebp,%eax
    6e5c:	73 17                	jae    6e75 <fwp_arg_drop2+0x45>
    6e5e:	89 c0                	mov    %eax,%eax
    6e60:	48 8b 3c c3          	mov    (%rbx,%rax,8),%rdi
    6e64:	e8 87 f2 ff ff       	call   60f0 <fwp_closure_drop>
    6e69:	eb 0a                	jmp    6e75 <fwp_arg_drop2+0x45>
    6e6b:	41 83 fe 02          	cmp    $0x2,%r14d
    6e6f:	0f 85 a3 00 00 00    	jne    6f18 <fwp_arg_drop2+0xe8>
    6e75:	b8 02 00 00 00       	mov    $0x2,%eax
    6e7a:	44 29 f0             	sub    %r14d,%eax
    6e7d:	39 e8                	cmp    %ebp,%eax
    6e7f:	0f 83 93 00 00 00    	jae    6f18 <fwp_arg_drop2+0xe8>
    6e85:	89 c0                	mov    %eax,%eax
    6e87:	48 8b 3c c3          	mov    (%rbx,%rax,8),%rdi
    6e8b:	48 89 f8             	mov    %rdi,%rax
    6e8e:	48 2b 05 43 93 00 00 	sub    0x9343(%rip),%rax        # 101d8 <fwp_gc+0x1030>
    6e95:	48 8b 0d 64 93 00 00 	mov    0x9364(%rip),%rcx        # 10200 <fwp_gc+0x1058>
    6e9c:	48 c1 e1 10          	shl    $0x10,%rcx
    6ea0:	48 39 c8             	cmp    %rcx,%rax
    6ea3:	73 73                	jae    6f18 <fwp_arg_drop2+0xe8>
    6ea5:	48 8b 0d 74 93 00 00 	mov    0x9374(%rip),%rcx        # 10220 <fwp_gc+0x1078>
    6eac:	48 89 c2             	mov    %rax,%rdx
    6eaf:	48 c1 ea 10          	shr    $0x10,%rdx
    6eb3:	48 69 d2 28 12 00 00 	imul   $0x1228,%rdx,%rdx
    6eba:	0f b6 34 11          	movzbl (%rcx,%rdx,1),%esi
    6ebe:	48 25 ff ff 00 00    	and    $0xffff,%rax
    6ec4:	75 12                	jne    6ed8 <fwp_arg_drop2+0xa8>
    6ec6:	40 80 fe 02          	cmp    $0x2,%sil
    6eca:	75 0c                	jne    6ed8 <fwp_arg_drop2+0xa8>
    6ecc:	48 8d 04 11          	lea    (%rcx,%rdx,1),%rax
    6ed0:	48 05 28 02 00 00    	add    $0x228,%rax
    6ed6:	eb 1f                	jmp    6ef7 <fwp_arg_drop2+0xc7>
    6ed8:	40 80 fe 01          	cmp    $0x1,%sil
    6edc:	75 3a                	jne    6f18 <fwp_arg_drop2+0xe8>
    6ede:	48 8d 34 11          	lea    (%rcx,%rdx,1),%rsi
    6ee2:	8b 4c 11 20          	mov    0x20(%rcx,%rdx,1),%ecx
    6ee6:	48 0f af c1          	imul   %rcx,%rax
    6eea:	48 c1 e8 20          	shr    $0x20,%rax
    6eee:	48 01 f0             	add    %rsi,%rax
    6ef1:	48 05 28 02 00 00    	add    $0x228,%rax
    6ef7:	0f b6 08             	movzbl (%rax),%ecx
    6efa:	85 c9                	test   %ecx,%ecx
    6efc:	74 1a                	je     6f18 <fwp_arg_drop2+0xe8>
    6efe:	83 f9 01             	cmp    $0x1,%ecx
    6f01:	75 09                	jne    6f0c <fwp_arg_drop2+0xdc>
    6f03:	5b                   	pop    %rbx
    6f04:	41 5e                	pop    %r14
    6f06:	5d                   	pop    %rbp
    6f07:	e9 04 f7 ff ff       	jmp    6610 <fwp_rc_free_obj>
    6f0c:	81 f9 ff 00 00 00    	cmp    $0xff,%ecx
    6f12:	74 09                	je     6f1d <fwp_arg_drop2+0xed>
    6f14:	fe c9                	dec    %cl
    6f16:	88 08                	mov    %cl,(%rax)
    6f18:	5b                   	pop    %rbx
    6f19:	41 5e                	pop    %r14
    6f1b:	5d                   	pop    %rbp
    6f1c:	c3                   	ret
    6f1d:	48 89 c7             	mov    %rax,%rdi
    6f20:	5b                   	pop    %rbx
    6f21:	41 5e                	pop    %r14
    6f23:	5d                   	pop    %rbp
    6f24:	e9 d7 f4 ff ff       	jmp    6400 <fwp_rc_wide_drop>
    6f29:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)

0000000000006f30 <fwp_args_release>:
    6f30:	8b 57 14             	mov    0x14(%rdi),%edx
    6f33:	c7 47 14 00 00 00 00 	movl   $0x0,0x14(%rdi)
    6f3a:	85 d2                	test   %edx,%edx
    6f3c:	74 0f                	je     6f4d <fwp_args_release+0x1d>
    6f3e:	48 8b 07             	mov    (%rdi),%rax
    6f41:	48 8b 4f 08          	mov    0x8(%rdi),%rcx
    6f45:	8b 77 10             	mov    0x10(%rdi),%esi
    6f48:	48 89 c7             	mov    %rax,%rdi
    6f4b:	ff e1                	jmp    *%rcx
    6f4d:	c3                   	ret
    6f4e:	66 90                	xchg   %ax,%ax

0000000000006f50 <fwp_p_file_with_owned>:
    6f50:	55                   	push   %rbp
    6f51:	41 57                	push   %r15
    6f53:	41 56                	push   %r14
    6f55:	41 55                	push   %r13
    6f57:	41 54                	push   %r12
    6f59:	53                   	push   %rbx
    6f5a:	48 81 ec 78 04 00 00 	sub    $0x478,%rsp
    6f61:	48 89 74 24 48       	mov    %rsi,0x48(%rsp)
    6f66:	48 89 7c 24 40       	mov    %rdi,0x40(%rsp)
    6f6b:	4c 8d 7f 08          	lea    0x8(%rdi),%r15
    6f6f:	48 8d 35 93 55 00 00 	lea    0x5593(%rip),%rsi        # c509 <fwp_segv.msg+0x2c9>
    6f76:	4c 89 ff             	mov    %r15,%rdi
    6f79:	e8 12 b3 ff ff       	call   2290 <fopen@plt>
    6f7e:	48 89 c3             	mov    %rax,%rbx
    6f81:	48 85 c0             	test   %rax,%rax
    6f84:	75 1b                	jne    6fa1 <fwp_p_file_with_owned+0x51>
    6f86:	48 8d 35 80 55 00 00 	lea    0x5580(%rip),%rsi        # c50d <fwp_segv.msg+0x2cd>
    6f8d:	4c 89 ff             	mov    %r15,%rdi
    6f90:	e8 fb b2 ff ff       	call   2290 <fopen@plt>
    6f95:	48 89 c3             	mov    %rax,%rbx
    6f98:	48 85 c0             	test   %rax,%rax
    6f9b:	0f 84 13 04 00 00    	je     73b4 <fwp_p_file_with_owned+0x464>
    6fa1:	48 89 5c 24 18       	mov    %rbx,0x18(%rsp)
    6fa6:	48 c7 44 24 20 00 00 	movq   $0x0,0x20(%rsp)
    6fad:	00 00 
    6faf:	48 8b 05 c2 9c 00 00 	mov    0x9cc2(%rip),%rax        # 10c78 <fwp_cleanups>
    6fb6:	48 89 44 24 70       	mov    %rax,0x70(%rsp)
    6fbb:	4c 8d 25 7e 05 00 00 	lea    0x57e(%rip),%r12        # 7540 <fwp_close_owned_scoped_file>
    6fc2:	4c 89 64 24 78       	mov    %r12,0x78(%rsp)
    6fc7:	48 8d 44 24 18       	lea    0x18(%rsp),%rax
    6fcc:	48 89 84 24 80 00 00 	mov    %rax,0x80(%rsp)
    6fd3:	00 
    6fd4:	48 8d 44 24 70       	lea    0x70(%rsp),%rax
    6fd9:	48 89 05 98 9c 00 00 	mov    %rax,0x9c98(%rip)        # 10c78 <fwp_cleanups>
    6fe0:	4c 89 ff             	mov    %r15,%rdi
    6fe3:	e8 28 b1 ff ff       	call   2110 <strlen@plt>
    6fe8:	48 83 f8 ef          	cmp    $0xffffffffffffffef,%rax
    6fec:	0f 83 70 03 00 00    	jae    7362 <fwp_p_file_with_owned+0x412>
    6ff2:	49 89 c5             	mov    %rax,%r13
    6ff5:	48 8d 50 11          	lea    0x11(%rax),%rdx
    6ff9:	48 3d ef 3f 00 00    	cmp    $0x3fef,%rax
    6fff:	77 63                	ja     7064 <fwp_p_file_with_owned+0x114>
    7001:	49 8d 4d 20          	lea    0x20(%r13),%rcx
    7005:	48 c1 e9 04          	shr    $0x4,%rcx
    7009:	48 8d 05 98 81 00 00 	lea    0x8198(%rip),%rax        # f1a8 <fwp_gc>
    7010:	0f b6 8c 01 e8 0b 00 	movzbl 0xbe8(%rcx,%rax,1),%ecx
    7017:	00 
    7018:	89 ce                	mov    %ecx,%esi
    701a:	8b 8c b0 48 0b 00 00 	mov    0xb48(%rax,%rsi,4),%ecx
    7021:	48 29 0d 80 81 00 00 	sub    %rcx,0x8180(%rip)        # f1a8 <fwp_gc>
    7028:	78 3a                	js     7064 <fwp_p_file_with_owned+0x114>
    702a:	48 8d 34 76          	lea    (%rsi,%rsi,2),%rsi
    702e:	48 8d 3c f0          	lea    (%rax,%rsi,8),%rdi
    7032:	48 81 c7 c8 03 00 00 	add    $0x3c8,%rdi
    7039:	4c 8b 37             	mov    (%rdi),%r14
    703c:	4d 85 f6             	test   %r14,%r14
    703f:	74 0b                	je     704c <fwp_p_file_with_owned+0xfc>
    7041:	49 8b 06             	mov    (%r14),%rax
    7044:	48 f7 d0             	not    %rax
    7047:	48 89 07             	mov    %rax,(%rdi)
    704a:	eb 3a                	jmp    7086 <fwp_p_file_with_owned+0x136>
    704c:	4c 8b b4 f0 d0 03 00 	mov    0x3d0(%rax,%rsi,8),%r14
    7053:	00 
    7054:	48 8b bc f0 d8 03 00 	mov    0x3d8(%rax,%rsi,8),%rdi
    705b:	00 
    705c:	4c 29 f7             	sub    %r14,%rdi
    705f:	48 39 cf             	cmp    %rcx,%rdi
    7062:	73 12                	jae    7076 <fwp_p_file_with_owned+0x126>
    7064:	48 89 d7             	mov    %rdx,%rdi
    7067:	be 01 00 00 00       	mov    $0x1,%esi
    706c:	e8 ff e4 ff ff       	call   5570 <fwp_gc_alloc_slow>
    7071:	49 89 c6             	mov    %rax,%r14
    7074:	eb 1a                	jmp    7090 <fwp_p_file_with_owned+0x140>
    7076:	48 8d 04 f0          	lea    (%rax,%rsi,8),%rax
    707a:	48 05 d0 03 00 00    	add    $0x3d0,%rax
    7080:	4c 01 f1             	add    %r14,%rcx
    7083:	48 89 08             	mov    %rcx,(%rax)
    7086:	4c 89 f7             	mov    %r14,%rdi
    7089:	31 f6                	xor    %esi,%esi
    708b:	e8 d0 b0 ff ff       	call   2160 <memset@plt>
    7090:	49 89 1e             	mov    %rbx,(%r14)
    7093:	49 c7 46 08 01 00 00 	movq   $0x1,0x8(%r14)
    709a:	00 
    709b:	4c 89 f2             	mov    %r14,%rdx
    709e:	48 2b 15 33 91 00 00 	sub    0x9133(%rip),%rdx        # 101d8 <fwp_gc+0x1030>
    70a5:	48 8b 05 54 91 00 00 	mov    0x9154(%rip),%rax        # 10200 <fwp_gc+0x1058>
    70ac:	48 c1 e0 10          	shl    $0x10,%rax
    70b0:	48 39 c2             	cmp    %rax,%rdx
    70b3:	73 70                	jae    7125 <fwp_p_file_with_owned+0x1d5>
    70b5:	48 8b 05 64 91 00 00 	mov    0x9164(%rip),%rax        # 10220 <fwp_gc+0x1078>
    70bc:	48 89 d1             	mov    %rdx,%rcx
    70bf:	48 c1 e9 10          	shr    $0x10,%rcx
    70c3:	48 69 c9 28 12 00 00 	imul   $0x1228,%rcx,%rcx
    70ca:	0f b6 34 08          	movzbl (%rax,%rcx,1),%esi
    70ce:	48 81 e2 ff ff 00 00 	and    $0xffff,%rdx
    70d5:	75 1d                	jne    70f4 <fwp_p_file_with_owned+0x1a4>
    70d7:	40 80 fe 02          	cmp    $0x2,%sil
    70db:	75 17                	jne    70f4 <fwp_p_file_with_owned+0x1a4>
    70dd:	48 8d 2c 08          	lea    (%rax,%rcx,1),%rbp
    70e1:	48 81 c5 28 02 00 00 	add    $0x228,%rbp
    70e8:	80 7d 00 ff          	cmpb   $0xff,0x0(%rbp)
    70ec:	74 2d                	je     711b <fwp_p_file_with_owned+0x1cb>
    70ee:	c6 45 00 01          	movb   $0x1,0x0(%rbp)
    70f2:	eb 31                	jmp    7125 <fwp_p_file_with_owned+0x1d5>
    70f4:	40 80 fe 01          	cmp    $0x1,%sil
    70f8:	75 2b                	jne    7125 <fwp_p_file_with_owned+0x1d5>
    70fa:	48 8d 34 08          	lea    (%rax,%rcx,1),%rsi
    70fe:	8b 44 08 20          	mov    0x20(%rax,%rcx,1),%eax
    7102:	48 0f af d0          	imul   %rax,%rdx
    7106:	48 c1 ea 20          	shr    $0x20,%rdx
    710a:	48 8d 2c 32          	lea    (%rdx,%rsi,1),%rbp
    710e:	48 81 c5 28 02 00 00 	add    $0x228,%rbp
    7115:	80 7d 00 ff          	cmpb   $0xff,0x0(%rbp)
    7119:	75 d3                	jne    70ee <fwp_p_file_with_owned+0x19e>
    711b:	48 89 ef             	mov    %rbp,%rdi
    711e:	e8 bd c7 ff ff       	call   38e0 <fwp_rc_forget_slot>
    7123:	eb c9                	jmp    70ee <fwp_p_file_with_owned+0x19e>
    7125:	4c 89 74 24 20       	mov    %r14,0x20(%rsp)
    712a:	49 8d 7e 10          	lea    0x10(%r14),%rdi
    712e:	49 ff c5             	inc    %r13
    7131:	4c 89 fe             	mov    %r15,%rsi
    7134:	4c 89 ea             	mov    %r13,%rdx
    7137:	e8 d4 b0 ff ff       	call   2210 <memcpy@plt>
    713c:	48 8d 7c 24 70       	lea    0x70(%rsp),%rdi
    7141:	48 39 3d 30 9b 00 00 	cmp    %rdi,0x9b30(%rip)        # 10c78 <fwp_cleanups>
    7148:	0f 85 0f 02 00 00    	jne    735d <fwp_p_file_with_owned+0x40d>
    714e:	48 8b 44 24 70       	mov    0x70(%rsp),%rax
    7153:	4c 89 74 24 50       	mov    %r14,0x50(%rsp)
    7158:	48 89 5c 24 08       	mov    %rbx,0x8(%rsp)
    715d:	4c 89 74 24 10       	mov    %r14,0x10(%rsp)
    7162:	48 89 44 24 18       	mov    %rax,0x18(%rsp)
    7167:	4c 89 64 24 20       	mov    %r12,0x20(%rsp)
    716c:	48 8d 4c 24 08       	lea    0x8(%rsp),%rcx
    7171:	48 89 4c 24 28       	mov    %rcx,0x28(%rsp)
    7176:	4c 8d 6c 24 18       	lea    0x18(%rsp),%r13
    717b:	4c 89 2d f6 9a 00 00 	mov    %r13,0x9af6(%rip)        # 10c78 <fwp_cleanups>
    7182:	48 8b 0d f7 9a 00 00 	mov    0x9af7(%rip),%rcx        # 10c80 <fwp_handlers>
    7189:	48 89 8c 24 38 01 00 	mov    %rcx,0x138(%rsp)
    7190:	00 
    7191:	48 8b 0d f0 9a 00 00 	mov    0x9af0(%rip),%rcx        # 10c88 <fwp_state_len>
    7198:	48 89 8c 24 50 01 00 	mov    %rcx,0x150(%rsp)
    719f:	00 
    71a0:	48 89 84 24 58 01 00 	mov    %rax,0x158(%rsp)
    71a7:	00 
    71a8:	48 89 3d d1 9a 00 00 	mov    %rdi,0x9ad1(%rip)        # 10c80 <fwp_handlers>
    71af:	e8 ec af ff ff       	call   21a0 <_setjmp@plt>
    71b4:	85 c0                	test   %eax,%eax
    71b6:	0f 85 d4 01 00 00    	jne    7390 <fwp_p_file_with_owned+0x440>
    71bc:	48 8d 74 24 50       	lea    0x50(%rsp),%rsi
    71c1:	4c 8b 64 24 48       	mov    0x48(%rsp),%r12
    71c6:	4c 89 e7             	mov    %r12,%rdi
    71c9:	e8 22 cc ff ff       	call   3df0 <fwp_apply_borrowed>
    71ce:	48 8b 8c 24 38 01 00 	mov    0x138(%rsp),%rcx
    71d5:	00 
    71d6:	48 89 0d a3 9a 00 00 	mov    %rcx,0x9aa3(%rip)        # 10c80 <fwp_handlers>
    71dd:	48 89 44 24 30       	mov    %rax,0x30(%rsp)
    71e2:	48 8d 0d 07 02 00 00 	lea    0x207(%rip),%rcx        # 73f0 <fwp_drop5>
    71e9:	48 89 4c 24 38       	mov    %rcx,0x38(%rsp)
    71ee:	48 8b 0d 83 9a 00 00 	mov    0x9a83(%rip),%rcx        # 10c78 <fwp_cleanups>
    71f5:	48 89 4c 24 58       	mov    %rcx,0x58(%rsp)
    71fa:	48 8d 0d 3f f8 ff ff 	lea    -0x7c1(%rip),%rcx        # 6a40 <fwp_value_release>
    7201:	48 89 4c 24 60       	mov    %rcx,0x60(%rsp)
    7206:	48 8d 4c 24 30       	lea    0x30(%rsp),%rcx
    720b:	48 89 4c 24 68       	mov    %rcx,0x68(%rsp)
    7210:	48 8d 5c 24 58       	lea    0x58(%rsp),%rbx
    7215:	48 89 1d 5c 9a 00 00 	mov    %rbx,0x9a5c(%rip)        # 10c78 <fwp_cleanups>
    721c:	4c 8b 78 08          	mov    0x8(%rax),%r15
    7220:	4c 89 fe             	mov    %r15,%rsi
    7223:	48 2b 35 ae 8f 00 00 	sub    0x8fae(%rip),%rsi        # 101d8 <fwp_gc+0x1030>
    722a:	48 8b 0d cf 8f 00 00 	mov    0x8fcf(%rip),%rcx        # 10200 <fwp_gc+0x1058>
    7231:	48 c1 e1 10          	shl    $0x10,%rcx
    7235:	48 39 ce             	cmp    %rcx,%rsi
    7238:	73 69                	jae    72a3 <fwp_p_file_with_owned+0x353>
    723a:	48 8b 0d df 8f 00 00 	mov    0x8fdf(%rip),%rcx        # 10220 <fwp_gc+0x1078>
    7241:	48 89 f2             	mov    %rsi,%rdx
    7244:	48 c1 ea 10          	shr    $0x10,%rdx
    7248:	48 69 d2 28 12 00 00 	imul   $0x1228,%rdx,%rdx
    724f:	0f b6 3c 11          	movzbl (%rcx,%rdx,1),%edi
    7253:	48 81 e6 ff ff 00 00 	and    $0xffff,%rsi
    725a:	75 13                	jne    726f <fwp_p_file_with_owned+0x31f>
    725c:	40 80 ff 02          	cmp    $0x2,%dil
    7260:	75 0d                	jne    726f <fwp_p_file_with_owned+0x31f>
    7262:	48 8d 3c 11          	lea    (%rcx,%rdx,1),%rdi
    7266:	48 81 c7 28 02 00 00 	add    $0x228,%rdi
    726d:	eb 20                	jmp    728f <fwp_p_file_with_owned+0x33f>
    726f:	40 80 ff 01          	cmp    $0x1,%dil
    7273:	75 2e                	jne    72a3 <fwp_p_file_with_owned+0x353>
    7275:	48 8d 3c 11          	lea    (%rcx,%rdx,1),%rdi
    7279:	8b 4c 11 20          	mov    0x20(%rcx,%rdx,1),%ecx
    727d:	48 0f af f1          	imul   %rcx,%rsi
    7281:	48 c1 ee 20          	shr    $0x20,%rsi
    7285:	48 01 f7             	add    %rsi,%rdi
    7288:	48 81 c7 28 02 00 00 	add    $0x228,%rdi
    728f:	0f b6 0f             	movzbl (%rdi),%ecx
    7292:	84 c9                	test   %cl,%cl
    7294:	74 0d                	je     72a3 <fwp_p_file_with_owned+0x353>
    7296:	80 f9 fe             	cmp    $0xfe,%cl
    7299:	0f 83 a2 00 00 00    	jae    7341 <fwp_p_file_with_owned+0x3f1>
    729f:	fe c1                	inc    %cl
    72a1:	88 0f                	mov    %cl,(%rdi)
    72a3:	48 83 7c 24 38 00    	cmpq   $0x0,0x38(%rsp)
    72a9:	74 19                	je     72c4 <fwp_p_file_with_owned+0x374>
    72ab:	48 39 1d c6 99 00 00 	cmp    %rbx,0x99c6(%rip)        # 10c78 <fwp_cleanups>
    72b2:	0f 85 a5 00 00 00    	jne    735d <fwp_p_file_with_owned+0x40d>
    72b8:	48 8b 4c 24 58       	mov    0x58(%rsp),%rcx
    72bd:	48 89 0d b4 99 00 00 	mov    %rcx,0x99b4(%rip)        # 10c78 <fwp_cleanups>
    72c4:	48 89 c7             	mov    %rax,%rdi
    72c7:	48 c7 44 24 30 00 00 	movq   $0x0,0x30(%rsp)
    72ce:	00 00 
    72d0:	e8 1b 01 00 00       	call   73f0 <fwp_drop5>
    72d5:	4c 39 2d 9c 99 00 00 	cmp    %r13,0x999c(%rip)        # 10c78 <fwp_cleanups>
    72dc:	75 7f                	jne    735d <fwp_p_file_with_owned+0x40d>
    72de:	48 8b 44 24 18       	mov    0x18(%rsp),%rax
    72e3:	48 89 05 8e 99 00 00 	mov    %rax,0x998e(%rip)        # 10c78 <fwp_cleanups>
    72ea:	48 8b 5c 24 10       	mov    0x10(%rsp),%rbx
    72ef:	48 85 db             	test   %rbx,%rbx
    72f2:	74 16                	je     730a <fwp_p_file_with_owned+0x3ba>
    72f4:	48 8b 3b             	mov    (%rbx),%rdi
    72f7:	48 85 ff             	test   %rdi,%rdi
    72fa:	74 18                	je     7314 <fwp_p_file_with_owned+0x3c4>
    72fc:	e8 ff ad ff ff       	call   2100 <fclose@plt>
    7301:	48 c7 03 00 00 00 00 	movq   $0x0,(%rbx)
    7308:	eb 0a                	jmp    7314 <fwp_p_file_with_owned+0x3c4>
    730a:	48 8b 7c 24 08       	mov    0x8(%rsp),%rdi
    730f:	e8 ec ad ff ff       	call   2100 <fclose@plt>
    7314:	48 8b 7c 24 10       	mov    0x10(%rsp),%rdi
    7319:	48 c7 44 24 10 00 00 	movq   $0x0,0x10(%rsp)
    7320:	00 00 
    7322:	e8 b9 04 00 00       	call   77e0 <fwp_file_drop>
    7327:	48 8b 44 24 40       	mov    0x40(%rsp),%rax
    732c:	4c 89 f8             	mov    %r15,%rax
    732f:	48 81 c4 78 04 00 00 	add    $0x478,%rsp
    7336:	5b                   	pop    %rbx
    7337:	41 5c                	pop    %r12
    7339:	41 5d                	pop    %r13
    733b:	41 5e                	pop    %r14
    733d:	41 5f                	pop    %r15
    733f:	5d                   	pop    %rbp
    7340:	c3                   	ret
    7341:	49 89 c6             	mov    %rax,%r14
    7344:	e8 47 f1 ff ff       	call   6490 <fwp_rc_wide_dup>
    7349:	4c 89 f0             	mov    %r14,%rax
    734c:	48 83 7c 24 38 00    	cmpq   $0x0,0x38(%rsp)
    7352:	0f 85 53 ff ff ff    	jne    72ab <fwp_p_file_with_owned+0x35b>
    7358:	e9 67 ff ff ff       	jmp    72c4 <fwp_p_file_with_owned+0x374>
    735d:	e8 fe ac ff ff       	call   2060 <abort@plt>
    7362:	e8 49 c5 ff ff       	call   38b0 <fwp_flush>
    7367:	48 8b 05 72 7c 00 00 	mov    0x7c72(%rip),%rax        # efe0 <stderr@GLIBC_2.2.5>
    736e:	48 8b 38             	mov    (%rax),%rdi
    7371:	48 8d 35 bc 4f 00 00 	lea    0x4fbc(%rip),%rsi        # c334 <fwp_segv.msg+0xf4>
    7378:	48 8d 15 9e 51 00 00 	lea    0x519e(%rip),%rdx        # c51d <fwp_segv.msg+0x2dd>
    737f:	31 c0                	xor    %eax,%eax
    7381:	e8 5a ae ff ff       	call   21e0 <fprintf@plt>
    7386:	bf 65 00 00 00       	mov    $0x65,%edi
    738b:	e8 40 af ff ff       	call   22d0 <exit@plt>
    7390:	48 8b 84 24 38 01 00 	mov    0x138(%rsp),%rax
    7397:	00 
    7398:	48 8b bc 24 40 01 00 	mov    0x140(%rsp),%rdi
    739f:	00 
    73a0:	48 89 05 d9 98 00 00 	mov    %rax,0x98d9(%rip)        # 10c80 <fwp_handlers>
    73a7:	48 8b b4 24 48 01 00 	mov    0x148(%rsp),%rsi
    73ae:	00 
    73af:	e8 dc 01 00 00       	call   7590 <fwp_fail>
    73b4:	e8 b7 ac ff ff       	call   2070 <__errno_location@plt>
    73b9:	8b 38                	mov    (%rax),%edi
    73bb:	e8 60 af ff ff       	call   2320 <strerror@plt>
    73c0:	49 89 c0             	mov    %rax,%r8
    73c3:	48 8d 15 4c 51 00 00 	lea    0x514c(%rip),%rdx        # c516 <fwp_segv.msg+0x2d6>
    73ca:	31 c0                	xor    %eax,%eax
    73cc:	48 8d 5c 24 70       	lea    0x70(%rsp),%rbx
    73d1:	be 00 04 00 00       	mov    $0x400,%esi
    73d6:	48 89 df             	mov    %rbx,%rdi
    73d9:	4c 89 f9             	mov    %r15,%rcx
    73dc:	e8 5f ad ff ff       	call   2140 <snprintf@plt>
    73e1:	48 8d 3d 29 51 00 00 	lea    0x5129(%rip),%rdi        # c511 <fwp_segv.msg+0x2d1>
    73e8:	48 89 de             	mov    %rbx,%rsi
    73eb:	e8 30 02 00 00       	call   7620 <fwp_io_error>

00000000000073f0 <fwp_drop5>:
    73f0:	48 8b 15 e1 8d 00 00 	mov    0x8de1(%rip),%rdx        # 101d8 <fwp_gc+0x1030>
    73f7:	48 89 f8             	mov    %rdi,%rax
    73fa:	48 29 d0             	sub    %rdx,%rax
    73fd:	48 8b 35 fc 8d 00 00 	mov    0x8dfc(%rip),%rsi        # 10200 <fwp_gc+0x1058>
    7404:	48 c1 e6 10          	shl    $0x10,%rsi
    7408:	48 39 f0             	cmp    %rsi,%rax
    740b:	0f 83 b3 00 00 00    	jae    74c4 <fwp_drop5+0xd4>
    7411:	48 8b 0d 08 8e 00 00 	mov    0x8e08(%rip),%rcx        # 10220 <fwp_gc+0x1078>
    7418:	49 89 c0             	mov    %rax,%r8
    741b:	49 c1 e8 10          	shr    $0x10,%r8
    741f:	4d 69 c0 28 12 00 00 	imul   $0x1228,%r8,%r8
    7426:	46 0f b6 0c 01       	movzbl (%rcx,%r8,1),%r9d
    742b:	48 25 ff ff 00 00    	and    $0xffff,%rax
    7431:	75 12                	jne    7445 <fwp_drop5+0x55>
    7433:	41 80 f9 02          	cmp    $0x2,%r9b
    7437:	75 0c                	jne    7445 <fwp_drop5+0x55>
    7439:	4a 8d 04 01          	lea    (%rcx,%r8,1),%rax
    743d:	48 05 28 02 00 00    	add    $0x228,%rax
    7443:	eb 20                	jmp    7465 <fwp_drop5+0x75>
    7445:	41 80 f9 01          	cmp    $0x1,%r9b
    7449:	75 79                	jne    74c4 <fwp_drop5+0xd4>
    744b:	4e 8d 0c 01          	lea    (%rcx,%r8,1),%r9
    744f:	46 8b 44 01 20       	mov    0x20(%rcx,%r8,1),%r8d
    7454:	49 0f af c0          	imul   %r8,%rax
    7458:	48 c1 e8 20          	shr    $0x20,%rax
    745c:	4c 01 c8             	add    %r9,%rax
    745f:	48 05 28 02 00 00    	add    $0x228,%rax
    7465:	44 0f b6 00          	movzbl (%rax),%r8d
    7469:	45 85 c0             	test   %r8d,%r8d
    746c:	74 56                	je     74c4 <fwp_drop5+0xd4>
    746e:	41 83 f8 01          	cmp    $0x1,%r8d
    7472:	75 41                	jne    74b5 <fwp_drop5+0xc5>
    7474:	53                   	push   %rbx
    7475:	48 8b 47 08          	mov    0x8(%rdi),%rax
    7479:	49 89 c0             	mov    %rax,%r8
    747c:	49 29 d0             	sub    %rdx,%r8
    747f:	49 39 f0             	cmp    %rsi,%r8
    7482:	0f 83 86 00 00 00    	jae    750e <fwp_drop5+0x11e>
    7488:	4c 89 c2             	mov    %r8,%rdx
    748b:	48 c1 ea 10          	shr    $0x10,%rdx
    748f:	48 69 d2 28 12 00 00 	imul   $0x1228,%rdx,%rdx
    7496:	0f b6 34 11          	movzbl (%rcx,%rdx,1),%esi
    749a:	49 81 e0 ff ff 00 00 	and    $0xffff,%r8
    74a1:	75 22                	jne    74c5 <fwp_drop5+0xd5>
    74a3:	40 80 fe 02          	cmp    $0x2,%sil
    74a7:	75 1c                	jne    74c5 <fwp_drop5+0xd5>
    74a9:	48 01 d1             	add    %rdx,%rcx
    74ac:	48 81 c1 28 02 00 00 	add    $0x228,%rcx
    74b3:	eb 31                	jmp    74e6 <fwp_drop5+0xf6>
    74b5:	41 81 f8 ff 00 00 00 	cmp    $0xff,%r8d
    74bc:	74 68                	je     7526 <fwp_drop5+0x136>
    74be:	41 fe c8             	dec    %r8b
    74c1:	44 88 00             	mov    %r8b,(%rax)
    74c4:	c3                   	ret
    74c5:	40 80 fe 01          	cmp    $0x1,%sil
    74c9:	75 43                	jne    750e <fwp_drop5+0x11e>
    74cb:	48 8d 34 11          	lea    (%rcx,%rdx,1),%rsi
    74cf:	8b 4c 11 20          	mov    0x20(%rcx,%rdx,1),%ecx
    74d3:	4c 0f af c1          	imul   %rcx,%r8
    74d7:	49 c1 e8 20          	shr    $0x20,%r8
    74db:	49 8d 0c 30          	lea    (%r8,%rsi,1),%rcx
    74df:	48 81 c1 28 02 00 00 	add    $0x228,%rcx
    74e6:	0f b6 11             	movzbl (%rcx),%edx
    74e9:	85 d2                	test   %edx,%edx
    74eb:	74 21                	je     750e <fwp_drop5+0x11e>
    74ed:	83 fa 01             	cmp    $0x1,%edx
    74f0:	75 10                	jne    7502 <fwp_drop5+0x112>
    74f2:	48 89 fb             	mov    %rdi,%rbx
    74f5:	48 89 c7             	mov    %rax,%rdi
    74f8:	e8 13 f1 ff ff       	call   6610 <fwp_rc_free_obj>
    74fd:	48 89 df             	mov    %rbx,%rdi
    7500:	eb 0c                	jmp    750e <fwp_drop5+0x11e>
    7502:	81 fa ff 00 00 00    	cmp    $0xff,%edx
    7508:	74 24                	je     752e <fwp_drop5+0x13e>
    750a:	fe ca                	dec    %dl
    750c:	88 11                	mov    %dl,(%rcx)
    750e:	48 8b 47 10          	mov    0x10(%rdi),%rax
    7512:	48 89 fb             	mov    %rdi,%rbx
    7515:	48 89 c7             	mov    %rax,%rdi
    7518:	e8 c3 02 00 00       	call   77e0 <fwp_file_drop>
    751d:	48 89 df             	mov    %rbx,%rdi
    7520:	5b                   	pop    %rbx
    7521:	e9 ea f0 ff ff       	jmp    6610 <fwp_rc_free_obj>
    7526:	48 89 c7             	mov    %rax,%rdi
    7529:	e9 d2 ee ff ff       	jmp    6400 <fwp_rc_wide_drop>
    752e:	48 89 fb             	mov    %rdi,%rbx
    7531:	48 89 cf             	mov    %rcx,%rdi
    7534:	e8 c7 ee ff ff       	call   6400 <fwp_rc_wide_drop>
    7539:	eb c2                	jmp    74fd <fwp_drop5+0x10d>
    753b:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)

0000000000007540 <fwp_close_owned_scoped_file>:
    7540:	41 56                	push   %r14
    7542:	53                   	push   %rbx
    7543:	50                   	push   %rax
    7544:	48 89 fb             	mov    %rdi,%rbx
    7547:	4c 8b 77 08          	mov    0x8(%rdi),%r14
    754b:	4d 85 f6             	test   %r14,%r14
    754e:	74 16                	je     7566 <fwp_close_owned_scoped_file+0x26>
    7550:	49 8b 3e             	mov    (%r14),%rdi
    7553:	48 85 ff             	test   %rdi,%rdi
    7556:	74 16                	je     756e <fwp_close_owned_scoped_file+0x2e>
    7558:	e8 a3 ab ff ff       	call   2100 <fclose@plt>
    755d:	49 c7 06 00 00 00 00 	movq   $0x0,(%r14)
    7564:	eb 08                	jmp    756e <fwp_close_owned_scoped_file+0x2e>
    7566:	48 8b 3b             	mov    (%rbx),%rdi
    7569:	e8 92 ab ff ff       	call   2100 <fclose@plt>
    756e:	48 8b 7b 08          	mov    0x8(%rbx),%rdi
    7572:	48 c7 43 08 00 00 00 	movq   $0x0,0x8(%rbx)
    7579:	00 
    757a:	48 83 c4 08          	add    $0x8,%rsp
    757e:	5b                   	pop    %rbx
    757f:	41 5e                	pop    %r14
    7581:	e9 5a 02 00 00       	jmp    77e0 <fwp_file_drop>
    7586:	66 2e 0f 1f 84 00 00 	cs nopw 0x0(%rax,%rax,1)
    758d:	00 00 00 

0000000000007590 <fwp_fail>:
    7590:	41 57                	push   %r15
    7592:	41 56                	push   %r14
    7594:	53                   	push   %rbx
    7595:	48 8b 05 e4 96 00 00 	mov    0x96e4(%rip),%rax        # 10c80 <fwp_handlers>
    759c:	48 85 c0             	test   %rax,%rax
    759f:	75 50                	jne    75f1 <fwp_fail+0x61>
    75a1:	48 89 f3             	mov    %rsi,%rbx
    75a4:	49 89 fe             	mov    %rdi,%r14
    75a7:	e8 04 c3 ff ff       	call   38b0 <fwp_flush>
    75ac:	4c 8b 3d 2d 7a 00 00 	mov    0x7a2d(%rip),%r15        # efe0 <stderr@GLIBC_2.2.5>
    75b3:	49 8b 0f             	mov    (%r15),%rcx
    75b6:	48 8d 3d 73 4f 00 00 	lea    0x4f73(%rip),%rdi        # c530 <fwp_segv.msg+0x2f0>
    75bd:	be 07 00 00 00       	mov    $0x7,%esi
    75c2:	ba 01 00 00 00       	mov    $0x1,%edx
    75c7:	e8 14 ad ff ff       	call   22e0 <fwrite@plt>
    75cc:	49 8b 17             	mov    (%r15),%rdx
    75cf:	4c 89 f7             	mov    %r14,%rdi
    75d2:	48 89 de             	mov    %rbx,%rsi
    75d5:	e8 56 03 00 00       	call   7930 <fwp_display_top>
    75da:	49 8b 37             	mov    (%r15),%rsi
    75dd:	bf 0a 00 00 00       	mov    $0xa,%edi
    75e2:	e8 89 ab ff ff       	call   2170 <fputc@plt>
    75e7:	bf 01 00 00 00       	mov    $0x1,%edi
    75ec:	e8 df ac ff ff       	call   22d0 <exit@plt>
    75f1:	48 89 b8 d0 00 00 00 	mov    %rdi,0xd0(%rax)
    75f8:	48 89 b0 d8 00 00 00 	mov    %rsi,0xd8(%rax)
    75ff:	48 8b b8 e8 00 00 00 	mov    0xe8(%rax),%rdi
    7606:	e8 65 c2 ff ff       	call   3870 <fwp_cleanup_unwind>
    760b:	48 8b 3d 6e 96 00 00 	mov    0x966e(%rip),%rdi        # 10c80 <fwp_handlers>
    7612:	be 01 00 00 00       	mov    $0x1,%esi
    7617:	e8 54 ac ff ff       	call   2270 <longjmp@plt>
    761c:	0f 1f 40 00          	nopl   0x0(%rax)

0000000000007620 <fwp_io_error>:
    7620:	41 57                	push   %r15
    7622:	41 56                	push   %r14
    7624:	41 55                	push   %r13
    7626:	41 54                	push   %r12
    7628:	53                   	push   %rbx
    7629:	48 83 ec 10          	sub    $0x10,%rsp
    762d:	48 89 f3             	mov    %rsi,%rbx
    7630:	49 89 fe             	mov    %rdi,%r14
    7633:	e8 d8 aa ff ff       	call   2110 <strlen@plt>
    7638:	49 89 c7             	mov    %rax,%r15
    763b:	48 8d 50 09          	lea    0x9(%rax),%rdx
    763f:	4c 8d 2d 62 7b 00 00 	lea    0x7b62(%rip),%r13        # f1a8 <fwp_gc>
    7646:	48 81 fa 00 40 00 00 	cmp    $0x4000,%rdx
    764d:	77 54                	ja     76a3 <fwp_io_error+0x83>
    764f:	4c 89 f8             	mov    %r15,%rax
    7652:	48 83 c0 18          	add    $0x18,%rax
    7656:	48 c1 e8 04          	shr    $0x4,%rax
    765a:	42 0f b6 8c 28 e8 0b 	movzbl 0xbe8(%rax,%r13,1),%ecx
    7661:	00 00 
    7663:	41 8b 84 8d 48 0b 00 	mov    0xb48(%r13,%rcx,4),%eax
    766a:	00 
    766b:	48 29 05 36 7b 00 00 	sub    %rax,0x7b36(%rip)        # f1a8 <fwp_gc>
    7672:	78 2f                	js     76a3 <fwp_io_error+0x83>
    7674:	48 8d 0c 49          	lea    (%rcx,%rcx,2),%rcx
    7678:	48 8d 34 cd c8 03 00 	lea    0x3c8(,%rcx,8),%rsi
    767f:	00 
    7680:	4c 01 ee             	add    %r13,%rsi
    7683:	4c 8b 26             	mov    (%rsi),%r12
    7686:	4d 85 e4             	test   %r12,%r12
    7689:	75 2a                	jne    76b5 <fwp_io_error+0x95>
    768b:	4d 8b a4 cd d0 03 00 	mov    0x3d0(%r13,%rcx,8),%r12
    7692:	00 
    7693:	49 8b b4 cd d8 03 00 	mov    0x3d8(%r13,%rcx,8),%rsi
    769a:	00 
    769b:	4c 29 e6             	sub    %r12,%rsi
    769e:	48 39 c6             	cmp    %rax,%rsi
    76a1:	73 1e                	jae    76c1 <fwp_io_error+0xa1>
    76a3:	48 89 d7             	mov    %rdx,%rdi
    76a6:	be 01 00 00 00       	mov    $0x1,%esi
    76ab:	e8 c0 de ff ff       	call   5570 <fwp_gc_alloc_slow>
    76b0:	49 89 c4             	mov    %rax,%r12
    76b3:	eb 27                	jmp    76dc <fwp_io_error+0xbc>
    76b5:	49 8b 04 24          	mov    (%r12),%rax
    76b9:	48 f7 d0             	not    %rax
    76bc:	48 89 06             	mov    %rax,(%rsi)
    76bf:	eb 11                	jmp    76d2 <fwp_io_error+0xb2>
    76c1:	48 8d 0c cd d0 03 00 	lea    0x3d0(,%rcx,8),%rcx
    76c8:	00 
    76c9:	4c 01 e9             	add    %r13,%rcx
    76cc:	4c 01 e0             	add    %r12,%rax
    76cf:	48 89 01             	mov    %rax,(%rcx)
    76d2:	4c 89 e7             	mov    %r12,%rdi
    76d5:	31 f6                	xor    %esi,%esi
    76d7:	e8 84 aa ff ff       	call   2160 <memset@plt>
    76dc:	4d 89 3c 24          	mov    %r15,(%r12)
    76e0:	49 8d 7c 24 08       	lea    0x8(%r12),%rdi
    76e5:	4c 89 f6             	mov    %r14,%rsi
    76e8:	4c 89 fa             	mov    %r15,%rdx
    76eb:	e8 20 ab ff ff       	call   2210 <memcpy@plt>
    76f0:	43 c6 44 3c 08 00    	movb   $0x0,0x8(%r12,%r15,1)
    76f6:	4c 89 24 24          	mov    %r12,(%rsp)
    76fa:	48 89 df             	mov    %rbx,%rdi
    76fd:	e8 0e aa ff ff       	call   2110 <strlen@plt>
    7702:	49 89 c6             	mov    %rax,%r14
    7705:	48 8d 50 09          	lea    0x9(%rax),%rdx
    7709:	48 81 fa 00 40 00 00 	cmp    $0x4000,%rdx
    7710:	77 54                	ja     7766 <fwp_io_error+0x146>
    7712:	4c 89 f0             	mov    %r14,%rax
    7715:	48 83 c0 18          	add    $0x18,%rax
    7719:	48 c1 e8 04          	shr    $0x4,%rax
    771d:	42 0f b6 8c 28 e8 0b 	movzbl 0xbe8(%rax,%r13,1),%ecx
    7724:	00 00 
    7726:	41 8b 84 8d 48 0b 00 	mov    0xb48(%r13,%rcx,4),%eax
    772d:	00 
    772e:	48 29 05 73 7a 00 00 	sub    %rax,0x7a73(%rip)        # f1a8 <fwp_gc>
    7735:	78 2f                	js     7766 <fwp_io_error+0x146>
    7737:	48 8d 0c 49          	lea    (%rcx,%rcx,2),%rcx
    773b:	48 8d 34 cd c8 03 00 	lea    0x3c8(,%rcx,8),%rsi
    7742:	00 
    7743:	4c 01 ee             	add    %r13,%rsi
    7746:	4c 8b 3e             	mov    (%rsi),%r15
    7749:	4d 85 ff             	test   %r15,%r15
    774c:	75 2a                	jne    7778 <fwp_io_error+0x158>
    774e:	4d 8b bc cd d0 03 00 	mov    0x3d0(%r13,%rcx,8),%r15
    7755:	00 
    7756:	49 8b b4 cd d8 03 00 	mov    0x3d8(%r13,%rcx,8),%rsi
    775d:	00 
    775e:	4c 29 fe             	sub    %r15,%rsi
    7761:	48 39 c6             	cmp    %rax,%rsi
    7764:	73 1d                	jae    7783 <fwp_io_error+0x163>
    7766:	48 89 d7             	mov    %rdx,%rdi
    7769:	be 01 00 00 00       	mov    $0x1,%esi
    776e:	e8 fd dd ff ff       	call   5570 <fwp_gc_alloc_slow>
    7773:	49 89 c7             	mov    %rax,%r15
    7776:	eb 26                	jmp    779e <fwp_io_error+0x17e>
    7778:	49 8b 07             	mov    (%r15),%rax
    777b:	48 f7 d0             	not    %rax
    777e:	48 89 06             	mov    %rax,(%rsi)
    7781:	eb 11                	jmp    7794 <fwp_io_error+0x174>
    7783:	48 8d 0c cd d0 03 00 	lea    0x3d0(,%rcx,8),%rcx
    778a:	00 
    778b:	4c 01 e9             	add    %r13,%rcx
    778e:	4c 01 f8             	add    %r15,%rax
    7791:	48 89 01             	mov    %rax,(%rcx)
    7794:	4c 89 ff             	mov    %r15,%rdi
    7797:	31 f6                	xor    %esi,%esi
    7799:	e8 c2 a9 ff ff       	call   2160 <memset@plt>
    779e:	4d 89 37             	mov    %r14,(%r15)
    77a1:	49 8d 7f 08          	lea    0x8(%r15),%rdi
    77a5:	48 89 de             	mov    %rbx,%rsi
    77a8:	4c 89 f2             	mov    %r14,%rdx
    77ab:	e8 60 aa ff ff       	call   2210 <memcpy@plt>
    77b0:	43 c6 44 37 08 00    	movb   $0x0,0x8(%r15,%r14,1)
    77b6:	4c 89 7c 24 08       	mov    %r15,0x8(%rsp)
    77bb:	48 89 e2             	mov    %rsp,%rdx
    77be:	31 ff                	xor    %edi,%edi
    77c0:	be 02 00 00 00       	mov    $0x2,%esi
    77c5:	e8 06 cb ff ff       	call   42d0 <fwp_data>
    77ca:	48 8d 35 2f 74 00 00 	lea    0x742f(%rip),%rsi        # ec00 <d0>
    77d1:	48 89 c7             	mov    %rax,%rdi
    77d4:	e8 b7 fd ff ff       	call   7590 <fwp_fail>
    77d9:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)

00000000000077e0 <fwp_file_drop>:
    77e0:	48 85 ff             	test   %rdi,%rdi
    77e3:	0f 84 3f 01 00 00    	je     7928 <fwp_file_drop+0x148>
    77e9:	53                   	push   %rbx
    77ea:	48 8b 47 08          	mov    0x8(%rdi),%rax
    77ee:	48 85 c0             	test   %rax,%rax
    77f1:	0f 84 30 01 00 00    	je     7927 <fwp_file_drop+0x147>
    77f7:	48 ff c8             	dec    %rax
    77fa:	48 89 47 08          	mov    %rax,0x8(%rdi)
    77fe:	0f 85 23 01 00 00    	jne    7927 <fwp_file_drop+0x147>
    7804:	48 8b 07             	mov    (%rdi),%rax
    7807:	48 85 c0             	test   %rax,%rax
    780a:	74 15                	je     7821 <fwp_file_drop+0x41>
    780c:	48 89 fb             	mov    %rdi,%rbx
    780f:	48 89 c7             	mov    %rax,%rdi
    7812:	e8 e9 a8 ff ff       	call   2100 <fclose@plt>
    7817:	48 89 df             	mov    %rbx,%rdi
    781a:	48 c7 03 00 00 00 00 	movq   $0x0,(%rbx)
    7821:	48 89 f8             	mov    %rdi,%rax
    7824:	48 2b 05 ad 89 00 00 	sub    0x89ad(%rip),%rax        # 101d8 <fwp_gc+0x1030>
    782b:	48 8b 0d ce 89 00 00 	mov    0x89ce(%rip),%rcx        # 10200 <fwp_gc+0x1058>
    7832:	48 c1 e1 10          	shl    $0x10,%rcx
    7836:	48 39 c8             	cmp    %rcx,%rax
    7839:	0f 83 e8 00 00 00    	jae    7927 <fwp_file_drop+0x147>
    783f:	48 8b 0d da 89 00 00 	mov    0x89da(%rip),%rcx        # 10220 <fwp_gc+0x1078>
    7846:	48 89 c2             	mov    %rax,%rdx
    7849:	48 c1 ea 10          	shr    $0x10,%rdx
    784d:	48 69 d2 28 12 00 00 	imul   $0x1228,%rdx,%rdx
    7854:	0f b6 34 11          	movzbl (%rcx,%rdx,1),%esi
    7858:	48 25 ff ff 00 00    	and    $0xffff,%rax
    785e:	75 1a                	jne    787a <fwp_file_drop+0x9a>
    7860:	40 80 fe 02          	cmp    $0x2,%sil
    7864:	75 14                	jne    787a <fwp_file_drop+0x9a>
    7866:	48 8d 04 11          	lea    (%rcx,%rdx,1),%rax
    786a:	48 05 28 02 00 00    	add    $0x228,%rax
    7870:	80 38 01             	cmpb   $0x1,(%rax)
    7873:	74 31                	je     78a6 <fwp_file_drop+0xc6>
    7875:	e9 ad 00 00 00       	jmp    7927 <fwp_file_drop+0x147>
    787a:	40 80 fe 01          	cmp    $0x1,%sil
    787e:	0f 85 a3 00 00 00    	jne    7927 <fwp_file_drop+0x147>
    7884:	48 8d 34 11          	lea    (%rcx,%rdx,1),%rsi
    7888:	8b 4c 11 20          	mov    0x20(%rcx,%rdx,1),%ecx
    788c:	48 0f af c1          	imul   %rcx,%rax
    7890:	48 c1 e8 20          	shr    $0x20,%rax
    7894:	48 01 f0             	add    %rsi,%rax
    7897:	48 05 28 02 00 00    	add    $0x228,%rax
    789d:	80 38 01             	cmpb   $0x1,(%rax)
    78a0:	0f 85 81 00 00 00    	jne    7927 <fwp_file_drop+0x147>
    78a6:	8b 0d 1c 93 00 00    	mov    0x931c(%rip),%ecx        # 10bc8 <fwp_reuse_verify>
    78ac:	85 c9                	test   %ecx,%ecx
    78ae:	79 42                	jns    78f2 <fwp_file_drop+0x112>
    78b0:	48 89 fb             	mov    %rdi,%rbx
    78b3:	48 8d 3d 26 4b 00 00 	lea    0x4b26(%rip),%rdi        # c3e0 <fwp_segv.msg+0x1a0>
    78ba:	e8 71 a7 ff ff       	call   2030 <getenv@plt>
    78bf:	31 c9                	xor    %ecx,%ecx
    78c1:	48 85 c0             	test   %rax,%rax
    78c4:	74 23                	je     78e9 <fwp_file_drop+0x109>
    78c6:	80 38 00             	cmpb   $0x0,(%rax)
    78c9:	48 89 df             	mov    %rbx,%rdi
    78cc:	74 1e                	je     78ec <fwp_file_drop+0x10c>
    78ce:	48 8d 35 da 4c 00 00 	lea    0x4cda(%rip),%rsi        # c5af <fwp_segv.msg+0x36f>
    78d5:	48 89 c7             	mov    %rax,%rdi
    78d8:	e8 e3 a8 ff ff       	call   21c0 <strcmp@plt>
    78dd:	48 89 df             	mov    %rbx,%rdi
    78e0:	31 c9                	xor    %ecx,%ecx
    78e2:	85 c0                	test   %eax,%eax
    78e4:	0f 95 c1             	setne  %cl
    78e7:	eb 03                	jmp    78ec <fwp_file_drop+0x10c>
    78e9:	48 89 df             	mov    %rbx,%rdi
    78ec:	89 0d d6 92 00 00    	mov    %ecx,0x92d6(%rip)        # 10bc8 <fwp_reuse_verify>
    78f2:	85 c9                	test   %ecx,%ecx
    78f4:	74 06                	je     78fc <fwp_file_drop+0x11c>
    78f6:	c6 47 10 00          	movb   $0x0,0x10(%rdi)
    78fa:	eb 2b                	jmp    7927 <fwp_file_drop+0x147>
    78fc:	48 8b 1d a5 78 00 00 	mov    0x78a5(%rip),%rbx        # f1a8 <fwp_gc>
    7903:	e8 e8 ee ff ff       	call   67f0 <fwp_mem_free>
    7908:	48 8b 05 99 78 00 00 	mov    0x7899(%rip),%rax        # f1a8 <fwp_gc>
    790f:	48 29 d8             	sub    %rbx,%rax
    7912:	f2 48 0f 2a c0       	cvtsi2sd %rax,%xmm0
    7917:	f2 0f 58 05 91 8a 00 	addsd  0x8a91(%rip),%xmm0        # 103b0 <fwp_gc+0x1208>
    791e:	00 
    791f:	f2 0f 11 05 89 8a 00 	movsd  %xmm0,0x8a89(%rip)        # 103b0 <fwp_gc+0x1208>
    7926:	00 
    7927:	5b                   	pop    %rbx
    7928:	c3                   	ret
    7929:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)

0000000000007930 <fwp_display_top>:
    7930:	53                   	push   %rbx
    7931:	48 83 ec 20          	sub    $0x20,%rsp
    7935:	48 89 d3             	mov    %rdx,%rbx
    7938:	48 89 f2             	mov    %rsi,%rdx
    793b:	48 89 fe             	mov    %rdi,%rsi
    793e:	0f 57 c0             	xorps  %xmm0,%xmm0
    7941:	0f 29 04 24          	movaps %xmm0,(%rsp)
    7945:	48 c7 44 24 10 00 00 	movq   $0x0,0x10(%rsp)
    794c:	00 00 
    794e:	48 89 e7             	mov    %rsp,%rdi
    7951:	b9 01 00 00 00       	mov    $0x1,%ecx
    7956:	e8 35 00 00 00       	call   7990 <fwp_write>
    795b:	48 8b 3c 24          	mov    (%rsp),%rdi
    795f:	48 85 ff             	test   %rdi,%rdi
    7962:	74 18                	je     797c <fwp_display_top+0x4c>
    7964:	48 8b 54 24 08       	mov    0x8(%rsp),%rdx
    7969:	be 01 00 00 00       	mov    $0x1,%esi
    796e:	48 89 d9             	mov    %rbx,%rcx
    7971:	e8 6a a9 ff ff       	call   22e0 <fwrite@plt>
    7976:	48 8b 3c 24          	mov    (%rsp),%rdi
    797a:	eb 02                	jmp    797e <fwp_display_top+0x4e>
    797c:	31 ff                	xor    %edi,%edi
    797e:	e8 cd a6 ff ff       	call   2050 <free@plt>
    7983:	48 83 c4 20          	add    $0x20,%rsp
    7987:	5b                   	pop    %rbx
    7988:	c3                   	ret
    7989:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)

0000000000007990 <fwp_write>:
    7990:	55                   	push   %rbp
    7991:	41 57                	push   %r15
    7993:	41 56                	push   %r14
    7995:	41 55                	push   %r13
    7997:	41 54                	push   %r12
    7999:	53                   	push   %rbx
    799a:	48 81 ec 78 02 00 00 	sub    $0x278,%rsp
    79a1:	8b 02                	mov    (%rdx),%eax
    79a3:	48 83 f8 19          	cmp    $0x19,%rax
    79a7:	0f 87 26 12 00 00    	ja     8bd3 <fwp_write+0x1243>
    79ad:	49 89 d7             	mov    %rdx,%r15
    79b0:	49 89 f6             	mov    %rsi,%r14
    79b3:	48 89 fd             	mov    %rdi,%rbp
    79b6:	48 8d 15 53 47 00 00 	lea    0x4753(%rip),%rdx        # c110 <_IO_stdin_used+0x110>
    79bd:	48 63 34 82          	movslq (%rdx,%rax,4),%rsi
    79c1:	48 01 d6             	add    %rdx,%rsi
    79c4:	48 89 3c 24          	mov    %rdi,(%rsp)
    79c8:	ff e6                	jmp    *%rsi
    79ca:	48 8d 15 67 4b 00 00 	lea    0x4b67(%rip),%rdx        # c538 <fwp_segv.msg+0x2f8>
    79d1:	eb 07                	jmp    79da <fwp_write+0x4a>
    79d3:	48 8d 15 63 4b 00 00 	lea    0x4b63(%rip),%rdx        # c53d <fwp_segv.msg+0x2fd>
    79da:	4c 8d 7c 24 70       	lea    0x70(%rsp),%r15
    79df:	be 00 02 00 00       	mov    $0x200,%esi
    79e4:	4c 89 ff             	mov    %r15,%rdi
    79e7:	4c 89 f1             	mov    %r14,%rcx
    79ea:	31 c0                	xor    %eax,%eax
    79ec:	e8 4f a7 ff ff       	call   2140 <snprintf@plt>
    79f1:	4c 89 ff             	mov    %r15,%rdi
    79f4:	e8 17 a7 ff ff       	call   2110 <strlen@plt>
    79f9:	48 89 ef             	mov    %rbp,%rdi
    79fc:	4c 89 fe             	mov    %r15,%rsi
    79ff:	e9 c7 11 00 00       	jmp    8bcb <fwp_write+0x123b>
    7a04:	83 f8 13             	cmp    $0x13,%eax
    7a07:	48 8d 05 69 4b 00 00 	lea    0x4b69(%rip),%rax        # c577 <fwp_segv.msg+0x337>
    7a0e:	48 8d 35 67 4b 00 00 	lea    0x4b67(%rip),%rsi        # c57c <fwp_segv.msg+0x33c>
    7a15:	48 0f 44 f0          	cmove  %rax,%rsi
    7a19:	ba 04 00 00 00       	mov    $0x4,%edx
    7a1e:	48 89 ef             	mov    %rbp,%rdi
    7a21:	e8 4a 13 00 00       	call   8d70 <buf_put>
    7a26:	49 83 3e 00          	cmpq   $0x0,(%r14)
    7a2a:	0f 84 c3 00 00 00    	je     7af3 <fwp_write+0x163>
    7a30:	49 8b 57 38          	mov    0x38(%r15),%rdx
    7a34:	49 8b 76 08          	mov    0x8(%r14),%rsi
    7a38:	48 8b 1c 24          	mov    (%rsp),%rbx
    7a3c:	48 89 df             	mov    %rbx,%rdi
    7a3f:	31 c9                	xor    %ecx,%ecx
    7a41:	e8 4a ff ff ff       	call   7990 <fwp_write>
    7a46:	41 83 3f 12          	cmpl   $0x12,(%r15)
    7a4a:	75 26                	jne    7a72 <fwp_write+0xe2>
    7a4c:	48 8d 35 e2 4a 00 00 	lea    0x4ae2(%rip),%rsi        # c535 <fwp_segv.msg+0x2f5>
    7a53:	ba 02 00 00 00       	mov    $0x2,%edx
    7a58:	48 89 df             	mov    %rbx,%rdi
    7a5b:	e8 10 13 00 00       	call   8d70 <buf_put>
    7a60:	49 8b 76 10          	mov    0x10(%r14),%rsi
    7a64:	49 8b 57 40          	mov    0x40(%r15),%rdx
    7a68:	48 89 df             	mov    %rbx,%rdi
    7a6b:	31 c9                	xor    %ecx,%ecx
    7a6d:	e8 1e ff ff ff       	call   7990 <fwp_write>
    7a72:	49 83 3e 02          	cmpq   $0x2,(%r14)
    7a76:	72 7b                	jb     7af3 <fwp_write+0x163>
    7a78:	49 8d 5e 20          	lea    0x20(%r14),%rbx
    7a7c:	bd 01 00 00 00       	mov    $0x1,%ebp
    7a81:	4c 8d 25 e2 4a 00 00 	lea    0x4ae2(%rip),%r12        # c56a <fwp_segv.msg+0x32a>
    7a88:	eb 12                	jmp    7a9c <fwp_write+0x10c>
    7a8a:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)
    7a90:	48 ff c5             	inc    %rbp
    7a93:	48 83 c3 10          	add    $0x10,%rbx
    7a97:	49 3b 2e             	cmp    (%r14),%rbp
    7a9a:	73 57                	jae    7af3 <fwp_write+0x163>
    7a9c:	ba 02 00 00 00       	mov    $0x2,%edx
    7aa1:	4c 8b 2c 24          	mov    (%rsp),%r13
    7aa5:	4c 89 ef             	mov    %r13,%rdi
    7aa8:	4c 89 e6             	mov    %r12,%rsi
    7aab:	e8 c0 12 00 00       	call   8d70 <buf_put>
    7ab0:	48 8b 73 f8          	mov    -0x8(%rbx),%rsi
    7ab4:	49 8b 57 38          	mov    0x38(%r15),%rdx
    7ab8:	4c 89 ef             	mov    %r13,%rdi
    7abb:	31 c9                	xor    %ecx,%ecx
    7abd:	e8 ce fe ff ff       	call   7990 <fwp_write>
    7ac2:	41 83 3f 12          	cmpl   $0x12,(%r15)
    7ac6:	75 c8                	jne    7a90 <fwp_write+0x100>
    7ac8:	ba 02 00 00 00       	mov    $0x2,%edx
    7acd:	4c 8b 2c 24          	mov    (%rsp),%r13
    7ad1:	4c 89 ef             	mov    %r13,%rdi
    7ad4:	48 8d 35 5a 4a 00 00 	lea    0x4a5a(%rip),%rsi        # c535 <fwp_segv.msg+0x2f5>
    7adb:	e8 90 12 00 00       	call   8d70 <buf_put>
    7ae0:	48 8b 33             	mov    (%rbx),%rsi
    7ae3:	49 8b 57 40          	mov    0x40(%r15),%rdx
    7ae7:	4c 89 ef             	mov    %r13,%rdi
    7aea:	31 c9                	xor    %ecx,%ecx
    7aec:	e8 9f fe ff ff       	call   7990 <fwp_write>
    7af1:	eb 9d                	jmp    7a90 <fwp_write+0x100>
    7af3:	c6 44 24 70 7d       	movb   $0x7d,0x70(%rsp)
    7af8:	48 8d 74 24 70       	lea    0x70(%rsp),%rsi
    7afd:	ba 01 00 00 00       	mov    $0x1,%edx
    7b02:	48 8b 3c 24          	mov    (%rsp),%rdi
    7b06:	e9 c3 10 00 00       	jmp    8bce <fwp_write+0x123e>
    7b0b:	4d 8b 67 08          	mov    0x8(%r15),%r12
    7b0f:	4d 85 e4             	test   %r12,%r12
    7b12:	0f 84 af 06 00 00    	je     81c7 <fwp_write+0x837>
    7b18:	48 8d 35 62 4a 00 00 	lea    0x4a62(%rip),%rsi        # c581 <fwp_segv.msg+0x341>
    7b1f:	4c 89 e7             	mov    %r12,%rdi
    7b22:	e8 99 a6 ff ff       	call   21c0 <strcmp@plt>
    7b27:	85 c0                	test   %eax,%eax
    7b29:	0f 84 36 0b 00 00    	je     8665 <fwp_write+0xcd5>
    7b2f:	4d 8d 6f 10          	lea    0x10(%r15),%r13
    7b33:	4c 89 e7             	mov    %r12,%rdi
    7b36:	e8 d5 a5 ff ff       	call   2110 <strlen@plt>
    7b3b:	48 89 ef             	mov    %rbp,%rdi
    7b3e:	4c 89 e6             	mov    %r12,%rsi
    7b41:	48 89 c2             	mov    %rax,%rdx
    7b44:	e8 27 12 00 00       	call   8d70 <buf_put>
    7b49:	c6 44 24 70 20       	movb   $0x20,0x70(%rsp)
    7b4e:	48 8d 74 24 70       	lea    0x70(%rsp),%rsi
    7b53:	ba 01 00 00 00       	mov    $0x1,%edx
    7b58:	48 89 ef             	mov    %rbp,%rdi
    7b5b:	e8 10 12 00 00       	call   8d70 <buf_put>
    7b60:	31 db                	xor    %ebx,%ebx
    7b62:	e9 7f 06 00 00       	jmp    81e6 <fwp_write+0x856>
    7b67:	49 81 fe ff 0f 00 00 	cmp    $0xfff,%r14
    7b6e:	0f 87 00 05 00 00    	ja     8074 <fwp_write+0x6e4>
    7b74:	44 89 f0             	mov    %r14d,%eax
    7b77:	e9 fb 04 00 00       	jmp    8077 <fwp_write+0x6e7>
    7b7c:	66 49 0f 6e ce       	movq   %r14,%xmm1
    7b81:	66 0f 2e c9          	ucomisd %xmm1,%xmm1
    7b85:	0f 8a d2 11 00 00    	jp     8d5d <fwp_write+0x13cd>
    7b8b:	66 0f 28 05 2d 45 00 	movapd 0x452d(%rip),%xmm0        # c0c0 <_IO_stdin_used+0xc0>
    7b92:	00 
    7b93:	66 0f 54 c1          	andpd  %xmm1,%xmm0
    7b97:	66 0f 2e 05 61 45 00 	ucomisd 0x4561(%rip),%xmm0        # c100 <_IO_stdin_used+0x100>
    7b9e:	00 
    7b9f:	0f 82 66 08 00 00    	jb     840b <fwp_write+0xa7b>
    7ba5:	66 0f 57 c0          	xorpd  %xmm0,%xmm0
    7ba9:	66 0f 2e c8          	ucomisd %xmm0,%xmm1
    7bad:	e9 55 04 00 00       	jmp    8007 <fwp_write+0x677>
    7bb2:	c6 44 24 70 3c       	movb   $0x3c,0x70(%rsp)
    7bb7:	48 8d 74 24 70       	lea    0x70(%rsp),%rsi
    7bbc:	ba 01 00 00 00       	mov    $0x1,%edx
    7bc1:	48 89 ef             	mov    %rbp,%rdi
    7bc4:	e8 a7 11 00 00       	call   8d70 <buf_put>
    7bc9:	4d 8b 77 08          	mov    0x8(%r15),%r14
    7bcd:	e9 82 04 00 00       	jmp    8054 <fwp_write+0x6c4>
    7bd2:	48 8d 35 7a 49 00 00 	lea    0x497a(%rip),%rsi        # c553 <fwp_segv.msg+0x313>
    7bd9:	ba 08 00 00 00       	mov    $0x8,%edx
    7bde:	48 89 ef             	mov    %rbp,%rdi
    7be1:	e9 5c 0d 00 00       	jmp    8942 <fwp_write+0xfb2>
    7be6:	49 8d 76 08          	lea    0x8(%r14),%rsi
    7bea:	49 8b 16             	mov    (%r14),%rdx
    7bed:	85 c9                	test   %ecx,%ecx
    7bef:	0f 84 13 07 00 00    	je     8308 <fwp_write+0x978>
    7bf5:	48 89 ef             	mov    %rbp,%rdi
    7bf8:	e9 45 0d 00 00       	jmp    8942 <fwp_write+0xfb2>
    7bfd:	4d 8b 0e             	mov    (%r14),%r9
    7c00:	4d 8b 46 08          	mov    0x8(%r14),%r8
    7c04:	4c 89 c8             	mov    %r9,%rax
    7c07:	4c 09 c0             	or     %r8,%rax
    7c0a:	0f 84 11 07 00 00    	je     8321 <fwp_write+0x991>
    7c10:	31 ff                	xor    %edi,%edi
    7c12:	49 ba cd cc cc cc cc 	movabs $0xcccccccccccccccd,%r10
    7c19:	cc cc cc 
    7c1c:	49 bb cc cc cc cc cc 	movabs $0xcccccccccccccccc,%r11
    7c23:	cc cc cc 
    7c26:	4c 89 c3             	mov    %r8,%rbx
    7c29:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)
    7c30:	4c 89 c1             	mov    %r8,%rcx
    7c33:	4c 0f a4 c9 3f       	shld   $0x3f,%r9,%rcx
    7c38:	48 d1 eb             	shr    $1,%rbx
    7c3b:	48 89 ce             	mov    %rcx,%rsi
    7c3e:	48 01 de             	add    %rbx,%rsi
    7c41:	48 83 d6 00          	adc    $0x0,%rsi
    7c45:	48 89 f0             	mov    %rsi,%rax
    7c48:	49 f7 e2             	mul    %r10
    7c4b:	48 c1 ea 02          	shr    $0x2,%rdx
    7c4f:	48 8d 04 92          	lea    (%rdx,%rdx,4),%rax
    7c53:	48 29 c6             	sub    %rax,%rsi
    7c56:	48 29 f1             	sub    %rsi,%rcx
    7c59:	48 83 db 00          	sbb    $0x0,%rbx
    7c5d:	48 89 ce             	mov    %rcx,%rsi
    7c60:	49 0f af f3          	imul   %r11,%rsi
    7c64:	48 89 c8             	mov    %rcx,%rax
    7c67:	49 f7 e2             	mul    %r10
    7c6a:	48 01 f2             	add    %rsi,%rdx
    7c6d:	49 0f af da          	imul   %r10,%rbx
    7c71:	48 01 d3             	add    %rdx,%rbx
    7c74:	48 89 c1             	mov    %rax,%rcx
    7c77:	48 01 c1             	add    %rax,%rcx
    7c7a:	48 8d 0c 89          	lea    (%rcx,%rcx,4),%rcx
    7c7e:	44 89 ca             	mov    %r9d,%edx
    7c81:	29 ca                	sub    %ecx,%edx
    7c83:	80 ca 30             	or     $0x30,%dl
    7c86:	88 54 3c 20          	mov    %dl,0x20(%rsp,%rdi,1)
    7c8a:	48 ff c7             	inc    %rdi
    7c8d:	49 83 f9 0a          	cmp    $0xa,%r9
    7c91:	49 83 d8 00          	sbb    $0x0,%r8
    7c95:	49 89 c1             	mov    %rax,%r9
    7c98:	49 89 d8             	mov    %rbx,%r8
    7c9b:	73 93                	jae    7c30 <fwp_write+0x2a0>
    7c9d:	85 ff                	test   %edi,%edi
    7c9f:	0f 8f 86 06 00 00    	jg     832b <fwp_write+0x99b>
    7ca5:	e9 ab 00 00 00       	jmp    7d55 <fwp_write+0x3c5>
    7caa:	4d 8b 06             	mov    (%r14),%r8
    7cad:	4d 8b 4e 08          	mov    0x8(%r14),%r9
    7cb1:	4d 85 c9             	test   %r9,%r9
    7cb4:	0f 88 93 06 00 00    	js     834d <fwp_write+0x9bd>
    7cba:	4c 89 c0             	mov    %r8,%rax
    7cbd:	4c 09 c8             	or     %r9,%rax
    7cc0:	0f 84 bc 09 00 00    	je     8682 <fwp_write+0xcf2>
    7cc6:	31 ff                	xor    %edi,%edi
    7cc8:	49 ba cd cc cc cc cc 	movabs $0xcccccccccccccccd,%r10
    7ccf:	cc cc cc 
    7cd2:	49 bb cc cc cc cc cc 	movabs $0xcccccccccccccccc,%r11
    7cd9:	cc cc cc 
    7cdc:	4c 89 cb             	mov    %r9,%rbx
    7cdf:	90                   	nop
    7ce0:	4c 89 c9             	mov    %r9,%rcx
    7ce3:	4c 0f a4 c1 3f       	shld   $0x3f,%r8,%rcx
    7ce8:	48 d1 eb             	shr    $1,%rbx
    7ceb:	48 89 ce             	mov    %rcx,%rsi
    7cee:	48 01 de             	add    %rbx,%rsi
    7cf1:	48 83 d6 00          	adc    $0x0,%rsi
    7cf5:	48 89 f0             	mov    %rsi,%rax
    7cf8:	49 f7 e2             	mul    %r10
    7cfb:	48 c1 ea 02          	shr    $0x2,%rdx
    7cff:	48 8d 04 92          	lea    (%rdx,%rdx,4),%rax
    7d03:	48 29 c6             	sub    %rax,%rsi
    7d06:	48 29 f1             	sub    %rsi,%rcx
    7d09:	48 83 db 00          	sbb    $0x0,%rbx
    7d0d:	48 89 ce             	mov    %rcx,%rsi
    7d10:	49 0f af f3          	imul   %r11,%rsi
    7d14:	48 89 c8             	mov    %rcx,%rax
    7d17:	49 f7 e2             	mul    %r10
    7d1a:	48 01 f2             	add    %rsi,%rdx
    7d1d:	49 0f af da          	imul   %r10,%rbx
    7d21:	48 01 d3             	add    %rdx,%rbx
    7d24:	48 89 c1             	mov    %rax,%rcx
    7d27:	48 01 c1             	add    %rax,%rcx
    7d2a:	48 8d 0c 89          	lea    (%rcx,%rcx,4),%rcx
    7d2e:	44 89 c2             	mov    %r8d,%edx
    7d31:	29 ca                	sub    %ecx,%edx
    7d33:	80 ca 30             	or     $0x30,%dl
    7d36:	88 54 3c 20          	mov    %dl,0x20(%rsp,%rdi,1)
    7d3a:	48 ff c7             	inc    %rdi
    7d3d:	49 83 f8 0a          	cmp    $0xa,%r8
    7d41:	49 83 d9 00          	sbb    $0x0,%r9
    7d45:	49 89 c0             	mov    %rax,%r8
    7d48:	49 89 d9             	mov    %rbx,%r9
    7d4b:	73 93                	jae    7ce0 <fwp_write+0x350>
    7d4d:	85 ff                	test   %edi,%edi
    7d4f:	0f 8f 37 09 00 00    	jg     868c <fwp_write+0xcfc>
    7d55:	31 c0                	xor    %eax,%eax
    7d57:	e9 57 0e 00 00       	jmp    8bb3 <fwp_write+0x1223>
    7d5c:	c6 44 24 70 5b       	movb   $0x5b,0x70(%rsp)
    7d61:	48 8d 74 24 70       	lea    0x70(%rsp),%rsi
    7d66:	ba 01 00 00 00       	mov    $0x1,%edx
    7d6b:	48 89 ef             	mov    %rbp,%rdi
    7d6e:	e8 fd 0f 00 00       	call   8d70 <buf_put>
    7d73:	4d 85 f6             	test   %r14,%r14
    7d76:	0f 84 e6 0c 00 00    	je     8a62 <fwp_write+0x10d2>
    7d7c:	49 8b 57 38          	mov    0x38(%r15),%rdx
    7d80:	49 8b 76 08          	mov    0x8(%r14),%rsi
    7d84:	48 89 ef             	mov    %rbp,%rdi
    7d87:	31 c9                	xor    %ecx,%ecx
    7d89:	e8 02 fc ff ff       	call   7990 <fwp_write>
    7d8e:	49 8b 5e 10          	mov    0x10(%r14),%rbx
    7d92:	48 85 db             	test   %rbx,%rbx
    7d95:	0f 84 c7 0c 00 00    	je     8a62 <fwp_write+0x10d2>
    7d9b:	4c 8d 35 c8 47 00 00 	lea    0x47c8(%rip),%r14        # c56a <fwp_segv.msg+0x32a>
    7da2:	66 66 66 66 66 2e 0f 	data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    7da9:	1f 84 00 00 00 00 00 
    7db0:	ba 02 00 00 00       	mov    $0x2,%edx
    7db5:	48 89 ef             	mov    %rbp,%rdi
    7db8:	4c 89 f6             	mov    %r14,%rsi
    7dbb:	e8 b0 0f 00 00       	call   8d70 <buf_put>
    7dc0:	48 8b 73 08          	mov    0x8(%rbx),%rsi
    7dc4:	49 8b 57 38          	mov    0x38(%r15),%rdx
    7dc8:	48 89 ef             	mov    %rbp,%rdi
    7dcb:	31 c9                	xor    %ecx,%ecx
    7dcd:	e8 be fb ff ff       	call   7990 <fwp_write>
    7dd2:	48 8b 5b 10          	mov    0x10(%rbx),%rbx
    7dd6:	48 85 db             	test   %rbx,%rbx
    7dd9:	75 d5                	jne    7db0 <fwp_write+0x420>
    7ddb:	e9 82 0c 00 00       	jmp    8a62 <fwp_write+0x10d2>
    7de0:	4d 63 67 48          	movslq 0x48(%r15),%r12
    7de4:	44 89 e3             	mov    %r12d,%ebx
    7de7:	49 8d 54 24 03       	lea    0x3(%r12),%rdx
    7dec:	48 81 fa 00 40 00 00 	cmp    $0x4000,%rdx
    7df3:	0f 87 57 08 00 00    	ja     8650 <fwp_write+0xcc0>
    7df9:	49 8d 4c 24 12       	lea    0x12(%r12),%rcx
    7dfe:	48 c1 e9 04          	shr    $0x4,%rcx
    7e02:	48 8d 05 9f 73 00 00 	lea    0x739f(%rip),%rax        # f1a8 <fwp_gc>
    7e09:	0f b6 b4 01 e8 0b 00 	movzbl 0xbe8(%rcx,%rax,1),%esi
    7e10:	00 
    7e11:	8b 8c b0 48 0b 00 00 	mov    0xb48(%rax,%rsi,4),%ecx
    7e18:	48 29 0d 89 73 00 00 	sub    %rcx,0x7389(%rip)        # f1a8 <fwp_gc>
    7e1f:	0f 88 2b 08 00 00    	js     8650 <fwp_write+0xcc0>
    7e25:	48 8d 34 76          	lea    (%rsi,%rsi,2),%rsi
    7e29:	48 8d 3c f0          	lea    (%rax,%rsi,8),%rdi
    7e2d:	48 81 c7 c8 03 00 00 	add    $0x3c8,%rdi
    7e34:	4c 8b 3f             	mov    (%rdi),%r15
    7e37:	4d 85 ff             	test   %r15,%r15
    7e3a:	0f 84 f4 07 00 00    	je     8634 <fwp_write+0xca4>
    7e40:	49 8b 07             	mov    (%r15),%rax
    7e43:	48 f7 d0             	not    %rax
    7e46:	48 89 07             	mov    %rax,(%rdi)
    7e49:	e9 2d 0a 00 00       	jmp    887b <fwp_write+0xeeb>
    7e4e:	49 83 fe ff          	cmp    $0xffffffffffffffff,%r14
    7e52:	48 8d 05 ec 46 00 00 	lea    0x46ec(%rip),%rax        # c545 <fwp_segv.msg+0x305>
    7e59:	48 8d 0d 4f 47 00 00 	lea    0x474f(%rip),%rcx        # c5af <fwp_segv.msg+0x36f>
    7e60:	48 0f 44 c8          	cmove  %rax,%rcx
    7e64:	49 83 fe 01          	cmp    $0x1,%r14
    7e68:	4c 8d 35 d3 46 00 00 	lea    0x46d3(%rip),%r14        # c542 <fwp_segv.msg+0x302>
    7e6f:	4c 0f 45 f1          	cmovne %rcx,%r14
    7e73:	4c 89 f7             	mov    %r14,%rdi
    7e76:	e8 95 a2 ff ff       	call   2110 <strlen@plt>
    7e7b:	48 89 ef             	mov    %rbp,%rdi
    7e7e:	4c 89 f6             	mov    %r14,%rsi
    7e81:	e9 b9 0a 00 00       	jmp    893f <fwp_write+0xfaf>
    7e86:	48 8d 35 e3 46 00 00 	lea    0x46e3(%rip),%rsi        # c570 <fwp_segv.msg+0x330>
    7e8d:	ba 06 00 00 00       	mov    $0x6,%edx
    7e92:	48 89 ef             	mov    %rbp,%rdi
    7e95:	e8 d6 0e 00 00       	call   8d70 <buf_put>
    7e9a:	49 8b 36             	mov    (%r14),%rsi
    7e9d:	48 8d 04 75 00 00 00 	lea    0x0(,%rsi,2),%rax
    7ea4:	00 
    7ea5:	48 85 c0             	test   %rax,%rax
    7ea8:	0f 84 b4 0b 00 00    	je     8a62 <fwp_write+0x10d2>
    7eae:	49 8b 57 38          	mov    0x38(%r15),%rdx
    7eb2:	b8 08 00 00 00       	mov    $0x8,%eax
    7eb7:	48 85 d2             	test   %rdx,%rdx
    7eba:	74 13                	je     7ecf <fwp_write+0x53f>
    7ebc:	8b 0a                	mov    (%rdx),%ecx
    7ebe:	48 83 f9 0a          	cmp    $0xa,%rcx
    7ec2:	77 0b                	ja     7ecf <fwp_write+0x53f>
    7ec4:	48 8d 05 95 43 00 00 	lea    0x4395(%rip),%rax        # c260 <fwp_segv.msg+0x20>
    7ecb:	48 8b 04 c8          	mov    (%rax,%rcx,8),%rax
    7ecf:	4d 8d 6e 08          	lea    0x8(%r14),%r13
    7ed3:	4c 89 e9             	mov    %r13,%rcx
    7ed6:	48 85 f6             	test   %rsi,%rsi
    7ed9:	79 04                	jns    7edf <fwp_write+0x54f>
    7edb:	49 8b 4e 10          	mov    0x10(%r14),%rcx
    7edf:	48 83 f8 01          	cmp    $0x1,%rax
    7ee3:	0f 84 74 0a 00 00    	je     895d <fwp_write+0xfcd>
    7ee9:	48 83 f8 08          	cmp    $0x8,%rax
    7eed:	0f 84 65 0a 00 00    	je     8958 <fwp_write+0xfc8>
    7ef3:	48 83 f8 02          	cmp    $0x2,%rax
    7ef7:	0f 85 6c 0a 00 00    	jne    8969 <fwp_write+0xfd9>
    7efd:	83 3a 01             	cmpl   $0x1,(%rdx)
    7f00:	0f b7 01             	movzwl (%rcx),%eax
    7f03:	48 0f bf f0          	movswq %ax,%rsi
    7f07:	e9 65 0a 00 00       	jmp    8971 <fwp_write+0xfe1>
    7f0c:	48 8d 35 50 46 00 00 	lea    0x4650(%rip),%rsi        # c563 <fwp_segv.msg+0x323>
    7f13:	ba 06 00 00 00       	mov    $0x6,%edx
    7f18:	48 89 ef             	mov    %rbp,%rdi
    7f1b:	e8 50 0e 00 00       	call   8d70 <buf_put>
    7f20:	49 83 3e 00          	cmpq   $0x0,(%r14)
    7f24:	0f 84 a3 00 00 00    	je     7fcd <fwp_write+0x63d>
    7f2a:	41 0f b6 4e 08       	movzbl 0x8(%r14),%ecx
    7f2f:	48 8d 15 37 46 00 00 	lea    0x4637(%rip),%rdx        # c56d <fwp_segv.msg+0x32d>
    7f36:	4c 8d 7c 24 70       	lea    0x70(%rsp),%r15
    7f3b:	be 00 02 00 00       	mov    $0x200,%esi
    7f40:	4c 89 ff             	mov    %r15,%rdi
    7f43:	31 c0                	xor    %eax,%eax
    7f45:	e8 f6 a1 ff ff       	call   2140 <snprintf@plt>
    7f4a:	4c 89 ff             	mov    %r15,%rdi
    7f4d:	e8 be a1 ff ff       	call   2110 <strlen@plt>
    7f52:	48 89 ef             	mov    %rbp,%rdi
    7f55:	4c 89 fe             	mov    %r15,%rsi
    7f58:	48 89 c2             	mov    %rax,%rdx
    7f5b:	e8 10 0e 00 00       	call   8d70 <buf_put>
    7f60:	49 83 3e 02          	cmpq   $0x2,(%r14)
    7f64:	72 67                	jb     7fcd <fwp_write+0x63d>
    7f66:	bb 09 00 00 00       	mov    $0x9,%ebx
    7f6b:	4c 8d 3d f8 45 00 00 	lea    0x45f8(%rip),%r15        # c56a <fwp_segv.msg+0x32a>
    7f72:	4c 8d 25 f4 45 00 00 	lea    0x45f4(%rip),%r12        # c56d <fwp_segv.msg+0x32d>
    7f79:	4c 8d 6c 24 70       	lea    0x70(%rsp),%r13
    7f7e:	66 90                	xchg   %ax,%ax
    7f80:	ba 02 00 00 00       	mov    $0x2,%edx
    7f85:	48 89 ef             	mov    %rbp,%rdi
    7f88:	4c 89 fe             	mov    %r15,%rsi
    7f8b:	e8 e0 0d 00 00       	call   8d70 <buf_put>
    7f90:	41 0f b6 0c 1e       	movzbl (%r14,%rbx,1),%ecx
    7f95:	be 00 02 00 00       	mov    $0x200,%esi
    7f9a:	4c 89 ef             	mov    %r13,%rdi
    7f9d:	4c 89 e2             	mov    %r12,%rdx
    7fa0:	31 c0                	xor    %eax,%eax
    7fa2:	e8 99 a1 ff ff       	call   2140 <snprintf@plt>
    7fa7:	4c 89 ef             	mov    %r13,%rdi
    7faa:	e8 61 a1 ff ff       	call   2110 <strlen@plt>
    7faf:	48 89 ef             	mov    %rbp,%rdi
    7fb2:	4c 89 ee             	mov    %r13,%rsi
    7fb5:	48 89 c2             	mov    %rax,%rdx
    7fb8:	e8 b3 0d 00 00       	call   8d70 <buf_put>
    7fbd:	48 8d 43 01          	lea    0x1(%rbx),%rax
    7fc1:	48 83 c3 f9          	add    $0xfffffffffffffff9,%rbx
    7fc5:	49 3b 1e             	cmp    (%r14),%rbx
    7fc8:	48 89 c3             	mov    %rax,%rbx
    7fcb:	72 b3                	jb     7f80 <fwp_write+0x5f0>
    7fcd:	c6 44 24 20 5d       	movb   $0x5d,0x20(%rsp)
    7fd2:	48 8d 74 24 20       	lea    0x20(%rsp),%rsi
    7fd7:	e9 90 0a 00 00       	jmp    8a6c <fwp_write+0x10dc>
    7fdc:	66 41 0f 6e ce       	movd   %r14d,%xmm1
    7fe1:	0f 2e c9             	ucomiss %xmm1,%xmm1
    7fe4:	0f 8a 73 0d 00 00    	jp     8d5d <fwp_write+0x13cd>
    7fea:	0f 28 05 df 40 00 00 	movaps 0x40df(%rip),%xmm0        # c0d0 <_IO_stdin_used+0xd0>
    7ff1:	0f 54 c1             	andps  %xmm1,%xmm0
    7ff4:	0f 2e 05 09 40 00 00 	ucomiss 0x4009(%rip),%xmm0        # c004 <_IO_stdin_used+0x4>
    7ffb:	0f 82 6e 04 00 00    	jb     846f <fwp_write+0xadf>
    8001:	0f 57 c0             	xorps  %xmm0,%xmm0
    8004:	0f 2e c8             	ucomiss %xmm0,%xmm1
    8007:	48 8d 05 88 45 00 00 	lea    0x4588(%rip),%rax        # c596 <fwp_segv.msg+0x356>
    800e:	48 8d 35 80 45 00 00 	lea    0x4580(%rip),%rsi        # c595 <fwp_segv.msg+0x355>
    8015:	48 0f 47 f0          	cmova  %rax,%rsi
    8019:	48 8d 7c 24 70       	lea    0x70(%rsp),%rdi
    801e:	e8 6d a0 ff ff       	call   2090 <strcpy@plt>
    8023:	e9 90 0b 00 00       	jmp    8bb8 <fwp_write+0x1228>
    8028:	48 8d 35 19 45 00 00 	lea    0x4519(%rip),%rsi        # c548 <fwp_segv.msg+0x308>
    802f:	ba 0a 00 00 00       	mov    $0xa,%edx
    8034:	48 89 ef             	mov    %rbp,%rdi
    8037:	e9 06 09 00 00       	jmp    8942 <fwp_write+0xfb2>
    803c:	48 8d 35 19 45 00 00 	lea    0x4519(%rip),%rsi        # c55c <fwp_segv.msg+0x31c>
    8043:	ba 06 00 00 00       	mov    $0x6,%edx
    8048:	48 89 ef             	mov    %rbp,%rdi
    804b:	e8 20 0d 00 00       	call   8d70 <buf_put>
    8050:	49 83 c6 10          	add    $0x10,%r14
    8054:	4c 89 f7             	mov    %r14,%rdi
    8057:	e8 b4 a0 ff ff       	call   2110 <strlen@plt>
    805c:	48 89 ef             	mov    %rbp,%rdi
    805f:	4c 89 f6             	mov    %r14,%rsi
    8062:	48 89 c2             	mov    %rax,%rdx
    8065:	e8 06 0d 00 00       	call   8d70 <buf_put>
    806a:	c6 44 24 70 3e       	movb   $0x3e,0x70(%rsp)
    806f:	e9 f3 09 00 00       	jmp    8a67 <fwp_write+0x10d7>
    8074:	41 8b 06             	mov    (%r14),%eax
    8077:	49 8b 4f 18          	mov    0x18(%r15),%rcx
    807b:	41 89 c5             	mov    %eax,%r13d
    807e:	4e 8b 24 e9          	mov    (%rcx,%r13,8),%r12
    8082:	4c 89 e7             	mov    %r12,%rdi
    8085:	e8 86 a0 ff ff       	call   2110 <strlen@plt>
    808a:	48 89 ef             	mov    %rbp,%rdi
    808d:	4c 89 e6             	mov    %r12,%rsi
    8090:	48 89 c2             	mov    %rax,%rdx
    8093:	e8 d8 0c 00 00       	call   8d70 <buf_put>
    8098:	49 8b 47 28          	mov    0x28(%r15),%rax
    809c:	42 83 3c a8 00       	cmpl   $0x0,(%rax,%r13,4)
    80a1:	0f 8e 2c 0b 00 00    	jle    8bd3 <fwp_write+0x1243>
    80a7:	45 31 e4             	xor    %r12d,%r12d
    80aa:	4c 89 7c 24 10       	mov    %r15,0x10(%rsp)
    80af:	4c 89 6c 24 68       	mov    %r13,0x68(%rsp)
    80b4:	eb 3c                	jmp    80f2 <fwp_write+0x762>
    80b6:	66 2e 0f 1f 84 00 00 	cs nopw 0x0(%rax,%rax,1)
    80bd:	00 00 00 
    80c0:	48 8b 2c 24          	mov    (%rsp),%rbp
    80c4:	48 89 ef             	mov    %rbp,%rdi
    80c7:	48 89 de             	mov    %rbx,%rsi
    80ca:	4c 89 ea             	mov    %r13,%rdx
    80cd:	31 c9                	xor    %ecx,%ecx
    80cf:	e8 bc f8 ff ff       	call   7990 <fwp_write>
    80d4:	49 ff c4             	inc    %r12
    80d7:	4c 8b 7c 24 10       	mov    0x10(%rsp),%r15
    80dc:	49 8b 47 28          	mov    0x28(%r15),%rax
    80e0:	4c 8b 6c 24 68       	mov    0x68(%rsp),%r13
    80e5:	4a 63 04 a8          	movslq (%rax,%r13,4),%rax
    80e9:	49 39 c4             	cmp    %rax,%r12
    80ec:	0f 8d e1 0a 00 00    	jge    8bd3 <fwp_write+0x1243>
    80f2:	4b 8b 5c e6 08       	mov    0x8(%r14,%r12,8),%rbx
    80f7:	49 8b 47 30          	mov    0x30(%r15),%rax
    80fb:	4a 8b 04 e8          	mov    (%rax,%r13,8),%rax
    80ff:	4e 8b 2c e0          	mov    (%rax,%r12,8),%r13
    8103:	c6 44 24 70 20       	movb   $0x20,0x70(%rsp)
    8108:	ba 01 00 00 00       	mov    $0x1,%edx
    810d:	48 89 ef             	mov    %rbp,%rdi
    8110:	48 8d 74 24 70       	lea    0x70(%rsp),%rsi
    8115:	e8 56 0c 00 00       	call   8d70 <buf_put>
    811a:	41 8b 45 00          	mov    0x0(%r13),%eax
    811e:	48 83 f8 10          	cmp    $0x10,%rax
    8122:	77 9c                	ja     80c0 <fwp_write+0x730>
    8124:	48 8d 0d 4d 40 00 00 	lea    0x404d(%rip),%rcx        # c178 <_IO_stdin_used+0x178>
    812b:	48 63 04 81          	movslq (%rcx,%rax,4),%rax
    812f:	48 01 c8             	add    %rcx,%rax
    8132:	ff e0                	jmp    *%rax
    8134:	48 89 d9             	mov    %rbx,%rcx
    8137:	48 c1 e9 3f          	shr    $0x3f,%rcx
    813b:	85 c9                	test   %ecx,%ecx
    813d:	74 81                	je     80c0 <fwp_write+0x730>
    813f:	c6 44 24 70 28       	movb   $0x28,0x70(%rsp)
    8144:	ba 01 00 00 00       	mov    $0x1,%edx
    8149:	48 8b 2c 24          	mov    (%rsp),%rbp
    814d:	48 89 ef             	mov    %rbp,%rdi
    8150:	4c 8d 7c 24 70       	lea    0x70(%rsp),%r15
    8155:	4c 89 fe             	mov    %r15,%rsi
    8158:	e8 13 0c 00 00       	call   8d70 <buf_put>
    815d:	48 89 ef             	mov    %rbp,%rdi
    8160:	48 89 de             	mov    %rbx,%rsi
    8163:	4c 89 ea             	mov    %r13,%rdx
    8166:	31 c9                	xor    %ecx,%ecx
    8168:	e8 23 f8 ff ff       	call   7990 <fwp_write>
    816d:	c6 44 24 70 29       	movb   $0x29,0x70(%rsp)
    8172:	ba 01 00 00 00       	mov    $0x1,%edx
    8177:	48 89 ef             	mov    %rbp,%rdi
    817a:	4c 89 fe             	mov    %r15,%rsi
    817d:	e8 ee 0b 00 00       	call   8d70 <buf_put>
    8182:	e9 4d ff ff ff       	jmp    80d4 <fwp_write+0x744>
    8187:	31 c9                	xor    %ecx,%ecx
    8189:	48 81 fb 00 10 00 00 	cmp    $0x1000,%rbx
    8190:	0f 93 c1             	setae  %cl
    8193:	eb a6                	jmp    813b <fwp_write+0x7ab>
    8195:	48 8b 4b 08          	mov    0x8(%rbx),%rcx
    8199:	eb 9c                	jmp    8137 <fwp_write+0x7a7>
    819b:	89 d9                	mov    %ebx,%ecx
    819d:	c1 e9 1f             	shr    $0x1f,%ecx
    81a0:	eb 99                	jmp    813b <fwp_write+0x7ab>
    81a2:	49 8b 7d 08          	mov    0x8(%r13),%rdi
    81a6:	48 85 ff             	test   %rdi,%rdi
    81a9:	0f 84 11 ff ff ff    	je     80c0 <fwp_write+0x730>
    81af:	48 8d 35 cb 43 00 00 	lea    0x43cb(%rip),%rsi        # c581 <fwp_segv.msg+0x341>
    81b6:	e8 05 a0 ff ff       	call   21c0 <strcmp@plt>
    81bb:	31 c9                	xor    %ecx,%ecx
    81bd:	85 c0                	test   %eax,%eax
    81bf:	0f 95 c1             	setne  %cl
    81c2:	e9 74 ff ff ff       	jmp    813b <fwp_write+0x7ab>
    81c7:	41 83 7f 10 00       	cmpl   $0x0,0x10(%r15)
    81cc:	0f 84 a7 08 00 00    	je     8a79 <fwp_write+0x10e9>
    81d2:	4d 8d 6f 10          	lea    0x10(%r15),%r13
    81d6:	4d 85 e4             	test   %r12,%r12
    81d9:	0f 94 c0             	sete   %al
    81dc:	41 83 7f 48 00       	cmpl   $0x0,0x48(%r15)
    81e1:	0f 95 c3             	setne  %bl
    81e4:	20 c3                	and    %al,%bl
    81e6:	84 db                	test   %bl,%bl
    81e8:	b8 28 00 00 00       	mov    $0x28,%eax
    81ed:	b9 7b 00 00 00       	mov    $0x7b,%ecx
    81f2:	0f 45 c8             	cmovne %eax,%ecx
    81f5:	88 4c 24 70          	mov    %cl,0x70(%rsp)
    81f9:	48 8d 74 24 70       	lea    0x70(%rsp),%rsi
    81fe:	ba 01 00 00 00       	mov    $0x1,%edx
    8203:	48 89 ef             	mov    %rbp,%rdi
    8206:	e8 65 0b 00 00       	call   8d70 <buf_put>
    820b:	41 83 7d 00 00       	cmpl   $0x0,0x0(%r13)
    8210:	0f 8e da 00 00 00    	jle    82f0 <fwp_write+0x960>
    8216:	84 db                	test   %bl,%bl
    8218:	75 31                	jne    824b <fwp_write+0x8bb>
    821a:	49 8b 47 18          	mov    0x18(%r15),%rax
    821e:	4c 8b 20             	mov    (%rax),%r12
    8221:	4c 89 e7             	mov    %r12,%rdi
    8224:	e8 e7 9e ff ff       	call   2110 <strlen@plt>
    8229:	48 89 ef             	mov    %rbp,%rdi
    822c:	4c 89 e6             	mov    %r12,%rsi
    822f:	48 89 c2             	mov    %rax,%rdx
    8232:	e8 39 0b 00 00       	call   8d70 <buf_put>
    8237:	48 8d 35 4f 43 00 00 	lea    0x434f(%rip),%rsi        # c58d <fwp_segv.msg+0x34d>
    823e:	ba 03 00 00 00       	mov    $0x3,%edx
    8243:	48 89 ef             	mov    %rbp,%rdi
    8246:	e8 25 0b 00 00       	call   8d70 <buf_put>
    824b:	49 8b 76 08          	mov    0x8(%r14),%rsi
    824f:	49 8b 47 20          	mov    0x20(%r15),%rax
    8253:	48 8b 10             	mov    (%rax),%rdx
    8256:	48 89 ef             	mov    %rbp,%rdi
    8259:	31 c9                	xor    %ecx,%ecx
    825b:	e8 30 f7 ff ff       	call   7990 <fwp_write>
    8260:	41 83 7f 10 02       	cmpl   $0x2,0x10(%r15)
    8265:	0f 8c 85 00 00 00    	jl     82f0 <fwp_write+0x960>
    826b:	41 bd 01 00 00 00    	mov    $0x1,%r13d
    8271:	4c 8d 25 f2 42 00 00 	lea    0x42f2(%rip),%r12        # c56a <fwp_segv.msg+0x32a>
    8278:	eb 29                	jmp    82a3 <fwp_write+0x913>
    827a:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)
    8280:	4b 8b 74 ee 08       	mov    0x8(%r14,%r13,8),%rsi
    8285:	49 8b 47 20          	mov    0x20(%r15),%rax
    8289:	4a 8b 14 e8          	mov    (%rax,%r13,8),%rdx
    828d:	48 89 ef             	mov    %rbp,%rdi
    8290:	31 c9                	xor    %ecx,%ecx
    8292:	e8 f9 f6 ff ff       	call   7990 <fwp_write>
    8297:	49 ff c5             	inc    %r13
    829a:	49 63 47 10          	movslq 0x10(%r15),%rax
    829e:	49 39 c5             	cmp    %rax,%r13
    82a1:	7d 4d                	jge    82f0 <fwp_write+0x960>
    82a3:	ba 02 00 00 00       	mov    $0x2,%edx
    82a8:	48 89 ef             	mov    %rbp,%rdi
    82ab:	4c 89 e6             	mov    %r12,%rsi
    82ae:	e8 bd 0a 00 00       	call   8d70 <buf_put>
    82b3:	84 db                	test   %bl,%bl
    82b5:	75 c9                	jne    8280 <fwp_write+0x8f0>
    82b7:	49 8b 47 18          	mov    0x18(%r15),%rax
    82bb:	4a 8b 2c e8          	mov    (%rax,%r13,8),%rbp
    82bf:	48 89 ef             	mov    %rbp,%rdi
    82c2:	e8 49 9e ff ff       	call   2110 <strlen@plt>
    82c7:	48 8b 3c 24          	mov    (%rsp),%rdi
    82cb:	48 89 ee             	mov    %rbp,%rsi
    82ce:	48 8b 2c 24          	mov    (%rsp),%rbp
    82d2:	48 89 c2             	mov    %rax,%rdx
    82d5:	e8 96 0a 00 00       	call   8d70 <buf_put>
    82da:	ba 03 00 00 00       	mov    $0x3,%edx
    82df:	48 89 ef             	mov    %rbp,%rdi
    82e2:	48 8d 35 a4 42 00 00 	lea    0x42a4(%rip),%rsi        # c58d <fwp_segv.msg+0x34d>
    82e9:	e8 82 0a 00 00       	call   8d70 <buf_put>
    82ee:	eb 90                	jmp    8280 <fwp_write+0x8f0>
    82f0:	84 db                	test   %bl,%bl
    82f2:	b8 29 00 00 00       	mov    $0x29,%eax
    82f7:	b9 7d 00 00 00       	mov    $0x7d,%ecx
    82fc:	0f 45 c8             	cmovne %eax,%ecx
    82ff:	88 4c 24 70          	mov    %cl,0x70(%rsp)
    8303:	e9 5f 07 00 00       	jmp    8a67 <fwp_write+0x10d7>
    8308:	48 89 ef             	mov    %rbp,%rdi
    830b:	48 81 c4 78 02 00 00 	add    $0x278,%rsp
    8312:	5b                   	pop    %rbx
    8313:	41 5c                	pop    %r12
    8315:	41 5d                	pop    %r13
    8317:	41 5e                	pop    %r14
    8319:	41 5f                	pop    %r15
    831b:	5d                   	pop    %rbp
    831c:	e9 3f 0b 00 00       	jmp    8e60 <fwp_escape>
    8321:	c6 44 24 20 30       	movb   $0x30,0x20(%rsp)
    8326:	bf 01 00 00 00       	mov    $0x1,%edi
    832b:	89 f8                	mov    %edi,%eax
    832d:	48 83 f8 08          	cmp    $0x8,%rax
    8331:	73 0a                	jae    833d <fwp_write+0x9ad>
    8333:	31 c9                	xor    %ecx,%ecx
    8335:	48 89 c2             	mov    %rax,%rdx
    8338:	e9 7a 04 00 00       	jmp    87b7 <fwp_write+0xe27>
    833d:	83 f8 20             	cmp    $0x20,%eax
    8340:	0f 83 68 03 00 00    	jae    86ae <fwp_write+0xd1e>
    8346:	31 c9                	xor    %ecx,%ecx
    8348:	e9 10 04 00 00       	jmp    875d <fwp_write+0xdcd>
    834d:	31 ff                	xor    %edi,%edi
    834f:	49 f7 d8             	neg    %r8
    8352:	41 ba 00 00 00 00    	mov    $0x0,%r10d
    8358:	4d 19 ca             	sbb    %r9,%r10
    835b:	c6 44 24 70 2d       	movb   $0x2d,0x70(%rsp)
    8360:	49 b9 cd cc cc cc cc 	movabs $0xcccccccccccccccd,%r9
    8367:	cc cc cc 
    836a:	49 bb cc cc cc cc cc 	movabs $0xcccccccccccccccc,%r11
    8371:	cc cc cc 
    8374:	4c 89 d3             	mov    %r10,%rbx
    8377:	66 0f 1f 84 00 00 00 	nopw   0x0(%rax,%rax,1)
    837e:	00 00 
    8380:	4c 89 d1             	mov    %r10,%rcx
    8383:	4c 0f a4 c1 3f       	shld   $0x3f,%r8,%rcx
    8388:	48 d1 eb             	shr    $1,%rbx
    838b:	48 89 ce             	mov    %rcx,%rsi
    838e:	48 01 de             	add    %rbx,%rsi
    8391:	48 83 d6 00          	adc    $0x0,%rsi
    8395:	48 89 f0             	mov    %rsi,%rax
    8398:	49 f7 e1             	mul    %r9
    839b:	48 c1 ea 02          	shr    $0x2,%rdx
    839f:	48 8d 04 92          	lea    (%rdx,%rdx,4),%rax
    83a3:	48 29 c6             	sub    %rax,%rsi
    83a6:	48 29 f1             	sub    %rsi,%rcx
    83a9:	48 83 db 00          	sbb    $0x0,%rbx
    83ad:	48 89 ce             	mov    %rcx,%rsi
    83b0:	49 0f af f3          	imul   %r11,%rsi
    83b4:	48 89 c8             	mov    %rcx,%rax
    83b7:	49 f7 e1             	mul    %r9
    83ba:	48 01 f2             	add    %rsi,%rdx
    83bd:	49 0f af d9          	imul   %r9,%rbx
    83c1:	48 01 d3             	add    %rdx,%rbx
    83c4:	48 89 c1             	mov    %rax,%rcx
    83c7:	48 01 c1             	add    %rax,%rcx
    83ca:	48 8d 0c 89          	lea    (%rcx,%rcx,4),%rcx
    83ce:	44 89 c2             	mov    %r8d,%edx
    83d1:	29 ca                	sub    %ecx,%edx
    83d3:	80 ca 30             	or     $0x30,%dl
    83d6:	88 54 3c 20          	mov    %dl,0x20(%rsp,%rdi,1)
    83da:	48 ff c7             	inc    %rdi
    83dd:	49 83 f8 0a          	cmp    $0xa,%r8
    83e1:	49 83 da 00          	sbb    $0x0,%r10
    83e5:	49 89 c0             	mov    %rax,%r8
    83e8:	49 89 da             	mov    %rbx,%r10
    83eb:	73 93                	jae    8380 <fwp_write+0x9f0>
    83ed:	85 ff                	test   %edi,%edi
    83ef:	0f 8e 98 06 00 00    	jle    8a8d <fwp_write+0x10fd>
    83f5:	89 f8                	mov    %edi,%eax
    83f7:	48 83 f8 08          	cmp    $0x8,%rax
    83fb:	0f 83 e4 07 00 00    	jae    8be5 <fwp_write+0x1255>
    8401:	31 c9                	xor    %ecx,%ecx
    8403:	48 89 c2             	mov    %rax,%rdx
    8406:	e9 fc 08 00 00       	jmp    8d07 <fwp_write+0x1377>
    840b:	bd 01 00 00 00       	mov    $0x1,%ebp
    8410:	4c 8d 74 24 70       	lea    0x70(%rsp),%r14
    8415:	0f 29 4c 24 10       	movaps %xmm1,0x10(%rsp)
    841a:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)
    8420:	4c 89 f7             	mov    %r14,%rdi
    8423:	66 0f 28 c1          	movapd %xmm1,%xmm0
    8427:	89 ee                	mov    %ebp,%esi
    8429:	e8 a2 16 00 00       	call   9ad0 <fwp_format_g>
    842e:	4c 89 f7             	mov    %r14,%rdi
    8431:	31 f6                	xor    %esi,%esi
    8433:	e8 98 9c ff ff       	call   20d0 <strtod@plt>
    8438:	66 0f 28 4c 24 10    	movapd 0x10(%rsp),%xmm1
    843e:	66 0f 2e c1          	ucomisd %xmm1,%xmm0
    8442:	75 06                	jne    844a <fwp_write+0xaba>
    8444:	0f 8b 9e 03 00 00    	jnp    87e8 <fwp_write+0xe58>
    844a:	ff c5                	inc    %ebp
    844c:	83 fd 12             	cmp    $0x12,%ebp
    844f:	75 cf                	jne    8420 <fwp_write+0xa90>
    8451:	4c 8d 74 24 70       	lea    0x70(%rsp),%r14
    8456:	4c 89 f7             	mov    %r14,%rdi
    8459:	66 0f 28 c1          	movapd %xmm1,%xmm0
    845d:	be 11 00 00 00       	mov    $0x11,%esi
    8462:	e8 69 16 00 00       	call   9ad0 <fwp_format_g>
    8467:	4c 89 f7             	mov    %r14,%rdi
    846a:	e9 7e 03 00 00       	jmp    87ed <fwp_write+0xe5d>
    846f:	0f 57 c0             	xorps  %xmm0,%xmm0
    8472:	f3 0f 5a c1          	cvtss2sd %xmm1,%xmm0
    8476:	4c 8d 74 24 70       	lea    0x70(%rsp),%r14
    847b:	4c 89 f7             	mov    %r14,%rdi
    847e:	f2 0f 11 44 24 10    	movsd  %xmm0,0x10(%rsp)
    8484:	be 01 00 00 00       	mov    $0x1,%esi
    8489:	0f 29 0c 24          	movaps %xmm1,(%rsp)
    848d:	e8 3e 16 00 00       	call   9ad0 <fwp_format_g>
    8492:	4c 89 f7             	mov    %r14,%rdi
    8495:	31 f6                	xor    %esi,%esi
    8497:	e8 b4 9c ff ff       	call   2150 <strtof@plt>
    849c:	0f 2e 04 24          	ucomiss (%rsp),%xmm0
    84a0:	75 06                	jne    84a8 <fwp_write+0xb18>
    84a2:	0f 8b 6f 01 00 00    	jnp    8617 <fwp_write+0xc87>
    84a8:	4c 8d 74 24 70       	lea    0x70(%rsp),%r14
    84ad:	4c 89 f7             	mov    %r14,%rdi
    84b0:	f2 0f 10 44 24 10    	movsd  0x10(%rsp),%xmm0
    84b6:	be 02 00 00 00       	mov    $0x2,%esi
    84bb:	e8 10 16 00 00       	call   9ad0 <fwp_format_g>
    84c0:	4c 89 f7             	mov    %r14,%rdi
    84c3:	31 f6                	xor    %esi,%esi
    84c5:	e8 86 9c ff ff       	call   2150 <strtof@plt>
    84ca:	0f 2e 04 24          	ucomiss (%rsp),%xmm0
    84ce:	75 06                	jne    84d6 <fwp_write+0xb46>
    84d0:	0f 8b 41 01 00 00    	jnp    8617 <fwp_write+0xc87>
    84d6:	4c 8d 74 24 70       	lea    0x70(%rsp),%r14
    84db:	4c 89 f7             	mov    %r14,%rdi
    84de:	f2 0f 10 44 24 10    	movsd  0x10(%rsp),%xmm0
    84e4:	be 03 00 00 00       	mov    $0x3,%esi
    84e9:	e8 e2 15 00 00       	call   9ad0 <fwp_format_g>
    84ee:	4c 89 f7             	mov    %r14,%rdi
    84f1:	31 f6                	xor    %esi,%esi
    84f3:	e8 58 9c ff ff       	call   2150 <strtof@plt>
    84f8:	0f 2e 04 24          	ucomiss (%rsp),%xmm0
    84fc:	75 06                	jne    8504 <fwp_write+0xb74>
    84fe:	0f 8b 13 01 00 00    	jnp    8617 <fwp_write+0xc87>
    8504:	4c 8d 74 24 70       	lea    0x70(%rsp),%r14
    8509:	4c 89 f7             	mov    %r14,%rdi
    850c:	f2 0f 10 44 24 10    	movsd  0x10(%rsp),%xmm0
    8512:	be 04 00 00 00       	mov    $0x4,%esi
    8517:	e8 b4 15 00 00       	call   9ad0 <fwp_format_g>
    851c:	4c 89 f7             	mov    %r14,%rdi
    851f:	31 f6                	xor    %esi,%esi
    8521:	e8 2a 9c ff ff       	call   2150 <strtof@plt>
    8526:	0f 2e 04 24          	ucomiss (%rsp),%xmm0
    852a:	75 06                	jne    8532 <fwp_write+0xba2>
    852c:	0f 8b e5 00 00 00    	jnp    8617 <fwp_write+0xc87>
    8532:	4c 8d 74 24 70       	lea    0x70(%rsp),%r14
    8537:	4c 89 f7             	mov    %r14,%rdi
    853a:	f2 0f 10 44 24 10    	movsd  0x10(%rsp),%xmm0
    8540:	be 05 00 00 00       	mov    $0x5,%esi
    8545:	e8 86 15 00 00       	call   9ad0 <fwp_format_g>
    854a:	4c 89 f7             	mov    %r14,%rdi
    854d:	31 f6                	xor    %esi,%esi
    854f:	e8 fc 9b ff ff       	call   2150 <strtof@plt>
    8554:	0f 2e 04 24          	ucomiss (%rsp),%xmm0
    8558:	75 06                	jne    8560 <fwp_write+0xbd0>
    855a:	0f 8b b7 00 00 00    	jnp    8617 <fwp_write+0xc87>
    8560:	4c 8d 74 24 70       	lea    0x70(%rsp),%r14
    8565:	4c 89 f7             	mov    %r14,%rdi
    8568:	f2 0f 10 44 24 10    	movsd  0x10(%rsp),%xmm0
    856e:	be 06 00 00 00       	mov    $0x6,%esi
    8573:	e8 58 15 00 00       	call   9ad0 <fwp_format_g>
    8578:	4c 89 f7             	mov    %r14,%rdi
    857b:	31 f6                	xor    %esi,%esi
    857d:	e8 ce 9b ff ff       	call   2150 <strtof@plt>
    8582:	0f 2e 04 24          	ucomiss (%rsp),%xmm0
    8586:	75 06                	jne    858e <fwp_write+0xbfe>
    8588:	0f 8b 89 00 00 00    	jnp    8617 <fwp_write+0xc87>
    858e:	4c 8d 74 24 70       	lea    0x70(%rsp),%r14
    8593:	4c 89 f7             	mov    %r14,%rdi
    8596:	f2 0f 10 44 24 10    	movsd  0x10(%rsp),%xmm0
    859c:	be 07 00 00 00       	mov    $0x7,%esi
    85a1:	e8 2a 15 00 00       	call   9ad0 <fwp_format_g>
    85a6:	4c 89 f7             	mov    %r14,%rdi
    85a9:	31 f6                	xor    %esi,%esi
    85ab:	e8 a0 9b ff ff       	call   2150 <strtof@plt>
    85b0:	0f 2e 04 24          	ucomiss (%rsp),%xmm0
    85b4:	75 02                	jne    85b8 <fwp_write+0xc28>
    85b6:	7b 5f                	jnp    8617 <fwp_write+0xc87>
    85b8:	4c 8d 74 24 70       	lea    0x70(%rsp),%r14
    85bd:	4c 89 f7             	mov    %r14,%rdi
    85c0:	f2 0f 10 44 24 10    	movsd  0x10(%rsp),%xmm0
    85c6:	be 08 00 00 00       	mov    $0x8,%esi
    85cb:	e8 00 15 00 00       	call   9ad0 <fwp_format_g>
    85d0:	4c 89 f7             	mov    %r14,%rdi
    85d3:	31 f6                	xor    %esi,%esi
    85d5:	e8 76 9b ff ff       	call   2150 <strtof@plt>
    85da:	0f 28 0c 24          	movaps (%rsp),%xmm1
    85de:	0f 2e c1             	ucomiss %xmm1,%xmm0
    85e1:	75 02                	jne    85e5 <fwp_write+0xc55>
    85e3:	7b 32                	jnp    8617 <fwp_write+0xc87>
    85e5:	4c 8d 74 24 70       	lea    0x70(%rsp),%r14
    85ea:	4c 89 f7             	mov    %r14,%rdi
    85ed:	f2 0f 10 44 24 10    	movsd  0x10(%rsp),%xmm0
    85f3:	be 09 00 00 00       	mov    $0x9,%esi
    85f8:	e8 d3 14 00 00       	call   9ad0 <fwp_format_g>
    85fd:	4c 89 f7             	mov    %r14,%rdi
    8600:	31 f6                	xor    %esi,%esi
    8602:	e8 49 9b ff ff       	call   2150 <strtof@plt>
    8607:	0f 2e 04 24          	ucomiss (%rsp),%xmm0
    860b:	0f 85 2c 07 00 00    	jne    8d3d <fwp_write+0x13ad>
    8611:	0f 8a 26 07 00 00    	jp     8d3d <fwp_write+0x13ad>
    8617:	48 8d 7c 24 70       	lea    0x70(%rsp),%rdi
    861c:	be 2e 00 00 00       	mov    $0x2e,%esi
    8621:	e8 0a 9b ff ff       	call   2130 <strchr@plt>
    8626:	48 85 c0             	test   %rax,%rax
    8629:	0f 85 89 05 00 00    	jne    8bb8 <fwp_write+0x1228>
    862f:	e9 d0 01 00 00       	jmp    8804 <fwp_write+0xe74>
    8634:	4c 8b bc f0 d0 03 00 	mov    0x3d0(%rax,%rsi,8),%r15
    863b:	00 
    863c:	48 8b bc f0 d8 03 00 	mov    0x3d8(%rax,%rsi,8),%rdi
    8643:	00 
    8644:	4c 29 ff             	sub    %r15,%rdi
    8647:	48 39 cf             	cmp    %rcx,%rdi
    864a:	0f 83 1b 02 00 00    	jae    886b <fwp_write+0xedb>
    8650:	48 89 d7             	mov    %rdx,%rdi
    8653:	be 01 00 00 00       	mov    $0x1,%esi
    8658:	e8 13 cf ff ff       	call   5570 <fwp_gc_alloc_slow>
    865d:	49 89 c7             	mov    %rax,%r15
    8660:	e9 20 02 00 00       	jmp    8885 <fwp_write+0xef5>
    8665:	49 8b 76 08          	mov    0x8(%r14),%rsi
    8669:	48 89 f2             	mov    %rsi,%rdx
    866c:	48 c1 fa 3f          	sar    $0x3f,%rdx
    8670:	4c 8d 74 24 70       	lea    0x70(%rsp),%r14
    8675:	4c 89 f7             	mov    %r14,%rdi
    8678:	e8 23 09 00 00       	call   8fa0 <fwp_fmt_duration>
    867d:	e9 3b 05 00 00       	jmp    8bbd <fwp_write+0x122d>
    8682:	c6 44 24 20 30       	movb   $0x30,0x20(%rsp)
    8687:	bf 01 00 00 00       	mov    $0x1,%edi
    868c:	89 f8                	mov    %edi,%eax
    868e:	48 83 f8 08          	cmp    $0x8,%rax
    8692:	73 0a                	jae    869e <fwp_write+0xd0e>
    8694:	31 c9                	xor    %ecx,%ecx
    8696:	48 89 c2             	mov    %rax,%rdx
    8699:	e9 f2 04 00 00       	jmp    8b90 <fwp_write+0x1200>
    869e:	83 f8 20             	cmp    $0x20,%eax
    86a1:	0f 83 f2 03 00 00    	jae    8a99 <fwp_write+0x1109>
    86a7:	31 c9                	xor    %ecx,%ecx
    86a9:	e9 92 04 00 00       	jmp    8b40 <fwp_write+0x11b0>
    86ae:	89 fa                	mov    %edi,%edx
    86b0:	83 e2 1f             	and    $0x1f,%edx
    86b3:	48 89 c1             	mov    %rax,%rcx
    86b6:	48 29 d1             	sub    %rdx,%rcx
    86b9:	48 8d b4 24 80 00 00 	lea    0x80(%rsp),%rsi
    86c0:	00 
    86c1:	66 0f ef c0          	pxor   %xmm0,%xmm0
    86c5:	49 89 c0             	mov    %rax,%r8
    86c8:	0f 1f 84 00 00 00 00 	nopl   0x0(%rax,%rax,1)
    86cf:	00 
    86d0:	f3 42 0f 6f 0c 04    	movdqu (%rsp,%r8,1),%xmm1
    86d6:	f3 42 0f 6f 54 04 10 	movdqu 0x10(%rsp,%r8,1),%xmm2
    86dd:	66 0f 6f da          	movdqa %xmm2,%xmm3
    86e1:	66 0f 60 d8          	punpcklbw %xmm0,%xmm3
    86e5:	66 0f 70 db 4e       	pshufd $0x4e,%xmm3,%xmm3
    86ea:	f2 0f 70 db 1b       	pshuflw $0x1b,%xmm3,%xmm3
    86ef:	f3 0f 70 db 1b       	pshufhw $0x1b,%xmm3,%xmm3
    86f4:	66 0f 68 d0          	punpckhbw %xmm0,%xmm2
    86f8:	66 0f 70 d2 4e       	pshufd $0x4e,%xmm2,%xmm2
    86fd:	f2 0f 70 d2 1b       	pshuflw $0x1b,%xmm2,%xmm2
    8702:	f3 0f 70 d2 1b       	pshufhw $0x1b,%xmm2,%xmm2
    8707:	66 0f 67 d3          	packuswb %xmm3,%xmm2
    870b:	66 0f 6f d9          	movdqa %xmm1,%xmm3
    870f:	66 0f 60 d8          	punpcklbw %xmm0,%xmm3
    8713:	66 0f 70 db 4e       	pshufd $0x4e,%xmm3,%xmm3
    8718:	f2 0f 70 db 1b       	pshuflw $0x1b,%xmm3,%xmm3
    871d:	f3 0f 70 db 1b       	pshufhw $0x1b,%xmm3,%xmm3
    8722:	66 0f 68 c8          	punpckhbw %xmm0,%xmm1
    8726:	66 0f 70 c9 4e       	pshufd $0x4e,%xmm1,%xmm1
    872b:	f2 0f 70 c9 1b       	pshuflw $0x1b,%xmm1,%xmm1
    8730:	f3 0f 70 c9 1b       	pshufhw $0x1b,%xmm1,%xmm1
    8735:	66 0f 67 cb          	packuswb %xmm3,%xmm1
    8739:	66 0f 7f 56 f0       	movdqa %xmm2,-0x10(%rsi)
    873e:	66 0f 7f 0e          	movdqa %xmm1,(%rsi)
    8742:	49 83 c0 e0          	add    $0xffffffffffffffe0,%r8
    8746:	48 83 c6 20          	add    $0x20,%rsi
    874a:	4c 39 c2             	cmp    %r8,%rdx
    874d:	75 81                	jne    86d0 <fwp_write+0xd40>
    874f:	48 85 d2             	test   %rdx,%rdx
    8752:	0f 84 5b 04 00 00    	je     8bb3 <fwp_write+0x1223>
    8758:	83 fa 08             	cmp    $0x8,%edx
    875b:	72 5a                	jb     87b7 <fwp_write+0xe27>
    875d:	89 fa                	mov    %edi,%edx
    875f:	83 e2 07             	and    $0x7,%edx
    8762:	48 89 c6             	mov    %rax,%rsi
    8765:	48 29 ce             	sub    %rcx,%rsi
    8768:	48 8d 3c 0c          	lea    (%rsp,%rcx,1),%rdi
    876c:	48 83 c7 70          	add    $0x70,%rdi
    8770:	48 89 c1             	mov    %rax,%rcx
    8773:	48 29 d1             	sub    %rdx,%rcx
    8776:	66 0f ef c0          	pxor   %xmm0,%xmm0
    877a:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)
    8780:	f3 0f 7e 4c 34 18    	movq   0x18(%rsp,%rsi,1),%xmm1
    8786:	66 0f 60 c8          	punpcklbw %xmm0,%xmm1
    878a:	66 0f 70 c9 4e       	pshufd $0x4e,%xmm1,%xmm1
    878f:	f2 0f 70 c9 1b       	pshuflw $0x1b,%xmm1,%xmm1
    8794:	f3 0f 70 c9 1b       	pshufhw $0x1b,%xmm1,%xmm1
    8799:	66 0f 67 c9          	packuswb %xmm1,%xmm1
    879d:	66 0f d6 0f          	movq   %xmm1,(%rdi)
    87a1:	48 83 c6 f8          	add    $0xfffffffffffffff8,%rsi
    87a5:	48 83 c7 08          	add    $0x8,%rdi
    87a9:	48 39 f2             	cmp    %rsi,%rdx
    87ac:	75 d2                	jne    8780 <fwp_write+0xdf0>
    87ae:	48 85 d2             	test   %rdx,%rdx
    87b1:	0f 84 fc 03 00 00    	je     8bb3 <fwp_write+0x1223>
    87b7:	48 8d 74 24 20       	lea    0x20(%rsp),%rsi
    87bc:	48 01 f2             	add    %rsi,%rdx
    87bf:	48 ff ca             	dec    %rdx
    87c2:	66 66 66 66 66 2e 0f 	data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    87c9:	1f 84 00 00 00 00 00 
    87d0:	0f b6 32             	movzbl (%rdx),%esi
    87d3:	40 88 74 0c 70       	mov    %sil,0x70(%rsp,%rcx,1)
    87d8:	48 ff c1             	inc    %rcx
    87db:	48 ff ca             	dec    %rdx
    87de:	48 39 c8             	cmp    %rcx,%rax
    87e1:	75 ed                	jne    87d0 <fwp_write+0xe40>
    87e3:	e9 cb 03 00 00       	jmp    8bb3 <fwp_write+0x1223>
    87e8:	48 8d 7c 24 70       	lea    0x70(%rsp),%rdi
    87ed:	be 2e 00 00 00       	mov    $0x2e,%esi
    87f2:	e8 39 99 ff ff       	call   2130 <strchr@plt>
    87f7:	48 85 c0             	test   %rax,%rax
    87fa:	48 8b 2c 24          	mov    (%rsp),%rbp
    87fe:	0f 85 b4 03 00 00    	jne    8bb8 <fwp_write+0x1228>
    8804:	48 8d 7c 24 70       	lea    0x70(%rsp),%rdi
    8809:	be 65 00 00 00       	mov    $0x65,%esi
    880e:	e8 1d 99 ff ff       	call   2130 <strchr@plt>
    8813:	48 85 c0             	test   %rax,%rax
    8816:	0f 85 9c 03 00 00    	jne    8bb8 <fwp_write+0x1228>
    881c:	48 8d 35 73 3d 00 00 	lea    0x3d73(%rip),%rsi        # c596 <fwp_segv.msg+0x356>
    8823:	48 8d 7c 24 70       	lea    0x70(%rsp),%rdi
    8828:	e8 03 9b ff ff       	call   2330 <strstr@plt>
    882d:	48 85 c0             	test   %rax,%rax
    8830:	0f 85 82 03 00 00    	jne    8bb8 <fwp_write+0x1228>
    8836:	48 8d 35 54 3d 00 00 	lea    0x3d54(%rip),%rsi        # c591 <fwp_segv.msg+0x351>
    883d:	48 8d 7c 24 70       	lea    0x70(%rsp),%rdi
    8842:	e8 e9 9a ff ff       	call   2330 <strstr@plt>
    8847:	48 85 c0             	test   %rax,%rax
    884a:	0f 85 68 03 00 00    	jne    8bb8 <fwp_write+0x1228>
    8850:	48 8d 7c 24 70       	lea    0x70(%rsp),%rdi
    8855:	e8 b6 98 ff ff       	call   2110 <strlen@plt>
    885a:	66 c7 44 04 70 2e 30 	movw   $0x302e,0x70(%rsp,%rax,1)
    8861:	c6 44 04 72 00       	movb   $0x0,0x72(%rsp,%rax,1)
    8866:	e9 4d 03 00 00       	jmp    8bb8 <fwp_write+0x1228>
    886b:	48 8d 04 f0          	lea    (%rax,%rsi,8),%rax
    886f:	48 05 d0 03 00 00    	add    $0x3d0,%rax
    8875:	4c 01 f9             	add    %r15,%rcx
    8878:	48 89 08             	mov    %rcx,(%rax)
    887b:	4c 89 ff             	mov    %r15,%rdi
    887e:	31 f6                	xor    %esi,%esi
    8880:	e8 db 98 ff ff       	call   2160 <memset@plt>
    8885:	66 41 c7 07 30 74    	movw   $0x7430,(%r15)
    888b:	85 db                	test   %ebx,%ebx
    888d:	0f 8e 98 00 00 00    	jle    892b <fwp_write+0xf9b>
    8893:	44 89 e1             	mov    %r12d,%ecx
    8896:	48 f7 d9             	neg    %rcx
    8899:	4a 8d 34 3b          	lea    (%rbx,%r15,1),%rsi
    889d:	48 ff c6             	inc    %rsi
    88a0:	31 ff                	xor    %edi,%edi
    88a2:	49 b8 56 55 55 55 55 	movabs $0x5555555555555556,%r8
    88a9:	55 55 55 
    88ac:	eb 2e                	jmp    88dc <fwp_write+0xf4c>
    88ae:	66 90                	xchg   %ax,%ax
    88b0:	41 b2 30             	mov    $0x30,%r10b
    88b3:	44 88 14 3e          	mov    %r10b,(%rsi,%rdi,1)
    88b7:	48 85 d2             	test   %rdx,%rdx
    88ba:	0f 95 c2             	setne  %dl
    88bd:	4d 85 f6             	test   %r14,%r14
    88c0:	41 0f 98 c2          	sets   %r10b
    88c4:	41 20 d2             	and    %dl,%r10b
    88c7:	41 0f b6 d2          	movzbl %r10b,%edx
    88cb:	48 29 d0             	sub    %rdx,%rax
    88ce:	4c 01 c8             	add    %r9,%rax
    88d1:	48 ff cf             	dec    %rdi
    88d4:	49 89 c6             	mov    %rax,%r14
    88d7:	48 39 f9             	cmp    %rdi,%rcx
    88da:	74 4f                	je     892b <fwp_write+0xf9b>
    88dc:	4c 89 f0             	mov    %r14,%rax
    88df:	49 f7 e8             	imul   %r8
    88e2:	48 89 d0             	mov    %rdx,%rax
    88e5:	48 c1 e8 3f          	shr    $0x3f,%rax
    88e9:	48 01 d0             	add    %rdx,%rax
    88ec:	4c 8d 0c 40          	lea    (%rax,%rax,2),%r9
    88f0:	4c 89 f2             	mov    %r14,%rdx
    88f3:	4c 29 ca             	sub    %r9,%rdx
    88f6:	49 f7 d9             	neg    %r9
    88f9:	4d 01 f1             	add    %r14,%r9
    88fc:	49 83 c1 03          	add    $0x3,%r9
    8900:	48 83 fa fd          	cmp    $0xfffffffffffffffd,%rdx
    8904:	4c 0f 42 ca          	cmovb  %rdx,%r9
    8908:	4d 85 c9             	test   %r9,%r9
    890b:	74 a3                	je     88b0 <fwp_write+0xf20>
    890d:	49 83 f9 01          	cmp    $0x1,%r9
    8911:	75 0d                	jne    8920 <fwp_write+0xf90>
    8913:	41 b2 2b             	mov    $0x2b,%r10b
    8916:	45 31 c9             	xor    %r9d,%r9d
    8919:	eb 98                	jmp    88b3 <fwp_write+0xf23>
    891b:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)
    8920:	41 b2 2d             	mov    $0x2d,%r10b
    8923:	41 b9 01 00 00 00    	mov    $0x1,%r9d
    8929:	eb 88                	jmp    88b3 <fwp_write+0xf23>
    892b:	43 c6 44 27 02 00    	movb   $0x0,0x2(%r15,%r12,1)
    8931:	4c 89 ff             	mov    %r15,%rdi
    8934:	e8 d7 97 ff ff       	call   2110 <strlen@plt>
    8939:	48 89 ef             	mov    %rbp,%rdi
    893c:	4c 89 fe             	mov    %r15,%rsi
    893f:	48 89 c2             	mov    %rax,%rdx
    8942:	48 81 c4 78 02 00 00 	add    $0x278,%rsp
    8949:	5b                   	pop    %rbx
    894a:	41 5c                	pop    %r12
    894c:	41 5d                	pop    %r13
    894e:	41 5e                	pop    %r14
    8950:	41 5f                	pop    %r15
    8952:	5d                   	pop    %rbp
    8953:	e9 18 04 00 00       	jmp    8d70 <buf_put>
    8958:	48 8b 31             	mov    (%rcx),%rsi
    895b:	eb 18                	jmp    8975 <fwp_write+0xfe5>
    895d:	83 3a 00             	cmpl   $0x0,(%rdx)
    8960:	0f b6 01             	movzbl (%rcx),%eax
    8963:	48 0f be f0          	movsbq %al,%rsi
    8967:	eb 08                	jmp    8971 <fwp_write+0xfe1>
    8969:	83 3a 02             	cmpl   $0x2,(%rdx)
    896c:	8b 01                	mov    (%rcx),%eax
    896e:	48 63 f0             	movslq %eax,%rsi
    8971:	48 0f 45 f0          	cmovne %rax,%rsi
    8975:	48 8b 2c 24          	mov    (%rsp),%rbp
    8979:	48 89 ef             	mov    %rbp,%rdi
    897c:	31 c9                	xor    %ecx,%ecx
    897e:	e8 0d f0 ff ff       	call   7990 <fwp_write>
    8983:	48 b8 ff ff ff ff ff 	movabs $0x7fffffffffffffff,%rax
    898a:	ff ff 7f 
    898d:	48 ff c8             	dec    %rax
    8990:	49 85 06             	test   %rax,(%r14)
    8993:	0f 84 c9 00 00 00    	je     8a62 <fwp_write+0x10d2>
    8999:	bb 01 00 00 00       	mov    $0x1,%ebx
    899e:	4c 8d 25 c5 3b 00 00 	lea    0x3bc5(%rip),%r12        # c56a <fwp_segv.msg+0x32a>
    89a5:	eb 39                	jmp    89e0 <fwp_write+0x1050>
    89a7:	83 3a 01             	cmpl   $0x1,(%rdx)
    89aa:	0f b7 04 31          	movzwl (%rcx,%rsi,1),%eax
    89ae:	48 0f bf f0          	movswq %ax,%rsi
    89b2:	48 0f 45 f0          	cmovne %rax,%rsi
    89b6:	48 8b 2c 24          	mov    (%rsp),%rbp
    89ba:	48 89 ef             	mov    %rbp,%rdi
    89bd:	31 c9                	xor    %ecx,%ecx
    89bf:	e8 cc ef ff ff       	call   7990 <fwp_write>
    89c4:	48 ff c3             	inc    %rbx
    89c7:	49 8b 06             	mov    (%r14),%rax
    89ca:	48 b9 ff ff ff ff ff 	movabs $0x7fffffffffffffff,%rcx
    89d1:	ff ff 7f 
    89d4:	48 21 c8             	and    %rcx,%rax
    89d7:	48 39 c3             	cmp    %rax,%rbx
    89da:	0f 83 82 00 00 00    	jae    8a62 <fwp_write+0x10d2>
    89e0:	ba 02 00 00 00       	mov    $0x2,%edx
    89e5:	48 89 ef             	mov    %rbp,%rdi
    89e8:	4c 89 e6             	mov    %r12,%rsi
    89eb:	e8 80 03 00 00       	call   8d70 <buf_put>
    89f0:	49 8b 57 38          	mov    0x38(%r15),%rdx
    89f4:	b8 08 00 00 00       	mov    $0x8,%eax
    89f9:	48 85 d2             	test   %rdx,%rdx
    89fc:	74 13                	je     8a11 <fwp_write+0x1081>
    89fe:	8b 0a                	mov    (%rdx),%ecx
    8a00:	48 83 f9 0a          	cmp    $0xa,%rcx
    8a04:	77 0b                	ja     8a11 <fwp_write+0x1081>
    8a06:	48 8d 05 53 38 00 00 	lea    0x3853(%rip),%rax        # c260 <fwp_segv.msg+0x20>
    8a0d:	48 8b 04 c8          	mov    (%rax,%rcx,8),%rax
    8a11:	49 83 3e 00          	cmpq   $0x0,(%r14)
    8a15:	4c 89 e9             	mov    %r13,%rcx
    8a18:	79 04                	jns    8a1e <fwp_write+0x108e>
    8a1a:	49 8b 4e 10          	mov    0x10(%r14),%rcx
    8a1e:	48 89 c6             	mov    %rax,%rsi
    8a21:	48 0f af f3          	imul   %rbx,%rsi
    8a25:	48 83 f8 01          	cmp    $0x1,%rax
    8a29:	74 19                	je     8a44 <fwp_write+0x10b4>
    8a2b:	48 83 f8 02          	cmp    $0x2,%rax
    8a2f:	0f 84 72 ff ff ff    	je     89a7 <fwp_write+0x1017>
    8a35:	48 83 f8 08          	cmp    $0x8,%rax
    8a39:	75 19                	jne    8a54 <fwp_write+0x10c4>
    8a3b:	48 8b 34 31          	mov    (%rcx,%rsi,1),%rsi
    8a3f:	e9 72 ff ff ff       	jmp    89b6 <fwp_write+0x1026>
    8a44:	83 3a 00             	cmpl   $0x0,(%rdx)
    8a47:	0f b6 04 31          	movzbl (%rcx,%rsi,1),%eax
    8a4b:	48 0f be f0          	movsbq %al,%rsi
    8a4f:	e9 5e ff ff ff       	jmp    89b2 <fwp_write+0x1022>
    8a54:	83 3a 02             	cmpl   $0x2,(%rdx)
    8a57:	8b 04 31             	mov    (%rcx,%rsi,1),%eax
    8a5a:	48 63 f0             	movslq %eax,%rsi
    8a5d:	e9 50 ff ff ff       	jmp    89b2 <fwp_write+0x1022>
    8a62:	c6 44 24 70 5d       	movb   $0x5d,0x70(%rsp)
    8a67:	48 8d 74 24 70       	lea    0x70(%rsp),%rsi
    8a6c:	ba 01 00 00 00       	mov    $0x1,%edx
    8a71:	48 89 ef             	mov    %rbp,%rdi
    8a74:	e9 55 01 00 00       	jmp    8bce <fwp_write+0x123e>
    8a79:	48 8d 35 0a 3b 00 00 	lea    0x3b0a(%rip),%rsi        # c58a <fwp_segv.msg+0x34a>
    8a80:	ba 02 00 00 00       	mov    $0x2,%edx
    8a85:	48 89 ef             	mov    %rbp,%rdi
    8a88:	e9 b5 fe ff ff       	jmp    8942 <fwp_write+0xfb2>
    8a8d:	31 c0                	xor    %eax,%eax
    8a8f:	c6 44 04 71 00       	movb   $0x0,0x71(%rsp,%rax,1)
    8a94:	e9 1f 01 00 00       	jmp    8bb8 <fwp_write+0x1228>
    8a99:	89 fa                	mov    %edi,%edx
    8a9b:	83 e2 1f             	and    $0x1f,%edx
    8a9e:	48 89 c1             	mov    %rax,%rcx
    8aa1:	48 29 d1             	sub    %rdx,%rcx
    8aa4:	48 8d b4 24 80 00 00 	lea    0x80(%rsp),%rsi
    8aab:	00 
    8aac:	66 0f ef c0          	pxor   %xmm0,%xmm0
    8ab0:	49 89 c0             	mov    %rax,%r8
    8ab3:	f3 42 0f 6f 0c 04    	movdqu (%rsp,%r8,1),%xmm1
    8ab9:	f3 42 0f 6f 54 04 10 	movdqu 0x10(%rsp,%r8,1),%xmm2
    8ac0:	66 0f 6f da          	movdqa %xmm2,%xmm3
    8ac4:	66 0f 60 d8          	punpcklbw %xmm0,%xmm3
    8ac8:	66 0f 70 db 4e       	pshufd $0x4e,%xmm3,%xmm3
    8acd:	f2 0f 70 db 1b       	pshuflw $0x1b,%xmm3,%xmm3
    8ad2:	f3 0f 70 db 1b       	pshufhw $0x1b,%xmm3,%xmm3
    8ad7:	66 0f 68 d0          	punpckhbw %xmm0,%xmm2
    8adb:	66 0f 70 d2 4e       	pshufd $0x4e,%xmm2,%xmm2
    8ae0:	f2 0f 70 d2 1b       	pshuflw $0x1b,%xmm2,%xmm2
    8ae5:	f3 0f 70 d2 1b       	pshufhw $0x1b,%xmm2,%xmm2
    8aea:	66 0f 67 d3          	packuswb %xmm3,%xmm2
    8aee:	66 0f 6f d9          	movdqa %xmm1,%xmm3
    8af2:	66 0f 60 d8          	punpcklbw %xmm0,%xmm3
    8af6:	66 0f 70 db 4e       	pshufd $0x4e,%xmm3,%xmm3
    8afb:	f2 0f 70 db 1b       	pshuflw $0x1b,%xmm3,%xmm3
    8b00:	f3 0f 70 db 1b       	pshufhw $0x1b,%xmm3,%xmm3
    8b05:	66 0f 68 c8          	punpckhbw %xmm0,%xmm1
    8b09:	66 0f 70 c9 4e       	pshufd $0x4e,%xmm1,%xmm1
    8b0e:	f2 0f 70 c9 1b       	pshuflw $0x1b,%xmm1,%xmm1
    8b13:	f3 0f 70 c9 1b       	pshufhw $0x1b,%xmm1,%xmm1
    8b18:	66 0f 67 cb          	packuswb %xmm3,%xmm1
    8b1c:	66 0f 7f 56 f0       	movdqa %xmm2,-0x10(%rsi)
    8b21:	66 0f 7f 0e          	movdqa %xmm1,(%rsi)
    8b25:	49 83 c0 e0          	add    $0xffffffffffffffe0,%r8
    8b29:	48 83 c6 20          	add    $0x20,%rsi
    8b2d:	4c 39 c2             	cmp    %r8,%rdx
    8b30:	75 81                	jne    8ab3 <fwp_write+0x1123>
    8b32:	48 85 d2             	test   %rdx,%rdx
    8b35:	0f 84 78 00 00 00    	je     8bb3 <fwp_write+0x1223>
    8b3b:	83 fa 08             	cmp    $0x8,%edx
    8b3e:	72 50                	jb     8b90 <fwp_write+0x1200>
    8b40:	89 fa                	mov    %edi,%edx
    8b42:	83 e2 07             	and    $0x7,%edx
    8b45:	48 89 c6             	mov    %rax,%rsi
    8b48:	48 29 ce             	sub    %rcx,%rsi
    8b4b:	48 8d 3c 0c          	lea    (%rsp,%rcx,1),%rdi
    8b4f:	48 83 c7 70          	add    $0x70,%rdi
    8b53:	48 89 c1             	mov    %rax,%rcx
    8b56:	48 29 d1             	sub    %rdx,%rcx
    8b59:	66 0f ef c0          	pxor   %xmm0,%xmm0
    8b5d:	f3 0f 7e 4c 34 18    	movq   0x18(%rsp,%rsi,1),%xmm1
    8b63:	66 0f 60 c8          	punpcklbw %xmm0,%xmm1
    8b67:	66 0f 70 c9 4e       	pshufd $0x4e,%xmm1,%xmm1
    8b6c:	f2 0f 70 c9 1b       	pshuflw $0x1b,%xmm1,%xmm1
    8b71:	f3 0f 70 c9 1b       	pshufhw $0x1b,%xmm1,%xmm1
    8b76:	66 0f 67 c9          	packuswb %xmm1,%xmm1
    8b7a:	66 0f d6 0f          	movq   %xmm1,(%rdi)
    8b7e:	48 83 c6 f8          	add    $0xfffffffffffffff8,%rsi
    8b82:	48 83 c7 08          	add    $0x8,%rdi
    8b86:	48 39 f2             	cmp    %rsi,%rdx
    8b89:	75 d2                	jne    8b5d <fwp_write+0x11cd>
    8b8b:	48 85 d2             	test   %rdx,%rdx
    8b8e:	74 23                	je     8bb3 <fwp_write+0x1223>
    8b90:	48 8d 74 24 20       	lea    0x20(%rsp),%rsi
    8b95:	48 01 f2             	add    %rsi,%rdx
    8b98:	48 ff ca             	dec    %rdx
    8b9b:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)
    8ba0:	0f b6 32             	movzbl (%rdx),%esi
    8ba3:	40 88 74 0c 70       	mov    %sil,0x70(%rsp,%rcx,1)
    8ba8:	48 ff c1             	inc    %rcx
    8bab:	48 ff ca             	dec    %rdx
    8bae:	48 39 c8             	cmp    %rcx,%rax
    8bb1:	75 ed                	jne    8ba0 <fwp_write+0x1210>
    8bb3:	c6 44 04 70 00       	movb   $0x0,0x70(%rsp,%rax,1)
    8bb8:	4c 8d 74 24 70       	lea    0x70(%rsp),%r14
    8bbd:	4c 89 f7             	mov    %r14,%rdi
    8bc0:	e8 4b 95 ff ff       	call   2110 <strlen@plt>
    8bc5:	48 89 ef             	mov    %rbp,%rdi
    8bc8:	4c 89 f6             	mov    %r14,%rsi
    8bcb:	48 89 c2             	mov    %rax,%rdx
    8bce:	e8 9d 01 00 00       	call   8d70 <buf_put>
    8bd3:	48 81 c4 78 02 00 00 	add    $0x278,%rsp
    8bda:	5b                   	pop    %rbx
    8bdb:	41 5c                	pop    %r12
    8bdd:	41 5d                	pop    %r13
    8bdf:	41 5e                	pop    %r14
    8be1:	41 5f                	pop    %r15
    8be3:	5d                   	pop    %rbp
    8be4:	c3                   	ret
    8be5:	83 f8 20             	cmp    $0x20,%eax
    8be8:	73 07                	jae    8bf1 <fwp_write+0x1261>
    8bea:	31 c9                	xor    %ecx,%ecx
    8bec:	e9 b6 00 00 00       	jmp    8ca7 <fwp_write+0x1317>
    8bf1:	89 fe                	mov    %edi,%esi
    8bf3:	89 fa                	mov    %edi,%edx
    8bf5:	83 e2 1f             	and    $0x1f,%edx
    8bf8:	48 89 c1             	mov    %rax,%rcx
    8bfb:	48 29 d1             	sub    %rdx,%rcx
    8bfe:	4c 8d 04 34          	lea    (%rsp,%rsi,1),%r8
    8c02:	49 83 c0 10          	add    $0x10,%r8
    8c06:	48 29 d6             	sub    %rdx,%rsi
    8c09:	45 31 c9             	xor    %r9d,%r9d
    8c0c:	66 0f ef c0          	pxor   %xmm0,%xmm0
    8c10:	f3 41 0f 6f 48 f0    	movdqu -0x10(%r8),%xmm1
    8c16:	f3 41 0f 6f 10       	movdqu (%r8),%xmm2
    8c1b:	66 0f 6f da          	movdqa %xmm2,%xmm3
    8c1f:	66 0f 60 d8          	punpcklbw %xmm0,%xmm3
    8c23:	66 0f 70 db 4e       	pshufd $0x4e,%xmm3,%xmm3
    8c28:	f2 0f 70 db 1b       	pshuflw $0x1b,%xmm3,%xmm3
    8c2d:	f3 0f 70 db 1b       	pshufhw $0x1b,%xmm3,%xmm3
    8c32:	66 0f 68 d0          	punpckhbw %xmm0,%xmm2
    8c36:	66 0f 70 d2 4e       	pshufd $0x4e,%xmm2,%xmm2
    8c3b:	f2 0f 70 d2 1b       	pshuflw $0x1b,%xmm2,%xmm2
    8c40:	f3 0f 70 d2 1b       	pshufhw $0x1b,%xmm2,%xmm2
    8c45:	66 0f 67 d3          	packuswb %xmm3,%xmm2
    8c49:	66 0f 6f d9          	movdqa %xmm1,%xmm3
    8c4d:	66 0f 60 d8          	punpcklbw %xmm0,%xmm3
    8c51:	66 0f 70 db 4e       	pshufd $0x4e,%xmm3,%xmm3
    8c56:	f2 0f 70 db 1b       	pshuflw $0x1b,%xmm3,%xmm3
    8c5b:	f3 0f 70 db 1b       	pshufhw $0x1b,%xmm3,%xmm3
    8c60:	66 0f 68 c8          	punpckhbw %xmm0,%xmm1
    8c64:	66 0f 70 c9 4e       	pshufd $0x4e,%xmm1,%xmm1
    8c69:	f2 0f 70 c9 1b       	pshuflw $0x1b,%xmm1,%xmm1
    8c6e:	f3 0f 70 c9 1b       	pshufhw $0x1b,%xmm1,%xmm1
    8c73:	66 0f 67 cb          	packuswb %xmm3,%xmm1
    8c77:	f3 42 0f 7f 54 0c 71 	movdqu %xmm2,0x71(%rsp,%r9,1)
    8c7e:	f3 42 0f 7f 8c 0c 81 	movdqu %xmm1,0x81(%rsp,%r9,1)
    8c85:	00 00 00 
    8c88:	49 83 c1 20          	add    $0x20,%r9
    8c8c:	49 83 c0 e0          	add    $0xffffffffffffffe0,%r8
    8c90:	4c 39 ce             	cmp    %r9,%rsi
    8c93:	0f 85 77 ff ff ff    	jne    8c10 <fwp_write+0x1280>
    8c99:	48 85 d2             	test   %rdx,%rdx
    8c9c:	0f 84 91 00 00 00    	je     8d33 <fwp_write+0x13a3>
    8ca2:	83 fa 08             	cmp    $0x8,%edx
    8ca5:	72 60                	jb     8d07 <fwp_write+0x1377>
    8ca7:	48 89 ce             	mov    %rcx,%rsi
    8caa:	41 89 f8             	mov    %edi,%r8d
    8cad:	89 fa                	mov    %edi,%edx
    8caf:	83 e2 07             	and    $0x7,%edx
    8cb2:	48 89 c1             	mov    %rax,%rcx
    8cb5:	48 29 d1             	sub    %rdx,%rcx
    8cb8:	49 89 f1             	mov    %rsi,%r9
    8cbb:	49 f7 d9             	neg    %r9
    8cbe:	49 01 e1             	add    %rsp,%r9
    8cc1:	49 83 c1 20          	add    $0x20,%r9
    8cc5:	4d 01 c1             	add    %r8,%r9
    8cc8:	49 83 c1 f8          	add    $0xfffffffffffffff8,%r9
    8ccc:	49 29 d0             	sub    %rdx,%r8
    8ccf:	66 0f ef c0          	pxor   %xmm0,%xmm0
    8cd3:	f3 41 0f 7e 09       	movq   (%r9),%xmm1
    8cd8:	66 0f 60 c8          	punpcklbw %xmm0,%xmm1
    8cdc:	66 0f 70 c9 4e       	pshufd $0x4e,%xmm1,%xmm1
    8ce1:	f2 0f 70 c9 1b       	pshuflw $0x1b,%xmm1,%xmm1
    8ce6:	f3 0f 70 c9 1b       	pshufhw $0x1b,%xmm1,%xmm1
    8ceb:	66 0f 67 c9          	packuswb %xmm1,%xmm1
    8cef:	66 0f d6 4c 34 71    	movq   %xmm1,0x71(%rsp,%rsi,1)
    8cf5:	48 83 c6 08          	add    $0x8,%rsi
    8cf9:	49 83 c1 f8          	add    $0xfffffffffffffff8,%r9
    8cfd:	49 39 f0             	cmp    %rsi,%r8
    8d00:	75 d1                	jne    8cd3 <fwp_write+0x1343>
    8d02:	48 85 d2             	test   %rdx,%rdx
    8d05:	74 2c                	je     8d33 <fwp_write+0x13a3>
    8d07:	48 8d 74 24 20       	lea    0x20(%rsp),%rsi
    8d0c:	48 01 f2             	add    %rsi,%rdx
    8d0f:	48 ff ca             	dec    %rdx
    8d12:	89 fe                	mov    %edi,%esi
    8d14:	66 66 66 2e 0f 1f 84 	data16 data16 cs nopw 0x0(%rax,%rax,1)
    8d1b:	00 00 00 00 00 
    8d20:	0f b6 3a             	movzbl (%rdx),%edi
    8d23:	40 88 7c 0c 71       	mov    %dil,0x71(%rsp,%rcx,1)
    8d28:	48 ff c1             	inc    %rcx
    8d2b:	48 ff ca             	dec    %rdx
    8d2e:	48 39 ce             	cmp    %rcx,%rsi
    8d31:	75 ed                	jne    8d20 <fwp_write+0x1390>
    8d33:	c6 44 04 71 00       	movb   $0x0,0x71(%rsp,%rax,1)
    8d38:	e9 7b fe ff ff       	jmp    8bb8 <fwp_write+0x1228>
    8d3d:	4c 8d 74 24 70       	lea    0x70(%rsp),%r14
    8d42:	4c 89 f7             	mov    %r14,%rdi
    8d45:	f2 0f 10 44 24 10    	movsd  0x10(%rsp),%xmm0
    8d4b:	be 09 00 00 00       	mov    $0x9,%esi
    8d50:	e8 7b 0d 00 00       	call   9ad0 <fwp_format_g>
    8d55:	4c 89 f7             	mov    %r14,%rdi
    8d58:	e9 bf f8 ff ff       	jmp    861c <fwp_write+0xc8c>
    8d5d:	c7 44 24 70 4e 61 4e 	movl   $0x4e614e,0x70(%rsp)
    8d64:	00 
    8d65:	e9 4e fe ff ff       	jmp    8bb8 <fwp_write+0x1228>
    8d6a:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)

0000000000008d70 <buf_put>:
    8d70:	41 57                	push   %r15
    8d72:	41 56                	push   %r14
    8d74:	41 54                	push   %r12
    8d76:	53                   	push   %rbx
    8d77:	50                   	push   %rax
    8d78:	49 89 fe             	mov    %rdi,%r14
    8d7b:	48 8b 7f 08          	mov    0x8(%rdi),%rdi
    8d7f:	48 83 ff ff          	cmp    $0xffffffffffffffff,%rdi
    8d83:	0f 84 a2 00 00 00    	je     8e2b <buf_put+0xbb>
    8d89:	48 89 d3             	mov    %rdx,%rbx
    8d8c:	48 c7 c0 fe ff ff ff 	mov    $0xfffffffffffffffe,%rax
    8d93:	48 29 f8             	sub    %rdi,%rax
    8d96:	48 39 d0             	cmp    %rdx,%rax
    8d99:	0f 82 8c 00 00 00    	jb     8e2b <buf_put+0xbb>
    8d9f:	48 8d 04 3b          	lea    (%rbx,%rdi,1),%rax
    8da3:	48 ff c0             	inc    %rax
    8da6:	49 8b 4e 10          	mov    0x10(%r14),%rcx
    8daa:	48 39 c8             	cmp    %rcx,%rax
    8dad:	76 30                	jbe    8ddf <buf_put+0x6f>
    8daf:	48 85 c9             	test   %rcx,%rcx
    8db2:	41 bf 40 00 00 00    	mov    $0x40,%r15d
    8db8:	4c 0f 45 f9          	cmovne %rcx,%r15
    8dbc:	49 89 f4             	mov    %rsi,%r12
    8dbf:	49 39 c7             	cmp    %rax,%r15
    8dc2:	73 23                	jae    8de7 <buf_put+0x77>
    8dc4:	66 66 66 2e 0f 1f 84 	data16 data16 cs nopw 0x0(%rax,%rax,1)
    8dcb:	00 00 00 00 00 
    8dd0:	4d 85 ff             	test   %r15,%r15
    8dd3:	78 0f                	js     8de4 <buf_put+0x74>
    8dd5:	4d 01 ff             	add    %r15,%r15
    8dd8:	49 39 c7             	cmp    %rax,%r15
    8ddb:	72 f3                	jb     8dd0 <buf_put+0x60>
    8ddd:	eb 08                	jmp    8de7 <buf_put+0x77>
    8ddf:	49 8b 06             	mov    (%r14),%rax
    8de2:	eb 21                	jmp    8e05 <buf_put+0x95>
    8de4:	49 89 c7             	mov    %rax,%r15
    8de7:	49 8b 3e             	mov    (%r14),%rdi
    8dea:	4c 89 fe             	mov    %r15,%rsi
    8ded:	e8 4e 94 ff ff       	call   2240 <realloc@plt>
    8df2:	48 85 c0             	test   %rax,%rax
    8df5:	74 34                	je     8e2b <buf_put+0xbb>
    8df7:	49 89 06             	mov    %rax,(%r14)
    8dfa:	4d 89 7e 10          	mov    %r15,0x10(%r14)
    8dfe:	49 8b 7e 08          	mov    0x8(%r14),%rdi
    8e02:	4c 89 e6             	mov    %r12,%rsi
    8e05:	48 01 c7             	add    %rax,%rdi
    8e08:	48 89 da             	mov    %rbx,%rdx
    8e0b:	e8 00 94 ff ff       	call   2210 <memcpy@plt>
    8e10:	49 03 5e 08          	add    0x8(%r14),%rbx
    8e14:	49 89 5e 08          	mov    %rbx,0x8(%r14)
    8e18:	49 8b 06             	mov    (%r14),%rax
    8e1b:	c6 04 18 00          	movb   $0x0,(%rax,%rbx,1)
    8e1f:	48 83 c4 08          	add    $0x8,%rsp
    8e23:	5b                   	pop    %rbx
    8e24:	41 5c                	pop    %r12
    8e26:	41 5e                	pop    %r14
    8e28:	41 5f                	pop    %r15
    8e2a:	c3                   	ret
    8e2b:	48 8b 05 ae 61 00 00 	mov    0x61ae(%rip),%rax        # efe0 <stderr@GLIBC_2.2.5>
    8e32:	48 8b 08             	mov    (%rax),%rcx
    8e35:	48 8d 3d f4 35 00 00 	lea    0x35f4(%rip),%rdi        # c430 <fwp_segv.msg+0x1f0>
    8e3c:	be 13 00 00 00       	mov    $0x13,%esi
    8e41:	ba 01 00 00 00       	mov    $0x1,%edx
    8e46:	e8 95 94 ff ff       	call   22e0 <fwrite@plt>
    8e4b:	bf 66 00 00 00       	mov    $0x66,%edi
    8e50:	e8 7b 94 ff ff       	call   22d0 <exit@plt>
    8e55:	66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
    8e5c:	00 00 00 00 

0000000000008e60 <fwp_escape>:
    8e60:	55                   	push   %rbp
    8e61:	41 57                	push   %r15
    8e63:	41 56                	push   %r14
    8e65:	41 55                	push   %r13
    8e67:	41 54                	push   %r12
    8e69:	53                   	push   %rbx
    8e6a:	48 83 ec 18          	sub    $0x18,%rsp
    8e6e:	49 89 d6             	mov    %rdx,%r14
    8e71:	49 89 f7             	mov    %rsi,%r15
    8e74:	48 89 fb             	mov    %rdi,%rbx
    8e77:	c6 04 24 22          	movb   $0x22,(%rsp)
    8e7b:	48 89 e6             	mov    %rsp,%rsi
    8e7e:	ba 01 00 00 00       	mov    $0x1,%edx
    8e83:	e8 e8 fe ff ff       	call   8d70 <buf_put>
    8e88:	4d 85 f6             	test   %r14,%r14
    8e8b:	0f 84 de 00 00 00    	je     8f6f <fwp_escape+0x10f>
    8e91:	48 89 e5             	mov    %rsp,%rbp
    8e94:	4c 8d 2d 21 33 00 00 	lea    0x3321(%rip),%r13        # c1bc <_IO_stdin_used+0x1bc>
    8e9b:	45 31 e4             	xor    %r12d,%r12d
    8e9e:	eb 21                	jmp    8ec1 <fwp_escape+0x61>
    8ea0:	ba 02 00 00 00       	mov    $0x2,%edx
    8ea5:	48 89 df             	mov    %rbx,%rdi
    8ea8:	48 8d 35 0e 37 00 00 	lea    0x370e(%rip),%rsi        # c5bd <fwp_segv.msg+0x37d>
    8eaf:	90                   	nop
    8eb0:	e8 bb fe ff ff       	call   8d70 <buf_put>
    8eb5:	49 ff c4             	inc    %r12
    8eb8:	4d 39 e6             	cmp    %r12,%r14
    8ebb:	0f 84 ae 00 00 00    	je     8f6f <fwp_escape+0x10f>
    8ec1:	43 0f b6 04 27       	movzbl (%r15,%r12,1),%eax
    8ec6:	0f b6 c8             	movzbl %al,%ecx
    8ec9:	8d 51 f7             	lea    -0x9(%rcx),%edx
    8ecc:	83 fa 19             	cmp    $0x19,%edx
    8ecf:	77 1f                	ja     8ef0 <fwp_escape+0x90>
    8ed1:	49 63 54 95 00       	movslq 0x0(%r13,%rdx,4),%rdx
    8ed6:	4c 01 ea             	add    %r13,%rdx
    8ed9:	ff e2                	jmp    *%rdx
    8edb:	ba 02 00 00 00       	mov    $0x2,%edx
    8ee0:	48 89 df             	mov    %rbx,%rdi
    8ee3:	48 8d 35 d0 36 00 00 	lea    0x36d0(%rip),%rsi        # c5ba <fwp_segv.msg+0x37a>
    8eea:	eb c4                	jmp    8eb0 <fwp_escape+0x50>
    8eec:	0f 1f 40 00          	nopl   0x0(%rax)
    8ef0:	83 f9 5c             	cmp    $0x5c,%ecx
    8ef3:	75 11                	jne    8f06 <fwp_escape+0xa6>
    8ef5:	ba 02 00 00 00       	mov    $0x2,%edx
    8efa:	48 89 df             	mov    %rbx,%rdi
    8efd:	48 8d 35 b0 36 00 00 	lea    0x36b0(%rip),%rsi        # c5b4 <fwp_segv.msg+0x374>
    8f04:	eb aa                	jmp    8eb0 <fwp_escape+0x50>
    8f06:	3c 20                	cmp    $0x20,%al
    8f08:	72 39                	jb     8f43 <fwp_escape+0xe3>
    8f0a:	3c 7f                	cmp    $0x7f,%al
    8f0c:	74 35                	je     8f43 <fwp_escape+0xe3>
    8f0e:	88 04 24             	mov    %al,(%rsp)
    8f11:	ba 01 00 00 00       	mov    $0x1,%edx
    8f16:	48 89 df             	mov    %rbx,%rdi
    8f19:	48 89 ee             	mov    %rbp,%rsi
    8f1c:	eb 92                	jmp    8eb0 <fwp_escape+0x50>
    8f1e:	ba 02 00 00 00       	mov    $0x2,%edx
    8f23:	48 89 df             	mov    %rbx,%rdi
    8f26:	48 8d 35 84 36 00 00 	lea    0x3684(%rip),%rsi        # c5b1 <fwp_segv.msg+0x371>
    8f2d:	eb 81                	jmp    8eb0 <fwp_escape+0x50>
    8f2f:	ba 02 00 00 00       	mov    $0x2,%edx
    8f34:	48 89 df             	mov    %rbx,%rdi
    8f37:	48 8d 35 79 36 00 00 	lea    0x3679(%rip),%rsi        # c5b7 <fwp_segv.msg+0x377>
    8f3e:	e9 6d ff ff ff       	jmp    8eb0 <fwp_escape+0x50>
    8f43:	be 10 00 00 00       	mov    $0x10,%esi
    8f48:	48 89 ef             	mov    %rbp,%rdi
    8f4b:	48 8d 15 6e 36 00 00 	lea    0x366e(%rip),%rdx        # c5c0 <fwp_segv.msg+0x380>
    8f52:	31 c0                	xor    %eax,%eax
    8f54:	e8 e7 91 ff ff       	call   2140 <snprintf@plt>
    8f59:	48 89 ef             	mov    %rbp,%rdi
    8f5c:	e8 af 91 ff ff       	call   2110 <strlen@plt>
    8f61:	48 89 df             	mov    %rbx,%rdi
    8f64:	48 89 ee             	mov    %rbp,%rsi
    8f67:	48 89 c2             	mov    %rax,%rdx
    8f6a:	e9 41 ff ff ff       	jmp    8eb0 <fwp_escape+0x50>
    8f6f:	c6 04 24 22          	movb   $0x22,(%rsp)
    8f73:	48 89 e6             	mov    %rsp,%rsi
    8f76:	ba 01 00 00 00       	mov    $0x1,%edx
    8f7b:	48 89 df             	mov    %rbx,%rdi
    8f7e:	e8 ed fd ff ff       	call   8d70 <buf_put>
    8f83:	48 83 c4 18          	add    $0x18,%rsp
    8f87:	5b                   	pop    %rbx
    8f88:	41 5c                	pop    %r12
    8f8a:	41 5d                	pop    %r13
    8f8c:	41 5e                	pop    %r14
    8f8e:	41 5f                	pop    %r15
    8f90:	5d                   	pop    %rbp
    8f91:	c3                   	ret
    8f92:	66 66 66 66 66 2e 0f 	data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    8f99:	1f 84 00 00 00 00 00 

0000000000008fa0 <fwp_fmt_duration>:
    8fa0:	41 57                	push   %r15
    8fa2:	41 56                	push   %r14
    8fa4:	41 54                	push   %r12
    8fa6:	53                   	push   %rbx
    8fa7:	48 81 ec 88 00 00 00 	sub    $0x88,%rsp
    8fae:	48 89 f0             	mov    %rsi,%rax
    8fb1:	48 09 d0             	or     %rdx,%rax
    8fb4:	0f 84 bf 02 00 00    	je     9279 <fwp_fmt_duration+0x2d9>
    8fba:	49 89 d0             	mov    %rdx,%r8
    8fbd:	48 b9 1d 3f c2 25 d6 	movabs $0xd2fe1d625c23f1d,%rcx
    8fc4:	e1 2f 0d 
    8fc7:	48 0f af ce          	imul   %rsi,%rcx
    8fcb:	49 b9 0d b1 f3 e4 99 	movabs $0x1c52799e4f3b10d,%r9
    8fd2:	27 c5 01 
    8fd5:	48 89 f0             	mov    %rsi,%rax
    8fd8:	49 f7 e1             	mul    %r9
    8fdb:	48 01 ca             	add    %rcx,%rdx
    8fde:	4d 0f af c8          	imul   %r8,%r9
    8fe2:	49 01 d1             	add    %rdx,%r9
    8fe5:	48 b9 00 a0 34 52 a3 	movabs $0x6baf6aa35234a000,%rcx
    8fec:	6a af 6b 
    8fef:	48 01 c1             	add    %rax,%rcx
    8ff2:	48 b8 37 f9 ff e2 04 	movabs $0x4e2fff937,%rax
    8ff9:	00 00 00 
    8ffc:	4c 11 c8             	adc    %r9,%rax
    8fff:	48 89 c2             	mov    %rax,%rdx
    9002:	48 0f ac ca 0d       	shrd   $0xd,%rcx,%rdx
    9007:	48 0f a4 c8 33       	shld   $0x33,%rcx,%rax
    900c:	48 b9 4a 23 35 aa f6 	movabs $0x9376baf6aa35234a,%rcx
    9013:	ba 76 93 
    9016:	48 39 c1             	cmp    %rax,%rcx
    9019:	b8 ff 2f 4e 00       	mov    $0x4e2fff,%eax
    901e:	48 19 d0             	sbb    %rdx,%rax
    9021:	0f 83 70 02 00 00    	jae    9297 <fwp_fmt_duration+0x2f7>
    9027:	48 b9 b3 b2 61 36 8c 	movabs $0xc5ce3b8c3661b2b3,%rcx
    902e:	3b ce c5 
    9031:	49 b9 c3 5f 47 6a 04 	movabs $0x1a8d52046a475fc3,%r9
    9038:	52 8d 1a 
    903b:	48 89 f0             	mov    %rsi,%rax
    903e:	49 f7 e1             	mul    %r9
    9041:	48 0f af ce          	imul   %rsi,%rcx
    9045:	48 01 ca             	add    %rcx,%rdx
    9048:	4d 0f af c8          	imul   %r8,%r9
    904c:	49 01 d1             	add    %rdx,%r9
    904f:	48 b9 00 a8 16 d1 91 	movabs $0x4f473f91d116a800,%rcx
    9056:	3f 47 4f 
    9059:	48 01 c1             	add    %rax,%rcx
    905c:	48 b8 3f 9a ff 4c 49 	movabs $0x494cff9a3f,%rax
    9063:	00 00 00 
    9066:	4c 11 c8             	adc    %r9,%rax
    9069:	48 89 c2             	mov    %rax,%rdx
    906c:	48 0f ac ca 0b       	shrd   $0xb,%rcx,%rdx
    9071:	48 0f a4 c8 35       	shld   $0x35,%rcx,%rax
    9076:	48 b9 ab 45 74 e4 cf 	movabs $0x8fd3d1cfe47445ab,%rcx
    907d:	d1 d3 8f 
    9080:	48 39 c8             	cmp    %rcx,%rax
    9083:	48 81 da e6 3f 53 12 	sbb    $0x12533fe6,%rdx
    908a:	0f 82 27 02 00 00    	jb     92b7 <fwp_fmt_duration+0x317>
    9090:	48 b9 7e 78 b9 2f 37 	movabs $0x97157d372fb9787e,%rcx
    9097:	7d 15 97 
    909a:	48 0f af ce          	imul   %rsi,%rcx
    909e:	49 b9 6d 9c 2e 3a 42 	movabs $0x8e47ce423a2e9c6d,%r9
    90a5:	ce 47 8e 
    90a8:	48 89 f0             	mov    %rsi,%rax
    90ab:	49 f7 e1             	mul    %r9
    90ae:	48 01 ca             	add    %rcx,%rdx
    90b1:	4d 0f af c8          	imul   %r8,%r9
    90b5:	49 01 d1             	add    %rdx,%r9
    90b8:	48 b9 00 46 54 40 8b 	movabs $0xa52cb98b40544600,%rcx
    90bf:	b9 2c a5 
    90c2:	48 01 c1             	add    %rax,%rcx
    90c5:	48 b8 b5 09 fa 82 4b 	movabs $0x44b82fa09b5,%rax
    90cc:	04 00 00 
    90cf:	4c 11 c8             	adc    %r9,%rax
    90d2:	48 89 c2             	mov    %rax,%rdx
    90d5:	48 0f ac ca 09       	shrd   $0x9,%rcx,%rdx
    90da:	48 0f a4 c8 37       	shld   $0x37,%rcx,%rax
    90df:	48 b9 47 54 40 8b b9 	movabs $0xb5a52cb98b405447,%rcx
    90e6:	2c a5 b5 
    90e9:	48 39 c8             	cmp    %rcx,%rax
    90ec:	48 b8 09 fa 82 4b 04 	movabs $0x44b82fa09,%rax
    90f3:	00 00 00 
    90f6:	48 19 c2             	sbb    %rax,%rdx
    90f9:	0f 82 0d 03 00 00    	jb     940c <fwp_fmt_duration+0x46c>
    90ff:	48 b9 cb d5 8f 4d f2 	movabs $0xc57e23f24d8fd5cb,%rcx
    9106:	23 7e c5 
    9109:	48 0f af ce          	imul   %rsi,%rcx
    910d:	49 b9 39 61 c2 68 56 	movabs $0x790fb65668c26139,%r9
    9114:	b6 0f 79 
    9117:	48 89 f0             	mov    %rsi,%rax
    911a:	49 f7 e1             	mul    %r9
    911d:	48 01 ca             	add    %rcx,%rdx
    9120:	4d 0f af c8          	imul   %r8,%r9
    9124:	49 01 d1             	add    %rdx,%r9
    9127:	48 b9 00 0b 27 69 fe 	movabs $0xa6d698fe69270b00,%rcx
    912e:	98 d6 a6 
    9131:	48 01 c1             	add    %rax,%rcx
    9134:	48 b8 b1 bd 16 f4 de 	movabs $0x218def416bdb1,%rax
    913b:	18 02 00 
    913e:	4c 11 c8             	adc    %r9,%rax
    9141:	48 89 c2             	mov    %rax,%rdx
    9144:	48 0f ac ca 06       	shrd   $0x6,%rcx,%rdx
    9149:	48 0f a4 c8 3a       	shld   $0x3a,%rcx,%rax
    914e:	48 b9 59 38 49 f3 c7 	movabs $0x8d36b4c7f3493859,%rcx
    9155:	b4 36 8d 
    9158:	48 39 c8             	cmp    %rcx,%rax
    915b:	48 b8 ed b5 a0 f7 c6 	movabs $0x10c6f7a0b5ed,%rax
    9162:	10 00 00 
    9165:	48 19 c2             	sbb    %rax,%rdx
    9168:	0f 82 ad 02 00 00    	jb     941b <fwp_fmt_duration+0x47b>
    916e:	48 b9 5a 64 3b df 4f 	movabs $0x6e978d4fdf3b645a,%rcx
    9175:	8d 97 6e 
    9178:	48 0f af ce          	imul   %rsi,%rcx
    917c:	49 b9 d5 78 e9 26 31 	movabs $0x1cac083126e978d5,%r9
    9183:	08 ac 1c 
    9186:	48 89 f0             	mov    %rsi,%rax
    9189:	49 f7 e1             	mul    %r9
    918c:	48 01 ca             	add    %rcx,%rdx
    918f:	4d 0f af c8          	imul   %r8,%r9
    9193:	49 01 d1             	add    %rdx,%r9
    9196:	48 b9 48 62 10 58 39 	movabs $0x76c8b43958106248,%rcx
    919d:	b4 c8 76 
    91a0:	48 01 c1             	add    %rax,%rcx
    91a3:	48 b8 be 9f 1a 2f dd 	movabs $0x10624dd2f1a9fbe,%rax
    91aa:	24 06 01 
    91ad:	4c 11 c8             	adc    %r9,%rax
    91b0:	48 89 c2             	mov    %rax,%rdx
    91b3:	48 0f ac ca 03       	shrd   $0x3,%rcx,%rdx
    91b8:	48 0f a4 c8 3d       	shld   $0x3d,%rcx,%rax
    91bd:	48 b9 93 18 04 56 0e 	movabs $0x9db22d0e56041893,%rcx
    91c4:	2d b2 9d 
    91c7:	48 39 c8             	cmp    %rcx,%rax
    91ca:	48 b8 ef a7 c6 4b 37 	movabs $0x4189374bc6a7ef,%rax
    91d1:	89 41 00 
    91d4:	48 19 c2             	sbb    %rax,%rdx
    91d7:	0f 82 4d 02 00 00    	jb     942a <fwp_fmt_duration+0x48a>
    91dd:	4d 85 c0             	test   %r8,%r8
    91e0:	0f 88 d6 06 00 00    	js     98bc <fwp_fmt_duration+0x91c>
    91e6:	45 31 d2             	xor    %r10d,%r10d
    91e9:	49 bb cd cc cc cc cc 	movabs $0xcccccccccccccccd,%r11
    91f0:	cc cc cc 
    91f3:	48 bb cc cc cc cc cc 	movabs $0xcccccccccccccccc,%rbx
    91fa:	cc cc cc 
    91fd:	4d 89 c6             	mov    %r8,%r14
    9200:	4c 89 c1             	mov    %r8,%rcx
    9203:	48 0f a4 f1 3f       	shld   $0x3f,%rsi,%rcx
    9208:	49 d1 ee             	shr    $1,%r14
    920b:	49 89 c9             	mov    %rcx,%r9
    920e:	4d 01 f1             	add    %r14,%r9
    9211:	49 83 d1 00          	adc    $0x0,%r9
    9215:	4c 89 c8             	mov    %r9,%rax
    9218:	49 f7 e3             	mul    %r11
    921b:	48 c1 ea 02          	shr    $0x2,%rdx
    921f:	48 8d 04 92          	lea    (%rdx,%rdx,4),%rax
    9223:	49 29 c1             	sub    %rax,%r9
    9226:	4c 29 c9             	sub    %r9,%rcx
    9229:	49 83 de 00          	sbb    $0x0,%r14
    922d:	49 89 c9             	mov    %rcx,%r9
    9230:	4c 0f af cb          	imul   %rbx,%r9
    9234:	48 89 c8             	mov    %rcx,%rax
    9237:	49 f7 e3             	mul    %r11
    923a:	4c 01 ca             	add    %r9,%rdx
    923d:	4d 0f af f3          	imul   %r11,%r14
    9241:	49 01 d6             	add    %rdx,%r14
    9244:	48 89 c1             	mov    %rax,%rcx
    9247:	48 01 c1             	add    %rax,%rcx
    924a:	48 8d 0c 89          	lea    (%rcx,%rcx,4),%rcx
    924e:	89 f2                	mov    %esi,%edx
    9250:	29 ca                	sub    %ecx,%edx
    9252:	80 ca 30             	or     $0x30,%dl
    9255:	42 88 54 14 40       	mov    %dl,0x40(%rsp,%r10,1)
    925a:	49 ff c2             	inc    %r10
    925d:	48 83 fe 0a          	cmp    $0xa,%rsi
    9261:	49 83 d8 00          	sbb    $0x0,%r8
    9265:	48 89 c6             	mov    %rax,%rsi
    9268:	4d 89 f0             	mov    %r14,%r8
    926b:	73 93                	jae    9200 <fwp_fmt_duration+0x260>
    926d:	45 85 d2             	test   %r10d,%r10d
    9270:	7f 12                	jg     9284 <fwp_fmt_duration+0x2e4>
    9272:	31 c0                	xor    %eax,%eax
    9274:	e9 79 01 00 00       	jmp    93f2 <fwp_fmt_duration+0x452>
    9279:	c6 44 24 40 30       	movb   $0x30,0x40(%rsp)
    927e:	41 ba 01 00 00 00    	mov    $0x1,%r10d
    9284:	44 89 d0             	mov    %r10d,%eax
    9287:	48 83 f8 08          	cmp    $0x8,%rax
    928b:	73 1e                	jae    92ab <fwp_fmt_duration+0x30b>
    928d:	31 c9                	xor    %ecx,%ecx
    928f:	48 89 c2             	mov    %rax,%rdx
    9292:	e9 3d 01 00 00       	jmp    93d4 <fwp_fmt_duration+0x434>
    9297:	49 89 fe             	mov    %rdi,%r14
    929a:	48 ba 00 a0 b8 30 46 	movabs $0x34630b8a000,%rdx
    92a1:	03 00 00 
    92a4:	31 c0                	xor    %eax,%eax
    92a6:	e9 8c 01 00 00       	jmp    9437 <fwp_fmt_duration+0x497>
    92ab:	83 f8 20             	cmp    $0x20,%eax
    92ae:	73 1e                	jae    92ce <fwp_fmt_duration+0x32e>
    92b0:	31 c9                	xor    %ecx,%ecx
    92b2:	e9 c3 00 00 00       	jmp    937a <fwp_fmt_duration+0x3da>
    92b7:	49 89 fe             	mov    %rdi,%r14
    92ba:	48 ba 00 58 47 f8 0d 	movabs $0xdf8475800,%rdx
    92c1:	00 00 00 
    92c4:	b8 01 00 00 00       	mov    $0x1,%eax
    92c9:	e9 69 01 00 00       	jmp    9437 <fwp_fmt_duration+0x497>
    92ce:	44 89 d2             	mov    %r10d,%edx
    92d1:	83 e2 1f             	and    $0x1f,%edx
    92d4:	48 89 c1             	mov    %rax,%rcx
    92d7:	48 29 d1             	sub    %rdx,%rcx
    92da:	48 8d 74 24 10       	lea    0x10(%rsp),%rsi
    92df:	66 0f ef c0          	pxor   %xmm0,%xmm0
    92e3:	49 89 c0             	mov    %rax,%r8
    92e6:	66 2e 0f 1f 84 00 00 	cs nopw 0x0(%rax,%rax,1)
    92ed:	00 00 00 
    92f0:	f3 42 0f 6f 4c 04 20 	movdqu 0x20(%rsp,%r8,1),%xmm1
    92f7:	f3 42 0f 6f 54 04 30 	movdqu 0x30(%rsp,%r8,1),%xmm2
    92fe:	66 0f 6f da          	movdqa %xmm2,%xmm3
    9302:	66 0f 60 d8          	punpcklbw %xmm0,%xmm3
    9306:	66 0f 70 db 4e       	pshufd $0x4e,%xmm3,%xmm3
    930b:	f2 0f 70 db 1b       	pshuflw $0x1b,%xmm3,%xmm3
    9310:	f3 0f 70 db 1b       	pshufhw $0x1b,%xmm3,%xmm3
    9315:	66 0f 68 d0          	punpckhbw %xmm0,%xmm2
    9319:	66 0f 70 d2 4e       	pshufd $0x4e,%xmm2,%xmm2
    931e:	f2 0f 70 d2 1b       	pshuflw $0x1b,%xmm2,%xmm2
    9323:	f3 0f 70 d2 1b       	pshufhw $0x1b,%xmm2,%xmm2
    9328:	66 0f 67 d3          	packuswb %xmm3,%xmm2
    932c:	66 0f 6f d9          	movdqa %xmm1,%xmm3
    9330:	66 0f 60 d8          	punpcklbw %xmm0,%xmm3
    9334:	66 0f 70 db 4e       	pshufd $0x4e,%xmm3,%xmm3
    9339:	f2 0f 70 db 1b       	pshuflw $0x1b,%xmm3,%xmm3
    933e:	f3 0f 70 db 1b       	pshufhw $0x1b,%xmm3,%xmm3
    9343:	66 0f 68 c8          	punpckhbw %xmm0,%xmm1
    9347:	66 0f 70 c9 4e       	pshufd $0x4e,%xmm1,%xmm1
    934c:	f2 0f 70 c9 1b       	pshuflw $0x1b,%xmm1,%xmm1
    9351:	f3 0f 70 c9 1b       	pshufhw $0x1b,%xmm1,%xmm1
    9356:	66 0f 67 cb          	packuswb %xmm3,%xmm1
    935a:	66 0f 7f 56 f0       	movdqa %xmm2,-0x10(%rsi)
    935f:	66 0f 7f 0e          	movdqa %xmm1,(%rsi)
    9363:	49 83 c0 e0          	add    $0xffffffffffffffe0,%r8
    9367:	48 83 c6 20          	add    $0x20,%rsi
    936b:	4c 39 c2             	cmp    %r8,%rdx
    936e:	75 80                	jne    92f0 <fwp_fmt_duration+0x350>
    9370:	48 85 d2             	test   %rdx,%rdx
    9373:	74 7d                	je     93f2 <fwp_fmt_duration+0x452>
    9375:	83 fa 08             	cmp    $0x8,%edx
    9378:	72 5a                	jb     93d4 <fwp_fmt_duration+0x434>
    937a:	44 89 d2             	mov    %r10d,%edx
    937d:	83 e2 07             	and    $0x7,%edx
    9380:	48 89 c6             	mov    %rax,%rsi
    9383:	48 29 ce             	sub    %rcx,%rsi
    9386:	4c 8d 04 0c          	lea    (%rsp,%rcx,1),%r8
    938a:	48 89 c1             	mov    %rax,%rcx
    938d:	48 29 d1             	sub    %rdx,%rcx
    9390:	66 0f ef c0          	pxor   %xmm0,%xmm0
    9394:	66 66 66 2e 0f 1f 84 	data16 data16 cs nopw 0x0(%rax,%rax,1)
    939b:	00 00 00 00 00 
    93a0:	f3 0f 7e 4c 34 38    	movq   0x38(%rsp,%rsi,1),%xmm1
    93a6:	66 0f 60 c8          	punpcklbw %xmm0,%xmm1
    93aa:	66 0f 70 c9 4e       	pshufd $0x4e,%xmm1,%xmm1
    93af:	f2 0f 70 c9 1b       	pshuflw $0x1b,%xmm1,%xmm1
    93b4:	f3 0f 70 c9 1b       	pshufhw $0x1b,%xmm1,%xmm1
    93b9:	66 0f 67 c9          	packuswb %xmm1,%xmm1
    93bd:	66 41 0f d6 08       	movq   %xmm1,(%r8)
    93c2:	48 83 c6 f8          	add    $0xfffffffffffffff8,%rsi
    93c6:	49 83 c0 08          	add    $0x8,%r8
    93ca:	48 39 f2             	cmp    %rsi,%rdx
    93cd:	75 d1                	jne    93a0 <fwp_fmt_duration+0x400>
    93cf:	48 85 d2             	test   %rdx,%rdx
    93d2:	74 1e                	je     93f2 <fwp_fmt_duration+0x452>
    93d4:	48 8d 74 24 40       	lea    0x40(%rsp),%rsi
    93d9:	48 01 f2             	add    %rsi,%rdx
    93dc:	48 ff ca             	dec    %rdx
    93df:	90                   	nop
    93e0:	0f b6 32             	movzbl (%rdx),%esi
    93e3:	40 88 34 0c          	mov    %sil,(%rsp,%rcx,1)
    93e7:	48 ff c1             	inc    %rcx
    93ea:	48 ff ca             	dec    %rdx
    93ed:	48 39 c8             	cmp    %rcx,%rax
    93f0:	75 ee                	jne    93e0 <fwp_fmt_duration+0x440>
    93f2:	c6 04 04 00          	movb   $0x0,(%rsp,%rax,1)
    93f6:	48 8d 35 d6 31 00 00 	lea    0x31d6(%rip),%rsi        # c5d3 <fwp_segv.msg+0x393>
    93fd:	48 89 e2             	mov    %rsp,%rdx
    9400:	31 c0                	xor    %eax,%eax
    9402:	e8 b9 8e ff ff       	call   22c0 <sprintf@plt>
    9407:	e9 a1 04 00 00       	jmp    98ad <fwp_fmt_duration+0x90d>
    940c:	49 89 fe             	mov    %rdi,%r14
    940f:	ba 00 ca 9a 3b       	mov    $0x3b9aca00,%edx
    9414:	b8 02 00 00 00       	mov    $0x2,%eax
    9419:	eb 1c                	jmp    9437 <fwp_fmt_duration+0x497>
    941b:	49 89 fe             	mov    %rdi,%r14
    941e:	ba 40 42 0f 00       	mov    $0xf4240,%edx
    9423:	b8 03 00 00 00       	mov    $0x3,%eax
    9428:	eb 0d                	jmp    9437 <fwp_fmt_duration+0x497>
    942a:	49 89 fe             	mov    %rdi,%r14
    942d:	ba e8 03 00 00       	mov    $0x3e8,%edx
    9432:	b8 04 00 00 00       	mov    $0x4,%eax
    9437:	31 c9                	xor    %ecx,%ecx
    9439:	c1 e0 04             	shl    $0x4,%eax
    943c:	48 8d 1d 1d 58 00 00 	lea    0x581d(%rip),%rbx        # ec60 <fwp_fmt_duration.units>
    9443:	48 01 c3             	add    %rax,%rbx
    9446:	48 89 f7             	mov    %rsi,%rdi
    9449:	4c 89 c6             	mov    %r8,%rsi
    944c:	e8 bf 1d 00 00       	call   b210 <__divti3>
    9451:	48 89 c1             	mov    %rax,%rcx
    9454:	48 89 d6             	mov    %rdx,%rsi
    9457:	48 85 d2             	test   %rdx,%rdx
    945a:	0f 88 b0 00 00 00    	js     9510 <fwp_fmt_duration+0x570>
    9460:	48 89 c8             	mov    %rcx,%rax
    9463:	48 09 f0             	or     %rsi,%rax
    9466:	0f 84 61 01 00 00    	je     95cd <fwp_fmt_duration+0x62d>
    946c:	45 31 d2             	xor    %r10d,%r10d
    946f:	49 bb cd cc cc cc cc 	movabs $0xcccccccccccccccd,%r11
    9476:	cc cc cc 
    9479:	49 bf cc cc cc cc cc 	movabs $0xcccccccccccccccc,%r15
    9480:	cc cc cc 
    9483:	49 89 f4             	mov    %rsi,%r12
    9486:	4c 89 f7             	mov    %r14,%rdi
    9489:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)
    9490:	49 89 f0             	mov    %rsi,%r8
    9493:	49 0f a4 c8 3f       	shld   $0x3f,%rcx,%r8
    9498:	49 d1 ec             	shr    $1,%r12
    949b:	4d 89 c1             	mov    %r8,%r9
    949e:	4d 01 e1             	add    %r12,%r9
    94a1:	49 83 d1 00          	adc    $0x0,%r9
    94a5:	4c 89 c8             	mov    %r9,%rax
    94a8:	49 f7 e3             	mul    %r11
    94ab:	48 c1 ea 02          	shr    $0x2,%rdx
    94af:	48 8d 04 92          	lea    (%rdx,%rdx,4),%rax
    94b3:	49 29 c1             	sub    %rax,%r9
    94b6:	4d 29 c8             	sub    %r9,%r8
    94b9:	49 83 dc 00          	sbb    $0x0,%r12
    94bd:	4d 89 c1             	mov    %r8,%r9
    94c0:	4d 0f af cf          	imul   %r15,%r9
    94c4:	4c 89 c0             	mov    %r8,%rax
    94c7:	49 f7 e3             	mul    %r11
    94ca:	4c 01 ca             	add    %r9,%rdx
    94cd:	4d 0f af e3          	imul   %r11,%r12
    94d1:	49 01 d4             	add    %rdx,%r12
    94d4:	48 89 c2             	mov    %rax,%rdx
    94d7:	48 01 c2             	add    %rax,%rdx
    94da:	48 8d 14 92          	lea    (%rdx,%rdx,4),%rdx
    94de:	41 89 c8             	mov    %ecx,%r8d
    94e1:	41 29 d0             	sub    %edx,%r8d
    94e4:	41 80 c8 30          	or     $0x30,%r8b
    94e8:	46 88 44 14 40       	mov    %r8b,0x40(%rsp,%r10,1)
    94ed:	49 ff c2             	inc    %r10
    94f0:	48 83 f9 0a          	cmp    $0xa,%rcx
    94f4:	48 83 de 00          	sbb    $0x0,%rsi
    94f8:	48 89 c1             	mov    %rax,%rcx
    94fb:	4c 89 e6             	mov    %r12,%rsi
    94fe:	73 90                	jae    9490 <fwp_fmt_duration+0x4f0>
    9500:	45 85 d2             	test   %r10d,%r10d
    9503:	0f 8f d2 00 00 00    	jg     95db <fwp_fmt_duration+0x63b>
    9509:	31 c0                	xor    %eax,%eax
    950b:	e9 12 02 00 00       	jmp    9722 <fwp_fmt_duration+0x782>
    9510:	45 31 c0             	xor    %r8d,%r8d
    9513:	48 f7 d9             	neg    %rcx
    9516:	41 b9 00 00 00 00    	mov    $0x0,%r9d
    951c:	49 19 f1             	sbb    %rsi,%r9
    951f:	c6 04 24 2d          	movb   $0x2d,(%rsp)
    9523:	49 ba cd cc cc cc cc 	movabs $0xcccccccccccccccd,%r10
    952a:	cc cc cc 
    952d:	49 bb cc cc cc cc cc 	movabs $0xcccccccccccccccc,%r11
    9534:	cc cc cc 
    9537:	4d 89 cf             	mov    %r9,%r15
    953a:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)
    9540:	4c 89 ce             	mov    %r9,%rsi
    9543:	48 0f a4 ce 3f       	shld   $0x3f,%rcx,%rsi
    9548:	49 d1 ef             	shr    $1,%r15
    954b:	48 89 f7             	mov    %rsi,%rdi
    954e:	4c 01 ff             	add    %r15,%rdi
    9551:	48 83 d7 00          	adc    $0x0,%rdi
    9555:	48 89 f8             	mov    %rdi,%rax
    9558:	49 f7 e2             	mul    %r10
    955b:	48 c1 ea 02          	shr    $0x2,%rdx
    955f:	48 8d 04 92          	lea    (%rdx,%rdx,4),%rax
    9563:	48 29 c7             	sub    %rax,%rdi
    9566:	48 29 fe             	sub    %rdi,%rsi
    9569:	49 83 df 00          	sbb    $0x0,%r15
    956d:	48 89 f7             	mov    %rsi,%rdi
    9570:	49 0f af fb          	imul   %r11,%rdi
    9574:	48 89 f0             	mov    %rsi,%rax
    9577:	49 f7 e2             	mul    %r10
    957a:	48 01 fa             	add    %rdi,%rdx
    957d:	4d 0f af fa          	imul   %r10,%r15
    9581:	49 01 d7             	add    %rdx,%r15
    9584:	48 89 c2             	mov    %rax,%rdx
    9587:	48 01 c2             	add    %rax,%rdx
    958a:	48 8d 14 92          	lea    (%rdx,%rdx,4),%rdx
    958e:	89 ce                	mov    %ecx,%esi
    9590:	29 d6                	sub    %edx,%esi
    9592:	40 80 ce 30          	or     $0x30,%sil
    9596:	42 88 74 04 40       	mov    %sil,0x40(%rsp,%r8,1)
    959b:	49 ff c0             	inc    %r8
    959e:	48 83 f9 0a          	cmp    $0xa,%rcx
    95a2:	49 83 d9 00          	sbb    $0x0,%r9
    95a6:	48 89 c1             	mov    %rax,%rcx
    95a9:	4d 89 f9             	mov    %r15,%r9
    95ac:	73 92                	jae    9540 <fwp_fmt_duration+0x5a0>
    95ae:	45 85 c0             	test   %r8d,%r8d
    95b1:	4c 89 f7             	mov    %r14,%rdi
    95b4:	7e 44                	jle    95fa <fwp_fmt_duration+0x65a>
    95b6:	44 89 c0             	mov    %r8d,%eax
    95b9:	48 83 f8 08          	cmp    $0x8,%rax
    95bd:	0f 83 68 01 00 00    	jae    972b <fwp_fmt_duration+0x78b>
    95c3:	31 c9                	xor    %ecx,%ecx
    95c5:	48 89 c2             	mov    %rax,%rdx
    95c8:	e9 97 02 00 00       	jmp    9864 <fwp_fmt_duration+0x8c4>
    95cd:	c6 44 24 40 30       	movb   $0x30,0x40(%rsp)
    95d2:	41 ba 01 00 00 00    	mov    $0x1,%r10d
    95d8:	4c 89 f7             	mov    %r14,%rdi
    95db:	44 89 d0             	mov    %r10d,%eax
    95de:	48 83 f8 08          	cmp    $0x8,%rax
    95e2:	73 0a                	jae    95ee <fwp_fmt_duration+0x64e>
    95e4:	31 c9                	xor    %ecx,%ecx
    95e6:	48 89 c2             	mov    %rax,%rdx
    95e9:	e9 16 01 00 00       	jmp    9704 <fwp_fmt_duration+0x764>
    95ee:	83 f8 20             	cmp    $0x20,%eax
    95f1:	73 0e                	jae    9601 <fwp_fmt_duration+0x661>
    95f3:	31 c9                	xor    %ecx,%ecx
    95f5:	e9 b0 00 00 00       	jmp    96aa <fwp_fmt_duration+0x70a>
    95fa:	31 c0                	xor    %eax,%eax
    95fc:	e9 93 02 00 00       	jmp    9894 <fwp_fmt_duration+0x8f4>
    9601:	44 89 d2             	mov    %r10d,%edx
    9604:	83 e2 1f             	and    $0x1f,%edx
    9607:	48 89 c1             	mov    %rax,%rcx
    960a:	48 29 d1             	sub    %rdx,%rcx
    960d:	48 8d 74 24 10       	lea    0x10(%rsp),%rsi
    9612:	66 0f ef c0          	pxor   %xmm0,%xmm0
    9616:	49 89 c0             	mov    %rax,%r8
    9619:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)
    9620:	f3 42 0f 6f 4c 04 20 	movdqu 0x20(%rsp,%r8,1),%xmm1
    9627:	f3 42 0f 6f 54 04 30 	movdqu 0x30(%rsp,%r8,1),%xmm2
    962e:	66 0f 6f da          	movdqa %xmm2,%xmm3
    9632:	66 0f 60 d8          	punpcklbw %xmm0,%xmm3
    9636:	66 0f 70 db 4e       	pshufd $0x4e,%xmm3,%xmm3
    963b:	f2 0f 70 db 1b       	pshuflw $0x1b,%xmm3,%xmm3
    9640:	f3 0f 70 db 1b       	pshufhw $0x1b,%xmm3,%xmm3
    9645:	66 0f 68 d0          	punpckhbw %xmm0,%xmm2
    9649:	66 0f 70 d2 4e       	pshufd $0x4e,%xmm2,%xmm2
    964e:	f2 0f 70 d2 1b       	pshuflw $0x1b,%xmm2,%xmm2
    9653:	f3 0f 70 d2 1b       	pshufhw $0x1b,%xmm2,%xmm2
    9658:	66 0f 67 d3          	packuswb %xmm3,%xmm2
    965c:	66 0f 6f d9          	movdqa %xmm1,%xmm3
    9660:	66 0f 60 d8          	punpcklbw %xmm0,%xmm3
    9664:	66 0f 70 db 4e       	pshufd $0x4e,%xmm3,%xmm3
    9669:	f2 0f 70 db 1b       	pshuflw $0x1b,%xmm3,%xmm3
    966e:	f3 0f 70 db 1b       	pshufhw $0x1b,%xmm3,%xmm3
    9673:	66 0f 68 c8          	punpckhbw %xmm0,%xmm1
    9677:	66 0f 70 c9 4e       	pshufd $0x4e,%xmm1,%xmm1
    967c:	f2 0f 70 c9 1b       	pshuflw $0x1b,%xmm1,%xmm1
    9681:	f3 0f 70 c9 1b       	pshufhw $0x1b,%xmm1,%xmm1
    9686:	66 0f 67 cb          	packuswb %xmm3,%xmm1
    968a:	66 0f 7f 56 f0       	movdqa %xmm2,-0x10(%rsi)
    968f:	66 0f 7f 0e          	movdqa %xmm1,(%rsi)
    9693:	49 83 c0 e0          	add    $0xffffffffffffffe0,%r8
    9697:	48 83 c6 20          	add    $0x20,%rsi
    969b:	4c 39 c2             	cmp    %r8,%rdx
    969e:	75 80                	jne    9620 <fwp_fmt_duration+0x680>
    96a0:	48 85 d2             	test   %rdx,%rdx
    96a3:	74 7d                	je     9722 <fwp_fmt_duration+0x782>
    96a5:	83 fa 08             	cmp    $0x8,%edx
    96a8:	72 5a                	jb     9704 <fwp_fmt_duration+0x764>
    96aa:	44 89 d2             	mov    %r10d,%edx
    96ad:	83 e2 07             	and    $0x7,%edx
    96b0:	48 89 c6             	mov    %rax,%rsi
    96b3:	48 29 ce             	sub    %rcx,%rsi
    96b6:	4c 8d 04 0c          	lea    (%rsp,%rcx,1),%r8
    96ba:	48 89 c1             	mov    %rax,%rcx
    96bd:	48 29 d1             	sub    %rdx,%rcx
    96c0:	66 0f ef c0          	pxor   %xmm0,%xmm0
    96c4:	66 66 66 2e 0f 1f 84 	data16 data16 cs nopw 0x0(%rax,%rax,1)
    96cb:	00 00 00 00 00 
    96d0:	f3 0f 7e 4c 34 38    	movq   0x38(%rsp,%rsi,1),%xmm1
    96d6:	66 0f 60 c8          	punpcklbw %xmm0,%xmm1
    96da:	66 0f 70 c9 4e       	pshufd $0x4e,%xmm1,%xmm1
    96df:	f2 0f 70 c9 1b       	pshuflw $0x1b,%xmm1,%xmm1
    96e4:	f3 0f 70 c9 1b       	pshufhw $0x1b,%xmm1,%xmm1
    96e9:	66 0f 67 c9          	packuswb %xmm1,%xmm1
    96ed:	66 41 0f d6 08       	movq   %xmm1,(%r8)
    96f2:	48 83 c6 f8          	add    $0xfffffffffffffff8,%rsi
    96f6:	49 83 c0 08          	add    $0x8,%r8
    96fa:	48 39 f2             	cmp    %rsi,%rdx
    96fd:	75 d1                	jne    96d0 <fwp_fmt_duration+0x730>
    96ff:	48 85 d2             	test   %rdx,%rdx
    9702:	74 1e                	je     9722 <fwp_fmt_duration+0x782>
    9704:	48 8d 74 24 40       	lea    0x40(%rsp),%rsi
    9709:	48 01 f2             	add    %rsi,%rdx
    970c:	48 ff ca             	dec    %rdx
    970f:	90                   	nop
    9710:	0f b6 32             	movzbl (%rdx),%esi
    9713:	40 88 34 0c          	mov    %sil,(%rsp,%rcx,1)
    9717:	48 ff c1             	inc    %rcx
    971a:	48 ff ca             	dec    %rdx
    971d:	48 39 c8             	cmp    %rcx,%rax
    9720:	75 ee                	jne    9710 <fwp_fmt_duration+0x770>
    9722:	c6 04 04 00          	movb   $0x0,(%rsp,%rax,1)
    9726:	e9 6e 01 00 00       	jmp    9899 <fwp_fmt_duration+0x8f9>
    972b:	83 f8 20             	cmp    $0x20,%eax
    972e:	73 07                	jae    9737 <fwp_fmt_duration+0x797>
    9730:	31 c9                	xor    %ecx,%ecx
    9732:	e9 bd 00 00 00       	jmp    97f4 <fwp_fmt_duration+0x854>
    9737:	44 89 c6             	mov    %r8d,%esi
    973a:	44 89 c2             	mov    %r8d,%edx
    973d:	83 e2 1f             	and    $0x1f,%edx
    9740:	48 89 c1             	mov    %rax,%rcx
    9743:	48 29 d1             	sub    %rdx,%rcx
    9746:	4c 8d 0c 34          	lea    (%rsp,%rsi,1),%r9
    974a:	49 83 c1 30          	add    $0x30,%r9
    974e:	48 29 d6             	sub    %rdx,%rsi
    9751:	45 31 d2             	xor    %r10d,%r10d
    9754:	66 0f ef c0          	pxor   %xmm0,%xmm0
    9758:	0f 1f 84 00 00 00 00 	nopl   0x0(%rax,%rax,1)
    975f:	00 
    9760:	f3 41 0f 6f 49 f0    	movdqu -0x10(%r9),%xmm1
    9766:	f3 41 0f 6f 11       	movdqu (%r9),%xmm2
    976b:	66 0f 6f da          	movdqa %xmm2,%xmm3
    976f:	66 0f 60 d8          	punpcklbw %xmm0,%xmm3
    9773:	66 0f 70 db 4e       	pshufd $0x4e,%xmm3,%xmm3
    9778:	f2 0f 70 db 1b       	pshuflw $0x1b,%xmm3,%xmm3
    977d:	f3 0f 70 db 1b       	pshufhw $0x1b,%xmm3,%xmm3
    9782:	66 0f 68 d0          	punpckhbw %xmm0,%xmm2
    9786:	66 0f 70 d2 4e       	pshufd $0x4e,%xmm2,%xmm2
    978b:	f2 0f 70 d2 1b       	pshuflw $0x1b,%xmm2,%xmm2
    9790:	f3 0f 70 d2 1b       	pshufhw $0x1b,%xmm2,%xmm2
    9795:	66 0f 67 d3          	packuswb %xmm3,%xmm2
    9799:	66 0f 6f d9          	movdqa %xmm1,%xmm3
    979d:	66 0f 60 d8          	punpcklbw %xmm0,%xmm3
    97a1:	66 0f 70 db 4e       	pshufd $0x4e,%xmm3,%xmm3
    97a6:	f2 0f 70 db 1b       	pshuflw $0x1b,%xmm3,%xmm3
    97ab:	f3 0f 70 db 1b       	pshufhw $0x1b,%xmm3,%xmm3
    97b0:	66 0f 68 c8          	punpckhbw %xmm0,%xmm1
    97b4:	66 0f 70 c9 4e       	pshufd $0x4e,%xmm1,%xmm1
    97b9:	f2 0f 70 c9 1b       	pshuflw $0x1b,%xmm1,%xmm1
    97be:	f3 0f 70 c9 1b       	pshufhw $0x1b,%xmm1,%xmm1
    97c3:	66 0f 67 cb          	packuswb %xmm3,%xmm1
    97c7:	f3 42 0f 7f 54 14 01 	movdqu %xmm2,0x1(%rsp,%r10,1)
    97ce:	f3 42 0f 7f 4c 14 11 	movdqu %xmm1,0x11(%rsp,%r10,1)
    97d5:	49 83 c2 20          	add    $0x20,%r10
    97d9:	49 83 c1 e0          	add    $0xffffffffffffffe0,%r9
    97dd:	4c 39 d6             	cmp    %r10,%rsi
    97e0:	0f 85 7a ff ff ff    	jne    9760 <fwp_fmt_duration+0x7c0>
    97e6:	48 85 d2             	test   %rdx,%rdx
    97e9:	0f 84 a5 00 00 00    	je     9894 <fwp_fmt_duration+0x8f4>
    97ef:	83 fa 08             	cmp    $0x8,%edx
    97f2:	72 70                	jb     9864 <fwp_fmt_duration+0x8c4>
    97f4:	48 89 ce             	mov    %rcx,%rsi
    97f7:	45 89 c1             	mov    %r8d,%r9d
    97fa:	44 89 c2             	mov    %r8d,%edx
    97fd:	83 e2 07             	and    $0x7,%edx
    9800:	48 89 c1             	mov    %rax,%rcx
    9803:	48 29 d1             	sub    %rdx,%rcx
    9806:	49 89 f2             	mov    %rsi,%r10
    9809:	49 f7 da             	neg    %r10
    980c:	49 01 e2             	add    %rsp,%r10
    980f:	49 83 c2 40          	add    $0x40,%r10
    9813:	4d 01 ca             	add    %r9,%r10
    9816:	49 83 c2 f8          	add    $0xfffffffffffffff8,%r10
    981a:	49 29 d1             	sub    %rdx,%r9
    981d:	66 0f ef c0          	pxor   %xmm0,%xmm0
    9821:	66 66 66 66 66 66 2e 	data16 data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    9828:	0f 1f 84 00 00 00 00 
    982f:	00 
    9830:	f3 41 0f 7e 0a       	movq   (%r10),%xmm1
    9835:	66 0f 60 c8          	punpcklbw %xmm0,%xmm1
    9839:	66 0f 70 c9 4e       	pshufd $0x4e,%xmm1,%xmm1
    983e:	f2 0f 70 c9 1b       	pshuflw $0x1b,%xmm1,%xmm1
    9843:	f3 0f 70 c9 1b       	pshufhw $0x1b,%xmm1,%xmm1
    9848:	66 0f 67 c9          	packuswb %xmm1,%xmm1
    984c:	66 0f d6 4c 34 01    	movq   %xmm1,0x1(%rsp,%rsi,1)
    9852:	48 83 c6 08          	add    $0x8,%rsi
    9856:	49 83 c2 f8          	add    $0xfffffffffffffff8,%r10
    985a:	49 39 f1             	cmp    %rsi,%r9
    985d:	75 d1                	jne    9830 <fwp_fmt_duration+0x890>
    985f:	48 85 d2             	test   %rdx,%rdx
    9862:	74 30                	je     9894 <fwp_fmt_duration+0x8f4>
    9864:	48 8d 74 24 40       	lea    0x40(%rsp),%rsi
    9869:	48 01 f2             	add    %rsi,%rdx
    986c:	48 ff ca             	dec    %rdx
    986f:	44 89 c6             	mov    %r8d,%esi
    9872:	66 66 66 66 66 2e 0f 	data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    9879:	1f 84 00 00 00 00 00 
    9880:	44 0f b6 02          	movzbl (%rdx),%r8d
    9884:	44 88 44 0c 01       	mov    %r8b,0x1(%rsp,%rcx,1)
    9889:	48 ff c1             	inc    %rcx
    988c:	48 ff ca             	dec    %rdx
    988f:	48 39 ce             	cmp    %rcx,%rsi
    9892:	75 ec                	jne    9880 <fwp_fmt_duration+0x8e0>
    9894:	c6 44 04 01 00       	movb   $0x0,0x1(%rsp,%rax,1)
    9899:	48 8b 0b             	mov    (%rbx),%rcx
    989c:	48 8d 35 2b 2d 00 00 	lea    0x2d2b(%rip),%rsi        # c5ce <fwp_segv.msg+0x38e>
    98a3:	48 89 e2             	mov    %rsp,%rdx
    98a6:	31 c0                	xor    %eax,%eax
    98a8:	e8 13 8a ff ff       	call   22c0 <sprintf@plt>
    98ad:	48 81 c4 88 00 00 00 	add    $0x88,%rsp
    98b4:	5b                   	pop    %rbx
    98b5:	41 5c                	pop    %r12
    98b7:	41 5e                	pop    %r14
    98b9:	41 5f                	pop    %r15
    98bb:	c3                   	ret
    98bc:	45 31 c9             	xor    %r9d,%r9d
    98bf:	48 f7 de             	neg    %rsi
    98c2:	41 ba 00 00 00 00    	mov    $0x0,%r10d
    98c8:	4d 19 c2             	sbb    %r8,%r10
    98cb:	c6 04 24 2d          	movb   $0x2d,(%rsp)
    98cf:	49 bb cd cc cc cc cc 	movabs $0xcccccccccccccccd,%r11
    98d6:	cc cc cc 
    98d9:	48 bb cc cc cc cc cc 	movabs $0xcccccccccccccccc,%rbx
    98e0:	cc cc cc 
    98e3:	4d 89 d6             	mov    %r10,%r14
    98e6:	66 2e 0f 1f 84 00 00 	cs nopw 0x0(%rax,%rax,1)
    98ed:	00 00 00 
    98f0:	4c 89 d1             	mov    %r10,%rcx
    98f3:	48 0f a4 f1 3f       	shld   $0x3f,%rsi,%rcx
    98f8:	49 d1 ee             	shr    $1,%r14
    98fb:	49 89 c8             	mov    %rcx,%r8
    98fe:	4d 01 f0             	add    %r14,%r8
    9901:	49 83 d0 00          	adc    $0x0,%r8
    9905:	4c 89 c0             	mov    %r8,%rax
    9908:	49 f7 e3             	mul    %r11
    990b:	48 c1 ea 02          	shr    $0x2,%rdx
    990f:	48 8d 04 92          	lea    (%rdx,%rdx,4),%rax
    9913:	49 29 c0             	sub    %rax,%r8
    9916:	4c 29 c1             	sub    %r8,%rcx
    9919:	49 83 de 00          	sbb    $0x0,%r14
    991d:	49 89 c8             	mov    %rcx,%r8
    9920:	4c 0f af c3          	imul   %rbx,%r8
    9924:	48 89 c8             	mov    %rcx,%rax
    9927:	49 f7 e3             	mul    %r11
    992a:	4c 01 c2             	add    %r8,%rdx
    992d:	4d 0f af f3          	imul   %r11,%r14
    9931:	49 01 d6             	add    %rdx,%r14
    9934:	48 89 c1             	mov    %rax,%rcx
    9937:	48 01 c1             	add    %rax,%rcx
    993a:	48 8d 0c 89          	lea    (%rcx,%rcx,4),%rcx
    993e:	89 f2                	mov    %esi,%edx
    9940:	29 ca                	sub    %ecx,%edx
    9942:	80 ca 30             	or     $0x30,%dl
    9945:	42 88 54 0c 40       	mov    %dl,0x40(%rsp,%r9,1)
    994a:	49 ff c1             	inc    %r9
    994d:	48 83 fe 0a          	cmp    $0xa,%rsi
    9951:	49 83 da 00          	sbb    $0x0,%r10
    9955:	48 89 c6             	mov    %rax,%rsi
    9958:	4d 89 f2             	mov    %r14,%r10
    995b:	73 93                	jae    98f0 <fwp_fmt_duration+0x950>
    995d:	45 85 c9             	test   %r9d,%r9d
    9960:	7e 13                	jle    9975 <fwp_fmt_duration+0x9d5>
    9962:	44 89 c8             	mov    %r9d,%eax
    9965:	48 83 f8 08          	cmp    $0x8,%rax
    9969:	73 11                	jae    997c <fwp_fmt_duration+0x9dc>
    996b:	31 c9                	xor    %ecx,%ecx
    996d:	48 89 c2             	mov    %rax,%rdx
    9970:	e9 29 01 00 00       	jmp    9a9e <fwp_fmt_duration+0xafe>
    9975:	31 c0                	xor    %eax,%eax
    9977:	e9 48 01 00 00       	jmp    9ac4 <fwp_fmt_duration+0xb24>
    997c:	83 f8 20             	cmp    $0x20,%eax
    997f:	73 07                	jae    9988 <fwp_fmt_duration+0x9e8>
    9981:	31 c9                	xor    %ecx,%ecx
    9983:	e9 b5 00 00 00       	jmp    9a3d <fwp_fmt_duration+0xa9d>
    9988:	44 89 ce             	mov    %r9d,%esi
    998b:	44 89 ca             	mov    %r9d,%edx
    998e:	83 e2 1f             	and    $0x1f,%edx
    9991:	48 89 c1             	mov    %rax,%rcx
    9994:	48 29 d1             	sub    %rdx,%rcx
    9997:	4c 8d 04 34          	lea    (%rsp,%rsi,1),%r8
    999b:	49 83 c0 30          	add    $0x30,%r8
    999f:	48 29 d6             	sub    %rdx,%rsi
    99a2:	45 31 d2             	xor    %r10d,%r10d
    99a5:	66 0f ef c0          	pxor   %xmm0,%xmm0
    99a9:	f3 41 0f 6f 48 f0    	movdqu -0x10(%r8),%xmm1
    99af:	f3 41 0f 6f 10       	movdqu (%r8),%xmm2
    99b4:	66 0f 6f da          	movdqa %xmm2,%xmm3
    99b8:	66 0f 60 d8          	punpcklbw %xmm0,%xmm3
    99bc:	66 0f 70 db 4e       	pshufd $0x4e,%xmm3,%xmm3
    99c1:	f2 0f 70 db 1b       	pshuflw $0x1b,%xmm3,%xmm3
    99c6:	f3 0f 70 db 1b       	pshufhw $0x1b,%xmm3,%xmm3
    99cb:	66 0f 68 d0          	punpckhbw %xmm0,%xmm2
    99cf:	66 0f 70 d2 4e       	pshufd $0x4e,%xmm2,%xmm2
    99d4:	f2 0f 70 d2 1b       	pshuflw $0x1b,%xmm2,%xmm2
    99d9:	f3 0f 70 d2 1b       	pshufhw $0x1b,%xmm2,%xmm2
    99de:	66 0f 67 d3          	packuswb %xmm3,%xmm2
    99e2:	66 0f 6f d9          	movdqa %xmm1,%xmm3
    99e6:	66 0f 60 d8          	punpcklbw %xmm0,%xmm3
    99ea:	66 0f 70 db 4e       	pshufd $0x4e,%xmm3,%xmm3
    99ef:	f2 0f 70 db 1b       	pshuflw $0x1b,%xmm3,%xmm3
    99f4:	f3 0f 70 db 1b       	pshufhw $0x1b,%xmm3,%xmm3
    99f9:	66 0f 68 c8          	punpckhbw %xmm0,%xmm1
    99fd:	66 0f 70 c9 4e       	pshufd $0x4e,%xmm1,%xmm1
    9a02:	f2 0f 70 c9 1b       	pshuflw $0x1b,%xmm1,%xmm1
    9a07:	f3 0f 70 c9 1b       	pshufhw $0x1b,%xmm1,%xmm1
    9a0c:	66 0f 67 cb          	packuswb %xmm3,%xmm1
    9a10:	f3 42 0f 7f 54 14 01 	movdqu %xmm2,0x1(%rsp,%r10,1)
    9a17:	f3 42 0f 7f 4c 14 11 	movdqu %xmm1,0x11(%rsp,%r10,1)
    9a1e:	49 83 c2 20          	add    $0x20,%r10
    9a22:	49 83 c0 e0          	add    $0xffffffffffffffe0,%r8
    9a26:	4c 39 d6             	cmp    %r10,%rsi
    9a29:	0f 85 7a ff ff ff    	jne    99a9 <fwp_fmt_duration+0xa09>
    9a2f:	48 85 d2             	test   %rdx,%rdx
    9a32:	0f 84 8c 00 00 00    	je     9ac4 <fwp_fmt_duration+0xb24>
    9a38:	83 fa 08             	cmp    $0x8,%edx
    9a3b:	72 61                	jb     9a9e <fwp_fmt_duration+0xafe>
    9a3d:	48 89 ce             	mov    %rcx,%rsi
    9a40:	45 89 c8             	mov    %r9d,%r8d
    9a43:	44 89 ca             	mov    %r9d,%edx
    9a46:	83 e2 07             	and    $0x7,%edx
    9a49:	48 89 c1             	mov    %rax,%rcx
    9a4c:	48 29 d1             	sub    %rdx,%rcx
    9a4f:	49 89 f2             	mov    %rsi,%r10
    9a52:	49 f7 da             	neg    %r10
    9a55:	49 01 e2             	add    %rsp,%r10
    9a58:	49 83 c2 40          	add    $0x40,%r10
    9a5c:	4d 01 c2             	add    %r8,%r10
    9a5f:	49 83 c2 f8          	add    $0xfffffffffffffff8,%r10
    9a63:	49 29 d0             	sub    %rdx,%r8
    9a66:	66 0f ef c0          	pxor   %xmm0,%xmm0
    9a6a:	f3 41 0f 7e 0a       	movq   (%r10),%xmm1
    9a6f:	66 0f 60 c8          	punpcklbw %xmm0,%xmm1
    9a73:	66 0f 70 c9 4e       	pshufd $0x4e,%xmm1,%xmm1
    9a78:	f2 0f 70 c9 1b       	pshuflw $0x1b,%xmm1,%xmm1
    9a7d:	f3 0f 70 c9 1b       	pshufhw $0x1b,%xmm1,%xmm1
    9a82:	66 0f 67 c9          	packuswb %xmm1,%xmm1
    9a86:	66 0f d6 4c 34 01    	movq   %xmm1,0x1(%rsp,%rsi,1)
    9a8c:	48 83 c6 08          	add    $0x8,%rsi
    9a90:	49 83 c2 f8          	add    $0xfffffffffffffff8,%r10
    9a94:	49 39 f0             	cmp    %rsi,%r8
    9a97:	75 d1                	jne    9a6a <fwp_fmt_duration+0xaca>
    9a99:	48 85 d2             	test   %rdx,%rdx
    9a9c:	74 26                	je     9ac4 <fwp_fmt_duration+0xb24>
    9a9e:	48 8d 74 24 40       	lea    0x40(%rsp),%rsi
    9aa3:	48 01 f2             	add    %rsi,%rdx
    9aa6:	48 ff ca             	dec    %rdx
    9aa9:	44 89 ce             	mov    %r9d,%esi
    9aac:	0f 1f 40 00          	nopl   0x0(%rax)
    9ab0:	44 0f b6 02          	movzbl (%rdx),%r8d
    9ab4:	44 88 44 0c 01       	mov    %r8b,0x1(%rsp,%rcx,1)
    9ab9:	48 ff c1             	inc    %rcx
    9abc:	48 ff ca             	dec    %rdx
    9abf:	48 39 ce             	cmp    %rcx,%rsi
    9ac2:	75 ec                	jne    9ab0 <fwp_fmt_duration+0xb10>
    9ac4:	c6 44 04 01 00       	movb   $0x0,0x1(%rsp,%rax,1)
    9ac9:	e9 28 f9 ff ff       	jmp    93f6 <fwp_fmt_duration+0x456>
    9ace:	66 90                	xchg   %ax,%ax

0000000000009ad0 <fwp_format_g>:
    9ad0:	55                   	push   %rbp
    9ad1:	41 57                	push   %r15
    9ad3:	41 56                	push   %r14
    9ad5:	41 55                	push   %r13
    9ad7:	41 54                	push   %r12
    9ad9:	53                   	push   %rbx
    9ada:	48 81 ec 98 00 00 00 	sub    $0x98,%rsp
    9ae1:	89 f5                	mov    %esi,%ebp
    9ae3:	48 89 fb             	mov    %rdi,%rbx
    9ae6:	ff cd                	dec    %ebp
    9ae8:	48 8d 15 ab 2a 00 00 	lea    0x2aab(%rip),%rdx        # c59a <fwp_segv.msg+0x35a>
    9aef:	4c 8d 64 24 50       	lea    0x50(%rsp),%r12
    9af4:	be 40 00 00 00       	mov    $0x40,%esi
    9af9:	4c 89 e7             	mov    %r12,%rdi
    9afc:	89 e9                	mov    %ebp,%ecx
    9afe:	f2 0f 11 44 24 08    	movsd  %xmm0,0x8(%rsp)
    9b04:	b0 01                	mov    $0x1,%al
    9b06:	e8 35 86 ff ff       	call   2140 <snprintf@plt>
    9b0b:	4c 89 e7             	mov    %r12,%rdi
    9b0e:	be 65 00 00 00       	mov    $0x65,%esi
    9b13:	e8 18 86 ff ff       	call   2130 <strchr@plt>
    9b18:	49 89 c7             	mov    %rax,%r15
    9b1b:	48 8d 78 01          	lea    0x1(%rax),%rdi
    9b1f:	45 31 ed             	xor    %r13d,%r13d
    9b22:	31 f6                	xor    %esi,%esi
    9b24:	ba 0a 00 00 00       	mov    $0xa,%edx
    9b29:	e8 d2 86 ff ff       	call   2200 <strtol@plt>
    9b2e:	49 89 c6             	mov    %rax,%r14
    9b31:	83 c0 ef             	add    $0xffffffef,%eax
    9b34:	83 f8 e9             	cmp    $0xffffffe9,%eax
    9b37:	77 5f                	ja     9b98 <fwp_format_g+0xc8>
    9b39:	4d 29 e7             	sub    %r12,%r15
    9b3c:	4c 8d 6c 24 10       	lea    0x10(%rsp),%r13
    9b41:	4c 89 ef             	mov    %r13,%rdi
    9b44:	4c 89 e6             	mov    %r12,%rsi
    9b47:	4c 89 fa             	mov    %r15,%rdx
    9b4a:	e8 c1 86 ff ff       	call   2210 <memcpy@plt>
    9b4f:	42 c6 44 3c 10 00    	movb   $0x0,0x10(%rsp,%r15,1)
    9b55:	4c 89 ef             	mov    %r13,%rdi
    9b58:	be 2e 00 00 00       	mov    $0x2e,%esi
    9b5d:	e8 ce 85 ff ff       	call   2130 <strchr@plt>
    9b62:	48 85 c0             	test   %rax,%rax
    9b65:	0f 84 a8 00 00 00    	je     9c13 <fwp_format_g+0x143>
    9b6b:	4d 85 ff             	test   %r15,%r15
    9b6e:	0f 84 9f 00 00 00    	je     9c13 <fwp_format_g+0x143>
    9b74:	66 66 66 2e 0f 1f 84 	data16 data16 cs nopw 0x0(%rax,%rax,1)
    9b7b:	00 00 00 00 00 
    9b80:	42 0f b6 44 3c 0f    	movzbl 0xf(%rsp,%r15,1),%eax
    9b86:	83 f8 30             	cmp    $0x30,%eax
    9b89:	75 7d                	jne    9c08 <fwp_format_g+0x138>
    9b8b:	42 c6 44 3c 0f 00    	movb   $0x0,0xf(%rsp,%r15,1)
    9b91:	49 ff cf             	dec    %r15
    9b94:	75 ea                	jne    9b80 <fwp_format_g+0xb0>
    9b96:	eb 7b                	jmp    9c13 <fwp_format_g+0x143>
    9b98:	44 29 f5             	sub    %r14d,%ebp
    9b9b:	85 ed                	test   %ebp,%ebp
    9b9d:	44 0f 4f ed          	cmovg  %ebp,%r13d
    9ba1:	48 8d 15 01 2a 00 00 	lea    0x2a01(%rip),%rdx        # c5a9 <fwp_segv.msg+0x369>
    9ba8:	be 90 01 00 00       	mov    $0x190,%esi
    9bad:	48 89 df             	mov    %rbx,%rdi
    9bb0:	44 89 e9             	mov    %r13d,%ecx
    9bb3:	f2 0f 10 44 24 08    	movsd  0x8(%rsp),%xmm0
    9bb9:	b0 01                	mov    $0x1,%al
    9bbb:	e8 80 85 ff ff       	call   2140 <snprintf@plt>
    9bc0:	48 89 df             	mov    %rbx,%rdi
    9bc3:	e8 48 85 ff ff       	call   2110 <strlen@plt>
    9bc8:	49 89 c6             	mov    %rax,%r14
    9bcb:	48 89 df             	mov    %rbx,%rdi
    9bce:	be 2e 00 00 00       	mov    $0x2e,%esi
    9bd3:	e8 58 85 ff ff       	call   2130 <strchr@plt>
    9bd8:	48 85 c0             	test   %rax,%rax
    9bdb:	74 69                	je     9c46 <fwp_format_g+0x176>
    9bdd:	4d 85 f6             	test   %r14,%r14
    9be0:	74 64                	je     9c46 <fwp_format_g+0x176>
    9be2:	66 66 66 66 66 2e 0f 	data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    9be9:	1f 84 00 00 00 00 00 
    9bf0:	42 0f b6 44 33 ff    	movzbl -0x1(%rbx,%r14,1),%eax
    9bf6:	83 f8 30             	cmp    $0x30,%eax
    9bf9:	75 5d                	jne    9c58 <fwp_format_g+0x188>
    9bfb:	42 c6 44 33 ff 00    	movb   $0x0,-0x1(%rbx,%r14,1)
    9c01:	49 ff ce             	dec    %r14
    9c04:	75 ea                	jne    9bf0 <fwp_format_g+0x120>
    9c06:	eb 3e                	jmp    9c46 <fwp_format_g+0x176>
    9c08:	83 f8 2e             	cmp    $0x2e,%eax
    9c0b:	75 06                	jne    9c13 <fwp_format_g+0x143>
    9c0d:	42 c6 44 3c 0f 00    	movb   $0x0,0xf(%rsp,%r15,1)
    9c13:	44 89 f0             	mov    %r14d,%eax
    9c16:	c1 e8 1f             	shr    $0x1f,%eax
    9c19:	44 8d 04 45 2b 00 00 	lea    0x2b(,%rax,2),%r8d
    9c20:	00 
    9c21:	45 89 f1             	mov    %r14d,%r9d
    9c24:	41 f7 d9             	neg    %r9d
    9c27:	45 0f 48 ce          	cmovs  %r14d,%r9d
    9c2b:	48 8d 15 6d 29 00 00 	lea    0x296d(%rip),%rdx        # c59f <fwp_segv.msg+0x35f>
    9c32:	48 8d 4c 24 10       	lea    0x10(%rsp),%rcx
    9c37:	be 90 01 00 00       	mov    $0x190,%esi
    9c3c:	48 89 df             	mov    %rbx,%rdi
    9c3f:	31 c0                	xor    %eax,%eax
    9c41:	e8 fa 84 ff ff       	call   2140 <snprintf@plt>
    9c46:	48 81 c4 98 00 00 00 	add    $0x98,%rsp
    9c4d:	5b                   	pop    %rbx
    9c4e:	41 5c                	pop    %r12
    9c50:	41 5d                	pop    %r13
    9c52:	41 5e                	pop    %r14
    9c54:	41 5f                	pop    %r15
    9c56:	5d                   	pop    %rbp
    9c57:	c3                   	ret
    9c58:	83 f8 2e             	cmp    $0x2e,%eax
    9c5b:	75 e9                	jne    9c46 <fwp_format_g+0x176>
    9c5d:	42 c6 44 33 ff 00    	movb   $0x0,-0x1(%rbx,%r14,1)
    9c63:	eb e1                	jmp    9c46 <fwp_format_g+0x176>
    9c65:	66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
    9c6c:	00 00 00 00 

0000000000009c70 <fwp_owned_entry3>:
    9c70:	41 57                	push   %r15
    9c72:	41 56                	push   %r14
    9c74:	53                   	push   %rbx
    9c75:	48 83 ec 20          	sub    $0x20,%rsp
    9c79:	48 89 fb             	mov    %rdi,%rbx
    9c7c:	48 8b 05 f5 6f 00 00 	mov    0x6ff5(%rip),%rax        # 10c78 <fwp_cleanups>
    9c83:	48 89 44 24 08       	mov    %rax,0x8(%rsp)
    9c88:	48 8d 05 c1 04 00 00 	lea    0x4c1(%rip),%rax        # a150 <fwp_entry_release3>
    9c8f:	48 89 44 24 10       	mov    %rax,0x10(%rsp)
    9c94:	48 89 7c 24 18       	mov    %rdi,0x18(%rsp)
    9c99:	4c 8d 7c 24 08       	lea    0x8(%rsp),%r15
    9c9e:	4c 89 3d d3 6f 00 00 	mov    %r15,0x6fd3(%rip)        # 10c78 <fwp_cleanups>
    9ca5:	48 8b 3f             	mov    (%rdi),%rdi
    9ca8:	48 8b 73 08          	mov    0x8(%rbx),%rsi
    9cac:	e8 9f d2 ff ff       	call   6f50 <fwp_p_file_with_owned>
    9cb1:	4c 39 3d c0 6f 00 00 	cmp    %r15,0x6fc0(%rip)        # 10c78 <fwp_cleanups>
    9cb8:	0f 85 c4 00 00 00    	jne    9d82 <fwp_owned_entry3+0x112>
    9cbe:	49 89 c6             	mov    %rax,%r14
    9cc1:	48 8b 44 24 08       	mov    0x8(%rsp),%rax
    9cc6:	48 89 05 ab 6f 00 00 	mov    %rax,0x6fab(%rip)        # 10c78 <fwp_cleanups>
    9ccd:	48 8b 03             	mov    (%rbx),%rax
    9cd0:	48 8b 3b             	mov    (%rbx),%rdi
    9cd3:	48 89 f8             	mov    %rdi,%rax
    9cd6:	48 2b 05 fb 64 00 00 	sub    0x64fb(%rip),%rax        # 101d8 <fwp_gc+0x1030>
    9cdd:	48 8b 0d 1c 65 00 00 	mov    0x651c(%rip),%rcx        # 10200 <fwp_gc+0x1058>
    9ce4:	48 c1 e1 10          	shl    $0x10,%rcx
    9ce8:	48 39 c8             	cmp    %rcx,%rax
    9ceb:	73 71                	jae    9d5e <fwp_owned_entry3+0xee>
    9ced:	48 8b 0d 2c 65 00 00 	mov    0x652c(%rip),%rcx        # 10220 <fwp_gc+0x1078>
    9cf4:	48 89 c2             	mov    %rax,%rdx
    9cf7:	48 c1 ea 10          	shr    $0x10,%rdx
    9cfb:	48 69 d2 28 12 00 00 	imul   $0x1228,%rdx,%rdx
    9d02:	0f b6 34 11          	movzbl (%rcx,%rdx,1),%esi
    9d06:	48 25 ff ff 00 00    	and    $0xffff,%rax
    9d0c:	75 12                	jne    9d20 <fwp_owned_entry3+0xb0>
    9d0e:	40 80 fe 02          	cmp    $0x2,%sil
    9d12:	75 0c                	jne    9d20 <fwp_owned_entry3+0xb0>
    9d14:	48 8d 04 11          	lea    (%rcx,%rdx,1),%rax
    9d18:	48 05 28 02 00 00    	add    $0x228,%rax
    9d1e:	eb 1f                	jmp    9d3f <fwp_owned_entry3+0xcf>
    9d20:	40 80 fe 01          	cmp    $0x1,%sil
    9d24:	75 38                	jne    9d5e <fwp_owned_entry3+0xee>
    9d26:	48 8d 34 11          	lea    (%rcx,%rdx,1),%rsi
    9d2a:	8b 4c 11 20          	mov    0x20(%rcx,%rdx,1),%ecx
    9d2e:	48 0f af c1          	imul   %rcx,%rax
    9d32:	48 c1 e8 20          	shr    $0x20,%rax
    9d36:	48 01 f0             	add    %rsi,%rax
    9d39:	48 05 28 02 00 00    	add    $0x228,%rax
    9d3f:	0f b6 08             	movzbl (%rax),%ecx
    9d42:	85 c9                	test   %ecx,%ecx
    9d44:	74 18                	je     9d5e <fwp_owned_entry3+0xee>
    9d46:	83 f9 01             	cmp    $0x1,%ecx
    9d49:	75 07                	jne    9d52 <fwp_owned_entry3+0xe2>
    9d4b:	e8 c0 c8 ff ff       	call   6610 <fwp_rc_free_obj>
    9d50:	eb 0c                	jmp    9d5e <fwp_owned_entry3+0xee>
    9d52:	81 f9 ff 00 00 00    	cmp    $0xff,%ecx
    9d58:	74 1e                	je     9d78 <fwp_owned_entry3+0x108>
    9d5a:	fe c9                	dec    %cl
    9d5c:	88 08                	mov    %cl,(%rax)
    9d5e:	48 8b 43 08          	mov    0x8(%rbx),%rax
    9d62:	48 8b 7b 08          	mov    0x8(%rbx),%rdi
    9d66:	e8 85 c3 ff ff       	call   60f0 <fwp_closure_drop>
    9d6b:	4c 89 f0             	mov    %r14,%rax
    9d6e:	48 83 c4 20          	add    $0x20,%rsp
    9d72:	5b                   	pop    %rbx
    9d73:	41 5e                	pop    %r14
    9d75:	41 5f                	pop    %r15
    9d77:	c3                   	ret
    9d78:	48 89 c7             	mov    %rax,%rdi
    9d7b:	e8 80 c6 ff ff       	call   6400 <fwp_rc_wide_drop>
    9d80:	eb dc                	jmp    9d5e <fwp_owned_entry3+0xee>
    9d82:	e8 d9 82 ff ff       	call   2060 <abort@plt>
    9d87:	66 0f 1f 84 00 00 00 	nopw   0x0(%rax,%rax,1)
    9d8e:	00 00 

0000000000009d90 <fwp_caps3>:
    9d90:	85 f6                	test   %esi,%esi
    9d92:	74 0e                	je     9da2 <fwp_caps3+0x12>
    9d94:	8b 57 04             	mov    0x4(%rdi),%edx
    9d97:	48 83 c7 08          	add    $0x8,%rdi
    9d9b:	31 f6                	xor    %esi,%esi
    9d9d:	e9 de 00 00 00       	jmp    9e80 <fwp_args3>
    9da2:	53                   	push   %rbx
    9da3:	83 7f 04 00          	cmpl   $0x0,0x4(%rdi)
    9da7:	0f 84 b4 00 00 00    	je     9e61 <fwp_caps3+0xd1>
    9dad:	48 8b 47 08          	mov    0x8(%rdi),%rax
    9db1:	48 89 c1             	mov    %rax,%rcx
    9db4:	48 2b 0d 1d 64 00 00 	sub    0x641d(%rip),%rcx        # 101d8 <fwp_gc+0x1030>
    9dbb:	48 8b 15 3e 64 00 00 	mov    0x643e(%rip),%rdx        # 10200 <fwp_gc+0x1058>
    9dc2:	48 c1 e2 10          	shl    $0x10,%rdx
    9dc6:	48 39 d1             	cmp    %rdx,%rcx
    9dc9:	73 7e                	jae    9e49 <fwp_caps3+0xb9>
    9dcb:	48 8b 15 4e 64 00 00 	mov    0x644e(%rip),%rdx        # 10220 <fwp_gc+0x1078>
    9dd2:	48 89 ce             	mov    %rcx,%rsi
    9dd5:	48 c1 ee 10          	shr    $0x10,%rsi
    9dd9:	48 69 f6 28 12 00 00 	imul   $0x1228,%rsi,%rsi
    9de0:	44 0f b6 04 32       	movzbl (%rdx,%rsi,1),%r8d
    9de5:	48 81 e1 ff ff 00 00 	and    $0xffff,%rcx
    9dec:	75 13                	jne    9e01 <fwp_caps3+0x71>
    9dee:	41 80 f8 02          	cmp    $0x2,%r8b
    9df2:	75 0d                	jne    9e01 <fwp_caps3+0x71>
    9df4:	48 8d 0c 32          	lea    (%rdx,%rsi,1),%rcx
    9df8:	48 81 c1 28 02 00 00 	add    $0x228,%rcx
    9dff:	eb 20                	jmp    9e21 <fwp_caps3+0x91>
    9e01:	41 80 f8 01          	cmp    $0x1,%r8b
    9e05:	75 42                	jne    9e49 <fwp_caps3+0xb9>
    9e07:	4c 8d 04 32          	lea    (%rdx,%rsi,1),%r8
    9e0b:	8b 54 32 20          	mov    0x20(%rdx,%rsi,1),%edx
    9e0f:	48 0f af ca          	imul   %rdx,%rcx
    9e13:	48 c1 e9 20          	shr    $0x20,%rcx
    9e17:	4c 01 c1             	add    %r8,%rcx
    9e1a:	48 81 c1 28 02 00 00 	add    $0x228,%rcx
    9e21:	0f b6 11             	movzbl (%rcx),%edx
    9e24:	85 d2                	test   %edx,%edx
    9e26:	74 21                	je     9e49 <fwp_caps3+0xb9>
    9e28:	83 fa 01             	cmp    $0x1,%edx
    9e2b:	75 10                	jne    9e3d <fwp_caps3+0xad>
    9e2d:	48 89 fb             	mov    %rdi,%rbx
    9e30:	48 89 c7             	mov    %rax,%rdi
    9e33:	e8 d8 c7 ff ff       	call   6610 <fwp_rc_free_obj>
    9e38:	48 89 df             	mov    %rbx,%rdi
    9e3b:	eb 0c                	jmp    9e49 <fwp_caps3+0xb9>
    9e3d:	81 fa ff 00 00 00    	cmp    $0xff,%edx
    9e43:	74 22                	je     9e67 <fwp_caps3+0xd7>
    9e45:	fe ca                	dec    %dl
    9e47:	88 11                	mov    %dl,(%rcx)
    9e49:	83 7f 04 02          	cmpl   $0x2,0x4(%rdi)
    9e4d:	72 12                	jb     9e61 <fwp_caps3+0xd1>
    9e4f:	48 8b 47 10          	mov    0x10(%rdi),%rax
    9e53:	48 89 fb             	mov    %rdi,%rbx
    9e56:	48 89 c7             	mov    %rax,%rdi
    9e59:	e8 92 c2 ff ff       	call   60f0 <fwp_closure_drop>
    9e5e:	48 89 df             	mov    %rbx,%rdi
    9e61:	5b                   	pop    %rbx
    9e62:	e9 a9 c7 ff ff       	jmp    6610 <fwp_rc_free_obj>
    9e67:	48 89 fb             	mov    %rdi,%rbx
    9e6a:	48 89 cf             	mov    %rcx,%rdi
    9e6d:	e8 8e c5 ff ff       	call   6400 <fwp_rc_wide_drop>
    9e72:	eb c4                	jmp    9e38 <fwp_caps3+0xa8>
    9e74:	66 66 66 2e 0f 1f 84 	data16 data16 cs nopw 0x0(%rax,%rax,1)
    9e7b:	00 00 00 00 00 

0000000000009e80 <fwp_args3>:
    9e80:	55                   	push   %rbp
    9e81:	41 57                	push   %r15
    9e83:	41 56                	push   %r14
    9e85:	53                   	push   %rbx
    9e86:	48 83 ec 38          	sub    $0x38,%rsp
    9e8a:	48 89 7c 24 08       	mov    %rdi,0x8(%rsp)
    9e8f:	48 8d 05 ca 01 00 00 	lea    0x1ca(%rip),%rax        # a060 <fwp_arg_drop3>
    9e96:	48 89 44 24 10       	mov    %rax,0x10(%rsp)
    9e9b:	89 74 24 18          	mov    %esi,0x18(%rsp)
    9e9f:	c7 44 24 1c 00 00 00 	movl   $0x0,0x1c(%rsp)
    9ea6:	00 
    9ea7:	48 8b 05 ca 6d 00 00 	mov    0x6dca(%rip),%rax        # 10c78 <fwp_cleanups>
    9eae:	48 89 44 24 20       	mov    %rax,0x20(%rsp)
    9eb3:	48 8d 05 76 d0 ff ff 	lea    -0x2f8a(%rip),%rax        # 6f30 <fwp_args_release>
    9eba:	48 89 44 24 28       	mov    %rax,0x28(%rsp)
    9ebf:	48 8d 44 24 08       	lea    0x8(%rsp),%rax
    9ec4:	48 89 44 24 30       	mov    %rax,0x30(%rsp)
    9ec9:	48 8d 5c 24 20       	lea    0x20(%rsp),%rbx
    9ece:	48 89 1d a3 6d 00 00 	mov    %rbx,0x6da3(%rip)        # 10c78 <fwp_cleanups>
    9ed5:	85 f6                	test   %esi,%esi
    9ed7:	75 52                	jne    9f2b <fwp_args3+0xab>
    9ed9:	85 d2                	test   %edx,%edx
    9edb:	74 4e                	je     9f2b <fwp_args3+0xab>
    9edd:	48 8b 07             	mov    (%rdi),%rax
    9ee0:	48 2b 05 f1 62 00 00 	sub    0x62f1(%rip),%rax        # 101d8 <fwp_gc+0x1030>
    9ee7:	48 8b 0d 12 63 00 00 	mov    0x6312(%rip),%rcx        # 10200 <fwp_gc+0x1058>
    9eee:	48 c1 e1 10          	shl    $0x10,%rcx
    9ef2:	48 39 c8             	cmp    %rcx,%rax
    9ef5:	73 72                	jae    9f69 <fwp_args3+0xe9>
    9ef7:	48 8b 0d 22 63 00 00 	mov    0x6322(%rip),%rcx        # 10220 <fwp_gc+0x1078>
    9efe:	49 89 c0             	mov    %rax,%r8
    9f01:	49 c1 e8 10          	shr    $0x10,%r8
    9f05:	4d 69 c0 28 12 00 00 	imul   $0x1228,%r8,%r8
    9f0c:	46 0f b6 0c 01       	movzbl (%rcx,%r8,1),%r9d
    9f11:	48 25 ff ff 00 00    	and    $0xffff,%rax
    9f17:	75 1c                	jne    9f35 <fwp_args3+0xb5>
    9f19:	41 80 f9 02          	cmp    $0x2,%r9b
    9f1d:	75 16                	jne    9f35 <fwp_args3+0xb5>
    9f1f:	4a 8d 04 01          	lea    (%rcx,%r8,1),%rax
    9f23:	48 05 28 02 00 00    	add    $0x228,%rax
    9f29:	eb 2a                	jmp    9f55 <fwp_args3+0xd5>
    9f2b:	83 fe 01             	cmp    $0x1,%esi
    9f2e:	76 41                	jbe    9f71 <fwp_args3+0xf1>
    9f30:	e9 d4 00 00 00       	jmp    a009 <fwp_args3+0x189>
    9f35:	41 80 f9 01          	cmp    $0x1,%r9b
    9f39:	75 2e                	jne    9f69 <fwp_args3+0xe9>
    9f3b:	4e 8d 0c 01          	lea    (%rcx,%r8,1),%r9
    9f3f:	42 8b 4c 01 20       	mov    0x20(%rcx,%r8,1),%ecx
    9f44:	48 0f af c1          	imul   %rcx,%rax
    9f48:	48 c1 e8 20          	shr    $0x20,%rax
    9f4c:	4c 01 c8             	add    %r9,%rax
    9f4f:	48 05 28 02 00 00    	add    $0x228,%rax
    9f55:	0f b6 08             	movzbl (%rax),%ecx
    9f58:	84 c9                	test   %cl,%cl
    9f5a:	74 0d                	je     9f69 <fwp_args3+0xe9>
    9f5c:	80 f9 fe             	cmp    $0xfe,%cl
    9f5f:	0f 83 c4 00 00 00    	jae    a029 <fwp_args3+0x1a9>
    9f65:	fe c1                	inc    %cl
    9f67:	88 08                	mov    %cl,(%rax)
    9f69:	c7 44 24 1c 01 00 00 	movl   $0x1,0x1c(%rsp)
    9f70:	00 
    9f71:	89 f0                	mov    %esi,%eax
    9f73:	83 f0 01             	xor    $0x1,%eax
    9f76:	39 d0                	cmp    %edx,%eax
    9f78:	0f 83 8b 00 00 00    	jae    a009 <fwp_args3+0x189>
    9f7e:	89 c0                	mov    %eax,%eax
    9f80:	48 8b 04 c7          	mov    (%rdi,%rax,8),%rax
    9f84:	48 2b 05 4d 62 00 00 	sub    0x624d(%rip),%rax        # 101d8 <fwp_gc+0x1030>
    9f8b:	48 8b 0d 6e 62 00 00 	mov    0x626e(%rip),%rcx        # 10200 <fwp_gc+0x1058>
    9f92:	48 c1 e1 10          	shl    $0x10,%rcx
    9f96:	48 39 c8             	cmp    %rcx,%rax
    9f99:	73 63                	jae    9ffe <fwp_args3+0x17e>
    9f9b:	48 8b 0d 7e 62 00 00 	mov    0x627e(%rip),%rcx        # 10220 <fwp_gc+0x1078>
    9fa2:	48 89 c2             	mov    %rax,%rdx
    9fa5:	48 c1 ea 10          	shr    $0x10,%rdx
    9fa9:	48 69 d2 28 12 00 00 	imul   $0x1228,%rdx,%rdx
    9fb0:	0f b6 3c 11          	movzbl (%rcx,%rdx,1),%edi
    9fb4:	48 25 ff ff 00 00    	and    $0xffff,%rax
    9fba:	75 13                	jne    9fcf <fwp_args3+0x14f>
    9fbc:	40 80 ff 02          	cmp    $0x2,%dil
    9fc0:	75 0d                	jne    9fcf <fwp_args3+0x14f>
    9fc2:	48 8d 3c 11          	lea    (%rcx,%rdx,1),%rdi
    9fc6:	48 81 c7 28 02 00 00 	add    $0x228,%rdi
    9fcd:	eb 20                	jmp    9fef <fwp_args3+0x16f>
    9fcf:	40 80 ff 01          	cmp    $0x1,%dil
    9fd3:	75 29                	jne    9ffe <fwp_args3+0x17e>
    9fd5:	48 8d 3c 11          	lea    (%rcx,%rdx,1),%rdi
    9fd9:	8b 4c 11 20          	mov    0x20(%rcx,%rdx,1),%ecx
    9fdd:	48 0f af c1          	imul   %rcx,%rax
    9fe1:	48 c1 e8 20          	shr    $0x20,%rax
    9fe5:	48 01 c7             	add    %rax,%rdi
    9fe8:	48 81 c7 28 02 00 00 	add    $0x228,%rdi
    9fef:	0f b6 07             	movzbl (%rdi),%eax
    9ff2:	84 c0                	test   %al,%al
    9ff4:	74 08                	je     9ffe <fwp_args3+0x17e>
    9ff6:	3c fe                	cmp    $0xfe,%al
    9ff8:	73 4c                	jae    a046 <fwp_args3+0x1c6>
    9ffa:	fe c0                	inc    %al
    9ffc:	88 07                	mov    %al,(%rdi)
    9ffe:	b8 02 00 00 00       	mov    $0x2,%eax
    a003:	29 f0                	sub    %esi,%eax
    a005:	89 44 24 1c          	mov    %eax,0x1c(%rsp)
    a009:	48 39 1d 68 6c 00 00 	cmp    %rbx,0x6c68(%rip)        # 10c78 <fwp_cleanups>
    a010:	75 3f                	jne    a051 <fwp_args3+0x1d1>
    a012:	48 8b 44 24 20       	mov    0x20(%rsp),%rax
    a017:	48 89 05 5a 6c 00 00 	mov    %rax,0x6c5a(%rip)        # 10c78 <fwp_cleanups>
    a01e:	48 83 c4 38          	add    $0x38,%rsp
    a022:	5b                   	pop    %rbx
    a023:	41 5e                	pop    %r14
    a025:	41 5f                	pop    %r15
    a027:	5d                   	pop    %rbp
    a028:	c3                   	ret
    a029:	49 89 fe             	mov    %rdi,%r14
    a02c:	48 89 c7             	mov    %rax,%rdi
    a02f:	89 f5                	mov    %esi,%ebp
    a031:	41 89 d7             	mov    %edx,%r15d
    a034:	e8 57 c4 ff ff       	call   6490 <fwp_rc_wide_dup>
    a039:	44 89 fa             	mov    %r15d,%edx
    a03c:	4c 89 f7             	mov    %r14,%rdi
    a03f:	89 ee                	mov    %ebp,%esi
    a041:	e9 23 ff ff ff       	jmp    9f69 <fwp_args3+0xe9>
    a046:	89 f5                	mov    %esi,%ebp
    a048:	e8 43 c4 ff ff       	call   6490 <fwp_rc_wide_dup>
    a04d:	89 ee                	mov    %ebp,%esi
    a04f:	eb ad                	jmp    9ffe <fwp_args3+0x17e>
    a051:	e8 0a 80 ff ff       	call   2060 <abort@plt>
    a056:	66 2e 0f 1f 84 00 00 	cs nopw 0x0(%rax,%rax,1)
    a05d:	00 00 00 

000000000000a060 <fwp_arg_drop3>:
    a060:	55                   	push   %rbp
    a061:	41 56                	push   %r14
    a063:	53                   	push   %rbx
    a064:	85 f6                	test   %esi,%esi
    a066:	75 5b                	jne    a0c3 <fwp_arg_drop3+0x63>
    a068:	85 d2                	test   %edx,%edx
    a06a:	74 57                	je     a0c3 <fwp_arg_drop3+0x63>
    a06c:	48 8b 07             	mov    (%rdi),%rax
    a06f:	48 89 c1             	mov    %rax,%rcx
    a072:	48 2b 0d 5f 61 00 00 	sub    0x615f(%rip),%rcx        # 101d8 <fwp_gc+0x1030>
    a079:	4c 8b 05 80 61 00 00 	mov    0x6180(%rip),%r8        # 10200 <fwp_gc+0x1058>
    a080:	49 c1 e0 10          	shl    $0x10,%r8
    a084:	4c 39 c1             	cmp    %r8,%rcx
    a087:	0f 83 96 00 00 00    	jae    a123 <fwp_arg_drop3+0xc3>
    a08d:	4c 8b 05 8c 61 00 00 	mov    0x618c(%rip),%r8        # 10220 <fwp_gc+0x1078>
    a094:	49 89 c9             	mov    %rcx,%r9
    a097:	49 c1 e9 10          	shr    $0x10,%r9
    a09b:	4d 69 c9 28 12 00 00 	imul   $0x1228,%r9,%r9
    a0a2:	47 0f b6 14 08       	movzbl (%r8,%r9,1),%r10d
    a0a7:	48 81 e1 ff ff 00 00 	and    $0xffff,%rcx
    a0ae:	75 1a                	jne    a0ca <fwp_arg_drop3+0x6a>
    a0b0:	41 80 fa 02          	cmp    $0x2,%r10b
    a0b4:	75 14                	jne    a0ca <fwp_arg_drop3+0x6a>
    a0b6:	4b 8d 0c 08          	lea    (%r8,%r9,1),%rcx
    a0ba:	48 81 c1 28 02 00 00 	add    $0x228,%rcx
    a0c1:	eb 28                	jmp    a0eb <fwp_arg_drop3+0x8b>
    a0c3:	83 fe 01             	cmp    $0x1,%esi
    a0c6:	76 5b                	jbe    a123 <fwp_arg_drop3+0xc3>
    a0c8:	eb 6f                	jmp    a139 <fwp_arg_drop3+0xd9>
    a0ca:	41 80 fa 01          	cmp    $0x1,%r10b
    a0ce:	75 53                	jne    a123 <fwp_arg_drop3+0xc3>
    a0d0:	4f 8d 14 08          	lea    (%r8,%r9,1),%r10
    a0d4:	47 8b 44 08 20       	mov    0x20(%r8,%r9,1),%r8d
    a0d9:	49 0f af c8          	imul   %r8,%rcx
    a0dd:	48 c1 e9 20          	shr    $0x20,%rcx
    a0e1:	4c 01 d1             	add    %r10,%rcx
    a0e4:	48 81 c1 28 02 00 00 	add    $0x228,%rcx
    a0eb:	44 0f b6 01          	movzbl (%rcx),%r8d
    a0ef:	45 85 c0             	test   %r8d,%r8d
    a0f2:	74 2f                	je     a123 <fwp_arg_drop3+0xc3>
    a0f4:	41 83 f8 01          	cmp    $0x1,%r8d
    a0f8:	75 1a                	jne    a114 <fwp_arg_drop3+0xb4>
    a0fa:	48 89 fb             	mov    %rdi,%rbx
    a0fd:	48 89 c7             	mov    %rax,%rdi
    a100:	89 f5                	mov    %esi,%ebp
    a102:	41 89 d6             	mov    %edx,%r14d
    a105:	e8 06 c5 ff ff       	call   6610 <fwp_rc_free_obj>
    a10a:	44 89 f2             	mov    %r14d,%edx
    a10d:	89 ee                	mov    %ebp,%esi
    a10f:	48 89 df             	mov    %rbx,%rdi
    a112:	eb 0f                	jmp    a123 <fwp_arg_drop3+0xc3>
    a114:	41 81 f8 ff 00 00 00 	cmp    $0xff,%r8d
    a11b:	74 21                	je     a13e <fwp_arg_drop3+0xde>
    a11d:	41 fe c8             	dec    %r8b
    a120:	44 88 01             	mov    %r8b,(%rcx)
    a123:	83 f6 01             	xor    $0x1,%esi
    a126:	39 d6                	cmp    %edx,%esi
    a128:	73 0f                	jae    a139 <fwp_arg_drop3+0xd9>
    a12a:	89 f0                	mov    %esi,%eax
    a12c:	48 8b 3c c7          	mov    (%rdi,%rax,8),%rdi
    a130:	5b                   	pop    %rbx
    a131:	41 5e                	pop    %r14
    a133:	5d                   	pop    %rbp
    a134:	e9 b7 bf ff ff       	jmp    60f0 <fwp_closure_drop>
    a139:	5b                   	pop    %rbx
    a13a:	41 5e                	pop    %r14
    a13c:	5d                   	pop    %rbp
    a13d:	c3                   	ret
    a13e:	48 89 fb             	mov    %rdi,%rbx
    a141:	48 89 cf             	mov    %rcx,%rdi
    a144:	89 f5                	mov    %esi,%ebp
    a146:	41 89 d6             	mov    %edx,%r14d
    a149:	e8 b2 c2 ff ff       	call   6400 <fwp_rc_wide_drop>
    a14e:	eb ba                	jmp    a10a <fwp_arg_drop3+0xaa>

000000000000a150 <fwp_entry_release3>:
    a150:	53                   	push   %rbx
    a151:	48 8b 07             	mov    (%rdi),%rax
    a154:	48 8b 07             	mov    (%rdi),%rax
    a157:	48 89 c1             	mov    %rax,%rcx
    a15a:	48 2b 0d 77 60 00 00 	sub    0x6077(%rip),%rcx        # 101d8 <fwp_gc+0x1030>
    a161:	48 8b 15 98 60 00 00 	mov    0x6098(%rip),%rdx        # 10200 <fwp_gc+0x1058>
    a168:	48 c1 e2 10          	shl    $0x10,%rdx
    a16c:	48 39 d1             	cmp    %rdx,%rcx
    a16f:	73 7e                	jae    a1ef <fwp_entry_release3+0x9f>
    a171:	48 8b 15 a8 60 00 00 	mov    0x60a8(%rip),%rdx        # 10220 <fwp_gc+0x1078>
    a178:	48 89 ce             	mov    %rcx,%rsi
    a17b:	48 c1 ee 10          	shr    $0x10,%rsi
    a17f:	48 69 f6 28 12 00 00 	imul   $0x1228,%rsi,%rsi
    a186:	44 0f b6 04 32       	movzbl (%rdx,%rsi,1),%r8d
    a18b:	48 81 e1 ff ff 00 00 	and    $0xffff,%rcx
    a192:	75 13                	jne    a1a7 <fwp_entry_release3+0x57>
    a194:	41 80 f8 02          	cmp    $0x2,%r8b
    a198:	75 0d                	jne    a1a7 <fwp_entry_release3+0x57>
    a19a:	48 8d 0c 32          	lea    (%rdx,%rsi,1),%rcx
    a19e:	48 81 c1 28 02 00 00 	add    $0x228,%rcx
    a1a5:	eb 20                	jmp    a1c7 <fwp_entry_release3+0x77>
    a1a7:	41 80 f8 01          	cmp    $0x1,%r8b
    a1ab:	75 42                	jne    a1ef <fwp_entry_release3+0x9f>
    a1ad:	4c 8d 04 32          	lea    (%rdx,%rsi,1),%r8
    a1b1:	8b 54 32 20          	mov    0x20(%rdx,%rsi,1),%edx
    a1b5:	48 0f af ca          	imul   %rdx,%rcx
    a1b9:	48 c1 e9 20          	shr    $0x20,%rcx
    a1bd:	4c 01 c1             	add    %r8,%rcx
    a1c0:	48 81 c1 28 02 00 00 	add    $0x228,%rcx
    a1c7:	0f b6 11             	movzbl (%rcx),%edx
    a1ca:	85 d2                	test   %edx,%edx
    a1cc:	74 21                	je     a1ef <fwp_entry_release3+0x9f>
    a1ce:	83 fa 01             	cmp    $0x1,%edx
    a1d1:	75 10                	jne    a1e3 <fwp_entry_release3+0x93>
    a1d3:	48 89 fb             	mov    %rdi,%rbx
    a1d6:	48 89 c7             	mov    %rax,%rdi
    a1d9:	e8 32 c4 ff ff       	call   6610 <fwp_rc_free_obj>
    a1de:	48 89 df             	mov    %rbx,%rdi
    a1e1:	eb 0c                	jmp    a1ef <fwp_entry_release3+0x9f>
    a1e3:	81 fa ff 00 00 00    	cmp    $0xff,%edx
    a1e9:	74 12                	je     a1fd <fwp_entry_release3+0xad>
    a1eb:	fe ca                	dec    %dl
    a1ed:	88 11                	mov    %dl,(%rcx)
    a1ef:	48 8b 47 08          	mov    0x8(%rdi),%rax
    a1f3:	48 8b 7f 08          	mov    0x8(%rdi),%rdi
    a1f7:	5b                   	pop    %rbx
    a1f8:	e9 f3 be ff ff       	jmp    60f0 <fwp_closure_drop>
    a1fd:	48 89 fb             	mov    %rdi,%rbx
    a200:	48 89 cf             	mov    %rcx,%rdi
    a203:	e8 f8 c1 ff ff       	call   6400 <fwp_rc_wide_drop>
    a208:	eb d4                	jmp    a1de <fwp_entry_release3+0x8e>
    a20a:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)

000000000000a210 <f4>:
    a210:	55                   	push   %rbp
    a211:	41 57                	push   %r15
    a213:	41 56                	push   %r14
    a215:	41 55                	push   %r13
    a217:	41 54                	push   %r12
    a219:	53                   	push   %rbx
    a21a:	48 81 ec 88 00 01 00 	sub    $0x10088,%rsp
    a221:	48 89 fb             	mov    %rdi,%rbx
    a224:	e8 d7 04 00 00       	call   a700 <fwp_file_dup>
    a229:	48 89 5c 24 48       	mov    %rbx,0x48(%rsp)
    a22e:	48 8d 05 ab d5 ff ff 	lea    -0x2a55(%rip),%rax        # 77e0 <fwp_file_drop>
    a235:	48 89 44 24 50       	mov    %rax,0x50(%rsp)
    a23a:	48 8b 05 37 6a 00 00 	mov    0x6a37(%rip),%rax        # 10c78 <fwp_cleanups>
    a241:	48 89 44 24 58       	mov    %rax,0x58(%rsp)
    a246:	48 8d 2d f3 c7 ff ff 	lea    -0x380d(%rip),%rbp        # 6a40 <fwp_value_release>
    a24d:	48 89 6c 24 60       	mov    %rbp,0x60(%rsp)
    a252:	48 8d 44 24 48       	lea    0x48(%rsp),%rax
    a257:	48 89 44 24 68       	mov    %rax,0x68(%rsp)
    a25c:	0f 57 c0             	xorps  %xmm0,%xmm0
    a25f:	0f 29 04 24          	movaps %xmm0,(%rsp)
    a263:	48 c7 44 24 10 00 00 	movq   $0x0,0x10(%rsp)
    a26a:	00 00 
    a26c:	4c 8d 64 24 58       	lea    0x58(%rsp),%r12
    a271:	4c 89 64 24 30       	mov    %r12,0x30(%rsp)
    a276:	48 8d 05 f3 04 00 00 	lea    0x4f3(%rip),%rax        # a770 <fwp_file_buffer_cleanup>
    a27d:	48 89 44 24 38       	mov    %rax,0x38(%rsp)
    a282:	48 89 e0             	mov    %rsp,%rax
    a285:	48 89 44 24 40       	mov    %rax,0x40(%rsp)
    a28a:	4c 8d 6c 24 30       	lea    0x30(%rsp),%r13
    a28f:	4c 89 2d e2 69 00 00 	mov    %r13,0x69e2(%rip)        # 10c78 <fwp_cleanups>
    a296:	48 8b 0b             	mov    (%rbx),%rcx
    a299:	48 85 c9             	test   %rcx,%rcx
    a29c:	0f 84 de 01 00 00    	je     a480 <f4+0x270>
    a2a2:	48 8d bc 24 80 00 00 	lea    0x80(%rsp),%rdi
    a2a9:	00 
    a2aa:	be 01 00 00 00       	mov    $0x1,%esi
    a2af:	ba 00 00 01 00       	mov    $0x10000,%edx
    a2b4:	e8 07 7e ff ff       	call   20c0 <fread@plt>
    a2b9:	48 85 c0             	test   %rax,%rax
    a2bc:	74 3a                	je     a2f8 <f4+0xe8>
    a2be:	49 89 e6             	mov    %rsp,%r14
    a2c1:	4c 8d bc 24 80 00 00 	lea    0x80(%rsp),%r15
    a2c8:	00 
    a2c9:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)
    a2d0:	4c 89 f7             	mov    %r14,%rdi
    a2d3:	4c 89 fe             	mov    %r15,%rsi
    a2d6:	48 89 c2             	mov    %rax,%rdx
    a2d9:	e8 92 ea ff ff       	call   8d70 <buf_put>
    a2de:	48 8b 0b             	mov    (%rbx),%rcx
    a2e1:	be 01 00 00 00       	mov    $0x1,%esi
    a2e6:	ba 00 00 01 00       	mov    $0x10000,%edx
    a2eb:	4c 89 ff             	mov    %r15,%rdi
    a2ee:	e8 cd 7d ff ff       	call   20c0 <fread@plt>
    a2f3:	48 85 c0             	test   %rax,%rax
    a2f6:	75 d8                	jne    a2d0 <f4+0xc0>
    a2f8:	48 8b 3b             	mov    (%rbx),%rdi
    a2fb:	e8 a0 7d ff ff       	call   20a0 <ferror@plt>
    a300:	85 c0                	test   %eax,%eax
    a302:	0f 85 b0 03 00 00    	jne    a6b8 <f4+0x4a8>
    a308:	48 8b 3c 24          	mov    (%rsp),%rdi
    a30c:	48 8b 44 24 08       	mov    0x8(%rsp),%rax
    a311:	48 85 ff             	test   %rdi,%rdi
    a314:	48 8d 0d 56 23 00 00 	lea    0x2356(%rip),%rcx        # c671 <fwp_segv.msg+0x431>
    a31b:	48 0f 45 cf          	cmovne %rdi,%rcx
    a31f:	48 85 c0             	test   %rax,%rax
    a322:	0f 84 58 01 00 00    	je     a480 <f4+0x270>
    a328:	31 d2                	xor    %edx,%edx
    a32a:	eb 10                	jmp    a33c <f4+0x12c>
    a32c:	0f 1f 40 00          	nopl   0x0(%rax)
    a330:	48 ff c2             	inc    %rdx
    a333:	48 39 c2             	cmp    %rax,%rdx
    a336:	0f 83 44 01 00 00    	jae    a480 <f4+0x270>
    a33c:	44 0f b6 14 11       	movzbl (%rcx,%rdx,1),%r10d
    a341:	45 84 d2             	test   %r10b,%r10b
    a344:	79 ea                	jns    a330 <f4+0x120>
    a346:	41 8d 72 3e          	lea    0x3e(%r10),%esi
    a34a:	40 80 fe 1e          	cmp    $0x1e,%sil
    a34e:	73 13                	jae    a363 <f4+0x153>
    a350:	be 80 00 00 00       	mov    $0x80,%esi
    a355:	41 b9 01 00 00 00    	mov    $0x1,%r9d
    a35b:	41 b8 1f 00 00 00    	mov    $0x1f,%r8d
    a361:	eb 3f                	jmp    a3a2 <f4+0x192>
    a363:	44 89 d6             	mov    %r10d,%esi
    a366:	40 80 e6 f0          	and    $0xf0,%sil
    a36a:	40 80 fe e0          	cmp    $0xe0,%sil
    a36e:	75 13                	jne    a383 <f4+0x173>
    a370:	be 00 08 00 00       	mov    $0x800,%esi
    a375:	41 b9 02 00 00 00    	mov    $0x2,%r9d
    a37b:	41 b8 0f 00 00 00    	mov    $0xf,%r8d
    a381:	eb 1f                	jmp    a3a2 <f4+0x192>
    a383:	41 8d 72 10          	lea    0x10(%r10),%esi
    a387:	40 80 fe 04          	cmp    $0x4,%sil
    a38b:	0f 87 f2 02 00 00    	ja     a683 <f4+0x473>
    a391:	be 00 00 01 00       	mov    $0x10000,%esi
    a396:	41 b9 03 00 00 00    	mov    $0x3,%r9d
    a39c:	41 b8 07 00 00 00    	mov    $0x7,%r8d
    a3a2:	45 89 c9             	mov    %r9d,%r9d
    a3a5:	4e 8d 1c 0a          	lea    (%rdx,%r9,1),%r11
    a3a9:	49 39 c3             	cmp    %rax,%r11
    a3ac:	0f 83 d1 02 00 00    	jae    a683 <f4+0x473>
    a3b2:	44 0f b6 5c 11 01    	movzbl 0x1(%rcx,%rdx,1),%r11d
    a3b8:	45 89 de             	mov    %r11d,%r14d
    a3bb:	41 83 e6 c0          	and    $0xffffffc0,%r14d
    a3bf:	41 81 fe 80 00 00 00 	cmp    $0x80,%r14d
    a3c6:	0f 85 b7 02 00 00    	jne    a683 <f4+0x473>
    a3cc:	45 21 d0             	and    %r10d,%r8d
    a3cf:	45 8d 51 01          	lea    0x1(%r9),%r10d
    a3d3:	45 89 c6             	mov    %r8d,%r14d
    a3d6:	41 c1 e6 06          	shl    $0x6,%r14d
    a3da:	41 83 e3 3f          	and    $0x3f,%r11d
    a3de:	45 09 f3             	or     %r14d,%r11d
    a3e1:	41 83 fa 02          	cmp    $0x2,%r10d
    a3e5:	75 05                	jne    a3ec <f4+0x1dc>
    a3e7:	45 89 da             	mov    %r11d,%r10d
    a3ea:	eb 5e                	jmp    a44a <f4+0x23a>
    a3ec:	44 0f b6 44 11 02    	movzbl 0x2(%rcx,%rdx,1),%r8d
    a3f2:	45 89 c6             	mov    %r8d,%r14d
    a3f5:	41 83 e6 c0          	and    $0xffffffc0,%r14d
    a3f9:	41 81 fe 80 00 00 00 	cmp    $0x80,%r14d
    a400:	0f 85 7d 02 00 00    	jne    a683 <f4+0x473>
    a406:	45 89 de             	mov    %r11d,%r14d
    a409:	41 c1 e6 06          	shl    $0x6,%r14d
    a40d:	41 83 e0 3f          	and    $0x3f,%r8d
    a411:	45 09 f0             	or     %r14d,%r8d
    a414:	41 83 fa 03          	cmp    $0x3,%r10d
    a418:	75 08                	jne    a422 <f4+0x212>
    a41a:	45 89 c2             	mov    %r8d,%r10d
    a41d:	45 89 d8             	mov    %r11d,%r8d
    a420:	eb 28                	jmp    a44a <f4+0x23a>
    a422:	44 0f b6 54 11 03    	movzbl 0x3(%rcx,%rdx,1),%r10d
    a428:	45 89 d3             	mov    %r10d,%r11d
    a42b:	41 83 e3 c0          	and    $0xffffffc0,%r11d
    a42f:	41 81 fb 80 00 00 00 	cmp    $0x80,%r11d
    a436:	0f 85 47 02 00 00    	jne    a683 <f4+0x473>
    a43c:	45 89 c3             	mov    %r8d,%r11d
    a43f:	41 c1 e3 06          	shl    $0x6,%r11d
    a443:	41 83 e2 3f          	and    $0x3f,%r10d
    a447:	45 09 da             	or     %r11d,%r10d
    a44a:	41 83 e0 e0          	and    $0xffffffe0,%r8d
    a44e:	41 81 f8 60 03 00 00 	cmp    $0x360,%r8d
    a455:	0f 84 28 02 00 00    	je     a683 <f4+0x473>
    a45b:	41 39 f2             	cmp    %esi,%r10d
    a45e:	0f 82 1f 02 00 00    	jb     a683 <f4+0x473>
    a464:	41 81 fa ff ff 10 00 	cmp    $0x10ffff,%r10d
    a46b:	0f 87 12 02 00 00    	ja     a683 <f4+0x473>
    a471:	4c 01 ca             	add    %r9,%rdx
    a474:	48 ff c2             	inc    %rdx
    a477:	48 39 c2             	cmp    %rax,%rdx
    a47a:	0f 82 bc fe ff ff    	jb     a33c <f4+0x12c>
    a480:	48 89 e7             	mov    %rsp,%rdi
    a483:	e8 08 03 00 00       	call   a790 <buf_to_str>
    a488:	48 89 c1             	mov    %rax,%rcx
    a48b:	48 2b 0d 46 5d 00 00 	sub    0x5d46(%rip),%rcx        # 101d8 <fwp_gc+0x1030>
    a492:	48 8b 15 67 5d 00 00 	mov    0x5d67(%rip),%rdx        # 10200 <fwp_gc+0x1058>
    a499:	48 c1 e2 10          	shl    $0x10,%rdx
    a49d:	48 39 d1             	cmp    %rdx,%rcx
    a4a0:	73 76                	jae    a518 <f4+0x308>
    a4a2:	48 8b 15 77 5d 00 00 	mov    0x5d77(%rip),%rdx        # 10220 <fwp_gc+0x1078>
    a4a9:	48 89 ce             	mov    %rcx,%rsi
    a4ac:	48 c1 ee 10          	shr    $0x10,%rsi
    a4b0:	48 69 f6 28 12 00 00 	imul   $0x1228,%rsi,%rsi
    a4b7:	0f b6 3c 32          	movzbl (%rdx,%rsi,1),%edi
    a4bb:	48 81 e1 ff ff 00 00 	and    $0xffff,%rcx
    a4c2:	75 1d                	jne    a4e1 <f4+0x2d1>
    a4c4:	40 80 ff 02          	cmp    $0x2,%dil
    a4c8:	75 17                	jne    a4e1 <f4+0x2d1>
    a4ca:	4c 8d 34 32          	lea    (%rdx,%rsi,1),%r14
    a4ce:	49 81 c6 28 02 00 00 	add    $0x228,%r14
    a4d5:	41 80 3e ff          	cmpb   $0xff,(%r14)
    a4d9:	74 2d                	je     a508 <f4+0x2f8>
    a4db:	41 c6 06 01          	movb   $0x1,(%r14)
    a4df:	eb 37                	jmp    a518 <f4+0x308>
    a4e1:	40 80 ff 01          	cmp    $0x1,%dil
    a4e5:	75 31                	jne    a518 <f4+0x308>
    a4e7:	48 8d 3c 32          	lea    (%rdx,%rsi,1),%rdi
    a4eb:	8b 54 32 20          	mov    0x20(%rdx,%rsi,1),%edx
    a4ef:	48 0f af ca          	imul   %rdx,%rcx
    a4f3:	48 c1 e9 20          	shr    $0x20,%rcx
    a4f7:	4c 8d 34 39          	lea    (%rcx,%rdi,1),%r14
    a4fb:	49 81 c6 28 02 00 00 	add    $0x228,%r14
    a502:	41 80 3e ff          	cmpb   $0xff,(%r14)
    a506:	75 d3                	jne    a4db <f4+0x2cb>
    a508:	4c 89 f7             	mov    %r14,%rdi
    a50b:	49 89 c7             	mov    %rax,%r15
    a50e:	e8 cd 93 ff ff       	call   38e0 <fwp_rc_forget_slot>
    a513:	4c 89 f8             	mov    %r15,%rax
    a516:	eb c3                	jmp    a4db <f4+0x2cb>
    a518:	48 c7 04 24 00 00 00 	movq   $0x0,(%rsp)
    a51f:	00 
    a520:	48 89 44 24 20       	mov    %rax,0x20(%rsp)
    a525:	48 8d 0d 54 03 00 00 	lea    0x354(%rip),%rcx        # a880 <fwp_file_text_drop>
    a52c:	48 89 4c 24 28       	mov    %rcx,0x28(%rsp)
    a531:	48 8b 0d 40 67 00 00 	mov    0x6740(%rip),%rcx        # 10c78 <fwp_cleanups>
    a538:	48 89 8c 24 80 00 00 	mov    %rcx,0x80(%rsp)
    a53f:	00 
    a540:	48 89 ac 24 88 00 00 	mov    %rbp,0x88(%rsp)
    a547:	00 
    a548:	48 8d 4c 24 20       	lea    0x20(%rsp),%rcx
    a54d:	48 89 8c 24 90 00 00 	mov    %rcx,0x90(%rsp)
    a554:	00 
    a555:	4c 8d bc 24 80 00 00 	lea    0x80(%rsp),%r15
    a55c:	00 
    a55d:	4c 89 3d 14 67 00 00 	mov    %r15,0x6714(%rip)        # 10c78 <fwp_cleanups>
    a564:	48 89 44 24 70       	mov    %rax,0x70(%rsp)
    a569:	48 89 5c 24 78       	mov    %rbx,0x78(%rsp)
    a56e:	48 8d 54 24 70       	lea    0x70(%rsp),%rdx
    a573:	31 ff                	xor    %edi,%edi
    a575:	be 02 00 00 00       	mov    $0x2,%esi
    a57a:	e8 51 9d ff ff       	call   42d0 <fwp_data>
    a57f:	48 89 c1             	mov    %rax,%rcx
    a582:	48 2b 0d 4f 5c 00 00 	sub    0x5c4f(%rip),%rcx        # 101d8 <fwp_gc+0x1030>
    a589:	48 8b 15 70 5c 00 00 	mov    0x5c70(%rip),%rdx        # 10200 <fwp_gc+0x1058>
    a590:	48 c1 e2 10          	shl    $0x10,%rdx
    a594:	48 39 d1             	cmp    %rdx,%rcx
    a597:	73 76                	jae    a60f <f4+0x3ff>
    a599:	48 8b 15 80 5c 00 00 	mov    0x5c80(%rip),%rdx        # 10220 <fwp_gc+0x1078>
    a5a0:	48 89 ce             	mov    %rcx,%rsi
    a5a3:	48 c1 ee 10          	shr    $0x10,%rsi
    a5a7:	48 69 f6 28 12 00 00 	imul   $0x1228,%rsi,%rsi
    a5ae:	0f b6 3c 32          	movzbl (%rdx,%rsi,1),%edi
    a5b2:	48 81 e1 ff ff 00 00 	and    $0xffff,%rcx
    a5b9:	75 1d                	jne    a5d8 <f4+0x3c8>
    a5bb:	40 80 ff 02          	cmp    $0x2,%dil
    a5bf:	75 17                	jne    a5d8 <f4+0x3c8>
    a5c1:	4c 8d 34 32          	lea    (%rdx,%rsi,1),%r14
    a5c5:	49 81 c6 28 02 00 00 	add    $0x228,%r14
    a5cc:	41 80 3e ff          	cmpb   $0xff,(%r14)
    a5d0:	74 2d                	je     a5ff <f4+0x3ef>
    a5d2:	41 c6 06 01          	movb   $0x1,(%r14)
    a5d6:	eb 37                	jmp    a60f <f4+0x3ff>
    a5d8:	40 80 ff 01          	cmp    $0x1,%dil
    a5dc:	75 31                	jne    a60f <f4+0x3ff>
    a5de:	48 8d 3c 32          	lea    (%rdx,%rsi,1),%rdi
    a5e2:	8b 54 32 20          	mov    0x20(%rdx,%rsi,1),%edx
    a5e6:	48 0f af ca          	imul   %rdx,%rcx
    a5ea:	48 c1 e9 20          	shr    $0x20,%rcx
    a5ee:	4c 8d 34 39          	lea    (%rcx,%rdi,1),%r14
    a5f2:	49 81 c6 28 02 00 00 	add    $0x228,%r14
    a5f9:	41 80 3e ff          	cmpb   $0xff,(%r14)
    a5fd:	75 d3                	jne    a5d2 <f4+0x3c2>
    a5ff:	4c 89 f7             	mov    %r14,%rdi
    a602:	48 89 c5             	mov    %rax,%rbp
    a605:	e8 d6 92 ff ff       	call   38e0 <fwp_rc_forget_slot>
    a60a:	48 89 e8             	mov    %rbp,%rax
    a60d:	eb c3                	jmp    a5d2 <f4+0x3c2>
    a60f:	48 83 7c 24 28 00    	cmpq   $0x0,0x28(%rsp)
    a615:	48 8b 0d 5c 66 00 00 	mov    0x665c(%rip),%rcx        # 10c78 <fwp_cleanups>
    a61c:	74 18                	je     a636 <f4+0x426>
    a61e:	4c 39 f9             	cmp    %r15,%rcx
    a621:	0f 85 d4 00 00 00    	jne    a6fb <f4+0x4eb>
    a627:	48 8b 8c 24 80 00 00 	mov    0x80(%rsp),%rcx
    a62e:	00 
    a62f:	48 89 0d 42 66 00 00 	mov    %rcx,0x6642(%rip)        # 10c78 <fwp_cleanups>
    a636:	48 c7 44 24 20 00 00 	movq   $0x0,0x20(%rsp)
    a63d:	00 00 
    a63f:	4c 39 e9             	cmp    %r13,%rcx
    a642:	0f 85 b3 00 00 00    	jne    a6fb <f4+0x4eb>
    a648:	48 8b 4c 24 30       	mov    0x30(%rsp),%rcx
    a64d:	48 89 0d 24 66 00 00 	mov    %rcx,0x6624(%rip)        # 10c78 <fwp_cleanups>
    a654:	48 83 7c 24 50 00    	cmpq   $0x0,0x50(%rsp)
    a65a:	74 15                	je     a671 <f4+0x461>
    a65c:	4c 39 e1             	cmp    %r12,%rcx
    a65f:	0f 85 96 00 00 00    	jne    a6fb <f4+0x4eb>
    a665:	48 8b 4c 24 58       	mov    0x58(%rsp),%rcx
    a66a:	48 89 0d 07 66 00 00 	mov    %rcx,0x6607(%rip)        # 10c78 <fwp_cleanups>
    a671:	48 81 c4 88 00 01 00 	add    $0x10088,%rsp
    a678:	5b                   	pop    %rbx
    a679:	41 5c                	pop    %r12
    a67b:	41 5d                	pop    %r13
    a67d:	41 5e                	pop    %r14
    a67f:	41 5f                	pop    %r15
    a681:	5d                   	pop    %rbp
    a682:	c3                   	ret
    a683:	4c 39 2d ee 65 00 00 	cmp    %r13,0x65ee(%rip)        # 10c78 <fwp_cleanups>
    a68a:	75 6f                	jne    a6fb <f4+0x4eb>
    a68c:	48 8b 44 24 30       	mov    0x30(%rsp),%rax
    a691:	48 89 05 e0 65 00 00 	mov    %rax,0x65e0(%rip)        # 10c78 <fwp_cleanups>
    a698:	e8 b3 79 ff ff       	call   2050 <free@plt>
    a69d:	48 c7 04 24 00 00 00 	movq   $0x0,(%rsp)
    a6a4:	00 
    a6a5:	48 8d 3d 6b 1f 00 00 	lea    0x1f6b(%rip),%rdi        # c617 <fwp_segv.msg+0x3d7>
    a6ac:	48 8d 35 69 1f 00 00 	lea    0x1f69(%rip),%rsi        # c61c <fwp_segv.msg+0x3dc>
    a6b3:	e8 68 cf ff ff       	call   7620 <fwp_io_error>
    a6b8:	4c 39 2d b9 65 00 00 	cmp    %r13,0x65b9(%rip)        # 10c78 <fwp_cleanups>
    a6bf:	75 3a                	jne    a6fb <f4+0x4eb>
    a6c1:	e8 aa 79 ff ff       	call   2070 <__errno_location@plt>
    a6c6:	8b 18                	mov    (%rax),%ebx
    a6c8:	48 8b 44 24 30       	mov    0x30(%rsp),%rax
    a6cd:	48 89 05 a4 65 00 00 	mov    %rax,0x65a4(%rip)        # 10c78 <fwp_cleanups>
    a6d4:	48 8b 3c 24          	mov    (%rsp),%rdi
    a6d8:	e8 73 79 ff ff       	call   2050 <free@plt>
    a6dd:	48 c7 04 24 00 00 00 	movq   $0x0,(%rsp)
    a6e4:	00 
    a6e5:	89 df                	mov    %ebx,%edi
    a6e7:	e8 34 7c ff ff       	call   2320 <strerror@plt>
    a6ec:	48 8d 3d 24 1f 00 00 	lea    0x1f24(%rip),%rdi        # c617 <fwp_segv.msg+0x3d7>
    a6f3:	48 89 c6             	mov    %rax,%rsi
    a6f6:	e8 25 cf ff ff       	call   7620 <fwp_io_error>
    a6fb:	e8 60 79 ff ff       	call   2060 <abort@plt>

000000000000a700 <fwp_file_dup>:
    a700:	50                   	push   %rax
    a701:	48 85 ff             	test   %rdi,%rdi
    a704:	74 16                	je     a71c <fwp_file_dup+0x1c>
    a706:	48 8b 47 08          	mov    0x8(%rdi),%rax
    a70a:	48 83 f8 ff          	cmp    $0xffffffffffffffff,%rax
    a70e:	74 0e                	je     a71e <fwp_file_dup+0x1e>
    a710:	48 85 c0             	test   %rax,%rax
    a713:	74 28                	je     a73d <fwp_file_dup+0x3d>
    a715:	48 ff c0             	inc    %rax
    a718:	48 89 47 08          	mov    %rax,0x8(%rdi)
    a71c:	58                   	pop    %rax
    a71d:	c3                   	ret
    a71e:	e8 8d 91 ff ff       	call   38b0 <fwp_flush>
    a723:	48 8b 05 b6 48 00 00 	mov    0x48b6(%rip),%rax        # efe0 <stderr@GLIBC_2.2.5>
    a72a:	48 8b 38             	mov    (%rax),%rdi
    a72d:	48 8d 35 00 1c 00 00 	lea    0x1c00(%rip),%rsi        # c334 <fwp_segv.msg+0xf4>
    a734:	48 8d 15 b5 1d 00 00 	lea    0x1db5(%rip),%rdx        # c4f0 <fwp_segv.msg+0x2b0>
    a73b:	eb 1d                	jmp    a75a <fwp_file_dup+0x5a>
    a73d:	e8 6e 91 ff ff       	call   38b0 <fwp_flush>
    a742:	48 8b 05 97 48 00 00 	mov    0x4897(%rip),%rax        # efe0 <stderr@GLIBC_2.2.5>
    a749:	48 8b 38             	mov    (%rax),%rdi
    a74c:	48 8d 35 e1 1b 00 00 	lea    0x1be1(%rip),%rsi        # c334 <fwp_segv.msg+0xf4>
    a753:	48 8d 15 9a 1e 00 00 	lea    0x1e9a(%rip),%rdx        # c5f4 <fwp_segv.msg+0x3b4>
    a75a:	31 c0                	xor    %eax,%eax
    a75c:	e8 7f 7a ff ff       	call   21e0 <fprintf@plt>
    a761:	bf 65 00 00 00       	mov    $0x65,%edi
    a766:	e8 65 7b ff ff       	call   22d0 <exit@plt>
    a76b:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)

000000000000a770 <fwp_file_buffer_cleanup>:
    a770:	53                   	push   %rbx
    a771:	48 89 fb             	mov    %rdi,%rbx
    a774:	48 8b 3f             	mov    (%rdi),%rdi
    a777:	e8 d4 78 ff ff       	call   2050 <free@plt>
    a77c:	48 c7 03 00 00 00 00 	movq   $0x0,(%rbx)
    a783:	5b                   	pop    %rbx
    a784:	c3                   	ret
    a785:	66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
    a78c:	00 00 00 00 

000000000000a790 <buf_to_str>:
    a790:	41 57                	push   %r15
    a792:	41 56                	push   %r14
    a794:	41 55                	push   %r13
    a796:	41 54                	push   %r12
    a798:	53                   	push   %rbx
    a799:	48 89 fb             	mov    %rdi,%rbx
    a79c:	4c 8b 2f             	mov    (%rdi),%r13
    a79f:	4c 8b 77 08          	mov    0x8(%rdi),%r14
    a7a3:	49 8d 56 09          	lea    0x9(%r14),%rdx
    a7a7:	48 81 fa 00 40 00 00 	cmp    $0x4000,%rdx
    a7ae:	77 61                	ja     a811 <buf_to_str+0x81>
    a7b0:	49 8d 4e 18          	lea    0x18(%r14),%rcx
    a7b4:	48 c1 e9 04          	shr    $0x4,%rcx
    a7b8:	48 8d 05 e9 49 00 00 	lea    0x49e9(%rip),%rax        # f1a8 <fwp_gc>
    a7bf:	0f b6 b4 01 e8 0b 00 	movzbl 0xbe8(%rcx,%rax,1),%esi
    a7c6:	00 
    a7c7:	8b 8c b0 48 0b 00 00 	mov    0xb48(%rax,%rsi,4),%ecx
    a7ce:	48 29 0d d3 49 00 00 	sub    %rcx,0x49d3(%rip)        # f1a8 <fwp_gc>
    a7d5:	78 3a                	js     a811 <buf_to_str+0x81>
    a7d7:	48 8d 34 76          	lea    (%rsi,%rsi,2),%rsi
    a7db:	48 8d 3c f0          	lea    (%rax,%rsi,8),%rdi
    a7df:	48 81 c7 c8 03 00 00 	add    $0x3c8,%rdi
    a7e6:	4c 8b 3f             	mov    (%rdi),%r15
    a7e9:	4d 85 ff             	test   %r15,%r15
    a7ec:	74 0b                	je     a7f9 <buf_to_str+0x69>
    a7ee:	49 8b 07             	mov    (%r15),%rax
    a7f1:	48 f7 d0             	not    %rax
    a7f4:	48 89 07             	mov    %rax,(%rdi)
    a7f7:	eb 3a                	jmp    a833 <buf_to_str+0xa3>
    a7f9:	4c 8b bc f0 d0 03 00 	mov    0x3d0(%rax,%rsi,8),%r15
    a800:	00 
    a801:	48 8b bc f0 d8 03 00 	mov    0x3d8(%rax,%rsi,8),%rdi
    a808:	00 
    a809:	4c 29 ff             	sub    %r15,%rdi
    a80c:	48 39 cf             	cmp    %rcx,%rdi
    a80f:	73 12                	jae    a823 <buf_to_str+0x93>
    a811:	48 89 d7             	mov    %rdx,%rdi
    a814:	be 01 00 00 00       	mov    $0x1,%esi
    a819:	e8 52 ad ff ff       	call   5570 <fwp_gc_alloc_slow>
    a81e:	49 89 c7             	mov    %rax,%r15
    a821:	eb 1a                	jmp    a83d <buf_to_str+0xad>
    a823:	48 8d 04 f0          	lea    (%rax,%rsi,8),%rax
    a827:	48 05 d0 03 00 00    	add    $0x3d0,%rax
    a82d:	4c 01 f9             	add    %r15,%rcx
    a830:	48 89 08             	mov    %rcx,(%rax)
    a833:	4c 89 ff             	mov    %r15,%rdi
    a836:	31 f6                	xor    %esi,%esi
    a838:	e8 23 79 ff ff       	call   2160 <memset@plt>
    a83d:	4d 85 ed             	test   %r13,%r13
    a840:	4c 8d 25 2a 1e 00 00 	lea    0x1e2a(%rip),%r12        # c671 <fwp_segv.msg+0x431>
    a847:	4d 0f 45 e5          	cmovne %r13,%r12
    a84b:	4d 89 37             	mov    %r14,(%r15)
    a84e:	49 8d 7f 08          	lea    0x8(%r15),%rdi
    a852:	4c 89 e6             	mov    %r12,%rsi
    a855:	4c 89 f2             	mov    %r14,%rdx
    a858:	e8 b3 79 ff ff       	call   2210 <memcpy@plt>
    a85d:	43 c6 44 37 08 00    	movb   $0x0,0x8(%r15,%r14,1)
    a863:	48 8b 3b             	mov    (%rbx),%rdi
    a866:	e8 e5 77 ff ff       	call   2050 <free@plt>
    a86b:	4c 89 f8             	mov    %r15,%rax
    a86e:	5b                   	pop    %rbx
    a86f:	41 5c                	pop    %r12
    a871:	41 5d                	pop    %r13
    a873:	41 5e                	pop    %r14
    a875:	41 5f                	pop    %r15
    a877:	c3                   	ret
    a878:	0f 1f 84 00 00 00 00 	nopl   0x0(%rax,%rax,1)
    a87f:	00 

000000000000a880 <fwp_file_text_drop>:
    a880:	e9 8b bd ff ff       	jmp    6610 <fwp_rc_free_obj>
    a885:	66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
    a88c:	00 00 00 00 

000000000000a890 <fwp_owned_entry4>:
    a890:	41 57                	push   %r15
    a892:	41 56                	push   %r14
    a894:	53                   	push   %rbx
    a895:	48 83 ec 20          	sub    $0x20,%rsp
    a899:	48 89 fb             	mov    %rdi,%rbx
    a89c:	48 8b 05 d5 63 00 00 	mov    0x63d5(%rip),%rax        # 10c78 <fwp_cleanups>
    a8a3:	48 89 44 24 08       	mov    %rax,0x8(%rsp)
    a8a8:	48 8d 05 e1 00 00 00 	lea    0xe1(%rip),%rax        # a990 <fwp_entry_release4>
    a8af:	48 89 44 24 10       	mov    %rax,0x10(%rsp)
    a8b4:	48 89 7c 24 18       	mov    %rdi,0x18(%rsp)
    a8b9:	4c 8d 7c 24 08       	lea    0x8(%rsp),%r15
    a8be:	4c 89 3d b3 63 00 00 	mov    %r15,0x63b3(%rip)        # 10c78 <fwp_cleanups>
    a8c5:	48 8b 3f             	mov    (%rdi),%rdi
    a8c8:	e8 43 f9 ff ff       	call   a210 <f4>
    a8cd:	4c 39 3d a4 63 00 00 	cmp    %r15,0x63a4(%rip)        # 10c78 <fwp_cleanups>
    a8d4:	75 27                	jne    a8fd <fwp_owned_entry4+0x6d>
    a8d6:	49 89 c6             	mov    %rax,%r14
    a8d9:	48 8b 44 24 08       	mov    0x8(%rsp),%rax
    a8de:	48 89 05 93 63 00 00 	mov    %rax,0x6393(%rip)        # 10c78 <fwp_cleanups>
    a8e5:	48 8b 03             	mov    (%rbx),%rax
    a8e8:	48 8b 3b             	mov    (%rbx),%rdi
    a8eb:	e8 f0 ce ff ff       	call   77e0 <fwp_file_drop>
    a8f0:	4c 89 f0             	mov    %r14,%rax
    a8f3:	48 83 c4 20          	add    $0x20,%rsp
    a8f7:	5b                   	pop    %rbx
    a8f8:	41 5e                	pop    %r14
    a8fa:	41 5f                	pop    %r15
    a8fc:	c3                   	ret
    a8fd:	e8 5e 77 ff ff       	call   2060 <abort@plt>
    a902:	66 66 66 66 66 2e 0f 	data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    a909:	1f 84 00 00 00 00 00 

000000000000a910 <fwp_caps4>:
    a910:	8b 47 04             	mov    0x4(%rdi),%eax
    a913:	85 f6                	test   %esi,%esi
    a915:	74 0d                	je     a924 <fwp_caps4+0x14>
    a917:	85 c0                	test   %eax,%eax
    a919:	74 2a                	je     a945 <fwp_caps4+0x35>
    a91b:	48 8b 7f 08          	mov    0x8(%rdi),%rdi
    a91f:	e9 dc fd ff ff       	jmp    a700 <fwp_file_dup>
    a924:	85 c0                	test   %eax,%eax
    a926:	0f 84 e4 bc ff ff    	je     6610 <fwp_rc_free_obj>
    a92c:	53                   	push   %rbx
    a92d:	48 8b 47 08          	mov    0x8(%rdi),%rax
    a931:	48 89 fb             	mov    %rdi,%rbx
    a934:	48 89 c7             	mov    %rax,%rdi
    a937:	e8 a4 ce ff ff       	call   77e0 <fwp_file_drop>
    a93c:	48 89 df             	mov    %rbx,%rdi
    a93f:	5b                   	pop    %rbx
    a940:	e9 cb bc ff ff       	jmp    6610 <fwp_rc_free_obj>
    a945:	c3                   	ret
    a946:	66 2e 0f 1f 84 00 00 	cs nopw 0x0(%rax,%rax,1)
    a94d:	00 00 00 

000000000000a950 <fwp_args4>:
    a950:	85 f6                	test   %esi,%esi
    a952:	75 0c                	jne    a960 <fwp_args4+0x10>
    a954:	85 d2                	test   %edx,%edx
    a956:	74 08                	je     a960 <fwp_args4+0x10>
    a958:	48 8b 3f             	mov    (%rdi),%rdi
    a95b:	e9 a0 fd ff ff       	jmp    a700 <fwp_file_dup>
    a960:	c3                   	ret
    a961:	66 66 66 66 66 66 2e 	data16 data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    a968:	0f 1f 84 00 00 00 00 
    a96f:	00 

000000000000a970 <fwp_arg_drop4>:
    a970:	85 f6                	test   %esi,%esi
    a972:	75 0c                	jne    a980 <fwp_arg_drop4+0x10>
    a974:	85 d2                	test   %edx,%edx
    a976:	74 08                	je     a980 <fwp_arg_drop4+0x10>
    a978:	48 8b 3f             	mov    (%rdi),%rdi
    a97b:	e9 60 ce ff ff       	jmp    77e0 <fwp_file_drop>
    a980:	c3                   	ret
    a981:	66 66 66 66 66 66 2e 	data16 data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    a988:	0f 1f 84 00 00 00 00 
    a98f:	00 

000000000000a990 <fwp_entry_release4>:
    a990:	48 8b 07             	mov    (%rdi),%rax
    a993:	48 8b 3f             	mov    (%rdi),%rdi
    a996:	e9 45 ce ff ff       	jmp    77e0 <fwp_file_drop>
    a99b:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)

000000000000a9a0 <f8>:
    a9a0:	41 56                	push   %r14
    a9a2:	53                   	push   %rbx
    a9a3:	48 83 ec 18          	sub    $0x18,%rsp
    a9a7:	48 89 fe             	mov    %rdi,%rsi
    a9aa:	0f 57 c0             	xorps  %xmm0,%xmm0
    a9ad:	0f 29 04 24          	movaps %xmm0,(%rsp)
    a9b1:	48 c7 44 24 10 00 00 	movq   $0x0,0x10(%rsp)
    a9b8:	00 00 
    a9ba:	48 8d 15 6f 43 00 00 	lea    0x436f(%rip),%rdx        # ed30 <d2>
    a9c1:	48 89 e3             	mov    %rsp,%rbx
    a9c4:	48 89 df             	mov    %rbx,%rdi
    a9c7:	b9 01 00 00 00       	mov    $0x1,%ecx
    a9cc:	e8 bf cf ff ff       	call   7990 <fwp_write>
    a9d1:	48 89 df             	mov    %rbx,%rdi
    a9d4:	e8 b7 fd ff ff       	call   a790 <buf_to_str>
    a9d9:	48 89 c1             	mov    %rax,%rcx
    a9dc:	48 2b 0d f5 57 00 00 	sub    0x57f5(%rip),%rcx        # 101d8 <fwp_gc+0x1030>
    a9e3:	48 8b 15 16 58 00 00 	mov    0x5816(%rip),%rdx        # 10200 <fwp_gc+0x1058>
    a9ea:	48 c1 e2 10          	shl    $0x10,%rdx
    a9ee:	48 39 d1             	cmp    %rdx,%rcx
    a9f1:	73 73                	jae    aa66 <f8+0xc6>
    a9f3:	48 8b 15 26 58 00 00 	mov    0x5826(%rip),%rdx        # 10220 <fwp_gc+0x1078>
    a9fa:	48 89 ce             	mov    %rcx,%rsi
    a9fd:	48 c1 ee 10          	shr    $0x10,%rsi
    aa01:	48 69 f6 28 12 00 00 	imul   $0x1228,%rsi,%rsi
    aa08:	0f b6 3c 32          	movzbl (%rdx,%rsi,1),%edi
    aa0c:	48 81 e1 ff ff 00 00 	and    $0xffff,%rcx
    aa13:	75 1b                	jne    aa30 <f8+0x90>
    aa15:	40 80 ff 02          	cmp    $0x2,%dil
    aa19:	75 15                	jne    aa30 <f8+0x90>
    aa1b:	48 8d 1c 32          	lea    (%rdx,%rsi,1),%rbx
    aa1f:	48 81 c3 28 02 00 00 	add    $0x228,%rbx
    aa26:	80 3b ff             	cmpb   $0xff,(%rbx)
    aa29:	74 2b                	je     aa56 <f8+0xb6>
    aa2b:	c6 03 01             	movb   $0x1,(%rbx)
    aa2e:	eb 36                	jmp    aa66 <f8+0xc6>
    aa30:	40 80 ff 01          	cmp    $0x1,%dil
    aa34:	75 30                	jne    aa66 <f8+0xc6>
    aa36:	48 8d 3c 32          	lea    (%rdx,%rsi,1),%rdi
    aa3a:	8b 54 32 20          	mov    0x20(%rdx,%rsi,1),%edx
    aa3e:	48 0f af ca          	imul   %rdx,%rcx
    aa42:	48 c1 e9 20          	shr    $0x20,%rcx
    aa46:	48 8d 1c 39          	lea    (%rcx,%rdi,1),%rbx
    aa4a:	48 81 c3 28 02 00 00 	add    $0x228,%rbx
    aa51:	80 3b ff             	cmpb   $0xff,(%rbx)
    aa54:	75 d5                	jne    aa2b <f8+0x8b>
    aa56:	48 89 df             	mov    %rbx,%rdi
    aa59:	49 89 c6             	mov    %rax,%r14
    aa5c:	e8 7f 8e ff ff       	call   38e0 <fwp_rc_forget_slot>
    aa61:	4c 89 f0             	mov    %r14,%rax
    aa64:	eb c5                	jmp    aa2b <f8+0x8b>
    aa66:	48 83 c4 18          	add    $0x18,%rsp
    aa6a:	5b                   	pop    %rbx
    aa6b:	41 5e                	pop    %r14
    aa6d:	c3                   	ret
    aa6e:	66 90                	xchg   %ax,%ax

000000000000aa70 <fwp_gc_find_data>:
    aa70:	0f b7 77 18          	movzwl 0x18(%rdi),%esi
    aa74:	48 85 f6             	test   %rsi,%rsi
    aa77:	0f 84 be 00 00 00    	je     ab3b <fwp_gc_find_data+0xcb>
    aa7d:	53                   	push   %rbx
    aa7e:	48 8b 07             	mov    (%rdi),%rax
    aa81:	4c 8b 47 10          	mov    0x10(%rdi),%r8
    aa85:	48 6b ce 38          	imul   $0x38,%rsi,%rcx
    aa89:	45 31 c9             	xor    %r9d,%r9d
    aa8c:	48 8d 15 15 47 00 00 	lea    0x4715(%rip),%rdx        # f1a8 <fwp_gc>
    aa93:	41 bb 01 00 00 00    	mov    $0x1,%r11d
    aa99:	45 31 d2             	xor    %r10d,%r10d
    aa9c:	eb 0b                	jmp    aaa9 <fwp_gc_find_data+0x39>
    aa9e:	66 90                	xchg   %ax,%ax
    aaa0:	49 83 c1 38          	add    $0x38,%r9
    aaa4:	4c 39 c9             	cmp    %r9,%rcx
    aaa7:	74 22                	je     aacb <fwp_gc_find_data+0x5b>
    aaa9:	43 83 3c 08 01       	cmpl   $0x1,(%r8,%r9,1)
    aaae:	75 f0                	jne    aaa0 <fwp_gc_find_data+0x30>
    aab0:	4b 8b 5c 08 10       	mov    0x10(%r8,%r9,1),%rbx
    aab5:	48 01 c3             	add    %rax,%rbx
    aab8:	48 39 d3             	cmp    %rdx,%rbx
    aabb:	77 e3                	ja     aaa0 <fwp_gc_find_data+0x30>
    aabd:	4b 03 5c 08 28       	add    0x28(%r8,%r9,1),%rbx
    aac2:	48 39 d3             	cmp    %rdx,%rbx
    aac5:	45 0f 47 d3          	cmova  %r11d,%r10d
    aac9:	eb d5                	jmp    aaa0 <fwp_gc_find_data+0x30>
    aacb:	31 c0                	xor    %eax,%eax
    aacd:	45 85 d2             	test   %r10d,%r10d
    aad0:	0f 95 c0             	setne  %al
    aad3:	74 6e                	je     ab43 <fwp_gc_find_data+0xd3>
    aad5:	66 85 f6             	test   %si,%si
    aad8:	74 69                	je     ab43 <fwp_gc_find_data+0xd3>
    aada:	8b 05 58 58 00 00    	mov    0x5858(%rip),%eax        # 10338 <fwp_gc+0x1190>
    aae0:	48 8b 77 10          	mov    0x10(%rdi),%rsi
    aae4:	45 31 c0             	xor    %r8d,%r8d
    aae7:	eb 10                	jmp    aaf9 <fwp_gc_find_data+0x89>
    aae9:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)
    aaf0:	49 83 c0 38          	add    $0x38,%r8
    aaf4:	4c 39 c1             	cmp    %r8,%rcx
    aaf7:	74 45                	je     ab3e <fwp_gc_find_data+0xce>
    aaf9:	42 83 3c 06 01       	cmpl   $0x1,(%rsi,%r8,1)
    aafe:	75 f0                	jne    aaf0 <fwp_gc_find_data+0x80>
    ab00:	42 f6 44 06 04 02    	testb  $0x2,0x4(%rsi,%r8,1)
    ab06:	74 e8                	je     aaf0 <fwp_gc_find_data+0x80>
    ab08:	83 f8 10             	cmp    $0x10,%eax
    ab0b:	74 31                	je     ab3e <fwp_gc_find_data+0xce>
    ab0d:	4e 8b 4c 06 10       	mov    0x10(%rsi,%r8,1),%r9
    ab12:	4c 03 0f             	add    (%rdi),%r9
    ab15:	4c 63 d0             	movslq %eax,%r10
    ab18:	49 c1 e2 04          	shl    $0x4,%r10
    ab1c:	4d 89 8c 12 90 10 00 	mov    %r9,0x1090(%r10,%rdx,1)
    ab23:	00 
    ab24:	4e 8b 4c 06 28       	mov    0x28(%rsi,%r8,1),%r9
    ab29:	4d 89 8c 12 98 10 00 	mov    %r9,0x1098(%r10,%rdx,1)
    ab30:	00 
    ab31:	ff c0                	inc    %eax
    ab33:	89 05 ff 57 00 00    	mov    %eax,0x57ff(%rip)        # 10338 <fwp_gc+0x1190>
    ab39:	eb b5                	jmp    aaf0 <fwp_gc_find_data+0x80>
    ab3b:	31 c0                	xor    %eax,%eax
    ab3d:	c3                   	ret
    ab3e:	b8 01 00 00 00       	mov    $0x1,%eax
    ab43:	5b                   	pop    %rbx
    ab44:	c3                   	ret
    ab45:	66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
    ab4c:	00 00 00 00 

000000000000ab50 <fwp_gc_report>:
    ab50:	55                   	push   %rbp
    ab51:	41 57                	push   %r15
    ab53:	41 56                	push   %r14
    ab55:	41 55                	push   %r13
    ab57:	41 54                	push   %r12
    ab59:	53                   	push   %rbx
    ab5a:	48 81 ec 58 01 00 00 	sub    $0x158,%rsp
    ab61:	48 8b 05 50 58 00 00 	mov    0x5850(%rip),%rax        # 103b8 <fwp_gc+0x1210>
    ab68:	48 8b 0d 39 46 00 00 	mov    0x4639(%rip),%rcx        # f1a8 <fwp_gc>
    ab6f:	48 29 c8             	sub    %rcx,%rax
    ab72:	f2 48 0f 2a c0       	cvtsi2sd %rax,%xmm0
    ab77:	f2 0f 58 05 11 58 00 	addsd  0x5811(%rip),%xmm0        # 10390 <fwp_gc+0x11e8>
    ab7e:	00 
    ab7f:	f2 0f 11 44 24 48    	movsd  %xmm0,0x48(%rsp)
    ab85:	f2 0f 11 05 03 58 00 	movsd  %xmm0,0x5803(%rip)        # 10390 <fwp_gc+0x11e8>
    ab8c:	00 
    ab8d:	48 89 0d 24 58 00 00 	mov    %rcx,0x5824(%rip)        # 103b8 <fwp_gc+0x1210>
    ab94:	48 8b 05 45 44 00 00 	mov    0x4445(%rip),%rax        # efe0 <stderr@GLIBC_2.2.5>
    ab9b:	48 8b 28             	mov    (%rax),%rbp
    ab9e:	48 8b 1d db 57 00 00 	mov    0x57db(%rip),%rbx        # 10380 <fwp_gc+0x11d8>
    aba5:	4c 8b 3d 14 56 00 00 	mov    0x5614(%rip),%r15        # 101c0 <fwp_gc+0x1018>
    abac:	f2 0f 10 05 fc 57 00 	movsd  0x57fc(%rip),%xmm0        # 103b0 <fwp_gc+0x1208>
    abb3:	00 
    abb4:	f2 0f 11 44 24 30    	movsd  %xmm0,0x30(%rsp)
    abba:	48 8b 05 2f 56 00 00 	mov    0x562f(%rip),%rax        # 101f0 <fwp_gc+0x1048>
    abc1:	48 89 44 24 28       	mov    %rax,0x28(%rsp)
    abc6:	48 8b 05 a3 57 00 00 	mov    0x57a3(%rip),%rax        # 10370 <fwp_gc+0x11c8>
    abcd:	48 89 44 24 20       	mov    %rax,0x20(%rsp)
    abd2:	4c 8b 35 9f 57 00 00 	mov    0x579f(%rip),%r14        # 10378 <fwp_gc+0x11d0>
    abd9:	f2 0f 10 05 b7 57 00 	movsd  0x57b7(%rip),%xmm0        # 10398 <fwp_gc+0x11f0>
    abe0:	00 
    abe1:	f2 0f 11 44 24 40    	movsd  %xmm0,0x40(%rsp)
    abe7:	f2 0f 10 05 b1 57 00 	movsd  0x57b1(%rip),%xmm0        # 103a0 <fwp_gc+0x11f8>
    abee:	00 
    abef:	f2 0f 11 44 24 38    	movsd  %xmm0,0x38(%rsp)
    abf5:	48 8d 3d 3d 1b 00 00 	lea    0x1b3d(%rip),%rdi        # c739 <fwp_segv.msg+0x4f9>
    abfc:	48 8d 35 bb 19 00 00 	lea    0x19bb(%rip),%rsi        # c5be <fwp_segv.msg+0x37e>
    ac03:	e8 88 76 ff ff       	call   2290 <fopen@plt>
    ac08:	49 c7 c4 ff ff ff ff 	mov    $0xffffffffffffffff,%r12
    ac0f:	48 85 c0             	test   %rax,%rax
    ac12:	74 4b                	je     ac5f <fwp_gc_report+0x10f>
    ac14:	49 89 c5             	mov    %rax,%r13
    ac17:	48 89 6c 24 08       	mov    %rbp,0x8(%rsp)
    ac1c:	4c 89 7c 24 10       	mov    %r15,0x10(%rsp)
    ac21:	48 89 5c 24 18       	mov    %rbx,0x18(%rsp)
    ac26:	48 8d 7c 24 50       	lea    0x50(%rsp),%rdi
    ac2b:	be 00 01 00 00       	mov    $0x100,%esi
    ac30:	48 89 c2             	mov    %rax,%rdx
    ac33:	e8 58 75 ff ff       	call   2190 <fgets@plt>
    ac38:	49 c7 c4 ff ff ff ff 	mov    $0xffffffffffffffff,%r12
    ac3f:	48 85 c0             	test   %rax,%rax
    ac42:	0f 85 f1 00 00 00    	jne    ad39 <fwp_gc_report+0x1e9>
    ac48:	4c 89 ef             	mov    %r13,%rdi
    ac4b:	e8 b0 74 ff ff       	call   2100 <fclose@plt>
    ac50:	48 8b 5c 24 18       	mov    0x18(%rsp),%rbx
    ac55:	4c 8b 7c 24 10       	mov    0x10(%rsp),%r15
    ac5a:	48 8b 6c 24 08       	mov    0x8(%rsp),%rbp
    ac5f:	66 49 0f 6e c6       	movq   %r14,%xmm0
    ac64:	66 0f 6f 0d 74 14 00 	movdqa 0x1474(%rip),%xmm1        # c0e0 <_IO_stdin_used+0xe0>
    ac6b:	00 
    ac6c:	66 0f 62 c1          	punpckldq %xmm1,%xmm0
    ac70:	66 0f 28 15 78 14 00 	movapd 0x1478(%rip),%xmm2        # c0f0 <_IO_stdin_used+0xf0>
    ac77:	00 
    ac78:	66 0f 5c c2          	subpd  %xmm2,%xmm0
    ac7c:	66 0f 28 e0          	movapd %xmm0,%xmm4
    ac80:	66 0f 15 e0          	unpckhpd %xmm0,%xmm4
    ac84:	f2 0f 58 e0          	addsd  %xmm0,%xmm4
    ac88:	f2 0f 10 35 78 14 00 	movsd  0x1478(%rip),%xmm6        # c108 <_IO_stdin_used+0x108>
    ac8f:	00 
    ac90:	f2 0f 59 e6          	mulsd  %xmm6,%xmm4
    ac94:	f3 0f 7e 6c 24 20    	movq   0x20(%rsp),%xmm5
    ac9a:	66 0f 62 e9          	punpckldq %xmm1,%xmm5
    ac9e:	66 0f 5c ea          	subpd  %xmm2,%xmm5
    aca2:	66 0f 28 dd          	movapd %xmm5,%xmm3
    aca6:	66 0f 15 dd          	unpckhpd %xmm5,%xmm3
    acaa:	f2 0f 58 dd          	addsd  %xmm5,%xmm3
    acae:	f2 0f 59 de          	mulsd  %xmm6,%xmm3
    acb2:	f3 0f 7e 6c 24 28    	movq   0x28(%rsp),%xmm5
    acb8:	66 0f 62 e9          	punpckldq %xmm1,%xmm5
    acbc:	66 0f 5c ea          	subpd  %xmm2,%xmm5
    acc0:	66 0f 28 d5          	movapd %xmm5,%xmm2
    acc4:	66 0f 15 d5          	unpckhpd %xmm5,%xmm2
    acc8:	f2 0f 58 d5          	addsd  %xmm5,%xmm2
    accc:	f2 0f 59 d6          	mulsd  %xmm6,%xmm2
    acd0:	f2 0f 10 44 24 48    	movsd  0x48(%rsp),%xmm0
    acd6:	f2 0f 10 4c 24 30    	movsd  0x30(%rsp),%xmm1
    acdc:	f2 0f 58 c1          	addsd  %xmm1,%xmm0
    ace0:	f2 0f 59 ce          	mulsd  %xmm6,%xmm1
    ace4:	f2 0f 59 c6          	mulsd  %xmm6,%xmm0
    ace8:	83 3d ad 54 00 00 00 	cmpl   $0x0,0x54ad(%rip)        # 1019c <fwp_gc+0xff4>
    acef:	48 8d 05 31 1a 00 00 	lea    0x1a31(%rip),%rax        # c727 <fwp_segv.msg+0x4e7>
    acf6:	4c 8d 0d 74 19 00 00 	lea    0x1974(%rip),%r9        # c671 <fwp_segv.msg+0x431>
    acfd:	4c 0f 44 c8          	cmove  %rax,%r9
    ad01:	48 8d 35 6a 19 00 00 	lea    0x196a(%rip),%rsi        # c672 <fwp_segv.msg+0x432>
    ad08:	48 89 ef             	mov    %rbp,%rdi
    ad0b:	48 89 da             	mov    %rbx,%rdx
    ad0e:	4c 89 f9             	mov    %r15,%rcx
    ad11:	f2 0f 10 6c 24 40    	movsd  0x40(%rsp),%xmm5
    ad17:	f2 0f 10 74 24 38    	movsd  0x38(%rsp),%xmm6
    ad1d:	4d 89 e0             	mov    %r12,%r8
    ad20:	b0 07                	mov    $0x7,%al
    ad22:	e8 b9 74 ff ff       	call   21e0 <fprintf@plt>
    ad27:	48 81 c4 58 01 00 00 	add    $0x158,%rsp
    ad2e:	5b                   	pop    %rbx
    ad2f:	41 5c                	pop    %r12
    ad31:	41 5d                	pop    %r13
    ad33:	41 5e                	pop    %r14
    ad35:	41 5f                	pop    %r15
    ad37:	5d                   	pop    %rbp
    ad38:	c3                   	ret
    ad39:	48 8d 6c 24 56       	lea    0x56(%rsp),%rbp
    ad3e:	41 bf 56 6d 48 57    	mov    $0x57486d56,%r15d
    ad44:	48 8d 5c 24 50       	lea    0x50(%rsp),%rbx
    ad49:	eb 1e                	jmp    ad69 <fwp_gc_report+0x219>
    ad4b:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)
    ad50:	48 89 df             	mov    %rbx,%rdi
    ad53:	be 00 01 00 00       	mov    $0x100,%esi
    ad58:	4c 89 ea             	mov    %r13,%rdx
    ad5b:	e8 30 74 ff ff       	call   2190 <fgets@plt>
    ad60:	48 85 c0             	test   %rax,%rax
    ad63:	0f 84 df fe ff ff    	je     ac48 <fwp_gc_report+0xf8>
    ad69:	8b 44 24 50          	mov    0x50(%rsp),%eax
    ad6d:	44 31 f8             	xor    %r15d,%eax
    ad70:	0f b6 4c 24 54       	movzbl 0x54(%rsp),%ecx
    ad75:	83 f1 4d             	xor    $0x4d,%ecx
    ad78:	09 c1                	or     %eax,%ecx
    ad7a:	75 d4                	jne    ad50 <fwp_gc_report+0x200>
    ad7c:	80 7c 24 55 3a       	cmpb   $0x3a,0x55(%rsp)
    ad81:	75 cd                	jne    ad50 <fwp_gc_report+0x200>
    ad83:	48 89 ef             	mov    %rbp,%rdi
    ad86:	31 f6                	xor    %esi,%esi
    ad88:	ba 0a 00 00 00       	mov    $0xa,%edx
    ad8d:	e8 6e 74 ff ff       	call   2200 <strtol@plt>
    ad92:	49 89 c4             	mov    %rax,%r12
    ad95:	eb b9                	jmp    ad50 <fwp_gc_report+0x200>
    ad97:	66 0f 1f 84 00 00 00 	nopw   0x0(%rax,%rax,1)
    ad9e:	00 00 

000000000000ada0 <fwp_segv>:
    ada0:	48 8b 05 e9 5e 00 00 	mov    0x5ee9(%rip),%rax        # 10c90 <fwp_main_stack_top>
    ada7:	48 85 c0             	test   %rax,%rax
    adaa:	74 22                	je     adce <fwp_segv+0x2e>
    adac:	48 8b 4e 10          	mov    0x10(%rsi),%rcx
    adb0:	48 2b 05 e1 5e 00 00 	sub    0x5ee1(%rip),%rax        # 10c98 <fwp_main_stack_size>
    adb7:	48 8d 90 00 00 f0 ff 	lea    -0x100000(%rax),%rdx
    adbe:	48 39 ca             	cmp    %rcx,%rdx
    adc1:	77 0b                	ja     adce <fwp_segv+0x2e>
    adc3:	48 05 00 00 10 00    	add    $0x100000,%rax
    adc9:	48 39 c8             	cmp    %rcx,%rax
    adcc:	77 07                	ja     add5 <fwp_segv+0x35>
    adce:	31 f6                	xor    %esi,%esi
    add0:	e9 fb 73 ff ff       	jmp    21d0 <signal@plt>
    add5:	50                   	push   %rax
    add6:	e8 d5 8a ff ff       	call   38b0 <fwp_flush>
    addb:	48 8d 35 5e 14 00 00 	lea    0x145e(%rip),%rsi        # c240 <fwp_segv.msg>
    ade2:	ba 1a 00 00 00       	mov    $0x1a,%edx
    ade7:	bf 02 00 00 00       	mov    $0x2,%edi
    adec:	e8 ff 72 ff ff       	call   20f0 <write@plt>
    adf1:	bf 65 00 00 00       	mov    $0x65,%edi
    adf6:	e8 85 72 ff ff       	call   2080 <_exit@plt>
    adfb:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)

000000000000ae00 <fwp_owner_release0>:
    ae00:	48 8b 3f             	mov    (%rdi),%rdi
    ae03:	e9 e8 b2 ff ff       	jmp    60f0 <fwp_closure_drop>
    ae08:	0f 1f 84 00 00 00 00 	nopl   0x0(%rax,%rax,1)
    ae0f:	00 

000000000000ae10 <fwp_owner_release1>:
    ae10:	48 8b 3f             	mov    (%rdi),%rdi
    ae13:	eb 0b                	jmp    ae20 <fwp_drop1>
    ae15:	66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
    ae1c:	00 00 00 00 

000000000000ae20 <fwp_drop1>:
    ae20:	53                   	push   %rbx
    ae21:	48 8b 15 b0 53 00 00 	mov    0x53b0(%rip),%rdx        # 101d8 <fwp_gc+0x1030>
    ae28:	48 89 f8             	mov    %rdi,%rax
    ae2b:	48 29 d0             	sub    %rdx,%rax
    ae2e:	48 8b 35 cb 53 00 00 	mov    0x53cb(%rip),%rsi        # 10200 <fwp_gc+0x1058>
    ae35:	48 c1 e6 10          	shl    $0x10,%rsi
    ae39:	48 39 f0             	cmp    %rsi,%rax
    ae3c:	0f 83 c1 00 00 00    	jae    af03 <fwp_drop1+0xe3>
    ae42:	48 8b 0d d7 53 00 00 	mov    0x53d7(%rip),%rcx        # 10220 <fwp_gc+0x1078>
    ae49:	49 89 c0             	mov    %rax,%r8
    ae4c:	49 c1 e8 10          	shr    $0x10,%r8
    ae50:	4d 69 c0 28 12 00 00 	imul   $0x1228,%r8,%r8
    ae57:	46 0f b6 0c 01       	movzbl (%rcx,%r8,1),%r9d
    ae5c:	48 25 ff ff 00 00    	and    $0xffff,%rax
    ae62:	75 12                	jne    ae76 <fwp_drop1+0x56>
    ae64:	41 80 f9 02          	cmp    $0x2,%r9b
    ae68:	75 0c                	jne    ae76 <fwp_drop1+0x56>
    ae6a:	4a 8d 04 01          	lea    (%rcx,%r8,1),%rax
    ae6e:	48 05 28 02 00 00    	add    $0x228,%rax
    ae74:	eb 24                	jmp    ae9a <fwp_drop1+0x7a>
    ae76:	41 80 f9 01          	cmp    $0x1,%r9b
    ae7a:	0f 85 83 00 00 00    	jne    af03 <fwp_drop1+0xe3>
    ae80:	4e 8d 0c 01          	lea    (%rcx,%r8,1),%r9
    ae84:	46 8b 44 01 20       	mov    0x20(%rcx,%r8,1),%r8d
    ae89:	49 0f af c0          	imul   %r8,%rax
    ae8d:	48 c1 e8 20          	shr    $0x20,%rax
    ae91:	4c 01 c8             	add    %r9,%rax
    ae94:	48 05 28 02 00 00    	add    $0x228,%rax
    ae9a:	44 0f b6 00          	movzbl (%rax),%r8d
    ae9e:	45 85 c0             	test   %r8d,%r8d
    aea1:	74 60                	je     af03 <fwp_drop1+0xe3>
    aea3:	41 83 f8 01          	cmp    $0x1,%r8d
    aea7:	75 4b                	jne    aef4 <fwp_drop1+0xd4>
    aea9:	8b 07                	mov    (%rdi),%eax
    aeab:	83 f8 01             	cmp    $0x1,%eax
    aeae:	74 55                	je     af05 <fwp_drop1+0xe5>
    aeb0:	85 c0                	test   %eax,%eax
    aeb2:	75 4f                	jne    af03 <fwp_drop1+0xe3>
    aeb4:	48 8b 47 08          	mov    0x8(%rdi),%rax
    aeb8:	49 89 c0             	mov    %rax,%r8
    aebb:	49 29 d0             	sub    %rdx,%r8
    aebe:	49 39 f0             	cmp    %rsi,%r8
    aec1:	0f 83 91 00 00 00    	jae    af58 <fwp_drop1+0x138>
    aec7:	4c 89 c2             	mov    %r8,%rdx
    aeca:	48 c1 ea 10          	shr    $0x10,%rdx
    aece:	48 69 d2 28 12 00 00 	imul   $0x1228,%rdx,%rdx
    aed5:	0f b6 34 11          	movzbl (%rcx,%rdx,1),%esi
    aed9:	49 81 e0 ff ff 00 00 	and    $0xffff,%r8
    aee0:	75 3b                	jne    af1d <fwp_drop1+0xfd>
    aee2:	40 80 fe 02          	cmp    $0x2,%sil
    aee6:	75 35                	jne    af1d <fwp_drop1+0xfd>
    aee8:	48 01 d1             	add    %rdx,%rcx
    aeeb:	48 81 c1 28 02 00 00 	add    $0x228,%rcx
    aef2:	eb 4a                	jmp    af3e <fwp_drop1+0x11e>
    aef4:	41 81 f8 ff 00 00 00 	cmp    $0xff,%r8d
    aefb:	74 73                	je     af70 <fwp_drop1+0x150>
    aefd:	41 fe c8             	dec    %r8b
    af00:	44 88 00             	mov    %r8b,(%rax)
    af03:	5b                   	pop    %rbx
    af04:	c3                   	ret
    af05:	48 8b 47 08          	mov    0x8(%rdi),%rax
    af09:	48 89 fb             	mov    %rdi,%rbx
    af0c:	48 89 c7             	mov    %rax,%rdi
    af0f:	e8 dc 8c ff ff       	call   3bf0 <fwp_drop3>
    af14:	48 89 df             	mov    %rbx,%rdi
    af17:	5b                   	pop    %rbx
    af18:	e9 f3 b6 ff ff       	jmp    6610 <fwp_rc_free_obj>
    af1d:	40 80 fe 01          	cmp    $0x1,%sil
    af21:	75 35                	jne    af58 <fwp_drop1+0x138>
    af23:	48 8d 34 11          	lea    (%rcx,%rdx,1),%rsi
    af27:	8b 4c 11 20          	mov    0x20(%rcx,%rdx,1),%ecx
    af2b:	4c 0f af c1          	imul   %rcx,%r8
    af2f:	49 c1 e8 20          	shr    $0x20,%r8
    af33:	49 8d 0c 30          	lea    (%r8,%rsi,1),%rcx
    af37:	48 81 c1 28 02 00 00 	add    $0x228,%rcx
    af3e:	0f b6 11             	movzbl (%rcx),%edx
    af41:	85 d2                	test   %edx,%edx
    af43:	74 13                	je     af58 <fwp_drop1+0x138>
    af45:	83 fa 01             	cmp    $0x1,%edx
    af48:	75 14                	jne    af5e <fwp_drop1+0x13e>
    af4a:	48 89 fb             	mov    %rdi,%rbx
    af4d:	48 89 c7             	mov    %rax,%rdi
    af50:	e8 bb b6 ff ff       	call   6610 <fwp_rc_free_obj>
    af55:	48 89 df             	mov    %rbx,%rdi
    af58:	5b                   	pop    %rbx
    af59:	e9 b2 b6 ff ff       	jmp    6610 <fwp_rc_free_obj>
    af5e:	81 fa ff 00 00 00    	cmp    $0xff,%edx
    af64:	74 13                	je     af79 <fwp_drop1+0x159>
    af66:	fe ca                	dec    %dl
    af68:	88 11                	mov    %dl,(%rcx)
    af6a:	5b                   	pop    %rbx
    af6b:	e9 a0 b6 ff ff       	jmp    6610 <fwp_rc_free_obj>
    af70:	48 89 c7             	mov    %rax,%rdi
    af73:	5b                   	pop    %rbx
    af74:	e9 87 b4 ff ff       	jmp    6400 <fwp_rc_wide_drop>
    af79:	48 89 fb             	mov    %rdi,%rbx
    af7c:	48 89 cf             	mov    %rcx,%rdi
    af7f:	e8 7c b4 ff ff       	call   6400 <fwp_rc_wide_drop>
    af84:	eb cf                	jmp    af55 <fwp_drop1+0x135>
    af86:	66 2e 0f 1f 84 00 00 	cs nopw 0x0(%rax,%rax,1)
    af8d:	00 00 00 

000000000000af90 <fwp_owner_release2>:
    af90:	48 8b 3f             	mov    (%rdi),%rdi
    af93:	48 89 f8             	mov    %rdi,%rax
    af96:	48 2b 05 3b 52 00 00 	sub    0x523b(%rip),%rax        # 101d8 <fwp_gc+0x1030>
    af9d:	48 8b 0d 5c 52 00 00 	mov    0x525c(%rip),%rcx        # 10200 <fwp_gc+0x1058>
    afa4:	48 c1 e1 10          	shl    $0x10,%rcx
    afa8:	48 39 c8             	cmp    %rcx,%rax
    afab:	73 6e                	jae    b01b <fwp_owner_release2+0x8b>
    afad:	48 8b 0d 6c 52 00 00 	mov    0x526c(%rip),%rcx        # 10220 <fwp_gc+0x1078>
    afb4:	48 89 c2             	mov    %rax,%rdx
    afb7:	48 c1 ea 10          	shr    $0x10,%rdx
    afbb:	48 69 d2 28 12 00 00 	imul   $0x1228,%rdx,%rdx
    afc2:	0f b6 34 11          	movzbl (%rcx,%rdx,1),%esi
    afc6:	48 25 ff ff 00 00    	and    $0xffff,%rax
    afcc:	75 12                	jne    afe0 <fwp_owner_release2+0x50>
    afce:	40 80 fe 02          	cmp    $0x2,%sil
    afd2:	75 0c                	jne    afe0 <fwp_owner_release2+0x50>
    afd4:	48 8d 04 11          	lea    (%rcx,%rdx,1),%rax
    afd8:	48 05 28 02 00 00    	add    $0x228,%rax
    afde:	eb 1f                	jmp    afff <fwp_owner_release2+0x6f>
    afe0:	40 80 fe 01          	cmp    $0x1,%sil
    afe4:	75 35                	jne    b01b <fwp_owner_release2+0x8b>
    afe6:	48 8d 34 11          	lea    (%rcx,%rdx,1),%rsi
    afea:	8b 4c 11 20          	mov    0x20(%rcx,%rdx,1),%ecx
    afee:	48 0f af c1          	imul   %rcx,%rax
    aff2:	48 c1 e8 20          	shr    $0x20,%rax
    aff6:	48 01 f0             	add    %rsi,%rax
    aff9:	48 05 28 02 00 00    	add    $0x228,%rax
    afff:	0f b6 08             	movzbl (%rax),%ecx
    b002:	85 c9                	test   %ecx,%ecx
    b004:	74 15                	je     b01b <fwp_owner_release2+0x8b>
    b006:	83 f9 01             	cmp    $0x1,%ecx
    b009:	0f 84 01 b6 ff ff    	je     6610 <fwp_rc_free_obj>
    b00f:	81 f9 ff 00 00 00    	cmp    $0xff,%ecx
    b015:	74 05                	je     b01c <fwp_owner_release2+0x8c>
    b017:	fe c9                	dec    %cl
    b019:	88 08                	mov    %cl,(%rax)
    b01b:	c3                   	ret
    b01c:	48 89 c7             	mov    %rax,%rdi
    b01f:	e9 dc b3 ff ff       	jmp    6400 <fwp_rc_wide_drop>
    b024:	66 66 66 2e 0f 1f 84 	data16 data16 cs nopw 0x0(%rax,%rax,1)
    b02b:	00 00 00 00 00 

000000000000b030 <fwp_owner_release3>:
    b030:	48 8b 3f             	mov    (%rdi),%rdi
    b033:	e9 b8 b0 ff ff       	jmp    60f0 <fwp_closure_drop>
    b038:	0f 1f 84 00 00 00 00 	nopl   0x0(%rax,%rax,1)
    b03f:	00 

000000000000b040 <fwp_owner_release4>:
    b040:	48 8b 3f             	mov    (%rdi),%rdi
    b043:	e9 d8 fd ff ff       	jmp    ae20 <fwp_drop1>
    b048:	0f 1f 84 00 00 00 00 	nopl   0x0(%rax,%rax,1)
    b04f:	00 

000000000000b050 <fwp_owner_release5>:
    b050:	48 8b 3f             	mov    (%rdi),%rdi
    b053:	48 89 f8             	mov    %rdi,%rax
    b056:	48 2b 05 7b 51 00 00 	sub    0x517b(%rip),%rax        # 101d8 <fwp_gc+0x1030>
    b05d:	48 8b 0d 9c 51 00 00 	mov    0x519c(%rip),%rcx        # 10200 <fwp_gc+0x1058>
    b064:	48 c1 e1 10          	shl    $0x10,%rcx
    b068:	48 39 c8             	cmp    %rcx,%rax
    b06b:	73 6e                	jae    b0db <fwp_owner_release5+0x8b>
    b06d:	48 8b 0d ac 51 00 00 	mov    0x51ac(%rip),%rcx        # 10220 <fwp_gc+0x1078>
    b074:	48 89 c2             	mov    %rax,%rdx
    b077:	48 c1 ea 10          	shr    $0x10,%rdx
    b07b:	48 69 d2 28 12 00 00 	imul   $0x1228,%rdx,%rdx
    b082:	0f b6 34 11          	movzbl (%rcx,%rdx,1),%esi
    b086:	48 25 ff ff 00 00    	and    $0xffff,%rax
    b08c:	75 12                	jne    b0a0 <fwp_owner_release5+0x50>
    b08e:	40 80 fe 02          	cmp    $0x2,%sil
    b092:	75 0c                	jne    b0a0 <fwp_owner_release5+0x50>
    b094:	48 8d 04 11          	lea    (%rcx,%rdx,1),%rax
    b098:	48 05 28 02 00 00    	add    $0x228,%rax
    b09e:	eb 1f                	jmp    b0bf <fwp_owner_release5+0x6f>
    b0a0:	40 80 fe 01          	cmp    $0x1,%sil
    b0a4:	75 35                	jne    b0db <fwp_owner_release5+0x8b>
    b0a6:	48 8d 34 11          	lea    (%rcx,%rdx,1),%rsi
    b0aa:	8b 4c 11 20          	mov    0x20(%rcx,%rdx,1),%ecx
    b0ae:	48 0f af c1          	imul   %rcx,%rax
    b0b2:	48 c1 e8 20          	shr    $0x20,%rax
    b0b6:	48 01 f0             	add    %rsi,%rax
    b0b9:	48 05 28 02 00 00    	add    $0x228,%rax
    b0bf:	0f b6 08             	movzbl (%rax),%ecx
    b0c2:	85 c9                	test   %ecx,%ecx
    b0c4:	74 15                	je     b0db <fwp_owner_release5+0x8b>
    b0c6:	83 f9 01             	cmp    $0x1,%ecx
    b0c9:	0f 84 41 b5 ff ff    	je     6610 <fwp_rc_free_obj>
    b0cf:	81 f9 ff 00 00 00    	cmp    $0xff,%ecx
    b0d5:	74 05                	je     b0dc <fwp_owner_release5+0x8c>
    b0d7:	fe c9                	dec    %cl
    b0d9:	88 08                	mov    %cl,(%rax)
    b0db:	c3                   	ret
    b0dc:	48 89 c7             	mov    %rax,%rdi
    b0df:	e9 1c b3 ff ff       	jmp    6400 <fwp_rc_wide_drop>
    b0e4:	66 66 66 2e 0f 1f 84 	data16 data16 cs nopw 0x0(%rax,%rax,1)
    b0eb:	00 00 00 00 00 

000000000000b0f0 <fwp_owner_release6>:
    b0f0:	48 8b 07             	mov    (%rdi),%rax
    b0f3:	48 2b 05 de 50 00 00 	sub    0x50de(%rip),%rax        # 101d8 <fwp_gc+0x1030>
    b0fa:	48 8b 0d ff 50 00 00 	mov    0x50ff(%rip),%rcx        # 10200 <fwp_gc+0x1058>
    b101:	48 c1 e1 10          	shl    $0x10,%rcx
    b105:	48 39 c8             	cmp    %rcx,%rax
    b108:	73 68                	jae    b172 <fwp_owner_release6+0x82>
    b10a:	48 8b 0d 0f 51 00 00 	mov    0x510f(%rip),%rcx        # 10220 <fwp_gc+0x1078>
    b111:	48 89 c2             	mov    %rax,%rdx
    b114:	48 c1 ea 10          	shr    $0x10,%rdx
    b118:	48 69 d2 28 12 00 00 	imul   $0x1228,%rdx,%rdx
    b11f:	0f b6 34 11          	movzbl (%rcx,%rdx,1),%esi
    b123:	48 25 ff ff 00 00    	and    $0xffff,%rax
    b129:	75 13                	jne    b13e <fwp_owner_release6+0x4e>
    b12b:	40 80 fe 02          	cmp    $0x2,%sil
    b12f:	75 0d                	jne    b13e <fwp_owner_release6+0x4e>
    b131:	48 8d 3c 11          	lea    (%rcx,%rdx,1),%rdi
    b135:	48 81 c7 28 02 00 00 	add    $0x228,%rdi
    b13c:	eb 21                	jmp    b15f <fwp_owner_release6+0x6f>
    b13e:	40 80 fe 01          	cmp    $0x1,%sil
    b142:	75 2e                	jne    b172 <fwp_owner_release6+0x82>
    b144:	48 8d 34 11          	lea    (%rcx,%rdx,1),%rsi
    b148:	8b 4c 11 20          	mov    0x20(%rcx,%rdx,1),%ecx
    b14c:	48 0f af c1          	imul   %rcx,%rax
    b150:	48 c1 e8 20          	shr    $0x20,%rax
    b154:	48 8d 3c 30          	lea    (%rax,%rsi,1),%rdi
    b158:	48 81 c7 28 02 00 00 	add    $0x228,%rdi
    b15f:	0f b6 07             	movzbl (%rdi),%eax
    b162:	3c 02                	cmp    $0x2,%al
    b164:	72 0c                	jb     b172 <fwp_owner_release6+0x82>
    b166:	3c ff                	cmp    $0xff,%al
    b168:	0f 84 92 b2 ff ff    	je     6400 <fwp_rc_wide_drop>
    b16e:	fe c8                	dec    %al
    b170:	88 07                	mov    %al,(%rdi)
    b172:	c3                   	ret
    b173:	66 66 66 66 2e 0f 1f 	data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    b17a:	84 00 00 00 00 00 

000000000000b180 <fwp_owner_release7>:
    b180:	48 8b 07             	mov    (%rdi),%rax
    b183:	48 2b 05 4e 50 00 00 	sub    0x504e(%rip),%rax        # 101d8 <fwp_gc+0x1030>
    b18a:	48 8b 0d 6f 50 00 00 	mov    0x506f(%rip),%rcx        # 10200 <fwp_gc+0x1058>
    b191:	48 c1 e1 10          	shl    $0x10,%rcx
    b195:	48 39 c8             	cmp    %rcx,%rax
    b198:	73 68                	jae    b202 <fwp_owner_release7+0x82>
    b19a:	48 8b 0d 7f 50 00 00 	mov    0x507f(%rip),%rcx        # 10220 <fwp_gc+0x1078>
    b1a1:	48 89 c2             	mov    %rax,%rdx
    b1a4:	48 c1 ea 10          	shr    $0x10,%rdx
    b1a8:	48 69 d2 28 12 00 00 	imul   $0x1228,%rdx,%rdx
    b1af:	0f b6 34 11          	movzbl (%rcx,%rdx,1),%esi
    b1b3:	48 25 ff ff 00 00    	and    $0xffff,%rax
    b1b9:	75 13                	jne    b1ce <fwp_owner_release7+0x4e>
    b1bb:	40 80 fe 02          	cmp    $0x2,%sil
    b1bf:	75 0d                	jne    b1ce <fwp_owner_release7+0x4e>
    b1c1:	48 8d 3c 11          	lea    (%rcx,%rdx,1),%rdi
    b1c5:	48 81 c7 28 02 00 00 	add    $0x228,%rdi
    b1cc:	eb 21                	jmp    b1ef <fwp_owner_release7+0x6f>
    b1ce:	40 80 fe 01          	cmp    $0x1,%sil
    b1d2:	75 2e                	jne    b202 <fwp_owner_release7+0x82>
    b1d4:	48 8d 34 11          	lea    (%rcx,%rdx,1),%rsi
    b1d8:	8b 4c 11 20          	mov    0x20(%rcx,%rdx,1),%ecx
    b1dc:	48 0f af c1          	imul   %rcx,%rax
    b1e0:	48 c1 e8 20          	shr    $0x20,%rax
    b1e4:	48 8d 3c 30          	lea    (%rax,%rsi,1),%rdi
    b1e8:	48 81 c7 28 02 00 00 	add    $0x228,%rdi
    b1ef:	0f b6 07             	movzbl (%rdi),%eax
    b1f2:	3c 02                	cmp    $0x2,%al
    b1f4:	72 0c                	jb     b202 <fwp_owner_release7+0x82>
    b1f6:	3c ff                	cmp    $0xff,%al
    b1f8:	0f 84 02 b2 ff ff    	je     6400 <fwp_rc_wide_drop>
    b1fe:	fe c8                	dec    %al
    b200:	88 07                	mov    %al,(%rdi)
    b202:	c3                   	ret
    b203:	66 2e 0f 1f 84 00 00 	cs nopw 0x0(%rax,%rax,1)
    b20a:	00 00 00 
    b20d:	0f 1f 00             	nopl   (%rax)

000000000000b210 <__divti3>:
    b210:	f3 0f 1e fa          	endbr64
    b214:	55                   	push   %rbp
    b215:	49 89 f8             	mov    %rdi,%r8
    b218:	49 89 d2             	mov    %rdx,%r10
    b21b:	49 89 cb             	mov    %rcx,%r11
    b21e:	31 ff                	xor    %edi,%edi
    b220:	48 89 e5             	mov    %rsp,%rbp
    b223:	41 56                	push   %r14
    b225:	53                   	push   %rbx
    b226:	48 85 f6             	test   %rsi,%rsi
    b229:	79 13                	jns    b23e <__divti3+0x2e>
    b22b:	45 31 c9             	xor    %r9d,%r9d
    b22e:	49 f7 d8             	neg    %r8
    b231:	48 c7 c7 ff ff ff ff 	mov    $0xffffffffffffffff,%rdi
    b238:	49 19 f1             	sbb    %rsi,%r9
    b23b:	4c 89 ce             	mov    %r9,%rsi
    b23e:	4c 89 da             	mov    %r11,%rdx
    b241:	4d 85 db             	test   %r11,%r11
    b244:	0f 88 f6 00 00 00    	js     b340 <__divti3+0x130>
    b24a:	4d 89 d6             	mov    %r10,%r14
    b24d:	75 31                	jne    b280 <__divti3+0x70>
    b24f:	4c 39 f6             	cmp    %r14,%rsi
    b252:	0f 83 b8 00 00 00    	jae    b310 <__divti3+0x100>
    b258:	48 89 f2             	mov    %rsi,%rdx
    b25b:	31 f6                	xor    %esi,%esi
    b25d:	4c 89 c0             	mov    %r8,%rax
    b260:	49 f7 f6             	div    %r14
    b263:	48 89 f2             	mov    %rsi,%rdx
    b266:	48 85 ff             	test   %rdi,%rdi
    b269:	74 0a                	je     b275 <__divti3+0x65>
    b26b:	48 f7 d8             	neg    %rax
    b26e:	48 83 d2 00          	adc    $0x0,%rdx
    b272:	48 f7 da             	neg    %rdx
    b275:	5b                   	pop    %rbx
    b276:	41 5e                	pop    %r14
    b278:	5d                   	pop    %rbp
    b279:	c3                   	ret
    b27a:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)
    b280:	4c 39 de             	cmp    %r11,%rsi
    b283:	0f 82 d5 00 00 00    	jb     b35e <__divti3+0x14e>
    b289:	4d 0f bd d3          	bsr    %r11,%r10
    b28d:	41 83 f2 3f          	xor    $0x3f,%r10d
    b291:	44 89 d1             	mov    %r10d,%ecx
    b294:	b8 40 00 00 00       	mov    $0x40,%eax
    b299:	4c 89 f3             	mov    %r14,%rbx
    b29c:	4d 89 f1             	mov    %r14,%r9
    b29f:	48 d3 e2             	shl    %cl,%rdx
    b2a2:	49 63 ca             	movslq %r10d,%rcx
    b2a5:	49 89 f3             	mov    %rsi,%r11
    b2a8:	48 29 c8             	sub    %rcx,%rax
    b2ab:	89 c1                	mov    %eax,%ecx
    b2ad:	48 d3 eb             	shr    %cl,%rbx
    b2b0:	44 89 d1             	mov    %r10d,%ecx
    b2b3:	49 d3 e1             	shl    %cl,%r9
    b2b6:	89 c1                	mov    %eax,%ecx
    b2b8:	48 09 d3             	or     %rdx,%rbx
    b2bb:	4c 89 c2             	mov    %r8,%rdx
    b2be:	49 d3 eb             	shr    %cl,%r11
    b2c1:	44 89 d1             	mov    %r10d,%ecx
    b2c4:	48 d3 e6             	shl    %cl,%rsi
    b2c7:	89 c1                	mov    %eax,%ecx
    b2c9:	48 d3 ea             	shr    %cl,%rdx
    b2cc:	48 89 d0             	mov    %rdx,%rax
    b2cf:	4c 89 da             	mov    %r11,%rdx
    b2d2:	48 09 f0             	or     %rsi,%rax
    b2d5:	48 f7 f3             	div    %rbx
    b2d8:	49 89 d3             	mov    %rdx,%r11
    b2db:	48 89 c6             	mov    %rax,%rsi
    b2de:	49 f7 e1             	mul    %r9
    b2e1:	49 39 d3             	cmp    %rdx,%r11
    b2e4:	0f 82 be 00 00 00    	jb     b3a8 <__divti3+0x198>
    b2ea:	44 89 d1             	mov    %r10d,%ecx
    b2ed:	49 d3 e0             	shl    %cl,%r8
    b2f0:	49 39 c0             	cmp    %rax,%r8
    b2f3:	73 09                	jae    b2fe <__divti3+0xee>
    b2f5:	49 39 d3             	cmp    %rdx,%r11
    b2f8:	0f 84 aa 00 00 00    	je     b3a8 <__divti3+0x198>
    b2fe:	48 89 f0             	mov    %rsi,%rax
    b301:	31 f6                	xor    %esi,%esi
    b303:	e9 5b ff ff ff       	jmp    b263 <__divti3+0x53>
    b308:	0f 1f 84 00 00 00 00 	nopl   0x0(%rax,%rax,1)
    b30f:	00 
    b310:	4d 85 f6             	test   %r14,%r14
    b313:	75 0d                	jne    b322 <__divti3+0x112>
    b315:	b8 01 00 00 00       	mov    $0x1,%eax
    b31a:	31 d2                	xor    %edx,%edx
    b31c:	49 f7 f6             	div    %r14
    b31f:	49 89 c6             	mov    %rax,%r14
    b322:	48 89 f0             	mov    %rsi,%rax
    b325:	31 d2                	xor    %edx,%edx
    b327:	49 f7 f6             	div    %r14
    b32a:	48 89 c6             	mov    %rax,%rsi
    b32d:	4c 89 c0             	mov    %r8,%rax
    b330:	49 f7 f6             	div    %r14
    b333:	e9 2b ff ff ff       	jmp    b263 <__divti3+0x53>
    b338:	0f 1f 84 00 00 00 00 	nopl   0x0(%rax,%rax,1)
    b33f:	00 
    b340:	49 f7 da             	neg    %r10
    b343:	48 f7 d7             	not    %rdi
    b346:	49 83 d3 00          	adc    $0x0,%r11
    b34a:	4d 89 d6             	mov    %r10,%r14
    b34d:	49 f7 db             	neg    %r11
    b350:	4c 89 da             	mov    %r11,%rdx
    b353:	0f 84 f6 fe ff ff    	je     b24f <__divti3+0x3f>
    b359:	4c 39 de             	cmp    %r11,%rsi
    b35c:	73 12                	jae    b370 <__divti3+0x160>
    b35e:	31 f6                	xor    %esi,%esi
    b360:	31 c0                	xor    %eax,%eax
    b362:	e9 fc fe ff ff       	jmp    b263 <__divti3+0x53>
    b367:	66 0f 1f 84 00 00 00 	nopw   0x0(%rax,%rax,1)
    b36e:	00 00 
    b370:	49 0f bd c3          	bsr    %r11,%rax
    b374:	48 83 f0 3f          	xor    $0x3f,%rax
    b378:	41 89 c2             	mov    %eax,%r10d
    b37b:	85 c0                	test   %eax,%eax
    b37d:	0f 85 0e ff ff ff    	jne    b291 <__divti3+0x81>
    b383:	49 39 f3             	cmp    %rsi,%r11
    b386:	72 0d                	jb     b395 <__divti3+0x185>
    b388:	31 f6                	xor    %esi,%esi
    b38a:	31 c0                	xor    %eax,%eax
    b38c:	4d 39 f0             	cmp    %r14,%r8
    b38f:	0f 82 ce fe ff ff    	jb     b263 <__divti3+0x53>
    b395:	31 f6                	xor    %esi,%esi
    b397:	b8 01 00 00 00       	mov    $0x1,%eax
    b39c:	e9 c2 fe ff ff       	jmp    b263 <__divti3+0x53>
    b3a1:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)
    b3a8:	48 8d 46 ff          	lea    -0x1(%rsi),%rax
    b3ac:	31 f6                	xor    %esi,%esi
    b3ae:	e9 b0 fe ff ff       	jmp    b263 <__divti3+0x53>
    b3b3:	66 2e 0f 1f 84 00 00 	cs nopw 0x0(%rax,%rax,1)
    b3ba:	00 00 00 
    b3bd:	0f 1f 00             	nopl   (%rax)

000000000000b3c0 <atexit>:
    b3c0:	f3 0f 1e fa          	endbr64
    b3c4:	48 8b 15 cd 3d 00 00 	mov    0x3dcd(%rip),%rdx        # f198 <__dso_handle>
    b3cb:	31 f6                	xor    %esi,%esi
    b3cd:	e9 de 6e ff ff       	jmp    22b0 <__cxa_atexit@plt>

Disassembly of section .fini:

000000000000b3d4 <_fini>:
    b3d4:	f3 0f 1e fa          	endbr64
    b3d8:	48 83 ec 08          	sub    $0x8,%rsp
    b3dc:	48 83 c4 08          	add    $0x8,%rsp
    b3e0:	c3                   	ret
