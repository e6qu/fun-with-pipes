
/home/runner/work/_temp/numeric-layout-baseline/scalar-diagnostic:     file format elf64-x86-64


Disassembly of section .init:

0000000000002000 <_init>:
    2000:	f3 0f 1e fa          	endbr64
    2004:	48 83 ec 08          	sub    $0x8,%rsp
    2008:	48 8b 05 b1 0f 01 00 	mov    0x10fb1(%rip),%rax        # 12fc0 <__gmon_start__@Base>
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

0000000000002050 <free@plt>:
    2050:	ff 25 ba 0f 01 00    	jmp    *0x10fba(%rip)        # 13010 <free@GLIBC_2.2.5>
    2056:	68 02 00 00 00       	push   $0x2
    205b:	e9 c0 ff ff ff       	jmp    2020 <_init+0x20>

0000000000002060 <recv@plt>:
    2060:	ff 25 b2 0f 01 00    	jmp    *0x10fb2(%rip)        # 13018 <recv@GLIBC_2.2.5>
    2066:	68 03 00 00 00       	push   $0x3
    206b:	e9 b0 ff ff ff       	jmp    2020 <_init+0x20>

0000000000002070 <abort@plt>:
    2070:	ff 25 aa 0f 01 00    	jmp    *0x10faa(%rip)        # 13020 <abort@GLIBC_2.2.5>
    2076:	68 04 00 00 00       	push   $0x4
    207b:	e9 a0 ff ff ff       	jmp    2020 <_init+0x20>

0000000000002080 <__errno_location@plt>:
    2080:	ff 25 a2 0f 01 00    	jmp    *0x10fa2(%rip)        # 13028 <__errno_location@GLIBC_2.2.5>
    2086:	68 05 00 00 00       	push   $0x5
    208b:	e9 90 ff ff ff       	jmp    2020 <_init+0x20>

0000000000002090 <strncmp@plt>:
    2090:	ff 25 9a 0f 01 00    	jmp    *0x10f9a(%rip)        # 13030 <strncmp@GLIBC_2.2.5>
    2096:	68 06 00 00 00       	push   $0x6
    209b:	e9 80 ff ff ff       	jmp    2020 <_init+0x20>

00000000000020a0 <_exit@plt>:
    20a0:	ff 25 92 0f 01 00    	jmp    *0x10f92(%rip)        # 13038 <_exit@GLIBC_2.2.5>
    20a6:	68 07 00 00 00       	push   $0x7
    20ab:	e9 70 ff ff ff       	jmp    2020 <_init+0x20>

00000000000020b0 <strcpy@plt>:
    20b0:	ff 25 8a 0f 01 00    	jmp    *0x10f8a(%rip)        # 13040 <strcpy@GLIBC_2.2.5>
    20b6:	68 08 00 00 00       	push   $0x8
    20bb:	e9 60 ff ff ff       	jmp    2020 <_init+0x20>

00000000000020c0 <sendmsg@plt>:
    20c0:	ff 25 82 0f 01 00    	jmp    *0x10f82(%rip)        # 13048 <sendmsg@GLIBC_2.2.5>
    20c6:	68 09 00 00 00       	push   $0x9
    20cb:	e9 50 ff ff ff       	jmp    2020 <_init+0x20>

00000000000020d0 <puts@plt>:
    20d0:	ff 25 7a 0f 01 00    	jmp    *0x10f7a(%rip)        # 13050 <puts@GLIBC_2.2.5>
    20d6:	68 0a 00 00 00       	push   $0xa
    20db:	e9 40 ff ff ff       	jmp    2020 <_init+0x20>

00000000000020e0 <sigaction@plt>:
    20e0:	ff 25 72 0f 01 00    	jmp    *0x10f72(%rip)        # 13058 <sigaction@GLIBC_2.2.5>
    20e6:	68 0b 00 00 00       	push   $0xb
    20eb:	e9 30 ff ff ff       	jmp    2020 <_init+0x20>

00000000000020f0 <fread@plt>:
    20f0:	ff 25 6a 0f 01 00    	jmp    *0x10f6a(%rip)        # 13060 <fread@GLIBC_2.2.5>
    20f6:	68 0c 00 00 00       	push   $0xc
    20fb:	e9 20 ff ff ff       	jmp    2020 <_init+0x20>

0000000000002100 <strtod@plt>:
    2100:	ff 25 62 0f 01 00    	jmp    *0x10f62(%rip)        # 13068 <strtod@GLIBC_2.2.5>
    2106:	68 0d 00 00 00       	push   $0xd
    210b:	e9 10 ff ff ff       	jmp    2020 <_init+0x20>

0000000000002110 <vsnprintf@plt>:
    2110:	ff 25 5a 0f 01 00    	jmp    *0x10f5a(%rip)        # 13070 <vsnprintf@GLIBC_2.2.5>
    2116:	68 0e 00 00 00       	push   $0xe
    211b:	e9 00 ff ff ff       	jmp    2020 <_init+0x20>

0000000000002120 <fcntl@plt>:
    2120:	ff 25 52 0f 01 00    	jmp    *0x10f52(%rip)        # 13078 <fcntl@GLIBC_2.2.5>
    2126:	68 0f 00 00 00       	push   $0xf
    212b:	e9 f0 fe ff ff       	jmp    2020 <_init+0x20>

0000000000002130 <clock_gettime@plt>:
    2130:	ff 25 4a 0f 01 00    	jmp    *0x10f4a(%rip)        # 13080 <clock_gettime@GLIBC_2.17>
    2136:	68 10 00 00 00       	push   $0x10
    213b:	e9 e0 fe ff ff       	jmp    2020 <_init+0x20>

0000000000002140 <write@plt>:
    2140:	ff 25 42 0f 01 00    	jmp    *0x10f42(%rip)        # 13088 <write@GLIBC_2.2.5>
    2146:	68 11 00 00 00       	push   $0x11
    214b:	e9 d0 fe ff ff       	jmp    2020 <_init+0x20>

0000000000002150 <fclose@plt>:
    2150:	ff 25 3a 0f 01 00    	jmp    *0x10f3a(%rip)        # 13090 <fclose@GLIBC_2.2.5>
    2156:	68 12 00 00 00       	push   $0x12
    215b:	e9 c0 fe ff ff       	jmp    2020 <_init+0x20>

0000000000002160 <shutdown@plt>:
    2160:	ff 25 32 0f 01 00    	jmp    *0x10f32(%rip)        # 13098 <shutdown@GLIBC_2.2.5>
    2166:	68 13 00 00 00       	push   $0x13
    216b:	e9 b0 fe ff ff       	jmp    2020 <_init+0x20>

0000000000002170 <strlen@plt>:
    2170:	ff 25 2a 0f 01 00    	jmp    *0x10f2a(%rip)        # 130a0 <strlen@GLIBC_2.2.5>
    2176:	68 14 00 00 00       	push   $0x14
    217b:	e9 a0 fe ff ff       	jmp    2020 <_init+0x20>

0000000000002180 <getuid@plt>:
    2180:	ff 25 22 0f 01 00    	jmp    *0x10f22(%rip)        # 130a8 <getuid@GLIBC_2.2.5>
    2186:	68 15 00 00 00       	push   $0x15
    218b:	e9 90 fe ff ff       	jmp    2020 <_init+0x20>

0000000000002190 <mmap@plt>:
    2190:	ff 25 1a 0f 01 00    	jmp    *0x10f1a(%rip)        # 130b0 <mmap@GLIBC_2.2.5>
    2196:	68 16 00 00 00       	push   $0x16
    219b:	e9 80 fe ff ff       	jmp    2020 <_init+0x20>

00000000000021a0 <send@plt>:
    21a0:	ff 25 12 0f 01 00    	jmp    *0x10f12(%rip)        # 130b8 <send@GLIBC_2.2.5>
    21a6:	68 17 00 00 00       	push   $0x17
    21ab:	e9 70 fe ff ff       	jmp    2020 <_init+0x20>

00000000000021b0 <strchr@plt>:
    21b0:	ff 25 0a 0f 01 00    	jmp    *0x10f0a(%rip)        # 130c0 <strchr@GLIBC_2.2.5>
    21b6:	68 18 00 00 00       	push   $0x18
    21bb:	e9 60 fe ff ff       	jmp    2020 <_init+0x20>

00000000000021c0 <printf@plt>:
    21c0:	ff 25 02 0f 01 00    	jmp    *0x10f02(%rip)        # 130c8 <printf@GLIBC_2.2.5>
    21c6:	68 19 00 00 00       	push   $0x19
    21cb:	e9 50 fe ff ff       	jmp    2020 <_init+0x20>

00000000000021d0 <snprintf@plt>:
    21d0:	ff 25 fa 0e 01 00    	jmp    *0x10efa(%rip)        # 130d0 <snprintf@GLIBC_2.2.5>
    21d6:	68 1a 00 00 00       	push   $0x1a
    21db:	e9 40 fe ff ff       	jmp    2020 <_init+0x20>

00000000000021e0 <ftruncate@plt>:
    21e0:	ff 25 f2 0e 01 00    	jmp    *0x10ef2(%rip)        # 130d8 <ftruncate@GLIBC_2.2.5>
    21e6:	68 1b 00 00 00       	push   $0x1b
    21eb:	e9 30 fe ff ff       	jmp    2020 <_init+0x20>

00000000000021f0 <fputs@plt>:
    21f0:	ff 25 ea 0e 01 00    	jmp    *0x10eea(%rip)        # 130e0 <fputs@GLIBC_2.2.5>
    21f6:	68 1c 00 00 00       	push   $0x1c
    21fb:	e9 20 fe ff ff       	jmp    2020 <_init+0x20>

0000000000002200 <strtof@plt>:
    2200:	ff 25 e2 0e 01 00    	jmp    *0x10ee2(%rip)        # 130e8 <strtof@GLIBC_2.2.5>
    2206:	68 1d 00 00 00       	push   $0x1d
    220b:	e9 10 fe ff ff       	jmp    2020 <_init+0x20>

0000000000002210 <memset@plt>:
    2210:	ff 25 da 0e 01 00    	jmp    *0x10eda(%rip)        # 130f0 <memset@GLIBC_2.2.5>
    2216:	68 1e 00 00 00       	push   $0x1e
    221b:	e9 00 fe ff ff       	jmp    2020 <_init+0x20>

0000000000002220 <fgetc@plt>:
    2220:	ff 25 d2 0e 01 00    	jmp    *0x10ed2(%rip)        # 130f8 <fgetc@GLIBC_2.2.5>
    2226:	68 1f 00 00 00       	push   $0x1f
    222b:	e9 f0 fd ff ff       	jmp    2020 <_init+0x20>

0000000000002230 <close@plt>:
    2230:	ff 25 ca 0e 01 00    	jmp    *0x10eca(%rip)        # 13100 <close@GLIBC_2.2.5>
    2236:	68 20 00 00 00       	push   $0x20
    223b:	e9 e0 fd ff ff       	jmp    2020 <_init+0x20>

0000000000002240 <fputc@plt>:
    2240:	ff 25 c2 0e 01 00    	jmp    *0x10ec2(%rip)        # 13108 <fputc@GLIBC_2.2.5>
    2246:	68 21 00 00 00       	push   $0x21
    224b:	e9 d0 fd ff ff       	jmp    2020 <_init+0x20>

0000000000002250 <sched_yield@plt>:
    2250:	ff 25 ba 0e 01 00    	jmp    *0x10eba(%rip)        # 13110 <sched_yield@GLIBC_2.2.5>
    2256:	68 22 00 00 00       	push   $0x22
    225b:	e9 c0 fd ff ff       	jmp    2020 <_init+0x20>

0000000000002260 <memchr@plt>:
    2260:	ff 25 b2 0e 01 00    	jmp    *0x10eb2(%rip)        # 13118 <memchr@GLIBC_2.2.5>
    2266:	68 23 00 00 00       	push   $0x23
    226b:	e9 b0 fd ff ff       	jmp    2020 <_init+0x20>

0000000000002270 <memcmp@plt>:
    2270:	ff 25 aa 0e 01 00    	jmp    *0x10eaa(%rip)        # 13120 <memcmp@GLIBC_2.2.5>
    2276:	68 24 00 00 00       	push   $0x24
    227b:	e9 a0 fd ff ff       	jmp    2020 <_init+0x20>

0000000000002280 <pthread_attr_init@plt>:
    2280:	ff 25 a2 0e 01 00    	jmp    *0x10ea2(%rip)        # 13128 <pthread_attr_init@GLIBC_2.2.5>
    2286:	68 25 00 00 00       	push   $0x25
    228b:	e9 90 fd ff ff       	jmp    2020 <_init+0x20>

0000000000002290 <fgets@plt>:
    2290:	ff 25 9a 0e 01 00    	jmp    *0x10e9a(%rip)        # 13130 <fgets@GLIBC_2.2.5>
    2296:	68 26 00 00 00       	push   $0x26
    229b:	e9 80 fd ff ff       	jmp    2020 <_init+0x20>

00000000000022a0 <getsockopt@plt>:
    22a0:	ff 25 92 0e 01 00    	jmp    *0x10e92(%rip)        # 13138 <getsockopt@GLIBC_2.2.5>
    22a6:	68 27 00 00 00       	push   $0x27
    22ab:	e9 70 fd ff ff       	jmp    2020 <_init+0x20>

00000000000022b0 <_setjmp@plt>:
    22b0:	ff 25 8a 0e 01 00    	jmp    *0x10e8a(%rip)        # 13140 <_setjmp@GLIBC_2.2.5>
    22b6:	68 28 00 00 00       	push   $0x28
    22bb:	e9 60 fd ff ff       	jmp    2020 <_init+0x20>

00000000000022c0 <strtoull@plt>:
    22c0:	ff 25 82 0e 01 00    	jmp    *0x10e82(%rip)        # 13148 <strtoull@GLIBC_2.2.5>
    22c6:	68 29 00 00 00       	push   $0x29
    22cb:	e9 50 fd ff ff       	jmp    2020 <_init+0x20>

00000000000022d0 <strcmp@plt>:
    22d0:	ff 25 7a 0e 01 00    	jmp    *0x10e7a(%rip)        # 13150 <strcmp@GLIBC_2.2.5>
    22d6:	68 2a 00 00 00       	push   $0x2a
    22db:	e9 40 fd ff ff       	jmp    2020 <_init+0x20>

00000000000022e0 <signal@plt>:
    22e0:	ff 25 72 0e 01 00    	jmp    *0x10e72(%rip)        # 13158 <signal@GLIBC_2.2.5>
    22e6:	68 2b 00 00 00       	push   $0x2b
    22eb:	e9 30 fd ff ff       	jmp    2020 <_init+0x20>

00000000000022f0 <fprintf@plt>:
    22f0:	ff 25 6a 0e 01 00    	jmp    *0x10e6a(%rip)        # 13160 <fprintf@GLIBC_2.2.5>
    22f6:	68 2c 00 00 00       	push   $0x2c
    22fb:	e9 20 fd ff ff       	jmp    2020 <_init+0x20>

0000000000002300 <syscall@plt>:
    2300:	ff 25 62 0e 01 00    	jmp    *0x10e62(%rip)        # 13168 <syscall@GLIBC_2.2.5>
    2306:	68 2d 00 00 00       	push   $0x2d
    230b:	e9 10 fd ff ff       	jmp    2020 <_init+0x20>

0000000000002310 <sigemptyset@plt>:
    2310:	ff 25 5a 0e 01 00    	jmp    *0x10e5a(%rip)        # 13170 <sigemptyset@GLIBC_2.2.5>
    2316:	68 2e 00 00 00       	push   $0x2e
    231b:	e9 00 fd ff ff       	jmp    2020 <_init+0x20>

0000000000002320 <strtol@plt>:
    2320:	ff 25 52 0e 01 00    	jmp    *0x10e52(%rip)        # 13178 <strtol@GLIBC_2.2.5>
    2326:	68 2f 00 00 00       	push   $0x2f
    232b:	e9 f0 fc ff ff       	jmp    2020 <_init+0x20>

0000000000002330 <memcpy@plt>:
    2330:	ff 25 4a 0e 01 00    	jmp    *0x10e4a(%rip)        # 13180 <memcpy@GLIBC_2.14>
    2336:	68 30 00 00 00       	push   $0x30
    233b:	e9 e0 fc ff ff       	jmp    2020 <_init+0x20>

0000000000002340 <malloc@plt>:
    2340:	ff 25 42 0e 01 00    	jmp    *0x10e42(%rip)        # 13188 <malloc@GLIBC_2.2.5>
    2346:	68 31 00 00 00       	push   $0x31
    234b:	e9 d0 fc ff ff       	jmp    2020 <_init+0x20>

0000000000002350 <fflush@plt>:
    2350:	ff 25 3a 0e 01 00    	jmp    *0x10e3a(%rip)        # 13190 <fflush@GLIBC_2.2.5>
    2356:	68 32 00 00 00       	push   $0x32
    235b:	e9 c0 fc ff ff       	jmp    2020 <_init+0x20>

0000000000002360 <listen@plt>:
    2360:	ff 25 32 0e 01 00    	jmp    *0x10e32(%rip)        # 13198 <listen@GLIBC_2.2.5>
    2366:	68 33 00 00 00       	push   $0x33
    236b:	e9 b0 fc ff ff       	jmp    2020 <_init+0x20>

0000000000002370 <bcmp@plt>:
    2370:	ff 25 2a 0e 01 00    	jmp    *0x10e2a(%rip)        # 131a0 <bcmp@GLIBC_2.2.5>
    2376:	68 34 00 00 00       	push   $0x34
    237b:	e9 a0 fc ff ff       	jmp    2020 <_init+0x20>

0000000000002380 <realloc@plt>:
    2380:	ff 25 22 0e 01 00    	jmp    *0x10e22(%rip)        # 131a8 <realloc@GLIBC_2.2.5>
    2386:	68 35 00 00 00       	push   $0x35
    238b:	e9 90 fc ff ff       	jmp    2020 <_init+0x20>

0000000000002390 <munmap@plt>:
    2390:	ff 25 1a 0e 01 00    	jmp    *0x10e1a(%rip)        # 131b0 <munmap@GLIBC_2.2.5>
    2396:	68 36 00 00 00       	push   $0x36
    239b:	e9 80 fc ff ff       	jmp    2020 <_init+0x20>

00000000000023a0 <recvmsg@plt>:
    23a0:	ff 25 12 0e 01 00    	jmp    *0x10e12(%rip)        # 131b8 <recvmsg@GLIBC_2.2.5>
    23a6:	68 37 00 00 00       	push   $0x37
    23ab:	e9 70 fc ff ff       	jmp    2020 <_init+0x20>

00000000000023b0 <setvbuf@plt>:
    23b0:	ff 25 0a 0e 01 00    	jmp    *0x10e0a(%rip)        # 131c0 <setvbuf@GLIBC_2.2.5>
    23b6:	68 38 00 00 00       	push   $0x38
    23bb:	e9 60 fc ff ff       	jmp    2020 <_init+0x20>

00000000000023c0 <poll@plt>:
    23c0:	ff 25 02 0e 01 00    	jmp    *0x10e02(%rip)        # 131c8 <poll@GLIBC_2.2.5>
    23c6:	68 39 00 00 00       	push   $0x39
    23cb:	e9 50 fc ff ff       	jmp    2020 <_init+0x20>

00000000000023d0 <bind@plt>:
    23d0:	ff 25 fa 0d 01 00    	jmp    *0x10dfa(%rip)        # 131d0 <bind@GLIBC_2.2.5>
    23d6:	68 3a 00 00 00       	push   $0x3a
    23db:	e9 40 fc ff ff       	jmp    2020 <_init+0x20>

00000000000023e0 <pthread_create@plt>:
    23e0:	ff 25 f2 0d 01 00    	jmp    *0x10df2(%rip)        # 131d8 <pthread_create@GLIBC_2.34>
    23e6:	68 3b 00 00 00       	push   $0x3b
    23eb:	e9 30 fc ff ff       	jmp    2020 <_init+0x20>

00000000000023f0 <madvise@plt>:
    23f0:	ff 25 ea 0d 01 00    	jmp    *0x10dea(%rip)        # 131e0 <madvise@GLIBC_2.2.5>
    23f6:	68 3c 00 00 00       	push   $0x3c
    23fb:	e9 20 fc ff ff       	jmp    2020 <_init+0x20>

0000000000002400 <atol@plt>:
    2400:	ff 25 e2 0d 01 00    	jmp    *0x10de2(%rip)        # 131e8 <atol@GLIBC_2.2.5>
    2406:	68 3d 00 00 00       	push   $0x3d
    240b:	e9 10 fc ff ff       	jmp    2020 <_init+0x20>

0000000000002410 <mprotect@plt>:
    2410:	ff 25 da 0d 01 00    	jmp    *0x10dda(%rip)        # 131f0 <mprotect@GLIBC_2.2.5>
    2416:	68 3e 00 00 00       	push   $0x3e
    241b:	e9 00 fc ff ff       	jmp    2020 <_init+0x20>

0000000000002420 <fopen@plt>:
    2420:	ff 25 d2 0d 01 00    	jmp    *0x10dd2(%rip)        # 131f8 <fopen@GLIBC_2.2.5>
    2426:	68 3f 00 00 00       	push   $0x3f
    242b:	e9 f0 fb ff ff       	jmp    2020 <_init+0x20>

0000000000002430 <sysconf@plt>:
    2430:	ff 25 ca 0d 01 00    	jmp    *0x10dca(%rip)        # 13200 <sysconf@GLIBC_2.2.5>
    2436:	68 40 00 00 00       	push   $0x40
    243b:	e9 e0 fb ff ff       	jmp    2020 <_init+0x20>

0000000000002440 <accept@plt>:
    2440:	ff 25 c2 0d 01 00    	jmp    *0x10dc2(%rip)        # 13208 <accept@GLIBC_2.2.5>
    2446:	68 41 00 00 00       	push   $0x41
    244b:	e9 d0 fb ff ff       	jmp    2020 <_init+0x20>

0000000000002450 <__cxa_atexit@plt>:
    2450:	ff 25 ba 0d 01 00    	jmp    *0x10dba(%rip)        # 13210 <__cxa_atexit@GLIBC_2.2.5>
    2456:	68 42 00 00 00       	push   $0x42
    245b:	e9 c0 fb ff ff       	jmp    2020 <_init+0x20>

0000000000002460 <atoi@plt>:
    2460:	ff 25 b2 0d 01 00    	jmp    *0x10db2(%rip)        # 13218 <atoi@GLIBC_2.2.5>
    2466:	68 43 00 00 00       	push   $0x43
    246b:	e9 b0 fb ff ff       	jmp    2020 <_init+0x20>

0000000000002470 <sprintf@plt>:
    2470:	ff 25 aa 0d 01 00    	jmp    *0x10daa(%rip)        # 13220 <sprintf@GLIBC_2.2.5>
    2476:	68 44 00 00 00       	push   $0x44
    247b:	e9 a0 fb ff ff       	jmp    2020 <_init+0x20>

0000000000002480 <exit@plt>:
    2480:	ff 25 a2 0d 01 00    	jmp    *0x10da2(%rip)        # 13228 <exit@GLIBC_2.2.5>
    2486:	68 45 00 00 00       	push   $0x45
    248b:	e9 90 fb ff ff       	jmp    2020 <_init+0x20>

0000000000002490 <connect@plt>:
    2490:	ff 25 9a 0d 01 00    	jmp    *0x10d9a(%rip)        # 13230 <connect@GLIBC_2.2.5>
    2496:	68 46 00 00 00       	push   $0x46
    249b:	e9 80 fb ff ff       	jmp    2020 <_init+0x20>

00000000000024a0 <fwrite@plt>:
    24a0:	ff 25 92 0d 01 00    	jmp    *0x10d92(%rip)        # 13238 <fwrite@GLIBC_2.2.5>
    24a6:	68 47 00 00 00       	push   $0x47
    24ab:	e9 70 fb ff ff       	jmp    2020 <_init+0x20>

00000000000024b0 <getrlimit@plt>:
    24b0:	ff 25 8a 0d 01 00    	jmp    *0x10d8a(%rip)        # 13240 <getrlimit@GLIBC_2.2.5>
    24b6:	68 48 00 00 00       	push   $0x48
    24bb:	e9 60 fb ff ff       	jmp    2020 <_init+0x20>

00000000000024c0 <pthread_join@plt>:
    24c0:	ff 25 82 0d 01 00    	jmp    *0x10d82(%rip)        # 13248 <pthread_join@GLIBC_2.34>
    24c6:	68 49 00 00 00       	push   $0x49
    24cb:	e9 50 fb ff ff       	jmp    2020 <_init+0x20>

00000000000024d0 <sigaltstack@plt>:
    24d0:	ff 25 7a 0d 01 00    	jmp    *0x10d7a(%rip)        # 13250 <sigaltstack@GLIBC_2.2.5>
    24d6:	68 4a 00 00 00       	push   $0x4a
    24db:	e9 40 fb ff ff       	jmp    2020 <_init+0x20>

00000000000024e0 <fstat@plt>:
    24e0:	ff 25 72 0d 01 00    	jmp    *0x10d72(%rip)        # 13258 <fstat@GLIBC_2.33>
    24e6:	68 4b 00 00 00       	push   $0x4b
    24eb:	e9 30 fb ff ff       	jmp    2020 <_init+0x20>

00000000000024f0 <strstr@plt>:
    24f0:	ff 25 6a 0d 01 00    	jmp    *0x10d6a(%rip)        # 13260 <strstr@GLIBC_2.2.5>
    24f6:	68 4c 00 00 00       	push   $0x4c
    24fb:	e9 20 fb ff ff       	jmp    2020 <_init+0x20>

0000000000002500 <__ctype_b_loc@plt>:
    2500:	ff 25 62 0d 01 00    	jmp    *0x10d62(%rip)        # 13268 <__ctype_b_loc@GLIBC_2.3>
    2506:	68 4d 00 00 00       	push   $0x4d
    250b:	e9 10 fb ff ff       	jmp    2020 <_init+0x20>

0000000000002510 <socket@plt>:
    2510:	ff 25 5a 0d 01 00    	jmp    *0x10d5a(%rip)        # 13270 <socket@GLIBC_2.2.5>
    2516:	68 4e 00 00 00       	push   $0x4e
    251b:	e9 00 fb ff ff       	jmp    2020 <_init+0x20>

0000000000002520 <pthread_attr_setstacksize@plt>:
    2520:	ff 25 52 0d 01 00    	jmp    *0x10d52(%rip)        # 13278 <pthread_attr_setstacksize@GLIBC_2.34>
    2526:	68 4f 00 00 00       	push   $0x4f
    252b:	e9 f0 fa ff ff       	jmp    2020 <_init+0x20>

Disassembly of section .plt.got:

0000000000002530 <__cxa_finalize@plt>:
    2530:	ff 25 9a 0a 01 00    	jmp    *0x10a9a(%rip)        # 12fd0 <__cxa_finalize@GLIBC_2.2.5>
    2536:	66 90                	xchg   %ax,%ax

Disassembly of section .text:

0000000000002540 <_start>:
    2540:	f3 0f 1e fa          	endbr64
    2544:	31 ed                	xor    %ebp,%ebp
    2546:	49 89 d1             	mov    %rdx,%r9
    2549:	5e                   	pop    %rsi
    254a:	48 89 e2             	mov    %rsp,%rdx
    254d:	48 83 e4 f0          	and    $0xfffffffffffffff0,%rsp
    2551:	50                   	push   %rax
    2552:	54                   	push   %rsp
    2553:	45 31 c0             	xor    %r8d,%r8d
    2556:	31 c9                	xor    %ecx,%ecx
    2558:	48 8d 3d b1 02 00 00 	lea    0x2b1(%rip),%rdi        # 2810 <main>
    255f:	ff 15 3b 0a 01 00    	call   *0x10a3b(%rip)        # 12fa0 <__libc_start_main@GLIBC_2.34>
    2565:	f4                   	hlt
    2566:	66 2e 0f 1f 84 00 00 	cs nopw 0x0(%rax,%rax,1)
    256d:	00 00 00 

0000000000002570 <deregister_tm_clones>:
    2570:	48 8d 3d b9 27 01 00 	lea    0x127b9(%rip),%rdi        # 14d30 <__TMC_END__>
    2577:	48 8d 05 b2 27 01 00 	lea    0x127b2(%rip),%rax        # 14d30 <__TMC_END__>
    257e:	48 39 f8             	cmp    %rdi,%rax
    2581:	74 15                	je     2598 <deregister_tm_clones+0x28>
    2583:	48 8b 05 1e 0a 01 00 	mov    0x10a1e(%rip),%rax        # 12fa8 <_ITM_deregisterTMCloneTable@Base>
    258a:	48 85 c0             	test   %rax,%rax
    258d:	74 09                	je     2598 <deregister_tm_clones+0x28>
    258f:	ff e0                	jmp    *%rax
    2591:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)
    2598:	c3                   	ret
    2599:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)

00000000000025a0 <register_tm_clones>:
    25a0:	48 8d 3d 89 27 01 00 	lea    0x12789(%rip),%rdi        # 14d30 <__TMC_END__>
    25a7:	48 8d 35 82 27 01 00 	lea    0x12782(%rip),%rsi        # 14d30 <__TMC_END__>
    25ae:	48 29 fe             	sub    %rdi,%rsi
    25b1:	48 89 f0             	mov    %rsi,%rax
    25b4:	48 c1 ee 3f          	shr    $0x3f,%rsi
    25b8:	48 c1 f8 03          	sar    $0x3,%rax
    25bc:	48 01 c6             	add    %rax,%rsi
    25bf:	48 d1 fe             	sar    $1,%rsi
    25c2:	74 14                	je     25d8 <register_tm_clones+0x38>
    25c4:	48 8b 05 fd 09 01 00 	mov    0x109fd(%rip),%rax        # 12fc8 <_ITM_registerTMCloneTable@Base>
    25cb:	48 85 c0             	test   %rax,%rax
    25ce:	74 08                	je     25d8 <register_tm_clones+0x38>
    25d0:	ff e0                	jmp    *%rax
    25d2:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)
    25d8:	c3                   	ret
    25d9:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)

00000000000025e0 <__do_global_dtors_aux>:
    25e0:	f3 0f 1e fa          	endbr64
    25e4:	80 3d 45 27 01 00 00 	cmpb   $0x0,0x12745(%rip)        # 14d30 <__TMC_END__>
    25eb:	75 2b                	jne    2618 <__do_global_dtors_aux+0x38>
    25ed:	55                   	push   %rbp
    25ee:	48 83 3d da 09 01 00 	cmpq   $0x0,0x109da(%rip)        # 12fd0 <__cxa_finalize@GLIBC_2.2.5>
    25f5:	00 
    25f6:	48 89 e5             	mov    %rsp,%rbp
    25f9:	74 0c                	je     2607 <__do_global_dtors_aux+0x27>
    25fb:	48 8b 3d 86 0c 01 00 	mov    0x10c86(%rip),%rdi        # 13288 <__dso_handle>
    2602:	e8 29 ff ff ff       	call   2530 <__cxa_finalize@plt>
    2607:	e8 64 ff ff ff       	call   2570 <deregister_tm_clones>
    260c:	c6 05 1d 27 01 00 01 	movb   $0x1,0x1271d(%rip)        # 14d30 <__TMC_END__>
    2613:	5d                   	pop    %rbp
    2614:	c3                   	ret
    2615:	0f 1f 00             	nopl   (%rax)
    2618:	c3                   	ret
    2619:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)

0000000000002620 <frame_dummy>:
    2620:	f3 0f 1e fa          	endbr64
    2624:	e9 77 ff ff ff       	jmp    25a0 <register_tm_clones>
    2629:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)

0000000000002630 <original_main>:
    2630:	41 56                	push   %r14
    2632:	53                   	push   %rbx
    2633:	48 83 ec 58          	sub    $0x58,%rsp
    2637:	48 8d 05 02 03 01 00 	lea    0x10302(%rip),%rax        # 12940 <fwp_fn_table>
    263e:	48 89 05 fb 26 01 00 	mov    %rax,0x126fb(%rip)        # 14d40 <fwp_fns>
    2645:	4c 8b 35 64 09 01 00 	mov    0x10964(%rip),%r14        # 12fb0 <stdout@GLIBC_2.2.5>
    264c:	49 8b 06             	mov    (%r14),%rax
    264f:	48 89 05 f2 26 01 00 	mov    %rax,0x126f2(%rip)        # 14d48 <fwp_prog_out>
    2656:	89 3d f4 26 01 00    	mov    %edi,0x126f4(%rip)        # 14d50 <fwp_argc>
    265c:	48 89 35 f5 26 01 00 	mov    %rsi,0x126f5(%rip)        # 14d58 <fwp_argv>
    2663:	48 8d 35 f6 26 01 00 	lea    0x126f6(%rip),%rsi        # 14d60 <fwp_start_time>
    266a:	bf 01 00 00 00       	mov    $0x1,%edi
    266f:	e8 bc fa ff ff       	call   2130 <clock_gettime@plt>
    2674:	e8 b7 00 00 00       	call   2730 <fwp_seed_rng>
    2679:	49 8b 3e             	mov    (%r14),%rdi
    267c:	b9 00 00 01 00       	mov    $0x10000,%ecx
    2681:	31 f6                	xor    %esi,%esi
    2683:	31 d2                	xor    %edx,%edx
    2685:	e8 26 fd ff ff       	call   23b0 <setvbuf@plt>
    268a:	be 01 00 00 00       	mov    $0x1,%esi
    268f:	bf 0d 00 00 00       	mov    $0xd,%edi
    2694:	e8 47 fc ff ff       	call   22e0 <signal@plt>
    2699:	48 8d 5c 24 20       	lea    0x20(%rsp),%rbx
    269e:	48 89 df             	mov    %rbx,%rdi
    26a1:	e8 da fb ff ff       	call   2280 <pthread_attr_init@plt>
    26a6:	48 8b 35 e3 0b 01 00 	mov    0x10be3(%rip),%rsi        # 13290 <fwp_main_stack>
    26ad:	48 89 df             	mov    %rbx,%rdi
    26b0:	e8 6b fe ff ff       	call   2520 <pthread_attr_setstacksize@plt>
    26b5:	48 8d 15 d4 00 00 00 	lea    0xd4(%rip),%rdx        # 2790 <fwp_main_thread>
    26bc:	48 8d 7c 24 08       	lea    0x8(%rsp),%rdi
    26c1:	48 89 de             	mov    %rbx,%rsi
    26c4:	31 c9                	xor    %ecx,%ecx
    26c6:	e8 15 fd ff ff       	call   23e0 <pthread_create@plt>
    26cb:	85 c0                	test   %eax,%eax
    26cd:	74 35                	je     2704 <original_main+0xd4>
    26cf:	48 8d 74 24 10       	lea    0x10(%rsp),%rsi
    26d4:	bf 03 00 00 00       	mov    $0x3,%edi
    26d9:	e8 d2 fd ff ff       	call   24b0 <getrlimit@plt>
    26de:	48 8b 4c 24 10       	mov    0x10(%rsp),%rcx
    26e3:	48 83 f9 ff          	cmp    $0xffffffffffffffff,%rcx
    26e7:	ba 00 00 80 00       	mov    $0x800000,%edx
    26ec:	48 0f 44 ca          	cmove  %rdx,%rcx
    26f0:	85 c0                	test   %eax,%eax
    26f2:	48 0f 45 ca          	cmovne %rdx,%rcx
    26f6:	48 89 0d 93 0b 01 00 	mov    %rcx,0x10b93(%rip)        # 13290 <fwp_main_stack>
    26fd:	e8 8e 00 00 00       	call   2790 <fwp_main_thread>
    2702:	eb 0c                	jmp    2710 <original_main+0xe0>
    2704:	48 8b 7c 24 08       	mov    0x8(%rsp),%rdi
    2709:	31 f6                	xor    %esi,%esi
    270b:	e8 b0 fd ff ff       	call   24c0 <pthread_join@plt>
    2710:	49 8b 3e             	mov    (%r14),%rdi
    2713:	e8 38 fc ff ff       	call   2350 <fflush@plt>
    2718:	8b 05 52 26 01 00    	mov    0x12652(%rip),%eax        # 14d70 <fwp_exit_code>
    271e:	48 83 c4 58          	add    $0x58,%rsp
    2722:	5b                   	pop    %rbx
    2723:	41 5e                	pop    %r14
    2725:	c3                   	ret
    2726:	66 2e 0f 1f 84 00 00 	cs nopw 0x0(%rax,%rax,1)
    272d:	00 00 00 

0000000000002730 <fwp_seed_rng>:
    2730:	53                   	push   %rbx
    2731:	48 83 ec 20          	sub    $0x20,%rsp
    2735:	48 8d 3d fd b0 00 00 	lea    0xb0fd(%rip),%rdi        # d839 <exec_in_fp0+0x1f9>
    273c:	e8 ef f8 ff ff       	call   2030 <getenv@plt>
    2741:	48 85 c0             	test   %rax,%rax
    2744:	74 24                	je     276a <fwp_seed_rng+0x3a>
    2746:	48 89 c3             	mov    %rax,%rbx
    2749:	80 38 00             	cmpb   $0x0,(%rax)
    274c:	74 1c                	je     276a <fwp_seed_rng+0x3a>
    274e:	48 8d 74 24 08       	lea    0x8(%rsp),%rsi
    2753:	48 89 df             	mov    %rbx,%rdi
    2756:	ba 0a 00 00 00       	mov    $0xa,%edx
    275b:	e8 60 fb ff ff       	call   22c0 <strtoull@plt>
    2760:	48 8b 44 24 08       	mov    0x8(%rsp),%rax
    2765:	80 38 00             	cmpb   $0x0,(%rax)
    2768:	74 12                	je     277c <fwp_seed_rng+0x4c>
    276a:	48 8d 74 24 10       	lea    0x10(%rsp),%rsi
    276f:	31 ff                	xor    %edi,%edi
    2771:	e8 ba f9 ff ff       	call   2130 <clock_gettime@plt>
    2776:	48 83 c4 20          	add    $0x20,%rsp
    277a:	5b                   	pop    %rbx
    277b:	c3                   	ret
    277c:	0f b6 03             	movzbl (%rbx),%eax
    277f:	83 f8 2d             	cmp    $0x2d,%eax
    2782:	74 e6                	je     276a <fwp_seed_rng+0x3a>
    2784:	83 f8 2b             	cmp    $0x2b,%eax
    2787:	74 e1                	je     276a <fwp_seed_rng+0x3a>
    2789:	eb eb                	jmp    2776 <fwp_seed_rng+0x46>
    278b:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)

0000000000002790 <fwp_main_thread>:
    2790:	55                   	push   %rbp
    2791:	48 89 e5             	mov    %rsp,%rbp
    2794:	48 89 ef             	mov    %rbp,%rdi
    2797:	e8 e4 00 00 00       	call   2880 <fwp_gc_start>
    279c:	48 8b 3d ed 0a 01 00 	mov    0x10aed(%rip),%rdi        # 13290 <fwp_main_stack>
    27a3:	e8 18 31 00 00       	call   58c0 <fwp_stack_guard_init>
    27a8:	48 8b 05 e1 04 01 00 	mov    0x104e1(%rip),%rax        # 12c90 <exec_scripts+0x10>
    27af:	48 89 05 da 25 01 00 	mov    %rax,0x125da(%rip)        # 14d90 <fwp_cli_scripts+0x10>
    27b6:	0f 28 05 c3 04 01 00 	movaps 0x104c3(%rip),%xmm0        # 12c80 <exec_scripts>
    27bd:	0f 29 05 bc 25 01 00 	movaps %xmm0,0x125bc(%rip)        # 14d80 <fwp_cli_scripts>
    27c4:	48 8d 05 d5 ac 00 00 	lea    0xacd5(%rip),%rax        # d4a0 <exec_man>
    27cb:	48 89 05 c6 25 01 00 	mov    %rax,0x125c6(%rip)        # 14d98 <fwp_cli_man>
    27d2:	c6 05 c7 25 01 00 01 	movb   $0x1,0x125c7(%rip)        # 14da0 <fwp_cli_single>
    27d9:	8b 3d 71 25 01 00    	mov    0x12571(%rip),%edi        # 14d50 <fwp_argc>
    27df:	48 8b 35 72 25 01 00 	mov    0x12572(%rip),%rsi        # 14d58 <fwp_argv>
    27e6:	e8 b5 31 00 00       	call   59a0 <fwp_exec>
    27eb:	89 05 7f 25 01 00    	mov    %eax,0x1257f(%rip)        # 14d70 <fwp_exit_code>
    27f1:	48 8b 05 b8 07 01 00 	mov    0x107b8(%rip),%rax        # 12fb0 <stdout@GLIBC_2.2.5>
    27f8:	48 8b 38             	mov    (%rax),%rdi
    27fb:	e8 50 fb ff ff       	call   2350 <fflush@plt>
    2800:	31 c0                	xor    %eax,%eax
    2802:	5d                   	pop    %rbp
    2803:	c3                   	ret
    2804:	66 66 66 2e 0f 1f 84 	data16 data16 cs nopw 0x0(%rax,%rax,1)
    280b:	00 00 00 00 00 

0000000000002810 <main>:
    2810:	55                   	push   %rbp
    2811:	48 89 e5             	mov    %rsp,%rbp
    2814:	53                   	push   %rbx
    2815:	50                   	push   %rax
    2816:	48 89 ef             	mov    %rbp,%rdi
    2819:	e8 62 00 00 00       	call   2880 <fwp_gc_start>
    281e:	48 8d 05 1b 01 01 00 	lea    0x1011b(%rip),%rax        # 12940 <fwp_fn_table>
    2825:	48 89 05 14 25 01 00 	mov    %rax,0x12514(%rip)        # 14d40 <fwp_fns>
    282c:	f2 0f 10 05 d4 a7 00 	movsd  0xa7d4(%rip),%xmm0        # d008 <_IO_stdin_used+0x8>
    2833:	00 
    2834:	e8 17 01 00 00       	call   2950 <fwp_from_f64>
    2839:	48 89 c7             	mov    %rax,%rdi
    283c:	e8 ef 00 00 00       	call   2930 <f2>
    2841:	48 89 c3             	mov    %rax,%rbx
    2844:	f2 0f 10 05 c4 a7 00 	movsd  0xa7c4(%rip),%xmm0        # d010 <_IO_stdin_used+0x10>
    284b:	00 
    284c:	e8 ff 00 00 00       	call   2950 <fwp_from_f64>
    2851:	48 89 c1             	mov    %rax,%rcx
    2854:	b8 81 00 00 00       	mov    $0x81,%eax
    2859:	48 39 cb             	cmp    %rcx,%rbx
    285c:	75 0e                	jne    286c <main+0x5c>
    285e:	48 8d 3d eb ad 00 00 	lea    0xadeb(%rip),%rdi        # d650 <exec_in_fp0+0x10>
    2865:	e8 66 f8 ff ff       	call   20d0 <puts@plt>
    286a:	31 c0                	xor    %eax,%eax
    286c:	48 83 c4 08          	add    $0x8,%rsp
    2870:	5b                   	pop    %rbx
    2871:	5d                   	pop    %rbp
    2872:	c3                   	ret
    2873:	66 66 66 66 2e 0f 1f 	data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    287a:	84 00 00 00 00 00 

0000000000002880 <fwp_gc_start>:
    2880:	53                   	push   %rbx
    2881:	48 89 fb             	mov    %rdi,%rbx
    2884:	83 3d f9 19 01 00 00 	cmpl   $0x0,0x119f9(%rip)        # 14284 <fwp_gc+0xfec>
    288b:	75 05                	jne    2892 <fwp_gc_start+0x12>
    288d:	e8 1e 0e 00 00       	call   36b0 <fwp_gc_init>
    2892:	48 89 1d 87 1a 01 00 	mov    %rbx,0x11a87(%rip)        # 14320 <fwp_gc+0x1088>
    2899:	48 8d 3d 10 9f 00 00 	lea    0x9f10(%rip),%rdi        # c7b0 <fwp_gc_find_data>
    28a0:	31 f6                	xor    %esi,%esi
    28a2:	e8 99 f7 ff ff       	call   2040 <dl_iterate_phdr@plt>
    28a7:	83 3d da 19 01 00 00 	cmpl   $0x0,0x119da(%rip)        # 14288 <fwp_gc+0xff0>
    28ae:	0f 95 c1             	setne  %cl
    28b1:	83 3d 70 1b 01 00 00 	cmpl   $0x0,0x11b70(%rip)        # 14428 <fwp_gc+0x1190>
    28b8:	0f 9f c0             	setg   %al
    28bb:	20 c8                	and    %cl,%al
    28bd:	0f b6 c8             	movzbl %al,%ecx
    28c0:	89 0d c6 19 01 00    	mov    %ecx,0x119c6(%rip)        # 1428c <fwp_gc+0xff4>
    28c6:	83 3d c7 19 01 00 00 	cmpl   $0x0,0x119c7(%rip)        # 14294 <fwp_gc+0xffc>
    28cd:	74 16                	je     28e5 <fwp_gc_start+0x65>
    28cf:	48 8d 3d ba 9f 00 00 	lea    0x9fba(%rip),%rdi        # c890 <fwp_gc_report>
    28d6:	e8 a5 a3 00 00       	call   cc80 <atexit>
    28db:	83 3d aa 19 01 00 00 	cmpl   $0x0,0x119aa(%rip)        # 1428c <fwp_gc+0xff4>
    28e2:	0f 95 c0             	setne  %al
    28e5:	84 c0                	test   %al,%al
    28e7:	74 43                	je     292c <fwp_gc_start+0xac>
    28e9:	48 83 3d c7 19 01 00 	cmpq   $0x0,0x119c7(%rip)        # 142b8 <fwp_gc+0x1020>
    28f0:	00 
    28f1:	74 39                	je     292c <fwp_gc_start+0xac>
    28f3:	48 8b 05 ae 1b 01 00 	mov    0x11bae(%rip),%rax        # 144a8 <fwp_gc+0x1210>
    28fa:	48 2b 05 97 09 01 00 	sub    0x10997(%rip),%rax        # 13298 <fwp_gc>
    2901:	f2 48 0f 2a c0       	cvtsi2sd %rax,%xmm0
    2906:	f2 0f 58 05 72 1b 01 	addsd  0x11b72(%rip),%xmm0        # 14480 <fwp_gc+0x11e8>
    290d:	00 
    290e:	f2 0f 11 05 6a 1b 01 	movsd  %xmm0,0x11b6a(%rip)        # 14480 <fwp_gc+0x11e8>
    2915:	00 
    2916:	48 c7 05 87 1b 01 00 	movq   $0x0,0x11b87(%rip)        # 144a8 <fwp_gc+0x1210>
    291d:	00 00 00 00 
    2921:	48 c7 05 6c 09 01 00 	movq   $0x0,0x1096c(%rip)        # 13298 <fwp_gc>
    2928:	00 00 00 00 
    292c:	5b                   	pop    %rbx
    292d:	c3                   	ret
    292e:	66 90                	xchg   %ax,%ax

0000000000002930 <f2>:
    2930:	48 89 fe             	mov    %rdi,%rsi
    2933:	48 bf 00 00 00 00 00 	movabs $0x3fc0000000000000,%rdi
    293a:	00 c0 3f 
    293d:	e9 1e 2f 00 00       	jmp    5860 <f4>
    2942:	66 66 66 66 66 2e 0f 	data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    2949:	1f 84 00 00 00 00 00 

0000000000002950 <fwp_from_f64>:
    2950:	66 48 0f 7e c0       	movq   %xmm0,%rax
    2955:	c3                   	ret
    2956:	66 2e 0f 1f 84 00 00 	cs nopw 0x0(%rax,%rax,1)
    295d:	00 00 00 

0000000000002960 <e0>:
    2960:	50                   	push   %rax
    2961:	48 8b 3f             	mov    (%rdi),%rdi
    2964:	e8 a7 01 00 00       	call   2b10 <f0>
    2969:	48 89 c7             	mov    %rax,%rdi
    296c:	58                   	pop    %rax
    296d:	e9 8e 01 00 00       	jmp    2b00 <fwp_rc_shared>
    2972:	66 66 66 66 66 2e 0f 	data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    2979:	1f 84 00 00 00 00 00 

0000000000002980 <e1>:
    2980:	50                   	push   %rax
    2981:	48 8b 3f             	mov    (%rdi),%rdi
    2984:	e8 57 2e 00 00       	call   57e0 <f1>
    2989:	48 89 c7             	mov    %rax,%rdi
    298c:	58                   	pop    %rax
    298d:	e9 6e 01 00 00       	jmp    2b00 <fwp_rc_shared>
    2992:	66 66 66 66 66 2e 0f 	data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    2999:	1f 84 00 00 00 00 00 

00000000000029a0 <e2>:
    29a0:	50                   	push   %rax
    29a1:	48 8b 3f             	mov    (%rdi),%rdi
    29a4:	e8 87 ff ff ff       	call   2930 <f2>
    29a9:	48 89 c7             	mov    %rax,%rdi
    29ac:	58                   	pop    %rax
    29ad:	e9 4e 01 00 00       	jmp    2b00 <fwp_rc_shared>
    29b2:	66 66 66 66 66 2e 0f 	data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    29b9:	1f 84 00 00 00 00 00 

00000000000029c0 <e4>:
    29c0:	50                   	push   %rax
    29c1:	48 8b 07             	mov    (%rdi),%rax
    29c4:	48 8b 77 08          	mov    0x8(%rdi),%rsi
    29c8:	48 89 c7             	mov    %rax,%rdi
    29cb:	e8 90 2e 00 00       	call   5860 <f4>
    29d0:	48 89 c7             	mov    %rax,%rdi
    29d3:	58                   	pop    %rax
    29d4:	e9 27 01 00 00       	jmp    2b00 <fwp_rc_shared>
    29d9:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)

00000000000029e0 <e8>:
    29e0:	50                   	push   %rax
    29e1:	48 8b 3f             	mov    (%rdi),%rdi
    29e4:	e8 a7 2e 00 00       	call   5890 <f8>
    29e9:	48 89 c7             	mov    %rax,%rdi
    29ec:	58                   	pop    %rax
    29ed:	e9 0e 01 00 00       	jmp    2b00 <fwp_rc_shared>
    29f2:	66 66 66 66 66 2e 0f 	data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    29f9:	1f 84 00 00 00 00 00 

0000000000002a00 <e10>:
    2a00:	50                   	push   %rax
    2a01:	48 8b 07             	mov    (%rdi),%rax
    2a04:	48 8b 77 08          	mov    0x8(%rdi),%rsi
    2a08:	48 89 c7             	mov    %rax,%rdi
    2a0b:	e8 30 08 00 00       	call   3240 <f10>
    2a10:	48 89 c7             	mov    %rax,%rdi
    2a13:	58                   	pop    %rax
    2a14:	e9 e7 00 00 00       	jmp    2b00 <fwp_rc_shared>
    2a19:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)

0000000000002a20 <e12>:
    2a20:	50                   	push   %rax
    2a21:	48 8b 07             	mov    (%rdi),%rax
    2a24:	48 8b 77 08          	mov    0x8(%rdi),%rsi
    2a28:	48 89 c7             	mov    %rax,%rdi
    2a2b:	e8 30 08 00 00       	call   3260 <f12>
    2a30:	48 89 c7             	mov    %rax,%rdi
    2a33:	58                   	pop    %rax
    2a34:	e9 c7 00 00 00       	jmp    2b00 <fwp_rc_shared>
    2a39:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)

0000000000002a40 <e14>:
    2a40:	50                   	push   %rax
    2a41:	48 8b 07             	mov    (%rdi),%rax
    2a44:	48 8b 77 08          	mov    0x8(%rdi),%rsi
    2a48:	48 89 c7             	mov    %rax,%rdi
    2a4b:	e8 40 08 00 00       	call   3290 <f14>
    2a50:	48 89 c7             	mov    %rax,%rdi
    2a53:	58                   	pop    %rax
    2a54:	e9 a7 00 00 00       	jmp    2b00 <fwp_rc_shared>
    2a59:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)

0000000000002a60 <e16>:
    2a60:	50                   	push   %rax
    2a61:	48 8b 07             	mov    (%rdi),%rax
    2a64:	48 8b 77 08          	mov    0x8(%rdi),%rsi
    2a68:	48 89 c7             	mov    %rax,%rdi
    2a6b:	e8 50 08 00 00       	call   32c0 <f16>
    2a70:	48 89 c7             	mov    %rax,%rdi
    2a73:	58                   	pop    %rax
    2a74:	e9 87 00 00 00       	jmp    2b00 <fwp_rc_shared>
    2a79:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)

0000000000002a80 <e18>:
    2a80:	50                   	push   %rax
    2a81:	48 8b 07             	mov    (%rdi),%rax
    2a84:	48 8b 77 08          	mov    0x8(%rdi),%rsi
    2a88:	48 89 c7             	mov    %rax,%rdi
    2a8b:	e8 70 08 00 00       	call   3300 <f18>
    2a90:	48 89 c7             	mov    %rax,%rdi
    2a93:	58                   	pop    %rax
    2a94:	eb 6a                	jmp    2b00 <fwp_rc_shared>
    2a96:	66 2e 0f 1f 84 00 00 	cs nopw 0x0(%rax,%rax,1)
    2a9d:	00 00 00 

0000000000002aa0 <e20>:
    2aa0:	50                   	push   %rax
    2aa1:	48 8b 07             	mov    (%rdi),%rax
    2aa4:	48 8b 77 08          	mov    0x8(%rdi),%rsi
    2aa8:	48 89 c7             	mov    %rax,%rdi
    2aab:	e8 a0 08 00 00       	call   3350 <f20>
    2ab0:	48 89 c7             	mov    %rax,%rdi
    2ab3:	58                   	pop    %rax
    2ab4:	eb 4a                	jmp    2b00 <fwp_rc_shared>
    2ab6:	66 2e 0f 1f 84 00 00 	cs nopw 0x0(%rax,%rax,1)
    2abd:	00 00 00 

0000000000002ac0 <e22>:
    2ac0:	50                   	push   %rax
    2ac1:	48 8b 07             	mov    (%rdi),%rax
    2ac4:	48 8b 77 08          	mov    0x8(%rdi),%rsi
    2ac8:	48 89 c7             	mov    %rax,%rdi
    2acb:	e8 d0 08 00 00       	call   33a0 <f22>
    2ad0:	48 89 c7             	mov    %rax,%rdi
    2ad3:	58                   	pop    %rax
    2ad4:	eb 2a                	jmp    2b00 <fwp_rc_shared>
    2ad6:	66 2e 0f 1f 84 00 00 	cs nopw 0x0(%rax,%rax,1)
    2add:	00 00 00 

0000000000002ae0 <e24>:
    2ae0:	50                   	push   %rax
    2ae1:	48 8b 07             	mov    (%rdi),%rax
    2ae4:	48 8b 77 08          	mov    0x8(%rdi),%rsi
    2ae8:	48 89 c7             	mov    %rax,%rdi
    2aeb:	e8 10 09 00 00       	call   3400 <f24>
    2af0:	48 89 c7             	mov    %rax,%rdi
    2af3:	58                   	pop    %rax
    2af4:	eb 0a                	jmp    2b00 <fwp_rc_shared>
    2af6:	66 2e 0f 1f 84 00 00 	cs nopw 0x0(%rax,%rax,1)
    2afd:	00 00 00 

0000000000002b00 <fwp_rc_shared>:
    2b00:	53                   	push   %rbx
    2b01:	48 89 fb             	mov    %rdi,%rbx
    2b04:	e8 97 00 00 00       	call   2ba0 <fwp_rc_share>
    2b09:	48 89 d8             	mov    %rbx,%rax
    2b0c:	5b                   	pop    %rbx
    2b0d:	c3                   	ret
    2b0e:	66 90                	xchg   %ax,%ax

0000000000002b10 <f0>:
    2b10:	41 56                	push   %r14
    2b12:	53                   	push   %rbx
    2b13:	48 81 ec 98 00 00 00 	sub    $0x98,%rsp
    2b1a:	48 89 fe             	mov    %rdi,%rsi
    2b1d:	48 8d 5c 24 40       	lea    0x40(%rsp),%rbx
    2b22:	48 89 df             	mov    %rbx,%rdi
    2b25:	e8 36 03 00 00       	call   2e60 <w0>
    2b2a:	0f 28 44 24 40       	movaps 0x40(%rsp),%xmm0
    2b2f:	0f 28 4c 24 50       	movaps 0x50(%rsp),%xmm1
    2b34:	0f 28 54 24 60       	movaps 0x60(%rsp),%xmm2
    2b39:	0f 28 5c 24 70       	movaps 0x70(%rsp),%xmm3
    2b3e:	0f 29 04 24          	movaps %xmm0,(%rsp)
    2b42:	0f 29 4c 24 10       	movaps %xmm1,0x10(%rsp)
    2b47:	0f 29 54 24 20       	movaps %xmm2,0x20(%rsp)
    2b4c:	0f 29 5c 24 30       	movaps %xmm3,0x30(%rsp)
    2b51:	48 8d 35 18 06 00 00 	lea    0x618(%rip),%rsi        # 3170 <fwp_owner_release7>
    2b58:	4c 8d b4 24 80 00 00 	lea    0x80(%rsp),%r14
    2b5f:	00 
    2b60:	48 89 e2             	mov    %rsp,%rdx
    2b63:	4c 89 f7             	mov    %r14,%rdi
    2b66:	e8 e5 05 00 00       	call   3150 <fwp_cleanup_push>
    2b6b:	bf 08 00 00 00       	mov    $0x8,%edi
    2b70:	48 89 de             	mov    %rbx,%rsi
    2b73:	e8 88 06 00 00       	call   3200 <fwp_record>
    2b78:	48 89 c3             	mov    %rax,%rbx
    2b7b:	48 89 c7             	mov    %rax,%rdi
    2b7e:	e8 3d 06 00 00       	call   31c0 <fwp_rc_fresh>
    2b83:	4c 89 f7             	mov    %r14,%rdi
    2b86:	e8 95 06 00 00       	call   3220 <fwp_cleanup_pop>
    2b8b:	48 89 d8             	mov    %rbx,%rax
    2b8e:	48 81 c4 98 00 00 00 	add    $0x98,%rsp
    2b95:	5b                   	pop    %rbx
    2b96:	41 5e                	pop    %r14
    2b98:	c3                   	ret
    2b99:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)

0000000000002ba0 <fwp_rc_share>:
    2ba0:	41 57                	push   %r15
    2ba2:	41 56                	push   %r14
    2ba4:	41 55                	push   %r13
    2ba6:	41 54                	push   %r12
    2ba8:	53                   	push   %rbx
    2ba9:	48 81 ec 00 02 00 00 	sub    $0x200,%rsp
    2bb0:	48 89 fb             	mov    %rdi,%rbx
    2bb3:	e8 08 01 00 00       	call   2cc0 <fwp_rc_slot>
    2bb8:	48 85 c0             	test   %rax,%rax
    2bbb:	0f 84 ec 00 00 00    	je     2cad <fwp_rc_share+0x10d>
    2bc1:	80 38 00             	cmpb   $0x0,(%rax)
    2bc4:	0f 84 e3 00 00 00    	je     2cad <fwp_rc_share+0x10d>
    2bca:	48 89 c7             	mov    %rax,%rdi
    2bcd:	e8 5e 01 00 00       	call   2d30 <fwp_rc_clear_slot>
    2bd2:	48 89 1c 24          	mov    %rbx,(%rsp)
    2bd6:	41 be 01 00 00 00    	mov    $0x1,%r14d
    2bdc:	eb 0b                	jmp    2be9 <fwp_rc_share+0x49>
    2bde:	66 90                	xchg   %ax,%ax
    2be0:	4d 85 f6             	test   %r14,%r14
    2be3:	0f 84 c4 00 00 00    	je     2cad <fwp_rc_share+0x10d>
    2be9:	4e 8b 7c f4 f8       	mov    -0x8(%rsp,%r14,8),%r15
    2bee:	49 ff ce             	dec    %r14
    2bf1:	4c 89 ff             	mov    %r15,%rdi
    2bf4:	48 2b 3d cd 16 01 00 	sub    0x116cd(%rip),%rdi        # 142c8 <fwp_gc+0x1030>
    2bfb:	48 c1 ef 10          	shr    $0x10,%rdi
    2bff:	48 8b 05 0a 17 01 00 	mov    0x1170a(%rip),%rax        # 14310 <fwp_gc+0x1078>
    2c06:	48 69 cf 28 12 00 00 	imul   $0x1228,%rdi,%rcx
    2c0d:	80 7c 08 01 01       	cmpb   $0x1,0x1(%rax,%rcx,1)
    2c12:	74 cc                	je     2be0 <fwp_rc_share+0x40>
    2c14:	0f b6 14 08          	movzbl (%rax,%rcx,1),%edx
    2c18:	80 fa 02             	cmp    $0x2,%dl
    2c1b:	75 13                	jne    2c30 <fwp_rc_share+0x90>
    2c1d:	4c 8b 64 08 18       	mov    0x18(%rax,%rcx,1),%r12
    2c22:	eb 33                	jmp    2c57 <fwp_rc_share+0xb7>
    2c24:	66 66 66 2e 0f 1f 84 	data16 data16 cs nopw 0x0(%rax,%rax,1)
    2c2b:	00 00 00 00 00 
    2c30:	44 8b 64 08 08       	mov    0x8(%rax,%rcx,1),%r12d
    2c35:	80 fa 01             	cmp    $0x1,%dl
    2c38:	75 1d                	jne    2c57 <fwp_rc_share+0xb7>
    2c3a:	41 0f b7 d7          	movzwl %r15w,%edx
    2c3e:	44 8b 7c 08 20       	mov    0x20(%rax,%rcx,1),%r15d
    2c43:	4c 0f af fa          	imul   %rdx,%r15
    2c47:	49 c1 ef 20          	shr    $0x20,%r15
    2c4b:	e8 00 01 00 00       	call   2d50 <fwp_gc_chunk_addr>
    2c50:	4d 0f af fc          	imul   %r12,%r15
    2c54:	49 01 c7             	add    %rax,%r15
    2c57:	49 83 fc 08          	cmp    $0x8,%r12
    2c5b:	72 83                	jb     2be0 <fwp_rc_share+0x40>
    2c5d:	49 c1 ec 03          	shr    $0x3,%r12
    2c61:	45 31 ed             	xor    %r13d,%r13d
    2c64:	eb 16                	jmp    2c7c <fwp_rc_share+0xdc>
    2c66:	48 89 df             	mov    %rbx,%rdi
    2c69:	e8 32 ff ff ff       	call   2ba0 <fwp_rc_share>
    2c6e:	66 90                	xchg   %ax,%ax
    2c70:	49 ff c5             	inc    %r13
    2c73:	4d 39 ec             	cmp    %r13,%r12
    2c76:	0f 84 64 ff ff ff    	je     2be0 <fwp_rc_share+0x40>
    2c7c:	4b 8b 1c ef          	mov    (%r15,%r13,8),%rbx
    2c80:	48 89 df             	mov    %rbx,%rdi
    2c83:	e8 38 00 00 00       	call   2cc0 <fwp_rc_slot>
    2c88:	48 85 c0             	test   %rax,%rax
    2c8b:	74 e3                	je     2c70 <fwp_rc_share+0xd0>
    2c8d:	80 38 00             	cmpb   $0x0,(%rax)
    2c90:	74 de                	je     2c70 <fwp_rc_share+0xd0>
    2c92:	49 83 fe 3f          	cmp    $0x3f,%r14
    2c96:	77 ce                	ja     2c66 <fwp_rc_share+0xc6>
    2c98:	48 89 c7             	mov    %rax,%rdi
    2c9b:	e8 90 00 00 00       	call   2d30 <fwp_rc_clear_slot>
    2ca0:	4b 8b 04 ef          	mov    (%r15,%r13,8),%rax
    2ca4:	4a 89 04 f4          	mov    %rax,(%rsp,%r14,8)
    2ca8:	49 ff c6             	inc    %r14
    2cab:	eb c3                	jmp    2c70 <fwp_rc_share+0xd0>
    2cad:	48 81 c4 00 02 00 00 	add    $0x200,%rsp
    2cb4:	5b                   	pop    %rbx
    2cb5:	41 5c                	pop    %r12
    2cb7:	41 5d                	pop    %r13
    2cb9:	41 5e                	pop    %r14
    2cbb:	41 5f                	pop    %r15
    2cbd:	c3                   	ret
    2cbe:	66 90                	xchg   %ax,%ax

0000000000002cc0 <fwp_rc_slot>:
    2cc0:	48 2b 3d 01 16 01 00 	sub    0x11601(%rip),%rdi        # 142c8 <fwp_gc+0x1030>
    2cc7:	48 8b 05 22 16 01 00 	mov    0x11622(%rip),%rax        # 142f0 <fwp_gc+0x1058>
    2cce:	48 c1 e0 10          	shl    $0x10,%rax
    2cd2:	48 39 c7             	cmp    %rax,%rdi
    2cd5:	73 51                	jae    2d28 <fwp_rc_slot+0x68>
    2cd7:	48 8b 05 32 16 01 00 	mov    0x11632(%rip),%rax        # 14310 <fwp_gc+0x1078>
    2cde:	48 89 f9             	mov    %rdi,%rcx
    2ce1:	48 c1 e9 10          	shr    $0x10,%rcx
    2ce5:	48 69 c9 28 12 00 00 	imul   $0x1228,%rcx,%rcx
    2cec:	0f b6 14 08          	movzbl (%rax,%rcx,1),%edx
    2cf0:	48 81 e7 ff ff 00 00 	and    $0xffff,%rdi
    2cf7:	75 0f                	jne    2d08 <fwp_rc_slot+0x48>
    2cf9:	80 fa 02             	cmp    $0x2,%dl
    2cfc:	75 0a                	jne    2d08 <fwp_rc_slot+0x48>
    2cfe:	48 01 c8             	add    %rcx,%rax
    2d01:	48 05 28 02 00 00    	add    $0x228,%rax
    2d07:	c3                   	ret
    2d08:	80 fa 01             	cmp    $0x1,%dl
    2d0b:	75 1b                	jne    2d28 <fwp_rc_slot+0x68>
    2d0d:	48 8d 14 08          	lea    (%rax,%rcx,1),%rdx
    2d11:	8b 44 08 20          	mov    0x20(%rax,%rcx,1),%eax
    2d15:	48 0f af f8          	imul   %rax,%rdi
    2d19:	48 c1 ef 20          	shr    $0x20,%rdi
    2d1d:	48 8d 04 17          	lea    (%rdi,%rdx,1),%rax
    2d21:	48 05 28 02 00 00    	add    $0x228,%rax
    2d27:	c3                   	ret
    2d28:	31 c0                	xor    %eax,%eax
    2d2a:	c3                   	ret
    2d2b:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)

0000000000002d30 <fwp_rc_clear_slot>:
    2d30:	80 3f ff             	cmpb   $0xff,(%rdi)
    2d33:	74 04                	je     2d39 <fwp_rc_clear_slot+0x9>
    2d35:	c6 07 00             	movb   $0x0,(%rdi)
    2d38:	c3                   	ret
    2d39:	53                   	push   %rbx
    2d3a:	48 89 fb             	mov    %rdi,%rbx
    2d3d:	e8 1e 00 00 00       	call   2d60 <fwp_rc_forget_slot>
    2d42:	48 89 df             	mov    %rbx,%rdi
    2d45:	5b                   	pop    %rbx
    2d46:	c6 07 00             	movb   $0x0,(%rdi)
    2d49:	c3                   	ret
    2d4a:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)

0000000000002d50 <fwp_gc_chunk_addr>:
    2d50:	48 89 f8             	mov    %rdi,%rax
    2d53:	48 c1 e0 10          	shl    $0x10,%rax
    2d57:	48 03 05 6a 15 01 00 	add    0x1156a(%rip),%rax        # 142c8 <fwp_gc+0x1030>
    2d5e:	c3                   	ret
    2d5f:	90                   	nop

0000000000002d60 <fwp_rc_forget_slot>:
    2d60:	50                   	push   %rax
    2d61:	80 3f ff             	cmpb   $0xff,(%rdi)
    2d64:	74 02                	je     2d68 <fwp_rc_forget_slot+0x8>
    2d66:	58                   	pop    %rax
    2d67:	c3                   	ret
    2d68:	e8 33 00 00 00       	call   2da0 <fwp_rc_wide_link>
    2d6d:	48 8b 38             	mov    (%rax),%rdi
    2d70:	48 85 ff             	test   %rdi,%rdi
    2d73:	74 15                	je     2d8a <fwp_rc_forget_slot+0x2a>
    2d75:	48 8b 4f 10          	mov    0x10(%rdi),%rcx
    2d79:	48 89 08             	mov    %rcx,(%rax)
    2d7c:	e8 cf f2 ff ff       	call   2050 <free@plt>
    2d81:	48 ff 0d 28 1f 01 00 	decq   0x11f28(%rip)        # 14cb0 <fwp_gc+0x1a18>
    2d88:	58                   	pop    %rax
    2d89:	c3                   	ret
    2d8a:	48 8d 3d 52 a9 00 00 	lea    0xa952(%rip),%rdi        # d6e3 <exec_in_fp0+0xa3>
    2d91:	e8 6a 00 00 00       	call   2e00 <fwp_trap>
    2d96:	66 2e 0f 1f 84 00 00 	cs nopw 0x0(%rax,%rax,1)
    2d9d:	00 00 00 

0000000000002da0 <fwp_rc_wide_link>:
    2da0:	48 89 f8             	mov    %rdi,%rax
    2da3:	48 c1 e8 11          	shr    $0x11,%rax
    2da7:	31 f8                	xor    %edi,%eax
    2da9:	89 c1                	mov    %eax,%ecx
    2dab:	c1 e9 09             	shr    $0x9,%ecx
    2dae:	31 c1                	xor    %eax,%ecx
    2db0:	0f b6 c9             	movzbl %cl,%ecx
    2db3:	48 8d 15 de 04 01 00 	lea    0x104de(%rip),%rdx        # 13298 <fwp_gc>
    2dba:	48 8d 04 ca          	lea    (%rdx,%rcx,8),%rax
    2dbe:	48 05 18 12 00 00    	add    $0x1218,%rax
    2dc4:	48 8b 8c ca 18 12 00 	mov    0x1218(%rdx,%rcx,8),%rcx
    2dcb:	00 
    2dcc:	48 85 c9             	test   %rcx,%rcx
    2dcf:	74 24                	je     2df5 <fwp_rc_wide_link+0x55>
    2dd1:	48 39 39             	cmp    %rdi,(%rcx)
    2dd4:	74 1f                	je     2df5 <fwp_rc_wide_link+0x55>
    2dd6:	66 2e 0f 1f 84 00 00 	cs nopw 0x0(%rax,%rax,1)
    2ddd:	00 00 00 
    2de0:	48 89 c8             	mov    %rcx,%rax
    2de3:	48 8b 49 10          	mov    0x10(%rcx),%rcx
    2de7:	48 85 c9             	test   %rcx,%rcx
    2dea:	74 05                	je     2df1 <fwp_rc_wide_link+0x51>
    2dec:	48 39 39             	cmp    %rdi,(%rcx)
    2def:	75 ef                	jne    2de0 <fwp_rc_wide_link+0x40>
    2df1:	48 83 c0 10          	add    $0x10,%rax
    2df5:	c3                   	ret
    2df6:	66 2e 0f 1f 84 00 00 	cs nopw 0x0(%rax,%rax,1)
    2dfd:	00 00 00 

0000000000002e00 <fwp_trap>:
    2e00:	53                   	push   %rbx
    2e01:	48 89 fb             	mov    %rdi,%rbx
    2e04:	e8 27 00 00 00       	call   2e30 <fwp_flush>
    2e09:	48 8b 05 c8 01 01 00 	mov    0x101c8(%rip),%rax        # 12fd8 <stderr@GLIBC_2.2.5>
    2e10:	48 8b 38             	mov    (%rax),%rdi
    2e13:	48 8d 35 f0 a8 00 00 	lea    0xa8f0(%rip),%rsi        # d70a <exec_in_fp0+0xca>
    2e1a:	48 89 da             	mov    %rbx,%rdx
    2e1d:	31 c0                	xor    %eax,%eax
    2e1f:	e8 cc f4 ff ff       	call   22f0 <fprintf@plt>
    2e24:	bf 65 00 00 00       	mov    $0x65,%edi
    2e29:	e8 52 f6 ff ff       	call   2480 <exit@plt>
    2e2e:	66 90                	xchg   %ax,%ax

0000000000002e30 <fwp_flush>:
    2e30:	50                   	push   %rax
    2e31:	48 8b 3d 10 1f 01 00 	mov    0x11f10(%rip),%rdi        # 14d48 <fwp_prog_out>
    2e38:	48 85 ff             	test   %rdi,%rdi
    2e3b:	74 05                	je     2e42 <fwp_flush+0x12>
    2e3d:	e8 0e f5 ff ff       	call   2350 <fflush@plt>
    2e42:	48 8b 05 67 01 01 00 	mov    0x10167(%rip),%rax        # 12fb0 <stdout@GLIBC_2.2.5>
    2e49:	48 8b 38             	mov    (%rax),%rdi
    2e4c:	58                   	pop    %rax
    2e4d:	e9 fe f4 ff ff       	jmp    2350 <fflush@plt>
    2e52:	66 66 66 66 66 2e 0f 	data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    2e59:	1f 84 00 00 00 00 00 

0000000000002e60 <w0>:
    2e60:	55                   	push   %rbp
    2e61:	41 57                	push   %r15
    2e63:	41 56                	push   %r14
    2e65:	41 55                	push   %r13
    2e67:	41 54                	push   %r12
    2e69:	53                   	push   %rbx
    2e6a:	48 81 ec b8 01 00 00 	sub    $0x1b8,%rsp
    2e71:	49 89 f6             	mov    %rsi,%r14
    2e74:	48 89 7c 24 28       	mov    %rdi,0x28(%rsp)
    2e79:	48 89 f7             	mov    %rsi,%rdi
    2e7c:	48 c7 c6 80 ff ff ff 	mov    $0xffffffffffffff80,%rsi
    2e83:	e8 b8 03 00 00       	call   3240 <f10>
    2e88:	48 89 44 24 30       	mov    %rax,0x30(%rsp)
    2e8d:	49 89 c7             	mov    %rax,%r15
    2e90:	48 8d 35 b9 03 00 00 	lea    0x3b9(%rip),%rsi        # 3250 <fwp_owner_release0>
    2e97:	4c 8d ac 24 a0 01 00 	lea    0x1a0(%rsp),%r13
    2e9e:	00 
    2e9f:	48 8d 54 24 30       	lea    0x30(%rsp),%rdx
    2ea4:	4c 89 ef             	mov    %r13,%rdi
    2ea7:	e8 a4 02 00 00       	call   3150 <fwp_cleanup_push>
    2eac:	be ff 00 00 00       	mov    $0xff,%esi
    2eb1:	4c 89 f7             	mov    %r14,%rdi
    2eb4:	e8 a7 03 00 00       	call   3260 <f12>
    2eb9:	49 89 c4             	mov    %rax,%r12
    2ebc:	4c 89 ef             	mov    %r13,%rdi
    2ebf:	e8 5c 03 00 00       	call   3220 <fwp_cleanup_pop>
    2ec4:	4c 89 7c 24 38       	mov    %r15,0x38(%rsp)
    2ec9:	4c 89 64 24 40       	mov    %r12,0x40(%rsp)
    2ece:	48 8d 35 9b 03 00 00 	lea    0x39b(%rip),%rsi        # 3270 <fwp_owner_release1>
    2ed5:	4c 8d ac 24 88 01 00 	lea    0x188(%rsp),%r13
    2edc:	00 
    2edd:	48 8d 54 24 38       	lea    0x38(%rsp),%rdx
    2ee2:	4c 89 ef             	mov    %r13,%rdi
    2ee5:	e8 66 02 00 00       	call   3150 <fwp_cleanup_push>
    2eea:	4c 89 f7             	mov    %r14,%rdi
    2eed:	48 c7 c6 00 80 ff ff 	mov    $0xffffffffffff8000,%rsi
    2ef4:	e8 97 03 00 00       	call   3290 <f14>
    2ef9:	48 89 c5             	mov    %rax,%rbp
    2efc:	4c 89 ef             	mov    %r13,%rdi
    2eff:	e8 1c 03 00 00       	call   3220 <fwp_cleanup_pop>
    2f04:	4c 89 7c 24 48       	mov    %r15,0x48(%rsp)
    2f09:	4c 89 64 24 50       	mov    %r12,0x50(%rsp)
    2f0e:	48 89 6c 24 58       	mov    %rbp,0x58(%rsp)
    2f13:	48 8d 35 86 03 00 00 	lea    0x386(%rip),%rsi        # 32a0 <fwp_owner_release2>
    2f1a:	48 8d 9c 24 70 01 00 	lea    0x170(%rsp),%rbx
    2f21:	00 
    2f22:	48 8d 54 24 48       	lea    0x48(%rsp),%rdx
    2f27:	48 89 df             	mov    %rbx,%rdi
    2f2a:	e8 21 02 00 00       	call   3150 <fwp_cleanup_push>
    2f2f:	be ff ff 00 00       	mov    $0xffff,%esi
    2f34:	4c 89 f7             	mov    %r14,%rdi
    2f37:	e8 84 03 00 00       	call   32c0 <f16>
    2f3c:	49 89 c5             	mov    %rax,%r13
    2f3f:	48 89 df             	mov    %rbx,%rdi
    2f42:	e8 d9 02 00 00       	call   3220 <fwp_cleanup_pop>
    2f47:	4c 89 7c 24 60       	mov    %r15,0x60(%rsp)
    2f4c:	4c 89 3c 24          	mov    %r15,(%rsp)
    2f50:	4c 89 64 24 68       	mov    %r12,0x68(%rsp)
    2f55:	4c 89 e3             	mov    %r12,%rbx
    2f58:	4c 89 64 24 10       	mov    %r12,0x10(%rsp)
    2f5d:	48 89 6c 24 70       	mov    %rbp,0x70(%rsp)
    2f62:	48 89 6c 24 18       	mov    %rbp,0x18(%rsp)
    2f67:	4c 89 6c 24 78       	mov    %r13,0x78(%rsp)
    2f6c:	48 8d 35 5d 03 00 00 	lea    0x35d(%rip),%rsi        # 32d0 <fwp_owner_release3>
    2f73:	48 8d bc 24 40 01 00 	lea    0x140(%rsp),%rdi
    2f7a:	00 
    2f7b:	48 8d 54 24 60       	lea    0x60(%rsp),%rdx
    2f80:	e8 cb 01 00 00       	call   3150 <fwp_cleanup_push>
    2f85:	4c 89 f7             	mov    %r14,%rdi
    2f88:	48 c7 c6 00 00 00 80 	mov    $0xffffffff80000000,%rsi
    2f8f:	e8 6c 03 00 00       	call   3300 <f18>
    2f94:	49 89 c4             	mov    %rax,%r12
    2f97:	48 89 44 24 08       	mov    %rax,0x8(%rsp)
    2f9c:	48 8d bc 24 40 01 00 	lea    0x140(%rsp),%rdi
    2fa3:	00 
    2fa4:	e8 77 02 00 00       	call   3220 <fwp_cleanup_pop>
    2fa9:	4c 89 bc 24 80 00 00 	mov    %r15,0x80(%rsp)
    2fb0:	00 
    2fb1:	48 89 9c 24 88 00 00 	mov    %rbx,0x88(%rsp)
    2fb8:	00 
    2fb9:	48 89 ac 24 90 00 00 	mov    %rbp,0x90(%rsp)
    2fc0:	00 
    2fc1:	4c 89 ac 24 98 00 00 	mov    %r13,0x98(%rsp)
    2fc8:	00 
    2fc9:	4c 89 a4 24 a0 00 00 	mov    %r12,0xa0(%rsp)
    2fd0:	00 
    2fd1:	48 8d 35 38 03 00 00 	lea    0x338(%rip),%rsi        # 3310 <fwp_owner_release4>
    2fd8:	4c 8d a4 24 58 01 00 	lea    0x158(%rsp),%r12
    2fdf:	00 
    2fe0:	48 8d 94 24 80 00 00 	lea    0x80(%rsp),%rdx
    2fe7:	00 
    2fe8:	4c 89 e7             	mov    %r12,%rdi
    2feb:	e8 60 01 00 00       	call   3150 <fwp_cleanup_push>
    2ff0:	b8 00 00 00 80       	mov    $0x80000000,%eax
    2ff5:	48 8d b0 ff ff ff 7f 	lea    0x7fffffff(%rax),%rsi
    2ffc:	4c 89 f7             	mov    %r14,%rdi
    2fff:	4c 89 f3             	mov    %r14,%rbx
    3002:	4c 89 74 24 20       	mov    %r14,0x20(%rsp)
    3007:	e8 44 03 00 00       	call   3350 <f20>
    300c:	49 89 c7             	mov    %rax,%r15
    300f:	4c 89 e7             	mov    %r12,%rdi
    3012:	e8 09 02 00 00       	call   3220 <fwp_cleanup_pop>
    3017:	48 8b 04 24          	mov    (%rsp),%rax
    301b:	48 89 84 24 a8 00 00 	mov    %rax,0xa8(%rsp)
    3022:	00 
    3023:	48 8b 6c 24 10       	mov    0x10(%rsp),%rbp
    3028:	48 89 ac 24 b0 00 00 	mov    %rbp,0xb0(%rsp)
    302f:	00 
    3030:	4c 8b 64 24 18       	mov    0x18(%rsp),%r12
    3035:	4c 89 a4 24 b8 00 00 	mov    %r12,0xb8(%rsp)
    303c:	00 
    303d:	4c 89 ac 24 c0 00 00 	mov    %r13,0xc0(%rsp)
    3044:	00 
    3045:	4c 8b 74 24 08       	mov    0x8(%rsp),%r14
    304a:	4c 89 b4 24 c8 00 00 	mov    %r14,0xc8(%rsp)
    3051:	00 
    3052:	4c 89 bc 24 d0 00 00 	mov    %r15,0xd0(%rsp)
    3059:	00 
    305a:	48 8d 35 ff 02 00 00 	lea    0x2ff(%rip),%rsi        # 3360 <fwp_owner_release5>
    3061:	48 8d bc 24 28 01 00 	lea    0x128(%rsp),%rdi
    3068:	00 
    3069:	48 8d 94 24 a8 00 00 	lea    0xa8(%rsp),%rdx
    3070:	00 
    3071:	e8 da 00 00 00       	call   3150 <fwp_cleanup_push>
    3076:	be 00 00 00 80       	mov    $0x80000000,%esi
    307b:	48 89 df             	mov    %rbx,%rdi
    307e:	e8 1d 03 00 00       	call   33a0 <f22>
    3083:	48 89 c3             	mov    %rax,%rbx
    3086:	48 8d bc 24 28 01 00 	lea    0x128(%rsp),%rdi
    308d:	00 
    308e:	e8 8d 01 00 00       	call   3220 <fwp_cleanup_pop>
    3093:	48 8b 04 24          	mov    (%rsp),%rax
    3097:	48 89 84 24 d8 00 00 	mov    %rax,0xd8(%rsp)
    309e:	00 
    309f:	48 89 ac 24 e0 00 00 	mov    %rbp,0xe0(%rsp)
    30a6:	00 
    30a7:	4c 89 a4 24 e8 00 00 	mov    %r12,0xe8(%rsp)
    30ae:	00 
    30af:	4c 89 ac 24 f0 00 00 	mov    %r13,0xf0(%rsp)
    30b6:	00 
    30b7:	4c 89 b4 24 f8 00 00 	mov    %r14,0xf8(%rsp)
    30be:	00 
    30bf:	4c 89 bc 24 00 01 00 	mov    %r15,0x100(%rsp)
    30c6:	00 
    30c7:	48 89 9c 24 08 01 00 	mov    %rbx,0x108(%rsp)
    30ce:	00 
    30cf:	48 8d 35 da 02 00 00 	lea    0x2da(%rip),%rsi        # 33b0 <fwp_owner_release6>
    30d6:	48 8d bc 24 10 01 00 	lea    0x110(%rsp),%rdi
    30dd:	00 
    30de:	48 8d 94 24 d8 00 00 	lea    0xd8(%rsp),%rdx
    30e5:	00 
    30e6:	e8 65 00 00 00       	call   3150 <fwp_cleanup_push>
    30eb:	48 be 00 00 00 00 00 	movabs $0x8000000000000000,%rsi
    30f2:	00 00 80 
    30f5:	48 8b 7c 24 20       	mov    0x20(%rsp),%rdi
    30fa:	e8 01 03 00 00       	call   3400 <f24>
    30ff:	49 89 c6             	mov    %rax,%r14
    3102:	48 8d bc 24 10 01 00 	lea    0x110(%rsp),%rdi
    3109:	00 
    310a:	e8 11 01 00 00       	call   3220 <fwp_cleanup_pop>
    310f:	48 8b 44 24 28       	mov    0x28(%rsp),%rax
    3114:	48 8b 0c 24          	mov    (%rsp),%rcx
    3118:	48 89 08             	mov    %rcx,(%rax)
    311b:	48 89 68 08          	mov    %rbp,0x8(%rax)
    311f:	4c 89 60 10          	mov    %r12,0x10(%rax)
    3123:	4c 89 68 18          	mov    %r13,0x18(%rax)
    3127:	48 8b 4c 24 08       	mov    0x8(%rsp),%rcx
    312c:	48 89 48 20          	mov    %rcx,0x20(%rax)
    3130:	4c 89 78 28          	mov    %r15,0x28(%rax)
    3134:	48 89 58 30          	mov    %rbx,0x30(%rax)
    3138:	4c 89 70 38          	mov    %r14,0x38(%rax)
    313c:	48 81 c4 b8 01 00 00 	add    $0x1b8,%rsp
    3143:	5b                   	pop    %rbx
    3144:	41 5c                	pop    %r12
    3146:	41 5d                	pop    %r13
    3148:	41 5e                	pop    %r14
    314a:	41 5f                	pop    %r15
    314c:	5d                   	pop    %rbp
    314d:	c3                   	ret
    314e:	66 90                	xchg   %ax,%ax

0000000000003150 <fwp_cleanup_push>:
    3150:	48 8b 05 21 1c 01 00 	mov    0x11c21(%rip),%rax        # 14d78 <fwp_cleanups>
    3157:	48 89 07             	mov    %rax,(%rdi)
    315a:	48 89 77 08          	mov    %rsi,0x8(%rdi)
    315e:	48 89 57 10          	mov    %rdx,0x10(%rdi)
    3162:	48 89 3d 0f 1c 01 00 	mov    %rdi,0x11c0f(%rip)        # 14d78 <fwp_cleanups>
    3169:	c3                   	ret
    316a:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)

0000000000003170 <fwp_owner_release7>:
    3170:	53                   	push   %rbx
    3171:	48 89 fb             	mov    %rdi,%rbx
    3174:	48 8b 3f             	mov    (%rdi),%rdi
    3177:	e8 74 20 00 00       	call   51f0 <fwp_drop0>
    317c:	48 8b 7b 08          	mov    0x8(%rbx),%rdi
    3180:	e8 ab 23 00 00       	call   5530 <fwp_drop1>
    3185:	48 8b 7b 10          	mov    0x10(%rbx),%rdi
    3189:	e8 c2 23 00 00       	call   5550 <fwp_drop2>
    318e:	48 8b 7b 18          	mov    0x18(%rbx),%rdi
    3192:	e8 d9 23 00 00       	call   5570 <fwp_drop3>
    3197:	48 8b 7b 20          	mov    0x20(%rbx),%rdi
    319b:	e8 f0 23 00 00       	call   5590 <fwp_drop4>
    31a0:	48 8b 7b 28          	mov    0x28(%rbx),%rdi
    31a4:	e8 07 24 00 00       	call   55b0 <fwp_drop5>
    31a9:	48 8b 7b 30          	mov    0x30(%rbx),%rdi
    31ad:	e8 1e 24 00 00       	call   55d0 <fwp_drop6>
    31b2:	48 8b 7b 38          	mov    0x38(%rbx),%rdi
    31b6:	5b                   	pop    %rbx
    31b7:	e9 34 24 00 00       	jmp    55f0 <fwp_drop7>
    31bc:	0f 1f 40 00          	nopl   0x0(%rax)

00000000000031c0 <fwp_rc_fresh>:
    31c0:	41 56                	push   %r14
    31c2:	53                   	push   %rbx
    31c3:	50                   	push   %rax
    31c4:	48 89 fb             	mov    %rdi,%rbx
    31c7:	e8 f4 fa ff ff       	call   2cc0 <fwp_rc_slot>
    31cc:	48 85 c0             	test   %rax,%rax
    31cf:	74 08                	je     31d9 <fwp_rc_fresh+0x19>
    31d1:	80 38 ff             	cmpb   $0xff,(%rax)
    31d4:	74 0e                	je     31e4 <fwp_rc_fresh+0x24>
    31d6:	c6 00 01             	movb   $0x1,(%rax)
    31d9:	48 89 d8             	mov    %rbx,%rax
    31dc:	48 83 c4 08          	add    $0x8,%rsp
    31e0:	5b                   	pop    %rbx
    31e1:	41 5e                	pop    %r14
    31e3:	c3                   	ret
    31e4:	48 89 c7             	mov    %rax,%rdi
    31e7:	49 89 c6             	mov    %rax,%r14
    31ea:	e8 71 fb ff ff       	call   2d60 <fwp_rc_forget_slot>
    31ef:	4c 89 f0             	mov    %r14,%rax
    31f2:	eb e2                	jmp    31d6 <fwp_rc_fresh+0x16>
    31f4:	66 66 66 2e 0f 1f 84 	data16 data16 cs nopw 0x0(%rax,%rax,1)
    31fb:	00 00 00 00 00 

0000000000003200 <fwp_record>:
    3200:	85 ff                	test   %edi,%edi
    3202:	74 0c                	je     3210 <fwp_record+0x10>
    3204:	48 89 f2             	mov    %rsi,%rdx
    3207:	89 fe                	mov    %edi,%esi
    3209:	31 ff                	xor    %edi,%edi
    320b:	e9 00 24 00 00       	jmp    5610 <fwp_data>
    3210:	31 c0                	xor    %eax,%eax
    3212:	c3                   	ret
    3213:	66 66 66 66 2e 0f 1f 	data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    321a:	84 00 00 00 00 00 

0000000000003220 <fwp_cleanup_pop>:
    3220:	48 39 3d 51 1b 01 00 	cmp    %rdi,0x11b51(%rip)        # 14d78 <fwp_cleanups>
    3227:	75 0b                	jne    3234 <fwp_cleanup_pop+0x14>
    3229:	48 8b 07             	mov    (%rdi),%rax
    322c:	48 89 05 45 1b 01 00 	mov    %rax,0x11b45(%rip)        # 14d78 <fwp_cleanups>
    3233:	c3                   	ret
    3234:	50                   	push   %rax
    3235:	e8 36 ee ff ff       	call   2070 <abort@plt>
    323a:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)

0000000000003240 <f10>:
    3240:	e9 cb 01 00 00       	jmp    3410 <fwp_p_array_make_typed>
    3245:	66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
    324c:	00 00 00 00 

0000000000003250 <fwp_owner_release0>:
    3250:	48 8b 3f             	mov    (%rdi),%rdi
    3253:	e9 98 1f 00 00       	jmp    51f0 <fwp_drop0>
    3258:	0f 1f 84 00 00 00 00 	nopl   0x0(%rax,%rax,1)
    325f:	00 

0000000000003260 <f12>:
    3260:	e9 ab 01 00 00       	jmp    3410 <fwp_p_array_make_typed>
    3265:	66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
    326c:	00 00 00 00 

0000000000003270 <fwp_owner_release1>:
    3270:	53                   	push   %rbx
    3271:	48 89 fb             	mov    %rdi,%rbx
    3274:	48 8b 3f             	mov    (%rdi),%rdi
    3277:	e8 74 1f 00 00       	call   51f0 <fwp_drop0>
    327c:	48 8b 7b 08          	mov    0x8(%rbx),%rdi
    3280:	5b                   	pop    %rbx
    3281:	e9 aa 22 00 00       	jmp    5530 <fwp_drop1>
    3286:	66 2e 0f 1f 84 00 00 	cs nopw 0x0(%rax,%rax,1)
    328d:	00 00 00 

0000000000003290 <f14>:
    3290:	e9 7b 01 00 00       	jmp    3410 <fwp_p_array_make_typed>
    3295:	66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
    329c:	00 00 00 00 

00000000000032a0 <fwp_owner_release2>:
    32a0:	53                   	push   %rbx
    32a1:	48 89 fb             	mov    %rdi,%rbx
    32a4:	48 8b 3f             	mov    (%rdi),%rdi
    32a7:	e8 44 1f 00 00       	call   51f0 <fwp_drop0>
    32ac:	48 8b 7b 08          	mov    0x8(%rbx),%rdi
    32b0:	e8 7b 22 00 00       	call   5530 <fwp_drop1>
    32b5:	48 8b 7b 10          	mov    0x10(%rbx),%rdi
    32b9:	5b                   	pop    %rbx
    32ba:	e9 91 22 00 00       	jmp    5550 <fwp_drop2>
    32bf:	90                   	nop

00000000000032c0 <f16>:
    32c0:	e9 4b 01 00 00       	jmp    3410 <fwp_p_array_make_typed>
    32c5:	66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
    32cc:	00 00 00 00 

00000000000032d0 <fwp_owner_release3>:
    32d0:	53                   	push   %rbx
    32d1:	48 89 fb             	mov    %rdi,%rbx
    32d4:	48 8b 3f             	mov    (%rdi),%rdi
    32d7:	e8 14 1f 00 00       	call   51f0 <fwp_drop0>
    32dc:	48 8b 7b 08          	mov    0x8(%rbx),%rdi
    32e0:	e8 4b 22 00 00       	call   5530 <fwp_drop1>
    32e5:	48 8b 7b 10          	mov    0x10(%rbx),%rdi
    32e9:	e8 62 22 00 00       	call   5550 <fwp_drop2>
    32ee:	48 8b 7b 18          	mov    0x18(%rbx),%rdi
    32f2:	5b                   	pop    %rbx
    32f3:	e9 78 22 00 00       	jmp    5570 <fwp_drop3>
    32f8:	0f 1f 84 00 00 00 00 	nopl   0x0(%rax,%rax,1)
    32ff:	00 

0000000000003300 <f18>:
    3300:	e9 0b 01 00 00       	jmp    3410 <fwp_p_array_make_typed>
    3305:	66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
    330c:	00 00 00 00 

0000000000003310 <fwp_owner_release4>:
    3310:	53                   	push   %rbx
    3311:	48 89 fb             	mov    %rdi,%rbx
    3314:	48 8b 3f             	mov    (%rdi),%rdi
    3317:	e8 d4 1e 00 00       	call   51f0 <fwp_drop0>
    331c:	48 8b 7b 08          	mov    0x8(%rbx),%rdi
    3320:	e8 0b 22 00 00       	call   5530 <fwp_drop1>
    3325:	48 8b 7b 10          	mov    0x10(%rbx),%rdi
    3329:	e8 22 22 00 00       	call   5550 <fwp_drop2>
    332e:	48 8b 7b 18          	mov    0x18(%rbx),%rdi
    3332:	e8 39 22 00 00       	call   5570 <fwp_drop3>
    3337:	48 8b 7b 20          	mov    0x20(%rbx),%rdi
    333b:	5b                   	pop    %rbx
    333c:	e9 4f 22 00 00       	jmp    5590 <fwp_drop4>
    3341:	66 66 66 66 66 66 2e 	data16 data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    3348:	0f 1f 84 00 00 00 00 
    334f:	00 

0000000000003350 <f20>:
    3350:	e9 bb 00 00 00       	jmp    3410 <fwp_p_array_make_typed>
    3355:	66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
    335c:	00 00 00 00 

0000000000003360 <fwp_owner_release5>:
    3360:	53                   	push   %rbx
    3361:	48 89 fb             	mov    %rdi,%rbx
    3364:	48 8b 3f             	mov    (%rdi),%rdi
    3367:	e8 84 1e 00 00       	call   51f0 <fwp_drop0>
    336c:	48 8b 7b 08          	mov    0x8(%rbx),%rdi
    3370:	e8 bb 21 00 00       	call   5530 <fwp_drop1>
    3375:	48 8b 7b 10          	mov    0x10(%rbx),%rdi
    3379:	e8 d2 21 00 00       	call   5550 <fwp_drop2>
    337e:	48 8b 7b 18          	mov    0x18(%rbx),%rdi
    3382:	e8 e9 21 00 00       	call   5570 <fwp_drop3>
    3387:	48 8b 7b 20          	mov    0x20(%rbx),%rdi
    338b:	e8 00 22 00 00       	call   5590 <fwp_drop4>
    3390:	48 8b 7b 28          	mov    0x28(%rbx),%rdi
    3394:	5b                   	pop    %rbx
    3395:	e9 16 22 00 00       	jmp    55b0 <fwp_drop5>
    339a:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)

00000000000033a0 <f22>:
    33a0:	eb 6e                	jmp    3410 <fwp_p_array_make_typed>
    33a2:	66 66 66 66 66 2e 0f 	data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    33a9:	1f 84 00 00 00 00 00 

00000000000033b0 <fwp_owner_release6>:
    33b0:	53                   	push   %rbx
    33b1:	48 89 fb             	mov    %rdi,%rbx
    33b4:	48 8b 3f             	mov    (%rdi),%rdi
    33b7:	e8 34 1e 00 00       	call   51f0 <fwp_drop0>
    33bc:	48 8b 7b 08          	mov    0x8(%rbx),%rdi
    33c0:	e8 6b 21 00 00       	call   5530 <fwp_drop1>
    33c5:	48 8b 7b 10          	mov    0x10(%rbx),%rdi
    33c9:	e8 82 21 00 00       	call   5550 <fwp_drop2>
    33ce:	48 8b 7b 18          	mov    0x18(%rbx),%rdi
    33d2:	e8 99 21 00 00       	call   5570 <fwp_drop3>
    33d7:	48 8b 7b 20          	mov    0x20(%rbx),%rdi
    33db:	e8 b0 21 00 00       	call   5590 <fwp_drop4>
    33e0:	48 8b 7b 28          	mov    0x28(%rbx),%rdi
    33e4:	e8 c7 21 00 00       	call   55b0 <fwp_drop5>
    33e9:	48 8b 7b 30          	mov    0x30(%rbx),%rdi
    33ed:	5b                   	pop    %rbx
    33ee:	e9 dd 21 00 00       	jmp    55d0 <fwp_drop6>
    33f3:	66 66 66 66 2e 0f 1f 	data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    33fa:	84 00 00 00 00 00 

0000000000003400 <f24>:
    3400:	eb 0e                	jmp    3410 <fwp_p_array_make_typed>
    3402:	66 66 66 66 66 2e 0f 	data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    3409:	1f 84 00 00 00 00 00 

0000000000003410 <fwp_p_array_make_typed>:
    3410:	41 56                	push   %r14
    3412:	53                   	push   %rbx
    3413:	50                   	push   %rax
    3414:	48 89 f3             	mov    %rsi,%rbx
    3417:	e8 64 00 00 00       	call   3480 <fwp_count_arg>
    341c:	49 89 c6             	mov    %rax,%r14
    341f:	48 89 c7             	mov    %rax,%rdi
    3422:	e8 69 00 00 00       	call   3490 <fwp_array_typed_new>
    3427:	4d 85 f6             	test   %r14,%r14
    342a:	74 48                	je     3474 <fwp_p_array_make_typed+0x64>
    342c:	49 83 fe 04          	cmp    $0x4,%r14
    3430:	73 04                	jae    3436 <fwp_p_array_make_typed+0x26>
    3432:	31 c9                	xor    %ecx,%ecx
    3434:	eb 31                	jmp    3467 <fwp_p_array_make_typed+0x57>
    3436:	4c 89 f1             	mov    %r14,%rcx
    3439:	48 83 e1 fc          	and    $0xfffffffffffffffc,%rcx
    343d:	66 48 0f 6e c3       	movq   %rbx,%xmm0
    3442:	66 0f 70 c0 44       	pshufd $0x44,%xmm0,%xmm0
    3447:	31 d2                	xor    %edx,%edx
    3449:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)
    3450:	f3 0f 7f 44 d0 08    	movdqu %xmm0,0x8(%rax,%rdx,8)
    3456:	f3 0f 7f 44 d0 18    	movdqu %xmm0,0x18(%rax,%rdx,8)
    345c:	48 83 c2 04          	add    $0x4,%rdx
    3460:	48 39 d1             	cmp    %rdx,%rcx
    3463:	75 eb                	jne    3450 <fwp_p_array_make_typed+0x40>
    3465:	eb 08                	jmp    346f <fwp_p_array_make_typed+0x5f>
    3467:	48 89 5c c8 08       	mov    %rbx,0x8(%rax,%rcx,8)
    346c:	48 ff c1             	inc    %rcx
    346f:	49 39 ce             	cmp    %rcx,%r14
    3472:	75 f3                	jne    3467 <fwp_p_array_make_typed+0x57>
    3474:	48 83 c4 08          	add    $0x8,%rsp
    3478:	5b                   	pop    %rbx
    3479:	41 5e                	pop    %r14
    347b:	c3                   	ret
    347c:	0f 1f 40 00          	nopl   0x0(%rax)

0000000000003480 <fwp_count_arg>:
    3480:	31 c0                	xor    %eax,%eax
    3482:	48 85 ff             	test   %rdi,%rdi
    3485:	48 0f 4f c7          	cmovg  %rdi,%rax
    3489:	c3                   	ret
    348a:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)

0000000000003490 <fwp_array_typed_new>:
    3490:	50                   	push   %rax
    3491:	48 b8 ff ff ff ff ff 	movabs $0x1fffffffffffffff,%rax
    3498:	ff ff 1f 
    349b:	48 39 c7             	cmp    %rax,%rdi
    349e:	73 0e                	jae    34ae <fwp_array_typed_new+0x1e>
    34a0:	e8 1b 00 00 00       	call   34c0 <fwp_arr_new>
    34a5:	48 89 c7             	mov    %rax,%rdi
    34a8:	58                   	pop    %rax
    34a9:	e9 12 fd ff ff       	jmp    31c0 <fwp_rc_fresh>
    34ae:	48 8d 3d 64 a2 00 00 	lea    0xa264(%rip),%rdi        # d719 <exec_in_fp0+0xd9>
    34b5:	e8 46 f9 ff ff       	call   2e00 <fwp_trap>
    34ba:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)

00000000000034c0 <fwp_arr_new>:
    34c0:	53                   	push   %rbx
    34c1:	48 b8 ff ff ff ff ff 	movabs $0x1fffffffffffffff,%rax
    34c8:	ff ff 1f 
    34cb:	48 39 c7             	cmp    %rax,%rdi
    34ce:	73 15                	jae    34e5 <fwp_arr_new+0x25>
    34d0:	48 89 fb             	mov    %rdi,%rbx
    34d3:	48 8d 3c fd 08 00 00 	lea    0x8(,%rdi,8),%rdi
    34da:	00 
    34db:	e8 20 00 00 00       	call   3500 <fwp_alloc>
    34e0:	48 89 18             	mov    %rbx,(%rax)
    34e3:	5b                   	pop    %rbx
    34e4:	c3                   	ret
    34e5:	48 8d 3d 2d a2 00 00 	lea    0xa22d(%rip),%rdi        # d719 <exec_in_fp0+0xd9>
    34ec:	e8 0f f9 ff ff       	call   2e00 <fwp_trap>
    34f1:	66 66 66 66 66 66 2e 	data16 data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    34f8:	0f 1f 84 00 00 00 00 
    34ff:	00 

0000000000003500 <fwp_alloc>:
    3500:	be 02 00 00 00       	mov    $0x2,%esi
    3505:	eb 09                	jmp    3510 <fwp_gc_alloc>
    3507:	66 0f 1f 84 00 00 00 	nopw   0x0(%rax,%rax,1)
    350e:	00 00 

0000000000003510 <fwp_gc_alloc>:
    3510:	53                   	push   %rbx
    3511:	48 81 ff 00 40 00 00 	cmp    $0x4000,%rdi
    3518:	77 6c                	ja     3586 <fwp_gc_alloc+0x76>
    351a:	48 8d 4f 0f          	lea    0xf(%rdi),%rcx
    351e:	48 c1 e9 04          	shr    $0x4,%rcx
    3522:	48 8d 05 6f fd 00 00 	lea    0xfd6f(%rip),%rax        # 13298 <fwp_gc>
    3529:	0f b6 8c 01 e8 0b 00 	movzbl 0xbe8(%rcx,%rax,1),%ecx
    3530:	00 
    3531:	8b 94 88 48 0b 00 00 	mov    0xb48(%rax,%rcx,4),%edx
    3538:	48 29 15 59 fd 00 00 	sub    %rdx,0xfd59(%rip)        # 13298 <fwp_gc>
    353f:	78 45                	js     3586 <fwp_gc_alloc+0x76>
    3541:	41 89 f0             	mov    %esi,%r8d
    3544:	4d 69 c0 c0 03 00 00 	imul   $0x3c0,%r8,%r8
    354b:	4c 01 c0             	add    %r8,%rax
    354e:	48 8d 0c 49          	lea    (%rcx,%rcx,2),%rcx
    3552:	4c 8d 04 c8          	lea    (%rax,%rcx,8),%r8
    3556:	49 83 c0 08          	add    $0x8,%r8
    355a:	49 8b 18             	mov    (%r8),%rbx
    355d:	48 85 db             	test   %rbx,%rbx
    3560:	74 12                	je     3574 <fwp_gc_alloc+0x64>
    3562:	48 8b 03             	mov    (%rbx),%rax
    3565:	48 f7 d0             	not    %rax
    3568:	49 89 00             	mov    %rax,(%r8)
    356b:	83 fe 01             	cmp    $0x1,%esi
    356e:	48 0f 44 d7          	cmove  %rdi,%rdx
    3572:	eb 2e                	jmp    35a2 <fwp_gc_alloc+0x92>
    3574:	48 8b 5c c8 10       	mov    0x10(%rax,%rcx,8),%rbx
    3579:	4c 8b 44 c8 18       	mov    0x18(%rax,%rcx,8),%r8
    357e:	49 29 d8             	sub    %rbx,%r8
    3581:	49 39 d0             	cmp    %rdx,%r8
    3584:	73 03                	jae    3589 <fwp_gc_alloc+0x79>
    3586:	5b                   	pop    %rbx
    3587:	eb 37                	jmp    35c0 <fwp_gc_alloc_slow>
    3589:	48 8d 04 c8          	lea    (%rax,%rcx,8),%rax
    358d:	48 83 c0 10          	add    $0x10,%rax
    3591:	48 8d 0c 13          	lea    (%rbx,%rdx,1),%rcx
    3595:	48 89 08             	mov    %rcx,(%rax)
    3598:	83 fe 01             	cmp    $0x1,%esi
    359b:	48 0f 45 fa          	cmovne %rdx,%rdi
    359f:	48 89 fa             	mov    %rdi,%rdx
    35a2:	48 89 df             	mov    %rbx,%rdi
    35a5:	31 f6                	xor    %esi,%esi
    35a7:	e8 64 ec ff ff       	call   2210 <memset@plt>
    35ac:	48 89 d8             	mov    %rbx,%rax
    35af:	5b                   	pop    %rbx
    35b0:	c3                   	ret
    35b1:	66 66 66 66 66 66 2e 	data16 data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    35b8:	0f 1f 84 00 00 00 00 
    35bf:	00 

00000000000035c0 <fwp_gc_alloc_slow>:
    35c0:	55                   	push   %rbp
    35c1:	41 57                	push   %r15
    35c3:	41 56                	push   %r14
    35c5:	41 54                	push   %r12
    35c7:	53                   	push   %rbx
    35c8:	89 f5                	mov    %esi,%ebp
    35ca:	48 89 fb             	mov    %rdi,%rbx
    35cd:	83 3d b0 0c 01 00 00 	cmpl   $0x0,0x10cb0(%rip)        # 14284 <fwp_gc+0xfec>
    35d4:	74 1b                	je     35f1 <fwp_gc_alloc_slow+0x31>
    35d6:	48 81 fb 01 40 00 00 	cmp    $0x4001,%rbx
    35dd:	72 20                	jb     35ff <fwp_gc_alloc_slow+0x3f>
    35df:	48 89 df             	mov    %rbx,%rdi
    35e2:	89 ee                	mov    %ebp,%esi
    35e4:	5b                   	pop    %rbx
    35e5:	41 5c                	pop    %r12
    35e7:	41 5e                	pop    %r14
    35e9:	41 5f                	pop    %r15
    35eb:	5d                   	pop    %rbp
    35ec:	e9 9f 03 00 00       	jmp    3990 <fwp_gc_alloc_big>
    35f1:	e8 ba 00 00 00       	call   36b0 <fwp_gc_init>
    35f6:	48 81 fb 01 40 00 00 	cmp    $0x4001,%rbx
    35fd:	73 e0                	jae    35df <fwp_gc_alloc_slow+0x1f>
    35ff:	48 8d 43 0f          	lea    0xf(%rbx),%rax
    3603:	48 c1 e8 04          	shr    $0x4,%rax
    3607:	4c 8d 25 8a fc 00 00 	lea    0xfc8a(%rip),%r12        # 13298 <fwp_gc>
    360e:	46 0f b6 bc 20 e8 0b 	movzbl 0xbe8(%rax,%r12,1),%r15d
    3615:	00 00 
    3617:	47 8b b4 bc 48 0b 00 	mov    0xb48(%r12,%r15,4),%r14d
    361e:	00 
    361f:	48 83 3d 71 fc 00 00 	cmpq   $0x0,0xfc71(%rip)        # 13298 <fwp_gc>
    3626:	00 
    3627:	79 05                	jns    362e <fwp_gc_alloc_slow+0x6e>
    3629:	e8 b2 04 00 00       	call   3ae0 <fwp_gc_spent>
    362e:	89 e8                	mov    %ebp,%eax
    3630:	48 69 c0 c0 03 00 00 	imul   $0x3c0,%rax,%rax
    3637:	49 01 c4             	add    %rax,%r12
    363a:	4b 8d 0c 7f          	lea    (%r15,%r15,2),%rcx
    363e:	49 8d 04 cc          	lea    (%r12,%rcx,8),%rax
    3642:	48 83 c0 08          	add    $0x8,%rax
    3646:	49 8b 7c cc 08       	mov    0x8(%r12,%rcx,8),%rdi
    364b:	48 85 ff             	test   %rdi,%rdi
    364e:	74 08                	je     3658 <fwp_gc_alloc_slow+0x98>
    3650:	48 8b 0f             	mov    (%rdi),%rcx
    3653:	48 f7 d1             	not    %rcx
    3656:	eb 30                	jmp    3688 <fwp_gc_alloc_slow+0xc8>
    3658:	49 8b 7c cc 10       	mov    0x10(%r12,%rcx,8),%rdi
    365d:	49 8b 54 cc 18       	mov    0x18(%r12,%rcx,8),%rdx
    3662:	48 29 fa             	sub    %rdi,%rdx
    3665:	4c 39 f2             	cmp    %r14,%rdx
    3668:	73 12                	jae    367c <fwp_gc_alloc_slow+0xbc>
    366a:	48 89 c7             	mov    %rax,%rdi
    366d:	44 89 fe             	mov    %r15d,%esi
    3670:	89 ea                	mov    %ebp,%edx
    3672:	e8 39 05 00 00       	call   3bb0 <fwp_gc_refill>
    3677:	48 89 c7             	mov    %rax,%rdi
    367a:	eb 0f                	jmp    368b <fwp_gc_alloc_slow+0xcb>
    367c:	49 8d 04 cc          	lea    (%r12,%rcx,8),%rax
    3680:	48 83 c0 10          	add    $0x10,%rax
    3684:	4a 8d 0c 37          	lea    (%rdi,%r14,1),%rcx
    3688:	48 89 08             	mov    %rcx,(%rax)
    368b:	83 fd 01             	cmp    $0x1,%ebp
    368e:	4c 0f 44 f3          	cmove  %rbx,%r14
    3692:	31 f6                	xor    %esi,%esi
    3694:	4c 89 f2             	mov    %r14,%rdx
    3697:	5b                   	pop    %rbx
    3698:	41 5c                	pop    %r12
    369a:	41 5e                	pop    %r14
    369c:	41 5f                	pop    %r15
    369e:	5d                   	pop    %rbp
    369f:	e9 6c eb ff ff       	jmp    2210 <memset@plt>
    36a4:	66 66 66 2e 0f 1f 84 	data16 data16 cs nopw 0x0(%rax,%rax,1)
    36ab:	00 00 00 00 00 

00000000000036b0 <fwp_gc_init>:
    36b0:	53                   	push   %rbx
    36b1:	48 83 ec 10          	sub    $0x10,%rsp
    36b5:	c7 05 c5 0b 01 00 01 	movl   $0x1,0x10bc5(%rip)        # 14284 <fwp_gc+0xfec>
    36bc:	00 00 00 
    36bf:	0f 28 05 8a 99 00 00 	movaps 0x998a(%rip),%xmm0        # d050 <_IO_stdin_used+0x50>
    36c6:	0f 11 05 13 07 01 00 	movups %xmm0,0x10713(%rip)        # 13de0 <fwp_gc+0xb48>
    36cd:	0f 28 05 8c 99 00 00 	movaps 0x998c(%rip),%xmm0        # d060 <_IO_stdin_used+0x60>
    36d4:	0f 11 05 15 07 01 00 	movups %xmm0,0x10715(%rip)        # 13df0 <fwp_gc+0xb58>
    36db:	0f 28 05 8e 99 00 00 	movaps 0x998e(%rip),%xmm0        # d070 <_IO_stdin_used+0x70>
    36e2:	0f 11 05 17 07 01 00 	movups %xmm0,0x10717(%rip)        # 13e00 <fwp_gc+0xb68>
    36e9:	0f 28 05 90 99 00 00 	movaps 0x9990(%rip),%xmm0        # d080 <_IO_stdin_used+0x80>
    36f0:	0f 11 05 19 07 01 00 	movups %xmm0,0x10719(%rip)        # 13e10 <fwp_gc+0xb78>
    36f7:	0f 28 05 92 99 00 00 	movaps 0x9992(%rip),%xmm0        # d090 <_IO_stdin_used+0x90>
    36fe:	0f 11 05 1b 07 01 00 	movups %xmm0,0x1071b(%rip)        # 13e20 <fwp_gc+0xb88>
    3705:	0f 28 05 94 99 00 00 	movaps 0x9994(%rip),%xmm0        # d0a0 <_IO_stdin_used+0xa0>
    370c:	0f 11 05 1d 07 01 00 	movups %xmm0,0x1071d(%rip)        # 13e30 <fwp_gc+0xb98>
    3713:	0f 28 05 96 99 00 00 	movaps 0x9996(%rip),%xmm0        # d0b0 <_IO_stdin_used+0xb0>
    371a:	0f 11 05 1f 07 01 00 	movups %xmm0,0x1071f(%rip)        # 13e40 <fwp_gc+0xba8>
    3721:	0f 28 05 98 99 00 00 	movaps 0x9998(%rip),%xmm0        # d0c0 <_IO_stdin_used+0xc0>
    3728:	0f 11 05 21 07 01 00 	movups %xmm0,0x10721(%rip)        # 13e50 <fwp_gc+0xbb8>
    372f:	0f 28 05 9a 99 00 00 	movaps 0x999a(%rip),%xmm0        # d0d0 <_IO_stdin_used+0xd0>
    3736:	0f 11 05 23 07 01 00 	movups %xmm0,0x10723(%rip)        # 13e60 <fwp_gc+0xbc8>
    373d:	0f 28 05 9c 99 00 00 	movaps 0x999c(%rip),%xmm0        # d0e0 <_IO_stdin_used+0xe0>
    3744:	0f 11 05 25 07 01 00 	movups %xmm0,0x10725(%rip)        # 13e70 <fwp_gc+0xbd8>
    374b:	31 c9                	xor    %ecx,%ecx
    374d:	48 8d 05 44 fb 00 00 	lea    0xfb44(%rip),%rax        # 13298 <fwp_gc>
    3754:	31 d2                	xor    %edx,%edx
    3756:	66 2e 0f 1f 84 00 00 	cs nopw 0x0(%rax,%rax,1)
    375d:	00 00 00 
    3760:	89 d6                	mov    %edx,%esi
    3762:	c1 e6 04             	shl    $0x4,%esi
    3765:	48 ff c9             	dec    %rcx
    3768:	48 89 cf             	mov    %rcx,%rdi
    376b:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)
    3770:	48 89 f9             	mov    %rdi,%rcx
    3773:	48 ff c7             	inc    %rdi
    3776:	3b b4 88 4c 0b 00 00 	cmp    0xb4c(%rax,%rcx,4),%esi
    377d:	77 f1                	ja     3770 <fwp_gc_init+0xc0>
    377f:	40 88 bc 02 e8 0b 00 	mov    %dil,0xbe8(%rdx,%rax,1)
    3786:	00 
    3787:	48 89 d6             	mov    %rdx,%rsi
    378a:	48 83 ce 01          	or     $0x1,%rsi
    378e:	48 81 fe 01 04 00 00 	cmp    $0x401,%rsi
    3795:	74 26                	je     37bd <fwp_gc_init+0x10d>
    3797:	89 f7                	mov    %esi,%edi
    3799:	c1 e7 04             	shl    $0x4,%edi
    379c:	0f 1f 40 00          	nopl   0x0(%rax)
    37a0:	49 89 c8             	mov    %rcx,%r8
    37a3:	48 ff c1             	inc    %rcx
    37a6:	42 3b bc 80 4c 0b 00 	cmp    0xb4c(%rax,%r8,4),%edi
    37ad:	00 
    37ae:	77 f0                	ja     37a0 <fwp_gc_init+0xf0>
    37b0:	88 8c 06 e8 0b 00 00 	mov    %cl,0xbe8(%rsi,%rax,1)
    37b7:	48 83 c2 02          	add    $0x2,%rdx
    37bb:	eb a3                	jmp    3760 <fwp_gc_init+0xb0>
    37bd:	48 b8 00 00 00 00 10 	movabs $0x1000000000,%rax
    37c4:	00 00 00 
    37c7:	48 89 44 24 08       	mov    %rax,0x8(%rsp)
    37cc:	48 8d 7c 24 08       	lea    0x8(%rsp),%rdi
    37d1:	e8 ba 04 00 00       	call   3c90 <fwp_gc_reserve>
    37d6:	48 85 c0             	test   %rax,%rax
    37d9:	0f 84 ab 01 00 00    	je     398a <fwp_gc_init+0x2da>
    37df:	48 89 05 ea 0a 01 00 	mov    %rax,0x10aea(%rip)        # 142d0 <fwp_gc+0x1038>
    37e6:	48 8b 4c 24 08       	mov    0x8(%rsp),%rcx
    37eb:	48 8d 91 00 00 01 00 	lea    0x10000(%rcx),%rdx
    37f2:	48 89 15 df 0a 01 00 	mov    %rdx,0x10adf(%rip)        # 142d8 <fwp_gc+0x1040>
    37f9:	48 05 ff ff 00 00    	add    $0xffff,%rax
    37ff:	48 25 00 00 ff ff    	and    $0xffffffffffff0000,%rax
    3805:	48 89 05 bc 0a 01 00 	mov    %rax,0x10abc(%rip)        # 142c8 <fwp_gc+0x1030>
    380c:	48 c1 e9 10          	shr    $0x10,%rcx
    3810:	48 89 0d d1 0a 01 00 	mov    %rcx,0x10ad1(%rip)        # 142e8 <fwp_gc+0x1050>
    3817:	48 69 f1 28 12 00 00 	imul   $0x1228,%rcx,%rsi
    381e:	48 89 35 f3 0a 01 00 	mov    %rsi,0x10af3(%rip)        # 14318 <fwp_gc+0x1080>
    3825:	31 ff                	xor    %edi,%edi
    3827:	31 d2                	xor    %edx,%edx
    3829:	b9 22 40 00 00       	mov    $0x4022,%ecx
    382e:	41 b8 ff ff ff ff    	mov    $0xffffffff,%r8d
    3834:	45 31 c9             	xor    %r9d,%r9d
    3837:	e8 54 e9 ff ff       	call   2190 <mmap@plt>
    383c:	48 83 f8 ff          	cmp    $0xffffffffffffffff,%rax
    3840:	0f 84 44 01 00 00    	je     398a <fwp_gc_init+0x2da>
    3846:	48 89 05 c3 0a 01 00 	mov    %rax,0x10ac3(%rip)        # 14310 <fwp_gc+0x1078>
    384d:	48 8d 3d d5 9e 00 00 	lea    0x9ed5(%rip),%rdi        # d729 <exec_in_fp0+0xe9>
    3854:	e8 d7 e7 ff ff       	call   2030 <getenv@plt>
    3859:	48 85 c0             	test   %rax,%rax
    385c:	74 2e                	je     388c <fwp_gc_init+0x1dc>
    385e:	48 89 c3             	mov    %rax,%rbx
    3861:	48 8d 35 c8 9e 00 00 	lea    0x9ec8(%rip),%rsi        # d730 <exec_in_fp0+0xf0>
    3868:	48 89 c7             	mov    %rax,%rdi
    386b:	e8 60 ea ff ff       	call   22d0 <strcmp@plt>
    3870:	85 c0                	test   %eax,%eax
    3872:	74 1f                	je     3893 <fwp_gc_init+0x1e3>
    3874:	48 8d 35 df aa 00 00 	lea    0xaadf(%rip),%rsi        # e35a <exec_in_fp0+0xd1a>
    387b:	48 89 df             	mov    %rbx,%rdi
    387e:	e8 4d ea ff ff       	call   22d0 <strcmp@plt>
    3883:	31 c9                	xor    %ecx,%ecx
    3885:	85 c0                	test   %eax,%eax
    3887:	0f 95 c1             	setne  %cl
    388a:	eb 09                	jmp    3895 <fwp_gc_init+0x1e5>
    388c:	b9 01 00 00 00       	mov    $0x1,%ecx
    3891:	eb 02                	jmp    3895 <fwp_gc_init+0x1e5>
    3893:	31 c9                	xor    %ecx,%ecx
    3895:	89 0d ed 09 01 00    	mov    %ecx,0x109ed(%rip)        # 14288 <fwp_gc+0xff0>
    389b:	48 8d 3d 92 9e 00 00 	lea    0x9e92(%rip),%rdi        # d734 <exec_in_fp0+0xf4>
    38a2:	e8 89 e7 ff ff       	call   2030 <getenv@plt>
    38a7:	31 c9                	xor    %ecx,%ecx
    38a9:	48 85 c0             	test   %rax,%rax
    38ac:	74 1b                	je     38c9 <fwp_gc_init+0x219>
    38ae:	80 38 00             	cmpb   $0x0,(%rax)
    38b1:	74 16                	je     38c9 <fwp_gc_init+0x219>
    38b3:	48 8d 35 a0 aa 00 00 	lea    0xaaa0(%rip),%rsi        # e35a <exec_in_fp0+0xd1a>
    38ba:	48 89 c7             	mov    %rax,%rdi
    38bd:	e8 0e ea ff ff       	call   22d0 <strcmp@plt>
    38c2:	31 c9                	xor    %ecx,%ecx
    38c4:	85 c0                	test   %eax,%eax
    38c6:	0f 95 c1             	setne  %cl
    38c9:	89 0d c5 09 01 00    	mov    %ecx,0x109c5(%rip)        # 14294 <fwp_gc+0xffc>
    38cf:	48 8d 3d 53 9e 00 00 	lea    0x9e53(%rip),%rdi        # d729 <exec_in_fp0+0xe9>
    38d6:	e8 55 e7 ff ff       	call   2030 <getenv@plt>
    38db:	48 85 c0             	test   %rax,%rax
    38de:	74 18                	je     38f8 <fwp_gc_init+0x248>
    38e0:	48 8d 35 5a 9e 00 00 	lea    0x9e5a(%rip),%rsi        # d741 <exec_in_fp0+0x101>
    38e7:	48 89 c7             	mov    %rax,%rdi
    38ea:	e8 e1 e9 ff ff       	call   22d0 <strcmp@plt>
    38ef:	31 c9                	xor    %ecx,%ecx
    38f1:	85 c0                	test   %eax,%eax
    38f3:	0f 95 c1             	setne  %cl
    38f6:	eb 05                	jmp    38fd <fwp_gc_init+0x24d>
    38f8:	b9 01 00 00 00       	mov    $0x1,%ecx
    38fd:	89 0d 95 09 01 00    	mov    %ecx,0x10995(%rip)        # 14298 <fwp_gc+0x1000>
    3903:	c7 05 93 09 01 00 01 	movl   $0x1,0x10993(%rip)        # 142a0 <fwp_gc+0x1008>
    390a:	00 00 00 
    390d:	48 8d 3d 32 9e 00 00 	lea    0x9e32(%rip),%rdi        # d746 <exec_in_fp0+0x106>
    3914:	e8 17 e7 ff ff       	call   2030 <getenv@plt>
    3919:	31 c9                	xor    %ecx,%ecx
    391b:	48 85 c0             	test   %rax,%rax
    391e:	74 1b                	je     393b <fwp_gc_init+0x28b>
    3920:	80 38 00             	cmpb   $0x0,(%rax)
    3923:	74 16                	je     393b <fwp_gc_init+0x28b>
    3925:	48 8d 35 2e aa 00 00 	lea    0xaa2e(%rip),%rsi        # e35a <exec_in_fp0+0xd1a>
    392c:	48 89 c7             	mov    %rax,%rdi
    392f:	e8 9c e9 ff ff       	call   22d0 <strcmp@plt>
    3934:	31 c9                	xor    %ecx,%ecx
    3936:	85 c0                	test   %eax,%eax
    3938:	0f 95 c1             	setne  %cl
    393b:	89 0d 5b 09 01 00    	mov    %ecx,0x1095b(%rip)        # 1429c <fwp_gc+0x1004>
    3941:	48 8d 3d 0c 9e 00 00 	lea    0x9e0c(%rip),%rdi        # d754 <exec_in_fp0+0x114>
    3948:	e8 e3 e6 ff ff       	call   2030 <getenv@plt>
    394d:	48 85 c0             	test   %rax,%rax
    3950:	74 0a                	je     395c <fwp_gc_init+0x2ac>
    3952:	48 89 c7             	mov    %rax,%rdi
    3955:	e8 a6 ea ff ff       	call   2400 <atol@plt>
    395a:	eb 02                	jmp    395e <fwp_gc_init+0x2ae>
    395c:	31 c0                	xor    %eax,%eax
    395e:	31 c9                	xor    %ecx,%ecx
    3960:	48 85 c0             	test   %rax,%rax
    3963:	48 0f 4f c8          	cmovg  %rax,%rcx
    3967:	48 89 0d 4a 09 01 00 	mov    %rcx,0x1094a(%rip)        # 142b8 <fwp_gc+0x1020>
    396e:	48 c7 05 2f 0b 01 00 	movq   $0x800000,0x10b2f(%rip)        # 144a8 <fwp_gc+0x1210>
    3975:	00 00 80 00 
    3979:	48 c7 05 14 f9 00 00 	movq   $0x800000,0xf914(%rip)        # 13298 <fwp_gc>
    3980:	00 00 80 00 
    3984:	48 83 c4 10          	add    $0x10,%rsp
    3988:	5b                   	pop    %rbx
    3989:	c3                   	ret
    398a:	e8 71 03 00 00       	call   3d00 <fwp_gc_oom>
    398f:	90                   	nop

0000000000003990 <fwp_gc_alloc_big>:
    3990:	55                   	push   %rbp
    3991:	41 57                	push   %r15
    3993:	41 56                	push   %r14
    3995:	41 54                	push   %r12
    3997:	53                   	push   %rbx
    3998:	48 b8 01 00 00 00 00 	movabs $0x4000000000000001,%rax
    399f:	00 00 40 
    39a2:	48 39 c7             	cmp    %rax,%rdi
    39a5:	0f 83 28 01 00 00    	jae    3ad3 <fwp_gc_alloc_big+0x143>
    39ab:	89 f5                	mov    %esi,%ebp
    39ad:	48 89 fb             	mov    %rdi,%rbx
    39b0:	48 29 3d e1 f8 00 00 	sub    %rdi,0xf8e1(%rip)        # 13298 <fwp_gc>
    39b7:	79 05                	jns    39be <fwp_gc_alloc_big+0x2e>
    39b9:	e8 22 01 00 00       	call   3ae0 <fwp_gc_spent>
    39be:	4c 8d bb ff ff 00 00 	lea    0xffff(%rbx),%r15
    39c5:	49 c1 ef 10          	shr    $0x10,%r15
    39c9:	4c 89 ff             	mov    %r15,%rdi
    39cc:	e8 5f 03 00 00       	call   3d30 <fwp_gc_chunks>
    39d1:	49 89 c6             	mov    %rax,%r14
    39d4:	48 8b 05 35 09 01 00 	mov    0x10935(%rip),%rax        # 14310 <fwp_gc+0x1078>
    39db:	4d 69 e6 28 12 00 00 	imul   $0x1228,%r14,%r12
    39e2:	42 c6 04 20 02       	movb   $0x2,(%rax,%r12,1)
    39e7:	42 88 6c 20 01       	mov    %bpl,0x1(%rax,%r12,1)
    39ec:	66 42 c7 44 20 03 00 	movw   $0x100,0x3(%rax,%r12,1)
    39f3:	01 
    39f4:	46 89 7c 20 10       	mov    %r15d,0x10(%rax,%r12,1)
    39f9:	4a 89 5c 20 18       	mov    %rbx,0x18(%rax,%r12,1)
    39fe:	4a 8d 3c 20          	lea    (%rax,%r12,1),%rdi
    3a02:	48 81 c7 28 02 00 00 	add    $0x228,%rdi
    3a09:	e8 22 f3 ff ff       	call   2d30 <fwp_rc_clear_slot>
    3a0e:	48 81 fb 01 00 01 00 	cmp    $0x10001,%rbx
    3a15:	0f 82 9b 00 00 00    	jb     3ab6 <fwp_gc_alloc_big+0x126>
    3a1b:	49 83 ff 03          	cmp    $0x3,%r15
    3a1f:	b9 02 00 00 00       	mov    $0x2,%ecx
    3a24:	49 0f 43 cf          	cmovae %r15,%rcx
    3a28:	48 8b 05 e1 08 01 00 	mov    0x108e1(%rip),%rax        # 14310 <fwp_gc+0x1078>
    3a2f:	48 ff c9             	dec    %rcx
    3a32:	ba 01 00 00 00       	mov    $0x1,%edx
    3a37:	48 81 fb 01 00 02 00 	cmp    $0x20001,%rbx
    3a3e:	72 59                	jb     3a99 <fwp_gc_alloc_big+0x109>
    3a40:	49 8d 34 04          	lea    (%r12,%rax,1),%rsi
    3a44:	48 81 c6 60 24 00 00 	add    $0x2460,%rsi
    3a4b:	48 89 cf             	mov    %rcx,%rdi
    3a4e:	48 83 e7 fe          	and    $0xfffffffffffffffe,%rdi
    3a52:	48 f7 df             	neg    %rdi
    3a55:	66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
    3a5c:	00 00 00 00 
    3a60:	c6 86 c8 ed ff ff 03 	movb   $0x3,-0x1238(%rsi)
    3a67:	c6 86 cc ed ff ff 01 	movb   $0x1,-0x1234(%rsi)
    3a6e:	44 89 b6 d8 ed ff ff 	mov    %r14d,-0x1228(%rsi)
    3a75:	c6 46 f0 03          	movb   $0x3,-0x10(%rsi)
    3a79:	c6 46 f4 01          	movb   $0x1,-0xc(%rsi)
    3a7d:	44 89 36             	mov    %r14d,(%rsi)
    3a80:	48 81 c6 50 24 00 00 	add    $0x2450,%rsi
    3a87:	4c 8d 04 17          	lea    (%rdi,%rdx,1),%r8
    3a8b:	49 83 c0 02          	add    $0x2,%r8
    3a8f:	48 83 c2 02          	add    $0x2,%rdx
    3a93:	49 83 f8 01          	cmp    $0x1,%r8
    3a97:	75 c7                	jne    3a60 <fwp_gc_alloc_big+0xd0>
    3a99:	f6 c1 01             	test   $0x1,%cl
    3a9c:	74 18                	je     3ab6 <fwp_gc_alloc_big+0x126>
    3a9e:	4c 01 e0             	add    %r12,%rax
    3aa1:	48 69 ca 28 12 00 00 	imul   $0x1228,%rdx,%rcx
    3aa8:	c6 04 08 03          	movb   $0x3,(%rax,%rcx,1)
    3aac:	c6 44 08 04 01       	movb   $0x1,0x4(%rax,%rcx,1)
    3ab1:	44 89 74 08 10       	mov    %r14d,0x10(%rax,%rcx,1)
    3ab6:	4c 89 f7             	mov    %r14,%rdi
    3ab9:	e8 92 f2 ff ff       	call   2d50 <fwp_gc_chunk_addr>
    3abe:	48 89 c7             	mov    %rax,%rdi
    3ac1:	31 f6                	xor    %esi,%esi
    3ac3:	48 89 da             	mov    %rbx,%rdx
    3ac6:	5b                   	pop    %rbx
    3ac7:	41 5c                	pop    %r12
    3ac9:	41 5e                	pop    %r14
    3acb:	41 5f                	pop    %r15
    3acd:	5d                   	pop    %rbp
    3ace:	e9 3d e7 ff ff       	jmp    2210 <memset@plt>
    3ad3:	e8 28 02 00 00       	call   3d00 <fwp_gc_oom>
    3ad8:	0f 1f 84 00 00 00 00 	nopl   0x0(%rax,%rax,1)
    3adf:	00 

0000000000003ae0 <fwp_gc_spent>:
    3ae0:	50                   	push   %rax
    3ae1:	83 3d 9c 07 01 00 00 	cmpl   $0x0,0x1079c(%rip)        # 14284 <fwp_gc+0xfec>
    3ae8:	75 05                	jne    3aef <fwp_gc_spent+0xf>
    3aea:	e8 c1 fb ff ff       	call   36b0 <fwp_gc_init>
    3aef:	8b 05 97 07 01 00    	mov    0x10797(%rip),%eax        # 1428c <fwp_gc+0xff4>
    3af5:	85 c0                	test   %eax,%eax
    3af7:	74 6d                	je     3b66 <fwp_gc_spent+0x86>
    3af9:	48 8b 0d b8 07 01 00 	mov    0x107b8(%rip),%rcx        # 142b8 <fwp_gc+0x1020>
    3b00:	48 85 c9             	test   %rcx,%rcx
    3b03:	74 61                	je     3b66 <fwp_gc_spent+0x86>
    3b05:	48 8b 05 b4 07 01 00 	mov    0x107b4(%rip),%rax        # 142c0 <fwp_gc+0x1028>
    3b0c:	48 ff c0             	inc    %rax
    3b0f:	48 89 05 aa 07 01 00 	mov    %rax,0x107aa(%rip)        # 142c0 <fwp_gc+0x1028>
    3b16:	48 39 c8             	cmp    %rcx,%rax
    3b19:	7c 10                	jl     3b2b <fwp_gc_spent+0x4b>
    3b1b:	48 c7 05 9a 07 01 00 	movq   $0x0,0x1079a(%rip)        # 142c0 <fwp_gc+0x1028>
    3b22:	00 00 00 00 
    3b26:	e8 85 03 00 00       	call   3eb0 <fwp_gc_collect>
    3b2b:	48 8b 05 76 09 01 00 	mov    0x10976(%rip),%rax        # 144a8 <fwp_gc+0x1210>
    3b32:	48 2b 05 5f f7 00 00 	sub    0xf75f(%rip),%rax        # 13298 <fwp_gc>
    3b39:	f2 48 0f 2a c0       	cvtsi2sd %rax,%xmm0
    3b3e:	f2 0f 58 05 3a 09 01 	addsd  0x1093a(%rip),%xmm0        # 14480 <fwp_gc+0x11e8>
    3b45:	00 
    3b46:	f2 0f 11 05 32 09 01 	movsd  %xmm0,0x10932(%rip)        # 14480 <fwp_gc+0x11e8>
    3b4d:	00 
    3b4e:	48 c7 05 4f 09 01 00 	movq   $0x0,0x1094f(%rip)        # 144a8 <fwp_gc+0x1210>
    3b55:	00 00 00 00 
    3b59:	48 c7 05 34 f7 00 00 	movq   $0x0,0xf734(%rip)        # 13298 <fwp_gc>
    3b60:	00 00 00 00 
    3b64:	58                   	pop    %rax
    3b65:	c3                   	ret
    3b66:	85 c0                	test   %eax,%eax
    3b68:	74 06                	je     3b70 <fwp_gc_spent+0x90>
    3b6a:	58                   	pop    %rax
    3b6b:	e9 40 03 00 00       	jmp    3eb0 <fwp_gc_collect>
    3b70:	48 8b 05 31 09 01 00 	mov    0x10931(%rip),%rax        # 144a8 <fwp_gc+0x1210>
    3b77:	48 2b 05 1a f7 00 00 	sub    0xf71a(%rip),%rax        # 13298 <fwp_gc>
    3b7e:	f2 48 0f 2a c0       	cvtsi2sd %rax,%xmm0
    3b83:	f2 0f 58 05 f5 08 01 	addsd  0x108f5(%rip),%xmm0        # 14480 <fwp_gc+0x11e8>
    3b8a:	00 
    3b8b:	f2 0f 11 05 ed 08 01 	movsd  %xmm0,0x108ed(%rip)        # 14480 <fwp_gc+0x11e8>
    3b92:	00 
    3b93:	48 c7 05 0a 09 01 00 	movq   $0x800000,0x1090a(%rip)        # 144a8 <fwp_gc+0x1210>
    3b9a:	00 00 80 00 
    3b9e:	48 c7 05 ef f6 00 00 	movq   $0x800000,0xf6ef(%rip)        # 13298 <fwp_gc>
    3ba5:	00 00 80 00 
    3ba9:	58                   	pop    %rax
    3baa:	c3                   	ret
    3bab:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)

0000000000003bb0 <fwp_gc_refill>:
    3bb0:	55                   	push   %rbp
    3bb1:	41 57                	push   %r15
    3bb3:	41 56                	push   %r14
    3bb5:	53                   	push   %rbx
    3bb6:	50                   	push   %rax
    3bb7:	89 d5                	mov    %edx,%ebp
    3bb9:	41 89 f7             	mov    %esi,%r15d
    3bbc:	48 89 fb             	mov    %rdi,%rbx
    3bbf:	bf 01 00 00 00       	mov    $0x1,%edi
    3bc4:	e8 67 01 00 00       	call   3d30 <fwp_gc_chunks>
    3bc9:	49 89 c6             	mov    %rax,%r14
    3bcc:	48 8b 0d 3d 07 01 00 	mov    0x1073d(%rip),%rcx        # 14310 <fwp_gc+0x1078>
    3bd3:	48 8d 05 be f6 00 00 	lea    0xf6be(%rip),%rax        # 13298 <fwp_gc>
    3bda:	49 69 f6 28 12 00 00 	imul   $0x1228,%r14,%rsi
    3be1:	48 8d 3c 31          	lea    (%rcx,%rsi,1),%rdi
    3be5:	c6 04 31 01          	movb   $0x1,(%rcx,%rsi,1)
    3be9:	40 88 6c 31 01       	mov    %bpl,0x1(%rcx,%rsi,1)
    3bee:	44 88 7c 31 02       	mov    %r15b,0x2(%rcx,%rsi,1)
    3bf3:	c6 44 31 04 01       	movb   $0x1,0x4(%rcx,%rsi,1)
    3bf8:	44 89 fa             	mov    %r15d,%edx
    3bfb:	44 8b 84 90 48 0b 00 	mov    0xb48(%rax,%rdx,4),%r8d
    3c02:	00 
    3c03:	44 89 44 31 08       	mov    %r8d,0x8(%rcx,%rsi,1)
    3c08:	b8 00 00 01 00       	mov    $0x10000,%eax
    3c0d:	31 d2                	xor    %edx,%edx
    3c0f:	41 f7 f0             	div    %r8d
    3c12:	89 44 31 0c          	mov    %eax,0xc(%rcx,%rsi,1)
    3c16:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    3c1b:	4c 01 c0             	add    %r8,%rax
    3c1e:	48 0f ba e0 20       	bt     $0x20,%rax
    3c23:	73 07                	jae    3c2c <fwp_gc_refill+0x7c>
    3c25:	31 d2                	xor    %edx,%edx
    3c27:	49 f7 f0             	div    %r8
    3c2a:	eb 05                	jmp    3c31 <fwp_gc_refill+0x81>
    3c2c:	31 d2                	xor    %edx,%edx
    3c2e:	41 f7 f0             	div    %r8d
    3c31:	4c 8d 3c 31          	lea    (%rcx,%rsi,1),%r15
    3c35:	49 83 c7 08          	add    $0x8,%r15
    3c39:	89 44 31 20          	mov    %eax,0x20(%rcx,%rsi,1)
    3c3d:	e8 4e 15 00 00       	call   5190 <fwp_rc_clear_chunk>
    3c42:	4c 89 f7             	mov    %r14,%rdi
    3c45:	e8 06 f1 ff ff       	call   2d50 <fwp_gc_chunk_addr>
    3c4a:	83 3d 4b 06 01 00 00 	cmpl   $0x0,0x1064b(%rip)        # 1429c <fwp_gc+0x1004>
    3c51:	74 15                	je     3c68 <fwp_gc_refill+0xb8>
    3c53:	ba 00 00 01 00       	mov    $0x10000,%edx
    3c58:	48 89 c7             	mov    %rax,%rdi
    3c5b:	31 f6                	xor    %esi,%esi
    3c5d:	49 89 c6             	mov    %rax,%r14
    3c60:	e8 ab e5 ff ff       	call   2210 <memset@plt>
    3c65:	4c 89 f0             	mov    %r14,%rax
    3c68:	41 8b 0f             	mov    (%r15),%ecx
    3c6b:	48 8d 14 08          	lea    (%rax,%rcx,1),%rdx
    3c6f:	48 89 53 08          	mov    %rdx,0x8(%rbx)
    3c73:	41 8b 57 04          	mov    0x4(%r15),%edx
    3c77:	48 0f af d1          	imul   %rcx,%rdx
    3c7b:	48 01 c2             	add    %rax,%rdx
    3c7e:	48 89 53 10          	mov    %rdx,0x10(%rbx)
    3c82:	48 83 c4 08          	add    $0x8,%rsp
    3c86:	5b                   	pop    %rbx
    3c87:	41 5e                	pop    %r14
    3c89:	41 5f                	pop    %r15
    3c8b:	5d                   	pop    %rbp
    3c8c:	c3                   	ret
    3c8d:	0f 1f 00             	nopl   (%rax)

0000000000003c90 <fwp_gc_reserve>:
    3c90:	41 56                	push   %r14
    3c92:	53                   	push   %rbx
    3c93:	50                   	push   %rax
    3c94:	4c 8b 37             	mov    (%rdi),%r14
    3c97:	49 81 fe 00 00 00 10 	cmp    $0x10000000,%r14
    3c9e:	72 47                	jb     3ce7 <fwp_gc_reserve+0x57>
    3ca0:	48 89 fb             	mov    %rdi,%rbx
    3ca3:	66 66 66 66 2e 0f 1f 	data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    3caa:	84 00 00 00 00 00 
    3cb0:	49 8d b6 00 00 01 00 	lea    0x10000(%r14),%rsi
    3cb7:	31 ff                	xor    %edi,%edi
    3cb9:	31 d2                	xor    %edx,%edx
    3cbb:	b9 22 40 00 00       	mov    $0x4022,%ecx
    3cc0:	41 b8 ff ff ff ff    	mov    $0xffffffff,%r8d
    3cc6:	45 31 c9             	xor    %r9d,%r9d
    3cc9:	e8 c2 e4 ff ff       	call   2190 <mmap@plt>
    3cce:	48 83 f8 ff          	cmp    $0xffffffffffffffff,%rax
    3cd2:	75 17                	jne    3ceb <fwp_gc_reserve+0x5b>
    3cd4:	4c 89 f0             	mov    %r14,%rax
    3cd7:	48 c1 e8 02          	shr    $0x2,%rax
    3cdb:	49 81 fe ff ff ff 3f 	cmp    $0x3fffffff,%r14
    3ce2:	49 89 c6             	mov    %rax,%r14
    3ce5:	77 c9                	ja     3cb0 <fwp_gc_reserve+0x20>
    3ce7:	31 c0                	xor    %eax,%eax
    3ce9:	eb 03                	jmp    3cee <fwp_gc_reserve+0x5e>
    3ceb:	4c 89 33             	mov    %r14,(%rbx)
    3cee:	48 83 c4 08          	add    $0x8,%rsp
    3cf2:	5b                   	pop    %rbx
    3cf3:	41 5e                	pop    %r14
    3cf5:	c3                   	ret
    3cf6:	66 2e 0f 1f 84 00 00 	cs nopw 0x0(%rax,%rax,1)
    3cfd:	00 00 00 

0000000000003d00 <fwp_gc_oom>:
    3d00:	50                   	push   %rax
    3d01:	48 8b 05 d0 f2 00 00 	mov    0xf2d0(%rip),%rax        # 12fd8 <stderr@GLIBC_2.2.5>
    3d08:	48 8b 08             	mov    (%rax),%rcx
    3d0b:	48 8d 3d 50 9a 00 00 	lea    0x9a50(%rip),%rdi        # d762 <exec_in_fp0+0x122>
    3d12:	be 13 00 00 00       	mov    $0x13,%esi
    3d17:	ba 01 00 00 00       	mov    $0x1,%edx
    3d1c:	e8 7f e7 ff ff       	call   24a0 <fwrite@plt>
    3d21:	bf 66 00 00 00       	mov    $0x66,%edi
    3d26:	e8 55 e7 ff ff       	call   2480 <exit@plt>
    3d2b:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)

0000000000003d30 <fwp_gc_chunks>:
    3d30:	41 56                	push   %r14
    3d32:	53                   	push   %rbx
    3d33:	50                   	push   %rax
    3d34:	48 89 fb             	mov    %rdi,%rbx
    3d37:	31 d2                	xor    %edx,%edx
    3d39:	48 83 ff 01          	cmp    $0x1,%rdi
    3d3d:	0f 95 c2             	setne  %dl
    3d40:	48 8d 0d 51 f5 00 00 	lea    0xf551(%rip),%rcx        # 13298 <fwp_gc>
    3d47:	48 8b 84 d1 68 10 00 	mov    0x1068(%rcx,%rdx,8),%rax
    3d4e:	00 
    3d4f:	4c 8b 35 9a 05 01 00 	mov    0x1059a(%rip),%r14        # 142f0 <fwp_gc+0x1058>
    3d56:	48 89 c7             	mov    %rax,%rdi
    3d59:	4c 29 f7             	sub    %r14,%rdi
    3d5c:	73 61                	jae    3dbf <fwp_gc_chunks+0x8f>
    3d5e:	48 8d 34 d5 68 10 00 	lea    0x1068(,%rdx,8),%rsi
    3d65:	00 
    3d66:	4c 69 c0 28 12 00 00 	imul   $0x1228,%rax,%r8
    3d6d:	4c 03 05 9c 05 01 00 	add    0x1059c(%rip),%r8        # 14310 <fwp_gc+0x1078>
    3d74:	31 d2                	xor    %edx,%edx
    3d76:	45 31 c9             	xor    %r9d,%r9d
    3d79:	eb 17                	jmp    3d92 <fwp_gc_chunks+0x62>
    3d7b:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)
    3d80:	45 31 c9             	xor    %r9d,%r9d
    3d83:	48 ff ca             	dec    %rdx
    3d86:	49 81 c0 28 12 00 00 	add    $0x1228,%r8
    3d8d:	48 39 d7             	cmp    %rdx,%rdi
    3d90:	74 30                	je     3dc2 <fwp_gc_chunks+0x92>
    3d92:	41 80 38 00          	cmpb   $0x0,(%r8)
    3d96:	75 e8                	jne    3d80 <fwp_gc_chunks+0x50>
    3d98:	49 ff c1             	inc    %r9
    3d9b:	49 39 d9             	cmp    %rbx,%r9
    3d9e:	75 e3                	jne    3d83 <fwp_gc_chunks+0x53>
    3da0:	48 ff c0             	inc    %rax
    3da3:	48 89 c7             	mov    %rax,%rdi
    3da6:	48 29 d7             	sub    %rdx,%rdi
    3da9:	48 89 3c 0e          	mov    %rdi,(%rsi,%rcx,1)
    3dad:	48 29 1d c4 06 01 00 	sub    %rbx,0x106c4(%rip)        # 14478 <fwp_gc+0x11e0>
    3db4:	48 29 d8             	sub    %rbx,%rax
    3db7:	48 29 d0             	sub    %rdx,%rax
    3dba:	49 89 c6             	mov    %rax,%r14
    3dbd:	eb 33                	jmp    3df2 <fwp_gc_chunks+0xc2>
    3dbf:	45 31 c9             	xor    %r9d,%r9d
    3dc2:	4d 29 ce             	sub    %r9,%r14
    3dc5:	4c 29 0d ac 06 01 00 	sub    %r9,0x106ac(%rip)        # 14478 <fwp_gc+0x11e0>
    3dcc:	4c 01 f3             	add    %r14,%rbx
    3dcf:	48 89 df             	mov    %rbx,%rdi
    3dd2:	e8 29 00 00 00       	call   3e00 <fwp_gc_commit>
    3dd7:	48 89 1d 12 05 01 00 	mov    %rbx,0x10512(%rip)        # 142f0 <fwp_gc+0x1058>
    3dde:	48 c1 e3 10          	shl    $0x10,%rbx
    3de2:	48 3b 1d f7 04 01 00 	cmp    0x104f7(%rip),%rbx        # 142e0 <fwp_gc+0x1048>
    3de9:	76 07                	jbe    3df2 <fwp_gc_chunks+0xc2>
    3deb:	48 89 1d ee 04 01 00 	mov    %rbx,0x104ee(%rip)        # 142e0 <fwp_gc+0x1048>
    3df2:	4c 89 f0             	mov    %r14,%rax
    3df5:	48 83 c4 08          	add    $0x8,%rsp
    3df9:	5b                   	pop    %rbx
    3dfa:	41 5e                	pop    %r14
    3dfc:	c3                   	ret
    3dfd:	0f 1f 00             	nopl   (%rax)

0000000000003e00 <fwp_gc_commit>:
    3e00:	53                   	push   %rbx
    3e01:	48 89 fb             	mov    %rdi,%rbx
    3e04:	48 8b 3d ed 04 01 00 	mov    0x104ed(%rip),%rdi        # 142f8 <fwp_gc+0x1060>
    3e0b:	48 39 df             	cmp    %rbx,%rdi
    3e0e:	0f 83 8f 00 00 00    	jae    3ea3 <fwp_gc_commit+0xa3>
    3e14:	48 8b 05 cd 04 01 00 	mov    0x104cd(%rip),%rax        # 142e8 <fwp_gc+0x1050>
    3e1b:	48 39 d8             	cmp    %rbx,%rax
    3e1e:	0f 82 81 00 00 00    	jb     3ea5 <fwp_gc_commit+0xa5>
    3e24:	48 83 c3 40          	add    $0x40,%rbx
    3e28:	48 39 c3             	cmp    %rax,%rbx
    3e2b:	48 0f 43 d8          	cmovae %rax,%rbx
    3e2f:	48 89 de             	mov    %rbx,%rsi
    3e32:	48 29 fe             	sub    %rdi,%rsi
    3e35:	48 c1 e7 10          	shl    $0x10,%rdi
    3e39:	48 03 3d 88 04 01 00 	add    0x10488(%rip),%rdi        # 142c8 <fwp_gc+0x1030>
    3e40:	48 c1 e6 10          	shl    $0x10,%rsi
    3e44:	ba 03 00 00 00       	mov    $0x3,%edx
    3e49:	e8 c2 e5 ff ff       	call   2410 <mprotect@plt>
    3e4e:	85 c0                	test   %eax,%eax
    3e50:	75 53                	jne    3ea5 <fwp_gc_commit+0xa5>
    3e52:	bf 1e 00 00 00       	mov    $0x1e,%edi
    3e57:	e8 d4 e5 ff ff       	call   2430 <sysconf@plt>
    3e5c:	48 8b 0d ad 04 01 00 	mov    0x104ad(%rip),%rcx        # 14310 <fwp_gc+0x1078>
    3e63:	48 69 3d 8a 04 01 00 	imul   $0x1228,0x1048a(%rip),%rdi        # 142f8 <fwp_gc+0x1060>
    3e6a:	28 12 00 00 
    3e6e:	48 01 cf             	add    %rcx,%rdi
    3e71:	48 69 d3 28 12 00 00 	imul   $0x1228,%rbx,%rdx
    3e78:	48 01 ca             	add    %rcx,%rdx
    3e7b:	48 8d 34 10          	lea    (%rax,%rdx,1),%rsi
    3e7f:	48 ff ce             	dec    %rsi
    3e82:	48 f7 d8             	neg    %rax
    3e85:	48 21 c7             	and    %rax,%rdi
    3e88:	48 21 c6             	and    %rax,%rsi
    3e8b:	48 29 fe             	sub    %rdi,%rsi
    3e8e:	ba 03 00 00 00       	mov    $0x3,%edx
    3e93:	e8 78 e5 ff ff       	call   2410 <mprotect@plt>
    3e98:	85 c0                	test   %eax,%eax
    3e9a:	75 09                	jne    3ea5 <fwp_gc_commit+0xa5>
    3e9c:	48 89 1d 55 04 01 00 	mov    %rbx,0x10455(%rip)        # 142f8 <fwp_gc+0x1060>
    3ea3:	5b                   	pop    %rbx
    3ea4:	c3                   	ret
    3ea5:	e8 56 fe ff ff       	call   3d00 <fwp_gc_oom>
    3eaa:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)

0000000000003eb0 <fwp_gc_collect>:
    3eb0:	83 3d d9 03 01 00 00 	cmpl   $0x0,0x103d9(%rip)        # 14290 <fwp_gc+0xff8>
    3eb7:	74 01                	je     3eba <fwp_gc_collect+0xa>
    3eb9:	c3                   	ret
    3eba:	55                   	push   %rbp
    3ebb:	48 89 e5             	mov    %rsp,%rbp
    3ebe:	41 57                	push   %r15
    3ec0:	41 56                	push   %r14
    3ec2:	41 55                	push   %r13
    3ec4:	41 54                	push   %r12
    3ec6:	53                   	push   %rbx
    3ec7:	48 81 ec e8 00 00 00 	sub    $0xe8,%rsp
    3ece:	c7 05 b8 03 01 00 01 	movl   $0x1,0x103b8(%rip)        # 14290 <fwp_gc+0xff8>
    3ed5:	00 00 00 
    3ed8:	48 8d 75 b8          	lea    -0x48(%rbp),%rsi
    3edc:	bf 01 00 00 00       	mov    $0x1,%edi
    3ee1:	e8 4a e2 ff ff       	call   2130 <clock_gettime@plt>
    3ee6:	48 8b 05 bb 05 01 00 	mov    0x105bb(%rip),%rax        # 144a8 <fwp_gc+0x1210>
    3eed:	48 2b 05 a4 f3 00 00 	sub    0xf3a4(%rip),%rax        # 13298 <fwp_gc>
    3ef4:	f2 48 0f 2a c0       	cvtsi2sd %rax,%xmm0
    3ef9:	f2 0f 58 05 7f 05 01 	addsd  0x1057f(%rip),%xmm0        # 14480 <fwp_gc+0x11e8>
    3f00:	00 
    3f01:	f2 0f 11 05 77 05 01 	movsd  %xmm0,0x10577(%rip)        # 14480 <fwp_gc+0x11e8>
    3f08:	00 
    3f09:	83 3d 88 03 01 00 00 	cmpl   $0x0,0x10388(%rip)        # 14298 <fwp_gc+0x1000>
    3f10:	0f 94 c0             	sete   %al
    3f13:	83 3d 86 03 01 00 00 	cmpl   $0x0,0x10386(%rip)        # 142a0 <fwp_gc+0x1008>
    3f1a:	0f 95 c3             	setne  %bl
    3f1d:	08 c3                	or     %al,%bl
    3f1f:	80 fb 01             	cmp    $0x1,%bl
    3f22:	75 3e                	jne    3f62 <fwp_gc_collect+0xb2>
    3f24:	e8 b7 01 00 00       	call   40e0 <fwp_gc_clear_marks>
    3f29:	48 8d bd f0 fe ff ff 	lea    -0x110(%rbp),%rdi
    3f30:	e8 7b e3 ff ff       	call   22b0 <_setjmp@plt>
    3f35:	48 c7 05 58 05 01 00 	movq   $0x0,0x10558(%rip)        # 14498 <fwp_gc+0x1200>
    3f3c:	00 00 00 00 
    3f40:	e8 1b 02 00 00       	call   4160 <fwp_gc_mark_all>
    3f45:	e8 36 07 00 00       	call   4680 <fwp_gc_finalize>
    3f4a:	e8 c1 07 00 00       	call   4710 <fwp_gc_sweep>
    3f4f:	48 8b 05 1a 05 01 00 	mov    0x1051a(%rip),%rax        # 14470 <fwp_gc+0x11d8>
    3f56:	48 ff c0             	inc    %rax
    3f59:	48 89 05 10 05 01 00 	mov    %rax,0x10510(%rip)        # 14470 <fwp_gc+0x11d8>
    3f60:	eb 51                	jmp    3fb3 <fwp_gc_collect+0x103>
    3f62:	48 8d bd f0 fe ff ff 	lea    -0x110(%rbp),%rdi
    3f69:	e8 42 e3 ff ff       	call   22b0 <_setjmp@plt>
    3f6e:	48 c7 05 1f 05 01 00 	movq   $0x0,0x1051f(%rip)        # 14498 <fwp_gc+0x1200>
    3f75:	00 00 00 00 
    3f79:	e8 e2 01 00 00       	call   4160 <fwp_gc_mark_all>
    3f7e:	e8 fd 01 00 00       	call   4180 <fwp_gc_scan_old_filled>
    3f83:	83 3d 12 03 01 00 00 	cmpl   $0x0,0x10312(%rip)        # 1429c <fwp_gc+0x1004>
    3f8a:	74 05                	je     3f91 <fwp_gc_collect+0xe1>
    3f8c:	e8 2f 03 00 00       	call   42c0 <fwp_gc_verify_minor>
    3f91:	e8 ea 06 00 00       	call   4680 <fwp_gc_finalize>
    3f96:	e8 75 07 00 00       	call   4710 <fwp_gc_sweep>
    3f9b:	48 8b 05 ce 04 01 00 	mov    0x104ce(%rip),%rax        # 14470 <fwp_gc+0x11d8>
    3fa2:	48 ff c0             	inc    %rax
    3fa5:	48 89 05 c4 04 01 00 	mov    %rax,0x104c4(%rip)        # 14470 <fwp_gc+0x11d8>
    3fac:	48 ff 05 fd 02 01 00 	incq   0x102fd(%rip)        # 142b0 <fwp_gc+0x1018>
    3fb3:	48 89 c1             	mov    %rax,%rcx
    3fb6:	48 8b 05 a3 04 01 00 	mov    0x104a3(%rip),%rax        # 14460 <fwp_gc+0x11c8>
    3fbd:	48 3b 05 a4 04 01 00 	cmp    0x104a4(%rip),%rax        # 14468 <fwp_gc+0x11d0>
    3fc4:	76 07                	jbe    3fcd <fwp_gc_collect+0x11d>
    3fc6:	48 89 05 9b 04 01 00 	mov    %rax,0x1049b(%rip)        # 14468 <fwp_gc+0x11d0>
    3fcd:	84 db                	test   %bl,%bl
    3fcf:	74 0b                	je     3fdc <fwp_gc_collect+0x12c>
    3fd1:	48 89 05 d0 02 01 00 	mov    %rax,0x102d0(%rip)        # 142a8 <fwp_gc+0x1010>
    3fd8:	31 d2                	xor    %edx,%edx
    3fda:	eb 2d                	jmp    4009 <fwp_gc_collect+0x159>
    3fdc:	48 8b 15 c5 02 01 00 	mov    0x102c5(%rip),%rdx        # 142a8 <fwp_gc+0x1010>
    3fe3:	48 89 d6             	mov    %rdx,%rsi
    3fe6:	48 d1 ee             	shr    $1,%rsi
    3fe9:	48 01 d6             	add    %rdx,%rsi
    3fec:	48 81 fe 01 00 00 01 	cmp    $0x1000001,%rsi
    3ff3:	ba 00 00 00 01       	mov    $0x1000000,%edx
    3ff8:	48 0f 43 d6          	cmovae %rsi,%rdx
    3ffc:	31 f6                	xor    %esi,%esi
    3ffe:	48 39 d0             	cmp    %rdx,%rax
    4001:	0f 97 c2             	seta   %dl
    4004:	40 88 d6             	mov    %dl,%sil
    4007:	89 f2                	mov    %esi,%edx
    4009:	f6 c1 07             	test   $0x7,%cl
    400c:	b9 01 00 00 00       	mov    $0x1,%ecx
    4011:	0f 45 ca             	cmovne %edx,%ecx
    4014:	48 83 3d 9c 02 01 00 	cmpq   $0x0,0x1029c(%rip)        # 142b8 <fwp_gc+0x1020>
    401b:	00 
    401c:	0f 44 ca             	cmove  %edx,%ecx
    401f:	89 0d 7b 02 01 00    	mov    %ecx,0x1027b(%rip)        # 142a0 <fwp_gc+0x1008>
    4025:	83 3d 6c 02 01 00 00 	cmpl   $0x0,0x1026c(%rip)        # 14298 <fwp_gc+0x1000>
    402c:	0f 94 c1             	sete   %cl
    402f:	48 d3 e0             	shl    %cl,%rax
    4032:	f2 48 0f 2c 0d 5d 04 	cvttsd2si 0x1045d(%rip),%rcx        # 14498 <fwp_gc+0x1200>
    4039:	01 00 
    403b:	48 01 c1             	add    %rax,%rcx
    403e:	48 81 f9 01 00 80 00 	cmp    $0x800001,%rcx
    4045:	b8 00 00 80 00       	mov    $0x800000,%eax
    404a:	48 0f 4d c1          	cmovge %rcx,%rax
    404e:	48 89 05 53 04 01 00 	mov    %rax,0x10453(%rip)        # 144a8 <fwp_gc+0x1210>
    4055:	48 89 05 3c f2 00 00 	mov    %rax,0xf23c(%rip)        # 13298 <fwp_gc>
    405c:	48 8d 75 c8          	lea    -0x38(%rbp),%rsi
    4060:	bf 01 00 00 00       	mov    $0x1,%edi
    4065:	e8 c6 e0 ff ff       	call   2130 <clock_gettime@plt>
    406a:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
    406e:	48 8b 4d d0          	mov    -0x30(%rbp),%rcx
    4072:	48 2b 45 b8          	sub    -0x48(%rbp),%rax
    4076:	f2 48 0f 2a c8       	cvtsi2sd %rax,%xmm1
    407b:	f2 0f 59 0d 95 8f 00 	mulsd  0x8f95(%rip),%xmm1        # d018 <_IO_stdin_used+0x18>
    4082:	00 
    4083:	48 2b 4d c0          	sub    -0x40(%rbp),%rcx
    4087:	0f 57 c0             	xorps  %xmm0,%xmm0
    408a:	f2 48 0f 2a c1       	cvtsi2sd %rcx,%xmm0
    408f:	f2 0f 5e 05 89 8f 00 	divsd  0x8f89(%rip),%xmm0        # d020 <_IO_stdin_used+0x20>
    4096:	00 
    4097:	f2 0f 58 c1          	addsd  %xmm1,%xmm0
    409b:	f2 0f 10 0d e5 03 01 	movsd  0x103e5(%rip),%xmm1        # 14488 <fwp_gc+0x11f0>
    40a2:	00 
    40a3:	f2 0f 58 c8          	addsd  %xmm0,%xmm1
    40a7:	f2 0f 11 0d d9 03 01 	movsd  %xmm1,0x103d9(%rip)        # 14488 <fwp_gc+0x11f0>
    40ae:	00 
    40af:	66 0f 2e 05 d9 03 01 	ucomisd 0x103d9(%rip),%xmm0        # 14490 <fwp_gc+0x11f8>
    40b6:	00 
    40b7:	48 8d a4 24 e8 00 00 	lea    0xe8(%rsp),%rsp
    40be:	00 
    40bf:	5b                   	pop    %rbx
    40c0:	41 5c                	pop    %r12
    40c2:	41 5d                	pop    %r13
    40c4:	41 5e                	pop    %r14
    40c6:	41 5f                	pop    %r15
    40c8:	5d                   	pop    %rbp
    40c9:	76 08                	jbe    40d3 <fwp_gc_collect+0x223>
    40cb:	f2 0f 11 05 bd 03 01 	movsd  %xmm0,0x103bd(%rip)        # 14490 <fwp_gc+0x11f8>
    40d2:	00 
    40d3:	c7 05 b3 01 01 00 00 	movl   $0x0,0x101b3(%rip)        # 14290 <fwp_gc+0xff8>
    40da:	00 00 00 
    40dd:	c3                   	ret
    40de:	66 90                	xchg   %ax,%ax

00000000000040e0 <fwp_gc_clear_marks>:
    40e0:	48 8b 05 09 02 01 00 	mov    0x10209(%rip),%rax        # 142f0 <fwp_gc+0x1058>
    40e7:	48 85 c0             	test   %rax,%rax
    40ea:	74 69                	je     4155 <fwp_gc_clear_marks+0x75>
    40ec:	41 56                	push   %r14
    40ee:	53                   	push   %rbx
    40ef:	50                   	push   %rax
    40f0:	48 8b 0d 19 02 01 00 	mov    0x10219(%rip),%rcx        # 14310 <fwp_gc+0x1078>
    40f7:	31 db                	xor    %ebx,%ebx
    40f9:	45 31 f6             	xor    %r14d,%r14d
    40fc:	eb 16                	jmp    4114 <fwp_gc_clear_marks+0x34>
    40fe:	66 90                	xchg   %ax,%ax
    4100:	c6 44 19 03 00       	movb   $0x0,0x3(%rcx,%rbx,1)
    4105:	49 ff c6             	inc    %r14
    4108:	48 81 c3 28 12 00 00 	add    $0x1228,%rbx
    410f:	49 39 c6             	cmp    %rax,%r14
    4112:	73 3a                	jae    414e <fwp_gc_clear_marks+0x6e>
    4114:	0f b6 14 19          	movzbl (%rcx,%rbx,1),%edx
    4118:	83 fa 02             	cmp    $0x2,%edx
    411b:	74 e3                	je     4100 <fwp_gc_clear_marks+0x20>
    411d:	83 fa 01             	cmp    $0x1,%edx
    4120:	75 e3                	jne    4105 <fwp_gc_clear_marks+0x25>
    4122:	48 8d 3c 19          	lea    (%rcx,%rbx,1),%rdi
    4126:	48 83 c7 28          	add    $0x28,%rdi
    412a:	8b 54 19 0c          	mov    0xc(%rcx,%rbx,1),%edx
    412e:	83 c2 3f             	add    $0x3f,%edx
    4131:	c1 ea 03             	shr    $0x3,%edx
    4134:	83 e2 f8             	and    $0xfffffff8,%edx
    4137:	31 f6                	xor    %esi,%esi
    4139:	e8 d2 e0 ff ff       	call   2210 <memset@plt>
    413e:	48 8b 0d cb 01 01 00 	mov    0x101cb(%rip),%rcx        # 14310 <fwp_gc+0x1078>
    4145:	48 8b 05 a4 01 01 00 	mov    0x101a4(%rip),%rax        # 142f0 <fwp_gc+0x1058>
    414c:	eb b7                	jmp    4105 <fwp_gc_clear_marks+0x25>
    414e:	48 83 c4 08          	add    $0x8,%rsp
    4152:	5b                   	pop    %rbx
    4153:	41 5e                	pop    %r14
    4155:	c3                   	ret
    4156:	66 2e 0f 1f 84 00 00 	cs nopw 0x0(%rax,%rax,1)
    415d:	00 00 00 

0000000000004160 <fwp_gc_mark_all>:
    4160:	50                   	push   %rax
    4161:	e8 4a 0c 00 00       	call   4db0 <fwp_gc_sp>
    4166:	48 89 c7             	mov    %rax,%rdi
    4169:	e8 32 0c 00 00       	call   4da0 <fwp_gc_scan_stacks>
    416e:	e8 4d 0c 00 00       	call   4dc0 <fwp_gc_drain>
    4173:	e8 98 0c 00 00       	call   4e10 <fwp_gc_scan_data>
    4178:	58                   	pop    %rax
    4179:	e9 42 0c 00 00       	jmp    4dc0 <fwp_gc_drain>
    417e:	66 90                	xchg   %ax,%ax

0000000000004180 <fwp_gc_scan_old_filled>:
    4180:	48 83 3d 68 01 01 00 	cmpq   $0x0,0x10168(%rip)        # 142f0 <fwp_gc+0x1058>
    4187:	00 
    4188:	0f 84 32 0c 00 00    	je     4dc0 <fwp_gc_drain>
    418e:	55                   	push   %rbp
    418f:	41 57                	push   %r15
    4191:	41 56                	push   %r14
    4193:	41 55                	push   %r13
    4195:	41 54                	push   %r12
    4197:	53                   	push   %rbx
    4198:	48 83 ec 18          	sub    $0x18,%rsp
    419c:	31 c0                	xor    %eax,%eax
    419e:	eb 14                	jmp    41b4 <fwp_gc_scan_old_filled+0x34>
    41a0:	48 8b 04 24          	mov    (%rsp),%rax
    41a4:	48 ff c0             	inc    %rax
    41a7:	48 3b 05 42 01 01 00 	cmp    0x10142(%rip),%rax        # 142f0 <fwp_gc+0x1058>
    41ae:	0f 83 f6 00 00 00    	jae    42aa <fwp_gc_scan_old_filled+0x12a>
    41b4:	48 8b 0d 55 01 01 00 	mov    0x10155(%rip),%rcx        # 14310 <fwp_gc+0x1078>
    41bb:	48 89 04 24          	mov    %rax,(%rsp)
    41bf:	48 69 e8 28 12 00 00 	imul   $0x1228,%rax,%rbp
    41c6:	80 7c 29 01 02       	cmpb   $0x2,0x1(%rcx,%rbp,1)
    41cb:	75 d3                	jne    41a0 <fwp_gc_scan_old_filled+0x20>
    41cd:	48 89 cb             	mov    %rcx,%rbx
    41d0:	0f b6 04 29          	movzbl (%rcx,%rbp,1),%eax
    41d4:	83 f8 02             	cmp    $0x2,%eax
    41d7:	0f 84 a7 00 00 00    	je     4284 <fwp_gc_scan_old_filled+0x104>
    41dd:	83 f8 01             	cmp    $0x1,%eax
    41e0:	75 be                	jne    41a0 <fwp_gc_scan_old_filled+0x20>
    41e2:	48 8b 3c 24          	mov    (%rsp),%rdi
    41e6:	e8 65 eb ff ff       	call   2d50 <fwp_gc_chunk_addr>
    41eb:	49 89 c6             	mov    %rax,%r14
    41ee:	8b 44 2b 0c          	mov    0xc(%rbx,%rbp,1),%eax
    41f2:	83 c0 3f             	add    $0x3f,%eax
    41f5:	48 89 44 24 08       	mov    %rax,0x8(%rsp)
    41fa:	83 f8 40             	cmp    $0x40,%eax
    41fd:	72 a1                	jb     41a0 <fwp_gc_scan_old_filled+0x20>
    41ff:	48 8b 44 24 08       	mov    0x8(%rsp),%rax
    4204:	c1 e8 06             	shr    $0x6,%eax
    4207:	48 89 44 24 08       	mov    %rax,0x8(%rsp)
    420c:	4c 8d 2c 2b          	lea    (%rbx,%rbp,1),%r13
    4210:	49 83 c5 08          	add    $0x8,%r13
    4214:	48 01 eb             	add    %rbp,%rbx
    4217:	48 89 5c 24 10       	mov    %rbx,0x10(%rsp)
    421c:	45 31 ff             	xor    %r15d,%r15d
    421f:	eb 1d                	jmp    423e <fwp_gc_scan_old_filled+0xbe>
    4221:	66 66 66 66 66 66 2e 	data16 data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    4228:	0f 1f 84 00 00 00 00 
    422f:	00 
    4230:	49 ff c7             	inc    %r15
    4233:	4c 3b 7c 24 08       	cmp    0x8(%rsp),%r15
    4238:	0f 84 62 ff ff ff    	je     41a0 <fwp_gc_scan_old_filled+0x20>
    423e:	48 8b 44 24 10       	mov    0x10(%rsp),%rax
    4243:	4e 8b 64 f8 28       	mov    0x28(%rax,%r15,8),%r12
    4248:	4d 85 e4             	test   %r12,%r12
    424b:	74 e3                	je     4230 <fwp_gc_scan_old_filled+0xb0>
    424d:	4c 89 fd             	mov    %r15,%rbp
    4250:	48 c1 e5 06          	shl    $0x6,%rbp
    4254:	66 66 66 2e 0f 1f 84 	data16 data16 cs nopw 0x0(%rax,%rax,1)
    425b:	00 00 00 00 00 
    4260:	f3 49 0f bc fc       	tzcnt  %r12,%rdi
    4265:	48 09 ef             	or     %rbp,%rdi
    4268:	49 8d 5c 24 ff       	lea    -0x1(%r12),%rbx
    426d:	41 8b 75 00          	mov    0x0(%r13),%esi
    4271:	48 0f af fe          	imul   %rsi,%rdi
    4275:	4c 01 f7             	add    %r14,%rdi
    4278:	e8 03 0e 00 00       	call   5080 <fwp_gc_push>
    427d:	49 21 dc             	and    %rbx,%r12
    4280:	75 de                	jne    4260 <fwp_gc_scan_old_filled+0xe0>
    4282:	eb ac                	jmp    4230 <fwp_gc_scan_old_filled+0xb0>
    4284:	80 7c 2b 03 00       	cmpb   $0x0,0x3(%rbx,%rbp,1)
    4289:	0f 84 11 ff ff ff    	je     41a0 <fwp_gc_scan_old_filled+0x20>
    428f:	48 8b 3c 24          	mov    (%rsp),%rdi
    4293:	e8 b8 ea ff ff       	call   2d50 <fwp_gc_chunk_addr>
    4298:	48 8b 74 2b 18       	mov    0x18(%rbx,%rbp,1),%rsi
    429d:	48 89 c7             	mov    %rax,%rdi
    42a0:	e8 db 0d 00 00       	call   5080 <fwp_gc_push>
    42a5:	e9 f6 fe ff ff       	jmp    41a0 <fwp_gc_scan_old_filled+0x20>
    42aa:	48 83 c4 18          	add    $0x18,%rsp
    42ae:	5b                   	pop    %rbx
    42af:	41 5c                	pop    %r12
    42b1:	41 5d                	pop    %r13
    42b3:	41 5e                	pop    %r14
    42b5:	41 5f                	pop    %r15
    42b7:	5d                   	pop    %rbp
    42b8:	e9 03 0b 00 00       	jmp    4dc0 <fwp_gc_drain>
    42bd:	0f 1f 00             	nopl   (%rax)

00000000000042c0 <fwp_gc_verify_minor>:
    42c0:	55                   	push   %rbp
    42c1:	41 57                	push   %r15
    42c3:	41 56                	push   %r14
    42c5:	41 55                	push   %r13
    42c7:	41 54                	push   %r12
    42c9:	53                   	push   %rbx
    42ca:	48 83 ec 58          	sub    $0x58,%rsp
    42ce:	4c 8b 2d 1b 00 01 00 	mov    0x1001b(%rip),%r13        # 142f0 <fwp_gc+0x1058>
    42d5:	4c 89 ef             	mov    %r13,%rdi
    42d8:	48 c1 e7 09          	shl    $0x9,%rdi
    42dc:	e8 5f e0 ff ff       	call   2340 <malloc@plt>
    42e1:	48 89 c3             	mov    %rax,%rbx
    42e4:	49 83 fd 01          	cmp    $0x1,%r13
    42e8:	4c 89 ef             	mov    %r13,%rdi
    42eb:	48 83 d7 00          	adc    $0x0,%rdi
    42ef:	48 89 7c 24 30       	mov    %rdi,0x30(%rsp)
    42f4:	e8 47 e0 ff ff       	call   2340 <malloc@plt>
    42f9:	48 89 5c 24 20       	mov    %rbx,0x20(%rsp)
    42fe:	48 85 db             	test   %rbx,%rbx
    4301:	0f 84 74 03 00 00    	je     467b <fwp_gc_verify_minor+0x3bb>
    4307:	49 89 c7             	mov    %rax,%r15
    430a:	48 85 c0             	test   %rax,%rax
    430d:	0f 84 68 03 00 00    	je     467b <fwp_gc_verify_minor+0x3bb>
    4313:	4d 85 ed             	test   %r13,%r13
    4316:	74 1c                	je     4334 <fwp_gc_verify_minor+0x74>
    4318:	48 8b 0d f1 ff 00 00 	mov    0xfff1(%rip),%rcx        # 14310 <fwp_gc+0x1078>
    431f:	49 83 fd 01          	cmp    $0x1,%r13
    4323:	48 89 4c 24 28       	mov    %rcx,0x28(%rsp)
    4328:	75 19                	jne    4343 <fwp_gc_verify_minor+0x83>
    432a:	4d 89 ec             	mov    %r13,%r12
    432d:	31 ed                	xor    %ebp,%ebp
    432f:	e9 81 00 00 00       	jmp    43b5 <fwp_gc_verify_minor+0xf5>
    4334:	e8 a7 fd ff ff       	call   40e0 <fwp_gc_clear_marks>
    4339:	e8 22 fe ff ff       	call   4160 <fwp_gc_mark_all>
    433e:	e9 13 03 00 00       	jmp    4656 <fwp_gc_verify_minor+0x396>
    4343:	4d 89 ec             	mov    %r13,%r12
    4346:	49 83 e5 fe          	and    $0xfffffffffffffffe,%r13
    434a:	48 8b 44 24 20       	mov    0x20(%rsp),%rax
    434f:	48 8d 98 00 02 00 00 	lea    0x200(%rax),%rbx
    4356:	4c 8d b1 50 12 00 00 	lea    0x1250(%rcx),%r14
    435d:	31 ed                	xor    %ebp,%ebp
    435f:	90                   	nop
    4360:	48 8d bb 00 fe ff ff 	lea    -0x200(%rbx),%rdi
    4367:	49 8d b6 d8 ed ff ff 	lea    -0x1228(%r14),%rsi
    436e:	ba 00 02 00 00       	mov    $0x200,%edx
    4373:	e8 b8 df ff ff       	call   2330 <memcpy@plt>
    4378:	41 0f b6 86 b3 ed ff 	movzbl -0x124d(%r14),%eax
    437f:	ff 
    4380:	41 88 04 2f          	mov    %al,(%r15,%rbp,1)
    4384:	ba 00 02 00 00       	mov    $0x200,%edx
    4389:	48 89 df             	mov    %rbx,%rdi
    438c:	4c 89 f6             	mov    %r14,%rsi
    438f:	e8 9c df ff ff       	call   2330 <memcpy@plt>
    4394:	41 0f b6 46 db       	movzbl -0x25(%r14),%eax
    4399:	41 88 44 2f 01       	mov    %al,0x1(%r15,%rbp,1)
    439e:	48 83 c5 02          	add    $0x2,%rbp
    43a2:	48 81 c3 00 04 00 00 	add    $0x400,%rbx
    43a9:	49 81 c6 50 24 00 00 	add    $0x2450,%r14
    43b0:	49 39 ed             	cmp    %rbp,%r13
    43b3:	75 ab                	jne    4360 <fwp_gc_verify_minor+0xa0>
    43b5:	4d 89 e5             	mov    %r12,%r13
    43b8:	41 f6 c5 01          	test   $0x1,%r13b
    43bc:	74 34                	je     43f2 <fwp_gc_verify_minor+0x132>
    43be:	48 89 ef             	mov    %rbp,%rdi
    43c1:	48 c1 e7 09          	shl    $0x9,%rdi
    43c5:	48 03 7c 24 20       	add    0x20(%rsp),%rdi
    43ca:	48 69 dd 28 12 00 00 	imul   $0x1228,%rbp,%rbx
    43d1:	4c 8b 74 24 28       	mov    0x28(%rsp),%r14
    43d6:	49 8d 34 1e          	lea    (%r14,%rbx,1),%rsi
    43da:	48 83 c6 28          	add    $0x28,%rsi
    43de:	ba 00 02 00 00       	mov    $0x200,%edx
    43e3:	e8 48 df ff ff       	call   2330 <memcpy@plt>
    43e8:	41 0f b6 44 1e 03    	movzbl 0x3(%r14,%rbx,1),%eax
    43ee:	41 88 04 2f          	mov    %al,(%r15,%rbp,1)
    43f2:	e8 e9 fc ff ff       	call   40e0 <fwp_gc_clear_marks>
    43f7:	e8 64 fd ff ff       	call   4160 <fwp_gc_mark_all>
    43fc:	4d 85 ed             	test   %r13,%r13
    43ff:	0f 84 51 02 00 00    	je     4656 <fwp_gc_verify_minor+0x396>
    4405:	48 8b 1d 04 ff 00 00 	mov    0xff04(%rip),%rbx        # 14310 <fwp_gc+0x1078>
    440c:	48 8d 43 28          	lea    0x28(%rbx),%rax
    4410:	48 8b 4c 24 20       	mov    0x20(%rsp),%rcx
    4415:	31 ff                	xor    %edi,%edi
    4417:	eb 30                	jmp    4449 <fwp_gc_verify_minor+0x189>
    4419:	4d 85 c9             	test   %r9,%r9
    441c:	0f 85 b8 00 00 00    	jne    44da <fwp_gc_verify_minor+0x21a>
    4422:	66 66 66 66 66 2e 0f 	data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    4429:	1f 84 00 00 00 00 00 
    4430:	48 ff c7             	inc    %rdi
    4433:	48 81 c1 00 02 00 00 	add    $0x200,%rcx
    443a:	48 05 28 12 00 00    	add    $0x1228,%rax
    4440:	4c 39 ef             	cmp    %r13,%rdi
    4443:	0f 84 0d 02 00 00    	je     4656 <fwp_gc_verify_minor+0x396>
    4449:	4c 69 f7 28 12 00 00 	imul   $0x1228,%rdi,%r14
    4450:	42 0f b6 2c 33       	movzbl (%rbx,%r14,1),%ebp
    4455:	83 fd 02             	cmp    $0x2,%ebp
    4458:	74 66                	je     44c0 <fwp_gc_verify_minor+0x200>
    445a:	83 fd 01             	cmp    $0x1,%ebp
    445d:	75 d1                	jne    4430 <fwp_gc_verify_minor+0x170>
    445f:	42 8b 54 33 0c       	mov    0xc(%rbx,%r14,1),%edx
    4464:	83 c2 3f             	add    $0x3f,%edx
    4467:	83 fa 40             	cmp    $0x40,%edx
    446a:	72 c4                	jb     4430 <fwp_gc_verify_minor+0x170>
    446c:	c1 ea 06             	shr    $0x6,%edx
    446f:	31 f6                	xor    %esi,%esi
    4471:	45 31 e4             	xor    %r12d,%r12d
    4474:	45 31 c0             	xor    %r8d,%r8d
    4477:	66 0f 1f 84 00 00 00 	nopw   0x0(%rax,%rax,1)
    447e:	00 00 
    4480:	4e 8b 0c c1          	mov    (%rcx,%r8,8),%r9
    4484:	49 f7 d1             	not    %r9
    4487:	4e 23 0c c0          	and    (%rax,%r8,8),%r9
    448b:	4d 89 e2             	mov    %r12,%r10
    448e:	f3 4d 0f bc e1       	tzcnt  %r9,%r12
    4493:	49 01 f4             	add    %rsi,%r12
    4496:	4d 85 c9             	test   %r9,%r9
    4499:	4d 0f 44 e2          	cmove  %r10,%r12
    449d:	49 ff c0             	inc    %r8
    44a0:	49 39 d0             	cmp    %rdx,%r8
    44a3:	0f 83 70 ff ff ff    	jae    4419 <fwp_gc_verify_minor+0x159>
    44a9:	48 83 c6 40          	add    $0x40,%rsi
    44ad:	4d 85 c9             	test   %r9,%r9
    44b0:	74 ce                	je     4480 <fwp_gc_verify_minor+0x1c0>
    44b2:	e9 62 ff ff ff       	jmp    4419 <fwp_gc_verify_minor+0x159>
    44b7:	66 0f 1f 84 00 00 00 	nopw   0x0(%rax,%rax,1)
    44be:	00 00 
    44c0:	42 80 7c 33 03 00    	cmpb   $0x0,0x3(%rbx,%r14,1)
    44c6:	0f 84 64 ff ff ff    	je     4430 <fwp_gc_verify_minor+0x170>
    44cc:	41 80 3c 3f 00       	cmpb   $0x0,(%r15,%rdi,1)
    44d1:	0f 85 59 ff ff ff    	jne    4430 <fwp_gc_verify_minor+0x170>
    44d7:	45 31 e4             	xor    %r12d,%r12d
    44da:	e8 71 e8 ff ff       	call   2d50 <fwp_gc_chunk_addr>
    44df:	46 8b 7c 33 08       	mov    0x8(%rbx,%r14,1),%r15d
    44e4:	4d 0f af e7          	imul   %r15,%r12
    44e8:	49 01 c4             	add    %rax,%r12
    44eb:	40 80 fd 01          	cmp    $0x1,%bpl
    44ef:	74 05                	je     44f6 <fwp_gc_verify_minor+0x236>
    44f1:	4e 8b 7c 33 18       	mov    0x18(%rbx,%r14,1),%r15
    44f6:	48 8b 05 db ea 00 00 	mov    0xeadb(%rip),%rax        # 12fd8 <stderr@GLIBC_2.2.5>
    44fd:	48 8b 38             	mov    (%rax),%rdi
    4500:	42 0f b6 4c 33 01    	movzbl 0x1(%rbx,%r14,1),%ecx
    4506:	48 8d 35 69 92 00 00 	lea    0x9269(%rip),%rsi        # d776 <exec_in_fp0+0x136>
    450d:	4c 89 e2             	mov    %r12,%rdx
    4510:	4d 89 f8             	mov    %r15,%r8
    4513:	31 c0                	xor    %eax,%eax
    4515:	e8 d6 dd ff ff       	call   22f0 <fprintf@plt>
    451a:	4d 01 e7             	add    %r12,%r15
    451d:	45 31 ed             	xor    %r13d,%r13d
    4520:	4c 89 7c 24 40       	mov    %r15,0x40(%rsp)
    4525:	eb 17                	jmp    453e <fwp_gc_verify_minor+0x27e>
    4527:	66 0f 1f 84 00 00 00 	nopw   0x0(%rax,%rax,1)
    452e:	00 00 
    4530:	49 ff c5             	inc    %r13
    4533:	4c 3b 6c 24 30       	cmp    0x30(%rsp),%r13
    4538:	0f 84 38 01 00 00    	je     4676 <fwp_gc_verify_minor+0x3b6>
    453e:	48 8b 05 cb fd 00 00 	mov    0xfdcb(%rip),%rax        # 14310 <fwp_gc+0x1078>
    4545:	49 69 cd 28 12 00 00 	imul   $0x1228,%r13,%rcx
    454c:	80 3c 08 01          	cmpb   $0x1,(%rax,%rcx,1)
    4550:	75 de                	jne    4530 <fwp_gc_verify_minor+0x270>
    4552:	80 7c 08 01 01       	cmpb   $0x1,0x1(%rax,%rcx,1)
    4557:	74 d7                	je     4530 <fwp_gc_verify_minor+0x270>
    4559:	8b 5c 08 0c          	mov    0xc(%rax,%rcx,1),%ebx
    455d:	85 db                	test   %ebx,%ebx
    455f:	74 cf                	je     4530 <fwp_gc_verify_minor+0x270>
    4561:	48 01 c8             	add    %rcx,%rax
    4564:	48 ff c0             	inc    %rax
    4567:	48 89 44 24 28       	mov    %rax,0x28(%rsp)
    456c:	4c 89 e8             	mov    %r13,%rax
    456f:	48 c1 e0 09          	shl    $0x9,%rax
    4573:	48 03 44 24 20       	add    0x20(%rsp),%rax
    4578:	48 89 44 24 50       	mov    %rax,0x50(%rsp)
    457d:	31 ed                	xor    %ebp,%ebp
    457f:	4c 89 6c 24 38       	mov    %r13,0x38(%rsp)
    4584:	eb 21                	jmp    45a7 <fwp_gc_verify_minor+0x2e7>
    4586:	66 2e 0f 1f 84 00 00 	cs nopw 0x0(%rax,%rax,1)
    458d:	00 00 00 
    4590:	48 8b 44 24 28       	mov    0x28(%rsp),%rax
    4595:	8b 58 0b             	mov    0xb(%rax),%ebx
    4598:	4c 8b 6c 24 38       	mov    0x38(%rsp),%r13
    459d:	48 ff c5             	inc    %rbp
    45a0:	89 d8                	mov    %ebx,%eax
    45a2:	48 39 c5             	cmp    %rax,%rbp
    45a5:	73 89                	jae    4530 <fwp_gc_verify_minor+0x270>
    45a7:	48 89 e8             	mov    %rbp,%rax
    45aa:	48 c1 e8 06          	shr    $0x6,%rax
    45ae:	48 8b 4c 24 50       	mov    0x50(%rsp),%rcx
    45b3:	48 8b 04 c1          	mov    (%rcx,%rax,8),%rax
    45b7:	48 0f a3 e8          	bt     %rbp,%rax
    45bb:	73 e0                	jae    459d <fwp_gc_verify_minor+0x2dd>
    45bd:	4c 89 ef             	mov    %r13,%rdi
    45c0:	e8 8b e7 ff ff       	call   2d50 <fwp_gc_chunk_addr>
    45c5:	48 89 c2             	mov    %rax,%rdx
    45c8:	48 8b 44 24 28       	mov    0x28(%rsp),%rax
    45cd:	44 8b 70 07          	mov    0x7(%rax),%r14d
    45d1:	49 83 fe 08          	cmp    $0x8,%r14
    45d5:	72 c6                	jb     459d <fwp_gc_verify_minor+0x2dd>
    45d7:	45 89 f0             	mov    %r14d,%r8d
    45da:	4c 0f af f5          	imul   %rbp,%r14
    45de:	48 89 d3             	mov    %rdx,%rbx
    45e1:	4c 01 f3             	add    %r14,%rbx
    45e4:	45 31 ed             	xor    %r13d,%r13d
    45e7:	48 89 54 24 48       	mov    %rdx,0x48(%rsp)
    45ec:	eb 10                	jmp    45fe <fwp_gc_verify_minor+0x33e>
    45ee:	66 90                	xchg   %ax,%ax
    45f0:	49 ff c5             	inc    %r13
    45f3:	44 89 c0             	mov    %r8d,%eax
    45f6:	c1 e8 03             	shr    $0x3,%eax
    45f9:	49 39 c5             	cmp    %rax,%r13
    45fc:	73 92                	jae    4590 <fwp_gc_verify_minor+0x2d0>
    45fe:	4a 8b 04 eb          	mov    (%rbx,%r13,8),%rax
    4602:	4c 39 e0             	cmp    %r12,%rax
    4605:	72 e9                	jb     45f0 <fwp_gc_verify_minor+0x330>
    4607:	4c 39 f8             	cmp    %r15,%rax
    460a:	73 e4                	jae    45f0 <fwp_gc_verify_minor+0x330>
    460c:	48 8b 05 c5 e9 00 00 	mov    0xe9c5(%rip),%rax        # 12fd8 <stderr@GLIBC_2.2.5>
    4613:	48 8b 38             	mov    (%rax),%rdi
    4616:	4c 8b 7c 24 28       	mov    0x28(%rsp),%r15
    461b:	41 0f b6 0f          	movzbl (%r15),%ecx
    461f:	42 0f 10 04 32       	movups (%rdx,%r14,1),%xmm0
    4624:	4a 8b 44 32 10       	mov    0x10(%rdx,%r14,1),%rax
    4629:	48 89 44 24 10       	mov    %rax,0x10(%rsp)
    462e:	0f 11 04 24          	movups %xmm0,(%rsp)
    4632:	48 8d 35 97 91 00 00 	lea    0x9197(%rip),%rsi        # d7d0 <exec_in_fp0+0x190>
    4639:	48 89 da             	mov    %rbx,%rdx
    463c:	4d 89 e9             	mov    %r13,%r9
    463f:	31 c0                	xor    %eax,%eax
    4641:	e8 aa dc ff ff       	call   22f0 <fprintf@plt>
    4646:	48 8b 54 24 48       	mov    0x48(%rsp),%rdx
    464b:	45 8b 47 07          	mov    0x7(%r15),%r8d
    464f:	4c 8b 7c 24 40       	mov    0x40(%rsp),%r15
    4654:	eb 9a                	jmp    45f0 <fwp_gc_verify_minor+0x330>
    4656:	48 8b 7c 24 20       	mov    0x20(%rsp),%rdi
    465b:	e8 f0 d9 ff ff       	call   2050 <free@plt>
    4660:	4c 89 ff             	mov    %r15,%rdi
    4663:	48 83 c4 58          	add    $0x58,%rsp
    4667:	5b                   	pop    %rbx
    4668:	41 5c                	pop    %r12
    466a:	41 5d                	pop    %r13
    466c:	41 5e                	pop    %r14
    466e:	41 5f                	pop    %r15
    4670:	5d                   	pop    %rbp
    4671:	e9 da d9 ff ff       	jmp    2050 <free@plt>
    4676:	e8 f5 d9 ff ff       	call   2070 <abort@plt>
    467b:	e8 80 f6 ff ff       	call   3d00 <fwp_gc_oom>

0000000000004680 <fwp_gc_finalize>:
    4680:	41 57                	push   %r15
    4682:	41 56                	push   %r14
    4684:	41 55                	push   %r13
    4686:	41 54                	push   %r12
    4688:	53                   	push   %rbx
    4689:	4c 8b 3d c0 fd 00 00 	mov    0xfdc0(%rip),%r15        # 14450 <fwp_gc+0x11b8>
    4690:	4d 85 ff             	test   %r15,%r15
    4693:	74 71                	je     4706 <fwp_gc_finalize+0x86>
    4695:	4c 8b 25 ac fd 00 00 	mov    0xfdac(%rip),%r12        # 14448 <fwp_gc+0x11b0>
    469c:	45 31 f6             	xor    %r14d,%r14d
    469f:	eb 46                	jmp    46e7 <fwp_gc_finalize+0x67>
    46a1:	66 66 66 66 66 66 2e 	data16 data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    46a8:	0f 1f 84 00 00 00 00 
    46af:	00 
    46b0:	4d 01 e5             	add    %r12,%r13
    46b3:	49 8b 45 08          	mov    0x8(%r13),%rax
    46b7:	49 ff cf             	dec    %r15
    46ba:	4c 89 3d 8f fd 00 00 	mov    %r15,0xfd8f(%rip)        # 14450 <fwp_gc+0x11b8>
    46c1:	49 c1 e7 04          	shl    $0x4,%r15
    46c5:	43 0f 10 04 3c       	movups (%r12,%r15,1),%xmm0
    46ca:	41 0f 11 45 00       	movups %xmm0,0x0(%r13)
    46cf:	48 89 df             	mov    %rbx,%rdi
    46d2:	ff d0                	call   *%rax
    46d4:	4c 8b 25 6d fd 00 00 	mov    0xfd6d(%rip),%r12        # 14448 <fwp_gc+0x11b0>
    46db:	4c 8b 3d 6e fd 00 00 	mov    0xfd6e(%rip),%r15        # 14450 <fwp_gc+0x11b8>
    46e2:	4d 39 fe             	cmp    %r15,%r14
    46e5:	73 1f                	jae    4706 <fwp_gc_finalize+0x86>
    46e7:	4d 89 f5             	mov    %r14,%r13
    46ea:	49 c1 e5 04          	shl    $0x4,%r13
    46ee:	4b 8b 1c 2c          	mov    (%r12,%r13,1),%rbx
    46f2:	48 89 df             	mov    %rbx,%rdi
    46f5:	e8 06 0a 00 00       	call   5100 <fwp_gc_marked>
    46fa:	85 c0                	test   %eax,%eax
    46fc:	74 b2                	je     46b0 <fwp_gc_finalize+0x30>
    46fe:	49 ff c6             	inc    %r14
    4701:	4d 39 fe             	cmp    %r15,%r14
    4704:	72 e1                	jb     46e7 <fwp_gc_finalize+0x67>
    4706:	5b                   	pop    %rbx
    4707:	41 5c                	pop    %r12
    4709:	41 5d                	pop    %r13
    470b:	41 5e                	pop    %r14
    470d:	41 5f                	pop    %r15
    470f:	c3                   	ret

0000000000004710 <fwp_gc_sweep>:
    4710:	55                   	push   %rbp
    4711:	41 57                	push   %r15
    4713:	41 56                	push   %r14
    4715:	41 55                	push   %r13
    4717:	41 54                	push   %r12
    4719:	53                   	push   %rbx
    471a:	48 83 ec 28          	sub    $0x28,%rsp
    471e:	48 8d 3d 7b eb 00 00 	lea    0xeb7b(%rip),%rdi        # 132a0 <fwp_gc+0x8>
    4725:	45 31 ff             	xor    %r15d,%r15d
    4728:	ba 40 0b 00 00       	mov    $0xb40,%edx
    472d:	31 f6                	xor    %esi,%esi
    472f:	e8 dc da ff ff       	call   2210 <memset@plt>
    4734:	48 83 3d b4 fb 00 00 	cmpq   $0x0,0xfbb4(%rip)        # 142f0 <fwp_gc+0x1058>
    473b:	00 
    473c:	0f 84 06 05 00 00    	je     4c48 <fwp_gc_sweep+0x538>
    4742:	31 c0                	xor    %eax,%eax
    4744:	48 89 44 24 08       	mov    %rax,0x8(%rsp)
    4749:	49 be 55 55 55 55 55 	movabs $0x5555555555555555,%r14
    4750:	55 55 55 
    4753:	49 b9 33 33 33 33 33 	movabs $0x3333333333333333,%r9
    475a:	33 33 33 
    475d:	49 ba 0f 0f 0f 0f 0f 	movabs $0xf0f0f0f0f0f0f0f,%r10
    4764:	0f 0f 0f 
    4767:	49 bb 01 01 01 01 01 	movabs $0x101010101010101,%r11
    476e:	01 01 01 
    4771:	66 0f 6f 2d 77 89 00 	movdqa 0x8977(%rip),%xmm5        # d0f0 <_IO_stdin_used+0xf0>
    4778:	00 
    4779:	66 0f 6f 35 7f 89 00 	movdqa 0x897f(%rip),%xmm6        # d100 <_IO_stdin_used+0x100>
    4780:	00 
    4781:	66 0f 6f 3d 87 89 00 	movdqa 0x8987(%rip),%xmm7        # d110 <_IO_stdin_used+0x110>
    4788:	00 
    4789:	66 45 0f ef c0       	pxor   %xmm8,%xmm8
    478e:	45 31 ff             	xor    %r15d,%r15d
    4791:	31 db                	xor    %ebx,%ebx
    4793:	eb 63                	jmp    47f8 <fwp_gc_sweep+0xe8>
    4795:	4c 8b 64 24 10       	mov    0x10(%rsp),%r12
    479a:	4c 89 e7             	mov    %r12,%rdi
    479d:	e8 ee 09 00 00       	call   5190 <fwp_rc_clear_chunk>
    47a2:	66 45 0f ef c0       	pxor   %xmm8,%xmm8
    47a7:	66 0f 6f 3d 61 89 00 	movdqa 0x8961(%rip),%xmm7        # d110 <_IO_stdin_used+0x110>
    47ae:	00 
    47af:	66 0f 6f 35 49 89 00 	movdqa 0x8949(%rip),%xmm6        # d100 <_IO_stdin_used+0x100>
    47b6:	00 
    47b7:	66 0f 6f 2d 31 89 00 	movdqa 0x8931(%rip),%xmm5        # d0f0 <_IO_stdin_used+0xf0>
    47be:	00 
    47bf:	49 bb 01 01 01 01 01 	movabs $0x101010101010101,%r11
    47c6:	01 01 01 
    47c9:	49 ba 0f 0f 0f 0f 0f 	movabs $0xf0f0f0f0f0f0f0f,%r10
    47d0:	0f 0f 0f 
    47d3:	49 b9 33 33 33 33 33 	movabs $0x3333333333333333,%r9
    47da:	33 33 33 
    47dd:	41 c6 04 24 00       	movb   $0x0,(%r12)
    47e2:	49 ff c7             	inc    %r15
    47e5:	48 ff c3             	inc    %rbx
    47e8:	48 8b 05 01 fb 00 00 	mov    0xfb01(%rip),%rax        # 142f0 <fwp_gc+0x1058>
    47ef:	48 39 c3             	cmp    %rax,%rbx
    47f2:	0f 83 59 04 00 00    	jae    4c51 <fwp_gc_sweep+0x541>
    47f8:	4c 8b 2d 11 fb 00 00 	mov    0xfb11(%rip),%r13        # 14310 <fwp_gc+0x1078>
    47ff:	4c 69 e3 28 12 00 00 	imul   $0x1228,%rbx,%r12
    4806:	43 0f b6 44 25 00    	movzbl 0x0(%r13,%r12,1),%eax
    480c:	85 c0                	test   %eax,%eax
    480e:	74 d2                	je     47e2 <fwp_gc_sweep+0xd2>
    4810:	83 f8 01             	cmp    $0x1,%eax
    4813:	74 2b                	je     4840 <fwp_gc_sweep+0x130>
    4815:	83 f8 02             	cmp    $0x2,%eax
    4818:	75 cb                	jne    47e5 <fwp_gc_sweep+0xd5>
    481a:	47 8b 74 25 10       	mov    0x10(%r13,%r12,1),%r14d
    481f:	43 80 7c 25 03 00    	cmpb   $0x0,0x3(%r13,%r12,1)
    4825:	74 4c                	je     4873 <fwp_gc_sweep+0x163>
    4827:	48 8b 44 24 08       	mov    0x8(%rsp),%rax
    482c:	4b 03 44 25 18       	add    0x18(%r13,%r12,1),%rax
    4831:	48 89 44 24 08       	mov    %rax,0x8(%rsp)
    4836:	e9 f8 03 00 00       	jmp    4c33 <fwp_gc_sweep+0x523>
    483b:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)
    4840:	4b 8d 04 2c          	lea    (%r12,%r13,1),%rax
    4844:	48 89 44 24 10       	mov    %rax,0x10(%rsp)
    4849:	43 8b 6c 25 0c       	mov    0xc(%r13,%r12,1),%ebp
    484e:	48 85 ed             	test   %rbp,%rbp
    4851:	0f 84 3e ff ff ff    	je     4795 <fwp_gc_sweep+0x85>
    4857:	48 8d 55 3f          	lea    0x3f(%rbp),%rdx
    485b:	48 89 d0             	mov    %rdx,%rax
    485e:	48 c1 e8 06          	shr    $0x6,%rax
    4862:	81 fd c1 00 00 00    	cmp    $0xc1,%ebp
    4868:	73 75                	jae    48df <fwp_gc_sweep+0x1cf>
    486a:	31 d2                	xor    %edx,%edx
    486c:	31 c9                	xor    %ecx,%ecx
    486e:	e9 3c 01 00 00       	jmp    49af <fwp_gc_sweep+0x29f>
    4873:	4b 8d 3c 2c          	lea    (%r12,%r13,1),%rdi
    4877:	48 81 c7 28 02 00 00 	add    $0x228,%rdi
    487e:	e8 ad e4 ff ff       	call   2d30 <fwp_rc_clear_slot>
    4883:	66 45 0f ef c0       	pxor   %xmm8,%xmm8
    4888:	66 0f 6f 3d 80 88 00 	movdqa 0x8880(%rip),%xmm7        # d110 <_IO_stdin_used+0x110>
    488f:	00 
    4890:	66 0f 6f 35 68 88 00 	movdqa 0x8868(%rip),%xmm6        # d100 <_IO_stdin_used+0x100>
    4897:	00 
    4898:	66 0f 6f 2d 50 88 00 	movdqa 0x8850(%rip),%xmm5        # d0f0 <_IO_stdin_used+0xf0>
    489f:	00 
    48a0:	49 bb 01 01 01 01 01 	movabs $0x101010101010101,%r11
    48a7:	01 01 01 
    48aa:	49 ba 0f 0f 0f 0f 0f 	movabs $0xf0f0f0f0f0f0f0f,%r10
    48b1:	0f 0f 0f 
    48b4:	49 b9 33 33 33 33 33 	movabs $0x3333333333333333,%r9
    48bb:	33 33 33 
    48be:	4d 85 f6             	test   %r14,%r14
    48c1:	0f 84 69 03 00 00    	je     4c30 <fwp_gc_sweep+0x520>
    48c7:	48 8b 05 42 fa 00 00 	mov    0xfa42(%rip),%rax        # 14310 <fwp_gc+0x1078>
    48ce:	41 83 fe 04          	cmp    $0x4,%r14d
    48d2:	0f 83 e6 02 00 00    	jae    4bbe <fwp_gc_sweep+0x4ae>
    48d8:	31 c9                	xor    %ecx,%ecx
    48da:	e9 19 03 00 00       	jmp    4bf8 <fwp_gc_sweep+0x4e8>
    48df:	89 c1                	mov    %eax,%ecx
    48e1:	83 e1 fc             	and    $0xfffffffc,%ecx
    48e4:	4b 8d 34 2c          	lea    (%r12,%r13,1),%rsi
    48e8:	48 83 c6 38          	add    $0x38,%rsi
    48ec:	48 c1 ea 03          	shr    $0x3,%rdx
    48f0:	83 e2 e0             	and    $0xffffffe0,%edx
    48f3:	66 0f ef c0          	pxor   %xmm0,%xmm0
    48f7:	31 ff                	xor    %edi,%edi
    48f9:	66 0f ef c9          	pxor   %xmm1,%xmm1
    48fd:	0f 1f 00             	nopl   (%rax)
    4900:	f3 0f 6f 5c 3e f0    	movdqu -0x10(%rsi,%rdi,1),%xmm3
    4906:	f3 0f 6f 14 3e       	movdqu (%rsi,%rdi,1),%xmm2
    490b:	66 0f 6f e3          	movdqa %xmm3,%xmm4
    490f:	66 0f 71 d4 01       	psrlw  $0x1,%xmm4
    4914:	66 0f db e5          	pand   %xmm5,%xmm4
    4918:	66 0f f8 dc          	psubb  %xmm4,%xmm3
    491c:	66 0f 6f e3          	movdqa %xmm3,%xmm4
    4920:	66 0f db e6          	pand   %xmm6,%xmm4
    4924:	66 0f 71 d3 02       	psrlw  $0x2,%xmm3
    4929:	66 0f db de          	pand   %xmm6,%xmm3
    492d:	66 0f fc dc          	paddb  %xmm4,%xmm3
    4931:	66 0f 6f e3          	movdqa %xmm3,%xmm4
    4935:	66 0f 71 d4 04       	psrlw  $0x4,%xmm4
    493a:	66 0f fc e3          	paddb  %xmm3,%xmm4
    493e:	66 0f db e7          	pand   %xmm7,%xmm4
    4942:	66 41 0f f6 e0       	psadbw %xmm8,%xmm4
    4947:	66 0f d4 c4          	paddq  %xmm4,%xmm0
    494b:	66 0f 6f da          	movdqa %xmm2,%xmm3
    494f:	66 0f 71 d3 01       	psrlw  $0x1,%xmm3
    4954:	66 0f db dd          	pand   %xmm5,%xmm3
    4958:	66 0f f8 d3          	psubb  %xmm3,%xmm2
    495c:	66 0f 6f da          	movdqa %xmm2,%xmm3
    4960:	66 0f db de          	pand   %xmm6,%xmm3
    4964:	66 0f 71 d2 02       	psrlw  $0x2,%xmm2
    4969:	66 0f db d6          	pand   %xmm6,%xmm2
    496d:	66 0f fc d3          	paddb  %xmm3,%xmm2
    4971:	66 0f 6f da          	movdqa %xmm2,%xmm3
    4975:	66 0f 71 d3 04       	psrlw  $0x4,%xmm3
    497a:	66 0f fc da          	paddb  %xmm2,%xmm3
    497e:	66 0f db df          	pand   %xmm7,%xmm3
    4982:	66 41 0f f6 d8       	psadbw %xmm8,%xmm3
    4987:	66 0f d4 cb          	paddq  %xmm3,%xmm1
    498b:	48 83 c7 20          	add    $0x20,%rdi
    498f:	48 39 fa             	cmp    %rdi,%rdx
    4992:	0f 85 68 ff ff ff    	jne    4900 <fwp_gc_sweep+0x1f0>
    4998:	66 0f d4 c8          	paddq  %xmm0,%xmm1
    499c:	66 0f 70 c1 ee       	pshufd $0xee,%xmm1,%xmm0
    49a1:	66 0f d4 c1          	paddq  %xmm1,%xmm0
    49a5:	66 48 0f 7e c2       	movq   %xmm0,%rdx
    49aa:	48 39 c8             	cmp    %rcx,%rax
    49ad:	74 51                	je     4a00 <fwp_gc_sweep+0x2f0>
    49af:	4b 8d 34 2c          	lea    (%r12,%r13,1),%rsi
    49b3:	48 83 c6 28          	add    $0x28,%rsi
    49b7:	66 0f 1f 84 00 00 00 	nopw   0x0(%rax,%rax,1)
    49be:	00 00 
    49c0:	48 8b 3c ce          	mov    (%rsi,%rcx,8),%rdi
    49c4:	49 89 f8             	mov    %rdi,%r8
    49c7:	49 d1 e8             	shr    $1,%r8
    49ca:	4d 21 f0             	and    %r14,%r8
    49cd:	4c 29 c7             	sub    %r8,%rdi
    49d0:	49 89 f8             	mov    %rdi,%r8
    49d3:	4d 21 c8             	and    %r9,%r8
    49d6:	48 c1 ef 02          	shr    $0x2,%rdi
    49da:	4c 21 cf             	and    %r9,%rdi
    49dd:	4c 01 c7             	add    %r8,%rdi
    49e0:	49 89 f8             	mov    %rdi,%r8
    49e3:	49 c1 e8 04          	shr    $0x4,%r8
    49e7:	49 01 f8             	add    %rdi,%r8
    49ea:	4d 21 d0             	and    %r10,%r8
    49ed:	4d 0f af c3          	imul   %r11,%r8
    49f1:	49 c1 e8 38          	shr    $0x38,%r8
    49f5:	4c 01 c2             	add    %r8,%rdx
    49f8:	48 ff c1             	inc    %rcx
    49fb:	48 39 c8             	cmp    %rcx,%rax
    49fe:	75 c0                	jne    49c0 <fwp_gc_sweep+0x2b0>
    4a00:	48 85 d2             	test   %rdx,%rdx
    4a03:	0f 84 8c fd ff ff    	je     4795 <fwp_gc_sweep+0x85>
    4a09:	4c 89 7c 24 18       	mov    %r15,0x18(%rsp)
    4a0e:	43 8b 44 25 08       	mov    0x8(%r13,%r12,1),%eax
    4a13:	48 0f af d0          	imul   %rax,%rdx
    4a17:	48 01 54 24 08       	add    %rdx,0x8(%rsp)
    4a1c:	47 0f b6 74 25 01    	movzbl 0x1(%r13,%r12,1),%r14d
    4a22:	47 0f b6 7c 25 02    	movzbl 0x2(%r13,%r12,1),%r15d
    4a28:	48 89 df             	mov    %rbx,%rdi
    4a2b:	e8 20 e3 ff ff       	call   2d50 <fwp_gc_chunk_addr>
    4a30:	48 89 44 24 20       	mov    %rax,0x20(%rsp)
    4a35:	48 85 ed             	test   %rbp,%rbp
    4a38:	0f 84 31 01 00 00    	je     4b6f <fwp_gc_sweep+0x45f>
    4a3e:	49 69 c6 c0 03 00 00 	imul   $0x3c0,%r14,%rax
    4a45:	48 8d 0d 4c e8 00 00 	lea    0xe84c(%rip),%rcx        # 13298 <fwp_gc>
    4a4c:	48 01 c8             	add    %rcx,%rax
    4a4f:	4f 8d 34 2c          	lea    (%r12,%r13,1),%r14
    4a53:	49 83 c6 08          	add    $0x8,%r14
    4a57:	4b 8d 0c 7f          	lea    (%r15,%r15,2),%rcx
    4a5b:	4c 8d 3c c8          	lea    (%rax,%rcx,8),%r15
    4a5f:	49 83 c7 08          	add    $0x8,%r15
    4a63:	49 01 ec             	add    %rbp,%r12
    4a66:	4d 01 ec             	add    %r13,%r12
    4a69:	49 81 c4 27 02 00 00 	add    $0x227,%r12
    4a70:	48 ff cd             	dec    %rbp
    4a73:	49 b9 33 33 33 33 33 	movabs $0x3333333333333333,%r9
    4a7a:	33 33 33 
    4a7d:	49 ba 0f 0f 0f 0f 0f 	movabs $0xf0f0f0f0f0f0f0f,%r10
    4a84:	0f 0f 0f 
    4a87:	49 bb 01 01 01 01 01 	movabs $0x101010101010101,%r11
    4a8e:	01 01 01 
    4a91:	66 0f 6f 2d 57 86 00 	movdqa 0x8657(%rip),%xmm5        # d0f0 <_IO_stdin_used+0xf0>
    4a98:	00 
    4a99:	66 0f 6f 35 5f 86 00 	movdqa 0x865f(%rip),%xmm6        # d100 <_IO_stdin_used+0x100>
    4aa0:	00 
    4aa1:	66 0f 6f 3d 67 86 00 	movdqa 0x8667(%rip),%xmm7        # d110 <_IO_stdin_used+0x110>
    4aa8:	00 
    4aa9:	66 45 0f ef c0       	pxor   %xmm8,%xmm8
    4aae:	48 8b 4c 24 10       	mov    0x10(%rsp),%rcx
    4ab3:	eb 69                	jmp    4b1e <fwp_gc_sweep+0x40e>
    4ab5:	66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
    4abc:	00 00 00 00 
    4ac0:	4c 89 e7             	mov    %r12,%rdi
    4ac3:	e8 68 e2 ff ff       	call   2d30 <fwp_rc_clear_slot>
    4ac8:	49 8b 07             	mov    (%r15),%rax
    4acb:	48 f7 d0             	not    %rax
    4ace:	49 89 45 00          	mov    %rax,0x0(%r13)
    4ad2:	4d 89 2f             	mov    %r13,(%r15)
    4ad5:	49 b9 33 33 33 33 33 	movabs $0x3333333333333333,%r9
    4adc:	33 33 33 
    4adf:	49 ba 0f 0f 0f 0f 0f 	movabs $0xf0f0f0f0f0f0f0f,%r10
    4ae6:	0f 0f 0f 
    4ae9:	49 bb 01 01 01 01 01 	movabs $0x101010101010101,%r11
    4af0:	01 01 01 
    4af3:	66 0f 6f 2d f5 85 00 	movdqa 0x85f5(%rip),%xmm5        # d0f0 <_IO_stdin_used+0xf0>
    4afa:	00 
    4afb:	66 0f 6f 35 fd 85 00 	movdqa 0x85fd(%rip),%xmm6        # d100 <_IO_stdin_used+0x100>
    4b02:	00 
    4b03:	66 0f 6f 3d 05 86 00 	movdqa 0x8605(%rip),%xmm7        # d110 <_IO_stdin_used+0x110>
    4b0a:	00 
    4b0b:	66 45 0f ef c0       	pxor   %xmm8,%xmm8
    4b10:	48 8b 4c 24 10       	mov    0x10(%rsp),%rcx
    4b15:	49 ff cc             	dec    %r12
    4b18:	48 83 c5 ff          	add    $0xffffffffffffffff,%rbp
    4b1c:	73 3d                	jae    4b5b <fwp_gc_sweep+0x44b>
    4b1e:	48 89 e8             	mov    %rbp,%rax
    4b21:	48 c1 e8 06          	shr    $0x6,%rax
    4b25:	48 8b 44 c1 28       	mov    0x28(%rcx,%rax,8),%rax
    4b2a:	48 0f a3 e8          	bt     %rbp,%rax
    4b2e:	72 e5                	jb     4b15 <fwp_gc_sweep+0x405>
    4b30:	41 8b 16             	mov    (%r14),%edx
    4b33:	49 89 ed             	mov    %rbp,%r13
    4b36:	4c 0f af ea          	imul   %rdx,%r13
    4b3a:	4c 03 6c 24 20       	add    0x20(%rsp),%r13
    4b3f:	83 3d 56 f7 00 00 00 	cmpl   $0x0,0xf756(%rip)        # 1429c <fwp_gc+0x1004>
    4b46:	0f 84 74 ff ff ff    	je     4ac0 <fwp_gc_sweep+0x3b0>
    4b4c:	4c 89 ef             	mov    %r13,%rdi
    4b4f:	31 f6                	xor    %esi,%esi
    4b51:	e8 ba d6 ff ff       	call   2210 <memset@plt>
    4b56:	e9 65 ff ff ff       	jmp    4ac0 <fwp_gc_sweep+0x3b0>
    4b5b:	4c 8b 7c 24 18       	mov    0x18(%rsp),%r15
    4b60:	49 be 55 55 55 55 55 	movabs $0x5555555555555555,%r14
    4b67:	55 55 55 
    4b6a:	e9 76 fc ff ff       	jmp    47e5 <fwp_gc_sweep+0xd5>
    4b6f:	4c 8b 7c 24 18       	mov    0x18(%rsp),%r15
    4b74:	49 be 55 55 55 55 55 	movabs $0x5555555555555555,%r14
    4b7b:	55 55 55 
    4b7e:	49 b9 33 33 33 33 33 	movabs $0x3333333333333333,%r9
    4b85:	33 33 33 
    4b88:	49 ba 0f 0f 0f 0f 0f 	movabs $0xf0f0f0f0f0f0f0f,%r10
    4b8f:	0f 0f 0f 
    4b92:	49 bb 01 01 01 01 01 	movabs $0x101010101010101,%r11
    4b99:	01 01 01 
    4b9c:	66 0f 6f 2d 4c 85 00 	movdqa 0x854c(%rip),%xmm5        # d0f0 <_IO_stdin_used+0xf0>
    4ba3:	00 
    4ba4:	66 0f 6f 35 54 85 00 	movdqa 0x8554(%rip),%xmm6        # d100 <_IO_stdin_used+0x100>
    4bab:	00 
    4bac:	66 0f 6f 3d 5c 85 00 	movdqa 0x855c(%rip),%xmm7        # d110 <_IO_stdin_used+0x110>
    4bb3:	00 
    4bb4:	66 45 0f ef c0       	pxor   %xmm8,%xmm8
    4bb9:	e9 27 fc ff ff       	jmp    47e5 <fwp_gc_sweep+0xd5>
    4bbe:	4a 8d 14 20          	lea    (%rax,%r12,1),%rdx
    4bc2:	44 89 f6             	mov    %r14d,%esi
    4bc5:	83 e6 fc             	and    $0xfffffffc,%esi
    4bc8:	31 c9                	xor    %ecx,%ecx
    4bca:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)
    4bd0:	c6 02 00             	movb   $0x0,(%rdx)
    4bd3:	c6 82 28 12 00 00 00 	movb   $0x0,0x1228(%rdx)
    4bda:	c6 82 50 24 00 00 00 	movb   $0x0,0x2450(%rdx)
    4be1:	c6 82 78 36 00 00 00 	movb   $0x0,0x3678(%rdx)
    4be8:	48 83 c1 04          	add    $0x4,%rcx
    4bec:	48 81 c2 a0 48 00 00 	add    $0x48a0,%rdx
    4bf3:	48 39 ce             	cmp    %rcx,%rsi
    4bf6:	75 d8                	jne    4bd0 <fwp_gc_sweep+0x4c0>
    4bf8:	44 89 f2             	mov    %r14d,%edx
    4bfb:	83 e2 03             	and    $0x3,%edx
    4bfe:	74 30                	je     4c30 <fwp_gc_sweep+0x520>
    4c00:	48 69 c9 28 12 00 00 	imul   $0x1228,%rcx,%rcx
    4c07:	4c 01 e1             	add    %r12,%rcx
    4c0a:	48 01 c8             	add    %rcx,%rax
    4c0d:	48 69 ca 28 12 00 00 	imul   $0x1228,%rdx,%rcx
    4c14:	31 d2                	xor    %edx,%edx
    4c16:	66 2e 0f 1f 84 00 00 	cs nopw 0x0(%rax,%rax,1)
    4c1d:	00 00 00 
    4c20:	c6 04 10 00          	movb   $0x0,(%rax,%rdx,1)
    4c24:	48 81 c2 28 12 00 00 	add    $0x1228,%rdx
    4c2b:	48 39 d1             	cmp    %rdx,%rcx
    4c2e:	75 f0                	jne    4c20 <fwp_gc_sweep+0x510>
    4c30:	4d 01 f7             	add    %r14,%r15
    4c33:	4c 01 f3             	add    %r14,%rbx
    4c36:	48 ff cb             	dec    %rbx
    4c39:	49 be 55 55 55 55 55 	movabs $0x5555555555555555,%r14
    4c40:	55 55 55 
    4c43:	e9 9d fb ff ff       	jmp    47e5 <fwp_gc_sweep+0xd5>
    4c48:	31 c0                	xor    %eax,%eax
    4c4a:	48 89 44 24 08       	mov    %rax,0x8(%rsp)
    4c4f:	31 c0                	xor    %eax,%eax
    4c51:	48 8b 54 24 08       	mov    0x8(%rsp),%rdx
    4c56:	48 89 15 03 f8 00 00 	mov    %rdx,0xf803(%rip)        # 14460 <fwp_gc+0x11c8>
    4c5d:	4c 89 3d 14 f8 00 00 	mov    %r15,0xf814(%rip)        # 14478 <fwp_gc+0x11e0>
    4c64:	48 81 fa 01 00 00 01 	cmp    $0x1000001,%rdx
    4c6b:	b9 00 00 00 01       	mov    $0x1000000,%ecx
    4c70:	48 0f 43 ca          	cmovae %rdx,%rcx
    4c74:	48 c1 e9 10          	shr    $0x10,%rcx
    4c78:	66 0f ef c0          	pxor   %xmm0,%xmm0
    4c7c:	f3 0f 7f 05 7c f6 00 	movdqu %xmm0,0xf67c(%rip)        # 14300 <fwp_gc+0x1068>
    4c83:	00 
    4c84:	49 29 cf             	sub    %rcx,%r15
    4c87:	0f 86 01 01 00 00    	jbe    4d8e <fwp_gc_sweep+0x67e>
    4c8d:	48 85 c0             	test   %rax,%rax
    4c90:	0f 84 f8 00 00 00    	je     4d8e <fwp_gc_sweep+0x67e>
    4c96:	4d 85 ff             	test   %r15,%r15
    4c99:	0f 84 ef 00 00 00    	je     4d8e <fwp_gc_sweep+0x67e>
    4c9f:	48 8b 0d 6a f6 00 00 	mov    0xf66a(%rip),%rcx        # 14310 <fwp_gc+0x1078>
    4ca6:	66 2e 0f 1f 84 00 00 	cs nopw 0x0(%rax,%rax,1)
    4cad:	00 00 00 
    4cb0:	48 8d 58 ff          	lea    -0x1(%rax),%rbx
    4cb4:	48 69 d3 28 12 00 00 	imul   $0x1228,%rbx,%rdx
    4cbb:	80 3c 11 00          	cmpb   $0x0,(%rcx,%rdx,1)
    4cbf:	0f 85 b8 00 00 00    	jne    4d7d <fwp_gc_sweep+0x66d>
    4cc5:	4c 89 ff             	mov    %r15,%rdi
    4cc8:	49 ff cf             	dec    %r15
    4ccb:	80 7c 11 04 00       	cmpb   $0x0,0x4(%rcx,%rdx,1)
    4cd0:	0f 84 a7 00 00 00    	je     4d7d <fwp_gc_sweep+0x66d>
    4cd6:	48 01 ca             	add    %rcx,%rdx
    4cd9:	48 83 c2 04          	add    $0x4,%rdx
    4cdd:	c6 02 00             	movb   $0x0,(%rdx)
    4ce0:	41 be 01 00 00 00    	mov    $0x1,%r14d
    4ce6:	48 85 db             	test   %rbx,%rbx
    4ce9:	74 6f                	je     4d5a <fwp_gc_sweep+0x64a>
    4ceb:	4d 85 ff             	test   %r15,%r15
    4cee:	74 6a                	je     4d5a <fwp_gc_sweep+0x64a>
    4cf0:	ba 02 00 00 00       	mov    $0x2,%edx
    4cf5:	48 29 c2             	sub    %rax,%rdx
    4cf8:	48 69 c0 28 12 00 00 	imul   $0x1228,%rax,%rax
    4cff:	48 01 c1             	add    %rax,%rcx
    4d02:	48 81 c1 b4 db ff ff 	add    $0xffffffffffffdbb4,%rcx
    4d09:	be 02 00 00 00       	mov    $0x2,%esi
    4d0e:	48 29 fe             	sub    %rdi,%rsi
    4d11:	b8 01 00 00 00       	mov    $0x1,%eax
    4d16:	66 2e 0f 1f 84 00 00 	cs nopw 0x0(%rax,%rax,1)
    4d1d:	00 00 00 
    4d20:	80 79 fc 00          	cmpb   $0x0,-0x4(%rcx)
    4d24:	75 31                	jne    4d57 <fwp_gc_sweep+0x647>
    4d26:	80 39 00             	cmpb   $0x0,(%rcx)
    4d29:	74 2c                	je     4d57 <fwp_gc_sweep+0x647>
    4d2b:	48 ff cb             	dec    %rbx
    4d2e:	48 8d 3c 02          	lea    (%rdx,%rax,1),%rdi
    4d32:	49 ff cf             	dec    %r15
    4d35:	c6 01 00             	movb   $0x0,(%rcx)
    4d38:	4c 8d 70 01          	lea    0x1(%rax),%r14
    4d3c:	48 83 ff 01          	cmp    $0x1,%rdi
    4d40:	74 18                	je     4d5a <fwp_gc_sweep+0x64a>
    4d42:	48 01 f0             	add    %rsi,%rax
    4d45:	48 81 c1 d8 ed ff ff 	add    $0xffffffffffffedd8,%rcx
    4d4c:	48 83 f8 01          	cmp    $0x1,%rax
    4d50:	4c 89 f0             	mov    %r14,%rax
    4d53:	75 cb                	jne    4d20 <fwp_gc_sweep+0x610>
    4d55:	eb 03                	jmp    4d5a <fwp_gc_sweep+0x64a>
    4d57:	49 89 c6             	mov    %rax,%r14
    4d5a:	48 89 df             	mov    %rbx,%rdi
    4d5d:	e8 ee df ff ff       	call   2d50 <fwp_gc_chunk_addr>
    4d62:	49 c1 e6 10          	shl    $0x10,%r14
    4d66:	48 89 c7             	mov    %rax,%rdi
    4d69:	4c 89 f6             	mov    %r14,%rsi
    4d6c:	ba 04 00 00 00       	mov    $0x4,%edx
    4d71:	e8 7a d6 ff ff       	call   23f0 <madvise@plt>
    4d76:	48 8b 0d 93 f5 00 00 	mov    0xf593(%rip),%rcx        # 14310 <fwp_gc+0x1078>
    4d7d:	48 89 d8             	mov    %rbx,%rax
    4d80:	48 85 db             	test   %rbx,%rbx
    4d83:	74 09                	je     4d8e <fwp_gc_sweep+0x67e>
    4d85:	4d 85 ff             	test   %r15,%r15
    4d88:	0f 85 22 ff ff ff    	jne    4cb0 <fwp_gc_sweep+0x5a0>
    4d8e:	48 83 c4 28          	add    $0x28,%rsp
    4d92:	5b                   	pop    %rbx
    4d93:	41 5c                	pop    %r12
    4d95:	41 5d                	pop    %r13
    4d97:	41 5e                	pop    %r14
    4d99:	41 5f                	pop    %r15
    4d9b:	5d                   	pop    %rbp
    4d9c:	c3                   	ret
    4d9d:	0f 1f 00             	nopl   (%rax)

0000000000004da0 <fwp_gc_scan_stacks>:
    4da0:	48 8b 35 79 f5 00 00 	mov    0xf579(%rip),%rsi        # 14320 <fwp_gc+0x1088>
    4da7:	e9 04 01 00 00       	jmp    4eb0 <fwp_gc_scan_root>
    4dac:	0f 1f 40 00          	nopl   0x0(%rax)

0000000000004db0 <fwp_gc_sp>:
    4db0:	55                   	push   %rbp
    4db1:	48 89 e5             	mov    %rsp,%rbp
    4db4:	48 89 e8             	mov    %rbp,%rax
    4db7:	5d                   	pop    %rbp
    4db8:	c3                   	ret
    4db9:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)

0000000000004dc0 <fwp_gc_drain>:
    4dc0:	48 8b 05 71 f6 00 00 	mov    0xf671(%rip),%rax        # 14438 <fwp_gc+0x11a0>
    4dc7:	48 85 c0             	test   %rax,%rax
    4dca:	74 3c                	je     4e08 <fwp_gc_drain+0x48>
    4dcc:	50                   	push   %rax
    4dcd:	0f 1f 00             	nopl   (%rax)
    4dd0:	48 8b 0d 59 f6 00 00 	mov    0xf659(%rip),%rcx        # 14430 <fwp_gc+0x1198>
    4dd7:	48 ff c8             	dec    %rax
    4dda:	48 89 05 57 f6 00 00 	mov    %rax,0xf657(%rip)        # 14438 <fwp_gc+0x11a0>
    4de1:	48 c1 e0 04          	shl    $0x4,%rax
    4de5:	48 8b 3c 01          	mov    (%rcx,%rax,1),%rdi
    4de9:	48 8b 74 01 08       	mov    0x8(%rcx,%rax,1),%rsi
    4dee:	48 01 fe             	add    %rdi,%rsi
    4df1:	31 d2                	xor    %edx,%edx
    4df3:	e8 e8 00 00 00       	call   4ee0 <fwp_gc_scan>
    4df8:	48 8b 05 39 f6 00 00 	mov    0xf639(%rip),%rax        # 14438 <fwp_gc+0x11a0>
    4dff:	48 85 c0             	test   %rax,%rax
    4e02:	75 cc                	jne    4dd0 <fwp_gc_drain+0x10>
    4e04:	48 83 c4 08          	add    $0x8,%rsp
    4e08:	c3                   	ret
    4e09:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)

0000000000004e10 <fwp_gc_scan_data>:
    4e10:	83 3d 11 f6 00 00 00 	cmpl   $0x0,0xf611(%rip)        # 14428 <fwp_gc+0x1190>
    4e17:	0f 8e 87 00 00 00    	jle    4ea4 <fwp_gc_scan_data+0x94>
    4e1d:	41 57                	push   %r15
    4e1f:	41 56                	push   %r14
    4e21:	41 55                	push   %r13
    4e23:	41 54                	push   %r12
    4e25:	53                   	push   %rbx
    4e26:	4c 8d 25 03 f5 00 00 	lea    0xf503(%rip),%r12        # 14330 <fwp_gc+0x1098>
    4e2d:	45 31 ed             	xor    %r13d,%r13d
    4e30:	48 8d 1d 61 e4 00 00 	lea    0xe461(%rip),%rbx        # 13298 <fwp_gc>
    4e37:	4c 8d 35 7a fe 00 00 	lea    0xfe7a(%rip),%r14        # 14cb8 <fwp_reuse_verify>
    4e3e:	eb 1d                	jmp    4e5d <fwp_gc_scan_data+0x4d>
    4e40:	4c 89 fe             	mov    %r15,%rsi
    4e43:	31 d2                	xor    %edx,%edx
    4e45:	e8 96 00 00 00       	call   4ee0 <fwp_gc_scan>
    4e4a:	49 ff c5             	inc    %r13
    4e4d:	48 63 05 d4 f5 00 00 	movslq 0xf5d4(%rip),%rax        # 14428 <fwp_gc+0x1190>
    4e54:	49 83 c4 10          	add    $0x10,%r12
    4e58:	49 39 c5             	cmp    %rax,%r13
    4e5b:	7d 3e                	jge    4e9b <fwp_gc_scan_data+0x8b>
    4e5d:	49 8b 7c 24 f8       	mov    -0x8(%r12),%rdi
    4e62:	49 8b 04 24          	mov    (%r12),%rax
    4e66:	4c 8d 3c 07          	lea    (%rdi,%rax,1),%r15
    4e6a:	0f 57 c0             	xorps  %xmm0,%xmm0
    4e6d:	f2 48 0f 2a c0       	cvtsi2sd %rax,%xmm0
    4e72:	f2 0f 58 05 1e f6 00 	addsd  0xf61e(%rip),%xmm0        # 14498 <fwp_gc+0x1200>
    4e79:	00 
    4e7a:	f2 0f 11 05 16 f6 00 	movsd  %xmm0,0xf616(%rip)        # 14498 <fwp_gc+0x1200>
    4e81:	00 
    4e82:	48 39 df             	cmp    %rbx,%rdi
    4e85:	77 b9                	ja     4e40 <fwp_gc_scan_data+0x30>
    4e87:	4d 39 f7             	cmp    %r14,%r15
    4e8a:	72 b4                	jb     4e40 <fwp_gc_scan_data+0x30>
    4e8c:	48 89 de             	mov    %rbx,%rsi
    4e8f:	31 d2                	xor    %edx,%edx
    4e91:	e8 4a 00 00 00       	call   4ee0 <fwp_gc_scan>
    4e96:	4c 89 f7             	mov    %r14,%rdi
    4e99:	eb a5                	jmp    4e40 <fwp_gc_scan_data+0x30>
    4e9b:	5b                   	pop    %rbx
    4e9c:	41 5c                	pop    %r12
    4e9e:	41 5d                	pop    %r13
    4ea0:	41 5e                	pop    %r14
    4ea2:	41 5f                	pop    %r15
    4ea4:	c3                   	ret
    4ea5:	66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
    4eac:	00 00 00 00 

0000000000004eb0 <fwp_gc_scan_root>:
    4eb0:	48 85 ff             	test   %rdi,%rdi
    4eb3:	74 24                	je     4ed9 <fwp_gc_scan_root+0x29>
    4eb5:	48 89 f0             	mov    %rsi,%rax
    4eb8:	48 29 f8             	sub    %rdi,%rax
    4ebb:	76 1c                	jbe    4ed9 <fwp_gc_scan_root+0x29>
    4ebd:	f2 48 0f 2a c0       	cvtsi2sd %rax,%xmm0
    4ec2:	f2 0f 58 05 ce f5 00 	addsd  0xf5ce(%rip),%xmm0        # 14498 <fwp_gc+0x1200>
    4ec9:	00 
    4eca:	f2 0f 11 05 c6 f5 00 	movsd  %xmm0,0xf5c6(%rip)        # 14498 <fwp_gc+0x1200>
    4ed1:	00 
    4ed2:	ba 01 00 00 00       	mov    $0x1,%edx
    4ed7:	eb 07                	jmp    4ee0 <fwp_gc_scan>
    4ed9:	c3                   	ret
    4eda:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)

0000000000004ee0 <fwp_gc_scan>:
    4ee0:	55                   	push   %rbp
    4ee1:	41 57                	push   %r15
    4ee3:	41 56                	push   %r14
    4ee5:	41 55                	push   %r13
    4ee7:	41 54                	push   %r12
    4ee9:	53                   	push   %rbx
    4eea:	50                   	push   %rax
    4eeb:	49 89 ff             	mov    %rdi,%r15
    4eee:	49 83 c7 07          	add    $0x7,%r15
    4ef2:	49 83 e7 f8          	and    $0xfffffffffffffff8,%r15
    4ef6:	49 8d 47 08          	lea    0x8(%r15),%rax
    4efa:	48 39 f0             	cmp    %rsi,%rax
    4efd:	76 0f                	jbe    4f0e <fwp_gc_scan+0x2e>
    4eff:	48 83 c4 08          	add    $0x8,%rsp
    4f03:	5b                   	pop    %rbx
    4f04:	41 5c                	pop    %r12
    4f06:	41 5d                	pop    %r13
    4f08:	41 5e                	pop    %r14
    4f0a:	41 5f                	pop    %r15
    4f0c:	5d                   	pop    %rbp
    4f0d:	c3                   	ret
    4f0e:	89 d3                	mov    %edx,%ebx
    4f10:	49 89 f6             	mov    %rsi,%r14
    4f13:	4c 8b 2d ae f3 00 00 	mov    0xf3ae(%rip),%r13        # 142c8 <fwp_gc+0x1030>
    4f1a:	48 8b 2d cf f3 00 00 	mov    0xf3cf(%rip),%rbp        # 142f0 <fwp_gc+0x1058>
    4f21:	48 c1 e5 10          	shl    $0x10,%rbp
    4f25:	eb 30                	jmp    4f57 <fwp_gc_scan+0x77>
    4f27:	66 0f 1f 84 00 00 00 	nopw   0x0(%rax,%rax,1)
    4f2e:	00 00 
    4f30:	4c 89 e7             	mov    %r12,%rdi
    4f33:	e8 38 00 00 00       	call   4f70 <fwp_gc_mark>
    4f38:	85 db                	test   %ebx,%ebx
    4f3a:	74 0b                	je     4f47 <fwp_gc_scan+0x67>
    4f3c:	49 ff cc             	dec    %r12
    4f3f:	4c 89 e7             	mov    %r12,%rdi
    4f42:	e8 29 00 00 00       	call   4f70 <fwp_gc_mark>
    4f47:	49 8d 47 08          	lea    0x8(%r15),%rax
    4f4b:	49 83 c7 10          	add    $0x10,%r15
    4f4f:	4d 39 f7             	cmp    %r14,%r15
    4f52:	49 89 c7             	mov    %rax,%r15
    4f55:	77 a8                	ja     4eff <fwp_gc_scan+0x1f>
    4f57:	4d 8b 27             	mov    (%r15),%r12
    4f5a:	4c 89 e0             	mov    %r12,%rax
    4f5d:	4c 29 e8             	sub    %r13,%rax
    4f60:	48 39 e8             	cmp    %rbp,%rax
    4f63:	72 cb                	jb     4f30 <fwp_gc_scan+0x50>
    4f65:	85 db                	test   %ebx,%ebx
    4f67:	74 de                	je     4f47 <fwp_gc_scan+0x67>
    4f69:	48 39 e8             	cmp    %rbp,%rax
    4f6c:	74 ce                	je     4f3c <fwp_gc_scan+0x5c>
    4f6e:	eb d7                	jmp    4f47 <fwp_gc_scan+0x67>

0000000000004f70 <fwp_gc_mark>:
    4f70:	41 56                	push   %r14
    4f72:	53                   	push   %rbx
    4f73:	50                   	push   %rax
    4f74:	49 89 fe             	mov    %rdi,%r14
    4f77:	48 89 e6             	mov    %rsp,%rsi
    4f7a:	e8 d1 00 00 00       	call   5050 <fwp_gc_chunk_of>
    4f7f:	48 85 c0             	test   %rax,%rax
    4f82:	0f 84 98 00 00 00    	je     5020 <fwp_gc_mark+0xb0>
    4f88:	0f b6 08             	movzbl (%rax),%ecx
    4f8b:	83 f9 03             	cmp    $0x3,%ecx
    4f8e:	74 6b                	je     4ffb <fwp_gc_mark+0x8b>
    4f90:	83 f9 02             	cmp    $0x2,%ecx
    4f93:	74 7b                	je     5010 <fwp_gc_mark+0xa0>
    4f95:	83 f9 01             	cmp    $0x1,%ecx
    4f98:	0f 85 82 00 00 00    	jne    5020 <fwp_gc_mark+0xb0>
    4f9e:	8b 58 08             	mov    0x8(%rax),%ebx
    4fa1:	41 0f b7 ce          	movzwl %r14w,%ecx
    4fa5:	48 89 c6             	mov    %rax,%rsi
    4fa8:	89 c8                	mov    %ecx,%eax
    4faa:	31 d2                	xor    %edx,%edx
    4fac:	f7 f3                	div    %ebx
    4fae:	41 89 c6             	mov    %eax,%r14d
    4fb1:	3b 46 0c             	cmp    0xc(%rsi),%eax
    4fb4:	73 6a                	jae    5020 <fwp_gc_mark+0xb0>
    4fb6:	48 89 f0             	mov    %rsi,%rax
    4fb9:	ba 01 00 00 00       	mov    $0x1,%edx
    4fbe:	44 89 f1             	mov    %r14d,%ecx
    4fc1:	48 d3 e2             	shl    %cl,%rdx
    4fc4:	44 89 f1             	mov    %r14d,%ecx
    4fc7:	c1 e9 06             	shr    $0x6,%ecx
    4fca:	48 8b 74 ce 28       	mov    0x28(%rsi,%rcx,8),%rsi
    4fcf:	4c 0f a3 f6          	bt     %r14,%rsi
    4fd3:	72 4b                	jb     5020 <fwp_gc_mark+0xb0>
    4fd5:	48 09 d6             	or     %rdx,%rsi
    4fd8:	48 89 74 c8 28       	mov    %rsi,0x28(%rax,%rcx,8)
    4fdd:	80 78 01 01          	cmpb   $0x1,0x1(%rax)
    4fe1:	74 3d                	je     5020 <fwp_gc_mark+0xb0>
    4fe3:	48 8b 3c 24          	mov    (%rsp),%rdi
    4fe7:	e8 64 dd ff ff       	call   2d50 <fwp_gc_chunk_addr>
    4fec:	4c 0f af f3          	imul   %rbx,%r14
    4ff0:	49 01 c6             	add    %rax,%r14
    4ff3:	4c 89 f7             	mov    %r14,%rdi
    4ff6:	48 89 de             	mov    %rbx,%rsi
    4ff9:	eb 40                	jmp    503b <fwp_gc_mark+0xcb>
    4ffb:	8b 40 10             	mov    0x10(%rax),%eax
    4ffe:	48 89 04 24          	mov    %rax,(%rsp)
    5002:	48 69 c0 28 12 00 00 	imul   $0x1228,%rax,%rax
    5009:	48 03 05 00 f3 00 00 	add    0xf300(%rip),%rax        # 14310 <fwp_gc+0x1078>
    5010:	80 78 03 00          	cmpb   $0x0,0x3(%rax)
    5014:	75 0a                	jne    5020 <fwp_gc_mark+0xb0>
    5016:	c6 40 03 01          	movb   $0x1,0x3(%rax)
    501a:	80 78 01 01          	cmpb   $0x1,0x1(%rax)
    501e:	75 08                	jne    5028 <fwp_gc_mark+0xb8>
    5020:	48 83 c4 08          	add    $0x8,%rsp
    5024:	5b                   	pop    %rbx
    5025:	41 5e                	pop    %r14
    5027:	c3                   	ret
    5028:	48 8b 3c 24          	mov    (%rsp),%rdi
    502c:	48 89 c3             	mov    %rax,%rbx
    502f:	e8 1c dd ff ff       	call   2d50 <fwp_gc_chunk_addr>
    5034:	48 8b 73 18          	mov    0x18(%rbx),%rsi
    5038:	48 89 c7             	mov    %rax,%rdi
    503b:	48 83 c4 08          	add    $0x8,%rsp
    503f:	5b                   	pop    %rbx
    5040:	41 5e                	pop    %r14
    5042:	eb 3c                	jmp    5080 <fwp_gc_push>
    5044:	66 66 66 2e 0f 1f 84 	data16 data16 cs nopw 0x0(%rax,%rax,1)
    504b:	00 00 00 00 00 

0000000000005050 <fwp_gc_chunk_of>:
    5050:	48 2b 3d 71 f2 00 00 	sub    0xf271(%rip),%rdi        # 142c8 <fwp_gc+0x1030>
    5057:	48 8b 05 92 f2 00 00 	mov    0xf292(%rip),%rax        # 142f0 <fwp_gc+0x1058>
    505e:	48 c1 e0 10          	shl    $0x10,%rax
    5062:	48 39 c7             	cmp    %rax,%rdi
    5065:	73 16                	jae    507d <fwp_gc_chunk_of+0x2d>
    5067:	48 c1 ef 10          	shr    $0x10,%rdi
    506b:	48 89 3e             	mov    %rdi,(%rsi)
    506e:	48 69 c7 28 12 00 00 	imul   $0x1228,%rdi,%rax
    5075:	48 03 05 94 f2 00 00 	add    0xf294(%rip),%rax        # 14310 <fwp_gc+0x1078>
    507c:	c3                   	ret
    507d:	31 c0                	xor    %eax,%eax
    507f:	c3                   	ret

0000000000005080 <fwp_gc_push>:
    5080:	41 56                	push   %r14
    5082:	53                   	push   %rbx
    5083:	50                   	push   %rax
    5084:	48 89 f3             	mov    %rsi,%rbx
    5087:	49 89 fe             	mov    %rdi,%r14
    508a:	48 8b 0d a7 f3 00 00 	mov    0xf3a7(%rip),%rcx        # 14438 <fwp_gc+0x11a0>
    5091:	48 8b 05 98 f3 00 00 	mov    0xf398(%rip),%rax        # 14430 <fwp_gc+0x1198>
    5098:	48 3b 0d a1 f3 00 00 	cmp    0xf3a1(%rip),%rcx        # 14440 <fwp_gc+0x11a8>
    509f:	75 36                	jne    50d7 <fwp_gc_push+0x57>
    50a1:	48 8d 14 09          	lea    (%rcx,%rcx,1),%rdx
    50a5:	48 85 c9             	test   %rcx,%rcx
    50a8:	be 00 10 00 00       	mov    $0x1000,%esi
    50ad:	48 0f 45 f2          	cmovne %rdx,%rsi
    50b1:	48 89 35 88 f3 00 00 	mov    %rsi,0xf388(%rip)        # 14440 <fwp_gc+0x11a8>
    50b8:	48 c1 e6 04          	shl    $0x4,%rsi
    50bc:	48 89 c7             	mov    %rax,%rdi
    50bf:	e8 bc d2 ff ff       	call   2380 <realloc@plt>
    50c4:	48 89 05 65 f3 00 00 	mov    %rax,0xf365(%rip)        # 14430 <fwp_gc+0x1198>
    50cb:	48 85 c0             	test   %rax,%rax
    50ce:	74 29                	je     50f9 <fwp_gc_push+0x79>
    50d0:	48 8b 0d 61 f3 00 00 	mov    0xf361(%rip),%rcx        # 14438 <fwp_gc+0x11a0>
    50d7:	48 89 ca             	mov    %rcx,%rdx
    50da:	48 c1 e2 04          	shl    $0x4,%rdx
    50de:	4c 89 34 10          	mov    %r14,(%rax,%rdx,1)
    50e2:	48 89 5c 10 08       	mov    %rbx,0x8(%rax,%rdx,1)
    50e7:	48 ff c1             	inc    %rcx
    50ea:	48 89 0d 47 f3 00 00 	mov    %rcx,0xf347(%rip)        # 14438 <fwp_gc+0x11a0>
    50f1:	48 83 c4 08          	add    $0x8,%rsp
    50f5:	5b                   	pop    %rbx
    50f6:	41 5e                	pop    %r14
    50f8:	c3                   	ret
    50f9:	e8 02 ec ff ff       	call   3d00 <fwp_gc_oom>
    50fe:	66 90                	xchg   %ax,%ax

0000000000005100 <fwp_gc_marked>:
    5100:	53                   	push   %rbx
    5101:	48 83 ec 10          	sub    $0x10,%rsp
    5105:	48 89 fb             	mov    %rdi,%rbx
    5108:	48 8d 74 24 08       	lea    0x8(%rsp),%rsi
    510d:	e8 3e ff ff ff       	call   5050 <fwp_gc_chunk_of>
    5112:	48 85 c0             	test   %rax,%rax
    5115:	74 36                	je     514d <fwp_gc_marked+0x4d>
    5117:	0f b6 08             	movzbl (%rax),%ecx
    511a:	80 f9 03             	cmp    $0x3,%cl
    511d:	75 19                	jne    5138 <fwp_gc_marked+0x38>
    511f:	48 8b 0d ea f1 00 00 	mov    0xf1ea(%rip),%rcx        # 14310 <fwp_gc+0x1078>
    5126:	8b 40 10             	mov    0x10(%rax),%eax
    5129:	48 69 d0 28 12 00 00 	imul   $0x1228,%rax,%rdx
    5130:	48 8d 04 11          	lea    (%rcx,%rdx,1),%rax
    5134:	0f b6 0c 11          	movzbl (%rcx,%rdx,1),%ecx
    5138:	80 f9 01             	cmp    $0x1,%cl
    513b:	74 17                	je     5154 <fwp_gc_marked+0x54>
    513d:	0f b6 d1             	movzbl %cl,%edx
    5140:	31 c9                	xor    %ecx,%ecx
    5142:	83 fa 02             	cmp    $0x2,%edx
    5145:	75 33                	jne    517a <fwp_gc_marked+0x7a>
    5147:	0f b6 48 03          	movzbl 0x3(%rax),%ecx
    514b:	eb 2d                	jmp    517a <fwp_gc_marked+0x7a>
    514d:	b9 01 00 00 00       	mov    $0x1,%ecx
    5152:	eb 26                	jmp    517a <fwp_gc_marked+0x7a>
    5154:	0f b7 cb             	movzwl %bx,%ecx
    5157:	48 89 c6             	mov    %rax,%rsi
    515a:	89 c8                	mov    %ecx,%eax
    515c:	31 d2                	xor    %edx,%edx
    515e:	f7 76 08             	divl   0x8(%rsi)
    5161:	89 c1                	mov    %eax,%ecx
    5163:	c1 e9 03             	shr    $0x3,%ecx
    5166:	81 e1 f8 1f 00 00    	and    $0x1ff8,%ecx
    516c:	48 8b 54 0e 28       	mov    0x28(%rsi,%rcx,1),%rdx
    5171:	31 c9                	xor    %ecx,%ecx
    5173:	48 0f a3 c2          	bt     %rax,%rdx
    5177:	0f 92 c1             	setb   %cl
    517a:	89 c8                	mov    %ecx,%eax
    517c:	48 83 c4 10          	add    $0x10,%rsp
    5180:	5b                   	pop    %rbx
    5181:	c3                   	ret
    5182:	66 66 66 66 66 2e 0f 	data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    5189:	1f 84 00 00 00 00 00 

0000000000005190 <fwp_rc_clear_chunk>:
    5190:	41 57                	push   %r15
    5192:	41 56                	push   %r14
    5194:	53                   	push   %rbx
    5195:	48 89 fb             	mov    %rdi,%rbx
    5198:	48 83 3d 10 fb 00 00 	cmpq   $0x0,0xfb10(%rip)        # 14cb0 <fwp_gc+0x1a18>
    519f:	00 
    51a0:	74 2c                	je     51ce <fwp_rc_clear_chunk+0x3e>
    51a2:	4c 8d b3 28 02 00 00 	lea    0x228(%rbx),%r14
    51a9:	45 31 ff             	xor    %r15d,%r15d
    51ac:	eb 0e                	jmp    51bc <fwp_rc_clear_chunk+0x2c>
    51ae:	66 90                	xchg   %ax,%ax
    51b0:	49 ff c7             	inc    %r15
    51b3:	49 81 ff 00 10 00 00 	cmp    $0x1000,%r15
    51ba:	74 12                	je     51ce <fwp_rc_clear_chunk+0x3e>
    51bc:	43 80 3c 3e ff       	cmpb   $0xff,(%r14,%r15,1)
    51c1:	75 ed                	jne    51b0 <fwp_rc_clear_chunk+0x20>
    51c3:	4b 8d 3c 3e          	lea    (%r14,%r15,1),%rdi
    51c7:	e8 94 db ff ff       	call   2d60 <fwp_rc_forget_slot>
    51cc:	eb e2                	jmp    51b0 <fwp_rc_clear_chunk+0x20>
    51ce:	48 81 c3 28 02 00 00 	add    $0x228,%rbx
    51d5:	ba 00 10 00 00       	mov    $0x1000,%edx
    51da:	48 89 df             	mov    %rbx,%rdi
    51dd:	31 f6                	xor    %esi,%esi
    51df:	5b                   	pop    %rbx
    51e0:	41 5e                	pop    %r14
    51e2:	41 5f                	pop    %r15
    51e4:	e9 27 d0 ff ff       	jmp    2210 <memset@plt>
    51e9:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)

00000000000051f0 <fwp_drop0>:
    51f0:	53                   	push   %rbx
    51f1:	48 89 fb             	mov    %rdi,%rbx
    51f4:	e8 17 00 00 00       	call   5210 <fwp_rc_release_last>
    51f9:	85 c0                	test   %eax,%eax
    51fb:	74 06                	je     5203 <fwp_drop0+0x13>
    51fd:	48 89 df             	mov    %rbx,%rdi
    5200:	5b                   	pop    %rbx
    5201:	eb 3d                	jmp    5240 <fwp_rc_free_arr>
    5203:	5b                   	pop    %rbx
    5204:	c3                   	ret
    5205:	66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
    520c:	00 00 00 00 

0000000000005210 <fwp_rc_release_last>:
    5210:	50                   	push   %rax
    5211:	e8 aa da ff ff       	call   2cc0 <fwp_rc_slot>
    5216:	48 89 c7             	mov    %rax,%rdi
    5219:	31 c0                	xor    %eax,%eax
    521b:	48 85 ff             	test   %rdi,%rdi
    521e:	74 1a                	je     523a <fwp_rc_release_last+0x2a>
    5220:	0f b6 07             	movzbl (%rdi),%eax
    5223:	85 c0                	test   %eax,%eax
    5225:	74 13                	je     523a <fwp_rc_release_last+0x2a>
    5227:	83 f8 01             	cmp    $0x1,%eax
    522a:	75 07                	jne    5233 <fwp_rc_release_last+0x23>
    522c:	b8 01 00 00 00       	mov    $0x1,%eax
    5231:	59                   	pop    %rcx
    5232:	c3                   	ret
    5233:	e8 a8 00 00 00       	call   52e0 <fwp_rc_drop_slot>
    5238:	31 c0                	xor    %eax,%eax
    523a:	59                   	pop    %rcx
    523b:	c3                   	ret
    523c:	0f 1f 40 00          	nopl   0x0(%rax)

0000000000005240 <fwp_rc_free_arr>:
    5240:	41 56                	push   %r14
    5242:	53                   	push   %rbx
    5243:	50                   	push   %rax
    5244:	48 89 fb             	mov    %rdi,%rbx
    5247:	e8 e4 00 00 00       	call   5330 <fwp_rc_last>
    524c:	85 c0                	test   %eax,%eax
    524e:	74 7d                	je     52cd <fwp_rc_free_arr+0x8d>
    5250:	8b 0d 62 fa 00 00    	mov    0xfa62(%rip),%ecx        # 14cb8 <fwp_reuse_verify>
    5256:	85 c9                	test   %ecx,%ecx
    5258:	78 0d                	js     5267 <fwp_rc_free_arr+0x27>
    525a:	85 c9                	test   %ecx,%ecx
    525c:	74 41                	je     529f <fwp_rc_free_arr+0x5f>
    525e:	48 c7 03 00 00 00 00 	movq   $0x0,(%rbx)
    5265:	eb 66                	jmp    52cd <fwp_rc_free_arr+0x8d>
    5267:	48 8d 3d ba 85 00 00 	lea    0x85ba(%rip),%rdi        # d828 <exec_in_fp0+0x1e8>
    526e:	e8 bd cd ff ff       	call   2030 <getenv@plt>
    5273:	31 c9                	xor    %ecx,%ecx
    5275:	48 85 c0             	test   %rax,%rax
    5278:	74 1b                	je     5295 <fwp_rc_free_arr+0x55>
    527a:	80 38 00             	cmpb   $0x0,(%rax)
    527d:	74 16                	je     5295 <fwp_rc_free_arr+0x55>
    527f:	48 8d 35 d4 90 00 00 	lea    0x90d4(%rip),%rsi        # e35a <exec_in_fp0+0xd1a>
    5286:	48 89 c7             	mov    %rax,%rdi
    5289:	e8 42 d0 ff ff       	call   22d0 <strcmp@plt>
    528e:	31 c9                	xor    %ecx,%ecx
    5290:	85 c0                	test   %eax,%eax
    5292:	0f 95 c1             	setne  %cl
    5295:	89 0d 1d fa 00 00    	mov    %ecx,0xfa1d(%rip)        # 14cb8 <fwp_reuse_verify>
    529b:	85 c9                	test   %ecx,%ecx
    529d:	75 bf                	jne    525e <fwp_rc_free_arr+0x1e>
    529f:	4c 8b 35 f2 df 00 00 	mov    0xdff2(%rip),%r14        # 13298 <fwp_gc>
    52a6:	48 89 df             	mov    %rbx,%rdi
    52a9:	e8 a2 00 00 00       	call   5350 <fwp_mem_free>
    52ae:	48 8b 05 e3 df 00 00 	mov    0xdfe3(%rip),%rax        # 13298 <fwp_gc>
    52b5:	4c 29 f0             	sub    %r14,%rax
    52b8:	f2 48 0f 2a c0       	cvtsi2sd %rax,%xmm0
    52bd:	f2 0f 58 05 db f1 00 	addsd  0xf1db(%rip),%xmm0        # 144a0 <fwp_gc+0x1208>
    52c4:	00 
    52c5:	f2 0f 11 05 d3 f1 00 	movsd  %xmm0,0xf1d3(%rip)        # 144a0 <fwp_gc+0x1208>
    52cc:	00 
    52cd:	48 83 c4 08          	add    $0x8,%rsp
    52d1:	5b                   	pop    %rbx
    52d2:	41 5e                	pop    %r14
    52d4:	c3                   	ret
    52d5:	66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
    52dc:	00 00 00 00 

00000000000052e0 <fwp_rc_drop_slot>:
    52e0:	0f b6 07             	movzbl (%rdi),%eax
    52e3:	3c ff                	cmp    $0xff,%al
    52e5:	74 09                	je     52f0 <fwp_rc_wide_drop>
    52e7:	3c 02                	cmp    $0x2,%al
    52e9:	72 04                	jb     52ef <fwp_rc_drop_slot+0xf>
    52eb:	fe c8                	dec    %al
    52ed:	88 07                	mov    %al,(%rdi)
    52ef:	c3                   	ret

00000000000052f0 <fwp_rc_wide_drop>:
    52f0:	53                   	push   %rbx
    52f1:	48 89 fb             	mov    %rdi,%rbx
    52f4:	e8 a7 da ff ff       	call   2da0 <fwp_rc_wide_link>
    52f9:	48 8b 00             	mov    (%rax),%rax
    52fc:	48 85 c0             	test   %rax,%rax
    52ff:	74 21                	je     5322 <fwp_rc_wide_drop+0x32>
    5301:	48 8b 48 08          	mov    0x8(%rax),%rcx
    5305:	48 ff c9             	dec    %rcx
    5308:	48 89 48 08          	mov    %rcx,0x8(%rax)
    530c:	48 81 f9 fe 00 00 00 	cmp    $0xfe,%rcx
    5313:	75 0b                	jne    5320 <fwp_rc_wide_drop+0x30>
    5315:	48 89 df             	mov    %rbx,%rdi
    5318:	e8 43 da ff ff       	call   2d60 <fwp_rc_forget_slot>
    531d:	c6 03 fe             	movb   $0xfe,(%rbx)
    5320:	5b                   	pop    %rbx
    5321:	c3                   	ret
    5322:	48 8d 3d ba 83 00 00 	lea    0x83ba(%rip),%rdi        # d6e3 <exec_in_fp0+0xa3>
    5329:	e8 d2 da ff ff       	call   2e00 <fwp_trap>
    532e:	66 90                	xchg   %ax,%ax

0000000000005330 <fwp_rc_last>:
    5330:	50                   	push   %rax
    5331:	e8 8a d9 ff ff       	call   2cc0 <fwp_rc_slot>
    5336:	48 85 c0             	test   %rax,%rax
    5339:	74 0d                	je     5348 <fwp_rc_last+0x18>
    533b:	48 89 c1             	mov    %rax,%rcx
    533e:	31 c0                	xor    %eax,%eax
    5340:	80 39 01             	cmpb   $0x1,(%rcx)
    5343:	0f 94 c0             	sete   %al
    5346:	59                   	pop    %rcx
    5347:	c3                   	ret
    5348:	31 c0                	xor    %eax,%eax
    534a:	59                   	pop    %rcx
    534b:	c3                   	ret
    534c:	0f 1f 40 00          	nopl   0x0(%rax)

0000000000005350 <fwp_mem_free>:
    5350:	48 85 ff             	test   %rdi,%rdi
    5353:	0f 84 c7 01 00 00    	je     5520 <fwp_mem_free+0x1d0>
    5359:	41 57                	push   %r15
    535b:	41 56                	push   %r14
    535d:	53                   	push   %rbx
    535e:	48 83 ec 10          	sub    $0x10,%rsp
    5362:	49 89 ff             	mov    %rdi,%r15
    5365:	48 8d 74 24 08       	lea    0x8(%rsp),%rsi
    536a:	e8 e1 fc ff ff       	call   5050 <fwp_gc_chunk_of>
    536f:	48 85 c0             	test   %rax,%rax
    5372:	0f 84 9f 01 00 00    	je     5517 <fwp_mem_free+0x1c7>
    5378:	49 89 c6             	mov    %rax,%r14
    537b:	0f b6 00             	movzbl (%rax),%eax
    537e:	83 f8 02             	cmp    $0x2,%eax
    5381:	0f 84 96 00 00 00    	je     541d <fwp_mem_free+0xcd>
    5387:	83 f8 01             	cmp    $0x1,%eax
    538a:	0f 85 87 01 00 00    	jne    5517 <fwp_mem_free+0x1c7>
    5390:	41 0f b6 46 01       	movzbl 0x1(%r14),%eax
    5395:	41 0f b6 4e 02       	movzbl 0x2(%r14),%ecx
    539a:	48 69 c0 c0 03 00 00 	imul   $0x3c0,%rax,%rax
    53a1:	48 8d 35 f0 de 00 00 	lea    0xdef0(%rip),%rsi        # 13298 <fwp_gc>
    53a8:	48 01 c6             	add    %rax,%rsi
    53ab:	48 8d 3c 49          	lea    (%rcx,%rcx,2),%rdi
    53af:	41 0f b7 c7          	movzwl %r15w,%eax
    53b3:	31 d2                	xor    %edx,%edx
    53b5:	41 f7 76 08          	divl   0x8(%r14)
    53b9:	48 c7 c2 fe ff ff ff 	mov    $0xfffffffffffffffe,%rdx
    53c0:	89 c1                	mov    %eax,%ecx
    53c2:	48 d3 c2             	rol    %cl,%rdx
    53c5:	48 8d 1c fe          	lea    (%rsi,%rdi,8),%rbx
    53c9:	48 83 c3 08          	add    $0x8,%rbx
    53cd:	49 8d 3c 06          	lea    (%r14,%rax,1),%rdi
    53d1:	48 81 c7 28 02 00 00 	add    $0x228,%rdi
    53d8:	c1 e8 03             	shr    $0x3,%eax
    53db:	25 f8 1f 00 00       	and    $0x1ff8,%eax
    53e0:	49 21 54 06 28       	and    %rdx,0x28(%r14,%rax,1)
    53e5:	e8 46 d9 ff ff       	call   2d30 <fwp_rc_clear_slot>
    53ea:	83 3d ab ee 00 00 00 	cmpl   $0x0,0xeeab(%rip)        # 1429c <fwp_gc+0x1004>
    53f1:	74 0e                	je     5401 <fwp_mem_free+0xb1>
    53f3:	41 8b 56 08          	mov    0x8(%r14),%edx
    53f7:	4c 89 ff             	mov    %r15,%rdi
    53fa:	31 f6                	xor    %esi,%esi
    53fc:	e8 0f ce ff ff       	call   2210 <memset@plt>
    5401:	48 8b 03             	mov    (%rbx),%rax
    5404:	48 f7 d0             	not    %rax
    5407:	49 89 07             	mov    %rax,(%r15)
    540a:	4c 89 3b             	mov    %r15,(%rbx)
    540d:	41 8b 46 08          	mov    0x8(%r14),%eax
    5411:	48 01 05 80 de 00 00 	add    %rax,0xde80(%rip)        # 13298 <fwp_gc>
    5418:	e9 fa 00 00 00       	jmp    5517 <fwp_mem_free+0x1c7>
    541d:	48 8b 5c 24 08       	mov    0x8(%rsp),%rbx
    5422:	48 89 df             	mov    %rbx,%rdi
    5425:	e8 26 d9 ff ff       	call   2d50 <fwp_gc_chunk_addr>
    542a:	4c 39 f8             	cmp    %r15,%rax
    542d:	0f 85 e4 00 00 00    	jne    5517 <fwp_mem_free+0x1c7>
    5433:	49 8b 46 18          	mov    0x18(%r14),%rax
    5437:	48 01 05 5a de 00 00 	add    %rax,0xde5a(%rip)        # 13298 <fwp_gc>
    543e:	41 c6 46 03 00       	movb   $0x0,0x3(%r14)
    5443:	4c 89 f7             	mov    %r14,%rdi
    5446:	48 81 c7 28 02 00 00 	add    $0x228,%rdi
    544d:	e8 de d8 ff ff       	call   2d30 <fwp_rc_clear_slot>
    5452:	41 8b 46 10          	mov    0x10(%r14),%eax
    5456:	48 85 c0             	test   %rax,%rax
    5459:	0f 84 91 00 00 00    	je     54f0 <fwp_mem_free+0x1a0>
    545f:	48 8b 0d aa ee 00 00 	mov    0xeeaa(%rip),%rcx        # 14310 <fwp_gc+0x1078>
    5466:	48 69 f3 28 12 00 00 	imul   $0x1228,%rbx,%rsi
    546d:	89 c2                	mov    %eax,%edx
    546f:	83 e2 03             	and    $0x3,%edx
    5472:	83 f8 04             	cmp    $0x4,%eax
    5475:	73 04                	jae    547b <fwp_mem_free+0x12b>
    5477:	31 ff                	xor    %edi,%edi
    5479:	eb 41                	jmp    54bc <fwp_mem_free+0x16c>
    547b:	4c 8d 04 31          	lea    (%rcx,%rsi,1),%r8
    547f:	41 89 c1             	mov    %eax,%r9d
    5482:	41 83 e1 fc          	and    $0xfffffffc,%r9d
    5486:	31 ff                	xor    %edi,%edi
    5488:	0f 1f 84 00 00 00 00 	nopl   0x0(%rax,%rax,1)
    548f:	00 
    5490:	41 c6 00 00          	movb   $0x0,(%r8)
    5494:	41 c6 80 28 12 00 00 	movb   $0x0,0x1228(%r8)
    549b:	00 
    549c:	41 c6 80 50 24 00 00 	movb   $0x0,0x2450(%r8)
    54a3:	00 
    54a4:	41 c6 80 78 36 00 00 	movb   $0x0,0x3678(%r8)
    54ab:	00 
    54ac:	48 83 c7 04          	add    $0x4,%rdi
    54b0:	49 81 c0 a0 48 00 00 	add    $0x48a0,%r8
    54b7:	49 39 f9             	cmp    %rdi,%r9
    54ba:	75 d4                	jne    5490 <fwp_mem_free+0x140>
    54bc:	48 85 d2             	test   %rdx,%rdx
    54bf:	74 2f                	je     54f0 <fwp_mem_free+0x1a0>
    54c1:	48 69 ff 28 12 00 00 	imul   $0x1228,%rdi,%rdi
    54c8:	48 01 f7             	add    %rsi,%rdi
    54cb:	48 01 f9             	add    %rdi,%rcx
    54ce:	48 69 d2 28 12 00 00 	imul   $0x1228,%rdx,%rdx
    54d5:	31 f6                	xor    %esi,%esi
    54d7:	66 0f 1f 84 00 00 00 	nopw   0x0(%rax,%rax,1)
    54de:	00 00 
    54e0:	c6 04 31 00          	movb   $0x0,(%rcx,%rsi,1)
    54e4:	48 81 c6 28 12 00 00 	add    $0x1228,%rsi
    54eb:	48 39 f2             	cmp    %rsi,%rdx
    54ee:	75 f0                	jne    54e0 <fwp_mem_free+0x190>
    54f0:	48 01 05 81 ef 00 00 	add    %rax,0xef81(%rip)        # 14478 <fwp_gc+0x11e0>
    54f7:	48 3b 1d 0a ee 00 00 	cmp    0xee0a(%rip),%rbx        # 14308 <fwp_gc+0x1070>
    54fe:	73 07                	jae    5507 <fwp_mem_free+0x1b7>
    5500:	48 89 1d 01 ee 00 00 	mov    %rbx,0xee01(%rip)        # 14308 <fwp_gc+0x1070>
    5507:	48 3b 1d f2 ed 00 00 	cmp    0xedf2(%rip),%rbx        # 14300 <fwp_gc+0x1068>
    550e:	73 07                	jae    5517 <fwp_mem_free+0x1c7>
    5510:	48 89 1d e9 ed 00 00 	mov    %rbx,0xede9(%rip)        # 14300 <fwp_gc+0x1068>
    5517:	48 83 c4 10          	add    $0x10,%rsp
    551b:	5b                   	pop    %rbx
    551c:	41 5e                	pop    %r14
    551e:	41 5f                	pop    %r15
    5520:	c3                   	ret
    5521:	66 66 66 66 66 66 2e 	data16 data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    5528:	0f 1f 84 00 00 00 00 
    552f:	00 

0000000000005530 <fwp_drop1>:
    5530:	53                   	push   %rbx
    5531:	48 89 fb             	mov    %rdi,%rbx
    5534:	e8 d7 fc ff ff       	call   5210 <fwp_rc_release_last>
    5539:	85 c0                	test   %eax,%eax
    553b:	74 09                	je     5546 <fwp_drop1+0x16>
    553d:	48 89 df             	mov    %rbx,%rdi
    5540:	5b                   	pop    %rbx
    5541:	e9 fa fc ff ff       	jmp    5240 <fwp_rc_free_arr>
    5546:	5b                   	pop    %rbx
    5547:	c3                   	ret
    5548:	0f 1f 84 00 00 00 00 	nopl   0x0(%rax,%rax,1)
    554f:	00 

0000000000005550 <fwp_drop2>:
    5550:	53                   	push   %rbx
    5551:	48 89 fb             	mov    %rdi,%rbx
    5554:	e8 b7 fc ff ff       	call   5210 <fwp_rc_release_last>
    5559:	85 c0                	test   %eax,%eax
    555b:	74 09                	je     5566 <fwp_drop2+0x16>
    555d:	48 89 df             	mov    %rbx,%rdi
    5560:	5b                   	pop    %rbx
    5561:	e9 da fc ff ff       	jmp    5240 <fwp_rc_free_arr>
    5566:	5b                   	pop    %rbx
    5567:	c3                   	ret
    5568:	0f 1f 84 00 00 00 00 	nopl   0x0(%rax,%rax,1)
    556f:	00 

0000000000005570 <fwp_drop3>:
    5570:	53                   	push   %rbx
    5571:	48 89 fb             	mov    %rdi,%rbx
    5574:	e8 97 fc ff ff       	call   5210 <fwp_rc_release_last>
    5579:	85 c0                	test   %eax,%eax
    557b:	74 09                	je     5586 <fwp_drop3+0x16>
    557d:	48 89 df             	mov    %rbx,%rdi
    5580:	5b                   	pop    %rbx
    5581:	e9 ba fc ff ff       	jmp    5240 <fwp_rc_free_arr>
    5586:	5b                   	pop    %rbx
    5587:	c3                   	ret
    5588:	0f 1f 84 00 00 00 00 	nopl   0x0(%rax,%rax,1)
    558f:	00 

0000000000005590 <fwp_drop4>:
    5590:	53                   	push   %rbx
    5591:	48 89 fb             	mov    %rdi,%rbx
    5594:	e8 77 fc ff ff       	call   5210 <fwp_rc_release_last>
    5599:	85 c0                	test   %eax,%eax
    559b:	74 09                	je     55a6 <fwp_drop4+0x16>
    559d:	48 89 df             	mov    %rbx,%rdi
    55a0:	5b                   	pop    %rbx
    55a1:	e9 9a fc ff ff       	jmp    5240 <fwp_rc_free_arr>
    55a6:	5b                   	pop    %rbx
    55a7:	c3                   	ret
    55a8:	0f 1f 84 00 00 00 00 	nopl   0x0(%rax,%rax,1)
    55af:	00 

00000000000055b0 <fwp_drop5>:
    55b0:	53                   	push   %rbx
    55b1:	48 89 fb             	mov    %rdi,%rbx
    55b4:	e8 57 fc ff ff       	call   5210 <fwp_rc_release_last>
    55b9:	85 c0                	test   %eax,%eax
    55bb:	74 09                	je     55c6 <fwp_drop5+0x16>
    55bd:	48 89 df             	mov    %rbx,%rdi
    55c0:	5b                   	pop    %rbx
    55c1:	e9 7a fc ff ff       	jmp    5240 <fwp_rc_free_arr>
    55c6:	5b                   	pop    %rbx
    55c7:	c3                   	ret
    55c8:	0f 1f 84 00 00 00 00 	nopl   0x0(%rax,%rax,1)
    55cf:	00 

00000000000055d0 <fwp_drop6>:
    55d0:	53                   	push   %rbx
    55d1:	48 89 fb             	mov    %rdi,%rbx
    55d4:	e8 37 fc ff ff       	call   5210 <fwp_rc_release_last>
    55d9:	85 c0                	test   %eax,%eax
    55db:	74 09                	je     55e6 <fwp_drop6+0x16>
    55dd:	48 89 df             	mov    %rbx,%rdi
    55e0:	5b                   	pop    %rbx
    55e1:	e9 5a fc ff ff       	jmp    5240 <fwp_rc_free_arr>
    55e6:	5b                   	pop    %rbx
    55e7:	c3                   	ret
    55e8:	0f 1f 84 00 00 00 00 	nopl   0x0(%rax,%rax,1)
    55ef:	00 

00000000000055f0 <fwp_drop7>:
    55f0:	53                   	push   %rbx
    55f1:	48 89 fb             	mov    %rdi,%rbx
    55f4:	e8 17 fc ff ff       	call   5210 <fwp_rc_release_last>
    55f9:	85 c0                	test   %eax,%eax
    55fb:	74 09                	je     5606 <fwp_drop7+0x16>
    55fd:	48 89 df             	mov    %rbx,%rdi
    5600:	5b                   	pop    %rbx
    5601:	e9 3a fc ff ff       	jmp    5240 <fwp_rc_free_arr>
    5606:	5b                   	pop    %rbx
    5607:	c3                   	ret
    5608:	0f 1f 84 00 00 00 00 	nopl   0x0(%rax,%rax,1)
    560f:	00 

0000000000005610 <fwp_data>:
    5610:	55                   	push   %rbp
    5611:	41 57                	push   %r15
    5613:	41 56                	push   %r14
    5615:	53                   	push   %rbx
    5616:	50                   	push   %rax
    5617:	89 fd                	mov    %edi,%ebp
    5619:	85 f6                	test   %esi,%esi
    561b:	0f 84 a1 00 00 00    	je     56c2 <fwp_data+0xb2>
    5621:	48 89 d3             	mov    %rdx,%rbx
    5624:	41 89 f6             	mov    %esi,%r14d
    5627:	4a 8d 3c f5 08 00 00 	lea    0x8(,%r14,8),%rdi
    562e:	00 
    562f:	41 89 f7             	mov    %esi,%r15d
    5632:	e8 d9 00 00 00       	call   5710 <fwp_alloc_init>
    5637:	89 28                	mov    %ebp,(%rax)
    5639:	44 89 78 04          	mov    %r15d,0x4(%rax)
    563d:	41 83 ff 08          	cmp    $0x8,%r15d
    5641:	72 10                	jb     5653 <fwp_data+0x43>
    5643:	48 89 c1             	mov    %rax,%rcx
    5646:	48 29 d9             	sub    %rbx,%rcx
    5649:	48 83 c1 08          	add    $0x8,%rcx
    564d:	48 83 f9 20          	cmp    $0x20,%rcx
    5651:	73 73                	jae    56c6 <fwp_data+0xb6>
    5653:	31 c9                	xor    %ecx,%ecx
    5655:	4c 89 f6             	mov    %r14,%rsi
    5658:	48 89 ca             	mov    %rcx,%rdx
    565b:	48 83 e6 03          	and    $0x3,%rsi
    565f:	74 20                	je     5681 <fwp_data+0x71>
    5661:	48 89 ca             	mov    %rcx,%rdx
    5664:	66 66 66 2e 0f 1f 84 	data16 data16 cs nopw 0x0(%rax,%rax,1)
    566b:	00 00 00 00 00 
    5670:	48 8b 3c d3          	mov    (%rbx,%rdx,8),%rdi
    5674:	48 89 7c d0 08       	mov    %rdi,0x8(%rax,%rdx,8)
    5679:	48 ff c2             	inc    %rdx
    567c:	48 ff ce             	dec    %rsi
    567f:	75 ef                	jne    5670 <fwp_data+0x60>
    5681:	4c 29 f1             	sub    %r14,%rcx
    5684:	48 83 f9 fc          	cmp    $0xfffffffffffffffc,%rcx
    5688:	77 7b                	ja     5705 <fwp_data+0xf5>
    568a:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)
    5690:	48 8b 0c d3          	mov    (%rbx,%rdx,8),%rcx
    5694:	48 89 4c d0 08       	mov    %rcx,0x8(%rax,%rdx,8)
    5699:	48 8b 4c d3 08       	mov    0x8(%rbx,%rdx,8),%rcx
    569e:	48 89 4c d0 10       	mov    %rcx,0x10(%rax,%rdx,8)
    56a3:	48 8b 4c d3 10       	mov    0x10(%rbx,%rdx,8),%rcx
    56a8:	48 89 4c d0 18       	mov    %rcx,0x18(%rax,%rdx,8)
    56ad:	48 8b 4c d3 18       	mov    0x18(%rbx,%rdx,8),%rcx
    56b2:	48 89 4c d0 20       	mov    %rcx,0x20(%rax,%rdx,8)
    56b7:	48 83 c2 04          	add    $0x4,%rdx
    56bb:	49 39 d6             	cmp    %rdx,%r14
    56be:	75 d0                	jne    5690 <fwp_data+0x80>
    56c0:	eb 43                	jmp    5705 <fwp_data+0xf5>
    56c2:	89 e8                	mov    %ebp,%eax
    56c4:	eb 3f                	jmp    5705 <fwp_data+0xf5>
    56c6:	44 89 f1             	mov    %r14d,%ecx
    56c9:	83 e1 fc             	and    $0xfffffffc,%ecx
    56cc:	4a 8d 14 f5 00 00 00 	lea    0x0(,%r14,8),%rdx
    56d3:	00 
    56d4:	48 83 e2 e0          	and    $0xffffffffffffffe0,%rdx
    56d8:	31 f6                	xor    %esi,%esi
    56da:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)
    56e0:	0f 10 04 33          	movups (%rbx,%rsi,1),%xmm0
    56e4:	0f 10 4c 33 10       	movups 0x10(%rbx,%rsi,1),%xmm1
    56e9:	0f 11 44 30 08       	movups %xmm0,0x8(%rax,%rsi,1)
    56ee:	0f 11 4c 30 18       	movups %xmm1,0x18(%rax,%rsi,1)
    56f3:	48 83 c6 20          	add    $0x20,%rsi
    56f7:	48 39 f2             	cmp    %rsi,%rdx
    56fa:	75 e4                	jne    56e0 <fwp_data+0xd0>
    56fc:	4c 39 f1             	cmp    %r14,%rcx
    56ff:	0f 85 50 ff ff ff    	jne    5655 <fwp_data+0x45>
    5705:	48 83 c4 08          	add    $0x8,%rsp
    5709:	5b                   	pop    %rbx
    570a:	41 5e                	pop    %r14
    570c:	41 5f                	pop    %r15
    570e:	5d                   	pop    %rbp
    570f:	c3                   	ret

0000000000005710 <fwp_alloc_init>:
    5710:	53                   	push   %rbx
    5711:	48 89 fa             	mov    %rdi,%rdx
    5714:	48 81 ff 00 40 00 00 	cmp    $0x4000,%rdi
    571b:	0f 87 a7 00 00 00    	ja     57c8 <fwp_alloc_init+0xb8>
    5721:	48 8d 42 0f          	lea    0xf(%rdx),%rax
    5725:	48 c1 e8 04          	shr    $0x4,%rax
    5729:	48 8d 35 68 db 00 00 	lea    0xdb68(%rip),%rsi        # 13298 <fwp_gc>
    5730:	0f b6 bc 30 e8 0b 00 	movzbl 0xbe8(%rax,%rsi,1),%edi
    5737:	00 
    5738:	8b 84 be 48 0b 00 00 	mov    0xb48(%rsi,%rdi,4),%eax
    573f:	48 8b 0d 52 db 00 00 	mov    0xdb52(%rip),%rcx        # 13298 <fwp_gc>
    5746:	49 89 c8             	mov    %rcx,%r8
    5749:	49 29 c0             	sub    %rax,%r8
    574c:	4c 89 05 45 db 00 00 	mov    %r8,0xdb45(%rip)        # 13298 <fwp_gc>
    5753:	78 6c                	js     57c1 <fwp_alloc_init+0xb1>
    5755:	48 8d 3c 7f          	lea    (%rdi,%rdi,2),%rdi
    5759:	4c 8d 04 fe          	lea    (%rsi,%rdi,8),%r8
    575d:	49 83 c0 08          	add    $0x8,%r8
    5761:	49 8b 18             	mov    (%r8),%rbx
    5764:	48 85 db             	test   %rbx,%rbx
    5767:	74 32                	je     579b <fwp_alloc_init+0x8b>
    5769:	48 8b 0b             	mov    (%rbx),%rcx
    576c:	48 f7 d1             	not    %rcx
    576f:	49 89 08             	mov    %rcx,(%r8)
    5772:	81 e2 f8 7f 00 00    	and    $0x7ff8,%edx
    5778:	48 39 c2             	cmp    %rax,%rdx
    577b:	73 19                	jae    5796 <fwp_alloc_init+0x86>
    577d:	48 8d 3c 13          	lea    (%rbx,%rdx,1),%rdi
    5781:	48 f7 d2             	not    %rdx
    5784:	48 01 c2             	add    %rax,%rdx
    5787:	48 83 e2 f8          	and    $0xfffffffffffffff8,%rdx
    578b:	48 83 c2 08          	add    $0x8,%rdx
    578f:	31 f6                	xor    %esi,%esi
    5791:	e8 7a ca ff ff       	call   2210 <memset@plt>
    5796:	48 89 d8             	mov    %rbx,%rax
    5799:	5b                   	pop    %rbx
    579a:	c3                   	ret
    579b:	48 8b 5c fe 10       	mov    0x10(%rsi,%rdi,8),%rbx
    57a0:	4c 8b 44 fe 18       	mov    0x18(%rsi,%rdi,8),%r8
    57a5:	49 29 d8             	sub    %rbx,%r8
    57a8:	49 39 c0             	cmp    %rax,%r8
    57ab:	72 14                	jb     57c1 <fwp_alloc_init+0xb1>
    57ad:	48 8d 34 fe          	lea    (%rsi,%rdi,8),%rsi
    57b1:	48 83 c6 10          	add    $0x10,%rsi
    57b5:	48 8d 3c 03          	lea    (%rbx,%rax,1),%rdi
    57b9:	48 89 3e             	mov    %rdi,(%rsi)
    57bc:	48 85 db             	test   %rbx,%rbx
    57bf:	75 b1                	jne    5772 <fwp_alloc_init+0x62>
    57c1:	48 89 0d d0 da 00 00 	mov    %rcx,0xdad0(%rip)        # 13298 <fwp_gc>
    57c8:	48 89 d7             	mov    %rdx,%rdi
    57cb:	31 f6                	xor    %esi,%esi
    57cd:	5b                   	pop    %rbx
    57ce:	e9 3d dd ff ff       	jmp    3510 <fwp_gc_alloc>
    57d3:	66 66 66 66 2e 0f 1f 	data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    57da:	84 00 00 00 00 00 

00000000000057e0 <f1>:
    57e0:	53                   	push   %rbx
    57e1:	48 83 ec 20          	sub    $0x20,%rsp
    57e5:	48 89 fe             	mov    %rdi,%rsi
    57e8:	48 8d 5c 24 08       	lea    0x8(%rsp),%rbx
    57ed:	48 89 df             	mov    %rbx,%rdi
    57f0:	e8 2b 00 00 00       	call   5820 <w1>
    57f5:	bf 03 00 00 00       	mov    $0x3,%edi
    57fa:	48 89 de             	mov    %rbx,%rsi
    57fd:	e8 fe d9 ff ff       	call   3200 <fwp_record>
    5802:	48 89 c3             	mov    %rax,%rbx
    5805:	48 89 c7             	mov    %rax,%rdi
    5808:	e8 b3 d9 ff ff       	call   31c0 <fwp_rc_fresh>
    580d:	48 89 d8             	mov    %rbx,%rax
    5810:	48 83 c4 20          	add    $0x20,%rsp
    5814:	5b                   	pop    %rbx
    5815:	c3                   	ret
    5816:	66 2e 0f 1f 84 00 00 	cs nopw 0x0(%rax,%rax,1)
    581d:	00 00 00 

0000000000005820 <w1>:
    5820:	41 57                	push   %r15
    5822:	41 56                	push   %r14
    5824:	53                   	push   %rbx
    5825:	48 89 f3             	mov    %rsi,%rbx
    5828:	49 89 fe             	mov    %rdi,%r14
    582b:	48 bf 00 00 00 00 00 	movabs $0x3fd0000000000000,%rdi
    5832:	00 d0 3f 
    5835:	e8 26 00 00 00       	call   5860 <f4>
    583a:	49 89 c7             	mov    %rax,%r15
    583d:	48 89 df             	mov    %rbx,%rdi
    5840:	e8 4b 00 00 00       	call   5890 <f8>
    5845:	49 89 1e             	mov    %rbx,(%r14)
    5848:	4d 89 7e 08          	mov    %r15,0x8(%r14)
    584c:	49 89 46 10          	mov    %rax,0x10(%r14)
    5850:	4c 89 f0             	mov    %r14,%rax
    5853:	5b                   	pop    %rbx
    5854:	41 5e                	pop    %r14
    5856:	41 5f                	pop    %r15
    5858:	c3                   	ret
    5859:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)

0000000000005860 <f4>:
    5860:	53                   	push   %rbx
    5861:	48 83 ec 10          	sub    $0x10,%rsp
    5865:	48 89 fb             	mov    %rdi,%rbx
    5868:	48 89 f7             	mov    %rsi,%rdi
    586b:	e8 40 00 00 00       	call   58b0 <fwp_f64>
    5870:	f2 0f 11 44 24 08    	movsd  %xmm0,0x8(%rsp)
    5876:	48 89 df             	mov    %rbx,%rdi
    5879:	e8 32 00 00 00       	call   58b0 <fwp_f64>
    587e:	f2 0f 58 44 24 08    	addsd  0x8(%rsp),%xmm0
    5884:	48 83 c4 10          	add    $0x10,%rsp
    5888:	5b                   	pop    %rbx
    5889:	e9 c2 d0 ff ff       	jmp    2950 <fwp_from_f64>
    588e:	66 90                	xchg   %ax,%ax

0000000000005890 <f8>:
    5890:	50                   	push   %rax
    5891:	e8 1a 00 00 00       	call   58b0 <fwp_f64>
    5896:	0f 57 05 83 78 00 00 	xorps  0x7883(%rip),%xmm0        # d120 <_IO_stdin_used+0x120>
    589d:	58                   	pop    %rax
    589e:	e9 ad d0 ff ff       	jmp    2950 <fwp_from_f64>
    58a3:	66 66 66 66 2e 0f 1f 	data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    58aa:	84 00 00 00 00 00 

00000000000058b0 <fwp_f64>:
    58b0:	66 48 0f 6e c7       	movq   %rdi,%xmm0
    58b5:	c3                   	ret
    58b6:	66 2e 0f 1f 84 00 00 	cs nopw 0x0(%rax,%rax,1)
    58bd:	00 00 00 

00000000000058c0 <fwp_stack_guard_init>:
    58c0:	53                   	push   %rbx
    58c1:	48 81 ec c0 00 00 00 	sub    $0xc0,%rsp
    58c8:	48 8d 44 24 0f       	lea    0xf(%rsp),%rax
    58cd:	48 89 05 d4 f4 00 00 	mov    %rax,0xf4d4(%rip)        # 14da8 <fwp_main_stack_top>
    58d4:	48 89 3d d5 f4 00 00 	mov    %rdi,0xf4d5(%rip)        # 14db0 <fwp_main_stack_size>
    58db:	48 8d 05 de f4 00 00 	lea    0xf4de(%rip),%rax        # 14dc0 <fwp_stack_guard_init.alt>
    58e2:	48 89 44 24 10       	mov    %rax,0x10(%rsp)
    58e7:	48 c7 44 24 20 00 00 	movq   $0x10000,0x20(%rsp)
    58ee:	01 00 
    58f0:	c7 44 24 18 00 00 00 	movl   $0x0,0x18(%rsp)
    58f7:	00 
    58f8:	48 8d 7c 24 10       	lea    0x10(%rsp),%rdi
    58fd:	31 f6                	xor    %esi,%esi
    58ff:	e8 cc cb ff ff       	call   24d0 <sigaltstack@plt>
    5904:	85 c0                	test   %eax,%eax
    5906:	0f 85 80 00 00 00    	jne    598c <fwp_stack_guard_init+0xcc>
    590c:	48 8d 7c 24 30       	lea    0x30(%rsp),%rdi
    5911:	0f 57 c0             	xorps  %xmm0,%xmm0
    5914:	0f 11 84 24 b0 00 00 	movups %xmm0,0xb0(%rsp)
    591b:	00 
    591c:	0f 11 84 24 a0 00 00 	movups %xmm0,0xa0(%rsp)
    5923:	00 
    5924:	0f 11 84 24 90 00 00 	movups %xmm0,0x90(%rsp)
    592b:	00 
    592c:	0f 11 84 24 80 00 00 	movups %xmm0,0x80(%rsp)
    5933:	00 
    5934:	0f 11 44 24 70       	movups %xmm0,0x70(%rsp)
    5939:	0f 11 44 24 60       	movups %xmm0,0x60(%rsp)
    593e:	0f 11 44 24 50       	movups %xmm0,0x50(%rsp)
    5943:	0f 11 44 24 40       	movups %xmm0,0x40(%rsp)
    5948:	0f 11 44 24 30       	movups %xmm0,0x30(%rsp)
    594d:	48 8d 05 7c 07 00 00 	lea    0x77c(%rip),%rax        # 60d0 <fwp_segv>
    5954:	48 89 44 24 28       	mov    %rax,0x28(%rsp)
    5959:	c7 84 24 b0 00 00 00 	movl   $0x8000004,0xb0(%rsp)
    5960:	04 00 00 08 
    5964:	e8 a7 c9 ff ff       	call   2310 <sigemptyset@plt>
    5969:	48 8d 5c 24 28       	lea    0x28(%rsp),%rbx
    596e:	bf 0b 00 00 00       	mov    $0xb,%edi
    5973:	48 89 de             	mov    %rbx,%rsi
    5976:	31 d2                	xor    %edx,%edx
    5978:	e8 63 c7 ff ff       	call   20e0 <sigaction@plt>
    597d:	bf 07 00 00 00       	mov    $0x7,%edi
    5982:	48 89 de             	mov    %rbx,%rsi
    5985:	31 d2                	xor    %edx,%edx
    5987:	e8 54 c7 ff ff       	call   20e0 <sigaction@plt>
    598c:	48 81 c4 c0 00 00 00 	add    $0xc0,%rsp
    5993:	5b                   	pop    %rbx
    5994:	c3                   	ret
    5995:	66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
    599c:	00 00 00 00 

00000000000059a0 <fwp_exec>:
    59a0:	55                   	push   %rbp
    59a1:	41 57                	push   %r15
    59a3:	41 56                	push   %r14
    59a5:	41 55                	push   %r13
    59a7:	41 54                	push   %r12
    59a9:	53                   	push   %rbx
    59aa:	48 81 ec 58 01 00 00 	sub    $0x158,%rsp
    59b1:	49 89 f7             	mov    %rsi,%r15
    59b4:	41 89 fd             	mov    %edi,%r13d
    59b7:	41 8d 5d ff          	lea    -0x1(%r13),%ebx
    59bb:	80 3d de f3 00 00 01 	cmpb   $0x1,0xf3de(%rip)        # 14da0 <fwp_cli_single>
    59c2:	75 16                	jne    59da <fwp_exec+0x3a>
    59c4:	49 8d 77 08          	lea    0x8(%r15),%rsi
    59c8:	89 df                	mov    %ebx,%edi
    59ca:	e8 91 07 00 00       	call   6160 <fwp_generated>
    59cf:	41 89 c6             	mov    %eax,%r14d
    59d2:	85 c0                	test   %eax,%eax
    59d4:	0f 89 1a 01 00 00    	jns    5af4 <fwp_exec+0x154>
    59da:	89 5c 24 18          	mov    %ebx,0x18(%rsp)
    59de:	49 63 fd             	movslq %r13d,%rdi
    59e1:	48 c1 e7 03          	shl    $0x3,%rdi
    59e5:	48 89 7c 24 48       	mov    %rdi,0x48(%rsp)
    59ea:	e8 11 db ff ff       	call   3500 <fwp_alloc>
    59ef:	49 89 c4             	mov    %rax,%r12
    59f2:	41 83 fd 02          	cmp    $0x2,%r13d
    59f6:	7c 30                	jl     5a28 <fwp_exec+0x88>
    59f8:	8b 6c 24 18          	mov    0x18(%rsp),%ebp
    59fc:	31 db                	xor    %ebx,%ebx
    59fe:	66 90                	xchg   %ax,%ax
    5a00:	4c 8d 73 01          	lea    0x1(%rbx),%r14
    5a04:	4d 8b 6c df 08       	mov    0x8(%r15,%rbx,8),%r13
    5a09:	4c 89 ef             	mov    %r13,%rdi
    5a0c:	e8 5f c7 ff ff       	call   2170 <strlen@plt>
    5a11:	4c 89 ef             	mov    %r13,%rdi
    5a14:	48 89 c6             	mov    %rax,%rsi
    5a17:	e8 a4 08 00 00       	call   62c0 <fwp_str_lossy>
    5a1c:	49 89 04 dc          	mov    %rax,(%r12,%rbx,8)
    5a20:	4c 89 f3             	mov    %r14,%rbx
    5a23:	4c 39 f5             	cmp    %r14,%rbp
    5a26:	75 d8                	jne    5a00 <fwp_exec+0x60>
    5a28:	bf 08 00 00 00       	mov    $0x8,%edi
    5a2d:	e8 ce da ff ff       	call   3500 <fwp_alloc>
    5a32:	bf 01 00 00 00       	mov    $0x1,%edi
    5a37:	e8 64 0a 00 00       	call   64a0 <fwp_alloc_leaf>
    5a3c:	48 8b 7c 24 48       	mov    0x48(%rsp),%rdi
    5a41:	e8 ba da ff ff       	call   3500 <fwp_alloc>
    5a46:	49 89 c6             	mov    %rax,%r14
    5a49:	48 8d 4c 24 2c       	lea    0x2c(%rsp),%rcx
    5a4e:	8b 7c 24 18          	mov    0x18(%rsp),%edi
    5a52:	4c 89 e6             	mov    %r12,%rsi
    5a55:	48 89 c2             	mov    %rax,%rdx
    5a58:	e8 53 0a 00 00       	call   64b0 <fwp_cli_parse>
    5a5d:	83 f8 02             	cmp    $0x2,%eax
    5a60:	74 32                	je     5a94 <fwp_exec+0xf4>
    5a62:	83 f8 01             	cmp    $0x1,%eax
    5a65:	75 5d                	jne    5ac4 <fwp_exec+0x124>
    5a67:	48 8b 1d 42 d5 00 00 	mov    0xd542(%rip),%rbx        # 12fb0 <stdout@GLIBC_2.2.5>
    5a6e:	48 8b 0b             	mov    (%rbx),%rcx
    5a71:	48 8d 3d 93 89 00 00 	lea    0x8993(%rip),%rdi        # e40b <exec_in_fp0+0xdcb>
    5a78:	be 72 00 00 00       	mov    $0x72,%esi
    5a7d:	ba 01 00 00 00       	mov    $0x1,%edx
    5a82:	e8 19 ca ff ff       	call   24a0 <fwrite@plt>
    5a87:	48 8b 3b             	mov    (%rbx),%rdi
    5a8a:	e8 c1 c8 ff ff       	call   2350 <fflush@plt>
    5a8f:	45 31 f6             	xor    %r14d,%r14d
    5a92:	eb 60                	jmp    5af4 <fwp_exec+0x154>
    5a94:	48 8d 3d de 85 00 00 	lea    0x85de(%rip),%rdi        # e079 <exec_in_fp0+0xa39>
    5a9b:	48 8d 15 d0 7b 00 00 	lea    0x7bd0(%rip),%rdx        # d672 <exec_in_fp0+0x32>
    5aa2:	45 31 f6             	xor    %r14d,%r14d
    5aa5:	be 06 00 00 00       	mov    $0x6,%esi
    5aaa:	31 c9                	xor    %ecx,%ecx
    5aac:	31 c0                	xor    %eax,%eax
    5aae:	e8 0d c7 ff ff       	call   21c0 <printf@plt>
    5ab3:	48 8b 05 f6 d4 00 00 	mov    0xd4f6(%rip),%rax        # 12fb0 <stdout@GLIBC_2.2.5>
    5aba:	48 8b 38             	mov    (%rax),%rdi
    5abd:	e8 8e c8 ff ff       	call   2350 <fflush@plt>
    5ac2:	eb 30                	jmp    5af4 <fwp_exec+0x154>
    5ac4:	bf 10 00 00 00       	mov    $0x10,%edi
    5ac9:	e8 32 da ff ff       	call   3500 <fwp_alloc>
    5ace:	49 89 c7             	mov    %rax,%r15
    5ad1:	c7 44 24 14 00 00 00 	movl   $0x0,0x14(%rsp)
    5ad8:	00 
    5ad9:	8b 74 24 2c          	mov    0x2c(%rsp),%esi
    5add:	48 8d 4c 24 14       	lea    0x14(%rsp),%rcx
    5ae2:	4c 89 f7             	mov    %r14,%rdi
    5ae5:	48 89 c2             	mov    %rax,%rdx
    5ae8:	e8 23 0c 00 00       	call   6710 <fwp_bind_positional>
    5aed:	41 89 c6             	mov    %eax,%r14d
    5af0:	85 c0                	test   %eax,%eax
    5af2:	74 15                	je     5b09 <fwp_exec+0x169>
    5af4:	44 89 f0             	mov    %r14d,%eax
    5af7:	48 81 c4 58 01 00 00 	add    $0x158,%rsp
    5afe:	5b                   	pop    %rbx
    5aff:	41 5c                	pop    %r12
    5b01:	41 5d                	pop    %r13
    5b03:	41 5e                	pop    %r14
    5b05:	41 5f                	pop    %r15
    5b07:	5d                   	pop    %rbp
    5b08:	c3                   	ret
    5b09:	48 8d 3d 72 85 00 00 	lea    0x8572(%rip),%rdi        # e082 <exec_in_fp0+0xa42>
    5b10:	e8 1b c5 ff ff       	call   2030 <getenv@plt>
    5b15:	48 85 c0             	test   %rax,%rax
    5b18:	74 27                	je     5b41 <fwp_exec+0x1a1>
    5b1a:	48 8d 35 69 85 00 00 	lea    0x8569(%rip),%rsi        # e08a <exec_in_fp0+0xa4a>
    5b21:	48 89 c7             	mov    %rax,%rdi
    5b24:	e8 a7 c7 ff ff       	call   22d0 <strcmp@plt>
    5b29:	31 c9                	xor    %ecx,%ecx
    5b2b:	85 c0                	test   %eax,%eax
    5b2d:	0f 94 c1             	sete   %cl
    5b30:	89 0d 8a f2 01 00    	mov    %ecx,0x1f28a(%rip)        # 24dc0 <fwp_exec_binary_out>
    5b36:	75 26                	jne    5b5e <fwp_exec+0x1be>
    5b38:	48 8b 05 99 d4 00 00 	mov    0xd499(%rip),%rax        # 12fd8 <stderr@GLIBC_2.2.5>
    5b3f:	eb 24                	jmp    5b65 <fwp_exec+0x1c5>
    5b41:	c7 05 75 f2 01 00 00 	movl   $0x0,0x1f275(%rip)        # 24dc0 <fwp_exec_binary_out>
    5b48:	00 00 00 
    5b4b:	48 8b 05 5e d4 00 00 	mov    0xd45e(%rip),%rax        # 12fb0 <stdout@GLIBC_2.2.5>
    5b52:	48 8b 00             	mov    (%rax),%rax
    5b55:	48 89 05 ec f1 00 00 	mov    %rax,0xf1ec(%rip)        # 14d48 <fwp_prog_out>
    5b5c:	eb 33                	jmp    5b91 <fwp_exec+0x1f1>
    5b5e:	48 8b 05 4b d4 00 00 	mov    0xd44b(%rip),%rax        # 12fb0 <stdout@GLIBC_2.2.5>
    5b65:	48 8b 00             	mov    (%rax),%rax
    5b68:	48 89 05 d9 f1 00 00 	mov    %rax,0xf1d9(%rip)        # 14d48 <fwp_prog_out>
    5b6f:	75 20                	jne    5b91 <fwp_exec+0x1f1>
    5b71:	e8 da 0b 00 00       	call   6750 <fwp_pipe_out_start>
    5b76:	48 8d 3d 93 7a 00 00 	lea    0x7a93(%rip),%rdi        # d610 <exec_out_header0>
    5b7d:	be 30 00 00 00       	mov    $0x30,%esi
    5b82:	e8 99 0c 00 00       	call   6820 <fwp_pipe_write>
    5b87:	e8 44 0d 00 00       	call   68d0 <fwp_pipe_flush>
    5b8c:	e8 6f 0d 00 00       	call   6900 <fwp_pipe_out_ready>
    5b91:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%rsp)
    5b98:	00 
    5b99:	83 7c 24 14 00       	cmpl   $0x0,0x14(%rsp)
    5b9e:	0f 84 57 01 00 00    	je     5cfb <fwp_exec+0x35b>
    5ba4:	48 8b 1d 0d d4 00 00 	mov    0xd40d(%rip),%rbx        # 12fb8 <stdin@GLIBC_2.2.5>
    5bab:	48 8b 3b             	mov    (%rbx),%rdi
    5bae:	b9 00 00 10 00       	mov    $0x100000,%ecx
    5bb3:	31 f6                	xor    %esi,%esi
    5bb5:	31 d2                	xor    %edx,%edx
    5bb7:	e8 f4 c7 ff ff       	call   23b0 <setvbuf@plt>
    5bbc:	48 8b 0b             	mov    (%rbx),%rcx
    5bbf:	48 8d 3d fe f1 01 00 	lea    0x1f1fe(%rip),%rdi        # 24dc4 <fwp_in_pend>
    5bc6:	be 01 00 00 00       	mov    $0x1,%esi
    5bcb:	ba 04 00 00 00       	mov    $0x4,%edx
    5bd0:	e8 1b c5 ff ff       	call   20f0 <fread@plt>
    5bd5:	89 05 ed f1 01 00    	mov    %eax,0x1f1ed(%rip)        # 24dc8 <fwp_in_npend>
    5bdb:	c7 05 e7 f1 01 00 00 	movl   $0x0,0x1f1e7(%rip)        # 24dcc <fwp_in_ppos>
    5be2:	00 00 00 
    5be5:	41 b4 01             	mov    $0x1,%r12b
    5be8:	83 f8 04             	cmp    $0x4,%eax
    5beb:	4c 89 7c 24 18       	mov    %r15,0x18(%rsp)
    5bf0:	0f 85 d3 01 00 00    	jne    5dc9 <fwp_exec+0x429>
    5bf6:	81 3d c4 f1 01 00 46 	cmpl   $0x31505746,0x1f1c4(%rip)        # 24dc4 <fwp_in_pend>
    5bfd:	57 50 31 
    5c00:	0f 85 c3 01 00 00    	jne    5dc9 <fwp_exec+0x429>
    5c06:	c7 05 bc f1 01 00 04 	movl   $0x4,0x1f1bc(%rip)        # 24dcc <fwp_in_ppos>
    5c0d:	00 00 00 
    5c10:	48 8d 7c 24 03       	lea    0x3(%rsp),%rdi
    5c15:	be 01 00 00 00       	mov    $0x1,%esi
    5c1a:	e8 41 0e 00 00       	call   6a60 <fwp_read_exact>
    5c1f:	85 c0                	test   %eax,%eax
    5c21:	0f 84 c3 03 00 00    	je     5fea <fwp_exec+0x64a>
    5c27:	48 8d 7c 24 20       	lea    0x20(%rsp),%rdi
    5c2c:	e8 2f 0f 00 00       	call   6b60 <fwp_stdin_leb>
    5c31:	83 f8 01             	cmp    $0x1,%eax
    5c34:	0f 85 99 03 00 00    	jne    5fd3 <fwp_exec+0x633>
    5c3a:	48 8b 44 24 20       	mov    0x20(%rsp),%rax
    5c3f:	48 83 f8 40          	cmp    $0x40,%rax
    5c43:	41 bd 40 00 00 00    	mov    $0x40,%r13d
    5c49:	4c 0f 42 e8          	cmovb  %rax,%r13
    5c4d:	48 85 c0             	test   %rax,%rax
    5c50:	0f 84 e2 00 00 00    	je     5d38 <fwp_exec+0x398>
    5c56:	45 31 f6             	xor    %r14d,%r14d
    5c59:	4c 8d 7c 24 50       	lea    0x50(%rsp),%r15
    5c5e:	31 ed                	xor    %ebp,%ebp
    5c60:	eb 4a                	jmp    5cac <fwp_exec+0x30c>
    5c62:	be 06 00 00 00       	mov    $0x6,%esi
    5c67:	4c 89 ff             	mov    %r15,%rdi
    5c6a:	e8 f1 0d 00 00       	call   6a60 <fwp_read_exact>
    5c6f:	85 c0                	test   %eax,%eax
    5c71:	0f 84 73 03 00 00    	je     5fea <fwp_exec+0x64a>
    5c77:	8b 44 24 50          	mov    0x50(%rsp),%eax
    5c7b:	b9 55 44 53 5f       	mov    $0x5f534455,%ecx
    5c80:	31 c8                	xor    %ecx,%eax
    5c82:	0f b7 4c 24 54       	movzwl 0x54(%rsp),%ecx
    5c87:	81 f1 56 31 00 00    	xor    $0x3156,%ecx
    5c8d:	09 c1                	or     %eax,%ecx
    5c8f:	b8 01 00 00 00       	mov    $0x1,%eax
    5c94:	0f 44 e8             	cmove  %eax,%ebp
    5c97:	48 c7 44 24 08 00 00 	movq   $0x0,0x8(%rsp)
    5c9e:	00 00 
    5ca0:	49 ff c6             	inc    %r14
    5ca3:	4d 39 ee             	cmp    %r13,%r14
    5ca6:	0f 84 8e 00 00 00    	je     5d3a <fwp_exec+0x39a>
    5cac:	48 8d 7c 24 08       	lea    0x8(%rsp),%rdi
    5cb1:	e8 2a 0f 00 00       	call   6be0 <fwp_stdin_name_len>
    5cb6:	83 f8 01             	cmp    $0x1,%eax
    5cb9:	0f 85 14 03 00 00    	jne    5fd3 <fwp_exec+0x633>
    5cbf:	48 8b 5c 24 08       	mov    0x8(%rsp),%rbx
    5cc4:	48 85 db             	test   %rbx,%rbx
    5cc7:	74 ce                	je     5c97 <fwp_exec+0x2f7>
    5cc9:	48 83 fb 06          	cmp    $0x6,%rbx
    5ccd:	74 93                	je     5c62 <fwp_exec+0x2c2>
    5ccf:	90                   	nop
    5cd0:	48 81 fb 00 01 00 00 	cmp    $0x100,%rbx
    5cd7:	41 bc 00 01 00 00    	mov    $0x100,%r12d
    5cdd:	4c 0f 42 e3          	cmovb  %rbx,%r12
    5ce1:	4c 89 ff             	mov    %r15,%rdi
    5ce4:	4c 89 e6             	mov    %r12,%rsi
    5ce7:	e8 74 0d 00 00       	call   6a60 <fwp_read_exact>
    5cec:	85 c0                	test   %eax,%eax
    5cee:	0f 84 f6 02 00 00    	je     5fea <fwp_exec+0x64a>
    5cf4:	4c 29 e3             	sub    %r12,%rbx
    5cf7:	75 d7                	jne    5cd0 <fwp_exec+0x330>
    5cf9:	eb 9c                	jmp    5c97 <fwp_exec+0x2f7>
    5cfb:	48 8d 74 24 04       	lea    0x4(%rsp),%rsi
    5d00:	4c 89 ff             	mov    %r15,%rdi
    5d03:	e8 98 0c 00 00       	call   69a0 <fwp_exec_call>
    5d08:	48 89 c3             	mov    %rax,%rbx
    5d0b:	48 8b 3d 36 f0 00 00 	mov    0xf036(%rip),%rdi        # 14d48 <fwp_prog_out>
    5d12:	e8 39 c6 ff ff       	call   2350 <fflush@plt>
    5d17:	41 be 01 00 00 00    	mov    $0x1,%r14d
    5d1d:	83 7c 24 04 00       	cmpl   $0x0,0x4(%rsp)
    5d22:	0f 85 83 02 00 00    	jne    5fab <fwp_exec+0x60b>
    5d28:	48 89 df             	mov    %rbx,%rdi
    5d2b:	e8 20 0d 00 00       	call   6a50 <fwp_emit_result>
    5d30:	45 31 f6             	xor    %r14d,%r14d
    5d33:	e9 73 02 00 00       	jmp    5fab <fwp_exec+0x60b>
    5d38:	31 ed                	xor    %ebp,%ebp
    5d3a:	48 8d 7c 24 30       	lea    0x30(%rsp),%rdi
    5d3f:	be 10 00 00 00       	mov    $0x10,%esi
    5d44:	e8 17 0d 00 00       	call   6a60 <fwp_read_exact>
    5d49:	85 c0                	test   %eax,%eax
    5d4b:	0f 84 99 02 00 00    	je     5fea <fwp_exec+0x64a>
    5d51:	48 8d 7c 24 08       	lea    0x8(%rsp),%rdi
    5d56:	e8 85 0e 00 00       	call   6be0 <fwp_stdin_name_len>
    5d5b:	83 f8 01             	cmp    $0x1,%eax
    5d5e:	0f 85 6f 02 00 00    	jne    5fd3 <fwp_exec+0x633>
    5d64:	4c 8b 7c 24 08       	mov    0x8(%rsp),%r15
    5d69:	49 8d 7f 01          	lea    0x1(%r15),%rdi
    5d6d:	e8 2e 07 00 00       	call   64a0 <fwp_alloc_leaf>
    5d72:	49 89 c6             	mov    %rax,%r14
    5d75:	4d 85 ff             	test   %r15,%r15
    5d78:	74 13                	je     5d8d <fwp_exec+0x3ed>
    5d7a:	4c 89 f7             	mov    %r14,%rdi
    5d7d:	4c 89 fe             	mov    %r15,%rsi
    5d80:	e8 db 0c 00 00       	call   6a60 <fwp_read_exact>
    5d85:	85 c0                	test   %eax,%eax
    5d87:	0f 84 5d 02 00 00    	je     5fea <fwp_exec+0x64a>
    5d8d:	43 c6 04 3e 00       	movb   $0x0,(%r14,%r15,1)
    5d92:	0f b6 4c 24 03       	movzbl 0x3(%rsp),%ecx
    5d97:	83 f9 01             	cmp    $0x1,%ecx
    5d9a:	0f 85 ab 02 00 00    	jne    604b <fwp_exec+0x6ab>
    5da0:	66 0f 6f 44 24 30    	movdqa 0x30(%rsp),%xmm0
    5da6:	66 0f 74 05 82 73 00 	pcmpeqb 0x7382(%rip),%xmm0        # d130 <_IO_stdin_used+0x130>
    5dad:	00 
    5dae:	66 0f d7 c0          	pmovmskb %xmm0,%eax
    5db2:	3d ff ff 00 00       	cmp    $0xffff,%eax
    5db7:	0f 85 af 02 00 00    	jne    606c <fwp_exec+0x6cc>
    5dbd:	85 ed                	test   %ebp,%ebp
    5dbf:	74 05                	je     5dc6 <fwp_exec+0x426>
    5dc1:	e8 4a 0e 00 00       	call   6c10 <fwp_pipe_in_offer>
    5dc6:	45 31 e4             	xor    %r12d,%r12d
    5dc9:	66 0f ef c0          	pxor   %xmm0,%xmm0
    5dcd:	66 0f 7f 44 24 50    	movdqa %xmm0,0x50(%rsp)
    5dd3:	48 c7 44 24 60 00 00 	movq   $0x0,0x60(%rsp)
    5dda:	00 00 
    5ddc:	45 31 ff             	xor    %r15d,%r15d
    5ddf:	45 31 f6             	xor    %r14d,%r14d
    5de2:	eb 35                	jmp    5e19 <fwp_exec+0x479>
    5de4:	48 89 ef             	mov    %rbp,%rdi
    5de7:	4c 89 ee             	mov    %r13,%rsi
    5dea:	e8 21 0f 00 00       	call   6d10 <fwp_pipe_in_switch>
    5def:	bb 10 00 00 00       	mov    $0x10,%ebx
    5df4:	48 8d 35 0b 83 00 00 	lea    0x830b(%rip),%rsi        # e106 <exec_in_fp0+0xac6>
    5dfb:	85 c0                	test   %eax,%eax
    5dfd:	0f 84 6b 01 00 00    	je     5f6e <fwp_exec+0x5ce>
    5e03:	66 66 66 66 2e 0f 1f 	data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    5e0a:	84 00 00 00 00 00 
    5e10:	83 fb 0f             	cmp    $0xf,%ebx
    5e13:	0f 84 83 01 00 00    	je     5f9c <fwp_exec+0x5fc>
    5e19:	45 84 e4             	test   %r12b,%r12b
    5e1c:	0f 84 9e 00 00 00    	je     5ec0 <fwp_exec+0x520>
    5e22:	48 8d 7c 24 50       	lea    0x50(%rsp),%rdi
    5e27:	e8 44 15 00 00       	call   7370 <fwp_read_text_line>
    5e2c:	4c 8b 7c 24 50       	mov    0x50(%rsp),%r15
    5e31:	85 c0                	test   %eax,%eax
    5e33:	0f 84 63 01 00 00    	je     5f9c <fwp_exec+0x5fc>
    5e39:	4d 85 ff             	test   %r15,%r15
    5e3c:	4c 89 ff             	mov    %r15,%rdi
    5e3f:	48 8d 05 32 82 00 00 	lea    0x8232(%rip),%rax        # e078 <exec_in_fp0+0xa38>
    5e46:	48 0f 44 f8          	cmove  %rax,%rdi
    5e4a:	48 8b 74 24 58       	mov    0x58(%rsp),%rsi
    5e4f:	e8 6c 04 00 00       	call   62c0 <fwp_str_lossy>
    5e54:	48 89 c5             	mov    %rax,%rbp
    5e57:	4c 8d 68 08          	lea    0x8(%rax),%r13
    5e5b:	48 8b 30             	mov    (%rax),%rsi
    5e5e:	4c 89 ef             	mov    %r13,%rdi
    5e61:	48 8d 54 24 20       	lea    0x20(%rsp),%rdx
    5e66:	e8 e5 07 00 00       	call   6650 <fwp_parse_text>
    5e6b:	85 c0                	test   %eax,%eax
    5e6d:	0f 84 a1 01 00 00    	je     6014 <fwp_exec+0x674>
    5e73:	48 8b 44 24 20       	mov    0x20(%rsp),%rax
    5e78:	48 8b 7c 24 18       	mov    0x18(%rsp),%rdi
    5e7d:	48 89 07             	mov    %rax,(%rdi)
    5e80:	48 8d 74 24 04       	lea    0x4(%rsp),%rsi
    5e85:	e8 16 0b 00 00       	call   69a0 <fwp_exec_call>
    5e8a:	49 89 c5             	mov    %rax,%r13
    5e8d:	48 8b 3d b4 ee 00 00 	mov    0xeeb4(%rip),%rdi        # 14d48 <fwp_prog_out>
    5e94:	e8 b7 c4 ff ff       	call   2350 <fflush@plt>
    5e99:	83 7c 24 04 00       	cmpl   $0x0,0x4(%rsp)
    5e9e:	0f 85 f2 00 00 00    	jne    5f96 <fwp_exec+0x5f6>
    5ea4:	4c 89 ef             	mov    %r13,%rdi
    5ea7:	e8 a4 0b 00 00       	call   6a50 <fwp_emit_result>
    5eac:	e8 1f 0a 00 00       	call   68d0 <fwp_pipe_flush>
    5eb1:	31 db                	xor    %ebx,%ebx
    5eb3:	e9 58 ff ff ff       	jmp    5e10 <fwp_exec+0x470>
    5eb8:	0f 1f 84 00 00 00 00 	nopl   0x0(%rax,%rax,1)
    5ebf:	00 
    5ec0:	be 01 00 00 00       	mov    $0x1,%esi
    5ec5:	48 8d 7c 24 08       	lea    0x8(%rsp),%rdi
    5eca:	e8 91 0b 00 00       	call   6a60 <fwp_read_exact>
    5ecf:	bb 0f 00 00 00       	mov    $0xf,%ebx
    5ed4:	85 c0                	test   %eax,%eax
    5ed6:	0f 84 34 ff ff ff    	je     5e10 <fwp_exec+0x470>
    5edc:	be 04 00 00 00       	mov    $0x4,%esi
    5ee1:	48 8d 7c 24 09       	lea    0x9(%rsp),%rdi
    5ee6:	e8 75 0b 00 00       	call   6a60 <fwp_read_exact>
    5eeb:	48 8d 35 ff 81 00 00 	lea    0x81ff(%rip),%rsi        # e0f1 <exec_in_fp0+0xab1>
    5ef2:	85 c0                	test   %eax,%eax
    5ef4:	74 78                	je     5f6e <fwp_exec+0x5ce>
    5ef6:	44 8b 6c 24 09       	mov    0x9(%rsp),%r13d
    5efb:	49 8d 7d 01          	lea    0x1(%r13),%rdi
    5eff:	e8 9c 05 00 00       	call   64a0 <fwp_alloc_leaf>
    5f04:	48 89 c5             	mov    %rax,%rbp
    5f07:	4d 85 ed             	test   %r13,%r13
    5f0a:	74 16                	je     5f22 <fwp_exec+0x582>
    5f0c:	48 89 ef             	mov    %rbp,%rdi
    5f0f:	4c 89 ee             	mov    %r13,%rsi
    5f12:	e8 49 0b 00 00       	call   6a60 <fwp_read_exact>
    5f17:	48 8d 35 d3 81 00 00 	lea    0x81d3(%rip),%rsi        # e0f1 <exec_in_fp0+0xab1>
    5f1e:	85 c0                	test   %eax,%eax
    5f20:	74 4c                	je     5f6e <fwp_exec+0x5ce>
    5f22:	0f b6 44 24 08       	movzbl 0x8(%rsp),%eax
    5f27:	85 c0                	test   %eax,%eax
    5f29:	0f 84 e1 fe ff ff    	je     5e10 <fwp_exec+0x470>
    5f2f:	83 f8 02             	cmp    $0x2,%eax
    5f32:	0f 84 ac fe ff ff    	je     5de4 <fwp_exec+0x444>
    5f38:	48 89 6c 24 30       	mov    %rbp,0x30(%rsp)
    5f3d:	4c 89 6c 24 38       	mov    %r13,0x38(%rsp)
    5f42:	48 c7 44 24 40 00 00 	movq   $0x0,0x40(%rsp)
    5f49:	00 00 
    5f4b:	48 8d 7c 24 30       	lea    0x30(%rsp),%rdi
    5f50:	48 8d 35 79 ed 00 00 	lea    0xed79(%rip),%rsi        # 14cd0 <d0>
    5f57:	48 8d 54 24 20       	lea    0x20(%rsp),%rdx
    5f5c:	e8 cf 0f 00 00       	call   6f30 <fwp_decode>
    5f61:	85 c0                	test   %eax,%eax
    5f63:	0f 85 0a ff ff ff    	jne    5e73 <fwp_exec+0x4d3>
    5f69:	e9 2c 01 00 00       	jmp    609a <fwp_exec+0x6fa>
    5f6e:	48 8b 05 63 d0 00 00 	mov    0xd063(%rip),%rax        # 12fd8 <stderr@GLIBC_2.2.5>
    5f75:	48 8b 38             	mov    (%rax),%rdi
    5f78:	48 8d 15 f3 76 00 00 	lea    0x76f3(%rip),%rdx        # d672 <exec_in_fp0+0x32>
    5f7f:	31 c0                	xor    %eax,%eax
    5f81:	e8 6a c3 ff ff       	call   22f0 <fprintf@plt>
    5f86:	41 be 03 00 00 00    	mov    $0x3,%r14d
    5f8c:	bb 0f 00 00 00       	mov    $0xf,%ebx
    5f91:	e9 7a fe ff ff       	jmp    5e10 <fwp_exec+0x470>
    5f96:	41 be 01 00 00 00    	mov    $0x1,%r14d
    5f9c:	31 ff                	xor    %edi,%edi
    5f9e:	e8 ad f3 ff ff       	call   5350 <fwp_mem_free>
    5fa3:	4c 89 ff             	mov    %r15,%rdi
    5fa6:	e8 a5 c0 ff ff       	call   2050 <free@plt>
    5fab:	83 3d 0e ee 01 00 00 	cmpl   $0x0,0x1ee0e(%rip)        # 24dc0 <fwp_exec_binary_out>
    5fb2:	0f 84 fb fa ff ff    	je     5ab3 <fwp_exec+0x113>
    5fb8:	48 8d 3d 4c 76 00 00 	lea    0x764c(%rip),%rdi        # d60b <fwp_exec.end>
    5fbf:	be 05 00 00 00       	mov    $0x5,%esi
    5fc4:	e8 57 08 00 00       	call   6820 <fwp_pipe_write>
    5fc9:	e8 b2 14 00 00       	call   7480 <fwp_pipe_out_end>
    5fce:	e9 e0 fa ff ff       	jmp    5ab3 <fwp_exec+0x113>
    5fd3:	85 c0                	test   %eax,%eax
    5fd5:	79 13                	jns    5fea <fwp_exec+0x64a>
    5fd7:	48 8b 05 fa cf 00 00 	mov    0xcffa(%rip),%rax        # 12fd8 <stderr@GLIBC_2.2.5>
    5fde:	48 8b 38             	mov    (%rax),%rdi
    5fe1:	48 8d 35 6e 81 00 00 	lea    0x816e(%rip),%rsi        # e156 <exec_in_fp0+0xb16>
    5fe8:	eb 11                	jmp    5ffb <fwp_exec+0x65b>
    5fea:	48 8b 05 e7 cf 00 00 	mov    0xcfe7(%rip),%rax        # 12fd8 <stderr@GLIBC_2.2.5>
    5ff1:	48 8b 38             	mov    (%rax),%rdi
    5ff4:	48 8d 35 6b 81 00 00 	lea    0x816b(%rip),%rsi        # e166 <exec_in_fp0+0xb26>
    5ffb:	48 8d 15 70 76 00 00 	lea    0x7670(%rip),%rdx        # d672 <exec_in_fp0+0x32>
    6002:	31 c0                	xor    %eax,%eax
    6004:	e8 e7 c2 ff ff       	call   22f0 <fprintf@plt>
    6009:	41 be 03 00 00 00    	mov    $0x3,%r14d
    600f:	e9 e0 fa ff ff       	jmp    5af4 <fwp_exec+0x154>
    6014:	48 8b 05 bd cf 00 00 	mov    0xcfbd(%rip),%rax        # 12fd8 <stderr@GLIBC_2.2.5>
    601b:	48 8b 38             	mov    (%rax),%rdi
    601e:	8b 4d 00             	mov    0x0(%rbp),%ecx
    6021:	48 8d 35 09 81 00 00 	lea    0x8109(%rip),%rsi        # e131 <exec_in_fp0+0xaf1>
    6028:	48 8d 15 43 76 00 00 	lea    0x7643(%rip),%rdx        # d672 <exec_in_fp0+0x32>
    602f:	4c 8d 0d 48 84 00 00 	lea    0x8448(%rip),%r9        # e47e <exec_in_fp0+0xe3e>
    6036:	4d 89 e8             	mov    %r13,%r8
    6039:	31 c0                	xor    %eax,%eax
    603b:	e8 b0 c2 ff ff       	call   22f0 <fprintf@plt>
    6040:	41 be 03 00 00 00    	mov    $0x3,%r14d
    6046:	e9 51 ff ff ff       	jmp    5f9c <fwp_exec+0x5fc>
    604b:	48 8b 05 86 cf 00 00 	mov    0xcf86(%rip),%rax        # 12fd8 <stderr@GLIBC_2.2.5>
    6052:	48 8b 38             	mov    (%rax),%rdi
    6055:	48 8d 35 3e 80 00 00 	lea    0x803e(%rip),%rsi        # e09a <exec_in_fp0+0xa5a>
    605c:	48 8d 15 0f 76 00 00 	lea    0x760f(%rip),%rdx        # d672 <exec_in_fp0+0x32>
    6063:	31 c0                	xor    %eax,%eax
    6065:	e8 86 c2 ff ff       	call   22f0 <fprintf@plt>
    606a:	eb 9d                	jmp    6009 <fwp_exec+0x669>
    606c:	48 8b 05 65 cf 00 00 	mov    0xcf65(%rip),%rax        # 12fd8 <stderr@GLIBC_2.2.5>
    6073:	48 8b 38             	mov    (%rax),%rdi
    6076:	48 8d 35 42 80 00 00 	lea    0x8042(%rip),%rsi        # e0bf <exec_in_fp0+0xa7f>
    607d:	48 8d 15 ee 75 00 00 	lea    0x75ee(%rip),%rdx        # d672 <exec_in_fp0+0x32>
    6084:	48 8d 0d f3 83 00 00 	lea    0x83f3(%rip),%rcx        # e47e <exec_in_fp0+0xe3e>
    608b:	4d 89 f0             	mov    %r14,%r8
    608e:	31 c0                	xor    %eax,%eax
    6090:	e8 5b c2 ff ff       	call   22f0 <fprintf@plt>
    6095:	e9 6f ff ff ff       	jmp    6009 <fwp_exec+0x669>
    609a:	48 8b 05 37 cf 00 00 	mov    0xcf37(%rip),%rax        # 12fd8 <stderr@GLIBC_2.2.5>
    60a1:	48 8b 38             	mov    (%rax),%rdi
    60a4:	48 8d 35 71 80 00 00 	lea    0x8071(%rip),%rsi        # e11c <exec_in_fp0+0xadc>
    60ab:	48 8d 15 c0 75 00 00 	lea    0x75c0(%rip),%rdx        # d672 <exec_in_fp0+0x32>
    60b2:	31 c0                	xor    %eax,%eax
    60b4:	e8 37 c2 ff ff       	call   22f0 <fprintf@plt>
    60b9:	41 be 03 00 00 00    	mov    $0x3,%r14d
    60bf:	e9 d8 fe ff ff       	jmp    5f9c <fwp_exec+0x5fc>
    60c4:	66 66 66 2e 0f 1f 84 	data16 data16 cs nopw 0x0(%rax,%rax,1)
    60cb:	00 00 00 00 00 

00000000000060d0 <fwp_segv>:
    60d0:	53                   	push   %rbx
    60d1:	48 8b 15 d0 ec 00 00 	mov    0xecd0(%rip),%rdx        # 14da8 <fwp_main_stack_top>
    60d8:	48 85 d2             	test   %rdx,%rdx
    60db:	74 29                	je     6106 <fwp_segv+0x36>
    60dd:	48 8b 46 10          	mov    0x10(%rsi),%rax
    60e1:	48 2b 15 c8 ec 00 00 	sub    0xecc8(%rip),%rdx        # 14db0 <fwp_main_stack_size>
    60e8:	48 8d b2 00 00 f0 ff 	lea    -0x100000(%rdx),%rsi
    60ef:	48 81 c2 00 00 10 00 	add    $0x100000,%rdx
    60f6:	89 fb                	mov    %edi,%ebx
    60f8:	48 89 c7             	mov    %rax,%rdi
    60fb:	e8 40 00 00 00       	call   6140 <fwp_near>
    6100:	89 df                	mov    %ebx,%edi
    6102:	85 c0                	test   %eax,%eax
    6104:	75 08                	jne    610e <fwp_segv+0x3e>
    6106:	31 f6                	xor    %esi,%esi
    6108:	5b                   	pop    %rbx
    6109:	e9 d2 c1 ff ff       	jmp    22e0 <signal@plt>
    610e:	e8 1d cd ff ff       	call   2e30 <fwp_flush>
    6113:	48 8d 35 d6 74 00 00 	lea    0x74d6(%rip),%rsi        # d5f0 <fwp_segv.msg>
    611a:	ba 1a 00 00 00       	mov    $0x1a,%edx
    611f:	bf 02 00 00 00       	mov    $0x2,%edi
    6124:	e8 17 c0 ff ff       	call   2140 <write@plt>
    6129:	bf 65 00 00 00       	mov    $0x65,%edi
    612e:	e8 6d bf ff ff       	call   20a0 <_exit@plt>
    6133:	66 66 66 66 2e 0f 1f 	data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    613a:	84 00 00 00 00 00 

0000000000006140 <fwp_near>:
    6140:	48 39 f7             	cmp    %rsi,%rdi
    6143:	0f 93 c0             	setae  %al
    6146:	48 39 d7             	cmp    %rdx,%rdi
    6149:	0f 92 c1             	setb   %cl
    614c:	20 c1                	and    %al,%cl
    614e:	0f b6 c1             	movzbl %cl,%eax
    6151:	c3                   	ret
    6152:	66 66 66 66 66 2e 0f 	data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    6159:	1f 84 00 00 00 00 00 

0000000000006160 <fwp_generated>:
    6160:	55                   	push   %rbp
    6161:	41 57                	push   %r15
    6163:	41 56                	push   %r14
    6165:	53                   	push   %rbx
    6166:	50                   	push   %rax
    6167:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
    616c:	85 ff                	test   %edi,%edi
    616e:	0f 8e 14 01 00 00    	jle    6288 <fwp_generated+0x128>
    6174:	89 fd                	mov    %edi,%ebp
    6176:	49 89 f7             	mov    %rsi,%r15
    6179:	4c 8b 36             	mov    (%rsi),%r14
    617c:	48 8d 35 f9 7f 00 00 	lea    0x7ff9(%rip),%rsi        # e17c <exec_in_fp0+0xb3c>
    6183:	4c 89 f7             	mov    %r14,%rdi
    6186:	e8 45 c1 ff ff       	call   22d0 <strcmp@plt>
    618b:	85 c0                	test   %eax,%eax
    618d:	74 34                	je     61c3 <fwp_generated+0x63>
    618f:	48 8d 35 ec 7f 00 00 	lea    0x7fec(%rip),%rsi        # e182 <exec_in_fp0+0xb42>
    6196:	ba 0d 00 00 00       	mov    $0xd,%edx
    619b:	4c 89 f7             	mov    %r14,%rdi
    619e:	e8 ed be ff ff       	call   2090 <strncmp@plt>
    61a3:	85 c0                	test   %eax,%eax
    61a5:	0f 85 dd 00 00 00    	jne    6288 <fwp_generated+0x128>
    61ab:	41 0f b6 46 0d       	movzbl 0xd(%r14),%eax
    61b0:	85 c0                	test   %eax,%eax
    61b2:	74 2c                	je     61e0 <fwp_generated+0x80>
    61b4:	83 f8 3d             	cmp    $0x3d,%eax
    61b7:	0f 85 cb 00 00 00    	jne    6288 <fwp_generated+0x128>
    61bd:	49 83 c6 0e          	add    $0xe,%r14
    61c1:	eb 2a                	jmp    61ed <fwp_generated+0x8d>
    61c3:	48 8b 3d ce eb 00 00 	mov    0xebce(%rip),%rdi        # 14d98 <fwp_cli_man>
    61ca:	48 8b 05 df cd 00 00 	mov    0xcddf(%rip),%rax        # 12fb0 <stdout@GLIBC_2.2.5>
    61d1:	48 8b 30             	mov    (%rax),%rsi
    61d4:	e8 17 c0 ff ff       	call   21f0 <fputs@plt>
    61d9:	31 db                	xor    %ebx,%ebx
    61db:	e9 a8 00 00 00       	jmp    6288 <fwp_generated+0x128>
    61e0:	83 fd 01             	cmp    $0x1,%ebp
    61e3:	0f 84 ac 00 00 00    	je     6295 <fwp_generated+0x135>
    61e9:	4d 8b 77 08          	mov    0x8(%r15),%r14
    61ed:	48 8d 35 da 7f 00 00 	lea    0x7fda(%rip),%rsi        # e1ce <exec_in_fp0+0xb8e>
    61f4:	4c 89 f7             	mov    %r14,%rdi
    61f7:	e8 d4 c0 ff ff       	call   22d0 <strcmp@plt>
    61fc:	31 db                	xor    %ebx,%ebx
    61fe:	85 c0                	test   %eax,%eax
    6200:	74 63                	je     6265 <fwp_generated+0x105>
    6202:	48 8d 35 ca 7f 00 00 	lea    0x7fca(%rip),%rsi        # e1d3 <exec_in_fp0+0xb93>
    6209:	4c 89 f7             	mov    %r14,%rdi
    620c:	e8 bf c0 ff ff       	call   22d0 <strcmp@plt>
    6211:	85 c0                	test   %eax,%eax
    6213:	74 54                	je     6269 <fwp_generated+0x109>
    6215:	48 8d 35 bb 7f 00 00 	lea    0x7fbb(%rip),%rsi        # e1d7 <exec_in_fp0+0xb97>
    621c:	4c 89 f7             	mov    %r14,%rdi
    621f:	e8 ac c0 ff ff       	call   22d0 <strcmp@plt>
    6224:	b9 02 00 00 00       	mov    $0x2,%ecx
    6229:	85 c0                	test   %eax,%eax
    622b:	74 41                	je     626e <fwp_generated+0x10e>
    622d:	4c 89 f7             	mov    %r14,%rdi
    6230:	e8 3b bf ff ff       	call   2170 <strlen@plt>
    6235:	4c 89 f7             	mov    %r14,%rdi
    6238:	48 89 c6             	mov    %rax,%rsi
    623b:	e8 80 00 00 00       	call   62c0 <fwp_str_lossy>
    6240:	48 8b 0d 91 cd 00 00 	mov    0xcd91(%rip),%rcx        # 12fd8 <stderr@GLIBC_2.2.5>
    6247:	48 8b 39             	mov    (%rcx),%rdi
    624a:	48 8d 48 08          	lea    0x8(%rax),%rcx
    624e:	48 8d 35 87 7f 00 00 	lea    0x7f87(%rip),%rsi        # e1dc <exec_in_fp0+0xb9c>
    6255:	48 8d 15 16 74 00 00 	lea    0x7416(%rip),%rdx        # d672 <exec_in_fp0+0x32>
    625c:	31 c0                	xor    %eax,%eax
    625e:	e8 8d c0 ff ff       	call   22f0 <fprintf@plt>
    6263:	eb 4f                	jmp    62b4 <fwp_generated+0x154>
    6265:	31 c9                	xor    %ecx,%ecx
    6267:	eb 05                	jmp    626e <fwp_generated+0x10e>
    6269:	b9 01 00 00 00       	mov    $0x1,%ecx
    626e:	48 8d 05 0b eb 00 00 	lea    0xeb0b(%rip),%rax        # 14d80 <fwp_cli_scripts>
    6275:	48 8b 3c c8          	mov    (%rax,%rcx,8),%rdi
    6279:	48 8b 05 30 cd 00 00 	mov    0xcd30(%rip),%rax        # 12fb0 <stdout@GLIBC_2.2.5>
    6280:	48 8b 30             	mov    (%rax),%rsi
    6283:	e8 68 bf ff ff       	call   21f0 <fputs@plt>
    6288:	89 d8                	mov    %ebx,%eax
    628a:	48 83 c4 08          	add    $0x8,%rsp
    628e:	5b                   	pop    %rbx
    628f:	41 5e                	pop    %r14
    6291:	41 5f                	pop    %r15
    6293:	5d                   	pop    %rbp
    6294:	c3                   	ret
    6295:	48 8b 05 3c cd 00 00 	mov    0xcd3c(%rip),%rax        # 12fd8 <stderr@GLIBC_2.2.5>
    629c:	48 8b 38             	mov    (%rax),%rdi
    629f:	48 8d 35 ea 7e 00 00 	lea    0x7eea(%rip),%rsi        # e190 <exec_in_fp0+0xb50>
    62a6:	48 8d 15 c5 73 00 00 	lea    0x73c5(%rip),%rdx        # d672 <exec_in_fp0+0x32>
    62ad:	31 c0                	xor    %eax,%eax
    62af:	e8 3c c0 ff ff       	call   22f0 <fprintf@plt>
    62b4:	bb 02 00 00 00       	mov    $0x2,%ebx
    62b9:	eb cd                	jmp    6288 <fwp_generated+0x128>
    62bb:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)

00000000000062c0 <fwp_str_lossy>:
    62c0:	55                   	push   %rbp
    62c1:	41 57                	push   %r15
    62c3:	41 56                	push   %r14
    62c5:	41 55                	push   %r13
    62c7:	41 54                	push   %r12
    62c9:	53                   	push   %rbx
    62ca:	48 83 ec 18          	sub    $0x18,%rsp
    62ce:	48 89 f3             	mov    %rsi,%rbx
    62d1:	49 89 fe             	mov    %rdi,%r14
    62d4:	e8 27 12 00 00       	call   7500 <fwp_valid_utf8>
    62d9:	85 c0                	test   %eax,%eax
    62db:	74 19                	je     62f6 <fwp_str_lossy+0x36>
    62dd:	4c 89 f7             	mov    %r14,%rdi
    62e0:	48 89 de             	mov    %rbx,%rsi
    62e3:	48 83 c4 18          	add    $0x18,%rsp
    62e7:	5b                   	pop    %rbx
    62e8:	41 5c                	pop    %r12
    62ea:	41 5d                	pop    %r13
    62ec:	41 5e                	pop    %r14
    62ee:	41 5f                	pop    %r15
    62f0:	5d                   	pop    %rbp
    62f1:	e9 6a 13 00 00       	jmp    7660 <fwp_str_new>
    62f6:	0f 57 c0             	xorps  %xmm0,%xmm0
    62f9:	0f 29 04 24          	movaps %xmm0,(%rsp)
    62fd:	48 c7 44 24 10 00 00 	movq   $0x0,0x10(%rsp)
    6304:	00 00 
    6306:	48 85 db             	test   %rbx,%rbx
    6309:	0f 84 72 01 00 00    	je     6481 <fwp_str_lossy+0x1c1>
    630f:	45 31 ed             	xor    %r13d,%r13d
    6312:	49 89 e7             	mov    %rsp,%r15
    6315:	4c 8d 25 ec 7e 00 00 	lea    0x7eec(%rip),%r12        # e208 <exec_in_fp0+0xbc8>
    631c:	eb 19                	jmp    6337 <fwp_str_lossy+0x77>
    631e:	66 90                	xchg   %ax,%ax
    6320:	4c 89 ff             	mov    %r15,%rdi
    6323:	4c 89 e6             	mov    %r12,%rsi
    6326:	e8 95 13 00 00       	call   76c0 <buf_puts>
    632b:	49 89 ed             	mov    %rbp,%r13
    632e:	48 39 dd             	cmp    %rbx,%rbp
    6331:	0f 83 4a 01 00 00    	jae    6481 <fwp_str_lossy+0x1c1>
    6337:	43 0f b6 04 2e       	movzbl (%r14,%r13,1),%eax
    633c:	84 c0                	test   %al,%al
    633e:	78 20                	js     6360 <fwp_str_lossy+0xa0>
    6340:	0f be f0             	movsbl %al,%esi
    6343:	4c 89 ff             	mov    %r15,%rdi
    6346:	e8 55 13 00 00       	call   76a0 <buf_putc>
    634b:	49 ff c5             	inc    %r13
    634e:	4c 89 ed             	mov    %r13,%rbp
    6351:	eb d8                	jmp    632b <fwp_str_lossy+0x6b>
    6353:	66 66 66 66 2e 0f 1f 	data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    635a:	84 00 00 00 00 00 
    6360:	8d 48 20             	lea    0x20(%rax),%ecx
    6363:	80 f9 e1             	cmp    $0xe1,%cl
    6366:	77 34                	ja     639c <fwp_str_lossy+0xdc>
    6368:	89 c2                	mov    %eax,%edx
    636a:	80 e2 f0             	and    $0xf0,%dl
    636d:	80 fa e0             	cmp    $0xe0,%dl
    6370:	0f 85 cb 00 00 00    	jne    6441 <fwp_str_lossy+0x181>
    6376:	3c e0                	cmp    $0xe0,%al
    6378:	40 0f 94 c6          	sete   %sil
    637c:	40 c0 e6 05          	shl    $0x5,%sil
    6380:	40 80 ce 80          	or     $0x80,%sil
    6384:	31 ff                	xor    %edi,%edi
    6386:	3c ed                	cmp    $0xed,%al
    6388:	40 0f 95 c7          	setne  %dil
    638c:	c1 e7 05             	shl    $0x5,%edi
    638f:	81 cf 9f 00 00 00    	or     $0x9f,%edi
    6395:	b8 02 00 00 00       	mov    $0x2,%eax
    639a:	eb 0d                	jmp    63a9 <fwp_str_lossy+0xe9>
    639c:	bf bf 00 00 00       	mov    $0xbf,%edi
    63a1:	40 b6 80             	mov    $0x80,%sil
    63a4:	b8 01 00 00 00       	mov    $0x1,%eax
    63a9:	31 d2                	xor    %edx,%edx
    63ab:	49 8d 6d 01          	lea    0x1(%r13),%rbp
    63af:	48 39 dd             	cmp    %rbx,%rbp
    63b2:	0f 83 68 ff ff ff    	jae    6320 <fwp_str_lossy+0x60>
    63b8:	45 0f b6 04 2e       	movzbl (%r14,%rbp,1),%r8d
    63bd:	41 38 f0             	cmp    %sil,%r8b
    63c0:	0f 82 5a ff ff ff    	jb     6320 <fwp_str_lossy+0x60>
    63c6:	44 39 c7             	cmp    %r8d,%edi
    63c9:	0f 82 51 ff ff ff    	jb     6320 <fwp_str_lossy+0x60>
    63cf:	49 8d 6d 02          	lea    0x2(%r13),%rbp
    63d3:	be 01 00 00 00       	mov    $0x1,%esi
    63d8:	80 f9 e1             	cmp    $0xe1,%cl
    63db:	77 45                	ja     6422 <fwp_str_lossy+0x162>
    63dd:	48 39 dd             	cmp    %rbx,%rbp
    63e0:	73 40                	jae    6422 <fwp_str_lossy+0x162>
    63e2:	41 0f b6 0c 2e       	movzbl (%r14,%rbp,1),%ecx
    63e7:	80 e1 c0             	and    $0xc0,%cl
    63ea:	80 f9 80             	cmp    $0x80,%cl
    63ed:	75 33                	jne    6422 <fwp_str_lossy+0x162>
    63ef:	49 8d 6d 03          	lea    0x3(%r13),%rbp
    63f3:	48 39 dd             	cmp    %rbx,%rbp
    63f6:	0f 93 c1             	setae  %cl
    63f9:	80 f2 01             	xor    $0x1,%dl
    63fc:	be 02 00 00 00       	mov    $0x2,%esi
    6401:	08 ca                	or     %cl,%dl
    6403:	75 1d                	jne    6422 <fwp_str_lossy+0x162>
    6405:	43 0f b6 4c 2e 03    	movzbl 0x3(%r14,%r13,1),%ecx
    640b:	80 e1 c0             	and    $0xc0,%cl
    640e:	31 f6                	xor    %esi,%esi
    6410:	80 f9 80             	cmp    $0x80,%cl
    6413:	0f 94 c1             	sete   %cl
    6416:	75 04                	jne    641c <fwp_str_lossy+0x15c>
    6418:	49 8d 6d 04          	lea    0x4(%r13),%rbp
    641c:	40 88 ce             	mov    %cl,%sil
    641f:	83 ce 02             	or     $0x2,%esi
    6422:	39 c6                	cmp    %eax,%esi
    6424:	0f 85 f6 fe ff ff    	jne    6320 <fwp_str_lossy+0x60>
    642a:	4b 8d 34 2e          	lea    (%r14,%r13,1),%rsi
    642e:	48 89 ea             	mov    %rbp,%rdx
    6431:	4c 29 ea             	sub    %r13,%rdx
    6434:	4c 89 ff             	mov    %r15,%rdi
    6437:	e8 b4 12 00 00       	call   76f0 <buf_put>
    643c:	e9 ea fe ff ff       	jmp    632b <fwp_str_lossy+0x6b>
    6441:	8d 50 10             	lea    0x10(%rax),%edx
    6444:	80 fa 04             	cmp    $0x4,%dl
    6447:	77 28                	ja     6471 <fwp_str_lossy+0x1b1>
    6449:	3c f0                	cmp    $0xf0,%al
    644b:	40 0f 94 c6          	sete   %sil
    644f:	bf 8f 00 00 00       	mov    $0x8f,%edi
    6454:	3c f4                	cmp    $0xf4,%al
    6456:	74 05                	je     645d <fwp_str_lossy+0x19d>
    6458:	bf bf 00 00 00       	mov    $0xbf,%edi
    645d:	40 c0 e6 04          	shl    $0x4,%sil
    6461:	40 80 ce 80          	or     $0x80,%sil
    6465:	b8 03 00 00 00       	mov    $0x3,%eax
    646a:	b2 01                	mov    $0x1,%dl
    646c:	e9 3a ff ff ff       	jmp    63ab <fwp_str_lossy+0xeb>
    6471:	4c 89 ff             	mov    %r15,%rdi
    6474:	4c 89 e6             	mov    %r12,%rsi
    6477:	e8 44 12 00 00       	call   76c0 <buf_puts>
    647c:	e9 ca fe ff ff       	jmp    634b <fwp_str_lossy+0x8b>
    6481:	48 89 e7             	mov    %rsp,%rdi
    6484:	e8 a7 12 00 00       	call   7730 <buf_to_str>
    6489:	48 83 c4 18          	add    $0x18,%rsp
    648d:	5b                   	pop    %rbx
    648e:	41 5c                	pop    %r12
    6490:	41 5d                	pop    %r13
    6492:	41 5e                	pop    %r14
    6494:	41 5f                	pop    %r15
    6496:	5d                   	pop    %rbp
    6497:	c3                   	ret
    6498:	0f 1f 84 00 00 00 00 	nopl   0x0(%rax,%rax,1)
    649f:	00 

00000000000064a0 <fwp_alloc_leaf>:
    64a0:	be 01 00 00 00       	mov    $0x1,%esi
    64a5:	e9 66 d0 ff ff       	jmp    3510 <fwp_gc_alloc>
    64aa:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)

00000000000064b0 <fwp_cli_parse>:
    64b0:	c7 01 00 00 00 00    	movl   $0x0,(%rcx)
    64b6:	85 ff                	test   %edi,%edi
    64b8:	0f 8e 6d 01 00 00    	jle    662b <fwp_cli_parse+0x17b>
    64be:	55                   	push   %rbp
    64bf:	41 57                	push   %r15
    64c1:	41 56                	push   %r14
    64c3:	41 55                	push   %r13
    64c5:	41 54                	push   %r12
    64c7:	53                   	push   %rbx
    64c8:	48 83 ec 28          	sub    $0x28,%rsp
    64cc:	41 89 f8             	mov    %edi,%r8d
    64cf:	4d 89 c1             	mov    %r8,%r9
    64d2:	49 f7 d9             	neg    %r9
    64d5:	40 b5 01             	mov    $0x1,%bpl
    64d8:	45 31 ff             	xor    %r15d,%r15d
    64db:	41 be 01 00 00 00    	mov    $0x1,%r14d
    64e1:	31 db                	xor    %ebx,%ebx
    64e3:	48 89 54 24 20       	mov    %rdx,0x20(%rsp)
    64e8:	48 89 74 24 18       	mov    %rsi,0x18(%rsp)
    64ed:	4c 89 44 24 10       	mov    %r8,0x10(%rsp)
    64f2:	4c 89 4c 24 08       	mov    %r9,0x8(%rsp)
    64f7:	48 89 0c 24          	mov    %rcx,(%rsp)
    64fb:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)
    6500:	4e 8b 6c f6 f8       	mov    -0x8(%rsi,%r14,8),%r13
    6505:	85 db                	test   %ebx,%ebx
    6507:	75 37                	jne    6540 <fwp_cli_parse+0x90>
    6509:	4d 8b 65 00          	mov    0x0(%r13),%r12
    650d:	49 83 fc 02          	cmp    $0x2,%r12
    6511:	72 2d                	jb     6540 <fwp_cli_parse+0x90>
    6513:	49 8d 7d 08          	lea    0x8(%r13),%rdi
    6517:	80 3f 2d             	cmpb   $0x2d,(%rdi)
    651a:	75 24                	jne    6540 <fwp_cli_parse+0x90>
    651c:	e8 ff 12 00 00       	call   7820 <fwp_is_number_arg>
    6521:	4c 8b 4c 24 08       	mov    0x8(%rsp),%r9
    6526:	4c 8b 44 24 10       	mov    0x10(%rsp),%r8
    652b:	48 8b 74 24 18       	mov    0x18(%rsp),%rsi
    6530:	48 8b 54 24 20       	mov    0x20(%rsp),%rdx
    6535:	48 8b 0c 24          	mov    (%rsp),%rcx
    6539:	85 c0                	test   %eax,%eax
    653b:	74 2f                	je     656c <fwp_cli_parse+0xbc>
    653d:	0f 1f 00             	nopl   (%rax)
    6540:	49 63 c7             	movslq %r15d,%rax
    6543:	41 8d 7f 01          	lea    0x1(%r15),%edi
    6547:	89 39                	mov    %edi,(%rcx)
    6549:	4c 89 2c c2          	mov    %r13,(%rdx,%rax,8)
    654d:	41 89 ff             	mov    %edi,%r15d
    6550:	4d 39 c6             	cmp    %r8,%r14
    6553:	40 0f 92 c5          	setb   %bpl
    6557:	4b 8d 04 31          	lea    (%r9,%r14,1),%rax
    655b:	48 ff c0             	inc    %rax
    655e:	49 ff c6             	inc    %r14
    6561:	48 83 f8 01          	cmp    $0x1,%rax
    6565:	75 99                	jne    6500 <fwp_cli_parse+0x50>
    6567:	e9 a9 00 00 00       	jmp    6615 <fwp_cli_parse+0x165>
    656c:	41 0f b6 45 09       	movzbl 0x9(%r13),%eax
    6571:	49 83 fc 02          	cmp    $0x2,%r12
    6575:	75 1a                	jne    6591 <fwp_cli_parse+0xe1>
    6577:	bb 01 00 00 00       	mov    $0x1,%ebx
    657c:	3c 2d                	cmp    $0x2d,%al
    657e:	74 d0                	je     6550 <fwp_cli_parse+0xa0>
    6580:	31 db                	xor    %ebx,%ebx
    6582:	49 83 fc 02          	cmp    $0x2,%r12
    6586:	75 b8                	jne    6540 <fwp_cli_parse+0x90>
    6588:	3c 68                	cmp    $0x68,%al
    658a:	75 b4                	jne    6540 <fwp_cli_parse+0x90>
    658c:	e9 84 00 00 00       	jmp    6615 <fwp_cli_parse+0x165>
    6591:	31 db                	xor    %ebx,%ebx
    6593:	3c 2d                	cmp    $0x2d,%al
    6595:	75 a9                	jne    6540 <fwp_cli_parse+0x90>
    6597:	49 8d 5d 0a          	lea    0xa(%r13),%rbx
    659b:	49 83 c4 fe          	add    $0xfffffffffffffffe,%r12
    659f:	48 89 df             	mov    %rbx,%rdi
    65a2:	be 3d 00 00 00       	mov    $0x3d,%esi
    65a7:	4c 89 e2             	mov    %r12,%rdx
    65aa:	e8 b1 bc ff ff       	call   2260 <memchr@plt>
    65af:	48 89 c1             	mov    %rax,%rcx
    65b2:	48 29 d9             	sub    %rbx,%rcx
    65b5:	48 85 c0             	test   %rax,%rax
    65b8:	49 0f 44 cc          	cmove  %r12,%rcx
    65bc:	75 38                	jne    65f6 <fwp_cli_parse+0x146>
    65be:	48 83 f9 04          	cmp    $0x4,%rcx
    65c2:	48 8b 0c 24          	mov    (%rsp),%rcx
    65c6:	48 8b 54 24 20       	mov    0x20(%rsp),%rdx
    65cb:	48 8b 74 24 18       	mov    0x18(%rsp),%rsi
    65d0:	4c 8b 44 24 10       	mov    0x10(%rsp),%r8
    65d5:	4c 8b 4c 24 08       	mov    0x8(%rsp),%r9
    65da:	75 13                	jne    65ef <fwp_cli_parse+0x13f>
    65dc:	81 3b 68 65 6c 70    	cmpl   $0x706c6568,(%rbx)
    65e2:	bb 00 00 00 00       	mov    $0x0,%ebx
    65e7:	0f 85 53 ff ff ff    	jne    6540 <fwp_cli_parse+0x90>
    65ed:	eb 26                	jmp    6615 <fwp_cli_parse+0x165>
    65ef:	31 db                	xor    %ebx,%ebx
    65f1:	e9 4a ff ff ff       	jmp    6540 <fwp_cli_parse+0x90>
    65f6:	48 8b 0c 24          	mov    (%rsp),%rcx
    65fa:	48 8b 54 24 20       	mov    0x20(%rsp),%rdx
    65ff:	48 8b 74 24 18       	mov    0x18(%rsp),%rsi
    6604:	4c 8b 44 24 10       	mov    0x10(%rsp),%r8
    6609:	4c 8b 4c 24 08       	mov    0x8(%rsp),%r9
    660e:	31 db                	xor    %ebx,%ebx
    6610:	e9 2b ff ff ff       	jmp    6540 <fwp_cli_parse+0x90>
    6615:	40 0f b6 c5          	movzbl %bpl,%eax
    6619:	83 e0 01             	and    $0x1,%eax
    661c:	48 83 c4 28          	add    $0x28,%rsp
    6620:	5b                   	pop    %rbx
    6621:	41 5c                	pop    %r12
    6623:	41 5d                	pop    %r13
    6625:	41 5e                	pop    %r14
    6627:	41 5f                	pop    %r15
    6629:	5d                   	pop    %rbp
    662a:	c3                   	ret
    662b:	31 c0                	xor    %eax,%eax
    662d:	c3                   	ret
    662e:	66 90                	xchg   %ax,%ax

0000000000006630 <fwp_usage_error>:
    6630:	48 8b 05 a1 c9 00 00 	mov    0xc9a1(%rip),%rax        # 12fd8 <stderr@GLIBC_2.2.5>
    6637:	48 8b 38             	mov    (%rax),%rdi
    663a:	48 8d 35 64 7c 00 00 	lea    0x7c64(%rip),%rsi        # e2a5 <exec_in_fp0+0xc65>
    6641:	48 8d 15 70 7d 00 00 	lea    0x7d70(%rip),%rdx        # e3b8 <exec_in_fp0+0xd78>
    6648:	31 c0                	xor    %eax,%eax
    664a:	e9 a1 bc ff ff       	jmp    22f0 <fprintf@plt>
    664f:	90                   	nop

0000000000006650 <fwp_parse_text>:
    6650:	48 83 ec 18          	sub    $0x18,%rsp
    6654:	48 89 d1             	mov    %rdx,%rcx
    6657:	48 89 3c 24          	mov    %rdi,(%rsp)
    665b:	48 89 74 24 08       	mov    %rsi,0x8(%rsp)
    6660:	48 c7 44 24 10 00 00 	movq   $0x0,0x10(%rsp)
    6667:	00 00 
    6669:	48 8d 35 60 e6 00 00 	lea    0xe660(%rip),%rsi        # 14cd0 <d0>
    6670:	48 89 e7             	mov    %rsp,%rdi
    6673:	ba 01 00 00 00       	mov    $0x1,%edx
    6678:	e8 a3 16 00 00       	call   7d20 <tp_value>
    667d:	85 c0                	test   %eax,%eax
    667f:	74 1c                	je     669d <fwp_parse_text+0x4d>
    6681:	48 89 e7             	mov    %rsp,%rdi
    6684:	e8 c7 1f 00 00       	call   8650 <tp_ws>
    6689:	48 8b 4c 24 10       	mov    0x10(%rsp),%rcx
    668e:	31 c0                	xor    %eax,%eax
    6690:	48 3b 4c 24 08       	cmp    0x8(%rsp),%rcx
    6695:	0f 94 c0             	sete   %al
    6698:	48 83 c4 18          	add    $0x18,%rsp
    669c:	c3                   	ret
    669d:	31 c0                	xor    %eax,%eax
    669f:	48 83 c4 18          	add    $0x18,%rsp
    66a3:	c3                   	ret
    66a4:	66 66 66 2e 0f 1f 84 	data16 data16 cs nopw 0x0(%rax,%rax,1)
    66ab:	00 00 00 00 00 

00000000000066b0 <fwp_parse_arg>:
    66b0:	53                   	push   %rbx
    66b1:	48 83 ec 10          	sub    $0x10,%rsp
    66b5:	89 fb                	mov    %edi,%ebx
    66b7:	48 8b 06             	mov    (%rsi),%rax
    66ba:	48 8d 7e 08          	lea    0x8(%rsi),%rdi
    66be:	48 8d 4c 24 08       	lea    0x8(%rsp),%rcx
    66c3:	48 89 c6             	mov    %rax,%rsi
    66c6:	e8 85 12 00 00       	call   7950 <fwp_cli_value>
    66cb:	89 c1                	mov    %eax,%ecx
    66cd:	b8 01 00 00 00       	mov    $0x1,%eax
    66d2:	85 c9                	test   %ecx,%ecx
    66d4:	74 06                	je     66dc <fwp_parse_arg+0x2c>
    66d6:	48 83 c4 10          	add    $0x10,%rsp
    66da:	5b                   	pop    %rbx
    66db:	c3                   	ret
    66dc:	48 8b 05 f5 c8 00 00 	mov    0xc8f5(%rip),%rax        # 12fd8 <stderr@GLIBC_2.2.5>
    66e3:	48 8b 38             	mov    (%rax),%rdi
    66e6:	ff c3                	inc    %ebx
    66e8:	4c 8b 44 24 08       	mov    0x8(%rsp),%r8
    66ed:	49 83 c0 08          	add    $0x8,%r8
    66f1:	48 8d 35 9c 7b 00 00 	lea    0x7b9c(%rip),%rsi        # e294 <exec_in_fp0+0xc54>
    66f8:	48 8d 15 73 6f 00 00 	lea    0x6f73(%rip),%rdx        # d672 <exec_in_fp0+0x32>
    66ff:	89 d9                	mov    %ebx,%ecx
    6701:	31 c0                	xor    %eax,%eax
    6703:	e8 e8 bb ff ff       	call   22f0 <fprintf@plt>
    6708:	31 c0                	xor    %eax,%eax
    670a:	eb ca                	jmp    66d6 <fwp_parse_arg+0x26>
    670c:	0f 1f 40 00          	nopl   0x0(%rax)

0000000000006710 <fwp_bind_positional>:
    6710:	50                   	push   %rax
    6711:	31 c0                	xor    %eax,%eax
    6713:	85 f6                	test   %esi,%esi
    6715:	0f 9e c0             	setle  %al
    6718:	89 01                	mov    %eax,(%rcx)
    671a:	83 fe 01             	cmp    $0x1,%esi
    671d:	76 0c                	jbe    672b <fwp_bind_positional+0x1b>
    671f:	e8 0c ff ff ff       	call   6630 <fwp_usage_error>
    6724:	b8 02 00 00 00       	mov    $0x2,%eax
    6729:	59                   	pop    %rcx
    672a:	c3                   	ret
    672b:	31 c0                	xor    %eax,%eax
    672d:	83 fe 01             	cmp    $0x1,%esi
    6730:	75 f7                	jne    6729 <fwp_bind_positional+0x19>
    6732:	48 8b 37             	mov    (%rdi),%rsi
    6735:	31 ff                	xor    %edi,%edi
    6737:	e8 74 ff ff ff       	call   66b0 <fwp_parse_arg>
    673c:	89 c1                	mov    %eax,%ecx
    673e:	31 c0                	xor    %eax,%eax
    6740:	85 c9                	test   %ecx,%ecx
    6742:	0f 94 c0             	sete   %al
    6745:	01 c0                	add    %eax,%eax
    6747:	59                   	pop    %rcx
    6748:	c3                   	ret
    6749:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)

0000000000006750 <fwp_pipe_out_start>:
    6750:	41 56                	push   %r14
    6752:	53                   	push   %rbx
    6753:	48 81 ec 08 01 00 00 	sub    $0x108,%rsp
    675a:	48 8d 74 24 08       	lea    0x8(%rsp),%rsi
    675f:	bf 01 00 00 00       	mov    $0x1,%edi
    6764:	e8 77 bd ff ff       	call   24e0 <fstat@plt>
    6769:	85 c0                	test   %eax,%eax
    676b:	0f 85 82 00 00 00    	jne    67f3 <fwp_pipe_out_start+0xa3>
    6771:	b8 00 f0 00 00       	mov    $0xf000,%eax
    6776:	23 44 24 20          	and    0x20(%rsp),%eax
    677a:	3d 00 10 00 00       	cmp    $0x1000,%eax
    677f:	75 72                	jne    67f3 <fwp_pipe_out_start+0xa3>
    6781:	bf 01 00 00 00       	mov    $0x1,%edi
    6786:	be 07 04 00 00       	mov    $0x407,%esi
    678b:	ba 00 00 10 00       	mov    $0x100000,%edx
    6790:	31 c0                	xor    %eax,%eax
    6792:	e8 89 b9 ff ff       	call   2120 <fcntl@plt>
    6797:	e8 34 36 00 00       	call   9dd0 <fwp_transport_off>
    679c:	85 c0                	test   %eax,%eax
    679e:	75 53                	jne    67f3 <fwp_pipe_out_start+0xa3>
    67a0:	bf 01 00 00 00       	mov    $0x1,%edi
    67a5:	be 01 08 08 00       	mov    $0x80801,%esi
    67aa:	31 d2                	xor    %edx,%edx
    67ac:	e8 5f bd ff ff       	call   2510 <socket@plt>
    67b1:	85 c0                	test   %eax,%eax
    67b3:	78 3e                	js     67f3 <fwp_pipe_out_start+0xa3>
    67b5:	89 c3                	mov    %eax,%ebx
    67b7:	4c 8d b4 24 9a 00 00 	lea    0x9a(%rsp),%r14
    67be:	00 
    67bf:	48 8d 74 24 08       	lea    0x8(%rsp),%rsi
    67c4:	4c 89 f7             	mov    %r14,%rdi
    67c7:	e8 34 36 00 00       	call   9e00 <fwp_pipe_addr>
    67cc:	89 df                	mov    %ebx,%edi
    67ce:	4c 89 f6             	mov    %r14,%rsi
    67d1:	89 c2                	mov    %eax,%edx
    67d3:	e8 f8 bb ff ff       	call   23d0 <bind@plt>
    67d8:	85 c0                	test   %eax,%eax
    67da:	75 10                	jne    67ec <fwp_pipe_out_start+0x9c>
    67dc:	89 df                	mov    %ebx,%edi
    67de:	be 01 00 00 00       	mov    $0x1,%esi
    67e3:	e8 78 bb ff ff       	call   2360 <listen@plt>
    67e8:	85 c0                	test   %eax,%eax
    67ea:	74 12                	je     67fe <fwp_pipe_out_start+0xae>
    67ec:	89 df                	mov    %ebx,%edi
    67ee:	e8 3d ba ff ff       	call   2230 <close@plt>
    67f3:	48 81 c4 08 01 00 00 	add    $0x108,%rsp
    67fa:	5b                   	pop    %rbx
    67fb:	41 5e                	pop    %r14
    67fd:	c3                   	ret
    67fe:	89 1d b8 e4 00 00    	mov    %ebx,0xe4b8(%rip)        # 14cbc <fwp_po_listen>
    6804:	e8 47 36 00 00       	call   9e50 <fwp_now_ns>
    6809:	48 b9 00 f2 05 2a 01 	movabs $0x12a05f200,%rcx
    6810:	00 00 00 
    6813:	48 01 c1             	add    %rax,%rcx
    6816:	48 89 0d bb e5 01 00 	mov    %rcx,0x1e5bb(%rip)        # 24dd8 <fwp_po_give_up>
    681d:	eb d4                	jmp    67f3 <fwp_pipe_out_start+0xa3>
    681f:	90                   	nop

0000000000006820 <fwp_pipe_write>:
    6820:	41 57                	push   %r15
    6822:	41 56                	push   %r14
    6824:	53                   	push   %rbx
    6825:	48 89 f3             	mov    %rsi,%rbx
    6828:	8b 05 b2 e5 01 00    	mov    0x1e5b2(%rip),%eax        # 24de0 <fwp_po_kind>
    682e:	83 f8 01             	cmp    $0x1,%eax
    6831:	74 12                	je     6845 <fwp_pipe_write+0x25>
    6833:	83 f8 02             	cmp    $0x2,%eax
    6836:	75 46                	jne    687e <fwp_pipe_write+0x5e>
    6838:	48 89 de             	mov    %rbx,%rsi
    683b:	5b                   	pop    %rbx
    683c:	41 5e                	pop    %r14
    683e:	41 5f                	pop    %r15
    6840:	e9 3b 36 00 00       	jmp    9e80 <fwp_ring_put>
    6845:	49 89 fe             	mov    %rdi,%r14
    6848:	48 8b 05 99 e5 01 00 	mov    0x1e599(%rip),%rax        # 24de8 <fwp_po_len>
    684f:	48 01 d8             	add    %rbx,%rax
    6852:	48 3d 01 00 01 00    	cmp    $0x10001,%rax
    6858:	72 05                	jb     685f <fwp_pipe_write+0x3f>
    685a:	e8 81 37 00 00       	call   9fe0 <fwp_po_flush_sock>
    685f:	48 81 fb 01 00 01 00 	cmp    $0x10001,%rbx
    6866:	72 32                	jb     689a <fwp_pipe_write+0x7a>
    6868:	8b 3d 52 e4 00 00    	mov    0xe452(%rip),%edi        # 14cc0 <fwp_po_sock>
    686e:	4c 89 f6             	mov    %r14,%rsi
    6871:	48 89 da             	mov    %rbx,%rdx
    6874:	5b                   	pop    %rbx
    6875:	41 5e                	pop    %r14
    6877:	41 5f                	pop    %r15
    6879:	e9 92 37 00 00       	jmp    a010 <fwp_po_write_raw>
    687e:	48 8b 05 2b c7 00 00 	mov    0xc72b(%rip),%rax        # 12fb0 <stdout@GLIBC_2.2.5>
    6885:	48 8b 08             	mov    (%rax),%rcx
    6888:	be 01 00 00 00       	mov    $0x1,%esi
    688d:	48 89 da             	mov    %rbx,%rdx
    6890:	5b                   	pop    %rbx
    6891:	41 5e                	pop    %r14
    6893:	41 5f                	pop    %r15
    6895:	e9 06 bc ff ff       	jmp    24a0 <fwrite@plt>
    689a:	4c 8b 3d 47 e5 01 00 	mov    0x1e547(%rip),%r15        # 24de8 <fwp_po_len>
    68a1:	48 8d 3d 48 e5 01 00 	lea    0x1e548(%rip),%rdi        # 24df0 <fwp_po_buf>
    68a8:	4c 01 ff             	add    %r15,%rdi
    68ab:	4c 89 f6             	mov    %r14,%rsi
    68ae:	48 89 da             	mov    %rbx,%rdx
    68b1:	e8 7a ba ff ff       	call   2330 <memcpy@plt>
    68b6:	49 01 df             	add    %rbx,%r15
    68b9:	4c 89 3d 28 e5 01 00 	mov    %r15,0x1e528(%rip)        # 24de8 <fwp_po_len>
    68c0:	5b                   	pop    %rbx
    68c1:	41 5e                	pop    %r14
    68c3:	41 5f                	pop    %r15
    68c5:	c3                   	ret
    68c6:	66 2e 0f 1f 84 00 00 	cs nopw 0x0(%rax,%rax,1)
    68cd:	00 00 00 

00000000000068d0 <fwp_pipe_flush>:
    68d0:	8b 05 0a e5 01 00    	mov    0x1e50a(%rip),%eax        # 24de0 <fwp_po_kind>
    68d6:	85 c0                	test   %eax,%eax
    68d8:	74 0a                	je     68e4 <fwp_pipe_flush+0x14>
    68da:	83 f8 01             	cmp    $0x1,%eax
    68dd:	75 1b                	jne    68fa <fwp_pipe_flush+0x2a>
    68df:	e9 fc 36 00 00       	jmp    9fe0 <fwp_po_flush_sock>
    68e4:	50                   	push   %rax
    68e5:	48 8b 05 c4 c6 00 00 	mov    0xc6c4(%rip),%rax        # 12fb0 <stdout@GLIBC_2.2.5>
    68ec:	48 8b 38             	mov    (%rax),%rdi
    68ef:	e8 5c ba ff ff       	call   2350 <fflush@plt>
    68f4:	58                   	pop    %rax
    68f5:	e9 f6 39 00 00       	jmp    a2f0 <fwp_pipe_poll>
    68fa:	c3                   	ret
    68fb:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)

0000000000006900 <fwp_pipe_out_ready>:
    6900:	48 83 ec 18          	sub    $0x18,%rsp
    6904:	48 8d 3d d8 79 00 00 	lea    0x79d8(%rip),%rdi        # e2e3 <exec_in_fp0+0xca3>
    690b:	e8 20 b7 ff ff       	call   2030 <getenv@plt>
    6910:	48 85 c0             	test   %rax,%rax
    6913:	74 79                	je     698e <fwp_pipe_out_ready+0x8e>
    6915:	83 3d a0 e3 00 00 00 	cmpl   $0x0,0xe3a0(%rip)        # 14cbc <fwp_po_listen>
    691c:	78 70                	js     698e <fwp_pipe_out_ready+0x8e>
    691e:	80 38 00             	cmpb   $0x0,(%rax)
    6921:	74 6b                	je     698e <fwp_pipe_out_ready+0x8e>
    6923:	48 89 c7             	mov    %rax,%rdi
    6926:	31 f6                	xor    %esi,%esi
    6928:	ba 0a 00 00 00       	mov    $0xa,%edx
    692d:	e8 ee b9 ff ff       	call   2320 <strtol@plt>
    6932:	8b 0d 84 e3 00 00    	mov    0xe384(%rip),%ecx        # 14cbc <fwp_po_listen>
    6938:	89 0c 24             	mov    %ecx,(%rsp)
    693b:	48 b9 01 00 00 00 01 	movabs $0x100000001,%rcx
    6942:	00 00 00 
    6945:	48 89 4c 24 04       	mov    %rcx,0x4(%rsp)
    694a:	c7 44 24 0c 00 00 00 	movl   $0x0,0xc(%rsp)
    6951:	00 
    6952:	48 85 c0             	test   %rax,%rax
    6955:	7e 37                	jle    698e <fwp_pipe_out_ready+0x8e>
    6957:	48 3d ff ff ff 7f    	cmp    $0x7fffffff,%rax
    695d:	ba ff ff ff 7f       	mov    $0x7fffffff,%edx
    6962:	48 0f 4c d0          	cmovl  %rax,%rdx
    6966:	48 89 e7             	mov    %rsp,%rdi
    6969:	be 02 00 00 00       	mov    $0x2,%esi
    696e:	e8 4d ba ff ff       	call   23c0 <poll@plt>
    6973:	85 c0                	test   %eax,%eax
    6975:	7e 17                	jle    698e <fwp_pipe_out_ready+0x8e>
    6977:	f6 44 24 06 01       	testb  $0x1,0x6(%rsp)
    697c:	74 10                	je     698e <fwp_pipe_out_ready+0x8e>
    697e:	48 c7 05 77 e4 02 00 	movq   $0x0,0x2e477(%rip)        # 34e00 <fwp_po_next_check>
    6985:	00 00 00 00 
    6989:	e8 62 39 00 00       	call   a2f0 <fwp_pipe_poll>
    698e:	48 83 c4 18          	add    $0x18,%rsp
    6992:	c3                   	ret
    6993:	66 66 66 66 2e 0f 1f 	data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    699a:	84 00 00 00 00 00 

00000000000069a0 <fwp_exec_call>:
    69a0:	41 56                	push   %r14
    69a2:	53                   	push   %rbx
    69a3:	48 81 ec f8 00 00 00 	sub    $0xf8,%rsp
    69aa:	48 89 f3             	mov    %rsi,%rbx
    69ad:	49 89 fe             	mov    %rdi,%r14
    69b0:	48 8b 05 51 e4 02 00 	mov    0x2e451(%rip),%rax        # 34e08 <fwp_handlers>
    69b7:	48 89 84 24 d0 00 00 	mov    %rax,0xd0(%rsp)
    69be:	00 
    69bf:	48 c7 84 24 e8 00 00 	movq   $0x0,0xe8(%rsp)
    69c6:	00 00 00 00 00 
    69cb:	48 8b 05 a6 e3 00 00 	mov    0xe3a6(%rip),%rax        # 14d78 <fwp_cleanups>
    69d2:	48 89 84 24 f0 00 00 	mov    %rax,0xf0(%rsp)
    69d9:	00 
    69da:	48 8d 7c 24 08       	lea    0x8(%rsp),%rdi
    69df:	48 89 3d 22 e4 02 00 	mov    %rdi,0x2e422(%rip)        # 34e08 <fwp_handlers>
    69e6:	e8 c5 b8 ff ff       	call   22b0 <_setjmp@plt>
    69eb:	85 c0                	test   %eax,%eax
    69ed:	74 32                	je     6a21 <fwp_exec_call+0x81>
    69ef:	48 8b 84 24 d0 00 00 	mov    0xd0(%rsp),%rax
    69f6:	00 
    69f7:	48 89 05 0a e4 02 00 	mov    %rax,0x2e40a(%rip)        # 34e08 <fwp_handlers>
    69fe:	e8 2d c4 ff ff       	call   2e30 <fwp_flush>
    6a03:	48 8b bc 24 d8 00 00 	mov    0xd8(%rsp),%rdi
    6a0a:	00 
    6a0b:	48 8b b4 24 e0 00 00 	mov    0xe0(%rsp),%rsi
    6a12:	00 
    6a13:	e8 28 41 00 00       	call   ab40 <fwp_exec_error>
    6a18:	b9 01 00 00 00       	mov    $0x1,%ecx
    6a1d:	31 c0                	xor    %eax,%eax
    6a1f:	eb 21                	jmp    6a42 <fwp_exec_call+0xa2>
    6a21:	e8 fa 40 00 00       	call   ab20 <fwp_pap>
    6a26:	48 89 c7             	mov    %rax,%rdi
    6a29:	4c 89 f6             	mov    %r14,%rsi
    6a2c:	e8 2f 3c 00 00       	call   a660 <fwp_apply>
    6a31:	48 8b 8c 24 d0 00 00 	mov    0xd0(%rsp),%rcx
    6a38:	00 
    6a39:	48 89 0d c8 e3 02 00 	mov    %rcx,0x2e3c8(%rip)        # 34e08 <fwp_handlers>
    6a40:	31 c9                	xor    %ecx,%ecx
    6a42:	89 0b                	mov    %ecx,(%rbx)
    6a44:	48 81 c4 f8 00 00 00 	add    $0xf8,%rsp
    6a4b:	5b                   	pop    %rbx
    6a4c:	41 5e                	pop    %r14
    6a4e:	c3                   	ret
    6a4f:	90                   	nop

0000000000006a50 <fwp_emit_result>:
    6a50:	e9 5b 55 00 00       	jmp    bfb0 <fwp_emit>
    6a55:	66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
    6a5c:	00 00 00 00 

0000000000006a60 <fwp_read_exact>:
    6a60:	41 57                	push   %r15
    6a62:	41 56                	push   %r14
    6a64:	53                   	push   %rbx
    6a65:	48 89 f3             	mov    %rsi,%rbx
    6a68:	49 89 fe             	mov    %rdi,%r14
    6a6b:	45 31 ff             	xor    %r15d,%r15d
    6a6e:	48 85 f6             	test   %rsi,%rsi
    6a71:	0f 84 b9 00 00 00    	je     6b30 <fwp_read_exact+0xd0>
    6a77:	8b 05 4b e3 01 00    	mov    0x1e34b(%rip),%eax        # 24dc8 <fwp_in_npend>
    6a7d:	8b 0d 49 e3 01 00    	mov    0x1e349(%rip),%ecx        # 24dcc <fwp_in_ppos>
    6a83:	39 c1                	cmp    %eax,%ecx
    6a85:	0f 8d a5 00 00 00    	jge    6b30 <fwp_read_exact+0xd0>
    6a8b:	48 98                	cltq
    6a8d:	48 63 f1             	movslq %ecx,%rsi
    6a90:	48 89 f2             	mov    %rsi,%rdx
    6a93:	48 f7 d2             	not    %rdx
    6a96:	48 01 c2             	add    %rax,%rdx
    6a99:	48 8d 4b ff          	lea    -0x1(%rbx),%rcx
    6a9d:	48 39 ca             	cmp    %rcx,%rdx
    6aa0:	48 0f 43 d1          	cmovae %rcx,%rdx
    6aa4:	48 ff c2             	inc    %rdx
    6aa7:	48 83 fa 20          	cmp    $0x20,%rdx
    6aab:	72 16                	jb     6ac3 <fwp_read_exact+0x63>
    6aad:	48 8d 3d 10 e3 01 00 	lea    0x1e310(%rip),%rdi        # 24dc4 <fwp_in_pend>
    6ab4:	4d 89 f0             	mov    %r14,%r8
    6ab7:	49 29 f0             	sub    %rsi,%r8
    6aba:	49 29 f8             	sub    %rdi,%r8
    6abd:	49 83 f8 20          	cmp    $0x20,%r8
    6ac1:	73 27                	jae    6aea <fwp_read_exact+0x8a>
    6ac3:	45 31 ff             	xor    %r15d,%r15d
    6ac6:	48 89 f1             	mov    %rsi,%rcx
    6ac9:	48 8d 15 f4 e2 01 00 	lea    0x1e2f4(%rip),%rdx        # 24dc4 <fwp_in_pend>
    6ad0:	0f b6 34 11          	movzbl (%rcx,%rdx,1),%esi
    6ad4:	48 ff c1             	inc    %rcx
    6ad7:	43 88 34 3e          	mov    %sil,(%r14,%r15,1)
    6adb:	49 ff c7             	inc    %r15
    6ade:	49 39 df             	cmp    %rbx,%r15
    6ae1:	73 3f                	jae    6b22 <fwp_read_exact+0xc2>
    6ae3:	48 39 c1             	cmp    %rax,%rcx
    6ae6:	7c e8                	jl     6ad0 <fwp_read_exact+0x70>
    6ae8:	eb 38                	jmp    6b22 <fwp_read_exact+0xc2>
    6aea:	49 89 d7             	mov    %rdx,%r15
    6aed:	49 83 e7 e0          	and    $0xffffffffffffffe0,%r15
    6af1:	49 8d 0c 37          	lea    (%r15,%rsi,1),%rcx
    6af5:	48 01 fe             	add    %rdi,%rsi
    6af8:	48 83 c6 10          	add    $0x10,%rsi
    6afc:	31 ff                	xor    %edi,%edi
    6afe:	66 90                	xchg   %ax,%ax
    6b00:	0f 10 44 3e f0       	movups -0x10(%rsi,%rdi,1),%xmm0
    6b05:	0f 10 0c 3e          	movups (%rsi,%rdi,1),%xmm1
    6b09:	41 0f 11 04 3e       	movups %xmm0,(%r14,%rdi,1)
    6b0e:	41 0f 11 4c 3e 10    	movups %xmm1,0x10(%r14,%rdi,1)
    6b14:	48 83 c7 20          	add    $0x20,%rdi
    6b18:	49 39 ff             	cmp    %rdi,%r15
    6b1b:	75 e3                	jne    6b00 <fwp_read_exact+0xa0>
    6b1d:	4c 39 fa             	cmp    %r15,%rdx
    6b20:	75 a7                	jne    6ac9 <fwp_read_exact+0x69>
    6b22:	89 0d a4 e2 01 00    	mov    %ecx,0x1e2a4(%rip)        # 24dcc <fwp_in_ppos>
    6b28:	0f 1f 84 00 00 00 00 	nopl   0x0(%rax,%rax,1)
    6b2f:	00 
    6b30:	48 89 de             	mov    %rbx,%rsi
    6b33:	4c 29 fe             	sub    %r15,%rsi
    6b36:	76 15                	jbe    6b4d <fwp_read_exact+0xed>
    6b38:	4b 8d 3c 3e          	lea    (%r14,%r15,1),%rdi
    6b3c:	e8 4f 58 00 00       	call   c390 <fwp_pipe_read>
    6b41:	49 01 c7             	add    %rax,%r15
    6b44:	48 85 c0             	test   %rax,%rax
    6b47:	75 e7                	jne    6b30 <fwp_read_exact+0xd0>
    6b49:	31 c0                	xor    %eax,%eax
    6b4b:	eb 05                	jmp    6b52 <fwp_read_exact+0xf2>
    6b4d:	b8 01 00 00 00       	mov    $0x1,%eax
    6b52:	5b                   	pop    %rbx
    6b53:	41 5e                	pop    %r14
    6b55:	41 5f                	pop    %r15
    6b57:	c3                   	ret
    6b58:	0f 1f 84 00 00 00 00 	nopl   0x0(%rax,%rax,1)
    6b5f:	00 

0000000000006b60 <fwp_stdin_leb>:
    6b60:	41 57                	push   %r15
    6b62:	41 56                	push   %r14
    6b64:	53                   	push   %rbx
    6b65:	48 83 ec 10          	sub    $0x10,%rsp
    6b69:	48 89 fb             	mov    %rdi,%rbx
    6b6c:	48 c7 07 00 00 00 00 	movq   $0x0,(%rdi)
    6b73:	49 c7 c6 f9 ff ff ff 	mov    $0xfffffffffffffff9,%r14
    6b7a:	4c 8d 7c 24 0f       	lea    0xf(%rsp),%r15
    6b7f:	90                   	nop
    6b80:	be 01 00 00 00       	mov    $0x1,%esi
    6b85:	4c 89 ff             	mov    %r15,%rdi
    6b88:	e8 d3 fe ff ff       	call   6a60 <fwp_read_exact>
    6b8d:	85 c0                	test   %eax,%eax
    6b8f:	74 35                	je     6bc6 <fwp_stdin_leb+0x66>
    6b91:	0f b6 44 24 0f       	movzbl 0xf(%rsp),%eax
    6b96:	49 83 fe 38          	cmp    $0x38,%r14
    6b9a:	75 07                	jne    6ba3 <fwp_stdin_leb+0x43>
    6b9c:	89 c1                	mov    %eax,%ecx
    6b9e:	80 e1 7e             	and    $0x7e,%cl
    6ba1:	75 1c                	jne    6bbf <fwp_stdin_leb+0x5f>
    6ba3:	49 83 c6 07          	add    $0x7,%r14
    6ba7:	89 c2                	mov    %eax,%edx
    6ba9:	83 e2 7f             	and    $0x7f,%edx
    6bac:	44 89 f1             	mov    %r14d,%ecx
    6baf:	48 d3 e2             	shl    %cl,%rdx
    6bb2:	48 09 13             	or     %rdx,(%rbx)
    6bb5:	84 c0                	test   %al,%al
    6bb7:	79 11                	jns    6bca <fwp_stdin_leb+0x6a>
    6bb9:	49 83 fe 38          	cmp    $0x38,%r14
    6bbd:	76 c1                	jbe    6b80 <fwp_stdin_leb+0x20>
    6bbf:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    6bc4:	eb 09                	jmp    6bcf <fwp_stdin_leb+0x6f>
    6bc6:	31 c0                	xor    %eax,%eax
    6bc8:	eb 05                	jmp    6bcf <fwp_stdin_leb+0x6f>
    6bca:	b8 01 00 00 00       	mov    $0x1,%eax
    6bcf:	48 83 c4 10          	add    $0x10,%rsp
    6bd3:	5b                   	pop    %rbx
    6bd4:	41 5e                	pop    %r14
    6bd6:	41 5f                	pop    %r15
    6bd8:	c3                   	ret
    6bd9:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)

0000000000006be0 <fwp_stdin_name_len>:
    6be0:	53                   	push   %rbx
    6be1:	48 89 fb             	mov    %rdi,%rbx
    6be4:	e8 77 ff ff ff       	call   6b60 <fwp_stdin_leb>
    6be9:	83 f8 01             	cmp    $0x1,%eax
    6bec:	75 0e                	jne    6bfc <fwp_stdin_name_len+0x1c>
    6bee:	b9 ff ff ff ff       	mov    $0xffffffff,%ecx
    6bf3:	48 81 3b 00 00 10 00 	cmpq   $0x100000,(%rbx)
    6bfa:	77 02                	ja     6bfe <fwp_stdin_name_len+0x1e>
    6bfc:	89 c1                	mov    %eax,%ecx
    6bfe:	89 c8                	mov    %ecx,%eax
    6c00:	5b                   	pop    %rbx
    6c01:	c3                   	ret
    6c02:	66 66 66 66 66 2e 0f 	data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    6c09:	1f 84 00 00 00 00 00 

0000000000006c10 <fwp_pipe_in_offer>:
    6c10:	55                   	push   %rbp
    6c11:	41 57                	push   %r15
    6c13:	41 56                	push   %r14
    6c15:	53                   	push   %rbx
    6c16:	48 81 ec 08 01 00 00 	sub    $0x108,%rsp
    6c1d:	48 8d 74 24 08       	lea    0x8(%rsp),%rsi
    6c22:	31 ff                	xor    %edi,%edi
    6c24:	e8 b7 b8 ff ff       	call   24e0 <fstat@plt>
    6c29:	85 c0                	test   %eax,%eax
    6c2b:	0f 85 a5 00 00 00    	jne    6cd6 <fwp_pipe_in_offer+0xc6>
    6c31:	b8 00 f0 00 00       	mov    $0xf000,%eax
    6c36:	23 44 24 20          	and    0x20(%rsp),%eax
    6c3a:	3d 00 10 00 00       	cmp    $0x1000,%eax
    6c3f:	0f 85 91 00 00 00    	jne    6cd6 <fwp_pipe_in_offer+0xc6>
    6c45:	bf 01 00 00 00       	mov    $0x1,%edi
    6c4a:	be 01 00 08 00       	mov    $0x80001,%esi
    6c4f:	31 d2                	xor    %edx,%edx
    6c51:	e8 ba b8 ff ff       	call   2510 <socket@plt>
    6c56:	85 c0                	test   %eax,%eax
    6c58:	78 7c                	js     6cd6 <fwp_pipe_in_offer+0xc6>
    6c5a:	89 c3                	mov    %eax,%ebx
    6c5c:	48 8d bc 24 9a 00 00 	lea    0x9a(%rsp),%rdi
    6c63:	00 
    6c64:	48 8d 74 24 08       	lea    0x8(%rsp),%rsi
    6c69:	e8 92 31 00 00       	call   9e00 <fwp_pipe_addr>
    6c6e:	41 89 c6             	mov    %eax,%r14d
    6c71:	48 8d 3d 31 76 00 00 	lea    0x7631(%rip),%rdi        # e2a9 <exec_in_fp0+0xc69>
    6c78:	e8 b3 b3 ff ff       	call   2030 <getenv@plt>
    6c7d:	49 89 c7             	mov    %rax,%r15
    6c80:	e8 4b 31 00 00       	call   9dd0 <fwp_transport_off>
    6c85:	89 c5                	mov    %eax,%ebp
    6c87:	c7 04 24 46 57 50 54 	movl   $0x54505746,(%rsp)
    6c8e:	85 c0                	test   %eax,%eax
    6c90:	74 04                	je     6c96 <fwp_pipe_in_offer+0x86>
    6c92:	31 c0                	xor    %eax,%eax
    6c94:	eb 1f                	jmp    6cb5 <fwp_pipe_in_offer+0xa5>
    6c96:	4d 85 ff             	test   %r15,%r15
    6c99:	74 18                	je     6cb3 <fwp_pipe_in_offer+0xa3>
    6c9b:	48 8d 35 da 76 00 00 	lea    0x76da(%rip),%rsi        # e37c <exec_in_fp0+0xd3c>
    6ca2:	4c 89 ff             	mov    %r15,%rdi
    6ca5:	e8 26 b6 ff ff       	call   22d0 <strcmp@plt>
    6caa:	83 f8 01             	cmp    $0x1,%eax
    6cad:	b0 02                	mov    $0x2,%al
    6caf:	1c 00                	sbb    $0x0,%al
    6cb1:	eb 02                	jmp    6cb5 <fwp_pipe_in_offer+0xa5>
    6cb3:	b0 02                	mov    $0x2,%al
    6cb5:	88 44 24 04          	mov    %al,0x4(%rsp)
    6cb9:	48 8d b4 24 9a 00 00 	lea    0x9a(%rsp),%rsi
    6cc0:	00 
    6cc1:	89 df                	mov    %ebx,%edi
    6cc3:	44 89 f2             	mov    %r14d,%edx
    6cc6:	e8 c5 b7 ff ff       	call   2490 <connect@plt>
    6ccb:	85 c0                	test   %eax,%eax
    6ccd:	74 15                	je     6ce4 <fwp_pipe_in_offer+0xd4>
    6ccf:	89 df                	mov    %ebx,%edi
    6cd1:	e8 5a b5 ff ff       	call   2230 <close@plt>
    6cd6:	48 81 c4 08 01 00 00 	add    $0x108,%rsp
    6cdd:	5b                   	pop    %rbx
    6cde:	41 5e                	pop    %r14
    6ce0:	41 5f                	pop    %r15
    6ce2:	5d                   	pop    %rbp
    6ce3:	c3                   	ret
    6ce4:	48 89 e6             	mov    %rsp,%rsi
    6ce7:	ba 05 00 00 00       	mov    $0x5,%edx
    6cec:	89 df                	mov    %ebx,%edi
    6cee:	b9 00 40 00 00       	mov    $0x4000,%ecx
    6cf3:	e8 a8 b4 ff ff       	call   21a0 <send@plt>
    6cf8:	85 ed                	test   %ebp,%ebp
    6cfa:	75 d3                	jne    6ccf <fwp_pipe_in_offer+0xbf>
    6cfc:	48 83 f8 05          	cmp    $0x5,%rax
    6d00:	75 cd                	jne    6ccf <fwp_pipe_in_offer+0xbf>
    6d02:	89 1d c0 df 00 00    	mov    %ebx,0xdfc0(%rip)        # 14cc8 <fwp_pi_sock>
    6d08:	eb cc                	jmp    6cd6 <fwp_pipe_in_offer+0xc6>
    6d0a:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)

0000000000006d10 <fwp_pipe_in_switch>:
    6d10:	55                   	push   %rbp
    6d11:	41 57                	push   %r15
    6d13:	41 56                	push   %r14
    6d15:	53                   	push   %rbx
    6d16:	48 81 ec 08 01 00 00 	sub    $0x108,%rsp
    6d1d:	31 db                	xor    %ebx,%ebx
    6d1f:	48 83 fe 01          	cmp    $0x1,%rsi
    6d23:	0f 85 f6 01 00 00    	jne    6f1f <fwp_pipe_in_switch+0x20f>
    6d29:	48 89 f8             	mov    %rdi,%rax
    6d2c:	8b 3d 96 df 00 00    	mov    0xdf96(%rip),%edi        # 14cc8 <fwp_pi_sock>
    6d32:	85 ff                	test   %edi,%edi
    6d34:	0f 88 e5 01 00 00    	js     6f1f <fwp_pipe_in_switch+0x20f>
    6d3a:	83 3d d3 e0 02 00 00 	cmpl   $0x0,0x2e0d3(%rip)        # 34e14 <fwp_pi_kind>
    6d41:	0f 85 d8 01 00 00    	jne    6f1f <fwp_pipe_in_switch+0x20f>
    6d47:	0f b6 00             	movzbl (%rax),%eax
    6d4a:	83 f8 02             	cmp    $0x2,%eax
    6d4d:	74 29                	je     6d78 <fwp_pipe_in_switch+0x68>
    6d4f:	83 f8 01             	cmp    $0x1,%eax
    6d52:	0f 85 c7 01 00 00    	jne    6f1f <fwp_pipe_in_switch+0x20f>
    6d58:	c7 05 b2 e0 02 00 01 	movl   $0x1,0x2e0b2(%rip)        # 34e14 <fwp_pi_kind>
    6d5f:	00 00 00 
    6d62:	48 8d 3d 2a 73 00 00 	lea    0x732a(%rip),%rdi        # e093 <exec_in_fp0+0xa53>
    6d69:	e8 42 58 00 00       	call   c5b0 <fwp_pipe_report>
    6d6e:	bb 01 00 00 00       	mov    $0x1,%ebx
    6d73:	e9 a7 01 00 00       	jmp    6f1f <fwp_pipe_in_switch+0x20f>
    6d78:	48 8d 44 24 0f       	lea    0xf(%rsp),%rax
    6d7d:	48 89 44 24 50       	mov    %rax,0x50(%rsp)
    6d82:	48 c7 44 24 58 01 00 	movq   $0x1,0x58(%rsp)
    6d89:	00 00 
    6d8b:	0f 57 c0             	xorps  %xmm0,%xmm0
    6d8e:	0f 29 44 24 20       	movaps %xmm0,0x20(%rsp)
    6d93:	0f 29 44 24 30       	movaps %xmm0,0x30(%rsp)
    6d98:	0f 29 44 24 10       	movaps %xmm0,0x10(%rsp)
    6d9d:	48 c7 44 24 40 00 00 	movq   $0x0,0x40(%rsp)
    6da4:	00 00 
    6da6:	48 8d 44 24 50       	lea    0x50(%rsp),%rax
    6dab:	48 89 44 24 20       	mov    %rax,0x20(%rsp)
    6db0:	48 c7 44 24 28 01 00 	movq   $0x1,0x28(%rsp)
    6db7:	00 00 
    6db9:	48 8d 44 24 60       	lea    0x60(%rsp),%rax
    6dbe:	48 89 44 24 30       	mov    %rax,0x30(%rsp)
    6dc3:	48 c7 44 24 38 18 00 	movq   $0x18,0x38(%rsp)
    6dca:	00 00 
    6dcc:	48 8d 74 24 10       	lea    0x10(%rsp),%rsi
    6dd1:	ba 00 00 00 40       	mov    $0x40000000,%edx
    6dd6:	e8 c5 b5 ff ff       	call   23a0 <recvmsg@plt>
    6ddb:	31 db                	xor    %ebx,%ebx
    6ddd:	48 83 f8 01          	cmp    $0x1,%rax
    6de1:	0f 85 38 01 00 00    	jne    6f1f <fwp_pipe_in_switch+0x20f>
    6de7:	48 83 7c 24 38 10    	cmpq   $0x10,0x38(%rsp)
    6ded:	0f 82 2c 01 00 00    	jb     6f1f <fwp_pipe_in_switch+0x20f>
    6df3:	48 8b 44 24 30       	mov    0x30(%rsp),%rax
    6df8:	48 85 c0             	test   %rax,%rax
    6dfb:	0f 84 1e 01 00 00    	je     6f1f <fwp_pipe_in_switch+0x20f>
    6e01:	83 78 0c 01          	cmpl   $0x1,0xc(%rax)
    6e05:	0f 85 14 01 00 00    	jne    6f1f <fwp_pipe_in_switch+0x20f>
    6e0b:	8b 68 10             	mov    0x10(%rax),%ebp
    6e0e:	48 8d 74 24 78       	lea    0x78(%rsp),%rsi
    6e13:	89 ef                	mov    %ebp,%edi
    6e15:	e8 c6 b6 ff ff       	call   24e0 <fstat@plt>
    6e1a:	85 c0                	test   %eax,%eax
    6e1c:	0f 85 f4 00 00 00    	jne    6f16 <fwp_pipe_in_switch+0x206>
    6e22:	4c 8b b4 24 a8 00 00 	mov    0xa8(%rsp),%r14
    6e29:	00 
    6e2a:	49 81 fe 00 10 00 00 	cmp    $0x1000,%r14
    6e31:	0f 86 df 00 00 00    	jbe    6f16 <fwp_pipe_in_switch+0x206>
    6e37:	31 db                	xor    %ebx,%ebx
    6e39:	31 ff                	xor    %edi,%edi
    6e3b:	4c 89 f6             	mov    %r14,%rsi
    6e3e:	ba 03 00 00 00       	mov    $0x3,%edx
    6e43:	b9 01 00 00 00       	mov    $0x1,%ecx
    6e48:	41 89 e8             	mov    %ebp,%r8d
    6e4b:	45 31 c9             	xor    %r9d,%r9d
    6e4e:	e8 3d b3 ff ff       	call   2190 <mmap@plt>
    6e53:	49 89 c7             	mov    %rax,%r15
    6e56:	89 ef                	mov    %ebp,%edi
    6e58:	e8 d3 b3 ff ff       	call   2230 <close@plt>
    6e5d:	49 83 ff ff          	cmp    $0xffffffffffffffff,%r15
    6e61:	0f 84 b8 00 00 00    	je     6f1f <fwp_pipe_in_switch+0x20f>
    6e67:	41 81 3f 46 57 50 53 	cmpl   $0x53505746,(%r15)
    6e6e:	0f 85 ab 00 00 00    	jne    6f1f <fwp_pipe_in_switch+0x20f>
    6e74:	41 83 7f 04 01       	cmpl   $0x1,0x4(%r15)
    6e79:	0f 85 a0 00 00 00    	jne    6f1f <fwp_pipe_in_switch+0x20f>
    6e7f:	49 8b 47 08          	mov    0x8(%r15),%rax
    6e83:	48 85 c0             	test   %rax,%rax
    6e86:	0f 84 93 00 00 00    	je     6f1f <fwp_pipe_in_switch+0x20f>
    6e8c:	48 89 c1             	mov    %rax,%rcx
    6e8f:	48 d1 e9             	shr    $1,%rcx
    6e92:	48 ba 55 55 55 55 55 	movabs $0x5555555555555555,%rdx
    6e99:	55 55 55 
    6e9c:	48 21 ca             	and    %rcx,%rdx
    6e9f:	48 89 c1             	mov    %rax,%rcx
    6ea2:	48 29 d1             	sub    %rdx,%rcx
    6ea5:	48 ba 33 33 33 33 33 	movabs $0x3333333333333333,%rdx
    6eac:	33 33 33 
    6eaf:	48 89 ce             	mov    %rcx,%rsi
    6eb2:	48 21 d6             	and    %rdx,%rsi
    6eb5:	48 c1 e9 02          	shr    $0x2,%rcx
    6eb9:	48 21 d1             	and    %rdx,%rcx
    6ebc:	48 01 f1             	add    %rsi,%rcx
    6ebf:	48 89 ca             	mov    %rcx,%rdx
    6ec2:	48 c1 ea 04          	shr    $0x4,%rdx
    6ec6:	48 01 ca             	add    %rcx,%rdx
    6ec9:	48 b9 0f 0f 0f 0f 0f 	movabs $0xf0f0f0f0f0f0f0f,%rcx
    6ed0:	0f 0f 0f 
    6ed3:	48 21 d1             	and    %rdx,%rcx
    6ed6:	48 ba 01 01 01 01 01 	movabs $0x101010101010101,%rdx
    6edd:	01 01 01 
    6ee0:	48 0f af d1          	imul   %rcx,%rdx
    6ee4:	48 c1 ea 38          	shr    $0x38,%rdx
    6ee8:	83 fa 01             	cmp    $0x1,%edx
    6eeb:	77 32                	ja     6f1f <fwp_pipe_in_switch+0x20f>
    6eed:	49 81 c6 00 f0 ff ff 	add    $0xfffffffffffff000,%r14
    6ef4:	4c 39 f0             	cmp    %r14,%rax
    6ef7:	77 26                	ja     6f1f <fwp_pipe_in_switch+0x20f>
    6ef9:	4c 89 3d 18 df 02 00 	mov    %r15,0x2df18(%rip)        # 34e18 <fwp_pi_ring>
    6f00:	c7 05 0a df 02 00 02 	movl   $0x2,0x2df0a(%rip)        # 34e14 <fwp_pi_kind>
    6f07:	00 00 00 
    6f0a:	48 8d 3d 6f 74 00 00 	lea    0x746f(%rip),%rdi        # e380 <exec_in_fp0+0xd40>
    6f11:	e9 53 fe ff ff       	jmp    6d69 <fwp_pipe_in_switch+0x59>
    6f16:	89 ef                	mov    %ebp,%edi
    6f18:	e8 13 b3 ff ff       	call   2230 <close@plt>
    6f1d:	31 db                	xor    %ebx,%ebx
    6f1f:	89 d8                	mov    %ebx,%eax
    6f21:	48 81 c4 08 01 00 00 	add    $0x108,%rsp
    6f28:	5b                   	pop    %rbx
    6f29:	41 5e                	pop    %r14
    6f2b:	41 5f                	pop    %r15
    6f2d:	5d                   	pop    %rbp
    6f2e:	c3                   	ret
    6f2f:	90                   	nop

0000000000006f30 <fwp_decode>:
    6f30:	55                   	push   %rbp
    6f31:	41 57                	push   %r15
    6f33:	41 56                	push   %r14
    6f35:	41 55                	push   %r13
    6f37:	41 54                	push   %r12
    6f39:	53                   	push   %rbx
    6f3a:	48 83 ec 38          	sub    $0x38,%rsp
    6f3e:	8b 06                	mov    (%rsi),%eax
    6f40:	45 31 f6             	xor    %r14d,%r14d
    6f43:	48 83 f8 15          	cmp    $0x15,%rax
    6f47:	77 47                	ja     6f90 <fwp_decode+0x60>
    6f49:	48 89 d3             	mov    %rdx,%rbx
    6f4c:	49 89 f4             	mov    %rsi,%r12
    6f4f:	49 89 ff             	mov    %rdi,%r15
    6f52:	48 8d 0d 27 62 00 00 	lea    0x6227(%rip),%rcx        # d180 <_IO_stdin_used+0x180>
    6f59:	48 63 14 81          	movslq (%rcx,%rax,4),%rdx
    6f5d:	48 01 ca             	add    %rcx,%rdx
    6f60:	ff e2                	jmp    *%rdx
    6f62:	31 c9                	xor    %ecx,%ecx
    6f64:	83 f8 0a             	cmp    $0xa,%eax
    6f67:	0f 95 c1             	setne  %cl
    6f6a:	8d 34 8d 04 00 00 00 	lea    0x4(,%rcx,4),%esi
    6f71:	48 8d 54 24 08       	lea    0x8(%rsp),%rdx
    6f76:	4c 89 ff             	mov    %r15,%rdi
    6f79:	e8 82 56 00 00       	call   c600 <rd_le>
    6f7e:	85 c0                	test   %eax,%eax
    6f80:	74 0e                	je     6f90 <fwp_decode+0x60>
    6f82:	48 8b 44 24 08       	mov    0x8(%rsp),%rax
    6f87:	48 89 03             	mov    %rax,(%rbx)
    6f8a:	41 be 01 00 00 00    	mov    $0x1,%r14d
    6f90:	44 89 f0             	mov    %r14d,%eax
    6f93:	48 83 c4 38          	add    $0x38,%rsp
    6f97:	5b                   	pop    %rbx
    6f98:	41 5c                	pop    %r12
    6f9a:	41 5d                	pop    %r13
    6f9c:	41 5e                	pop    %r14
    6f9e:	41 5f                	pop    %r15
    6fa0:	5d                   	pop    %rbp
    6fa1:	c3                   	ret
    6fa2:	48 8d 74 24 08       	lea    0x8(%rsp),%rsi
    6fa7:	4c 89 ff             	mov    %r15,%rdi
    6faa:	e8 11 57 00 00       	call   c6c0 <rd_leb>
    6faf:	45 31 f6             	xor    %r14d,%r14d
    6fb2:	85 c0                	test   %eax,%eax
    6fb4:	74 da                	je     6f90 <fwp_decode+0x60>
    6fb6:	4c 8b 6c 24 08       	mov    0x8(%rsp),%r13
    6fbb:	4d 3b 6f 08          	cmp    0x8(%r15),%r13
    6fbf:	77 cf                	ja     6f90 <fwp_decode+0x60>
    6fc1:	48 8d 54 24 18       	lea    0x18(%rsp),%rdx
    6fc6:	4c 89 ff             	mov    %r15,%rdi
    6fc9:	4c 89 ee             	mov    %r13,%rsi
    6fcc:	e8 6f 57 00 00       	call   c740 <rd_take>
    6fd1:	85 c0                	test   %eax,%eax
    6fd3:	74 bb                	je     6f90 <fwp_decode+0x60>
    6fd5:	41 83 3c 24 0c       	cmpl   $0xc,(%r12)
    6fda:	4c 8b 7c 24 18       	mov    0x18(%rsp),%r15
    6fdf:	75 0f                	jne    6ff0 <fwp_decode+0xc0>
    6fe1:	4c 89 ff             	mov    %r15,%rdi
    6fe4:	4c 89 ee             	mov    %r13,%rsi
    6fe7:	e8 14 05 00 00       	call   7500 <fwp_valid_utf8>
    6fec:	85 c0                	test   %eax,%eax
    6fee:	74 a0                	je     6f90 <fwp_decode+0x60>
    6ff0:	4c 89 ff             	mov    %r15,%rdi
    6ff3:	4c 89 ee             	mov    %r13,%rsi
    6ff6:	e8 65 06 00 00       	call   7660 <fwp_str_new>
    6ffb:	eb 8a                	jmp    6f87 <fwp_decode+0x57>
    6ffd:	48 8d 54 24 08       	lea    0x8(%rsp),%rdx
    7002:	4c 89 ff             	mov    %r15,%rdi
    7005:	be 01 00 00 00       	mov    $0x1,%esi
    700a:	e8 f1 55 00 00       	call   c600 <rd_le>
    700f:	85 c0                	test   %eax,%eax
    7011:	0f 84 79 ff ff ff    	je     6f90 <fwp_decode+0x60>
    7017:	48 0f be 44 24 08    	movsbq 0x8(%rsp),%rax
    701d:	e9 65 ff ff ff       	jmp    6f87 <fwp_decode+0x57>
    7022:	48 8d 54 24 08       	lea    0x8(%rsp),%rdx
    7027:	4c 89 ff             	mov    %r15,%rdi
    702a:	be 08 00 00 00       	mov    $0x8,%esi
    702f:	e8 cc 55 00 00       	call   c600 <rd_le>
    7034:	45 31 f6             	xor    %r14d,%r14d
    7037:	85 c0                	test   %eax,%eax
    7039:	0f 84 51 ff ff ff    	je     6f90 <fwp_decode+0x60>
    703f:	48 8d 54 24 18       	lea    0x18(%rsp),%rdx
    7044:	4c 89 ff             	mov    %r15,%rdi
    7047:	be 08 00 00 00       	mov    $0x8,%esi
    704c:	e8 af 55 00 00       	call   c600 <rd_le>
    7051:	85 c0                	test   %eax,%eax
    7053:	0f 84 37 ff ff ff    	je     6f90 <fwp_decode+0x60>
    7059:	48 8b 74 24 18       	mov    0x18(%rsp),%rsi
    705e:	48 8b 7c 24 08       	mov    0x8(%rsp),%rdi
    7063:	41 83 3c 24 04       	cmpl   $0x4,(%r12)
    7068:	0f 85 d1 02 00 00    	jne    733f <fwp_decode+0x40f>
    706e:	e8 9d 24 00 00       	call   9510 <fwp_box_i128>
    7073:	e9 0f ff ff ff       	jmp    6f87 <fwp_decode+0x57>
    7078:	48 8d 74 24 08       	lea    0x8(%rsp),%rsi
    707d:	4c 89 ff             	mov    %r15,%rdi
    7080:	e8 3b 56 00 00       	call   c6c0 <rd_leb>
    7085:	85 c0                	test   %eax,%eax
    7087:	0f 84 03 ff ff ff    	je     6f90 <fwp_decode+0x60>
    708d:	48 8b 6c 24 08       	mov    0x8(%rsp),%rbp
    7092:	49 3b 6f 08          	cmp    0x8(%r15),%rbp
    7096:	0f 87 f4 fe ff ff    	ja     6f90 <fwp_decode+0x60>
    709c:	4c 8d 35 2d dd 01 00 	lea    0x1dd2d(%rip),%r14        # 24dd0 <fwp_empty_map>
    70a3:	48 85 ed             	test   %rbp,%rbp
    70a6:	0f 84 9d 02 00 00    	je     7349 <fwp_decode+0x419>
    70ac:	4c 8d 6c 24 18       	lea    0x18(%rsp),%r13
    70b1:	eb 20                	jmp    70d3 <fwp_decode+0x1a3>
    70b3:	31 f6                	xor    %esi,%esi
    70b5:	48 8b 7c 24 18       	mov    0x18(%rsp),%rdi
    70ba:	49 8b 4c 24 38       	mov    0x38(%r12),%rcx
    70bf:	4c 89 f2             	mov    %r14,%rdx
    70c2:	e8 89 1c 00 00       	call   8d50 <fwp_p_map_insert>
    70c7:	49 89 c6             	mov    %rax,%r14
    70ca:	48 ff cd             	dec    %rbp
    70cd:	0f 84 76 02 00 00    	je     7349 <fwp_decode+0x419>
    70d3:	48 c7 44 24 30 00 00 	movq   $0x0,0x30(%rsp)
    70da:	00 00 
    70dc:	49 8b 74 24 38       	mov    0x38(%r12),%rsi
    70e1:	4c 89 ff             	mov    %r15,%rdi
    70e4:	4c 89 ea             	mov    %r13,%rdx
    70e7:	e8 44 fe ff ff       	call   6f30 <fwp_decode>
    70ec:	85 c0                	test   %eax,%eax
    70ee:	0f 84 69 02 00 00    	je     735d <fwp_decode+0x42d>
    70f4:	41 83 3c 24 12       	cmpl   $0x12,(%r12)
    70f9:	75 b8                	jne    70b3 <fwp_decode+0x183>
    70fb:	49 8b 74 24 40       	mov    0x40(%r12),%rsi
    7100:	4c 89 ff             	mov    %r15,%rdi
    7103:	48 8d 54 24 30       	lea    0x30(%rsp),%rdx
    7108:	e8 23 fe ff ff       	call   6f30 <fwp_decode>
    710d:	85 c0                	test   %eax,%eax
    710f:	0f 84 48 02 00 00    	je     735d <fwp_decode+0x42d>
    7115:	48 8b 74 24 30       	mov    0x30(%rsp),%rsi
    711a:	eb 99                	jmp    70b5 <fwp_decode+0x185>
    711c:	48 8d 74 24 08       	lea    0x8(%rsp),%rsi
    7121:	4c 89 ff             	mov    %r15,%rdi
    7124:	e8 97 55 00 00       	call   c6c0 <rd_leb>
    7129:	85 c0                	test   %eax,%eax
    712b:	0f 84 5f fe ff ff    	je     6f90 <fwp_decode+0x60>
    7131:	48 89 5c 24 20       	mov    %rbx,0x20(%rsp)
    7136:	48 8b 5c 24 08       	mov    0x8(%rsp),%rbx
    713b:	49 3b 5f 08          	cmp    0x8(%r15),%rbx
    713f:	0f 87 4b fe ff ff    	ja     6f90 <fwp_decode+0x60>
    7145:	48 8d 3c dd 08 00 00 	lea    0x8(,%rbx,8),%rdi
    714c:	00 
    714d:	e8 ae c3 ff ff       	call   3500 <fwp_alloc>
    7152:	48 89 44 24 10       	mov    %rax,0x10(%rsp)
    7157:	48 85 db             	test   %rbx,%rbx
    715a:	74 35                	je     7191 <fwp_decode+0x261>
    715c:	48 8b 6c 24 10       	mov    0x10(%rsp),%rbp
    7161:	49 89 dd             	mov    %rbx,%r13
    7164:	66 66 66 2e 0f 1f 84 	data16 data16 cs nopw 0x0(%rax,%rax,1)
    716b:	00 00 00 00 00 
    7170:	49 8b 74 24 38       	mov    0x38(%r12),%rsi
    7175:	4c 89 ff             	mov    %r15,%rdi
    7178:	48 89 ea             	mov    %rbp,%rdx
    717b:	e8 b0 fd ff ff       	call   6f30 <fwp_decode>
    7180:	85 c0                	test   %eax,%eax
    7182:	0f 84 08 fe ff ff    	je     6f90 <fwp_decode+0x60>
    7188:	48 83 c5 08          	add    $0x8,%rbp
    718c:	49 ff cd             	dec    %r13
    718f:	75 df                	jne    7170 <fwp_decode+0x240>
    7191:	48 8b 7c 24 10       	mov    0x10(%rsp),%rdi
    7196:	48 89 de             	mov    %rbx,%rsi
    7199:	e8 a2 02 00 00       	call   7440 <fwp_list_from>
    719e:	41 83 3c 24 11       	cmpl   $0x11,(%r12)
    71a3:	0f 85 b4 00 00 00    	jne    725d <fwp_decode+0x32d>
    71a9:	48 89 c7             	mov    %rax,%rdi
    71ac:	e8 4f 1a 00 00       	call   8c00 <fwp_p_array_from_list>
    71b1:	e9 a7 00 00 00       	jmp    725d <fwp_decode+0x32d>
    71b6:	48 8d 74 24 08       	lea    0x8(%rsp),%rsi
    71bb:	4c 89 ff             	mov    %r15,%rdi
    71be:	e8 fd 54 00 00       	call   c6c0 <rd_leb>
    71c3:	85 c0                	test   %eax,%eax
    71c5:	0f 84 c5 fd ff ff    	je     6f90 <fwp_decode+0x60>
    71cb:	4c 8b 6c 24 08       	mov    0x8(%rsp),%r13
    71d0:	49 63 44 24 10       	movslq 0x10(%r12),%rax
    71d5:	49 39 c5             	cmp    %rax,%r13
    71d8:	0f 83 b2 fd ff ff    	jae    6f90 <fwp_decode+0x60>
    71de:	48 89 5c 24 20       	mov    %rbx,0x20(%rsp)
    71e3:	49 8b 44 24 28       	mov    0x28(%r12),%rax
    71e8:	4a 63 1c a8          	movslq (%rax,%r13,4),%rbx
    71ec:	48 8d 3c dd 08 00 00 	lea    0x8(,%rbx,8),%rdi
    71f3:	00 
    71f4:	e8 07 c3 ff ff       	call   3500 <fwp_alloc>
    71f9:	48 89 44 24 10       	mov    %rax,0x10(%rsp)
    71fe:	89 d8                	mov    %ebx,%eax
    7200:	48 89 44 24 28       	mov    %rax,0x28(%rsp)
    7205:	48 85 db             	test   %rbx,%rbx
    7208:	7e 41                	jle    724b <fwp_decode+0x31b>
    720a:	48 8b 44 24 28       	mov    0x28(%rsp),%rax
    720f:	48 8d 2c c5 00 00 00 	lea    0x0(,%rax,8),%rbp
    7216:	00 
    7217:	45 31 f6             	xor    %r14d,%r14d
    721a:	31 db                	xor    %ebx,%ebx
    721c:	49 8b 44 24 30       	mov    0x30(%r12),%rax
    7221:	4a 8b 04 e8          	mov    (%rax,%r13,8),%rax
    7225:	48 8b 34 18          	mov    (%rax,%rbx,1),%rsi
    7229:	48 8b 44 24 10       	mov    0x10(%rsp),%rax
    722e:	48 8d 14 18          	lea    (%rax,%rbx,1),%rdx
    7232:	4c 89 ff             	mov    %r15,%rdi
    7235:	e8 f6 fc ff ff       	call   6f30 <fwp_decode>
    723a:	85 c0                	test   %eax,%eax
    723c:	0f 84 4e fd ff ff    	je     6f90 <fwp_decode+0x60>
    7242:	48 83 c3 08          	add    $0x8,%rbx
    7246:	48 39 dd             	cmp    %rbx,%rbp
    7249:	75 d1                	jne    721c <fwp_decode+0x2ec>
    724b:	44 89 ef             	mov    %r13d,%edi
    724e:	48 8b 74 24 28       	mov    0x28(%rsp),%rsi
    7253:	48 8b 54 24 10       	mov    0x10(%rsp),%rdx
    7258:	e8 b3 e3 ff ff       	call   5610 <fwp_data>
    725d:	48 8b 4c 24 20       	mov    0x20(%rsp),%rcx
    7262:	48 89 01             	mov    %rax,(%rcx)
    7265:	e9 20 fd ff ff       	jmp    6f8a <fwp_decode+0x5a>
    726a:	be 01 00 00 00       	mov    $0x1,%esi
    726f:	e9 fd fc ff ff       	jmp    6f71 <fwp_decode+0x41>
    7274:	be 02 00 00 00       	mov    $0x2,%esi
    7279:	e9 f3 fc ff ff       	jmp    6f71 <fwp_decode+0x41>
    727e:	48 8d 54 24 08       	lea    0x8(%rsp),%rdx
    7283:	4c 89 ff             	mov    %r15,%rdi
    7286:	be 02 00 00 00       	mov    $0x2,%esi
    728b:	e8 70 53 00 00       	call   c600 <rd_le>
    7290:	85 c0                	test   %eax,%eax
    7292:	0f 84 f8 fc ff ff    	je     6f90 <fwp_decode+0x60>
    7298:	48 0f bf 44 24 08    	movswq 0x8(%rsp),%rax
    729e:	e9 e4 fc ff ff       	jmp    6f87 <fwp_decode+0x57>
    72a3:	48 8d 54 24 08       	lea    0x8(%rsp),%rdx
    72a8:	4c 89 ff             	mov    %r15,%rdi
    72ab:	be 04 00 00 00       	mov    $0x4,%esi
    72b0:	e8 4b 53 00 00       	call   c600 <rd_le>
    72b5:	85 c0                	test   %eax,%eax
    72b7:	0f 84 d3 fc ff ff    	je     6f90 <fwp_decode+0x60>
    72bd:	48 63 44 24 08       	movslq 0x8(%rsp),%rax
    72c2:	e9 c0 fc ff ff       	jmp    6f87 <fwp_decode+0x57>
    72c7:	be 04 00 00 00       	mov    $0x4,%esi
    72cc:	e9 a0 fc ff ff       	jmp    6f71 <fwp_decode+0x41>
    72d1:	49 63 7c 24 10       	movslq 0x10(%r12),%rdi
    72d6:	48 85 ff             	test   %rdi,%rdi
    72d9:	74 76                	je     7351 <fwp_decode+0x421>
    72db:	48 c1 e7 03          	shl    $0x3,%rdi
    72df:	e8 1c c2 ff ff       	call   3500 <fwp_alloc>
    72e4:	41 8b 7c 24 10       	mov    0x10(%r12),%edi
    72e9:	85 ff                	test   %edi,%edi
    72eb:	7e 45                	jle    7332 <fwp_decode+0x402>
    72ed:	45 31 f6             	xor    %r14d,%r14d
    72f0:	48 89 44 24 10       	mov    %rax,0x10(%rsp)
    72f5:	48 89 c5             	mov    %rax,%rbp
    72f8:	45 31 ed             	xor    %r13d,%r13d
    72fb:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)
    7300:	49 8b 44 24 20       	mov    0x20(%r12),%rax
    7305:	4a 8b 34 e8          	mov    (%rax,%r13,8),%rsi
    7309:	4c 89 ff             	mov    %r15,%rdi
    730c:	48 89 ea             	mov    %rbp,%rdx
    730f:	e8 1c fc ff ff       	call   6f30 <fwp_decode>
    7314:	85 c0                	test   %eax,%eax
    7316:	0f 84 74 fc ff ff    	je     6f90 <fwp_decode+0x60>
    731c:	49 ff c5             	inc    %r13
    731f:	49 63 7c 24 10       	movslq 0x10(%r12),%rdi
    7324:	48 83 c5 08          	add    $0x8,%rbp
    7328:	49 39 fd             	cmp    %rdi,%r13
    732b:	7c d3                	jl     7300 <fwp_decode+0x3d0>
    732d:	48 8b 44 24 10       	mov    0x10(%rsp),%rax
    7332:	48 89 c6             	mov    %rax,%rsi
    7335:	e8 c6 be ff ff       	call   3200 <fwp_record>
    733a:	e9 48 fc ff ff       	jmp    6f87 <fwp_decode+0x57>
    733f:	e8 7c 20 00 00       	call   93c0 <fwp_box_u128>
    7344:	e9 3e fc ff ff       	jmp    6f87 <fwp_decode+0x57>
    7349:	4c 89 33             	mov    %r14,(%rbx)
    734c:	e9 39 fc ff ff       	jmp    6f8a <fwp_decode+0x5a>
    7351:	48 c7 03 00 00 00 00 	movq   $0x0,(%rbx)
    7358:	e9 2d fc ff ff       	jmp    6f8a <fwp_decode+0x5a>
    735d:	45 31 f6             	xor    %r14d,%r14d
    7360:	e9 2b fc ff ff       	jmp    6f90 <fwp_decode+0x60>
    7365:	66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
    736c:	00 00 00 00 

0000000000007370 <fwp_read_text_line>:
    7370:	53                   	push   %rbx
    7371:	48 89 fb             	mov    %rdi,%rbx
    7374:	48 c7 47 08 00 00 00 	movq   $0x0,0x8(%rdi)
    737b:	00 
    737c:	e8 ef 53 00 00       	call   c770 <fwp_getc>
    7381:	83 f8 ff             	cmp    $0xffffffff,%eax
    7384:	74 59                	je     73df <fwp_read_text_line+0x6f>
    7386:	66 2e 0f 1f 84 00 00 	cs nopw 0x0(%rax,%rax,1)
    738d:	00 00 00 
    7390:	83 f8 0a             	cmp    $0xa,%eax
    7393:	74 1a                	je     73af <fwp_read_text_line+0x3f>
    7395:	0f be f0             	movsbl %al,%esi
    7398:	48 89 df             	mov    %rbx,%rdi
    739b:	e8 00 03 00 00       	call   76a0 <buf_putc>
    73a0:	e8 cb 53 00 00       	call   c770 <fwp_getc>
    73a5:	83 f8 ff             	cmp    $0xffffffff,%eax
    73a8:	75 e6                	jne    7390 <fwp_read_text_line+0x20>
    73aa:	48 8b 03             	mov    (%rbx),%rax
    73ad:	eb 1c                	jmp    73cb <fwp_read_text_line+0x5b>
    73af:	48 8b 03             	mov    (%rbx),%rax
    73b2:	48 8b 4b 08          	mov    0x8(%rbx),%rcx
    73b6:	48 85 c9             	test   %rcx,%rcx
    73b9:	74 10                	je     73cb <fwp_read_text_line+0x5b>
    73bb:	80 7c 08 ff 0d       	cmpb   $0xd,-0x1(%rax,%rcx,1)
    73c0:	75 12                	jne    73d4 <fwp_read_text_line+0x64>
    73c2:	48 ff c9             	dec    %rcx
    73c5:	48 89 4b 08          	mov    %rcx,0x8(%rbx)
    73c9:	eb 05                	jmp    73d0 <fwp_read_text_line+0x60>
    73cb:	48 85 c0             	test   %rax,%rax
    73ce:	74 08                	je     73d8 <fwp_read_text_line+0x68>
    73d0:	48 8b 4b 08          	mov    0x8(%rbx),%rcx
    73d4:	c6 04 08 00          	movb   $0x0,(%rax,%rcx,1)
    73d8:	b8 01 00 00 00       	mov    $0x1,%eax
    73dd:	5b                   	pop    %rbx
    73de:	c3                   	ret
    73df:	31 c0                	xor    %eax,%eax
    73e1:	5b                   	pop    %rbx
    73e2:	c3                   	ret
    73e3:	66 66 66 66 2e 0f 1f 	data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    73ea:	84 00 00 00 00 00 

00000000000073f0 <fwp_mem_realloc>:
    73f0:	41 57                	push   %r15
    73f2:	41 56                	push   %r14
    73f4:	53                   	push   %rbx
    73f5:	49 89 d6             	mov    %rdx,%r14
    73f8:	49 89 f7             	mov    %rsi,%r15
    73fb:	48 89 fb             	mov    %rdi,%rbx
    73fe:	48 89 d7             	mov    %rdx,%rdi
    7401:	e8 fa c0 ff ff       	call   3500 <fwp_alloc>
    7406:	48 85 db             	test   %rbx,%rbx
    7409:	74 23                	je     742e <fwp_mem_realloc+0x3e>
    740b:	4d 39 f7             	cmp    %r14,%r15
    740e:	4d 0f 42 f7          	cmovb  %r15,%r14
    7412:	48 89 c7             	mov    %rax,%rdi
    7415:	48 89 de             	mov    %rbx,%rsi
    7418:	4c 89 f2             	mov    %r14,%rdx
    741b:	49 89 c6             	mov    %rax,%r14
    741e:	e8 0d af ff ff       	call   2330 <memcpy@plt>
    7423:	48 89 df             	mov    %rbx,%rdi
    7426:	e8 25 df ff ff       	call   5350 <fwp_mem_free>
    742b:	4c 89 f0             	mov    %r14,%rax
    742e:	5b                   	pop    %rbx
    742f:	41 5e                	pop    %r14
    7431:	41 5f                	pop    %r15
    7433:	c3                   	ret
    7434:	66 66 66 2e 0f 1f 84 	data16 data16 cs nopw 0x0(%rax,%rax,1)
    743b:	00 00 00 00 00 

0000000000007440 <fwp_list_from>:
    7440:	41 56                	push   %r14
    7442:	53                   	push   %rbx
    7443:	50                   	push   %rax
    7444:	48 89 fb             	mov    %rdi,%rbx
    7447:	48 85 f6             	test   %rsi,%rsi
    744a:	74 28                	je     7474 <fwp_list_from+0x34>
    744c:	49 89 f6             	mov    %rsi,%r14
    744f:	31 c0                	xor    %eax,%eax
    7451:	66 66 66 66 66 66 2e 	data16 data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    7458:	0f 1f 84 00 00 00 00 
    745f:	00 
    7460:	4a 8b 7c f3 f8       	mov    -0x8(%rbx,%r14,8),%rdi
    7465:	48 89 c6             	mov    %rax,%rsi
    7468:	e8 63 06 00 00       	call   7ad0 <fwp_cons>
    746d:	49 ff ce             	dec    %r14
    7470:	75 ee                	jne    7460 <fwp_list_from+0x20>
    7472:	eb 02                	jmp    7476 <fwp_list_from+0x36>
    7474:	31 c0                	xor    %eax,%eax
    7476:	48 83 c4 08          	add    $0x8,%rsp
    747a:	5b                   	pop    %rbx
    747b:	41 5e                	pop    %r14
    747d:	c3                   	ret
    747e:	66 90                	xchg   %ax,%ax

0000000000007480 <fwp_pipe_out_end>:
    7480:	50                   	push   %rax
    7481:	8b 05 59 d9 01 00    	mov    0x1d959(%rip),%eax        # 24de0 <fwp_po_kind>
    7487:	83 f8 02             	cmp    $0x2,%eax
    748a:	74 1c                	je     74a8 <fwp_pipe_out_end+0x28>
    748c:	83 f8 01             	cmp    $0x1,%eax
    748f:	75 3d                	jne    74ce <fwp_pipe_out_end+0x4e>
    7491:	e8 4a 2b 00 00       	call   9fe0 <fwp_po_flush_sock>
    7496:	8b 3d 24 d8 00 00    	mov    0xd824(%rip),%edi        # 14cc0 <fwp_po_sock>
    749c:	be 01 00 00 00       	mov    $0x1,%esi
    74a1:	e8 ba ac ff ff       	call   2160 <shutdown@plt>
    74a6:	eb 35                	jmp    74dd <fwp_pipe_out_end+0x5d>
    74a8:	48 8b 35 41 d9 02 00 	mov    0x2d941(%rip),%rsi        # 34df0 <fwp_po_ring>
    74af:	c7 86 40 01 00 00 01 	movl   $0x1,0x140(%rsi)
    74b6:	00 00 00 
    74b9:	48 8d be c0 00 00 00 	lea    0xc0(%rsi),%rdi
    74c0:	48 81 c6 c4 00 00 00 	add    $0xc4,%rsi
    74c7:	e8 24 2d 00 00       	call   a1f0 <fwp_ring_wake>
    74cc:	eb 0f                	jmp    74dd <fwp_pipe_out_end+0x5d>
    74ce:	48 8b 05 db ba 00 00 	mov    0xbadb(%rip),%rax        # 12fb0 <stdout@GLIBC_2.2.5>
    74d5:	48 8b 38             	mov    (%rax),%rdi
    74d8:	e8 73 ae ff ff       	call   2350 <fflush@plt>
    74dd:	8b 3d d9 d7 00 00    	mov    0xd7d9(%rip),%edi        # 14cbc <fwp_po_listen>
    74e3:	85 ff                	test   %edi,%edi
    74e5:	78 0f                	js     74f6 <fwp_pipe_out_end+0x76>
    74e7:	e8 44 ad ff ff       	call   2230 <close@plt>
    74ec:	c7 05 c6 d7 00 00 ff 	movl   $0xffffffff,0xd7c6(%rip)        # 14cbc <fwp_po_listen>
    74f3:	ff ff ff 
    74f6:	58                   	pop    %rax
    74f7:	c3                   	ret
    74f8:	0f 1f 84 00 00 00 00 	nopl   0x0(%rax,%rax,1)
    74ff:	00 

0000000000007500 <fwp_valid_utf8>:
    7500:	48 85 f6             	test   %rsi,%rsi
    7503:	0f 84 48 01 00 00    	je     7651 <fwp_valid_utf8+0x151>
    7509:	53                   	push   %rbx
    750a:	31 c9                	xor    %ecx,%ecx
    750c:	eb 0e                	jmp    751c <fwp_valid_utf8+0x1c>
    750e:	66 90                	xchg   %ax,%ax
    7510:	48 ff c1             	inc    %rcx
    7513:	48 39 f1             	cmp    %rsi,%rcx
    7516:	0f 83 2e 01 00 00    	jae    764a <fwp_valid_utf8+0x14a>
    751c:	44 0f b6 14 0f       	movzbl (%rdi,%rcx,1),%r10d
    7521:	45 84 d2             	test   %r10b,%r10b
    7524:	79 ea                	jns    7510 <fwp_valid_utf8+0x10>
    7526:	41 8d 42 3e          	lea    0x3e(%r10),%eax
    752a:	3c 1e                	cmp    $0x1e,%al
    752c:	73 12                	jae    7540 <fwp_valid_utf8+0x40>
    752e:	ba 80 00 00 00       	mov    $0x80,%edx
    7533:	b8 01 00 00 00       	mov    $0x1,%eax
    7538:	41 b8 1f 00 00 00    	mov    $0x1f,%r8d
    753e:	eb 37                	jmp    7577 <fwp_valid_utf8+0x77>
    7540:	44 89 d0             	mov    %r10d,%eax
    7543:	24 f0                	and    $0xf0,%al
    7545:	3c e0                	cmp    $0xe0,%al
    7547:	75 12                	jne    755b <fwp_valid_utf8+0x5b>
    7549:	ba 00 08 00 00       	mov    $0x800,%edx
    754e:	b8 02 00 00 00       	mov    $0x2,%eax
    7553:	41 b8 0f 00 00 00    	mov    $0xf,%r8d
    7559:	eb 1c                	jmp    7577 <fwp_valid_utf8+0x77>
    755b:	41 8d 42 10          	lea    0x10(%r10),%eax
    755f:	3c 04                	cmp    $0x4,%al
    7561:	0f 87 f0 00 00 00    	ja     7657 <fwp_valid_utf8+0x157>
    7567:	ba 00 00 01 00       	mov    $0x10000,%edx
    756c:	b8 03 00 00 00       	mov    $0x3,%eax
    7571:	41 b8 07 00 00 00    	mov    $0x7,%r8d
    7577:	41 89 c1             	mov    %eax,%r9d
    757a:	4e 8d 1c 09          	lea    (%rcx,%r9,1),%r11
    757e:	31 c0                	xor    %eax,%eax
    7580:	49 39 f3             	cmp    %rsi,%r11
    7583:	0f 83 c6 00 00 00    	jae    764f <fwp_valid_utf8+0x14f>
    7589:	44 0f b6 5c 0f 01    	movzbl 0x1(%rdi,%rcx,1),%r11d
    758f:	44 89 db             	mov    %r11d,%ebx
    7592:	83 e3 c0             	and    $0xffffffc0,%ebx
    7595:	81 fb 80 00 00 00    	cmp    $0x80,%ebx
    759b:	0f 85 ae 00 00 00    	jne    764f <fwp_valid_utf8+0x14f>
    75a1:	45 21 d0             	and    %r10d,%r8d
    75a4:	45 8d 51 01          	lea    0x1(%r9),%r10d
    75a8:	44 89 c3             	mov    %r8d,%ebx
    75ab:	c1 e3 06             	shl    $0x6,%ebx
    75ae:	41 83 e3 3f          	and    $0x3f,%r11d
    75b2:	41 09 db             	or     %ebx,%r11d
    75b5:	41 83 fa 02          	cmp    $0x2,%r10d
    75b9:	75 0d                	jne    75c8 <fwp_valid_utf8+0xc8>
    75bb:	45 89 da             	mov    %r11d,%r10d
    75be:	41 39 d2             	cmp    %edx,%r10d
    75c1:	73 62                	jae    7625 <fwp_valid_utf8+0x125>
    75c3:	e9 87 00 00 00       	jmp    764f <fwp_valid_utf8+0x14f>
    75c8:	44 0f b6 44 0f 02    	movzbl 0x2(%rdi,%rcx,1),%r8d
    75ce:	44 89 c3             	mov    %r8d,%ebx
    75d1:	83 e3 c0             	and    $0xffffffc0,%ebx
    75d4:	81 fb 80 00 00 00    	cmp    $0x80,%ebx
    75da:	75 73                	jne    764f <fwp_valid_utf8+0x14f>
    75dc:	44 89 db             	mov    %r11d,%ebx
    75df:	c1 e3 06             	shl    $0x6,%ebx
    75e2:	41 83 e0 3f          	and    $0x3f,%r8d
    75e6:	41 09 d8             	or     %ebx,%r8d
    75e9:	41 83 fa 03          	cmp    $0x3,%r10d
    75ed:	75 0d                	jne    75fc <fwp_valid_utf8+0xfc>
    75ef:	45 89 c2             	mov    %r8d,%r10d
    75f2:	45 89 d8             	mov    %r11d,%r8d
    75f5:	41 39 d2             	cmp    %edx,%r10d
    75f8:	73 2b                	jae    7625 <fwp_valid_utf8+0x125>
    75fa:	eb 53                	jmp    764f <fwp_valid_utf8+0x14f>
    75fc:	44 0f b6 54 0f 03    	movzbl 0x3(%rdi,%rcx,1),%r10d
    7602:	45 89 d3             	mov    %r10d,%r11d
    7605:	41 83 e3 c0          	and    $0xffffffc0,%r11d
    7609:	41 81 fb 80 00 00 00 	cmp    $0x80,%r11d
    7610:	75 3d                	jne    764f <fwp_valid_utf8+0x14f>
    7612:	45 89 c3             	mov    %r8d,%r11d
    7615:	41 c1 e3 06          	shl    $0x6,%r11d
    7619:	41 83 e2 3f          	and    $0x3f,%r10d
    761d:	45 09 da             	or     %r11d,%r10d
    7620:	41 39 d2             	cmp    %edx,%r10d
    7623:	72 2a                	jb     764f <fwp_valid_utf8+0x14f>
    7625:	41 81 fa ff ff 10 00 	cmp    $0x10ffff,%r10d
    762c:	77 21                	ja     764f <fwp_valid_utf8+0x14f>
    762e:	41 83 e0 e0          	and    $0xffffffe0,%r8d
    7632:	41 81 f8 60 03 00 00 	cmp    $0x360,%r8d
    7639:	74 14                	je     764f <fwp_valid_utf8+0x14f>
    763b:	4c 01 c9             	add    %r9,%rcx
    763e:	48 ff c1             	inc    %rcx
    7641:	48 39 f1             	cmp    %rsi,%rcx
    7644:	0f 82 d2 fe ff ff    	jb     751c <fwp_valid_utf8+0x1c>
    764a:	b8 01 00 00 00       	mov    $0x1,%eax
    764f:	5b                   	pop    %rbx
    7650:	c3                   	ret
    7651:	b8 01 00 00 00       	mov    $0x1,%eax
    7656:	c3                   	ret
    7657:	31 c0                	xor    %eax,%eax
    7659:	5b                   	pop    %rbx
    765a:	c3                   	ret
    765b:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)

0000000000007660 <fwp_str_new>:
    7660:	41 57                	push   %r15
    7662:	41 56                	push   %r14
    7664:	53                   	push   %rbx
    7665:	48 89 f3             	mov    %rsi,%rbx
    7668:	49 89 fe             	mov    %rdi,%r14
    766b:	48 8d 7e 09          	lea    0x9(%rsi),%rdi
    766f:	e8 2c ee ff ff       	call   64a0 <fwp_alloc_leaf>
    7674:	49 89 c7             	mov    %rax,%r15
    7677:	48 89 18             	mov    %rbx,(%rax)
    767a:	48 8d 78 08          	lea    0x8(%rax),%rdi
    767e:	4c 89 f6             	mov    %r14,%rsi
    7681:	48 89 da             	mov    %rbx,%rdx
    7684:	e8 a7 ac ff ff       	call   2330 <memcpy@plt>
    7689:	41 c6 44 1f 08 00    	movb   $0x0,0x8(%r15,%rbx,1)
    768f:	4c 89 f8             	mov    %r15,%rax
    7692:	5b                   	pop    %rbx
    7693:	41 5e                	pop    %r14
    7695:	41 5f                	pop    %r15
    7697:	c3                   	ret
    7698:	0f 1f 84 00 00 00 00 	nopl   0x0(%rax,%rax,1)
    769f:	00 

00000000000076a0 <buf_putc>:
    76a0:	50                   	push   %rax
    76a1:	40 88 74 24 07       	mov    %sil,0x7(%rsp)
    76a6:	48 8d 74 24 07       	lea    0x7(%rsp),%rsi
    76ab:	ba 01 00 00 00       	mov    $0x1,%edx
    76b0:	e8 3b 00 00 00       	call   76f0 <buf_put>
    76b5:	58                   	pop    %rax
    76b6:	c3                   	ret
    76b7:	66 0f 1f 84 00 00 00 	nopw   0x0(%rax,%rax,1)
    76be:	00 00 

00000000000076c0 <buf_puts>:
    76c0:	41 56                	push   %r14
    76c2:	53                   	push   %rbx
    76c3:	50                   	push   %rax
    76c4:	48 89 f3             	mov    %rsi,%rbx
    76c7:	49 89 fe             	mov    %rdi,%r14
    76ca:	48 89 f7             	mov    %rsi,%rdi
    76cd:	e8 9e aa ff ff       	call   2170 <strlen@plt>
    76d2:	4c 89 f7             	mov    %r14,%rdi
    76d5:	48 89 de             	mov    %rbx,%rsi
    76d8:	48 89 c2             	mov    %rax,%rdx
    76db:	48 83 c4 08          	add    $0x8,%rsp
    76df:	5b                   	pop    %rbx
    76e0:	41 5e                	pop    %r14
    76e2:	eb 0c                	jmp    76f0 <buf_put>
    76e4:	66 66 66 2e 0f 1f 84 	data16 data16 cs nopw 0x0(%rax,%rax,1)
    76eb:	00 00 00 00 00 

00000000000076f0 <buf_put>:
    76f0:	41 57                	push   %r15
    76f2:	41 56                	push   %r14
    76f4:	53                   	push   %rbx
    76f5:	48 89 d3             	mov    %rdx,%rbx
    76f8:	49 89 f6             	mov    %rsi,%r14
    76fb:	49 89 ff             	mov    %rdi,%r15
    76fe:	48 89 d6             	mov    %rdx,%rsi
    7701:	e8 6a 00 00 00       	call   7770 <buf_grow>
    7706:	49 8b 3f             	mov    (%r15),%rdi
    7709:	49 03 7f 08          	add    0x8(%r15),%rdi
    770d:	4c 89 f6             	mov    %r14,%rsi
    7710:	48 89 da             	mov    %rbx,%rdx
    7713:	e8 18 ac ff ff       	call   2330 <memcpy@plt>
    7718:	49 03 5f 08          	add    0x8(%r15),%rbx
    771c:	49 89 5f 08          	mov    %rbx,0x8(%r15)
    7720:	49 8b 07             	mov    (%r15),%rax
    7723:	c6 04 18 00          	movb   $0x0,(%rax,%rbx,1)
    7727:	5b                   	pop    %rbx
    7728:	41 5e                	pop    %r14
    772a:	41 5f                	pop    %r15
    772c:	c3                   	ret
    772d:	0f 1f 00             	nopl   (%rax)

0000000000007730 <buf_to_str>:
    7730:	41 56                	push   %r14
    7732:	53                   	push   %rbx
    7733:	50                   	push   %rax
    7734:	48 89 fb             	mov    %rdi,%rbx
    7737:	48 8b 07             	mov    (%rdi),%rax
    773a:	48 8b 77 08          	mov    0x8(%rdi),%rsi
    773e:	48 85 c0             	test   %rax,%rax
    7741:	48 8d 3d 30 69 00 00 	lea    0x6930(%rip),%rdi        # e078 <exec_in_fp0+0xa38>
    7748:	48 0f 45 f8          	cmovne %rax,%rdi
    774c:	e8 0f ff ff ff       	call   7660 <fwp_str_new>
    7751:	49 89 c6             	mov    %rax,%r14
    7754:	48 8b 3b             	mov    (%rbx),%rdi
    7757:	e8 f4 a8 ff ff       	call   2050 <free@plt>
    775c:	4c 89 f0             	mov    %r14,%rax
    775f:	48 83 c4 08          	add    $0x8,%rsp
    7763:	5b                   	pop    %rbx
    7764:	41 5e                	pop    %r14
    7766:	c3                   	ret
    7767:	66 0f 1f 84 00 00 00 	nopw   0x0(%rax,%rax,1)
    776e:	00 00 

0000000000007770 <buf_grow>:
    7770:	41 56                	push   %r14
    7772:	53                   	push   %rbx
    7773:	50                   	push   %rax
    7774:	48 8b 47 08          	mov    0x8(%rdi),%rax
    7778:	48 83 f8 ff          	cmp    $0xffffffffffffffff,%rax
    777c:	74 73                	je     77f1 <buf_grow+0x81>
    777e:	48 c7 c1 fe ff ff ff 	mov    $0xfffffffffffffffe,%rcx
    7785:	48 29 c1             	sub    %rax,%rcx
    7788:	48 39 f1             	cmp    %rsi,%rcx
    778b:	72 64                	jb     77f1 <buf_grow+0x81>
    778d:	48 89 fb             	mov    %rdi,%rbx
    7790:	48 01 f0             	add    %rsi,%rax
    7793:	48 ff c0             	inc    %rax
    7796:	48 8b 4f 10          	mov    0x10(%rdi),%rcx
    779a:	48 39 c8             	cmp    %rcx,%rax
    779d:	76 4a                	jbe    77e9 <buf_grow+0x79>
    779f:	48 85 c9             	test   %rcx,%rcx
    77a2:	41 be 40 00 00 00    	mov    $0x40,%r14d
    77a8:	4c 0f 45 f1          	cmovne %rcx,%r14
    77ac:	49 39 c6             	cmp    %rax,%r14
    77af:	73 21                	jae    77d2 <buf_grow+0x62>
    77b1:	66 66 66 66 66 66 2e 	data16 data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    77b8:	0f 1f 84 00 00 00 00 
    77bf:	00 
    77c0:	4d 85 f6             	test   %r14,%r14
    77c3:	78 0a                	js     77cf <buf_grow+0x5f>
    77c5:	4d 01 f6             	add    %r14,%r14
    77c8:	49 39 c6             	cmp    %rax,%r14
    77cb:	72 f3                	jb     77c0 <buf_grow+0x50>
    77cd:	eb 03                	jmp    77d2 <buf_grow+0x62>
    77cf:	49 89 c6             	mov    %rax,%r14
    77d2:	48 8b 3b             	mov    (%rbx),%rdi
    77d5:	4c 89 f6             	mov    %r14,%rsi
    77d8:	e8 a3 ab ff ff       	call   2380 <realloc@plt>
    77dd:	48 85 c0             	test   %rax,%rax
    77e0:	74 0f                	je     77f1 <buf_grow+0x81>
    77e2:	48 89 03             	mov    %rax,(%rbx)
    77e5:	4c 89 73 10          	mov    %r14,0x10(%rbx)
    77e9:	48 83 c4 08          	add    $0x8,%rsp
    77ed:	5b                   	pop    %rbx
    77ee:	41 5e                	pop    %r14
    77f0:	c3                   	ret
    77f1:	48 8b 05 e0 b7 00 00 	mov    0xb7e0(%rip),%rax        # 12fd8 <stderr@GLIBC_2.2.5>
    77f8:	48 8b 08             	mov    (%rax),%rcx
    77fb:	48 8d 3d 60 5f 00 00 	lea    0x5f60(%rip),%rdi        # d762 <exec_in_fp0+0x122>
    7802:	be 13 00 00 00       	mov    $0x13,%esi
    7807:	ba 01 00 00 00       	mov    $0x1,%edx
    780c:	e8 8f ac ff ff       	call   24a0 <fwrite@plt>
    7811:	bf 66 00 00 00       	mov    $0x66,%edi
    7816:	e8 65 ac ff ff       	call   2480 <exit@plt>
    781b:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)

0000000000007820 <fwp_is_number_arg>:
    7820:	31 c0                	xor    %eax,%eax
    7822:	80 3f 2d             	cmpb   $0x2d,(%rdi)
    7825:	75 19                	jne    7840 <fwp_is_number_arg+0x20>
    7827:	0f b6 4f 01          	movzbl 0x1(%rdi),%ecx
    782b:	8d 51 d0             	lea    -0x30(%rcx),%edx
    782e:	b8 01 00 00 00       	mov    $0x1,%eax
    7833:	80 fa 0a             	cmp    $0xa,%dl
    7836:	72 08                	jb     7840 <fwp_is_number_arg+0x20>
    7838:	31 c0                	xor    %eax,%eax
    783a:	80 f9 2e             	cmp    $0x2e,%cl
    783d:	0f 94 c0             	sete   %al
    7840:	c3                   	ret
    7841:	66 66 66 66 66 66 2e 	data16 data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    7848:	0f 1f 84 00 00 00 00 
    784f:	00 

0000000000007850 <fwp_strf>:
    7850:	55                   	push   %rbp
    7851:	41 57                	push   %r15
    7853:	41 56                	push   %r14
    7855:	41 55                	push   %r13
    7857:	41 54                	push   %r12
    7859:	53                   	push   %rbx
    785a:	48 81 ec d8 00 00 00 	sub    $0xd8,%rsp
    7861:	48 89 fb             	mov    %rdi,%rbx
    7864:	48 89 74 24 28       	mov    %rsi,0x28(%rsp)
    7869:	48 89 54 24 30       	mov    %rdx,0x30(%rsp)
    786e:	48 89 4c 24 38       	mov    %rcx,0x38(%rsp)
    7873:	4c 89 44 24 40       	mov    %r8,0x40(%rsp)
    7878:	4c 89 4c 24 48       	mov    %r9,0x48(%rsp)
    787d:	84 c0                	test   %al,%al
    787f:	74 37                	je     78b8 <fwp_strf+0x68>
    7881:	0f 29 44 24 50       	movaps %xmm0,0x50(%rsp)
    7886:	0f 29 4c 24 60       	movaps %xmm1,0x60(%rsp)
    788b:	0f 29 54 24 70       	movaps %xmm2,0x70(%rsp)
    7890:	0f 29 9c 24 80 00 00 	movaps %xmm3,0x80(%rsp)
    7897:	00 
    7898:	0f 29 a4 24 90 00 00 	movaps %xmm4,0x90(%rsp)
    789f:	00 
    78a0:	0f 29 ac 24 a0 00 00 	movaps %xmm5,0xa0(%rsp)
    78a7:	00 
    78a8:	0f 29 b4 24 b0 00 00 	movaps %xmm6,0xb0(%rsp)
    78af:	00 
    78b0:	0f 29 bc 24 c0 00 00 	movaps %xmm7,0xc0(%rsp)
    78b7:	00 
    78b8:	48 8d 44 24 20       	lea    0x20(%rsp),%rax
    78bd:	48 89 44 24 10       	mov    %rax,0x10(%rsp)
    78c2:	48 8d 84 24 10 01 00 	lea    0x110(%rsp),%rax
    78c9:	00 
    78ca:	48 89 44 24 08       	mov    %rax,0x8(%rsp)
    78cf:	48 bd 08 00 00 00 30 	movabs $0x3000000008,%rbp
    78d6:	00 00 00 
    78d9:	48 89 2c 24          	mov    %rbp,(%rsp)
    78dd:	49 89 e6             	mov    %rsp,%r14
    78e0:	31 ff                	xor    %edi,%edi
    78e2:	31 f6                	xor    %esi,%esi
    78e4:	48 89 da             	mov    %rbx,%rdx
    78e7:	4c 89 f1             	mov    %r14,%rcx
    78ea:	e8 21 a8 ff ff       	call   2110 <vsnprintf@plt>
    78ef:	4c 63 f8             	movslq %eax,%r15
    78f2:	4d 8d 67 01          	lea    0x1(%r15),%r12
    78f6:	4c 89 e7             	mov    %r12,%rdi
    78f9:	e8 a2 eb ff ff       	call   64a0 <fwp_alloc_leaf>
    78fe:	49 89 c5             	mov    %rax,%r13
    7901:	48 89 2c 24          	mov    %rbp,(%rsp)
    7905:	48 8d 84 24 10 01 00 	lea    0x110(%rsp),%rax
    790c:	00 
    790d:	48 89 44 24 08       	mov    %rax,0x8(%rsp)
    7912:	48 8d 44 24 20       	lea    0x20(%rsp),%rax
    7917:	48 89 44 24 10       	mov    %rax,0x10(%rsp)
    791c:	4c 89 ef             	mov    %r13,%rdi
    791f:	4c 89 e6             	mov    %r12,%rsi
    7922:	48 89 da             	mov    %rbx,%rdx
    7925:	4c 89 f1             	mov    %r14,%rcx
    7928:	e8 e3 a7 ff ff       	call   2110 <vsnprintf@plt>
    792d:	4c 89 ef             	mov    %r13,%rdi
    7930:	4c 89 fe             	mov    %r15,%rsi
    7933:	e8 28 fd ff ff       	call   7660 <fwp_str_new>
    7938:	48 81 c4 d8 00 00 00 	add    $0xd8,%rsp
    793f:	5b                   	pop    %rbx
    7940:	41 5c                	pop    %r12
    7942:	41 5d                	pop    %r13
    7944:	41 5e                	pop    %r14
    7946:	41 5f                	pop    %r15
    7948:	5d                   	pop    %rbp
    7949:	c3                   	ret
    794a:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)

0000000000007950 <fwp_cli_value>:
    7950:	55                   	push   %rbp
    7951:	41 57                	push   %r15
    7953:	41 56                	push   %r14
    7955:	41 55                	push   %r13
    7957:	41 54                	push   %r12
    7959:	53                   	push   %rbx
    795a:	48 83 ec 58          	sub    $0x58,%rsp
    795e:	49 89 cf             	mov    %rcx,%r15
    7961:	48 89 d3             	mov    %rdx,%rbx
    7964:	49 89 f6             	mov    %rsi,%r14
    7967:	49 89 fc             	mov    %rdi,%r12
    796a:	e8 91 01 00 00       	call   7b00 <fwp_is_enum>
    796f:	85 c0                	test   %eax,%eax
    7971:	0f 84 ef 00 00 00    	je     7a66 <fwp_cli_value+0x116>
    7977:	48 89 5c 24 38       	mov    %rbx,0x38(%rsp)
    797c:	0f 57 c0             	xorps  %xmm0,%xmm0
    797f:	0f 29 44 24 40       	movaps %xmm0,0x40(%rsp)
    7984:	48 c7 44 24 50 00 00 	movq   $0x0,0x50(%rsp)
    798b:	00 00 
    798d:	0f 29 04 24          	movaps %xmm0,(%rsp)
    7991:	48 c7 44 24 10 00 00 	movq   $0x0,0x10(%rsp)
    7998:	00 00 
    799a:	48 8d 7c 24 40       	lea    0x40(%rsp),%rdi
    799f:	4c 89 e6             	mov    %r12,%rsi
    79a2:	4c 89 74 24 30       	mov    %r14,0x30(%rsp)
    79a7:	4c 89 f2             	mov    %r14,%rdx
    79aa:	e8 d1 01 00 00       	call   7b80 <fwp_loose>
    79af:	4c 8b 6c 24 40       	mov    0x40(%rsp),%r13
    79b4:	31 db                	xor    %ebx,%ebx
    79b6:	83 3d 23 d3 00 00 00 	cmpl   $0x0,0xd323(%rip)        # 14ce0 <d0+0x10>
    79bd:	41 be ff ff ff ff    	mov    $0xffffffff,%r14d
    79c3:	7e 7a                	jle    7a3f <fwp_cli_value+0xef>
    79c5:	48 8b 6c 24 48       	mov    0x48(%rsp),%rbp
    79ca:	48 85 ed             	test   %rbp,%rbp
    79cd:	74 70                	je     7a3f <fwp_cli_value+0xef>
    79cf:	4c 89 64 24 20       	mov    %r12,0x20(%rsp)
    79d4:	4c 89 7c 24 28       	mov    %r15,0x28(%rsp)
    79d9:	45 31 ff             	xor    %r15d,%r15d
    79dc:	48 89 e3             	mov    %rsp,%rbx
    79df:	90                   	nop
    79e0:	48 8b 05 01 d3 00 00 	mov    0xd301(%rip),%rax        # 14ce8 <d0+0x18>
    79e7:	4e 8b 24 f8          	mov    (%rax,%r15,8),%r12
    79eb:	4c 89 e7             	mov    %r12,%rdi
    79ee:	e8 7d a7 ff ff       	call   2170 <strlen@plt>
    79f3:	48 89 df             	mov    %rbx,%rdi
    79f6:	4c 89 e6             	mov    %r12,%rsi
    79f9:	48 89 c2             	mov    %rax,%rdx
    79fc:	e8 7f 01 00 00       	call   7b80 <fwp_loose>
    7a01:	48 39 6c 24 08       	cmp    %rbp,0x8(%rsp)
    7a06:	75 15                	jne    7a1d <fwp_cli_value+0xcd>
    7a08:	48 8b 3c 24          	mov    (%rsp),%rdi
    7a0c:	4c 89 ee             	mov    %r13,%rsi
    7a0f:	48 89 ea             	mov    %rbp,%rdx
    7a12:	e8 59 a9 ff ff       	call   2370 <bcmp@plt>
    7a17:	85 c0                	test   %eax,%eax
    7a19:	45 0f 44 f7          	cmove  %r15d,%r14d
    7a1d:	49 ff c7             	inc    %r15
    7a20:	48 63 05 b9 d2 00 00 	movslq 0xd2b9(%rip),%rax        # 14ce0 <d0+0x10>
    7a27:	49 39 c7             	cmp    %rax,%r15
    7a2a:	7d 05                	jge    7a31 <fwp_cli_value+0xe1>
    7a2c:	45 85 f6             	test   %r14d,%r14d
    7a2f:	78 af                	js     79e0 <fwp_cli_value+0x90>
    7a31:	48 8b 1c 24          	mov    (%rsp),%rbx
    7a35:	4c 8b 7c 24 28       	mov    0x28(%rsp),%r15
    7a3a:	4c 8b 64 24 20       	mov    0x20(%rsp),%r12
    7a3f:	4c 89 ef             	mov    %r13,%rdi
    7a42:	e8 09 a6 ff ff       	call   2050 <free@plt>
    7a47:	48 89 df             	mov    %rbx,%rdi
    7a4a:	e8 01 a6 ff ff       	call   2050 <free@plt>
    7a4f:	45 85 f6             	test   %r14d,%r14d
    7a52:	78 3e                	js     7a92 <fwp_cli_value+0x142>
    7a54:	44 89 f0             	mov    %r14d,%eax
    7a57:	48 8b 4c 24 38       	mov    0x38(%rsp),%rcx
    7a5c:	48 89 01             	mov    %rax,(%rcx)
    7a5f:	bb 01 00 00 00       	mov    $0x1,%ebx
    7a64:	eb 50                	jmp    7ab6 <fwp_cli_value+0x166>
    7a66:	4c 89 e7             	mov    %r12,%rdi
    7a69:	4c 89 f6             	mov    %r14,%rsi
    7a6c:	48 89 da             	mov    %rbx,%rdx
    7a6f:	e8 dc eb ff ff       	call   6650 <fwp_parse_text>
    7a74:	bb 01 00 00 00       	mov    $0x1,%ebx
    7a79:	85 c0                	test   %eax,%eax
    7a7b:	75 39                	jne    7ab6 <fwp_cli_value+0x166>
    7a7d:	48 8d 3d aa 67 00 00 	lea    0x67aa(%rip),%rdi        # e22e <exec_in_fp0+0xbee>
    7a84:	48 8d 0d f3 69 00 00 	lea    0x69f3(%rip),%rcx        # e47e <exec_in_fp0+0xe3e>
    7a8b:	31 db                	xor    %ebx,%ebx
    7a8d:	44 89 f6             	mov    %r14d,%esi
    7a90:	eb 17                	jmp    7aa9 <fwp_cli_value+0x159>
    7a92:	e8 69 01 00 00       	call   7c00 <fwp_choices>
    7a97:	48 8d 48 08          	lea    0x8(%rax),%rcx
    7a9b:	48 8d 3d 74 67 00 00 	lea    0x6774(%rip),%rdi        # e216 <exec_in_fp0+0xbd6>
    7aa2:	31 db                	xor    %ebx,%ebx
    7aa4:	48 8b 74 24 30       	mov    0x30(%rsp),%rsi
    7aa9:	4c 89 e2             	mov    %r12,%rdx
    7aac:	31 c0                	xor    %eax,%eax
    7aae:	e8 9d fd ff ff       	call   7850 <fwp_strf>
    7ab3:	49 89 07             	mov    %rax,(%r15)
    7ab6:	89 d8                	mov    %ebx,%eax
    7ab8:	48 83 c4 58          	add    $0x58,%rsp
    7abc:	5b                   	pop    %rbx
    7abd:	41 5c                	pop    %r12
    7abf:	41 5d                	pop    %r13
    7ac1:	41 5e                	pop    %r14
    7ac3:	41 5f                	pop    %r15
    7ac5:	5d                   	pop    %rbp
    7ac6:	c3                   	ret
    7ac7:	66 0f 1f 84 00 00 00 	nopw   0x0(%rax,%rax,1)
    7ace:	00 00 

0000000000007ad0 <fwp_cons>:
    7ad0:	48 83 ec 18          	sub    $0x18,%rsp
    7ad4:	48 89 3c 24          	mov    %rdi,(%rsp)
    7ad8:	48 89 74 24 08       	mov    %rsi,0x8(%rsp)
    7add:	48 89 e2             	mov    %rsp,%rdx
    7ae0:	bf 01 00 00 00       	mov    $0x1,%edi
    7ae5:	be 02 00 00 00       	mov    $0x2,%esi
    7aea:	e8 21 db ff ff       	call   5610 <fwp_data>
    7aef:	48 83 c4 18          	add    $0x18,%rsp
    7af3:	c3                   	ret
    7af4:	66 66 66 2e 0f 1f 84 	data16 data16 cs nopw 0x0(%rax,%rax,1)
    7afb:	00 00 00 00 00 

0000000000007b00 <fwp_is_enum>:
    7b00:	31 c0                	xor    %eax,%eax
    7b02:	83 3d c7 d1 00 00 0e 	cmpl   $0xe,0xd1c7(%rip)        # 14cd0 <d0>
    7b09:	75 67                	jne    7b72 <fwp_is_enum+0x72>
    7b0b:	53                   	push   %rbx
    7b0c:	8b 1d ce d1 00 00    	mov    0xd1ce(%rip),%ebx        # 14ce0 <d0+0x10>
    7b12:	85 db                	test   %ebx,%ebx
    7b14:	74 5b                	je     7b71 <fwp_is_enum+0x71>
    7b16:	48 8b 3d bb d1 00 00 	mov    0xd1bb(%rip),%rdi        # 14cd8 <d0+0x8>
    7b1d:	48 85 ff             	test   %rdi,%rdi
    7b20:	74 14                	je     7b36 <fwp_is_enum+0x36>
    7b22:	48 8d 35 1f 67 00 00 	lea    0x671f(%rip),%rsi        # e248 <exec_in_fp0+0xc08>
    7b29:	e8 a2 a7 ff ff       	call   22d0 <strcmp@plt>
    7b2e:	89 c1                	mov    %eax,%ecx
    7b30:	31 c0                	xor    %eax,%eax
    7b32:	85 c9                	test   %ecx,%ecx
    7b34:	74 3b                	je     7b71 <fwp_is_enum+0x71>
    7b36:	85 db                	test   %ebx,%ebx
    7b38:	7e 32                	jle    7b6c <fwp_is_enum+0x6c>
    7b3a:	48 8b 0d b7 d1 00 00 	mov    0xd1b7(%rip),%rcx        # 14cf8 <d0+0x28>
    7b41:	83 39 00             	cmpl   $0x0,(%rcx)
    7b44:	75 2b                	jne    7b71 <fwp_is_enum+0x71>
    7b46:	b8 01 00 00 00       	mov    $0x1,%eax
    7b4b:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)
    7b50:	48 89 c2             	mov    %rax,%rdx
    7b53:	48 39 c3             	cmp    %rax,%rbx
    7b56:	74 0a                	je     7b62 <fwp_is_enum+0x62>
    7b58:	48 8d 42 01          	lea    0x1(%rdx),%rax
    7b5c:	83 3c 91 00          	cmpl   $0x0,(%rcx,%rdx,4)
    7b60:	74 ee                	je     7b50 <fwp_is_enum+0x50>
    7b62:	31 c0                	xor    %eax,%eax
    7b64:	48 39 da             	cmp    %rbx,%rdx
    7b67:	0f 93 c0             	setae  %al
    7b6a:	eb 05                	jmp    7b71 <fwp_is_enum+0x71>
    7b6c:	b8 01 00 00 00       	mov    $0x1,%eax
    7b71:	5b                   	pop    %rbx
    7b72:	c3                   	ret
    7b73:	66 66 66 66 2e 0f 1f 	data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    7b7a:	84 00 00 00 00 00 

0000000000007b80 <fwp_loose>:
    7b80:	48 c7 47 08 00 00 00 	movq   $0x0,0x8(%rdi)
    7b87:	00 
    7b88:	48 85 d2             	test   %rdx,%rdx
    7b8b:	74 63                	je     7bf0 <fwp_loose+0x70>
    7b8d:	41 57                	push   %r15
    7b8f:	41 56                	push   %r14
    7b91:	41 54                	push   %r12
    7b93:	53                   	push   %rbx
    7b94:	50                   	push   %rax
    7b95:	48 89 d3             	mov    %rdx,%rbx
    7b98:	49 89 f6             	mov    %rsi,%r14
    7b9b:	49 89 ff             	mov    %rdi,%r15
    7b9e:	45 31 e4             	xor    %r12d,%r12d
    7ba1:	eb 15                	jmp    7bb8 <fwp_loose+0x38>
    7ba3:	66 66 66 66 2e 0f 1f 	data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    7baa:	84 00 00 00 00 00 
    7bb0:	49 ff c4             	inc    %r12
    7bb3:	4c 39 e3             	cmp    %r12,%rbx
    7bb6:	74 2d                	je     7be5 <fwp_loose+0x65>
    7bb8:	43 0f b6 04 26       	movzbl (%r14,%r12,1),%eax
    7bbd:	83 f8 2d             	cmp    $0x2d,%eax
    7bc0:	74 ee                	je     7bb0 <fwp_loose+0x30>
    7bc2:	83 f8 5f             	cmp    $0x5f,%eax
    7bc5:	74 e9                	je     7bb0 <fwp_loose+0x30>
    7bc7:	8d 48 bf             	lea    -0x41(%rax),%ecx
    7bca:	0f b6 d0             	movzbl %al,%edx
    7bcd:	0c 20                	or     $0x20,%al
    7bcf:	80 f9 1a             	cmp    $0x1a,%cl
    7bd2:	0f b6 c0             	movzbl %al,%eax
    7bd5:	0f 43 c2             	cmovae %edx,%eax
    7bd8:	0f be f0             	movsbl %al,%esi
    7bdb:	4c 89 ff             	mov    %r15,%rdi
    7bde:	e8 bd fa ff ff       	call   76a0 <buf_putc>
    7be3:	eb cb                	jmp    7bb0 <fwp_loose+0x30>
    7be5:	48 83 c4 08          	add    $0x8,%rsp
    7be9:	5b                   	pop    %rbx
    7bea:	41 5c                	pop    %r12
    7bec:	41 5e                	pop    %r14
    7bee:	41 5f                	pop    %r15
    7bf0:	c3                   	ret
    7bf1:	66 66 66 66 66 66 2e 	data16 data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    7bf8:	0f 1f 84 00 00 00 00 
    7bff:	00 

0000000000007c00 <fwp_choices>:
    7c00:	41 57                	push   %r15
    7c02:	41 56                	push   %r14
    7c04:	53                   	push   %rbx
    7c05:	48 83 ec 20          	sub    $0x20,%rsp
    7c09:	0f 57 c0             	xorps  %xmm0,%xmm0
    7c0c:	0f 29 04 24          	movaps %xmm0,(%rsp)
    7c10:	48 c7 44 24 10 00 00 	movq   $0x0,0x10(%rsp)
    7c17:	00 00 
    7c19:	83 3d c0 d0 00 00 00 	cmpl   $0x0,0xd0c0(%rip)        # 14ce0 <d0+0x10>
    7c20:	7e 5b                	jle    7c7d <fwp_choices+0x7d>
    7c22:	48 8b 05 bf d0 00 00 	mov    0xd0bf(%rip),%rax        # 14ce8 <d0+0x18>
    7c29:	48 8b 30             	mov    (%rax),%rsi
    7c2c:	48 89 e7             	mov    %rsp,%rdi
    7c2f:	e8 5c 00 00 00       	call   7c90 <fwp_kebab>
    7c34:	83 3d a5 d0 00 00 02 	cmpl   $0x2,0xd0a5(%rip)        # 14ce0 <d0+0x10>
    7c3b:	7c 40                	jl     7c7d <fwp_choices+0x7d>
    7c3d:	41 bf 01 00 00 00    	mov    $0x1,%r15d
    7c43:	48 8d 1d 03 66 00 00 	lea    0x6603(%rip),%rbx        # e24d <exec_in_fp0+0xc0d>
    7c4a:	49 89 e6             	mov    %rsp,%r14
    7c4d:	0f 1f 00             	nopl   (%rax)
    7c50:	4c 89 f7             	mov    %r14,%rdi
    7c53:	48 89 de             	mov    %rbx,%rsi
    7c56:	e8 65 fa ff ff       	call   76c0 <buf_puts>
    7c5b:	48 8b 05 86 d0 00 00 	mov    0xd086(%rip),%rax        # 14ce8 <d0+0x18>
    7c62:	4a 8b 34 f8          	mov    (%rax,%r15,8),%rsi
    7c66:	4c 89 f7             	mov    %r14,%rdi
    7c69:	e8 22 00 00 00       	call   7c90 <fwp_kebab>
    7c6e:	49 ff c7             	inc    %r15
    7c71:	48 63 05 68 d0 00 00 	movslq 0xd068(%rip),%rax        # 14ce0 <d0+0x10>
    7c78:	49 39 c7             	cmp    %rax,%r15
    7c7b:	7c d3                	jl     7c50 <fwp_choices+0x50>
    7c7d:	48 89 e7             	mov    %rsp,%rdi
    7c80:	e8 ab fa ff ff       	call   7730 <buf_to_str>
    7c85:	48 83 c4 20          	add    $0x20,%rsp
    7c89:	5b                   	pop    %rbx
    7c8a:	41 5e                	pop    %r14
    7c8c:	41 5f                	pop    %r15
    7c8e:	c3                   	ret
    7c8f:	90                   	nop

0000000000007c90 <fwp_kebab>:
    7c90:	41 57                	push   %r15
    7c92:	41 56                	push   %r14
    7c94:	53                   	push   %rbx
    7c95:	44 0f b6 3e          	movzbl (%rsi),%r15d
    7c99:	45 84 ff             	test   %r15b,%r15b
    7c9c:	74 71                	je     7d0f <fwp_kebab+0x7f>
    7c9e:	48 89 f3             	mov    %rsi,%rbx
    7ca1:	49 89 fe             	mov    %rdi,%r14
    7ca4:	48 ff c3             	inc    %rbx
    7ca7:	31 c0                	xor    %eax,%eax
    7ca9:	eb 36                	jmp    7ce1 <fwp_kebab+0x51>
    7cab:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)
    7cb0:	41 0f be f7          	movsbl %r15b,%esi
    7cb4:	4c 89 f7             	mov    %r14,%rdi
    7cb7:	e8 e4 f9 ff ff       	call   76a0 <buf_putc>
    7cbc:	41 8d 47 9f          	lea    -0x61(%r15),%eax
    7cc0:	3c 1a                	cmp    $0x1a,%al
    7cc2:	0f 92 c0             	setb   %al
    7cc5:	41 80 c7 d0          	add    $0xd0,%r15b
    7cc9:	41 80 ff 0a          	cmp    $0xa,%r15b
    7ccd:	0f 92 c1             	setb   %cl
    7cd0:	08 c1                	or     %al,%cl
    7cd2:	0f b6 c1             	movzbl %cl,%eax
    7cd5:	44 0f b6 3b          	movzbl (%rbx),%r15d
    7cd9:	48 ff c3             	inc    %rbx
    7cdc:	45 84 ff             	test   %r15b,%r15b
    7cdf:	74 2e                	je     7d0f <fwp_kebab+0x7f>
    7ce1:	41 8d 4f bf          	lea    -0x41(%r15),%ecx
    7ce5:	80 f9 19             	cmp    $0x19,%cl
    7ce8:	77 c6                	ja     7cb0 <fwp_kebab+0x20>
    7cea:	85 c0                	test   %eax,%eax
    7cec:	74 0d                	je     7cfb <fwp_kebab+0x6b>
    7cee:	4c 89 f7             	mov    %r14,%rdi
    7cf1:	be 2d 00 00 00       	mov    $0x2d,%esi
    7cf6:	e8 a5 f9 ff ff       	call   76a0 <buf_putc>
    7cfb:	41 80 cf 20          	or     $0x20,%r15b
    7cff:	41 0f be f7          	movsbl %r15b,%esi
    7d03:	4c 89 f7             	mov    %r14,%rdi
    7d06:	e8 95 f9 ff ff       	call   76a0 <buf_putc>
    7d0b:	31 c0                	xor    %eax,%eax
    7d0d:	eb c6                	jmp    7cd5 <fwp_kebab+0x45>
    7d0f:	5b                   	pop    %rbx
    7d10:	41 5e                	pop    %r14
    7d12:	41 5f                	pop    %r15
    7d14:	c3                   	ret
    7d15:	66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
    7d1c:	00 00 00 00 

0000000000007d20 <tp_value>:
    7d20:	55                   	push   %rbp
    7d21:	41 57                	push   %r15
    7d23:	41 56                	push   %r14
    7d25:	41 55                	push   %r13
    7d27:	41 54                	push   %r12
    7d29:	53                   	push   %rbx
    7d2a:	48 81 ec a8 01 00 00 	sub    $0x1a8,%rsp
    7d31:	48 89 cd             	mov    %rcx,%rbp
    7d34:	49 89 f6             	mov    %rsi,%r14
    7d37:	49 89 ff             	mov    %rdi,%r15
    7d3a:	85 d2                	test   %edx,%edx
    7d3c:	74 4c                	je     7d8a <tp_value+0x6a>
    7d3e:	41 83 3e 0c          	cmpl   $0xc,(%r14)
    7d42:	75 46                	jne    7d8a <tp_value+0x6a>
    7d44:	4d 8b 77 08          	mov    0x8(%r15),%r14
    7d48:	49 8b 47 10          	mov    0x10(%r15),%rax
    7d4c:	4d 8b 27             	mov    (%r15),%r12
    7d4f:	49 01 c4             	add    %rax,%r12
    7d52:	49 29 c6             	sub    %rax,%r14
    7d55:	4c 89 e7             	mov    %r12,%rdi
    7d58:	4c 89 f6             	mov    %r14,%rsi
    7d5b:	e8 a0 f7 ff ff       	call   7500 <fwp_valid_utf8>
    7d60:	85 c0                	test   %eax,%eax
    7d62:	0f 84 e9 07 00 00    	je     8551 <tp_value+0x831>
    7d68:	4c 89 e7             	mov    %r12,%rdi
    7d6b:	4c 89 f6             	mov    %r14,%rsi
    7d6e:	e8 ed f8 ff ff       	call   7660 <fwp_str_new>
    7d73:	48 89 45 00          	mov    %rax,0x0(%rbp)
    7d77:	49 8b 47 08          	mov    0x8(%r15),%rax
    7d7b:	49 89 47 10          	mov    %rax,0x10(%r15)
    7d7f:	41 bc 01 00 00 00    	mov    $0x1,%r12d
    7d85:	e9 ca 07 00 00       	jmp    8554 <tp_value+0x834>
    7d8a:	41 89 d5             	mov    %edx,%r13d
    7d8d:	4c 89 ff             	mov    %r15,%rdi
    7d90:	e8 bb 08 00 00       	call   8650 <tp_ws>
    7d95:	41 8b 06             	mov    (%r14),%eax
    7d98:	45 31 e4             	xor    %r12d,%r12d
    7d9b:	48 83 f8 15          	cmp    $0x15,%rax
    7d9f:	0f 87 af 07 00 00    	ja     8554 <tp_value+0x834>
    7da5:	48 8d 0d 2c 54 00 00 	lea    0x542c(%rip),%rcx        # d1d8 <_IO_stdin_used+0x1d8>
    7dac:	48 63 14 81          	movslq (%rcx,%rax,4),%rdx
    7db0:	48 01 ca             	add    %rcx,%rdx
    7db3:	ff e2                	jmp    *%rdx
    7db5:	4c 89 ff             	mov    %r15,%rdi
    7db8:	4c 89 f6             	mov    %r14,%rsi
    7dbb:	48 89 ea             	mov    %rbp,%rdx
    7dbe:	48 81 c4 a8 01 00 00 	add    $0x1a8,%rsp
    7dc5:	5b                   	pop    %rbx
    7dc6:	41 5c                	pop    %r12
    7dc8:	41 5d                	pop    %r13
    7dca:	41 5e                	pop    %r14
    7dcc:	41 5f                	pop    %r15
    7dce:	5d                   	pop    %rbp
    7dcf:	e9 cc 08 00 00       	jmp    86a0 <tp_int>
    7dd4:	41 0f 10 46 38       	movups 0x38(%r14),%xmm0
    7dd9:	0f 29 44 24 20       	movaps %xmm0,0x20(%rsp)
    7dde:	31 c9                	xor    %ecx,%ecx
    7de0:	83 f8 13             	cmp    $0x13,%eax
    7de3:	0f 94 c1             	sete   %cl
    7de6:	0f 57 c0             	xorps  %xmm0,%xmm0
    7de9:	0f 29 44 24 30       	movaps %xmm0,0x30(%rsp)
    7dee:	48 c7 44 24 40 00 00 	movq   $0x0,0x40(%rsp)
    7df5:	00 00 
    7df7:	89 4c 24 48          	mov    %ecx,0x48(%rsp)
    7dfb:	48 8d 05 60 64 00 00 	lea    0x6460(%rip),%rax        # e262 <exec_in_fp0+0xc22>
    7e02:	48 8d 35 5d 64 00 00 	lea    0x645d(%rip),%rsi        # e266 <exec_in_fp0+0xc26>
    7e09:	48 0f 44 f0          	cmove  %rax,%rsi
    7e0d:	4c 89 ff             	mov    %r15,%rdi
    7e10:	e8 fb 0b 00 00       	call   8a10 <tp_eat>
    7e15:	45 31 e4             	xor    %r12d,%r12d
    7e18:	85 c0                	test   %eax,%eax
    7e1a:	0f 84 34 07 00 00    	je     8554 <tp_value+0x834>
    7e20:	48 8d 35 15 65 00 00 	lea    0x6515(%rip),%rsi        # e33c <exec_in_fp0+0xcfc>
    7e27:	48 8d 15 36 58 00 00 	lea    0x5836(%rip),%rdx        # d664 <exec_in_fp0+0x24>
    7e2e:	48 8d 0d 7b 0e 00 00 	lea    0xe7b(%rip),%rcx        # 8cb0 <tp_kv_item>
    7e35:	4c 8d 44 24 20       	lea    0x20(%rsp),%r8
    7e3a:	4c 89 ff             	mov    %r15,%rdi
    7e3d:	e8 2e 0c 00 00       	call   8a70 <tp_list_of>
    7e42:	85 c0                	test   %eax,%eax
    7e44:	0f 84 a1 03 00 00    	je     81eb <tp_value+0x4cb>
    7e4a:	48 83 7c 24 38 00    	cmpq   $0x0,0x38(%rsp)
    7e50:	0f 84 2b 05 00 00    	je     8381 <tp_value+0x661>
    7e56:	48 8d 05 73 cf 01 00 	lea    0x1cf73(%rip),%rax        # 24dd0 <fwp_empty_map>
    7e5d:	31 db                	xor    %ebx,%ebx
    7e5f:	90                   	nop
    7e60:	48 8b 4c 24 30       	mov    0x30(%rsp),%rcx
    7e65:	48 8b 3c d9          	mov    (%rcx,%rbx,8),%rdi
    7e69:	48 8b 74 d9 08       	mov    0x8(%rcx,%rbx,8),%rsi
    7e6e:	49 8b 4e 38          	mov    0x38(%r14),%rcx
    7e72:	48 89 c2             	mov    %rax,%rdx
    7e75:	e8 d6 0e 00 00       	call   8d50 <fwp_p_map_insert>
    7e7a:	48 83 c3 02          	add    $0x2,%rbx
    7e7e:	48 3b 5c 24 38       	cmp    0x38(%rsp),%rbx
    7e83:	72 db                	jb     7e60 <tp_value+0x140>
    7e85:	e9 fe 04 00 00       	jmp    8388 <tp_value+0x668>
    7e8a:	0f 57 c0             	xorps  %xmm0,%xmm0
    7e8d:	0f 11 44 24 38       	movups %xmm0,0x38(%rsp)
    7e92:	0f 11 44 24 28       	movups %xmm0,0x28(%rsp)
    7e97:	48 c7 44 24 48 00 00 	movq   $0x0,0x48(%rsp)
    7e9e:	00 00 
    7ea0:	49 8b 4e 38          	mov    0x38(%r14),%rcx
    7ea4:	48 89 4c 24 20       	mov    %rcx,0x20(%rsp)
    7ea9:	83 f8 11             	cmp    $0x11,%eax
    7eac:	75 17                	jne    7ec5 <tp_value+0x1a5>
    7eae:	48 8d 35 a7 63 00 00 	lea    0x63a7(%rip),%rsi        # e25c <exec_in_fp0+0xc1c>
    7eb5:	4c 89 ff             	mov    %r15,%rdi
    7eb8:	e8 53 0b 00 00       	call   8a10 <tp_eat>
    7ebd:	85 c0                	test   %eax,%eax
    7ebf:	0f 84 8c 06 00 00    	je     8551 <tp_value+0x831>
    7ec5:	48 8d 35 5c 64 00 00 	lea    0x645c(%rip),%rsi        # e328 <exec_in_fp0+0xce8>
    7ecc:	48 8d 15 d8 57 00 00 	lea    0x57d8(%rip),%rdx        # d6ab <exec_in_fp0+0x6b>
    7ed3:	48 8d 0d e6 0c 00 00 	lea    0xce6(%rip),%rcx        # 8bc0 <tp_elem_item>
    7eda:	4c 8d 44 24 20       	lea    0x20(%rsp),%r8
    7edf:	4c 89 ff             	mov    %r15,%rdi
    7ee2:	e8 89 0b 00 00       	call   8a70 <tp_list_of>
    7ee7:	48 8b 7c 24 30       	mov    0x30(%rsp),%rdi
    7eec:	85 c0                	test   %eax,%eax
    7eee:	0f 84 06 03 00 00    	je     81fa <tp_value+0x4da>
    7ef4:	48 8b 74 24 38       	mov    0x38(%rsp),%rsi
    7ef9:	e8 42 f5 ff ff       	call   7440 <fwp_list_from>
    7efe:	49 89 c7             	mov    %rax,%r15
    7f01:	48 8b 7c 24 30       	mov    0x30(%rsp),%rdi
    7f06:	e8 45 d4 ff ff       	call   5350 <fwp_mem_free>
    7f0b:	41 83 3e 11          	cmpl   $0x11,(%r14)
    7f0f:	75 0b                	jne    7f1c <tp_value+0x1fc>
    7f11:	4c 89 ff             	mov    %r15,%rdi
    7f14:	e8 e7 0c 00 00       	call   8c00 <fwp_p_array_from_list>
    7f19:	49 89 c7             	mov    %rax,%r15
    7f1c:	4c 89 7d 00          	mov    %r15,0x0(%rbp)
    7f20:	e9 5a fe ff ff       	jmp    7d7f <tp_value+0x5f>
    7f25:	4c 89 ff             	mov    %r15,%rdi
    7f28:	4c 89 f6             	mov    %r14,%rsi
    7f2b:	48 89 ea             	mov    %rbp,%rdx
    7f2e:	48 81 c4 a8 01 00 00 	add    $0x1a8,%rsp
    7f35:	5b                   	pop    %rbx
    7f36:	41 5c                	pop    %r12
    7f38:	41 5d                	pop    %r13
    7f3a:	41 5e                	pop    %r14
    7f3c:	41 5f                	pop    %r15
    7f3e:	5d                   	pop    %rbp
    7f3f:	e9 bc 07 00 00       	jmp    8700 <tp_float>
    7f44:	45 85 ed             	test   %r13d,%r13d
    7f47:	0f 85 f7 fd ff ff    	jne    7d44 <tp_value+0x24>
    7f4d:	4c 89 ff             	mov    %r15,%rdi
    7f50:	48 89 ee             	mov    %rbp,%rsi
    7f53:	48 81 c4 a8 01 00 00 	add    $0x1a8,%rsp
    7f5a:	5b                   	pop    %rbx
    7f5b:	41 5c                	pop    %r12
    7f5d:	41 5d                	pop    %r13
    7f5f:	41 5e                	pop    %r14
    7f61:	41 5f                	pop    %r15
    7f63:	5d                   	pop    %rbp
    7f64:	e9 57 08 00 00       	jmp    87c0 <tp_quoted>
    7f69:	0f 57 c0             	xorps  %xmm0,%xmm0
    7f6c:	0f 29 44 24 40       	movaps %xmm0,0x40(%rsp)
    7f71:	0f 29 44 24 30       	movaps %xmm0,0x30(%rsp)
    7f76:	0f 29 44 24 20       	movaps %xmm0,0x20(%rsp)
    7f7b:	48 8d 35 ce 62 00 00 	lea    0x62ce(%rip),%rsi        # e250 <exec_in_fp0+0xc10>
    7f82:	4c 89 ff             	mov    %r15,%rdi
    7f85:	e8 86 0a 00 00       	call   8a10 <tp_eat>
    7f8a:	45 31 e4             	xor    %r12d,%r12d
    7f8d:	85 c0                	test   %eax,%eax
    7f8f:	0f 84 6f 02 00 00    	je     8204 <tp_value+0x4e4>
    7f95:	48 8d 35 8c 63 00 00 	lea    0x638c(%rip),%rsi        # e328 <exec_in_fp0+0xce8>
    7f9c:	48 8d 15 08 57 00 00 	lea    0x5708(%rip),%rdx        # d6ab <exec_in_fp0+0x6b>
    7fa3:	48 8d 0d 46 0b 00 00 	lea    0xb46(%rip),%rcx        # 8af0 <tp_byte_item>
    7faa:	4c 8d 44 24 20       	lea    0x20(%rsp),%r8
    7faf:	4c 89 ff             	mov    %r15,%rdi
    7fb2:	e8 b9 0a 00 00       	call   8a70 <tp_list_of>
    7fb7:	85 c0                	test   %eax,%eax
    7fb9:	0f 84 2c 02 00 00    	je     81eb <tp_value+0x4cb>
    7fbf:	0f 57 c0             	xorps  %xmm0,%xmm0
    7fc2:	0f 29 84 24 20 01 00 	movaps %xmm0,0x120(%rsp)
    7fc9:	00 
    7fca:	48 c7 84 24 30 01 00 	movq   $0x0,0x130(%rsp)
    7fd1:	00 00 00 00 00 
    7fd6:	48 83 7c 24 38 00    	cmpq   $0x0,0x38(%rsp)
    7fdc:	74 2d                	je     800b <tp_value+0x2eb>
    7fde:	31 db                	xor    %ebx,%ebx
    7fe0:	4c 8d b4 24 20 01 00 	lea    0x120(%rsp),%r14
    7fe7:	00 
    7fe8:	0f 1f 84 00 00 00 00 	nopl   0x0(%rax,%rax,1)
    7fef:	00 
    7ff0:	48 8b 44 24 30       	mov    0x30(%rsp),%rax
    7ff5:	0f be 34 d8          	movsbl (%rax,%rbx,8),%esi
    7ff9:	4c 89 f7             	mov    %r14,%rdi
    7ffc:	e8 9f f6 ff ff       	call   76a0 <buf_putc>
    8001:	48 ff c3             	inc    %rbx
    8004:	48 3b 5c 24 38       	cmp    0x38(%rsp),%rbx
    8009:	72 e5                	jb     7ff0 <tp_value+0x2d0>
    800b:	48 8b 7c 24 30       	mov    0x30(%rsp),%rdi
    8010:	e8 3b d3 ff ff       	call   5350 <fwp_mem_free>
    8015:	48 8d bc 24 20 01 00 	lea    0x120(%rsp),%rdi
    801c:	00 
    801d:	e8 0e f7 ff ff       	call   7730 <buf_to_str>
    8022:	48 89 45 00          	mov    %rax,0x0(%rbp)
    8026:	e9 54 fd ff ff       	jmp    7d7f <tp_value+0x5f>
    802b:	48 8d 74 24 20       	lea    0x20(%rsp),%rsi
    8030:	ba 00 01 00 00       	mov    $0x100,%edx
    8035:	4c 89 ff             	mov    %r15,%rdi
    8038:	e8 f3 0a 00 00       	call   8b30 <tp_token>
    803d:	45 31 e4             	xor    %r12d,%r12d
    8040:	48 83 f8 02          	cmp    $0x2,%rax
    8044:	0f 82 0a 05 00 00    	jb     8554 <tp_value+0x834>
    804a:	80 7c 24 20 30       	cmpb   $0x30,0x20(%rsp)
    804f:	0f 85 ff 04 00 00    	jne    8554 <tp_value+0x834>
    8055:	80 7c 24 21 74       	cmpb   $0x74,0x21(%rsp)
    805a:	0f 85 f4 04 00 00    	jne    8554 <tp_value+0x834>
    8060:	48 8d 48 fe          	lea    -0x2(%rax),%rcx
    8064:	49 63 56 48          	movslq 0x48(%r14),%rdx
    8068:	48 39 d1             	cmp    %rdx,%rcx
    806b:	0f 87 e3 04 00 00    	ja     8554 <tp_value+0x834>
    8071:	48 83 f8 03          	cmp    $0x3,%rax
    8075:	0f 82 21 05 00 00    	jb     859c <tp_value+0x87c>
    807b:	ba 02 00 00 00       	mov    $0x2,%edx
    8080:	31 c9                	xor    %ecx,%ecx
    8082:	e9 3d 01 00 00       	jmp    81c4 <tp_value+0x4a4>
    8087:	48 8d 74 24 20       	lea    0x20(%rsp),%rsi
    808c:	ba 10 00 00 00       	mov    $0x10,%edx
    8091:	4c 89 ff             	mov    %r15,%rdi
    8094:	e8 97 0a 00 00       	call   8b30 <tp_token>
    8099:	8b 44 24 20          	mov    0x20(%rsp),%eax
    809d:	89 c1                	mov    %eax,%ecx
    809f:	81 f1 2b 31 00 00    	xor    $0x312b,%ecx
    80a5:	0f b6 54 24 22       	movzbl 0x22(%rsp),%edx
    80aa:	66 09 ca             	or     %cx,%dx
    80ad:	41 bc 01 00 00 00    	mov    $0x1,%r12d
    80b3:	74 2d                	je     80e2 <tp_value+0x3c2>
    80b5:	66 83 f8 31          	cmp    $0x31,%ax
    80b9:	74 27                	je     80e2 <tp_value+0x3c2>
    80bb:	45 31 e4             	xor    %r12d,%r12d
    80be:	66 83 f8 30          	cmp    $0x30,%ax
    80c2:	74 1e                	je     80e2 <tp_value+0x3c2>
    80c4:	b8 2d 31 00 00       	mov    $0x312d,%eax
    80c9:	33 44 24 20          	xor    0x20(%rsp),%eax
    80cd:	0f b6 4c 24 22       	movzbl 0x22(%rsp),%ecx
    80d2:	66 09 c1             	or     %ax,%cx
    80d5:	0f 85 79 04 00 00    	jne    8554 <tp_value+0x834>
    80db:	49 c7 c4 ff ff ff ff 	mov    $0xffffffffffffffff,%r12
    80e2:	4c 89 65 00          	mov    %r12,0x0(%rbp)
    80e6:	e9 94 fc ff ff       	jmp    7d7f <tp_value+0x5f>
    80eb:	49 8b 7e 08          	mov    0x8(%r14),%rdi
    80ef:	48 85 ff             	test   %rdi,%rdi
    80f2:	0f 84 18 01 00 00    	je     8210 <tp_value+0x4f0>
    80f8:	48 8d 35 6b 61 00 00 	lea    0x616b(%rip),%rsi        # e26a <exec_in_fp0+0xc2a>
    80ff:	e8 cc a1 ff ff       	call   22d0 <strcmp@plt>
    8104:	85 c0                	test   %eax,%eax
    8106:	0f 84 23 03 00 00    	je     842f <tp_value+0x70f>
    810c:	4c 89 ff             	mov    %r15,%rdi
    810f:	e8 3c 05 00 00       	call   8650 <tp_ws>
    8114:	4d 8b 6e 08          	mov    0x8(%r14),%r13
    8118:	4c 89 ef             	mov    %r13,%rdi
    811b:	e8 50 a0 ff ff       	call   2170 <strlen@plt>
    8120:	49 89 c4             	mov    %rax,%r12
    8123:	49 8b 47 08          	mov    0x8(%r15),%rax
    8127:	49 8b 5f 10          	mov    0x10(%r15),%rbx
    812b:	48 29 d8             	sub    %rbx,%rax
    812e:	4c 39 e0             	cmp    %r12,%rax
    8131:	0f 82 c4 01 00 00    	jb     82fb <tp_value+0x5db>
    8137:	49 8b 3f             	mov    (%r15),%rdi
    813a:	48 01 df             	add    %rbx,%rdi
    813d:	4c 89 ee             	mov    %r13,%rsi
    8140:	4c 89 e2             	mov    %r12,%rdx
    8143:	e8 28 a2 ff ff       	call   2370 <bcmp@plt>
    8148:	85 c0                	test   %eax,%eax
    814a:	0f 85 ab 01 00 00    	jne    82fb <tp_value+0x5db>
    8150:	4c 01 e3             	add    %r12,%rbx
    8153:	49 89 5f 10          	mov    %rbx,0x10(%r15)
    8157:	e9 9f 01 00 00       	jmp    82fb <tp_value+0x5db>
    815c:	48 89 2c 24          	mov    %rbp,(%rsp)
    8160:	48 8d 74 24 20       	lea    0x20(%rsp),%rsi
    8165:	4c 89 ff             	mov    %r15,%rdi
    8168:	e8 d3 0e 00 00       	call   9040 <tp_ident>
    816d:	41 8b 5e 10          	mov    0x10(%r14),%ebx
    8171:	85 db                	test   %ebx,%ebx
    8173:	4c 89 74 24 08       	mov    %r14,0x8(%rsp)
    8178:	0f 8e 9c 01 00 00    	jle    831a <tp_value+0x5fa>
    817e:	4d 8b 66 18          	mov    0x18(%r14),%r12
    8182:	bd ff ff ff ff       	mov    $0xffffffff,%ebp
    8187:	45 31 f6             	xor    %r14d,%r14d
    818a:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)
    8190:	4b 8b 3c f4          	mov    (%r12,%r14,8),%rdi
    8194:	48 8d 74 24 20       	lea    0x20(%rsp),%rsi
    8199:	e8 32 a1 ff ff       	call   22d0 <strcmp@plt>
    819e:	85 c0                	test   %eax,%eax
    81a0:	41 0f 44 ee          	cmove  %r14d,%ebp
    81a4:	49 ff c6             	inc    %r14
    81a7:	4c 39 f3             	cmp    %r14,%rbx
    81aa:	75 e4                	jne    8190 <tp_value+0x470>
    81ac:	e9 6e 01 00 00       	jmp    831f <tp_value+0x5ff>
    81b1:	48 8d 0c 49          	lea    (%rcx,%rcx,2),%rcx
    81b5:	48 ff c9             	dec    %rcx
    81b8:	48 ff c2             	inc    %rdx
    81bb:	48 39 d0             	cmp    %rdx,%rax
    81be:	0f 84 da 03 00 00    	je     859e <tp_value+0x87e>
    81c4:	0f b6 74 14 20       	movzbl 0x20(%rsp,%rdx,1),%esi
    81c9:	83 fe 30             	cmp    $0x30,%esi
    81cc:	74 17                	je     81e5 <tp_value+0x4c5>
    81ce:	83 fe 2d             	cmp    $0x2d,%esi
    81d1:	74 de                	je     81b1 <tp_value+0x491>
    81d3:	83 fe 2b             	cmp    $0x2b,%esi
    81d6:	0f 85 75 03 00 00    	jne    8551 <tp_value+0x831>
    81dc:	48 8d 0c 49          	lea    (%rcx,%rcx,2),%rcx
    81e0:	48 ff c1             	inc    %rcx
    81e3:	eb d3                	jmp    81b8 <tp_value+0x498>
    81e5:	48 8d 0c 49          	lea    (%rcx,%rcx,2),%rcx
    81e9:	eb cd                	jmp    81b8 <tp_value+0x498>
    81eb:	48 8b 7c 24 30       	mov    0x30(%rsp),%rdi
    81f0:	e8 5b d1 ff ff       	call   5350 <fwp_mem_free>
    81f5:	e9 5a 03 00 00       	jmp    8554 <tp_value+0x834>
    81fa:	e8 51 d1 ff ff       	call   5350 <fwp_mem_free>
    81ff:	e9 4d 03 00 00       	jmp    8551 <tp_value+0x831>
    8204:	31 ff                	xor    %edi,%edi
    8206:	e8 45 d1 ff ff       	call   5350 <fwp_mem_free>
    820b:	e9 44 03 00 00       	jmp    8554 <tp_value+0x834>
    8210:	49 63 7e 10          	movslq 0x10(%r14),%rdi
    8214:	48 85 ff             	test   %rdi,%rdi
    8217:	0f 84 4c 03 00 00    	je     8569 <tp_value+0x849>
    821d:	41 83 7e 48 00       	cmpl   $0x0,0x48(%r14)
    8222:	0f 84 d3 00 00 00    	je     82fb <tp_value+0x5db>
    8228:	48 c1 e7 03          	shl    $0x3,%rdi
    822c:	e8 cf b2 ff ff       	call   3500 <fwp_alloc>
    8231:	48 89 c3             	mov    %rax,%rbx
    8234:	48 8d 35 3f 60 00 00 	lea    0x603f(%rip),%rsi        # e27a <exec_in_fp0+0xc3a>
    823b:	4c 89 ff             	mov    %r15,%rdi
    823e:	e8 cd 07 00 00       	call   8a10 <tp_eat>
    8243:	85 c0                	test   %eax,%eax
    8245:	0f 84 09 03 00 00    	je     8554 <tp_value+0x834>
    824b:	48 89 2c 24          	mov    %rbp,(%rsp)
    824f:	41 83 7e 10 00       	cmpl   $0x0,0x10(%r14)
    8254:	7e 77                	jle    82cd <tp_value+0x5ad>
    8256:	49 8b 46 20          	mov    0x20(%r14),%rax
    825a:	48 8b 30             	mov    (%rax),%rsi
    825d:	4c 89 ff             	mov    %r15,%rdi
    8260:	31 d2                	xor    %edx,%edx
    8262:	48 89 d9             	mov    %rbx,%rcx
    8265:	e8 b6 fa ff ff       	call   7d20 <tp_value>
    826a:	85 c0                	test   %eax,%eax
    826c:	0f 84 df 02 00 00    	je     8551 <tp_value+0x831>
    8272:	41 83 7e 10 02       	cmpl   $0x2,0x10(%r14)
    8277:	7c 54                	jl     82cd <tp_value+0x5ad>
    8279:	48 89 dd             	mov    %rbx,%rbp
    827c:	48 83 c5 08          	add    $0x8,%rbp
    8280:	41 bd 01 00 00 00    	mov    $0x1,%r13d
    8286:	4c 89 ff             	mov    %r15,%rdi
    8289:	48 8d 35 ec 5f 00 00 	lea    0x5fec(%rip),%rsi        # e27c <exec_in_fp0+0xc3c>
    8290:	e8 7b 07 00 00       	call   8a10 <tp_eat>
    8295:	85 c0                	test   %eax,%eax
    8297:	0f 84 b4 02 00 00    	je     8551 <tp_value+0x831>
    829d:	49 8b 46 20          	mov    0x20(%r14),%rax
    82a1:	4a 8b 34 e8          	mov    (%rax,%r13,8),%rsi
    82a5:	45 31 e4             	xor    %r12d,%r12d
    82a8:	4c 89 ff             	mov    %r15,%rdi
    82ab:	31 d2                	xor    %edx,%edx
    82ad:	48 89 e9             	mov    %rbp,%rcx
    82b0:	e8 6b fa ff ff       	call   7d20 <tp_value>
    82b5:	85 c0                	test   %eax,%eax
    82b7:	0f 84 97 02 00 00    	je     8554 <tp_value+0x834>
    82bd:	49 ff c5             	inc    %r13
    82c0:	49 63 46 10          	movslq 0x10(%r14),%rax
    82c4:	48 83 c5 08          	add    $0x8,%rbp
    82c8:	49 39 c5             	cmp    %rax,%r13
    82cb:	7c b9                	jl     8286 <tp_value+0x566>
    82cd:	48 8d 35 6b 60 00 00 	lea    0x606b(%rip),%rsi        # e33f <exec_in_fp0+0xcff>
    82d4:	4c 89 ff             	mov    %r15,%rdi
    82d7:	e8 34 07 00 00       	call   8a10 <tp_eat>
    82dc:	41 bc 00 00 00 00    	mov    $0x0,%r12d
    82e2:	85 c0                	test   %eax,%eax
    82e4:	0f 84 6a 02 00 00    	je     8554 <tp_value+0x834>
    82ea:	41 8b 7e 10          	mov    0x10(%r14),%edi
    82ee:	48 89 de             	mov    %rbx,%rsi
    82f1:	e8 0a af ff ff       	call   3200 <fwp_record>
    82f6:	e9 28 01 00 00       	jmp    8423 <tp_value+0x703>
    82fb:	4c 89 ff             	mov    %r15,%rdi
    82fe:	4c 89 f6             	mov    %r14,%rsi
    8301:	48 89 ea             	mov    %rbp,%rdx
    8304:	48 81 c4 a8 01 00 00 	add    $0x1a8,%rsp
    830b:	5b                   	pop    %rbx
    830c:	41 5c                	pop    %r12
    830e:	41 5d                	pop    %r13
    8310:	41 5e                	pop    %r14
    8312:	41 5f                	pop    %r15
    8314:	5d                   	pop    %rbp
    8315:	e9 56 0b 00 00       	jmp    8e70 <tp_record_body>
    831a:	bd ff ff ff ff       	mov    $0xffffffff,%ebp
    831f:	45 85 ed             	test   %r13d,%r13d
    8322:	74 7a                	je     839e <tp_value+0x67e>
    8324:	85 ed                	test   %ebp,%ebp
    8326:	48 8b 5c 24 08       	mov    0x8(%rsp),%rbx
    832b:	79 76                	jns    83a3 <tp_value+0x683>
    832d:	48 8b 7b 08          	mov    0x8(%rbx),%rdi
    8331:	45 31 e4             	xor    %r12d,%r12d
    8334:	48 85 ff             	test   %rdi,%rdi
    8337:	0f 84 17 02 00 00    	je     8554 <tp_value+0x834>
    833d:	48 8d 35 04 5f 00 00 	lea    0x5f04(%rip),%rsi        # e248 <exec_in_fp0+0xc08>
    8344:	e8 87 9f ff ff       	call   22d0 <strcmp@plt>
    8349:	85 c0                	test   %eax,%eax
    834b:	0f 85 03 02 00 00    	jne    8554 <tp_value+0x834>
    8351:	8b 44 24 20          	mov    0x20(%rsp),%eax
    8355:	89 c1                	mov    %eax,%ecx
    8357:	81 f1 74 72 75 65    	xor    $0x65757274,%ecx
    835d:	0f b6 54 24 24       	movzbl 0x24(%rsp),%edx
    8362:	09 ca                	or     %ecx,%edx
    8364:	b9 01 00 00 00       	mov    $0x1,%ecx
    8369:	0f 44 e9             	cmove  %ecx,%ebp
    836c:	35 66 61 6c 73       	xor    $0x736c6166,%eax
    8371:	0f b7 4c 24 24       	movzwl 0x24(%rsp),%ecx
    8376:	83 f1 65             	xor    $0x65,%ecx
    8379:	09 c1                	or     %eax,%ecx
    837b:	75 26                	jne    83a3 <tp_value+0x683>
    837d:	31 ed                	xor    %ebp,%ebp
    837f:	eb 2a                	jmp    83ab <tp_value+0x68b>
    8381:	48 8d 05 48 ca 01 00 	lea    0x1ca48(%rip),%rax        # 24dd0 <fwp_empty_map>
    8388:	48 8b 7c 24 30       	mov    0x30(%rsp),%rdi
    838d:	48 89 c3             	mov    %rax,%rbx
    8390:	e8 bb cf ff ff       	call   5350 <fwp_mem_free>
    8395:	48 89 5d 00          	mov    %rbx,0x0(%rbp)
    8399:	e9 e1 f9 ff ff       	jmp    7d7f <tp_value+0x5f>
    839e:	48 8b 5c 24 08       	mov    0x8(%rsp),%rbx
    83a3:	85 ed                	test   %ebp,%ebp
    83a5:	0f 88 a6 01 00 00    	js     8551 <tp_value+0x831>
    83ab:	48 8b 43 28          	mov    0x28(%rbx),%rax
    83af:	41 89 ed             	mov    %ebp,%r13d
    83b2:	4a 63 1c a8          	movslq (%rax,%r13,4),%rbx
    83b6:	48 8d 3c dd 08 00 00 	lea    0x8(,%rbx,8),%rdi
    83bd:	00 
    83be:	e8 3d b1 ff ff       	call   3500 <fwp_alloc>
    83c3:	48 89 c5             	mov    %rax,%rbp
    83c6:	89 d8                	mov    %ebx,%eax
    83c8:	48 89 44 24 10       	mov    %rax,0x10(%rsp)
    83cd:	48 85 db             	test   %rbx,%rbx
    83d0:	7e 41                	jle    8413 <tp_value+0x6f3>
    83d2:	48 8b 44 24 10       	mov    0x10(%rsp),%rax
    83d7:	48 8d 1c c5 00 00 00 	lea    0x0(,%rax,8),%rbx
    83de:	00 
    83df:	45 31 e4             	xor    %r12d,%r12d
    83e2:	45 31 f6             	xor    %r14d,%r14d
    83e5:	48 8b 44 24 08       	mov    0x8(%rsp),%rax
    83ea:	48 8b 40 30          	mov    0x30(%rax),%rax
    83ee:	4a 8b 04 e8          	mov    (%rax,%r13,8),%rax
    83f2:	4a 8b 34 30          	mov    (%rax,%r14,1),%rsi
    83f6:	49 8d 14 2e          	lea    (%r14,%rbp,1),%rdx
    83fa:	4c 89 ff             	mov    %r15,%rdi
    83fd:	e8 fe 0c 00 00       	call   9100 <tp_atom>
    8402:	85 c0                	test   %eax,%eax
    8404:	0f 84 4a 01 00 00    	je     8554 <tp_value+0x834>
    840a:	49 83 c6 08          	add    $0x8,%r14
    840e:	4c 39 f3             	cmp    %r14,%rbx
    8411:	75 d2                	jne    83e5 <tp_value+0x6c5>
    8413:	44 89 ef             	mov    %r13d,%edi
    8416:	48 8b 74 24 10       	mov    0x10(%rsp),%rsi
    841b:	48 89 ea             	mov    %rbp,%rdx
    841e:	e8 ed d1 ff ff       	call   5610 <fwp_data>
    8423:	48 8b 0c 24          	mov    (%rsp),%rcx
    8427:	48 89 01             	mov    %rax,(%rcx)
    842a:	e9 50 f9 ff ff       	jmp    7d7f <tp_value+0x5f>
    842f:	48 89 2c 24          	mov    %rbp,(%rsp)
    8433:	48 8d 74 24 20       	lea    0x20(%rsp),%rsi
    8438:	ba 80 00 00 00       	mov    $0x80,%edx
    843d:	4c 89 ff             	mov    %r15,%rdi
    8440:	48 89 f3             	mov    %rsi,%rbx
    8443:	e8 e8 06 00 00       	call   8b30 <tp_token>
    8448:	49 89 c7             	mov    %rax,%r15
    844b:	4c 8d 24 04          	lea    (%rsp,%rax,1),%r12
    844f:	49 83 c4 20          	add    $0x20,%r12
    8453:	41 be 08 00 00 00    	mov    $0x8,%r14d
    8459:	eb 0e                	jmp    8469 <tp_value+0x749>
    845b:	49 83 c6 10          	add    $0x10,%r14
    845f:	49 83 fe 68          	cmp    $0x68,%r14
    8463:	0f 84 e8 00 00 00    	je     8551 <tp_value+0x831>
    8469:	48 8d 05 30 a8 00 00 	lea    0xa830(%rip),%rax        # 12ca0 <tp_value.units>
    8470:	49 8b 6c 06 f8       	mov    -0x8(%r14,%rax,1),%rbp
    8475:	48 89 ef             	mov    %rbp,%rdi
    8478:	e8 f3 9c ff ff       	call   2170 <strlen@plt>
    847d:	4d 89 fd             	mov    %r15,%r13
    8480:	49 29 c5             	sub    %rax,%r13
    8483:	76 d6                	jbe    845b <tp_value+0x73b>
    8485:	4c 89 e7             	mov    %r12,%rdi
    8488:	48 29 c7             	sub    %rax,%rdi
    848b:	48 89 ee             	mov    %rbp,%rsi
    848e:	e8 3d 9e ff ff       	call   22d0 <strcmp@plt>
    8493:	85 c0                	test   %eax,%eax
    8495:	75 c4                	jne    845b <tp_value+0x73b>
    8497:	48 8d ac 24 20 01 00 	lea    0x120(%rsp),%rbp
    849e:	00 
    849f:	48 89 ef             	mov    %rbp,%rdi
    84a2:	48 89 de             	mov    %rbx,%rsi
    84a5:	4c 89 ea             	mov    %r13,%rdx
    84a8:	e8 83 9e ff ff       	call   2330 <memcpy@plt>
    84ad:	42 c6 84 2c 20 01 00 	movb   $0x0,0x120(%rsp,%r13,1)
    84b4:	00 00 
    84b6:	48 89 ef             	mov    %rbp,%rdi
    84b9:	4c 89 ee             	mov    %r13,%rsi
    84bc:	e8 6f 09 00 00       	call   8e30 <fwp_valid_int>
    84c1:	85 c0                	test   %eax,%eax
    84c3:	74 96                	je     845b <tp_value+0x73b>
    84c5:	0f b6 b4 24 20 01 00 	movzbl 0x120(%rsp),%esi
    84cc:	00 
    84cd:	8d 4e d5             	lea    -0x2b(%rsi),%ecx
    84d0:	31 c0                	xor    %eax,%eax
    84d2:	f6 c1 fd             	test   $0xfd,%cl
    84d5:	0f 94 c0             	sete   %al
    84d8:	44 0f b6 94 04 20 01 	movzbl 0x120(%rsp,%rax,1),%r10d
    84df:	00 00 
    84e1:	45 31 e4             	xor    %r12d,%r12d
    84e4:	45 84 d2             	test   %r10b,%r10b
    84e7:	0f 84 ba 00 00 00    	je     85a7 <tp_value+0x887>
    84ed:	48 8d 8c 24 20 01 00 	lea    0x120(%rsp),%rcx
    84f4:	00 
    84f5:	48 01 c1             	add    %rax,%rcx
    84f8:	48 ff c1             	inc    %rcx
    84fb:	31 c0                	xor    %eax,%eax
    84fd:	bf 0a 00 00 00       	mov    $0xa,%edi
    8502:	49 b9 00 00 00 00 00 	movabs $0x8000000000000000,%r9
    8509:	00 00 80 
    850c:	45 31 c0             	xor    %r8d,%r8d
    850f:	48 8b 1c 24          	mov    (%rsp),%rbx
    8513:	48 f7 e7             	mul    %rdi
    8516:	4f 8d 04 80          	lea    (%r8,%r8,4),%r8
    851a:	4a 8d 14 42          	lea    (%rdx,%r8,2),%rdx
    851e:	45 0f be c2          	movsbl %r10b,%r8d
    8522:	41 83 c0 d0          	add    $0xffffffd0,%r8d
    8526:	4d 63 d0             	movslq %r8d,%r10
    8529:	4d 89 d0             	mov    %r10,%r8
    852c:	49 c1 f8 3f          	sar    $0x3f,%r8
    8530:	4c 01 d0             	add    %r10,%rax
    8533:	49 11 d0             	adc    %rdx,%r8
    8536:	49 39 c1             	cmp    %rax,%r9
    8539:	ba 00 00 00 00       	mov    $0x0,%edx
    853e:	4c 19 c2             	sbb    %r8,%rdx
    8541:	7c 0e                	jl     8551 <tp_value+0x831>
    8543:	44 0f b6 11          	movzbl (%rcx),%r10d
    8547:	48 ff c1             	inc    %rcx
    854a:	45 84 d2             	test   %r10b,%r10b
    854d:	75 c4                	jne    8513 <tp_value+0x7f3>
    854f:	eb 5f                	jmp    85b0 <tp_value+0x890>
    8551:	45 31 e4             	xor    %r12d,%r12d
    8554:	44 89 e0             	mov    %r12d,%eax
    8557:	48 81 c4 a8 01 00 00 	add    $0x1a8,%rsp
    855e:	5b                   	pop    %rbx
    855f:	41 5c                	pop    %r12
    8561:	41 5d                	pop    %r13
    8563:	41 5e                	pop    %r14
    8565:	41 5f                	pop    %r15
    8567:	5d                   	pop    %rbp
    8568:	c3                   	ret
    8569:	48 8d 35 0a 5d 00 00 	lea    0x5d0a(%rip),%rsi        # e27a <exec_in_fp0+0xc3a>
    8570:	4c 89 ff             	mov    %r15,%rdi
    8573:	e8 98 04 00 00       	call   8a10 <tp_eat>
    8578:	85 c0                	test   %eax,%eax
    857a:	74 d8                	je     8554 <tp_value+0x834>
    857c:	48 8d 35 bc 5d 00 00 	lea    0x5dbc(%rip),%rsi        # e33f <exec_in_fp0+0xcff>
    8583:	4c 89 ff             	mov    %r15,%rdi
    8586:	e8 85 04 00 00       	call   8a10 <tp_eat>
    858b:	85 c0                	test   %eax,%eax
    858d:	74 c5                	je     8554 <tp_value+0x834>
    858f:	48 c7 45 00 00 00 00 	movq   $0x0,0x0(%rbp)
    8596:	00 
    8597:	e9 e3 f7 ff ff       	jmp    7d7f <tp_value+0x5f>
    859c:	31 c9                	xor    %ecx,%ecx
    859e:	48 89 4d 00          	mov    %rcx,0x0(%rbp)
    85a2:	e9 d8 f7 ff ff       	jmp    7d7f <tp_value+0x5f>
    85a7:	31 c0                	xor    %eax,%eax
    85a9:	45 31 c0             	xor    %r8d,%r8d
    85ac:	48 8b 1c 24          	mov    (%rsp),%rbx
    85b0:	48 89 c1             	mov    %rax,%rcx
    85b3:	48 f7 d9             	neg    %rcx
    85b6:	bf 00 00 00 00       	mov    $0x0,%edi
    85bb:	4c 19 c7             	sbb    %r8,%rdi
    85be:	40 80 fe 2d          	cmp    $0x2d,%sil
    85c2:	49 0f 45 f8          	cmovne %r8,%rdi
    85c6:	48 0f 45 c8          	cmovne %rax,%rcx
    85ca:	48 b8 ff ff ff ff ff 	movabs $0x7fffffffffffffff,%rax
    85d1:	ff ff 7f 
    85d4:	48 39 c8             	cmp    %rcx,%rax
    85d7:	b8 00 00 00 00       	mov    $0x0,%eax
    85dc:	48 19 f8             	sbb    %rdi,%rax
    85df:	0f 8c 6f ff ff ff    	jl     8554 <tp_value+0x834>
    85e5:	48 8d 05 b4 a6 00 00 	lea    0xa6b4(%rip),%rax        # 12ca0 <tp_value.units>
    85ec:	49 8b 34 06          	mov    (%r14,%rax,1),%rsi
    85f0:	48 89 c8             	mov    %rcx,%rax
    85f3:	48 f7 e6             	mul    %rsi
    85f6:	48 0f af fe          	imul   %rsi,%rdi
    85fa:	48 c1 fe 3f          	sar    $0x3f,%rsi
    85fe:	48 0f af f1          	imul   %rcx,%rsi
    8602:	48 01 d6             	add    %rdx,%rsi
    8605:	48 01 f7             	add    %rsi,%rdi
    8608:	48 b9 00 00 00 00 00 	movabs $0x8000000000000000,%rcx
    860f:	00 00 80 
    8612:	48 01 c1             	add    %rax,%rcx
    8615:	48 83 d7 ff          	adc    $0xffffffffffffffff,%rdi
    8619:	48 83 ff ff          	cmp    $0xffffffffffffffff,%rdi
    861d:	0f 85 31 ff ff ff    	jne    8554 <tp_value+0x834>
    8623:	48 89 44 24 18       	mov    %rax,0x18(%rsp)
    8628:	41 bc 01 00 00 00    	mov    $0x1,%r12d
    862e:	48 8d 74 24 18       	lea    0x18(%rsp),%rsi
    8633:	bf 01 00 00 00       	mov    $0x1,%edi
    8638:	e8 c3 ab ff ff       	call   3200 <fwp_record>
    863d:	48 89 03             	mov    %rax,(%rbx)
    8640:	e9 0f ff ff ff       	jmp    8554 <tp_value+0x834>
    8645:	66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
    864c:	00 00 00 00 

0000000000008650 <tp_ws>:
    8650:	48 8b 47 08          	mov    0x8(%rdi),%rax
    8654:	48 8b 4f 10          	mov    0x10(%rdi),%rcx
    8658:	48 39 c1             	cmp    %rax,%rcx
    865b:	73 39                	jae    8696 <tp_ws+0x46>
    865d:	48 8b 17             	mov    (%rdi),%rdx
    8660:	48 f7 d8             	neg    %rax
    8663:	48 ff c1             	inc    %rcx
    8666:	48 be 00 26 00 00 01 	movabs $0x100002600,%rsi
    866d:	00 00 00 
    8670:	44 0f b6 44 0a ff    	movzbl -0x1(%rdx,%rcx,1),%r8d
    8676:	49 83 f8 20          	cmp    $0x20,%r8
    867a:	77 1a                	ja     8696 <tp_ws+0x46>
    867c:	4c 0f a3 c6          	bt     %r8,%rsi
    8680:	73 14                	jae    8696 <tp_ws+0x46>
    8682:	48 89 4f 10          	mov    %rcx,0x10(%rdi)
    8686:	4c 8d 04 08          	lea    (%rax,%rcx,1),%r8
    868a:	49 ff c0             	inc    %r8
    868d:	48 ff c1             	inc    %rcx
    8690:	49 83 f8 01          	cmp    $0x1,%r8
    8694:	75 da                	jne    8670 <tp_ws+0x20>
    8696:	c3                   	ret
    8697:	66 0f 1f 84 00 00 00 	nopw   0x0(%rax,%rax,1)
    869e:	00 00 

00000000000086a0 <tp_int>:
    86a0:	55                   	push   %rbp
    86a1:	41 56                	push   %r14
    86a3:	53                   	push   %rbx
    86a4:	48 81 ec 80 00 00 00 	sub    $0x80,%rsp
    86ab:	48 89 d3             	mov    %rdx,%rbx
    86ae:	49 89 f6             	mov    %rsi,%r14
    86b1:	48 89 e6             	mov    %rsp,%rsi
    86b4:	ba 80 00 00 00       	mov    $0x80,%edx
    86b9:	e8 72 04 00 00       	call   8b30 <tp_token>
    86be:	31 ed                	xor    %ebp,%ebp
    86c0:	48 83 f8 7f          	cmp    $0x7f,%rax
    86c4:	77 28                	ja     86ee <tp_int+0x4e>
    86c6:	48 89 e7             	mov    %rsp,%rdi
    86c9:	e8 d2 0a 00 00       	call   91a0 <fwp_cstr>
    86ce:	41 8b 36             	mov    (%r14),%esi
    86d1:	41 8b 56 48          	mov    0x48(%r14),%edx
    86d5:	48 89 c7             	mov    %rax,%rdi
    86d8:	e8 e3 0a 00 00       	call   91c0 <fwp_p_parse_int>
    86dd:	48 85 c0             	test   %rax,%rax
    86e0:	74 0c                	je     86ee <tp_int+0x4e>
    86e2:	48 8b 40 08          	mov    0x8(%rax),%rax
    86e6:	48 89 03             	mov    %rax,(%rbx)
    86e9:	bd 01 00 00 00       	mov    $0x1,%ebp
    86ee:	89 e8                	mov    %ebp,%eax
    86f0:	48 81 c4 80 00 00 00 	add    $0x80,%rsp
    86f7:	5b                   	pop    %rbx
    86f8:	41 5e                	pop    %r14
    86fa:	5d                   	pop    %rbp
    86fb:	c3                   	ret
    86fc:	0f 1f 40 00          	nopl   0x0(%rax)

0000000000008700 <tp_float>:
    8700:	41 56                	push   %r14
    8702:	53                   	push   %rbx
    8703:	48 81 ec 88 00 00 00 	sub    $0x88,%rsp
    870a:	48 89 d3             	mov    %rdx,%rbx
    870d:	49 89 f6             	mov    %rsi,%r14
    8710:	48 89 e6             	mov    %rsp,%rsi
    8713:	ba 80 00 00 00       	mov    $0x80,%edx
    8718:	e8 13 04 00 00       	call   8b30 <tp_token>
    871d:	31 c9                	xor    %ecx,%ecx
    871f:	48 83 f8 7f          	cmp    $0x7f,%rax
    8723:	0f 87 84 00 00 00    	ja     87ad <tp_float+0xad>
    8729:	8b 0c 24             	mov    (%rsp),%ecx
    872c:	81 f9 69 6e 66 00    	cmp    $0x666e69,%ecx
    8732:	75 0a                	jne    873e <tp_float+0x3e>
    8734:	f2 0f 10 05 ec 48 00 	movsd  0x48ec(%rip),%xmm0        # d028 <_IO_stdin_used+0x28>
    873b:	00 
    873c:	eb 5f                	jmp    879d <tp_float+0x9d>
    873e:	ba 2d 69 6e 66       	mov    $0x666e692d,%edx
    8743:	33 14 24             	xor    (%rsp),%edx
    8746:	0f b6 74 24 04       	movzbl 0x4(%rsp),%esi
    874b:	09 d6                	or     %edx,%esi
    874d:	74 12                	je     8761 <tp_float+0x61>
    874f:	81 f9 4e 61 4e 00    	cmp    $0x4e614e,%ecx
    8755:	75 14                	jne    876b <tp_float+0x6b>
    8757:	f2 0f 10 05 d9 48 00 	movsd  0x48d9(%rip),%xmm0        # d038 <_IO_stdin_used+0x38>
    875e:	00 
    875f:	eb 3c                	jmp    879d <tp_float+0x9d>
    8761:	f2 0f 10 05 c7 48 00 	movsd  0x48c7(%rip),%xmm0        # d030 <_IO_stdin_used+0x30>
    8768:	00 
    8769:	eb 32                	jmp    879d <tp_float+0x9d>
    876b:	48 89 e7             	mov    %rsp,%rdi
    876e:	48 89 c6             	mov    %rax,%rsi
    8771:	e8 7a 0e 00 00       	call   95f0 <fwp_valid_float>
    8776:	31 c9                	xor    %ecx,%ecx
    8778:	85 c0                	test   %eax,%eax
    877a:	74 31                	je     87ad <tp_float+0xad>
    877c:	41 83 3e 0a          	cmpl   $0xa,(%r14)
    8780:	75 11                	jne    8793 <tp_float+0x93>
    8782:	48 89 e7             	mov    %rsp,%rdi
    8785:	31 f6                	xor    %esi,%esi
    8787:	e8 74 9a ff ff       	call   2200 <strtof@plt>
    878c:	e8 4f 0f 00 00       	call   96e0 <fwp_from_f32>
    8791:	eb 12                	jmp    87a5 <tp_float+0xa5>
    8793:	48 89 e7             	mov    %rsp,%rdi
    8796:	31 f6                	xor    %esi,%esi
    8798:	e8 63 99 ff ff       	call   2100 <strtod@plt>
    879d:	41 8b 3e             	mov    (%r14),%edi
    87a0:	e8 4b 0f 00 00       	call   96f0 <fwp_float_of>
    87a5:	48 89 03             	mov    %rax,(%rbx)
    87a8:	b9 01 00 00 00       	mov    $0x1,%ecx
    87ad:	89 c8                	mov    %ecx,%eax
    87af:	48 81 c4 88 00 00 00 	add    $0x88,%rsp
    87b6:	5b                   	pop    %rbx
    87b7:	41 5e                	pop    %r14
    87b9:	c3                   	ret
    87ba:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)

00000000000087c0 <tp_quoted>:
    87c0:	55                   	push   %rbp
    87c1:	41 57                	push   %r15
    87c3:	41 56                	push   %r14
    87c5:	41 55                	push   %r13
    87c7:	41 54                	push   %r12
    87c9:	53                   	push   %rbx
    87ca:	48 83 ec 18          	sub    $0x18,%rsp
    87ce:	49 89 f6             	mov    %rsi,%r14
    87d1:	49 89 ff             	mov    %rdi,%r15
    87d4:	e8 77 fe ff ff       	call   8650 <tp_ws>
    87d9:	4d 8b 6f 08          	mov    0x8(%r15),%r13
    87dd:	49 8b 6f 10          	mov    0x10(%r15),%rbp
    87e1:	31 db                	xor    %ebx,%ebx
    87e3:	4c 39 ed             	cmp    %r13,%rbp
    87e6:	0f 83 0d 02 00 00    	jae    89f9 <tp_quoted+0x239>
    87ec:	49 8b 07             	mov    (%r15),%rax
    87ef:	80 3c 28 22          	cmpb   $0x22,(%rax,%rbp,1)
    87f3:	0f 85 00 02 00 00    	jne    89f9 <tp_quoted+0x239>
    87f9:	48 ff c5             	inc    %rbp
    87fc:	49 89 6f 10          	mov    %rbp,0x10(%r15)
    8800:	0f 57 c0             	xorps  %xmm0,%xmm0
    8803:	0f 29 04 24          	movaps %xmm0,(%rsp)
    8807:	48 c7 44 24 10 00 00 	movq   $0x0,0x10(%rsp)
    880e:	00 00 
    8810:	31 db                	xor    %ebx,%ebx
    8812:	4c 39 ed             	cmp    %r13,%rbp
    8815:	0f 83 8d 01 00 00    	jae    89a8 <tp_quoted+0x1e8>
    881b:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)
    8820:	4d 8b 27             	mov    (%r15),%r12
    8823:	48 8d 4d 01          	lea    0x1(%rbp),%rcx
    8827:	49 89 4f 10          	mov    %rcx,0x10(%r15)
    882b:	41 0f b6 04 2c       	movzbl (%r12,%rbp,1),%eax
    8830:	83 f8 5c             	cmp    $0x5c,%eax
    8833:	74 2b                	je     8860 <tp_quoted+0xa0>
    8835:	83 f8 22             	cmp    $0x22,%eax
    8838:	0f 84 8b 01 00 00    	je     89c9 <tp_quoted+0x209>
    883e:	0f be f0             	movsbl %al,%esi
    8841:	48 89 e7             	mov    %rsp,%rdi
    8844:	e8 57 ee ff ff       	call   76a0 <buf_putc>
    8849:	4d 8b 6f 08          	mov    0x8(%r15),%r13
    884d:	49 8b 6f 10          	mov    0x10(%r15),%rbp
    8851:	4c 39 ed             	cmp    %r13,%rbp
    8854:	72 ca                	jb     8820 <tp_quoted+0x60>
    8856:	e9 63 01 00 00       	jmp    89be <tp_quoted+0x1fe>
    885b:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)
    8860:	4c 39 e9             	cmp    %r13,%rcx
    8863:	0f 83 48 01 00 00    	jae    89b1 <tp_quoted+0x1f1>
    8869:	48 8d 45 02          	lea    0x2(%rbp),%rax
    886d:	49 89 47 10          	mov    %rax,0x10(%r15)
    8871:	41 0f b6 4c 2c 01    	movzbl 0x1(%r12,%rbp,1),%ecx
    8877:	8d 51 a4             	lea    -0x5c(%rcx),%edx
    887a:	83 fa 19             	cmp    $0x19,%edx
    887d:	77 1a                	ja     8899 <tp_quoted+0xd9>
    887f:	48 8d 35 aa 49 00 00 	lea    0x49aa(%rip),%rsi        # d230 <_IO_stdin_used+0x230>
    8886:	48 63 0c 96          	movslq (%rsi,%rdx,4),%rcx
    888a:	48 01 f1             	add    %rsi,%rcx
    888d:	ff e1                	jmp    *%rcx
    888f:	48 89 e7             	mov    %rsp,%rdi
    8892:	be 5c 00 00 00       	mov    $0x5c,%esi
    8897:	eb ab                	jmp    8844 <tp_quoted+0x84>
    8899:	83 f9 22             	cmp    $0x22,%ecx
    889c:	0f 84 bf 00 00 00    	je     8961 <tp_quoted+0x1a1>
    88a2:	83 f9 30             	cmp    $0x30,%ecx
    88a5:	0f 85 06 01 00 00    	jne    89b1 <tp_quoted+0x1f1>
    88ab:	48 89 e7             	mov    %rsp,%rdi
    88ae:	31 f6                	xor    %esi,%esi
    88b0:	eb 92                	jmp    8844 <tp_quoted+0x84>
    88b2:	48 89 e7             	mov    %rsp,%rdi
    88b5:	be 09 00 00 00       	mov    $0x9,%esi
    88ba:	eb 88                	jmp    8844 <tp_quoted+0x84>
    88bc:	48 89 e7             	mov    %rsp,%rdi
    88bf:	be 0d 00 00 00       	mov    $0xd,%esi
    88c4:	e9 7b ff ff ff       	jmp    8844 <tp_quoted+0x84>
    88c9:	48 89 e7             	mov    %rsp,%rdi
    88cc:	be 0a 00 00 00       	mov    $0xa,%esi
    88d1:	e9 6e ff ff ff       	jmp    8844 <tp_quoted+0x84>
    88d6:	4c 39 e8             	cmp    %r13,%rax
    88d9:	0f 83 d2 00 00 00    	jae    89b1 <tp_quoted+0x1f1>
    88df:	41 80 3c 04 7b       	cmpb   $0x7b,(%r12,%rax,1)
    88e4:	0f 85 c7 00 00 00    	jne    89b1 <tp_quoted+0x1f1>
    88ea:	48 8d 45 03          	lea    0x3(%rbp),%rax
    88ee:	49 89 47 10          	mov    %rax,0x10(%r15)
    88f2:	4c 39 e8             	cmp    %r13,%rax
    88f5:	0f 83 b6 00 00 00    	jae    89b1 <tp_quoted+0x1f1>
    88fb:	e8 00 9c ff ff       	call   2500 <__ctype_b_loc@plt>
    8900:	48 8b 08             	mov    (%rax),%rcx
    8903:	48 8d 55 04          	lea    0x4(%rbp),%rdx
    8907:	49 8d 3c 2c          	lea    (%r12,%rbp,1),%rdi
    890b:	48 83 c7 03          	add    $0x3,%rdi
    890f:	49 29 ed             	sub    %rbp,%r13
    8912:	49 83 c5 fd          	add    $0xfffffffffffffffd,%r13
    8916:	31 c0                	xor    %eax,%eax
    8918:	31 f6                	xor    %esi,%esi
    891a:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)
    8920:	44 0f b6 04 07       	movzbl (%rdi,%rax,1),%r8d
    8925:	42 f6 44 41 01 10    	testb  $0x10,0x1(%rcx,%r8,2)
    892b:	74 41                	je     896e <tp_quoted+0x1ae>
    892d:	4c 8d 04 02          	lea    (%rdx,%rax,1),%r8
    8931:	4d 89 47 10          	mov    %r8,0x10(%r15)
    8935:	44 0f be 04 07       	movsbl (%rdi,%rax,1),%r8d
    893a:	c1 e6 04             	shl    $0x4,%esi
    893d:	45 8d 48 d0          	lea    -0x30(%r8),%r9d
    8941:	45 89 c2             	mov    %r8d,%r10d
    8944:	41 83 ca 20          	or     $0x20,%r10d
    8948:	41 83 c2 a9          	add    $0xffffffa9,%r10d
    894c:	41 83 f8 3a          	cmp    $0x3a,%r8d
    8950:	45 0f 4c d1          	cmovl  %r9d,%r10d
    8954:	44 01 d6             	add    %r10d,%esi
    8957:	48 ff c0             	inc    %rax
    895a:	49 39 c5             	cmp    %rax,%r13
    895d:	75 c1                	jne    8920 <tp_quoted+0x160>
    895f:	eb 50                	jmp    89b1 <tp_quoted+0x1f1>
    8961:	48 89 e7             	mov    %rsp,%rdi
    8964:	be 22 00 00 00       	mov    $0x22,%esi
    8969:	e9 d6 fe ff ff       	jmp    8844 <tp_quoted+0x84>
    896e:	85 c0                	test   %eax,%eax
    8970:	74 3f                	je     89b1 <tp_quoted+0x1f1>
    8972:	41 80 f8 7d          	cmp    $0x7d,%r8b
    8976:	75 39                	jne    89b1 <tp_quoted+0x1f1>
    8978:	81 fe ff ff 10 00    	cmp    $0x10ffff,%esi
    897e:	77 31                	ja     89b1 <tp_quoted+0x1f1>
    8980:	89 f1                	mov    %esi,%ecx
    8982:	81 e1 00 f8 ff ff    	and    $0xfffff800,%ecx
    8988:	81 f9 00 d8 00 00    	cmp    $0xd800,%ecx
    898e:	74 21                	je     89b1 <tp_quoted+0x1f1>
    8990:	48 01 e8             	add    %rbp,%rax
    8993:	48 83 c0 04          	add    $0x4,%rax
    8997:	49 89 47 10          	mov    %rax,0x10(%r15)
    899b:	48 89 e7             	mov    %rsp,%rdi
    899e:	e8 5d 0d 00 00       	call   9700 <fwp_utf8_put>
    89a3:	e9 a1 fe ff ff       	jmp    8849 <tp_quoted+0x89>
    89a8:	31 ff                	xor    %edi,%edi
    89aa:	e8 a1 96 ff ff       	call   2050 <free@plt>
    89af:	eb 48                	jmp    89f9 <tp_quoted+0x239>
    89b1:	48 8b 3c 24          	mov    (%rsp),%rdi
    89b5:	e8 96 96 ff ff       	call   2050 <free@plt>
    89ba:	31 db                	xor    %ebx,%ebx
    89bc:	eb 3b                	jmp    89f9 <tp_quoted+0x239>
    89be:	48 8b 3c 24          	mov    (%rsp),%rdi
    89c2:	e8 89 96 ff ff       	call   2050 <free@plt>
    89c7:	eb 30                	jmp    89f9 <tp_quoted+0x239>
    89c9:	48 8b 1c 24          	mov    (%rsp),%rbx
    89cd:	48 8b 74 24 08       	mov    0x8(%rsp),%rsi
    89d2:	48 85 db             	test   %rbx,%rbx
    89d5:	48 8d 3d 9c 56 00 00 	lea    0x569c(%rip),%rdi        # e078 <exec_in_fp0+0xa38>
    89dc:	48 0f 45 fb          	cmovne %rbx,%rdi
    89e0:	e8 1b eb ff ff       	call   7500 <fwp_valid_utf8>
    89e5:	85 c0                	test   %eax,%eax
    89e7:	74 21                	je     8a0a <tp_quoted+0x24a>
    89e9:	48 89 e7             	mov    %rsp,%rdi
    89ec:	e8 3f ed ff ff       	call   7730 <buf_to_str>
    89f1:	49 89 06             	mov    %rax,(%r14)
    89f4:	bb 01 00 00 00       	mov    $0x1,%ebx
    89f9:	89 d8                	mov    %ebx,%eax
    89fb:	48 83 c4 18          	add    $0x18,%rsp
    89ff:	5b                   	pop    %rbx
    8a00:	41 5c                	pop    %r12
    8a02:	41 5d                	pop    %r13
    8a04:	41 5e                	pop    %r14
    8a06:	41 5f                	pop    %r15
    8a08:	5d                   	pop    %rbp
    8a09:	c3                   	ret
    8a0a:	48 89 df             	mov    %rbx,%rdi
    8a0d:	eb a6                	jmp    89b5 <tp_quoted+0x1f5>
    8a0f:	90                   	nop

0000000000008a10 <tp_eat>:
    8a10:	55                   	push   %rbp
    8a11:	41 57                	push   %r15
    8a13:	41 56                	push   %r14
    8a15:	53                   	push   %rbx
    8a16:	50                   	push   %rax
    8a17:	49 89 f6             	mov    %rsi,%r14
    8a1a:	48 89 fb             	mov    %rdi,%rbx
    8a1d:	e8 2e fc ff ff       	call   8650 <tp_ws>
    8a22:	4c 89 f7             	mov    %r14,%rdi
    8a25:	e8 46 97 ff ff       	call   2170 <strlen@plt>
    8a2a:	48 8b 4b 08          	mov    0x8(%rbx),%rcx
    8a2e:	4c 8b 7b 10          	mov    0x10(%rbx),%r15
    8a32:	4c 29 f9             	sub    %r15,%rcx
    8a35:	31 ed                	xor    %ebp,%ebp
    8a37:	48 39 c1             	cmp    %rax,%rcx
    8a3a:	72 24                	jb     8a60 <tp_eat+0x50>
    8a3c:	48 8b 3b             	mov    (%rbx),%rdi
    8a3f:	4c 01 ff             	add    %r15,%rdi
    8a42:	4c 89 f6             	mov    %r14,%rsi
    8a45:	49 89 c6             	mov    %rax,%r14
    8a48:	48 89 c2             	mov    %rax,%rdx
    8a4b:	e8 20 99 ff ff       	call   2370 <bcmp@plt>
    8a50:	85 c0                	test   %eax,%eax
    8a52:	75 0c                	jne    8a60 <tp_eat+0x50>
    8a54:	4d 01 f7             	add    %r14,%r15
    8a57:	4c 89 7b 10          	mov    %r15,0x10(%rbx)
    8a5b:	bd 01 00 00 00       	mov    $0x1,%ebp
    8a60:	89 e8                	mov    %ebp,%eax
    8a62:	48 83 c4 08          	add    $0x8,%rsp
    8a66:	5b                   	pop    %rbx
    8a67:	41 5e                	pop    %r14
    8a69:	41 5f                	pop    %r15
    8a6b:	5d                   	pop    %rbp
    8a6c:	c3                   	ret
    8a6d:	0f 1f 00             	nopl   (%rax)

0000000000008a70 <tp_list_of>:
    8a70:	55                   	push   %rbp
    8a71:	41 57                	push   %r15
    8a73:	41 56                	push   %r14
    8a75:	41 55                	push   %r13
    8a77:	41 54                	push   %r12
    8a79:	53                   	push   %rbx
    8a7a:	50                   	push   %rax
    8a7b:	4d 89 c6             	mov    %r8,%r14
    8a7e:	49 89 cf             	mov    %rcx,%r15
    8a81:	49 89 d4             	mov    %rdx,%r12
    8a84:	49 89 fd             	mov    %rdi,%r13
    8a87:	e8 84 ff ff ff       	call   8a10 <tp_eat>
    8a8c:	31 db                	xor    %ebx,%ebx
    8a8e:	85 c0                	test   %eax,%eax
    8a90:	74 14                	je     8aa6 <tp_list_of+0x36>
    8a92:	4c 89 ef             	mov    %r13,%rdi
    8a95:	4c 89 e6             	mov    %r12,%rsi
    8a98:	e8 73 ff ff ff       	call   8a10 <tp_eat>
    8a9d:	85 c0                	test   %eax,%eax
    8a9f:	74 16                	je     8ab7 <tp_list_of+0x47>
    8aa1:	bb 01 00 00 00       	mov    $0x1,%ebx
    8aa6:	89 d8                	mov    %ebx,%eax
    8aa8:	48 83 c4 08          	add    $0x8,%rsp
    8aac:	5b                   	pop    %rbx
    8aad:	41 5c                	pop    %r12
    8aaf:	41 5d                	pop    %r13
    8ab1:	41 5e                	pop    %r14
    8ab3:	41 5f                	pop    %r15
    8ab5:	5d                   	pop    %rbp
    8ab6:	c3                   	ret
    8ab7:	48 8d 2d be 57 00 00 	lea    0x57be(%rip),%rbp        # e27c <exec_in_fp0+0xc3c>
    8abe:	66 90                	xchg   %ax,%ax
    8ac0:	4c 89 ef             	mov    %r13,%rdi
    8ac3:	4c 89 f6             	mov    %r14,%rsi
    8ac6:	41 ff d7             	call   *%r15
    8ac9:	85 c0                	test   %eax,%eax
    8acb:	74 d9                	je     8aa6 <tp_list_of+0x36>
    8acd:	4c 89 ef             	mov    %r13,%rdi
    8ad0:	4c 89 e6             	mov    %r12,%rsi
    8ad3:	e8 38 ff ff ff       	call   8a10 <tp_eat>
    8ad8:	85 c0                	test   %eax,%eax
    8ada:	75 c5                	jne    8aa1 <tp_list_of+0x31>
    8adc:	4c 89 ef             	mov    %r13,%rdi
    8adf:	48 89 ee             	mov    %rbp,%rsi
    8ae2:	e8 29 ff ff ff       	call   8a10 <tp_eat>
    8ae7:	85 c0                	test   %eax,%eax
    8ae9:	75 d5                	jne    8ac0 <tp_list_of+0x50>
    8aeb:	eb b9                	jmp    8aa6 <tp_list_of+0x36>
    8aed:	0f 1f 00             	nopl   (%rax)

0000000000008af0 <tp_byte_item>:
    8af0:	53                   	push   %rbx
    8af1:	48 83 ec 10          	sub    $0x10,%rsp
    8af5:	48 89 f3             	mov    %rsi,%rbx
    8af8:	48 8d 35 01 a2 00 00 	lea    0xa201(%rip),%rsi        # 12d00 <tp_byte_item.u8d>
    8aff:	48 8d 54 24 08       	lea    0x8(%rsp),%rdx
    8b04:	e8 97 fb ff ff       	call   86a0 <tp_int>
    8b09:	85 c0                	test   %eax,%eax
    8b0b:	74 14                	je     8b21 <tp_byte_item+0x31>
    8b0d:	48 8b 74 24 08       	mov    0x8(%rsp),%rsi
    8b12:	48 89 df             	mov    %rbx,%rdi
    8b15:	e8 96 0c 00 00       	call   97b0 <tp_push>
    8b1a:	b8 01 00 00 00       	mov    $0x1,%eax
    8b1f:	eb 02                	jmp    8b23 <tp_byte_item+0x33>
    8b21:	31 c0                	xor    %eax,%eax
    8b23:	48 83 c4 10          	add    $0x10,%rsp
    8b27:	5b                   	pop    %rbx
    8b28:	c3                   	ret
    8b29:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)

0000000000008b30 <tp_token>:
    8b30:	55                   	push   %rbp
    8b31:	41 57                	push   %r15
    8b33:	41 56                	push   %r14
    8b35:	41 55                	push   %r13
    8b37:	41 54                	push   %r12
    8b39:	53                   	push   %rbx
    8b3a:	50                   	push   %rax
    8b3b:	49 89 d7             	mov    %rdx,%r15
    8b3e:	48 89 34 24          	mov    %rsi,(%rsp)
    8b42:	48 89 fb             	mov    %rdi,%rbx
    8b45:	e8 06 fb ff ff       	call   8650 <tp_ws>
    8b4a:	4c 8b 73 10          	mov    0x10(%rbx),%r14
    8b4e:	4c 8b 23             	mov    (%rbx),%r12
    8b51:	4c 8b 6b 08          	mov    0x8(%rbx),%r13
    8b55:	4c 89 f5             	mov    %r14,%rbp
    8b58:	4d 39 ee             	cmp    %r13,%r14
    8b5b:	73 20                	jae    8b7d <tp_token+0x4d>
    8b5d:	4c 89 f5             	mov    %r14,%rbp
    8b60:	41 0f be 3c 2c       	movsbl (%r12,%rbp,1),%edi
    8b65:	e8 a6 0c 00 00       	call   9810 <tp_is_delim>
    8b6a:	85 c0                	test   %eax,%eax
    8b6c:	75 0f                	jne    8b7d <tp_token+0x4d>
    8b6e:	48 ff c5             	inc    %rbp
    8b71:	48 89 6b 10          	mov    %rbp,0x10(%rbx)
    8b75:	49 39 ed             	cmp    %rbp,%r13
    8b78:	75 e6                	jne    8b60 <tp_token+0x30>
    8b7a:	4c 89 ed             	mov    %r13,%rbp
    8b7d:	4c 29 f5             	sub    %r14,%rbp
    8b80:	4d 8d 6f ff          	lea    -0x1(%r15),%r13
    8b84:	4c 39 fd             	cmp    %r15,%rbp
    8b87:	4c 0f 42 ed          	cmovb  %rbp,%r13
    8b8b:	4d 01 f4             	add    %r14,%r12
    8b8e:	4c 8b 3c 24          	mov    (%rsp),%r15
    8b92:	4c 89 ff             	mov    %r15,%rdi
    8b95:	4c 89 e6             	mov    %r12,%rsi
    8b98:	4c 89 ea             	mov    %r13,%rdx
    8b9b:	e8 90 97 ff ff       	call   2330 <memcpy@plt>
    8ba0:	43 c6 04 2f 00       	movb   $0x0,(%r15,%r13,1)
    8ba5:	48 8b 43 10          	mov    0x10(%rbx),%rax
    8ba9:	4c 29 f0             	sub    %r14,%rax
    8bac:	48 83 c4 08          	add    $0x8,%rsp
    8bb0:	5b                   	pop    %rbx
    8bb1:	41 5c                	pop    %r12
    8bb3:	41 5d                	pop    %r13
    8bb5:	41 5e                	pop    %r14
    8bb7:	41 5f                	pop    %r15
    8bb9:	5d                   	pop    %rbp
    8bba:	c3                   	ret
    8bbb:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)

0000000000008bc0 <tp_elem_item>:
    8bc0:	55                   	push   %rbp
    8bc1:	53                   	push   %rbx
    8bc2:	50                   	push   %rax
    8bc3:	48 89 f3             	mov    %rsi,%rbx
    8bc6:	48 8b 36             	mov    (%rsi),%rsi
    8bc9:	31 ed                	xor    %ebp,%ebp
    8bcb:	48 89 e1             	mov    %rsp,%rcx
    8bce:	31 d2                	xor    %edx,%edx
    8bd0:	e8 4b f1 ff ff       	call   7d20 <tp_value>
    8bd5:	85 c0                	test   %eax,%eax
    8bd7:	74 11                	je     8bea <tp_elem_item+0x2a>
    8bd9:	48 8b 34 24          	mov    (%rsp),%rsi
    8bdd:	48 89 df             	mov    %rbx,%rdi
    8be0:	e8 cb 0b 00 00       	call   97b0 <tp_push>
    8be5:	bd 01 00 00 00       	mov    $0x1,%ebp
    8bea:	89 e8                	mov    %ebp,%eax
    8bec:	48 83 c4 08          	add    $0x8,%rsp
    8bf0:	5b                   	pop    %rbx
    8bf1:	5d                   	pop    %rbp
    8bf2:	c3                   	ret
    8bf3:	66 66 66 66 2e 0f 1f 	data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    8bfa:	84 00 00 00 00 00 

0000000000008c00 <fwp_p_array_from_list>:
    8c00:	41 56                	push   %r14
    8c02:	53                   	push   %rbx
    8c03:	50                   	push   %rax
    8c04:	48 89 fb             	mov    %rdi,%rbx
    8c07:	e8 44 0c 00 00       	call   9850 <fwp_list_len>
    8c0c:	49 89 c6             	mov    %rax,%r14
    8c0f:	48 89 c7             	mov    %rax,%rdi
    8c12:	e8 a9 a8 ff ff       	call   34c0 <fwp_arr_new>
    8c17:	4d 85 f6             	test   %r14,%r14
    8c1a:	0f 84 84 00 00 00    	je     8ca4 <fwp_p_array_from_list+0xa4>
    8c20:	44 89 f1             	mov    %r14d,%ecx
    8c23:	83 e1 03             	and    $0x3,%ecx
    8c26:	49 83 fe 04          	cmp    $0x4,%r14
    8c2a:	73 04                	jae    8c30 <fwp_p_array_from_list+0x30>
    8c2c:	31 d2                	xor    %edx,%edx
    8c2e:	eb 4d                	jmp    8c7d <fwp_p_array_from_list+0x7d>
    8c30:	49 83 e6 fc          	and    $0xfffffffffffffffc,%r14
    8c34:	31 d2                	xor    %edx,%edx
    8c36:	66 2e 0f 1f 84 00 00 	cs nopw 0x0(%rax,%rax,1)
    8c3d:	00 00 00 
    8c40:	48 8b 73 08          	mov    0x8(%rbx),%rsi
    8c44:	48 89 74 d0 08       	mov    %rsi,0x8(%rax,%rdx,8)
    8c49:	48 8b 73 10          	mov    0x10(%rbx),%rsi
    8c4d:	48 8b 7e 08          	mov    0x8(%rsi),%rdi
    8c51:	48 89 7c d0 10       	mov    %rdi,0x10(%rax,%rdx,8)
    8c56:	48 8b 76 10          	mov    0x10(%rsi),%rsi
    8c5a:	48 8b 7e 08          	mov    0x8(%rsi),%rdi
    8c5e:	48 89 7c d0 18       	mov    %rdi,0x18(%rax,%rdx,8)
    8c63:	48 8b 76 10          	mov    0x10(%rsi),%rsi
    8c67:	48 8b 7e 08          	mov    0x8(%rsi),%rdi
    8c6b:	48 89 7c d0 20       	mov    %rdi,0x20(%rax,%rdx,8)
    8c70:	48 8b 5e 10          	mov    0x10(%rsi),%rbx
    8c74:	48 83 c2 04          	add    $0x4,%rdx
    8c78:	49 39 d6             	cmp    %rdx,%r14
    8c7b:	75 c3                	jne    8c40 <fwp_p_array_from_list+0x40>
    8c7d:	48 85 c9             	test   %rcx,%rcx
    8c80:	74 22                	je     8ca4 <fwp_p_array_from_list+0xa4>
    8c82:	48 8d 14 d0          	lea    (%rax,%rdx,8),%rdx
    8c86:	48 83 c2 08          	add    $0x8,%rdx
    8c8a:	31 f6                	xor    %esi,%esi
    8c8c:	0f 1f 40 00          	nopl   0x0(%rax)
    8c90:	48 8b 7b 08          	mov    0x8(%rbx),%rdi
    8c94:	48 89 3c f2          	mov    %rdi,(%rdx,%rsi,8)
    8c98:	48 8b 5b 10          	mov    0x10(%rbx),%rbx
    8c9c:	48 ff c6             	inc    %rsi
    8c9f:	48 39 f1             	cmp    %rsi,%rcx
    8ca2:	75 ec                	jne    8c90 <fwp_p_array_from_list+0x90>
    8ca4:	48 83 c4 08          	add    $0x8,%rsp
    8ca8:	5b                   	pop    %rbx
    8ca9:	41 5e                	pop    %r14
    8cab:	c3                   	ret
    8cac:	0f 1f 40 00          	nopl   0x0(%rax)

0000000000008cb0 <tp_kv_item>:
    8cb0:	41 57                	push   %r15
    8cb2:	41 56                	push   %r14
    8cb4:	53                   	push   %rbx
    8cb5:	48 83 ec 10          	sub    $0x10,%rsp
    8cb9:	48 89 f3             	mov    %rsi,%rbx
    8cbc:	49 89 ff             	mov    %rdi,%r15
    8cbf:	48 c7 04 24 00 00 00 	movq   $0x0,(%rsp)
    8cc6:	00 
    8cc7:	48 8b 36             	mov    (%rsi),%rsi
    8cca:	45 31 f6             	xor    %r14d,%r14d
    8ccd:	48 8d 4c 24 08       	lea    0x8(%rsp),%rcx
    8cd2:	31 d2                	xor    %edx,%edx
    8cd4:	e8 47 f0 ff ff       	call   7d20 <tp_value>
    8cd9:	85 c0                	test   %eax,%eax
    8cdb:	74 27                	je     8d04 <tp_kv_item+0x54>
    8cdd:	45 31 f6             	xor    %r14d,%r14d
    8ce0:	83 7b 28 00          	cmpl   $0x0,0x28(%rbx)
    8ce4:	74 2b                	je     8d11 <tp_kv_item+0x61>
    8ce6:	48 8b 74 24 08       	mov    0x8(%rsp),%rsi
    8ceb:	48 89 df             	mov    %rbx,%rdi
    8cee:	e8 bd 0a 00 00       	call   97b0 <tp_push>
    8cf3:	48 89 df             	mov    %rbx,%rdi
    8cf6:	4c 89 f6             	mov    %r14,%rsi
    8cf9:	e8 b2 0a 00 00       	call   97b0 <tp_push>
    8cfe:	41 be 01 00 00 00    	mov    $0x1,%r14d
    8d04:	44 89 f0             	mov    %r14d,%eax
    8d07:	48 83 c4 10          	add    $0x10,%rsp
    8d0b:	5b                   	pop    %rbx
    8d0c:	41 5e                	pop    %r14
    8d0e:	41 5f                	pop    %r15
    8d10:	c3                   	ret
    8d11:	48 8d 35 78 55 00 00 	lea    0x5578(%rip),%rsi        # e290 <exec_in_fp0+0xc50>
    8d18:	4c 89 ff             	mov    %r15,%rdi
    8d1b:	e8 f0 fc ff ff       	call   8a10 <tp_eat>
    8d20:	85 c0                	test   %eax,%eax
    8d22:	74 e0                	je     8d04 <tp_kv_item+0x54>
    8d24:	48 8b 73 08          	mov    0x8(%rbx),%rsi
    8d28:	45 31 f6             	xor    %r14d,%r14d
    8d2b:	48 89 e1             	mov    %rsp,%rcx
    8d2e:	4c 89 ff             	mov    %r15,%rdi
    8d31:	31 d2                	xor    %edx,%edx
    8d33:	e8 e8 ef ff ff       	call   7d20 <tp_value>
    8d38:	85 c0                	test   %eax,%eax
    8d3a:	74 c8                	je     8d04 <tp_kv_item+0x54>
    8d3c:	4c 8b 34 24          	mov    (%rsp),%r14
    8d40:	eb a4                	jmp    8ce6 <tp_kv_item+0x36>
    8d42:	66 66 66 66 66 2e 0f 	data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    8d49:	1f 84 00 00 00 00 00 

0000000000008d50 <fwp_p_map_insert>:
    8d50:	55                   	push   %rbp
    8d51:	41 57                	push   %r15
    8d53:	41 56                	push   %r14
    8d55:	41 55                	push   %r13
    8d57:	41 54                	push   %r12
    8d59:	53                   	push   %rbx
    8d5a:	48 83 ec 18          	sub    $0x18,%rsp
    8d5e:	49 89 d6             	mov    %rdx,%r14
    8d61:	48 89 74 24 08       	mov    %rsi,0x8(%rsp)
    8d66:	48 89 fe             	mov    %rdi,%rsi
    8d69:	48 8d 44 24 04       	lea    0x4(%rsp),%rax
    8d6e:	48 89 d7             	mov    %rdx,%rdi
    8d71:	48 89 74 24 10       	mov    %rsi,0x10(%rsp)
    8d76:	48 89 ca             	mov    %rcx,%rdx
    8d79:	48 89 c1             	mov    %rax,%rcx
    8d7c:	e8 ef 0a 00 00       	call   9870 <fwp_map_find>
    8d81:	48 89 c5             	mov    %rax,%rbp
    8d84:	4d 8b 3e             	mov    (%r14),%r15
    8d87:	44 8b 64 24 04       	mov    0x4(%rsp),%r12d
    8d8c:	31 ff                	xor    %edi,%edi
    8d8e:	45 85 e4             	test   %r12d,%r12d
    8d91:	40 0f 94 c7          	sete   %dil
    8d95:	4c 01 ff             	add    %r15,%rdi
    8d98:	e8 23 0c 00 00       	call   99c0 <fwp_map_alloc>
    8d9d:	49 89 c5             	mov    %rax,%r13
    8da0:	48 8d 58 08          	lea    0x8(%rax),%rbx
    8da4:	49 83 c6 08          	add    $0x8,%r14
    8da8:	45 85 e4             	test   %r12d,%r12d
    8dab:	74 22                	je     8dcf <fwp_p_map_insert+0x7f>
    8dad:	49 c1 e7 04          	shl    $0x4,%r15
    8db1:	48 89 df             	mov    %rbx,%rdi
    8db4:	4c 89 f6             	mov    %r14,%rsi
    8db7:	4c 89 fa             	mov    %r15,%rdx
    8dba:	e8 71 95 ff ff       	call   2330 <memcpy@plt>
    8dbf:	48 c1 e5 04          	shl    $0x4,%rbp
    8dc3:	48 8b 44 24 08       	mov    0x8(%rsp),%rax
    8dc8:	49 89 44 2d 10       	mov    %rax,0x10(%r13,%rbp,1)
    8dcd:	eb 46                	jmp    8e15 <fwp_p_map_insert+0xc5>
    8dcf:	49 89 ec             	mov    %rbp,%r12
    8dd2:	49 c1 e4 04          	shl    $0x4,%r12
    8dd6:	48 89 df             	mov    %rbx,%rdi
    8dd9:	4c 89 f6             	mov    %r14,%rsi
    8ddc:	4c 89 e2             	mov    %r12,%rdx
    8ddf:	e8 4c 95 ff ff       	call   2330 <memcpy@plt>
    8de4:	48 8b 44 24 10       	mov    0x10(%rsp),%rax
    8de9:	4b 89 44 25 08       	mov    %rax,0x8(%r13,%r12,1)
    8dee:	48 8b 44 24 08       	mov    0x8(%rsp),%rax
    8df3:	4b 89 44 25 10       	mov    %rax,0x10(%r13,%r12,1)
    8df8:	4a 8d 3c 23          	lea    (%rbx,%r12,1),%rdi
    8dfc:	48 83 c7 10          	add    $0x10,%rdi
    8e00:	4d 01 f4             	add    %r14,%r12
    8e03:	49 29 ef             	sub    %rbp,%r15
    8e06:	49 c1 e7 04          	shl    $0x4,%r15
    8e0a:	4c 89 e6             	mov    %r12,%rsi
    8e0d:	4c 89 fa             	mov    %r15,%rdx
    8e10:	e8 1b 95 ff ff       	call   2330 <memcpy@plt>
    8e15:	4c 89 e8             	mov    %r13,%rax
    8e18:	48 83 c4 18          	add    $0x18,%rsp
    8e1c:	5b                   	pop    %rbx
    8e1d:	41 5c                	pop    %r12
    8e1f:	41 5d                	pop    %r13
    8e21:	41 5e                	pop    %r14
    8e23:	41 5f                	pop    %r15
    8e25:	5d                   	pop    %rbp
    8e26:	c3                   	ret
    8e27:	66 0f 1f 84 00 00 00 	nopw   0x0(%rax,%rax,1)
    8e2e:	00 00 

0000000000008e30 <fwp_valid_int>:
    8e30:	31 c0                	xor    %eax,%eax
    8e32:	48 85 f6             	test   %rsi,%rsi
    8e35:	74 32                	je     8e69 <fwp_valid_int+0x39>
    8e37:	0f b6 17             	movzbl (%rdi),%edx
    8e3a:	80 c2 d5             	add    $0xd5,%dl
    8e3d:	31 c9                	xor    %ecx,%ecx
    8e3f:	f6 c2 fd             	test   $0xfd,%dl
    8e42:	0f 94 c1             	sete   %cl
    8e45:	48 39 f1             	cmp    %rsi,%rcx
    8e48:	74 1f                	je     8e69 <fwp_valid_int+0x39>
    8e4a:	73 18                	jae    8e64 <fwp_valid_int+0x34>
    8e4c:	0f 1f 40 00          	nopl   0x0(%rax)
    8e50:	0f b6 14 0f          	movzbl (%rdi,%rcx,1),%edx
    8e54:	80 c2 c6             	add    $0xc6,%dl
    8e57:	80 fa f5             	cmp    $0xf5,%dl
    8e5a:	76 0d                	jbe    8e69 <fwp_valid_int+0x39>
    8e5c:	48 ff c1             	inc    %rcx
    8e5f:	48 39 ce             	cmp    %rcx,%rsi
    8e62:	75 ec                	jne    8e50 <fwp_valid_int+0x20>
    8e64:	b8 01 00 00 00       	mov    $0x1,%eax
    8e69:	c3                   	ret
    8e6a:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)

0000000000008e70 <tp_record_body>:
    8e70:	55                   	push   %rbp
    8e71:	41 57                	push   %r15
    8e73:	41 56                	push   %r14
    8e75:	41 55                	push   %r13
    8e77:	41 54                	push   %r12
    8e79:	53                   	push   %rbx
    8e7a:	48 81 ec 28 01 00 00 	sub    $0x128,%rsp
    8e81:	48 89 d3             	mov    %rdx,%rbx
    8e84:	49 89 f5             	mov    %rsi,%r13
    8e87:	48 89 fd             	mov    %rdi,%rbp
    8e8a:	48 63 46 10          	movslq 0x10(%rsi),%rax
    8e8e:	48 8d 3c c5 08 00 00 	lea    0x8(,%rax,8),%rdi
    8e95:	00 
    8e96:	e8 65 a6 ff ff       	call   3500 <fwp_alloc>
    8e9b:	49 89 c7             	mov    %rax,%r15
    8e9e:	49 63 7d 10          	movslq 0x10(%r13),%rdi
    8ea2:	48 ff c7             	inc    %rdi
    8ea5:	e8 f6 d5 ff ff       	call   64a0 <fwp_alloc_leaf>
    8eaa:	49 89 c4             	mov    %rax,%r12
    8ead:	49 63 55 10          	movslq 0x10(%r13),%rdx
    8eb1:	48 ff c2             	inc    %rdx
    8eb4:	45 31 f6             	xor    %r14d,%r14d
    8eb7:	48 89 c7             	mov    %rax,%rdi
    8eba:	31 f6                	xor    %esi,%esi
    8ebc:	e8 4f 93 ff ff       	call   2210 <memset@plt>
    8ec1:	48 8d 35 74 54 00 00 	lea    0x5474(%rip),%rsi        # e33c <exec_in_fp0+0xcfc>
    8ec8:	48 89 ef             	mov    %rbp,%rdi
    8ecb:	e8 40 fb ff ff       	call   8a10 <tp_eat>
    8ed0:	85 c0                	test   %eax,%eax
    8ed2:	0f 84 3b 01 00 00    	je     9013 <tp_record_body+0x1a3>
    8ed8:	48 8d 35 85 47 00 00 	lea    0x4785(%rip),%rsi        # d664 <exec_in_fp0+0x24>
    8edf:	48 89 ef             	mov    %rbp,%rdi
    8ee2:	e8 29 fb ff ff       	call   8a10 <tp_eat>
    8ee7:	85 c0                	test   %eax,%eax
    8ee9:	74 3e                	je     8f29 <tp_record_body+0xb9>
    8eeb:	41 8b 7d 10          	mov    0x10(%r13),%edi
    8eef:	85 ff                	test   %edi,%edi
    8ef1:	7e 20                	jle    8f13 <tp_record_body+0xa3>
    8ef3:	45 31 f6             	xor    %r14d,%r14d
    8ef6:	31 c0                	xor    %eax,%eax
    8ef8:	0f 1f 84 00 00 00 00 	nopl   0x0(%rax,%rax,1)
    8eff:	00 
    8f00:	41 80 3c 04 00       	cmpb   $0x0,(%r12,%rax,1)
    8f05:	0f 84 08 01 00 00    	je     9013 <tp_record_body+0x1a3>
    8f0b:	48 ff c0             	inc    %rax
    8f0e:	48 39 c7             	cmp    %rax,%rdi
    8f11:	75 ed                	jne    8f00 <tp_record_body+0x90>
    8f13:	4c 89 fe             	mov    %r15,%rsi
    8f16:	e8 e5 a2 ff ff       	call   3200 <fwp_record>
    8f1b:	48 89 03             	mov    %rax,(%rbx)
    8f1e:	41 be 01 00 00 00    	mov    $0x1,%r14d
    8f24:	e9 ea 00 00 00       	jmp    9013 <tp_record_body+0x1a3>
    8f29:	48 89 1c 24          	mov    %rbx,(%rsp)
    8f2d:	48 8d 74 24 20       	lea    0x20(%rsp),%rsi
    8f32:	48 89 ef             	mov    %rbp,%rdi
    8f35:	e8 06 01 00 00       	call   9040 <tp_ident>
    8f3a:	41 8b 45 10          	mov    0x10(%r13),%eax
    8f3e:	85 c0                	test   %eax,%eax
    8f40:	0f 8e ca 00 00 00    	jle    9010 <tp_record_body+0x1a0>
    8f46:	48 8d 5c 24 20       	lea    0x20(%rsp),%rbx
    8f4b:	4c 89 7c 24 18       	mov    %r15,0x18(%rsp)
    8f50:	4c 89 64 24 10       	mov    %r12,0x10(%rsp)
    8f55:	48 89 6c 24 08       	mov    %rbp,0x8(%rsp)
    8f5a:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)
    8f60:	4d 8b 65 18          	mov    0x18(%r13),%r12
    8f64:	41 89 c7             	mov    %eax,%r15d
    8f67:	41 be ff ff ff ff    	mov    $0xffffffff,%r14d
    8f6d:	31 ed                	xor    %ebp,%ebp
    8f6f:	90                   	nop
    8f70:	49 8b 3c ec          	mov    (%r12,%rbp,8),%rdi
    8f74:	48 89 de             	mov    %rbx,%rsi
    8f77:	e8 54 93 ff ff       	call   22d0 <strcmp@plt>
    8f7c:	85 c0                	test   %eax,%eax
    8f7e:	44 0f 44 f5          	cmove  %ebp,%r14d
    8f82:	48 ff c5             	inc    %rbp
    8f85:	49 39 ef             	cmp    %rbp,%r15
    8f88:	75 e6                	jne    8f70 <tp_record_body+0x100>
    8f8a:	45 85 f6             	test   %r14d,%r14d
    8f8d:	4c 8b 7c 24 18       	mov    0x18(%rsp),%r15
    8f92:	4c 8b 64 24 10       	mov    0x10(%rsp),%r12
    8f97:	48 8b 6c 24 08       	mov    0x8(%rsp),%rbp
    8f9c:	78 72                	js     9010 <tp_record_body+0x1a0>
    8f9e:	48 89 ef             	mov    %rbp,%rdi
    8fa1:	48 8d 35 ea 52 00 00 	lea    0x52ea(%rip),%rsi        # e292 <exec_in_fp0+0xc52>
    8fa8:	e8 63 fa ff ff       	call   8a10 <tp_eat>
    8fad:	85 c0                	test   %eax,%eax
    8faf:	74 5f                	je     9010 <tp_record_body+0x1a0>
    8fb1:	49 8b 45 20          	mov    0x20(%r13),%rax
    8fb5:	45 89 f6             	mov    %r14d,%r14d
    8fb8:	4a 8b 34 f0          	mov    (%rax,%r14,8),%rsi
    8fbc:	4b 8d 0c f7          	lea    (%r15,%r14,8),%rcx
    8fc0:	48 89 ef             	mov    %rbp,%rdi
    8fc3:	31 d2                	xor    %edx,%edx
    8fc5:	e8 56 ed ff ff       	call   7d20 <tp_value>
    8fca:	85 c0                	test   %eax,%eax
    8fcc:	74 42                	je     9010 <tp_record_body+0x1a0>
    8fce:	43 c6 04 34 01       	movb   $0x1,(%r12,%r14,1)
    8fd3:	48 89 ef             	mov    %rbp,%rdi
    8fd6:	48 8d 35 87 46 00 00 	lea    0x4687(%rip),%rsi        # d664 <exec_in_fp0+0x24>
    8fdd:	e8 2e fa ff ff       	call   8a10 <tp_eat>
    8fe2:	85 c0                	test   %eax,%eax
    8fe4:	75 42                	jne    9028 <tp_record_body+0x1b8>
    8fe6:	48 89 ef             	mov    %rbp,%rdi
    8fe9:	48 8d 35 8c 52 00 00 	lea    0x528c(%rip),%rsi        # e27c <exec_in_fp0+0xc3c>
    8ff0:	e8 1b fa ff ff       	call   8a10 <tp_eat>
    8ff5:	85 c0                	test   %eax,%eax
    8ff7:	74 17                	je     9010 <tp_record_body+0x1a0>
    8ff9:	48 89 ef             	mov    %rbp,%rdi
    8ffc:	48 89 de             	mov    %rbx,%rsi
    8fff:	e8 3c 00 00 00       	call   9040 <tp_ident>
    9004:	41 8b 45 10          	mov    0x10(%r13),%eax
    9008:	85 c0                	test   %eax,%eax
    900a:	0f 8f 50 ff ff ff    	jg     8f60 <tp_record_body+0xf0>
    9010:	45 31 f6             	xor    %r14d,%r14d
    9013:	44 89 f0             	mov    %r14d,%eax
    9016:	48 81 c4 28 01 00 00 	add    $0x128,%rsp
    901d:	5b                   	pop    %rbx
    901e:	41 5c                	pop    %r12
    9020:	41 5d                	pop    %r13
    9022:	41 5e                	pop    %r14
    9024:	41 5f                	pop    %r15
    9026:	5d                   	pop    %rbp
    9027:	c3                   	ret
    9028:	48 8b 1c 24          	mov    (%rsp),%rbx
    902c:	e9 ba fe ff ff       	jmp    8eeb <tp_record_body+0x7b>
    9031:	66 66 66 66 66 66 2e 	data16 data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    9038:	0f 1f 84 00 00 00 00 
    903f:	00 

0000000000009040 <tp_ident>:
    9040:	41 56                	push   %r14
    9042:	53                   	push   %rbx
    9043:	50                   	push   %rax
    9044:	48 89 f3             	mov    %rsi,%rbx
    9047:	49 89 fe             	mov    %rdi,%r14
    904a:	e8 01 f6 ff ff       	call   8650 <tp_ws>
    904f:	49 8b 46 10          	mov    0x10(%r14),%rax
    9053:	49 8b 36             	mov    (%r14),%rsi
    9056:	49 8b 56 08          	mov    0x8(%r14),%rdx
    905a:	48 89 c1             	mov    %rax,%rcx
    905d:	48 39 d0             	cmp    %rdx,%rax
    9060:	73 63                	jae    90c5 <tp_ident+0x85>
    9062:	48 bf 03 00 00 00 00 	movabs $0x4000000000003,%rdi
    9069:	00 04 00 
    906c:	48 89 c1             	mov    %rax,%rcx
    906f:	eb 1b                	jmp    908c <tp_ident+0x4c>
    9071:	66 66 66 66 66 66 2e 	data16 data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    9078:	0f 1f 84 00 00 00 00 
    907f:	00 
    9080:	48 ff c1             	inc    %rcx
    9083:	49 89 4e 10          	mov    %rcx,0x10(%r14)
    9087:	48 39 ca             	cmp    %rcx,%rdx
    908a:	74 36                	je     90c2 <tp_ident+0x82>
    908c:	44 0f b6 04 0e       	movzbl (%rsi,%rcx,1),%r8d
    9091:	45 8d 48 d0          	lea    -0x30(%r8),%r9d
    9095:	41 80 f9 0a          	cmp    $0xa,%r9b
    9099:	72 e5                	jb     9080 <tp_ident+0x40>
    909b:	45 89 c1             	mov    %r8d,%r9d
    909e:	41 80 e1 df          	and    $0xdf,%r9b
    90a2:	41 80 c1 bf          	add    $0xbf,%r9b
    90a6:	41 80 f9 1a          	cmp    $0x1a,%r9b
    90aa:	72 d4                	jb     9080 <tp_ident+0x40>
    90ac:	45 0f b6 c0          	movzbl %r8b,%r8d
    90b0:	41 83 c0 d3          	add    $0xffffffd3,%r8d
    90b4:	41 83 f8 32          	cmp    $0x32,%r8d
    90b8:	77 0b                	ja     90c5 <tp_ident+0x85>
    90ba:	4c 0f a3 c7          	bt     %r8,%rdi
    90be:	72 c0                	jb     9080 <tp_ident+0x40>
    90c0:	eb 03                	jmp    90c5 <tp_ident+0x85>
    90c2:	48 89 d1             	mov    %rdx,%rcx
    90c5:	48 29 c1             	sub    %rax,%rcx
    90c8:	48 81 f9 ff 00 00 00 	cmp    $0xff,%rcx
    90cf:	41 be ff 00 00 00    	mov    $0xff,%r14d
    90d5:	4c 0f 42 f1          	cmovb  %rcx,%r14
    90d9:	48 01 c6             	add    %rax,%rsi
    90dc:	48 89 df             	mov    %rbx,%rdi
    90df:	4c 89 f2             	mov    %r14,%rdx
    90e2:	e8 49 92 ff ff       	call   2330 <memcpy@plt>
    90e7:	42 c6 04 33 00       	movb   $0x0,(%rbx,%r14,1)
    90ec:	48 83 c4 08          	add    $0x8,%rsp
    90f0:	5b                   	pop    %rbx
    90f1:	41 5e                	pop    %r14
    90f3:	c3                   	ret
    90f4:	66 66 66 2e 0f 1f 84 	data16 data16 cs nopw 0x0(%rax,%rax,1)
    90fb:	00 00 00 00 00 

0000000000009100 <tp_atom>:
    9100:	41 57                	push   %r15
    9102:	41 56                	push   %r14
    9104:	53                   	push   %rbx
    9105:	49 89 d6             	mov    %rdx,%r14
    9108:	49 89 f7             	mov    %rsi,%r15
    910b:	48 89 fb             	mov    %rdi,%rbx
    910e:	e8 3d f5 ff ff       	call   8650 <tp_ws>
    9113:	41 83 3f 10          	cmpl   $0x10,(%r15)
    9117:	75 07                	jne    9120 <tp_atom+0x20>
    9119:	49 83 7f 08 00       	cmpq   $0x0,0x8(%r15)
    911e:	74 5e                	je     917e <tp_atom+0x7e>
    9120:	31 c0                	xor    %eax,%eax
    9122:	48 8b 4b 10          	mov    0x10(%rbx),%rcx
    9126:	48 3b 4b 08          	cmp    0x8(%rbx),%rcx
    912a:	73 0e                	jae    913a <tp_atom+0x3a>
    912c:	48 8b 13             	mov    (%rbx),%rdx
    912f:	80 3c 0a 28          	cmpb   $0x28,(%rdx,%rcx,1)
    9133:	0f 95 c2             	setne  %dl
    9136:	08 c2                	or     %al,%dl
    9138:	74 15                	je     914f <tp_atom+0x4f>
    913a:	48 89 df             	mov    %rbx,%rdi
    913d:	4c 89 fe             	mov    %r15,%rsi
    9140:	31 d2                	xor    %edx,%edx
    9142:	4c 89 f1             	mov    %r14,%rcx
    9145:	5b                   	pop    %rbx
    9146:	41 5e                	pop    %r14
    9148:	41 5f                	pop    %r15
    914a:	e9 d1 eb ff ff       	jmp    7d20 <tp_value>
    914f:	48 ff c1             	inc    %rcx
    9152:	48 89 4b 10          	mov    %rcx,0x10(%rbx)
    9156:	48 89 df             	mov    %rbx,%rdi
    9159:	4c 89 fe             	mov    %r15,%rsi
    915c:	31 d2                	xor    %edx,%edx
    915e:	4c 89 f1             	mov    %r14,%rcx
    9161:	e8 ba eb ff ff       	call   7d20 <tp_value>
    9166:	85 c0                	test   %eax,%eax
    9168:	74 25                	je     918f <tp_atom+0x8f>
    916a:	48 8d 35 ce 51 00 00 	lea    0x51ce(%rip),%rsi        # e33f <exec_in_fp0+0xcff>
    9171:	48 89 df             	mov    %rbx,%rdi
    9174:	5b                   	pop    %rbx
    9175:	41 5e                	pop    %r14
    9177:	41 5f                	pop    %r15
    9179:	e9 92 f8 ff ff       	jmp    8a10 <tp_eat>
    917e:	41 83 7f 10 00       	cmpl   $0x0,0x10(%r15)
    9183:	74 12                	je     9197 <tp_atom+0x97>
    9185:	41 83 7f 48 00       	cmpl   $0x0,0x48(%r15)
    918a:	0f 95 c0             	setne  %al
    918d:	eb 93                	jmp    9122 <tp_atom+0x22>
    918f:	31 c0                	xor    %eax,%eax
    9191:	5b                   	pop    %rbx
    9192:	41 5e                	pop    %r14
    9194:	41 5f                	pop    %r15
    9196:	c3                   	ret
    9197:	b0 01                	mov    $0x1,%al
    9199:	eb 87                	jmp    9122 <tp_atom+0x22>
    919b:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)

00000000000091a0 <fwp_cstr>:
    91a0:	53                   	push   %rbx
    91a1:	48 89 fb             	mov    %rdi,%rbx
    91a4:	e8 c7 8f ff ff       	call   2170 <strlen@plt>
    91a9:	48 89 df             	mov    %rbx,%rdi
    91ac:	48 89 c6             	mov    %rax,%rsi
    91af:	5b                   	pop    %rbx
    91b0:	e9 ab e4 ff ff       	jmp    7660 <fwp_str_new>
    91b5:	66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
    91bc:	00 00 00 00 

00000000000091c0 <fwp_p_parse_int>:
    91c0:	55                   	push   %rbp
    91c1:	41 57                	push   %r15
    91c3:	41 56                	push   %r14
    91c5:	41 55                	push   %r13
    91c7:	41 54                	push   %r12
    91c9:	53                   	push   %rbx
    91ca:	48 83 ec 18          	sub    $0x18,%rsp
    91ce:	89 d3                	mov    %edx,%ebx
    91d0:	89 f5                	mov    %esi,%ebp
    91d2:	49 89 fe             	mov    %rdi,%r14
    91d5:	4c 8b 3f             	mov    (%rdi),%r15
    91d8:	49 83 c6 08          	add    $0x8,%r14
    91dc:	4c 89 f7             	mov    %r14,%rdi
    91df:	4c 89 fe             	mov    %r15,%rsi
    91e2:	e8 49 fc ff ff       	call   8e30 <fwp_valid_int>
    91e7:	85 c0                	test   %eax,%eax
    91e9:	0f 84 1a 01 00 00    	je     9309 <fwp_p_parse_int+0x149>
    91ef:	41 0f b6 06          	movzbl (%r14),%eax
    91f3:	31 ff                	xor    %edi,%edi
    91f5:	3c 2d                	cmp    $0x2d,%al
    91f7:	0f 94 c1             	sete   %cl
    91fa:	3c 2b                	cmp    $0x2b,%al
    91fc:	0f 94 c0             	sete   %al
    91ff:	08 c8                	or     %cl,%al
    9201:	44 0f b6 e0          	movzbl %al,%r12d
    9205:	4d 39 e7             	cmp    %r12,%r15
    9208:	0f 86 d0 00 00 00    	jbe    92de <fwp_p_parse_int+0x11e>
    920e:	88 4c 24 07          	mov    %cl,0x7(%rsp)
    9212:	89 6c 24 08          	mov    %ebp,0x8(%rsp)
    9216:	89 5c 24 0c          	mov    %ebx,0xc(%rsp)
    921a:	bf 0a 00 00 00       	mov    $0xa,%edi
    921f:	48 bb cd cc cc cc cc 	movabs $0xcccccccccccccccd,%rbx
    9226:	cc cc cc 
    9229:	48 bd cc cc cc cc cc 	movabs $0xcccccccccccccccc,%rbp
    9230:	cc cc cc 
    9233:	31 f6                	xor    %esi,%esi
    9235:	45 31 db             	xor    %r11d,%r11d
    9238:	0f 1f 84 00 00 00 00 	nopl   0x0(%rax,%rax,1)
    923f:	00 
    9240:	4d 89 dd             	mov    %r11,%r13
    9243:	49 89 f0             	mov    %rsi,%r8
    9246:	48 89 f0             	mov    %rsi,%rax
    9249:	48 f7 e7             	mul    %rdi
    924c:	4b 8d 0c 9b          	lea    (%r11,%r11,4),%rcx
    9250:	48 8d 0c 4a          	lea    (%rdx,%rcx,2),%rcx
    9254:	43 0f be 14 26       	movsbl (%r14,%r12,1),%edx
    9259:	83 c2 d0             	add    $0xffffffd0,%edx
    925c:	48 63 d2             	movslq %edx,%rdx
    925f:	49 89 d3             	mov    %rdx,%r11
    9262:	49 c1 fb 3f          	sar    $0x3f,%r11
    9266:	48 89 c6             	mov    %rax,%rsi
    9269:	48 01 d6             	add    %rdx,%rsi
    926c:	49 11 cb             	adc    %rcx,%r11
    926f:	4d 89 d9             	mov    %r11,%r9
    9272:	49 0f a4 f1 3f       	shld   $0x3f,%rsi,%r9
    9277:	4c 89 d9             	mov    %r11,%rcx
    927a:	48 d1 e9             	shr    $1,%rcx
    927d:	4d 89 ca             	mov    %r9,%r10
    9280:	49 01 ca             	add    %rcx,%r10
    9283:	49 83 d2 00          	adc    $0x0,%r10
    9287:	4c 89 d0             	mov    %r10,%rax
    928a:	48 f7 e3             	mul    %rbx
    928d:	48 c1 ea 02          	shr    $0x2,%rdx
    9291:	48 8d 04 92          	lea    (%rdx,%rdx,4),%rax
    9295:	49 29 c2             	sub    %rax,%r10
    9298:	4d 29 d1             	sub    %r10,%r9
    929b:	48 83 d9 00          	sbb    $0x0,%rcx
    929f:	4d 89 ca             	mov    %r9,%r10
    92a2:	4c 0f af d5          	imul   %rbp,%r10
    92a6:	4c 89 c8             	mov    %r9,%rax
    92a9:	48 f7 e3             	mul    %rbx
    92ac:	4c 01 d2             	add    %r10,%rdx
    92af:	48 0f af cb          	imul   %rbx,%rcx
    92b3:	48 01 d1             	add    %rdx,%rcx
    92b6:	4c 31 e9             	xor    %r13,%rcx
    92b9:	4c 31 c0             	xor    %r8,%rax
    92bc:	48 09 c8             	or     %rcx,%rax
    92bf:	75 48                	jne    9309 <fwp_p_parse_int+0x149>
    92c1:	49 ff c4             	inc    %r12
    92c4:	4d 39 e7             	cmp    %r12,%r15
    92c7:	0f 85 73 ff ff ff    	jne    9240 <fwp_p_parse_int+0x80>
    92cd:	8b 5c 24 0c          	mov    0xc(%rsp),%ebx
    92d1:	8b 6c 24 08          	mov    0x8(%rsp),%ebp
    92d5:	31 ff                	xor    %edi,%edi
    92d7:	0f b6 4c 24 07       	movzbl 0x7(%rsp),%ecx
    92dc:	eb 05                	jmp    92e3 <fwp_p_parse_int+0x123>
    92de:	31 f6                	xor    %esi,%esi
    92e0:	45 31 db             	xor    %r11d,%r11d
    92e3:	40 88 cf             	mov    %cl,%dil
    92e6:	4c 8d 4c 24 10       	lea    0x10(%rsp),%r9
    92eb:	4c 89 da             	mov    %r11,%rdx
    92ee:	89 e9                	mov    %ebp,%ecx
    92f0:	41 89 d8             	mov    %ebx,%r8d
    92f3:	e8 28 00 00 00       	call   9320 <fwp_int_in_range>
    92f8:	48 85 c0             	test   %rax,%rax
    92fb:	74 0c                	je     9309 <fwp_p_parse_int+0x149>
    92fd:	48 8b 7c 24 10       	mov    0x10(%rsp),%rdi
    9302:	e8 99 00 00 00       	call   93a0 <fwp_some>
    9307:	eb 02                	jmp    930b <fwp_p_parse_int+0x14b>
    9309:	31 c0                	xor    %eax,%eax
    930b:	48 83 c4 18          	add    $0x18,%rsp
    930f:	5b                   	pop    %rbx
    9310:	41 5c                	pop    %r12
    9312:	41 5d                	pop    %r13
    9314:	41 5e                	pop    %r14
    9316:	41 5f                	pop    %r15
    9318:	5d                   	pop    %rbp
    9319:	c3                   	ret
    931a:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)

0000000000009320 <fwp_int_in_range>:
    9320:	53                   	push   %rbx
    9321:	83 f9 09             	cmp    $0x9,%ecx
    9324:	75 24                	jne    934a <fwp_int_in_range+0x2a>
    9326:	85 ff                	test   %edi,%edi
    9328:	74 08                	je     9332 <fwp_int_in_range+0x12>
    932a:	48 89 f0             	mov    %rsi,%rax
    932d:	48 09 d0             	or     %rdx,%rax
    9330:	75 3c                	jne    936e <fwp_int_in_range+0x4e>
    9332:	48 89 f7             	mov    %rsi,%rdi
    9335:	48 89 d6             	mov    %rdx,%rsi
    9338:	4c 89 cb             	mov    %r9,%rbx
    933b:	e8 80 00 00 00       	call   93c0 <fwp_box_u128>
    9340:	48 89 03             	mov    %rax,(%rbx)
    9343:	b8 01 00 00 00       	mov    $0x1,%eax
    9348:	5b                   	pop    %rbx
    9349:	c3                   	ret
    934a:	48 89 f0             	mov    %rsi,%rax
    934d:	48 f7 d8             	neg    %rax
    9350:	48 b8 00 00 00 00 00 	movabs $0x8000000000000000,%rax
    9357:	00 00 80 
    935a:	49 89 c2             	mov    %rax,%r10
    935d:	49 19 d2             	sbb    %rdx,%r10
    9360:	72 0c                	jb     936e <fwp_int_in_range+0x4e>
    9362:	85 ff                	test   %edi,%edi
    9364:	75 0c                	jne    9372 <fwp_int_in_range+0x52>
    9366:	48 31 d0             	xor    %rdx,%rax
    9369:	48 09 f0             	or     %rsi,%rax
    936c:	75 04                	jne    9372 <fwp_int_in_range+0x52>
    936e:	31 c0                	xor    %eax,%eax
    9370:	5b                   	pop    %rbx
    9371:	c3                   	ret
    9372:	31 c0                	xor    %eax,%eax
    9374:	49 89 f2             	mov    %rsi,%r10
    9377:	49 f7 da             	neg    %r10
    937a:	48 19 d0             	sbb    %rdx,%rax
    937d:	85 ff                	test   %edi,%edi
    937f:	4c 0f 44 d6          	cmove  %rsi,%r10
    9383:	48 0f 44 c2          	cmove  %rdx,%rax
    9387:	4c 89 d7             	mov    %r10,%rdi
    938a:	48 89 c6             	mov    %rax,%rsi
    938d:	89 ca                	mov    %ecx,%edx
    938f:	44 89 c1             	mov    %r8d,%ecx
    9392:	4d 89 c8             	mov    %r9,%r8
    9395:	e8 56 00 00 00       	call   93f0 <fwp_int_fits>
    939a:	89 c0                	mov    %eax,%eax
    939c:	5b                   	pop    %rbx
    939d:	c3                   	ret
    939e:	66 90                	xchg   %ax,%ax

00000000000093a0 <fwp_some>:
    93a0:	50                   	push   %rax
    93a1:	48 89 3c 24          	mov    %rdi,(%rsp)
    93a5:	48 89 e2             	mov    %rsp,%rdx
    93a8:	bf 01 00 00 00       	mov    $0x1,%edi
    93ad:	be 01 00 00 00       	mov    $0x1,%esi
    93b2:	e8 59 c2 ff ff       	call   5610 <fwp_data>
    93b7:	59                   	pop    %rcx
    93b8:	c3                   	ret
    93b9:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)

00000000000093c0 <fwp_box_u128>:
    93c0:	41 56                	push   %r14
    93c2:	53                   	push   %rbx
    93c3:	50                   	push   %rax
    93c4:	48 89 f3             	mov    %rsi,%rbx
    93c7:	49 89 fe             	mov    %rdi,%r14
    93ca:	bf 10 00 00 00       	mov    $0x10,%edi
    93cf:	e8 cc d0 ff ff       	call   64a0 <fwp_alloc_leaf>
    93d4:	48 89 58 08          	mov    %rbx,0x8(%rax)
    93d8:	4c 89 30             	mov    %r14,(%rax)
    93db:	48 83 c4 08          	add    $0x8,%rsp
    93df:	5b                   	pop    %rbx
    93e0:	41 5e                	pop    %r14
    93e2:	c3                   	ret
    93e3:	66 66 66 66 2e 0f 1f 	data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    93ea:	84 00 00 00 00 00 

00000000000093f0 <fwp_int_fits>:
    93f0:	41 57                	push   %r15
    93f2:	41 56                	push   %r14
    93f4:	53                   	push   %rbx
    93f5:	31 c0                	xor    %eax,%eax
    93f7:	83 fa 14             	cmp    $0x14,%edx
    93fa:	0f 87 02 01 00 00    	ja     9502 <fwp_int_fits+0x112>
    9400:	89 d2                	mov    %edx,%edx
    9402:	4c 8d 0d 8f 3e 00 00 	lea    0x3e8f(%rip),%r9        # d298 <_IO_stdin_used+0x298>
    9409:	49 63 14 91          	movslq (%r9,%rdx,4),%rdx
    940d:	4c 01 ca             	add    %r9,%rdx
    9410:	ff e2                	jmp    *%rdx
    9412:	48 89 f9             	mov    %rdi,%rcx
    9415:	48 83 c1 80          	add    $0xffffffffffffff80,%rcx
    9419:	48 83 d6 ff          	adc    $0xffffffffffffffff,%rsi
    941d:	48 81 f9 00 ff ff ff 	cmp    $0xffffffffffffff00,%rcx
    9424:	eb 3b                	jmp    9461 <fwp_int_fits+0x71>
    9426:	48 89 f9             	mov    %rdi,%rcx
    9429:	48 81 c1 00 00 00 80 	add    $0xffffffff80000000,%rcx
    9430:	48 83 d6 ff          	adc    $0xffffffffffffffff,%rsi
    9434:	48 ba 00 00 00 00 ff 	movabs $0xffffffff00000000,%rdx
    943b:	ff ff ff 
    943e:	48 39 d1             	cmp    %rdx,%rcx
    9441:	eb 1e                	jmp    9461 <fwp_int_fits+0x71>
    9443:	31 c0                	xor    %eax,%eax
    9445:	b9 ff 00 00 00       	mov    $0xff,%ecx
    944a:	eb 2b                	jmp    9477 <fwp_int_fits+0x87>
    944c:	48 89 f9             	mov    %rdi,%rcx
    944f:	48 81 c1 00 80 ff ff 	add    $0xffffffffffff8000,%rcx
    9456:	48 83 d6 ff          	adc    $0xffffffffffffffff,%rsi
    945a:	48 81 f9 00 00 ff ff 	cmp    $0xffffffffffff0000,%rcx
    9461:	48 83 de ff          	sbb    $0xffffffffffffffff,%rsi
    9465:	0f 83 8f 00 00 00    	jae    94fa <fwp_int_fits+0x10a>
    946b:	e9 92 00 00 00       	jmp    9502 <fwp_int_fits+0x112>
    9470:	31 c0                	xor    %eax,%eax
    9472:	b9 ff ff 00 00       	mov    $0xffff,%ecx
    9477:	48 39 f9             	cmp    %rdi,%rcx
    947a:	b9 00 00 00 00       	mov    $0x0,%ecx
    947f:	48 19 f1             	sbb    %rsi,%rcx
    9482:	73 76                	jae    94fa <fwp_int_fits+0x10a>
    9484:	eb 7c                	jmp    9502 <fwp_int_fits+0x112>
    9486:	48 89 f9             	mov    %rdi,%rcx
    9489:	48 c1 e9 20          	shr    $0x20,%rcx
    948d:	48 09 f1             	or     %rsi,%rcx
    9490:	74 68                	je     94fa <fwp_int_fits+0x10a>
    9492:	eb 6e                	jmp    9502 <fwp_int_fits+0x112>
    9494:	48 b9 00 00 00 00 00 	movabs $0x8000000000000000,%rcx
    949b:	00 00 80 
    949e:	48 01 f9             	add    %rdi,%rcx
    94a1:	48 83 d6 ff          	adc    $0xffffffffffffffff,%rsi
    94a5:	48 83 fe ff          	cmp    $0xffffffffffffffff,%rsi
    94a9:	74 4f                	je     94fa <fwp_int_fits+0x10a>
    94ab:	eb 55                	jmp    9502 <fwp_int_fits+0x112>
    94ad:	4c 89 c3             	mov    %r8,%rbx
    94b0:	e8 5b 00 00 00       	call   9510 <fwp_box_i128>
    94b5:	49 89 d8             	mov    %rbx,%r8
    94b8:	48 89 c7             	mov    %rax,%rdi
    94bb:	eb 3d                	jmp    94fa <fwp_int_fits+0x10a>
    94bd:	4c 89 c3             	mov    %r8,%rbx
    94c0:	49 89 fe             	mov    %rdi,%r14
    94c3:	89 cf                	mov    %ecx,%edi
    94c5:	49 89 f7             	mov    %rsi,%r15
    94c8:	e8 73 00 00 00       	call   9540 <fwp_tint_max>
    94cd:	48 89 c1             	mov    %rax,%rcx
    94d0:	31 c0                	xor    %eax,%eax
    94d2:	49 89 c8             	mov    %rcx,%r8
    94d5:	49 f7 d8             	neg    %r8
    94d8:	41 b9 00 00 00 00    	mov    $0x0,%r9d
    94de:	49 19 d1             	sbb    %rdx,%r9
    94e1:	4c 39 f1             	cmp    %r14,%rcx
    94e4:	4c 19 fa             	sbb    %r15,%rdx
    94e7:	7c 19                	jl     9502 <fwp_int_fits+0x112>
    94e9:	4c 89 fe             	mov    %r15,%rsi
    94ec:	4c 89 f7             	mov    %r14,%rdi
    94ef:	4d 39 c6             	cmp    %r8,%r14
    94f2:	4c 19 ce             	sbb    %r9,%rsi
    94f5:	49 89 d8             	mov    %rbx,%r8
    94f8:	7c 08                	jl     9502 <fwp_int_fits+0x112>
    94fa:	49 89 38             	mov    %rdi,(%r8)
    94fd:	b8 01 00 00 00       	mov    $0x1,%eax
    9502:	5b                   	pop    %rbx
    9503:	41 5e                	pop    %r14
    9505:	41 5f                	pop    %r15
    9507:	c3                   	ret
    9508:	48 85 f6             	test   %rsi,%rsi
    950b:	74 ed                	je     94fa <fwp_int_fits+0x10a>
    950d:	eb f3                	jmp    9502 <fwp_int_fits+0x112>
    950f:	90                   	nop

0000000000009510 <fwp_box_i128>:
    9510:	41 56                	push   %r14
    9512:	53                   	push   %rbx
    9513:	50                   	push   %rax
    9514:	48 89 f3             	mov    %rsi,%rbx
    9517:	49 89 fe             	mov    %rdi,%r14
    951a:	bf 10 00 00 00       	mov    $0x10,%edi
    951f:	e8 7c cf ff ff       	call   64a0 <fwp_alloc_leaf>
    9524:	48 89 58 08          	mov    %rbx,0x8(%rax)
    9528:	4c 89 30             	mov    %r14,(%rax)
    952b:	48 83 c4 08          	add    $0x8,%rsp
    952f:	5b                   	pop    %rbx
    9530:	41 5e                	pop    %r14
    9532:	c3                   	ret
    9533:	66 66 66 66 2e 0f 1f 	data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    953a:	84 00 00 00 00 00 

0000000000009540 <fwp_tint_max>:
    9540:	85 ff                	test   %edi,%edi
    9542:	7e 27                	jle    956b <fwp_tint_max+0x2b>
    9544:	8d 47 ff             	lea    -0x1(%rdi),%eax
    9547:	83 f8 4f             	cmp    $0x4f,%eax
    954a:	41 b8 4f 00 00 00    	mov    $0x4f,%r8d
    9550:	44 0f 42 c0          	cmovb  %eax,%r8d
    9554:	41 ff c0             	inc    %r8d
    9557:	44 89 c6             	mov    %r8d,%esi
    955a:	83 e6 07             	and    $0x7,%esi
    955d:	83 ff 08             	cmp    $0x8,%edi
    9560:	73 11                	jae    9573 <fwp_tint_max+0x33>
    9562:	b8 01 00 00 00       	mov    $0x1,%eax
    9567:	31 c9                	xor    %ecx,%ecx
    9569:	eb 38                	jmp    95a3 <fwp_tint_max+0x63>
    956b:	31 c0                	xor    %eax,%eax
    956d:	31 c9                	xor    %ecx,%ecx
    956f:	48 89 ca             	mov    %rcx,%rdx
    9572:	c3                   	ret
    9573:	41 81 e0 f8 00 00 00 	and    $0xf8,%r8d
    957a:	b8 01 00 00 00       	mov    $0x1,%eax
    957f:	31 c9                	xor    %ecx,%ecx
    9581:	bf a1 19 00 00       	mov    $0x19a1,%edi
    9586:	66 2e 0f 1f 84 00 00 	cs nopw 0x0(%rax,%rax,1)
    958d:	00 00 00 
    9590:	48 f7 e7             	mul    %rdi
    9593:	48 69 c9 a1 19 00 00 	imul   $0x19a1,%rcx,%rcx
    959a:	48 01 d1             	add    %rdx,%rcx
    959d:	41 83 c0 f8          	add    $0xfffffff8,%r8d
    95a1:	75 ed                	jne    9590 <fwp_tint_max+0x50>
    95a3:	85 f6                	test   %esi,%esi
    95a5:	74 17                	je     95be <fwp_tint_max+0x7e>
    95a7:	bf 03 00 00 00       	mov    $0x3,%edi
    95ac:	0f 1f 40 00          	nopl   0x0(%rax)
    95b0:	48 f7 e7             	mul    %rdi
    95b3:	48 8d 0c 49          	lea    (%rcx,%rcx,2),%rcx
    95b7:	48 01 d1             	add    %rdx,%rcx
    95ba:	ff ce                	dec    %esi
    95bc:	75 f2                	jne    95b0 <fwp_tint_max+0x70>
    95be:	48 83 c0 ff          	add    $0xffffffffffffffff,%rax
    95c2:	48 83 d1 ff          	adc    $0xffffffffffffffff,%rcx
    95c6:	48 89 ca             	mov    %rcx,%rdx
    95c9:	48 c1 ea 3f          	shr    $0x3f,%rdx
    95cd:	48 01 c2             	add    %rax,%rdx
    95d0:	48 89 d0             	mov    %rdx,%rax
    95d3:	48 83 d1 00          	adc    $0x0,%rcx
    95d7:	48 0f ac c8 01       	shrd   $0x1,%rcx,%rax
    95dc:	48 d1 f9             	sar    $1,%rcx
    95df:	48 89 ca             	mov    %rcx,%rdx
    95e2:	c3                   	ret
    95e3:	66 66 66 66 2e 0f 1f 	data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    95ea:	84 00 00 00 00 00 

00000000000095f0 <fwp_valid_float>:
    95f0:	48 85 f6             	test   %rsi,%rsi
    95f3:	74 0e                	je     9603 <fwp_valid_float+0x13>
    95f5:	0f b6 07             	movzbl (%rdi),%eax
    95f8:	04 d5                	add    $0xd5,%al
    95fa:	31 d2                	xor    %edx,%edx
    95fc:	a8 fd                	test   $0xfd,%al
    95fe:	0f 94 c2             	sete   %dl
    9601:	eb 02                	jmp    9605 <fwp_valid_float+0x15>
    9603:	31 d2                	xor    %edx,%edx
    9605:	41 b1 01             	mov    $0x1,%r9b
    9608:	49 89 d0             	mov    %rdx,%r8
    960b:	48 39 f2             	cmp    %rsi,%rdx
    960e:	73 1d                	jae    962d <fwp_valid_float+0x3d>
    9610:	42 0f b6 04 07       	movzbl (%rdi,%r8,1),%eax
    9615:	8d 48 d0             	lea    -0x30(%rax),%ecx
    9618:	80 f9 09             	cmp    $0x9,%cl
    961b:	77 15                	ja     9632 <fwp_valid_float+0x42>
    961d:	49 ff c0             	inc    %r8
    9620:	4c 39 c6             	cmp    %r8,%rsi
    9623:	75 eb                	jne    9610 <fwp_valid_float+0x20>
    9625:	49 89 f0             	mov    %rsi,%r8
    9628:	48 89 f1             	mov    %rsi,%rcx
    962b:	eb 38                	jmp    9665 <fwp_valid_float+0x75>
    962d:	48 89 d1             	mov    %rdx,%rcx
    9630:	eb 33                	jmp    9665 <fwp_valid_float+0x75>
    9632:	3c 2e                	cmp    $0x2e,%al
    9634:	75 2c                	jne    9662 <fwp_valid_float+0x72>
    9636:	49 8d 48 01          	lea    0x1(%r8),%rcx
    963a:	48 39 f1             	cmp    %rsi,%rcx
    963d:	73 16                	jae    9655 <fwp_valid_float+0x65>
    963f:	90                   	nop
    9640:	0f b6 04 0f          	movzbl (%rdi,%rcx,1),%eax
    9644:	04 d0                	add    $0xd0,%al
    9646:	3c 09                	cmp    $0x9,%al
    9648:	77 0b                	ja     9655 <fwp_valid_float+0x65>
    964a:	48 ff c1             	inc    %rcx
    964d:	48 39 f1             	cmp    %rsi,%rcx
    9650:	72 ee                	jb     9640 <fwp_valid_float+0x50>
    9652:	48 89 f1             	mov    %rsi,%rcx
    9655:	48 8d 41 ff          	lea    -0x1(%rcx),%rax
    9659:	4c 39 c0             	cmp    %r8,%rax
    965c:	41 0f 94 c1          	sete   %r9b
    9660:	eb 03                	jmp    9665 <fwp_valid_float+0x75>
    9662:	4c 89 c1             	mov    %r8,%rcx
    9665:	31 c0                	xor    %eax,%eax
    9667:	49 39 d0             	cmp    %rdx,%r8
    966a:	75 06                	jne    9672 <fwp_valid_float+0x82>
    966c:	45 84 c9             	test   %r9b,%r9b
    966f:	74 01                	je     9672 <fwp_valid_float+0x82>
    9671:	c3                   	ret
    9672:	48 39 f1             	cmp    %rsi,%rcx
    9675:	73 58                	jae    96cf <fwp_valid_float+0xdf>
    9677:	0f b6 14 0f          	movzbl (%rdi,%rcx,1),%edx
    967b:	83 ca 20             	or     $0x20,%edx
    967e:	83 fa 65             	cmp    $0x65,%edx
    9681:	75 4c                	jne    96cf <fwp_valid_float+0xdf>
    9683:	48 8d 51 01          	lea    0x1(%rcx),%rdx
    9687:	48 39 f2             	cmp    %rsi,%rdx
    968a:	73 18                	jae    96a4 <fwp_valid_float+0xb4>
    968c:	44 0f b6 04 17       	movzbl (%rdi,%rdx,1),%r8d
    9691:	41 83 f8 2d          	cmp    $0x2d,%r8d
    9695:	74 06                	je     969d <fwp_valid_float+0xad>
    9697:	41 83 f8 2b          	cmp    $0x2b,%r8d
    969b:	75 07                	jne    96a4 <fwp_valid_float+0xb4>
    969d:	48 83 c1 02          	add    $0x2,%rcx
    96a1:	48 89 ca             	mov    %rcx,%rdx
    96a4:	48 39 f2             	cmp    %rsi,%rdx
    96a7:	73 c8                	jae    9671 <fwp_valid_float+0x81>
    96a9:	48 89 d1             	mov    %rdx,%rcx
    96ac:	0f 1f 40 00          	nopl   0x0(%rax)
    96b0:	44 0f b6 04 0f       	movzbl (%rdi,%rcx,1),%r8d
    96b5:	41 80 c0 d0          	add    $0xd0,%r8b
    96b9:	41 80 f8 09          	cmp    $0x9,%r8b
    96bd:	77 0b                	ja     96ca <fwp_valid_float+0xda>
    96bf:	48 ff c1             	inc    %rcx
    96c2:	48 39 ce             	cmp    %rcx,%rsi
    96c5:	75 e9                	jne    96b0 <fwp_valid_float+0xc0>
    96c7:	48 89 f1             	mov    %rsi,%rcx
    96ca:	48 39 d1             	cmp    %rdx,%rcx
    96cd:	74 a2                	je     9671 <fwp_valid_float+0x81>
    96cf:	31 c0                	xor    %eax,%eax
    96d1:	48 39 f1             	cmp    %rsi,%rcx
    96d4:	0f 94 c0             	sete   %al
    96d7:	c3                   	ret
    96d8:	0f 1f 84 00 00 00 00 	nopl   0x0(%rax,%rax,1)
    96df:	00 

00000000000096e0 <fwp_from_f32>:
    96e0:	66 0f 7e c0          	movd   %xmm0,%eax
    96e4:	c3                   	ret
    96e5:	66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
    96ec:	00 00 00 00 

00000000000096f0 <fwp_float_of>:
    96f0:	83 ff 0a             	cmp    $0xa,%edi
    96f3:	0f 85 57 92 ff ff    	jne    2950 <fwp_from_f64>
    96f9:	f2 0f 5a c0          	cvtsd2ss %xmm0,%xmm0
    96fd:	eb e1                	jmp    96e0 <fwp_from_f32>
    96ff:	90                   	nop

0000000000009700 <fwp_utf8_put>:
    9700:	50                   	push   %rax
    9701:	83 fe 7f             	cmp    $0x7f,%esi
    9704:	77 0f                	ja     9715 <fwp_utf8_put+0x15>
    9706:	40 88 74 24 04       	mov    %sil,0x4(%rsp)
    970b:	ba 01 00 00 00       	mov    $0x1,%edx
    9710:	e9 8e 00 00 00       	jmp    97a3 <fwp_utf8_put+0xa3>
    9715:	89 f0                	mov    %esi,%eax
    9717:	81 fe ff 07 00 00    	cmp    $0x7ff,%esi
    971d:	77 1d                	ja     973c <fwp_utf8_put+0x3c>
    971f:	c1 e8 06             	shr    $0x6,%eax
    9722:	0c c0                	or     $0xc0,%al
    9724:	88 44 24 04          	mov    %al,0x4(%rsp)
    9728:	40 80 e6 3f          	and    $0x3f,%sil
    972c:	40 80 ce 80          	or     $0x80,%sil
    9730:	40 88 74 24 05       	mov    %sil,0x5(%rsp)
    9735:	ba 02 00 00 00       	mov    $0x2,%edx
    973a:	eb 67                	jmp    97a3 <fwp_utf8_put+0xa3>
    973c:	81 fe ff ff 00 00    	cmp    $0xffff,%esi
    9742:	77 2a                	ja     976e <fwp_utf8_put+0x6e>
    9744:	c1 e8 0c             	shr    $0xc,%eax
    9747:	0c e0                	or     $0xe0,%al
    9749:	88 44 24 04          	mov    %al,0x4(%rsp)
    974d:	89 f0                	mov    %esi,%eax
    974f:	c1 e8 06             	shr    $0x6,%eax
    9752:	24 3f                	and    $0x3f,%al
    9754:	0c 80                	or     $0x80,%al
    9756:	88 44 24 05          	mov    %al,0x5(%rsp)
    975a:	40 80 e6 3f          	and    $0x3f,%sil
    975e:	40 80 ce 80          	or     $0x80,%sil
    9762:	40 88 74 24 06       	mov    %sil,0x6(%rsp)
    9767:	ba 03 00 00 00       	mov    $0x3,%edx
    976c:	eb 35                	jmp    97a3 <fwp_utf8_put+0xa3>
    976e:	c1 e8 12             	shr    $0x12,%eax
    9771:	0c f0                	or     $0xf0,%al
    9773:	88 44 24 04          	mov    %al,0x4(%rsp)
    9777:	89 f0                	mov    %esi,%eax
    9779:	c1 e8 0c             	shr    $0xc,%eax
    977c:	24 3f                	and    $0x3f,%al
    977e:	0c 80                	or     $0x80,%al
    9780:	88 44 24 05          	mov    %al,0x5(%rsp)
    9784:	89 f0                	mov    %esi,%eax
    9786:	c1 e8 06             	shr    $0x6,%eax
    9789:	24 3f                	and    $0x3f,%al
    978b:	0c 80                	or     $0x80,%al
    978d:	88 44 24 06          	mov    %al,0x6(%rsp)
    9791:	40 80 e6 3f          	and    $0x3f,%sil
    9795:	40 80 ce 80          	or     $0x80,%sil
    9799:	40 88 74 24 07       	mov    %sil,0x7(%rsp)
    979e:	ba 04 00 00 00       	mov    $0x4,%edx
    97a3:	48 8d 74 24 04       	lea    0x4(%rsp),%rsi
    97a8:	e8 43 df ff ff       	call   76f0 <buf_put>
    97ad:	58                   	pop    %rax
    97ae:	c3                   	ret
    97af:	90                   	nop

00000000000097b0 <tp_push>:
    97b0:	41 56                	push   %r14
    97b2:	53                   	push   %rbx
    97b3:	50                   	push   %rax
    97b4:	48 89 f3             	mov    %rsi,%rbx
    97b7:	49 89 fe             	mov    %rdi,%r14
    97ba:	48 8b 77 18          	mov    0x18(%rdi),%rsi
    97be:	48 3b 77 20          	cmp    0x20(%rdi),%rsi
    97c2:	75 2f                	jne    97f3 <tp_push+0x43>
    97c4:	48 8d 04 36          	lea    (%rsi,%rsi,1),%rax
    97c8:	48 85 f6             	test   %rsi,%rsi
    97cb:	ba 08 00 00 00       	mov    $0x8,%edx
    97d0:	48 0f 45 d0          	cmovne %rax,%rdx
    97d4:	49 89 56 20          	mov    %rdx,0x20(%r14)
    97d8:	49 8b 7e 10          	mov    0x10(%r14),%rdi
    97dc:	48 c1 e6 03          	shl    $0x3,%rsi
    97e0:	48 c1 e2 03          	shl    $0x3,%rdx
    97e4:	e8 07 dc ff ff       	call   73f0 <fwp_mem_realloc>
    97e9:	49 89 46 10          	mov    %rax,0x10(%r14)
    97ed:	49 8b 76 18          	mov    0x18(%r14),%rsi
    97f1:	eb 04                	jmp    97f7 <tp_push+0x47>
    97f3:	49 8b 46 10          	mov    0x10(%r14),%rax
    97f7:	48 8d 4e 01          	lea    0x1(%rsi),%rcx
    97fb:	49 89 4e 18          	mov    %rcx,0x18(%r14)
    97ff:	48 89 1c f0          	mov    %rbx,(%rax,%rsi,8)
    9803:	48 83 c4 08          	add    $0x8,%rsp
    9807:	5b                   	pop    %rbx
    9808:	41 5e                	pop    %r14
    980a:	c3                   	ret
    980b:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)

0000000000009810 <tp_is_delim>:
    9810:	b8 01 00 00 00       	mov    $0x1,%eax
    9815:	83 ff 2c             	cmp    $0x2c,%edi
    9818:	77 13                	ja     982d <tp_is_delim+0x1d>
    981a:	89 f9                	mov    %edi,%ecx
    981c:	48 ba 00 26 00 00 01 	movabs $0x130100002600,%rdx
    9823:	13 00 00 
    9826:	48 0f a3 ca          	bt     %rcx,%rdx
    982a:	73 01                	jae    982d <tp_is_delim+0x1d>
    982c:	c3                   	ret
    982d:	83 ff 5d             	cmp    $0x5d,%edi
    9830:	74 fa                	je     982c <tp_is_delim+0x1c>
    9832:	83 ff 7d             	cmp    $0x7d,%edi
    9835:	74 f5                	je     982c <tp_is_delim+0x1c>
    9837:	31 c0                	xor    %eax,%eax
    9839:	40 80 ff 3a          	cmp    $0x3a,%dil
    983d:	0f 94 c0             	sete   %al
    9840:	c3                   	ret
    9841:	66 66 66 66 66 66 2e 	data16 data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    9848:	0f 1f 84 00 00 00 00 
    984f:	00 

0000000000009850 <fwp_list_len>:
    9850:	31 c0                	xor    %eax,%eax
    9852:	48 85 ff             	test   %rdi,%rdi
    9855:	74 15                	je     986c <fwp_list_len+0x1c>
    9857:	66 0f 1f 84 00 00 00 	nopw   0x0(%rax,%rax,1)
    985e:	00 00 
    9860:	48 ff c0             	inc    %rax
    9863:	48 8b 7f 10          	mov    0x10(%rdi),%rdi
    9867:	48 85 ff             	test   %rdi,%rdi
    986a:	75 f4                	jne    9860 <fwp_list_len+0x10>
    986c:	c3                   	ret
    986d:	0f 1f 00             	nopl   (%rax)

0000000000009870 <fwp_map_find>:
    9870:	55                   	push   %rbp
    9871:	41 57                	push   %r15
    9873:	41 56                	push   %r14
    9875:	41 55                	push   %r13
    9877:	41 54                	push   %r12
    9879:	53                   	push   %rbx
    987a:	50                   	push   %rax
    987b:	49 89 f6             	mov    %rsi,%r14
    987e:	49 89 ff             	mov    %rdi,%r15
    9881:	48 8b 2f             	mov    (%rdi),%rbp
    9884:	8b 02                	mov    (%rdx),%eax
    9886:	83 f8 04             	cmp    $0x4,%eax
    9889:	72 53                	jb     98de <fwp_map_find+0x6e>
    988b:	83 c0 fb             	add    $0xfffffffb,%eax
    988e:	83 f8 04             	cmp    $0x4,%eax
    9891:	0f 83 a3 00 00 00    	jae    993a <fwp_map_find+0xca>
    9897:	48 85 ed             	test   %rbp,%rbp
    989a:	0f 84 f7 00 00 00    	je     9997 <fwp_map_find+0x127>
    98a0:	31 f6                	xor    %esi,%esi
    98a2:	48 b8 fe ff ff ff ff 	movabs $0x1ffffffffffffffe,%rax
    98a9:	ff ff 1f 
    98ac:	eb 0a                	jmp    98b8 <fwp_map_find+0x48>
    98ae:	66 90                	xchg   %ax,%ax
    98b0:	4c 89 e5             	mov    %r12,%rbp
    98b3:	48 39 ee             	cmp    %rbp,%rsi
    98b6:	73 74                	jae    992c <fwp_map_find+0xbc>
    98b8:	48 8d 14 2e          	lea    (%rsi,%rbp,1),%rdx
    98bc:	49 89 d4             	mov    %rdx,%r12
    98bf:	49 d1 ec             	shr    $1,%r12
    98c2:	48 21 c2             	and    %rax,%rdx
    98c5:	49 8b 54 d7 08       	mov    0x8(%r15,%rdx,8),%rdx
    98ca:	4c 39 f2             	cmp    %r14,%rdx
    98cd:	74 64                	je     9933 <fwp_map_find+0xc3>
    98cf:	73 df                	jae    98b0 <fwp_map_find+0x40>
    98d1:	49 ff c4             	inc    %r12
    98d4:	4c 89 e6             	mov    %r12,%rsi
    98d7:	48 39 ee             	cmp    %rbp,%rsi
    98da:	72 dc                	jb     98b8 <fwp_map_find+0x48>
    98dc:	eb 4e                	jmp    992c <fwp_map_find+0xbc>
    98de:	48 85 ed             	test   %rbp,%rbp
    98e1:	0f 84 b0 00 00 00    	je     9997 <fwp_map_find+0x127>
    98e7:	31 f6                	xor    %esi,%esi
    98e9:	48 b8 fe ff ff ff ff 	movabs $0x1ffffffffffffffe,%rax
    98f0:	ff ff 1f 
    98f3:	eb 13                	jmp    9908 <fwp_map_find+0x98>
    98f5:	66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
    98fc:	00 00 00 00 
    9900:	4c 89 e5             	mov    %r12,%rbp
    9903:	48 39 ee             	cmp    %rbp,%rsi
    9906:	73 24                	jae    992c <fwp_map_find+0xbc>
    9908:	48 8d 14 2e          	lea    (%rsi,%rbp,1),%rdx
    990c:	49 89 d4             	mov    %rdx,%r12
    990f:	49 d1 ec             	shr    $1,%r12
    9912:	48 21 c2             	and    %rax,%rdx
    9915:	49 8b 54 d7 08       	mov    0x8(%r15,%rdx,8),%rdx
    991a:	4c 39 f2             	cmp    %r14,%rdx
    991d:	74 14                	je     9933 <fwp_map_find+0xc3>
    991f:	7d df                	jge    9900 <fwp_map_find+0x90>
    9921:	49 ff c4             	inc    %r12
    9924:	4c 89 e6             	mov    %r12,%rsi
    9927:	48 39 ee             	cmp    %rbp,%rsi
    992a:	72 dc                	jb     9908 <fwp_map_find+0x98>
    992c:	31 c0                	xor    %eax,%eax
    992e:	49 89 f4             	mov    %rsi,%r12
    9931:	eb 69                	jmp    999c <fwp_map_find+0x12c>
    9933:	b8 01 00 00 00       	mov    $0x1,%eax
    9938:	eb 62                	jmp    999c <fwp_map_find+0x12c>
    993a:	48 85 ed             	test   %rbp,%rbp
    993d:	74 58                	je     9997 <fwp_map_find+0x127>
    993f:	49 89 d5             	mov    %rdx,%r13
    9942:	48 89 0c 24          	mov    %rcx,(%rsp)
    9946:	31 db                	xor    %ebx,%ebx
    9948:	eb 0e                	jmp    9958 <fwp_map_find+0xe8>
    994a:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)
    9950:	4c 89 e5             	mov    %r12,%rbp
    9953:	48 39 eb             	cmp    %rbp,%rbx
    9956:	73 38                	jae    9990 <fwp_map_find+0x120>
    9958:	48 8d 04 2b          	lea    (%rbx,%rbp,1),%rax
    995c:	49 89 c4             	mov    %rax,%r12
    995f:	49 d1 ec             	shr    $1,%r12
    9962:	48 b9 fe ff ff ff ff 	movabs $0x1ffffffffffffffe,%rcx
    9969:	ff ff 1f 
    996c:	48 21 c8             	and    %rcx,%rax
    996f:	49 8b 7c c7 08       	mov    0x8(%r15,%rax,8),%rdi
    9974:	4c 89 f6             	mov    %r14,%rsi
    9977:	4c 89 ea             	mov    %r13,%rdx
    997a:	e8 61 00 00 00       	call   99e0 <fwp_cmp>
    997f:	85 c0                	test   %eax,%eax
    9981:	74 2d                	je     99b0 <fwp_map_find+0x140>
    9983:	79 cb                	jns    9950 <fwp_map_find+0xe0>
    9985:	49 ff c4             	inc    %r12
    9988:	4c 89 e3             	mov    %r12,%rbx
    998b:	48 39 eb             	cmp    %rbp,%rbx
    998e:	72 c8                	jb     9958 <fwp_map_find+0xe8>
    9990:	31 c0                	xor    %eax,%eax
    9992:	49 89 dc             	mov    %rbx,%r12
    9995:	eb 1e                	jmp    99b5 <fwp_map_find+0x145>
    9997:	31 c0                	xor    %eax,%eax
    9999:	45 31 e4             	xor    %r12d,%r12d
    999c:	89 01                	mov    %eax,(%rcx)
    999e:	4c 89 e0             	mov    %r12,%rax
    99a1:	48 83 c4 08          	add    $0x8,%rsp
    99a5:	5b                   	pop    %rbx
    99a6:	41 5c                	pop    %r12
    99a8:	41 5d                	pop    %r13
    99aa:	41 5e                	pop    %r14
    99ac:	41 5f                	pop    %r15
    99ae:	5d                   	pop    %rbp
    99af:	c3                   	ret
    99b0:	b8 01 00 00 00       	mov    $0x1,%eax
    99b5:	48 8b 0c 24          	mov    (%rsp),%rcx
    99b9:	eb e1                	jmp    999c <fwp_map_find+0x12c>
    99bb:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)

00000000000099c0 <fwp_map_alloc>:
    99c0:	53                   	push   %rbx
    99c1:	48 89 fb             	mov    %rdi,%rbx
    99c4:	48 c1 e7 04          	shl    $0x4,%rdi
    99c8:	48 83 cf 08          	or     $0x8,%rdi
    99cc:	e8 2f 9b ff ff       	call   3500 <fwp_alloc>
    99d1:	48 89 18             	mov    %rbx,(%rax)
    99d4:	5b                   	pop    %rbx
    99d5:	c3                   	ret
    99d6:	66 2e 0f 1f 84 00 00 	cs nopw 0x0(%rax,%rax,1)
    99dd:	00 00 00 

00000000000099e0 <fwp_cmp>:
    99e0:	55                   	push   %rbp
    99e1:	41 57                	push   %r15
    99e3:	41 56                	push   %r14
    99e5:	41 55                	push   %r13
    99e7:	41 54                	push   %r12
    99e9:	53                   	push   %rbx
    99ea:	48 83 ec 18          	sub    $0x18,%rsp
    99ee:	48 89 f3             	mov    %rsi,%rbx
    99f1:	49 89 fe             	mov    %rdi,%r14
    99f4:	44 8b 2a             	mov    (%rdx),%r13d
    99f7:	49 83 fd 15          	cmp    $0x15,%r13
    99fb:	77 25                	ja     9a22 <fwp_cmp+0x42>
    99fd:	49 89 d7             	mov    %rdx,%r15
    9a00:	48 8d 05 e5 38 00 00 	lea    0x38e5(%rip),%rax        # d2ec <_IO_stdin_used+0x2ec>
    9a07:	4a 63 0c a8          	movslq (%rax,%r13,4),%rcx
    9a0b:	48 01 c1             	add    %rax,%rcx
    9a0e:	ff e1                	jmp    *%rcx
    9a10:	31 c9                	xor    %ecx,%ecx
    9a12:	49 39 de             	cmp    %rbx,%r14
    9a15:	0f 9f c1             	setg   %cl
    9a18:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    9a1d:	0f 4d c1             	cmovge %ecx,%eax
    9a20:	eb 10                	jmp    9a32 <fwp_cmp+0x52>
    9a22:	31 c9                	xor    %ecx,%ecx
    9a24:	49 39 de             	cmp    %rbx,%r14
    9a27:	0f 97 c1             	seta   %cl
    9a2a:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    9a2f:	0f 43 c1             	cmovae %ecx,%eax
    9a32:	48 83 c4 18          	add    $0x18,%rsp
    9a36:	5b                   	pop    %rbx
    9a37:	41 5c                	pop    %r12
    9a39:	41 5d                	pop    %r13
    9a3b:	41 5e                	pop    %r14
    9a3d:	41 5f                	pop    %r15
    9a3f:	5d                   	pop    %rbp
    9a40:	c3                   	ret
    9a41:	4d 8b 3e             	mov    (%r14),%r15
    9a44:	4c 8b 23             	mov    (%rbx),%r12
    9a47:	49 83 c6 08          	add    $0x8,%r14
    9a4b:	48 83 c3 08          	add    $0x8,%rbx
    9a4f:	4d 39 e7             	cmp    %r12,%r15
    9a52:	4c 89 e2             	mov    %r12,%rdx
    9a55:	49 0f 42 d7          	cmovb  %r15,%rdx
    9a59:	4c 89 f7             	mov    %r14,%rdi
    9a5c:	48 89 de             	mov    %rbx,%rsi
    9a5f:	e8 0c 88 ff ff       	call   2270 <memcmp@plt>
    9a64:	85 c0                	test   %eax,%eax
    9a66:	0f 84 ce 02 00 00    	je     9d3a <fwp_cmp+0x35a>
    9a6c:	c1 f8 1f             	sar    $0x1f,%eax
    9a6f:	83 c8 01             	or     $0x1,%eax
    9a72:	eb be                	jmp    9a32 <fwp_cmp+0x52>
    9a74:	49 8b 06             	mov    (%r14),%rax
    9a77:	48 8b 2b             	mov    (%rbx),%rbp
    9a7a:	48 39 e8             	cmp    %rbp,%rax
    9a7d:	48 89 6c 24 08       	mov    %rbp,0x8(%rsp)
    9a82:	48 89 44 24 10       	mov    %rax,0x10(%rsp)
    9a87:	48 0f 42 e8          	cmovb  %rax,%rbp
    9a8b:	48 85 ed             	test   %rbp,%rbp
    9a8e:	74 54                	je     9ae4 <fwp_cmp+0x104>
    9a90:	49 8b 47 38          	mov    0x38(%r15),%rax
    9a94:	48 89 04 24          	mov    %rax,(%rsp)
    9a98:	41 bc 10 00 00 00    	mov    $0x10,%r12d
    9a9e:	eb 09                	jmp    9aa9 <fwp_cmp+0xc9>
    9aa0:	49 83 c4 10          	add    $0x10,%r12
    9aa4:	48 ff cd             	dec    %rbp
    9aa7:	74 3b                	je     9ae4 <fwp_cmp+0x104>
    9aa9:	4b 8b 7c 26 f8       	mov    -0x8(%r14,%r12,1),%rdi
    9aae:	4a 8b 74 23 f8       	mov    -0x8(%rbx,%r12,1),%rsi
    9ab3:	48 8b 14 24          	mov    (%rsp),%rdx
    9ab7:	e8 24 ff ff ff       	call   99e0 <fwp_cmp>
    9abc:	85 c0                	test   %eax,%eax
    9abe:	0f 85 6e ff ff ff    	jne    9a32 <fwp_cmp+0x52>
    9ac4:	41 83 fd 12          	cmp    $0x12,%r13d
    9ac8:	75 d6                	jne    9aa0 <fwp_cmp+0xc0>
    9aca:	4b 8b 3c 26          	mov    (%r14,%r12,1),%rdi
    9ace:	4a 8b 34 23          	mov    (%rbx,%r12,1),%rsi
    9ad2:	49 8b 57 40          	mov    0x40(%r15),%rdx
    9ad6:	e8 05 ff ff ff       	call   99e0 <fwp_cmp>
    9adb:	85 c0                	test   %eax,%eax
    9add:	74 c1                	je     9aa0 <fwp_cmp+0xc0>
    9adf:	e9 4e ff ff ff       	jmp    9a32 <fwp_cmp+0x52>
    9ae4:	31 c9                	xor    %ecx,%ecx
    9ae6:	48 8b 44 24 08       	mov    0x8(%rsp),%rax
    9aeb:	48 39 44 24 10       	cmp    %rax,0x10(%rsp)
    9af0:	e9 32 ff ff ff       	jmp    9a27 <fwp_cmp+0x47>
    9af5:	4c 89 f7             	mov    %r14,%rdi
    9af8:	e8 73 02 00 00       	call   9d70 <fwp_u128>
    9afd:	49 89 c7             	mov    %rax,%r15
    9b00:	49 89 d6             	mov    %rdx,%r14
    9b03:	48 89 df             	mov    %rbx,%rdi
    9b06:	e8 65 02 00 00       	call   9d70 <fwp_u128>
    9b0b:	48 89 c1             	mov    %rax,%rcx
    9b0e:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    9b13:	49 39 cf             	cmp    %rcx,%r15
    9b16:	4c 89 f6             	mov    %r14,%rsi
    9b19:	48 19 d6             	sbb    %rdx,%rsi
    9b1c:	0f 82 10 ff ff ff    	jb     9a32 <fwp_cmp+0x52>
    9b22:	4c 39 f9             	cmp    %r15,%rcx
    9b25:	4c 19 f2             	sbb    %r14,%rdx
    9b28:	0f 92 c0             	setb   %al
    9b2b:	0f b6 c0             	movzbl %al,%eax
    9b2e:	e9 ff fe ff ff       	jmp    9a32 <fwp_cmp+0x52>
    9b33:	4c 89 f7             	mov    %r14,%rdi
    9b36:	e8 55 02 00 00       	call   9d90 <fwp_f32>
    9b3b:	e8 40 02 00 00       	call   9d80 <fwp_total_key32>
    9b40:	89 c5                	mov    %eax,%ebp
    9b42:	48 89 df             	mov    %rbx,%rdi
    9b45:	e8 46 02 00 00       	call   9d90 <fwp_f32>
    9b4a:	e8 31 02 00 00       	call   9d80 <fwp_total_key32>
    9b4f:	89 c1                	mov    %eax,%ecx
    9b51:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    9b56:	39 cd                	cmp    %ecx,%ebp
    9b58:	0f 8c d4 fe ff ff    	jl     9a32 <fwp_cmp+0x52>
    9b5e:	eb 2e                	jmp    9b8e <fwp_cmp+0x1ae>
    9b60:	4c 89 f7             	mov    %r14,%rdi
    9b63:	e8 48 bd ff ff       	call   58b0 <fwp_f64>
    9b68:	e8 33 02 00 00       	call   9da0 <fwp_total_key64>
    9b6d:	49 89 c6             	mov    %rax,%r14
    9b70:	48 89 df             	mov    %rbx,%rdi
    9b73:	e8 38 bd ff ff       	call   58b0 <fwp_f64>
    9b78:	e8 23 02 00 00       	call   9da0 <fwp_total_key64>
    9b7d:	48 89 c1             	mov    %rax,%rcx
    9b80:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    9b85:	49 39 ce             	cmp    %rcx,%r14
    9b88:	0f 8c a4 fe ff ff    	jl     9a32 <fwp_cmp+0x52>
    9b8e:	0f 9f c0             	setg   %al
    9b91:	0f b6 c0             	movzbl %al,%eax
    9b94:	e9 99 fe ff ff       	jmp    9a32 <fwp_cmp+0x52>
    9b99:	4c 89 f7             	mov    %r14,%rdi
    9b9c:	e8 bf 01 00 00       	call   9d60 <fwp_i128>
    9ba1:	49 89 c7             	mov    %rax,%r15
    9ba4:	49 89 d6             	mov    %rdx,%r14
    9ba7:	48 89 df             	mov    %rbx,%rdi
    9baa:	e8 b1 01 00 00       	call   9d60 <fwp_i128>
    9baf:	48 89 c1             	mov    %rax,%rcx
    9bb2:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    9bb7:	49 39 cf             	cmp    %rcx,%r15
    9bba:	4c 89 f6             	mov    %r14,%rsi
    9bbd:	48 19 d6             	sbb    %rdx,%rsi
    9bc0:	0f 8c 6c fe ff ff    	jl     9a32 <fwp_cmp+0x52>
    9bc6:	4c 39 f9             	cmp    %r15,%rcx
    9bc9:	4c 19 f2             	sbb    %r14,%rdx
    9bcc:	0f 9c c0             	setl   %al
    9bcf:	0f b6 c0             	movzbl %al,%eax
    9bd2:	e9 5b fe ff ff       	jmp    9a32 <fwp_cmp+0x52>
    9bd7:	4d 85 f6             	test   %r14,%r14
    9bda:	0f 94 c0             	sete   %al
    9bdd:	74 3e                	je     9c1d <fwp_cmp+0x23d>
    9bdf:	48 85 db             	test   %rbx,%rbx
    9be2:	74 39                	je     9c1d <fwp_cmp+0x23d>
    9be4:	4d 8b 7f 38          	mov    0x38(%r15),%r15
    9be8:	0f 1f 84 00 00 00 00 	nopl   0x0(%rax,%rax,1)
    9bef:	00 
    9bf0:	49 8b 7e 08          	mov    0x8(%r14),%rdi
    9bf4:	48 8b 73 08          	mov    0x8(%rbx),%rsi
    9bf8:	4c 89 fa             	mov    %r15,%rdx
    9bfb:	e8 e0 fd ff ff       	call   99e0 <fwp_cmp>
    9c00:	85 c0                	test   %eax,%eax
    9c02:	0f 85 2a fe ff ff    	jne    9a32 <fwp_cmp+0x52>
    9c08:	4d 8b 76 10          	mov    0x10(%r14),%r14
    9c0c:	48 8b 5b 10          	mov    0x10(%rbx),%rbx
    9c10:	4d 85 f6             	test   %r14,%r14
    9c13:	0f 94 c0             	sete   %al
    9c16:	74 05                	je     9c1d <fwp_cmp+0x23d>
    9c18:	48 85 db             	test   %rbx,%rbx
    9c1b:	75 d3                	jne    9bf0 <fwp_cmp+0x210>
    9c1d:	48 85 db             	test   %rbx,%rbx
    9c20:	0f 95 c1             	setne  %cl
    9c23:	08 c1                	or     %al,%cl
    9c25:	80 f1 01             	xor    $0x1,%cl
    9c28:	0f b6 c9             	movzbl %cl,%ecx
    9c2b:	84 c0                	test   %al,%al
    9c2d:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    9c32:	0f 44 c1             	cmove  %ecx,%eax
    9c35:	48 85 db             	test   %rbx,%rbx
    9c38:	0f 44 c1             	cmove  %ecx,%eax
    9c3b:	e9 f2 fd ff ff       	jmp    9a32 <fwp_cmp+0x52>
    9c40:	45 8b 67 10          	mov    0x10(%r15),%r12d
    9c44:	45 85 e4             	test   %r12d,%r12d
    9c47:	0f 8e f7 00 00 00    	jle    9d44 <fwp_cmp+0x364>
    9c4d:	4d 8b 7f 20          	mov    0x20(%r15),%r15
    9c51:	45 31 ed             	xor    %r13d,%r13d
    9c54:	66 66 66 2e 0f 1f 84 	data16 data16 cs nopw 0x0(%rax,%rax,1)
    9c5b:	00 00 00 00 00 
    9c60:	4b 8b 7c ee 08       	mov    0x8(%r14,%r13,8),%rdi
    9c65:	4a 8b 74 eb 08       	mov    0x8(%rbx,%r13,8),%rsi
    9c6a:	4b 8b 14 ef          	mov    (%r15,%r13,8),%rdx
    9c6e:	e8 6d fd ff ff       	call   99e0 <fwp_cmp>
    9c73:	85 c0                	test   %eax,%eax
    9c75:	0f 85 b7 fd ff ff    	jne    9a32 <fwp_cmp+0x52>
    9c7b:	49 ff c5             	inc    %r13
    9c7e:	31 c0                	xor    %eax,%eax
    9c80:	4d 39 ec             	cmp    %r13,%r12
    9c83:	75 db                	jne    9c60 <fwp_cmp+0x280>
    9c85:	e9 a8 fd ff ff       	jmp    9a32 <fwp_cmp+0x52>
    9c8a:	49 8b 06             	mov    (%r14),%rax
    9c8d:	4c 8b 2b             	mov    (%rbx),%r13
    9c90:	4c 39 e8             	cmp    %r13,%rax
    9c93:	4c 89 ed             	mov    %r13,%rbp
    9c96:	48 89 04 24          	mov    %rax,(%rsp)
    9c9a:	48 0f 42 e8          	cmovb  %rax,%rbp
    9c9e:	48 85 ed             	test   %rbp,%rbp
    9ca1:	74 2f                	je     9cd2 <fwp_cmp+0x2f2>
    9ca3:	4d 8b 7f 38          	mov    0x38(%r15),%r15
    9ca7:	45 31 e4             	xor    %r12d,%r12d
    9caa:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)
    9cb0:	4b 8b 7c e6 08       	mov    0x8(%r14,%r12,8),%rdi
    9cb5:	4a 8b 74 e3 08       	mov    0x8(%rbx,%r12,8),%rsi
    9cba:	4c 89 fa             	mov    %r15,%rdx
    9cbd:	e8 1e fd ff ff       	call   99e0 <fwp_cmp>
    9cc2:	85 c0                	test   %eax,%eax
    9cc4:	0f 85 68 fd ff ff    	jne    9a32 <fwp_cmp+0x52>
    9cca:	49 ff c4             	inc    %r12
    9ccd:	4c 39 e5             	cmp    %r12,%rbp
    9cd0:	75 de                	jne    9cb0 <fwp_cmp+0x2d0>
    9cd2:	31 c9                	xor    %ecx,%ecx
    9cd4:	4c 39 2c 24          	cmp    %r13,(%rsp)
    9cd8:	e9 4a fd ff ff       	jmp    9a27 <fwp_cmp+0x47>
    9cdd:	4c 89 f7             	mov    %r14,%rdi
    9ce0:	e8 db 00 00 00       	call   9dc0 <fwp_tag>
    9ce5:	89 c5                	mov    %eax,%ebp
    9ce7:	48 89 df             	mov    %rbx,%rdi
    9cea:	e8 d1 00 00 00       	call   9dc0 <fwp_tag>
    9cef:	39 c5                	cmp    %eax,%ebp
    9cf1:	75 58                	jne    9d4b <fwp_cmp+0x36b>
    9cf3:	49 8b 4f 28          	mov    0x28(%r15),%rcx
    9cf7:	89 e8                	mov    %ebp,%eax
    9cf9:	44 8b 24 81          	mov    (%rcx,%rax,4),%r12d
    9cfd:	45 85 e4             	test   %r12d,%r12d
    9d00:	7e 42                	jle    9d44 <fwp_cmp+0x364>
    9d02:	49 8b 4f 30          	mov    0x30(%r15),%rcx
    9d06:	4c 8b 3c c1          	mov    (%rcx,%rax,8),%r15
    9d0a:	45 31 ed             	xor    %r13d,%r13d
    9d0d:	0f 1f 00             	nopl   (%rax)
    9d10:	4b 8b 7c ee 08       	mov    0x8(%r14,%r13,8),%rdi
    9d15:	4a 8b 74 eb 08       	mov    0x8(%rbx,%r13,8),%rsi
    9d1a:	4b 8b 14 ef          	mov    (%r15,%r13,8),%rdx
    9d1e:	e8 bd fc ff ff       	call   99e0 <fwp_cmp>
    9d23:	85 c0                	test   %eax,%eax
    9d25:	0f 85 07 fd ff ff    	jne    9a32 <fwp_cmp+0x52>
    9d2b:	49 ff c5             	inc    %r13
    9d2e:	31 c0                	xor    %eax,%eax
    9d30:	4d 39 ec             	cmp    %r13,%r12
    9d33:	75 db                	jne    9d10 <fwp_cmp+0x330>
    9d35:	e9 f8 fc ff ff       	jmp    9a32 <fwp_cmp+0x52>
    9d3a:	31 c9                	xor    %ecx,%ecx
    9d3c:	4d 39 e7             	cmp    %r12,%r15
    9d3f:	e9 e3 fc ff ff       	jmp    9a27 <fwp_cmp+0x47>
    9d44:	31 c0                	xor    %eax,%eax
    9d46:	e9 e7 fc ff ff       	jmp    9a32 <fwp_cmp+0x52>
    9d4b:	0f 97 c0             	seta   %al
    9d4e:	0f b6 c8             	movzbl %al,%ecx
    9d51:	e9 d4 fc ff ff       	jmp    9a2a <fwp_cmp+0x4a>
    9d56:	66 2e 0f 1f 84 00 00 	cs nopw 0x0(%rax,%rax,1)
    9d5d:	00 00 00 

0000000000009d60 <fwp_i128>:
    9d60:	48 8b 07             	mov    (%rdi),%rax
    9d63:	48 8b 57 08          	mov    0x8(%rdi),%rdx
    9d67:	c3                   	ret
    9d68:	0f 1f 84 00 00 00 00 	nopl   0x0(%rax,%rax,1)
    9d6f:	00 

0000000000009d70 <fwp_u128>:
    9d70:	48 8b 07             	mov    (%rdi),%rax
    9d73:	48 8b 57 08          	mov    0x8(%rdi),%rdx
    9d77:	c3                   	ret
    9d78:	0f 1f 84 00 00 00 00 	nopl   0x0(%rax,%rax,1)
    9d7f:	00 

0000000000009d80 <fwp_total_key32>:
    9d80:	66 0f 7e c1          	movd   %xmm0,%ecx
    9d84:	89 c8                	mov    %ecx,%eax
    9d86:	c1 f8 1f             	sar    $0x1f,%eax
    9d89:	d1 e8                	shr    $1,%eax
    9d8b:	31 c8                	xor    %ecx,%eax
    9d8d:	c3                   	ret
    9d8e:	66 90                	xchg   %ax,%ax

0000000000009d90 <fwp_f32>:
    9d90:	66 0f 6e c7          	movd   %edi,%xmm0
    9d94:	c3                   	ret
    9d95:	66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
    9d9c:	00 00 00 00 

0000000000009da0 <fwp_total_key64>:
    9da0:	66 48 0f 7e c1       	movq   %xmm0,%rcx
    9da5:	48 89 c8             	mov    %rcx,%rax
    9da8:	48 c1 f8 3f          	sar    $0x3f,%rax
    9dac:	48 d1 e8             	shr    $1,%rax
    9daf:	48 31 c8             	xor    %rcx,%rax
    9db2:	c3                   	ret
    9db3:	66 66 66 66 2e 0f 1f 	data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    9dba:	84 00 00 00 00 00 

0000000000009dc0 <fwp_tag>:
    9dc0:	48 89 f8             	mov    %rdi,%rax
    9dc3:	48 81 ff ff 0f 00 00 	cmp    $0xfff,%rdi
    9dca:	76 02                	jbe    9dce <fwp_tag+0xe>
    9dcc:	8b 00                	mov    (%rax),%eax
    9dce:	c3                   	ret
    9dcf:	90                   	nop

0000000000009dd0 <fwp_transport_off>:
    9dd0:	50                   	push   %rax
    9dd1:	48 8d 3d d1 44 00 00 	lea    0x44d1(%rip),%rdi        # e2a9 <exec_in_fp0+0xc69>
    9dd8:	e8 53 82 ff ff       	call   2030 <getenv@plt>
    9ddd:	48 85 c0             	test   %rax,%rax
    9de0:	74 1a                	je     9dfc <fwp_transport_off+0x2c>
    9de2:	48 8d 35 ce 44 00 00 	lea    0x44ce(%rip),%rsi        # e2b7 <exec_in_fp0+0xc77>
    9de9:	48 89 c7             	mov    %rax,%rdi
    9dec:	e8 df 84 ff ff       	call   22d0 <strcmp@plt>
    9df1:	89 c1                	mov    %eax,%ecx
    9df3:	31 c0                	xor    %eax,%eax
    9df5:	85 c9                	test   %ecx,%ecx
    9df7:	0f 94 c0             	sete   %al
    9dfa:	59                   	pop    %rcx
    9dfb:	c3                   	ret
    9dfc:	31 c0                	xor    %eax,%eax
    9dfe:	59                   	pop    %rcx
    9dff:	c3                   	ret

0000000000009e00 <fwp_pipe_addr>:
    9e00:	50                   	push   %rax
    9e01:	0f 57 c0             	xorps  %xmm0,%xmm0
    9e04:	0f 11 47 5e          	movups %xmm0,0x5e(%rdi)
    9e08:	0f 11 47 52          	movups %xmm0,0x52(%rdi)
    9e0c:	0f 11 47 42          	movups %xmm0,0x42(%rdi)
    9e10:	0f 11 47 32          	movups %xmm0,0x32(%rdi)
    9e14:	0f 11 47 22          	movups %xmm0,0x22(%rdi)
    9e18:	0f 11 47 12          	movups %xmm0,0x12(%rdi)
    9e1c:	0f 11 47 02          	movups %xmm0,0x2(%rdi)
    9e20:	66 c7 07 01 00       	movw   $0x1,(%rdi)
    9e25:	48 83 c7 03          	add    $0x3,%rdi
    9e29:	48 8b 0e             	mov    (%rsi),%rcx
    9e2c:	4c 8b 46 08          	mov    0x8(%rsi),%r8
    9e30:	48 8d 15 86 44 00 00 	lea    0x4486(%rip),%rdx        # e2bd <exec_in_fp0+0xc7d>
    9e37:	be 6b 00 00 00       	mov    $0x6b,%esi
    9e3c:	31 c0                	xor    %eax,%eax
    9e3e:	e8 8d 83 ff ff       	call   21d0 <snprintf@plt>
    9e43:	83 c0 03             	add    $0x3,%eax
    9e46:	59                   	pop    %rcx
    9e47:	c3                   	ret
    9e48:	0f 1f 84 00 00 00 00 	nopl   0x0(%rax,%rax,1)
    9e4f:	00 

0000000000009e50 <fwp_now_ns>:
    9e50:	48 83 ec 18          	sub    $0x18,%rsp
    9e54:	48 8d 74 24 08       	lea    0x8(%rsp),%rsi
    9e59:	bf 01 00 00 00       	mov    $0x1,%edi
    9e5e:	e8 cd 82 ff ff       	call   2130 <clock_gettime@plt>
    9e63:	48 69 44 24 08 00 ca 	imul   $0x3b9aca00,0x8(%rsp),%rax
    9e6a:	9a 3b 
    9e6c:	48 03 44 24 10       	add    0x10(%rsp),%rax
    9e71:	48 83 c4 18          	add    $0x18,%rsp
    9e75:	c3                   	ret
    9e76:	66 2e 0f 1f 84 00 00 	cs nopw 0x0(%rax,%rax,1)
    9e7d:	00 00 00 

0000000000009e80 <fwp_ring_put>:
    9e80:	55                   	push   %rbp
    9e81:	41 57                	push   %r15
    9e83:	41 56                	push   %r14
    9e85:	41 55                	push   %r13
    9e87:	41 54                	push   %r12
    9e89:	53                   	push   %rbx
    9e8a:	48 83 ec 38          	sub    $0x38,%rsp
    9e8e:	48 89 3c 24          	mov    %rdi,(%rsp)
    9e92:	48 85 f6             	test   %rsi,%rsi
    9e95:	0f 84 27 01 00 00    	je     9fc2 <fwp_ring_put+0x142>
    9e9b:	f6 05 56 af 02 00 01 	testb  $0x1,0x2af56(%rip)        # 34df8 <fwp_po_gone>
    9ea2:	0f 85 1a 01 00 00    	jne    9fc2 <fwp_ring_put+0x142>
    9ea8:	48 89 f3             	mov    %rsi,%rbx
    9eab:	4c 8b 3d 3e af 02 00 	mov    0x2af3e(%rip),%r15        # 34df0 <fwp_po_ring>
    9eb2:	49 8d 87 00 10 00 00 	lea    0x1000(%r15),%rax
    9eb9:	48 89 44 24 28       	mov    %rax,0x28(%rsp)
    9ebe:	49 8d 87 c0 00 00 00 	lea    0xc0(%r15),%rax
    9ec5:	48 89 44 24 20       	mov    %rax,0x20(%rsp)
    9eca:	49 8d 87 c4 00 00 00 	lea    0xc4(%r15),%rax
    9ed1:	48 89 44 24 18       	mov    %rax,0x18(%rsp)
    9ed6:	49 8d 87 00 01 00 00 	lea    0x100(%r15),%rax
    9edd:	48 89 44 24 10       	mov    %rax,0x10(%rsp)
    9ee2:	49 8d 87 04 01 00 00 	lea    0x104(%r15),%rax
    9ee9:	48 89 44 24 08       	mov    %rax,0x8(%rsp)
    9eee:	4c 8b 74 24 28       	mov    0x28(%rsp),%r14
    9ef3:	66 66 66 66 2e 0f 1f 	data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    9efa:	84 00 00 00 00 00 
    9f00:	4d 8b 67 40          	mov    0x40(%r15),%r12
    9f04:	49 8b af 80 00 00 00 	mov    0x80(%r15),%rbp
    9f0b:	4d 8b 6f 08          	mov    0x8(%r15),%r13
    9f0f:	4c 29 e5             	sub    %r12,%rbp
    9f12:	4c 01 ed             	add    %r13,%rbp
    9f15:	74 69                	je     9f80 <fwp_ring_put+0x100>
    9f17:	48 39 eb             	cmp    %rbp,%rbx
    9f1a:	48 0f 42 eb          	cmovb  %rbx,%rbp
    9f1e:	49 8d 7d ff          	lea    -0x1(%r13),%rdi
    9f22:	4c 21 e7             	and    %r12,%rdi
    9f25:	49 29 fd             	sub    %rdi,%r13
    9f28:	4c 39 ed             	cmp    %r13,%rbp
    9f2b:	4c 0f 42 ed          	cmovb  %rbp,%r13
    9f2f:	4c 01 f7             	add    %r14,%rdi
    9f32:	48 89 5c 24 30       	mov    %rbx,0x30(%rsp)
    9f37:	48 8b 1c 24          	mov    (%rsp),%rbx
    9f3b:	48 89 de             	mov    %rbx,%rsi
    9f3e:	4c 89 ea             	mov    %r13,%rdx
    9f41:	e8 ea 83 ff ff       	call   2330 <memcpy@plt>
    9f46:	4a 8d 34 2b          	lea    (%rbx,%r13,1),%rsi
    9f4a:	48 89 ea             	mov    %rbp,%rdx
    9f4d:	4c 29 ea             	sub    %r13,%rdx
    9f50:	4c 89 f7             	mov    %r14,%rdi
    9f53:	e8 d8 83 ff ff       	call   2330 <memcpy@plt>
    9f58:	49 01 ec             	add    %rbp,%r12
    9f5b:	4d 89 67 40          	mov    %r12,0x40(%r15)
    9f5f:	48 8b 7c 24 20       	mov    0x20(%rsp),%rdi
    9f64:	48 8b 74 24 18       	mov    0x18(%rsp),%rsi
    9f69:	e8 82 02 00 00       	call   a1f0 <fwp_ring_wake>
    9f6e:	48 01 eb             	add    %rbp,%rbx
    9f71:	48 89 1c 24          	mov    %rbx,(%rsp)
    9f75:	48 8b 5c 24 30       	mov    0x30(%rsp),%rbx
    9f7a:	48 29 eb             	sub    %rbp,%rbx
    9f7d:	eb 31                	jmp    9fb0 <fwp_ring_put+0x130>
    9f7f:	90                   	nop
    9f80:	44 8b 05 39 ad 00 00 	mov    0xad39(%rip),%r8d        # 14cc0 <fwp_po_sock>
    9f87:	4c 89 ff             	mov    %r15,%rdi
    9f8a:	48 8b 74 24 10       	mov    0x10(%rsp),%rsi
    9f8f:	48 8b 54 24 08       	mov    0x8(%rsp),%rdx
    9f94:	48 8d 0d 35 02 00 00 	lea    0x235(%rip),%rcx        # a1d0 <fwp_ring_has_space>
    9f9b:	e8 f0 00 00 00       	call   a090 <fwp_ring_wait>
    9fa0:	85 c0                	test   %eax,%eax
    9fa2:	75 0c                	jne    9fb0 <fwp_ring_put+0x130>
    9fa4:	c6 05 4d ae 02 00 01 	movb   $0x1,0x2ae4d(%rip)        # 34df8 <fwp_po_gone>
    9fab:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)
    9fb0:	48 85 db             	test   %rbx,%rbx
    9fb3:	74 0d                	je     9fc2 <fwp_ring_put+0x142>
    9fb5:	f6 05 3c ae 02 00 01 	testb  $0x1,0x2ae3c(%rip)        # 34df8 <fwp_po_gone>
    9fbc:	0f 84 3e ff ff ff    	je     9f00 <fwp_ring_put+0x80>
    9fc2:	48 83 c4 38          	add    $0x38,%rsp
    9fc6:	5b                   	pop    %rbx
    9fc7:	41 5c                	pop    %r12
    9fc9:	41 5d                	pop    %r13
    9fcb:	41 5e                	pop    %r14
    9fcd:	41 5f                	pop    %r15
    9fcf:	5d                   	pop    %rbp
    9fd0:	c3                   	ret
    9fd1:	66 66 66 66 66 66 2e 	data16 data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    9fd8:	0f 1f 84 00 00 00 00 
    9fdf:	00 

0000000000009fe0 <fwp_po_flush_sock>:
    9fe0:	48 8b 15 01 ae 01 00 	mov    0x1ae01(%rip),%rdx        # 24de8 <fwp_po_len>
    9fe7:	48 85 d2             	test   %rdx,%rdx
    9fea:	74 17                	je     a003 <fwp_po_flush_sock+0x23>
    9fec:	50                   	push   %rax
    9fed:	8b 3d cd ac 00 00    	mov    0xaccd(%rip),%edi        # 14cc0 <fwp_po_sock>
    9ff3:	48 8d 35 f6 ad 01 00 	lea    0x1adf6(%rip),%rsi        # 24df0 <fwp_po_buf>
    9ffa:	e8 11 00 00 00       	call   a010 <fwp_po_write_raw>
    9fff:	48 83 c4 08          	add    $0x8,%rsp
    a003:	48 c7 05 da ad 01 00 	movq   $0x0,0x1adda(%rip)        # 24de8 <fwp_po_len>
    a00a:	00 00 00 00 
    a00e:	c3                   	ret
    a00f:	90                   	nop

000000000000a010 <fwp_po_write_raw>:
    a010:	48 85 d2             	test   %rdx,%rdx
    a013:	74 70                	je     a085 <fwp_po_write_raw+0x75>
    a015:	f6 05 dc ad 02 00 01 	testb  $0x1,0x2addc(%rip)        # 34df8 <fwp_po_gone>
    a01c:	75 67                	jne    a085 <fwp_po_write_raw+0x75>
    a01e:	55                   	push   %rbp
    a01f:	41 56                	push   %r14
    a021:	53                   	push   %rbx
    a022:	48 89 d3             	mov    %rdx,%rbx
    a025:	49 89 f6             	mov    %rsi,%r14
    a028:	89 fd                	mov    %edi,%ebp
    a02a:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)
    a030:	89 ef                	mov    %ebp,%edi
    a032:	4c 89 f6             	mov    %r14,%rsi
    a035:	48 89 da             	mov    %rbx,%rdx
    a038:	b9 00 40 00 00       	mov    $0x4000,%ecx
    a03d:	e8 5e 81 ff ff       	call   21a0 <send@plt>
    a042:	48 85 c0             	test   %rax,%rax
    a045:	78 19                	js     a060 <fwp_po_write_raw+0x50>
    a047:	74 31                	je     a07a <fwp_po_write_raw+0x6a>
    a049:	49 01 c6             	add    %rax,%r14
    a04c:	48 29 c3             	sub    %rax,%rbx
    a04f:	eb 19                	jmp    a06a <fwp_po_write_raw+0x5a>
    a051:	66 66 66 66 66 66 2e 	data16 data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    a058:	0f 1f 84 00 00 00 00 
    a05f:	00 
    a060:	e8 1b 80 ff ff       	call   2080 <__errno_location@plt>
    a065:	83 38 04             	cmpl   $0x4,(%rax)
    a068:	75 10                	jne    a07a <fwp_po_write_raw+0x6a>
    a06a:	48 85 db             	test   %rbx,%rbx
    a06d:	74 12                	je     a081 <fwp_po_write_raw+0x71>
    a06f:	f6 05 82 ad 02 00 01 	testb  $0x1,0x2ad82(%rip)        # 34df8 <fwp_po_gone>
    a076:	74 b8                	je     a030 <fwp_po_write_raw+0x20>
    a078:	eb 07                	jmp    a081 <fwp_po_write_raw+0x71>
    a07a:	c6 05 77 ad 02 00 01 	movb   $0x1,0x2ad77(%rip)        # 34df8 <fwp_po_gone>
    a081:	5b                   	pop    %rbx
    a082:	41 5e                	pop    %r14
    a084:	5d                   	pop    %rbp
    a085:	c3                   	ret
    a086:	66 2e 0f 1f 84 00 00 	cs nopw 0x0(%rax,%rax,1)
    a08d:	00 00 00 

000000000000a090 <fwp_ring_wait>:
    a090:	55                   	push   %rbp
    a091:	41 57                	push   %r15
    a093:	41 56                	push   %r14
    a095:	41 55                	push   %r13
    a097:	41 54                	push   %r12
    a099:	53                   	push   %rbx
    a09a:	50                   	push   %rax
    a09b:	44 89 44 24 04       	mov    %r8d,0x4(%rsp)
    a0a0:	49 89 cf             	mov    %rcx,%r15
    a0a3:	49 89 d6             	mov    %rdx,%r14
    a0a6:	49 89 f4             	mov    %rsi,%r12
    a0a9:	49 89 fd             	mov    %rdi,%r13
    a0ac:	8b 0d 12 ac 00 00    	mov    0xac12(%rip),%ecx        # 14cc4 <fwp_ring_spin>
    a0b2:	85 c9                	test   %ecx,%ecx
    a0b4:	78 06                	js     a0bc <fwp_ring_wait+0x2c>
    a0b6:	85 c9                	test   %ecx,%ecx
    a0b8:	75 1f                	jne    a0d9 <fwp_ring_wait+0x49>
    a0ba:	eb 6f                	jmp    a12b <fwp_ring_wait+0x9b>
    a0bc:	bf 54 00 00 00       	mov    $0x54,%edi
    a0c1:	e8 6a 83 ff ff       	call   2430 <sysconf@plt>
    a0c6:	31 c9                	xor    %ecx,%ecx
    a0c8:	48 83 f8 02          	cmp    $0x2,%rax
    a0cc:	0f 9d c1             	setge  %cl
    a0cf:	89 0d ef ab 00 00    	mov    %ecx,0xabef(%rip)        # 14cc4 <fwp_ring_spin>
    a0d5:	85 c9                	test   %ecx,%ecx
    a0d7:	74 52                	je     a12b <fwp_ring_wait+0x9b>
    a0d9:	4c 89 ef             	mov    %r13,%rdi
    a0dc:	41 ff d7             	call   *%r15
    a0df:	89 c1                	mov    %eax,%ecx
    a0e1:	b8 01 00 00 00       	mov    $0x1,%eax
    a0e6:	85 c9                	test   %ecx,%ecx
    a0e8:	75 6a                	jne    a154 <fwp_ring_wait+0xc4>
    a0ea:	bd 01 00 00 00       	mov    $0x1,%ebp
    a0ef:	31 db                	xor    %ebx,%ebx
    a0f1:	eb 19                	jmp    a10c <fwp_ring_wait+0x7c>
    a0f3:	48 05 50 c3 00 00    	add    $0xc350,%rax
    a0f9:	48 89 c3             	mov    %rax,%rbx
    a0fc:	0f 1f 40 00          	nopl   0x0(%rax)
    a100:	ff c5                	inc    %ebp
    a102:	4c 89 ef             	mov    %r13,%rdi
    a105:	41 ff d7             	call   *%r15
    a108:	85 c0                	test   %eax,%eax
    a10a:	75 43                	jne    a14f <fwp_ring_wait+0xbf>
    a10c:	e8 ff 00 00 00       	call   a210 <fwp_cpu_relax>
    a111:	40 f6 c5 3f          	test   $0x3f,%bpl
    a115:	75 e9                	jne    a100 <fwp_ring_wait+0x70>
    a117:	e8 34 81 ff ff       	call   2250 <sched_yield@plt>
    a11c:	e8 2f fd ff ff       	call   9e50 <fwp_now_ns>
    a121:	48 85 db             	test   %rbx,%rbx
    a124:	74 cd                	je     a0f3 <fwp_ring_wait+0x63>
    a126:	48 39 d8             	cmp    %rbx,%rax
    a129:	7e d5                	jle    a100 <fwp_ring_wait+0x70>
    a12b:	41 8b 2c 24          	mov    (%r12),%ebp
    a12f:	b8 01 00 00 00       	mov    $0x1,%eax
    a134:	41 87 06             	xchg   %eax,(%r14)
    a137:	0f ae f0             	mfence
    a13a:	4c 89 ef             	mov    %r13,%rdi
    a13d:	41 ff d7             	call   *%r15
    a140:	85 c0                	test   %eax,%eax
    a142:	8b 5c 24 04          	mov    0x4(%rsp),%ebx
    a146:	74 41                	je     a189 <fwp_ring_wait+0xf9>
    a148:	41 c7 06 00 00 00 00 	movl   $0x0,(%r14)
    a14f:	b8 01 00 00 00       	mov    $0x1,%eax
    a154:	48 83 c4 08          	add    $0x8,%rsp
    a158:	5b                   	pop    %rbx
    a159:	41 5c                	pop    %r12
    a15b:	41 5d                	pop    %r13
    a15d:	41 5e                	pop    %r14
    a15f:	41 5f                	pop    %r15
    a161:	5d                   	pop    %rbp
    a162:	c3                   	ret
    a163:	66 66 66 66 2e 0f 1f 	data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    a16a:	84 00 00 00 00 00 
    a170:	41 8b 2c 24          	mov    (%r12),%ebp
    a174:	b8 01 00 00 00       	mov    $0x1,%eax
    a179:	41 87 06             	xchg   %eax,(%r14)
    a17c:	0f ae f0             	mfence
    a17f:	4c 89 ef             	mov    %r13,%rdi
    a182:	41 ff d7             	call   *%r15
    a185:	85 c0                	test   %eax,%eax
    a187:	75 bf                	jne    a148 <fwp_ring_wait+0xb8>
    a189:	4c 89 e7             	mov    %r12,%rdi
    a18c:	31 f6                	xor    %esi,%esi
    a18e:	89 ea                	mov    %ebp,%edx
    a190:	b9 64 00 00 00       	mov    $0x64,%ecx
    a195:	e8 86 00 00 00       	call   a220 <fwp_futex>
    a19a:	48 89 c5             	mov    %rax,%rbp
    a19d:	41 c7 06 00 00 00 00 	movl   $0x0,(%r14)
    a1a4:	4c 89 ef             	mov    %r13,%rdi
    a1a7:	41 ff d7             	call   *%r15
    a1aa:	85 c0                	test   %eax,%eax
    a1ac:	75 a1                	jne    a14f <fwp_ring_wait+0xbf>
    a1ae:	48 85 ed             	test   %rbp,%rbp
    a1b1:	74 bd                	je     a170 <fwp_ring_wait+0xe0>
    a1b3:	e8 c8 7e ff ff       	call   2080 <__errno_location@plt>
    a1b8:	83 38 6e             	cmpl   $0x6e,(%rax)
    a1bb:	75 b3                	jne    a170 <fwp_ring_wait+0xe0>
    a1bd:	89 df                	mov    %ebx,%edi
    a1bf:	e8 cc 00 00 00       	call   a290 <fwp_sock_gone>
    a1c4:	85 c0                	test   %eax,%eax
    a1c6:	74 a8                	je     a170 <fwp_ring_wait+0xe0>
    a1c8:	31 c0                	xor    %eax,%eax
    a1ca:	eb 88                	jmp    a154 <fwp_ring_wait+0xc4>
    a1cc:	0f 1f 40 00          	nopl   0x0(%rax)

000000000000a1d0 <fwp_ring_has_space>:
    a1d0:	48 8b 8f 80 00 00 00 	mov    0x80(%rdi),%rcx
    a1d7:	48 2b 4f 40          	sub    0x40(%rdi),%rcx
    a1db:	31 c0                	xor    %eax,%eax
    a1dd:	48 03 4f 08          	add    0x8(%rdi),%rcx
    a1e1:	0f 95 c0             	setne  %al
    a1e4:	c3                   	ret
    a1e5:	66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
    a1ec:	00 00 00 00 

000000000000a1f0 <fwp_ring_wake>:
    a1f0:	0f ae f0             	mfence
    a1f3:	8b 06                	mov    (%rsi),%eax
    a1f5:	85 c0                	test   %eax,%eax
    a1f7:	74 14                	je     a20d <fwp_ring_wake+0x1d>
    a1f9:	f0 ff 07             	lock incl (%rdi)
    a1fc:	be 01 00 00 00       	mov    $0x1,%esi
    a201:	ba ff ff ff 7f       	mov    $0x7fffffff,%edx
    a206:	b9 ff ff ff ff       	mov    $0xffffffff,%ecx
    a20b:	eb 13                	jmp    a220 <fwp_futex>
    a20d:	c3                   	ret
    a20e:	66 90                	xchg   %ax,%ax

000000000000a210 <fwp_cpu_relax>:
    a210:	f3 90                	pause
    a212:	c3                   	ret
    a213:	66 66 66 66 2e 0f 1f 	data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    a21a:	84 00 00 00 00 00 

000000000000a220 <fwp_futex>:
    a220:	48 83 ec 18          	sub    $0x18,%rsp
    a224:	89 c8                	mov    %ecx,%eax
    a226:	89 d1                	mov    %edx,%ecx
    a228:	89 f2                	mov    %esi,%edx
    a22a:	48 89 fe             	mov    %rdi,%rsi
    a22d:	48 c7 44 24 08 00 00 	movq   $0x0,0x8(%rsp)
    a234:	00 00 
    a236:	48 98                	cltq
    a238:	48 69 f8 d3 4d 62 10 	imul   $0x10624dd3,%rax,%rdi
    a23f:	49 89 f8             	mov    %rdi,%r8
    a242:	49 c1 e8 3f          	shr    $0x3f,%r8
    a246:	48 c1 ff 26          	sar    $0x26,%rdi
    a24a:	44 01 c7             	add    %r8d,%edi
    a24d:	69 ff e8 03 00 00    	imul   $0x3e8,%edi,%edi
    a253:	41 89 c0             	mov    %eax,%r8d
    a256:	41 29 f8             	sub    %edi,%r8d
    a259:	41 69 f8 40 42 0f 00 	imul   $0xf4240,%r8d,%edi
    a260:	48 63 ff             	movslq %edi,%rdi
    a263:	48 89 7c 24 10       	mov    %rdi,0x10(%rsp)
    a268:	31 ff                	xor    %edi,%edi
    a26a:	85 c0                	test   %eax,%eax
    a26c:	4c 8d 44 24 08       	lea    0x8(%rsp),%r8
    a271:	4c 0f 48 c7          	cmovs  %rdi,%r8
    a275:	c7 04 24 00 00 00 00 	movl   $0x0,(%rsp)
    a27c:	bf ca 00 00 00       	mov    $0xca,%edi
    a281:	45 31 c9             	xor    %r9d,%r9d
    a284:	31 c0                	xor    %eax,%eax
    a286:	e8 75 80 ff ff       	call   2300 <syscall@plt>
    a28b:	48 83 c4 18          	add    $0x18,%rsp
    a28f:	c3                   	ret

000000000000a290 <fwp_sock_gone>:
    a290:	55                   	push   %rbp
    a291:	53                   	push   %rbx
    a292:	48 83 ec 18          	sub    $0x18,%rsp
    a296:	89 fb                	mov    %edi,%ebx
    a298:	89 7c 24 10          	mov    %edi,0x10(%rsp)
    a29c:	c7 44 24 14 01 00 00 	movl   $0x1,0x14(%rsp)
    a2a3:	00 
    a2a4:	48 8d 7c 24 10       	lea    0x10(%rsp),%rdi
    a2a9:	31 ed                	xor    %ebp,%ebp
    a2ab:	be 01 00 00 00       	mov    $0x1,%esi
    a2b0:	31 d2                	xor    %edx,%edx
    a2b2:	e8 09 81 ff ff       	call   23c0 <poll@plt>
    a2b7:	85 c0                	test   %eax,%eax
    a2b9:	7e 2b                	jle    a2e6 <fwp_sock_gone+0x56>
    a2bb:	bd 01 00 00 00       	mov    $0x1,%ebp
    a2c0:	f6 44 24 16 18       	testb  $0x18,0x16(%rsp)
    a2c5:	75 1f                	jne    a2e6 <fwp_sock_gone+0x56>
    a2c7:	48 8d 74 24 0f       	lea    0xf(%rsp),%rsi
    a2cc:	ba 01 00 00 00       	mov    $0x1,%edx
    a2d1:	89 df                	mov    %ebx,%edi
    a2d3:	b9 42 00 00 00       	mov    $0x42,%ecx
    a2d8:	e8 83 7d ff ff       	call   2060 <recv@plt>
    a2dd:	31 ed                	xor    %ebp,%ebp
    a2df:	48 85 c0             	test   %rax,%rax
    a2e2:	40 0f 94 c5          	sete   %bpl
    a2e6:	89 e8                	mov    %ebp,%eax
    a2e8:	48 83 c4 18          	add    $0x18,%rsp
    a2ec:	5b                   	pop    %rbx
    a2ed:	5d                   	pop    %rbp
    a2ee:	c3                   	ret
    a2ef:	90                   	nop

000000000000a2f0 <fwp_pipe_poll>:
    a2f0:	83 3d c5 a9 00 00 00 	cmpl   $0x0,0xa9c5(%rip)        # 14cbc <fwp_po_listen>
    a2f7:	0f 88 9b 01 00 00    	js     a498 <fwp_pipe_poll+0x1a8>
    a2fd:	55                   	push   %rbp
    a2fe:	41 57                	push   %r15
    a300:	41 56                	push   %r14
    a302:	53                   	push   %rbx
    a303:	48 83 ec 28          	sub    $0x28,%rsp
    a307:	e8 44 fb ff ff       	call   9e50 <fwp_now_ns>
    a30c:	48 3b 05 ed aa 02 00 	cmp    0x2aaed(%rip),%rax        # 34e00 <fwp_po_next_check>
    a313:	0f 8c 75 01 00 00    	jl     a48e <fwp_pipe_poll+0x19e>
    a319:	49 89 c6             	mov    %rax,%r14
    a31c:	48 05 40 42 0f 00    	add    $0xf4240,%rax
    a322:	48 89 05 d7 aa 02 00 	mov    %rax,0x2aad7(%rip)        # 34e00 <fwp_po_next_check>
    a329:	8b 3d 8d a9 00 00    	mov    0xa98d(%rip),%edi        # 14cbc <fwp_po_listen>
    a32f:	31 f6                	xor    %esi,%esi
    a331:	31 d2                	xor    %edx,%edx
    a333:	e8 08 81 ff ff       	call   2440 <accept@plt>
    a338:	85 c0                	test   %eax,%eax
    a33a:	0f 88 10 01 00 00    	js     a450 <fwp_pipe_poll+0x160>
    a340:	89 c3                	mov    %eax,%ebx
    a342:	8b 3d 74 a9 00 00    	mov    0xa974(%rip),%edi        # 14cbc <fwp_po_listen>
    a348:	e8 e3 7e ff ff       	call   2230 <close@plt>
    a34d:	c7 05 65 a9 00 00 ff 	movl   $0xffffffff,0xa965(%rip)        # 14cbc <fwp_po_listen>
    a354:	ff ff ff 
    a357:	89 df                	mov    %ebx,%edi
    a359:	be 02 00 00 00       	mov    $0x2,%esi
    a35e:	ba 01 00 00 00       	mov    $0x1,%edx
    a363:	31 c0                	xor    %eax,%eax
    a365:	e8 b6 7d ff ff       	call   2120 <fcntl@plt>
    a36a:	89 df                	mov    %ebx,%edi
    a36c:	be 03 00 00 00       	mov    $0x3,%esi
    a371:	31 c0                	xor    %eax,%eax
    a373:	e8 a8 7d ff ff       	call   2120 <fcntl@plt>
    a378:	25 ff f7 ff ff       	and    $0xfffff7ff,%eax
    a37d:	89 df                	mov    %ebx,%edi
    a37f:	be 04 00 00 00       	mov    $0x4,%esi
    a384:	89 c2                	mov    %eax,%edx
    a386:	31 c0                	xor    %eax,%eax
    a388:	e8 93 7d ff ff       	call   2120 <fcntl@plt>
    a38d:	c7 44 24 18 0c 00 00 	movl   $0xc,0x18(%rsp)
    a394:	00 
    a395:	89 5c 24 10          	mov    %ebx,0x10(%rsp)
    a399:	c7 44 24 14 01 00 00 	movl   $0x1,0x14(%rsp)
    a3a0:	00 
    a3a1:	48 8d 4c 24 1c       	lea    0x1c(%rsp),%rcx
    a3a6:	4c 8d 44 24 18       	lea    0x18(%rsp),%r8
    a3ab:	89 df                	mov    %ebx,%edi
    a3ad:	be 01 00 00 00       	mov    $0x1,%esi
    a3b2:	ba 11 00 00 00       	mov    $0x11,%edx
    a3b7:	e8 e4 7e ff ff       	call   22a0 <getsockopt@plt>
    a3bc:	85 c0                	test   %eax,%eax
    a3be:	0f 85 c3 00 00 00    	jne    a487 <fwp_pipe_poll+0x197>
    a3c4:	8b 6c 24 20          	mov    0x20(%rsp),%ebp
    a3c8:	e8 b3 7d ff ff       	call   2180 <getuid@plt>
    a3cd:	39 c5                	cmp    %eax,%ebp
    a3cf:	0f 85 b2 00 00 00    	jne    a487 <fwp_pipe_poll+0x197>
    a3d5:	48 8d 7c 24 10       	lea    0x10(%rsp),%rdi
    a3da:	be 01 00 00 00       	mov    $0x1,%esi
    a3df:	ba e8 03 00 00       	mov    $0x3e8,%edx
    a3e4:	e8 d7 7f ff ff       	call   23c0 <poll@plt>
    a3e9:	85 c0                	test   %eax,%eax
    a3eb:	0f 8e 96 00 00 00    	jle    a487 <fwp_pipe_poll+0x197>
    a3f1:	48 8d 74 24 03       	lea    0x3(%rsp),%rsi
    a3f6:	ba 05 00 00 00       	mov    $0x5,%edx
    a3fb:	89 df                	mov    %ebx,%edi
    a3fd:	31 c9                	xor    %ecx,%ecx
    a3ff:	e8 5c 7c ff ff       	call   2060 <recv@plt>
    a404:	48 85 c0             	test   %rax,%rax
    a407:	7e 7e                	jle    a487 <fwp_pipe_poll+0x197>
    a409:	49 89 c6             	mov    %rax,%r14
    a40c:	4c 8d 7c 24 10       	lea    0x10(%rsp),%r15
    a411:	49 83 fe 04          	cmp    $0x4,%r14
    a415:	77 59                	ja     a470 <fwp_pipe_poll+0x180>
    a417:	be 01 00 00 00       	mov    $0x1,%esi
    a41c:	4c 89 ff             	mov    %r15,%rdi
    a41f:	ba e8 03 00 00       	mov    $0x3e8,%edx
    a424:	e8 97 7f ff ff       	call   23c0 <poll@plt>
    a429:	85 c0                	test   %eax,%eax
    a42b:	7e 5a                	jle    a487 <fwp_pipe_poll+0x197>
    a42d:	4a 8d 34 34          	lea    (%rsp,%r14,1),%rsi
    a431:	48 83 c6 03          	add    $0x3,%rsi
    a435:	ba 05 00 00 00       	mov    $0x5,%edx
    a43a:	4c 29 f2             	sub    %r14,%rdx
    a43d:	89 df                	mov    %ebx,%edi
    a43f:	31 c9                	xor    %ecx,%ecx
    a441:	e8 1a 7c ff ff       	call   2060 <recv@plt>
    a446:	49 01 c6             	add    %rax,%r14
    a449:	48 85 c0             	test   %rax,%rax
    a44c:	7f c3                	jg     a411 <fwp_pipe_poll+0x121>
    a44e:	eb 37                	jmp    a487 <fwp_pipe_poll+0x197>
    a450:	4c 3b 35 81 a9 01 00 	cmp    0x1a981(%rip),%r14        # 24dd8 <fwp_po_give_up>
    a457:	7e 35                	jle    a48e <fwp_pipe_poll+0x19e>
    a459:	8b 3d 5d a8 00 00    	mov    0xa85d(%rip),%edi        # 14cbc <fwp_po_listen>
    a45f:	e8 cc 7d ff ff       	call   2230 <close@plt>
    a464:	c7 05 4e a8 00 00 ff 	movl   $0xffffffff,0xa84e(%rip)        # 14cbc <fwp_po_listen>
    a46b:	ff ff ff 
    a46e:	eb 1e                	jmp    a48e <fwp_pipe_poll+0x19e>
    a470:	81 7c 24 03 46 57 50 	cmpl   $0x54505746,0x3(%rsp)
    a477:	54 
    a478:	75 0d                	jne    a487 <fwp_pipe_poll+0x197>
    a47a:	0f b6 44 24 07       	movzbl 0x7(%rsp),%eax
    a47f:	8d 48 fd             	lea    -0x3(%rax),%ecx
    a482:	80 f9 fd             	cmp    $0xfd,%cl
    a485:	77 12                	ja     a499 <fwp_pipe_poll+0x1a9>
    a487:	89 df                	mov    %ebx,%edi
    a489:	e8 a2 7d ff ff       	call   2230 <close@plt>
    a48e:	48 83 c4 28          	add    $0x28,%rsp
    a492:	5b                   	pop    %rbx
    a493:	41 5e                	pop    %r14
    a495:	41 5f                	pop    %r15
    a497:	5d                   	pop    %rbp
    a498:	c3                   	ret
    a499:	89 1d 21 a8 00 00    	mov    %ebx,0xa821(%rip)        # 14cc0 <fwp_po_sock>
    a49f:	bb 01 00 00 00       	mov    $0x1,%ebx
    a4a4:	3c 02                	cmp    $0x2,%al
    a4a6:	75 10                	jne    a4b8 <fwp_pipe_poll+0x1c8>
    a4a8:	e8 53 00 00 00       	call   a500 <fwp_po_make_ring>
    a4ad:	83 f8 01             	cmp    $0x1,%eax
    a4b0:	bb 02 00 00 00       	mov    $0x2,%ebx
    a4b5:	83 db 00             	sbb    $0x0,%ebx
    a4b8:	c7 44 24 08 02 01 00 	movl   $0x102,0x8(%rsp)
    a4bf:	00 
    a4c0:	c6 44 24 0c 00       	movb   $0x0,0xc(%rsp)
    a4c5:	88 5c 24 0d          	mov    %bl,0xd(%rsp)
    a4c9:	4c 8b 35 e0 8a 00 00 	mov    0x8ae0(%rip),%r14        # 12fb0 <stdout@GLIBC_2.2.5>
    a4d0:	49 8b 0e             	mov    (%r14),%rcx
    a4d3:	48 8d 7c 24 08       	lea    0x8(%rsp),%rdi
    a4d8:	be 01 00 00 00       	mov    $0x1,%esi
    a4dd:	ba 06 00 00 00       	mov    $0x6,%edx
    a4e2:	e8 b9 7f ff ff       	call   24a0 <fwrite@plt>
    a4e7:	49 8b 3e             	mov    (%r14),%rdi
    a4ea:	e8 61 7e ff ff       	call   2350 <fflush@plt>
    a4ef:	89 1d eb a8 01 00    	mov    %ebx,0x1a8eb(%rip)        # 24de0 <fwp_po_kind>
    a4f5:	eb 97                	jmp    a48e <fwp_pipe_poll+0x19e>
    a4f7:	66 0f 1f 84 00 00 00 	nopw   0x0(%rax,%rax,1)
    a4fe:	00 00 

000000000000a500 <fwp_po_make_ring>:
    a500:	55                   	push   %rbp
    a501:	41 57                	push   %r15
    a503:	41 56                	push   %r14
    a505:	53                   	push   %rbx
    a506:	48 83 ec 68          	sub    $0x68,%rsp
    a50a:	48 8d 35 c4 3d 00 00 	lea    0x3dc4(%rip),%rsi        # e2d5 <exec_in_fp0+0xc95>
    a511:	31 ed                	xor    %ebp,%ebp
    a513:	bf 3f 01 00 00       	mov    $0x13f,%edi
    a518:	ba 01 00 00 00       	mov    $0x1,%edx
    a51d:	31 c0                	xor    %eax,%eax
    a51f:	e8 dc 7d ff ff       	call   2300 <syscall@plt>
    a524:	48 89 c3             	mov    %rax,%rbx
    a527:	85 db                	test   %ebx,%ebx
    a529:	78 17                	js     a542 <fwp_po_make_ring+0x42>
    a52b:	be 00 10 10 00       	mov    $0x101000,%esi
    a530:	89 df                	mov    %ebx,%edi
    a532:	e8 a9 7c ff ff       	call   21e0 <ftruncate@plt>
    a537:	85 c0                	test   %eax,%eax
    a539:	74 14                	je     a54f <fwp_po_make_ring+0x4f>
    a53b:	89 df                	mov    %ebx,%edi
    a53d:	e8 ee 7c ff ff       	call   2230 <close@plt>
    a542:	89 e8                	mov    %ebp,%eax
    a544:	48 83 c4 68          	add    $0x68,%rsp
    a548:	5b                   	pop    %rbx
    a549:	41 5e                	pop    %r14
    a54b:	41 5f                	pop    %r15
    a54d:	5d                   	pop    %rbp
    a54e:	c3                   	ret
    a54f:	be 00 10 10 00       	mov    $0x101000,%esi
    a554:	31 ff                	xor    %edi,%edi
    a556:	ba 03 00 00 00       	mov    $0x3,%edx
    a55b:	b9 01 00 00 00       	mov    $0x1,%ecx
    a560:	41 89 d8             	mov    %ebx,%r8d
    a563:	45 31 c9             	xor    %r9d,%r9d
    a566:	e8 25 7c ff ff       	call   2190 <mmap@plt>
    a56b:	48 83 f8 ff          	cmp    $0xffffffffffffffff,%rax
    a56f:	74 ca                	je     a53b <fwp_po_make_ring+0x3b>
    a571:	49 89 c6             	mov    %rax,%r14
    a574:	48 b8 46 57 50 53 01 	movabs $0x153505746,%rax
    a57b:	00 00 00 
    a57e:	49 89 06             	mov    %rax,(%r14)
    a581:	49 c7 46 08 00 00 10 	movq   $0x100000,0x8(%r14)
    a588:	00 
    a589:	c6 44 24 07 53       	movb   $0x53,0x7(%rsp)
    a58e:	48 8d 44 24 07       	lea    0x7(%rsp),%rax
    a593:	48 89 44 24 20       	mov    %rax,0x20(%rsp)
    a598:	48 c7 44 24 28 01 00 	movq   $0x1,0x28(%rsp)
    a59f:	00 00 
    a5a1:	48 c7 44 24 18 00 00 	movq   $0x0,0x18(%rsp)
    a5a8:	00 00 
    a5aa:	0f 57 c0             	xorps  %xmm0,%xmm0
    a5ad:	0f 29 44 24 40       	movaps %xmm0,0x40(%rsp)
    a5b2:	0f 29 44 24 50       	movaps %xmm0,0x50(%rsp)
    a5b7:	0f 29 44 24 30       	movaps %xmm0,0x30(%rsp)
    a5bc:	48 c7 44 24 60 00 00 	movq   $0x0,0x60(%rsp)
    a5c3:	00 00 
    a5c5:	48 8d 44 24 20       	lea    0x20(%rsp),%rax
    a5ca:	48 89 44 24 40       	mov    %rax,0x40(%rsp)
    a5cf:	48 c7 44 24 48 01 00 	movq   $0x1,0x48(%rsp)
    a5d6:	00 00 
    a5d8:	48 8d 44 24 08       	lea    0x8(%rsp),%rax
    a5dd:	48 89 44 24 50       	mov    %rax,0x50(%rsp)
    a5e2:	48 c7 44 24 58 18 00 	movq   $0x18,0x58(%rsp)
    a5e9:	00 00 
    a5eb:	48 b8 01 00 00 00 01 	movabs $0x100000001,%rax
    a5f2:	00 00 00 
    a5f5:	48 89 44 24 10       	mov    %rax,0x10(%rsp)
    a5fa:	48 c7 44 24 08 14 00 	movq   $0x14,0x8(%rsp)
    a601:	00 00 
    a603:	89 5c 24 18          	mov    %ebx,0x18(%rsp)
    a607:	8b 3d b3 a6 00 00    	mov    0xa6b3(%rip),%edi        # 14cc0 <fwp_po_sock>
    a60d:	48 8d 74 24 30       	lea    0x30(%rsp),%rsi
    a612:	ba 00 40 00 00       	mov    $0x4000,%edx
    a617:	e8 a4 7a ff ff       	call   20c0 <sendmsg@plt>
    a61c:	49 89 c7             	mov    %rax,%r15
    a61f:	89 df                	mov    %ebx,%edi
    a621:	e8 0a 7c ff ff       	call   2230 <close@plt>
    a626:	49 83 ff 01          	cmp    $0x1,%r15
    a62a:	75 11                	jne    a63d <fwp_po_make_ring+0x13d>
    a62c:	4c 89 35 bd a7 02 00 	mov    %r14,0x2a7bd(%rip)        # 34df0 <fwp_po_ring>
    a633:	bd 01 00 00 00       	mov    $0x1,%ebp
    a638:	e9 05 ff ff ff       	jmp    a542 <fwp_po_make_ring+0x42>
    a63d:	be 00 10 10 00       	mov    $0x101000,%esi
    a642:	4c 89 f7             	mov    %r14,%rdi
    a645:	e8 46 7d ff ff       	call   2390 <munmap@plt>
    a64a:	31 ed                	xor    %ebp,%ebp
    a64c:	e9 f1 fe ff ff       	jmp    a542 <fwp_po_make_ring+0x42>
    a651:	66 66 66 66 66 66 2e 	data16 data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    a658:	0f 1f 84 00 00 00 00 
    a65f:	00 

000000000000a660 <fwp_apply>:
    a660:	55                   	push   %rbp
    a661:	48 89 e5             	mov    %rsp,%rbp
    a664:	41 57                	push   %r15
    a666:	41 56                	push   %r14
    a668:	41 55                	push   %r13
    a66a:	41 54                	push   %r12
    a66c:	53                   	push   %rbx
    a66d:	48 83 ec 18          	sub    $0x18,%rsp
    a671:	48 89 f3             	mov    %rsi,%rbx
    a674:	49 89 ff             	mov    %rdi,%r15
    a677:	be 01 00 00 00       	mov    $0x1,%esi
    a67c:	eb 1e                	jmp    a69c <fwp_apply+0x3c>
    a67e:	66 90                	xchg   %ax,%ax
    a680:	4a 8d 1c f3          	lea    (%rbx,%r14,8),%rbx
    a684:	31 c9                	xor    %ecx,%ecx
    a686:	49 89 c7             	mov    %rax,%r15
    a689:	4c 8b 75 c8          	mov    -0x38(%rbp),%r14
    a68d:	48 8b 65 c0          	mov    -0x40(%rbp),%rsp
    a691:	89 d6                	mov    %edx,%esi
    a693:	83 f9 01             	cmp    $0x1,%ecx
    a696:	0f 84 ff 03 00 00    	je     aa9b <fwp_apply+0x43b>
    a69c:	48 8b 05 9d a6 00 00 	mov    0xa69d(%rip),%rax        # 14d40 <fwp_fns>
    a6a3:	41 8b 0f             	mov    (%r15),%ecx
    a6a6:	45 8b 67 04          	mov    0x4(%r15),%r12d
    a6aa:	48 c1 e1 05          	shl    $0x5,%rcx
    a6ae:	44 8b 2c 08          	mov    (%rax,%rcx,1),%r13d
    a6b2:	4d 85 e4             	test   %r12,%r12
    a6b5:	75 39                	jne    a6f0 <fwp_apply+0x90>
    a6b7:	41 8d 55 ff          	lea    -0x1(%r13),%edx
    a6bb:	39 f2                	cmp    %esi,%edx
    a6bd:	73 31                	jae    a6f0 <fwp_apply+0x90>
    a6bf:	49 89 f7             	mov    %rsi,%r15
    a6c2:	48 89 df             	mov    %rbx,%rdi
    a6c5:	ff 54 08 08          	call   *0x8(%rax,%rcx,1)
    a6c9:	4c 89 fe             	mov    %r15,%rsi
    a6cc:	49 89 c7             	mov    %rax,%r15
    a6cf:	44 39 ee             	cmp    %r13d,%esi
    a6d2:	0f 84 c0 03 00 00    	je     aa98 <fwp_apply+0x438>
    a6d8:	4a 8d 1c eb          	lea    (%rbx,%r13,8),%rbx
    a6dc:	44 29 ee             	sub    %r13d,%esi
    a6df:	b9 03 00 00 00       	mov    $0x3,%ecx
    a6e4:	83 f9 01             	cmp    $0x1,%ecx
    a6e7:	75 b3                	jne    a69c <fwp_apply+0x3c>
    a6e9:	e9 ad 03 00 00       	jmp    aa9b <fwp_apply+0x43b>
    a6ee:	66 90                	xchg   %ax,%ax
    a6f0:	4c 89 75 c8          	mov    %r14,-0x38(%rbp)
    a6f4:	48 89 75 d0          	mov    %rsi,-0x30(%rbp)
    a6f8:	45 8d 34 34          	lea    (%r12,%rsi,1),%r14d
    a6fc:	45 39 ee             	cmp    %r13d,%r14d
    a6ff:	0f 82 1a 02 00 00    	jb     a91f <fwp_apply+0x2bf>
    a705:	48 89 65 c0          	mov    %rsp,-0x40(%rbp)
    a709:	45 89 eb             	mov    %r13d,%r11d
    a70c:	41 83 fd 02          	cmp    $0x2,%r13d
    a710:	ba 01 00 00 00       	mov    $0x1,%edx
    a715:	41 0f 43 d5          	cmovae %r13d,%edx
    a719:	48 8d 14 d5 0f 00 00 	lea    0xf(,%rdx,8),%rdx
    a720:	00 
    a721:	48 83 e2 f0          	and    $0xfffffffffffffff0,%rdx
    a725:	48 89 e7             	mov    %rsp,%rdi
    a728:	48 29 d7             	sub    %rdx,%rdi
    a72b:	48 89 fc             	mov    %rdi,%rsp
    a72e:	4d 85 e4             	test   %r12,%r12
    a731:	0f 84 c9 00 00 00    	je     a800 <fwp_apply+0x1a0>
    a737:	41 83 fc 04          	cmp    $0x4,%r12d
    a73b:	72 10                	jb     a74d <fwp_apply+0xed>
    a73d:	48 89 fa             	mov    %rdi,%rdx
    a740:	4c 29 fa             	sub    %r15,%rdx
    a743:	48 83 c2 f8          	add    $0xfffffffffffffff8,%rdx
    a747:	48 83 fa 20          	cmp    $0x20,%rdx
    a74b:	73 65                	jae    a7b2 <fwp_apply+0x152>
    a74d:	31 d2                	xor    %edx,%edx
    a74f:	4d 89 e0             	mov    %r12,%r8
    a752:	48 89 d6             	mov    %rdx,%rsi
    a755:	49 83 e0 03          	and    $0x3,%r8
    a759:	74 16                	je     a771 <fwp_apply+0x111>
    a75b:	48 89 d6             	mov    %rdx,%rsi
    a75e:	66 90                	xchg   %ax,%ax
    a760:	4d 8b 4c f7 08       	mov    0x8(%r15,%rsi,8),%r9
    a765:	4c 89 0c f7          	mov    %r9,(%rdi,%rsi,8)
    a769:	48 ff c6             	inc    %rsi
    a76c:	49 ff c8             	dec    %r8
    a76f:	75 ef                	jne    a760 <fwp_apply+0x100>
    a771:	4c 29 e2             	sub    %r12,%rdx
    a774:	48 83 fa fc          	cmp    $0xfffffffffffffffc,%rdx
    a778:	0f 87 82 00 00 00    	ja     a800 <fwp_apply+0x1a0>
    a77e:	66 90                	xchg   %ax,%ax
    a780:	49 8b 54 f7 08       	mov    0x8(%r15,%rsi,8),%rdx
    a785:	48 89 14 f7          	mov    %rdx,(%rdi,%rsi,8)
    a789:	49 8b 54 f7 10       	mov    0x10(%r15,%rsi,8),%rdx
    a78e:	48 89 54 f7 08       	mov    %rdx,0x8(%rdi,%rsi,8)
    a793:	49 8b 54 f7 18       	mov    0x18(%r15,%rsi,8),%rdx
    a798:	48 89 54 f7 10       	mov    %rdx,0x10(%rdi,%rsi,8)
    a79d:	49 8b 54 f7 20       	mov    0x20(%r15,%rsi,8),%rdx
    a7a2:	48 89 54 f7 18       	mov    %rdx,0x18(%rdi,%rsi,8)
    a7a7:	48 83 c6 04          	add    $0x4,%rsi
    a7ab:	49 39 f4             	cmp    %rsi,%r12
    a7ae:	75 d0                	jne    a780 <fwp_apply+0x120>
    a7b0:	eb 4e                	jmp    a800 <fwp_apply+0x1a0>
    a7b2:	44 89 e2             	mov    %r12d,%edx
    a7b5:	83 e2 fc             	and    $0xfffffffc,%edx
    a7b8:	4a 8d 34 e5 00 00 00 	lea    0x0(,%r12,8),%rsi
    a7bf:	00 
    a7c0:	48 83 e6 e0          	and    $0xffffffffffffffe0,%rsi
    a7c4:	45 31 c0             	xor    %r8d,%r8d
    a7c7:	66 0f 1f 84 00 00 00 	nopw   0x0(%rax,%rax,1)
    a7ce:	00 00 
    a7d0:	43 0f 10 44 07 08    	movups 0x8(%r15,%r8,1),%xmm0
    a7d6:	43 0f 10 4c 07 18    	movups 0x18(%r15,%r8,1),%xmm1
    a7dc:	42 0f 29 04 07       	movaps %xmm0,(%rdi,%r8,1)
    a7e1:	42 0f 29 4c 07 10    	movaps %xmm1,0x10(%rdi,%r8,1)
    a7e7:	49 83 c0 20          	add    $0x20,%r8
    a7eb:	4c 39 c6             	cmp    %r8,%rsi
    a7ee:	75 e0                	jne    a7d0 <fwp_apply+0x170>
    a7f0:	4c 39 e2             	cmp    %r12,%rdx
    a7f3:	0f 85 56 ff ff ff    	jne    a74f <fwp_apply+0xef>
    a7f9:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)
    a800:	45 29 e3             	sub    %r12d,%r11d
    a803:	45 89 de             	mov    %r11d,%r14d
    a806:	45 39 e5             	cmp    %r12d,%r13d
    a809:	0f 84 85 00 00 00    	je     a894 <fwp_apply+0x234>
    a80f:	41 83 fb 0e          	cmp    $0xe,%r11d
    a813:	0f 83 a0 00 00 00    	jae    a8b9 <fwp_apply+0x259>
    a819:	31 d2                	xor    %edx,%edx
    a81b:	4d 89 f0             	mov    %r14,%r8
    a81e:	48 89 d6             	mov    %rdx,%rsi
    a821:	49 83 e0 03          	and    $0x3,%r8
    a825:	74 1d                	je     a844 <fwp_apply+0x1e4>
    a827:	48 89 d6             	mov    %rdx,%rsi
    a82a:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)
    a830:	4c 8b 0c f3          	mov    (%rbx,%rsi,8),%r9
    a834:	45 8d 14 34          	lea    (%r12,%rsi,1),%r10d
    a838:	4e 89 0c d7          	mov    %r9,(%rdi,%r10,8)
    a83c:	48 ff c6             	inc    %rsi
    a83f:	49 ff c8             	dec    %r8
    a842:	75 ec                	jne    a830 <fwp_apply+0x1d0>
    a844:	4c 29 f2             	sub    %r14,%rdx
    a847:	48 83 fa fc          	cmp    $0xfffffffffffffffc,%rdx
    a84b:	77 47                	ja     a894 <fwp_apply+0x234>
    a84d:	0f 1f 00             	nopl   (%rax)
    a850:	48 8b 14 f3          	mov    (%rbx,%rsi,8),%rdx
    a854:	45 8d 04 34          	lea    (%r12,%rsi,1),%r8d
    a858:	4a 89 14 c7          	mov    %rdx,(%rdi,%r8,8)
    a85c:	48 8b 54 f3 08       	mov    0x8(%rbx,%rsi,8),%rdx
    a861:	45 8d 04 34          	lea    (%r12,%rsi,1),%r8d
    a865:	41 ff c0             	inc    %r8d
    a868:	4a 89 14 c7          	mov    %rdx,(%rdi,%r8,8)
    a86c:	48 8b 54 f3 10       	mov    0x10(%rbx,%rsi,8),%rdx
    a871:	45 8d 44 34 02       	lea    0x2(%r12,%rsi,1),%r8d
    a876:	4a 89 14 c7          	mov    %rdx,(%rdi,%r8,8)
    a87a:	48 8b 54 f3 18       	mov    0x18(%rbx,%rsi,8),%rdx
    a87f:	45 8d 04 34          	lea    (%r12,%rsi,1),%r8d
    a883:	41 83 c0 03          	add    $0x3,%r8d
    a887:	4a 89 14 c7          	mov    %rdx,(%rdi,%r8,8)
    a88b:	48 83 c6 04          	add    $0x4,%rsi
    a88f:	49 39 f6             	cmp    %rsi,%r14
    a892:	75 bc                	jne    a850 <fwp_apply+0x1f0>
    a894:	45 89 dc             	mov    %r11d,%r12d
    a897:	ff 54 08 08          	call   *0x8(%rax,%rcx,1)
    a89b:	b9 01 00 00 00       	mov    $0x1,%ecx
    a8a0:	48 8b 75 d0          	mov    -0x30(%rbp),%rsi
    a8a4:	89 f2                	mov    %esi,%edx
    a8a6:	44 29 e2             	sub    %r12d,%edx
    a8a9:	0f 85 d1 fd ff ff    	jne    a680 <fwp_apply+0x20>
    a8af:	89 f2                	mov    %esi,%edx
    a8b1:	49 89 c6             	mov    %rax,%r14
    a8b4:	e9 d4 fd ff ff       	jmp    a68d <fwp_apply+0x2d>
    a8b9:	49 8d 56 ff          	lea    -0x1(%r14),%rdx
    a8bd:	89 d6                	mov    %edx,%esi
    a8bf:	44 01 e6             	add    %r12d,%esi
    a8c2:	0f 82 51 ff ff ff    	jb     a819 <fwp_apply+0x1b9>
    a8c8:	48 c1 ea 20          	shr    $0x20,%rdx
    a8cc:	ba 00 00 00 00       	mov    $0x0,%edx
    a8d1:	0f 85 44 ff ff ff    	jne    a81b <fwp_apply+0x1bb>
    a8d7:	4a 8d 14 e7          	lea    (%rdi,%r12,8),%rdx
    a8db:	48 29 da             	sub    %rbx,%rdx
    a8de:	48 83 fa 20          	cmp    $0x20,%rdx
    a8e2:	0f 82 31 ff ff ff    	jb     a819 <fwp_apply+0x1b9>
    a8e8:	44 89 f2             	mov    %r14d,%edx
    a8eb:	83 e2 fc             	and    $0xfffffffc,%edx
    a8ee:	31 f6                	xor    %esi,%esi
    a8f0:	0f 10 04 f3          	movups (%rbx,%rsi,8),%xmm0
    a8f4:	0f 10 4c f3 10       	movups 0x10(%rbx,%rsi,8),%xmm1
    a8f9:	45 8d 04 34          	lea    (%r12,%rsi,1),%r8d
    a8fd:	42 0f 11 04 c7       	movups %xmm0,(%rdi,%r8,8)
    a902:	42 0f 11 4c c7 10    	movups %xmm1,0x10(%rdi,%r8,8)
    a908:	48 83 c6 04          	add    $0x4,%rsi
    a90c:	48 39 f2             	cmp    %rsi,%rdx
    a90f:	75 df                	jne    a8f0 <fwp_apply+0x290>
    a911:	4c 39 f2             	cmp    %r14,%rdx
    a914:	0f 85 01 ff ff ff    	jne    a81b <fwp_apply+0x1bb>
    a91a:	e9 75 ff ff ff       	jmp    a894 <fwp_apply+0x234>
    a91f:	44 89 f0             	mov    %r14d,%eax
    a922:	48 8d 3c c5 08 00 00 	lea    0x8(,%rax,8),%rdi
    a929:	00 
    a92a:	e8 d1 8b ff ff       	call   3500 <fwp_alloc>
    a92f:	41 8b 0f             	mov    (%r15),%ecx
    a932:	89 08                	mov    %ecx,(%rax)
    a934:	44 89 70 04          	mov    %r14d,0x4(%rax)
    a938:	49 89 c6             	mov    %rax,%r14
    a93b:	4d 85 e4             	test   %r12,%r12
    a93e:	48 8b 7d d0          	mov    -0x30(%rbp),%rdi
    a942:	0f 84 b9 00 00 00    	je     aa01 <fwp_apply+0x3a1>
    a948:	31 c0                	xor    %eax,%eax
    a94a:	41 83 fc 06          	cmp    $0x6,%r12d
    a94e:	72 46                	jb     a996 <fwp_apply+0x336>
    a950:	4c 89 f1             	mov    %r14,%rcx
    a953:	4c 29 f9             	sub    %r15,%rcx
    a956:	48 83 f9 20          	cmp    $0x20,%rcx
    a95a:	72 3a                	jb     a996 <fwp_apply+0x336>
    a95c:	44 89 e0             	mov    %r12d,%eax
    a95f:	83 e0 fc             	and    $0xfffffffc,%eax
    a962:	4a 8d 0c e5 00 00 00 	lea    0x0(,%r12,8),%rcx
    a969:	00 
    a96a:	48 83 e1 e0          	and    $0xffffffffffffffe0,%rcx
    a96e:	31 d2                	xor    %edx,%edx
    a970:	41 0f 10 44 17 08    	movups 0x8(%r15,%rdx,1),%xmm0
    a976:	41 0f 10 4c 17 18    	movups 0x18(%r15,%rdx,1),%xmm1
    a97c:	41 0f 11 44 16 08    	movups %xmm0,0x8(%r14,%rdx,1)
    a982:	41 0f 11 4c 16 18    	movups %xmm1,0x18(%r14,%rdx,1)
    a988:	48 83 c2 20          	add    $0x20,%rdx
    a98c:	48 39 d1             	cmp    %rdx,%rcx
    a98f:	75 df                	jne    a970 <fwp_apply+0x310>
    a991:	4c 39 e0             	cmp    %r12,%rax
    a994:	74 6b                	je     aa01 <fwp_apply+0x3a1>
    a996:	4c 89 e2             	mov    %r12,%rdx
    a999:	48 89 c1             	mov    %rax,%rcx
    a99c:	48 83 e2 03          	and    $0x3,%rdx
    a9a0:	74 20                	je     a9c2 <fwp_apply+0x362>
    a9a2:	48 89 c1             	mov    %rax,%rcx
    a9a5:	66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
    a9ac:	00 00 00 00 
    a9b0:	49 8b 74 cf 08       	mov    0x8(%r15,%rcx,8),%rsi
    a9b5:	49 89 74 ce 08       	mov    %rsi,0x8(%r14,%rcx,8)
    a9ba:	48 ff c1             	inc    %rcx
    a9bd:	48 ff ca             	dec    %rdx
    a9c0:	75 ee                	jne    a9b0 <fwp_apply+0x350>
    a9c2:	4c 29 e0             	sub    %r12,%rax
    a9c5:	48 83 f8 fc          	cmp    $0xfffffffffffffffc,%rax
    a9c9:	77 36                	ja     aa01 <fwp_apply+0x3a1>
    a9cb:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)
    a9d0:	49 8b 44 cf 08       	mov    0x8(%r15,%rcx,8),%rax
    a9d5:	49 89 44 ce 08       	mov    %rax,0x8(%r14,%rcx,8)
    a9da:	49 8b 44 cf 10       	mov    0x10(%r15,%rcx,8),%rax
    a9df:	49 89 44 ce 10       	mov    %rax,0x10(%r14,%rcx,8)
    a9e4:	49 8b 44 cf 18       	mov    0x18(%r15,%rcx,8),%rax
    a9e9:	49 89 44 ce 18       	mov    %rax,0x18(%r14,%rcx,8)
    a9ee:	49 8b 44 cf 20       	mov    0x20(%r15,%rcx,8),%rax
    a9f3:	49 89 44 ce 20       	mov    %rax,0x20(%r14,%rcx,8)
    a9f8:	48 83 c1 04          	add    $0x4,%rcx
    a9fc:	49 39 cc             	cmp    %rcx,%r12
    a9ff:	75 cf                	jne    a9d0 <fwp_apply+0x370>
    aa01:	85 ff                	test   %edi,%edi
    aa03:	0f 84 92 00 00 00    	je     aa9b <fwp_apply+0x43b>
    aa09:	89 f8                	mov    %edi,%eax
    aa0b:	83 ff 14             	cmp    $0x14,%edi
    aa0e:	0f 83 99 00 00 00    	jae    aaad <fwp_apply+0x44d>
    aa14:	31 c9                	xor    %ecx,%ecx
    aa16:	48 89 c6             	mov    %rax,%rsi
    aa19:	48 89 ca             	mov    %rcx,%rdx
    aa1c:	48 83 e6 03          	and    $0x3,%rsi
    aa20:	74 23                	je     aa45 <fwp_apply+0x3e5>
    aa22:	48 89 ca             	mov    %rcx,%rdx
    aa25:	66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
    aa2c:	00 00 00 00 
    aa30:	48 8b 3c d3          	mov    (%rbx,%rdx,8),%rdi
    aa34:	45 8d 04 14          	lea    (%r12,%rdx,1),%r8d
    aa38:	4b 89 7c c6 08       	mov    %rdi,0x8(%r14,%r8,8)
    aa3d:	48 ff c2             	inc    %rdx
    aa40:	48 ff ce             	dec    %rsi
    aa43:	75 eb                	jne    aa30 <fwp_apply+0x3d0>
    aa45:	48 29 c1             	sub    %rax,%rcx
    aa48:	48 83 f9 fc          	cmp    $0xfffffffffffffffc,%rcx
    aa4c:	77 4d                	ja     aa9b <fwp_apply+0x43b>
    aa4e:	66 90                	xchg   %ax,%ax
    aa50:	48 8b 0c d3          	mov    (%rbx,%rdx,8),%rcx
    aa54:	41 8d 34 14          	lea    (%r12,%rdx,1),%esi
    aa58:	49 89 4c f6 08       	mov    %rcx,0x8(%r14,%rsi,8)
    aa5d:	48 8b 4c d3 08       	mov    0x8(%rbx,%rdx,8),%rcx
    aa62:	41 8d 34 14          	lea    (%r12,%rdx,1),%esi
    aa66:	ff c6                	inc    %esi
    aa68:	49 89 4c f6 08       	mov    %rcx,0x8(%r14,%rsi,8)
    aa6d:	48 8b 4c d3 10       	mov    0x10(%rbx,%rdx,8),%rcx
    aa72:	41 8d 74 14 02       	lea    0x2(%r12,%rdx,1),%esi
    aa77:	49 89 4c f6 08       	mov    %rcx,0x8(%r14,%rsi,8)
    aa7c:	48 8b 4c d3 18       	mov    0x18(%rbx,%rdx,8),%rcx
    aa81:	41 8d 34 14          	lea    (%r12,%rdx,1),%esi
    aa85:	83 c6 03             	add    $0x3,%esi
    aa88:	49 89 4c f6 08       	mov    %rcx,0x8(%r14,%rsi,8)
    aa8d:	48 83 c2 04          	add    $0x4,%rdx
    aa91:	48 39 d0             	cmp    %rdx,%rax
    aa94:	75 ba                	jne    aa50 <fwp_apply+0x3f0>
    aa96:	eb 03                	jmp    aa9b <fwp_apply+0x43b>
    aa98:	4d 89 fe             	mov    %r15,%r14
    aa9b:	4c 89 f0             	mov    %r14,%rax
    aa9e:	48 8d 65 d8          	lea    -0x28(%rbp),%rsp
    aaa2:	5b                   	pop    %rbx
    aaa3:	41 5c                	pop    %r12
    aaa5:	41 5d                	pop    %r13
    aaa7:	41 5e                	pop    %r14
    aaa9:	41 5f                	pop    %r15
    aaab:	5d                   	pop    %rbp
    aaac:	c3                   	ret
    aaad:	48 8d 50 ff          	lea    -0x1(%rax),%rdx
    aab1:	31 c9                	xor    %ecx,%ecx
    aab3:	89 d6                	mov    %edx,%esi
    aab5:	44 01 e6             	add    %r12d,%esi
    aab8:	0f 82 58 ff ff ff    	jb     aa16 <fwp_apply+0x3b6>
    aabe:	48 c1 ea 20          	shr    $0x20,%rdx
    aac2:	0f 85 4e ff ff ff    	jne    aa16 <fwp_apply+0x3b6>
    aac8:	4b 8d 0c e6          	lea    (%r14,%r12,8),%rcx
    aacc:	48 29 d9             	sub    %rbx,%rcx
    aacf:	48 83 c1 08          	add    $0x8,%rcx
    aad3:	48 83 f9 20          	cmp    $0x20,%rcx
    aad7:	0f 82 37 ff ff ff    	jb     aa14 <fwp_apply+0x3b4>
    aadd:	89 c1                	mov    %eax,%ecx
    aadf:	83 e1 fc             	and    $0xfffffffc,%ecx
    aae2:	31 d2                	xor    %edx,%edx
    aae4:	66 66 66 2e 0f 1f 84 	data16 data16 cs nopw 0x0(%rax,%rax,1)
    aaeb:	00 00 00 00 00 
    aaf0:	0f 10 04 d3          	movups (%rbx,%rdx,8),%xmm0
    aaf4:	0f 10 4c d3 10       	movups 0x10(%rbx,%rdx,8),%xmm1
    aaf9:	41 8d 34 14          	lea    (%r12,%rdx,1),%esi
    aafd:	41 0f 11 44 f6 08    	movups %xmm0,0x8(%r14,%rsi,8)
    ab03:	41 0f 11 4c f6 18    	movups %xmm1,0x18(%r14,%rsi,8)
    ab09:	48 83 c2 04          	add    $0x4,%rdx
    ab0d:	48 39 d1             	cmp    %rdx,%rcx
    ab10:	75 de                	jne    aaf0 <fwp_apply+0x490>
    ab12:	48 39 c1             	cmp    %rax,%rcx
    ab15:	0f 85 fb fe ff ff    	jne    aa16 <fwp_apply+0x3b6>
    ab1b:	e9 7b ff ff ff       	jmp    aa9b <fwp_apply+0x43b>

000000000000ab20 <fwp_pap>:
    ab20:	50                   	push   %rax
    ab21:	bf 08 00 00 00       	mov    $0x8,%edi
    ab26:	e8 d5 89 ff ff       	call   3500 <fwp_alloc>
    ab2b:	48 c7 00 02 00 00 00 	movq   $0x2,(%rax)
    ab32:	59                   	pop    %rcx
    ab33:	c3                   	ret
    ab34:	66 66 66 2e 0f 1f 84 	data16 data16 cs nopw 0x0(%rax,%rax,1)
    ab3b:	00 00 00 00 00 

000000000000ab40 <fwp_exec_error>:
    ab40:	41 57                	push   %r15
    ab42:	41 56                	push   %r14
    ab44:	53                   	push   %rbx
    ab45:	48 89 f3             	mov    %rsi,%rbx
    ab48:	49 89 fe             	mov    %rdi,%r14
    ab4b:	e8 80 bd ff ff       	call   68d0 <fwp_pipe_flush>
    ab50:	4c 8b 3d 81 84 00 00 	mov    0x8481(%rip),%r15        # 12fd8 <stderr@GLIBC_2.2.5>
    ab57:	49 8b 3f             	mov    (%r15),%rdi
    ab5a:	48 8d 35 95 37 00 00 	lea    0x3795(%rip),%rsi        # e2f6 <exec_in_fp0+0xcb6>
    ab61:	48 8d 15 0a 2b 00 00 	lea    0x2b0a(%rip),%rdx        # d672 <exec_in_fp0+0x32>
    ab68:	31 c0                	xor    %eax,%eax
    ab6a:	e8 81 77 ff ff       	call   22f0 <fprintf@plt>
    ab6f:	83 3b 10             	cmpl   $0x10,(%rbx)
    ab72:	75 1f                	jne    ab93 <fwp_exec_error+0x53>
    ab74:	48 8b 7b 08          	mov    0x8(%rbx),%rdi
    ab78:	48 85 ff             	test   %rdi,%rdi
    ab7b:	74 16                	je     ab93 <fwp_exec_error+0x53>
    ab7d:	48 8d 35 77 37 00 00 	lea    0x3777(%rip),%rsi        # e2fb <exec_in_fp0+0xcbb>
    ab84:	e8 47 77 ff ff       	call   22d0 <strcmp@plt>
    ab89:	85 c0                	test   %eax,%eax
    ab8b:	75 06                	jne    ab93 <fwp_exec_error+0x53>
    ab8d:	83 7b 10 02          	cmpl   $0x2,0x10(%rbx)
    ab91:	74 20                	je     abb3 <fwp_exec_error+0x73>
    ab93:	49 8b 17             	mov    (%r15),%rdx
    ab96:	4c 89 f7             	mov    %r14,%rdi
    ab99:	48 89 de             	mov    %rbx,%rsi
    ab9c:	e8 2f 00 00 00       	call   abd0 <fwp_display_top>
    aba1:	49 8b 37             	mov    (%r15),%rsi
    aba4:	bf 0a 00 00 00       	mov    $0xa,%edi
    aba9:	5b                   	pop    %rbx
    abaa:	41 5e                	pop    %r14
    abac:	41 5f                	pop    %r15
    abae:	e9 8d 76 ff ff       	jmp    2240 <fputc@plt>
    abb3:	49 8b 7e 10          	mov    0x10(%r14),%rdi
    abb7:	48 8b 17             	mov    (%rdi),%rdx
    abba:	48 83 c7 08          	add    $0x8,%rdi
    abbe:	49 8b 0f             	mov    (%r15),%rcx
    abc1:	be 01 00 00 00       	mov    $0x1,%esi
    abc6:	e8 d5 78 ff ff       	call   24a0 <fwrite@plt>
    abcb:	eb d4                	jmp    aba1 <fwp_exec_error+0x61>
    abcd:	0f 1f 00             	nopl   (%rax)

000000000000abd0 <fwp_display_top>:
    abd0:	53                   	push   %rbx
    abd1:	48 83 ec 20          	sub    $0x20,%rsp
    abd5:	48 89 d3             	mov    %rdx,%rbx
    abd8:	48 89 f2             	mov    %rsi,%rdx
    abdb:	48 89 fe             	mov    %rdi,%rsi
    abde:	0f 57 c0             	xorps  %xmm0,%xmm0
    abe1:	0f 29 04 24          	movaps %xmm0,(%rsp)
    abe5:	48 c7 44 24 10 00 00 	movq   $0x0,0x10(%rsp)
    abec:	00 00 
    abee:	48 89 e7             	mov    %rsp,%rdi
    abf1:	b9 01 00 00 00       	mov    $0x1,%ecx
    abf6:	e8 35 00 00 00       	call   ac30 <fwp_write>
    abfb:	48 8b 3c 24          	mov    (%rsp),%rdi
    abff:	48 85 ff             	test   %rdi,%rdi
    ac02:	74 18                	je     ac1c <fwp_display_top+0x4c>
    ac04:	48 8b 54 24 08       	mov    0x8(%rsp),%rdx
    ac09:	be 01 00 00 00       	mov    $0x1,%esi
    ac0e:	48 89 d9             	mov    %rbx,%rcx
    ac11:	e8 8a 78 ff ff       	call   24a0 <fwrite@plt>
    ac16:	48 8b 3c 24          	mov    (%rsp),%rdi
    ac1a:	eb 02                	jmp    ac1e <fwp_display_top+0x4e>
    ac1c:	31 ff                	xor    %edi,%edi
    ac1e:	e8 2d 74 ff ff       	call   2050 <free@plt>
    ac23:	48 83 c4 20          	add    $0x20,%rsp
    ac27:	5b                   	pop    %rbx
    ac28:	c3                   	ret
    ac29:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)

000000000000ac30 <fwp_write>:
    ac30:	55                   	push   %rbp
    ac31:	41 57                	push   %r15
    ac33:	41 56                	push   %r14
    ac35:	41 55                	push   %r13
    ac37:	41 54                	push   %r12
    ac39:	53                   	push   %rbx
    ac3a:	48 81 ec 28 02 00 00 	sub    $0x228,%rsp
    ac41:	8b 02                	mov    (%rdx),%eax
    ac43:	48 83 f8 19          	cmp    $0x19,%rax
    ac47:	0f 87 3f 05 00 00    	ja     b18c <fwp_write+0x55c>
    ac4d:	49 89 f5             	mov    %rsi,%r13
    ac50:	48 89 fb             	mov    %rdi,%rbx
    ac53:	48 89 54 24 08       	mov    %rdx,0x8(%rsp)
    ac58:	48 8d 15 e5 26 00 00 	lea    0x26e5(%rip),%rdx        # d344 <_IO_stdin_used+0x344>
    ac5f:	48 63 34 82          	movslq (%rdx,%rax,4),%rsi
    ac63:	48 01 d6             	add    %rdx,%rsi
    ac66:	ff e6                	jmp    *%rsi
    ac68:	48 8d 15 94 36 00 00 	lea    0x3694(%rip),%rdx        # e303 <exec_in_fp0+0xcc3>
    ac6f:	eb 07                	jmp    ac78 <fwp_write+0x48>
    ac71:	48 8d 15 53 36 00 00 	lea    0x3653(%rip),%rdx        # e2cb <exec_in_fp0+0xc8b>
    ac78:	4c 8d 7c 24 20       	lea    0x20(%rsp),%r15
    ac7d:	be 00 02 00 00       	mov    $0x200,%esi
    ac82:	4c 89 ff             	mov    %r15,%rdi
    ac85:	4c 89 e9             	mov    %r13,%rcx
    ac88:	31 c0                	xor    %eax,%eax
    ac8a:	e8 41 75 ff ff       	call   21d0 <snprintf@plt>
    ac8f:	48 89 df             	mov    %rbx,%rdi
    ac92:	4c 89 fe             	mov    %r15,%rsi
    ac95:	e9 ed 04 00 00       	jmp    b187 <fwp_write+0x557>
    ac9a:	83 f8 13             	cmp    $0x13,%eax
    ac9d:	48 8d 05 90 36 00 00 	lea    0x3690(%rip),%rax        # e334 <exec_in_fp0+0xcf4>
    aca4:	48 8d 35 8e 36 00 00 	lea    0x368e(%rip),%rsi        # e339 <exec_in_fp0+0xcf9>
    acab:	48 0f 44 f0          	cmove  %rax,%rsi
    acaf:	48 89 df             	mov    %rbx,%rdi
    acb2:	e8 09 ca ff ff       	call   76c0 <buf_puts>
    acb7:	49 83 7d 00 00       	cmpq   $0x0,0x0(%r13)
    acbc:	48 8b 44 24 08       	mov    0x8(%rsp),%rax
    acc1:	0f 84 cb 00 00 00    	je     ad92 <fwp_write+0x162>
    acc7:	4d 89 ec             	mov    %r13,%r12
    acca:	48 8b 50 38          	mov    0x38(%rax),%rdx
    acce:	48 89 df             	mov    %rbx,%rdi
    acd1:	4c 89 eb             	mov    %r13,%rbx
    acd4:	49 8b 74 24 08       	mov    0x8(%r12),%rsi
    acd9:	49 89 c6             	mov    %rax,%r14
    acdc:	49 89 ff             	mov    %rdi,%r15
    acdf:	31 c9                	xor    %ecx,%ecx
    ace1:	e8 4a ff ff ff       	call   ac30 <fwp_write>
    ace6:	41 83 3e 12          	cmpl   $0x12,(%r14)
    acea:	75 29                	jne    ad15 <fwp_write+0xe5>
    acec:	48 8d 35 05 36 00 00 	lea    0x3605(%rip),%rsi        # e2f8 <exec_in_fp0+0xcb8>
    acf3:	4d 89 fe             	mov    %r15,%r14
    acf6:	4c 89 ff             	mov    %r15,%rdi
    acf9:	e8 c2 c9 ff ff       	call   76c0 <buf_puts>
    acfe:	48 8b 73 10          	mov    0x10(%rbx),%rsi
    ad02:	48 8b 44 24 08       	mov    0x8(%rsp),%rax
    ad07:	48 8b 50 40          	mov    0x40(%rax),%rdx
    ad0b:	4c 89 ff             	mov    %r15,%rdi
    ad0e:	31 c9                	xor    %ecx,%ecx
    ad10:	e8 1b ff ff ff       	call   ac30 <fwp_write>
    ad15:	48 83 3b 02          	cmpq   $0x2,(%rbx)
    ad19:	4c 89 fb             	mov    %r15,%rbx
    ad1c:	4c 8b 7c 24 08       	mov    0x8(%rsp),%r15
    ad21:	72 6f                	jb     ad92 <fwp_write+0x162>
    ad23:	4d 8d 74 24 20       	lea    0x20(%r12),%r14
    ad28:	bd 01 00 00 00       	mov    $0x1,%ebp
    ad2d:	4c 8d 2d 19 35 00 00 	lea    0x3519(%rip),%r13        # e24d <exec_in_fp0+0xc0d>
    ad34:	eb 17                	jmp    ad4d <fwp_write+0x11d>
    ad36:	66 2e 0f 1f 84 00 00 	cs nopw 0x0(%rax,%rax,1)
    ad3d:	00 00 00 
    ad40:	48 ff c5             	inc    %rbp
    ad43:	49 83 c6 10          	add    $0x10,%r14
    ad47:	49 3b 2c 24          	cmp    (%r12),%rbp
    ad4b:	73 45                	jae    ad92 <fwp_write+0x162>
    ad4d:	48 89 df             	mov    %rbx,%rdi
    ad50:	4c 89 ee             	mov    %r13,%rsi
    ad53:	e8 68 c9 ff ff       	call   76c0 <buf_puts>
    ad58:	49 8b 76 f8          	mov    -0x8(%r14),%rsi
    ad5c:	49 8b 57 38          	mov    0x38(%r15),%rdx
    ad60:	48 89 df             	mov    %rbx,%rdi
    ad63:	31 c9                	xor    %ecx,%ecx
    ad65:	e8 c6 fe ff ff       	call   ac30 <fwp_write>
    ad6a:	41 83 3f 12          	cmpl   $0x12,(%r15)
    ad6e:	75 d0                	jne    ad40 <fwp_write+0x110>
    ad70:	48 89 df             	mov    %rbx,%rdi
    ad73:	48 8d 35 7e 35 00 00 	lea    0x357e(%rip),%rsi        # e2f8 <exec_in_fp0+0xcb8>
    ad7a:	e8 41 c9 ff ff       	call   76c0 <buf_puts>
    ad7f:	49 8b 36             	mov    (%r14),%rsi
    ad82:	49 8b 57 40          	mov    0x40(%r15),%rdx
    ad86:	48 89 df             	mov    %rbx,%rdi
    ad89:	31 c9                	xor    %ecx,%ecx
    ad8b:	e8 a0 fe ff ff       	call   ac30 <fwp_write>
    ad90:	eb ae                	jmp    ad40 <fwp_write+0x110>
    ad92:	48 89 df             	mov    %rbx,%rdi
    ad95:	be 7d 00 00 00       	mov    $0x7d,%esi
    ad9a:	e9 48 05 00 00       	jmp    b2e7 <fwp_write+0x6b7>
    ad9f:	4c 8b 7c 24 08       	mov    0x8(%rsp),%r15
    ada4:	4d 8b 67 08          	mov    0x8(%r15),%r12
    ada8:	4d 85 e4             	test   %r12,%r12
    adab:	0f 84 38 04 00 00    	je     b1e9 <fwp_write+0x5b9>
    adb1:	48 8d 35 b2 34 00 00 	lea    0x34b2(%rip),%rsi        # e26a <exec_in_fp0+0xc2a>
    adb8:	4c 89 e7             	mov    %r12,%rdi
    adbb:	e8 10 75 ff ff       	call   22d0 <strcmp@plt>
    adc0:	85 c0                	test   %eax,%eax
    adc2:	0f 84 44 05 00 00    	je     b30c <fwp_write+0x6dc>
    adc8:	4d 8d 77 10          	lea    0x10(%r15),%r14
    adcc:	48 89 df             	mov    %rbx,%rdi
    adcf:	4c 89 e6             	mov    %r12,%rsi
    add2:	e8 e9 c8 ff ff       	call   76c0 <buf_puts>
    add7:	48 89 df             	mov    %rbx,%rdi
    adda:	be 20 00 00 00       	mov    $0x20,%esi
    addf:	e8 bc c8 ff ff       	call   76a0 <buf_putc>
    ade4:	31 ed                	xor    %ebp,%ebp
    ade6:	e9 1f 04 00 00       	jmp    b20a <fwp_write+0x5da>
    adeb:	4c 89 ef             	mov    %r13,%rdi
    adee:	e8 cd ef ff ff       	call   9dc0 <fwp_tag>
    adf3:	4c 8b 7c 24 08       	mov    0x8(%rsp),%r15
    adf8:	49 8b 4f 18          	mov    0x18(%r15),%rcx
    adfc:	41 89 c6             	mov    %eax,%r14d
    adff:	4a 8b 34 f1          	mov    (%rcx,%r14,8),%rsi
    ae03:	48 89 df             	mov    %rbx,%rdi
    ae06:	e8 b5 c8 ff ff       	call   76c0 <buf_puts>
    ae0b:	49 8b 47 28          	mov    0x28(%r15),%rax
    ae0f:	42 83 3c b0 00       	cmpl   $0x0,(%rax,%r14,4)
    ae14:	0f 8e 72 03 00 00    	jle    b18c <fwp_write+0x55c>
    ae1a:	4c 89 f1             	mov    %r14,%rcx
    ae1d:	45 31 f6             	xor    %r14d,%r14d
    ae20:	4c 89 6c 24 18       	mov    %r13,0x18(%rsp)
    ae25:	48 89 4c 24 10       	mov    %rcx,0x10(%rsp)
    ae2a:	eb 3d                	jmp    ae69 <fwp_write+0x239>
    ae2c:	0f 1f 40 00          	nopl   0x0(%rax)
    ae30:	48 89 dd             	mov    %rbx,%rbp
    ae33:	48 89 df             	mov    %rbx,%rdi
    ae36:	4c 89 e6             	mov    %r12,%rsi
    ae39:	4c 89 ea             	mov    %r13,%rdx
    ae3c:	31 c9                	xor    %ecx,%ecx
    ae3e:	e8 ed fd ff ff       	call   ac30 <fwp_write>
    ae43:	49 ff c6             	inc    %r14
    ae46:	4c 8b 7c 24 08       	mov    0x8(%rsp),%r15
    ae4b:	49 8b 47 28          	mov    0x28(%r15),%rax
    ae4f:	48 8b 4c 24 10       	mov    0x10(%rsp),%rcx
    ae54:	48 63 04 88          	movslq (%rax,%rcx,4),%rax
    ae58:	49 39 c6             	cmp    %rax,%r14
    ae5b:	4c 8b 6c 24 18       	mov    0x18(%rsp),%r13
    ae60:	48 89 eb             	mov    %rbp,%rbx
    ae63:	0f 8d 23 03 00 00    	jge    b18c <fwp_write+0x55c>
    ae69:	4f 8b 64 f5 08       	mov    0x8(%r13,%r14,8),%r12
    ae6e:	49 8b 47 30          	mov    0x30(%r15),%rax
    ae72:	48 8b 04 c8          	mov    (%rax,%rcx,8),%rax
    ae76:	4e 8b 2c f0          	mov    (%rax,%r14,8),%r13
    ae7a:	48 89 df             	mov    %rbx,%rdi
    ae7d:	be 20 00 00 00       	mov    $0x20,%esi
    ae82:	e8 19 c8 ff ff       	call   76a0 <buf_putc>
    ae87:	4c 89 e7             	mov    %r12,%rdi
    ae8a:	4c 89 ee             	mov    %r13,%rsi
    ae8d:	e8 8e 0e 00 00       	call   bd20 <fwp_needs_parens>
    ae92:	85 c0                	test   %eax,%eax
    ae94:	74 9a                	je     ae30 <fwp_write+0x200>
    ae96:	48 89 df             	mov    %rbx,%rdi
    ae99:	be 28 00 00 00       	mov    $0x28,%esi
    ae9e:	e8 fd c7 ff ff       	call   76a0 <buf_putc>
    aea3:	48 89 df             	mov    %rbx,%rdi
    aea6:	4c 89 e6             	mov    %r12,%rsi
    aea9:	4c 89 ea             	mov    %r13,%rdx
    aeac:	31 c9                	xor    %ecx,%ecx
    aeae:	e8 7d fd ff ff       	call   ac30 <fwp_write>
    aeb3:	48 89 dd             	mov    %rbx,%rbp
    aeb6:	48 89 df             	mov    %rbx,%rdi
    aeb9:	be 29 00 00 00       	mov    $0x29,%esi
    aebe:	e8 dd c7 ff ff       	call   76a0 <buf_putc>
    aec3:	e9 7b ff ff ff       	jmp    ae43 <fwp_write+0x213>
    aec8:	4c 89 ef             	mov    %r13,%rdi
    aecb:	e8 e0 a9 ff ff       	call   58b0 <fwp_f64>
    aed0:	4c 8d 74 24 20       	lea    0x20(%rsp),%r14
    aed5:	4c 89 f7             	mov    %r14,%rdi
    aed8:	e8 93 08 00 00       	call   b770 <fwp_fmt_f64>
    aedd:	e9 9f 02 00 00       	jmp    b181 <fwp_write+0x551>
    aee2:	48 89 df             	mov    %rbx,%rdi
    aee5:	be 3c 00 00 00       	mov    $0x3c,%esi
    aeea:	e8 b1 c7 ff ff       	call   76a0 <buf_putc>
    aeef:	48 8b 44 24 08       	mov    0x8(%rsp),%rax
    aef4:	48 8b 70 08          	mov    0x8(%rax),%rsi
    aef8:	48 89 df             	mov    %rbx,%rdi
    aefb:	e9 d7 02 00 00       	jmp    b1d7 <fwp_write+0x5a7>
    af00:	48 8d 35 0c 34 00 00 	lea    0x340c(%rip),%rsi        # e313 <exec_in_fp0+0xcd3>
    af07:	e9 99 02 00 00       	jmp    b1a5 <fwp_write+0x575>
    af0c:	49 8d 75 08          	lea    0x8(%r13),%rsi
    af10:	49 8b 55 00          	mov    0x0(%r13),%rdx
    af14:	48 89 df             	mov    %rbx,%rdi
    af17:	48 81 c4 28 02 00 00 	add    $0x228,%rsp
    af1e:	85 c9                	test   %ecx,%ecx
    af20:	0f 84 d7 03 00 00    	je     b2fd <fwp_write+0x6cd>
    af26:	5b                   	pop    %rbx
    af27:	41 5c                	pop    %r12
    af29:	41 5d                	pop    %r13
    af2b:	41 5e                	pop    %r14
    af2d:	41 5f                	pop    %r15
    af2f:	5d                   	pop    %rbp
    af30:	e9 bb c7 ff ff       	jmp    76f0 <buf_put>
    af35:	4c 89 ef             	mov    %r13,%rdi
    af38:	e8 33 ee ff ff       	call   9d70 <fwp_u128>
    af3d:	4c 8d 74 24 20       	lea    0x20(%rsp),%r14
    af42:	4c 89 f7             	mov    %r14,%rdi
    af45:	48 89 c6             	mov    %rax,%rsi
    af48:	e8 13 04 00 00       	call   b360 <fwp_fmt_u128>
    af4d:	e9 2f 02 00 00       	jmp    b181 <fwp_write+0x551>
    af52:	4c 89 ef             	mov    %r13,%rdi
    af55:	e8 06 ee ff ff       	call   9d60 <fwp_i128>
    af5a:	4c 8d 74 24 20       	lea    0x20(%rsp),%r14
    af5f:	4c 89 f7             	mov    %r14,%rdi
    af62:	48 89 c6             	mov    %rax,%rsi
    af65:	e8 d6 03 00 00       	call   b340 <fwp_fmt_i128>
    af6a:	e9 12 02 00 00       	jmp    b181 <fwp_write+0x551>
    af6f:	48 89 df             	mov    %rbx,%rdi
    af72:	be 5b 00 00 00       	mov    $0x5b,%esi
    af77:	e8 24 c7 ff ff       	call   76a0 <buf_putc>
    af7c:	4d 85 ed             	test   %r13,%r13
    af7f:	4c 8b 7c 24 08       	mov    0x8(%rsp),%r15
    af84:	0f 84 d5 01 00 00    	je     b15f <fwp_write+0x52f>
    af8a:	49 8b 57 38          	mov    0x38(%r15),%rdx
    af8e:	49 8b 75 08          	mov    0x8(%r13),%rsi
    af92:	48 89 df             	mov    %rbx,%rdi
    af95:	31 c9                	xor    %ecx,%ecx
    af97:	e8 94 fc ff ff       	call   ac30 <fwp_write>
    af9c:	4d 8b 65 10          	mov    0x10(%r13),%r12
    afa0:	4d 85 e4             	test   %r12,%r12
    afa3:	0f 84 b6 01 00 00    	je     b15f <fwp_write+0x52f>
    afa9:	4c 8d 35 9d 32 00 00 	lea    0x329d(%rip),%r14        # e24d <exec_in_fp0+0xc0d>
    afb0:	48 89 df             	mov    %rbx,%rdi
    afb3:	4c 89 f6             	mov    %r14,%rsi
    afb6:	e8 05 c7 ff ff       	call   76c0 <buf_puts>
    afbb:	49 8b 74 24 08       	mov    0x8(%r12),%rsi
    afc0:	49 8b 57 38          	mov    0x38(%r15),%rdx
    afc4:	48 89 df             	mov    %rbx,%rdi
    afc7:	31 c9                	xor    %ecx,%ecx
    afc9:	e8 62 fc ff ff       	call   ac30 <fwp_write>
    afce:	4d 8b 64 24 10       	mov    0x10(%r12),%r12
    afd3:	4d 85 e4             	test   %r12,%r12
    afd6:	75 d8                	jne    afb0 <fwp_write+0x380>
    afd8:	e9 82 01 00 00       	jmp    b15f <fwp_write+0x52f>
    afdd:	48 8b 44 24 08       	mov    0x8(%rsp),%rax
    afe2:	8b 50 48             	mov    0x48(%rax),%edx
    afe5:	48 89 df             	mov    %rbx,%rdi
    afe8:	4c 89 ee             	mov    %r13,%rsi
    afeb:	48 81 c4 28 02 00 00 	add    $0x228,%rsp
    aff2:	5b                   	pop    %rbx
    aff3:	41 5c                	pop    %r12
    aff5:	41 5d                	pop    %r13
    aff7:	41 5e                	pop    %r14
    aff9:	41 5f                	pop    %r15
    affb:	5d                   	pop    %rbp
    affc:	e9 2f 08 00 00       	jmp    b830 <fwp_trits>
    b001:	49 83 fd ff          	cmp    $0xffffffffffffffff,%r13
    b005:	48 8d 05 4d 32 00 00 	lea    0x324d(%rip),%rax        # e259 <exec_in_fp0+0xc19>
    b00c:	48 8d 0d 47 33 00 00 	lea    0x3347(%rip),%rcx        # e35a <exec_in_fp0+0xd1a>
    b013:	48 0f 44 c8          	cmove  %rax,%rcx
    b017:	49 83 fd 01          	cmp    $0x1,%r13
    b01b:	48 8d 35 34 32 00 00 	lea    0x3234(%rip),%rsi        # e256 <exec_in_fp0+0xc16>
    b022:	48 0f 45 f1          	cmovne %rcx,%rsi
    b026:	e9 7a 01 00 00       	jmp    b1a5 <fwp_write+0x575>
    b02b:	48 8d 35 fb 32 00 00 	lea    0x32fb(%rip),%rsi        # e32d <exec_in_fp0+0xced>
    b032:	48 89 df             	mov    %rbx,%rdi
    b035:	e8 86 c6 ff ff       	call   76c0 <buf_puts>
    b03a:	49 83 7d 00 00       	cmpq   $0x0,0x0(%r13)
    b03f:	4c 8b 7c 24 08       	mov    0x8(%rsp),%r15
    b044:	0f 84 15 01 00 00    	je     b15f <fwp_write+0x52f>
    b04a:	49 8b 57 38          	mov    0x38(%r15),%rdx
    b04e:	49 8b 75 08          	mov    0x8(%r13),%rsi
    b052:	48 89 df             	mov    %rbx,%rdi
    b055:	31 c9                	xor    %ecx,%ecx
    b057:	e8 d4 fb ff ff       	call   ac30 <fwp_write>
    b05c:	49 83 7d 00 02       	cmpq   $0x2,0x0(%r13)
    b061:	0f 82 f8 00 00 00    	jb     b15f <fwp_write+0x52f>
    b067:	41 be 01 00 00 00    	mov    $0x1,%r14d
    b06d:	4c 8d 25 d9 31 00 00 	lea    0x31d9(%rip),%r12        # e24d <exec_in_fp0+0xc0d>
    b074:	66 66 66 2e 0f 1f 84 	data16 data16 cs nopw 0x0(%rax,%rax,1)
    b07b:	00 00 00 00 00 
    b080:	48 89 df             	mov    %rbx,%rdi
    b083:	4c 89 e6             	mov    %r12,%rsi
    b086:	e8 35 c6 ff ff       	call   76c0 <buf_puts>
    b08b:	4b 8b 74 f5 08       	mov    0x8(%r13,%r14,8),%rsi
    b090:	49 8b 57 38          	mov    0x38(%r15),%rdx
    b094:	48 89 df             	mov    %rbx,%rdi
    b097:	31 c9                	xor    %ecx,%ecx
    b099:	e8 92 fb ff ff       	call   ac30 <fwp_write>
    b09e:	49 ff c6             	inc    %r14
    b0a1:	4d 3b 75 00          	cmp    0x0(%r13),%r14
    b0a5:	72 d9                	jb     b080 <fwp_write+0x450>
    b0a7:	e9 b3 00 00 00       	jmp    b15f <fwp_write+0x52f>
    b0ac:	48 8d 35 70 32 00 00 	lea    0x3270(%rip),%rsi        # e323 <exec_in_fp0+0xce3>
    b0b3:	48 89 df             	mov    %rbx,%rdi
    b0b6:	e8 05 c6 ff ff       	call   76c0 <buf_puts>
    b0bb:	49 83 7d 00 00       	cmpq   $0x0,0x0(%r13)
    b0c0:	0f 84 99 00 00 00    	je     b15f <fwp_write+0x52f>
    b0c6:	4c 89 ed             	mov    %r13,%rbp
    b0c9:	41 0f b6 4d 08       	movzbl 0x8(%r13),%ecx
    b0ce:	48 8d 15 55 32 00 00 	lea    0x3255(%rip),%rdx        # e32a <exec_in_fp0+0xcea>
    b0d5:	4c 8d 7c 24 20       	lea    0x20(%rsp),%r15
    b0da:	be 00 02 00 00       	mov    $0x200,%esi
    b0df:	4c 89 ff             	mov    %r15,%rdi
    b0e2:	31 c0                	xor    %eax,%eax
    b0e4:	e8 e7 70 ff ff       	call   21d0 <snprintf@plt>
    b0e9:	48 89 df             	mov    %rbx,%rdi
    b0ec:	4c 89 fe             	mov    %r15,%rsi
    b0ef:	e8 cc c5 ff ff       	call   76c0 <buf_puts>
    b0f4:	49 83 7d 00 02       	cmpq   $0x2,0x0(%r13)
    b0f9:	72 64                	jb     b15f <fwp_write+0x52f>
    b0fb:	41 be 09 00 00 00    	mov    $0x9,%r14d
    b101:	4c 8d 3d 45 31 00 00 	lea    0x3145(%rip),%r15        # e24d <exec_in_fp0+0xc0d>
    b108:	4c 8d 25 1b 32 00 00 	lea    0x321b(%rip),%r12        # e32a <exec_in_fp0+0xcea>
    b10f:	4c 8d 6c 24 20       	lea    0x20(%rsp),%r13
    b114:	66 66 66 2e 0f 1f 84 	data16 data16 cs nopw 0x0(%rax,%rax,1)
    b11b:	00 00 00 00 00 
    b120:	48 89 df             	mov    %rbx,%rdi
    b123:	4c 89 fe             	mov    %r15,%rsi
    b126:	e8 95 c5 ff ff       	call   76c0 <buf_puts>
    b12b:	42 0f b6 4c 35 00    	movzbl 0x0(%rbp,%r14,1),%ecx
    b131:	be 00 02 00 00       	mov    $0x200,%esi
    b136:	4c 89 ef             	mov    %r13,%rdi
    b139:	4c 89 e2             	mov    %r12,%rdx
    b13c:	31 c0                	xor    %eax,%eax
    b13e:	e8 8d 70 ff ff       	call   21d0 <snprintf@plt>
    b143:	48 89 df             	mov    %rbx,%rdi
    b146:	4c 89 ee             	mov    %r13,%rsi
    b149:	e8 72 c5 ff ff       	call   76c0 <buf_puts>
    b14e:	49 8d 46 01          	lea    0x1(%r14),%rax
    b152:	49 83 c6 f9          	add    $0xfffffffffffffff9,%r14
    b156:	4c 3b 75 00          	cmp    0x0(%rbp),%r14
    b15a:	49 89 c6             	mov    %rax,%r14
    b15d:	72 c1                	jb     b120 <fwp_write+0x4f0>
    b15f:	48 89 df             	mov    %rbx,%rdi
    b162:	be 5d 00 00 00       	mov    $0x5d,%esi
    b167:	e9 7b 01 00 00       	jmp    b2e7 <fwp_write+0x6b7>
    b16c:	4c 89 ef             	mov    %r13,%rdi
    b16f:	e8 1c ec ff ff       	call   9d90 <fwp_f32>
    b174:	4c 8d 74 24 20       	lea    0x20(%rsp),%r14
    b179:	4c 89 f7             	mov    %r14,%rdi
    b17c:	e8 ef 03 00 00       	call   b570 <fwp_fmt_f32>
    b181:	48 89 df             	mov    %rbx,%rdi
    b184:	4c 89 f6             	mov    %r14,%rsi
    b187:	e8 34 c5 ff ff       	call   76c0 <buf_puts>
    b18c:	48 81 c4 28 02 00 00 	add    $0x228,%rsp
    b193:	5b                   	pop    %rbx
    b194:	41 5c                	pop    %r12
    b196:	41 5d                	pop    %r13
    b198:	41 5e                	pop    %r14
    b19a:	41 5f                	pop    %r15
    b19c:	5d                   	pop    %rbp
    b19d:	c3                   	ret
    b19e:	48 8d 35 63 31 00 00 	lea    0x3163(%rip),%rsi        # e308 <exec_in_fp0+0xcc8>
    b1a5:	48 89 df             	mov    %rbx,%rdi
    b1a8:	48 81 c4 28 02 00 00 	add    $0x228,%rsp
    b1af:	5b                   	pop    %rbx
    b1b0:	41 5c                	pop    %r12
    b1b2:	41 5d                	pop    %r13
    b1b4:	41 5e                	pop    %r14
    b1b6:	41 5f                	pop    %r15
    b1b8:	5d                   	pop    %rbp
    b1b9:	e9 02 c5 ff ff       	jmp    76c0 <buf_puts>
    b1be:	48 8d 35 57 31 00 00 	lea    0x3157(%rip),%rsi        # e31c <exec_in_fp0+0xcdc>
    b1c5:	48 89 df             	mov    %rbx,%rdi
    b1c8:	e8 f3 c4 ff ff       	call   76c0 <buf_puts>
    b1cd:	49 83 c5 10          	add    $0x10,%r13
    b1d1:	48 89 df             	mov    %rbx,%rdi
    b1d4:	4c 89 ee             	mov    %r13,%rsi
    b1d7:	e8 e4 c4 ff ff       	call   76c0 <buf_puts>
    b1dc:	48 89 df             	mov    %rbx,%rdi
    b1df:	be 3e 00 00 00       	mov    $0x3e,%esi
    b1e4:	e9 fe 00 00 00       	jmp    b2e7 <fwp_write+0x6b7>
    b1e9:	41 83 7f 10 00       	cmpl   $0x0,0x10(%r15)
    b1ee:	0f 84 35 01 00 00    	je     b329 <fwp_write+0x6f9>
    b1f4:	4d 8d 77 10          	lea    0x10(%r15),%r14
    b1f8:	4d 85 e4             	test   %r12,%r12
    b1fb:	0f 94 c0             	sete   %al
    b1fe:	41 83 7f 48 00       	cmpl   $0x0,0x48(%r15)
    b203:	40 0f 95 c5          	setne  %bpl
    b207:	40 20 c5             	and    %al,%bpl
    b20a:	40 84 ed             	test   %bpl,%bpl
    b20d:	b8 28 00 00 00       	mov    $0x28,%eax
    b212:	be 7b 00 00 00       	mov    $0x7b,%esi
    b217:	0f 45 f0             	cmovne %eax,%esi
    b21a:	48 89 df             	mov    %rbx,%rdi
    b21d:	e8 7e c4 ff ff       	call   76a0 <buf_putc>
    b222:	41 83 3e 00          	cmpl   $0x0,(%r14)
    b226:	0f 8e a8 00 00 00    	jle    b2d4 <fwp_write+0x6a4>
    b22c:	40 84 ed             	test   %bpl,%bpl
    b22f:	75 1e                	jne    b24f <fwp_write+0x61f>
    b231:	49 8b 47 18          	mov    0x18(%r15),%rax
    b235:	48 8b 30             	mov    (%rax),%rsi
    b238:	48 89 df             	mov    %rbx,%rdi
    b23b:	e8 80 c4 ff ff       	call   76c0 <buf_puts>
    b240:	48 8d 35 fa 30 00 00 	lea    0x30fa(%rip),%rsi        # e341 <exec_in_fp0+0xd01>
    b247:	48 89 df             	mov    %rbx,%rdi
    b24a:	e8 71 c4 ff ff       	call   76c0 <buf_puts>
    b24f:	49 8b 75 08          	mov    0x8(%r13),%rsi
    b253:	49 8b 47 20          	mov    0x20(%r15),%rax
    b257:	48 8b 10             	mov    (%rax),%rdx
    b25a:	48 89 df             	mov    %rbx,%rdi
    b25d:	31 c9                	xor    %ecx,%ecx
    b25f:	e8 cc f9 ff ff       	call   ac30 <fwp_write>
    b264:	41 83 7f 10 02       	cmpl   $0x2,0x10(%r15)
    b269:	7c 69                	jl     b2d4 <fwp_write+0x6a4>
    b26b:	41 be 01 00 00 00    	mov    $0x1,%r14d
    b271:	4c 8d 25 d5 2f 00 00 	lea    0x2fd5(%rip),%r12        # e24d <exec_in_fp0+0xc0d>
    b278:	eb 29                	jmp    b2a3 <fwp_write+0x673>
    b27a:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)
    b280:	4b 8b 74 f5 08       	mov    0x8(%r13,%r14,8),%rsi
    b285:	49 8b 47 20          	mov    0x20(%r15),%rax
    b289:	4a 8b 14 f0          	mov    (%rax,%r14,8),%rdx
    b28d:	48 89 df             	mov    %rbx,%rdi
    b290:	31 c9                	xor    %ecx,%ecx
    b292:	e8 99 f9 ff ff       	call   ac30 <fwp_write>
    b297:	49 ff c6             	inc    %r14
    b29a:	49 63 47 10          	movslq 0x10(%r15),%rax
    b29e:	49 39 c6             	cmp    %rax,%r14
    b2a1:	7d 31                	jge    b2d4 <fwp_write+0x6a4>
    b2a3:	48 89 df             	mov    %rbx,%rdi
    b2a6:	4c 89 e6             	mov    %r12,%rsi
    b2a9:	e8 12 c4 ff ff       	call   76c0 <buf_puts>
    b2ae:	40 84 ed             	test   %bpl,%bpl
    b2b1:	75 cd                	jne    b280 <fwp_write+0x650>
    b2b3:	49 8b 47 18          	mov    0x18(%r15),%rax
    b2b7:	4a 8b 34 f0          	mov    (%rax,%r14,8),%rsi
    b2bb:	48 89 df             	mov    %rbx,%rdi
    b2be:	e8 fd c3 ff ff       	call   76c0 <buf_puts>
    b2c3:	48 89 df             	mov    %rbx,%rdi
    b2c6:	48 8d 35 74 30 00 00 	lea    0x3074(%rip),%rsi        # e341 <exec_in_fp0+0xd01>
    b2cd:	e8 ee c3 ff ff       	call   76c0 <buf_puts>
    b2d2:	eb ac                	jmp    b280 <fwp_write+0x650>
    b2d4:	40 84 ed             	test   %bpl,%bpl
    b2d7:	b8 29 00 00 00       	mov    $0x29,%eax
    b2dc:	be 7d 00 00 00       	mov    $0x7d,%esi
    b2e1:	0f 45 f0             	cmovne %eax,%esi
    b2e4:	48 89 df             	mov    %rbx,%rdi
    b2e7:	48 81 c4 28 02 00 00 	add    $0x228,%rsp
    b2ee:	5b                   	pop    %rbx
    b2ef:	41 5c                	pop    %r12
    b2f1:	41 5d                	pop    %r13
    b2f3:	41 5e                	pop    %r14
    b2f5:	41 5f                	pop    %r15
    b2f7:	5d                   	pop    %rbp
    b2f8:	e9 a3 c3 ff ff       	jmp    76a0 <buf_putc>
    b2fd:	5b                   	pop    %rbx
    b2fe:	41 5c                	pop    %r12
    b300:	41 5d                	pop    %r13
    b302:	41 5e                	pop    %r14
    b304:	41 5f                	pop    %r15
    b306:	5d                   	pop    %rbp
    b307:	e9 14 06 00 00       	jmp    b920 <fwp_escape>
    b30c:	49 8b 75 08          	mov    0x8(%r13),%rsi
    b310:	48 89 f2             	mov    %rsi,%rdx
    b313:	48 c1 fa 3f          	sar    $0x3f,%rdx
    b317:	4c 8d 74 24 20       	lea    0x20(%rsp),%r14
    b31c:	4c 89 f7             	mov    %r14,%rdi
    b31f:	e8 0c 07 00 00       	call   ba30 <fwp_fmt_duration>
    b324:	e9 58 fe ff ff       	jmp    b181 <fwp_write+0x551>
    b329:	48 8d 35 0e 30 00 00 	lea    0x300e(%rip),%rsi        # e33e <exec_in_fp0+0xcfe>
    b330:	e9 70 fe ff ff       	jmp    b1a5 <fwp_write+0x575>
    b335:	66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
    b33c:	00 00 00 00 

000000000000b340 <fwp_fmt_i128>:
    b340:	48 85 d2             	test   %rdx,%rdx
    b343:	79 1b                	jns    b360 <fwp_fmt_u128>
    b345:	c6 07 2d             	movb   $0x2d,(%rdi)
    b348:	48 ff c7             	inc    %rdi
    b34b:	31 c0                	xor    %eax,%eax
    b34d:	48 f7 de             	neg    %rsi
    b350:	48 19 d0             	sbb    %rdx,%rax
    b353:	48 89 c2             	mov    %rax,%rdx
    b356:	eb 08                	jmp    b360 <fwp_fmt_u128>
    b358:	0f 1f 84 00 00 00 00 	nopl   0x0(%rax,%rax,1)
    b35f:	00 

000000000000b360 <fwp_fmt_u128>:
    b360:	41 56                	push   %r14
    b362:	53                   	push   %rbx
    b363:	48 89 f0             	mov    %rsi,%rax
    b366:	48 09 d0             	or     %rdx,%rax
    b369:	0f 84 9d 00 00 00    	je     b40c <fwp_fmt_u128+0xac>
    b36f:	48 89 d1             	mov    %rdx,%rcx
    b372:	45 31 d2             	xor    %r10d,%r10d
    b375:	49 bb cd cc cc cc cc 	movabs $0xcccccccccccccccd,%r11
    b37c:	cc cc cc 
    b37f:	48 bb cc cc cc cc cc 	movabs $0xcccccccccccccccc,%rbx
    b386:	cc cc cc 
    b389:	49 89 d6             	mov    %rdx,%r14
    b38c:	0f 1f 40 00          	nopl   0x0(%rax)
    b390:	49 89 c8             	mov    %rcx,%r8
    b393:	49 0f a4 f0 3f       	shld   $0x3f,%rsi,%r8
    b398:	49 d1 ee             	shr    $1,%r14
    b39b:	4d 89 c1             	mov    %r8,%r9
    b39e:	4d 01 f1             	add    %r14,%r9
    b3a1:	49 83 d1 00          	adc    $0x0,%r9
    b3a5:	4c 89 c8             	mov    %r9,%rax
    b3a8:	49 f7 e3             	mul    %r11
    b3ab:	48 c1 ea 02          	shr    $0x2,%rdx
    b3af:	48 8d 04 92          	lea    (%rdx,%rdx,4),%rax
    b3b3:	49 29 c1             	sub    %rax,%r9
    b3b6:	4d 29 c8             	sub    %r9,%r8
    b3b9:	49 83 de 00          	sbb    $0x0,%r14
    b3bd:	4d 89 c1             	mov    %r8,%r9
    b3c0:	4c 0f af cb          	imul   %rbx,%r9
    b3c4:	4c 89 c0             	mov    %r8,%rax
    b3c7:	49 f7 e3             	mul    %r11
    b3ca:	4c 01 ca             	add    %r9,%rdx
    b3cd:	4d 0f af f3          	imul   %r11,%r14
    b3d1:	49 01 d6             	add    %rdx,%r14
    b3d4:	48 89 c2             	mov    %rax,%rdx
    b3d7:	48 01 c2             	add    %rax,%rdx
    b3da:	48 8d 14 92          	lea    (%rdx,%rdx,4),%rdx
    b3de:	41 89 f0             	mov    %esi,%r8d
    b3e1:	41 29 d0             	sub    %edx,%r8d
    b3e4:	41 80 c8 30          	or     $0x30,%r8b
    b3e8:	46 88 44 14 b8       	mov    %r8b,-0x48(%rsp,%r10,1)
    b3ed:	49 ff c2             	inc    %r10
    b3f0:	48 83 fe 0a          	cmp    $0xa,%rsi
    b3f4:	48 83 d9 00          	sbb    $0x0,%rcx
    b3f8:	48 89 c6             	mov    %rax,%rsi
    b3fb:	4c 89 f1             	mov    %r14,%rcx
    b3fe:	73 90                	jae    b390 <fwp_fmt_u128+0x30>
    b400:	45 85 d2             	test   %r10d,%r10d
    b403:	7f 12                	jg     b417 <fwp_fmt_u128+0xb7>
    b405:	31 c0                	xor    %eax,%eax
    b407:	e9 56 01 00 00       	jmp    b562 <fwp_fmt_u128+0x202>
    b40c:	c6 44 24 b8 30       	movb   $0x30,-0x48(%rsp)
    b411:	41 ba 01 00 00 00    	mov    $0x1,%r10d
    b417:	44 89 d0             	mov    %r10d,%eax
    b41a:	41 83 fa 08          	cmp    $0x8,%r10d
    b41e:	73 0a                	jae    b42a <fwp_fmt_u128+0xca>
    b420:	31 c9                	xor    %ecx,%ecx
    b422:	48 89 c2             	mov    %rax,%rdx
    b425:	e9 10 01 00 00       	jmp    b53a <fwp_fmt_u128+0x1da>
    b42a:	83 f8 20             	cmp    $0x20,%eax
    b42d:	73 07                	jae    b436 <fwp_fmt_u128+0xd6>
    b42f:	31 c9                	xor    %ecx,%ecx
    b431:	e9 a4 00 00 00       	jmp    b4da <fwp_fmt_u128+0x17a>
    b436:	89 c1                	mov    %eax,%ecx
    b438:	81 e1 e0 ff ff 7f    	and    $0x7fffffe0,%ecx
    b43e:	48 8d 54 24 b8       	lea    -0x48(%rsp),%rdx
    b443:	48 01 c2             	add    %rax,%rdx
    b446:	48 83 c2 f0          	add    $0xfffffffffffffff0,%rdx
    b44a:	31 f6                	xor    %esi,%esi
    b44c:	66 0f ef c0          	pxor   %xmm0,%xmm0
    b450:	f3 0f 6f 4a f0       	movdqu -0x10(%rdx),%xmm1
    b455:	f3 0f 6f 12          	movdqu (%rdx),%xmm2
    b459:	66 0f 6f da          	movdqa %xmm2,%xmm3
    b45d:	66 0f 60 d8          	punpcklbw %xmm0,%xmm3
    b461:	66 0f 70 db 4e       	pshufd $0x4e,%xmm3,%xmm3
    b466:	f2 0f 70 db 1b       	pshuflw $0x1b,%xmm3,%xmm3
    b46b:	f3 0f 70 db 1b       	pshufhw $0x1b,%xmm3,%xmm3
    b470:	66 0f 68 d0          	punpckhbw %xmm0,%xmm2
    b474:	66 0f 70 d2 4e       	pshufd $0x4e,%xmm2,%xmm2
    b479:	f2 0f 70 d2 1b       	pshuflw $0x1b,%xmm2,%xmm2
    b47e:	f3 0f 70 d2 1b       	pshufhw $0x1b,%xmm2,%xmm2
    b483:	66 0f 67 d3          	packuswb %xmm3,%xmm2
    b487:	66 0f 6f d9          	movdqa %xmm1,%xmm3
    b48b:	66 0f 60 d8          	punpcklbw %xmm0,%xmm3
    b48f:	66 0f 70 db 4e       	pshufd $0x4e,%xmm3,%xmm3
    b494:	f2 0f 70 db 1b       	pshuflw $0x1b,%xmm3,%xmm3
    b499:	f3 0f 70 db 1b       	pshufhw $0x1b,%xmm3,%xmm3
    b49e:	66 0f 68 c8          	punpckhbw %xmm0,%xmm1
    b4a2:	66 0f 70 c9 4e       	pshufd $0x4e,%xmm1,%xmm1
    b4a7:	f2 0f 70 c9 1b       	pshuflw $0x1b,%xmm1,%xmm1
    b4ac:	f3 0f 70 c9 1b       	pshufhw $0x1b,%xmm1,%xmm1
    b4b1:	66 0f 67 cb          	packuswb %xmm3,%xmm1
    b4b5:	f3 0f 7f 14 37       	movdqu %xmm2,(%rdi,%rsi,1)
    b4ba:	f3 0f 7f 4c 37 10    	movdqu %xmm1,0x10(%rdi,%rsi,1)
    b4c0:	48 83 c6 20          	add    $0x20,%rsi
    b4c4:	48 83 c2 e0          	add    $0xffffffffffffffe0,%rdx
    b4c8:	48 39 f1             	cmp    %rsi,%rcx
    b4cb:	75 83                	jne    b450 <fwp_fmt_u128+0xf0>
    b4cd:	48 39 c1             	cmp    %rax,%rcx
    b4d0:	0f 84 8c 00 00 00    	je     b562 <fwp_fmt_u128+0x202>
    b4d6:	a8 18                	test   $0x18,%al
    b4d8:	74 5b                	je     b535 <fwp_fmt_u128+0x1d5>
    b4da:	48 89 ce             	mov    %rcx,%rsi
    b4dd:	89 c1                	mov    %eax,%ecx
    b4df:	81 e1 f8 ff ff 7f    	and    $0x7ffffff8,%ecx
    b4e5:	89 c2                	mov    %eax,%edx
    b4e7:	83 e2 07             	and    $0x7,%edx
    b4ea:	49 89 c0             	mov    %rax,%r8
    b4ed:	49 29 f0             	sub    %rsi,%r8
    b4f0:	49 01 e0             	add    %rsp,%r8
    b4f3:	49 83 c0 b0          	add    $0xffffffffffffffb0,%r8
    b4f7:	66 0f ef c0          	pxor   %xmm0,%xmm0
    b4fb:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)
    b500:	f3 41 0f 7e 08       	movq   (%r8),%xmm1
    b505:	66 0f 60 c8          	punpcklbw %xmm0,%xmm1
    b509:	66 0f 70 c9 4e       	pshufd $0x4e,%xmm1,%xmm1
    b50e:	f2 0f 70 c9 1b       	pshuflw $0x1b,%xmm1,%xmm1
    b513:	f3 0f 70 c9 1b       	pshufhw $0x1b,%xmm1,%xmm1
    b518:	66 0f 67 c9          	packuswb %xmm1,%xmm1
    b51c:	66 0f d6 0c 37       	movq   %xmm1,(%rdi,%rsi,1)
    b521:	48 83 c6 08          	add    $0x8,%rsi
    b525:	49 83 c0 f8          	add    $0xfffffffffffffff8,%r8
    b529:	48 39 f1             	cmp    %rsi,%rcx
    b52c:	75 d2                	jne    b500 <fwp_fmt_u128+0x1a0>
    b52e:	48 39 c1             	cmp    %rax,%rcx
    b531:	75 07                	jne    b53a <fwp_fmt_u128+0x1da>
    b533:	eb 2d                	jmp    b562 <fwp_fmt_u128+0x202>
    b535:	89 c2                	mov    %eax,%edx
    b537:	83 e2 1f             	and    $0x1f,%edx
    b53a:	48 8d 74 24 b8       	lea    -0x48(%rsp),%rsi
    b53f:	48 01 f2             	add    %rsi,%rdx
    b542:	48 ff ca             	dec    %rdx
    b545:	66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
    b54c:	00 00 00 00 
    b550:	0f b6 32             	movzbl (%rdx),%esi
    b553:	40 88 34 0f          	mov    %sil,(%rdi,%rcx,1)
    b557:	48 ff c1             	inc    %rcx
    b55a:	48 ff ca             	dec    %rdx
    b55d:	48 39 c8             	cmp    %rcx,%rax
    b560:	75 ee                	jne    b550 <fwp_fmt_u128+0x1f0>
    b562:	c6 04 07 00          	movb   $0x0,(%rdi,%rax,1)
    b566:	5b                   	pop    %rbx
    b567:	41 5e                	pop    %r14
    b569:	c3                   	ret
    b56a:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)

000000000000b570 <fwp_fmt_f32>:
    b570:	53                   	push   %rbx
    b571:	48 83 ec 20          	sub    $0x20,%rsp
    b575:	48 89 fb             	mov    %rdi,%rbx
    b578:	0f 2e c0             	ucomiss %xmm0,%xmm0
    b57b:	0f 8a d8 01 00 00    	jp     b759 <fwp_fmt_f32+0x1e9>
    b581:	0f 28 c8             	movaps %xmm0,%xmm1
    b584:	0f 28 05 b5 1b 00 00 	movaps 0x1bb5(%rip),%xmm0        # d140 <_IO_stdin_used+0x140>
    b58b:	0f 54 c1             	andps  %xmm1,%xmm0
    b58e:	0f 2e 05 6f 1a 00 00 	ucomiss 0x1a6f(%rip),%xmm0        # d004 <_IO_stdin_used+0x4>
    b595:	72 25                	jb     b5bc <fwp_fmt_f32+0x4c>
    b597:	0f 57 c0             	xorps  %xmm0,%xmm0
    b59a:	0f 2e c8             	ucomiss %xmm0,%xmm1
    b59d:	48 8d 05 e1 2c 00 00 	lea    0x2ce1(%rip),%rax        # e285 <exec_in_fp0+0xc45>
    b5a4:	48 8d 35 d9 2c 00 00 	lea    0x2cd9(%rip),%rsi        # e284 <exec_in_fp0+0xc44>
    b5ab:	48 0f 47 f0          	cmova  %rax,%rsi
    b5af:	48 89 df             	mov    %rbx,%rdi
    b5b2:	48 83 c4 20          	add    $0x20,%rsp
    b5b6:	5b                   	pop    %rbx
    b5b7:	e9 f4 6a ff ff       	jmp    20b0 <strcpy@plt>
    b5bc:	0f 57 c0             	xorps  %xmm0,%xmm0
    b5bf:	f3 0f 5a c1          	cvtss2sd %xmm1,%xmm0
    b5c3:	48 89 df             	mov    %rbx,%rdi
    b5c6:	f2 0f 11 44 24 08    	movsd  %xmm0,0x8(%rsp)
    b5cc:	be 01 00 00 00       	mov    $0x1,%esi
    b5d1:	0f 29 4c 24 10       	movaps %xmm1,0x10(%rsp)
    b5d6:	e8 95 07 00 00       	call   bd70 <fwp_format_g>
    b5db:	48 89 df             	mov    %rbx,%rdi
    b5de:	31 f6                	xor    %esi,%esi
    b5e0:	e8 1b 6c ff ff       	call   2200 <strtof@plt>
    b5e5:	0f 2e 44 24 10       	ucomiss 0x10(%rsp),%xmm0
    b5ea:	75 06                	jne    b5f2 <fwp_fmt_f32+0x82>
    b5ec:	0f 8b 5a 01 00 00    	jnp    b74c <fwp_fmt_f32+0x1dc>
    b5f2:	48 89 df             	mov    %rbx,%rdi
    b5f5:	f2 0f 10 44 24 08    	movsd  0x8(%rsp),%xmm0
    b5fb:	be 02 00 00 00       	mov    $0x2,%esi
    b600:	e8 6b 07 00 00       	call   bd70 <fwp_format_g>
    b605:	48 89 df             	mov    %rbx,%rdi
    b608:	31 f6                	xor    %esi,%esi
    b60a:	e8 f1 6b ff ff       	call   2200 <strtof@plt>
    b60f:	0f 2e 44 24 10       	ucomiss 0x10(%rsp),%xmm0
    b614:	75 06                	jne    b61c <fwp_fmt_f32+0xac>
    b616:	0f 8b 30 01 00 00    	jnp    b74c <fwp_fmt_f32+0x1dc>
    b61c:	48 89 df             	mov    %rbx,%rdi
    b61f:	f2 0f 10 44 24 08    	movsd  0x8(%rsp),%xmm0
    b625:	be 03 00 00 00       	mov    $0x3,%esi
    b62a:	e8 41 07 00 00       	call   bd70 <fwp_format_g>
    b62f:	48 89 df             	mov    %rbx,%rdi
    b632:	31 f6                	xor    %esi,%esi
    b634:	e8 c7 6b ff ff       	call   2200 <strtof@plt>
    b639:	0f 2e 44 24 10       	ucomiss 0x10(%rsp),%xmm0
    b63e:	75 06                	jne    b646 <fwp_fmt_f32+0xd6>
    b640:	0f 8b 06 01 00 00    	jnp    b74c <fwp_fmt_f32+0x1dc>
    b646:	48 89 df             	mov    %rbx,%rdi
    b649:	f2 0f 10 44 24 08    	movsd  0x8(%rsp),%xmm0
    b64f:	be 04 00 00 00       	mov    $0x4,%esi
    b654:	e8 17 07 00 00       	call   bd70 <fwp_format_g>
    b659:	48 89 df             	mov    %rbx,%rdi
    b65c:	31 f6                	xor    %esi,%esi
    b65e:	e8 9d 6b ff ff       	call   2200 <strtof@plt>
    b663:	0f 2e 44 24 10       	ucomiss 0x10(%rsp),%xmm0
    b668:	75 06                	jne    b670 <fwp_fmt_f32+0x100>
    b66a:	0f 8b dc 00 00 00    	jnp    b74c <fwp_fmt_f32+0x1dc>
    b670:	48 89 df             	mov    %rbx,%rdi
    b673:	f2 0f 10 44 24 08    	movsd  0x8(%rsp),%xmm0
    b679:	be 05 00 00 00       	mov    $0x5,%esi
    b67e:	e8 ed 06 00 00       	call   bd70 <fwp_format_g>
    b683:	48 89 df             	mov    %rbx,%rdi
    b686:	31 f6                	xor    %esi,%esi
    b688:	e8 73 6b ff ff       	call   2200 <strtof@plt>
    b68d:	0f 2e 44 24 10       	ucomiss 0x10(%rsp),%xmm0
    b692:	75 06                	jne    b69a <fwp_fmt_f32+0x12a>
    b694:	0f 8b b2 00 00 00    	jnp    b74c <fwp_fmt_f32+0x1dc>
    b69a:	48 89 df             	mov    %rbx,%rdi
    b69d:	f2 0f 10 44 24 08    	movsd  0x8(%rsp),%xmm0
    b6a3:	be 06 00 00 00       	mov    $0x6,%esi
    b6a8:	e8 c3 06 00 00       	call   bd70 <fwp_format_g>
    b6ad:	48 89 df             	mov    %rbx,%rdi
    b6b0:	31 f6                	xor    %esi,%esi
    b6b2:	e8 49 6b ff ff       	call   2200 <strtof@plt>
    b6b7:	0f 2e 44 24 10       	ucomiss 0x10(%rsp),%xmm0
    b6bc:	75 06                	jne    b6c4 <fwp_fmt_f32+0x154>
    b6be:	0f 8b 88 00 00 00    	jnp    b74c <fwp_fmt_f32+0x1dc>
    b6c4:	48 89 df             	mov    %rbx,%rdi
    b6c7:	f2 0f 10 44 24 08    	movsd  0x8(%rsp),%xmm0
    b6cd:	be 07 00 00 00       	mov    $0x7,%esi
    b6d2:	e8 99 06 00 00       	call   bd70 <fwp_format_g>
    b6d7:	48 89 df             	mov    %rbx,%rdi
    b6da:	31 f6                	xor    %esi,%esi
    b6dc:	e8 1f 6b ff ff       	call   2200 <strtof@plt>
    b6e1:	0f 2e 44 24 10       	ucomiss 0x10(%rsp),%xmm0
    b6e6:	75 02                	jne    b6ea <fwp_fmt_f32+0x17a>
    b6e8:	7b 62                	jnp    b74c <fwp_fmt_f32+0x1dc>
    b6ea:	48 89 df             	mov    %rbx,%rdi
    b6ed:	f2 0f 10 44 24 08    	movsd  0x8(%rsp),%xmm0
    b6f3:	be 08 00 00 00       	mov    $0x8,%esi
    b6f8:	e8 73 06 00 00       	call   bd70 <fwp_format_g>
    b6fd:	48 89 df             	mov    %rbx,%rdi
    b700:	31 f6                	xor    %esi,%esi
    b702:	e8 f9 6a ff ff       	call   2200 <strtof@plt>
    b707:	0f 28 4c 24 10       	movaps 0x10(%rsp),%xmm1
    b70c:	0f 2e c1             	ucomiss %xmm1,%xmm0
    b70f:	75 02                	jne    b713 <fwp_fmt_f32+0x1a3>
    b711:	7b 39                	jnp    b74c <fwp_fmt_f32+0x1dc>
    b713:	48 89 df             	mov    %rbx,%rdi
    b716:	f2 0f 10 44 24 08    	movsd  0x8(%rsp),%xmm0
    b71c:	be 09 00 00 00       	mov    $0x9,%esi
    b721:	e8 4a 06 00 00       	call   bd70 <fwp_format_g>
    b726:	48 89 df             	mov    %rbx,%rdi
    b729:	31 f6                	xor    %esi,%esi
    b72b:	e8 d0 6a ff ff       	call   2200 <strtof@plt>
    b730:	0f 2e 44 24 10       	ucomiss 0x10(%rsp),%xmm0
    b735:	75 02                	jne    b739 <fwp_fmt_f32+0x1c9>
    b737:	7b 13                	jnp    b74c <fwp_fmt_f32+0x1dc>
    b739:	48 89 df             	mov    %rbx,%rdi
    b73c:	f2 0f 10 44 24 08    	movsd  0x8(%rsp),%xmm0
    b742:	be 09 00 00 00       	mov    $0x9,%esi
    b747:	e8 24 06 00 00       	call   bd70 <fwp_format_g>
    b74c:	48 89 df             	mov    %rbx,%rdi
    b74f:	48 83 c4 20          	add    $0x20,%rsp
    b753:	5b                   	pop    %rbx
    b754:	e9 97 07 00 00       	jmp    bef0 <fwp_finish_float>
    b759:	c7 03 4e 61 4e 00    	movl   $0x4e614e,(%rbx)
    b75f:	48 83 c4 20          	add    $0x20,%rsp
    b763:	5b                   	pop    %rbx
    b764:	c3                   	ret
    b765:	66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
    b76c:	00 00 00 00 

000000000000b770 <fwp_fmt_f64>:
    b770:	55                   	push   %rbp
    b771:	53                   	push   %rbx
    b772:	48 83 ec 18          	sub    $0x18,%rsp
    b776:	48 89 fb             	mov    %rdi,%rbx
    b779:	66 0f 2e c0          	ucomisd %xmm0,%xmm0
    b77d:	0f 8a 98 00 00 00    	jp     b81b <fwp_fmt_f64+0xab>
    b783:	66 0f 28 c8          	movapd %xmm0,%xmm1
    b787:	66 0f 28 05 c1 19 00 	movapd 0x19c1(%rip),%xmm0        # d150 <_IO_stdin_used+0x150>
    b78e:	00 
    b78f:	66 0f 54 c1          	andpd  %xmm1,%xmm0
    b793:	66 0f 2e 05 8d 18 00 	ucomisd 0x188d(%rip),%xmm0        # d028 <_IO_stdin_used+0x28>
    b79a:	00 
    b79b:	72 28                	jb     b7c5 <fwp_fmt_f64+0x55>
    b79d:	66 0f 57 c0          	xorpd  %xmm0,%xmm0
    b7a1:	66 0f 2e c8          	ucomisd %xmm0,%xmm1
    b7a5:	48 8d 05 d9 2a 00 00 	lea    0x2ad9(%rip),%rax        # e285 <exec_in_fp0+0xc45>
    b7ac:	48 8d 35 d1 2a 00 00 	lea    0x2ad1(%rip),%rsi        # e284 <exec_in_fp0+0xc44>
    b7b3:	48 0f 47 f0          	cmova  %rax,%rsi
    b7b7:	48 89 df             	mov    %rbx,%rdi
    b7ba:	48 83 c4 18          	add    $0x18,%rsp
    b7be:	5b                   	pop    %rbx
    b7bf:	5d                   	pop    %rbp
    b7c0:	e9 eb 68 ff ff       	jmp    20b0 <strcpy@plt>
    b7c5:	bd 01 00 00 00       	mov    $0x1,%ebp
    b7ca:	66 0f 29 0c 24       	movapd %xmm1,(%rsp)
    b7cf:	90                   	nop
    b7d0:	48 89 df             	mov    %rbx,%rdi
    b7d3:	66 0f 28 c1          	movapd %xmm1,%xmm0
    b7d7:	89 ee                	mov    %ebp,%esi
    b7d9:	e8 92 05 00 00       	call   bd70 <fwp_format_g>
    b7de:	48 89 df             	mov    %rbx,%rdi
    b7e1:	31 f6                	xor    %esi,%esi
    b7e3:	e8 18 69 ff ff       	call   2100 <strtod@plt>
    b7e8:	66 0f 28 0c 24       	movapd (%rsp),%xmm1
    b7ed:	66 0f 2e c1          	ucomisd %xmm1,%xmm0
    b7f1:	75 02                	jne    b7f5 <fwp_fmt_f64+0x85>
    b7f3:	7b 18                	jnp    b80d <fwp_fmt_f64+0x9d>
    b7f5:	ff c5                	inc    %ebp
    b7f7:	83 fd 12             	cmp    $0x12,%ebp
    b7fa:	75 d4                	jne    b7d0 <fwp_fmt_f64+0x60>
    b7fc:	48 89 df             	mov    %rbx,%rdi
    b7ff:	66 0f 28 c1          	movapd %xmm1,%xmm0
    b803:	be 11 00 00 00       	mov    $0x11,%esi
    b808:	e8 63 05 00 00       	call   bd70 <fwp_format_g>
    b80d:	48 89 df             	mov    %rbx,%rdi
    b810:	48 83 c4 18          	add    $0x18,%rsp
    b814:	5b                   	pop    %rbx
    b815:	5d                   	pop    %rbp
    b816:	e9 d5 06 00 00       	jmp    bef0 <fwp_finish_float>
    b81b:	c7 03 4e 61 4e 00    	movl   $0x4e614e,(%rbx)
    b821:	48 83 c4 18          	add    $0x18,%rsp
    b825:	5b                   	pop    %rbx
    b826:	5d                   	pop    %rbp
    b827:	c3                   	ret
    b828:	0f 1f 84 00 00 00 00 	nopl   0x0(%rax,%rax,1)
    b82f:	00 

000000000000b830 <fwp_trits>:
    b830:	55                   	push   %rbp
    b831:	41 57                	push   %r15
    b833:	41 56                	push   %r14
    b835:	53                   	push   %rbx
    b836:	50                   	push   %rax
    b837:	89 d5                	mov    %edx,%ebp
    b839:	49 89 f6             	mov    %rsi,%r14
    b83c:	48 89 fb             	mov    %rdi,%rbx
    b83f:	4c 63 fa             	movslq %edx,%r15
    b842:	49 8d 7f 03          	lea    0x3(%r15),%rdi
    b846:	e8 55 ac ff ff       	call   64a0 <fwp_alloc_leaf>
    b84b:	48 89 c6             	mov    %rax,%rsi
    b84e:	66 c7 00 30 74       	movw   $0x7430,(%rax)
    b853:	45 85 ff             	test   %r15d,%r15d
    b856:	0f 8e 9f 00 00 00    	jle    b8fb <fwp_trits+0xcb>
    b85c:	89 e9                	mov    %ebp,%ecx
    b85e:	48 8d 3c 31          	lea    (%rcx,%rsi,1),%rdi
    b862:	48 ff c7             	inc    %rdi
    b865:	48 f7 d9             	neg    %rcx
    b868:	45 31 c0             	xor    %r8d,%r8d
    b86b:	49 b9 56 55 55 55 55 	movabs $0x5555555555555556,%r9
    b872:	55 55 55 
    b875:	eb 35                	jmp    b8ac <fwp_trits+0x7c>
    b877:	66 0f 1f 84 00 00 00 	nopw   0x0(%rax,%rax,1)
    b87e:	00 00 
    b880:	41 b3 30             	mov    $0x30,%r11b
    b883:	46 88 1c 07          	mov    %r11b,(%rdi,%r8,1)
    b887:	48 85 d2             	test   %rdx,%rdx
    b88a:	0f 95 c2             	setne  %dl
    b88d:	4d 85 f6             	test   %r14,%r14
    b890:	41 0f 98 c3          	sets   %r11b
    b894:	41 20 d3             	and    %dl,%r11b
    b897:	41 0f b6 d3          	movzbl %r11b,%edx
    b89b:	48 29 d0             	sub    %rdx,%rax
    b89e:	4c 01 d0             	add    %r10,%rax
    b8a1:	49 ff c8             	dec    %r8
    b8a4:	49 89 c6             	mov    %rax,%r14
    b8a7:	4c 39 c1             	cmp    %r8,%rcx
    b8aa:	74 4f                	je     b8fb <fwp_trits+0xcb>
    b8ac:	4c 89 f0             	mov    %r14,%rax
    b8af:	49 f7 e9             	imul   %r9
    b8b2:	48 89 d0             	mov    %rdx,%rax
    b8b5:	48 c1 e8 3f          	shr    $0x3f,%rax
    b8b9:	48 01 d0             	add    %rdx,%rax
    b8bc:	4c 8d 14 40          	lea    (%rax,%rax,2),%r10
    b8c0:	4c 89 f2             	mov    %r14,%rdx
    b8c3:	4c 29 d2             	sub    %r10,%rdx
    b8c6:	49 f7 da             	neg    %r10
    b8c9:	4d 01 f2             	add    %r14,%r10
    b8cc:	49 83 c2 03          	add    $0x3,%r10
    b8d0:	48 83 fa fd          	cmp    $0xfffffffffffffffd,%rdx
    b8d4:	4c 0f 42 d2          	cmovb  %rdx,%r10
    b8d8:	4d 85 d2             	test   %r10,%r10
    b8db:	74 a3                	je     b880 <fwp_trits+0x50>
    b8dd:	49 83 fa 01          	cmp    $0x1,%r10
    b8e1:	75 0d                	jne    b8f0 <fwp_trits+0xc0>
    b8e3:	41 b3 2b             	mov    $0x2b,%r11b
    b8e6:	45 31 d2             	xor    %r10d,%r10d
    b8e9:	eb 98                	jmp    b883 <fwp_trits+0x53>
    b8eb:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)
    b8f0:	41 b3 2d             	mov    $0x2d,%r11b
    b8f3:	41 ba 01 00 00 00    	mov    $0x1,%r10d
    b8f9:	eb 88                	jmp    b883 <fwp_trits+0x53>
    b8fb:	42 c6 44 3e 02 00    	movb   $0x0,0x2(%rsi,%r15,1)
    b901:	48 89 df             	mov    %rbx,%rdi
    b904:	48 83 c4 08          	add    $0x8,%rsp
    b908:	5b                   	pop    %rbx
    b909:	41 5e                	pop    %r14
    b90b:	41 5f                	pop    %r15
    b90d:	5d                   	pop    %rbp
    b90e:	e9 ad bd ff ff       	jmp    76c0 <buf_puts>
    b913:	66 66 66 66 2e 0f 1f 	data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    b91a:	84 00 00 00 00 00 

000000000000b920 <fwp_escape>:
    b920:	55                   	push   %rbp
    b921:	41 57                	push   %r15
    b923:	41 56                	push   %r14
    b925:	41 55                	push   %r13
    b927:	41 54                	push   %r12
    b929:	53                   	push   %rbx
    b92a:	48 83 ec 18          	sub    $0x18,%rsp
    b92e:	48 89 d3             	mov    %rdx,%rbx
    b931:	49 89 f7             	mov    %rsi,%r15
    b934:	49 89 fe             	mov    %rdi,%r14
    b937:	be 22 00 00 00       	mov    $0x22,%esi
    b93c:	e8 5f bd ff ff       	call   76a0 <buf_putc>
    b941:	48 85 db             	test   %rbx,%rbx
    b944:	0f 84 c7 00 00 00    	je     ba11 <fwp_escape+0xf1>
    b94a:	48 89 e5             	mov    %rsp,%rbp
    b94d:	4c 8d 2d 58 1a 00 00 	lea    0x1a58(%rip),%r13        # d3ac <_IO_stdin_used+0x3ac>
    b954:	45 31 e4             	xor    %r12d,%r12d
    b957:	eb 28                	jmp    b981 <fwp_escape+0x61>
    b959:	4c 89 f7             	mov    %r14,%rdi
    b95c:	48 8d 35 05 2a 00 00 	lea    0x2a05(%rip),%rsi        # e368 <exec_in_fp0+0xd28>
    b963:	66 66 66 66 2e 0f 1f 	data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    b96a:	84 00 00 00 00 00 
    b970:	e8 4b bd ff ff       	call   76c0 <buf_puts>
    b975:	49 ff c4             	inc    %r12
    b978:	4c 39 e3             	cmp    %r12,%rbx
    b97b:	0f 84 90 00 00 00    	je     ba11 <fwp_escape+0xf1>
    b981:	43 0f b6 0c 27       	movzbl (%r15,%r12,1),%ecx
    b986:	8d 41 f7             	lea    -0x9(%rcx),%eax
    b989:	83 f8 19             	cmp    $0x19,%eax
    b98c:	77 22                	ja     b9b0 <fwp_escape+0x90>
    b98e:	49 63 44 85 00       	movslq 0x0(%r13,%rax,4),%rax
    b993:	4c 01 e8             	add    %r13,%rax
    b996:	ff e0                	jmp    *%rax
    b998:	4c 89 f7             	mov    %r14,%rdi
    b99b:	48 8d 35 c3 29 00 00 	lea    0x29c3(%rip),%rsi        # e365 <exec_in_fp0+0xd25>
    b9a2:	eb cc                	jmp    b970 <fwp_escape+0x50>
    b9a4:	66 66 66 2e 0f 1f 84 	data16 data16 cs nopw 0x0(%rax,%rax,1)
    b9ab:	00 00 00 00 00 
    b9b0:	83 f9 5c             	cmp    $0x5c,%ecx
    b9b3:	75 0c                	jne    b9c1 <fwp_escape+0xa1>
    b9b5:	4c 89 f7             	mov    %r14,%rdi
    b9b8:	48 8d 35 a0 29 00 00 	lea    0x29a0(%rip),%rsi        # e35f <exec_in_fp0+0xd1f>
    b9bf:	eb af                	jmp    b970 <fwp_escape+0x50>
    b9c1:	80 f9 20             	cmp    $0x20,%cl
    b9c4:	72 2a                	jb     b9f0 <fwp_escape+0xd0>
    b9c6:	80 f9 7f             	cmp    $0x7f,%cl
    b9c9:	74 25                	je     b9f0 <fwp_escape+0xd0>
    b9cb:	0f be f1             	movsbl %cl,%esi
    b9ce:	4c 89 f7             	mov    %r14,%rdi
    b9d1:	e8 ca bc ff ff       	call   76a0 <buf_putc>
    b9d6:	eb 9d                	jmp    b975 <fwp_escape+0x55>
    b9d8:	4c 89 f7             	mov    %r14,%rdi
    b9db:	48 8d 35 7a 29 00 00 	lea    0x297a(%rip),%rsi        # e35c <exec_in_fp0+0xd1c>
    b9e2:	eb 8c                	jmp    b970 <fwp_escape+0x50>
    b9e4:	4c 89 f7             	mov    %r14,%rdi
    b9e7:	48 8d 35 74 29 00 00 	lea    0x2974(%rip),%rsi        # e362 <exec_in_fp0+0xd22>
    b9ee:	eb 80                	jmp    b970 <fwp_escape+0x50>
    b9f0:	be 10 00 00 00       	mov    $0x10,%esi
    b9f5:	48 89 ef             	mov    %rbp,%rdi
    b9f8:	48 8d 15 6c 29 00 00 	lea    0x296c(%rip),%rdx        # e36b <exec_in_fp0+0xd2b>
    b9ff:	31 c0                	xor    %eax,%eax
    ba01:	e8 ca 67 ff ff       	call   21d0 <snprintf@plt>
    ba06:	4c 89 f7             	mov    %r14,%rdi
    ba09:	48 89 ee             	mov    %rbp,%rsi
    ba0c:	e9 5f ff ff ff       	jmp    b970 <fwp_escape+0x50>
    ba11:	4c 89 f7             	mov    %r14,%rdi
    ba14:	be 22 00 00 00       	mov    $0x22,%esi
    ba19:	48 83 c4 18          	add    $0x18,%rsp
    ba1d:	5b                   	pop    %rbx
    ba1e:	41 5c                	pop    %r12
    ba20:	41 5d                	pop    %r13
    ba22:	41 5e                	pop    %r14
    ba24:	41 5f                	pop    %r15
    ba26:	5d                   	pop    %rbp
    ba27:	e9 74 bc ff ff       	jmp    76a0 <buf_putc>
    ba2c:	0f 1f 40 00          	nopl   0x0(%rax)

000000000000ba30 <fwp_fmt_duration>:
    ba30:	41 57                	push   %r15
    ba32:	41 56                	push   %r14
    ba34:	41 54                	push   %r12
    ba36:	53                   	push   %rbx
    ba37:	48 83 ec 48          	sub    $0x48,%rsp
    ba3b:	49 89 d0             	mov    %rdx,%r8
    ba3e:	48 89 fb             	mov    %rdi,%rbx
    ba41:	48 89 f0             	mov    %rsi,%rax
    ba44:	48 09 d0             	or     %rdx,%rax
    ba47:	0f 84 1b 02 00 00    	je     bc68 <fwp_fmt_duration+0x238>
    ba4d:	48 b9 1d 3f c2 25 d6 	movabs $0xd2fe1d625c23f1d,%rcx
    ba54:	e1 2f 0d 
    ba57:	48 bf 0d b1 f3 e4 99 	movabs $0x1c52799e4f3b10d,%rdi
    ba5e:	27 c5 01 
    ba61:	48 89 f0             	mov    %rsi,%rax
    ba64:	48 f7 e7             	mul    %rdi
    ba67:	48 0f af ce          	imul   %rsi,%rcx
    ba6b:	48 01 ca             	add    %rcx,%rdx
    ba6e:	49 0f af f8          	imul   %r8,%rdi
    ba72:	48 01 d7             	add    %rdx,%rdi
    ba75:	48 b9 00 a0 34 52 a3 	movabs $0x6baf6aa35234a000,%rcx
    ba7c:	6a af 6b 
    ba7f:	48 01 c1             	add    %rax,%rcx
    ba82:	48 b8 37 f9 ff e2 04 	movabs $0x4e2fff937,%rax
    ba89:	00 00 00 
    ba8c:	48 11 f8             	adc    %rdi,%rax
    ba8f:	48 89 c2             	mov    %rax,%rdx
    ba92:	48 0f ac ca 0d       	shrd   $0xd,%rcx,%rdx
    ba97:	48 0f a4 c8 33       	shld   $0x33,%rcx,%rax
    ba9c:	48 b9 4b 23 35 aa f6 	movabs $0x9376baf6aa35234b,%rcx
    baa3:	ba 76 93 
    baa6:	48 39 c8             	cmp    %rcx,%rax
    baa9:	48 81 da ff 2f 4e 00 	sbb    $0x4e2fff,%rdx
    bab0:	0f 82 d9 01 00 00    	jb     bc8f <fwp_fmt_duration+0x25f>
    bab6:	48 b9 b3 b2 61 36 8c 	movabs $0xc5ce3b8c3661b2b3,%rcx
    babd:	3b ce c5 
    bac0:	48 bf c3 5f 47 6a 04 	movabs $0x1a8d52046a475fc3,%rdi
    bac7:	52 8d 1a 
    baca:	48 89 f0             	mov    %rsi,%rax
    bacd:	48 f7 e7             	mul    %rdi
    bad0:	48 0f af ce          	imul   %rsi,%rcx
    bad4:	48 01 ca             	add    %rcx,%rdx
    bad7:	49 0f af f8          	imul   %r8,%rdi
    badb:	48 01 d7             	add    %rdx,%rdi
    bade:	48 b9 00 a8 16 d1 91 	movabs $0x4f473f91d116a800,%rcx
    bae5:	3f 47 4f 
    bae8:	48 01 c1             	add    %rax,%rcx
    baeb:	48 b8 3f 9a ff 4c 49 	movabs $0x494cff9a3f,%rax
    baf2:	00 00 00 
    baf5:	48 11 f8             	adc    %rdi,%rax
    baf8:	48 89 c2             	mov    %rax,%rdx
    bafb:	48 0f ac ca 0b       	shrd   $0xb,%rcx,%rdx
    bb00:	48 0f a4 c8 35       	shld   $0x35,%rcx,%rax
    bb05:	48 b9 ab 45 74 e4 cf 	movabs $0x8fd3d1cfe47445ab,%rcx
    bb0c:	d1 d3 8f 
    bb0f:	48 39 c8             	cmp    %rcx,%rax
    bb12:	48 81 da e6 3f 53 12 	sbb    $0x12533fe6,%rdx
    bb19:	0f 82 7f 01 00 00    	jb     bc9e <fwp_fmt_duration+0x26e>
    bb1f:	48 b9 7e 78 b9 2f 37 	movabs $0x97157d372fb9787e,%rcx
    bb26:	7d 15 97 
    bb29:	48 0f af ce          	imul   %rsi,%rcx
    bb2d:	48 bf 6d 9c 2e 3a 42 	movabs $0x8e47ce423a2e9c6d,%rdi
    bb34:	ce 47 8e 
    bb37:	48 89 f0             	mov    %rsi,%rax
    bb3a:	48 f7 e7             	mul    %rdi
    bb3d:	48 01 ca             	add    %rcx,%rdx
    bb40:	49 0f af f8          	imul   %r8,%rdi
    bb44:	48 01 d7             	add    %rdx,%rdi
    bb47:	48 b9 00 46 54 40 8b 	movabs $0xa52cb98b40544600,%rcx
    bb4e:	b9 2c a5 
    bb51:	48 01 c1             	add    %rax,%rcx
    bb54:	48 b8 b5 09 fa 82 4b 	movabs $0x44b82fa09b5,%rax
    bb5b:	04 00 00 
    bb5e:	48 11 f8             	adc    %rdi,%rax
    bb61:	48 89 c2             	mov    %rax,%rdx
    bb64:	48 0f ac ca 09       	shrd   $0x9,%rcx,%rdx
    bb69:	48 0f a4 c8 37       	shld   $0x37,%rcx,%rax
    bb6e:	48 b9 47 54 40 8b b9 	movabs $0xb5a52cb98b405447,%rcx
    bb75:	2c a5 b5 
    bb78:	48 39 c8             	cmp    %rcx,%rax
    bb7b:	48 b8 09 fa 82 4b 04 	movabs $0x44b82fa09,%rax
    bb82:	00 00 00 
    bb85:	48 19 c2             	sbb    %rax,%rdx
    bb88:	0f 82 22 01 00 00    	jb     bcb0 <fwp_fmt_duration+0x280>
    bb8e:	48 b9 cb d5 8f 4d f2 	movabs $0xc57e23f24d8fd5cb,%rcx
    bb95:	23 7e c5 
    bb98:	48 0f af ce          	imul   %rsi,%rcx
    bb9c:	48 bf 39 61 c2 68 56 	movabs $0x790fb65668c26139,%rdi
    bba3:	b6 0f 79 
    bba6:	48 89 f0             	mov    %rsi,%rax
    bba9:	48 f7 e7             	mul    %rdi
    bbac:	48 01 ca             	add    %rcx,%rdx
    bbaf:	49 0f af f8          	imul   %r8,%rdi
    bbb3:	48 01 d7             	add    %rdx,%rdi
    bbb6:	48 b9 00 0b 27 69 fe 	movabs $0xa6d698fe69270b00,%rcx
    bbbd:	98 d6 a6 
    bbc0:	48 01 c1             	add    %rax,%rcx
    bbc3:	48 b8 b1 bd 16 f4 de 	movabs $0x218def416bdb1,%rax
    bbca:	18 02 00 
    bbcd:	48 11 f8             	adc    %rdi,%rax
    bbd0:	48 89 c2             	mov    %rax,%rdx
    bbd3:	48 0f ac ca 06       	shrd   $0x6,%rcx,%rdx
    bbd8:	48 0f a4 c8 3a       	shld   $0x3a,%rcx,%rax
    bbdd:	48 b9 59 38 49 f3 c7 	movabs $0x8d36b4c7f3493859,%rcx
    bbe4:	b4 36 8d 
    bbe7:	48 39 c8             	cmp    %rcx,%rax
    bbea:	48 b8 ed b5 a0 f7 c6 	movabs $0x10c6f7a0b5ed,%rax
    bbf1:	10 00 00 
    bbf4:	48 19 c2             	sbb    %rax,%rdx
    bbf7:	0f 82 c0 00 00 00    	jb     bcbd <fwp_fmt_duration+0x28d>
    bbfd:	48 b9 5a 64 3b df 4f 	movabs $0x6e978d4fdf3b645a,%rcx
    bc04:	8d 97 6e 
    bc07:	48 0f af ce          	imul   %rsi,%rcx
    bc0b:	48 bf d5 78 e9 26 31 	movabs $0x1cac083126e978d5,%rdi
    bc12:	08 ac 1c 
    bc15:	48 89 f0             	mov    %rsi,%rax
    bc18:	48 f7 e7             	mul    %rdi
    bc1b:	48 01 ca             	add    %rcx,%rdx
    bc1e:	49 0f af f8          	imul   %r8,%rdi
    bc22:	48 01 d7             	add    %rdx,%rdi
    bc25:	48 b9 48 62 10 58 39 	movabs $0x76c8b43958106248,%rcx
    bc2c:	b4 c8 76 
    bc2f:	48 01 c1             	add    %rax,%rcx
    bc32:	48 b8 be 9f 1a 2f dd 	movabs $0x10624dd2f1a9fbe,%rax
    bc39:	24 06 01 
    bc3c:	48 11 f8             	adc    %rdi,%rax
    bc3f:	48 89 c2             	mov    %rax,%rdx
    bc42:	48 0f ac ca 03       	shrd   $0x3,%rcx,%rdx
    bc47:	48 0f a4 c8 3d       	shld   $0x3d,%rcx,%rax
    bc4c:	48 b9 93 18 04 56 0e 	movabs $0x9db22d0e56041893,%rcx
    bc53:	2d b2 9d 
    bc56:	48 39 c8             	cmp    %rcx,%rax
    bc59:	48 b8 ef a7 c6 4b 37 	movabs $0x4189374bc6a7ef,%rax
    bc60:	89 41 00 
    bc63:	48 19 c2             	sbb    %rax,%rdx
    bc66:	72 62                	jb     bcca <fwp_fmt_duration+0x29a>
    bc68:	49 89 e6             	mov    %rsp,%r14
    bc6b:	4c 89 f7             	mov    %r14,%rdi
    bc6e:	4c 89 c2             	mov    %r8,%rdx
    bc71:	e8 ca f6 ff ff       	call   b340 <fwp_fmt_i128>
    bc76:	48 8d 35 fa 26 00 00 	lea    0x26fa(%rip),%rsi        # e377 <exec_in_fp0+0xd37>
    bc7d:	48 89 df             	mov    %rbx,%rdi
    bc80:	4c 89 f2             	mov    %r14,%rdx
    bc83:	31 c0                	xor    %eax,%eax
    bc85:	e8 e6 67 ff ff       	call   2470 <sprintf@plt>
    bc8a:	e9 84 00 00 00       	jmp    bd13 <fwp_fmt_duration+0x2e3>
    bc8f:	48 ba 00 a0 b8 30 46 	movabs $0x34630b8a000,%rdx
    bc96:	03 00 00 
    bc99:	45 31 ff             	xor    %r15d,%r15d
    bc9c:	eb 37                	jmp    bcd5 <fwp_fmt_duration+0x2a5>
    bc9e:	48 ba 00 58 47 f8 0d 	movabs $0xdf8475800,%rdx
    bca5:	00 00 00 
    bca8:	41 bf 01 00 00 00    	mov    $0x1,%r15d
    bcae:	eb 25                	jmp    bcd5 <fwp_fmt_duration+0x2a5>
    bcb0:	ba 00 ca 9a 3b       	mov    $0x3b9aca00,%edx
    bcb5:	41 bf 02 00 00 00    	mov    $0x2,%r15d
    bcbb:	eb 18                	jmp    bcd5 <fwp_fmt_duration+0x2a5>
    bcbd:	ba 40 42 0f 00       	mov    $0xf4240,%edx
    bcc2:	41 bf 03 00 00 00    	mov    $0x3,%r15d
    bcc8:	eb 0b                	jmp    bcd5 <fwp_fmt_duration+0x2a5>
    bcca:	ba e8 03 00 00       	mov    $0x3e8,%edx
    bccf:	41 bf 04 00 00 00    	mov    $0x4,%r15d
    bcd5:	31 c9                	xor    %ecx,%ecx
    bcd7:	41 c1 e7 04          	shl    $0x4,%r15d
    bcdb:	4c 8d 25 7e 70 00 00 	lea    0x707e(%rip),%r12        # 12d60 <fwp_fmt_duration.units>
    bce2:	48 89 f7             	mov    %rsi,%rdi
    bce5:	4c 89 c6             	mov    %r8,%rsi
    bce8:	e8 e3 0d 00 00       	call   cad0 <__divti3>
    bced:	49 89 e6             	mov    %rsp,%r14
    bcf0:	4c 89 f7             	mov    %r14,%rdi
    bcf3:	48 89 c6             	mov    %rax,%rsi
    bcf6:	e8 45 f6 ff ff       	call   b340 <fwp_fmt_i128>
    bcfb:	4b 8b 0c 27          	mov    (%r15,%r12,1),%rcx
    bcff:	48 8d 35 6c 26 00 00 	lea    0x266c(%rip),%rsi        # e372 <exec_in_fp0+0xd32>
    bd06:	48 89 df             	mov    %rbx,%rdi
    bd09:	4c 89 f2             	mov    %r14,%rdx
    bd0c:	31 c0                	xor    %eax,%eax
    bd0e:	e8 5d 67 ff ff       	call   2470 <sprintf@plt>
    bd13:	48 83 c4 48          	add    $0x48,%rsp
    bd17:	5b                   	pop    %rbx
    bd18:	41 5c                	pop    %r12
    bd1a:	41 5e                	pop    %r14
    bd1c:	41 5f                	pop    %r15
    bd1e:	c3                   	ret
    bd1f:	90                   	nop

000000000000bd20 <fwp_needs_parens>:
    bd20:	8b 06                	mov    (%rsi),%eax
    bd22:	83 f8 10             	cmp    $0x10,%eax
    bd25:	74 16                	je     bd3d <fwp_needs_parens+0x1d>
    bd27:	83 f8 0e             	cmp    $0xe,%eax
    bd2a:	0f 85 30 02 00 00    	jne    bf60 <fwp_is_negative>
    bd30:	31 c0                	xor    %eax,%eax
    bd32:	48 81 ff 00 10 00 00 	cmp    $0x1000,%rdi
    bd39:	0f 93 c0             	setae  %al
    bd3c:	c3                   	ret
    bd3d:	48 8b 46 08          	mov    0x8(%rsi),%rax
    bd41:	48 85 c0             	test   %rax,%rax
    bd44:	0f 84 16 02 00 00    	je     bf60 <fwp_is_negative>
    bd4a:	50                   	push   %rax
    bd4b:	48 8d 35 18 25 00 00 	lea    0x2518(%rip),%rsi        # e26a <exec_in_fp0+0xc2a>
    bd52:	48 89 c7             	mov    %rax,%rdi
    bd55:	e8 76 65 ff ff       	call   22d0 <strcmp@plt>
    bd5a:	89 c1                	mov    %eax,%ecx
    bd5c:	31 c0                	xor    %eax,%eax
    bd5e:	85 c9                	test   %ecx,%ecx
    bd60:	0f 95 c0             	setne  %al
    bd63:	48 83 c4 08          	add    $0x8,%rsp
    bd67:	c3                   	ret
    bd68:	0f 1f 84 00 00 00 00 	nopl   0x0(%rax,%rax,1)
    bd6f:	00 

000000000000bd70 <fwp_format_g>:
    bd70:	55                   	push   %rbp
    bd71:	41 57                	push   %r15
    bd73:	41 56                	push   %r14
    bd75:	41 55                	push   %r13
    bd77:	41 54                	push   %r12
    bd79:	53                   	push   %rbx
    bd7a:	48 81 ec 98 00 00 00 	sub    $0x98,%rsp
    bd81:	89 f5                	mov    %esi,%ebp
    bd83:	48 89 fb             	mov    %rdi,%rbx
    bd86:	ff cd                	dec    %ebp
    bd88:	48 8d 15 b6 25 00 00 	lea    0x25b6(%rip),%rdx        # e345 <exec_in_fp0+0xd05>
    bd8f:	4c 8d 64 24 50       	lea    0x50(%rsp),%r12
    bd94:	be 40 00 00 00       	mov    $0x40,%esi
    bd99:	4c 89 e7             	mov    %r12,%rdi
    bd9c:	89 e9                	mov    %ebp,%ecx
    bd9e:	f2 0f 11 44 24 08    	movsd  %xmm0,0x8(%rsp)
    bda4:	b0 01                	mov    $0x1,%al
    bda6:	e8 25 64 ff ff       	call   21d0 <snprintf@plt>
    bdab:	4c 89 e7             	mov    %r12,%rdi
    bdae:	be 65 00 00 00       	mov    $0x65,%esi
    bdb3:	e8 f8 63 ff ff       	call   21b0 <strchr@plt>
    bdb8:	49 89 c7             	mov    %rax,%r15
    bdbb:	48 8d 78 01          	lea    0x1(%rax),%rdi
    bdbf:	e8 9c 66 ff ff       	call   2460 <atoi@plt>
    bdc4:	41 89 c6             	mov    %eax,%r14d
    bdc7:	41 8d 46 ef          	lea    -0x11(%r14),%eax
    bdcb:	83 f8 e9             	cmp    $0xffffffe9,%eax
    bdce:	77 58                	ja     be28 <fwp_format_g+0xb8>
    bdd0:	4d 29 e7             	sub    %r12,%r15
    bdd3:	4c 8d 6c 24 10       	lea    0x10(%rsp),%r13
    bdd8:	4c 89 ef             	mov    %r13,%rdi
    bddb:	4c 89 e6             	mov    %r12,%rsi
    bdde:	4c 89 fa             	mov    %r15,%rdx
    bde1:	e8 4a 65 ff ff       	call   2330 <memcpy@plt>
    bde6:	42 c6 44 3c 10 00    	movb   $0x0,0x10(%rsp,%r15,1)
    bdec:	4c 89 ef             	mov    %r13,%rdi
    bdef:	be 2e 00 00 00       	mov    $0x2e,%esi
    bdf4:	e8 b7 63 ff ff       	call   21b0 <strchr@plt>
    bdf9:	48 85 c0             	test   %rax,%rax
    bdfc:	0f 84 91 00 00 00    	je     be93 <fwp_format_g+0x123>
    be02:	4d 85 ff             	test   %r15,%r15
    be05:	0f 84 88 00 00 00    	je     be93 <fwp_format_g+0x123>
    be0b:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)
    be10:	42 0f b6 44 3c 0f    	movzbl 0xf(%rsp,%r15,1),%eax
    be16:	83 f8 30             	cmp    $0x30,%eax
    be19:	75 6d                	jne    be88 <fwp_format_g+0x118>
    be1b:	42 c6 44 3c 0f 00    	movb   $0x0,0xf(%rsp,%r15,1)
    be21:	49 ff cf             	dec    %r15
    be24:	75 ea                	jne    be10 <fwp_format_g+0xa0>
    be26:	eb 6b                	jmp    be93 <fwp_format_g+0x123>
    be28:	44 29 f5             	sub    %r14d,%ebp
    be2b:	31 c9                	xor    %ecx,%ecx
    be2d:	85 ed                	test   %ebp,%ebp
    be2f:	0f 4f cd             	cmovg  %ebp,%ecx
    be32:	48 8d 15 1b 25 00 00 	lea    0x251b(%rip),%rdx        # e354 <exec_in_fp0+0xd14>
    be39:	be 90 01 00 00       	mov    $0x190,%esi
    be3e:	48 89 df             	mov    %rbx,%rdi
    be41:	f2 0f 10 44 24 08    	movsd  0x8(%rsp),%xmm0
    be47:	b0 01                	mov    $0x1,%al
    be49:	e8 82 63 ff ff       	call   21d0 <snprintf@plt>
    be4e:	48 89 df             	mov    %rbx,%rdi
    be51:	e8 1a 63 ff ff       	call   2170 <strlen@plt>
    be56:	49 89 c6             	mov    %rax,%r14
    be59:	48 89 df             	mov    %rbx,%rdi
    be5c:	be 2e 00 00 00       	mov    $0x2e,%esi
    be61:	e8 4a 63 ff ff       	call   21b0 <strchr@plt>
    be66:	48 85 c0             	test   %rax,%rax
    be69:	74 5b                	je     bec6 <fwp_format_g+0x156>
    be6b:	4d 85 f6             	test   %r14,%r14
    be6e:	74 56                	je     bec6 <fwp_format_g+0x156>
    be70:	42 0f b6 44 33 ff    	movzbl -0x1(%rbx,%r14,1),%eax
    be76:	83 f8 30             	cmp    $0x30,%eax
    be79:	75 5d                	jne    bed8 <fwp_format_g+0x168>
    be7b:	42 c6 44 33 ff 00    	movb   $0x0,-0x1(%rbx,%r14,1)
    be81:	49 ff ce             	dec    %r14
    be84:	75 ea                	jne    be70 <fwp_format_g+0x100>
    be86:	eb 3e                	jmp    bec6 <fwp_format_g+0x156>
    be88:	83 f8 2e             	cmp    $0x2e,%eax
    be8b:	75 06                	jne    be93 <fwp_format_g+0x123>
    be8d:	42 c6 44 3c 0f 00    	movb   $0x0,0xf(%rsp,%r15,1)
    be93:	44 89 f0             	mov    %r14d,%eax
    be96:	c1 e8 1f             	shr    $0x1f,%eax
    be99:	44 8d 04 45 2b 00 00 	lea    0x2b(,%rax,2),%r8d
    bea0:	00 
    bea1:	45 89 f1             	mov    %r14d,%r9d
    bea4:	41 f7 d9             	neg    %r9d
    bea7:	45 0f 48 ce          	cmovs  %r14d,%r9d
    beab:	48 8d 15 98 24 00 00 	lea    0x2498(%rip),%rdx        # e34a <exec_in_fp0+0xd0a>
    beb2:	48 8d 4c 24 10       	lea    0x10(%rsp),%rcx
    beb7:	be 90 01 00 00       	mov    $0x190,%esi
    bebc:	48 89 df             	mov    %rbx,%rdi
    bebf:	31 c0                	xor    %eax,%eax
    bec1:	e8 0a 63 ff ff       	call   21d0 <snprintf@plt>
    bec6:	48 81 c4 98 00 00 00 	add    $0x98,%rsp
    becd:	5b                   	pop    %rbx
    bece:	41 5c                	pop    %r12
    bed0:	41 5d                	pop    %r13
    bed2:	41 5e                	pop    %r14
    bed4:	41 5f                	pop    %r15
    bed6:	5d                   	pop    %rbp
    bed7:	c3                   	ret
    bed8:	83 f8 2e             	cmp    $0x2e,%eax
    bedb:	75 e9                	jne    bec6 <fwp_format_g+0x156>
    bedd:	42 c6 44 33 ff 00    	movb   $0x0,-0x1(%rbx,%r14,1)
    bee3:	eb e1                	jmp    bec6 <fwp_format_g+0x156>
    bee5:	66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
    beec:	00 00 00 00 

000000000000bef0 <fwp_finish_float>:
    bef0:	53                   	push   %rbx
    bef1:	48 89 fb             	mov    %rdi,%rbx
    bef4:	be 2e 00 00 00       	mov    $0x2e,%esi
    bef9:	e8 b2 62 ff ff       	call   21b0 <strchr@plt>
    befe:	48 85 c0             	test   %rax,%rax
    bf01:	74 02                	je     bf05 <fwp_finish_float+0x15>
    bf03:	5b                   	pop    %rbx
    bf04:	c3                   	ret
    bf05:	48 89 df             	mov    %rbx,%rdi
    bf08:	be 65 00 00 00       	mov    $0x65,%esi
    bf0d:	e8 9e 62 ff ff       	call   21b0 <strchr@plt>
    bf12:	48 85 c0             	test   %rax,%rax
    bf15:	75 ec                	jne    bf03 <fwp_finish_float+0x13>
    bf17:	48 8d 35 67 23 00 00 	lea    0x2367(%rip),%rsi        # e285 <exec_in_fp0+0xc45>
    bf1e:	48 89 df             	mov    %rbx,%rdi
    bf21:	e8 ca 65 ff ff       	call   24f0 <strstr@plt>
    bf26:	48 85 c0             	test   %rax,%rax
    bf29:	75 d8                	jne    bf03 <fwp_finish_float+0x13>
    bf2b:	48 8d 35 57 23 00 00 	lea    0x2357(%rip),%rsi        # e289 <exec_in_fp0+0xc49>
    bf32:	48 89 df             	mov    %rbx,%rdi
    bf35:	e8 b6 65 ff ff       	call   24f0 <strstr@plt>
    bf3a:	48 85 c0             	test   %rax,%rax
    bf3d:	75 c4                	jne    bf03 <fwp_finish_float+0x13>
    bf3f:	48 89 df             	mov    %rbx,%rdi
    bf42:	e8 29 62 ff ff       	call   2170 <strlen@plt>
    bf47:	66 c7 04 03 2e 30    	movw   $0x302e,(%rbx,%rax,1)
    bf4d:	c6 44 03 02 00       	movb   $0x0,0x2(%rbx,%rax,1)
    bf52:	5b                   	pop    %rbx
    bf53:	c3                   	ret
    bf54:	66 66 66 2e 0f 1f 84 	data16 data16 cs nopw 0x0(%rax,%rax,1)
    bf5b:	00 00 00 00 00 

000000000000bf60 <fwp_is_negative>:
    bf60:	50                   	push   %rax
    bf61:	8b 0e                	mov    (%rsi),%ecx
    bf63:	31 c0                	xor    %eax,%eax
    bf65:	48 83 f9 0b          	cmp    $0xb,%rcx
    bf69:	77 16                	ja     bf81 <fwp_is_negative+0x21>
    bf6b:	48 8d 15 a2 14 00 00 	lea    0x14a2(%rip),%rdx        # d414 <_IO_stdin_used+0x414>
    bf72:	48 63 0c 8a          	movslq (%rdx,%rcx,4),%rcx
    bf76:	48 01 d1             	add    %rdx,%rcx
    bf79:	ff e1                	jmp    *%rcx
    bf7b:	48 c1 ef 3f          	shr    $0x3f,%rdi
    bf7f:	89 f8                	mov    %edi,%eax
    bf81:	59                   	pop    %rcx
    bf82:	c3                   	ret
    bf83:	e8 08 de ff ff       	call   9d90 <fwp_f32>
    bf88:	0f 50 c0             	movmskps %xmm0,%eax
    bf8b:	eb 09                	jmp    bf96 <fwp_is_negative+0x36>
    bf8d:	e8 1e 99 ff ff       	call   58b0 <fwp_f64>
    bf92:	66 0f 50 c0          	movmskpd %xmm0,%eax
    bf96:	83 e0 01             	and    $0x1,%eax
    bf99:	59                   	pop    %rcx
    bf9a:	c3                   	ret
    bf9b:	e8 c0 dd ff ff       	call   9d60 <fwp_i128>
    bfa0:	48 89 d0             	mov    %rdx,%rax
    bfa3:	48 c1 e8 3f          	shr    $0x3f,%rax
    bfa7:	59                   	pop    %rcx
    bfa8:	c3                   	ret
    bfa9:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)

000000000000bfb0 <fwp_emit>:
    bfb0:	53                   	push   %rbx
    bfb1:	48 83 ec 30          	sub    $0x30,%rsp
    bfb5:	48 89 f8             	mov    %rdi,%rax
    bfb8:	83 3d 01 8e 01 00 00 	cmpl   $0x0,0x18e01(%rip)        # 24dc0 <fwp_exec_binary_out>
    bfbf:	74 66                	je     c027 <fwp_emit+0x77>
    bfc1:	0f 57 c0             	xorps  %xmm0,%xmm0
    bfc4:	0f 29 44 24 10       	movaps %xmm0,0x10(%rsp)
    bfc9:	48 c7 44 24 20 00 00 	movq   $0x0,0x20(%rsp)
    bfd0:	00 00 
    bfd2:	48 8d 15 f7 8c 00 00 	lea    0x8cf7(%rip),%rdx        # 14cd0 <d0>
    bfd9:	48 8d 7c 24 10       	lea    0x10(%rsp),%rdi
    bfde:	48 89 c6             	mov    %rax,%rsi
    bfe1:	e8 9a 00 00 00       	call   c080 <fwp_encode>
    bfe6:	c6 44 24 0b 01       	movb   $0x1,0xb(%rsp)
    bfeb:	8b 44 24 18          	mov    0x18(%rsp),%eax
    bfef:	89 44 24 0c          	mov    %eax,0xc(%rsp)
    bff3:	48 8d 7c 24 0b       	lea    0xb(%rsp),%rdi
    bff8:	be 05 00 00 00       	mov    $0x5,%esi
    bffd:	e8 1e a8 ff ff       	call   6820 <fwp_pipe_write>
    c002:	48 8b 74 24 18       	mov    0x18(%rsp),%rsi
    c007:	48 85 f6             	test   %rsi,%rsi
    c00a:	74 0a                	je     c016 <fwp_emit+0x66>
    c00c:	48 8b 7c 24 10       	mov    0x10(%rsp),%rdi
    c011:	e8 0a a8 ff ff       	call   6820 <fwp_pipe_write>
    c016:	48 8b 7c 24 10       	mov    0x10(%rsp),%rdi
    c01b:	e8 30 60 ff ff       	call   2050 <free@plt>
    c020:	e8 9b 02 00 00       	call   c2c0 <fwp_pipe_frame_done>
    c025:	eb 1c                	jmp    c043 <fwp_emit+0x93>
    c027:	83 3d a2 8c 00 00 10 	cmpl   $0x10,0x8ca2(%rip)        # 14cd0 <d0>
    c02e:	75 19                	jne    c049 <fwp_emit+0x99>
    c030:	83 3d a9 8c 00 00 00 	cmpl   $0x0,0x8ca9(%rip)        # 14ce0 <d0+0x10>
    c037:	75 10                	jne    c049 <fwp_emit+0x99>
    c039:	48 83 3d 97 8c 00 00 	cmpq   $0x0,0x8c97(%rip)        # 14cd8 <d0+0x8>
    c040:	00 
    c041:	75 06                	jne    c049 <fwp_emit+0x99>
    c043:	48 83 c4 30          	add    $0x30,%rsp
    c047:	5b                   	pop    %rbx
    c048:	c3                   	ret
    c049:	48 8b 1d 60 6f 00 00 	mov    0x6f60(%rip),%rbx        # 12fb0 <stdout@GLIBC_2.2.5>
    c050:	48 8b 13             	mov    (%rbx),%rdx
    c053:	48 8d 35 76 8c 00 00 	lea    0x8c76(%rip),%rsi        # 14cd0 <d0>
    c05a:	48 89 c7             	mov    %rax,%rdi
    c05d:	e8 6e eb ff ff       	call   abd0 <fwp_display_top>
    c062:	48 8b 33             	mov    (%rbx),%rsi
    c065:	bf 0a 00 00 00       	mov    $0xa,%edi
    c06a:	48 83 c4 30          	add    $0x30,%rsp
    c06e:	5b                   	pop    %rbx
    c06f:	e9 cc 61 ff ff       	jmp    2240 <fputc@plt>
    c074:	66 66 66 2e 0f 1f 84 	data16 data16 cs nopw 0x0(%rax,%rax,1)
    c07b:	00 00 00 00 00 

000000000000c080 <fwp_encode>:
    c080:	41 57                	push   %r15
    c082:	41 56                	push   %r14
    c084:	41 55                	push   %r13
    c086:	41 54                	push   %r12
    c088:	53                   	push   %rbx
    c089:	8b 02                	mov    (%rdx),%eax
    c08b:	48 83 f8 15          	cmp    $0x15,%rax
    c08f:	0f 87 14 02 00 00    	ja     c2a9 <fwp_encode+0x229>
    c095:	49 89 d7             	mov    %rdx,%r15
    c098:	49 89 f6             	mov    %rsi,%r14
    c09b:	48 89 fb             	mov    %rdi,%rbx
    c09e:	48 8d 0d 9f 13 00 00 	lea    0x139f(%rip),%rcx        # d444 <_IO_stdin_used+0x444>
    c0a5:	48 63 04 81          	movslq (%rcx,%rax,4),%rax
    c0a9:	48 01 c8             	add    %rcx,%rax
    c0ac:	ff e0                	jmp    *%rax
    c0ae:	48 89 df             	mov    %rbx,%rdi
    c0b1:	4c 89 f6             	mov    %r14,%rsi
    c0b4:	ba 01 00 00 00       	mov    $0x1,%edx
    c0b9:	e9 77 01 00 00       	jmp    c235 <fwp_encode+0x1b5>
    c0be:	48 89 df             	mov    %rbx,%rdi
    c0c1:	4c 89 f6             	mov    %r14,%rsi
    c0c4:	ba 04 00 00 00       	mov    $0x4,%edx
    c0c9:	e9 67 01 00 00       	jmp    c235 <fwp_encode+0x1b5>
    c0ce:	49 8b 36             	mov    (%r14),%rsi
    c0d1:	48 89 df             	mov    %rbx,%rdi
    c0d4:	e8 57 02 00 00       	call   c330 <fwp_leb128>
    c0d9:	49 8b 16             	mov    (%r14),%rdx
    c0dc:	49 83 c6 08          	add    $0x8,%r14
    c0e0:	48 89 df             	mov    %rbx,%rdi
    c0e3:	4c 89 f6             	mov    %r14,%rsi
    c0e6:	5b                   	pop    %rbx
    c0e7:	41 5c                	pop    %r12
    c0e9:	41 5d                	pop    %r13
    c0eb:	41 5e                	pop    %r14
    c0ed:	41 5f                	pop    %r15
    c0ef:	e9 fc b5 ff ff       	jmp    76f0 <buf_put>
    c0f4:	48 89 df             	mov    %rbx,%rdi
    c0f7:	4c 89 f6             	mov    %r14,%rsi
    c0fa:	ba 02 00 00 00       	mov    $0x2,%edx
    c0ff:	e9 31 01 00 00       	jmp    c235 <fwp_encode+0x1b5>
    c104:	49 8b 36             	mov    (%r14),%rsi
    c107:	48 89 df             	mov    %rbx,%rdi
    c10a:	e8 21 02 00 00       	call   c330 <fwp_leb128>
    c10f:	49 83 3e 00          	cmpq   $0x0,(%r14)
    c113:	0f 84 90 01 00 00    	je     c2a9 <fwp_encode+0x229>
    c119:	4d 8d 66 10          	lea    0x10(%r14),%r12
    c11d:	45 31 ed             	xor    %r13d,%r13d
    c120:	eb 1e                	jmp    c140 <fwp_encode+0xc0>
    c122:	66 66 66 66 66 2e 0f 	data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    c129:	1f 84 00 00 00 00 00 
    c130:	49 ff c5             	inc    %r13
    c133:	49 83 c4 10          	add    $0x10,%r12
    c137:	4d 3b 2e             	cmp    (%r14),%r13
    c13a:	0f 83 69 01 00 00    	jae    c2a9 <fwp_encode+0x229>
    c140:	49 8b 74 24 f8       	mov    -0x8(%r12),%rsi
    c145:	49 8b 57 38          	mov    0x38(%r15),%rdx
    c149:	48 89 df             	mov    %rbx,%rdi
    c14c:	e8 2f ff ff ff       	call   c080 <fwp_encode>
    c151:	41 83 3f 12          	cmpl   $0x12,(%r15)
    c155:	75 d9                	jne    c130 <fwp_encode+0xb0>
    c157:	49 8b 34 24          	mov    (%r12),%rsi
    c15b:	49 8b 57 40          	mov    0x40(%r15),%rdx
    c15f:	48 89 df             	mov    %rbx,%rdi
    c162:	e8 19 ff ff ff       	call   c080 <fwp_encode>
    c167:	eb c7                	jmp    c130 <fwp_encode+0xb0>
    c169:	4c 89 f7             	mov    %r14,%rdi
    c16c:	e8 4f dc ff ff       	call   9dc0 <fwp_tag>
    c171:	41 89 c4             	mov    %eax,%r12d
    c174:	48 89 df             	mov    %rbx,%rdi
    c177:	4c 89 e6             	mov    %r12,%rsi
    c17a:	e8 b1 01 00 00       	call   c330 <fwp_leb128>
    c17f:	49 8b 47 28          	mov    0x28(%r15),%rax
    c183:	42 83 3c a0 00       	cmpl   $0x0,(%rax,%r12,4)
    c188:	0f 8e 1b 01 00 00    	jle    c2a9 <fwp_encode+0x229>
    c18e:	45 31 ed             	xor    %r13d,%r13d
    c191:	66 66 66 66 66 66 2e 	data16 data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    c198:	0f 1f 84 00 00 00 00 
    c19f:	00 
    c1a0:	4b 8b 74 ee 08       	mov    0x8(%r14,%r13,8),%rsi
    c1a5:	49 8b 47 30          	mov    0x30(%r15),%rax
    c1a9:	4a 8b 04 e0          	mov    (%rax,%r12,8),%rax
    c1ad:	4a 8b 14 e8          	mov    (%rax,%r13,8),%rdx
    c1b1:	48 89 df             	mov    %rbx,%rdi
    c1b4:	e8 c7 fe ff ff       	call   c080 <fwp_encode>
    c1b9:	49 ff c5             	inc    %r13
    c1bc:	49 8b 47 28          	mov    0x28(%r15),%rax
    c1c0:	4a 63 04 a0          	movslq (%rax,%r12,4),%rax
    c1c4:	49 39 c5             	cmp    %rax,%r13
    c1c7:	7c d7                	jl     c1a0 <fwp_encode+0x120>
    c1c9:	e9 db 00 00 00       	jmp    c2a9 <fwp_encode+0x229>
    c1ce:	4c 89 f7             	mov    %r14,%rdi
    c1d1:	e8 8a db ff ff       	call   9d60 <fwp_i128>
    c1d6:	eb 3f                	jmp    c217 <fwp_encode+0x197>
    c1d8:	4c 89 f7             	mov    %r14,%rdi
    c1db:	e8 70 d6 ff ff       	call   9850 <fwp_list_len>
    c1e0:	48 89 df             	mov    %rbx,%rdi
    c1e3:	48 89 c6             	mov    %rax,%rsi
    c1e6:	e8 45 01 00 00       	call   c330 <fwp_leb128>
    c1eb:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)
    c1f0:	4d 85 f6             	test   %r14,%r14
    c1f3:	0f 84 b0 00 00 00    	je     c2a9 <fwp_encode+0x229>
    c1f9:	49 8b 76 08          	mov    0x8(%r14),%rsi
    c1fd:	49 8b 57 38          	mov    0x38(%r15),%rdx
    c201:	48 89 df             	mov    %rbx,%rdi
    c204:	e8 77 fe ff ff       	call   c080 <fwp_encode>
    c209:	4d 8b 76 10          	mov    0x10(%r14),%r14
    c20d:	eb e1                	jmp    c1f0 <fwp_encode+0x170>
    c20f:	4c 89 f7             	mov    %r14,%rdi
    c212:	e8 59 db ff ff       	call   9d70 <fwp_u128>
    c217:	49 89 d6             	mov    %rdx,%r14
    c21a:	48 89 df             	mov    %rbx,%rdi
    c21d:	48 89 c6             	mov    %rax,%rsi
    c220:	ba 08 00 00 00       	mov    $0x8,%edx
    c225:	e8 b6 00 00 00       	call   c2e0 <fwp_le>
    c22a:	48 89 df             	mov    %rbx,%rdi
    c22d:	4c 89 f6             	mov    %r14,%rsi
    c230:	ba 08 00 00 00       	mov    $0x8,%edx
    c235:	5b                   	pop    %rbx
    c236:	41 5c                	pop    %r12
    c238:	41 5d                	pop    %r13
    c23a:	41 5e                	pop    %r14
    c23c:	41 5f                	pop    %r15
    c23e:	e9 9d 00 00 00       	jmp    c2e0 <fwp_le>
    c243:	41 83 7f 10 00       	cmpl   $0x0,0x10(%r15)
    c248:	7e 5f                	jle    c2a9 <fwp_encode+0x229>
    c24a:	45 31 e4             	xor    %r12d,%r12d
    c24d:	0f 1f 00             	nopl   (%rax)
    c250:	4b 8b 74 e6 08       	mov    0x8(%r14,%r12,8),%rsi
    c255:	49 8b 47 20          	mov    0x20(%r15),%rax
    c259:	4a 8b 14 e0          	mov    (%rax,%r12,8),%rdx
    c25d:	48 89 df             	mov    %rbx,%rdi
    c260:	e8 1b fe ff ff       	call   c080 <fwp_encode>
    c265:	49 ff c4             	inc    %r12
    c268:	49 63 47 10          	movslq 0x10(%r15),%rax
    c26c:	49 39 c4             	cmp    %rax,%r12
    c26f:	7c df                	jl     c250 <fwp_encode+0x1d0>
    c271:	eb 36                	jmp    c2a9 <fwp_encode+0x229>
    c273:	49 8b 36             	mov    (%r14),%rsi
    c276:	48 89 df             	mov    %rbx,%rdi
    c279:	e8 b2 00 00 00       	call   c330 <fwp_leb128>
    c27e:	49 83 3e 00          	cmpq   $0x0,(%r14)
    c282:	74 25                	je     c2a9 <fwp_encode+0x229>
    c284:	45 31 e4             	xor    %r12d,%r12d
    c287:	66 0f 1f 84 00 00 00 	nopw   0x0(%rax,%rax,1)
    c28e:	00 00 
    c290:	4b 8b 74 e6 08       	mov    0x8(%r14,%r12,8),%rsi
    c295:	49 8b 57 38          	mov    0x38(%r15),%rdx
    c299:	48 89 df             	mov    %rbx,%rdi
    c29c:	e8 df fd ff ff       	call   c080 <fwp_encode>
    c2a1:	49 ff c4             	inc    %r12
    c2a4:	4d 3b 26             	cmp    (%r14),%r12
    c2a7:	72 e7                	jb     c290 <fwp_encode+0x210>
    c2a9:	5b                   	pop    %rbx
    c2aa:	41 5c                	pop    %r12
    c2ac:	41 5d                	pop    %r13
    c2ae:	41 5e                	pop    %r14
    c2b0:	41 5f                	pop    %r15
    c2b2:	c3                   	ret
    c2b3:	66 66 66 66 2e 0f 1f 	data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    c2ba:	84 00 00 00 00 00 

000000000000c2c0 <fwp_pipe_frame_done>:
    c2c0:	83 3d f5 89 00 00 00 	cmpl   $0x0,0x89f5(%rip)        # 14cbc <fwp_po_listen>
    c2c7:	78 16                	js     c2df <fwp_pipe_frame_done+0x1f>
    c2c9:	8b 05 41 8b 02 00    	mov    0x28b41(%rip),%eax        # 34e10 <fwp_po_frames>
    c2cf:	ff c0                	inc    %eax
    c2d1:	89 05 39 8b 02 00    	mov    %eax,0x28b39(%rip)        # 34e10 <fwp_po_frames>
    c2d7:	a8 3f                	test   $0x3f,%al
    c2d9:	0f 84 11 e0 ff ff    	je     a2f0 <fwp_pipe_poll>
    c2df:	c3                   	ret

000000000000c2e0 <fwp_le>:
    c2e0:	85 d2                	test   %edx,%edx
    c2e2:	7e 44                	jle    c328 <fwp_le+0x48>
    c2e4:	41 57                	push   %r15
    c2e6:	41 56                	push   %r14
    c2e8:	41 54                	push   %r12
    c2ea:	53                   	push   %rbx
    c2eb:	50                   	push   %rax
    c2ec:	48 89 f3             	mov    %rsi,%rbx
    c2ef:	49 89 fe             	mov    %rdi,%r14
    c2f2:	41 89 d4             	mov    %edx,%r12d
    c2f5:	49 c1 e4 03          	shl    $0x3,%r12
    c2f9:	45 31 ff             	xor    %r15d,%r15d
    c2fc:	0f 1f 40 00          	nopl   0x0(%rax)
    c300:	48 89 d8             	mov    %rbx,%rax
    c303:	44 89 f9             	mov    %r15d,%ecx
    c306:	48 d3 e8             	shr    %cl,%rax
    c309:	0f be f0             	movsbl %al,%esi
    c30c:	4c 89 f7             	mov    %r14,%rdi
    c30f:	e8 8c b3 ff ff       	call   76a0 <buf_putc>
    c314:	49 83 c7 08          	add    $0x8,%r15
    c318:	4d 39 fc             	cmp    %r15,%r12
    c31b:	75 e3                	jne    c300 <fwp_le+0x20>
    c31d:	48 83 c4 08          	add    $0x8,%rsp
    c321:	5b                   	pop    %rbx
    c322:	41 5c                	pop    %r12
    c324:	41 5e                	pop    %r14
    c326:	41 5f                	pop    %r15
    c328:	c3                   	ret
    c329:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)

000000000000c330 <fwp_leb128>:
    c330:	41 57                	push   %r15
    c332:	41 56                	push   %r14
    c334:	53                   	push   %rbx
    c335:	49 89 f6             	mov    %rsi,%r14
    c338:	48 89 fb             	mov    %rdi,%rbx
    c33b:	48 81 fe 80 00 00 00 	cmp    $0x80,%rsi
    c342:	73 05                	jae    c349 <fwp_leb128+0x19>
    c344:	4d 89 f7             	mov    %r14,%r15
    c347:	eb 27                	jmp    c370 <fwp_leb128+0x40>
    c349:	4d 89 f7             	mov    %r14,%r15
    c34c:	0f 1f 40 00          	nopl   0x0(%rax)
    c350:	49 c1 ef 07          	shr    $0x7,%r15
    c354:	44 89 f0             	mov    %r14d,%eax
    c357:	0c 80                	or     $0x80,%al
    c359:	0f be f0             	movsbl %al,%esi
    c35c:	48 89 df             	mov    %rbx,%rdi
    c35f:	e8 3c b3 ff ff       	call   76a0 <buf_putc>
    c364:	49 81 fe ff 3f 00 00 	cmp    $0x3fff,%r14
    c36b:	4d 89 fe             	mov    %r15,%r14
    c36e:	77 e0                	ja     c350 <fwp_leb128+0x20>
    c370:	41 0f be f7          	movsbl %r15b,%esi
    c374:	48 89 df             	mov    %rbx,%rdi
    c377:	5b                   	pop    %rbx
    c378:	41 5e                	pop    %r14
    c37a:	41 5f                	pop    %r15
    c37c:	e9 1f b3 ff ff       	jmp    76a0 <buf_putc>
    c381:	66 66 66 66 66 66 2e 	data16 data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    c388:	0f 1f 84 00 00 00 00 
    c38f:	00 

000000000000c390 <fwp_pipe_read>:
    c390:	55                   	push   %rbp
    c391:	41 57                	push   %r15
    c393:	41 56                	push   %r14
    c395:	41 55                	push   %r13
    c397:	41 54                	push   %r12
    c399:	53                   	push   %rbx
    c39a:	50                   	push   %rax
    c39b:	48 89 f3             	mov    %rsi,%rbx
    c39e:	8b 05 70 8a 02 00    	mov    0x28a70(%rip),%eax        # 34e14 <fwp_pi_kind>
    c3a4:	83 f8 01             	cmp    $0x1,%eax
    c3a7:	0f 84 89 00 00 00    	je     c436 <fwp_pipe_read+0xa6>
    c3ad:	83 f8 02             	cmp    $0x2,%eax
    c3b0:	0f 85 d7 00 00 00    	jne    c48d <fwp_pipe_read+0xfd>
    c3b6:	48 89 3c 24          	mov    %rdi,(%rsp)
    c3ba:	4c 8b 25 57 8a 02 00 	mov    0x28a57(%rip),%r12        # 34e18 <fwp_pi_ring>
    c3c1:	4d 8d ac 24 c0 00 00 	lea    0xc0(%r12),%r13
    c3c8:	00 
    c3c9:	49 8d ac 24 c4 00 00 	lea    0xc4(%r12),%rbp
    c3d0:	00 
    c3d1:	4c 8d 35 b8 01 00 00 	lea    0x1b8(%rip),%r14        # c590 <fwp_ring_has_data>
    c3d8:	45 31 ff             	xor    %r15d,%r15d
    c3db:	eb 23                	jmp    c400 <fwp_pipe_read+0x70>
    c3dd:	0f 1f 00             	nopl   (%rax)
    c3e0:	44 8b 05 e1 88 00 00 	mov    0x88e1(%rip),%r8d        # 14cc8 <fwp_pi_sock>
    c3e7:	4c 89 e7             	mov    %r12,%rdi
    c3ea:	4c 89 ee             	mov    %r13,%rsi
    c3ed:	48 89 ea             	mov    %rbp,%rdx
    c3f0:	4c 89 f1             	mov    %r14,%rcx
    c3f3:	e8 98 dc ff ff       	call   a090 <fwp_ring_wait>
    c3f8:	85 c0                	test   %eax,%eax
    c3fa:	0f 84 6c 01 00 00    	je     c56c <fwp_pipe_read+0x1dc>
    c400:	49 8b 4c 24 40       	mov    0x40(%r12),%rcx
    c405:	49 8b 84 24 80 00 00 	mov    0x80(%r12),%rax
    c40c:	00 
    c40d:	48 29 c1             	sub    %rax,%rcx
    c410:	0f 85 9c 00 00 00    	jne    c4b2 <fwp_pipe_read+0x122>
    c416:	41 8b 84 24 40 01 00 	mov    0x140(%r12),%eax
    c41d:	00 
    c41e:	85 c0                	test   %eax,%eax
    c420:	74 be                	je     c3e0 <fwp_pipe_read+0x50>
    c422:	49 8b 44 24 40       	mov    0x40(%r12),%rax
    c427:	49 3b 84 24 80 00 00 	cmp    0x80(%r12),%rax
    c42e:	00 
    c42f:	75 af                	jne    c3e0 <fwp_pipe_read+0x50>
    c431:	e9 36 01 00 00       	jmp    c56c <fwp_pipe_read+0x1dc>
    c436:	4c 8b 35 e3 89 02 00 	mov    0x289e3(%rip),%r14        # 34e20 <fwp_pi_pos>
    c43d:	4c 8b 3d e4 89 02 00 	mov    0x289e4(%rip),%r15        # 34e28 <fwp_pi_len>
    c444:	4d 39 fe             	cmp    %r15,%r14
    c447:	0f 85 f9 00 00 00    	jne    c546 <fwp_pipe_read+0x1b6>
    c44d:	49 89 fc             	mov    %rdi,%r12
    c450:	4c 8d 35 d9 89 02 00 	lea    0x289d9(%rip),%r14        # 34e30 <fwp_pi_buf>
    c457:	45 31 ff             	xor    %r15d,%r15d
    c45a:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)
    c460:	8b 3d 62 88 00 00    	mov    0x8862(%rip),%edi        # 14cc8 <fwp_pi_sock>
    c466:	ba 00 00 01 00       	mov    $0x10000,%edx
    c46b:	4c 89 f6             	mov    %r14,%rsi
    c46e:	31 c9                	xor    %ecx,%ecx
    c470:	e8 eb 5b ff ff       	call   2060 <recv@plt>
    c475:	48 85 c0             	test   %rax,%rax
    c478:	0f 89 b6 00 00 00    	jns    c534 <fwp_pipe_read+0x1a4>
    c47e:	e8 fd 5b ff ff       	call   2080 <__errno_location@plt>
    c483:	83 38 04             	cmpl   $0x4,(%rax)
    c486:	74 d8                	je     c460 <fwp_pipe_read+0xd0>
    c488:	e9 df 00 00 00       	jmp    c56c <fwp_pipe_read+0x1dc>
    c48d:	48 8b 05 24 6b 00 00 	mov    0x6b24(%rip),%rax        # 12fb8 <stdin@GLIBC_2.2.5>
    c494:	48 8b 08             	mov    (%rax),%rcx
    c497:	be 01 00 00 00       	mov    $0x1,%esi
    c49c:	48 89 da             	mov    %rbx,%rdx
    c49f:	48 83 c4 08          	add    $0x8,%rsp
    c4a3:	5b                   	pop    %rbx
    c4a4:	41 5c                	pop    %r12
    c4a6:	41 5d                	pop    %r13
    c4a8:	41 5e                	pop    %r14
    c4aa:	41 5f                	pop    %r15
    c4ac:	5d                   	pop    %rbp
    c4ad:	e9 3e 5c ff ff       	jmp    20f0 <fread@plt>
    c4b2:	48 39 d9             	cmp    %rbx,%rcx
    c4b5:	48 0f 42 d9          	cmovb  %rcx,%rbx
    c4b9:	4d 8b 74 24 08       	mov    0x8(%r12),%r14
    c4be:	49 8d 4e ff          	lea    -0x1(%r14),%rcx
    c4c2:	48 21 c1             	and    %rax,%rcx
    c4c5:	49 29 ce             	sub    %rcx,%r14
    c4c8:	4c 39 f3             	cmp    %r14,%rbx
    c4cb:	4c 0f 42 f3          	cmovb  %rbx,%r14
    c4cf:	4d 8d bc 24 00 10 00 	lea    0x1000(%r12),%r15
    c4d6:	00 
    c4d7:	49 8d 34 0c          	lea    (%r12,%rcx,1),%rsi
    c4db:	48 81 c6 00 10 00 00 	add    $0x1000,%rsi
    c4e2:	4c 8b 2c 24          	mov    (%rsp),%r13
    c4e6:	4c 89 ef             	mov    %r13,%rdi
    c4e9:	4c 89 f2             	mov    %r14,%rdx
    c4ec:	e8 3f 5e ff ff       	call   2330 <memcpy@plt>
    c4f1:	4d 01 f5             	add    %r14,%r13
    c4f4:	48 89 da             	mov    %rbx,%rdx
    c4f7:	4c 29 f2             	sub    %r14,%rdx
    c4fa:	4c 89 ef             	mov    %r13,%rdi
    c4fd:	4c 89 fe             	mov    %r15,%rsi
    c500:	e8 2b 5e ff ff       	call   2330 <memcpy@plt>
    c505:	49 8b 84 24 80 00 00 	mov    0x80(%r12),%rax
    c50c:	00 
    c50d:	48 01 d8             	add    %rbx,%rax
    c510:	49 89 84 24 80 00 00 	mov    %rax,0x80(%r12)
    c517:	00 
    c518:	49 8d bc 24 00 01 00 	lea    0x100(%r12),%rdi
    c51f:	00 
    c520:	49 81 c4 04 01 00 00 	add    $0x104,%r12
    c527:	4c 89 e6             	mov    %r12,%rsi
    c52a:	e8 c1 dc ff ff       	call   a1f0 <fwp_ring_wake>
    c52f:	49 89 df             	mov    %rbx,%r15
    c532:	eb 38                	jmp    c56c <fwp_pipe_read+0x1dc>
    c534:	74 48                	je     c57e <fwp_pipe_read+0x1ee>
    c536:	4c 89 e7             	mov    %r12,%rdi
    c539:	48 89 05 e8 88 02 00 	mov    %rax,0x288e8(%rip)        # 34e28 <fwp_pi_len>
    c540:	45 31 f6             	xor    %r14d,%r14d
    c543:	49 89 c7             	mov    %rax,%r15
    c546:	4d 29 f7             	sub    %r14,%r15
    c549:	49 39 df             	cmp    %rbx,%r15
    c54c:	4c 0f 43 fb          	cmovae %rbx,%r15
    c550:	48 8d 35 d9 88 02 00 	lea    0x288d9(%rip),%rsi        # 34e30 <fwp_pi_buf>
    c557:	4c 01 f6             	add    %r14,%rsi
    c55a:	4c 89 fa             	mov    %r15,%rdx
    c55d:	e8 ce 5d ff ff       	call   2330 <memcpy@plt>
    c562:	4d 01 fe             	add    %r15,%r14
    c565:	4c 89 35 b4 88 02 00 	mov    %r14,0x288b4(%rip)        # 34e20 <fwp_pi_pos>
    c56c:	4c 89 f8             	mov    %r15,%rax
    c56f:	48 83 c4 08          	add    $0x8,%rsp
    c573:	5b                   	pop    %rbx
    c574:	41 5c                	pop    %r12
    c576:	41 5d                	pop    %r13
    c578:	41 5e                	pop    %r14
    c57a:	41 5f                	pop    %r15
    c57c:	5d                   	pop    %rbp
    c57d:	c3                   	ret
    c57e:	45 31 ff             	xor    %r15d,%r15d
    c581:	eb e9                	jmp    c56c <fwp_pipe_read+0x1dc>
    c583:	66 66 66 66 2e 0f 1f 	data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    c58a:	84 00 00 00 00 00 

000000000000c590 <fwp_ring_has_data>:
    c590:	48 8b 4f 40          	mov    0x40(%rdi),%rcx
    c594:	b8 01 00 00 00       	mov    $0x1,%eax
    c599:	48 3b 8f 80 00 00 00 	cmp    0x80(%rdi),%rcx
    c5a0:	75 0d                	jne    c5af <fwp_ring_has_data+0x1f>
    c5a2:	8b 8f 40 01 00 00    	mov    0x140(%rdi),%ecx
    c5a8:	31 c0                	xor    %eax,%eax
    c5aa:	85 c9                	test   %ecx,%ecx
    c5ac:	0f 95 c0             	setne  %al
    c5af:	c3                   	ret

000000000000c5b0 <fwp_pipe_report>:
    c5b0:	53                   	push   %rbx
    c5b1:	48 89 fb             	mov    %rdi,%rbx
    c5b4:	48 8d 3d cc 1d 00 00 	lea    0x1dcc(%rip),%rdi        # e387 <exec_in_fp0+0xd47>
    c5bb:	e8 70 5a ff ff       	call   2030 <getenv@plt>
    c5c0:	48 85 c0             	test   %rax,%rax
    c5c3:	74 18                	je     c5dd <fwp_pipe_report+0x2d>
    c5c5:	80 38 00             	cmpb   $0x0,(%rax)
    c5c8:	74 13                	je     c5dd <fwp_pipe_report+0x2d>
    c5ca:	48 8d 35 89 1d 00 00 	lea    0x1d89(%rip),%rsi        # e35a <exec_in_fp0+0xd1a>
    c5d1:	48 89 c7             	mov    %rax,%rdi
    c5d4:	e8 f7 5c ff ff       	call   22d0 <strcmp@plt>
    c5d9:	85 c0                	test   %eax,%eax
    c5db:	75 02                	jne    c5df <fwp_pipe_report+0x2f>
    c5dd:	5b                   	pop    %rbx
    c5de:	c3                   	ret
    c5df:	48 8b 05 f2 69 00 00 	mov    0x69f2(%rip),%rax        # 12fd8 <stderr@GLIBC_2.2.5>
    c5e6:	48 8b 38             	mov    (%rax),%rdi
    c5e9:	48 8d 35 ac 1d 00 00 	lea    0x1dac(%rip),%rsi        # e39c <exec_in_fp0+0xd5c>
    c5f0:	48 89 da             	mov    %rbx,%rdx
    c5f3:	31 c0                	xor    %eax,%eax
    c5f5:	5b                   	pop    %rbx
    c5f6:	e9 f5 5c ff ff       	jmp    22f0 <fprintf@plt>
    c5fb:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)

000000000000c600 <rd_le>:
    c600:	55                   	push   %rbp
    c601:	41 56                	push   %r14
    c603:	53                   	push   %rbx
    c604:	48 83 ec 10          	sub    $0x10,%rsp
    c608:	48 89 d3             	mov    %rdx,%rbx
    c60b:	89 f5                	mov    %esi,%ebp
    c60d:	41 89 f6             	mov    %esi,%r14d
    c610:	48 8d 54 24 08       	lea    0x8(%rsp),%rdx
    c615:	4c 89 f6             	mov    %r14,%rsi
    c618:	e8 23 01 00 00       	call   c740 <rd_take>
    c61d:	85 c0                	test   %eax,%eax
    c61f:	74 20                	je     c641 <rd_le+0x41>
    c621:	48 c7 03 00 00 00 00 	movq   $0x0,(%rbx)
    c628:	b8 01 00 00 00       	mov    $0x1,%eax
    c62d:	85 ed                	test   %ebp,%ebp
    c62f:	7e 7d                	jle    c6ae <rd_le+0xae>
    c631:	48 8b 74 24 08       	mov    0x8(%rsp),%rsi
    c636:	83 fd 01             	cmp    $0x1,%ebp
    c639:	75 0a                	jne    c645 <rd_le+0x45>
    c63b:	31 d2                	xor    %edx,%edx
    c63d:	31 ff                	xor    %edi,%edi
    c63f:	eb 55                	jmp    c696 <rd_le+0x96>
    c641:	31 c0                	xor    %eax,%eax
    c643:	eb 69                	jmp    c6ae <rd_le+0xae>
    c645:	45 89 f0             	mov    %r14d,%r8d
    c648:	41 81 e0 fe ff ff 7f 	and    $0x7ffffffe,%r8d
    c64f:	41 b9 08 00 00 00    	mov    $0x8,%r9d
    c655:	31 d2                	xor    %edx,%edx
    c657:	31 ff                	xor    %edi,%edi
    c659:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)
    c660:	44 0f b6 14 16       	movzbl (%rsi,%rdx,1),%r10d
    c665:	41 8d 49 f8          	lea    -0x8(%r9),%ecx
    c669:	80 e1 f0             	and    $0xf0,%cl
    c66c:	49 d3 e2             	shl    %cl,%r10
    c66f:	49 09 fa             	or     %rdi,%r10
    c672:	4c 89 13             	mov    %r10,(%rbx)
    c675:	0f b6 7c 16 01       	movzbl 0x1(%rsi,%rdx,1),%edi
    c67a:	44 89 c9             	mov    %r9d,%ecx
    c67d:	80 e1 f8             	and    $0xf8,%cl
    c680:	48 d3 e7             	shl    %cl,%rdi
    c683:	4c 09 d7             	or     %r10,%rdi
    c686:	48 89 3b             	mov    %rdi,(%rbx)
    c689:	48 83 c2 02          	add    $0x2,%rdx
    c68d:	49 83 c1 10          	add    $0x10,%r9
    c691:	49 39 d0             	cmp    %rdx,%r8
    c694:	75 ca                	jne    c660 <rd_le+0x60>
    c696:	41 f6 c6 01          	test   $0x1,%r14b
    c69a:	74 12                	je     c6ae <rd_le+0xae>
    c69c:	0f b6 34 16          	movzbl (%rsi,%rdx,1),%esi
    c6a0:	c1 e2 03             	shl    $0x3,%edx
    c6a3:	89 d1                	mov    %edx,%ecx
    c6a5:	48 d3 e6             	shl    %cl,%rsi
    c6a8:	48 09 fe             	or     %rdi,%rsi
    c6ab:	48 89 33             	mov    %rsi,(%rbx)
    c6ae:	48 83 c4 10          	add    $0x10,%rsp
    c6b2:	5b                   	pop    %rbx
    c6b3:	41 5e                	pop    %r14
    c6b5:	5d                   	pop    %rbp
    c6b6:	c3                   	ret
    c6b7:	66 0f 1f 84 00 00 00 	nopw   0x0(%rax,%rax,1)
    c6be:	00 00 

000000000000c6c0 <rd_leb>:
    c6c0:	41 57                	push   %r15
    c6c2:	41 56                	push   %r14
    c6c4:	41 54                	push   %r12
    c6c6:	53                   	push   %rbx
    c6c7:	50                   	push   %rax
    c6c8:	48 89 f3             	mov    %rsi,%rbx
    c6cb:	49 89 fe             	mov    %rdi,%r14
    c6ce:	48 c7 06 00 00 00 00 	movq   $0x0,(%rsi)
    c6d5:	49 c7 c7 f9 ff ff ff 	mov    $0xfffffffffffffff9,%r15
    c6dc:	49 89 e4             	mov    %rsp,%r12
    c6df:	90                   	nop
    c6e0:	be 01 00 00 00       	mov    $0x1,%esi
    c6e5:	4c 89 f7             	mov    %r14,%rdi
    c6e8:	4c 89 e2             	mov    %r12,%rdx
    c6eb:	e8 50 00 00 00       	call   c740 <rd_take>
    c6f0:	85 c0                	test   %eax,%eax
    c6f2:	74 2f                	je     c723 <rd_leb+0x63>
    c6f4:	48 8b 04 24          	mov    (%rsp),%rax
    c6f8:	0f b6 10             	movzbl (%rax),%edx
    c6fb:	49 83 ff 38          	cmp    $0x38,%r15
    c6ff:	75 07                	jne    c708 <rd_leb+0x48>
    c701:	89 d1                	mov    %edx,%ecx
    c703:	80 e1 7e             	and    $0x7e,%cl
    c706:	75 1b                	jne    c723 <rd_leb+0x63>
    c708:	49 83 c7 07          	add    $0x7,%r15
    c70c:	83 e2 7f             	and    $0x7f,%edx
    c70f:	44 89 f9             	mov    %r15d,%ecx
    c712:	48 d3 e2             	shl    %cl,%rdx
    c715:	48 09 13             	or     %rdx,(%rbx)
    c718:	80 38 00             	cmpb   $0x0,(%rax)
    c71b:	79 0a                	jns    c727 <rd_leb+0x67>
    c71d:	49 83 ff 38          	cmp    $0x38,%r15
    c721:	76 bd                	jbe    c6e0 <rd_leb+0x20>
    c723:	31 c0                	xor    %eax,%eax
    c725:	eb 05                	jmp    c72c <rd_leb+0x6c>
    c727:	b8 01 00 00 00       	mov    $0x1,%eax
    c72c:	48 83 c4 08          	add    $0x8,%rsp
    c730:	5b                   	pop    %rbx
    c731:	41 5c                	pop    %r12
    c733:	41 5e                	pop    %r14
    c735:	41 5f                	pop    %r15
    c737:	c3                   	ret
    c738:	0f 1f 84 00 00 00 00 	nopl   0x0(%rax,%rax,1)
    c73f:	00 

000000000000c740 <rd_take>:
    c740:	4c 8b 47 08          	mov    0x8(%rdi),%r8
    c744:	48 8b 4f 10          	mov    0x10(%rdi),%rcx
    c748:	49 29 c8             	sub    %rcx,%r8
    c74b:	31 c0                	xor    %eax,%eax
    c74d:	49 39 f0             	cmp    %rsi,%r8
    c750:	72 15                	jb     c767 <rd_take+0x27>
    c752:	48 8b 07             	mov    (%rdi),%rax
    c755:	48 01 c8             	add    %rcx,%rax
    c758:	48 89 02             	mov    %rax,(%rdx)
    c75b:	48 01 ce             	add    %rcx,%rsi
    c75e:	48 89 77 10          	mov    %rsi,0x10(%rdi)
    c762:	b8 01 00 00 00       	mov    $0x1,%eax
    c767:	c3                   	ret
    c768:	0f 1f 84 00 00 00 00 	nopl   0x0(%rax,%rax,1)
    c76f:	00 

000000000000c770 <fwp_getc>:
    c770:	48 63 05 55 86 01 00 	movslq 0x18655(%rip),%rax        # 24dcc <fwp_in_ppos>
    c777:	3b 05 4b 86 01 00    	cmp    0x1864b(%rip),%eax        # 24dc8 <fwp_in_npend>
    c77d:	7d 15                	jge    c794 <fwp_getc+0x24>
    c77f:	8d 48 01             	lea    0x1(%rax),%ecx
    c782:	89 0d 44 86 01 00    	mov    %ecx,0x18644(%rip)        # 24dcc <fwp_in_ppos>
    c788:	48 8d 0d 35 86 01 00 	lea    0x18635(%rip),%rcx        # 24dc4 <fwp_in_pend>
    c78f:	0f b6 04 08          	movzbl (%rax,%rcx,1),%eax
    c793:	c3                   	ret
    c794:	48 8b 05 1d 68 00 00 	mov    0x681d(%rip),%rax        # 12fb8 <stdin@GLIBC_2.2.5>
    c79b:	48 8b 38             	mov    (%rax),%rdi
    c79e:	e9 7d 5a ff ff       	jmp    2220 <fgetc@plt>
    c7a3:	66 66 66 66 2e 0f 1f 	data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    c7aa:	84 00 00 00 00 00 

000000000000c7b0 <fwp_gc_find_data>:
    c7b0:	0f b7 77 18          	movzwl 0x18(%rdi),%esi
    c7b4:	48 85 f6             	test   %rsi,%rsi
    c7b7:	0f 84 be 00 00 00    	je     c87b <fwp_gc_find_data+0xcb>
    c7bd:	53                   	push   %rbx
    c7be:	48 8b 07             	mov    (%rdi),%rax
    c7c1:	4c 8b 47 10          	mov    0x10(%rdi),%r8
    c7c5:	48 6b ce 38          	imul   $0x38,%rsi,%rcx
    c7c9:	45 31 c9             	xor    %r9d,%r9d
    c7cc:	48 8d 15 c5 6a 00 00 	lea    0x6ac5(%rip),%rdx        # 13298 <fwp_gc>
    c7d3:	41 bb 01 00 00 00    	mov    $0x1,%r11d
    c7d9:	45 31 d2             	xor    %r10d,%r10d
    c7dc:	eb 0b                	jmp    c7e9 <fwp_gc_find_data+0x39>
    c7de:	66 90                	xchg   %ax,%ax
    c7e0:	49 83 c1 38          	add    $0x38,%r9
    c7e4:	4c 39 c9             	cmp    %r9,%rcx
    c7e7:	74 22                	je     c80b <fwp_gc_find_data+0x5b>
    c7e9:	43 83 3c 08 01       	cmpl   $0x1,(%r8,%r9,1)
    c7ee:	75 f0                	jne    c7e0 <fwp_gc_find_data+0x30>
    c7f0:	4b 8b 5c 08 10       	mov    0x10(%r8,%r9,1),%rbx
    c7f5:	48 01 c3             	add    %rax,%rbx
    c7f8:	48 39 d3             	cmp    %rdx,%rbx
    c7fb:	77 e3                	ja     c7e0 <fwp_gc_find_data+0x30>
    c7fd:	4b 03 5c 08 28       	add    0x28(%r8,%r9,1),%rbx
    c802:	48 39 d3             	cmp    %rdx,%rbx
    c805:	45 0f 47 d3          	cmova  %r11d,%r10d
    c809:	eb d5                	jmp    c7e0 <fwp_gc_find_data+0x30>
    c80b:	31 c0                	xor    %eax,%eax
    c80d:	45 85 d2             	test   %r10d,%r10d
    c810:	0f 95 c0             	setne  %al
    c813:	74 6e                	je     c883 <fwp_gc_find_data+0xd3>
    c815:	66 85 f6             	test   %si,%si
    c818:	74 69                	je     c883 <fwp_gc_find_data+0xd3>
    c81a:	8b 05 08 7c 00 00    	mov    0x7c08(%rip),%eax        # 14428 <fwp_gc+0x1190>
    c820:	48 8b 77 10          	mov    0x10(%rdi),%rsi
    c824:	45 31 c0             	xor    %r8d,%r8d
    c827:	eb 10                	jmp    c839 <fwp_gc_find_data+0x89>
    c829:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)
    c830:	49 83 c0 38          	add    $0x38,%r8
    c834:	4c 39 c1             	cmp    %r8,%rcx
    c837:	74 45                	je     c87e <fwp_gc_find_data+0xce>
    c839:	42 83 3c 06 01       	cmpl   $0x1,(%rsi,%r8,1)
    c83e:	75 f0                	jne    c830 <fwp_gc_find_data+0x80>
    c840:	42 f6 44 06 04 02    	testb  $0x2,0x4(%rsi,%r8,1)
    c846:	74 e8                	je     c830 <fwp_gc_find_data+0x80>
    c848:	83 f8 10             	cmp    $0x10,%eax
    c84b:	74 31                	je     c87e <fwp_gc_find_data+0xce>
    c84d:	4e 8b 4c 06 10       	mov    0x10(%rsi,%r8,1),%r9
    c852:	4c 03 0f             	add    (%rdi),%r9
    c855:	4c 63 d0             	movslq %eax,%r10
    c858:	49 c1 e2 04          	shl    $0x4,%r10
    c85c:	4d 89 8c 12 90 10 00 	mov    %r9,0x1090(%r10,%rdx,1)
    c863:	00 
    c864:	4e 8b 4c 06 28       	mov    0x28(%rsi,%r8,1),%r9
    c869:	4d 89 8c 12 98 10 00 	mov    %r9,0x1098(%r10,%rdx,1)
    c870:	00 
    c871:	ff c0                	inc    %eax
    c873:	89 05 af 7b 00 00    	mov    %eax,0x7baf(%rip)        # 14428 <fwp_gc+0x1190>
    c879:	eb b5                	jmp    c830 <fwp_gc_find_data+0x80>
    c87b:	31 c0                	xor    %eax,%eax
    c87d:	c3                   	ret
    c87e:	b8 01 00 00 00       	mov    $0x1,%eax
    c883:	5b                   	pop    %rbx
    c884:	c3                   	ret
    c885:	66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
    c88c:	00 00 00 00 

000000000000c890 <fwp_gc_report>:
    c890:	41 57                	push   %r15
    c892:	41 56                	push   %r14
    c894:	53                   	push   %rbx
    c895:	48 83 ec 50          	sub    $0x50,%rsp
    c899:	48 8b 05 08 7c 00 00 	mov    0x7c08(%rip),%rax        # 144a8 <fwp_gc+0x1210>
    c8a0:	48 8b 0d f1 69 00 00 	mov    0x69f1(%rip),%rcx        # 13298 <fwp_gc>
    c8a7:	48 29 c8             	sub    %rcx,%rax
    c8aa:	f2 48 0f 2a c8       	cvtsi2sd %rax,%xmm1
    c8af:	f2 0f 58 0d c9 7b 00 	addsd  0x7bc9(%rip),%xmm1        # 14480 <fwp_gc+0x11e8>
    c8b6:	00 
    c8b7:	f2 0f 11 0d c1 7b 00 	movsd  %xmm1,0x7bc1(%rip)        # 14480 <fwp_gc+0x11e8>
    c8be:	00 
    c8bf:	48 89 0d e2 7b 00 00 	mov    %rcx,0x7be2(%rip)        # 144a8 <fwp_gc+0x1210>
    c8c6:	48 8b 05 0b 67 00 00 	mov    0x670b(%rip),%rax        # 12fd8 <stderr@GLIBC_2.2.5>
    c8cd:	4c 8b 38             	mov    (%rax),%r15
    c8d0:	48 8b 1d 99 7b 00 00 	mov    0x7b99(%rip),%rbx        # 14470 <fwp_gc+0x11d8>
    c8d7:	4c 8b 35 d2 79 00 00 	mov    0x79d2(%rip),%r14        # 142b0 <fwp_gc+0x1018>
    c8de:	f2 0f 10 15 ba 7b 00 	movsd  0x7bba(%rip),%xmm2        # 144a0 <fwp_gc+0x1208>
    c8e5:	00 
    c8e6:	f2 0f 58 ca          	addsd  %xmm2,%xmm1
    c8ea:	f2 0f 10 05 4e 07 00 	movsd  0x74e(%rip),%xmm0        # d040 <_IO_stdin_used+0x40>
    c8f1:	00 
    c8f2:	f2 0f 59 c8          	mulsd  %xmm0,%xmm1
    c8f6:	f2 0f 11 4c 24 18    	movsd  %xmm1,0x18(%rsp)
    c8fc:	f2 0f 59 d0          	mulsd  %xmm0,%xmm2
    c900:	f2 0f 11 54 24 10    	movsd  %xmm2,0x10(%rsp)
    c906:	f2 0f 10 0d d2 79 00 	movsd  0x79d2(%rip),%xmm1        # 142e0 <fwp_gc+0x1048>
    c90d:	00 
    c90e:	66 0f 28 15 4a 08 00 	movapd 0x84a(%rip),%xmm2        # d160 <_IO_stdin_used+0x160>
    c915:	00 
    c916:	0f 14 ca             	unpcklps %xmm2,%xmm1
    c919:	66 0f 28 1d 4f 08 00 	movapd 0x84f(%rip),%xmm3        # d170 <_IO_stdin_used+0x170>
    c920:	00 
    c921:	66 0f 5c cb          	subpd  %xmm3,%xmm1
    c925:	66 0f 28 e1          	movapd %xmm1,%xmm4
    c929:	66 0f 15 e1          	unpckhpd %xmm1,%xmm4
    c92d:	f2 0f 58 e1          	addsd  %xmm1,%xmm4
    c931:	f2 0f 59 e0          	mulsd  %xmm0,%xmm4
    c935:	66 0f 29 64 24 40    	movapd %xmm4,0x40(%rsp)
    c93b:	f2 0f 10 0d 1d 7b 00 	movsd  0x7b1d(%rip),%xmm1        # 14460 <fwp_gc+0x11c8>
    c942:	00 
    c943:	0f 14 ca             	unpcklps %xmm2,%xmm1
    c946:	66 0f 5c cb          	subpd  %xmm3,%xmm1
    c94a:	66 0f 28 e1          	movapd %xmm1,%xmm4
    c94e:	66 0f 15 e1          	unpckhpd %xmm1,%xmm4
    c952:	f2 0f 58 e1          	addsd  %xmm1,%xmm4
    c956:	f2 0f 59 e0          	mulsd  %xmm0,%xmm4
    c95a:	66 0f 29 64 24 30    	movapd %xmm4,0x30(%rsp)
    c960:	f2 0f 10 0d 00 7b 00 	movsd  0x7b00(%rip),%xmm1        # 14468 <fwp_gc+0x11d0>
    c967:	00 
    c968:	0f 14 ca             	unpcklps %xmm2,%xmm1
    c96b:	66 0f 5c cb          	subpd  %xmm3,%xmm1
    c96f:	66 0f 28 d1          	movapd %xmm1,%xmm2
    c973:	66 0f 15 d1          	unpckhpd %xmm1,%xmm2
    c977:	f2 0f 58 d1          	addsd  %xmm1,%xmm2
    c97b:	f2 0f 59 d0          	mulsd  %xmm0,%xmm2
    c97f:	66 0f 29 54 24 20    	movapd %xmm2,0x20(%rsp)
    c985:	f2 0f 10 05 fb 7a 00 	movsd  0x7afb(%rip),%xmm0        # 14488 <fwp_gc+0x11f0>
    c98c:	00 
    c98d:	f2 0f 11 44 24 08    	movsd  %xmm0,0x8(%rsp)
    c993:	f2 0f 10 05 f5 7a 00 	movsd  0x7af5(%rip),%xmm0        # 14490 <fwp_gc+0x11f8>
    c99a:	00 
    c99b:	f2 0f 11 04 24       	movsd  %xmm0,(%rsp)
    c9a0:	e8 6b 00 00 00       	call   ca10 <fwp_gc_status_kb>
    c9a5:	83 3d e0 78 00 00 00 	cmpl   $0x0,0x78e0(%rip)        # 1428c <fwp_gc+0xff4>
    c9ac:	48 8d 0d 84 1b 00 00 	lea    0x1b84(%rip),%rcx        # e537 <exec_in_fp0+0xef7>
    c9b3:	4c 8d 0d be 16 00 00 	lea    0x16be(%rip),%r9        # e078 <exec_in_fp0+0xa38>
    c9ba:	4c 0f 44 c9          	cmove  %rcx,%r9
    c9be:	48 8d 35 bd 1a 00 00 	lea    0x1abd(%rip),%rsi        # e482 <exec_in_fp0+0xe42>
    c9c5:	4c 89 ff             	mov    %r15,%rdi
    c9c8:	48 89 da             	mov    %rbx,%rdx
    c9cb:	4c 89 f1             	mov    %r14,%rcx
    c9ce:	f2 0f 10 44 24 18    	movsd  0x18(%rsp),%xmm0
    c9d4:	f2 0f 10 4c 24 10    	movsd  0x10(%rsp),%xmm1
    c9da:	0f 28 54 24 40       	movaps 0x40(%rsp),%xmm2
    c9df:	0f 28 5c 24 30       	movaps 0x30(%rsp),%xmm3
    c9e4:	0f 28 64 24 20       	movaps 0x20(%rsp),%xmm4
    c9e9:	f2 0f 10 6c 24 08    	movsd  0x8(%rsp),%xmm5
    c9ef:	f2 0f 10 34 24       	movsd  (%rsp),%xmm6
    c9f4:	49 89 c0             	mov    %rax,%r8
    c9f7:	b0 07                	mov    $0x7,%al
    c9f9:	48 83 c4 50          	add    $0x50,%rsp
    c9fd:	5b                   	pop    %rbx
    c9fe:	41 5e                	pop    %r14
    ca00:	41 5f                	pop    %r15
    ca02:	e9 e9 58 ff ff       	jmp    22f0 <fprintf@plt>
    ca07:	66 0f 1f 84 00 00 00 	nopw   0x0(%rax,%rax,1)
    ca0e:	00 00 

000000000000ca10 <fwp_gc_status_kb>:
    ca10:	55                   	push   %rbp
    ca11:	41 57                	push   %r15
    ca13:	41 56                	push   %r14
    ca15:	41 54                	push   %r12
    ca17:	53                   	push   %rbx
    ca18:	48 81 ec 00 01 00 00 	sub    $0x100,%rsp
    ca1f:	48 8d 3d 23 1b 00 00 	lea    0x1b23(%rip),%rdi        # e549 <exec_in_fp0+0xf09>
    ca26:	48 8d 35 3c 19 00 00 	lea    0x193c(%rip),%rsi        # e369 <exec_in_fp0+0xd29>
    ca2d:	e8 ee 59 ff ff       	call   2420 <fopen@plt>
    ca32:	48 85 c0             	test   %rax,%rax
    ca35:	74 7d                	je     cab4 <fwp_gc_status_kb+0xa4>
    ca37:	48 89 c3             	mov    %rax,%rbx
    ca3a:	48 89 e7             	mov    %rsp,%rdi
    ca3d:	be 00 01 00 00       	mov    $0x100,%esi
    ca42:	48 89 c2             	mov    %rax,%rdx
    ca45:	e8 46 58 ff ff       	call   2290 <fgets@plt>
    ca4a:	49 c7 c6 ff ff ff ff 	mov    $0xffffffffffffffff,%r14
    ca51:	48 85 c0             	test   %rax,%rax
    ca54:	74 54                	je     caaa <fwp_gc_status_kb+0x9a>
    ca56:	4c 8d 7c 24 06       	lea    0x6(%rsp),%r15
    ca5b:	bd 56 6d 48 57       	mov    $0x57486d56,%ebp
    ca60:	49 89 e4             	mov    %rsp,%r12
    ca63:	eb 20                	jmp    ca85 <fwp_gc_status_kb+0x75>
    ca65:	66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
    ca6c:	00 00 00 00 
    ca70:	4c 89 e7             	mov    %r12,%rdi
    ca73:	be 00 01 00 00       	mov    $0x100,%esi
    ca78:	48 89 da             	mov    %rbx,%rdx
    ca7b:	e8 10 58 ff ff       	call   2290 <fgets@plt>
    ca80:	48 85 c0             	test   %rax,%rax
    ca83:	74 25                	je     caaa <fwp_gc_status_kb+0x9a>
    ca85:	8b 04 24             	mov    (%rsp),%eax
    ca88:	31 e8                	xor    %ebp,%eax
    ca8a:	0f b6 4c 24 04       	movzbl 0x4(%rsp),%ecx
    ca8f:	83 f1 4d             	xor    $0x4d,%ecx
    ca92:	09 c1                	or     %eax,%ecx
    ca94:	75 da                	jne    ca70 <fwp_gc_status_kb+0x60>
    ca96:	80 7c 24 05 3a       	cmpb   $0x3a,0x5(%rsp)
    ca9b:	75 d3                	jne    ca70 <fwp_gc_status_kb+0x60>
    ca9d:	4c 89 ff             	mov    %r15,%rdi
    caa0:	e8 5b 59 ff ff       	call   2400 <atol@plt>
    caa5:	49 89 c6             	mov    %rax,%r14
    caa8:	eb c6                	jmp    ca70 <fwp_gc_status_kb+0x60>
    caaa:	48 89 df             	mov    %rbx,%rdi
    caad:	e8 9e 56 ff ff       	call   2150 <fclose@plt>
    cab2:	eb 07                	jmp    cabb <fwp_gc_status_kb+0xab>
    cab4:	49 c7 c6 ff ff ff ff 	mov    $0xffffffffffffffff,%r14
    cabb:	4c 89 f0             	mov    %r14,%rax
    cabe:	48 81 c4 00 01 00 00 	add    $0x100,%rsp
    cac5:	5b                   	pop    %rbx
    cac6:	41 5c                	pop    %r12
    cac8:	41 5e                	pop    %r14
    caca:	41 5f                	pop    %r15
    cacc:	5d                   	pop    %rbp
    cacd:	c3                   	ret
    cace:	66 90                	xchg   %ax,%ax

000000000000cad0 <__divti3>:
    cad0:	f3 0f 1e fa          	endbr64
    cad4:	55                   	push   %rbp
    cad5:	49 89 f8             	mov    %rdi,%r8
    cad8:	49 89 d2             	mov    %rdx,%r10
    cadb:	49 89 cb             	mov    %rcx,%r11
    cade:	31 ff                	xor    %edi,%edi
    cae0:	48 89 e5             	mov    %rsp,%rbp
    cae3:	41 56                	push   %r14
    cae5:	53                   	push   %rbx
    cae6:	48 85 f6             	test   %rsi,%rsi
    cae9:	79 13                	jns    cafe <__divti3+0x2e>
    caeb:	45 31 c9             	xor    %r9d,%r9d
    caee:	49 f7 d8             	neg    %r8
    caf1:	48 c7 c7 ff ff ff ff 	mov    $0xffffffffffffffff,%rdi
    caf8:	49 19 f1             	sbb    %rsi,%r9
    cafb:	4c 89 ce             	mov    %r9,%rsi
    cafe:	4c 89 da             	mov    %r11,%rdx
    cb01:	4d 85 db             	test   %r11,%r11
    cb04:	0f 88 f6 00 00 00    	js     cc00 <__divti3+0x130>
    cb0a:	4d 89 d6             	mov    %r10,%r14
    cb0d:	75 31                	jne    cb40 <__divti3+0x70>
    cb0f:	4c 39 f6             	cmp    %r14,%rsi
    cb12:	0f 83 b8 00 00 00    	jae    cbd0 <__divti3+0x100>
    cb18:	48 89 f2             	mov    %rsi,%rdx
    cb1b:	31 f6                	xor    %esi,%esi
    cb1d:	4c 89 c0             	mov    %r8,%rax
    cb20:	49 f7 f6             	div    %r14
    cb23:	48 89 f2             	mov    %rsi,%rdx
    cb26:	48 85 ff             	test   %rdi,%rdi
    cb29:	74 0a                	je     cb35 <__divti3+0x65>
    cb2b:	48 f7 d8             	neg    %rax
    cb2e:	48 83 d2 00          	adc    $0x0,%rdx
    cb32:	48 f7 da             	neg    %rdx
    cb35:	5b                   	pop    %rbx
    cb36:	41 5e                	pop    %r14
    cb38:	5d                   	pop    %rbp
    cb39:	c3                   	ret
    cb3a:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)
    cb40:	4c 39 de             	cmp    %r11,%rsi
    cb43:	0f 82 d5 00 00 00    	jb     cc1e <__divti3+0x14e>
    cb49:	4d 0f bd d3          	bsr    %r11,%r10
    cb4d:	41 83 f2 3f          	xor    $0x3f,%r10d
    cb51:	44 89 d1             	mov    %r10d,%ecx
    cb54:	b8 40 00 00 00       	mov    $0x40,%eax
    cb59:	4c 89 f3             	mov    %r14,%rbx
    cb5c:	4d 89 f1             	mov    %r14,%r9
    cb5f:	48 d3 e2             	shl    %cl,%rdx
    cb62:	49 63 ca             	movslq %r10d,%rcx
    cb65:	49 89 f3             	mov    %rsi,%r11
    cb68:	48 29 c8             	sub    %rcx,%rax
    cb6b:	89 c1                	mov    %eax,%ecx
    cb6d:	48 d3 eb             	shr    %cl,%rbx
    cb70:	44 89 d1             	mov    %r10d,%ecx
    cb73:	49 d3 e1             	shl    %cl,%r9
    cb76:	89 c1                	mov    %eax,%ecx
    cb78:	48 09 d3             	or     %rdx,%rbx
    cb7b:	4c 89 c2             	mov    %r8,%rdx
    cb7e:	49 d3 eb             	shr    %cl,%r11
    cb81:	44 89 d1             	mov    %r10d,%ecx
    cb84:	48 d3 e6             	shl    %cl,%rsi
    cb87:	89 c1                	mov    %eax,%ecx
    cb89:	48 d3 ea             	shr    %cl,%rdx
    cb8c:	48 89 d0             	mov    %rdx,%rax
    cb8f:	4c 89 da             	mov    %r11,%rdx
    cb92:	48 09 f0             	or     %rsi,%rax
    cb95:	48 f7 f3             	div    %rbx
    cb98:	49 89 d3             	mov    %rdx,%r11
    cb9b:	48 89 c6             	mov    %rax,%rsi
    cb9e:	49 f7 e1             	mul    %r9
    cba1:	49 39 d3             	cmp    %rdx,%r11
    cba4:	0f 82 be 00 00 00    	jb     cc68 <__divti3+0x198>
    cbaa:	44 89 d1             	mov    %r10d,%ecx
    cbad:	49 d3 e0             	shl    %cl,%r8
    cbb0:	49 39 c0             	cmp    %rax,%r8
    cbb3:	73 09                	jae    cbbe <__divti3+0xee>
    cbb5:	49 39 d3             	cmp    %rdx,%r11
    cbb8:	0f 84 aa 00 00 00    	je     cc68 <__divti3+0x198>
    cbbe:	48 89 f0             	mov    %rsi,%rax
    cbc1:	31 f6                	xor    %esi,%esi
    cbc3:	e9 5b ff ff ff       	jmp    cb23 <__divti3+0x53>
    cbc8:	0f 1f 84 00 00 00 00 	nopl   0x0(%rax,%rax,1)
    cbcf:	00 
    cbd0:	4d 85 f6             	test   %r14,%r14
    cbd3:	75 0d                	jne    cbe2 <__divti3+0x112>
    cbd5:	b8 01 00 00 00       	mov    $0x1,%eax
    cbda:	31 d2                	xor    %edx,%edx
    cbdc:	49 f7 f6             	div    %r14
    cbdf:	49 89 c6             	mov    %rax,%r14
    cbe2:	48 89 f0             	mov    %rsi,%rax
    cbe5:	31 d2                	xor    %edx,%edx
    cbe7:	49 f7 f6             	div    %r14
    cbea:	48 89 c6             	mov    %rax,%rsi
    cbed:	4c 89 c0             	mov    %r8,%rax
    cbf0:	49 f7 f6             	div    %r14
    cbf3:	e9 2b ff ff ff       	jmp    cb23 <__divti3+0x53>
    cbf8:	0f 1f 84 00 00 00 00 	nopl   0x0(%rax,%rax,1)
    cbff:	00 
    cc00:	49 f7 da             	neg    %r10
    cc03:	48 f7 d7             	not    %rdi
    cc06:	49 83 d3 00          	adc    $0x0,%r11
    cc0a:	4d 89 d6             	mov    %r10,%r14
    cc0d:	49 f7 db             	neg    %r11
    cc10:	4c 89 da             	mov    %r11,%rdx
    cc13:	0f 84 f6 fe ff ff    	je     cb0f <__divti3+0x3f>
    cc19:	4c 39 de             	cmp    %r11,%rsi
    cc1c:	73 12                	jae    cc30 <__divti3+0x160>
    cc1e:	31 f6                	xor    %esi,%esi
    cc20:	31 c0                	xor    %eax,%eax
    cc22:	e9 fc fe ff ff       	jmp    cb23 <__divti3+0x53>
    cc27:	66 0f 1f 84 00 00 00 	nopw   0x0(%rax,%rax,1)
    cc2e:	00 00 
    cc30:	49 0f bd c3          	bsr    %r11,%rax
    cc34:	48 83 f0 3f          	xor    $0x3f,%rax
    cc38:	41 89 c2             	mov    %eax,%r10d
    cc3b:	85 c0                	test   %eax,%eax
    cc3d:	0f 85 0e ff ff ff    	jne    cb51 <__divti3+0x81>
    cc43:	49 39 f3             	cmp    %rsi,%r11
    cc46:	72 0d                	jb     cc55 <__divti3+0x185>
    cc48:	31 f6                	xor    %esi,%esi
    cc4a:	31 c0                	xor    %eax,%eax
    cc4c:	4d 39 f0             	cmp    %r14,%r8
    cc4f:	0f 82 ce fe ff ff    	jb     cb23 <__divti3+0x53>
    cc55:	31 f6                	xor    %esi,%esi
    cc57:	b8 01 00 00 00       	mov    $0x1,%eax
    cc5c:	e9 c2 fe ff ff       	jmp    cb23 <__divti3+0x53>
    cc61:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)
    cc68:	48 8d 46 ff          	lea    -0x1(%rsi),%rax
    cc6c:	31 f6                	xor    %esi,%esi
    cc6e:	e9 b0 fe ff ff       	jmp    cb23 <__divti3+0x53>
    cc73:	66 2e 0f 1f 84 00 00 	cs nopw 0x0(%rax,%rax,1)
    cc7a:	00 00 00 
    cc7d:	0f 1f 00             	nopl   (%rax)

000000000000cc80 <atexit>:
    cc80:	f3 0f 1e fa          	endbr64
    cc84:	48 8b 15 fd 65 00 00 	mov    0x65fd(%rip),%rdx        # 13288 <__dso_handle>
    cc8b:	31 f6                	xor    %esi,%esi
    cc8d:	e9 be 57 ff ff       	jmp    2450 <__cxa_atexit@plt>

Disassembly of section .fini:

000000000000cc94 <_fini>:
    cc94:	f3 0f 1e fa          	endbr64
    cc98:	48 83 ec 08          	sub    $0x8,%rsp
    cc9c:	48 83 c4 08          	add    $0x8,%rsp
    cca0:	c3                   	ret
