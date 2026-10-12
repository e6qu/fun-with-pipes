
/tmp/fwp-arc-4399/files-1-dynamic-O2:     file format elf64-x86-64


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
    2390:	48 8d 3d 99 e8 00 00 	lea    0xe899(%rip),%rdi        # 10c30 <__TMC_END__>
    2397:	48 8d 05 92 e8 00 00 	lea    0xe892(%rip),%rax        # 10c30 <__TMC_END__>
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
    23c0:	48 8d 3d 69 e8 00 00 	lea    0xe869(%rip),%rdi        # 10c30 <__TMC_END__>
    23c7:	48 8d 35 62 e8 00 00 	lea    0xe862(%rip),%rsi        # 10c30 <__TMC_END__>
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
    2404:	80 3d 25 e8 00 00 00 	cmpb   $0x0,0xe825(%rip)        # 10c30 <__TMC_END__>
    240b:	75 2b                	jne    2438 <__do_global_dtors_aux+0x38>
    240d:	55                   	push   %rbp
    240e:	48 83 3d c2 cb 00 00 	cmpq   $0x0,0xcbc2(%rip)        # efd8 <__cxa_finalize@GLIBC_2.2.5>
    2415:	00 
    2416:	48 89 e5             	mov    %rsp,%rbp
    2419:	74 0c                	je     2427 <__do_global_dtors_aux+0x27>
    241b:	48 8b 3d 76 cd 00 00 	mov    0xcd76(%rip),%rdi        # f198 <__dso_handle>
    2422:	e8 29 ff ff ff       	call   2350 <__cxa_finalize@plt>
    2427:	e8 64 ff ff ff       	call   2390 <deregister_tm_clones>
    242c:	c6 05 fd e7 00 00 01 	movb   $0x1,0xe7fd(%rip)        # 10c30 <__TMC_END__>
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
    2457:	48 8d 05 92 c5 00 00 	lea    0xc592(%rip),%rax        # e9f0 <fwp_fn_table>
    245e:	48 89 05 db e7 00 00 	mov    %rax,0xe7db(%rip)        # 10c40 <fwp_fns>
    2465:	4c 8b 35 54 cb 00 00 	mov    0xcb54(%rip),%r14        # efc0 <stdout@GLIBC_2.2.5>
    246c:	49 8b 06             	mov    (%r14),%rax
    246f:	48 89 05 d2 e7 00 00 	mov    %rax,0xe7d2(%rip)        # 10c48 <fwp_prog_out>
    2476:	48 89 35 d3 e7 00 00 	mov    %rsi,0xe7d3(%rip)        # 10c50 <fwp_argv>
    247d:	48 8d 35 d4 e7 00 00 	lea    0xe7d4(%rip),%rsi        # 10c58 <fwp_start_time>
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
    25a8:	41 54                	push   %r12
    25aa:	53                   	push   %rbx
    25ab:	48 81 ec c0 01 00 00 	sub    $0x1c0,%rsp
    25b2:	83 3d db db 00 00 00 	cmpl   $0x0,0xdbdb(%rip)        # 10194 <fwp_gc+0xfec>
    25b9:	75 05                	jne    25c0 <fwp_main_thread+0x20>
    25bb:	e8 40 30 00 00       	call   5600 <fwp_gc_init>
    25c0:	48 89 2d 69 dc 00 00 	mov    %rbp,0xdc69(%rip)        # 10230 <fwp_gc+0x1088>
    25c7:	48 8d 3d a2 83 00 00 	lea    0x83a2(%rip),%rdi        # a970 <fwp_gc_find_data>
    25ce:	31 f6                	xor    %esi,%esi
    25d0:	e8 6b fa ff ff       	call   2040 <dl_iterate_phdr@plt>
    25d5:	83 3d bc db 00 00 00 	cmpl   $0x0,0xdbbc(%rip)        # 10198 <fwp_gc+0xff0>
    25dc:	0f 95 c1             	setne  %cl
    25df:	83 3d 52 dd 00 00 00 	cmpl   $0x0,0xdd52(%rip)        # 10338 <fwp_gc+0x1190>
    25e6:	0f 9f c0             	setg   %al
    25e9:	20 c8                	and    %cl,%al
    25eb:	0f b6 c8             	movzbl %al,%ecx
    25ee:	89 0d a8 db 00 00    	mov    %ecx,0xdba8(%rip)        # 1019c <fwp_gc+0xff4>
    25f4:	83 3d a9 db 00 00 00 	cmpl   $0x0,0xdba9(%rip)        # 101a4 <fwp_gc+0xffc>
    25fb:	74 16                	je     2613 <fwp_main_thread+0x73>
    25fd:	48 8d 3d 4c 84 00 00 	lea    0x844c(%rip),%rdi        # aa50 <fwp_gc_report>
    2604:	e8 47 8c 00 00       	call   b250 <atexit>
    2609:	83 3d 8c db 00 00 00 	cmpl   $0x0,0xdb8c(%rip)        # 1019c <fwp_gc+0xff4>
    2610:	0f 95 c0             	setne  %al
    2613:	84 c0                	test   %al,%al
    2615:	74 43                	je     265a <fwp_main_thread+0xba>
    2617:	48 83 3d a9 db 00 00 	cmpq   $0x0,0xdba9(%rip)        # 101c8 <fwp_gc+0x1020>
    261e:	00 
    261f:	74 39                	je     265a <fwp_main_thread+0xba>
    2621:	48 8b 05 90 dd 00 00 	mov    0xdd90(%rip),%rax        # 103b8 <fwp_gc+0x1210>
    2628:	48 2b 05 79 cb 00 00 	sub    0xcb79(%rip),%rax        # f1a8 <fwp_gc>
    262f:	f2 48 0f 2a c0       	cvtsi2sd %rax,%xmm0
    2634:	f2 0f 58 05 54 dd 00 	addsd  0xdd54(%rip),%xmm0        # 10390 <fwp_gc+0x11e8>
    263b:	00 
    263c:	f2 0f 11 05 4c dd 00 	movsd  %xmm0,0xdd4c(%rip)        # 10390 <fwp_gc+0x11e8>
    2643:	00 
    2644:	48 c7 05 69 dd 00 00 	movq   $0x0,0xdd69(%rip)        # 103b8 <fwp_gc+0x1210>
    264b:	00 00 00 00 
    264f:	48 c7 05 4e cb 00 00 	movq   $0x0,0xcb4e(%rip)        # f1a8 <fwp_gc>
    2656:	00 00 00 00 
    265a:	48 8b 05 3f cb 00 00 	mov    0xcb3f(%rip),%rax        # f1a0 <fwp_main_stack>
    2661:	4c 8d a5 10 ff ff ff 	lea    -0xf0(%rbp),%r12
    2668:	4c 89 25 11 e6 00 00 	mov    %r12,0xe611(%rip)        # 10c80 <fwp_main_stack_top>
    266f:	48 89 05 12 e6 00 00 	mov    %rax,0xe612(%rip)        # 10c88 <fwp_main_stack_size>
    2676:	48 8d 05 13 e6 00 00 	lea    0xe613(%rip),%rax        # 10c90 <fwp_stack_guard_init.alt>
    267d:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
    2681:	48 c7 45 d8 00 00 01 	movq   $0x10000,-0x28(%rbp)
    2688:	00 
    2689:	c7 45 d0 00 00 00 00 	movl   $0x0,-0x30(%rbp)
    2690:	4c 8d 75 c8          	lea    -0x38(%rbp),%r14
    2694:	4c 89 f7             	mov    %r14,%rdi
    2697:	31 f6                	xor    %esi,%esi
    2699:	e8 72 fc ff ff       	call   2310 <sigaltstack@plt>
    269e:	85 c0                	test   %eax,%eax
    26a0:	0f 85 95 00 00 00    	jne    273b <fwp_main_thread+0x19b>
    26a6:	48 8d bd 28 fe ff ff 	lea    -0x1d8(%rbp),%rdi
    26ad:	66 0f 57 c0          	xorpd  %xmm0,%xmm0
    26b1:	66 0f 11 85 a8 fe ff 	movupd %xmm0,-0x158(%rbp)
    26b8:	ff 
    26b9:	66 0f 11 85 98 fe ff 	movupd %xmm0,-0x168(%rbp)
    26c0:	ff 
    26c1:	66 0f 11 85 88 fe ff 	movupd %xmm0,-0x178(%rbp)
    26c8:	ff 
    26c9:	66 0f 11 85 78 fe ff 	movupd %xmm0,-0x188(%rbp)
    26d0:	ff 
    26d1:	66 0f 11 85 68 fe ff 	movupd %xmm0,-0x198(%rbp)
    26d8:	ff 
    26d9:	66 0f 11 85 58 fe ff 	movupd %xmm0,-0x1a8(%rbp)
    26e0:	ff 
    26e1:	66 0f 11 85 48 fe ff 	movupd %xmm0,-0x1b8(%rbp)
    26e8:	ff 
    26e9:	66 0f 11 85 38 fe ff 	movupd %xmm0,-0x1c8(%rbp)
    26f0:	ff 
    26f1:	66 0f 11 85 28 fe ff 	movupd %xmm0,-0x1d8(%rbp)
    26f8:	ff 
    26f9:	48 8d 05 a0 85 00 00 	lea    0x85a0(%rip),%rax        # aca0 <fwp_segv>
    2700:	48 89 85 20 fe ff ff 	mov    %rax,-0x1e0(%rbp)
    2707:	c7 85 a8 fe ff ff 04 	movl   $0x8000004,-0x158(%rbp)
    270e:	00 00 08 
    2711:	e8 da fa ff ff       	call   21f0 <sigemptyset@plt>
    2716:	48 8d 9d 20 fe ff ff 	lea    -0x1e0(%rbp),%rbx
    271d:	bf 0b 00 00 00       	mov    $0xb,%edi
    2722:	48 89 de             	mov    %rbx,%rsi
    2725:	31 d2                	xor    %edx,%edx
    2727:	e8 84 f9 ff ff       	call   20b0 <sigaction@plt>
    272c:	bf 07 00 00 00       	mov    $0x7,%edi
    2731:	48 89 de             	mov    %rbx,%rsi
    2734:	31 d2                	xor    %edx,%edx
    2736:	e8 75 f9 ff ff       	call   20b0 <sigaction@plt>
    273b:	48 8b 1d 66 ca 00 00 	mov    0xca66(%rip),%rbx        # f1a8 <fwp_gc>
    2742:	80 3d 47 e5 01 00 00 	cmpb   $0x0,0x1e547(%rip)        # 20c90 <caf0.st>
    2749:	48 89 d8             	mov    %rbx,%rax
    274c:	0f 85 12 06 00 00    	jne    2d64 <fwp_main_thread+0x7c4>
    2752:	48 8b 05 27 c6 00 00 	mov    0xc627(%rip),%rax        # ed80 <d2_v1+0x18>
    2759:	48 89 85 30 fe ff ff 	mov    %rax,-0x1d0(%rbp)
    2760:	0f 10 05 09 c6 00 00 	movups 0xc609(%rip),%xmm0        # ed70 <d2_v1+0x8>
    2767:	0f 29 85 20 fe ff ff 	movaps %xmm0,-0x1e0(%rbp)
    276e:	66 0f 10 05 12 c6 00 	movupd 0xc612(%rip),%xmm0        # ed88 <d2_v1+0x20>
    2775:	00 
    2776:	66 0f 29 85 c0 fe ff 	movapd %xmm0,-0x140(%rbp)
    277d:	ff 
    277e:	48 8b 05 e3 e4 00 00 	mov    0xe4e3(%rip),%rax        # 10c68 <fwp_cleanups>
    2785:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
    2789:	48 8d 05 70 85 00 00 	lea    0x8570(%rip),%rax        # ad00 <fwp_owner_release0>
    2790:	48 89 45 d0          	mov    %rax,-0x30(%rbp)
    2794:	48 8d 85 c0 fe ff ff 	lea    -0x140(%rbp),%rax
    279b:	48 89 45 d8          	mov    %rax,-0x28(%rbp)
    279f:	4c 89 35 c2 e4 00 00 	mov    %r14,0xe4c2(%rip)        # 10c68 <fwp_cleanups>
    27a6:	48 8d 35 33 e4 00 00 	lea    0xe433(%rip),%rsi        # 10be0 <s0>
    27ad:	48 8d bd 20 fe ff ff 	lea    -0x1e0(%rbp),%rdi
    27b4:	e8 d7 10 00 00       	call   3890 <fwp_p_attempt_owned>
    27b9:	4c 39 35 a8 e4 00 00 	cmp    %r14,0xe4a8(%rip)        # 10c68 <fwp_cleanups>
    27c0:	0f 85 00 06 00 00    	jne    2dc6 <fwp_main_thread+0x826>
    27c6:	49 89 c7             	mov    %rax,%r15
    27c9:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
    27cd:	48 89 05 94 e4 00 00 	mov    %rax,0xe494(%rip)        # 10c68 <fwp_cleanups>
    27d4:	48 8d 85 20 fe ff ff 	lea    -0x1e0(%rbp),%rax
    27db:	48 8d 05 fe e3 00 00 	lea    0xe3fe(%rip),%rax        # 10be0 <s0>
    27e2:	48 8d 3d e7 e3 00 00 	lea    0xe3e7(%rip),%rdi        # 10bd0 <fc3>
    27e9:	e8 02 38 00 00       	call   5ff0 <fwp_closure_drop>
    27ee:	48 8d 3d e3 e3 00 00 	lea    0xe3e3(%rip),%rdi        # 10bd8 <fc4>
    27f5:	e8 f6 37 00 00       	call   5ff0 <fwp_closure_drop>
    27fa:	4c 89 7d a0          	mov    %r15,-0x60(%rbp)
    27fe:	48 8b 05 63 e4 00 00 	mov    0xe463(%rip),%rax        # 10c68 <fwp_cleanups>
    2805:	48 89 85 10 ff ff ff 	mov    %rax,-0xf0(%rbp)
    280c:	48 8d 05 0d 85 00 00 	lea    0x850d(%rip),%rax        # ad20 <fwp_owner_release1>
    2813:	48 89 85 18 ff ff ff 	mov    %rax,-0xe8(%rbp)
    281a:	48 8d 45 a0          	lea    -0x60(%rbp),%rax
    281e:	48 89 85 20 ff ff ff 	mov    %rax,-0xe0(%rbp)
    2825:	4c 89 25 3c e4 00 00 	mov    %r12,0xe43c(%rip)        # 10c68 <fwp_cleanups>
    282c:	4c 89 ff             	mov    %r15,%rdi
    282f:	e8 6c 80 00 00       	call   a8a0 <f8>
    2834:	4c 39 25 2d e4 00 00 	cmp    %r12,0xe42d(%rip)        # 10c68 <fwp_cleanups>
    283b:	0f 85 85 05 00 00    	jne    2dc6 <fwp_main_thread+0x826>
    2841:	49 89 c6             	mov    %rax,%r14
    2844:	48 8b 85 10 ff ff ff 	mov    -0xf0(%rbp),%rax
    284b:	48 89 05 16 e4 00 00 	mov    %rax,0xe416(%rip)        # 10c68 <fwp_cleanups>
    2852:	4c 89 ff             	mov    %r15,%rdi
    2855:	e8 d6 84 00 00       	call   ad30 <fwp_drop2>
    285a:	4c 89 75 a8          	mov    %r14,-0x58(%rbp)
    285e:	48 8b 05 03 e4 00 00 	mov    0xe403(%rip),%rax        # 10c68 <fwp_cleanups>
    2865:	48 89 85 28 ff ff ff 	mov    %rax,-0xd8(%rbp)
    286c:	48 8d 05 2d 86 00 00 	lea    0x862d(%rip),%rax        # aea0 <fwp_owner_release2>
    2873:	48 89 85 30 ff ff ff 	mov    %rax,-0xd0(%rbp)
    287a:	48 8d 45 a8          	lea    -0x58(%rbp),%rax
    287e:	48 89 85 38 ff ff ff 	mov    %rax,-0xc8(%rbp)
    2885:	4c 8d bd 28 ff ff ff 	lea    -0xd8(%rbp),%r15
    288c:	4c 89 3d d5 e3 00 00 	mov    %r15,0xe3d5(%rip)        # 10c68 <fwp_cleanups>
    2893:	4c 89 f7             	mov    %r14,%rdi
    2896:	48 83 c7 08          	add    $0x8,%rdi
    289a:	49 8b 16             	mov    (%r14),%rdx
    289d:	48 8b 0d a4 e3 00 00 	mov    0xe3a4(%rip),%rcx        # 10c48 <fwp_prog_out>
    28a4:	be 01 00 00 00       	mov    $0x1,%esi
    28a9:	e8 32 fa ff ff       	call   22e0 <fwrite@plt>
    28ae:	48 8b 35 93 e3 00 00 	mov    0xe393(%rip),%rsi        # 10c48 <fwp_prog_out>
    28b5:	bf 0a 00 00 00       	mov    $0xa,%edi
    28ba:	e8 b1 f8 ff ff       	call   2170 <fputc@plt>
    28bf:	4c 39 3d a2 e3 00 00 	cmp    %r15,0xe3a2(%rip)        # 10c68 <fwp_cleanups>
    28c6:	0f 85 fa 04 00 00    	jne    2dc6 <fwp_main_thread+0x826>
    28cc:	48 8b 85 28 ff ff ff 	mov    -0xd8(%rbp),%rax
    28d3:	48 89 05 8e e3 00 00 	mov    %rax,0xe38e(%rip)        # 10c68 <fwp_cleanups>
    28da:	4c 89 f0             	mov    %r14,%rax
    28dd:	48 2b 05 f4 d8 00 00 	sub    0xd8f4(%rip),%rax        # 101d8 <fwp_gc+0x1030>
    28e4:	48 8b 0d 15 d9 00 00 	mov    0xd915(%rip),%rcx        # 10200 <fwp_gc+0x1058>
    28eb:	48 c1 e1 10          	shl    $0x10,%rcx
    28ef:	48 39 c8             	cmp    %rcx,%rax
    28f2:	73 7a                	jae    296e <fwp_main_thread+0x3ce>
    28f4:	48 8b 0d 25 d9 00 00 	mov    0xd925(%rip),%rcx        # 10220 <fwp_gc+0x1078>
    28fb:	48 89 c2             	mov    %rax,%rdx
    28fe:	48 c1 ea 10          	shr    $0x10,%rdx
    2902:	48 69 d2 28 12 00 00 	imul   $0x1228,%rdx,%rdx
    2909:	0f b6 34 11          	movzbl (%rcx,%rdx,1),%esi
    290d:	48 25 ff ff 00 00    	and    $0xffff,%rax
    2913:	75 13                	jne    2928 <fwp_main_thread+0x388>
    2915:	40 80 fe 02          	cmp    $0x2,%sil
    2919:	75 0d                	jne    2928 <fwp_main_thread+0x388>
    291b:	48 8d 3c 11          	lea    (%rcx,%rdx,1),%rdi
    291f:	48 81 c7 28 02 00 00 	add    $0x228,%rdi
    2926:	eb 21                	jmp    2949 <fwp_main_thread+0x3a9>
    2928:	40 80 fe 01          	cmp    $0x1,%sil
    292c:	75 40                	jne    296e <fwp_main_thread+0x3ce>
    292e:	48 8d 34 11          	lea    (%rcx,%rdx,1),%rsi
    2932:	8b 4c 11 20          	mov    0x20(%rcx,%rdx,1),%ecx
    2936:	48 0f af c1          	imul   %rcx,%rax
    293a:	48 c1 e8 20          	shr    $0x20,%rax
    293e:	48 8d 3c 30          	lea    (%rax,%rsi,1),%rdi
    2942:	48 81 c7 28 02 00 00 	add    $0x228,%rdi
    2949:	0f b6 07             	movzbl (%rdi),%eax
    294c:	85 c0                	test   %eax,%eax
    294e:	74 1e                	je     296e <fwp_main_thread+0x3ce>
    2950:	83 f8 01             	cmp    $0x1,%eax
    2953:	75 0a                	jne    295f <fwp_main_thread+0x3bf>
    2955:	4c 89 f7             	mov    %r14,%rdi
    2958:	e8 b3 3b 00 00       	call   6510 <fwp_rc_free_obj>
    295d:	eb 0f                	jmp    296e <fwp_main_thread+0x3ce>
    295f:	3d ff 00 00 00       	cmp    $0xff,%eax
    2964:	0f 84 48 04 00 00    	je     2db2 <fwp_main_thread+0x812>
    296a:	fe c8                	dec    %al
    296c:	88 07                	mov    %al,(%rdi)
    296e:	48 8b 05 33 c4 00 00 	mov    0xc433(%rip),%rax        # eda8 <d2_v1+0x40>
    2975:	48 89 85 00 ff ff ff 	mov    %rax,-0x100(%rbp)
    297c:	0f 10 05 15 c4 00 00 	movups 0xc415(%rip),%xmm0        # ed98 <d2_v1+0x30>
    2983:	0f 29 85 f0 fe ff ff 	movaps %xmm0,-0x110(%rbp)
    298a:	66 0f 10 05 1e c4 00 	movupd 0xc41e(%rip),%xmm0        # edb0 <d2_v1+0x48>
    2991:	00 
    2992:	66 0f 29 85 d0 fe ff 	movapd %xmm0,-0x130(%rbp)
    2999:	ff 
    299a:	48 8b 05 c7 e2 00 00 	mov    0xe2c7(%rip),%rax        # 10c68 <fwp_cleanups>
    29a1:	48 89 85 40 ff ff ff 	mov    %rax,-0xc0(%rbp)
    29a8:	48 8d 05 91 85 00 00 	lea    0x8591(%rip),%rax        # af40 <fwp_owner_release3>
    29af:	48 89 85 48 ff ff ff 	mov    %rax,-0xb8(%rbp)
    29b6:	48 8d 85 d0 fe ff ff 	lea    -0x130(%rbp),%rax
    29bd:	48 89 85 50 ff ff ff 	mov    %rax,-0xb0(%rbp)
    29c4:	4c 8d b5 40 ff ff ff 	lea    -0xc0(%rbp),%r14
    29cb:	4c 89 35 96 e2 00 00 	mov    %r14,0xe296(%rip)        # 10c68 <fwp_cleanups>
    29d2:	48 8d 35 2f e2 00 00 	lea    0xe22f(%rip),%rsi        # 10c08 <s1>
    29d9:	48 8d bd f0 fe ff ff 	lea    -0x110(%rbp),%rdi
    29e0:	e8 ab 0e 00 00       	call   3890 <fwp_p_attempt_owned>
    29e5:	4c 39 35 7c e2 00 00 	cmp    %r14,0xe27c(%rip)        # 10c68 <fwp_cleanups>
    29ec:	0f 85 d4 03 00 00    	jne    2dc6 <fwp_main_thread+0x826>
    29f2:	49 89 c7             	mov    %rax,%r15
    29f5:	48 8b 85 40 ff ff ff 	mov    -0xc0(%rbp),%rax
    29fc:	48 89 05 65 e2 00 00 	mov    %rax,0xe265(%rip)        # 10c68 <fwp_cleanups>
    2a03:	48 8d 85 f0 fe ff ff 	lea    -0x110(%rbp),%rax
    2a0a:	48 8d 05 f7 e1 00 00 	lea    0xe1f7(%rip),%rax        # 10c08 <s1>
    2a11:	48 8d 3d b8 e1 00 00 	lea    0xe1b8(%rip),%rdi        # 10bd0 <fc3>
    2a18:	e8 d3 35 00 00       	call   5ff0 <fwp_closure_drop>
    2a1d:	48 8d 3d b4 e1 00 00 	lea    0xe1b4(%rip),%rdi        # 10bd8 <fc4>
    2a24:	e8 c7 35 00 00       	call   5ff0 <fwp_closure_drop>
    2a29:	4c 89 7d b0          	mov    %r15,-0x50(%rbp)
    2a2d:	48 8b 05 34 e2 00 00 	mov    0xe234(%rip),%rax        # 10c68 <fwp_cleanups>
    2a34:	48 89 85 58 ff ff ff 	mov    %rax,-0xa8(%rbp)
    2a3b:	48 8d 05 1e 85 00 00 	lea    0x851e(%rip),%rax        # af60 <fwp_owner_release4>
    2a42:	48 89 85 60 ff ff ff 	mov    %rax,-0xa0(%rbp)
    2a49:	48 8d 45 b0          	lea    -0x50(%rbp),%rax
    2a4d:	48 89 85 68 ff ff ff 	mov    %rax,-0x98(%rbp)
    2a54:	4c 8d a5 58 ff ff ff 	lea    -0xa8(%rbp),%r12
    2a5b:	4c 89 25 06 e2 00 00 	mov    %r12,0xe206(%rip)        # 10c68 <fwp_cleanups>
    2a62:	4c 89 ff             	mov    %r15,%rdi
    2a65:	e8 36 7e 00 00       	call   a8a0 <f8>
    2a6a:	4c 39 25 f7 e1 00 00 	cmp    %r12,0xe1f7(%rip)        # 10c68 <fwp_cleanups>
    2a71:	0f 85 4f 03 00 00    	jne    2dc6 <fwp_main_thread+0x826>
    2a77:	49 89 c6             	mov    %rax,%r14
    2a7a:	48 8b 85 58 ff ff ff 	mov    -0xa8(%rbp),%rax
    2a81:	48 89 05 e0 e1 00 00 	mov    %rax,0xe1e0(%rip)        # 10c68 <fwp_cleanups>
    2a88:	4c 89 ff             	mov    %r15,%rdi
    2a8b:	e8 a0 82 00 00       	call   ad30 <fwp_drop2>
    2a90:	4c 89 75 b8          	mov    %r14,-0x48(%rbp)
    2a94:	48 8b 05 cd e1 00 00 	mov    0xe1cd(%rip),%rax        # 10c68 <fwp_cleanups>
    2a9b:	48 89 85 70 ff ff ff 	mov    %rax,-0x90(%rbp)
    2aa2:	48 8d 05 c7 84 00 00 	lea    0x84c7(%rip),%rax        # af70 <fwp_owner_release5>
    2aa9:	48 89 85 78 ff ff ff 	mov    %rax,-0x88(%rbp)
    2ab0:	48 8d 45 b8          	lea    -0x48(%rbp),%rax
    2ab4:	48 89 45 80          	mov    %rax,-0x80(%rbp)
    2ab8:	4c 8d bd 70 ff ff ff 	lea    -0x90(%rbp),%r15
    2abf:	4c 89 3d a2 e1 00 00 	mov    %r15,0xe1a2(%rip)        # 10c68 <fwp_cleanups>
    2ac6:	4c 89 f7             	mov    %r14,%rdi
    2ac9:	48 83 c7 08          	add    $0x8,%rdi
    2acd:	49 8b 16             	mov    (%r14),%rdx
    2ad0:	48 8b 0d 71 e1 00 00 	mov    0xe171(%rip),%rcx        # 10c48 <fwp_prog_out>
    2ad7:	be 01 00 00 00       	mov    $0x1,%esi
    2adc:	e8 ff f7 ff ff       	call   22e0 <fwrite@plt>
    2ae1:	48 8b 35 60 e1 00 00 	mov    0xe160(%rip),%rsi        # 10c48 <fwp_prog_out>
    2ae8:	bf 0a 00 00 00       	mov    $0xa,%edi
    2aed:	e8 7e f6 ff ff       	call   2170 <fputc@plt>
    2af2:	4c 39 3d 6f e1 00 00 	cmp    %r15,0xe16f(%rip)        # 10c68 <fwp_cleanups>
    2af9:	0f 85 c7 02 00 00    	jne    2dc6 <fwp_main_thread+0x826>
    2aff:	48 8b 85 70 ff ff ff 	mov    -0x90(%rbp),%rax
    2b06:	48 89 05 5b e1 00 00 	mov    %rax,0xe15b(%rip)        # 10c68 <fwp_cleanups>
    2b0d:	4c 89 f0             	mov    %r14,%rax
    2b10:	48 2b 05 c1 d6 00 00 	sub    0xd6c1(%rip),%rax        # 101d8 <fwp_gc+0x1030>
    2b17:	48 8b 0d e2 d6 00 00 	mov    0xd6e2(%rip),%rcx        # 10200 <fwp_gc+0x1058>
    2b1e:	48 c1 e1 10          	shl    $0x10,%rcx
    2b22:	48 39 c8             	cmp    %rcx,%rax
    2b25:	73 7a                	jae    2ba1 <fwp_main_thread+0x601>
    2b27:	48 8b 0d f2 d6 00 00 	mov    0xd6f2(%rip),%rcx        # 10220 <fwp_gc+0x1078>
    2b2e:	48 89 c2             	mov    %rax,%rdx
    2b31:	48 c1 ea 10          	shr    $0x10,%rdx
    2b35:	48 69 d2 28 12 00 00 	imul   $0x1228,%rdx,%rdx
    2b3c:	0f b6 34 11          	movzbl (%rcx,%rdx,1),%esi
    2b40:	48 25 ff ff 00 00    	and    $0xffff,%rax
    2b46:	75 13                	jne    2b5b <fwp_main_thread+0x5bb>
    2b48:	40 80 fe 02          	cmp    $0x2,%sil
    2b4c:	75 0d                	jne    2b5b <fwp_main_thread+0x5bb>
    2b4e:	48 8d 3c 11          	lea    (%rcx,%rdx,1),%rdi
    2b52:	48 81 c7 28 02 00 00 	add    $0x228,%rdi
    2b59:	eb 21                	jmp    2b7c <fwp_main_thread+0x5dc>
    2b5b:	40 80 fe 01          	cmp    $0x1,%sil
    2b5f:	75 40                	jne    2ba1 <fwp_main_thread+0x601>
    2b61:	48 8d 34 11          	lea    (%rcx,%rdx,1),%rsi
    2b65:	8b 4c 11 20          	mov    0x20(%rcx,%rdx,1),%ecx
    2b69:	48 0f af c1          	imul   %rcx,%rax
    2b6d:	48 c1 e8 20          	shr    $0x20,%rax
    2b71:	48 8d 3c 30          	lea    (%rax,%rsi,1),%rdi
    2b75:	48 81 c7 28 02 00 00 	add    $0x228,%rdi
    2b7c:	0f b6 07             	movzbl (%rdi),%eax
    2b7f:	85 c0                	test   %eax,%eax
    2b81:	74 1e                	je     2ba1 <fwp_main_thread+0x601>
    2b83:	83 f8 01             	cmp    $0x1,%eax
    2b86:	75 0a                	jne    2b92 <fwp_main_thread+0x5f2>
    2b88:	4c 89 f7             	mov    %r14,%rdi
    2b8b:	e8 80 39 00 00       	call   6510 <fwp_rc_free_obj>
    2b90:	eb 0f                	jmp    2ba1 <fwp_main_thread+0x601>
    2b92:	3d ff 00 00 00       	cmp    $0xff,%eax
    2b97:	0f 84 1f 02 00 00    	je     2dbc <fwp_main_thread+0x81c>
    2b9d:	fe c8                	dec    %al
    2b9f:	88 07                	mov    %al,(%rdi)
    2ba1:	48 c7 45 c0 00 00 00 	movq   $0x0,-0x40(%rbp)
    2ba8:	00 
    2ba9:	48 8b 05 b8 e0 00 00 	mov    0xe0b8(%rip),%rax        # 10c68 <fwp_cleanups>
    2bb0:	48 89 45 88          	mov    %rax,-0x78(%rbp)
    2bb4:	48 8d 05 55 84 00 00 	lea    0x8455(%rip),%rax        # b010 <fwp_owner_release6>
    2bbb:	48 89 45 90          	mov    %rax,-0x70(%rbp)
    2bbf:	48 8d 45 c0          	lea    -0x40(%rbp),%rax
    2bc3:	48 89 45 98          	mov    %rax,-0x68(%rbp)
    2bc7:	4c 8d 7d 88          	lea    -0x78(%rbp),%r15
    2bcb:	4c 89 3d 96 e0 00 00 	mov    %r15,0xe096(%rip)        # 10c68 <fwp_cleanups>
    2bd2:	66 0f 57 c0          	xorpd  %xmm0,%xmm0
    2bd6:	66 0f 29 85 e0 fe ff 	movapd %xmm0,-0x120(%rbp)
    2bdd:	ff 
    2bde:	48 8d 95 e0 fe ff ff 	lea    -0x120(%rbp),%rdx
    2be5:	bf 01 00 00 00       	mov    $0x1,%edi
    2bea:	be 02 00 00 00       	mov    $0x2,%esi
    2bef:	e8 dc 15 00 00       	call   41d0 <fwp_data>
    2bf4:	48 89 c1             	mov    %rax,%rcx
    2bf7:	48 2b 0d da d5 00 00 	sub    0xd5da(%rip),%rcx        # 101d8 <fwp_gc+0x1030>
    2bfe:	48 8b 15 fb d5 00 00 	mov    0xd5fb(%rip),%rdx        # 10200 <fwp_gc+0x1058>
    2c05:	48 c1 e2 10          	shl    $0x10,%rdx
    2c09:	48 39 d1             	cmp    %rdx,%rcx
    2c0c:	73 76                	jae    2c84 <fwp_main_thread+0x6e4>
    2c0e:	48 8b 15 0b d6 00 00 	mov    0xd60b(%rip),%rdx        # 10220 <fwp_gc+0x1078>
    2c15:	48 89 ce             	mov    %rcx,%rsi
    2c18:	48 c1 ee 10          	shr    $0x10,%rsi
    2c1c:	48 69 f6 28 12 00 00 	imul   $0x1228,%rsi,%rsi
    2c23:	0f b6 3c 32          	movzbl (%rdx,%rsi,1),%edi
    2c27:	48 81 e1 ff ff 00 00 	and    $0xffff,%rcx
    2c2e:	75 1d                	jne    2c4d <fwp_main_thread+0x6ad>
    2c30:	40 80 ff 02          	cmp    $0x2,%dil
    2c34:	75 17                	jne    2c4d <fwp_main_thread+0x6ad>
    2c36:	4c 8d 34 32          	lea    (%rdx,%rsi,1),%r14
    2c3a:	49 81 c6 28 02 00 00 	add    $0x228,%r14
    2c41:	41 80 3e ff          	cmpb   $0xff,(%r14)
    2c45:	74 2d                	je     2c74 <fwp_main_thread+0x6d4>
    2c47:	41 c6 06 01          	movb   $0x1,(%r14)
    2c4b:	eb 37                	jmp    2c84 <fwp_main_thread+0x6e4>
    2c4d:	40 80 ff 01          	cmp    $0x1,%dil
    2c51:	75 31                	jne    2c84 <fwp_main_thread+0x6e4>
    2c53:	48 8d 3c 32          	lea    (%rdx,%rsi,1),%rdi
    2c57:	8b 54 32 20          	mov    0x20(%rdx,%rsi,1),%edx
    2c5b:	48 0f af ca          	imul   %rdx,%rcx
    2c5f:	48 c1 e9 20          	shr    $0x20,%rcx
    2c63:	4c 8d 34 39          	lea    (%rcx,%rdi,1),%r14
    2c67:	49 81 c6 28 02 00 00 	add    $0x228,%r14
    2c6e:	41 80 3e ff          	cmpb   $0xff,(%r14)
    2c72:	75 d3                	jne    2c47 <fwp_main_thread+0x6a7>
    2c74:	4c 89 f7             	mov    %r14,%rdi
    2c77:	49 89 c4             	mov    %rax,%r12
    2c7a:	e8 61 0b 00 00       	call   37e0 <fwp_rc_forget_slot>
    2c7f:	4c 89 e0             	mov    %r12,%rax
    2c82:	eb c3                	jmp    2c47 <fwp_main_thread+0x6a7>
    2c84:	4c 39 3d dd df 00 00 	cmp    %r15,0xdfdd(%rip)        # 10c68 <fwp_cleanups>
    2c8b:	0f 85 35 01 00 00    	jne    2dc6 <fwp_main_thread+0x826>
    2c91:	48 8b 4d 88          	mov    -0x78(%rbp),%rcx
    2c95:	48 89 0d cc df 00 00 	mov    %rcx,0xdfcc(%rip)        # 10c68 <fwp_cleanups>
    2c9c:	48 89 c1             	mov    %rax,%rcx
    2c9f:	48 2b 0d 32 d5 00 00 	sub    0xd532(%rip),%rcx        # 101d8 <fwp_gc+0x1030>
    2ca6:	48 8b 15 53 d5 00 00 	mov    0xd553(%rip),%rdx        # 10200 <fwp_gc+0x1058>
    2cad:	48 c1 e2 10          	shl    $0x10,%rdx
    2cb1:	48 39 d1             	cmp    %rdx,%rcx
    2cb4:	0f 83 9c 00 00 00    	jae    2d56 <fwp_main_thread+0x7b6>
    2cba:	48 8b 15 5f d5 00 00 	mov    0xd55f(%rip),%rdx        # 10220 <fwp_gc+0x1078>
    2cc1:	48 89 ce             	mov    %rcx,%rsi
    2cc4:	48 c1 ee 10          	shr    $0x10,%rsi
    2cc8:	48 69 f6 28 12 00 00 	imul   $0x1228,%rsi,%rsi
    2ccf:	0f b6 3c 32          	movzbl (%rdx,%rsi,1),%edi
    2cd3:	48 81 e1 ff ff 00 00 	and    $0xffff,%rcx
    2cda:	75 13                	jne    2cef <fwp_main_thread+0x74f>
    2cdc:	40 80 ff 02          	cmp    $0x2,%dil
    2ce0:	75 0d                	jne    2cef <fwp_main_thread+0x74f>
    2ce2:	48 8d 3c 32          	lea    (%rdx,%rsi,1),%rdi
    2ce6:	48 81 c7 28 02 00 00 	add    $0x228,%rdi
    2ced:	eb 20                	jmp    2d0f <fwp_main_thread+0x76f>
    2cef:	40 80 ff 01          	cmp    $0x1,%dil
    2cf3:	75 61                	jne    2d56 <fwp_main_thread+0x7b6>
    2cf5:	48 8d 3c 32          	lea    (%rdx,%rsi,1),%rdi
    2cf9:	8b 54 32 20          	mov    0x20(%rdx,%rsi,1),%edx
    2cfd:	48 0f af ca          	imul   %rdx,%rcx
    2d01:	48 c1 e9 20          	shr    $0x20,%rcx
    2d05:	48 01 cf             	add    %rcx,%rdi
    2d08:	48 81 c7 28 02 00 00 	add    $0x228,%rdi
    2d0f:	0f b6 0f             	movzbl (%rdi),%ecx
    2d12:	85 c9                	test   %ecx,%ecx
    2d14:	74 40                	je     2d56 <fwp_main_thread+0x7b6>
    2d16:	83 f9 01             	cmp    $0x1,%ecx
    2d19:	75 2f                	jne    2d4a <fwp_main_thread+0x7aa>
    2d1b:	4c 8b 70 10          	mov    0x10(%rax),%r14
    2d1f:	48 89 c7             	mov    %rax,%rdi
    2d22:	e8 e9 37 00 00       	call   6510 <fwp_rc_free_obj>
    2d27:	4c 89 f1             	mov    %r14,%rcx
    2d2a:	48 2b 0d a7 d4 00 00 	sub    0xd4a7(%rip),%rcx        # 101d8 <fwp_gc+0x1030>
    2d31:	48 8b 15 c8 d4 00 00 	mov    0xd4c8(%rip),%rdx        # 10200 <fwp_gc+0x1058>
    2d38:	48 c1 e2 10          	shl    $0x10,%rdx
    2d3c:	4c 89 f0             	mov    %r14,%rax
    2d3f:	48 39 d1             	cmp    %rdx,%rcx
    2d42:	0f 82 72 ff ff ff    	jb     2cba <fwp_main_thread+0x71a>
    2d48:	eb 0c                	jmp    2d56 <fwp_main_thread+0x7b6>
    2d4a:	81 f9 ff 00 00 00    	cmp    $0xff,%ecx
    2d50:	74 59                	je     2dab <fwp_main_thread+0x80b>
    2d52:	fe c9                	dec    %cl
    2d54:	88 0f                	mov    %cl,(%rdi)
    2d56:	c6 05 33 df 01 00 01 	movb   $0x1,0x1df33(%rip)        # 20c90 <caf0.st>
    2d5d:	48 8b 05 44 c4 00 00 	mov    0xc444(%rip),%rax        # f1a8 <fwp_gc>
    2d64:	48 83 3d 14 d6 00 00 	cmpq   $0x0,0xd614(%rip)        # 10380 <fwp_gc+0x11d8>
    2d6b:	00 
    2d6c:	75 5d                	jne    2dcb <fwp_main_thread+0x82b>
    2d6e:	83 3d 23 d4 00 00 00 	cmpl   $0x0,0xd423(%rip)        # 10198 <fwp_gc+0xff0>
    2d75:	75 54                	jne    2dcb <fwp_main_thread+0x82b>
    2d77:	48 39 c3             	cmp    %rax,%rbx
    2d7a:	7f 4f                	jg     2dcb <fwp_main_thread+0x82b>
    2d7c:	66 0f 57 c0          	xorpd  %xmm0,%xmm0
    2d80:	66 0f 2e 05 28 d6 00 	ucomisd 0xd628(%rip),%xmm0        # 103b0 <fwp_gc+0x1208>
    2d87:	00 
    2d88:	73 41                	jae    2dcb <fwp_main_thread+0x82b>
    2d8a:	48 8b 05 2f c2 00 00 	mov    0xc22f(%rip),%rax        # efc0 <stdout@GLIBC_2.2.5>
    2d91:	48 8b 38             	mov    (%rax),%rdi
    2d94:	e8 97 f4 ff ff       	call   2230 <fflush@plt>
    2d99:	31 c0                	xor    %eax,%eax
    2d9b:	48 81 c4 c0 01 00 00 	add    $0x1c0,%rsp
    2da2:	5b                   	pop    %rbx
    2da3:	41 5c                	pop    %r12
    2da5:	41 5e                	pop    %r14
    2da7:	41 5f                	pop    %r15
    2da9:	5d                   	pop    %rbp
    2daa:	c3                   	ret
    2dab:	e8 50 35 00 00       	call   6300 <fwp_rc_wide_drop>
    2db0:	eb a4                	jmp    2d56 <fwp_main_thread+0x7b6>
    2db2:	e8 49 35 00 00       	call   6300 <fwp_rc_wide_drop>
    2db7:	e9 b2 fb ff ff       	jmp    296e <fwp_main_thread+0x3ce>
    2dbc:	e8 3f 35 00 00       	call   6300 <fwp_rc_wide_drop>
    2dc1:	e9 db fd ff ff       	jmp    2ba1 <fwp_main_thread+0x601>
    2dc6:	e8 95 f2 ff ff       	call   2060 <abort@plt>
    2dcb:	48 8b 0d 0e c2 00 00 	mov    0xc20e(%rip),%rcx        # efe0 <stderr@GLIBC_2.2.5>
    2dd2:	48 8b 39             	mov    (%rcx),%rdi
    2dd5:	48 29 c3             	sub    %rax,%rbx
    2dd8:	48 8d 35 77 98 00 00 	lea    0x9877(%rip),%rsi        # c656 <fwp_segv.msg+0x416>
    2ddf:	48 89 da             	mov    %rbx,%rdx
    2de2:	31 c0                	xor    %eax,%eax
    2de4:	e8 f7 f3 ff ff       	call   21e0 <fprintf@plt>
    2de9:	bf c1 00 00 00       	mov    $0xc1,%edi
    2dee:	e8 dd f4 ff ff       	call   22d0 <exit@plt>
    2df3:	66 66 66 66 2e 0f 1f 	data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    2dfa:	84 00 00 00 00 00 

0000000000002e00 <e1>:
    2e00:	50                   	push   %rax
    2e01:	48 89 f8             	mov    %rdi,%rax
    2e04:	48 8b 3f             	mov    (%rdi),%rdi
    2e07:	48 8b 0d ca d3 00 00 	mov    0xd3ca(%rip),%rcx        # 101d8 <fwp_gc+0x1030>
    2e0e:	48 89 fe             	mov    %rdi,%rsi
    2e11:	48 29 ce             	sub    %rcx,%rsi
    2e14:	48 8b 15 e5 d3 00 00 	mov    0xd3e5(%rip),%rdx        # 10200 <fwp_gc+0x1058>
    2e1b:	48 c1 e2 10          	shl    $0x10,%rdx
    2e1f:	48 39 d6             	cmp    %rdx,%rsi
    2e22:	73 68                	jae    2e8c <e1+0x8c>
    2e24:	4c 8b 05 f5 d3 00 00 	mov    0xd3f5(%rip),%r8        # 10220 <fwp_gc+0x1078>
    2e2b:	49 89 f1             	mov    %rsi,%r9
    2e2e:	49 c1 e9 10          	shr    $0x10,%r9
    2e32:	4d 69 c9 28 12 00 00 	imul   $0x1228,%r9,%r9
    2e39:	47 0f b6 14 08       	movzbl (%r8,%r9,1),%r10d
    2e3e:	48 81 e6 ff ff 00 00 	and    $0xffff,%rsi
    2e45:	75 1b                	jne    2e62 <e1+0x62>
    2e47:	41 80 fa 02          	cmp    $0x2,%r10b
    2e4b:	75 15                	jne    2e62 <e1+0x62>
    2e4d:	4b 8d 34 08          	lea    (%r8,%r9,1),%rsi
    2e51:	48 81 c6 28 02 00 00 	add    $0x228,%rsi
    2e58:	80 3e 00             	cmpb   $0x0,(%rsi)
    2e5b:	74 2f                	je     2e8c <e1+0x8c>
    2e5d:	e9 1d 01 00 00       	jmp    2f7f <e1+0x17f>
    2e62:	41 80 fa 01          	cmp    $0x1,%r10b
    2e66:	75 24                	jne    2e8c <e1+0x8c>
    2e68:	4f 8d 14 08          	lea    (%r8,%r9,1),%r10
    2e6c:	47 8b 44 08 20       	mov    0x20(%r8,%r9,1),%r8d
    2e71:	49 0f af f0          	imul   %r8,%rsi
    2e75:	48 c1 ee 20          	shr    $0x20,%rsi
    2e79:	4c 01 d6             	add    %r10,%rsi
    2e7c:	48 81 c6 28 02 00 00 	add    $0x228,%rsi
    2e83:	80 3e 00             	cmpb   $0x0,(%rsi)
    2e86:	0f 85 f3 00 00 00    	jne    2f7f <e1+0x17f>
    2e8c:	48 8b 70 08          	mov    0x8(%rax),%rsi
    2e90:	48 89 f0             	mov    %rsi,%rax
    2e93:	48 29 c8             	sub    %rcx,%rax
    2e96:	48 39 d0             	cmp    %rdx,%rax
    2e99:	73 64                	jae    2eff <e1+0xff>
    2e9b:	48 8b 0d 7e d3 00 00 	mov    0xd37e(%rip),%rcx        # 10220 <fwp_gc+0x1078>
    2ea2:	48 89 c2             	mov    %rax,%rdx
    2ea5:	48 c1 ea 10          	shr    $0x10,%rdx
    2ea9:	48 69 d2 28 12 00 00 	imul   $0x1228,%rdx,%rdx
    2eb0:	44 0f b6 04 11       	movzbl (%rcx,%rdx,1),%r8d
    2eb5:	48 25 ff ff 00 00    	and    $0xffff,%rax
    2ebb:	75 1a                	jne    2ed7 <e1+0xd7>
    2ebd:	41 80 f8 02          	cmp    $0x2,%r8b
    2ec1:	75 14                	jne    2ed7 <e1+0xd7>
    2ec3:	48 8d 04 11          	lea    (%rcx,%rdx,1),%rax
    2ec7:	48 05 28 02 00 00    	add    $0x228,%rax
    2ecd:	80 38 00             	cmpb   $0x0,(%rax)
    2ed0:	74 2d                	je     2eff <e1+0xff>
    2ed2:	e9 a8 00 00 00       	jmp    2f7f <e1+0x17f>
    2ed7:	41 80 f8 01          	cmp    $0x1,%r8b
    2edb:	75 22                	jne    2eff <e1+0xff>
    2edd:	4c 8d 04 11          	lea    (%rcx,%rdx,1),%r8
    2ee1:	8b 4c 11 20          	mov    0x20(%rcx,%rdx,1),%ecx
    2ee5:	48 0f af c1          	imul   %rcx,%rax
    2ee9:	48 c1 e8 20          	shr    $0x20,%rax
    2eed:	4c 01 c0             	add    %r8,%rax
    2ef0:	48 05 28 02 00 00    	add    $0x228,%rax
    2ef6:	80 38 00             	cmpb   $0x0,(%rax)
    2ef9:	0f 85 80 00 00 00    	jne    2f7f <e1+0x17f>
    2eff:	e8 8c 09 00 00       	call   3890 <fwp_p_attempt_owned>
    2f04:	48 89 c1             	mov    %rax,%rcx
    2f07:	48 2b 0d ca d2 00 00 	sub    0xd2ca(%rip),%rcx        # 101d8 <fwp_gc+0x1030>
    2f0e:	48 8b 15 eb d2 00 00 	mov    0xd2eb(%rip),%rdx        # 10200 <fwp_gc+0x1058>
    2f15:	48 c1 e2 10          	shl    $0x10,%rdx
    2f19:	48 39 d1             	cmp    %rdx,%rcx
    2f1c:	73 5f                	jae    2f7d <e1+0x17d>
    2f1e:	48 8b 15 fb d2 00 00 	mov    0xd2fb(%rip),%rdx        # 10220 <fwp_gc+0x1078>
    2f25:	48 89 ce             	mov    %rcx,%rsi
    2f28:	48 c1 ee 10          	shr    $0x10,%rsi
    2f2c:	48 69 f6 28 12 00 00 	imul   $0x1228,%rsi,%rsi
    2f33:	0f b6 3c 32          	movzbl (%rdx,%rsi,1),%edi
    2f37:	48 81 e1 ff ff 00 00 	and    $0xffff,%rcx
    2f3e:	75 18                	jne    2f58 <e1+0x158>
    2f40:	40 80 ff 02          	cmp    $0x2,%dil
    2f44:	75 12                	jne    2f58 <e1+0x158>
    2f46:	48 8d 0c 32          	lea    (%rdx,%rsi,1),%rcx
    2f4a:	48 81 c1 28 02 00 00 	add    $0x228,%rcx
    2f51:	80 39 00             	cmpb   $0x0,(%rcx)
    2f54:	74 27                	je     2f7d <e1+0x17d>
    2f56:	eb 27                	jmp    2f7f <e1+0x17f>
    2f58:	40 80 ff 01          	cmp    $0x1,%dil
    2f5c:	75 1f                	jne    2f7d <e1+0x17d>
    2f5e:	48 8d 3c 32          	lea    (%rdx,%rsi,1),%rdi
    2f62:	8b 54 32 20          	mov    0x20(%rdx,%rsi,1),%edx
    2f66:	48 0f af ca          	imul   %rdx,%rcx
    2f6a:	48 c1 e9 20          	shr    $0x20,%rcx
    2f6e:	48 01 f9             	add    %rdi,%rcx
    2f71:	48 81 c1 28 02 00 00 	add    $0x228,%rcx
    2f78:	80 39 00             	cmpb   $0x0,(%rcx)
    2f7b:	75 02                	jne    2f7f <e1+0x17f>
    2f7d:	59                   	pop    %rcx
    2f7e:	c3                   	ret
    2f7f:	e8 2c 08 00 00       	call   37b0 <fwp_flush>
    2f84:	48 8b 05 55 c0 00 00 	mov    0xc055(%rip),%rax        # efe0 <stderr@GLIBC_2.2.5>
    2f8b:	48 8b 38             	mov    (%rax),%rdi
    2f8e:	48 8d 35 9f 93 00 00 	lea    0x939f(%rip),%rsi        # c334 <fwp_segv.msg+0xf4>
    2f95:	48 8d 15 6b 93 00 00 	lea    0x936b(%rip),%rdx        # c307 <fwp_segv.msg+0xc7>
    2f9c:	31 c0                	xor    %eax,%eax
    2f9e:	e8 3d f2 ff ff       	call   21e0 <fprintf@plt>
    2fa3:	bf 65 00 00 00       	mov    $0x65,%edi
    2fa8:	e8 23 f3 ff ff       	call   22d0 <exit@plt>
    2fad:	0f 1f 00             	nopl   (%rax)

0000000000002fb0 <e2>:
    2fb0:	48 83 ec 18          	sub    $0x18,%rsp
    2fb4:	48 89 f8             	mov    %rdi,%rax
    2fb7:	48 8b 3f             	mov    (%rdi),%rdi
    2fba:	48 8b 0d 17 d2 00 00 	mov    0xd217(%rip),%rcx        # 101d8 <fwp_gc+0x1030>
    2fc1:	48 89 fe             	mov    %rdi,%rsi
    2fc4:	48 29 ce             	sub    %rcx,%rsi
    2fc7:	48 8b 15 32 d2 00 00 	mov    0xd232(%rip),%rdx        # 10200 <fwp_gc+0x1058>
    2fce:	48 c1 e2 10          	shl    $0x10,%rdx
    2fd2:	48 39 d6             	cmp    %rdx,%rsi
    2fd5:	73 68                	jae    303f <e2+0x8f>
    2fd7:	4c 8b 05 42 d2 00 00 	mov    0xd242(%rip),%r8        # 10220 <fwp_gc+0x1078>
    2fde:	49 89 f1             	mov    %rsi,%r9
    2fe1:	49 c1 e9 10          	shr    $0x10,%r9
    2fe5:	4d 69 c9 28 12 00 00 	imul   $0x1228,%r9,%r9
    2fec:	47 0f b6 14 08       	movzbl (%r8,%r9,1),%r10d
    2ff1:	48 81 e6 ff ff 00 00 	and    $0xffff,%rsi
    2ff8:	75 1b                	jne    3015 <e2+0x65>
    2ffa:	41 80 fa 02          	cmp    $0x2,%r10b
    2ffe:	75 15                	jne    3015 <e2+0x65>
    3000:	4b 8d 34 08          	lea    (%r8,%r9,1),%rsi
    3004:	48 81 c6 28 02 00 00 	add    $0x228,%rsi
    300b:	80 3e 00             	cmpb   $0x0,(%rsi)
    300e:	74 2f                	je     303f <e2+0x8f>
    3010:	e9 b0 01 00 00       	jmp    31c5 <e2+0x215>
    3015:	41 80 fa 01          	cmp    $0x1,%r10b
    3019:	75 24                	jne    303f <e2+0x8f>
    301b:	4f 8d 14 08          	lea    (%r8,%r9,1),%r10
    301f:	47 8b 44 08 20       	mov    0x20(%r8,%r9,1),%r8d
    3024:	49 0f af f0          	imul   %r8,%rsi
    3028:	48 c1 ee 20          	shr    $0x20,%rsi
    302c:	4c 01 d6             	add    %r10,%rsi
    302f:	48 81 c6 28 02 00 00 	add    $0x228,%rsi
    3036:	80 3e 00             	cmpb   $0x0,(%rsi)
    3039:	0f 85 86 01 00 00    	jne    31c5 <e2+0x215>
    303f:	48 8b 70 08          	mov    0x8(%rax),%rsi
    3043:	49 89 f0             	mov    %rsi,%r8
    3046:	49 29 c8             	sub    %rcx,%r8
    3049:	49 39 d0             	cmp    %rdx,%r8
    304c:	73 6a                	jae    30b8 <e2+0x108>
    304e:	4c 8b 0d cb d1 00 00 	mov    0xd1cb(%rip),%r9        # 10220 <fwp_gc+0x1078>
    3055:	4d 89 c2             	mov    %r8,%r10
    3058:	49 c1 ea 10          	shr    $0x10,%r10
    305c:	4d 69 d2 28 12 00 00 	imul   $0x1228,%r10,%r10
    3063:	47 0f b6 1c 11       	movzbl (%r9,%r10,1),%r11d
    3068:	49 81 e0 ff ff 00 00 	and    $0xffff,%r8
    306f:	75 1c                	jne    308d <e2+0xdd>
    3071:	41 80 fb 02          	cmp    $0x2,%r11b
    3075:	75 16                	jne    308d <e2+0xdd>
    3077:	4f 8d 04 11          	lea    (%r9,%r10,1),%r8
    307b:	49 81 c0 28 02 00 00 	add    $0x228,%r8
    3082:	41 80 38 00          	cmpb   $0x0,(%r8)
    3086:	74 30                	je     30b8 <e2+0x108>
    3088:	e9 38 01 00 00       	jmp    31c5 <e2+0x215>
    308d:	41 80 fb 01          	cmp    $0x1,%r11b
    3091:	75 25                	jne    30b8 <e2+0x108>
    3093:	4f 8d 1c 11          	lea    (%r9,%r10,1),%r11
    3097:	47 8b 4c 11 20       	mov    0x20(%r9,%r10,1),%r9d
    309c:	4d 0f af c1          	imul   %r9,%r8
    30a0:	49 c1 e8 20          	shr    $0x20,%r8
    30a4:	4d 01 d8             	add    %r11,%r8
    30a7:	49 81 c0 28 02 00 00 	add    $0x228,%r8
    30ae:	41 80 38 00          	cmpb   $0x0,(%r8)
    30b2:	0f 85 0d 01 00 00    	jne    31c5 <e2+0x215>
    30b8:	48 8b 40 10          	mov    0x10(%rax),%rax
    30bc:	49 89 c0             	mov    %rax,%r8
    30bf:	49 29 c8             	sub    %rcx,%r8
    30c2:	49 39 d0             	cmp    %rdx,%r8
    30c5:	73 67                	jae    312e <e2+0x17e>
    30c7:	48 8b 0d 52 d1 00 00 	mov    0xd152(%rip),%rcx        # 10220 <fwp_gc+0x1078>
    30ce:	4c 89 c2             	mov    %r8,%rdx
    30d1:	48 c1 ea 10          	shr    $0x10,%rdx
    30d5:	48 69 d2 28 12 00 00 	imul   $0x1228,%rdx,%rdx
    30dc:	44 0f b6 0c 11       	movzbl (%rcx,%rdx,1),%r9d
    30e1:	49 81 e0 ff ff 00 00 	and    $0xffff,%r8
    30e8:	75 1a                	jne    3104 <e2+0x154>
    30ea:	41 80 f9 02          	cmp    $0x2,%r9b
    30ee:	75 14                	jne    3104 <e2+0x154>
    30f0:	48 01 d1             	add    %rdx,%rcx
    30f3:	48 81 c1 28 02 00 00 	add    $0x228,%rcx
    30fa:	80 39 00             	cmpb   $0x0,(%rcx)
    30fd:	74 2f                	je     312e <e2+0x17e>
    30ff:	e9 c1 00 00 00       	jmp    31c5 <e2+0x215>
    3104:	41 80 f9 01          	cmp    $0x1,%r9b
    3108:	75 24                	jne    312e <e2+0x17e>
    310a:	4c 8d 0c 11          	lea    (%rcx,%rdx,1),%r9
    310e:	8b 4c 11 20          	mov    0x20(%rcx,%rdx,1),%ecx
    3112:	4c 0f af c1          	imul   %rcx,%r8
    3116:	49 c1 e8 20          	shr    $0x20,%r8
    311a:	4b 8d 0c 08          	lea    (%r8,%r9,1),%rcx
    311e:	48 81 c1 28 02 00 00 	add    $0x228,%rcx
    3125:	80 39 00             	cmpb   $0x0,(%rcx)
    3128:	0f 85 97 00 00 00    	jne    31c5 <e2+0x215>
    312e:	48 89 44 24 08       	mov    %rax,0x8(%rsp)
    3133:	48 89 74 24 10       	mov    %rsi,0x10(%rsp)
    3138:	48 8d 54 24 08       	lea    0x8(%rsp),%rdx
    313d:	be 02 00 00 00       	mov    $0x2,%esi
    3142:	e8 79 18 00 00       	call   49c0 <fwp_apply_owned>
    3147:	48 89 c1             	mov    %rax,%rcx
    314a:	48 2b 0d 87 d0 00 00 	sub    0xd087(%rip),%rcx        # 101d8 <fwp_gc+0x1030>
    3151:	48 8b 15 a8 d0 00 00 	mov    0xd0a8(%rip),%rdx        # 10200 <fwp_gc+0x1058>
    3158:	48 c1 e2 10          	shl    $0x10,%rdx
    315c:	48 39 d1             	cmp    %rdx,%rcx
    315f:	73 5f                	jae    31c0 <e2+0x210>
    3161:	48 8b 15 b8 d0 00 00 	mov    0xd0b8(%rip),%rdx        # 10220 <fwp_gc+0x1078>
    3168:	48 89 ce             	mov    %rcx,%rsi
    316b:	48 c1 ee 10          	shr    $0x10,%rsi
    316f:	48 69 f6 28 12 00 00 	imul   $0x1228,%rsi,%rsi
    3176:	0f b6 3c 32          	movzbl (%rdx,%rsi,1),%edi
    317a:	48 81 e1 ff ff 00 00 	and    $0xffff,%rcx
    3181:	75 18                	jne    319b <e2+0x1eb>
    3183:	40 80 ff 02          	cmp    $0x2,%dil
    3187:	75 12                	jne    319b <e2+0x1eb>
    3189:	48 8d 0c 32          	lea    (%rdx,%rsi,1),%rcx
    318d:	48 81 c1 28 02 00 00 	add    $0x228,%rcx
    3194:	80 39 00             	cmpb   $0x0,(%rcx)
    3197:	74 27                	je     31c0 <e2+0x210>
    3199:	eb 2a                	jmp    31c5 <e2+0x215>
    319b:	40 80 ff 01          	cmp    $0x1,%dil
    319f:	75 1f                	jne    31c0 <e2+0x210>
    31a1:	48 8d 3c 32          	lea    (%rdx,%rsi,1),%rdi
    31a5:	8b 54 32 20          	mov    0x20(%rdx,%rsi,1),%edx
    31a9:	48 0f af ca          	imul   %rdx,%rcx
    31ad:	48 c1 e9 20          	shr    $0x20,%rcx
    31b1:	48 01 f9             	add    %rdi,%rcx
    31b4:	48 81 c1 28 02 00 00 	add    $0x228,%rcx
    31bb:	80 39 00             	cmpb   $0x0,(%rcx)
    31be:	75 05                	jne    31c5 <e2+0x215>
    31c0:	48 83 c4 18          	add    $0x18,%rsp
    31c4:	c3                   	ret
    31c5:	e8 e6 05 00 00       	call   37b0 <fwp_flush>
    31ca:	48 8b 05 0f be 00 00 	mov    0xbe0f(%rip),%rax        # efe0 <stderr@GLIBC_2.2.5>
    31d1:	48 8b 38             	mov    (%rax),%rdi
    31d4:	48 8d 35 59 91 00 00 	lea    0x9159(%rip),%rsi        # c334 <fwp_segv.msg+0xf4>
    31db:	48 8d 15 25 91 00 00 	lea    0x9125(%rip),%rdx        # c307 <fwp_segv.msg+0xc7>
    31e2:	31 c0                	xor    %eax,%eax
    31e4:	e8 f7 ef ff ff       	call   21e0 <fprintf@plt>
    31e9:	bf 65 00 00 00       	mov    $0x65,%edi
    31ee:	e8 dd f0 ff ff       	call   22d0 <exit@plt>
    31f3:	66 66 66 66 2e 0f 1f 	data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    31fa:	84 00 00 00 00 00 

0000000000003200 <e3>:
    3200:	50                   	push   %rax
    3201:	48 89 f8             	mov    %rdi,%rax
    3204:	48 8b 3f             	mov    (%rdi),%rdi
    3207:	48 8b 0d ca cf 00 00 	mov    0xcfca(%rip),%rcx        # 101d8 <fwp_gc+0x1030>
    320e:	48 89 fe             	mov    %rdi,%rsi
    3211:	48 29 ce             	sub    %rcx,%rsi
    3214:	48 8b 15 e5 cf 00 00 	mov    0xcfe5(%rip),%rdx        # 10200 <fwp_gc+0x1058>
    321b:	48 c1 e2 10          	shl    $0x10,%rdx
    321f:	48 39 d6             	cmp    %rdx,%rsi
    3222:	73 68                	jae    328c <e3+0x8c>
    3224:	4c 8b 05 f5 cf 00 00 	mov    0xcff5(%rip),%r8        # 10220 <fwp_gc+0x1078>
    322b:	49 89 f1             	mov    %rsi,%r9
    322e:	49 c1 e9 10          	shr    $0x10,%r9
    3232:	4d 69 c9 28 12 00 00 	imul   $0x1228,%r9,%r9
    3239:	47 0f b6 14 08       	movzbl (%r8,%r9,1),%r10d
    323e:	48 81 e6 ff ff 00 00 	and    $0xffff,%rsi
    3245:	75 1b                	jne    3262 <e3+0x62>
    3247:	41 80 fa 02          	cmp    $0x2,%r10b
    324b:	75 15                	jne    3262 <e3+0x62>
    324d:	4b 8d 34 08          	lea    (%r8,%r9,1),%rsi
    3251:	48 81 c6 28 02 00 00 	add    $0x228,%rsi
    3258:	80 3e 00             	cmpb   $0x0,(%rsi)
    325b:	74 2f                	je     328c <e3+0x8c>
    325d:	e9 1d 01 00 00       	jmp    337f <e3+0x17f>
    3262:	41 80 fa 01          	cmp    $0x1,%r10b
    3266:	75 24                	jne    328c <e3+0x8c>
    3268:	4f 8d 14 08          	lea    (%r8,%r9,1),%r10
    326c:	47 8b 44 08 20       	mov    0x20(%r8,%r9,1),%r8d
    3271:	49 0f af f0          	imul   %r8,%rsi
    3275:	48 c1 ee 20          	shr    $0x20,%rsi
    3279:	4c 01 d6             	add    %r10,%rsi
    327c:	48 81 c6 28 02 00 00 	add    $0x228,%rsi
    3283:	80 3e 00             	cmpb   $0x0,(%rsi)
    3286:	0f 85 f3 00 00 00    	jne    337f <e3+0x17f>
    328c:	48 8b 70 08          	mov    0x8(%rax),%rsi
    3290:	48 89 f0             	mov    %rsi,%rax
    3293:	48 29 c8             	sub    %rcx,%rax
    3296:	48 39 d0             	cmp    %rdx,%rax
    3299:	73 64                	jae    32ff <e3+0xff>
    329b:	48 8b 0d 7e cf 00 00 	mov    0xcf7e(%rip),%rcx        # 10220 <fwp_gc+0x1078>
    32a2:	48 89 c2             	mov    %rax,%rdx
    32a5:	48 c1 ea 10          	shr    $0x10,%rdx
    32a9:	48 69 d2 28 12 00 00 	imul   $0x1228,%rdx,%rdx
    32b0:	44 0f b6 04 11       	movzbl (%rcx,%rdx,1),%r8d
    32b5:	48 25 ff ff 00 00    	and    $0xffff,%rax
    32bb:	75 1a                	jne    32d7 <e3+0xd7>
    32bd:	41 80 f8 02          	cmp    $0x2,%r8b
    32c1:	75 14                	jne    32d7 <e3+0xd7>
    32c3:	48 8d 04 11          	lea    (%rcx,%rdx,1),%rax
    32c7:	48 05 28 02 00 00    	add    $0x228,%rax
    32cd:	80 38 00             	cmpb   $0x0,(%rax)
    32d0:	74 2d                	je     32ff <e3+0xff>
    32d2:	e9 a8 00 00 00       	jmp    337f <e3+0x17f>
    32d7:	41 80 f8 01          	cmp    $0x1,%r8b
    32db:	75 22                	jne    32ff <e3+0xff>
    32dd:	4c 8d 04 11          	lea    (%rcx,%rdx,1),%r8
    32e1:	8b 4c 11 20          	mov    0x20(%rcx,%rdx,1),%ecx
    32e5:	48 0f af c1          	imul   %rcx,%rax
    32e9:	48 c1 e8 20          	shr    $0x20,%rax
    32ed:	4c 01 c0             	add    %r8,%rax
    32f0:	48 05 28 02 00 00    	add    $0x228,%rax
    32f6:	80 38 00             	cmpb   $0x0,(%rax)
    32f9:	0f 85 80 00 00 00    	jne    337f <e3+0x17f>
    32ff:	e8 4c 3b 00 00       	call   6e50 <fwp_p_file_with_owned>
    3304:	48 89 c1             	mov    %rax,%rcx
    3307:	48 2b 0d ca ce 00 00 	sub    0xceca(%rip),%rcx        # 101d8 <fwp_gc+0x1030>
    330e:	48 8b 15 eb ce 00 00 	mov    0xceeb(%rip),%rdx        # 10200 <fwp_gc+0x1058>
    3315:	48 c1 e2 10          	shl    $0x10,%rdx
    3319:	48 39 d1             	cmp    %rdx,%rcx
    331c:	73 5f                	jae    337d <e3+0x17d>
    331e:	48 8b 15 fb ce 00 00 	mov    0xcefb(%rip),%rdx        # 10220 <fwp_gc+0x1078>
    3325:	48 89 ce             	mov    %rcx,%rsi
    3328:	48 c1 ee 10          	shr    $0x10,%rsi
    332c:	48 69 f6 28 12 00 00 	imul   $0x1228,%rsi,%rsi
    3333:	0f b6 3c 32          	movzbl (%rdx,%rsi,1),%edi
    3337:	48 81 e1 ff ff 00 00 	and    $0xffff,%rcx
    333e:	75 18                	jne    3358 <e3+0x158>
    3340:	40 80 ff 02          	cmp    $0x2,%dil
    3344:	75 12                	jne    3358 <e3+0x158>
    3346:	48 8d 0c 32          	lea    (%rdx,%rsi,1),%rcx
    334a:	48 81 c1 28 02 00 00 	add    $0x228,%rcx
    3351:	80 39 00             	cmpb   $0x0,(%rcx)
    3354:	74 27                	je     337d <e3+0x17d>
    3356:	eb 27                	jmp    337f <e3+0x17f>
    3358:	40 80 ff 01          	cmp    $0x1,%dil
    335c:	75 1f                	jne    337d <e3+0x17d>
    335e:	48 8d 3c 32          	lea    (%rdx,%rsi,1),%rdi
    3362:	8b 54 32 20          	mov    0x20(%rdx,%rsi,1),%edx
    3366:	48 0f af ca          	imul   %rdx,%rcx
    336a:	48 c1 e9 20          	shr    $0x20,%rcx
    336e:	48 01 f9             	add    %rdi,%rcx
    3371:	48 81 c1 28 02 00 00 	add    $0x228,%rcx
    3378:	80 39 00             	cmpb   $0x0,(%rcx)
    337b:	75 02                	jne    337f <e3+0x17f>
    337d:	59                   	pop    %rcx
    337e:	c3                   	ret
    337f:	e8 2c 04 00 00       	call   37b0 <fwp_flush>
    3384:	48 8b 05 55 bc 00 00 	mov    0xbc55(%rip),%rax        # efe0 <stderr@GLIBC_2.2.5>
    338b:	48 8b 38             	mov    (%rax),%rdi
    338e:	48 8d 35 9f 8f 00 00 	lea    0x8f9f(%rip),%rsi        # c334 <fwp_segv.msg+0xf4>
    3395:	48 8d 15 6b 8f 00 00 	lea    0x8f6b(%rip),%rdx        # c307 <fwp_segv.msg+0xc7>
    339c:	31 c0                	xor    %eax,%eax
    339e:	e8 3d ee ff ff       	call   21e0 <fprintf@plt>
    33a3:	bf 65 00 00 00       	mov    $0x65,%edi
    33a8:	e8 23 ef ff ff       	call   22d0 <exit@plt>
    33ad:	0f 1f 00             	nopl   (%rax)

00000000000033b0 <e4>:
    33b0:	50                   	push   %rax
    33b1:	48 8b 3f             	mov    (%rdi),%rdi
    33b4:	48 89 f8             	mov    %rdi,%rax
    33b7:	48 2b 05 1a ce 00 00 	sub    0xce1a(%rip),%rax        # 101d8 <fwp_gc+0x1030>
    33be:	48 8b 0d 3b ce 00 00 	mov    0xce3b(%rip),%rcx        # 10200 <fwp_gc+0x1058>
    33c5:	48 c1 e1 10          	shl    $0x10,%rcx
    33c9:	48 39 c8             	cmp    %rcx,%rax
    33cc:	73 63                	jae    3431 <e4+0x81>
    33ce:	48 8b 0d 4b ce 00 00 	mov    0xce4b(%rip),%rcx        # 10220 <fwp_gc+0x1078>
    33d5:	48 89 c2             	mov    %rax,%rdx
    33d8:	48 c1 ea 10          	shr    $0x10,%rdx
    33dc:	48 69 d2 28 12 00 00 	imul   $0x1228,%rdx,%rdx
    33e3:	0f b6 34 11          	movzbl (%rcx,%rdx,1),%esi
    33e7:	48 25 ff ff 00 00    	and    $0xffff,%rax
    33ed:	75 1a                	jne    3409 <e4+0x59>
    33ef:	40 80 fe 02          	cmp    $0x2,%sil
    33f3:	75 14                	jne    3409 <e4+0x59>
    33f5:	48 8d 04 11          	lea    (%rcx,%rdx,1),%rax
    33f9:	48 05 28 02 00 00    	add    $0x228,%rax
    33ff:	80 38 00             	cmpb   $0x0,(%rax)
    3402:	74 2d                	je     3431 <e4+0x81>
    3404:	e9 a8 00 00 00       	jmp    34b1 <e4+0x101>
    3409:	40 80 fe 01          	cmp    $0x1,%sil
    340d:	75 22                	jne    3431 <e4+0x81>
    340f:	48 8d 34 11          	lea    (%rcx,%rdx,1),%rsi
    3413:	8b 4c 11 20          	mov    0x20(%rcx,%rdx,1),%ecx
    3417:	48 0f af c1          	imul   %rcx,%rax
    341b:	48 c1 e8 20          	shr    $0x20,%rax
    341f:	48 01 f0             	add    %rsi,%rax
    3422:	48 05 28 02 00 00    	add    $0x228,%rax
    3428:	80 38 00             	cmpb   $0x0,(%rax)
    342b:	0f 85 80 00 00 00    	jne    34b1 <e4+0x101>
    3431:	e8 da 6c 00 00       	call   a110 <f4>
    3436:	48 89 c1             	mov    %rax,%rcx
    3439:	48 2b 0d 98 cd 00 00 	sub    0xcd98(%rip),%rcx        # 101d8 <fwp_gc+0x1030>
    3440:	48 8b 15 b9 cd 00 00 	mov    0xcdb9(%rip),%rdx        # 10200 <fwp_gc+0x1058>
    3447:	48 c1 e2 10          	shl    $0x10,%rdx
    344b:	48 39 d1             	cmp    %rdx,%rcx
    344e:	73 5f                	jae    34af <e4+0xff>
    3450:	48 8b 15 c9 cd 00 00 	mov    0xcdc9(%rip),%rdx        # 10220 <fwp_gc+0x1078>
    3457:	48 89 ce             	mov    %rcx,%rsi
    345a:	48 c1 ee 10          	shr    $0x10,%rsi
    345e:	48 69 f6 28 12 00 00 	imul   $0x1228,%rsi,%rsi
    3465:	0f b6 3c 32          	movzbl (%rdx,%rsi,1),%edi
    3469:	48 81 e1 ff ff 00 00 	and    $0xffff,%rcx
    3470:	75 18                	jne    348a <e4+0xda>
    3472:	40 80 ff 02          	cmp    $0x2,%dil
    3476:	75 12                	jne    348a <e4+0xda>
    3478:	48 8d 0c 32          	lea    (%rdx,%rsi,1),%rcx
    347c:	48 81 c1 28 02 00 00 	add    $0x228,%rcx
    3483:	80 39 00             	cmpb   $0x0,(%rcx)
    3486:	74 27                	je     34af <e4+0xff>
    3488:	eb 27                	jmp    34b1 <e4+0x101>
    348a:	40 80 ff 01          	cmp    $0x1,%dil
    348e:	75 1f                	jne    34af <e4+0xff>
    3490:	48 8d 3c 32          	lea    (%rdx,%rsi,1),%rdi
    3494:	8b 54 32 20          	mov    0x20(%rdx,%rsi,1),%edx
    3498:	48 0f af ca          	imul   %rdx,%rcx
    349c:	48 c1 e9 20          	shr    $0x20,%rcx
    34a0:	48 01 f9             	add    %rdi,%rcx
    34a3:	48 81 c1 28 02 00 00 	add    $0x228,%rcx
    34aa:	80 39 00             	cmpb   $0x0,(%rcx)
    34ad:	75 02                	jne    34b1 <e4+0x101>
    34af:	59                   	pop    %rcx
    34b0:	c3                   	ret
    34b1:	e8 fa 02 00 00       	call   37b0 <fwp_flush>
    34b6:	48 8b 05 23 bb 00 00 	mov    0xbb23(%rip),%rax        # efe0 <stderr@GLIBC_2.2.5>
    34bd:	48 8b 38             	mov    (%rax),%rdi
    34c0:	48 8d 35 6d 8e 00 00 	lea    0x8e6d(%rip),%rsi        # c334 <fwp_segv.msg+0xf4>
    34c7:	48 8d 15 39 8e 00 00 	lea    0x8e39(%rip),%rdx        # c307 <fwp_segv.msg+0xc7>
    34ce:	31 c0                	xor    %eax,%eax
    34d0:	e8 0b ed ff ff       	call   21e0 <fprintf@plt>
    34d5:	bf 65 00 00 00       	mov    $0x65,%edi
    34da:	e8 f1 ed ff ff       	call   22d0 <exit@plt>
    34df:	90                   	nop

00000000000034e0 <e8>:
    34e0:	50                   	push   %rax
    34e1:	48 8b 3f             	mov    (%rdi),%rdi
    34e4:	48 89 f8             	mov    %rdi,%rax
    34e7:	48 2b 05 ea cc 00 00 	sub    0xccea(%rip),%rax        # 101d8 <fwp_gc+0x1030>
    34ee:	48 8b 0d 0b cd 00 00 	mov    0xcd0b(%rip),%rcx        # 10200 <fwp_gc+0x1058>
    34f5:	48 c1 e1 10          	shl    $0x10,%rcx
    34f9:	48 39 c8             	cmp    %rcx,%rax
    34fc:	73 63                	jae    3561 <e8+0x81>
    34fe:	48 8b 0d 1b cd 00 00 	mov    0xcd1b(%rip),%rcx        # 10220 <fwp_gc+0x1078>
    3505:	48 89 c2             	mov    %rax,%rdx
    3508:	48 c1 ea 10          	shr    $0x10,%rdx
    350c:	48 69 d2 28 12 00 00 	imul   $0x1228,%rdx,%rdx
    3513:	0f b6 34 11          	movzbl (%rcx,%rdx,1),%esi
    3517:	48 25 ff ff 00 00    	and    $0xffff,%rax
    351d:	75 1a                	jne    3539 <e8+0x59>
    351f:	40 80 fe 02          	cmp    $0x2,%sil
    3523:	75 14                	jne    3539 <e8+0x59>
    3525:	48 8d 04 11          	lea    (%rcx,%rdx,1),%rax
    3529:	48 05 28 02 00 00    	add    $0x228,%rax
    352f:	80 38 00             	cmpb   $0x0,(%rax)
    3532:	74 2d                	je     3561 <e8+0x81>
    3534:	e9 a8 00 00 00       	jmp    35e1 <e8+0x101>
    3539:	40 80 fe 01          	cmp    $0x1,%sil
    353d:	75 22                	jne    3561 <e8+0x81>
    353f:	48 8d 34 11          	lea    (%rcx,%rdx,1),%rsi
    3543:	8b 4c 11 20          	mov    0x20(%rcx,%rdx,1),%ecx
    3547:	48 0f af c1          	imul   %rcx,%rax
    354b:	48 c1 e8 20          	shr    $0x20,%rax
    354f:	48 01 f0             	add    %rsi,%rax
    3552:	48 05 28 02 00 00    	add    $0x228,%rax
    3558:	80 38 00             	cmpb   $0x0,(%rax)
    355b:	0f 85 80 00 00 00    	jne    35e1 <e8+0x101>
    3561:	e8 3a 73 00 00       	call   a8a0 <f8>
    3566:	48 89 c1             	mov    %rax,%rcx
    3569:	48 2b 0d 68 cc 00 00 	sub    0xcc68(%rip),%rcx        # 101d8 <fwp_gc+0x1030>
    3570:	48 8b 15 89 cc 00 00 	mov    0xcc89(%rip),%rdx        # 10200 <fwp_gc+0x1058>
    3577:	48 c1 e2 10          	shl    $0x10,%rdx
    357b:	48 39 d1             	cmp    %rdx,%rcx
    357e:	73 5f                	jae    35df <e8+0xff>
    3580:	48 8b 15 99 cc 00 00 	mov    0xcc99(%rip),%rdx        # 10220 <fwp_gc+0x1078>
    3587:	48 89 ce             	mov    %rcx,%rsi
    358a:	48 c1 ee 10          	shr    $0x10,%rsi
    358e:	48 69 f6 28 12 00 00 	imul   $0x1228,%rsi,%rsi
    3595:	0f b6 3c 32          	movzbl (%rdx,%rsi,1),%edi
    3599:	48 81 e1 ff ff 00 00 	and    $0xffff,%rcx
    35a0:	75 18                	jne    35ba <e8+0xda>
    35a2:	40 80 ff 02          	cmp    $0x2,%dil
    35a6:	75 12                	jne    35ba <e8+0xda>
    35a8:	48 8d 0c 32          	lea    (%rdx,%rsi,1),%rcx
    35ac:	48 81 c1 28 02 00 00 	add    $0x228,%rcx
    35b3:	80 39 00             	cmpb   $0x0,(%rcx)
    35b6:	74 27                	je     35df <e8+0xff>
    35b8:	eb 27                	jmp    35e1 <e8+0x101>
    35ba:	40 80 ff 01          	cmp    $0x1,%dil
    35be:	75 1f                	jne    35df <e8+0xff>
    35c0:	48 8d 3c 32          	lea    (%rdx,%rsi,1),%rdi
    35c4:	8b 54 32 20          	mov    0x20(%rdx,%rsi,1),%edx
    35c8:	48 0f af ca          	imul   %rdx,%rcx
    35cc:	48 c1 e9 20          	shr    $0x20,%rcx
    35d0:	48 01 f9             	add    %rdi,%rcx
    35d3:	48 81 c1 28 02 00 00 	add    $0x228,%rcx
    35da:	80 39 00             	cmpb   $0x0,(%rcx)
    35dd:	75 02                	jne    35e1 <e8+0x101>
    35df:	59                   	pop    %rcx
    35e0:	c3                   	ret
    35e1:	e8 ca 01 00 00       	call   37b0 <fwp_flush>
    35e6:	48 8b 05 f3 b9 00 00 	mov    0xb9f3(%rip),%rax        # efe0 <stderr@GLIBC_2.2.5>
    35ed:	48 8b 38             	mov    (%rax),%rdi
    35f0:	48 8d 35 3d 8d 00 00 	lea    0x8d3d(%rip),%rsi        # c334 <fwp_segv.msg+0xf4>
    35f7:	48 8d 15 09 8d 00 00 	lea    0x8d09(%rip),%rdx        # c307 <fwp_segv.msg+0xc7>
    35fe:	31 c0                	xor    %eax,%eax
    3600:	e8 db eb ff ff       	call   21e0 <fprintf@plt>
    3605:	bf 65 00 00 00       	mov    $0x65,%edi
    360a:	e8 c1 ec ff ff       	call   22d0 <exit@plt>
    360f:	90                   	nop

0000000000003610 <e9>:
    3610:	50                   	push   %rax
    3611:	48 8b 3f             	mov    (%rdi),%rdi
    3614:	48 89 f8             	mov    %rdi,%rax
    3617:	48 2b 05 ba cb 00 00 	sub    0xcbba(%rip),%rax        # 101d8 <fwp_gc+0x1030>
    361e:	48 8b 0d db cb 00 00 	mov    0xcbdb(%rip),%rcx        # 10200 <fwp_gc+0x1058>
    3625:	48 c1 e1 10          	shl    $0x10,%rcx
    3629:	48 39 c8             	cmp    %rcx,%rax
    362c:	73 63                	jae    3691 <e9+0x81>
    362e:	48 8b 0d eb cb 00 00 	mov    0xcbeb(%rip),%rcx        # 10220 <fwp_gc+0x1078>
    3635:	48 89 c2             	mov    %rax,%rdx
    3638:	48 c1 ea 10          	shr    $0x10,%rdx
    363c:	48 69 d2 28 12 00 00 	imul   $0x1228,%rdx,%rdx
    3643:	0f b6 34 11          	movzbl (%rcx,%rdx,1),%esi
    3647:	48 25 ff ff 00 00    	and    $0xffff,%rax
    364d:	75 1a                	jne    3669 <e9+0x59>
    364f:	40 80 fe 02          	cmp    $0x2,%sil
    3653:	75 14                	jne    3669 <e9+0x59>
    3655:	48 8d 04 11          	lea    (%rcx,%rdx,1),%rax
    3659:	48 05 28 02 00 00    	add    $0x228,%rax
    365f:	80 38 00             	cmpb   $0x0,(%rax)
    3662:	74 2d                	je     3691 <e9+0x81>
    3664:	e9 ca 00 00 00       	jmp    3733 <e9+0x123>
    3669:	40 80 fe 01          	cmp    $0x1,%sil
    366d:	75 22                	jne    3691 <e9+0x81>
    366f:	48 8d 34 11          	lea    (%rcx,%rdx,1),%rsi
    3673:	8b 4c 11 20          	mov    0x20(%rcx,%rdx,1),%ecx
    3677:	48 0f af c1          	imul   %rcx,%rax
    367b:	48 c1 e8 20          	shr    $0x20,%rax
    367f:	48 01 f0             	add    %rsi,%rax
    3682:	48 05 28 02 00 00    	add    $0x228,%rax
    3688:	80 38 00             	cmpb   $0x0,(%rax)
    368b:	0f 85 a2 00 00 00    	jne    3733 <e9+0x123>
    3691:	48 8b 17             	mov    (%rdi),%rdx
    3694:	48 83 c7 08          	add    $0x8,%rdi
    3698:	48 8b 0d a9 d5 00 00 	mov    0xd5a9(%rip),%rcx        # 10c48 <fwp_prog_out>
    369f:	be 01 00 00 00       	mov    $0x1,%esi
    36a4:	e8 37 ec ff ff       	call   22e0 <fwrite@plt>
    36a9:	48 8b 35 98 d5 00 00 	mov    0xd598(%rip),%rsi        # 10c48 <fwp_prog_out>
    36b0:	bf 0a 00 00 00       	mov    $0xa,%edi
    36b5:	e8 b6 ea ff ff       	call   2170 <fputc@plt>
    36ba:	31 c0                	xor    %eax,%eax
    36bc:	48 2b 05 15 cb 00 00 	sub    0xcb15(%rip),%rax        # 101d8 <fwp_gc+0x1030>
    36c3:	48 8b 0d 36 cb 00 00 	mov    0xcb36(%rip),%rcx        # 10200 <fwp_gc+0x1058>
    36ca:	48 c1 e1 10          	shl    $0x10,%rcx
    36ce:	48 39 c1             	cmp    %rax,%rcx
    36d1:	76 5c                	jbe    372f <e9+0x11f>
    36d3:	48 8b 0d 46 cb 00 00 	mov    0xcb46(%rip),%rcx        # 10220 <fwp_gc+0x1078>
    36da:	48 89 c2             	mov    %rax,%rdx
    36dd:	48 c1 ea 10          	shr    $0x10,%rdx
    36e1:	48 69 d2 28 12 00 00 	imul   $0x1228,%rdx,%rdx
    36e8:	0f b6 34 11          	movzbl (%rcx,%rdx,1),%esi
    36ec:	48 25 ff ff 00 00    	and    $0xffff,%rax
    36f2:	75 17                	jne    370b <e9+0xfb>
    36f4:	40 80 fe 02          	cmp    $0x2,%sil
    36f8:	75 11                	jne    370b <e9+0xfb>
    36fa:	48 8d 04 11          	lea    (%rcx,%rdx,1),%rax
    36fe:	48 05 28 02 00 00    	add    $0x228,%rax
    3704:	80 38 00             	cmpb   $0x0,(%rax)
    3707:	74 26                	je     372f <e9+0x11f>
    3709:	eb 28                	jmp    3733 <e9+0x123>
    370b:	40 80 fe 01          	cmp    $0x1,%sil
    370f:	75 1e                	jne    372f <e9+0x11f>
    3711:	48 8d 34 11          	lea    (%rcx,%rdx,1),%rsi
    3715:	8b 4c 11 20          	mov    0x20(%rcx,%rdx,1),%ecx
    3719:	48 0f af c1          	imul   %rcx,%rax
    371d:	48 c1 e8 20          	shr    $0x20,%rax
    3721:	48 01 f0             	add    %rsi,%rax
    3724:	48 05 28 02 00 00    	add    $0x228,%rax
    372a:	80 38 00             	cmpb   $0x0,(%rax)
    372d:	75 04                	jne    3733 <e9+0x123>
    372f:	31 c0                	xor    %eax,%eax
    3731:	59                   	pop    %rcx
    3732:	c3                   	ret
    3733:	e8 78 00 00 00       	call   37b0 <fwp_flush>
    3738:	48 8b 05 a1 b8 00 00 	mov    0xb8a1(%rip),%rax        # efe0 <stderr@GLIBC_2.2.5>
    373f:	48 8b 38             	mov    (%rax),%rdi
    3742:	48 8d 35 eb 8b 00 00 	lea    0x8beb(%rip),%rsi        # c334 <fwp_segv.msg+0xf4>
    3749:	48 8d 15 b7 8b 00 00 	lea    0x8bb7(%rip),%rdx        # c307 <fwp_segv.msg+0xc7>
    3750:	31 c0                	xor    %eax,%eax
    3752:	e8 89 ea ff ff       	call   21e0 <fprintf@plt>
    3757:	bf 65 00 00 00       	mov    $0x65,%edi
    375c:	e8 6f eb ff ff       	call   22d0 <exit@plt>
    3761:	66 66 66 66 66 66 2e 	data16 data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    3768:	0f 1f 84 00 00 00 00 
    376f:	00 

0000000000003770 <fwp_cleanup_unwind>:
    3770:	53                   	push   %rbx
    3771:	48 8b 05 f0 d4 00 00 	mov    0xd4f0(%rip),%rax        # 10c68 <fwp_cleanups>
    3778:	48 39 f8             	cmp    %rdi,%rax
    377b:	74 25                	je     37a2 <fwp_cleanup_unwind+0x32>
    377d:	48 89 fb             	mov    %rdi,%rbx
    3780:	48 85 c0             	test   %rax,%rax
    3783:	74 1f                	je     37a4 <fwp_cleanup_unwind+0x34>
    3785:	48 8b 08             	mov    (%rax),%rcx
    3788:	48 89 0d d9 d4 00 00 	mov    %rcx,0xd4d9(%rip)        # 10c68 <fwp_cleanups>
    378f:	48 8b 78 10          	mov    0x10(%rax),%rdi
    3793:	ff 50 08             	call   *0x8(%rax)
    3796:	48 8b 05 cb d4 00 00 	mov    0xd4cb(%rip),%rax        # 10c68 <fwp_cleanups>
    379d:	48 39 d8             	cmp    %rbx,%rax
    37a0:	75 de                	jne    3780 <fwp_cleanup_unwind+0x10>
    37a2:	5b                   	pop    %rbx
    37a3:	c3                   	ret
    37a4:	e8 b7 e8 ff ff       	call   2060 <abort@plt>
    37a9:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)

00000000000037b0 <fwp_flush>:
    37b0:	50                   	push   %rax
    37b1:	48 8b 3d 90 d4 00 00 	mov    0xd490(%rip),%rdi        # 10c48 <fwp_prog_out>
    37b8:	48 85 ff             	test   %rdi,%rdi
    37bb:	74 05                	je     37c2 <fwp_flush+0x12>
    37bd:	e8 6e ea ff ff       	call   2230 <fflush@plt>
    37c2:	48 8b 05 f7 b7 00 00 	mov    0xb7f7(%rip),%rax        # efc0 <stdout@GLIBC_2.2.5>
    37c9:	48 8b 38             	mov    (%rax),%rdi
    37cc:	58                   	pop    %rax
    37cd:	e9 5e ea ff ff       	jmp    2230 <fflush@plt>
    37d2:	66 66 66 66 66 2e 0f 	data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    37d9:	1f 84 00 00 00 00 00 

00000000000037e0 <fwp_rc_forget_slot>:
    37e0:	50                   	push   %rax
    37e1:	80 3f ff             	cmpb   $0xff,(%rdi)
    37e4:	74 02                	je     37e8 <fwp_rc_forget_slot+0x8>
    37e6:	58                   	pop    %rax
    37e7:	c3                   	ret
    37e8:	48 89 f8             	mov    %rdi,%rax
    37eb:	48 c1 e8 11          	shr    $0x11,%rax
    37ef:	31 f8                	xor    %edi,%eax
    37f1:	89 c1                	mov    %eax,%ecx
    37f3:	c1 e9 09             	shr    $0x9,%ecx
    37f6:	31 c1                	xor    %eax,%ecx
    37f8:	0f b6 c9             	movzbl %cl,%ecx
    37fb:	48 8d 15 a6 b9 00 00 	lea    0xb9a6(%rip),%rdx        # f1a8 <fwp_gc>
    3802:	48 8b 84 ca 18 12 00 	mov    0x1218(%rdx,%rcx,8),%rax
    3809:	00 
    380a:	48 85 c0             	test   %rax,%rax
    380d:	74 4b                	je     385a <fwp_rc_forget_slot+0x7a>
    380f:	48 39 38             	cmp    %rdi,(%rax)
    3812:	74 23                	je     3837 <fwp_rc_forget_slot+0x57>
    3814:	66 66 66 2e 0f 1f 84 	data16 data16 cs nopw 0x0(%rax,%rax,1)
    381b:	00 00 00 00 00 
    3820:	48 89 c1             	mov    %rax,%rcx
    3823:	48 8b 40 10          	mov    0x10(%rax),%rax
    3827:	48 85 c0             	test   %rax,%rax
    382a:	74 2e                	je     385a <fwp_rc_forget_slot+0x7a>
    382c:	48 39 38             	cmp    %rdi,(%rax)
    382f:	75 ef                	jne    3820 <fwp_rc_forget_slot+0x40>
    3831:	48 83 c1 10          	add    $0x10,%rcx
    3835:	eb 0b                	jmp    3842 <fwp_rc_forget_slot+0x62>
    3837:	48 8d 0c ca          	lea    (%rdx,%rcx,8),%rcx
    383b:	48 81 c1 18 12 00 00 	add    $0x1218,%rcx
    3842:	48 8b 50 10          	mov    0x10(%rax),%rdx
    3846:	48 89 11             	mov    %rdx,(%rcx)
    3849:	48 89 c7             	mov    %rax,%rdi
    384c:	e8 ff e7 ff ff       	call   2050 <free@plt>
    3851:	48 ff 0d 68 d3 00 00 	decq   0xd368(%rip)        # 10bc0 <fwp_gc+0x1a18>
    3858:	58                   	pop    %rax
    3859:	c3                   	ret
    385a:	e8 51 ff ff ff       	call   37b0 <fwp_flush>
    385f:	48 8b 05 7a b7 00 00 	mov    0xb77a(%rip),%rax        # efe0 <stderr@GLIBC_2.2.5>
    3866:	48 8b 38             	mov    (%rax),%rdi
    3869:	48 8d 35 c4 8a 00 00 	lea    0x8ac4(%rip),%rsi        # c334 <fwp_segv.msg+0xf4>
    3870:	48 8d 15 cc 8a 00 00 	lea    0x8acc(%rip),%rdx        # c343 <fwp_segv.msg+0x103>
    3877:	31 c0                	xor    %eax,%eax
    3879:	e8 62 e9 ff ff       	call   21e0 <fprintf@plt>
    387e:	bf 65 00 00 00       	mov    $0x65,%edi
    3883:	e8 48 ea ff ff       	call   22d0 <exit@plt>
    3888:	0f 1f 84 00 00 00 00 	nopl   0x0(%rax,%rax,1)
    388f:	00 

0000000000003890 <fwp_p_attempt_owned>:
    3890:	41 57                	push   %r15
    3892:	41 56                	push   %r14
    3894:	41 54                	push   %r12
    3896:	53                   	push   %rbx
    3897:	48 81 ec 28 01 00 00 	sub    $0x128,%rsp
    389e:	48 89 fb             	mov    %rdi,%rbx
    38a1:	48 89 34 24          	mov    %rsi,(%rsp)
    38a5:	48 8b 05 c4 d3 00 00 	mov    0xd3c4(%rip),%rax        # 10c70 <fwp_handlers>
    38ac:	48 89 84 24 00 01 00 	mov    %rax,0x100(%rsp)
    38b3:	00 
    38b4:	48 8b 05 bd d3 00 00 	mov    0xd3bd(%rip),%rax        # 10c78 <fwp_state_len>
    38bb:	48 89 84 24 18 01 00 	mov    %rax,0x118(%rsp)
    38c2:	00 
    38c3:	48 8b 05 9e d3 00 00 	mov    0xd39e(%rip),%rax        # 10c68 <fwp_cleanups>
    38ca:	48 89 84 24 20 01 00 	mov    %rax,0x120(%rsp)
    38d1:	00 
    38d2:	48 8d 7c 24 38       	lea    0x38(%rsp),%rdi
    38d7:	48 89 3d 92 d3 00 00 	mov    %rdi,0xd392(%rip)        # 10c70 <fwp_handlers>
    38de:	e8 bd e8 ff ff       	call   21a0 <_setjmp@plt>
    38e3:	85 c0                	test   %eax,%eax
    38e5:	74 25                	je     390c <fwp_p_attempt_owned+0x7c>
    38e7:	48 8b 8c 24 08 01 00 	mov    0x108(%rsp),%rcx
    38ee:	00 
    38ef:	48 8b 84 24 18 01 00 	mov    0x118(%rsp),%rax
    38f6:	00 
    38f7:	48 89 05 7a d3 00 00 	mov    %rax,0xd37a(%rip)        # 10c78 <fwp_state_len>
    38fe:	bf 01 00 00 00       	mov    $0x1,%edi
    3903:	48 8d 05 e6 01 00 00 	lea    0x1e6(%rip),%rax        # 3af0 <fwp_drop4>
    390a:	eb 1d                	jmp    3929 <fwp_p_attempt_owned+0x99>
    390c:	48 89 e6             	mov    %rsp,%rsi
    390f:	48 89 df             	mov    %rbx,%rdi
    3912:	e8 d9 03 00 00       	call   3cf0 <fwp_apply_borrowed>
    3917:	31 ff                	xor    %edi,%edi
    3919:	48 8d 0d 30 01 00 00 	lea    0x130(%rip),%rcx        # 3a50 <fwp_drop3>
    3920:	48 89 c2             	mov    %rax,%rdx
    3923:	48 89 c8             	mov    %rcx,%rax
    3926:	48 89 d1             	mov    %rdx,%rcx
    3929:	48 89 4c 24 18       	mov    %rcx,0x18(%rsp)
    392e:	48 8b 94 24 00 01 00 	mov    0x100(%rsp),%rdx
    3935:	00 
    3936:	48 89 15 33 d3 00 00 	mov    %rdx,0xd333(%rip)        # 10c70 <fwp_handlers>
    393d:	48 89 4c 24 08       	mov    %rcx,0x8(%rsp)
    3942:	48 89 44 24 10       	mov    %rax,0x10(%rsp)
    3947:	48 8b 05 1a d3 00 00 	mov    0xd31a(%rip),%rax        # 10c68 <fwp_cleanups>
    394e:	48 89 44 24 20       	mov    %rax,0x20(%rsp)
    3953:	48 8d 05 e6 2f 00 00 	lea    0x2fe6(%rip),%rax        # 6940 <fwp_value_release>
    395a:	48 89 44 24 28       	mov    %rax,0x28(%rsp)
    395f:	48 8d 44 24 08       	lea    0x8(%rsp),%rax
    3964:	48 89 44 24 30       	mov    %rax,0x30(%rsp)
    3969:	4c 8d 7c 24 20       	lea    0x20(%rsp),%r15
    396e:	4c 89 3d f3 d2 00 00 	mov    %r15,0xd2f3(%rip)        # 10c68 <fwp_cleanups>
    3975:	48 8d 54 24 18       	lea    0x18(%rsp),%rdx
    397a:	be 01 00 00 00       	mov    $0x1,%esi
    397f:	e8 4c 08 00 00       	call   41d0 <fwp_data>
    3984:	48 89 c6             	mov    %rax,%rsi
    3987:	48 2b 35 4a c8 00 00 	sub    0xc84a(%rip),%rsi        # 101d8 <fwp_gc+0x1030>
    398e:	48 8b 0d 6b c8 00 00 	mov    0xc86b(%rip),%rcx        # 10200 <fwp_gc+0x1058>
    3995:	48 c1 e1 10          	shl    $0x10,%rcx
    3999:	48 39 ce             	cmp    %rcx,%rsi
    399c:	73 76                	jae    3a14 <fwp_p_attempt_owned+0x184>
    399e:	48 8b 0d 7b c8 00 00 	mov    0xc87b(%rip),%rcx        # 10220 <fwp_gc+0x1078>
    39a5:	48 89 f2             	mov    %rsi,%rdx
    39a8:	48 c1 ea 10          	shr    $0x10,%rdx
    39ac:	48 69 d2 28 12 00 00 	imul   $0x1228,%rdx,%rdx
    39b3:	0f b6 3c 11          	movzbl (%rcx,%rdx,1),%edi
    39b7:	48 81 e6 ff ff 00 00 	and    $0xffff,%rsi
    39be:	75 1d                	jne    39dd <fwp_p_attempt_owned+0x14d>
    39c0:	40 80 ff 02          	cmp    $0x2,%dil
    39c4:	75 17                	jne    39dd <fwp_p_attempt_owned+0x14d>
    39c6:	4c 8d 34 11          	lea    (%rcx,%rdx,1),%r14
    39ca:	49 81 c6 28 02 00 00 	add    $0x228,%r14
    39d1:	41 80 3e ff          	cmpb   $0xff,(%r14)
    39d5:	74 2d                	je     3a04 <fwp_p_attempt_owned+0x174>
    39d7:	41 c6 06 01          	movb   $0x1,(%r14)
    39db:	eb 37                	jmp    3a14 <fwp_p_attempt_owned+0x184>
    39dd:	40 80 ff 01          	cmp    $0x1,%dil
    39e1:	75 31                	jne    3a14 <fwp_p_attempt_owned+0x184>
    39e3:	48 8d 3c 11          	lea    (%rcx,%rdx,1),%rdi
    39e7:	8b 4c 11 20          	mov    0x20(%rcx,%rdx,1),%ecx
    39eb:	48 0f af f1          	imul   %rcx,%rsi
    39ef:	48 c1 ee 20          	shr    $0x20,%rsi
    39f3:	4c 8d 34 3e          	lea    (%rsi,%rdi,1),%r14
    39f7:	49 81 c6 28 02 00 00 	add    $0x228,%r14
    39fe:	41 80 3e ff          	cmpb   $0xff,(%r14)
    3a02:	75 d3                	jne    39d7 <fwp_p_attempt_owned+0x147>
    3a04:	4c 89 f7             	mov    %r14,%rdi
    3a07:	49 89 c4             	mov    %rax,%r12
    3a0a:	e8 d1 fd ff ff       	call   37e0 <fwp_rc_forget_slot>
    3a0f:	4c 89 e0             	mov    %r12,%rax
    3a12:	eb c3                	jmp    39d7 <fwp_p_attempt_owned+0x147>
    3a14:	48 8b 0c 24          	mov    (%rsp),%rcx
    3a18:	48 83 7c 24 10 00    	cmpq   $0x0,0x10(%rsp)
    3a1e:	74 15                	je     3a35 <fwp_p_attempt_owned+0x1a5>
    3a20:	4c 39 3d 41 d2 00 00 	cmp    %r15,0xd241(%rip)        # 10c68 <fwp_cleanups>
    3a27:	75 1b                	jne    3a44 <fwp_p_attempt_owned+0x1b4>
    3a29:	48 8b 4c 24 20       	mov    0x20(%rsp),%rcx
    3a2e:	48 89 0d 33 d2 00 00 	mov    %rcx,0xd233(%rip)        # 10c68 <fwp_cleanups>
    3a35:	48 81 c4 28 01 00 00 	add    $0x128,%rsp
    3a3c:	5b                   	pop    %rbx
    3a3d:	41 5c                	pop    %r12
    3a3f:	41 5e                	pop    %r14
    3a41:	41 5f                	pop    %r15
    3a43:	c3                   	ret
    3a44:	e8 17 e6 ff ff       	call   2060 <abort@plt>
    3a49:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)

0000000000003a50 <fwp_drop3>:
    3a50:	48 89 f8             	mov    %rdi,%rax
    3a53:	48 2b 05 7e c7 00 00 	sub    0xc77e(%rip),%rax        # 101d8 <fwp_gc+0x1030>
    3a5a:	48 8b 0d 9f c7 00 00 	mov    0xc79f(%rip),%rcx        # 10200 <fwp_gc+0x1058>
    3a61:	48 c1 e1 10          	shl    $0x10,%rcx
    3a65:	48 39 c8             	cmp    %rcx,%rax
    3a68:	73 6e                	jae    3ad8 <fwp_drop3+0x88>
    3a6a:	48 8b 0d af c7 00 00 	mov    0xc7af(%rip),%rcx        # 10220 <fwp_gc+0x1078>
    3a71:	48 89 c2             	mov    %rax,%rdx
    3a74:	48 c1 ea 10          	shr    $0x10,%rdx
    3a78:	48 69 d2 28 12 00 00 	imul   $0x1228,%rdx,%rdx
    3a7f:	0f b6 34 11          	movzbl (%rcx,%rdx,1),%esi
    3a83:	48 25 ff ff 00 00    	and    $0xffff,%rax
    3a89:	75 12                	jne    3a9d <fwp_drop3+0x4d>
    3a8b:	40 80 fe 02          	cmp    $0x2,%sil
    3a8f:	75 0c                	jne    3a9d <fwp_drop3+0x4d>
    3a91:	48 8d 04 11          	lea    (%rcx,%rdx,1),%rax
    3a95:	48 05 28 02 00 00    	add    $0x228,%rax
    3a9b:	eb 1f                	jmp    3abc <fwp_drop3+0x6c>
    3a9d:	40 80 fe 01          	cmp    $0x1,%sil
    3aa1:	75 35                	jne    3ad8 <fwp_drop3+0x88>
    3aa3:	48 8d 34 11          	lea    (%rcx,%rdx,1),%rsi
    3aa7:	8b 4c 11 20          	mov    0x20(%rcx,%rdx,1),%ecx
    3aab:	48 0f af c1          	imul   %rcx,%rax
    3aaf:	48 c1 e8 20          	shr    $0x20,%rax
    3ab3:	48 01 f0             	add    %rsi,%rax
    3ab6:	48 05 28 02 00 00    	add    $0x228,%rax
    3abc:	0f b6 08             	movzbl (%rax),%ecx
    3abf:	85 c9                	test   %ecx,%ecx
    3ac1:	74 15                	je     3ad8 <fwp_drop3+0x88>
    3ac3:	83 f9 01             	cmp    $0x1,%ecx
    3ac6:	0f 84 44 2a 00 00    	je     6510 <fwp_rc_free_obj>
    3acc:	81 f9 ff 00 00 00    	cmp    $0xff,%ecx
    3ad2:	74 05                	je     3ad9 <fwp_drop3+0x89>
    3ad4:	fe c9                	dec    %cl
    3ad6:	88 08                	mov    %cl,(%rax)
    3ad8:	c3                   	ret
    3ad9:	48 89 c7             	mov    %rax,%rdi
    3adc:	e9 1f 28 00 00       	jmp    6300 <fwp_rc_wide_drop>
    3ae1:	66 66 66 66 66 66 2e 	data16 data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    3ae8:	0f 1f 84 00 00 00 00 
    3aef:	00 

0000000000003af0 <fwp_drop4>:
    3af0:	48 8b 15 e1 c6 00 00 	mov    0xc6e1(%rip),%rdx        # 101d8 <fwp_gc+0x1030>
    3af7:	48 89 f8             	mov    %rdi,%rax
    3afa:	48 29 d0             	sub    %rdx,%rax
    3afd:	48 8b 35 fc c6 00 00 	mov    0xc6fc(%rip),%rsi        # 10200 <fwp_gc+0x1058>
    3b04:	48 c1 e6 10          	shl    $0x10,%rsi
    3b08:	48 39 f0             	cmp    %rsi,%rax
    3b0b:	0f 83 b7 00 00 00    	jae    3bc8 <fwp_drop4+0xd8>
    3b11:	48 8b 0d 08 c7 00 00 	mov    0xc708(%rip),%rcx        # 10220 <fwp_gc+0x1078>
    3b18:	49 89 c0             	mov    %rax,%r8
    3b1b:	49 c1 e8 10          	shr    $0x10,%r8
    3b1f:	4d 69 c0 28 12 00 00 	imul   $0x1228,%r8,%r8
    3b26:	46 0f b6 0c 01       	movzbl (%rcx,%r8,1),%r9d
    3b2b:	48 25 ff ff 00 00    	and    $0xffff,%rax
    3b31:	75 12                	jne    3b45 <fwp_drop4+0x55>
    3b33:	41 80 f9 02          	cmp    $0x2,%r9b
    3b37:	75 0c                	jne    3b45 <fwp_drop4+0x55>
    3b39:	4a 8d 04 01          	lea    (%rcx,%r8,1),%rax
    3b3d:	48 05 28 02 00 00    	add    $0x228,%rax
    3b43:	eb 20                	jmp    3b65 <fwp_drop4+0x75>
    3b45:	41 80 f9 01          	cmp    $0x1,%r9b
    3b49:	75 7d                	jne    3bc8 <fwp_drop4+0xd8>
    3b4b:	4e 8d 0c 01          	lea    (%rcx,%r8,1),%r9
    3b4f:	46 8b 44 01 20       	mov    0x20(%rcx,%r8,1),%r8d
    3b54:	49 0f af c0          	imul   %r8,%rax
    3b58:	48 c1 e8 20          	shr    $0x20,%rax
    3b5c:	4c 01 c8             	add    %r9,%rax
    3b5f:	48 05 28 02 00 00    	add    $0x228,%rax
    3b65:	44 0f b6 00          	movzbl (%rax),%r8d
    3b69:	45 85 c0             	test   %r8d,%r8d
    3b6c:	74 5a                	je     3bc8 <fwp_drop4+0xd8>
    3b6e:	41 83 f8 01          	cmp    $0x1,%r8d
    3b72:	75 41                	jne    3bb5 <fwp_drop4+0xc5>
    3b74:	53                   	push   %rbx
    3b75:	48 8b 47 08          	mov    0x8(%rdi),%rax
    3b79:	49 89 c0             	mov    %rax,%r8
    3b7c:	49 29 d0             	sub    %rdx,%r8
    3b7f:	49 39 f0             	cmp    %rsi,%r8
    3b82:	0f 83 8e 00 00 00    	jae    3c16 <fwp_drop4+0x126>
    3b88:	4c 89 c2             	mov    %r8,%rdx
    3b8b:	48 c1 ea 10          	shr    $0x10,%rdx
    3b8f:	48 69 d2 28 12 00 00 	imul   $0x1228,%rdx,%rdx
    3b96:	0f b6 34 11          	movzbl (%rcx,%rdx,1),%esi
    3b9a:	49 81 e0 ff ff 00 00 	and    $0xffff,%r8
    3ba1:	75 26                	jne    3bc9 <fwp_drop4+0xd9>
    3ba3:	40 80 fe 02          	cmp    $0x2,%sil
    3ba7:	75 20                	jne    3bc9 <fwp_drop4+0xd9>
    3ba9:	48 01 d1             	add    %rdx,%rcx
    3bac:	48 81 c1 28 02 00 00 	add    $0x228,%rcx
    3bb3:	eb 35                	jmp    3bea <fwp_drop4+0xfa>
    3bb5:	41 81 f8 ff 00 00 00 	cmp    $0xff,%r8d
    3bbc:	0f 84 fa 00 00 00    	je     3cbc <fwp_drop4+0x1cc>
    3bc2:	41 fe c8             	dec    %r8b
    3bc5:	44 88 00             	mov    %r8b,(%rax)
    3bc8:	c3                   	ret
    3bc9:	40 80 fe 01          	cmp    $0x1,%sil
    3bcd:	75 47                	jne    3c16 <fwp_drop4+0x126>
    3bcf:	48 8d 34 11          	lea    (%rcx,%rdx,1),%rsi
    3bd3:	8b 4c 11 20          	mov    0x20(%rcx,%rdx,1),%ecx
    3bd7:	4c 0f af c1          	imul   %rcx,%r8
    3bdb:	49 c1 e8 20          	shr    $0x20,%r8
    3bdf:	49 8d 0c 30          	lea    (%r8,%rsi,1),%rcx
    3be3:	48 81 c1 28 02 00 00 	add    $0x228,%rcx
    3bea:	0f b6 11             	movzbl (%rcx),%edx
    3bed:	85 d2                	test   %edx,%edx
    3bef:	74 25                	je     3c16 <fwp_drop4+0x126>
    3bf1:	83 fa 01             	cmp    $0x1,%edx
    3bf4:	75 10                	jne    3c06 <fwp_drop4+0x116>
    3bf6:	48 89 fb             	mov    %rdi,%rbx
    3bf9:	48 89 c7             	mov    %rax,%rdi
    3bfc:	e8 0f 29 00 00       	call   6510 <fwp_rc_free_obj>
    3c01:	48 89 df             	mov    %rbx,%rdi
    3c04:	eb 10                	jmp    3c16 <fwp_drop4+0x126>
    3c06:	81 fa ff 00 00 00    	cmp    $0xff,%edx
    3c0c:	0f 84 b2 00 00 00    	je     3cc4 <fwp_drop4+0x1d4>
    3c12:	fe ca                	dec    %dl
    3c14:	88 11                	mov    %dl,(%rcx)
    3c16:	48 8b 47 10          	mov    0x10(%rdi),%rax
    3c1a:	48 89 c1             	mov    %rax,%rcx
    3c1d:	48 2b 0d b4 c5 00 00 	sub    0xc5b4(%rip),%rcx        # 101d8 <fwp_gc+0x1030>
    3c24:	48 8b 15 d5 c5 00 00 	mov    0xc5d5(%rip),%rdx        # 10200 <fwp_gc+0x1058>
    3c2b:	48 c1 e2 10          	shl    $0x10,%rdx
    3c2f:	48 39 d1             	cmp    %rdx,%rcx
    3c32:	73 70                	jae    3ca4 <fwp_drop4+0x1b4>
    3c34:	48 8b 15 e5 c5 00 00 	mov    0xc5e5(%rip),%rdx        # 10220 <fwp_gc+0x1078>
    3c3b:	48 89 ce             	mov    %rcx,%rsi
    3c3e:	48 c1 ee 10          	shr    $0x10,%rsi
    3c42:	48 69 f6 28 12 00 00 	imul   $0x1228,%rsi,%rsi
    3c49:	44 0f b6 04 32       	movzbl (%rdx,%rsi,1),%r8d
    3c4e:	48 81 e1 ff ff 00 00 	and    $0xffff,%rcx
    3c55:	75 13                	jne    3c6a <fwp_drop4+0x17a>
    3c57:	41 80 f8 02          	cmp    $0x2,%r8b
    3c5b:	75 0d                	jne    3c6a <fwp_drop4+0x17a>
    3c5d:	48 8d 0c 32          	lea    (%rdx,%rsi,1),%rcx
    3c61:	48 81 c1 28 02 00 00 	add    $0x228,%rcx
    3c68:	eb 20                	jmp    3c8a <fwp_drop4+0x19a>
    3c6a:	41 80 f8 01          	cmp    $0x1,%r8b
    3c6e:	75 34                	jne    3ca4 <fwp_drop4+0x1b4>
    3c70:	4c 8d 04 32          	lea    (%rdx,%rsi,1),%r8
    3c74:	8b 54 32 20          	mov    0x20(%rdx,%rsi,1),%edx
    3c78:	48 0f af ca          	imul   %rdx,%rcx
    3c7c:	48 c1 e9 20          	shr    $0x20,%rcx
    3c80:	4c 01 c1             	add    %r8,%rcx
    3c83:	48 81 c1 28 02 00 00 	add    $0x228,%rcx
    3c8a:	0f b6 11             	movzbl (%rcx),%edx
    3c8d:	85 d2                	test   %edx,%edx
    3c8f:	74 13                	je     3ca4 <fwp_drop4+0x1b4>
    3c91:	83 fa 01             	cmp    $0x1,%edx
    3c94:	75 14                	jne    3caa <fwp_drop4+0x1ba>
    3c96:	48 89 fb             	mov    %rdi,%rbx
    3c99:	48 89 c7             	mov    %rax,%rdi
    3c9c:	e8 6f 28 00 00       	call   6510 <fwp_rc_free_obj>
    3ca1:	48 89 df             	mov    %rbx,%rdi
    3ca4:	5b                   	pop    %rbx
    3ca5:	e9 66 28 00 00       	jmp    6510 <fwp_rc_free_obj>
    3caa:	81 fa ff 00 00 00    	cmp    $0xff,%edx
    3cb0:	74 22                	je     3cd4 <fwp_drop4+0x1e4>
    3cb2:	fe ca                	dec    %dl
    3cb4:	88 11                	mov    %dl,(%rcx)
    3cb6:	5b                   	pop    %rbx
    3cb7:	e9 54 28 00 00       	jmp    6510 <fwp_rc_free_obj>
    3cbc:	48 89 c7             	mov    %rax,%rdi
    3cbf:	e9 3c 26 00 00       	jmp    6300 <fwp_rc_wide_drop>
    3cc4:	48 89 fb             	mov    %rdi,%rbx
    3cc7:	48 89 cf             	mov    %rcx,%rdi
    3cca:	e8 31 26 00 00       	call   6300 <fwp_rc_wide_drop>
    3ccf:	e9 2d ff ff ff       	jmp    3c01 <fwp_drop4+0x111>
    3cd4:	48 89 fb             	mov    %rdi,%rbx
    3cd7:	48 89 cf             	mov    %rcx,%rdi
    3cda:	e8 21 26 00 00       	call   6300 <fwp_rc_wide_drop>
    3cdf:	eb c0                	jmp    3ca1 <fwp_drop4+0x1b1>
    3ce1:	66 66 66 66 66 66 2e 	data16 data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    3ce8:	0f 1f 84 00 00 00 00 
    3cef:	00 

0000000000003cf0 <fwp_apply_borrowed>:
    3cf0:	55                   	push   %rbp
    3cf1:	41 57                	push   %r15
    3cf3:	41 56                	push   %r14
    3cf5:	41 55                	push   %r13
    3cf7:	41 54                	push   %r12
    3cf9:	53                   	push   %rbx
    3cfa:	48 81 ec 98 00 00 00 	sub    $0x98,%rsp
    3d01:	49 89 f4             	mov    %rsi,%r12
    3d04:	48 89 fb             	mov    %rdi,%rbx
    3d07:	4c 8b 3d 32 cf 00 00 	mov    0xcf32(%rip),%r15        # 10c40 <fwp_fns>
    3d0e:	8b 0f                	mov    (%rdi),%ecx
    3d10:	48 c1 e1 05          	shl    $0x5,%rcx
    3d14:	49 8b 44 0f 18       	mov    0x18(%r15,%rcx,1),%rax
    3d19:	48 85 c0             	test   %rax,%rax
    3d1c:	0f 84 29 03 00 00    	je     404b <fwp_apply_borrowed+0x35b>
    3d22:	4d 8d 2c 0f          	lea    (%r15,%rcx,1),%r13
    3d26:	49 83 c5 18          	add    $0x18,%r13
    3d2a:	49 01 cf             	add    %rcx,%r15
    3d2d:	bd 01 00 00 00       	mov    $0x1,%ebp
    3d32:	31 c9                	xor    %ecx,%ecx
    3d34:	66 66 66 2e 0f 1f 84 	data16 data16 cs nopw 0x0(%rax,%rax,1)
    3d3b:	00 00 00 00 00 
    3d40:	f6 c1 01             	test   $0x1,%cl
    3d43:	ba 00 00 00 00       	mov    $0x0,%edx
    3d48:	48 0f 45 d3          	cmovne %rbx,%rdx
    3d4c:	48 89 54 24 70       	mov    %rdx,0x70(%rsp)
    3d51:	4c 89 64 24 78       	mov    %r12,0x78(%rsp)
    3d56:	48 89 84 24 80 00 00 	mov    %rax,0x80(%rsp)
    3d5d:	00 
    3d5e:	c7 84 24 88 00 00 00 	movl   $0x0,0x88(%rsp)
    3d65:	00 00 00 00 
    3d69:	8b 53 04             	mov    0x4(%rbx),%edx
    3d6c:	89 94 24 8c 00 00 00 	mov    %edx,0x8c(%rsp)
    3d73:	48 89 da             	mov    %rbx,%rdx
    3d76:	48 2b 15 5b c4 00 00 	sub    0xc45b(%rip),%rdx        # 101d8 <fwp_gc+0x1030>
    3d7d:	c7 84 24 90 00 00 00 	movl   $0x0,0x90(%rsp)
    3d84:	00 00 00 00 
    3d88:	48 8b 35 71 c4 00 00 	mov    0xc471(%rip),%rsi        # 10200 <fwp_gc+0x1058>
    3d8f:	48 c1 e6 10          	shl    $0x10,%rsi
    3d93:	48 39 f2             	cmp    %rsi,%rdx
    3d96:	0f 83 c4 00 00 00    	jae    3e60 <fwp_apply_borrowed+0x170>
    3d9c:	48 8b 35 7d c4 00 00 	mov    0xc47d(%rip),%rsi        # 10220 <fwp_gc+0x1078>
    3da3:	48 89 d7             	mov    %rdx,%rdi
    3da6:	48 c1 ef 10          	shr    $0x10,%rdi
    3daa:	48 69 ff 28 12 00 00 	imul   $0x1228,%rdi,%rdi
    3db1:	44 0f b6 04 3e       	movzbl (%rsi,%rdi,1),%r8d
    3db6:	41 80 f8 02          	cmp    $0x2,%r8b
    3dba:	41 0f 94 c2          	sete   %r10b
    3dbe:	48 81 e2 ff ff 00 00 	and    $0xffff,%rdx
    3dc5:	41 0f 94 c1          	sete   %r9b
    3dc9:	45 20 d1             	and    %r10b,%r9b
    3dcc:	41 80 f9 01          	cmp    $0x1,%r9b
    3dd0:	75 0e                	jne    3de0 <fwp_apply_borrowed+0xf0>
    3dd2:	4c 8d 14 3e          	lea    (%rsi,%rdi,1),%r10
    3dd6:	49 81 c2 28 02 00 00 	add    $0x228,%r10
    3ddd:	eb 22                	jmp    3e01 <fwp_apply_borrowed+0x111>
    3ddf:	90                   	nop
    3de0:	41 80 f8 01          	cmp    $0x1,%r8b
    3de4:	75 7a                	jne    3e60 <fwp_apply_borrowed+0x170>
    3de6:	4c 8d 14 3e          	lea    (%rsi,%rdi,1),%r10
    3dea:	44 8b 5c 3e 20       	mov    0x20(%rsi,%rdi,1),%r11d
    3def:	4c 0f af da          	imul   %rdx,%r11
    3df3:	49 c1 eb 20          	shr    $0x20,%r11
    3df7:	4d 01 da             	add    %r11,%r10
    3dfa:	49 81 c2 28 02 00 00 	add    $0x228,%r10
    3e01:	41 80 3a 00          	cmpb   $0x0,(%r10)
    3e05:	41 0f 95 c3          	setne  %r11b
    3e09:	74 2e                	je     3e39 <fwp_apply_borrowed+0x149>
    3e0b:	4c 8b 15 56 ce 00 00 	mov    0xce56(%rip),%r10        # 10c68 <fwp_cleanups>
    3e12:	4c 89 54 24 58       	mov    %r10,0x58(%rsp)
    3e17:	4c 8d 15 32 0b 00 00 	lea    0xb32(%rip),%r10        # 4950 <fwp_apply_release>
    3e1e:	4c 89 54 24 60       	mov    %r10,0x60(%rsp)
    3e23:	4c 8d 54 24 70       	lea    0x70(%rsp),%r10
    3e28:	4c 89 54 24 68       	mov    %r10,0x68(%rsp)
    3e2d:	4c 8d 54 24 58       	lea    0x58(%rsp),%r10
    3e32:	4c 89 15 2f ce 00 00 	mov    %r10,0xce2f(%rip)        # 10c68 <fwp_cleanups>
    3e39:	f6 c1 01             	test   $0x1,%cl
    3e3c:	44 89 1c 24          	mov    %r11d,(%rsp)
    3e40:	75 77                	jne    3eb9 <fwp_apply_borrowed+0x1c9>
    3e42:	45 84 c9             	test   %r9b,%r9b
    3e45:	74 27                	je     3e6e <fwp_apply_borrowed+0x17e>
    3e47:	48 01 f7             	add    %rsi,%rdi
    3e4a:	48 81 c7 28 02 00 00 	add    $0x228,%rdi
    3e51:	eb 3c                	jmp    3e8f <fwp_apply_borrowed+0x19f>
    3e53:	66 66 66 66 2e 0f 1f 	data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    3e5a:	84 00 00 00 00 00 
    3e60:	c7 04 24 00 00 00 00 	movl   $0x0,(%rsp)
    3e67:	f6 c1 01             	test   $0x1,%cl
    3e6a:	74 44                	je     3eb0 <fwp_apply_borrowed+0x1c0>
    3e6c:	eb 4b                	jmp    3eb9 <fwp_apply_borrowed+0x1c9>
    3e6e:	41 80 f8 01          	cmp    $0x1,%r8b
    3e72:	75 3c                	jne    3eb0 <fwp_apply_borrowed+0x1c0>
    3e74:	48 8d 04 3e          	lea    (%rsi,%rdi,1),%rax
    3e78:	8b 4c 3e 20          	mov    0x20(%rsi,%rdi,1),%ecx
    3e7c:	48 0f af d1          	imul   %rcx,%rdx
    3e80:	48 c1 ea 20          	shr    $0x20,%rdx
    3e84:	48 8d 3c 02          	lea    (%rdx,%rax,1),%rdi
    3e88:	48 81 c7 28 02 00 00 	add    $0x228,%rdi
    3e8f:	0f b6 07             	movzbl (%rdi),%eax
    3e92:	84 c0                	test   %al,%al
    3e94:	74 1a                	je     3eb0 <fwp_apply_borrowed+0x1c0>
    3e96:	3c fe                	cmp    $0xfe,%al
    3e98:	0f 83 a3 01 00 00    	jae    4041 <fwp_apply_borrowed+0x351>
    3e9e:	fe c0                	inc    %al
    3ea0:	88 07                	mov    %al,(%rdi)
    3ea2:	66 66 66 66 66 2e 0f 	data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    3ea9:	1f 84 00 00 00 00 00 
    3eb0:	48 89 5c 24 70       	mov    %rbx,0x70(%rsp)
    3eb5:	49 8b 45 00          	mov    0x0(%r13),%rax
    3eb9:	45 8b 3f             	mov    (%r15),%r15d
    3ebc:	44 2b 7b 04          	sub    0x4(%rbx),%r15d
    3ec0:	44 39 fd             	cmp    %r15d,%ebp
    3ec3:	44 89 7c 24 0c       	mov    %r15d,0xc(%rsp)
    3ec8:	44 0f 42 fd          	cmovb  %ebp,%r15d
    3ecc:	48 c7 44 24 30 00 00 	movq   $0x0,0x30(%rsp)
    3ed3:	00 00 
    3ed5:	4c 89 64 24 38       	mov    %r12,0x38(%rsp)
    3eda:	48 89 44 24 40       	mov    %rax,0x40(%rsp)
    3edf:	c7 44 24 48 00 00 00 	movl   $0x0,0x48(%rsp)
    3ee6:	00 
    3ee7:	8b 4b 04             	mov    0x4(%rbx),%ecx
    3eea:	89 4c 24 4c          	mov    %ecx,0x4c(%rsp)
    3eee:	c7 44 24 50 00 00 00 	movl   $0x0,0x50(%rsp)
    3ef5:	00 
    3ef6:	45 89 fe             	mov    %r15d,%r14d
    3ef9:	45 85 ff             	test   %r15d,%r15d
    3efc:	0f 84 8e 00 00 00    	je     3f90 <fwp_apply_borrowed+0x2a0>
    3f02:	89 6c 24 08          	mov    %ebp,0x8(%rsp)
    3f06:	48 83 78 18 00       	cmpq   $0x0,0x18(%rax)
    3f0b:	0f 95 c0             	setne  %al
    3f0e:	89 44 24 04          	mov    %eax,0x4(%rsp)
    3f12:	74 2e                	je     3f42 <fwp_apply_borrowed+0x252>
    3f14:	48 8b 05 4d cd 00 00 	mov    0xcd4d(%rip),%rax        # 10c68 <fwp_cleanups>
    3f1b:	48 89 44 24 18       	mov    %rax,0x18(%rsp)
    3f20:	48 8d 05 29 0a 00 00 	lea    0xa29(%rip),%rax        # 4950 <fwp_apply_release>
    3f27:	48 89 44 24 20       	mov    %rax,0x20(%rsp)
    3f2c:	48 8d 44 24 30       	lea    0x30(%rsp),%rax
    3f31:	48 89 44 24 28       	mov    %rax,0x28(%rsp)
    3f36:	48 8d 44 24 18       	lea    0x18(%rsp),%rax
    3f3b:	48 89 05 26 cd 00 00 	mov    %rax,0xcd26(%rip)        # 10c68 <fwp_cleanups>
    3f42:	4c 89 64 24 10       	mov    %r12,0x10(%rsp)
    3f47:	31 ed                	xor    %ebp,%ebp
    3f49:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)
    3f50:	49 8b 45 00          	mov    0x0(%r13),%rax
    3f54:	8b 73 04             	mov    0x4(%rbx),%esi
    3f57:	01 ee                	add    %ebp,%esi
    3f59:	4c 89 e7             	mov    %r12,%rdi
    3f5c:	ba 01 00 00 00       	mov    $0x1,%edx
    3f61:	ff 50 10             	call   *0x10(%rax)
    3f64:	8b 44 24 50          	mov    0x50(%rsp),%eax
    3f68:	ff c0                	inc    %eax
    3f6a:	89 44 24 50          	mov    %eax,0x50(%rsp)
    3f6e:	48 ff c5             	inc    %rbp
    3f71:	49 83 c4 08          	add    $0x8,%r12
    3f75:	49 39 ee             	cmp    %rbp,%r14
    3f78:	75 d6                	jne    3f50 <fwp_apply_borrowed+0x260>
    3f7a:	4c 8b 64 24 10       	mov    0x10(%rsp),%r12
    3f7f:	8b 6c 24 08          	mov    0x8(%rsp),%ebp
    3f83:	44 8b 6c 24 04       	mov    0x4(%rsp),%r13d
    3f88:	eb 0b                	jmp    3f95 <fwp_apply_borrowed+0x2a5>
    3f8a:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)
    3f90:	45 31 ed             	xor    %r13d,%r13d
    3f93:	31 c0                	xor    %eax,%eax
    3f95:	89 44 24 48          	mov    %eax,0x48(%rsp)
    3f99:	48 c7 44 24 70 00 00 	movq   $0x0,0x70(%rsp)
    3fa0:	00 00 
    3fa2:	c7 84 24 88 00 00 00 	movl   $0x0,0x88(%rsp)
    3fa9:	00 00 00 00 
    3fad:	48 89 df             	mov    %rbx,%rdi
    3fb0:	44 89 fe             	mov    %r15d,%esi
    3fb3:	4c 89 e2             	mov    %r12,%rdx
    3fb6:	e8 05 0a 00 00       	call   49c0 <fwp_apply_owned>
    3fbb:	48 89 c3             	mov    %rax,%rbx
    3fbe:	45 84 ed             	test   %r13b,%r13b
    3fc1:	74 1e                	je     3fe1 <fwp_apply_borrowed+0x2f1>
    3fc3:	48 8d 44 24 18       	lea    0x18(%rsp),%rax
    3fc8:	48 39 05 99 cc 00 00 	cmp    %rax,0xcc99(%rip)        # 10c68 <fwp_cleanups>
    3fcf:	0f 85 c8 01 00 00    	jne    419d <fwp_apply_borrowed+0x4ad>
    3fd5:	48 8b 44 24 18       	mov    0x18(%rsp),%rax
    3fda:	48 89 05 87 cc 00 00 	mov    %rax,0xcc87(%rip)        # 10c68 <fwp_cleanups>
    3fe1:	80 3c 24 00          	cmpb   $0x0,(%rsp)
    3fe5:	74 1e                	je     4005 <fwp_apply_borrowed+0x315>
    3fe7:	48 8d 44 24 58       	lea    0x58(%rsp),%rax
    3fec:	48 39 05 75 cc 00 00 	cmp    %rax,0xcc75(%rip)        # 10c68 <fwp_cleanups>
    3ff3:	0f 85 a4 01 00 00    	jne    419d <fwp_apply_borrowed+0x4ad>
    3ff9:	48 8b 44 24 58       	mov    0x58(%rsp),%rax
    3ffe:	48 89 05 63 cc 00 00 	mov    %rax,0xcc63(%rip)        # 10c68 <fwp_cleanups>
    4005:	3b 6c 24 0c          	cmp    0xc(%rsp),%ebp
    4009:	0f 86 79 01 00 00    	jbe    4188 <fwp_apply_borrowed+0x498>
    400f:	4f 8d 24 f4          	lea    (%r12,%r14,8),%r12
    4013:	44 29 fd             	sub    %r15d,%ebp
    4016:	48 8b 05 23 cc 00 00 	mov    0xcc23(%rip),%rax        # 10c40 <fwp_fns>
    401d:	8b 0b                	mov    (%rbx),%ecx
    401f:	48 c1 e1 05          	shl    $0x5,%rcx
    4023:	4c 8d 3c 08          	lea    (%rax,%rcx,1),%r15
    4027:	4c 8d 2c 08          	lea    (%rax,%rcx,1),%r13
    402b:	49 83 c5 18          	add    $0x18,%r13
    402f:	48 8b 44 08 18       	mov    0x18(%rax,%rcx,1),%rax
    4034:	b1 01                	mov    $0x1,%cl
    4036:	48 85 c0             	test   %rax,%rax
    4039:	0f 85 01 fd ff ff    	jne    3d40 <fwp_apply_borrowed+0x50>
    403f:	eb 0f                	jmp    4050 <fwp_apply_borrowed+0x360>
    4041:	e8 4a 23 00 00       	call   6390 <fwp_rc_wide_dup>
    4046:	e9 65 fe ff ff       	jmp    3eb0 <fwp_apply_borrowed+0x1c0>
    404b:	bd 01 00 00 00       	mov    $0x1,%ebp
    4050:	48 8b 05 81 c1 00 00 	mov    0xc181(%rip),%rax        # 101d8 <fwp_gc+0x1030>
    4057:	48 89 da             	mov    %rbx,%rdx
    405a:	48 29 c2             	sub    %rax,%rdx
    405d:	48 8b 0d 9c c1 00 00 	mov    0xc19c(%rip),%rcx        # 10200 <fwp_gc+0x1058>
    4064:	48 c1 e1 10          	shl    $0x10,%rcx
    4068:	48 39 ca             	cmp    %rcx,%rdx
    406b:	73 67                	jae    40d4 <fwp_apply_borrowed+0x3e4>
    406d:	48 8b 35 ac c1 00 00 	mov    0xc1ac(%rip),%rsi        # 10220 <fwp_gc+0x1078>
    4074:	48 89 d7             	mov    %rdx,%rdi
    4077:	48 c1 ef 10          	shr    $0x10,%rdi
    407b:	48 69 ff 28 12 00 00 	imul   $0x1228,%rdi,%rdi
    4082:	44 0f b6 04 3e       	movzbl (%rsi,%rdi,1),%r8d
    4087:	48 81 e2 ff ff 00 00 	and    $0xffff,%rdx
    408e:	75 1b                	jne    40ab <fwp_apply_borrowed+0x3bb>
    4090:	41 80 f8 02          	cmp    $0x2,%r8b
    4094:	75 15                	jne    40ab <fwp_apply_borrowed+0x3bb>
    4096:	48 8d 14 3e          	lea    (%rsi,%rdi,1),%rdx
    409a:	48 81 c2 28 02 00 00 	add    $0x228,%rdx
    40a1:	80 3a 00             	cmpb   $0x0,(%rdx)
    40a4:	74 2e                	je     40d4 <fwp_apply_borrowed+0x3e4>
    40a6:	e9 f7 00 00 00       	jmp    41a2 <fwp_apply_borrowed+0x4b2>
    40ab:	41 80 f8 01          	cmp    $0x1,%r8b
    40af:	75 23                	jne    40d4 <fwp_apply_borrowed+0x3e4>
    40b1:	4c 8d 04 3e          	lea    (%rsi,%rdi,1),%r8
    40b5:	8b 74 3e 20          	mov    0x20(%rsi,%rdi,1),%esi
    40b9:	48 0f af d6          	imul   %rsi,%rdx
    40bd:	48 c1 ea 20          	shr    $0x20,%rdx
    40c1:	4c 01 c2             	add    %r8,%rdx
    40c4:	48 81 c2 28 02 00 00 	add    $0x228,%rdx
    40cb:	80 3a 00             	cmpb   $0x0,(%rdx)
    40ce:	0f 85 ce 00 00 00    	jne    41a2 <fwp_apply_borrowed+0x4b2>
    40d4:	85 ed                	test   %ebp,%ebp
    40d6:	0f 84 9c 00 00 00    	je     4178 <fwp_apply_borrowed+0x488>
    40dc:	48 8b 15 3d c1 00 00 	mov    0xc13d(%rip),%rdx        # 10220 <fwp_gc+0x1078>
    40e3:	89 ee                	mov    %ebp,%esi
    40e5:	31 ff                	xor    %edi,%edi
    40e7:	eb 27                	jmp    4110 <fwp_apply_borrowed+0x420>
    40e9:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)
    40f0:	4e 8d 04 0a          	lea    (%rdx,%r9,1),%r8
    40f4:	49 81 c0 28 02 00 00 	add    $0x228,%r8
    40fb:	41 80 38 00          	cmpb   $0x0,(%r8)
    40ff:	74 6f                	je     4170 <fwp_apply_borrowed+0x480>
    4101:	e9 9c 00 00 00       	jmp    41a2 <fwp_apply_borrowed+0x4b2>
    4106:	66 2e 0f 1f 84 00 00 	cs nopw 0x0(%rax,%rax,1)
    410d:	00 00 00 
    4110:	4d 8b 04 fc          	mov    (%r12,%rdi,8),%r8
    4114:	49 29 c0             	sub    %rax,%r8
    4117:	49 39 c8             	cmp    %rcx,%r8
    411a:	73 54                	jae    4170 <fwp_apply_borrowed+0x480>
    411c:	4d 89 c1             	mov    %r8,%r9
    411f:	49 c1 e9 10          	shr    $0x10,%r9
    4123:	4d 69 c9 28 12 00 00 	imul   $0x1228,%r9,%r9
    412a:	46 0f b6 14 0a       	movzbl (%rdx,%r9,1),%r10d
    412f:	49 81 e0 ff ff 00 00 	and    $0xffff,%r8
    4136:	75 06                	jne    413e <fwp_apply_borrowed+0x44e>
    4138:	41 80 fa 02          	cmp    $0x2,%r10b
    413c:	74 b2                	je     40f0 <fwp_apply_borrowed+0x400>
    413e:	41 80 fa 01          	cmp    $0x1,%r10b
    4142:	75 2c                	jne    4170 <fwp_apply_borrowed+0x480>
    4144:	4e 8d 14 0a          	lea    (%rdx,%r9,1),%r10
    4148:	46 8b 4c 0a 20       	mov    0x20(%rdx,%r9,1),%r9d
    414d:	4d 0f af c1          	imul   %r9,%r8
    4151:	49 c1 e8 20          	shr    $0x20,%r8
    4155:	4d 01 d0             	add    %r10,%r8
    4158:	49 81 c0 28 02 00 00 	add    $0x228,%r8
    415f:	41 80 38 00          	cmpb   $0x0,(%r8)
    4163:	75 3d                	jne    41a2 <fwp_apply_borrowed+0x4b2>
    4165:	66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
    416c:	00 00 00 00 
    4170:	48 ff c7             	inc    %rdi
    4173:	48 39 fe             	cmp    %rdi,%rsi
    4176:	75 98                	jne    4110 <fwp_apply_borrowed+0x420>
    4178:	48 89 df             	mov    %rbx,%rdi
    417b:	89 ee                	mov    %ebp,%esi
    417d:	4c 89 e2             	mov    %r12,%rdx
    4180:	e8 6b 02 00 00       	call   43f0 <fwp_apply>
    4185:	48 89 c3             	mov    %rax,%rbx
    4188:	48 89 d8             	mov    %rbx,%rax
    418b:	48 81 c4 98 00 00 00 	add    $0x98,%rsp
    4192:	5b                   	pop    %rbx
    4193:	41 5c                	pop    %r12
    4195:	41 5d                	pop    %r13
    4197:	41 5e                	pop    %r14
    4199:	41 5f                	pop    %r15
    419b:	5d                   	pop    %rbp
    419c:	c3                   	ret
    419d:	e8 be de ff ff       	call   2060 <abort@plt>
    41a2:	e8 09 f6 ff ff       	call   37b0 <fwp_flush>
    41a7:	48 8b 05 32 ae 00 00 	mov    0xae32(%rip),%rax        # efe0 <stderr@GLIBC_2.2.5>
    41ae:	48 8b 38             	mov    (%rax),%rdi
    41b1:	48 8d 35 7c 81 00 00 	lea    0x817c(%rip),%rsi        # c334 <fwp_segv.msg+0xf4>
    41b8:	48 8d 15 48 81 00 00 	lea    0x8148(%rip),%rdx        # c307 <fwp_segv.msg+0xc7>
    41bf:	31 c0                	xor    %eax,%eax
    41c1:	e8 1a e0 ff ff       	call   21e0 <fprintf@plt>
    41c6:	bf 65 00 00 00       	mov    $0x65,%edi
    41cb:	e8 00 e1 ff ff       	call   22d0 <exit@plt>

00000000000041d0 <fwp_data>:
    41d0:	55                   	push   %rbp
    41d1:	41 57                	push   %r15
    41d3:	41 56                	push   %r14
    41d5:	41 55                	push   %r13
    41d7:	41 54                	push   %r12
    41d9:	53                   	push   %rbx
    41da:	50                   	push   %rax
    41db:	48 89 d3             	mov    %rdx,%rbx
    41de:	89 f5                	mov    %esi,%ebp
    41e0:	41 89 ff             	mov    %edi,%r15d
    41e3:	41 89 f4             	mov    %esi,%r12d
    41e6:	4e 8d 2c e5 00 00 00 	lea    0x0(,%r12,8),%r13
    41ed:	00 
    41ee:	4a 8d 3c e5 08 00 00 	lea    0x8(,%r12,8),%rdi
    41f5:	00 
    41f6:	81 fe ff 07 00 00    	cmp    $0x7ff,%esi
    41fc:	0f 87 e6 00 00 00    	ja     42e8 <fwp_data+0x118>
    4202:	49 8d 75 17          	lea    0x17(%r13),%rsi
    4206:	48 c1 ee 04          	shr    $0x4,%rsi
    420a:	48 8d 05 97 af 00 00 	lea    0xaf97(%rip),%rax        # f1a8 <fwp_gc>
    4211:	0f b6 8c 06 e8 0b 00 	movzbl 0xbe8(%rsi,%rax,1),%ecx
    4218:	00 
    4219:	8b 94 88 48 0b 00 00 	mov    0xb48(%rax,%rcx,4),%edx
    4220:	4c 8b 05 81 af 00 00 	mov    0xaf81(%rip),%r8        # f1a8 <fwp_gc>
    4227:	4d 89 c1             	mov    %r8,%r9
    422a:	49 29 d1             	sub    %rdx,%r9
    422d:	4c 89 0d 74 af 00 00 	mov    %r9,0xaf74(%rip)        # f1a8 <fwp_gc>
    4234:	0f 88 ae 00 00 00    	js     42e8 <fwp_data+0x118>
    423a:	4c 8d 0c 49          	lea    (%rcx,%rcx,2),%r9
    423e:	4e 8d 14 c8          	lea    (%rax,%r9,8),%r10
    4242:	49 83 c2 08          	add    $0x8,%r10
    4246:	4d 8b 32             	mov    (%r10),%r14
    4249:	4d 85 f6             	test   %r14,%r14
    424c:	74 29                	je     4277 <fwp_data+0xa7>
    424e:	49 8b 06             	mov    (%r14),%rax
    4251:	48 f7 d0             	not    %rax
    4254:	49 89 02             	mov    %rax,(%r10)
    4257:	48 39 d7             	cmp    %rdx,%rdi
    425a:	0f 83 ad 00 00 00    	jae    430d <fwp_data+0x13d>
    4260:	4c 01 f7             	add    %r14,%rdi
    4263:	4c 29 ea             	sub    %r13,%rdx
    4266:	48 83 c2 f7          	add    $0xfffffffffffffff7,%rdx
    426a:	48 83 e2 f8          	and    $0xfffffffffffffff8,%rdx
    426e:	48 83 c2 08          	add    $0x8,%rdx
    4272:	e9 8f 00 00 00       	jmp    4306 <fwp_data+0x136>
    4277:	4e 8b 74 c8 10       	mov    0x10(%rax,%r9,8),%r14
    427c:	4e 8b 54 c8 18       	mov    0x18(%rax,%r9,8),%r10
    4281:	4d 29 f2             	sub    %r14,%r10
    4284:	49 39 d2             	cmp    %rdx,%r10
    4287:	72 2f                	jb     42b8 <fwp_data+0xe8>
    4289:	4a 8d 0c c8          	lea    (%rax,%r9,8),%rcx
    428d:	48 83 c1 10          	add    $0x10,%rcx
    4291:	4d 8d 0c 16          	lea    (%r14,%rdx,1),%r9
    4295:	4c 89 09             	mov    %r9,(%rcx)
    4298:	4d 85 f6             	test   %r14,%r14
    429b:	75 ba                	jne    4257 <fwp_data+0x87>
    429d:	0f b6 8c 06 e8 0b 00 	movzbl 0xbe8(%rsi,%rax,1),%ecx
    42a4:	00 
    42a5:	8b 94 88 48 0b 00 00 	mov    0xb48(%rax,%rcx,4),%edx
    42ac:	49 29 d0             	sub    %rdx,%r8
    42af:	4c 89 05 f2 ae 00 00 	mov    %r8,0xaef2(%rip)        # f1a8 <fwp_gc>
    42b6:	78 30                	js     42e8 <fwp_data+0x118>
    42b8:	48 8d 0c 49          	lea    (%rcx,%rcx,2),%rcx
    42bc:	4c 8b 74 c8 08       	mov    0x8(%rax,%rcx,8),%r14
    42c1:	4d 85 f6             	test   %r14,%r14
    42c4:	74 10                	je     42d6 <fwp_data+0x106>
    42c6:	48 8d 04 c8          	lea    (%rax,%rcx,8),%rax
    42ca:	48 83 c0 08          	add    $0x8,%rax
    42ce:	49 8b 0e             	mov    (%r14),%rcx
    42d1:	48 f7 d1             	not    %rcx
    42d4:	eb 2a                	jmp    4300 <fwp_data+0x130>
    42d6:	4c 8b 74 c8 10       	mov    0x10(%rax,%rcx,8),%r14
    42db:	48 8b 74 c8 18       	mov    0x18(%rax,%rcx,8),%rsi
    42e0:	4c 29 f6             	sub    %r14,%rsi
    42e3:	48 39 d6             	cmp    %rdx,%rsi
    42e6:	73 0c                	jae    42f4 <fwp_data+0x124>
    42e8:	31 f6                	xor    %esi,%esi
    42ea:	e8 81 11 00 00       	call   5470 <fwp_gc_alloc_slow>
    42ef:	49 89 c6             	mov    %rax,%r14
    42f2:	eb 19                	jmp    430d <fwp_data+0x13d>
    42f4:	48 8d 04 c8          	lea    (%rax,%rcx,8),%rax
    42f8:	48 83 c0 10          	add    $0x10,%rax
    42fc:	49 8d 0c 16          	lea    (%r14,%rdx,1),%rcx
    4300:	48 89 08             	mov    %rcx,(%rax)
    4303:	4c 89 f7             	mov    %r14,%rdi
    4306:	31 f6                	xor    %esi,%esi
    4308:	e8 53 de ff ff       	call   2160 <memset@plt>
    430d:	45 89 3e             	mov    %r15d,(%r14)
    4310:	41 89 6e 04          	mov    %ebp,0x4(%r14)
    4314:	85 ed                	test   %ebp,%ebp
    4316:	0f 84 bb 00 00 00    	je     43d7 <fwp_data+0x207>
    431c:	83 fd 08             	cmp    $0x8,%ebp
    431f:	72 10                	jb     4331 <fwp_data+0x161>
    4321:	4c 89 f0             	mov    %r14,%rax
    4324:	48 29 d8             	sub    %rbx,%rax
    4327:	48 83 c0 08          	add    $0x8,%rax
    432b:	48 83 f8 20          	cmp    $0x20,%rax
    432f:	73 71                	jae    43a2 <fwp_data+0x1d2>
    4331:	31 c0                	xor    %eax,%eax
    4333:	4c 89 e2             	mov    %r12,%rdx
    4336:	48 89 c1             	mov    %rax,%rcx
    4339:	48 83 e2 03          	and    $0x3,%rdx
    433d:	74 22                	je     4361 <fwp_data+0x191>
    433f:	48 89 c1             	mov    %rax,%rcx
    4342:	66 66 66 66 66 2e 0f 	data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    4349:	1f 84 00 00 00 00 00 
    4350:	48 8b 34 cb          	mov    (%rbx,%rcx,8),%rsi
    4354:	49 89 74 ce 08       	mov    %rsi,0x8(%r14,%rcx,8)
    4359:	48 ff c1             	inc    %rcx
    435c:	48 ff ca             	dec    %rdx
    435f:	75 ef                	jne    4350 <fwp_data+0x180>
    4361:	4c 29 e0             	sub    %r12,%rax
    4364:	48 83 f8 fc          	cmp    $0xfffffffffffffffc,%rax
    4368:	77 6d                	ja     43d7 <fwp_data+0x207>
    436a:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)
    4370:	48 8b 04 cb          	mov    (%rbx,%rcx,8),%rax
    4374:	49 89 44 ce 08       	mov    %rax,0x8(%r14,%rcx,8)
    4379:	48 8b 44 cb 08       	mov    0x8(%rbx,%rcx,8),%rax
    437e:	49 89 44 ce 10       	mov    %rax,0x10(%r14,%rcx,8)
    4383:	48 8b 44 cb 10       	mov    0x10(%rbx,%rcx,8),%rax
    4388:	49 89 44 ce 18       	mov    %rax,0x18(%r14,%rcx,8)
    438d:	48 8b 44 cb 18       	mov    0x18(%rbx,%rcx,8),%rax
    4392:	49 89 44 ce 20       	mov    %rax,0x20(%r14,%rcx,8)
    4397:	48 83 c1 04          	add    $0x4,%rcx
    439b:	49 39 cc             	cmp    %rcx,%r12
    439e:	75 d0                	jne    4370 <fwp_data+0x1a0>
    43a0:	eb 35                	jmp    43d7 <fwp_data+0x207>
    43a2:	44 89 e0             	mov    %r12d,%eax
    43a5:	83 e0 fc             	and    $0xfffffffc,%eax
    43a8:	49 83 e5 e0          	and    $0xffffffffffffffe0,%r13
    43ac:	31 c9                	xor    %ecx,%ecx
    43ae:	66 90                	xchg   %ax,%ax
    43b0:	0f 10 04 0b          	movups (%rbx,%rcx,1),%xmm0
    43b4:	0f 10 4c 0b 10       	movups 0x10(%rbx,%rcx,1),%xmm1
    43b9:	41 0f 11 44 0e 08    	movups %xmm0,0x8(%r14,%rcx,1)
    43bf:	41 0f 11 4c 0e 18    	movups %xmm1,0x18(%r14,%rcx,1)
    43c5:	48 83 c1 20          	add    $0x20,%rcx
    43c9:	49 39 cd             	cmp    %rcx,%r13
    43cc:	75 e2                	jne    43b0 <fwp_data+0x1e0>
    43ce:	4c 39 e0             	cmp    %r12,%rax
    43d1:	0f 85 5c ff ff ff    	jne    4333 <fwp_data+0x163>
    43d7:	4c 89 f0             	mov    %r14,%rax
    43da:	48 83 c4 08          	add    $0x8,%rsp
    43de:	5b                   	pop    %rbx
    43df:	41 5c                	pop    %r12
    43e1:	41 5d                	pop    %r13
    43e3:	41 5e                	pop    %r14
    43e5:	41 5f                	pop    %r15
    43e7:	5d                   	pop    %rbp
    43e8:	c3                   	ret
    43e9:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)

00000000000043f0 <fwp_apply>:
    43f0:	55                   	push   %rbp
    43f1:	48 89 e5             	mov    %rsp,%rbp
    43f4:	41 57                	push   %r15
    43f6:	41 56                	push   %r14
    43f8:	41 55                	push   %r13
    43fa:	41 54                	push   %r12
    43fc:	53                   	push   %rbx
    43fd:	48 83 ec 18          	sub    $0x18,%rsp
    4401:	48 89 d3             	mov    %rdx,%rbx
    4404:	49 89 ff             	mov    %rdi,%r15
    4407:	eb 23                	jmp    442c <fwp_apply+0x3c>
    4409:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)
    4410:	4a 8d 1c f3          	lea    (%rbx,%r14,8),%rbx
    4414:	31 c9                	xor    %ecx,%ecx
    4416:	49 89 c7             	mov    %rax,%r15
    4419:	4c 8b 75 c8          	mov    -0x38(%rbp),%r14
    441d:	48 8b 65 c0          	mov    -0x40(%rbp),%rsp
    4421:	89 d6                	mov    %edx,%esi
    4423:	83 f9 01             	cmp    $0x1,%ecx
    4426:	0f 84 aa 04 00 00    	je     48d6 <fwp_apply+0x4e6>
    442c:	48 8b 05 0d c8 00 00 	mov    0xc80d(%rip),%rax        # 10c40 <fwp_fns>
    4433:	41 8b 0f             	mov    (%r15),%ecx
    4436:	45 8b 6f 04          	mov    0x4(%r15),%r13d
    443a:	48 c1 e1 05          	shl    $0x5,%rcx
    443e:	44 8b 24 08          	mov    (%rax,%rcx,1),%r12d
    4442:	4d 85 ed             	test   %r13,%r13
    4445:	75 39                	jne    4480 <fwp_apply+0x90>
    4447:	41 8d 54 24 ff       	lea    -0x1(%r12),%edx
    444c:	39 f2                	cmp    %esi,%edx
    444e:	73 30                	jae    4480 <fwp_apply+0x90>
    4450:	48 89 df             	mov    %rbx,%rdi
    4453:	49 89 f7             	mov    %rsi,%r15
    4456:	ff 54 08 08          	call   *0x8(%rax,%rcx,1)
    445a:	4c 89 fe             	mov    %r15,%rsi
    445d:	49 89 c7             	mov    %rax,%r15
    4460:	44 39 e6             	cmp    %r12d,%esi
    4463:	0f 84 a4 02 00 00    	je     470d <fwp_apply+0x31d>
    4469:	4a 8d 1c e3          	lea    (%rbx,%r12,8),%rbx
    446d:	44 29 e6             	sub    %r12d,%esi
    4470:	b9 03 00 00 00       	mov    $0x3,%ecx
    4475:	83 f9 01             	cmp    $0x1,%ecx
    4478:	75 b2                	jne    442c <fwp_apply+0x3c>
    447a:	e9 57 04 00 00       	jmp    48d6 <fwp_apply+0x4e6>
    447f:	90                   	nop
    4480:	4c 89 75 c8          	mov    %r14,-0x38(%rbp)
    4484:	46 8d 34 2e          	lea    (%rsi,%r13,1),%r14d
    4488:	45 39 e6             	cmp    %r12d,%r14d
    448b:	48 89 75 d0          	mov    %rsi,-0x30(%rbp)
    448f:	0f 82 1a 02 00 00    	jb     46af <fwp_apply+0x2bf>
    4495:	48 89 65 c0          	mov    %rsp,-0x40(%rbp)
    4499:	45 89 e3             	mov    %r12d,%r11d
    449c:	41 83 fc 02          	cmp    $0x2,%r12d
    44a0:	ba 01 00 00 00       	mov    $0x1,%edx
    44a5:	41 0f 43 d4          	cmovae %r12d,%edx
    44a9:	48 8d 14 d5 0f 00 00 	lea    0xf(,%rdx,8),%rdx
    44b0:	00 
    44b1:	48 83 e2 f0          	and    $0xfffffffffffffff0,%rdx
    44b5:	48 89 e7             	mov    %rsp,%rdi
    44b8:	48 29 d7             	sub    %rdx,%rdi
    44bb:	48 89 fc             	mov    %rdi,%rsp
    44be:	4d 85 ed             	test   %r13,%r13
    44c1:	0f 84 c9 00 00 00    	je     4590 <fwp_apply+0x1a0>
    44c7:	41 83 fd 04          	cmp    $0x4,%r13d
    44cb:	72 10                	jb     44dd <fwp_apply+0xed>
    44cd:	48 89 fa             	mov    %rdi,%rdx
    44d0:	4c 29 fa             	sub    %r15,%rdx
    44d3:	48 83 c2 f8          	add    $0xfffffffffffffff8,%rdx
    44d7:	48 83 fa 20          	cmp    $0x20,%rdx
    44db:	73 65                	jae    4542 <fwp_apply+0x152>
    44dd:	31 d2                	xor    %edx,%edx
    44df:	4d 89 e8             	mov    %r13,%r8
    44e2:	49 89 d2             	mov    %rdx,%r10
    44e5:	49 83 e0 03          	and    $0x3,%r8
    44e9:	74 16                	je     4501 <fwp_apply+0x111>
    44eb:	49 89 d2             	mov    %rdx,%r10
    44ee:	66 90                	xchg   %ax,%ax
    44f0:	4f 8b 4c d7 08       	mov    0x8(%r15,%r10,8),%r9
    44f5:	4e 89 0c d7          	mov    %r9,(%rdi,%r10,8)
    44f9:	49 ff c2             	inc    %r10
    44fc:	49 ff c8             	dec    %r8
    44ff:	75 ef                	jne    44f0 <fwp_apply+0x100>
    4501:	4c 29 ea             	sub    %r13,%rdx
    4504:	48 83 fa fc          	cmp    $0xfffffffffffffffc,%rdx
    4508:	0f 87 82 00 00 00    	ja     4590 <fwp_apply+0x1a0>
    450e:	66 90                	xchg   %ax,%ax
    4510:	4b 8b 54 d7 08       	mov    0x8(%r15,%r10,8),%rdx
    4515:	4a 89 14 d7          	mov    %rdx,(%rdi,%r10,8)
    4519:	4b 8b 54 d7 10       	mov    0x10(%r15,%r10,8),%rdx
    451e:	4a 89 54 d7 08       	mov    %rdx,0x8(%rdi,%r10,8)
    4523:	4b 8b 54 d7 18       	mov    0x18(%r15,%r10,8),%rdx
    4528:	4a 89 54 d7 10       	mov    %rdx,0x10(%rdi,%r10,8)
    452d:	4b 8b 54 d7 20       	mov    0x20(%r15,%r10,8),%rdx
    4532:	4a 89 54 d7 18       	mov    %rdx,0x18(%rdi,%r10,8)
    4537:	49 83 c2 04          	add    $0x4,%r10
    453b:	4d 39 d5             	cmp    %r10,%r13
    453e:	75 d0                	jne    4510 <fwp_apply+0x120>
    4540:	eb 4e                	jmp    4590 <fwp_apply+0x1a0>
    4542:	44 89 ea             	mov    %r13d,%edx
    4545:	83 e2 fc             	and    $0xfffffffc,%edx
    4548:	4e 8d 0c ed 00 00 00 	lea    0x0(,%r13,8),%r9
    454f:	00 
    4550:	49 83 e1 e0          	and    $0xffffffffffffffe0,%r9
    4554:	45 31 c0             	xor    %r8d,%r8d
    4557:	66 0f 1f 84 00 00 00 	nopw   0x0(%rax,%rax,1)
    455e:	00 00 
    4560:	43 0f 10 44 07 08    	movups 0x8(%r15,%r8,1),%xmm0
    4566:	43 0f 10 4c 07 18    	movups 0x18(%r15,%r8,1),%xmm1
    456c:	42 0f 29 04 07       	movaps %xmm0,(%rdi,%r8,1)
    4571:	42 0f 29 4c 07 10    	movaps %xmm1,0x10(%rdi,%r8,1)
    4577:	49 83 c0 20          	add    $0x20,%r8
    457b:	4d 39 c1             	cmp    %r8,%r9
    457e:	75 e0                	jne    4560 <fwp_apply+0x170>
    4580:	4c 39 ea             	cmp    %r13,%rdx
    4583:	0f 85 56 ff ff ff    	jne    44df <fwp_apply+0xef>
    4589:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)
    4590:	45 29 eb             	sub    %r13d,%r11d
    4593:	45 89 de             	mov    %r11d,%r14d
    4596:	45 39 ec             	cmp    %r13d,%r12d
    4599:	0f 84 85 00 00 00    	je     4624 <fwp_apply+0x234>
    459f:	41 83 fb 0e          	cmp    $0xe,%r11d
    45a3:	0f 83 a0 00 00 00    	jae    4649 <fwp_apply+0x259>
    45a9:	31 d2                	xor    %edx,%edx
    45ab:	4d 89 f0             	mov    %r14,%r8
    45ae:	48 89 d6             	mov    %rdx,%rsi
    45b1:	49 83 e0 03          	and    $0x3,%r8
    45b5:	74 1d                	je     45d4 <fwp_apply+0x1e4>
    45b7:	48 89 d6             	mov    %rdx,%rsi
    45ba:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)
    45c0:	4c 8b 0c f3          	mov    (%rbx,%rsi,8),%r9
    45c4:	46 8d 14 2e          	lea    (%rsi,%r13,1),%r10d
    45c8:	4e 89 0c d7          	mov    %r9,(%rdi,%r10,8)
    45cc:	48 ff c6             	inc    %rsi
    45cf:	49 ff c8             	dec    %r8
    45d2:	75 ec                	jne    45c0 <fwp_apply+0x1d0>
    45d4:	4c 29 f2             	sub    %r14,%rdx
    45d7:	48 83 fa fc          	cmp    $0xfffffffffffffffc,%rdx
    45db:	77 47                	ja     4624 <fwp_apply+0x234>
    45dd:	0f 1f 00             	nopl   (%rax)
    45e0:	48 8b 14 f3          	mov    (%rbx,%rsi,8),%rdx
    45e4:	46 8d 04 2e          	lea    (%rsi,%r13,1),%r8d
    45e8:	4a 89 14 c7          	mov    %rdx,(%rdi,%r8,8)
    45ec:	48 8b 54 f3 08       	mov    0x8(%rbx,%rsi,8),%rdx
    45f1:	46 8d 04 2e          	lea    (%rsi,%r13,1),%r8d
    45f5:	41 ff c0             	inc    %r8d
    45f8:	4a 89 14 c7          	mov    %rdx,(%rdi,%r8,8)
    45fc:	48 8b 54 f3 10       	mov    0x10(%rbx,%rsi,8),%rdx
    4601:	45 8d 44 35 02       	lea    0x2(%r13,%rsi,1),%r8d
    4606:	4a 89 14 c7          	mov    %rdx,(%rdi,%r8,8)
    460a:	48 8b 54 f3 18       	mov    0x18(%rbx,%rsi,8),%rdx
    460f:	46 8d 04 2e          	lea    (%rsi,%r13,1),%r8d
    4613:	41 83 c0 03          	add    $0x3,%r8d
    4617:	4a 89 14 c7          	mov    %rdx,(%rdi,%r8,8)
    461b:	48 83 c6 04          	add    $0x4,%rsi
    461f:	49 39 f6             	cmp    %rsi,%r14
    4622:	75 bc                	jne    45e0 <fwp_apply+0x1f0>
    4624:	45 89 dc             	mov    %r11d,%r12d
    4627:	ff 54 08 08          	call   *0x8(%rax,%rcx,1)
    462b:	b9 01 00 00 00       	mov    $0x1,%ecx
    4630:	48 8b 75 d0          	mov    -0x30(%rbp),%rsi
    4634:	89 f2                	mov    %esi,%edx
    4636:	44 29 e2             	sub    %r12d,%edx
    4639:	0f 85 d1 fd ff ff    	jne    4410 <fwp_apply+0x20>
    463f:	89 f2                	mov    %esi,%edx
    4641:	49 89 c6             	mov    %rax,%r14
    4644:	e9 d4 fd ff ff       	jmp    441d <fwp_apply+0x2d>
    4649:	49 8d 56 ff          	lea    -0x1(%r14),%rdx
    464d:	89 d6                	mov    %edx,%esi
    464f:	44 01 ee             	add    %r13d,%esi
    4652:	0f 82 51 ff ff ff    	jb     45a9 <fwp_apply+0x1b9>
    4658:	48 c1 ea 20          	shr    $0x20,%rdx
    465c:	ba 00 00 00 00       	mov    $0x0,%edx
    4661:	0f 85 44 ff ff ff    	jne    45ab <fwp_apply+0x1bb>
    4667:	4a 8d 14 ef          	lea    (%rdi,%r13,8),%rdx
    466b:	48 29 da             	sub    %rbx,%rdx
    466e:	48 83 fa 20          	cmp    $0x20,%rdx
    4672:	0f 82 31 ff ff ff    	jb     45a9 <fwp_apply+0x1b9>
    4678:	44 89 f2             	mov    %r14d,%edx
    467b:	83 e2 fc             	and    $0xfffffffc,%edx
    467e:	31 f6                	xor    %esi,%esi
    4680:	0f 10 04 f3          	movups (%rbx,%rsi,8),%xmm0
    4684:	0f 10 4c f3 10       	movups 0x10(%rbx,%rsi,8),%xmm1
    4689:	46 8d 04 2e          	lea    (%rsi,%r13,1),%r8d
    468d:	42 0f 11 04 c7       	movups %xmm0,(%rdi,%r8,8)
    4692:	42 0f 11 4c c7 10    	movups %xmm1,0x10(%rdi,%r8,8)
    4698:	48 83 c6 04          	add    $0x4,%rsi
    469c:	48 39 f2             	cmp    %rsi,%rdx
    469f:	75 df                	jne    4680 <fwp_apply+0x290>
    46a1:	4c 39 f2             	cmp    %r14,%rdx
    46a4:	0f 85 01 ff ff ff    	jne    45ab <fwp_apply+0x1bb>
    46aa:	e9 75 ff ff ff       	jmp    4624 <fwp_apply+0x234>
    46af:	44 89 f0             	mov    %r14d,%eax
    46b2:	41 81 fe ff 07 00 00 	cmp    $0x7ff,%r14d
    46b9:	77 72                	ja     472d <fwp_apply+0x33d>
    46bb:	48 8d 14 c5 00 00 00 	lea    0x0(,%rax,8),%rdx
    46c2:	00 
    46c3:	48 83 c2 17          	add    $0x17,%rdx
    46c7:	48 c1 ea 04          	shr    $0x4,%rdx
    46cb:	48 8d 0d d6 aa 00 00 	lea    0xaad6(%rip),%rcx        # f1a8 <fwp_gc>
    46d2:	0f b6 bc 0a e8 0b 00 	movzbl 0xbe8(%rdx,%rcx,1),%edi
    46d9:	00 
    46da:	8b 94 b9 48 0b 00 00 	mov    0xb48(%rcx,%rdi,4),%edx
    46e1:	48 29 15 c0 aa 00 00 	sub    %rdx,0xaac0(%rip)        # f1a8 <fwp_gc>
    46e8:	78 43                	js     472d <fwp_apply+0x33d>
    46ea:	4c 8d 04 7f          	lea    (%rdi,%rdi,2),%r8
    46ee:	4a 8d 3c c1          	lea    (%rcx,%r8,8),%rdi
    46f2:	48 81 c7 88 07 00 00 	add    $0x788,%rdi
    46f9:	4c 8b 27             	mov    (%rdi),%r12
    46fc:	4d 85 e4             	test   %r12,%r12
    46ff:	74 14                	je     4715 <fwp_apply+0x325>
    4701:	49 8b 04 24          	mov    (%r12),%rax
    4705:	48 f7 d0             	not    %rax
    4708:	48 89 07             	mov    %rax,(%rdi)
    470b:	eb 48                	jmp    4755 <fwp_apply+0x365>
    470d:	4d 89 fe             	mov    %r15,%r14
    4710:	e9 c1 01 00 00       	jmp    48d6 <fwp_apply+0x4e6>
    4715:	4e 8b a4 c1 90 07 00 	mov    0x790(%rcx,%r8,8),%r12
    471c:	00 
    471d:	4a 8b bc c1 98 07 00 	mov    0x798(%rcx,%r8,8),%rdi
    4724:	00 
    4725:	4c 29 e7             	sub    %r12,%rdi
    4728:	48 39 d7             	cmp    %rdx,%rdi
    472b:	73 17                	jae    4744 <fwp_apply+0x354>
    472d:	48 8d 3c c5 08 00 00 	lea    0x8(,%rax,8),%rdi
    4734:	00 
    4735:	be 02 00 00 00       	mov    $0x2,%esi
    473a:	e8 31 0d 00 00       	call   5470 <fwp_gc_alloc_slow>
    473f:	49 89 c4             	mov    %rax,%r12
    4742:	eb 1b                	jmp    475f <fwp_apply+0x36f>
    4744:	4a 8d 04 c1          	lea    (%rcx,%r8,8),%rax
    4748:	48 05 90 07 00 00    	add    $0x790,%rax
    474e:	49 8d 0c 14          	lea    (%r12,%rdx,1),%rcx
    4752:	48 89 08             	mov    %rcx,(%rax)
    4755:	4c 89 e7             	mov    %r12,%rdi
    4758:	31 f6                	xor    %esi,%esi
    475a:	e8 01 da ff ff       	call   2160 <memset@plt>
    475f:	41 8b 07             	mov    (%r15),%eax
    4762:	41 89 04 24          	mov    %eax,(%r12)
    4766:	45 89 74 24 04       	mov    %r14d,0x4(%r12)
    476b:	4d 85 ed             	test   %r13,%r13
    476e:	4d 89 e6             	mov    %r12,%r14
    4771:	48 8b 7d d0          	mov    -0x30(%rbp),%rdi
    4775:	0f 84 c6 00 00 00    	je     4841 <fwp_apply+0x451>
    477b:	31 c0                	xor    %eax,%eax
    477d:	41 83 fd 06          	cmp    $0x6,%r13d
    4781:	72 53                	jb     47d6 <fwp_apply+0x3e6>
    4783:	4c 89 f1             	mov    %r14,%rcx
    4786:	4c 29 f9             	sub    %r15,%rcx
    4789:	48 83 f9 20          	cmp    $0x20,%rcx
    478d:	72 47                	jb     47d6 <fwp_apply+0x3e6>
    478f:	44 89 e8             	mov    %r13d,%eax
    4792:	83 e0 fc             	and    $0xfffffffc,%eax
    4795:	4a 8d 0c ed 00 00 00 	lea    0x0(,%r13,8),%rcx
    479c:	00 
    479d:	48 83 e1 e0          	and    $0xffffffffffffffe0,%rcx
    47a1:	31 d2                	xor    %edx,%edx
    47a3:	66 66 66 66 2e 0f 1f 	data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    47aa:	84 00 00 00 00 00 
    47b0:	41 0f 10 44 17 08    	movups 0x8(%r15,%rdx,1),%xmm0
    47b6:	41 0f 10 4c 17 18    	movups 0x18(%r15,%rdx,1),%xmm1
    47bc:	41 0f 11 44 16 08    	movups %xmm0,0x8(%r14,%rdx,1)
    47c2:	41 0f 11 4c 16 18    	movups %xmm1,0x18(%r14,%rdx,1)
    47c8:	48 83 c2 20          	add    $0x20,%rdx
    47cc:	48 39 d1             	cmp    %rdx,%rcx
    47cf:	75 df                	jne    47b0 <fwp_apply+0x3c0>
    47d1:	4c 39 e8             	cmp    %r13,%rax
    47d4:	74 6b                	je     4841 <fwp_apply+0x451>
    47d6:	4c 89 ea             	mov    %r13,%rdx
    47d9:	48 89 c1             	mov    %rax,%rcx
    47dc:	48 83 e2 03          	and    $0x3,%rdx
    47e0:	74 20                	je     4802 <fwp_apply+0x412>
    47e2:	48 89 c1             	mov    %rax,%rcx
    47e5:	66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
    47ec:	00 00 00 00 
    47f0:	49 8b 74 cf 08       	mov    0x8(%r15,%rcx,8),%rsi
    47f5:	49 89 74 ce 08       	mov    %rsi,0x8(%r14,%rcx,8)
    47fa:	48 ff c1             	inc    %rcx
    47fd:	48 ff ca             	dec    %rdx
    4800:	75 ee                	jne    47f0 <fwp_apply+0x400>
    4802:	4c 29 e8             	sub    %r13,%rax
    4805:	48 83 f8 fc          	cmp    $0xfffffffffffffffc,%rax
    4809:	77 36                	ja     4841 <fwp_apply+0x451>
    480b:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)
    4810:	49 8b 44 cf 08       	mov    0x8(%r15,%rcx,8),%rax
    4815:	49 89 44 ce 08       	mov    %rax,0x8(%r14,%rcx,8)
    481a:	49 8b 44 cf 10       	mov    0x10(%r15,%rcx,8),%rax
    481f:	49 89 44 ce 10       	mov    %rax,0x10(%r14,%rcx,8)
    4824:	49 8b 44 cf 18       	mov    0x18(%r15,%rcx,8),%rax
    4829:	49 89 44 ce 18       	mov    %rax,0x18(%r14,%rcx,8)
    482e:	49 8b 44 cf 20       	mov    0x20(%r15,%rcx,8),%rax
    4833:	49 89 44 ce 20       	mov    %rax,0x20(%r14,%rcx,8)
    4838:	48 83 c1 04          	add    $0x4,%rcx
    483c:	49 39 cd             	cmp    %rcx,%r13
    483f:	75 cf                	jne    4810 <fwp_apply+0x420>
    4841:	85 ff                	test   %edi,%edi
    4843:	0f 84 8d 00 00 00    	je     48d6 <fwp_apply+0x4e6>
    4849:	89 f8                	mov    %edi,%eax
    484b:	83 ff 14             	cmp    $0x14,%edi
    484e:	0f 83 94 00 00 00    	jae    48e8 <fwp_apply+0x4f8>
    4854:	31 c9                	xor    %ecx,%ecx
    4856:	48 89 c6             	mov    %rax,%rsi
    4859:	48 89 ca             	mov    %rcx,%rdx
    485c:	48 83 e6 03          	and    $0x3,%rsi
    4860:	74 23                	je     4885 <fwp_apply+0x495>
    4862:	48 89 ca             	mov    %rcx,%rdx
    4865:	66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
    486c:	00 00 00 00 
    4870:	48 8b 3c d3          	mov    (%rbx,%rdx,8),%rdi
    4874:	46 8d 04 2a          	lea    (%rdx,%r13,1),%r8d
    4878:	4b 89 7c c6 08       	mov    %rdi,0x8(%r14,%r8,8)
    487d:	48 ff c2             	inc    %rdx
    4880:	48 ff ce             	dec    %rsi
    4883:	75 eb                	jne    4870 <fwp_apply+0x480>
    4885:	48 29 c1             	sub    %rax,%rcx
    4888:	48 83 f9 fc          	cmp    $0xfffffffffffffffc,%rcx
    488c:	77 48                	ja     48d6 <fwp_apply+0x4e6>
    488e:	66 90                	xchg   %ax,%ax
    4890:	48 8b 0c d3          	mov    (%rbx,%rdx,8),%rcx
    4894:	42 8d 34 2a          	lea    (%rdx,%r13,1),%esi
    4898:	49 89 4c f6 08       	mov    %rcx,0x8(%r14,%rsi,8)
    489d:	48 8b 4c d3 08       	mov    0x8(%rbx,%rdx,8),%rcx
    48a2:	42 8d 34 2a          	lea    (%rdx,%r13,1),%esi
    48a6:	ff c6                	inc    %esi
    48a8:	49 89 4c f6 08       	mov    %rcx,0x8(%r14,%rsi,8)
    48ad:	48 8b 4c d3 10       	mov    0x10(%rbx,%rdx,8),%rcx
    48b2:	41 8d 74 15 02       	lea    0x2(%r13,%rdx,1),%esi
    48b7:	49 89 4c f6 08       	mov    %rcx,0x8(%r14,%rsi,8)
    48bc:	48 8b 4c d3 18       	mov    0x18(%rbx,%rdx,8),%rcx
    48c1:	42 8d 34 2a          	lea    (%rdx,%r13,1),%esi
    48c5:	83 c6 03             	add    $0x3,%esi
    48c8:	49 89 4c f6 08       	mov    %rcx,0x8(%r14,%rsi,8)
    48cd:	48 83 c2 04          	add    $0x4,%rdx
    48d1:	48 39 d0             	cmp    %rdx,%rax
    48d4:	75 ba                	jne    4890 <fwp_apply+0x4a0>
    48d6:	4c 89 f0             	mov    %r14,%rax
    48d9:	48 8d 65 d8          	lea    -0x28(%rbp),%rsp
    48dd:	5b                   	pop    %rbx
    48de:	41 5c                	pop    %r12
    48e0:	41 5d                	pop    %r13
    48e2:	41 5e                	pop    %r14
    48e4:	41 5f                	pop    %r15
    48e6:	5d                   	pop    %rbp
    48e7:	c3                   	ret
    48e8:	48 8d 50 ff          	lea    -0x1(%rax),%rdx
    48ec:	31 c9                	xor    %ecx,%ecx
    48ee:	89 d6                	mov    %edx,%esi
    48f0:	44 01 ee             	add    %r13d,%esi
    48f3:	0f 82 5d ff ff ff    	jb     4856 <fwp_apply+0x466>
    48f9:	48 c1 ea 20          	shr    $0x20,%rdx
    48fd:	0f 85 53 ff ff ff    	jne    4856 <fwp_apply+0x466>
    4903:	4b 8d 0c ee          	lea    (%r14,%r13,8),%rcx
    4907:	48 29 d9             	sub    %rbx,%rcx
    490a:	48 83 c1 08          	add    $0x8,%rcx
    490e:	48 83 f9 20          	cmp    $0x20,%rcx
    4912:	0f 82 3c ff ff ff    	jb     4854 <fwp_apply+0x464>
    4918:	89 c1                	mov    %eax,%ecx
    491a:	83 e1 fc             	and    $0xfffffffc,%ecx
    491d:	31 d2                	xor    %edx,%edx
    491f:	90                   	nop
    4920:	0f 10 04 d3          	movups (%rbx,%rdx,8),%xmm0
    4924:	0f 10 4c d3 10       	movups 0x10(%rbx,%rdx,8),%xmm1
    4929:	42 8d 34 2a          	lea    (%rdx,%r13,1),%esi
    492d:	41 0f 11 44 f6 08    	movups %xmm0,0x8(%r14,%rsi,8)
    4933:	41 0f 11 4c f6 18    	movups %xmm1,0x18(%r14,%rsi,8)
    4939:	48 83 c2 04          	add    $0x4,%rdx
    493d:	48 39 d1             	cmp    %rdx,%rcx
    4940:	75 de                	jne    4920 <fwp_apply+0x530>
    4942:	48 39 c1             	cmp    %rax,%rcx
    4945:	0f 85 0b ff ff ff    	jne    4856 <fwp_apply+0x466>
    494b:	eb 89                	jmp    48d6 <fwp_apply+0x4e6>
    494d:	0f 1f 00             	nopl   (%rax)

0000000000004950 <fwp_apply_release>:
    4950:	41 56                	push   %r14
    4952:	53                   	push   %rbx
    4953:	50                   	push   %rax
    4954:	48 8b 1f             	mov    (%rdi),%rbx
    4957:	48 c7 07 00 00 00 00 	movq   $0x0,(%rdi)
    495e:	8b 47 20             	mov    0x20(%rdi),%eax
    4961:	8b 4f 18             	mov    0x18(%rdi),%ecx
    4964:	89 c2                	mov    %eax,%edx
    4966:	29 ca                	sub    %ecx,%edx
    4968:	74 2d                	je     4997 <fwp_apply_release+0x47>
    496a:	48 8b 77 10          	mov    0x10(%rdi),%rsi
    496e:	4c 8b 46 18          	mov    0x18(%rsi),%r8
    4972:	4d 85 c0             	test   %r8,%r8
    4975:	74 20                	je     4997 <fwp_apply_release+0x47>
    4977:	48 89 c8             	mov    %rcx,%rax
    497a:	48 c1 e0 03          	shl    $0x3,%rax
    497e:	48 03 47 08          	add    0x8(%rdi),%rax
    4982:	8b 77 1c             	mov    0x1c(%rdi),%esi
    4985:	01 ce                	add    %ecx,%esi
    4987:	49 89 fe             	mov    %rdi,%r14
    498a:	48 89 c7             	mov    %rax,%rdi
    498d:	41 ff d0             	call   *%r8
    4990:	4c 89 f7             	mov    %r14,%rdi
    4993:	41 8b 46 20          	mov    0x20(%r14),%eax
    4997:	89 47 18             	mov    %eax,0x18(%rdi)
    499a:	48 85 db             	test   %rbx,%rbx
    499d:	74 0f                	je     49ae <fwp_apply_release+0x5e>
    499f:	48 89 df             	mov    %rbx,%rdi
    49a2:	48 83 c4 08          	add    $0x8,%rsp
    49a6:	5b                   	pop    %rbx
    49a7:	41 5e                	pop    %r14
    49a9:	e9 42 16 00 00       	jmp    5ff0 <fwp_closure_drop>
    49ae:	48 83 c4 08          	add    $0x8,%rsp
    49b2:	5b                   	pop    %rbx
    49b3:	41 5e                	pop    %r14
    49b5:	c3                   	ret
    49b6:	66 2e 0f 1f 84 00 00 	cs nopw 0x0(%rax,%rax,1)
    49bd:	00 00 00 

00000000000049c0 <fwp_apply_owned>:
    49c0:	55                   	push   %rbp
    49c1:	48 89 e5             	mov    %rsp,%rbp
    49c4:	41 57                	push   %r15
    49c6:	41 56                	push   %r14
    49c8:	41 55                	push   %r13
    49ca:	41 54                	push   %r12
    49cc:	53                   	push   %rbx
    49cd:	48 81 ec 88 00 00 00 	sub    $0x88,%rsp
    49d4:	48 89 d3             	mov    %rdx,%rbx
    49d7:	41 89 f5             	mov    %esi,%r13d
    49da:	48 8b 05 5f c2 00 00 	mov    0xc25f(%rip),%rax        # 10c40 <fwp_fns>
    49e1:	8b 17                	mov    (%rdi),%edx
    49e3:	48 89 d6             	mov    %rdx,%rsi
    49e6:	48 c1 e6 05          	shl    $0x5,%rsi
    49ea:	48 8b 4c 30 18       	mov    0x18(%rax,%rsi,1),%rcx
    49ef:	48 85 c9             	test   %rcx,%rcx
    49f2:	0f 84 fc 03 00 00    	je     4df4 <fwp_apply_owned+0x434>
    49f8:	4c 8d 14 30          	lea    (%rax,%rsi,1),%r10
    49fc:	49 83 c2 18          	add    $0x18,%r10
    4a00:	49 89 fc             	mov    %rdi,%r12
    4a03:	66 66 66 66 2e 0f 1f 	data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    4a0a:	84 00 00 00 00 00 
    4a10:	48 c1 e2 05          	shl    $0x5,%rdx
    4a14:	8b 04 10             	mov    (%rax,%rdx,1),%eax
    4a17:	45 8b 7c 24 04       	mov    0x4(%r12),%r15d
    4a1c:	48 89 bd 68 ff ff ff 	mov    %rdi,-0x98(%rbp)
    4a23:	48 89 9d 70 ff ff ff 	mov    %rbx,-0x90(%rbp)
    4a2a:	48 89 8d 78 ff ff ff 	mov    %rcx,-0x88(%rbp)
    4a31:	c7 45 80 00 00 00 00 	movl   $0x0,-0x80(%rbp)
    4a38:	44 89 7d 84          	mov    %r15d,-0x7c(%rbp)
    4a3c:	48 89 fa             	mov    %rdi,%rdx
    4a3f:	48 2b 15 92 b7 00 00 	sub    0xb792(%rip),%rdx        # 101d8 <fwp_gc+0x1030>
    4a46:	44 89 6d 88          	mov    %r13d,-0x78(%rbp)
    4a4a:	48 8b 35 af b7 00 00 	mov    0xb7af(%rip),%rsi        # 10200 <fwp_gc+0x1058>
    4a51:	48 c1 e6 10          	shl    $0x10,%rsi
    4a55:	48 39 f2             	cmp    %rsi,%rdx
    4a58:	73 76                	jae    4ad0 <fwp_apply_owned+0x110>
    4a5a:	48 8b 35 bf b7 00 00 	mov    0xb7bf(%rip),%rsi        # 10220 <fwp_gc+0x1078>
    4a61:	49 89 d0             	mov    %rdx,%r8
    4a64:	49 c1 e8 10          	shr    $0x10,%r8
    4a68:	4d 69 c8 28 12 00 00 	imul   $0x1228,%r8,%r9
    4a6f:	46 0f b6 04 0e       	movzbl (%rsi,%r9,1),%r8d
    4a74:	48 81 e2 ff ff 00 00 	and    $0xffff,%rdx
    4a7b:	75 23                	jne    4aa0 <fwp_apply_owned+0xe0>
    4a7d:	41 80 f8 02          	cmp    $0x2,%r8b
    4a81:	75 1d                	jne    4aa0 <fwp_apply_owned+0xe0>
    4a83:	4a 8d 14 0e          	lea    (%rsi,%r9,1),%rdx
    4a87:	48 81 c2 28 02 00 00 	add    $0x228,%rdx
    4a8e:	80 3a 00             	cmpb   $0x0,(%rdx)
    4a91:	75 52                	jne    4ae5 <fwp_apply_owned+0x125>
    4a93:	eb 3b                	jmp    4ad0 <fwp_apply_owned+0x110>
    4a95:	66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
    4a9c:	00 00 00 00 
    4aa0:	41 80 f8 01          	cmp    $0x1,%r8b
    4aa4:	75 2a                	jne    4ad0 <fwp_apply_owned+0x110>
    4aa6:	4e 8d 04 0e          	lea    (%rsi,%r9,1),%r8
    4aaa:	42 8b 74 0e 20       	mov    0x20(%rsi,%r9,1),%esi
    4aaf:	48 0f af d6          	imul   %rsi,%rdx
    4ab3:	48 c1 ea 20          	shr    $0x20,%rdx
    4ab7:	4c 01 c2             	add    %r8,%rdx
    4aba:	48 81 c2 28 02 00 00 	add    $0x228,%rdx
    4ac1:	80 3a 00             	cmpb   $0x0,(%rdx)
    4ac4:	75 1f                	jne    4ae5 <fwp_apply_owned+0x125>
    4ac6:	66 2e 0f 1f 84 00 00 	cs nopw 0x0(%rax,%rax,1)
    4acd:	00 00 00 
    4ad0:	48 83 79 18 00       	cmpq   $0x0,0x18(%rcx)
    4ad5:	74 49                	je     4b20 <fwp_apply_owned+0x160>
    4ad7:	4d 85 ff             	test   %r15,%r15
    4ada:	75 09                	jne    4ae5 <fwp_apply_owned+0x125>
    4adc:	31 d2                	xor    %edx,%edx
    4ade:	41 39 c5             	cmp    %eax,%r13d
    4ae1:	72 02                	jb     4ae5 <fwp_apply_owned+0x125>
    4ae3:	76 3d                	jbe    4b22 <fwp_apply_owned+0x162>
    4ae5:	48 8b 15 7c c1 00 00 	mov    0xc17c(%rip),%rdx        # 10c68 <fwp_cleanups>
    4aec:	48 89 55 98          	mov    %rdx,-0x68(%rbp)
    4af0:	48 8d 15 59 fe ff ff 	lea    -0x1a7(%rip),%rdx        # 4950 <fwp_apply_release>
    4af7:	48 89 55 a0          	mov    %rdx,-0x60(%rbp)
    4afb:	48 8d 95 68 ff ff ff 	lea    -0x98(%rbp),%rdx
    4b02:	48 89 55 a8          	mov    %rdx,-0x58(%rbp)
    4b06:	48 8d 55 98          	lea    -0x68(%rbp),%rdx
    4b0a:	48 89 15 57 c1 00 00 	mov    %rdx,0xc157(%rip)        # 10c68 <fwp_cleanups>
    4b11:	b2 01                	mov    $0x1,%dl
    4b13:	eb 0d                	jmp    4b22 <fwp_apply_owned+0x162>
    4b15:	66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
    4b1c:	00 00 00 00 
    4b20:	31 d2                	xor    %edx,%edx
    4b22:	47 8d 34 2f          	lea    (%r15,%r13,1),%r14d
    4b26:	41 39 c6             	cmp    %eax,%r14d
    4b29:	48 89 7d c8          	mov    %rdi,-0x38(%rbp)
    4b2d:	89 55 bc             	mov    %edx,-0x44(%rbp)
    4b30:	0f 82 2c 03 00 00    	jb     4e62 <fwp_apply_owned+0x4a2>
    4b36:	41 89 c3             	mov    %eax,%r11d
    4b39:	45 29 fb             	sub    %r15d,%r11d
    4b3c:	45 89 d9             	mov    %r11d,%r9d
    4b3f:	4d 85 ff             	test   %r15,%r15
    4b42:	4c 89 4d d0          	mov    %r9,-0x30(%rbp)
    4b46:	75 18                	jne    4b60 <fwp_apply_owned+0x1a0>
    4b48:	85 c0                	test   %eax,%eax
    4b4a:	74 14                	je     4b60 <fwp_apply_owned+0x1a0>
    4b4c:	45 89 de             	mov    %r11d,%r14d
    4b4f:	44 89 5d 80          	mov    %r11d,-0x80(%rbp)
    4b53:	48 89 df             	mov    %rbx,%rdi
    4b56:	ff 11                	call   *(%rcx)
    4b58:	49 89 c4             	mov    %rax,%r12
    4b5b:	e9 2b 02 00 00       	jmp    4d8b <fwp_apply_owned+0x3cb>
    4b60:	4c 89 6d c0          	mov    %r13,-0x40(%rbp)
    4b64:	48 89 65 90          	mov    %rsp,-0x70(%rbp)
    4b68:	85 c0                	test   %eax,%eax
    4b6a:	b9 01 00 00 00       	mov    $0x1,%ecx
    4b6f:	0f 45 c8             	cmovne %eax,%ecx
    4b72:	48 8d 0c cd 0f 00 00 	lea    0xf(,%rcx,8),%rcx
    4b79:	00 
    4b7a:	48 83 e1 f0          	and    $0xfffffffffffffff0,%rcx
    4b7e:	49 89 e5             	mov    %rsp,%r13
    4b81:	49 29 cd             	sub    %rcx,%r13
    4b84:	4c 89 ec             	mov    %r13,%rsp
    4b87:	4d 85 ff             	test   %r15,%r15
    4b8a:	0f 84 d0 00 00 00    	je     4c60 <fwp_apply_owned+0x2a0>
    4b90:	41 83 ff 04          	cmp    $0x4,%r15d
    4b94:	72 10                	jb     4ba6 <fwp_apply_owned+0x1e6>
    4b96:	4c 89 e9             	mov    %r13,%rcx
    4b99:	4c 29 e1             	sub    %r12,%rcx
    4b9c:	48 83 c1 f8          	add    $0xfffffffffffffff8,%rcx
    4ba0:	48 83 f9 20          	cmp    $0x20,%rcx
    4ba4:	73 6d                	jae    4c13 <fwp_apply_owned+0x253>
    4ba6:	31 c9                	xor    %ecx,%ecx
    4ba8:	4c 89 fe             	mov    %r15,%rsi
    4bab:	48 89 ca             	mov    %rcx,%rdx
    4bae:	48 83 e6 03          	and    $0x3,%rsi
    4bb2:	74 1e                	je     4bd2 <fwp_apply_owned+0x212>
    4bb4:	48 89 ca             	mov    %rcx,%rdx
    4bb7:	66 0f 1f 84 00 00 00 	nopw   0x0(%rax,%rax,1)
    4bbe:	00 00 
    4bc0:	4d 8b 44 d4 08       	mov    0x8(%r12,%rdx,8),%r8
    4bc5:	4d 89 44 d5 00       	mov    %r8,0x0(%r13,%rdx,8)
    4bca:	48 ff c2             	inc    %rdx
    4bcd:	48 ff ce             	dec    %rsi
    4bd0:	75 ee                	jne    4bc0 <fwp_apply_owned+0x200>
    4bd2:	4c 29 f9             	sub    %r15,%rcx
    4bd5:	48 83 f9 fc          	cmp    $0xfffffffffffffffc,%rcx
    4bd9:	0f 87 81 00 00 00    	ja     4c60 <fwp_apply_owned+0x2a0>
    4bdf:	90                   	nop
    4be0:	49 8b 4c d4 08       	mov    0x8(%r12,%rdx,8),%rcx
    4be5:	49 89 4c d5 00       	mov    %rcx,0x0(%r13,%rdx,8)
    4bea:	49 8b 4c d4 10       	mov    0x10(%r12,%rdx,8),%rcx
    4bef:	49 89 4c d5 08       	mov    %rcx,0x8(%r13,%rdx,8)
    4bf4:	49 8b 4c d4 18       	mov    0x18(%r12,%rdx,8),%rcx
    4bf9:	49 89 4c d5 10       	mov    %rcx,0x10(%r13,%rdx,8)
    4bfe:	49 8b 4c d4 20       	mov    0x20(%r12,%rdx,8),%rcx
    4c03:	49 89 4c d5 18       	mov    %rcx,0x18(%r13,%rdx,8)
    4c08:	48 83 c2 04          	add    $0x4,%rdx
    4c0c:	49 39 d7             	cmp    %rdx,%r15
    4c0f:	75 cf                	jne    4be0 <fwp_apply_owned+0x220>
    4c11:	eb 4d                	jmp    4c60 <fwp_apply_owned+0x2a0>
    4c13:	44 89 f9             	mov    %r15d,%ecx
    4c16:	83 e1 fc             	and    $0xfffffffc,%ecx
    4c19:	4a 8d 14 fd 00 00 00 	lea    0x0(,%r15,8),%rdx
    4c20:	00 
    4c21:	48 83 e2 e0          	and    $0xffffffffffffffe0,%rdx
    4c25:	31 f6                	xor    %esi,%esi
    4c27:	66 0f 1f 84 00 00 00 	nopw   0x0(%rax,%rax,1)
    4c2e:	00 00 
    4c30:	41 0f 10 44 34 08    	movups 0x8(%r12,%rsi,1),%xmm0
    4c36:	41 0f 10 4c 34 18    	movups 0x18(%r12,%rsi,1),%xmm1
    4c3c:	41 0f 29 44 35 00    	movaps %xmm0,0x0(%r13,%rsi,1)
    4c42:	41 0f 29 4c 35 10    	movaps %xmm1,0x10(%r13,%rsi,1)
    4c48:	48 83 c6 20          	add    $0x20,%rsi
    4c4c:	48 39 f2             	cmp    %rsi,%rdx
    4c4f:	75 df                	jne    4c30 <fwp_apply_owned+0x270>
    4c51:	4c 39 f9             	cmp    %r15,%rcx
    4c54:	0f 85 4e ff ff ff    	jne    4ba8 <fwp_apply_owned+0x1e8>
    4c5a:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)
    4c60:	44 39 f8             	cmp    %r15d,%eax
    4c63:	0f 84 f7 00 00 00    	je     4d60 <fwp_apply_owned+0x3a0>
    4c69:	41 83 fb 0a          	cmp    $0xa,%r11d
    4c6d:	0f 83 95 00 00 00    	jae    4d08 <fwp_apply_owned+0x348>
    4c73:	31 c0                	xor    %eax,%eax
    4c75:	4c 89 ca             	mov    %r9,%rdx
    4c78:	48 89 c1             	mov    %rax,%rcx
    4c7b:	48 83 e2 03          	and    $0x3,%rdx
    4c7f:	74 24                	je     4ca5 <fwp_apply_owned+0x2e5>
    4c81:	48 89 c1             	mov    %rax,%rcx
    4c84:	66 66 66 2e 0f 1f 84 	data16 data16 cs nopw 0x0(%rax,%rax,1)
    4c8b:	00 00 00 00 00 
    4c90:	48 8b 34 cb          	mov    (%rbx,%rcx,8),%rsi
    4c94:	45 8d 04 0f          	lea    (%r15,%rcx,1),%r8d
    4c98:	4b 89 74 c5 00       	mov    %rsi,0x0(%r13,%r8,8)
    4c9d:	48 ff c1             	inc    %rcx
    4ca0:	48 ff ca             	dec    %rdx
    4ca3:	75 eb                	jne    4c90 <fwp_apply_owned+0x2d0>
    4ca5:	4c 29 c8             	sub    %r9,%rax
    4ca8:	48 83 f8 fc          	cmp    $0xfffffffffffffffc,%rax
    4cac:	0f 87 ae 00 00 00    	ja     4d60 <fwp_apply_owned+0x3a0>
    4cb2:	66 66 66 66 66 2e 0f 	data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    4cb9:	1f 84 00 00 00 00 00 
    4cc0:	48 8b 04 cb          	mov    (%rbx,%rcx,8),%rax
    4cc4:	41 8d 14 0f          	lea    (%r15,%rcx,1),%edx
    4cc8:	49 89 44 d5 00       	mov    %rax,0x0(%r13,%rdx,8)
    4ccd:	48 8b 44 cb 08       	mov    0x8(%rbx,%rcx,8),%rax
    4cd2:	41 8d 14 0f          	lea    (%r15,%rcx,1),%edx
    4cd6:	ff c2                	inc    %edx
    4cd8:	49 89 44 d5 00       	mov    %rax,0x0(%r13,%rdx,8)
    4cdd:	48 8b 44 cb 10       	mov    0x10(%rbx,%rcx,8),%rax
    4ce2:	41 8d 54 0f 02       	lea    0x2(%r15,%rcx,1),%edx
    4ce7:	49 89 44 d5 00       	mov    %rax,0x0(%r13,%rdx,8)
    4cec:	48 8b 44 cb 18       	mov    0x18(%rbx,%rcx,8),%rax
    4cf1:	41 8d 14 0f          	lea    (%r15,%rcx,1),%edx
    4cf5:	83 c2 03             	add    $0x3,%edx
    4cf8:	49 89 44 d5 00       	mov    %rax,0x0(%r13,%rdx,8)
    4cfd:	48 83 c1 04          	add    $0x4,%rcx
    4d01:	49 39 c9             	cmp    %rcx,%r9
    4d04:	75 ba                	jne    4cc0 <fwp_apply_owned+0x300>
    4d06:	eb 58                	jmp    4d60 <fwp_apply_owned+0x3a0>
    4d08:	49 8d 41 ff          	lea    -0x1(%r9),%rax
    4d0c:	89 c1                	mov    %eax,%ecx
    4d0e:	44 01 f9             	add    %r15d,%ecx
    4d11:	0f 82 5c ff ff ff    	jb     4c73 <fwp_apply_owned+0x2b3>
    4d17:	48 c1 e8 20          	shr    $0x20,%rax
    4d1b:	b8 00 00 00 00       	mov    $0x0,%eax
    4d20:	0f 85 4f ff ff ff    	jne    4c75 <fwp_apply_owned+0x2b5>
    4d26:	44 89 c8             	mov    %r9d,%eax
    4d29:	83 e0 fc             	and    $0xfffffffc,%eax
    4d2c:	31 c9                	xor    %ecx,%ecx
    4d2e:	66 90                	xchg   %ax,%ax
    4d30:	0f 10 04 cb          	movups (%rbx,%rcx,8),%xmm0
    4d34:	0f 10 4c cb 10       	movups 0x10(%rbx,%rcx,8),%xmm1
    4d39:	41 8d 14 0f          	lea    (%r15,%rcx,1),%edx
    4d3d:	41 0f 11 44 d5 00    	movups %xmm0,0x0(%r13,%rdx,8)
    4d43:	41 0f 11 4c d5 10    	movups %xmm1,0x10(%r13,%rdx,8)
    4d49:	48 83 c1 04          	add    $0x4,%rcx
    4d4d:	48 39 c8             	cmp    %rcx,%rax
    4d50:	75 de                	jne    4d30 <fwp_apply_owned+0x370>
    4d52:	4c 39 c8             	cmp    %r9,%rax
    4d55:	0f 85 1a ff ff ff    	jne    4c75 <fwp_apply_owned+0x2b5>
    4d5b:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)
    4d60:	49 8b 02             	mov    (%r10),%rax
    4d63:	be 01 00 00 00       	mov    $0x1,%esi
    4d68:	4d 89 d7             	mov    %r10,%r15
    4d6b:	45 89 dc             	mov    %r11d,%r12d
    4d6e:	ff 50 08             	call   *0x8(%rax)
    4d71:	45 89 e6             	mov    %r12d,%r14d
    4d74:	44 89 65 80          	mov    %r12d,-0x80(%rbp)
    4d78:	49 8b 07             	mov    (%r15),%rax
    4d7b:	4c 89 ef             	mov    %r13,%rdi
    4d7e:	ff 10                	call   *(%rax)
    4d80:	49 89 c4             	mov    %rax,%r12
    4d83:	48 8b 65 90          	mov    -0x70(%rbp),%rsp
    4d87:	4c 8b 6d c0          	mov    -0x40(%rbp),%r13
    4d8b:	80 7d bc 00          	cmpb   $0x0,-0x44(%rbp)
    4d8f:	48 8b 7d c8          	mov    -0x38(%rbp),%rdi
    4d93:	74 1c                	je     4db1 <fwp_apply_owned+0x3f1>
    4d95:	48 8d 45 98          	lea    -0x68(%rbp),%rax
    4d99:	48 39 05 c8 be 00 00 	cmp    %rax,0xbec8(%rip)        # 10c68 <fwp_cleanups>
    4da0:	0f 85 c1 06 00 00    	jne    5467 <fwp_apply_owned+0xaa7>
    4da6:	48 8b 45 98          	mov    -0x68(%rbp),%rax
    4daa:	48 89 05 b7 be 00 00 	mov    %rax,0xbeb7(%rip)        # 10c68 <fwp_cleanups>
    4db1:	e8 3a 12 00 00       	call   5ff0 <fwp_closure_drop>
    4db6:	45 29 f5             	sub    %r14d,%r13d
    4db9:	0f 84 96 06 00 00    	je     5455 <fwp_apply_owned+0xa95>
    4dbf:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
    4dc3:	48 8d 1c c3          	lea    (%rbx,%rax,8),%rbx
    4dc7:	48 8b 05 72 be 00 00 	mov    0xbe72(%rip),%rax        # 10c40 <fwp_fns>
    4dce:	41 8b 14 24          	mov    (%r12),%edx
    4dd2:	48 89 d1             	mov    %rdx,%rcx
    4dd5:	48 c1 e1 05          	shl    $0x5,%rcx
    4dd9:	4c 8d 14 08          	lea    (%rax,%rcx,1),%r10
    4ddd:	49 83 c2 18          	add    $0x18,%r10
    4de1:	48 8b 4c 08 18       	mov    0x18(%rax,%rcx,1),%rcx
    4de6:	4c 89 e7             	mov    %r12,%rdi
    4de9:	48 85 c9             	test   %rcx,%rcx
    4dec:	0f 85 1e fc ff ff    	jne    4a10 <fwp_apply_owned+0x50>
    4df2:	eb 03                	jmp    4df7 <fwp_apply_owned+0x437>
    4df4:	49 89 fc             	mov    %rdi,%r12
    4df7:	48 8b 05 da b3 00 00 	mov    0xb3da(%rip),%rax        # 101d8 <fwp_gc+0x1030>
    4dfe:	4c 89 e2             	mov    %r12,%rdx
    4e01:	48 29 c2             	sub    %rax,%rdx
    4e04:	48 8b 0d f5 b3 00 00 	mov    0xb3f5(%rip),%rcx        # 10200 <fwp_gc+0x1058>
    4e0b:	48 c1 e1 10          	shl    $0x10,%rcx
    4e0f:	48 39 ca             	cmp    %rcx,%rdx
    4e12:	0f 83 12 01 00 00    	jae    4f2a <fwp_apply_owned+0x56a>
    4e18:	48 8b 35 01 b4 00 00 	mov    0xb401(%rip),%rsi        # 10220 <fwp_gc+0x1078>
    4e1f:	48 89 d7             	mov    %rdx,%rdi
    4e22:	48 c1 ef 10          	shr    $0x10,%rdi
    4e26:	48 69 ff 28 12 00 00 	imul   $0x1228,%rdi,%rdi
    4e2d:	44 0f b6 04 3e       	movzbl (%rsi,%rdi,1),%r8d
    4e32:	48 81 e2 ff ff 00 00 	and    $0xffff,%rdx
    4e39:	0f 85 c2 00 00 00    	jne    4f01 <fwp_apply_owned+0x541>
    4e3f:	41 80 f8 02          	cmp    $0x2,%r8b
    4e43:	0f 85 b8 00 00 00    	jne    4f01 <fwp_apply_owned+0x541>
    4e49:	48 8d 14 3e          	lea    (%rsi,%rdi,1),%rdx
    4e4d:	48 81 c2 28 02 00 00 	add    $0x228,%rdx
    4e54:	80 3a 00             	cmpb   $0x0,(%rdx)
    4e57:	0f 84 cd 00 00 00    	je     4f2a <fwp_apply_owned+0x56a>
    4e5d:	e9 60 01 00 00       	jmp    4fc2 <fwp_apply_owned+0x602>
    4e62:	4c 89 55 d0          	mov    %r10,-0x30(%rbp)
    4e66:	4c 89 6d c0          	mov    %r13,-0x40(%rbp)
    4e6a:	44 89 f1             	mov    %r14d,%ecx
    4e6d:	48 8d 3c cd 08 00 00 	lea    0x8(,%rcx,8),%rdi
    4e74:	00 
    4e75:	41 81 fe ff 07 00 00 	cmp    $0x7ff,%r14d
    4e7c:	0f 87 fb 01 00 00    	ja     507d <fwp_apply_owned+0x6bd>
    4e82:	48 c1 e1 03          	shl    $0x3,%rcx
    4e86:	4c 8d 41 17          	lea    0x17(%rcx),%r8
    4e8a:	49 c1 e8 04          	shr    $0x4,%r8
    4e8e:	48 8d 05 13 a3 00 00 	lea    0xa313(%rip),%rax        # f1a8 <fwp_gc>
    4e95:	41 0f b6 b4 00 e8 0b 	movzbl 0xbe8(%r8,%rax,1),%esi
    4e9c:	00 00 
    4e9e:	8b 94 b0 48 0b 00 00 	mov    0xb48(%rax,%rsi,4),%edx
    4ea5:	4c 8b 0d fc a2 00 00 	mov    0xa2fc(%rip),%r9        # f1a8 <fwp_gc>
    4eac:	4d 89 ca             	mov    %r9,%r10
    4eaf:	49 29 d2             	sub    %rdx,%r10
    4eb2:	4c 89 15 ef a2 00 00 	mov    %r10,0xa2ef(%rip)        # f1a8 <fwp_gc>
    4eb9:	0f 88 be 01 00 00    	js     507d <fwp_apply_owned+0x6bd>
    4ebf:	4c 8d 14 76          	lea    (%rsi,%rsi,2),%r10
    4ec3:	4e 8d 1c d0          	lea    (%rax,%r10,8),%r11
    4ec7:	49 83 c3 08          	add    $0x8,%r11
    4ecb:	4d 8b 2b             	mov    (%r11),%r13
    4ece:	4d 85 ed             	test   %r13,%r13
    4ed1:	0f 84 2f 01 00 00    	je     5006 <fwp_apply_owned+0x646>
    4ed7:	49 8b 45 00          	mov    0x0(%r13),%rax
    4edb:	48 f7 d0             	not    %rax
    4ede:	49 89 03             	mov    %rax,(%r11)
    4ee1:	48 39 d7             	cmp    %rdx,%rdi
    4ee4:	0f 83 b8 01 00 00    	jae    50a2 <fwp_apply_owned+0x6e2>
    4eea:	4c 01 ef             	add    %r13,%rdi
    4eed:	48 29 ca             	sub    %rcx,%rdx
    4ef0:	48 83 c2 f7          	add    $0xfffffffffffffff7,%rdx
    4ef4:	48 83 e2 f8          	and    $0xfffffffffffffff8,%rdx
    4ef8:	48 83 c2 08          	add    $0x8,%rdx
    4efc:	e9 9a 01 00 00       	jmp    509b <fwp_apply_owned+0x6db>
    4f01:	41 80 f8 01          	cmp    $0x1,%r8b
    4f05:	75 23                	jne    4f2a <fwp_apply_owned+0x56a>
    4f07:	4c 8d 04 3e          	lea    (%rsi,%rdi,1),%r8
    4f0b:	8b 74 3e 20          	mov    0x20(%rsi,%rdi,1),%esi
    4f0f:	48 0f af d6          	imul   %rsi,%rdx
    4f13:	48 c1 ea 20          	shr    $0x20,%rdx
    4f17:	4c 01 c2             	add    %r8,%rdx
    4f1a:	48 81 c2 28 02 00 00 	add    $0x228,%rdx
    4f21:	80 3a 00             	cmpb   $0x0,(%rdx)
    4f24:	0f 85 98 00 00 00    	jne    4fc2 <fwp_apply_owned+0x602>
    4f2a:	45 85 ed             	test   %r13d,%r13d
    4f2d:	0f 84 bd 00 00 00    	je     4ff0 <fwp_apply_owned+0x630>
    4f33:	48 8b 15 e6 b2 00 00 	mov    0xb2e6(%rip),%rdx        # 10220 <fwp_gc+0x1078>
    4f3a:	44 89 ee             	mov    %r13d,%esi
    4f3d:	31 ff                	xor    %edi,%edi
    4f3f:	eb 2c                	jmp    4f6d <fwp_apply_owned+0x5ad>
    4f41:	66 66 66 66 66 66 2e 	data16 data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    4f48:	0f 1f 84 00 00 00 00 
    4f4f:	00 
    4f50:	4e 8d 04 0a          	lea    (%rdx,%r9,1),%r8
    4f54:	49 81 c0 28 02 00 00 	add    $0x228,%r8
    4f5b:	41 80 38 00          	cmpb   $0x0,(%r8)
    4f5f:	75 61                	jne    4fc2 <fwp_apply_owned+0x602>
    4f61:	48 ff c7             	inc    %rdi
    4f64:	48 39 fe             	cmp    %rdi,%rsi
    4f67:	0f 84 83 00 00 00    	je     4ff0 <fwp_apply_owned+0x630>
    4f6d:	4c 8b 04 fb          	mov    (%rbx,%rdi,8),%r8
    4f71:	49 29 c0             	sub    %rax,%r8
    4f74:	49 39 c8             	cmp    %rcx,%r8
    4f77:	73 e8                	jae    4f61 <fwp_apply_owned+0x5a1>
    4f79:	4d 89 c1             	mov    %r8,%r9
    4f7c:	49 c1 e9 10          	shr    $0x10,%r9
    4f80:	4d 69 c9 28 12 00 00 	imul   $0x1228,%r9,%r9
    4f87:	46 0f b6 14 0a       	movzbl (%rdx,%r9,1),%r10d
    4f8c:	49 81 e0 ff ff 00 00 	and    $0xffff,%r8
    4f93:	75 06                	jne    4f9b <fwp_apply_owned+0x5db>
    4f95:	41 80 fa 02          	cmp    $0x2,%r10b
    4f99:	74 b5                	je     4f50 <fwp_apply_owned+0x590>
    4f9b:	41 80 fa 01          	cmp    $0x1,%r10b
    4f9f:	75 c0                	jne    4f61 <fwp_apply_owned+0x5a1>
    4fa1:	4e 8d 14 0a          	lea    (%rdx,%r9,1),%r10
    4fa5:	46 8b 4c 0a 20       	mov    0x20(%rdx,%r9,1),%r9d
    4faa:	4d 0f af c1          	imul   %r9,%r8
    4fae:	49 c1 e8 20          	shr    $0x20,%r8
    4fb2:	4d 01 d0             	add    %r10,%r8
    4fb5:	49 81 c0 28 02 00 00 	add    $0x228,%r8
    4fbc:	41 80 38 00          	cmpb   $0x0,(%r8)
    4fc0:	74 9f                	je     4f61 <fwp_apply_owned+0x5a1>
    4fc2:	e8 e9 e7 ff ff       	call   37b0 <fwp_flush>
    4fc7:	48 8b 05 12 a0 00 00 	mov    0xa012(%rip),%rax        # efe0 <stderr@GLIBC_2.2.5>
    4fce:	48 8b 38             	mov    (%rax),%rdi
    4fd1:	48 8d 35 5c 73 00 00 	lea    0x735c(%rip),%rsi        # c334 <fwp_segv.msg+0xf4>
    4fd8:	48 8d 15 28 73 00 00 	lea    0x7328(%rip),%rdx        # c307 <fwp_segv.msg+0xc7>
    4fdf:	31 c0                	xor    %eax,%eax
    4fe1:	e8 fa d1 ff ff       	call   21e0 <fprintf@plt>
    4fe6:	bf 65 00 00 00       	mov    $0x65,%edi
    4feb:	e8 e0 d2 ff ff       	call   22d0 <exit@plt>
    4ff0:	4c 89 e7             	mov    %r12,%rdi
    4ff3:	44 89 ee             	mov    %r13d,%esi
    4ff6:	48 89 da             	mov    %rbx,%rdx
    4ff9:	e8 f2 f3 ff ff       	call   43f0 <fwp_apply>
    4ffe:	49 89 c4             	mov    %rax,%r12
    5001:	e9 4f 04 00 00       	jmp    5455 <fwp_apply_owned+0xa95>
    5006:	4e 8b 6c d0 10       	mov    0x10(%rax,%r10,8),%r13
    500b:	4e 8b 5c d0 18       	mov    0x18(%rax,%r10,8),%r11
    5010:	4d 29 eb             	sub    %r13,%r11
    5013:	49 39 d3             	cmp    %rdx,%r11
    5016:	72 34                	jb     504c <fwp_apply_owned+0x68c>
    5018:	4a 8d 34 d0          	lea    (%rax,%r10,8),%rsi
    501c:	48 83 c6 10          	add    $0x10,%rsi
    5020:	4e 8d 14 2a          	lea    (%rdx,%r13,1),%r10
    5024:	4c 89 16             	mov    %r10,(%rsi)
    5027:	4d 85 ed             	test   %r13,%r13
    502a:	0f 85 b1 fe ff ff    	jne    4ee1 <fwp_apply_owned+0x521>
    5030:	41 0f b6 b4 00 e8 0b 	movzbl 0xbe8(%r8,%rax,1),%esi
    5037:	00 00 
    5039:	8b 94 b0 48 0b 00 00 	mov    0xb48(%rax,%rsi,4),%edx
    5040:	49 29 d1             	sub    %rdx,%r9
    5043:	4c 89 0d 5e a1 00 00 	mov    %r9,0xa15e(%rip)        # f1a8 <fwp_gc>
    504a:	78 31                	js     507d <fwp_apply_owned+0x6bd>
    504c:	48 8d 0c 76          	lea    (%rsi,%rsi,2),%rcx
    5050:	4c 8b 6c c8 08       	mov    0x8(%rax,%rcx,8),%r13
    5055:	4d 85 ed             	test   %r13,%r13
    5058:	74 11                	je     506b <fwp_apply_owned+0x6ab>
    505a:	48 8d 04 c8          	lea    (%rax,%rcx,8),%rax
    505e:	48 83 c0 08          	add    $0x8,%rax
    5062:	49 8b 4d 00          	mov    0x0(%r13),%rcx
    5066:	48 f7 d1             	not    %rcx
    5069:	eb 2a                	jmp    5095 <fwp_apply_owned+0x6d5>
    506b:	4c 8b 6c c8 10       	mov    0x10(%rax,%rcx,8),%r13
    5070:	48 8b 74 c8 18       	mov    0x18(%rax,%rcx,8),%rsi
    5075:	4c 29 ee             	sub    %r13,%rsi
    5078:	48 39 d6             	cmp    %rdx,%rsi
    507b:	73 0c                	jae    5089 <fwp_apply_owned+0x6c9>
    507d:	31 f6                	xor    %esi,%esi
    507f:	e8 ec 03 00 00       	call   5470 <fwp_gc_alloc_slow>
    5084:	49 89 c5             	mov    %rax,%r13
    5087:	eb 19                	jmp    50a2 <fwp_apply_owned+0x6e2>
    5089:	48 8d 04 c8          	lea    (%rax,%rcx,8),%rax
    508d:	48 83 c0 10          	add    $0x10,%rax
    5091:	4a 8d 0c 2a          	lea    (%rdx,%r13,1),%rcx
    5095:	48 89 08             	mov    %rcx,(%rax)
    5098:	4c 89 ef             	mov    %r13,%rdi
    509b:	31 f6                	xor    %esi,%esi
    509d:	e8 be d0 ff ff       	call   2160 <memset@plt>
    50a2:	48 8b 7d c8          	mov    -0x38(%rbp),%rdi
    50a6:	4c 8b 55 d0          	mov    -0x30(%rbp),%r10
    50aa:	41 8b 04 24          	mov    (%r12),%eax
    50ae:	41 89 45 00          	mov    %eax,0x0(%r13)
    50b2:	45 89 75 04          	mov    %r14d,0x4(%r13)
    50b6:	4c 89 e8             	mov    %r13,%rax
    50b9:	48 2b 05 18 b1 00 00 	sub    0xb118(%rip),%rax        # 101d8 <fwp_gc+0x1030>
    50c0:	48 8b 0d 39 b1 00 00 	mov    0xb139(%rip),%rcx        # 10200 <fwp_gc+0x1058>
    50c7:	48 c1 e1 10          	shl    $0x10,%rcx
    50cb:	48 39 c8             	cmp    %rcx,%rax
    50ce:	73 77                	jae    5147 <fwp_apply_owned+0x787>
    50d0:	48 8b 0d 49 b1 00 00 	mov    0xb149(%rip),%rcx        # 10220 <fwp_gc+0x1078>
    50d7:	48 89 c2             	mov    %rax,%rdx
    50da:	48 c1 ea 10          	shr    $0x10,%rdx
    50de:	48 69 d2 28 12 00 00 	imul   $0x1228,%rdx,%rdx
    50e5:	0f b6 34 11          	movzbl (%rcx,%rdx,1),%esi
    50e9:	48 25 ff ff 00 00    	and    $0xffff,%rax
    50ef:	75 1d                	jne    510e <fwp_apply_owned+0x74e>
    50f1:	40 80 fe 02          	cmp    $0x2,%sil
    50f5:	75 17                	jne    510e <fwp_apply_owned+0x74e>
    50f7:	4c 8d 34 11          	lea    (%rcx,%rdx,1),%r14
    50fb:	49 81 c6 28 02 00 00 	add    $0x228,%r14
    5102:	41 80 3e ff          	cmpb   $0xff,(%r14)
    5106:	74 2d                	je     5135 <fwp_apply_owned+0x775>
    5108:	41 c6 06 01          	movb   $0x1,(%r14)
    510c:	eb 39                	jmp    5147 <fwp_apply_owned+0x787>
    510e:	40 80 fe 01          	cmp    $0x1,%sil
    5112:	75 33                	jne    5147 <fwp_apply_owned+0x787>
    5114:	48 8d 34 11          	lea    (%rcx,%rdx,1),%rsi
    5118:	8b 4c 11 20          	mov    0x20(%rcx,%rdx,1),%ecx
    511c:	48 0f af c1          	imul   %rcx,%rax
    5120:	48 c1 e8 20          	shr    $0x20,%rax
    5124:	4c 8d 34 30          	lea    (%rax,%rsi,1),%r14
    5128:	49 81 c6 28 02 00 00 	add    $0x228,%r14
    512f:	41 80 3e ff          	cmpb   $0xff,(%r14)
    5133:	75 d3                	jne    5108 <fwp_apply_owned+0x748>
    5135:	4c 89 f7             	mov    %r14,%rdi
    5138:	e8 a3 e6 ff ff       	call   37e0 <fwp_rc_forget_slot>
    513d:	4c 8b 55 d0          	mov    -0x30(%rbp),%r10
    5141:	48 8b 7d c8          	mov    -0x38(%rbp),%rdi
    5145:	eb c1                	jmp    5108 <fwp_apply_owned+0x748>
    5147:	4c 89 6d b0          	mov    %r13,-0x50(%rbp)
    514b:	48 8b 05 16 bb 00 00 	mov    0xbb16(%rip),%rax        # 10c68 <fwp_cleanups>
    5152:	48 89 85 50 ff ff ff 	mov    %rax,-0xb0(%rbp)
    5159:	48 8d 05 90 13 00 00 	lea    0x1390(%rip),%rax        # 64f0 <fwp_rc_cleanup_cell>
    5160:	48 89 85 58 ff ff ff 	mov    %rax,-0xa8(%rbp)
    5167:	48 8d 45 b0          	lea    -0x50(%rbp),%rax
    516b:	48 89 85 60 ff ff ff 	mov    %rax,-0xa0(%rbp)
    5172:	4c 8d b5 50 ff ff ff 	lea    -0xb0(%rbp),%r14
    5179:	4c 89 35 e8 ba 00 00 	mov    %r14,0xbae8(%rip)        # 10c68 <fwp_cleanups>
    5180:	4d 85 ff             	test   %r15,%r15
    5183:	0f 84 c8 00 00 00    	je     5251 <fwp_apply_owned+0x891>
    5189:	31 c0                	xor    %eax,%eax
    518b:	41 83 ff 06          	cmp    $0x6,%r15d
    518f:	72 55                	jb     51e6 <fwp_apply_owned+0x826>
    5191:	4c 89 e9             	mov    %r13,%rcx
    5194:	4c 29 e1             	sub    %r12,%rcx
    5197:	48 83 f9 20          	cmp    $0x20,%rcx
    519b:	72 49                	jb     51e6 <fwp_apply_owned+0x826>
    519d:	44 89 f8             	mov    %r15d,%eax
    51a0:	83 e0 fc             	and    $0xfffffffc,%eax
    51a3:	4a 8d 0c fd 00 00 00 	lea    0x0(,%r15,8),%rcx
    51aa:	00 
    51ab:	48 83 e1 e0          	and    $0xffffffffffffffe0,%rcx
    51af:	31 d2                	xor    %edx,%edx
    51b1:	66 66 66 66 66 66 2e 	data16 data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    51b8:	0f 1f 84 00 00 00 00 
    51bf:	00 
    51c0:	41 0f 10 44 14 08    	movups 0x8(%r12,%rdx,1),%xmm0
    51c6:	41 0f 10 4c 14 18    	movups 0x18(%r12,%rdx,1),%xmm1
    51cc:	41 0f 11 44 15 08    	movups %xmm0,0x8(%r13,%rdx,1)
    51d2:	41 0f 11 4c 15 18    	movups %xmm1,0x18(%r13,%rdx,1)
    51d8:	48 83 c2 20          	add    $0x20,%rdx
    51dc:	48 39 d1             	cmp    %rdx,%rcx
    51df:	75 df                	jne    51c0 <fwp_apply_owned+0x800>
    51e1:	4c 39 f8             	cmp    %r15,%rax
    51e4:	74 6b                	je     5251 <fwp_apply_owned+0x891>
    51e6:	4c 89 fa             	mov    %r15,%rdx
    51e9:	48 89 c1             	mov    %rax,%rcx
    51ec:	48 83 e2 03          	and    $0x3,%rdx
    51f0:	74 20                	je     5212 <fwp_apply_owned+0x852>
    51f2:	48 89 c1             	mov    %rax,%rcx
    51f5:	66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
    51fc:	00 00 00 00 
    5200:	49 8b 74 cc 08       	mov    0x8(%r12,%rcx,8),%rsi
    5205:	49 89 74 cd 08       	mov    %rsi,0x8(%r13,%rcx,8)
    520a:	48 ff c1             	inc    %rcx
    520d:	48 ff ca             	dec    %rdx
    5210:	75 ee                	jne    5200 <fwp_apply_owned+0x840>
    5212:	4c 29 f8             	sub    %r15,%rax
    5215:	48 83 f8 fc          	cmp    $0xfffffffffffffffc,%rax
    5219:	77 36                	ja     5251 <fwp_apply_owned+0x891>
    521b:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)
    5220:	49 8b 44 cc 08       	mov    0x8(%r12,%rcx,8),%rax
    5225:	49 89 44 cd 08       	mov    %rax,0x8(%r13,%rcx,8)
    522a:	49 8b 44 cc 10       	mov    0x10(%r12,%rcx,8),%rax
    522f:	49 89 44 cd 10       	mov    %rax,0x10(%r13,%rcx,8)
    5234:	49 8b 44 cc 18       	mov    0x18(%r12,%rcx,8),%rax
    5239:	49 89 44 cd 18       	mov    %rax,0x18(%r13,%rcx,8)
    523e:	49 8b 44 cc 20       	mov    0x20(%r12,%rcx,8),%rax
    5243:	49 89 44 cd 20       	mov    %rax,0x20(%r13,%rcx,8)
    5248:	48 83 c1 04          	add    $0x4,%rcx
    524c:	49 39 cf             	cmp    %rcx,%r15
    524f:	75 cf                	jne    5220 <fwp_apply_owned+0x860>
    5251:	83 7d c0 00          	cmpl   $0x0,-0x40(%rbp)
    5255:	0f 84 8b 00 00 00    	je     52e6 <fwp_apply_owned+0x926>
    525b:	48 8b 4d c0          	mov    -0x40(%rbp),%rcx
    525f:	89 c8                	mov    %ecx,%eax
    5261:	83 f9 14             	cmp    $0x14,%ecx
    5264:	0f 83 f4 00 00 00    	jae    535e <fwp_apply_owned+0x99e>
    526a:	31 c9                	xor    %ecx,%ecx
    526c:	48 89 c6             	mov    %rax,%rsi
    526f:	48 89 ca             	mov    %rcx,%rdx
    5272:	48 83 e6 03          	and    $0x3,%rsi
    5276:	74 1d                	je     5295 <fwp_apply_owned+0x8d5>
    5278:	48 89 ca             	mov    %rcx,%rdx
    527b:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)
    5280:	4c 8b 0c d3          	mov    (%rbx,%rdx,8),%r9
    5284:	45 8d 04 17          	lea    (%r15,%rdx,1),%r8d
    5288:	4f 89 4c c5 08       	mov    %r9,0x8(%r13,%r8,8)
    528d:	48 ff c2             	inc    %rdx
    5290:	48 ff ce             	dec    %rsi
    5293:	75 eb                	jne    5280 <fwp_apply_owned+0x8c0>
    5295:	48 29 c1             	sub    %rax,%rcx
    5298:	48 83 f9 fc          	cmp    $0xfffffffffffffffc,%rcx
    529c:	77 48                	ja     52e6 <fwp_apply_owned+0x926>
    529e:	66 90                	xchg   %ax,%ax
    52a0:	48 8b 0c d3          	mov    (%rbx,%rdx,8),%rcx
    52a4:	41 8d 34 17          	lea    (%r15,%rdx,1),%esi
    52a8:	49 89 4c f5 08       	mov    %rcx,0x8(%r13,%rsi,8)
    52ad:	48 8b 4c d3 08       	mov    0x8(%rbx,%rdx,8),%rcx
    52b2:	41 8d 34 17          	lea    (%r15,%rdx,1),%esi
    52b6:	ff c6                	inc    %esi
    52b8:	49 89 4c f5 08       	mov    %rcx,0x8(%r13,%rsi,8)
    52bd:	48 8b 4c d3 10       	mov    0x10(%rbx,%rdx,8),%rcx
    52c2:	41 8d 74 17 02       	lea    0x2(%r15,%rdx,1),%esi
    52c7:	49 89 4c f5 08       	mov    %rcx,0x8(%r13,%rsi,8)
    52cc:	48 8b 4c d3 18       	mov    0x18(%rbx,%rdx,8),%rcx
    52d1:	41 8d 34 17          	lea    (%r15,%rdx,1),%esi
    52d5:	83 c6 03             	add    $0x3,%esi
    52d8:	49 89 4c f5 08       	mov    %rcx,0x8(%r13,%rsi,8)
    52dd:	48 83 c2 04          	add    $0x4,%rdx
    52e1:	48 39 d0             	cmp    %rdx,%rax
    52e4:	75 ba                	jne    52a0 <fwp_apply_owned+0x8e0>
    52e6:	49 8b 02             	mov    (%r10),%rax
    52e9:	be 01 00 00 00       	mov    $0x1,%esi
    52ee:	ff 50 08             	call   *0x8(%rax)
    52f1:	4c 89 e8             	mov    %r13,%rax
    52f4:	48 2b 05 dd ae 00 00 	sub    0xaedd(%rip),%rax        # 101d8 <fwp_gc+0x1030>
    52fb:	48 8b 0d fe ae 00 00 	mov    0xaefe(%rip),%rcx        # 10200 <fwp_gc+0x1058>
    5302:	48 c1 e1 10          	shl    $0x10,%rcx
    5306:	48 39 c8             	cmp    %rcx,%rax
    5309:	0f 83 fa 00 00 00    	jae    5409 <fwp_apply_owned+0xa49>
    530f:	48 8b 0d 0a af 00 00 	mov    0xaf0a(%rip),%rcx        # 10220 <fwp_gc+0x1078>
    5316:	48 89 c2             	mov    %rax,%rdx
    5319:	48 c1 ea 10          	shr    $0x10,%rdx
    531d:	48 69 d2 28 12 00 00 	imul   $0x1228,%rdx,%rdx
    5324:	0f b6 34 11          	movzbl (%rcx,%rdx,1),%esi
    5328:	48 25 ff ff 00 00    	and    $0xffff,%rax
    532e:	0f 85 9c 00 00 00    	jne    53d0 <fwp_apply_owned+0xa10>
    5334:	40 80 fe 02          	cmp    $0x2,%sil
    5338:	0f 85 92 00 00 00    	jne    53d0 <fwp_apply_owned+0xa10>
    533e:	4c 8d 24 11          	lea    (%rcx,%rdx,1),%r12
    5342:	49 81 c4 28 02 00 00 	add    $0x228,%r12
    5349:	41 80 3c 24 ff       	cmpb   $0xff,(%r12)
    534e:	0f 84 a8 00 00 00    	je     53fc <fwp_apply_owned+0xa3c>
    5354:	41 c6 04 24 01       	movb   $0x1,(%r12)
    5359:	e9 ab 00 00 00       	jmp    5409 <fwp_apply_owned+0xa49>
    535e:	48 8d 50 ff          	lea    -0x1(%rax),%rdx
    5362:	31 c9                	xor    %ecx,%ecx
    5364:	89 d6                	mov    %edx,%esi
    5366:	44 01 fe             	add    %r15d,%esi
    5369:	0f 82 fd fe ff ff    	jb     526c <fwp_apply_owned+0x8ac>
    536f:	48 c1 ea 20          	shr    $0x20,%rdx
    5373:	0f 85 f3 fe ff ff    	jne    526c <fwp_apply_owned+0x8ac>
    5379:	4a 8d 0c fd 00 00 00 	lea    0x0(,%r15,8),%rcx
    5380:	00 
    5381:	4c 01 e9             	add    %r13,%rcx
    5384:	48 29 d9             	sub    %rbx,%rcx
    5387:	48 83 c1 08          	add    $0x8,%rcx
    538b:	48 83 f9 20          	cmp    $0x20,%rcx
    538f:	0f 82 d5 fe ff ff    	jb     526a <fwp_apply_owned+0x8aa>
    5395:	89 c1                	mov    %eax,%ecx
    5397:	83 e1 fc             	and    $0xfffffffc,%ecx
    539a:	31 d2                	xor    %edx,%edx
    539c:	0f 1f 40 00          	nopl   0x0(%rax)
    53a0:	0f 10 04 d3          	movups (%rbx,%rdx,8),%xmm0
    53a4:	0f 10 4c d3 10       	movups 0x10(%rbx,%rdx,8),%xmm1
    53a9:	41 8d 34 17          	lea    (%r15,%rdx,1),%esi
    53ad:	41 0f 11 44 f5 08    	movups %xmm0,0x8(%r13,%rsi,8)
    53b3:	41 0f 11 4c f5 18    	movups %xmm1,0x18(%r13,%rsi,8)
    53b9:	48 83 c2 04          	add    $0x4,%rdx
    53bd:	48 39 d1             	cmp    %rdx,%rcx
    53c0:	75 de                	jne    53a0 <fwp_apply_owned+0x9e0>
    53c2:	48 39 c1             	cmp    %rax,%rcx
    53c5:	0f 85 a1 fe ff ff    	jne    526c <fwp_apply_owned+0x8ac>
    53cb:	e9 16 ff ff ff       	jmp    52e6 <fwp_apply_owned+0x926>
    53d0:	40 80 fe 01          	cmp    $0x1,%sil
    53d4:	75 33                	jne    5409 <fwp_apply_owned+0xa49>
    53d6:	48 8d 34 11          	lea    (%rcx,%rdx,1),%rsi
    53da:	8b 4c 11 20          	mov    0x20(%rcx,%rdx,1),%ecx
    53de:	48 0f af c1          	imul   %rcx,%rax
    53e2:	48 c1 e8 20          	shr    $0x20,%rax
    53e6:	4c 8d 24 30          	lea    (%rax,%rsi,1),%r12
    53ea:	49 81 c4 28 02 00 00 	add    $0x228,%r12
    53f1:	41 80 3c 24 ff       	cmpb   $0xff,(%r12)
    53f6:	0f 85 58 ff ff ff    	jne    5354 <fwp_apply_owned+0x994>
    53fc:	4c 89 e7             	mov    %r12,%rdi
    53ff:	e8 dc e3 ff ff       	call   37e0 <fwp_rc_forget_slot>
    5404:	e9 4b ff ff ff       	jmp    5354 <fwp_apply_owned+0x994>
    5409:	48 8b 45 c0          	mov    -0x40(%rbp),%rax
    540d:	89 45 80             	mov    %eax,-0x80(%rbp)
    5410:	48 c7 45 b0 00 00 00 	movq   $0x0,-0x50(%rbp)
    5417:	00 
    5418:	4c 39 35 49 b8 00 00 	cmp    %r14,0xb849(%rip)        # 10c68 <fwp_cleanups>
    541f:	75 46                	jne    5467 <fwp_apply_owned+0xaa7>
    5421:	48 8b 85 50 ff ff ff 	mov    -0xb0(%rbp),%rax
    5428:	48 89 05 39 b8 00 00 	mov    %rax,0xb839(%rip)        # 10c68 <fwp_cleanups>
    542f:	80 7d bc 00          	cmpb   $0x0,-0x44(%rbp)
    5433:	48 8b 7d c8          	mov    -0x38(%rbp),%rdi
    5437:	74 14                	je     544d <fwp_apply_owned+0xa8d>
    5439:	48 8d 4d 98          	lea    -0x68(%rbp),%rcx
    543d:	48 39 c8             	cmp    %rcx,%rax
    5440:	75 25                	jne    5467 <fwp_apply_owned+0xaa7>
    5442:	48 8b 45 98          	mov    -0x68(%rbp),%rax
    5446:	48 89 05 1b b8 00 00 	mov    %rax,0xb81b(%rip)        # 10c68 <fwp_cleanups>
    544d:	e8 9e 0b 00 00       	call   5ff0 <fwp_closure_drop>
    5452:	4d 89 ec             	mov    %r13,%r12
    5455:	4c 89 e0             	mov    %r12,%rax
    5458:	48 8d 65 d8          	lea    -0x28(%rbp),%rsp
    545c:	5b                   	pop    %rbx
    545d:	41 5c                	pop    %r12
    545f:	41 5d                	pop    %r13
    5461:	41 5e                	pop    %r14
    5463:	41 5f                	pop    %r15
    5465:	5d                   	pop    %rbp
    5466:	c3                   	ret
    5467:	e8 f4 cb ff ff       	call   2060 <abort@plt>
    546c:	0f 1f 40 00          	nopl   0x0(%rax)

0000000000005470 <fwp_gc_alloc_slow>:
    5470:	41 57                	push   %r15
    5472:	41 56                	push   %r14
    5474:	41 55                	push   %r13
    5476:	41 54                	push   %r12
    5478:	53                   	push   %rbx
    5479:	89 f3                	mov    %esi,%ebx
    547b:	83 3d 12 ad 00 00 00 	cmpl   $0x0,0xad12(%rip)        # 10194 <fwp_gc+0xfec>
    5482:	74 19                	je     549d <fwp_gc_alloc_slow+0x2d>
    5484:	48 81 ff 01 40 00 00 	cmp    $0x4001,%rdi
    548b:	72 24                	jb     54b1 <fwp_gc_alloc_slow+0x41>
    548d:	89 de                	mov    %ebx,%esi
    548f:	5b                   	pop    %rbx
    5490:	41 5c                	pop    %r12
    5492:	41 5d                	pop    %r13
    5494:	41 5e                	pop    %r14
    5496:	41 5f                	pop    %r15
    5498:	e9 33 06 00 00       	jmp    5ad0 <fwp_gc_alloc_big>
    549d:	49 89 fe             	mov    %rdi,%r14
    54a0:	e8 5b 01 00 00       	call   5600 <fwp_gc_init>
    54a5:	4c 89 f7             	mov    %r14,%rdi
    54a8:	48 81 ff 01 40 00 00 	cmp    $0x4001,%rdi
    54af:	73 dc                	jae    548d <fwp_gc_alloc_slow+0x1d>
    54b1:	48 8d 47 0f          	lea    0xf(%rdi),%rax
    54b5:	48 c1 e8 04          	shr    $0x4,%rax
    54b9:	4c 8d 3d e8 9c 00 00 	lea    0x9ce8(%rip),%r15        # f1a8 <fwp_gc>
    54c0:	46 0f b6 b4 38 e8 0b 	movzbl 0xbe8(%rax,%r15,1),%r14d
    54c7:	00 00 
    54c9:	43 8b 94 b7 48 0b 00 	mov    0xb48(%r15,%r14,4),%edx
    54d0:	00 
    54d1:	48 83 3d cf 9c 00 00 	cmpq   $0x0,0x9ccf(%rip)        # f1a8 <fwp_gc>
    54d8:	00 
    54d9:	0f 89 8c 00 00 00    	jns    556b <fwp_gc_alloc_slow+0xfb>
    54df:	83 3d ae ac 00 00 00 	cmpl   $0x0,0xacae(%rip)        # 10194 <fwp_gc+0xfec>
    54e6:	75 11                	jne    54f9 <fwp_gc_alloc_slow+0x89>
    54e8:	49 89 fc             	mov    %rdi,%r12
    54eb:	49 89 d5             	mov    %rdx,%r13
    54ee:	e8 0d 01 00 00       	call   5600 <fwp_gc_init>
    54f3:	4c 89 ea             	mov    %r13,%rdx
    54f6:	4c 89 e7             	mov    %r12,%rdi
    54f9:	8b 0d 9d ac 00 00    	mov    0xac9d(%rip),%ecx        # 1019c <fwp_gc+0xff4>
    54ff:	85 c9                	test   %ecx,%ecx
    5501:	74 2a                	je     552d <fwp_gc_alloc_slow+0xbd>
    5503:	48 8b 05 be ac 00 00 	mov    0xacbe(%rip),%rax        # 101c8 <fwp_gc+0x1020>
    550a:	48 85 c0             	test   %rax,%rax
    550d:	74 1e                	je     552d <fwp_gc_alloc_slow+0xbd>
    550f:	48 8b 0d ba ac 00 00 	mov    0xacba(%rip),%rcx        # 101d0 <fwp_gc+0x1028>
    5516:	48 ff c1             	inc    %rcx
    5519:	48 89 0d b0 ac 00 00 	mov    %rcx,0xacb0(%rip)        # 101d0 <fwp_gc+0x1028>
    5520:	48 39 c1             	cmp    %rax,%rcx
    5523:	0f 8d c7 00 00 00    	jge    55f0 <fwp_gc_alloc_slow+0x180>
    5529:	31 c0                	xor    %eax,%eax
    552b:	eb 0d                	jmp    553a <fwp_gc_alloc_slow+0xca>
    552d:	b8 00 00 80 00       	mov    $0x800000,%eax
    5532:	85 c9                	test   %ecx,%ecx
    5534:	0f 85 b1 00 00 00    	jne    55eb <fwp_gc_alloc_slow+0x17b>
    553a:	48 8b 0d 77 ae 00 00 	mov    0xae77(%rip),%rcx        # 103b8 <fwp_gc+0x1210>
    5541:	48 2b 0d 60 9c 00 00 	sub    0x9c60(%rip),%rcx        # f1a8 <fwp_gc>
    5548:	f2 48 0f 2a c1       	cvtsi2sd %rcx,%xmm0
    554d:	f2 0f 58 05 3b ae 00 	addsd  0xae3b(%rip),%xmm0        # 10390 <fwp_gc+0x11e8>
    5554:	00 
    5555:	f2 0f 11 05 33 ae 00 	movsd  %xmm0,0xae33(%rip)        # 10390 <fwp_gc+0x11e8>
    555c:	00 
    555d:	48 89 05 54 ae 00 00 	mov    %rax,0xae54(%rip)        # 103b8 <fwp_gc+0x1210>
    5564:	48 89 05 3d 9c 00 00 	mov    %rax,0x9c3d(%rip)        # f1a8 <fwp_gc>
    556b:	89 d8                	mov    %ebx,%eax
    556d:	48 69 c0 c0 03 00 00 	imul   $0x3c0,%rax,%rax
    5574:	49 01 c7             	add    %rax,%r15
    5577:	4b 8d 34 76          	lea    (%r14,%r14,2),%rsi
    557b:	49 8d 0c f7          	lea    (%r15,%rsi,8),%rcx
    557f:	48 83 c1 08          	add    $0x8,%rcx
    5583:	49 8b 44 f7 08       	mov    0x8(%r15,%rsi,8),%rax
    5588:	48 85 c0             	test   %rax,%rax
    558b:	74 08                	je     5595 <fwp_gc_alloc_slow+0x125>
    558d:	48 8b 30             	mov    (%rax),%rsi
    5590:	48 f7 d6             	not    %rsi
    5593:	eb 39                	jmp    55ce <fwp_gc_alloc_slow+0x15e>
    5595:	49 8b 44 f7 10       	mov    0x10(%r15,%rsi,8),%rax
    559a:	4d 8b 44 f7 18       	mov    0x18(%r15,%rsi,8),%r8
    559f:	49 29 c0             	sub    %rax,%r8
    55a2:	49 39 d0             	cmp    %rdx,%r8
    55a5:	73 1b                	jae    55c2 <fwp_gc_alloc_slow+0x152>
    55a7:	49 89 ff             	mov    %rdi,%r15
    55aa:	48 89 cf             	mov    %rcx,%rdi
    55ad:	44 89 f6             	mov    %r14d,%esi
    55b0:	49 89 d6             	mov    %rdx,%r14
    55b3:	89 da                	mov    %ebx,%edx
    55b5:	e8 46 07 00 00       	call   5d00 <fwp_gc_refill>
    55ba:	4c 89 f2             	mov    %r14,%rdx
    55bd:	4c 89 ff             	mov    %r15,%rdi
    55c0:	eb 0f                	jmp    55d1 <fwp_gc_alloc_slow+0x161>
    55c2:	49 8d 0c f7          	lea    (%r15,%rsi,8),%rcx
    55c6:	48 83 c1 10          	add    $0x10,%rcx
    55ca:	48 8d 34 10          	lea    (%rax,%rdx,1),%rsi
    55ce:	48 89 31             	mov    %rsi,(%rcx)
    55d1:	83 fb 01             	cmp    $0x1,%ebx
    55d4:	48 0f 44 d7          	cmove  %rdi,%rdx
    55d8:	48 89 c7             	mov    %rax,%rdi
    55db:	31 f6                	xor    %esi,%esi
    55dd:	5b                   	pop    %rbx
    55de:	41 5c                	pop    %r12
    55e0:	41 5d                	pop    %r13
    55e2:	41 5e                	pop    %r14
    55e4:	41 5f                	pop    %r15
    55e6:	e9 75 cb ff ff       	jmp    2160 <memset@plt>
    55eb:	e8 d0 09 00 00       	call   5fc0 <fwp_gc_collect>
    55f0:	48 c7 05 d5 ab 00 00 	movq   $0x0,0xabd5(%rip)        # 101d0 <fwp_gc+0x1028>
    55f7:	00 00 00 00 
    55fb:	e8 c0 09 00 00       	call   5fc0 <fwp_gc_collect>

0000000000005600 <fwp_gc_init>:
    5600:	41 56                	push   %r14
    5602:	53                   	push   %rbx
    5603:	50                   	push   %rax
    5604:	c7 05 86 ab 00 00 01 	movl   $0x1,0xab86(%rip)        # 10194 <fwp_gc+0xfec>
    560b:	00 00 00 
    560e:	0f 28 05 fb 69 00 00 	movaps 0x69fb(%rip),%xmm0        # c010 <_IO_stdin_used+0x10>
    5615:	0f 11 05 d4 a6 00 00 	movups %xmm0,0xa6d4(%rip)        # fcf0 <fwp_gc+0xb48>
    561c:	0f 28 05 fd 69 00 00 	movaps 0x69fd(%rip),%xmm0        # c020 <_IO_stdin_used+0x20>
    5623:	0f 11 05 d6 a6 00 00 	movups %xmm0,0xa6d6(%rip)        # fd00 <fwp_gc+0xb58>
    562a:	0f 28 05 ff 69 00 00 	movaps 0x69ff(%rip),%xmm0        # c030 <_IO_stdin_used+0x30>
    5631:	0f 11 05 d8 a6 00 00 	movups %xmm0,0xa6d8(%rip)        # fd10 <fwp_gc+0xb68>
    5638:	0f 28 05 01 6a 00 00 	movaps 0x6a01(%rip),%xmm0        # c040 <_IO_stdin_used+0x40>
    563f:	0f 11 05 da a6 00 00 	movups %xmm0,0xa6da(%rip)        # fd20 <fwp_gc+0xb78>
    5646:	0f 28 05 03 6a 00 00 	movaps 0x6a03(%rip),%xmm0        # c050 <_IO_stdin_used+0x50>
    564d:	0f 11 05 dc a6 00 00 	movups %xmm0,0xa6dc(%rip)        # fd30 <fwp_gc+0xb88>
    5654:	0f 28 05 05 6a 00 00 	movaps 0x6a05(%rip),%xmm0        # c060 <_IO_stdin_used+0x60>
    565b:	0f 11 05 de a6 00 00 	movups %xmm0,0xa6de(%rip)        # fd40 <fwp_gc+0xb98>
    5662:	0f 28 05 07 6a 00 00 	movaps 0x6a07(%rip),%xmm0        # c070 <_IO_stdin_used+0x70>
    5669:	0f 11 05 e0 a6 00 00 	movups %xmm0,0xa6e0(%rip)        # fd50 <fwp_gc+0xba8>
    5670:	0f 28 05 09 6a 00 00 	movaps 0x6a09(%rip),%xmm0        # c080 <_IO_stdin_used+0x80>
    5677:	0f 11 05 e2 a6 00 00 	movups %xmm0,0xa6e2(%rip)        # fd60 <fwp_gc+0xbb8>
    567e:	0f 28 05 0b 6a 00 00 	movaps 0x6a0b(%rip),%xmm0        # c090 <_IO_stdin_used+0x90>
    5685:	0f 11 05 e4 a6 00 00 	movups %xmm0,0xa6e4(%rip)        # fd70 <fwp_gc+0xbc8>
    568c:	0f 28 05 0d 6a 00 00 	movaps 0x6a0d(%rip),%xmm0        # c0a0 <_IO_stdin_used+0xa0>
    5693:	0f 11 05 e6 a6 00 00 	movups %xmm0,0xa6e6(%rip)        # fd80 <fwp_gc+0xbd8>
    569a:	31 c9                	xor    %ecx,%ecx
    569c:	48 8d 05 05 9b 00 00 	lea    0x9b05(%rip),%rax        # f1a8 <fwp_gc>
    56a3:	31 d2                	xor    %edx,%edx
    56a5:	66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
    56ac:	00 00 00 00 
    56b0:	89 d6                	mov    %edx,%esi
    56b2:	c1 e6 04             	shl    $0x4,%esi
    56b5:	48 ff c9             	dec    %rcx
    56b8:	48 89 cf             	mov    %rcx,%rdi
    56bb:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)
    56c0:	48 89 f9             	mov    %rdi,%rcx
    56c3:	48 ff c7             	inc    %rdi
    56c6:	3b b4 88 4c 0b 00 00 	cmp    0xb4c(%rax,%rcx,4),%esi
    56cd:	77 f1                	ja     56c0 <fwp_gc_init+0xc0>
    56cf:	40 88 bc 02 e8 0b 00 	mov    %dil,0xbe8(%rdx,%rax,1)
    56d6:	00 
    56d7:	48 89 d6             	mov    %rdx,%rsi
    56da:	48 83 ce 01          	or     $0x1,%rsi
    56de:	48 81 fe 01 04 00 00 	cmp    $0x401,%rsi
    56e5:	74 26                	je     570d <fwp_gc_init+0x10d>
    56e7:	89 f7                	mov    %esi,%edi
    56e9:	c1 e7 04             	shl    $0x4,%edi
    56ec:	0f 1f 40 00          	nopl   0x0(%rax)
    56f0:	49 89 c8             	mov    %rcx,%r8
    56f3:	48 ff c1             	inc    %rcx
    56f6:	42 3b bc 80 4c 0b 00 	cmp    0xb4c(%rax,%r8,4),%edi
    56fd:	00 
    56fe:	77 f0                	ja     56f0 <fwp_gc_init+0xf0>
    5700:	88 8c 06 e8 0b 00 00 	mov    %cl,0xbe8(%rsi,%rax,1)
    5707:	48 83 c2 02          	add    $0x2,%rdx
    570b:	eb a3                	jmp    56b0 <fwp_gc_init+0xb0>
    570d:	48 bb 00 00 00 00 10 	movabs $0x1000000000,%rbx
    5714:	00 00 00 
    5717:	48 8d b3 00 00 01 00 	lea    0x10000(%rbx),%rsi
    571e:	31 ff                	xor    %edi,%edi
    5720:	31 d2                	xor    %edx,%edx
    5722:	b9 22 40 00 00       	mov    $0x4022,%ecx
    5727:	41 b8 ff ff ff ff    	mov    $0xffffffff,%r8d
    572d:	45 31 c9             	xor    %r9d,%r9d
    5730:	e8 eb c9 ff ff       	call   2120 <mmap@plt>
    5735:	48 83 f8 ff          	cmp    $0xffffffffffffffff,%rax
    5739:	75 60                	jne    579b <fwp_gc_init+0x19b>
    573b:	48 bb 00 00 00 00 04 	movabs $0x400000000,%rbx
    5742:	00 00 00 
    5745:	48 8d b3 00 00 01 00 	lea    0x10000(%rbx),%rsi
    574c:	31 ff                	xor    %edi,%edi
    574e:	31 d2                	xor    %edx,%edx
    5750:	b9 22 40 00 00       	mov    $0x4022,%ecx
    5755:	41 b8 ff ff ff ff    	mov    $0xffffffff,%r8d
    575b:	45 31 c9             	xor    %r9d,%r9d
    575e:	e8 bd c9 ff ff       	call   2120 <mmap@plt>
    5763:	48 83 f8 ff          	cmp    $0xffffffffffffffff,%rax
    5767:	75 32                	jne    579b <fwp_gc_init+0x19b>
    5769:	48 bb 00 00 00 00 01 	movabs $0x100000000,%rbx
    5770:	00 00 00 
    5773:	48 8d b3 00 00 01 00 	lea    0x10000(%rbx),%rsi
    577a:	31 ff                	xor    %edi,%edi
    577c:	31 d2                	xor    %edx,%edx
    577e:	b9 22 40 00 00       	mov    $0x4022,%ecx
    5783:	41 b8 ff ff ff ff    	mov    $0xffffffff,%r8d
    5789:	45 31 c9             	xor    %r9d,%r9d
    578c:	e8 8f c9 ff ff       	call   2120 <mmap@plt>
    5791:	48 83 f8 ff          	cmp    $0xffffffffffffffff,%rax
    5795:	0f 84 4e 02 00 00    	je     59e9 <fwp_gc_init+0x3e9>
    579b:	48 85 c0             	test   %rax,%rax
    579e:	0f 84 a6 02 00 00    	je     5a4a <fwp_gc_init+0x44a>
    57a4:	48 89 05 35 aa 00 00 	mov    %rax,0xaa35(%rip)        # 101e0 <fwp_gc+0x1038>
    57ab:	48 89 d9             	mov    %rbx,%rcx
    57ae:	48 81 c9 00 00 01 00 	or     $0x10000,%rcx
    57b5:	48 89 0d 2c aa 00 00 	mov    %rcx,0xaa2c(%rip)        # 101e8 <fwp_gc+0x1040>
    57bc:	48 05 ff ff 00 00    	add    $0xffff,%rax
    57c2:	48 25 00 00 ff ff    	and    $0xffffffffffff0000,%rax
    57c8:	48 89 05 09 aa 00 00 	mov    %rax,0xaa09(%rip)        # 101d8 <fwp_gc+0x1030>
    57cf:	48 c1 eb 10          	shr    $0x10,%rbx
    57d3:	48 89 1d 1e aa 00 00 	mov    %rbx,0xaa1e(%rip)        # 101f8 <fwp_gc+0x1050>
    57da:	48 69 f3 28 12 00 00 	imul   $0x1228,%rbx,%rsi
    57e1:	48 89 35 40 aa 00 00 	mov    %rsi,0xaa40(%rip)        # 10228 <fwp_gc+0x1080>
    57e8:	31 ff                	xor    %edi,%edi
    57ea:	31 d2                	xor    %edx,%edx
    57ec:	b9 22 40 00 00       	mov    $0x4022,%ecx
    57f1:	41 b8 ff ff ff ff    	mov    $0xffffffff,%r8d
    57f7:	45 31 c9             	xor    %r9d,%r9d
    57fa:	e8 21 c9 ff ff       	call   2120 <mmap@plt>
    57ff:	48 83 f8 ff          	cmp    $0xffffffffffffffff,%rax
    5803:	0f 84 41 02 00 00    	je     5a4a <fwp_gc_init+0x44a>
    5809:	48 89 05 10 aa 00 00 	mov    %rax,0xaa10(%rip)        # 10220 <fwp_gc+0x1078>
    5810:	48 8d 3d 53 6b 00 00 	lea    0x6b53(%rip),%rdi        # c36a <fwp_segv.msg+0x12a>
    5817:	e8 14 c8 ff ff       	call   2030 <getenv@plt>
    581c:	48 85 c0             	test   %rax,%rax
    581f:	74 2e                	je     584f <fwp_gc_init+0x24f>
    5821:	48 89 c3             	mov    %rax,%rbx
    5824:	48 8d 35 46 6b 00 00 	lea    0x6b46(%rip),%rsi        # c371 <fwp_segv.msg+0x131>
    582b:	48 89 c7             	mov    %rax,%rdi
    582e:	e8 8d c9 ff ff       	call   21c0 <strcmp@plt>
    5833:	85 c0                	test   %eax,%eax
    5835:	74 1f                	je     5856 <fwp_gc_init+0x256>
    5837:	48 8d 35 71 6d 00 00 	lea    0x6d71(%rip),%rsi        # c5af <fwp_segv.msg+0x36f>
    583e:	48 89 df             	mov    %rbx,%rdi
    5841:	e8 7a c9 ff ff       	call   21c0 <strcmp@plt>
    5846:	31 c9                	xor    %ecx,%ecx
    5848:	85 c0                	test   %eax,%eax
    584a:	0f 95 c1             	setne  %cl
    584d:	eb 09                	jmp    5858 <fwp_gc_init+0x258>
    584f:	b9 01 00 00 00       	mov    $0x1,%ecx
    5854:	eb 02                	jmp    5858 <fwp_gc_init+0x258>
    5856:	31 c9                	xor    %ecx,%ecx
    5858:	89 0d 3a a9 00 00    	mov    %ecx,0xa93a(%rip)        # 10198 <fwp_gc+0xff0>
    585e:	48 8d 3d 10 6b 00 00 	lea    0x6b10(%rip),%rdi        # c375 <fwp_segv.msg+0x135>
    5865:	e8 c6 c7 ff ff       	call   2030 <getenv@plt>
    586a:	31 c9                	xor    %ecx,%ecx
    586c:	48 85 c0             	test   %rax,%rax
    586f:	74 1b                	je     588c <fwp_gc_init+0x28c>
    5871:	80 38 00             	cmpb   $0x0,(%rax)
    5874:	74 16                	je     588c <fwp_gc_init+0x28c>
    5876:	48 8d 35 32 6d 00 00 	lea    0x6d32(%rip),%rsi        # c5af <fwp_segv.msg+0x36f>
    587d:	48 89 c7             	mov    %rax,%rdi
    5880:	e8 3b c9 ff ff       	call   21c0 <strcmp@plt>
    5885:	31 c9                	xor    %ecx,%ecx
    5887:	85 c0                	test   %eax,%eax
    5889:	0f 95 c1             	setne  %cl
    588c:	89 0d 12 a9 00 00    	mov    %ecx,0xa912(%rip)        # 101a4 <fwp_gc+0xffc>
    5892:	48 8d 3d d1 6a 00 00 	lea    0x6ad1(%rip),%rdi        # c36a <fwp_segv.msg+0x12a>
    5899:	e8 92 c7 ff ff       	call   2030 <getenv@plt>
    589e:	48 85 c0             	test   %rax,%rax
    58a1:	74 18                	je     58bb <fwp_gc_init+0x2bb>
    58a3:	48 8d 35 d8 6a 00 00 	lea    0x6ad8(%rip),%rsi        # c382 <fwp_segv.msg+0x142>
    58aa:	48 89 c7             	mov    %rax,%rdi
    58ad:	e8 0e c9 ff ff       	call   21c0 <strcmp@plt>
    58b2:	31 c9                	xor    %ecx,%ecx
    58b4:	85 c0                	test   %eax,%eax
    58b6:	0f 95 c1             	setne  %cl
    58b9:	eb 05                	jmp    58c0 <fwp_gc_init+0x2c0>
    58bb:	b9 01 00 00 00       	mov    $0x1,%ecx
    58c0:	89 0d e2 a8 00 00    	mov    %ecx,0xa8e2(%rip)        # 101a8 <fwp_gc+0x1000>
    58c6:	c7 05 e0 a8 00 00 01 	movl   $0x1,0xa8e0(%rip)        # 101b0 <fwp_gc+0x1008>
    58cd:	00 00 00 
    58d0:	48 8d 3d b0 6a 00 00 	lea    0x6ab0(%rip),%rdi        # c387 <fwp_segv.msg+0x147>
    58d7:	e8 54 c7 ff ff       	call   2030 <getenv@plt>
    58dc:	31 c9                	xor    %ecx,%ecx
    58de:	48 85 c0             	test   %rax,%rax
    58e1:	74 1b                	je     58fe <fwp_gc_init+0x2fe>
    58e3:	80 38 00             	cmpb   $0x0,(%rax)
    58e6:	74 16                	je     58fe <fwp_gc_init+0x2fe>
    58e8:	48 8d 35 c0 6c 00 00 	lea    0x6cc0(%rip),%rsi        # c5af <fwp_segv.msg+0x36f>
    58ef:	48 89 c7             	mov    %rax,%rdi
    58f2:	e8 c9 c8 ff ff       	call   21c0 <strcmp@plt>
    58f7:	31 c9                	xor    %ecx,%ecx
    58f9:	85 c0                	test   %eax,%eax
    58fb:	0f 95 c1             	setne  %cl
    58fe:	89 0d a8 a8 00 00    	mov    %ecx,0xa8a8(%rip)        # 101ac <fwp_gc+0x1004>
    5904:	48 8d 3d 8a 6a 00 00 	lea    0x6a8a(%rip),%rdi        # c395 <fwp_segv.msg+0x155>
    590b:	e8 20 c7 ff ff       	call   2030 <getenv@plt>
    5910:	48 85 c0             	test   %rax,%rax
    5913:	74 14                	je     5929 <fwp_gc_init+0x329>
    5915:	48 89 c7             	mov    %rax,%rdi
    5918:	31 f6                	xor    %esi,%esi
    591a:	ba 0a 00 00 00       	mov    $0xa,%edx
    591f:	e8 dc c8 ff ff       	call   2200 <strtol@plt>
    5924:	48 89 c3             	mov    %rax,%rbx
    5927:	eb 02                	jmp    592b <fwp_gc_init+0x32b>
    5929:	31 db                	xor    %ebx,%ebx
    592b:	31 c0                	xor    %eax,%eax
    592d:	48 85 db             	test   %rbx,%rbx
    5930:	48 0f 4f c3          	cmovg  %rbx,%rax
    5934:	48 89 05 8d a8 00 00 	mov    %rax,0xa88d(%rip)        # 101c8 <fwp_gc+0x1020>
    593b:	48 8d 3d 28 6a 00 00 	lea    0x6a28(%rip),%rdi        # c36a <fwp_segv.msg+0x12a>
    5942:	e8 e9 c6 ff ff       	call   2030 <getenv@plt>
    5947:	48 85 c0             	test   %rax,%rax
    594a:	74 32                	je     597e <fwp_gc_init+0x37e>
    594c:	49 89 c6             	mov    %rax,%r14
    594f:	80 38 00             	cmpb   $0x0,(%rax)
    5952:	74 2a                	je     597e <fwp_gc_init+0x37e>
    5954:	48 8d 35 16 6a 00 00 	lea    0x6a16(%rip),%rsi        # c371 <fwp_segv.msg+0x131>
    595b:	4c 89 f7             	mov    %r14,%rdi
    595e:	e8 5d c8 ff ff       	call   21c0 <strcmp@plt>
    5963:	85 c0                	test   %eax,%eax
    5965:	74 17                	je     597e <fwp_gc_init+0x37e>
    5967:	48 8d 35 41 6c 00 00 	lea    0x6c41(%rip),%rsi        # c5af <fwp_segv.msg+0x36f>
    596e:	4c 89 f7             	mov    %r14,%rdi
    5971:	e8 4a c8 ff ff       	call   21c0 <strcmp@plt>
    5976:	85 c0                	test   %eax,%eax
    5978:	0f 85 f6 00 00 00    	jne    5a74 <fwp_gc_init+0x474>
    597e:	48 85 db             	test   %rbx,%rbx
    5981:	0f 8f ed 00 00 00    	jg     5a74 <fwp_gc_init+0x474>
    5987:	83 3d 1e a8 00 00 00 	cmpl   $0x0,0xa81e(%rip)        # 101ac <fwp_gc+0x1004>
    598e:	0f 85 e0 00 00 00    	jne    5a74 <fwp_gc_init+0x474>
    5994:	48 8d 3d 45 6a 00 00 	lea    0x6a45(%rip),%rdi        # c3e0 <fwp_segv.msg+0x1a0>
    599b:	e8 90 c6 ff ff       	call   2030 <getenv@plt>
    59a0:	48 85 c0             	test   %rax,%rax
    59a3:	74 1c                	je     59c1 <fwp_gc_init+0x3c1>
    59a5:	80 38 00             	cmpb   $0x0,(%rax)
    59a8:	74 17                	je     59c1 <fwp_gc_init+0x3c1>
    59aa:	48 8d 35 fe 6b 00 00 	lea    0x6bfe(%rip),%rsi        # c5af <fwp_segv.msg+0x36f>
    59b1:	48 89 c7             	mov    %rax,%rdi
    59b4:	e8 07 c8 ff ff       	call   21c0 <strcmp@plt>
    59b9:	85 c0                	test   %eax,%eax
    59bb:	0f 85 e1 00 00 00    	jne    5aa2 <fwp_gc_init+0x4a2>
    59c1:	c7 05 cd a7 00 00 00 	movl   $0x0,0xa7cd(%rip)        # 10198 <fwp_gc+0xff0>
    59c8:	00 00 00 
    59cb:	48 c7 05 e2 a9 00 00 	movq   $0x800000,0xa9e2(%rip)        # 103b8 <fwp_gc+0x1210>
    59d2:	00 00 80 00 
    59d6:	48 c7 05 c7 97 00 00 	movq   $0x800000,0x97c7(%rip)        # f1a8 <fwp_gc>
    59dd:	00 00 80 00 
    59e1:	48 83 c4 08          	add    $0x8,%rsp
    59e5:	5b                   	pop    %rbx
    59e6:	41 5e                	pop    %r14
    59e8:	c3                   	ret
    59e9:	be 00 00 01 40       	mov    $0x40010000,%esi
    59ee:	31 ff                	xor    %edi,%edi
    59f0:	31 d2                	xor    %edx,%edx
    59f2:	b9 22 40 00 00       	mov    $0x4022,%ecx
    59f7:	41 b8 ff ff ff ff    	mov    $0xffffffff,%r8d
    59fd:	45 31 c9             	xor    %r9d,%r9d
    5a00:	e8 1b c7 ff ff       	call   2120 <mmap@plt>
    5a05:	48 83 f8 ff          	cmp    $0xffffffffffffffff,%rax
    5a09:	74 0f                	je     5a1a <fwp_gc_init+0x41a>
    5a0b:	48 85 c0             	test   %rax,%rax
    5a0e:	74 3a                	je     5a4a <fwp_gc_init+0x44a>
    5a10:	bb 00 00 00 40       	mov    $0x40000000,%ebx
    5a15:	e9 8a fd ff ff       	jmp    57a4 <fwp_gc_init+0x1a4>
    5a1a:	be 00 00 01 10       	mov    $0x10010000,%esi
    5a1f:	31 ff                	xor    %edi,%edi
    5a21:	31 d2                	xor    %edx,%edx
    5a23:	b9 22 40 00 00       	mov    $0x4022,%ecx
    5a28:	41 b8 ff ff ff ff    	mov    $0xffffffff,%r8d
    5a2e:	45 31 c9             	xor    %r9d,%r9d
    5a31:	e8 ea c6 ff ff       	call   2120 <mmap@plt>
    5a36:	48 8d 48 01          	lea    0x1(%rax),%rcx
    5a3a:	48 83 f9 02          	cmp    $0x2,%rcx
    5a3e:	72 0a                	jb     5a4a <fwp_gc_init+0x44a>
    5a40:	bb 00 00 00 10       	mov    $0x10000000,%ebx
    5a45:	e9 5a fd ff ff       	jmp    57a4 <fwp_gc_init+0x1a4>
    5a4a:	48 8b 05 8f 95 00 00 	mov    0x958f(%rip),%rax        # efe0 <stderr@GLIBC_2.2.5>
    5a51:	48 8b 08             	mov    (%rax),%rcx
    5a54:	48 8d 3d d5 69 00 00 	lea    0x69d5(%rip),%rdi        # c430 <fwp_segv.msg+0x1f0>
    5a5b:	be 13 00 00 00       	mov    $0x13,%esi
    5a60:	ba 01 00 00 00       	mov    $0x1,%edx
    5a65:	e8 76 c8 ff ff       	call   22e0 <fwrite@plt>
    5a6a:	bf 66 00 00 00       	mov    $0x66,%edi
    5a6f:	e8 5c c8 ff ff       	call   22d0 <exit@plt>
    5a74:	e8 37 dd ff ff       	call   37b0 <fwp_flush>
    5a79:	48 8b 05 60 95 00 00 	mov    0x9560(%rip),%rax        # efe0 <stderr@GLIBC_2.2.5>
    5a80:	48 8b 38             	mov    (%rax),%rdi
    5a83:	48 8d 35 aa 68 00 00 	lea    0x68aa(%rip),%rsi        # c334 <fwp_segv.msg+0xf4>
    5a8a:	48 8d 15 12 69 00 00 	lea    0x6912(%rip),%rdx        # c3a3 <fwp_segv.msg+0x163>
    5a91:	31 c0                	xor    %eax,%eax
    5a93:	e8 48 c7 ff ff       	call   21e0 <fprintf@plt>
    5a98:	bf 65 00 00 00       	mov    $0x65,%edi
    5a9d:	e8 2e c8 ff ff       	call   22d0 <exit@plt>
    5aa2:	e8 09 dd ff ff       	call   37b0 <fwp_flush>
    5aa7:	48 8b 05 32 95 00 00 	mov    0x9532(%rip),%rax        # efe0 <stderr@GLIBC_2.2.5>
    5aae:	48 8b 38             	mov    (%rax),%rdi
    5ab1:	48 8d 35 7c 68 00 00 	lea    0x687c(%rip),%rsi        # c334 <fwp_segv.msg+0xf4>
    5ab8:	48 8d 15 32 69 00 00 	lea    0x6932(%rip),%rdx        # c3f1 <fwp_segv.msg+0x1b1>
    5abf:	eb d0                	jmp    5a91 <fwp_gc_init+0x491>
    5ac1:	66 66 66 66 66 66 2e 	data16 data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    5ac8:	0f 1f 84 00 00 00 00 
    5acf:	00 

0000000000005ad0 <fwp_gc_alloc_big>:
    5ad0:	55                   	push   %rbp
    5ad1:	41 57                	push   %r15
    5ad3:	41 56                	push   %r14
    5ad5:	41 55                	push   %r13
    5ad7:	41 54                	push   %r12
    5ad9:	53                   	push   %rbx
    5ada:	50                   	push   %rax
    5adb:	48 b8 01 00 00 00 00 	movabs $0x4000000000000001,%rax
    5ae2:	00 00 40 
    5ae5:	48 39 c7             	cmp    %rax,%rdi
    5ae8:	0f 83 ce 01 00 00    	jae    5cbc <fwp_gc_alloc_big+0x1ec>
    5aee:	89 f5                	mov    %esi,%ebp
    5af0:	48 89 fb             	mov    %rdi,%rbx
    5af3:	48 29 3d ae 96 00 00 	sub    %rdi,0x96ae(%rip)        # f1a8 <fwp_gc>
    5afa:	0f 89 80 00 00 00    	jns    5b80 <fwp_gc_alloc_big+0xb0>
    5b00:	83 3d 8d a6 00 00 00 	cmpl   $0x0,0xa68d(%rip)        # 10194 <fwp_gc+0xfec>
    5b07:	75 05                	jne    5b0e <fwp_gc_alloc_big+0x3e>
    5b09:	e8 f2 fa ff ff       	call   5600 <fwp_gc_init>
    5b0e:	8b 0d 88 a6 00 00    	mov    0xa688(%rip),%ecx        # 1019c <fwp_gc+0xff4>
    5b14:	85 c9                	test   %ecx,%ecx
    5b16:	74 2a                	je     5b42 <fwp_gc_alloc_big+0x72>
    5b18:	48 8b 05 a9 a6 00 00 	mov    0xa6a9(%rip),%rax        # 101c8 <fwp_gc+0x1020>
    5b1f:	48 85 c0             	test   %rax,%rax
    5b22:	74 1e                	je     5b42 <fwp_gc_alloc_big+0x72>
    5b24:	48 8b 0d a5 a6 00 00 	mov    0xa6a5(%rip),%rcx        # 101d0 <fwp_gc+0x1028>
    5b2b:	48 ff c1             	inc    %rcx
    5b2e:	48 89 0d 9b a6 00 00 	mov    %rcx,0xa69b(%rip)        # 101d0 <fwp_gc+0x1028>
    5b35:	48 39 c1             	cmp    %rax,%rcx
    5b38:	0f 8d ad 01 00 00    	jge    5ceb <fwp_gc_alloc_big+0x21b>
    5b3e:	31 c0                	xor    %eax,%eax
    5b40:	eb 0d                	jmp    5b4f <fwp_gc_alloc_big+0x7f>
    5b42:	b8 00 00 80 00       	mov    $0x800000,%eax
    5b47:	85 c9                	test   %ecx,%ecx
    5b49:	0f 85 97 01 00 00    	jne    5ce6 <fwp_gc_alloc_big+0x216>
    5b4f:	48 8b 0d 62 a8 00 00 	mov    0xa862(%rip),%rcx        # 103b8 <fwp_gc+0x1210>
    5b56:	48 2b 0d 4b 96 00 00 	sub    0x964b(%rip),%rcx        # f1a8 <fwp_gc>
    5b5d:	f2 48 0f 2a c1       	cvtsi2sd %rcx,%xmm0
    5b62:	f2 0f 58 05 26 a8 00 	addsd  0xa826(%rip),%xmm0        # 10390 <fwp_gc+0x11e8>
    5b69:	00 
    5b6a:	f2 0f 11 05 1e a8 00 	movsd  %xmm0,0xa81e(%rip)        # 10390 <fwp_gc+0x11e8>
    5b71:	00 
    5b72:	48 89 05 3f a8 00 00 	mov    %rax,0xa83f(%rip)        # 103b8 <fwp_gc+0x1210>
    5b79:	48 89 05 28 96 00 00 	mov    %rax,0x9628(%rip)        # f1a8 <fwp_gc>
    5b80:	4c 8d b3 ff ff 00 00 	lea    0xffff(%rbx),%r14
    5b87:	49 c1 ee 10          	shr    $0x10,%r14
    5b8b:	4c 89 f7             	mov    %r14,%rdi
    5b8e:	e8 9d 02 00 00       	call   5e30 <fwp_gc_chunks>
    5b93:	48 8b 0d 86 a6 00 00 	mov    0xa686(%rip),%rcx        # 10220 <fwp_gc+0x1078>
    5b9a:	4c 69 e0 28 12 00 00 	imul   $0x1228,%rax,%r12
    5ba1:	42 c6 04 21 02       	movb   $0x2,(%rcx,%r12,1)
    5ba6:	42 88 6c 21 01       	mov    %bpl,0x1(%rcx,%r12,1)
    5bab:	66 42 c7 44 21 03 00 	movw   $0x100,0x3(%rcx,%r12,1)
    5bb2:	01 
    5bb3:	46 89 74 21 10       	mov    %r14d,0x10(%rcx,%r12,1)
    5bb8:	4a 89 5c 21 18       	mov    %rbx,0x18(%rcx,%r12,1)
    5bbd:	4e 8d 3c 21          	lea    (%rcx,%r12,1),%r15
    5bc1:	49 81 c7 28 02 00 00 	add    $0x228,%r15
    5bc8:	42 80 bc 21 28 02 00 	cmpb   $0xff,0x228(%rcx,%r12,1)
    5bcf:	00 ff 
    5bd1:	0f 84 d2 00 00 00    	je     5ca9 <fwp_gc_alloc_big+0x1d9>
    5bd7:	41 c6 07 00          	movb   $0x0,(%r15)
    5bdb:	48 81 fb 01 00 01 00 	cmp    $0x10001,%rbx
    5be2:	0f 82 9b 00 00 00    	jb     5c83 <fwp_gc_alloc_big+0x1b3>
    5be8:	49 83 fe 03          	cmp    $0x3,%r14
    5bec:	ba 02 00 00 00       	mov    $0x2,%edx
    5bf1:	49 0f 43 d6          	cmovae %r14,%rdx
    5bf5:	48 8b 0d 24 a6 00 00 	mov    0xa624(%rip),%rcx        # 10220 <fwp_gc+0x1078>
    5bfc:	48 ff ca             	dec    %rdx
    5bff:	be 01 00 00 00       	mov    $0x1,%esi
    5c04:	48 81 fb 01 00 02 00 	cmp    $0x20001,%rbx
    5c0b:	72 5a                	jb     5c67 <fwp_gc_alloc_big+0x197>
    5c0d:	49 8d 3c 0c          	lea    (%r12,%rcx,1),%rdi
    5c11:	48 81 c7 60 24 00 00 	add    $0x2460,%rdi
    5c18:	49 89 d0             	mov    %rdx,%r8
    5c1b:	49 83 e0 fe          	and    $0xfffffffffffffffe,%r8
    5c1f:	49 f7 d8             	neg    %r8
    5c22:	66 66 66 66 66 2e 0f 	data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    5c29:	1f 84 00 00 00 00 00 
    5c30:	c6 87 c8 ed ff ff 03 	movb   $0x3,-0x1238(%rdi)
    5c37:	c6 87 cc ed ff ff 01 	movb   $0x1,-0x1234(%rdi)
    5c3e:	89 87 d8 ed ff ff    	mov    %eax,-0x1228(%rdi)
    5c44:	c6 47 f0 03          	movb   $0x3,-0x10(%rdi)
    5c48:	c6 47 f4 01          	movb   $0x1,-0xc(%rdi)
    5c4c:	89 07                	mov    %eax,(%rdi)
    5c4e:	48 81 c7 50 24 00 00 	add    $0x2450,%rdi
    5c55:	4d 8d 0c 30          	lea    (%r8,%rsi,1),%r9
    5c59:	49 83 c1 02          	add    $0x2,%r9
    5c5d:	48 83 c6 02          	add    $0x2,%rsi
    5c61:	49 83 f9 01          	cmp    $0x1,%r9
    5c65:	75 c9                	jne    5c30 <fwp_gc_alloc_big+0x160>
    5c67:	f6 c2 01             	test   $0x1,%dl
    5c6a:	74 17                	je     5c83 <fwp_gc_alloc_big+0x1b3>
    5c6c:	4c 01 e1             	add    %r12,%rcx
    5c6f:	48 69 d6 28 12 00 00 	imul   $0x1228,%rsi,%rdx
    5c76:	c6 04 11 03          	movb   $0x3,(%rcx,%rdx,1)
    5c7a:	c6 44 11 04 01       	movb   $0x1,0x4(%rcx,%rdx,1)
    5c7f:	89 44 11 10          	mov    %eax,0x10(%rcx,%rdx,1)
    5c83:	48 c1 e0 10          	shl    $0x10,%rax
    5c87:	48 03 05 4a a5 00 00 	add    0xa54a(%rip),%rax        # 101d8 <fwp_gc+0x1030>
    5c8e:	48 89 c7             	mov    %rax,%rdi
    5c91:	31 f6                	xor    %esi,%esi
    5c93:	48 89 da             	mov    %rbx,%rdx
    5c96:	48 83 c4 08          	add    $0x8,%rsp
    5c9a:	5b                   	pop    %rbx
    5c9b:	41 5c                	pop    %r12
    5c9d:	41 5d                	pop    %r13
    5c9f:	41 5e                	pop    %r14
    5ca1:	41 5f                	pop    %r15
    5ca3:	5d                   	pop    %rbp
    5ca4:	e9 b7 c4 ff ff       	jmp    2160 <memset@plt>
    5ca9:	4c 89 ff             	mov    %r15,%rdi
    5cac:	49 89 c5             	mov    %rax,%r13
    5caf:	e8 2c db ff ff       	call   37e0 <fwp_rc_forget_slot>
    5cb4:	4c 89 e8             	mov    %r13,%rax
    5cb7:	e9 1b ff ff ff       	jmp    5bd7 <fwp_gc_alloc_big+0x107>
    5cbc:	48 8b 05 1d 93 00 00 	mov    0x931d(%rip),%rax        # efe0 <stderr@GLIBC_2.2.5>
    5cc3:	48 8b 08             	mov    (%rax),%rcx
    5cc6:	48 8d 3d 63 67 00 00 	lea    0x6763(%rip),%rdi        # c430 <fwp_segv.msg+0x1f0>
    5ccd:	be 13 00 00 00       	mov    $0x13,%esi
    5cd2:	ba 01 00 00 00       	mov    $0x1,%edx
    5cd7:	e8 04 c6 ff ff       	call   22e0 <fwrite@plt>
    5cdc:	bf 66 00 00 00       	mov    $0x66,%edi
    5ce1:	e8 ea c5 ff ff       	call   22d0 <exit@plt>
    5ce6:	e8 d5 02 00 00       	call   5fc0 <fwp_gc_collect>
    5ceb:	48 c7 05 da a4 00 00 	movq   $0x0,0xa4da(%rip)        # 101d0 <fwp_gc+0x1028>
    5cf2:	00 00 00 00 
    5cf6:	e8 c5 02 00 00       	call   5fc0 <fwp_gc_collect>
    5cfb:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)

0000000000005d00 <fwp_gc_refill>:
    5d00:	55                   	push   %rbp
    5d01:	41 57                	push   %r15
    5d03:	41 56                	push   %r14
    5d05:	41 55                	push   %r13
    5d07:	41 54                	push   %r12
    5d09:	53                   	push   %rbx
    5d0a:	50                   	push   %rax
    5d0b:	89 d5                	mov    %edx,%ebp
    5d0d:	41 89 f7             	mov    %esi,%r15d
    5d10:	48 89 fb             	mov    %rdi,%rbx
    5d13:	bf 01 00 00 00       	mov    $0x1,%edi
    5d18:	e8 13 01 00 00       	call   5e30 <fwp_gc_chunks>
    5d1d:	49 89 c6             	mov    %rax,%r14
    5d20:	4c 8b 25 f9 a4 00 00 	mov    0xa4f9(%rip),%r12        # 10220 <fwp_gc+0x1078>
    5d27:	48 8d 05 7a 94 00 00 	lea    0x947a(%rip),%rax        # f1a8 <fwp_gc>
    5d2e:	4d 69 ee 28 12 00 00 	imul   $0x1228,%r14,%r13
    5d35:	43 c6 04 2c 01       	movb   $0x1,(%r12,%r13,1)
    5d3a:	43 88 6c 2c 01       	mov    %bpl,0x1(%r12,%r13,1)
    5d3f:	47 88 7c 2c 02       	mov    %r15b,0x2(%r12,%r13,1)
    5d44:	43 c6 44 2c 04 01    	movb   $0x1,0x4(%r12,%r13,1)
    5d4a:	44 89 f9             	mov    %r15d,%ecx
    5d4d:	8b 8c 88 48 0b 00 00 	mov    0xb48(%rax,%rcx,4),%ecx
    5d54:	43 89 4c 2c 08       	mov    %ecx,0x8(%r12,%r13,1)
    5d59:	b8 00 00 01 00       	mov    $0x10000,%eax
    5d5e:	31 d2                	xor    %edx,%edx
    5d60:	f7 f1                	div    %ecx
    5d62:	43 89 44 2c 0c       	mov    %eax,0xc(%r12,%r13,1)
    5d67:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    5d6c:	48 01 c8             	add    %rcx,%rax
    5d6f:	48 0f ba e0 20       	bt     $0x20,%rax
    5d74:	73 07                	jae    5d7d <fwp_gc_refill+0x7d>
    5d76:	31 d2                	xor    %edx,%edx
    5d78:	48 f7 f1             	div    %rcx
    5d7b:	eb 04                	jmp    5d81 <fwp_gc_refill+0x81>
    5d7d:	31 d2                	xor    %edx,%edx
    5d7f:	f7 f1                	div    %ecx
    5d81:	43 89 44 2c 20       	mov    %eax,0x20(%r12,%r13,1)
    5d86:	48 83 3d 32 ae 00 00 	cmpq   $0x0,0xae32(%rip)        # 10bc0 <fwp_gc+0x1a18>
    5d8d:	00 
    5d8e:	74 2e                	je     5dbe <fwp_gc_refill+0xbe>
    5d90:	4f 8d 3c 2c          	lea    (%r12,%r13,1),%r15
    5d94:	49 81 c7 28 02 00 00 	add    $0x228,%r15
    5d9b:	31 ed                	xor    %ebp,%ebp
    5d9d:	eb 0d                	jmp    5dac <fwp_gc_refill+0xac>
    5d9f:	90                   	nop
    5da0:	48 ff c5             	inc    %rbp
    5da3:	48 81 fd 00 10 00 00 	cmp    $0x1000,%rbp
    5daa:	74 12                	je     5dbe <fwp_gc_refill+0xbe>
    5dac:	41 80 3c 2f ff       	cmpb   $0xff,(%r15,%rbp,1)
    5db1:	75 ed                	jne    5da0 <fwp_gc_refill+0xa0>
    5db3:	49 8d 3c 2f          	lea    (%r15,%rbp,1),%rdi
    5db7:	e8 24 da ff ff       	call   37e0 <fwp_rc_forget_slot>
    5dbc:	eb e2                	jmp    5da0 <fwp_gc_refill+0xa0>
    5dbe:	4f 8d 3c 2c          	lea    (%r12,%r13,1),%r15
    5dc2:	49 83 c7 08          	add    $0x8,%r15
    5dc6:	4b 8d 3c 2c          	lea    (%r12,%r13,1),%rdi
    5dca:	48 81 c7 28 02 00 00 	add    $0x228,%rdi
    5dd1:	ba 00 10 00 00       	mov    $0x1000,%edx
    5dd6:	31 f6                	xor    %esi,%esi
    5dd8:	e8 83 c3 ff ff       	call   2160 <memset@plt>
    5ddd:	49 c1 e6 10          	shl    $0x10,%r14
    5de1:	4c 03 35 f0 a3 00 00 	add    0xa3f0(%rip),%r14        # 101d8 <fwp_gc+0x1030>
    5de8:	83 3d bd a3 00 00 00 	cmpl   $0x0,0xa3bd(%rip)        # 101ac <fwp_gc+0x1004>
    5def:	74 0f                	je     5e00 <fwp_gc_refill+0x100>
    5df1:	ba 00 00 01 00       	mov    $0x10000,%edx
    5df6:	4c 89 f7             	mov    %r14,%rdi
    5df9:	31 f6                	xor    %esi,%esi
    5dfb:	e8 60 c3 ff ff       	call   2160 <memset@plt>
    5e00:	41 8b 07             	mov    (%r15),%eax
    5e03:	49 8d 0c 06          	lea    (%r14,%rax,1),%rcx
    5e07:	48 89 4b 08          	mov    %rcx,0x8(%rbx)
    5e0b:	41 8b 4f 04          	mov    0x4(%r15),%ecx
    5e0f:	48 0f af c8          	imul   %rax,%rcx
    5e13:	4c 01 f1             	add    %r14,%rcx
    5e16:	48 89 4b 10          	mov    %rcx,0x10(%rbx)
    5e1a:	4c 89 f0             	mov    %r14,%rax
    5e1d:	48 83 c4 08          	add    $0x8,%rsp
    5e21:	5b                   	pop    %rbx
    5e22:	41 5c                	pop    %r12
    5e24:	41 5d                	pop    %r13
    5e26:	41 5e                	pop    %r14
    5e28:	41 5f                	pop    %r15
    5e2a:	5d                   	pop    %rbp
    5e2b:	c3                   	ret
    5e2c:	0f 1f 40 00          	nopl   0x0(%rax)

0000000000005e30 <fwp_gc_chunks>:
    5e30:	41 57                	push   %r15
    5e32:	41 56                	push   %r14
    5e34:	53                   	push   %rbx
    5e35:	48 89 fb             	mov    %rdi,%rbx
    5e38:	31 d2                	xor    %edx,%edx
    5e3a:	48 83 ff 01          	cmp    $0x1,%rdi
    5e3e:	0f 95 c2             	setne  %dl
    5e41:	48 8d 0d 60 93 00 00 	lea    0x9360(%rip),%rcx        # f1a8 <fwp_gc>
    5e48:	48 8b 84 d1 68 10 00 	mov    0x1068(%rcx,%rdx,8),%rax
    5e4f:	00 
    5e50:	4c 8b 35 a9 a3 00 00 	mov    0xa3a9(%rip),%r14        # 10200 <fwp_gc+0x1058>
    5e57:	48 89 c7             	mov    %rax,%rdi
    5e5a:	4c 29 f7             	sub    %r14,%rdi
    5e5d:	73 63                	jae    5ec2 <fwp_gc_chunks+0x92>
    5e5f:	48 8d 34 d5 68 10 00 	lea    0x1068(,%rdx,8),%rsi
    5e66:	00 
    5e67:	4c 69 c0 28 12 00 00 	imul   $0x1228,%rax,%r8
    5e6e:	4c 03 05 ab a3 00 00 	add    0xa3ab(%rip),%r8        # 10220 <fwp_gc+0x1078>
    5e75:	31 d2                	xor    %edx,%edx
    5e77:	45 31 c9             	xor    %r9d,%r9d
    5e7a:	eb 16                	jmp    5e92 <fwp_gc_chunks+0x62>
    5e7c:	0f 1f 40 00          	nopl   0x0(%rax)
    5e80:	45 31 c9             	xor    %r9d,%r9d
    5e83:	48 ff ca             	dec    %rdx
    5e86:	49 81 c0 28 12 00 00 	add    $0x1228,%r8
    5e8d:	48 39 d7             	cmp    %rdx,%rdi
    5e90:	74 33                	je     5ec5 <fwp_gc_chunks+0x95>
    5e92:	41 80 38 00          	cmpb   $0x0,(%r8)
    5e96:	75 e8                	jne    5e80 <fwp_gc_chunks+0x50>
    5e98:	49 ff c1             	inc    %r9
    5e9b:	49 39 d9             	cmp    %rbx,%r9
    5e9e:	75 e3                	jne    5e83 <fwp_gc_chunks+0x53>
    5ea0:	48 ff c0             	inc    %rax
    5ea3:	48 89 c7             	mov    %rax,%rdi
    5ea6:	48 29 d7             	sub    %rdx,%rdi
    5ea9:	48 89 3c 0e          	mov    %rdi,(%rsi,%rcx,1)
    5ead:	48 29 1d d4 a4 00 00 	sub    %rbx,0xa4d4(%rip)        # 10388 <fwp_gc+0x11e0>
    5eb4:	48 29 d8             	sub    %rbx,%rax
    5eb7:	48 29 d0             	sub    %rdx,%rax
    5eba:	49 89 c6             	mov    %rax,%r14
    5ebd:	e9 ca 00 00 00       	jmp    5f8c <fwp_gc_chunks+0x15c>
    5ec2:	45 31 c9             	xor    %r9d,%r9d
    5ec5:	4c 29 0d bc a4 00 00 	sub    %r9,0xa4bc(%rip)        # 10388 <fwp_gc+0x11e0>
    5ecc:	4d 29 ce             	sub    %r9,%r14
    5ecf:	4c 01 f3             	add    %r14,%rbx
    5ed2:	48 8b 3d 2f a3 00 00 	mov    0xa32f(%rip),%rdi        # 10208 <fwp_gc+0x1060>
    5ed9:	48 39 df             	cmp    %rbx,%rdi
    5edc:	0f 83 8f 00 00 00    	jae    5f71 <fwp_gc_chunks+0x141>
    5ee2:	4c 8b 3d 0f a3 00 00 	mov    0xa30f(%rip),%r15        # 101f8 <fwp_gc+0x1050>
    5ee9:	49 39 df             	cmp    %rbx,%r15
    5eec:	0f 82 a3 00 00 00    	jb     5f95 <fwp_gc_chunks+0x165>
    5ef2:	48 8d 43 40          	lea    0x40(%rbx),%rax
    5ef6:	4c 39 f8             	cmp    %r15,%rax
    5ef9:	4c 0f 42 f8          	cmovb  %rax,%r15
    5efd:	4c 89 fe             	mov    %r15,%rsi
    5f00:	48 29 fe             	sub    %rdi,%rsi
    5f03:	48 c1 e7 10          	shl    $0x10,%rdi
    5f07:	48 03 3d ca a2 00 00 	add    0xa2ca(%rip),%rdi        # 101d8 <fwp_gc+0x1030>
    5f0e:	48 c1 e6 10          	shl    $0x10,%rsi
    5f12:	ba 03 00 00 00       	mov    $0x3,%edx
    5f17:	e8 64 c3 ff ff       	call   2280 <mprotect@plt>
    5f1c:	85 c0                	test   %eax,%eax
    5f1e:	75 75                	jne    5f95 <fwp_gc_chunks+0x165>
    5f20:	bf 1e 00 00 00       	mov    $0x1e,%edi
    5f25:	e8 76 c3 ff ff       	call   22a0 <sysconf@plt>
    5f2a:	48 8b 0d ef a2 00 00 	mov    0xa2ef(%rip),%rcx        # 10220 <fwp_gc+0x1078>
    5f31:	48 69 3d cc a2 00 00 	imul   $0x1228,0xa2cc(%rip),%rdi        # 10208 <fwp_gc+0x1060>
    5f38:	28 12 00 00 
    5f3c:	48 01 cf             	add    %rcx,%rdi
    5f3f:	49 69 d7 28 12 00 00 	imul   $0x1228,%r15,%rdx
    5f46:	48 01 ca             	add    %rcx,%rdx
    5f49:	48 8d 34 10          	lea    (%rax,%rdx,1),%rsi
    5f4d:	48 ff ce             	dec    %rsi
    5f50:	48 f7 d8             	neg    %rax
    5f53:	48 21 c7             	and    %rax,%rdi
    5f56:	48 21 c6             	and    %rax,%rsi
    5f59:	48 29 fe             	sub    %rdi,%rsi
    5f5c:	ba 03 00 00 00       	mov    $0x3,%edx
    5f61:	e8 1a c3 ff ff       	call   2280 <mprotect@plt>
    5f66:	85 c0                	test   %eax,%eax
    5f68:	75 2b                	jne    5f95 <fwp_gc_chunks+0x165>
    5f6a:	4c 89 3d 97 a2 00 00 	mov    %r15,0xa297(%rip)        # 10208 <fwp_gc+0x1060>
    5f71:	48 89 1d 88 a2 00 00 	mov    %rbx,0xa288(%rip)        # 10200 <fwp_gc+0x1058>
    5f78:	48 c1 e3 10          	shl    $0x10,%rbx
    5f7c:	48 3b 1d 6d a2 00 00 	cmp    0xa26d(%rip),%rbx        # 101f0 <fwp_gc+0x1048>
    5f83:	76 07                	jbe    5f8c <fwp_gc_chunks+0x15c>
    5f85:	48 89 1d 64 a2 00 00 	mov    %rbx,0xa264(%rip)        # 101f0 <fwp_gc+0x1048>
    5f8c:	4c 89 f0             	mov    %r14,%rax
    5f8f:	5b                   	pop    %rbx
    5f90:	41 5e                	pop    %r14
    5f92:	41 5f                	pop    %r15
    5f94:	c3                   	ret
    5f95:	48 8b 05 44 90 00 00 	mov    0x9044(%rip),%rax        # efe0 <stderr@GLIBC_2.2.5>
    5f9c:	48 8b 08             	mov    (%rax),%rcx
    5f9f:	48 8d 3d 8a 64 00 00 	lea    0x648a(%rip),%rdi        # c430 <fwp_segv.msg+0x1f0>
    5fa6:	be 13 00 00 00       	mov    $0x13,%esi
    5fab:	ba 01 00 00 00       	mov    $0x1,%edx
    5fb0:	e8 2b c3 ff ff       	call   22e0 <fwrite@plt>
    5fb5:	bf 66 00 00 00       	mov    $0x66,%edi
    5fba:	e8 11 c3 ff ff       	call   22d0 <exit@plt>
    5fbf:	90                   	nop

0000000000005fc0 <fwp_gc_collect>:
    5fc0:	50                   	push   %rax
    5fc1:	e8 ea d7 ff ff       	call   37b0 <fwp_flush>
    5fc6:	48 8b 05 13 90 00 00 	mov    0x9013(%rip),%rax        # efe0 <stderr@GLIBC_2.2.5>
    5fcd:	48 8b 38             	mov    (%rax),%rdi
    5fd0:	48 8d 35 5d 63 00 00 	lea    0x635d(%rip),%rsi        # c334 <fwp_segv.msg+0xf4>
    5fd7:	48 8d 15 66 64 00 00 	lea    0x6466(%rip),%rdx        # c444 <fwp_segv.msg+0x204>
    5fde:	31 c0                	xor    %eax,%eax
    5fe0:	e8 fb c1 ff ff       	call   21e0 <fprintf@plt>
    5fe5:	bf 65 00 00 00       	mov    $0x65,%edi
    5fea:	e8 e1 c2 ff ff       	call   22d0 <exit@plt>
    5fef:	90                   	nop

0000000000005ff0 <fwp_closure_drop>:
    5ff0:	41 57                	push   %r15
    5ff2:	41 56                	push   %r14
    5ff4:	53                   	push   %rbx
    5ff5:	48 81 ec 30 02 00 00 	sub    $0x230,%rsp
    5ffc:	48 89 f8             	mov    %rdi,%rax
    5fff:	48 2b 05 d2 a1 00 00 	sub    0xa1d2(%rip),%rax        # 101d8 <fwp_gc+0x1030>
    6006:	48 8b 0d f3 a1 00 00 	mov    0xa1f3(%rip),%rcx        # 10200 <fwp_gc+0x1058>
    600d:	48 c1 e1 10          	shl    $0x10,%rcx
    6011:	48 39 c8             	cmp    %rcx,%rax
    6014:	0f 83 91 00 00 00    	jae    60ab <fwp_closure_drop+0xbb>
    601a:	48 89 fe             	mov    %rdi,%rsi
    601d:	48 8b 0d fc a1 00 00 	mov    0xa1fc(%rip),%rcx        # 10220 <fwp_gc+0x1078>
    6024:	48 89 c2             	mov    %rax,%rdx
    6027:	48 c1 ea 10          	shr    $0x10,%rdx
    602b:	48 69 d2 28 12 00 00 	imul   $0x1228,%rdx,%rdx
    6032:	0f b6 3c 11          	movzbl (%rcx,%rdx,1),%edi
    6036:	48 25 ff ff 00 00    	and    $0xffff,%rax
    603c:	75 13                	jne    6051 <fwp_closure_drop+0x61>
    603e:	40 80 ff 02          	cmp    $0x2,%dil
    6042:	75 0d                	jne    6051 <fwp_closure_drop+0x61>
    6044:	48 8d 3c 11          	lea    (%rcx,%rdx,1),%rdi
    6048:	48 81 c7 28 02 00 00 	add    $0x228,%rdi
    604f:	eb 20                	jmp    6071 <fwp_closure_drop+0x81>
    6051:	40 80 ff 01          	cmp    $0x1,%dil
    6055:	75 54                	jne    60ab <fwp_closure_drop+0xbb>
    6057:	48 8d 3c 11          	lea    (%rcx,%rdx,1),%rdi
    605b:	8b 4c 11 20          	mov    0x20(%rcx,%rdx,1),%ecx
    605f:	48 0f af c1          	imul   %rcx,%rax
    6063:	48 c1 e8 20          	shr    $0x20,%rax
    6067:	48 01 c7             	add    %rax,%rdi
    606a:	48 81 c7 28 02 00 00 	add    $0x228,%rdi
    6071:	0f b6 07             	movzbl (%rdi),%eax
    6074:	85 c0                	test   %eax,%eax
    6076:	74 33                	je     60ab <fwp_closure_drop+0xbb>
    6078:	83 f8 01             	cmp    $0x1,%eax
    607b:	75 1f                	jne    609c <fwp_closure_drop+0xac>
    607d:	64 48 8b 3c 25 f8 ff 	mov    %fs:0xfffffffffffffff8,%rdi
    6084:	ff ff 
    6086:	48 85 ff             	test   %rdi,%rdi
    6089:	74 2d                	je     60b8 <fwp_closure_drop+0xc8>
    608b:	48 81 c4 30 02 00 00 	add    $0x230,%rsp
    6092:	5b                   	pop    %rbx
    6093:	41 5e                	pop    %r14
    6095:	41 5f                	pop    %r15
    6097:	e9 44 01 00 00       	jmp    61e0 <fwp_closure_drop_push>
    609c:	3d ff 00 00 00       	cmp    $0xff,%eax
    60a1:	0f 84 e7 00 00 00    	je     618e <fwp_closure_drop+0x19e>
    60a7:	fe c8                	dec    %al
    60a9:	88 07                	mov    %al,(%rdi)
    60ab:	48 81 c4 30 02 00 00 	add    $0x230,%rsp
    60b2:	5b                   	pop    %rbx
    60b3:	41 5e                	pop    %r14
    60b5:	41 5f                	pop    %r15
    60b7:	c3                   	ret
    60b8:	64 48 8b 04 25 00 00 	mov    %fs:0x0,%rax
    60bf:	00 00 
    60c1:	4c 8d b0 f8 ff ff ff 	lea    -0x8(%rax),%r14
    60c8:	48 8d 5c 24 30       	lea    0x30(%rsp),%rbx
    60cd:	48 89 5c 24 18       	mov    %rbx,0x18(%rsp)
    60d2:	48 c7 44 24 20 00 00 	movq   $0x0,0x20(%rsp)
    60d9:	00 00 
    60db:	48 c7 44 24 28 40 00 	movq   $0x40,0x28(%rsp)
    60e2:	00 00 
    60e4:	48 8b 05 7d ab 00 00 	mov    0xab7d(%rip),%rax        # 10c68 <fwp_cleanups>
    60eb:	48 89 04 24          	mov    %rax,(%rsp)
    60ef:	48 8d 05 ca 01 00 00 	lea    0x1ca(%rip),%rax        # 62c0 <fwp_closure_drop_release>
    60f6:	48 89 44 24 08       	mov    %rax,0x8(%rsp)
    60fb:	48 8d 7c 24 18       	lea    0x18(%rsp),%rdi
    6100:	48 89 7c 24 10       	mov    %rdi,0x10(%rsp)
    6105:	49 89 e7             	mov    %rsp,%r15
    6108:	4c 89 3d 59 ab 00 00 	mov    %r15,0xab59(%rip)        # 10c68 <fwp_cleanups>
    610f:	49 89 3e             	mov    %rdi,(%r14)
    6112:	e8 c9 00 00 00       	call   61e0 <fwp_closure_drop_push>
    6117:	66 0f 1f 84 00 00 00 	nopw   0x0(%rax,%rax,1)
    611e:	00 00 
    6120:	48 8b 44 24 20       	mov    0x20(%rsp),%rax
    6125:	48 85 c0             	test   %rax,%rax
    6128:	74 31                	je     615b <fwp_closure_drop+0x16b>
    612a:	48 8b 4c 24 18       	mov    0x18(%rsp),%rcx
    612f:	48 8d 50 ff          	lea    -0x1(%rax),%rdx
    6133:	48 89 54 24 20       	mov    %rdx,0x20(%rsp)
    6138:	48 8b 7c c1 f8       	mov    -0x8(%rcx,%rax,8),%rdi
    613d:	48 8b 05 fc aa 00 00 	mov    0xaafc(%rip),%rax        # 10c40 <fwp_fns>
    6144:	8b 0f                	mov    (%rdi),%ecx
    6146:	48 c1 e1 05          	shl    $0x5,%rcx
    614a:	48 8b 44 08 18       	mov    0x18(%rax,%rcx,1),%rax
    614f:	48 85 c0             	test   %rax,%rax
    6152:	74 4b                	je     619f <fwp_closure_drop+0x1af>
    6154:	31 f6                	xor    %esi,%esi
    6156:	ff 50 08             	call   *0x8(%rax)
    6159:	eb c5                	jmp    6120 <fwp_closure_drop+0x130>
    615b:	4c 39 3d 06 ab 00 00 	cmp    %r15,0xab06(%rip)        # 10c68 <fwp_cleanups>
    6162:	75 69                	jne    61cd <fwp_closure_drop+0x1dd>
    6164:	48 8b 04 24          	mov    (%rsp),%rax
    6168:	48 89 05 f9 aa 00 00 	mov    %rax,0xaaf9(%rip)        # 10c68 <fwp_cleanups>
    616f:	49 c7 06 00 00 00 00 	movq   $0x0,(%r14)
    6176:	48 8b 7c 24 18       	mov    0x18(%rsp),%rdi
    617b:	48 39 df             	cmp    %rbx,%rdi
    617e:	0f 84 27 ff ff ff    	je     60ab <fwp_closure_drop+0xbb>
    6184:	e8 c7 be ff ff       	call   2050 <free@plt>
    6189:	e9 1d ff ff ff       	jmp    60ab <fwp_closure_drop+0xbb>
    618e:	48 81 c4 30 02 00 00 	add    $0x230,%rsp
    6195:	5b                   	pop    %rbx
    6196:	41 5e                	pop    %r14
    6198:	41 5f                	pop    %r15
    619a:	e9 61 01 00 00       	jmp    6300 <fwp_rc_wide_drop>
    619f:	e8 0c d6 ff ff       	call   37b0 <fwp_flush>
    61a4:	48 8b 05 35 8e 00 00 	mov    0x8e35(%rip),%rax        # efe0 <stderr@GLIBC_2.2.5>
    61ab:	48 8b 38             	mov    (%rax),%rdi
    61ae:	48 8d 35 7f 61 00 00 	lea    0x617f(%rip),%rsi        # c334 <fwp_segv.msg+0xf4>
    61b5:	48 8d 15 b9 62 00 00 	lea    0x62b9(%rip),%rdx        # c475 <fwp_segv.msg+0x235>
    61bc:	31 c0                	xor    %eax,%eax
    61be:	e8 1d c0 ff ff       	call   21e0 <fprintf@plt>
    61c3:	bf 65 00 00 00       	mov    $0x65,%edi
    61c8:	e8 03 c1 ff ff       	call   22d0 <exit@plt>
    61cd:	e8 8e be ff ff       	call   2060 <abort@plt>
    61d2:	66 66 66 66 66 2e 0f 	data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    61d9:	1f 84 00 00 00 00 00 

00000000000061e0 <fwp_closure_drop_push>:
    61e0:	55                   	push   %rbp
    61e1:	41 57                	push   %r15
    61e3:	41 56                	push   %r14
    61e5:	41 55                	push   %r13
    61e7:	41 54                	push   %r12
    61e9:	53                   	push   %rbx
    61ea:	50                   	push   %rax
    61eb:	48 89 f3             	mov    %rsi,%rbx
    61ee:	49 89 fe             	mov    %rdi,%r14
    61f1:	4c 8b 6f 08          	mov    0x8(%rdi),%r13
    61f5:	4c 3b 6f 10          	cmp    0x10(%rdi),%r13
    61f9:	75 59                	jne    6254 <fwp_closure_drop_push+0x74>
    61fb:	4c 89 e8             	mov    %r13,%rax
    61fe:	48 c1 e8 3c          	shr    $0x3c,%rax
    6202:	75 6e                	jne    6272 <fwp_closure_drop_push+0x92>
    6204:	4c 89 ef             	mov    %r13,%rdi
    6207:	48 c1 e7 04          	shl    $0x4,%rdi
    620b:	e8 10 c0 ff ff       	call   2220 <malloc@plt>
    6210:	48 85 c0             	test   %rax,%rax
    6213:	74 7c                	je     6291 <fwp_closure_drop_push+0xb1>
    6215:	49 89 c7             	mov    %rax,%r15
    6218:	4a 8d 2c 6d 00 00 00 	lea    0x0(,%r13,2),%rbp
    621f:	00 
    6220:	4d 8b 26             	mov    (%r14),%r12
    6223:	4a 8d 14 ed 00 00 00 	lea    0x0(,%r13,8),%rdx
    622a:	00 
    622b:	48 89 c7             	mov    %rax,%rdi
    622e:	4c 89 e6             	mov    %r12,%rsi
    6231:	e8 da bf ff ff       	call   2210 <memcpy@plt>
    6236:	49 8d 46 18          	lea    0x18(%r14),%rax
    623a:	49 39 c4             	cmp    %rax,%r12
    623d:	74 0c                	je     624b <fwp_closure_drop_push+0x6b>
    623f:	4c 89 e7             	mov    %r12,%rdi
    6242:	e8 09 be ff ff       	call   2050 <free@plt>
    6247:	4d 8b 6e 08          	mov    0x8(%r14),%r13
    624b:	4d 89 3e             	mov    %r15,(%r14)
    624e:	49 89 6e 10          	mov    %rbp,0x10(%r14)
    6252:	eb 03                	jmp    6257 <fwp_closure_drop_push+0x77>
    6254:	4d 8b 3e             	mov    (%r14),%r15
    6257:	49 8d 45 01          	lea    0x1(%r13),%rax
    625b:	49 89 46 08          	mov    %rax,0x8(%r14)
    625f:	4b 89 1c ef          	mov    %rbx,(%r15,%r13,8)
    6263:	48 83 c4 08          	add    $0x8,%rsp
    6267:	5b                   	pop    %rbx
    6268:	41 5c                	pop    %r12
    626a:	41 5d                	pop    %r13
    626c:	41 5e                	pop    %r14
    626e:	41 5f                	pop    %r15
    6270:	5d                   	pop    %rbp
    6271:	c3                   	ret
    6272:	e8 39 d5 ff ff       	call   37b0 <fwp_flush>
    6277:	48 8b 05 62 8d 00 00 	mov    0x8d62(%rip),%rax        # efe0 <stderr@GLIBC_2.2.5>
    627e:	48 8b 38             	mov    (%rax),%rdi
    6281:	48 8d 35 ac 60 00 00 	lea    0x60ac(%rip),%rsi        # c334 <fwp_segv.msg+0xf4>
    6288:	48 8d 15 14 62 00 00 	lea    0x6214(%rip),%rdx        # c4a3 <fwp_segv.msg+0x263>
    628f:	eb 1d                	jmp    62ae <fwp_closure_drop_push+0xce>
    6291:	e8 1a d5 ff ff       	call   37b0 <fwp_flush>
    6296:	48 8b 05 43 8d 00 00 	mov    0x8d43(%rip),%rax        # efe0 <stderr@GLIBC_2.2.5>
    629d:	48 8b 38             	mov    (%rax),%rdi
    62a0:	48 8d 35 8d 60 00 00 	lea    0x608d(%rip),%rsi        # c334 <fwp_segv.msg+0xf4>
    62a7:	48 8d 15 0f 62 00 00 	lea    0x620f(%rip),%rdx        # c4bd <fwp_segv.msg+0x27d>
    62ae:	31 c0                	xor    %eax,%eax
    62b0:	e8 2b bf ff ff       	call   21e0 <fprintf@plt>
    62b5:	bf 65 00 00 00       	mov    $0x65,%edi
    62ba:	e8 11 c0 ff ff       	call   22d0 <exit@plt>
    62bf:	90                   	nop

00000000000062c0 <fwp_closure_drop_release>:
    62c0:	41 56                	push   %r14
    62c2:	53                   	push   %rbx
    62c3:	50                   	push   %rax
    62c4:	48 89 fb             	mov    %rdi,%rbx
    62c7:	64 48 c7 04 25 f8 ff 	movq   $0x0,%fs:0xfffffffffffffff8
    62ce:	ff ff 00 00 00 00 
    62d4:	48 8b 3f             	mov    (%rdi),%rdi
    62d7:	4c 8d 73 18          	lea    0x18(%rbx),%r14
    62db:	4c 39 f7             	cmp    %r14,%rdi
    62de:	74 05                	je     62e5 <fwp_closure_drop_release+0x25>
    62e0:	e8 6b bd ff ff       	call   2050 <free@plt>
    62e5:	4c 89 33             	mov    %r14,(%rbx)
    62e8:	48 c7 43 08 00 00 00 	movq   $0x0,0x8(%rbx)
    62ef:	00 
    62f0:	48 83 c4 08          	add    $0x8,%rsp
    62f4:	5b                   	pop    %rbx
    62f5:	41 5e                	pop    %r14
    62f7:	c3                   	ret
    62f8:	0f 1f 84 00 00 00 00 	nopl   0x0(%rax,%rax,1)
    62ff:	00 

0000000000006300 <fwp_rc_wide_drop>:
    6300:	53                   	push   %rbx
    6301:	48 89 f8             	mov    %rdi,%rax
    6304:	48 c1 e8 11          	shr    $0x11,%rax
    6308:	31 f8                	xor    %edi,%eax
    630a:	89 c1                	mov    %eax,%ecx
    630c:	c1 e9 09             	shr    $0x9,%ecx
    630f:	31 c1                	xor    %eax,%ecx
    6311:	0f b6 c1             	movzbl %cl,%eax
    6314:	48 8d 0d 8d 8e 00 00 	lea    0x8e8d(%rip),%rcx        # f1a8 <fwp_gc>
    631b:	48 8b 84 c1 18 12 00 	mov    0x1218(%rcx,%rax,8),%rax
    6322:	00 
    6323:	48 85 c0             	test   %rax,%rax
    6326:	74 16                	je     633e <fwp_rc_wide_drop+0x3e>
    6328:	0f 1f 84 00 00 00 00 	nopl   0x0(%rax,%rax,1)
    632f:	00 
    6330:	48 39 38             	cmp    %rdi,(%rax)
    6333:	74 37                	je     636c <fwp_rc_wide_drop+0x6c>
    6335:	48 8b 40 10          	mov    0x10(%rax),%rax
    6339:	48 85 c0             	test   %rax,%rax
    633c:	75 f2                	jne    6330 <fwp_rc_wide_drop+0x30>
    633e:	e8 6d d4 ff ff       	call   37b0 <fwp_flush>
    6343:	48 8b 05 96 8c 00 00 	mov    0x8c96(%rip),%rax        # efe0 <stderr@GLIBC_2.2.5>
    634a:	48 8b 38             	mov    (%rax),%rdi
    634d:	48 8d 35 e0 5f 00 00 	lea    0x5fe0(%rip),%rsi        # c334 <fwp_segv.msg+0xf4>
    6354:	48 8d 15 e8 5f 00 00 	lea    0x5fe8(%rip),%rdx        # c343 <fwp_segv.msg+0x103>
    635b:	31 c0                	xor    %eax,%eax
    635d:	e8 7e be ff ff       	call   21e0 <fprintf@plt>
    6362:	bf 65 00 00 00       	mov    $0x65,%edi
    6367:	e8 64 bf ff ff       	call   22d0 <exit@plt>
    636c:	48 8b 48 08          	mov    0x8(%rax),%rcx
    6370:	48 ff c9             	dec    %rcx
    6373:	48 89 48 08          	mov    %rcx,0x8(%rax)
    6377:	48 81 f9 fe 00 00 00 	cmp    $0xfe,%rcx
    637e:	75 0b                	jne    638b <fwp_rc_wide_drop+0x8b>
    6380:	48 89 fb             	mov    %rdi,%rbx
    6383:	e8 58 d4 ff ff       	call   37e0 <fwp_rc_forget_slot>
    6388:	c6 03 fe             	movb   $0xfe,(%rbx)
    638b:	5b                   	pop    %rbx
    638c:	c3                   	ret
    638d:	0f 1f 00             	nopl   (%rax)

0000000000006390 <fwp_rc_wide_dup>:
    6390:	41 56                	push   %r14
    6392:	53                   	push   %rbx
    6393:	50                   	push   %rax
    6394:	48 89 fb             	mov    %rdi,%rbx
    6397:	48 89 f8             	mov    %rdi,%rax
    639a:	48 c1 e8 11          	shr    $0x11,%rax
    639e:	31 d8                	xor    %ebx,%eax
    63a0:	89 c1                	mov    %eax,%ecx
    63a2:	c1 e9 09             	shr    $0x9,%ecx
    63a5:	31 c1                	xor    %eax,%ecx
    63a7:	0f b6 c1             	movzbl %cl,%eax
    63aa:	48 8d 0d f7 8d 00 00 	lea    0x8df7(%rip),%rcx        # f1a8 <fwp_gc>
    63b1:	4c 8d 34 c1          	lea    (%rcx,%rax,8),%r14
    63b5:	49 81 c6 18 12 00 00 	add    $0x1218,%r14
    63bc:	48 8b 84 c1 18 12 00 	mov    0x1218(%rcx,%rax,8),%rax
    63c3:	00 
    63c4:	48 85 c0             	test   %rax,%rax
    63c7:	74 1a                	je     63e3 <fwp_rc_wide_dup+0x53>
    63c9:	48 39 18             	cmp    %rbx,(%rax)
    63cc:	74 22                	je     63f0 <fwp_rc_wide_dup+0x60>
    63ce:	66 90                	xchg   %ax,%ax
    63d0:	49 89 c6             	mov    %rax,%r14
    63d3:	48 8b 40 10          	mov    0x10(%rax),%rax
    63d7:	48 85 c0             	test   %rax,%rax
    63da:	74 0e                	je     63ea <fwp_rc_wide_dup+0x5a>
    63dc:	48 39 18             	cmp    %rbx,(%rax)
    63df:	75 ef                	jne    63d0 <fwp_rc_wide_dup+0x40>
    63e1:	eb 09                	jmp    63ec <fwp_rc_wide_dup+0x5c>
    63e3:	80 3b fe             	cmpb   $0xfe,(%rbx)
    63e6:	74 16                	je     63fe <fwp_rc_wide_dup+0x6e>
    63e8:	eb 6d                	jmp    6457 <fwp_rc_wide_dup+0xc7>
    63ea:	31 c0                	xor    %eax,%eax
    63ec:	49 83 c6 10          	add    $0x10,%r14
    63f0:	80 3b fe             	cmpb   $0xfe,(%rbx)
    63f3:	75 41                	jne    6436 <fwp_rc_wide_dup+0xa6>
    63f5:	48 85 c0             	test   %rax,%rax
    63f8:	0f 85 a2 00 00 00    	jne    64a0 <fwp_rc_wide_dup+0x110>
    63fe:	bf 18 00 00 00       	mov    $0x18,%edi
    6403:	e8 18 be ff ff       	call   2220 <malloc@plt>
    6408:	48 85 c0             	test   %rax,%rax
    640b:	74 69                	je     6476 <fwp_rc_wide_dup+0xe6>
    640d:	48 89 18             	mov    %rbx,(%rax)
    6410:	48 c7 40 08 ff 00 00 	movq   $0xff,0x8(%rax)
    6417:	00 
    6418:	48 c7 40 10 00 00 00 	movq   $0x0,0x10(%rax)
    641f:	00 
    6420:	49 89 06             	mov    %rax,(%r14)
    6423:	c6 03 ff             	movb   $0xff,(%rbx)
    6426:	48 8d 05 93 a7 00 00 	lea    0xa793(%rip),%rax        # 10bc0 <fwp_gc+0x1a18>
    642d:	48 8b 0d 8c a7 00 00 	mov    0xa78c(%rip),%rcx        # 10bc0 <fwp_gc+0x1a18>
    6434:	eb 13                	jmp    6449 <fwp_rc_wide_dup+0xb9>
    6436:	48 85 c0             	test   %rax,%rax
    6439:	74 1c                	je     6457 <fwp_rc_wide_dup+0xc7>
    643b:	48 8b 48 08          	mov    0x8(%rax),%rcx
    643f:	48 83 f9 ff          	cmp    $0xffffffffffffffff,%rcx
    6443:	74 7a                	je     64bf <fwp_rc_wide_dup+0x12f>
    6445:	48 83 c0 08          	add    $0x8,%rax
    6449:	48 ff c1             	inc    %rcx
    644c:	48 89 08             	mov    %rcx,(%rax)
    644f:	48 83 c4 08          	add    $0x8,%rsp
    6453:	5b                   	pop    %rbx
    6454:	41 5e                	pop    %r14
    6456:	c3                   	ret
    6457:	e8 54 d3 ff ff       	call   37b0 <fwp_flush>
    645c:	48 8b 05 7d 8b 00 00 	mov    0x8b7d(%rip),%rax        # efe0 <stderr@GLIBC_2.2.5>
    6463:	48 8b 38             	mov    (%rax),%rdi
    6466:	48 8d 35 c7 5e 00 00 	lea    0x5ec7(%rip),%rsi        # c334 <fwp_segv.msg+0xf4>
    646d:	48 8d 15 cf 5e 00 00 	lea    0x5ecf(%rip),%rdx        # c343 <fwp_segv.msg+0x103>
    6474:	eb 66                	jmp    64dc <fwp_rc_wide_dup+0x14c>
    6476:	48 8b 05 63 8b 00 00 	mov    0x8b63(%rip),%rax        # efe0 <stderr@GLIBC_2.2.5>
    647d:	48 8b 08             	mov    (%rax),%rcx
    6480:	48 8d 3d a9 5f 00 00 	lea    0x5fa9(%rip),%rdi        # c430 <fwp_segv.msg+0x1f0>
    6487:	be 13 00 00 00       	mov    $0x13,%esi
    648c:	ba 01 00 00 00       	mov    $0x1,%edx
    6491:	e8 4a be ff ff       	call   22e0 <fwrite@plt>
    6496:	bf 66 00 00 00       	mov    $0x66,%edi
    649b:	e8 30 be ff ff       	call   22d0 <exit@plt>
    64a0:	e8 0b d3 ff ff       	call   37b0 <fwp_flush>
    64a5:	48 8b 05 34 8b 00 00 	mov    0x8b34(%rip),%rax        # efe0 <stderr@GLIBC_2.2.5>
    64ac:	48 8b 38             	mov    (%rax),%rdi
    64af:	48 8d 35 7e 5e 00 00 	lea    0x5e7e(%rip),%rsi        # c334 <fwp_segv.msg+0xf4>
    64b6:	48 8d 15 0e 60 00 00 	lea    0x600e(%rip),%rdx        # c4cb <fwp_segv.msg+0x28b>
    64bd:	eb 1d                	jmp    64dc <fwp_rc_wide_dup+0x14c>
    64bf:	e8 ec d2 ff ff       	call   37b0 <fwp_flush>
    64c4:	48 8b 05 15 8b 00 00 	mov    0x8b15(%rip),%rax        # efe0 <stderr@GLIBC_2.2.5>
    64cb:	48 8b 38             	mov    (%rax),%rdi
    64ce:	48 8d 35 5f 5e 00 00 	lea    0x5e5f(%rip),%rsi        # c334 <fwp_segv.msg+0xf4>
    64d5:	48 8d 15 14 60 00 00 	lea    0x6014(%rip),%rdx        # c4f0 <fwp_segv.msg+0x2b0>
    64dc:	31 c0                	xor    %eax,%eax
    64de:	e8 fd bc ff ff       	call   21e0 <fprintf@plt>
    64e3:	bf 65 00 00 00       	mov    $0x65,%edi
    64e8:	e8 e3 bd ff ff       	call   22d0 <exit@plt>
    64ed:	0f 1f 00             	nopl   (%rax)

00000000000064f0 <fwp_rc_cleanup_cell>:
    64f0:	48 89 f8             	mov    %rdi,%rax
    64f3:	48 8b 3f             	mov    (%rdi),%rdi
    64f6:	48 c7 00 00 00 00 00 	movq   $0x0,(%rax)
    64fd:	48 85 ff             	test   %rdi,%rdi
    6500:	75 0e                	jne    6510 <fwp_rc_free_obj>
    6502:	c3                   	ret
    6503:	66 66 66 66 2e 0f 1f 	data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    650a:	84 00 00 00 00 00 

0000000000006510 <fwp_rc_free_obj>:
    6510:	48 89 f8             	mov    %rdi,%rax
    6513:	48 2b 05 be 9c 00 00 	sub    0x9cbe(%rip),%rax        # 101d8 <fwp_gc+0x1030>
    651a:	48 8b 0d df 9c 00 00 	mov    0x9cdf(%rip),%rcx        # 10200 <fwp_gc+0x1058>
    6521:	48 c1 e1 10          	shl    $0x10,%rcx
    6525:	48 39 c8             	cmp    %rcx,%rax
    6528:	0f 83 b8 01 00 00    	jae    66e6 <fwp_rc_free_obj+0x1d6>
    652e:	55                   	push   %rbp
    652f:	41 57                	push   %r15
    6531:	41 56                	push   %r14
    6533:	53                   	push   %rbx
    6534:	50                   	push   %rax
    6535:	48 8b 1d e4 9c 00 00 	mov    0x9ce4(%rip),%rbx        # 10220 <fwp_gc+0x1078>
    653c:	48 89 c1             	mov    %rax,%rcx
    653f:	48 c1 e9 10          	shr    $0x10,%rcx
    6543:	4c 69 f1 28 12 00 00 	imul   $0x1228,%rcx,%r14
    654a:	42 0f b6 2c 33       	movzbl (%rbx,%r14,1),%ebp
    654f:	48 25 ff ff 00 00    	and    $0xffff,%rax
    6555:	75 1a                	jne    6571 <fwp_rc_free_obj+0x61>
    6557:	40 80 fd 02          	cmp    $0x2,%bpl
    655b:	75 14                	jne    6571 <fwp_rc_free_obj+0x61>
    655d:	4a 8d 04 33          	lea    (%rbx,%r14,1),%rax
    6561:	48 05 28 02 00 00    	add    $0x228,%rax
    6567:	80 38 01             	cmpb   $0x1,(%rax)
    656a:	74 32                	je     659e <fwp_rc_free_obj+0x8e>
    656c:	e9 6b 01 00 00       	jmp    66dc <fwp_rc_free_obj+0x1cc>
    6571:	40 80 fd 01          	cmp    $0x1,%bpl
    6575:	0f 85 61 01 00 00    	jne    66dc <fwp_rc_free_obj+0x1cc>
    657b:	4a 8d 0c 33          	lea    (%rbx,%r14,1),%rcx
    657f:	42 8b 54 33 20       	mov    0x20(%rbx,%r14,1),%edx
    6584:	48 0f af c2          	imul   %rdx,%rax
    6588:	48 c1 e8 20          	shr    $0x20,%rax
    658c:	48 01 c8             	add    %rcx,%rax
    658f:	48 05 28 02 00 00    	add    $0x228,%rax
    6595:	80 38 01             	cmpb   $0x1,(%rax)
    6598:	0f 85 3e 01 00 00    	jne    66dc <fwp_rc_free_obj+0x1cc>
    659e:	8b 0d 24 a6 00 00    	mov    0xa624(%rip),%ecx        # 10bc8 <fwp_reuse_verify>
    65a4:	85 c9                	test   %ecx,%ecx
    65a6:	0f 88 c3 00 00 00    	js     666f <fwp_rc_free_obj+0x15f>
    65ac:	85 c9                	test   %ecx,%ecx
    65ae:	0f 84 fd 00 00 00    	je     66b1 <fwp_rc_free_obj+0x1a1>
    65b4:	42 80 7c 33 01 01    	cmpb   $0x1,0x1(%rbx,%r14,1)
    65ba:	75 0d                	jne    65c9 <fwp_rc_free_obj+0xb9>
    65bc:	40 80 fd 02          	cmp    $0x2,%bpl
    65c0:	75 22                	jne    65e4 <fwp_rc_free_obj+0xd4>
    65c2:	4a 8b 54 33 18       	mov    0x18(%rbx,%r14,1),%rdx
    65c7:	eb 20                	jmp    65e9 <fwp_rc_free_obj+0xd9>
    65c9:	c7 07 ad de 00 00    	movl   $0xdead,(%rdi)
    65cf:	8b 47 04             	mov    0x4(%rdi),%eax
    65d2:	48 85 c0             	test   %rax,%rax
    65d5:	0f 84 01 01 00 00    	je     66dc <fwp_rc_free_obj+0x1cc>
    65db:	83 f8 04             	cmp    $0x4,%eax
    65de:	73 26                	jae    6606 <fwp_rc_free_obj+0xf6>
    65e0:	31 c9                	xor    %ecx,%ecx
    65e2:	eb 6a                	jmp    664e <fwp_rc_free_obj+0x13e>
    65e4:	42 8b 54 33 08       	mov    0x8(%rbx,%r14,1),%edx
    65e9:	48 89 fb             	mov    %rdi,%rbx
    65ec:	be dd 00 00 00       	mov    $0xdd,%esi
    65f1:	e8 6a bb ff ff       	call   2160 <memset@plt>
    65f6:	48 c7 03 00 00 00 00 	movq   $0x0,(%rbx)
    65fd:	c6 43 08 00          	movb   $0x0,0x8(%rbx)
    6601:	e9 d6 00 00 00       	jmp    66dc <fwp_rc_free_obj+0x1cc>
    6606:	89 c1                	mov    %eax,%ecx
    6608:	83 e1 fc             	and    $0xfffffffc,%ecx
    660b:	48 8d 14 c5 00 00 00 	lea    0x0(,%rax,8),%rdx
    6612:	00 
    6613:	48 83 e2 e0          	and    $0xffffffffffffffe0,%rdx
    6617:	31 f6                	xor    %esi,%esi
    6619:	66 0f 28 05 8f 5a 00 	movapd 0x5a8f(%rip),%xmm0        # c0b0 <_IO_stdin_used+0xb0>
    6620:	00 
    6621:	66 66 66 66 66 66 2e 	data16 data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    6628:	0f 1f 84 00 00 00 00 
    662f:	00 
    6630:	66 0f 11 44 37 08    	movupd %xmm0,0x8(%rdi,%rsi,1)
    6636:	66 0f 11 44 37 18    	movupd %xmm0,0x18(%rdi,%rsi,1)
    663c:	48 83 c6 20          	add    $0x20,%rsi
    6640:	48 39 f2             	cmp    %rsi,%rdx
    6643:	75 eb                	jne    6630 <fwp_rc_free_obj+0x120>
    6645:	48 39 c1             	cmp    %rax,%rcx
    6648:	0f 84 8e 00 00 00    	je     66dc <fwp_rc_free_obj+0x1cc>
    664e:	48 ba ef be ad de ef 	movabs $0xdeadbeefdeadbeef,%rdx
    6655:	be ad de 
    6658:	0f 1f 84 00 00 00 00 	nopl   0x0(%rax,%rax,1)
    665f:	00 
    6660:	48 89 54 cf 08       	mov    %rdx,0x8(%rdi,%rcx,8)
    6665:	48 ff c1             	inc    %rcx
    6668:	48 39 c8             	cmp    %rcx,%rax
    666b:	75 f3                	jne    6660 <fwp_rc_free_obj+0x150>
    666d:	eb 6d                	jmp    66dc <fwp_rc_free_obj+0x1cc>
    666f:	49 89 ff             	mov    %rdi,%r15
    6672:	48 8d 3d 67 5d 00 00 	lea    0x5d67(%rip),%rdi        # c3e0 <fwp_segv.msg+0x1a0>
    6679:	e8 b2 b9 ff ff       	call   2030 <getenv@plt>
    667e:	31 c9                	xor    %ecx,%ecx
    6680:	48 85 c0             	test   %rax,%rax
    6683:	74 1b                	je     66a0 <fwp_rc_free_obj+0x190>
    6685:	80 38 00             	cmpb   $0x0,(%rax)
    6688:	74 16                	je     66a0 <fwp_rc_free_obj+0x190>
    668a:	48 8d 35 1e 5f 00 00 	lea    0x5f1e(%rip),%rsi        # c5af <fwp_segv.msg+0x36f>
    6691:	48 89 c7             	mov    %rax,%rdi
    6694:	e8 27 bb ff ff       	call   21c0 <strcmp@plt>
    6699:	31 c9                	xor    %ecx,%ecx
    669b:	85 c0                	test   %eax,%eax
    669d:	0f 95 c1             	setne  %cl
    66a0:	89 0d 22 a5 00 00    	mov    %ecx,0xa522(%rip)        # 10bc8 <fwp_reuse_verify>
    66a6:	4c 89 ff             	mov    %r15,%rdi
    66a9:	85 c9                	test   %ecx,%ecx
    66ab:	0f 85 03 ff ff ff    	jne    65b4 <fwp_rc_free_obj+0xa4>
    66b1:	48 8b 1d f0 8a 00 00 	mov    0x8af0(%rip),%rbx        # f1a8 <fwp_gc>
    66b8:	e8 33 00 00 00       	call   66f0 <fwp_mem_free>
    66bd:	48 8b 05 e4 8a 00 00 	mov    0x8ae4(%rip),%rax        # f1a8 <fwp_gc>
    66c4:	48 29 d8             	sub    %rbx,%rax
    66c7:	f2 48 0f 2a c0       	cvtsi2sd %rax,%xmm0
    66cc:	f2 0f 58 05 dc 9c 00 	addsd  0x9cdc(%rip),%xmm0        # 103b0 <fwp_gc+0x1208>
    66d3:	00 
    66d4:	f2 0f 11 05 d4 9c 00 	movsd  %xmm0,0x9cd4(%rip)        # 103b0 <fwp_gc+0x1208>
    66db:	00 
    66dc:	48 83 c4 08          	add    $0x8,%rsp
    66e0:	5b                   	pop    %rbx
    66e1:	41 5e                	pop    %r14
    66e3:	41 5f                	pop    %r15
    66e5:	5d                   	pop    %rbp
    66e6:	c3                   	ret
    66e7:	66 0f 1f 84 00 00 00 	nopw   0x0(%rax,%rax,1)
    66ee:	00 00 

00000000000066f0 <fwp_mem_free>:
    66f0:	48 85 ff             	test   %rdi,%rdi
    66f3:	0f 84 17 02 00 00    	je     6910 <fwp_mem_free+0x220>
    66f9:	48 8b 05 d8 9a 00 00 	mov    0x9ad8(%rip),%rax        # 101d8 <fwp_gc+0x1030>
    6700:	48 89 f9             	mov    %rdi,%rcx
    6703:	48 29 c1             	sub    %rax,%rcx
    6706:	48 8b 15 f3 9a 00 00 	mov    0x9af3(%rip),%rdx        # 10200 <fwp_gc+0x1058>
    670d:	48 c1 e2 10          	shl    $0x10,%rdx
    6711:	48 39 d1             	cmp    %rdx,%rcx
    6714:	0f 83 f6 01 00 00    	jae    6910 <fwp_mem_free+0x220>
    671a:	41 57                	push   %r15
    671c:	41 56                	push   %r14
    671e:	41 55                	push   %r13
    6720:	41 54                	push   %r12
    6722:	53                   	push   %rbx
    6723:	4c 8b 25 f6 9a 00 00 	mov    0x9af6(%rip),%r12        # 10220 <fwp_gc+0x1078>
    672a:	4d 85 e4             	test   %r12,%r12
    672d:	0f 84 d4 01 00 00    	je     6907 <fwp_mem_free+0x217>
    6733:	49 89 cf             	mov    %rcx,%r15
    6736:	49 c1 ef 10          	shr    $0x10,%r15
    673a:	4d 69 f7 28 12 00 00 	imul   $0x1228,%r15,%r14
    6741:	43 0f b6 14 34       	movzbl (%r12,%r14,1),%edx
    6746:	83 fa 02             	cmp    $0x2,%edx
    6749:	0f 84 b9 00 00 00    	je     6808 <fwp_mem_free+0x118>
    674f:	83 fa 01             	cmp    $0x1,%edx
    6752:	0f 85 af 01 00 00    	jne    6907 <fwp_mem_free+0x217>
    6758:	47 0f b6 4c 34 01    	movzbl 0x1(%r12,%r14,1),%r9d
    675e:	47 0f b6 44 34 02    	movzbl 0x2(%r12,%r14,1),%r8d
    6764:	43 8b 74 34 08       	mov    0x8(%r12,%r14,1),%esi
    6769:	0f b7 c7             	movzwl %di,%eax
    676c:	31 d2                	xor    %edx,%edx
    676e:	f7 f6                	div    %esi
    6770:	48 c7 c2 fe ff ff ff 	mov    $0xfffffffffffffffe,%rdx
    6777:	89 c1                	mov    %eax,%ecx
    6779:	48 d3 c2             	rol    %cl,%rdx
    677c:	4b 8d 0c 34          	lea    (%r12,%r14,1),%rcx
    6780:	41 89 c2             	mov    %eax,%r10d
    6783:	41 c1 ea 03          	shr    $0x3,%r10d
    6787:	41 81 e2 f8 1f 00 00 	and    $0x1ff8,%r10d
    678e:	49 21 54 0a 28       	and    %rdx,0x28(%r10,%rcx,1)
    6793:	49 69 d1 c0 03 00 00 	imul   $0x3c0,%r9,%rdx
    679a:	4c 8d 3d 07 8a 00 00 	lea    0x8a07(%rip),%r15        # f1a8 <fwp_gc>
    67a1:	49 01 d7             	add    %rdx,%r15
    67a4:	4f 8d 2c 40          	lea    (%r8,%r8,2),%r13
    67a8:	4d 01 e6             	add    %r12,%r14
    67ab:	49 83 c6 08          	add    $0x8,%r14
    67af:	48 8d 1c 08          	lea    (%rax,%rcx,1),%rbx
    67b3:	48 81 c3 28 02 00 00 	add    $0x228,%rbx
    67ba:	80 bc 08 28 02 00 00 	cmpb   $0xff,0x228(%rax,%rcx,1)
    67c1:	ff 
    67c2:	0f 84 49 01 00 00    	je     6911 <fwp_mem_free+0x221>
    67c8:	4f 8d 3c ef          	lea    (%r15,%r13,8),%r15
    67cc:	49 83 c7 08          	add    $0x8,%r15
    67d0:	c6 03 00             	movb   $0x0,(%rbx)
    67d3:	83 3d d2 99 00 00 00 	cmpl   $0x0,0x99d2(%rip)        # 101ac <fwp_gc+0x1004>
    67da:	74 12                	je     67ee <fwp_mem_free+0xfe>
    67dc:	89 f2                	mov    %esi,%edx
    67de:	48 89 fb             	mov    %rdi,%rbx
    67e1:	31 f6                	xor    %esi,%esi
    67e3:	e8 78 b9 ff ff       	call   2160 <memset@plt>
    67e8:	48 89 df             	mov    %rbx,%rdi
    67eb:	41 8b 36             	mov    (%r14),%esi
    67ee:	49 8b 07             	mov    (%r15),%rax
    67f1:	48 f7 d0             	not    %rax
    67f4:	48 89 07             	mov    %rax,(%rdi)
    67f7:	49 89 3f             	mov    %rdi,(%r15)
    67fa:	89 f0                	mov    %esi,%eax
    67fc:	48 01 05 a5 89 00 00 	add    %rax,0x89a5(%rip)        # f1a8 <fwp_gc>
    6803:	e9 ff 00 00 00       	jmp    6907 <fwp_mem_free+0x217>
    6808:	48 81 e1 00 00 ff ff 	and    $0xffffffffffff0000,%rcx
    680f:	48 01 c8             	add    %rcx,%rax
    6812:	48 39 f8             	cmp    %rdi,%rax
    6815:	0f 85 ec 00 00 00    	jne    6907 <fwp_mem_free+0x217>
    681b:	4b 8b 44 34 18       	mov    0x18(%r12,%r14,1),%rax
    6820:	48 01 05 81 89 00 00 	add    %rax,0x8981(%rip)        # f1a8 <fwp_gc>
    6827:	43 c6 44 34 03 00    	movb   $0x0,0x3(%r12,%r14,1)
    682d:	4b 8d 1c 34          	lea    (%r12,%r14,1),%rbx
    6831:	48 81 c3 28 02 00 00 	add    $0x228,%rbx
    6838:	43 80 bc 34 28 02 00 	cmpb   $0xff,0x228(%r12,%r14,1)
    683f:	00 ff 
    6841:	0f 84 e0 00 00 00    	je     6927 <fwp_mem_free+0x237>
    6847:	c6 03 00             	movb   $0x0,(%rbx)
    684a:	43 8b 44 34 10       	mov    0x10(%r12,%r14,1),%eax
    684f:	48 85 c0             	test   %rax,%rax
    6852:	0f 84 88 00 00 00    	je     68e0 <fwp_mem_free+0x1f0>
    6858:	48 8b 0d c1 99 00 00 	mov    0x99c1(%rip),%rcx        # 10220 <fwp_gc+0x1078>
    685f:	89 c2                	mov    %eax,%edx
    6861:	83 e2 03             	and    $0x3,%edx
    6864:	83 f8 04             	cmp    $0x4,%eax
    6867:	73 04                	jae    686d <fwp_mem_free+0x17d>
    6869:	31 f6                	xor    %esi,%esi
    686b:	eb 3b                	jmp    68a8 <fwp_mem_free+0x1b8>
    686d:	4a 8d 3c 31          	lea    (%rcx,%r14,1),%rdi
    6871:	41 89 c0             	mov    %eax,%r8d
    6874:	41 83 e0 fc          	and    $0xfffffffc,%r8d
    6878:	31 f6                	xor    %esi,%esi
    687a:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)
    6880:	c6 07 00             	movb   $0x0,(%rdi)
    6883:	c6 87 28 12 00 00 00 	movb   $0x0,0x1228(%rdi)
    688a:	c6 87 50 24 00 00 00 	movb   $0x0,0x2450(%rdi)
    6891:	c6 87 78 36 00 00 00 	movb   $0x0,0x3678(%rdi)
    6898:	48 83 c6 04          	add    $0x4,%rsi
    689c:	48 81 c7 a0 48 00 00 	add    $0x48a0,%rdi
    68a3:	49 39 f0             	cmp    %rsi,%r8
    68a6:	75 d8                	jne    6880 <fwp_mem_free+0x190>
    68a8:	48 85 d2             	test   %rdx,%rdx
    68ab:	74 33                	je     68e0 <fwp_mem_free+0x1f0>
    68ad:	48 69 f6 28 12 00 00 	imul   $0x1228,%rsi,%rsi
    68b4:	4c 01 f6             	add    %r14,%rsi
    68b7:	48 01 f1             	add    %rsi,%rcx
    68ba:	48 69 d2 28 12 00 00 	imul   $0x1228,%rdx,%rdx
    68c1:	31 f6                	xor    %esi,%esi
    68c3:	66 66 66 66 2e 0f 1f 	data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    68ca:	84 00 00 00 00 00 
    68d0:	c6 04 31 00          	movb   $0x0,(%rcx,%rsi,1)
    68d4:	48 81 c6 28 12 00 00 	add    $0x1228,%rsi
    68db:	48 39 f2             	cmp    %rsi,%rdx
    68de:	75 f0                	jne    68d0 <fwp_mem_free+0x1e0>
    68e0:	48 01 05 a1 9a 00 00 	add    %rax,0x9aa1(%rip)        # 10388 <fwp_gc+0x11e0>
    68e7:	4c 3b 3d 2a 99 00 00 	cmp    0x992a(%rip),%r15        # 10218 <fwp_gc+0x1070>
    68ee:	73 07                	jae    68f7 <fwp_mem_free+0x207>
    68f0:	4c 89 3d 21 99 00 00 	mov    %r15,0x9921(%rip)        # 10218 <fwp_gc+0x1070>
    68f7:	4c 3b 3d 12 99 00 00 	cmp    0x9912(%rip),%r15        # 10210 <fwp_gc+0x1068>
    68fe:	73 07                	jae    6907 <fwp_mem_free+0x217>
    6900:	4c 89 3d 09 99 00 00 	mov    %r15,0x9909(%rip)        # 10210 <fwp_gc+0x1068>
    6907:	5b                   	pop    %rbx
    6908:	41 5c                	pop    %r12
    690a:	41 5d                	pop    %r13
    690c:	41 5e                	pop    %r14
    690e:	41 5f                	pop    %r15
    6910:	c3                   	ret
    6911:	49 89 fc             	mov    %rdi,%r12
    6914:	48 89 df             	mov    %rbx,%rdi
    6917:	e8 c4 ce ff ff       	call   37e0 <fwp_rc_forget_slot>
    691c:	4c 89 e7             	mov    %r12,%rdi
    691f:	41 8b 36             	mov    (%r14),%esi
    6922:	e9 a1 fe ff ff       	jmp    67c8 <fwp_mem_free+0xd8>
    6927:	48 89 df             	mov    %rbx,%rdi
    692a:	e8 b1 ce ff ff       	call   37e0 <fwp_rc_forget_slot>
    692f:	e9 13 ff ff ff       	jmp    6847 <fwp_mem_free+0x157>
    6934:	66 66 66 2e 0f 1f 84 	data16 data16 cs nopw 0x0(%rax,%rax,1)
    693b:	00 00 00 00 00 

0000000000006940 <fwp_value_release>:
    6940:	48 89 f8             	mov    %rdi,%rax
    6943:	48 8b 3f             	mov    (%rdi),%rdi
    6946:	48 8b 48 08          	mov    0x8(%rax),%rcx
    694a:	48 c7 00 00 00 00 00 	movq   $0x0,(%rax)
    6951:	48 85 c9             	test   %rcx,%rcx
    6954:	74 07                	je     695d <fwp_value_release+0x1d>
    6956:	48 85 ff             	test   %rdi,%rdi
    6959:	74 02                	je     695d <fwp_value_release+0x1d>
    695b:	ff e1                	jmp    *%rcx
    695d:	c3                   	ret
    695e:	66 90                	xchg   %ax,%ax

0000000000006960 <fwp_owned_entry2>:
    6960:	48 83 ec 18          	sub    $0x18,%rsp
    6964:	48 8b 07             	mov    (%rdi),%rax
    6967:	f3 0f 6f 47 08       	movdqu 0x8(%rdi),%xmm0
    696c:	66 0f 70 c0 4e       	pshufd $0x4e,%xmm0,%xmm0
    6971:	66 0f 7f 04 24       	movdqa %xmm0,(%rsp)
    6976:	48 89 e2             	mov    %rsp,%rdx
    6979:	48 89 c7             	mov    %rax,%rdi
    697c:	be 02 00 00 00       	mov    $0x2,%esi
    6981:	e8 3a e0 ff ff       	call   49c0 <fwp_apply_owned>
    6986:	48 83 c4 18          	add    $0x18,%rsp
    698a:	c3                   	ret
    698b:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)

0000000000006990 <fwp_caps2>:
    6990:	85 f6                	test   %esi,%esi
    6992:	74 0e                	je     69a2 <fwp_caps2+0x12>
    6994:	8b 57 04             	mov    0x4(%rdi),%edx
    6997:	48 83 c7 08          	add    $0x8,%rdi
    699b:	31 f6                	xor    %esi,%esi
    699d:	e9 ee 00 00 00       	jmp    6a90 <fwp_args2>
    69a2:	53                   	push   %rbx
    69a3:	83 7f 04 00          	cmpl   $0x0,0x4(%rdi)
    69a7:	0f 84 bd 00 00 00    	je     6a6a <fwp_caps2+0xda>
    69ad:	48 8b 47 08          	mov    0x8(%rdi),%rax
    69b1:	48 89 fb             	mov    %rdi,%rbx
    69b4:	48 89 c7             	mov    %rax,%rdi
    69b7:	e8 34 f6 ff ff       	call   5ff0 <fwp_closure_drop>
    69bc:	48 89 df             	mov    %rbx,%rdi
    69bf:	83 7b 04 02          	cmpl   $0x2,0x4(%rbx)
    69c3:	0f 82 a1 00 00 00    	jb     6a6a <fwp_caps2+0xda>
    69c9:	48 8b 7f 10          	mov    0x10(%rdi),%rdi
    69cd:	e8 1e f6 ff ff       	call   5ff0 <fwp_closure_drop>
    69d2:	48 89 df             	mov    %rbx,%rdi
    69d5:	83 7b 04 03          	cmpl   $0x3,0x4(%rbx)
    69d9:	0f 82 8b 00 00 00    	jb     6a6a <fwp_caps2+0xda>
    69df:	48 8b 47 18          	mov    0x18(%rdi),%rax
    69e3:	48 89 c1             	mov    %rax,%rcx
    69e6:	48 2b 0d eb 97 00 00 	sub    0x97eb(%rip),%rcx        # 101d8 <fwp_gc+0x1030>
    69ed:	48 8b 15 0c 98 00 00 	mov    0x980c(%rip),%rdx        # 10200 <fwp_gc+0x1058>
    69f4:	48 c1 e2 10          	shl    $0x10,%rdx
    69f8:	48 39 d1             	cmp    %rdx,%rcx
    69fb:	73 6d                	jae    6a6a <fwp_caps2+0xda>
    69fd:	48 8b 15 1c 98 00 00 	mov    0x981c(%rip),%rdx        # 10220 <fwp_gc+0x1078>
    6a04:	48 89 ce             	mov    %rcx,%rsi
    6a07:	48 c1 ee 10          	shr    $0x10,%rsi
    6a0b:	48 69 f6 28 12 00 00 	imul   $0x1228,%rsi,%rsi
    6a12:	44 0f b6 04 32       	movzbl (%rdx,%rsi,1),%r8d
    6a17:	48 81 e1 ff ff 00 00 	and    $0xffff,%rcx
    6a1e:	75 13                	jne    6a33 <fwp_caps2+0xa3>
    6a20:	41 80 f8 02          	cmp    $0x2,%r8b
    6a24:	75 0d                	jne    6a33 <fwp_caps2+0xa3>
    6a26:	48 8d 0c 32          	lea    (%rdx,%rsi,1),%rcx
    6a2a:	48 81 c1 28 02 00 00 	add    $0x228,%rcx
    6a31:	eb 20                	jmp    6a53 <fwp_caps2+0xc3>
    6a33:	41 80 f8 01          	cmp    $0x1,%r8b
    6a37:	75 31                	jne    6a6a <fwp_caps2+0xda>
    6a39:	4c 8d 04 32          	lea    (%rdx,%rsi,1),%r8
    6a3d:	8b 54 32 20          	mov    0x20(%rdx,%rsi,1),%edx
    6a41:	48 0f af ca          	imul   %rdx,%rcx
    6a45:	48 c1 e9 20          	shr    $0x20,%rcx
    6a49:	4c 01 c1             	add    %r8,%rcx
    6a4c:	48 81 c1 28 02 00 00 	add    $0x228,%rcx
    6a53:	0f b6 11             	movzbl (%rcx),%edx
    6a56:	85 d2                	test   %edx,%edx
    6a58:	74 10                	je     6a6a <fwp_caps2+0xda>
    6a5a:	83 fa 01             	cmp    $0x1,%edx
    6a5d:	75 11                	jne    6a70 <fwp_caps2+0xe0>
    6a5f:	48 89 c7             	mov    %rax,%rdi
    6a62:	e8 a9 fa ff ff       	call   6510 <fwp_rc_free_obj>
    6a67:	48 89 df             	mov    %rbx,%rdi
    6a6a:	5b                   	pop    %rbx
    6a6b:	e9 a0 fa ff ff       	jmp    6510 <fwp_rc_free_obj>
    6a70:	81 fa ff 00 00 00    	cmp    $0xff,%edx
    6a76:	74 0a                	je     6a82 <fwp_caps2+0xf2>
    6a78:	fe ca                	dec    %dl
    6a7a:	88 11                	mov    %dl,(%rcx)
    6a7c:	5b                   	pop    %rbx
    6a7d:	e9 8e fa ff ff       	jmp    6510 <fwp_rc_free_obj>
    6a82:	48 89 cf             	mov    %rcx,%rdi
    6a85:	e8 76 f8 ff ff       	call   6300 <fwp_rc_wide_drop>
    6a8a:	eb db                	jmp    6a67 <fwp_caps2+0xd7>
    6a8c:	0f 1f 40 00          	nopl   0x0(%rax)

0000000000006a90 <fwp_args2>:
    6a90:	55                   	push   %rbp
    6a91:	41 57                	push   %r15
    6a93:	41 56                	push   %r14
    6a95:	53                   	push   %rbx
    6a96:	48 83 ec 38          	sub    $0x38,%rsp
    6a9a:	48 89 7c 24 08       	mov    %rdi,0x8(%rsp)
    6a9f:	48 8d 05 8a 02 00 00 	lea    0x28a(%rip),%rax        # 6d30 <fwp_arg_drop2>
    6aa6:	48 89 44 24 10       	mov    %rax,0x10(%rsp)
    6aab:	89 74 24 18          	mov    %esi,0x18(%rsp)
    6aaf:	c7 44 24 1c 00 00 00 	movl   $0x0,0x1c(%rsp)
    6ab6:	00 
    6ab7:	48 8b 05 aa a1 00 00 	mov    0xa1aa(%rip),%rax        # 10c68 <fwp_cleanups>
    6abe:	48 89 44 24 20       	mov    %rax,0x20(%rsp)
    6ac3:	48 8d 05 66 03 00 00 	lea    0x366(%rip),%rax        # 6e30 <fwp_args_release>
    6aca:	48 89 44 24 28       	mov    %rax,0x28(%rsp)
    6acf:	48 8d 44 24 08       	lea    0x8(%rsp),%rax
    6ad4:	48 89 44 24 30       	mov    %rax,0x30(%rsp)
    6ad9:	48 8d 5c 24 20       	lea    0x20(%rsp),%rbx
    6ade:	48 89 1d 83 a1 00 00 	mov    %rbx,0xa183(%rip)        # 10c68 <fwp_cleanups>
    6ae5:	85 f6                	test   %esi,%esi
    6ae7:	75 52                	jne    6b3b <fwp_args2+0xab>
    6ae9:	85 d2                	test   %edx,%edx
    6aeb:	74 4e                	je     6b3b <fwp_args2+0xab>
    6aed:	48 8b 07             	mov    (%rdi),%rax
    6af0:	48 2b 05 e1 96 00 00 	sub    0x96e1(%rip),%rax        # 101d8 <fwp_gc+0x1030>
    6af7:	48 8b 0d 02 97 00 00 	mov    0x9702(%rip),%rcx        # 10200 <fwp_gc+0x1058>
    6afe:	48 c1 e1 10          	shl    $0x10,%rcx
    6b02:	48 39 c8             	cmp    %rcx,%rax
    6b05:	73 7b                	jae    6b82 <fwp_args2+0xf2>
    6b07:	48 8b 0d 12 97 00 00 	mov    0x9712(%rip),%rcx        # 10220 <fwp_gc+0x1078>
    6b0e:	49 89 c0             	mov    %rax,%r8
    6b11:	49 c1 e8 10          	shr    $0x10,%r8
    6b15:	4d 69 c0 28 12 00 00 	imul   $0x1228,%r8,%r8
    6b1c:	46 0f b6 0c 01       	movzbl (%rcx,%r8,1),%r9d
    6b21:	48 25 ff ff 00 00    	and    $0xffff,%rax
    6b27:	75 25                	jne    6b4e <fwp_args2+0xbe>
    6b29:	41 80 f9 02          	cmp    $0x2,%r9b
    6b2d:	75 1f                	jne    6b4e <fwp_args2+0xbe>
    6b2f:	4a 8d 04 01          	lea    (%rcx,%r8,1),%rax
    6b33:	48 05 28 02 00 00    	add    $0x228,%rax
    6b39:	eb 33                	jmp    6b6e <fwp_args2+0xde>
    6b3b:	83 fe 01             	cmp    $0x1,%esi
    6b3e:	76 4a                	jbe    6b8a <fwp_args2+0xfa>
    6b40:	83 fe 02             	cmp    $0x2,%esi
    6b43:	0f 84 de 00 00 00    	je     6c27 <fwp_args2+0x197>
    6b49:	e9 6f 01 00 00       	jmp    6cbd <fwp_args2+0x22d>
    6b4e:	41 80 f9 01          	cmp    $0x1,%r9b
    6b52:	75 2e                	jne    6b82 <fwp_args2+0xf2>
    6b54:	4e 8d 0c 01          	lea    (%rcx,%r8,1),%r9
    6b58:	42 8b 4c 01 20       	mov    0x20(%rcx,%r8,1),%ecx
    6b5d:	48 0f af c1          	imul   %rcx,%rax
    6b61:	48 c1 e8 20          	shr    $0x20,%rax
    6b65:	4c 01 c8             	add    %r9,%rax
    6b68:	48 05 28 02 00 00    	add    $0x228,%rax
    6b6e:	0f b6 08             	movzbl (%rax),%ecx
    6b71:	84 c9                	test   %cl,%cl
    6b73:	74 0d                	je     6b82 <fwp_args2+0xf2>
    6b75:	80 f9 fe             	cmp    $0xfe,%cl
    6b78:	0f 83 5f 01 00 00    	jae    6cdd <fwp_args2+0x24d>
    6b7e:	fe c1                	inc    %cl
    6b80:	88 08                	mov    %cl,(%rax)
    6b82:	c7 44 24 1c 01 00 00 	movl   $0x1,0x1c(%rsp)
    6b89:	00 
    6b8a:	89 f0                	mov    %esi,%eax
    6b8c:	83 f0 01             	xor    $0x1,%eax
    6b8f:	39 d0                	cmp    %edx,%eax
    6b91:	0f 83 90 00 00 00    	jae    6c27 <fwp_args2+0x197>
    6b97:	89 c0                	mov    %eax,%eax
    6b99:	48 8b 04 c7          	mov    (%rdi,%rax,8),%rax
    6b9d:	48 2b 05 34 96 00 00 	sub    0x9634(%rip),%rax        # 101d8 <fwp_gc+0x1030>
    6ba4:	48 8b 0d 55 96 00 00 	mov    0x9655(%rip),%rcx        # 10200 <fwp_gc+0x1058>
    6bab:	48 c1 e1 10          	shl    $0x10,%rcx
    6baf:	48 39 c8             	cmp    %rcx,%rax
    6bb2:	73 68                	jae    6c1c <fwp_args2+0x18c>
    6bb4:	48 8b 0d 65 96 00 00 	mov    0x9665(%rip),%rcx        # 10220 <fwp_gc+0x1078>
    6bbb:	49 89 c0             	mov    %rax,%r8
    6bbe:	49 c1 e8 10          	shr    $0x10,%r8
    6bc2:	4d 69 c0 28 12 00 00 	imul   $0x1228,%r8,%r8
    6bc9:	46 0f b6 0c 01       	movzbl (%rcx,%r8,1),%r9d
    6bce:	48 25 ff ff 00 00    	and    $0xffff,%rax
    6bd4:	75 12                	jne    6be8 <fwp_args2+0x158>
    6bd6:	41 80 f9 02          	cmp    $0x2,%r9b
    6bda:	75 0c                	jne    6be8 <fwp_args2+0x158>
    6bdc:	4a 8d 04 01          	lea    (%rcx,%r8,1),%rax
    6be0:	48 05 28 02 00 00    	add    $0x228,%rax
    6be6:	eb 20                	jmp    6c08 <fwp_args2+0x178>
    6be8:	41 80 f9 01          	cmp    $0x1,%r9b
    6bec:	75 2e                	jne    6c1c <fwp_args2+0x18c>
    6bee:	4e 8d 0c 01          	lea    (%rcx,%r8,1),%r9
    6bf2:	42 8b 4c 01 20       	mov    0x20(%rcx,%r8,1),%ecx
    6bf7:	48 0f af c1          	imul   %rcx,%rax
    6bfb:	48 c1 e8 20          	shr    $0x20,%rax
    6bff:	4c 01 c8             	add    %r9,%rax
    6c02:	48 05 28 02 00 00    	add    $0x228,%rax
    6c08:	0f b6 08             	movzbl (%rax),%ecx
    6c0b:	84 c9                	test   %cl,%cl
    6c0d:	74 0d                	je     6c1c <fwp_args2+0x18c>
    6c0f:	80 f9 fe             	cmp    $0xfe,%cl
    6c12:	0f 83 ed 00 00 00    	jae    6d05 <fwp_args2+0x275>
    6c18:	fe c1                	inc    %cl
    6c1a:	88 08                	mov    %cl,(%rax)
    6c1c:	b8 02 00 00 00       	mov    $0x2,%eax
    6c21:	29 f0                	sub    %esi,%eax
    6c23:	89 44 24 1c          	mov    %eax,0x1c(%rsp)
    6c27:	b8 02 00 00 00       	mov    $0x2,%eax
    6c2c:	29 f0                	sub    %esi,%eax
    6c2e:	39 d0                	cmp    %edx,%eax
    6c30:	0f 83 87 00 00 00    	jae    6cbd <fwp_args2+0x22d>
    6c36:	89 c0                	mov    %eax,%eax
    6c38:	48 8b 04 c7          	mov    (%rdi,%rax,8),%rax
    6c3c:	48 2b 05 95 95 00 00 	sub    0x9595(%rip),%rax        # 101d8 <fwp_gc+0x1030>
    6c43:	48 8b 0d b6 95 00 00 	mov    0x95b6(%rip),%rcx        # 10200 <fwp_gc+0x1058>
    6c4a:	48 c1 e1 10          	shl    $0x10,%rcx
    6c4e:	48 39 c8             	cmp    %rcx,%rax
    6c51:	73 63                	jae    6cb6 <fwp_args2+0x226>
    6c53:	48 8b 0d c6 95 00 00 	mov    0x95c6(%rip),%rcx        # 10220 <fwp_gc+0x1078>
    6c5a:	48 89 c2             	mov    %rax,%rdx
    6c5d:	48 c1 ea 10          	shr    $0x10,%rdx
    6c61:	48 69 d2 28 12 00 00 	imul   $0x1228,%rdx,%rdx
    6c68:	0f b6 3c 11          	movzbl (%rcx,%rdx,1),%edi
    6c6c:	48 25 ff ff 00 00    	and    $0xffff,%rax
    6c72:	75 13                	jne    6c87 <fwp_args2+0x1f7>
    6c74:	40 80 ff 02          	cmp    $0x2,%dil
    6c78:	75 0d                	jne    6c87 <fwp_args2+0x1f7>
    6c7a:	48 8d 3c 11          	lea    (%rcx,%rdx,1),%rdi
    6c7e:	48 81 c7 28 02 00 00 	add    $0x228,%rdi
    6c85:	eb 20                	jmp    6ca7 <fwp_args2+0x217>
    6c87:	40 80 ff 01          	cmp    $0x1,%dil
    6c8b:	75 29                	jne    6cb6 <fwp_args2+0x226>
    6c8d:	48 8d 3c 11          	lea    (%rcx,%rdx,1),%rdi
    6c91:	8b 4c 11 20          	mov    0x20(%rcx,%rdx,1),%ecx
    6c95:	48 0f af c1          	imul   %rcx,%rax
    6c99:	48 c1 e8 20          	shr    $0x20,%rax
    6c9d:	48 01 c7             	add    %rax,%rdi
    6ca0:	48 81 c7 28 02 00 00 	add    $0x228,%rdi
    6ca7:	0f b6 07             	movzbl (%rdi),%eax
    6caa:	84 c0                	test   %al,%al
    6cac:	74 08                	je     6cb6 <fwp_args2+0x226>
    6cae:	3c fe                	cmp    $0xfe,%al
    6cb0:	73 48                	jae    6cfa <fwp_args2+0x26a>
    6cb2:	fe c0                	inc    %al
    6cb4:	88 07                	mov    %al,(%rdi)
    6cb6:	83 f6 03             	xor    $0x3,%esi
    6cb9:	89 74 24 1c          	mov    %esi,0x1c(%rsp)
    6cbd:	48 39 1d a4 9f 00 00 	cmp    %rbx,0x9fa4(%rip)        # 10c68 <fwp_cleanups>
    6cc4:	75 5c                	jne    6d22 <fwp_args2+0x292>
    6cc6:	48 8b 44 24 20       	mov    0x20(%rsp),%rax
    6ccb:	48 89 05 96 9f 00 00 	mov    %rax,0x9f96(%rip)        # 10c68 <fwp_cleanups>
    6cd2:	48 83 c4 38          	add    $0x38,%rsp
    6cd6:	5b                   	pop    %rbx
    6cd7:	41 5e                	pop    %r14
    6cd9:	41 5f                	pop    %r15
    6cdb:	5d                   	pop    %rbp
    6cdc:	c3                   	ret
    6cdd:	49 89 fe             	mov    %rdi,%r14
    6ce0:	48 89 c7             	mov    %rax,%rdi
    6ce3:	89 f5                	mov    %esi,%ebp
    6ce5:	41 89 d7             	mov    %edx,%r15d
    6ce8:	e8 a3 f6 ff ff       	call   6390 <fwp_rc_wide_dup>
    6ced:	44 89 fa             	mov    %r15d,%edx
    6cf0:	4c 89 f7             	mov    %r14,%rdi
    6cf3:	89 ee                	mov    %ebp,%esi
    6cf5:	e9 88 fe ff ff       	jmp    6b82 <fwp_args2+0xf2>
    6cfa:	89 f5                	mov    %esi,%ebp
    6cfc:	e8 8f f6 ff ff       	call   6390 <fwp_rc_wide_dup>
    6d01:	89 ee                	mov    %ebp,%esi
    6d03:	eb b1                	jmp    6cb6 <fwp_args2+0x226>
    6d05:	49 89 fe             	mov    %rdi,%r14
    6d08:	48 89 c7             	mov    %rax,%rdi
    6d0b:	89 f5                	mov    %esi,%ebp
    6d0d:	41 89 d7             	mov    %edx,%r15d
    6d10:	e8 7b f6 ff ff       	call   6390 <fwp_rc_wide_dup>
    6d15:	44 89 fa             	mov    %r15d,%edx
    6d18:	4c 89 f7             	mov    %r14,%rdi
    6d1b:	89 ee                	mov    %ebp,%esi
    6d1d:	e9 fa fe ff ff       	jmp    6c1c <fwp_args2+0x18c>
    6d22:	e8 39 b3 ff ff       	call   2060 <abort@plt>
    6d27:	66 0f 1f 84 00 00 00 	nopw   0x0(%rax,%rax,1)
    6d2e:	00 00 

0000000000006d30 <fwp_arg_drop2>:
    6d30:	55                   	push   %rbp
    6d31:	41 56                	push   %r14
    6d33:	53                   	push   %rbx
    6d34:	89 d5                	mov    %edx,%ebp
    6d36:	41 89 f6             	mov    %esi,%r14d
    6d39:	48 89 fb             	mov    %rdi,%rbx
    6d3c:	85 f6                	test   %esi,%esi
    6d3e:	75 0e                	jne    6d4e <fwp_arg_drop2+0x1e>
    6d40:	85 ed                	test   %ebp,%ebp
    6d42:	74 0a                	je     6d4e <fwp_arg_drop2+0x1e>
    6d44:	48 8b 3b             	mov    (%rbx),%rdi
    6d47:	e8 a4 f2 ff ff       	call   5ff0 <fwp_closure_drop>
    6d4c:	eb 06                	jmp    6d54 <fwp_arg_drop2+0x24>
    6d4e:	41 83 fe 01          	cmp    $0x1,%r14d
    6d52:	77 17                	ja     6d6b <fwp_arg_drop2+0x3b>
    6d54:	44 89 f0             	mov    %r14d,%eax
    6d57:	83 f0 01             	xor    $0x1,%eax
    6d5a:	39 e8                	cmp    %ebp,%eax
    6d5c:	73 17                	jae    6d75 <fwp_arg_drop2+0x45>
    6d5e:	89 c0                	mov    %eax,%eax
    6d60:	48 8b 3c c3          	mov    (%rbx,%rax,8),%rdi
    6d64:	e8 87 f2 ff ff       	call   5ff0 <fwp_closure_drop>
    6d69:	eb 0a                	jmp    6d75 <fwp_arg_drop2+0x45>
    6d6b:	41 83 fe 02          	cmp    $0x2,%r14d
    6d6f:	0f 85 a3 00 00 00    	jne    6e18 <fwp_arg_drop2+0xe8>
    6d75:	b8 02 00 00 00       	mov    $0x2,%eax
    6d7a:	44 29 f0             	sub    %r14d,%eax
    6d7d:	39 e8                	cmp    %ebp,%eax
    6d7f:	0f 83 93 00 00 00    	jae    6e18 <fwp_arg_drop2+0xe8>
    6d85:	89 c0                	mov    %eax,%eax
    6d87:	48 8b 3c c3          	mov    (%rbx,%rax,8),%rdi
    6d8b:	48 89 f8             	mov    %rdi,%rax
    6d8e:	48 2b 05 43 94 00 00 	sub    0x9443(%rip),%rax        # 101d8 <fwp_gc+0x1030>
    6d95:	48 8b 0d 64 94 00 00 	mov    0x9464(%rip),%rcx        # 10200 <fwp_gc+0x1058>
    6d9c:	48 c1 e1 10          	shl    $0x10,%rcx
    6da0:	48 39 c8             	cmp    %rcx,%rax
    6da3:	73 73                	jae    6e18 <fwp_arg_drop2+0xe8>
    6da5:	48 8b 0d 74 94 00 00 	mov    0x9474(%rip),%rcx        # 10220 <fwp_gc+0x1078>
    6dac:	48 89 c2             	mov    %rax,%rdx
    6daf:	48 c1 ea 10          	shr    $0x10,%rdx
    6db3:	48 69 d2 28 12 00 00 	imul   $0x1228,%rdx,%rdx
    6dba:	0f b6 34 11          	movzbl (%rcx,%rdx,1),%esi
    6dbe:	48 25 ff ff 00 00    	and    $0xffff,%rax
    6dc4:	75 12                	jne    6dd8 <fwp_arg_drop2+0xa8>
    6dc6:	40 80 fe 02          	cmp    $0x2,%sil
    6dca:	75 0c                	jne    6dd8 <fwp_arg_drop2+0xa8>
    6dcc:	48 8d 04 11          	lea    (%rcx,%rdx,1),%rax
    6dd0:	48 05 28 02 00 00    	add    $0x228,%rax
    6dd6:	eb 1f                	jmp    6df7 <fwp_arg_drop2+0xc7>
    6dd8:	40 80 fe 01          	cmp    $0x1,%sil
    6ddc:	75 3a                	jne    6e18 <fwp_arg_drop2+0xe8>
    6dde:	48 8d 34 11          	lea    (%rcx,%rdx,1),%rsi
    6de2:	8b 4c 11 20          	mov    0x20(%rcx,%rdx,1),%ecx
    6de6:	48 0f af c1          	imul   %rcx,%rax
    6dea:	48 c1 e8 20          	shr    $0x20,%rax
    6dee:	48 01 f0             	add    %rsi,%rax
    6df1:	48 05 28 02 00 00    	add    $0x228,%rax
    6df7:	0f b6 08             	movzbl (%rax),%ecx
    6dfa:	85 c9                	test   %ecx,%ecx
    6dfc:	74 1a                	je     6e18 <fwp_arg_drop2+0xe8>
    6dfe:	83 f9 01             	cmp    $0x1,%ecx
    6e01:	75 09                	jne    6e0c <fwp_arg_drop2+0xdc>
    6e03:	5b                   	pop    %rbx
    6e04:	41 5e                	pop    %r14
    6e06:	5d                   	pop    %rbp
    6e07:	e9 04 f7 ff ff       	jmp    6510 <fwp_rc_free_obj>
    6e0c:	81 f9 ff 00 00 00    	cmp    $0xff,%ecx
    6e12:	74 09                	je     6e1d <fwp_arg_drop2+0xed>
    6e14:	fe c9                	dec    %cl
    6e16:	88 08                	mov    %cl,(%rax)
    6e18:	5b                   	pop    %rbx
    6e19:	41 5e                	pop    %r14
    6e1b:	5d                   	pop    %rbp
    6e1c:	c3                   	ret
    6e1d:	48 89 c7             	mov    %rax,%rdi
    6e20:	5b                   	pop    %rbx
    6e21:	41 5e                	pop    %r14
    6e23:	5d                   	pop    %rbp
    6e24:	e9 d7 f4 ff ff       	jmp    6300 <fwp_rc_wide_drop>
    6e29:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)

0000000000006e30 <fwp_args_release>:
    6e30:	8b 57 14             	mov    0x14(%rdi),%edx
    6e33:	c7 47 14 00 00 00 00 	movl   $0x0,0x14(%rdi)
    6e3a:	85 d2                	test   %edx,%edx
    6e3c:	74 0f                	je     6e4d <fwp_args_release+0x1d>
    6e3e:	48 8b 07             	mov    (%rdi),%rax
    6e41:	48 8b 4f 08          	mov    0x8(%rdi),%rcx
    6e45:	8b 77 10             	mov    0x10(%rdi),%esi
    6e48:	48 89 c7             	mov    %rax,%rdi
    6e4b:	ff e1                	jmp    *%rcx
    6e4d:	c3                   	ret
    6e4e:	66 90                	xchg   %ax,%ax

0000000000006e50 <fwp_p_file_with_owned>:
    6e50:	55                   	push   %rbp
    6e51:	41 57                	push   %r15
    6e53:	41 56                	push   %r14
    6e55:	41 55                	push   %r13
    6e57:	41 54                	push   %r12
    6e59:	53                   	push   %rbx
    6e5a:	48 81 ec 78 04 00 00 	sub    $0x478,%rsp
    6e61:	48 89 74 24 48       	mov    %rsi,0x48(%rsp)
    6e66:	48 89 7c 24 40       	mov    %rdi,0x40(%rsp)
    6e6b:	4c 8d 7f 08          	lea    0x8(%rdi),%r15
    6e6f:	48 8d 35 93 56 00 00 	lea    0x5693(%rip),%rsi        # c509 <fwp_segv.msg+0x2c9>
    6e76:	4c 89 ff             	mov    %r15,%rdi
    6e79:	e8 12 b4 ff ff       	call   2290 <fopen@plt>
    6e7e:	48 89 c3             	mov    %rax,%rbx
    6e81:	48 85 c0             	test   %rax,%rax
    6e84:	75 1b                	jne    6ea1 <fwp_p_file_with_owned+0x51>
    6e86:	48 8d 35 80 56 00 00 	lea    0x5680(%rip),%rsi        # c50d <fwp_segv.msg+0x2cd>
    6e8d:	4c 89 ff             	mov    %r15,%rdi
    6e90:	e8 fb b3 ff ff       	call   2290 <fopen@plt>
    6e95:	48 89 c3             	mov    %rax,%rbx
    6e98:	48 85 c0             	test   %rax,%rax
    6e9b:	0f 84 13 04 00 00    	je     72b4 <fwp_p_file_with_owned+0x464>
    6ea1:	48 89 5c 24 18       	mov    %rbx,0x18(%rsp)
    6ea6:	48 c7 44 24 20 00 00 	movq   $0x0,0x20(%rsp)
    6ead:	00 00 
    6eaf:	48 8b 05 b2 9d 00 00 	mov    0x9db2(%rip),%rax        # 10c68 <fwp_cleanups>
    6eb6:	48 89 44 24 70       	mov    %rax,0x70(%rsp)
    6ebb:	4c 8d 25 7e 05 00 00 	lea    0x57e(%rip),%r12        # 7440 <fwp_close_owned_scoped_file>
    6ec2:	4c 89 64 24 78       	mov    %r12,0x78(%rsp)
    6ec7:	48 8d 44 24 18       	lea    0x18(%rsp),%rax
    6ecc:	48 89 84 24 80 00 00 	mov    %rax,0x80(%rsp)
    6ed3:	00 
    6ed4:	48 8d 44 24 70       	lea    0x70(%rsp),%rax
    6ed9:	48 89 05 88 9d 00 00 	mov    %rax,0x9d88(%rip)        # 10c68 <fwp_cleanups>
    6ee0:	4c 89 ff             	mov    %r15,%rdi
    6ee3:	e8 28 b2 ff ff       	call   2110 <strlen@plt>
    6ee8:	48 83 f8 ef          	cmp    $0xffffffffffffffef,%rax
    6eec:	0f 83 70 03 00 00    	jae    7262 <fwp_p_file_with_owned+0x412>
    6ef2:	49 89 c5             	mov    %rax,%r13
    6ef5:	48 8d 50 11          	lea    0x11(%rax),%rdx
    6ef9:	48 3d ef 3f 00 00    	cmp    $0x3fef,%rax
    6eff:	77 63                	ja     6f64 <fwp_p_file_with_owned+0x114>
    6f01:	49 8d 4d 20          	lea    0x20(%r13),%rcx
    6f05:	48 c1 e9 04          	shr    $0x4,%rcx
    6f09:	48 8d 05 98 82 00 00 	lea    0x8298(%rip),%rax        # f1a8 <fwp_gc>
    6f10:	0f b6 8c 01 e8 0b 00 	movzbl 0xbe8(%rcx,%rax,1),%ecx
    6f17:	00 
    6f18:	89 ce                	mov    %ecx,%esi
    6f1a:	8b 8c b0 48 0b 00 00 	mov    0xb48(%rax,%rsi,4),%ecx
    6f21:	48 29 0d 80 82 00 00 	sub    %rcx,0x8280(%rip)        # f1a8 <fwp_gc>
    6f28:	78 3a                	js     6f64 <fwp_p_file_with_owned+0x114>
    6f2a:	48 8d 34 76          	lea    (%rsi,%rsi,2),%rsi
    6f2e:	48 8d 3c f0          	lea    (%rax,%rsi,8),%rdi
    6f32:	48 81 c7 c8 03 00 00 	add    $0x3c8,%rdi
    6f39:	4c 8b 37             	mov    (%rdi),%r14
    6f3c:	4d 85 f6             	test   %r14,%r14
    6f3f:	74 0b                	je     6f4c <fwp_p_file_with_owned+0xfc>
    6f41:	49 8b 06             	mov    (%r14),%rax
    6f44:	48 f7 d0             	not    %rax
    6f47:	48 89 07             	mov    %rax,(%rdi)
    6f4a:	eb 3a                	jmp    6f86 <fwp_p_file_with_owned+0x136>
    6f4c:	4c 8b b4 f0 d0 03 00 	mov    0x3d0(%rax,%rsi,8),%r14
    6f53:	00 
    6f54:	48 8b bc f0 d8 03 00 	mov    0x3d8(%rax,%rsi,8),%rdi
    6f5b:	00 
    6f5c:	4c 29 f7             	sub    %r14,%rdi
    6f5f:	48 39 cf             	cmp    %rcx,%rdi
    6f62:	73 12                	jae    6f76 <fwp_p_file_with_owned+0x126>
    6f64:	48 89 d7             	mov    %rdx,%rdi
    6f67:	be 01 00 00 00       	mov    $0x1,%esi
    6f6c:	e8 ff e4 ff ff       	call   5470 <fwp_gc_alloc_slow>
    6f71:	49 89 c6             	mov    %rax,%r14
    6f74:	eb 1a                	jmp    6f90 <fwp_p_file_with_owned+0x140>
    6f76:	48 8d 04 f0          	lea    (%rax,%rsi,8),%rax
    6f7a:	48 05 d0 03 00 00    	add    $0x3d0,%rax
    6f80:	4c 01 f1             	add    %r14,%rcx
    6f83:	48 89 08             	mov    %rcx,(%rax)
    6f86:	4c 89 f7             	mov    %r14,%rdi
    6f89:	31 f6                	xor    %esi,%esi
    6f8b:	e8 d0 b1 ff ff       	call   2160 <memset@plt>
    6f90:	49 89 1e             	mov    %rbx,(%r14)
    6f93:	49 c7 46 08 01 00 00 	movq   $0x1,0x8(%r14)
    6f9a:	00 
    6f9b:	4c 89 f2             	mov    %r14,%rdx
    6f9e:	48 2b 15 33 92 00 00 	sub    0x9233(%rip),%rdx        # 101d8 <fwp_gc+0x1030>
    6fa5:	48 8b 05 54 92 00 00 	mov    0x9254(%rip),%rax        # 10200 <fwp_gc+0x1058>
    6fac:	48 c1 e0 10          	shl    $0x10,%rax
    6fb0:	48 39 c2             	cmp    %rax,%rdx
    6fb3:	73 70                	jae    7025 <fwp_p_file_with_owned+0x1d5>
    6fb5:	48 8b 05 64 92 00 00 	mov    0x9264(%rip),%rax        # 10220 <fwp_gc+0x1078>
    6fbc:	48 89 d1             	mov    %rdx,%rcx
    6fbf:	48 c1 e9 10          	shr    $0x10,%rcx
    6fc3:	48 69 c9 28 12 00 00 	imul   $0x1228,%rcx,%rcx
    6fca:	0f b6 34 08          	movzbl (%rax,%rcx,1),%esi
    6fce:	48 81 e2 ff ff 00 00 	and    $0xffff,%rdx
    6fd5:	75 1d                	jne    6ff4 <fwp_p_file_with_owned+0x1a4>
    6fd7:	40 80 fe 02          	cmp    $0x2,%sil
    6fdb:	75 17                	jne    6ff4 <fwp_p_file_with_owned+0x1a4>
    6fdd:	48 8d 2c 08          	lea    (%rax,%rcx,1),%rbp
    6fe1:	48 81 c5 28 02 00 00 	add    $0x228,%rbp
    6fe8:	80 7d 00 ff          	cmpb   $0xff,0x0(%rbp)
    6fec:	74 2d                	je     701b <fwp_p_file_with_owned+0x1cb>
    6fee:	c6 45 00 01          	movb   $0x1,0x0(%rbp)
    6ff2:	eb 31                	jmp    7025 <fwp_p_file_with_owned+0x1d5>
    6ff4:	40 80 fe 01          	cmp    $0x1,%sil
    6ff8:	75 2b                	jne    7025 <fwp_p_file_with_owned+0x1d5>
    6ffa:	48 8d 34 08          	lea    (%rax,%rcx,1),%rsi
    6ffe:	8b 44 08 20          	mov    0x20(%rax,%rcx,1),%eax
    7002:	48 0f af d0          	imul   %rax,%rdx
    7006:	48 c1 ea 20          	shr    $0x20,%rdx
    700a:	48 8d 2c 32          	lea    (%rdx,%rsi,1),%rbp
    700e:	48 81 c5 28 02 00 00 	add    $0x228,%rbp
    7015:	80 7d 00 ff          	cmpb   $0xff,0x0(%rbp)
    7019:	75 d3                	jne    6fee <fwp_p_file_with_owned+0x19e>
    701b:	48 89 ef             	mov    %rbp,%rdi
    701e:	e8 bd c7 ff ff       	call   37e0 <fwp_rc_forget_slot>
    7023:	eb c9                	jmp    6fee <fwp_p_file_with_owned+0x19e>
    7025:	4c 89 74 24 20       	mov    %r14,0x20(%rsp)
    702a:	49 8d 7e 10          	lea    0x10(%r14),%rdi
    702e:	49 ff c5             	inc    %r13
    7031:	4c 89 fe             	mov    %r15,%rsi
    7034:	4c 89 ea             	mov    %r13,%rdx
    7037:	e8 d4 b1 ff ff       	call   2210 <memcpy@plt>
    703c:	48 8d 7c 24 70       	lea    0x70(%rsp),%rdi
    7041:	48 39 3d 20 9c 00 00 	cmp    %rdi,0x9c20(%rip)        # 10c68 <fwp_cleanups>
    7048:	0f 85 0f 02 00 00    	jne    725d <fwp_p_file_with_owned+0x40d>
    704e:	48 8b 44 24 70       	mov    0x70(%rsp),%rax
    7053:	4c 89 74 24 50       	mov    %r14,0x50(%rsp)
    7058:	48 89 5c 24 08       	mov    %rbx,0x8(%rsp)
    705d:	4c 89 74 24 10       	mov    %r14,0x10(%rsp)
    7062:	48 89 44 24 18       	mov    %rax,0x18(%rsp)
    7067:	4c 89 64 24 20       	mov    %r12,0x20(%rsp)
    706c:	48 8d 4c 24 08       	lea    0x8(%rsp),%rcx
    7071:	48 89 4c 24 28       	mov    %rcx,0x28(%rsp)
    7076:	4c 8d 6c 24 18       	lea    0x18(%rsp),%r13
    707b:	4c 89 2d e6 9b 00 00 	mov    %r13,0x9be6(%rip)        # 10c68 <fwp_cleanups>
    7082:	48 8b 0d e7 9b 00 00 	mov    0x9be7(%rip),%rcx        # 10c70 <fwp_handlers>
    7089:	48 89 8c 24 38 01 00 	mov    %rcx,0x138(%rsp)
    7090:	00 
    7091:	48 8b 0d e0 9b 00 00 	mov    0x9be0(%rip),%rcx        # 10c78 <fwp_state_len>
    7098:	48 89 8c 24 50 01 00 	mov    %rcx,0x150(%rsp)
    709f:	00 
    70a0:	48 89 84 24 58 01 00 	mov    %rax,0x158(%rsp)
    70a7:	00 
    70a8:	48 89 3d c1 9b 00 00 	mov    %rdi,0x9bc1(%rip)        # 10c70 <fwp_handlers>
    70af:	e8 ec b0 ff ff       	call   21a0 <_setjmp@plt>
    70b4:	85 c0                	test   %eax,%eax
    70b6:	0f 85 d4 01 00 00    	jne    7290 <fwp_p_file_with_owned+0x440>
    70bc:	48 8d 74 24 50       	lea    0x50(%rsp),%rsi
    70c1:	4c 8b 64 24 48       	mov    0x48(%rsp),%r12
    70c6:	4c 89 e7             	mov    %r12,%rdi
    70c9:	e8 22 cc ff ff       	call   3cf0 <fwp_apply_borrowed>
    70ce:	48 8b 8c 24 38 01 00 	mov    0x138(%rsp),%rcx
    70d5:	00 
    70d6:	48 89 0d 93 9b 00 00 	mov    %rcx,0x9b93(%rip)        # 10c70 <fwp_handlers>
    70dd:	48 89 44 24 30       	mov    %rax,0x30(%rsp)
    70e2:	48 8d 0d 07 02 00 00 	lea    0x207(%rip),%rcx        # 72f0 <fwp_drop6>
    70e9:	48 89 4c 24 38       	mov    %rcx,0x38(%rsp)
    70ee:	48 8b 0d 73 9b 00 00 	mov    0x9b73(%rip),%rcx        # 10c68 <fwp_cleanups>
    70f5:	48 89 4c 24 58       	mov    %rcx,0x58(%rsp)
    70fa:	48 8d 0d 3f f8 ff ff 	lea    -0x7c1(%rip),%rcx        # 6940 <fwp_value_release>
    7101:	48 89 4c 24 60       	mov    %rcx,0x60(%rsp)
    7106:	48 8d 4c 24 30       	lea    0x30(%rsp),%rcx
    710b:	48 89 4c 24 68       	mov    %rcx,0x68(%rsp)
    7110:	48 8d 5c 24 58       	lea    0x58(%rsp),%rbx
    7115:	48 89 1d 4c 9b 00 00 	mov    %rbx,0x9b4c(%rip)        # 10c68 <fwp_cleanups>
    711c:	4c 8b 78 08          	mov    0x8(%rax),%r15
    7120:	4c 89 fe             	mov    %r15,%rsi
    7123:	48 2b 35 ae 90 00 00 	sub    0x90ae(%rip),%rsi        # 101d8 <fwp_gc+0x1030>
    712a:	48 8b 0d cf 90 00 00 	mov    0x90cf(%rip),%rcx        # 10200 <fwp_gc+0x1058>
    7131:	48 c1 e1 10          	shl    $0x10,%rcx
    7135:	48 39 ce             	cmp    %rcx,%rsi
    7138:	73 69                	jae    71a3 <fwp_p_file_with_owned+0x353>
    713a:	48 8b 0d df 90 00 00 	mov    0x90df(%rip),%rcx        # 10220 <fwp_gc+0x1078>
    7141:	48 89 f2             	mov    %rsi,%rdx
    7144:	48 c1 ea 10          	shr    $0x10,%rdx
    7148:	48 69 d2 28 12 00 00 	imul   $0x1228,%rdx,%rdx
    714f:	0f b6 3c 11          	movzbl (%rcx,%rdx,1),%edi
    7153:	48 81 e6 ff ff 00 00 	and    $0xffff,%rsi
    715a:	75 13                	jne    716f <fwp_p_file_with_owned+0x31f>
    715c:	40 80 ff 02          	cmp    $0x2,%dil
    7160:	75 0d                	jne    716f <fwp_p_file_with_owned+0x31f>
    7162:	48 8d 3c 11          	lea    (%rcx,%rdx,1),%rdi
    7166:	48 81 c7 28 02 00 00 	add    $0x228,%rdi
    716d:	eb 20                	jmp    718f <fwp_p_file_with_owned+0x33f>
    716f:	40 80 ff 01          	cmp    $0x1,%dil
    7173:	75 2e                	jne    71a3 <fwp_p_file_with_owned+0x353>
    7175:	48 8d 3c 11          	lea    (%rcx,%rdx,1),%rdi
    7179:	8b 4c 11 20          	mov    0x20(%rcx,%rdx,1),%ecx
    717d:	48 0f af f1          	imul   %rcx,%rsi
    7181:	48 c1 ee 20          	shr    $0x20,%rsi
    7185:	48 01 f7             	add    %rsi,%rdi
    7188:	48 81 c7 28 02 00 00 	add    $0x228,%rdi
    718f:	0f b6 0f             	movzbl (%rdi),%ecx
    7192:	84 c9                	test   %cl,%cl
    7194:	74 0d                	je     71a3 <fwp_p_file_with_owned+0x353>
    7196:	80 f9 fe             	cmp    $0xfe,%cl
    7199:	0f 83 a2 00 00 00    	jae    7241 <fwp_p_file_with_owned+0x3f1>
    719f:	fe c1                	inc    %cl
    71a1:	88 0f                	mov    %cl,(%rdi)
    71a3:	48 83 7c 24 38 00    	cmpq   $0x0,0x38(%rsp)
    71a9:	74 19                	je     71c4 <fwp_p_file_with_owned+0x374>
    71ab:	48 39 1d b6 9a 00 00 	cmp    %rbx,0x9ab6(%rip)        # 10c68 <fwp_cleanups>
    71b2:	0f 85 a5 00 00 00    	jne    725d <fwp_p_file_with_owned+0x40d>
    71b8:	48 8b 4c 24 58       	mov    0x58(%rsp),%rcx
    71bd:	48 89 0d a4 9a 00 00 	mov    %rcx,0x9aa4(%rip)        # 10c68 <fwp_cleanups>
    71c4:	48 89 c7             	mov    %rax,%rdi
    71c7:	48 c7 44 24 30 00 00 	movq   $0x0,0x30(%rsp)
    71ce:	00 00 
    71d0:	e8 1b 01 00 00       	call   72f0 <fwp_drop6>
    71d5:	4c 39 2d 8c 9a 00 00 	cmp    %r13,0x9a8c(%rip)        # 10c68 <fwp_cleanups>
    71dc:	75 7f                	jne    725d <fwp_p_file_with_owned+0x40d>
    71de:	48 8b 44 24 18       	mov    0x18(%rsp),%rax
    71e3:	48 89 05 7e 9a 00 00 	mov    %rax,0x9a7e(%rip)        # 10c68 <fwp_cleanups>
    71ea:	48 8b 5c 24 10       	mov    0x10(%rsp),%rbx
    71ef:	48 85 db             	test   %rbx,%rbx
    71f2:	74 16                	je     720a <fwp_p_file_with_owned+0x3ba>
    71f4:	48 8b 3b             	mov    (%rbx),%rdi
    71f7:	48 85 ff             	test   %rdi,%rdi
    71fa:	74 18                	je     7214 <fwp_p_file_with_owned+0x3c4>
    71fc:	e8 ff ae ff ff       	call   2100 <fclose@plt>
    7201:	48 c7 03 00 00 00 00 	movq   $0x0,(%rbx)
    7208:	eb 0a                	jmp    7214 <fwp_p_file_with_owned+0x3c4>
    720a:	48 8b 7c 24 08       	mov    0x8(%rsp),%rdi
    720f:	e8 ec ae ff ff       	call   2100 <fclose@plt>
    7214:	48 8b 7c 24 10       	mov    0x10(%rsp),%rdi
    7219:	48 c7 44 24 10 00 00 	movq   $0x0,0x10(%rsp)
    7220:	00 00 
    7222:	e8 b9 04 00 00       	call   76e0 <fwp_file_drop>
    7227:	48 8b 44 24 40       	mov    0x40(%rsp),%rax
    722c:	4c 89 f8             	mov    %r15,%rax
    722f:	48 81 c4 78 04 00 00 	add    $0x478,%rsp
    7236:	5b                   	pop    %rbx
    7237:	41 5c                	pop    %r12
    7239:	41 5d                	pop    %r13
    723b:	41 5e                	pop    %r14
    723d:	41 5f                	pop    %r15
    723f:	5d                   	pop    %rbp
    7240:	c3                   	ret
    7241:	49 89 c6             	mov    %rax,%r14
    7244:	e8 47 f1 ff ff       	call   6390 <fwp_rc_wide_dup>
    7249:	4c 89 f0             	mov    %r14,%rax
    724c:	48 83 7c 24 38 00    	cmpq   $0x0,0x38(%rsp)
    7252:	0f 85 53 ff ff ff    	jne    71ab <fwp_p_file_with_owned+0x35b>
    7258:	e9 67 ff ff ff       	jmp    71c4 <fwp_p_file_with_owned+0x374>
    725d:	e8 fe ad ff ff       	call   2060 <abort@plt>
    7262:	e8 49 c5 ff ff       	call   37b0 <fwp_flush>
    7267:	48 8b 05 72 7d 00 00 	mov    0x7d72(%rip),%rax        # efe0 <stderr@GLIBC_2.2.5>
    726e:	48 8b 38             	mov    (%rax),%rdi
    7271:	48 8d 35 bc 50 00 00 	lea    0x50bc(%rip),%rsi        # c334 <fwp_segv.msg+0xf4>
    7278:	48 8d 15 9e 52 00 00 	lea    0x529e(%rip),%rdx        # c51d <fwp_segv.msg+0x2dd>
    727f:	31 c0                	xor    %eax,%eax
    7281:	e8 5a af ff ff       	call   21e0 <fprintf@plt>
    7286:	bf 65 00 00 00       	mov    $0x65,%edi
    728b:	e8 40 b0 ff ff       	call   22d0 <exit@plt>
    7290:	48 8b 84 24 38 01 00 	mov    0x138(%rsp),%rax
    7297:	00 
    7298:	48 8b bc 24 40 01 00 	mov    0x140(%rsp),%rdi
    729f:	00 
    72a0:	48 89 05 c9 99 00 00 	mov    %rax,0x99c9(%rip)        # 10c70 <fwp_handlers>
    72a7:	48 8b b4 24 48 01 00 	mov    0x148(%rsp),%rsi
    72ae:	00 
    72af:	e8 dc 01 00 00       	call   7490 <fwp_fail>
    72b4:	e8 b7 ad ff ff       	call   2070 <__errno_location@plt>
    72b9:	8b 38                	mov    (%rax),%edi
    72bb:	e8 60 b0 ff ff       	call   2320 <strerror@plt>
    72c0:	49 89 c0             	mov    %rax,%r8
    72c3:	48 8d 15 4c 52 00 00 	lea    0x524c(%rip),%rdx        # c516 <fwp_segv.msg+0x2d6>
    72ca:	31 c0                	xor    %eax,%eax
    72cc:	48 8d 5c 24 70       	lea    0x70(%rsp),%rbx
    72d1:	be 00 04 00 00       	mov    $0x400,%esi
    72d6:	48 89 df             	mov    %rbx,%rdi
    72d9:	4c 89 f9             	mov    %r15,%rcx
    72dc:	e8 5f ae ff ff       	call   2140 <snprintf@plt>
    72e1:	48 8d 3d 29 52 00 00 	lea    0x5229(%rip),%rdi        # c511 <fwp_segv.msg+0x2d1>
    72e8:	48 89 de             	mov    %rbx,%rsi
    72eb:	e8 30 02 00 00       	call   7520 <fwp_io_error>

00000000000072f0 <fwp_drop6>:
    72f0:	48 8b 15 e1 8e 00 00 	mov    0x8ee1(%rip),%rdx        # 101d8 <fwp_gc+0x1030>
    72f7:	48 89 f8             	mov    %rdi,%rax
    72fa:	48 29 d0             	sub    %rdx,%rax
    72fd:	48 8b 35 fc 8e 00 00 	mov    0x8efc(%rip),%rsi        # 10200 <fwp_gc+0x1058>
    7304:	48 c1 e6 10          	shl    $0x10,%rsi
    7308:	48 39 f0             	cmp    %rsi,%rax
    730b:	0f 83 b3 00 00 00    	jae    73c4 <fwp_drop6+0xd4>
    7311:	48 8b 0d 08 8f 00 00 	mov    0x8f08(%rip),%rcx        # 10220 <fwp_gc+0x1078>
    7318:	49 89 c0             	mov    %rax,%r8
    731b:	49 c1 e8 10          	shr    $0x10,%r8
    731f:	4d 69 c0 28 12 00 00 	imul   $0x1228,%r8,%r8
    7326:	46 0f b6 0c 01       	movzbl (%rcx,%r8,1),%r9d
    732b:	48 25 ff ff 00 00    	and    $0xffff,%rax
    7331:	75 12                	jne    7345 <fwp_drop6+0x55>
    7333:	41 80 f9 02          	cmp    $0x2,%r9b
    7337:	75 0c                	jne    7345 <fwp_drop6+0x55>
    7339:	4a 8d 04 01          	lea    (%rcx,%r8,1),%rax
    733d:	48 05 28 02 00 00    	add    $0x228,%rax
    7343:	eb 20                	jmp    7365 <fwp_drop6+0x75>
    7345:	41 80 f9 01          	cmp    $0x1,%r9b
    7349:	75 79                	jne    73c4 <fwp_drop6+0xd4>
    734b:	4e 8d 0c 01          	lea    (%rcx,%r8,1),%r9
    734f:	46 8b 44 01 20       	mov    0x20(%rcx,%r8,1),%r8d
    7354:	49 0f af c0          	imul   %r8,%rax
    7358:	48 c1 e8 20          	shr    $0x20,%rax
    735c:	4c 01 c8             	add    %r9,%rax
    735f:	48 05 28 02 00 00    	add    $0x228,%rax
    7365:	44 0f b6 00          	movzbl (%rax),%r8d
    7369:	45 85 c0             	test   %r8d,%r8d
    736c:	74 56                	je     73c4 <fwp_drop6+0xd4>
    736e:	41 83 f8 01          	cmp    $0x1,%r8d
    7372:	75 41                	jne    73b5 <fwp_drop6+0xc5>
    7374:	53                   	push   %rbx
    7375:	48 8b 47 08          	mov    0x8(%rdi),%rax
    7379:	49 89 c0             	mov    %rax,%r8
    737c:	49 29 d0             	sub    %rdx,%r8
    737f:	49 39 f0             	cmp    %rsi,%r8
    7382:	0f 83 86 00 00 00    	jae    740e <fwp_drop6+0x11e>
    7388:	4c 89 c2             	mov    %r8,%rdx
    738b:	48 c1 ea 10          	shr    $0x10,%rdx
    738f:	48 69 d2 28 12 00 00 	imul   $0x1228,%rdx,%rdx
    7396:	0f b6 34 11          	movzbl (%rcx,%rdx,1),%esi
    739a:	49 81 e0 ff ff 00 00 	and    $0xffff,%r8
    73a1:	75 22                	jne    73c5 <fwp_drop6+0xd5>
    73a3:	40 80 fe 02          	cmp    $0x2,%sil
    73a7:	75 1c                	jne    73c5 <fwp_drop6+0xd5>
    73a9:	48 01 d1             	add    %rdx,%rcx
    73ac:	48 81 c1 28 02 00 00 	add    $0x228,%rcx
    73b3:	eb 31                	jmp    73e6 <fwp_drop6+0xf6>
    73b5:	41 81 f8 ff 00 00 00 	cmp    $0xff,%r8d
    73bc:	74 68                	je     7426 <fwp_drop6+0x136>
    73be:	41 fe c8             	dec    %r8b
    73c1:	44 88 00             	mov    %r8b,(%rax)
    73c4:	c3                   	ret
    73c5:	40 80 fe 01          	cmp    $0x1,%sil
    73c9:	75 43                	jne    740e <fwp_drop6+0x11e>
    73cb:	48 8d 34 11          	lea    (%rcx,%rdx,1),%rsi
    73cf:	8b 4c 11 20          	mov    0x20(%rcx,%rdx,1),%ecx
    73d3:	4c 0f af c1          	imul   %rcx,%r8
    73d7:	49 c1 e8 20          	shr    $0x20,%r8
    73db:	49 8d 0c 30          	lea    (%r8,%rsi,1),%rcx
    73df:	48 81 c1 28 02 00 00 	add    $0x228,%rcx
    73e6:	0f b6 11             	movzbl (%rcx),%edx
    73e9:	85 d2                	test   %edx,%edx
    73eb:	74 21                	je     740e <fwp_drop6+0x11e>
    73ed:	83 fa 01             	cmp    $0x1,%edx
    73f0:	75 10                	jne    7402 <fwp_drop6+0x112>
    73f2:	48 89 fb             	mov    %rdi,%rbx
    73f5:	48 89 c7             	mov    %rax,%rdi
    73f8:	e8 13 f1 ff ff       	call   6510 <fwp_rc_free_obj>
    73fd:	48 89 df             	mov    %rbx,%rdi
    7400:	eb 0c                	jmp    740e <fwp_drop6+0x11e>
    7402:	81 fa ff 00 00 00    	cmp    $0xff,%edx
    7408:	74 24                	je     742e <fwp_drop6+0x13e>
    740a:	fe ca                	dec    %dl
    740c:	88 11                	mov    %dl,(%rcx)
    740e:	48 8b 47 10          	mov    0x10(%rdi),%rax
    7412:	48 89 fb             	mov    %rdi,%rbx
    7415:	48 89 c7             	mov    %rax,%rdi
    7418:	e8 c3 02 00 00       	call   76e0 <fwp_file_drop>
    741d:	48 89 df             	mov    %rbx,%rdi
    7420:	5b                   	pop    %rbx
    7421:	e9 ea f0 ff ff       	jmp    6510 <fwp_rc_free_obj>
    7426:	48 89 c7             	mov    %rax,%rdi
    7429:	e9 d2 ee ff ff       	jmp    6300 <fwp_rc_wide_drop>
    742e:	48 89 fb             	mov    %rdi,%rbx
    7431:	48 89 cf             	mov    %rcx,%rdi
    7434:	e8 c7 ee ff ff       	call   6300 <fwp_rc_wide_drop>
    7439:	eb c2                	jmp    73fd <fwp_drop6+0x10d>
    743b:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)

0000000000007440 <fwp_close_owned_scoped_file>:
    7440:	41 56                	push   %r14
    7442:	53                   	push   %rbx
    7443:	50                   	push   %rax
    7444:	48 89 fb             	mov    %rdi,%rbx
    7447:	4c 8b 77 08          	mov    0x8(%rdi),%r14
    744b:	4d 85 f6             	test   %r14,%r14
    744e:	74 16                	je     7466 <fwp_close_owned_scoped_file+0x26>
    7450:	49 8b 3e             	mov    (%r14),%rdi
    7453:	48 85 ff             	test   %rdi,%rdi
    7456:	74 16                	je     746e <fwp_close_owned_scoped_file+0x2e>
    7458:	e8 a3 ac ff ff       	call   2100 <fclose@plt>
    745d:	49 c7 06 00 00 00 00 	movq   $0x0,(%r14)
    7464:	eb 08                	jmp    746e <fwp_close_owned_scoped_file+0x2e>
    7466:	48 8b 3b             	mov    (%rbx),%rdi
    7469:	e8 92 ac ff ff       	call   2100 <fclose@plt>
    746e:	48 8b 7b 08          	mov    0x8(%rbx),%rdi
    7472:	48 c7 43 08 00 00 00 	movq   $0x0,0x8(%rbx)
    7479:	00 
    747a:	48 83 c4 08          	add    $0x8,%rsp
    747e:	5b                   	pop    %rbx
    747f:	41 5e                	pop    %r14
    7481:	e9 5a 02 00 00       	jmp    76e0 <fwp_file_drop>
    7486:	66 2e 0f 1f 84 00 00 	cs nopw 0x0(%rax,%rax,1)
    748d:	00 00 00 

0000000000007490 <fwp_fail>:
    7490:	41 57                	push   %r15
    7492:	41 56                	push   %r14
    7494:	53                   	push   %rbx
    7495:	48 8b 05 d4 97 00 00 	mov    0x97d4(%rip),%rax        # 10c70 <fwp_handlers>
    749c:	48 85 c0             	test   %rax,%rax
    749f:	75 50                	jne    74f1 <fwp_fail+0x61>
    74a1:	48 89 f3             	mov    %rsi,%rbx
    74a4:	49 89 fe             	mov    %rdi,%r14
    74a7:	e8 04 c3 ff ff       	call   37b0 <fwp_flush>
    74ac:	4c 8b 3d 2d 7b 00 00 	mov    0x7b2d(%rip),%r15        # efe0 <stderr@GLIBC_2.2.5>
    74b3:	49 8b 0f             	mov    (%r15),%rcx
    74b6:	48 8d 3d 73 50 00 00 	lea    0x5073(%rip),%rdi        # c530 <fwp_segv.msg+0x2f0>
    74bd:	be 07 00 00 00       	mov    $0x7,%esi
    74c2:	ba 01 00 00 00       	mov    $0x1,%edx
    74c7:	e8 14 ae ff ff       	call   22e0 <fwrite@plt>
    74cc:	49 8b 17             	mov    (%r15),%rdx
    74cf:	4c 89 f7             	mov    %r14,%rdi
    74d2:	48 89 de             	mov    %rbx,%rsi
    74d5:	e8 56 03 00 00       	call   7830 <fwp_display_top>
    74da:	49 8b 37             	mov    (%r15),%rsi
    74dd:	bf 0a 00 00 00       	mov    $0xa,%edi
    74e2:	e8 89 ac ff ff       	call   2170 <fputc@plt>
    74e7:	bf 01 00 00 00       	mov    $0x1,%edi
    74ec:	e8 df ad ff ff       	call   22d0 <exit@plt>
    74f1:	48 89 b8 d0 00 00 00 	mov    %rdi,0xd0(%rax)
    74f8:	48 89 b0 d8 00 00 00 	mov    %rsi,0xd8(%rax)
    74ff:	48 8b b8 e8 00 00 00 	mov    0xe8(%rax),%rdi
    7506:	e8 65 c2 ff ff       	call   3770 <fwp_cleanup_unwind>
    750b:	48 8b 3d 5e 97 00 00 	mov    0x975e(%rip),%rdi        # 10c70 <fwp_handlers>
    7512:	be 01 00 00 00       	mov    $0x1,%esi
    7517:	e8 54 ad ff ff       	call   2270 <longjmp@plt>
    751c:	0f 1f 40 00          	nopl   0x0(%rax)

0000000000007520 <fwp_io_error>:
    7520:	41 57                	push   %r15
    7522:	41 56                	push   %r14
    7524:	41 55                	push   %r13
    7526:	41 54                	push   %r12
    7528:	53                   	push   %rbx
    7529:	48 83 ec 10          	sub    $0x10,%rsp
    752d:	48 89 f3             	mov    %rsi,%rbx
    7530:	49 89 fe             	mov    %rdi,%r14
    7533:	e8 d8 ab ff ff       	call   2110 <strlen@plt>
    7538:	49 89 c7             	mov    %rax,%r15
    753b:	48 8d 50 09          	lea    0x9(%rax),%rdx
    753f:	4c 8d 2d 62 7c 00 00 	lea    0x7c62(%rip),%r13        # f1a8 <fwp_gc>
    7546:	48 81 fa 00 40 00 00 	cmp    $0x4000,%rdx
    754d:	77 54                	ja     75a3 <fwp_io_error+0x83>
    754f:	4c 89 f8             	mov    %r15,%rax
    7552:	48 83 c0 18          	add    $0x18,%rax
    7556:	48 c1 e8 04          	shr    $0x4,%rax
    755a:	42 0f b6 8c 28 e8 0b 	movzbl 0xbe8(%rax,%r13,1),%ecx
    7561:	00 00 
    7563:	41 8b 84 8d 48 0b 00 	mov    0xb48(%r13,%rcx,4),%eax
    756a:	00 
    756b:	48 29 05 36 7c 00 00 	sub    %rax,0x7c36(%rip)        # f1a8 <fwp_gc>
    7572:	78 2f                	js     75a3 <fwp_io_error+0x83>
    7574:	48 8d 0c 49          	lea    (%rcx,%rcx,2),%rcx
    7578:	48 8d 34 cd c8 03 00 	lea    0x3c8(,%rcx,8),%rsi
    757f:	00 
    7580:	4c 01 ee             	add    %r13,%rsi
    7583:	4c 8b 26             	mov    (%rsi),%r12
    7586:	4d 85 e4             	test   %r12,%r12
    7589:	75 2a                	jne    75b5 <fwp_io_error+0x95>
    758b:	4d 8b a4 cd d0 03 00 	mov    0x3d0(%r13,%rcx,8),%r12
    7592:	00 
    7593:	49 8b b4 cd d8 03 00 	mov    0x3d8(%r13,%rcx,8),%rsi
    759a:	00 
    759b:	4c 29 e6             	sub    %r12,%rsi
    759e:	48 39 c6             	cmp    %rax,%rsi
    75a1:	73 1e                	jae    75c1 <fwp_io_error+0xa1>
    75a3:	48 89 d7             	mov    %rdx,%rdi
    75a6:	be 01 00 00 00       	mov    $0x1,%esi
    75ab:	e8 c0 de ff ff       	call   5470 <fwp_gc_alloc_slow>
    75b0:	49 89 c4             	mov    %rax,%r12
    75b3:	eb 27                	jmp    75dc <fwp_io_error+0xbc>
    75b5:	49 8b 04 24          	mov    (%r12),%rax
    75b9:	48 f7 d0             	not    %rax
    75bc:	48 89 06             	mov    %rax,(%rsi)
    75bf:	eb 11                	jmp    75d2 <fwp_io_error+0xb2>
    75c1:	48 8d 0c cd d0 03 00 	lea    0x3d0(,%rcx,8),%rcx
    75c8:	00 
    75c9:	4c 01 e9             	add    %r13,%rcx
    75cc:	4c 01 e0             	add    %r12,%rax
    75cf:	48 89 01             	mov    %rax,(%rcx)
    75d2:	4c 89 e7             	mov    %r12,%rdi
    75d5:	31 f6                	xor    %esi,%esi
    75d7:	e8 84 ab ff ff       	call   2160 <memset@plt>
    75dc:	4d 89 3c 24          	mov    %r15,(%r12)
    75e0:	49 8d 7c 24 08       	lea    0x8(%r12),%rdi
    75e5:	4c 89 f6             	mov    %r14,%rsi
    75e8:	4c 89 fa             	mov    %r15,%rdx
    75eb:	e8 20 ac ff ff       	call   2210 <memcpy@plt>
    75f0:	43 c6 44 3c 08 00    	movb   $0x0,0x8(%r12,%r15,1)
    75f6:	4c 89 24 24          	mov    %r12,(%rsp)
    75fa:	48 89 df             	mov    %rbx,%rdi
    75fd:	e8 0e ab ff ff       	call   2110 <strlen@plt>
    7602:	49 89 c6             	mov    %rax,%r14
    7605:	48 8d 50 09          	lea    0x9(%rax),%rdx
    7609:	48 81 fa 00 40 00 00 	cmp    $0x4000,%rdx
    7610:	77 54                	ja     7666 <fwp_io_error+0x146>
    7612:	4c 89 f0             	mov    %r14,%rax
    7615:	48 83 c0 18          	add    $0x18,%rax
    7619:	48 c1 e8 04          	shr    $0x4,%rax
    761d:	42 0f b6 8c 28 e8 0b 	movzbl 0xbe8(%rax,%r13,1),%ecx
    7624:	00 00 
    7626:	41 8b 84 8d 48 0b 00 	mov    0xb48(%r13,%rcx,4),%eax
    762d:	00 
    762e:	48 29 05 73 7b 00 00 	sub    %rax,0x7b73(%rip)        # f1a8 <fwp_gc>
    7635:	78 2f                	js     7666 <fwp_io_error+0x146>
    7637:	48 8d 0c 49          	lea    (%rcx,%rcx,2),%rcx
    763b:	48 8d 34 cd c8 03 00 	lea    0x3c8(,%rcx,8),%rsi
    7642:	00 
    7643:	4c 01 ee             	add    %r13,%rsi
    7646:	4c 8b 3e             	mov    (%rsi),%r15
    7649:	4d 85 ff             	test   %r15,%r15
    764c:	75 2a                	jne    7678 <fwp_io_error+0x158>
    764e:	4d 8b bc cd d0 03 00 	mov    0x3d0(%r13,%rcx,8),%r15
    7655:	00 
    7656:	49 8b b4 cd d8 03 00 	mov    0x3d8(%r13,%rcx,8),%rsi
    765d:	00 
    765e:	4c 29 fe             	sub    %r15,%rsi
    7661:	48 39 c6             	cmp    %rax,%rsi
    7664:	73 1d                	jae    7683 <fwp_io_error+0x163>
    7666:	48 89 d7             	mov    %rdx,%rdi
    7669:	be 01 00 00 00       	mov    $0x1,%esi
    766e:	e8 fd dd ff ff       	call   5470 <fwp_gc_alloc_slow>
    7673:	49 89 c7             	mov    %rax,%r15
    7676:	eb 26                	jmp    769e <fwp_io_error+0x17e>
    7678:	49 8b 07             	mov    (%r15),%rax
    767b:	48 f7 d0             	not    %rax
    767e:	48 89 06             	mov    %rax,(%rsi)
    7681:	eb 11                	jmp    7694 <fwp_io_error+0x174>
    7683:	48 8d 0c cd d0 03 00 	lea    0x3d0(,%rcx,8),%rcx
    768a:	00 
    768b:	4c 01 e9             	add    %r13,%rcx
    768e:	4c 01 f8             	add    %r15,%rax
    7691:	48 89 01             	mov    %rax,(%rcx)
    7694:	4c 89 ff             	mov    %r15,%rdi
    7697:	31 f6                	xor    %esi,%esi
    7699:	e8 c2 aa ff ff       	call   2160 <memset@plt>
    769e:	4d 89 37             	mov    %r14,(%r15)
    76a1:	49 8d 7f 08          	lea    0x8(%r15),%rdi
    76a5:	48 89 de             	mov    %rbx,%rsi
    76a8:	4c 89 f2             	mov    %r14,%rdx
    76ab:	e8 60 ab ff ff       	call   2210 <memcpy@plt>
    76b0:	43 c6 44 37 08 00    	movb   $0x0,0x8(%r15,%r14,1)
    76b6:	4c 89 7c 24 08       	mov    %r15,0x8(%rsp)
    76bb:	48 89 e2             	mov    %rsp,%rdx
    76be:	31 ff                	xor    %edi,%edi
    76c0:	be 02 00 00 00       	mov    $0x2,%esi
    76c5:	e8 06 cb ff ff       	call   41d0 <fwp_data>
    76ca:	48 8d 35 df 74 00 00 	lea    0x74df(%rip),%rsi        # ebb0 <d0>
    76d1:	48 89 c7             	mov    %rax,%rdi
    76d4:	e8 b7 fd ff ff       	call   7490 <fwp_fail>
    76d9:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)

00000000000076e0 <fwp_file_drop>:
    76e0:	48 85 ff             	test   %rdi,%rdi
    76e3:	0f 84 3f 01 00 00    	je     7828 <fwp_file_drop+0x148>
    76e9:	53                   	push   %rbx
    76ea:	48 8b 47 08          	mov    0x8(%rdi),%rax
    76ee:	48 85 c0             	test   %rax,%rax
    76f1:	0f 84 30 01 00 00    	je     7827 <fwp_file_drop+0x147>
    76f7:	48 ff c8             	dec    %rax
    76fa:	48 89 47 08          	mov    %rax,0x8(%rdi)
    76fe:	0f 85 23 01 00 00    	jne    7827 <fwp_file_drop+0x147>
    7704:	48 8b 07             	mov    (%rdi),%rax
    7707:	48 85 c0             	test   %rax,%rax
    770a:	74 15                	je     7721 <fwp_file_drop+0x41>
    770c:	48 89 fb             	mov    %rdi,%rbx
    770f:	48 89 c7             	mov    %rax,%rdi
    7712:	e8 e9 a9 ff ff       	call   2100 <fclose@plt>
    7717:	48 89 df             	mov    %rbx,%rdi
    771a:	48 c7 03 00 00 00 00 	movq   $0x0,(%rbx)
    7721:	48 89 f8             	mov    %rdi,%rax
    7724:	48 2b 05 ad 8a 00 00 	sub    0x8aad(%rip),%rax        # 101d8 <fwp_gc+0x1030>
    772b:	48 8b 0d ce 8a 00 00 	mov    0x8ace(%rip),%rcx        # 10200 <fwp_gc+0x1058>
    7732:	48 c1 e1 10          	shl    $0x10,%rcx
    7736:	48 39 c8             	cmp    %rcx,%rax
    7739:	0f 83 e8 00 00 00    	jae    7827 <fwp_file_drop+0x147>
    773f:	48 8b 0d da 8a 00 00 	mov    0x8ada(%rip),%rcx        # 10220 <fwp_gc+0x1078>
    7746:	48 89 c2             	mov    %rax,%rdx
    7749:	48 c1 ea 10          	shr    $0x10,%rdx
    774d:	48 69 d2 28 12 00 00 	imul   $0x1228,%rdx,%rdx
    7754:	0f b6 34 11          	movzbl (%rcx,%rdx,1),%esi
    7758:	48 25 ff ff 00 00    	and    $0xffff,%rax
    775e:	75 1a                	jne    777a <fwp_file_drop+0x9a>
    7760:	40 80 fe 02          	cmp    $0x2,%sil
    7764:	75 14                	jne    777a <fwp_file_drop+0x9a>
    7766:	48 8d 04 11          	lea    (%rcx,%rdx,1),%rax
    776a:	48 05 28 02 00 00    	add    $0x228,%rax
    7770:	80 38 01             	cmpb   $0x1,(%rax)
    7773:	74 31                	je     77a6 <fwp_file_drop+0xc6>
    7775:	e9 ad 00 00 00       	jmp    7827 <fwp_file_drop+0x147>
    777a:	40 80 fe 01          	cmp    $0x1,%sil
    777e:	0f 85 a3 00 00 00    	jne    7827 <fwp_file_drop+0x147>
    7784:	48 8d 34 11          	lea    (%rcx,%rdx,1),%rsi
    7788:	8b 4c 11 20          	mov    0x20(%rcx,%rdx,1),%ecx
    778c:	48 0f af c1          	imul   %rcx,%rax
    7790:	48 c1 e8 20          	shr    $0x20,%rax
    7794:	48 01 f0             	add    %rsi,%rax
    7797:	48 05 28 02 00 00    	add    $0x228,%rax
    779d:	80 38 01             	cmpb   $0x1,(%rax)
    77a0:	0f 85 81 00 00 00    	jne    7827 <fwp_file_drop+0x147>
    77a6:	8b 0d 1c 94 00 00    	mov    0x941c(%rip),%ecx        # 10bc8 <fwp_reuse_verify>
    77ac:	85 c9                	test   %ecx,%ecx
    77ae:	79 42                	jns    77f2 <fwp_file_drop+0x112>
    77b0:	48 89 fb             	mov    %rdi,%rbx
    77b3:	48 8d 3d 26 4c 00 00 	lea    0x4c26(%rip),%rdi        # c3e0 <fwp_segv.msg+0x1a0>
    77ba:	e8 71 a8 ff ff       	call   2030 <getenv@plt>
    77bf:	31 c9                	xor    %ecx,%ecx
    77c1:	48 85 c0             	test   %rax,%rax
    77c4:	74 23                	je     77e9 <fwp_file_drop+0x109>
    77c6:	80 38 00             	cmpb   $0x0,(%rax)
    77c9:	48 89 df             	mov    %rbx,%rdi
    77cc:	74 1e                	je     77ec <fwp_file_drop+0x10c>
    77ce:	48 8d 35 da 4d 00 00 	lea    0x4dda(%rip),%rsi        # c5af <fwp_segv.msg+0x36f>
    77d5:	48 89 c7             	mov    %rax,%rdi
    77d8:	e8 e3 a9 ff ff       	call   21c0 <strcmp@plt>
    77dd:	48 89 df             	mov    %rbx,%rdi
    77e0:	31 c9                	xor    %ecx,%ecx
    77e2:	85 c0                	test   %eax,%eax
    77e4:	0f 95 c1             	setne  %cl
    77e7:	eb 03                	jmp    77ec <fwp_file_drop+0x10c>
    77e9:	48 89 df             	mov    %rbx,%rdi
    77ec:	89 0d d6 93 00 00    	mov    %ecx,0x93d6(%rip)        # 10bc8 <fwp_reuse_verify>
    77f2:	85 c9                	test   %ecx,%ecx
    77f4:	74 06                	je     77fc <fwp_file_drop+0x11c>
    77f6:	c6 47 10 00          	movb   $0x0,0x10(%rdi)
    77fa:	eb 2b                	jmp    7827 <fwp_file_drop+0x147>
    77fc:	48 8b 1d a5 79 00 00 	mov    0x79a5(%rip),%rbx        # f1a8 <fwp_gc>
    7803:	e8 e8 ee ff ff       	call   66f0 <fwp_mem_free>
    7808:	48 8b 05 99 79 00 00 	mov    0x7999(%rip),%rax        # f1a8 <fwp_gc>
    780f:	48 29 d8             	sub    %rbx,%rax
    7812:	f2 48 0f 2a c0       	cvtsi2sd %rax,%xmm0
    7817:	f2 0f 58 05 91 8b 00 	addsd  0x8b91(%rip),%xmm0        # 103b0 <fwp_gc+0x1208>
    781e:	00 
    781f:	f2 0f 11 05 89 8b 00 	movsd  %xmm0,0x8b89(%rip)        # 103b0 <fwp_gc+0x1208>
    7826:	00 
    7827:	5b                   	pop    %rbx
    7828:	c3                   	ret
    7829:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)

0000000000007830 <fwp_display_top>:
    7830:	53                   	push   %rbx
    7831:	48 83 ec 20          	sub    $0x20,%rsp
    7835:	48 89 d3             	mov    %rdx,%rbx
    7838:	48 89 f2             	mov    %rsi,%rdx
    783b:	48 89 fe             	mov    %rdi,%rsi
    783e:	0f 57 c0             	xorps  %xmm0,%xmm0
    7841:	0f 29 04 24          	movaps %xmm0,(%rsp)
    7845:	48 c7 44 24 10 00 00 	movq   $0x0,0x10(%rsp)
    784c:	00 00 
    784e:	48 89 e7             	mov    %rsp,%rdi
    7851:	b9 01 00 00 00       	mov    $0x1,%ecx
    7856:	e8 35 00 00 00       	call   7890 <fwp_write>
    785b:	48 8b 3c 24          	mov    (%rsp),%rdi
    785f:	48 85 ff             	test   %rdi,%rdi
    7862:	74 18                	je     787c <fwp_display_top+0x4c>
    7864:	48 8b 54 24 08       	mov    0x8(%rsp),%rdx
    7869:	be 01 00 00 00       	mov    $0x1,%esi
    786e:	48 89 d9             	mov    %rbx,%rcx
    7871:	e8 6a aa ff ff       	call   22e0 <fwrite@plt>
    7876:	48 8b 3c 24          	mov    (%rsp),%rdi
    787a:	eb 02                	jmp    787e <fwp_display_top+0x4e>
    787c:	31 ff                	xor    %edi,%edi
    787e:	e8 cd a7 ff ff       	call   2050 <free@plt>
    7883:	48 83 c4 20          	add    $0x20,%rsp
    7887:	5b                   	pop    %rbx
    7888:	c3                   	ret
    7889:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)

0000000000007890 <fwp_write>:
    7890:	55                   	push   %rbp
    7891:	41 57                	push   %r15
    7893:	41 56                	push   %r14
    7895:	41 55                	push   %r13
    7897:	41 54                	push   %r12
    7899:	53                   	push   %rbx
    789a:	48 81 ec 78 02 00 00 	sub    $0x278,%rsp
    78a1:	8b 02                	mov    (%rdx),%eax
    78a3:	48 83 f8 19          	cmp    $0x19,%rax
    78a7:	0f 87 26 12 00 00    	ja     8ad3 <fwp_write+0x1243>
    78ad:	49 89 d7             	mov    %rdx,%r15
    78b0:	49 89 f6             	mov    %rsi,%r14
    78b3:	48 89 fd             	mov    %rdi,%rbp
    78b6:	48 8d 15 53 48 00 00 	lea    0x4853(%rip),%rdx        # c110 <_IO_stdin_used+0x110>
    78bd:	48 63 34 82          	movslq (%rdx,%rax,4),%rsi
    78c1:	48 01 d6             	add    %rdx,%rsi
    78c4:	48 89 3c 24          	mov    %rdi,(%rsp)
    78c8:	ff e6                	jmp    *%rsi
    78ca:	48 8d 15 67 4c 00 00 	lea    0x4c67(%rip),%rdx        # c538 <fwp_segv.msg+0x2f8>
    78d1:	eb 07                	jmp    78da <fwp_write+0x4a>
    78d3:	48 8d 15 63 4c 00 00 	lea    0x4c63(%rip),%rdx        # c53d <fwp_segv.msg+0x2fd>
    78da:	4c 8d 7c 24 70       	lea    0x70(%rsp),%r15
    78df:	be 00 02 00 00       	mov    $0x200,%esi
    78e4:	4c 89 ff             	mov    %r15,%rdi
    78e7:	4c 89 f1             	mov    %r14,%rcx
    78ea:	31 c0                	xor    %eax,%eax
    78ec:	e8 4f a8 ff ff       	call   2140 <snprintf@plt>
    78f1:	4c 89 ff             	mov    %r15,%rdi
    78f4:	e8 17 a8 ff ff       	call   2110 <strlen@plt>
    78f9:	48 89 ef             	mov    %rbp,%rdi
    78fc:	4c 89 fe             	mov    %r15,%rsi
    78ff:	e9 c7 11 00 00       	jmp    8acb <fwp_write+0x123b>
    7904:	83 f8 13             	cmp    $0x13,%eax
    7907:	48 8d 05 69 4c 00 00 	lea    0x4c69(%rip),%rax        # c577 <fwp_segv.msg+0x337>
    790e:	48 8d 35 67 4c 00 00 	lea    0x4c67(%rip),%rsi        # c57c <fwp_segv.msg+0x33c>
    7915:	48 0f 44 f0          	cmove  %rax,%rsi
    7919:	ba 04 00 00 00       	mov    $0x4,%edx
    791e:	48 89 ef             	mov    %rbp,%rdi
    7921:	e8 4a 13 00 00       	call   8c70 <buf_put>
    7926:	49 83 3e 00          	cmpq   $0x0,(%r14)
    792a:	0f 84 c3 00 00 00    	je     79f3 <fwp_write+0x163>
    7930:	49 8b 57 38          	mov    0x38(%r15),%rdx
    7934:	49 8b 76 08          	mov    0x8(%r14),%rsi
    7938:	48 8b 1c 24          	mov    (%rsp),%rbx
    793c:	48 89 df             	mov    %rbx,%rdi
    793f:	31 c9                	xor    %ecx,%ecx
    7941:	e8 4a ff ff ff       	call   7890 <fwp_write>
    7946:	41 83 3f 12          	cmpl   $0x12,(%r15)
    794a:	75 26                	jne    7972 <fwp_write+0xe2>
    794c:	48 8d 35 e2 4b 00 00 	lea    0x4be2(%rip),%rsi        # c535 <fwp_segv.msg+0x2f5>
    7953:	ba 02 00 00 00       	mov    $0x2,%edx
    7958:	48 89 df             	mov    %rbx,%rdi
    795b:	e8 10 13 00 00       	call   8c70 <buf_put>
    7960:	49 8b 76 10          	mov    0x10(%r14),%rsi
    7964:	49 8b 57 40          	mov    0x40(%r15),%rdx
    7968:	48 89 df             	mov    %rbx,%rdi
    796b:	31 c9                	xor    %ecx,%ecx
    796d:	e8 1e ff ff ff       	call   7890 <fwp_write>
    7972:	49 83 3e 02          	cmpq   $0x2,(%r14)
    7976:	72 7b                	jb     79f3 <fwp_write+0x163>
    7978:	49 8d 5e 20          	lea    0x20(%r14),%rbx
    797c:	bd 01 00 00 00       	mov    $0x1,%ebp
    7981:	4c 8d 25 e2 4b 00 00 	lea    0x4be2(%rip),%r12        # c56a <fwp_segv.msg+0x32a>
    7988:	eb 12                	jmp    799c <fwp_write+0x10c>
    798a:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)
    7990:	48 ff c5             	inc    %rbp
    7993:	48 83 c3 10          	add    $0x10,%rbx
    7997:	49 3b 2e             	cmp    (%r14),%rbp
    799a:	73 57                	jae    79f3 <fwp_write+0x163>
    799c:	ba 02 00 00 00       	mov    $0x2,%edx
    79a1:	4c 8b 2c 24          	mov    (%rsp),%r13
    79a5:	4c 89 ef             	mov    %r13,%rdi
    79a8:	4c 89 e6             	mov    %r12,%rsi
    79ab:	e8 c0 12 00 00       	call   8c70 <buf_put>
    79b0:	48 8b 73 f8          	mov    -0x8(%rbx),%rsi
    79b4:	49 8b 57 38          	mov    0x38(%r15),%rdx
    79b8:	4c 89 ef             	mov    %r13,%rdi
    79bb:	31 c9                	xor    %ecx,%ecx
    79bd:	e8 ce fe ff ff       	call   7890 <fwp_write>
    79c2:	41 83 3f 12          	cmpl   $0x12,(%r15)
    79c6:	75 c8                	jne    7990 <fwp_write+0x100>
    79c8:	ba 02 00 00 00       	mov    $0x2,%edx
    79cd:	4c 8b 2c 24          	mov    (%rsp),%r13
    79d1:	4c 89 ef             	mov    %r13,%rdi
    79d4:	48 8d 35 5a 4b 00 00 	lea    0x4b5a(%rip),%rsi        # c535 <fwp_segv.msg+0x2f5>
    79db:	e8 90 12 00 00       	call   8c70 <buf_put>
    79e0:	48 8b 33             	mov    (%rbx),%rsi
    79e3:	49 8b 57 40          	mov    0x40(%r15),%rdx
    79e7:	4c 89 ef             	mov    %r13,%rdi
    79ea:	31 c9                	xor    %ecx,%ecx
    79ec:	e8 9f fe ff ff       	call   7890 <fwp_write>
    79f1:	eb 9d                	jmp    7990 <fwp_write+0x100>
    79f3:	c6 44 24 70 7d       	movb   $0x7d,0x70(%rsp)
    79f8:	48 8d 74 24 70       	lea    0x70(%rsp),%rsi
    79fd:	ba 01 00 00 00       	mov    $0x1,%edx
    7a02:	48 8b 3c 24          	mov    (%rsp),%rdi
    7a06:	e9 c3 10 00 00       	jmp    8ace <fwp_write+0x123e>
    7a0b:	4d 8b 67 08          	mov    0x8(%r15),%r12
    7a0f:	4d 85 e4             	test   %r12,%r12
    7a12:	0f 84 af 06 00 00    	je     80c7 <fwp_write+0x837>
    7a18:	48 8d 35 62 4b 00 00 	lea    0x4b62(%rip),%rsi        # c581 <fwp_segv.msg+0x341>
    7a1f:	4c 89 e7             	mov    %r12,%rdi
    7a22:	e8 99 a7 ff ff       	call   21c0 <strcmp@plt>
    7a27:	85 c0                	test   %eax,%eax
    7a29:	0f 84 36 0b 00 00    	je     8565 <fwp_write+0xcd5>
    7a2f:	4d 8d 6f 10          	lea    0x10(%r15),%r13
    7a33:	4c 89 e7             	mov    %r12,%rdi
    7a36:	e8 d5 a6 ff ff       	call   2110 <strlen@plt>
    7a3b:	48 89 ef             	mov    %rbp,%rdi
    7a3e:	4c 89 e6             	mov    %r12,%rsi
    7a41:	48 89 c2             	mov    %rax,%rdx
    7a44:	e8 27 12 00 00       	call   8c70 <buf_put>
    7a49:	c6 44 24 70 20       	movb   $0x20,0x70(%rsp)
    7a4e:	48 8d 74 24 70       	lea    0x70(%rsp),%rsi
    7a53:	ba 01 00 00 00       	mov    $0x1,%edx
    7a58:	48 89 ef             	mov    %rbp,%rdi
    7a5b:	e8 10 12 00 00       	call   8c70 <buf_put>
    7a60:	31 db                	xor    %ebx,%ebx
    7a62:	e9 7f 06 00 00       	jmp    80e6 <fwp_write+0x856>
    7a67:	49 81 fe ff 0f 00 00 	cmp    $0xfff,%r14
    7a6e:	0f 87 00 05 00 00    	ja     7f74 <fwp_write+0x6e4>
    7a74:	44 89 f0             	mov    %r14d,%eax
    7a77:	e9 fb 04 00 00       	jmp    7f77 <fwp_write+0x6e7>
    7a7c:	66 49 0f 6e ce       	movq   %r14,%xmm1
    7a81:	66 0f 2e c9          	ucomisd %xmm1,%xmm1
    7a85:	0f 8a d2 11 00 00    	jp     8c5d <fwp_write+0x13cd>
    7a8b:	66 0f 28 05 2d 46 00 	movapd 0x462d(%rip),%xmm0        # c0c0 <_IO_stdin_used+0xc0>
    7a92:	00 
    7a93:	66 0f 54 c1          	andpd  %xmm1,%xmm0
    7a97:	66 0f 2e 05 61 46 00 	ucomisd 0x4661(%rip),%xmm0        # c100 <_IO_stdin_used+0x100>
    7a9e:	00 
    7a9f:	0f 82 66 08 00 00    	jb     830b <fwp_write+0xa7b>
    7aa5:	66 0f 57 c0          	xorpd  %xmm0,%xmm0
    7aa9:	66 0f 2e c8          	ucomisd %xmm0,%xmm1
    7aad:	e9 55 04 00 00       	jmp    7f07 <fwp_write+0x677>
    7ab2:	c6 44 24 70 3c       	movb   $0x3c,0x70(%rsp)
    7ab7:	48 8d 74 24 70       	lea    0x70(%rsp),%rsi
    7abc:	ba 01 00 00 00       	mov    $0x1,%edx
    7ac1:	48 89 ef             	mov    %rbp,%rdi
    7ac4:	e8 a7 11 00 00       	call   8c70 <buf_put>
    7ac9:	4d 8b 77 08          	mov    0x8(%r15),%r14
    7acd:	e9 82 04 00 00       	jmp    7f54 <fwp_write+0x6c4>
    7ad2:	48 8d 35 7a 4a 00 00 	lea    0x4a7a(%rip),%rsi        # c553 <fwp_segv.msg+0x313>
    7ad9:	ba 08 00 00 00       	mov    $0x8,%edx
    7ade:	48 89 ef             	mov    %rbp,%rdi
    7ae1:	e9 5c 0d 00 00       	jmp    8842 <fwp_write+0xfb2>
    7ae6:	49 8d 76 08          	lea    0x8(%r14),%rsi
    7aea:	49 8b 16             	mov    (%r14),%rdx
    7aed:	85 c9                	test   %ecx,%ecx
    7aef:	0f 84 13 07 00 00    	je     8208 <fwp_write+0x978>
    7af5:	48 89 ef             	mov    %rbp,%rdi
    7af8:	e9 45 0d 00 00       	jmp    8842 <fwp_write+0xfb2>
    7afd:	4d 8b 0e             	mov    (%r14),%r9
    7b00:	4d 8b 46 08          	mov    0x8(%r14),%r8
    7b04:	4c 89 c8             	mov    %r9,%rax
    7b07:	4c 09 c0             	or     %r8,%rax
    7b0a:	0f 84 11 07 00 00    	je     8221 <fwp_write+0x991>
    7b10:	31 ff                	xor    %edi,%edi
    7b12:	49 ba cd cc cc cc cc 	movabs $0xcccccccccccccccd,%r10
    7b19:	cc cc cc 
    7b1c:	49 bb cc cc cc cc cc 	movabs $0xcccccccccccccccc,%r11
    7b23:	cc cc cc 
    7b26:	4c 89 c3             	mov    %r8,%rbx
    7b29:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)
    7b30:	4c 89 c1             	mov    %r8,%rcx
    7b33:	4c 0f a4 c9 3f       	shld   $0x3f,%r9,%rcx
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
    7b7e:	44 89 ca             	mov    %r9d,%edx
    7b81:	29 ca                	sub    %ecx,%edx
    7b83:	80 ca 30             	or     $0x30,%dl
    7b86:	88 54 3c 20          	mov    %dl,0x20(%rsp,%rdi,1)
    7b8a:	48 ff c7             	inc    %rdi
    7b8d:	49 83 f9 0a          	cmp    $0xa,%r9
    7b91:	49 83 d8 00          	sbb    $0x0,%r8
    7b95:	49 89 c1             	mov    %rax,%r9
    7b98:	49 89 d8             	mov    %rbx,%r8
    7b9b:	73 93                	jae    7b30 <fwp_write+0x2a0>
    7b9d:	85 ff                	test   %edi,%edi
    7b9f:	0f 8f 86 06 00 00    	jg     822b <fwp_write+0x99b>
    7ba5:	e9 ab 00 00 00       	jmp    7c55 <fwp_write+0x3c5>
    7baa:	4d 8b 06             	mov    (%r14),%r8
    7bad:	4d 8b 4e 08          	mov    0x8(%r14),%r9
    7bb1:	4d 85 c9             	test   %r9,%r9
    7bb4:	0f 88 93 06 00 00    	js     824d <fwp_write+0x9bd>
    7bba:	4c 89 c0             	mov    %r8,%rax
    7bbd:	4c 09 c8             	or     %r9,%rax
    7bc0:	0f 84 bc 09 00 00    	je     8582 <fwp_write+0xcf2>
    7bc6:	31 ff                	xor    %edi,%edi
    7bc8:	49 ba cd cc cc cc cc 	movabs $0xcccccccccccccccd,%r10
    7bcf:	cc cc cc 
    7bd2:	49 bb cc cc cc cc cc 	movabs $0xcccccccccccccccc,%r11
    7bd9:	cc cc cc 
    7bdc:	4c 89 cb             	mov    %r9,%rbx
    7bdf:	90                   	nop
    7be0:	4c 89 c9             	mov    %r9,%rcx
    7be3:	4c 0f a4 c1 3f       	shld   $0x3f,%r8,%rcx
    7be8:	48 d1 eb             	shr    $1,%rbx
    7beb:	48 89 ce             	mov    %rcx,%rsi
    7bee:	48 01 de             	add    %rbx,%rsi
    7bf1:	48 83 d6 00          	adc    $0x0,%rsi
    7bf5:	48 89 f0             	mov    %rsi,%rax
    7bf8:	49 f7 e2             	mul    %r10
    7bfb:	48 c1 ea 02          	shr    $0x2,%rdx
    7bff:	48 8d 04 92          	lea    (%rdx,%rdx,4),%rax
    7c03:	48 29 c6             	sub    %rax,%rsi
    7c06:	48 29 f1             	sub    %rsi,%rcx
    7c09:	48 83 db 00          	sbb    $0x0,%rbx
    7c0d:	48 89 ce             	mov    %rcx,%rsi
    7c10:	49 0f af f3          	imul   %r11,%rsi
    7c14:	48 89 c8             	mov    %rcx,%rax
    7c17:	49 f7 e2             	mul    %r10
    7c1a:	48 01 f2             	add    %rsi,%rdx
    7c1d:	49 0f af da          	imul   %r10,%rbx
    7c21:	48 01 d3             	add    %rdx,%rbx
    7c24:	48 89 c1             	mov    %rax,%rcx
    7c27:	48 01 c1             	add    %rax,%rcx
    7c2a:	48 8d 0c 89          	lea    (%rcx,%rcx,4),%rcx
    7c2e:	44 89 c2             	mov    %r8d,%edx
    7c31:	29 ca                	sub    %ecx,%edx
    7c33:	80 ca 30             	or     $0x30,%dl
    7c36:	88 54 3c 20          	mov    %dl,0x20(%rsp,%rdi,1)
    7c3a:	48 ff c7             	inc    %rdi
    7c3d:	49 83 f8 0a          	cmp    $0xa,%r8
    7c41:	49 83 d9 00          	sbb    $0x0,%r9
    7c45:	49 89 c0             	mov    %rax,%r8
    7c48:	49 89 d9             	mov    %rbx,%r9
    7c4b:	73 93                	jae    7be0 <fwp_write+0x350>
    7c4d:	85 ff                	test   %edi,%edi
    7c4f:	0f 8f 37 09 00 00    	jg     858c <fwp_write+0xcfc>
    7c55:	31 c0                	xor    %eax,%eax
    7c57:	e9 57 0e 00 00       	jmp    8ab3 <fwp_write+0x1223>
    7c5c:	c6 44 24 70 5b       	movb   $0x5b,0x70(%rsp)
    7c61:	48 8d 74 24 70       	lea    0x70(%rsp),%rsi
    7c66:	ba 01 00 00 00       	mov    $0x1,%edx
    7c6b:	48 89 ef             	mov    %rbp,%rdi
    7c6e:	e8 fd 0f 00 00       	call   8c70 <buf_put>
    7c73:	4d 85 f6             	test   %r14,%r14
    7c76:	0f 84 e6 0c 00 00    	je     8962 <fwp_write+0x10d2>
    7c7c:	49 8b 57 38          	mov    0x38(%r15),%rdx
    7c80:	49 8b 76 08          	mov    0x8(%r14),%rsi
    7c84:	48 89 ef             	mov    %rbp,%rdi
    7c87:	31 c9                	xor    %ecx,%ecx
    7c89:	e8 02 fc ff ff       	call   7890 <fwp_write>
    7c8e:	49 8b 5e 10          	mov    0x10(%r14),%rbx
    7c92:	48 85 db             	test   %rbx,%rbx
    7c95:	0f 84 c7 0c 00 00    	je     8962 <fwp_write+0x10d2>
    7c9b:	4c 8d 35 c8 48 00 00 	lea    0x48c8(%rip),%r14        # c56a <fwp_segv.msg+0x32a>
    7ca2:	66 66 66 66 66 2e 0f 	data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    7ca9:	1f 84 00 00 00 00 00 
    7cb0:	ba 02 00 00 00       	mov    $0x2,%edx
    7cb5:	48 89 ef             	mov    %rbp,%rdi
    7cb8:	4c 89 f6             	mov    %r14,%rsi
    7cbb:	e8 b0 0f 00 00       	call   8c70 <buf_put>
    7cc0:	48 8b 73 08          	mov    0x8(%rbx),%rsi
    7cc4:	49 8b 57 38          	mov    0x38(%r15),%rdx
    7cc8:	48 89 ef             	mov    %rbp,%rdi
    7ccb:	31 c9                	xor    %ecx,%ecx
    7ccd:	e8 be fb ff ff       	call   7890 <fwp_write>
    7cd2:	48 8b 5b 10          	mov    0x10(%rbx),%rbx
    7cd6:	48 85 db             	test   %rbx,%rbx
    7cd9:	75 d5                	jne    7cb0 <fwp_write+0x420>
    7cdb:	e9 82 0c 00 00       	jmp    8962 <fwp_write+0x10d2>
    7ce0:	4d 63 67 48          	movslq 0x48(%r15),%r12
    7ce4:	44 89 e3             	mov    %r12d,%ebx
    7ce7:	49 8d 54 24 03       	lea    0x3(%r12),%rdx
    7cec:	48 81 fa 00 40 00 00 	cmp    $0x4000,%rdx
    7cf3:	0f 87 57 08 00 00    	ja     8550 <fwp_write+0xcc0>
    7cf9:	49 8d 4c 24 12       	lea    0x12(%r12),%rcx
    7cfe:	48 c1 e9 04          	shr    $0x4,%rcx
    7d02:	48 8d 05 9f 74 00 00 	lea    0x749f(%rip),%rax        # f1a8 <fwp_gc>
    7d09:	0f b6 b4 01 e8 0b 00 	movzbl 0xbe8(%rcx,%rax,1),%esi
    7d10:	00 
    7d11:	8b 8c b0 48 0b 00 00 	mov    0xb48(%rax,%rsi,4),%ecx
    7d18:	48 29 0d 89 74 00 00 	sub    %rcx,0x7489(%rip)        # f1a8 <fwp_gc>
    7d1f:	0f 88 2b 08 00 00    	js     8550 <fwp_write+0xcc0>
    7d25:	48 8d 34 76          	lea    (%rsi,%rsi,2),%rsi
    7d29:	48 8d 3c f0          	lea    (%rax,%rsi,8),%rdi
    7d2d:	48 81 c7 c8 03 00 00 	add    $0x3c8,%rdi
    7d34:	4c 8b 3f             	mov    (%rdi),%r15
    7d37:	4d 85 ff             	test   %r15,%r15
    7d3a:	0f 84 f4 07 00 00    	je     8534 <fwp_write+0xca4>
    7d40:	49 8b 07             	mov    (%r15),%rax
    7d43:	48 f7 d0             	not    %rax
    7d46:	48 89 07             	mov    %rax,(%rdi)
    7d49:	e9 2d 0a 00 00       	jmp    877b <fwp_write+0xeeb>
    7d4e:	49 83 fe ff          	cmp    $0xffffffffffffffff,%r14
    7d52:	48 8d 05 ec 47 00 00 	lea    0x47ec(%rip),%rax        # c545 <fwp_segv.msg+0x305>
    7d59:	48 8d 0d 4f 48 00 00 	lea    0x484f(%rip),%rcx        # c5af <fwp_segv.msg+0x36f>
    7d60:	48 0f 44 c8          	cmove  %rax,%rcx
    7d64:	49 83 fe 01          	cmp    $0x1,%r14
    7d68:	4c 8d 35 d3 47 00 00 	lea    0x47d3(%rip),%r14        # c542 <fwp_segv.msg+0x302>
    7d6f:	4c 0f 45 f1          	cmovne %rcx,%r14
    7d73:	4c 89 f7             	mov    %r14,%rdi
    7d76:	e8 95 a3 ff ff       	call   2110 <strlen@plt>
    7d7b:	48 89 ef             	mov    %rbp,%rdi
    7d7e:	4c 89 f6             	mov    %r14,%rsi
    7d81:	e9 b9 0a 00 00       	jmp    883f <fwp_write+0xfaf>
    7d86:	48 8d 35 e3 47 00 00 	lea    0x47e3(%rip),%rsi        # c570 <fwp_segv.msg+0x330>
    7d8d:	ba 06 00 00 00       	mov    $0x6,%edx
    7d92:	48 89 ef             	mov    %rbp,%rdi
    7d95:	e8 d6 0e 00 00       	call   8c70 <buf_put>
    7d9a:	49 8b 36             	mov    (%r14),%rsi
    7d9d:	48 8d 04 75 00 00 00 	lea    0x0(,%rsi,2),%rax
    7da4:	00 
    7da5:	48 85 c0             	test   %rax,%rax
    7da8:	0f 84 b4 0b 00 00    	je     8962 <fwp_write+0x10d2>
    7dae:	49 8b 57 38          	mov    0x38(%r15),%rdx
    7db2:	b8 08 00 00 00       	mov    $0x8,%eax
    7db7:	48 85 d2             	test   %rdx,%rdx
    7dba:	74 13                	je     7dcf <fwp_write+0x53f>
    7dbc:	8b 0a                	mov    (%rdx),%ecx
    7dbe:	48 83 f9 0a          	cmp    $0xa,%rcx
    7dc2:	77 0b                	ja     7dcf <fwp_write+0x53f>
    7dc4:	48 8d 05 95 44 00 00 	lea    0x4495(%rip),%rax        # c260 <fwp_segv.msg+0x20>
    7dcb:	48 8b 04 c8          	mov    (%rax,%rcx,8),%rax
    7dcf:	4d 8d 6e 08          	lea    0x8(%r14),%r13
    7dd3:	4c 89 e9             	mov    %r13,%rcx
    7dd6:	48 85 f6             	test   %rsi,%rsi
    7dd9:	79 04                	jns    7ddf <fwp_write+0x54f>
    7ddb:	49 8b 4e 10          	mov    0x10(%r14),%rcx
    7ddf:	48 83 f8 01          	cmp    $0x1,%rax
    7de3:	0f 84 74 0a 00 00    	je     885d <fwp_write+0xfcd>
    7de9:	48 83 f8 08          	cmp    $0x8,%rax
    7ded:	0f 84 65 0a 00 00    	je     8858 <fwp_write+0xfc8>
    7df3:	48 83 f8 02          	cmp    $0x2,%rax
    7df7:	0f 85 6c 0a 00 00    	jne    8869 <fwp_write+0xfd9>
    7dfd:	83 3a 01             	cmpl   $0x1,(%rdx)
    7e00:	0f b7 01             	movzwl (%rcx),%eax
    7e03:	48 0f bf f0          	movswq %ax,%rsi
    7e07:	e9 65 0a 00 00       	jmp    8871 <fwp_write+0xfe1>
    7e0c:	48 8d 35 50 47 00 00 	lea    0x4750(%rip),%rsi        # c563 <fwp_segv.msg+0x323>
    7e13:	ba 06 00 00 00       	mov    $0x6,%edx
    7e18:	48 89 ef             	mov    %rbp,%rdi
    7e1b:	e8 50 0e 00 00       	call   8c70 <buf_put>
    7e20:	49 83 3e 00          	cmpq   $0x0,(%r14)
    7e24:	0f 84 a3 00 00 00    	je     7ecd <fwp_write+0x63d>
    7e2a:	41 0f b6 4e 08       	movzbl 0x8(%r14),%ecx
    7e2f:	48 8d 15 37 47 00 00 	lea    0x4737(%rip),%rdx        # c56d <fwp_segv.msg+0x32d>
    7e36:	4c 8d 7c 24 70       	lea    0x70(%rsp),%r15
    7e3b:	be 00 02 00 00       	mov    $0x200,%esi
    7e40:	4c 89 ff             	mov    %r15,%rdi
    7e43:	31 c0                	xor    %eax,%eax
    7e45:	e8 f6 a2 ff ff       	call   2140 <snprintf@plt>
    7e4a:	4c 89 ff             	mov    %r15,%rdi
    7e4d:	e8 be a2 ff ff       	call   2110 <strlen@plt>
    7e52:	48 89 ef             	mov    %rbp,%rdi
    7e55:	4c 89 fe             	mov    %r15,%rsi
    7e58:	48 89 c2             	mov    %rax,%rdx
    7e5b:	e8 10 0e 00 00       	call   8c70 <buf_put>
    7e60:	49 83 3e 02          	cmpq   $0x2,(%r14)
    7e64:	72 67                	jb     7ecd <fwp_write+0x63d>
    7e66:	bb 09 00 00 00       	mov    $0x9,%ebx
    7e6b:	4c 8d 3d f8 46 00 00 	lea    0x46f8(%rip),%r15        # c56a <fwp_segv.msg+0x32a>
    7e72:	4c 8d 25 f4 46 00 00 	lea    0x46f4(%rip),%r12        # c56d <fwp_segv.msg+0x32d>
    7e79:	4c 8d 6c 24 70       	lea    0x70(%rsp),%r13
    7e7e:	66 90                	xchg   %ax,%ax
    7e80:	ba 02 00 00 00       	mov    $0x2,%edx
    7e85:	48 89 ef             	mov    %rbp,%rdi
    7e88:	4c 89 fe             	mov    %r15,%rsi
    7e8b:	e8 e0 0d 00 00       	call   8c70 <buf_put>
    7e90:	41 0f b6 0c 1e       	movzbl (%r14,%rbx,1),%ecx
    7e95:	be 00 02 00 00       	mov    $0x200,%esi
    7e9a:	4c 89 ef             	mov    %r13,%rdi
    7e9d:	4c 89 e2             	mov    %r12,%rdx
    7ea0:	31 c0                	xor    %eax,%eax
    7ea2:	e8 99 a2 ff ff       	call   2140 <snprintf@plt>
    7ea7:	4c 89 ef             	mov    %r13,%rdi
    7eaa:	e8 61 a2 ff ff       	call   2110 <strlen@plt>
    7eaf:	48 89 ef             	mov    %rbp,%rdi
    7eb2:	4c 89 ee             	mov    %r13,%rsi
    7eb5:	48 89 c2             	mov    %rax,%rdx
    7eb8:	e8 b3 0d 00 00       	call   8c70 <buf_put>
    7ebd:	48 8d 43 01          	lea    0x1(%rbx),%rax
    7ec1:	48 83 c3 f9          	add    $0xfffffffffffffff9,%rbx
    7ec5:	49 3b 1e             	cmp    (%r14),%rbx
    7ec8:	48 89 c3             	mov    %rax,%rbx
    7ecb:	72 b3                	jb     7e80 <fwp_write+0x5f0>
    7ecd:	c6 44 24 20 5d       	movb   $0x5d,0x20(%rsp)
    7ed2:	48 8d 74 24 20       	lea    0x20(%rsp),%rsi
    7ed7:	e9 90 0a 00 00       	jmp    896c <fwp_write+0x10dc>
    7edc:	66 41 0f 6e ce       	movd   %r14d,%xmm1
    7ee1:	0f 2e c9             	ucomiss %xmm1,%xmm1
    7ee4:	0f 8a 73 0d 00 00    	jp     8c5d <fwp_write+0x13cd>
    7eea:	0f 28 05 df 41 00 00 	movaps 0x41df(%rip),%xmm0        # c0d0 <_IO_stdin_used+0xd0>
    7ef1:	0f 54 c1             	andps  %xmm1,%xmm0
    7ef4:	0f 2e 05 09 41 00 00 	ucomiss 0x4109(%rip),%xmm0        # c004 <_IO_stdin_used+0x4>
    7efb:	0f 82 6e 04 00 00    	jb     836f <fwp_write+0xadf>
    7f01:	0f 57 c0             	xorps  %xmm0,%xmm0
    7f04:	0f 2e c8             	ucomiss %xmm0,%xmm1
    7f07:	48 8d 05 88 46 00 00 	lea    0x4688(%rip),%rax        # c596 <fwp_segv.msg+0x356>
    7f0e:	48 8d 35 80 46 00 00 	lea    0x4680(%rip),%rsi        # c595 <fwp_segv.msg+0x355>
    7f15:	48 0f 47 f0          	cmova  %rax,%rsi
    7f19:	48 8d 7c 24 70       	lea    0x70(%rsp),%rdi
    7f1e:	e8 6d a1 ff ff       	call   2090 <strcpy@plt>
    7f23:	e9 90 0b 00 00       	jmp    8ab8 <fwp_write+0x1228>
    7f28:	48 8d 35 19 46 00 00 	lea    0x4619(%rip),%rsi        # c548 <fwp_segv.msg+0x308>
    7f2f:	ba 0a 00 00 00       	mov    $0xa,%edx
    7f34:	48 89 ef             	mov    %rbp,%rdi
    7f37:	e9 06 09 00 00       	jmp    8842 <fwp_write+0xfb2>
    7f3c:	48 8d 35 19 46 00 00 	lea    0x4619(%rip),%rsi        # c55c <fwp_segv.msg+0x31c>
    7f43:	ba 06 00 00 00       	mov    $0x6,%edx
    7f48:	48 89 ef             	mov    %rbp,%rdi
    7f4b:	e8 20 0d 00 00       	call   8c70 <buf_put>
    7f50:	49 83 c6 10          	add    $0x10,%r14
    7f54:	4c 89 f7             	mov    %r14,%rdi
    7f57:	e8 b4 a1 ff ff       	call   2110 <strlen@plt>
    7f5c:	48 89 ef             	mov    %rbp,%rdi
    7f5f:	4c 89 f6             	mov    %r14,%rsi
    7f62:	48 89 c2             	mov    %rax,%rdx
    7f65:	e8 06 0d 00 00       	call   8c70 <buf_put>
    7f6a:	c6 44 24 70 3e       	movb   $0x3e,0x70(%rsp)
    7f6f:	e9 f3 09 00 00       	jmp    8967 <fwp_write+0x10d7>
    7f74:	41 8b 06             	mov    (%r14),%eax
    7f77:	49 8b 4f 18          	mov    0x18(%r15),%rcx
    7f7b:	41 89 c5             	mov    %eax,%r13d
    7f7e:	4e 8b 24 e9          	mov    (%rcx,%r13,8),%r12
    7f82:	4c 89 e7             	mov    %r12,%rdi
    7f85:	e8 86 a1 ff ff       	call   2110 <strlen@plt>
    7f8a:	48 89 ef             	mov    %rbp,%rdi
    7f8d:	4c 89 e6             	mov    %r12,%rsi
    7f90:	48 89 c2             	mov    %rax,%rdx
    7f93:	e8 d8 0c 00 00       	call   8c70 <buf_put>
    7f98:	49 8b 47 28          	mov    0x28(%r15),%rax
    7f9c:	42 83 3c a8 00       	cmpl   $0x0,(%rax,%r13,4)
    7fa1:	0f 8e 2c 0b 00 00    	jle    8ad3 <fwp_write+0x1243>
    7fa7:	45 31 e4             	xor    %r12d,%r12d
    7faa:	4c 89 7c 24 10       	mov    %r15,0x10(%rsp)
    7faf:	4c 89 6c 24 68       	mov    %r13,0x68(%rsp)
    7fb4:	eb 3c                	jmp    7ff2 <fwp_write+0x762>
    7fb6:	66 2e 0f 1f 84 00 00 	cs nopw 0x0(%rax,%rax,1)
    7fbd:	00 00 00 
    7fc0:	48 8b 2c 24          	mov    (%rsp),%rbp
    7fc4:	48 89 ef             	mov    %rbp,%rdi
    7fc7:	48 89 de             	mov    %rbx,%rsi
    7fca:	4c 89 ea             	mov    %r13,%rdx
    7fcd:	31 c9                	xor    %ecx,%ecx
    7fcf:	e8 bc f8 ff ff       	call   7890 <fwp_write>
    7fd4:	49 ff c4             	inc    %r12
    7fd7:	4c 8b 7c 24 10       	mov    0x10(%rsp),%r15
    7fdc:	49 8b 47 28          	mov    0x28(%r15),%rax
    7fe0:	4c 8b 6c 24 68       	mov    0x68(%rsp),%r13
    7fe5:	4a 63 04 a8          	movslq (%rax,%r13,4),%rax
    7fe9:	49 39 c4             	cmp    %rax,%r12
    7fec:	0f 8d e1 0a 00 00    	jge    8ad3 <fwp_write+0x1243>
    7ff2:	4b 8b 5c e6 08       	mov    0x8(%r14,%r12,8),%rbx
    7ff7:	49 8b 47 30          	mov    0x30(%r15),%rax
    7ffb:	4a 8b 04 e8          	mov    (%rax,%r13,8),%rax
    7fff:	4e 8b 2c e0          	mov    (%rax,%r12,8),%r13
    8003:	c6 44 24 70 20       	movb   $0x20,0x70(%rsp)
    8008:	ba 01 00 00 00       	mov    $0x1,%edx
    800d:	48 89 ef             	mov    %rbp,%rdi
    8010:	48 8d 74 24 70       	lea    0x70(%rsp),%rsi
    8015:	e8 56 0c 00 00       	call   8c70 <buf_put>
    801a:	41 8b 45 00          	mov    0x0(%r13),%eax
    801e:	48 83 f8 10          	cmp    $0x10,%rax
    8022:	77 9c                	ja     7fc0 <fwp_write+0x730>
    8024:	48 8d 0d 4d 41 00 00 	lea    0x414d(%rip),%rcx        # c178 <_IO_stdin_used+0x178>
    802b:	48 63 04 81          	movslq (%rcx,%rax,4),%rax
    802f:	48 01 c8             	add    %rcx,%rax
    8032:	ff e0                	jmp    *%rax
    8034:	48 89 d9             	mov    %rbx,%rcx
    8037:	48 c1 e9 3f          	shr    $0x3f,%rcx
    803b:	85 c9                	test   %ecx,%ecx
    803d:	74 81                	je     7fc0 <fwp_write+0x730>
    803f:	c6 44 24 70 28       	movb   $0x28,0x70(%rsp)
    8044:	ba 01 00 00 00       	mov    $0x1,%edx
    8049:	48 8b 2c 24          	mov    (%rsp),%rbp
    804d:	48 89 ef             	mov    %rbp,%rdi
    8050:	4c 8d 7c 24 70       	lea    0x70(%rsp),%r15
    8055:	4c 89 fe             	mov    %r15,%rsi
    8058:	e8 13 0c 00 00       	call   8c70 <buf_put>
    805d:	48 89 ef             	mov    %rbp,%rdi
    8060:	48 89 de             	mov    %rbx,%rsi
    8063:	4c 89 ea             	mov    %r13,%rdx
    8066:	31 c9                	xor    %ecx,%ecx
    8068:	e8 23 f8 ff ff       	call   7890 <fwp_write>
    806d:	c6 44 24 70 29       	movb   $0x29,0x70(%rsp)
    8072:	ba 01 00 00 00       	mov    $0x1,%edx
    8077:	48 89 ef             	mov    %rbp,%rdi
    807a:	4c 89 fe             	mov    %r15,%rsi
    807d:	e8 ee 0b 00 00       	call   8c70 <buf_put>
    8082:	e9 4d ff ff ff       	jmp    7fd4 <fwp_write+0x744>
    8087:	31 c9                	xor    %ecx,%ecx
    8089:	48 81 fb 00 10 00 00 	cmp    $0x1000,%rbx
    8090:	0f 93 c1             	setae  %cl
    8093:	eb a6                	jmp    803b <fwp_write+0x7ab>
    8095:	48 8b 4b 08          	mov    0x8(%rbx),%rcx
    8099:	eb 9c                	jmp    8037 <fwp_write+0x7a7>
    809b:	89 d9                	mov    %ebx,%ecx
    809d:	c1 e9 1f             	shr    $0x1f,%ecx
    80a0:	eb 99                	jmp    803b <fwp_write+0x7ab>
    80a2:	49 8b 7d 08          	mov    0x8(%r13),%rdi
    80a6:	48 85 ff             	test   %rdi,%rdi
    80a9:	0f 84 11 ff ff ff    	je     7fc0 <fwp_write+0x730>
    80af:	48 8d 35 cb 44 00 00 	lea    0x44cb(%rip),%rsi        # c581 <fwp_segv.msg+0x341>
    80b6:	e8 05 a1 ff ff       	call   21c0 <strcmp@plt>
    80bb:	31 c9                	xor    %ecx,%ecx
    80bd:	85 c0                	test   %eax,%eax
    80bf:	0f 95 c1             	setne  %cl
    80c2:	e9 74 ff ff ff       	jmp    803b <fwp_write+0x7ab>
    80c7:	41 83 7f 10 00       	cmpl   $0x0,0x10(%r15)
    80cc:	0f 84 a7 08 00 00    	je     8979 <fwp_write+0x10e9>
    80d2:	4d 8d 6f 10          	lea    0x10(%r15),%r13
    80d6:	4d 85 e4             	test   %r12,%r12
    80d9:	0f 94 c0             	sete   %al
    80dc:	41 83 7f 48 00       	cmpl   $0x0,0x48(%r15)
    80e1:	0f 95 c3             	setne  %bl
    80e4:	20 c3                	and    %al,%bl
    80e6:	84 db                	test   %bl,%bl
    80e8:	b8 28 00 00 00       	mov    $0x28,%eax
    80ed:	b9 7b 00 00 00       	mov    $0x7b,%ecx
    80f2:	0f 45 c8             	cmovne %eax,%ecx
    80f5:	88 4c 24 70          	mov    %cl,0x70(%rsp)
    80f9:	48 8d 74 24 70       	lea    0x70(%rsp),%rsi
    80fe:	ba 01 00 00 00       	mov    $0x1,%edx
    8103:	48 89 ef             	mov    %rbp,%rdi
    8106:	e8 65 0b 00 00       	call   8c70 <buf_put>
    810b:	41 83 7d 00 00       	cmpl   $0x0,0x0(%r13)
    8110:	0f 8e da 00 00 00    	jle    81f0 <fwp_write+0x960>
    8116:	84 db                	test   %bl,%bl
    8118:	75 31                	jne    814b <fwp_write+0x8bb>
    811a:	49 8b 47 18          	mov    0x18(%r15),%rax
    811e:	4c 8b 20             	mov    (%rax),%r12
    8121:	4c 89 e7             	mov    %r12,%rdi
    8124:	e8 e7 9f ff ff       	call   2110 <strlen@plt>
    8129:	48 89 ef             	mov    %rbp,%rdi
    812c:	4c 89 e6             	mov    %r12,%rsi
    812f:	48 89 c2             	mov    %rax,%rdx
    8132:	e8 39 0b 00 00       	call   8c70 <buf_put>
    8137:	48 8d 35 4f 44 00 00 	lea    0x444f(%rip),%rsi        # c58d <fwp_segv.msg+0x34d>
    813e:	ba 03 00 00 00       	mov    $0x3,%edx
    8143:	48 89 ef             	mov    %rbp,%rdi
    8146:	e8 25 0b 00 00       	call   8c70 <buf_put>
    814b:	49 8b 76 08          	mov    0x8(%r14),%rsi
    814f:	49 8b 47 20          	mov    0x20(%r15),%rax
    8153:	48 8b 10             	mov    (%rax),%rdx
    8156:	48 89 ef             	mov    %rbp,%rdi
    8159:	31 c9                	xor    %ecx,%ecx
    815b:	e8 30 f7 ff ff       	call   7890 <fwp_write>
    8160:	41 83 7f 10 02       	cmpl   $0x2,0x10(%r15)
    8165:	0f 8c 85 00 00 00    	jl     81f0 <fwp_write+0x960>
    816b:	41 bd 01 00 00 00    	mov    $0x1,%r13d
    8171:	4c 8d 25 f2 43 00 00 	lea    0x43f2(%rip),%r12        # c56a <fwp_segv.msg+0x32a>
    8178:	eb 29                	jmp    81a3 <fwp_write+0x913>
    817a:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)
    8180:	4b 8b 74 ee 08       	mov    0x8(%r14,%r13,8),%rsi
    8185:	49 8b 47 20          	mov    0x20(%r15),%rax
    8189:	4a 8b 14 e8          	mov    (%rax,%r13,8),%rdx
    818d:	48 89 ef             	mov    %rbp,%rdi
    8190:	31 c9                	xor    %ecx,%ecx
    8192:	e8 f9 f6 ff ff       	call   7890 <fwp_write>
    8197:	49 ff c5             	inc    %r13
    819a:	49 63 47 10          	movslq 0x10(%r15),%rax
    819e:	49 39 c5             	cmp    %rax,%r13
    81a1:	7d 4d                	jge    81f0 <fwp_write+0x960>
    81a3:	ba 02 00 00 00       	mov    $0x2,%edx
    81a8:	48 89 ef             	mov    %rbp,%rdi
    81ab:	4c 89 e6             	mov    %r12,%rsi
    81ae:	e8 bd 0a 00 00       	call   8c70 <buf_put>
    81b3:	84 db                	test   %bl,%bl
    81b5:	75 c9                	jne    8180 <fwp_write+0x8f0>
    81b7:	49 8b 47 18          	mov    0x18(%r15),%rax
    81bb:	4a 8b 2c e8          	mov    (%rax,%r13,8),%rbp
    81bf:	48 89 ef             	mov    %rbp,%rdi
    81c2:	e8 49 9f ff ff       	call   2110 <strlen@plt>
    81c7:	48 8b 3c 24          	mov    (%rsp),%rdi
    81cb:	48 89 ee             	mov    %rbp,%rsi
    81ce:	48 8b 2c 24          	mov    (%rsp),%rbp
    81d2:	48 89 c2             	mov    %rax,%rdx
    81d5:	e8 96 0a 00 00       	call   8c70 <buf_put>
    81da:	ba 03 00 00 00       	mov    $0x3,%edx
    81df:	48 89 ef             	mov    %rbp,%rdi
    81e2:	48 8d 35 a4 43 00 00 	lea    0x43a4(%rip),%rsi        # c58d <fwp_segv.msg+0x34d>
    81e9:	e8 82 0a 00 00       	call   8c70 <buf_put>
    81ee:	eb 90                	jmp    8180 <fwp_write+0x8f0>
    81f0:	84 db                	test   %bl,%bl
    81f2:	b8 29 00 00 00       	mov    $0x29,%eax
    81f7:	b9 7d 00 00 00       	mov    $0x7d,%ecx
    81fc:	0f 45 c8             	cmovne %eax,%ecx
    81ff:	88 4c 24 70          	mov    %cl,0x70(%rsp)
    8203:	e9 5f 07 00 00       	jmp    8967 <fwp_write+0x10d7>
    8208:	48 89 ef             	mov    %rbp,%rdi
    820b:	48 81 c4 78 02 00 00 	add    $0x278,%rsp
    8212:	5b                   	pop    %rbx
    8213:	41 5c                	pop    %r12
    8215:	41 5d                	pop    %r13
    8217:	41 5e                	pop    %r14
    8219:	41 5f                	pop    %r15
    821b:	5d                   	pop    %rbp
    821c:	e9 3f 0b 00 00       	jmp    8d60 <fwp_escape>
    8221:	c6 44 24 20 30       	movb   $0x30,0x20(%rsp)
    8226:	bf 01 00 00 00       	mov    $0x1,%edi
    822b:	89 f8                	mov    %edi,%eax
    822d:	48 83 f8 08          	cmp    $0x8,%rax
    8231:	73 0a                	jae    823d <fwp_write+0x9ad>
    8233:	31 c9                	xor    %ecx,%ecx
    8235:	48 89 c2             	mov    %rax,%rdx
    8238:	e9 7a 04 00 00       	jmp    86b7 <fwp_write+0xe27>
    823d:	83 f8 20             	cmp    $0x20,%eax
    8240:	0f 83 68 03 00 00    	jae    85ae <fwp_write+0xd1e>
    8246:	31 c9                	xor    %ecx,%ecx
    8248:	e9 10 04 00 00       	jmp    865d <fwp_write+0xdcd>
    824d:	31 ff                	xor    %edi,%edi
    824f:	49 f7 d8             	neg    %r8
    8252:	41 ba 00 00 00 00    	mov    $0x0,%r10d
    8258:	4d 19 ca             	sbb    %r9,%r10
    825b:	c6 44 24 70 2d       	movb   $0x2d,0x70(%rsp)
    8260:	49 b9 cd cc cc cc cc 	movabs $0xcccccccccccccccd,%r9
    8267:	cc cc cc 
    826a:	49 bb cc cc cc cc cc 	movabs $0xcccccccccccccccc,%r11
    8271:	cc cc cc 
    8274:	4c 89 d3             	mov    %r10,%rbx
    8277:	66 0f 1f 84 00 00 00 	nopw   0x0(%rax,%rax,1)
    827e:	00 00 
    8280:	4c 89 d1             	mov    %r10,%rcx
    8283:	4c 0f a4 c1 3f       	shld   $0x3f,%r8,%rcx
    8288:	48 d1 eb             	shr    $1,%rbx
    828b:	48 89 ce             	mov    %rcx,%rsi
    828e:	48 01 de             	add    %rbx,%rsi
    8291:	48 83 d6 00          	adc    $0x0,%rsi
    8295:	48 89 f0             	mov    %rsi,%rax
    8298:	49 f7 e1             	mul    %r9
    829b:	48 c1 ea 02          	shr    $0x2,%rdx
    829f:	48 8d 04 92          	lea    (%rdx,%rdx,4),%rax
    82a3:	48 29 c6             	sub    %rax,%rsi
    82a6:	48 29 f1             	sub    %rsi,%rcx
    82a9:	48 83 db 00          	sbb    $0x0,%rbx
    82ad:	48 89 ce             	mov    %rcx,%rsi
    82b0:	49 0f af f3          	imul   %r11,%rsi
    82b4:	48 89 c8             	mov    %rcx,%rax
    82b7:	49 f7 e1             	mul    %r9
    82ba:	48 01 f2             	add    %rsi,%rdx
    82bd:	49 0f af d9          	imul   %r9,%rbx
    82c1:	48 01 d3             	add    %rdx,%rbx
    82c4:	48 89 c1             	mov    %rax,%rcx
    82c7:	48 01 c1             	add    %rax,%rcx
    82ca:	48 8d 0c 89          	lea    (%rcx,%rcx,4),%rcx
    82ce:	44 89 c2             	mov    %r8d,%edx
    82d1:	29 ca                	sub    %ecx,%edx
    82d3:	80 ca 30             	or     $0x30,%dl
    82d6:	88 54 3c 20          	mov    %dl,0x20(%rsp,%rdi,1)
    82da:	48 ff c7             	inc    %rdi
    82dd:	49 83 f8 0a          	cmp    $0xa,%r8
    82e1:	49 83 da 00          	sbb    $0x0,%r10
    82e5:	49 89 c0             	mov    %rax,%r8
    82e8:	49 89 da             	mov    %rbx,%r10
    82eb:	73 93                	jae    8280 <fwp_write+0x9f0>
    82ed:	85 ff                	test   %edi,%edi
    82ef:	0f 8e 98 06 00 00    	jle    898d <fwp_write+0x10fd>
    82f5:	89 f8                	mov    %edi,%eax
    82f7:	48 83 f8 08          	cmp    $0x8,%rax
    82fb:	0f 83 e4 07 00 00    	jae    8ae5 <fwp_write+0x1255>
    8301:	31 c9                	xor    %ecx,%ecx
    8303:	48 89 c2             	mov    %rax,%rdx
    8306:	e9 fc 08 00 00       	jmp    8c07 <fwp_write+0x1377>
    830b:	bd 01 00 00 00       	mov    $0x1,%ebp
    8310:	4c 8d 74 24 70       	lea    0x70(%rsp),%r14
    8315:	0f 29 4c 24 10       	movaps %xmm1,0x10(%rsp)
    831a:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)
    8320:	4c 89 f7             	mov    %r14,%rdi
    8323:	66 0f 28 c1          	movapd %xmm1,%xmm0
    8327:	89 ee                	mov    %ebp,%esi
    8329:	e8 a2 16 00 00       	call   99d0 <fwp_format_g>
    832e:	4c 89 f7             	mov    %r14,%rdi
    8331:	31 f6                	xor    %esi,%esi
    8333:	e8 98 9d ff ff       	call   20d0 <strtod@plt>
    8338:	66 0f 28 4c 24 10    	movapd 0x10(%rsp),%xmm1
    833e:	66 0f 2e c1          	ucomisd %xmm1,%xmm0
    8342:	75 06                	jne    834a <fwp_write+0xaba>
    8344:	0f 8b 9e 03 00 00    	jnp    86e8 <fwp_write+0xe58>
    834a:	ff c5                	inc    %ebp
    834c:	83 fd 12             	cmp    $0x12,%ebp
    834f:	75 cf                	jne    8320 <fwp_write+0xa90>
    8351:	4c 8d 74 24 70       	lea    0x70(%rsp),%r14
    8356:	4c 89 f7             	mov    %r14,%rdi
    8359:	66 0f 28 c1          	movapd %xmm1,%xmm0
    835d:	be 11 00 00 00       	mov    $0x11,%esi
    8362:	e8 69 16 00 00       	call   99d0 <fwp_format_g>
    8367:	4c 89 f7             	mov    %r14,%rdi
    836a:	e9 7e 03 00 00       	jmp    86ed <fwp_write+0xe5d>
    836f:	0f 57 c0             	xorps  %xmm0,%xmm0
    8372:	f3 0f 5a c1          	cvtss2sd %xmm1,%xmm0
    8376:	4c 8d 74 24 70       	lea    0x70(%rsp),%r14
    837b:	4c 89 f7             	mov    %r14,%rdi
    837e:	f2 0f 11 44 24 10    	movsd  %xmm0,0x10(%rsp)
    8384:	be 01 00 00 00       	mov    $0x1,%esi
    8389:	0f 29 0c 24          	movaps %xmm1,(%rsp)
    838d:	e8 3e 16 00 00       	call   99d0 <fwp_format_g>
    8392:	4c 89 f7             	mov    %r14,%rdi
    8395:	31 f6                	xor    %esi,%esi
    8397:	e8 b4 9d ff ff       	call   2150 <strtof@plt>
    839c:	0f 2e 04 24          	ucomiss (%rsp),%xmm0
    83a0:	75 06                	jne    83a8 <fwp_write+0xb18>
    83a2:	0f 8b 6f 01 00 00    	jnp    8517 <fwp_write+0xc87>
    83a8:	4c 8d 74 24 70       	lea    0x70(%rsp),%r14
    83ad:	4c 89 f7             	mov    %r14,%rdi
    83b0:	f2 0f 10 44 24 10    	movsd  0x10(%rsp),%xmm0
    83b6:	be 02 00 00 00       	mov    $0x2,%esi
    83bb:	e8 10 16 00 00       	call   99d0 <fwp_format_g>
    83c0:	4c 89 f7             	mov    %r14,%rdi
    83c3:	31 f6                	xor    %esi,%esi
    83c5:	e8 86 9d ff ff       	call   2150 <strtof@plt>
    83ca:	0f 2e 04 24          	ucomiss (%rsp),%xmm0
    83ce:	75 06                	jne    83d6 <fwp_write+0xb46>
    83d0:	0f 8b 41 01 00 00    	jnp    8517 <fwp_write+0xc87>
    83d6:	4c 8d 74 24 70       	lea    0x70(%rsp),%r14
    83db:	4c 89 f7             	mov    %r14,%rdi
    83de:	f2 0f 10 44 24 10    	movsd  0x10(%rsp),%xmm0
    83e4:	be 03 00 00 00       	mov    $0x3,%esi
    83e9:	e8 e2 15 00 00       	call   99d0 <fwp_format_g>
    83ee:	4c 89 f7             	mov    %r14,%rdi
    83f1:	31 f6                	xor    %esi,%esi
    83f3:	e8 58 9d ff ff       	call   2150 <strtof@plt>
    83f8:	0f 2e 04 24          	ucomiss (%rsp),%xmm0
    83fc:	75 06                	jne    8404 <fwp_write+0xb74>
    83fe:	0f 8b 13 01 00 00    	jnp    8517 <fwp_write+0xc87>
    8404:	4c 8d 74 24 70       	lea    0x70(%rsp),%r14
    8409:	4c 89 f7             	mov    %r14,%rdi
    840c:	f2 0f 10 44 24 10    	movsd  0x10(%rsp),%xmm0
    8412:	be 04 00 00 00       	mov    $0x4,%esi
    8417:	e8 b4 15 00 00       	call   99d0 <fwp_format_g>
    841c:	4c 89 f7             	mov    %r14,%rdi
    841f:	31 f6                	xor    %esi,%esi
    8421:	e8 2a 9d ff ff       	call   2150 <strtof@plt>
    8426:	0f 2e 04 24          	ucomiss (%rsp),%xmm0
    842a:	75 06                	jne    8432 <fwp_write+0xba2>
    842c:	0f 8b e5 00 00 00    	jnp    8517 <fwp_write+0xc87>
    8432:	4c 8d 74 24 70       	lea    0x70(%rsp),%r14
    8437:	4c 89 f7             	mov    %r14,%rdi
    843a:	f2 0f 10 44 24 10    	movsd  0x10(%rsp),%xmm0
    8440:	be 05 00 00 00       	mov    $0x5,%esi
    8445:	e8 86 15 00 00       	call   99d0 <fwp_format_g>
    844a:	4c 89 f7             	mov    %r14,%rdi
    844d:	31 f6                	xor    %esi,%esi
    844f:	e8 fc 9c ff ff       	call   2150 <strtof@plt>
    8454:	0f 2e 04 24          	ucomiss (%rsp),%xmm0
    8458:	75 06                	jne    8460 <fwp_write+0xbd0>
    845a:	0f 8b b7 00 00 00    	jnp    8517 <fwp_write+0xc87>
    8460:	4c 8d 74 24 70       	lea    0x70(%rsp),%r14
    8465:	4c 89 f7             	mov    %r14,%rdi
    8468:	f2 0f 10 44 24 10    	movsd  0x10(%rsp),%xmm0
    846e:	be 06 00 00 00       	mov    $0x6,%esi
    8473:	e8 58 15 00 00       	call   99d0 <fwp_format_g>
    8478:	4c 89 f7             	mov    %r14,%rdi
    847b:	31 f6                	xor    %esi,%esi
    847d:	e8 ce 9c ff ff       	call   2150 <strtof@plt>
    8482:	0f 2e 04 24          	ucomiss (%rsp),%xmm0
    8486:	75 06                	jne    848e <fwp_write+0xbfe>
    8488:	0f 8b 89 00 00 00    	jnp    8517 <fwp_write+0xc87>
    848e:	4c 8d 74 24 70       	lea    0x70(%rsp),%r14
    8493:	4c 89 f7             	mov    %r14,%rdi
    8496:	f2 0f 10 44 24 10    	movsd  0x10(%rsp),%xmm0
    849c:	be 07 00 00 00       	mov    $0x7,%esi
    84a1:	e8 2a 15 00 00       	call   99d0 <fwp_format_g>
    84a6:	4c 89 f7             	mov    %r14,%rdi
    84a9:	31 f6                	xor    %esi,%esi
    84ab:	e8 a0 9c ff ff       	call   2150 <strtof@plt>
    84b0:	0f 2e 04 24          	ucomiss (%rsp),%xmm0
    84b4:	75 02                	jne    84b8 <fwp_write+0xc28>
    84b6:	7b 5f                	jnp    8517 <fwp_write+0xc87>
    84b8:	4c 8d 74 24 70       	lea    0x70(%rsp),%r14
    84bd:	4c 89 f7             	mov    %r14,%rdi
    84c0:	f2 0f 10 44 24 10    	movsd  0x10(%rsp),%xmm0
    84c6:	be 08 00 00 00       	mov    $0x8,%esi
    84cb:	e8 00 15 00 00       	call   99d0 <fwp_format_g>
    84d0:	4c 89 f7             	mov    %r14,%rdi
    84d3:	31 f6                	xor    %esi,%esi
    84d5:	e8 76 9c ff ff       	call   2150 <strtof@plt>
    84da:	0f 28 0c 24          	movaps (%rsp),%xmm1
    84de:	0f 2e c1             	ucomiss %xmm1,%xmm0
    84e1:	75 02                	jne    84e5 <fwp_write+0xc55>
    84e3:	7b 32                	jnp    8517 <fwp_write+0xc87>
    84e5:	4c 8d 74 24 70       	lea    0x70(%rsp),%r14
    84ea:	4c 89 f7             	mov    %r14,%rdi
    84ed:	f2 0f 10 44 24 10    	movsd  0x10(%rsp),%xmm0
    84f3:	be 09 00 00 00       	mov    $0x9,%esi
    84f8:	e8 d3 14 00 00       	call   99d0 <fwp_format_g>
    84fd:	4c 89 f7             	mov    %r14,%rdi
    8500:	31 f6                	xor    %esi,%esi
    8502:	e8 49 9c ff ff       	call   2150 <strtof@plt>
    8507:	0f 2e 04 24          	ucomiss (%rsp),%xmm0
    850b:	0f 85 2c 07 00 00    	jne    8c3d <fwp_write+0x13ad>
    8511:	0f 8a 26 07 00 00    	jp     8c3d <fwp_write+0x13ad>
    8517:	48 8d 7c 24 70       	lea    0x70(%rsp),%rdi
    851c:	be 2e 00 00 00       	mov    $0x2e,%esi
    8521:	e8 0a 9c ff ff       	call   2130 <strchr@plt>
    8526:	48 85 c0             	test   %rax,%rax
    8529:	0f 85 89 05 00 00    	jne    8ab8 <fwp_write+0x1228>
    852f:	e9 d0 01 00 00       	jmp    8704 <fwp_write+0xe74>
    8534:	4c 8b bc f0 d0 03 00 	mov    0x3d0(%rax,%rsi,8),%r15
    853b:	00 
    853c:	48 8b bc f0 d8 03 00 	mov    0x3d8(%rax,%rsi,8),%rdi
    8543:	00 
    8544:	4c 29 ff             	sub    %r15,%rdi
    8547:	48 39 cf             	cmp    %rcx,%rdi
    854a:	0f 83 1b 02 00 00    	jae    876b <fwp_write+0xedb>
    8550:	48 89 d7             	mov    %rdx,%rdi
    8553:	be 01 00 00 00       	mov    $0x1,%esi
    8558:	e8 13 cf ff ff       	call   5470 <fwp_gc_alloc_slow>
    855d:	49 89 c7             	mov    %rax,%r15
    8560:	e9 20 02 00 00       	jmp    8785 <fwp_write+0xef5>
    8565:	49 8b 76 08          	mov    0x8(%r14),%rsi
    8569:	48 89 f2             	mov    %rsi,%rdx
    856c:	48 c1 fa 3f          	sar    $0x3f,%rdx
    8570:	4c 8d 74 24 70       	lea    0x70(%rsp),%r14
    8575:	4c 89 f7             	mov    %r14,%rdi
    8578:	e8 23 09 00 00       	call   8ea0 <fwp_fmt_duration>
    857d:	e9 3b 05 00 00       	jmp    8abd <fwp_write+0x122d>
    8582:	c6 44 24 20 30       	movb   $0x30,0x20(%rsp)
    8587:	bf 01 00 00 00       	mov    $0x1,%edi
    858c:	89 f8                	mov    %edi,%eax
    858e:	48 83 f8 08          	cmp    $0x8,%rax
    8592:	73 0a                	jae    859e <fwp_write+0xd0e>
    8594:	31 c9                	xor    %ecx,%ecx
    8596:	48 89 c2             	mov    %rax,%rdx
    8599:	e9 f2 04 00 00       	jmp    8a90 <fwp_write+0x1200>
    859e:	83 f8 20             	cmp    $0x20,%eax
    85a1:	0f 83 f2 03 00 00    	jae    8999 <fwp_write+0x1109>
    85a7:	31 c9                	xor    %ecx,%ecx
    85a9:	e9 92 04 00 00       	jmp    8a40 <fwp_write+0x11b0>
    85ae:	89 fa                	mov    %edi,%edx
    85b0:	83 e2 1f             	and    $0x1f,%edx
    85b3:	48 89 c1             	mov    %rax,%rcx
    85b6:	48 29 d1             	sub    %rdx,%rcx
    85b9:	48 8d b4 24 80 00 00 	lea    0x80(%rsp),%rsi
    85c0:	00 
    85c1:	66 0f ef c0          	pxor   %xmm0,%xmm0
    85c5:	49 89 c0             	mov    %rax,%r8
    85c8:	0f 1f 84 00 00 00 00 	nopl   0x0(%rax,%rax,1)
    85cf:	00 
    85d0:	f3 42 0f 6f 0c 04    	movdqu (%rsp,%r8,1),%xmm1
    85d6:	f3 42 0f 6f 54 04 10 	movdqu 0x10(%rsp,%r8,1),%xmm2
    85dd:	66 0f 6f da          	movdqa %xmm2,%xmm3
    85e1:	66 0f 60 d8          	punpcklbw %xmm0,%xmm3
    85e5:	66 0f 70 db 4e       	pshufd $0x4e,%xmm3,%xmm3
    85ea:	f2 0f 70 db 1b       	pshuflw $0x1b,%xmm3,%xmm3
    85ef:	f3 0f 70 db 1b       	pshufhw $0x1b,%xmm3,%xmm3
    85f4:	66 0f 68 d0          	punpckhbw %xmm0,%xmm2
    85f8:	66 0f 70 d2 4e       	pshufd $0x4e,%xmm2,%xmm2
    85fd:	f2 0f 70 d2 1b       	pshuflw $0x1b,%xmm2,%xmm2
    8602:	f3 0f 70 d2 1b       	pshufhw $0x1b,%xmm2,%xmm2
    8607:	66 0f 67 d3          	packuswb %xmm3,%xmm2
    860b:	66 0f 6f d9          	movdqa %xmm1,%xmm3
    860f:	66 0f 60 d8          	punpcklbw %xmm0,%xmm3
    8613:	66 0f 70 db 4e       	pshufd $0x4e,%xmm3,%xmm3
    8618:	f2 0f 70 db 1b       	pshuflw $0x1b,%xmm3,%xmm3
    861d:	f3 0f 70 db 1b       	pshufhw $0x1b,%xmm3,%xmm3
    8622:	66 0f 68 c8          	punpckhbw %xmm0,%xmm1
    8626:	66 0f 70 c9 4e       	pshufd $0x4e,%xmm1,%xmm1
    862b:	f2 0f 70 c9 1b       	pshuflw $0x1b,%xmm1,%xmm1
    8630:	f3 0f 70 c9 1b       	pshufhw $0x1b,%xmm1,%xmm1
    8635:	66 0f 67 cb          	packuswb %xmm3,%xmm1
    8639:	66 0f 7f 56 f0       	movdqa %xmm2,-0x10(%rsi)
    863e:	66 0f 7f 0e          	movdqa %xmm1,(%rsi)
    8642:	49 83 c0 e0          	add    $0xffffffffffffffe0,%r8
    8646:	48 83 c6 20          	add    $0x20,%rsi
    864a:	4c 39 c2             	cmp    %r8,%rdx
    864d:	75 81                	jne    85d0 <fwp_write+0xd40>
    864f:	48 85 d2             	test   %rdx,%rdx
    8652:	0f 84 5b 04 00 00    	je     8ab3 <fwp_write+0x1223>
    8658:	83 fa 08             	cmp    $0x8,%edx
    865b:	72 5a                	jb     86b7 <fwp_write+0xe27>
    865d:	89 fa                	mov    %edi,%edx
    865f:	83 e2 07             	and    $0x7,%edx
    8662:	48 89 c6             	mov    %rax,%rsi
    8665:	48 29 ce             	sub    %rcx,%rsi
    8668:	48 8d 3c 0c          	lea    (%rsp,%rcx,1),%rdi
    866c:	48 83 c7 70          	add    $0x70,%rdi
    8670:	48 89 c1             	mov    %rax,%rcx
    8673:	48 29 d1             	sub    %rdx,%rcx
    8676:	66 0f ef c0          	pxor   %xmm0,%xmm0
    867a:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)
    8680:	f3 0f 7e 4c 34 18    	movq   0x18(%rsp,%rsi,1),%xmm1
    8686:	66 0f 60 c8          	punpcklbw %xmm0,%xmm1
    868a:	66 0f 70 c9 4e       	pshufd $0x4e,%xmm1,%xmm1
    868f:	f2 0f 70 c9 1b       	pshuflw $0x1b,%xmm1,%xmm1
    8694:	f3 0f 70 c9 1b       	pshufhw $0x1b,%xmm1,%xmm1
    8699:	66 0f 67 c9          	packuswb %xmm1,%xmm1
    869d:	66 0f d6 0f          	movq   %xmm1,(%rdi)
    86a1:	48 83 c6 f8          	add    $0xfffffffffffffff8,%rsi
    86a5:	48 83 c7 08          	add    $0x8,%rdi
    86a9:	48 39 f2             	cmp    %rsi,%rdx
    86ac:	75 d2                	jne    8680 <fwp_write+0xdf0>
    86ae:	48 85 d2             	test   %rdx,%rdx
    86b1:	0f 84 fc 03 00 00    	je     8ab3 <fwp_write+0x1223>
    86b7:	48 8d 74 24 20       	lea    0x20(%rsp),%rsi
    86bc:	48 01 f2             	add    %rsi,%rdx
    86bf:	48 ff ca             	dec    %rdx
    86c2:	66 66 66 66 66 2e 0f 	data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    86c9:	1f 84 00 00 00 00 00 
    86d0:	0f b6 32             	movzbl (%rdx),%esi
    86d3:	40 88 74 0c 70       	mov    %sil,0x70(%rsp,%rcx,1)
    86d8:	48 ff c1             	inc    %rcx
    86db:	48 ff ca             	dec    %rdx
    86de:	48 39 c8             	cmp    %rcx,%rax
    86e1:	75 ed                	jne    86d0 <fwp_write+0xe40>
    86e3:	e9 cb 03 00 00       	jmp    8ab3 <fwp_write+0x1223>
    86e8:	48 8d 7c 24 70       	lea    0x70(%rsp),%rdi
    86ed:	be 2e 00 00 00       	mov    $0x2e,%esi
    86f2:	e8 39 9a ff ff       	call   2130 <strchr@plt>
    86f7:	48 85 c0             	test   %rax,%rax
    86fa:	48 8b 2c 24          	mov    (%rsp),%rbp
    86fe:	0f 85 b4 03 00 00    	jne    8ab8 <fwp_write+0x1228>
    8704:	48 8d 7c 24 70       	lea    0x70(%rsp),%rdi
    8709:	be 65 00 00 00       	mov    $0x65,%esi
    870e:	e8 1d 9a ff ff       	call   2130 <strchr@plt>
    8713:	48 85 c0             	test   %rax,%rax
    8716:	0f 85 9c 03 00 00    	jne    8ab8 <fwp_write+0x1228>
    871c:	48 8d 35 73 3e 00 00 	lea    0x3e73(%rip),%rsi        # c596 <fwp_segv.msg+0x356>
    8723:	48 8d 7c 24 70       	lea    0x70(%rsp),%rdi
    8728:	e8 03 9c ff ff       	call   2330 <strstr@plt>
    872d:	48 85 c0             	test   %rax,%rax
    8730:	0f 85 82 03 00 00    	jne    8ab8 <fwp_write+0x1228>
    8736:	48 8d 35 54 3e 00 00 	lea    0x3e54(%rip),%rsi        # c591 <fwp_segv.msg+0x351>
    873d:	48 8d 7c 24 70       	lea    0x70(%rsp),%rdi
    8742:	e8 e9 9b ff ff       	call   2330 <strstr@plt>
    8747:	48 85 c0             	test   %rax,%rax
    874a:	0f 85 68 03 00 00    	jne    8ab8 <fwp_write+0x1228>
    8750:	48 8d 7c 24 70       	lea    0x70(%rsp),%rdi
    8755:	e8 b6 99 ff ff       	call   2110 <strlen@plt>
    875a:	66 c7 44 04 70 2e 30 	movw   $0x302e,0x70(%rsp,%rax,1)
    8761:	c6 44 04 72 00       	movb   $0x0,0x72(%rsp,%rax,1)
    8766:	e9 4d 03 00 00       	jmp    8ab8 <fwp_write+0x1228>
    876b:	48 8d 04 f0          	lea    (%rax,%rsi,8),%rax
    876f:	48 05 d0 03 00 00    	add    $0x3d0,%rax
    8775:	4c 01 f9             	add    %r15,%rcx
    8778:	48 89 08             	mov    %rcx,(%rax)
    877b:	4c 89 ff             	mov    %r15,%rdi
    877e:	31 f6                	xor    %esi,%esi
    8780:	e8 db 99 ff ff       	call   2160 <memset@plt>
    8785:	66 41 c7 07 30 74    	movw   $0x7430,(%r15)
    878b:	85 db                	test   %ebx,%ebx
    878d:	0f 8e 98 00 00 00    	jle    882b <fwp_write+0xf9b>
    8793:	44 89 e1             	mov    %r12d,%ecx
    8796:	48 f7 d9             	neg    %rcx
    8799:	4a 8d 34 3b          	lea    (%rbx,%r15,1),%rsi
    879d:	48 ff c6             	inc    %rsi
    87a0:	31 ff                	xor    %edi,%edi
    87a2:	49 b8 56 55 55 55 55 	movabs $0x5555555555555556,%r8
    87a9:	55 55 55 
    87ac:	eb 2e                	jmp    87dc <fwp_write+0xf4c>
    87ae:	66 90                	xchg   %ax,%ax
    87b0:	41 b2 30             	mov    $0x30,%r10b
    87b3:	44 88 14 3e          	mov    %r10b,(%rsi,%rdi,1)
    87b7:	48 85 d2             	test   %rdx,%rdx
    87ba:	0f 95 c2             	setne  %dl
    87bd:	4d 85 f6             	test   %r14,%r14
    87c0:	41 0f 98 c2          	sets   %r10b
    87c4:	41 20 d2             	and    %dl,%r10b
    87c7:	41 0f b6 d2          	movzbl %r10b,%edx
    87cb:	48 29 d0             	sub    %rdx,%rax
    87ce:	4c 01 c8             	add    %r9,%rax
    87d1:	48 ff cf             	dec    %rdi
    87d4:	49 89 c6             	mov    %rax,%r14
    87d7:	48 39 f9             	cmp    %rdi,%rcx
    87da:	74 4f                	je     882b <fwp_write+0xf9b>
    87dc:	4c 89 f0             	mov    %r14,%rax
    87df:	49 f7 e8             	imul   %r8
    87e2:	48 89 d0             	mov    %rdx,%rax
    87e5:	48 c1 e8 3f          	shr    $0x3f,%rax
    87e9:	48 01 d0             	add    %rdx,%rax
    87ec:	4c 8d 0c 40          	lea    (%rax,%rax,2),%r9
    87f0:	4c 89 f2             	mov    %r14,%rdx
    87f3:	4c 29 ca             	sub    %r9,%rdx
    87f6:	49 f7 d9             	neg    %r9
    87f9:	4d 01 f1             	add    %r14,%r9
    87fc:	49 83 c1 03          	add    $0x3,%r9
    8800:	48 83 fa fd          	cmp    $0xfffffffffffffffd,%rdx
    8804:	4c 0f 42 ca          	cmovb  %rdx,%r9
    8808:	4d 85 c9             	test   %r9,%r9
    880b:	74 a3                	je     87b0 <fwp_write+0xf20>
    880d:	49 83 f9 01          	cmp    $0x1,%r9
    8811:	75 0d                	jne    8820 <fwp_write+0xf90>
    8813:	41 b2 2b             	mov    $0x2b,%r10b
    8816:	45 31 c9             	xor    %r9d,%r9d
    8819:	eb 98                	jmp    87b3 <fwp_write+0xf23>
    881b:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)
    8820:	41 b2 2d             	mov    $0x2d,%r10b
    8823:	41 b9 01 00 00 00    	mov    $0x1,%r9d
    8829:	eb 88                	jmp    87b3 <fwp_write+0xf23>
    882b:	43 c6 44 27 02 00    	movb   $0x0,0x2(%r15,%r12,1)
    8831:	4c 89 ff             	mov    %r15,%rdi
    8834:	e8 d7 98 ff ff       	call   2110 <strlen@plt>
    8839:	48 89 ef             	mov    %rbp,%rdi
    883c:	4c 89 fe             	mov    %r15,%rsi
    883f:	48 89 c2             	mov    %rax,%rdx
    8842:	48 81 c4 78 02 00 00 	add    $0x278,%rsp
    8849:	5b                   	pop    %rbx
    884a:	41 5c                	pop    %r12
    884c:	41 5d                	pop    %r13
    884e:	41 5e                	pop    %r14
    8850:	41 5f                	pop    %r15
    8852:	5d                   	pop    %rbp
    8853:	e9 18 04 00 00       	jmp    8c70 <buf_put>
    8858:	48 8b 31             	mov    (%rcx),%rsi
    885b:	eb 18                	jmp    8875 <fwp_write+0xfe5>
    885d:	83 3a 00             	cmpl   $0x0,(%rdx)
    8860:	0f b6 01             	movzbl (%rcx),%eax
    8863:	48 0f be f0          	movsbq %al,%rsi
    8867:	eb 08                	jmp    8871 <fwp_write+0xfe1>
    8869:	83 3a 02             	cmpl   $0x2,(%rdx)
    886c:	8b 01                	mov    (%rcx),%eax
    886e:	48 63 f0             	movslq %eax,%rsi
    8871:	48 0f 45 f0          	cmovne %rax,%rsi
    8875:	48 8b 2c 24          	mov    (%rsp),%rbp
    8879:	48 89 ef             	mov    %rbp,%rdi
    887c:	31 c9                	xor    %ecx,%ecx
    887e:	e8 0d f0 ff ff       	call   7890 <fwp_write>
    8883:	48 b8 ff ff ff ff ff 	movabs $0x7fffffffffffffff,%rax
    888a:	ff ff 7f 
    888d:	48 ff c8             	dec    %rax
    8890:	49 85 06             	test   %rax,(%r14)
    8893:	0f 84 c9 00 00 00    	je     8962 <fwp_write+0x10d2>
    8899:	bb 01 00 00 00       	mov    $0x1,%ebx
    889e:	4c 8d 25 c5 3c 00 00 	lea    0x3cc5(%rip),%r12        # c56a <fwp_segv.msg+0x32a>
    88a5:	eb 39                	jmp    88e0 <fwp_write+0x1050>
    88a7:	83 3a 01             	cmpl   $0x1,(%rdx)
    88aa:	0f b7 04 31          	movzwl (%rcx,%rsi,1),%eax
    88ae:	48 0f bf f0          	movswq %ax,%rsi
    88b2:	48 0f 45 f0          	cmovne %rax,%rsi
    88b6:	48 8b 2c 24          	mov    (%rsp),%rbp
    88ba:	48 89 ef             	mov    %rbp,%rdi
    88bd:	31 c9                	xor    %ecx,%ecx
    88bf:	e8 cc ef ff ff       	call   7890 <fwp_write>
    88c4:	48 ff c3             	inc    %rbx
    88c7:	49 8b 06             	mov    (%r14),%rax
    88ca:	48 b9 ff ff ff ff ff 	movabs $0x7fffffffffffffff,%rcx
    88d1:	ff ff 7f 
    88d4:	48 21 c8             	and    %rcx,%rax
    88d7:	48 39 c3             	cmp    %rax,%rbx
    88da:	0f 83 82 00 00 00    	jae    8962 <fwp_write+0x10d2>
    88e0:	ba 02 00 00 00       	mov    $0x2,%edx
    88e5:	48 89 ef             	mov    %rbp,%rdi
    88e8:	4c 89 e6             	mov    %r12,%rsi
    88eb:	e8 80 03 00 00       	call   8c70 <buf_put>
    88f0:	49 8b 57 38          	mov    0x38(%r15),%rdx
    88f4:	b8 08 00 00 00       	mov    $0x8,%eax
    88f9:	48 85 d2             	test   %rdx,%rdx
    88fc:	74 13                	je     8911 <fwp_write+0x1081>
    88fe:	8b 0a                	mov    (%rdx),%ecx
    8900:	48 83 f9 0a          	cmp    $0xa,%rcx
    8904:	77 0b                	ja     8911 <fwp_write+0x1081>
    8906:	48 8d 05 53 39 00 00 	lea    0x3953(%rip),%rax        # c260 <fwp_segv.msg+0x20>
    890d:	48 8b 04 c8          	mov    (%rax,%rcx,8),%rax
    8911:	49 83 3e 00          	cmpq   $0x0,(%r14)
    8915:	4c 89 e9             	mov    %r13,%rcx
    8918:	79 04                	jns    891e <fwp_write+0x108e>
    891a:	49 8b 4e 10          	mov    0x10(%r14),%rcx
    891e:	48 89 c6             	mov    %rax,%rsi
    8921:	48 0f af f3          	imul   %rbx,%rsi
    8925:	48 83 f8 01          	cmp    $0x1,%rax
    8929:	74 19                	je     8944 <fwp_write+0x10b4>
    892b:	48 83 f8 02          	cmp    $0x2,%rax
    892f:	0f 84 72 ff ff ff    	je     88a7 <fwp_write+0x1017>
    8935:	48 83 f8 08          	cmp    $0x8,%rax
    8939:	75 19                	jne    8954 <fwp_write+0x10c4>
    893b:	48 8b 34 31          	mov    (%rcx,%rsi,1),%rsi
    893f:	e9 72 ff ff ff       	jmp    88b6 <fwp_write+0x1026>
    8944:	83 3a 00             	cmpl   $0x0,(%rdx)
    8947:	0f b6 04 31          	movzbl (%rcx,%rsi,1),%eax
    894b:	48 0f be f0          	movsbq %al,%rsi
    894f:	e9 5e ff ff ff       	jmp    88b2 <fwp_write+0x1022>
    8954:	83 3a 02             	cmpl   $0x2,(%rdx)
    8957:	8b 04 31             	mov    (%rcx,%rsi,1),%eax
    895a:	48 63 f0             	movslq %eax,%rsi
    895d:	e9 50 ff ff ff       	jmp    88b2 <fwp_write+0x1022>
    8962:	c6 44 24 70 5d       	movb   $0x5d,0x70(%rsp)
    8967:	48 8d 74 24 70       	lea    0x70(%rsp),%rsi
    896c:	ba 01 00 00 00       	mov    $0x1,%edx
    8971:	48 89 ef             	mov    %rbp,%rdi
    8974:	e9 55 01 00 00       	jmp    8ace <fwp_write+0x123e>
    8979:	48 8d 35 0a 3c 00 00 	lea    0x3c0a(%rip),%rsi        # c58a <fwp_segv.msg+0x34a>
    8980:	ba 02 00 00 00       	mov    $0x2,%edx
    8985:	48 89 ef             	mov    %rbp,%rdi
    8988:	e9 b5 fe ff ff       	jmp    8842 <fwp_write+0xfb2>
    898d:	31 c0                	xor    %eax,%eax
    898f:	c6 44 04 71 00       	movb   $0x0,0x71(%rsp,%rax,1)
    8994:	e9 1f 01 00 00       	jmp    8ab8 <fwp_write+0x1228>
    8999:	89 fa                	mov    %edi,%edx
    899b:	83 e2 1f             	and    $0x1f,%edx
    899e:	48 89 c1             	mov    %rax,%rcx
    89a1:	48 29 d1             	sub    %rdx,%rcx
    89a4:	48 8d b4 24 80 00 00 	lea    0x80(%rsp),%rsi
    89ab:	00 
    89ac:	66 0f ef c0          	pxor   %xmm0,%xmm0
    89b0:	49 89 c0             	mov    %rax,%r8
    89b3:	f3 42 0f 6f 0c 04    	movdqu (%rsp,%r8,1),%xmm1
    89b9:	f3 42 0f 6f 54 04 10 	movdqu 0x10(%rsp,%r8,1),%xmm2
    89c0:	66 0f 6f da          	movdqa %xmm2,%xmm3
    89c4:	66 0f 60 d8          	punpcklbw %xmm0,%xmm3
    89c8:	66 0f 70 db 4e       	pshufd $0x4e,%xmm3,%xmm3
    89cd:	f2 0f 70 db 1b       	pshuflw $0x1b,%xmm3,%xmm3
    89d2:	f3 0f 70 db 1b       	pshufhw $0x1b,%xmm3,%xmm3
    89d7:	66 0f 68 d0          	punpckhbw %xmm0,%xmm2
    89db:	66 0f 70 d2 4e       	pshufd $0x4e,%xmm2,%xmm2
    89e0:	f2 0f 70 d2 1b       	pshuflw $0x1b,%xmm2,%xmm2
    89e5:	f3 0f 70 d2 1b       	pshufhw $0x1b,%xmm2,%xmm2
    89ea:	66 0f 67 d3          	packuswb %xmm3,%xmm2
    89ee:	66 0f 6f d9          	movdqa %xmm1,%xmm3
    89f2:	66 0f 60 d8          	punpcklbw %xmm0,%xmm3
    89f6:	66 0f 70 db 4e       	pshufd $0x4e,%xmm3,%xmm3
    89fb:	f2 0f 70 db 1b       	pshuflw $0x1b,%xmm3,%xmm3
    8a00:	f3 0f 70 db 1b       	pshufhw $0x1b,%xmm3,%xmm3
    8a05:	66 0f 68 c8          	punpckhbw %xmm0,%xmm1
    8a09:	66 0f 70 c9 4e       	pshufd $0x4e,%xmm1,%xmm1
    8a0e:	f2 0f 70 c9 1b       	pshuflw $0x1b,%xmm1,%xmm1
    8a13:	f3 0f 70 c9 1b       	pshufhw $0x1b,%xmm1,%xmm1
    8a18:	66 0f 67 cb          	packuswb %xmm3,%xmm1
    8a1c:	66 0f 7f 56 f0       	movdqa %xmm2,-0x10(%rsi)
    8a21:	66 0f 7f 0e          	movdqa %xmm1,(%rsi)
    8a25:	49 83 c0 e0          	add    $0xffffffffffffffe0,%r8
    8a29:	48 83 c6 20          	add    $0x20,%rsi
    8a2d:	4c 39 c2             	cmp    %r8,%rdx
    8a30:	75 81                	jne    89b3 <fwp_write+0x1123>
    8a32:	48 85 d2             	test   %rdx,%rdx
    8a35:	0f 84 78 00 00 00    	je     8ab3 <fwp_write+0x1223>
    8a3b:	83 fa 08             	cmp    $0x8,%edx
    8a3e:	72 50                	jb     8a90 <fwp_write+0x1200>
    8a40:	89 fa                	mov    %edi,%edx
    8a42:	83 e2 07             	and    $0x7,%edx
    8a45:	48 89 c6             	mov    %rax,%rsi
    8a48:	48 29 ce             	sub    %rcx,%rsi
    8a4b:	48 8d 3c 0c          	lea    (%rsp,%rcx,1),%rdi
    8a4f:	48 83 c7 70          	add    $0x70,%rdi
    8a53:	48 89 c1             	mov    %rax,%rcx
    8a56:	48 29 d1             	sub    %rdx,%rcx
    8a59:	66 0f ef c0          	pxor   %xmm0,%xmm0
    8a5d:	f3 0f 7e 4c 34 18    	movq   0x18(%rsp,%rsi,1),%xmm1
    8a63:	66 0f 60 c8          	punpcklbw %xmm0,%xmm1
    8a67:	66 0f 70 c9 4e       	pshufd $0x4e,%xmm1,%xmm1
    8a6c:	f2 0f 70 c9 1b       	pshuflw $0x1b,%xmm1,%xmm1
    8a71:	f3 0f 70 c9 1b       	pshufhw $0x1b,%xmm1,%xmm1
    8a76:	66 0f 67 c9          	packuswb %xmm1,%xmm1
    8a7a:	66 0f d6 0f          	movq   %xmm1,(%rdi)
    8a7e:	48 83 c6 f8          	add    $0xfffffffffffffff8,%rsi
    8a82:	48 83 c7 08          	add    $0x8,%rdi
    8a86:	48 39 f2             	cmp    %rsi,%rdx
    8a89:	75 d2                	jne    8a5d <fwp_write+0x11cd>
    8a8b:	48 85 d2             	test   %rdx,%rdx
    8a8e:	74 23                	je     8ab3 <fwp_write+0x1223>
    8a90:	48 8d 74 24 20       	lea    0x20(%rsp),%rsi
    8a95:	48 01 f2             	add    %rsi,%rdx
    8a98:	48 ff ca             	dec    %rdx
    8a9b:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)
    8aa0:	0f b6 32             	movzbl (%rdx),%esi
    8aa3:	40 88 74 0c 70       	mov    %sil,0x70(%rsp,%rcx,1)
    8aa8:	48 ff c1             	inc    %rcx
    8aab:	48 ff ca             	dec    %rdx
    8aae:	48 39 c8             	cmp    %rcx,%rax
    8ab1:	75 ed                	jne    8aa0 <fwp_write+0x1210>
    8ab3:	c6 44 04 70 00       	movb   $0x0,0x70(%rsp,%rax,1)
    8ab8:	4c 8d 74 24 70       	lea    0x70(%rsp),%r14
    8abd:	4c 89 f7             	mov    %r14,%rdi
    8ac0:	e8 4b 96 ff ff       	call   2110 <strlen@plt>
    8ac5:	48 89 ef             	mov    %rbp,%rdi
    8ac8:	4c 89 f6             	mov    %r14,%rsi
    8acb:	48 89 c2             	mov    %rax,%rdx
    8ace:	e8 9d 01 00 00       	call   8c70 <buf_put>
    8ad3:	48 81 c4 78 02 00 00 	add    $0x278,%rsp
    8ada:	5b                   	pop    %rbx
    8adb:	41 5c                	pop    %r12
    8add:	41 5d                	pop    %r13
    8adf:	41 5e                	pop    %r14
    8ae1:	41 5f                	pop    %r15
    8ae3:	5d                   	pop    %rbp
    8ae4:	c3                   	ret
    8ae5:	83 f8 20             	cmp    $0x20,%eax
    8ae8:	73 07                	jae    8af1 <fwp_write+0x1261>
    8aea:	31 c9                	xor    %ecx,%ecx
    8aec:	e9 b6 00 00 00       	jmp    8ba7 <fwp_write+0x1317>
    8af1:	89 fe                	mov    %edi,%esi
    8af3:	89 fa                	mov    %edi,%edx
    8af5:	83 e2 1f             	and    $0x1f,%edx
    8af8:	48 89 c1             	mov    %rax,%rcx
    8afb:	48 29 d1             	sub    %rdx,%rcx
    8afe:	4c 8d 04 34          	lea    (%rsp,%rsi,1),%r8
    8b02:	49 83 c0 10          	add    $0x10,%r8
    8b06:	48 29 d6             	sub    %rdx,%rsi
    8b09:	45 31 c9             	xor    %r9d,%r9d
    8b0c:	66 0f ef c0          	pxor   %xmm0,%xmm0
    8b10:	f3 41 0f 6f 48 f0    	movdqu -0x10(%r8),%xmm1
    8b16:	f3 41 0f 6f 10       	movdqu (%r8),%xmm2
    8b1b:	66 0f 6f da          	movdqa %xmm2,%xmm3
    8b1f:	66 0f 60 d8          	punpcklbw %xmm0,%xmm3
    8b23:	66 0f 70 db 4e       	pshufd $0x4e,%xmm3,%xmm3
    8b28:	f2 0f 70 db 1b       	pshuflw $0x1b,%xmm3,%xmm3
    8b2d:	f3 0f 70 db 1b       	pshufhw $0x1b,%xmm3,%xmm3
    8b32:	66 0f 68 d0          	punpckhbw %xmm0,%xmm2
    8b36:	66 0f 70 d2 4e       	pshufd $0x4e,%xmm2,%xmm2
    8b3b:	f2 0f 70 d2 1b       	pshuflw $0x1b,%xmm2,%xmm2
    8b40:	f3 0f 70 d2 1b       	pshufhw $0x1b,%xmm2,%xmm2
    8b45:	66 0f 67 d3          	packuswb %xmm3,%xmm2
    8b49:	66 0f 6f d9          	movdqa %xmm1,%xmm3
    8b4d:	66 0f 60 d8          	punpcklbw %xmm0,%xmm3
    8b51:	66 0f 70 db 4e       	pshufd $0x4e,%xmm3,%xmm3
    8b56:	f2 0f 70 db 1b       	pshuflw $0x1b,%xmm3,%xmm3
    8b5b:	f3 0f 70 db 1b       	pshufhw $0x1b,%xmm3,%xmm3
    8b60:	66 0f 68 c8          	punpckhbw %xmm0,%xmm1
    8b64:	66 0f 70 c9 4e       	pshufd $0x4e,%xmm1,%xmm1
    8b69:	f2 0f 70 c9 1b       	pshuflw $0x1b,%xmm1,%xmm1
    8b6e:	f3 0f 70 c9 1b       	pshufhw $0x1b,%xmm1,%xmm1
    8b73:	66 0f 67 cb          	packuswb %xmm3,%xmm1
    8b77:	f3 42 0f 7f 54 0c 71 	movdqu %xmm2,0x71(%rsp,%r9,1)
    8b7e:	f3 42 0f 7f 8c 0c 81 	movdqu %xmm1,0x81(%rsp,%r9,1)
    8b85:	00 00 00 
    8b88:	49 83 c1 20          	add    $0x20,%r9
    8b8c:	49 83 c0 e0          	add    $0xffffffffffffffe0,%r8
    8b90:	4c 39 ce             	cmp    %r9,%rsi
    8b93:	0f 85 77 ff ff ff    	jne    8b10 <fwp_write+0x1280>
    8b99:	48 85 d2             	test   %rdx,%rdx
    8b9c:	0f 84 91 00 00 00    	je     8c33 <fwp_write+0x13a3>
    8ba2:	83 fa 08             	cmp    $0x8,%edx
    8ba5:	72 60                	jb     8c07 <fwp_write+0x1377>
    8ba7:	48 89 ce             	mov    %rcx,%rsi
    8baa:	41 89 f8             	mov    %edi,%r8d
    8bad:	89 fa                	mov    %edi,%edx
    8baf:	83 e2 07             	and    $0x7,%edx
    8bb2:	48 89 c1             	mov    %rax,%rcx
    8bb5:	48 29 d1             	sub    %rdx,%rcx
    8bb8:	49 89 f1             	mov    %rsi,%r9
    8bbb:	49 f7 d9             	neg    %r9
    8bbe:	49 01 e1             	add    %rsp,%r9
    8bc1:	49 83 c1 20          	add    $0x20,%r9
    8bc5:	4d 01 c1             	add    %r8,%r9
    8bc8:	49 83 c1 f8          	add    $0xfffffffffffffff8,%r9
    8bcc:	49 29 d0             	sub    %rdx,%r8
    8bcf:	66 0f ef c0          	pxor   %xmm0,%xmm0
    8bd3:	f3 41 0f 7e 09       	movq   (%r9),%xmm1
    8bd8:	66 0f 60 c8          	punpcklbw %xmm0,%xmm1
    8bdc:	66 0f 70 c9 4e       	pshufd $0x4e,%xmm1,%xmm1
    8be1:	f2 0f 70 c9 1b       	pshuflw $0x1b,%xmm1,%xmm1
    8be6:	f3 0f 70 c9 1b       	pshufhw $0x1b,%xmm1,%xmm1
    8beb:	66 0f 67 c9          	packuswb %xmm1,%xmm1
    8bef:	66 0f d6 4c 34 71    	movq   %xmm1,0x71(%rsp,%rsi,1)
    8bf5:	48 83 c6 08          	add    $0x8,%rsi
    8bf9:	49 83 c1 f8          	add    $0xfffffffffffffff8,%r9
    8bfd:	49 39 f0             	cmp    %rsi,%r8
    8c00:	75 d1                	jne    8bd3 <fwp_write+0x1343>
    8c02:	48 85 d2             	test   %rdx,%rdx
    8c05:	74 2c                	je     8c33 <fwp_write+0x13a3>
    8c07:	48 8d 74 24 20       	lea    0x20(%rsp),%rsi
    8c0c:	48 01 f2             	add    %rsi,%rdx
    8c0f:	48 ff ca             	dec    %rdx
    8c12:	89 fe                	mov    %edi,%esi
    8c14:	66 66 66 2e 0f 1f 84 	data16 data16 cs nopw 0x0(%rax,%rax,1)
    8c1b:	00 00 00 00 00 
    8c20:	0f b6 3a             	movzbl (%rdx),%edi
    8c23:	40 88 7c 0c 71       	mov    %dil,0x71(%rsp,%rcx,1)
    8c28:	48 ff c1             	inc    %rcx
    8c2b:	48 ff ca             	dec    %rdx
    8c2e:	48 39 ce             	cmp    %rcx,%rsi
    8c31:	75 ed                	jne    8c20 <fwp_write+0x1390>
    8c33:	c6 44 04 71 00       	movb   $0x0,0x71(%rsp,%rax,1)
    8c38:	e9 7b fe ff ff       	jmp    8ab8 <fwp_write+0x1228>
    8c3d:	4c 8d 74 24 70       	lea    0x70(%rsp),%r14
    8c42:	4c 89 f7             	mov    %r14,%rdi
    8c45:	f2 0f 10 44 24 10    	movsd  0x10(%rsp),%xmm0
    8c4b:	be 09 00 00 00       	mov    $0x9,%esi
    8c50:	e8 7b 0d 00 00       	call   99d0 <fwp_format_g>
    8c55:	4c 89 f7             	mov    %r14,%rdi
    8c58:	e9 bf f8 ff ff       	jmp    851c <fwp_write+0xc8c>
    8c5d:	c7 44 24 70 4e 61 4e 	movl   $0x4e614e,0x70(%rsp)
    8c64:	00 
    8c65:	e9 4e fe ff ff       	jmp    8ab8 <fwp_write+0x1228>
    8c6a:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)

0000000000008c70 <buf_put>:
    8c70:	41 57                	push   %r15
    8c72:	41 56                	push   %r14
    8c74:	41 54                	push   %r12
    8c76:	53                   	push   %rbx
    8c77:	50                   	push   %rax
    8c78:	49 89 fe             	mov    %rdi,%r14
    8c7b:	48 8b 7f 08          	mov    0x8(%rdi),%rdi
    8c7f:	48 83 ff ff          	cmp    $0xffffffffffffffff,%rdi
    8c83:	0f 84 a2 00 00 00    	je     8d2b <buf_put+0xbb>
    8c89:	48 89 d3             	mov    %rdx,%rbx
    8c8c:	48 c7 c0 fe ff ff ff 	mov    $0xfffffffffffffffe,%rax
    8c93:	48 29 f8             	sub    %rdi,%rax
    8c96:	48 39 d0             	cmp    %rdx,%rax
    8c99:	0f 82 8c 00 00 00    	jb     8d2b <buf_put+0xbb>
    8c9f:	48 8d 04 3b          	lea    (%rbx,%rdi,1),%rax
    8ca3:	48 ff c0             	inc    %rax
    8ca6:	49 8b 4e 10          	mov    0x10(%r14),%rcx
    8caa:	48 39 c8             	cmp    %rcx,%rax
    8cad:	76 30                	jbe    8cdf <buf_put+0x6f>
    8caf:	48 85 c9             	test   %rcx,%rcx
    8cb2:	41 bf 40 00 00 00    	mov    $0x40,%r15d
    8cb8:	4c 0f 45 f9          	cmovne %rcx,%r15
    8cbc:	49 89 f4             	mov    %rsi,%r12
    8cbf:	49 39 c7             	cmp    %rax,%r15
    8cc2:	73 23                	jae    8ce7 <buf_put+0x77>
    8cc4:	66 66 66 2e 0f 1f 84 	data16 data16 cs nopw 0x0(%rax,%rax,1)
    8ccb:	00 00 00 00 00 
    8cd0:	4d 85 ff             	test   %r15,%r15
    8cd3:	78 0f                	js     8ce4 <buf_put+0x74>
    8cd5:	4d 01 ff             	add    %r15,%r15
    8cd8:	49 39 c7             	cmp    %rax,%r15
    8cdb:	72 f3                	jb     8cd0 <buf_put+0x60>
    8cdd:	eb 08                	jmp    8ce7 <buf_put+0x77>
    8cdf:	49 8b 06             	mov    (%r14),%rax
    8ce2:	eb 21                	jmp    8d05 <buf_put+0x95>
    8ce4:	49 89 c7             	mov    %rax,%r15
    8ce7:	49 8b 3e             	mov    (%r14),%rdi
    8cea:	4c 89 fe             	mov    %r15,%rsi
    8ced:	e8 4e 95 ff ff       	call   2240 <realloc@plt>
    8cf2:	48 85 c0             	test   %rax,%rax
    8cf5:	74 34                	je     8d2b <buf_put+0xbb>
    8cf7:	49 89 06             	mov    %rax,(%r14)
    8cfa:	4d 89 7e 10          	mov    %r15,0x10(%r14)
    8cfe:	49 8b 7e 08          	mov    0x8(%r14),%rdi
    8d02:	4c 89 e6             	mov    %r12,%rsi
    8d05:	48 01 c7             	add    %rax,%rdi
    8d08:	48 89 da             	mov    %rbx,%rdx
    8d0b:	e8 00 95 ff ff       	call   2210 <memcpy@plt>
    8d10:	49 03 5e 08          	add    0x8(%r14),%rbx
    8d14:	49 89 5e 08          	mov    %rbx,0x8(%r14)
    8d18:	49 8b 06             	mov    (%r14),%rax
    8d1b:	c6 04 18 00          	movb   $0x0,(%rax,%rbx,1)
    8d1f:	48 83 c4 08          	add    $0x8,%rsp
    8d23:	5b                   	pop    %rbx
    8d24:	41 5c                	pop    %r12
    8d26:	41 5e                	pop    %r14
    8d28:	41 5f                	pop    %r15
    8d2a:	c3                   	ret
    8d2b:	48 8b 05 ae 62 00 00 	mov    0x62ae(%rip),%rax        # efe0 <stderr@GLIBC_2.2.5>
    8d32:	48 8b 08             	mov    (%rax),%rcx
    8d35:	48 8d 3d f4 36 00 00 	lea    0x36f4(%rip),%rdi        # c430 <fwp_segv.msg+0x1f0>
    8d3c:	be 13 00 00 00       	mov    $0x13,%esi
    8d41:	ba 01 00 00 00       	mov    $0x1,%edx
    8d46:	e8 95 95 ff ff       	call   22e0 <fwrite@plt>
    8d4b:	bf 66 00 00 00       	mov    $0x66,%edi
    8d50:	e8 7b 95 ff ff       	call   22d0 <exit@plt>
    8d55:	66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
    8d5c:	00 00 00 00 

0000000000008d60 <fwp_escape>:
    8d60:	55                   	push   %rbp
    8d61:	41 57                	push   %r15
    8d63:	41 56                	push   %r14
    8d65:	41 55                	push   %r13
    8d67:	41 54                	push   %r12
    8d69:	53                   	push   %rbx
    8d6a:	48 83 ec 18          	sub    $0x18,%rsp
    8d6e:	49 89 d6             	mov    %rdx,%r14
    8d71:	49 89 f7             	mov    %rsi,%r15
    8d74:	48 89 fb             	mov    %rdi,%rbx
    8d77:	c6 04 24 22          	movb   $0x22,(%rsp)
    8d7b:	48 89 e6             	mov    %rsp,%rsi
    8d7e:	ba 01 00 00 00       	mov    $0x1,%edx
    8d83:	e8 e8 fe ff ff       	call   8c70 <buf_put>
    8d88:	4d 85 f6             	test   %r14,%r14
    8d8b:	0f 84 de 00 00 00    	je     8e6f <fwp_escape+0x10f>
    8d91:	48 89 e5             	mov    %rsp,%rbp
    8d94:	4c 8d 2d 21 34 00 00 	lea    0x3421(%rip),%r13        # c1bc <_IO_stdin_used+0x1bc>
    8d9b:	45 31 e4             	xor    %r12d,%r12d
    8d9e:	eb 21                	jmp    8dc1 <fwp_escape+0x61>
    8da0:	ba 02 00 00 00       	mov    $0x2,%edx
    8da5:	48 89 df             	mov    %rbx,%rdi
    8da8:	48 8d 35 0e 38 00 00 	lea    0x380e(%rip),%rsi        # c5bd <fwp_segv.msg+0x37d>
    8daf:	90                   	nop
    8db0:	e8 bb fe ff ff       	call   8c70 <buf_put>
    8db5:	49 ff c4             	inc    %r12
    8db8:	4d 39 e6             	cmp    %r12,%r14
    8dbb:	0f 84 ae 00 00 00    	je     8e6f <fwp_escape+0x10f>
    8dc1:	43 0f b6 04 27       	movzbl (%r15,%r12,1),%eax
    8dc6:	0f b6 c8             	movzbl %al,%ecx
    8dc9:	8d 51 f7             	lea    -0x9(%rcx),%edx
    8dcc:	83 fa 19             	cmp    $0x19,%edx
    8dcf:	77 1f                	ja     8df0 <fwp_escape+0x90>
    8dd1:	49 63 54 95 00       	movslq 0x0(%r13,%rdx,4),%rdx
    8dd6:	4c 01 ea             	add    %r13,%rdx
    8dd9:	ff e2                	jmp    *%rdx
    8ddb:	ba 02 00 00 00       	mov    $0x2,%edx
    8de0:	48 89 df             	mov    %rbx,%rdi
    8de3:	48 8d 35 d0 37 00 00 	lea    0x37d0(%rip),%rsi        # c5ba <fwp_segv.msg+0x37a>
    8dea:	eb c4                	jmp    8db0 <fwp_escape+0x50>
    8dec:	0f 1f 40 00          	nopl   0x0(%rax)
    8df0:	83 f9 5c             	cmp    $0x5c,%ecx
    8df3:	75 11                	jne    8e06 <fwp_escape+0xa6>
    8df5:	ba 02 00 00 00       	mov    $0x2,%edx
    8dfa:	48 89 df             	mov    %rbx,%rdi
    8dfd:	48 8d 35 b0 37 00 00 	lea    0x37b0(%rip),%rsi        # c5b4 <fwp_segv.msg+0x374>
    8e04:	eb aa                	jmp    8db0 <fwp_escape+0x50>
    8e06:	3c 20                	cmp    $0x20,%al
    8e08:	72 39                	jb     8e43 <fwp_escape+0xe3>
    8e0a:	3c 7f                	cmp    $0x7f,%al
    8e0c:	74 35                	je     8e43 <fwp_escape+0xe3>
    8e0e:	88 04 24             	mov    %al,(%rsp)
    8e11:	ba 01 00 00 00       	mov    $0x1,%edx
    8e16:	48 89 df             	mov    %rbx,%rdi
    8e19:	48 89 ee             	mov    %rbp,%rsi
    8e1c:	eb 92                	jmp    8db0 <fwp_escape+0x50>
    8e1e:	ba 02 00 00 00       	mov    $0x2,%edx
    8e23:	48 89 df             	mov    %rbx,%rdi
    8e26:	48 8d 35 84 37 00 00 	lea    0x3784(%rip),%rsi        # c5b1 <fwp_segv.msg+0x371>
    8e2d:	eb 81                	jmp    8db0 <fwp_escape+0x50>
    8e2f:	ba 02 00 00 00       	mov    $0x2,%edx
    8e34:	48 89 df             	mov    %rbx,%rdi
    8e37:	48 8d 35 79 37 00 00 	lea    0x3779(%rip),%rsi        # c5b7 <fwp_segv.msg+0x377>
    8e3e:	e9 6d ff ff ff       	jmp    8db0 <fwp_escape+0x50>
    8e43:	be 10 00 00 00       	mov    $0x10,%esi
    8e48:	48 89 ef             	mov    %rbp,%rdi
    8e4b:	48 8d 15 6e 37 00 00 	lea    0x376e(%rip),%rdx        # c5c0 <fwp_segv.msg+0x380>
    8e52:	31 c0                	xor    %eax,%eax
    8e54:	e8 e7 92 ff ff       	call   2140 <snprintf@plt>
    8e59:	48 89 ef             	mov    %rbp,%rdi
    8e5c:	e8 af 92 ff ff       	call   2110 <strlen@plt>
    8e61:	48 89 df             	mov    %rbx,%rdi
    8e64:	48 89 ee             	mov    %rbp,%rsi
    8e67:	48 89 c2             	mov    %rax,%rdx
    8e6a:	e9 41 ff ff ff       	jmp    8db0 <fwp_escape+0x50>
    8e6f:	c6 04 24 22          	movb   $0x22,(%rsp)
    8e73:	48 89 e6             	mov    %rsp,%rsi
    8e76:	ba 01 00 00 00       	mov    $0x1,%edx
    8e7b:	48 89 df             	mov    %rbx,%rdi
    8e7e:	e8 ed fd ff ff       	call   8c70 <buf_put>
    8e83:	48 83 c4 18          	add    $0x18,%rsp
    8e87:	5b                   	pop    %rbx
    8e88:	41 5c                	pop    %r12
    8e8a:	41 5d                	pop    %r13
    8e8c:	41 5e                	pop    %r14
    8e8e:	41 5f                	pop    %r15
    8e90:	5d                   	pop    %rbp
    8e91:	c3                   	ret
    8e92:	66 66 66 66 66 2e 0f 	data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    8e99:	1f 84 00 00 00 00 00 

0000000000008ea0 <fwp_fmt_duration>:
    8ea0:	41 57                	push   %r15
    8ea2:	41 56                	push   %r14
    8ea4:	41 54                	push   %r12
    8ea6:	53                   	push   %rbx
    8ea7:	48 81 ec 88 00 00 00 	sub    $0x88,%rsp
    8eae:	48 89 f0             	mov    %rsi,%rax
    8eb1:	48 09 d0             	or     %rdx,%rax
    8eb4:	0f 84 bf 02 00 00    	je     9179 <fwp_fmt_duration+0x2d9>
    8eba:	49 89 d0             	mov    %rdx,%r8
    8ebd:	48 b9 1d 3f c2 25 d6 	movabs $0xd2fe1d625c23f1d,%rcx
    8ec4:	e1 2f 0d 
    8ec7:	48 0f af ce          	imul   %rsi,%rcx
    8ecb:	49 b9 0d b1 f3 e4 99 	movabs $0x1c52799e4f3b10d,%r9
    8ed2:	27 c5 01 
    8ed5:	48 89 f0             	mov    %rsi,%rax
    8ed8:	49 f7 e1             	mul    %r9
    8edb:	48 01 ca             	add    %rcx,%rdx
    8ede:	4d 0f af c8          	imul   %r8,%r9
    8ee2:	49 01 d1             	add    %rdx,%r9
    8ee5:	48 b9 00 a0 34 52 a3 	movabs $0x6baf6aa35234a000,%rcx
    8eec:	6a af 6b 
    8eef:	48 01 c1             	add    %rax,%rcx
    8ef2:	48 b8 37 f9 ff e2 04 	movabs $0x4e2fff937,%rax
    8ef9:	00 00 00 
    8efc:	4c 11 c8             	adc    %r9,%rax
    8eff:	48 89 c2             	mov    %rax,%rdx
    8f02:	48 0f ac ca 0d       	shrd   $0xd,%rcx,%rdx
    8f07:	48 0f a4 c8 33       	shld   $0x33,%rcx,%rax
    8f0c:	48 b9 4a 23 35 aa f6 	movabs $0x9376baf6aa35234a,%rcx
    8f13:	ba 76 93 
    8f16:	48 39 c1             	cmp    %rax,%rcx
    8f19:	b8 ff 2f 4e 00       	mov    $0x4e2fff,%eax
    8f1e:	48 19 d0             	sbb    %rdx,%rax
    8f21:	0f 83 70 02 00 00    	jae    9197 <fwp_fmt_duration+0x2f7>
    8f27:	48 b9 b3 b2 61 36 8c 	movabs $0xc5ce3b8c3661b2b3,%rcx
    8f2e:	3b ce c5 
    8f31:	49 b9 c3 5f 47 6a 04 	movabs $0x1a8d52046a475fc3,%r9
    8f38:	52 8d 1a 
    8f3b:	48 89 f0             	mov    %rsi,%rax
    8f3e:	49 f7 e1             	mul    %r9
    8f41:	48 0f af ce          	imul   %rsi,%rcx
    8f45:	48 01 ca             	add    %rcx,%rdx
    8f48:	4d 0f af c8          	imul   %r8,%r9
    8f4c:	49 01 d1             	add    %rdx,%r9
    8f4f:	48 b9 00 a8 16 d1 91 	movabs $0x4f473f91d116a800,%rcx
    8f56:	3f 47 4f 
    8f59:	48 01 c1             	add    %rax,%rcx
    8f5c:	48 b8 3f 9a ff 4c 49 	movabs $0x494cff9a3f,%rax
    8f63:	00 00 00 
    8f66:	4c 11 c8             	adc    %r9,%rax
    8f69:	48 89 c2             	mov    %rax,%rdx
    8f6c:	48 0f ac ca 0b       	shrd   $0xb,%rcx,%rdx
    8f71:	48 0f a4 c8 35       	shld   $0x35,%rcx,%rax
    8f76:	48 b9 ab 45 74 e4 cf 	movabs $0x8fd3d1cfe47445ab,%rcx
    8f7d:	d1 d3 8f 
    8f80:	48 39 c8             	cmp    %rcx,%rax
    8f83:	48 81 da e6 3f 53 12 	sbb    $0x12533fe6,%rdx
    8f8a:	0f 82 27 02 00 00    	jb     91b7 <fwp_fmt_duration+0x317>
    8f90:	48 b9 7e 78 b9 2f 37 	movabs $0x97157d372fb9787e,%rcx
    8f97:	7d 15 97 
    8f9a:	48 0f af ce          	imul   %rsi,%rcx
    8f9e:	49 b9 6d 9c 2e 3a 42 	movabs $0x8e47ce423a2e9c6d,%r9
    8fa5:	ce 47 8e 
    8fa8:	48 89 f0             	mov    %rsi,%rax
    8fab:	49 f7 e1             	mul    %r9
    8fae:	48 01 ca             	add    %rcx,%rdx
    8fb1:	4d 0f af c8          	imul   %r8,%r9
    8fb5:	49 01 d1             	add    %rdx,%r9
    8fb8:	48 b9 00 46 54 40 8b 	movabs $0xa52cb98b40544600,%rcx
    8fbf:	b9 2c a5 
    8fc2:	48 01 c1             	add    %rax,%rcx
    8fc5:	48 b8 b5 09 fa 82 4b 	movabs $0x44b82fa09b5,%rax
    8fcc:	04 00 00 
    8fcf:	4c 11 c8             	adc    %r9,%rax
    8fd2:	48 89 c2             	mov    %rax,%rdx
    8fd5:	48 0f ac ca 09       	shrd   $0x9,%rcx,%rdx
    8fda:	48 0f a4 c8 37       	shld   $0x37,%rcx,%rax
    8fdf:	48 b9 47 54 40 8b b9 	movabs $0xb5a52cb98b405447,%rcx
    8fe6:	2c a5 b5 
    8fe9:	48 39 c8             	cmp    %rcx,%rax
    8fec:	48 b8 09 fa 82 4b 04 	movabs $0x44b82fa09,%rax
    8ff3:	00 00 00 
    8ff6:	48 19 c2             	sbb    %rax,%rdx
    8ff9:	0f 82 0d 03 00 00    	jb     930c <fwp_fmt_duration+0x46c>
    8fff:	48 b9 cb d5 8f 4d f2 	movabs $0xc57e23f24d8fd5cb,%rcx
    9006:	23 7e c5 
    9009:	48 0f af ce          	imul   %rsi,%rcx
    900d:	49 b9 39 61 c2 68 56 	movabs $0x790fb65668c26139,%r9
    9014:	b6 0f 79 
    9017:	48 89 f0             	mov    %rsi,%rax
    901a:	49 f7 e1             	mul    %r9
    901d:	48 01 ca             	add    %rcx,%rdx
    9020:	4d 0f af c8          	imul   %r8,%r9
    9024:	49 01 d1             	add    %rdx,%r9
    9027:	48 b9 00 0b 27 69 fe 	movabs $0xa6d698fe69270b00,%rcx
    902e:	98 d6 a6 
    9031:	48 01 c1             	add    %rax,%rcx
    9034:	48 b8 b1 bd 16 f4 de 	movabs $0x218def416bdb1,%rax
    903b:	18 02 00 
    903e:	4c 11 c8             	adc    %r9,%rax
    9041:	48 89 c2             	mov    %rax,%rdx
    9044:	48 0f ac ca 06       	shrd   $0x6,%rcx,%rdx
    9049:	48 0f a4 c8 3a       	shld   $0x3a,%rcx,%rax
    904e:	48 b9 59 38 49 f3 c7 	movabs $0x8d36b4c7f3493859,%rcx
    9055:	b4 36 8d 
    9058:	48 39 c8             	cmp    %rcx,%rax
    905b:	48 b8 ed b5 a0 f7 c6 	movabs $0x10c6f7a0b5ed,%rax
    9062:	10 00 00 
    9065:	48 19 c2             	sbb    %rax,%rdx
    9068:	0f 82 ad 02 00 00    	jb     931b <fwp_fmt_duration+0x47b>
    906e:	48 b9 5a 64 3b df 4f 	movabs $0x6e978d4fdf3b645a,%rcx
    9075:	8d 97 6e 
    9078:	48 0f af ce          	imul   %rsi,%rcx
    907c:	49 b9 d5 78 e9 26 31 	movabs $0x1cac083126e978d5,%r9
    9083:	08 ac 1c 
    9086:	48 89 f0             	mov    %rsi,%rax
    9089:	49 f7 e1             	mul    %r9
    908c:	48 01 ca             	add    %rcx,%rdx
    908f:	4d 0f af c8          	imul   %r8,%r9
    9093:	49 01 d1             	add    %rdx,%r9
    9096:	48 b9 48 62 10 58 39 	movabs $0x76c8b43958106248,%rcx
    909d:	b4 c8 76 
    90a0:	48 01 c1             	add    %rax,%rcx
    90a3:	48 b8 be 9f 1a 2f dd 	movabs $0x10624dd2f1a9fbe,%rax
    90aa:	24 06 01 
    90ad:	4c 11 c8             	adc    %r9,%rax
    90b0:	48 89 c2             	mov    %rax,%rdx
    90b3:	48 0f ac ca 03       	shrd   $0x3,%rcx,%rdx
    90b8:	48 0f a4 c8 3d       	shld   $0x3d,%rcx,%rax
    90bd:	48 b9 93 18 04 56 0e 	movabs $0x9db22d0e56041893,%rcx
    90c4:	2d b2 9d 
    90c7:	48 39 c8             	cmp    %rcx,%rax
    90ca:	48 b8 ef a7 c6 4b 37 	movabs $0x4189374bc6a7ef,%rax
    90d1:	89 41 00 
    90d4:	48 19 c2             	sbb    %rax,%rdx
    90d7:	0f 82 4d 02 00 00    	jb     932a <fwp_fmt_duration+0x48a>
    90dd:	4d 85 c0             	test   %r8,%r8
    90e0:	0f 88 d6 06 00 00    	js     97bc <fwp_fmt_duration+0x91c>
    90e6:	45 31 d2             	xor    %r10d,%r10d
    90e9:	49 bb cd cc cc cc cc 	movabs $0xcccccccccccccccd,%r11
    90f0:	cc cc cc 
    90f3:	48 bb cc cc cc cc cc 	movabs $0xcccccccccccccccc,%rbx
    90fa:	cc cc cc 
    90fd:	4d 89 c6             	mov    %r8,%r14
    9100:	4c 89 c1             	mov    %r8,%rcx
    9103:	48 0f a4 f1 3f       	shld   $0x3f,%rsi,%rcx
    9108:	49 d1 ee             	shr    $1,%r14
    910b:	49 89 c9             	mov    %rcx,%r9
    910e:	4d 01 f1             	add    %r14,%r9
    9111:	49 83 d1 00          	adc    $0x0,%r9
    9115:	4c 89 c8             	mov    %r9,%rax
    9118:	49 f7 e3             	mul    %r11
    911b:	48 c1 ea 02          	shr    $0x2,%rdx
    911f:	48 8d 04 92          	lea    (%rdx,%rdx,4),%rax
    9123:	49 29 c1             	sub    %rax,%r9
    9126:	4c 29 c9             	sub    %r9,%rcx
    9129:	49 83 de 00          	sbb    $0x0,%r14
    912d:	49 89 c9             	mov    %rcx,%r9
    9130:	4c 0f af cb          	imul   %rbx,%r9
    9134:	48 89 c8             	mov    %rcx,%rax
    9137:	49 f7 e3             	mul    %r11
    913a:	4c 01 ca             	add    %r9,%rdx
    913d:	4d 0f af f3          	imul   %r11,%r14
    9141:	49 01 d6             	add    %rdx,%r14
    9144:	48 89 c1             	mov    %rax,%rcx
    9147:	48 01 c1             	add    %rax,%rcx
    914a:	48 8d 0c 89          	lea    (%rcx,%rcx,4),%rcx
    914e:	89 f2                	mov    %esi,%edx
    9150:	29 ca                	sub    %ecx,%edx
    9152:	80 ca 30             	or     $0x30,%dl
    9155:	42 88 54 14 40       	mov    %dl,0x40(%rsp,%r10,1)
    915a:	49 ff c2             	inc    %r10
    915d:	48 83 fe 0a          	cmp    $0xa,%rsi
    9161:	49 83 d8 00          	sbb    $0x0,%r8
    9165:	48 89 c6             	mov    %rax,%rsi
    9168:	4d 89 f0             	mov    %r14,%r8
    916b:	73 93                	jae    9100 <fwp_fmt_duration+0x260>
    916d:	45 85 d2             	test   %r10d,%r10d
    9170:	7f 12                	jg     9184 <fwp_fmt_duration+0x2e4>
    9172:	31 c0                	xor    %eax,%eax
    9174:	e9 79 01 00 00       	jmp    92f2 <fwp_fmt_duration+0x452>
    9179:	c6 44 24 40 30       	movb   $0x30,0x40(%rsp)
    917e:	41 ba 01 00 00 00    	mov    $0x1,%r10d
    9184:	44 89 d0             	mov    %r10d,%eax
    9187:	48 83 f8 08          	cmp    $0x8,%rax
    918b:	73 1e                	jae    91ab <fwp_fmt_duration+0x30b>
    918d:	31 c9                	xor    %ecx,%ecx
    918f:	48 89 c2             	mov    %rax,%rdx
    9192:	e9 3d 01 00 00       	jmp    92d4 <fwp_fmt_duration+0x434>
    9197:	49 89 fe             	mov    %rdi,%r14
    919a:	48 ba 00 a0 b8 30 46 	movabs $0x34630b8a000,%rdx
    91a1:	03 00 00 
    91a4:	31 c0                	xor    %eax,%eax
    91a6:	e9 8c 01 00 00       	jmp    9337 <fwp_fmt_duration+0x497>
    91ab:	83 f8 20             	cmp    $0x20,%eax
    91ae:	73 1e                	jae    91ce <fwp_fmt_duration+0x32e>
    91b0:	31 c9                	xor    %ecx,%ecx
    91b2:	e9 c3 00 00 00       	jmp    927a <fwp_fmt_duration+0x3da>
    91b7:	49 89 fe             	mov    %rdi,%r14
    91ba:	48 ba 00 58 47 f8 0d 	movabs $0xdf8475800,%rdx
    91c1:	00 00 00 
    91c4:	b8 01 00 00 00       	mov    $0x1,%eax
    91c9:	e9 69 01 00 00       	jmp    9337 <fwp_fmt_duration+0x497>
    91ce:	44 89 d2             	mov    %r10d,%edx
    91d1:	83 e2 1f             	and    $0x1f,%edx
    91d4:	48 89 c1             	mov    %rax,%rcx
    91d7:	48 29 d1             	sub    %rdx,%rcx
    91da:	48 8d 74 24 10       	lea    0x10(%rsp),%rsi
    91df:	66 0f ef c0          	pxor   %xmm0,%xmm0
    91e3:	49 89 c0             	mov    %rax,%r8
    91e6:	66 2e 0f 1f 84 00 00 	cs nopw 0x0(%rax,%rax,1)
    91ed:	00 00 00 
    91f0:	f3 42 0f 6f 4c 04 20 	movdqu 0x20(%rsp,%r8,1),%xmm1
    91f7:	f3 42 0f 6f 54 04 30 	movdqu 0x30(%rsp,%r8,1),%xmm2
    91fe:	66 0f 6f da          	movdqa %xmm2,%xmm3
    9202:	66 0f 60 d8          	punpcklbw %xmm0,%xmm3
    9206:	66 0f 70 db 4e       	pshufd $0x4e,%xmm3,%xmm3
    920b:	f2 0f 70 db 1b       	pshuflw $0x1b,%xmm3,%xmm3
    9210:	f3 0f 70 db 1b       	pshufhw $0x1b,%xmm3,%xmm3
    9215:	66 0f 68 d0          	punpckhbw %xmm0,%xmm2
    9219:	66 0f 70 d2 4e       	pshufd $0x4e,%xmm2,%xmm2
    921e:	f2 0f 70 d2 1b       	pshuflw $0x1b,%xmm2,%xmm2
    9223:	f3 0f 70 d2 1b       	pshufhw $0x1b,%xmm2,%xmm2
    9228:	66 0f 67 d3          	packuswb %xmm3,%xmm2
    922c:	66 0f 6f d9          	movdqa %xmm1,%xmm3
    9230:	66 0f 60 d8          	punpcklbw %xmm0,%xmm3
    9234:	66 0f 70 db 4e       	pshufd $0x4e,%xmm3,%xmm3
    9239:	f2 0f 70 db 1b       	pshuflw $0x1b,%xmm3,%xmm3
    923e:	f3 0f 70 db 1b       	pshufhw $0x1b,%xmm3,%xmm3
    9243:	66 0f 68 c8          	punpckhbw %xmm0,%xmm1
    9247:	66 0f 70 c9 4e       	pshufd $0x4e,%xmm1,%xmm1
    924c:	f2 0f 70 c9 1b       	pshuflw $0x1b,%xmm1,%xmm1
    9251:	f3 0f 70 c9 1b       	pshufhw $0x1b,%xmm1,%xmm1
    9256:	66 0f 67 cb          	packuswb %xmm3,%xmm1
    925a:	66 0f 7f 56 f0       	movdqa %xmm2,-0x10(%rsi)
    925f:	66 0f 7f 0e          	movdqa %xmm1,(%rsi)
    9263:	49 83 c0 e0          	add    $0xffffffffffffffe0,%r8
    9267:	48 83 c6 20          	add    $0x20,%rsi
    926b:	4c 39 c2             	cmp    %r8,%rdx
    926e:	75 80                	jne    91f0 <fwp_fmt_duration+0x350>
    9270:	48 85 d2             	test   %rdx,%rdx
    9273:	74 7d                	je     92f2 <fwp_fmt_duration+0x452>
    9275:	83 fa 08             	cmp    $0x8,%edx
    9278:	72 5a                	jb     92d4 <fwp_fmt_duration+0x434>
    927a:	44 89 d2             	mov    %r10d,%edx
    927d:	83 e2 07             	and    $0x7,%edx
    9280:	48 89 c6             	mov    %rax,%rsi
    9283:	48 29 ce             	sub    %rcx,%rsi
    9286:	4c 8d 04 0c          	lea    (%rsp,%rcx,1),%r8
    928a:	48 89 c1             	mov    %rax,%rcx
    928d:	48 29 d1             	sub    %rdx,%rcx
    9290:	66 0f ef c0          	pxor   %xmm0,%xmm0
    9294:	66 66 66 2e 0f 1f 84 	data16 data16 cs nopw 0x0(%rax,%rax,1)
    929b:	00 00 00 00 00 
    92a0:	f3 0f 7e 4c 34 38    	movq   0x38(%rsp,%rsi,1),%xmm1
    92a6:	66 0f 60 c8          	punpcklbw %xmm0,%xmm1
    92aa:	66 0f 70 c9 4e       	pshufd $0x4e,%xmm1,%xmm1
    92af:	f2 0f 70 c9 1b       	pshuflw $0x1b,%xmm1,%xmm1
    92b4:	f3 0f 70 c9 1b       	pshufhw $0x1b,%xmm1,%xmm1
    92b9:	66 0f 67 c9          	packuswb %xmm1,%xmm1
    92bd:	66 41 0f d6 08       	movq   %xmm1,(%r8)
    92c2:	48 83 c6 f8          	add    $0xfffffffffffffff8,%rsi
    92c6:	49 83 c0 08          	add    $0x8,%r8
    92ca:	48 39 f2             	cmp    %rsi,%rdx
    92cd:	75 d1                	jne    92a0 <fwp_fmt_duration+0x400>
    92cf:	48 85 d2             	test   %rdx,%rdx
    92d2:	74 1e                	je     92f2 <fwp_fmt_duration+0x452>
    92d4:	48 8d 74 24 40       	lea    0x40(%rsp),%rsi
    92d9:	48 01 f2             	add    %rsi,%rdx
    92dc:	48 ff ca             	dec    %rdx
    92df:	90                   	nop
    92e0:	0f b6 32             	movzbl (%rdx),%esi
    92e3:	40 88 34 0c          	mov    %sil,(%rsp,%rcx,1)
    92e7:	48 ff c1             	inc    %rcx
    92ea:	48 ff ca             	dec    %rdx
    92ed:	48 39 c8             	cmp    %rcx,%rax
    92f0:	75 ee                	jne    92e0 <fwp_fmt_duration+0x440>
    92f2:	c6 04 04 00          	movb   $0x0,(%rsp,%rax,1)
    92f6:	48 8d 35 d6 32 00 00 	lea    0x32d6(%rip),%rsi        # c5d3 <fwp_segv.msg+0x393>
    92fd:	48 89 e2             	mov    %rsp,%rdx
    9300:	31 c0                	xor    %eax,%eax
    9302:	e8 b9 8f ff ff       	call   22c0 <sprintf@plt>
    9307:	e9 a1 04 00 00       	jmp    97ad <fwp_fmt_duration+0x90d>
    930c:	49 89 fe             	mov    %rdi,%r14
    930f:	ba 00 ca 9a 3b       	mov    $0x3b9aca00,%edx
    9314:	b8 02 00 00 00       	mov    $0x2,%eax
    9319:	eb 1c                	jmp    9337 <fwp_fmt_duration+0x497>
    931b:	49 89 fe             	mov    %rdi,%r14
    931e:	ba 40 42 0f 00       	mov    $0xf4240,%edx
    9323:	b8 03 00 00 00       	mov    $0x3,%eax
    9328:	eb 0d                	jmp    9337 <fwp_fmt_duration+0x497>
    932a:	49 89 fe             	mov    %rdi,%r14
    932d:	ba e8 03 00 00       	mov    $0x3e8,%edx
    9332:	b8 04 00 00 00       	mov    $0x4,%eax
    9337:	31 c9                	xor    %ecx,%ecx
    9339:	c1 e0 04             	shl    $0x4,%eax
    933c:	48 8d 1d cd 58 00 00 	lea    0x58cd(%rip),%rbx        # ec10 <fwp_fmt_duration.units>
    9343:	48 01 c3             	add    %rax,%rbx
    9346:	48 89 f7             	mov    %rsi,%rdi
    9349:	4c 89 c6             	mov    %r8,%rsi
    934c:	e8 4f 1d 00 00       	call   b0a0 <__divti3>
    9351:	48 89 c1             	mov    %rax,%rcx
    9354:	48 89 d6             	mov    %rdx,%rsi
    9357:	48 85 d2             	test   %rdx,%rdx
    935a:	0f 88 b0 00 00 00    	js     9410 <fwp_fmt_duration+0x570>
    9360:	48 89 c8             	mov    %rcx,%rax
    9363:	48 09 f0             	or     %rsi,%rax
    9366:	0f 84 61 01 00 00    	je     94cd <fwp_fmt_duration+0x62d>
    936c:	45 31 d2             	xor    %r10d,%r10d
    936f:	49 bb cd cc cc cc cc 	movabs $0xcccccccccccccccd,%r11
    9376:	cc cc cc 
    9379:	49 bf cc cc cc cc cc 	movabs $0xcccccccccccccccc,%r15
    9380:	cc cc cc 
    9383:	49 89 f4             	mov    %rsi,%r12
    9386:	4c 89 f7             	mov    %r14,%rdi
    9389:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)
    9390:	49 89 f0             	mov    %rsi,%r8
    9393:	49 0f a4 c8 3f       	shld   $0x3f,%rcx,%r8
    9398:	49 d1 ec             	shr    $1,%r12
    939b:	4d 89 c1             	mov    %r8,%r9
    939e:	4d 01 e1             	add    %r12,%r9
    93a1:	49 83 d1 00          	adc    $0x0,%r9
    93a5:	4c 89 c8             	mov    %r9,%rax
    93a8:	49 f7 e3             	mul    %r11
    93ab:	48 c1 ea 02          	shr    $0x2,%rdx
    93af:	48 8d 04 92          	lea    (%rdx,%rdx,4),%rax
    93b3:	49 29 c1             	sub    %rax,%r9
    93b6:	4d 29 c8             	sub    %r9,%r8
    93b9:	49 83 dc 00          	sbb    $0x0,%r12
    93bd:	4d 89 c1             	mov    %r8,%r9
    93c0:	4d 0f af cf          	imul   %r15,%r9
    93c4:	4c 89 c0             	mov    %r8,%rax
    93c7:	49 f7 e3             	mul    %r11
    93ca:	4c 01 ca             	add    %r9,%rdx
    93cd:	4d 0f af e3          	imul   %r11,%r12
    93d1:	49 01 d4             	add    %rdx,%r12
    93d4:	48 89 c2             	mov    %rax,%rdx
    93d7:	48 01 c2             	add    %rax,%rdx
    93da:	48 8d 14 92          	lea    (%rdx,%rdx,4),%rdx
    93de:	41 89 c8             	mov    %ecx,%r8d
    93e1:	41 29 d0             	sub    %edx,%r8d
    93e4:	41 80 c8 30          	or     $0x30,%r8b
    93e8:	46 88 44 14 40       	mov    %r8b,0x40(%rsp,%r10,1)
    93ed:	49 ff c2             	inc    %r10
    93f0:	48 83 f9 0a          	cmp    $0xa,%rcx
    93f4:	48 83 de 00          	sbb    $0x0,%rsi
    93f8:	48 89 c1             	mov    %rax,%rcx
    93fb:	4c 89 e6             	mov    %r12,%rsi
    93fe:	73 90                	jae    9390 <fwp_fmt_duration+0x4f0>
    9400:	45 85 d2             	test   %r10d,%r10d
    9403:	0f 8f d2 00 00 00    	jg     94db <fwp_fmt_duration+0x63b>
    9409:	31 c0                	xor    %eax,%eax
    940b:	e9 12 02 00 00       	jmp    9622 <fwp_fmt_duration+0x782>
    9410:	45 31 c0             	xor    %r8d,%r8d
    9413:	48 f7 d9             	neg    %rcx
    9416:	41 b9 00 00 00 00    	mov    $0x0,%r9d
    941c:	49 19 f1             	sbb    %rsi,%r9
    941f:	c6 04 24 2d          	movb   $0x2d,(%rsp)
    9423:	49 ba cd cc cc cc cc 	movabs $0xcccccccccccccccd,%r10
    942a:	cc cc cc 
    942d:	49 bb cc cc cc cc cc 	movabs $0xcccccccccccccccc,%r11
    9434:	cc cc cc 
    9437:	4d 89 cf             	mov    %r9,%r15
    943a:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)
    9440:	4c 89 ce             	mov    %r9,%rsi
    9443:	48 0f a4 ce 3f       	shld   $0x3f,%rcx,%rsi
    9448:	49 d1 ef             	shr    $1,%r15
    944b:	48 89 f7             	mov    %rsi,%rdi
    944e:	4c 01 ff             	add    %r15,%rdi
    9451:	48 83 d7 00          	adc    $0x0,%rdi
    9455:	48 89 f8             	mov    %rdi,%rax
    9458:	49 f7 e2             	mul    %r10
    945b:	48 c1 ea 02          	shr    $0x2,%rdx
    945f:	48 8d 04 92          	lea    (%rdx,%rdx,4),%rax
    9463:	48 29 c7             	sub    %rax,%rdi
    9466:	48 29 fe             	sub    %rdi,%rsi
    9469:	49 83 df 00          	sbb    $0x0,%r15
    946d:	48 89 f7             	mov    %rsi,%rdi
    9470:	49 0f af fb          	imul   %r11,%rdi
    9474:	48 89 f0             	mov    %rsi,%rax
    9477:	49 f7 e2             	mul    %r10
    947a:	48 01 fa             	add    %rdi,%rdx
    947d:	4d 0f af fa          	imul   %r10,%r15
    9481:	49 01 d7             	add    %rdx,%r15
    9484:	48 89 c2             	mov    %rax,%rdx
    9487:	48 01 c2             	add    %rax,%rdx
    948a:	48 8d 14 92          	lea    (%rdx,%rdx,4),%rdx
    948e:	89 ce                	mov    %ecx,%esi
    9490:	29 d6                	sub    %edx,%esi
    9492:	40 80 ce 30          	or     $0x30,%sil
    9496:	42 88 74 04 40       	mov    %sil,0x40(%rsp,%r8,1)
    949b:	49 ff c0             	inc    %r8
    949e:	48 83 f9 0a          	cmp    $0xa,%rcx
    94a2:	49 83 d9 00          	sbb    $0x0,%r9
    94a6:	48 89 c1             	mov    %rax,%rcx
    94a9:	4d 89 f9             	mov    %r15,%r9
    94ac:	73 92                	jae    9440 <fwp_fmt_duration+0x5a0>
    94ae:	45 85 c0             	test   %r8d,%r8d
    94b1:	4c 89 f7             	mov    %r14,%rdi
    94b4:	7e 44                	jle    94fa <fwp_fmt_duration+0x65a>
    94b6:	44 89 c0             	mov    %r8d,%eax
    94b9:	48 83 f8 08          	cmp    $0x8,%rax
    94bd:	0f 83 68 01 00 00    	jae    962b <fwp_fmt_duration+0x78b>
    94c3:	31 c9                	xor    %ecx,%ecx
    94c5:	48 89 c2             	mov    %rax,%rdx
    94c8:	e9 97 02 00 00       	jmp    9764 <fwp_fmt_duration+0x8c4>
    94cd:	c6 44 24 40 30       	movb   $0x30,0x40(%rsp)
    94d2:	41 ba 01 00 00 00    	mov    $0x1,%r10d
    94d8:	4c 89 f7             	mov    %r14,%rdi
    94db:	44 89 d0             	mov    %r10d,%eax
    94de:	48 83 f8 08          	cmp    $0x8,%rax
    94e2:	73 0a                	jae    94ee <fwp_fmt_duration+0x64e>
    94e4:	31 c9                	xor    %ecx,%ecx
    94e6:	48 89 c2             	mov    %rax,%rdx
    94e9:	e9 16 01 00 00       	jmp    9604 <fwp_fmt_duration+0x764>
    94ee:	83 f8 20             	cmp    $0x20,%eax
    94f1:	73 0e                	jae    9501 <fwp_fmt_duration+0x661>
    94f3:	31 c9                	xor    %ecx,%ecx
    94f5:	e9 b0 00 00 00       	jmp    95aa <fwp_fmt_duration+0x70a>
    94fa:	31 c0                	xor    %eax,%eax
    94fc:	e9 93 02 00 00       	jmp    9794 <fwp_fmt_duration+0x8f4>
    9501:	44 89 d2             	mov    %r10d,%edx
    9504:	83 e2 1f             	and    $0x1f,%edx
    9507:	48 89 c1             	mov    %rax,%rcx
    950a:	48 29 d1             	sub    %rdx,%rcx
    950d:	48 8d 74 24 10       	lea    0x10(%rsp),%rsi
    9512:	66 0f ef c0          	pxor   %xmm0,%xmm0
    9516:	49 89 c0             	mov    %rax,%r8
    9519:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)
    9520:	f3 42 0f 6f 4c 04 20 	movdqu 0x20(%rsp,%r8,1),%xmm1
    9527:	f3 42 0f 6f 54 04 30 	movdqu 0x30(%rsp,%r8,1),%xmm2
    952e:	66 0f 6f da          	movdqa %xmm2,%xmm3
    9532:	66 0f 60 d8          	punpcklbw %xmm0,%xmm3
    9536:	66 0f 70 db 4e       	pshufd $0x4e,%xmm3,%xmm3
    953b:	f2 0f 70 db 1b       	pshuflw $0x1b,%xmm3,%xmm3
    9540:	f3 0f 70 db 1b       	pshufhw $0x1b,%xmm3,%xmm3
    9545:	66 0f 68 d0          	punpckhbw %xmm0,%xmm2
    9549:	66 0f 70 d2 4e       	pshufd $0x4e,%xmm2,%xmm2
    954e:	f2 0f 70 d2 1b       	pshuflw $0x1b,%xmm2,%xmm2
    9553:	f3 0f 70 d2 1b       	pshufhw $0x1b,%xmm2,%xmm2
    9558:	66 0f 67 d3          	packuswb %xmm3,%xmm2
    955c:	66 0f 6f d9          	movdqa %xmm1,%xmm3
    9560:	66 0f 60 d8          	punpcklbw %xmm0,%xmm3
    9564:	66 0f 70 db 4e       	pshufd $0x4e,%xmm3,%xmm3
    9569:	f2 0f 70 db 1b       	pshuflw $0x1b,%xmm3,%xmm3
    956e:	f3 0f 70 db 1b       	pshufhw $0x1b,%xmm3,%xmm3
    9573:	66 0f 68 c8          	punpckhbw %xmm0,%xmm1
    9577:	66 0f 70 c9 4e       	pshufd $0x4e,%xmm1,%xmm1
    957c:	f2 0f 70 c9 1b       	pshuflw $0x1b,%xmm1,%xmm1
    9581:	f3 0f 70 c9 1b       	pshufhw $0x1b,%xmm1,%xmm1
    9586:	66 0f 67 cb          	packuswb %xmm3,%xmm1
    958a:	66 0f 7f 56 f0       	movdqa %xmm2,-0x10(%rsi)
    958f:	66 0f 7f 0e          	movdqa %xmm1,(%rsi)
    9593:	49 83 c0 e0          	add    $0xffffffffffffffe0,%r8
    9597:	48 83 c6 20          	add    $0x20,%rsi
    959b:	4c 39 c2             	cmp    %r8,%rdx
    959e:	75 80                	jne    9520 <fwp_fmt_duration+0x680>
    95a0:	48 85 d2             	test   %rdx,%rdx
    95a3:	74 7d                	je     9622 <fwp_fmt_duration+0x782>
    95a5:	83 fa 08             	cmp    $0x8,%edx
    95a8:	72 5a                	jb     9604 <fwp_fmt_duration+0x764>
    95aa:	44 89 d2             	mov    %r10d,%edx
    95ad:	83 e2 07             	and    $0x7,%edx
    95b0:	48 89 c6             	mov    %rax,%rsi
    95b3:	48 29 ce             	sub    %rcx,%rsi
    95b6:	4c 8d 04 0c          	lea    (%rsp,%rcx,1),%r8
    95ba:	48 89 c1             	mov    %rax,%rcx
    95bd:	48 29 d1             	sub    %rdx,%rcx
    95c0:	66 0f ef c0          	pxor   %xmm0,%xmm0
    95c4:	66 66 66 2e 0f 1f 84 	data16 data16 cs nopw 0x0(%rax,%rax,1)
    95cb:	00 00 00 00 00 
    95d0:	f3 0f 7e 4c 34 38    	movq   0x38(%rsp,%rsi,1),%xmm1
    95d6:	66 0f 60 c8          	punpcklbw %xmm0,%xmm1
    95da:	66 0f 70 c9 4e       	pshufd $0x4e,%xmm1,%xmm1
    95df:	f2 0f 70 c9 1b       	pshuflw $0x1b,%xmm1,%xmm1
    95e4:	f3 0f 70 c9 1b       	pshufhw $0x1b,%xmm1,%xmm1
    95e9:	66 0f 67 c9          	packuswb %xmm1,%xmm1
    95ed:	66 41 0f d6 08       	movq   %xmm1,(%r8)
    95f2:	48 83 c6 f8          	add    $0xfffffffffffffff8,%rsi
    95f6:	49 83 c0 08          	add    $0x8,%r8
    95fa:	48 39 f2             	cmp    %rsi,%rdx
    95fd:	75 d1                	jne    95d0 <fwp_fmt_duration+0x730>
    95ff:	48 85 d2             	test   %rdx,%rdx
    9602:	74 1e                	je     9622 <fwp_fmt_duration+0x782>
    9604:	48 8d 74 24 40       	lea    0x40(%rsp),%rsi
    9609:	48 01 f2             	add    %rsi,%rdx
    960c:	48 ff ca             	dec    %rdx
    960f:	90                   	nop
    9610:	0f b6 32             	movzbl (%rdx),%esi
    9613:	40 88 34 0c          	mov    %sil,(%rsp,%rcx,1)
    9617:	48 ff c1             	inc    %rcx
    961a:	48 ff ca             	dec    %rdx
    961d:	48 39 c8             	cmp    %rcx,%rax
    9620:	75 ee                	jne    9610 <fwp_fmt_duration+0x770>
    9622:	c6 04 04 00          	movb   $0x0,(%rsp,%rax,1)
    9626:	e9 6e 01 00 00       	jmp    9799 <fwp_fmt_duration+0x8f9>
    962b:	83 f8 20             	cmp    $0x20,%eax
    962e:	73 07                	jae    9637 <fwp_fmt_duration+0x797>
    9630:	31 c9                	xor    %ecx,%ecx
    9632:	e9 bd 00 00 00       	jmp    96f4 <fwp_fmt_duration+0x854>
    9637:	44 89 c6             	mov    %r8d,%esi
    963a:	44 89 c2             	mov    %r8d,%edx
    963d:	83 e2 1f             	and    $0x1f,%edx
    9640:	48 89 c1             	mov    %rax,%rcx
    9643:	48 29 d1             	sub    %rdx,%rcx
    9646:	4c 8d 0c 34          	lea    (%rsp,%rsi,1),%r9
    964a:	49 83 c1 30          	add    $0x30,%r9
    964e:	48 29 d6             	sub    %rdx,%rsi
    9651:	45 31 d2             	xor    %r10d,%r10d
    9654:	66 0f ef c0          	pxor   %xmm0,%xmm0
    9658:	0f 1f 84 00 00 00 00 	nopl   0x0(%rax,%rax,1)
    965f:	00 
    9660:	f3 41 0f 6f 49 f0    	movdqu -0x10(%r9),%xmm1
    9666:	f3 41 0f 6f 11       	movdqu (%r9),%xmm2
    966b:	66 0f 6f da          	movdqa %xmm2,%xmm3
    966f:	66 0f 60 d8          	punpcklbw %xmm0,%xmm3
    9673:	66 0f 70 db 4e       	pshufd $0x4e,%xmm3,%xmm3
    9678:	f2 0f 70 db 1b       	pshuflw $0x1b,%xmm3,%xmm3
    967d:	f3 0f 70 db 1b       	pshufhw $0x1b,%xmm3,%xmm3
    9682:	66 0f 68 d0          	punpckhbw %xmm0,%xmm2
    9686:	66 0f 70 d2 4e       	pshufd $0x4e,%xmm2,%xmm2
    968b:	f2 0f 70 d2 1b       	pshuflw $0x1b,%xmm2,%xmm2
    9690:	f3 0f 70 d2 1b       	pshufhw $0x1b,%xmm2,%xmm2
    9695:	66 0f 67 d3          	packuswb %xmm3,%xmm2
    9699:	66 0f 6f d9          	movdqa %xmm1,%xmm3
    969d:	66 0f 60 d8          	punpcklbw %xmm0,%xmm3
    96a1:	66 0f 70 db 4e       	pshufd $0x4e,%xmm3,%xmm3
    96a6:	f2 0f 70 db 1b       	pshuflw $0x1b,%xmm3,%xmm3
    96ab:	f3 0f 70 db 1b       	pshufhw $0x1b,%xmm3,%xmm3
    96b0:	66 0f 68 c8          	punpckhbw %xmm0,%xmm1
    96b4:	66 0f 70 c9 4e       	pshufd $0x4e,%xmm1,%xmm1
    96b9:	f2 0f 70 c9 1b       	pshuflw $0x1b,%xmm1,%xmm1
    96be:	f3 0f 70 c9 1b       	pshufhw $0x1b,%xmm1,%xmm1
    96c3:	66 0f 67 cb          	packuswb %xmm3,%xmm1
    96c7:	f3 42 0f 7f 54 14 01 	movdqu %xmm2,0x1(%rsp,%r10,1)
    96ce:	f3 42 0f 7f 4c 14 11 	movdqu %xmm1,0x11(%rsp,%r10,1)
    96d5:	49 83 c2 20          	add    $0x20,%r10
    96d9:	49 83 c1 e0          	add    $0xffffffffffffffe0,%r9
    96dd:	4c 39 d6             	cmp    %r10,%rsi
    96e0:	0f 85 7a ff ff ff    	jne    9660 <fwp_fmt_duration+0x7c0>
    96e6:	48 85 d2             	test   %rdx,%rdx
    96e9:	0f 84 a5 00 00 00    	je     9794 <fwp_fmt_duration+0x8f4>
    96ef:	83 fa 08             	cmp    $0x8,%edx
    96f2:	72 70                	jb     9764 <fwp_fmt_duration+0x8c4>
    96f4:	48 89 ce             	mov    %rcx,%rsi
    96f7:	45 89 c1             	mov    %r8d,%r9d
    96fa:	44 89 c2             	mov    %r8d,%edx
    96fd:	83 e2 07             	and    $0x7,%edx
    9700:	48 89 c1             	mov    %rax,%rcx
    9703:	48 29 d1             	sub    %rdx,%rcx
    9706:	49 89 f2             	mov    %rsi,%r10
    9709:	49 f7 da             	neg    %r10
    970c:	49 01 e2             	add    %rsp,%r10
    970f:	49 83 c2 40          	add    $0x40,%r10
    9713:	4d 01 ca             	add    %r9,%r10
    9716:	49 83 c2 f8          	add    $0xfffffffffffffff8,%r10
    971a:	49 29 d1             	sub    %rdx,%r9
    971d:	66 0f ef c0          	pxor   %xmm0,%xmm0
    9721:	66 66 66 66 66 66 2e 	data16 data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    9728:	0f 1f 84 00 00 00 00 
    972f:	00 
    9730:	f3 41 0f 7e 0a       	movq   (%r10),%xmm1
    9735:	66 0f 60 c8          	punpcklbw %xmm0,%xmm1
    9739:	66 0f 70 c9 4e       	pshufd $0x4e,%xmm1,%xmm1
    973e:	f2 0f 70 c9 1b       	pshuflw $0x1b,%xmm1,%xmm1
    9743:	f3 0f 70 c9 1b       	pshufhw $0x1b,%xmm1,%xmm1
    9748:	66 0f 67 c9          	packuswb %xmm1,%xmm1
    974c:	66 0f d6 4c 34 01    	movq   %xmm1,0x1(%rsp,%rsi,1)
    9752:	48 83 c6 08          	add    $0x8,%rsi
    9756:	49 83 c2 f8          	add    $0xfffffffffffffff8,%r10
    975a:	49 39 f1             	cmp    %rsi,%r9
    975d:	75 d1                	jne    9730 <fwp_fmt_duration+0x890>
    975f:	48 85 d2             	test   %rdx,%rdx
    9762:	74 30                	je     9794 <fwp_fmt_duration+0x8f4>
    9764:	48 8d 74 24 40       	lea    0x40(%rsp),%rsi
    9769:	48 01 f2             	add    %rsi,%rdx
    976c:	48 ff ca             	dec    %rdx
    976f:	44 89 c6             	mov    %r8d,%esi
    9772:	66 66 66 66 66 2e 0f 	data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    9779:	1f 84 00 00 00 00 00 
    9780:	44 0f b6 02          	movzbl (%rdx),%r8d
    9784:	44 88 44 0c 01       	mov    %r8b,0x1(%rsp,%rcx,1)
    9789:	48 ff c1             	inc    %rcx
    978c:	48 ff ca             	dec    %rdx
    978f:	48 39 ce             	cmp    %rcx,%rsi
    9792:	75 ec                	jne    9780 <fwp_fmt_duration+0x8e0>
    9794:	c6 44 04 01 00       	movb   $0x0,0x1(%rsp,%rax,1)
    9799:	48 8b 0b             	mov    (%rbx),%rcx
    979c:	48 8d 35 2b 2e 00 00 	lea    0x2e2b(%rip),%rsi        # c5ce <fwp_segv.msg+0x38e>
    97a3:	48 89 e2             	mov    %rsp,%rdx
    97a6:	31 c0                	xor    %eax,%eax
    97a8:	e8 13 8b ff ff       	call   22c0 <sprintf@plt>
    97ad:	48 81 c4 88 00 00 00 	add    $0x88,%rsp
    97b4:	5b                   	pop    %rbx
    97b5:	41 5c                	pop    %r12
    97b7:	41 5e                	pop    %r14
    97b9:	41 5f                	pop    %r15
    97bb:	c3                   	ret
    97bc:	45 31 c9             	xor    %r9d,%r9d
    97bf:	48 f7 de             	neg    %rsi
    97c2:	41 ba 00 00 00 00    	mov    $0x0,%r10d
    97c8:	4d 19 c2             	sbb    %r8,%r10
    97cb:	c6 04 24 2d          	movb   $0x2d,(%rsp)
    97cf:	49 bb cd cc cc cc cc 	movabs $0xcccccccccccccccd,%r11
    97d6:	cc cc cc 
    97d9:	48 bb cc cc cc cc cc 	movabs $0xcccccccccccccccc,%rbx
    97e0:	cc cc cc 
    97e3:	4d 89 d6             	mov    %r10,%r14
    97e6:	66 2e 0f 1f 84 00 00 	cs nopw 0x0(%rax,%rax,1)
    97ed:	00 00 00 
    97f0:	4c 89 d1             	mov    %r10,%rcx
    97f3:	48 0f a4 f1 3f       	shld   $0x3f,%rsi,%rcx
    97f8:	49 d1 ee             	shr    $1,%r14
    97fb:	49 89 c8             	mov    %rcx,%r8
    97fe:	4d 01 f0             	add    %r14,%r8
    9801:	49 83 d0 00          	adc    $0x0,%r8
    9805:	4c 89 c0             	mov    %r8,%rax
    9808:	49 f7 e3             	mul    %r11
    980b:	48 c1 ea 02          	shr    $0x2,%rdx
    980f:	48 8d 04 92          	lea    (%rdx,%rdx,4),%rax
    9813:	49 29 c0             	sub    %rax,%r8
    9816:	4c 29 c1             	sub    %r8,%rcx
    9819:	49 83 de 00          	sbb    $0x0,%r14
    981d:	49 89 c8             	mov    %rcx,%r8
    9820:	4c 0f af c3          	imul   %rbx,%r8
    9824:	48 89 c8             	mov    %rcx,%rax
    9827:	49 f7 e3             	mul    %r11
    982a:	4c 01 c2             	add    %r8,%rdx
    982d:	4d 0f af f3          	imul   %r11,%r14
    9831:	49 01 d6             	add    %rdx,%r14
    9834:	48 89 c1             	mov    %rax,%rcx
    9837:	48 01 c1             	add    %rax,%rcx
    983a:	48 8d 0c 89          	lea    (%rcx,%rcx,4),%rcx
    983e:	89 f2                	mov    %esi,%edx
    9840:	29 ca                	sub    %ecx,%edx
    9842:	80 ca 30             	or     $0x30,%dl
    9845:	42 88 54 0c 40       	mov    %dl,0x40(%rsp,%r9,1)
    984a:	49 ff c1             	inc    %r9
    984d:	48 83 fe 0a          	cmp    $0xa,%rsi
    9851:	49 83 da 00          	sbb    $0x0,%r10
    9855:	48 89 c6             	mov    %rax,%rsi
    9858:	4d 89 f2             	mov    %r14,%r10
    985b:	73 93                	jae    97f0 <fwp_fmt_duration+0x950>
    985d:	45 85 c9             	test   %r9d,%r9d
    9860:	7e 13                	jle    9875 <fwp_fmt_duration+0x9d5>
    9862:	44 89 c8             	mov    %r9d,%eax
    9865:	48 83 f8 08          	cmp    $0x8,%rax
    9869:	73 11                	jae    987c <fwp_fmt_duration+0x9dc>
    986b:	31 c9                	xor    %ecx,%ecx
    986d:	48 89 c2             	mov    %rax,%rdx
    9870:	e9 29 01 00 00       	jmp    999e <fwp_fmt_duration+0xafe>
    9875:	31 c0                	xor    %eax,%eax
    9877:	e9 48 01 00 00       	jmp    99c4 <fwp_fmt_duration+0xb24>
    987c:	83 f8 20             	cmp    $0x20,%eax
    987f:	73 07                	jae    9888 <fwp_fmt_duration+0x9e8>
    9881:	31 c9                	xor    %ecx,%ecx
    9883:	e9 b5 00 00 00       	jmp    993d <fwp_fmt_duration+0xa9d>
    9888:	44 89 ce             	mov    %r9d,%esi
    988b:	44 89 ca             	mov    %r9d,%edx
    988e:	83 e2 1f             	and    $0x1f,%edx
    9891:	48 89 c1             	mov    %rax,%rcx
    9894:	48 29 d1             	sub    %rdx,%rcx
    9897:	4c 8d 04 34          	lea    (%rsp,%rsi,1),%r8
    989b:	49 83 c0 30          	add    $0x30,%r8
    989f:	48 29 d6             	sub    %rdx,%rsi
    98a2:	45 31 d2             	xor    %r10d,%r10d
    98a5:	66 0f ef c0          	pxor   %xmm0,%xmm0
    98a9:	f3 41 0f 6f 48 f0    	movdqu -0x10(%r8),%xmm1
    98af:	f3 41 0f 6f 10       	movdqu (%r8),%xmm2
    98b4:	66 0f 6f da          	movdqa %xmm2,%xmm3
    98b8:	66 0f 60 d8          	punpcklbw %xmm0,%xmm3
    98bc:	66 0f 70 db 4e       	pshufd $0x4e,%xmm3,%xmm3
    98c1:	f2 0f 70 db 1b       	pshuflw $0x1b,%xmm3,%xmm3
    98c6:	f3 0f 70 db 1b       	pshufhw $0x1b,%xmm3,%xmm3
    98cb:	66 0f 68 d0          	punpckhbw %xmm0,%xmm2
    98cf:	66 0f 70 d2 4e       	pshufd $0x4e,%xmm2,%xmm2
    98d4:	f2 0f 70 d2 1b       	pshuflw $0x1b,%xmm2,%xmm2
    98d9:	f3 0f 70 d2 1b       	pshufhw $0x1b,%xmm2,%xmm2
    98de:	66 0f 67 d3          	packuswb %xmm3,%xmm2
    98e2:	66 0f 6f d9          	movdqa %xmm1,%xmm3
    98e6:	66 0f 60 d8          	punpcklbw %xmm0,%xmm3
    98ea:	66 0f 70 db 4e       	pshufd $0x4e,%xmm3,%xmm3
    98ef:	f2 0f 70 db 1b       	pshuflw $0x1b,%xmm3,%xmm3
    98f4:	f3 0f 70 db 1b       	pshufhw $0x1b,%xmm3,%xmm3
    98f9:	66 0f 68 c8          	punpckhbw %xmm0,%xmm1
    98fd:	66 0f 70 c9 4e       	pshufd $0x4e,%xmm1,%xmm1
    9902:	f2 0f 70 c9 1b       	pshuflw $0x1b,%xmm1,%xmm1
    9907:	f3 0f 70 c9 1b       	pshufhw $0x1b,%xmm1,%xmm1
    990c:	66 0f 67 cb          	packuswb %xmm3,%xmm1
    9910:	f3 42 0f 7f 54 14 01 	movdqu %xmm2,0x1(%rsp,%r10,1)
    9917:	f3 42 0f 7f 4c 14 11 	movdqu %xmm1,0x11(%rsp,%r10,1)
    991e:	49 83 c2 20          	add    $0x20,%r10
    9922:	49 83 c0 e0          	add    $0xffffffffffffffe0,%r8
    9926:	4c 39 d6             	cmp    %r10,%rsi
    9929:	0f 85 7a ff ff ff    	jne    98a9 <fwp_fmt_duration+0xa09>
    992f:	48 85 d2             	test   %rdx,%rdx
    9932:	0f 84 8c 00 00 00    	je     99c4 <fwp_fmt_duration+0xb24>
    9938:	83 fa 08             	cmp    $0x8,%edx
    993b:	72 61                	jb     999e <fwp_fmt_duration+0xafe>
    993d:	48 89 ce             	mov    %rcx,%rsi
    9940:	45 89 c8             	mov    %r9d,%r8d
    9943:	44 89 ca             	mov    %r9d,%edx
    9946:	83 e2 07             	and    $0x7,%edx
    9949:	48 89 c1             	mov    %rax,%rcx
    994c:	48 29 d1             	sub    %rdx,%rcx
    994f:	49 89 f2             	mov    %rsi,%r10
    9952:	49 f7 da             	neg    %r10
    9955:	49 01 e2             	add    %rsp,%r10
    9958:	49 83 c2 40          	add    $0x40,%r10
    995c:	4d 01 c2             	add    %r8,%r10
    995f:	49 83 c2 f8          	add    $0xfffffffffffffff8,%r10
    9963:	49 29 d0             	sub    %rdx,%r8
    9966:	66 0f ef c0          	pxor   %xmm0,%xmm0
    996a:	f3 41 0f 7e 0a       	movq   (%r10),%xmm1
    996f:	66 0f 60 c8          	punpcklbw %xmm0,%xmm1
    9973:	66 0f 70 c9 4e       	pshufd $0x4e,%xmm1,%xmm1
    9978:	f2 0f 70 c9 1b       	pshuflw $0x1b,%xmm1,%xmm1
    997d:	f3 0f 70 c9 1b       	pshufhw $0x1b,%xmm1,%xmm1
    9982:	66 0f 67 c9          	packuswb %xmm1,%xmm1
    9986:	66 0f d6 4c 34 01    	movq   %xmm1,0x1(%rsp,%rsi,1)
    998c:	48 83 c6 08          	add    $0x8,%rsi
    9990:	49 83 c2 f8          	add    $0xfffffffffffffff8,%r10
    9994:	49 39 f0             	cmp    %rsi,%r8
    9997:	75 d1                	jne    996a <fwp_fmt_duration+0xaca>
    9999:	48 85 d2             	test   %rdx,%rdx
    999c:	74 26                	je     99c4 <fwp_fmt_duration+0xb24>
    999e:	48 8d 74 24 40       	lea    0x40(%rsp),%rsi
    99a3:	48 01 f2             	add    %rsi,%rdx
    99a6:	48 ff ca             	dec    %rdx
    99a9:	44 89 ce             	mov    %r9d,%esi
    99ac:	0f 1f 40 00          	nopl   0x0(%rax)
    99b0:	44 0f b6 02          	movzbl (%rdx),%r8d
    99b4:	44 88 44 0c 01       	mov    %r8b,0x1(%rsp,%rcx,1)
    99b9:	48 ff c1             	inc    %rcx
    99bc:	48 ff ca             	dec    %rdx
    99bf:	48 39 ce             	cmp    %rcx,%rsi
    99c2:	75 ec                	jne    99b0 <fwp_fmt_duration+0xb10>
    99c4:	c6 44 04 01 00       	movb   $0x0,0x1(%rsp,%rax,1)
    99c9:	e9 28 f9 ff ff       	jmp    92f6 <fwp_fmt_duration+0x456>
    99ce:	66 90                	xchg   %ax,%ax

00000000000099d0 <fwp_format_g>:
    99d0:	55                   	push   %rbp
    99d1:	41 57                	push   %r15
    99d3:	41 56                	push   %r14
    99d5:	41 55                	push   %r13
    99d7:	41 54                	push   %r12
    99d9:	53                   	push   %rbx
    99da:	48 81 ec 98 00 00 00 	sub    $0x98,%rsp
    99e1:	89 f5                	mov    %esi,%ebp
    99e3:	48 89 fb             	mov    %rdi,%rbx
    99e6:	ff cd                	dec    %ebp
    99e8:	48 8d 15 ab 2b 00 00 	lea    0x2bab(%rip),%rdx        # c59a <fwp_segv.msg+0x35a>
    99ef:	4c 8d 64 24 50       	lea    0x50(%rsp),%r12
    99f4:	be 40 00 00 00       	mov    $0x40,%esi
    99f9:	4c 89 e7             	mov    %r12,%rdi
    99fc:	89 e9                	mov    %ebp,%ecx
    99fe:	f2 0f 11 44 24 08    	movsd  %xmm0,0x8(%rsp)
    9a04:	b0 01                	mov    $0x1,%al
    9a06:	e8 35 87 ff ff       	call   2140 <snprintf@plt>
    9a0b:	4c 89 e7             	mov    %r12,%rdi
    9a0e:	be 65 00 00 00       	mov    $0x65,%esi
    9a13:	e8 18 87 ff ff       	call   2130 <strchr@plt>
    9a18:	49 89 c7             	mov    %rax,%r15
    9a1b:	48 8d 78 01          	lea    0x1(%rax),%rdi
    9a1f:	45 31 ed             	xor    %r13d,%r13d
    9a22:	31 f6                	xor    %esi,%esi
    9a24:	ba 0a 00 00 00       	mov    $0xa,%edx
    9a29:	e8 d2 87 ff ff       	call   2200 <strtol@plt>
    9a2e:	49 89 c6             	mov    %rax,%r14
    9a31:	83 c0 ef             	add    $0xffffffef,%eax
    9a34:	83 f8 e9             	cmp    $0xffffffe9,%eax
    9a37:	77 5f                	ja     9a98 <fwp_format_g+0xc8>
    9a39:	4d 29 e7             	sub    %r12,%r15
    9a3c:	4c 8d 6c 24 10       	lea    0x10(%rsp),%r13
    9a41:	4c 89 ef             	mov    %r13,%rdi
    9a44:	4c 89 e6             	mov    %r12,%rsi
    9a47:	4c 89 fa             	mov    %r15,%rdx
    9a4a:	e8 c1 87 ff ff       	call   2210 <memcpy@plt>
    9a4f:	42 c6 44 3c 10 00    	movb   $0x0,0x10(%rsp,%r15,1)
    9a55:	4c 89 ef             	mov    %r13,%rdi
    9a58:	be 2e 00 00 00       	mov    $0x2e,%esi
    9a5d:	e8 ce 86 ff ff       	call   2130 <strchr@plt>
    9a62:	48 85 c0             	test   %rax,%rax
    9a65:	0f 84 a8 00 00 00    	je     9b13 <fwp_format_g+0x143>
    9a6b:	4d 85 ff             	test   %r15,%r15
    9a6e:	0f 84 9f 00 00 00    	je     9b13 <fwp_format_g+0x143>
    9a74:	66 66 66 2e 0f 1f 84 	data16 data16 cs nopw 0x0(%rax,%rax,1)
    9a7b:	00 00 00 00 00 
    9a80:	42 0f b6 44 3c 0f    	movzbl 0xf(%rsp,%r15,1),%eax
    9a86:	83 f8 30             	cmp    $0x30,%eax
    9a89:	75 7d                	jne    9b08 <fwp_format_g+0x138>
    9a8b:	42 c6 44 3c 0f 00    	movb   $0x0,0xf(%rsp,%r15,1)
    9a91:	49 ff cf             	dec    %r15
    9a94:	75 ea                	jne    9a80 <fwp_format_g+0xb0>
    9a96:	eb 7b                	jmp    9b13 <fwp_format_g+0x143>
    9a98:	44 29 f5             	sub    %r14d,%ebp
    9a9b:	85 ed                	test   %ebp,%ebp
    9a9d:	44 0f 4f ed          	cmovg  %ebp,%r13d
    9aa1:	48 8d 15 01 2b 00 00 	lea    0x2b01(%rip),%rdx        # c5a9 <fwp_segv.msg+0x369>
    9aa8:	be 90 01 00 00       	mov    $0x190,%esi
    9aad:	48 89 df             	mov    %rbx,%rdi
    9ab0:	44 89 e9             	mov    %r13d,%ecx
    9ab3:	f2 0f 10 44 24 08    	movsd  0x8(%rsp),%xmm0
    9ab9:	b0 01                	mov    $0x1,%al
    9abb:	e8 80 86 ff ff       	call   2140 <snprintf@plt>
    9ac0:	48 89 df             	mov    %rbx,%rdi
    9ac3:	e8 48 86 ff ff       	call   2110 <strlen@plt>
    9ac8:	49 89 c6             	mov    %rax,%r14
    9acb:	48 89 df             	mov    %rbx,%rdi
    9ace:	be 2e 00 00 00       	mov    $0x2e,%esi
    9ad3:	e8 58 86 ff ff       	call   2130 <strchr@plt>
    9ad8:	48 85 c0             	test   %rax,%rax
    9adb:	74 69                	je     9b46 <fwp_format_g+0x176>
    9add:	4d 85 f6             	test   %r14,%r14
    9ae0:	74 64                	je     9b46 <fwp_format_g+0x176>
    9ae2:	66 66 66 66 66 2e 0f 	data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    9ae9:	1f 84 00 00 00 00 00 
    9af0:	42 0f b6 44 33 ff    	movzbl -0x1(%rbx,%r14,1),%eax
    9af6:	83 f8 30             	cmp    $0x30,%eax
    9af9:	75 5d                	jne    9b58 <fwp_format_g+0x188>
    9afb:	42 c6 44 33 ff 00    	movb   $0x0,-0x1(%rbx,%r14,1)
    9b01:	49 ff ce             	dec    %r14
    9b04:	75 ea                	jne    9af0 <fwp_format_g+0x120>
    9b06:	eb 3e                	jmp    9b46 <fwp_format_g+0x176>
    9b08:	83 f8 2e             	cmp    $0x2e,%eax
    9b0b:	75 06                	jne    9b13 <fwp_format_g+0x143>
    9b0d:	42 c6 44 3c 0f 00    	movb   $0x0,0xf(%rsp,%r15,1)
    9b13:	44 89 f0             	mov    %r14d,%eax
    9b16:	c1 e8 1f             	shr    $0x1f,%eax
    9b19:	44 8d 04 45 2b 00 00 	lea    0x2b(,%rax,2),%r8d
    9b20:	00 
    9b21:	45 89 f1             	mov    %r14d,%r9d
    9b24:	41 f7 d9             	neg    %r9d
    9b27:	45 0f 48 ce          	cmovs  %r14d,%r9d
    9b2b:	48 8d 15 6d 2a 00 00 	lea    0x2a6d(%rip),%rdx        # c59f <fwp_segv.msg+0x35f>
    9b32:	48 8d 4c 24 10       	lea    0x10(%rsp),%rcx
    9b37:	be 90 01 00 00       	mov    $0x190,%esi
    9b3c:	48 89 df             	mov    %rbx,%rdi
    9b3f:	31 c0                	xor    %eax,%eax
    9b41:	e8 fa 85 ff ff       	call   2140 <snprintf@plt>
    9b46:	48 81 c4 98 00 00 00 	add    $0x98,%rsp
    9b4d:	5b                   	pop    %rbx
    9b4e:	41 5c                	pop    %r12
    9b50:	41 5d                	pop    %r13
    9b52:	41 5e                	pop    %r14
    9b54:	41 5f                	pop    %r15
    9b56:	5d                   	pop    %rbp
    9b57:	c3                   	ret
    9b58:	83 f8 2e             	cmp    $0x2e,%eax
    9b5b:	75 e9                	jne    9b46 <fwp_format_g+0x176>
    9b5d:	42 c6 44 33 ff 00    	movb   $0x0,-0x1(%rbx,%r14,1)
    9b63:	eb e1                	jmp    9b46 <fwp_format_g+0x176>
    9b65:	66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
    9b6c:	00 00 00 00 

0000000000009b70 <fwp_owned_entry3>:
    9b70:	41 57                	push   %r15
    9b72:	41 56                	push   %r14
    9b74:	53                   	push   %rbx
    9b75:	48 83 ec 20          	sub    $0x20,%rsp
    9b79:	48 89 fb             	mov    %rdi,%rbx
    9b7c:	48 8b 05 e5 70 00 00 	mov    0x70e5(%rip),%rax        # 10c68 <fwp_cleanups>
    9b83:	48 89 44 24 08       	mov    %rax,0x8(%rsp)
    9b88:	48 8d 05 c1 04 00 00 	lea    0x4c1(%rip),%rax        # a050 <fwp_entry_release3>
    9b8f:	48 89 44 24 10       	mov    %rax,0x10(%rsp)
    9b94:	48 89 7c 24 18       	mov    %rdi,0x18(%rsp)
    9b99:	4c 8d 7c 24 08       	lea    0x8(%rsp),%r15
    9b9e:	4c 89 3d c3 70 00 00 	mov    %r15,0x70c3(%rip)        # 10c68 <fwp_cleanups>
    9ba5:	48 8b 3f             	mov    (%rdi),%rdi
    9ba8:	48 8b 73 08          	mov    0x8(%rbx),%rsi
    9bac:	e8 9f d2 ff ff       	call   6e50 <fwp_p_file_with_owned>
    9bb1:	4c 39 3d b0 70 00 00 	cmp    %r15,0x70b0(%rip)        # 10c68 <fwp_cleanups>
    9bb8:	0f 85 c4 00 00 00    	jne    9c82 <fwp_owned_entry3+0x112>
    9bbe:	49 89 c6             	mov    %rax,%r14
    9bc1:	48 8b 44 24 08       	mov    0x8(%rsp),%rax
    9bc6:	48 89 05 9b 70 00 00 	mov    %rax,0x709b(%rip)        # 10c68 <fwp_cleanups>
    9bcd:	48 8b 03             	mov    (%rbx),%rax
    9bd0:	48 8b 3b             	mov    (%rbx),%rdi
    9bd3:	48 89 f8             	mov    %rdi,%rax
    9bd6:	48 2b 05 fb 65 00 00 	sub    0x65fb(%rip),%rax        # 101d8 <fwp_gc+0x1030>
    9bdd:	48 8b 0d 1c 66 00 00 	mov    0x661c(%rip),%rcx        # 10200 <fwp_gc+0x1058>
    9be4:	48 c1 e1 10          	shl    $0x10,%rcx
    9be8:	48 39 c8             	cmp    %rcx,%rax
    9beb:	73 71                	jae    9c5e <fwp_owned_entry3+0xee>
    9bed:	48 8b 0d 2c 66 00 00 	mov    0x662c(%rip),%rcx        # 10220 <fwp_gc+0x1078>
    9bf4:	48 89 c2             	mov    %rax,%rdx
    9bf7:	48 c1 ea 10          	shr    $0x10,%rdx
    9bfb:	48 69 d2 28 12 00 00 	imul   $0x1228,%rdx,%rdx
    9c02:	0f b6 34 11          	movzbl (%rcx,%rdx,1),%esi
    9c06:	48 25 ff ff 00 00    	and    $0xffff,%rax
    9c0c:	75 12                	jne    9c20 <fwp_owned_entry3+0xb0>
    9c0e:	40 80 fe 02          	cmp    $0x2,%sil
    9c12:	75 0c                	jne    9c20 <fwp_owned_entry3+0xb0>
    9c14:	48 8d 04 11          	lea    (%rcx,%rdx,1),%rax
    9c18:	48 05 28 02 00 00    	add    $0x228,%rax
    9c1e:	eb 1f                	jmp    9c3f <fwp_owned_entry3+0xcf>
    9c20:	40 80 fe 01          	cmp    $0x1,%sil
    9c24:	75 38                	jne    9c5e <fwp_owned_entry3+0xee>
    9c26:	48 8d 34 11          	lea    (%rcx,%rdx,1),%rsi
    9c2a:	8b 4c 11 20          	mov    0x20(%rcx,%rdx,1),%ecx
    9c2e:	48 0f af c1          	imul   %rcx,%rax
    9c32:	48 c1 e8 20          	shr    $0x20,%rax
    9c36:	48 01 f0             	add    %rsi,%rax
    9c39:	48 05 28 02 00 00    	add    $0x228,%rax
    9c3f:	0f b6 08             	movzbl (%rax),%ecx
    9c42:	85 c9                	test   %ecx,%ecx
    9c44:	74 18                	je     9c5e <fwp_owned_entry3+0xee>
    9c46:	83 f9 01             	cmp    $0x1,%ecx
    9c49:	75 07                	jne    9c52 <fwp_owned_entry3+0xe2>
    9c4b:	e8 c0 c8 ff ff       	call   6510 <fwp_rc_free_obj>
    9c50:	eb 0c                	jmp    9c5e <fwp_owned_entry3+0xee>
    9c52:	81 f9 ff 00 00 00    	cmp    $0xff,%ecx
    9c58:	74 1e                	je     9c78 <fwp_owned_entry3+0x108>
    9c5a:	fe c9                	dec    %cl
    9c5c:	88 08                	mov    %cl,(%rax)
    9c5e:	48 8b 43 08          	mov    0x8(%rbx),%rax
    9c62:	48 8b 7b 08          	mov    0x8(%rbx),%rdi
    9c66:	e8 85 c3 ff ff       	call   5ff0 <fwp_closure_drop>
    9c6b:	4c 89 f0             	mov    %r14,%rax
    9c6e:	48 83 c4 20          	add    $0x20,%rsp
    9c72:	5b                   	pop    %rbx
    9c73:	41 5e                	pop    %r14
    9c75:	41 5f                	pop    %r15
    9c77:	c3                   	ret
    9c78:	48 89 c7             	mov    %rax,%rdi
    9c7b:	e8 80 c6 ff ff       	call   6300 <fwp_rc_wide_drop>
    9c80:	eb dc                	jmp    9c5e <fwp_owned_entry3+0xee>
    9c82:	e8 d9 83 ff ff       	call   2060 <abort@plt>
    9c87:	66 0f 1f 84 00 00 00 	nopw   0x0(%rax,%rax,1)
    9c8e:	00 00 

0000000000009c90 <fwp_caps3>:
    9c90:	85 f6                	test   %esi,%esi
    9c92:	74 0e                	je     9ca2 <fwp_caps3+0x12>
    9c94:	8b 57 04             	mov    0x4(%rdi),%edx
    9c97:	48 83 c7 08          	add    $0x8,%rdi
    9c9b:	31 f6                	xor    %esi,%esi
    9c9d:	e9 de 00 00 00       	jmp    9d80 <fwp_args3>
    9ca2:	53                   	push   %rbx
    9ca3:	83 7f 04 00          	cmpl   $0x0,0x4(%rdi)
    9ca7:	0f 84 b4 00 00 00    	je     9d61 <fwp_caps3+0xd1>
    9cad:	48 8b 47 08          	mov    0x8(%rdi),%rax
    9cb1:	48 89 c1             	mov    %rax,%rcx
    9cb4:	48 2b 0d 1d 65 00 00 	sub    0x651d(%rip),%rcx        # 101d8 <fwp_gc+0x1030>
    9cbb:	48 8b 15 3e 65 00 00 	mov    0x653e(%rip),%rdx        # 10200 <fwp_gc+0x1058>
    9cc2:	48 c1 e2 10          	shl    $0x10,%rdx
    9cc6:	48 39 d1             	cmp    %rdx,%rcx
    9cc9:	73 7e                	jae    9d49 <fwp_caps3+0xb9>
    9ccb:	48 8b 15 4e 65 00 00 	mov    0x654e(%rip),%rdx        # 10220 <fwp_gc+0x1078>
    9cd2:	48 89 ce             	mov    %rcx,%rsi
    9cd5:	48 c1 ee 10          	shr    $0x10,%rsi
    9cd9:	48 69 f6 28 12 00 00 	imul   $0x1228,%rsi,%rsi
    9ce0:	44 0f b6 04 32       	movzbl (%rdx,%rsi,1),%r8d
    9ce5:	48 81 e1 ff ff 00 00 	and    $0xffff,%rcx
    9cec:	75 13                	jne    9d01 <fwp_caps3+0x71>
    9cee:	41 80 f8 02          	cmp    $0x2,%r8b
    9cf2:	75 0d                	jne    9d01 <fwp_caps3+0x71>
    9cf4:	48 8d 0c 32          	lea    (%rdx,%rsi,1),%rcx
    9cf8:	48 81 c1 28 02 00 00 	add    $0x228,%rcx
    9cff:	eb 20                	jmp    9d21 <fwp_caps3+0x91>
    9d01:	41 80 f8 01          	cmp    $0x1,%r8b
    9d05:	75 42                	jne    9d49 <fwp_caps3+0xb9>
    9d07:	4c 8d 04 32          	lea    (%rdx,%rsi,1),%r8
    9d0b:	8b 54 32 20          	mov    0x20(%rdx,%rsi,1),%edx
    9d0f:	48 0f af ca          	imul   %rdx,%rcx
    9d13:	48 c1 e9 20          	shr    $0x20,%rcx
    9d17:	4c 01 c1             	add    %r8,%rcx
    9d1a:	48 81 c1 28 02 00 00 	add    $0x228,%rcx
    9d21:	0f b6 11             	movzbl (%rcx),%edx
    9d24:	85 d2                	test   %edx,%edx
    9d26:	74 21                	je     9d49 <fwp_caps3+0xb9>
    9d28:	83 fa 01             	cmp    $0x1,%edx
    9d2b:	75 10                	jne    9d3d <fwp_caps3+0xad>
    9d2d:	48 89 fb             	mov    %rdi,%rbx
    9d30:	48 89 c7             	mov    %rax,%rdi
    9d33:	e8 d8 c7 ff ff       	call   6510 <fwp_rc_free_obj>
    9d38:	48 89 df             	mov    %rbx,%rdi
    9d3b:	eb 0c                	jmp    9d49 <fwp_caps3+0xb9>
    9d3d:	81 fa ff 00 00 00    	cmp    $0xff,%edx
    9d43:	74 22                	je     9d67 <fwp_caps3+0xd7>
    9d45:	fe ca                	dec    %dl
    9d47:	88 11                	mov    %dl,(%rcx)
    9d49:	83 7f 04 02          	cmpl   $0x2,0x4(%rdi)
    9d4d:	72 12                	jb     9d61 <fwp_caps3+0xd1>
    9d4f:	48 8b 47 10          	mov    0x10(%rdi),%rax
    9d53:	48 89 fb             	mov    %rdi,%rbx
    9d56:	48 89 c7             	mov    %rax,%rdi
    9d59:	e8 92 c2 ff ff       	call   5ff0 <fwp_closure_drop>
    9d5e:	48 89 df             	mov    %rbx,%rdi
    9d61:	5b                   	pop    %rbx
    9d62:	e9 a9 c7 ff ff       	jmp    6510 <fwp_rc_free_obj>
    9d67:	48 89 fb             	mov    %rdi,%rbx
    9d6a:	48 89 cf             	mov    %rcx,%rdi
    9d6d:	e8 8e c5 ff ff       	call   6300 <fwp_rc_wide_drop>
    9d72:	eb c4                	jmp    9d38 <fwp_caps3+0xa8>
    9d74:	66 66 66 2e 0f 1f 84 	data16 data16 cs nopw 0x0(%rax,%rax,1)
    9d7b:	00 00 00 00 00 

0000000000009d80 <fwp_args3>:
    9d80:	55                   	push   %rbp
    9d81:	41 57                	push   %r15
    9d83:	41 56                	push   %r14
    9d85:	53                   	push   %rbx
    9d86:	48 83 ec 38          	sub    $0x38,%rsp
    9d8a:	48 89 7c 24 08       	mov    %rdi,0x8(%rsp)
    9d8f:	48 8d 05 ca 01 00 00 	lea    0x1ca(%rip),%rax        # 9f60 <fwp_arg_drop3>
    9d96:	48 89 44 24 10       	mov    %rax,0x10(%rsp)
    9d9b:	89 74 24 18          	mov    %esi,0x18(%rsp)
    9d9f:	c7 44 24 1c 00 00 00 	movl   $0x0,0x1c(%rsp)
    9da6:	00 
    9da7:	48 8b 05 ba 6e 00 00 	mov    0x6eba(%rip),%rax        # 10c68 <fwp_cleanups>
    9dae:	48 89 44 24 20       	mov    %rax,0x20(%rsp)
    9db3:	48 8d 05 76 d0 ff ff 	lea    -0x2f8a(%rip),%rax        # 6e30 <fwp_args_release>
    9dba:	48 89 44 24 28       	mov    %rax,0x28(%rsp)
    9dbf:	48 8d 44 24 08       	lea    0x8(%rsp),%rax
    9dc4:	48 89 44 24 30       	mov    %rax,0x30(%rsp)
    9dc9:	48 8d 5c 24 20       	lea    0x20(%rsp),%rbx
    9dce:	48 89 1d 93 6e 00 00 	mov    %rbx,0x6e93(%rip)        # 10c68 <fwp_cleanups>
    9dd5:	85 f6                	test   %esi,%esi
    9dd7:	75 52                	jne    9e2b <fwp_args3+0xab>
    9dd9:	85 d2                	test   %edx,%edx
    9ddb:	74 4e                	je     9e2b <fwp_args3+0xab>
    9ddd:	48 8b 07             	mov    (%rdi),%rax
    9de0:	48 2b 05 f1 63 00 00 	sub    0x63f1(%rip),%rax        # 101d8 <fwp_gc+0x1030>
    9de7:	48 8b 0d 12 64 00 00 	mov    0x6412(%rip),%rcx        # 10200 <fwp_gc+0x1058>
    9dee:	48 c1 e1 10          	shl    $0x10,%rcx
    9df2:	48 39 c8             	cmp    %rcx,%rax
    9df5:	73 72                	jae    9e69 <fwp_args3+0xe9>
    9df7:	48 8b 0d 22 64 00 00 	mov    0x6422(%rip),%rcx        # 10220 <fwp_gc+0x1078>
    9dfe:	49 89 c0             	mov    %rax,%r8
    9e01:	49 c1 e8 10          	shr    $0x10,%r8
    9e05:	4d 69 c0 28 12 00 00 	imul   $0x1228,%r8,%r8
    9e0c:	46 0f b6 0c 01       	movzbl (%rcx,%r8,1),%r9d
    9e11:	48 25 ff ff 00 00    	and    $0xffff,%rax
    9e17:	75 1c                	jne    9e35 <fwp_args3+0xb5>
    9e19:	41 80 f9 02          	cmp    $0x2,%r9b
    9e1d:	75 16                	jne    9e35 <fwp_args3+0xb5>
    9e1f:	4a 8d 04 01          	lea    (%rcx,%r8,1),%rax
    9e23:	48 05 28 02 00 00    	add    $0x228,%rax
    9e29:	eb 2a                	jmp    9e55 <fwp_args3+0xd5>
    9e2b:	83 fe 01             	cmp    $0x1,%esi
    9e2e:	76 41                	jbe    9e71 <fwp_args3+0xf1>
    9e30:	e9 d4 00 00 00       	jmp    9f09 <fwp_args3+0x189>
    9e35:	41 80 f9 01          	cmp    $0x1,%r9b
    9e39:	75 2e                	jne    9e69 <fwp_args3+0xe9>
    9e3b:	4e 8d 0c 01          	lea    (%rcx,%r8,1),%r9
    9e3f:	42 8b 4c 01 20       	mov    0x20(%rcx,%r8,1),%ecx
    9e44:	48 0f af c1          	imul   %rcx,%rax
    9e48:	48 c1 e8 20          	shr    $0x20,%rax
    9e4c:	4c 01 c8             	add    %r9,%rax
    9e4f:	48 05 28 02 00 00    	add    $0x228,%rax
    9e55:	0f b6 08             	movzbl (%rax),%ecx
    9e58:	84 c9                	test   %cl,%cl
    9e5a:	74 0d                	je     9e69 <fwp_args3+0xe9>
    9e5c:	80 f9 fe             	cmp    $0xfe,%cl
    9e5f:	0f 83 c4 00 00 00    	jae    9f29 <fwp_args3+0x1a9>
    9e65:	fe c1                	inc    %cl
    9e67:	88 08                	mov    %cl,(%rax)
    9e69:	c7 44 24 1c 01 00 00 	movl   $0x1,0x1c(%rsp)
    9e70:	00 
    9e71:	89 f0                	mov    %esi,%eax
    9e73:	83 f0 01             	xor    $0x1,%eax
    9e76:	39 d0                	cmp    %edx,%eax
    9e78:	0f 83 8b 00 00 00    	jae    9f09 <fwp_args3+0x189>
    9e7e:	89 c0                	mov    %eax,%eax
    9e80:	48 8b 04 c7          	mov    (%rdi,%rax,8),%rax
    9e84:	48 2b 05 4d 63 00 00 	sub    0x634d(%rip),%rax        # 101d8 <fwp_gc+0x1030>
    9e8b:	48 8b 0d 6e 63 00 00 	mov    0x636e(%rip),%rcx        # 10200 <fwp_gc+0x1058>
    9e92:	48 c1 e1 10          	shl    $0x10,%rcx
    9e96:	48 39 c8             	cmp    %rcx,%rax
    9e99:	73 63                	jae    9efe <fwp_args3+0x17e>
    9e9b:	48 8b 0d 7e 63 00 00 	mov    0x637e(%rip),%rcx        # 10220 <fwp_gc+0x1078>
    9ea2:	48 89 c2             	mov    %rax,%rdx
    9ea5:	48 c1 ea 10          	shr    $0x10,%rdx
    9ea9:	48 69 d2 28 12 00 00 	imul   $0x1228,%rdx,%rdx
    9eb0:	0f b6 3c 11          	movzbl (%rcx,%rdx,1),%edi
    9eb4:	48 25 ff ff 00 00    	and    $0xffff,%rax
    9eba:	75 13                	jne    9ecf <fwp_args3+0x14f>
    9ebc:	40 80 ff 02          	cmp    $0x2,%dil
    9ec0:	75 0d                	jne    9ecf <fwp_args3+0x14f>
    9ec2:	48 8d 3c 11          	lea    (%rcx,%rdx,1),%rdi
    9ec6:	48 81 c7 28 02 00 00 	add    $0x228,%rdi
    9ecd:	eb 20                	jmp    9eef <fwp_args3+0x16f>
    9ecf:	40 80 ff 01          	cmp    $0x1,%dil
    9ed3:	75 29                	jne    9efe <fwp_args3+0x17e>
    9ed5:	48 8d 3c 11          	lea    (%rcx,%rdx,1),%rdi
    9ed9:	8b 4c 11 20          	mov    0x20(%rcx,%rdx,1),%ecx
    9edd:	48 0f af c1          	imul   %rcx,%rax
    9ee1:	48 c1 e8 20          	shr    $0x20,%rax
    9ee5:	48 01 c7             	add    %rax,%rdi
    9ee8:	48 81 c7 28 02 00 00 	add    $0x228,%rdi
    9eef:	0f b6 07             	movzbl (%rdi),%eax
    9ef2:	84 c0                	test   %al,%al
    9ef4:	74 08                	je     9efe <fwp_args3+0x17e>
    9ef6:	3c fe                	cmp    $0xfe,%al
    9ef8:	73 4c                	jae    9f46 <fwp_args3+0x1c6>
    9efa:	fe c0                	inc    %al
    9efc:	88 07                	mov    %al,(%rdi)
    9efe:	b8 02 00 00 00       	mov    $0x2,%eax
    9f03:	29 f0                	sub    %esi,%eax
    9f05:	89 44 24 1c          	mov    %eax,0x1c(%rsp)
    9f09:	48 39 1d 58 6d 00 00 	cmp    %rbx,0x6d58(%rip)        # 10c68 <fwp_cleanups>
    9f10:	75 3f                	jne    9f51 <fwp_args3+0x1d1>
    9f12:	48 8b 44 24 20       	mov    0x20(%rsp),%rax
    9f17:	48 89 05 4a 6d 00 00 	mov    %rax,0x6d4a(%rip)        # 10c68 <fwp_cleanups>
    9f1e:	48 83 c4 38          	add    $0x38,%rsp
    9f22:	5b                   	pop    %rbx
    9f23:	41 5e                	pop    %r14
    9f25:	41 5f                	pop    %r15
    9f27:	5d                   	pop    %rbp
    9f28:	c3                   	ret
    9f29:	49 89 fe             	mov    %rdi,%r14
    9f2c:	48 89 c7             	mov    %rax,%rdi
    9f2f:	89 f5                	mov    %esi,%ebp
    9f31:	41 89 d7             	mov    %edx,%r15d
    9f34:	e8 57 c4 ff ff       	call   6390 <fwp_rc_wide_dup>
    9f39:	44 89 fa             	mov    %r15d,%edx
    9f3c:	4c 89 f7             	mov    %r14,%rdi
    9f3f:	89 ee                	mov    %ebp,%esi
    9f41:	e9 23 ff ff ff       	jmp    9e69 <fwp_args3+0xe9>
    9f46:	89 f5                	mov    %esi,%ebp
    9f48:	e8 43 c4 ff ff       	call   6390 <fwp_rc_wide_dup>
    9f4d:	89 ee                	mov    %ebp,%esi
    9f4f:	eb ad                	jmp    9efe <fwp_args3+0x17e>
    9f51:	e8 0a 81 ff ff       	call   2060 <abort@plt>
    9f56:	66 2e 0f 1f 84 00 00 	cs nopw 0x0(%rax,%rax,1)
    9f5d:	00 00 00 

0000000000009f60 <fwp_arg_drop3>:
    9f60:	55                   	push   %rbp
    9f61:	41 56                	push   %r14
    9f63:	53                   	push   %rbx
    9f64:	85 f6                	test   %esi,%esi
    9f66:	75 5b                	jne    9fc3 <fwp_arg_drop3+0x63>
    9f68:	85 d2                	test   %edx,%edx
    9f6a:	74 57                	je     9fc3 <fwp_arg_drop3+0x63>
    9f6c:	48 8b 07             	mov    (%rdi),%rax
    9f6f:	48 89 c1             	mov    %rax,%rcx
    9f72:	48 2b 0d 5f 62 00 00 	sub    0x625f(%rip),%rcx        # 101d8 <fwp_gc+0x1030>
    9f79:	4c 8b 05 80 62 00 00 	mov    0x6280(%rip),%r8        # 10200 <fwp_gc+0x1058>
    9f80:	49 c1 e0 10          	shl    $0x10,%r8
    9f84:	4c 39 c1             	cmp    %r8,%rcx
    9f87:	0f 83 96 00 00 00    	jae    a023 <fwp_arg_drop3+0xc3>
    9f8d:	4c 8b 05 8c 62 00 00 	mov    0x628c(%rip),%r8        # 10220 <fwp_gc+0x1078>
    9f94:	49 89 c9             	mov    %rcx,%r9
    9f97:	49 c1 e9 10          	shr    $0x10,%r9
    9f9b:	4d 69 c9 28 12 00 00 	imul   $0x1228,%r9,%r9
    9fa2:	47 0f b6 14 08       	movzbl (%r8,%r9,1),%r10d
    9fa7:	48 81 e1 ff ff 00 00 	and    $0xffff,%rcx
    9fae:	75 1a                	jne    9fca <fwp_arg_drop3+0x6a>
    9fb0:	41 80 fa 02          	cmp    $0x2,%r10b
    9fb4:	75 14                	jne    9fca <fwp_arg_drop3+0x6a>
    9fb6:	4b 8d 0c 08          	lea    (%r8,%r9,1),%rcx
    9fba:	48 81 c1 28 02 00 00 	add    $0x228,%rcx
    9fc1:	eb 28                	jmp    9feb <fwp_arg_drop3+0x8b>
    9fc3:	83 fe 01             	cmp    $0x1,%esi
    9fc6:	76 5b                	jbe    a023 <fwp_arg_drop3+0xc3>
    9fc8:	eb 6f                	jmp    a039 <fwp_arg_drop3+0xd9>
    9fca:	41 80 fa 01          	cmp    $0x1,%r10b
    9fce:	75 53                	jne    a023 <fwp_arg_drop3+0xc3>
    9fd0:	4f 8d 14 08          	lea    (%r8,%r9,1),%r10
    9fd4:	47 8b 44 08 20       	mov    0x20(%r8,%r9,1),%r8d
    9fd9:	49 0f af c8          	imul   %r8,%rcx
    9fdd:	48 c1 e9 20          	shr    $0x20,%rcx
    9fe1:	4c 01 d1             	add    %r10,%rcx
    9fe4:	48 81 c1 28 02 00 00 	add    $0x228,%rcx
    9feb:	44 0f b6 01          	movzbl (%rcx),%r8d
    9fef:	45 85 c0             	test   %r8d,%r8d
    9ff2:	74 2f                	je     a023 <fwp_arg_drop3+0xc3>
    9ff4:	41 83 f8 01          	cmp    $0x1,%r8d
    9ff8:	75 1a                	jne    a014 <fwp_arg_drop3+0xb4>
    9ffa:	48 89 fb             	mov    %rdi,%rbx
    9ffd:	48 89 c7             	mov    %rax,%rdi
    a000:	89 f5                	mov    %esi,%ebp
    a002:	41 89 d6             	mov    %edx,%r14d
    a005:	e8 06 c5 ff ff       	call   6510 <fwp_rc_free_obj>
    a00a:	44 89 f2             	mov    %r14d,%edx
    a00d:	89 ee                	mov    %ebp,%esi
    a00f:	48 89 df             	mov    %rbx,%rdi
    a012:	eb 0f                	jmp    a023 <fwp_arg_drop3+0xc3>
    a014:	41 81 f8 ff 00 00 00 	cmp    $0xff,%r8d
    a01b:	74 21                	je     a03e <fwp_arg_drop3+0xde>
    a01d:	41 fe c8             	dec    %r8b
    a020:	44 88 01             	mov    %r8b,(%rcx)
    a023:	83 f6 01             	xor    $0x1,%esi
    a026:	39 d6                	cmp    %edx,%esi
    a028:	73 0f                	jae    a039 <fwp_arg_drop3+0xd9>
    a02a:	89 f0                	mov    %esi,%eax
    a02c:	48 8b 3c c7          	mov    (%rdi,%rax,8),%rdi
    a030:	5b                   	pop    %rbx
    a031:	41 5e                	pop    %r14
    a033:	5d                   	pop    %rbp
    a034:	e9 b7 bf ff ff       	jmp    5ff0 <fwp_closure_drop>
    a039:	5b                   	pop    %rbx
    a03a:	41 5e                	pop    %r14
    a03c:	5d                   	pop    %rbp
    a03d:	c3                   	ret
    a03e:	48 89 fb             	mov    %rdi,%rbx
    a041:	48 89 cf             	mov    %rcx,%rdi
    a044:	89 f5                	mov    %esi,%ebp
    a046:	41 89 d6             	mov    %edx,%r14d
    a049:	e8 b2 c2 ff ff       	call   6300 <fwp_rc_wide_drop>
    a04e:	eb ba                	jmp    a00a <fwp_arg_drop3+0xaa>

000000000000a050 <fwp_entry_release3>:
    a050:	53                   	push   %rbx
    a051:	48 8b 07             	mov    (%rdi),%rax
    a054:	48 8b 07             	mov    (%rdi),%rax
    a057:	48 89 c1             	mov    %rax,%rcx
    a05a:	48 2b 0d 77 61 00 00 	sub    0x6177(%rip),%rcx        # 101d8 <fwp_gc+0x1030>
    a061:	48 8b 15 98 61 00 00 	mov    0x6198(%rip),%rdx        # 10200 <fwp_gc+0x1058>
    a068:	48 c1 e2 10          	shl    $0x10,%rdx
    a06c:	48 39 d1             	cmp    %rdx,%rcx
    a06f:	73 7e                	jae    a0ef <fwp_entry_release3+0x9f>
    a071:	48 8b 15 a8 61 00 00 	mov    0x61a8(%rip),%rdx        # 10220 <fwp_gc+0x1078>
    a078:	48 89 ce             	mov    %rcx,%rsi
    a07b:	48 c1 ee 10          	shr    $0x10,%rsi
    a07f:	48 69 f6 28 12 00 00 	imul   $0x1228,%rsi,%rsi
    a086:	44 0f b6 04 32       	movzbl (%rdx,%rsi,1),%r8d
    a08b:	48 81 e1 ff ff 00 00 	and    $0xffff,%rcx
    a092:	75 13                	jne    a0a7 <fwp_entry_release3+0x57>
    a094:	41 80 f8 02          	cmp    $0x2,%r8b
    a098:	75 0d                	jne    a0a7 <fwp_entry_release3+0x57>
    a09a:	48 8d 0c 32          	lea    (%rdx,%rsi,1),%rcx
    a09e:	48 81 c1 28 02 00 00 	add    $0x228,%rcx
    a0a5:	eb 20                	jmp    a0c7 <fwp_entry_release3+0x77>
    a0a7:	41 80 f8 01          	cmp    $0x1,%r8b
    a0ab:	75 42                	jne    a0ef <fwp_entry_release3+0x9f>
    a0ad:	4c 8d 04 32          	lea    (%rdx,%rsi,1),%r8
    a0b1:	8b 54 32 20          	mov    0x20(%rdx,%rsi,1),%edx
    a0b5:	48 0f af ca          	imul   %rdx,%rcx
    a0b9:	48 c1 e9 20          	shr    $0x20,%rcx
    a0bd:	4c 01 c1             	add    %r8,%rcx
    a0c0:	48 81 c1 28 02 00 00 	add    $0x228,%rcx
    a0c7:	0f b6 11             	movzbl (%rcx),%edx
    a0ca:	85 d2                	test   %edx,%edx
    a0cc:	74 21                	je     a0ef <fwp_entry_release3+0x9f>
    a0ce:	83 fa 01             	cmp    $0x1,%edx
    a0d1:	75 10                	jne    a0e3 <fwp_entry_release3+0x93>
    a0d3:	48 89 fb             	mov    %rdi,%rbx
    a0d6:	48 89 c7             	mov    %rax,%rdi
    a0d9:	e8 32 c4 ff ff       	call   6510 <fwp_rc_free_obj>
    a0de:	48 89 df             	mov    %rbx,%rdi
    a0e1:	eb 0c                	jmp    a0ef <fwp_entry_release3+0x9f>
    a0e3:	81 fa ff 00 00 00    	cmp    $0xff,%edx
    a0e9:	74 12                	je     a0fd <fwp_entry_release3+0xad>
    a0eb:	fe ca                	dec    %dl
    a0ed:	88 11                	mov    %dl,(%rcx)
    a0ef:	48 8b 47 08          	mov    0x8(%rdi),%rax
    a0f3:	48 8b 7f 08          	mov    0x8(%rdi),%rdi
    a0f7:	5b                   	pop    %rbx
    a0f8:	e9 f3 be ff ff       	jmp    5ff0 <fwp_closure_drop>
    a0fd:	48 89 fb             	mov    %rdi,%rbx
    a100:	48 89 cf             	mov    %rcx,%rdi
    a103:	e8 f8 c1 ff ff       	call   6300 <fwp_rc_wide_drop>
    a108:	eb d4                	jmp    a0de <fwp_entry_release3+0x8e>
    a10a:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)

000000000000a110 <f4>:
    a110:	55                   	push   %rbp
    a111:	41 57                	push   %r15
    a113:	41 56                	push   %r14
    a115:	41 55                	push   %r13
    a117:	41 54                	push   %r12
    a119:	53                   	push   %rbx
    a11a:	48 81 ec 88 00 01 00 	sub    $0x10088,%rsp
    a121:	48 89 fb             	mov    %rdi,%rbx
    a124:	e8 d7 04 00 00       	call   a600 <fwp_file_dup>
    a129:	48 89 5c 24 48       	mov    %rbx,0x48(%rsp)
    a12e:	48 8d 05 ab d5 ff ff 	lea    -0x2a55(%rip),%rax        # 76e0 <fwp_file_drop>
    a135:	48 89 44 24 50       	mov    %rax,0x50(%rsp)
    a13a:	48 8b 05 27 6b 00 00 	mov    0x6b27(%rip),%rax        # 10c68 <fwp_cleanups>
    a141:	48 89 44 24 58       	mov    %rax,0x58(%rsp)
    a146:	48 8d 2d f3 c7 ff ff 	lea    -0x380d(%rip),%rbp        # 6940 <fwp_value_release>
    a14d:	48 89 6c 24 60       	mov    %rbp,0x60(%rsp)
    a152:	48 8d 44 24 48       	lea    0x48(%rsp),%rax
    a157:	48 89 44 24 68       	mov    %rax,0x68(%rsp)
    a15c:	0f 57 c0             	xorps  %xmm0,%xmm0
    a15f:	0f 29 04 24          	movaps %xmm0,(%rsp)
    a163:	48 c7 44 24 10 00 00 	movq   $0x0,0x10(%rsp)
    a16a:	00 00 
    a16c:	4c 8d 64 24 58       	lea    0x58(%rsp),%r12
    a171:	4c 89 64 24 30       	mov    %r12,0x30(%rsp)
    a176:	48 8d 05 f3 04 00 00 	lea    0x4f3(%rip),%rax        # a670 <fwp_file_buffer_cleanup>
    a17d:	48 89 44 24 38       	mov    %rax,0x38(%rsp)
    a182:	48 89 e0             	mov    %rsp,%rax
    a185:	48 89 44 24 40       	mov    %rax,0x40(%rsp)
    a18a:	4c 8d 6c 24 30       	lea    0x30(%rsp),%r13
    a18f:	4c 89 2d d2 6a 00 00 	mov    %r13,0x6ad2(%rip)        # 10c68 <fwp_cleanups>
    a196:	48 8b 0b             	mov    (%rbx),%rcx
    a199:	48 85 c9             	test   %rcx,%rcx
    a19c:	0f 84 de 01 00 00    	je     a380 <f4+0x270>
    a1a2:	48 8d bc 24 80 00 00 	lea    0x80(%rsp),%rdi
    a1a9:	00 
    a1aa:	be 01 00 00 00       	mov    $0x1,%esi
    a1af:	ba 00 00 01 00       	mov    $0x10000,%edx
    a1b4:	e8 07 7f ff ff       	call   20c0 <fread@plt>
    a1b9:	48 85 c0             	test   %rax,%rax
    a1bc:	74 3a                	je     a1f8 <f4+0xe8>
    a1be:	49 89 e6             	mov    %rsp,%r14
    a1c1:	4c 8d bc 24 80 00 00 	lea    0x80(%rsp),%r15
    a1c8:	00 
    a1c9:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)
    a1d0:	4c 89 f7             	mov    %r14,%rdi
    a1d3:	4c 89 fe             	mov    %r15,%rsi
    a1d6:	48 89 c2             	mov    %rax,%rdx
    a1d9:	e8 92 ea ff ff       	call   8c70 <buf_put>
    a1de:	48 8b 0b             	mov    (%rbx),%rcx
    a1e1:	be 01 00 00 00       	mov    $0x1,%esi
    a1e6:	ba 00 00 01 00       	mov    $0x10000,%edx
    a1eb:	4c 89 ff             	mov    %r15,%rdi
    a1ee:	e8 cd 7e ff ff       	call   20c0 <fread@plt>
    a1f3:	48 85 c0             	test   %rax,%rax
    a1f6:	75 d8                	jne    a1d0 <f4+0xc0>
    a1f8:	48 8b 3b             	mov    (%rbx),%rdi
    a1fb:	e8 a0 7e ff ff       	call   20a0 <ferror@plt>
    a200:	85 c0                	test   %eax,%eax
    a202:	0f 85 b0 03 00 00    	jne    a5b8 <f4+0x4a8>
    a208:	48 8b 3c 24          	mov    (%rsp),%rdi
    a20c:	48 8b 44 24 08       	mov    0x8(%rsp),%rax
    a211:	48 85 ff             	test   %rdi,%rdi
    a214:	48 8d 0d 56 24 00 00 	lea    0x2456(%rip),%rcx        # c671 <fwp_segv.msg+0x431>
    a21b:	48 0f 45 cf          	cmovne %rdi,%rcx
    a21f:	48 85 c0             	test   %rax,%rax
    a222:	0f 84 58 01 00 00    	je     a380 <f4+0x270>
    a228:	31 d2                	xor    %edx,%edx
    a22a:	eb 10                	jmp    a23c <f4+0x12c>
    a22c:	0f 1f 40 00          	nopl   0x0(%rax)
    a230:	48 ff c2             	inc    %rdx
    a233:	48 39 c2             	cmp    %rax,%rdx
    a236:	0f 83 44 01 00 00    	jae    a380 <f4+0x270>
    a23c:	44 0f b6 14 11       	movzbl (%rcx,%rdx,1),%r10d
    a241:	45 84 d2             	test   %r10b,%r10b
    a244:	79 ea                	jns    a230 <f4+0x120>
    a246:	41 8d 72 3e          	lea    0x3e(%r10),%esi
    a24a:	40 80 fe 1e          	cmp    $0x1e,%sil
    a24e:	73 13                	jae    a263 <f4+0x153>
    a250:	be 80 00 00 00       	mov    $0x80,%esi
    a255:	41 b9 01 00 00 00    	mov    $0x1,%r9d
    a25b:	41 b8 1f 00 00 00    	mov    $0x1f,%r8d
    a261:	eb 3f                	jmp    a2a2 <f4+0x192>
    a263:	44 89 d6             	mov    %r10d,%esi
    a266:	40 80 e6 f0          	and    $0xf0,%sil
    a26a:	40 80 fe e0          	cmp    $0xe0,%sil
    a26e:	75 13                	jne    a283 <f4+0x173>
    a270:	be 00 08 00 00       	mov    $0x800,%esi
    a275:	41 b9 02 00 00 00    	mov    $0x2,%r9d
    a27b:	41 b8 0f 00 00 00    	mov    $0xf,%r8d
    a281:	eb 1f                	jmp    a2a2 <f4+0x192>
    a283:	41 8d 72 10          	lea    0x10(%r10),%esi
    a287:	40 80 fe 04          	cmp    $0x4,%sil
    a28b:	0f 87 f2 02 00 00    	ja     a583 <f4+0x473>
    a291:	be 00 00 01 00       	mov    $0x10000,%esi
    a296:	41 b9 03 00 00 00    	mov    $0x3,%r9d
    a29c:	41 b8 07 00 00 00    	mov    $0x7,%r8d
    a2a2:	45 89 c9             	mov    %r9d,%r9d
    a2a5:	4e 8d 1c 0a          	lea    (%rdx,%r9,1),%r11
    a2a9:	49 39 c3             	cmp    %rax,%r11
    a2ac:	0f 83 d1 02 00 00    	jae    a583 <f4+0x473>
    a2b2:	44 0f b6 5c 11 01    	movzbl 0x1(%rcx,%rdx,1),%r11d
    a2b8:	45 89 de             	mov    %r11d,%r14d
    a2bb:	41 83 e6 c0          	and    $0xffffffc0,%r14d
    a2bf:	41 81 fe 80 00 00 00 	cmp    $0x80,%r14d
    a2c6:	0f 85 b7 02 00 00    	jne    a583 <f4+0x473>
    a2cc:	45 21 d0             	and    %r10d,%r8d
    a2cf:	45 8d 51 01          	lea    0x1(%r9),%r10d
    a2d3:	45 89 c6             	mov    %r8d,%r14d
    a2d6:	41 c1 e6 06          	shl    $0x6,%r14d
    a2da:	41 83 e3 3f          	and    $0x3f,%r11d
    a2de:	45 09 f3             	or     %r14d,%r11d
    a2e1:	41 83 fa 02          	cmp    $0x2,%r10d
    a2e5:	75 05                	jne    a2ec <f4+0x1dc>
    a2e7:	45 89 da             	mov    %r11d,%r10d
    a2ea:	eb 5e                	jmp    a34a <f4+0x23a>
    a2ec:	44 0f b6 44 11 02    	movzbl 0x2(%rcx,%rdx,1),%r8d
    a2f2:	45 89 c6             	mov    %r8d,%r14d
    a2f5:	41 83 e6 c0          	and    $0xffffffc0,%r14d
    a2f9:	41 81 fe 80 00 00 00 	cmp    $0x80,%r14d
    a300:	0f 85 7d 02 00 00    	jne    a583 <f4+0x473>
    a306:	45 89 de             	mov    %r11d,%r14d
    a309:	41 c1 e6 06          	shl    $0x6,%r14d
    a30d:	41 83 e0 3f          	and    $0x3f,%r8d
    a311:	45 09 f0             	or     %r14d,%r8d
    a314:	41 83 fa 03          	cmp    $0x3,%r10d
    a318:	75 08                	jne    a322 <f4+0x212>
    a31a:	45 89 c2             	mov    %r8d,%r10d
    a31d:	45 89 d8             	mov    %r11d,%r8d
    a320:	eb 28                	jmp    a34a <f4+0x23a>
    a322:	44 0f b6 54 11 03    	movzbl 0x3(%rcx,%rdx,1),%r10d
    a328:	45 89 d3             	mov    %r10d,%r11d
    a32b:	41 83 e3 c0          	and    $0xffffffc0,%r11d
    a32f:	41 81 fb 80 00 00 00 	cmp    $0x80,%r11d
    a336:	0f 85 47 02 00 00    	jne    a583 <f4+0x473>
    a33c:	45 89 c3             	mov    %r8d,%r11d
    a33f:	41 c1 e3 06          	shl    $0x6,%r11d
    a343:	41 83 e2 3f          	and    $0x3f,%r10d
    a347:	45 09 da             	or     %r11d,%r10d
    a34a:	41 83 e0 e0          	and    $0xffffffe0,%r8d
    a34e:	41 81 f8 60 03 00 00 	cmp    $0x360,%r8d
    a355:	0f 84 28 02 00 00    	je     a583 <f4+0x473>
    a35b:	41 39 f2             	cmp    %esi,%r10d
    a35e:	0f 82 1f 02 00 00    	jb     a583 <f4+0x473>
    a364:	41 81 fa ff ff 10 00 	cmp    $0x10ffff,%r10d
    a36b:	0f 87 12 02 00 00    	ja     a583 <f4+0x473>
    a371:	4c 01 ca             	add    %r9,%rdx
    a374:	48 ff c2             	inc    %rdx
    a377:	48 39 c2             	cmp    %rax,%rdx
    a37a:	0f 82 bc fe ff ff    	jb     a23c <f4+0x12c>
    a380:	48 89 e7             	mov    %rsp,%rdi
    a383:	e8 08 03 00 00       	call   a690 <buf_to_str>
    a388:	48 89 c1             	mov    %rax,%rcx
    a38b:	48 2b 0d 46 5e 00 00 	sub    0x5e46(%rip),%rcx        # 101d8 <fwp_gc+0x1030>
    a392:	48 8b 15 67 5e 00 00 	mov    0x5e67(%rip),%rdx        # 10200 <fwp_gc+0x1058>
    a399:	48 c1 e2 10          	shl    $0x10,%rdx
    a39d:	48 39 d1             	cmp    %rdx,%rcx
    a3a0:	73 76                	jae    a418 <f4+0x308>
    a3a2:	48 8b 15 77 5e 00 00 	mov    0x5e77(%rip),%rdx        # 10220 <fwp_gc+0x1078>
    a3a9:	48 89 ce             	mov    %rcx,%rsi
    a3ac:	48 c1 ee 10          	shr    $0x10,%rsi
    a3b0:	48 69 f6 28 12 00 00 	imul   $0x1228,%rsi,%rsi
    a3b7:	0f b6 3c 32          	movzbl (%rdx,%rsi,1),%edi
    a3bb:	48 81 e1 ff ff 00 00 	and    $0xffff,%rcx
    a3c2:	75 1d                	jne    a3e1 <f4+0x2d1>
    a3c4:	40 80 ff 02          	cmp    $0x2,%dil
    a3c8:	75 17                	jne    a3e1 <f4+0x2d1>
    a3ca:	4c 8d 34 32          	lea    (%rdx,%rsi,1),%r14
    a3ce:	49 81 c6 28 02 00 00 	add    $0x228,%r14
    a3d5:	41 80 3e ff          	cmpb   $0xff,(%r14)
    a3d9:	74 2d                	je     a408 <f4+0x2f8>
    a3db:	41 c6 06 01          	movb   $0x1,(%r14)
    a3df:	eb 37                	jmp    a418 <f4+0x308>
    a3e1:	40 80 ff 01          	cmp    $0x1,%dil
    a3e5:	75 31                	jne    a418 <f4+0x308>
    a3e7:	48 8d 3c 32          	lea    (%rdx,%rsi,1),%rdi
    a3eb:	8b 54 32 20          	mov    0x20(%rdx,%rsi,1),%edx
    a3ef:	48 0f af ca          	imul   %rdx,%rcx
    a3f3:	48 c1 e9 20          	shr    $0x20,%rcx
    a3f7:	4c 8d 34 39          	lea    (%rcx,%rdi,1),%r14
    a3fb:	49 81 c6 28 02 00 00 	add    $0x228,%r14
    a402:	41 80 3e ff          	cmpb   $0xff,(%r14)
    a406:	75 d3                	jne    a3db <f4+0x2cb>
    a408:	4c 89 f7             	mov    %r14,%rdi
    a40b:	49 89 c7             	mov    %rax,%r15
    a40e:	e8 cd 93 ff ff       	call   37e0 <fwp_rc_forget_slot>
    a413:	4c 89 f8             	mov    %r15,%rax
    a416:	eb c3                	jmp    a3db <f4+0x2cb>
    a418:	48 c7 04 24 00 00 00 	movq   $0x0,(%rsp)
    a41f:	00 
    a420:	48 89 44 24 20       	mov    %rax,0x20(%rsp)
    a425:	48 8d 0d 54 03 00 00 	lea    0x354(%rip),%rcx        # a780 <fwp_file_text_drop>
    a42c:	48 89 4c 24 28       	mov    %rcx,0x28(%rsp)
    a431:	48 8b 0d 30 68 00 00 	mov    0x6830(%rip),%rcx        # 10c68 <fwp_cleanups>
    a438:	48 89 8c 24 80 00 00 	mov    %rcx,0x80(%rsp)
    a43f:	00 
    a440:	48 89 ac 24 88 00 00 	mov    %rbp,0x88(%rsp)
    a447:	00 
    a448:	48 8d 4c 24 20       	lea    0x20(%rsp),%rcx
    a44d:	48 89 8c 24 90 00 00 	mov    %rcx,0x90(%rsp)
    a454:	00 
    a455:	4c 8d bc 24 80 00 00 	lea    0x80(%rsp),%r15
    a45c:	00 
    a45d:	4c 89 3d 04 68 00 00 	mov    %r15,0x6804(%rip)        # 10c68 <fwp_cleanups>
    a464:	48 89 44 24 70       	mov    %rax,0x70(%rsp)
    a469:	48 89 5c 24 78       	mov    %rbx,0x78(%rsp)
    a46e:	48 8d 54 24 70       	lea    0x70(%rsp),%rdx
    a473:	31 ff                	xor    %edi,%edi
    a475:	be 02 00 00 00       	mov    $0x2,%esi
    a47a:	e8 51 9d ff ff       	call   41d0 <fwp_data>
    a47f:	48 89 c1             	mov    %rax,%rcx
    a482:	48 2b 0d 4f 5d 00 00 	sub    0x5d4f(%rip),%rcx        # 101d8 <fwp_gc+0x1030>
    a489:	48 8b 15 70 5d 00 00 	mov    0x5d70(%rip),%rdx        # 10200 <fwp_gc+0x1058>
    a490:	48 c1 e2 10          	shl    $0x10,%rdx
    a494:	48 39 d1             	cmp    %rdx,%rcx
    a497:	73 76                	jae    a50f <f4+0x3ff>
    a499:	48 8b 15 80 5d 00 00 	mov    0x5d80(%rip),%rdx        # 10220 <fwp_gc+0x1078>
    a4a0:	48 89 ce             	mov    %rcx,%rsi
    a4a3:	48 c1 ee 10          	shr    $0x10,%rsi
    a4a7:	48 69 f6 28 12 00 00 	imul   $0x1228,%rsi,%rsi
    a4ae:	0f b6 3c 32          	movzbl (%rdx,%rsi,1),%edi
    a4b2:	48 81 e1 ff ff 00 00 	and    $0xffff,%rcx
    a4b9:	75 1d                	jne    a4d8 <f4+0x3c8>
    a4bb:	40 80 ff 02          	cmp    $0x2,%dil
    a4bf:	75 17                	jne    a4d8 <f4+0x3c8>
    a4c1:	4c 8d 34 32          	lea    (%rdx,%rsi,1),%r14
    a4c5:	49 81 c6 28 02 00 00 	add    $0x228,%r14
    a4cc:	41 80 3e ff          	cmpb   $0xff,(%r14)
    a4d0:	74 2d                	je     a4ff <f4+0x3ef>
    a4d2:	41 c6 06 01          	movb   $0x1,(%r14)
    a4d6:	eb 37                	jmp    a50f <f4+0x3ff>
    a4d8:	40 80 ff 01          	cmp    $0x1,%dil
    a4dc:	75 31                	jne    a50f <f4+0x3ff>
    a4de:	48 8d 3c 32          	lea    (%rdx,%rsi,1),%rdi
    a4e2:	8b 54 32 20          	mov    0x20(%rdx,%rsi,1),%edx
    a4e6:	48 0f af ca          	imul   %rdx,%rcx
    a4ea:	48 c1 e9 20          	shr    $0x20,%rcx
    a4ee:	4c 8d 34 39          	lea    (%rcx,%rdi,1),%r14
    a4f2:	49 81 c6 28 02 00 00 	add    $0x228,%r14
    a4f9:	41 80 3e ff          	cmpb   $0xff,(%r14)
    a4fd:	75 d3                	jne    a4d2 <f4+0x3c2>
    a4ff:	4c 89 f7             	mov    %r14,%rdi
    a502:	48 89 c5             	mov    %rax,%rbp
    a505:	e8 d6 92 ff ff       	call   37e0 <fwp_rc_forget_slot>
    a50a:	48 89 e8             	mov    %rbp,%rax
    a50d:	eb c3                	jmp    a4d2 <f4+0x3c2>
    a50f:	48 83 7c 24 28 00    	cmpq   $0x0,0x28(%rsp)
    a515:	48 8b 0d 4c 67 00 00 	mov    0x674c(%rip),%rcx        # 10c68 <fwp_cleanups>
    a51c:	74 18                	je     a536 <f4+0x426>
    a51e:	4c 39 f9             	cmp    %r15,%rcx
    a521:	0f 85 d4 00 00 00    	jne    a5fb <f4+0x4eb>
    a527:	48 8b 8c 24 80 00 00 	mov    0x80(%rsp),%rcx
    a52e:	00 
    a52f:	48 89 0d 32 67 00 00 	mov    %rcx,0x6732(%rip)        # 10c68 <fwp_cleanups>
    a536:	48 c7 44 24 20 00 00 	movq   $0x0,0x20(%rsp)
    a53d:	00 00 
    a53f:	4c 39 e9             	cmp    %r13,%rcx
    a542:	0f 85 b3 00 00 00    	jne    a5fb <f4+0x4eb>
    a548:	48 8b 4c 24 30       	mov    0x30(%rsp),%rcx
    a54d:	48 89 0d 14 67 00 00 	mov    %rcx,0x6714(%rip)        # 10c68 <fwp_cleanups>
    a554:	48 83 7c 24 50 00    	cmpq   $0x0,0x50(%rsp)
    a55a:	74 15                	je     a571 <f4+0x461>
    a55c:	4c 39 e1             	cmp    %r12,%rcx
    a55f:	0f 85 96 00 00 00    	jne    a5fb <f4+0x4eb>
    a565:	48 8b 4c 24 58       	mov    0x58(%rsp),%rcx
    a56a:	48 89 0d f7 66 00 00 	mov    %rcx,0x66f7(%rip)        # 10c68 <fwp_cleanups>
    a571:	48 81 c4 88 00 01 00 	add    $0x10088,%rsp
    a578:	5b                   	pop    %rbx
    a579:	41 5c                	pop    %r12
    a57b:	41 5d                	pop    %r13
    a57d:	41 5e                	pop    %r14
    a57f:	41 5f                	pop    %r15
    a581:	5d                   	pop    %rbp
    a582:	c3                   	ret
    a583:	4c 39 2d de 66 00 00 	cmp    %r13,0x66de(%rip)        # 10c68 <fwp_cleanups>
    a58a:	75 6f                	jne    a5fb <f4+0x4eb>
    a58c:	48 8b 44 24 30       	mov    0x30(%rsp),%rax
    a591:	48 89 05 d0 66 00 00 	mov    %rax,0x66d0(%rip)        # 10c68 <fwp_cleanups>
    a598:	e8 b3 7a ff ff       	call   2050 <free@plt>
    a59d:	48 c7 04 24 00 00 00 	movq   $0x0,(%rsp)
    a5a4:	00 
    a5a5:	48 8d 3d 6b 20 00 00 	lea    0x206b(%rip),%rdi        # c617 <fwp_segv.msg+0x3d7>
    a5ac:	48 8d 35 69 20 00 00 	lea    0x2069(%rip),%rsi        # c61c <fwp_segv.msg+0x3dc>
    a5b3:	e8 68 cf ff ff       	call   7520 <fwp_io_error>
    a5b8:	4c 39 2d a9 66 00 00 	cmp    %r13,0x66a9(%rip)        # 10c68 <fwp_cleanups>
    a5bf:	75 3a                	jne    a5fb <f4+0x4eb>
    a5c1:	e8 aa 7a ff ff       	call   2070 <__errno_location@plt>
    a5c6:	8b 18                	mov    (%rax),%ebx
    a5c8:	48 8b 44 24 30       	mov    0x30(%rsp),%rax
    a5cd:	48 89 05 94 66 00 00 	mov    %rax,0x6694(%rip)        # 10c68 <fwp_cleanups>
    a5d4:	48 8b 3c 24          	mov    (%rsp),%rdi
    a5d8:	e8 73 7a ff ff       	call   2050 <free@plt>
    a5dd:	48 c7 04 24 00 00 00 	movq   $0x0,(%rsp)
    a5e4:	00 
    a5e5:	89 df                	mov    %ebx,%edi
    a5e7:	e8 34 7d ff ff       	call   2320 <strerror@plt>
    a5ec:	48 8d 3d 24 20 00 00 	lea    0x2024(%rip),%rdi        # c617 <fwp_segv.msg+0x3d7>
    a5f3:	48 89 c6             	mov    %rax,%rsi
    a5f6:	e8 25 cf ff ff       	call   7520 <fwp_io_error>
    a5fb:	e8 60 7a ff ff       	call   2060 <abort@plt>

000000000000a600 <fwp_file_dup>:
    a600:	50                   	push   %rax
    a601:	48 85 ff             	test   %rdi,%rdi
    a604:	74 16                	je     a61c <fwp_file_dup+0x1c>
    a606:	48 8b 47 08          	mov    0x8(%rdi),%rax
    a60a:	48 83 f8 ff          	cmp    $0xffffffffffffffff,%rax
    a60e:	74 0e                	je     a61e <fwp_file_dup+0x1e>
    a610:	48 85 c0             	test   %rax,%rax
    a613:	74 28                	je     a63d <fwp_file_dup+0x3d>
    a615:	48 ff c0             	inc    %rax
    a618:	48 89 47 08          	mov    %rax,0x8(%rdi)
    a61c:	58                   	pop    %rax
    a61d:	c3                   	ret
    a61e:	e8 8d 91 ff ff       	call   37b0 <fwp_flush>
    a623:	48 8b 05 b6 49 00 00 	mov    0x49b6(%rip),%rax        # efe0 <stderr@GLIBC_2.2.5>
    a62a:	48 8b 38             	mov    (%rax),%rdi
    a62d:	48 8d 35 00 1d 00 00 	lea    0x1d00(%rip),%rsi        # c334 <fwp_segv.msg+0xf4>
    a634:	48 8d 15 b5 1e 00 00 	lea    0x1eb5(%rip),%rdx        # c4f0 <fwp_segv.msg+0x2b0>
    a63b:	eb 1d                	jmp    a65a <fwp_file_dup+0x5a>
    a63d:	e8 6e 91 ff ff       	call   37b0 <fwp_flush>
    a642:	48 8b 05 97 49 00 00 	mov    0x4997(%rip),%rax        # efe0 <stderr@GLIBC_2.2.5>
    a649:	48 8b 38             	mov    (%rax),%rdi
    a64c:	48 8d 35 e1 1c 00 00 	lea    0x1ce1(%rip),%rsi        # c334 <fwp_segv.msg+0xf4>
    a653:	48 8d 15 9a 1f 00 00 	lea    0x1f9a(%rip),%rdx        # c5f4 <fwp_segv.msg+0x3b4>
    a65a:	31 c0                	xor    %eax,%eax
    a65c:	e8 7f 7b ff ff       	call   21e0 <fprintf@plt>
    a661:	bf 65 00 00 00       	mov    $0x65,%edi
    a666:	e8 65 7c ff ff       	call   22d0 <exit@plt>
    a66b:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)

000000000000a670 <fwp_file_buffer_cleanup>:
    a670:	53                   	push   %rbx
    a671:	48 89 fb             	mov    %rdi,%rbx
    a674:	48 8b 3f             	mov    (%rdi),%rdi
    a677:	e8 d4 79 ff ff       	call   2050 <free@plt>
    a67c:	48 c7 03 00 00 00 00 	movq   $0x0,(%rbx)
    a683:	5b                   	pop    %rbx
    a684:	c3                   	ret
    a685:	66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
    a68c:	00 00 00 00 

000000000000a690 <buf_to_str>:
    a690:	41 57                	push   %r15
    a692:	41 56                	push   %r14
    a694:	41 55                	push   %r13
    a696:	41 54                	push   %r12
    a698:	53                   	push   %rbx
    a699:	48 89 fb             	mov    %rdi,%rbx
    a69c:	4c 8b 2f             	mov    (%rdi),%r13
    a69f:	4c 8b 77 08          	mov    0x8(%rdi),%r14
    a6a3:	49 8d 56 09          	lea    0x9(%r14),%rdx
    a6a7:	48 81 fa 00 40 00 00 	cmp    $0x4000,%rdx
    a6ae:	77 61                	ja     a711 <buf_to_str+0x81>
    a6b0:	49 8d 4e 18          	lea    0x18(%r14),%rcx
    a6b4:	48 c1 e9 04          	shr    $0x4,%rcx
    a6b8:	48 8d 05 e9 4a 00 00 	lea    0x4ae9(%rip),%rax        # f1a8 <fwp_gc>
    a6bf:	0f b6 b4 01 e8 0b 00 	movzbl 0xbe8(%rcx,%rax,1),%esi
    a6c6:	00 
    a6c7:	8b 8c b0 48 0b 00 00 	mov    0xb48(%rax,%rsi,4),%ecx
    a6ce:	48 29 0d d3 4a 00 00 	sub    %rcx,0x4ad3(%rip)        # f1a8 <fwp_gc>
    a6d5:	78 3a                	js     a711 <buf_to_str+0x81>
    a6d7:	48 8d 34 76          	lea    (%rsi,%rsi,2),%rsi
    a6db:	48 8d 3c f0          	lea    (%rax,%rsi,8),%rdi
    a6df:	48 81 c7 c8 03 00 00 	add    $0x3c8,%rdi
    a6e6:	4c 8b 3f             	mov    (%rdi),%r15
    a6e9:	4d 85 ff             	test   %r15,%r15
    a6ec:	74 0b                	je     a6f9 <buf_to_str+0x69>
    a6ee:	49 8b 07             	mov    (%r15),%rax
    a6f1:	48 f7 d0             	not    %rax
    a6f4:	48 89 07             	mov    %rax,(%rdi)
    a6f7:	eb 3a                	jmp    a733 <buf_to_str+0xa3>
    a6f9:	4c 8b bc f0 d0 03 00 	mov    0x3d0(%rax,%rsi,8),%r15
    a700:	00 
    a701:	48 8b bc f0 d8 03 00 	mov    0x3d8(%rax,%rsi,8),%rdi
    a708:	00 
    a709:	4c 29 ff             	sub    %r15,%rdi
    a70c:	48 39 cf             	cmp    %rcx,%rdi
    a70f:	73 12                	jae    a723 <buf_to_str+0x93>
    a711:	48 89 d7             	mov    %rdx,%rdi
    a714:	be 01 00 00 00       	mov    $0x1,%esi
    a719:	e8 52 ad ff ff       	call   5470 <fwp_gc_alloc_slow>
    a71e:	49 89 c7             	mov    %rax,%r15
    a721:	eb 1a                	jmp    a73d <buf_to_str+0xad>
    a723:	48 8d 04 f0          	lea    (%rax,%rsi,8),%rax
    a727:	48 05 d0 03 00 00    	add    $0x3d0,%rax
    a72d:	4c 01 f9             	add    %r15,%rcx
    a730:	48 89 08             	mov    %rcx,(%rax)
    a733:	4c 89 ff             	mov    %r15,%rdi
    a736:	31 f6                	xor    %esi,%esi
    a738:	e8 23 7a ff ff       	call   2160 <memset@plt>
    a73d:	4d 85 ed             	test   %r13,%r13
    a740:	4c 8d 25 2a 1f 00 00 	lea    0x1f2a(%rip),%r12        # c671 <fwp_segv.msg+0x431>
    a747:	4d 0f 45 e5          	cmovne %r13,%r12
    a74b:	4d 89 37             	mov    %r14,(%r15)
    a74e:	49 8d 7f 08          	lea    0x8(%r15),%rdi
    a752:	4c 89 e6             	mov    %r12,%rsi
    a755:	4c 89 f2             	mov    %r14,%rdx
    a758:	e8 b3 7a ff ff       	call   2210 <memcpy@plt>
    a75d:	43 c6 44 37 08 00    	movb   $0x0,0x8(%r15,%r14,1)
    a763:	48 8b 3b             	mov    (%rbx),%rdi
    a766:	e8 e5 78 ff ff       	call   2050 <free@plt>
    a76b:	4c 89 f8             	mov    %r15,%rax
    a76e:	5b                   	pop    %rbx
    a76f:	41 5c                	pop    %r12
    a771:	41 5d                	pop    %r13
    a773:	41 5e                	pop    %r14
    a775:	41 5f                	pop    %r15
    a777:	c3                   	ret
    a778:	0f 1f 84 00 00 00 00 	nopl   0x0(%rax,%rax,1)
    a77f:	00 

000000000000a780 <fwp_file_text_drop>:
    a780:	e9 8b bd ff ff       	jmp    6510 <fwp_rc_free_obj>
    a785:	66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
    a78c:	00 00 00 00 

000000000000a790 <fwp_owned_entry4>:
    a790:	41 57                	push   %r15
    a792:	41 56                	push   %r14
    a794:	53                   	push   %rbx
    a795:	48 83 ec 20          	sub    $0x20,%rsp
    a799:	48 89 fb             	mov    %rdi,%rbx
    a79c:	48 8b 05 c5 64 00 00 	mov    0x64c5(%rip),%rax        # 10c68 <fwp_cleanups>
    a7a3:	48 89 44 24 08       	mov    %rax,0x8(%rsp)
    a7a8:	48 8d 05 e1 00 00 00 	lea    0xe1(%rip),%rax        # a890 <fwp_entry_release4>
    a7af:	48 89 44 24 10       	mov    %rax,0x10(%rsp)
    a7b4:	48 89 7c 24 18       	mov    %rdi,0x18(%rsp)
    a7b9:	4c 8d 7c 24 08       	lea    0x8(%rsp),%r15
    a7be:	4c 89 3d a3 64 00 00 	mov    %r15,0x64a3(%rip)        # 10c68 <fwp_cleanups>
    a7c5:	48 8b 3f             	mov    (%rdi),%rdi
    a7c8:	e8 43 f9 ff ff       	call   a110 <f4>
    a7cd:	4c 39 3d 94 64 00 00 	cmp    %r15,0x6494(%rip)        # 10c68 <fwp_cleanups>
    a7d4:	75 27                	jne    a7fd <fwp_owned_entry4+0x6d>
    a7d6:	49 89 c6             	mov    %rax,%r14
    a7d9:	48 8b 44 24 08       	mov    0x8(%rsp),%rax
    a7de:	48 89 05 83 64 00 00 	mov    %rax,0x6483(%rip)        # 10c68 <fwp_cleanups>
    a7e5:	48 8b 03             	mov    (%rbx),%rax
    a7e8:	48 8b 3b             	mov    (%rbx),%rdi
    a7eb:	e8 f0 ce ff ff       	call   76e0 <fwp_file_drop>
    a7f0:	4c 89 f0             	mov    %r14,%rax
    a7f3:	48 83 c4 20          	add    $0x20,%rsp
    a7f7:	5b                   	pop    %rbx
    a7f8:	41 5e                	pop    %r14
    a7fa:	41 5f                	pop    %r15
    a7fc:	c3                   	ret
    a7fd:	e8 5e 78 ff ff       	call   2060 <abort@plt>
    a802:	66 66 66 66 66 2e 0f 	data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    a809:	1f 84 00 00 00 00 00 

000000000000a810 <fwp_caps4>:
    a810:	8b 47 04             	mov    0x4(%rdi),%eax
    a813:	85 f6                	test   %esi,%esi
    a815:	74 0d                	je     a824 <fwp_caps4+0x14>
    a817:	85 c0                	test   %eax,%eax
    a819:	74 2a                	je     a845 <fwp_caps4+0x35>
    a81b:	48 8b 7f 08          	mov    0x8(%rdi),%rdi
    a81f:	e9 dc fd ff ff       	jmp    a600 <fwp_file_dup>
    a824:	85 c0                	test   %eax,%eax
    a826:	0f 84 e4 bc ff ff    	je     6510 <fwp_rc_free_obj>
    a82c:	53                   	push   %rbx
    a82d:	48 8b 47 08          	mov    0x8(%rdi),%rax
    a831:	48 89 fb             	mov    %rdi,%rbx
    a834:	48 89 c7             	mov    %rax,%rdi
    a837:	e8 a4 ce ff ff       	call   76e0 <fwp_file_drop>
    a83c:	48 89 df             	mov    %rbx,%rdi
    a83f:	5b                   	pop    %rbx
    a840:	e9 cb bc ff ff       	jmp    6510 <fwp_rc_free_obj>
    a845:	c3                   	ret
    a846:	66 2e 0f 1f 84 00 00 	cs nopw 0x0(%rax,%rax,1)
    a84d:	00 00 00 

000000000000a850 <fwp_args4>:
    a850:	85 f6                	test   %esi,%esi
    a852:	75 0c                	jne    a860 <fwp_args4+0x10>
    a854:	85 d2                	test   %edx,%edx
    a856:	74 08                	je     a860 <fwp_args4+0x10>
    a858:	48 8b 3f             	mov    (%rdi),%rdi
    a85b:	e9 a0 fd ff ff       	jmp    a600 <fwp_file_dup>
    a860:	c3                   	ret
    a861:	66 66 66 66 66 66 2e 	data16 data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    a868:	0f 1f 84 00 00 00 00 
    a86f:	00 

000000000000a870 <fwp_arg_drop4>:
    a870:	85 f6                	test   %esi,%esi
    a872:	75 0c                	jne    a880 <fwp_arg_drop4+0x10>
    a874:	85 d2                	test   %edx,%edx
    a876:	74 08                	je     a880 <fwp_arg_drop4+0x10>
    a878:	48 8b 3f             	mov    (%rdi),%rdi
    a87b:	e9 60 ce ff ff       	jmp    76e0 <fwp_file_drop>
    a880:	c3                   	ret
    a881:	66 66 66 66 66 66 2e 	data16 data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    a888:	0f 1f 84 00 00 00 00 
    a88f:	00 

000000000000a890 <fwp_entry_release4>:
    a890:	48 8b 07             	mov    (%rdi),%rax
    a893:	48 8b 3f             	mov    (%rdi),%rdi
    a896:	e9 45 ce ff ff       	jmp    76e0 <fwp_file_drop>
    a89b:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)

000000000000a8a0 <f8>:
    a8a0:	41 56                	push   %r14
    a8a2:	53                   	push   %rbx
    a8a3:	48 83 ec 18          	sub    $0x18,%rsp
    a8a7:	48 89 fe             	mov    %rdi,%rsi
    a8aa:	0f 57 c0             	xorps  %xmm0,%xmm0
    a8ad:	0f 29 04 24          	movaps %xmm0,(%rsp)
    a8b1:	48 c7 44 24 10 00 00 	movq   $0x0,0x10(%rsp)
    a8b8:	00 00 
    a8ba:	48 8d 15 1f 44 00 00 	lea    0x441f(%rip),%rdx        # ece0 <d2>
    a8c1:	48 89 e3             	mov    %rsp,%rbx
    a8c4:	48 89 df             	mov    %rbx,%rdi
    a8c7:	b9 01 00 00 00       	mov    $0x1,%ecx
    a8cc:	e8 bf cf ff ff       	call   7890 <fwp_write>
    a8d1:	48 89 df             	mov    %rbx,%rdi
    a8d4:	e8 b7 fd ff ff       	call   a690 <buf_to_str>
    a8d9:	48 89 c1             	mov    %rax,%rcx
    a8dc:	48 2b 0d f5 58 00 00 	sub    0x58f5(%rip),%rcx        # 101d8 <fwp_gc+0x1030>
    a8e3:	48 8b 15 16 59 00 00 	mov    0x5916(%rip),%rdx        # 10200 <fwp_gc+0x1058>
    a8ea:	48 c1 e2 10          	shl    $0x10,%rdx
    a8ee:	48 39 d1             	cmp    %rdx,%rcx
    a8f1:	73 73                	jae    a966 <f8+0xc6>
    a8f3:	48 8b 15 26 59 00 00 	mov    0x5926(%rip),%rdx        # 10220 <fwp_gc+0x1078>
    a8fa:	48 89 ce             	mov    %rcx,%rsi
    a8fd:	48 c1 ee 10          	shr    $0x10,%rsi
    a901:	48 69 f6 28 12 00 00 	imul   $0x1228,%rsi,%rsi
    a908:	0f b6 3c 32          	movzbl (%rdx,%rsi,1),%edi
    a90c:	48 81 e1 ff ff 00 00 	and    $0xffff,%rcx
    a913:	75 1b                	jne    a930 <f8+0x90>
    a915:	40 80 ff 02          	cmp    $0x2,%dil
    a919:	75 15                	jne    a930 <f8+0x90>
    a91b:	48 8d 1c 32          	lea    (%rdx,%rsi,1),%rbx
    a91f:	48 81 c3 28 02 00 00 	add    $0x228,%rbx
    a926:	80 3b ff             	cmpb   $0xff,(%rbx)
    a929:	74 2b                	je     a956 <f8+0xb6>
    a92b:	c6 03 01             	movb   $0x1,(%rbx)
    a92e:	eb 36                	jmp    a966 <f8+0xc6>
    a930:	40 80 ff 01          	cmp    $0x1,%dil
    a934:	75 30                	jne    a966 <f8+0xc6>
    a936:	48 8d 3c 32          	lea    (%rdx,%rsi,1),%rdi
    a93a:	8b 54 32 20          	mov    0x20(%rdx,%rsi,1),%edx
    a93e:	48 0f af ca          	imul   %rdx,%rcx
    a942:	48 c1 e9 20          	shr    $0x20,%rcx
    a946:	48 8d 1c 39          	lea    (%rcx,%rdi,1),%rbx
    a94a:	48 81 c3 28 02 00 00 	add    $0x228,%rbx
    a951:	80 3b ff             	cmpb   $0xff,(%rbx)
    a954:	75 d5                	jne    a92b <f8+0x8b>
    a956:	48 89 df             	mov    %rbx,%rdi
    a959:	49 89 c6             	mov    %rax,%r14
    a95c:	e8 7f 8e ff ff       	call   37e0 <fwp_rc_forget_slot>
    a961:	4c 89 f0             	mov    %r14,%rax
    a964:	eb c5                	jmp    a92b <f8+0x8b>
    a966:	48 83 c4 18          	add    $0x18,%rsp
    a96a:	5b                   	pop    %rbx
    a96b:	41 5e                	pop    %r14
    a96d:	c3                   	ret
    a96e:	66 90                	xchg   %ax,%ax

000000000000a970 <fwp_gc_find_data>:
    a970:	0f b7 77 18          	movzwl 0x18(%rdi),%esi
    a974:	48 85 f6             	test   %rsi,%rsi
    a977:	0f 84 be 00 00 00    	je     aa3b <fwp_gc_find_data+0xcb>
    a97d:	53                   	push   %rbx
    a97e:	48 8b 07             	mov    (%rdi),%rax
    a981:	4c 8b 47 10          	mov    0x10(%rdi),%r8
    a985:	48 6b ce 38          	imul   $0x38,%rsi,%rcx
    a989:	45 31 c9             	xor    %r9d,%r9d
    a98c:	48 8d 15 15 48 00 00 	lea    0x4815(%rip),%rdx        # f1a8 <fwp_gc>
    a993:	41 bb 01 00 00 00    	mov    $0x1,%r11d
    a999:	45 31 d2             	xor    %r10d,%r10d
    a99c:	eb 0b                	jmp    a9a9 <fwp_gc_find_data+0x39>
    a99e:	66 90                	xchg   %ax,%ax
    a9a0:	49 83 c1 38          	add    $0x38,%r9
    a9a4:	4c 39 c9             	cmp    %r9,%rcx
    a9a7:	74 22                	je     a9cb <fwp_gc_find_data+0x5b>
    a9a9:	43 83 3c 08 01       	cmpl   $0x1,(%r8,%r9,1)
    a9ae:	75 f0                	jne    a9a0 <fwp_gc_find_data+0x30>
    a9b0:	4b 8b 5c 08 10       	mov    0x10(%r8,%r9,1),%rbx
    a9b5:	48 01 c3             	add    %rax,%rbx
    a9b8:	48 39 d3             	cmp    %rdx,%rbx
    a9bb:	77 e3                	ja     a9a0 <fwp_gc_find_data+0x30>
    a9bd:	4b 03 5c 08 28       	add    0x28(%r8,%r9,1),%rbx
    a9c2:	48 39 d3             	cmp    %rdx,%rbx
    a9c5:	45 0f 47 d3          	cmova  %r11d,%r10d
    a9c9:	eb d5                	jmp    a9a0 <fwp_gc_find_data+0x30>
    a9cb:	31 c0                	xor    %eax,%eax
    a9cd:	45 85 d2             	test   %r10d,%r10d
    a9d0:	0f 95 c0             	setne  %al
    a9d3:	74 6e                	je     aa43 <fwp_gc_find_data+0xd3>
    a9d5:	66 85 f6             	test   %si,%si
    a9d8:	74 69                	je     aa43 <fwp_gc_find_data+0xd3>
    a9da:	8b 05 58 59 00 00    	mov    0x5958(%rip),%eax        # 10338 <fwp_gc+0x1190>
    a9e0:	48 8b 77 10          	mov    0x10(%rdi),%rsi
    a9e4:	45 31 c0             	xor    %r8d,%r8d
    a9e7:	eb 10                	jmp    a9f9 <fwp_gc_find_data+0x89>
    a9e9:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)
    a9f0:	49 83 c0 38          	add    $0x38,%r8
    a9f4:	4c 39 c1             	cmp    %r8,%rcx
    a9f7:	74 45                	je     aa3e <fwp_gc_find_data+0xce>
    a9f9:	42 83 3c 06 01       	cmpl   $0x1,(%rsi,%r8,1)
    a9fe:	75 f0                	jne    a9f0 <fwp_gc_find_data+0x80>
    aa00:	42 f6 44 06 04 02    	testb  $0x2,0x4(%rsi,%r8,1)
    aa06:	74 e8                	je     a9f0 <fwp_gc_find_data+0x80>
    aa08:	83 f8 10             	cmp    $0x10,%eax
    aa0b:	74 31                	je     aa3e <fwp_gc_find_data+0xce>
    aa0d:	4e 8b 4c 06 10       	mov    0x10(%rsi,%r8,1),%r9
    aa12:	4c 03 0f             	add    (%rdi),%r9
    aa15:	4c 63 d0             	movslq %eax,%r10
    aa18:	49 c1 e2 04          	shl    $0x4,%r10
    aa1c:	4d 89 8c 12 90 10 00 	mov    %r9,0x1090(%r10,%rdx,1)
    aa23:	00 
    aa24:	4e 8b 4c 06 28       	mov    0x28(%rsi,%r8,1),%r9
    aa29:	4d 89 8c 12 98 10 00 	mov    %r9,0x1098(%r10,%rdx,1)
    aa30:	00 
    aa31:	ff c0                	inc    %eax
    aa33:	89 05 ff 58 00 00    	mov    %eax,0x58ff(%rip)        # 10338 <fwp_gc+0x1190>
    aa39:	eb b5                	jmp    a9f0 <fwp_gc_find_data+0x80>
    aa3b:	31 c0                	xor    %eax,%eax
    aa3d:	c3                   	ret
    aa3e:	b8 01 00 00 00       	mov    $0x1,%eax
    aa43:	5b                   	pop    %rbx
    aa44:	c3                   	ret
    aa45:	66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
    aa4c:	00 00 00 00 

000000000000aa50 <fwp_gc_report>:
    aa50:	55                   	push   %rbp
    aa51:	41 57                	push   %r15
    aa53:	41 56                	push   %r14
    aa55:	41 55                	push   %r13
    aa57:	41 54                	push   %r12
    aa59:	53                   	push   %rbx
    aa5a:	48 81 ec 58 01 00 00 	sub    $0x158,%rsp
    aa61:	48 8b 05 50 59 00 00 	mov    0x5950(%rip),%rax        # 103b8 <fwp_gc+0x1210>
    aa68:	48 8b 0d 39 47 00 00 	mov    0x4739(%rip),%rcx        # f1a8 <fwp_gc>
    aa6f:	48 29 c8             	sub    %rcx,%rax
    aa72:	f2 48 0f 2a c0       	cvtsi2sd %rax,%xmm0
    aa77:	f2 0f 58 05 11 59 00 	addsd  0x5911(%rip),%xmm0        # 10390 <fwp_gc+0x11e8>
    aa7e:	00 
    aa7f:	f2 0f 11 44 24 48    	movsd  %xmm0,0x48(%rsp)
    aa85:	f2 0f 11 05 03 59 00 	movsd  %xmm0,0x5903(%rip)        # 10390 <fwp_gc+0x11e8>
    aa8c:	00 
    aa8d:	48 89 0d 24 59 00 00 	mov    %rcx,0x5924(%rip)        # 103b8 <fwp_gc+0x1210>
    aa94:	48 8b 05 45 45 00 00 	mov    0x4545(%rip),%rax        # efe0 <stderr@GLIBC_2.2.5>
    aa9b:	48 8b 28             	mov    (%rax),%rbp
    aa9e:	48 8b 1d db 58 00 00 	mov    0x58db(%rip),%rbx        # 10380 <fwp_gc+0x11d8>
    aaa5:	4c 8b 3d 14 57 00 00 	mov    0x5714(%rip),%r15        # 101c0 <fwp_gc+0x1018>
    aaac:	f2 0f 10 05 fc 58 00 	movsd  0x58fc(%rip),%xmm0        # 103b0 <fwp_gc+0x1208>
    aab3:	00 
    aab4:	f2 0f 11 44 24 30    	movsd  %xmm0,0x30(%rsp)
    aaba:	48 8b 05 2f 57 00 00 	mov    0x572f(%rip),%rax        # 101f0 <fwp_gc+0x1048>
    aac1:	48 89 44 24 28       	mov    %rax,0x28(%rsp)
    aac6:	48 8b 05 a3 58 00 00 	mov    0x58a3(%rip),%rax        # 10370 <fwp_gc+0x11c8>
    aacd:	48 89 44 24 20       	mov    %rax,0x20(%rsp)
    aad2:	4c 8b 35 9f 58 00 00 	mov    0x589f(%rip),%r14        # 10378 <fwp_gc+0x11d0>
    aad9:	f2 0f 10 05 b7 58 00 	movsd  0x58b7(%rip),%xmm0        # 10398 <fwp_gc+0x11f0>
    aae0:	00 
    aae1:	f2 0f 11 44 24 40    	movsd  %xmm0,0x40(%rsp)
    aae7:	f2 0f 10 05 b1 58 00 	movsd  0x58b1(%rip),%xmm0        # 103a0 <fwp_gc+0x11f8>
    aaee:	00 
    aaef:	f2 0f 11 44 24 38    	movsd  %xmm0,0x38(%rsp)
    aaf5:	48 8d 3d 3d 1c 00 00 	lea    0x1c3d(%rip),%rdi        # c739 <fwp_segv.msg+0x4f9>
    aafc:	48 8d 35 bb 1a 00 00 	lea    0x1abb(%rip),%rsi        # c5be <fwp_segv.msg+0x37e>
    ab03:	e8 88 77 ff ff       	call   2290 <fopen@plt>
    ab08:	49 c7 c4 ff ff ff ff 	mov    $0xffffffffffffffff,%r12
    ab0f:	48 85 c0             	test   %rax,%rax
    ab12:	74 4b                	je     ab5f <fwp_gc_report+0x10f>
    ab14:	49 89 c5             	mov    %rax,%r13
    ab17:	48 89 6c 24 08       	mov    %rbp,0x8(%rsp)
    ab1c:	4c 89 7c 24 10       	mov    %r15,0x10(%rsp)
    ab21:	48 89 5c 24 18       	mov    %rbx,0x18(%rsp)
    ab26:	48 8d 7c 24 50       	lea    0x50(%rsp),%rdi
    ab2b:	be 00 01 00 00       	mov    $0x100,%esi
    ab30:	48 89 c2             	mov    %rax,%rdx
    ab33:	e8 58 76 ff ff       	call   2190 <fgets@plt>
    ab38:	49 c7 c4 ff ff ff ff 	mov    $0xffffffffffffffff,%r12
    ab3f:	48 85 c0             	test   %rax,%rax
    ab42:	0f 85 f1 00 00 00    	jne    ac39 <fwp_gc_report+0x1e9>
    ab48:	4c 89 ef             	mov    %r13,%rdi
    ab4b:	e8 b0 75 ff ff       	call   2100 <fclose@plt>
    ab50:	48 8b 5c 24 18       	mov    0x18(%rsp),%rbx
    ab55:	4c 8b 7c 24 10       	mov    0x10(%rsp),%r15
    ab5a:	48 8b 6c 24 08       	mov    0x8(%rsp),%rbp
    ab5f:	66 49 0f 6e c6       	movq   %r14,%xmm0
    ab64:	66 0f 6f 0d 74 15 00 	movdqa 0x1574(%rip),%xmm1        # c0e0 <_IO_stdin_used+0xe0>
    ab6b:	00 
    ab6c:	66 0f 62 c1          	punpckldq %xmm1,%xmm0
    ab70:	66 0f 28 15 78 15 00 	movapd 0x1578(%rip),%xmm2        # c0f0 <_IO_stdin_used+0xf0>
    ab77:	00 
    ab78:	66 0f 5c c2          	subpd  %xmm2,%xmm0
    ab7c:	66 0f 28 e0          	movapd %xmm0,%xmm4
    ab80:	66 0f 15 e0          	unpckhpd %xmm0,%xmm4
    ab84:	f2 0f 58 e0          	addsd  %xmm0,%xmm4
    ab88:	f2 0f 10 35 78 15 00 	movsd  0x1578(%rip),%xmm6        # c108 <_IO_stdin_used+0x108>
    ab8f:	00 
    ab90:	f2 0f 59 e6          	mulsd  %xmm6,%xmm4
    ab94:	f3 0f 7e 6c 24 20    	movq   0x20(%rsp),%xmm5
    ab9a:	66 0f 62 e9          	punpckldq %xmm1,%xmm5
    ab9e:	66 0f 5c ea          	subpd  %xmm2,%xmm5
    aba2:	66 0f 28 dd          	movapd %xmm5,%xmm3
    aba6:	66 0f 15 dd          	unpckhpd %xmm5,%xmm3
    abaa:	f2 0f 58 dd          	addsd  %xmm5,%xmm3
    abae:	f2 0f 59 de          	mulsd  %xmm6,%xmm3
    abb2:	f3 0f 7e 6c 24 28    	movq   0x28(%rsp),%xmm5
    abb8:	66 0f 62 e9          	punpckldq %xmm1,%xmm5
    abbc:	66 0f 5c ea          	subpd  %xmm2,%xmm5
    abc0:	66 0f 28 d5          	movapd %xmm5,%xmm2
    abc4:	66 0f 15 d5          	unpckhpd %xmm5,%xmm2
    abc8:	f2 0f 58 d5          	addsd  %xmm5,%xmm2
    abcc:	f2 0f 59 d6          	mulsd  %xmm6,%xmm2
    abd0:	f2 0f 10 44 24 48    	movsd  0x48(%rsp),%xmm0
    abd6:	f2 0f 10 4c 24 30    	movsd  0x30(%rsp),%xmm1
    abdc:	f2 0f 58 c1          	addsd  %xmm1,%xmm0
    abe0:	f2 0f 59 ce          	mulsd  %xmm6,%xmm1
    abe4:	f2 0f 59 c6          	mulsd  %xmm6,%xmm0
    abe8:	83 3d ad 55 00 00 00 	cmpl   $0x0,0x55ad(%rip)        # 1019c <fwp_gc+0xff4>
    abef:	48 8d 05 31 1b 00 00 	lea    0x1b31(%rip),%rax        # c727 <fwp_segv.msg+0x4e7>
    abf6:	4c 8d 0d 74 1a 00 00 	lea    0x1a74(%rip),%r9        # c671 <fwp_segv.msg+0x431>
    abfd:	4c 0f 44 c8          	cmove  %rax,%r9
    ac01:	48 8d 35 6a 1a 00 00 	lea    0x1a6a(%rip),%rsi        # c672 <fwp_segv.msg+0x432>
    ac08:	48 89 ef             	mov    %rbp,%rdi
    ac0b:	48 89 da             	mov    %rbx,%rdx
    ac0e:	4c 89 f9             	mov    %r15,%rcx
    ac11:	f2 0f 10 6c 24 40    	movsd  0x40(%rsp),%xmm5
    ac17:	f2 0f 10 74 24 38    	movsd  0x38(%rsp),%xmm6
    ac1d:	4d 89 e0             	mov    %r12,%r8
    ac20:	b0 07                	mov    $0x7,%al
    ac22:	e8 b9 75 ff ff       	call   21e0 <fprintf@plt>
    ac27:	48 81 c4 58 01 00 00 	add    $0x158,%rsp
    ac2e:	5b                   	pop    %rbx
    ac2f:	41 5c                	pop    %r12
    ac31:	41 5d                	pop    %r13
    ac33:	41 5e                	pop    %r14
    ac35:	41 5f                	pop    %r15
    ac37:	5d                   	pop    %rbp
    ac38:	c3                   	ret
    ac39:	48 8d 6c 24 56       	lea    0x56(%rsp),%rbp
    ac3e:	41 bf 56 6d 48 57    	mov    $0x57486d56,%r15d
    ac44:	48 8d 5c 24 50       	lea    0x50(%rsp),%rbx
    ac49:	eb 1e                	jmp    ac69 <fwp_gc_report+0x219>
    ac4b:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)
    ac50:	48 89 df             	mov    %rbx,%rdi
    ac53:	be 00 01 00 00       	mov    $0x100,%esi
    ac58:	4c 89 ea             	mov    %r13,%rdx
    ac5b:	e8 30 75 ff ff       	call   2190 <fgets@plt>
    ac60:	48 85 c0             	test   %rax,%rax
    ac63:	0f 84 df fe ff ff    	je     ab48 <fwp_gc_report+0xf8>
    ac69:	8b 44 24 50          	mov    0x50(%rsp),%eax
    ac6d:	44 31 f8             	xor    %r15d,%eax
    ac70:	0f b6 4c 24 54       	movzbl 0x54(%rsp),%ecx
    ac75:	83 f1 4d             	xor    $0x4d,%ecx
    ac78:	09 c1                	or     %eax,%ecx
    ac7a:	75 d4                	jne    ac50 <fwp_gc_report+0x200>
    ac7c:	80 7c 24 55 3a       	cmpb   $0x3a,0x55(%rsp)
    ac81:	75 cd                	jne    ac50 <fwp_gc_report+0x200>
    ac83:	48 89 ef             	mov    %rbp,%rdi
    ac86:	31 f6                	xor    %esi,%esi
    ac88:	ba 0a 00 00 00       	mov    $0xa,%edx
    ac8d:	e8 6e 75 ff ff       	call   2200 <strtol@plt>
    ac92:	49 89 c4             	mov    %rax,%r12
    ac95:	eb b9                	jmp    ac50 <fwp_gc_report+0x200>
    ac97:	66 0f 1f 84 00 00 00 	nopw   0x0(%rax,%rax,1)
    ac9e:	00 00 

000000000000aca0 <fwp_segv>:
    aca0:	48 8b 05 d9 5f 00 00 	mov    0x5fd9(%rip),%rax        # 10c80 <fwp_main_stack_top>
    aca7:	48 85 c0             	test   %rax,%rax
    acaa:	74 22                	je     acce <fwp_segv+0x2e>
    acac:	48 8b 4e 10          	mov    0x10(%rsi),%rcx
    acb0:	48 2b 05 d1 5f 00 00 	sub    0x5fd1(%rip),%rax        # 10c88 <fwp_main_stack_size>
    acb7:	48 8d 90 00 00 f0 ff 	lea    -0x100000(%rax),%rdx
    acbe:	48 39 ca             	cmp    %rcx,%rdx
    acc1:	77 0b                	ja     acce <fwp_segv+0x2e>
    acc3:	48 05 00 00 10 00    	add    $0x100000,%rax
    acc9:	48 39 c8             	cmp    %rcx,%rax
    accc:	77 07                	ja     acd5 <fwp_segv+0x35>
    acce:	31 f6                	xor    %esi,%esi
    acd0:	e9 fb 74 ff ff       	jmp    21d0 <signal@plt>
    acd5:	50                   	push   %rax
    acd6:	e8 d5 8a ff ff       	call   37b0 <fwp_flush>
    acdb:	48 8d 35 5e 15 00 00 	lea    0x155e(%rip),%rsi        # c240 <fwp_segv.msg>
    ace2:	ba 1a 00 00 00       	mov    $0x1a,%edx
    ace7:	bf 02 00 00 00       	mov    $0x2,%edi
    acec:	e8 ff 73 ff ff       	call   20f0 <write@plt>
    acf1:	bf 65 00 00 00       	mov    $0x65,%edi
    acf6:	e8 85 73 ff ff       	call   2080 <_exit@plt>
    acfb:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)

000000000000ad00 <fwp_owner_release0>:
    ad00:	53                   	push   %rbx
    ad01:	48 89 fb             	mov    %rdi,%rbx
    ad04:	48 8b 3f             	mov    (%rdi),%rdi
    ad07:	e8 e4 b2 ff ff       	call   5ff0 <fwp_closure_drop>
    ad0c:	48 8b 7b 08          	mov    0x8(%rbx),%rdi
    ad10:	5b                   	pop    %rbx
    ad11:	e9 da b2 ff ff       	jmp    5ff0 <fwp_closure_drop>
    ad16:	66 2e 0f 1f 84 00 00 	cs nopw 0x0(%rax,%rax,1)
    ad1d:	00 00 00 

000000000000ad20 <fwp_owner_release1>:
    ad20:	48 8b 3f             	mov    (%rdi),%rdi
    ad23:	eb 0b                	jmp    ad30 <fwp_drop2>
    ad25:	66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
    ad2c:	00 00 00 00 

000000000000ad30 <fwp_drop2>:
    ad30:	53                   	push   %rbx
    ad31:	48 8b 15 a0 54 00 00 	mov    0x54a0(%rip),%rdx        # 101d8 <fwp_gc+0x1030>
    ad38:	48 89 f8             	mov    %rdi,%rax
    ad3b:	48 29 d0             	sub    %rdx,%rax
    ad3e:	48 8b 35 bb 54 00 00 	mov    0x54bb(%rip),%rsi        # 10200 <fwp_gc+0x1058>
    ad45:	48 c1 e6 10          	shl    $0x10,%rsi
    ad49:	48 39 f0             	cmp    %rsi,%rax
    ad4c:	0f 83 c1 00 00 00    	jae    ae13 <fwp_drop2+0xe3>
    ad52:	48 8b 0d c7 54 00 00 	mov    0x54c7(%rip),%rcx        # 10220 <fwp_gc+0x1078>
    ad59:	49 89 c0             	mov    %rax,%r8
    ad5c:	49 c1 e8 10          	shr    $0x10,%r8
    ad60:	4d 69 c0 28 12 00 00 	imul   $0x1228,%r8,%r8
    ad67:	46 0f b6 0c 01       	movzbl (%rcx,%r8,1),%r9d
    ad6c:	48 25 ff ff 00 00    	and    $0xffff,%rax
    ad72:	75 12                	jne    ad86 <fwp_drop2+0x56>
    ad74:	41 80 f9 02          	cmp    $0x2,%r9b
    ad78:	75 0c                	jne    ad86 <fwp_drop2+0x56>
    ad7a:	4a 8d 04 01          	lea    (%rcx,%r8,1),%rax
    ad7e:	48 05 28 02 00 00    	add    $0x228,%rax
    ad84:	eb 24                	jmp    adaa <fwp_drop2+0x7a>
    ad86:	41 80 f9 01          	cmp    $0x1,%r9b
    ad8a:	0f 85 83 00 00 00    	jne    ae13 <fwp_drop2+0xe3>
    ad90:	4e 8d 0c 01          	lea    (%rcx,%r8,1),%r9
    ad94:	46 8b 44 01 20       	mov    0x20(%rcx,%r8,1),%r8d
    ad99:	49 0f af c0          	imul   %r8,%rax
    ad9d:	48 c1 e8 20          	shr    $0x20,%rax
    ada1:	4c 01 c8             	add    %r9,%rax
    ada4:	48 05 28 02 00 00    	add    $0x228,%rax
    adaa:	44 0f b6 00          	movzbl (%rax),%r8d
    adae:	45 85 c0             	test   %r8d,%r8d
    adb1:	74 60                	je     ae13 <fwp_drop2+0xe3>
    adb3:	41 83 f8 01          	cmp    $0x1,%r8d
    adb7:	75 4b                	jne    ae04 <fwp_drop2+0xd4>
    adb9:	8b 07                	mov    (%rdi),%eax
    adbb:	83 f8 01             	cmp    $0x1,%eax
    adbe:	74 55                	je     ae15 <fwp_drop2+0xe5>
    adc0:	85 c0                	test   %eax,%eax
    adc2:	75 4f                	jne    ae13 <fwp_drop2+0xe3>
    adc4:	48 8b 47 08          	mov    0x8(%rdi),%rax
    adc8:	49 89 c0             	mov    %rax,%r8
    adcb:	49 29 d0             	sub    %rdx,%r8
    adce:	49 39 f0             	cmp    %rsi,%r8
    add1:	0f 83 91 00 00 00    	jae    ae68 <fwp_drop2+0x138>
    add7:	4c 89 c2             	mov    %r8,%rdx
    adda:	48 c1 ea 10          	shr    $0x10,%rdx
    adde:	48 69 d2 28 12 00 00 	imul   $0x1228,%rdx,%rdx
    ade5:	0f b6 34 11          	movzbl (%rcx,%rdx,1),%esi
    ade9:	49 81 e0 ff ff 00 00 	and    $0xffff,%r8
    adf0:	75 3b                	jne    ae2d <fwp_drop2+0xfd>
    adf2:	40 80 fe 02          	cmp    $0x2,%sil
    adf6:	75 35                	jne    ae2d <fwp_drop2+0xfd>
    adf8:	48 01 d1             	add    %rdx,%rcx
    adfb:	48 81 c1 28 02 00 00 	add    $0x228,%rcx
    ae02:	eb 4a                	jmp    ae4e <fwp_drop2+0x11e>
    ae04:	41 81 f8 ff 00 00 00 	cmp    $0xff,%r8d
    ae0b:	74 73                	je     ae80 <fwp_drop2+0x150>
    ae0d:	41 fe c8             	dec    %r8b
    ae10:	44 88 00             	mov    %r8b,(%rax)
    ae13:	5b                   	pop    %rbx
    ae14:	c3                   	ret
    ae15:	48 8b 47 08          	mov    0x8(%rdi),%rax
    ae19:	48 89 fb             	mov    %rdi,%rbx
    ae1c:	48 89 c7             	mov    %rax,%rdi
    ae1f:	e8 cc 8c ff ff       	call   3af0 <fwp_drop4>
    ae24:	48 89 df             	mov    %rbx,%rdi
    ae27:	5b                   	pop    %rbx
    ae28:	e9 e3 b6 ff ff       	jmp    6510 <fwp_rc_free_obj>
    ae2d:	40 80 fe 01          	cmp    $0x1,%sil
    ae31:	75 35                	jne    ae68 <fwp_drop2+0x138>
    ae33:	48 8d 34 11          	lea    (%rcx,%rdx,1),%rsi
    ae37:	8b 4c 11 20          	mov    0x20(%rcx,%rdx,1),%ecx
    ae3b:	4c 0f af c1          	imul   %rcx,%r8
    ae3f:	49 c1 e8 20          	shr    $0x20,%r8
    ae43:	49 8d 0c 30          	lea    (%r8,%rsi,1),%rcx
    ae47:	48 81 c1 28 02 00 00 	add    $0x228,%rcx
    ae4e:	0f b6 11             	movzbl (%rcx),%edx
    ae51:	85 d2                	test   %edx,%edx
    ae53:	74 13                	je     ae68 <fwp_drop2+0x138>
    ae55:	83 fa 01             	cmp    $0x1,%edx
    ae58:	75 14                	jne    ae6e <fwp_drop2+0x13e>
    ae5a:	48 89 fb             	mov    %rdi,%rbx
    ae5d:	48 89 c7             	mov    %rax,%rdi
    ae60:	e8 ab b6 ff ff       	call   6510 <fwp_rc_free_obj>
    ae65:	48 89 df             	mov    %rbx,%rdi
    ae68:	5b                   	pop    %rbx
    ae69:	e9 a2 b6 ff ff       	jmp    6510 <fwp_rc_free_obj>
    ae6e:	81 fa ff 00 00 00    	cmp    $0xff,%edx
    ae74:	74 13                	je     ae89 <fwp_drop2+0x159>
    ae76:	fe ca                	dec    %dl
    ae78:	88 11                	mov    %dl,(%rcx)
    ae7a:	5b                   	pop    %rbx
    ae7b:	e9 90 b6 ff ff       	jmp    6510 <fwp_rc_free_obj>
    ae80:	48 89 c7             	mov    %rax,%rdi
    ae83:	5b                   	pop    %rbx
    ae84:	e9 77 b4 ff ff       	jmp    6300 <fwp_rc_wide_drop>
    ae89:	48 89 fb             	mov    %rdi,%rbx
    ae8c:	48 89 cf             	mov    %rcx,%rdi
    ae8f:	e8 6c b4 ff ff       	call   6300 <fwp_rc_wide_drop>
    ae94:	eb cf                	jmp    ae65 <fwp_drop2+0x135>
    ae96:	66 2e 0f 1f 84 00 00 	cs nopw 0x0(%rax,%rax,1)
    ae9d:	00 00 00 

000000000000aea0 <fwp_owner_release2>:
    aea0:	48 8b 3f             	mov    (%rdi),%rdi
    aea3:	48 89 f8             	mov    %rdi,%rax
    aea6:	48 2b 05 2b 53 00 00 	sub    0x532b(%rip),%rax        # 101d8 <fwp_gc+0x1030>
    aead:	48 8b 0d 4c 53 00 00 	mov    0x534c(%rip),%rcx        # 10200 <fwp_gc+0x1058>
    aeb4:	48 c1 e1 10          	shl    $0x10,%rcx
    aeb8:	48 39 c8             	cmp    %rcx,%rax
    aebb:	73 6e                	jae    af2b <fwp_owner_release2+0x8b>
    aebd:	48 8b 0d 5c 53 00 00 	mov    0x535c(%rip),%rcx        # 10220 <fwp_gc+0x1078>
    aec4:	48 89 c2             	mov    %rax,%rdx
    aec7:	48 c1 ea 10          	shr    $0x10,%rdx
    aecb:	48 69 d2 28 12 00 00 	imul   $0x1228,%rdx,%rdx
    aed2:	0f b6 34 11          	movzbl (%rcx,%rdx,1),%esi
    aed6:	48 25 ff ff 00 00    	and    $0xffff,%rax
    aedc:	75 12                	jne    aef0 <fwp_owner_release2+0x50>
    aede:	40 80 fe 02          	cmp    $0x2,%sil
    aee2:	75 0c                	jne    aef0 <fwp_owner_release2+0x50>
    aee4:	48 8d 04 11          	lea    (%rcx,%rdx,1),%rax
    aee8:	48 05 28 02 00 00    	add    $0x228,%rax
    aeee:	eb 1f                	jmp    af0f <fwp_owner_release2+0x6f>
    aef0:	40 80 fe 01          	cmp    $0x1,%sil
    aef4:	75 35                	jne    af2b <fwp_owner_release2+0x8b>
    aef6:	48 8d 34 11          	lea    (%rcx,%rdx,1),%rsi
    aefa:	8b 4c 11 20          	mov    0x20(%rcx,%rdx,1),%ecx
    aefe:	48 0f af c1          	imul   %rcx,%rax
    af02:	48 c1 e8 20          	shr    $0x20,%rax
    af06:	48 01 f0             	add    %rsi,%rax
    af09:	48 05 28 02 00 00    	add    $0x228,%rax
    af0f:	0f b6 08             	movzbl (%rax),%ecx
    af12:	85 c9                	test   %ecx,%ecx
    af14:	74 15                	je     af2b <fwp_owner_release2+0x8b>
    af16:	83 f9 01             	cmp    $0x1,%ecx
    af19:	0f 84 f1 b5 ff ff    	je     6510 <fwp_rc_free_obj>
    af1f:	81 f9 ff 00 00 00    	cmp    $0xff,%ecx
    af25:	74 05                	je     af2c <fwp_owner_release2+0x8c>
    af27:	fe c9                	dec    %cl
    af29:	88 08                	mov    %cl,(%rax)
    af2b:	c3                   	ret
    af2c:	48 89 c7             	mov    %rax,%rdi
    af2f:	e9 cc b3 ff ff       	jmp    6300 <fwp_rc_wide_drop>
    af34:	66 66 66 2e 0f 1f 84 	data16 data16 cs nopw 0x0(%rax,%rax,1)
    af3b:	00 00 00 00 00 

000000000000af40 <fwp_owner_release3>:
    af40:	53                   	push   %rbx
    af41:	48 89 fb             	mov    %rdi,%rbx
    af44:	48 8b 3f             	mov    (%rdi),%rdi
    af47:	e8 a4 b0 ff ff       	call   5ff0 <fwp_closure_drop>
    af4c:	48 8b 7b 08          	mov    0x8(%rbx),%rdi
    af50:	5b                   	pop    %rbx
    af51:	e9 9a b0 ff ff       	jmp    5ff0 <fwp_closure_drop>
    af56:	66 2e 0f 1f 84 00 00 	cs nopw 0x0(%rax,%rax,1)
    af5d:	00 00 00 

000000000000af60 <fwp_owner_release4>:
    af60:	48 8b 3f             	mov    (%rdi),%rdi
    af63:	e9 c8 fd ff ff       	jmp    ad30 <fwp_drop2>
    af68:	0f 1f 84 00 00 00 00 	nopl   0x0(%rax,%rax,1)
    af6f:	00 

000000000000af70 <fwp_owner_release5>:
    af70:	48 8b 3f             	mov    (%rdi),%rdi
    af73:	48 89 f8             	mov    %rdi,%rax
    af76:	48 2b 05 5b 52 00 00 	sub    0x525b(%rip),%rax        # 101d8 <fwp_gc+0x1030>
    af7d:	48 8b 0d 7c 52 00 00 	mov    0x527c(%rip),%rcx        # 10200 <fwp_gc+0x1058>
    af84:	48 c1 e1 10          	shl    $0x10,%rcx
    af88:	48 39 c8             	cmp    %rcx,%rax
    af8b:	73 6e                	jae    affb <fwp_owner_release5+0x8b>
    af8d:	48 8b 0d 8c 52 00 00 	mov    0x528c(%rip),%rcx        # 10220 <fwp_gc+0x1078>
    af94:	48 89 c2             	mov    %rax,%rdx
    af97:	48 c1 ea 10          	shr    $0x10,%rdx
    af9b:	48 69 d2 28 12 00 00 	imul   $0x1228,%rdx,%rdx
    afa2:	0f b6 34 11          	movzbl (%rcx,%rdx,1),%esi
    afa6:	48 25 ff ff 00 00    	and    $0xffff,%rax
    afac:	75 12                	jne    afc0 <fwp_owner_release5+0x50>
    afae:	40 80 fe 02          	cmp    $0x2,%sil
    afb2:	75 0c                	jne    afc0 <fwp_owner_release5+0x50>
    afb4:	48 8d 04 11          	lea    (%rcx,%rdx,1),%rax
    afb8:	48 05 28 02 00 00    	add    $0x228,%rax
    afbe:	eb 1f                	jmp    afdf <fwp_owner_release5+0x6f>
    afc0:	40 80 fe 01          	cmp    $0x1,%sil
    afc4:	75 35                	jne    affb <fwp_owner_release5+0x8b>
    afc6:	48 8d 34 11          	lea    (%rcx,%rdx,1),%rsi
    afca:	8b 4c 11 20          	mov    0x20(%rcx,%rdx,1),%ecx
    afce:	48 0f af c1          	imul   %rcx,%rax
    afd2:	48 c1 e8 20          	shr    $0x20,%rax
    afd6:	48 01 f0             	add    %rsi,%rax
    afd9:	48 05 28 02 00 00    	add    $0x228,%rax
    afdf:	0f b6 08             	movzbl (%rax),%ecx
    afe2:	85 c9                	test   %ecx,%ecx
    afe4:	74 15                	je     affb <fwp_owner_release5+0x8b>
    afe6:	83 f9 01             	cmp    $0x1,%ecx
    afe9:	0f 84 21 b5 ff ff    	je     6510 <fwp_rc_free_obj>
    afef:	81 f9 ff 00 00 00    	cmp    $0xff,%ecx
    aff5:	74 05                	je     affc <fwp_owner_release5+0x8c>
    aff7:	fe c9                	dec    %cl
    aff9:	88 08                	mov    %cl,(%rax)
    affb:	c3                   	ret
    affc:	48 89 c7             	mov    %rax,%rdi
    afff:	e9 fc b2 ff ff       	jmp    6300 <fwp_rc_wide_drop>
    b004:	66 66 66 2e 0f 1f 84 	data16 data16 cs nopw 0x0(%rax,%rax,1)
    b00b:	00 00 00 00 00 

000000000000b010 <fwp_owner_release6>:
    b010:	48 8b 07             	mov    (%rdi),%rax
    b013:	48 2b 05 be 51 00 00 	sub    0x51be(%rip),%rax        # 101d8 <fwp_gc+0x1030>
    b01a:	48 8b 0d df 51 00 00 	mov    0x51df(%rip),%rcx        # 10200 <fwp_gc+0x1058>
    b021:	48 c1 e1 10          	shl    $0x10,%rcx
    b025:	48 39 c8             	cmp    %rcx,%rax
    b028:	73 68                	jae    b092 <fwp_owner_release6+0x82>
    b02a:	48 8b 0d ef 51 00 00 	mov    0x51ef(%rip),%rcx        # 10220 <fwp_gc+0x1078>
    b031:	48 89 c2             	mov    %rax,%rdx
    b034:	48 c1 ea 10          	shr    $0x10,%rdx
    b038:	48 69 d2 28 12 00 00 	imul   $0x1228,%rdx,%rdx
    b03f:	0f b6 34 11          	movzbl (%rcx,%rdx,1),%esi
    b043:	48 25 ff ff 00 00    	and    $0xffff,%rax
    b049:	75 13                	jne    b05e <fwp_owner_release6+0x4e>
    b04b:	40 80 fe 02          	cmp    $0x2,%sil
    b04f:	75 0d                	jne    b05e <fwp_owner_release6+0x4e>
    b051:	48 8d 3c 11          	lea    (%rcx,%rdx,1),%rdi
    b055:	48 81 c7 28 02 00 00 	add    $0x228,%rdi
    b05c:	eb 21                	jmp    b07f <fwp_owner_release6+0x6f>
    b05e:	40 80 fe 01          	cmp    $0x1,%sil
    b062:	75 2e                	jne    b092 <fwp_owner_release6+0x82>
    b064:	48 8d 34 11          	lea    (%rcx,%rdx,1),%rsi
    b068:	8b 4c 11 20          	mov    0x20(%rcx,%rdx,1),%ecx
    b06c:	48 0f af c1          	imul   %rcx,%rax
    b070:	48 c1 e8 20          	shr    $0x20,%rax
    b074:	48 8d 3c 30          	lea    (%rax,%rsi,1),%rdi
    b078:	48 81 c7 28 02 00 00 	add    $0x228,%rdi
    b07f:	0f b6 07             	movzbl (%rdi),%eax
    b082:	3c 02                	cmp    $0x2,%al
    b084:	72 0c                	jb     b092 <fwp_owner_release6+0x82>
    b086:	3c ff                	cmp    $0xff,%al
    b088:	0f 84 72 b2 ff ff    	je     6300 <fwp_rc_wide_drop>
    b08e:	fe c8                	dec    %al
    b090:	88 07                	mov    %al,(%rdi)
    b092:	c3                   	ret
    b093:	66 2e 0f 1f 84 00 00 	cs nopw 0x0(%rax,%rax,1)
    b09a:	00 00 00 
    b09d:	0f 1f 00             	nopl   (%rax)

000000000000b0a0 <__divti3>:
    b0a0:	f3 0f 1e fa          	endbr64
    b0a4:	55                   	push   %rbp
    b0a5:	49 89 f8             	mov    %rdi,%r8
    b0a8:	49 89 d2             	mov    %rdx,%r10
    b0ab:	49 89 cb             	mov    %rcx,%r11
    b0ae:	31 ff                	xor    %edi,%edi
    b0b0:	48 89 e5             	mov    %rsp,%rbp
    b0b3:	41 56                	push   %r14
    b0b5:	53                   	push   %rbx
    b0b6:	48 85 f6             	test   %rsi,%rsi
    b0b9:	79 13                	jns    b0ce <__divti3+0x2e>
    b0bb:	45 31 c9             	xor    %r9d,%r9d
    b0be:	49 f7 d8             	neg    %r8
    b0c1:	48 c7 c7 ff ff ff ff 	mov    $0xffffffffffffffff,%rdi
    b0c8:	49 19 f1             	sbb    %rsi,%r9
    b0cb:	4c 89 ce             	mov    %r9,%rsi
    b0ce:	4c 89 da             	mov    %r11,%rdx
    b0d1:	4d 85 db             	test   %r11,%r11
    b0d4:	0f 88 f6 00 00 00    	js     b1d0 <__divti3+0x130>
    b0da:	4d 89 d6             	mov    %r10,%r14
    b0dd:	75 31                	jne    b110 <__divti3+0x70>
    b0df:	4c 39 f6             	cmp    %r14,%rsi
    b0e2:	0f 83 b8 00 00 00    	jae    b1a0 <__divti3+0x100>
    b0e8:	48 89 f2             	mov    %rsi,%rdx
    b0eb:	31 f6                	xor    %esi,%esi
    b0ed:	4c 89 c0             	mov    %r8,%rax
    b0f0:	49 f7 f6             	div    %r14
    b0f3:	48 89 f2             	mov    %rsi,%rdx
    b0f6:	48 85 ff             	test   %rdi,%rdi
    b0f9:	74 0a                	je     b105 <__divti3+0x65>
    b0fb:	48 f7 d8             	neg    %rax
    b0fe:	48 83 d2 00          	adc    $0x0,%rdx
    b102:	48 f7 da             	neg    %rdx
    b105:	5b                   	pop    %rbx
    b106:	41 5e                	pop    %r14
    b108:	5d                   	pop    %rbp
    b109:	c3                   	ret
    b10a:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)
    b110:	4c 39 de             	cmp    %r11,%rsi
    b113:	0f 82 d5 00 00 00    	jb     b1ee <__divti3+0x14e>
    b119:	4d 0f bd d3          	bsr    %r11,%r10
    b11d:	41 83 f2 3f          	xor    $0x3f,%r10d
    b121:	44 89 d1             	mov    %r10d,%ecx
    b124:	b8 40 00 00 00       	mov    $0x40,%eax
    b129:	4c 89 f3             	mov    %r14,%rbx
    b12c:	4d 89 f1             	mov    %r14,%r9
    b12f:	48 d3 e2             	shl    %cl,%rdx
    b132:	49 63 ca             	movslq %r10d,%rcx
    b135:	49 89 f3             	mov    %rsi,%r11
    b138:	48 29 c8             	sub    %rcx,%rax
    b13b:	89 c1                	mov    %eax,%ecx
    b13d:	48 d3 eb             	shr    %cl,%rbx
    b140:	44 89 d1             	mov    %r10d,%ecx
    b143:	49 d3 e1             	shl    %cl,%r9
    b146:	89 c1                	mov    %eax,%ecx
    b148:	48 09 d3             	or     %rdx,%rbx
    b14b:	4c 89 c2             	mov    %r8,%rdx
    b14e:	49 d3 eb             	shr    %cl,%r11
    b151:	44 89 d1             	mov    %r10d,%ecx
    b154:	48 d3 e6             	shl    %cl,%rsi
    b157:	89 c1                	mov    %eax,%ecx
    b159:	48 d3 ea             	shr    %cl,%rdx
    b15c:	48 89 d0             	mov    %rdx,%rax
    b15f:	4c 89 da             	mov    %r11,%rdx
    b162:	48 09 f0             	or     %rsi,%rax
    b165:	48 f7 f3             	div    %rbx
    b168:	49 89 d3             	mov    %rdx,%r11
    b16b:	48 89 c6             	mov    %rax,%rsi
    b16e:	49 f7 e1             	mul    %r9
    b171:	49 39 d3             	cmp    %rdx,%r11
    b174:	0f 82 be 00 00 00    	jb     b238 <__divti3+0x198>
    b17a:	44 89 d1             	mov    %r10d,%ecx
    b17d:	49 d3 e0             	shl    %cl,%r8
    b180:	49 39 c0             	cmp    %rax,%r8
    b183:	73 09                	jae    b18e <__divti3+0xee>
    b185:	49 39 d3             	cmp    %rdx,%r11
    b188:	0f 84 aa 00 00 00    	je     b238 <__divti3+0x198>
    b18e:	48 89 f0             	mov    %rsi,%rax
    b191:	31 f6                	xor    %esi,%esi
    b193:	e9 5b ff ff ff       	jmp    b0f3 <__divti3+0x53>
    b198:	0f 1f 84 00 00 00 00 	nopl   0x0(%rax,%rax,1)
    b19f:	00 
    b1a0:	4d 85 f6             	test   %r14,%r14
    b1a3:	75 0d                	jne    b1b2 <__divti3+0x112>
    b1a5:	b8 01 00 00 00       	mov    $0x1,%eax
    b1aa:	31 d2                	xor    %edx,%edx
    b1ac:	49 f7 f6             	div    %r14
    b1af:	49 89 c6             	mov    %rax,%r14
    b1b2:	48 89 f0             	mov    %rsi,%rax
    b1b5:	31 d2                	xor    %edx,%edx
    b1b7:	49 f7 f6             	div    %r14
    b1ba:	48 89 c6             	mov    %rax,%rsi
    b1bd:	4c 89 c0             	mov    %r8,%rax
    b1c0:	49 f7 f6             	div    %r14
    b1c3:	e9 2b ff ff ff       	jmp    b0f3 <__divti3+0x53>
    b1c8:	0f 1f 84 00 00 00 00 	nopl   0x0(%rax,%rax,1)
    b1cf:	00 
    b1d0:	49 f7 da             	neg    %r10
    b1d3:	48 f7 d7             	not    %rdi
    b1d6:	49 83 d3 00          	adc    $0x0,%r11
    b1da:	4d 89 d6             	mov    %r10,%r14
    b1dd:	49 f7 db             	neg    %r11
    b1e0:	4c 89 da             	mov    %r11,%rdx
    b1e3:	0f 84 f6 fe ff ff    	je     b0df <__divti3+0x3f>
    b1e9:	4c 39 de             	cmp    %r11,%rsi
    b1ec:	73 12                	jae    b200 <__divti3+0x160>
    b1ee:	31 f6                	xor    %esi,%esi
    b1f0:	31 c0                	xor    %eax,%eax
    b1f2:	e9 fc fe ff ff       	jmp    b0f3 <__divti3+0x53>
    b1f7:	66 0f 1f 84 00 00 00 	nopw   0x0(%rax,%rax,1)
    b1fe:	00 00 
    b200:	49 0f bd c3          	bsr    %r11,%rax
    b204:	48 83 f0 3f          	xor    $0x3f,%rax
    b208:	41 89 c2             	mov    %eax,%r10d
    b20b:	85 c0                	test   %eax,%eax
    b20d:	0f 85 0e ff ff ff    	jne    b121 <__divti3+0x81>
    b213:	49 39 f3             	cmp    %rsi,%r11
    b216:	72 0d                	jb     b225 <__divti3+0x185>
    b218:	31 f6                	xor    %esi,%esi
    b21a:	31 c0                	xor    %eax,%eax
    b21c:	4d 39 f0             	cmp    %r14,%r8
    b21f:	0f 82 ce fe ff ff    	jb     b0f3 <__divti3+0x53>
    b225:	31 f6                	xor    %esi,%esi
    b227:	b8 01 00 00 00       	mov    $0x1,%eax
    b22c:	e9 c2 fe ff ff       	jmp    b0f3 <__divti3+0x53>
    b231:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)
    b238:	48 8d 46 ff          	lea    -0x1(%rsi),%rax
    b23c:	31 f6                	xor    %esi,%esi
    b23e:	e9 b0 fe ff ff       	jmp    b0f3 <__divti3+0x53>
    b243:	66 2e 0f 1f 84 00 00 	cs nopw 0x0(%rax,%rax,1)
    b24a:	00 00 00 
    b24d:	0f 1f 00             	nopl   (%rax)

000000000000b250 <atexit>:
    b250:	f3 0f 1e fa          	endbr64
    b254:	48 8b 15 3d 3f 00 00 	mov    0x3f3d(%rip),%rdx        # f198 <__dso_handle>
    b25b:	31 f6                	xor    %esi,%esi
    b25d:	e9 4e 70 ff ff       	jmp    22b0 <__cxa_atexit@plt>

Disassembly of section .fini:

000000000000b264 <_fini>:
    b264:	f3 0f 1e fa          	endbr64
    b268:	48 83 ec 08          	sub    $0x8,%rsp
    b26c:	48 83 c4 08          	add    $0x8,%rsp
    b270:	c3                   	ret
