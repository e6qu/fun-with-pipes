
/tmp/fwp-arc-3169/closures-1-O2:     file format elf64-x86-64


Disassembly of section .init:

0000000000002000 <_init>:
    2000:	f3 0f 1e fa          	endbr64
    2004:	48 83 ec 08          	sub    $0x8,%rsp
    2008:	48 8b 05 b9 9f 00 00 	mov    0x9fb9(%rip),%rax        # bfc8 <__gmon_start__@Base>
    200f:	48 85 c0             	test   %rax,%rax
    2012:	74 02                	je     2016 <_init+0x16>
    2014:	ff d0                	call   *%rax
    2016:	48 83 c4 08          	add    $0x8,%rsp
    201a:	c3                   	ret

Disassembly of section .plt:

0000000000002020 <getenv@plt-0x10>:
    2020:	ff 35 ca 9f 00 00    	push   0x9fca(%rip)        # bff0 <_GLOBAL_OFFSET_TABLE_+0x8>
    2026:	ff 25 cc 9f 00 00    	jmp    *0x9fcc(%rip)        # bff8 <_GLOBAL_OFFSET_TABLE_+0x10>
    202c:	0f 1f 40 00          	nopl   0x0(%rax)

0000000000002030 <getenv@plt>:
    2030:	ff 25 ca 9f 00 00    	jmp    *0x9fca(%rip)        # c000 <getenv@GLIBC_2.2.5>
    2036:	68 00 00 00 00       	push   $0x0
    203b:	e9 e0 ff ff ff       	jmp    2020 <_init+0x20>

0000000000002040 <dl_iterate_phdr@plt>:
    2040:	ff 25 c2 9f 00 00    	jmp    *0x9fc2(%rip)        # c008 <dl_iterate_phdr@GLIBC_2.2.5>
    2046:	68 01 00 00 00       	push   $0x1
    204b:	e9 d0 ff ff ff       	jmp    2020 <_init+0x20>

0000000000002050 <free@plt>:
    2050:	ff 25 ba 9f 00 00    	jmp    *0x9fba(%rip)        # c010 <free@GLIBC_2.2.5>
    2056:	68 02 00 00 00       	push   $0x2
    205b:	e9 c0 ff ff ff       	jmp    2020 <_init+0x20>

0000000000002060 <abort@plt>:
    2060:	ff 25 b2 9f 00 00    	jmp    *0x9fb2(%rip)        # c018 <abort@GLIBC_2.2.5>
    2066:	68 03 00 00 00       	push   $0x3
    206b:	e9 b0 ff ff ff       	jmp    2020 <_init+0x20>

0000000000002070 <_exit@plt>:
    2070:	ff 25 aa 9f 00 00    	jmp    *0x9faa(%rip)        # c020 <_exit@GLIBC_2.2.5>
    2076:	68 04 00 00 00       	push   $0x4
    207b:	e9 a0 ff ff ff       	jmp    2020 <_init+0x20>

0000000000002080 <sigaction@plt>:
    2080:	ff 25 a2 9f 00 00    	jmp    *0x9fa2(%rip)        # c028 <sigaction@GLIBC_2.2.5>
    2086:	68 05 00 00 00       	push   $0x5
    208b:	e9 90 ff ff ff       	jmp    2020 <_init+0x20>

0000000000002090 <clock_gettime@plt>:
    2090:	ff 25 9a 9f 00 00    	jmp    *0x9f9a(%rip)        # c030 <clock_gettime@GLIBC_2.17>
    2096:	68 06 00 00 00       	push   $0x6
    209b:	e9 80 ff ff ff       	jmp    2020 <_init+0x20>

00000000000020a0 <write@plt>:
    20a0:	ff 25 92 9f 00 00    	jmp    *0x9f92(%rip)        # c038 <write@GLIBC_2.2.5>
    20a6:	68 07 00 00 00       	push   $0x7
    20ab:	e9 70 ff ff ff       	jmp    2020 <_init+0x20>

00000000000020b0 <fclose@plt>:
    20b0:	ff 25 8a 9f 00 00    	jmp    *0x9f8a(%rip)        # c040 <fclose@GLIBC_2.2.5>
    20b6:	68 08 00 00 00       	push   $0x8
    20bb:	e9 60 ff ff ff       	jmp    2020 <_init+0x20>

00000000000020c0 <mmap@plt>:
    20c0:	ff 25 82 9f 00 00    	jmp    *0x9f82(%rip)        # c048 <mmap@GLIBC_2.2.5>
    20c6:	68 09 00 00 00       	push   $0x9
    20cb:	e9 50 ff ff ff       	jmp    2020 <_init+0x20>

00000000000020d0 <snprintf@plt>:
    20d0:	ff 25 7a 9f 00 00    	jmp    *0x9f7a(%rip)        # c050 <snprintf@GLIBC_2.2.5>
    20d6:	68 0a 00 00 00       	push   $0xa
    20db:	e9 40 ff ff ff       	jmp    2020 <_init+0x20>

00000000000020e0 <memset@plt>:
    20e0:	ff 25 72 9f 00 00    	jmp    *0x9f72(%rip)        # c058 <memset@GLIBC_2.2.5>
    20e6:	68 0b 00 00 00       	push   $0xb
    20eb:	e9 30 ff ff ff       	jmp    2020 <_init+0x20>

00000000000020f0 <fputc@plt>:
    20f0:	ff 25 6a 9f 00 00    	jmp    *0x9f6a(%rip)        # c060 <fputc@GLIBC_2.2.5>
    20f6:	68 0c 00 00 00       	push   $0xc
    20fb:	e9 20 ff ff ff       	jmp    2020 <_init+0x20>

0000000000002100 <pthread_attr_init@plt>:
    2100:	ff 25 62 9f 00 00    	jmp    *0x9f62(%rip)        # c068 <pthread_attr_init@GLIBC_2.2.5>
    2106:	68 0d 00 00 00       	push   $0xd
    210b:	e9 10 ff ff ff       	jmp    2020 <_init+0x20>

0000000000002110 <fgets@plt>:
    2110:	ff 25 5a 9f 00 00    	jmp    *0x9f5a(%rip)        # c070 <fgets@GLIBC_2.2.5>
    2116:	68 0e 00 00 00       	push   $0xe
    211b:	e9 00 ff ff ff       	jmp    2020 <_init+0x20>

0000000000002120 <strtoull@plt>:
    2120:	ff 25 52 9f 00 00    	jmp    *0x9f52(%rip)        # c078 <strtoull@GLIBC_2.2.5>
    2126:	68 0f 00 00 00       	push   $0xf
    212b:	e9 f0 fe ff ff       	jmp    2020 <_init+0x20>

0000000000002130 <strcmp@plt>:
    2130:	ff 25 4a 9f 00 00    	jmp    *0x9f4a(%rip)        # c080 <strcmp@GLIBC_2.2.5>
    2136:	68 10 00 00 00       	push   $0x10
    213b:	e9 e0 fe ff ff       	jmp    2020 <_init+0x20>

0000000000002140 <signal@plt>:
    2140:	ff 25 42 9f 00 00    	jmp    *0x9f42(%rip)        # c088 <signal@GLIBC_2.2.5>
    2146:	68 11 00 00 00       	push   $0x11
    214b:	e9 d0 fe ff ff       	jmp    2020 <_init+0x20>

0000000000002150 <fprintf@plt>:
    2150:	ff 25 3a 9f 00 00    	jmp    *0x9f3a(%rip)        # c090 <fprintf@GLIBC_2.2.5>
    2156:	68 12 00 00 00       	push   $0x12
    215b:	e9 c0 fe ff ff       	jmp    2020 <_init+0x20>

0000000000002160 <sigemptyset@plt>:
    2160:	ff 25 32 9f 00 00    	jmp    *0x9f32(%rip)        # c098 <sigemptyset@GLIBC_2.2.5>
    2166:	68 13 00 00 00       	push   $0x13
    216b:	e9 b0 fe ff ff       	jmp    2020 <_init+0x20>

0000000000002170 <strtol@plt>:
    2170:	ff 25 2a 9f 00 00    	jmp    *0x9f2a(%rip)        # c0a0 <strtol@GLIBC_2.2.5>
    2176:	68 14 00 00 00       	push   $0x14
    217b:	e9 a0 fe ff ff       	jmp    2020 <_init+0x20>

0000000000002180 <memcpy@plt>:
    2180:	ff 25 22 9f 00 00    	jmp    *0x9f22(%rip)        # c0a8 <memcpy@GLIBC_2.14>
    2186:	68 15 00 00 00       	push   $0x15
    218b:	e9 90 fe ff ff       	jmp    2020 <_init+0x20>

0000000000002190 <malloc@plt>:
    2190:	ff 25 1a 9f 00 00    	jmp    *0x9f1a(%rip)        # c0b0 <malloc@GLIBC_2.2.5>
    2196:	68 16 00 00 00       	push   $0x16
    219b:	e9 80 fe ff ff       	jmp    2020 <_init+0x20>

00000000000021a0 <fflush@plt>:
    21a0:	ff 25 12 9f 00 00    	jmp    *0x9f12(%rip)        # c0b8 <fflush@GLIBC_2.2.5>
    21a6:	68 17 00 00 00       	push   $0x17
    21ab:	e9 70 fe ff ff       	jmp    2020 <_init+0x20>

00000000000021b0 <realloc@plt>:
    21b0:	ff 25 0a 9f 00 00    	jmp    *0x9f0a(%rip)        # c0c0 <realloc@GLIBC_2.2.5>
    21b6:	68 18 00 00 00       	push   $0x18
    21bb:	e9 60 fe ff ff       	jmp    2020 <_init+0x20>

00000000000021c0 <setvbuf@plt>:
    21c0:	ff 25 02 9f 00 00    	jmp    *0x9f02(%rip)        # c0c8 <setvbuf@GLIBC_2.2.5>
    21c6:	68 19 00 00 00       	push   $0x19
    21cb:	e9 50 fe ff ff       	jmp    2020 <_init+0x20>

00000000000021d0 <pthread_create@plt>:
    21d0:	ff 25 fa 9e 00 00    	jmp    *0x9efa(%rip)        # c0d0 <pthread_create@GLIBC_2.34>
    21d6:	68 1a 00 00 00       	push   $0x1a
    21db:	e9 40 fe ff ff       	jmp    2020 <_init+0x20>

00000000000021e0 <mprotect@plt>:
    21e0:	ff 25 f2 9e 00 00    	jmp    *0x9ef2(%rip)        # c0d8 <mprotect@GLIBC_2.2.5>
    21e6:	68 1b 00 00 00       	push   $0x1b
    21eb:	e9 30 fe ff ff       	jmp    2020 <_init+0x20>

00000000000021f0 <fopen@plt>:
    21f0:	ff 25 ea 9e 00 00    	jmp    *0x9eea(%rip)        # c0e0 <fopen@GLIBC_2.2.5>
    21f6:	68 1c 00 00 00       	push   $0x1c
    21fb:	e9 20 fe ff ff       	jmp    2020 <_init+0x20>

0000000000002200 <sysconf@plt>:
    2200:	ff 25 e2 9e 00 00    	jmp    *0x9ee2(%rip)        # c0e8 <sysconf@GLIBC_2.2.5>
    2206:	68 1d 00 00 00       	push   $0x1d
    220b:	e9 10 fe ff ff       	jmp    2020 <_init+0x20>

0000000000002210 <__cxa_atexit@plt>:
    2210:	ff 25 da 9e 00 00    	jmp    *0x9eda(%rip)        # c0f0 <__cxa_atexit@GLIBC_2.2.5>
    2216:	68 1e 00 00 00       	push   $0x1e
    221b:	e9 00 fe ff ff       	jmp    2020 <_init+0x20>

0000000000002220 <exit@plt>:
    2220:	ff 25 d2 9e 00 00    	jmp    *0x9ed2(%rip)        # c0f8 <exit@GLIBC_2.2.5>
    2226:	68 1f 00 00 00       	push   $0x1f
    222b:	e9 f0 fd ff ff       	jmp    2020 <_init+0x20>

0000000000002230 <fwrite@plt>:
    2230:	ff 25 ca 9e 00 00    	jmp    *0x9eca(%rip)        # c100 <fwrite@GLIBC_2.2.5>
    2236:	68 20 00 00 00       	push   $0x20
    223b:	e9 e0 fd ff ff       	jmp    2020 <_init+0x20>

0000000000002240 <getrlimit@plt>:
    2240:	ff 25 c2 9e 00 00    	jmp    *0x9ec2(%rip)        # c108 <getrlimit@GLIBC_2.2.5>
    2246:	68 21 00 00 00       	push   $0x21
    224b:	e9 d0 fd ff ff       	jmp    2020 <_init+0x20>

0000000000002250 <pthread_join@plt>:
    2250:	ff 25 ba 9e 00 00    	jmp    *0x9eba(%rip)        # c110 <pthread_join@GLIBC_2.34>
    2256:	68 22 00 00 00       	push   $0x22
    225b:	e9 c0 fd ff ff       	jmp    2020 <_init+0x20>

0000000000002260 <sigaltstack@plt>:
    2260:	ff 25 b2 9e 00 00    	jmp    *0x9eb2(%rip)        # c118 <sigaltstack@GLIBC_2.2.5>
    2266:	68 23 00 00 00       	push   $0x23
    226b:	e9 b0 fd ff ff       	jmp    2020 <_init+0x20>

0000000000002270 <pthread_attr_setstacksize@plt>:
    2270:	ff 25 aa 9e 00 00    	jmp    *0x9eaa(%rip)        # c120 <pthread_attr_setstacksize@GLIBC_2.34>
    2276:	68 24 00 00 00       	push   $0x24
    227b:	e9 a0 fd ff ff       	jmp    2020 <_init+0x20>

Disassembly of section .plt.got:

0000000000002280 <__cxa_finalize@plt>:
    2280:	ff 25 52 9d 00 00    	jmp    *0x9d52(%rip)        # bfd8 <__cxa_finalize@GLIBC_2.2.5>
    2286:	66 90                	xchg   %ax,%ax

Disassembly of section .text:

0000000000002290 <_start>:
    2290:	f3 0f 1e fa          	endbr64
    2294:	31 ed                	xor    %ebp,%ebp
    2296:	49 89 d1             	mov    %rdx,%r9
    2299:	5e                   	pop    %rsi
    229a:	48 89 e2             	mov    %rsp,%rdx
    229d:	48 83 e4 f0          	and    $0xfffffffffffffff0,%rsp
    22a1:	50                   	push   %rax
    22a2:	54                   	push   %rsp
    22a3:	45 31 c0             	xor    %r8d,%r8d
    22a6:	31 c9                	xor    %ecx,%ecx
    22a8:	48 8d 3d d1 00 00 00 	lea    0xd1(%rip),%rdi        # 2380 <main>
    22af:	ff 15 fb 9c 00 00    	call   *0x9cfb(%rip)        # bfb0 <__libc_start_main@GLIBC_2.34>
    22b5:	f4                   	hlt
    22b6:	66 2e 0f 1f 84 00 00 	cs nopw 0x0(%rax,%rax,1)
    22bd:	00 00 00 

00000000000022c0 <deregister_tm_clones>:
    22c0:	48 8d 3d 01 b9 00 00 	lea    0xb901(%rip),%rdi        # dbc8 <__TMC_END__>
    22c7:	48 8d 05 fa b8 00 00 	lea    0xb8fa(%rip),%rax        # dbc8 <__TMC_END__>
    22ce:	48 39 f8             	cmp    %rdi,%rax
    22d1:	74 15                	je     22e8 <deregister_tm_clones+0x28>
    22d3:	48 8b 05 de 9c 00 00 	mov    0x9cde(%rip),%rax        # bfb8 <_ITM_deregisterTMCloneTable@Base>
    22da:	48 85 c0             	test   %rax,%rax
    22dd:	74 09                	je     22e8 <deregister_tm_clones+0x28>
    22df:	ff e0                	jmp    *%rax
    22e1:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)
    22e8:	c3                   	ret
    22e9:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)

00000000000022f0 <register_tm_clones>:
    22f0:	48 8d 3d d1 b8 00 00 	lea    0xb8d1(%rip),%rdi        # dbc8 <__TMC_END__>
    22f7:	48 8d 35 ca b8 00 00 	lea    0xb8ca(%rip),%rsi        # dbc8 <__TMC_END__>
    22fe:	48 29 fe             	sub    %rdi,%rsi
    2301:	48 89 f0             	mov    %rsi,%rax
    2304:	48 c1 ee 3f          	shr    $0x3f,%rsi
    2308:	48 c1 f8 03          	sar    $0x3,%rax
    230c:	48 01 c6             	add    %rax,%rsi
    230f:	48 d1 fe             	sar    $1,%rsi
    2312:	74 14                	je     2328 <register_tm_clones+0x38>
    2314:	48 8b 05 b5 9c 00 00 	mov    0x9cb5(%rip),%rax        # bfd0 <_ITM_registerTMCloneTable@Base>
    231b:	48 85 c0             	test   %rax,%rax
    231e:	74 08                	je     2328 <register_tm_clones+0x38>
    2320:	ff e0                	jmp    *%rax
    2322:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)
    2328:	c3                   	ret
    2329:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)

0000000000002330 <__do_global_dtors_aux>:
    2330:	f3 0f 1e fa          	endbr64
    2334:	80 3d 95 b8 00 00 00 	cmpb   $0x0,0xb895(%rip)        # dbd0 <completed.0>
    233b:	75 2b                	jne    2368 <__do_global_dtors_aux+0x38>
    233d:	55                   	push   %rbp
    233e:	48 83 3d 92 9c 00 00 	cmpq   $0x0,0x9c92(%rip)        # bfd8 <__cxa_finalize@GLIBC_2.2.5>
    2345:	00 
    2346:	48 89 e5             	mov    %rsp,%rbp
    2349:	74 0c                	je     2357 <__do_global_dtors_aux+0x27>
    234b:	48 8b 3d de 9d 00 00 	mov    0x9dde(%rip),%rdi        # c130 <__dso_handle>
    2352:	e8 29 ff ff ff       	call   2280 <__cxa_finalize@plt>
    2357:	e8 64 ff ff ff       	call   22c0 <deregister_tm_clones>
    235c:	c6 05 6d b8 00 00 01 	movb   $0x1,0xb86d(%rip)        # dbd0 <completed.0>
    2363:	5d                   	pop    %rbp
    2364:	c3                   	ret
    2365:	0f 1f 00             	nopl   (%rax)
    2368:	c3                   	ret
    2369:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)

0000000000002370 <frame_dummy>:
    2370:	f3 0f 1e fa          	endbr64
    2374:	e9 77 ff ff ff       	jmp    22f0 <register_tm_clones>
    2379:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)

0000000000002380 <main>:
    2380:	41 56                	push   %r14
    2382:	53                   	push   %rbx
    2383:	48 83 ec 58          	sub    $0x58,%rsp
    2387:	48 8d 05 32 96 00 00 	lea    0x9632(%rip),%rax        # b9c0 <fwp_fn_table>
    238e:	48 89 05 4b b8 00 00 	mov    %rax,0xb84b(%rip)        # dbe0 <fwp_fns>
    2395:	4c 8b 35 24 9c 00 00 	mov    0x9c24(%rip),%r14        # bfc0 <stdout@GLIBC_2.2.5>
    239c:	49 8b 06             	mov    (%r14),%rax
    239f:	48 89 05 42 b8 00 00 	mov    %rax,0xb842(%rip)        # dbe8 <fwp_prog_out>
    23a6:	48 89 35 43 b8 00 00 	mov    %rsi,0xb843(%rip)        # dbf0 <fwp_argv>
    23ad:	48 8d 35 44 b8 00 00 	lea    0xb844(%rip),%rsi        # dbf8 <fwp_start_time>
    23b4:	bf 01 00 00 00       	mov    $0x1,%edi
    23b9:	e8 d2 fc ff ff       	call   2090 <clock_gettime@plt>
    23be:	48 8d 3d 07 70 00 00 	lea    0x7007(%rip),%rdi        # 93cc <_IO_stdin_used+0x3cc>
    23c5:	e8 66 fc ff ff       	call   2030 <getenv@plt>
    23ca:	48 85 c0             	test   %rax,%rax
    23cd:	74 28                	je     23f7 <main+0x77>
    23cf:	48 89 c3             	mov    %rax,%rbx
    23d2:	80 38 00             	cmpb   $0x0,(%rax)
    23d5:	74 20                	je     23f7 <main+0x77>
    23d7:	48 8d 74 24 08       	lea    0x8(%rsp),%rsi
    23dc:	48 89 df             	mov    %rbx,%rdi
    23df:	ba 0a 00 00 00       	mov    $0xa,%edx
    23e4:	e8 37 fd ff ff       	call   2120 <strtoull@plt>
    23e9:	48 8b 44 24 08       	mov    0x8(%rsp),%rax
    23ee:	80 38 00             	cmpb   $0x0,(%rax)
    23f1:	0f 84 b5 00 00 00    	je     24ac <main+0x12c>
    23f7:	48 8d 74 24 20       	lea    0x20(%rsp),%rsi
    23fc:	31 ff                	xor    %edi,%edi
    23fe:	e8 8d fc ff ff       	call   2090 <clock_gettime@plt>
    2403:	49 8b 3e             	mov    (%r14),%rdi
    2406:	b9 00 00 01 00       	mov    $0x10000,%ecx
    240b:	31 f6                	xor    %esi,%esi
    240d:	31 d2                	xor    %edx,%edx
    240f:	e8 ac fd ff ff       	call   21c0 <setvbuf@plt>
    2414:	be 01 00 00 00       	mov    $0x1,%esi
    2419:	bf 0d 00 00 00       	mov    $0xd,%edi
    241e:	e8 1d fd ff ff       	call   2140 <signal@plt>
    2423:	48 8d 5c 24 20       	lea    0x20(%rsp),%rbx
    2428:	48 89 df             	mov    %rbx,%rdi
    242b:	e8 d0 fc ff ff       	call   2100 <pthread_attr_init@plt>
    2430:	48 8b 35 01 9d 00 00 	mov    0x9d01(%rip),%rsi        # c138 <fwp_main_stack>
    2437:	48 89 df             	mov    %rbx,%rdi
    243a:	e8 31 fe ff ff       	call   2270 <pthread_attr_setstacksize@plt>
    243f:	48 8d 15 8a 00 00 00 	lea    0x8a(%rip),%rdx        # 24d0 <fwp_main_thread>
    2446:	48 8d 7c 24 18       	lea    0x18(%rsp),%rdi
    244b:	48 89 de             	mov    %rbx,%rsi
    244e:	31 c9                	xor    %ecx,%ecx
    2450:	e8 7b fd ff ff       	call   21d0 <pthread_create@plt>
    2455:	85 c0                	test   %eax,%eax
    2457:	74 35                	je     248e <main+0x10e>
    2459:	48 8d 74 24 08       	lea    0x8(%rsp),%rsi
    245e:	bf 03 00 00 00       	mov    $0x3,%edi
    2463:	e8 d8 fd ff ff       	call   2240 <getrlimit@plt>
    2468:	48 8b 4c 24 08       	mov    0x8(%rsp),%rcx
    246d:	48 83 f9 ff          	cmp    $0xffffffffffffffff,%rcx
    2471:	ba 00 00 80 00       	mov    $0x800000,%edx
    2476:	48 0f 44 ca          	cmove  %rdx,%rcx
    247a:	85 c0                	test   %eax,%eax
    247c:	48 0f 45 ca          	cmovne %rdx,%rcx
    2480:	48 89 0d b1 9c 00 00 	mov    %rcx,0x9cb1(%rip)        # c138 <fwp_main_stack>
    2487:	e8 44 00 00 00       	call   24d0 <fwp_main_thread>
    248c:	eb 0c                	jmp    249a <main+0x11a>
    248e:	48 8b 7c 24 18       	mov    0x18(%rsp),%rdi
    2493:	31 f6                	xor    %esi,%esi
    2495:	e8 b6 fd ff ff       	call   2250 <pthread_join@plt>
    249a:	49 8b 3e             	mov    (%r14),%rdi
    249d:	e8 fe fc ff ff       	call   21a0 <fflush@plt>
    24a2:	31 c0                	xor    %eax,%eax
    24a4:	48 83 c4 58          	add    $0x58,%rsp
    24a8:	5b                   	pop    %rbx
    24a9:	41 5e                	pop    %r14
    24ab:	c3                   	ret
    24ac:	0f b6 03             	movzbl (%rbx),%eax
    24af:	83 f8 2d             	cmp    $0x2d,%eax
    24b2:	0f 84 3f ff ff ff    	je     23f7 <main+0x77>
    24b8:	83 f8 2b             	cmp    $0x2b,%eax
    24bb:	0f 84 36 ff ff ff    	je     23f7 <main+0x77>
    24c1:	e9 3d ff ff ff       	jmp    2403 <main+0x83>
    24c6:	66 2e 0f 1f 84 00 00 	cs nopw 0x0(%rax,%rax,1)
    24cd:	00 00 00 

00000000000024d0 <fwp_main_thread>:
    24d0:	55                   	push   %rbp
    24d1:	48 89 e5             	mov    %rsp,%rbp
    24d4:	41 57                	push   %r15
    24d6:	41 56                	push   %r14
    24d8:	41 55                	push   %r13
    24da:	41 54                	push   %r12
    24dc:	53                   	push   %rbx
    24dd:	48 81 ec b8 00 00 00 	sub    $0xb8,%rsp
    24e4:	83 3d 41 ac 00 00 00 	cmpl   $0x0,0xac41(%rip)        # d12c <fwp_gc+0xfec>
    24eb:	75 05                	jne    24f2 <fwp_main_thread+0x22>
    24ed:	e8 6e 1d 00 00       	call   4260 <fwp_gc_init>
    24f2:	48 89 2d cf ac 00 00 	mov    %rbp,0xaccf(%rip)        # d1c8 <fwp_gc+0x1088>
    24f9:	48 8d 3d 30 5e 00 00 	lea    0x5e30(%rip),%rdi        # 8330 <fwp_gc_find_data>
    2500:	31 f6                	xor    %esi,%esi
    2502:	e8 39 fb ff ff       	call   2040 <dl_iterate_phdr@plt>
    2507:	83 3d 22 ac 00 00 00 	cmpl   $0x0,0xac22(%rip)        # d130 <fwp_gc+0xff0>
    250e:	0f 95 c1             	setne  %cl
    2511:	83 3d b8 ad 00 00 00 	cmpl   $0x0,0xadb8(%rip)        # d2d0 <fwp_gc+0x1190>
    2518:	0f 9f c0             	setg   %al
    251b:	20 c8                	and    %cl,%al
    251d:	0f b6 c8             	movzbl %al,%ecx
    2520:	89 0d 0e ac 00 00    	mov    %ecx,0xac0e(%rip)        # d134 <fwp_gc+0xff4>
    2526:	83 3d 0f ac 00 00 00 	cmpl   $0x0,0xac0f(%rip)        # d13c <fwp_gc+0xffc>
    252d:	74 16                	je     2545 <fwp_main_thread+0x75>
    252f:	48 8d 3d da 5e 00 00 	lea    0x5eda(%rip),%rdi        # 8410 <fwp_gc_report>
    2536:	e8 85 61 00 00       	call   86c0 <atexit>
    253b:	83 3d f2 ab 00 00 00 	cmpl   $0x0,0xabf2(%rip)        # d134 <fwp_gc+0xff4>
    2542:	0f 95 c0             	setne  %al
    2545:	84 c0                	test   %al,%al
    2547:	74 43                	je     258c <fwp_main_thread+0xbc>
    2549:	48 83 3d 0f ac 00 00 	cmpq   $0x0,0xac0f(%rip)        # d160 <fwp_gc+0x1020>
    2550:	00 
    2551:	74 39                	je     258c <fwp_main_thread+0xbc>
    2553:	48 8b 05 f6 ad 00 00 	mov    0xadf6(%rip),%rax        # d350 <fwp_gc+0x1210>
    255a:	48 2b 05 df 9b 00 00 	sub    0x9bdf(%rip),%rax        # c140 <fwp_gc>
    2561:	f2 48 0f 2a c0       	cvtsi2sd %rax,%xmm0
    2566:	f2 0f 58 05 ba ad 00 	addsd  0xadba(%rip),%xmm0        # d328 <fwp_gc+0x11e8>
    256d:	00 
    256e:	f2 0f 11 05 b2 ad 00 	movsd  %xmm0,0xadb2(%rip)        # d328 <fwp_gc+0x11e8>
    2575:	00 
    2576:	48 c7 05 cf ad 00 00 	movq   $0x0,0xadcf(%rip)        # d350 <fwp_gc+0x1210>
    257d:	00 00 00 00 
    2581:	48 c7 05 b4 9b 00 00 	movq   $0x0,0x9bb4(%rip)        # c140 <fwp_gc>
    2588:	00 00 00 00 
    258c:	48 8b 05 a5 9b 00 00 	mov    0x9ba5(%rip),%rax        # c138 <fwp_main_stack>
    2593:	48 8d 4d d7          	lea    -0x29(%rbp),%rcx
    2597:	48 89 0d 72 b6 00 00 	mov    %rcx,0xb672(%rip)        # dc10 <fwp_main_stack_top>
    259e:	48 89 05 73 b6 00 00 	mov    %rax,0xb673(%rip)        # dc18 <fwp_main_stack_size>
    25a5:	48 8d 05 74 b6 00 00 	lea    0xb674(%rip),%rax        # dc20 <fwp_stack_guard_init.alt>
    25ac:	48 89 45 b8          	mov    %rax,-0x48(%rbp)
    25b0:	48 c7 45 c8 00 00 01 	movq   $0x10000,-0x38(%rbp)
    25b7:	00 
    25b8:	c7 45 c0 00 00 00 00 	movl   $0x0,-0x40(%rbp)
    25bf:	48 8d 7d b8          	lea    -0x48(%rbp),%rdi
    25c3:	31 f6                	xor    %esi,%esi
    25c5:	e8 96 fc ff ff       	call   2260 <sigaltstack@plt>
    25ca:	85 c0                	test   %eax,%eax
    25cc:	0f 85 89 00 00 00    	jne    265b <fwp_main_thread+0x18b>
    25d2:	48 8d bd 28 ff ff ff 	lea    -0xd8(%rbp),%rdi
    25d9:	66 0f 57 c0          	xorpd  %xmm0,%xmm0
    25dd:	66 0f 11 45 a8       	movupd %xmm0,-0x58(%rbp)
    25e2:	66 0f 11 45 98       	movupd %xmm0,-0x68(%rbp)
    25e7:	66 0f 11 45 88       	movupd %xmm0,-0x78(%rbp)
    25ec:	66 0f 11 85 78 ff ff 	movupd %xmm0,-0x88(%rbp)
    25f3:	ff 
    25f4:	66 0f 11 85 68 ff ff 	movupd %xmm0,-0x98(%rbp)
    25fb:	ff 
    25fc:	66 0f 11 85 58 ff ff 	movupd %xmm0,-0xa8(%rbp)
    2603:	ff 
    2604:	66 0f 11 85 48 ff ff 	movupd %xmm0,-0xb8(%rbp)
    260b:	ff 
    260c:	66 0f 11 85 38 ff ff 	movupd %xmm0,-0xc8(%rbp)
    2613:	ff 
    2614:	66 0f 11 85 28 ff ff 	movupd %xmm0,-0xd8(%rbp)
    261b:	ff 
    261c:	48 8d 05 3d 60 00 00 	lea    0x603d(%rip),%rax        # 8660 <fwp_segv>
    2623:	48 89 85 20 ff ff ff 	mov    %rax,-0xe0(%rbp)
    262a:	c7 45 a8 04 00 00 08 	movl   $0x8000004,-0x58(%rbp)
    2631:	e8 2a fb ff ff       	call   2160 <sigemptyset@plt>
    2636:	48 8d 9d 20 ff ff ff 	lea    -0xe0(%rbp),%rbx
    263d:	bf 0b 00 00 00       	mov    $0xb,%edi
    2642:	48 89 de             	mov    %rbx,%rsi
    2645:	31 d2                	xor    %edx,%edx
    2647:	e8 34 fa ff ff       	call   2080 <sigaction@plt>
    264c:	bf 07 00 00 00       	mov    $0x7,%edi
    2651:	48 89 de             	mov    %rbx,%rsi
    2654:	31 d2                	xor    %edx,%edx
    2656:	e8 25 fa ff ff       	call   2080 <sigaction@plt>
    265b:	48 8b 1d de 9a 00 00 	mov    0x9ade(%rip),%rbx        # c140 <fwp_gc>
    2662:	80 3d b7 b5 01 00 00 	cmpb   $0x0,0x1b5b7(%rip)        # 1dc20 <caf0.st>
    2669:	48 89 d8             	mov    %rbx,%rax
    266c:	0f 85 44 02 00 00    	jne    28b6 <fwp_main_thread+0x3e6>
    2672:	be 81 00 00 00       	mov    $0x81,%esi
    2677:	31 ff                	xor    %edi,%edi
    2679:	e8 02 16 00 00       	call   3c80 <f1>
    267e:	49 89 c6             	mov    %rax,%r14
    2681:	48 8d 75 b8          	lea    -0x48(%rbp),%rsi
    2685:	48 89 c7             	mov    %rax,%rdi
    2688:	e8 63 29 00 00       	call   4ff0 <fwp_map_items>
    268d:	49 89 c7             	mov    %rax,%r15
    2690:	48 89 85 20 ff ff ff 	mov    %rax,-0xe0(%rbp)
    2697:	48 c7 85 30 ff ff ff 	movq   $0x0,-0xd0(%rbp)
    269e:	00 00 00 00 
    26a2:	48 8d 05 a7 25 00 00 	lea    0x25a7(%rip),%rax        # 4c50 <fwp_drop0>
    26a9:	48 89 85 38 ff ff ff 	mov    %rax,-0xc8(%rbp)
    26b0:	48 8d 05 49 28 00 00 	lea    0x2849(%rip),%rax        # 4f00 <fwp_drop2>
    26b7:	48 89 85 40 ff ff ff 	mov    %rax,-0xc0(%rbp)
    26be:	4c 8b 65 b8          	mov    -0x48(%rbp),%r12
    26c2:	4d 85 e4             	test   %r12,%r12
    26c5:	74 1e                	je     26e5 <fwp_main_thread+0x215>
    26c7:	45 31 ed             	xor    %r13d,%r13d
    26ca:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)
    26d0:	4b 8b 3c ef          	mov    (%r15,%r13,8),%rdi
    26d4:	e8 e7 5a 00 00       	call   81c0 <f27>
    26d9:	4b 89 04 ef          	mov    %rax,(%r15,%r13,8)
    26dd:	49 ff c5             	inc    %r13
    26e0:	4d 39 ec             	cmp    %r13,%r12
    26e3:	75 eb                	jne    26d0 <fwp_main_thread+0x200>
    26e5:	4c 89 a5 28 ff ff ff 	mov    %r12,-0xd8(%rbp)
    26ec:	48 8d bd 20 ff ff ff 	lea    -0xe0(%rbp),%rdi
    26f3:	e8 48 2a 00 00       	call   5140 <fwp_map_finish_protected>
    26f8:	4c 89 f1             	mov    %r14,%rcx
    26fb:	48 2b 0d 6e aa 00 00 	sub    0xaa6e(%rip),%rcx        # d170 <fwp_gc+0x1030>
    2702:	48 8b 15 8f aa 00 00 	mov    0xaa8f(%rip),%rdx        # d198 <fwp_gc+0x1058>
    2709:	48 c1 e2 10          	shl    $0x10,%rdx
    270d:	48 39 d1             	cmp    %rdx,%rcx
    2710:	0f 83 a6 00 00 00    	jae    27bc <fwp_main_thread+0x2ec>
    2716:	48 8b 15 9b aa 00 00 	mov    0xaa9b(%rip),%rdx        # d1b8 <fwp_gc+0x1078>
    271d:	48 89 ce             	mov    %rcx,%rsi
    2720:	48 c1 ee 10          	shr    $0x10,%rsi
    2724:	48 69 f6 28 12 00 00 	imul   $0x1228,%rsi,%rsi
    272b:	0f b6 3c 32          	movzbl (%rdx,%rsi,1),%edi
    272f:	48 81 e1 ff ff 00 00 	and    $0xffff,%rcx
    2736:	75 13                	jne    274b <fwp_main_thread+0x27b>
    2738:	40 80 ff 02          	cmp    $0x2,%dil
    273c:	75 0d                	jne    274b <fwp_main_thread+0x27b>
    273e:	48 8d 3c 32          	lea    (%rdx,%rsi,1),%rdi
    2742:	48 81 c7 28 02 00 00 	add    $0x228,%rdi
    2749:	eb 20                	jmp    276b <fwp_main_thread+0x29b>
    274b:	40 80 ff 01          	cmp    $0x1,%dil
    274f:	75 6b                	jne    27bc <fwp_main_thread+0x2ec>
    2751:	48 8d 3c 32          	lea    (%rdx,%rsi,1),%rdi
    2755:	8b 54 32 20          	mov    0x20(%rdx,%rsi,1),%edx
    2759:	48 0f af ca          	imul   %rdx,%rcx
    275d:	48 c1 e9 20          	shr    $0x20,%rcx
    2761:	48 01 cf             	add    %rcx,%rdi
    2764:	48 81 c7 28 02 00 00 	add    $0x228,%rdi
    276b:	0f b6 0f             	movzbl (%rdi),%ecx
    276e:	85 c9                	test   %ecx,%ecx
    2770:	74 4a                	je     27bc <fwp_main_thread+0x2ec>
    2772:	83 f9 01             	cmp    $0x1,%ecx
    2775:	75 35                	jne    27ac <fwp_main_thread+0x2dc>
    2777:	4d 8b 7e 10          	mov    0x10(%r14),%r15
    277b:	4c 89 f7             	mov    %r14,%rdi
    277e:	49 89 c6             	mov    %rax,%r14
    2781:	e8 0a 40 00 00       	call   6790 <fwp_rc_free_obj>
    2786:	4c 89 f0             	mov    %r14,%rax
    2789:	4c 89 f9             	mov    %r15,%rcx
    278c:	48 2b 0d dd a9 00 00 	sub    0xa9dd(%rip),%rcx        # d170 <fwp_gc+0x1030>
    2793:	48 8b 15 fe a9 00 00 	mov    0xa9fe(%rip),%rdx        # d198 <fwp_gc+0x1058>
    279a:	48 c1 e2 10          	shl    $0x10,%rdx
    279e:	4d 89 fe             	mov    %r15,%r14
    27a1:	48 39 d1             	cmp    %rdx,%rcx
    27a4:	0f 82 6c ff ff ff    	jb     2716 <fwp_main_thread+0x246>
    27aa:	eb 10                	jmp    27bc <fwp_main_thread+0x2ec>
    27ac:	81 f9 ff 00 00 00    	cmp    $0xff,%ecx
    27b2:	0f 84 47 01 00 00    	je     28ff <fwp_main_thread+0x42f>
    27b8:	fe c9                	dec    %cl
    27ba:	88 0f                	mov    %cl,(%rdi)
    27bc:	45 31 f6             	xor    %r14d,%r14d
    27bf:	48 85 c0             	test   %rax,%rax
    27c2:	74 18                	je     27dc <fwp_main_thread+0x30c>
    27c4:	48 89 c1             	mov    %rax,%rcx
    27c7:	66 0f 1f 84 00 00 00 	nopw   0x0(%rax,%rax,1)
    27ce:	00 00 
    27d0:	49 ff c6             	inc    %r14
    27d3:	48 8b 49 10          	mov    0x10(%rcx),%rcx
    27d7:	48 85 c9             	test   %rcx,%rcx
    27da:	75 f4                	jne    27d0 <fwp_main_thread+0x300>
    27dc:	48 89 c7             	mov    %rax,%rdi
    27df:	e8 1c 27 00 00       	call   4f00 <fwp_drop2>
    27e4:	4c 89 f7             	mov    %r14,%rdi
    27e7:	e8 e4 47 00 00       	call   6fd0 <f8>
    27ec:	49 89 c6             	mov    %rax,%r14
    27ef:	48 8d 78 08          	lea    0x8(%rax),%rdi
    27f3:	48 8b 10             	mov    (%rax),%rdx
    27f6:	48 8b 0d eb b3 00 00 	mov    0xb3eb(%rip),%rcx        # dbe8 <fwp_prog_out>
    27fd:	be 01 00 00 00       	mov    $0x1,%esi
    2802:	e8 29 fa ff ff       	call   2230 <fwrite@plt>
    2807:	48 8b 35 da b3 00 00 	mov    0xb3da(%rip),%rsi        # dbe8 <fwp_prog_out>
    280e:	bf 0a 00 00 00       	mov    $0xa,%edi
    2813:	e8 d8 f8 ff ff       	call   20f0 <fputc@plt>
    2818:	4c 89 f0             	mov    %r14,%rax
    281b:	48 2b 05 4e a9 00 00 	sub    0xa94e(%rip),%rax        # d170 <fwp_gc+0x1030>
    2822:	48 8b 0d 6f a9 00 00 	mov    0xa96f(%rip),%rcx        # d198 <fwp_gc+0x1058>
    2829:	48 c1 e1 10          	shl    $0x10,%rcx
    282d:	48 39 c8             	cmp    %rcx,%rax
    2830:	73 76                	jae    28a8 <fwp_main_thread+0x3d8>
    2832:	48 8b 0d 7f a9 00 00 	mov    0xa97f(%rip),%rcx        # d1b8 <fwp_gc+0x1078>
    2839:	48 89 c2             	mov    %rax,%rdx
    283c:	48 c1 ea 10          	shr    $0x10,%rdx
    2840:	48 69 d2 28 12 00 00 	imul   $0x1228,%rdx,%rdx
    2847:	0f b6 34 11          	movzbl (%rcx,%rdx,1),%esi
    284b:	48 25 ff ff 00 00    	and    $0xffff,%rax
    2851:	75 13                	jne    2866 <fwp_main_thread+0x396>
    2853:	40 80 fe 02          	cmp    $0x2,%sil
    2857:	75 0d                	jne    2866 <fwp_main_thread+0x396>
    2859:	48 8d 3c 11          	lea    (%rcx,%rdx,1),%rdi
    285d:	48 81 c7 28 02 00 00 	add    $0x228,%rdi
    2864:	eb 21                	jmp    2887 <fwp_main_thread+0x3b7>
    2866:	40 80 fe 01          	cmp    $0x1,%sil
    286a:	75 3c                	jne    28a8 <fwp_main_thread+0x3d8>
    286c:	48 8d 34 11          	lea    (%rcx,%rdx,1),%rsi
    2870:	8b 4c 11 20          	mov    0x20(%rcx,%rdx,1),%ecx
    2874:	48 0f af c1          	imul   %rcx,%rax
    2878:	48 c1 e8 20          	shr    $0x20,%rax
    287c:	48 8d 3c 30          	lea    (%rax,%rsi,1),%rdi
    2880:	48 81 c7 28 02 00 00 	add    $0x228,%rdi
    2887:	0f b6 07             	movzbl (%rdi),%eax
    288a:	85 c0                	test   %eax,%eax
    288c:	74 1a                	je     28a8 <fwp_main_thread+0x3d8>
    288e:	83 f8 01             	cmp    $0x1,%eax
    2891:	75 0a                	jne    289d <fwp_main_thread+0x3cd>
    2893:	4c 89 f7             	mov    %r14,%rdi
    2896:	e8 f5 3e 00 00       	call   6790 <fwp_rc_free_obj>
    289b:	eb 0b                	jmp    28a8 <fwp_main_thread+0x3d8>
    289d:	3d ff 00 00 00       	cmp    $0xff,%eax
    28a2:	74 6b                	je     290f <fwp_main_thread+0x43f>
    28a4:	fe c8                	dec    %al
    28a6:	88 07                	mov    %al,(%rdi)
    28a8:	c6 05 71 b3 01 00 01 	movb   $0x1,0x1b371(%rip)        # 1dc20 <caf0.st>
    28af:	48 8b 05 8a 98 00 00 	mov    0x988a(%rip),%rax        # c140 <fwp_gc>
    28b6:	48 83 3d 5a aa 00 00 	cmpq   $0x0,0xaa5a(%rip)        # d318 <fwp_gc+0x11d8>
    28bd:	00 
    28be:	75 56                	jne    2916 <fwp_main_thread+0x446>
    28c0:	83 3d 69 a8 00 00 00 	cmpl   $0x0,0xa869(%rip)        # d130 <fwp_gc+0xff0>
    28c7:	75 4d                	jne    2916 <fwp_main_thread+0x446>
    28c9:	48 39 c3             	cmp    %rax,%rbx
    28cc:	7f 48                	jg     2916 <fwp_main_thread+0x446>
    28ce:	66 0f 57 c0          	xorpd  %xmm0,%xmm0
    28d2:	66 0f 2e 05 6e aa 00 	ucomisd 0xaa6e(%rip),%xmm0        # d348 <fwp_gc+0x1208>
    28d9:	00 
    28da:	73 3a                	jae    2916 <fwp_main_thread+0x446>
    28dc:	48 8b 05 dd 96 00 00 	mov    0x96dd(%rip),%rax        # bfc0 <stdout@GLIBC_2.2.5>
    28e3:	48 8b 38             	mov    (%rax),%rdi
    28e6:	e8 b5 f8 ff ff       	call   21a0 <fflush@plt>
    28eb:	31 c0                	xor    %eax,%eax
    28ed:	48 81 c4 b8 00 00 00 	add    $0xb8,%rsp
    28f4:	5b                   	pop    %rbx
    28f5:	41 5c                	pop    %r12
    28f7:	41 5d                	pop    %r13
    28f9:	41 5e                	pop    %r14
    28fb:	41 5f                	pop    %r15
    28fd:	5d                   	pop    %rbp
    28fe:	c3                   	ret
    28ff:	49 89 c6             	mov    %rax,%r14
    2902:	e8 a9 3b 00 00       	call   64b0 <fwp_rc_wide_drop>
    2907:	4c 89 f0             	mov    %r14,%rax
    290a:	e9 ad fe ff ff       	jmp    27bc <fwp_main_thread+0x2ec>
    290f:	e8 9c 3b 00 00       	call   64b0 <fwp_rc_wide_drop>
    2914:	eb 92                	jmp    28a8 <fwp_main_thread+0x3d8>
    2916:	48 8b 0d c3 96 00 00 	mov    0x96c3(%rip),%rcx        # bfe0 <stderr@GLIBC_2.2.5>
    291d:	48 8b 39             	mov    (%rcx),%rdi
    2920:	48 29 c3             	sub    %rax,%rbx
    2923:	48 8d 35 ab 6a 00 00 	lea    0x6aab(%rip),%rsi        # 93d5 <_IO_stdin_used+0x3d5>
    292a:	48 89 da             	mov    %rbx,%rdx
    292d:	31 c0                	xor    %eax,%eax
    292f:	e8 1c f8 ff ff       	call   2150 <fprintf@plt>
    2934:	bf c1 00 00 00       	mov    $0xc1,%edi
    2939:	e8 e2 f8 ff ff       	call   2220 <exit@plt>
    293e:	66 90                	xchg   %ax,%ax

0000000000002940 <e1>:
    2940:	50                   	push   %rax
    2941:	48 8b 07             	mov    (%rdi),%rax
    2944:	48 8b 77 08          	mov    0x8(%rdi),%rsi
    2948:	48 89 c7             	mov    %rax,%rdi
    294b:	e8 30 13 00 00       	call   3c80 <f1>
    2950:	48 89 c1             	mov    %rax,%rcx
    2953:	48 2b 0d 16 a8 00 00 	sub    0xa816(%rip),%rcx        # d170 <fwp_gc+0x1030>
    295a:	48 8b 15 37 a8 00 00 	mov    0xa837(%rip),%rdx        # d198 <fwp_gc+0x1058>
    2961:	48 c1 e2 10          	shl    $0x10,%rdx
    2965:	48 39 d1             	cmp    %rdx,%rcx
    2968:	73 5f                	jae    29c9 <e1+0x89>
    296a:	48 8b 15 47 a8 00 00 	mov    0xa847(%rip),%rdx        # d1b8 <fwp_gc+0x1078>
    2971:	48 89 ce             	mov    %rcx,%rsi
    2974:	48 c1 ee 10          	shr    $0x10,%rsi
    2978:	48 69 f6 28 12 00 00 	imul   $0x1228,%rsi,%rsi
    297f:	0f b6 3c 32          	movzbl (%rdx,%rsi,1),%edi
    2983:	48 81 e1 ff ff 00 00 	and    $0xffff,%rcx
    298a:	75 18                	jne    29a4 <e1+0x64>
    298c:	40 80 ff 02          	cmp    $0x2,%dil
    2990:	75 12                	jne    29a4 <e1+0x64>
    2992:	48 8d 0c 32          	lea    (%rdx,%rsi,1),%rcx
    2996:	48 81 c1 28 02 00 00 	add    $0x228,%rcx
    299d:	80 39 00             	cmpb   $0x0,(%rcx)
    29a0:	74 27                	je     29c9 <e1+0x89>
    29a2:	eb 27                	jmp    29cb <e1+0x8b>
    29a4:	40 80 ff 01          	cmp    $0x1,%dil
    29a8:	75 1f                	jne    29c9 <e1+0x89>
    29aa:	48 8d 3c 32          	lea    (%rdx,%rsi,1),%rdi
    29ae:	8b 54 32 20          	mov    0x20(%rdx,%rsi,1),%edx
    29b2:	48 0f af ca          	imul   %rdx,%rcx
    29b6:	48 c1 e9 20          	shr    $0x20,%rcx
    29ba:	48 01 f9             	add    %rdi,%rcx
    29bd:	48 81 c1 28 02 00 00 	add    $0x228,%rcx
    29c4:	80 39 00             	cmpb   $0x0,(%rcx)
    29c7:	75 02                	jne    29cb <e1+0x8b>
    29c9:	59                   	pop    %rcx
    29ca:	c3                   	ret
    29cb:	e8 00 14 00 00       	call   3dd0 <fwp_flush>
    29d0:	48 8b 05 09 96 00 00 	mov    0x9609(%rip),%rax        # bfe0 <stderr@GLIBC_2.2.5>
    29d7:	48 8b 38             	mov    (%rax),%rdi
    29da:	48 8d 35 d7 67 00 00 	lea    0x67d7(%rip),%rsi        # 91b8 <_IO_stdin_used+0x1b8>
    29e1:	48 8d 15 a3 67 00 00 	lea    0x67a3(%rip),%rdx        # 918b <_IO_stdin_used+0x18b>
    29e8:	31 c0                	xor    %eax,%eax
    29ea:	e8 61 f7 ff ff       	call   2150 <fprintf@plt>
    29ef:	bf 65 00 00 00       	mov    $0x65,%edi
    29f4:	e8 27 f8 ff ff       	call   2220 <exit@plt>
    29f9:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)

0000000000002a00 <e2>:
    2a00:	55                   	push   %rbp
    2a01:	41 57                	push   %r15
    2a03:	41 56                	push   %r14
    2a05:	41 55                	push   %r13
    2a07:	41 54                	push   %r12
    2a09:	53                   	push   %rbx
    2a0a:	48 83 ec 68          	sub    $0x68,%rsp
    2a0e:	48 8b 17             	mov    (%rdi),%rdx
    2a11:	48 8b 05 58 a7 00 00 	mov    0xa758(%rip),%rax        # d170 <fwp_gc+0x1030>
    2a18:	48 89 54 24 08       	mov    %rdx,0x8(%rsp)
    2a1d:	48 29 c2             	sub    %rax,%rdx
    2a20:	48 8b 0d 71 a7 00 00 	mov    0xa771(%rip),%rcx        # d198 <fwp_gc+0x1058>
    2a27:	48 c1 e1 10          	shl    $0x10,%rcx
    2a2b:	48 39 ca             	cmp    %rcx,%rdx
    2a2e:	73 68                	jae    2a98 <e2+0x98>
    2a30:	48 8b 35 81 a7 00 00 	mov    0xa781(%rip),%rsi        # d1b8 <fwp_gc+0x1078>
    2a37:	49 89 d0             	mov    %rdx,%r8
    2a3a:	49 c1 e8 10          	shr    $0x10,%r8
    2a3e:	4d 69 c0 28 12 00 00 	imul   $0x1228,%r8,%r8
    2a45:	46 0f b6 0c 06       	movzbl (%rsi,%r8,1),%r9d
    2a4a:	48 81 e2 ff ff 00 00 	and    $0xffff,%rdx
    2a51:	75 1b                	jne    2a6e <e2+0x6e>
    2a53:	41 80 f9 02          	cmp    $0x2,%r9b
    2a57:	75 15                	jne    2a6e <e2+0x6e>
    2a59:	4a 8d 14 06          	lea    (%rsi,%r8,1),%rdx
    2a5d:	48 81 c2 28 02 00 00 	add    $0x228,%rdx
    2a64:	80 3a 00             	cmpb   $0x0,(%rdx)
    2a67:	74 2f                	je     2a98 <e2+0x98>
    2a69:	e9 b8 04 00 00       	jmp    2f26 <e2+0x526>
    2a6e:	41 80 f9 01          	cmp    $0x1,%r9b
    2a72:	75 24                	jne    2a98 <e2+0x98>
    2a74:	4e 8d 0c 06          	lea    (%rsi,%r8,1),%r9
    2a78:	42 8b 74 06 20       	mov    0x20(%rsi,%r8,1),%esi
    2a7d:	48 0f af d6          	imul   %rsi,%rdx
    2a81:	48 c1 ea 20          	shr    $0x20,%rdx
    2a85:	4c 01 ca             	add    %r9,%rdx
    2a88:	48 81 c2 28 02 00 00 	add    $0x228,%rdx
    2a8f:	80 3a 00             	cmpb   $0x0,(%rdx)
    2a92:	0f 85 8e 04 00 00    	jne    2f26 <e2+0x526>
    2a98:	48 8b 7f 08          	mov    0x8(%rdi),%rdi
    2a9c:	48 89 fa             	mov    %rdi,%rdx
    2a9f:	48 29 c2             	sub    %rax,%rdx
    2aa2:	48 39 ca             	cmp    %rcx,%rdx
    2aa5:	73 64                	jae    2b0b <e2+0x10b>
    2aa7:	48 8b 05 0a a7 00 00 	mov    0xa70a(%rip),%rax        # d1b8 <fwp_gc+0x1078>
    2aae:	48 89 d1             	mov    %rdx,%rcx
    2ab1:	48 c1 e9 10          	shr    $0x10,%rcx
    2ab5:	48 69 c9 28 12 00 00 	imul   $0x1228,%rcx,%rcx
    2abc:	0f b6 34 08          	movzbl (%rax,%rcx,1),%esi
    2ac0:	48 81 e2 ff ff 00 00 	and    $0xffff,%rdx
    2ac7:	75 19                	jne    2ae2 <e2+0xe2>
    2ac9:	40 80 fe 02          	cmp    $0x2,%sil
    2acd:	75 13                	jne    2ae2 <e2+0xe2>
    2acf:	48 01 c8             	add    %rcx,%rax
    2ad2:	48 05 28 02 00 00    	add    $0x228,%rax
    2ad8:	80 38 00             	cmpb   $0x0,(%rax)
    2adb:	74 2e                	je     2b0b <e2+0x10b>
    2add:	e9 44 04 00 00       	jmp    2f26 <e2+0x526>
    2ae2:	40 80 fe 01          	cmp    $0x1,%sil
    2ae6:	75 23                	jne    2b0b <e2+0x10b>
    2ae8:	48 8d 34 08          	lea    (%rax,%rcx,1),%rsi
    2aec:	8b 44 08 20          	mov    0x20(%rax,%rcx,1),%eax
    2af0:	48 0f af d0          	imul   %rax,%rdx
    2af4:	48 c1 ea 20          	shr    $0x20,%rdx
    2af8:	48 8d 04 32          	lea    (%rdx,%rsi,1),%rax
    2afc:	48 05 28 02 00 00    	add    $0x228,%rax
    2b02:	80 38 00             	cmpb   $0x0,(%rax)
    2b05:	0f 85 1b 04 00 00    	jne    2f26 <e2+0x526>
    2b0b:	48 8d 74 24 38       	lea    0x38(%rsp),%rsi
    2b10:	48 89 7c 24 20       	mov    %rdi,0x20(%rsp)
    2b15:	e8 d6 24 00 00       	call   4ff0 <fwp_map_items>
    2b1a:	48 89 44 24 30       	mov    %rax,0x30(%rsp)
    2b1f:	48 89 44 24 40       	mov    %rax,0x40(%rsp)
    2b24:	0f 57 c0             	xorps  %xmm0,%xmm0
    2b27:	0f 11 44 24 48       	movups %xmm0,0x48(%rsp)
    2b2c:	48 8d 05 1d 21 00 00 	lea    0x211d(%rip),%rax        # 4c50 <fwp_drop0>
    2b33:	48 89 44 24 58       	mov    %rax,0x58(%rsp)
    2b38:	48 8d 05 c1 23 00 00 	lea    0x23c1(%rip),%rax        # 4f00 <fwp_drop2>
    2b3f:	48 89 44 24 60       	mov    %rax,0x60(%rsp)
    2b44:	48 8b 44 24 38       	mov    0x38(%rsp),%rax
    2b49:	48 89 44 24 28       	mov    %rax,0x28(%rsp)
    2b4e:	48 85 c0             	test   %rax,%rax
    2b51:	4c 8b 44 24 08       	mov    0x8(%rsp),%r8
    2b56:	0f 84 30 03 00 00    	je     2e8c <e2+0x48c>
    2b5c:	31 db                	xor    %ebx,%ebx
    2b5e:	eb 30                	jmp    2b90 <e2+0x190>
    2b60:	4c 89 ef             	mov    %r13,%rdi
    2b63:	89 ee                	mov    %ebp,%esi
    2b65:	4c 89 e2             	mov    %r12,%rdx
    2b68:	e8 03 27 00 00       	call   5270 <fwp_apply>
    2b6d:	49 89 c5             	mov    %rax,%r13
    2b70:	4c 8b 44 24 08       	mov    0x8(%rsp),%r8
    2b75:	48 8b 5c 24 10       	mov    0x10(%rsp),%rbx
    2b7a:	4d 89 2e             	mov    %r13,(%r14)
    2b7d:	48 ff c3             	inc    %rbx
    2b80:	48 89 5c 24 48       	mov    %rbx,0x48(%rsp)
    2b85:	48 3b 5c 24 28       	cmp    0x28(%rsp),%rbx
    2b8a:	0f 84 fc 02 00 00    	je     2e8c <e2+0x48c>
    2b90:	48 8b 44 24 30       	mov    0x30(%rsp),%rax
    2b95:	48 8d 04 d8          	lea    (%rax,%rbx,8),%rax
    2b99:	4c 8b 2d 40 b0 00 00 	mov    0xb040(%rip),%r13        # dbe0 <fwp_fns>
    2ba0:	45 8b 30             	mov    (%r8),%r14d
    2ba3:	49 c1 e6 05          	shl    $0x5,%r14
    2ba7:	bd 01 00 00 00       	mov    $0x1,%ebp
    2bac:	4b 83 7c 35 18 00    	cmpq   $0x0,0x18(%r13,%r14,1)
    2bb2:	48 89 5c 24 10       	mov    %rbx,0x10(%rsp)
    2bb7:	74 57                	je     2c10 <e2+0x210>
    2bb9:	48 89 44 24 18       	mov    %rax,0x18(%rsp)
    2bbe:	4c 89 c0             	mov    %r8,%rax
    2bc1:	48 2b 05 a8 a5 00 00 	sub    0xa5a8(%rip),%rax        # d170 <fwp_gc+0x1030>
    2bc8:	48 8b 0d c9 a5 00 00 	mov    0xa5c9(%rip),%rcx        # d198 <fwp_gc+0x1058>
    2bcf:	48 c1 e1 10          	shl    $0x10,%rcx
    2bd3:	48 39 c8             	cmp    %rcx,%rax
    2bd6:	73 7a                	jae    2c52 <e2+0x252>
    2bd8:	48 8b 0d d9 a5 00 00 	mov    0xa5d9(%rip),%rcx        # d1b8 <fwp_gc+0x1078>
    2bdf:	48 89 c2             	mov    %rax,%rdx
    2be2:	48 c1 ea 10          	shr    $0x10,%rdx
    2be6:	48 69 d2 28 12 00 00 	imul   $0x1228,%rdx,%rdx
    2bed:	0f b6 34 11          	movzbl (%rcx,%rdx,1),%esi
    2bf1:	48 25 ff ff 00 00    	and    $0xffff,%rax
    2bf7:	75 25                	jne    2c1e <e2+0x21e>
    2bf9:	40 80 fe 02          	cmp    $0x2,%sil
    2bfd:	75 1f                	jne    2c1e <e2+0x21e>
    2bff:	48 8d 3c 11          	lea    (%rcx,%rdx,1),%rdi
    2c03:	48 81 c7 28 02 00 00 	add    $0x228,%rdi
    2c0a:	eb 33                	jmp    2c3f <e2+0x23f>
    2c0c:	0f 1f 40 00          	nopl   0x0(%rax)
    2c10:	49 89 c4             	mov    %rax,%r12
    2c13:	4d 89 c5             	mov    %r8,%r13
    2c16:	49 89 c6             	mov    %rax,%r14
    2c19:	e9 22 01 00 00       	jmp    2d40 <e2+0x340>
    2c1e:	40 80 fe 01          	cmp    $0x1,%sil
    2c22:	75 2e                	jne    2c52 <e2+0x252>
    2c24:	48 8d 34 11          	lea    (%rcx,%rdx,1),%rsi
    2c28:	8b 4c 11 20          	mov    0x20(%rcx,%rdx,1),%ecx
    2c2c:	48 0f af c1          	imul   %rcx,%rax
    2c30:	48 c1 e8 20          	shr    $0x20,%rax
    2c34:	48 8d 3c 30          	lea    (%rax,%rsi,1),%rdi
    2c38:	48 81 c7 28 02 00 00 	add    $0x228,%rdi
    2c3f:	0f b6 07             	movzbl (%rdi),%eax
    2c42:	84 c0                	test   %al,%al
    2c44:	74 0c                	je     2c52 <e2+0x252>
    2c46:	3c fd                	cmp    $0xfd,%al
    2c48:	0f 87 2f 02 00 00    	ja     2e7d <e2+0x47d>
    2c4e:	fe c0                	inc    %al
    2c50:	88 07                	mov    %al,(%rdi)
    2c52:	4b 8d 04 2e          	lea    (%r14,%r13,1),%rax
    2c56:	8b 18                	mov    (%rax),%ebx
    2c58:	45 8b 78 04          	mov    0x4(%r8),%r15d
    2c5c:	45 31 e4             	xor    %r12d,%r12d
    2c5f:	44 39 fb             	cmp    %r15d,%ebx
    2c62:	41 0f 95 c4          	setne  %r12b
    2c66:	74 1e                	je     2c86 <e2+0x286>
    2c68:	4b 8d 04 2e          	lea    (%r14,%r13,1),%rax
    2c6c:	48 83 c0 18          	add    $0x18,%rax
    2c70:	48 8b 00             	mov    (%rax),%rax
    2c73:	48 8b 7c 24 18       	mov    0x18(%rsp),%rdi
    2c78:	44 89 fe             	mov    %r15d,%esi
    2c7b:	44 89 e2             	mov    %r12d,%edx
    2c7e:	ff 50 10             	call   *0x10(%rax)
    2c81:	4c 8b 44 24 08       	mov    0x8(%rsp),%r8
    2c86:	4c 89 c7             	mov    %r8,%rdi
    2c89:	44 89 e6             	mov    %r12d,%esi
    2c8c:	4c 8b 74 24 18       	mov    0x18(%rsp),%r14
    2c91:	4c 89 f2             	mov    %r14,%rdx
    2c94:	e8 37 2b 00 00       	call   57d0 <fwp_apply_owned>
    2c99:	49 89 c5             	mov    %rax,%r13
    2c9c:	44 39 fb             	cmp    %r15d,%ebx
    2c9f:	0f 85 cb fe ff ff    	jne    2b70 <e2+0x170>
    2ca5:	48 8b 0d 34 af 00 00 	mov    0xaf34(%rip),%rcx        # dbe0 <fwp_fns>
    2cac:	41 8b 55 00          	mov    0x0(%r13),%edx
    2cb0:	48 c1 e2 05          	shl    $0x5,%rdx
    2cb4:	48 8b 44 11 18       	mov    0x18(%rcx,%rdx,1),%rax
    2cb9:	48 85 c0             	test   %rax,%rax
    2cbc:	74 73                	je     2d31 <e2+0x331>
    2cbe:	48 01 d1             	add    %rdx,%rcx
    2cc1:	bd 01 00 00 00       	mov    $0x1,%ebp
    2cc6:	4d 89 f4             	mov    %r14,%r12
    2cc9:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)
    2cd0:	8b 19                	mov    (%rcx),%ebx
    2cd2:	41 8b 75 04          	mov    0x4(%r13),%esi
    2cd6:	29 f3                	sub    %esi,%ebx
    2cd8:	39 dd                	cmp    %ebx,%ebp
    2cda:	41 89 df             	mov    %ebx,%r15d
    2cdd:	44 0f 42 fd          	cmovb  %ebp,%r15d
    2ce1:	45 85 ff             	test   %r15d,%r15d
    2ce4:	74 09                	je     2cef <e2+0x2ef>
    2ce6:	4c 89 e7             	mov    %r12,%rdi
    2ce9:	44 89 fa             	mov    %r15d,%edx
    2cec:	ff 50 10             	call   *0x10(%rax)
    2cef:	4c 89 ef             	mov    %r13,%rdi
    2cf2:	44 89 fe             	mov    %r15d,%esi
    2cf5:	4c 89 e2             	mov    %r12,%rdx
    2cf8:	e8 d3 2a 00 00       	call   57d0 <fwp_apply_owned>
    2cfd:	49 89 c5             	mov    %rax,%r13
    2d00:	39 dd                	cmp    %ebx,%ebp
    2d02:	0f 86 68 fe ff ff    	jbe    2b70 <e2+0x170>
    2d08:	44 89 f8             	mov    %r15d,%eax
    2d0b:	4d 8d 24 c4          	lea    (%r12,%rax,8),%r12
    2d0f:	44 29 fd             	sub    %r15d,%ebp
    2d12:	48 8b 05 c7 ae 00 00 	mov    0xaec7(%rip),%rax        # dbe0 <fwp_fns>
    2d19:	41 8b 55 00          	mov    0x0(%r13),%edx
    2d1d:	48 c1 e2 05          	shl    $0x5,%rdx
    2d21:	48 8d 0c 10          	lea    (%rax,%rdx,1),%rcx
    2d25:	48 8b 44 10 18       	mov    0x18(%rax,%rdx,1),%rax
    2d2a:	48 85 c0             	test   %rax,%rax
    2d2d:	75 a1                	jne    2cd0 <e2+0x2d0>
    2d2f:	eb 0f                	jmp    2d40 <e2+0x340>
    2d31:	4d 89 f4             	mov    %r14,%r12
    2d34:	66 66 66 2e 0f 1f 84 	data16 data16 cs nopw 0x0(%rax,%rax,1)
    2d3b:	00 00 00 00 00 
    2d40:	48 8b 05 29 a4 00 00 	mov    0xa429(%rip),%rax        # d170 <fwp_gc+0x1030>
    2d47:	4c 89 ea             	mov    %r13,%rdx
    2d4a:	48 29 c2             	sub    %rax,%rdx
    2d4d:	48 8b 0d 44 a4 00 00 	mov    0xa444(%rip),%rcx        # d198 <fwp_gc+0x1058>
    2d54:	48 c1 e1 10          	shl    $0x10,%rcx
    2d58:	48 39 ca             	cmp    %rcx,%rdx
    2d5b:	73 73                	jae    2dd0 <e2+0x3d0>
    2d5d:	48 8b 35 54 a4 00 00 	mov    0xa454(%rip),%rsi        # d1b8 <fwp_gc+0x1078>
    2d64:	48 89 d7             	mov    %rdx,%rdi
    2d67:	48 c1 ef 10          	shr    $0x10,%rdi
    2d6b:	48 69 ff 28 12 00 00 	imul   $0x1228,%rdi,%rdi
    2d72:	44 0f b6 04 3e       	movzbl (%rsi,%rdi,1),%r8d
    2d77:	48 81 e2 ff ff 00 00 	and    $0xffff,%rdx
    2d7e:	75 1b                	jne    2d9b <e2+0x39b>
    2d80:	41 80 f8 02          	cmp    $0x2,%r8b
    2d84:	75 15                	jne    2d9b <e2+0x39b>
    2d86:	48 8d 14 3e          	lea    (%rsi,%rdi,1),%rdx
    2d8a:	48 81 c2 28 02 00 00 	add    $0x228,%rdx
    2d91:	80 3a 00             	cmpb   $0x0,(%rdx)
    2d94:	74 3a                	je     2dd0 <e2+0x3d0>
    2d96:	e9 8b 01 00 00       	jmp    2f26 <e2+0x526>
    2d9b:	41 80 f8 01          	cmp    $0x1,%r8b
    2d9f:	75 2f                	jne    2dd0 <e2+0x3d0>
    2da1:	4c 8d 04 3e          	lea    (%rsi,%rdi,1),%r8
    2da5:	8b 74 3e 20          	mov    0x20(%rsi,%rdi,1),%esi
    2da9:	48 0f af d6          	imul   %rsi,%rdx
    2dad:	48 c1 ea 20          	shr    $0x20,%rdx
    2db1:	4c 01 c2             	add    %r8,%rdx
    2db4:	48 81 c2 28 02 00 00 	add    $0x228,%rdx
    2dbb:	80 3a 00             	cmpb   $0x0,(%rdx)
    2dbe:	0f 85 62 01 00 00    	jne    2f26 <e2+0x526>
    2dc4:	66 66 66 2e 0f 1f 84 	data16 data16 cs nopw 0x0(%rax,%rax,1)
    2dcb:	00 00 00 00 00 
    2dd0:	85 ed                	test   %ebp,%ebp
    2dd2:	0f 84 88 fd ff ff    	je     2b60 <e2+0x160>
    2dd8:	48 8b 15 d9 a3 00 00 	mov    0xa3d9(%rip),%rdx        # d1b8 <fwp_gc+0x1078>
    2ddf:	89 ee                	mov    %ebp,%esi
    2de1:	31 ff                	xor    %edi,%edi
    2de3:	eb 2b                	jmp    2e10 <e2+0x410>
    2de5:	66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
    2dec:	00 00 00 00 
    2df0:	4e 8d 04 0a          	lea    (%rdx,%r9,1),%r8
    2df4:	49 81 c0 28 02 00 00 	add    $0x228,%r8
    2dfb:	41 80 38 00          	cmpb   $0x0,(%r8)
    2dff:	74 6f                	je     2e70 <e2+0x470>
    2e01:	e9 20 01 00 00       	jmp    2f26 <e2+0x526>
    2e06:	66 2e 0f 1f 84 00 00 	cs nopw 0x0(%rax,%rax,1)
    2e0d:	00 00 00 
    2e10:	4d 8b 04 fc          	mov    (%r12,%rdi,8),%r8
    2e14:	49 29 c0             	sub    %rax,%r8
    2e17:	49 39 c8             	cmp    %rcx,%r8
    2e1a:	73 54                	jae    2e70 <e2+0x470>
    2e1c:	4d 89 c1             	mov    %r8,%r9
    2e1f:	49 c1 e9 10          	shr    $0x10,%r9
    2e23:	4d 69 c9 28 12 00 00 	imul   $0x1228,%r9,%r9
    2e2a:	46 0f b6 14 0a       	movzbl (%rdx,%r9,1),%r10d
    2e2f:	49 81 e0 ff ff 00 00 	and    $0xffff,%r8
    2e36:	75 06                	jne    2e3e <e2+0x43e>
    2e38:	41 80 fa 02          	cmp    $0x2,%r10b
    2e3c:	74 b2                	je     2df0 <e2+0x3f0>
    2e3e:	41 80 fa 01          	cmp    $0x1,%r10b
    2e42:	75 2c                	jne    2e70 <e2+0x470>
    2e44:	4e 8d 14 0a          	lea    (%rdx,%r9,1),%r10
    2e48:	46 8b 4c 0a 20       	mov    0x20(%rdx,%r9,1),%r9d
    2e4d:	4d 0f af c1          	imul   %r9,%r8
    2e51:	49 c1 e8 20          	shr    $0x20,%r8
    2e55:	4d 01 d0             	add    %r10,%r8
    2e58:	49 81 c0 28 02 00 00 	add    $0x228,%r8
    2e5f:	41 80 38 00          	cmpb   $0x0,(%r8)
    2e63:	0f 85 bd 00 00 00    	jne    2f26 <e2+0x526>
    2e69:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)
    2e70:	48 ff c7             	inc    %rdi
    2e73:	48 39 fe             	cmp    %rdi,%rsi
    2e76:	75 98                	jne    2e10 <e2+0x410>
    2e78:	e9 e3 fc ff ff       	jmp    2b60 <e2+0x160>
    2e7d:	e8 be 31 00 00       	call   6040 <fwp_rc_wide_dup>
    2e82:	4c 8b 44 24 08       	mov    0x8(%rsp),%r8
    2e87:	e9 c6 fd ff ff       	jmp    2c52 <e2+0x252>
    2e8c:	48 8d 7c 24 40       	lea    0x40(%rsp),%rdi
    2e91:	4c 89 c3             	mov    %r8,%rbx
    2e94:	e8 a7 22 00 00       	call   5140 <fwp_map_finish_protected>
    2e99:	48 8b 4c 24 20       	mov    0x20(%rsp),%rcx
    2e9e:	48 89 c1             	mov    %rax,%rcx
    2ea1:	48 2b 0d c8 a2 00 00 	sub    0xa2c8(%rip),%rcx        # d170 <fwp_gc+0x1030>
    2ea8:	48 8b 15 e9 a2 00 00 	mov    0xa2e9(%rip),%rdx        # d198 <fwp_gc+0x1058>
    2eaf:	48 c1 e2 10          	shl    $0x10,%rdx
    2eb3:	48 39 d1             	cmp    %rdx,%rcx
    2eb6:	73 5f                	jae    2f17 <e2+0x517>
    2eb8:	48 8b 15 f9 a2 00 00 	mov    0xa2f9(%rip),%rdx        # d1b8 <fwp_gc+0x1078>
    2ebf:	48 89 ce             	mov    %rcx,%rsi
    2ec2:	48 c1 ee 10          	shr    $0x10,%rsi
    2ec6:	48 69 f6 28 12 00 00 	imul   $0x1228,%rsi,%rsi
    2ecd:	0f b6 3c 32          	movzbl (%rdx,%rsi,1),%edi
    2ed1:	48 81 e1 ff ff 00 00 	and    $0xffff,%rcx
    2ed8:	75 18                	jne    2ef2 <e2+0x4f2>
    2eda:	40 80 ff 02          	cmp    $0x2,%dil
    2ede:	75 12                	jne    2ef2 <e2+0x4f2>
    2ee0:	48 8d 0c 32          	lea    (%rdx,%rsi,1),%rcx
    2ee4:	48 81 c1 28 02 00 00 	add    $0x228,%rcx
    2eeb:	80 39 00             	cmpb   $0x0,(%rcx)
    2eee:	74 27                	je     2f17 <e2+0x517>
    2ef0:	eb 34                	jmp    2f26 <e2+0x526>
    2ef2:	40 80 ff 01          	cmp    $0x1,%dil
    2ef6:	75 1f                	jne    2f17 <e2+0x517>
    2ef8:	48 8d 3c 32          	lea    (%rdx,%rsi,1),%rdi
    2efc:	8b 54 32 20          	mov    0x20(%rdx,%rsi,1),%edx
    2f00:	48 0f af ca          	imul   %rdx,%rcx
    2f04:	48 c1 e9 20          	shr    $0x20,%rcx
    2f08:	48 01 f9             	add    %rdi,%rcx
    2f0b:	48 81 c1 28 02 00 00 	add    $0x228,%rcx
    2f12:	80 39 00             	cmpb   $0x0,(%rcx)
    2f15:	75 0f                	jne    2f26 <e2+0x526>
    2f17:	48 83 c4 68          	add    $0x68,%rsp
    2f1b:	5b                   	pop    %rbx
    2f1c:	41 5c                	pop    %r12
    2f1e:	41 5d                	pop    %r13
    2f20:	41 5e                	pop    %r14
    2f22:	41 5f                	pop    %r15
    2f24:	5d                   	pop    %rbp
    2f25:	c3                   	ret
    2f26:	e8 a5 0e 00 00       	call   3dd0 <fwp_flush>
    2f2b:	48 8b 05 ae 90 00 00 	mov    0x90ae(%rip),%rax        # bfe0 <stderr@GLIBC_2.2.5>
    2f32:	48 8b 38             	mov    (%rax),%rdi
    2f35:	48 8d 35 7c 62 00 00 	lea    0x627c(%rip),%rsi        # 91b8 <_IO_stdin_used+0x1b8>
    2f3c:	48 8d 15 48 62 00 00 	lea    0x6248(%rip),%rdx        # 918b <_IO_stdin_used+0x18b>
    2f43:	31 c0                	xor    %eax,%eax
    2f45:	e8 06 f2 ff ff       	call   2150 <fprintf@plt>
    2f4a:	bf 65 00 00 00       	mov    $0x65,%edi
    2f4f:	e8 cc f2 ff ff       	call   2220 <exit@plt>
    2f54:	66 66 66 2e 0f 1f 84 	data16 data16 cs nopw 0x0(%rax,%rax,1)
    2f5b:	00 00 00 00 00 

0000000000002f60 <e3>:
    2f60:	50                   	push   %rax
    2f61:	48 8b 77 08          	mov    0x8(%rdi),%rsi
    2f65:	48 89 f0             	mov    %rsi,%rax
    2f68:	48 2b 05 01 a2 00 00 	sub    0xa201(%rip),%rax        # d170 <fwp_gc+0x1030>
    2f6f:	48 8b 0d 22 a2 00 00 	mov    0xa222(%rip),%rcx        # d198 <fwp_gc+0x1058>
    2f76:	48 c1 e1 10          	shl    $0x10,%rcx
    2f7a:	48 39 c8             	cmp    %rcx,%rax
    2f7d:	73 64                	jae    2fe3 <e3+0x83>
    2f7f:	48 8b 0d 32 a2 00 00 	mov    0xa232(%rip),%rcx        # d1b8 <fwp_gc+0x1078>
    2f86:	48 89 c2             	mov    %rax,%rdx
    2f89:	48 c1 ea 10          	shr    $0x10,%rdx
    2f8d:	48 69 d2 28 12 00 00 	imul   $0x1228,%rdx,%rdx
    2f94:	44 0f b6 04 11       	movzbl (%rcx,%rdx,1),%r8d
    2f99:	48 25 ff ff 00 00    	and    $0xffff,%rax
    2f9f:	75 1a                	jne    2fbb <e3+0x5b>
    2fa1:	41 80 f8 02          	cmp    $0x2,%r8b
    2fa5:	75 14                	jne    2fbb <e3+0x5b>
    2fa7:	48 8d 04 11          	lea    (%rcx,%rdx,1),%rax
    2fab:	48 05 28 02 00 00    	add    $0x228,%rax
    2fb1:	80 38 00             	cmpb   $0x0,(%rax)
    2fb4:	74 2d                	je     2fe3 <e3+0x83>
    2fb6:	e9 ab 00 00 00       	jmp    3066 <e3+0x106>
    2fbb:	41 80 f8 01          	cmp    $0x1,%r8b
    2fbf:	75 22                	jne    2fe3 <e3+0x83>
    2fc1:	4c 8d 04 11          	lea    (%rcx,%rdx,1),%r8
    2fc5:	8b 4c 11 20          	mov    0x20(%rcx,%rdx,1),%ecx
    2fc9:	48 0f af c1          	imul   %rcx,%rax
    2fcd:	48 c1 e8 20          	shr    $0x20,%rax
    2fd1:	4c 01 c0             	add    %r8,%rax
    2fd4:	48 05 28 02 00 00    	add    $0x228,%rax
    2fda:	80 38 00             	cmpb   $0x0,(%rax)
    2fdd:	0f 85 83 00 00 00    	jne    3066 <e3+0x106>
    2fe3:	48 8b 3f             	mov    (%rdi),%rdi
    2fe6:	e8 85 39 00 00       	call   6970 <f3>
    2feb:	48 89 c1             	mov    %rax,%rcx
    2fee:	48 2b 0d 7b a1 00 00 	sub    0xa17b(%rip),%rcx        # d170 <fwp_gc+0x1030>
    2ff5:	48 8b 15 9c a1 00 00 	mov    0xa19c(%rip),%rdx        # d198 <fwp_gc+0x1058>
    2ffc:	48 c1 e2 10          	shl    $0x10,%rdx
    3000:	48 39 d1             	cmp    %rdx,%rcx
    3003:	73 5f                	jae    3064 <e3+0x104>
    3005:	48 8b 15 ac a1 00 00 	mov    0xa1ac(%rip),%rdx        # d1b8 <fwp_gc+0x1078>
    300c:	48 89 ce             	mov    %rcx,%rsi
    300f:	48 c1 ee 10          	shr    $0x10,%rsi
    3013:	48 69 f6 28 12 00 00 	imul   $0x1228,%rsi,%rsi
    301a:	0f b6 3c 32          	movzbl (%rdx,%rsi,1),%edi
    301e:	48 81 e1 ff ff 00 00 	and    $0xffff,%rcx
    3025:	75 18                	jne    303f <e3+0xdf>
    3027:	40 80 ff 02          	cmp    $0x2,%dil
    302b:	75 12                	jne    303f <e3+0xdf>
    302d:	48 8d 0c 32          	lea    (%rdx,%rsi,1),%rcx
    3031:	48 81 c1 28 02 00 00 	add    $0x228,%rcx
    3038:	80 39 00             	cmpb   $0x0,(%rcx)
    303b:	74 27                	je     3064 <e3+0x104>
    303d:	eb 27                	jmp    3066 <e3+0x106>
    303f:	40 80 ff 01          	cmp    $0x1,%dil
    3043:	75 1f                	jne    3064 <e3+0x104>
    3045:	48 8d 3c 32          	lea    (%rdx,%rsi,1),%rdi
    3049:	8b 54 32 20          	mov    0x20(%rdx,%rsi,1),%edx
    304d:	48 0f af ca          	imul   %rdx,%rcx
    3051:	48 c1 e9 20          	shr    $0x20,%rcx
    3055:	48 01 f9             	add    %rdi,%rcx
    3058:	48 81 c1 28 02 00 00 	add    $0x228,%rcx
    305f:	80 39 00             	cmpb   $0x0,(%rcx)
    3062:	75 02                	jne    3066 <e3+0x106>
    3064:	59                   	pop    %rcx
    3065:	c3                   	ret
    3066:	e8 65 0d 00 00       	call   3dd0 <fwp_flush>
    306b:	48 8b 05 6e 8f 00 00 	mov    0x8f6e(%rip),%rax        # bfe0 <stderr@GLIBC_2.2.5>
    3072:	48 8b 38             	mov    (%rax),%rdi
    3075:	48 8d 35 3c 61 00 00 	lea    0x613c(%rip),%rsi        # 91b8 <_IO_stdin_used+0x1b8>
    307c:	48 8d 15 08 61 00 00 	lea    0x6108(%rip),%rdx        # 918b <_IO_stdin_used+0x18b>
    3083:	31 c0                	xor    %eax,%eax
    3085:	e8 c6 f0 ff ff       	call   2150 <fprintf@plt>
    308a:	bf 65 00 00 00       	mov    $0x65,%edi
    308f:	e8 8c f1 ff ff       	call   2220 <exit@plt>
    3094:	66 66 66 2e 0f 1f 84 	data16 data16 cs nopw 0x0(%rax,%rax,1)
    309b:	00 00 00 00 00 

00000000000030a0 <e6>:
    30a0:	50                   	push   %rax
    30a1:	48 8b 37             	mov    (%rdi),%rsi
    30a4:	48 8b 0d c5 a0 00 00 	mov    0xa0c5(%rip),%rcx        # d170 <fwp_gc+0x1030>
    30ab:	48 89 f0             	mov    %rsi,%rax
    30ae:	48 29 c8             	sub    %rcx,%rax
    30b1:	48 8b 15 e0 a0 00 00 	mov    0xa0e0(%rip),%rdx        # d198 <fwp_gc+0x1058>
    30b8:	48 c1 e2 10          	shl    $0x10,%rdx
    30bc:	48 39 d0             	cmp    %rdx,%rax
    30bf:	73 65                	jae    3126 <e6+0x86>
    30c1:	48 8b 3d f0 a0 00 00 	mov    0xa0f0(%rip),%rdi        # d1b8 <fwp_gc+0x1078>
    30c8:	49 89 c0             	mov    %rax,%r8
    30cb:	49 c1 e8 10          	shr    $0x10,%r8
    30cf:	4d 69 c0 28 12 00 00 	imul   $0x1228,%r8,%r8
    30d6:	46 0f b6 0c 07       	movzbl (%rdi,%r8,1),%r9d
    30db:	48 25 ff ff 00 00    	and    $0xffff,%rax
    30e1:	75 1a                	jne    30fd <e6+0x5d>
    30e3:	41 80 f9 02          	cmp    $0x2,%r9b
    30e7:	75 14                	jne    30fd <e6+0x5d>
    30e9:	4a 8d 04 07          	lea    (%rdi,%r8,1),%rax
    30ed:	48 05 28 02 00 00    	add    $0x228,%rax
    30f3:	80 38 00             	cmpb   $0x0,(%rax)
    30f6:	74 2e                	je     3126 <e6+0x86>
    30f8:	e9 ab 00 00 00       	jmp    31a8 <e6+0x108>
    30fd:	41 80 f9 01          	cmp    $0x1,%r9b
    3101:	75 23                	jne    3126 <e6+0x86>
    3103:	4e 8d 0c 07          	lea    (%rdi,%r8,1),%r9
    3107:	42 8b 7c 07 20       	mov    0x20(%rdi,%r8,1),%edi
    310c:	48 0f af c7          	imul   %rdi,%rax
    3110:	48 c1 e8 20          	shr    $0x20,%rax
    3114:	4c 01 c8             	add    %r9,%rax
    3117:	48 05 28 02 00 00    	add    $0x228,%rax
    311d:	80 38 00             	cmpb   $0x0,(%rax)
    3120:	0f 85 82 00 00 00    	jne    31a8 <e6+0x108>
    3126:	31 c0                	xor    %eax,%eax
    3128:	48 85 f6             	test   %rsi,%rsi
    312b:	74 0f                	je     313c <e6+0x9c>
    312d:	0f 1f 00             	nopl   (%rax)
    3130:	48 ff c0             	inc    %rax
    3133:	48 8b 76 10          	mov    0x10(%rsi),%rsi
    3137:	48 85 f6             	test   %rsi,%rsi
    313a:	75 f4                	jne    3130 <e6+0x90>
    313c:	48 89 c6             	mov    %rax,%rsi
    313f:	48 29 ce             	sub    %rcx,%rsi
    3142:	48 39 d6             	cmp    %rdx,%rsi
    3145:	73 5f                	jae    31a6 <e6+0x106>
    3147:	48 8b 0d 6a a0 00 00 	mov    0xa06a(%rip),%rcx        # d1b8 <fwp_gc+0x1078>
    314e:	48 89 f2             	mov    %rsi,%rdx
    3151:	48 c1 ea 10          	shr    $0x10,%rdx
    3155:	48 69 d2 28 12 00 00 	imul   $0x1228,%rdx,%rdx
    315c:	0f b6 3c 11          	movzbl (%rcx,%rdx,1),%edi
    3160:	48 81 e6 ff ff 00 00 	and    $0xffff,%rsi
    3167:	75 17                	jne    3180 <e6+0xe0>
    3169:	40 80 ff 02          	cmp    $0x2,%dil
    316d:	75 11                	jne    3180 <e6+0xe0>
    316f:	48 01 d1             	add    %rdx,%rcx
    3172:	48 81 c1 28 02 00 00 	add    $0x228,%rcx
    3179:	80 39 00             	cmpb   $0x0,(%rcx)
    317c:	74 28                	je     31a6 <e6+0x106>
    317e:	eb 28                	jmp    31a8 <e6+0x108>
    3180:	40 80 ff 01          	cmp    $0x1,%dil
    3184:	75 20                	jne    31a6 <e6+0x106>
    3186:	48 8d 3c 11          	lea    (%rcx,%rdx,1),%rdi
    318a:	8b 4c 11 20          	mov    0x20(%rcx,%rdx,1),%ecx
    318e:	48 0f af f1          	imul   %rcx,%rsi
    3192:	48 c1 ee 20          	shr    $0x20,%rsi
    3196:	48 8d 0c 3e          	lea    (%rsi,%rdi,1),%rcx
    319a:	48 81 c1 28 02 00 00 	add    $0x228,%rcx
    31a1:	80 39 00             	cmpb   $0x0,(%rcx)
    31a4:	75 02                	jne    31a8 <e6+0x108>
    31a6:	59                   	pop    %rcx
    31a7:	c3                   	ret
    31a8:	e8 23 0c 00 00       	call   3dd0 <fwp_flush>
    31ad:	48 8b 05 2c 8e 00 00 	mov    0x8e2c(%rip),%rax        # bfe0 <stderr@GLIBC_2.2.5>
    31b4:	48 8b 38             	mov    (%rax),%rdi
    31b7:	48 8d 35 fa 5f 00 00 	lea    0x5ffa(%rip),%rsi        # 91b8 <_IO_stdin_used+0x1b8>
    31be:	48 8d 15 c6 5f 00 00 	lea    0x5fc6(%rip),%rdx        # 918b <_IO_stdin_used+0x18b>
    31c5:	31 c0                	xor    %eax,%eax
    31c7:	e8 84 ef ff ff       	call   2150 <fprintf@plt>
    31cc:	bf 65 00 00 00       	mov    $0x65,%edi
    31d1:	e8 4a f0 ff ff       	call   2220 <exit@plt>
    31d6:	66 2e 0f 1f 84 00 00 	cs nopw 0x0(%rax,%rax,1)
    31dd:	00 00 00 

00000000000031e0 <e8>:
    31e0:	50                   	push   %rax
    31e1:	48 8b 3f             	mov    (%rdi),%rdi
    31e4:	e8 e7 3d 00 00       	call   6fd0 <f8>
    31e9:	48 89 c1             	mov    %rax,%rcx
    31ec:	48 2b 0d 7d 9f 00 00 	sub    0x9f7d(%rip),%rcx        # d170 <fwp_gc+0x1030>
    31f3:	48 8b 15 9e 9f 00 00 	mov    0x9f9e(%rip),%rdx        # d198 <fwp_gc+0x1058>
    31fa:	48 c1 e2 10          	shl    $0x10,%rdx
    31fe:	48 39 d1             	cmp    %rdx,%rcx
    3201:	73 5f                	jae    3262 <e8+0x82>
    3203:	48 8b 15 ae 9f 00 00 	mov    0x9fae(%rip),%rdx        # d1b8 <fwp_gc+0x1078>
    320a:	48 89 ce             	mov    %rcx,%rsi
    320d:	48 c1 ee 10          	shr    $0x10,%rsi
    3211:	48 69 f6 28 12 00 00 	imul   $0x1228,%rsi,%rsi
    3218:	0f b6 3c 32          	movzbl (%rdx,%rsi,1),%edi
    321c:	48 81 e1 ff ff 00 00 	and    $0xffff,%rcx
    3223:	75 18                	jne    323d <e8+0x5d>
    3225:	40 80 ff 02          	cmp    $0x2,%dil
    3229:	75 12                	jne    323d <e8+0x5d>
    322b:	48 8d 0c 32          	lea    (%rdx,%rsi,1),%rcx
    322f:	48 81 c1 28 02 00 00 	add    $0x228,%rcx
    3236:	80 39 00             	cmpb   $0x0,(%rcx)
    3239:	74 27                	je     3262 <e8+0x82>
    323b:	eb 27                	jmp    3264 <e8+0x84>
    323d:	40 80 ff 01          	cmp    $0x1,%dil
    3241:	75 1f                	jne    3262 <e8+0x82>
    3243:	48 8d 3c 32          	lea    (%rdx,%rsi,1),%rdi
    3247:	8b 54 32 20          	mov    0x20(%rdx,%rsi,1),%edx
    324b:	48 0f af ca          	imul   %rdx,%rcx
    324f:	48 c1 e9 20          	shr    $0x20,%rcx
    3253:	48 01 f9             	add    %rdi,%rcx
    3256:	48 81 c1 28 02 00 00 	add    $0x228,%rcx
    325d:	80 39 00             	cmpb   $0x0,(%rcx)
    3260:	75 02                	jne    3264 <e8+0x84>
    3262:	59                   	pop    %rcx
    3263:	c3                   	ret
    3264:	e8 67 0b 00 00       	call   3dd0 <fwp_flush>
    3269:	48 8b 05 70 8d 00 00 	mov    0x8d70(%rip),%rax        # bfe0 <stderr@GLIBC_2.2.5>
    3270:	48 8b 38             	mov    (%rax),%rdi
    3273:	48 8d 35 3e 5f 00 00 	lea    0x5f3e(%rip),%rsi        # 91b8 <_IO_stdin_used+0x1b8>
    327a:	48 8d 15 0a 5f 00 00 	lea    0x5f0a(%rip),%rdx        # 918b <_IO_stdin_used+0x18b>
    3281:	31 c0                	xor    %eax,%eax
    3283:	e8 c8 ee ff ff       	call   2150 <fprintf@plt>
    3288:	bf 65 00 00 00       	mov    $0x65,%edi
    328d:	e8 8e ef ff ff       	call   2220 <exit@plt>
    3292:	66 66 66 66 66 2e 0f 	data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    3299:	1f 84 00 00 00 00 00 

00000000000032a0 <e9>:
    32a0:	50                   	push   %rax
    32a1:	48 8b 3f             	mov    (%rdi),%rdi
    32a4:	48 89 f8             	mov    %rdi,%rax
    32a7:	48 2b 05 c2 9e 00 00 	sub    0x9ec2(%rip),%rax        # d170 <fwp_gc+0x1030>
    32ae:	48 8b 0d e3 9e 00 00 	mov    0x9ee3(%rip),%rcx        # d198 <fwp_gc+0x1058>
    32b5:	48 c1 e1 10          	shl    $0x10,%rcx
    32b9:	48 39 c8             	cmp    %rcx,%rax
    32bc:	73 63                	jae    3321 <e9+0x81>
    32be:	48 8b 0d f3 9e 00 00 	mov    0x9ef3(%rip),%rcx        # d1b8 <fwp_gc+0x1078>
    32c5:	48 89 c2             	mov    %rax,%rdx
    32c8:	48 c1 ea 10          	shr    $0x10,%rdx
    32cc:	48 69 d2 28 12 00 00 	imul   $0x1228,%rdx,%rdx
    32d3:	0f b6 34 11          	movzbl (%rcx,%rdx,1),%esi
    32d7:	48 25 ff ff 00 00    	and    $0xffff,%rax
    32dd:	75 1a                	jne    32f9 <e9+0x59>
    32df:	40 80 fe 02          	cmp    $0x2,%sil
    32e3:	75 14                	jne    32f9 <e9+0x59>
    32e5:	48 8d 04 11          	lea    (%rcx,%rdx,1),%rax
    32e9:	48 05 28 02 00 00    	add    $0x228,%rax
    32ef:	80 38 00             	cmpb   $0x0,(%rax)
    32f2:	74 2d                	je     3321 <e9+0x81>
    32f4:	e9 ca 00 00 00       	jmp    33c3 <e9+0x123>
    32f9:	40 80 fe 01          	cmp    $0x1,%sil
    32fd:	75 22                	jne    3321 <e9+0x81>
    32ff:	48 8d 34 11          	lea    (%rcx,%rdx,1),%rsi
    3303:	8b 4c 11 20          	mov    0x20(%rcx,%rdx,1),%ecx
    3307:	48 0f af c1          	imul   %rcx,%rax
    330b:	48 c1 e8 20          	shr    $0x20,%rax
    330f:	48 01 f0             	add    %rsi,%rax
    3312:	48 05 28 02 00 00    	add    $0x228,%rax
    3318:	80 38 00             	cmpb   $0x0,(%rax)
    331b:	0f 85 a2 00 00 00    	jne    33c3 <e9+0x123>
    3321:	48 8b 17             	mov    (%rdi),%rdx
    3324:	48 83 c7 08          	add    $0x8,%rdi
    3328:	48 8b 0d b9 a8 00 00 	mov    0xa8b9(%rip),%rcx        # dbe8 <fwp_prog_out>
    332f:	be 01 00 00 00       	mov    $0x1,%esi
    3334:	e8 f7 ee ff ff       	call   2230 <fwrite@plt>
    3339:	48 8b 35 a8 a8 00 00 	mov    0xa8a8(%rip),%rsi        # dbe8 <fwp_prog_out>
    3340:	bf 0a 00 00 00       	mov    $0xa,%edi
    3345:	e8 a6 ed ff ff       	call   20f0 <fputc@plt>
    334a:	31 c0                	xor    %eax,%eax
    334c:	48 2b 05 1d 9e 00 00 	sub    0x9e1d(%rip),%rax        # d170 <fwp_gc+0x1030>
    3353:	48 8b 0d 3e 9e 00 00 	mov    0x9e3e(%rip),%rcx        # d198 <fwp_gc+0x1058>
    335a:	48 c1 e1 10          	shl    $0x10,%rcx
    335e:	48 39 c1             	cmp    %rax,%rcx
    3361:	76 5c                	jbe    33bf <e9+0x11f>
    3363:	48 8b 0d 4e 9e 00 00 	mov    0x9e4e(%rip),%rcx        # d1b8 <fwp_gc+0x1078>
    336a:	48 89 c2             	mov    %rax,%rdx
    336d:	48 c1 ea 10          	shr    $0x10,%rdx
    3371:	48 69 d2 28 12 00 00 	imul   $0x1228,%rdx,%rdx
    3378:	0f b6 34 11          	movzbl (%rcx,%rdx,1),%esi
    337c:	48 25 ff ff 00 00    	and    $0xffff,%rax
    3382:	75 17                	jne    339b <e9+0xfb>
    3384:	40 80 fe 02          	cmp    $0x2,%sil
    3388:	75 11                	jne    339b <e9+0xfb>
    338a:	48 8d 04 11          	lea    (%rcx,%rdx,1),%rax
    338e:	48 05 28 02 00 00    	add    $0x228,%rax
    3394:	80 38 00             	cmpb   $0x0,(%rax)
    3397:	74 26                	je     33bf <e9+0x11f>
    3399:	eb 28                	jmp    33c3 <e9+0x123>
    339b:	40 80 fe 01          	cmp    $0x1,%sil
    339f:	75 1e                	jne    33bf <e9+0x11f>
    33a1:	48 8d 34 11          	lea    (%rcx,%rdx,1),%rsi
    33a5:	8b 4c 11 20          	mov    0x20(%rcx,%rdx,1),%ecx
    33a9:	48 0f af c1          	imul   %rcx,%rax
    33ad:	48 c1 e8 20          	shr    $0x20,%rax
    33b1:	48 01 f0             	add    %rsi,%rax
    33b4:	48 05 28 02 00 00    	add    $0x228,%rax
    33ba:	80 38 00             	cmpb   $0x0,(%rax)
    33bd:	75 04                	jne    33c3 <e9+0x123>
    33bf:	31 c0                	xor    %eax,%eax
    33c1:	59                   	pop    %rcx
    33c2:	c3                   	ret
    33c3:	e8 08 0a 00 00       	call   3dd0 <fwp_flush>
    33c8:	48 8b 05 11 8c 00 00 	mov    0x8c11(%rip),%rax        # bfe0 <stderr@GLIBC_2.2.5>
    33cf:	48 8b 38             	mov    (%rax),%rdi
    33d2:	48 8d 35 df 5d 00 00 	lea    0x5ddf(%rip),%rsi        # 91b8 <_IO_stdin_used+0x1b8>
    33d9:	48 8d 15 ab 5d 00 00 	lea    0x5dab(%rip),%rdx        # 918b <_IO_stdin_used+0x18b>
    33e0:	31 c0                	xor    %eax,%eax
    33e2:	e8 69 ed ff ff       	call   2150 <fprintf@plt>
    33e7:	bf 65 00 00 00       	mov    $0x65,%edi
    33ec:	e8 2f ee ff ff       	call   2220 <exit@plt>
    33f1:	66 66 66 66 66 66 2e 	data16 data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    33f8:	0f 1f 84 00 00 00 00 
    33ff:	00 

0000000000003400 <e15>:
    3400:	48 8b 4f 08          	mov    0x8(%rdi),%rcx
    3404:	31 c0                	xor    %eax,%eax
    3406:	48 3b 0f             	cmp    (%rdi),%rcx
    3409:	0f 94 c0             	sete   %al
    340c:	48 89 c1             	mov    %rax,%rcx
    340f:	48 2b 0d 5a 9d 00 00 	sub    0x9d5a(%rip),%rcx        # d170 <fwp_gc+0x1030>
    3416:	48 8b 15 7b 9d 00 00 	mov    0x9d7b(%rip),%rdx        # d198 <fwp_gc+0x1058>
    341d:	48 c1 e2 10          	shl    $0x10,%rdx
    3421:	48 39 d1             	cmp    %rdx,%rcx
    3424:	73 5f                	jae    3485 <e15+0x85>
    3426:	48 8b 15 8b 9d 00 00 	mov    0x9d8b(%rip),%rdx        # d1b8 <fwp_gc+0x1078>
    342d:	48 89 ce             	mov    %rcx,%rsi
    3430:	48 c1 ee 10          	shr    $0x10,%rsi
    3434:	48 69 f6 28 12 00 00 	imul   $0x1228,%rsi,%rsi
    343b:	0f b6 3c 32          	movzbl (%rdx,%rsi,1),%edi
    343f:	48 81 e1 ff ff 00 00 	and    $0xffff,%rcx
    3446:	75 18                	jne    3460 <e15+0x60>
    3448:	40 80 ff 02          	cmp    $0x2,%dil
    344c:	75 12                	jne    3460 <e15+0x60>
    344e:	48 8d 0c 32          	lea    (%rdx,%rsi,1),%rcx
    3452:	48 81 c1 28 02 00 00 	add    $0x228,%rcx
    3459:	80 39 00             	cmpb   $0x0,(%rcx)
    345c:	74 27                	je     3485 <e15+0x85>
    345e:	eb 26                	jmp    3486 <e15+0x86>
    3460:	40 80 ff 01          	cmp    $0x1,%dil
    3464:	75 1f                	jne    3485 <e15+0x85>
    3466:	48 8d 3c 32          	lea    (%rdx,%rsi,1),%rdi
    346a:	8b 54 32 20          	mov    0x20(%rdx,%rsi,1),%edx
    346e:	48 0f af ca          	imul   %rdx,%rcx
    3472:	48 c1 e9 20          	shr    $0x20,%rcx
    3476:	48 01 f9             	add    %rdi,%rcx
    3479:	48 81 c1 28 02 00 00 	add    $0x228,%rcx
    3480:	80 39 00             	cmpb   $0x0,(%rcx)
    3483:	75 01                	jne    3486 <e15+0x86>
    3485:	c3                   	ret
    3486:	50                   	push   %rax
    3487:	e8 44 09 00 00       	call   3dd0 <fwp_flush>
    348c:	48 8b 05 4d 8b 00 00 	mov    0x8b4d(%rip),%rax        # bfe0 <stderr@GLIBC_2.2.5>
    3493:	48 8b 38             	mov    (%rax),%rdi
    3496:	48 8d 35 1b 5d 00 00 	lea    0x5d1b(%rip),%rsi        # 91b8 <_IO_stdin_used+0x1b8>
    349d:	48 8d 15 e7 5c 00 00 	lea    0x5ce7(%rip),%rdx        # 918b <_IO_stdin_used+0x18b>
    34a4:	31 c0                	xor    %eax,%eax
    34a6:	e8 a5 ec ff ff       	call   2150 <fprintf@plt>
    34ab:	bf 65 00 00 00       	mov    $0x65,%edi
    34b0:	e8 6b ed ff ff       	call   2220 <exit@plt>
    34b5:	66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
    34bc:	00 00 00 00 

00000000000034c0 <e20>:
    34c0:	50                   	push   %rax
    34c1:	48 8b 77 08          	mov    0x8(%rdi),%rsi
    34c5:	48 89 f0             	mov    %rsi,%rax
    34c8:	48 2b 05 a1 9c 00 00 	sub    0x9ca1(%rip),%rax        # d170 <fwp_gc+0x1030>
    34cf:	48 8b 0d c2 9c 00 00 	mov    0x9cc2(%rip),%rcx        # d198 <fwp_gc+0x1058>
    34d6:	48 c1 e1 10          	shl    $0x10,%rcx
    34da:	48 39 c8             	cmp    %rcx,%rax
    34dd:	73 64                	jae    3543 <e20+0x83>
    34df:	48 8b 0d d2 9c 00 00 	mov    0x9cd2(%rip),%rcx        # d1b8 <fwp_gc+0x1078>
    34e6:	48 89 c2             	mov    %rax,%rdx
    34e9:	48 c1 ea 10          	shr    $0x10,%rdx
    34ed:	48 69 d2 28 12 00 00 	imul   $0x1228,%rdx,%rdx
    34f4:	44 0f b6 04 11       	movzbl (%rcx,%rdx,1),%r8d
    34f9:	48 25 ff ff 00 00    	and    $0xffff,%rax
    34ff:	75 1a                	jne    351b <e20+0x5b>
    3501:	41 80 f8 02          	cmp    $0x2,%r8b
    3505:	75 14                	jne    351b <e20+0x5b>
    3507:	48 8d 04 11          	lea    (%rcx,%rdx,1),%rax
    350b:	48 05 28 02 00 00    	add    $0x228,%rax
    3511:	80 38 00             	cmpb   $0x0,(%rax)
    3514:	74 2d                	je     3543 <e20+0x83>
    3516:	e9 ab 00 00 00       	jmp    35c6 <e20+0x106>
    351b:	41 80 f8 01          	cmp    $0x1,%r8b
    351f:	75 22                	jne    3543 <e20+0x83>
    3521:	4c 8d 04 11          	lea    (%rcx,%rdx,1),%r8
    3525:	8b 4c 11 20          	mov    0x20(%rcx,%rdx,1),%ecx
    3529:	48 0f af c1          	imul   %rcx,%rax
    352d:	48 c1 e8 20          	shr    $0x20,%rax
    3531:	4c 01 c0             	add    %r8,%rax
    3534:	48 05 28 02 00 00    	add    $0x228,%rax
    353a:	80 38 00             	cmpb   $0x0,(%rax)
    353d:	0f 85 83 00 00 00    	jne    35c6 <e20+0x106>
    3543:	48 8b 3f             	mov    (%rdi),%rdi
    3546:	e8 75 35 00 00       	call   6ac0 <f20>
    354b:	48 89 c1             	mov    %rax,%rcx
    354e:	48 2b 0d 1b 9c 00 00 	sub    0x9c1b(%rip),%rcx        # d170 <fwp_gc+0x1030>
    3555:	48 8b 15 3c 9c 00 00 	mov    0x9c3c(%rip),%rdx        # d198 <fwp_gc+0x1058>
    355c:	48 c1 e2 10          	shl    $0x10,%rdx
    3560:	48 39 d1             	cmp    %rdx,%rcx
    3563:	73 5f                	jae    35c4 <e20+0x104>
    3565:	48 8b 15 4c 9c 00 00 	mov    0x9c4c(%rip),%rdx        # d1b8 <fwp_gc+0x1078>
    356c:	48 89 ce             	mov    %rcx,%rsi
    356f:	48 c1 ee 10          	shr    $0x10,%rsi
    3573:	48 69 f6 28 12 00 00 	imul   $0x1228,%rsi,%rsi
    357a:	0f b6 3c 32          	movzbl (%rdx,%rsi,1),%edi
    357e:	48 81 e1 ff ff 00 00 	and    $0xffff,%rcx
    3585:	75 18                	jne    359f <e20+0xdf>
    3587:	40 80 ff 02          	cmp    $0x2,%dil
    358b:	75 12                	jne    359f <e20+0xdf>
    358d:	48 8d 0c 32          	lea    (%rdx,%rsi,1),%rcx
    3591:	48 81 c1 28 02 00 00 	add    $0x228,%rcx
    3598:	80 39 00             	cmpb   $0x0,(%rcx)
    359b:	74 27                	je     35c4 <e20+0x104>
    359d:	eb 27                	jmp    35c6 <e20+0x106>
    359f:	40 80 ff 01          	cmp    $0x1,%dil
    35a3:	75 1f                	jne    35c4 <e20+0x104>
    35a5:	48 8d 3c 32          	lea    (%rdx,%rsi,1),%rdi
    35a9:	8b 54 32 20          	mov    0x20(%rdx,%rsi,1),%edx
    35ad:	48 0f af ca          	imul   %rdx,%rcx
    35b1:	48 c1 e9 20          	shr    $0x20,%rcx
    35b5:	48 01 f9             	add    %rdi,%rcx
    35b8:	48 81 c1 28 02 00 00 	add    $0x228,%rcx
    35bf:	80 39 00             	cmpb   $0x0,(%rcx)
    35c2:	75 02                	jne    35c6 <e20+0x106>
    35c4:	59                   	pop    %rcx
    35c5:	c3                   	ret
    35c6:	e8 05 08 00 00       	call   3dd0 <fwp_flush>
    35cb:	48 8b 05 0e 8a 00 00 	mov    0x8a0e(%rip),%rax        # bfe0 <stderr@GLIBC_2.2.5>
    35d2:	48 8b 38             	mov    (%rax),%rdi
    35d5:	48 8d 35 dc 5b 00 00 	lea    0x5bdc(%rip),%rsi        # 91b8 <_IO_stdin_used+0x1b8>
    35dc:	48 8d 15 a8 5b 00 00 	lea    0x5ba8(%rip),%rdx        # 918b <_IO_stdin_used+0x18b>
    35e3:	31 c0                	xor    %eax,%eax
    35e5:	e8 66 eb ff ff       	call   2150 <fprintf@plt>
    35ea:	bf 65 00 00 00       	mov    $0x65,%edi
    35ef:	e8 2c ec ff ff       	call   2220 <exit@plt>
    35f4:	66 66 66 2e 0f 1f 84 	data16 data16 cs nopw 0x0(%rax,%rax,1)
    35fb:	00 00 00 00 00 

0000000000003600 <e22>:
    3600:	50                   	push   %rax
    3601:	48 89 f8             	mov    %rdi,%rax
    3604:	48 8b 3f             	mov    (%rdi),%rdi
    3607:	48 8b 0d 62 9b 00 00 	mov    0x9b62(%rip),%rcx        # d170 <fwp_gc+0x1030>
    360e:	48 89 fe             	mov    %rdi,%rsi
    3611:	48 29 ce             	sub    %rcx,%rsi
    3614:	48 8b 15 7d 9b 00 00 	mov    0x9b7d(%rip),%rdx        # d198 <fwp_gc+0x1058>
    361b:	48 c1 e2 10          	shl    $0x10,%rdx
    361f:	48 39 d6             	cmp    %rdx,%rsi
    3622:	73 68                	jae    368c <e22+0x8c>
    3624:	4c 8b 05 8d 9b 00 00 	mov    0x9b8d(%rip),%r8        # d1b8 <fwp_gc+0x1078>
    362b:	49 89 f1             	mov    %rsi,%r9
    362e:	49 c1 e9 10          	shr    $0x10,%r9
    3632:	4d 69 c9 28 12 00 00 	imul   $0x1228,%r9,%r9
    3639:	47 0f b6 14 08       	movzbl (%r8,%r9,1),%r10d
    363e:	48 81 e6 ff ff 00 00 	and    $0xffff,%rsi
    3645:	75 1b                	jne    3662 <e22+0x62>
    3647:	41 80 fa 02          	cmp    $0x2,%r10b
    364b:	75 15                	jne    3662 <e22+0x62>
    364d:	4b 8d 34 08          	lea    (%r8,%r9,1),%rsi
    3651:	48 81 c6 28 02 00 00 	add    $0x228,%rsi
    3658:	80 3e 00             	cmpb   $0x0,(%rsi)
    365b:	74 2f                	je     368c <e22+0x8c>
    365d:	e9 1d 01 00 00       	jmp    377f <e22+0x17f>
    3662:	41 80 fa 01          	cmp    $0x1,%r10b
    3666:	75 24                	jne    368c <e22+0x8c>
    3668:	4f 8d 14 08          	lea    (%r8,%r9,1),%r10
    366c:	47 8b 44 08 20       	mov    0x20(%r8,%r9,1),%r8d
    3671:	49 0f af f0          	imul   %r8,%rsi
    3675:	48 c1 ee 20          	shr    $0x20,%rsi
    3679:	4c 01 d6             	add    %r10,%rsi
    367c:	48 81 c6 28 02 00 00 	add    $0x228,%rsi
    3683:	80 3e 00             	cmpb   $0x0,(%rsi)
    3686:	0f 85 f3 00 00 00    	jne    377f <e22+0x17f>
    368c:	48 8b 70 08          	mov    0x8(%rax),%rsi
    3690:	48 89 f0             	mov    %rsi,%rax
    3693:	48 29 c8             	sub    %rcx,%rax
    3696:	48 39 d0             	cmp    %rdx,%rax
    3699:	73 64                	jae    36ff <e22+0xff>
    369b:	48 8b 0d 16 9b 00 00 	mov    0x9b16(%rip),%rcx        # d1b8 <fwp_gc+0x1078>
    36a2:	48 89 c2             	mov    %rax,%rdx
    36a5:	48 c1 ea 10          	shr    $0x10,%rdx
    36a9:	48 69 d2 28 12 00 00 	imul   $0x1228,%rdx,%rdx
    36b0:	44 0f b6 04 11       	movzbl (%rcx,%rdx,1),%r8d
    36b5:	48 25 ff ff 00 00    	and    $0xffff,%rax
    36bb:	75 1a                	jne    36d7 <e22+0xd7>
    36bd:	41 80 f8 02          	cmp    $0x2,%r8b
    36c1:	75 14                	jne    36d7 <e22+0xd7>
    36c3:	48 8d 04 11          	lea    (%rcx,%rdx,1),%rax
    36c7:	48 05 28 02 00 00    	add    $0x228,%rax
    36cd:	80 38 00             	cmpb   $0x0,(%rax)
    36d0:	74 2d                	je     36ff <e22+0xff>
    36d2:	e9 a8 00 00 00       	jmp    377f <e22+0x17f>
    36d7:	41 80 f8 01          	cmp    $0x1,%r8b
    36db:	75 22                	jne    36ff <e22+0xff>
    36dd:	4c 8d 04 11          	lea    (%rcx,%rdx,1),%r8
    36e1:	8b 4c 11 20          	mov    0x20(%rcx,%rdx,1),%ecx
    36e5:	48 0f af c1          	imul   %rcx,%rax
    36e9:	48 c1 e8 20          	shr    $0x20,%rax
    36ed:	4c 01 c0             	add    %r8,%rax
    36f0:	48 05 28 02 00 00    	add    $0x228,%rax
    36f6:	80 38 00             	cmpb   $0x0,(%rax)
    36f9:	0f 85 80 00 00 00    	jne    377f <e22+0x17f>
    36ff:	e8 9c 3a 00 00       	call   71a0 <f22>
    3704:	48 89 c1             	mov    %rax,%rcx
    3707:	48 2b 0d 62 9a 00 00 	sub    0x9a62(%rip),%rcx        # d170 <fwp_gc+0x1030>
    370e:	48 8b 15 83 9a 00 00 	mov    0x9a83(%rip),%rdx        # d198 <fwp_gc+0x1058>
    3715:	48 c1 e2 10          	shl    $0x10,%rdx
    3719:	48 39 d1             	cmp    %rdx,%rcx
    371c:	73 5f                	jae    377d <e22+0x17d>
    371e:	48 8b 15 93 9a 00 00 	mov    0x9a93(%rip),%rdx        # d1b8 <fwp_gc+0x1078>
    3725:	48 89 ce             	mov    %rcx,%rsi
    3728:	48 c1 ee 10          	shr    $0x10,%rsi
    372c:	48 69 f6 28 12 00 00 	imul   $0x1228,%rsi,%rsi
    3733:	0f b6 3c 32          	movzbl (%rdx,%rsi,1),%edi
    3737:	48 81 e1 ff ff 00 00 	and    $0xffff,%rcx
    373e:	75 18                	jne    3758 <e22+0x158>
    3740:	40 80 ff 02          	cmp    $0x2,%dil
    3744:	75 12                	jne    3758 <e22+0x158>
    3746:	48 8d 0c 32          	lea    (%rdx,%rsi,1),%rcx
    374a:	48 81 c1 28 02 00 00 	add    $0x228,%rcx
    3751:	80 39 00             	cmpb   $0x0,(%rcx)
    3754:	74 27                	je     377d <e22+0x17d>
    3756:	eb 27                	jmp    377f <e22+0x17f>
    3758:	40 80 ff 01          	cmp    $0x1,%dil
    375c:	75 1f                	jne    377d <e22+0x17d>
    375e:	48 8d 3c 32          	lea    (%rdx,%rsi,1),%rdi
    3762:	8b 54 32 20          	mov    0x20(%rdx,%rsi,1),%edx
    3766:	48 0f af ca          	imul   %rdx,%rcx
    376a:	48 c1 e9 20          	shr    $0x20,%rcx
    376e:	48 01 f9             	add    %rdi,%rcx
    3771:	48 81 c1 28 02 00 00 	add    $0x228,%rcx
    3778:	80 39 00             	cmpb   $0x0,(%rcx)
    377b:	75 02                	jne    377f <e22+0x17f>
    377d:	59                   	pop    %rcx
    377e:	c3                   	ret
    377f:	e8 4c 06 00 00       	call   3dd0 <fwp_flush>
    3784:	48 8b 05 55 88 00 00 	mov    0x8855(%rip),%rax        # bfe0 <stderr@GLIBC_2.2.5>
    378b:	48 8b 38             	mov    (%rax),%rdi
    378e:	48 8d 35 23 5a 00 00 	lea    0x5a23(%rip),%rsi        # 91b8 <_IO_stdin_used+0x1b8>
    3795:	48 8d 15 ef 59 00 00 	lea    0x59ef(%rip),%rdx        # 918b <_IO_stdin_used+0x18b>
    379c:	31 c0                	xor    %eax,%eax
    379e:	e8 ad e9 ff ff       	call   2150 <fprintf@plt>
    37a3:	bf 65 00 00 00       	mov    $0x65,%edi
    37a8:	e8 73 ea ff ff       	call   2220 <exit@plt>
    37ad:	0f 1f 00             	nopl   (%rax)

00000000000037b0 <e24>:
    37b0:	48 83 ec 18          	sub    $0x18,%rsp
    37b4:	48 89 f8             	mov    %rdi,%rax
    37b7:	48 8b 3f             	mov    (%rdi),%rdi
    37ba:	48 8b 0d af 99 00 00 	mov    0x99af(%rip),%rcx        # d170 <fwp_gc+0x1030>
    37c1:	48 89 fe             	mov    %rdi,%rsi
    37c4:	48 29 ce             	sub    %rcx,%rsi
    37c7:	48 8b 15 ca 99 00 00 	mov    0x99ca(%rip),%rdx        # d198 <fwp_gc+0x1058>
    37ce:	48 c1 e2 10          	shl    $0x10,%rdx
    37d2:	48 39 d6             	cmp    %rdx,%rsi
    37d5:	73 68                	jae    383f <e24+0x8f>
    37d7:	4c 8b 05 da 99 00 00 	mov    0x99da(%rip),%r8        # d1b8 <fwp_gc+0x1078>
    37de:	49 89 f1             	mov    %rsi,%r9
    37e1:	49 c1 e9 10          	shr    $0x10,%r9
    37e5:	4d 69 c9 28 12 00 00 	imul   $0x1228,%r9,%r9
    37ec:	47 0f b6 14 08       	movzbl (%r8,%r9,1),%r10d
    37f1:	48 81 e6 ff ff 00 00 	and    $0xffff,%rsi
    37f8:	75 1b                	jne    3815 <e24+0x65>
    37fa:	41 80 fa 02          	cmp    $0x2,%r10b
    37fe:	75 15                	jne    3815 <e24+0x65>
    3800:	4b 8d 34 08          	lea    (%r8,%r9,1),%rsi
    3804:	48 81 c6 28 02 00 00 	add    $0x228,%rsi
    380b:	80 3e 00             	cmpb   $0x0,(%rsi)
    380e:	74 2f                	je     383f <e24+0x8f>
    3810:	e9 b0 01 00 00       	jmp    39c5 <e24+0x215>
    3815:	41 80 fa 01          	cmp    $0x1,%r10b
    3819:	75 24                	jne    383f <e24+0x8f>
    381b:	4f 8d 14 08          	lea    (%r8,%r9,1),%r10
    381f:	47 8b 44 08 20       	mov    0x20(%r8,%r9,1),%r8d
    3824:	49 0f af f0          	imul   %r8,%rsi
    3828:	48 c1 ee 20          	shr    $0x20,%rsi
    382c:	4c 01 d6             	add    %r10,%rsi
    382f:	48 81 c6 28 02 00 00 	add    $0x228,%rsi
    3836:	80 3e 00             	cmpb   $0x0,(%rsi)
    3839:	0f 85 86 01 00 00    	jne    39c5 <e24+0x215>
    383f:	48 8b 70 08          	mov    0x8(%rax),%rsi
    3843:	49 89 f0             	mov    %rsi,%r8
    3846:	49 29 c8             	sub    %rcx,%r8
    3849:	49 39 d0             	cmp    %rdx,%r8
    384c:	73 6a                	jae    38b8 <e24+0x108>
    384e:	4c 8b 0d 63 99 00 00 	mov    0x9963(%rip),%r9        # d1b8 <fwp_gc+0x1078>
    3855:	4d 89 c2             	mov    %r8,%r10
    3858:	49 c1 ea 10          	shr    $0x10,%r10
    385c:	4d 69 d2 28 12 00 00 	imul   $0x1228,%r10,%r10
    3863:	47 0f b6 1c 11       	movzbl (%r9,%r10,1),%r11d
    3868:	49 81 e0 ff ff 00 00 	and    $0xffff,%r8
    386f:	75 1c                	jne    388d <e24+0xdd>
    3871:	41 80 fb 02          	cmp    $0x2,%r11b
    3875:	75 16                	jne    388d <e24+0xdd>
    3877:	4f 8d 04 11          	lea    (%r9,%r10,1),%r8
    387b:	49 81 c0 28 02 00 00 	add    $0x228,%r8
    3882:	41 80 38 00          	cmpb   $0x0,(%r8)
    3886:	74 30                	je     38b8 <e24+0x108>
    3888:	e9 38 01 00 00       	jmp    39c5 <e24+0x215>
    388d:	41 80 fb 01          	cmp    $0x1,%r11b
    3891:	75 25                	jne    38b8 <e24+0x108>
    3893:	4f 8d 1c 11          	lea    (%r9,%r10,1),%r11
    3897:	47 8b 4c 11 20       	mov    0x20(%r9,%r10,1),%r9d
    389c:	4d 0f af c1          	imul   %r9,%r8
    38a0:	49 c1 e8 20          	shr    $0x20,%r8
    38a4:	4d 01 d8             	add    %r11,%r8
    38a7:	49 81 c0 28 02 00 00 	add    $0x228,%r8
    38ae:	41 80 38 00          	cmpb   $0x0,(%r8)
    38b2:	0f 85 0d 01 00 00    	jne    39c5 <e24+0x215>
    38b8:	48 8b 40 10          	mov    0x10(%rax),%rax
    38bc:	49 89 c0             	mov    %rax,%r8
    38bf:	49 29 c8             	sub    %rcx,%r8
    38c2:	49 39 d0             	cmp    %rdx,%r8
    38c5:	73 67                	jae    392e <e24+0x17e>
    38c7:	48 8b 0d ea 98 00 00 	mov    0x98ea(%rip),%rcx        # d1b8 <fwp_gc+0x1078>
    38ce:	4c 89 c2             	mov    %r8,%rdx
    38d1:	48 c1 ea 10          	shr    $0x10,%rdx
    38d5:	48 69 d2 28 12 00 00 	imul   $0x1228,%rdx,%rdx
    38dc:	44 0f b6 0c 11       	movzbl (%rcx,%rdx,1),%r9d
    38e1:	49 81 e0 ff ff 00 00 	and    $0xffff,%r8
    38e8:	75 1a                	jne    3904 <e24+0x154>
    38ea:	41 80 f9 02          	cmp    $0x2,%r9b
    38ee:	75 14                	jne    3904 <e24+0x154>
    38f0:	48 01 d1             	add    %rdx,%rcx
    38f3:	48 81 c1 28 02 00 00 	add    $0x228,%rcx
    38fa:	80 39 00             	cmpb   $0x0,(%rcx)
    38fd:	74 2f                	je     392e <e24+0x17e>
    38ff:	e9 c1 00 00 00       	jmp    39c5 <e24+0x215>
    3904:	41 80 f9 01          	cmp    $0x1,%r9b
    3908:	75 24                	jne    392e <e24+0x17e>
    390a:	4c 8d 0c 11          	lea    (%rcx,%rdx,1),%r9
    390e:	8b 4c 11 20          	mov    0x20(%rcx,%rdx,1),%ecx
    3912:	4c 0f af c1          	imul   %rcx,%r8
    3916:	49 c1 e8 20          	shr    $0x20,%r8
    391a:	4b 8d 0c 08          	lea    (%r8,%r9,1),%rcx
    391e:	48 81 c1 28 02 00 00 	add    $0x228,%rcx
    3925:	80 39 00             	cmpb   $0x0,(%rcx)
    3928:	0f 85 97 00 00 00    	jne    39c5 <e24+0x215>
    392e:	48 89 44 24 08       	mov    %rax,0x8(%rsp)
    3933:	48 89 74 24 10       	mov    %rsi,0x10(%rsp)
    3938:	48 8d 54 24 08       	lea    0x8(%rsp),%rdx
    393d:	be 02 00 00 00       	mov    $0x2,%esi
    3942:	e8 89 1e 00 00       	call   57d0 <fwp_apply_owned>
    3947:	48 89 c1             	mov    %rax,%rcx
    394a:	48 2b 0d 1f 98 00 00 	sub    0x981f(%rip),%rcx        # d170 <fwp_gc+0x1030>
    3951:	48 8b 15 40 98 00 00 	mov    0x9840(%rip),%rdx        # d198 <fwp_gc+0x1058>
    3958:	48 c1 e2 10          	shl    $0x10,%rdx
    395c:	48 39 d1             	cmp    %rdx,%rcx
    395f:	73 5f                	jae    39c0 <e24+0x210>
    3961:	48 8b 15 50 98 00 00 	mov    0x9850(%rip),%rdx        # d1b8 <fwp_gc+0x1078>
    3968:	48 89 ce             	mov    %rcx,%rsi
    396b:	48 c1 ee 10          	shr    $0x10,%rsi
    396f:	48 69 f6 28 12 00 00 	imul   $0x1228,%rsi,%rsi
    3976:	0f b6 3c 32          	movzbl (%rdx,%rsi,1),%edi
    397a:	48 81 e1 ff ff 00 00 	and    $0xffff,%rcx
    3981:	75 18                	jne    399b <e24+0x1eb>
    3983:	40 80 ff 02          	cmp    $0x2,%dil
    3987:	75 12                	jne    399b <e24+0x1eb>
    3989:	48 8d 0c 32          	lea    (%rdx,%rsi,1),%rcx
    398d:	48 81 c1 28 02 00 00 	add    $0x228,%rcx
    3994:	80 39 00             	cmpb   $0x0,(%rcx)
    3997:	74 27                	je     39c0 <e24+0x210>
    3999:	eb 2a                	jmp    39c5 <e24+0x215>
    399b:	40 80 ff 01          	cmp    $0x1,%dil
    399f:	75 1f                	jne    39c0 <e24+0x210>
    39a1:	48 8d 3c 32          	lea    (%rdx,%rsi,1),%rdi
    39a5:	8b 54 32 20          	mov    0x20(%rdx,%rsi,1),%edx
    39a9:	48 0f af ca          	imul   %rdx,%rcx
    39ad:	48 c1 e9 20          	shr    $0x20,%rcx
    39b1:	48 01 f9             	add    %rdi,%rcx
    39b4:	48 81 c1 28 02 00 00 	add    $0x228,%rcx
    39bb:	80 39 00             	cmpb   $0x0,(%rcx)
    39be:	75 05                	jne    39c5 <e24+0x215>
    39c0:	48 83 c4 18          	add    $0x18,%rsp
    39c4:	c3                   	ret
    39c5:	e8 06 04 00 00       	call   3dd0 <fwp_flush>
    39ca:	48 8b 05 0f 86 00 00 	mov    0x860f(%rip),%rax        # bfe0 <stderr@GLIBC_2.2.5>
    39d1:	48 8b 38             	mov    (%rax),%rdi
    39d4:	48 8d 35 dd 57 00 00 	lea    0x57dd(%rip),%rsi        # 91b8 <_IO_stdin_used+0x1b8>
    39db:	48 8d 15 a9 57 00 00 	lea    0x57a9(%rip),%rdx        # 918b <_IO_stdin_used+0x18b>
    39e2:	31 c0                	xor    %eax,%eax
    39e4:	e8 67 e7 ff ff       	call   2150 <fprintf@plt>
    39e9:	bf 65 00 00 00       	mov    $0x65,%edi
    39ee:	e8 2d e8 ff ff       	call   2220 <exit@plt>
    39f3:	66 66 66 66 2e 0f 1f 	data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    39fa:	84 00 00 00 00 00 

0000000000003a00 <e25>:
    3a00:	53                   	push   %rbx
    3a01:	48 83 ec 60          	sub    $0x60,%rsp
    3a05:	48 8b 47 08          	mov    0x8(%rdi),%rax
    3a09:	48 03 07             	add    (%rdi),%rax
    3a0c:	70 7f                	jo     3a8d <e25+0x8d>
    3a0e:	48 89 c1             	mov    %rax,%rcx
    3a11:	48 2b 0d 58 97 00 00 	sub    0x9758(%rip),%rcx        # d170 <fwp_gc+0x1030>
    3a18:	48 8b 15 79 97 00 00 	mov    0x9779(%rip),%rdx        # d198 <fwp_gc+0x1058>
    3a1f:	48 c1 e2 10          	shl    $0x10,%rdx
    3a23:	48 39 d1             	cmp    %rdx,%rcx
    3a26:	73 5f                	jae    3a87 <e25+0x87>
    3a28:	48 8b 15 89 97 00 00 	mov    0x9789(%rip),%rdx        # d1b8 <fwp_gc+0x1078>
    3a2f:	48 89 ce             	mov    %rcx,%rsi
    3a32:	48 c1 ee 10          	shr    $0x10,%rsi
    3a36:	48 69 f6 28 12 00 00 	imul   $0x1228,%rsi,%rsi
    3a3d:	0f b6 3c 32          	movzbl (%rdx,%rsi,1),%edi
    3a41:	48 81 e1 ff ff 00 00 	and    $0xffff,%rcx
    3a48:	75 18                	jne    3a62 <e25+0x62>
    3a4a:	40 80 ff 02          	cmp    $0x2,%dil
    3a4e:	75 12                	jne    3a62 <e25+0x62>
    3a50:	48 8d 0c 32          	lea    (%rdx,%rsi,1),%rcx
    3a54:	48 81 c1 28 02 00 00 	add    $0x228,%rcx
    3a5b:	80 39 00             	cmpb   $0x0,(%rcx)
    3a5e:	74 27                	je     3a87 <e25+0x87>
    3a60:	eb 66                	jmp    3ac8 <e25+0xc8>
    3a62:	40 80 ff 01          	cmp    $0x1,%dil
    3a66:	75 1f                	jne    3a87 <e25+0x87>
    3a68:	48 8d 3c 32          	lea    (%rdx,%rsi,1),%rdi
    3a6c:	8b 54 32 20          	mov    0x20(%rdx,%rsi,1),%edx
    3a70:	48 0f af ca          	imul   %rdx,%rcx
    3a74:	48 c1 e9 20          	shr    $0x20,%rcx
    3a78:	48 01 f9             	add    %rdi,%rcx
    3a7b:	48 81 c1 28 02 00 00 	add    $0x228,%rcx
    3a82:	80 39 00             	cmpb   $0x0,(%rcx)
    3a85:	75 41                	jne    3ac8 <e25+0xc8>
    3a87:	48 83 c4 60          	add    $0x60,%rsp
    3a8b:	5b                   	pop    %rbx
    3a8c:	c3                   	ret
    3a8d:	48 8d 15 1e 59 00 00 	lea    0x591e(%rip),%rdx        # 93b2 <_IO_stdin_used+0x3b2>
    3a94:	48 8d 0d 13 59 00 00 	lea    0x5913(%rip),%rcx        # 93ae <_IO_stdin_used+0x3ae>
    3a9b:	48 89 e3             	mov    %rsp,%rbx
    3a9e:	be 60 00 00 00       	mov    $0x60,%esi
    3aa3:	48 89 df             	mov    %rbx,%rdi
    3aa6:	31 c0                	xor    %eax,%eax
    3aa8:	e8 23 e6 ff ff       	call   20d0 <snprintf@plt>
    3aad:	e8 1e 03 00 00       	call   3dd0 <fwp_flush>
    3ab2:	48 8b 05 27 85 00 00 	mov    0x8527(%rip),%rax        # bfe0 <stderr@GLIBC_2.2.5>
    3ab9:	48 8b 38             	mov    (%rax),%rdi
    3abc:	48 8d 35 f5 56 00 00 	lea    0x56f5(%rip),%rsi        # 91b8 <_IO_stdin_used+0x1b8>
    3ac3:	48 89 da             	mov    %rbx,%rdx
    3ac6:	eb 1d                	jmp    3ae5 <e25+0xe5>
    3ac8:	e8 03 03 00 00       	call   3dd0 <fwp_flush>
    3acd:	48 8b 05 0c 85 00 00 	mov    0x850c(%rip),%rax        # bfe0 <stderr@GLIBC_2.2.5>
    3ad4:	48 8b 38             	mov    (%rax),%rdi
    3ad7:	48 8d 35 da 56 00 00 	lea    0x56da(%rip),%rsi        # 91b8 <_IO_stdin_used+0x1b8>
    3ade:	48 8d 15 a6 56 00 00 	lea    0x56a6(%rip),%rdx        # 918b <_IO_stdin_used+0x18b>
    3ae5:	31 c0                	xor    %eax,%eax
    3ae7:	e8 64 e6 ff ff       	call   2150 <fprintf@plt>
    3aec:	bf 65 00 00 00       	mov    $0x65,%edi
    3af1:	e8 2a e7 ff ff       	call   2220 <exit@plt>
    3af6:	66 2e 0f 1f 84 00 00 	cs nopw 0x0(%rax,%rax,1)
    3afd:	00 00 00 

0000000000003b00 <e26>:
    3b00:	50                   	push   %rax
    3b01:	48 8b 07             	mov    (%rdi),%rax
    3b04:	48 8b 77 08          	mov    0x8(%rdi),%rsi
    3b08:	48 89 c7             	mov    %rax,%rdi
    3b0b:	e8 00 2f 00 00       	call   6a10 <f26>
    3b10:	48 89 c1             	mov    %rax,%rcx
    3b13:	48 2b 0d 56 96 00 00 	sub    0x9656(%rip),%rcx        # d170 <fwp_gc+0x1030>
    3b1a:	48 8b 15 77 96 00 00 	mov    0x9677(%rip),%rdx        # d198 <fwp_gc+0x1058>
    3b21:	48 c1 e2 10          	shl    $0x10,%rdx
    3b25:	48 39 d1             	cmp    %rdx,%rcx
    3b28:	73 5f                	jae    3b89 <e26+0x89>
    3b2a:	48 8b 15 87 96 00 00 	mov    0x9687(%rip),%rdx        # d1b8 <fwp_gc+0x1078>
    3b31:	48 89 ce             	mov    %rcx,%rsi
    3b34:	48 c1 ee 10          	shr    $0x10,%rsi
    3b38:	48 69 f6 28 12 00 00 	imul   $0x1228,%rsi,%rsi
    3b3f:	0f b6 3c 32          	movzbl (%rdx,%rsi,1),%edi
    3b43:	48 81 e1 ff ff 00 00 	and    $0xffff,%rcx
    3b4a:	75 18                	jne    3b64 <e26+0x64>
    3b4c:	40 80 ff 02          	cmp    $0x2,%dil
    3b50:	75 12                	jne    3b64 <e26+0x64>
    3b52:	48 8d 0c 32          	lea    (%rdx,%rsi,1),%rcx
    3b56:	48 81 c1 28 02 00 00 	add    $0x228,%rcx
    3b5d:	80 39 00             	cmpb   $0x0,(%rcx)
    3b60:	74 27                	je     3b89 <e26+0x89>
    3b62:	eb 27                	jmp    3b8b <e26+0x8b>
    3b64:	40 80 ff 01          	cmp    $0x1,%dil
    3b68:	75 1f                	jne    3b89 <e26+0x89>
    3b6a:	48 8d 3c 32          	lea    (%rdx,%rsi,1),%rdi
    3b6e:	8b 54 32 20          	mov    0x20(%rdx,%rsi,1),%edx
    3b72:	48 0f af ca          	imul   %rdx,%rcx
    3b76:	48 c1 e9 20          	shr    $0x20,%rcx
    3b7a:	48 01 f9             	add    %rdi,%rcx
    3b7d:	48 81 c1 28 02 00 00 	add    $0x228,%rcx
    3b84:	80 39 00             	cmpb   $0x0,(%rcx)
    3b87:	75 02                	jne    3b8b <e26+0x8b>
    3b89:	59                   	pop    %rcx
    3b8a:	c3                   	ret
    3b8b:	e8 40 02 00 00       	call   3dd0 <fwp_flush>
    3b90:	48 8b 05 49 84 00 00 	mov    0x8449(%rip),%rax        # bfe0 <stderr@GLIBC_2.2.5>
    3b97:	48 8b 38             	mov    (%rax),%rdi
    3b9a:	48 8d 35 17 56 00 00 	lea    0x5617(%rip),%rsi        # 91b8 <_IO_stdin_used+0x1b8>
    3ba1:	48 8d 15 e3 55 00 00 	lea    0x55e3(%rip),%rdx        # 918b <_IO_stdin_used+0x18b>
    3ba8:	31 c0                	xor    %eax,%eax
    3baa:	e8 a1 e5 ff ff       	call   2150 <fprintf@plt>
    3baf:	bf 65 00 00 00       	mov    $0x65,%edi
    3bb4:	e8 67 e6 ff ff       	call   2220 <exit@plt>
    3bb9:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)

0000000000003bc0 <e27>:
    3bc0:	50                   	push   %rax
    3bc1:	48 8b 3f             	mov    (%rdi),%rdi
    3bc4:	e8 f7 45 00 00       	call   81c0 <f27>
    3bc9:	48 89 c1             	mov    %rax,%rcx
    3bcc:	48 2b 0d 9d 95 00 00 	sub    0x959d(%rip),%rcx        # d170 <fwp_gc+0x1030>
    3bd3:	48 8b 15 be 95 00 00 	mov    0x95be(%rip),%rdx        # d198 <fwp_gc+0x1058>
    3bda:	48 c1 e2 10          	shl    $0x10,%rdx
    3bde:	48 39 d1             	cmp    %rdx,%rcx
    3be1:	73 5f                	jae    3c42 <e27+0x82>
    3be3:	48 8b 15 ce 95 00 00 	mov    0x95ce(%rip),%rdx        # d1b8 <fwp_gc+0x1078>
    3bea:	48 89 ce             	mov    %rcx,%rsi
    3bed:	48 c1 ee 10          	shr    $0x10,%rsi
    3bf1:	48 69 f6 28 12 00 00 	imul   $0x1228,%rsi,%rsi
    3bf8:	0f b6 3c 32          	movzbl (%rdx,%rsi,1),%edi
    3bfc:	48 81 e1 ff ff 00 00 	and    $0xffff,%rcx
    3c03:	75 18                	jne    3c1d <e27+0x5d>
    3c05:	40 80 ff 02          	cmp    $0x2,%dil
    3c09:	75 12                	jne    3c1d <e27+0x5d>
    3c0b:	48 8d 0c 32          	lea    (%rdx,%rsi,1),%rcx
    3c0f:	48 81 c1 28 02 00 00 	add    $0x228,%rcx
    3c16:	80 39 00             	cmpb   $0x0,(%rcx)
    3c19:	74 27                	je     3c42 <e27+0x82>
    3c1b:	eb 27                	jmp    3c44 <e27+0x84>
    3c1d:	40 80 ff 01          	cmp    $0x1,%dil
    3c21:	75 1f                	jne    3c42 <e27+0x82>
    3c23:	48 8d 3c 32          	lea    (%rdx,%rsi,1),%rdi
    3c27:	8b 54 32 20          	mov    0x20(%rdx,%rsi,1),%edx
    3c2b:	48 0f af ca          	imul   %rdx,%rcx
    3c2f:	48 c1 e9 20          	shr    $0x20,%rcx
    3c33:	48 01 f9             	add    %rdi,%rcx
    3c36:	48 81 c1 28 02 00 00 	add    $0x228,%rcx
    3c3d:	80 39 00             	cmpb   $0x0,(%rcx)
    3c40:	75 02                	jne    3c44 <e27+0x84>
    3c42:	59                   	pop    %rcx
    3c43:	c3                   	ret
    3c44:	e8 87 01 00 00       	call   3dd0 <fwp_flush>
    3c49:	48 8b 05 90 83 00 00 	mov    0x8390(%rip),%rax        # bfe0 <stderr@GLIBC_2.2.5>
    3c50:	48 8b 38             	mov    (%rax),%rdi
    3c53:	48 8d 35 5e 55 00 00 	lea    0x555e(%rip),%rsi        # 91b8 <_IO_stdin_used+0x1b8>
    3c5a:	48 8d 15 2a 55 00 00 	lea    0x552a(%rip),%rdx        # 918b <_IO_stdin_used+0x18b>
    3c61:	31 c0                	xor    %eax,%eax
    3c63:	e8 e8 e4 ff ff       	call   2150 <fprintf@plt>
    3c68:	bf 65 00 00 00       	mov    $0x65,%edi
    3c6d:	e8 ae e5 ff ff       	call   2220 <exit@plt>
    3c72:	66 66 66 66 66 2e 0f 	data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    3c79:	1f 84 00 00 00 00 00 

0000000000003c80 <f1>:
    3c80:	55                   	push   %rbp
    3c81:	41 57                	push   %r15
    3c83:	41 56                	push   %r14
    3c85:	41 55                	push   %r13
    3c87:	41 54                	push   %r12
    3c89:	53                   	push   %rbx
    3c8a:	48 83 ec 28          	sub    $0x28,%rsp
    3c8e:	49 89 fd             	mov    %rdi,%r13
    3c91:	49 c1 fd 3f          	sar    $0x3f,%r13
    3c95:	48 89 f5             	mov    %rsi,%rbp
    3c98:	48 c1 fd 3f          	sar    $0x3f,%rbp
    3c9c:	48 39 f7             	cmp    %rsi,%rdi
    3c9f:	4c 89 e8             	mov    %r13,%rax
    3ca2:	48 19 e8             	sbb    %rbp,%rax
    3ca5:	0f 8d 14 01 00 00    	jge    3dbf <f1+0x13f>
    3cab:	48 89 f3             	mov    %rsi,%rbx
    3cae:	49 89 fe             	mov    %rdi,%r14
    3cb1:	31 c0                	xor    %eax,%eax
    3cb3:	49 bc 00 00 00 00 00 	movabs $0x8000000000000000,%r12
    3cba:	00 00 80 
    3cbd:	eb 35                	jmp    3cf4 <f1+0x74>
    3cbf:	90                   	nop
    3cc0:	4c 8d 24 32          	lea    (%rdx,%rsi,1),%r12
    3cc4:	49 81 c4 28 02 00 00 	add    $0x228,%r12
    3ccb:	41 80 3c 24 ff       	cmpb   $0xff,(%r12)
    3cd0:	0f 84 d2 00 00 00    	je     3da8 <f1+0x128>
    3cd6:	41 c6 04 24 01       	movb   $0x1,(%r12)
    3cdb:	49 bc 00 00 00 00 00 	movabs $0x8000000000000000,%r12
    3ce2:	00 00 80 
    3ce5:	49 39 de             	cmp    %rbx,%r14
    3ce8:	4c 89 e9             	mov    %r13,%rcx
    3ceb:	48 19 e9             	sbb    %rbp,%rcx
    3cee:	0f 8d cd 00 00 00    	jge    3dc1 <f1+0x141>
    3cf4:	48 83 c3 ff          	add    $0xffffffffffffffff,%rbx
    3cf8:	48 83 d5 ff          	adc    $0xffffffffffffffff,%rbp
    3cfc:	48 89 d9             	mov    %rbx,%rcx
    3cff:	4c 21 e1             	and    %r12,%rcx
    3d02:	4c 01 e1             	add    %r12,%rcx
    3d05:	48 89 e9             	mov    %rbp,%rcx
    3d08:	48 83 d1 ff          	adc    $0xffffffffffffffff,%rcx
    3d0c:	48 83 f9 ff          	cmp    $0xffffffffffffffff,%rcx
    3d10:	4c 0f 44 fb          	cmove  %rbx,%r15
    3d14:	4c 89 7c 24 10       	mov    %r15,0x10(%rsp)
    3d19:	48 89 44 24 18       	mov    %rax,0x18(%rsp)
    3d1e:	bf 01 00 00 00       	mov    $0x1,%edi
    3d23:	be 02 00 00 00       	mov    $0x2,%esi
    3d28:	48 8d 54 24 10       	lea    0x10(%rsp),%rdx
    3d2d:	e8 7e 01 00 00       	call   3eb0 <fwp_data>
    3d32:	48 89 c1             	mov    %rax,%rcx
    3d35:	48 2b 0d 34 94 00 00 	sub    0x9434(%rip),%rcx        # d170 <fwp_gc+0x1030>
    3d3c:	48 8b 15 55 94 00 00 	mov    0x9455(%rip),%rdx        # d198 <fwp_gc+0x1058>
    3d43:	48 c1 e2 10          	shl    $0x10,%rdx
    3d47:	48 39 d1             	cmp    %rdx,%rcx
    3d4a:	73 99                	jae    3ce5 <f1+0x65>
    3d4c:	48 8b 15 65 94 00 00 	mov    0x9465(%rip),%rdx        # d1b8 <fwp_gc+0x1078>
    3d53:	48 89 ce             	mov    %rcx,%rsi
    3d56:	48 c1 ee 10          	shr    $0x10,%rsi
    3d5a:	48 69 f6 28 12 00 00 	imul   $0x1228,%rsi,%rsi
    3d61:	0f b6 3c 32          	movzbl (%rdx,%rsi,1),%edi
    3d65:	48 81 e1 ff ff 00 00 	and    $0xffff,%rcx
    3d6c:	75 0a                	jne    3d78 <f1+0xf8>
    3d6e:	40 80 ff 02          	cmp    $0x2,%dil
    3d72:	0f 84 48 ff ff ff    	je     3cc0 <f1+0x40>
    3d78:	40 80 ff 01          	cmp    $0x1,%dil
    3d7c:	0f 85 63 ff ff ff    	jne    3ce5 <f1+0x65>
    3d82:	48 8d 3c 32          	lea    (%rdx,%rsi,1),%rdi
    3d86:	8b 54 32 20          	mov    0x20(%rdx,%rsi,1),%edx
    3d8a:	48 0f af ca          	imul   %rdx,%rcx
    3d8e:	48 c1 e9 20          	shr    $0x20,%rcx
    3d92:	4c 8d 24 39          	lea    (%rcx,%rdi,1),%r12
    3d96:	49 81 c4 28 02 00 00 	add    $0x228,%r12
    3d9d:	41 80 3c 24 ff       	cmpb   $0xff,(%r12)
    3da2:	0f 85 2e ff ff ff    	jne    3cd6 <f1+0x56>
    3da8:	4c 89 e7             	mov    %r12,%rdi
    3dab:	48 89 44 24 08       	mov    %rax,0x8(%rsp)
    3db0:	e8 4b 00 00 00       	call   3e00 <fwp_rc_forget_slot>
    3db5:	48 8b 44 24 08       	mov    0x8(%rsp),%rax
    3dba:	e9 17 ff ff ff       	jmp    3cd6 <f1+0x56>
    3dbf:	31 c0                	xor    %eax,%eax
    3dc1:	48 83 c4 28          	add    $0x28,%rsp
    3dc5:	5b                   	pop    %rbx
    3dc6:	41 5c                	pop    %r12
    3dc8:	41 5d                	pop    %r13
    3dca:	41 5e                	pop    %r14
    3dcc:	41 5f                	pop    %r15
    3dce:	5d                   	pop    %rbp
    3dcf:	c3                   	ret

0000000000003dd0 <fwp_flush>:
    3dd0:	50                   	push   %rax
    3dd1:	48 8b 3d 10 9e 00 00 	mov    0x9e10(%rip),%rdi        # dbe8 <fwp_prog_out>
    3dd8:	48 85 ff             	test   %rdi,%rdi
    3ddb:	74 05                	je     3de2 <fwp_flush+0x12>
    3ddd:	e8 be e3 ff ff       	call   21a0 <fflush@plt>
    3de2:	48 8b 05 d7 81 00 00 	mov    0x81d7(%rip),%rax        # bfc0 <stdout@GLIBC_2.2.5>
    3de9:	48 8b 38             	mov    (%rax),%rdi
    3dec:	58                   	pop    %rax
    3ded:	e9 ae e3 ff ff       	jmp    21a0 <fflush@plt>
    3df2:	66 66 66 66 66 2e 0f 	data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    3df9:	1f 84 00 00 00 00 00 

0000000000003e00 <fwp_rc_forget_slot>:
    3e00:	50                   	push   %rax
    3e01:	80 3f ff             	cmpb   $0xff,(%rdi)
    3e04:	74 02                	je     3e08 <fwp_rc_forget_slot+0x8>
    3e06:	58                   	pop    %rax
    3e07:	c3                   	ret
    3e08:	48 89 f8             	mov    %rdi,%rax
    3e0b:	48 c1 e8 11          	shr    $0x11,%rax
    3e0f:	31 f8                	xor    %edi,%eax
    3e11:	89 c1                	mov    %eax,%ecx
    3e13:	c1 e9 09             	shr    $0x9,%ecx
    3e16:	31 c1                	xor    %eax,%ecx
    3e18:	0f b6 c9             	movzbl %cl,%ecx
    3e1b:	48 8d 15 1e 83 00 00 	lea    0x831e(%rip),%rdx        # c140 <fwp_gc>
    3e22:	48 8b 84 ca 18 12 00 	mov    0x1218(%rdx,%rcx,8),%rax
    3e29:	00 
    3e2a:	48 85 c0             	test   %rax,%rax
    3e2d:	74 4b                	je     3e7a <fwp_rc_forget_slot+0x7a>
    3e2f:	48 39 38             	cmp    %rdi,(%rax)
    3e32:	74 23                	je     3e57 <fwp_rc_forget_slot+0x57>
    3e34:	66 66 66 2e 0f 1f 84 	data16 data16 cs nopw 0x0(%rax,%rax,1)
    3e3b:	00 00 00 00 00 
    3e40:	48 89 c1             	mov    %rax,%rcx
    3e43:	48 8b 40 10          	mov    0x10(%rax),%rax
    3e47:	48 85 c0             	test   %rax,%rax
    3e4a:	74 2e                	je     3e7a <fwp_rc_forget_slot+0x7a>
    3e4c:	48 39 38             	cmp    %rdi,(%rax)
    3e4f:	75 ef                	jne    3e40 <fwp_rc_forget_slot+0x40>
    3e51:	48 83 c1 10          	add    $0x10,%rcx
    3e55:	eb 0b                	jmp    3e62 <fwp_rc_forget_slot+0x62>
    3e57:	48 8d 0c ca          	lea    (%rdx,%rcx,8),%rcx
    3e5b:	48 81 c1 18 12 00 00 	add    $0x1218,%rcx
    3e62:	48 8b 50 10          	mov    0x10(%rax),%rdx
    3e66:	48 89 11             	mov    %rdx,(%rcx)
    3e69:	48 89 c7             	mov    %rax,%rdi
    3e6c:	e8 df e1 ff ff       	call   2050 <free@plt>
    3e71:	48 ff 0d e0 9c 00 00 	decq   0x9ce0(%rip)        # db58 <fwp_gc+0x1a18>
    3e78:	58                   	pop    %rax
    3e79:	c3                   	ret
    3e7a:	e8 51 ff ff ff       	call   3dd0 <fwp_flush>
    3e7f:	48 8b 05 5a 81 00 00 	mov    0x815a(%rip),%rax        # bfe0 <stderr@GLIBC_2.2.5>
    3e86:	48 8b 38             	mov    (%rax),%rdi
    3e89:	48 8d 35 28 53 00 00 	lea    0x5328(%rip),%rsi        # 91b8 <_IO_stdin_used+0x1b8>
    3e90:	48 8d 15 30 53 00 00 	lea    0x5330(%rip),%rdx        # 91c7 <_IO_stdin_used+0x1c7>
    3e97:	31 c0                	xor    %eax,%eax
    3e99:	e8 b2 e2 ff ff       	call   2150 <fprintf@plt>
    3e9e:	bf 65 00 00 00       	mov    $0x65,%edi
    3ea3:	e8 78 e3 ff ff       	call   2220 <exit@plt>
    3ea8:	0f 1f 84 00 00 00 00 	nopl   0x0(%rax,%rax,1)
    3eaf:	00 

0000000000003eb0 <fwp_data>:
    3eb0:	55                   	push   %rbp
    3eb1:	41 57                	push   %r15
    3eb3:	41 56                	push   %r14
    3eb5:	41 55                	push   %r13
    3eb7:	41 54                	push   %r12
    3eb9:	53                   	push   %rbx
    3eba:	50                   	push   %rax
    3ebb:	48 89 d3             	mov    %rdx,%rbx
    3ebe:	89 f5                	mov    %esi,%ebp
    3ec0:	41 89 ff             	mov    %edi,%r15d
    3ec3:	41 89 f4             	mov    %esi,%r12d
    3ec6:	4e 8d 2c e5 00 00 00 	lea    0x0(,%r12,8),%r13
    3ecd:	00 
    3ece:	4a 8d 3c e5 08 00 00 	lea    0x8(,%r12,8),%rdi
    3ed5:	00 
    3ed6:	81 fe ff 07 00 00    	cmp    $0x7ff,%esi
    3edc:	0f 87 e6 00 00 00    	ja     3fc8 <fwp_data+0x118>
    3ee2:	49 8d 75 17          	lea    0x17(%r13),%rsi
    3ee6:	48 c1 ee 04          	shr    $0x4,%rsi
    3eea:	48 8d 05 4f 82 00 00 	lea    0x824f(%rip),%rax        # c140 <fwp_gc>
    3ef1:	0f b6 8c 06 e8 0b 00 	movzbl 0xbe8(%rsi,%rax,1),%ecx
    3ef8:	00 
    3ef9:	8b 94 88 48 0b 00 00 	mov    0xb48(%rax,%rcx,4),%edx
    3f00:	4c 8b 05 39 82 00 00 	mov    0x8239(%rip),%r8        # c140 <fwp_gc>
    3f07:	4d 89 c1             	mov    %r8,%r9
    3f0a:	49 29 d1             	sub    %rdx,%r9
    3f0d:	4c 89 0d 2c 82 00 00 	mov    %r9,0x822c(%rip)        # c140 <fwp_gc>
    3f14:	0f 88 ae 00 00 00    	js     3fc8 <fwp_data+0x118>
    3f1a:	4c 8d 0c 49          	lea    (%rcx,%rcx,2),%r9
    3f1e:	4e 8d 14 c8          	lea    (%rax,%r9,8),%r10
    3f22:	49 83 c2 08          	add    $0x8,%r10
    3f26:	4d 8b 32             	mov    (%r10),%r14
    3f29:	4d 85 f6             	test   %r14,%r14
    3f2c:	74 29                	je     3f57 <fwp_data+0xa7>
    3f2e:	49 8b 06             	mov    (%r14),%rax
    3f31:	48 f7 d0             	not    %rax
    3f34:	49 89 02             	mov    %rax,(%r10)
    3f37:	48 39 d7             	cmp    %rdx,%rdi
    3f3a:	0f 83 ad 00 00 00    	jae    3fed <fwp_data+0x13d>
    3f40:	4c 01 f7             	add    %r14,%rdi
    3f43:	4c 29 ea             	sub    %r13,%rdx
    3f46:	48 83 c2 f7          	add    $0xfffffffffffffff7,%rdx
    3f4a:	48 83 e2 f8          	and    $0xfffffffffffffff8,%rdx
    3f4e:	48 83 c2 08          	add    $0x8,%rdx
    3f52:	e9 8f 00 00 00       	jmp    3fe6 <fwp_data+0x136>
    3f57:	4e 8b 74 c8 10       	mov    0x10(%rax,%r9,8),%r14
    3f5c:	4e 8b 54 c8 18       	mov    0x18(%rax,%r9,8),%r10
    3f61:	4d 29 f2             	sub    %r14,%r10
    3f64:	49 39 d2             	cmp    %rdx,%r10
    3f67:	72 2f                	jb     3f98 <fwp_data+0xe8>
    3f69:	4a 8d 0c c8          	lea    (%rax,%r9,8),%rcx
    3f6d:	48 83 c1 10          	add    $0x10,%rcx
    3f71:	4d 8d 0c 16          	lea    (%r14,%rdx,1),%r9
    3f75:	4c 89 09             	mov    %r9,(%rcx)
    3f78:	4d 85 f6             	test   %r14,%r14
    3f7b:	75 ba                	jne    3f37 <fwp_data+0x87>
    3f7d:	0f b6 8c 06 e8 0b 00 	movzbl 0xbe8(%rsi,%rax,1),%ecx
    3f84:	00 
    3f85:	8b 94 88 48 0b 00 00 	mov    0xb48(%rax,%rcx,4),%edx
    3f8c:	49 29 d0             	sub    %rdx,%r8
    3f8f:	4c 89 05 aa 81 00 00 	mov    %r8,0x81aa(%rip)        # c140 <fwp_gc>
    3f96:	78 30                	js     3fc8 <fwp_data+0x118>
    3f98:	48 8d 0c 49          	lea    (%rcx,%rcx,2),%rcx
    3f9c:	4c 8b 74 c8 08       	mov    0x8(%rax,%rcx,8),%r14
    3fa1:	4d 85 f6             	test   %r14,%r14
    3fa4:	74 10                	je     3fb6 <fwp_data+0x106>
    3fa6:	48 8d 04 c8          	lea    (%rax,%rcx,8),%rax
    3faa:	48 83 c0 08          	add    $0x8,%rax
    3fae:	49 8b 0e             	mov    (%r14),%rcx
    3fb1:	48 f7 d1             	not    %rcx
    3fb4:	eb 2a                	jmp    3fe0 <fwp_data+0x130>
    3fb6:	4c 8b 74 c8 10       	mov    0x10(%rax,%rcx,8),%r14
    3fbb:	48 8b 74 c8 18       	mov    0x18(%rax,%rcx,8),%rsi
    3fc0:	4c 29 f6             	sub    %r14,%rsi
    3fc3:	48 39 d6             	cmp    %rdx,%rsi
    3fc6:	73 0c                	jae    3fd4 <fwp_data+0x124>
    3fc8:	31 f6                	xor    %esi,%esi
    3fca:	e8 01 01 00 00       	call   40d0 <fwp_gc_alloc_slow>
    3fcf:	49 89 c6             	mov    %rax,%r14
    3fd2:	eb 19                	jmp    3fed <fwp_data+0x13d>
    3fd4:	48 8d 04 c8          	lea    (%rax,%rcx,8),%rax
    3fd8:	48 83 c0 10          	add    $0x10,%rax
    3fdc:	49 8d 0c 16          	lea    (%r14,%rdx,1),%rcx
    3fe0:	48 89 08             	mov    %rcx,(%rax)
    3fe3:	4c 89 f7             	mov    %r14,%rdi
    3fe6:	31 f6                	xor    %esi,%esi
    3fe8:	e8 f3 e0 ff ff       	call   20e0 <memset@plt>
    3fed:	45 89 3e             	mov    %r15d,(%r14)
    3ff0:	41 89 6e 04          	mov    %ebp,0x4(%r14)
    3ff4:	85 ed                	test   %ebp,%ebp
    3ff6:	0f 84 bb 00 00 00    	je     40b7 <fwp_data+0x207>
    3ffc:	83 fd 08             	cmp    $0x8,%ebp
    3fff:	72 10                	jb     4011 <fwp_data+0x161>
    4001:	4c 89 f0             	mov    %r14,%rax
    4004:	48 29 d8             	sub    %rbx,%rax
    4007:	48 83 c0 08          	add    $0x8,%rax
    400b:	48 83 f8 20          	cmp    $0x20,%rax
    400f:	73 71                	jae    4082 <fwp_data+0x1d2>
    4011:	31 c0                	xor    %eax,%eax
    4013:	4c 89 e2             	mov    %r12,%rdx
    4016:	48 89 c1             	mov    %rax,%rcx
    4019:	48 83 e2 03          	and    $0x3,%rdx
    401d:	74 22                	je     4041 <fwp_data+0x191>
    401f:	48 89 c1             	mov    %rax,%rcx
    4022:	66 66 66 66 66 2e 0f 	data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    4029:	1f 84 00 00 00 00 00 
    4030:	48 8b 34 cb          	mov    (%rbx,%rcx,8),%rsi
    4034:	49 89 74 ce 08       	mov    %rsi,0x8(%r14,%rcx,8)
    4039:	48 ff c1             	inc    %rcx
    403c:	48 ff ca             	dec    %rdx
    403f:	75 ef                	jne    4030 <fwp_data+0x180>
    4041:	4c 29 e0             	sub    %r12,%rax
    4044:	48 83 f8 fc          	cmp    $0xfffffffffffffffc,%rax
    4048:	77 6d                	ja     40b7 <fwp_data+0x207>
    404a:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)
    4050:	48 8b 04 cb          	mov    (%rbx,%rcx,8),%rax
    4054:	49 89 44 ce 08       	mov    %rax,0x8(%r14,%rcx,8)
    4059:	48 8b 44 cb 08       	mov    0x8(%rbx,%rcx,8),%rax
    405e:	49 89 44 ce 10       	mov    %rax,0x10(%r14,%rcx,8)
    4063:	48 8b 44 cb 10       	mov    0x10(%rbx,%rcx,8),%rax
    4068:	49 89 44 ce 18       	mov    %rax,0x18(%r14,%rcx,8)
    406d:	48 8b 44 cb 18       	mov    0x18(%rbx,%rcx,8),%rax
    4072:	49 89 44 ce 20       	mov    %rax,0x20(%r14,%rcx,8)
    4077:	48 83 c1 04          	add    $0x4,%rcx
    407b:	49 39 cc             	cmp    %rcx,%r12
    407e:	75 d0                	jne    4050 <fwp_data+0x1a0>
    4080:	eb 35                	jmp    40b7 <fwp_data+0x207>
    4082:	44 89 e0             	mov    %r12d,%eax
    4085:	83 e0 fc             	and    $0xfffffffc,%eax
    4088:	49 83 e5 e0          	and    $0xffffffffffffffe0,%r13
    408c:	31 c9                	xor    %ecx,%ecx
    408e:	66 90                	xchg   %ax,%ax
    4090:	0f 10 04 0b          	movups (%rbx,%rcx,1),%xmm0
    4094:	0f 10 4c 0b 10       	movups 0x10(%rbx,%rcx,1),%xmm1
    4099:	41 0f 11 44 0e 08    	movups %xmm0,0x8(%r14,%rcx,1)
    409f:	41 0f 11 4c 0e 18    	movups %xmm1,0x18(%r14,%rcx,1)
    40a5:	48 83 c1 20          	add    $0x20,%rcx
    40a9:	49 39 cd             	cmp    %rcx,%r13
    40ac:	75 e2                	jne    4090 <fwp_data+0x1e0>
    40ae:	4c 39 e0             	cmp    %r12,%rax
    40b1:	0f 85 5c ff ff ff    	jne    4013 <fwp_data+0x163>
    40b7:	4c 89 f0             	mov    %r14,%rax
    40ba:	48 83 c4 08          	add    $0x8,%rsp
    40be:	5b                   	pop    %rbx
    40bf:	41 5c                	pop    %r12
    40c1:	41 5d                	pop    %r13
    40c3:	41 5e                	pop    %r14
    40c5:	41 5f                	pop    %r15
    40c7:	5d                   	pop    %rbp
    40c8:	c3                   	ret
    40c9:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)

00000000000040d0 <fwp_gc_alloc_slow>:
    40d0:	41 57                	push   %r15
    40d2:	41 56                	push   %r14
    40d4:	41 55                	push   %r13
    40d6:	41 54                	push   %r12
    40d8:	53                   	push   %rbx
    40d9:	89 f3                	mov    %esi,%ebx
    40db:	83 3d 4a 90 00 00 00 	cmpl   $0x0,0x904a(%rip)        # d12c <fwp_gc+0xfec>
    40e2:	74 19                	je     40fd <fwp_gc_alloc_slow+0x2d>
    40e4:	48 81 ff 01 40 00 00 	cmp    $0x4001,%rdi
    40eb:	72 24                	jb     4111 <fwp_gc_alloc_slow+0x41>
    40ed:	89 de                	mov    %ebx,%esi
    40ef:	5b                   	pop    %rbx
    40f0:	41 5c                	pop    %r12
    40f2:	41 5d                	pop    %r13
    40f4:	41 5e                	pop    %r14
    40f6:	41 5f                	pop    %r15
    40f8:	e9 33 06 00 00       	jmp    4730 <fwp_gc_alloc_big>
    40fd:	49 89 fe             	mov    %rdi,%r14
    4100:	e8 5b 01 00 00       	call   4260 <fwp_gc_init>
    4105:	4c 89 f7             	mov    %r14,%rdi
    4108:	48 81 ff 01 40 00 00 	cmp    $0x4001,%rdi
    410f:	73 dc                	jae    40ed <fwp_gc_alloc_slow+0x1d>
    4111:	48 8d 47 0f          	lea    0xf(%rdi),%rax
    4115:	48 c1 e8 04          	shr    $0x4,%rax
    4119:	4c 8d 3d 20 80 00 00 	lea    0x8020(%rip),%r15        # c140 <fwp_gc>
    4120:	46 0f b6 b4 38 e8 0b 	movzbl 0xbe8(%rax,%r15,1),%r14d
    4127:	00 00 
    4129:	43 8b 94 b7 48 0b 00 	mov    0xb48(%r15,%r14,4),%edx
    4130:	00 
    4131:	48 83 3d 07 80 00 00 	cmpq   $0x0,0x8007(%rip)        # c140 <fwp_gc>
    4138:	00 
    4139:	0f 89 8c 00 00 00    	jns    41cb <fwp_gc_alloc_slow+0xfb>
    413f:	83 3d e6 8f 00 00 00 	cmpl   $0x0,0x8fe6(%rip)        # d12c <fwp_gc+0xfec>
    4146:	75 11                	jne    4159 <fwp_gc_alloc_slow+0x89>
    4148:	49 89 fc             	mov    %rdi,%r12
    414b:	49 89 d5             	mov    %rdx,%r13
    414e:	e8 0d 01 00 00       	call   4260 <fwp_gc_init>
    4153:	4c 89 ea             	mov    %r13,%rdx
    4156:	4c 89 e7             	mov    %r12,%rdi
    4159:	8b 0d d5 8f 00 00    	mov    0x8fd5(%rip),%ecx        # d134 <fwp_gc+0xff4>
    415f:	85 c9                	test   %ecx,%ecx
    4161:	74 2a                	je     418d <fwp_gc_alloc_slow+0xbd>
    4163:	48 8b 05 f6 8f 00 00 	mov    0x8ff6(%rip),%rax        # d160 <fwp_gc+0x1020>
    416a:	48 85 c0             	test   %rax,%rax
    416d:	74 1e                	je     418d <fwp_gc_alloc_slow+0xbd>
    416f:	48 8b 0d f2 8f 00 00 	mov    0x8ff2(%rip),%rcx        # d168 <fwp_gc+0x1028>
    4176:	48 ff c1             	inc    %rcx
    4179:	48 89 0d e8 8f 00 00 	mov    %rcx,0x8fe8(%rip)        # d168 <fwp_gc+0x1028>
    4180:	48 39 c1             	cmp    %rax,%rcx
    4183:	0f 8d c7 00 00 00    	jge    4250 <fwp_gc_alloc_slow+0x180>
    4189:	31 c0                	xor    %eax,%eax
    418b:	eb 0d                	jmp    419a <fwp_gc_alloc_slow+0xca>
    418d:	b8 00 00 80 00       	mov    $0x800000,%eax
    4192:	85 c9                	test   %ecx,%ecx
    4194:	0f 85 b1 00 00 00    	jne    424b <fwp_gc_alloc_slow+0x17b>
    419a:	48 8b 0d af 91 00 00 	mov    0x91af(%rip),%rcx        # d350 <fwp_gc+0x1210>
    41a1:	48 2b 0d 98 7f 00 00 	sub    0x7f98(%rip),%rcx        # c140 <fwp_gc>
    41a8:	f2 48 0f 2a c1       	cvtsi2sd %rcx,%xmm0
    41ad:	f2 0f 58 05 73 91 00 	addsd  0x9173(%rip),%xmm0        # d328 <fwp_gc+0x11e8>
    41b4:	00 
    41b5:	f2 0f 11 05 6b 91 00 	movsd  %xmm0,0x916b(%rip)        # d328 <fwp_gc+0x11e8>
    41bc:	00 
    41bd:	48 89 05 8c 91 00 00 	mov    %rax,0x918c(%rip)        # d350 <fwp_gc+0x1210>
    41c4:	48 89 05 75 7f 00 00 	mov    %rax,0x7f75(%rip)        # c140 <fwp_gc>
    41cb:	89 d8                	mov    %ebx,%eax
    41cd:	48 69 c0 c0 03 00 00 	imul   $0x3c0,%rax,%rax
    41d4:	49 01 c7             	add    %rax,%r15
    41d7:	4b 8d 34 76          	lea    (%r14,%r14,2),%rsi
    41db:	49 8d 0c f7          	lea    (%r15,%rsi,8),%rcx
    41df:	48 83 c1 08          	add    $0x8,%rcx
    41e3:	49 8b 44 f7 08       	mov    0x8(%r15,%rsi,8),%rax
    41e8:	48 85 c0             	test   %rax,%rax
    41eb:	74 08                	je     41f5 <fwp_gc_alloc_slow+0x125>
    41ed:	48 8b 30             	mov    (%rax),%rsi
    41f0:	48 f7 d6             	not    %rsi
    41f3:	eb 39                	jmp    422e <fwp_gc_alloc_slow+0x15e>
    41f5:	49 8b 44 f7 10       	mov    0x10(%r15,%rsi,8),%rax
    41fa:	4d 8b 44 f7 18       	mov    0x18(%r15,%rsi,8),%r8
    41ff:	49 29 c0             	sub    %rax,%r8
    4202:	49 39 d0             	cmp    %rdx,%r8
    4205:	73 1b                	jae    4222 <fwp_gc_alloc_slow+0x152>
    4207:	49 89 ff             	mov    %rdi,%r15
    420a:	48 89 cf             	mov    %rcx,%rdi
    420d:	44 89 f6             	mov    %r14d,%esi
    4210:	49 89 d6             	mov    %rdx,%r14
    4213:	89 da                	mov    %ebx,%edx
    4215:	e8 46 07 00 00       	call   4960 <fwp_gc_refill>
    421a:	4c 89 f2             	mov    %r14,%rdx
    421d:	4c 89 ff             	mov    %r15,%rdi
    4220:	eb 0f                	jmp    4231 <fwp_gc_alloc_slow+0x161>
    4222:	49 8d 0c f7          	lea    (%r15,%rsi,8),%rcx
    4226:	48 83 c1 10          	add    $0x10,%rcx
    422a:	48 8d 34 10          	lea    (%rax,%rdx,1),%rsi
    422e:	48 89 31             	mov    %rsi,(%rcx)
    4231:	83 fb 01             	cmp    $0x1,%ebx
    4234:	48 0f 44 d7          	cmove  %rdi,%rdx
    4238:	48 89 c7             	mov    %rax,%rdi
    423b:	31 f6                	xor    %esi,%esi
    423d:	5b                   	pop    %rbx
    423e:	41 5c                	pop    %r12
    4240:	41 5d                	pop    %r13
    4242:	41 5e                	pop    %r14
    4244:	41 5f                	pop    %r15
    4246:	e9 95 de ff ff       	jmp    20e0 <memset@plt>
    424b:	e8 d0 09 00 00       	call   4c20 <fwp_gc_collect>
    4250:	48 c7 05 0d 8f 00 00 	movq   $0x0,0x8f0d(%rip)        # d168 <fwp_gc+0x1028>
    4257:	00 00 00 00 
    425b:	e8 c0 09 00 00       	call   4c20 <fwp_gc_collect>

0000000000004260 <fwp_gc_init>:
    4260:	41 56                	push   %r14
    4262:	53                   	push   %rbx
    4263:	50                   	push   %rax
    4264:	c7 05 be 8e 00 00 01 	movl   $0x1,0x8ebe(%rip)        # d12c <fwp_gc+0xfec>
    426b:	00 00 00 
    426e:	0f 28 05 9b 4d 00 00 	movaps 0x4d9b(%rip),%xmm0        # 9010 <_IO_stdin_used+0x10>
    4275:	0f 11 05 0c 8a 00 00 	movups %xmm0,0x8a0c(%rip)        # cc88 <fwp_gc+0xb48>
    427c:	0f 28 05 9d 4d 00 00 	movaps 0x4d9d(%rip),%xmm0        # 9020 <_IO_stdin_used+0x20>
    4283:	0f 11 05 0e 8a 00 00 	movups %xmm0,0x8a0e(%rip)        # cc98 <fwp_gc+0xb58>
    428a:	0f 28 05 9f 4d 00 00 	movaps 0x4d9f(%rip),%xmm0        # 9030 <_IO_stdin_used+0x30>
    4291:	0f 11 05 10 8a 00 00 	movups %xmm0,0x8a10(%rip)        # cca8 <fwp_gc+0xb68>
    4298:	0f 28 05 a1 4d 00 00 	movaps 0x4da1(%rip),%xmm0        # 9040 <_IO_stdin_used+0x40>
    429f:	0f 11 05 12 8a 00 00 	movups %xmm0,0x8a12(%rip)        # ccb8 <fwp_gc+0xb78>
    42a6:	0f 28 05 a3 4d 00 00 	movaps 0x4da3(%rip),%xmm0        # 9050 <_IO_stdin_used+0x50>
    42ad:	0f 11 05 14 8a 00 00 	movups %xmm0,0x8a14(%rip)        # ccc8 <fwp_gc+0xb88>
    42b4:	0f 28 05 a5 4d 00 00 	movaps 0x4da5(%rip),%xmm0        # 9060 <_IO_stdin_used+0x60>
    42bb:	0f 11 05 16 8a 00 00 	movups %xmm0,0x8a16(%rip)        # ccd8 <fwp_gc+0xb98>
    42c2:	0f 28 05 a7 4d 00 00 	movaps 0x4da7(%rip),%xmm0        # 9070 <_IO_stdin_used+0x70>
    42c9:	0f 11 05 18 8a 00 00 	movups %xmm0,0x8a18(%rip)        # cce8 <fwp_gc+0xba8>
    42d0:	0f 28 05 a9 4d 00 00 	movaps 0x4da9(%rip),%xmm0        # 9080 <_IO_stdin_used+0x80>
    42d7:	0f 11 05 1a 8a 00 00 	movups %xmm0,0x8a1a(%rip)        # ccf8 <fwp_gc+0xbb8>
    42de:	0f 28 05 ab 4d 00 00 	movaps 0x4dab(%rip),%xmm0        # 9090 <_IO_stdin_used+0x90>
    42e5:	0f 11 05 1c 8a 00 00 	movups %xmm0,0x8a1c(%rip)        # cd08 <fwp_gc+0xbc8>
    42ec:	0f 28 05 ad 4d 00 00 	movaps 0x4dad(%rip),%xmm0        # 90a0 <_IO_stdin_used+0xa0>
    42f3:	0f 11 05 1e 8a 00 00 	movups %xmm0,0x8a1e(%rip)        # cd18 <fwp_gc+0xbd8>
    42fa:	31 c9                	xor    %ecx,%ecx
    42fc:	48 8d 05 3d 7e 00 00 	lea    0x7e3d(%rip),%rax        # c140 <fwp_gc>
    4303:	31 d2                	xor    %edx,%edx
    4305:	66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
    430c:	00 00 00 00 
    4310:	89 d6                	mov    %edx,%esi
    4312:	c1 e6 04             	shl    $0x4,%esi
    4315:	48 ff c9             	dec    %rcx
    4318:	48 89 cf             	mov    %rcx,%rdi
    431b:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)
    4320:	48 89 f9             	mov    %rdi,%rcx
    4323:	48 ff c7             	inc    %rdi
    4326:	3b b4 88 4c 0b 00 00 	cmp    0xb4c(%rax,%rcx,4),%esi
    432d:	77 f1                	ja     4320 <fwp_gc_init+0xc0>
    432f:	40 88 bc 02 e8 0b 00 	mov    %dil,0xbe8(%rdx,%rax,1)
    4336:	00 
    4337:	48 89 d6             	mov    %rdx,%rsi
    433a:	48 83 ce 01          	or     $0x1,%rsi
    433e:	48 81 fe 01 04 00 00 	cmp    $0x401,%rsi
    4345:	74 26                	je     436d <fwp_gc_init+0x10d>
    4347:	89 f7                	mov    %esi,%edi
    4349:	c1 e7 04             	shl    $0x4,%edi
    434c:	0f 1f 40 00          	nopl   0x0(%rax)
    4350:	49 89 c8             	mov    %rcx,%r8
    4353:	48 ff c1             	inc    %rcx
    4356:	42 3b bc 80 4c 0b 00 	cmp    0xb4c(%rax,%r8,4),%edi
    435d:	00 
    435e:	77 f0                	ja     4350 <fwp_gc_init+0xf0>
    4360:	88 8c 06 e8 0b 00 00 	mov    %cl,0xbe8(%rsi,%rax,1)
    4367:	48 83 c2 02          	add    $0x2,%rdx
    436b:	eb a3                	jmp    4310 <fwp_gc_init+0xb0>
    436d:	48 bb 00 00 00 00 10 	movabs $0x1000000000,%rbx
    4374:	00 00 00 
    4377:	48 8d b3 00 00 01 00 	lea    0x10000(%rbx),%rsi
    437e:	31 ff                	xor    %edi,%edi
    4380:	31 d2                	xor    %edx,%edx
    4382:	b9 22 40 00 00       	mov    $0x4022,%ecx
    4387:	41 b8 ff ff ff ff    	mov    $0xffffffff,%r8d
    438d:	45 31 c9             	xor    %r9d,%r9d
    4390:	e8 2b dd ff ff       	call   20c0 <mmap@plt>
    4395:	48 83 f8 ff          	cmp    $0xffffffffffffffff,%rax
    4399:	75 60                	jne    43fb <fwp_gc_init+0x19b>
    439b:	48 bb 00 00 00 00 04 	movabs $0x400000000,%rbx
    43a2:	00 00 00 
    43a5:	48 8d b3 00 00 01 00 	lea    0x10000(%rbx),%rsi
    43ac:	31 ff                	xor    %edi,%edi
    43ae:	31 d2                	xor    %edx,%edx
    43b0:	b9 22 40 00 00       	mov    $0x4022,%ecx
    43b5:	41 b8 ff ff ff ff    	mov    $0xffffffff,%r8d
    43bb:	45 31 c9             	xor    %r9d,%r9d
    43be:	e8 fd dc ff ff       	call   20c0 <mmap@plt>
    43c3:	48 83 f8 ff          	cmp    $0xffffffffffffffff,%rax
    43c7:	75 32                	jne    43fb <fwp_gc_init+0x19b>
    43c9:	48 bb 00 00 00 00 01 	movabs $0x100000000,%rbx
    43d0:	00 00 00 
    43d3:	48 8d b3 00 00 01 00 	lea    0x10000(%rbx),%rsi
    43da:	31 ff                	xor    %edi,%edi
    43dc:	31 d2                	xor    %edx,%edx
    43de:	b9 22 40 00 00       	mov    $0x4022,%ecx
    43e3:	41 b8 ff ff ff ff    	mov    $0xffffffff,%r8d
    43e9:	45 31 c9             	xor    %r9d,%r9d
    43ec:	e8 cf dc ff ff       	call   20c0 <mmap@plt>
    43f1:	48 83 f8 ff          	cmp    $0xffffffffffffffff,%rax
    43f5:	0f 84 4e 02 00 00    	je     4649 <fwp_gc_init+0x3e9>
    43fb:	48 85 c0             	test   %rax,%rax
    43fe:	0f 84 a6 02 00 00    	je     46aa <fwp_gc_init+0x44a>
    4404:	48 89 05 6d 8d 00 00 	mov    %rax,0x8d6d(%rip)        # d178 <fwp_gc+0x1038>
    440b:	48 89 d9             	mov    %rbx,%rcx
    440e:	48 81 c9 00 00 01 00 	or     $0x10000,%rcx
    4415:	48 89 0d 64 8d 00 00 	mov    %rcx,0x8d64(%rip)        # d180 <fwp_gc+0x1040>
    441c:	48 05 ff ff 00 00    	add    $0xffff,%rax
    4422:	48 25 00 00 ff ff    	and    $0xffffffffffff0000,%rax
    4428:	48 89 05 41 8d 00 00 	mov    %rax,0x8d41(%rip)        # d170 <fwp_gc+0x1030>
    442f:	48 c1 eb 10          	shr    $0x10,%rbx
    4433:	48 89 1d 56 8d 00 00 	mov    %rbx,0x8d56(%rip)        # d190 <fwp_gc+0x1050>
    443a:	48 69 f3 28 12 00 00 	imul   $0x1228,%rbx,%rsi
    4441:	48 89 35 78 8d 00 00 	mov    %rsi,0x8d78(%rip)        # d1c0 <fwp_gc+0x1080>
    4448:	31 ff                	xor    %edi,%edi
    444a:	31 d2                	xor    %edx,%edx
    444c:	b9 22 40 00 00       	mov    $0x4022,%ecx
    4451:	41 b8 ff ff ff ff    	mov    $0xffffffff,%r8d
    4457:	45 31 c9             	xor    %r9d,%r9d
    445a:	e8 61 dc ff ff       	call   20c0 <mmap@plt>
    445f:	48 83 f8 ff          	cmp    $0xffffffffffffffff,%rax
    4463:	0f 84 41 02 00 00    	je     46aa <fwp_gc_init+0x44a>
    4469:	48 89 05 48 8d 00 00 	mov    %rax,0x8d48(%rip)        # d1b8 <fwp_gc+0x1078>
    4470:	48 8d 3d 77 4d 00 00 	lea    0x4d77(%rip),%rdi        # 91ee <_IO_stdin_used+0x1ee>
    4477:	e8 b4 db ff ff       	call   2030 <getenv@plt>
    447c:	48 85 c0             	test   %rax,%rax
    447f:	74 2e                	je     44af <fwp_gc_init+0x24f>
    4481:	48 89 c3             	mov    %rax,%rbx
    4484:	48 8d 35 6a 4d 00 00 	lea    0x4d6a(%rip),%rsi        # 91f5 <_IO_stdin_used+0x1f5>
    448b:	48 89 c7             	mov    %rax,%rdi
    448e:	e8 9d dc ff ff       	call   2130 <strcmp@plt>
    4493:	85 c0                	test   %eax,%eax
    4495:	74 1f                	je     44b6 <fwp_gc_init+0x256>
    4497:	48 8d 35 5b 4d 00 00 	lea    0x4d5b(%rip),%rsi        # 91f9 <_IO_stdin_used+0x1f9>
    449e:	48 89 df             	mov    %rbx,%rdi
    44a1:	e8 8a dc ff ff       	call   2130 <strcmp@plt>
    44a6:	31 c9                	xor    %ecx,%ecx
    44a8:	85 c0                	test   %eax,%eax
    44aa:	0f 95 c1             	setne  %cl
    44ad:	eb 09                	jmp    44b8 <fwp_gc_init+0x258>
    44af:	b9 01 00 00 00       	mov    $0x1,%ecx
    44b4:	eb 02                	jmp    44b8 <fwp_gc_init+0x258>
    44b6:	31 c9                	xor    %ecx,%ecx
    44b8:	89 0d 72 8c 00 00    	mov    %ecx,0x8c72(%rip)        # d130 <fwp_gc+0xff0>
    44be:	48 8d 3d 36 4d 00 00 	lea    0x4d36(%rip),%rdi        # 91fb <_IO_stdin_used+0x1fb>
    44c5:	e8 66 db ff ff       	call   2030 <getenv@plt>
    44ca:	31 c9                	xor    %ecx,%ecx
    44cc:	48 85 c0             	test   %rax,%rax
    44cf:	74 1b                	je     44ec <fwp_gc_init+0x28c>
    44d1:	80 38 00             	cmpb   $0x0,(%rax)
    44d4:	74 16                	je     44ec <fwp_gc_init+0x28c>
    44d6:	48 8d 35 1c 4d 00 00 	lea    0x4d1c(%rip),%rsi        # 91f9 <_IO_stdin_used+0x1f9>
    44dd:	48 89 c7             	mov    %rax,%rdi
    44e0:	e8 4b dc ff ff       	call   2130 <strcmp@plt>
    44e5:	31 c9                	xor    %ecx,%ecx
    44e7:	85 c0                	test   %eax,%eax
    44e9:	0f 95 c1             	setne  %cl
    44ec:	89 0d 4a 8c 00 00    	mov    %ecx,0x8c4a(%rip)        # d13c <fwp_gc+0xffc>
    44f2:	48 8d 3d f5 4c 00 00 	lea    0x4cf5(%rip),%rdi        # 91ee <_IO_stdin_used+0x1ee>
    44f9:	e8 32 db ff ff       	call   2030 <getenv@plt>
    44fe:	48 85 c0             	test   %rax,%rax
    4501:	74 18                	je     451b <fwp_gc_init+0x2bb>
    4503:	48 8d 35 fe 4c 00 00 	lea    0x4cfe(%rip),%rsi        # 9208 <_IO_stdin_used+0x208>
    450a:	48 89 c7             	mov    %rax,%rdi
    450d:	e8 1e dc ff ff       	call   2130 <strcmp@plt>
    4512:	31 c9                	xor    %ecx,%ecx
    4514:	85 c0                	test   %eax,%eax
    4516:	0f 95 c1             	setne  %cl
    4519:	eb 05                	jmp    4520 <fwp_gc_init+0x2c0>
    451b:	b9 01 00 00 00       	mov    $0x1,%ecx
    4520:	89 0d 1a 8c 00 00    	mov    %ecx,0x8c1a(%rip)        # d140 <fwp_gc+0x1000>
    4526:	c7 05 18 8c 00 00 01 	movl   $0x1,0x8c18(%rip)        # d148 <fwp_gc+0x1008>
    452d:	00 00 00 
    4530:	48 8d 3d d6 4c 00 00 	lea    0x4cd6(%rip),%rdi        # 920d <_IO_stdin_used+0x20d>
    4537:	e8 f4 da ff ff       	call   2030 <getenv@plt>
    453c:	31 c9                	xor    %ecx,%ecx
    453e:	48 85 c0             	test   %rax,%rax
    4541:	74 1b                	je     455e <fwp_gc_init+0x2fe>
    4543:	80 38 00             	cmpb   $0x0,(%rax)
    4546:	74 16                	je     455e <fwp_gc_init+0x2fe>
    4548:	48 8d 35 aa 4c 00 00 	lea    0x4caa(%rip),%rsi        # 91f9 <_IO_stdin_used+0x1f9>
    454f:	48 89 c7             	mov    %rax,%rdi
    4552:	e8 d9 db ff ff       	call   2130 <strcmp@plt>
    4557:	31 c9                	xor    %ecx,%ecx
    4559:	85 c0                	test   %eax,%eax
    455b:	0f 95 c1             	setne  %cl
    455e:	89 0d e0 8b 00 00    	mov    %ecx,0x8be0(%rip)        # d144 <fwp_gc+0x1004>
    4564:	48 8d 3d b0 4c 00 00 	lea    0x4cb0(%rip),%rdi        # 921b <_IO_stdin_used+0x21b>
    456b:	e8 c0 da ff ff       	call   2030 <getenv@plt>
    4570:	48 85 c0             	test   %rax,%rax
    4573:	74 14                	je     4589 <fwp_gc_init+0x329>
    4575:	48 89 c7             	mov    %rax,%rdi
    4578:	31 f6                	xor    %esi,%esi
    457a:	ba 0a 00 00 00       	mov    $0xa,%edx
    457f:	e8 ec db ff ff       	call   2170 <strtol@plt>
    4584:	48 89 c3             	mov    %rax,%rbx
    4587:	eb 02                	jmp    458b <fwp_gc_init+0x32b>
    4589:	31 db                	xor    %ebx,%ebx
    458b:	31 c0                	xor    %eax,%eax
    458d:	48 85 db             	test   %rbx,%rbx
    4590:	48 0f 4f c3          	cmovg  %rbx,%rax
    4594:	48 89 05 c5 8b 00 00 	mov    %rax,0x8bc5(%rip)        # d160 <fwp_gc+0x1020>
    459b:	48 8d 3d 4c 4c 00 00 	lea    0x4c4c(%rip),%rdi        # 91ee <_IO_stdin_used+0x1ee>
    45a2:	e8 89 da ff ff       	call   2030 <getenv@plt>
    45a7:	48 85 c0             	test   %rax,%rax
    45aa:	74 32                	je     45de <fwp_gc_init+0x37e>
    45ac:	49 89 c6             	mov    %rax,%r14
    45af:	80 38 00             	cmpb   $0x0,(%rax)
    45b2:	74 2a                	je     45de <fwp_gc_init+0x37e>
    45b4:	48 8d 35 3a 4c 00 00 	lea    0x4c3a(%rip),%rsi        # 91f5 <_IO_stdin_used+0x1f5>
    45bb:	4c 89 f7             	mov    %r14,%rdi
    45be:	e8 6d db ff ff       	call   2130 <strcmp@plt>
    45c3:	85 c0                	test   %eax,%eax
    45c5:	74 17                	je     45de <fwp_gc_init+0x37e>
    45c7:	48 8d 35 2b 4c 00 00 	lea    0x4c2b(%rip),%rsi        # 91f9 <_IO_stdin_used+0x1f9>
    45ce:	4c 89 f7             	mov    %r14,%rdi
    45d1:	e8 5a db ff ff       	call   2130 <strcmp@plt>
    45d6:	85 c0                	test   %eax,%eax
    45d8:	0f 85 f6 00 00 00    	jne    46d4 <fwp_gc_init+0x474>
    45de:	48 85 db             	test   %rbx,%rbx
    45e1:	0f 8f ed 00 00 00    	jg     46d4 <fwp_gc_init+0x474>
    45e7:	83 3d 56 8b 00 00 00 	cmpl   $0x0,0x8b56(%rip)        # d144 <fwp_gc+0x1004>
    45ee:	0f 85 e0 00 00 00    	jne    46d4 <fwp_gc_init+0x474>
    45f4:	48 8d 3d 6b 4c 00 00 	lea    0x4c6b(%rip),%rdi        # 9266 <_IO_stdin_used+0x266>
    45fb:	e8 30 da ff ff       	call   2030 <getenv@plt>
    4600:	48 85 c0             	test   %rax,%rax
    4603:	74 1c                	je     4621 <fwp_gc_init+0x3c1>
    4605:	80 38 00             	cmpb   $0x0,(%rax)
    4608:	74 17                	je     4621 <fwp_gc_init+0x3c1>
    460a:	48 8d 35 e8 4b 00 00 	lea    0x4be8(%rip),%rsi        # 91f9 <_IO_stdin_used+0x1f9>
    4611:	48 89 c7             	mov    %rax,%rdi
    4614:	e8 17 db ff ff       	call   2130 <strcmp@plt>
    4619:	85 c0                	test   %eax,%eax
    461b:	0f 85 e1 00 00 00    	jne    4702 <fwp_gc_init+0x4a2>
    4621:	c7 05 05 8b 00 00 00 	movl   $0x0,0x8b05(%rip)        # d130 <fwp_gc+0xff0>
    4628:	00 00 00 
    462b:	48 c7 05 1a 8d 00 00 	movq   $0x800000,0x8d1a(%rip)        # d350 <fwp_gc+0x1210>
    4632:	00 00 80 00 
    4636:	48 c7 05 ff 7a 00 00 	movq   $0x800000,0x7aff(%rip)        # c140 <fwp_gc>
    463d:	00 00 80 00 
    4641:	48 83 c4 08          	add    $0x8,%rsp
    4645:	5b                   	pop    %rbx
    4646:	41 5e                	pop    %r14
    4648:	c3                   	ret
    4649:	be 00 00 01 40       	mov    $0x40010000,%esi
    464e:	31 ff                	xor    %edi,%edi
    4650:	31 d2                	xor    %edx,%edx
    4652:	b9 22 40 00 00       	mov    $0x4022,%ecx
    4657:	41 b8 ff ff ff ff    	mov    $0xffffffff,%r8d
    465d:	45 31 c9             	xor    %r9d,%r9d
    4660:	e8 5b da ff ff       	call   20c0 <mmap@plt>
    4665:	48 83 f8 ff          	cmp    $0xffffffffffffffff,%rax
    4669:	74 0f                	je     467a <fwp_gc_init+0x41a>
    466b:	48 85 c0             	test   %rax,%rax
    466e:	74 3a                	je     46aa <fwp_gc_init+0x44a>
    4670:	bb 00 00 00 40       	mov    $0x40000000,%ebx
    4675:	e9 8a fd ff ff       	jmp    4404 <fwp_gc_init+0x1a4>
    467a:	be 00 00 01 10       	mov    $0x10010000,%esi
    467f:	31 ff                	xor    %edi,%edi
    4681:	31 d2                	xor    %edx,%edx
    4683:	b9 22 40 00 00       	mov    $0x4022,%ecx
    4688:	41 b8 ff ff ff ff    	mov    $0xffffffff,%r8d
    468e:	45 31 c9             	xor    %r9d,%r9d
    4691:	e8 2a da ff ff       	call   20c0 <mmap@plt>
    4696:	48 8d 48 01          	lea    0x1(%rax),%rcx
    469a:	48 83 f9 02          	cmp    $0x2,%rcx
    469e:	72 0a                	jb     46aa <fwp_gc_init+0x44a>
    46a0:	bb 00 00 00 10       	mov    $0x10000000,%ebx
    46a5:	e9 5a fd ff ff       	jmp    4404 <fwp_gc_init+0x1a4>
    46aa:	48 8b 05 2f 79 00 00 	mov    0x792f(%rip),%rax        # bfe0 <stderr@GLIBC_2.2.5>
    46b1:	48 8b 08             	mov    (%rax),%rcx
    46b4:	48 8d 3d fb 4b 00 00 	lea    0x4bfb(%rip),%rdi        # 92b6 <_IO_stdin_used+0x2b6>
    46bb:	be 13 00 00 00       	mov    $0x13,%esi
    46c0:	ba 01 00 00 00       	mov    $0x1,%edx
    46c5:	e8 66 db ff ff       	call   2230 <fwrite@plt>
    46ca:	bf 66 00 00 00       	mov    $0x66,%edi
    46cf:	e8 4c db ff ff       	call   2220 <exit@plt>
    46d4:	e8 f7 f6 ff ff       	call   3dd0 <fwp_flush>
    46d9:	48 8b 05 00 79 00 00 	mov    0x7900(%rip),%rax        # bfe0 <stderr@GLIBC_2.2.5>
    46e0:	48 8b 38             	mov    (%rax),%rdi
    46e3:	48 8d 35 ce 4a 00 00 	lea    0x4ace(%rip),%rsi        # 91b8 <_IO_stdin_used+0x1b8>
    46ea:	48 8d 15 38 4b 00 00 	lea    0x4b38(%rip),%rdx        # 9229 <_IO_stdin_used+0x229>
    46f1:	31 c0                	xor    %eax,%eax
    46f3:	e8 58 da ff ff       	call   2150 <fprintf@plt>
    46f8:	bf 65 00 00 00       	mov    $0x65,%edi
    46fd:	e8 1e db ff ff       	call   2220 <exit@plt>
    4702:	e8 c9 f6 ff ff       	call   3dd0 <fwp_flush>
    4707:	48 8b 05 d2 78 00 00 	mov    0x78d2(%rip),%rax        # bfe0 <stderr@GLIBC_2.2.5>
    470e:	48 8b 38             	mov    (%rax),%rdi
    4711:	48 8d 35 a0 4a 00 00 	lea    0x4aa0(%rip),%rsi        # 91b8 <_IO_stdin_used+0x1b8>
    4718:	48 8d 15 58 4b 00 00 	lea    0x4b58(%rip),%rdx        # 9277 <_IO_stdin_used+0x277>
    471f:	eb d0                	jmp    46f1 <fwp_gc_init+0x491>
    4721:	66 66 66 66 66 66 2e 	data16 data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    4728:	0f 1f 84 00 00 00 00 
    472f:	00 

0000000000004730 <fwp_gc_alloc_big>:
    4730:	55                   	push   %rbp
    4731:	41 57                	push   %r15
    4733:	41 56                	push   %r14
    4735:	41 55                	push   %r13
    4737:	41 54                	push   %r12
    4739:	53                   	push   %rbx
    473a:	50                   	push   %rax
    473b:	48 b8 01 00 00 00 00 	movabs $0x4000000000000001,%rax
    4742:	00 00 40 
    4745:	48 39 c7             	cmp    %rax,%rdi
    4748:	0f 83 ce 01 00 00    	jae    491c <fwp_gc_alloc_big+0x1ec>
    474e:	89 f5                	mov    %esi,%ebp
    4750:	48 89 fb             	mov    %rdi,%rbx
    4753:	48 29 3d e6 79 00 00 	sub    %rdi,0x79e6(%rip)        # c140 <fwp_gc>
    475a:	0f 89 80 00 00 00    	jns    47e0 <fwp_gc_alloc_big+0xb0>
    4760:	83 3d c5 89 00 00 00 	cmpl   $0x0,0x89c5(%rip)        # d12c <fwp_gc+0xfec>
    4767:	75 05                	jne    476e <fwp_gc_alloc_big+0x3e>
    4769:	e8 f2 fa ff ff       	call   4260 <fwp_gc_init>
    476e:	8b 0d c0 89 00 00    	mov    0x89c0(%rip),%ecx        # d134 <fwp_gc+0xff4>
    4774:	85 c9                	test   %ecx,%ecx
    4776:	74 2a                	je     47a2 <fwp_gc_alloc_big+0x72>
    4778:	48 8b 05 e1 89 00 00 	mov    0x89e1(%rip),%rax        # d160 <fwp_gc+0x1020>
    477f:	48 85 c0             	test   %rax,%rax
    4782:	74 1e                	je     47a2 <fwp_gc_alloc_big+0x72>
    4784:	48 8b 0d dd 89 00 00 	mov    0x89dd(%rip),%rcx        # d168 <fwp_gc+0x1028>
    478b:	48 ff c1             	inc    %rcx
    478e:	48 89 0d d3 89 00 00 	mov    %rcx,0x89d3(%rip)        # d168 <fwp_gc+0x1028>
    4795:	48 39 c1             	cmp    %rax,%rcx
    4798:	0f 8d ad 01 00 00    	jge    494b <fwp_gc_alloc_big+0x21b>
    479e:	31 c0                	xor    %eax,%eax
    47a0:	eb 0d                	jmp    47af <fwp_gc_alloc_big+0x7f>
    47a2:	b8 00 00 80 00       	mov    $0x800000,%eax
    47a7:	85 c9                	test   %ecx,%ecx
    47a9:	0f 85 97 01 00 00    	jne    4946 <fwp_gc_alloc_big+0x216>
    47af:	48 8b 0d 9a 8b 00 00 	mov    0x8b9a(%rip),%rcx        # d350 <fwp_gc+0x1210>
    47b6:	48 2b 0d 83 79 00 00 	sub    0x7983(%rip),%rcx        # c140 <fwp_gc>
    47bd:	f2 48 0f 2a c1       	cvtsi2sd %rcx,%xmm0
    47c2:	f2 0f 58 05 5e 8b 00 	addsd  0x8b5e(%rip),%xmm0        # d328 <fwp_gc+0x11e8>
    47c9:	00 
    47ca:	f2 0f 11 05 56 8b 00 	movsd  %xmm0,0x8b56(%rip)        # d328 <fwp_gc+0x11e8>
    47d1:	00 
    47d2:	48 89 05 77 8b 00 00 	mov    %rax,0x8b77(%rip)        # d350 <fwp_gc+0x1210>
    47d9:	48 89 05 60 79 00 00 	mov    %rax,0x7960(%rip)        # c140 <fwp_gc>
    47e0:	4c 8d b3 ff ff 00 00 	lea    0xffff(%rbx),%r14
    47e7:	49 c1 ee 10          	shr    $0x10,%r14
    47eb:	4c 89 f7             	mov    %r14,%rdi
    47ee:	e8 9d 02 00 00       	call   4a90 <fwp_gc_chunks>
    47f3:	48 8b 0d be 89 00 00 	mov    0x89be(%rip),%rcx        # d1b8 <fwp_gc+0x1078>
    47fa:	4c 69 e0 28 12 00 00 	imul   $0x1228,%rax,%r12
    4801:	42 c6 04 21 02       	movb   $0x2,(%rcx,%r12,1)
    4806:	42 88 6c 21 01       	mov    %bpl,0x1(%rcx,%r12,1)
    480b:	66 42 c7 44 21 03 00 	movw   $0x100,0x3(%rcx,%r12,1)
    4812:	01 
    4813:	46 89 74 21 10       	mov    %r14d,0x10(%rcx,%r12,1)
    4818:	4a 89 5c 21 18       	mov    %rbx,0x18(%rcx,%r12,1)
    481d:	4e 8d 3c 21          	lea    (%rcx,%r12,1),%r15
    4821:	49 81 c7 28 02 00 00 	add    $0x228,%r15
    4828:	42 80 bc 21 28 02 00 	cmpb   $0xff,0x228(%rcx,%r12,1)
    482f:	00 ff 
    4831:	0f 84 d2 00 00 00    	je     4909 <fwp_gc_alloc_big+0x1d9>
    4837:	41 c6 07 00          	movb   $0x0,(%r15)
    483b:	48 81 fb 01 00 01 00 	cmp    $0x10001,%rbx
    4842:	0f 82 9b 00 00 00    	jb     48e3 <fwp_gc_alloc_big+0x1b3>
    4848:	49 83 fe 03          	cmp    $0x3,%r14
    484c:	ba 02 00 00 00       	mov    $0x2,%edx
    4851:	49 0f 43 d6          	cmovae %r14,%rdx
    4855:	48 8b 0d 5c 89 00 00 	mov    0x895c(%rip),%rcx        # d1b8 <fwp_gc+0x1078>
    485c:	48 ff ca             	dec    %rdx
    485f:	be 01 00 00 00       	mov    $0x1,%esi
    4864:	48 81 fb 01 00 02 00 	cmp    $0x20001,%rbx
    486b:	72 5a                	jb     48c7 <fwp_gc_alloc_big+0x197>
    486d:	49 8d 3c 0c          	lea    (%r12,%rcx,1),%rdi
    4871:	48 81 c7 60 24 00 00 	add    $0x2460,%rdi
    4878:	49 89 d0             	mov    %rdx,%r8
    487b:	49 83 e0 fe          	and    $0xfffffffffffffffe,%r8
    487f:	49 f7 d8             	neg    %r8
    4882:	66 66 66 66 66 2e 0f 	data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    4889:	1f 84 00 00 00 00 00 
    4890:	c6 87 c8 ed ff ff 03 	movb   $0x3,-0x1238(%rdi)
    4897:	c6 87 cc ed ff ff 01 	movb   $0x1,-0x1234(%rdi)
    489e:	89 87 d8 ed ff ff    	mov    %eax,-0x1228(%rdi)
    48a4:	c6 47 f0 03          	movb   $0x3,-0x10(%rdi)
    48a8:	c6 47 f4 01          	movb   $0x1,-0xc(%rdi)
    48ac:	89 07                	mov    %eax,(%rdi)
    48ae:	48 81 c7 50 24 00 00 	add    $0x2450,%rdi
    48b5:	4d 8d 0c 30          	lea    (%r8,%rsi,1),%r9
    48b9:	49 83 c1 02          	add    $0x2,%r9
    48bd:	48 83 c6 02          	add    $0x2,%rsi
    48c1:	49 83 f9 01          	cmp    $0x1,%r9
    48c5:	75 c9                	jne    4890 <fwp_gc_alloc_big+0x160>
    48c7:	f6 c2 01             	test   $0x1,%dl
    48ca:	74 17                	je     48e3 <fwp_gc_alloc_big+0x1b3>
    48cc:	4c 01 e1             	add    %r12,%rcx
    48cf:	48 69 d6 28 12 00 00 	imul   $0x1228,%rsi,%rdx
    48d6:	c6 04 11 03          	movb   $0x3,(%rcx,%rdx,1)
    48da:	c6 44 11 04 01       	movb   $0x1,0x4(%rcx,%rdx,1)
    48df:	89 44 11 10          	mov    %eax,0x10(%rcx,%rdx,1)
    48e3:	48 c1 e0 10          	shl    $0x10,%rax
    48e7:	48 03 05 82 88 00 00 	add    0x8882(%rip),%rax        # d170 <fwp_gc+0x1030>
    48ee:	48 89 c7             	mov    %rax,%rdi
    48f1:	31 f6                	xor    %esi,%esi
    48f3:	48 89 da             	mov    %rbx,%rdx
    48f6:	48 83 c4 08          	add    $0x8,%rsp
    48fa:	5b                   	pop    %rbx
    48fb:	41 5c                	pop    %r12
    48fd:	41 5d                	pop    %r13
    48ff:	41 5e                	pop    %r14
    4901:	41 5f                	pop    %r15
    4903:	5d                   	pop    %rbp
    4904:	e9 d7 d7 ff ff       	jmp    20e0 <memset@plt>
    4909:	4c 89 ff             	mov    %r15,%rdi
    490c:	49 89 c5             	mov    %rax,%r13
    490f:	e8 ec f4 ff ff       	call   3e00 <fwp_rc_forget_slot>
    4914:	4c 89 e8             	mov    %r13,%rax
    4917:	e9 1b ff ff ff       	jmp    4837 <fwp_gc_alloc_big+0x107>
    491c:	48 8b 05 bd 76 00 00 	mov    0x76bd(%rip),%rax        # bfe0 <stderr@GLIBC_2.2.5>
    4923:	48 8b 08             	mov    (%rax),%rcx
    4926:	48 8d 3d 89 49 00 00 	lea    0x4989(%rip),%rdi        # 92b6 <_IO_stdin_used+0x2b6>
    492d:	be 13 00 00 00       	mov    $0x13,%esi
    4932:	ba 01 00 00 00       	mov    $0x1,%edx
    4937:	e8 f4 d8 ff ff       	call   2230 <fwrite@plt>
    493c:	bf 66 00 00 00       	mov    $0x66,%edi
    4941:	e8 da d8 ff ff       	call   2220 <exit@plt>
    4946:	e8 d5 02 00 00       	call   4c20 <fwp_gc_collect>
    494b:	48 c7 05 12 88 00 00 	movq   $0x0,0x8812(%rip)        # d168 <fwp_gc+0x1028>
    4952:	00 00 00 00 
    4956:	e8 c5 02 00 00       	call   4c20 <fwp_gc_collect>
    495b:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)

0000000000004960 <fwp_gc_refill>:
    4960:	55                   	push   %rbp
    4961:	41 57                	push   %r15
    4963:	41 56                	push   %r14
    4965:	41 55                	push   %r13
    4967:	41 54                	push   %r12
    4969:	53                   	push   %rbx
    496a:	50                   	push   %rax
    496b:	89 d5                	mov    %edx,%ebp
    496d:	41 89 f7             	mov    %esi,%r15d
    4970:	48 89 fb             	mov    %rdi,%rbx
    4973:	bf 01 00 00 00       	mov    $0x1,%edi
    4978:	e8 13 01 00 00       	call   4a90 <fwp_gc_chunks>
    497d:	49 89 c6             	mov    %rax,%r14
    4980:	4c 8b 25 31 88 00 00 	mov    0x8831(%rip),%r12        # d1b8 <fwp_gc+0x1078>
    4987:	48 8d 05 b2 77 00 00 	lea    0x77b2(%rip),%rax        # c140 <fwp_gc>
    498e:	4d 69 ee 28 12 00 00 	imul   $0x1228,%r14,%r13
    4995:	43 c6 04 2c 01       	movb   $0x1,(%r12,%r13,1)
    499a:	43 88 6c 2c 01       	mov    %bpl,0x1(%r12,%r13,1)
    499f:	47 88 7c 2c 02       	mov    %r15b,0x2(%r12,%r13,1)
    49a4:	43 c6 44 2c 04 01    	movb   $0x1,0x4(%r12,%r13,1)
    49aa:	44 89 f9             	mov    %r15d,%ecx
    49ad:	8b 8c 88 48 0b 00 00 	mov    0xb48(%rax,%rcx,4),%ecx
    49b4:	43 89 4c 2c 08       	mov    %ecx,0x8(%r12,%r13,1)
    49b9:	b8 00 00 01 00       	mov    $0x10000,%eax
    49be:	31 d2                	xor    %edx,%edx
    49c0:	f7 f1                	div    %ecx
    49c2:	43 89 44 2c 0c       	mov    %eax,0xc(%r12,%r13,1)
    49c7:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    49cc:	48 01 c8             	add    %rcx,%rax
    49cf:	48 0f ba e0 20       	bt     $0x20,%rax
    49d4:	73 07                	jae    49dd <fwp_gc_refill+0x7d>
    49d6:	31 d2                	xor    %edx,%edx
    49d8:	48 f7 f1             	div    %rcx
    49db:	eb 04                	jmp    49e1 <fwp_gc_refill+0x81>
    49dd:	31 d2                	xor    %edx,%edx
    49df:	f7 f1                	div    %ecx
    49e1:	43 89 44 2c 20       	mov    %eax,0x20(%r12,%r13,1)
    49e6:	48 83 3d 6a 91 00 00 	cmpq   $0x0,0x916a(%rip)        # db58 <fwp_gc+0x1a18>
    49ed:	00 
    49ee:	74 2e                	je     4a1e <fwp_gc_refill+0xbe>
    49f0:	4f 8d 3c 2c          	lea    (%r12,%r13,1),%r15
    49f4:	49 81 c7 28 02 00 00 	add    $0x228,%r15
    49fb:	31 ed                	xor    %ebp,%ebp
    49fd:	eb 0d                	jmp    4a0c <fwp_gc_refill+0xac>
    49ff:	90                   	nop
    4a00:	48 ff c5             	inc    %rbp
    4a03:	48 81 fd 00 10 00 00 	cmp    $0x1000,%rbp
    4a0a:	74 12                	je     4a1e <fwp_gc_refill+0xbe>
    4a0c:	41 80 3c 2f ff       	cmpb   $0xff,(%r15,%rbp,1)
    4a11:	75 ed                	jne    4a00 <fwp_gc_refill+0xa0>
    4a13:	49 8d 3c 2f          	lea    (%r15,%rbp,1),%rdi
    4a17:	e8 e4 f3 ff ff       	call   3e00 <fwp_rc_forget_slot>
    4a1c:	eb e2                	jmp    4a00 <fwp_gc_refill+0xa0>
    4a1e:	4f 8d 3c 2c          	lea    (%r12,%r13,1),%r15
    4a22:	49 83 c7 08          	add    $0x8,%r15
    4a26:	4b 8d 3c 2c          	lea    (%r12,%r13,1),%rdi
    4a2a:	48 81 c7 28 02 00 00 	add    $0x228,%rdi
    4a31:	ba 00 10 00 00       	mov    $0x1000,%edx
    4a36:	31 f6                	xor    %esi,%esi
    4a38:	e8 a3 d6 ff ff       	call   20e0 <memset@plt>
    4a3d:	49 c1 e6 10          	shl    $0x10,%r14
    4a41:	4c 03 35 28 87 00 00 	add    0x8728(%rip),%r14        # d170 <fwp_gc+0x1030>
    4a48:	83 3d f5 86 00 00 00 	cmpl   $0x0,0x86f5(%rip)        # d144 <fwp_gc+0x1004>
    4a4f:	74 0f                	je     4a60 <fwp_gc_refill+0x100>
    4a51:	ba 00 00 01 00       	mov    $0x10000,%edx
    4a56:	4c 89 f7             	mov    %r14,%rdi
    4a59:	31 f6                	xor    %esi,%esi
    4a5b:	e8 80 d6 ff ff       	call   20e0 <memset@plt>
    4a60:	41 8b 07             	mov    (%r15),%eax
    4a63:	49 8d 0c 06          	lea    (%r14,%rax,1),%rcx
    4a67:	48 89 4b 08          	mov    %rcx,0x8(%rbx)
    4a6b:	41 8b 4f 04          	mov    0x4(%r15),%ecx
    4a6f:	48 0f af c8          	imul   %rax,%rcx
    4a73:	4c 01 f1             	add    %r14,%rcx
    4a76:	48 89 4b 10          	mov    %rcx,0x10(%rbx)
    4a7a:	4c 89 f0             	mov    %r14,%rax
    4a7d:	48 83 c4 08          	add    $0x8,%rsp
    4a81:	5b                   	pop    %rbx
    4a82:	41 5c                	pop    %r12
    4a84:	41 5d                	pop    %r13
    4a86:	41 5e                	pop    %r14
    4a88:	41 5f                	pop    %r15
    4a8a:	5d                   	pop    %rbp
    4a8b:	c3                   	ret
    4a8c:	0f 1f 40 00          	nopl   0x0(%rax)

0000000000004a90 <fwp_gc_chunks>:
    4a90:	41 57                	push   %r15
    4a92:	41 56                	push   %r14
    4a94:	53                   	push   %rbx
    4a95:	48 89 fb             	mov    %rdi,%rbx
    4a98:	31 d2                	xor    %edx,%edx
    4a9a:	48 83 ff 01          	cmp    $0x1,%rdi
    4a9e:	0f 95 c2             	setne  %dl
    4aa1:	48 8d 0d 98 76 00 00 	lea    0x7698(%rip),%rcx        # c140 <fwp_gc>
    4aa8:	48 8b 84 d1 68 10 00 	mov    0x1068(%rcx,%rdx,8),%rax
    4aaf:	00 
    4ab0:	4c 8b 35 e1 86 00 00 	mov    0x86e1(%rip),%r14        # d198 <fwp_gc+0x1058>
    4ab7:	48 89 c7             	mov    %rax,%rdi
    4aba:	4c 29 f7             	sub    %r14,%rdi
    4abd:	73 63                	jae    4b22 <fwp_gc_chunks+0x92>
    4abf:	48 8d 34 d5 68 10 00 	lea    0x1068(,%rdx,8),%rsi
    4ac6:	00 
    4ac7:	4c 69 c0 28 12 00 00 	imul   $0x1228,%rax,%r8
    4ace:	4c 03 05 e3 86 00 00 	add    0x86e3(%rip),%r8        # d1b8 <fwp_gc+0x1078>
    4ad5:	31 d2                	xor    %edx,%edx
    4ad7:	45 31 c9             	xor    %r9d,%r9d
    4ada:	eb 16                	jmp    4af2 <fwp_gc_chunks+0x62>
    4adc:	0f 1f 40 00          	nopl   0x0(%rax)
    4ae0:	45 31 c9             	xor    %r9d,%r9d
    4ae3:	48 ff ca             	dec    %rdx
    4ae6:	49 81 c0 28 12 00 00 	add    $0x1228,%r8
    4aed:	48 39 d7             	cmp    %rdx,%rdi
    4af0:	74 33                	je     4b25 <fwp_gc_chunks+0x95>
    4af2:	41 80 38 00          	cmpb   $0x0,(%r8)
    4af6:	75 e8                	jne    4ae0 <fwp_gc_chunks+0x50>
    4af8:	49 ff c1             	inc    %r9
    4afb:	49 39 d9             	cmp    %rbx,%r9
    4afe:	75 e3                	jne    4ae3 <fwp_gc_chunks+0x53>
    4b00:	48 ff c0             	inc    %rax
    4b03:	48 89 c7             	mov    %rax,%rdi
    4b06:	48 29 d7             	sub    %rdx,%rdi
    4b09:	48 89 3c 0e          	mov    %rdi,(%rsi,%rcx,1)
    4b0d:	48 29 1d 0c 88 00 00 	sub    %rbx,0x880c(%rip)        # d320 <fwp_gc+0x11e0>
    4b14:	48 29 d8             	sub    %rbx,%rax
    4b17:	48 29 d0             	sub    %rdx,%rax
    4b1a:	49 89 c6             	mov    %rax,%r14
    4b1d:	e9 ca 00 00 00       	jmp    4bec <fwp_gc_chunks+0x15c>
    4b22:	45 31 c9             	xor    %r9d,%r9d
    4b25:	4c 29 0d f4 87 00 00 	sub    %r9,0x87f4(%rip)        # d320 <fwp_gc+0x11e0>
    4b2c:	4d 29 ce             	sub    %r9,%r14
    4b2f:	4c 01 f3             	add    %r14,%rbx
    4b32:	48 8b 3d 67 86 00 00 	mov    0x8667(%rip),%rdi        # d1a0 <fwp_gc+0x1060>
    4b39:	48 39 df             	cmp    %rbx,%rdi
    4b3c:	0f 83 8f 00 00 00    	jae    4bd1 <fwp_gc_chunks+0x141>
    4b42:	4c 8b 3d 47 86 00 00 	mov    0x8647(%rip),%r15        # d190 <fwp_gc+0x1050>
    4b49:	49 39 df             	cmp    %rbx,%r15
    4b4c:	0f 82 a3 00 00 00    	jb     4bf5 <fwp_gc_chunks+0x165>
    4b52:	48 8d 43 40          	lea    0x40(%rbx),%rax
    4b56:	4c 39 f8             	cmp    %r15,%rax
    4b59:	4c 0f 42 f8          	cmovb  %rax,%r15
    4b5d:	4c 89 fe             	mov    %r15,%rsi
    4b60:	48 29 fe             	sub    %rdi,%rsi
    4b63:	48 c1 e7 10          	shl    $0x10,%rdi
    4b67:	48 03 3d 02 86 00 00 	add    0x8602(%rip),%rdi        # d170 <fwp_gc+0x1030>
    4b6e:	48 c1 e6 10          	shl    $0x10,%rsi
    4b72:	ba 03 00 00 00       	mov    $0x3,%edx
    4b77:	e8 64 d6 ff ff       	call   21e0 <mprotect@plt>
    4b7c:	85 c0                	test   %eax,%eax
    4b7e:	75 75                	jne    4bf5 <fwp_gc_chunks+0x165>
    4b80:	bf 1e 00 00 00       	mov    $0x1e,%edi
    4b85:	e8 76 d6 ff ff       	call   2200 <sysconf@plt>
    4b8a:	48 8b 0d 27 86 00 00 	mov    0x8627(%rip),%rcx        # d1b8 <fwp_gc+0x1078>
    4b91:	48 69 3d 04 86 00 00 	imul   $0x1228,0x8604(%rip),%rdi        # d1a0 <fwp_gc+0x1060>
    4b98:	28 12 00 00 
    4b9c:	48 01 cf             	add    %rcx,%rdi
    4b9f:	49 69 d7 28 12 00 00 	imul   $0x1228,%r15,%rdx
    4ba6:	48 01 ca             	add    %rcx,%rdx
    4ba9:	48 8d 34 10          	lea    (%rax,%rdx,1),%rsi
    4bad:	48 ff ce             	dec    %rsi
    4bb0:	48 f7 d8             	neg    %rax
    4bb3:	48 21 c7             	and    %rax,%rdi
    4bb6:	48 21 c6             	and    %rax,%rsi
    4bb9:	48 29 fe             	sub    %rdi,%rsi
    4bbc:	ba 03 00 00 00       	mov    $0x3,%edx
    4bc1:	e8 1a d6 ff ff       	call   21e0 <mprotect@plt>
    4bc6:	85 c0                	test   %eax,%eax
    4bc8:	75 2b                	jne    4bf5 <fwp_gc_chunks+0x165>
    4bca:	4c 89 3d cf 85 00 00 	mov    %r15,0x85cf(%rip)        # d1a0 <fwp_gc+0x1060>
    4bd1:	48 89 1d c0 85 00 00 	mov    %rbx,0x85c0(%rip)        # d198 <fwp_gc+0x1058>
    4bd8:	48 c1 e3 10          	shl    $0x10,%rbx
    4bdc:	48 3b 1d a5 85 00 00 	cmp    0x85a5(%rip),%rbx        # d188 <fwp_gc+0x1048>
    4be3:	76 07                	jbe    4bec <fwp_gc_chunks+0x15c>
    4be5:	48 89 1d 9c 85 00 00 	mov    %rbx,0x859c(%rip)        # d188 <fwp_gc+0x1048>
    4bec:	4c 89 f0             	mov    %r14,%rax
    4bef:	5b                   	pop    %rbx
    4bf0:	41 5e                	pop    %r14
    4bf2:	41 5f                	pop    %r15
    4bf4:	c3                   	ret
    4bf5:	48 8b 05 e4 73 00 00 	mov    0x73e4(%rip),%rax        # bfe0 <stderr@GLIBC_2.2.5>
    4bfc:	48 8b 08             	mov    (%rax),%rcx
    4bff:	48 8d 3d b0 46 00 00 	lea    0x46b0(%rip),%rdi        # 92b6 <_IO_stdin_used+0x2b6>
    4c06:	be 13 00 00 00       	mov    $0x13,%esi
    4c0b:	ba 01 00 00 00       	mov    $0x1,%edx
    4c10:	e8 1b d6 ff ff       	call   2230 <fwrite@plt>
    4c15:	bf 66 00 00 00       	mov    $0x66,%edi
    4c1a:	e8 01 d6 ff ff       	call   2220 <exit@plt>
    4c1f:	90                   	nop

0000000000004c20 <fwp_gc_collect>:
    4c20:	50                   	push   %rax
    4c21:	e8 aa f1 ff ff       	call   3dd0 <fwp_flush>
    4c26:	48 8b 05 b3 73 00 00 	mov    0x73b3(%rip),%rax        # bfe0 <stderr@GLIBC_2.2.5>
    4c2d:	48 8b 38             	mov    (%rax),%rdi
    4c30:	48 8d 35 81 45 00 00 	lea    0x4581(%rip),%rsi        # 91b8 <_IO_stdin_used+0x1b8>
    4c37:	48 8d 15 8c 46 00 00 	lea    0x468c(%rip),%rdx        # 92ca <_IO_stdin_used+0x2ca>
    4c3e:	31 c0                	xor    %eax,%eax
    4c40:	e8 0b d5 ff ff       	call   2150 <fprintf@plt>
    4c45:	bf 65 00 00 00       	mov    $0x65,%edi
    4c4a:	e8 d1 d5 ff ff       	call   2220 <exit@plt>
    4c4f:	90                   	nop

0000000000004c50 <fwp_drop0>:
    4c50:	48 8b 15 19 85 00 00 	mov    0x8519(%rip),%rdx        # d170 <fwp_gc+0x1030>
    4c57:	48 89 f8             	mov    %rdi,%rax
    4c5a:	48 29 d0             	sub    %rdx,%rax
    4c5d:	48 8b 35 34 85 00 00 	mov    0x8534(%rip),%rsi        # d198 <fwp_gc+0x1058>
    4c64:	48 c1 e6 10          	shl    $0x10,%rsi
    4c68:	48 39 f0             	cmp    %rsi,%rax
    4c6b:	0f 83 b7 00 00 00    	jae    4d28 <fwp_drop0+0xd8>
    4c71:	48 8b 0d 40 85 00 00 	mov    0x8540(%rip),%rcx        # d1b8 <fwp_gc+0x1078>
    4c78:	49 89 c0             	mov    %rax,%r8
    4c7b:	49 c1 e8 10          	shr    $0x10,%r8
    4c7f:	4d 69 c0 28 12 00 00 	imul   $0x1228,%r8,%r8
    4c86:	46 0f b6 0c 01       	movzbl (%rcx,%r8,1),%r9d
    4c8b:	48 25 ff ff 00 00    	and    $0xffff,%rax
    4c91:	75 12                	jne    4ca5 <fwp_drop0+0x55>
    4c93:	41 80 f9 02          	cmp    $0x2,%r9b
    4c97:	75 0c                	jne    4ca5 <fwp_drop0+0x55>
    4c99:	4a 8d 04 01          	lea    (%rcx,%r8,1),%rax
    4c9d:	48 05 28 02 00 00    	add    $0x228,%rax
    4ca3:	eb 20                	jmp    4cc5 <fwp_drop0+0x75>
    4ca5:	41 80 f9 01          	cmp    $0x1,%r9b
    4ca9:	75 7d                	jne    4d28 <fwp_drop0+0xd8>
    4cab:	4e 8d 0c 01          	lea    (%rcx,%r8,1),%r9
    4caf:	46 8b 44 01 20       	mov    0x20(%rcx,%r8,1),%r8d
    4cb4:	49 0f af c0          	imul   %r8,%rax
    4cb8:	48 c1 e8 20          	shr    $0x20,%rax
    4cbc:	4c 01 c8             	add    %r9,%rax
    4cbf:	48 05 28 02 00 00    	add    $0x228,%rax
    4cc5:	44 0f b6 00          	movzbl (%rax),%r8d
    4cc9:	45 85 c0             	test   %r8d,%r8d
    4ccc:	74 5a                	je     4d28 <fwp_drop0+0xd8>
    4cce:	41 83 f8 01          	cmp    $0x1,%r8d
    4cd2:	75 41                	jne    4d15 <fwp_drop0+0xc5>
    4cd4:	53                   	push   %rbx
    4cd5:	48 8b 47 08          	mov    0x8(%rdi),%rax
    4cd9:	49 89 c0             	mov    %rax,%r8
    4cdc:	49 29 d0             	sub    %rdx,%r8
    4cdf:	49 39 f0             	cmp    %rsi,%r8
    4ce2:	0f 83 8e 00 00 00    	jae    4d76 <fwp_drop0+0x126>
    4ce8:	4c 89 c2             	mov    %r8,%rdx
    4ceb:	48 c1 ea 10          	shr    $0x10,%rdx
    4cef:	48 69 d2 28 12 00 00 	imul   $0x1228,%rdx,%rdx
    4cf6:	0f b6 34 11          	movzbl (%rcx,%rdx,1),%esi
    4cfa:	49 81 e0 ff ff 00 00 	and    $0xffff,%r8
    4d01:	75 26                	jne    4d29 <fwp_drop0+0xd9>
    4d03:	40 80 fe 02          	cmp    $0x2,%sil
    4d07:	75 20                	jne    4d29 <fwp_drop0+0xd9>
    4d09:	48 01 d1             	add    %rdx,%rcx
    4d0c:	48 81 c1 28 02 00 00 	add    $0x228,%rcx
    4d13:	eb 35                	jmp    4d4a <fwp_drop0+0xfa>
    4d15:	41 81 f8 ff 00 00 00 	cmp    $0xff,%r8d
    4d1c:	0f 84 9e 01 00 00    	je     4ec0 <fwp_drop0+0x270>
    4d22:	41 fe c8             	dec    %r8b
    4d25:	44 88 00             	mov    %r8b,(%rax)
    4d28:	c3                   	ret
    4d29:	40 80 fe 01          	cmp    $0x1,%sil
    4d2d:	75 47                	jne    4d76 <fwp_drop0+0x126>
    4d2f:	48 8d 34 11          	lea    (%rcx,%rdx,1),%rsi
    4d33:	8b 4c 11 20          	mov    0x20(%rcx,%rdx,1),%ecx
    4d37:	4c 0f af c1          	imul   %rcx,%r8
    4d3b:	49 c1 e8 20          	shr    $0x20,%r8
    4d3f:	49 8d 0c 30          	lea    (%r8,%rsi,1),%rcx
    4d43:	48 81 c1 28 02 00 00 	add    $0x228,%rcx
    4d4a:	0f b6 11             	movzbl (%rcx),%edx
    4d4d:	85 d2                	test   %edx,%edx
    4d4f:	74 25                	je     4d76 <fwp_drop0+0x126>
    4d51:	83 fa 01             	cmp    $0x1,%edx
    4d54:	75 10                	jne    4d66 <fwp_drop0+0x116>
    4d56:	48 89 fb             	mov    %rdi,%rbx
    4d59:	48 89 c7             	mov    %rax,%rdi
    4d5c:	e8 2f 1a 00 00       	call   6790 <fwp_rc_free_obj>
    4d61:	48 89 df             	mov    %rbx,%rdi
    4d64:	eb 10                	jmp    4d76 <fwp_drop0+0x126>
    4d66:	81 fa ff 00 00 00    	cmp    $0xff,%edx
    4d6c:	0f 84 56 01 00 00    	je     4ec8 <fwp_drop0+0x278>
    4d72:	fe ca                	dec    %dl
    4d74:	88 11                	mov    %dl,(%rcx)
    4d76:	48 8b 47 10          	mov    0x10(%rdi),%rax
    4d7a:	48 89 c1             	mov    %rax,%rcx
    4d7d:	48 2b 0d ec 83 00 00 	sub    0x83ec(%rip),%rcx        # d170 <fwp_gc+0x1030>
    4d84:	48 8b 15 0d 84 00 00 	mov    0x840d(%rip),%rdx        # d198 <fwp_gc+0x1058>
    4d8b:	48 c1 e2 10          	shl    $0x10,%rdx
    4d8f:	48 39 d1             	cmp    %rdx,%rcx
    4d92:	0f 83 82 00 00 00    	jae    4e1a <fwp_drop0+0x1ca>
    4d98:	48 8b 15 19 84 00 00 	mov    0x8419(%rip),%rdx        # d1b8 <fwp_gc+0x1078>
    4d9f:	48 89 ce             	mov    %rcx,%rsi
    4da2:	48 c1 ee 10          	shr    $0x10,%rsi
    4da6:	48 69 f6 28 12 00 00 	imul   $0x1228,%rsi,%rsi
    4dad:	44 0f b6 04 32       	movzbl (%rdx,%rsi,1),%r8d
    4db2:	48 81 e1 ff ff 00 00 	and    $0xffff,%rcx
    4db9:	75 13                	jne    4dce <fwp_drop0+0x17e>
    4dbb:	41 80 f8 02          	cmp    $0x2,%r8b
    4dbf:	75 0d                	jne    4dce <fwp_drop0+0x17e>
    4dc1:	48 8d 0c 32          	lea    (%rdx,%rsi,1),%rcx
    4dc5:	48 81 c1 28 02 00 00 	add    $0x228,%rcx
    4dcc:	eb 20                	jmp    4dee <fwp_drop0+0x19e>
    4dce:	41 80 f8 01          	cmp    $0x1,%r8b
    4dd2:	75 46                	jne    4e1a <fwp_drop0+0x1ca>
    4dd4:	4c 8d 04 32          	lea    (%rdx,%rsi,1),%r8
    4dd8:	8b 54 32 20          	mov    0x20(%rdx,%rsi,1),%edx
    4ddc:	48 0f af ca          	imul   %rdx,%rcx
    4de0:	48 c1 e9 20          	shr    $0x20,%rcx
    4de4:	4c 01 c1             	add    %r8,%rcx
    4de7:	48 81 c1 28 02 00 00 	add    $0x228,%rcx
    4dee:	0f b6 11             	movzbl (%rcx),%edx
    4df1:	85 d2                	test   %edx,%edx
    4df3:	74 25                	je     4e1a <fwp_drop0+0x1ca>
    4df5:	83 fa 01             	cmp    $0x1,%edx
    4df8:	75 10                	jne    4e0a <fwp_drop0+0x1ba>
    4dfa:	48 89 fb             	mov    %rdi,%rbx
    4dfd:	48 89 c7             	mov    %rax,%rdi
    4e00:	e8 8b 19 00 00       	call   6790 <fwp_rc_free_obj>
    4e05:	48 89 df             	mov    %rbx,%rdi
    4e08:	eb 10                	jmp    4e1a <fwp_drop0+0x1ca>
    4e0a:	81 fa ff 00 00 00    	cmp    $0xff,%edx
    4e10:	0f 84 c2 00 00 00    	je     4ed8 <fwp_drop0+0x288>
    4e16:	fe ca                	dec    %dl
    4e18:	88 11                	mov    %dl,(%rcx)
    4e1a:	48 8b 47 18          	mov    0x18(%rdi),%rax
    4e1e:	48 89 c1             	mov    %rax,%rcx
    4e21:	48 2b 0d 48 83 00 00 	sub    0x8348(%rip),%rcx        # d170 <fwp_gc+0x1030>
    4e28:	48 8b 15 69 83 00 00 	mov    0x8369(%rip),%rdx        # d198 <fwp_gc+0x1058>
    4e2f:	48 c1 e2 10          	shl    $0x10,%rdx
    4e33:	48 39 d1             	cmp    %rdx,%rcx
    4e36:	73 70                	jae    4ea8 <fwp_drop0+0x258>
    4e38:	48 8b 15 79 83 00 00 	mov    0x8379(%rip),%rdx        # d1b8 <fwp_gc+0x1078>
    4e3f:	48 89 ce             	mov    %rcx,%rsi
    4e42:	48 c1 ee 10          	shr    $0x10,%rsi
    4e46:	48 69 f6 28 12 00 00 	imul   $0x1228,%rsi,%rsi
    4e4d:	44 0f b6 04 32       	movzbl (%rdx,%rsi,1),%r8d
    4e52:	48 81 e1 ff ff 00 00 	and    $0xffff,%rcx
    4e59:	75 13                	jne    4e6e <fwp_drop0+0x21e>
    4e5b:	41 80 f8 02          	cmp    $0x2,%r8b
    4e5f:	75 0d                	jne    4e6e <fwp_drop0+0x21e>
    4e61:	48 8d 0c 32          	lea    (%rdx,%rsi,1),%rcx
    4e65:	48 81 c1 28 02 00 00 	add    $0x228,%rcx
    4e6c:	eb 20                	jmp    4e8e <fwp_drop0+0x23e>
    4e6e:	41 80 f8 01          	cmp    $0x1,%r8b
    4e72:	75 34                	jne    4ea8 <fwp_drop0+0x258>
    4e74:	4c 8d 04 32          	lea    (%rdx,%rsi,1),%r8
    4e78:	8b 54 32 20          	mov    0x20(%rdx,%rsi,1),%edx
    4e7c:	48 0f af ca          	imul   %rdx,%rcx
    4e80:	48 c1 e9 20          	shr    $0x20,%rcx
    4e84:	4c 01 c1             	add    %r8,%rcx
    4e87:	48 81 c1 28 02 00 00 	add    $0x228,%rcx
    4e8e:	0f b6 11             	movzbl (%rcx),%edx
    4e91:	85 d2                	test   %edx,%edx
    4e93:	74 13                	je     4ea8 <fwp_drop0+0x258>
    4e95:	83 fa 01             	cmp    $0x1,%edx
    4e98:	75 14                	jne    4eae <fwp_drop0+0x25e>
    4e9a:	48 89 fb             	mov    %rdi,%rbx
    4e9d:	48 89 c7             	mov    %rax,%rdi
    4ea0:	e8 eb 18 00 00       	call   6790 <fwp_rc_free_obj>
    4ea5:	48 89 df             	mov    %rbx,%rdi
    4ea8:	5b                   	pop    %rbx
    4ea9:	e9 e2 18 00 00       	jmp    6790 <fwp_rc_free_obj>
    4eae:	81 fa ff 00 00 00    	cmp    $0xff,%edx
    4eb4:	74 32                	je     4ee8 <fwp_drop0+0x298>
    4eb6:	fe ca                	dec    %dl
    4eb8:	88 11                	mov    %dl,(%rcx)
    4eba:	5b                   	pop    %rbx
    4ebb:	e9 d0 18 00 00       	jmp    6790 <fwp_rc_free_obj>
    4ec0:	48 89 c7             	mov    %rax,%rdi
    4ec3:	e9 e8 15 00 00       	jmp    64b0 <fwp_rc_wide_drop>
    4ec8:	48 89 fb             	mov    %rdi,%rbx
    4ecb:	48 89 cf             	mov    %rcx,%rdi
    4ece:	e8 dd 15 00 00       	call   64b0 <fwp_rc_wide_drop>
    4ed3:	e9 89 fe ff ff       	jmp    4d61 <fwp_drop0+0x111>
    4ed8:	48 89 fb             	mov    %rdi,%rbx
    4edb:	48 89 cf             	mov    %rcx,%rdi
    4ede:	e8 cd 15 00 00       	call   64b0 <fwp_rc_wide_drop>
    4ee3:	e9 1d ff ff ff       	jmp    4e05 <fwp_drop0+0x1b5>
    4ee8:	48 89 fb             	mov    %rdi,%rbx
    4eeb:	48 89 cf             	mov    %rcx,%rdi
    4eee:	e8 bd 15 00 00       	call   64b0 <fwp_rc_wide_drop>
    4ef3:	eb b0                	jmp    4ea5 <fwp_drop0+0x255>
    4ef5:	66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
    4efc:	00 00 00 00 

0000000000004f00 <fwp_drop2>:
    4f00:	41 56                	push   %r14
    4f02:	53                   	push   %rbx
    4f03:	50                   	push   %rax
    4f04:	48 89 f8             	mov    %rdi,%rax
    4f07:	48 2b 05 62 82 00 00 	sub    0x8262(%rip),%rax        # d170 <fwp_gc+0x1030>
    4f0e:	48 8b 0d 83 82 00 00 	mov    0x8283(%rip),%rcx        # d198 <fwp_gc+0x1058>
    4f15:	48 c1 e1 10          	shl    $0x10,%rcx
    4f19:	48 39 c8             	cmp    %rcx,%rax
    4f1c:	0f 83 b3 00 00 00    	jae    4fd5 <fwp_drop2+0xd5>
    4f22:	48 8b 0d 8f 82 00 00 	mov    0x828f(%rip),%rcx        # d1b8 <fwp_gc+0x1078>
    4f29:	48 89 c2             	mov    %rax,%rdx
    4f2c:	48 c1 ea 10          	shr    $0x10,%rdx
    4f30:	48 69 d2 28 12 00 00 	imul   $0x1228,%rdx,%rdx
    4f37:	0f b6 34 11          	movzbl (%rcx,%rdx,1),%esi
    4f3b:	48 25 ff ff 00 00    	and    $0xffff,%rax
    4f41:	75 1d                	jne    4f60 <fwp_drop2+0x60>
    4f43:	40 80 fe 02          	cmp    $0x2,%sil
    4f47:	75 17                	jne    4f60 <fwp_drop2+0x60>
    4f49:	48 8d 04 11          	lea    (%rcx,%rdx,1),%rax
    4f4d:	48 05 28 02 00 00    	add    $0x228,%rax
    4f53:	eb 2a                	jmp    4f7f <fwp_drop2+0x7f>
    4f55:	66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
    4f5c:	00 00 00 00 
    4f60:	40 80 fe 01          	cmp    $0x1,%sil
    4f64:	75 6f                	jne    4fd5 <fwp_drop2+0xd5>
    4f66:	48 8d 34 11          	lea    (%rcx,%rdx,1),%rsi
    4f6a:	8b 4c 11 20          	mov    0x20(%rcx,%rdx,1),%ecx
    4f6e:	48 0f af c1          	imul   %rcx,%rax
    4f72:	48 c1 e8 20          	shr    $0x20,%rax
    4f76:	48 01 f0             	add    %rsi,%rax
    4f79:	48 05 28 02 00 00    	add    $0x228,%rax
    4f7f:	0f b6 08             	movzbl (%rax),%ecx
    4f82:	85 c9                	test   %ecx,%ecx
    4f84:	74 4f                	je     4fd5 <fwp_drop2+0xd5>
    4f86:	83 f9 01             	cmp    $0x1,%ecx
    4f89:	75 3e                	jne    4fc9 <fwp_drop2+0xc9>
    4f8b:	48 8b 47 08          	mov    0x8(%rdi),%rax
    4f8f:	48 89 fb             	mov    %rdi,%rbx
    4f92:	48 89 c7             	mov    %rax,%rdi
    4f95:	e8 b6 fc ff ff       	call   4c50 <fwp_drop0>
    4f9a:	4c 8b 73 10          	mov    0x10(%rbx),%r14
    4f9e:	48 89 df             	mov    %rbx,%rdi
    4fa1:	e8 ea 17 00 00       	call   6790 <fwp_rc_free_obj>
    4fa6:	4c 89 f0             	mov    %r14,%rax
    4fa9:	48 2b 05 c0 81 00 00 	sub    0x81c0(%rip),%rax        # d170 <fwp_gc+0x1030>
    4fb0:	48 8b 0d e1 81 00 00 	mov    0x81e1(%rip),%rcx        # d198 <fwp_gc+0x1058>
    4fb7:	48 c1 e1 10          	shl    $0x10,%rcx
    4fbb:	4c 89 f7             	mov    %r14,%rdi
    4fbe:	48 39 c8             	cmp    %rcx,%rax
    4fc1:	0f 82 5b ff ff ff    	jb     4f22 <fwp_drop2+0x22>
    4fc7:	eb 0c                	jmp    4fd5 <fwp_drop2+0xd5>
    4fc9:	81 f9 ff 00 00 00    	cmp    $0xff,%ecx
    4fcf:	74 0c                	je     4fdd <fwp_drop2+0xdd>
    4fd1:	fe c9                	dec    %cl
    4fd3:	88 08                	mov    %cl,(%rax)
    4fd5:	48 83 c4 08          	add    $0x8,%rsp
    4fd9:	5b                   	pop    %rbx
    4fda:	41 5e                	pop    %r14
    4fdc:	c3                   	ret
    4fdd:	48 89 c7             	mov    %rax,%rdi
    4fe0:	48 83 c4 08          	add    $0x8,%rsp
    4fe4:	5b                   	pop    %rbx
    4fe5:	41 5e                	pop    %r14
    4fe7:	e9 c4 14 00 00       	jmp    64b0 <fwp_rc_wide_drop>
    4fec:	0f 1f 40 00          	nopl   0x0(%rax)

0000000000004ff0 <fwp_map_items>:
    4ff0:	41 56                	push   %r14
    4ff2:	53                   	push   %rbx
    4ff3:	50                   	push   %rax
    4ff4:	48 89 fb             	mov    %rdi,%rbx
    4ff7:	48 85 ff             	test   %rdi,%rdi
    4ffa:	74 44                	je     5040 <fwp_map_items+0x50>
    4ffc:	bf 08 00 00 00       	mov    $0x8,%edi
    5001:	31 c0                	xor    %eax,%eax
    5003:	48 89 d9             	mov    %rbx,%rcx
    5006:	66 2e 0f 1f 84 00 00 	cs nopw 0x0(%rax,%rax,1)
    500d:	00 00 00 
    5010:	48 ff c0             	inc    %rax
    5013:	48 8b 49 10          	mov    0x10(%rcx),%rcx
    5017:	48 83 c7 08          	add    $0x8,%rdi
    501b:	48 85 c9             	test   %rcx,%rcx
    501e:	75 f0                	jne    5010 <fwp_map_items+0x20>
    5020:	48 89 06             	mov    %rax,(%rsi)
    5023:	48 b9 ff ff ff ff ff 	movabs $0x1fffffffffffffff,%rcx
    502a:	ff ff 1f 
    502d:	48 39 c8             	cmp    %rcx,%rax
    5030:	0f 83 d9 00 00 00    	jae    510f <fwp_map_items+0x11f>
    5036:	48 3d ff 07 00 00    	cmp    $0x7ff,%rax
    503c:	76 0e                	jbe    504c <fwp_map_items+0x5c>
    503e:	eb 6d                	jmp    50ad <fwp_map_items+0xbd>
    5040:	48 c7 06 00 00 00 00 	movq   $0x0,(%rsi)
    5047:	bf 08 00 00 00       	mov    $0x8,%edi
    504c:	48 8d 4f 0f          	lea    0xf(%rdi),%rcx
    5050:	48 c1 e9 04          	shr    $0x4,%rcx
    5054:	48 8d 05 e5 70 00 00 	lea    0x70e5(%rip),%rax        # c140 <fwp_gc>
    505b:	0f b6 8c 01 e8 0b 00 	movzbl 0xbe8(%rcx,%rax,1),%ecx
    5062:	00 
    5063:	8b 94 88 48 0b 00 00 	mov    0xb48(%rax,%rcx,4),%edx
    506a:	48 29 15 cf 70 00 00 	sub    %rdx,0x70cf(%rip)        # c140 <fwp_gc>
    5071:	78 3a                	js     50ad <fwp_map_items+0xbd>
    5073:	48 8d 0c 49          	lea    (%rcx,%rcx,2),%rcx
    5077:	48 8d 34 c8          	lea    (%rax,%rcx,8),%rsi
    507b:	48 81 c6 88 07 00 00 	add    $0x788,%rsi
    5082:	4c 8b 36             	mov    (%rsi),%r14
    5085:	4d 85 f6             	test   %r14,%r14
    5088:	74 0b                	je     5095 <fwp_map_items+0xa5>
    508a:	49 8b 06             	mov    (%r14),%rax
    508d:	48 f7 d0             	not    %rax
    5090:	48 89 06             	mov    %rax,(%rsi)
    5093:	eb 3d                	jmp    50d2 <fwp_map_items+0xe2>
    5095:	4c 8b b4 c8 90 07 00 	mov    0x790(%rax,%rcx,8),%r14
    509c:	00 
    509d:	48 8b b4 c8 98 07 00 	mov    0x798(%rax,%rcx,8),%rsi
    50a4:	00 
    50a5:	4c 29 f6             	sub    %r14,%rsi
    50a8:	48 39 d6             	cmp    %rdx,%rsi
    50ab:	73 14                	jae    50c1 <fwp_map_items+0xd1>
    50ad:	be 02 00 00 00       	mov    $0x2,%esi
    50b2:	e8 19 f0 ff ff       	call   40d0 <fwp_gc_alloc_slow>
    50b7:	49 89 c6             	mov    %rax,%r14
    50ba:	48 85 db             	test   %rbx,%rbx
    50bd:	75 22                	jne    50e1 <fwp_map_items+0xf1>
    50bf:	eb 43                	jmp    5104 <fwp_map_items+0x114>
    50c1:	48 8d 04 c8          	lea    (%rax,%rcx,8),%rax
    50c5:	48 05 90 07 00 00    	add    $0x790,%rax
    50cb:	49 8d 0c 16          	lea    (%r14,%rdx,1),%rcx
    50cf:	48 89 08             	mov    %rcx,(%rax)
    50d2:	4c 89 f7             	mov    %r14,%rdi
    50d5:	31 f6                	xor    %esi,%esi
    50d7:	e8 04 d0 ff ff       	call   20e0 <memset@plt>
    50dc:	48 85 db             	test   %rbx,%rbx
    50df:	74 23                	je     5104 <fwp_map_items+0x114>
    50e1:	4c 89 f0             	mov    %r14,%rax
    50e4:	48 89 d9             	mov    %rbx,%rcx
    50e7:	66 0f 1f 84 00 00 00 	nopw   0x0(%rax,%rax,1)
    50ee:	00 00 
    50f0:	48 8b 51 08          	mov    0x8(%rcx),%rdx
    50f4:	48 89 10             	mov    %rdx,(%rax)
    50f7:	48 8b 49 10          	mov    0x10(%rcx),%rcx
    50fb:	48 83 c0 08          	add    $0x8,%rax
    50ff:	48 85 c9             	test   %rcx,%rcx
    5102:	75 ec                	jne    50f0 <fwp_map_items+0x100>
    5104:	4c 89 f0             	mov    %r14,%rax
    5107:	48 83 c4 08          	add    $0x8,%rsp
    510b:	5b                   	pop    %rbx
    510c:	41 5e                	pop    %r14
    510e:	c3                   	ret
    510f:	e8 bc ec ff ff       	call   3dd0 <fwp_flush>
    5114:	48 8b 05 c5 6e 00 00 	mov    0x6ec5(%rip),%rax        # bfe0 <stderr@GLIBC_2.2.5>
    511b:	48 8b 38             	mov    (%rax),%rdi
    511e:	48 8d 35 93 40 00 00 	lea    0x4093(%rip),%rsi        # 91b8 <_IO_stdin_used+0x1b8>
    5125:	48 8d 15 cf 41 00 00 	lea    0x41cf(%rip),%rdx        # 92fb <_IO_stdin_used+0x2fb>
    512c:	31 c0                	xor    %eax,%eax
    512e:	e8 1d d0 ff ff       	call   2150 <fprintf@plt>
    5133:	bf 65 00 00 00       	mov    $0x65,%edi
    5138:	e8 e3 d0 ff ff       	call   2220 <exit@plt>
    513d:	0f 1f 00             	nopl   (%rax)

0000000000005140 <fwp_map_finish_protected>:
    5140:	41 57                	push   %r15
    5142:	41 56                	push   %r14
    5144:	41 54                	push   %r12
    5146:	53                   	push   %rbx
    5147:	48 83 ec 18          	sub    $0x18,%rsp
    514b:	48 89 fb             	mov    %rdi,%rbx
    514e:	48 8b 4f 08          	mov    0x8(%rdi),%rcx
    5152:	48 85 c9             	test   %rcx,%rcx
    5155:	0f 84 ee 00 00 00    	je     5249 <fwp_map_finish_protected+0x109>
    515b:	48 8b 43 10          	mov    0x10(%rbx),%rax
    515f:	49 89 e6             	mov    %rsp,%r14
    5162:	eb 3a                	jmp    519e <fwp_map_finish_protected+0x5e>
    5164:	66 66 66 2e 0f 1f 84 	data16 data16 cs nopw 0x0(%rax,%rax,1)
    516b:	00 00 00 00 00 
    5170:	4c 8d 3c 32          	lea    (%rdx,%rsi,1),%r15
    5174:	49 81 c7 28 02 00 00 	add    $0x228,%r15
    517b:	41 80 3f ff          	cmpb   $0xff,(%r15)
    517f:	0f 84 b1 00 00 00    	je     5236 <fwp_map_finish_protected+0xf6>
    5185:	41 c6 07 01          	movb   $0x1,(%r15)
    5189:	48 8b 4b 08          	mov    0x8(%rbx),%rcx
    518d:	48 ff c9             	dec    %rcx
    5190:	48 89 4b 08          	mov    %rcx,0x8(%rbx)
    5194:	48 89 43 10          	mov    %rax,0x10(%rbx)
    5198:	0f 84 af 00 00 00    	je     524d <fwp_map_finish_protected+0x10d>
    519e:	48 8b 13             	mov    (%rbx),%rdx
    51a1:	48 8b 4c ca f8       	mov    -0x8(%rdx,%rcx,8),%rcx
    51a6:	48 89 0c 24          	mov    %rcx,(%rsp)
    51aa:	48 89 44 24 08       	mov    %rax,0x8(%rsp)
    51af:	bf 01 00 00 00       	mov    $0x1,%edi
    51b4:	be 02 00 00 00       	mov    $0x2,%esi
    51b9:	4c 89 f2             	mov    %r14,%rdx
    51bc:	e8 ef ec ff ff       	call   3eb0 <fwp_data>
    51c1:	48 89 c1             	mov    %rax,%rcx
    51c4:	48 2b 0d a5 7f 00 00 	sub    0x7fa5(%rip),%rcx        # d170 <fwp_gc+0x1030>
    51cb:	48 8b 15 c6 7f 00 00 	mov    0x7fc6(%rip),%rdx        # d198 <fwp_gc+0x1058>
    51d2:	48 c1 e2 10          	shl    $0x10,%rdx
    51d6:	48 39 d1             	cmp    %rdx,%rcx
    51d9:	73 ae                	jae    5189 <fwp_map_finish_protected+0x49>
    51db:	48 8b 15 d6 7f 00 00 	mov    0x7fd6(%rip),%rdx        # d1b8 <fwp_gc+0x1078>
    51e2:	48 89 ce             	mov    %rcx,%rsi
    51e5:	48 c1 ee 10          	shr    $0x10,%rsi
    51e9:	48 69 f6 28 12 00 00 	imul   $0x1228,%rsi,%rsi
    51f0:	0f b6 3c 32          	movzbl (%rdx,%rsi,1),%edi
    51f4:	48 81 e1 ff ff 00 00 	and    $0xffff,%rcx
    51fb:	75 0a                	jne    5207 <fwp_map_finish_protected+0xc7>
    51fd:	40 80 ff 02          	cmp    $0x2,%dil
    5201:	0f 84 69 ff ff ff    	je     5170 <fwp_map_finish_protected+0x30>
    5207:	40 80 ff 01          	cmp    $0x1,%dil
    520b:	0f 85 78 ff ff ff    	jne    5189 <fwp_map_finish_protected+0x49>
    5211:	48 8d 3c 32          	lea    (%rdx,%rsi,1),%rdi
    5215:	8b 54 32 20          	mov    0x20(%rdx,%rsi,1),%edx
    5219:	48 0f af ca          	imul   %rdx,%rcx
    521d:	48 c1 e9 20          	shr    $0x20,%rcx
    5221:	4c 8d 3c 39          	lea    (%rcx,%rdi,1),%r15
    5225:	49 81 c7 28 02 00 00 	add    $0x228,%r15
    522c:	41 80 3f ff          	cmpb   $0xff,(%r15)
    5230:	0f 85 4f ff ff ff    	jne    5185 <fwp_map_finish_protected+0x45>
    5236:	4c 89 ff             	mov    %r15,%rdi
    5239:	49 89 c4             	mov    %rax,%r12
    523c:	e8 bf eb ff ff       	call   3e00 <fwp_rc_forget_slot>
    5241:	4c 89 e0             	mov    %r12,%rax
    5244:	e9 3c ff ff ff       	jmp    5185 <fwp_map_finish_protected+0x45>
    5249:	48 8b 43 10          	mov    0x10(%rbx),%rax
    524d:	48 8b 0b             	mov    (%rbx),%rcx
    5250:	48 8b 3b             	mov    (%rbx),%rdi
    5253:	48 89 c3             	mov    %rax,%rbx
    5256:	e8 e5 12 00 00       	call   6540 <fwp_mem_free>
    525b:	48 89 d8             	mov    %rbx,%rax
    525e:	48 83 c4 18          	add    $0x18,%rsp
    5262:	5b                   	pop    %rbx
    5263:	41 5c                	pop    %r12
    5265:	41 5e                	pop    %r14
    5267:	41 5f                	pop    %r15
    5269:	c3                   	ret
    526a:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)

0000000000005270 <fwp_apply>:
    5270:	55                   	push   %rbp
    5271:	48 89 e5             	mov    %rsp,%rbp
    5274:	41 57                	push   %r15
    5276:	41 56                	push   %r14
    5278:	41 55                	push   %r13
    527a:	41 54                	push   %r12
    527c:	53                   	push   %rbx
    527d:	48 83 ec 18          	sub    $0x18,%rsp
    5281:	48 89 d3             	mov    %rdx,%rbx
    5284:	49 89 ff             	mov    %rdi,%r15
    5287:	eb 23                	jmp    52ac <fwp_apply+0x3c>
    5289:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)
    5290:	4a 8d 1c f3          	lea    (%rbx,%r14,8),%rbx
    5294:	31 c9                	xor    %ecx,%ecx
    5296:	49 89 c7             	mov    %rax,%r15
    5299:	4c 8b 75 c8          	mov    -0x38(%rbp),%r14
    529d:	48 8b 65 c0          	mov    -0x40(%rbp),%rsp
    52a1:	89 d6                	mov    %edx,%esi
    52a3:	83 f9 01             	cmp    $0x1,%ecx
    52a6:	0f 84 aa 04 00 00    	je     5756 <fwp_apply+0x4e6>
    52ac:	48 8b 05 2d 89 00 00 	mov    0x892d(%rip),%rax        # dbe0 <fwp_fns>
    52b3:	41 8b 0f             	mov    (%r15),%ecx
    52b6:	45 8b 6f 04          	mov    0x4(%r15),%r13d
    52ba:	48 c1 e1 05          	shl    $0x5,%rcx
    52be:	44 8b 24 08          	mov    (%rax,%rcx,1),%r12d
    52c2:	4d 85 ed             	test   %r13,%r13
    52c5:	75 39                	jne    5300 <fwp_apply+0x90>
    52c7:	41 8d 54 24 ff       	lea    -0x1(%r12),%edx
    52cc:	39 f2                	cmp    %esi,%edx
    52ce:	73 30                	jae    5300 <fwp_apply+0x90>
    52d0:	48 89 df             	mov    %rbx,%rdi
    52d3:	49 89 f7             	mov    %rsi,%r15
    52d6:	ff 54 08 08          	call   *0x8(%rax,%rcx,1)
    52da:	4c 89 fe             	mov    %r15,%rsi
    52dd:	49 89 c7             	mov    %rax,%r15
    52e0:	44 39 e6             	cmp    %r12d,%esi
    52e3:	0f 84 a4 02 00 00    	je     558d <fwp_apply+0x31d>
    52e9:	4a 8d 1c e3          	lea    (%rbx,%r12,8),%rbx
    52ed:	44 29 e6             	sub    %r12d,%esi
    52f0:	b9 03 00 00 00       	mov    $0x3,%ecx
    52f5:	83 f9 01             	cmp    $0x1,%ecx
    52f8:	75 b2                	jne    52ac <fwp_apply+0x3c>
    52fa:	e9 57 04 00 00       	jmp    5756 <fwp_apply+0x4e6>
    52ff:	90                   	nop
    5300:	4c 89 75 c8          	mov    %r14,-0x38(%rbp)
    5304:	46 8d 34 2e          	lea    (%rsi,%r13,1),%r14d
    5308:	45 39 e6             	cmp    %r12d,%r14d
    530b:	48 89 75 d0          	mov    %rsi,-0x30(%rbp)
    530f:	0f 82 1a 02 00 00    	jb     552f <fwp_apply+0x2bf>
    5315:	48 89 65 c0          	mov    %rsp,-0x40(%rbp)
    5319:	45 89 e3             	mov    %r12d,%r11d
    531c:	41 83 fc 02          	cmp    $0x2,%r12d
    5320:	ba 01 00 00 00       	mov    $0x1,%edx
    5325:	41 0f 43 d4          	cmovae %r12d,%edx
    5329:	48 8d 14 d5 0f 00 00 	lea    0xf(,%rdx,8),%rdx
    5330:	00 
    5331:	48 83 e2 f0          	and    $0xfffffffffffffff0,%rdx
    5335:	48 89 e7             	mov    %rsp,%rdi
    5338:	48 29 d7             	sub    %rdx,%rdi
    533b:	48 89 fc             	mov    %rdi,%rsp
    533e:	4d 85 ed             	test   %r13,%r13
    5341:	0f 84 c9 00 00 00    	je     5410 <fwp_apply+0x1a0>
    5347:	41 83 fd 04          	cmp    $0x4,%r13d
    534b:	72 10                	jb     535d <fwp_apply+0xed>
    534d:	48 89 fa             	mov    %rdi,%rdx
    5350:	4c 29 fa             	sub    %r15,%rdx
    5353:	48 83 c2 f8          	add    $0xfffffffffffffff8,%rdx
    5357:	48 83 fa 20          	cmp    $0x20,%rdx
    535b:	73 65                	jae    53c2 <fwp_apply+0x152>
    535d:	31 d2                	xor    %edx,%edx
    535f:	4d 89 e8             	mov    %r13,%r8
    5362:	49 89 d2             	mov    %rdx,%r10
    5365:	49 83 e0 03          	and    $0x3,%r8
    5369:	74 16                	je     5381 <fwp_apply+0x111>
    536b:	49 89 d2             	mov    %rdx,%r10
    536e:	66 90                	xchg   %ax,%ax
    5370:	4f 8b 4c d7 08       	mov    0x8(%r15,%r10,8),%r9
    5375:	4e 89 0c d7          	mov    %r9,(%rdi,%r10,8)
    5379:	49 ff c2             	inc    %r10
    537c:	49 ff c8             	dec    %r8
    537f:	75 ef                	jne    5370 <fwp_apply+0x100>
    5381:	4c 29 ea             	sub    %r13,%rdx
    5384:	48 83 fa fc          	cmp    $0xfffffffffffffffc,%rdx
    5388:	0f 87 82 00 00 00    	ja     5410 <fwp_apply+0x1a0>
    538e:	66 90                	xchg   %ax,%ax
    5390:	4b 8b 54 d7 08       	mov    0x8(%r15,%r10,8),%rdx
    5395:	4a 89 14 d7          	mov    %rdx,(%rdi,%r10,8)
    5399:	4b 8b 54 d7 10       	mov    0x10(%r15,%r10,8),%rdx
    539e:	4a 89 54 d7 08       	mov    %rdx,0x8(%rdi,%r10,8)
    53a3:	4b 8b 54 d7 18       	mov    0x18(%r15,%r10,8),%rdx
    53a8:	4a 89 54 d7 10       	mov    %rdx,0x10(%rdi,%r10,8)
    53ad:	4b 8b 54 d7 20       	mov    0x20(%r15,%r10,8),%rdx
    53b2:	4a 89 54 d7 18       	mov    %rdx,0x18(%rdi,%r10,8)
    53b7:	49 83 c2 04          	add    $0x4,%r10
    53bb:	4d 39 d5             	cmp    %r10,%r13
    53be:	75 d0                	jne    5390 <fwp_apply+0x120>
    53c0:	eb 4e                	jmp    5410 <fwp_apply+0x1a0>
    53c2:	44 89 ea             	mov    %r13d,%edx
    53c5:	83 e2 fc             	and    $0xfffffffc,%edx
    53c8:	4e 8d 0c ed 00 00 00 	lea    0x0(,%r13,8),%r9
    53cf:	00 
    53d0:	49 83 e1 e0          	and    $0xffffffffffffffe0,%r9
    53d4:	45 31 c0             	xor    %r8d,%r8d
    53d7:	66 0f 1f 84 00 00 00 	nopw   0x0(%rax,%rax,1)
    53de:	00 00 
    53e0:	43 0f 10 44 07 08    	movups 0x8(%r15,%r8,1),%xmm0
    53e6:	43 0f 10 4c 07 18    	movups 0x18(%r15,%r8,1),%xmm1
    53ec:	42 0f 29 04 07       	movaps %xmm0,(%rdi,%r8,1)
    53f1:	42 0f 29 4c 07 10    	movaps %xmm1,0x10(%rdi,%r8,1)
    53f7:	49 83 c0 20          	add    $0x20,%r8
    53fb:	4d 39 c1             	cmp    %r8,%r9
    53fe:	75 e0                	jne    53e0 <fwp_apply+0x170>
    5400:	4c 39 ea             	cmp    %r13,%rdx
    5403:	0f 85 56 ff ff ff    	jne    535f <fwp_apply+0xef>
    5409:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)
    5410:	45 29 eb             	sub    %r13d,%r11d
    5413:	45 89 de             	mov    %r11d,%r14d
    5416:	45 39 ec             	cmp    %r13d,%r12d
    5419:	0f 84 85 00 00 00    	je     54a4 <fwp_apply+0x234>
    541f:	41 83 fb 0e          	cmp    $0xe,%r11d
    5423:	0f 83 a0 00 00 00    	jae    54c9 <fwp_apply+0x259>
    5429:	31 d2                	xor    %edx,%edx
    542b:	4d 89 f0             	mov    %r14,%r8
    542e:	48 89 d6             	mov    %rdx,%rsi
    5431:	49 83 e0 03          	and    $0x3,%r8
    5435:	74 1d                	je     5454 <fwp_apply+0x1e4>
    5437:	48 89 d6             	mov    %rdx,%rsi
    543a:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)
    5440:	4c 8b 0c f3          	mov    (%rbx,%rsi,8),%r9
    5444:	46 8d 14 2e          	lea    (%rsi,%r13,1),%r10d
    5448:	4e 89 0c d7          	mov    %r9,(%rdi,%r10,8)
    544c:	48 ff c6             	inc    %rsi
    544f:	49 ff c8             	dec    %r8
    5452:	75 ec                	jne    5440 <fwp_apply+0x1d0>
    5454:	4c 29 f2             	sub    %r14,%rdx
    5457:	48 83 fa fc          	cmp    $0xfffffffffffffffc,%rdx
    545b:	77 47                	ja     54a4 <fwp_apply+0x234>
    545d:	0f 1f 00             	nopl   (%rax)
    5460:	48 8b 14 f3          	mov    (%rbx,%rsi,8),%rdx
    5464:	46 8d 04 2e          	lea    (%rsi,%r13,1),%r8d
    5468:	4a 89 14 c7          	mov    %rdx,(%rdi,%r8,8)
    546c:	48 8b 54 f3 08       	mov    0x8(%rbx,%rsi,8),%rdx
    5471:	46 8d 04 2e          	lea    (%rsi,%r13,1),%r8d
    5475:	41 ff c0             	inc    %r8d
    5478:	4a 89 14 c7          	mov    %rdx,(%rdi,%r8,8)
    547c:	48 8b 54 f3 10       	mov    0x10(%rbx,%rsi,8),%rdx
    5481:	45 8d 44 35 02       	lea    0x2(%r13,%rsi,1),%r8d
    5486:	4a 89 14 c7          	mov    %rdx,(%rdi,%r8,8)
    548a:	48 8b 54 f3 18       	mov    0x18(%rbx,%rsi,8),%rdx
    548f:	46 8d 04 2e          	lea    (%rsi,%r13,1),%r8d
    5493:	41 83 c0 03          	add    $0x3,%r8d
    5497:	4a 89 14 c7          	mov    %rdx,(%rdi,%r8,8)
    549b:	48 83 c6 04          	add    $0x4,%rsi
    549f:	49 39 f6             	cmp    %rsi,%r14
    54a2:	75 bc                	jne    5460 <fwp_apply+0x1f0>
    54a4:	45 89 dc             	mov    %r11d,%r12d
    54a7:	ff 54 08 08          	call   *0x8(%rax,%rcx,1)
    54ab:	b9 01 00 00 00       	mov    $0x1,%ecx
    54b0:	48 8b 75 d0          	mov    -0x30(%rbp),%rsi
    54b4:	89 f2                	mov    %esi,%edx
    54b6:	44 29 e2             	sub    %r12d,%edx
    54b9:	0f 85 d1 fd ff ff    	jne    5290 <fwp_apply+0x20>
    54bf:	89 f2                	mov    %esi,%edx
    54c1:	49 89 c6             	mov    %rax,%r14
    54c4:	e9 d4 fd ff ff       	jmp    529d <fwp_apply+0x2d>
    54c9:	49 8d 56 ff          	lea    -0x1(%r14),%rdx
    54cd:	89 d6                	mov    %edx,%esi
    54cf:	44 01 ee             	add    %r13d,%esi
    54d2:	0f 82 51 ff ff ff    	jb     5429 <fwp_apply+0x1b9>
    54d8:	48 c1 ea 20          	shr    $0x20,%rdx
    54dc:	ba 00 00 00 00       	mov    $0x0,%edx
    54e1:	0f 85 44 ff ff ff    	jne    542b <fwp_apply+0x1bb>
    54e7:	4a 8d 14 ef          	lea    (%rdi,%r13,8),%rdx
    54eb:	48 29 da             	sub    %rbx,%rdx
    54ee:	48 83 fa 20          	cmp    $0x20,%rdx
    54f2:	0f 82 31 ff ff ff    	jb     5429 <fwp_apply+0x1b9>
    54f8:	44 89 f2             	mov    %r14d,%edx
    54fb:	83 e2 fc             	and    $0xfffffffc,%edx
    54fe:	31 f6                	xor    %esi,%esi
    5500:	0f 10 04 f3          	movups (%rbx,%rsi,8),%xmm0
    5504:	0f 10 4c f3 10       	movups 0x10(%rbx,%rsi,8),%xmm1
    5509:	46 8d 04 2e          	lea    (%rsi,%r13,1),%r8d
    550d:	42 0f 11 04 c7       	movups %xmm0,(%rdi,%r8,8)
    5512:	42 0f 11 4c c7 10    	movups %xmm1,0x10(%rdi,%r8,8)
    5518:	48 83 c6 04          	add    $0x4,%rsi
    551c:	48 39 f2             	cmp    %rsi,%rdx
    551f:	75 df                	jne    5500 <fwp_apply+0x290>
    5521:	4c 39 f2             	cmp    %r14,%rdx
    5524:	0f 85 01 ff ff ff    	jne    542b <fwp_apply+0x1bb>
    552a:	e9 75 ff ff ff       	jmp    54a4 <fwp_apply+0x234>
    552f:	44 89 f0             	mov    %r14d,%eax
    5532:	41 81 fe ff 07 00 00 	cmp    $0x7ff,%r14d
    5539:	77 72                	ja     55ad <fwp_apply+0x33d>
    553b:	48 8d 14 c5 00 00 00 	lea    0x0(,%rax,8),%rdx
    5542:	00 
    5543:	48 83 c2 17          	add    $0x17,%rdx
    5547:	48 c1 ea 04          	shr    $0x4,%rdx
    554b:	48 8d 0d ee 6b 00 00 	lea    0x6bee(%rip),%rcx        # c140 <fwp_gc>
    5552:	0f b6 bc 0a e8 0b 00 	movzbl 0xbe8(%rdx,%rcx,1),%edi
    5559:	00 
    555a:	8b 94 b9 48 0b 00 00 	mov    0xb48(%rcx,%rdi,4),%edx
    5561:	48 29 15 d8 6b 00 00 	sub    %rdx,0x6bd8(%rip)        # c140 <fwp_gc>
    5568:	78 43                	js     55ad <fwp_apply+0x33d>
    556a:	4c 8d 04 7f          	lea    (%rdi,%rdi,2),%r8
    556e:	4a 8d 3c c1          	lea    (%rcx,%r8,8),%rdi
    5572:	48 81 c7 88 07 00 00 	add    $0x788,%rdi
    5579:	4c 8b 27             	mov    (%rdi),%r12
    557c:	4d 85 e4             	test   %r12,%r12
    557f:	74 14                	je     5595 <fwp_apply+0x325>
    5581:	49 8b 04 24          	mov    (%r12),%rax
    5585:	48 f7 d0             	not    %rax
    5588:	48 89 07             	mov    %rax,(%rdi)
    558b:	eb 48                	jmp    55d5 <fwp_apply+0x365>
    558d:	4d 89 fe             	mov    %r15,%r14
    5590:	e9 c1 01 00 00       	jmp    5756 <fwp_apply+0x4e6>
    5595:	4e 8b a4 c1 90 07 00 	mov    0x790(%rcx,%r8,8),%r12
    559c:	00 
    559d:	4a 8b bc c1 98 07 00 	mov    0x798(%rcx,%r8,8),%rdi
    55a4:	00 
    55a5:	4c 29 e7             	sub    %r12,%rdi
    55a8:	48 39 d7             	cmp    %rdx,%rdi
    55ab:	73 17                	jae    55c4 <fwp_apply+0x354>
    55ad:	48 8d 3c c5 08 00 00 	lea    0x8(,%rax,8),%rdi
    55b4:	00 
    55b5:	be 02 00 00 00       	mov    $0x2,%esi
    55ba:	e8 11 eb ff ff       	call   40d0 <fwp_gc_alloc_slow>
    55bf:	49 89 c4             	mov    %rax,%r12
    55c2:	eb 1b                	jmp    55df <fwp_apply+0x36f>
    55c4:	4a 8d 04 c1          	lea    (%rcx,%r8,8),%rax
    55c8:	48 05 90 07 00 00    	add    $0x790,%rax
    55ce:	49 8d 0c 14          	lea    (%r12,%rdx,1),%rcx
    55d2:	48 89 08             	mov    %rcx,(%rax)
    55d5:	4c 89 e7             	mov    %r12,%rdi
    55d8:	31 f6                	xor    %esi,%esi
    55da:	e8 01 cb ff ff       	call   20e0 <memset@plt>
    55df:	41 8b 07             	mov    (%r15),%eax
    55e2:	41 89 04 24          	mov    %eax,(%r12)
    55e6:	45 89 74 24 04       	mov    %r14d,0x4(%r12)
    55eb:	4d 85 ed             	test   %r13,%r13
    55ee:	4d 89 e6             	mov    %r12,%r14
    55f1:	48 8b 7d d0          	mov    -0x30(%rbp),%rdi
    55f5:	0f 84 c6 00 00 00    	je     56c1 <fwp_apply+0x451>
    55fb:	31 c0                	xor    %eax,%eax
    55fd:	41 83 fd 06          	cmp    $0x6,%r13d
    5601:	72 53                	jb     5656 <fwp_apply+0x3e6>
    5603:	4c 89 f1             	mov    %r14,%rcx
    5606:	4c 29 f9             	sub    %r15,%rcx
    5609:	48 83 f9 20          	cmp    $0x20,%rcx
    560d:	72 47                	jb     5656 <fwp_apply+0x3e6>
    560f:	44 89 e8             	mov    %r13d,%eax
    5612:	83 e0 fc             	and    $0xfffffffc,%eax
    5615:	4a 8d 0c ed 00 00 00 	lea    0x0(,%r13,8),%rcx
    561c:	00 
    561d:	48 83 e1 e0          	and    $0xffffffffffffffe0,%rcx
    5621:	31 d2                	xor    %edx,%edx
    5623:	66 66 66 66 2e 0f 1f 	data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    562a:	84 00 00 00 00 00 
    5630:	41 0f 10 44 17 08    	movups 0x8(%r15,%rdx,1),%xmm0
    5636:	41 0f 10 4c 17 18    	movups 0x18(%r15,%rdx,1),%xmm1
    563c:	41 0f 11 44 16 08    	movups %xmm0,0x8(%r14,%rdx,1)
    5642:	41 0f 11 4c 16 18    	movups %xmm1,0x18(%r14,%rdx,1)
    5648:	48 83 c2 20          	add    $0x20,%rdx
    564c:	48 39 d1             	cmp    %rdx,%rcx
    564f:	75 df                	jne    5630 <fwp_apply+0x3c0>
    5651:	4c 39 e8             	cmp    %r13,%rax
    5654:	74 6b                	je     56c1 <fwp_apply+0x451>
    5656:	4c 89 ea             	mov    %r13,%rdx
    5659:	48 89 c1             	mov    %rax,%rcx
    565c:	48 83 e2 03          	and    $0x3,%rdx
    5660:	74 20                	je     5682 <fwp_apply+0x412>
    5662:	48 89 c1             	mov    %rax,%rcx
    5665:	66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
    566c:	00 00 00 00 
    5670:	49 8b 74 cf 08       	mov    0x8(%r15,%rcx,8),%rsi
    5675:	49 89 74 ce 08       	mov    %rsi,0x8(%r14,%rcx,8)
    567a:	48 ff c1             	inc    %rcx
    567d:	48 ff ca             	dec    %rdx
    5680:	75 ee                	jne    5670 <fwp_apply+0x400>
    5682:	4c 29 e8             	sub    %r13,%rax
    5685:	48 83 f8 fc          	cmp    $0xfffffffffffffffc,%rax
    5689:	77 36                	ja     56c1 <fwp_apply+0x451>
    568b:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)
    5690:	49 8b 44 cf 08       	mov    0x8(%r15,%rcx,8),%rax
    5695:	49 89 44 ce 08       	mov    %rax,0x8(%r14,%rcx,8)
    569a:	49 8b 44 cf 10       	mov    0x10(%r15,%rcx,8),%rax
    569f:	49 89 44 ce 10       	mov    %rax,0x10(%r14,%rcx,8)
    56a4:	49 8b 44 cf 18       	mov    0x18(%r15,%rcx,8),%rax
    56a9:	49 89 44 ce 18       	mov    %rax,0x18(%r14,%rcx,8)
    56ae:	49 8b 44 cf 20       	mov    0x20(%r15,%rcx,8),%rax
    56b3:	49 89 44 ce 20       	mov    %rax,0x20(%r14,%rcx,8)
    56b8:	48 83 c1 04          	add    $0x4,%rcx
    56bc:	49 39 cd             	cmp    %rcx,%r13
    56bf:	75 cf                	jne    5690 <fwp_apply+0x420>
    56c1:	85 ff                	test   %edi,%edi
    56c3:	0f 84 8d 00 00 00    	je     5756 <fwp_apply+0x4e6>
    56c9:	89 f8                	mov    %edi,%eax
    56cb:	83 ff 14             	cmp    $0x14,%edi
    56ce:	0f 83 94 00 00 00    	jae    5768 <fwp_apply+0x4f8>
    56d4:	31 c9                	xor    %ecx,%ecx
    56d6:	48 89 c6             	mov    %rax,%rsi
    56d9:	48 89 ca             	mov    %rcx,%rdx
    56dc:	48 83 e6 03          	and    $0x3,%rsi
    56e0:	74 23                	je     5705 <fwp_apply+0x495>
    56e2:	48 89 ca             	mov    %rcx,%rdx
    56e5:	66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
    56ec:	00 00 00 00 
    56f0:	48 8b 3c d3          	mov    (%rbx,%rdx,8),%rdi
    56f4:	46 8d 04 2a          	lea    (%rdx,%r13,1),%r8d
    56f8:	4b 89 7c c6 08       	mov    %rdi,0x8(%r14,%r8,8)
    56fd:	48 ff c2             	inc    %rdx
    5700:	48 ff ce             	dec    %rsi
    5703:	75 eb                	jne    56f0 <fwp_apply+0x480>
    5705:	48 29 c1             	sub    %rax,%rcx
    5708:	48 83 f9 fc          	cmp    $0xfffffffffffffffc,%rcx
    570c:	77 48                	ja     5756 <fwp_apply+0x4e6>
    570e:	66 90                	xchg   %ax,%ax
    5710:	48 8b 0c d3          	mov    (%rbx,%rdx,8),%rcx
    5714:	42 8d 34 2a          	lea    (%rdx,%r13,1),%esi
    5718:	49 89 4c f6 08       	mov    %rcx,0x8(%r14,%rsi,8)
    571d:	48 8b 4c d3 08       	mov    0x8(%rbx,%rdx,8),%rcx
    5722:	42 8d 34 2a          	lea    (%rdx,%r13,1),%esi
    5726:	ff c6                	inc    %esi
    5728:	49 89 4c f6 08       	mov    %rcx,0x8(%r14,%rsi,8)
    572d:	48 8b 4c d3 10       	mov    0x10(%rbx,%rdx,8),%rcx
    5732:	41 8d 74 15 02       	lea    0x2(%r13,%rdx,1),%esi
    5737:	49 89 4c f6 08       	mov    %rcx,0x8(%r14,%rsi,8)
    573c:	48 8b 4c d3 18       	mov    0x18(%rbx,%rdx,8),%rcx
    5741:	42 8d 34 2a          	lea    (%rdx,%r13,1),%esi
    5745:	83 c6 03             	add    $0x3,%esi
    5748:	49 89 4c f6 08       	mov    %rcx,0x8(%r14,%rsi,8)
    574d:	48 83 c2 04          	add    $0x4,%rdx
    5751:	48 39 d0             	cmp    %rdx,%rax
    5754:	75 ba                	jne    5710 <fwp_apply+0x4a0>
    5756:	4c 89 f0             	mov    %r14,%rax
    5759:	48 8d 65 d8          	lea    -0x28(%rbp),%rsp
    575d:	5b                   	pop    %rbx
    575e:	41 5c                	pop    %r12
    5760:	41 5d                	pop    %r13
    5762:	41 5e                	pop    %r14
    5764:	41 5f                	pop    %r15
    5766:	5d                   	pop    %rbp
    5767:	c3                   	ret
    5768:	48 8d 50 ff          	lea    -0x1(%rax),%rdx
    576c:	31 c9                	xor    %ecx,%ecx
    576e:	89 d6                	mov    %edx,%esi
    5770:	44 01 ee             	add    %r13d,%esi
    5773:	0f 82 5d ff ff ff    	jb     56d6 <fwp_apply+0x466>
    5779:	48 c1 ea 20          	shr    $0x20,%rdx
    577d:	0f 85 53 ff ff ff    	jne    56d6 <fwp_apply+0x466>
    5783:	4b 8d 0c ee          	lea    (%r14,%r13,8),%rcx
    5787:	48 29 d9             	sub    %rbx,%rcx
    578a:	48 83 c1 08          	add    $0x8,%rcx
    578e:	48 83 f9 20          	cmp    $0x20,%rcx
    5792:	0f 82 3c ff ff ff    	jb     56d4 <fwp_apply+0x464>
    5798:	89 c1                	mov    %eax,%ecx
    579a:	83 e1 fc             	and    $0xfffffffc,%ecx
    579d:	31 d2                	xor    %edx,%edx
    579f:	90                   	nop
    57a0:	0f 10 04 d3          	movups (%rbx,%rdx,8),%xmm0
    57a4:	0f 10 4c d3 10       	movups 0x10(%rbx,%rdx,8),%xmm1
    57a9:	42 8d 34 2a          	lea    (%rdx,%r13,1),%esi
    57ad:	41 0f 11 44 f6 08    	movups %xmm0,0x8(%r14,%rsi,8)
    57b3:	41 0f 11 4c f6 18    	movups %xmm1,0x18(%r14,%rsi,8)
    57b9:	48 83 c2 04          	add    $0x4,%rdx
    57bd:	48 39 d1             	cmp    %rdx,%rcx
    57c0:	75 de                	jne    57a0 <fwp_apply+0x530>
    57c2:	48 39 c1             	cmp    %rax,%rcx
    57c5:	0f 85 0b ff ff ff    	jne    56d6 <fwp_apply+0x466>
    57cb:	eb 89                	jmp    5756 <fwp_apply+0x4e6>
    57cd:	0f 1f 00             	nopl   (%rax)

00000000000057d0 <fwp_apply_owned>:
    57d0:	55                   	push   %rbp
    57d1:	48 89 e5             	mov    %rsp,%rbp
    57d4:	41 57                	push   %r15
    57d6:	41 56                	push   %r14
    57d8:	41 55                	push   %r13
    57da:	41 54                	push   %r12
    57dc:	53                   	push   %rbx
    57dd:	48 83 ec 28          	sub    $0x28,%rsp
    57e1:	48 89 d3             	mov    %rdx,%rbx
    57e4:	41 89 f5             	mov    %esi,%r13d
    57e7:	48 8b 05 f2 83 00 00 	mov    0x83f2(%rip),%rax        # dbe0 <fwp_fns>
    57ee:	8b 17                	mov    (%rdi),%edx
    57f0:	48 89 d6             	mov    %rdx,%rsi
    57f3:	48 c1 e6 05          	shl    $0x5,%rsi
    57f7:	48 8b 4c 30 18       	mov    0x18(%rax,%rsi,1),%rcx
    57fc:	48 85 c9             	test   %rcx,%rcx
    57ff:	0f 84 ca 02 00 00    	je     5acf <fwp_apply_owned+0x2ff>
    5805:	4c 8d 04 30          	lea    (%rax,%rsi,1),%r8
    5809:	49 83 c0 18          	add    $0x18,%r8
    580d:	49 89 fc             	mov    %rdi,%r12
    5810:	48 89 7d c0          	mov    %rdi,-0x40(%rbp)
    5814:	48 c1 e2 05          	shl    $0x5,%rdx
    5818:	8b 04 10             	mov    (%rax,%rdx,1),%eax
    581b:	45 8b 74 24 04       	mov    0x4(%r12),%r14d
    5820:	47 8d 3c 2e          	lea    (%r14,%r13,1),%r15d
    5824:	41 39 c7             	cmp    %eax,%r15d
    5827:	0f 82 10 03 00 00    	jb     5b3d <fwp_apply_owned+0x36d>
    582d:	41 89 c7             	mov    %eax,%r15d
    5830:	45 29 f7             	sub    %r14d,%r15d
    5833:	45 89 fa             	mov    %r15d,%r10d
    5836:	85 c0                	test   %eax,%eax
    5838:	4c 89 55 d0          	mov    %r10,-0x30(%rbp)
    583c:	74 22                	je     5860 <fwp_apply_owned+0x90>
    583e:	45 85 f6             	test   %r14d,%r14d
    5841:	75 1d                	jne    5860 <fwp_apply_owned+0x90>
    5843:	48 89 df             	mov    %rbx,%rdi
    5846:	ff 11                	call   *(%rcx)
    5848:	49 89 c4             	mov    %rax,%r12
    584b:	4c 8b 75 c0          	mov    -0x40(%rbp),%r14
    584f:	e9 35 02 00 00       	jmp    5a89 <fwp_apply_owned+0x2b9>
    5854:	66 66 66 2e 0f 1f 84 	data16 data16 cs nopw 0x0(%rax,%rax,1)
    585b:	00 00 00 00 00 
    5860:	4c 89 6d c8          	mov    %r13,-0x38(%rbp)
    5864:	48 89 65 b8          	mov    %rsp,-0x48(%rbp)
    5868:	85 c0                	test   %eax,%eax
    586a:	b9 01 00 00 00       	mov    $0x1,%ecx
    586f:	0f 45 c8             	cmovne %eax,%ecx
    5872:	48 8d 0c cd 0f 00 00 	lea    0xf(,%rcx,8),%rcx
    5879:	00 
    587a:	48 83 e1 f0          	and    $0xfffffffffffffff0,%rcx
    587e:	49 89 e5             	mov    %rsp,%r13
    5881:	49 29 cd             	sub    %rcx,%r13
    5884:	4c 89 ec             	mov    %r13,%rsp
    5887:	4d 85 f6             	test   %r14,%r14
    588a:	0f 84 d0 00 00 00    	je     5960 <fwp_apply_owned+0x190>
    5890:	41 83 fe 04          	cmp    $0x4,%r14d
    5894:	72 10                	jb     58a6 <fwp_apply_owned+0xd6>
    5896:	4c 89 e9             	mov    %r13,%rcx
    5899:	4c 29 e1             	sub    %r12,%rcx
    589c:	48 83 c1 f8          	add    $0xfffffffffffffff8,%rcx
    58a0:	48 83 f9 20          	cmp    $0x20,%rcx
    58a4:	73 6d                	jae    5913 <fwp_apply_owned+0x143>
    58a6:	31 c9                	xor    %ecx,%ecx
    58a8:	4c 89 f6             	mov    %r14,%rsi
    58ab:	48 89 ca             	mov    %rcx,%rdx
    58ae:	48 83 e6 03          	and    $0x3,%rsi
    58b2:	74 1e                	je     58d2 <fwp_apply_owned+0x102>
    58b4:	48 89 ca             	mov    %rcx,%rdx
    58b7:	66 0f 1f 84 00 00 00 	nopw   0x0(%rax,%rax,1)
    58be:	00 00 
    58c0:	49 8b 7c d4 08       	mov    0x8(%r12,%rdx,8),%rdi
    58c5:	49 89 7c d5 00       	mov    %rdi,0x0(%r13,%rdx,8)
    58ca:	48 ff c2             	inc    %rdx
    58cd:	48 ff ce             	dec    %rsi
    58d0:	75 ee                	jne    58c0 <fwp_apply_owned+0xf0>
    58d2:	4c 29 f1             	sub    %r14,%rcx
    58d5:	48 83 f9 fc          	cmp    $0xfffffffffffffffc,%rcx
    58d9:	0f 87 81 00 00 00    	ja     5960 <fwp_apply_owned+0x190>
    58df:	90                   	nop
    58e0:	49 8b 4c d4 08       	mov    0x8(%r12,%rdx,8),%rcx
    58e5:	49 89 4c d5 00       	mov    %rcx,0x0(%r13,%rdx,8)
    58ea:	49 8b 4c d4 10       	mov    0x10(%r12,%rdx,8),%rcx
    58ef:	49 89 4c d5 08       	mov    %rcx,0x8(%r13,%rdx,8)
    58f4:	49 8b 4c d4 18       	mov    0x18(%r12,%rdx,8),%rcx
    58f9:	49 89 4c d5 10       	mov    %rcx,0x10(%r13,%rdx,8)
    58fe:	49 8b 4c d4 20       	mov    0x20(%r12,%rdx,8),%rcx
    5903:	49 89 4c d5 18       	mov    %rcx,0x18(%r13,%rdx,8)
    5908:	48 83 c2 04          	add    $0x4,%rdx
    590c:	49 39 d6             	cmp    %rdx,%r14
    590f:	75 cf                	jne    58e0 <fwp_apply_owned+0x110>
    5911:	eb 4d                	jmp    5960 <fwp_apply_owned+0x190>
    5913:	44 89 f1             	mov    %r14d,%ecx
    5916:	83 e1 fc             	and    $0xfffffffc,%ecx
    5919:	4a 8d 14 f5 00 00 00 	lea    0x0(,%r14,8),%rdx
    5920:	00 
    5921:	48 83 e2 e0          	and    $0xffffffffffffffe0,%rdx
    5925:	31 f6                	xor    %esi,%esi
    5927:	66 0f 1f 84 00 00 00 	nopw   0x0(%rax,%rax,1)
    592e:	00 00 
    5930:	41 0f 10 44 34 08    	movups 0x8(%r12,%rsi,1),%xmm0
    5936:	41 0f 10 4c 34 18    	movups 0x18(%r12,%rsi,1),%xmm1
    593c:	41 0f 29 44 35 00    	movaps %xmm0,0x0(%r13,%rsi,1)
    5942:	41 0f 29 4c 35 10    	movaps %xmm1,0x10(%r13,%rsi,1)
    5948:	48 83 c6 20          	add    $0x20,%rsi
    594c:	48 39 f2             	cmp    %rsi,%rdx
    594f:	75 df                	jne    5930 <fwp_apply_owned+0x160>
    5951:	4c 39 f1             	cmp    %r14,%rcx
    5954:	0f 85 4e ff ff ff    	jne    58a8 <fwp_apply_owned+0xd8>
    595a:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)
    5960:	44 39 f0             	cmp    %r14d,%eax
    5963:	0f 84 f7 00 00 00    	je     5a60 <fwp_apply_owned+0x290>
    5969:	41 83 ff 0a          	cmp    $0xa,%r15d
    596d:	0f 83 95 00 00 00    	jae    5a08 <fwp_apply_owned+0x238>
    5973:	31 c0                	xor    %eax,%eax
    5975:	4c 89 d2             	mov    %r10,%rdx
    5978:	48 89 c1             	mov    %rax,%rcx
    597b:	48 83 e2 03          	and    $0x3,%rdx
    597f:	74 24                	je     59a5 <fwp_apply_owned+0x1d5>
    5981:	48 89 c1             	mov    %rax,%rcx
    5984:	66 66 66 2e 0f 1f 84 	data16 data16 cs nopw 0x0(%rax,%rax,1)
    598b:	00 00 00 00 00 
    5990:	48 8b 34 cb          	mov    (%rbx,%rcx,8),%rsi
    5994:	41 8d 3c 0e          	lea    (%r14,%rcx,1),%edi
    5998:	49 89 74 fd 00       	mov    %rsi,0x0(%r13,%rdi,8)
    599d:	48 ff c1             	inc    %rcx
    59a0:	48 ff ca             	dec    %rdx
    59a3:	75 eb                	jne    5990 <fwp_apply_owned+0x1c0>
    59a5:	4c 29 d0             	sub    %r10,%rax
    59a8:	48 83 f8 fc          	cmp    $0xfffffffffffffffc,%rax
    59ac:	0f 87 ae 00 00 00    	ja     5a60 <fwp_apply_owned+0x290>
    59b2:	66 66 66 66 66 2e 0f 	data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    59b9:	1f 84 00 00 00 00 00 
    59c0:	48 8b 04 cb          	mov    (%rbx,%rcx,8),%rax
    59c4:	41 8d 14 0e          	lea    (%r14,%rcx,1),%edx
    59c8:	49 89 44 d5 00       	mov    %rax,0x0(%r13,%rdx,8)
    59cd:	48 8b 44 cb 08       	mov    0x8(%rbx,%rcx,8),%rax
    59d2:	41 8d 14 0e          	lea    (%r14,%rcx,1),%edx
    59d6:	ff c2                	inc    %edx
    59d8:	49 89 44 d5 00       	mov    %rax,0x0(%r13,%rdx,8)
    59dd:	48 8b 44 cb 10       	mov    0x10(%rbx,%rcx,8),%rax
    59e2:	41 8d 54 0e 02       	lea    0x2(%r14,%rcx,1),%edx
    59e7:	49 89 44 d5 00       	mov    %rax,0x0(%r13,%rdx,8)
    59ec:	48 8b 44 cb 18       	mov    0x18(%rbx,%rcx,8),%rax
    59f1:	41 8d 14 0e          	lea    (%r14,%rcx,1),%edx
    59f5:	83 c2 03             	add    $0x3,%edx
    59f8:	49 89 44 d5 00       	mov    %rax,0x0(%r13,%rdx,8)
    59fd:	48 83 c1 04          	add    $0x4,%rcx
    5a01:	49 39 ca             	cmp    %rcx,%r10
    5a04:	75 ba                	jne    59c0 <fwp_apply_owned+0x1f0>
    5a06:	eb 58                	jmp    5a60 <fwp_apply_owned+0x290>
    5a08:	49 8d 42 ff          	lea    -0x1(%r10),%rax
    5a0c:	89 c1                	mov    %eax,%ecx
    5a0e:	44 01 f1             	add    %r14d,%ecx
    5a11:	0f 82 5c ff ff ff    	jb     5973 <fwp_apply_owned+0x1a3>
    5a17:	48 c1 e8 20          	shr    $0x20,%rax
    5a1b:	b8 00 00 00 00       	mov    $0x0,%eax
    5a20:	0f 85 4f ff ff ff    	jne    5975 <fwp_apply_owned+0x1a5>
    5a26:	44 89 d0             	mov    %r10d,%eax
    5a29:	83 e0 fc             	and    $0xfffffffc,%eax
    5a2c:	31 c9                	xor    %ecx,%ecx
    5a2e:	66 90                	xchg   %ax,%ax
    5a30:	0f 10 04 cb          	movups (%rbx,%rcx,8),%xmm0
    5a34:	0f 10 4c cb 10       	movups 0x10(%rbx,%rcx,8),%xmm1
    5a39:	41 8d 14 0e          	lea    (%r14,%rcx,1),%edx
    5a3d:	41 0f 11 44 d5 00    	movups %xmm0,0x0(%r13,%rdx,8)
    5a43:	41 0f 11 4c d5 10    	movups %xmm1,0x10(%r13,%rdx,8)
    5a49:	48 83 c1 04          	add    $0x4,%rcx
    5a4d:	48 39 c8             	cmp    %rcx,%rax
    5a50:	75 de                	jne    5a30 <fwp_apply_owned+0x260>
    5a52:	4c 39 d0             	cmp    %r10,%rax
    5a55:	0f 85 1a ff ff ff    	jne    5975 <fwp_apply_owned+0x1a5>
    5a5b:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)
    5a60:	49 8b 00             	mov    (%r8),%rax
    5a63:	4c 8b 75 c0          	mov    -0x40(%rbp),%r14
    5a67:	4c 89 f7             	mov    %r14,%rdi
    5a6a:	be 01 00 00 00       	mov    $0x1,%esi
    5a6f:	4d 89 c4             	mov    %r8,%r12
    5a72:	ff 50 08             	call   *0x8(%rax)
    5a75:	49 8b 04 24          	mov    (%r12),%rax
    5a79:	4c 89 ef             	mov    %r13,%rdi
    5a7c:	ff 10                	call   *(%rax)
    5a7e:	49 89 c4             	mov    %rax,%r12
    5a81:	48 8b 65 b8          	mov    -0x48(%rbp),%rsp
    5a85:	4c 8b 6d c8          	mov    -0x38(%rbp),%r13
    5a89:	4c 89 f7             	mov    %r14,%rdi
    5a8c:	e8 0f 07 00 00       	call   61a0 <fwp_closure_drop>
    5a91:	45 29 fd             	sub    %r15d,%r13d
    5a94:	0f 84 89 05 00 00    	je     6023 <fwp_apply_owned+0x853>
    5a9a:	48 8b 45 d0          	mov    -0x30(%rbp),%rax
    5a9e:	48 8d 1c c3          	lea    (%rbx,%rax,8),%rbx
    5aa2:	48 8b 05 37 81 00 00 	mov    0x8137(%rip),%rax        # dbe0 <fwp_fns>
    5aa9:	41 8b 14 24          	mov    (%r12),%edx
    5aad:	48 89 d1             	mov    %rdx,%rcx
    5ab0:	48 c1 e1 05          	shl    $0x5,%rcx
    5ab4:	4c 8d 04 08          	lea    (%rax,%rcx,1),%r8
    5ab8:	49 83 c0 18          	add    $0x18,%r8
    5abc:	48 8b 4c 08 18       	mov    0x18(%rax,%rcx,1),%rcx
    5ac1:	4c 89 e7             	mov    %r12,%rdi
    5ac4:	48 85 c9             	test   %rcx,%rcx
    5ac7:	0f 85 43 fd ff ff    	jne    5810 <fwp_apply_owned+0x40>
    5acd:	eb 03                	jmp    5ad2 <fwp_apply_owned+0x302>
    5acf:	49 89 fc             	mov    %rdi,%r12
    5ad2:	48 8b 05 97 76 00 00 	mov    0x7697(%rip),%rax        # d170 <fwp_gc+0x1030>
    5ad9:	4c 89 e2             	mov    %r12,%rdx
    5adc:	48 29 c2             	sub    %rax,%rdx
    5adf:	48 8b 0d b2 76 00 00 	mov    0x76b2(%rip),%rcx        # d198 <fwp_gc+0x1058>
    5ae6:	48 c1 e1 10          	shl    $0x10,%rcx
    5aea:	48 39 ca             	cmp    %rcx,%rdx
    5aed:	0f 83 12 01 00 00    	jae    5c05 <fwp_apply_owned+0x435>
    5af3:	48 8b 35 be 76 00 00 	mov    0x76be(%rip),%rsi        # d1b8 <fwp_gc+0x1078>
    5afa:	48 89 d7             	mov    %rdx,%rdi
    5afd:	48 c1 ef 10          	shr    $0x10,%rdi
    5b01:	48 69 ff 28 12 00 00 	imul   $0x1228,%rdi,%rdi
    5b08:	44 0f b6 04 3e       	movzbl (%rsi,%rdi,1),%r8d
    5b0d:	48 81 e2 ff ff 00 00 	and    $0xffff,%rdx
    5b14:	0f 85 c2 00 00 00    	jne    5bdc <fwp_apply_owned+0x40c>
    5b1a:	41 80 f8 02          	cmp    $0x2,%r8b
    5b1e:	0f 85 b8 00 00 00    	jne    5bdc <fwp_apply_owned+0x40c>
    5b24:	48 8d 14 3e          	lea    (%rsi,%rdi,1),%rdx
    5b28:	48 81 c2 28 02 00 00 	add    $0x228,%rdx
    5b2f:	80 3a 00             	cmpb   $0x0,(%rdx)
    5b32:	0f 84 cd 00 00 00    	je     5c05 <fwp_apply_owned+0x435>
    5b38:	e9 55 01 00 00       	jmp    5c92 <fwp_apply_owned+0x4c2>
    5b3d:	4c 89 45 d0          	mov    %r8,-0x30(%rbp)
    5b41:	4c 89 6d c8          	mov    %r13,-0x38(%rbp)
    5b45:	44 89 f9             	mov    %r15d,%ecx
    5b48:	48 8d 3c cd 08 00 00 	lea    0x8(,%rcx,8),%rdi
    5b4f:	00 
    5b50:	41 81 ff ff 07 00 00 	cmp    $0x7ff,%r15d
    5b57:	0f 87 f0 01 00 00    	ja     5d4d <fwp_apply_owned+0x57d>
    5b5d:	48 c1 e1 03          	shl    $0x3,%rcx
    5b61:	4c 8d 41 17          	lea    0x17(%rcx),%r8
    5b65:	49 c1 e8 04          	shr    $0x4,%r8
    5b69:	48 8d 05 d0 65 00 00 	lea    0x65d0(%rip),%rax        # c140 <fwp_gc>
    5b70:	41 0f b6 b4 00 e8 0b 	movzbl 0xbe8(%r8,%rax,1),%esi
    5b77:	00 00 
    5b79:	8b 94 b0 48 0b 00 00 	mov    0xb48(%rax,%rsi,4),%edx
    5b80:	4c 8b 0d b9 65 00 00 	mov    0x65b9(%rip),%r9        # c140 <fwp_gc>
    5b87:	4d 89 ca             	mov    %r9,%r10
    5b8a:	49 29 d2             	sub    %rdx,%r10
    5b8d:	4c 89 15 ac 65 00 00 	mov    %r10,0x65ac(%rip)        # c140 <fwp_gc>
    5b94:	0f 88 b3 01 00 00    	js     5d4d <fwp_apply_owned+0x57d>
    5b9a:	4c 8d 14 76          	lea    (%rsi,%rsi,2),%r10
    5b9e:	4e 8d 1c d0          	lea    (%rax,%r10,8),%r11
    5ba2:	49 83 c3 08          	add    $0x8,%r11
    5ba6:	4d 8b 2b             	mov    (%r11),%r13
    5ba9:	4d 85 ed             	test   %r13,%r13
    5bac:	0f 84 24 01 00 00    	je     5cd6 <fwp_apply_owned+0x506>
    5bb2:	49 8b 45 00          	mov    0x0(%r13),%rax
    5bb6:	48 f7 d0             	not    %rax
    5bb9:	49 89 03             	mov    %rax,(%r11)
    5bbc:	48 39 d7             	cmp    %rdx,%rdi
    5bbf:	0f 83 ad 01 00 00    	jae    5d72 <fwp_apply_owned+0x5a2>
    5bc5:	4c 01 ef             	add    %r13,%rdi
    5bc8:	48 29 ca             	sub    %rcx,%rdx
    5bcb:	48 83 c2 f7          	add    $0xfffffffffffffff7,%rdx
    5bcf:	48 83 e2 f8          	and    $0xfffffffffffffff8,%rdx
    5bd3:	48 83 c2 08          	add    $0x8,%rdx
    5bd7:	e9 8f 01 00 00       	jmp    5d6b <fwp_apply_owned+0x59b>
    5bdc:	41 80 f8 01          	cmp    $0x1,%r8b
    5be0:	75 23                	jne    5c05 <fwp_apply_owned+0x435>
    5be2:	4c 8d 04 3e          	lea    (%rsi,%rdi,1),%r8
    5be6:	8b 74 3e 20          	mov    0x20(%rsi,%rdi,1),%esi
    5bea:	48 0f af d6          	imul   %rsi,%rdx
    5bee:	48 c1 ea 20          	shr    $0x20,%rdx
    5bf2:	4c 01 c2             	add    %r8,%rdx
    5bf5:	48 81 c2 28 02 00 00 	add    $0x228,%rdx
    5bfc:	80 3a 00             	cmpb   $0x0,(%rdx)
    5bff:	0f 85 8d 00 00 00    	jne    5c92 <fwp_apply_owned+0x4c2>
    5c05:	45 85 ed             	test   %r13d,%r13d
    5c08:	0f 84 b2 00 00 00    	je     5cc0 <fwp_apply_owned+0x4f0>
    5c0e:	48 8b 15 a3 75 00 00 	mov    0x75a3(%rip),%rdx        # d1b8 <fwp_gc+0x1078>
    5c15:	44 89 ee             	mov    %r13d,%esi
    5c18:	31 ff                	xor    %edi,%edi
    5c1a:	eb 21                	jmp    5c3d <fwp_apply_owned+0x46d>
    5c1c:	0f 1f 40 00          	nopl   0x0(%rax)
    5c20:	4e 8d 04 0a          	lea    (%rdx,%r9,1),%r8
    5c24:	49 81 c0 28 02 00 00 	add    $0x228,%r8
    5c2b:	41 80 38 00          	cmpb   $0x0,(%r8)
    5c2f:	75 61                	jne    5c92 <fwp_apply_owned+0x4c2>
    5c31:	48 ff c7             	inc    %rdi
    5c34:	48 39 fe             	cmp    %rdi,%rsi
    5c37:	0f 84 83 00 00 00    	je     5cc0 <fwp_apply_owned+0x4f0>
    5c3d:	4c 8b 04 fb          	mov    (%rbx,%rdi,8),%r8
    5c41:	49 29 c0             	sub    %rax,%r8
    5c44:	49 39 c8             	cmp    %rcx,%r8
    5c47:	73 e8                	jae    5c31 <fwp_apply_owned+0x461>
    5c49:	4d 89 c1             	mov    %r8,%r9
    5c4c:	49 c1 e9 10          	shr    $0x10,%r9
    5c50:	4d 69 c9 28 12 00 00 	imul   $0x1228,%r9,%r9
    5c57:	46 0f b6 14 0a       	movzbl (%rdx,%r9,1),%r10d
    5c5c:	49 81 e0 ff ff 00 00 	and    $0xffff,%r8
    5c63:	75 06                	jne    5c6b <fwp_apply_owned+0x49b>
    5c65:	41 80 fa 02          	cmp    $0x2,%r10b
    5c69:	74 b5                	je     5c20 <fwp_apply_owned+0x450>
    5c6b:	41 80 fa 01          	cmp    $0x1,%r10b
    5c6f:	75 c0                	jne    5c31 <fwp_apply_owned+0x461>
    5c71:	4e 8d 14 0a          	lea    (%rdx,%r9,1),%r10
    5c75:	46 8b 4c 0a 20       	mov    0x20(%rdx,%r9,1),%r9d
    5c7a:	4d 0f af c1          	imul   %r9,%r8
    5c7e:	49 c1 e8 20          	shr    $0x20,%r8
    5c82:	4d 01 d0             	add    %r10,%r8
    5c85:	49 81 c0 28 02 00 00 	add    $0x228,%r8
    5c8c:	41 80 38 00          	cmpb   $0x0,(%r8)
    5c90:	74 9f                	je     5c31 <fwp_apply_owned+0x461>
    5c92:	e8 39 e1 ff ff       	call   3dd0 <fwp_flush>
    5c97:	48 8b 05 42 63 00 00 	mov    0x6342(%rip),%rax        # bfe0 <stderr@GLIBC_2.2.5>
    5c9e:	48 8b 38             	mov    (%rax),%rdi
    5ca1:	48 8d 35 10 35 00 00 	lea    0x3510(%rip),%rsi        # 91b8 <_IO_stdin_used+0x1b8>
    5ca8:	48 8d 15 dc 34 00 00 	lea    0x34dc(%rip),%rdx        # 918b <_IO_stdin_used+0x18b>
    5caf:	31 c0                	xor    %eax,%eax
    5cb1:	e8 9a c4 ff ff       	call   2150 <fprintf@plt>
    5cb6:	bf 65 00 00 00       	mov    $0x65,%edi
    5cbb:	e8 60 c5 ff ff       	call   2220 <exit@plt>
    5cc0:	4c 89 e7             	mov    %r12,%rdi
    5cc3:	44 89 ee             	mov    %r13d,%esi
    5cc6:	48 89 da             	mov    %rbx,%rdx
    5cc9:	e8 a2 f5 ff ff       	call   5270 <fwp_apply>
    5cce:	49 89 c4             	mov    %rax,%r12
    5cd1:	e9 4d 03 00 00       	jmp    6023 <fwp_apply_owned+0x853>
    5cd6:	4e 8b 6c d0 10       	mov    0x10(%rax,%r10,8),%r13
    5cdb:	4e 8b 5c d0 18       	mov    0x18(%rax,%r10,8),%r11
    5ce0:	4d 29 eb             	sub    %r13,%r11
    5ce3:	49 39 d3             	cmp    %rdx,%r11
    5ce6:	72 34                	jb     5d1c <fwp_apply_owned+0x54c>
    5ce8:	4a 8d 34 d0          	lea    (%rax,%r10,8),%rsi
    5cec:	48 83 c6 10          	add    $0x10,%rsi
    5cf0:	4e 8d 14 2a          	lea    (%rdx,%r13,1),%r10
    5cf4:	4c 89 16             	mov    %r10,(%rsi)
    5cf7:	4d 85 ed             	test   %r13,%r13
    5cfa:	0f 85 bc fe ff ff    	jne    5bbc <fwp_apply_owned+0x3ec>
    5d00:	41 0f b6 b4 00 e8 0b 	movzbl 0xbe8(%r8,%rax,1),%esi
    5d07:	00 00 
    5d09:	8b 94 b0 48 0b 00 00 	mov    0xb48(%rax,%rsi,4),%edx
    5d10:	49 29 d1             	sub    %rdx,%r9
    5d13:	4c 89 0d 26 64 00 00 	mov    %r9,0x6426(%rip)        # c140 <fwp_gc>
    5d1a:	78 31                	js     5d4d <fwp_apply_owned+0x57d>
    5d1c:	48 8d 0c 76          	lea    (%rsi,%rsi,2),%rcx
    5d20:	4c 8b 6c c8 08       	mov    0x8(%rax,%rcx,8),%r13
    5d25:	4d 85 ed             	test   %r13,%r13
    5d28:	74 11                	je     5d3b <fwp_apply_owned+0x56b>
    5d2a:	48 8d 04 c8          	lea    (%rax,%rcx,8),%rax
    5d2e:	48 83 c0 08          	add    $0x8,%rax
    5d32:	49 8b 4d 00          	mov    0x0(%r13),%rcx
    5d36:	48 f7 d1             	not    %rcx
    5d39:	eb 2a                	jmp    5d65 <fwp_apply_owned+0x595>
    5d3b:	4c 8b 6c c8 10       	mov    0x10(%rax,%rcx,8),%r13
    5d40:	48 8b 74 c8 18       	mov    0x18(%rax,%rcx,8),%rsi
    5d45:	4c 29 ee             	sub    %r13,%rsi
    5d48:	48 39 d6             	cmp    %rdx,%rsi
    5d4b:	73 0c                	jae    5d59 <fwp_apply_owned+0x589>
    5d4d:	31 f6                	xor    %esi,%esi
    5d4f:	e8 7c e3 ff ff       	call   40d0 <fwp_gc_alloc_slow>
    5d54:	49 89 c5             	mov    %rax,%r13
    5d57:	eb 19                	jmp    5d72 <fwp_apply_owned+0x5a2>
    5d59:	48 8d 04 c8          	lea    (%rax,%rcx,8),%rax
    5d5d:	48 83 c0 10          	add    $0x10,%rax
    5d61:	4a 8d 0c 2a          	lea    (%rdx,%r13,1),%rcx
    5d65:	48 89 08             	mov    %rcx,(%rax)
    5d68:	4c 89 ef             	mov    %r13,%rdi
    5d6b:	31 f6                	xor    %esi,%esi
    5d6d:	e8 6e c3 ff ff       	call   20e0 <memset@plt>
    5d72:	4c 8b 4d d0          	mov    -0x30(%rbp),%r9
    5d76:	41 8b 04 24          	mov    (%r12),%eax
    5d7a:	41 89 45 00          	mov    %eax,0x0(%r13)
    5d7e:	45 89 7d 04          	mov    %r15d,0x4(%r13)
    5d82:	4d 85 f6             	test   %r14,%r14
    5d85:	0f 84 c6 00 00 00    	je     5e51 <fwp_apply_owned+0x681>
    5d8b:	31 c0                	xor    %eax,%eax
    5d8d:	41 83 fe 06          	cmp    $0x6,%r14d
    5d91:	72 53                	jb     5de6 <fwp_apply_owned+0x616>
    5d93:	4c 89 e9             	mov    %r13,%rcx
    5d96:	4c 29 e1             	sub    %r12,%rcx
    5d99:	48 83 f9 20          	cmp    $0x20,%rcx
    5d9d:	72 47                	jb     5de6 <fwp_apply_owned+0x616>
    5d9f:	44 89 f0             	mov    %r14d,%eax
    5da2:	83 e0 fc             	and    $0xfffffffc,%eax
    5da5:	4a 8d 0c f5 00 00 00 	lea    0x0(,%r14,8),%rcx
    5dac:	00 
    5dad:	48 83 e1 e0          	and    $0xffffffffffffffe0,%rcx
    5db1:	31 d2                	xor    %edx,%edx
    5db3:	66 66 66 66 2e 0f 1f 	data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    5dba:	84 00 00 00 00 00 
    5dc0:	41 0f 10 44 14 08    	movups 0x8(%r12,%rdx,1),%xmm0
    5dc6:	41 0f 10 4c 14 18    	movups 0x18(%r12,%rdx,1),%xmm1
    5dcc:	41 0f 11 44 15 08    	movups %xmm0,0x8(%r13,%rdx,1)
    5dd2:	41 0f 11 4c 15 18    	movups %xmm1,0x18(%r13,%rdx,1)
    5dd8:	48 83 c2 20          	add    $0x20,%rdx
    5ddc:	48 39 d1             	cmp    %rdx,%rcx
    5ddf:	75 df                	jne    5dc0 <fwp_apply_owned+0x5f0>
    5de1:	4c 39 f0             	cmp    %r14,%rax
    5de4:	74 6b                	je     5e51 <fwp_apply_owned+0x681>
    5de6:	4c 89 f2             	mov    %r14,%rdx
    5de9:	48 89 c1             	mov    %rax,%rcx
    5dec:	48 83 e2 03          	and    $0x3,%rdx
    5df0:	74 20                	je     5e12 <fwp_apply_owned+0x642>
    5df2:	48 89 c1             	mov    %rax,%rcx
    5df5:	66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
    5dfc:	00 00 00 00 
    5e00:	49 8b 74 cc 08       	mov    0x8(%r12,%rcx,8),%rsi
    5e05:	49 89 74 cd 08       	mov    %rsi,0x8(%r13,%rcx,8)
    5e0a:	48 ff c1             	inc    %rcx
    5e0d:	48 ff ca             	dec    %rdx
    5e10:	75 ee                	jne    5e00 <fwp_apply_owned+0x630>
    5e12:	4c 29 f0             	sub    %r14,%rax
    5e15:	48 83 f8 fc          	cmp    $0xfffffffffffffffc,%rax
    5e19:	77 36                	ja     5e51 <fwp_apply_owned+0x681>
    5e1b:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)
    5e20:	49 8b 44 cc 08       	mov    0x8(%r12,%rcx,8),%rax
    5e25:	49 89 44 cd 08       	mov    %rax,0x8(%r13,%rcx,8)
    5e2a:	49 8b 44 cc 10       	mov    0x10(%r12,%rcx,8),%rax
    5e2f:	49 89 44 cd 10       	mov    %rax,0x10(%r13,%rcx,8)
    5e34:	49 8b 44 cc 18       	mov    0x18(%r12,%rcx,8),%rax
    5e39:	49 89 44 cd 18       	mov    %rax,0x18(%r13,%rcx,8)
    5e3e:	49 8b 44 cc 20       	mov    0x20(%r12,%rcx,8),%rax
    5e43:	49 89 44 cd 20       	mov    %rax,0x20(%r13,%rcx,8)
    5e48:	48 83 c1 04          	add    $0x4,%rcx
    5e4c:	49 39 ce             	cmp    %rcx,%r14
    5e4f:	75 cf                	jne    5e20 <fwp_apply_owned+0x650>
    5e51:	48 8b 4d c8          	mov    -0x38(%rbp),%rcx
    5e55:	85 c9                	test   %ecx,%ecx
    5e57:	0f 84 89 00 00 00    	je     5ee6 <fwp_apply_owned+0x716>
    5e5d:	89 c8                	mov    %ecx,%eax
    5e5f:	83 f9 14             	cmp    $0x14,%ecx
    5e62:	0f 83 fb 00 00 00    	jae    5f63 <fwp_apply_owned+0x793>
    5e68:	31 c9                	xor    %ecx,%ecx
    5e6a:	48 89 c6             	mov    %rax,%rsi
    5e6d:	48 89 ca             	mov    %rcx,%rdx
    5e70:	48 83 e6 03          	and    $0x3,%rsi
    5e74:	74 1f                	je     5e95 <fwp_apply_owned+0x6c5>
    5e76:	48 89 ca             	mov    %rcx,%rdx
    5e79:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)
    5e80:	48 8b 3c d3          	mov    (%rbx,%rdx,8),%rdi
    5e84:	45 8d 04 16          	lea    (%r14,%rdx,1),%r8d
    5e88:	4b 89 7c c5 08       	mov    %rdi,0x8(%r13,%r8,8)
    5e8d:	48 ff c2             	inc    %rdx
    5e90:	48 ff ce             	dec    %rsi
    5e93:	75 eb                	jne    5e80 <fwp_apply_owned+0x6b0>
    5e95:	48 29 c1             	sub    %rax,%rcx
    5e98:	48 83 f9 fc          	cmp    $0xfffffffffffffffc,%rcx
    5e9c:	77 48                	ja     5ee6 <fwp_apply_owned+0x716>
    5e9e:	66 90                	xchg   %ax,%ax
    5ea0:	48 8b 0c d3          	mov    (%rbx,%rdx,8),%rcx
    5ea4:	41 8d 34 16          	lea    (%r14,%rdx,1),%esi
    5ea8:	49 89 4c f5 08       	mov    %rcx,0x8(%r13,%rsi,8)
    5ead:	48 8b 4c d3 08       	mov    0x8(%rbx,%rdx,8),%rcx
    5eb2:	41 8d 34 16          	lea    (%r14,%rdx,1),%esi
    5eb6:	ff c6                	inc    %esi
    5eb8:	49 89 4c f5 08       	mov    %rcx,0x8(%r13,%rsi,8)
    5ebd:	48 8b 4c d3 10       	mov    0x10(%rbx,%rdx,8),%rcx
    5ec2:	41 8d 74 16 02       	lea    0x2(%r14,%rdx,1),%esi
    5ec7:	49 89 4c f5 08       	mov    %rcx,0x8(%r13,%rsi,8)
    5ecc:	48 8b 4c d3 18       	mov    0x18(%rbx,%rdx,8),%rcx
    5ed1:	41 8d 34 16          	lea    (%r14,%rdx,1),%esi
    5ed5:	83 c6 03             	add    $0x3,%esi
    5ed8:	49 89 4c f5 08       	mov    %rcx,0x8(%r13,%rsi,8)
    5edd:	48 83 c2 04          	add    $0x4,%rdx
    5ee1:	48 39 d0             	cmp    %rdx,%rax
    5ee4:	75 ba                	jne    5ea0 <fwp_apply_owned+0x6d0>
    5ee6:	49 8b 01             	mov    (%r9),%rax
    5ee9:	4c 8b 75 c0          	mov    -0x40(%rbp),%r14
    5eed:	4c 89 f7             	mov    %r14,%rdi
    5ef0:	be 01 00 00 00       	mov    $0x1,%esi
    5ef5:	ff 50 08             	call   *0x8(%rax)
    5ef8:	4c 89 e8             	mov    %r13,%rax
    5efb:	48 2b 05 6e 72 00 00 	sub    0x726e(%rip),%rax        # d170 <fwp_gc+0x1030>
    5f02:	48 8b 0d 8f 72 00 00 	mov    0x728f(%rip),%rcx        # d198 <fwp_gc+0x1058>
    5f09:	48 c1 e1 10          	shl    $0x10,%rcx
    5f0d:	48 39 c8             	cmp    %rcx,%rax
    5f10:	0f 83 02 01 00 00    	jae    6018 <fwp_apply_owned+0x848>
    5f16:	48 8b 0d 9b 72 00 00 	mov    0x729b(%rip),%rcx        # d1b8 <fwp_gc+0x1078>
    5f1d:	48 89 c2             	mov    %rax,%rdx
    5f20:	48 c1 ea 10          	shr    $0x10,%rdx
    5f24:	48 69 d2 28 12 00 00 	imul   $0x1228,%rdx,%rdx
    5f2b:	0f b6 34 11          	movzbl (%rcx,%rdx,1),%esi
    5f2f:	48 25 ff ff 00 00    	and    $0xffff,%rax
    5f35:	0f 85 a5 00 00 00    	jne    5fe0 <fwp_apply_owned+0x810>
    5f3b:	40 80 fe 02          	cmp    $0x2,%sil
    5f3f:	0f 85 9b 00 00 00    	jne    5fe0 <fwp_apply_owned+0x810>
    5f45:	4c 8d 3c 11          	lea    (%rcx,%rdx,1),%r15
    5f49:	49 81 c7 28 02 00 00 	add    $0x228,%r15
    5f50:	41 80 3f ff          	cmpb   $0xff,(%r15)
    5f54:	0f 84 b1 00 00 00    	je     600b <fwp_apply_owned+0x83b>
    5f5a:	41 c6 07 01          	movb   $0x1,(%r15)
    5f5e:	e9 b5 00 00 00       	jmp    6018 <fwp_apply_owned+0x848>
    5f63:	48 8d 50 ff          	lea    -0x1(%rax),%rdx
    5f67:	31 c9                	xor    %ecx,%ecx
    5f69:	89 d6                	mov    %edx,%esi
    5f6b:	44 01 f6             	add    %r14d,%esi
    5f6e:	0f 82 f6 fe ff ff    	jb     5e6a <fwp_apply_owned+0x69a>
    5f74:	48 c1 ea 20          	shr    $0x20,%rdx
    5f78:	0f 85 ec fe ff ff    	jne    5e6a <fwp_apply_owned+0x69a>
    5f7e:	4a 8d 0c f5 00 00 00 	lea    0x0(,%r14,8),%rcx
    5f85:	00 
    5f86:	4c 01 e9             	add    %r13,%rcx
    5f89:	48 29 d9             	sub    %rbx,%rcx
    5f8c:	48 83 c1 08          	add    $0x8,%rcx
    5f90:	48 83 f9 20          	cmp    $0x20,%rcx
    5f94:	0f 82 ce fe ff ff    	jb     5e68 <fwp_apply_owned+0x698>
    5f9a:	89 c1                	mov    %eax,%ecx
    5f9c:	83 e1 fc             	and    $0xfffffffc,%ecx
    5f9f:	31 d2                	xor    %edx,%edx
    5fa1:	66 66 66 66 66 66 2e 	data16 data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    5fa8:	0f 1f 84 00 00 00 00 
    5faf:	00 
    5fb0:	0f 10 04 d3          	movups (%rbx,%rdx,8),%xmm0
    5fb4:	0f 10 4c d3 10       	movups 0x10(%rbx,%rdx,8),%xmm1
    5fb9:	41 8d 34 16          	lea    (%r14,%rdx,1),%esi
    5fbd:	41 0f 11 44 f5 08    	movups %xmm0,0x8(%r13,%rsi,8)
    5fc3:	41 0f 11 4c f5 18    	movups %xmm1,0x18(%r13,%rsi,8)
    5fc9:	48 83 c2 04          	add    $0x4,%rdx
    5fcd:	48 39 d1             	cmp    %rdx,%rcx
    5fd0:	75 de                	jne    5fb0 <fwp_apply_owned+0x7e0>
    5fd2:	48 39 c1             	cmp    %rax,%rcx
    5fd5:	0f 85 8f fe ff ff    	jne    5e6a <fwp_apply_owned+0x69a>
    5fdb:	e9 06 ff ff ff       	jmp    5ee6 <fwp_apply_owned+0x716>
    5fe0:	40 80 fe 01          	cmp    $0x1,%sil
    5fe4:	75 32                	jne    6018 <fwp_apply_owned+0x848>
    5fe6:	48 8d 34 11          	lea    (%rcx,%rdx,1),%rsi
    5fea:	8b 4c 11 20          	mov    0x20(%rcx,%rdx,1),%ecx
    5fee:	48 0f af c1          	imul   %rcx,%rax
    5ff2:	48 c1 e8 20          	shr    $0x20,%rax
    5ff6:	4c 8d 3c 30          	lea    (%rax,%rsi,1),%r15
    5ffa:	49 81 c7 28 02 00 00 	add    $0x228,%r15
    6001:	41 80 3f ff          	cmpb   $0xff,(%r15)
    6005:	0f 85 4f ff ff ff    	jne    5f5a <fwp_apply_owned+0x78a>
    600b:	4c 89 ff             	mov    %r15,%rdi
    600e:	e8 ed dd ff ff       	call   3e00 <fwp_rc_forget_slot>
    6013:	e9 42 ff ff ff       	jmp    5f5a <fwp_apply_owned+0x78a>
    6018:	4c 89 f7             	mov    %r14,%rdi
    601b:	e8 80 01 00 00       	call   61a0 <fwp_closure_drop>
    6020:	4d 89 ec             	mov    %r13,%r12
    6023:	4c 89 e0             	mov    %r12,%rax
    6026:	48 8d 65 d8          	lea    -0x28(%rbp),%rsp
    602a:	5b                   	pop    %rbx
    602b:	41 5c                	pop    %r12
    602d:	41 5d                	pop    %r13
    602f:	41 5e                	pop    %r14
    6031:	41 5f                	pop    %r15
    6033:	5d                   	pop    %rbp
    6034:	c3                   	ret
    6035:	66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
    603c:	00 00 00 00 

0000000000006040 <fwp_rc_wide_dup>:
    6040:	41 56                	push   %r14
    6042:	53                   	push   %rbx
    6043:	50                   	push   %rax
    6044:	48 89 fb             	mov    %rdi,%rbx
    6047:	48 89 f8             	mov    %rdi,%rax
    604a:	48 c1 e8 11          	shr    $0x11,%rax
    604e:	31 d8                	xor    %ebx,%eax
    6050:	89 c1                	mov    %eax,%ecx
    6052:	c1 e9 09             	shr    $0x9,%ecx
    6055:	31 c1                	xor    %eax,%ecx
    6057:	0f b6 c1             	movzbl %cl,%eax
    605a:	48 8d 0d df 60 00 00 	lea    0x60df(%rip),%rcx        # c140 <fwp_gc>
    6061:	4c 8d 34 c1          	lea    (%rcx,%rax,8),%r14
    6065:	49 81 c6 18 12 00 00 	add    $0x1218,%r14
    606c:	48 8b 84 c1 18 12 00 	mov    0x1218(%rcx,%rax,8),%rax
    6073:	00 
    6074:	48 85 c0             	test   %rax,%rax
    6077:	74 1a                	je     6093 <fwp_rc_wide_dup+0x53>
    6079:	48 39 18             	cmp    %rbx,(%rax)
    607c:	74 22                	je     60a0 <fwp_rc_wide_dup+0x60>
    607e:	66 90                	xchg   %ax,%ax
    6080:	49 89 c6             	mov    %rax,%r14
    6083:	48 8b 40 10          	mov    0x10(%rax),%rax
    6087:	48 85 c0             	test   %rax,%rax
    608a:	74 0e                	je     609a <fwp_rc_wide_dup+0x5a>
    608c:	48 39 18             	cmp    %rbx,(%rax)
    608f:	75 ef                	jne    6080 <fwp_rc_wide_dup+0x40>
    6091:	eb 09                	jmp    609c <fwp_rc_wide_dup+0x5c>
    6093:	80 3b fe             	cmpb   $0xfe,(%rbx)
    6096:	74 16                	je     60ae <fwp_rc_wide_dup+0x6e>
    6098:	eb 6d                	jmp    6107 <fwp_rc_wide_dup+0xc7>
    609a:	31 c0                	xor    %eax,%eax
    609c:	49 83 c6 10          	add    $0x10,%r14
    60a0:	80 3b fe             	cmpb   $0xfe,(%rbx)
    60a3:	75 41                	jne    60e6 <fwp_rc_wide_dup+0xa6>
    60a5:	48 85 c0             	test   %rax,%rax
    60a8:	0f 85 a2 00 00 00    	jne    6150 <fwp_rc_wide_dup+0x110>
    60ae:	bf 18 00 00 00       	mov    $0x18,%edi
    60b3:	e8 d8 c0 ff ff       	call   2190 <malloc@plt>
    60b8:	48 85 c0             	test   %rax,%rax
    60bb:	74 69                	je     6126 <fwp_rc_wide_dup+0xe6>
    60bd:	48 89 18             	mov    %rbx,(%rax)
    60c0:	48 c7 40 08 ff 00 00 	movq   $0xff,0x8(%rax)
    60c7:	00 
    60c8:	48 c7 40 10 00 00 00 	movq   $0x0,0x10(%rax)
    60cf:	00 
    60d0:	49 89 06             	mov    %rax,(%r14)
    60d3:	c6 03 ff             	movb   $0xff,(%rbx)
    60d6:	48 8d 05 7b 7a 00 00 	lea    0x7a7b(%rip),%rax        # db58 <fwp_gc+0x1a18>
    60dd:	48 8b 0d 74 7a 00 00 	mov    0x7a74(%rip),%rcx        # db58 <fwp_gc+0x1a18>
    60e4:	eb 13                	jmp    60f9 <fwp_rc_wide_dup+0xb9>
    60e6:	48 85 c0             	test   %rax,%rax
    60e9:	74 1c                	je     6107 <fwp_rc_wide_dup+0xc7>
    60eb:	48 8b 48 08          	mov    0x8(%rax),%rcx
    60ef:	48 83 f9 ff          	cmp    $0xffffffffffffffff,%rcx
    60f3:	74 7a                	je     616f <fwp_rc_wide_dup+0x12f>
    60f5:	48 83 c0 08          	add    $0x8,%rax
    60f9:	48 ff c1             	inc    %rcx
    60fc:	48 89 08             	mov    %rcx,(%rax)
    60ff:	48 83 c4 08          	add    $0x8,%rsp
    6103:	5b                   	pop    %rbx
    6104:	41 5e                	pop    %r14
    6106:	c3                   	ret
    6107:	e8 c4 dc ff ff       	call   3dd0 <fwp_flush>
    610c:	48 8b 05 cd 5e 00 00 	mov    0x5ecd(%rip),%rax        # bfe0 <stderr@GLIBC_2.2.5>
    6113:	48 8b 38             	mov    (%rax),%rdi
    6116:	48 8d 35 9b 30 00 00 	lea    0x309b(%rip),%rsi        # 91b8 <_IO_stdin_used+0x1b8>
    611d:	48 8d 15 a3 30 00 00 	lea    0x30a3(%rip),%rdx        # 91c7 <_IO_stdin_used+0x1c7>
    6124:	eb 66                	jmp    618c <fwp_rc_wide_dup+0x14c>
    6126:	48 8b 05 b3 5e 00 00 	mov    0x5eb3(%rip),%rax        # bfe0 <stderr@GLIBC_2.2.5>
    612d:	48 8b 08             	mov    (%rax),%rcx
    6130:	48 8d 3d 7f 31 00 00 	lea    0x317f(%rip),%rdi        # 92b6 <_IO_stdin_used+0x2b6>
    6137:	be 13 00 00 00       	mov    $0x13,%esi
    613c:	ba 01 00 00 00       	mov    $0x1,%edx
    6141:	e8 ea c0 ff ff       	call   2230 <fwrite@plt>
    6146:	bf 66 00 00 00       	mov    $0x66,%edi
    614b:	e8 d0 c0 ff ff       	call   2220 <exit@plt>
    6150:	e8 7b dc ff ff       	call   3dd0 <fwp_flush>
    6155:	48 8b 05 84 5e 00 00 	mov    0x5e84(%rip),%rax        # bfe0 <stderr@GLIBC_2.2.5>
    615c:	48 8b 38             	mov    (%rax),%rdi
    615f:	48 8d 35 52 30 00 00 	lea    0x3052(%rip),%rsi        # 91b8 <_IO_stdin_used+0x1b8>
    6166:	48 8d 15 9c 31 00 00 	lea    0x319c(%rip),%rdx        # 9309 <_IO_stdin_used+0x309>
    616d:	eb 1d                	jmp    618c <fwp_rc_wide_dup+0x14c>
    616f:	e8 5c dc ff ff       	call   3dd0 <fwp_flush>
    6174:	48 8b 05 65 5e 00 00 	mov    0x5e65(%rip),%rax        # bfe0 <stderr@GLIBC_2.2.5>
    617b:	48 8b 38             	mov    (%rax),%rdi
    617e:	48 8d 35 33 30 00 00 	lea    0x3033(%rip),%rsi        # 91b8 <_IO_stdin_used+0x1b8>
    6185:	48 8d 15 a2 31 00 00 	lea    0x31a2(%rip),%rdx        # 932e <_IO_stdin_used+0x32e>
    618c:	31 c0                	xor    %eax,%eax
    618e:	e8 bd bf ff ff       	call   2150 <fprintf@plt>
    6193:	bf 65 00 00 00       	mov    $0x65,%edi
    6198:	e8 83 c0 ff ff       	call   2220 <exit@plt>
    619d:	0f 1f 00             	nopl   (%rax)

00000000000061a0 <fwp_closure_drop>:
    61a0:	41 57                	push   %r15
    61a2:	41 56                	push   %r14
    61a4:	53                   	push   %rbx
    61a5:	48 81 ec 30 02 00 00 	sub    $0x230,%rsp
    61ac:	48 89 f8             	mov    %rdi,%rax
    61af:	48 2b 05 ba 6f 00 00 	sub    0x6fba(%rip),%rax        # d170 <fwp_gc+0x1030>
    61b6:	48 8b 0d db 6f 00 00 	mov    0x6fdb(%rip),%rcx        # d198 <fwp_gc+0x1058>
    61bd:	48 c1 e1 10          	shl    $0x10,%rcx
    61c1:	48 39 c8             	cmp    %rcx,%rax
    61c4:	0f 83 91 00 00 00    	jae    625b <fwp_closure_drop+0xbb>
    61ca:	48 89 fe             	mov    %rdi,%rsi
    61cd:	48 8b 0d e4 6f 00 00 	mov    0x6fe4(%rip),%rcx        # d1b8 <fwp_gc+0x1078>
    61d4:	48 89 c2             	mov    %rax,%rdx
    61d7:	48 c1 ea 10          	shr    $0x10,%rdx
    61db:	48 69 d2 28 12 00 00 	imul   $0x1228,%rdx,%rdx
    61e2:	0f b6 3c 11          	movzbl (%rcx,%rdx,1),%edi
    61e6:	48 25 ff ff 00 00    	and    $0xffff,%rax
    61ec:	75 13                	jne    6201 <fwp_closure_drop+0x61>
    61ee:	40 80 ff 02          	cmp    $0x2,%dil
    61f2:	75 0d                	jne    6201 <fwp_closure_drop+0x61>
    61f4:	48 8d 3c 11          	lea    (%rcx,%rdx,1),%rdi
    61f8:	48 81 c7 28 02 00 00 	add    $0x228,%rdi
    61ff:	eb 20                	jmp    6221 <fwp_closure_drop+0x81>
    6201:	40 80 ff 01          	cmp    $0x1,%dil
    6205:	75 54                	jne    625b <fwp_closure_drop+0xbb>
    6207:	48 8d 3c 11          	lea    (%rcx,%rdx,1),%rdi
    620b:	8b 4c 11 20          	mov    0x20(%rcx,%rdx,1),%ecx
    620f:	48 0f af c1          	imul   %rcx,%rax
    6213:	48 c1 e8 20          	shr    $0x20,%rax
    6217:	48 01 c7             	add    %rax,%rdi
    621a:	48 81 c7 28 02 00 00 	add    $0x228,%rdi
    6221:	0f b6 07             	movzbl (%rdi),%eax
    6224:	85 c0                	test   %eax,%eax
    6226:	74 33                	je     625b <fwp_closure_drop+0xbb>
    6228:	83 f8 01             	cmp    $0x1,%eax
    622b:	75 1f                	jne    624c <fwp_closure_drop+0xac>
    622d:	64 48 8b 3c 25 f8 ff 	mov    %fs:0xfffffffffffffff8,%rdi
    6234:	ff ff 
    6236:	48 85 ff             	test   %rdi,%rdi
    6239:	74 2d                	je     6268 <fwp_closure_drop+0xc8>
    623b:	48 81 c4 30 02 00 00 	add    $0x230,%rsp
    6242:	5b                   	pop    %rbx
    6243:	41 5e                	pop    %r14
    6245:	41 5f                	pop    %r15
    6247:	e9 44 01 00 00       	jmp    6390 <fwp_closure_drop_push>
    624c:	3d ff 00 00 00       	cmp    $0xff,%eax
    6251:	0f 84 e7 00 00 00    	je     633e <fwp_closure_drop+0x19e>
    6257:	fe c8                	dec    %al
    6259:	88 07                	mov    %al,(%rdi)
    625b:	48 81 c4 30 02 00 00 	add    $0x230,%rsp
    6262:	5b                   	pop    %rbx
    6263:	41 5e                	pop    %r14
    6265:	41 5f                	pop    %r15
    6267:	c3                   	ret
    6268:	64 48 8b 04 25 00 00 	mov    %fs:0x0,%rax
    626f:	00 00 
    6271:	4c 8d b0 f8 ff ff ff 	lea    -0x8(%rax),%r14
    6278:	48 8d 5c 24 30       	lea    0x30(%rsp),%rbx
    627d:	48 89 5c 24 18       	mov    %rbx,0x18(%rsp)
    6282:	48 c7 44 24 20 00 00 	movq   $0x0,0x20(%rsp)
    6289:	00 00 
    628b:	48 c7 44 24 28 40 00 	movq   $0x40,0x28(%rsp)
    6292:	00 00 
    6294:	48 8b 05 6d 79 00 00 	mov    0x796d(%rip),%rax        # dc08 <fwp_cleanups>
    629b:	48 89 04 24          	mov    %rax,(%rsp)
    629f:	48 8d 05 ca 01 00 00 	lea    0x1ca(%rip),%rax        # 6470 <fwp_closure_drop_release>
    62a6:	48 89 44 24 08       	mov    %rax,0x8(%rsp)
    62ab:	48 8d 7c 24 18       	lea    0x18(%rsp),%rdi
    62b0:	48 89 7c 24 10       	mov    %rdi,0x10(%rsp)
    62b5:	49 89 e7             	mov    %rsp,%r15
    62b8:	4c 89 3d 49 79 00 00 	mov    %r15,0x7949(%rip)        # dc08 <fwp_cleanups>
    62bf:	49 89 3e             	mov    %rdi,(%r14)
    62c2:	e8 c9 00 00 00       	call   6390 <fwp_closure_drop_push>
    62c7:	66 0f 1f 84 00 00 00 	nopw   0x0(%rax,%rax,1)
    62ce:	00 00 
    62d0:	48 8b 44 24 20       	mov    0x20(%rsp),%rax
    62d5:	48 85 c0             	test   %rax,%rax
    62d8:	74 31                	je     630b <fwp_closure_drop+0x16b>
    62da:	48 8b 4c 24 18       	mov    0x18(%rsp),%rcx
    62df:	48 8d 50 ff          	lea    -0x1(%rax),%rdx
    62e3:	48 89 54 24 20       	mov    %rdx,0x20(%rsp)
    62e8:	48 8b 7c c1 f8       	mov    -0x8(%rcx,%rax,8),%rdi
    62ed:	48 8b 05 ec 78 00 00 	mov    0x78ec(%rip),%rax        # dbe0 <fwp_fns>
    62f4:	8b 0f                	mov    (%rdi),%ecx
    62f6:	48 c1 e1 05          	shl    $0x5,%rcx
    62fa:	48 8b 44 08 18       	mov    0x18(%rax,%rcx,1),%rax
    62ff:	48 85 c0             	test   %rax,%rax
    6302:	74 4b                	je     634f <fwp_closure_drop+0x1af>
    6304:	31 f6                	xor    %esi,%esi
    6306:	ff 50 08             	call   *0x8(%rax)
    6309:	eb c5                	jmp    62d0 <fwp_closure_drop+0x130>
    630b:	4c 39 3d f6 78 00 00 	cmp    %r15,0x78f6(%rip)        # dc08 <fwp_cleanups>
    6312:	75 69                	jne    637d <fwp_closure_drop+0x1dd>
    6314:	48 8b 04 24          	mov    (%rsp),%rax
    6318:	48 89 05 e9 78 00 00 	mov    %rax,0x78e9(%rip)        # dc08 <fwp_cleanups>
    631f:	49 c7 06 00 00 00 00 	movq   $0x0,(%r14)
    6326:	48 8b 7c 24 18       	mov    0x18(%rsp),%rdi
    632b:	48 39 df             	cmp    %rbx,%rdi
    632e:	0f 84 27 ff ff ff    	je     625b <fwp_closure_drop+0xbb>
    6334:	e8 17 bd ff ff       	call   2050 <free@plt>
    6339:	e9 1d ff ff ff       	jmp    625b <fwp_closure_drop+0xbb>
    633e:	48 81 c4 30 02 00 00 	add    $0x230,%rsp
    6345:	5b                   	pop    %rbx
    6346:	41 5e                	pop    %r14
    6348:	41 5f                	pop    %r15
    634a:	e9 61 01 00 00       	jmp    64b0 <fwp_rc_wide_drop>
    634f:	e8 7c da ff ff       	call   3dd0 <fwp_flush>
    6354:	48 8b 05 85 5c 00 00 	mov    0x5c85(%rip),%rax        # bfe0 <stderr@GLIBC_2.2.5>
    635b:	48 8b 38             	mov    (%rax),%rdi
    635e:	48 8d 35 53 2e 00 00 	lea    0x2e53(%rip),%rsi        # 91b8 <_IO_stdin_used+0x1b8>
    6365:	48 8d 15 db 2f 00 00 	lea    0x2fdb(%rip),%rdx        # 9347 <_IO_stdin_used+0x347>
    636c:	31 c0                	xor    %eax,%eax
    636e:	e8 dd bd ff ff       	call   2150 <fprintf@plt>
    6373:	bf 65 00 00 00       	mov    $0x65,%edi
    6378:	e8 a3 be ff ff       	call   2220 <exit@plt>
    637d:	e8 de bc ff ff       	call   2060 <abort@plt>
    6382:	66 66 66 66 66 2e 0f 	data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    6389:	1f 84 00 00 00 00 00 

0000000000006390 <fwp_closure_drop_push>:
    6390:	55                   	push   %rbp
    6391:	41 57                	push   %r15
    6393:	41 56                	push   %r14
    6395:	41 55                	push   %r13
    6397:	41 54                	push   %r12
    6399:	53                   	push   %rbx
    639a:	50                   	push   %rax
    639b:	48 89 f3             	mov    %rsi,%rbx
    639e:	49 89 fe             	mov    %rdi,%r14
    63a1:	4c 8b 6f 08          	mov    0x8(%rdi),%r13
    63a5:	4c 3b 6f 10          	cmp    0x10(%rdi),%r13
    63a9:	75 59                	jne    6404 <fwp_closure_drop_push+0x74>
    63ab:	4c 89 e8             	mov    %r13,%rax
    63ae:	48 c1 e8 3c          	shr    $0x3c,%rax
    63b2:	75 6e                	jne    6422 <fwp_closure_drop_push+0x92>
    63b4:	4c 89 ef             	mov    %r13,%rdi
    63b7:	48 c1 e7 04          	shl    $0x4,%rdi
    63bb:	e8 d0 bd ff ff       	call   2190 <malloc@plt>
    63c0:	48 85 c0             	test   %rax,%rax
    63c3:	74 7c                	je     6441 <fwp_closure_drop_push+0xb1>
    63c5:	49 89 c7             	mov    %rax,%r15
    63c8:	4a 8d 2c 6d 00 00 00 	lea    0x0(,%r13,2),%rbp
    63cf:	00 
    63d0:	4d 8b 26             	mov    (%r14),%r12
    63d3:	4a 8d 14 ed 00 00 00 	lea    0x0(,%r13,8),%rdx
    63da:	00 
    63db:	48 89 c7             	mov    %rax,%rdi
    63de:	4c 89 e6             	mov    %r12,%rsi
    63e1:	e8 9a bd ff ff       	call   2180 <memcpy@plt>
    63e6:	49 8d 46 18          	lea    0x18(%r14),%rax
    63ea:	49 39 c4             	cmp    %rax,%r12
    63ed:	74 0c                	je     63fb <fwp_closure_drop_push+0x6b>
    63ef:	4c 89 e7             	mov    %r12,%rdi
    63f2:	e8 59 bc ff ff       	call   2050 <free@plt>
    63f7:	4d 8b 6e 08          	mov    0x8(%r14),%r13
    63fb:	4d 89 3e             	mov    %r15,(%r14)
    63fe:	49 89 6e 10          	mov    %rbp,0x10(%r14)
    6402:	eb 03                	jmp    6407 <fwp_closure_drop_push+0x77>
    6404:	4d 8b 3e             	mov    (%r14),%r15
    6407:	49 8d 45 01          	lea    0x1(%r13),%rax
    640b:	49 89 46 08          	mov    %rax,0x8(%r14)
    640f:	4b 89 1c ef          	mov    %rbx,(%r15,%r13,8)
    6413:	48 83 c4 08          	add    $0x8,%rsp
    6417:	5b                   	pop    %rbx
    6418:	41 5c                	pop    %r12
    641a:	41 5d                	pop    %r13
    641c:	41 5e                	pop    %r14
    641e:	41 5f                	pop    %r15
    6420:	5d                   	pop    %rbp
    6421:	c3                   	ret
    6422:	e8 a9 d9 ff ff       	call   3dd0 <fwp_flush>
    6427:	48 8b 05 b2 5b 00 00 	mov    0x5bb2(%rip),%rax        # bfe0 <stderr@GLIBC_2.2.5>
    642e:	48 8b 38             	mov    (%rax),%rdi
    6431:	48 8d 35 80 2d 00 00 	lea    0x2d80(%rip),%rsi        # 91b8 <_IO_stdin_used+0x1b8>
    6438:	48 8d 15 36 2f 00 00 	lea    0x2f36(%rip),%rdx        # 9375 <_IO_stdin_used+0x375>
    643f:	eb 1d                	jmp    645e <fwp_closure_drop_push+0xce>
    6441:	e8 8a d9 ff ff       	call   3dd0 <fwp_flush>
    6446:	48 8b 05 93 5b 00 00 	mov    0x5b93(%rip),%rax        # bfe0 <stderr@GLIBC_2.2.5>
    644d:	48 8b 38             	mov    (%rax),%rdi
    6450:	48 8d 35 61 2d 00 00 	lea    0x2d61(%rip),%rsi        # 91b8 <_IO_stdin_used+0x1b8>
    6457:	48 8d 15 31 2f 00 00 	lea    0x2f31(%rip),%rdx        # 938f <_IO_stdin_used+0x38f>
    645e:	31 c0                	xor    %eax,%eax
    6460:	e8 eb bc ff ff       	call   2150 <fprintf@plt>
    6465:	bf 65 00 00 00       	mov    $0x65,%edi
    646a:	e8 b1 bd ff ff       	call   2220 <exit@plt>
    646f:	90                   	nop

0000000000006470 <fwp_closure_drop_release>:
    6470:	41 56                	push   %r14
    6472:	53                   	push   %rbx
    6473:	50                   	push   %rax
    6474:	48 89 fb             	mov    %rdi,%rbx
    6477:	64 48 c7 04 25 f8 ff 	movq   $0x0,%fs:0xfffffffffffffff8
    647e:	ff ff 00 00 00 00 
    6484:	48 8b 3f             	mov    (%rdi),%rdi
    6487:	4c 8d 73 18          	lea    0x18(%rbx),%r14
    648b:	4c 39 f7             	cmp    %r14,%rdi
    648e:	74 05                	je     6495 <fwp_closure_drop_release+0x25>
    6490:	e8 bb bb ff ff       	call   2050 <free@plt>
    6495:	4c 89 33             	mov    %r14,(%rbx)
    6498:	48 c7 43 08 00 00 00 	movq   $0x0,0x8(%rbx)
    649f:	00 
    64a0:	48 83 c4 08          	add    $0x8,%rsp
    64a4:	5b                   	pop    %rbx
    64a5:	41 5e                	pop    %r14
    64a7:	c3                   	ret
    64a8:	0f 1f 84 00 00 00 00 	nopl   0x0(%rax,%rax,1)
    64af:	00 

00000000000064b0 <fwp_rc_wide_drop>:
    64b0:	53                   	push   %rbx
    64b1:	48 89 f8             	mov    %rdi,%rax
    64b4:	48 c1 e8 11          	shr    $0x11,%rax
    64b8:	31 f8                	xor    %edi,%eax
    64ba:	89 c1                	mov    %eax,%ecx
    64bc:	c1 e9 09             	shr    $0x9,%ecx
    64bf:	31 c1                	xor    %eax,%ecx
    64c1:	0f b6 c1             	movzbl %cl,%eax
    64c4:	48 8d 0d 75 5c 00 00 	lea    0x5c75(%rip),%rcx        # c140 <fwp_gc>
    64cb:	48 8b 84 c1 18 12 00 	mov    0x1218(%rcx,%rax,8),%rax
    64d2:	00 
    64d3:	48 85 c0             	test   %rax,%rax
    64d6:	74 16                	je     64ee <fwp_rc_wide_drop+0x3e>
    64d8:	0f 1f 84 00 00 00 00 	nopl   0x0(%rax,%rax,1)
    64df:	00 
    64e0:	48 39 38             	cmp    %rdi,(%rax)
    64e3:	74 37                	je     651c <fwp_rc_wide_drop+0x6c>
    64e5:	48 8b 40 10          	mov    0x10(%rax),%rax
    64e9:	48 85 c0             	test   %rax,%rax
    64ec:	75 f2                	jne    64e0 <fwp_rc_wide_drop+0x30>
    64ee:	e8 dd d8 ff ff       	call   3dd0 <fwp_flush>
    64f3:	48 8b 05 e6 5a 00 00 	mov    0x5ae6(%rip),%rax        # bfe0 <stderr@GLIBC_2.2.5>
    64fa:	48 8b 38             	mov    (%rax),%rdi
    64fd:	48 8d 35 b4 2c 00 00 	lea    0x2cb4(%rip),%rsi        # 91b8 <_IO_stdin_used+0x1b8>
    6504:	48 8d 15 bc 2c 00 00 	lea    0x2cbc(%rip),%rdx        # 91c7 <_IO_stdin_used+0x1c7>
    650b:	31 c0                	xor    %eax,%eax
    650d:	e8 3e bc ff ff       	call   2150 <fprintf@plt>
    6512:	bf 65 00 00 00       	mov    $0x65,%edi
    6517:	e8 04 bd ff ff       	call   2220 <exit@plt>
    651c:	48 8b 48 08          	mov    0x8(%rax),%rcx
    6520:	48 ff c9             	dec    %rcx
    6523:	48 89 48 08          	mov    %rcx,0x8(%rax)
    6527:	48 81 f9 fe 00 00 00 	cmp    $0xfe,%rcx
    652e:	75 0b                	jne    653b <fwp_rc_wide_drop+0x8b>
    6530:	48 89 fb             	mov    %rdi,%rbx
    6533:	e8 c8 d8 ff ff       	call   3e00 <fwp_rc_forget_slot>
    6538:	c6 03 fe             	movb   $0xfe,(%rbx)
    653b:	5b                   	pop    %rbx
    653c:	c3                   	ret
    653d:	0f 1f 00             	nopl   (%rax)

0000000000006540 <fwp_mem_free>:
    6540:	48 85 ff             	test   %rdi,%rdi
    6543:	0f 84 17 02 00 00    	je     6760 <fwp_mem_free+0x220>
    6549:	48 8b 05 20 6c 00 00 	mov    0x6c20(%rip),%rax        # d170 <fwp_gc+0x1030>
    6550:	48 89 f9             	mov    %rdi,%rcx
    6553:	48 29 c1             	sub    %rax,%rcx
    6556:	48 8b 15 3b 6c 00 00 	mov    0x6c3b(%rip),%rdx        # d198 <fwp_gc+0x1058>
    655d:	48 c1 e2 10          	shl    $0x10,%rdx
    6561:	48 39 d1             	cmp    %rdx,%rcx
    6564:	0f 83 f6 01 00 00    	jae    6760 <fwp_mem_free+0x220>
    656a:	41 57                	push   %r15
    656c:	41 56                	push   %r14
    656e:	41 55                	push   %r13
    6570:	41 54                	push   %r12
    6572:	53                   	push   %rbx
    6573:	4c 8b 25 3e 6c 00 00 	mov    0x6c3e(%rip),%r12        # d1b8 <fwp_gc+0x1078>
    657a:	4d 85 e4             	test   %r12,%r12
    657d:	0f 84 d4 01 00 00    	je     6757 <fwp_mem_free+0x217>
    6583:	49 89 cf             	mov    %rcx,%r15
    6586:	49 c1 ef 10          	shr    $0x10,%r15
    658a:	4d 69 f7 28 12 00 00 	imul   $0x1228,%r15,%r14
    6591:	43 0f b6 14 34       	movzbl (%r12,%r14,1),%edx
    6596:	83 fa 02             	cmp    $0x2,%edx
    6599:	0f 84 b9 00 00 00    	je     6658 <fwp_mem_free+0x118>
    659f:	83 fa 01             	cmp    $0x1,%edx
    65a2:	0f 85 af 01 00 00    	jne    6757 <fwp_mem_free+0x217>
    65a8:	47 0f b6 4c 34 01    	movzbl 0x1(%r12,%r14,1),%r9d
    65ae:	47 0f b6 44 34 02    	movzbl 0x2(%r12,%r14,1),%r8d
    65b4:	43 8b 74 34 08       	mov    0x8(%r12,%r14,1),%esi
    65b9:	0f b7 c7             	movzwl %di,%eax
    65bc:	31 d2                	xor    %edx,%edx
    65be:	f7 f6                	div    %esi
    65c0:	48 c7 c2 fe ff ff ff 	mov    $0xfffffffffffffffe,%rdx
    65c7:	89 c1                	mov    %eax,%ecx
    65c9:	48 d3 c2             	rol    %cl,%rdx
    65cc:	4b 8d 0c 34          	lea    (%r12,%r14,1),%rcx
    65d0:	41 89 c2             	mov    %eax,%r10d
    65d3:	41 c1 ea 03          	shr    $0x3,%r10d
    65d7:	41 81 e2 f8 1f 00 00 	and    $0x1ff8,%r10d
    65de:	49 21 54 0a 28       	and    %rdx,0x28(%r10,%rcx,1)
    65e3:	49 69 d1 c0 03 00 00 	imul   $0x3c0,%r9,%rdx
    65ea:	4c 8d 3d 4f 5b 00 00 	lea    0x5b4f(%rip),%r15        # c140 <fwp_gc>
    65f1:	49 01 d7             	add    %rdx,%r15
    65f4:	4f 8d 2c 40          	lea    (%r8,%r8,2),%r13
    65f8:	4d 01 e6             	add    %r12,%r14
    65fb:	49 83 c6 08          	add    $0x8,%r14
    65ff:	48 8d 1c 08          	lea    (%rax,%rcx,1),%rbx
    6603:	48 81 c3 28 02 00 00 	add    $0x228,%rbx
    660a:	80 bc 08 28 02 00 00 	cmpb   $0xff,0x228(%rax,%rcx,1)
    6611:	ff 
    6612:	0f 84 49 01 00 00    	je     6761 <fwp_mem_free+0x221>
    6618:	4f 8d 3c ef          	lea    (%r15,%r13,8),%r15
    661c:	49 83 c7 08          	add    $0x8,%r15
    6620:	c6 03 00             	movb   $0x0,(%rbx)
    6623:	83 3d 1a 6b 00 00 00 	cmpl   $0x0,0x6b1a(%rip)        # d144 <fwp_gc+0x1004>
    662a:	74 12                	je     663e <fwp_mem_free+0xfe>
    662c:	89 f2                	mov    %esi,%edx
    662e:	48 89 fb             	mov    %rdi,%rbx
    6631:	31 f6                	xor    %esi,%esi
    6633:	e8 a8 ba ff ff       	call   20e0 <memset@plt>
    6638:	48 89 df             	mov    %rbx,%rdi
    663b:	41 8b 36             	mov    (%r14),%esi
    663e:	49 8b 07             	mov    (%r15),%rax
    6641:	48 f7 d0             	not    %rax
    6644:	48 89 07             	mov    %rax,(%rdi)
    6647:	49 89 3f             	mov    %rdi,(%r15)
    664a:	89 f0                	mov    %esi,%eax
    664c:	48 01 05 ed 5a 00 00 	add    %rax,0x5aed(%rip)        # c140 <fwp_gc>
    6653:	e9 ff 00 00 00       	jmp    6757 <fwp_mem_free+0x217>
    6658:	48 81 e1 00 00 ff ff 	and    $0xffffffffffff0000,%rcx
    665f:	48 01 c8             	add    %rcx,%rax
    6662:	48 39 f8             	cmp    %rdi,%rax
    6665:	0f 85 ec 00 00 00    	jne    6757 <fwp_mem_free+0x217>
    666b:	4b 8b 44 34 18       	mov    0x18(%r12,%r14,1),%rax
    6670:	48 01 05 c9 5a 00 00 	add    %rax,0x5ac9(%rip)        # c140 <fwp_gc>
    6677:	43 c6 44 34 03 00    	movb   $0x0,0x3(%r12,%r14,1)
    667d:	4b 8d 1c 34          	lea    (%r12,%r14,1),%rbx
    6681:	48 81 c3 28 02 00 00 	add    $0x228,%rbx
    6688:	43 80 bc 34 28 02 00 	cmpb   $0xff,0x228(%r12,%r14,1)
    668f:	00 ff 
    6691:	0f 84 e0 00 00 00    	je     6777 <fwp_mem_free+0x237>
    6697:	c6 03 00             	movb   $0x0,(%rbx)
    669a:	43 8b 44 34 10       	mov    0x10(%r12,%r14,1),%eax
    669f:	48 85 c0             	test   %rax,%rax
    66a2:	0f 84 88 00 00 00    	je     6730 <fwp_mem_free+0x1f0>
    66a8:	48 8b 0d 09 6b 00 00 	mov    0x6b09(%rip),%rcx        # d1b8 <fwp_gc+0x1078>
    66af:	89 c2                	mov    %eax,%edx
    66b1:	83 e2 03             	and    $0x3,%edx
    66b4:	83 f8 04             	cmp    $0x4,%eax
    66b7:	73 04                	jae    66bd <fwp_mem_free+0x17d>
    66b9:	31 f6                	xor    %esi,%esi
    66bb:	eb 3b                	jmp    66f8 <fwp_mem_free+0x1b8>
    66bd:	4a 8d 3c 31          	lea    (%rcx,%r14,1),%rdi
    66c1:	41 89 c0             	mov    %eax,%r8d
    66c4:	41 83 e0 fc          	and    $0xfffffffc,%r8d
    66c8:	31 f6                	xor    %esi,%esi
    66ca:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)
    66d0:	c6 07 00             	movb   $0x0,(%rdi)
    66d3:	c6 87 28 12 00 00 00 	movb   $0x0,0x1228(%rdi)
    66da:	c6 87 50 24 00 00 00 	movb   $0x0,0x2450(%rdi)
    66e1:	c6 87 78 36 00 00 00 	movb   $0x0,0x3678(%rdi)
    66e8:	48 83 c6 04          	add    $0x4,%rsi
    66ec:	48 81 c7 a0 48 00 00 	add    $0x48a0,%rdi
    66f3:	49 39 f0             	cmp    %rsi,%r8
    66f6:	75 d8                	jne    66d0 <fwp_mem_free+0x190>
    66f8:	48 85 d2             	test   %rdx,%rdx
    66fb:	74 33                	je     6730 <fwp_mem_free+0x1f0>
    66fd:	48 69 f6 28 12 00 00 	imul   $0x1228,%rsi,%rsi
    6704:	4c 01 f6             	add    %r14,%rsi
    6707:	48 01 f1             	add    %rsi,%rcx
    670a:	48 69 d2 28 12 00 00 	imul   $0x1228,%rdx,%rdx
    6711:	31 f6                	xor    %esi,%esi
    6713:	66 66 66 66 2e 0f 1f 	data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    671a:	84 00 00 00 00 00 
    6720:	c6 04 31 00          	movb   $0x0,(%rcx,%rsi,1)
    6724:	48 81 c6 28 12 00 00 	add    $0x1228,%rsi
    672b:	48 39 f2             	cmp    %rsi,%rdx
    672e:	75 f0                	jne    6720 <fwp_mem_free+0x1e0>
    6730:	48 01 05 e9 6b 00 00 	add    %rax,0x6be9(%rip)        # d320 <fwp_gc+0x11e0>
    6737:	4c 3b 3d 72 6a 00 00 	cmp    0x6a72(%rip),%r15        # d1b0 <fwp_gc+0x1070>
    673e:	73 07                	jae    6747 <fwp_mem_free+0x207>
    6740:	4c 89 3d 69 6a 00 00 	mov    %r15,0x6a69(%rip)        # d1b0 <fwp_gc+0x1070>
    6747:	4c 3b 3d 5a 6a 00 00 	cmp    0x6a5a(%rip),%r15        # d1a8 <fwp_gc+0x1068>
    674e:	73 07                	jae    6757 <fwp_mem_free+0x217>
    6750:	4c 89 3d 51 6a 00 00 	mov    %r15,0x6a51(%rip)        # d1a8 <fwp_gc+0x1068>
    6757:	5b                   	pop    %rbx
    6758:	41 5c                	pop    %r12
    675a:	41 5d                	pop    %r13
    675c:	41 5e                	pop    %r14
    675e:	41 5f                	pop    %r15
    6760:	c3                   	ret
    6761:	49 89 fc             	mov    %rdi,%r12
    6764:	48 89 df             	mov    %rbx,%rdi
    6767:	e8 94 d6 ff ff       	call   3e00 <fwp_rc_forget_slot>
    676c:	4c 89 e7             	mov    %r12,%rdi
    676f:	41 8b 36             	mov    (%r14),%esi
    6772:	e9 a1 fe ff ff       	jmp    6618 <fwp_mem_free+0xd8>
    6777:	48 89 df             	mov    %rbx,%rdi
    677a:	e8 81 d6 ff ff       	call   3e00 <fwp_rc_forget_slot>
    677f:	e9 13 ff ff ff       	jmp    6697 <fwp_mem_free+0x157>
    6784:	66 66 66 2e 0f 1f 84 	data16 data16 cs nopw 0x0(%rax,%rax,1)
    678b:	00 00 00 00 00 

0000000000006790 <fwp_rc_free_obj>:
    6790:	48 89 f8             	mov    %rdi,%rax
    6793:	48 2b 05 d6 69 00 00 	sub    0x69d6(%rip),%rax        # d170 <fwp_gc+0x1030>
    679a:	48 8b 0d f7 69 00 00 	mov    0x69f7(%rip),%rcx        # d198 <fwp_gc+0x1058>
    67a1:	48 c1 e1 10          	shl    $0x10,%rcx
    67a5:	48 39 c8             	cmp    %rcx,%rax
    67a8:	0f 83 b8 01 00 00    	jae    6966 <fwp_rc_free_obj+0x1d6>
    67ae:	55                   	push   %rbp
    67af:	41 57                	push   %r15
    67b1:	41 56                	push   %r14
    67b3:	53                   	push   %rbx
    67b4:	50                   	push   %rax
    67b5:	48 8b 1d fc 69 00 00 	mov    0x69fc(%rip),%rbx        # d1b8 <fwp_gc+0x1078>
    67bc:	48 89 c1             	mov    %rax,%rcx
    67bf:	48 c1 e9 10          	shr    $0x10,%rcx
    67c3:	4c 69 f1 28 12 00 00 	imul   $0x1228,%rcx,%r14
    67ca:	42 0f b6 2c 33       	movzbl (%rbx,%r14,1),%ebp
    67cf:	48 25 ff ff 00 00    	and    $0xffff,%rax
    67d5:	75 1a                	jne    67f1 <fwp_rc_free_obj+0x61>
    67d7:	40 80 fd 02          	cmp    $0x2,%bpl
    67db:	75 14                	jne    67f1 <fwp_rc_free_obj+0x61>
    67dd:	4a 8d 04 33          	lea    (%rbx,%r14,1),%rax
    67e1:	48 05 28 02 00 00    	add    $0x228,%rax
    67e7:	80 38 01             	cmpb   $0x1,(%rax)
    67ea:	74 32                	je     681e <fwp_rc_free_obj+0x8e>
    67ec:	e9 6b 01 00 00       	jmp    695c <fwp_rc_free_obj+0x1cc>
    67f1:	40 80 fd 01          	cmp    $0x1,%bpl
    67f5:	0f 85 61 01 00 00    	jne    695c <fwp_rc_free_obj+0x1cc>
    67fb:	4a 8d 0c 33          	lea    (%rbx,%r14,1),%rcx
    67ff:	42 8b 54 33 20       	mov    0x20(%rbx,%r14,1),%edx
    6804:	48 0f af c2          	imul   %rdx,%rax
    6808:	48 c1 e8 20          	shr    $0x20,%rax
    680c:	48 01 c8             	add    %rcx,%rax
    680f:	48 05 28 02 00 00    	add    $0x228,%rax
    6815:	80 38 01             	cmpb   $0x1,(%rax)
    6818:	0f 85 3e 01 00 00    	jne    695c <fwp_rc_free_obj+0x1cc>
    681e:	8b 0d 3c 73 00 00    	mov    0x733c(%rip),%ecx        # db60 <fwp_reuse_verify>
    6824:	85 c9                	test   %ecx,%ecx
    6826:	0f 88 c3 00 00 00    	js     68ef <fwp_rc_free_obj+0x15f>
    682c:	85 c9                	test   %ecx,%ecx
    682e:	0f 84 fd 00 00 00    	je     6931 <fwp_rc_free_obj+0x1a1>
    6834:	42 80 7c 33 01 01    	cmpb   $0x1,0x1(%rbx,%r14,1)
    683a:	75 0d                	jne    6849 <fwp_rc_free_obj+0xb9>
    683c:	40 80 fd 02          	cmp    $0x2,%bpl
    6840:	75 22                	jne    6864 <fwp_rc_free_obj+0xd4>
    6842:	4a 8b 54 33 18       	mov    0x18(%rbx,%r14,1),%rdx
    6847:	eb 20                	jmp    6869 <fwp_rc_free_obj+0xd9>
    6849:	c7 07 ad de 00 00    	movl   $0xdead,(%rdi)
    684f:	8b 47 04             	mov    0x4(%rdi),%eax
    6852:	48 85 c0             	test   %rax,%rax
    6855:	0f 84 01 01 00 00    	je     695c <fwp_rc_free_obj+0x1cc>
    685b:	83 f8 04             	cmp    $0x4,%eax
    685e:	73 26                	jae    6886 <fwp_rc_free_obj+0xf6>
    6860:	31 c9                	xor    %ecx,%ecx
    6862:	eb 6a                	jmp    68ce <fwp_rc_free_obj+0x13e>
    6864:	42 8b 54 33 08       	mov    0x8(%rbx,%r14,1),%edx
    6869:	48 89 fb             	mov    %rdi,%rbx
    686c:	be dd 00 00 00       	mov    $0xdd,%esi
    6871:	e8 6a b8 ff ff       	call   20e0 <memset@plt>
    6876:	48 c7 03 00 00 00 00 	movq   $0x0,(%rbx)
    687d:	c6 43 08 00          	movb   $0x0,0x8(%rbx)
    6881:	e9 d6 00 00 00       	jmp    695c <fwp_rc_free_obj+0x1cc>
    6886:	89 c1                	mov    %eax,%ecx
    6888:	83 e1 fc             	and    $0xfffffffc,%ecx
    688b:	48 8d 14 c5 00 00 00 	lea    0x0(,%rax,8),%rdx
    6892:	00 
    6893:	48 83 e2 e0          	and    $0xffffffffffffffe0,%rdx
    6897:	31 f6                	xor    %esi,%esi
    6899:	66 0f 28 05 0f 28 00 	movapd 0x280f(%rip),%xmm0        # 90b0 <_IO_stdin_used+0xb0>
    68a0:	00 
    68a1:	66 66 66 66 66 66 2e 	data16 data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    68a8:	0f 1f 84 00 00 00 00 
    68af:	00 
    68b0:	66 0f 11 44 37 08    	movupd %xmm0,0x8(%rdi,%rsi,1)
    68b6:	66 0f 11 44 37 18    	movupd %xmm0,0x18(%rdi,%rsi,1)
    68bc:	48 83 c6 20          	add    $0x20,%rsi
    68c0:	48 39 f2             	cmp    %rsi,%rdx
    68c3:	75 eb                	jne    68b0 <fwp_rc_free_obj+0x120>
    68c5:	48 39 c1             	cmp    %rax,%rcx
    68c8:	0f 84 8e 00 00 00    	je     695c <fwp_rc_free_obj+0x1cc>
    68ce:	48 ba ef be ad de ef 	movabs $0xdeadbeefdeadbeef,%rdx
    68d5:	be ad de 
    68d8:	0f 1f 84 00 00 00 00 	nopl   0x0(%rax,%rax,1)
    68df:	00 
    68e0:	48 89 54 cf 08       	mov    %rdx,0x8(%rdi,%rcx,8)
    68e5:	48 ff c1             	inc    %rcx
    68e8:	48 39 c8             	cmp    %rcx,%rax
    68eb:	75 f3                	jne    68e0 <fwp_rc_free_obj+0x150>
    68ed:	eb 6d                	jmp    695c <fwp_rc_free_obj+0x1cc>
    68ef:	49 89 ff             	mov    %rdi,%r15
    68f2:	48 8d 3d 6d 29 00 00 	lea    0x296d(%rip),%rdi        # 9266 <_IO_stdin_used+0x266>
    68f9:	e8 32 b7 ff ff       	call   2030 <getenv@plt>
    68fe:	31 c9                	xor    %ecx,%ecx
    6900:	48 85 c0             	test   %rax,%rax
    6903:	74 1b                	je     6920 <fwp_rc_free_obj+0x190>
    6905:	80 38 00             	cmpb   $0x0,(%rax)
    6908:	74 16                	je     6920 <fwp_rc_free_obj+0x190>
    690a:	48 8d 35 e8 28 00 00 	lea    0x28e8(%rip),%rsi        # 91f9 <_IO_stdin_used+0x1f9>
    6911:	48 89 c7             	mov    %rax,%rdi
    6914:	e8 17 b8 ff ff       	call   2130 <strcmp@plt>
    6919:	31 c9                	xor    %ecx,%ecx
    691b:	85 c0                	test   %eax,%eax
    691d:	0f 95 c1             	setne  %cl
    6920:	89 0d 3a 72 00 00    	mov    %ecx,0x723a(%rip)        # db60 <fwp_reuse_verify>
    6926:	4c 89 ff             	mov    %r15,%rdi
    6929:	85 c9                	test   %ecx,%ecx
    692b:	0f 85 03 ff ff ff    	jne    6834 <fwp_rc_free_obj+0xa4>
    6931:	48 8b 1d 08 58 00 00 	mov    0x5808(%rip),%rbx        # c140 <fwp_gc>
    6938:	e8 03 fc ff ff       	call   6540 <fwp_mem_free>
    693d:	48 8b 05 fc 57 00 00 	mov    0x57fc(%rip),%rax        # c140 <fwp_gc>
    6944:	48 29 d8             	sub    %rbx,%rax
    6947:	f2 48 0f 2a c0       	cvtsi2sd %rax,%xmm0
    694c:	f2 0f 58 05 f4 69 00 	addsd  0x69f4(%rip),%xmm0        # d348 <fwp_gc+0x1208>
    6953:	00 
    6954:	f2 0f 11 05 ec 69 00 	movsd  %xmm0,0x69ec(%rip)        # d348 <fwp_gc+0x1208>
    695b:	00 
    695c:	48 83 c4 08          	add    $0x8,%rsp
    6960:	5b                   	pop    %rbx
    6961:	41 5e                	pop    %r14
    6963:	41 5f                	pop    %r15
    6965:	5d                   	pop    %rbp
    6966:	c3                   	ret
    6967:	66 0f 1f 84 00 00 00 	nopw   0x0(%rax,%rax,1)
    696e:	00 00 

0000000000006970 <f3>:
    6970:	41 56                	push   %r14
    6972:	53                   	push   %rbx
    6973:	48 83 ec 18          	sub    $0x18,%rsp
    6977:	48 89 f3             	mov    %rsi,%rbx
    697a:	48 89 f8             	mov    %rdi,%rax
    697d:	48 8d 4f 07          	lea    0x7(%rdi),%rcx
    6981:	48 85 ff             	test   %rdi,%rdi
    6984:	48 0f 49 cf          	cmovns %rdi,%rcx
    6988:	48 83 e1 f8          	and    $0xfffffffffffffff8,%rcx
    698c:	48 29 cf             	sub    %rcx,%rdi
    698f:	a8 01                	test   $0x1,%al
    6991:	75 28                	jne    69bb <f3+0x4b>
    6993:	48 83 cf 01          	or     $0x1,%rdi
    6997:	4c 8d 35 ca 71 00 00 	lea    0x71ca(%rip),%r14        # db68 <s0>
    699e:	4c 89 f6             	mov    %r14,%rsi
    69a1:	e8 1a 01 00 00       	call   6ac0 <f20>
    69a6:	48 89 04 24          	mov    %rax,(%rsp)
    69aa:	48 8d 3d c7 71 00 00 	lea    0x71c7(%rip),%rdi        # db78 <fc22>
    69b1:	48 89 e2             	mov    %rsp,%rdx
    69b4:	be 01 00 00 00       	mov    $0x1,%esi
    69b9:	eb 31                	jmp    69ec <f3+0x7c>
    69bb:	48 ff c7             	inc    %rdi
    69be:	4c 8d 35 bb 71 00 00 	lea    0x71bb(%rip),%r14        # db80 <s1>
    69c5:	4c 89 f6             	mov    %r14,%rsi
    69c8:	e8 f3 00 00 00       	call   6ac0 <f20>
    69cd:	48 8d 0d a4 71 00 00 	lea    0x71a4(%rip),%rcx        # db78 <fc22>
    69d4:	48 89 0c 24          	mov    %rcx,(%rsp)
    69d8:	48 89 44 24 08       	mov    %rax,0x8(%rsp)
    69dd:	48 8d 3d ac 71 00 00 	lea    0x71ac(%rip),%rdi        # db90 <fc24>
    69e4:	48 89 e2             	mov    %rsp,%rdx
    69e7:	be 02 00 00 00       	mov    $0x2,%esi
    69ec:	e8 df ed ff ff       	call   57d0 <fwp_apply_owned>
    69f1:	48 89 5c 24 10       	mov    %rbx,0x10(%rsp)
    69f6:	48 8d 54 24 10       	lea    0x10(%rsp),%rdx
    69fb:	48 89 c7             	mov    %rax,%rdi
    69fe:	be 01 00 00 00       	mov    $0x1,%esi
    6a03:	e8 c8 ed ff ff       	call   57d0 <fwp_apply_owned>
    6a08:	48 83 c4 18          	add    $0x18,%rsp
    6a0c:	5b                   	pop    %rbx
    6a0d:	41 5e                	pop    %r14
    6a0f:	c3                   	ret

0000000000006a10 <f26>:
    6a10:	53                   	push   %rbx
    6a11:	48 83 ec 60          	sub    $0x60,%rsp
    6a15:	48 85 ff             	test   %rdi,%rdi
    6a18:	74 3c                	je     6a56 <f26+0x46>
    6a1a:	48 83 ff ff          	cmp    $0xffffffffffffffff,%rdi
    6a1e:	75 0f                	jne    6a2f <f26+0x1f>
    6a20:	48 b8 00 00 00 00 00 	movabs $0x8000000000000000,%rax
    6a27:	00 00 80 
    6a2a:	48 39 c6             	cmp    %rax,%rsi
    6a2d:	74 46                	je     6a75 <f26+0x65>
    6a2f:	48 89 f0             	mov    %rsi,%rax
    6a32:	48 09 f8             	or     %rdi,%rax
    6a35:	48 c1 e8 20          	shr    $0x20,%rax
    6a39:	74 0d                	je     6a48 <f26+0x38>
    6a3b:	48 89 f0             	mov    %rsi,%rax
    6a3e:	48 99                	cqto
    6a40:	48 f7 ff             	idiv   %rdi
    6a43:	48 89 d0             	mov    %rdx,%rax
    6a46:	eb 08                	jmp    6a50 <f26+0x40>
    6a48:	89 f0                	mov    %esi,%eax
    6a4a:	31 d2                	xor    %edx,%edx
    6a4c:	f7 f7                	div    %edi
    6a4e:	89 d0                	mov    %edx,%eax
    6a50:	48 83 c4 60          	add    $0x60,%rsp
    6a54:	5b                   	pop    %rbx
    6a55:	c3                   	ret
    6a56:	e8 75 d3 ff ff       	call   3dd0 <fwp_flush>
    6a5b:	48 8b 05 7e 55 00 00 	mov    0x557e(%rip),%rax        # bfe0 <stderr@GLIBC_2.2.5>
    6a62:	48 8b 38             	mov    (%rax),%rdi
    6a65:	48 8d 35 4c 27 00 00 	lea    0x274c(%rip),%rsi        # 91b8 <_IO_stdin_used+0x1b8>
    6a6c:	48 8d 15 2a 29 00 00 	lea    0x292a(%rip),%rdx        # 939d <_IO_stdin_used+0x39d>
    6a73:	eb 39                	jmp    6aae <f26+0x9e>
    6a75:	48 8d 15 36 29 00 00 	lea    0x2936(%rip),%rdx        # 93b2 <_IO_stdin_used+0x3b2>
    6a7c:	48 8d 0d 2b 29 00 00 	lea    0x292b(%rip),%rcx        # 93ae <_IO_stdin_used+0x3ae>
    6a83:	48 89 e3             	mov    %rsp,%rbx
    6a86:	be 60 00 00 00       	mov    $0x60,%esi
    6a8b:	48 89 df             	mov    %rbx,%rdi
    6a8e:	31 c0                	xor    %eax,%eax
    6a90:	e8 3b b6 ff ff       	call   20d0 <snprintf@plt>
    6a95:	e8 36 d3 ff ff       	call   3dd0 <fwp_flush>
    6a9a:	48 8b 05 3f 55 00 00 	mov    0x553f(%rip),%rax        # bfe0 <stderr@GLIBC_2.2.5>
    6aa1:	48 8b 38             	mov    (%rax),%rdi
    6aa4:	48 8d 35 0d 27 00 00 	lea    0x270d(%rip),%rsi        # 91b8 <_IO_stdin_used+0x1b8>
    6aab:	48 89 da             	mov    %rbx,%rdx
    6aae:	31 c0                	xor    %eax,%eax
    6ab0:	e8 9b b6 ff ff       	call   2150 <fprintf@plt>
    6ab5:	bf 65 00 00 00       	mov    $0x65,%edi
    6aba:	e8 61 b7 ff ff       	call   2220 <exit@plt>
    6abf:	90                   	nop

0000000000006ac0 <f20>:
    6ac0:	55                   	push   %rbp
    6ac1:	41 57                	push   %r15
    6ac3:	41 56                	push   %r14
    6ac5:	41 55                	push   %r13
    6ac7:	41 54                	push   %r12
    6ac9:	53                   	push   %rbx
    6aca:	48 83 ec 18          	sub    $0x18,%rsp
    6ace:	48 89 7c 24 10       	mov    %rdi,0x10(%rsp)
    6ad3:	48 85 ff             	test   %rdi,%rdi
    6ad6:	0f 8e c9 00 00 00    	jle    6ba5 <f20+0xe5>
    6adc:	48 8d 46 08          	lea    0x8(%rsi),%rax
    6ae0:	48 89 04 24          	mov    %rax,(%rsp)
    6ae4:	45 31 e4             	xor    %r12d,%r12d
    6ae7:	31 ed                	xor    %ebp,%ebp
    6ae9:	45 31 f6             	xor    %r14d,%r14d
    6aec:	31 db                	xor    %ebx,%ebx
    6aee:	48 89 74 24 08       	mov    %rsi,0x8(%rsp)
    6af3:	eb 47                	jmp    6b3c <f20+0x7c>
    6af5:	48 89 c5             	mov    %rax,%rbp
    6af8:	48 89 df             	mov    %rbx,%rdi
    6afb:	48 89 ee             	mov    %rbp,%rsi
    6afe:	e8 ad b6 ff ff       	call   21b0 <realloc@plt>
    6b03:	48 89 c3             	mov    %rax,%rbx
    6b06:	48 85 c0             	test   %rax,%rax
    6b09:	0f 84 f4 01 00 00    	je     6d03 <f20+0x243>
    6b0f:	4f 8d 2c 37          	lea    (%r15,%r14,1),%r13
    6b13:	49 01 de             	add    %rbx,%r14
    6b16:	4c 89 f7             	mov    %r14,%rdi
    6b19:	48 8b 34 24          	mov    (%rsp),%rsi
    6b1d:	4c 89 fa             	mov    %r15,%rdx
    6b20:	e8 5b b6 ff ff       	call   2180 <memcpy@plt>
    6b25:	42 c6 04 2b 00       	movb   $0x0,(%rbx,%r13,1)
    6b2a:	49 ff c4             	inc    %r12
    6b2d:	4d 89 ee             	mov    %r13,%r14
    6b30:	4c 3b 64 24 10       	cmp    0x10(%rsp),%r12
    6b35:	48 8b 74 24 08       	mov    0x8(%rsp),%rsi
    6b3a:	74 5a                	je     6b96 <f20+0xd6>
    6b3c:	49 83 fe ff          	cmp    $0xffffffffffffffff,%r14
    6b40:	0f 84 bd 01 00 00    	je     6d03 <f20+0x243>
    6b46:	4c 8b 3e             	mov    (%rsi),%r15
    6b49:	48 c7 c0 fe ff ff ff 	mov    $0xfffffffffffffffe,%rax
    6b50:	4c 29 f0             	sub    %r14,%rax
    6b53:	4c 39 f8             	cmp    %r15,%rax
    6b56:	0f 82 a7 01 00 00    	jb     6d03 <f20+0x243>
    6b5c:	4b 8d 04 37          	lea    (%r15,%r14,1),%rax
    6b60:	48 ff c0             	inc    %rax
    6b63:	48 39 e8             	cmp    %rbp,%rax
    6b66:	76 a7                	jbe    6b0f <f20+0x4f>
    6b68:	48 85 ed             	test   %rbp,%rbp
    6b6b:	b9 40 00 00 00       	mov    $0x40,%ecx
    6b70:	48 0f 44 e9          	cmove  %rcx,%rbp
    6b74:	48 39 c5             	cmp    %rax,%rbp
    6b77:	0f 83 7b ff ff ff    	jae    6af8 <f20+0x38>
    6b7d:	0f 1f 00             	nopl   (%rax)
    6b80:	48 85 ed             	test   %rbp,%rbp
    6b83:	0f 88 6c ff ff ff    	js     6af5 <f20+0x35>
    6b89:	48 01 ed             	add    %rbp,%rbp
    6b8c:	48 39 c5             	cmp    %rax,%rbp
    6b8f:	72 ef                	jb     6b80 <f20+0xc0>
    6b91:	e9 62 ff ff ff       	jmp    6af8 <f20+0x38>
    6b96:	49 8d 55 09          	lea    0x9(%r13),%rdx
    6b9a:	48 81 fa 00 40 00 00 	cmp    $0x4000,%rdx
    6ba1:	76 0c                	jbe    6baf <f20+0xef>
    6ba3:	eb 6b                	jmp    6c10 <f20+0x150>
    6ba5:	ba 09 00 00 00       	mov    $0x9,%edx
    6baa:	45 31 ed             	xor    %r13d,%r13d
    6bad:	31 db                	xor    %ebx,%ebx
    6baf:	49 8d 45 18          	lea    0x18(%r13),%rax
    6bb3:	48 c1 e8 04          	shr    $0x4,%rax
    6bb7:	48 8d 0d 82 55 00 00 	lea    0x5582(%rip),%rcx        # c140 <fwp_gc>
    6bbe:	0f b6 b4 08 e8 0b 00 	movzbl 0xbe8(%rax,%rcx,1),%esi
    6bc5:	00 
    6bc6:	8b 84 b1 48 0b 00 00 	mov    0xb48(%rcx,%rsi,4),%eax
    6bcd:	48 29 05 6c 55 00 00 	sub    %rax,0x556c(%rip)        # c140 <fwp_gc>
    6bd4:	78 3a                	js     6c10 <f20+0x150>
    6bd6:	48 8d 34 76          	lea    (%rsi,%rsi,2),%rsi
    6bda:	48 8d 3c f1          	lea    (%rcx,%rsi,8),%rdi
    6bde:	48 81 c7 c8 03 00 00 	add    $0x3c8,%rdi
    6be5:	4c 8b 3f             	mov    (%rdi),%r15
    6be8:	4d 85 ff             	test   %r15,%r15
    6beb:	74 0b                	je     6bf8 <f20+0x138>
    6bed:	49 8b 07             	mov    (%r15),%rax
    6bf0:	48 f7 d0             	not    %rax
    6bf3:	48 89 07             	mov    %rax,(%rdi)
    6bf6:	eb 3b                	jmp    6c33 <f20+0x173>
    6bf8:	4c 8b bc f1 d0 03 00 	mov    0x3d0(%rcx,%rsi,8),%r15
    6bff:	00 
    6c00:	48 8b bc f1 d8 03 00 	mov    0x3d8(%rcx,%rsi,8),%rdi
    6c07:	00 
    6c08:	4c 29 ff             	sub    %r15,%rdi
    6c0b:	48 39 c7             	cmp    %rax,%rdi
    6c0e:	73 12                	jae    6c22 <f20+0x162>
    6c10:	48 89 d7             	mov    %rdx,%rdi
    6c13:	be 01 00 00 00       	mov    $0x1,%esi
    6c18:	e8 b3 d4 ff ff       	call   40d0 <fwp_gc_alloc_slow>
    6c1d:	49 89 c7             	mov    %rax,%r15
    6c20:	eb 1b                	jmp    6c3d <f20+0x17d>
    6c22:	48 8d 0c f1          	lea    (%rcx,%rsi,8),%rcx
    6c26:	48 81 c1 d0 03 00 00 	add    $0x3d0,%rcx
    6c2d:	4c 01 f8             	add    %r15,%rax
    6c30:	48 89 01             	mov    %rax,(%rcx)
    6c33:	4c 89 ff             	mov    %r15,%rdi
    6c36:	31 f6                	xor    %esi,%esi
    6c38:	e8 a3 b4 ff ff       	call   20e0 <memset@plt>
    6c3d:	48 85 db             	test   %rbx,%rbx
    6c40:	4c 8d 35 a9 27 00 00 	lea    0x27a9(%rip),%r14        # 93f0 <_IO_stdin_used+0x3f0>
    6c47:	4c 0f 45 f3          	cmovne %rbx,%r14
    6c4b:	4d 89 2f             	mov    %r13,(%r15)
    6c4e:	49 8d 7f 08          	lea    0x8(%r15),%rdi
    6c52:	4c 89 f6             	mov    %r14,%rsi
    6c55:	4c 89 ea             	mov    %r13,%rdx
    6c58:	e8 23 b5 ff ff       	call   2180 <memcpy@plt>
    6c5d:	43 c6 44 2f 08 00    	movb   $0x0,0x8(%r15,%r13,1)
    6c63:	48 89 df             	mov    %rbx,%rdi
    6c66:	e8 e5 b3 ff ff       	call   2050 <free@plt>
    6c6b:	4c 89 f8             	mov    %r15,%rax
    6c6e:	48 2b 05 fb 64 00 00 	sub    0x64fb(%rip),%rax        # d170 <fwp_gc+0x1030>
    6c75:	48 8b 0d 1c 65 00 00 	mov    0x651c(%rip),%rcx        # d198 <fwp_gc+0x1058>
    6c7c:	48 c1 e1 10          	shl    $0x10,%rcx
    6c80:	48 39 c8             	cmp    %rcx,%rax
    6c83:	73 6c                	jae    6cf1 <f20+0x231>
    6c85:	48 8b 0d 2c 65 00 00 	mov    0x652c(%rip),%rcx        # d1b8 <fwp_gc+0x1078>
    6c8c:	48 89 c2             	mov    %rax,%rdx
    6c8f:	48 c1 ea 10          	shr    $0x10,%rdx
    6c93:	48 69 d2 28 12 00 00 	imul   $0x1228,%rdx,%rdx
    6c9a:	0f b6 34 11          	movzbl (%rcx,%rdx,1),%esi
    6c9e:	48 25 ff ff 00 00    	and    $0xffff,%rax
    6ca4:	75 1b                	jne    6cc1 <f20+0x201>
    6ca6:	40 80 fe 02          	cmp    $0x2,%sil
    6caa:	75 15                	jne    6cc1 <f20+0x201>
    6cac:	48 8d 1c 11          	lea    (%rcx,%rdx,1),%rbx
    6cb0:	48 81 c3 28 02 00 00 	add    $0x228,%rbx
    6cb7:	80 3b ff             	cmpb   $0xff,(%rbx)
    6cba:	74 2b                	je     6ce7 <f20+0x227>
    6cbc:	c6 03 01             	movb   $0x1,(%rbx)
    6cbf:	eb 30                	jmp    6cf1 <f20+0x231>
    6cc1:	40 80 fe 01          	cmp    $0x1,%sil
    6cc5:	75 2a                	jne    6cf1 <f20+0x231>
    6cc7:	48 8d 34 11          	lea    (%rcx,%rdx,1),%rsi
    6ccb:	8b 4c 11 20          	mov    0x20(%rcx,%rdx,1),%ecx
    6ccf:	48 0f af c1          	imul   %rcx,%rax
    6cd3:	48 c1 e8 20          	shr    $0x20,%rax
    6cd7:	48 8d 1c 30          	lea    (%rax,%rsi,1),%rbx
    6cdb:	48 81 c3 28 02 00 00 	add    $0x228,%rbx
    6ce2:	80 3b ff             	cmpb   $0xff,(%rbx)
    6ce5:	75 d5                	jne    6cbc <f20+0x1fc>
    6ce7:	48 89 df             	mov    %rbx,%rdi
    6cea:	e8 11 d1 ff ff       	call   3e00 <fwp_rc_forget_slot>
    6cef:	eb cb                	jmp    6cbc <f20+0x1fc>
    6cf1:	4c 89 f8             	mov    %r15,%rax
    6cf4:	48 83 c4 18          	add    $0x18,%rsp
    6cf8:	5b                   	pop    %rbx
    6cf9:	41 5c                	pop    %r12
    6cfb:	41 5d                	pop    %r13
    6cfd:	41 5e                	pop    %r14
    6cff:	41 5f                	pop    %r15
    6d01:	5d                   	pop    %rbp
    6d02:	c3                   	ret
    6d03:	48 8b 05 d6 52 00 00 	mov    0x52d6(%rip),%rax        # bfe0 <stderr@GLIBC_2.2.5>
    6d0a:	48 8b 08             	mov    (%rax),%rcx
    6d0d:	48 8d 3d a2 25 00 00 	lea    0x25a2(%rip),%rdi        # 92b6 <_IO_stdin_used+0x2b6>
    6d14:	be 13 00 00 00       	mov    $0x13,%esi
    6d19:	ba 01 00 00 00       	mov    $0x1,%edx
    6d1e:	e8 0d b5 ff ff       	call   2230 <fwrite@plt>
    6d23:	bf 66 00 00 00       	mov    $0x66,%edi
    6d28:	e8 f3 b4 ff ff       	call   2220 <exit@plt>
    6d2d:	0f 1f 00             	nopl   (%rax)

0000000000006d30 <fwp_owned_entry3>:
    6d30:	48 8b 07             	mov    (%rdi),%rax
    6d33:	48 8b 77 08          	mov    0x8(%rdi),%rsi
    6d37:	48 89 c7             	mov    %rax,%rdi
    6d3a:	e9 31 fc ff ff       	jmp    6970 <f3>
    6d3f:	90                   	nop

0000000000006d40 <fwp_caps3>:
    6d40:	53                   	push   %rbx
    6d41:	83 7f 04 02          	cmpl   $0x2,0x4(%rdi)
    6d45:	72 57                	jb     6d9e <fwp_caps3+0x5e>
    6d47:	48 8b 47 10          	mov    0x10(%rdi),%rax
    6d4b:	48 89 c1             	mov    %rax,%rcx
    6d4e:	48 2b 0d 1b 64 00 00 	sub    0x641b(%rip),%rcx        # d170 <fwp_gc+0x1030>
    6d55:	48 8b 15 3c 64 00 00 	mov    0x643c(%rip),%rdx        # d198 <fwp_gc+0x1058>
    6d5c:	48 c1 e2 10          	shl    $0x10,%rdx
    6d60:	85 f6                	test   %esi,%esi
    6d62:	74 44                	je     6da8 <fwp_caps3+0x68>
    6d64:	48 39 d1             	cmp    %rdx,%rcx
    6d67:	73 3d                	jae    6da6 <fwp_caps3+0x66>
    6d69:	48 8b 05 48 64 00 00 	mov    0x6448(%rip),%rax        # d1b8 <fwp_gc+0x1078>
    6d70:	48 89 ca             	mov    %rcx,%rdx
    6d73:	48 c1 ea 10          	shr    $0x10,%rdx
    6d77:	48 69 d2 28 12 00 00 	imul   $0x1228,%rdx,%rdx
    6d7e:	0f b6 34 10          	movzbl (%rax,%rdx,1),%esi
    6d82:	48 81 e1 ff ff 00 00 	and    $0xffff,%rcx
    6d89:	75 5c                	jne    6de7 <fwp_caps3+0xa7>
    6d8b:	40 80 fe 02          	cmp    $0x2,%sil
    6d8f:	75 56                	jne    6de7 <fwp_caps3+0xa7>
    6d91:	48 8d 3c 10          	lea    (%rax,%rdx,1),%rdi
    6d95:	48 81 c7 28 02 00 00 	add    $0x228,%rdi
    6d9c:	eb 6a                	jmp    6e08 <fwp_caps3+0xc8>
    6d9e:	85 f6                	test   %esi,%esi
    6da0:	0f 84 ad 00 00 00    	je     6e53 <fwp_caps3+0x113>
    6da6:	5b                   	pop    %rbx
    6da7:	c3                   	ret
    6da8:	48 39 d1             	cmp    %rdx,%rcx
    6dab:	0f 83 a2 00 00 00    	jae    6e53 <fwp_caps3+0x113>
    6db1:	48 8b 15 00 64 00 00 	mov    0x6400(%rip),%rdx        # d1b8 <fwp_gc+0x1078>
    6db8:	48 89 ce             	mov    %rcx,%rsi
    6dbb:	48 c1 ee 10          	shr    $0x10,%rsi
    6dbf:	48 69 f6 28 12 00 00 	imul   $0x1228,%rsi,%rsi
    6dc6:	44 0f b6 04 32       	movzbl (%rdx,%rsi,1),%r8d
    6dcb:	48 81 e1 ff ff 00 00 	and    $0xffff,%rcx
    6dd2:	75 45                	jne    6e19 <fwp_caps3+0xd9>
    6dd4:	41 80 f8 02          	cmp    $0x2,%r8b
    6dd8:	75 3f                	jne    6e19 <fwp_caps3+0xd9>
    6dda:	48 8d 0c 32          	lea    (%rdx,%rsi,1),%rcx
    6dde:	48 81 c1 28 02 00 00 	add    $0x228,%rcx
    6de5:	eb 52                	jmp    6e39 <fwp_caps3+0xf9>
    6de7:	40 80 fe 01          	cmp    $0x1,%sil
    6deb:	75 b9                	jne    6da6 <fwp_caps3+0x66>
    6ded:	48 8d 34 10          	lea    (%rax,%rdx,1),%rsi
    6df1:	8b 44 10 20          	mov    0x20(%rax,%rdx,1),%eax
    6df5:	48 0f af c8          	imul   %rax,%rcx
    6df9:	48 c1 e9 20          	shr    $0x20,%rcx
    6dfd:	48 8d 3c 31          	lea    (%rcx,%rsi,1),%rdi
    6e01:	48 81 c7 28 02 00 00 	add    $0x228,%rdi
    6e08:	0f b6 07             	movzbl (%rdi),%eax
    6e0b:	84 c0                	test   %al,%al
    6e0d:	74 97                	je     6da6 <fwp_caps3+0x66>
    6e0f:	3c fe                	cmp    $0xfe,%al
    6e11:	73 58                	jae    6e6b <fwp_caps3+0x12b>
    6e13:	fe c0                	inc    %al
    6e15:	88 07                	mov    %al,(%rdi)
    6e17:	5b                   	pop    %rbx
    6e18:	c3                   	ret
    6e19:	41 80 f8 01          	cmp    $0x1,%r8b
    6e1d:	75 34                	jne    6e53 <fwp_caps3+0x113>
    6e1f:	4c 8d 04 32          	lea    (%rdx,%rsi,1),%r8
    6e23:	8b 54 32 20          	mov    0x20(%rdx,%rsi,1),%edx
    6e27:	48 0f af ca          	imul   %rdx,%rcx
    6e2b:	48 c1 e9 20          	shr    $0x20,%rcx
    6e2f:	4c 01 c1             	add    %r8,%rcx
    6e32:	48 81 c1 28 02 00 00 	add    $0x228,%rcx
    6e39:	0f b6 11             	movzbl (%rcx),%edx
    6e3c:	85 d2                	test   %edx,%edx
    6e3e:	74 13                	je     6e53 <fwp_caps3+0x113>
    6e40:	83 fa 01             	cmp    $0x1,%edx
    6e43:	75 14                	jne    6e59 <fwp_caps3+0x119>
    6e45:	48 89 fb             	mov    %rdi,%rbx
    6e48:	48 89 c7             	mov    %rax,%rdi
    6e4b:	e8 40 f9 ff ff       	call   6790 <fwp_rc_free_obj>
    6e50:	48 89 df             	mov    %rbx,%rdi
    6e53:	5b                   	pop    %rbx
    6e54:	e9 37 f9 ff ff       	jmp    6790 <fwp_rc_free_obj>
    6e59:	81 fa ff 00 00 00    	cmp    $0xff,%edx
    6e5f:	74 10                	je     6e71 <fwp_caps3+0x131>
    6e61:	fe ca                	dec    %dl
    6e63:	88 11                	mov    %dl,(%rcx)
    6e65:	5b                   	pop    %rbx
    6e66:	e9 25 f9 ff ff       	jmp    6790 <fwp_rc_free_obj>
    6e6b:	5b                   	pop    %rbx
    6e6c:	e9 cf f1 ff ff       	jmp    6040 <fwp_rc_wide_dup>
    6e71:	48 89 fb             	mov    %rdi,%rbx
    6e74:	48 89 cf             	mov    %rcx,%rdi
    6e77:	e8 34 f6 ff ff       	call   64b0 <fwp_rc_wide_drop>
    6e7c:	eb d2                	jmp    6e50 <fwp_caps3+0x110>
    6e7e:	66 90                	xchg   %ax,%ax

0000000000006e80 <fwp_args3>:
    6e80:	83 fe 01             	cmp    $0x1,%esi
    6e83:	0f 87 90 00 00 00    	ja     6f19 <fwp_args3+0x99>
    6e89:	83 f6 01             	xor    $0x1,%esi
    6e8c:	39 d6                	cmp    %edx,%esi
    6e8e:	0f 83 85 00 00 00    	jae    6f19 <fwp_args3+0x99>
    6e94:	89 f0                	mov    %esi,%eax
    6e96:	48 8b 04 c7          	mov    (%rdi,%rax,8),%rax
    6e9a:	48 2b 05 cf 62 00 00 	sub    0x62cf(%rip),%rax        # d170 <fwp_gc+0x1030>
    6ea1:	48 8b 0d f0 62 00 00 	mov    0x62f0(%rip),%rcx        # d198 <fwp_gc+0x1058>
    6ea8:	48 c1 e1 10          	shl    $0x10,%rcx
    6eac:	48 39 c8             	cmp    %rcx,%rax
    6eaf:	73 68                	jae    6f19 <fwp_args3+0x99>
    6eb1:	48 8b 0d 00 63 00 00 	mov    0x6300(%rip),%rcx        # d1b8 <fwp_gc+0x1078>
    6eb8:	48 89 c2             	mov    %rax,%rdx
    6ebb:	48 c1 ea 10          	shr    $0x10,%rdx
    6ebf:	48 69 d2 28 12 00 00 	imul   $0x1228,%rdx,%rdx
    6ec6:	0f b6 34 11          	movzbl (%rcx,%rdx,1),%esi
    6eca:	48 25 ff ff 00 00    	and    $0xffff,%rax
    6ed0:	75 13                	jne    6ee5 <fwp_args3+0x65>
    6ed2:	40 80 fe 02          	cmp    $0x2,%sil
    6ed6:	75 0d                	jne    6ee5 <fwp_args3+0x65>
    6ed8:	48 8d 3c 11          	lea    (%rcx,%rdx,1),%rdi
    6edc:	48 81 c7 28 02 00 00 	add    $0x228,%rdi
    6ee3:	eb 21                	jmp    6f06 <fwp_args3+0x86>
    6ee5:	40 80 fe 01          	cmp    $0x1,%sil
    6ee9:	75 2e                	jne    6f19 <fwp_args3+0x99>
    6eeb:	48 8d 34 11          	lea    (%rcx,%rdx,1),%rsi
    6eef:	8b 4c 11 20          	mov    0x20(%rcx,%rdx,1),%ecx
    6ef3:	48 0f af c1          	imul   %rcx,%rax
    6ef7:	48 c1 e8 20          	shr    $0x20,%rax
    6efb:	48 8d 3c 30          	lea    (%rax,%rsi,1),%rdi
    6eff:	48 81 c7 28 02 00 00 	add    $0x228,%rdi
    6f06:	0f b6 07             	movzbl (%rdi),%eax
    6f09:	84 c0                	test   %al,%al
    6f0b:	74 0c                	je     6f19 <fwp_args3+0x99>
    6f0d:	3c fe                	cmp    $0xfe,%al
    6f0f:	0f 83 2b f1 ff ff    	jae    6040 <fwp_rc_wide_dup>
    6f15:	fe c0                	inc    %al
    6f17:	88 07                	mov    %al,(%rdi)
    6f19:	c3                   	ret
    6f1a:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)

0000000000006f20 <fwp_arg_drop3>:
    6f20:	83 fe 01             	cmp    $0x1,%esi
    6f23:	0f 87 99 00 00 00    	ja     6fc2 <fwp_arg_drop3+0xa2>
    6f29:	83 f6 01             	xor    $0x1,%esi
    6f2c:	39 d6                	cmp    %edx,%esi
    6f2e:	0f 83 8e 00 00 00    	jae    6fc2 <fwp_arg_drop3+0xa2>
    6f34:	89 f0                	mov    %esi,%eax
    6f36:	48 8b 3c c7          	mov    (%rdi,%rax,8),%rdi
    6f3a:	48 89 f8             	mov    %rdi,%rax
    6f3d:	48 2b 05 2c 62 00 00 	sub    0x622c(%rip),%rax        # d170 <fwp_gc+0x1030>
    6f44:	48 8b 0d 4d 62 00 00 	mov    0x624d(%rip),%rcx        # d198 <fwp_gc+0x1058>
    6f4b:	48 c1 e1 10          	shl    $0x10,%rcx
    6f4f:	48 39 c8             	cmp    %rcx,%rax
    6f52:	73 6e                	jae    6fc2 <fwp_arg_drop3+0xa2>
    6f54:	48 8b 0d 5d 62 00 00 	mov    0x625d(%rip),%rcx        # d1b8 <fwp_gc+0x1078>
    6f5b:	48 89 c2             	mov    %rax,%rdx
    6f5e:	48 c1 ea 10          	shr    $0x10,%rdx
    6f62:	48 69 d2 28 12 00 00 	imul   $0x1228,%rdx,%rdx
    6f69:	0f b6 34 11          	movzbl (%rcx,%rdx,1),%esi
    6f6d:	48 25 ff ff 00 00    	and    $0xffff,%rax
    6f73:	75 12                	jne    6f87 <fwp_arg_drop3+0x67>
    6f75:	40 80 fe 02          	cmp    $0x2,%sil
    6f79:	75 0c                	jne    6f87 <fwp_arg_drop3+0x67>
    6f7b:	48 8d 04 11          	lea    (%rcx,%rdx,1),%rax
    6f7f:	48 05 28 02 00 00    	add    $0x228,%rax
    6f85:	eb 1f                	jmp    6fa6 <fwp_arg_drop3+0x86>
    6f87:	40 80 fe 01          	cmp    $0x1,%sil
    6f8b:	75 35                	jne    6fc2 <fwp_arg_drop3+0xa2>
    6f8d:	48 8d 34 11          	lea    (%rcx,%rdx,1),%rsi
    6f91:	8b 4c 11 20          	mov    0x20(%rcx,%rdx,1),%ecx
    6f95:	48 0f af c1          	imul   %rcx,%rax
    6f99:	48 c1 e8 20          	shr    $0x20,%rax
    6f9d:	48 01 f0             	add    %rsi,%rax
    6fa0:	48 05 28 02 00 00    	add    $0x228,%rax
    6fa6:	0f b6 08             	movzbl (%rax),%ecx
    6fa9:	85 c9                	test   %ecx,%ecx
    6fab:	74 15                	je     6fc2 <fwp_arg_drop3+0xa2>
    6fad:	83 f9 01             	cmp    $0x1,%ecx
    6fb0:	0f 84 da f7 ff ff    	je     6790 <fwp_rc_free_obj>
    6fb6:	81 f9 ff 00 00 00    	cmp    $0xff,%ecx
    6fbc:	74 05                	je     6fc3 <fwp_arg_drop3+0xa3>
    6fbe:	fe c9                	dec    %cl
    6fc0:	88 08                	mov    %cl,(%rax)
    6fc2:	c3                   	ret
    6fc3:	48 89 c7             	mov    %rax,%rdi
    6fc6:	e9 e5 f4 ff ff       	jmp    64b0 <fwp_rc_wide_drop>
    6fcb:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)

0000000000006fd0 <f8>:
    6fd0:	41 57                	push   %r15
    6fd2:	41 56                	push   %r14
    6fd4:	53                   	push   %rbx
    6fd5:	48 83 ec 20          	sub    $0x20,%rsp
    6fd9:	48 be 00 00 00 00 01 	movabs $0x100000000,%rsi
    6fe0:	00 00 00 
    6fe3:	48 89 f9             	mov    %rdi,%rcx
    6fe6:	48 f7 d9             	neg    %rcx
    6fe9:	48 0f 48 cf          	cmovs  %rdi,%rcx
    6fed:	48 8d 5c 24 18       	lea    0x18(%rsp),%rbx
    6ff2:	4c 8d 44 24 17       	lea    0x17(%rsp),%r8
    6ff7:	45 31 f6             	xor    %r14d,%r14d
    6ffa:	49 b9 cd cc cc cc cc 	movabs $0xcccccccccccccccd,%r9
    7001:	cc cc cc 
    7004:	66 66 66 2e 0f 1f 84 	data16 data16 cs nopw 0x0(%rax,%rax,1)
    700b:	00 00 00 00 00 
    7010:	48 89 c8             	mov    %rcx,%rax
    7013:	49 f7 e1             	mul    %r9
    7016:	48 c1 ea 03          	shr    $0x3,%rdx
    701a:	8d 04 12             	lea    (%rdx,%rdx,1),%eax
    701d:	8d 04 80             	lea    (%rax,%rax,4),%eax
    7020:	41 89 ca             	mov    %ecx,%r10d
    7023:	41 29 c2             	sub    %eax,%r10d
    7026:	41 80 ca 30          	or     $0x30,%r10b
    702a:	45 88 10             	mov    %r10b,(%r8)
    702d:	49 01 f6             	add    %rsi,%r14
    7030:	49 ff c8             	dec    %r8
    7033:	48 83 f9 09          	cmp    $0x9,%rcx
    7037:	48 89 d1             	mov    %rdx,%rcx
    703a:	77 d4                	ja     7010 <f8+0x40>
    703c:	48 85 ff             	test   %rdi,%rdi
    703f:	78 06                	js     7047 <f8+0x77>
    7041:	49 c1 fe 20          	sar    $0x20,%r14
    7045:	eb 11                	jmp    7058 <f8+0x88>
    7047:	49 01 f6             	add    %rsi,%r14
    704a:	49 c1 fe 20          	sar    $0x20,%r14
    704e:	48 89 e0             	mov    %rsp,%rax
    7051:	4c 29 f0             	sub    %r14,%rax
    7054:	c6 40 18 2d          	movb   $0x2d,0x18(%rax)
    7058:	49 8d 56 09          	lea    0x9(%r14),%rdx
    705c:	48 81 fa 00 40 00 00 	cmp    $0x4000,%rdx
    7063:	77 61                	ja     70c6 <f8+0xf6>
    7065:	49 8d 4e 18          	lea    0x18(%r14),%rcx
    7069:	48 c1 e9 04          	shr    $0x4,%rcx
    706d:	48 8d 05 cc 50 00 00 	lea    0x50cc(%rip),%rax        # c140 <fwp_gc>
    7074:	0f b6 b4 01 e8 0b 00 	movzbl 0xbe8(%rcx,%rax,1),%esi
    707b:	00 
    707c:	8b 8c b0 48 0b 00 00 	mov    0xb48(%rax,%rsi,4),%ecx
    7083:	48 29 0d b6 50 00 00 	sub    %rcx,0x50b6(%rip)        # c140 <fwp_gc>
    708a:	78 3a                	js     70c6 <f8+0xf6>
    708c:	48 8d 34 76          	lea    (%rsi,%rsi,2),%rsi
    7090:	48 8d 3c f0          	lea    (%rax,%rsi,8),%rdi
    7094:	48 81 c7 c8 03 00 00 	add    $0x3c8,%rdi
    709b:	4c 8b 3f             	mov    (%rdi),%r15
    709e:	4d 85 ff             	test   %r15,%r15
    70a1:	74 0b                	je     70ae <f8+0xde>
    70a3:	49 8b 07             	mov    (%r15),%rax
    70a6:	48 f7 d0             	not    %rax
    70a9:	48 89 07             	mov    %rax,(%rdi)
    70ac:	eb 3a                	jmp    70e8 <f8+0x118>
    70ae:	4c 8b bc f0 d0 03 00 	mov    0x3d0(%rax,%rsi,8),%r15
    70b5:	00 
    70b6:	48 8b bc f0 d8 03 00 	mov    0x3d8(%rax,%rsi,8),%rdi
    70bd:	00 
    70be:	4c 29 ff             	sub    %r15,%rdi
    70c1:	48 39 cf             	cmp    %rcx,%rdi
    70c4:	73 12                	jae    70d8 <f8+0x108>
    70c6:	48 89 d7             	mov    %rdx,%rdi
    70c9:	be 01 00 00 00       	mov    $0x1,%esi
    70ce:	e8 fd cf ff ff       	call   40d0 <fwp_gc_alloc_slow>
    70d3:	49 89 c7             	mov    %rax,%r15
    70d6:	eb 1a                	jmp    70f2 <f8+0x122>
    70d8:	48 8d 04 f0          	lea    (%rax,%rsi,8),%rax
    70dc:	48 05 d0 03 00 00    	add    $0x3d0,%rax
    70e2:	4c 01 f9             	add    %r15,%rcx
    70e5:	48 89 08             	mov    %rcx,(%rax)
    70e8:	4c 89 ff             	mov    %r15,%rdi
    70eb:	31 f6                	xor    %esi,%esi
    70ed:	e8 ee af ff ff       	call   20e0 <memset@plt>
    70f2:	4c 29 f3             	sub    %r14,%rbx
    70f5:	4d 89 37             	mov    %r14,(%r15)
    70f8:	49 8d 7f 08          	lea    0x8(%r15),%rdi
    70fc:	48 89 de             	mov    %rbx,%rsi
    70ff:	4c 89 f2             	mov    %r14,%rdx
    7102:	e8 79 b0 ff ff       	call   2180 <memcpy@plt>
    7107:	43 c6 44 37 08 00    	movb   $0x0,0x8(%r15,%r14,1)
    710d:	4c 89 f8             	mov    %r15,%rax
    7110:	48 2b 05 59 60 00 00 	sub    0x6059(%rip),%rax        # d170 <fwp_gc+0x1030>
    7117:	48 8b 0d 7a 60 00 00 	mov    0x607a(%rip),%rcx        # d198 <fwp_gc+0x1058>
    711e:	48 c1 e1 10          	shl    $0x10,%rcx
    7122:	48 39 c8             	cmp    %rcx,%rax
    7125:	73 6c                	jae    7193 <f8+0x1c3>
    7127:	48 8b 0d 8a 60 00 00 	mov    0x608a(%rip),%rcx        # d1b8 <fwp_gc+0x1078>
    712e:	48 89 c2             	mov    %rax,%rdx
    7131:	48 c1 ea 10          	shr    $0x10,%rdx
    7135:	48 69 d2 28 12 00 00 	imul   $0x1228,%rdx,%rdx
    713c:	0f b6 34 11          	movzbl (%rcx,%rdx,1),%esi
    7140:	48 25 ff ff 00 00    	and    $0xffff,%rax
    7146:	75 1b                	jne    7163 <f8+0x193>
    7148:	40 80 fe 02          	cmp    $0x2,%sil
    714c:	75 15                	jne    7163 <f8+0x193>
    714e:	48 8d 1c 11          	lea    (%rcx,%rdx,1),%rbx
    7152:	48 81 c3 28 02 00 00 	add    $0x228,%rbx
    7159:	80 3b ff             	cmpb   $0xff,(%rbx)
    715c:	74 2b                	je     7189 <f8+0x1b9>
    715e:	c6 03 01             	movb   $0x1,(%rbx)
    7161:	eb 30                	jmp    7193 <f8+0x1c3>
    7163:	40 80 fe 01          	cmp    $0x1,%sil
    7167:	75 2a                	jne    7193 <f8+0x1c3>
    7169:	48 8d 34 11          	lea    (%rcx,%rdx,1),%rsi
    716d:	8b 4c 11 20          	mov    0x20(%rcx,%rdx,1),%ecx
    7171:	48 0f af c1          	imul   %rcx,%rax
    7175:	48 c1 e8 20          	shr    $0x20,%rax
    7179:	48 8d 1c 30          	lea    (%rax,%rsi,1),%rbx
    717d:	48 81 c3 28 02 00 00 	add    $0x228,%rbx
    7184:	80 3b ff             	cmpb   $0xff,(%rbx)
    7187:	75 d5                	jne    715e <f8+0x18e>
    7189:	48 89 df             	mov    %rbx,%rdi
    718c:	e8 6f cc ff ff       	call   3e00 <fwp_rc_forget_slot>
    7191:	eb cb                	jmp    715e <f8+0x18e>
    7193:	4c 89 f8             	mov    %r15,%rax
    7196:	48 83 c4 20          	add    $0x20,%rsp
    719a:	5b                   	pop    %rbx
    719b:	41 5e                	pop    %r14
    719d:	41 5f                	pop    %r15
    719f:	c3                   	ret

00000000000071a0 <f22>:
    71a0:	41 57                	push   %r15
    71a2:	41 56                	push   %r14
    71a4:	41 54                	push   %r12
    71a6:	53                   	push   %rbx
    71a7:	50                   	push   %rax
    71a8:	49 89 f7             	mov    %rsi,%r15
    71ab:	49 89 fe             	mov    %rdi,%r14
    71ae:	48 8b 06             	mov    (%rsi),%rax
    71b1:	48 8b 0f             	mov    (%rdi),%rcx
    71b4:	48 8d 14 08          	lea    (%rax,%rcx,1),%rdx
    71b8:	48 83 c2 09          	add    $0x9,%rdx
    71bc:	48 81 fa 00 40 00 00 	cmp    $0x4000,%rdx
    71c3:	77 68                	ja     722d <f22+0x8d>
    71c5:	48 01 c1             	add    %rax,%rcx
    71c8:	48 83 c1 08          	add    $0x8,%rcx
    71cc:	48 83 c1 10          	add    $0x10,%rcx
    71d0:	48 c1 e9 04          	shr    $0x4,%rcx
    71d4:	48 8d 05 65 4f 00 00 	lea    0x4f65(%rip),%rax        # c140 <fwp_gc>
    71db:	0f b6 b4 01 e8 0b 00 	movzbl 0xbe8(%rcx,%rax,1),%esi
    71e2:	00 
    71e3:	8b 8c b0 48 0b 00 00 	mov    0xb48(%rax,%rsi,4),%ecx
    71ea:	48 29 0d 4f 4f 00 00 	sub    %rcx,0x4f4f(%rip)        # c140 <fwp_gc>
    71f1:	78 3a                	js     722d <f22+0x8d>
    71f3:	48 8d 34 76          	lea    (%rsi,%rsi,2),%rsi
    71f7:	48 8d 3c f0          	lea    (%rax,%rsi,8),%rdi
    71fb:	48 81 c7 c8 03 00 00 	add    $0x3c8,%rdi
    7202:	48 8b 1f             	mov    (%rdi),%rbx
    7205:	48 85 db             	test   %rbx,%rbx
    7208:	74 0b                	je     7215 <f22+0x75>
    720a:	48 8b 03             	mov    (%rbx),%rax
    720d:	48 f7 d0             	not    %rax
    7210:	48 89 07             	mov    %rax,(%rdi)
    7213:	eb 3a                	jmp    724f <f22+0xaf>
    7215:	48 8b 9c f0 d0 03 00 	mov    0x3d0(%rax,%rsi,8),%rbx
    721c:	00 
    721d:	48 8b bc f0 d8 03 00 	mov    0x3d8(%rax,%rsi,8),%rdi
    7224:	00 
    7225:	48 29 df             	sub    %rbx,%rdi
    7228:	48 39 cf             	cmp    %rcx,%rdi
    722b:	73 12                	jae    723f <f22+0x9f>
    722d:	48 89 d7             	mov    %rdx,%rdi
    7230:	be 01 00 00 00       	mov    $0x1,%esi
    7235:	e8 96 ce ff ff       	call   40d0 <fwp_gc_alloc_slow>
    723a:	48 89 c3             	mov    %rax,%rbx
    723d:	eb 1a                	jmp    7259 <f22+0xb9>
    723f:	48 8d 04 f0          	lea    (%rax,%rsi,8),%rax
    7243:	48 05 d0 03 00 00    	add    $0x3d0,%rax
    7249:	48 01 d9             	add    %rbx,%rcx
    724c:	48 89 08             	mov    %rcx,(%rax)
    724f:	48 89 df             	mov    %rbx,%rdi
    7252:	31 f6                	xor    %esi,%esi
    7254:	e8 87 ae ff ff       	call   20e0 <memset@plt>
    7259:	49 8b 06             	mov    (%r14),%rax
    725c:	49 03 07             	add    (%r15),%rax
    725f:	48 89 03             	mov    %rax,(%rbx)
    7262:	4c 8d 63 08          	lea    0x8(%rbx),%r12
    7266:	49 8d 77 08          	lea    0x8(%r15),%rsi
    726a:	49 8b 17             	mov    (%r15),%rdx
    726d:	4c 89 e7             	mov    %r12,%rdi
    7270:	e8 0b af ff ff       	call   2180 <memcpy@plt>
    7275:	4d 03 27             	add    (%r15),%r12
    7278:	49 8b 16             	mov    (%r14),%rdx
    727b:	49 83 c6 08          	add    $0x8,%r14
    727f:	4c 89 e7             	mov    %r12,%rdi
    7282:	4c 89 f6             	mov    %r14,%rsi
    7285:	e8 f6 ae ff ff       	call   2180 <memcpy@plt>
    728a:	48 8b 03             	mov    (%rbx),%rax
    728d:	c6 44 03 08 00       	movb   $0x0,0x8(%rbx,%rax,1)
    7292:	48 89 d8             	mov    %rbx,%rax
    7295:	48 2b 05 d4 5e 00 00 	sub    0x5ed4(%rip),%rax        # d170 <fwp_gc+0x1030>
    729c:	48 8b 0d f5 5e 00 00 	mov    0x5ef5(%rip),%rcx        # d198 <fwp_gc+0x1058>
    72a3:	48 c1 e1 10          	shl    $0x10,%rcx
    72a7:	48 39 c8             	cmp    %rcx,%rax
    72aa:	73 6f                	jae    731b <f22+0x17b>
    72ac:	48 8b 0d 05 5f 00 00 	mov    0x5f05(%rip),%rcx        # d1b8 <fwp_gc+0x1078>
    72b3:	48 89 c2             	mov    %rax,%rdx
    72b6:	48 c1 ea 10          	shr    $0x10,%rdx
    72ba:	48 69 d2 28 12 00 00 	imul   $0x1228,%rdx,%rdx
    72c1:	0f b6 34 11          	movzbl (%rcx,%rdx,1),%esi
    72c5:	48 25 ff ff 00 00    	and    $0xffff,%rax
    72cb:	75 1d                	jne    72ea <f22+0x14a>
    72cd:	40 80 fe 02          	cmp    $0x2,%sil
    72d1:	75 17                	jne    72ea <f22+0x14a>
    72d3:	4c 8d 34 11          	lea    (%rcx,%rdx,1),%r14
    72d7:	49 81 c6 28 02 00 00 	add    $0x228,%r14
    72de:	41 80 3e ff          	cmpb   $0xff,(%r14)
    72e2:	74 2d                	je     7311 <f22+0x171>
    72e4:	41 c6 06 01          	movb   $0x1,(%r14)
    72e8:	eb 31                	jmp    731b <f22+0x17b>
    72ea:	40 80 fe 01          	cmp    $0x1,%sil
    72ee:	75 2b                	jne    731b <f22+0x17b>
    72f0:	48 8d 34 11          	lea    (%rcx,%rdx,1),%rsi
    72f4:	8b 4c 11 20          	mov    0x20(%rcx,%rdx,1),%ecx
    72f8:	48 0f af c1          	imul   %rcx,%rax
    72fc:	48 c1 e8 20          	shr    $0x20,%rax
    7300:	4c 8d 34 30          	lea    (%rax,%rsi,1),%r14
    7304:	49 81 c6 28 02 00 00 	add    $0x228,%r14
    730b:	41 80 3e ff          	cmpb   $0xff,(%r14)
    730f:	75 d3                	jne    72e4 <f22+0x144>
    7311:	4c 89 f7             	mov    %r14,%rdi
    7314:	e8 e7 ca ff ff       	call   3e00 <fwp_rc_forget_slot>
    7319:	eb c9                	jmp    72e4 <f22+0x144>
    731b:	48 89 d8             	mov    %rbx,%rax
    731e:	48 83 c4 08          	add    $0x8,%rsp
    7322:	5b                   	pop    %rbx
    7323:	41 5c                	pop    %r12
    7325:	41 5e                	pop    %r14
    7327:	41 5f                	pop    %r15
    7329:	c3                   	ret
    732a:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)

0000000000007330 <fwp_owned_entry22>:
    7330:	41 56                	push   %r14
    7332:	53                   	push   %rbx
    7333:	50                   	push   %rax
    7334:	48 89 fb             	mov    %rdi,%rbx
    7337:	48 8b 3f             	mov    (%rdi),%rdi
    733a:	48 8b 73 08          	mov    0x8(%rbx),%rsi
    733e:	e8 5d fe ff ff       	call   71a0 <f22>
    7343:	48 8b 0b             	mov    (%rbx),%rcx
    7346:	48 8b 3b             	mov    (%rbx),%rdi
    7349:	48 89 f9             	mov    %rdi,%rcx
    734c:	48 2b 0d 1d 5e 00 00 	sub    0x5e1d(%rip),%rcx        # d170 <fwp_gc+0x1030>
    7353:	48 8b 15 3e 5e 00 00 	mov    0x5e3e(%rip),%rdx        # d198 <fwp_gc+0x1058>
    735a:	48 c1 e2 10          	shl    $0x10,%rdx
    735e:	48 39 d1             	cmp    %rdx,%rcx
    7361:	73 7f                	jae    73e2 <fwp_owned_entry22+0xb2>
    7363:	48 8b 15 4e 5e 00 00 	mov    0x5e4e(%rip),%rdx        # d1b8 <fwp_gc+0x1078>
    736a:	48 89 ce             	mov    %rcx,%rsi
    736d:	48 c1 ee 10          	shr    $0x10,%rsi
    7371:	48 69 f6 28 12 00 00 	imul   $0x1228,%rsi,%rsi
    7378:	44 0f b6 04 32       	movzbl (%rdx,%rsi,1),%r8d
    737d:	48 81 e1 ff ff 00 00 	and    $0xffff,%rcx
    7384:	75 13                	jne    7399 <fwp_owned_entry22+0x69>
    7386:	41 80 f8 02          	cmp    $0x2,%r8b
    738a:	75 0d                	jne    7399 <fwp_owned_entry22+0x69>
    738c:	48 8d 0c 32          	lea    (%rdx,%rsi,1),%rcx
    7390:	48 81 c1 28 02 00 00 	add    $0x228,%rcx
    7397:	eb 20                	jmp    73b9 <fwp_owned_entry22+0x89>
    7399:	41 80 f8 01          	cmp    $0x1,%r8b
    739d:	75 43                	jne    73e2 <fwp_owned_entry22+0xb2>
    739f:	4c 8d 04 32          	lea    (%rdx,%rsi,1),%r8
    73a3:	8b 54 32 20          	mov    0x20(%rdx,%rsi,1),%edx
    73a7:	48 0f af ca          	imul   %rdx,%rcx
    73ab:	48 c1 e9 20          	shr    $0x20,%rcx
    73af:	4c 01 c1             	add    %r8,%rcx
    73b2:	48 81 c1 28 02 00 00 	add    $0x228,%rcx
    73b9:	0f b6 11             	movzbl (%rcx),%edx
    73bc:	85 d2                	test   %edx,%edx
    73be:	74 22                	je     73e2 <fwp_owned_entry22+0xb2>
    73c0:	83 fa 01             	cmp    $0x1,%edx
    73c3:	75 0d                	jne    73d2 <fwp_owned_entry22+0xa2>
    73c5:	49 89 c6             	mov    %rax,%r14
    73c8:	e8 c3 f3 ff ff       	call   6790 <fwp_rc_free_obj>
    73cd:	4c 89 f0             	mov    %r14,%rax
    73d0:	eb 10                	jmp    73e2 <fwp_owned_entry22+0xb2>
    73d2:	81 fa ff 00 00 00    	cmp    $0xff,%edx
    73d8:	0f 84 a9 00 00 00    	je     7487 <fwp_owned_entry22+0x157>
    73de:	fe ca                	dec    %dl
    73e0:	88 11                	mov    %dl,(%rcx)
    73e2:	48 8b 4b 08          	mov    0x8(%rbx),%rcx
    73e6:	48 8b 7b 08          	mov    0x8(%rbx),%rdi
    73ea:	48 89 f9             	mov    %rdi,%rcx
    73ed:	48 2b 0d 7c 5d 00 00 	sub    0x5d7c(%rip),%rcx        # d170 <fwp_gc+0x1030>
    73f4:	48 8b 15 9d 5d 00 00 	mov    0x5d9d(%rip),%rdx        # d198 <fwp_gc+0x1058>
    73fb:	48 c1 e2 10          	shl    $0x10,%rdx
    73ff:	48 39 d1             	cmp    %rdx,%rcx
    7402:	73 7b                	jae    747f <fwp_owned_entry22+0x14f>
    7404:	48 8b 15 ad 5d 00 00 	mov    0x5dad(%rip),%rdx        # d1b8 <fwp_gc+0x1078>
    740b:	48 89 ce             	mov    %rcx,%rsi
    740e:	48 c1 ee 10          	shr    $0x10,%rsi
    7412:	48 69 f6 28 12 00 00 	imul   $0x1228,%rsi,%rsi
    7419:	44 0f b6 04 32       	movzbl (%rdx,%rsi,1),%r8d
    741e:	48 81 e1 ff ff 00 00 	and    $0xffff,%rcx
    7425:	75 13                	jne    743a <fwp_owned_entry22+0x10a>
    7427:	41 80 f8 02          	cmp    $0x2,%r8b
    742b:	75 0d                	jne    743a <fwp_owned_entry22+0x10a>
    742d:	48 8d 0c 32          	lea    (%rdx,%rsi,1),%rcx
    7431:	48 81 c1 28 02 00 00 	add    $0x228,%rcx
    7438:	eb 20                	jmp    745a <fwp_owned_entry22+0x12a>
    743a:	41 80 f8 01          	cmp    $0x1,%r8b
    743e:	75 3f                	jne    747f <fwp_owned_entry22+0x14f>
    7440:	4c 8d 04 32          	lea    (%rdx,%rsi,1),%r8
    7444:	8b 54 32 20          	mov    0x20(%rdx,%rsi,1),%edx
    7448:	48 0f af ca          	imul   %rdx,%rcx
    744c:	48 c1 e9 20          	shr    $0x20,%rcx
    7450:	4c 01 c1             	add    %r8,%rcx
    7453:	48 81 c1 28 02 00 00 	add    $0x228,%rcx
    745a:	0f b6 11             	movzbl (%rcx),%edx
    745d:	85 d2                	test   %edx,%edx
    745f:	74 1e                	je     747f <fwp_owned_entry22+0x14f>
    7461:	83 fa 01             	cmp    $0x1,%edx
    7464:	75 0d                	jne    7473 <fwp_owned_entry22+0x143>
    7466:	48 89 c3             	mov    %rax,%rbx
    7469:	e8 22 f3 ff ff       	call   6790 <fwp_rc_free_obj>
    746e:	48 89 d8             	mov    %rbx,%rax
    7471:	eb 0c                	jmp    747f <fwp_owned_entry22+0x14f>
    7473:	81 fa ff 00 00 00    	cmp    $0xff,%edx
    7479:	74 1c                	je     7497 <fwp_owned_entry22+0x167>
    747b:	fe ca                	dec    %dl
    747d:	88 11                	mov    %dl,(%rcx)
    747f:	48 83 c4 08          	add    $0x8,%rsp
    7483:	5b                   	pop    %rbx
    7484:	41 5e                	pop    %r14
    7486:	c3                   	ret
    7487:	48 89 cf             	mov    %rcx,%rdi
    748a:	49 89 c6             	mov    %rax,%r14
    748d:	e8 1e f0 ff ff       	call   64b0 <fwp_rc_wide_drop>
    7492:	e9 36 ff ff ff       	jmp    73cd <fwp_owned_entry22+0x9d>
    7497:	48 89 cf             	mov    %rcx,%rdi
    749a:	48 89 c3             	mov    %rax,%rbx
    749d:	e8 0e f0 ff ff       	call   64b0 <fwp_rc_wide_drop>
    74a2:	eb ca                	jmp    746e <fwp_owned_entry22+0x13e>
    74a4:	66 66 66 2e 0f 1f 84 	data16 data16 cs nopw 0x0(%rax,%rax,1)
    74ab:	00 00 00 00 00 

00000000000074b0 <fwp_caps22>:
    74b0:	55                   	push   %rbp
    74b1:	53                   	push   %rbx
    74b2:	50                   	push   %rax
    74b3:	83 7f 04 00          	cmpl   $0x0,0x4(%rdi)
    74b7:	0f 84 4b 02 00 00    	je     7708 <fwp_caps22+0x258>
    74bd:	48 8b 47 08          	mov    0x8(%rdi),%rax
    74c1:	48 89 c1             	mov    %rax,%rcx
    74c4:	48 2b 0d a5 5c 00 00 	sub    0x5ca5(%rip),%rcx        # d170 <fwp_gc+0x1030>
    74cb:	48 8b 15 c6 5c 00 00 	mov    0x5cc6(%rip),%rdx        # d198 <fwp_gc+0x1058>
    74d2:	48 c1 e2 10          	shl    $0x10,%rdx
    74d6:	85 f6                	test   %esi,%esi
    74d8:	74 3d                	je     7517 <fwp_caps22+0x67>
    74da:	48 39 d1             	cmp    %rdx,%rcx
    74dd:	0f 83 f5 00 00 00    	jae    75d8 <fwp_caps22+0x128>
    74e3:	48 8b 05 ce 5c 00 00 	mov    0x5cce(%rip),%rax        # d1b8 <fwp_gc+0x1078>
    74ea:	48 89 ca             	mov    %rcx,%rdx
    74ed:	48 c1 ea 10          	shr    $0x10,%rdx
    74f1:	48 69 d2 28 12 00 00 	imul   $0x1228,%rdx,%rdx
    74f8:	44 0f b6 04 10       	movzbl (%rax,%rdx,1),%r8d
    74fd:	48 81 e1 ff ff 00 00 	and    $0xffff,%rcx
    7504:	75 50                	jne    7556 <fwp_caps22+0xa6>
    7506:	41 80 f8 02          	cmp    $0x2,%r8b
    750a:	75 4a                	jne    7556 <fwp_caps22+0xa6>
    750c:	48 01 d0             	add    %rdx,%rax
    750f:	48 05 28 02 00 00    	add    $0x228,%rax
    7515:	eb 5f                	jmp    7576 <fwp_caps22+0xc6>
    7517:	48 39 d1             	cmp    %rdx,%rcx
    751a:	0f 83 b8 00 00 00    	jae    75d8 <fwp_caps22+0x128>
    7520:	48 8b 15 91 5c 00 00 	mov    0x5c91(%rip),%rdx        # d1b8 <fwp_gc+0x1078>
    7527:	49 89 c8             	mov    %rcx,%r8
    752a:	49 c1 e8 10          	shr    $0x10,%r8
    752e:	4d 69 c0 28 12 00 00 	imul   $0x1228,%r8,%r8
    7535:	46 0f b6 0c 02       	movzbl (%rdx,%r8,1),%r9d
    753a:	48 81 e1 ff ff 00 00 	and    $0xffff,%rcx
    7541:	75 52                	jne    7595 <fwp_caps22+0xe5>
    7543:	41 80 f9 02          	cmp    $0x2,%r9b
    7547:	75 4c                	jne    7595 <fwp_caps22+0xe5>
    7549:	4a 8d 0c 02          	lea    (%rdx,%r8,1),%rcx
    754d:	48 81 c1 28 02 00 00 	add    $0x228,%rcx
    7554:	eb 60                	jmp    75b6 <fwp_caps22+0x106>
    7556:	41 80 f8 01          	cmp    $0x1,%r8b
    755a:	75 7c                	jne    75d8 <fwp_caps22+0x128>
    755c:	4c 8d 04 10          	lea    (%rax,%rdx,1),%r8
    7560:	8b 44 10 20          	mov    0x20(%rax,%rdx,1),%eax
    7564:	48 0f af c8          	imul   %rax,%rcx
    7568:	48 c1 e9 20          	shr    $0x20,%rcx
    756c:	4a 8d 04 01          	lea    (%rcx,%r8,1),%rax
    7570:	48 05 28 02 00 00    	add    $0x228,%rax
    7576:	0f b6 08             	movzbl (%rax),%ecx
    7579:	84 c9                	test   %cl,%cl
    757b:	74 5b                	je     75d8 <fwp_caps22+0x128>
    757d:	80 f9 fe             	cmp    $0xfe,%cl
    7580:	0f 83 a4 01 00 00    	jae    772a <fwp_caps22+0x27a>
    7586:	fe c1                	inc    %cl
    7588:	88 08                	mov    %cl,(%rax)
    758a:	83 7f 04 02          	cmpl   $0x2,0x4(%rdi)
    758e:	73 52                	jae    75e2 <fwp_caps22+0x132>
    7590:	e9 73 01 00 00       	jmp    7708 <fwp_caps22+0x258>
    7595:	41 80 f9 01          	cmp    $0x1,%r9b
    7599:	75 3d                	jne    75d8 <fwp_caps22+0x128>
    759b:	4e 8d 0c 02          	lea    (%rdx,%r8,1),%r9
    759f:	42 8b 54 02 20       	mov    0x20(%rdx,%r8,1),%edx
    75a4:	48 0f af ca          	imul   %rdx,%rcx
    75a8:	48 c1 e9 20          	shr    $0x20,%rcx
    75ac:	4c 01 c9             	add    %r9,%rcx
    75af:	48 81 c1 28 02 00 00 	add    $0x228,%rcx
    75b6:	0f b6 11             	movzbl (%rcx),%edx
    75b9:	85 d2                	test   %edx,%edx
    75bb:	74 1b                	je     75d8 <fwp_caps22+0x128>
    75bd:	83 fa 01             	cmp    $0x1,%edx
    75c0:	0f 85 2c 01 00 00    	jne    76f2 <fwp_caps22+0x242>
    75c6:	48 89 fb             	mov    %rdi,%rbx
    75c9:	48 89 c7             	mov    %rax,%rdi
    75cc:	89 f5                	mov    %esi,%ebp
    75ce:	e8 bd f1 ff ff       	call   6790 <fwp_rc_free_obj>
    75d3:	89 ee                	mov    %ebp,%esi
    75d5:	48 89 df             	mov    %rbx,%rdi
    75d8:	83 7f 04 02          	cmpl   $0x2,0x4(%rdi)
    75dc:	0f 82 26 01 00 00    	jb     7708 <fwp_caps22+0x258>
    75e2:	48 8b 47 10          	mov    0x10(%rdi),%rax
    75e6:	48 89 c1             	mov    %rax,%rcx
    75e9:	48 2b 0d 80 5b 00 00 	sub    0x5b80(%rip),%rcx        # d170 <fwp_gc+0x1030>
    75f0:	48 8b 15 a1 5b 00 00 	mov    0x5ba1(%rip),%rdx        # d198 <fwp_gc+0x1058>
    75f7:	48 c1 e2 10          	shl    $0x10,%rdx
    75fb:	85 f6                	test   %esi,%esi
    75fd:	74 3e                	je     763d <fwp_caps22+0x18d>
    75ff:	48 39 d1             	cmp    %rdx,%rcx
    7602:	0f 83 04 01 00 00    	jae    770c <fwp_caps22+0x25c>
    7608:	48 8b 05 a9 5b 00 00 	mov    0x5ba9(%rip),%rax        # d1b8 <fwp_gc+0x1078>
    760f:	48 89 ca             	mov    %rcx,%rdx
    7612:	48 c1 ea 10          	shr    $0x10,%rdx
    7616:	48 69 d2 28 12 00 00 	imul   $0x1228,%rdx,%rdx
    761d:	0f b6 34 10          	movzbl (%rax,%rdx,1),%esi
    7621:	48 81 e1 ff ff 00 00 	and    $0xffff,%rcx
    7628:	75 52                	jne    767c <fwp_caps22+0x1cc>
    762a:	40 80 fe 02          	cmp    $0x2,%sil
    762e:	75 4c                	jne    767c <fwp_caps22+0x1cc>
    7630:	48 8d 3c 10          	lea    (%rax,%rdx,1),%rdi
    7634:	48 81 c7 28 02 00 00 	add    $0x228,%rdi
    763b:	eb 64                	jmp    76a1 <fwp_caps22+0x1f1>
    763d:	48 39 d1             	cmp    %rdx,%rcx
    7640:	0f 83 d9 00 00 00    	jae    771f <fwp_caps22+0x26f>
    7646:	48 8b 15 6b 5b 00 00 	mov    0x5b6b(%rip),%rdx        # d1b8 <fwp_gc+0x1078>
    764d:	48 89 ce             	mov    %rcx,%rsi
    7650:	48 c1 ee 10          	shr    $0x10,%rsi
    7654:	48 69 f6 28 12 00 00 	imul   $0x1228,%rsi,%rsi
    765b:	44 0f b6 04 32       	movzbl (%rdx,%rsi,1),%r8d
    7660:	48 81 e1 ff ff 00 00 	and    $0xffff,%rcx
    7667:	75 4d                	jne    76b6 <fwp_caps22+0x206>
    7669:	41 80 f8 02          	cmp    $0x2,%r8b
    766d:	75 47                	jne    76b6 <fwp_caps22+0x206>
    766f:	48 8d 0c 32          	lea    (%rdx,%rsi,1),%rcx
    7673:	48 81 c1 28 02 00 00 	add    $0x228,%rcx
    767a:	eb 5a                	jmp    76d6 <fwp_caps22+0x226>
    767c:	40 80 fe 01          	cmp    $0x1,%sil
    7680:	0f 85 86 00 00 00    	jne    770c <fwp_caps22+0x25c>
    7686:	48 8d 34 10          	lea    (%rax,%rdx,1),%rsi
    768a:	8b 44 10 20          	mov    0x20(%rax,%rdx,1),%eax
    768e:	48 0f af c8          	imul   %rax,%rcx
    7692:	48 c1 e9 20          	shr    $0x20,%rcx
    7696:	48 8d 3c 31          	lea    (%rcx,%rsi,1),%rdi
    769a:	48 81 c7 28 02 00 00 	add    $0x228,%rdi
    76a1:	0f b6 07             	movzbl (%rdi),%eax
    76a4:	84 c0                	test   %al,%al
    76a6:	74 64                	je     770c <fwp_caps22+0x25c>
    76a8:	3c fe                	cmp    $0xfe,%al
    76aa:	0f 83 8c 00 00 00    	jae    773c <fwp_caps22+0x28c>
    76b0:	fe c0                	inc    %al
    76b2:	88 07                	mov    %al,(%rdi)
    76b4:	eb 56                	jmp    770c <fwp_caps22+0x25c>
    76b6:	41 80 f8 01          	cmp    $0x1,%r8b
    76ba:	75 63                	jne    771f <fwp_caps22+0x26f>
    76bc:	4c 8d 04 32          	lea    (%rdx,%rsi,1),%r8
    76c0:	8b 54 32 20          	mov    0x20(%rdx,%rsi,1),%edx
    76c4:	48 0f af ca          	imul   %rdx,%rcx
    76c8:	48 c1 e9 20          	shr    $0x20,%rcx
    76cc:	4c 01 c1             	add    %r8,%rcx
    76cf:	48 81 c1 28 02 00 00 	add    $0x228,%rcx
    76d6:	0f b6 11             	movzbl (%rcx),%edx
    76d9:	85 d2                	test   %edx,%edx
    76db:	74 42                	je     771f <fwp_caps22+0x26f>
    76dd:	83 fa 01             	cmp    $0x1,%edx
    76e0:	75 31                	jne    7713 <fwp_caps22+0x263>
    76e2:	48 89 fb             	mov    %rdi,%rbx
    76e5:	48 89 c7             	mov    %rax,%rdi
    76e8:	e8 a3 f0 ff ff       	call   6790 <fwp_rc_free_obj>
    76ed:	48 89 df             	mov    %rbx,%rdi
    76f0:	eb 2d                	jmp    771f <fwp_caps22+0x26f>
    76f2:	81 fa ff 00 00 00    	cmp    $0xff,%edx
    76f8:	74 4d                	je     7747 <fwp_caps22+0x297>
    76fa:	fe ca                	dec    %dl
    76fc:	88 11                	mov    %dl,(%rcx)
    76fe:	83 7f 04 02          	cmpl   $0x2,0x4(%rdi)
    7702:	0f 83 da fe ff ff    	jae    75e2 <fwp_caps22+0x132>
    7708:	85 f6                	test   %esi,%esi
    770a:	74 13                	je     771f <fwp_caps22+0x26f>
    770c:	48 83 c4 08          	add    $0x8,%rsp
    7710:	5b                   	pop    %rbx
    7711:	5d                   	pop    %rbp
    7712:	c3                   	ret
    7713:	81 fa ff 00 00 00    	cmp    $0xff,%edx
    7719:	74 3e                	je     7759 <fwp_caps22+0x2a9>
    771b:	fe ca                	dec    %dl
    771d:	88 11                	mov    %dl,(%rcx)
    771f:	48 83 c4 08          	add    $0x8,%rsp
    7723:	5b                   	pop    %rbx
    7724:	5d                   	pop    %rbp
    7725:	e9 66 f0 ff ff       	jmp    6790 <fwp_rc_free_obj>
    772a:	48 89 fb             	mov    %rdi,%rbx
    772d:	48 89 c7             	mov    %rax,%rdi
    7730:	89 f5                	mov    %esi,%ebp
    7732:	e8 09 e9 ff ff       	call   6040 <fwp_rc_wide_dup>
    7737:	e9 97 fe ff ff       	jmp    75d3 <fwp_caps22+0x123>
    773c:	48 83 c4 08          	add    $0x8,%rsp
    7740:	5b                   	pop    %rbx
    7741:	5d                   	pop    %rbp
    7742:	e9 f9 e8 ff ff       	jmp    6040 <fwp_rc_wide_dup>
    7747:	48 89 fb             	mov    %rdi,%rbx
    774a:	48 89 cf             	mov    %rcx,%rdi
    774d:	89 f5                	mov    %esi,%ebp
    774f:	e8 5c ed ff ff       	call   64b0 <fwp_rc_wide_drop>
    7754:	e9 7a fe ff ff       	jmp    75d3 <fwp_caps22+0x123>
    7759:	48 89 fb             	mov    %rdi,%rbx
    775c:	48 89 cf             	mov    %rcx,%rdi
    775f:	e8 4c ed ff ff       	call   64b0 <fwp_rc_wide_drop>
    7764:	eb 87                	jmp    76ed <fwp_caps22+0x23d>
    7766:	66 2e 0f 1f 84 00 00 	cs nopw 0x0(%rax,%rax,1)
    776d:	00 00 00 

0000000000007770 <fwp_args22>:
    7770:	55                   	push   %rbp
    7771:	41 56                	push   %r14
    7773:	53                   	push   %rbx
    7774:	85 f6                	test   %esi,%esi
    7776:	75 52                	jne    77ca <fwp_args22+0x5a>
    7778:	85 d2                	test   %edx,%edx
    777a:	74 4e                	je     77ca <fwp_args22+0x5a>
    777c:	48 8b 07             	mov    (%rdi),%rax
    777f:	48 2b 05 ea 59 00 00 	sub    0x59ea(%rip),%rax        # d170 <fwp_gc+0x1030>
    7786:	48 8b 0d 0b 5a 00 00 	mov    0x5a0b(%rip),%rcx        # d198 <fwp_gc+0x1058>
    778d:	48 c1 e1 10          	shl    $0x10,%rcx
    7791:	48 39 c8             	cmp    %rcx,%rax
    7794:	73 72                	jae    7808 <fwp_args22+0x98>
    7796:	48 8b 0d 1b 5a 00 00 	mov    0x5a1b(%rip),%rcx        # d1b8 <fwp_gc+0x1078>
    779d:	49 89 c0             	mov    %rax,%r8
    77a0:	49 c1 e8 10          	shr    $0x10,%r8
    77a4:	4d 69 c0 28 12 00 00 	imul   $0x1228,%r8,%r8
    77ab:	46 0f b6 0c 01       	movzbl (%rcx,%r8,1),%r9d
    77b0:	48 25 ff ff 00 00    	and    $0xffff,%rax
    77b6:	75 1c                	jne    77d4 <fwp_args22+0x64>
    77b8:	41 80 f9 02          	cmp    $0x2,%r9b
    77bc:	75 16                	jne    77d4 <fwp_args22+0x64>
    77be:	4a 8d 04 01          	lea    (%rcx,%r8,1),%rax
    77c2:	48 05 28 02 00 00    	add    $0x228,%rax
    77c8:	eb 2a                	jmp    77f4 <fwp_args22+0x84>
    77ca:	83 fe 01             	cmp    $0x1,%esi
    77cd:	76 39                	jbe    7808 <fwp_args22+0x98>
    77cf:	e9 c0 00 00 00       	jmp    7894 <fwp_args22+0x124>
    77d4:	41 80 f9 01          	cmp    $0x1,%r9b
    77d8:	75 2e                	jne    7808 <fwp_args22+0x98>
    77da:	4e 8d 0c 01          	lea    (%rcx,%r8,1),%r9
    77de:	42 8b 4c 01 20       	mov    0x20(%rcx,%r8,1),%ecx
    77e3:	48 0f af c1          	imul   %rcx,%rax
    77e7:	48 c1 e8 20          	shr    $0x20,%rax
    77eb:	4c 01 c8             	add    %r9,%rax
    77ee:	48 05 28 02 00 00    	add    $0x228,%rax
    77f4:	0f b6 08             	movzbl (%rax),%ecx
    77f7:	84 c9                	test   %cl,%cl
    77f9:	74 0d                	je     7808 <fwp_args22+0x98>
    77fb:	80 f9 fe             	cmp    $0xfe,%cl
    77fe:	0f 83 95 00 00 00    	jae    7899 <fwp_args22+0x129>
    7804:	fe c1                	inc    %cl
    7806:	88 08                	mov    %cl,(%rax)
    7808:	83 f6 01             	xor    $0x1,%esi
    780b:	39 d6                	cmp    %edx,%esi
    780d:	0f 83 81 00 00 00    	jae    7894 <fwp_args22+0x124>
    7813:	89 f0                	mov    %esi,%eax
    7815:	48 8b 04 c7          	mov    (%rdi,%rax,8),%rax
    7819:	48 2b 05 50 59 00 00 	sub    0x5950(%rip),%rax        # d170 <fwp_gc+0x1030>
    7820:	48 8b 0d 71 59 00 00 	mov    0x5971(%rip),%rcx        # d198 <fwp_gc+0x1058>
    7827:	48 c1 e1 10          	shl    $0x10,%rcx
    782b:	48 39 c8             	cmp    %rcx,%rax
    782e:	73 64                	jae    7894 <fwp_args22+0x124>
    7830:	48 8b 0d 81 59 00 00 	mov    0x5981(%rip),%rcx        # d1b8 <fwp_gc+0x1078>
    7837:	48 89 c2             	mov    %rax,%rdx
    783a:	48 c1 ea 10          	shr    $0x10,%rdx
    783e:	48 69 d2 28 12 00 00 	imul   $0x1228,%rdx,%rdx
    7845:	0f b6 34 11          	movzbl (%rcx,%rdx,1),%esi
    7849:	48 25 ff ff 00 00    	and    $0xffff,%rax
    784f:	75 13                	jne    7864 <fwp_args22+0xf4>
    7851:	40 80 fe 02          	cmp    $0x2,%sil
    7855:	75 0d                	jne    7864 <fwp_args22+0xf4>
    7857:	48 8d 3c 11          	lea    (%rcx,%rdx,1),%rdi
    785b:	48 81 c7 28 02 00 00 	add    $0x228,%rdi
    7862:	eb 21                	jmp    7885 <fwp_args22+0x115>
    7864:	40 80 fe 01          	cmp    $0x1,%sil
    7868:	75 2a                	jne    7894 <fwp_args22+0x124>
    786a:	48 8d 34 11          	lea    (%rcx,%rdx,1),%rsi
    786e:	8b 4c 11 20          	mov    0x20(%rcx,%rdx,1),%ecx
    7872:	48 0f af c1          	imul   %rcx,%rax
    7876:	48 c1 e8 20          	shr    $0x20,%rax
    787a:	48 8d 3c 30          	lea    (%rax,%rsi,1),%rdi
    787e:	48 81 c7 28 02 00 00 	add    $0x228,%rdi
    7885:	0f b6 07             	movzbl (%rdi),%eax
    7888:	84 c0                	test   %al,%al
    788a:	74 08                	je     7894 <fwp_args22+0x124>
    788c:	3c fe                	cmp    $0xfe,%al
    788e:	73 26                	jae    78b6 <fwp_args22+0x146>
    7890:	fe c0                	inc    %al
    7892:	88 07                	mov    %al,(%rdi)
    7894:	5b                   	pop    %rbx
    7895:	41 5e                	pop    %r14
    7897:	5d                   	pop    %rbp
    7898:	c3                   	ret
    7899:	48 89 fb             	mov    %rdi,%rbx
    789c:	48 89 c7             	mov    %rax,%rdi
    789f:	89 f5                	mov    %esi,%ebp
    78a1:	41 89 d6             	mov    %edx,%r14d
    78a4:	e8 97 e7 ff ff       	call   6040 <fwp_rc_wide_dup>
    78a9:	44 89 f2             	mov    %r14d,%edx
    78ac:	89 ee                	mov    %ebp,%esi
    78ae:	48 89 df             	mov    %rbx,%rdi
    78b1:	e9 52 ff ff ff       	jmp    7808 <fwp_args22+0x98>
    78b6:	5b                   	pop    %rbx
    78b7:	41 5e                	pop    %r14
    78b9:	5d                   	pop    %rbp
    78ba:	e9 81 e7 ff ff       	jmp    6040 <fwp_rc_wide_dup>
    78bf:	90                   	nop

00000000000078c0 <fwp_arg_drop22>:
    78c0:	55                   	push   %rbp
    78c1:	41 56                	push   %r14
    78c3:	53                   	push   %rbx
    78c4:	85 f6                	test   %esi,%esi
    78c6:	75 5b                	jne    7923 <fwp_arg_drop22+0x63>
    78c8:	85 d2                	test   %edx,%edx
    78ca:	74 57                	je     7923 <fwp_arg_drop22+0x63>
    78cc:	48 8b 07             	mov    (%rdi),%rax
    78cf:	48 89 c1             	mov    %rax,%rcx
    78d2:	48 2b 0d 97 58 00 00 	sub    0x5897(%rip),%rcx        # d170 <fwp_gc+0x1030>
    78d9:	4c 8b 05 b8 58 00 00 	mov    0x58b8(%rip),%r8        # d198 <fwp_gc+0x1058>
    78e0:	49 c1 e0 10          	shl    $0x10,%r8
    78e4:	4c 39 c1             	cmp    %r8,%rcx
    78e7:	0f 83 9d 00 00 00    	jae    798a <fwp_arg_drop22+0xca>
    78ed:	4c 8b 05 c4 58 00 00 	mov    0x58c4(%rip),%r8        # d1b8 <fwp_gc+0x1078>
    78f4:	49 89 c9             	mov    %rcx,%r9
    78f7:	49 c1 e9 10          	shr    $0x10,%r9
    78fb:	4d 69 c9 28 12 00 00 	imul   $0x1228,%r9,%r9
    7902:	47 0f b6 14 08       	movzbl (%r8,%r9,1),%r10d
    7907:	48 81 e1 ff ff 00 00 	and    $0xffff,%rcx
    790e:	75 1d                	jne    792d <fwp_arg_drop22+0x6d>
    7910:	41 80 fa 02          	cmp    $0x2,%r10b
    7914:	75 17                	jne    792d <fwp_arg_drop22+0x6d>
    7916:	4b 8d 0c 08          	lea    (%r8,%r9,1),%rcx
    791a:	48 81 c1 28 02 00 00 	add    $0x228,%rcx
    7921:	eb 2b                	jmp    794e <fwp_arg_drop22+0x8e>
    7923:	83 fe 01             	cmp    $0x1,%esi
    7926:	76 62                	jbe    798a <fwp_arg_drop22+0xca>
    7928:	e9 fb 00 00 00       	jmp    7a28 <fwp_arg_drop22+0x168>
    792d:	41 80 fa 01          	cmp    $0x1,%r10b
    7931:	75 57                	jne    798a <fwp_arg_drop22+0xca>
    7933:	4f 8d 14 08          	lea    (%r8,%r9,1),%r10
    7937:	47 8b 44 08 20       	mov    0x20(%r8,%r9,1),%r8d
    793c:	49 0f af c8          	imul   %r8,%rcx
    7940:	48 c1 e9 20          	shr    $0x20,%rcx
    7944:	4c 01 d1             	add    %r10,%rcx
    7947:	48 81 c1 28 02 00 00 	add    $0x228,%rcx
    794e:	44 0f b6 01          	movzbl (%rcx),%r8d
    7952:	45 85 c0             	test   %r8d,%r8d
    7955:	74 33                	je     798a <fwp_arg_drop22+0xca>
    7957:	41 83 f8 01          	cmp    $0x1,%r8d
    795b:	75 1a                	jne    7977 <fwp_arg_drop22+0xb7>
    795d:	48 89 fb             	mov    %rdi,%rbx
    7960:	48 89 c7             	mov    %rax,%rdi
    7963:	89 f5                	mov    %esi,%ebp
    7965:	41 89 d6             	mov    %edx,%r14d
    7968:	e8 23 ee ff ff       	call   6790 <fwp_rc_free_obj>
    796d:	44 89 f2             	mov    %r14d,%edx
    7970:	89 ee                	mov    %ebp,%esi
    7972:	48 89 df             	mov    %rbx,%rdi
    7975:	eb 13                	jmp    798a <fwp_arg_drop22+0xca>
    7977:	41 81 f8 ff 00 00 00 	cmp    $0xff,%r8d
    797e:	0f 84 a9 00 00 00    	je     7a2d <fwp_arg_drop22+0x16d>
    7984:	41 fe c8             	dec    %r8b
    7987:	44 88 01             	mov    %r8b,(%rcx)
    798a:	83 f6 01             	xor    $0x1,%esi
    798d:	39 d6                	cmp    %edx,%esi
    798f:	0f 83 93 00 00 00    	jae    7a28 <fwp_arg_drop22+0x168>
    7995:	89 f0                	mov    %esi,%eax
    7997:	48 8b 3c c7          	mov    (%rdi,%rax,8),%rdi
    799b:	48 89 f8             	mov    %rdi,%rax
    799e:	48 2b 05 cb 57 00 00 	sub    0x57cb(%rip),%rax        # d170 <fwp_gc+0x1030>
    79a5:	48 8b 0d ec 57 00 00 	mov    0x57ec(%rip),%rcx        # d198 <fwp_gc+0x1058>
    79ac:	48 c1 e1 10          	shl    $0x10,%rcx
    79b0:	48 39 c8             	cmp    %rcx,%rax
    79b3:	73 73                	jae    7a28 <fwp_arg_drop22+0x168>
    79b5:	48 8b 0d fc 57 00 00 	mov    0x57fc(%rip),%rcx        # d1b8 <fwp_gc+0x1078>
    79bc:	48 89 c2             	mov    %rax,%rdx
    79bf:	48 c1 ea 10          	shr    $0x10,%rdx
    79c3:	48 69 d2 28 12 00 00 	imul   $0x1228,%rdx,%rdx
    79ca:	0f b6 34 11          	movzbl (%rcx,%rdx,1),%esi
    79ce:	48 25 ff ff 00 00    	and    $0xffff,%rax
    79d4:	75 12                	jne    79e8 <fwp_arg_drop22+0x128>
    79d6:	40 80 fe 02          	cmp    $0x2,%sil
    79da:	75 0c                	jne    79e8 <fwp_arg_drop22+0x128>
    79dc:	48 8d 04 11          	lea    (%rcx,%rdx,1),%rax
    79e0:	48 05 28 02 00 00    	add    $0x228,%rax
    79e6:	eb 1f                	jmp    7a07 <fwp_arg_drop22+0x147>
    79e8:	40 80 fe 01          	cmp    $0x1,%sil
    79ec:	75 3a                	jne    7a28 <fwp_arg_drop22+0x168>
    79ee:	48 8d 34 11          	lea    (%rcx,%rdx,1),%rsi
    79f2:	8b 4c 11 20          	mov    0x20(%rcx,%rdx,1),%ecx
    79f6:	48 0f af c1          	imul   %rcx,%rax
    79fa:	48 c1 e8 20          	shr    $0x20,%rax
    79fe:	48 01 f0             	add    %rsi,%rax
    7a01:	48 05 28 02 00 00    	add    $0x228,%rax
    7a07:	0f b6 08             	movzbl (%rax),%ecx
    7a0a:	85 c9                	test   %ecx,%ecx
    7a0c:	74 1a                	je     7a28 <fwp_arg_drop22+0x168>
    7a0e:	83 f9 01             	cmp    $0x1,%ecx
    7a11:	75 09                	jne    7a1c <fwp_arg_drop22+0x15c>
    7a13:	5b                   	pop    %rbx
    7a14:	41 5e                	pop    %r14
    7a16:	5d                   	pop    %rbp
    7a17:	e9 74 ed ff ff       	jmp    6790 <fwp_rc_free_obj>
    7a1c:	81 f9 ff 00 00 00    	cmp    $0xff,%ecx
    7a22:	74 1e                	je     7a42 <fwp_arg_drop22+0x182>
    7a24:	fe c9                	dec    %cl
    7a26:	88 08                	mov    %cl,(%rax)
    7a28:	5b                   	pop    %rbx
    7a29:	41 5e                	pop    %r14
    7a2b:	5d                   	pop    %rbp
    7a2c:	c3                   	ret
    7a2d:	48 89 fb             	mov    %rdi,%rbx
    7a30:	48 89 cf             	mov    %rcx,%rdi
    7a33:	89 f5                	mov    %esi,%ebp
    7a35:	41 89 d6             	mov    %edx,%r14d
    7a38:	e8 73 ea ff ff       	call   64b0 <fwp_rc_wide_drop>
    7a3d:	e9 2b ff ff ff       	jmp    796d <fwp_arg_drop22+0xad>
    7a42:	48 89 c7             	mov    %rax,%rdi
    7a45:	5b                   	pop    %rbx
    7a46:	41 5e                	pop    %r14
    7a48:	5d                   	pop    %rbp
    7a49:	e9 62 ea ff ff       	jmp    64b0 <fwp_rc_wide_drop>
    7a4e:	66 90                	xchg   %ax,%ax

0000000000007a50 <fwp_owned_entry24>:
    7a50:	48 83 ec 18          	sub    $0x18,%rsp
    7a54:	48 8b 07             	mov    (%rdi),%rax
    7a57:	f3 0f 6f 47 08       	movdqu 0x8(%rdi),%xmm0
    7a5c:	66 0f 70 c0 4e       	pshufd $0x4e,%xmm0,%xmm0
    7a61:	66 0f 7f 04 24       	movdqa %xmm0,(%rsp)
    7a66:	48 89 e2             	mov    %rsp,%rdx
    7a69:	48 89 c7             	mov    %rax,%rdi
    7a6c:	be 02 00 00 00       	mov    $0x2,%esi
    7a71:	e8 5a dd ff ff       	call   57d0 <fwp_apply_owned>
    7a76:	48 83 c4 18          	add    $0x18,%rsp
    7a7a:	c3                   	ret
    7a7b:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)

0000000000007a80 <fwp_caps24>:
    7a80:	55                   	push   %rbp
    7a81:	53                   	push   %rbx
    7a82:	50                   	push   %rax
    7a83:	83 7f 04 00          	cmpl   $0x0,0x4(%rdi)
    7a87:	0f 84 4f 02 00 00    	je     7cdc <fwp_caps24+0x25c>
    7a8d:	48 8b 47 08          	mov    0x8(%rdi),%rax
    7a91:	85 f6                	test   %esi,%esi
    7a93:	74 5a                	je     7aef <fwp_caps24+0x6f>
    7a95:	48 2b 05 d4 56 00 00 	sub    0x56d4(%rip),%rax        # d170 <fwp_gc+0x1030>
    7a9c:	48 8b 0d f5 56 00 00 	mov    0x56f5(%rip),%rcx        # d198 <fwp_gc+0x1058>
    7aa3:	48 c1 e1 10          	shl    $0x10,%rcx
    7aa7:	48 39 c8             	cmp    %rcx,%rax
    7aaa:	0f 83 f1 00 00 00    	jae    7ba1 <fwp_caps24+0x121>
    7ab0:	48 8b 0d 01 57 00 00 	mov    0x5701(%rip),%rcx        # d1b8 <fwp_gc+0x1078>
    7ab7:	48 89 c2             	mov    %rax,%rdx
    7aba:	48 c1 ea 10          	shr    $0x10,%rdx
    7abe:	48 69 d2 28 12 00 00 	imul   $0x1228,%rdx,%rdx
    7ac5:	44 0f b6 04 11       	movzbl (%rcx,%rdx,1),%r8d
    7aca:	48 25 ff ff 00 00    	and    $0xffff,%rax
    7ad0:	0f 85 98 00 00 00    	jne    7b6e <fwp_caps24+0xee>
    7ad6:	41 80 f8 02          	cmp    $0x2,%r8b
    7ada:	0f 85 8e 00 00 00    	jne    7b6e <fwp_caps24+0xee>
    7ae0:	48 8d 04 11          	lea    (%rcx,%rdx,1),%rax
    7ae4:	48 05 28 02 00 00    	add    $0x228,%rax
    7aea:	e9 9e 00 00 00       	jmp    7b8d <fwp_caps24+0x10d>
    7aef:	48 89 fb             	mov    %rdi,%rbx
    7af2:	48 89 c7             	mov    %rax,%rdi
    7af5:	89 f5                	mov    %esi,%ebp
    7af7:	e8 a4 e6 ff ff       	call   61a0 <fwp_closure_drop>
    7afc:	48 89 df             	mov    %rbx,%rdi
    7aff:	83 7b 04 01          	cmpl   $0x1,0x4(%rbx)
    7b03:	0f 86 9f 02 00 00    	jbe    7da8 <fwp_caps24+0x328>
    7b09:	89 ee                	mov    %ebp,%esi
    7b0b:	48 8b 47 10          	mov    0x10(%rdi),%rax
    7b0f:	48 89 c1             	mov    %rax,%rcx
    7b12:	48 2b 0d 57 56 00 00 	sub    0x5657(%rip),%rcx        # d170 <fwp_gc+0x1030>
    7b19:	48 8b 15 78 56 00 00 	mov    0x5678(%rip),%rdx        # d198 <fwp_gc+0x1058>
    7b20:	48 c1 e2 10          	shl    $0x10,%rdx
    7b24:	48 39 d1             	cmp    %rdx,%rcx
    7b27:	0f 83 52 01 00 00    	jae    7c7f <fwp_caps24+0x1ff>
    7b2d:	48 8b 15 84 56 00 00 	mov    0x5684(%rip),%rdx        # d1b8 <fwp_gc+0x1078>
    7b34:	49 89 c8             	mov    %rcx,%r8
    7b37:	49 c1 e8 10          	shr    $0x10,%r8
    7b3b:	4d 69 c0 28 12 00 00 	imul   $0x1228,%r8,%r8
    7b42:	46 0f b6 0c 02       	movzbl (%rdx,%r8,1),%r9d
    7b47:	48 81 e1 ff ff 00 00 	and    $0xffff,%rcx
    7b4e:	0f 85 df 00 00 00    	jne    7c33 <fwp_caps24+0x1b3>
    7b54:	41 80 f9 02          	cmp    $0x2,%r9b
    7b58:	0f 85 d5 00 00 00    	jne    7c33 <fwp_caps24+0x1b3>
    7b5e:	4a 8d 0c 02          	lea    (%rdx,%r8,1),%rcx
    7b62:	48 81 c1 28 02 00 00 	add    $0x228,%rcx
    7b69:	e9 e6 00 00 00       	jmp    7c54 <fwp_caps24+0x1d4>
    7b6e:	41 80 f8 01          	cmp    $0x1,%r8b
    7b72:	75 2d                	jne    7ba1 <fwp_caps24+0x121>
    7b74:	4c 8d 04 11          	lea    (%rcx,%rdx,1),%r8
    7b78:	8b 4c 11 20          	mov    0x20(%rcx,%rdx,1),%ecx
    7b7c:	48 0f af c1          	imul   %rcx,%rax
    7b80:	48 c1 e8 20          	shr    $0x20,%rax
    7b84:	4c 01 c0             	add    %r8,%rax
    7b87:	48 05 28 02 00 00    	add    $0x228,%rax
    7b8d:	0f b6 08             	movzbl (%rax),%ecx
    7b90:	84 c9                	test   %cl,%cl
    7b92:	74 0d                	je     7ba1 <fwp_caps24+0x121>
    7b94:	80 f9 fe             	cmp    $0xfe,%cl
    7b97:	0f 83 16 02 00 00    	jae    7db3 <fwp_caps24+0x333>
    7b9d:	fe c1                	inc    %cl
    7b9f:	88 08                	mov    %cl,(%rax)
    7ba1:	83 7f 04 01          	cmpl   $0x1,0x4(%rdi)
    7ba5:	0f 86 39 01 00 00    	jbe    7ce4 <fwp_caps24+0x264>
    7bab:	48 8b 47 10          	mov    0x10(%rdi),%rax
    7baf:	48 2b 05 ba 55 00 00 	sub    0x55ba(%rip),%rax        # d170 <fwp_gc+0x1030>
    7bb6:	48 8b 0d db 55 00 00 	mov    0x55db(%rip),%rcx        # d198 <fwp_gc+0x1058>
    7bbd:	48 c1 e1 10          	shl    $0x10,%rcx
    7bc1:	48 39 c8             	cmp    %rcx,%rax
    7bc4:	0f 83 b5 00 00 00    	jae    7c7f <fwp_caps24+0x1ff>
    7bca:	48 8b 0d e7 55 00 00 	mov    0x55e7(%rip),%rcx        # d1b8 <fwp_gc+0x1078>
    7bd1:	48 89 c2             	mov    %rax,%rdx
    7bd4:	48 c1 ea 10          	shr    $0x10,%rdx
    7bd8:	48 69 d2 28 12 00 00 	imul   $0x1228,%rdx,%rdx
    7bdf:	44 0f b6 04 11       	movzbl (%rcx,%rdx,1),%r8d
    7be4:	48 25 ff ff 00 00    	and    $0xffff,%rax
    7bea:	75 12                	jne    7bfe <fwp_caps24+0x17e>
    7bec:	41 80 f8 02          	cmp    $0x2,%r8b
    7bf0:	75 0c                	jne    7bfe <fwp_caps24+0x17e>
    7bf2:	48 8d 04 11          	lea    (%rcx,%rdx,1),%rax
    7bf6:	48 05 28 02 00 00    	add    $0x228,%rax
    7bfc:	eb 1f                	jmp    7c1d <fwp_caps24+0x19d>
    7bfe:	41 80 f8 01          	cmp    $0x1,%r8b
    7c02:	75 7b                	jne    7c7f <fwp_caps24+0x1ff>
    7c04:	4c 8d 04 11          	lea    (%rcx,%rdx,1),%r8
    7c08:	8b 4c 11 20          	mov    0x20(%rcx,%rdx,1),%ecx
    7c0c:	48 0f af c1          	imul   %rcx,%rax
    7c10:	48 c1 e8 20          	shr    $0x20,%rax
    7c14:	4c 01 c0             	add    %r8,%rax
    7c17:	48 05 28 02 00 00    	add    $0x228,%rax
    7c1d:	0f b6 08             	movzbl (%rax),%ecx
    7c20:	84 c9                	test   %cl,%cl
    7c22:	74 5b                	je     7c7f <fwp_caps24+0x1ff>
    7c24:	80 f9 fe             	cmp    $0xfe,%cl
    7c27:	0f 83 a7 01 00 00    	jae    7dd4 <fwp_caps24+0x354>
    7c2d:	fe c1                	inc    %cl
    7c2f:	88 08                	mov    %cl,(%rax)
    7c31:	eb 4c                	jmp    7c7f <fwp_caps24+0x1ff>
    7c33:	41 80 f9 01          	cmp    $0x1,%r9b
    7c37:	75 46                	jne    7c7f <fwp_caps24+0x1ff>
    7c39:	4e 8d 0c 02          	lea    (%rdx,%r8,1),%r9
    7c3d:	42 8b 54 02 20       	mov    0x20(%rdx,%r8,1),%edx
    7c42:	48 0f af ca          	imul   %rdx,%rcx
    7c46:	48 c1 e9 20          	shr    $0x20,%rcx
    7c4a:	4c 01 c9             	add    %r9,%rcx
    7c4d:	48 81 c1 28 02 00 00 	add    $0x228,%rcx
    7c54:	0f b6 11             	movzbl (%rcx),%edx
    7c57:	85 d2                	test   %edx,%edx
    7c59:	74 24                	je     7c7f <fwp_caps24+0x1ff>
    7c5b:	83 fa 01             	cmp    $0x1,%edx
    7c5e:	75 0f                	jne    7c6f <fwp_caps24+0x1ef>
    7c60:	48 89 c7             	mov    %rax,%rdi
    7c63:	e8 28 eb ff ff       	call   6790 <fwp_rc_free_obj>
    7c68:	89 ee                	mov    %ebp,%esi
    7c6a:	48 89 df             	mov    %rbx,%rdi
    7c6d:	eb 10                	jmp    7c7f <fwp_caps24+0x1ff>
    7c6f:	81 fa ff 00 00 00    	cmp    $0xff,%edx
    7c75:	0f 84 76 01 00 00    	je     7df1 <fwp_caps24+0x371>
    7c7b:	fe ca                	dec    %dl
    7c7d:	88 11                	mov    %dl,(%rcx)
    7c7f:	83 7f 04 03          	cmpl   $0x3,0x4(%rdi)
    7c83:	72 57                	jb     7cdc <fwp_caps24+0x25c>
    7c85:	48 8b 47 18          	mov    0x18(%rdi),%rax
    7c89:	48 89 c1             	mov    %rax,%rcx
    7c8c:	48 2b 0d dd 54 00 00 	sub    0x54dd(%rip),%rcx        # d170 <fwp_gc+0x1030>
    7c93:	48 8b 15 fe 54 00 00 	mov    0x54fe(%rip),%rdx        # d198 <fwp_gc+0x1058>
    7c9a:	48 c1 e2 10          	shl    $0x10,%rdx
    7c9e:	85 f6                	test   %esi,%esi
    7ca0:	74 49                	je     7ceb <fwp_caps24+0x26b>
    7ca2:	48 39 d1             	cmp    %rdx,%rcx
    7ca5:	73 3d                	jae    7ce4 <fwp_caps24+0x264>
    7ca7:	48 8b 05 0a 55 00 00 	mov    0x550a(%rip),%rax        # d1b8 <fwp_gc+0x1078>
    7cae:	48 89 ca             	mov    %rcx,%rdx
    7cb1:	48 c1 ea 10          	shr    $0x10,%rdx
    7cb5:	48 69 d2 28 12 00 00 	imul   $0x1228,%rdx,%rdx
    7cbc:	0f b6 34 10          	movzbl (%rax,%rdx,1),%esi
    7cc0:	48 81 e1 ff ff 00 00 	and    $0xffff,%rcx
    7cc7:	75 61                	jne    7d2a <fwp_caps24+0x2aa>
    7cc9:	40 80 fe 02          	cmp    $0x2,%sil
    7ccd:	75 5b                	jne    7d2a <fwp_caps24+0x2aa>
    7ccf:	48 8d 3c 10          	lea    (%rax,%rdx,1),%rdi
    7cd3:	48 81 c7 28 02 00 00 	add    $0x228,%rdi
    7cda:	eb 6f                	jmp    7d4b <fwp_caps24+0x2cb>
    7cdc:	85 f6                	test   %esi,%esi
    7cde:	0f 84 c4 00 00 00    	je     7da8 <fwp_caps24+0x328>
    7ce4:	48 83 c4 08          	add    $0x8,%rsp
    7ce8:	5b                   	pop    %rbx
    7ce9:	5d                   	pop    %rbp
    7cea:	c3                   	ret
    7ceb:	48 39 d1             	cmp    %rdx,%rcx
    7cee:	0f 83 b4 00 00 00    	jae    7da8 <fwp_caps24+0x328>
    7cf4:	48 8b 15 bd 54 00 00 	mov    0x54bd(%rip),%rdx        # d1b8 <fwp_gc+0x1078>
    7cfb:	48 89 ce             	mov    %rcx,%rsi
    7cfe:	48 c1 ee 10          	shr    $0x10,%rsi
    7d02:	48 69 f6 28 12 00 00 	imul   $0x1228,%rsi,%rsi
    7d09:	44 0f b6 04 32       	movzbl (%rdx,%rsi,1),%r8d
    7d0e:	48 81 e1 ff ff 00 00 	and    $0xffff,%rcx
    7d15:	75 49                	jne    7d60 <fwp_caps24+0x2e0>
    7d17:	41 80 f8 02          	cmp    $0x2,%r8b
    7d1b:	75 43                	jne    7d60 <fwp_caps24+0x2e0>
    7d1d:	48 8d 0c 32          	lea    (%rdx,%rsi,1),%rcx
    7d21:	48 81 c1 28 02 00 00 	add    $0x228,%rcx
    7d28:	eb 56                	jmp    7d80 <fwp_caps24+0x300>
    7d2a:	40 80 fe 01          	cmp    $0x1,%sil
    7d2e:	75 b4                	jne    7ce4 <fwp_caps24+0x264>
    7d30:	48 8d 34 10          	lea    (%rax,%rdx,1),%rsi
    7d34:	8b 44 10 20          	mov    0x20(%rax,%rdx,1),%eax
    7d38:	48 0f af c8          	imul   %rax,%rcx
    7d3c:	48 c1 e9 20          	shr    $0x20,%rcx
    7d40:	48 8d 3c 31          	lea    (%rcx,%rsi,1),%rdi
    7d44:	48 81 c7 28 02 00 00 	add    $0x228,%rdi
    7d4b:	0f b6 07             	movzbl (%rdi),%eax
    7d4e:	84 c0                	test   %al,%al
    7d50:	74 92                	je     7ce4 <fwp_caps24+0x264>
    7d52:	3c fe                	cmp    $0xfe,%al
    7d54:	0f 83 8c 00 00 00    	jae    7de6 <fwp_caps24+0x366>
    7d5a:	fe c0                	inc    %al
    7d5c:	88 07                	mov    %al,(%rdi)
    7d5e:	eb 84                	jmp    7ce4 <fwp_caps24+0x264>
    7d60:	41 80 f8 01          	cmp    $0x1,%r8b
    7d64:	75 42                	jne    7da8 <fwp_caps24+0x328>
    7d66:	4c 8d 04 32          	lea    (%rdx,%rsi,1),%r8
    7d6a:	8b 54 32 20          	mov    0x20(%rdx,%rsi,1),%edx
    7d6e:	48 0f af ca          	imul   %rdx,%rcx
    7d72:	48 c1 e9 20          	shr    $0x20,%rcx
    7d76:	4c 01 c1             	add    %r8,%rcx
    7d79:	48 81 c1 28 02 00 00 	add    $0x228,%rcx
    7d80:	0f b6 11             	movzbl (%rcx),%edx
    7d83:	85 d2                	test   %edx,%edx
    7d85:	74 21                	je     7da8 <fwp_caps24+0x328>
    7d87:	83 fa 01             	cmp    $0x1,%edx
    7d8a:	75 10                	jne    7d9c <fwp_caps24+0x31c>
    7d8c:	48 89 fb             	mov    %rdi,%rbx
    7d8f:	48 89 c7             	mov    %rax,%rdi
    7d92:	e8 f9 e9 ff ff       	call   6790 <fwp_rc_free_obj>
    7d97:	48 89 df             	mov    %rbx,%rdi
    7d9a:	eb 0c                	jmp    7da8 <fwp_caps24+0x328>
    7d9c:	81 fa ff 00 00 00    	cmp    $0xff,%edx
    7da2:	74 5a                	je     7dfe <fwp_caps24+0x37e>
    7da4:	fe ca                	dec    %dl
    7da6:	88 11                	mov    %dl,(%rcx)
    7da8:	48 83 c4 08          	add    $0x8,%rsp
    7dac:	5b                   	pop    %rbx
    7dad:	5d                   	pop    %rbp
    7dae:	e9 dd e9 ff ff       	jmp    6790 <fwp_rc_free_obj>
    7db3:	48 89 fb             	mov    %rdi,%rbx
    7db6:	48 89 c7             	mov    %rax,%rdi
    7db9:	89 f5                	mov    %esi,%ebp
    7dbb:	e8 80 e2 ff ff       	call   6040 <fwp_rc_wide_dup>
    7dc0:	89 ee                	mov    %ebp,%esi
    7dc2:	48 89 df             	mov    %rbx,%rdi
    7dc5:	83 7f 04 01          	cmpl   $0x1,0x4(%rdi)
    7dc9:	0f 87 dc fd ff ff    	ja     7bab <fwp_caps24+0x12b>
    7dcf:	e9 10 ff ff ff       	jmp    7ce4 <fwp_caps24+0x264>
    7dd4:	48 89 fb             	mov    %rdi,%rbx
    7dd7:	48 89 c7             	mov    %rax,%rdi
    7dda:	89 f5                	mov    %esi,%ebp
    7ddc:	e8 5f e2 ff ff       	call   6040 <fwp_rc_wide_dup>
    7de1:	e9 82 fe ff ff       	jmp    7c68 <fwp_caps24+0x1e8>
    7de6:	48 83 c4 08          	add    $0x8,%rsp
    7dea:	5b                   	pop    %rbx
    7deb:	5d                   	pop    %rbp
    7dec:	e9 4f e2 ff ff       	jmp    6040 <fwp_rc_wide_dup>
    7df1:	48 89 cf             	mov    %rcx,%rdi
    7df4:	e8 b7 e6 ff ff       	call   64b0 <fwp_rc_wide_drop>
    7df9:	e9 6a fe ff ff       	jmp    7c68 <fwp_caps24+0x1e8>
    7dfe:	48 89 fb             	mov    %rdi,%rbx
    7e01:	48 89 cf             	mov    %rcx,%rdi
    7e04:	e8 a7 e6 ff ff       	call   64b0 <fwp_rc_wide_drop>
    7e09:	eb 8c                	jmp    7d97 <fwp_caps24+0x317>
    7e0b:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)

0000000000007e10 <fwp_args24>:
    7e10:	55                   	push   %rbp
    7e11:	41 56                	push   %r14
    7e13:	53                   	push   %rbx
    7e14:	85 f6                	test   %esi,%esi
    7e16:	75 52                	jne    7e6a <fwp_args24+0x5a>
    7e18:	85 d2                	test   %edx,%edx
    7e1a:	74 4e                	je     7e6a <fwp_args24+0x5a>
    7e1c:	48 8b 07             	mov    (%rdi),%rax
    7e1f:	48 2b 05 4a 53 00 00 	sub    0x534a(%rip),%rax        # d170 <fwp_gc+0x1030>
    7e26:	48 8b 0d 6b 53 00 00 	mov    0x536b(%rip),%rcx        # d198 <fwp_gc+0x1058>
    7e2d:	48 c1 e1 10          	shl    $0x10,%rcx
    7e31:	48 39 c8             	cmp    %rcx,%rax
    7e34:	73 7b                	jae    7eb1 <fwp_args24+0xa1>
    7e36:	48 8b 0d 7b 53 00 00 	mov    0x537b(%rip),%rcx        # d1b8 <fwp_gc+0x1078>
    7e3d:	49 89 c0             	mov    %rax,%r8
    7e40:	49 c1 e8 10          	shr    $0x10,%r8
    7e44:	4d 69 c0 28 12 00 00 	imul   $0x1228,%r8,%r8
    7e4b:	46 0f b6 0c 01       	movzbl (%rcx,%r8,1),%r9d
    7e50:	48 25 ff ff 00 00    	and    $0xffff,%rax
    7e56:	75 25                	jne    7e7d <fwp_args24+0x6d>
    7e58:	41 80 f9 02          	cmp    $0x2,%r9b
    7e5c:	75 1f                	jne    7e7d <fwp_args24+0x6d>
    7e5e:	4a 8d 04 01          	lea    (%rcx,%r8,1),%rax
    7e62:	48 05 28 02 00 00    	add    $0x228,%rax
    7e68:	eb 33                	jmp    7e9d <fwp_args24+0x8d>
    7e6a:	83 fe 01             	cmp    $0x1,%esi
    7e6d:	76 42                	jbe    7eb1 <fwp_args24+0xa1>
    7e6f:	83 fe 02             	cmp    $0x2,%esi
    7e72:	0f 84 cb 00 00 00    	je     7f43 <fwp_args24+0x133>
    7e78:	e9 56 01 00 00       	jmp    7fd3 <fwp_args24+0x1c3>
    7e7d:	41 80 f9 01          	cmp    $0x1,%r9b
    7e81:	75 2e                	jne    7eb1 <fwp_args24+0xa1>
    7e83:	4e 8d 0c 01          	lea    (%rcx,%r8,1),%r9
    7e87:	42 8b 4c 01 20       	mov    0x20(%rcx,%r8,1),%ecx
    7e8c:	48 0f af c1          	imul   %rcx,%rax
    7e90:	48 c1 e8 20          	shr    $0x20,%rax
    7e94:	4c 01 c8             	add    %r9,%rax
    7e97:	48 05 28 02 00 00    	add    $0x228,%rax
    7e9d:	0f b6 08             	movzbl (%rax),%ecx
    7ea0:	84 c9                	test   %cl,%cl
    7ea2:	74 0d                	je     7eb1 <fwp_args24+0xa1>
    7ea4:	80 f9 fe             	cmp    $0xfe,%cl
    7ea7:	0f 83 2b 01 00 00    	jae    7fd8 <fwp_args24+0x1c8>
    7ead:	fe c1                	inc    %cl
    7eaf:	88 08                	mov    %cl,(%rax)
    7eb1:	89 f0                	mov    %esi,%eax
    7eb3:	83 f0 01             	xor    $0x1,%eax
    7eb6:	39 d0                	cmp    %edx,%eax
    7eb8:	0f 83 85 00 00 00    	jae    7f43 <fwp_args24+0x133>
    7ebe:	89 c0                	mov    %eax,%eax
    7ec0:	48 8b 04 c7          	mov    (%rdi,%rax,8),%rax
    7ec4:	48 2b 05 a5 52 00 00 	sub    0x52a5(%rip),%rax        # d170 <fwp_gc+0x1030>
    7ecb:	48 8b 0d c6 52 00 00 	mov    0x52c6(%rip),%rcx        # d198 <fwp_gc+0x1058>
    7ed2:	48 c1 e1 10          	shl    $0x10,%rcx
    7ed6:	48 39 c8             	cmp    %rcx,%rax
    7ed9:	73 68                	jae    7f43 <fwp_args24+0x133>
    7edb:	48 8b 0d d6 52 00 00 	mov    0x52d6(%rip),%rcx        # d1b8 <fwp_gc+0x1078>
    7ee2:	49 89 c0             	mov    %rax,%r8
    7ee5:	49 c1 e8 10          	shr    $0x10,%r8
    7ee9:	4d 69 c0 28 12 00 00 	imul   $0x1228,%r8,%r8
    7ef0:	46 0f b6 0c 01       	movzbl (%rcx,%r8,1),%r9d
    7ef5:	48 25 ff ff 00 00    	and    $0xffff,%rax
    7efb:	75 12                	jne    7f0f <fwp_args24+0xff>
    7efd:	41 80 f9 02          	cmp    $0x2,%r9b
    7f01:	75 0c                	jne    7f0f <fwp_args24+0xff>
    7f03:	4a 8d 04 01          	lea    (%rcx,%r8,1),%rax
    7f07:	48 05 28 02 00 00    	add    $0x228,%rax
    7f0d:	eb 20                	jmp    7f2f <fwp_args24+0x11f>
    7f0f:	41 80 f9 01          	cmp    $0x1,%r9b
    7f13:	75 2e                	jne    7f43 <fwp_args24+0x133>
    7f15:	4e 8d 0c 01          	lea    (%rcx,%r8,1),%r9
    7f19:	42 8b 4c 01 20       	mov    0x20(%rcx,%r8,1),%ecx
    7f1e:	48 0f af c1          	imul   %rcx,%rax
    7f22:	48 c1 e8 20          	shr    $0x20,%rax
    7f26:	4c 01 c8             	add    %r9,%rax
    7f29:	48 05 28 02 00 00    	add    $0x228,%rax
    7f2f:	0f b6 08             	movzbl (%rax),%ecx
    7f32:	84 c9                	test   %cl,%cl
    7f34:	74 0d                	je     7f43 <fwp_args24+0x133>
    7f36:	80 f9 fe             	cmp    $0xfe,%cl
    7f39:	0f 83 bf 00 00 00    	jae    7ffe <fwp_args24+0x1ee>
    7f3f:	fe c1                	inc    %cl
    7f41:	88 08                	mov    %cl,(%rax)
    7f43:	b8 02 00 00 00       	mov    $0x2,%eax
    7f48:	29 f0                	sub    %esi,%eax
    7f4a:	39 d0                	cmp    %edx,%eax
    7f4c:	0f 83 81 00 00 00    	jae    7fd3 <fwp_args24+0x1c3>
    7f52:	89 c0                	mov    %eax,%eax
    7f54:	48 8b 04 c7          	mov    (%rdi,%rax,8),%rax
    7f58:	48 2b 05 11 52 00 00 	sub    0x5211(%rip),%rax        # d170 <fwp_gc+0x1030>
    7f5f:	48 8b 0d 32 52 00 00 	mov    0x5232(%rip),%rcx        # d198 <fwp_gc+0x1058>
    7f66:	48 c1 e1 10          	shl    $0x10,%rcx
    7f6a:	48 39 c8             	cmp    %rcx,%rax
    7f6d:	73 64                	jae    7fd3 <fwp_args24+0x1c3>
    7f6f:	48 8b 0d 42 52 00 00 	mov    0x5242(%rip),%rcx        # d1b8 <fwp_gc+0x1078>
    7f76:	48 89 c2             	mov    %rax,%rdx
    7f79:	48 c1 ea 10          	shr    $0x10,%rdx
    7f7d:	48 69 d2 28 12 00 00 	imul   $0x1228,%rdx,%rdx
    7f84:	0f b6 34 11          	movzbl (%rcx,%rdx,1),%esi
    7f88:	48 25 ff ff 00 00    	and    $0xffff,%rax
    7f8e:	75 13                	jne    7fa3 <fwp_args24+0x193>
    7f90:	40 80 fe 02          	cmp    $0x2,%sil
    7f94:	75 0d                	jne    7fa3 <fwp_args24+0x193>
    7f96:	48 8d 3c 11          	lea    (%rcx,%rdx,1),%rdi
    7f9a:	48 81 c7 28 02 00 00 	add    $0x228,%rdi
    7fa1:	eb 21                	jmp    7fc4 <fwp_args24+0x1b4>
    7fa3:	40 80 fe 01          	cmp    $0x1,%sil
    7fa7:	75 2a                	jne    7fd3 <fwp_args24+0x1c3>
    7fa9:	48 8d 34 11          	lea    (%rcx,%rdx,1),%rsi
    7fad:	8b 4c 11 20          	mov    0x20(%rcx,%rdx,1),%ecx
    7fb1:	48 0f af c1          	imul   %rcx,%rax
    7fb5:	48 c1 e8 20          	shr    $0x20,%rax
    7fb9:	48 8d 3c 30          	lea    (%rax,%rsi,1),%rdi
    7fbd:	48 81 c7 28 02 00 00 	add    $0x228,%rdi
    7fc4:	0f b6 07             	movzbl (%rdi),%eax
    7fc7:	84 c0                	test   %al,%al
    7fc9:	74 08                	je     7fd3 <fwp_args24+0x1c3>
    7fcb:	3c fe                	cmp    $0xfe,%al
    7fcd:	73 26                	jae    7ff5 <fwp_args24+0x1e5>
    7fcf:	fe c0                	inc    %al
    7fd1:	88 07                	mov    %al,(%rdi)
    7fd3:	5b                   	pop    %rbx
    7fd4:	41 5e                	pop    %r14
    7fd6:	5d                   	pop    %rbp
    7fd7:	c3                   	ret
    7fd8:	48 89 fb             	mov    %rdi,%rbx
    7fdb:	48 89 c7             	mov    %rax,%rdi
    7fde:	89 d5                	mov    %edx,%ebp
    7fe0:	41 89 f6             	mov    %esi,%r14d
    7fe3:	e8 58 e0 ff ff       	call   6040 <fwp_rc_wide_dup>
    7fe8:	44 89 f6             	mov    %r14d,%esi
    7feb:	89 ea                	mov    %ebp,%edx
    7fed:	48 89 df             	mov    %rbx,%rdi
    7ff0:	e9 bc fe ff ff       	jmp    7eb1 <fwp_args24+0xa1>
    7ff5:	5b                   	pop    %rbx
    7ff6:	41 5e                	pop    %r14
    7ff8:	5d                   	pop    %rbp
    7ff9:	e9 42 e0 ff ff       	jmp    6040 <fwp_rc_wide_dup>
    7ffe:	48 89 fb             	mov    %rdi,%rbx
    8001:	48 89 c7             	mov    %rax,%rdi
    8004:	89 d5                	mov    %edx,%ebp
    8006:	41 89 f6             	mov    %esi,%r14d
    8009:	e8 32 e0 ff ff       	call   6040 <fwp_rc_wide_dup>
    800e:	44 89 f6             	mov    %r14d,%esi
    8011:	89 ea                	mov    %ebp,%edx
    8013:	48 89 df             	mov    %rbx,%rdi
    8016:	e9 28 ff ff ff       	jmp    7f43 <fwp_args24+0x133>
    801b:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)

0000000000008020 <fwp_arg_drop24>:
    8020:	55                   	push   %rbp
    8021:	41 56                	push   %r14
    8023:	53                   	push   %rbx
    8024:	89 d5                	mov    %edx,%ebp
    8026:	41 89 f6             	mov    %esi,%r14d
    8029:	48 89 fb             	mov    %rdi,%rbx
    802c:	85 f6                	test   %esi,%esi
    802e:	75 0e                	jne    803e <fwp_arg_drop24+0x1e>
    8030:	85 ed                	test   %ebp,%ebp
    8032:	74 0a                	je     803e <fwp_arg_drop24+0x1e>
    8034:	48 8b 3b             	mov    (%rbx),%rdi
    8037:	e8 64 e1 ff ff       	call   61a0 <fwp_closure_drop>
    803c:	eb 06                	jmp    8044 <fwp_arg_drop24+0x24>
    803e:	41 83 fe 01          	cmp    $0x1,%r14d
    8042:	77 65                	ja     80a9 <fwp_arg_drop24+0x89>
    8044:	44 89 f0             	mov    %r14d,%eax
    8047:	83 f0 01             	xor    $0x1,%eax
    804a:	39 e8                	cmp    %ebp,%eax
    804c:	0f 83 a4 00 00 00    	jae    80f6 <fwp_arg_drop24+0xd6>
    8052:	89 c0                	mov    %eax,%eax
    8054:	48 8b 3c c3          	mov    (%rbx,%rax,8),%rdi
    8058:	48 89 f8             	mov    %rdi,%rax
    805b:	48 2b 05 0e 51 00 00 	sub    0x510e(%rip),%rax        # d170 <fwp_gc+0x1030>
    8062:	48 8b 0d 2f 51 00 00 	mov    0x512f(%rip),%rcx        # d198 <fwp_gc+0x1058>
    8069:	48 c1 e1 10          	shl    $0x10,%rcx
    806d:	48 39 c8             	cmp    %rcx,%rax
    8070:	0f 83 80 00 00 00    	jae    80f6 <fwp_arg_drop24+0xd6>
    8076:	48 8b 0d 3b 51 00 00 	mov    0x513b(%rip),%rcx        # d1b8 <fwp_gc+0x1078>
    807d:	48 89 c2             	mov    %rax,%rdx
    8080:	48 c1 ea 10          	shr    $0x10,%rdx
    8084:	48 69 d2 28 12 00 00 	imul   $0x1228,%rdx,%rdx
    808b:	0f b6 34 11          	movzbl (%rcx,%rdx,1),%esi
    808f:	48 25 ff ff 00 00    	and    $0xffff,%rax
    8095:	75 1d                	jne    80b4 <fwp_arg_drop24+0x94>
    8097:	40 80 fe 02          	cmp    $0x2,%sil
    809b:	75 17                	jne    80b4 <fwp_arg_drop24+0x94>
    809d:	48 8d 04 11          	lea    (%rcx,%rdx,1),%rax
    80a1:	48 05 28 02 00 00    	add    $0x228,%rax
    80a7:	eb 2a                	jmp    80d3 <fwp_arg_drop24+0xb3>
    80a9:	41 83 fe 02          	cmp    $0x2,%r14d
    80ad:	74 47                	je     80f6 <fwp_arg_drop24+0xd6>
    80af:	e9 e5 00 00 00       	jmp    8199 <fwp_arg_drop24+0x179>
    80b4:	40 80 fe 01          	cmp    $0x1,%sil
    80b8:	75 3c                	jne    80f6 <fwp_arg_drop24+0xd6>
    80ba:	48 8d 34 11          	lea    (%rcx,%rdx,1),%rsi
    80be:	8b 4c 11 20          	mov    0x20(%rcx,%rdx,1),%ecx
    80c2:	48 0f af c1          	imul   %rcx,%rax
    80c6:	48 c1 e8 20          	shr    $0x20,%rax
    80ca:	48 01 f0             	add    %rsi,%rax
    80cd:	48 05 28 02 00 00    	add    $0x228,%rax
    80d3:	0f b6 08             	movzbl (%rax),%ecx
    80d6:	85 c9                	test   %ecx,%ecx
    80d8:	74 1c                	je     80f6 <fwp_arg_drop24+0xd6>
    80da:	83 f9 01             	cmp    $0x1,%ecx
    80dd:	75 07                	jne    80e6 <fwp_arg_drop24+0xc6>
    80df:	e8 ac e6 ff ff       	call   6790 <fwp_rc_free_obj>
    80e4:	eb 10                	jmp    80f6 <fwp_arg_drop24+0xd6>
    80e6:	81 f9 ff 00 00 00    	cmp    $0xff,%ecx
    80ec:	0f 84 b8 00 00 00    	je     81aa <fwp_arg_drop24+0x18a>
    80f2:	fe c9                	dec    %cl
    80f4:	88 08                	mov    %cl,(%rax)
    80f6:	b8 02 00 00 00       	mov    $0x2,%eax
    80fb:	44 29 f0             	sub    %r14d,%eax
    80fe:	39 e8                	cmp    %ebp,%eax
    8100:	0f 83 93 00 00 00    	jae    8199 <fwp_arg_drop24+0x179>
    8106:	89 c0                	mov    %eax,%eax
    8108:	48 8b 3c c3          	mov    (%rbx,%rax,8),%rdi
    810c:	48 89 f8             	mov    %rdi,%rax
    810f:	48 2b 05 5a 50 00 00 	sub    0x505a(%rip),%rax        # d170 <fwp_gc+0x1030>
    8116:	48 8b 0d 7b 50 00 00 	mov    0x507b(%rip),%rcx        # d198 <fwp_gc+0x1058>
    811d:	48 c1 e1 10          	shl    $0x10,%rcx
    8121:	48 39 c8             	cmp    %rcx,%rax
    8124:	73 73                	jae    8199 <fwp_arg_drop24+0x179>
    8126:	48 8b 0d 8b 50 00 00 	mov    0x508b(%rip),%rcx        # d1b8 <fwp_gc+0x1078>
    812d:	48 89 c2             	mov    %rax,%rdx
    8130:	48 c1 ea 10          	shr    $0x10,%rdx
    8134:	48 69 d2 28 12 00 00 	imul   $0x1228,%rdx,%rdx
    813b:	0f b6 34 11          	movzbl (%rcx,%rdx,1),%esi
    813f:	48 25 ff ff 00 00    	and    $0xffff,%rax
    8145:	75 12                	jne    8159 <fwp_arg_drop24+0x139>
    8147:	40 80 fe 02          	cmp    $0x2,%sil
    814b:	75 0c                	jne    8159 <fwp_arg_drop24+0x139>
    814d:	48 8d 04 11          	lea    (%rcx,%rdx,1),%rax
    8151:	48 05 28 02 00 00    	add    $0x228,%rax
    8157:	eb 1f                	jmp    8178 <fwp_arg_drop24+0x158>
    8159:	40 80 fe 01          	cmp    $0x1,%sil
    815d:	75 3a                	jne    8199 <fwp_arg_drop24+0x179>
    815f:	48 8d 34 11          	lea    (%rcx,%rdx,1),%rsi
    8163:	8b 4c 11 20          	mov    0x20(%rcx,%rdx,1),%ecx
    8167:	48 0f af c1          	imul   %rcx,%rax
    816b:	48 c1 e8 20          	shr    $0x20,%rax
    816f:	48 01 f0             	add    %rsi,%rax
    8172:	48 05 28 02 00 00    	add    $0x228,%rax
    8178:	0f b6 08             	movzbl (%rax),%ecx
    817b:	85 c9                	test   %ecx,%ecx
    817d:	74 1a                	je     8199 <fwp_arg_drop24+0x179>
    817f:	83 f9 01             	cmp    $0x1,%ecx
    8182:	75 09                	jne    818d <fwp_arg_drop24+0x16d>
    8184:	5b                   	pop    %rbx
    8185:	41 5e                	pop    %r14
    8187:	5d                   	pop    %rbp
    8188:	e9 03 e6 ff ff       	jmp    6790 <fwp_rc_free_obj>
    818d:	81 f9 ff 00 00 00    	cmp    $0xff,%ecx
    8193:	74 09                	je     819e <fwp_arg_drop24+0x17e>
    8195:	fe c9                	dec    %cl
    8197:	88 08                	mov    %cl,(%rax)
    8199:	5b                   	pop    %rbx
    819a:	41 5e                	pop    %r14
    819c:	5d                   	pop    %rbp
    819d:	c3                   	ret
    819e:	48 89 c7             	mov    %rax,%rdi
    81a1:	5b                   	pop    %rbx
    81a2:	41 5e                	pop    %r14
    81a4:	5d                   	pop    %rbp
    81a5:	e9 06 e3 ff ff       	jmp    64b0 <fwp_rc_wide_drop>
    81aa:	48 89 c7             	mov    %rax,%rdi
    81ad:	e8 fe e2 ff ff       	call   64b0 <fwp_rc_wide_drop>
    81b2:	e9 3f ff ff ff       	jmp    80f6 <fwp_arg_drop24+0xd6>
    81b7:	66 0f 1f 84 00 00 00 	nopw   0x0(%rax,%rax,1)
    81be:	00 00 

00000000000081c0 <f27>:
    81c0:	41 57                	push   %r15
    81c2:	41 56                	push   %r14
    81c4:	53                   	push   %rbx
    81c5:	48 83 ec 40          	sub    $0x40,%rsp
    81c9:	48 b8 03 00 00 00 01 	movabs $0x100000003,%rax
    81d0:	00 00 00 
    81d3:	48 89 44 24 18       	mov    %rax,0x18(%rsp)
    81d8:	48 89 7c 24 20       	mov    %rdi,0x20(%rsp)
    81dd:	48 8d 05 b4 59 00 00 	lea    0x59b4(%rip),%rax        # db98 <s2>
    81e4:	48 89 44 24 10       	mov    %rax,0x10(%rsp)
    81e9:	48 8d 5c 24 18       	lea    0x18(%rsp),%rbx
    81ee:	48 8d 54 24 10       	lea    0x10(%rsp),%rdx
    81f3:	48 89 df             	mov    %rbx,%rdi
    81f6:	be 01 00 00 00       	mov    $0x1,%esi
    81fb:	e8 d0 d5 ff ff       	call   57d0 <fwp_apply_owned>
    8200:	49 89 c6             	mov    %rax,%r14
    8203:	48 8d 05 9e 59 00 00 	lea    0x599e(%rip),%rax        # dba8 <s3>
    820a:	48 89 44 24 08       	mov    %rax,0x8(%rsp)
    820f:	48 8d 54 24 08       	lea    0x8(%rsp),%rdx
    8214:	48 89 df             	mov    %rbx,%rdi
    8217:	be 01 00 00 00       	mov    $0x1,%esi
    821c:	e8 af d5 ff ff       	call   57d0 <fwp_apply_owned>
    8221:	49 89 c7             	mov    %rax,%r15
    8224:	48 8d 05 8d 59 00 00 	lea    0x598d(%rip),%rax        # dbb8 <s4>
    822b:	48 89 04 24          	mov    %rax,(%rsp)
    822f:	48 89 e2             	mov    %rsp,%rdx
    8232:	48 89 df             	mov    %rbx,%rdi
    8235:	be 01 00 00 00       	mov    $0x1,%esi
    823a:	e8 91 d5 ff ff       	call   57d0 <fwp_apply_owned>
    823f:	4c 89 74 24 28       	mov    %r14,0x28(%rsp)
    8244:	4c 89 7c 24 30       	mov    %r15,0x30(%rsp)
    8249:	48 89 44 24 38       	mov    %rax,0x38(%rsp)
    824e:	48 8d 54 24 28       	lea    0x28(%rsp),%rdx
    8253:	31 ff                	xor    %edi,%edi
    8255:	be 03 00 00 00       	mov    $0x3,%esi
    825a:	e8 51 bc ff ff       	call   3eb0 <fwp_data>
    825f:	48 89 c1             	mov    %rax,%rcx
    8262:	48 2b 0d 07 4f 00 00 	sub    0x4f07(%rip),%rcx        # d170 <fwp_gc+0x1030>
    8269:	48 8b 15 28 4f 00 00 	mov    0x4f28(%rip),%rdx        # d198 <fwp_gc+0x1058>
    8270:	48 c1 e2 10          	shl    $0x10,%rdx
    8274:	48 39 d1             	cmp    %rdx,%rcx
    8277:	73 73                	jae    82ec <f27+0x12c>
    8279:	48 8b 15 38 4f 00 00 	mov    0x4f38(%rip),%rdx        # d1b8 <fwp_gc+0x1078>
    8280:	48 89 ce             	mov    %rcx,%rsi
    8283:	48 c1 ee 10          	shr    $0x10,%rsi
    8287:	48 69 f6 28 12 00 00 	imul   $0x1228,%rsi,%rsi
    828e:	0f b6 3c 32          	movzbl (%rdx,%rsi,1),%edi
    8292:	48 81 e1 ff ff 00 00 	and    $0xffff,%rcx
    8299:	75 1b                	jne    82b6 <f27+0xf6>
    829b:	40 80 ff 02          	cmp    $0x2,%dil
    829f:	75 15                	jne    82b6 <f27+0xf6>
    82a1:	48 8d 1c 32          	lea    (%rdx,%rsi,1),%rbx
    82a5:	48 81 c3 28 02 00 00 	add    $0x228,%rbx
    82ac:	80 3b ff             	cmpb   $0xff,(%rbx)
    82af:	74 2b                	je     82dc <f27+0x11c>
    82b1:	c6 03 01             	movb   $0x1,(%rbx)
    82b4:	eb 36                	jmp    82ec <f27+0x12c>
    82b6:	40 80 ff 01          	cmp    $0x1,%dil
    82ba:	75 30                	jne    82ec <f27+0x12c>
    82bc:	48 8d 3c 32          	lea    (%rdx,%rsi,1),%rdi
    82c0:	8b 54 32 20          	mov    0x20(%rdx,%rsi,1),%edx
    82c4:	48 0f af ca          	imul   %rdx,%rcx
    82c8:	48 c1 e9 20          	shr    $0x20,%rcx
    82cc:	48 8d 1c 39          	lea    (%rcx,%rdi,1),%rbx
    82d0:	48 81 c3 28 02 00 00 	add    $0x228,%rbx
    82d7:	80 3b ff             	cmpb   $0xff,(%rbx)
    82da:	75 d5                	jne    82b1 <f27+0xf1>
    82dc:	48 89 df             	mov    %rbx,%rdi
    82df:	49 89 c6             	mov    %rax,%r14
    82e2:	e8 19 bb ff ff       	call   3e00 <fwp_rc_forget_slot>
    82e7:	4c 89 f0             	mov    %r14,%rax
    82ea:	eb c5                	jmp    82b1 <f27+0xf1>
    82ec:	48 83 c4 40          	add    $0x40,%rsp
    82f0:	5b                   	pop    %rbx
    82f1:	41 5e                	pop    %r14
    82f3:	41 5f                	pop    %r15
    82f5:	c3                   	ret
    82f6:	66 2e 0f 1f 84 00 00 	cs nopw 0x0(%rax,%rax,1)
    82fd:	00 00 00 

0000000000008300 <fwp_owned_entry27>:
    8300:	48 8b 3f             	mov    (%rdi),%rdi
    8303:	e9 b8 fe ff ff       	jmp    81c0 <f27>
    8308:	0f 1f 84 00 00 00 00 	nopl   0x0(%rax,%rax,1)
    830f:	00 

0000000000008310 <fwp_caps27>:
    8310:	85 f6                	test   %esi,%esi
    8312:	0f 84 78 e4 ff ff    	je     6790 <fwp_rc_free_obj>
    8318:	c3                   	ret
    8319:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)

0000000000008320 <fwp_args27>:
    8320:	c3                   	ret
    8321:	66 66 66 66 66 66 2e 	data16 data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    8328:	0f 1f 84 00 00 00 00 
    832f:	00 

0000000000008330 <fwp_gc_find_data>:
    8330:	0f b7 77 18          	movzwl 0x18(%rdi),%esi
    8334:	48 85 f6             	test   %rsi,%rsi
    8337:	0f 84 be 00 00 00    	je     83fb <fwp_gc_find_data+0xcb>
    833d:	53                   	push   %rbx
    833e:	48 8b 07             	mov    (%rdi),%rax
    8341:	4c 8b 47 10          	mov    0x10(%rdi),%r8
    8345:	48 6b ce 38          	imul   $0x38,%rsi,%rcx
    8349:	45 31 c9             	xor    %r9d,%r9d
    834c:	48 8d 15 ed 3d 00 00 	lea    0x3ded(%rip),%rdx        # c140 <fwp_gc>
    8353:	41 bb 01 00 00 00    	mov    $0x1,%r11d
    8359:	45 31 d2             	xor    %r10d,%r10d
    835c:	eb 0b                	jmp    8369 <fwp_gc_find_data+0x39>
    835e:	66 90                	xchg   %ax,%ax
    8360:	49 83 c1 38          	add    $0x38,%r9
    8364:	4c 39 c9             	cmp    %r9,%rcx
    8367:	74 22                	je     838b <fwp_gc_find_data+0x5b>
    8369:	43 83 3c 08 01       	cmpl   $0x1,(%r8,%r9,1)
    836e:	75 f0                	jne    8360 <fwp_gc_find_data+0x30>
    8370:	4b 8b 5c 08 10       	mov    0x10(%r8,%r9,1),%rbx
    8375:	48 01 c3             	add    %rax,%rbx
    8378:	48 39 d3             	cmp    %rdx,%rbx
    837b:	77 e3                	ja     8360 <fwp_gc_find_data+0x30>
    837d:	4b 03 5c 08 28       	add    0x28(%r8,%r9,1),%rbx
    8382:	48 39 d3             	cmp    %rdx,%rbx
    8385:	45 0f 47 d3          	cmova  %r11d,%r10d
    8389:	eb d5                	jmp    8360 <fwp_gc_find_data+0x30>
    838b:	31 c0                	xor    %eax,%eax
    838d:	45 85 d2             	test   %r10d,%r10d
    8390:	0f 95 c0             	setne  %al
    8393:	74 6e                	je     8403 <fwp_gc_find_data+0xd3>
    8395:	66 85 f6             	test   %si,%si
    8398:	74 69                	je     8403 <fwp_gc_find_data+0xd3>
    839a:	8b 05 30 4f 00 00    	mov    0x4f30(%rip),%eax        # d2d0 <fwp_gc+0x1190>
    83a0:	48 8b 77 10          	mov    0x10(%rdi),%rsi
    83a4:	45 31 c0             	xor    %r8d,%r8d
    83a7:	eb 10                	jmp    83b9 <fwp_gc_find_data+0x89>
    83a9:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)
    83b0:	49 83 c0 38          	add    $0x38,%r8
    83b4:	4c 39 c1             	cmp    %r8,%rcx
    83b7:	74 45                	je     83fe <fwp_gc_find_data+0xce>
    83b9:	42 83 3c 06 01       	cmpl   $0x1,(%rsi,%r8,1)
    83be:	75 f0                	jne    83b0 <fwp_gc_find_data+0x80>
    83c0:	42 f6 44 06 04 02    	testb  $0x2,0x4(%rsi,%r8,1)
    83c6:	74 e8                	je     83b0 <fwp_gc_find_data+0x80>
    83c8:	83 f8 10             	cmp    $0x10,%eax
    83cb:	74 31                	je     83fe <fwp_gc_find_data+0xce>
    83cd:	4e 8b 4c 06 10       	mov    0x10(%rsi,%r8,1),%r9
    83d2:	4c 03 0f             	add    (%rdi),%r9
    83d5:	4c 63 d0             	movslq %eax,%r10
    83d8:	49 c1 e2 04          	shl    $0x4,%r10
    83dc:	4d 89 8c 12 90 10 00 	mov    %r9,0x1090(%r10,%rdx,1)
    83e3:	00 
    83e4:	4e 8b 4c 06 28       	mov    0x28(%rsi,%r8,1),%r9
    83e9:	4d 89 8c 12 98 10 00 	mov    %r9,0x1098(%r10,%rdx,1)
    83f0:	00 
    83f1:	ff c0                	inc    %eax
    83f3:	89 05 d7 4e 00 00    	mov    %eax,0x4ed7(%rip)        # d2d0 <fwp_gc+0x1190>
    83f9:	eb b5                	jmp    83b0 <fwp_gc_find_data+0x80>
    83fb:	31 c0                	xor    %eax,%eax
    83fd:	c3                   	ret
    83fe:	b8 01 00 00 00       	mov    $0x1,%eax
    8403:	5b                   	pop    %rbx
    8404:	c3                   	ret
    8405:	66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
    840c:	00 00 00 00 

0000000000008410 <fwp_gc_report>:
    8410:	55                   	push   %rbp
    8411:	41 57                	push   %r15
    8413:	41 56                	push   %r14
    8415:	41 55                	push   %r13
    8417:	41 54                	push   %r12
    8419:	53                   	push   %rbx
    841a:	48 81 ec 58 01 00 00 	sub    $0x158,%rsp
    8421:	48 8b 05 28 4f 00 00 	mov    0x4f28(%rip),%rax        # d350 <fwp_gc+0x1210>
    8428:	48 8b 0d 11 3d 00 00 	mov    0x3d11(%rip),%rcx        # c140 <fwp_gc>
    842f:	48 29 c8             	sub    %rcx,%rax
    8432:	f2 48 0f 2a c0       	cvtsi2sd %rax,%xmm0
    8437:	f2 0f 58 05 e9 4e 00 	addsd  0x4ee9(%rip),%xmm0        # d328 <fwp_gc+0x11e8>
    843e:	00 
    843f:	f2 0f 11 44 24 48    	movsd  %xmm0,0x48(%rsp)
    8445:	f2 0f 11 05 db 4e 00 	movsd  %xmm0,0x4edb(%rip)        # d328 <fwp_gc+0x11e8>
    844c:	00 
    844d:	48 89 0d fc 4e 00 00 	mov    %rcx,0x4efc(%rip)        # d350 <fwp_gc+0x1210>
    8454:	48 8b 05 85 3b 00 00 	mov    0x3b85(%rip),%rax        # bfe0 <stderr@GLIBC_2.2.5>
    845b:	48 8b 28             	mov    (%rax),%rbp
    845e:	48 8b 1d b3 4e 00 00 	mov    0x4eb3(%rip),%rbx        # d318 <fwp_gc+0x11d8>
    8465:	4c 8b 3d ec 4c 00 00 	mov    0x4cec(%rip),%r15        # d158 <fwp_gc+0x1018>
    846c:	f2 0f 10 05 d4 4e 00 	movsd  0x4ed4(%rip),%xmm0        # d348 <fwp_gc+0x1208>
    8473:	00 
    8474:	f2 0f 11 44 24 30    	movsd  %xmm0,0x30(%rsp)
    847a:	48 8b 05 07 4d 00 00 	mov    0x4d07(%rip),%rax        # d188 <fwp_gc+0x1048>
    8481:	48 89 44 24 28       	mov    %rax,0x28(%rsp)
    8486:	48 8b 05 7b 4e 00 00 	mov    0x4e7b(%rip),%rax        # d308 <fwp_gc+0x11c8>
    848d:	48 89 44 24 20       	mov    %rax,0x20(%rsp)
    8492:	4c 8b 35 77 4e 00 00 	mov    0x4e77(%rip),%r14        # d310 <fwp_gc+0x11d0>
    8499:	f2 0f 10 05 8f 4e 00 	movsd  0x4e8f(%rip),%xmm0        # d330 <fwp_gc+0x11f0>
    84a0:	00 
    84a1:	f2 0f 11 44 24 40    	movsd  %xmm0,0x40(%rsp)
    84a7:	f2 0f 10 05 89 4e 00 	movsd  0x4e89(%rip),%xmm0        # d338 <fwp_gc+0x11f8>
    84ae:	00 
    84af:	f2 0f 11 44 24 38    	movsd  %xmm0,0x38(%rsp)
    84b5:	48 8d 3d fc 0f 00 00 	lea    0xffc(%rip),%rdi        # 94b8 <_IO_stdin_used+0x4b8>
    84bc:	48 8d 35 07 10 00 00 	lea    0x1007(%rip),%rsi        # 94ca <_IO_stdin_used+0x4ca>
    84c3:	e8 28 9d ff ff       	call   21f0 <fopen@plt>
    84c8:	49 c7 c4 ff ff ff ff 	mov    $0xffffffffffffffff,%r12
    84cf:	48 85 c0             	test   %rax,%rax
    84d2:	74 4b                	je     851f <fwp_gc_report+0x10f>
    84d4:	49 89 c5             	mov    %rax,%r13
    84d7:	48 89 6c 24 08       	mov    %rbp,0x8(%rsp)
    84dc:	4c 89 7c 24 10       	mov    %r15,0x10(%rsp)
    84e1:	48 89 5c 24 18       	mov    %rbx,0x18(%rsp)
    84e6:	48 8d 7c 24 50       	lea    0x50(%rsp),%rdi
    84eb:	be 00 01 00 00       	mov    $0x100,%esi
    84f0:	48 89 c2             	mov    %rax,%rdx
    84f3:	e8 18 9c ff ff       	call   2110 <fgets@plt>
    84f8:	49 c7 c4 ff ff ff ff 	mov    $0xffffffffffffffff,%r12
    84ff:	48 85 c0             	test   %rax,%rax
    8502:	0f 85 f1 00 00 00    	jne    85f9 <fwp_gc_report+0x1e9>
    8508:	4c 89 ef             	mov    %r13,%rdi
    850b:	e8 a0 9b ff ff       	call   20b0 <fclose@plt>
    8510:	48 8b 5c 24 18       	mov    0x18(%rsp),%rbx
    8515:	4c 8b 7c 24 10       	mov    0x10(%rsp),%r15
    851a:	48 8b 6c 24 08       	mov    0x8(%rsp),%rbp
    851f:	66 49 0f 6e c6       	movq   %r14,%xmm0
    8524:	66 0f 6f 0d 94 0b 00 	movdqa 0xb94(%rip),%xmm1        # 90c0 <_IO_stdin_used+0xc0>
    852b:	00 
    852c:	66 0f 62 c1          	punpckldq %xmm1,%xmm0
    8530:	66 0f 28 15 98 0b 00 	movapd 0xb98(%rip),%xmm2        # 90d0 <_IO_stdin_used+0xd0>
    8537:	00 
    8538:	66 0f 5c c2          	subpd  %xmm2,%xmm0
    853c:	66 0f 28 e0          	movapd %xmm0,%xmm4
    8540:	66 0f 15 e0          	unpckhpd %xmm0,%xmm4
    8544:	f2 0f 58 e0          	addsd  %xmm0,%xmm4
    8548:	f2 0f 10 35 90 0b 00 	movsd  0xb90(%rip),%xmm6        # 90e0 <_IO_stdin_used+0xe0>
    854f:	00 
    8550:	f2 0f 59 e6          	mulsd  %xmm6,%xmm4
    8554:	f3 0f 7e 6c 24 20    	movq   0x20(%rsp),%xmm5
    855a:	66 0f 62 e9          	punpckldq %xmm1,%xmm5
    855e:	66 0f 5c ea          	subpd  %xmm2,%xmm5
    8562:	66 0f 28 dd          	movapd %xmm5,%xmm3
    8566:	66 0f 15 dd          	unpckhpd %xmm5,%xmm3
    856a:	f2 0f 58 dd          	addsd  %xmm5,%xmm3
    856e:	f2 0f 59 de          	mulsd  %xmm6,%xmm3
    8572:	f3 0f 7e 6c 24 28    	movq   0x28(%rsp),%xmm5
    8578:	66 0f 62 e9          	punpckldq %xmm1,%xmm5
    857c:	66 0f 5c ea          	subpd  %xmm2,%xmm5
    8580:	66 0f 28 d5          	movapd %xmm5,%xmm2
    8584:	66 0f 15 d5          	unpckhpd %xmm5,%xmm2
    8588:	f2 0f 58 d5          	addsd  %xmm5,%xmm2
    858c:	f2 0f 59 d6          	mulsd  %xmm6,%xmm2
    8590:	f2 0f 10 44 24 48    	movsd  0x48(%rsp),%xmm0
    8596:	f2 0f 10 4c 24 30    	movsd  0x30(%rsp),%xmm1
    859c:	f2 0f 58 c1          	addsd  %xmm1,%xmm0
    85a0:	f2 0f 59 ce          	mulsd  %xmm6,%xmm1
    85a4:	f2 0f 59 c6          	mulsd  %xmm6,%xmm0
    85a8:	83 3d 85 4b 00 00 00 	cmpl   $0x0,0x4b85(%rip)        # d134 <fwp_gc+0xff4>
    85af:	48 8d 05 f0 0e 00 00 	lea    0xef0(%rip),%rax        # 94a6 <_IO_stdin_used+0x4a6>
    85b6:	4c 8d 0d 33 0e 00 00 	lea    0xe33(%rip),%r9        # 93f0 <_IO_stdin_used+0x3f0>
    85bd:	4c 0f 44 c8          	cmove  %rax,%r9
    85c1:	48 8d 35 29 0e 00 00 	lea    0xe29(%rip),%rsi        # 93f1 <_IO_stdin_used+0x3f1>
    85c8:	48 89 ef             	mov    %rbp,%rdi
    85cb:	48 89 da             	mov    %rbx,%rdx
    85ce:	4c 89 f9             	mov    %r15,%rcx
    85d1:	f2 0f 10 6c 24 40    	movsd  0x40(%rsp),%xmm5
    85d7:	f2 0f 10 74 24 38    	movsd  0x38(%rsp),%xmm6
    85dd:	4d 89 e0             	mov    %r12,%r8
    85e0:	b0 07                	mov    $0x7,%al
    85e2:	e8 69 9b ff ff       	call   2150 <fprintf@plt>
    85e7:	48 81 c4 58 01 00 00 	add    $0x158,%rsp
    85ee:	5b                   	pop    %rbx
    85ef:	41 5c                	pop    %r12
    85f1:	41 5d                	pop    %r13
    85f3:	41 5e                	pop    %r14
    85f5:	41 5f                	pop    %r15
    85f7:	5d                   	pop    %rbp
    85f8:	c3                   	ret
    85f9:	48 8d 6c 24 56       	lea    0x56(%rsp),%rbp
    85fe:	41 bf 56 6d 48 57    	mov    $0x57486d56,%r15d
    8604:	48 8d 5c 24 50       	lea    0x50(%rsp),%rbx
    8609:	eb 1e                	jmp    8629 <fwp_gc_report+0x219>
    860b:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)
    8610:	48 89 df             	mov    %rbx,%rdi
    8613:	be 00 01 00 00       	mov    $0x100,%esi
    8618:	4c 89 ea             	mov    %r13,%rdx
    861b:	e8 f0 9a ff ff       	call   2110 <fgets@plt>
    8620:	48 85 c0             	test   %rax,%rax
    8623:	0f 84 df fe ff ff    	je     8508 <fwp_gc_report+0xf8>
    8629:	8b 44 24 50          	mov    0x50(%rsp),%eax
    862d:	44 31 f8             	xor    %r15d,%eax
    8630:	0f b6 4c 24 54       	movzbl 0x54(%rsp),%ecx
    8635:	83 f1 4d             	xor    $0x4d,%ecx
    8638:	09 c1                	or     %eax,%ecx
    863a:	75 d4                	jne    8610 <fwp_gc_report+0x200>
    863c:	80 7c 24 55 3a       	cmpb   $0x3a,0x55(%rsp)
    8641:	75 cd                	jne    8610 <fwp_gc_report+0x200>
    8643:	48 89 ef             	mov    %rbp,%rdi
    8646:	31 f6                	xor    %esi,%esi
    8648:	ba 0a 00 00 00       	mov    $0xa,%edx
    864d:	e8 1e 9b ff ff       	call   2170 <strtol@plt>
    8652:	49 89 c4             	mov    %rax,%r12
    8655:	eb b9                	jmp    8610 <fwp_gc_report+0x200>
    8657:	66 0f 1f 84 00 00 00 	nopw   0x0(%rax,%rax,1)
    865e:	00 00 

0000000000008660 <fwp_segv>:
    8660:	48 8b 05 a9 55 00 00 	mov    0x55a9(%rip),%rax        # dc10 <fwp_main_stack_top>
    8667:	48 85 c0             	test   %rax,%rax
    866a:	74 22                	je     868e <fwp_segv+0x2e>
    866c:	48 8b 4e 10          	mov    0x10(%rsi),%rcx
    8670:	48 2b 05 a1 55 00 00 	sub    0x55a1(%rip),%rax        # dc18 <fwp_main_stack_size>
    8677:	48 8d 90 00 00 f0 ff 	lea    -0x100000(%rax),%rdx
    867e:	48 39 ca             	cmp    %rcx,%rdx
    8681:	77 0b                	ja     868e <fwp_segv+0x2e>
    8683:	48 05 00 00 10 00    	add    $0x100000,%rax
    8689:	48 39 c8             	cmp    %rcx,%rax
    868c:	77 07                	ja     8695 <fwp_segv+0x35>
    868e:	31 f6                	xor    %esi,%esi
    8690:	e9 ab 9a ff ff       	jmp    2140 <signal@plt>
    8695:	50                   	push   %rax
    8696:	e8 35 b7 ff ff       	call   3dd0 <fwp_flush>
    869b:	48 8d 35 2e 0e 00 00 	lea    0xe2e(%rip),%rsi        # 94d0 <fwp_segv.msg>
    86a2:	ba 1a 00 00 00       	mov    $0x1a,%edx
    86a7:	bf 02 00 00 00       	mov    $0x2,%edi
    86ac:	e8 ef 99 ff ff       	call   20a0 <write@plt>
    86b1:	bf 65 00 00 00       	mov    $0x65,%edi
    86b6:	e8 b5 99 ff ff       	call   2070 <_exit@plt>
    86bb:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)

00000000000086c0 <atexit>:
    86c0:	f3 0f 1e fa          	endbr64
    86c4:	48 8b 15 65 3a 00 00 	mov    0x3a65(%rip),%rdx        # c130 <__dso_handle>
    86cb:	31 f6                	xor    %esi,%esi
    86cd:	e9 3e 9b ff ff       	jmp    2210 <__cxa_atexit@plt>

Disassembly of section .fini:

00000000000086d4 <_fini>:
    86d4:	f3 0f 1e fa          	endbr64
    86d8:	48 83 ec 08          	sub    $0x8,%rsp
    86dc:	48 83 c4 08          	add    $0x8,%rsp
    86e0:	c3                   	ret
