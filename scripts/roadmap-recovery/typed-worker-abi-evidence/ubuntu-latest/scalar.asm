
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
    2637:	48 8d 05 82 02 01 00 	lea    0x10282(%rip),%rax        # 128c0 <fwp_fn_table>
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
    2735:	48 8d 3d 0b b1 00 00 	lea    0xb10b(%rip),%rdi        # d847 <exec_in_fp0+0x207>
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
    27a3:	e8 68 33 00 00       	call   5b10 <fwp_stack_guard_init>
    27a8:	48 8b 05 e1 04 01 00 	mov    0x104e1(%rip),%rax        # 12c90 <exec_scripts+0x10>
    27af:	48 89 05 da 25 01 00 	mov    %rax,0x125da(%rip)        # 14d90 <fwp_cli_scripts+0x10>
    27b6:	0f 28 05 c3 04 01 00 	movaps 0x104c3(%rip),%xmm0        # 12c80 <exec_scripts>
    27bd:	0f 29 05 bc 25 01 00 	movaps %xmm0,0x125bc(%rip)        # 14d80 <fwp_cli_scripts>
    27c4:	48 8d 05 d5 ac 00 00 	lea    0xacd5(%rip),%rax        # d4a0 <exec_man>
    27cb:	48 89 05 c6 25 01 00 	mov    %rax,0x125c6(%rip)        # 14d98 <fwp_cli_man>
    27d2:	c6 05 c7 25 01 00 01 	movb   $0x1,0x125c7(%rip)        # 14da0 <fwp_cli_single>
    27d9:	8b 3d 71 25 01 00    	mov    0x12571(%rip),%edi        # 14d50 <fwp_argc>
    27df:	48 8b 35 72 25 01 00 	mov    0x12572(%rip),%rsi        # 14d58 <fwp_argv>
    27e6:	e8 05 34 00 00       	call   5bf0 <fwp_exec>
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
    281e:	48 8d 05 9b 00 01 00 	lea    0x1009b(%rip),%rax        # 128c0 <fwp_fn_table>
    2825:	48 89 05 14 25 01 00 	mov    %rax,0x12514(%rip)        # 14d40 <fwp_fns>
    282c:	f2 0f 10 05 d4 a7 00 	movsd  0xa7d4(%rip),%xmm0        # d008 <_IO_stdin_used+0x8>
    2833:	00 
    2834:	e8 07 01 00 00       	call   2940 <fwp_from_f64>
    2839:	48 89 c7             	mov    %rax,%rdi
    283c:	e8 ef 00 00 00       	call   2930 <f4>
    2841:	48 89 c3             	mov    %rax,%rbx
    2844:	f2 0f 10 05 c4 a7 00 	movsd  0xa7c4(%rip),%xmm0        # d010 <_IO_stdin_used+0x10>
    284b:	00 
    284c:	e8 ef 00 00 00       	call   2940 <fwp_from_f64>
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
    288d:	e8 ce 09 00 00       	call   3260 <fwp_gc_init>
    2892:	48 89 1d 87 1a 01 00 	mov    %rbx,0x11a87(%rip)        # 14320 <fwp_gc+0x1088>
    2899:	48 8d 3d 50 a1 00 00 	lea    0xa150(%rip),%rdi        # c9f0 <fwp_gc_find_data>
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
    28cf:	48 8d 3d fa a1 00 00 	lea    0xa1fa(%rip),%rdi        # cad0 <fwp_gc_report>
    28d6:	e8 15 a6 00 00       	call   cef0 <atexit>
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

0000000000002930 <f4>:
    2930:	50                   	push   %rax
    2931:	e8 6a 05 00 00       	call   2ea0 <fwp_f64>
    2936:	e8 d5 a3 00 00       	call   cd10 <w4>
    293b:	58                   	pop    %rax
    293c:	eb 02                	jmp    2940 <fwp_from_f64>
    293e:	66 90                	xchg   %ax,%ax

0000000000002940 <fwp_from_f64>:
    2940:	66 48 0f 7e c0       	movq   %xmm0,%rax
    2945:	c3                   	ret
    2946:	66 2e 0f 1f 84 00 00 	cs nopw 0x0(%rax,%rax,1)
    294d:	00 00 00 

0000000000002950 <e0>:
    2950:	50                   	push   %rax
    2951:	48 8b 3f             	mov    (%rdi),%rdi
    2954:	e8 e7 01 00 00       	call   2b40 <f0>
    2959:	48 89 c7             	mov    %rax,%rdi
    295c:	58                   	pop    %rax
    295d:	e9 ce 01 00 00       	jmp    2b30 <fwp_rc_shared>
    2962:	66 66 66 66 66 2e 0f 	data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    2969:	1f 84 00 00 00 00 00 

0000000000002970 <e1>:
    2970:	50                   	push   %rax
    2971:	48 8b 3f             	mov    (%rdi),%rdi
    2974:	e8 27 24 00 00       	call   4da0 <f1>
    2979:	48 89 c7             	mov    %rax,%rdi
    297c:	58                   	pop    %rax
    297d:	e9 ae 01 00 00       	jmp    2b30 <fwp_rc_shared>
    2982:	66 66 66 66 66 2e 0f 	data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    2989:	1f 84 00 00 00 00 00 

0000000000002990 <e2>:
    2990:	50                   	push   %rax
    2991:	48 8b 3f             	mov    (%rdi),%rdi
    2994:	e8 b7 24 00 00       	call   4e50 <f2>
    2999:	48 89 c7             	mov    %rax,%rdi
    299c:	58                   	pop    %rax
    299d:	e9 8e 01 00 00       	jmp    2b30 <fwp_rc_shared>
    29a2:	66 66 66 66 66 2e 0f 	data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    29a9:	1f 84 00 00 00 00 00 

00000000000029b0 <e3>:
    29b0:	50                   	push   %rax
    29b1:	48 8b 3f             	mov    (%rdi),%rdi
    29b4:	e8 27 30 00 00       	call   59e0 <f3>
    29b9:	48 89 c7             	mov    %rax,%rdi
    29bc:	58                   	pop    %rax
    29bd:	e9 6e 01 00 00       	jmp    2b30 <fwp_rc_shared>
    29c2:	66 66 66 66 66 2e 0f 	data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    29c9:	1f 84 00 00 00 00 00 

00000000000029d0 <e4>:
    29d0:	50                   	push   %rax
    29d1:	48 8b 3f             	mov    (%rdi),%rdi
    29d4:	e8 57 ff ff ff       	call   2930 <f4>
    29d9:	48 89 c7             	mov    %rax,%rdi
    29dc:	58                   	pop    %rax
    29dd:	e9 4e 01 00 00       	jmp    2b30 <fwp_rc_shared>
    29e2:	66 66 66 66 66 2e 0f 	data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    29e9:	1f 84 00 00 00 00 00 

00000000000029f0 <e6>:
    29f0:	50                   	push   %rax
    29f1:	48 8b 07             	mov    (%rdi),%rax
    29f4:	48 8b 77 08          	mov    0x8(%rdi),%rsi
    29f8:	48 89 c7             	mov    %rax,%rdi
    29fb:	e8 c0 30 00 00       	call   5ac0 <f6>
    2a00:	48 89 c7             	mov    %rax,%rdi
    2a03:	58                   	pop    %rax
    2a04:	e9 27 01 00 00       	jmp    2b30 <fwp_rc_shared>
    2a09:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)

0000000000002a10 <e10>:
    2a10:	50                   	push   %rax
    2a11:	48 8b 3f             	mov    (%rdi),%rdi
    2a14:	e8 d7 30 00 00       	call   5af0 <f10>
    2a19:	48 89 c7             	mov    %rax,%rdi
    2a1c:	58                   	pop    %rax
    2a1d:	e9 0e 01 00 00       	jmp    2b30 <fwp_rc_shared>
    2a22:	66 66 66 66 66 2e 0f 	data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    2a29:	1f 84 00 00 00 00 00 

0000000000002a30 <e12>:
    2a30:	50                   	push   %rax
    2a31:	48 8b 07             	mov    (%rdi),%rax
    2a34:	48 8b 77 08          	mov    0x8(%rdi),%rsi
    2a38:	48 89 c7             	mov    %rax,%rdi
    2a3b:	e8 b0 28 00 00       	call   52f0 <f12>
    2a40:	48 89 c7             	mov    %rax,%rdi
    2a43:	58                   	pop    %rax
    2a44:	e9 e7 00 00 00       	jmp    2b30 <fwp_rc_shared>
    2a49:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)

0000000000002a50 <e14>:
    2a50:	50                   	push   %rax
    2a51:	48 8b 07             	mov    (%rdi),%rax
    2a54:	48 8b 77 08          	mov    0x8(%rdi),%rsi
    2a58:	48 89 c7             	mov    %rax,%rdi
    2a5b:	e8 b0 28 00 00       	call   5310 <f14>
    2a60:	48 89 c7             	mov    %rax,%rdi
    2a63:	58                   	pop    %rax
    2a64:	e9 c7 00 00 00       	jmp    2b30 <fwp_rc_shared>
    2a69:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)

0000000000002a70 <e16>:
    2a70:	50                   	push   %rax
    2a71:	48 8b 07             	mov    (%rdi),%rax
    2a74:	48 8b 77 08          	mov    0x8(%rdi),%rsi
    2a78:	48 89 c7             	mov    %rax,%rdi
    2a7b:	e8 c0 28 00 00       	call   5340 <f16>
    2a80:	48 89 c7             	mov    %rax,%rdi
    2a83:	58                   	pop    %rax
    2a84:	e9 a7 00 00 00       	jmp    2b30 <fwp_rc_shared>
    2a89:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)

0000000000002a90 <e18>:
    2a90:	50                   	push   %rax
    2a91:	48 8b 07             	mov    (%rdi),%rax
    2a94:	48 8b 77 08          	mov    0x8(%rdi),%rsi
    2a98:	48 89 c7             	mov    %rax,%rdi
    2a9b:	e8 d0 28 00 00       	call   5370 <f18>
    2aa0:	48 89 c7             	mov    %rax,%rdi
    2aa3:	58                   	pop    %rax
    2aa4:	e9 87 00 00 00       	jmp    2b30 <fwp_rc_shared>
    2aa9:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)

0000000000002ab0 <e20>:
    2ab0:	50                   	push   %rax
    2ab1:	48 8b 07             	mov    (%rdi),%rax
    2ab4:	48 8b 77 08          	mov    0x8(%rdi),%rsi
    2ab8:	48 89 c7             	mov    %rax,%rdi
    2abb:	e8 f0 28 00 00       	call   53b0 <f20>
    2ac0:	48 89 c7             	mov    %rax,%rdi
    2ac3:	58                   	pop    %rax
    2ac4:	eb 6a                	jmp    2b30 <fwp_rc_shared>
    2ac6:	66 2e 0f 1f 84 00 00 	cs nopw 0x0(%rax,%rax,1)
    2acd:	00 00 00 

0000000000002ad0 <e22>:
    2ad0:	50                   	push   %rax
    2ad1:	48 8b 07             	mov    (%rdi),%rax
    2ad4:	48 8b 77 08          	mov    0x8(%rdi),%rsi
    2ad8:	48 89 c7             	mov    %rax,%rdi
    2adb:	e8 20 29 00 00       	call   5400 <f22>
    2ae0:	48 89 c7             	mov    %rax,%rdi
    2ae3:	58                   	pop    %rax
    2ae4:	eb 4a                	jmp    2b30 <fwp_rc_shared>
    2ae6:	66 2e 0f 1f 84 00 00 	cs nopw 0x0(%rax,%rax,1)
    2aed:	00 00 00 

0000000000002af0 <e24>:
    2af0:	50                   	push   %rax
    2af1:	48 8b 07             	mov    (%rdi),%rax
    2af4:	48 8b 77 08          	mov    0x8(%rdi),%rsi
    2af8:	48 89 c7             	mov    %rax,%rdi
    2afb:	e8 50 29 00 00       	call   5450 <f24>
    2b00:	48 89 c7             	mov    %rax,%rdi
    2b03:	58                   	pop    %rax
    2b04:	eb 2a                	jmp    2b30 <fwp_rc_shared>
    2b06:	66 2e 0f 1f 84 00 00 	cs nopw 0x0(%rax,%rax,1)
    2b0d:	00 00 00 

0000000000002b10 <e26>:
    2b10:	50                   	push   %rax
    2b11:	48 8b 07             	mov    (%rdi),%rax
    2b14:	48 8b 77 08          	mov    0x8(%rdi),%rsi
    2b18:	48 89 c7             	mov    %rax,%rdi
    2b1b:	e8 90 29 00 00       	call   54b0 <f26>
    2b20:	48 89 c7             	mov    %rax,%rdi
    2b23:	58                   	pop    %rax
    2b24:	eb 0a                	jmp    2b30 <fwp_rc_shared>
    2b26:	66 2e 0f 1f 84 00 00 	cs nopw 0x0(%rax,%rax,1)
    2b2d:	00 00 00 

0000000000002b30 <fwp_rc_shared>:
    2b30:	53                   	push   %rbx
    2b31:	48 89 fb             	mov    %rdi,%rbx
    2b34:	e8 77 00 00 00       	call   2bb0 <fwp_rc_share>
    2b39:	48 89 d8             	mov    %rbx,%rax
    2b3c:	5b                   	pop    %rbx
    2b3d:	c3                   	ret
    2b3e:	66 90                	xchg   %ax,%ax

0000000000002b40 <f0>:
    2b40:	53                   	push   %rbx
    2b41:	48 83 ec 30          	sub    $0x30,%rsp
    2b45:	e8 56 03 00 00       	call   2ea0 <fwp_f64>
    2b4a:	48 8d 7c 24 18       	lea    0x18(%rsp),%rdi
    2b4f:	e8 1c 03 00 00       	call   2e70 <w0>
    2b54:	f2 0f 10 44 24 18    	movsd  0x18(%rsp),%xmm0
    2b5a:	e8 e1 fd ff ff       	call   2940 <fwp_from_f64>
    2b5f:	48 89 04 24          	mov    %rax,(%rsp)
    2b63:	f2 0f 10 44 24 20    	movsd  0x20(%rsp),%xmm0
    2b69:	e8 d2 fd ff ff       	call   2940 <fwp_from_f64>
    2b6e:	48 89 44 24 08       	mov    %rax,0x8(%rsp)
    2b73:	f2 0f 10 44 24 28    	movsd  0x28(%rsp),%xmm0
    2b79:	e8 c2 fd ff ff       	call   2940 <fwp_from_f64>
    2b7e:	48 89 44 24 10       	mov    %rax,0x10(%rsp)
    2b83:	48 89 e6             	mov    %rsp,%rsi
    2b86:	bf 03 00 00 00       	mov    $0x3,%edi
    2b8b:	e8 60 03 00 00       	call   2ef0 <fwp_record>
    2b90:	48 89 c3             	mov    %rax,%rbx
    2b93:	48 89 c7             	mov    %rax,%rdi
    2b96:	e8 15 03 00 00       	call   2eb0 <fwp_rc_fresh>
    2b9b:	48 89 d8             	mov    %rbx,%rax
    2b9e:	48 83 c4 30          	add    $0x30,%rsp
    2ba2:	5b                   	pop    %rbx
    2ba3:	c3                   	ret
    2ba4:	66 66 66 2e 0f 1f 84 	data16 data16 cs nopw 0x0(%rax,%rax,1)
    2bab:	00 00 00 00 00 

0000000000002bb0 <fwp_rc_share>:
    2bb0:	41 57                	push   %r15
    2bb2:	41 56                	push   %r14
    2bb4:	41 55                	push   %r13
    2bb6:	41 54                	push   %r12
    2bb8:	53                   	push   %rbx
    2bb9:	48 81 ec 00 02 00 00 	sub    $0x200,%rsp
    2bc0:	48 89 fb             	mov    %rdi,%rbx
    2bc3:	e8 08 01 00 00       	call   2cd0 <fwp_rc_slot>
    2bc8:	48 85 c0             	test   %rax,%rax
    2bcb:	0f 84 ec 00 00 00    	je     2cbd <fwp_rc_share+0x10d>
    2bd1:	80 38 00             	cmpb   $0x0,(%rax)
    2bd4:	0f 84 e3 00 00 00    	je     2cbd <fwp_rc_share+0x10d>
    2bda:	48 89 c7             	mov    %rax,%rdi
    2bdd:	e8 5e 01 00 00       	call   2d40 <fwp_rc_clear_slot>
    2be2:	48 89 1c 24          	mov    %rbx,(%rsp)
    2be6:	41 be 01 00 00 00    	mov    $0x1,%r14d
    2bec:	eb 0b                	jmp    2bf9 <fwp_rc_share+0x49>
    2bee:	66 90                	xchg   %ax,%ax
    2bf0:	4d 85 f6             	test   %r14,%r14
    2bf3:	0f 84 c4 00 00 00    	je     2cbd <fwp_rc_share+0x10d>
    2bf9:	4e 8b 7c f4 f8       	mov    -0x8(%rsp,%r14,8),%r15
    2bfe:	49 ff ce             	dec    %r14
    2c01:	4c 89 ff             	mov    %r15,%rdi
    2c04:	48 2b 3d bd 16 01 00 	sub    0x116bd(%rip),%rdi        # 142c8 <fwp_gc+0x1030>
    2c0b:	48 c1 ef 10          	shr    $0x10,%rdi
    2c0f:	48 8b 05 fa 16 01 00 	mov    0x116fa(%rip),%rax        # 14310 <fwp_gc+0x1078>
    2c16:	48 69 cf 28 12 00 00 	imul   $0x1228,%rdi,%rcx
    2c1d:	80 7c 08 01 01       	cmpb   $0x1,0x1(%rax,%rcx,1)
    2c22:	74 cc                	je     2bf0 <fwp_rc_share+0x40>
    2c24:	0f b6 14 08          	movzbl (%rax,%rcx,1),%edx
    2c28:	80 fa 02             	cmp    $0x2,%dl
    2c2b:	75 13                	jne    2c40 <fwp_rc_share+0x90>
    2c2d:	4c 8b 64 08 18       	mov    0x18(%rax,%rcx,1),%r12
    2c32:	eb 33                	jmp    2c67 <fwp_rc_share+0xb7>
    2c34:	66 66 66 2e 0f 1f 84 	data16 data16 cs nopw 0x0(%rax,%rax,1)
    2c3b:	00 00 00 00 00 
    2c40:	44 8b 64 08 08       	mov    0x8(%rax,%rcx,1),%r12d
    2c45:	80 fa 01             	cmp    $0x1,%dl
    2c48:	75 1d                	jne    2c67 <fwp_rc_share+0xb7>
    2c4a:	41 0f b7 d7          	movzwl %r15w,%edx
    2c4e:	44 8b 7c 08 20       	mov    0x20(%rax,%rcx,1),%r15d
    2c53:	4c 0f af fa          	imul   %rdx,%r15
    2c57:	49 c1 ef 20          	shr    $0x20,%r15
    2c5b:	e8 00 01 00 00       	call   2d60 <fwp_gc_chunk_addr>
    2c60:	4d 0f af fc          	imul   %r12,%r15
    2c64:	49 01 c7             	add    %rax,%r15
    2c67:	49 83 fc 08          	cmp    $0x8,%r12
    2c6b:	72 83                	jb     2bf0 <fwp_rc_share+0x40>
    2c6d:	49 c1 ec 03          	shr    $0x3,%r12
    2c71:	45 31 ed             	xor    %r13d,%r13d
    2c74:	eb 16                	jmp    2c8c <fwp_rc_share+0xdc>
    2c76:	48 89 df             	mov    %rbx,%rdi
    2c79:	e8 32 ff ff ff       	call   2bb0 <fwp_rc_share>
    2c7e:	66 90                	xchg   %ax,%ax
    2c80:	49 ff c5             	inc    %r13
    2c83:	4d 39 ec             	cmp    %r13,%r12
    2c86:	0f 84 64 ff ff ff    	je     2bf0 <fwp_rc_share+0x40>
    2c8c:	4b 8b 1c ef          	mov    (%r15,%r13,8),%rbx
    2c90:	48 89 df             	mov    %rbx,%rdi
    2c93:	e8 38 00 00 00       	call   2cd0 <fwp_rc_slot>
    2c98:	48 85 c0             	test   %rax,%rax
    2c9b:	74 e3                	je     2c80 <fwp_rc_share+0xd0>
    2c9d:	80 38 00             	cmpb   $0x0,(%rax)
    2ca0:	74 de                	je     2c80 <fwp_rc_share+0xd0>
    2ca2:	49 83 fe 3f          	cmp    $0x3f,%r14
    2ca6:	77 ce                	ja     2c76 <fwp_rc_share+0xc6>
    2ca8:	48 89 c7             	mov    %rax,%rdi
    2cab:	e8 90 00 00 00       	call   2d40 <fwp_rc_clear_slot>
    2cb0:	4b 8b 04 ef          	mov    (%r15,%r13,8),%rax
    2cb4:	4a 89 04 f4          	mov    %rax,(%rsp,%r14,8)
    2cb8:	49 ff c6             	inc    %r14
    2cbb:	eb c3                	jmp    2c80 <fwp_rc_share+0xd0>
    2cbd:	48 81 c4 00 02 00 00 	add    $0x200,%rsp
    2cc4:	5b                   	pop    %rbx
    2cc5:	41 5c                	pop    %r12
    2cc7:	41 5d                	pop    %r13
    2cc9:	41 5e                	pop    %r14
    2ccb:	41 5f                	pop    %r15
    2ccd:	c3                   	ret
    2cce:	66 90                	xchg   %ax,%ax

0000000000002cd0 <fwp_rc_slot>:
    2cd0:	48 2b 3d f1 15 01 00 	sub    0x115f1(%rip),%rdi        # 142c8 <fwp_gc+0x1030>
    2cd7:	48 8b 05 12 16 01 00 	mov    0x11612(%rip),%rax        # 142f0 <fwp_gc+0x1058>
    2cde:	48 c1 e0 10          	shl    $0x10,%rax
    2ce2:	48 39 c7             	cmp    %rax,%rdi
    2ce5:	73 51                	jae    2d38 <fwp_rc_slot+0x68>
    2ce7:	48 8b 05 22 16 01 00 	mov    0x11622(%rip),%rax        # 14310 <fwp_gc+0x1078>
    2cee:	48 89 f9             	mov    %rdi,%rcx
    2cf1:	48 c1 e9 10          	shr    $0x10,%rcx
    2cf5:	48 69 c9 28 12 00 00 	imul   $0x1228,%rcx,%rcx
    2cfc:	0f b6 14 08          	movzbl (%rax,%rcx,1),%edx
    2d00:	48 81 e7 ff ff 00 00 	and    $0xffff,%rdi
    2d07:	75 0f                	jne    2d18 <fwp_rc_slot+0x48>
    2d09:	80 fa 02             	cmp    $0x2,%dl
    2d0c:	75 0a                	jne    2d18 <fwp_rc_slot+0x48>
    2d0e:	48 01 c8             	add    %rcx,%rax
    2d11:	48 05 28 02 00 00    	add    $0x228,%rax
    2d17:	c3                   	ret
    2d18:	80 fa 01             	cmp    $0x1,%dl
    2d1b:	75 1b                	jne    2d38 <fwp_rc_slot+0x68>
    2d1d:	48 8d 14 08          	lea    (%rax,%rcx,1),%rdx
    2d21:	8b 44 08 20          	mov    0x20(%rax,%rcx,1),%eax
    2d25:	48 0f af f8          	imul   %rax,%rdi
    2d29:	48 c1 ef 20          	shr    $0x20,%rdi
    2d2d:	48 8d 04 17          	lea    (%rdi,%rdx,1),%rax
    2d31:	48 05 28 02 00 00    	add    $0x228,%rax
    2d37:	c3                   	ret
    2d38:	31 c0                	xor    %eax,%eax
    2d3a:	c3                   	ret
    2d3b:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)

0000000000002d40 <fwp_rc_clear_slot>:
    2d40:	80 3f ff             	cmpb   $0xff,(%rdi)
    2d43:	74 04                	je     2d49 <fwp_rc_clear_slot+0x9>
    2d45:	c6 07 00             	movb   $0x0,(%rdi)
    2d48:	c3                   	ret
    2d49:	53                   	push   %rbx
    2d4a:	48 89 fb             	mov    %rdi,%rbx
    2d4d:	e8 1e 00 00 00       	call   2d70 <fwp_rc_forget_slot>
    2d52:	48 89 df             	mov    %rbx,%rdi
    2d55:	5b                   	pop    %rbx
    2d56:	c6 07 00             	movb   $0x0,(%rdi)
    2d59:	c3                   	ret
    2d5a:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)

0000000000002d60 <fwp_gc_chunk_addr>:
    2d60:	48 89 f8             	mov    %rdi,%rax
    2d63:	48 c1 e0 10          	shl    $0x10,%rax
    2d67:	48 03 05 5a 15 01 00 	add    0x1155a(%rip),%rax        # 142c8 <fwp_gc+0x1030>
    2d6e:	c3                   	ret
    2d6f:	90                   	nop

0000000000002d70 <fwp_rc_forget_slot>:
    2d70:	50                   	push   %rax
    2d71:	80 3f ff             	cmpb   $0xff,(%rdi)
    2d74:	74 02                	je     2d78 <fwp_rc_forget_slot+0x8>
    2d76:	58                   	pop    %rax
    2d77:	c3                   	ret
    2d78:	e8 33 00 00 00       	call   2db0 <fwp_rc_wide_link>
    2d7d:	48 8b 38             	mov    (%rax),%rdi
    2d80:	48 85 ff             	test   %rdi,%rdi
    2d83:	74 15                	je     2d9a <fwp_rc_forget_slot+0x2a>
    2d85:	48 8b 4f 10          	mov    0x10(%rdi),%rcx
    2d89:	48 89 08             	mov    %rcx,(%rax)
    2d8c:	e8 bf f2 ff ff       	call   2050 <free@plt>
    2d91:	48 ff 0d 18 1f 01 00 	decq   0x11f18(%rip)        # 14cb0 <fwp_gc+0x1a18>
    2d98:	58                   	pop    %rax
    2d99:	c3                   	ret
    2d9a:	48 8d 3d 50 a9 00 00 	lea    0xa950(%rip),%rdi        # d6f1 <exec_in_fp0+0xb1>
    2da1:	e8 6a 00 00 00       	call   2e10 <fwp_trap>
    2da6:	66 2e 0f 1f 84 00 00 	cs nopw 0x0(%rax,%rax,1)
    2dad:	00 00 00 

0000000000002db0 <fwp_rc_wide_link>:
    2db0:	48 89 f8             	mov    %rdi,%rax
    2db3:	48 c1 e8 11          	shr    $0x11,%rax
    2db7:	31 f8                	xor    %edi,%eax
    2db9:	89 c1                	mov    %eax,%ecx
    2dbb:	c1 e9 09             	shr    $0x9,%ecx
    2dbe:	31 c1                	xor    %eax,%ecx
    2dc0:	0f b6 c9             	movzbl %cl,%ecx
    2dc3:	48 8d 15 ce 04 01 00 	lea    0x104ce(%rip),%rdx        # 13298 <fwp_gc>
    2dca:	48 8d 04 ca          	lea    (%rdx,%rcx,8),%rax
    2dce:	48 05 18 12 00 00    	add    $0x1218,%rax
    2dd4:	48 8b 8c ca 18 12 00 	mov    0x1218(%rdx,%rcx,8),%rcx
    2ddb:	00 
    2ddc:	48 85 c9             	test   %rcx,%rcx
    2ddf:	74 24                	je     2e05 <fwp_rc_wide_link+0x55>
    2de1:	48 39 39             	cmp    %rdi,(%rcx)
    2de4:	74 1f                	je     2e05 <fwp_rc_wide_link+0x55>
    2de6:	66 2e 0f 1f 84 00 00 	cs nopw 0x0(%rax,%rax,1)
    2ded:	00 00 00 
    2df0:	48 89 c8             	mov    %rcx,%rax
    2df3:	48 8b 49 10          	mov    0x10(%rcx),%rcx
    2df7:	48 85 c9             	test   %rcx,%rcx
    2dfa:	74 05                	je     2e01 <fwp_rc_wide_link+0x51>
    2dfc:	48 39 39             	cmp    %rdi,(%rcx)
    2dff:	75 ef                	jne    2df0 <fwp_rc_wide_link+0x40>
    2e01:	48 83 c0 10          	add    $0x10,%rax
    2e05:	c3                   	ret
    2e06:	66 2e 0f 1f 84 00 00 	cs nopw 0x0(%rax,%rax,1)
    2e0d:	00 00 00 

0000000000002e10 <fwp_trap>:
    2e10:	53                   	push   %rbx
    2e11:	48 89 fb             	mov    %rdi,%rbx
    2e14:	e8 27 00 00 00       	call   2e40 <fwp_flush>
    2e19:	48 8b 05 b8 01 01 00 	mov    0x101b8(%rip),%rax        # 12fd8 <stderr@GLIBC_2.2.5>
    2e20:	48 8b 38             	mov    (%rax),%rdi
    2e23:	48 8d 35 ee a8 00 00 	lea    0xa8ee(%rip),%rsi        # d718 <exec_in_fp0+0xd8>
    2e2a:	48 89 da             	mov    %rbx,%rdx
    2e2d:	31 c0                	xor    %eax,%eax
    2e2f:	e8 bc f4 ff ff       	call   22f0 <fprintf@plt>
    2e34:	bf 65 00 00 00       	mov    $0x65,%edi
    2e39:	e8 42 f6 ff ff       	call   2480 <exit@plt>
    2e3e:	66 90                	xchg   %ax,%ax

0000000000002e40 <fwp_flush>:
    2e40:	50                   	push   %rax
    2e41:	48 8b 3d 00 1f 01 00 	mov    0x11f00(%rip),%rdi        # 14d48 <fwp_prog_out>
    2e48:	48 85 ff             	test   %rdi,%rdi
    2e4b:	74 05                	je     2e52 <fwp_flush+0x12>
    2e4d:	e8 fe f4 ff ff       	call   2350 <fflush@plt>
    2e52:	48 8b 05 57 01 01 00 	mov    0x10157(%rip),%rax        # 12fb0 <stdout@GLIBC_2.2.5>
    2e59:	48 8b 38             	mov    (%rax),%rdi
    2e5c:	58                   	pop    %rax
    2e5d:	e9 ee f4 ff ff       	jmp    2350 <fflush@plt>
    2e62:	66 66 66 66 66 2e 0f 	data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    2e69:	1f 84 00 00 00 00 00 

0000000000002e70 <w0>:
    2e70:	53                   	push   %rbx
    2e71:	48 89 fb             	mov    %rdi,%rbx
    2e74:	e8 c7 fa ff ff       	call   2940 <fwp_from_f64>
    2e79:	48 89 c7             	mov    %rax,%rdi
    2e7c:	e8 1f 00 00 00       	call   2ea0 <fwp_f64>
    2e81:	f2 0f 11 03          	movsd  %xmm0,(%rbx)
    2e85:	f2 0f 11 43 08       	movsd  %xmm0,0x8(%rbx)
    2e8a:	f2 0f 11 43 10       	movsd  %xmm0,0x10(%rbx)
    2e8f:	48 89 d8             	mov    %rbx,%rax
    2e92:	5b                   	pop    %rbx
    2e93:	c3                   	ret
    2e94:	66 66 66 2e 0f 1f 84 	data16 data16 cs nopw 0x0(%rax,%rax,1)
    2e9b:	00 00 00 00 00 

0000000000002ea0 <fwp_f64>:
    2ea0:	66 48 0f 6e c7       	movq   %rdi,%xmm0
    2ea5:	c3                   	ret
    2ea6:	66 2e 0f 1f 84 00 00 	cs nopw 0x0(%rax,%rax,1)
    2ead:	00 00 00 

0000000000002eb0 <fwp_rc_fresh>:
    2eb0:	41 56                	push   %r14
    2eb2:	53                   	push   %rbx
    2eb3:	50                   	push   %rax
    2eb4:	48 89 fb             	mov    %rdi,%rbx
    2eb7:	e8 14 fe ff ff       	call   2cd0 <fwp_rc_slot>
    2ebc:	48 85 c0             	test   %rax,%rax
    2ebf:	74 08                	je     2ec9 <fwp_rc_fresh+0x19>
    2ec1:	80 38 ff             	cmpb   $0xff,(%rax)
    2ec4:	74 0e                	je     2ed4 <fwp_rc_fresh+0x24>
    2ec6:	c6 00 01             	movb   $0x1,(%rax)
    2ec9:	48 89 d8             	mov    %rbx,%rax
    2ecc:	48 83 c4 08          	add    $0x8,%rsp
    2ed0:	5b                   	pop    %rbx
    2ed1:	41 5e                	pop    %r14
    2ed3:	c3                   	ret
    2ed4:	48 89 c7             	mov    %rax,%rdi
    2ed7:	49 89 c6             	mov    %rax,%r14
    2eda:	e8 91 fe ff ff       	call   2d70 <fwp_rc_forget_slot>
    2edf:	4c 89 f0             	mov    %r14,%rax
    2ee2:	eb e2                	jmp    2ec6 <fwp_rc_fresh+0x16>
    2ee4:	66 66 66 2e 0f 1f 84 	data16 data16 cs nopw 0x0(%rax,%rax,1)
    2eeb:	00 00 00 00 00 

0000000000002ef0 <fwp_record>:
    2ef0:	85 ff                	test   %edi,%edi
    2ef2:	74 09                	je     2efd <fwp_record+0xd>
    2ef4:	48 89 f2             	mov    %rsi,%rdx
    2ef7:	89 fe                	mov    %edi,%esi
    2ef9:	31 ff                	xor    %edi,%edi
    2efb:	eb 03                	jmp    2f00 <fwp_data>
    2efd:	31 c0                	xor    %eax,%eax
    2eff:	c3                   	ret

0000000000002f00 <fwp_data>:
    2f00:	55                   	push   %rbp
    2f01:	41 57                	push   %r15
    2f03:	41 56                	push   %r14
    2f05:	53                   	push   %rbx
    2f06:	50                   	push   %rax
    2f07:	89 fd                	mov    %edi,%ebp
    2f09:	85 f6                	test   %esi,%esi
    2f0b:	0f 84 a1 00 00 00    	je     2fb2 <fwp_data+0xb2>
    2f11:	48 89 d3             	mov    %rdx,%rbx
    2f14:	41 89 f6             	mov    %esi,%r14d
    2f17:	4a 8d 3c f5 08 00 00 	lea    0x8(,%r14,8),%rdi
    2f1e:	00 
    2f1f:	41 89 f7             	mov    %esi,%r15d
    2f22:	e8 d9 00 00 00       	call   3000 <fwp_alloc_init>
    2f27:	89 28                	mov    %ebp,(%rax)
    2f29:	44 89 78 04          	mov    %r15d,0x4(%rax)
    2f2d:	41 83 ff 08          	cmp    $0x8,%r15d
    2f31:	72 10                	jb     2f43 <fwp_data+0x43>
    2f33:	48 89 c1             	mov    %rax,%rcx
    2f36:	48 29 d9             	sub    %rbx,%rcx
    2f39:	48 83 c1 08          	add    $0x8,%rcx
    2f3d:	48 83 f9 20          	cmp    $0x20,%rcx
    2f41:	73 73                	jae    2fb6 <fwp_data+0xb6>
    2f43:	31 c9                	xor    %ecx,%ecx
    2f45:	4c 89 f6             	mov    %r14,%rsi
    2f48:	48 89 ca             	mov    %rcx,%rdx
    2f4b:	48 83 e6 03          	and    $0x3,%rsi
    2f4f:	74 20                	je     2f71 <fwp_data+0x71>
    2f51:	48 89 ca             	mov    %rcx,%rdx
    2f54:	66 66 66 2e 0f 1f 84 	data16 data16 cs nopw 0x0(%rax,%rax,1)
    2f5b:	00 00 00 00 00 
    2f60:	48 8b 3c d3          	mov    (%rbx,%rdx,8),%rdi
    2f64:	48 89 7c d0 08       	mov    %rdi,0x8(%rax,%rdx,8)
    2f69:	48 ff c2             	inc    %rdx
    2f6c:	48 ff ce             	dec    %rsi
    2f6f:	75 ef                	jne    2f60 <fwp_data+0x60>
    2f71:	4c 29 f1             	sub    %r14,%rcx
    2f74:	48 83 f9 fc          	cmp    $0xfffffffffffffffc,%rcx
    2f78:	77 7b                	ja     2ff5 <fwp_data+0xf5>
    2f7a:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)
    2f80:	48 8b 0c d3          	mov    (%rbx,%rdx,8),%rcx
    2f84:	48 89 4c d0 08       	mov    %rcx,0x8(%rax,%rdx,8)
    2f89:	48 8b 4c d3 08       	mov    0x8(%rbx,%rdx,8),%rcx
    2f8e:	48 89 4c d0 10       	mov    %rcx,0x10(%rax,%rdx,8)
    2f93:	48 8b 4c d3 10       	mov    0x10(%rbx,%rdx,8),%rcx
    2f98:	48 89 4c d0 18       	mov    %rcx,0x18(%rax,%rdx,8)
    2f9d:	48 8b 4c d3 18       	mov    0x18(%rbx,%rdx,8),%rcx
    2fa2:	48 89 4c d0 20       	mov    %rcx,0x20(%rax,%rdx,8)
    2fa7:	48 83 c2 04          	add    $0x4,%rdx
    2fab:	49 39 d6             	cmp    %rdx,%r14
    2fae:	75 d0                	jne    2f80 <fwp_data+0x80>
    2fb0:	eb 43                	jmp    2ff5 <fwp_data+0xf5>
    2fb2:	89 e8                	mov    %ebp,%eax
    2fb4:	eb 3f                	jmp    2ff5 <fwp_data+0xf5>
    2fb6:	44 89 f1             	mov    %r14d,%ecx
    2fb9:	83 e1 fc             	and    $0xfffffffc,%ecx
    2fbc:	4a 8d 14 f5 00 00 00 	lea    0x0(,%r14,8),%rdx
    2fc3:	00 
    2fc4:	48 83 e2 e0          	and    $0xffffffffffffffe0,%rdx
    2fc8:	31 f6                	xor    %esi,%esi
    2fca:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)
    2fd0:	0f 10 04 33          	movups (%rbx,%rsi,1),%xmm0
    2fd4:	0f 10 4c 33 10       	movups 0x10(%rbx,%rsi,1),%xmm1
    2fd9:	0f 11 44 30 08       	movups %xmm0,0x8(%rax,%rsi,1)
    2fde:	0f 11 4c 30 18       	movups %xmm1,0x18(%rax,%rsi,1)
    2fe3:	48 83 c6 20          	add    $0x20,%rsi
    2fe7:	48 39 f2             	cmp    %rsi,%rdx
    2fea:	75 e4                	jne    2fd0 <fwp_data+0xd0>
    2fec:	4c 39 f1             	cmp    %r14,%rcx
    2fef:	0f 85 50 ff ff ff    	jne    2f45 <fwp_data+0x45>
    2ff5:	48 83 c4 08          	add    $0x8,%rsp
    2ff9:	5b                   	pop    %rbx
    2ffa:	41 5e                	pop    %r14
    2ffc:	41 5f                	pop    %r15
    2ffe:	5d                   	pop    %rbp
    2fff:	c3                   	ret

0000000000003000 <fwp_alloc_init>:
    3000:	53                   	push   %rbx
    3001:	48 89 fa             	mov    %rdi,%rdx
    3004:	48 81 ff 00 40 00 00 	cmp    $0x4000,%rdi
    300b:	0f 87 a7 00 00 00    	ja     30b8 <fwp_alloc_init+0xb8>
    3011:	48 8d 42 0f          	lea    0xf(%rdx),%rax
    3015:	48 c1 e8 04          	shr    $0x4,%rax
    3019:	48 8d 35 78 02 01 00 	lea    0x10278(%rip),%rsi        # 13298 <fwp_gc>
    3020:	0f b6 bc 30 e8 0b 00 	movzbl 0xbe8(%rax,%rsi,1),%edi
    3027:	00 
    3028:	8b 84 be 48 0b 00 00 	mov    0xb48(%rsi,%rdi,4),%eax
    302f:	48 8b 0d 62 02 01 00 	mov    0x10262(%rip),%rcx        # 13298 <fwp_gc>
    3036:	49 89 c8             	mov    %rcx,%r8
    3039:	49 29 c0             	sub    %rax,%r8
    303c:	4c 89 05 55 02 01 00 	mov    %r8,0x10255(%rip)        # 13298 <fwp_gc>
    3043:	78 6c                	js     30b1 <fwp_alloc_init+0xb1>
    3045:	48 8d 3c 7f          	lea    (%rdi,%rdi,2),%rdi
    3049:	4c 8d 04 fe          	lea    (%rsi,%rdi,8),%r8
    304d:	49 83 c0 08          	add    $0x8,%r8
    3051:	49 8b 18             	mov    (%r8),%rbx
    3054:	48 85 db             	test   %rbx,%rbx
    3057:	74 32                	je     308b <fwp_alloc_init+0x8b>
    3059:	48 8b 0b             	mov    (%rbx),%rcx
    305c:	48 f7 d1             	not    %rcx
    305f:	49 89 08             	mov    %rcx,(%r8)
    3062:	81 e2 f8 7f 00 00    	and    $0x7ff8,%edx
    3068:	48 39 c2             	cmp    %rax,%rdx
    306b:	73 19                	jae    3086 <fwp_alloc_init+0x86>
    306d:	48 8d 3c 13          	lea    (%rbx,%rdx,1),%rdi
    3071:	48 f7 d2             	not    %rdx
    3074:	48 01 c2             	add    %rax,%rdx
    3077:	48 83 e2 f8          	and    $0xfffffffffffffff8,%rdx
    307b:	48 83 c2 08          	add    $0x8,%rdx
    307f:	31 f6                	xor    %esi,%esi
    3081:	e8 8a f1 ff ff       	call   2210 <memset@plt>
    3086:	48 89 d8             	mov    %rbx,%rax
    3089:	5b                   	pop    %rbx
    308a:	c3                   	ret
    308b:	48 8b 5c fe 10       	mov    0x10(%rsi,%rdi,8),%rbx
    3090:	4c 8b 44 fe 18       	mov    0x18(%rsi,%rdi,8),%r8
    3095:	49 29 d8             	sub    %rbx,%r8
    3098:	49 39 c0             	cmp    %rax,%r8
    309b:	72 14                	jb     30b1 <fwp_alloc_init+0xb1>
    309d:	48 8d 34 fe          	lea    (%rsi,%rdi,8),%rsi
    30a1:	48 83 c6 10          	add    $0x10,%rsi
    30a5:	48 8d 3c 03          	lea    (%rbx,%rax,1),%rdi
    30a9:	48 89 3e             	mov    %rdi,(%rsi)
    30ac:	48 85 db             	test   %rbx,%rbx
    30af:	75 b1                	jne    3062 <fwp_alloc_init+0x62>
    30b1:	48 89 0d e0 01 01 00 	mov    %rcx,0x101e0(%rip)        # 13298 <fwp_gc>
    30b8:	48 89 d7             	mov    %rdx,%rdi
    30bb:	31 f6                	xor    %esi,%esi
    30bd:	5b                   	pop    %rbx
    30be:	eb 00                	jmp    30c0 <fwp_gc_alloc>

00000000000030c0 <fwp_gc_alloc>:
    30c0:	53                   	push   %rbx
    30c1:	48 81 ff 00 40 00 00 	cmp    $0x4000,%rdi
    30c8:	77 6c                	ja     3136 <fwp_gc_alloc+0x76>
    30ca:	48 8d 4f 0f          	lea    0xf(%rdi),%rcx
    30ce:	48 c1 e9 04          	shr    $0x4,%rcx
    30d2:	48 8d 05 bf 01 01 00 	lea    0x101bf(%rip),%rax        # 13298 <fwp_gc>
    30d9:	0f b6 8c 01 e8 0b 00 	movzbl 0xbe8(%rcx,%rax,1),%ecx
    30e0:	00 
    30e1:	8b 94 88 48 0b 00 00 	mov    0xb48(%rax,%rcx,4),%edx
    30e8:	48 29 15 a9 01 01 00 	sub    %rdx,0x101a9(%rip)        # 13298 <fwp_gc>
    30ef:	78 45                	js     3136 <fwp_gc_alloc+0x76>
    30f1:	41 89 f0             	mov    %esi,%r8d
    30f4:	4d 69 c0 c0 03 00 00 	imul   $0x3c0,%r8,%r8
    30fb:	4c 01 c0             	add    %r8,%rax
    30fe:	48 8d 0c 49          	lea    (%rcx,%rcx,2),%rcx
    3102:	4c 8d 04 c8          	lea    (%rax,%rcx,8),%r8
    3106:	49 83 c0 08          	add    $0x8,%r8
    310a:	49 8b 18             	mov    (%r8),%rbx
    310d:	48 85 db             	test   %rbx,%rbx
    3110:	74 12                	je     3124 <fwp_gc_alloc+0x64>
    3112:	48 8b 03             	mov    (%rbx),%rax
    3115:	48 f7 d0             	not    %rax
    3118:	49 89 00             	mov    %rax,(%r8)
    311b:	83 fe 01             	cmp    $0x1,%esi
    311e:	48 0f 44 d7          	cmove  %rdi,%rdx
    3122:	eb 2e                	jmp    3152 <fwp_gc_alloc+0x92>
    3124:	48 8b 5c c8 10       	mov    0x10(%rax,%rcx,8),%rbx
    3129:	4c 8b 44 c8 18       	mov    0x18(%rax,%rcx,8),%r8
    312e:	49 29 d8             	sub    %rbx,%r8
    3131:	49 39 d0             	cmp    %rdx,%r8
    3134:	73 03                	jae    3139 <fwp_gc_alloc+0x79>
    3136:	5b                   	pop    %rbx
    3137:	eb 37                	jmp    3170 <fwp_gc_alloc_slow>
    3139:	48 8d 04 c8          	lea    (%rax,%rcx,8),%rax
    313d:	48 83 c0 10          	add    $0x10,%rax
    3141:	48 8d 0c 13          	lea    (%rbx,%rdx,1),%rcx
    3145:	48 89 08             	mov    %rcx,(%rax)
    3148:	83 fe 01             	cmp    $0x1,%esi
    314b:	48 0f 45 fa          	cmovne %rdx,%rdi
    314f:	48 89 fa             	mov    %rdi,%rdx
    3152:	48 89 df             	mov    %rbx,%rdi
    3155:	31 f6                	xor    %esi,%esi
    3157:	e8 b4 f0 ff ff       	call   2210 <memset@plt>
    315c:	48 89 d8             	mov    %rbx,%rax
    315f:	5b                   	pop    %rbx
    3160:	c3                   	ret
    3161:	66 66 66 66 66 66 2e 	data16 data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    3168:	0f 1f 84 00 00 00 00 
    316f:	00 

0000000000003170 <fwp_gc_alloc_slow>:
    3170:	55                   	push   %rbp
    3171:	41 57                	push   %r15
    3173:	41 56                	push   %r14
    3175:	41 54                	push   %r12
    3177:	53                   	push   %rbx
    3178:	89 f5                	mov    %esi,%ebp
    317a:	48 89 fb             	mov    %rdi,%rbx
    317d:	83 3d 00 11 01 00 00 	cmpl   $0x0,0x11100(%rip)        # 14284 <fwp_gc+0xfec>
    3184:	74 1b                	je     31a1 <fwp_gc_alloc_slow+0x31>
    3186:	48 81 fb 01 40 00 00 	cmp    $0x4001,%rbx
    318d:	72 20                	jb     31af <fwp_gc_alloc_slow+0x3f>
    318f:	48 89 df             	mov    %rbx,%rdi
    3192:	89 ee                	mov    %ebp,%esi
    3194:	5b                   	pop    %rbx
    3195:	41 5c                	pop    %r12
    3197:	41 5e                	pop    %r14
    3199:	41 5f                	pop    %r15
    319b:	5d                   	pop    %rbp
    319c:	e9 9f 03 00 00       	jmp    3540 <fwp_gc_alloc_big>
    31a1:	e8 ba 00 00 00       	call   3260 <fwp_gc_init>
    31a6:	48 81 fb 01 40 00 00 	cmp    $0x4001,%rbx
    31ad:	73 e0                	jae    318f <fwp_gc_alloc_slow+0x1f>
    31af:	48 8d 43 0f          	lea    0xf(%rbx),%rax
    31b3:	48 c1 e8 04          	shr    $0x4,%rax
    31b7:	4c 8d 25 da 00 01 00 	lea    0x100da(%rip),%r12        # 13298 <fwp_gc>
    31be:	46 0f b6 bc 20 e8 0b 	movzbl 0xbe8(%rax,%r12,1),%r15d
    31c5:	00 00 
    31c7:	47 8b b4 bc 48 0b 00 	mov    0xb48(%r12,%r15,4),%r14d
    31ce:	00 
    31cf:	48 83 3d c1 00 01 00 	cmpq   $0x0,0x100c1(%rip)        # 13298 <fwp_gc>
    31d6:	00 
    31d7:	79 05                	jns    31de <fwp_gc_alloc_slow+0x6e>
    31d9:	e8 b2 04 00 00       	call   3690 <fwp_gc_spent>
    31de:	89 e8                	mov    %ebp,%eax
    31e0:	48 69 c0 c0 03 00 00 	imul   $0x3c0,%rax,%rax
    31e7:	49 01 c4             	add    %rax,%r12
    31ea:	4b 8d 0c 7f          	lea    (%r15,%r15,2),%rcx
    31ee:	49 8d 04 cc          	lea    (%r12,%rcx,8),%rax
    31f2:	48 83 c0 08          	add    $0x8,%rax
    31f6:	49 8b 7c cc 08       	mov    0x8(%r12,%rcx,8),%rdi
    31fb:	48 85 ff             	test   %rdi,%rdi
    31fe:	74 08                	je     3208 <fwp_gc_alloc_slow+0x98>
    3200:	48 8b 0f             	mov    (%rdi),%rcx
    3203:	48 f7 d1             	not    %rcx
    3206:	eb 30                	jmp    3238 <fwp_gc_alloc_slow+0xc8>
    3208:	49 8b 7c cc 10       	mov    0x10(%r12,%rcx,8),%rdi
    320d:	49 8b 54 cc 18       	mov    0x18(%r12,%rcx,8),%rdx
    3212:	48 29 fa             	sub    %rdi,%rdx
    3215:	4c 39 f2             	cmp    %r14,%rdx
    3218:	73 12                	jae    322c <fwp_gc_alloc_slow+0xbc>
    321a:	48 89 c7             	mov    %rax,%rdi
    321d:	44 89 fe             	mov    %r15d,%esi
    3220:	89 ea                	mov    %ebp,%edx
    3222:	e8 39 05 00 00       	call   3760 <fwp_gc_refill>
    3227:	48 89 c7             	mov    %rax,%rdi
    322a:	eb 0f                	jmp    323b <fwp_gc_alloc_slow+0xcb>
    322c:	49 8d 04 cc          	lea    (%r12,%rcx,8),%rax
    3230:	48 83 c0 10          	add    $0x10,%rax
    3234:	4a 8d 0c 37          	lea    (%rdi,%r14,1),%rcx
    3238:	48 89 08             	mov    %rcx,(%rax)
    323b:	83 fd 01             	cmp    $0x1,%ebp
    323e:	4c 0f 44 f3          	cmove  %rbx,%r14
    3242:	31 f6                	xor    %esi,%esi
    3244:	4c 89 f2             	mov    %r14,%rdx
    3247:	5b                   	pop    %rbx
    3248:	41 5c                	pop    %r12
    324a:	41 5e                	pop    %r14
    324c:	41 5f                	pop    %r15
    324e:	5d                   	pop    %rbp
    324f:	e9 bc ef ff ff       	jmp    2210 <memset@plt>
    3254:	66 66 66 2e 0f 1f 84 	data16 data16 cs nopw 0x0(%rax,%rax,1)
    325b:	00 00 00 00 00 

0000000000003260 <fwp_gc_init>:
    3260:	53                   	push   %rbx
    3261:	48 83 ec 10          	sub    $0x10,%rsp
    3265:	c7 05 15 10 01 00 01 	movl   $0x1,0x11015(%rip)        # 14284 <fwp_gc+0xfec>
    326c:	00 00 00 
    326f:	0f 28 05 da 9d 00 00 	movaps 0x9dda(%rip),%xmm0        # d050 <_IO_stdin_used+0x50>
    3276:	0f 11 05 63 0b 01 00 	movups %xmm0,0x10b63(%rip)        # 13de0 <fwp_gc+0xb48>
    327d:	0f 28 05 dc 9d 00 00 	movaps 0x9ddc(%rip),%xmm0        # d060 <_IO_stdin_used+0x60>
    3284:	0f 11 05 65 0b 01 00 	movups %xmm0,0x10b65(%rip)        # 13df0 <fwp_gc+0xb58>
    328b:	0f 28 05 de 9d 00 00 	movaps 0x9dde(%rip),%xmm0        # d070 <_IO_stdin_used+0x70>
    3292:	0f 11 05 67 0b 01 00 	movups %xmm0,0x10b67(%rip)        # 13e00 <fwp_gc+0xb68>
    3299:	0f 28 05 e0 9d 00 00 	movaps 0x9de0(%rip),%xmm0        # d080 <_IO_stdin_used+0x80>
    32a0:	0f 11 05 69 0b 01 00 	movups %xmm0,0x10b69(%rip)        # 13e10 <fwp_gc+0xb78>
    32a7:	0f 28 05 e2 9d 00 00 	movaps 0x9de2(%rip),%xmm0        # d090 <_IO_stdin_used+0x90>
    32ae:	0f 11 05 6b 0b 01 00 	movups %xmm0,0x10b6b(%rip)        # 13e20 <fwp_gc+0xb88>
    32b5:	0f 28 05 e4 9d 00 00 	movaps 0x9de4(%rip),%xmm0        # d0a0 <_IO_stdin_used+0xa0>
    32bc:	0f 11 05 6d 0b 01 00 	movups %xmm0,0x10b6d(%rip)        # 13e30 <fwp_gc+0xb98>
    32c3:	0f 28 05 e6 9d 00 00 	movaps 0x9de6(%rip),%xmm0        # d0b0 <_IO_stdin_used+0xb0>
    32ca:	0f 11 05 6f 0b 01 00 	movups %xmm0,0x10b6f(%rip)        # 13e40 <fwp_gc+0xba8>
    32d1:	0f 28 05 e8 9d 00 00 	movaps 0x9de8(%rip),%xmm0        # d0c0 <_IO_stdin_used+0xc0>
    32d8:	0f 11 05 71 0b 01 00 	movups %xmm0,0x10b71(%rip)        # 13e50 <fwp_gc+0xbb8>
    32df:	0f 28 05 ea 9d 00 00 	movaps 0x9dea(%rip),%xmm0        # d0d0 <_IO_stdin_used+0xd0>
    32e6:	0f 11 05 73 0b 01 00 	movups %xmm0,0x10b73(%rip)        # 13e60 <fwp_gc+0xbc8>
    32ed:	0f 28 05 ec 9d 00 00 	movaps 0x9dec(%rip),%xmm0        # d0e0 <_IO_stdin_used+0xe0>
    32f4:	0f 11 05 75 0b 01 00 	movups %xmm0,0x10b75(%rip)        # 13e70 <fwp_gc+0xbd8>
    32fb:	31 c9                	xor    %ecx,%ecx
    32fd:	48 8d 05 94 ff 00 00 	lea    0xff94(%rip),%rax        # 13298 <fwp_gc>
    3304:	31 d2                	xor    %edx,%edx
    3306:	66 2e 0f 1f 84 00 00 	cs nopw 0x0(%rax,%rax,1)
    330d:	00 00 00 
    3310:	89 d6                	mov    %edx,%esi
    3312:	c1 e6 04             	shl    $0x4,%esi
    3315:	48 ff c9             	dec    %rcx
    3318:	48 89 cf             	mov    %rcx,%rdi
    331b:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)
    3320:	48 89 f9             	mov    %rdi,%rcx
    3323:	48 ff c7             	inc    %rdi
    3326:	3b b4 88 4c 0b 00 00 	cmp    0xb4c(%rax,%rcx,4),%esi
    332d:	77 f1                	ja     3320 <fwp_gc_init+0xc0>
    332f:	40 88 bc 02 e8 0b 00 	mov    %dil,0xbe8(%rdx,%rax,1)
    3336:	00 
    3337:	48 89 d6             	mov    %rdx,%rsi
    333a:	48 83 ce 01          	or     $0x1,%rsi
    333e:	48 81 fe 01 04 00 00 	cmp    $0x401,%rsi
    3345:	74 26                	je     336d <fwp_gc_init+0x10d>
    3347:	89 f7                	mov    %esi,%edi
    3349:	c1 e7 04             	shl    $0x4,%edi
    334c:	0f 1f 40 00          	nopl   0x0(%rax)
    3350:	49 89 c8             	mov    %rcx,%r8
    3353:	48 ff c1             	inc    %rcx
    3356:	42 3b bc 80 4c 0b 00 	cmp    0xb4c(%rax,%r8,4),%edi
    335d:	00 
    335e:	77 f0                	ja     3350 <fwp_gc_init+0xf0>
    3360:	88 8c 06 e8 0b 00 00 	mov    %cl,0xbe8(%rsi,%rax,1)
    3367:	48 83 c2 02          	add    $0x2,%rdx
    336b:	eb a3                	jmp    3310 <fwp_gc_init+0xb0>
    336d:	48 b8 00 00 00 00 10 	movabs $0x1000000000,%rax
    3374:	00 00 00 
    3377:	48 89 44 24 08       	mov    %rax,0x8(%rsp)
    337c:	48 8d 7c 24 08       	lea    0x8(%rsp),%rdi
    3381:	e8 ba 04 00 00       	call   3840 <fwp_gc_reserve>
    3386:	48 85 c0             	test   %rax,%rax
    3389:	0f 84 ab 01 00 00    	je     353a <fwp_gc_init+0x2da>
    338f:	48 89 05 3a 0f 01 00 	mov    %rax,0x10f3a(%rip)        # 142d0 <fwp_gc+0x1038>
    3396:	48 8b 4c 24 08       	mov    0x8(%rsp),%rcx
    339b:	48 8d 91 00 00 01 00 	lea    0x10000(%rcx),%rdx
    33a2:	48 89 15 2f 0f 01 00 	mov    %rdx,0x10f2f(%rip)        # 142d8 <fwp_gc+0x1040>
    33a9:	48 05 ff ff 00 00    	add    $0xffff,%rax
    33af:	48 25 00 00 ff ff    	and    $0xffffffffffff0000,%rax
    33b5:	48 89 05 0c 0f 01 00 	mov    %rax,0x10f0c(%rip)        # 142c8 <fwp_gc+0x1030>
    33bc:	48 c1 e9 10          	shr    $0x10,%rcx
    33c0:	48 89 0d 21 0f 01 00 	mov    %rcx,0x10f21(%rip)        # 142e8 <fwp_gc+0x1050>
    33c7:	48 69 f1 28 12 00 00 	imul   $0x1228,%rcx,%rsi
    33ce:	48 89 35 43 0f 01 00 	mov    %rsi,0x10f43(%rip)        # 14318 <fwp_gc+0x1080>
    33d5:	31 ff                	xor    %edi,%edi
    33d7:	31 d2                	xor    %edx,%edx
    33d9:	b9 22 40 00 00       	mov    $0x4022,%ecx
    33de:	41 b8 ff ff ff ff    	mov    $0xffffffff,%r8d
    33e4:	45 31 c9             	xor    %r9d,%r9d
    33e7:	e8 a4 ed ff ff       	call   2190 <mmap@plt>
    33ec:	48 83 f8 ff          	cmp    $0xffffffffffffffff,%rax
    33f0:	0f 84 44 01 00 00    	je     353a <fwp_gc_init+0x2da>
    33f6:	48 89 05 13 0f 01 00 	mov    %rax,0x10f13(%rip)        # 14310 <fwp_gc+0x1078>
    33fd:	48 8d 3d 23 a3 00 00 	lea    0xa323(%rip),%rdi        # d727 <exec_in_fp0+0xe7>
    3404:	e8 27 ec ff ff       	call   2030 <getenv@plt>
    3409:	48 85 c0             	test   %rax,%rax
    340c:	74 2e                	je     343c <fwp_gc_init+0x1dc>
    340e:	48 89 c3             	mov    %rax,%rbx
    3411:	48 8d 35 16 a3 00 00 	lea    0xa316(%rip),%rsi        # d72e <exec_in_fp0+0xee>
    3418:	48 89 c7             	mov    %rax,%rdi
    341b:	e8 b0 ee ff ff       	call   22d0 <strcmp@plt>
    3420:	85 c0                	test   %eax,%eax
    3422:	74 1f                	je     3443 <fwp_gc_init+0x1e3>
    3424:	48 8d 35 3d af 00 00 	lea    0xaf3d(%rip),%rsi        # e368 <exec_in_fp0+0xd28>
    342b:	48 89 df             	mov    %rbx,%rdi
    342e:	e8 9d ee ff ff       	call   22d0 <strcmp@plt>
    3433:	31 c9                	xor    %ecx,%ecx
    3435:	85 c0                	test   %eax,%eax
    3437:	0f 95 c1             	setne  %cl
    343a:	eb 09                	jmp    3445 <fwp_gc_init+0x1e5>
    343c:	b9 01 00 00 00       	mov    $0x1,%ecx
    3441:	eb 02                	jmp    3445 <fwp_gc_init+0x1e5>
    3443:	31 c9                	xor    %ecx,%ecx
    3445:	89 0d 3d 0e 01 00    	mov    %ecx,0x10e3d(%rip)        # 14288 <fwp_gc+0xff0>
    344b:	48 8d 3d e0 a2 00 00 	lea    0xa2e0(%rip),%rdi        # d732 <exec_in_fp0+0xf2>
    3452:	e8 d9 eb ff ff       	call   2030 <getenv@plt>
    3457:	31 c9                	xor    %ecx,%ecx
    3459:	48 85 c0             	test   %rax,%rax
    345c:	74 1b                	je     3479 <fwp_gc_init+0x219>
    345e:	80 38 00             	cmpb   $0x0,(%rax)
    3461:	74 16                	je     3479 <fwp_gc_init+0x219>
    3463:	48 8d 35 fe ae 00 00 	lea    0xaefe(%rip),%rsi        # e368 <exec_in_fp0+0xd28>
    346a:	48 89 c7             	mov    %rax,%rdi
    346d:	e8 5e ee ff ff       	call   22d0 <strcmp@plt>
    3472:	31 c9                	xor    %ecx,%ecx
    3474:	85 c0                	test   %eax,%eax
    3476:	0f 95 c1             	setne  %cl
    3479:	89 0d 15 0e 01 00    	mov    %ecx,0x10e15(%rip)        # 14294 <fwp_gc+0xffc>
    347f:	48 8d 3d a1 a2 00 00 	lea    0xa2a1(%rip),%rdi        # d727 <exec_in_fp0+0xe7>
    3486:	e8 a5 eb ff ff       	call   2030 <getenv@plt>
    348b:	48 85 c0             	test   %rax,%rax
    348e:	74 18                	je     34a8 <fwp_gc_init+0x248>
    3490:	48 8d 35 a8 a2 00 00 	lea    0xa2a8(%rip),%rsi        # d73f <exec_in_fp0+0xff>
    3497:	48 89 c7             	mov    %rax,%rdi
    349a:	e8 31 ee ff ff       	call   22d0 <strcmp@plt>
    349f:	31 c9                	xor    %ecx,%ecx
    34a1:	85 c0                	test   %eax,%eax
    34a3:	0f 95 c1             	setne  %cl
    34a6:	eb 05                	jmp    34ad <fwp_gc_init+0x24d>
    34a8:	b9 01 00 00 00       	mov    $0x1,%ecx
    34ad:	89 0d e5 0d 01 00    	mov    %ecx,0x10de5(%rip)        # 14298 <fwp_gc+0x1000>
    34b3:	c7 05 e3 0d 01 00 01 	movl   $0x1,0x10de3(%rip)        # 142a0 <fwp_gc+0x1008>
    34ba:	00 00 00 
    34bd:	48 8d 3d 80 a2 00 00 	lea    0xa280(%rip),%rdi        # d744 <exec_in_fp0+0x104>
    34c4:	e8 67 eb ff ff       	call   2030 <getenv@plt>
    34c9:	31 c9                	xor    %ecx,%ecx
    34cb:	48 85 c0             	test   %rax,%rax
    34ce:	74 1b                	je     34eb <fwp_gc_init+0x28b>
    34d0:	80 38 00             	cmpb   $0x0,(%rax)
    34d3:	74 16                	je     34eb <fwp_gc_init+0x28b>
    34d5:	48 8d 35 8c ae 00 00 	lea    0xae8c(%rip),%rsi        # e368 <exec_in_fp0+0xd28>
    34dc:	48 89 c7             	mov    %rax,%rdi
    34df:	e8 ec ed ff ff       	call   22d0 <strcmp@plt>
    34e4:	31 c9                	xor    %ecx,%ecx
    34e6:	85 c0                	test   %eax,%eax
    34e8:	0f 95 c1             	setne  %cl
    34eb:	89 0d ab 0d 01 00    	mov    %ecx,0x10dab(%rip)        # 1429c <fwp_gc+0x1004>
    34f1:	48 8d 3d 5a a2 00 00 	lea    0xa25a(%rip),%rdi        # d752 <exec_in_fp0+0x112>
    34f8:	e8 33 eb ff ff       	call   2030 <getenv@plt>
    34fd:	48 85 c0             	test   %rax,%rax
    3500:	74 0a                	je     350c <fwp_gc_init+0x2ac>
    3502:	48 89 c7             	mov    %rax,%rdi
    3505:	e8 f6 ee ff ff       	call   2400 <atol@plt>
    350a:	eb 02                	jmp    350e <fwp_gc_init+0x2ae>
    350c:	31 c0                	xor    %eax,%eax
    350e:	31 c9                	xor    %ecx,%ecx
    3510:	48 85 c0             	test   %rax,%rax
    3513:	48 0f 4f c8          	cmovg  %rax,%rcx
    3517:	48 89 0d 9a 0d 01 00 	mov    %rcx,0x10d9a(%rip)        # 142b8 <fwp_gc+0x1020>
    351e:	48 c7 05 7f 0f 01 00 	movq   $0x800000,0x10f7f(%rip)        # 144a8 <fwp_gc+0x1210>
    3525:	00 00 80 00 
    3529:	48 c7 05 64 fd 00 00 	movq   $0x800000,0xfd64(%rip)        # 13298 <fwp_gc>
    3530:	00 00 80 00 
    3534:	48 83 c4 10          	add    $0x10,%rsp
    3538:	5b                   	pop    %rbx
    3539:	c3                   	ret
    353a:	e8 71 03 00 00       	call   38b0 <fwp_gc_oom>
    353f:	90                   	nop

0000000000003540 <fwp_gc_alloc_big>:
    3540:	55                   	push   %rbp
    3541:	41 57                	push   %r15
    3543:	41 56                	push   %r14
    3545:	41 54                	push   %r12
    3547:	53                   	push   %rbx
    3548:	48 b8 01 00 00 00 00 	movabs $0x4000000000000001,%rax
    354f:	00 00 40 
    3552:	48 39 c7             	cmp    %rax,%rdi
    3555:	0f 83 28 01 00 00    	jae    3683 <fwp_gc_alloc_big+0x143>
    355b:	89 f5                	mov    %esi,%ebp
    355d:	48 89 fb             	mov    %rdi,%rbx
    3560:	48 29 3d 31 fd 00 00 	sub    %rdi,0xfd31(%rip)        # 13298 <fwp_gc>
    3567:	79 05                	jns    356e <fwp_gc_alloc_big+0x2e>
    3569:	e8 22 01 00 00       	call   3690 <fwp_gc_spent>
    356e:	4c 8d bb ff ff 00 00 	lea    0xffff(%rbx),%r15
    3575:	49 c1 ef 10          	shr    $0x10,%r15
    3579:	4c 89 ff             	mov    %r15,%rdi
    357c:	e8 5f 03 00 00       	call   38e0 <fwp_gc_chunks>
    3581:	49 89 c6             	mov    %rax,%r14
    3584:	48 8b 05 85 0d 01 00 	mov    0x10d85(%rip),%rax        # 14310 <fwp_gc+0x1078>
    358b:	4d 69 e6 28 12 00 00 	imul   $0x1228,%r14,%r12
    3592:	42 c6 04 20 02       	movb   $0x2,(%rax,%r12,1)
    3597:	42 88 6c 20 01       	mov    %bpl,0x1(%rax,%r12,1)
    359c:	66 42 c7 44 20 03 00 	movw   $0x100,0x3(%rax,%r12,1)
    35a3:	01 
    35a4:	46 89 7c 20 10       	mov    %r15d,0x10(%rax,%r12,1)
    35a9:	4a 89 5c 20 18       	mov    %rbx,0x18(%rax,%r12,1)
    35ae:	4a 8d 3c 20          	lea    (%rax,%r12,1),%rdi
    35b2:	48 81 c7 28 02 00 00 	add    $0x228,%rdi
    35b9:	e8 82 f7 ff ff       	call   2d40 <fwp_rc_clear_slot>
    35be:	48 81 fb 01 00 01 00 	cmp    $0x10001,%rbx
    35c5:	0f 82 9b 00 00 00    	jb     3666 <fwp_gc_alloc_big+0x126>
    35cb:	49 83 ff 03          	cmp    $0x3,%r15
    35cf:	b9 02 00 00 00       	mov    $0x2,%ecx
    35d4:	49 0f 43 cf          	cmovae %r15,%rcx
    35d8:	48 8b 05 31 0d 01 00 	mov    0x10d31(%rip),%rax        # 14310 <fwp_gc+0x1078>
    35df:	48 ff c9             	dec    %rcx
    35e2:	ba 01 00 00 00       	mov    $0x1,%edx
    35e7:	48 81 fb 01 00 02 00 	cmp    $0x20001,%rbx
    35ee:	72 59                	jb     3649 <fwp_gc_alloc_big+0x109>
    35f0:	49 8d 34 04          	lea    (%r12,%rax,1),%rsi
    35f4:	48 81 c6 60 24 00 00 	add    $0x2460,%rsi
    35fb:	48 89 cf             	mov    %rcx,%rdi
    35fe:	48 83 e7 fe          	and    $0xfffffffffffffffe,%rdi
    3602:	48 f7 df             	neg    %rdi
    3605:	66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
    360c:	00 00 00 00 
    3610:	c6 86 c8 ed ff ff 03 	movb   $0x3,-0x1238(%rsi)
    3617:	c6 86 cc ed ff ff 01 	movb   $0x1,-0x1234(%rsi)
    361e:	44 89 b6 d8 ed ff ff 	mov    %r14d,-0x1228(%rsi)
    3625:	c6 46 f0 03          	movb   $0x3,-0x10(%rsi)
    3629:	c6 46 f4 01          	movb   $0x1,-0xc(%rsi)
    362d:	44 89 36             	mov    %r14d,(%rsi)
    3630:	48 81 c6 50 24 00 00 	add    $0x2450,%rsi
    3637:	4c 8d 04 17          	lea    (%rdi,%rdx,1),%r8
    363b:	49 83 c0 02          	add    $0x2,%r8
    363f:	48 83 c2 02          	add    $0x2,%rdx
    3643:	49 83 f8 01          	cmp    $0x1,%r8
    3647:	75 c7                	jne    3610 <fwp_gc_alloc_big+0xd0>
    3649:	f6 c1 01             	test   $0x1,%cl
    364c:	74 18                	je     3666 <fwp_gc_alloc_big+0x126>
    364e:	4c 01 e0             	add    %r12,%rax
    3651:	48 69 ca 28 12 00 00 	imul   $0x1228,%rdx,%rcx
    3658:	c6 04 08 03          	movb   $0x3,(%rax,%rcx,1)
    365c:	c6 44 08 04 01       	movb   $0x1,0x4(%rax,%rcx,1)
    3661:	44 89 74 08 10       	mov    %r14d,0x10(%rax,%rcx,1)
    3666:	4c 89 f7             	mov    %r14,%rdi
    3669:	e8 f2 f6 ff ff       	call   2d60 <fwp_gc_chunk_addr>
    366e:	48 89 c7             	mov    %rax,%rdi
    3671:	31 f6                	xor    %esi,%esi
    3673:	48 89 da             	mov    %rbx,%rdx
    3676:	5b                   	pop    %rbx
    3677:	41 5c                	pop    %r12
    3679:	41 5e                	pop    %r14
    367b:	41 5f                	pop    %r15
    367d:	5d                   	pop    %rbp
    367e:	e9 8d eb ff ff       	jmp    2210 <memset@plt>
    3683:	e8 28 02 00 00       	call   38b0 <fwp_gc_oom>
    3688:	0f 1f 84 00 00 00 00 	nopl   0x0(%rax,%rax,1)
    368f:	00 

0000000000003690 <fwp_gc_spent>:
    3690:	50                   	push   %rax
    3691:	83 3d ec 0b 01 00 00 	cmpl   $0x0,0x10bec(%rip)        # 14284 <fwp_gc+0xfec>
    3698:	75 05                	jne    369f <fwp_gc_spent+0xf>
    369a:	e8 c1 fb ff ff       	call   3260 <fwp_gc_init>
    369f:	8b 05 e7 0b 01 00    	mov    0x10be7(%rip),%eax        # 1428c <fwp_gc+0xff4>
    36a5:	85 c0                	test   %eax,%eax
    36a7:	74 6d                	je     3716 <fwp_gc_spent+0x86>
    36a9:	48 8b 0d 08 0c 01 00 	mov    0x10c08(%rip),%rcx        # 142b8 <fwp_gc+0x1020>
    36b0:	48 85 c9             	test   %rcx,%rcx
    36b3:	74 61                	je     3716 <fwp_gc_spent+0x86>
    36b5:	48 8b 05 04 0c 01 00 	mov    0x10c04(%rip),%rax        # 142c0 <fwp_gc+0x1028>
    36bc:	48 ff c0             	inc    %rax
    36bf:	48 89 05 fa 0b 01 00 	mov    %rax,0x10bfa(%rip)        # 142c0 <fwp_gc+0x1028>
    36c6:	48 39 c8             	cmp    %rcx,%rax
    36c9:	7c 10                	jl     36db <fwp_gc_spent+0x4b>
    36cb:	48 c7 05 ea 0b 01 00 	movq   $0x0,0x10bea(%rip)        # 142c0 <fwp_gc+0x1028>
    36d2:	00 00 00 00 
    36d6:	e8 85 03 00 00       	call   3a60 <fwp_gc_collect>
    36db:	48 8b 05 c6 0d 01 00 	mov    0x10dc6(%rip),%rax        # 144a8 <fwp_gc+0x1210>
    36e2:	48 2b 05 af fb 00 00 	sub    0xfbaf(%rip),%rax        # 13298 <fwp_gc>
    36e9:	f2 48 0f 2a c0       	cvtsi2sd %rax,%xmm0
    36ee:	f2 0f 58 05 8a 0d 01 	addsd  0x10d8a(%rip),%xmm0        # 14480 <fwp_gc+0x11e8>
    36f5:	00 
    36f6:	f2 0f 11 05 82 0d 01 	movsd  %xmm0,0x10d82(%rip)        # 14480 <fwp_gc+0x11e8>
    36fd:	00 
    36fe:	48 c7 05 9f 0d 01 00 	movq   $0x0,0x10d9f(%rip)        # 144a8 <fwp_gc+0x1210>
    3705:	00 00 00 00 
    3709:	48 c7 05 84 fb 00 00 	movq   $0x0,0xfb84(%rip)        # 13298 <fwp_gc>
    3710:	00 00 00 00 
    3714:	58                   	pop    %rax
    3715:	c3                   	ret
    3716:	85 c0                	test   %eax,%eax
    3718:	74 06                	je     3720 <fwp_gc_spent+0x90>
    371a:	58                   	pop    %rax
    371b:	e9 40 03 00 00       	jmp    3a60 <fwp_gc_collect>
    3720:	48 8b 05 81 0d 01 00 	mov    0x10d81(%rip),%rax        # 144a8 <fwp_gc+0x1210>
    3727:	48 2b 05 6a fb 00 00 	sub    0xfb6a(%rip),%rax        # 13298 <fwp_gc>
    372e:	f2 48 0f 2a c0       	cvtsi2sd %rax,%xmm0
    3733:	f2 0f 58 05 45 0d 01 	addsd  0x10d45(%rip),%xmm0        # 14480 <fwp_gc+0x11e8>
    373a:	00 
    373b:	f2 0f 11 05 3d 0d 01 	movsd  %xmm0,0x10d3d(%rip)        # 14480 <fwp_gc+0x11e8>
    3742:	00 
    3743:	48 c7 05 5a 0d 01 00 	movq   $0x800000,0x10d5a(%rip)        # 144a8 <fwp_gc+0x1210>
    374a:	00 00 80 00 
    374e:	48 c7 05 3f fb 00 00 	movq   $0x800000,0xfb3f(%rip)        # 13298 <fwp_gc>
    3755:	00 00 80 00 
    3759:	58                   	pop    %rax
    375a:	c3                   	ret
    375b:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)

0000000000003760 <fwp_gc_refill>:
    3760:	55                   	push   %rbp
    3761:	41 57                	push   %r15
    3763:	41 56                	push   %r14
    3765:	53                   	push   %rbx
    3766:	50                   	push   %rax
    3767:	89 d5                	mov    %edx,%ebp
    3769:	41 89 f7             	mov    %esi,%r15d
    376c:	48 89 fb             	mov    %rdi,%rbx
    376f:	bf 01 00 00 00       	mov    $0x1,%edi
    3774:	e8 67 01 00 00       	call   38e0 <fwp_gc_chunks>
    3779:	49 89 c6             	mov    %rax,%r14
    377c:	48 8b 0d 8d 0b 01 00 	mov    0x10b8d(%rip),%rcx        # 14310 <fwp_gc+0x1078>
    3783:	48 8d 05 0e fb 00 00 	lea    0xfb0e(%rip),%rax        # 13298 <fwp_gc>
    378a:	49 69 f6 28 12 00 00 	imul   $0x1228,%r14,%rsi
    3791:	48 8d 3c 31          	lea    (%rcx,%rsi,1),%rdi
    3795:	c6 04 31 01          	movb   $0x1,(%rcx,%rsi,1)
    3799:	40 88 6c 31 01       	mov    %bpl,0x1(%rcx,%rsi,1)
    379e:	44 88 7c 31 02       	mov    %r15b,0x2(%rcx,%rsi,1)
    37a3:	c6 44 31 04 01       	movb   $0x1,0x4(%rcx,%rsi,1)
    37a8:	44 89 fa             	mov    %r15d,%edx
    37ab:	44 8b 84 90 48 0b 00 	mov    0xb48(%rax,%rdx,4),%r8d
    37b2:	00 
    37b3:	44 89 44 31 08       	mov    %r8d,0x8(%rcx,%rsi,1)
    37b8:	b8 00 00 01 00       	mov    $0x10000,%eax
    37bd:	31 d2                	xor    %edx,%edx
    37bf:	41 f7 f0             	div    %r8d
    37c2:	89 44 31 0c          	mov    %eax,0xc(%rcx,%rsi,1)
    37c6:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    37cb:	4c 01 c0             	add    %r8,%rax
    37ce:	48 0f ba e0 20       	bt     $0x20,%rax
    37d3:	73 07                	jae    37dc <fwp_gc_refill+0x7c>
    37d5:	31 d2                	xor    %edx,%edx
    37d7:	49 f7 f0             	div    %r8
    37da:	eb 05                	jmp    37e1 <fwp_gc_refill+0x81>
    37dc:	31 d2                	xor    %edx,%edx
    37de:	41 f7 f0             	div    %r8d
    37e1:	4c 8d 3c 31          	lea    (%rcx,%rsi,1),%r15
    37e5:	49 83 c7 08          	add    $0x8,%r15
    37e9:	89 44 31 20          	mov    %eax,0x20(%rcx,%rsi,1)
    37ed:	e8 4e 15 00 00       	call   4d40 <fwp_rc_clear_chunk>
    37f2:	4c 89 f7             	mov    %r14,%rdi
    37f5:	e8 66 f5 ff ff       	call   2d60 <fwp_gc_chunk_addr>
    37fa:	83 3d 9b 0a 01 00 00 	cmpl   $0x0,0x10a9b(%rip)        # 1429c <fwp_gc+0x1004>
    3801:	74 15                	je     3818 <fwp_gc_refill+0xb8>
    3803:	ba 00 00 01 00       	mov    $0x10000,%edx
    3808:	48 89 c7             	mov    %rax,%rdi
    380b:	31 f6                	xor    %esi,%esi
    380d:	49 89 c6             	mov    %rax,%r14
    3810:	e8 fb e9 ff ff       	call   2210 <memset@plt>
    3815:	4c 89 f0             	mov    %r14,%rax
    3818:	41 8b 0f             	mov    (%r15),%ecx
    381b:	48 8d 14 08          	lea    (%rax,%rcx,1),%rdx
    381f:	48 89 53 08          	mov    %rdx,0x8(%rbx)
    3823:	41 8b 57 04          	mov    0x4(%r15),%edx
    3827:	48 0f af d1          	imul   %rcx,%rdx
    382b:	48 01 c2             	add    %rax,%rdx
    382e:	48 89 53 10          	mov    %rdx,0x10(%rbx)
    3832:	48 83 c4 08          	add    $0x8,%rsp
    3836:	5b                   	pop    %rbx
    3837:	41 5e                	pop    %r14
    3839:	41 5f                	pop    %r15
    383b:	5d                   	pop    %rbp
    383c:	c3                   	ret
    383d:	0f 1f 00             	nopl   (%rax)

0000000000003840 <fwp_gc_reserve>:
    3840:	41 56                	push   %r14
    3842:	53                   	push   %rbx
    3843:	50                   	push   %rax
    3844:	4c 8b 37             	mov    (%rdi),%r14
    3847:	49 81 fe 00 00 00 10 	cmp    $0x10000000,%r14
    384e:	72 47                	jb     3897 <fwp_gc_reserve+0x57>
    3850:	48 89 fb             	mov    %rdi,%rbx
    3853:	66 66 66 66 2e 0f 1f 	data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    385a:	84 00 00 00 00 00 
    3860:	49 8d b6 00 00 01 00 	lea    0x10000(%r14),%rsi
    3867:	31 ff                	xor    %edi,%edi
    3869:	31 d2                	xor    %edx,%edx
    386b:	b9 22 40 00 00       	mov    $0x4022,%ecx
    3870:	41 b8 ff ff ff ff    	mov    $0xffffffff,%r8d
    3876:	45 31 c9             	xor    %r9d,%r9d
    3879:	e8 12 e9 ff ff       	call   2190 <mmap@plt>
    387e:	48 83 f8 ff          	cmp    $0xffffffffffffffff,%rax
    3882:	75 17                	jne    389b <fwp_gc_reserve+0x5b>
    3884:	4c 89 f0             	mov    %r14,%rax
    3887:	48 c1 e8 02          	shr    $0x2,%rax
    388b:	49 81 fe ff ff ff 3f 	cmp    $0x3fffffff,%r14
    3892:	49 89 c6             	mov    %rax,%r14
    3895:	77 c9                	ja     3860 <fwp_gc_reserve+0x20>
    3897:	31 c0                	xor    %eax,%eax
    3899:	eb 03                	jmp    389e <fwp_gc_reserve+0x5e>
    389b:	4c 89 33             	mov    %r14,(%rbx)
    389e:	48 83 c4 08          	add    $0x8,%rsp
    38a2:	5b                   	pop    %rbx
    38a3:	41 5e                	pop    %r14
    38a5:	c3                   	ret
    38a6:	66 2e 0f 1f 84 00 00 	cs nopw 0x0(%rax,%rax,1)
    38ad:	00 00 00 

00000000000038b0 <fwp_gc_oom>:
    38b0:	50                   	push   %rax
    38b1:	48 8b 05 20 f7 00 00 	mov    0xf720(%rip),%rax        # 12fd8 <stderr@GLIBC_2.2.5>
    38b8:	48 8b 08             	mov    (%rax),%rcx
    38bb:	48 8d 3d 9e 9e 00 00 	lea    0x9e9e(%rip),%rdi        # d760 <exec_in_fp0+0x120>
    38c2:	be 13 00 00 00       	mov    $0x13,%esi
    38c7:	ba 01 00 00 00       	mov    $0x1,%edx
    38cc:	e8 cf eb ff ff       	call   24a0 <fwrite@plt>
    38d1:	bf 66 00 00 00       	mov    $0x66,%edi
    38d6:	e8 a5 eb ff ff       	call   2480 <exit@plt>
    38db:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)

00000000000038e0 <fwp_gc_chunks>:
    38e0:	41 56                	push   %r14
    38e2:	53                   	push   %rbx
    38e3:	50                   	push   %rax
    38e4:	48 89 fb             	mov    %rdi,%rbx
    38e7:	31 d2                	xor    %edx,%edx
    38e9:	48 83 ff 01          	cmp    $0x1,%rdi
    38ed:	0f 95 c2             	setne  %dl
    38f0:	48 8d 0d a1 f9 00 00 	lea    0xf9a1(%rip),%rcx        # 13298 <fwp_gc>
    38f7:	48 8b 84 d1 68 10 00 	mov    0x1068(%rcx,%rdx,8),%rax
    38fe:	00 
    38ff:	4c 8b 35 ea 09 01 00 	mov    0x109ea(%rip),%r14        # 142f0 <fwp_gc+0x1058>
    3906:	48 89 c7             	mov    %rax,%rdi
    3909:	4c 29 f7             	sub    %r14,%rdi
    390c:	73 61                	jae    396f <fwp_gc_chunks+0x8f>
    390e:	48 8d 34 d5 68 10 00 	lea    0x1068(,%rdx,8),%rsi
    3915:	00 
    3916:	4c 69 c0 28 12 00 00 	imul   $0x1228,%rax,%r8
    391d:	4c 03 05 ec 09 01 00 	add    0x109ec(%rip),%r8        # 14310 <fwp_gc+0x1078>
    3924:	31 d2                	xor    %edx,%edx
    3926:	45 31 c9             	xor    %r9d,%r9d
    3929:	eb 17                	jmp    3942 <fwp_gc_chunks+0x62>
    392b:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)
    3930:	45 31 c9             	xor    %r9d,%r9d
    3933:	48 ff ca             	dec    %rdx
    3936:	49 81 c0 28 12 00 00 	add    $0x1228,%r8
    393d:	48 39 d7             	cmp    %rdx,%rdi
    3940:	74 30                	je     3972 <fwp_gc_chunks+0x92>
    3942:	41 80 38 00          	cmpb   $0x0,(%r8)
    3946:	75 e8                	jne    3930 <fwp_gc_chunks+0x50>
    3948:	49 ff c1             	inc    %r9
    394b:	49 39 d9             	cmp    %rbx,%r9
    394e:	75 e3                	jne    3933 <fwp_gc_chunks+0x53>
    3950:	48 ff c0             	inc    %rax
    3953:	48 89 c7             	mov    %rax,%rdi
    3956:	48 29 d7             	sub    %rdx,%rdi
    3959:	48 89 3c 0e          	mov    %rdi,(%rsi,%rcx,1)
    395d:	48 29 1d 14 0b 01 00 	sub    %rbx,0x10b14(%rip)        # 14478 <fwp_gc+0x11e0>
    3964:	48 29 d8             	sub    %rbx,%rax
    3967:	48 29 d0             	sub    %rdx,%rax
    396a:	49 89 c6             	mov    %rax,%r14
    396d:	eb 33                	jmp    39a2 <fwp_gc_chunks+0xc2>
    396f:	45 31 c9             	xor    %r9d,%r9d
    3972:	4d 29 ce             	sub    %r9,%r14
    3975:	4c 29 0d fc 0a 01 00 	sub    %r9,0x10afc(%rip)        # 14478 <fwp_gc+0x11e0>
    397c:	4c 01 f3             	add    %r14,%rbx
    397f:	48 89 df             	mov    %rbx,%rdi
    3982:	e8 29 00 00 00       	call   39b0 <fwp_gc_commit>
    3987:	48 89 1d 62 09 01 00 	mov    %rbx,0x10962(%rip)        # 142f0 <fwp_gc+0x1058>
    398e:	48 c1 e3 10          	shl    $0x10,%rbx
    3992:	48 3b 1d 47 09 01 00 	cmp    0x10947(%rip),%rbx        # 142e0 <fwp_gc+0x1048>
    3999:	76 07                	jbe    39a2 <fwp_gc_chunks+0xc2>
    399b:	48 89 1d 3e 09 01 00 	mov    %rbx,0x1093e(%rip)        # 142e0 <fwp_gc+0x1048>
    39a2:	4c 89 f0             	mov    %r14,%rax
    39a5:	48 83 c4 08          	add    $0x8,%rsp
    39a9:	5b                   	pop    %rbx
    39aa:	41 5e                	pop    %r14
    39ac:	c3                   	ret
    39ad:	0f 1f 00             	nopl   (%rax)

00000000000039b0 <fwp_gc_commit>:
    39b0:	53                   	push   %rbx
    39b1:	48 89 fb             	mov    %rdi,%rbx
    39b4:	48 8b 3d 3d 09 01 00 	mov    0x1093d(%rip),%rdi        # 142f8 <fwp_gc+0x1060>
    39bb:	48 39 df             	cmp    %rbx,%rdi
    39be:	0f 83 8f 00 00 00    	jae    3a53 <fwp_gc_commit+0xa3>
    39c4:	48 8b 05 1d 09 01 00 	mov    0x1091d(%rip),%rax        # 142e8 <fwp_gc+0x1050>
    39cb:	48 39 d8             	cmp    %rbx,%rax
    39ce:	0f 82 81 00 00 00    	jb     3a55 <fwp_gc_commit+0xa5>
    39d4:	48 83 c3 40          	add    $0x40,%rbx
    39d8:	48 39 c3             	cmp    %rax,%rbx
    39db:	48 0f 43 d8          	cmovae %rax,%rbx
    39df:	48 89 de             	mov    %rbx,%rsi
    39e2:	48 29 fe             	sub    %rdi,%rsi
    39e5:	48 c1 e7 10          	shl    $0x10,%rdi
    39e9:	48 03 3d d8 08 01 00 	add    0x108d8(%rip),%rdi        # 142c8 <fwp_gc+0x1030>
    39f0:	48 c1 e6 10          	shl    $0x10,%rsi
    39f4:	ba 03 00 00 00       	mov    $0x3,%edx
    39f9:	e8 12 ea ff ff       	call   2410 <mprotect@plt>
    39fe:	85 c0                	test   %eax,%eax
    3a00:	75 53                	jne    3a55 <fwp_gc_commit+0xa5>
    3a02:	bf 1e 00 00 00       	mov    $0x1e,%edi
    3a07:	e8 24 ea ff ff       	call   2430 <sysconf@plt>
    3a0c:	48 8b 0d fd 08 01 00 	mov    0x108fd(%rip),%rcx        # 14310 <fwp_gc+0x1078>
    3a13:	48 69 3d da 08 01 00 	imul   $0x1228,0x108da(%rip),%rdi        # 142f8 <fwp_gc+0x1060>
    3a1a:	28 12 00 00 
    3a1e:	48 01 cf             	add    %rcx,%rdi
    3a21:	48 69 d3 28 12 00 00 	imul   $0x1228,%rbx,%rdx
    3a28:	48 01 ca             	add    %rcx,%rdx
    3a2b:	48 8d 34 10          	lea    (%rax,%rdx,1),%rsi
    3a2f:	48 ff ce             	dec    %rsi
    3a32:	48 f7 d8             	neg    %rax
    3a35:	48 21 c7             	and    %rax,%rdi
    3a38:	48 21 c6             	and    %rax,%rsi
    3a3b:	48 29 fe             	sub    %rdi,%rsi
    3a3e:	ba 03 00 00 00       	mov    $0x3,%edx
    3a43:	e8 c8 e9 ff ff       	call   2410 <mprotect@plt>
    3a48:	85 c0                	test   %eax,%eax
    3a4a:	75 09                	jne    3a55 <fwp_gc_commit+0xa5>
    3a4c:	48 89 1d a5 08 01 00 	mov    %rbx,0x108a5(%rip)        # 142f8 <fwp_gc+0x1060>
    3a53:	5b                   	pop    %rbx
    3a54:	c3                   	ret
    3a55:	e8 56 fe ff ff       	call   38b0 <fwp_gc_oom>
    3a5a:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)

0000000000003a60 <fwp_gc_collect>:
    3a60:	83 3d 29 08 01 00 00 	cmpl   $0x0,0x10829(%rip)        # 14290 <fwp_gc+0xff8>
    3a67:	74 01                	je     3a6a <fwp_gc_collect+0xa>
    3a69:	c3                   	ret
    3a6a:	55                   	push   %rbp
    3a6b:	48 89 e5             	mov    %rsp,%rbp
    3a6e:	41 57                	push   %r15
    3a70:	41 56                	push   %r14
    3a72:	41 55                	push   %r13
    3a74:	41 54                	push   %r12
    3a76:	53                   	push   %rbx
    3a77:	48 81 ec e8 00 00 00 	sub    $0xe8,%rsp
    3a7e:	c7 05 08 08 01 00 01 	movl   $0x1,0x10808(%rip)        # 14290 <fwp_gc+0xff8>
    3a85:	00 00 00 
    3a88:	48 8d 75 b8          	lea    -0x48(%rbp),%rsi
    3a8c:	bf 01 00 00 00       	mov    $0x1,%edi
    3a91:	e8 9a e6 ff ff       	call   2130 <clock_gettime@plt>
    3a96:	48 8b 05 0b 0a 01 00 	mov    0x10a0b(%rip),%rax        # 144a8 <fwp_gc+0x1210>
    3a9d:	48 2b 05 f4 f7 00 00 	sub    0xf7f4(%rip),%rax        # 13298 <fwp_gc>
    3aa4:	f2 48 0f 2a c0       	cvtsi2sd %rax,%xmm0
    3aa9:	f2 0f 58 05 cf 09 01 	addsd  0x109cf(%rip),%xmm0        # 14480 <fwp_gc+0x11e8>
    3ab0:	00 
    3ab1:	f2 0f 11 05 c7 09 01 	movsd  %xmm0,0x109c7(%rip)        # 14480 <fwp_gc+0x11e8>
    3ab8:	00 
    3ab9:	83 3d d8 07 01 00 00 	cmpl   $0x0,0x107d8(%rip)        # 14298 <fwp_gc+0x1000>
    3ac0:	0f 94 c0             	sete   %al
    3ac3:	83 3d d6 07 01 00 00 	cmpl   $0x0,0x107d6(%rip)        # 142a0 <fwp_gc+0x1008>
    3aca:	0f 95 c3             	setne  %bl
    3acd:	08 c3                	or     %al,%bl
    3acf:	80 fb 01             	cmp    $0x1,%bl
    3ad2:	75 3e                	jne    3b12 <fwp_gc_collect+0xb2>
    3ad4:	e8 b7 01 00 00       	call   3c90 <fwp_gc_clear_marks>
    3ad9:	48 8d bd f0 fe ff ff 	lea    -0x110(%rbp),%rdi
    3ae0:	e8 cb e7 ff ff       	call   22b0 <_setjmp@plt>
    3ae5:	48 c7 05 a8 09 01 00 	movq   $0x0,0x109a8(%rip)        # 14498 <fwp_gc+0x1200>
    3aec:	00 00 00 00 
    3af0:	e8 1b 02 00 00       	call   3d10 <fwp_gc_mark_all>
    3af5:	e8 36 07 00 00       	call   4230 <fwp_gc_finalize>
    3afa:	e8 c1 07 00 00       	call   42c0 <fwp_gc_sweep>
    3aff:	48 8b 05 6a 09 01 00 	mov    0x1096a(%rip),%rax        # 14470 <fwp_gc+0x11d8>
    3b06:	48 ff c0             	inc    %rax
    3b09:	48 89 05 60 09 01 00 	mov    %rax,0x10960(%rip)        # 14470 <fwp_gc+0x11d8>
    3b10:	eb 51                	jmp    3b63 <fwp_gc_collect+0x103>
    3b12:	48 8d bd f0 fe ff ff 	lea    -0x110(%rbp),%rdi
    3b19:	e8 92 e7 ff ff       	call   22b0 <_setjmp@plt>
    3b1e:	48 c7 05 6f 09 01 00 	movq   $0x0,0x1096f(%rip)        # 14498 <fwp_gc+0x1200>
    3b25:	00 00 00 00 
    3b29:	e8 e2 01 00 00       	call   3d10 <fwp_gc_mark_all>
    3b2e:	e8 fd 01 00 00       	call   3d30 <fwp_gc_scan_old_filled>
    3b33:	83 3d 62 07 01 00 00 	cmpl   $0x0,0x10762(%rip)        # 1429c <fwp_gc+0x1004>
    3b3a:	74 05                	je     3b41 <fwp_gc_collect+0xe1>
    3b3c:	e8 2f 03 00 00       	call   3e70 <fwp_gc_verify_minor>
    3b41:	e8 ea 06 00 00       	call   4230 <fwp_gc_finalize>
    3b46:	e8 75 07 00 00       	call   42c0 <fwp_gc_sweep>
    3b4b:	48 8b 05 1e 09 01 00 	mov    0x1091e(%rip),%rax        # 14470 <fwp_gc+0x11d8>
    3b52:	48 ff c0             	inc    %rax
    3b55:	48 89 05 14 09 01 00 	mov    %rax,0x10914(%rip)        # 14470 <fwp_gc+0x11d8>
    3b5c:	48 ff 05 4d 07 01 00 	incq   0x1074d(%rip)        # 142b0 <fwp_gc+0x1018>
    3b63:	48 89 c1             	mov    %rax,%rcx
    3b66:	48 8b 05 f3 08 01 00 	mov    0x108f3(%rip),%rax        # 14460 <fwp_gc+0x11c8>
    3b6d:	48 3b 05 f4 08 01 00 	cmp    0x108f4(%rip),%rax        # 14468 <fwp_gc+0x11d0>
    3b74:	76 07                	jbe    3b7d <fwp_gc_collect+0x11d>
    3b76:	48 89 05 eb 08 01 00 	mov    %rax,0x108eb(%rip)        # 14468 <fwp_gc+0x11d0>
    3b7d:	84 db                	test   %bl,%bl
    3b7f:	74 0b                	je     3b8c <fwp_gc_collect+0x12c>
    3b81:	48 89 05 20 07 01 00 	mov    %rax,0x10720(%rip)        # 142a8 <fwp_gc+0x1010>
    3b88:	31 d2                	xor    %edx,%edx
    3b8a:	eb 2d                	jmp    3bb9 <fwp_gc_collect+0x159>
    3b8c:	48 8b 15 15 07 01 00 	mov    0x10715(%rip),%rdx        # 142a8 <fwp_gc+0x1010>
    3b93:	48 89 d6             	mov    %rdx,%rsi
    3b96:	48 d1 ee             	shr    $1,%rsi
    3b99:	48 01 d6             	add    %rdx,%rsi
    3b9c:	48 81 fe 01 00 00 01 	cmp    $0x1000001,%rsi
    3ba3:	ba 00 00 00 01       	mov    $0x1000000,%edx
    3ba8:	48 0f 43 d6          	cmovae %rsi,%rdx
    3bac:	31 f6                	xor    %esi,%esi
    3bae:	48 39 d0             	cmp    %rdx,%rax
    3bb1:	0f 97 c2             	seta   %dl
    3bb4:	40 88 d6             	mov    %dl,%sil
    3bb7:	89 f2                	mov    %esi,%edx
    3bb9:	f6 c1 07             	test   $0x7,%cl
    3bbc:	b9 01 00 00 00       	mov    $0x1,%ecx
    3bc1:	0f 45 ca             	cmovne %edx,%ecx
    3bc4:	48 83 3d ec 06 01 00 	cmpq   $0x0,0x106ec(%rip)        # 142b8 <fwp_gc+0x1020>
    3bcb:	00 
    3bcc:	0f 44 ca             	cmove  %edx,%ecx
    3bcf:	89 0d cb 06 01 00    	mov    %ecx,0x106cb(%rip)        # 142a0 <fwp_gc+0x1008>
    3bd5:	83 3d bc 06 01 00 00 	cmpl   $0x0,0x106bc(%rip)        # 14298 <fwp_gc+0x1000>
    3bdc:	0f 94 c1             	sete   %cl
    3bdf:	48 d3 e0             	shl    %cl,%rax
    3be2:	f2 48 0f 2c 0d ad 08 	cvttsd2si 0x108ad(%rip),%rcx        # 14498 <fwp_gc+0x1200>
    3be9:	01 00 
    3beb:	48 01 c1             	add    %rax,%rcx
    3bee:	48 81 f9 01 00 80 00 	cmp    $0x800001,%rcx
    3bf5:	b8 00 00 80 00       	mov    $0x800000,%eax
    3bfa:	48 0f 4d c1          	cmovge %rcx,%rax
    3bfe:	48 89 05 a3 08 01 00 	mov    %rax,0x108a3(%rip)        # 144a8 <fwp_gc+0x1210>
    3c05:	48 89 05 8c f6 00 00 	mov    %rax,0xf68c(%rip)        # 13298 <fwp_gc>
    3c0c:	48 8d 75 c8          	lea    -0x38(%rbp),%rsi
    3c10:	bf 01 00 00 00       	mov    $0x1,%edi
    3c15:	e8 16 e5 ff ff       	call   2130 <clock_gettime@plt>
    3c1a:	48 8b 45 c8          	mov    -0x38(%rbp),%rax
    3c1e:	48 8b 4d d0          	mov    -0x30(%rbp),%rcx
    3c22:	48 2b 45 b8          	sub    -0x48(%rbp),%rax
    3c26:	f2 48 0f 2a c8       	cvtsi2sd %rax,%xmm1
    3c2b:	f2 0f 59 0d e5 93 00 	mulsd  0x93e5(%rip),%xmm1        # d018 <_IO_stdin_used+0x18>
    3c32:	00 
    3c33:	48 2b 4d c0          	sub    -0x40(%rbp),%rcx
    3c37:	0f 57 c0             	xorps  %xmm0,%xmm0
    3c3a:	f2 48 0f 2a c1       	cvtsi2sd %rcx,%xmm0
    3c3f:	f2 0f 5e 05 d9 93 00 	divsd  0x93d9(%rip),%xmm0        # d020 <_IO_stdin_used+0x20>
    3c46:	00 
    3c47:	f2 0f 58 c1          	addsd  %xmm1,%xmm0
    3c4b:	f2 0f 10 0d 35 08 01 	movsd  0x10835(%rip),%xmm1        # 14488 <fwp_gc+0x11f0>
    3c52:	00 
    3c53:	f2 0f 58 c8          	addsd  %xmm0,%xmm1
    3c57:	f2 0f 11 0d 29 08 01 	movsd  %xmm1,0x10829(%rip)        # 14488 <fwp_gc+0x11f0>
    3c5e:	00 
    3c5f:	66 0f 2e 05 29 08 01 	ucomisd 0x10829(%rip),%xmm0        # 14490 <fwp_gc+0x11f8>
    3c66:	00 
    3c67:	48 8d a4 24 e8 00 00 	lea    0xe8(%rsp),%rsp
    3c6e:	00 
    3c6f:	5b                   	pop    %rbx
    3c70:	41 5c                	pop    %r12
    3c72:	41 5d                	pop    %r13
    3c74:	41 5e                	pop    %r14
    3c76:	41 5f                	pop    %r15
    3c78:	5d                   	pop    %rbp
    3c79:	76 08                	jbe    3c83 <fwp_gc_collect+0x223>
    3c7b:	f2 0f 11 05 0d 08 01 	movsd  %xmm0,0x1080d(%rip)        # 14490 <fwp_gc+0x11f8>
    3c82:	00 
    3c83:	c7 05 03 06 01 00 00 	movl   $0x0,0x10603(%rip)        # 14290 <fwp_gc+0xff8>
    3c8a:	00 00 00 
    3c8d:	c3                   	ret
    3c8e:	66 90                	xchg   %ax,%ax

0000000000003c90 <fwp_gc_clear_marks>:
    3c90:	48 8b 05 59 06 01 00 	mov    0x10659(%rip),%rax        # 142f0 <fwp_gc+0x1058>
    3c97:	48 85 c0             	test   %rax,%rax
    3c9a:	74 69                	je     3d05 <fwp_gc_clear_marks+0x75>
    3c9c:	41 56                	push   %r14
    3c9e:	53                   	push   %rbx
    3c9f:	50                   	push   %rax
    3ca0:	48 8b 0d 69 06 01 00 	mov    0x10669(%rip),%rcx        # 14310 <fwp_gc+0x1078>
    3ca7:	31 db                	xor    %ebx,%ebx
    3ca9:	45 31 f6             	xor    %r14d,%r14d
    3cac:	eb 16                	jmp    3cc4 <fwp_gc_clear_marks+0x34>
    3cae:	66 90                	xchg   %ax,%ax
    3cb0:	c6 44 19 03 00       	movb   $0x0,0x3(%rcx,%rbx,1)
    3cb5:	49 ff c6             	inc    %r14
    3cb8:	48 81 c3 28 12 00 00 	add    $0x1228,%rbx
    3cbf:	49 39 c6             	cmp    %rax,%r14
    3cc2:	73 3a                	jae    3cfe <fwp_gc_clear_marks+0x6e>
    3cc4:	0f b6 14 19          	movzbl (%rcx,%rbx,1),%edx
    3cc8:	83 fa 02             	cmp    $0x2,%edx
    3ccb:	74 e3                	je     3cb0 <fwp_gc_clear_marks+0x20>
    3ccd:	83 fa 01             	cmp    $0x1,%edx
    3cd0:	75 e3                	jne    3cb5 <fwp_gc_clear_marks+0x25>
    3cd2:	48 8d 3c 19          	lea    (%rcx,%rbx,1),%rdi
    3cd6:	48 83 c7 28          	add    $0x28,%rdi
    3cda:	8b 54 19 0c          	mov    0xc(%rcx,%rbx,1),%edx
    3cde:	83 c2 3f             	add    $0x3f,%edx
    3ce1:	c1 ea 03             	shr    $0x3,%edx
    3ce4:	83 e2 f8             	and    $0xfffffff8,%edx
    3ce7:	31 f6                	xor    %esi,%esi
    3ce9:	e8 22 e5 ff ff       	call   2210 <memset@plt>
    3cee:	48 8b 0d 1b 06 01 00 	mov    0x1061b(%rip),%rcx        # 14310 <fwp_gc+0x1078>
    3cf5:	48 8b 05 f4 05 01 00 	mov    0x105f4(%rip),%rax        # 142f0 <fwp_gc+0x1058>
    3cfc:	eb b7                	jmp    3cb5 <fwp_gc_clear_marks+0x25>
    3cfe:	48 83 c4 08          	add    $0x8,%rsp
    3d02:	5b                   	pop    %rbx
    3d03:	41 5e                	pop    %r14
    3d05:	c3                   	ret
    3d06:	66 2e 0f 1f 84 00 00 	cs nopw 0x0(%rax,%rax,1)
    3d0d:	00 00 00 

0000000000003d10 <fwp_gc_mark_all>:
    3d10:	50                   	push   %rax
    3d11:	e8 4a 0c 00 00       	call   4960 <fwp_gc_sp>
    3d16:	48 89 c7             	mov    %rax,%rdi
    3d19:	e8 32 0c 00 00       	call   4950 <fwp_gc_scan_stacks>
    3d1e:	e8 4d 0c 00 00       	call   4970 <fwp_gc_drain>
    3d23:	e8 98 0c 00 00       	call   49c0 <fwp_gc_scan_data>
    3d28:	58                   	pop    %rax
    3d29:	e9 42 0c 00 00       	jmp    4970 <fwp_gc_drain>
    3d2e:	66 90                	xchg   %ax,%ax

0000000000003d30 <fwp_gc_scan_old_filled>:
    3d30:	48 83 3d b8 05 01 00 	cmpq   $0x0,0x105b8(%rip)        # 142f0 <fwp_gc+0x1058>
    3d37:	00 
    3d38:	0f 84 32 0c 00 00    	je     4970 <fwp_gc_drain>
    3d3e:	55                   	push   %rbp
    3d3f:	41 57                	push   %r15
    3d41:	41 56                	push   %r14
    3d43:	41 55                	push   %r13
    3d45:	41 54                	push   %r12
    3d47:	53                   	push   %rbx
    3d48:	48 83 ec 18          	sub    $0x18,%rsp
    3d4c:	31 c0                	xor    %eax,%eax
    3d4e:	eb 14                	jmp    3d64 <fwp_gc_scan_old_filled+0x34>
    3d50:	48 8b 04 24          	mov    (%rsp),%rax
    3d54:	48 ff c0             	inc    %rax
    3d57:	48 3b 05 92 05 01 00 	cmp    0x10592(%rip),%rax        # 142f0 <fwp_gc+0x1058>
    3d5e:	0f 83 f6 00 00 00    	jae    3e5a <fwp_gc_scan_old_filled+0x12a>
    3d64:	48 8b 0d a5 05 01 00 	mov    0x105a5(%rip),%rcx        # 14310 <fwp_gc+0x1078>
    3d6b:	48 89 04 24          	mov    %rax,(%rsp)
    3d6f:	48 69 e8 28 12 00 00 	imul   $0x1228,%rax,%rbp
    3d76:	80 7c 29 01 02       	cmpb   $0x2,0x1(%rcx,%rbp,1)
    3d7b:	75 d3                	jne    3d50 <fwp_gc_scan_old_filled+0x20>
    3d7d:	48 89 cb             	mov    %rcx,%rbx
    3d80:	0f b6 04 29          	movzbl (%rcx,%rbp,1),%eax
    3d84:	83 f8 02             	cmp    $0x2,%eax
    3d87:	0f 84 a7 00 00 00    	je     3e34 <fwp_gc_scan_old_filled+0x104>
    3d8d:	83 f8 01             	cmp    $0x1,%eax
    3d90:	75 be                	jne    3d50 <fwp_gc_scan_old_filled+0x20>
    3d92:	48 8b 3c 24          	mov    (%rsp),%rdi
    3d96:	e8 c5 ef ff ff       	call   2d60 <fwp_gc_chunk_addr>
    3d9b:	49 89 c6             	mov    %rax,%r14
    3d9e:	8b 44 2b 0c          	mov    0xc(%rbx,%rbp,1),%eax
    3da2:	83 c0 3f             	add    $0x3f,%eax
    3da5:	48 89 44 24 08       	mov    %rax,0x8(%rsp)
    3daa:	83 f8 40             	cmp    $0x40,%eax
    3dad:	72 a1                	jb     3d50 <fwp_gc_scan_old_filled+0x20>
    3daf:	48 8b 44 24 08       	mov    0x8(%rsp),%rax
    3db4:	c1 e8 06             	shr    $0x6,%eax
    3db7:	48 89 44 24 08       	mov    %rax,0x8(%rsp)
    3dbc:	4c 8d 2c 2b          	lea    (%rbx,%rbp,1),%r13
    3dc0:	49 83 c5 08          	add    $0x8,%r13
    3dc4:	48 01 eb             	add    %rbp,%rbx
    3dc7:	48 89 5c 24 10       	mov    %rbx,0x10(%rsp)
    3dcc:	45 31 ff             	xor    %r15d,%r15d
    3dcf:	eb 1d                	jmp    3dee <fwp_gc_scan_old_filled+0xbe>
    3dd1:	66 66 66 66 66 66 2e 	data16 data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    3dd8:	0f 1f 84 00 00 00 00 
    3ddf:	00 
    3de0:	49 ff c7             	inc    %r15
    3de3:	4c 3b 7c 24 08       	cmp    0x8(%rsp),%r15
    3de8:	0f 84 62 ff ff ff    	je     3d50 <fwp_gc_scan_old_filled+0x20>
    3dee:	48 8b 44 24 10       	mov    0x10(%rsp),%rax
    3df3:	4e 8b 64 f8 28       	mov    0x28(%rax,%r15,8),%r12
    3df8:	4d 85 e4             	test   %r12,%r12
    3dfb:	74 e3                	je     3de0 <fwp_gc_scan_old_filled+0xb0>
    3dfd:	4c 89 fd             	mov    %r15,%rbp
    3e00:	48 c1 e5 06          	shl    $0x6,%rbp
    3e04:	66 66 66 2e 0f 1f 84 	data16 data16 cs nopw 0x0(%rax,%rax,1)
    3e0b:	00 00 00 00 00 
    3e10:	f3 49 0f bc fc       	tzcnt  %r12,%rdi
    3e15:	48 09 ef             	or     %rbp,%rdi
    3e18:	49 8d 5c 24 ff       	lea    -0x1(%r12),%rbx
    3e1d:	41 8b 75 00          	mov    0x0(%r13),%esi
    3e21:	48 0f af fe          	imul   %rsi,%rdi
    3e25:	4c 01 f7             	add    %r14,%rdi
    3e28:	e8 03 0e 00 00       	call   4c30 <fwp_gc_push>
    3e2d:	49 21 dc             	and    %rbx,%r12
    3e30:	75 de                	jne    3e10 <fwp_gc_scan_old_filled+0xe0>
    3e32:	eb ac                	jmp    3de0 <fwp_gc_scan_old_filled+0xb0>
    3e34:	80 7c 2b 03 00       	cmpb   $0x0,0x3(%rbx,%rbp,1)
    3e39:	0f 84 11 ff ff ff    	je     3d50 <fwp_gc_scan_old_filled+0x20>
    3e3f:	48 8b 3c 24          	mov    (%rsp),%rdi
    3e43:	e8 18 ef ff ff       	call   2d60 <fwp_gc_chunk_addr>
    3e48:	48 8b 74 2b 18       	mov    0x18(%rbx,%rbp,1),%rsi
    3e4d:	48 89 c7             	mov    %rax,%rdi
    3e50:	e8 db 0d 00 00       	call   4c30 <fwp_gc_push>
    3e55:	e9 f6 fe ff ff       	jmp    3d50 <fwp_gc_scan_old_filled+0x20>
    3e5a:	48 83 c4 18          	add    $0x18,%rsp
    3e5e:	5b                   	pop    %rbx
    3e5f:	41 5c                	pop    %r12
    3e61:	41 5d                	pop    %r13
    3e63:	41 5e                	pop    %r14
    3e65:	41 5f                	pop    %r15
    3e67:	5d                   	pop    %rbp
    3e68:	e9 03 0b 00 00       	jmp    4970 <fwp_gc_drain>
    3e6d:	0f 1f 00             	nopl   (%rax)

0000000000003e70 <fwp_gc_verify_minor>:
    3e70:	55                   	push   %rbp
    3e71:	41 57                	push   %r15
    3e73:	41 56                	push   %r14
    3e75:	41 55                	push   %r13
    3e77:	41 54                	push   %r12
    3e79:	53                   	push   %rbx
    3e7a:	48 83 ec 58          	sub    $0x58,%rsp
    3e7e:	4c 8b 2d 6b 04 01 00 	mov    0x1046b(%rip),%r13        # 142f0 <fwp_gc+0x1058>
    3e85:	4c 89 ef             	mov    %r13,%rdi
    3e88:	48 c1 e7 09          	shl    $0x9,%rdi
    3e8c:	e8 af e4 ff ff       	call   2340 <malloc@plt>
    3e91:	48 89 c3             	mov    %rax,%rbx
    3e94:	49 83 fd 01          	cmp    $0x1,%r13
    3e98:	4c 89 ef             	mov    %r13,%rdi
    3e9b:	48 83 d7 00          	adc    $0x0,%rdi
    3e9f:	48 89 7c 24 30       	mov    %rdi,0x30(%rsp)
    3ea4:	e8 97 e4 ff ff       	call   2340 <malloc@plt>
    3ea9:	48 89 5c 24 20       	mov    %rbx,0x20(%rsp)
    3eae:	48 85 db             	test   %rbx,%rbx
    3eb1:	0f 84 74 03 00 00    	je     422b <fwp_gc_verify_minor+0x3bb>
    3eb7:	49 89 c7             	mov    %rax,%r15
    3eba:	48 85 c0             	test   %rax,%rax
    3ebd:	0f 84 68 03 00 00    	je     422b <fwp_gc_verify_minor+0x3bb>
    3ec3:	4d 85 ed             	test   %r13,%r13
    3ec6:	74 1c                	je     3ee4 <fwp_gc_verify_minor+0x74>
    3ec8:	48 8b 0d 41 04 01 00 	mov    0x10441(%rip),%rcx        # 14310 <fwp_gc+0x1078>
    3ecf:	49 83 fd 01          	cmp    $0x1,%r13
    3ed3:	48 89 4c 24 28       	mov    %rcx,0x28(%rsp)
    3ed8:	75 19                	jne    3ef3 <fwp_gc_verify_minor+0x83>
    3eda:	4d 89 ec             	mov    %r13,%r12
    3edd:	31 ed                	xor    %ebp,%ebp
    3edf:	e9 81 00 00 00       	jmp    3f65 <fwp_gc_verify_minor+0xf5>
    3ee4:	e8 a7 fd ff ff       	call   3c90 <fwp_gc_clear_marks>
    3ee9:	e8 22 fe ff ff       	call   3d10 <fwp_gc_mark_all>
    3eee:	e9 13 03 00 00       	jmp    4206 <fwp_gc_verify_minor+0x396>
    3ef3:	4d 89 ec             	mov    %r13,%r12
    3ef6:	49 83 e5 fe          	and    $0xfffffffffffffffe,%r13
    3efa:	48 8b 44 24 20       	mov    0x20(%rsp),%rax
    3eff:	48 8d 98 00 02 00 00 	lea    0x200(%rax),%rbx
    3f06:	4c 8d b1 50 12 00 00 	lea    0x1250(%rcx),%r14
    3f0d:	31 ed                	xor    %ebp,%ebp
    3f0f:	90                   	nop
    3f10:	48 8d bb 00 fe ff ff 	lea    -0x200(%rbx),%rdi
    3f17:	49 8d b6 d8 ed ff ff 	lea    -0x1228(%r14),%rsi
    3f1e:	ba 00 02 00 00       	mov    $0x200,%edx
    3f23:	e8 08 e4 ff ff       	call   2330 <memcpy@plt>
    3f28:	41 0f b6 86 b3 ed ff 	movzbl -0x124d(%r14),%eax
    3f2f:	ff 
    3f30:	41 88 04 2f          	mov    %al,(%r15,%rbp,1)
    3f34:	ba 00 02 00 00       	mov    $0x200,%edx
    3f39:	48 89 df             	mov    %rbx,%rdi
    3f3c:	4c 89 f6             	mov    %r14,%rsi
    3f3f:	e8 ec e3 ff ff       	call   2330 <memcpy@plt>
    3f44:	41 0f b6 46 db       	movzbl -0x25(%r14),%eax
    3f49:	41 88 44 2f 01       	mov    %al,0x1(%r15,%rbp,1)
    3f4e:	48 83 c5 02          	add    $0x2,%rbp
    3f52:	48 81 c3 00 04 00 00 	add    $0x400,%rbx
    3f59:	49 81 c6 50 24 00 00 	add    $0x2450,%r14
    3f60:	49 39 ed             	cmp    %rbp,%r13
    3f63:	75 ab                	jne    3f10 <fwp_gc_verify_minor+0xa0>
    3f65:	4d 89 e5             	mov    %r12,%r13
    3f68:	41 f6 c5 01          	test   $0x1,%r13b
    3f6c:	74 34                	je     3fa2 <fwp_gc_verify_minor+0x132>
    3f6e:	48 89 ef             	mov    %rbp,%rdi
    3f71:	48 c1 e7 09          	shl    $0x9,%rdi
    3f75:	48 03 7c 24 20       	add    0x20(%rsp),%rdi
    3f7a:	48 69 dd 28 12 00 00 	imul   $0x1228,%rbp,%rbx
    3f81:	4c 8b 74 24 28       	mov    0x28(%rsp),%r14
    3f86:	49 8d 34 1e          	lea    (%r14,%rbx,1),%rsi
    3f8a:	48 83 c6 28          	add    $0x28,%rsi
    3f8e:	ba 00 02 00 00       	mov    $0x200,%edx
    3f93:	e8 98 e3 ff ff       	call   2330 <memcpy@plt>
    3f98:	41 0f b6 44 1e 03    	movzbl 0x3(%r14,%rbx,1),%eax
    3f9e:	41 88 04 2f          	mov    %al,(%r15,%rbp,1)
    3fa2:	e8 e9 fc ff ff       	call   3c90 <fwp_gc_clear_marks>
    3fa7:	e8 64 fd ff ff       	call   3d10 <fwp_gc_mark_all>
    3fac:	4d 85 ed             	test   %r13,%r13
    3faf:	0f 84 51 02 00 00    	je     4206 <fwp_gc_verify_minor+0x396>
    3fb5:	48 8b 1d 54 03 01 00 	mov    0x10354(%rip),%rbx        # 14310 <fwp_gc+0x1078>
    3fbc:	48 8d 43 28          	lea    0x28(%rbx),%rax
    3fc0:	48 8b 4c 24 20       	mov    0x20(%rsp),%rcx
    3fc5:	31 ff                	xor    %edi,%edi
    3fc7:	eb 30                	jmp    3ff9 <fwp_gc_verify_minor+0x189>
    3fc9:	4d 85 c9             	test   %r9,%r9
    3fcc:	0f 85 b8 00 00 00    	jne    408a <fwp_gc_verify_minor+0x21a>
    3fd2:	66 66 66 66 66 2e 0f 	data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    3fd9:	1f 84 00 00 00 00 00 
    3fe0:	48 ff c7             	inc    %rdi
    3fe3:	48 81 c1 00 02 00 00 	add    $0x200,%rcx
    3fea:	48 05 28 12 00 00    	add    $0x1228,%rax
    3ff0:	4c 39 ef             	cmp    %r13,%rdi
    3ff3:	0f 84 0d 02 00 00    	je     4206 <fwp_gc_verify_minor+0x396>
    3ff9:	4c 69 f7 28 12 00 00 	imul   $0x1228,%rdi,%r14
    4000:	42 0f b6 2c 33       	movzbl (%rbx,%r14,1),%ebp
    4005:	83 fd 02             	cmp    $0x2,%ebp
    4008:	74 66                	je     4070 <fwp_gc_verify_minor+0x200>
    400a:	83 fd 01             	cmp    $0x1,%ebp
    400d:	75 d1                	jne    3fe0 <fwp_gc_verify_minor+0x170>
    400f:	42 8b 54 33 0c       	mov    0xc(%rbx,%r14,1),%edx
    4014:	83 c2 3f             	add    $0x3f,%edx
    4017:	83 fa 40             	cmp    $0x40,%edx
    401a:	72 c4                	jb     3fe0 <fwp_gc_verify_minor+0x170>
    401c:	c1 ea 06             	shr    $0x6,%edx
    401f:	31 f6                	xor    %esi,%esi
    4021:	45 31 e4             	xor    %r12d,%r12d
    4024:	45 31 c0             	xor    %r8d,%r8d
    4027:	66 0f 1f 84 00 00 00 	nopw   0x0(%rax,%rax,1)
    402e:	00 00 
    4030:	4e 8b 0c c1          	mov    (%rcx,%r8,8),%r9
    4034:	49 f7 d1             	not    %r9
    4037:	4e 23 0c c0          	and    (%rax,%r8,8),%r9
    403b:	4d 89 e2             	mov    %r12,%r10
    403e:	f3 4d 0f bc e1       	tzcnt  %r9,%r12
    4043:	49 01 f4             	add    %rsi,%r12
    4046:	4d 85 c9             	test   %r9,%r9
    4049:	4d 0f 44 e2          	cmove  %r10,%r12
    404d:	49 ff c0             	inc    %r8
    4050:	49 39 d0             	cmp    %rdx,%r8
    4053:	0f 83 70 ff ff ff    	jae    3fc9 <fwp_gc_verify_minor+0x159>
    4059:	48 83 c6 40          	add    $0x40,%rsi
    405d:	4d 85 c9             	test   %r9,%r9
    4060:	74 ce                	je     4030 <fwp_gc_verify_minor+0x1c0>
    4062:	e9 62 ff ff ff       	jmp    3fc9 <fwp_gc_verify_minor+0x159>
    4067:	66 0f 1f 84 00 00 00 	nopw   0x0(%rax,%rax,1)
    406e:	00 00 
    4070:	42 80 7c 33 03 00    	cmpb   $0x0,0x3(%rbx,%r14,1)
    4076:	0f 84 64 ff ff ff    	je     3fe0 <fwp_gc_verify_minor+0x170>
    407c:	41 80 3c 3f 00       	cmpb   $0x0,(%r15,%rdi,1)
    4081:	0f 85 59 ff ff ff    	jne    3fe0 <fwp_gc_verify_minor+0x170>
    4087:	45 31 e4             	xor    %r12d,%r12d
    408a:	e8 d1 ec ff ff       	call   2d60 <fwp_gc_chunk_addr>
    408f:	46 8b 7c 33 08       	mov    0x8(%rbx,%r14,1),%r15d
    4094:	4d 0f af e7          	imul   %r15,%r12
    4098:	49 01 c4             	add    %rax,%r12
    409b:	40 80 fd 01          	cmp    $0x1,%bpl
    409f:	74 05                	je     40a6 <fwp_gc_verify_minor+0x236>
    40a1:	4e 8b 7c 33 18       	mov    0x18(%rbx,%r14,1),%r15
    40a6:	48 8b 05 2b ef 00 00 	mov    0xef2b(%rip),%rax        # 12fd8 <stderr@GLIBC_2.2.5>
    40ad:	48 8b 38             	mov    (%rax),%rdi
    40b0:	42 0f b6 4c 33 01    	movzbl 0x1(%rbx,%r14,1),%ecx
    40b6:	48 8d 35 b7 96 00 00 	lea    0x96b7(%rip),%rsi        # d774 <exec_in_fp0+0x134>
    40bd:	4c 89 e2             	mov    %r12,%rdx
    40c0:	4d 89 f8             	mov    %r15,%r8
    40c3:	31 c0                	xor    %eax,%eax
    40c5:	e8 26 e2 ff ff       	call   22f0 <fprintf@plt>
    40ca:	4d 01 e7             	add    %r12,%r15
    40cd:	45 31 ed             	xor    %r13d,%r13d
    40d0:	4c 89 7c 24 40       	mov    %r15,0x40(%rsp)
    40d5:	eb 17                	jmp    40ee <fwp_gc_verify_minor+0x27e>
    40d7:	66 0f 1f 84 00 00 00 	nopw   0x0(%rax,%rax,1)
    40de:	00 00 
    40e0:	49 ff c5             	inc    %r13
    40e3:	4c 3b 6c 24 30       	cmp    0x30(%rsp),%r13
    40e8:	0f 84 38 01 00 00    	je     4226 <fwp_gc_verify_minor+0x3b6>
    40ee:	48 8b 05 1b 02 01 00 	mov    0x1021b(%rip),%rax        # 14310 <fwp_gc+0x1078>
    40f5:	49 69 cd 28 12 00 00 	imul   $0x1228,%r13,%rcx
    40fc:	80 3c 08 01          	cmpb   $0x1,(%rax,%rcx,1)
    4100:	75 de                	jne    40e0 <fwp_gc_verify_minor+0x270>
    4102:	80 7c 08 01 01       	cmpb   $0x1,0x1(%rax,%rcx,1)
    4107:	74 d7                	je     40e0 <fwp_gc_verify_minor+0x270>
    4109:	8b 5c 08 0c          	mov    0xc(%rax,%rcx,1),%ebx
    410d:	85 db                	test   %ebx,%ebx
    410f:	74 cf                	je     40e0 <fwp_gc_verify_minor+0x270>
    4111:	48 01 c8             	add    %rcx,%rax
    4114:	48 ff c0             	inc    %rax
    4117:	48 89 44 24 28       	mov    %rax,0x28(%rsp)
    411c:	4c 89 e8             	mov    %r13,%rax
    411f:	48 c1 e0 09          	shl    $0x9,%rax
    4123:	48 03 44 24 20       	add    0x20(%rsp),%rax
    4128:	48 89 44 24 50       	mov    %rax,0x50(%rsp)
    412d:	31 ed                	xor    %ebp,%ebp
    412f:	4c 89 6c 24 38       	mov    %r13,0x38(%rsp)
    4134:	eb 21                	jmp    4157 <fwp_gc_verify_minor+0x2e7>
    4136:	66 2e 0f 1f 84 00 00 	cs nopw 0x0(%rax,%rax,1)
    413d:	00 00 00 
    4140:	48 8b 44 24 28       	mov    0x28(%rsp),%rax
    4145:	8b 58 0b             	mov    0xb(%rax),%ebx
    4148:	4c 8b 6c 24 38       	mov    0x38(%rsp),%r13
    414d:	48 ff c5             	inc    %rbp
    4150:	89 d8                	mov    %ebx,%eax
    4152:	48 39 c5             	cmp    %rax,%rbp
    4155:	73 89                	jae    40e0 <fwp_gc_verify_minor+0x270>
    4157:	48 89 e8             	mov    %rbp,%rax
    415a:	48 c1 e8 06          	shr    $0x6,%rax
    415e:	48 8b 4c 24 50       	mov    0x50(%rsp),%rcx
    4163:	48 8b 04 c1          	mov    (%rcx,%rax,8),%rax
    4167:	48 0f a3 e8          	bt     %rbp,%rax
    416b:	73 e0                	jae    414d <fwp_gc_verify_minor+0x2dd>
    416d:	4c 89 ef             	mov    %r13,%rdi
    4170:	e8 eb eb ff ff       	call   2d60 <fwp_gc_chunk_addr>
    4175:	48 89 c2             	mov    %rax,%rdx
    4178:	48 8b 44 24 28       	mov    0x28(%rsp),%rax
    417d:	44 8b 70 07          	mov    0x7(%rax),%r14d
    4181:	49 83 fe 08          	cmp    $0x8,%r14
    4185:	72 c6                	jb     414d <fwp_gc_verify_minor+0x2dd>
    4187:	45 89 f0             	mov    %r14d,%r8d
    418a:	4c 0f af f5          	imul   %rbp,%r14
    418e:	48 89 d3             	mov    %rdx,%rbx
    4191:	4c 01 f3             	add    %r14,%rbx
    4194:	45 31 ed             	xor    %r13d,%r13d
    4197:	48 89 54 24 48       	mov    %rdx,0x48(%rsp)
    419c:	eb 10                	jmp    41ae <fwp_gc_verify_minor+0x33e>
    419e:	66 90                	xchg   %ax,%ax
    41a0:	49 ff c5             	inc    %r13
    41a3:	44 89 c0             	mov    %r8d,%eax
    41a6:	c1 e8 03             	shr    $0x3,%eax
    41a9:	49 39 c5             	cmp    %rax,%r13
    41ac:	73 92                	jae    4140 <fwp_gc_verify_minor+0x2d0>
    41ae:	4a 8b 04 eb          	mov    (%rbx,%r13,8),%rax
    41b2:	4c 39 e0             	cmp    %r12,%rax
    41b5:	72 e9                	jb     41a0 <fwp_gc_verify_minor+0x330>
    41b7:	4c 39 f8             	cmp    %r15,%rax
    41ba:	73 e4                	jae    41a0 <fwp_gc_verify_minor+0x330>
    41bc:	48 8b 05 15 ee 00 00 	mov    0xee15(%rip),%rax        # 12fd8 <stderr@GLIBC_2.2.5>
    41c3:	48 8b 38             	mov    (%rax),%rdi
    41c6:	4c 8b 7c 24 28       	mov    0x28(%rsp),%r15
    41cb:	41 0f b6 0f          	movzbl (%r15),%ecx
    41cf:	42 0f 10 04 32       	movups (%rdx,%r14,1),%xmm0
    41d4:	4a 8b 44 32 10       	mov    0x10(%rdx,%r14,1),%rax
    41d9:	48 89 44 24 10       	mov    %rax,0x10(%rsp)
    41de:	0f 11 04 24          	movups %xmm0,(%rsp)
    41e2:	48 8d 35 e5 95 00 00 	lea    0x95e5(%rip),%rsi        # d7ce <exec_in_fp0+0x18e>
    41e9:	48 89 da             	mov    %rbx,%rdx
    41ec:	4d 89 e9             	mov    %r13,%r9
    41ef:	31 c0                	xor    %eax,%eax
    41f1:	e8 fa e0 ff ff       	call   22f0 <fprintf@plt>
    41f6:	48 8b 54 24 48       	mov    0x48(%rsp),%rdx
    41fb:	45 8b 47 07          	mov    0x7(%r15),%r8d
    41ff:	4c 8b 7c 24 40       	mov    0x40(%rsp),%r15
    4204:	eb 9a                	jmp    41a0 <fwp_gc_verify_minor+0x330>
    4206:	48 8b 7c 24 20       	mov    0x20(%rsp),%rdi
    420b:	e8 40 de ff ff       	call   2050 <free@plt>
    4210:	4c 89 ff             	mov    %r15,%rdi
    4213:	48 83 c4 58          	add    $0x58,%rsp
    4217:	5b                   	pop    %rbx
    4218:	41 5c                	pop    %r12
    421a:	41 5d                	pop    %r13
    421c:	41 5e                	pop    %r14
    421e:	41 5f                	pop    %r15
    4220:	5d                   	pop    %rbp
    4221:	e9 2a de ff ff       	jmp    2050 <free@plt>
    4226:	e8 45 de ff ff       	call   2070 <abort@plt>
    422b:	e8 80 f6 ff ff       	call   38b0 <fwp_gc_oom>

0000000000004230 <fwp_gc_finalize>:
    4230:	41 57                	push   %r15
    4232:	41 56                	push   %r14
    4234:	41 55                	push   %r13
    4236:	41 54                	push   %r12
    4238:	53                   	push   %rbx
    4239:	4c 8b 3d 10 02 01 00 	mov    0x10210(%rip),%r15        # 14450 <fwp_gc+0x11b8>
    4240:	4d 85 ff             	test   %r15,%r15
    4243:	74 71                	je     42b6 <fwp_gc_finalize+0x86>
    4245:	4c 8b 25 fc 01 01 00 	mov    0x101fc(%rip),%r12        # 14448 <fwp_gc+0x11b0>
    424c:	45 31 f6             	xor    %r14d,%r14d
    424f:	eb 46                	jmp    4297 <fwp_gc_finalize+0x67>
    4251:	66 66 66 66 66 66 2e 	data16 data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    4258:	0f 1f 84 00 00 00 00 
    425f:	00 
    4260:	4d 01 e5             	add    %r12,%r13
    4263:	49 8b 45 08          	mov    0x8(%r13),%rax
    4267:	49 ff cf             	dec    %r15
    426a:	4c 89 3d df 01 01 00 	mov    %r15,0x101df(%rip)        # 14450 <fwp_gc+0x11b8>
    4271:	49 c1 e7 04          	shl    $0x4,%r15
    4275:	43 0f 10 04 3c       	movups (%r12,%r15,1),%xmm0
    427a:	41 0f 11 45 00       	movups %xmm0,0x0(%r13)
    427f:	48 89 df             	mov    %rbx,%rdi
    4282:	ff d0                	call   *%rax
    4284:	4c 8b 25 bd 01 01 00 	mov    0x101bd(%rip),%r12        # 14448 <fwp_gc+0x11b0>
    428b:	4c 8b 3d be 01 01 00 	mov    0x101be(%rip),%r15        # 14450 <fwp_gc+0x11b8>
    4292:	4d 39 fe             	cmp    %r15,%r14
    4295:	73 1f                	jae    42b6 <fwp_gc_finalize+0x86>
    4297:	4d 89 f5             	mov    %r14,%r13
    429a:	49 c1 e5 04          	shl    $0x4,%r13
    429e:	4b 8b 1c 2c          	mov    (%r12,%r13,1),%rbx
    42a2:	48 89 df             	mov    %rbx,%rdi
    42a5:	e8 06 0a 00 00       	call   4cb0 <fwp_gc_marked>
    42aa:	85 c0                	test   %eax,%eax
    42ac:	74 b2                	je     4260 <fwp_gc_finalize+0x30>
    42ae:	49 ff c6             	inc    %r14
    42b1:	4d 39 fe             	cmp    %r15,%r14
    42b4:	72 e1                	jb     4297 <fwp_gc_finalize+0x67>
    42b6:	5b                   	pop    %rbx
    42b7:	41 5c                	pop    %r12
    42b9:	41 5d                	pop    %r13
    42bb:	41 5e                	pop    %r14
    42bd:	41 5f                	pop    %r15
    42bf:	c3                   	ret

00000000000042c0 <fwp_gc_sweep>:
    42c0:	55                   	push   %rbp
    42c1:	41 57                	push   %r15
    42c3:	41 56                	push   %r14
    42c5:	41 55                	push   %r13
    42c7:	41 54                	push   %r12
    42c9:	53                   	push   %rbx
    42ca:	48 83 ec 28          	sub    $0x28,%rsp
    42ce:	48 8d 3d cb ef 00 00 	lea    0xefcb(%rip),%rdi        # 132a0 <fwp_gc+0x8>
    42d5:	45 31 ff             	xor    %r15d,%r15d
    42d8:	ba 40 0b 00 00       	mov    $0xb40,%edx
    42dd:	31 f6                	xor    %esi,%esi
    42df:	e8 2c df ff ff       	call   2210 <memset@plt>
    42e4:	48 83 3d 04 00 01 00 	cmpq   $0x0,0x10004(%rip)        # 142f0 <fwp_gc+0x1058>
    42eb:	00 
    42ec:	0f 84 06 05 00 00    	je     47f8 <fwp_gc_sweep+0x538>
    42f2:	31 c0                	xor    %eax,%eax
    42f4:	48 89 44 24 08       	mov    %rax,0x8(%rsp)
    42f9:	49 be 55 55 55 55 55 	movabs $0x5555555555555555,%r14
    4300:	55 55 55 
    4303:	49 b9 33 33 33 33 33 	movabs $0x3333333333333333,%r9
    430a:	33 33 33 
    430d:	49 ba 0f 0f 0f 0f 0f 	movabs $0xf0f0f0f0f0f0f0f,%r10
    4314:	0f 0f 0f 
    4317:	49 bb 01 01 01 01 01 	movabs $0x101010101010101,%r11
    431e:	01 01 01 
    4321:	66 0f 6f 2d c7 8d 00 	movdqa 0x8dc7(%rip),%xmm5        # d0f0 <_IO_stdin_used+0xf0>
    4328:	00 
    4329:	66 0f 6f 35 cf 8d 00 	movdqa 0x8dcf(%rip),%xmm6        # d100 <_IO_stdin_used+0x100>
    4330:	00 
    4331:	66 0f 6f 3d d7 8d 00 	movdqa 0x8dd7(%rip),%xmm7        # d110 <_IO_stdin_used+0x110>
    4338:	00 
    4339:	66 45 0f ef c0       	pxor   %xmm8,%xmm8
    433e:	45 31 ff             	xor    %r15d,%r15d
    4341:	31 db                	xor    %ebx,%ebx
    4343:	eb 63                	jmp    43a8 <fwp_gc_sweep+0xe8>
    4345:	4c 8b 64 24 10       	mov    0x10(%rsp),%r12
    434a:	4c 89 e7             	mov    %r12,%rdi
    434d:	e8 ee 09 00 00       	call   4d40 <fwp_rc_clear_chunk>
    4352:	66 45 0f ef c0       	pxor   %xmm8,%xmm8
    4357:	66 0f 6f 3d b1 8d 00 	movdqa 0x8db1(%rip),%xmm7        # d110 <_IO_stdin_used+0x110>
    435e:	00 
    435f:	66 0f 6f 35 99 8d 00 	movdqa 0x8d99(%rip),%xmm6        # d100 <_IO_stdin_used+0x100>
    4366:	00 
    4367:	66 0f 6f 2d 81 8d 00 	movdqa 0x8d81(%rip),%xmm5        # d0f0 <_IO_stdin_used+0xf0>
    436e:	00 
    436f:	49 bb 01 01 01 01 01 	movabs $0x101010101010101,%r11
    4376:	01 01 01 
    4379:	49 ba 0f 0f 0f 0f 0f 	movabs $0xf0f0f0f0f0f0f0f,%r10
    4380:	0f 0f 0f 
    4383:	49 b9 33 33 33 33 33 	movabs $0x3333333333333333,%r9
    438a:	33 33 33 
    438d:	41 c6 04 24 00       	movb   $0x0,(%r12)
    4392:	49 ff c7             	inc    %r15
    4395:	48 ff c3             	inc    %rbx
    4398:	48 8b 05 51 ff 00 00 	mov    0xff51(%rip),%rax        # 142f0 <fwp_gc+0x1058>
    439f:	48 39 c3             	cmp    %rax,%rbx
    43a2:	0f 83 59 04 00 00    	jae    4801 <fwp_gc_sweep+0x541>
    43a8:	4c 8b 2d 61 ff 00 00 	mov    0xff61(%rip),%r13        # 14310 <fwp_gc+0x1078>
    43af:	4c 69 e3 28 12 00 00 	imul   $0x1228,%rbx,%r12
    43b6:	43 0f b6 44 25 00    	movzbl 0x0(%r13,%r12,1),%eax
    43bc:	85 c0                	test   %eax,%eax
    43be:	74 d2                	je     4392 <fwp_gc_sweep+0xd2>
    43c0:	83 f8 01             	cmp    $0x1,%eax
    43c3:	74 2b                	je     43f0 <fwp_gc_sweep+0x130>
    43c5:	83 f8 02             	cmp    $0x2,%eax
    43c8:	75 cb                	jne    4395 <fwp_gc_sweep+0xd5>
    43ca:	47 8b 74 25 10       	mov    0x10(%r13,%r12,1),%r14d
    43cf:	43 80 7c 25 03 00    	cmpb   $0x0,0x3(%r13,%r12,1)
    43d5:	74 4c                	je     4423 <fwp_gc_sweep+0x163>
    43d7:	48 8b 44 24 08       	mov    0x8(%rsp),%rax
    43dc:	4b 03 44 25 18       	add    0x18(%r13,%r12,1),%rax
    43e1:	48 89 44 24 08       	mov    %rax,0x8(%rsp)
    43e6:	e9 f8 03 00 00       	jmp    47e3 <fwp_gc_sweep+0x523>
    43eb:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)
    43f0:	4b 8d 04 2c          	lea    (%r12,%r13,1),%rax
    43f4:	48 89 44 24 10       	mov    %rax,0x10(%rsp)
    43f9:	43 8b 6c 25 0c       	mov    0xc(%r13,%r12,1),%ebp
    43fe:	48 85 ed             	test   %rbp,%rbp
    4401:	0f 84 3e ff ff ff    	je     4345 <fwp_gc_sweep+0x85>
    4407:	48 8d 55 3f          	lea    0x3f(%rbp),%rdx
    440b:	48 89 d0             	mov    %rdx,%rax
    440e:	48 c1 e8 06          	shr    $0x6,%rax
    4412:	81 fd c1 00 00 00    	cmp    $0xc1,%ebp
    4418:	73 75                	jae    448f <fwp_gc_sweep+0x1cf>
    441a:	31 d2                	xor    %edx,%edx
    441c:	31 c9                	xor    %ecx,%ecx
    441e:	e9 3c 01 00 00       	jmp    455f <fwp_gc_sweep+0x29f>
    4423:	4b 8d 3c 2c          	lea    (%r12,%r13,1),%rdi
    4427:	48 81 c7 28 02 00 00 	add    $0x228,%rdi
    442e:	e8 0d e9 ff ff       	call   2d40 <fwp_rc_clear_slot>
    4433:	66 45 0f ef c0       	pxor   %xmm8,%xmm8
    4438:	66 0f 6f 3d d0 8c 00 	movdqa 0x8cd0(%rip),%xmm7        # d110 <_IO_stdin_used+0x110>
    443f:	00 
    4440:	66 0f 6f 35 b8 8c 00 	movdqa 0x8cb8(%rip),%xmm6        # d100 <_IO_stdin_used+0x100>
    4447:	00 
    4448:	66 0f 6f 2d a0 8c 00 	movdqa 0x8ca0(%rip),%xmm5        # d0f0 <_IO_stdin_used+0xf0>
    444f:	00 
    4450:	49 bb 01 01 01 01 01 	movabs $0x101010101010101,%r11
    4457:	01 01 01 
    445a:	49 ba 0f 0f 0f 0f 0f 	movabs $0xf0f0f0f0f0f0f0f,%r10
    4461:	0f 0f 0f 
    4464:	49 b9 33 33 33 33 33 	movabs $0x3333333333333333,%r9
    446b:	33 33 33 
    446e:	4d 85 f6             	test   %r14,%r14
    4471:	0f 84 69 03 00 00    	je     47e0 <fwp_gc_sweep+0x520>
    4477:	48 8b 05 92 fe 00 00 	mov    0xfe92(%rip),%rax        # 14310 <fwp_gc+0x1078>
    447e:	41 83 fe 04          	cmp    $0x4,%r14d
    4482:	0f 83 e6 02 00 00    	jae    476e <fwp_gc_sweep+0x4ae>
    4488:	31 c9                	xor    %ecx,%ecx
    448a:	e9 19 03 00 00       	jmp    47a8 <fwp_gc_sweep+0x4e8>
    448f:	89 c1                	mov    %eax,%ecx
    4491:	83 e1 fc             	and    $0xfffffffc,%ecx
    4494:	4b 8d 34 2c          	lea    (%r12,%r13,1),%rsi
    4498:	48 83 c6 38          	add    $0x38,%rsi
    449c:	48 c1 ea 03          	shr    $0x3,%rdx
    44a0:	83 e2 e0             	and    $0xffffffe0,%edx
    44a3:	66 0f ef c0          	pxor   %xmm0,%xmm0
    44a7:	31 ff                	xor    %edi,%edi
    44a9:	66 0f ef c9          	pxor   %xmm1,%xmm1
    44ad:	0f 1f 00             	nopl   (%rax)
    44b0:	f3 0f 6f 5c 3e f0    	movdqu -0x10(%rsi,%rdi,1),%xmm3
    44b6:	f3 0f 6f 14 3e       	movdqu (%rsi,%rdi,1),%xmm2
    44bb:	66 0f 6f e3          	movdqa %xmm3,%xmm4
    44bf:	66 0f 71 d4 01       	psrlw  $0x1,%xmm4
    44c4:	66 0f db e5          	pand   %xmm5,%xmm4
    44c8:	66 0f f8 dc          	psubb  %xmm4,%xmm3
    44cc:	66 0f 6f e3          	movdqa %xmm3,%xmm4
    44d0:	66 0f db e6          	pand   %xmm6,%xmm4
    44d4:	66 0f 71 d3 02       	psrlw  $0x2,%xmm3
    44d9:	66 0f db de          	pand   %xmm6,%xmm3
    44dd:	66 0f fc dc          	paddb  %xmm4,%xmm3
    44e1:	66 0f 6f e3          	movdqa %xmm3,%xmm4
    44e5:	66 0f 71 d4 04       	psrlw  $0x4,%xmm4
    44ea:	66 0f fc e3          	paddb  %xmm3,%xmm4
    44ee:	66 0f db e7          	pand   %xmm7,%xmm4
    44f2:	66 41 0f f6 e0       	psadbw %xmm8,%xmm4
    44f7:	66 0f d4 c4          	paddq  %xmm4,%xmm0
    44fb:	66 0f 6f da          	movdqa %xmm2,%xmm3
    44ff:	66 0f 71 d3 01       	psrlw  $0x1,%xmm3
    4504:	66 0f db dd          	pand   %xmm5,%xmm3
    4508:	66 0f f8 d3          	psubb  %xmm3,%xmm2
    450c:	66 0f 6f da          	movdqa %xmm2,%xmm3
    4510:	66 0f db de          	pand   %xmm6,%xmm3
    4514:	66 0f 71 d2 02       	psrlw  $0x2,%xmm2
    4519:	66 0f db d6          	pand   %xmm6,%xmm2
    451d:	66 0f fc d3          	paddb  %xmm3,%xmm2
    4521:	66 0f 6f da          	movdqa %xmm2,%xmm3
    4525:	66 0f 71 d3 04       	psrlw  $0x4,%xmm3
    452a:	66 0f fc da          	paddb  %xmm2,%xmm3
    452e:	66 0f db df          	pand   %xmm7,%xmm3
    4532:	66 41 0f f6 d8       	psadbw %xmm8,%xmm3
    4537:	66 0f d4 cb          	paddq  %xmm3,%xmm1
    453b:	48 83 c7 20          	add    $0x20,%rdi
    453f:	48 39 fa             	cmp    %rdi,%rdx
    4542:	0f 85 68 ff ff ff    	jne    44b0 <fwp_gc_sweep+0x1f0>
    4548:	66 0f d4 c8          	paddq  %xmm0,%xmm1
    454c:	66 0f 70 c1 ee       	pshufd $0xee,%xmm1,%xmm0
    4551:	66 0f d4 c1          	paddq  %xmm1,%xmm0
    4555:	66 48 0f 7e c2       	movq   %xmm0,%rdx
    455a:	48 39 c8             	cmp    %rcx,%rax
    455d:	74 51                	je     45b0 <fwp_gc_sweep+0x2f0>
    455f:	4b 8d 34 2c          	lea    (%r12,%r13,1),%rsi
    4563:	48 83 c6 28          	add    $0x28,%rsi
    4567:	66 0f 1f 84 00 00 00 	nopw   0x0(%rax,%rax,1)
    456e:	00 00 
    4570:	48 8b 3c ce          	mov    (%rsi,%rcx,8),%rdi
    4574:	49 89 f8             	mov    %rdi,%r8
    4577:	49 d1 e8             	shr    $1,%r8
    457a:	4d 21 f0             	and    %r14,%r8
    457d:	4c 29 c7             	sub    %r8,%rdi
    4580:	49 89 f8             	mov    %rdi,%r8
    4583:	4d 21 c8             	and    %r9,%r8
    4586:	48 c1 ef 02          	shr    $0x2,%rdi
    458a:	4c 21 cf             	and    %r9,%rdi
    458d:	4c 01 c7             	add    %r8,%rdi
    4590:	49 89 f8             	mov    %rdi,%r8
    4593:	49 c1 e8 04          	shr    $0x4,%r8
    4597:	49 01 f8             	add    %rdi,%r8
    459a:	4d 21 d0             	and    %r10,%r8
    459d:	4d 0f af c3          	imul   %r11,%r8
    45a1:	49 c1 e8 38          	shr    $0x38,%r8
    45a5:	4c 01 c2             	add    %r8,%rdx
    45a8:	48 ff c1             	inc    %rcx
    45ab:	48 39 c8             	cmp    %rcx,%rax
    45ae:	75 c0                	jne    4570 <fwp_gc_sweep+0x2b0>
    45b0:	48 85 d2             	test   %rdx,%rdx
    45b3:	0f 84 8c fd ff ff    	je     4345 <fwp_gc_sweep+0x85>
    45b9:	4c 89 7c 24 18       	mov    %r15,0x18(%rsp)
    45be:	43 8b 44 25 08       	mov    0x8(%r13,%r12,1),%eax
    45c3:	48 0f af d0          	imul   %rax,%rdx
    45c7:	48 01 54 24 08       	add    %rdx,0x8(%rsp)
    45cc:	47 0f b6 74 25 01    	movzbl 0x1(%r13,%r12,1),%r14d
    45d2:	47 0f b6 7c 25 02    	movzbl 0x2(%r13,%r12,1),%r15d
    45d8:	48 89 df             	mov    %rbx,%rdi
    45db:	e8 80 e7 ff ff       	call   2d60 <fwp_gc_chunk_addr>
    45e0:	48 89 44 24 20       	mov    %rax,0x20(%rsp)
    45e5:	48 85 ed             	test   %rbp,%rbp
    45e8:	0f 84 31 01 00 00    	je     471f <fwp_gc_sweep+0x45f>
    45ee:	49 69 c6 c0 03 00 00 	imul   $0x3c0,%r14,%rax
    45f5:	48 8d 0d 9c ec 00 00 	lea    0xec9c(%rip),%rcx        # 13298 <fwp_gc>
    45fc:	48 01 c8             	add    %rcx,%rax
    45ff:	4f 8d 34 2c          	lea    (%r12,%r13,1),%r14
    4603:	49 83 c6 08          	add    $0x8,%r14
    4607:	4b 8d 0c 7f          	lea    (%r15,%r15,2),%rcx
    460b:	4c 8d 3c c8          	lea    (%rax,%rcx,8),%r15
    460f:	49 83 c7 08          	add    $0x8,%r15
    4613:	49 01 ec             	add    %rbp,%r12
    4616:	4d 01 ec             	add    %r13,%r12
    4619:	49 81 c4 27 02 00 00 	add    $0x227,%r12
    4620:	48 ff cd             	dec    %rbp
    4623:	49 b9 33 33 33 33 33 	movabs $0x3333333333333333,%r9
    462a:	33 33 33 
    462d:	49 ba 0f 0f 0f 0f 0f 	movabs $0xf0f0f0f0f0f0f0f,%r10
    4634:	0f 0f 0f 
    4637:	49 bb 01 01 01 01 01 	movabs $0x101010101010101,%r11
    463e:	01 01 01 
    4641:	66 0f 6f 2d a7 8a 00 	movdqa 0x8aa7(%rip),%xmm5        # d0f0 <_IO_stdin_used+0xf0>
    4648:	00 
    4649:	66 0f 6f 35 af 8a 00 	movdqa 0x8aaf(%rip),%xmm6        # d100 <_IO_stdin_used+0x100>
    4650:	00 
    4651:	66 0f 6f 3d b7 8a 00 	movdqa 0x8ab7(%rip),%xmm7        # d110 <_IO_stdin_used+0x110>
    4658:	00 
    4659:	66 45 0f ef c0       	pxor   %xmm8,%xmm8
    465e:	48 8b 4c 24 10       	mov    0x10(%rsp),%rcx
    4663:	eb 69                	jmp    46ce <fwp_gc_sweep+0x40e>
    4665:	66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
    466c:	00 00 00 00 
    4670:	4c 89 e7             	mov    %r12,%rdi
    4673:	e8 c8 e6 ff ff       	call   2d40 <fwp_rc_clear_slot>
    4678:	49 8b 07             	mov    (%r15),%rax
    467b:	48 f7 d0             	not    %rax
    467e:	49 89 45 00          	mov    %rax,0x0(%r13)
    4682:	4d 89 2f             	mov    %r13,(%r15)
    4685:	49 b9 33 33 33 33 33 	movabs $0x3333333333333333,%r9
    468c:	33 33 33 
    468f:	49 ba 0f 0f 0f 0f 0f 	movabs $0xf0f0f0f0f0f0f0f,%r10
    4696:	0f 0f 0f 
    4699:	49 bb 01 01 01 01 01 	movabs $0x101010101010101,%r11
    46a0:	01 01 01 
    46a3:	66 0f 6f 2d 45 8a 00 	movdqa 0x8a45(%rip),%xmm5        # d0f0 <_IO_stdin_used+0xf0>
    46aa:	00 
    46ab:	66 0f 6f 35 4d 8a 00 	movdqa 0x8a4d(%rip),%xmm6        # d100 <_IO_stdin_used+0x100>
    46b2:	00 
    46b3:	66 0f 6f 3d 55 8a 00 	movdqa 0x8a55(%rip),%xmm7        # d110 <_IO_stdin_used+0x110>
    46ba:	00 
    46bb:	66 45 0f ef c0       	pxor   %xmm8,%xmm8
    46c0:	48 8b 4c 24 10       	mov    0x10(%rsp),%rcx
    46c5:	49 ff cc             	dec    %r12
    46c8:	48 83 c5 ff          	add    $0xffffffffffffffff,%rbp
    46cc:	73 3d                	jae    470b <fwp_gc_sweep+0x44b>
    46ce:	48 89 e8             	mov    %rbp,%rax
    46d1:	48 c1 e8 06          	shr    $0x6,%rax
    46d5:	48 8b 44 c1 28       	mov    0x28(%rcx,%rax,8),%rax
    46da:	48 0f a3 e8          	bt     %rbp,%rax
    46de:	72 e5                	jb     46c5 <fwp_gc_sweep+0x405>
    46e0:	41 8b 16             	mov    (%r14),%edx
    46e3:	49 89 ed             	mov    %rbp,%r13
    46e6:	4c 0f af ea          	imul   %rdx,%r13
    46ea:	4c 03 6c 24 20       	add    0x20(%rsp),%r13
    46ef:	83 3d a6 fb 00 00 00 	cmpl   $0x0,0xfba6(%rip)        # 1429c <fwp_gc+0x1004>
    46f6:	0f 84 74 ff ff ff    	je     4670 <fwp_gc_sweep+0x3b0>
    46fc:	4c 89 ef             	mov    %r13,%rdi
    46ff:	31 f6                	xor    %esi,%esi
    4701:	e8 0a db ff ff       	call   2210 <memset@plt>
    4706:	e9 65 ff ff ff       	jmp    4670 <fwp_gc_sweep+0x3b0>
    470b:	4c 8b 7c 24 18       	mov    0x18(%rsp),%r15
    4710:	49 be 55 55 55 55 55 	movabs $0x5555555555555555,%r14
    4717:	55 55 55 
    471a:	e9 76 fc ff ff       	jmp    4395 <fwp_gc_sweep+0xd5>
    471f:	4c 8b 7c 24 18       	mov    0x18(%rsp),%r15
    4724:	49 be 55 55 55 55 55 	movabs $0x5555555555555555,%r14
    472b:	55 55 55 
    472e:	49 b9 33 33 33 33 33 	movabs $0x3333333333333333,%r9
    4735:	33 33 33 
    4738:	49 ba 0f 0f 0f 0f 0f 	movabs $0xf0f0f0f0f0f0f0f,%r10
    473f:	0f 0f 0f 
    4742:	49 bb 01 01 01 01 01 	movabs $0x101010101010101,%r11
    4749:	01 01 01 
    474c:	66 0f 6f 2d 9c 89 00 	movdqa 0x899c(%rip),%xmm5        # d0f0 <_IO_stdin_used+0xf0>
    4753:	00 
    4754:	66 0f 6f 35 a4 89 00 	movdqa 0x89a4(%rip),%xmm6        # d100 <_IO_stdin_used+0x100>
    475b:	00 
    475c:	66 0f 6f 3d ac 89 00 	movdqa 0x89ac(%rip),%xmm7        # d110 <_IO_stdin_used+0x110>
    4763:	00 
    4764:	66 45 0f ef c0       	pxor   %xmm8,%xmm8
    4769:	e9 27 fc ff ff       	jmp    4395 <fwp_gc_sweep+0xd5>
    476e:	4a 8d 14 20          	lea    (%rax,%r12,1),%rdx
    4772:	44 89 f6             	mov    %r14d,%esi
    4775:	83 e6 fc             	and    $0xfffffffc,%esi
    4778:	31 c9                	xor    %ecx,%ecx
    477a:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)
    4780:	c6 02 00             	movb   $0x0,(%rdx)
    4783:	c6 82 28 12 00 00 00 	movb   $0x0,0x1228(%rdx)
    478a:	c6 82 50 24 00 00 00 	movb   $0x0,0x2450(%rdx)
    4791:	c6 82 78 36 00 00 00 	movb   $0x0,0x3678(%rdx)
    4798:	48 83 c1 04          	add    $0x4,%rcx
    479c:	48 81 c2 a0 48 00 00 	add    $0x48a0,%rdx
    47a3:	48 39 ce             	cmp    %rcx,%rsi
    47a6:	75 d8                	jne    4780 <fwp_gc_sweep+0x4c0>
    47a8:	44 89 f2             	mov    %r14d,%edx
    47ab:	83 e2 03             	and    $0x3,%edx
    47ae:	74 30                	je     47e0 <fwp_gc_sweep+0x520>
    47b0:	48 69 c9 28 12 00 00 	imul   $0x1228,%rcx,%rcx
    47b7:	4c 01 e1             	add    %r12,%rcx
    47ba:	48 01 c8             	add    %rcx,%rax
    47bd:	48 69 ca 28 12 00 00 	imul   $0x1228,%rdx,%rcx
    47c4:	31 d2                	xor    %edx,%edx
    47c6:	66 2e 0f 1f 84 00 00 	cs nopw 0x0(%rax,%rax,1)
    47cd:	00 00 00 
    47d0:	c6 04 10 00          	movb   $0x0,(%rax,%rdx,1)
    47d4:	48 81 c2 28 12 00 00 	add    $0x1228,%rdx
    47db:	48 39 d1             	cmp    %rdx,%rcx
    47de:	75 f0                	jne    47d0 <fwp_gc_sweep+0x510>
    47e0:	4d 01 f7             	add    %r14,%r15
    47e3:	4c 01 f3             	add    %r14,%rbx
    47e6:	48 ff cb             	dec    %rbx
    47e9:	49 be 55 55 55 55 55 	movabs $0x5555555555555555,%r14
    47f0:	55 55 55 
    47f3:	e9 9d fb ff ff       	jmp    4395 <fwp_gc_sweep+0xd5>
    47f8:	31 c0                	xor    %eax,%eax
    47fa:	48 89 44 24 08       	mov    %rax,0x8(%rsp)
    47ff:	31 c0                	xor    %eax,%eax
    4801:	48 8b 54 24 08       	mov    0x8(%rsp),%rdx
    4806:	48 89 15 53 fc 00 00 	mov    %rdx,0xfc53(%rip)        # 14460 <fwp_gc+0x11c8>
    480d:	4c 89 3d 64 fc 00 00 	mov    %r15,0xfc64(%rip)        # 14478 <fwp_gc+0x11e0>
    4814:	48 81 fa 01 00 00 01 	cmp    $0x1000001,%rdx
    481b:	b9 00 00 00 01       	mov    $0x1000000,%ecx
    4820:	48 0f 43 ca          	cmovae %rdx,%rcx
    4824:	48 c1 e9 10          	shr    $0x10,%rcx
    4828:	66 0f ef c0          	pxor   %xmm0,%xmm0
    482c:	f3 0f 7f 05 cc fa 00 	movdqu %xmm0,0xfacc(%rip)        # 14300 <fwp_gc+0x1068>
    4833:	00 
    4834:	49 29 cf             	sub    %rcx,%r15
    4837:	0f 86 01 01 00 00    	jbe    493e <fwp_gc_sweep+0x67e>
    483d:	48 85 c0             	test   %rax,%rax
    4840:	0f 84 f8 00 00 00    	je     493e <fwp_gc_sweep+0x67e>
    4846:	4d 85 ff             	test   %r15,%r15
    4849:	0f 84 ef 00 00 00    	je     493e <fwp_gc_sweep+0x67e>
    484f:	48 8b 0d ba fa 00 00 	mov    0xfaba(%rip),%rcx        # 14310 <fwp_gc+0x1078>
    4856:	66 2e 0f 1f 84 00 00 	cs nopw 0x0(%rax,%rax,1)
    485d:	00 00 00 
    4860:	48 8d 58 ff          	lea    -0x1(%rax),%rbx
    4864:	48 69 d3 28 12 00 00 	imul   $0x1228,%rbx,%rdx
    486b:	80 3c 11 00          	cmpb   $0x0,(%rcx,%rdx,1)
    486f:	0f 85 b8 00 00 00    	jne    492d <fwp_gc_sweep+0x66d>
    4875:	4c 89 ff             	mov    %r15,%rdi
    4878:	49 ff cf             	dec    %r15
    487b:	80 7c 11 04 00       	cmpb   $0x0,0x4(%rcx,%rdx,1)
    4880:	0f 84 a7 00 00 00    	je     492d <fwp_gc_sweep+0x66d>
    4886:	48 01 ca             	add    %rcx,%rdx
    4889:	48 83 c2 04          	add    $0x4,%rdx
    488d:	c6 02 00             	movb   $0x0,(%rdx)
    4890:	41 be 01 00 00 00    	mov    $0x1,%r14d
    4896:	48 85 db             	test   %rbx,%rbx
    4899:	74 6f                	je     490a <fwp_gc_sweep+0x64a>
    489b:	4d 85 ff             	test   %r15,%r15
    489e:	74 6a                	je     490a <fwp_gc_sweep+0x64a>
    48a0:	ba 02 00 00 00       	mov    $0x2,%edx
    48a5:	48 29 c2             	sub    %rax,%rdx
    48a8:	48 69 c0 28 12 00 00 	imul   $0x1228,%rax,%rax
    48af:	48 01 c1             	add    %rax,%rcx
    48b2:	48 81 c1 b4 db ff ff 	add    $0xffffffffffffdbb4,%rcx
    48b9:	be 02 00 00 00       	mov    $0x2,%esi
    48be:	48 29 fe             	sub    %rdi,%rsi
    48c1:	b8 01 00 00 00       	mov    $0x1,%eax
    48c6:	66 2e 0f 1f 84 00 00 	cs nopw 0x0(%rax,%rax,1)
    48cd:	00 00 00 
    48d0:	80 79 fc 00          	cmpb   $0x0,-0x4(%rcx)
    48d4:	75 31                	jne    4907 <fwp_gc_sweep+0x647>
    48d6:	80 39 00             	cmpb   $0x0,(%rcx)
    48d9:	74 2c                	je     4907 <fwp_gc_sweep+0x647>
    48db:	48 ff cb             	dec    %rbx
    48de:	48 8d 3c 02          	lea    (%rdx,%rax,1),%rdi
    48e2:	49 ff cf             	dec    %r15
    48e5:	c6 01 00             	movb   $0x0,(%rcx)
    48e8:	4c 8d 70 01          	lea    0x1(%rax),%r14
    48ec:	48 83 ff 01          	cmp    $0x1,%rdi
    48f0:	74 18                	je     490a <fwp_gc_sweep+0x64a>
    48f2:	48 01 f0             	add    %rsi,%rax
    48f5:	48 81 c1 d8 ed ff ff 	add    $0xffffffffffffedd8,%rcx
    48fc:	48 83 f8 01          	cmp    $0x1,%rax
    4900:	4c 89 f0             	mov    %r14,%rax
    4903:	75 cb                	jne    48d0 <fwp_gc_sweep+0x610>
    4905:	eb 03                	jmp    490a <fwp_gc_sweep+0x64a>
    4907:	49 89 c6             	mov    %rax,%r14
    490a:	48 89 df             	mov    %rbx,%rdi
    490d:	e8 4e e4 ff ff       	call   2d60 <fwp_gc_chunk_addr>
    4912:	49 c1 e6 10          	shl    $0x10,%r14
    4916:	48 89 c7             	mov    %rax,%rdi
    4919:	4c 89 f6             	mov    %r14,%rsi
    491c:	ba 04 00 00 00       	mov    $0x4,%edx
    4921:	e8 ca da ff ff       	call   23f0 <madvise@plt>
    4926:	48 8b 0d e3 f9 00 00 	mov    0xf9e3(%rip),%rcx        # 14310 <fwp_gc+0x1078>
    492d:	48 89 d8             	mov    %rbx,%rax
    4930:	48 85 db             	test   %rbx,%rbx
    4933:	74 09                	je     493e <fwp_gc_sweep+0x67e>
    4935:	4d 85 ff             	test   %r15,%r15
    4938:	0f 85 22 ff ff ff    	jne    4860 <fwp_gc_sweep+0x5a0>
    493e:	48 83 c4 28          	add    $0x28,%rsp
    4942:	5b                   	pop    %rbx
    4943:	41 5c                	pop    %r12
    4945:	41 5d                	pop    %r13
    4947:	41 5e                	pop    %r14
    4949:	41 5f                	pop    %r15
    494b:	5d                   	pop    %rbp
    494c:	c3                   	ret
    494d:	0f 1f 00             	nopl   (%rax)

0000000000004950 <fwp_gc_scan_stacks>:
    4950:	48 8b 35 c9 f9 00 00 	mov    0xf9c9(%rip),%rsi        # 14320 <fwp_gc+0x1088>
    4957:	e9 04 01 00 00       	jmp    4a60 <fwp_gc_scan_root>
    495c:	0f 1f 40 00          	nopl   0x0(%rax)

0000000000004960 <fwp_gc_sp>:
    4960:	55                   	push   %rbp
    4961:	48 89 e5             	mov    %rsp,%rbp
    4964:	48 89 e8             	mov    %rbp,%rax
    4967:	5d                   	pop    %rbp
    4968:	c3                   	ret
    4969:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)

0000000000004970 <fwp_gc_drain>:
    4970:	48 8b 05 c1 fa 00 00 	mov    0xfac1(%rip),%rax        # 14438 <fwp_gc+0x11a0>
    4977:	48 85 c0             	test   %rax,%rax
    497a:	74 3c                	je     49b8 <fwp_gc_drain+0x48>
    497c:	50                   	push   %rax
    497d:	0f 1f 00             	nopl   (%rax)
    4980:	48 8b 0d a9 fa 00 00 	mov    0xfaa9(%rip),%rcx        # 14430 <fwp_gc+0x1198>
    4987:	48 ff c8             	dec    %rax
    498a:	48 89 05 a7 fa 00 00 	mov    %rax,0xfaa7(%rip)        # 14438 <fwp_gc+0x11a0>
    4991:	48 c1 e0 04          	shl    $0x4,%rax
    4995:	48 8b 3c 01          	mov    (%rcx,%rax,1),%rdi
    4999:	48 8b 74 01 08       	mov    0x8(%rcx,%rax,1),%rsi
    499e:	48 01 fe             	add    %rdi,%rsi
    49a1:	31 d2                	xor    %edx,%edx
    49a3:	e8 e8 00 00 00       	call   4a90 <fwp_gc_scan>
    49a8:	48 8b 05 89 fa 00 00 	mov    0xfa89(%rip),%rax        # 14438 <fwp_gc+0x11a0>
    49af:	48 85 c0             	test   %rax,%rax
    49b2:	75 cc                	jne    4980 <fwp_gc_drain+0x10>
    49b4:	48 83 c4 08          	add    $0x8,%rsp
    49b8:	c3                   	ret
    49b9:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)

00000000000049c0 <fwp_gc_scan_data>:
    49c0:	83 3d 61 fa 00 00 00 	cmpl   $0x0,0xfa61(%rip)        # 14428 <fwp_gc+0x1190>
    49c7:	0f 8e 87 00 00 00    	jle    4a54 <fwp_gc_scan_data+0x94>
    49cd:	41 57                	push   %r15
    49cf:	41 56                	push   %r14
    49d1:	41 55                	push   %r13
    49d3:	41 54                	push   %r12
    49d5:	53                   	push   %rbx
    49d6:	4c 8d 25 53 f9 00 00 	lea    0xf953(%rip),%r12        # 14330 <fwp_gc+0x1098>
    49dd:	45 31 ed             	xor    %r13d,%r13d
    49e0:	48 8d 1d b1 e8 00 00 	lea    0xe8b1(%rip),%rbx        # 13298 <fwp_gc>
    49e7:	4c 8d 35 ca 02 01 00 	lea    0x102ca(%rip),%r14        # 14cb8 <fwp_reuse_verify>
    49ee:	eb 1d                	jmp    4a0d <fwp_gc_scan_data+0x4d>
    49f0:	4c 89 fe             	mov    %r15,%rsi
    49f3:	31 d2                	xor    %edx,%edx
    49f5:	e8 96 00 00 00       	call   4a90 <fwp_gc_scan>
    49fa:	49 ff c5             	inc    %r13
    49fd:	48 63 05 24 fa 00 00 	movslq 0xfa24(%rip),%rax        # 14428 <fwp_gc+0x1190>
    4a04:	49 83 c4 10          	add    $0x10,%r12
    4a08:	49 39 c5             	cmp    %rax,%r13
    4a0b:	7d 3e                	jge    4a4b <fwp_gc_scan_data+0x8b>
    4a0d:	49 8b 7c 24 f8       	mov    -0x8(%r12),%rdi
    4a12:	49 8b 04 24          	mov    (%r12),%rax
    4a16:	4c 8d 3c 07          	lea    (%rdi,%rax,1),%r15
    4a1a:	0f 57 c0             	xorps  %xmm0,%xmm0
    4a1d:	f2 48 0f 2a c0       	cvtsi2sd %rax,%xmm0
    4a22:	f2 0f 58 05 6e fa 00 	addsd  0xfa6e(%rip),%xmm0        # 14498 <fwp_gc+0x1200>
    4a29:	00 
    4a2a:	f2 0f 11 05 66 fa 00 	movsd  %xmm0,0xfa66(%rip)        # 14498 <fwp_gc+0x1200>
    4a31:	00 
    4a32:	48 39 df             	cmp    %rbx,%rdi
    4a35:	77 b9                	ja     49f0 <fwp_gc_scan_data+0x30>
    4a37:	4d 39 f7             	cmp    %r14,%r15
    4a3a:	72 b4                	jb     49f0 <fwp_gc_scan_data+0x30>
    4a3c:	48 89 de             	mov    %rbx,%rsi
    4a3f:	31 d2                	xor    %edx,%edx
    4a41:	e8 4a 00 00 00       	call   4a90 <fwp_gc_scan>
    4a46:	4c 89 f7             	mov    %r14,%rdi
    4a49:	eb a5                	jmp    49f0 <fwp_gc_scan_data+0x30>
    4a4b:	5b                   	pop    %rbx
    4a4c:	41 5c                	pop    %r12
    4a4e:	41 5d                	pop    %r13
    4a50:	41 5e                	pop    %r14
    4a52:	41 5f                	pop    %r15
    4a54:	c3                   	ret
    4a55:	66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
    4a5c:	00 00 00 00 

0000000000004a60 <fwp_gc_scan_root>:
    4a60:	48 85 ff             	test   %rdi,%rdi
    4a63:	74 24                	je     4a89 <fwp_gc_scan_root+0x29>
    4a65:	48 89 f0             	mov    %rsi,%rax
    4a68:	48 29 f8             	sub    %rdi,%rax
    4a6b:	76 1c                	jbe    4a89 <fwp_gc_scan_root+0x29>
    4a6d:	f2 48 0f 2a c0       	cvtsi2sd %rax,%xmm0
    4a72:	f2 0f 58 05 1e fa 00 	addsd  0xfa1e(%rip),%xmm0        # 14498 <fwp_gc+0x1200>
    4a79:	00 
    4a7a:	f2 0f 11 05 16 fa 00 	movsd  %xmm0,0xfa16(%rip)        # 14498 <fwp_gc+0x1200>
    4a81:	00 
    4a82:	ba 01 00 00 00       	mov    $0x1,%edx
    4a87:	eb 07                	jmp    4a90 <fwp_gc_scan>
    4a89:	c3                   	ret
    4a8a:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)

0000000000004a90 <fwp_gc_scan>:
    4a90:	55                   	push   %rbp
    4a91:	41 57                	push   %r15
    4a93:	41 56                	push   %r14
    4a95:	41 55                	push   %r13
    4a97:	41 54                	push   %r12
    4a99:	53                   	push   %rbx
    4a9a:	50                   	push   %rax
    4a9b:	49 89 ff             	mov    %rdi,%r15
    4a9e:	49 83 c7 07          	add    $0x7,%r15
    4aa2:	49 83 e7 f8          	and    $0xfffffffffffffff8,%r15
    4aa6:	49 8d 47 08          	lea    0x8(%r15),%rax
    4aaa:	48 39 f0             	cmp    %rsi,%rax
    4aad:	76 0f                	jbe    4abe <fwp_gc_scan+0x2e>
    4aaf:	48 83 c4 08          	add    $0x8,%rsp
    4ab3:	5b                   	pop    %rbx
    4ab4:	41 5c                	pop    %r12
    4ab6:	41 5d                	pop    %r13
    4ab8:	41 5e                	pop    %r14
    4aba:	41 5f                	pop    %r15
    4abc:	5d                   	pop    %rbp
    4abd:	c3                   	ret
    4abe:	89 d3                	mov    %edx,%ebx
    4ac0:	49 89 f6             	mov    %rsi,%r14
    4ac3:	4c 8b 2d fe f7 00 00 	mov    0xf7fe(%rip),%r13        # 142c8 <fwp_gc+0x1030>
    4aca:	48 8b 2d 1f f8 00 00 	mov    0xf81f(%rip),%rbp        # 142f0 <fwp_gc+0x1058>
    4ad1:	48 c1 e5 10          	shl    $0x10,%rbp
    4ad5:	eb 30                	jmp    4b07 <fwp_gc_scan+0x77>
    4ad7:	66 0f 1f 84 00 00 00 	nopw   0x0(%rax,%rax,1)
    4ade:	00 00 
    4ae0:	4c 89 e7             	mov    %r12,%rdi
    4ae3:	e8 38 00 00 00       	call   4b20 <fwp_gc_mark>
    4ae8:	85 db                	test   %ebx,%ebx
    4aea:	74 0b                	je     4af7 <fwp_gc_scan+0x67>
    4aec:	49 ff cc             	dec    %r12
    4aef:	4c 89 e7             	mov    %r12,%rdi
    4af2:	e8 29 00 00 00       	call   4b20 <fwp_gc_mark>
    4af7:	49 8d 47 08          	lea    0x8(%r15),%rax
    4afb:	49 83 c7 10          	add    $0x10,%r15
    4aff:	4d 39 f7             	cmp    %r14,%r15
    4b02:	49 89 c7             	mov    %rax,%r15
    4b05:	77 a8                	ja     4aaf <fwp_gc_scan+0x1f>
    4b07:	4d 8b 27             	mov    (%r15),%r12
    4b0a:	4c 89 e0             	mov    %r12,%rax
    4b0d:	4c 29 e8             	sub    %r13,%rax
    4b10:	48 39 e8             	cmp    %rbp,%rax
    4b13:	72 cb                	jb     4ae0 <fwp_gc_scan+0x50>
    4b15:	85 db                	test   %ebx,%ebx
    4b17:	74 de                	je     4af7 <fwp_gc_scan+0x67>
    4b19:	48 39 e8             	cmp    %rbp,%rax
    4b1c:	74 ce                	je     4aec <fwp_gc_scan+0x5c>
    4b1e:	eb d7                	jmp    4af7 <fwp_gc_scan+0x67>

0000000000004b20 <fwp_gc_mark>:
    4b20:	41 56                	push   %r14
    4b22:	53                   	push   %rbx
    4b23:	50                   	push   %rax
    4b24:	49 89 fe             	mov    %rdi,%r14
    4b27:	48 89 e6             	mov    %rsp,%rsi
    4b2a:	e8 d1 00 00 00       	call   4c00 <fwp_gc_chunk_of>
    4b2f:	48 85 c0             	test   %rax,%rax
    4b32:	0f 84 98 00 00 00    	je     4bd0 <fwp_gc_mark+0xb0>
    4b38:	0f b6 08             	movzbl (%rax),%ecx
    4b3b:	83 f9 03             	cmp    $0x3,%ecx
    4b3e:	74 6b                	je     4bab <fwp_gc_mark+0x8b>
    4b40:	83 f9 02             	cmp    $0x2,%ecx
    4b43:	74 7b                	je     4bc0 <fwp_gc_mark+0xa0>
    4b45:	83 f9 01             	cmp    $0x1,%ecx
    4b48:	0f 85 82 00 00 00    	jne    4bd0 <fwp_gc_mark+0xb0>
    4b4e:	8b 58 08             	mov    0x8(%rax),%ebx
    4b51:	41 0f b7 ce          	movzwl %r14w,%ecx
    4b55:	48 89 c6             	mov    %rax,%rsi
    4b58:	89 c8                	mov    %ecx,%eax
    4b5a:	31 d2                	xor    %edx,%edx
    4b5c:	f7 f3                	div    %ebx
    4b5e:	41 89 c6             	mov    %eax,%r14d
    4b61:	3b 46 0c             	cmp    0xc(%rsi),%eax
    4b64:	73 6a                	jae    4bd0 <fwp_gc_mark+0xb0>
    4b66:	48 89 f0             	mov    %rsi,%rax
    4b69:	ba 01 00 00 00       	mov    $0x1,%edx
    4b6e:	44 89 f1             	mov    %r14d,%ecx
    4b71:	48 d3 e2             	shl    %cl,%rdx
    4b74:	44 89 f1             	mov    %r14d,%ecx
    4b77:	c1 e9 06             	shr    $0x6,%ecx
    4b7a:	48 8b 74 ce 28       	mov    0x28(%rsi,%rcx,8),%rsi
    4b7f:	4c 0f a3 f6          	bt     %r14,%rsi
    4b83:	72 4b                	jb     4bd0 <fwp_gc_mark+0xb0>
    4b85:	48 09 d6             	or     %rdx,%rsi
    4b88:	48 89 74 c8 28       	mov    %rsi,0x28(%rax,%rcx,8)
    4b8d:	80 78 01 01          	cmpb   $0x1,0x1(%rax)
    4b91:	74 3d                	je     4bd0 <fwp_gc_mark+0xb0>
    4b93:	48 8b 3c 24          	mov    (%rsp),%rdi
    4b97:	e8 c4 e1 ff ff       	call   2d60 <fwp_gc_chunk_addr>
    4b9c:	4c 0f af f3          	imul   %rbx,%r14
    4ba0:	49 01 c6             	add    %rax,%r14
    4ba3:	4c 89 f7             	mov    %r14,%rdi
    4ba6:	48 89 de             	mov    %rbx,%rsi
    4ba9:	eb 40                	jmp    4beb <fwp_gc_mark+0xcb>
    4bab:	8b 40 10             	mov    0x10(%rax),%eax
    4bae:	48 89 04 24          	mov    %rax,(%rsp)
    4bb2:	48 69 c0 28 12 00 00 	imul   $0x1228,%rax,%rax
    4bb9:	48 03 05 50 f7 00 00 	add    0xf750(%rip),%rax        # 14310 <fwp_gc+0x1078>
    4bc0:	80 78 03 00          	cmpb   $0x0,0x3(%rax)
    4bc4:	75 0a                	jne    4bd0 <fwp_gc_mark+0xb0>
    4bc6:	c6 40 03 01          	movb   $0x1,0x3(%rax)
    4bca:	80 78 01 01          	cmpb   $0x1,0x1(%rax)
    4bce:	75 08                	jne    4bd8 <fwp_gc_mark+0xb8>
    4bd0:	48 83 c4 08          	add    $0x8,%rsp
    4bd4:	5b                   	pop    %rbx
    4bd5:	41 5e                	pop    %r14
    4bd7:	c3                   	ret
    4bd8:	48 8b 3c 24          	mov    (%rsp),%rdi
    4bdc:	48 89 c3             	mov    %rax,%rbx
    4bdf:	e8 7c e1 ff ff       	call   2d60 <fwp_gc_chunk_addr>
    4be4:	48 8b 73 18          	mov    0x18(%rbx),%rsi
    4be8:	48 89 c7             	mov    %rax,%rdi
    4beb:	48 83 c4 08          	add    $0x8,%rsp
    4bef:	5b                   	pop    %rbx
    4bf0:	41 5e                	pop    %r14
    4bf2:	eb 3c                	jmp    4c30 <fwp_gc_push>
    4bf4:	66 66 66 2e 0f 1f 84 	data16 data16 cs nopw 0x0(%rax,%rax,1)
    4bfb:	00 00 00 00 00 

0000000000004c00 <fwp_gc_chunk_of>:
    4c00:	48 2b 3d c1 f6 00 00 	sub    0xf6c1(%rip),%rdi        # 142c8 <fwp_gc+0x1030>
    4c07:	48 8b 05 e2 f6 00 00 	mov    0xf6e2(%rip),%rax        # 142f0 <fwp_gc+0x1058>
    4c0e:	48 c1 e0 10          	shl    $0x10,%rax
    4c12:	48 39 c7             	cmp    %rax,%rdi
    4c15:	73 16                	jae    4c2d <fwp_gc_chunk_of+0x2d>
    4c17:	48 c1 ef 10          	shr    $0x10,%rdi
    4c1b:	48 89 3e             	mov    %rdi,(%rsi)
    4c1e:	48 69 c7 28 12 00 00 	imul   $0x1228,%rdi,%rax
    4c25:	48 03 05 e4 f6 00 00 	add    0xf6e4(%rip),%rax        # 14310 <fwp_gc+0x1078>
    4c2c:	c3                   	ret
    4c2d:	31 c0                	xor    %eax,%eax
    4c2f:	c3                   	ret

0000000000004c30 <fwp_gc_push>:
    4c30:	41 56                	push   %r14
    4c32:	53                   	push   %rbx
    4c33:	50                   	push   %rax
    4c34:	48 89 f3             	mov    %rsi,%rbx
    4c37:	49 89 fe             	mov    %rdi,%r14
    4c3a:	48 8b 0d f7 f7 00 00 	mov    0xf7f7(%rip),%rcx        # 14438 <fwp_gc+0x11a0>
    4c41:	48 8b 05 e8 f7 00 00 	mov    0xf7e8(%rip),%rax        # 14430 <fwp_gc+0x1198>
    4c48:	48 3b 0d f1 f7 00 00 	cmp    0xf7f1(%rip),%rcx        # 14440 <fwp_gc+0x11a8>
    4c4f:	75 36                	jne    4c87 <fwp_gc_push+0x57>
    4c51:	48 8d 14 09          	lea    (%rcx,%rcx,1),%rdx
    4c55:	48 85 c9             	test   %rcx,%rcx
    4c58:	be 00 10 00 00       	mov    $0x1000,%esi
    4c5d:	48 0f 45 f2          	cmovne %rdx,%rsi
    4c61:	48 89 35 d8 f7 00 00 	mov    %rsi,0xf7d8(%rip)        # 14440 <fwp_gc+0x11a8>
    4c68:	48 c1 e6 04          	shl    $0x4,%rsi
    4c6c:	48 89 c7             	mov    %rax,%rdi
    4c6f:	e8 0c d7 ff ff       	call   2380 <realloc@plt>
    4c74:	48 89 05 b5 f7 00 00 	mov    %rax,0xf7b5(%rip)        # 14430 <fwp_gc+0x1198>
    4c7b:	48 85 c0             	test   %rax,%rax
    4c7e:	74 29                	je     4ca9 <fwp_gc_push+0x79>
    4c80:	48 8b 0d b1 f7 00 00 	mov    0xf7b1(%rip),%rcx        # 14438 <fwp_gc+0x11a0>
    4c87:	48 89 ca             	mov    %rcx,%rdx
    4c8a:	48 c1 e2 04          	shl    $0x4,%rdx
    4c8e:	4c 89 34 10          	mov    %r14,(%rax,%rdx,1)
    4c92:	48 89 5c 10 08       	mov    %rbx,0x8(%rax,%rdx,1)
    4c97:	48 ff c1             	inc    %rcx
    4c9a:	48 89 0d 97 f7 00 00 	mov    %rcx,0xf797(%rip)        # 14438 <fwp_gc+0x11a0>
    4ca1:	48 83 c4 08          	add    $0x8,%rsp
    4ca5:	5b                   	pop    %rbx
    4ca6:	41 5e                	pop    %r14
    4ca8:	c3                   	ret
    4ca9:	e8 02 ec ff ff       	call   38b0 <fwp_gc_oom>
    4cae:	66 90                	xchg   %ax,%ax

0000000000004cb0 <fwp_gc_marked>:
    4cb0:	53                   	push   %rbx
    4cb1:	48 83 ec 10          	sub    $0x10,%rsp
    4cb5:	48 89 fb             	mov    %rdi,%rbx
    4cb8:	48 8d 74 24 08       	lea    0x8(%rsp),%rsi
    4cbd:	e8 3e ff ff ff       	call   4c00 <fwp_gc_chunk_of>
    4cc2:	48 85 c0             	test   %rax,%rax
    4cc5:	74 36                	je     4cfd <fwp_gc_marked+0x4d>
    4cc7:	0f b6 08             	movzbl (%rax),%ecx
    4cca:	80 f9 03             	cmp    $0x3,%cl
    4ccd:	75 19                	jne    4ce8 <fwp_gc_marked+0x38>
    4ccf:	48 8b 0d 3a f6 00 00 	mov    0xf63a(%rip),%rcx        # 14310 <fwp_gc+0x1078>
    4cd6:	8b 40 10             	mov    0x10(%rax),%eax
    4cd9:	48 69 d0 28 12 00 00 	imul   $0x1228,%rax,%rdx
    4ce0:	48 8d 04 11          	lea    (%rcx,%rdx,1),%rax
    4ce4:	0f b6 0c 11          	movzbl (%rcx,%rdx,1),%ecx
    4ce8:	80 f9 01             	cmp    $0x1,%cl
    4ceb:	74 17                	je     4d04 <fwp_gc_marked+0x54>
    4ced:	0f b6 d1             	movzbl %cl,%edx
    4cf0:	31 c9                	xor    %ecx,%ecx
    4cf2:	83 fa 02             	cmp    $0x2,%edx
    4cf5:	75 33                	jne    4d2a <fwp_gc_marked+0x7a>
    4cf7:	0f b6 48 03          	movzbl 0x3(%rax),%ecx
    4cfb:	eb 2d                	jmp    4d2a <fwp_gc_marked+0x7a>
    4cfd:	b9 01 00 00 00       	mov    $0x1,%ecx
    4d02:	eb 26                	jmp    4d2a <fwp_gc_marked+0x7a>
    4d04:	0f b7 cb             	movzwl %bx,%ecx
    4d07:	48 89 c6             	mov    %rax,%rsi
    4d0a:	89 c8                	mov    %ecx,%eax
    4d0c:	31 d2                	xor    %edx,%edx
    4d0e:	f7 76 08             	divl   0x8(%rsi)
    4d11:	89 c1                	mov    %eax,%ecx
    4d13:	c1 e9 03             	shr    $0x3,%ecx
    4d16:	81 e1 f8 1f 00 00    	and    $0x1ff8,%ecx
    4d1c:	48 8b 54 0e 28       	mov    0x28(%rsi,%rcx,1),%rdx
    4d21:	31 c9                	xor    %ecx,%ecx
    4d23:	48 0f a3 c2          	bt     %rax,%rdx
    4d27:	0f 92 c1             	setb   %cl
    4d2a:	89 c8                	mov    %ecx,%eax
    4d2c:	48 83 c4 10          	add    $0x10,%rsp
    4d30:	5b                   	pop    %rbx
    4d31:	c3                   	ret
    4d32:	66 66 66 66 66 2e 0f 	data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    4d39:	1f 84 00 00 00 00 00 

0000000000004d40 <fwp_rc_clear_chunk>:
    4d40:	41 57                	push   %r15
    4d42:	41 56                	push   %r14
    4d44:	53                   	push   %rbx
    4d45:	48 89 fb             	mov    %rdi,%rbx
    4d48:	48 83 3d 60 ff 00 00 	cmpq   $0x0,0xff60(%rip)        # 14cb0 <fwp_gc+0x1a18>
    4d4f:	00 
    4d50:	74 2c                	je     4d7e <fwp_rc_clear_chunk+0x3e>
    4d52:	4c 8d b3 28 02 00 00 	lea    0x228(%rbx),%r14
    4d59:	45 31 ff             	xor    %r15d,%r15d
    4d5c:	eb 0e                	jmp    4d6c <fwp_rc_clear_chunk+0x2c>
    4d5e:	66 90                	xchg   %ax,%ax
    4d60:	49 ff c7             	inc    %r15
    4d63:	49 81 ff 00 10 00 00 	cmp    $0x1000,%r15
    4d6a:	74 12                	je     4d7e <fwp_rc_clear_chunk+0x3e>
    4d6c:	43 80 3c 3e ff       	cmpb   $0xff,(%r14,%r15,1)
    4d71:	75 ed                	jne    4d60 <fwp_rc_clear_chunk+0x20>
    4d73:	4b 8d 3c 3e          	lea    (%r14,%r15,1),%rdi
    4d77:	e8 f4 df ff ff       	call   2d70 <fwp_rc_forget_slot>
    4d7c:	eb e2                	jmp    4d60 <fwp_rc_clear_chunk+0x20>
    4d7e:	48 81 c3 28 02 00 00 	add    $0x228,%rbx
    4d85:	ba 00 10 00 00       	mov    $0x1000,%edx
    4d8a:	48 89 df             	mov    %rbx,%rdi
    4d8d:	31 f6                	xor    %esi,%esi
    4d8f:	5b                   	pop    %rbx
    4d90:	41 5e                	pop    %r14
    4d92:	41 5f                	pop    %r15
    4d94:	e9 77 d4 ff ff       	jmp    2210 <memset@plt>
    4d99:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)

0000000000004da0 <f1>:
    4da0:	53                   	push   %rbx
    4da1:	48 83 ec 30          	sub    $0x30,%rsp
    4da5:	e8 86 00 00 00       	call   4e30 <fwp_f32>
    4daa:	e8 61 00 00 00       	call   4e10 <w1>
    4daf:	0f 29 44 24 20       	movaps %xmm0,0x20(%rsp)
    4db4:	f3 0f 11 4c 24 04    	movss  %xmm1,0x4(%rsp)
    4dba:	e8 81 00 00 00       	call   4e40 <fwp_from_f32>
    4dbf:	48 89 44 24 08       	mov    %rax,0x8(%rsp)
    4dc4:	0f 28 44 24 20       	movaps 0x20(%rsp),%xmm0
    4dc9:	0f c6 c0 55          	shufps $0x55,%xmm0,%xmm0
    4dcd:	e8 6e 00 00 00       	call   4e40 <fwp_from_f32>
    4dd2:	48 89 44 24 10       	mov    %rax,0x10(%rsp)
    4dd7:	f3 0f 10 44 24 04    	movss  0x4(%rsp),%xmm0
    4ddd:	e8 5e 00 00 00       	call   4e40 <fwp_from_f32>
    4de2:	48 89 44 24 18       	mov    %rax,0x18(%rsp)
    4de7:	48 8d 74 24 08       	lea    0x8(%rsp),%rsi
    4dec:	bf 03 00 00 00       	mov    $0x3,%edi
    4df1:	e8 fa e0 ff ff       	call   2ef0 <fwp_record>
    4df6:	48 89 c3             	mov    %rax,%rbx
    4df9:	48 89 c7             	mov    %rax,%rdi
    4dfc:	e8 af e0 ff ff       	call   2eb0 <fwp_rc_fresh>
    4e01:	48 89 d8             	mov    %rbx,%rax
    4e04:	48 83 c4 30          	add    $0x30,%rsp
    4e08:	5b                   	pop    %rbx
    4e09:	c3                   	ret
    4e0a:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)

0000000000004e10 <w1>:
    4e10:	50                   	push   %rax
    4e11:	e8 2a 00 00 00       	call   4e40 <fwp_from_f32>
    4e16:	48 89 c7             	mov    %rax,%rdi
    4e19:	e8 12 00 00 00       	call   4e30 <fwp_f32>
    4e1e:	0f 28 d0             	movaps %xmm0,%xmm2
    4e21:	0f c6 d0 00          	shufps $0x0,%xmm0,%xmm2
    4e25:	0f 28 c8             	movaps %xmm0,%xmm1
    4e28:	0f 28 c2             	movaps %xmm2,%xmm0
    4e2b:	58                   	pop    %rax
    4e2c:	c3                   	ret
    4e2d:	0f 1f 00             	nopl   (%rax)

0000000000004e30 <fwp_f32>:
    4e30:	66 0f 6e c7          	movd   %edi,%xmm0
    4e34:	c3                   	ret
    4e35:	66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
    4e3c:	00 00 00 00 

0000000000004e40 <fwp_from_f32>:
    4e40:	66 0f 7e c0          	movd   %xmm0,%eax
    4e44:	c3                   	ret
    4e45:	66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
    4e4c:	00 00 00 00 

0000000000004e50 <f2>:
    4e50:	55                   	push   %rbp
    4e51:	41 57                	push   %r15
    4e53:	41 56                	push   %r14
    4e55:	41 55                	push   %r13
    4e57:	41 54                	push   %r12
    4e59:	53                   	push   %rbx
    4e5a:	48 81 ec e8 00 00 00 	sub    $0xe8,%rsp
    4e61:	48 89 fe             	mov    %rdi,%rsi
    4e64:	48 8d bc 24 90 00 00 	lea    0x90(%rsp),%rdi
    4e6b:	00 
    4e6c:	e8 ff 00 00 00       	call   4f70 <w2>
    4e71:	48 8b 84 24 90 00 00 	mov    0x90(%rsp),%rax
    4e78:	00 
    4e79:	48 89 44 24 08       	mov    %rax,0x8(%rsp)
    4e7e:	48 8b 8c 24 98 00 00 	mov    0x98(%rsp),%rcx
    4e85:	00 
    4e86:	48 89 0c 24          	mov    %rcx,(%rsp)
    4e8a:	48 89 44 24 50       	mov    %rax,0x50(%rsp)
    4e8f:	48 89 4c 24 58       	mov    %rcx,0x58(%rsp)
    4e94:	4c 8b a4 24 a0 00 00 	mov    0xa0(%rsp),%r12
    4e9b:	00 
    4e9c:	4c 89 64 24 60       	mov    %r12,0x60(%rsp)
    4ea1:	4c 8b ac 24 a8 00 00 	mov    0xa8(%rsp),%r13
    4ea8:	00 
    4ea9:	4c 89 6c 24 68       	mov    %r13,0x68(%rsp)
    4eae:	48 8b ac 24 b0 00 00 	mov    0xb0(%rsp),%rbp
    4eb5:	00 
    4eb6:	48 89 6c 24 70       	mov    %rbp,0x70(%rsp)
    4ebb:	48 8b 9c 24 b8 00 00 	mov    0xb8(%rsp),%rbx
    4ec2:	00 
    4ec3:	48 89 5c 24 78       	mov    %rbx,0x78(%rsp)
    4ec8:	4c 8b b4 24 c0 00 00 	mov    0xc0(%rsp),%r14
    4ecf:	00 
    4ed0:	4c 89 b4 24 80 00 00 	mov    %r14,0x80(%rsp)
    4ed7:	00 
    4ed8:	4c 8b bc 24 c8 00 00 	mov    0xc8(%rsp),%r15
    4edf:	00 
    4ee0:	4c 89 bc 24 88 00 00 	mov    %r15,0x88(%rsp)
    4ee7:	00 
    4ee8:	48 8d 35 91 03 00 00 	lea    0x391(%rip),%rsi        # 5280 <fwp_owner_release7>
    4eef:	48 8d bc 24 d0 00 00 	lea    0xd0(%rsp),%rdi
    4ef6:	00 
    4ef7:	48 8d 54 24 50       	lea    0x50(%rsp),%rdx
    4efc:	e8 5f 03 00 00       	call   5260 <fwp_cleanup_push>
    4f01:	48 8b 44 24 08       	mov    0x8(%rsp),%rax
    4f06:	48 89 44 24 10       	mov    %rax,0x10(%rsp)
    4f0b:	48 8b 04 24          	mov    (%rsp),%rax
    4f0f:	48 89 44 24 18       	mov    %rax,0x18(%rsp)
    4f14:	4c 89 64 24 20       	mov    %r12,0x20(%rsp)
    4f19:	4c 89 6c 24 28       	mov    %r13,0x28(%rsp)
    4f1e:	48 89 6c 24 30       	mov    %rbp,0x30(%rsp)
    4f23:	48 89 5c 24 38       	mov    %rbx,0x38(%rsp)
    4f28:	4c 89 74 24 40       	mov    %r14,0x40(%rsp)
    4f2d:	4c 89 7c 24 48       	mov    %r15,0x48(%rsp)
    4f32:	48 8d 74 24 10       	lea    0x10(%rsp),%rsi
    4f37:	bf 08 00 00 00       	mov    $0x8,%edi
    4f3c:	e8 af df ff ff       	call   2ef0 <fwp_record>
    4f41:	49 89 c6             	mov    %rax,%r14
    4f44:	48 89 c7             	mov    %rax,%rdi
    4f47:	e8 64 df ff ff       	call   2eb0 <fwp_rc_fresh>
    4f4c:	48 8d bc 24 d0 00 00 	lea    0xd0(%rsp),%rdi
    4f53:	00 
    4f54:	e8 77 03 00 00       	call   52d0 <fwp_cleanup_pop>
    4f59:	4c 89 f0             	mov    %r14,%rax
    4f5c:	48 81 c4 e8 00 00 00 	add    $0xe8,%rsp
    4f63:	5b                   	pop    %rbx
    4f64:	41 5c                	pop    %r12
    4f66:	41 5d                	pop    %r13
    4f68:	41 5e                	pop    %r14
    4f6a:	41 5f                	pop    %r15
    4f6c:	5d                   	pop    %rbp
    4f6d:	c3                   	ret
    4f6e:	66 90                	xchg   %ax,%ax

0000000000004f70 <w2>:
    4f70:	55                   	push   %rbp
    4f71:	41 57                	push   %r15
    4f73:	41 56                	push   %r14
    4f75:	41 55                	push   %r13
    4f77:	41 54                	push   %r12
    4f79:	53                   	push   %rbx
    4f7a:	48 81 ec b8 01 00 00 	sub    $0x1b8,%rsp
    4f81:	49 89 f6             	mov    %rsi,%r14
    4f84:	48 89 7c 24 28       	mov    %rdi,0x28(%rsp)
    4f89:	48 89 f7             	mov    %rsi,%rdi
    4f8c:	48 c7 c6 80 ff ff ff 	mov    $0xffffffffffffff80,%rsi
    4f93:	e8 58 03 00 00       	call   52f0 <f12>
    4f98:	48 89 44 24 30       	mov    %rax,0x30(%rsp)
    4f9d:	49 89 c7             	mov    %rax,%r15
    4fa0:	48 8d 35 59 03 00 00 	lea    0x359(%rip),%rsi        # 5300 <fwp_owner_release0>
    4fa7:	4c 8d ac 24 a0 01 00 	lea    0x1a0(%rsp),%r13
    4fae:	00 
    4faf:	48 8d 54 24 30       	lea    0x30(%rsp),%rdx
    4fb4:	4c 89 ef             	mov    %r13,%rdi
    4fb7:	e8 a4 02 00 00       	call   5260 <fwp_cleanup_push>
    4fbc:	be ff 00 00 00       	mov    $0xff,%esi
    4fc1:	4c 89 f7             	mov    %r14,%rdi
    4fc4:	e8 47 03 00 00       	call   5310 <f14>
    4fc9:	49 89 c4             	mov    %rax,%r12
    4fcc:	4c 89 ef             	mov    %r13,%rdi
    4fcf:	e8 fc 02 00 00       	call   52d0 <fwp_cleanup_pop>
    4fd4:	4c 89 7c 24 38       	mov    %r15,0x38(%rsp)
    4fd9:	4c 89 64 24 40       	mov    %r12,0x40(%rsp)
    4fde:	48 8d 35 3b 03 00 00 	lea    0x33b(%rip),%rsi        # 5320 <fwp_owner_release1>
    4fe5:	4c 8d ac 24 88 01 00 	lea    0x188(%rsp),%r13
    4fec:	00 
    4fed:	48 8d 54 24 38       	lea    0x38(%rsp),%rdx
    4ff2:	4c 89 ef             	mov    %r13,%rdi
    4ff5:	e8 66 02 00 00       	call   5260 <fwp_cleanup_push>
    4ffa:	4c 89 f7             	mov    %r14,%rdi
    4ffd:	48 c7 c6 00 80 ff ff 	mov    $0xffffffffffff8000,%rsi
    5004:	e8 37 03 00 00       	call   5340 <f16>
    5009:	48 89 c5             	mov    %rax,%rbp
    500c:	4c 89 ef             	mov    %r13,%rdi
    500f:	e8 bc 02 00 00       	call   52d0 <fwp_cleanup_pop>
    5014:	4c 89 7c 24 48       	mov    %r15,0x48(%rsp)
    5019:	4c 89 64 24 50       	mov    %r12,0x50(%rsp)
    501e:	48 89 6c 24 58       	mov    %rbp,0x58(%rsp)
    5023:	48 8d 35 26 03 00 00 	lea    0x326(%rip),%rsi        # 5350 <fwp_owner_release2>
    502a:	48 8d 9c 24 70 01 00 	lea    0x170(%rsp),%rbx
    5031:	00 
    5032:	48 8d 54 24 48       	lea    0x48(%rsp),%rdx
    5037:	48 89 df             	mov    %rbx,%rdi
    503a:	e8 21 02 00 00       	call   5260 <fwp_cleanup_push>
    503f:	be ff ff 00 00       	mov    $0xffff,%esi
    5044:	4c 89 f7             	mov    %r14,%rdi
    5047:	e8 24 03 00 00       	call   5370 <f18>
    504c:	49 89 c5             	mov    %rax,%r13
    504f:	48 89 df             	mov    %rbx,%rdi
    5052:	e8 79 02 00 00       	call   52d0 <fwp_cleanup_pop>
    5057:	4c 89 7c 24 60       	mov    %r15,0x60(%rsp)
    505c:	4c 89 3c 24          	mov    %r15,(%rsp)
    5060:	4c 89 64 24 68       	mov    %r12,0x68(%rsp)
    5065:	4c 89 e3             	mov    %r12,%rbx
    5068:	4c 89 64 24 10       	mov    %r12,0x10(%rsp)
    506d:	48 89 6c 24 70       	mov    %rbp,0x70(%rsp)
    5072:	48 89 6c 24 18       	mov    %rbp,0x18(%rsp)
    5077:	4c 89 6c 24 78       	mov    %r13,0x78(%rsp)
    507c:	48 8d 35 fd 02 00 00 	lea    0x2fd(%rip),%rsi        # 5380 <fwp_owner_release3>
    5083:	48 8d bc 24 40 01 00 	lea    0x140(%rsp),%rdi
    508a:	00 
    508b:	48 8d 54 24 60       	lea    0x60(%rsp),%rdx
    5090:	e8 cb 01 00 00       	call   5260 <fwp_cleanup_push>
    5095:	4c 89 f7             	mov    %r14,%rdi
    5098:	48 c7 c6 00 00 00 80 	mov    $0xffffffff80000000,%rsi
    509f:	e8 0c 03 00 00       	call   53b0 <f20>
    50a4:	49 89 c4             	mov    %rax,%r12
    50a7:	48 89 44 24 08       	mov    %rax,0x8(%rsp)
    50ac:	48 8d bc 24 40 01 00 	lea    0x140(%rsp),%rdi
    50b3:	00 
    50b4:	e8 17 02 00 00       	call   52d0 <fwp_cleanup_pop>
    50b9:	4c 89 bc 24 80 00 00 	mov    %r15,0x80(%rsp)
    50c0:	00 
    50c1:	48 89 9c 24 88 00 00 	mov    %rbx,0x88(%rsp)
    50c8:	00 
    50c9:	48 89 ac 24 90 00 00 	mov    %rbp,0x90(%rsp)
    50d0:	00 
    50d1:	4c 89 ac 24 98 00 00 	mov    %r13,0x98(%rsp)
    50d8:	00 
    50d9:	4c 89 a4 24 a0 00 00 	mov    %r12,0xa0(%rsp)
    50e0:	00 
    50e1:	48 8d 35 d8 02 00 00 	lea    0x2d8(%rip),%rsi        # 53c0 <fwp_owner_release4>
    50e8:	4c 8d a4 24 58 01 00 	lea    0x158(%rsp),%r12
    50ef:	00 
    50f0:	48 8d 94 24 80 00 00 	lea    0x80(%rsp),%rdx
    50f7:	00 
    50f8:	4c 89 e7             	mov    %r12,%rdi
    50fb:	e8 60 01 00 00       	call   5260 <fwp_cleanup_push>
    5100:	b8 00 00 00 80       	mov    $0x80000000,%eax
    5105:	48 8d b0 ff ff ff 7f 	lea    0x7fffffff(%rax),%rsi
    510c:	4c 89 f7             	mov    %r14,%rdi
    510f:	4c 89 f3             	mov    %r14,%rbx
    5112:	4c 89 74 24 20       	mov    %r14,0x20(%rsp)
    5117:	e8 e4 02 00 00       	call   5400 <f22>
    511c:	49 89 c7             	mov    %rax,%r15
    511f:	4c 89 e7             	mov    %r12,%rdi
    5122:	e8 a9 01 00 00       	call   52d0 <fwp_cleanup_pop>
    5127:	48 8b 04 24          	mov    (%rsp),%rax
    512b:	48 89 84 24 a8 00 00 	mov    %rax,0xa8(%rsp)
    5132:	00 
    5133:	48 8b 6c 24 10       	mov    0x10(%rsp),%rbp
    5138:	48 89 ac 24 b0 00 00 	mov    %rbp,0xb0(%rsp)
    513f:	00 
    5140:	4c 8b 64 24 18       	mov    0x18(%rsp),%r12
    5145:	4c 89 a4 24 b8 00 00 	mov    %r12,0xb8(%rsp)
    514c:	00 
    514d:	4c 89 ac 24 c0 00 00 	mov    %r13,0xc0(%rsp)
    5154:	00 
    5155:	4c 8b 74 24 08       	mov    0x8(%rsp),%r14
    515a:	4c 89 b4 24 c8 00 00 	mov    %r14,0xc8(%rsp)
    5161:	00 
    5162:	4c 89 bc 24 d0 00 00 	mov    %r15,0xd0(%rsp)
    5169:	00 
    516a:	48 8d 35 9f 02 00 00 	lea    0x29f(%rip),%rsi        # 5410 <fwp_owner_release5>
    5171:	48 8d bc 24 28 01 00 	lea    0x128(%rsp),%rdi
    5178:	00 
    5179:	48 8d 94 24 a8 00 00 	lea    0xa8(%rsp),%rdx
    5180:	00 
    5181:	e8 da 00 00 00       	call   5260 <fwp_cleanup_push>
    5186:	be 00 00 00 80       	mov    $0x80000000,%esi
    518b:	48 89 df             	mov    %rbx,%rdi
    518e:	e8 bd 02 00 00       	call   5450 <f24>
    5193:	48 89 c3             	mov    %rax,%rbx
    5196:	48 8d bc 24 28 01 00 	lea    0x128(%rsp),%rdi
    519d:	00 
    519e:	e8 2d 01 00 00       	call   52d0 <fwp_cleanup_pop>
    51a3:	48 8b 04 24          	mov    (%rsp),%rax
    51a7:	48 89 84 24 d8 00 00 	mov    %rax,0xd8(%rsp)
    51ae:	00 
    51af:	48 89 ac 24 e0 00 00 	mov    %rbp,0xe0(%rsp)
    51b6:	00 
    51b7:	4c 89 a4 24 e8 00 00 	mov    %r12,0xe8(%rsp)
    51be:	00 
    51bf:	4c 89 ac 24 f0 00 00 	mov    %r13,0xf0(%rsp)
    51c6:	00 
    51c7:	4c 89 b4 24 f8 00 00 	mov    %r14,0xf8(%rsp)
    51ce:	00 
    51cf:	4c 89 bc 24 00 01 00 	mov    %r15,0x100(%rsp)
    51d6:	00 
    51d7:	48 89 9c 24 08 01 00 	mov    %rbx,0x108(%rsp)
    51de:	00 
    51df:	48 8d 35 7a 02 00 00 	lea    0x27a(%rip),%rsi        # 5460 <fwp_owner_release6>
    51e6:	48 8d bc 24 10 01 00 	lea    0x110(%rsp),%rdi
    51ed:	00 
    51ee:	48 8d 94 24 d8 00 00 	lea    0xd8(%rsp),%rdx
    51f5:	00 
    51f6:	e8 65 00 00 00       	call   5260 <fwp_cleanup_push>
    51fb:	48 be 00 00 00 00 00 	movabs $0x8000000000000000,%rsi
    5202:	00 00 80 
    5205:	48 8b 7c 24 20       	mov    0x20(%rsp),%rdi
    520a:	e8 a1 02 00 00       	call   54b0 <f26>
    520f:	49 89 c6             	mov    %rax,%r14
    5212:	48 8d bc 24 10 01 00 	lea    0x110(%rsp),%rdi
    5219:	00 
    521a:	e8 b1 00 00 00       	call   52d0 <fwp_cleanup_pop>
    521f:	48 8b 44 24 28       	mov    0x28(%rsp),%rax
    5224:	48 8b 0c 24          	mov    (%rsp),%rcx
    5228:	48 89 08             	mov    %rcx,(%rax)
    522b:	48 89 68 08          	mov    %rbp,0x8(%rax)
    522f:	4c 89 60 10          	mov    %r12,0x10(%rax)
    5233:	4c 89 68 18          	mov    %r13,0x18(%rax)
    5237:	48 8b 4c 24 08       	mov    0x8(%rsp),%rcx
    523c:	48 89 48 20          	mov    %rcx,0x20(%rax)
    5240:	4c 89 78 28          	mov    %r15,0x28(%rax)
    5244:	48 89 58 30          	mov    %rbx,0x30(%rax)
    5248:	4c 89 70 38          	mov    %r14,0x38(%rax)
    524c:	48 81 c4 b8 01 00 00 	add    $0x1b8,%rsp
    5253:	5b                   	pop    %rbx
    5254:	41 5c                	pop    %r12
    5256:	41 5d                	pop    %r13
    5258:	41 5e                	pop    %r14
    525a:	41 5f                	pop    %r15
    525c:	5d                   	pop    %rbp
    525d:	c3                   	ret
    525e:	66 90                	xchg   %ax,%ax

0000000000005260 <fwp_cleanup_push>:
    5260:	48 8b 05 11 fb 00 00 	mov    0xfb11(%rip),%rax        # 14d78 <fwp_cleanups>
    5267:	48 89 07             	mov    %rax,(%rdi)
    526a:	48 89 77 08          	mov    %rsi,0x8(%rdi)
    526e:	48 89 57 10          	mov    %rdx,0x10(%rdi)
    5272:	48 89 3d ff fa 00 00 	mov    %rdi,0xfaff(%rip)        # 14d78 <fwp_cleanups>
    5279:	c3                   	ret
    527a:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)

0000000000005280 <fwp_owner_release7>:
    5280:	53                   	push   %rbx
    5281:	48 89 fb             	mov    %rdi,%rbx
    5284:	48 8b 3f             	mov    (%rdi),%rdi
    5287:	e8 34 03 00 00       	call   55c0 <fwp_drop0>
    528c:	48 8b 7b 08          	mov    0x8(%rbx),%rdi
    5290:	e8 6b 06 00 00       	call   5900 <fwp_drop1>
    5295:	48 8b 7b 10          	mov    0x10(%rbx),%rdi
    5299:	e8 82 06 00 00       	call   5920 <fwp_drop2>
    529e:	48 8b 7b 18          	mov    0x18(%rbx),%rdi
    52a2:	e8 99 06 00 00       	call   5940 <fwp_drop3>
    52a7:	48 8b 7b 20          	mov    0x20(%rbx),%rdi
    52ab:	e8 b0 06 00 00       	call   5960 <fwp_drop4>
    52b0:	48 8b 7b 28          	mov    0x28(%rbx),%rdi
    52b4:	e8 c7 06 00 00       	call   5980 <fwp_drop5>
    52b9:	48 8b 7b 30          	mov    0x30(%rbx),%rdi
    52bd:	e8 de 06 00 00       	call   59a0 <fwp_drop6>
    52c2:	48 8b 7b 38          	mov    0x38(%rbx),%rdi
    52c6:	5b                   	pop    %rbx
    52c7:	e9 f4 06 00 00       	jmp    59c0 <fwp_drop7>
    52cc:	0f 1f 40 00          	nopl   0x0(%rax)

00000000000052d0 <fwp_cleanup_pop>:
    52d0:	48 39 3d a1 fa 00 00 	cmp    %rdi,0xfaa1(%rip)        # 14d78 <fwp_cleanups>
    52d7:	75 0b                	jne    52e4 <fwp_cleanup_pop+0x14>
    52d9:	48 8b 07             	mov    (%rdi),%rax
    52dc:	48 89 05 95 fa 00 00 	mov    %rax,0xfa95(%rip)        # 14d78 <fwp_cleanups>
    52e3:	c3                   	ret
    52e4:	50                   	push   %rax
    52e5:	e8 86 cd ff ff       	call   2070 <abort@plt>
    52ea:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)

00000000000052f0 <f12>:
    52f0:	e9 cb 01 00 00       	jmp    54c0 <fwp_p_array_make_typed>
    52f5:	66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
    52fc:	00 00 00 00 

0000000000005300 <fwp_owner_release0>:
    5300:	48 8b 3f             	mov    (%rdi),%rdi
    5303:	e9 b8 02 00 00       	jmp    55c0 <fwp_drop0>
    5308:	0f 1f 84 00 00 00 00 	nopl   0x0(%rax,%rax,1)
    530f:	00 

0000000000005310 <f14>:
    5310:	e9 ab 01 00 00       	jmp    54c0 <fwp_p_array_make_typed>
    5315:	66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
    531c:	00 00 00 00 

0000000000005320 <fwp_owner_release1>:
    5320:	53                   	push   %rbx
    5321:	48 89 fb             	mov    %rdi,%rbx
    5324:	48 8b 3f             	mov    (%rdi),%rdi
    5327:	e8 94 02 00 00       	call   55c0 <fwp_drop0>
    532c:	48 8b 7b 08          	mov    0x8(%rbx),%rdi
    5330:	5b                   	pop    %rbx
    5331:	e9 ca 05 00 00       	jmp    5900 <fwp_drop1>
    5336:	66 2e 0f 1f 84 00 00 	cs nopw 0x0(%rax,%rax,1)
    533d:	00 00 00 

0000000000005340 <f16>:
    5340:	e9 7b 01 00 00       	jmp    54c0 <fwp_p_array_make_typed>
    5345:	66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
    534c:	00 00 00 00 

0000000000005350 <fwp_owner_release2>:
    5350:	53                   	push   %rbx
    5351:	48 89 fb             	mov    %rdi,%rbx
    5354:	48 8b 3f             	mov    (%rdi),%rdi
    5357:	e8 64 02 00 00       	call   55c0 <fwp_drop0>
    535c:	48 8b 7b 08          	mov    0x8(%rbx),%rdi
    5360:	e8 9b 05 00 00       	call   5900 <fwp_drop1>
    5365:	48 8b 7b 10          	mov    0x10(%rbx),%rdi
    5369:	5b                   	pop    %rbx
    536a:	e9 b1 05 00 00       	jmp    5920 <fwp_drop2>
    536f:	90                   	nop

0000000000005370 <f18>:
    5370:	e9 4b 01 00 00       	jmp    54c0 <fwp_p_array_make_typed>
    5375:	66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
    537c:	00 00 00 00 

0000000000005380 <fwp_owner_release3>:
    5380:	53                   	push   %rbx
    5381:	48 89 fb             	mov    %rdi,%rbx
    5384:	48 8b 3f             	mov    (%rdi),%rdi
    5387:	e8 34 02 00 00       	call   55c0 <fwp_drop0>
    538c:	48 8b 7b 08          	mov    0x8(%rbx),%rdi
    5390:	e8 6b 05 00 00       	call   5900 <fwp_drop1>
    5395:	48 8b 7b 10          	mov    0x10(%rbx),%rdi
    5399:	e8 82 05 00 00       	call   5920 <fwp_drop2>
    539e:	48 8b 7b 18          	mov    0x18(%rbx),%rdi
    53a2:	5b                   	pop    %rbx
    53a3:	e9 98 05 00 00       	jmp    5940 <fwp_drop3>
    53a8:	0f 1f 84 00 00 00 00 	nopl   0x0(%rax,%rax,1)
    53af:	00 

00000000000053b0 <f20>:
    53b0:	e9 0b 01 00 00       	jmp    54c0 <fwp_p_array_make_typed>
    53b5:	66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
    53bc:	00 00 00 00 

00000000000053c0 <fwp_owner_release4>:
    53c0:	53                   	push   %rbx
    53c1:	48 89 fb             	mov    %rdi,%rbx
    53c4:	48 8b 3f             	mov    (%rdi),%rdi
    53c7:	e8 f4 01 00 00       	call   55c0 <fwp_drop0>
    53cc:	48 8b 7b 08          	mov    0x8(%rbx),%rdi
    53d0:	e8 2b 05 00 00       	call   5900 <fwp_drop1>
    53d5:	48 8b 7b 10          	mov    0x10(%rbx),%rdi
    53d9:	e8 42 05 00 00       	call   5920 <fwp_drop2>
    53de:	48 8b 7b 18          	mov    0x18(%rbx),%rdi
    53e2:	e8 59 05 00 00       	call   5940 <fwp_drop3>
    53e7:	48 8b 7b 20          	mov    0x20(%rbx),%rdi
    53eb:	5b                   	pop    %rbx
    53ec:	e9 6f 05 00 00       	jmp    5960 <fwp_drop4>
    53f1:	66 66 66 66 66 66 2e 	data16 data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    53f8:	0f 1f 84 00 00 00 00 
    53ff:	00 

0000000000005400 <f22>:
    5400:	e9 bb 00 00 00       	jmp    54c0 <fwp_p_array_make_typed>
    5405:	66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
    540c:	00 00 00 00 

0000000000005410 <fwp_owner_release5>:
    5410:	53                   	push   %rbx
    5411:	48 89 fb             	mov    %rdi,%rbx
    5414:	48 8b 3f             	mov    (%rdi),%rdi
    5417:	e8 a4 01 00 00       	call   55c0 <fwp_drop0>
    541c:	48 8b 7b 08          	mov    0x8(%rbx),%rdi
    5420:	e8 db 04 00 00       	call   5900 <fwp_drop1>
    5425:	48 8b 7b 10          	mov    0x10(%rbx),%rdi
    5429:	e8 f2 04 00 00       	call   5920 <fwp_drop2>
    542e:	48 8b 7b 18          	mov    0x18(%rbx),%rdi
    5432:	e8 09 05 00 00       	call   5940 <fwp_drop3>
    5437:	48 8b 7b 20          	mov    0x20(%rbx),%rdi
    543b:	e8 20 05 00 00       	call   5960 <fwp_drop4>
    5440:	48 8b 7b 28          	mov    0x28(%rbx),%rdi
    5444:	5b                   	pop    %rbx
    5445:	e9 36 05 00 00       	jmp    5980 <fwp_drop5>
    544a:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)

0000000000005450 <f24>:
    5450:	eb 6e                	jmp    54c0 <fwp_p_array_make_typed>
    5452:	66 66 66 66 66 2e 0f 	data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    5459:	1f 84 00 00 00 00 00 

0000000000005460 <fwp_owner_release6>:
    5460:	53                   	push   %rbx
    5461:	48 89 fb             	mov    %rdi,%rbx
    5464:	48 8b 3f             	mov    (%rdi),%rdi
    5467:	e8 54 01 00 00       	call   55c0 <fwp_drop0>
    546c:	48 8b 7b 08          	mov    0x8(%rbx),%rdi
    5470:	e8 8b 04 00 00       	call   5900 <fwp_drop1>
    5475:	48 8b 7b 10          	mov    0x10(%rbx),%rdi
    5479:	e8 a2 04 00 00       	call   5920 <fwp_drop2>
    547e:	48 8b 7b 18          	mov    0x18(%rbx),%rdi
    5482:	e8 b9 04 00 00       	call   5940 <fwp_drop3>
    5487:	48 8b 7b 20          	mov    0x20(%rbx),%rdi
    548b:	e8 d0 04 00 00       	call   5960 <fwp_drop4>
    5490:	48 8b 7b 28          	mov    0x28(%rbx),%rdi
    5494:	e8 e7 04 00 00       	call   5980 <fwp_drop5>
    5499:	48 8b 7b 30          	mov    0x30(%rbx),%rdi
    549d:	5b                   	pop    %rbx
    549e:	e9 fd 04 00 00       	jmp    59a0 <fwp_drop6>
    54a3:	66 66 66 66 2e 0f 1f 	data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    54aa:	84 00 00 00 00 00 

00000000000054b0 <f26>:
    54b0:	eb 0e                	jmp    54c0 <fwp_p_array_make_typed>
    54b2:	66 66 66 66 66 2e 0f 	data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    54b9:	1f 84 00 00 00 00 00 

00000000000054c0 <fwp_p_array_make_typed>:
    54c0:	41 56                	push   %r14
    54c2:	53                   	push   %rbx
    54c3:	50                   	push   %rax
    54c4:	48 89 f3             	mov    %rsi,%rbx
    54c7:	e8 64 00 00 00       	call   5530 <fwp_count_arg>
    54cc:	49 89 c6             	mov    %rax,%r14
    54cf:	48 89 c7             	mov    %rax,%rdi
    54d2:	e8 69 00 00 00       	call   5540 <fwp_array_typed_new>
    54d7:	4d 85 f6             	test   %r14,%r14
    54da:	74 48                	je     5524 <fwp_p_array_make_typed+0x64>
    54dc:	49 83 fe 04          	cmp    $0x4,%r14
    54e0:	73 04                	jae    54e6 <fwp_p_array_make_typed+0x26>
    54e2:	31 c9                	xor    %ecx,%ecx
    54e4:	eb 31                	jmp    5517 <fwp_p_array_make_typed+0x57>
    54e6:	4c 89 f1             	mov    %r14,%rcx
    54e9:	48 83 e1 fc          	and    $0xfffffffffffffffc,%rcx
    54ed:	66 48 0f 6e c3       	movq   %rbx,%xmm0
    54f2:	66 0f 70 c0 44       	pshufd $0x44,%xmm0,%xmm0
    54f7:	31 d2                	xor    %edx,%edx
    54f9:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)
    5500:	f3 0f 7f 44 d0 08    	movdqu %xmm0,0x8(%rax,%rdx,8)
    5506:	f3 0f 7f 44 d0 18    	movdqu %xmm0,0x18(%rax,%rdx,8)
    550c:	48 83 c2 04          	add    $0x4,%rdx
    5510:	48 39 d1             	cmp    %rdx,%rcx
    5513:	75 eb                	jne    5500 <fwp_p_array_make_typed+0x40>
    5515:	eb 08                	jmp    551f <fwp_p_array_make_typed+0x5f>
    5517:	48 89 5c c8 08       	mov    %rbx,0x8(%rax,%rcx,8)
    551c:	48 ff c1             	inc    %rcx
    551f:	49 39 ce             	cmp    %rcx,%r14
    5522:	75 f3                	jne    5517 <fwp_p_array_make_typed+0x57>
    5524:	48 83 c4 08          	add    $0x8,%rsp
    5528:	5b                   	pop    %rbx
    5529:	41 5e                	pop    %r14
    552b:	c3                   	ret
    552c:	0f 1f 40 00          	nopl   0x0(%rax)

0000000000005530 <fwp_count_arg>:
    5530:	31 c0                	xor    %eax,%eax
    5532:	48 85 ff             	test   %rdi,%rdi
    5535:	48 0f 4f c7          	cmovg  %rdi,%rax
    5539:	c3                   	ret
    553a:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)

0000000000005540 <fwp_array_typed_new>:
    5540:	50                   	push   %rax
    5541:	48 b8 ff ff ff ff ff 	movabs $0x1fffffffffffffff,%rax
    5548:	ff ff 1f 
    554b:	48 39 c7             	cmp    %rax,%rdi
    554e:	73 0e                	jae    555e <fwp_array_typed_new+0x1e>
    5550:	e8 1b 00 00 00       	call   5570 <fwp_arr_new>
    5555:	48 89 c7             	mov    %rax,%rdi
    5558:	58                   	pop    %rax
    5559:	e9 52 d9 ff ff       	jmp    2eb0 <fwp_rc_fresh>
    555e:	48 8d 3d c1 82 00 00 	lea    0x82c1(%rip),%rdi        # d826 <exec_in_fp0+0x1e6>
    5565:	e8 a6 d8 ff ff       	call   2e10 <fwp_trap>
    556a:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)

0000000000005570 <fwp_arr_new>:
    5570:	53                   	push   %rbx
    5571:	48 b8 ff ff ff ff ff 	movabs $0x1fffffffffffffff,%rax
    5578:	ff ff 1f 
    557b:	48 39 c7             	cmp    %rax,%rdi
    557e:	73 15                	jae    5595 <fwp_arr_new+0x25>
    5580:	48 89 fb             	mov    %rdi,%rbx
    5583:	48 8d 3c fd 08 00 00 	lea    0x8(,%rdi,8),%rdi
    558a:	00 
    558b:	e8 20 00 00 00       	call   55b0 <fwp_alloc>
    5590:	48 89 18             	mov    %rbx,(%rax)
    5593:	5b                   	pop    %rbx
    5594:	c3                   	ret
    5595:	48 8d 3d 8a 82 00 00 	lea    0x828a(%rip),%rdi        # d826 <exec_in_fp0+0x1e6>
    559c:	e8 6f d8 ff ff       	call   2e10 <fwp_trap>
    55a1:	66 66 66 66 66 66 2e 	data16 data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    55a8:	0f 1f 84 00 00 00 00 
    55af:	00 

00000000000055b0 <fwp_alloc>:
    55b0:	be 02 00 00 00       	mov    $0x2,%esi
    55b5:	e9 06 db ff ff       	jmp    30c0 <fwp_gc_alloc>
    55ba:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)

00000000000055c0 <fwp_drop0>:
    55c0:	53                   	push   %rbx
    55c1:	48 89 fb             	mov    %rdi,%rbx
    55c4:	e8 17 00 00 00       	call   55e0 <fwp_rc_release_last>
    55c9:	85 c0                	test   %eax,%eax
    55cb:	74 06                	je     55d3 <fwp_drop0+0x13>
    55cd:	48 89 df             	mov    %rbx,%rdi
    55d0:	5b                   	pop    %rbx
    55d1:	eb 3d                	jmp    5610 <fwp_rc_free_arr>
    55d3:	5b                   	pop    %rbx
    55d4:	c3                   	ret
    55d5:	66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
    55dc:	00 00 00 00 

00000000000055e0 <fwp_rc_release_last>:
    55e0:	50                   	push   %rax
    55e1:	e8 ea d6 ff ff       	call   2cd0 <fwp_rc_slot>
    55e6:	48 89 c7             	mov    %rax,%rdi
    55e9:	31 c0                	xor    %eax,%eax
    55eb:	48 85 ff             	test   %rdi,%rdi
    55ee:	74 1a                	je     560a <fwp_rc_release_last+0x2a>
    55f0:	0f b6 07             	movzbl (%rdi),%eax
    55f3:	85 c0                	test   %eax,%eax
    55f5:	74 13                	je     560a <fwp_rc_release_last+0x2a>
    55f7:	83 f8 01             	cmp    $0x1,%eax
    55fa:	75 07                	jne    5603 <fwp_rc_release_last+0x23>
    55fc:	b8 01 00 00 00       	mov    $0x1,%eax
    5601:	59                   	pop    %rcx
    5602:	c3                   	ret
    5603:	e8 a8 00 00 00       	call   56b0 <fwp_rc_drop_slot>
    5608:	31 c0                	xor    %eax,%eax
    560a:	59                   	pop    %rcx
    560b:	c3                   	ret
    560c:	0f 1f 40 00          	nopl   0x0(%rax)

0000000000005610 <fwp_rc_free_arr>:
    5610:	41 56                	push   %r14
    5612:	53                   	push   %rbx
    5613:	50                   	push   %rax
    5614:	48 89 fb             	mov    %rdi,%rbx
    5617:	e8 e4 00 00 00       	call   5700 <fwp_rc_last>
    561c:	85 c0                	test   %eax,%eax
    561e:	74 7d                	je     569d <fwp_rc_free_arr+0x8d>
    5620:	8b 0d 92 f6 00 00    	mov    0xf692(%rip),%ecx        # 14cb8 <fwp_reuse_verify>
    5626:	85 c9                	test   %ecx,%ecx
    5628:	78 0d                	js     5637 <fwp_rc_free_arr+0x27>
    562a:	85 c9                	test   %ecx,%ecx
    562c:	74 41                	je     566f <fwp_rc_free_arr+0x5f>
    562e:	48 c7 03 00 00 00 00 	movq   $0x0,(%rbx)
    5635:	eb 66                	jmp    569d <fwp_rc_free_arr+0x8d>
    5637:	48 8d 3d f8 81 00 00 	lea    0x81f8(%rip),%rdi        # d836 <exec_in_fp0+0x1f6>
    563e:	e8 ed c9 ff ff       	call   2030 <getenv@plt>
    5643:	31 c9                	xor    %ecx,%ecx
    5645:	48 85 c0             	test   %rax,%rax
    5648:	74 1b                	je     5665 <fwp_rc_free_arr+0x55>
    564a:	80 38 00             	cmpb   $0x0,(%rax)
    564d:	74 16                	je     5665 <fwp_rc_free_arr+0x55>
    564f:	48 8d 35 12 8d 00 00 	lea    0x8d12(%rip),%rsi        # e368 <exec_in_fp0+0xd28>
    5656:	48 89 c7             	mov    %rax,%rdi
    5659:	e8 72 cc ff ff       	call   22d0 <strcmp@plt>
    565e:	31 c9                	xor    %ecx,%ecx
    5660:	85 c0                	test   %eax,%eax
    5662:	0f 95 c1             	setne  %cl
    5665:	89 0d 4d f6 00 00    	mov    %ecx,0xf64d(%rip)        # 14cb8 <fwp_reuse_verify>
    566b:	85 c9                	test   %ecx,%ecx
    566d:	75 bf                	jne    562e <fwp_rc_free_arr+0x1e>
    566f:	4c 8b 35 22 dc 00 00 	mov    0xdc22(%rip),%r14        # 13298 <fwp_gc>
    5676:	48 89 df             	mov    %rbx,%rdi
    5679:	e8 a2 00 00 00       	call   5720 <fwp_mem_free>
    567e:	48 8b 05 13 dc 00 00 	mov    0xdc13(%rip),%rax        # 13298 <fwp_gc>
    5685:	4c 29 f0             	sub    %r14,%rax
    5688:	f2 48 0f 2a c0       	cvtsi2sd %rax,%xmm0
    568d:	f2 0f 58 05 0b ee 00 	addsd  0xee0b(%rip),%xmm0        # 144a0 <fwp_gc+0x1208>
    5694:	00 
    5695:	f2 0f 11 05 03 ee 00 	movsd  %xmm0,0xee03(%rip)        # 144a0 <fwp_gc+0x1208>
    569c:	00 
    569d:	48 83 c4 08          	add    $0x8,%rsp
    56a1:	5b                   	pop    %rbx
    56a2:	41 5e                	pop    %r14
    56a4:	c3                   	ret
    56a5:	66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
    56ac:	00 00 00 00 

00000000000056b0 <fwp_rc_drop_slot>:
    56b0:	0f b6 07             	movzbl (%rdi),%eax
    56b3:	3c ff                	cmp    $0xff,%al
    56b5:	74 09                	je     56c0 <fwp_rc_wide_drop>
    56b7:	3c 02                	cmp    $0x2,%al
    56b9:	72 04                	jb     56bf <fwp_rc_drop_slot+0xf>
    56bb:	fe c8                	dec    %al
    56bd:	88 07                	mov    %al,(%rdi)
    56bf:	c3                   	ret

00000000000056c0 <fwp_rc_wide_drop>:
    56c0:	53                   	push   %rbx
    56c1:	48 89 fb             	mov    %rdi,%rbx
    56c4:	e8 e7 d6 ff ff       	call   2db0 <fwp_rc_wide_link>
    56c9:	48 8b 00             	mov    (%rax),%rax
    56cc:	48 85 c0             	test   %rax,%rax
    56cf:	74 21                	je     56f2 <fwp_rc_wide_drop+0x32>
    56d1:	48 8b 48 08          	mov    0x8(%rax),%rcx
    56d5:	48 ff c9             	dec    %rcx
    56d8:	48 89 48 08          	mov    %rcx,0x8(%rax)
    56dc:	48 81 f9 fe 00 00 00 	cmp    $0xfe,%rcx
    56e3:	75 0b                	jne    56f0 <fwp_rc_wide_drop+0x30>
    56e5:	48 89 df             	mov    %rbx,%rdi
    56e8:	e8 83 d6 ff ff       	call   2d70 <fwp_rc_forget_slot>
    56ed:	c6 03 fe             	movb   $0xfe,(%rbx)
    56f0:	5b                   	pop    %rbx
    56f1:	c3                   	ret
    56f2:	48 8d 3d f8 7f 00 00 	lea    0x7ff8(%rip),%rdi        # d6f1 <exec_in_fp0+0xb1>
    56f9:	e8 12 d7 ff ff       	call   2e10 <fwp_trap>
    56fe:	66 90                	xchg   %ax,%ax

0000000000005700 <fwp_rc_last>:
    5700:	50                   	push   %rax
    5701:	e8 ca d5 ff ff       	call   2cd0 <fwp_rc_slot>
    5706:	48 85 c0             	test   %rax,%rax
    5709:	74 0d                	je     5718 <fwp_rc_last+0x18>
    570b:	48 89 c1             	mov    %rax,%rcx
    570e:	31 c0                	xor    %eax,%eax
    5710:	80 39 01             	cmpb   $0x1,(%rcx)
    5713:	0f 94 c0             	sete   %al
    5716:	59                   	pop    %rcx
    5717:	c3                   	ret
    5718:	31 c0                	xor    %eax,%eax
    571a:	59                   	pop    %rcx
    571b:	c3                   	ret
    571c:	0f 1f 40 00          	nopl   0x0(%rax)

0000000000005720 <fwp_mem_free>:
    5720:	48 85 ff             	test   %rdi,%rdi
    5723:	0f 84 c7 01 00 00    	je     58f0 <fwp_mem_free+0x1d0>
    5729:	41 57                	push   %r15
    572b:	41 56                	push   %r14
    572d:	53                   	push   %rbx
    572e:	48 83 ec 10          	sub    $0x10,%rsp
    5732:	49 89 ff             	mov    %rdi,%r15
    5735:	48 8d 74 24 08       	lea    0x8(%rsp),%rsi
    573a:	e8 c1 f4 ff ff       	call   4c00 <fwp_gc_chunk_of>
    573f:	48 85 c0             	test   %rax,%rax
    5742:	0f 84 9f 01 00 00    	je     58e7 <fwp_mem_free+0x1c7>
    5748:	49 89 c6             	mov    %rax,%r14
    574b:	0f b6 00             	movzbl (%rax),%eax
    574e:	83 f8 02             	cmp    $0x2,%eax
    5751:	0f 84 96 00 00 00    	je     57ed <fwp_mem_free+0xcd>
    5757:	83 f8 01             	cmp    $0x1,%eax
    575a:	0f 85 87 01 00 00    	jne    58e7 <fwp_mem_free+0x1c7>
    5760:	41 0f b6 46 01       	movzbl 0x1(%r14),%eax
    5765:	41 0f b6 4e 02       	movzbl 0x2(%r14),%ecx
    576a:	48 69 c0 c0 03 00 00 	imul   $0x3c0,%rax,%rax
    5771:	48 8d 35 20 db 00 00 	lea    0xdb20(%rip),%rsi        # 13298 <fwp_gc>
    5778:	48 01 c6             	add    %rax,%rsi
    577b:	48 8d 3c 49          	lea    (%rcx,%rcx,2),%rdi
    577f:	41 0f b7 c7          	movzwl %r15w,%eax
    5783:	31 d2                	xor    %edx,%edx
    5785:	41 f7 76 08          	divl   0x8(%r14)
    5789:	48 c7 c2 fe ff ff ff 	mov    $0xfffffffffffffffe,%rdx
    5790:	89 c1                	mov    %eax,%ecx
    5792:	48 d3 c2             	rol    %cl,%rdx
    5795:	48 8d 1c fe          	lea    (%rsi,%rdi,8),%rbx
    5799:	48 83 c3 08          	add    $0x8,%rbx
    579d:	49 8d 3c 06          	lea    (%r14,%rax,1),%rdi
    57a1:	48 81 c7 28 02 00 00 	add    $0x228,%rdi
    57a8:	c1 e8 03             	shr    $0x3,%eax
    57ab:	25 f8 1f 00 00       	and    $0x1ff8,%eax
    57b0:	49 21 54 06 28       	and    %rdx,0x28(%r14,%rax,1)
    57b5:	e8 86 d5 ff ff       	call   2d40 <fwp_rc_clear_slot>
    57ba:	83 3d db ea 00 00 00 	cmpl   $0x0,0xeadb(%rip)        # 1429c <fwp_gc+0x1004>
    57c1:	74 0e                	je     57d1 <fwp_mem_free+0xb1>
    57c3:	41 8b 56 08          	mov    0x8(%r14),%edx
    57c7:	4c 89 ff             	mov    %r15,%rdi
    57ca:	31 f6                	xor    %esi,%esi
    57cc:	e8 3f ca ff ff       	call   2210 <memset@plt>
    57d1:	48 8b 03             	mov    (%rbx),%rax
    57d4:	48 f7 d0             	not    %rax
    57d7:	49 89 07             	mov    %rax,(%r15)
    57da:	4c 89 3b             	mov    %r15,(%rbx)
    57dd:	41 8b 46 08          	mov    0x8(%r14),%eax
    57e1:	48 01 05 b0 da 00 00 	add    %rax,0xdab0(%rip)        # 13298 <fwp_gc>
    57e8:	e9 fa 00 00 00       	jmp    58e7 <fwp_mem_free+0x1c7>
    57ed:	48 8b 5c 24 08       	mov    0x8(%rsp),%rbx
    57f2:	48 89 df             	mov    %rbx,%rdi
    57f5:	e8 66 d5 ff ff       	call   2d60 <fwp_gc_chunk_addr>
    57fa:	4c 39 f8             	cmp    %r15,%rax
    57fd:	0f 85 e4 00 00 00    	jne    58e7 <fwp_mem_free+0x1c7>
    5803:	49 8b 46 18          	mov    0x18(%r14),%rax
    5807:	48 01 05 8a da 00 00 	add    %rax,0xda8a(%rip)        # 13298 <fwp_gc>
    580e:	41 c6 46 03 00       	movb   $0x0,0x3(%r14)
    5813:	4c 89 f7             	mov    %r14,%rdi
    5816:	48 81 c7 28 02 00 00 	add    $0x228,%rdi
    581d:	e8 1e d5 ff ff       	call   2d40 <fwp_rc_clear_slot>
    5822:	41 8b 46 10          	mov    0x10(%r14),%eax
    5826:	48 85 c0             	test   %rax,%rax
    5829:	0f 84 91 00 00 00    	je     58c0 <fwp_mem_free+0x1a0>
    582f:	48 8b 0d da ea 00 00 	mov    0xeada(%rip),%rcx        # 14310 <fwp_gc+0x1078>
    5836:	48 69 f3 28 12 00 00 	imul   $0x1228,%rbx,%rsi
    583d:	89 c2                	mov    %eax,%edx
    583f:	83 e2 03             	and    $0x3,%edx
    5842:	83 f8 04             	cmp    $0x4,%eax
    5845:	73 04                	jae    584b <fwp_mem_free+0x12b>
    5847:	31 ff                	xor    %edi,%edi
    5849:	eb 41                	jmp    588c <fwp_mem_free+0x16c>
    584b:	4c 8d 04 31          	lea    (%rcx,%rsi,1),%r8
    584f:	41 89 c1             	mov    %eax,%r9d
    5852:	41 83 e1 fc          	and    $0xfffffffc,%r9d
    5856:	31 ff                	xor    %edi,%edi
    5858:	0f 1f 84 00 00 00 00 	nopl   0x0(%rax,%rax,1)
    585f:	00 
    5860:	41 c6 00 00          	movb   $0x0,(%r8)
    5864:	41 c6 80 28 12 00 00 	movb   $0x0,0x1228(%r8)
    586b:	00 
    586c:	41 c6 80 50 24 00 00 	movb   $0x0,0x2450(%r8)
    5873:	00 
    5874:	41 c6 80 78 36 00 00 	movb   $0x0,0x3678(%r8)
    587b:	00 
    587c:	48 83 c7 04          	add    $0x4,%rdi
    5880:	49 81 c0 a0 48 00 00 	add    $0x48a0,%r8
    5887:	49 39 f9             	cmp    %rdi,%r9
    588a:	75 d4                	jne    5860 <fwp_mem_free+0x140>
    588c:	48 85 d2             	test   %rdx,%rdx
    588f:	74 2f                	je     58c0 <fwp_mem_free+0x1a0>
    5891:	48 69 ff 28 12 00 00 	imul   $0x1228,%rdi,%rdi
    5898:	48 01 f7             	add    %rsi,%rdi
    589b:	48 01 f9             	add    %rdi,%rcx
    589e:	48 69 d2 28 12 00 00 	imul   $0x1228,%rdx,%rdx
    58a5:	31 f6                	xor    %esi,%esi
    58a7:	66 0f 1f 84 00 00 00 	nopw   0x0(%rax,%rax,1)
    58ae:	00 00 
    58b0:	c6 04 31 00          	movb   $0x0,(%rcx,%rsi,1)
    58b4:	48 81 c6 28 12 00 00 	add    $0x1228,%rsi
    58bb:	48 39 f2             	cmp    %rsi,%rdx
    58be:	75 f0                	jne    58b0 <fwp_mem_free+0x190>
    58c0:	48 01 05 b1 eb 00 00 	add    %rax,0xebb1(%rip)        # 14478 <fwp_gc+0x11e0>
    58c7:	48 3b 1d 3a ea 00 00 	cmp    0xea3a(%rip),%rbx        # 14308 <fwp_gc+0x1070>
    58ce:	73 07                	jae    58d7 <fwp_mem_free+0x1b7>
    58d0:	48 89 1d 31 ea 00 00 	mov    %rbx,0xea31(%rip)        # 14308 <fwp_gc+0x1070>
    58d7:	48 3b 1d 22 ea 00 00 	cmp    0xea22(%rip),%rbx        # 14300 <fwp_gc+0x1068>
    58de:	73 07                	jae    58e7 <fwp_mem_free+0x1c7>
    58e0:	48 89 1d 19 ea 00 00 	mov    %rbx,0xea19(%rip)        # 14300 <fwp_gc+0x1068>
    58e7:	48 83 c4 10          	add    $0x10,%rsp
    58eb:	5b                   	pop    %rbx
    58ec:	41 5e                	pop    %r14
    58ee:	41 5f                	pop    %r15
    58f0:	c3                   	ret
    58f1:	66 66 66 66 66 66 2e 	data16 data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    58f8:	0f 1f 84 00 00 00 00 
    58ff:	00 

0000000000005900 <fwp_drop1>:
    5900:	53                   	push   %rbx
    5901:	48 89 fb             	mov    %rdi,%rbx
    5904:	e8 d7 fc ff ff       	call   55e0 <fwp_rc_release_last>
    5909:	85 c0                	test   %eax,%eax
    590b:	74 09                	je     5916 <fwp_drop1+0x16>
    590d:	48 89 df             	mov    %rbx,%rdi
    5910:	5b                   	pop    %rbx
    5911:	e9 fa fc ff ff       	jmp    5610 <fwp_rc_free_arr>
    5916:	5b                   	pop    %rbx
    5917:	c3                   	ret
    5918:	0f 1f 84 00 00 00 00 	nopl   0x0(%rax,%rax,1)
    591f:	00 

0000000000005920 <fwp_drop2>:
    5920:	53                   	push   %rbx
    5921:	48 89 fb             	mov    %rdi,%rbx
    5924:	e8 b7 fc ff ff       	call   55e0 <fwp_rc_release_last>
    5929:	85 c0                	test   %eax,%eax
    592b:	74 09                	je     5936 <fwp_drop2+0x16>
    592d:	48 89 df             	mov    %rbx,%rdi
    5930:	5b                   	pop    %rbx
    5931:	e9 da fc ff ff       	jmp    5610 <fwp_rc_free_arr>
    5936:	5b                   	pop    %rbx
    5937:	c3                   	ret
    5938:	0f 1f 84 00 00 00 00 	nopl   0x0(%rax,%rax,1)
    593f:	00 

0000000000005940 <fwp_drop3>:
    5940:	53                   	push   %rbx
    5941:	48 89 fb             	mov    %rdi,%rbx
    5944:	e8 97 fc ff ff       	call   55e0 <fwp_rc_release_last>
    5949:	85 c0                	test   %eax,%eax
    594b:	74 09                	je     5956 <fwp_drop3+0x16>
    594d:	48 89 df             	mov    %rbx,%rdi
    5950:	5b                   	pop    %rbx
    5951:	e9 ba fc ff ff       	jmp    5610 <fwp_rc_free_arr>
    5956:	5b                   	pop    %rbx
    5957:	c3                   	ret
    5958:	0f 1f 84 00 00 00 00 	nopl   0x0(%rax,%rax,1)
    595f:	00 

0000000000005960 <fwp_drop4>:
    5960:	53                   	push   %rbx
    5961:	48 89 fb             	mov    %rdi,%rbx
    5964:	e8 77 fc ff ff       	call   55e0 <fwp_rc_release_last>
    5969:	85 c0                	test   %eax,%eax
    596b:	74 09                	je     5976 <fwp_drop4+0x16>
    596d:	48 89 df             	mov    %rbx,%rdi
    5970:	5b                   	pop    %rbx
    5971:	e9 9a fc ff ff       	jmp    5610 <fwp_rc_free_arr>
    5976:	5b                   	pop    %rbx
    5977:	c3                   	ret
    5978:	0f 1f 84 00 00 00 00 	nopl   0x0(%rax,%rax,1)
    597f:	00 

0000000000005980 <fwp_drop5>:
    5980:	53                   	push   %rbx
    5981:	48 89 fb             	mov    %rdi,%rbx
    5984:	e8 57 fc ff ff       	call   55e0 <fwp_rc_release_last>
    5989:	85 c0                	test   %eax,%eax
    598b:	74 09                	je     5996 <fwp_drop5+0x16>
    598d:	48 89 df             	mov    %rbx,%rdi
    5990:	5b                   	pop    %rbx
    5991:	e9 7a fc ff ff       	jmp    5610 <fwp_rc_free_arr>
    5996:	5b                   	pop    %rbx
    5997:	c3                   	ret
    5998:	0f 1f 84 00 00 00 00 	nopl   0x0(%rax,%rax,1)
    599f:	00 

00000000000059a0 <fwp_drop6>:
    59a0:	53                   	push   %rbx
    59a1:	48 89 fb             	mov    %rdi,%rbx
    59a4:	e8 37 fc ff ff       	call   55e0 <fwp_rc_release_last>
    59a9:	85 c0                	test   %eax,%eax
    59ab:	74 09                	je     59b6 <fwp_drop6+0x16>
    59ad:	48 89 df             	mov    %rbx,%rdi
    59b0:	5b                   	pop    %rbx
    59b1:	e9 5a fc ff ff       	jmp    5610 <fwp_rc_free_arr>
    59b6:	5b                   	pop    %rbx
    59b7:	c3                   	ret
    59b8:	0f 1f 84 00 00 00 00 	nopl   0x0(%rax,%rax,1)
    59bf:	00 

00000000000059c0 <fwp_drop7>:
    59c0:	53                   	push   %rbx
    59c1:	48 89 fb             	mov    %rdi,%rbx
    59c4:	e8 17 fc ff ff       	call   55e0 <fwp_rc_release_last>
    59c9:	85 c0                	test   %eax,%eax
    59cb:	74 09                	je     59d6 <fwp_drop7+0x16>
    59cd:	48 89 df             	mov    %rbx,%rdi
    59d0:	5b                   	pop    %rbx
    59d1:	e9 3a fc ff ff       	jmp    5610 <fwp_rc_free_arr>
    59d6:	5b                   	pop    %rbx
    59d7:	c3                   	ret
    59d8:	0f 1f 84 00 00 00 00 	nopl   0x0(%rax,%rax,1)
    59df:	00 

00000000000059e0 <f3>:
    59e0:	53                   	push   %rbx
    59e1:	48 83 ec 30          	sub    $0x30,%rsp
    59e5:	e8 b6 d4 ff ff       	call   2ea0 <fwp_f64>
    59ea:	48 8d 7c 24 18       	lea    0x18(%rsp),%rdi
    59ef:	e8 5c 00 00 00       	call   5a50 <w3>
    59f4:	f2 0f 10 44 24 18    	movsd  0x18(%rsp),%xmm0
    59fa:	e8 41 cf ff ff       	call   2940 <fwp_from_f64>
    59ff:	48 89 04 24          	mov    %rax,(%rsp)
    5a03:	f2 0f 10 44 24 20    	movsd  0x20(%rsp),%xmm0
    5a09:	e8 32 cf ff ff       	call   2940 <fwp_from_f64>
    5a0e:	48 89 44 24 08       	mov    %rax,0x8(%rsp)
    5a13:	f2 0f 10 44 24 28    	movsd  0x28(%rsp),%xmm0
    5a19:	e8 22 cf ff ff       	call   2940 <fwp_from_f64>
    5a1e:	48 89 44 24 10       	mov    %rax,0x10(%rsp)
    5a23:	48 89 e6             	mov    %rsp,%rsi
    5a26:	bf 03 00 00 00       	mov    $0x3,%edi
    5a2b:	e8 c0 d4 ff ff       	call   2ef0 <fwp_record>
    5a30:	48 89 c3             	mov    %rax,%rbx
    5a33:	48 89 c7             	mov    %rax,%rdi
    5a36:	e8 75 d4 ff ff       	call   2eb0 <fwp_rc_fresh>
    5a3b:	48 89 d8             	mov    %rbx,%rax
    5a3e:	48 83 c4 30          	add    $0x30,%rsp
    5a42:	5b                   	pop    %rbx
    5a43:	c3                   	ret
    5a44:	66 66 66 2e 0f 1f 84 	data16 data16 cs nopw 0x0(%rax,%rax,1)
    5a4b:	00 00 00 00 00 

0000000000005a50 <w3>:
    5a50:	41 57                	push   %r15
    5a52:	41 56                	push   %r14
    5a54:	41 54                	push   %r12
    5a56:	53                   	push   %rbx
    5a57:	50                   	push   %rax
    5a58:	48 89 fb             	mov    %rdi,%rbx
    5a5b:	e8 e0 ce ff ff       	call   2940 <fwp_from_f64>
    5a60:	49 89 c6             	mov    %rax,%r14
    5a63:	48 bf 00 00 00 00 00 	movabs $0x3fd0000000000000,%rdi
    5a6a:	00 d0 3f 
    5a6d:	48 89 c6             	mov    %rax,%rsi
    5a70:	e8 4b 00 00 00       	call   5ac0 <f6>
    5a75:	49 89 c7             	mov    %rax,%r15
    5a78:	4c 89 f7             	mov    %r14,%rdi
    5a7b:	e8 70 00 00 00       	call   5af0 <f10>
    5a80:	49 89 c4             	mov    %rax,%r12
    5a83:	4c 89 f7             	mov    %r14,%rdi
    5a86:	e8 15 d4 ff ff       	call   2ea0 <fwp_f64>
    5a8b:	f2 0f 11 03          	movsd  %xmm0,(%rbx)
    5a8f:	4c 89 ff             	mov    %r15,%rdi
    5a92:	e8 09 d4 ff ff       	call   2ea0 <fwp_f64>
    5a97:	f2 0f 11 43 08       	movsd  %xmm0,0x8(%rbx)
    5a9c:	4c 89 e7             	mov    %r12,%rdi
    5a9f:	e8 fc d3 ff ff       	call   2ea0 <fwp_f64>
    5aa4:	f2 0f 11 43 10       	movsd  %xmm0,0x10(%rbx)
    5aa9:	48 89 d8             	mov    %rbx,%rax
    5aac:	48 83 c4 08          	add    $0x8,%rsp
    5ab0:	5b                   	pop    %rbx
    5ab1:	41 5c                	pop    %r12
    5ab3:	41 5e                	pop    %r14
    5ab5:	41 5f                	pop    %r15
    5ab7:	c3                   	ret
    5ab8:	0f 1f 84 00 00 00 00 	nopl   0x0(%rax,%rax,1)
    5abf:	00 

0000000000005ac0 <f6>:
    5ac0:	53                   	push   %rbx
    5ac1:	48 83 ec 10          	sub    $0x10,%rsp
    5ac5:	48 89 fb             	mov    %rdi,%rbx
    5ac8:	48 89 f7             	mov    %rsi,%rdi
    5acb:	e8 d0 d3 ff ff       	call   2ea0 <fwp_f64>
    5ad0:	f2 0f 11 44 24 08    	movsd  %xmm0,0x8(%rsp)
    5ad6:	48 89 df             	mov    %rbx,%rdi
    5ad9:	e8 c2 d3 ff ff       	call   2ea0 <fwp_f64>
    5ade:	f2 0f 58 44 24 08    	addsd  0x8(%rsp),%xmm0
    5ae4:	48 83 c4 10          	add    $0x10,%rsp
    5ae8:	5b                   	pop    %rbx
    5ae9:	e9 52 ce ff ff       	jmp    2940 <fwp_from_f64>
    5aee:	66 90                	xchg   %ax,%ax

0000000000005af0 <f10>:
    5af0:	50                   	push   %rax
    5af1:	e8 aa d3 ff ff       	call   2ea0 <fwp_f64>
    5af6:	0f 57 05 23 76 00 00 	xorps  0x7623(%rip),%xmm0        # d120 <_IO_stdin_used+0x120>
    5afd:	58                   	pop    %rax
    5afe:	e9 3d ce ff ff       	jmp    2940 <fwp_from_f64>
    5b03:	66 66 66 66 2e 0f 1f 	data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    5b0a:	84 00 00 00 00 00 

0000000000005b10 <fwp_stack_guard_init>:
    5b10:	53                   	push   %rbx
    5b11:	48 81 ec c0 00 00 00 	sub    $0xc0,%rsp
    5b18:	48 8d 44 24 0f       	lea    0xf(%rsp),%rax
    5b1d:	48 89 05 84 f2 00 00 	mov    %rax,0xf284(%rip)        # 14da8 <fwp_main_stack_top>
    5b24:	48 89 3d 85 f2 00 00 	mov    %rdi,0xf285(%rip)        # 14db0 <fwp_main_stack_size>
    5b2b:	48 8d 05 8e f2 00 00 	lea    0xf28e(%rip),%rax        # 14dc0 <fwp_stack_guard_init.alt>
    5b32:	48 89 44 24 10       	mov    %rax,0x10(%rsp)
    5b37:	48 c7 44 24 20 00 00 	movq   $0x10000,0x20(%rsp)
    5b3e:	01 00 
    5b40:	c7 44 24 18 00 00 00 	movl   $0x0,0x18(%rsp)
    5b47:	00 
    5b48:	48 8d 7c 24 10       	lea    0x10(%rsp),%rdi
    5b4d:	31 f6                	xor    %esi,%esi
    5b4f:	e8 7c c9 ff ff       	call   24d0 <sigaltstack@plt>
    5b54:	85 c0                	test   %eax,%eax
    5b56:	0f 85 80 00 00 00    	jne    5bdc <fwp_stack_guard_init+0xcc>
    5b5c:	48 8d 7c 24 30       	lea    0x30(%rsp),%rdi
    5b61:	0f 57 c0             	xorps  %xmm0,%xmm0
    5b64:	0f 11 84 24 b0 00 00 	movups %xmm0,0xb0(%rsp)
    5b6b:	00 
    5b6c:	0f 11 84 24 a0 00 00 	movups %xmm0,0xa0(%rsp)
    5b73:	00 
    5b74:	0f 11 84 24 90 00 00 	movups %xmm0,0x90(%rsp)
    5b7b:	00 
    5b7c:	0f 11 84 24 80 00 00 	movups %xmm0,0x80(%rsp)
    5b83:	00 
    5b84:	0f 11 44 24 70       	movups %xmm0,0x70(%rsp)
    5b89:	0f 11 44 24 60       	movups %xmm0,0x60(%rsp)
    5b8e:	0f 11 44 24 50       	movups %xmm0,0x50(%rsp)
    5b93:	0f 11 44 24 40       	movups %xmm0,0x40(%rsp)
    5b98:	0f 11 44 24 30       	movups %xmm0,0x30(%rsp)
    5b9d:	48 8d 05 7c 07 00 00 	lea    0x77c(%rip),%rax        # 6320 <fwp_segv>
    5ba4:	48 89 44 24 28       	mov    %rax,0x28(%rsp)
    5ba9:	c7 84 24 b0 00 00 00 	movl   $0x8000004,0xb0(%rsp)
    5bb0:	04 00 00 08 
    5bb4:	e8 57 c7 ff ff       	call   2310 <sigemptyset@plt>
    5bb9:	48 8d 5c 24 28       	lea    0x28(%rsp),%rbx
    5bbe:	bf 0b 00 00 00       	mov    $0xb,%edi
    5bc3:	48 89 de             	mov    %rbx,%rsi
    5bc6:	31 d2                	xor    %edx,%edx
    5bc8:	e8 13 c5 ff ff       	call   20e0 <sigaction@plt>
    5bcd:	bf 07 00 00 00       	mov    $0x7,%edi
    5bd2:	48 89 de             	mov    %rbx,%rsi
    5bd5:	31 d2                	xor    %edx,%edx
    5bd7:	e8 04 c5 ff ff       	call   20e0 <sigaction@plt>
    5bdc:	48 81 c4 c0 00 00 00 	add    $0xc0,%rsp
    5be3:	5b                   	pop    %rbx
    5be4:	c3                   	ret
    5be5:	66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
    5bec:	00 00 00 00 

0000000000005bf0 <fwp_exec>:
    5bf0:	55                   	push   %rbp
    5bf1:	41 57                	push   %r15
    5bf3:	41 56                	push   %r14
    5bf5:	41 55                	push   %r13
    5bf7:	41 54                	push   %r12
    5bf9:	53                   	push   %rbx
    5bfa:	48 81 ec 58 01 00 00 	sub    $0x158,%rsp
    5c01:	49 89 f7             	mov    %rsi,%r15
    5c04:	41 89 fd             	mov    %edi,%r13d
    5c07:	41 8d 5d ff          	lea    -0x1(%r13),%ebx
    5c0b:	80 3d 8e f1 00 00 01 	cmpb   $0x1,0xf18e(%rip)        # 14da0 <fwp_cli_single>
    5c12:	75 16                	jne    5c2a <fwp_exec+0x3a>
    5c14:	49 8d 77 08          	lea    0x8(%r15),%rsi
    5c18:	89 df                	mov    %ebx,%edi
    5c1a:	e8 91 07 00 00       	call   63b0 <fwp_generated>
    5c1f:	41 89 c6             	mov    %eax,%r14d
    5c22:	85 c0                	test   %eax,%eax
    5c24:	0f 89 1a 01 00 00    	jns    5d44 <fwp_exec+0x154>
    5c2a:	89 5c 24 18          	mov    %ebx,0x18(%rsp)
    5c2e:	49 63 fd             	movslq %r13d,%rdi
    5c31:	48 c1 e7 03          	shl    $0x3,%rdi
    5c35:	48 89 7c 24 48       	mov    %rdi,0x48(%rsp)
    5c3a:	e8 71 f9 ff ff       	call   55b0 <fwp_alloc>
    5c3f:	49 89 c4             	mov    %rax,%r12
    5c42:	41 83 fd 02          	cmp    $0x2,%r13d
    5c46:	7c 30                	jl     5c78 <fwp_exec+0x88>
    5c48:	8b 6c 24 18          	mov    0x18(%rsp),%ebp
    5c4c:	31 db                	xor    %ebx,%ebx
    5c4e:	66 90                	xchg   %ax,%ax
    5c50:	4c 8d 73 01          	lea    0x1(%rbx),%r14
    5c54:	4d 8b 6c df 08       	mov    0x8(%r15,%rbx,8),%r13
    5c59:	4c 89 ef             	mov    %r13,%rdi
    5c5c:	e8 0f c5 ff ff       	call   2170 <strlen@plt>
    5c61:	4c 89 ef             	mov    %r13,%rdi
    5c64:	48 89 c6             	mov    %rax,%rsi
    5c67:	e8 a4 08 00 00       	call   6510 <fwp_str_lossy>
    5c6c:	49 89 04 dc          	mov    %rax,(%r12,%rbx,8)
    5c70:	4c 89 f3             	mov    %r14,%rbx
    5c73:	4c 39 f5             	cmp    %r14,%rbp
    5c76:	75 d8                	jne    5c50 <fwp_exec+0x60>
    5c78:	bf 08 00 00 00       	mov    $0x8,%edi
    5c7d:	e8 2e f9 ff ff       	call   55b0 <fwp_alloc>
    5c82:	bf 01 00 00 00       	mov    $0x1,%edi
    5c87:	e8 64 0a 00 00       	call   66f0 <fwp_alloc_leaf>
    5c8c:	48 8b 7c 24 48       	mov    0x48(%rsp),%rdi
    5c91:	e8 1a f9 ff ff       	call   55b0 <fwp_alloc>
    5c96:	49 89 c6             	mov    %rax,%r14
    5c99:	48 8d 4c 24 2c       	lea    0x2c(%rsp),%rcx
    5c9e:	8b 7c 24 18          	mov    0x18(%rsp),%edi
    5ca2:	4c 89 e6             	mov    %r12,%rsi
    5ca5:	48 89 c2             	mov    %rax,%rdx
    5ca8:	e8 53 0a 00 00       	call   6700 <fwp_cli_parse>
    5cad:	83 f8 02             	cmp    $0x2,%eax
    5cb0:	74 32                	je     5ce4 <fwp_exec+0xf4>
    5cb2:	83 f8 01             	cmp    $0x1,%eax
    5cb5:	75 5d                	jne    5d14 <fwp_exec+0x124>
    5cb7:	48 8b 1d f2 d2 00 00 	mov    0xd2f2(%rip),%rbx        # 12fb0 <stdout@GLIBC_2.2.5>
    5cbe:	48 8b 0b             	mov    (%rbx),%rcx
    5cc1:	48 8d 3d 51 87 00 00 	lea    0x8751(%rip),%rdi        # e419 <exec_in_fp0+0xdd9>
    5cc8:	be 72 00 00 00       	mov    $0x72,%esi
    5ccd:	ba 01 00 00 00       	mov    $0x1,%edx
    5cd2:	e8 c9 c7 ff ff       	call   24a0 <fwrite@plt>
    5cd7:	48 8b 3b             	mov    (%rbx),%rdi
    5cda:	e8 71 c6 ff ff       	call   2350 <fflush@plt>
    5cdf:	45 31 f6             	xor    %r14d,%r14d
    5ce2:	eb 60                	jmp    5d44 <fwp_exec+0x154>
    5ce4:	48 8d 3d 9c 83 00 00 	lea    0x839c(%rip),%rdi        # e087 <exec_in_fp0+0xa47>
    5ceb:	48 8d 15 8e 79 00 00 	lea    0x798e(%rip),%rdx        # d680 <exec_in_fp0+0x40>
    5cf2:	45 31 f6             	xor    %r14d,%r14d
    5cf5:	be 06 00 00 00       	mov    $0x6,%esi
    5cfa:	31 c9                	xor    %ecx,%ecx
    5cfc:	31 c0                	xor    %eax,%eax
    5cfe:	e8 bd c4 ff ff       	call   21c0 <printf@plt>
    5d03:	48 8b 05 a6 d2 00 00 	mov    0xd2a6(%rip),%rax        # 12fb0 <stdout@GLIBC_2.2.5>
    5d0a:	48 8b 38             	mov    (%rax),%rdi
    5d0d:	e8 3e c6 ff ff       	call   2350 <fflush@plt>
    5d12:	eb 30                	jmp    5d44 <fwp_exec+0x154>
    5d14:	bf 10 00 00 00       	mov    $0x10,%edi
    5d19:	e8 92 f8 ff ff       	call   55b0 <fwp_alloc>
    5d1e:	49 89 c7             	mov    %rax,%r15
    5d21:	c7 44 24 14 00 00 00 	movl   $0x0,0x14(%rsp)
    5d28:	00 
    5d29:	8b 74 24 2c          	mov    0x2c(%rsp),%esi
    5d2d:	48 8d 4c 24 14       	lea    0x14(%rsp),%rcx
    5d32:	4c 89 f7             	mov    %r14,%rdi
    5d35:	48 89 c2             	mov    %rax,%rdx
    5d38:	e8 23 0c 00 00       	call   6960 <fwp_bind_positional>
    5d3d:	41 89 c6             	mov    %eax,%r14d
    5d40:	85 c0                	test   %eax,%eax
    5d42:	74 15                	je     5d59 <fwp_exec+0x169>
    5d44:	44 89 f0             	mov    %r14d,%eax
    5d47:	48 81 c4 58 01 00 00 	add    $0x158,%rsp
    5d4e:	5b                   	pop    %rbx
    5d4f:	41 5c                	pop    %r12
    5d51:	41 5d                	pop    %r13
    5d53:	41 5e                	pop    %r14
    5d55:	41 5f                	pop    %r15
    5d57:	5d                   	pop    %rbp
    5d58:	c3                   	ret
    5d59:	48 8d 3d 30 83 00 00 	lea    0x8330(%rip),%rdi        # e090 <exec_in_fp0+0xa50>
    5d60:	e8 cb c2 ff ff       	call   2030 <getenv@plt>
    5d65:	48 85 c0             	test   %rax,%rax
    5d68:	74 27                	je     5d91 <fwp_exec+0x1a1>
    5d6a:	48 8d 35 27 83 00 00 	lea    0x8327(%rip),%rsi        # e098 <exec_in_fp0+0xa58>
    5d71:	48 89 c7             	mov    %rax,%rdi
    5d74:	e8 57 c5 ff ff       	call   22d0 <strcmp@plt>
    5d79:	31 c9                	xor    %ecx,%ecx
    5d7b:	85 c0                	test   %eax,%eax
    5d7d:	0f 94 c1             	sete   %cl
    5d80:	89 0d 3a f0 01 00    	mov    %ecx,0x1f03a(%rip)        # 24dc0 <fwp_exec_binary_out>
    5d86:	75 26                	jne    5dae <fwp_exec+0x1be>
    5d88:	48 8b 05 49 d2 00 00 	mov    0xd249(%rip),%rax        # 12fd8 <stderr@GLIBC_2.2.5>
    5d8f:	eb 24                	jmp    5db5 <fwp_exec+0x1c5>
    5d91:	c7 05 25 f0 01 00 00 	movl   $0x0,0x1f025(%rip)        # 24dc0 <fwp_exec_binary_out>
    5d98:	00 00 00 
    5d9b:	48 8b 05 0e d2 00 00 	mov    0xd20e(%rip),%rax        # 12fb0 <stdout@GLIBC_2.2.5>
    5da2:	48 8b 00             	mov    (%rax),%rax
    5da5:	48 89 05 9c ef 00 00 	mov    %rax,0xef9c(%rip)        # 14d48 <fwp_prog_out>
    5dac:	eb 33                	jmp    5de1 <fwp_exec+0x1f1>
    5dae:	48 8b 05 fb d1 00 00 	mov    0xd1fb(%rip),%rax        # 12fb0 <stdout@GLIBC_2.2.5>
    5db5:	48 8b 00             	mov    (%rax),%rax
    5db8:	48 89 05 89 ef 00 00 	mov    %rax,0xef89(%rip)        # 14d48 <fwp_prog_out>
    5dbf:	75 20                	jne    5de1 <fwp_exec+0x1f1>
    5dc1:	e8 da 0b 00 00       	call   69a0 <fwp_pipe_out_start>
    5dc6:	48 8d 3d 43 78 00 00 	lea    0x7843(%rip),%rdi        # d610 <exec_out_header0>
    5dcd:	be 30 00 00 00       	mov    $0x30,%esi
    5dd2:	e8 99 0c 00 00       	call   6a70 <fwp_pipe_write>
    5dd7:	e8 44 0d 00 00       	call   6b20 <fwp_pipe_flush>
    5ddc:	e8 6f 0d 00 00       	call   6b50 <fwp_pipe_out_ready>
    5de1:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%rsp)
    5de8:	00 
    5de9:	83 7c 24 14 00       	cmpl   $0x0,0x14(%rsp)
    5dee:	0f 84 57 01 00 00    	je     5f4b <fwp_exec+0x35b>
    5df4:	48 8b 1d bd d1 00 00 	mov    0xd1bd(%rip),%rbx        # 12fb8 <stdin@GLIBC_2.2.5>
    5dfb:	48 8b 3b             	mov    (%rbx),%rdi
    5dfe:	b9 00 00 10 00       	mov    $0x100000,%ecx
    5e03:	31 f6                	xor    %esi,%esi
    5e05:	31 d2                	xor    %edx,%edx
    5e07:	e8 a4 c5 ff ff       	call   23b0 <setvbuf@plt>
    5e0c:	48 8b 0b             	mov    (%rbx),%rcx
    5e0f:	48 8d 3d ae ef 01 00 	lea    0x1efae(%rip),%rdi        # 24dc4 <fwp_in_pend>
    5e16:	be 01 00 00 00       	mov    $0x1,%esi
    5e1b:	ba 04 00 00 00       	mov    $0x4,%edx
    5e20:	e8 cb c2 ff ff       	call   20f0 <fread@plt>
    5e25:	89 05 9d ef 01 00    	mov    %eax,0x1ef9d(%rip)        # 24dc8 <fwp_in_npend>
    5e2b:	c7 05 97 ef 01 00 00 	movl   $0x0,0x1ef97(%rip)        # 24dcc <fwp_in_ppos>
    5e32:	00 00 00 
    5e35:	41 b4 01             	mov    $0x1,%r12b
    5e38:	83 f8 04             	cmp    $0x4,%eax
    5e3b:	4c 89 7c 24 18       	mov    %r15,0x18(%rsp)
    5e40:	0f 85 d3 01 00 00    	jne    6019 <fwp_exec+0x429>
    5e46:	81 3d 74 ef 01 00 46 	cmpl   $0x31505746,0x1ef74(%rip)        # 24dc4 <fwp_in_pend>
    5e4d:	57 50 31 
    5e50:	0f 85 c3 01 00 00    	jne    6019 <fwp_exec+0x429>
    5e56:	c7 05 6c ef 01 00 04 	movl   $0x4,0x1ef6c(%rip)        # 24dcc <fwp_in_ppos>
    5e5d:	00 00 00 
    5e60:	48 8d 7c 24 03       	lea    0x3(%rsp),%rdi
    5e65:	be 01 00 00 00       	mov    $0x1,%esi
    5e6a:	e8 41 0e 00 00       	call   6cb0 <fwp_read_exact>
    5e6f:	85 c0                	test   %eax,%eax
    5e71:	0f 84 c3 03 00 00    	je     623a <fwp_exec+0x64a>
    5e77:	48 8d 7c 24 20       	lea    0x20(%rsp),%rdi
    5e7c:	e8 2f 0f 00 00       	call   6db0 <fwp_stdin_leb>
    5e81:	83 f8 01             	cmp    $0x1,%eax
    5e84:	0f 85 99 03 00 00    	jne    6223 <fwp_exec+0x633>
    5e8a:	48 8b 44 24 20       	mov    0x20(%rsp),%rax
    5e8f:	48 83 f8 40          	cmp    $0x40,%rax
    5e93:	41 bd 40 00 00 00    	mov    $0x40,%r13d
    5e99:	4c 0f 42 e8          	cmovb  %rax,%r13
    5e9d:	48 85 c0             	test   %rax,%rax
    5ea0:	0f 84 e2 00 00 00    	je     5f88 <fwp_exec+0x398>
    5ea6:	45 31 f6             	xor    %r14d,%r14d
    5ea9:	4c 8d 7c 24 50       	lea    0x50(%rsp),%r15
    5eae:	31 ed                	xor    %ebp,%ebp
    5eb0:	eb 4a                	jmp    5efc <fwp_exec+0x30c>
    5eb2:	be 06 00 00 00       	mov    $0x6,%esi
    5eb7:	4c 89 ff             	mov    %r15,%rdi
    5eba:	e8 f1 0d 00 00       	call   6cb0 <fwp_read_exact>
    5ebf:	85 c0                	test   %eax,%eax
    5ec1:	0f 84 73 03 00 00    	je     623a <fwp_exec+0x64a>
    5ec7:	8b 44 24 50          	mov    0x50(%rsp),%eax
    5ecb:	b9 55 44 53 5f       	mov    $0x5f534455,%ecx
    5ed0:	31 c8                	xor    %ecx,%eax
    5ed2:	0f b7 4c 24 54       	movzwl 0x54(%rsp),%ecx
    5ed7:	81 f1 56 31 00 00    	xor    $0x3156,%ecx
    5edd:	09 c1                	or     %eax,%ecx
    5edf:	b8 01 00 00 00       	mov    $0x1,%eax
    5ee4:	0f 44 e8             	cmove  %eax,%ebp
    5ee7:	48 c7 44 24 08 00 00 	movq   $0x0,0x8(%rsp)
    5eee:	00 00 
    5ef0:	49 ff c6             	inc    %r14
    5ef3:	4d 39 ee             	cmp    %r13,%r14
    5ef6:	0f 84 8e 00 00 00    	je     5f8a <fwp_exec+0x39a>
    5efc:	48 8d 7c 24 08       	lea    0x8(%rsp),%rdi
    5f01:	e8 2a 0f 00 00       	call   6e30 <fwp_stdin_name_len>
    5f06:	83 f8 01             	cmp    $0x1,%eax
    5f09:	0f 85 14 03 00 00    	jne    6223 <fwp_exec+0x633>
    5f0f:	48 8b 5c 24 08       	mov    0x8(%rsp),%rbx
    5f14:	48 85 db             	test   %rbx,%rbx
    5f17:	74 ce                	je     5ee7 <fwp_exec+0x2f7>
    5f19:	48 83 fb 06          	cmp    $0x6,%rbx
    5f1d:	74 93                	je     5eb2 <fwp_exec+0x2c2>
    5f1f:	90                   	nop
    5f20:	48 81 fb 00 01 00 00 	cmp    $0x100,%rbx
    5f27:	41 bc 00 01 00 00    	mov    $0x100,%r12d
    5f2d:	4c 0f 42 e3          	cmovb  %rbx,%r12
    5f31:	4c 89 ff             	mov    %r15,%rdi
    5f34:	4c 89 e6             	mov    %r12,%rsi
    5f37:	e8 74 0d 00 00       	call   6cb0 <fwp_read_exact>
    5f3c:	85 c0                	test   %eax,%eax
    5f3e:	0f 84 f6 02 00 00    	je     623a <fwp_exec+0x64a>
    5f44:	4c 29 e3             	sub    %r12,%rbx
    5f47:	75 d7                	jne    5f20 <fwp_exec+0x330>
    5f49:	eb 9c                	jmp    5ee7 <fwp_exec+0x2f7>
    5f4b:	48 8d 74 24 04       	lea    0x4(%rsp),%rsi
    5f50:	4c 89 ff             	mov    %r15,%rdi
    5f53:	e8 98 0c 00 00       	call   6bf0 <fwp_exec_call>
    5f58:	48 89 c3             	mov    %rax,%rbx
    5f5b:	48 8b 3d e6 ed 00 00 	mov    0xede6(%rip),%rdi        # 14d48 <fwp_prog_out>
    5f62:	e8 e9 c3 ff ff       	call   2350 <fflush@plt>
    5f67:	41 be 01 00 00 00    	mov    $0x1,%r14d
    5f6d:	83 7c 24 04 00       	cmpl   $0x0,0x4(%rsp)
    5f72:	0f 85 83 02 00 00    	jne    61fb <fwp_exec+0x60b>
    5f78:	48 89 df             	mov    %rbx,%rdi
    5f7b:	e8 20 0d 00 00       	call   6ca0 <fwp_emit_result>
    5f80:	45 31 f6             	xor    %r14d,%r14d
    5f83:	e9 73 02 00 00       	jmp    61fb <fwp_exec+0x60b>
    5f88:	31 ed                	xor    %ebp,%ebp
    5f8a:	48 8d 7c 24 30       	lea    0x30(%rsp),%rdi
    5f8f:	be 10 00 00 00       	mov    $0x10,%esi
    5f94:	e8 17 0d 00 00       	call   6cb0 <fwp_read_exact>
    5f99:	85 c0                	test   %eax,%eax
    5f9b:	0f 84 99 02 00 00    	je     623a <fwp_exec+0x64a>
    5fa1:	48 8d 7c 24 08       	lea    0x8(%rsp),%rdi
    5fa6:	e8 85 0e 00 00       	call   6e30 <fwp_stdin_name_len>
    5fab:	83 f8 01             	cmp    $0x1,%eax
    5fae:	0f 85 6f 02 00 00    	jne    6223 <fwp_exec+0x633>
    5fb4:	4c 8b 7c 24 08       	mov    0x8(%rsp),%r15
    5fb9:	49 8d 7f 01          	lea    0x1(%r15),%rdi
    5fbd:	e8 2e 07 00 00       	call   66f0 <fwp_alloc_leaf>
    5fc2:	49 89 c6             	mov    %rax,%r14
    5fc5:	4d 85 ff             	test   %r15,%r15
    5fc8:	74 13                	je     5fdd <fwp_exec+0x3ed>
    5fca:	4c 89 f7             	mov    %r14,%rdi
    5fcd:	4c 89 fe             	mov    %r15,%rsi
    5fd0:	e8 db 0c 00 00       	call   6cb0 <fwp_read_exact>
    5fd5:	85 c0                	test   %eax,%eax
    5fd7:	0f 84 5d 02 00 00    	je     623a <fwp_exec+0x64a>
    5fdd:	43 c6 04 3e 00       	movb   $0x0,(%r14,%r15,1)
    5fe2:	0f b6 4c 24 03       	movzbl 0x3(%rsp),%ecx
    5fe7:	83 f9 01             	cmp    $0x1,%ecx
    5fea:	0f 85 ab 02 00 00    	jne    629b <fwp_exec+0x6ab>
    5ff0:	66 0f 6f 44 24 30    	movdqa 0x30(%rsp),%xmm0
    5ff6:	66 0f 74 05 32 71 00 	pcmpeqb 0x7132(%rip),%xmm0        # d130 <_IO_stdin_used+0x130>
    5ffd:	00 
    5ffe:	66 0f d7 c0          	pmovmskb %xmm0,%eax
    6002:	3d ff ff 00 00       	cmp    $0xffff,%eax
    6007:	0f 85 af 02 00 00    	jne    62bc <fwp_exec+0x6cc>
    600d:	85 ed                	test   %ebp,%ebp
    600f:	74 05                	je     6016 <fwp_exec+0x426>
    6011:	e8 4a 0e 00 00       	call   6e60 <fwp_pipe_in_offer>
    6016:	45 31 e4             	xor    %r12d,%r12d
    6019:	66 0f ef c0          	pxor   %xmm0,%xmm0
    601d:	66 0f 7f 44 24 50    	movdqa %xmm0,0x50(%rsp)
    6023:	48 c7 44 24 60 00 00 	movq   $0x0,0x60(%rsp)
    602a:	00 00 
    602c:	45 31 ff             	xor    %r15d,%r15d
    602f:	45 31 f6             	xor    %r14d,%r14d
    6032:	eb 35                	jmp    6069 <fwp_exec+0x479>
    6034:	48 89 ef             	mov    %rbp,%rdi
    6037:	4c 89 ee             	mov    %r13,%rsi
    603a:	e8 21 0f 00 00       	call   6f60 <fwp_pipe_in_switch>
    603f:	bb 10 00 00 00       	mov    $0x10,%ebx
    6044:	48 8d 35 c9 80 00 00 	lea    0x80c9(%rip),%rsi        # e114 <exec_in_fp0+0xad4>
    604b:	85 c0                	test   %eax,%eax
    604d:	0f 84 6b 01 00 00    	je     61be <fwp_exec+0x5ce>
    6053:	66 66 66 66 2e 0f 1f 	data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    605a:	84 00 00 00 00 00 
    6060:	83 fb 0f             	cmp    $0xf,%ebx
    6063:	0f 84 83 01 00 00    	je     61ec <fwp_exec+0x5fc>
    6069:	45 84 e4             	test   %r12b,%r12b
    606c:	0f 84 9e 00 00 00    	je     6110 <fwp_exec+0x520>
    6072:	48 8d 7c 24 50       	lea    0x50(%rsp),%rdi
    6077:	e8 44 15 00 00       	call   75c0 <fwp_read_text_line>
    607c:	4c 8b 7c 24 50       	mov    0x50(%rsp),%r15
    6081:	85 c0                	test   %eax,%eax
    6083:	0f 84 63 01 00 00    	je     61ec <fwp_exec+0x5fc>
    6089:	4d 85 ff             	test   %r15,%r15
    608c:	4c 89 ff             	mov    %r15,%rdi
    608f:	48 8d 05 f0 7f 00 00 	lea    0x7ff0(%rip),%rax        # e086 <exec_in_fp0+0xa46>
    6096:	48 0f 44 f8          	cmove  %rax,%rdi
    609a:	48 8b 74 24 58       	mov    0x58(%rsp),%rsi
    609f:	e8 6c 04 00 00       	call   6510 <fwp_str_lossy>
    60a4:	48 89 c5             	mov    %rax,%rbp
    60a7:	4c 8d 68 08          	lea    0x8(%rax),%r13
    60ab:	48 8b 30             	mov    (%rax),%rsi
    60ae:	4c 89 ef             	mov    %r13,%rdi
    60b1:	48 8d 54 24 20       	lea    0x20(%rsp),%rdx
    60b6:	e8 e5 07 00 00       	call   68a0 <fwp_parse_text>
    60bb:	85 c0                	test   %eax,%eax
    60bd:	0f 84 a1 01 00 00    	je     6264 <fwp_exec+0x674>
    60c3:	48 8b 44 24 20       	mov    0x20(%rsp),%rax
    60c8:	48 8b 7c 24 18       	mov    0x18(%rsp),%rdi
    60cd:	48 89 07             	mov    %rax,(%rdi)
    60d0:	48 8d 74 24 04       	lea    0x4(%rsp),%rsi
    60d5:	e8 16 0b 00 00       	call   6bf0 <fwp_exec_call>
    60da:	49 89 c5             	mov    %rax,%r13
    60dd:	48 8b 3d 64 ec 00 00 	mov    0xec64(%rip),%rdi        # 14d48 <fwp_prog_out>
    60e4:	e8 67 c2 ff ff       	call   2350 <fflush@plt>
    60e9:	83 7c 24 04 00       	cmpl   $0x0,0x4(%rsp)
    60ee:	0f 85 f2 00 00 00    	jne    61e6 <fwp_exec+0x5f6>
    60f4:	4c 89 ef             	mov    %r13,%rdi
    60f7:	e8 a4 0b 00 00       	call   6ca0 <fwp_emit_result>
    60fc:	e8 1f 0a 00 00       	call   6b20 <fwp_pipe_flush>
    6101:	31 db                	xor    %ebx,%ebx
    6103:	e9 58 ff ff ff       	jmp    6060 <fwp_exec+0x470>
    6108:	0f 1f 84 00 00 00 00 	nopl   0x0(%rax,%rax,1)
    610f:	00 
    6110:	be 01 00 00 00       	mov    $0x1,%esi
    6115:	48 8d 7c 24 08       	lea    0x8(%rsp),%rdi
    611a:	e8 91 0b 00 00       	call   6cb0 <fwp_read_exact>
    611f:	bb 0f 00 00 00       	mov    $0xf,%ebx
    6124:	85 c0                	test   %eax,%eax
    6126:	0f 84 34 ff ff ff    	je     6060 <fwp_exec+0x470>
    612c:	be 04 00 00 00       	mov    $0x4,%esi
    6131:	48 8d 7c 24 09       	lea    0x9(%rsp),%rdi
    6136:	e8 75 0b 00 00       	call   6cb0 <fwp_read_exact>
    613b:	48 8d 35 bd 7f 00 00 	lea    0x7fbd(%rip),%rsi        # e0ff <exec_in_fp0+0xabf>
    6142:	85 c0                	test   %eax,%eax
    6144:	74 78                	je     61be <fwp_exec+0x5ce>
    6146:	44 8b 6c 24 09       	mov    0x9(%rsp),%r13d
    614b:	49 8d 7d 01          	lea    0x1(%r13),%rdi
    614f:	e8 9c 05 00 00       	call   66f0 <fwp_alloc_leaf>
    6154:	48 89 c5             	mov    %rax,%rbp
    6157:	4d 85 ed             	test   %r13,%r13
    615a:	74 16                	je     6172 <fwp_exec+0x582>
    615c:	48 89 ef             	mov    %rbp,%rdi
    615f:	4c 89 ee             	mov    %r13,%rsi
    6162:	e8 49 0b 00 00       	call   6cb0 <fwp_read_exact>
    6167:	48 8d 35 91 7f 00 00 	lea    0x7f91(%rip),%rsi        # e0ff <exec_in_fp0+0xabf>
    616e:	85 c0                	test   %eax,%eax
    6170:	74 4c                	je     61be <fwp_exec+0x5ce>
    6172:	0f b6 44 24 08       	movzbl 0x8(%rsp),%eax
    6177:	85 c0                	test   %eax,%eax
    6179:	0f 84 e1 fe ff ff    	je     6060 <fwp_exec+0x470>
    617f:	83 f8 02             	cmp    $0x2,%eax
    6182:	0f 84 ac fe ff ff    	je     6034 <fwp_exec+0x444>
    6188:	48 89 6c 24 30       	mov    %rbp,0x30(%rsp)
    618d:	4c 89 6c 24 38       	mov    %r13,0x38(%rsp)
    6192:	48 c7 44 24 40 00 00 	movq   $0x0,0x40(%rsp)
    6199:	00 00 
    619b:	48 8d 7c 24 30       	lea    0x30(%rsp),%rdi
    61a0:	48 8d 35 29 eb 00 00 	lea    0xeb29(%rip),%rsi        # 14cd0 <d0>
    61a7:	48 8d 54 24 20       	lea    0x20(%rsp),%rdx
    61ac:	e8 cf 0f 00 00       	call   7180 <fwp_decode>
    61b1:	85 c0                	test   %eax,%eax
    61b3:	0f 85 0a ff ff ff    	jne    60c3 <fwp_exec+0x4d3>
    61b9:	e9 2c 01 00 00       	jmp    62ea <fwp_exec+0x6fa>
    61be:	48 8b 05 13 ce 00 00 	mov    0xce13(%rip),%rax        # 12fd8 <stderr@GLIBC_2.2.5>
    61c5:	48 8b 38             	mov    (%rax),%rdi
    61c8:	48 8d 15 b1 74 00 00 	lea    0x74b1(%rip),%rdx        # d680 <exec_in_fp0+0x40>
    61cf:	31 c0                	xor    %eax,%eax
    61d1:	e8 1a c1 ff ff       	call   22f0 <fprintf@plt>
    61d6:	41 be 03 00 00 00    	mov    $0x3,%r14d
    61dc:	bb 0f 00 00 00       	mov    $0xf,%ebx
    61e1:	e9 7a fe ff ff       	jmp    6060 <fwp_exec+0x470>
    61e6:	41 be 01 00 00 00    	mov    $0x1,%r14d
    61ec:	31 ff                	xor    %edi,%edi
    61ee:	e8 2d f5 ff ff       	call   5720 <fwp_mem_free>
    61f3:	4c 89 ff             	mov    %r15,%rdi
    61f6:	e8 55 be ff ff       	call   2050 <free@plt>
    61fb:	83 3d be eb 01 00 00 	cmpl   $0x0,0x1ebbe(%rip)        # 24dc0 <fwp_exec_binary_out>
    6202:	0f 84 fb fa ff ff    	je     5d03 <fwp_exec+0x113>
    6208:	48 8d 3d fc 73 00 00 	lea    0x73fc(%rip),%rdi        # d60b <fwp_exec.end>
    620f:	be 05 00 00 00       	mov    $0x5,%esi
    6214:	e8 57 08 00 00       	call   6a70 <fwp_pipe_write>
    6219:	e8 b2 14 00 00       	call   76d0 <fwp_pipe_out_end>
    621e:	e9 e0 fa ff ff       	jmp    5d03 <fwp_exec+0x113>
    6223:	85 c0                	test   %eax,%eax
    6225:	79 13                	jns    623a <fwp_exec+0x64a>
    6227:	48 8b 05 aa cd 00 00 	mov    0xcdaa(%rip),%rax        # 12fd8 <stderr@GLIBC_2.2.5>
    622e:	48 8b 38             	mov    (%rax),%rdi
    6231:	48 8d 35 2c 7f 00 00 	lea    0x7f2c(%rip),%rsi        # e164 <exec_in_fp0+0xb24>
    6238:	eb 11                	jmp    624b <fwp_exec+0x65b>
    623a:	48 8b 05 97 cd 00 00 	mov    0xcd97(%rip),%rax        # 12fd8 <stderr@GLIBC_2.2.5>
    6241:	48 8b 38             	mov    (%rax),%rdi
    6244:	48 8d 35 29 7f 00 00 	lea    0x7f29(%rip),%rsi        # e174 <exec_in_fp0+0xb34>
    624b:	48 8d 15 2e 74 00 00 	lea    0x742e(%rip),%rdx        # d680 <exec_in_fp0+0x40>
    6252:	31 c0                	xor    %eax,%eax
    6254:	e8 97 c0 ff ff       	call   22f0 <fprintf@plt>
    6259:	41 be 03 00 00 00    	mov    $0x3,%r14d
    625f:	e9 e0 fa ff ff       	jmp    5d44 <fwp_exec+0x154>
    6264:	48 8b 05 6d cd 00 00 	mov    0xcd6d(%rip),%rax        # 12fd8 <stderr@GLIBC_2.2.5>
    626b:	48 8b 38             	mov    (%rax),%rdi
    626e:	8b 4d 00             	mov    0x0(%rbp),%ecx
    6271:	48 8d 35 c7 7e 00 00 	lea    0x7ec7(%rip),%rsi        # e13f <exec_in_fp0+0xaff>
    6278:	48 8d 15 01 74 00 00 	lea    0x7401(%rip),%rdx        # d680 <exec_in_fp0+0x40>
    627f:	4c 8d 0d 06 82 00 00 	lea    0x8206(%rip),%r9        # e48c <exec_in_fp0+0xe4c>
    6286:	4d 89 e8             	mov    %r13,%r8
    6289:	31 c0                	xor    %eax,%eax
    628b:	e8 60 c0 ff ff       	call   22f0 <fprintf@plt>
    6290:	41 be 03 00 00 00    	mov    $0x3,%r14d
    6296:	e9 51 ff ff ff       	jmp    61ec <fwp_exec+0x5fc>
    629b:	48 8b 05 36 cd 00 00 	mov    0xcd36(%rip),%rax        # 12fd8 <stderr@GLIBC_2.2.5>
    62a2:	48 8b 38             	mov    (%rax),%rdi
    62a5:	48 8d 35 fc 7d 00 00 	lea    0x7dfc(%rip),%rsi        # e0a8 <exec_in_fp0+0xa68>
    62ac:	48 8d 15 cd 73 00 00 	lea    0x73cd(%rip),%rdx        # d680 <exec_in_fp0+0x40>
    62b3:	31 c0                	xor    %eax,%eax
    62b5:	e8 36 c0 ff ff       	call   22f0 <fprintf@plt>
    62ba:	eb 9d                	jmp    6259 <fwp_exec+0x669>
    62bc:	48 8b 05 15 cd 00 00 	mov    0xcd15(%rip),%rax        # 12fd8 <stderr@GLIBC_2.2.5>
    62c3:	48 8b 38             	mov    (%rax),%rdi
    62c6:	48 8d 35 00 7e 00 00 	lea    0x7e00(%rip),%rsi        # e0cd <exec_in_fp0+0xa8d>
    62cd:	48 8d 15 ac 73 00 00 	lea    0x73ac(%rip),%rdx        # d680 <exec_in_fp0+0x40>
    62d4:	48 8d 0d b1 81 00 00 	lea    0x81b1(%rip),%rcx        # e48c <exec_in_fp0+0xe4c>
    62db:	4d 89 f0             	mov    %r14,%r8
    62de:	31 c0                	xor    %eax,%eax
    62e0:	e8 0b c0 ff ff       	call   22f0 <fprintf@plt>
    62e5:	e9 6f ff ff ff       	jmp    6259 <fwp_exec+0x669>
    62ea:	48 8b 05 e7 cc 00 00 	mov    0xcce7(%rip),%rax        # 12fd8 <stderr@GLIBC_2.2.5>
    62f1:	48 8b 38             	mov    (%rax),%rdi
    62f4:	48 8d 35 2f 7e 00 00 	lea    0x7e2f(%rip),%rsi        # e12a <exec_in_fp0+0xaea>
    62fb:	48 8d 15 7e 73 00 00 	lea    0x737e(%rip),%rdx        # d680 <exec_in_fp0+0x40>
    6302:	31 c0                	xor    %eax,%eax
    6304:	e8 e7 bf ff ff       	call   22f0 <fprintf@plt>
    6309:	41 be 03 00 00 00    	mov    $0x3,%r14d
    630f:	e9 d8 fe ff ff       	jmp    61ec <fwp_exec+0x5fc>
    6314:	66 66 66 2e 0f 1f 84 	data16 data16 cs nopw 0x0(%rax,%rax,1)
    631b:	00 00 00 00 00 

0000000000006320 <fwp_segv>:
    6320:	53                   	push   %rbx
    6321:	48 8b 15 80 ea 00 00 	mov    0xea80(%rip),%rdx        # 14da8 <fwp_main_stack_top>
    6328:	48 85 d2             	test   %rdx,%rdx
    632b:	74 29                	je     6356 <fwp_segv+0x36>
    632d:	48 8b 46 10          	mov    0x10(%rsi),%rax
    6331:	48 2b 15 78 ea 00 00 	sub    0xea78(%rip),%rdx        # 14db0 <fwp_main_stack_size>
    6338:	48 8d b2 00 00 f0 ff 	lea    -0x100000(%rdx),%rsi
    633f:	48 81 c2 00 00 10 00 	add    $0x100000,%rdx
    6346:	89 fb                	mov    %edi,%ebx
    6348:	48 89 c7             	mov    %rax,%rdi
    634b:	e8 40 00 00 00       	call   6390 <fwp_near>
    6350:	89 df                	mov    %ebx,%edi
    6352:	85 c0                	test   %eax,%eax
    6354:	75 08                	jne    635e <fwp_segv+0x3e>
    6356:	31 f6                	xor    %esi,%esi
    6358:	5b                   	pop    %rbx
    6359:	e9 82 bf ff ff       	jmp    22e0 <signal@plt>
    635e:	e8 dd ca ff ff       	call   2e40 <fwp_flush>
    6363:	48 8d 35 86 72 00 00 	lea    0x7286(%rip),%rsi        # d5f0 <fwp_segv.msg>
    636a:	ba 1a 00 00 00       	mov    $0x1a,%edx
    636f:	bf 02 00 00 00       	mov    $0x2,%edi
    6374:	e8 c7 bd ff ff       	call   2140 <write@plt>
    6379:	bf 65 00 00 00       	mov    $0x65,%edi
    637e:	e8 1d bd ff ff       	call   20a0 <_exit@plt>
    6383:	66 66 66 66 2e 0f 1f 	data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    638a:	84 00 00 00 00 00 

0000000000006390 <fwp_near>:
    6390:	48 39 f7             	cmp    %rsi,%rdi
    6393:	0f 93 c0             	setae  %al
    6396:	48 39 d7             	cmp    %rdx,%rdi
    6399:	0f 92 c1             	setb   %cl
    639c:	20 c1                	and    %al,%cl
    639e:	0f b6 c1             	movzbl %cl,%eax
    63a1:	c3                   	ret
    63a2:	66 66 66 66 66 2e 0f 	data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    63a9:	1f 84 00 00 00 00 00 

00000000000063b0 <fwp_generated>:
    63b0:	55                   	push   %rbp
    63b1:	41 57                	push   %r15
    63b3:	41 56                	push   %r14
    63b5:	53                   	push   %rbx
    63b6:	50                   	push   %rax
    63b7:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
    63bc:	85 ff                	test   %edi,%edi
    63be:	0f 8e 14 01 00 00    	jle    64d8 <fwp_generated+0x128>
    63c4:	89 fd                	mov    %edi,%ebp
    63c6:	49 89 f7             	mov    %rsi,%r15
    63c9:	4c 8b 36             	mov    (%rsi),%r14
    63cc:	48 8d 35 b7 7d 00 00 	lea    0x7db7(%rip),%rsi        # e18a <exec_in_fp0+0xb4a>
    63d3:	4c 89 f7             	mov    %r14,%rdi
    63d6:	e8 f5 be ff ff       	call   22d0 <strcmp@plt>
    63db:	85 c0                	test   %eax,%eax
    63dd:	74 34                	je     6413 <fwp_generated+0x63>
    63df:	48 8d 35 aa 7d 00 00 	lea    0x7daa(%rip),%rsi        # e190 <exec_in_fp0+0xb50>
    63e6:	ba 0d 00 00 00       	mov    $0xd,%edx
    63eb:	4c 89 f7             	mov    %r14,%rdi
    63ee:	e8 9d bc ff ff       	call   2090 <strncmp@plt>
    63f3:	85 c0                	test   %eax,%eax
    63f5:	0f 85 dd 00 00 00    	jne    64d8 <fwp_generated+0x128>
    63fb:	41 0f b6 46 0d       	movzbl 0xd(%r14),%eax
    6400:	85 c0                	test   %eax,%eax
    6402:	74 2c                	je     6430 <fwp_generated+0x80>
    6404:	83 f8 3d             	cmp    $0x3d,%eax
    6407:	0f 85 cb 00 00 00    	jne    64d8 <fwp_generated+0x128>
    640d:	49 83 c6 0e          	add    $0xe,%r14
    6411:	eb 2a                	jmp    643d <fwp_generated+0x8d>
    6413:	48 8b 3d 7e e9 00 00 	mov    0xe97e(%rip),%rdi        # 14d98 <fwp_cli_man>
    641a:	48 8b 05 8f cb 00 00 	mov    0xcb8f(%rip),%rax        # 12fb0 <stdout@GLIBC_2.2.5>
    6421:	48 8b 30             	mov    (%rax),%rsi
    6424:	e8 c7 bd ff ff       	call   21f0 <fputs@plt>
    6429:	31 db                	xor    %ebx,%ebx
    642b:	e9 a8 00 00 00       	jmp    64d8 <fwp_generated+0x128>
    6430:	83 fd 01             	cmp    $0x1,%ebp
    6433:	0f 84 ac 00 00 00    	je     64e5 <fwp_generated+0x135>
    6439:	4d 8b 77 08          	mov    0x8(%r15),%r14
    643d:	48 8d 35 98 7d 00 00 	lea    0x7d98(%rip),%rsi        # e1dc <exec_in_fp0+0xb9c>
    6444:	4c 89 f7             	mov    %r14,%rdi
    6447:	e8 84 be ff ff       	call   22d0 <strcmp@plt>
    644c:	31 db                	xor    %ebx,%ebx
    644e:	85 c0                	test   %eax,%eax
    6450:	74 63                	je     64b5 <fwp_generated+0x105>
    6452:	48 8d 35 88 7d 00 00 	lea    0x7d88(%rip),%rsi        # e1e1 <exec_in_fp0+0xba1>
    6459:	4c 89 f7             	mov    %r14,%rdi
    645c:	e8 6f be ff ff       	call   22d0 <strcmp@plt>
    6461:	85 c0                	test   %eax,%eax
    6463:	74 54                	je     64b9 <fwp_generated+0x109>
    6465:	48 8d 35 79 7d 00 00 	lea    0x7d79(%rip),%rsi        # e1e5 <exec_in_fp0+0xba5>
    646c:	4c 89 f7             	mov    %r14,%rdi
    646f:	e8 5c be ff ff       	call   22d0 <strcmp@plt>
    6474:	b9 02 00 00 00       	mov    $0x2,%ecx
    6479:	85 c0                	test   %eax,%eax
    647b:	74 41                	je     64be <fwp_generated+0x10e>
    647d:	4c 89 f7             	mov    %r14,%rdi
    6480:	e8 eb bc ff ff       	call   2170 <strlen@plt>
    6485:	4c 89 f7             	mov    %r14,%rdi
    6488:	48 89 c6             	mov    %rax,%rsi
    648b:	e8 80 00 00 00       	call   6510 <fwp_str_lossy>
    6490:	48 8b 0d 41 cb 00 00 	mov    0xcb41(%rip),%rcx        # 12fd8 <stderr@GLIBC_2.2.5>
    6497:	48 8b 39             	mov    (%rcx),%rdi
    649a:	48 8d 48 08          	lea    0x8(%rax),%rcx
    649e:	48 8d 35 45 7d 00 00 	lea    0x7d45(%rip),%rsi        # e1ea <exec_in_fp0+0xbaa>
    64a5:	48 8d 15 d4 71 00 00 	lea    0x71d4(%rip),%rdx        # d680 <exec_in_fp0+0x40>
    64ac:	31 c0                	xor    %eax,%eax
    64ae:	e8 3d be ff ff       	call   22f0 <fprintf@plt>
    64b3:	eb 4f                	jmp    6504 <fwp_generated+0x154>
    64b5:	31 c9                	xor    %ecx,%ecx
    64b7:	eb 05                	jmp    64be <fwp_generated+0x10e>
    64b9:	b9 01 00 00 00       	mov    $0x1,%ecx
    64be:	48 8d 05 bb e8 00 00 	lea    0xe8bb(%rip),%rax        # 14d80 <fwp_cli_scripts>
    64c5:	48 8b 3c c8          	mov    (%rax,%rcx,8),%rdi
    64c9:	48 8b 05 e0 ca 00 00 	mov    0xcae0(%rip),%rax        # 12fb0 <stdout@GLIBC_2.2.5>
    64d0:	48 8b 30             	mov    (%rax),%rsi
    64d3:	e8 18 bd ff ff       	call   21f0 <fputs@plt>
    64d8:	89 d8                	mov    %ebx,%eax
    64da:	48 83 c4 08          	add    $0x8,%rsp
    64de:	5b                   	pop    %rbx
    64df:	41 5e                	pop    %r14
    64e1:	41 5f                	pop    %r15
    64e3:	5d                   	pop    %rbp
    64e4:	c3                   	ret
    64e5:	48 8b 05 ec ca 00 00 	mov    0xcaec(%rip),%rax        # 12fd8 <stderr@GLIBC_2.2.5>
    64ec:	48 8b 38             	mov    (%rax),%rdi
    64ef:	48 8d 35 a8 7c 00 00 	lea    0x7ca8(%rip),%rsi        # e19e <exec_in_fp0+0xb5e>
    64f6:	48 8d 15 83 71 00 00 	lea    0x7183(%rip),%rdx        # d680 <exec_in_fp0+0x40>
    64fd:	31 c0                	xor    %eax,%eax
    64ff:	e8 ec bd ff ff       	call   22f0 <fprintf@plt>
    6504:	bb 02 00 00 00       	mov    $0x2,%ebx
    6509:	eb cd                	jmp    64d8 <fwp_generated+0x128>
    650b:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)

0000000000006510 <fwp_str_lossy>:
    6510:	55                   	push   %rbp
    6511:	41 57                	push   %r15
    6513:	41 56                	push   %r14
    6515:	41 55                	push   %r13
    6517:	41 54                	push   %r12
    6519:	53                   	push   %rbx
    651a:	48 83 ec 18          	sub    $0x18,%rsp
    651e:	48 89 f3             	mov    %rsi,%rbx
    6521:	49 89 fe             	mov    %rdi,%r14
    6524:	e8 27 12 00 00       	call   7750 <fwp_valid_utf8>
    6529:	85 c0                	test   %eax,%eax
    652b:	74 19                	je     6546 <fwp_str_lossy+0x36>
    652d:	4c 89 f7             	mov    %r14,%rdi
    6530:	48 89 de             	mov    %rbx,%rsi
    6533:	48 83 c4 18          	add    $0x18,%rsp
    6537:	5b                   	pop    %rbx
    6538:	41 5c                	pop    %r12
    653a:	41 5d                	pop    %r13
    653c:	41 5e                	pop    %r14
    653e:	41 5f                	pop    %r15
    6540:	5d                   	pop    %rbp
    6541:	e9 6a 13 00 00       	jmp    78b0 <fwp_str_new>
    6546:	0f 57 c0             	xorps  %xmm0,%xmm0
    6549:	0f 29 04 24          	movaps %xmm0,(%rsp)
    654d:	48 c7 44 24 10 00 00 	movq   $0x0,0x10(%rsp)
    6554:	00 00 
    6556:	48 85 db             	test   %rbx,%rbx
    6559:	0f 84 72 01 00 00    	je     66d1 <fwp_str_lossy+0x1c1>
    655f:	45 31 ed             	xor    %r13d,%r13d
    6562:	49 89 e7             	mov    %rsp,%r15
    6565:	4c 8d 25 aa 7c 00 00 	lea    0x7caa(%rip),%r12        # e216 <exec_in_fp0+0xbd6>
    656c:	eb 19                	jmp    6587 <fwp_str_lossy+0x77>
    656e:	66 90                	xchg   %ax,%ax
    6570:	4c 89 ff             	mov    %r15,%rdi
    6573:	4c 89 e6             	mov    %r12,%rsi
    6576:	e8 95 13 00 00       	call   7910 <buf_puts>
    657b:	49 89 ed             	mov    %rbp,%r13
    657e:	48 39 dd             	cmp    %rbx,%rbp
    6581:	0f 83 4a 01 00 00    	jae    66d1 <fwp_str_lossy+0x1c1>
    6587:	43 0f b6 04 2e       	movzbl (%r14,%r13,1),%eax
    658c:	84 c0                	test   %al,%al
    658e:	78 20                	js     65b0 <fwp_str_lossy+0xa0>
    6590:	0f be f0             	movsbl %al,%esi
    6593:	4c 89 ff             	mov    %r15,%rdi
    6596:	e8 55 13 00 00       	call   78f0 <buf_putc>
    659b:	49 ff c5             	inc    %r13
    659e:	4c 89 ed             	mov    %r13,%rbp
    65a1:	eb d8                	jmp    657b <fwp_str_lossy+0x6b>
    65a3:	66 66 66 66 2e 0f 1f 	data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    65aa:	84 00 00 00 00 00 
    65b0:	8d 48 20             	lea    0x20(%rax),%ecx
    65b3:	80 f9 e1             	cmp    $0xe1,%cl
    65b6:	77 34                	ja     65ec <fwp_str_lossy+0xdc>
    65b8:	89 c2                	mov    %eax,%edx
    65ba:	80 e2 f0             	and    $0xf0,%dl
    65bd:	80 fa e0             	cmp    $0xe0,%dl
    65c0:	0f 85 cb 00 00 00    	jne    6691 <fwp_str_lossy+0x181>
    65c6:	3c e0                	cmp    $0xe0,%al
    65c8:	40 0f 94 c6          	sete   %sil
    65cc:	40 c0 e6 05          	shl    $0x5,%sil
    65d0:	40 80 ce 80          	or     $0x80,%sil
    65d4:	31 ff                	xor    %edi,%edi
    65d6:	3c ed                	cmp    $0xed,%al
    65d8:	40 0f 95 c7          	setne  %dil
    65dc:	c1 e7 05             	shl    $0x5,%edi
    65df:	81 cf 9f 00 00 00    	or     $0x9f,%edi
    65e5:	b8 02 00 00 00       	mov    $0x2,%eax
    65ea:	eb 0d                	jmp    65f9 <fwp_str_lossy+0xe9>
    65ec:	bf bf 00 00 00       	mov    $0xbf,%edi
    65f1:	40 b6 80             	mov    $0x80,%sil
    65f4:	b8 01 00 00 00       	mov    $0x1,%eax
    65f9:	31 d2                	xor    %edx,%edx
    65fb:	49 8d 6d 01          	lea    0x1(%r13),%rbp
    65ff:	48 39 dd             	cmp    %rbx,%rbp
    6602:	0f 83 68 ff ff ff    	jae    6570 <fwp_str_lossy+0x60>
    6608:	45 0f b6 04 2e       	movzbl (%r14,%rbp,1),%r8d
    660d:	41 38 f0             	cmp    %sil,%r8b
    6610:	0f 82 5a ff ff ff    	jb     6570 <fwp_str_lossy+0x60>
    6616:	44 39 c7             	cmp    %r8d,%edi
    6619:	0f 82 51 ff ff ff    	jb     6570 <fwp_str_lossy+0x60>
    661f:	49 8d 6d 02          	lea    0x2(%r13),%rbp
    6623:	be 01 00 00 00       	mov    $0x1,%esi
    6628:	80 f9 e1             	cmp    $0xe1,%cl
    662b:	77 45                	ja     6672 <fwp_str_lossy+0x162>
    662d:	48 39 dd             	cmp    %rbx,%rbp
    6630:	73 40                	jae    6672 <fwp_str_lossy+0x162>
    6632:	41 0f b6 0c 2e       	movzbl (%r14,%rbp,1),%ecx
    6637:	80 e1 c0             	and    $0xc0,%cl
    663a:	80 f9 80             	cmp    $0x80,%cl
    663d:	75 33                	jne    6672 <fwp_str_lossy+0x162>
    663f:	49 8d 6d 03          	lea    0x3(%r13),%rbp
    6643:	48 39 dd             	cmp    %rbx,%rbp
    6646:	0f 93 c1             	setae  %cl
    6649:	80 f2 01             	xor    $0x1,%dl
    664c:	be 02 00 00 00       	mov    $0x2,%esi
    6651:	08 ca                	or     %cl,%dl
    6653:	75 1d                	jne    6672 <fwp_str_lossy+0x162>
    6655:	43 0f b6 4c 2e 03    	movzbl 0x3(%r14,%r13,1),%ecx
    665b:	80 e1 c0             	and    $0xc0,%cl
    665e:	31 f6                	xor    %esi,%esi
    6660:	80 f9 80             	cmp    $0x80,%cl
    6663:	0f 94 c1             	sete   %cl
    6666:	75 04                	jne    666c <fwp_str_lossy+0x15c>
    6668:	49 8d 6d 04          	lea    0x4(%r13),%rbp
    666c:	40 88 ce             	mov    %cl,%sil
    666f:	83 ce 02             	or     $0x2,%esi
    6672:	39 c6                	cmp    %eax,%esi
    6674:	0f 85 f6 fe ff ff    	jne    6570 <fwp_str_lossy+0x60>
    667a:	4b 8d 34 2e          	lea    (%r14,%r13,1),%rsi
    667e:	48 89 ea             	mov    %rbp,%rdx
    6681:	4c 29 ea             	sub    %r13,%rdx
    6684:	4c 89 ff             	mov    %r15,%rdi
    6687:	e8 b4 12 00 00       	call   7940 <buf_put>
    668c:	e9 ea fe ff ff       	jmp    657b <fwp_str_lossy+0x6b>
    6691:	8d 50 10             	lea    0x10(%rax),%edx
    6694:	80 fa 04             	cmp    $0x4,%dl
    6697:	77 28                	ja     66c1 <fwp_str_lossy+0x1b1>
    6699:	3c f0                	cmp    $0xf0,%al
    669b:	40 0f 94 c6          	sete   %sil
    669f:	bf 8f 00 00 00       	mov    $0x8f,%edi
    66a4:	3c f4                	cmp    $0xf4,%al
    66a6:	74 05                	je     66ad <fwp_str_lossy+0x19d>
    66a8:	bf bf 00 00 00       	mov    $0xbf,%edi
    66ad:	40 c0 e6 04          	shl    $0x4,%sil
    66b1:	40 80 ce 80          	or     $0x80,%sil
    66b5:	b8 03 00 00 00       	mov    $0x3,%eax
    66ba:	b2 01                	mov    $0x1,%dl
    66bc:	e9 3a ff ff ff       	jmp    65fb <fwp_str_lossy+0xeb>
    66c1:	4c 89 ff             	mov    %r15,%rdi
    66c4:	4c 89 e6             	mov    %r12,%rsi
    66c7:	e8 44 12 00 00       	call   7910 <buf_puts>
    66cc:	e9 ca fe ff ff       	jmp    659b <fwp_str_lossy+0x8b>
    66d1:	48 89 e7             	mov    %rsp,%rdi
    66d4:	e8 a7 12 00 00       	call   7980 <buf_to_str>
    66d9:	48 83 c4 18          	add    $0x18,%rsp
    66dd:	5b                   	pop    %rbx
    66de:	41 5c                	pop    %r12
    66e0:	41 5d                	pop    %r13
    66e2:	41 5e                	pop    %r14
    66e4:	41 5f                	pop    %r15
    66e6:	5d                   	pop    %rbp
    66e7:	c3                   	ret
    66e8:	0f 1f 84 00 00 00 00 	nopl   0x0(%rax,%rax,1)
    66ef:	00 

00000000000066f0 <fwp_alloc_leaf>:
    66f0:	be 01 00 00 00       	mov    $0x1,%esi
    66f5:	e9 c6 c9 ff ff       	jmp    30c0 <fwp_gc_alloc>
    66fa:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)

0000000000006700 <fwp_cli_parse>:
    6700:	c7 01 00 00 00 00    	movl   $0x0,(%rcx)
    6706:	85 ff                	test   %edi,%edi
    6708:	0f 8e 6d 01 00 00    	jle    687b <fwp_cli_parse+0x17b>
    670e:	55                   	push   %rbp
    670f:	41 57                	push   %r15
    6711:	41 56                	push   %r14
    6713:	41 55                	push   %r13
    6715:	41 54                	push   %r12
    6717:	53                   	push   %rbx
    6718:	48 83 ec 28          	sub    $0x28,%rsp
    671c:	41 89 f8             	mov    %edi,%r8d
    671f:	4d 89 c1             	mov    %r8,%r9
    6722:	49 f7 d9             	neg    %r9
    6725:	40 b5 01             	mov    $0x1,%bpl
    6728:	45 31 ff             	xor    %r15d,%r15d
    672b:	41 be 01 00 00 00    	mov    $0x1,%r14d
    6731:	31 db                	xor    %ebx,%ebx
    6733:	48 89 54 24 20       	mov    %rdx,0x20(%rsp)
    6738:	48 89 74 24 18       	mov    %rsi,0x18(%rsp)
    673d:	4c 89 44 24 10       	mov    %r8,0x10(%rsp)
    6742:	4c 89 4c 24 08       	mov    %r9,0x8(%rsp)
    6747:	48 89 0c 24          	mov    %rcx,(%rsp)
    674b:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)
    6750:	4e 8b 6c f6 f8       	mov    -0x8(%rsi,%r14,8),%r13
    6755:	85 db                	test   %ebx,%ebx
    6757:	75 37                	jne    6790 <fwp_cli_parse+0x90>
    6759:	4d 8b 65 00          	mov    0x0(%r13),%r12
    675d:	49 83 fc 02          	cmp    $0x2,%r12
    6761:	72 2d                	jb     6790 <fwp_cli_parse+0x90>
    6763:	49 8d 7d 08          	lea    0x8(%r13),%rdi
    6767:	80 3f 2d             	cmpb   $0x2d,(%rdi)
    676a:	75 24                	jne    6790 <fwp_cli_parse+0x90>
    676c:	e8 ff 12 00 00       	call   7a70 <fwp_is_number_arg>
    6771:	4c 8b 4c 24 08       	mov    0x8(%rsp),%r9
    6776:	4c 8b 44 24 10       	mov    0x10(%rsp),%r8
    677b:	48 8b 74 24 18       	mov    0x18(%rsp),%rsi
    6780:	48 8b 54 24 20       	mov    0x20(%rsp),%rdx
    6785:	48 8b 0c 24          	mov    (%rsp),%rcx
    6789:	85 c0                	test   %eax,%eax
    678b:	74 2f                	je     67bc <fwp_cli_parse+0xbc>
    678d:	0f 1f 00             	nopl   (%rax)
    6790:	49 63 c7             	movslq %r15d,%rax
    6793:	41 8d 7f 01          	lea    0x1(%r15),%edi
    6797:	89 39                	mov    %edi,(%rcx)
    6799:	4c 89 2c c2          	mov    %r13,(%rdx,%rax,8)
    679d:	41 89 ff             	mov    %edi,%r15d
    67a0:	4d 39 c6             	cmp    %r8,%r14
    67a3:	40 0f 92 c5          	setb   %bpl
    67a7:	4b 8d 04 31          	lea    (%r9,%r14,1),%rax
    67ab:	48 ff c0             	inc    %rax
    67ae:	49 ff c6             	inc    %r14
    67b1:	48 83 f8 01          	cmp    $0x1,%rax
    67b5:	75 99                	jne    6750 <fwp_cli_parse+0x50>
    67b7:	e9 a9 00 00 00       	jmp    6865 <fwp_cli_parse+0x165>
    67bc:	41 0f b6 45 09       	movzbl 0x9(%r13),%eax
    67c1:	49 83 fc 02          	cmp    $0x2,%r12
    67c5:	75 1a                	jne    67e1 <fwp_cli_parse+0xe1>
    67c7:	bb 01 00 00 00       	mov    $0x1,%ebx
    67cc:	3c 2d                	cmp    $0x2d,%al
    67ce:	74 d0                	je     67a0 <fwp_cli_parse+0xa0>
    67d0:	31 db                	xor    %ebx,%ebx
    67d2:	49 83 fc 02          	cmp    $0x2,%r12
    67d6:	75 b8                	jne    6790 <fwp_cli_parse+0x90>
    67d8:	3c 68                	cmp    $0x68,%al
    67da:	75 b4                	jne    6790 <fwp_cli_parse+0x90>
    67dc:	e9 84 00 00 00       	jmp    6865 <fwp_cli_parse+0x165>
    67e1:	31 db                	xor    %ebx,%ebx
    67e3:	3c 2d                	cmp    $0x2d,%al
    67e5:	75 a9                	jne    6790 <fwp_cli_parse+0x90>
    67e7:	49 8d 5d 0a          	lea    0xa(%r13),%rbx
    67eb:	49 83 c4 fe          	add    $0xfffffffffffffffe,%r12
    67ef:	48 89 df             	mov    %rbx,%rdi
    67f2:	be 3d 00 00 00       	mov    $0x3d,%esi
    67f7:	4c 89 e2             	mov    %r12,%rdx
    67fa:	e8 61 ba ff ff       	call   2260 <memchr@plt>
    67ff:	48 89 c1             	mov    %rax,%rcx
    6802:	48 29 d9             	sub    %rbx,%rcx
    6805:	48 85 c0             	test   %rax,%rax
    6808:	49 0f 44 cc          	cmove  %r12,%rcx
    680c:	75 38                	jne    6846 <fwp_cli_parse+0x146>
    680e:	48 83 f9 04          	cmp    $0x4,%rcx
    6812:	48 8b 0c 24          	mov    (%rsp),%rcx
    6816:	48 8b 54 24 20       	mov    0x20(%rsp),%rdx
    681b:	48 8b 74 24 18       	mov    0x18(%rsp),%rsi
    6820:	4c 8b 44 24 10       	mov    0x10(%rsp),%r8
    6825:	4c 8b 4c 24 08       	mov    0x8(%rsp),%r9
    682a:	75 13                	jne    683f <fwp_cli_parse+0x13f>
    682c:	81 3b 68 65 6c 70    	cmpl   $0x706c6568,(%rbx)
    6832:	bb 00 00 00 00       	mov    $0x0,%ebx
    6837:	0f 85 53 ff ff ff    	jne    6790 <fwp_cli_parse+0x90>
    683d:	eb 26                	jmp    6865 <fwp_cli_parse+0x165>
    683f:	31 db                	xor    %ebx,%ebx
    6841:	e9 4a ff ff ff       	jmp    6790 <fwp_cli_parse+0x90>
    6846:	48 8b 0c 24          	mov    (%rsp),%rcx
    684a:	48 8b 54 24 20       	mov    0x20(%rsp),%rdx
    684f:	48 8b 74 24 18       	mov    0x18(%rsp),%rsi
    6854:	4c 8b 44 24 10       	mov    0x10(%rsp),%r8
    6859:	4c 8b 4c 24 08       	mov    0x8(%rsp),%r9
    685e:	31 db                	xor    %ebx,%ebx
    6860:	e9 2b ff ff ff       	jmp    6790 <fwp_cli_parse+0x90>
    6865:	40 0f b6 c5          	movzbl %bpl,%eax
    6869:	83 e0 01             	and    $0x1,%eax
    686c:	48 83 c4 28          	add    $0x28,%rsp
    6870:	5b                   	pop    %rbx
    6871:	41 5c                	pop    %r12
    6873:	41 5d                	pop    %r13
    6875:	41 5e                	pop    %r14
    6877:	41 5f                	pop    %r15
    6879:	5d                   	pop    %rbp
    687a:	c3                   	ret
    687b:	31 c0                	xor    %eax,%eax
    687d:	c3                   	ret
    687e:	66 90                	xchg   %ax,%ax

0000000000006880 <fwp_usage_error>:
    6880:	48 8b 05 51 c7 00 00 	mov    0xc751(%rip),%rax        # 12fd8 <stderr@GLIBC_2.2.5>
    6887:	48 8b 38             	mov    (%rax),%rdi
    688a:	48 8d 35 22 7a 00 00 	lea    0x7a22(%rip),%rsi        # e2b3 <exec_in_fp0+0xc73>
    6891:	48 8d 15 2e 7b 00 00 	lea    0x7b2e(%rip),%rdx        # e3c6 <exec_in_fp0+0xd86>
    6898:	31 c0                	xor    %eax,%eax
    689a:	e9 51 ba ff ff       	jmp    22f0 <fprintf@plt>
    689f:	90                   	nop

00000000000068a0 <fwp_parse_text>:
    68a0:	48 83 ec 18          	sub    $0x18,%rsp
    68a4:	48 89 d1             	mov    %rdx,%rcx
    68a7:	48 89 3c 24          	mov    %rdi,(%rsp)
    68ab:	48 89 74 24 08       	mov    %rsi,0x8(%rsp)
    68b0:	48 c7 44 24 10 00 00 	movq   $0x0,0x10(%rsp)
    68b7:	00 00 
    68b9:	48 8d 35 10 e4 00 00 	lea    0xe410(%rip),%rsi        # 14cd0 <d0>
    68c0:	48 89 e7             	mov    %rsp,%rdi
    68c3:	ba 01 00 00 00       	mov    $0x1,%edx
    68c8:	e8 a3 16 00 00       	call   7f70 <tp_value>
    68cd:	85 c0                	test   %eax,%eax
    68cf:	74 1c                	je     68ed <fwp_parse_text+0x4d>
    68d1:	48 89 e7             	mov    %rsp,%rdi
    68d4:	e8 c7 1f 00 00       	call   88a0 <tp_ws>
    68d9:	48 8b 4c 24 10       	mov    0x10(%rsp),%rcx
    68de:	31 c0                	xor    %eax,%eax
    68e0:	48 3b 4c 24 08       	cmp    0x8(%rsp),%rcx
    68e5:	0f 94 c0             	sete   %al
    68e8:	48 83 c4 18          	add    $0x18,%rsp
    68ec:	c3                   	ret
    68ed:	31 c0                	xor    %eax,%eax
    68ef:	48 83 c4 18          	add    $0x18,%rsp
    68f3:	c3                   	ret
    68f4:	66 66 66 2e 0f 1f 84 	data16 data16 cs nopw 0x0(%rax,%rax,1)
    68fb:	00 00 00 00 00 

0000000000006900 <fwp_parse_arg>:
    6900:	53                   	push   %rbx
    6901:	48 83 ec 10          	sub    $0x10,%rsp
    6905:	89 fb                	mov    %edi,%ebx
    6907:	48 8b 06             	mov    (%rsi),%rax
    690a:	48 8d 7e 08          	lea    0x8(%rsi),%rdi
    690e:	48 8d 4c 24 08       	lea    0x8(%rsp),%rcx
    6913:	48 89 c6             	mov    %rax,%rsi
    6916:	e8 85 12 00 00       	call   7ba0 <fwp_cli_value>
    691b:	89 c1                	mov    %eax,%ecx
    691d:	b8 01 00 00 00       	mov    $0x1,%eax
    6922:	85 c9                	test   %ecx,%ecx
    6924:	74 06                	je     692c <fwp_parse_arg+0x2c>
    6926:	48 83 c4 10          	add    $0x10,%rsp
    692a:	5b                   	pop    %rbx
    692b:	c3                   	ret
    692c:	48 8b 05 a5 c6 00 00 	mov    0xc6a5(%rip),%rax        # 12fd8 <stderr@GLIBC_2.2.5>
    6933:	48 8b 38             	mov    (%rax),%rdi
    6936:	ff c3                	inc    %ebx
    6938:	4c 8b 44 24 08       	mov    0x8(%rsp),%r8
    693d:	49 83 c0 08          	add    $0x8,%r8
    6941:	48 8d 35 5a 79 00 00 	lea    0x795a(%rip),%rsi        # e2a2 <exec_in_fp0+0xc62>
    6948:	48 8d 15 31 6d 00 00 	lea    0x6d31(%rip),%rdx        # d680 <exec_in_fp0+0x40>
    694f:	89 d9                	mov    %ebx,%ecx
    6951:	31 c0                	xor    %eax,%eax
    6953:	e8 98 b9 ff ff       	call   22f0 <fprintf@plt>
    6958:	31 c0                	xor    %eax,%eax
    695a:	eb ca                	jmp    6926 <fwp_parse_arg+0x26>
    695c:	0f 1f 40 00          	nopl   0x0(%rax)

0000000000006960 <fwp_bind_positional>:
    6960:	50                   	push   %rax
    6961:	31 c0                	xor    %eax,%eax
    6963:	85 f6                	test   %esi,%esi
    6965:	0f 9e c0             	setle  %al
    6968:	89 01                	mov    %eax,(%rcx)
    696a:	83 fe 01             	cmp    $0x1,%esi
    696d:	76 0c                	jbe    697b <fwp_bind_positional+0x1b>
    696f:	e8 0c ff ff ff       	call   6880 <fwp_usage_error>
    6974:	b8 02 00 00 00       	mov    $0x2,%eax
    6979:	59                   	pop    %rcx
    697a:	c3                   	ret
    697b:	31 c0                	xor    %eax,%eax
    697d:	83 fe 01             	cmp    $0x1,%esi
    6980:	75 f7                	jne    6979 <fwp_bind_positional+0x19>
    6982:	48 8b 37             	mov    (%rdi),%rsi
    6985:	31 ff                	xor    %edi,%edi
    6987:	e8 74 ff ff ff       	call   6900 <fwp_parse_arg>
    698c:	89 c1                	mov    %eax,%ecx
    698e:	31 c0                	xor    %eax,%eax
    6990:	85 c9                	test   %ecx,%ecx
    6992:	0f 94 c0             	sete   %al
    6995:	01 c0                	add    %eax,%eax
    6997:	59                   	pop    %rcx
    6998:	c3                   	ret
    6999:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)

00000000000069a0 <fwp_pipe_out_start>:
    69a0:	41 56                	push   %r14
    69a2:	53                   	push   %rbx
    69a3:	48 81 ec 08 01 00 00 	sub    $0x108,%rsp
    69aa:	48 8d 74 24 08       	lea    0x8(%rsp),%rsi
    69af:	bf 01 00 00 00       	mov    $0x1,%edi
    69b4:	e8 27 bb ff ff       	call   24e0 <fstat@plt>
    69b9:	85 c0                	test   %eax,%eax
    69bb:	0f 85 82 00 00 00    	jne    6a43 <fwp_pipe_out_start+0xa3>
    69c1:	b8 00 f0 00 00       	mov    $0xf000,%eax
    69c6:	23 44 24 20          	and    0x20(%rsp),%eax
    69ca:	3d 00 10 00 00       	cmp    $0x1000,%eax
    69cf:	75 72                	jne    6a43 <fwp_pipe_out_start+0xa3>
    69d1:	bf 01 00 00 00       	mov    $0x1,%edi
    69d6:	be 07 04 00 00       	mov    $0x407,%esi
    69db:	ba 00 00 10 00       	mov    $0x100000,%edx
    69e0:	31 c0                	xor    %eax,%eax
    69e2:	e8 39 b7 ff ff       	call   2120 <fcntl@plt>
    69e7:	e8 24 36 00 00       	call   a010 <fwp_transport_off>
    69ec:	85 c0                	test   %eax,%eax
    69ee:	75 53                	jne    6a43 <fwp_pipe_out_start+0xa3>
    69f0:	bf 01 00 00 00       	mov    $0x1,%edi
    69f5:	be 01 08 08 00       	mov    $0x80801,%esi
    69fa:	31 d2                	xor    %edx,%edx
    69fc:	e8 0f bb ff ff       	call   2510 <socket@plt>
    6a01:	85 c0                	test   %eax,%eax
    6a03:	78 3e                	js     6a43 <fwp_pipe_out_start+0xa3>
    6a05:	89 c3                	mov    %eax,%ebx
    6a07:	4c 8d b4 24 9a 00 00 	lea    0x9a(%rsp),%r14
    6a0e:	00 
    6a0f:	48 8d 74 24 08       	lea    0x8(%rsp),%rsi
    6a14:	4c 89 f7             	mov    %r14,%rdi
    6a17:	e8 24 36 00 00       	call   a040 <fwp_pipe_addr>
    6a1c:	89 df                	mov    %ebx,%edi
    6a1e:	4c 89 f6             	mov    %r14,%rsi
    6a21:	89 c2                	mov    %eax,%edx
    6a23:	e8 a8 b9 ff ff       	call   23d0 <bind@plt>
    6a28:	85 c0                	test   %eax,%eax
    6a2a:	75 10                	jne    6a3c <fwp_pipe_out_start+0x9c>
    6a2c:	89 df                	mov    %ebx,%edi
    6a2e:	be 01 00 00 00       	mov    $0x1,%esi
    6a33:	e8 28 b9 ff ff       	call   2360 <listen@plt>
    6a38:	85 c0                	test   %eax,%eax
    6a3a:	74 12                	je     6a4e <fwp_pipe_out_start+0xae>
    6a3c:	89 df                	mov    %ebx,%edi
    6a3e:	e8 ed b7 ff ff       	call   2230 <close@plt>
    6a43:	48 81 c4 08 01 00 00 	add    $0x108,%rsp
    6a4a:	5b                   	pop    %rbx
    6a4b:	41 5e                	pop    %r14
    6a4d:	c3                   	ret
    6a4e:	89 1d 68 e2 00 00    	mov    %ebx,0xe268(%rip)        # 14cbc <fwp_po_listen>
    6a54:	e8 37 36 00 00       	call   a090 <fwp_now_ns>
    6a59:	48 b9 00 f2 05 2a 01 	movabs $0x12a05f200,%rcx
    6a60:	00 00 00 
    6a63:	48 01 c1             	add    %rax,%rcx
    6a66:	48 89 0d 6b e3 01 00 	mov    %rcx,0x1e36b(%rip)        # 24dd8 <fwp_po_give_up>
    6a6d:	eb d4                	jmp    6a43 <fwp_pipe_out_start+0xa3>
    6a6f:	90                   	nop

0000000000006a70 <fwp_pipe_write>:
    6a70:	41 57                	push   %r15
    6a72:	41 56                	push   %r14
    6a74:	53                   	push   %rbx
    6a75:	48 89 f3             	mov    %rsi,%rbx
    6a78:	8b 05 62 e3 01 00    	mov    0x1e362(%rip),%eax        # 24de0 <fwp_po_kind>
    6a7e:	83 f8 01             	cmp    $0x1,%eax
    6a81:	74 12                	je     6a95 <fwp_pipe_write+0x25>
    6a83:	83 f8 02             	cmp    $0x2,%eax
    6a86:	75 46                	jne    6ace <fwp_pipe_write+0x5e>
    6a88:	48 89 de             	mov    %rbx,%rsi
    6a8b:	5b                   	pop    %rbx
    6a8c:	41 5e                	pop    %r14
    6a8e:	41 5f                	pop    %r15
    6a90:	e9 2b 36 00 00       	jmp    a0c0 <fwp_ring_put>
    6a95:	49 89 fe             	mov    %rdi,%r14
    6a98:	48 8b 05 49 e3 01 00 	mov    0x1e349(%rip),%rax        # 24de8 <fwp_po_len>
    6a9f:	48 01 d8             	add    %rbx,%rax
    6aa2:	48 3d 01 00 01 00    	cmp    $0x10001,%rax
    6aa8:	72 05                	jb     6aaf <fwp_pipe_write+0x3f>
    6aaa:	e8 71 37 00 00       	call   a220 <fwp_po_flush_sock>
    6aaf:	48 81 fb 01 00 01 00 	cmp    $0x10001,%rbx
    6ab6:	72 32                	jb     6aea <fwp_pipe_write+0x7a>
    6ab8:	8b 3d 02 e2 00 00    	mov    0xe202(%rip),%edi        # 14cc0 <fwp_po_sock>
    6abe:	4c 89 f6             	mov    %r14,%rsi
    6ac1:	48 89 da             	mov    %rbx,%rdx
    6ac4:	5b                   	pop    %rbx
    6ac5:	41 5e                	pop    %r14
    6ac7:	41 5f                	pop    %r15
    6ac9:	e9 82 37 00 00       	jmp    a250 <fwp_po_write_raw>
    6ace:	48 8b 05 db c4 00 00 	mov    0xc4db(%rip),%rax        # 12fb0 <stdout@GLIBC_2.2.5>
    6ad5:	48 8b 08             	mov    (%rax),%rcx
    6ad8:	be 01 00 00 00       	mov    $0x1,%esi
    6add:	48 89 da             	mov    %rbx,%rdx
    6ae0:	5b                   	pop    %rbx
    6ae1:	41 5e                	pop    %r14
    6ae3:	41 5f                	pop    %r15
    6ae5:	e9 b6 b9 ff ff       	jmp    24a0 <fwrite@plt>
    6aea:	4c 8b 3d f7 e2 01 00 	mov    0x1e2f7(%rip),%r15        # 24de8 <fwp_po_len>
    6af1:	48 8d 3d f8 e2 01 00 	lea    0x1e2f8(%rip),%rdi        # 24df0 <fwp_po_buf>
    6af8:	4c 01 ff             	add    %r15,%rdi
    6afb:	4c 89 f6             	mov    %r14,%rsi
    6afe:	48 89 da             	mov    %rbx,%rdx
    6b01:	e8 2a b8 ff ff       	call   2330 <memcpy@plt>
    6b06:	49 01 df             	add    %rbx,%r15
    6b09:	4c 89 3d d8 e2 01 00 	mov    %r15,0x1e2d8(%rip)        # 24de8 <fwp_po_len>
    6b10:	5b                   	pop    %rbx
    6b11:	41 5e                	pop    %r14
    6b13:	41 5f                	pop    %r15
    6b15:	c3                   	ret
    6b16:	66 2e 0f 1f 84 00 00 	cs nopw 0x0(%rax,%rax,1)
    6b1d:	00 00 00 

0000000000006b20 <fwp_pipe_flush>:
    6b20:	8b 05 ba e2 01 00    	mov    0x1e2ba(%rip),%eax        # 24de0 <fwp_po_kind>
    6b26:	85 c0                	test   %eax,%eax
    6b28:	74 0a                	je     6b34 <fwp_pipe_flush+0x14>
    6b2a:	83 f8 01             	cmp    $0x1,%eax
    6b2d:	75 1b                	jne    6b4a <fwp_pipe_flush+0x2a>
    6b2f:	e9 ec 36 00 00       	jmp    a220 <fwp_po_flush_sock>
    6b34:	50                   	push   %rax
    6b35:	48 8b 05 74 c4 00 00 	mov    0xc474(%rip),%rax        # 12fb0 <stdout@GLIBC_2.2.5>
    6b3c:	48 8b 38             	mov    (%rax),%rdi
    6b3f:	e8 0c b8 ff ff       	call   2350 <fflush@plt>
    6b44:	58                   	pop    %rax
    6b45:	e9 e6 39 00 00       	jmp    a530 <fwp_pipe_poll>
    6b4a:	c3                   	ret
    6b4b:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)

0000000000006b50 <fwp_pipe_out_ready>:
    6b50:	48 83 ec 18          	sub    $0x18,%rsp
    6b54:	48 8d 3d 96 77 00 00 	lea    0x7796(%rip),%rdi        # e2f1 <exec_in_fp0+0xcb1>
    6b5b:	e8 d0 b4 ff ff       	call   2030 <getenv@plt>
    6b60:	48 85 c0             	test   %rax,%rax
    6b63:	74 79                	je     6bde <fwp_pipe_out_ready+0x8e>
    6b65:	83 3d 50 e1 00 00 00 	cmpl   $0x0,0xe150(%rip)        # 14cbc <fwp_po_listen>
    6b6c:	78 70                	js     6bde <fwp_pipe_out_ready+0x8e>
    6b6e:	80 38 00             	cmpb   $0x0,(%rax)
    6b71:	74 6b                	je     6bde <fwp_pipe_out_ready+0x8e>
    6b73:	48 89 c7             	mov    %rax,%rdi
    6b76:	31 f6                	xor    %esi,%esi
    6b78:	ba 0a 00 00 00       	mov    $0xa,%edx
    6b7d:	e8 9e b7 ff ff       	call   2320 <strtol@plt>
    6b82:	8b 0d 34 e1 00 00    	mov    0xe134(%rip),%ecx        # 14cbc <fwp_po_listen>
    6b88:	89 0c 24             	mov    %ecx,(%rsp)
    6b8b:	48 b9 01 00 00 00 01 	movabs $0x100000001,%rcx
    6b92:	00 00 00 
    6b95:	48 89 4c 24 04       	mov    %rcx,0x4(%rsp)
    6b9a:	c7 44 24 0c 00 00 00 	movl   $0x0,0xc(%rsp)
    6ba1:	00 
    6ba2:	48 85 c0             	test   %rax,%rax
    6ba5:	7e 37                	jle    6bde <fwp_pipe_out_ready+0x8e>
    6ba7:	48 3d ff ff ff 7f    	cmp    $0x7fffffff,%rax
    6bad:	ba ff ff ff 7f       	mov    $0x7fffffff,%edx
    6bb2:	48 0f 4c d0          	cmovl  %rax,%rdx
    6bb6:	48 89 e7             	mov    %rsp,%rdi
    6bb9:	be 02 00 00 00       	mov    $0x2,%esi
    6bbe:	e8 fd b7 ff ff       	call   23c0 <poll@plt>
    6bc3:	85 c0                	test   %eax,%eax
    6bc5:	7e 17                	jle    6bde <fwp_pipe_out_ready+0x8e>
    6bc7:	f6 44 24 06 01       	testb  $0x1,0x6(%rsp)
    6bcc:	74 10                	je     6bde <fwp_pipe_out_ready+0x8e>
    6bce:	48 c7 05 27 e2 02 00 	movq   $0x0,0x2e227(%rip)        # 34e00 <fwp_po_next_check>
    6bd5:	00 00 00 00 
    6bd9:	e8 52 39 00 00       	call   a530 <fwp_pipe_poll>
    6bde:	48 83 c4 18          	add    $0x18,%rsp
    6be2:	c3                   	ret
    6be3:	66 66 66 66 2e 0f 1f 	data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    6bea:	84 00 00 00 00 00 

0000000000006bf0 <fwp_exec_call>:
    6bf0:	41 56                	push   %r14
    6bf2:	53                   	push   %rbx
    6bf3:	48 81 ec f8 00 00 00 	sub    $0xf8,%rsp
    6bfa:	48 89 f3             	mov    %rsi,%rbx
    6bfd:	49 89 fe             	mov    %rdi,%r14
    6c00:	48 8b 05 01 e2 02 00 	mov    0x2e201(%rip),%rax        # 34e08 <fwp_handlers>
    6c07:	48 89 84 24 d0 00 00 	mov    %rax,0xd0(%rsp)
    6c0e:	00 
    6c0f:	48 c7 84 24 e8 00 00 	movq   $0x0,0xe8(%rsp)
    6c16:	00 00 00 00 00 
    6c1b:	48 8b 05 56 e1 00 00 	mov    0xe156(%rip),%rax        # 14d78 <fwp_cleanups>
    6c22:	48 89 84 24 f0 00 00 	mov    %rax,0xf0(%rsp)
    6c29:	00 
    6c2a:	48 8d 7c 24 08       	lea    0x8(%rsp),%rdi
    6c2f:	48 89 3d d2 e1 02 00 	mov    %rdi,0x2e1d2(%rip)        # 34e08 <fwp_handlers>
    6c36:	e8 75 b6 ff ff       	call   22b0 <_setjmp@plt>
    6c3b:	85 c0                	test   %eax,%eax
    6c3d:	74 32                	je     6c71 <fwp_exec_call+0x81>
    6c3f:	48 8b 84 24 d0 00 00 	mov    0xd0(%rsp),%rax
    6c46:	00 
    6c47:	48 89 05 ba e1 02 00 	mov    %rax,0x2e1ba(%rip)        # 34e08 <fwp_handlers>
    6c4e:	e8 ed c1 ff ff       	call   2e40 <fwp_flush>
    6c53:	48 8b bc 24 d8 00 00 	mov    0xd8(%rsp),%rdi
    6c5a:	00 
    6c5b:	48 8b b4 24 e0 00 00 	mov    0xe0(%rsp),%rsi
    6c62:	00 
    6c63:	e8 18 41 00 00       	call   ad80 <fwp_exec_error>
    6c68:	b9 01 00 00 00       	mov    $0x1,%ecx
    6c6d:	31 c0                	xor    %eax,%eax
    6c6f:	eb 21                	jmp    6c92 <fwp_exec_call+0xa2>
    6c71:	e8 ea 40 00 00       	call   ad60 <fwp_pap>
    6c76:	48 89 c7             	mov    %rax,%rdi
    6c79:	4c 89 f6             	mov    %r14,%rsi
    6c7c:	e8 1f 3c 00 00       	call   a8a0 <fwp_apply>
    6c81:	48 8b 8c 24 d0 00 00 	mov    0xd0(%rsp),%rcx
    6c88:	00 
    6c89:	48 89 0d 78 e1 02 00 	mov    %rcx,0x2e178(%rip)        # 34e08 <fwp_handlers>
    6c90:	31 c9                	xor    %ecx,%ecx
    6c92:	89 0b                	mov    %ecx,(%rbx)
    6c94:	48 81 c4 f8 00 00 00 	add    $0xf8,%rsp
    6c9b:	5b                   	pop    %rbx
    6c9c:	41 5e                	pop    %r14
    6c9e:	c3                   	ret
    6c9f:	90                   	nop

0000000000006ca0 <fwp_emit_result>:
    6ca0:	e9 4b 55 00 00       	jmp    c1f0 <fwp_emit>
    6ca5:	66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
    6cac:	00 00 00 00 

0000000000006cb0 <fwp_read_exact>:
    6cb0:	41 57                	push   %r15
    6cb2:	41 56                	push   %r14
    6cb4:	53                   	push   %rbx
    6cb5:	48 89 f3             	mov    %rsi,%rbx
    6cb8:	49 89 fe             	mov    %rdi,%r14
    6cbb:	45 31 ff             	xor    %r15d,%r15d
    6cbe:	48 85 f6             	test   %rsi,%rsi
    6cc1:	0f 84 b9 00 00 00    	je     6d80 <fwp_read_exact+0xd0>
    6cc7:	8b 05 fb e0 01 00    	mov    0x1e0fb(%rip),%eax        # 24dc8 <fwp_in_npend>
    6ccd:	8b 0d f9 e0 01 00    	mov    0x1e0f9(%rip),%ecx        # 24dcc <fwp_in_ppos>
    6cd3:	39 c1                	cmp    %eax,%ecx
    6cd5:	0f 8d a5 00 00 00    	jge    6d80 <fwp_read_exact+0xd0>
    6cdb:	48 98                	cltq
    6cdd:	48 63 f1             	movslq %ecx,%rsi
    6ce0:	48 89 f2             	mov    %rsi,%rdx
    6ce3:	48 f7 d2             	not    %rdx
    6ce6:	48 01 c2             	add    %rax,%rdx
    6ce9:	48 8d 4b ff          	lea    -0x1(%rbx),%rcx
    6ced:	48 39 ca             	cmp    %rcx,%rdx
    6cf0:	48 0f 43 d1          	cmovae %rcx,%rdx
    6cf4:	48 ff c2             	inc    %rdx
    6cf7:	48 83 fa 20          	cmp    $0x20,%rdx
    6cfb:	72 16                	jb     6d13 <fwp_read_exact+0x63>
    6cfd:	48 8d 3d c0 e0 01 00 	lea    0x1e0c0(%rip),%rdi        # 24dc4 <fwp_in_pend>
    6d04:	4d 89 f0             	mov    %r14,%r8
    6d07:	49 29 f0             	sub    %rsi,%r8
    6d0a:	49 29 f8             	sub    %rdi,%r8
    6d0d:	49 83 f8 20          	cmp    $0x20,%r8
    6d11:	73 27                	jae    6d3a <fwp_read_exact+0x8a>
    6d13:	45 31 ff             	xor    %r15d,%r15d
    6d16:	48 89 f1             	mov    %rsi,%rcx
    6d19:	48 8d 15 a4 e0 01 00 	lea    0x1e0a4(%rip),%rdx        # 24dc4 <fwp_in_pend>
    6d20:	0f b6 34 11          	movzbl (%rcx,%rdx,1),%esi
    6d24:	48 ff c1             	inc    %rcx
    6d27:	43 88 34 3e          	mov    %sil,(%r14,%r15,1)
    6d2b:	49 ff c7             	inc    %r15
    6d2e:	49 39 df             	cmp    %rbx,%r15
    6d31:	73 3f                	jae    6d72 <fwp_read_exact+0xc2>
    6d33:	48 39 c1             	cmp    %rax,%rcx
    6d36:	7c e8                	jl     6d20 <fwp_read_exact+0x70>
    6d38:	eb 38                	jmp    6d72 <fwp_read_exact+0xc2>
    6d3a:	49 89 d7             	mov    %rdx,%r15
    6d3d:	49 83 e7 e0          	and    $0xffffffffffffffe0,%r15
    6d41:	49 8d 0c 37          	lea    (%r15,%rsi,1),%rcx
    6d45:	48 01 fe             	add    %rdi,%rsi
    6d48:	48 83 c6 10          	add    $0x10,%rsi
    6d4c:	31 ff                	xor    %edi,%edi
    6d4e:	66 90                	xchg   %ax,%ax
    6d50:	0f 10 44 3e f0       	movups -0x10(%rsi,%rdi,1),%xmm0
    6d55:	0f 10 0c 3e          	movups (%rsi,%rdi,1),%xmm1
    6d59:	41 0f 11 04 3e       	movups %xmm0,(%r14,%rdi,1)
    6d5e:	41 0f 11 4c 3e 10    	movups %xmm1,0x10(%r14,%rdi,1)
    6d64:	48 83 c7 20          	add    $0x20,%rdi
    6d68:	49 39 ff             	cmp    %rdi,%r15
    6d6b:	75 e3                	jne    6d50 <fwp_read_exact+0xa0>
    6d6d:	4c 39 fa             	cmp    %r15,%rdx
    6d70:	75 a7                	jne    6d19 <fwp_read_exact+0x69>
    6d72:	89 0d 54 e0 01 00    	mov    %ecx,0x1e054(%rip)        # 24dcc <fwp_in_ppos>
    6d78:	0f 1f 84 00 00 00 00 	nopl   0x0(%rax,%rax,1)
    6d7f:	00 
    6d80:	48 89 de             	mov    %rbx,%rsi
    6d83:	4c 29 fe             	sub    %r15,%rsi
    6d86:	76 15                	jbe    6d9d <fwp_read_exact+0xed>
    6d88:	4b 8d 3c 3e          	lea    (%r14,%r15,1),%rdi
    6d8c:	e8 3f 58 00 00       	call   c5d0 <fwp_pipe_read>
    6d91:	49 01 c7             	add    %rax,%r15
    6d94:	48 85 c0             	test   %rax,%rax
    6d97:	75 e7                	jne    6d80 <fwp_read_exact+0xd0>
    6d99:	31 c0                	xor    %eax,%eax
    6d9b:	eb 05                	jmp    6da2 <fwp_read_exact+0xf2>
    6d9d:	b8 01 00 00 00       	mov    $0x1,%eax
    6da2:	5b                   	pop    %rbx
    6da3:	41 5e                	pop    %r14
    6da5:	41 5f                	pop    %r15
    6da7:	c3                   	ret
    6da8:	0f 1f 84 00 00 00 00 	nopl   0x0(%rax,%rax,1)
    6daf:	00 

0000000000006db0 <fwp_stdin_leb>:
    6db0:	41 57                	push   %r15
    6db2:	41 56                	push   %r14
    6db4:	53                   	push   %rbx
    6db5:	48 83 ec 10          	sub    $0x10,%rsp
    6db9:	48 89 fb             	mov    %rdi,%rbx
    6dbc:	48 c7 07 00 00 00 00 	movq   $0x0,(%rdi)
    6dc3:	49 c7 c6 f9 ff ff ff 	mov    $0xfffffffffffffff9,%r14
    6dca:	4c 8d 7c 24 0f       	lea    0xf(%rsp),%r15
    6dcf:	90                   	nop
    6dd0:	be 01 00 00 00       	mov    $0x1,%esi
    6dd5:	4c 89 ff             	mov    %r15,%rdi
    6dd8:	e8 d3 fe ff ff       	call   6cb0 <fwp_read_exact>
    6ddd:	85 c0                	test   %eax,%eax
    6ddf:	74 35                	je     6e16 <fwp_stdin_leb+0x66>
    6de1:	0f b6 44 24 0f       	movzbl 0xf(%rsp),%eax
    6de6:	49 83 fe 38          	cmp    $0x38,%r14
    6dea:	75 07                	jne    6df3 <fwp_stdin_leb+0x43>
    6dec:	89 c1                	mov    %eax,%ecx
    6dee:	80 e1 7e             	and    $0x7e,%cl
    6df1:	75 1c                	jne    6e0f <fwp_stdin_leb+0x5f>
    6df3:	49 83 c6 07          	add    $0x7,%r14
    6df7:	89 c2                	mov    %eax,%edx
    6df9:	83 e2 7f             	and    $0x7f,%edx
    6dfc:	44 89 f1             	mov    %r14d,%ecx
    6dff:	48 d3 e2             	shl    %cl,%rdx
    6e02:	48 09 13             	or     %rdx,(%rbx)
    6e05:	84 c0                	test   %al,%al
    6e07:	79 11                	jns    6e1a <fwp_stdin_leb+0x6a>
    6e09:	49 83 fe 38          	cmp    $0x38,%r14
    6e0d:	76 c1                	jbe    6dd0 <fwp_stdin_leb+0x20>
    6e0f:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    6e14:	eb 09                	jmp    6e1f <fwp_stdin_leb+0x6f>
    6e16:	31 c0                	xor    %eax,%eax
    6e18:	eb 05                	jmp    6e1f <fwp_stdin_leb+0x6f>
    6e1a:	b8 01 00 00 00       	mov    $0x1,%eax
    6e1f:	48 83 c4 10          	add    $0x10,%rsp
    6e23:	5b                   	pop    %rbx
    6e24:	41 5e                	pop    %r14
    6e26:	41 5f                	pop    %r15
    6e28:	c3                   	ret
    6e29:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)

0000000000006e30 <fwp_stdin_name_len>:
    6e30:	53                   	push   %rbx
    6e31:	48 89 fb             	mov    %rdi,%rbx
    6e34:	e8 77 ff ff ff       	call   6db0 <fwp_stdin_leb>
    6e39:	83 f8 01             	cmp    $0x1,%eax
    6e3c:	75 0e                	jne    6e4c <fwp_stdin_name_len+0x1c>
    6e3e:	b9 ff ff ff ff       	mov    $0xffffffff,%ecx
    6e43:	48 81 3b 00 00 10 00 	cmpq   $0x100000,(%rbx)
    6e4a:	77 02                	ja     6e4e <fwp_stdin_name_len+0x1e>
    6e4c:	89 c1                	mov    %eax,%ecx
    6e4e:	89 c8                	mov    %ecx,%eax
    6e50:	5b                   	pop    %rbx
    6e51:	c3                   	ret
    6e52:	66 66 66 66 66 2e 0f 	data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    6e59:	1f 84 00 00 00 00 00 

0000000000006e60 <fwp_pipe_in_offer>:
    6e60:	55                   	push   %rbp
    6e61:	41 57                	push   %r15
    6e63:	41 56                	push   %r14
    6e65:	53                   	push   %rbx
    6e66:	48 81 ec 08 01 00 00 	sub    $0x108,%rsp
    6e6d:	48 8d 74 24 08       	lea    0x8(%rsp),%rsi
    6e72:	31 ff                	xor    %edi,%edi
    6e74:	e8 67 b6 ff ff       	call   24e0 <fstat@plt>
    6e79:	85 c0                	test   %eax,%eax
    6e7b:	0f 85 a5 00 00 00    	jne    6f26 <fwp_pipe_in_offer+0xc6>
    6e81:	b8 00 f0 00 00       	mov    $0xf000,%eax
    6e86:	23 44 24 20          	and    0x20(%rsp),%eax
    6e8a:	3d 00 10 00 00       	cmp    $0x1000,%eax
    6e8f:	0f 85 91 00 00 00    	jne    6f26 <fwp_pipe_in_offer+0xc6>
    6e95:	bf 01 00 00 00       	mov    $0x1,%edi
    6e9a:	be 01 00 08 00       	mov    $0x80001,%esi
    6e9f:	31 d2                	xor    %edx,%edx
    6ea1:	e8 6a b6 ff ff       	call   2510 <socket@plt>
    6ea6:	85 c0                	test   %eax,%eax
    6ea8:	78 7c                	js     6f26 <fwp_pipe_in_offer+0xc6>
    6eaa:	89 c3                	mov    %eax,%ebx
    6eac:	48 8d bc 24 9a 00 00 	lea    0x9a(%rsp),%rdi
    6eb3:	00 
    6eb4:	48 8d 74 24 08       	lea    0x8(%rsp),%rsi
    6eb9:	e8 82 31 00 00       	call   a040 <fwp_pipe_addr>
    6ebe:	41 89 c6             	mov    %eax,%r14d
    6ec1:	48 8d 3d ef 73 00 00 	lea    0x73ef(%rip),%rdi        # e2b7 <exec_in_fp0+0xc77>
    6ec8:	e8 63 b1 ff ff       	call   2030 <getenv@plt>
    6ecd:	49 89 c7             	mov    %rax,%r15
    6ed0:	e8 3b 31 00 00       	call   a010 <fwp_transport_off>
    6ed5:	89 c5                	mov    %eax,%ebp
    6ed7:	c7 04 24 46 57 50 54 	movl   $0x54505746,(%rsp)
    6ede:	85 c0                	test   %eax,%eax
    6ee0:	74 04                	je     6ee6 <fwp_pipe_in_offer+0x86>
    6ee2:	31 c0                	xor    %eax,%eax
    6ee4:	eb 1f                	jmp    6f05 <fwp_pipe_in_offer+0xa5>
    6ee6:	4d 85 ff             	test   %r15,%r15
    6ee9:	74 18                	je     6f03 <fwp_pipe_in_offer+0xa3>
    6eeb:	48 8d 35 98 74 00 00 	lea    0x7498(%rip),%rsi        # e38a <exec_in_fp0+0xd4a>
    6ef2:	4c 89 ff             	mov    %r15,%rdi
    6ef5:	e8 d6 b3 ff ff       	call   22d0 <strcmp@plt>
    6efa:	83 f8 01             	cmp    $0x1,%eax
    6efd:	b0 02                	mov    $0x2,%al
    6eff:	1c 00                	sbb    $0x0,%al
    6f01:	eb 02                	jmp    6f05 <fwp_pipe_in_offer+0xa5>
    6f03:	b0 02                	mov    $0x2,%al
    6f05:	88 44 24 04          	mov    %al,0x4(%rsp)
    6f09:	48 8d b4 24 9a 00 00 	lea    0x9a(%rsp),%rsi
    6f10:	00 
    6f11:	89 df                	mov    %ebx,%edi
    6f13:	44 89 f2             	mov    %r14d,%edx
    6f16:	e8 75 b5 ff ff       	call   2490 <connect@plt>
    6f1b:	85 c0                	test   %eax,%eax
    6f1d:	74 15                	je     6f34 <fwp_pipe_in_offer+0xd4>
    6f1f:	89 df                	mov    %ebx,%edi
    6f21:	e8 0a b3 ff ff       	call   2230 <close@plt>
    6f26:	48 81 c4 08 01 00 00 	add    $0x108,%rsp
    6f2d:	5b                   	pop    %rbx
    6f2e:	41 5e                	pop    %r14
    6f30:	41 5f                	pop    %r15
    6f32:	5d                   	pop    %rbp
    6f33:	c3                   	ret
    6f34:	48 89 e6             	mov    %rsp,%rsi
    6f37:	ba 05 00 00 00       	mov    $0x5,%edx
    6f3c:	89 df                	mov    %ebx,%edi
    6f3e:	b9 00 40 00 00       	mov    $0x4000,%ecx
    6f43:	e8 58 b2 ff ff       	call   21a0 <send@plt>
    6f48:	85 ed                	test   %ebp,%ebp
    6f4a:	75 d3                	jne    6f1f <fwp_pipe_in_offer+0xbf>
    6f4c:	48 83 f8 05          	cmp    $0x5,%rax
    6f50:	75 cd                	jne    6f1f <fwp_pipe_in_offer+0xbf>
    6f52:	89 1d 70 dd 00 00    	mov    %ebx,0xdd70(%rip)        # 14cc8 <fwp_pi_sock>
    6f58:	eb cc                	jmp    6f26 <fwp_pipe_in_offer+0xc6>
    6f5a:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)

0000000000006f60 <fwp_pipe_in_switch>:
    6f60:	55                   	push   %rbp
    6f61:	41 57                	push   %r15
    6f63:	41 56                	push   %r14
    6f65:	53                   	push   %rbx
    6f66:	48 81 ec 08 01 00 00 	sub    $0x108,%rsp
    6f6d:	31 db                	xor    %ebx,%ebx
    6f6f:	48 83 fe 01          	cmp    $0x1,%rsi
    6f73:	0f 85 f6 01 00 00    	jne    716f <fwp_pipe_in_switch+0x20f>
    6f79:	48 89 f8             	mov    %rdi,%rax
    6f7c:	8b 3d 46 dd 00 00    	mov    0xdd46(%rip),%edi        # 14cc8 <fwp_pi_sock>
    6f82:	85 ff                	test   %edi,%edi
    6f84:	0f 88 e5 01 00 00    	js     716f <fwp_pipe_in_switch+0x20f>
    6f8a:	83 3d 83 de 02 00 00 	cmpl   $0x0,0x2de83(%rip)        # 34e14 <fwp_pi_kind>
    6f91:	0f 85 d8 01 00 00    	jne    716f <fwp_pipe_in_switch+0x20f>
    6f97:	0f b6 00             	movzbl (%rax),%eax
    6f9a:	83 f8 02             	cmp    $0x2,%eax
    6f9d:	74 29                	je     6fc8 <fwp_pipe_in_switch+0x68>
    6f9f:	83 f8 01             	cmp    $0x1,%eax
    6fa2:	0f 85 c7 01 00 00    	jne    716f <fwp_pipe_in_switch+0x20f>
    6fa8:	c7 05 62 de 02 00 01 	movl   $0x1,0x2de62(%rip)        # 34e14 <fwp_pi_kind>
    6faf:	00 00 00 
    6fb2:	48 8d 3d e8 70 00 00 	lea    0x70e8(%rip),%rdi        # e0a1 <exec_in_fp0+0xa61>
    6fb9:	e8 32 58 00 00       	call   c7f0 <fwp_pipe_report>
    6fbe:	bb 01 00 00 00       	mov    $0x1,%ebx
    6fc3:	e9 a7 01 00 00       	jmp    716f <fwp_pipe_in_switch+0x20f>
    6fc8:	48 8d 44 24 0f       	lea    0xf(%rsp),%rax
    6fcd:	48 89 44 24 50       	mov    %rax,0x50(%rsp)
    6fd2:	48 c7 44 24 58 01 00 	movq   $0x1,0x58(%rsp)
    6fd9:	00 00 
    6fdb:	0f 57 c0             	xorps  %xmm0,%xmm0
    6fde:	0f 29 44 24 20       	movaps %xmm0,0x20(%rsp)
    6fe3:	0f 29 44 24 30       	movaps %xmm0,0x30(%rsp)
    6fe8:	0f 29 44 24 10       	movaps %xmm0,0x10(%rsp)
    6fed:	48 c7 44 24 40 00 00 	movq   $0x0,0x40(%rsp)
    6ff4:	00 00 
    6ff6:	48 8d 44 24 50       	lea    0x50(%rsp),%rax
    6ffb:	48 89 44 24 20       	mov    %rax,0x20(%rsp)
    7000:	48 c7 44 24 28 01 00 	movq   $0x1,0x28(%rsp)
    7007:	00 00 
    7009:	48 8d 44 24 60       	lea    0x60(%rsp),%rax
    700e:	48 89 44 24 30       	mov    %rax,0x30(%rsp)
    7013:	48 c7 44 24 38 18 00 	movq   $0x18,0x38(%rsp)
    701a:	00 00 
    701c:	48 8d 74 24 10       	lea    0x10(%rsp),%rsi
    7021:	ba 00 00 00 40       	mov    $0x40000000,%edx
    7026:	e8 75 b3 ff ff       	call   23a0 <recvmsg@plt>
    702b:	31 db                	xor    %ebx,%ebx
    702d:	48 83 f8 01          	cmp    $0x1,%rax
    7031:	0f 85 38 01 00 00    	jne    716f <fwp_pipe_in_switch+0x20f>
    7037:	48 83 7c 24 38 10    	cmpq   $0x10,0x38(%rsp)
    703d:	0f 82 2c 01 00 00    	jb     716f <fwp_pipe_in_switch+0x20f>
    7043:	48 8b 44 24 30       	mov    0x30(%rsp),%rax
    7048:	48 85 c0             	test   %rax,%rax
    704b:	0f 84 1e 01 00 00    	je     716f <fwp_pipe_in_switch+0x20f>
    7051:	83 78 0c 01          	cmpl   $0x1,0xc(%rax)
    7055:	0f 85 14 01 00 00    	jne    716f <fwp_pipe_in_switch+0x20f>
    705b:	8b 68 10             	mov    0x10(%rax),%ebp
    705e:	48 8d 74 24 78       	lea    0x78(%rsp),%rsi
    7063:	89 ef                	mov    %ebp,%edi
    7065:	e8 76 b4 ff ff       	call   24e0 <fstat@plt>
    706a:	85 c0                	test   %eax,%eax
    706c:	0f 85 f4 00 00 00    	jne    7166 <fwp_pipe_in_switch+0x206>
    7072:	4c 8b b4 24 a8 00 00 	mov    0xa8(%rsp),%r14
    7079:	00 
    707a:	49 81 fe 00 10 00 00 	cmp    $0x1000,%r14
    7081:	0f 86 df 00 00 00    	jbe    7166 <fwp_pipe_in_switch+0x206>
    7087:	31 db                	xor    %ebx,%ebx
    7089:	31 ff                	xor    %edi,%edi
    708b:	4c 89 f6             	mov    %r14,%rsi
    708e:	ba 03 00 00 00       	mov    $0x3,%edx
    7093:	b9 01 00 00 00       	mov    $0x1,%ecx
    7098:	41 89 e8             	mov    %ebp,%r8d
    709b:	45 31 c9             	xor    %r9d,%r9d
    709e:	e8 ed b0 ff ff       	call   2190 <mmap@plt>
    70a3:	49 89 c7             	mov    %rax,%r15
    70a6:	89 ef                	mov    %ebp,%edi
    70a8:	e8 83 b1 ff ff       	call   2230 <close@plt>
    70ad:	49 83 ff ff          	cmp    $0xffffffffffffffff,%r15
    70b1:	0f 84 b8 00 00 00    	je     716f <fwp_pipe_in_switch+0x20f>
    70b7:	41 81 3f 46 57 50 53 	cmpl   $0x53505746,(%r15)
    70be:	0f 85 ab 00 00 00    	jne    716f <fwp_pipe_in_switch+0x20f>
    70c4:	41 83 7f 04 01       	cmpl   $0x1,0x4(%r15)
    70c9:	0f 85 a0 00 00 00    	jne    716f <fwp_pipe_in_switch+0x20f>
    70cf:	49 8b 47 08          	mov    0x8(%r15),%rax
    70d3:	48 85 c0             	test   %rax,%rax
    70d6:	0f 84 93 00 00 00    	je     716f <fwp_pipe_in_switch+0x20f>
    70dc:	48 89 c1             	mov    %rax,%rcx
    70df:	48 d1 e9             	shr    $1,%rcx
    70e2:	48 ba 55 55 55 55 55 	movabs $0x5555555555555555,%rdx
    70e9:	55 55 55 
    70ec:	48 21 ca             	and    %rcx,%rdx
    70ef:	48 89 c1             	mov    %rax,%rcx
    70f2:	48 29 d1             	sub    %rdx,%rcx
    70f5:	48 ba 33 33 33 33 33 	movabs $0x3333333333333333,%rdx
    70fc:	33 33 33 
    70ff:	48 89 ce             	mov    %rcx,%rsi
    7102:	48 21 d6             	and    %rdx,%rsi
    7105:	48 c1 e9 02          	shr    $0x2,%rcx
    7109:	48 21 d1             	and    %rdx,%rcx
    710c:	48 01 f1             	add    %rsi,%rcx
    710f:	48 89 ca             	mov    %rcx,%rdx
    7112:	48 c1 ea 04          	shr    $0x4,%rdx
    7116:	48 01 ca             	add    %rcx,%rdx
    7119:	48 b9 0f 0f 0f 0f 0f 	movabs $0xf0f0f0f0f0f0f0f,%rcx
    7120:	0f 0f 0f 
    7123:	48 21 d1             	and    %rdx,%rcx
    7126:	48 ba 01 01 01 01 01 	movabs $0x101010101010101,%rdx
    712d:	01 01 01 
    7130:	48 0f af d1          	imul   %rcx,%rdx
    7134:	48 c1 ea 38          	shr    $0x38,%rdx
    7138:	83 fa 01             	cmp    $0x1,%edx
    713b:	77 32                	ja     716f <fwp_pipe_in_switch+0x20f>
    713d:	49 81 c6 00 f0 ff ff 	add    $0xfffffffffffff000,%r14
    7144:	4c 39 f0             	cmp    %r14,%rax
    7147:	77 26                	ja     716f <fwp_pipe_in_switch+0x20f>
    7149:	4c 89 3d c8 dc 02 00 	mov    %r15,0x2dcc8(%rip)        # 34e18 <fwp_pi_ring>
    7150:	c7 05 ba dc 02 00 02 	movl   $0x2,0x2dcba(%rip)        # 34e14 <fwp_pi_kind>
    7157:	00 00 00 
    715a:	48 8d 3d 2d 72 00 00 	lea    0x722d(%rip),%rdi        # e38e <exec_in_fp0+0xd4e>
    7161:	e9 53 fe ff ff       	jmp    6fb9 <fwp_pipe_in_switch+0x59>
    7166:	89 ef                	mov    %ebp,%edi
    7168:	e8 c3 b0 ff ff       	call   2230 <close@plt>
    716d:	31 db                	xor    %ebx,%ebx
    716f:	89 d8                	mov    %ebx,%eax
    7171:	48 81 c4 08 01 00 00 	add    $0x108,%rsp
    7178:	5b                   	pop    %rbx
    7179:	41 5e                	pop    %r14
    717b:	41 5f                	pop    %r15
    717d:	5d                   	pop    %rbp
    717e:	c3                   	ret
    717f:	90                   	nop

0000000000007180 <fwp_decode>:
    7180:	55                   	push   %rbp
    7181:	41 57                	push   %r15
    7183:	41 56                	push   %r14
    7185:	41 55                	push   %r13
    7187:	41 54                	push   %r12
    7189:	53                   	push   %rbx
    718a:	48 83 ec 38          	sub    $0x38,%rsp
    718e:	8b 06                	mov    (%rsi),%eax
    7190:	45 31 f6             	xor    %r14d,%r14d
    7193:	48 83 f8 15          	cmp    $0x15,%rax
    7197:	77 47                	ja     71e0 <fwp_decode+0x60>
    7199:	48 89 d3             	mov    %rdx,%rbx
    719c:	49 89 f4             	mov    %rsi,%r12
    719f:	49 89 ff             	mov    %rdi,%r15
    71a2:	48 8d 0d d7 5f 00 00 	lea    0x5fd7(%rip),%rcx        # d180 <_IO_stdin_used+0x180>
    71a9:	48 63 14 81          	movslq (%rcx,%rax,4),%rdx
    71ad:	48 01 ca             	add    %rcx,%rdx
    71b0:	ff e2                	jmp    *%rdx
    71b2:	31 c9                	xor    %ecx,%ecx
    71b4:	83 f8 0a             	cmp    $0xa,%eax
    71b7:	0f 95 c1             	setne  %cl
    71ba:	8d 34 8d 04 00 00 00 	lea    0x4(,%rcx,4),%esi
    71c1:	48 8d 54 24 08       	lea    0x8(%rsp),%rdx
    71c6:	4c 89 ff             	mov    %r15,%rdi
    71c9:	e8 72 56 00 00       	call   c840 <rd_le>
    71ce:	85 c0                	test   %eax,%eax
    71d0:	74 0e                	je     71e0 <fwp_decode+0x60>
    71d2:	48 8b 44 24 08       	mov    0x8(%rsp),%rax
    71d7:	48 89 03             	mov    %rax,(%rbx)
    71da:	41 be 01 00 00 00    	mov    $0x1,%r14d
    71e0:	44 89 f0             	mov    %r14d,%eax
    71e3:	48 83 c4 38          	add    $0x38,%rsp
    71e7:	5b                   	pop    %rbx
    71e8:	41 5c                	pop    %r12
    71ea:	41 5d                	pop    %r13
    71ec:	41 5e                	pop    %r14
    71ee:	41 5f                	pop    %r15
    71f0:	5d                   	pop    %rbp
    71f1:	c3                   	ret
    71f2:	48 8d 74 24 08       	lea    0x8(%rsp),%rsi
    71f7:	4c 89 ff             	mov    %r15,%rdi
    71fa:	e8 01 57 00 00       	call   c900 <rd_leb>
    71ff:	45 31 f6             	xor    %r14d,%r14d
    7202:	85 c0                	test   %eax,%eax
    7204:	74 da                	je     71e0 <fwp_decode+0x60>
    7206:	4c 8b 6c 24 08       	mov    0x8(%rsp),%r13
    720b:	4d 3b 6f 08          	cmp    0x8(%r15),%r13
    720f:	77 cf                	ja     71e0 <fwp_decode+0x60>
    7211:	48 8d 54 24 18       	lea    0x18(%rsp),%rdx
    7216:	4c 89 ff             	mov    %r15,%rdi
    7219:	4c 89 ee             	mov    %r13,%rsi
    721c:	e8 5f 57 00 00       	call   c980 <rd_take>
    7221:	85 c0                	test   %eax,%eax
    7223:	74 bb                	je     71e0 <fwp_decode+0x60>
    7225:	41 83 3c 24 0c       	cmpl   $0xc,(%r12)
    722a:	4c 8b 7c 24 18       	mov    0x18(%rsp),%r15
    722f:	75 0f                	jne    7240 <fwp_decode+0xc0>
    7231:	4c 89 ff             	mov    %r15,%rdi
    7234:	4c 89 ee             	mov    %r13,%rsi
    7237:	e8 14 05 00 00       	call   7750 <fwp_valid_utf8>
    723c:	85 c0                	test   %eax,%eax
    723e:	74 a0                	je     71e0 <fwp_decode+0x60>
    7240:	4c 89 ff             	mov    %r15,%rdi
    7243:	4c 89 ee             	mov    %r13,%rsi
    7246:	e8 65 06 00 00       	call   78b0 <fwp_str_new>
    724b:	eb 8a                	jmp    71d7 <fwp_decode+0x57>
    724d:	48 8d 54 24 08       	lea    0x8(%rsp),%rdx
    7252:	4c 89 ff             	mov    %r15,%rdi
    7255:	be 01 00 00 00       	mov    $0x1,%esi
    725a:	e8 e1 55 00 00       	call   c840 <rd_le>
    725f:	85 c0                	test   %eax,%eax
    7261:	0f 84 79 ff ff ff    	je     71e0 <fwp_decode+0x60>
    7267:	48 0f be 44 24 08    	movsbq 0x8(%rsp),%rax
    726d:	e9 65 ff ff ff       	jmp    71d7 <fwp_decode+0x57>
    7272:	48 8d 54 24 08       	lea    0x8(%rsp),%rdx
    7277:	4c 89 ff             	mov    %r15,%rdi
    727a:	be 08 00 00 00       	mov    $0x8,%esi
    727f:	e8 bc 55 00 00       	call   c840 <rd_le>
    7284:	45 31 f6             	xor    %r14d,%r14d
    7287:	85 c0                	test   %eax,%eax
    7289:	0f 84 51 ff ff ff    	je     71e0 <fwp_decode+0x60>
    728f:	48 8d 54 24 18       	lea    0x18(%rsp),%rdx
    7294:	4c 89 ff             	mov    %r15,%rdi
    7297:	be 08 00 00 00       	mov    $0x8,%esi
    729c:	e8 9f 55 00 00       	call   c840 <rd_le>
    72a1:	85 c0                	test   %eax,%eax
    72a3:	0f 84 37 ff ff ff    	je     71e0 <fwp_decode+0x60>
    72a9:	48 8b 74 24 18       	mov    0x18(%rsp),%rsi
    72ae:	48 8b 7c 24 08       	mov    0x8(%rsp),%rdi
    72b3:	41 83 3c 24 04       	cmpl   $0x4,(%r12)
    72b8:	0f 85 d1 02 00 00    	jne    758f <fwp_decode+0x40f>
    72be:	e8 9d 24 00 00       	call   9760 <fwp_box_i128>
    72c3:	e9 0f ff ff ff       	jmp    71d7 <fwp_decode+0x57>
    72c8:	48 8d 74 24 08       	lea    0x8(%rsp),%rsi
    72cd:	4c 89 ff             	mov    %r15,%rdi
    72d0:	e8 2b 56 00 00       	call   c900 <rd_leb>
    72d5:	85 c0                	test   %eax,%eax
    72d7:	0f 84 03 ff ff ff    	je     71e0 <fwp_decode+0x60>
    72dd:	48 8b 6c 24 08       	mov    0x8(%rsp),%rbp
    72e2:	49 3b 6f 08          	cmp    0x8(%r15),%rbp
    72e6:	0f 87 f4 fe ff ff    	ja     71e0 <fwp_decode+0x60>
    72ec:	4c 8d 35 dd da 01 00 	lea    0x1dadd(%rip),%r14        # 24dd0 <fwp_empty_map>
    72f3:	48 85 ed             	test   %rbp,%rbp
    72f6:	0f 84 9d 02 00 00    	je     7599 <fwp_decode+0x419>
    72fc:	4c 8d 6c 24 18       	lea    0x18(%rsp),%r13
    7301:	eb 20                	jmp    7323 <fwp_decode+0x1a3>
    7303:	31 f6                	xor    %esi,%esi
    7305:	48 8b 7c 24 18       	mov    0x18(%rsp),%rdi
    730a:	49 8b 4c 24 38       	mov    0x38(%r12),%rcx
    730f:	4c 89 f2             	mov    %r14,%rdx
    7312:	e8 89 1c 00 00       	call   8fa0 <fwp_p_map_insert>
    7317:	49 89 c6             	mov    %rax,%r14
    731a:	48 ff cd             	dec    %rbp
    731d:	0f 84 76 02 00 00    	je     7599 <fwp_decode+0x419>
    7323:	48 c7 44 24 30 00 00 	movq   $0x0,0x30(%rsp)
    732a:	00 00 
    732c:	49 8b 74 24 38       	mov    0x38(%r12),%rsi
    7331:	4c 89 ff             	mov    %r15,%rdi
    7334:	4c 89 ea             	mov    %r13,%rdx
    7337:	e8 44 fe ff ff       	call   7180 <fwp_decode>
    733c:	85 c0                	test   %eax,%eax
    733e:	0f 84 69 02 00 00    	je     75ad <fwp_decode+0x42d>
    7344:	41 83 3c 24 12       	cmpl   $0x12,(%r12)
    7349:	75 b8                	jne    7303 <fwp_decode+0x183>
    734b:	49 8b 74 24 40       	mov    0x40(%r12),%rsi
    7350:	4c 89 ff             	mov    %r15,%rdi
    7353:	48 8d 54 24 30       	lea    0x30(%rsp),%rdx
    7358:	e8 23 fe ff ff       	call   7180 <fwp_decode>
    735d:	85 c0                	test   %eax,%eax
    735f:	0f 84 48 02 00 00    	je     75ad <fwp_decode+0x42d>
    7365:	48 8b 74 24 30       	mov    0x30(%rsp),%rsi
    736a:	eb 99                	jmp    7305 <fwp_decode+0x185>
    736c:	48 8d 74 24 08       	lea    0x8(%rsp),%rsi
    7371:	4c 89 ff             	mov    %r15,%rdi
    7374:	e8 87 55 00 00       	call   c900 <rd_leb>
    7379:	85 c0                	test   %eax,%eax
    737b:	0f 84 5f fe ff ff    	je     71e0 <fwp_decode+0x60>
    7381:	48 89 5c 24 20       	mov    %rbx,0x20(%rsp)
    7386:	48 8b 5c 24 08       	mov    0x8(%rsp),%rbx
    738b:	49 3b 5f 08          	cmp    0x8(%r15),%rbx
    738f:	0f 87 4b fe ff ff    	ja     71e0 <fwp_decode+0x60>
    7395:	48 8d 3c dd 08 00 00 	lea    0x8(,%rbx,8),%rdi
    739c:	00 
    739d:	e8 0e e2 ff ff       	call   55b0 <fwp_alloc>
    73a2:	48 89 44 24 10       	mov    %rax,0x10(%rsp)
    73a7:	48 85 db             	test   %rbx,%rbx
    73aa:	74 35                	je     73e1 <fwp_decode+0x261>
    73ac:	48 8b 6c 24 10       	mov    0x10(%rsp),%rbp
    73b1:	49 89 dd             	mov    %rbx,%r13
    73b4:	66 66 66 2e 0f 1f 84 	data16 data16 cs nopw 0x0(%rax,%rax,1)
    73bb:	00 00 00 00 00 
    73c0:	49 8b 74 24 38       	mov    0x38(%r12),%rsi
    73c5:	4c 89 ff             	mov    %r15,%rdi
    73c8:	48 89 ea             	mov    %rbp,%rdx
    73cb:	e8 b0 fd ff ff       	call   7180 <fwp_decode>
    73d0:	85 c0                	test   %eax,%eax
    73d2:	0f 84 08 fe ff ff    	je     71e0 <fwp_decode+0x60>
    73d8:	48 83 c5 08          	add    $0x8,%rbp
    73dc:	49 ff cd             	dec    %r13
    73df:	75 df                	jne    73c0 <fwp_decode+0x240>
    73e1:	48 8b 7c 24 10       	mov    0x10(%rsp),%rdi
    73e6:	48 89 de             	mov    %rbx,%rsi
    73e9:	e8 a2 02 00 00       	call   7690 <fwp_list_from>
    73ee:	41 83 3c 24 11       	cmpl   $0x11,(%r12)
    73f3:	0f 85 b4 00 00 00    	jne    74ad <fwp_decode+0x32d>
    73f9:	48 89 c7             	mov    %rax,%rdi
    73fc:	e8 4f 1a 00 00       	call   8e50 <fwp_p_array_from_list>
    7401:	e9 a7 00 00 00       	jmp    74ad <fwp_decode+0x32d>
    7406:	48 8d 74 24 08       	lea    0x8(%rsp),%rsi
    740b:	4c 89 ff             	mov    %r15,%rdi
    740e:	e8 ed 54 00 00       	call   c900 <rd_leb>
    7413:	85 c0                	test   %eax,%eax
    7415:	0f 84 c5 fd ff ff    	je     71e0 <fwp_decode+0x60>
    741b:	4c 8b 6c 24 08       	mov    0x8(%rsp),%r13
    7420:	49 63 44 24 10       	movslq 0x10(%r12),%rax
    7425:	49 39 c5             	cmp    %rax,%r13
    7428:	0f 83 b2 fd ff ff    	jae    71e0 <fwp_decode+0x60>
    742e:	48 89 5c 24 20       	mov    %rbx,0x20(%rsp)
    7433:	49 8b 44 24 28       	mov    0x28(%r12),%rax
    7438:	4a 63 1c a8          	movslq (%rax,%r13,4),%rbx
    743c:	48 8d 3c dd 08 00 00 	lea    0x8(,%rbx,8),%rdi
    7443:	00 
    7444:	e8 67 e1 ff ff       	call   55b0 <fwp_alloc>
    7449:	48 89 44 24 10       	mov    %rax,0x10(%rsp)
    744e:	89 d8                	mov    %ebx,%eax
    7450:	48 89 44 24 28       	mov    %rax,0x28(%rsp)
    7455:	48 85 db             	test   %rbx,%rbx
    7458:	7e 41                	jle    749b <fwp_decode+0x31b>
    745a:	48 8b 44 24 28       	mov    0x28(%rsp),%rax
    745f:	48 8d 2c c5 00 00 00 	lea    0x0(,%rax,8),%rbp
    7466:	00 
    7467:	45 31 f6             	xor    %r14d,%r14d
    746a:	31 db                	xor    %ebx,%ebx
    746c:	49 8b 44 24 30       	mov    0x30(%r12),%rax
    7471:	4a 8b 04 e8          	mov    (%rax,%r13,8),%rax
    7475:	48 8b 34 18          	mov    (%rax,%rbx,1),%rsi
    7479:	48 8b 44 24 10       	mov    0x10(%rsp),%rax
    747e:	48 8d 14 18          	lea    (%rax,%rbx,1),%rdx
    7482:	4c 89 ff             	mov    %r15,%rdi
    7485:	e8 f6 fc ff ff       	call   7180 <fwp_decode>
    748a:	85 c0                	test   %eax,%eax
    748c:	0f 84 4e fd ff ff    	je     71e0 <fwp_decode+0x60>
    7492:	48 83 c3 08          	add    $0x8,%rbx
    7496:	48 39 dd             	cmp    %rbx,%rbp
    7499:	75 d1                	jne    746c <fwp_decode+0x2ec>
    749b:	44 89 ef             	mov    %r13d,%edi
    749e:	48 8b 74 24 28       	mov    0x28(%rsp),%rsi
    74a3:	48 8b 54 24 10       	mov    0x10(%rsp),%rdx
    74a8:	e8 53 ba ff ff       	call   2f00 <fwp_data>
    74ad:	48 8b 4c 24 20       	mov    0x20(%rsp),%rcx
    74b2:	48 89 01             	mov    %rax,(%rcx)
    74b5:	e9 20 fd ff ff       	jmp    71da <fwp_decode+0x5a>
    74ba:	be 01 00 00 00       	mov    $0x1,%esi
    74bf:	e9 fd fc ff ff       	jmp    71c1 <fwp_decode+0x41>
    74c4:	be 02 00 00 00       	mov    $0x2,%esi
    74c9:	e9 f3 fc ff ff       	jmp    71c1 <fwp_decode+0x41>
    74ce:	48 8d 54 24 08       	lea    0x8(%rsp),%rdx
    74d3:	4c 89 ff             	mov    %r15,%rdi
    74d6:	be 02 00 00 00       	mov    $0x2,%esi
    74db:	e8 60 53 00 00       	call   c840 <rd_le>
    74e0:	85 c0                	test   %eax,%eax
    74e2:	0f 84 f8 fc ff ff    	je     71e0 <fwp_decode+0x60>
    74e8:	48 0f bf 44 24 08    	movswq 0x8(%rsp),%rax
    74ee:	e9 e4 fc ff ff       	jmp    71d7 <fwp_decode+0x57>
    74f3:	48 8d 54 24 08       	lea    0x8(%rsp),%rdx
    74f8:	4c 89 ff             	mov    %r15,%rdi
    74fb:	be 04 00 00 00       	mov    $0x4,%esi
    7500:	e8 3b 53 00 00       	call   c840 <rd_le>
    7505:	85 c0                	test   %eax,%eax
    7507:	0f 84 d3 fc ff ff    	je     71e0 <fwp_decode+0x60>
    750d:	48 63 44 24 08       	movslq 0x8(%rsp),%rax
    7512:	e9 c0 fc ff ff       	jmp    71d7 <fwp_decode+0x57>
    7517:	be 04 00 00 00       	mov    $0x4,%esi
    751c:	e9 a0 fc ff ff       	jmp    71c1 <fwp_decode+0x41>
    7521:	49 63 7c 24 10       	movslq 0x10(%r12),%rdi
    7526:	48 85 ff             	test   %rdi,%rdi
    7529:	74 76                	je     75a1 <fwp_decode+0x421>
    752b:	48 c1 e7 03          	shl    $0x3,%rdi
    752f:	e8 7c e0 ff ff       	call   55b0 <fwp_alloc>
    7534:	41 8b 7c 24 10       	mov    0x10(%r12),%edi
    7539:	85 ff                	test   %edi,%edi
    753b:	7e 45                	jle    7582 <fwp_decode+0x402>
    753d:	45 31 f6             	xor    %r14d,%r14d
    7540:	48 89 44 24 10       	mov    %rax,0x10(%rsp)
    7545:	48 89 c5             	mov    %rax,%rbp
    7548:	45 31 ed             	xor    %r13d,%r13d
    754b:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)
    7550:	49 8b 44 24 20       	mov    0x20(%r12),%rax
    7555:	4a 8b 34 e8          	mov    (%rax,%r13,8),%rsi
    7559:	4c 89 ff             	mov    %r15,%rdi
    755c:	48 89 ea             	mov    %rbp,%rdx
    755f:	e8 1c fc ff ff       	call   7180 <fwp_decode>
    7564:	85 c0                	test   %eax,%eax
    7566:	0f 84 74 fc ff ff    	je     71e0 <fwp_decode+0x60>
    756c:	49 ff c5             	inc    %r13
    756f:	49 63 7c 24 10       	movslq 0x10(%r12),%rdi
    7574:	48 83 c5 08          	add    $0x8,%rbp
    7578:	49 39 fd             	cmp    %rdi,%r13
    757b:	7c d3                	jl     7550 <fwp_decode+0x3d0>
    757d:	48 8b 44 24 10       	mov    0x10(%rsp),%rax
    7582:	48 89 c6             	mov    %rax,%rsi
    7585:	e8 66 b9 ff ff       	call   2ef0 <fwp_record>
    758a:	e9 48 fc ff ff       	jmp    71d7 <fwp_decode+0x57>
    758f:	e8 7c 20 00 00       	call   9610 <fwp_box_u128>
    7594:	e9 3e fc ff ff       	jmp    71d7 <fwp_decode+0x57>
    7599:	4c 89 33             	mov    %r14,(%rbx)
    759c:	e9 39 fc ff ff       	jmp    71da <fwp_decode+0x5a>
    75a1:	48 c7 03 00 00 00 00 	movq   $0x0,(%rbx)
    75a8:	e9 2d fc ff ff       	jmp    71da <fwp_decode+0x5a>
    75ad:	45 31 f6             	xor    %r14d,%r14d
    75b0:	e9 2b fc ff ff       	jmp    71e0 <fwp_decode+0x60>
    75b5:	66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
    75bc:	00 00 00 00 

00000000000075c0 <fwp_read_text_line>:
    75c0:	53                   	push   %rbx
    75c1:	48 89 fb             	mov    %rdi,%rbx
    75c4:	48 c7 47 08 00 00 00 	movq   $0x0,0x8(%rdi)
    75cb:	00 
    75cc:	e8 df 53 00 00       	call   c9b0 <fwp_getc>
    75d1:	83 f8 ff             	cmp    $0xffffffff,%eax
    75d4:	74 59                	je     762f <fwp_read_text_line+0x6f>
    75d6:	66 2e 0f 1f 84 00 00 	cs nopw 0x0(%rax,%rax,1)
    75dd:	00 00 00 
    75e0:	83 f8 0a             	cmp    $0xa,%eax
    75e3:	74 1a                	je     75ff <fwp_read_text_line+0x3f>
    75e5:	0f be f0             	movsbl %al,%esi
    75e8:	48 89 df             	mov    %rbx,%rdi
    75eb:	e8 00 03 00 00       	call   78f0 <buf_putc>
    75f0:	e8 bb 53 00 00       	call   c9b0 <fwp_getc>
    75f5:	83 f8 ff             	cmp    $0xffffffff,%eax
    75f8:	75 e6                	jne    75e0 <fwp_read_text_line+0x20>
    75fa:	48 8b 03             	mov    (%rbx),%rax
    75fd:	eb 1c                	jmp    761b <fwp_read_text_line+0x5b>
    75ff:	48 8b 03             	mov    (%rbx),%rax
    7602:	48 8b 4b 08          	mov    0x8(%rbx),%rcx
    7606:	48 85 c9             	test   %rcx,%rcx
    7609:	74 10                	je     761b <fwp_read_text_line+0x5b>
    760b:	80 7c 08 ff 0d       	cmpb   $0xd,-0x1(%rax,%rcx,1)
    7610:	75 12                	jne    7624 <fwp_read_text_line+0x64>
    7612:	48 ff c9             	dec    %rcx
    7615:	48 89 4b 08          	mov    %rcx,0x8(%rbx)
    7619:	eb 05                	jmp    7620 <fwp_read_text_line+0x60>
    761b:	48 85 c0             	test   %rax,%rax
    761e:	74 08                	je     7628 <fwp_read_text_line+0x68>
    7620:	48 8b 4b 08          	mov    0x8(%rbx),%rcx
    7624:	c6 04 08 00          	movb   $0x0,(%rax,%rcx,1)
    7628:	b8 01 00 00 00       	mov    $0x1,%eax
    762d:	5b                   	pop    %rbx
    762e:	c3                   	ret
    762f:	31 c0                	xor    %eax,%eax
    7631:	5b                   	pop    %rbx
    7632:	c3                   	ret
    7633:	66 66 66 66 2e 0f 1f 	data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    763a:	84 00 00 00 00 00 

0000000000007640 <fwp_mem_realloc>:
    7640:	41 57                	push   %r15
    7642:	41 56                	push   %r14
    7644:	53                   	push   %rbx
    7645:	49 89 d6             	mov    %rdx,%r14
    7648:	49 89 f7             	mov    %rsi,%r15
    764b:	48 89 fb             	mov    %rdi,%rbx
    764e:	48 89 d7             	mov    %rdx,%rdi
    7651:	e8 5a df ff ff       	call   55b0 <fwp_alloc>
    7656:	48 85 db             	test   %rbx,%rbx
    7659:	74 23                	je     767e <fwp_mem_realloc+0x3e>
    765b:	4d 39 f7             	cmp    %r14,%r15
    765e:	4d 0f 42 f7          	cmovb  %r15,%r14
    7662:	48 89 c7             	mov    %rax,%rdi
    7665:	48 89 de             	mov    %rbx,%rsi
    7668:	4c 89 f2             	mov    %r14,%rdx
    766b:	49 89 c6             	mov    %rax,%r14
    766e:	e8 bd ac ff ff       	call   2330 <memcpy@plt>
    7673:	48 89 df             	mov    %rbx,%rdi
    7676:	e8 a5 e0 ff ff       	call   5720 <fwp_mem_free>
    767b:	4c 89 f0             	mov    %r14,%rax
    767e:	5b                   	pop    %rbx
    767f:	41 5e                	pop    %r14
    7681:	41 5f                	pop    %r15
    7683:	c3                   	ret
    7684:	66 66 66 2e 0f 1f 84 	data16 data16 cs nopw 0x0(%rax,%rax,1)
    768b:	00 00 00 00 00 

0000000000007690 <fwp_list_from>:
    7690:	41 56                	push   %r14
    7692:	53                   	push   %rbx
    7693:	50                   	push   %rax
    7694:	48 89 fb             	mov    %rdi,%rbx
    7697:	48 85 f6             	test   %rsi,%rsi
    769a:	74 28                	je     76c4 <fwp_list_from+0x34>
    769c:	49 89 f6             	mov    %rsi,%r14
    769f:	31 c0                	xor    %eax,%eax
    76a1:	66 66 66 66 66 66 2e 	data16 data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    76a8:	0f 1f 84 00 00 00 00 
    76af:	00 
    76b0:	4a 8b 7c f3 f8       	mov    -0x8(%rbx,%r14,8),%rdi
    76b5:	48 89 c6             	mov    %rax,%rsi
    76b8:	e8 63 06 00 00       	call   7d20 <fwp_cons>
    76bd:	49 ff ce             	dec    %r14
    76c0:	75 ee                	jne    76b0 <fwp_list_from+0x20>
    76c2:	eb 02                	jmp    76c6 <fwp_list_from+0x36>
    76c4:	31 c0                	xor    %eax,%eax
    76c6:	48 83 c4 08          	add    $0x8,%rsp
    76ca:	5b                   	pop    %rbx
    76cb:	41 5e                	pop    %r14
    76cd:	c3                   	ret
    76ce:	66 90                	xchg   %ax,%ax

00000000000076d0 <fwp_pipe_out_end>:
    76d0:	50                   	push   %rax
    76d1:	8b 05 09 d7 01 00    	mov    0x1d709(%rip),%eax        # 24de0 <fwp_po_kind>
    76d7:	83 f8 02             	cmp    $0x2,%eax
    76da:	74 1c                	je     76f8 <fwp_pipe_out_end+0x28>
    76dc:	83 f8 01             	cmp    $0x1,%eax
    76df:	75 3d                	jne    771e <fwp_pipe_out_end+0x4e>
    76e1:	e8 3a 2b 00 00       	call   a220 <fwp_po_flush_sock>
    76e6:	8b 3d d4 d5 00 00    	mov    0xd5d4(%rip),%edi        # 14cc0 <fwp_po_sock>
    76ec:	be 01 00 00 00       	mov    $0x1,%esi
    76f1:	e8 6a aa ff ff       	call   2160 <shutdown@plt>
    76f6:	eb 35                	jmp    772d <fwp_pipe_out_end+0x5d>
    76f8:	48 8b 35 f1 d6 02 00 	mov    0x2d6f1(%rip),%rsi        # 34df0 <fwp_po_ring>
    76ff:	c7 86 40 01 00 00 01 	movl   $0x1,0x140(%rsi)
    7706:	00 00 00 
    7709:	48 8d be c0 00 00 00 	lea    0xc0(%rsi),%rdi
    7710:	48 81 c6 c4 00 00 00 	add    $0xc4,%rsi
    7717:	e8 14 2d 00 00       	call   a430 <fwp_ring_wake>
    771c:	eb 0f                	jmp    772d <fwp_pipe_out_end+0x5d>
    771e:	48 8b 05 8b b8 00 00 	mov    0xb88b(%rip),%rax        # 12fb0 <stdout@GLIBC_2.2.5>
    7725:	48 8b 38             	mov    (%rax),%rdi
    7728:	e8 23 ac ff ff       	call   2350 <fflush@plt>
    772d:	8b 3d 89 d5 00 00    	mov    0xd589(%rip),%edi        # 14cbc <fwp_po_listen>
    7733:	85 ff                	test   %edi,%edi
    7735:	78 0f                	js     7746 <fwp_pipe_out_end+0x76>
    7737:	e8 f4 aa ff ff       	call   2230 <close@plt>
    773c:	c7 05 76 d5 00 00 ff 	movl   $0xffffffff,0xd576(%rip)        # 14cbc <fwp_po_listen>
    7743:	ff ff ff 
    7746:	58                   	pop    %rax
    7747:	c3                   	ret
    7748:	0f 1f 84 00 00 00 00 	nopl   0x0(%rax,%rax,1)
    774f:	00 

0000000000007750 <fwp_valid_utf8>:
    7750:	48 85 f6             	test   %rsi,%rsi
    7753:	0f 84 48 01 00 00    	je     78a1 <fwp_valid_utf8+0x151>
    7759:	53                   	push   %rbx
    775a:	31 c9                	xor    %ecx,%ecx
    775c:	eb 0e                	jmp    776c <fwp_valid_utf8+0x1c>
    775e:	66 90                	xchg   %ax,%ax
    7760:	48 ff c1             	inc    %rcx
    7763:	48 39 f1             	cmp    %rsi,%rcx
    7766:	0f 83 2e 01 00 00    	jae    789a <fwp_valid_utf8+0x14a>
    776c:	44 0f b6 14 0f       	movzbl (%rdi,%rcx,1),%r10d
    7771:	45 84 d2             	test   %r10b,%r10b
    7774:	79 ea                	jns    7760 <fwp_valid_utf8+0x10>
    7776:	41 8d 42 3e          	lea    0x3e(%r10),%eax
    777a:	3c 1e                	cmp    $0x1e,%al
    777c:	73 12                	jae    7790 <fwp_valid_utf8+0x40>
    777e:	ba 80 00 00 00       	mov    $0x80,%edx
    7783:	b8 01 00 00 00       	mov    $0x1,%eax
    7788:	41 b8 1f 00 00 00    	mov    $0x1f,%r8d
    778e:	eb 37                	jmp    77c7 <fwp_valid_utf8+0x77>
    7790:	44 89 d0             	mov    %r10d,%eax
    7793:	24 f0                	and    $0xf0,%al
    7795:	3c e0                	cmp    $0xe0,%al
    7797:	75 12                	jne    77ab <fwp_valid_utf8+0x5b>
    7799:	ba 00 08 00 00       	mov    $0x800,%edx
    779e:	b8 02 00 00 00       	mov    $0x2,%eax
    77a3:	41 b8 0f 00 00 00    	mov    $0xf,%r8d
    77a9:	eb 1c                	jmp    77c7 <fwp_valid_utf8+0x77>
    77ab:	41 8d 42 10          	lea    0x10(%r10),%eax
    77af:	3c 04                	cmp    $0x4,%al
    77b1:	0f 87 f0 00 00 00    	ja     78a7 <fwp_valid_utf8+0x157>
    77b7:	ba 00 00 01 00       	mov    $0x10000,%edx
    77bc:	b8 03 00 00 00       	mov    $0x3,%eax
    77c1:	41 b8 07 00 00 00    	mov    $0x7,%r8d
    77c7:	41 89 c1             	mov    %eax,%r9d
    77ca:	4e 8d 1c 09          	lea    (%rcx,%r9,1),%r11
    77ce:	31 c0                	xor    %eax,%eax
    77d0:	49 39 f3             	cmp    %rsi,%r11
    77d3:	0f 83 c6 00 00 00    	jae    789f <fwp_valid_utf8+0x14f>
    77d9:	44 0f b6 5c 0f 01    	movzbl 0x1(%rdi,%rcx,1),%r11d
    77df:	44 89 db             	mov    %r11d,%ebx
    77e2:	83 e3 c0             	and    $0xffffffc0,%ebx
    77e5:	81 fb 80 00 00 00    	cmp    $0x80,%ebx
    77eb:	0f 85 ae 00 00 00    	jne    789f <fwp_valid_utf8+0x14f>
    77f1:	45 21 d0             	and    %r10d,%r8d
    77f4:	45 8d 51 01          	lea    0x1(%r9),%r10d
    77f8:	44 89 c3             	mov    %r8d,%ebx
    77fb:	c1 e3 06             	shl    $0x6,%ebx
    77fe:	41 83 e3 3f          	and    $0x3f,%r11d
    7802:	41 09 db             	or     %ebx,%r11d
    7805:	41 83 fa 02          	cmp    $0x2,%r10d
    7809:	75 0d                	jne    7818 <fwp_valid_utf8+0xc8>
    780b:	45 89 da             	mov    %r11d,%r10d
    780e:	41 39 d2             	cmp    %edx,%r10d
    7811:	73 62                	jae    7875 <fwp_valid_utf8+0x125>
    7813:	e9 87 00 00 00       	jmp    789f <fwp_valid_utf8+0x14f>
    7818:	44 0f b6 44 0f 02    	movzbl 0x2(%rdi,%rcx,1),%r8d
    781e:	44 89 c3             	mov    %r8d,%ebx
    7821:	83 e3 c0             	and    $0xffffffc0,%ebx
    7824:	81 fb 80 00 00 00    	cmp    $0x80,%ebx
    782a:	75 73                	jne    789f <fwp_valid_utf8+0x14f>
    782c:	44 89 db             	mov    %r11d,%ebx
    782f:	c1 e3 06             	shl    $0x6,%ebx
    7832:	41 83 e0 3f          	and    $0x3f,%r8d
    7836:	41 09 d8             	or     %ebx,%r8d
    7839:	41 83 fa 03          	cmp    $0x3,%r10d
    783d:	75 0d                	jne    784c <fwp_valid_utf8+0xfc>
    783f:	45 89 c2             	mov    %r8d,%r10d
    7842:	45 89 d8             	mov    %r11d,%r8d
    7845:	41 39 d2             	cmp    %edx,%r10d
    7848:	73 2b                	jae    7875 <fwp_valid_utf8+0x125>
    784a:	eb 53                	jmp    789f <fwp_valid_utf8+0x14f>
    784c:	44 0f b6 54 0f 03    	movzbl 0x3(%rdi,%rcx,1),%r10d
    7852:	45 89 d3             	mov    %r10d,%r11d
    7855:	41 83 e3 c0          	and    $0xffffffc0,%r11d
    7859:	41 81 fb 80 00 00 00 	cmp    $0x80,%r11d
    7860:	75 3d                	jne    789f <fwp_valid_utf8+0x14f>
    7862:	45 89 c3             	mov    %r8d,%r11d
    7865:	41 c1 e3 06          	shl    $0x6,%r11d
    7869:	41 83 e2 3f          	and    $0x3f,%r10d
    786d:	45 09 da             	or     %r11d,%r10d
    7870:	41 39 d2             	cmp    %edx,%r10d
    7873:	72 2a                	jb     789f <fwp_valid_utf8+0x14f>
    7875:	41 81 fa ff ff 10 00 	cmp    $0x10ffff,%r10d
    787c:	77 21                	ja     789f <fwp_valid_utf8+0x14f>
    787e:	41 83 e0 e0          	and    $0xffffffe0,%r8d
    7882:	41 81 f8 60 03 00 00 	cmp    $0x360,%r8d
    7889:	74 14                	je     789f <fwp_valid_utf8+0x14f>
    788b:	4c 01 c9             	add    %r9,%rcx
    788e:	48 ff c1             	inc    %rcx
    7891:	48 39 f1             	cmp    %rsi,%rcx
    7894:	0f 82 d2 fe ff ff    	jb     776c <fwp_valid_utf8+0x1c>
    789a:	b8 01 00 00 00       	mov    $0x1,%eax
    789f:	5b                   	pop    %rbx
    78a0:	c3                   	ret
    78a1:	b8 01 00 00 00       	mov    $0x1,%eax
    78a6:	c3                   	ret
    78a7:	31 c0                	xor    %eax,%eax
    78a9:	5b                   	pop    %rbx
    78aa:	c3                   	ret
    78ab:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)

00000000000078b0 <fwp_str_new>:
    78b0:	41 57                	push   %r15
    78b2:	41 56                	push   %r14
    78b4:	53                   	push   %rbx
    78b5:	48 89 f3             	mov    %rsi,%rbx
    78b8:	49 89 fe             	mov    %rdi,%r14
    78bb:	48 8d 7e 09          	lea    0x9(%rsi),%rdi
    78bf:	e8 2c ee ff ff       	call   66f0 <fwp_alloc_leaf>
    78c4:	49 89 c7             	mov    %rax,%r15
    78c7:	48 89 18             	mov    %rbx,(%rax)
    78ca:	48 8d 78 08          	lea    0x8(%rax),%rdi
    78ce:	4c 89 f6             	mov    %r14,%rsi
    78d1:	48 89 da             	mov    %rbx,%rdx
    78d4:	e8 57 aa ff ff       	call   2330 <memcpy@plt>
    78d9:	41 c6 44 1f 08 00    	movb   $0x0,0x8(%r15,%rbx,1)
    78df:	4c 89 f8             	mov    %r15,%rax
    78e2:	5b                   	pop    %rbx
    78e3:	41 5e                	pop    %r14
    78e5:	41 5f                	pop    %r15
    78e7:	c3                   	ret
    78e8:	0f 1f 84 00 00 00 00 	nopl   0x0(%rax,%rax,1)
    78ef:	00 

00000000000078f0 <buf_putc>:
    78f0:	50                   	push   %rax
    78f1:	40 88 74 24 07       	mov    %sil,0x7(%rsp)
    78f6:	48 8d 74 24 07       	lea    0x7(%rsp),%rsi
    78fb:	ba 01 00 00 00       	mov    $0x1,%edx
    7900:	e8 3b 00 00 00       	call   7940 <buf_put>
    7905:	58                   	pop    %rax
    7906:	c3                   	ret
    7907:	66 0f 1f 84 00 00 00 	nopw   0x0(%rax,%rax,1)
    790e:	00 00 

0000000000007910 <buf_puts>:
    7910:	41 56                	push   %r14
    7912:	53                   	push   %rbx
    7913:	50                   	push   %rax
    7914:	48 89 f3             	mov    %rsi,%rbx
    7917:	49 89 fe             	mov    %rdi,%r14
    791a:	48 89 f7             	mov    %rsi,%rdi
    791d:	e8 4e a8 ff ff       	call   2170 <strlen@plt>
    7922:	4c 89 f7             	mov    %r14,%rdi
    7925:	48 89 de             	mov    %rbx,%rsi
    7928:	48 89 c2             	mov    %rax,%rdx
    792b:	48 83 c4 08          	add    $0x8,%rsp
    792f:	5b                   	pop    %rbx
    7930:	41 5e                	pop    %r14
    7932:	eb 0c                	jmp    7940 <buf_put>
    7934:	66 66 66 2e 0f 1f 84 	data16 data16 cs nopw 0x0(%rax,%rax,1)
    793b:	00 00 00 00 00 

0000000000007940 <buf_put>:
    7940:	41 57                	push   %r15
    7942:	41 56                	push   %r14
    7944:	53                   	push   %rbx
    7945:	48 89 d3             	mov    %rdx,%rbx
    7948:	49 89 f6             	mov    %rsi,%r14
    794b:	49 89 ff             	mov    %rdi,%r15
    794e:	48 89 d6             	mov    %rdx,%rsi
    7951:	e8 6a 00 00 00       	call   79c0 <buf_grow>
    7956:	49 8b 3f             	mov    (%r15),%rdi
    7959:	49 03 7f 08          	add    0x8(%r15),%rdi
    795d:	4c 89 f6             	mov    %r14,%rsi
    7960:	48 89 da             	mov    %rbx,%rdx
    7963:	e8 c8 a9 ff ff       	call   2330 <memcpy@plt>
    7968:	49 03 5f 08          	add    0x8(%r15),%rbx
    796c:	49 89 5f 08          	mov    %rbx,0x8(%r15)
    7970:	49 8b 07             	mov    (%r15),%rax
    7973:	c6 04 18 00          	movb   $0x0,(%rax,%rbx,1)
    7977:	5b                   	pop    %rbx
    7978:	41 5e                	pop    %r14
    797a:	41 5f                	pop    %r15
    797c:	c3                   	ret
    797d:	0f 1f 00             	nopl   (%rax)

0000000000007980 <buf_to_str>:
    7980:	41 56                	push   %r14
    7982:	53                   	push   %rbx
    7983:	50                   	push   %rax
    7984:	48 89 fb             	mov    %rdi,%rbx
    7987:	48 8b 07             	mov    (%rdi),%rax
    798a:	48 8b 77 08          	mov    0x8(%rdi),%rsi
    798e:	48 85 c0             	test   %rax,%rax
    7991:	48 8d 3d ee 66 00 00 	lea    0x66ee(%rip),%rdi        # e086 <exec_in_fp0+0xa46>
    7998:	48 0f 45 f8          	cmovne %rax,%rdi
    799c:	e8 0f ff ff ff       	call   78b0 <fwp_str_new>
    79a1:	49 89 c6             	mov    %rax,%r14
    79a4:	48 8b 3b             	mov    (%rbx),%rdi
    79a7:	e8 a4 a6 ff ff       	call   2050 <free@plt>
    79ac:	4c 89 f0             	mov    %r14,%rax
    79af:	48 83 c4 08          	add    $0x8,%rsp
    79b3:	5b                   	pop    %rbx
    79b4:	41 5e                	pop    %r14
    79b6:	c3                   	ret
    79b7:	66 0f 1f 84 00 00 00 	nopw   0x0(%rax,%rax,1)
    79be:	00 00 

00000000000079c0 <buf_grow>:
    79c0:	41 56                	push   %r14
    79c2:	53                   	push   %rbx
    79c3:	50                   	push   %rax
    79c4:	48 8b 47 08          	mov    0x8(%rdi),%rax
    79c8:	48 83 f8 ff          	cmp    $0xffffffffffffffff,%rax
    79cc:	74 73                	je     7a41 <buf_grow+0x81>
    79ce:	48 c7 c1 fe ff ff ff 	mov    $0xfffffffffffffffe,%rcx
    79d5:	48 29 c1             	sub    %rax,%rcx
    79d8:	48 39 f1             	cmp    %rsi,%rcx
    79db:	72 64                	jb     7a41 <buf_grow+0x81>
    79dd:	48 89 fb             	mov    %rdi,%rbx
    79e0:	48 01 f0             	add    %rsi,%rax
    79e3:	48 ff c0             	inc    %rax
    79e6:	48 8b 4f 10          	mov    0x10(%rdi),%rcx
    79ea:	48 39 c8             	cmp    %rcx,%rax
    79ed:	76 4a                	jbe    7a39 <buf_grow+0x79>
    79ef:	48 85 c9             	test   %rcx,%rcx
    79f2:	41 be 40 00 00 00    	mov    $0x40,%r14d
    79f8:	4c 0f 45 f1          	cmovne %rcx,%r14
    79fc:	49 39 c6             	cmp    %rax,%r14
    79ff:	73 21                	jae    7a22 <buf_grow+0x62>
    7a01:	66 66 66 66 66 66 2e 	data16 data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    7a08:	0f 1f 84 00 00 00 00 
    7a0f:	00 
    7a10:	4d 85 f6             	test   %r14,%r14
    7a13:	78 0a                	js     7a1f <buf_grow+0x5f>
    7a15:	4d 01 f6             	add    %r14,%r14
    7a18:	49 39 c6             	cmp    %rax,%r14
    7a1b:	72 f3                	jb     7a10 <buf_grow+0x50>
    7a1d:	eb 03                	jmp    7a22 <buf_grow+0x62>
    7a1f:	49 89 c6             	mov    %rax,%r14
    7a22:	48 8b 3b             	mov    (%rbx),%rdi
    7a25:	4c 89 f6             	mov    %r14,%rsi
    7a28:	e8 53 a9 ff ff       	call   2380 <realloc@plt>
    7a2d:	48 85 c0             	test   %rax,%rax
    7a30:	74 0f                	je     7a41 <buf_grow+0x81>
    7a32:	48 89 03             	mov    %rax,(%rbx)
    7a35:	4c 89 73 10          	mov    %r14,0x10(%rbx)
    7a39:	48 83 c4 08          	add    $0x8,%rsp
    7a3d:	5b                   	pop    %rbx
    7a3e:	41 5e                	pop    %r14
    7a40:	c3                   	ret
    7a41:	48 8b 05 90 b5 00 00 	mov    0xb590(%rip),%rax        # 12fd8 <stderr@GLIBC_2.2.5>
    7a48:	48 8b 08             	mov    (%rax),%rcx
    7a4b:	48 8d 3d 0e 5d 00 00 	lea    0x5d0e(%rip),%rdi        # d760 <exec_in_fp0+0x120>
    7a52:	be 13 00 00 00       	mov    $0x13,%esi
    7a57:	ba 01 00 00 00       	mov    $0x1,%edx
    7a5c:	e8 3f aa ff ff       	call   24a0 <fwrite@plt>
    7a61:	bf 66 00 00 00       	mov    $0x66,%edi
    7a66:	e8 15 aa ff ff       	call   2480 <exit@plt>
    7a6b:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)

0000000000007a70 <fwp_is_number_arg>:
    7a70:	31 c0                	xor    %eax,%eax
    7a72:	80 3f 2d             	cmpb   $0x2d,(%rdi)
    7a75:	75 19                	jne    7a90 <fwp_is_number_arg+0x20>
    7a77:	0f b6 4f 01          	movzbl 0x1(%rdi),%ecx
    7a7b:	8d 51 d0             	lea    -0x30(%rcx),%edx
    7a7e:	b8 01 00 00 00       	mov    $0x1,%eax
    7a83:	80 fa 0a             	cmp    $0xa,%dl
    7a86:	72 08                	jb     7a90 <fwp_is_number_arg+0x20>
    7a88:	31 c0                	xor    %eax,%eax
    7a8a:	80 f9 2e             	cmp    $0x2e,%cl
    7a8d:	0f 94 c0             	sete   %al
    7a90:	c3                   	ret
    7a91:	66 66 66 66 66 66 2e 	data16 data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    7a98:	0f 1f 84 00 00 00 00 
    7a9f:	00 

0000000000007aa0 <fwp_strf>:
    7aa0:	55                   	push   %rbp
    7aa1:	41 57                	push   %r15
    7aa3:	41 56                	push   %r14
    7aa5:	41 55                	push   %r13
    7aa7:	41 54                	push   %r12
    7aa9:	53                   	push   %rbx
    7aaa:	48 81 ec d8 00 00 00 	sub    $0xd8,%rsp
    7ab1:	48 89 fb             	mov    %rdi,%rbx
    7ab4:	48 89 74 24 28       	mov    %rsi,0x28(%rsp)
    7ab9:	48 89 54 24 30       	mov    %rdx,0x30(%rsp)
    7abe:	48 89 4c 24 38       	mov    %rcx,0x38(%rsp)
    7ac3:	4c 89 44 24 40       	mov    %r8,0x40(%rsp)
    7ac8:	4c 89 4c 24 48       	mov    %r9,0x48(%rsp)
    7acd:	84 c0                	test   %al,%al
    7acf:	74 37                	je     7b08 <fwp_strf+0x68>
    7ad1:	0f 29 44 24 50       	movaps %xmm0,0x50(%rsp)
    7ad6:	0f 29 4c 24 60       	movaps %xmm1,0x60(%rsp)
    7adb:	0f 29 54 24 70       	movaps %xmm2,0x70(%rsp)
    7ae0:	0f 29 9c 24 80 00 00 	movaps %xmm3,0x80(%rsp)
    7ae7:	00 
    7ae8:	0f 29 a4 24 90 00 00 	movaps %xmm4,0x90(%rsp)
    7aef:	00 
    7af0:	0f 29 ac 24 a0 00 00 	movaps %xmm5,0xa0(%rsp)
    7af7:	00 
    7af8:	0f 29 b4 24 b0 00 00 	movaps %xmm6,0xb0(%rsp)
    7aff:	00 
    7b00:	0f 29 bc 24 c0 00 00 	movaps %xmm7,0xc0(%rsp)
    7b07:	00 
    7b08:	48 8d 44 24 20       	lea    0x20(%rsp),%rax
    7b0d:	48 89 44 24 10       	mov    %rax,0x10(%rsp)
    7b12:	48 8d 84 24 10 01 00 	lea    0x110(%rsp),%rax
    7b19:	00 
    7b1a:	48 89 44 24 08       	mov    %rax,0x8(%rsp)
    7b1f:	48 bd 08 00 00 00 30 	movabs $0x3000000008,%rbp
    7b26:	00 00 00 
    7b29:	48 89 2c 24          	mov    %rbp,(%rsp)
    7b2d:	49 89 e6             	mov    %rsp,%r14
    7b30:	31 ff                	xor    %edi,%edi
    7b32:	31 f6                	xor    %esi,%esi
    7b34:	48 89 da             	mov    %rbx,%rdx
    7b37:	4c 89 f1             	mov    %r14,%rcx
    7b3a:	e8 d1 a5 ff ff       	call   2110 <vsnprintf@plt>
    7b3f:	4c 63 f8             	movslq %eax,%r15
    7b42:	4d 8d 67 01          	lea    0x1(%r15),%r12
    7b46:	4c 89 e7             	mov    %r12,%rdi
    7b49:	e8 a2 eb ff ff       	call   66f0 <fwp_alloc_leaf>
    7b4e:	49 89 c5             	mov    %rax,%r13
    7b51:	48 89 2c 24          	mov    %rbp,(%rsp)
    7b55:	48 8d 84 24 10 01 00 	lea    0x110(%rsp),%rax
    7b5c:	00 
    7b5d:	48 89 44 24 08       	mov    %rax,0x8(%rsp)
    7b62:	48 8d 44 24 20       	lea    0x20(%rsp),%rax
    7b67:	48 89 44 24 10       	mov    %rax,0x10(%rsp)
    7b6c:	4c 89 ef             	mov    %r13,%rdi
    7b6f:	4c 89 e6             	mov    %r12,%rsi
    7b72:	48 89 da             	mov    %rbx,%rdx
    7b75:	4c 89 f1             	mov    %r14,%rcx
    7b78:	e8 93 a5 ff ff       	call   2110 <vsnprintf@plt>
    7b7d:	4c 89 ef             	mov    %r13,%rdi
    7b80:	4c 89 fe             	mov    %r15,%rsi
    7b83:	e8 28 fd ff ff       	call   78b0 <fwp_str_new>
    7b88:	48 81 c4 d8 00 00 00 	add    $0xd8,%rsp
    7b8f:	5b                   	pop    %rbx
    7b90:	41 5c                	pop    %r12
    7b92:	41 5d                	pop    %r13
    7b94:	41 5e                	pop    %r14
    7b96:	41 5f                	pop    %r15
    7b98:	5d                   	pop    %rbp
    7b99:	c3                   	ret
    7b9a:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)

0000000000007ba0 <fwp_cli_value>:
    7ba0:	55                   	push   %rbp
    7ba1:	41 57                	push   %r15
    7ba3:	41 56                	push   %r14
    7ba5:	41 55                	push   %r13
    7ba7:	41 54                	push   %r12
    7ba9:	53                   	push   %rbx
    7baa:	48 83 ec 58          	sub    $0x58,%rsp
    7bae:	49 89 cf             	mov    %rcx,%r15
    7bb1:	48 89 d3             	mov    %rdx,%rbx
    7bb4:	49 89 f6             	mov    %rsi,%r14
    7bb7:	49 89 fc             	mov    %rdi,%r12
    7bba:	e8 91 01 00 00       	call   7d50 <fwp_is_enum>
    7bbf:	85 c0                	test   %eax,%eax
    7bc1:	0f 84 ef 00 00 00    	je     7cb6 <fwp_cli_value+0x116>
    7bc7:	48 89 5c 24 38       	mov    %rbx,0x38(%rsp)
    7bcc:	0f 57 c0             	xorps  %xmm0,%xmm0
    7bcf:	0f 29 44 24 40       	movaps %xmm0,0x40(%rsp)
    7bd4:	48 c7 44 24 50 00 00 	movq   $0x0,0x50(%rsp)
    7bdb:	00 00 
    7bdd:	0f 29 04 24          	movaps %xmm0,(%rsp)
    7be1:	48 c7 44 24 10 00 00 	movq   $0x0,0x10(%rsp)
    7be8:	00 00 
    7bea:	48 8d 7c 24 40       	lea    0x40(%rsp),%rdi
    7bef:	4c 89 e6             	mov    %r12,%rsi
    7bf2:	4c 89 74 24 30       	mov    %r14,0x30(%rsp)
    7bf7:	4c 89 f2             	mov    %r14,%rdx
    7bfa:	e8 d1 01 00 00       	call   7dd0 <fwp_loose>
    7bff:	4c 8b 6c 24 40       	mov    0x40(%rsp),%r13
    7c04:	31 db                	xor    %ebx,%ebx
    7c06:	83 3d d3 d0 00 00 00 	cmpl   $0x0,0xd0d3(%rip)        # 14ce0 <d0+0x10>
    7c0d:	41 be ff ff ff ff    	mov    $0xffffffff,%r14d
    7c13:	7e 7a                	jle    7c8f <fwp_cli_value+0xef>
    7c15:	48 8b 6c 24 48       	mov    0x48(%rsp),%rbp
    7c1a:	48 85 ed             	test   %rbp,%rbp
    7c1d:	74 70                	je     7c8f <fwp_cli_value+0xef>
    7c1f:	4c 89 64 24 20       	mov    %r12,0x20(%rsp)
    7c24:	4c 89 7c 24 28       	mov    %r15,0x28(%rsp)
    7c29:	45 31 ff             	xor    %r15d,%r15d
    7c2c:	48 89 e3             	mov    %rsp,%rbx
    7c2f:	90                   	nop
    7c30:	48 8b 05 b1 d0 00 00 	mov    0xd0b1(%rip),%rax        # 14ce8 <d0+0x18>
    7c37:	4e 8b 24 f8          	mov    (%rax,%r15,8),%r12
    7c3b:	4c 89 e7             	mov    %r12,%rdi
    7c3e:	e8 2d a5 ff ff       	call   2170 <strlen@plt>
    7c43:	48 89 df             	mov    %rbx,%rdi
    7c46:	4c 89 e6             	mov    %r12,%rsi
    7c49:	48 89 c2             	mov    %rax,%rdx
    7c4c:	e8 7f 01 00 00       	call   7dd0 <fwp_loose>
    7c51:	48 39 6c 24 08       	cmp    %rbp,0x8(%rsp)
    7c56:	75 15                	jne    7c6d <fwp_cli_value+0xcd>
    7c58:	48 8b 3c 24          	mov    (%rsp),%rdi
    7c5c:	4c 89 ee             	mov    %r13,%rsi
    7c5f:	48 89 ea             	mov    %rbp,%rdx
    7c62:	e8 09 a7 ff ff       	call   2370 <bcmp@plt>
    7c67:	85 c0                	test   %eax,%eax
    7c69:	45 0f 44 f7          	cmove  %r15d,%r14d
    7c6d:	49 ff c7             	inc    %r15
    7c70:	48 63 05 69 d0 00 00 	movslq 0xd069(%rip),%rax        # 14ce0 <d0+0x10>
    7c77:	49 39 c7             	cmp    %rax,%r15
    7c7a:	7d 05                	jge    7c81 <fwp_cli_value+0xe1>
    7c7c:	45 85 f6             	test   %r14d,%r14d
    7c7f:	78 af                	js     7c30 <fwp_cli_value+0x90>
    7c81:	48 8b 1c 24          	mov    (%rsp),%rbx
    7c85:	4c 8b 7c 24 28       	mov    0x28(%rsp),%r15
    7c8a:	4c 8b 64 24 20       	mov    0x20(%rsp),%r12
    7c8f:	4c 89 ef             	mov    %r13,%rdi
    7c92:	e8 b9 a3 ff ff       	call   2050 <free@plt>
    7c97:	48 89 df             	mov    %rbx,%rdi
    7c9a:	e8 b1 a3 ff ff       	call   2050 <free@plt>
    7c9f:	45 85 f6             	test   %r14d,%r14d
    7ca2:	78 3e                	js     7ce2 <fwp_cli_value+0x142>
    7ca4:	44 89 f0             	mov    %r14d,%eax
    7ca7:	48 8b 4c 24 38       	mov    0x38(%rsp),%rcx
    7cac:	48 89 01             	mov    %rax,(%rcx)
    7caf:	bb 01 00 00 00       	mov    $0x1,%ebx
    7cb4:	eb 50                	jmp    7d06 <fwp_cli_value+0x166>
    7cb6:	4c 89 e7             	mov    %r12,%rdi
    7cb9:	4c 89 f6             	mov    %r14,%rsi
    7cbc:	48 89 da             	mov    %rbx,%rdx
    7cbf:	e8 dc eb ff ff       	call   68a0 <fwp_parse_text>
    7cc4:	bb 01 00 00 00       	mov    $0x1,%ebx
    7cc9:	85 c0                	test   %eax,%eax
    7ccb:	75 39                	jne    7d06 <fwp_cli_value+0x166>
    7ccd:	48 8d 3d 68 65 00 00 	lea    0x6568(%rip),%rdi        # e23c <exec_in_fp0+0xbfc>
    7cd4:	48 8d 0d b1 67 00 00 	lea    0x67b1(%rip),%rcx        # e48c <exec_in_fp0+0xe4c>
    7cdb:	31 db                	xor    %ebx,%ebx
    7cdd:	44 89 f6             	mov    %r14d,%esi
    7ce0:	eb 17                	jmp    7cf9 <fwp_cli_value+0x159>
    7ce2:	e8 69 01 00 00       	call   7e50 <fwp_choices>
    7ce7:	48 8d 48 08          	lea    0x8(%rax),%rcx
    7ceb:	48 8d 3d 32 65 00 00 	lea    0x6532(%rip),%rdi        # e224 <exec_in_fp0+0xbe4>
    7cf2:	31 db                	xor    %ebx,%ebx
    7cf4:	48 8b 74 24 30       	mov    0x30(%rsp),%rsi
    7cf9:	4c 89 e2             	mov    %r12,%rdx
    7cfc:	31 c0                	xor    %eax,%eax
    7cfe:	e8 9d fd ff ff       	call   7aa0 <fwp_strf>
    7d03:	49 89 07             	mov    %rax,(%r15)
    7d06:	89 d8                	mov    %ebx,%eax
    7d08:	48 83 c4 58          	add    $0x58,%rsp
    7d0c:	5b                   	pop    %rbx
    7d0d:	41 5c                	pop    %r12
    7d0f:	41 5d                	pop    %r13
    7d11:	41 5e                	pop    %r14
    7d13:	41 5f                	pop    %r15
    7d15:	5d                   	pop    %rbp
    7d16:	c3                   	ret
    7d17:	66 0f 1f 84 00 00 00 	nopw   0x0(%rax,%rax,1)
    7d1e:	00 00 

0000000000007d20 <fwp_cons>:
    7d20:	48 83 ec 18          	sub    $0x18,%rsp
    7d24:	48 89 3c 24          	mov    %rdi,(%rsp)
    7d28:	48 89 74 24 08       	mov    %rsi,0x8(%rsp)
    7d2d:	48 89 e2             	mov    %rsp,%rdx
    7d30:	bf 01 00 00 00       	mov    $0x1,%edi
    7d35:	be 02 00 00 00       	mov    $0x2,%esi
    7d3a:	e8 c1 b1 ff ff       	call   2f00 <fwp_data>
    7d3f:	48 83 c4 18          	add    $0x18,%rsp
    7d43:	c3                   	ret
    7d44:	66 66 66 2e 0f 1f 84 	data16 data16 cs nopw 0x0(%rax,%rax,1)
    7d4b:	00 00 00 00 00 

0000000000007d50 <fwp_is_enum>:
    7d50:	31 c0                	xor    %eax,%eax
    7d52:	83 3d 77 cf 00 00 0e 	cmpl   $0xe,0xcf77(%rip)        # 14cd0 <d0>
    7d59:	75 67                	jne    7dc2 <fwp_is_enum+0x72>
    7d5b:	53                   	push   %rbx
    7d5c:	8b 1d 7e cf 00 00    	mov    0xcf7e(%rip),%ebx        # 14ce0 <d0+0x10>
    7d62:	85 db                	test   %ebx,%ebx
    7d64:	74 5b                	je     7dc1 <fwp_is_enum+0x71>
    7d66:	48 8b 3d 6b cf 00 00 	mov    0xcf6b(%rip),%rdi        # 14cd8 <d0+0x8>
    7d6d:	48 85 ff             	test   %rdi,%rdi
    7d70:	74 14                	je     7d86 <fwp_is_enum+0x36>
    7d72:	48 8d 35 dd 64 00 00 	lea    0x64dd(%rip),%rsi        # e256 <exec_in_fp0+0xc16>
    7d79:	e8 52 a5 ff ff       	call   22d0 <strcmp@plt>
    7d7e:	89 c1                	mov    %eax,%ecx
    7d80:	31 c0                	xor    %eax,%eax
    7d82:	85 c9                	test   %ecx,%ecx
    7d84:	74 3b                	je     7dc1 <fwp_is_enum+0x71>
    7d86:	85 db                	test   %ebx,%ebx
    7d88:	7e 32                	jle    7dbc <fwp_is_enum+0x6c>
    7d8a:	48 8b 0d 67 cf 00 00 	mov    0xcf67(%rip),%rcx        # 14cf8 <d0+0x28>
    7d91:	83 39 00             	cmpl   $0x0,(%rcx)
    7d94:	75 2b                	jne    7dc1 <fwp_is_enum+0x71>
    7d96:	b8 01 00 00 00       	mov    $0x1,%eax
    7d9b:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)
    7da0:	48 89 c2             	mov    %rax,%rdx
    7da3:	48 39 c3             	cmp    %rax,%rbx
    7da6:	74 0a                	je     7db2 <fwp_is_enum+0x62>
    7da8:	48 8d 42 01          	lea    0x1(%rdx),%rax
    7dac:	83 3c 91 00          	cmpl   $0x0,(%rcx,%rdx,4)
    7db0:	74 ee                	je     7da0 <fwp_is_enum+0x50>
    7db2:	31 c0                	xor    %eax,%eax
    7db4:	48 39 da             	cmp    %rbx,%rdx
    7db7:	0f 93 c0             	setae  %al
    7dba:	eb 05                	jmp    7dc1 <fwp_is_enum+0x71>
    7dbc:	b8 01 00 00 00       	mov    $0x1,%eax
    7dc1:	5b                   	pop    %rbx
    7dc2:	c3                   	ret
    7dc3:	66 66 66 66 2e 0f 1f 	data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    7dca:	84 00 00 00 00 00 

0000000000007dd0 <fwp_loose>:
    7dd0:	48 c7 47 08 00 00 00 	movq   $0x0,0x8(%rdi)
    7dd7:	00 
    7dd8:	48 85 d2             	test   %rdx,%rdx
    7ddb:	74 63                	je     7e40 <fwp_loose+0x70>
    7ddd:	41 57                	push   %r15
    7ddf:	41 56                	push   %r14
    7de1:	41 54                	push   %r12
    7de3:	53                   	push   %rbx
    7de4:	50                   	push   %rax
    7de5:	48 89 d3             	mov    %rdx,%rbx
    7de8:	49 89 f6             	mov    %rsi,%r14
    7deb:	49 89 ff             	mov    %rdi,%r15
    7dee:	45 31 e4             	xor    %r12d,%r12d
    7df1:	eb 15                	jmp    7e08 <fwp_loose+0x38>
    7df3:	66 66 66 66 2e 0f 1f 	data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    7dfa:	84 00 00 00 00 00 
    7e00:	49 ff c4             	inc    %r12
    7e03:	4c 39 e3             	cmp    %r12,%rbx
    7e06:	74 2d                	je     7e35 <fwp_loose+0x65>
    7e08:	43 0f b6 04 26       	movzbl (%r14,%r12,1),%eax
    7e0d:	83 f8 2d             	cmp    $0x2d,%eax
    7e10:	74 ee                	je     7e00 <fwp_loose+0x30>
    7e12:	83 f8 5f             	cmp    $0x5f,%eax
    7e15:	74 e9                	je     7e00 <fwp_loose+0x30>
    7e17:	8d 48 bf             	lea    -0x41(%rax),%ecx
    7e1a:	0f b6 d0             	movzbl %al,%edx
    7e1d:	0c 20                	or     $0x20,%al
    7e1f:	80 f9 1a             	cmp    $0x1a,%cl
    7e22:	0f b6 c0             	movzbl %al,%eax
    7e25:	0f 43 c2             	cmovae %edx,%eax
    7e28:	0f be f0             	movsbl %al,%esi
    7e2b:	4c 89 ff             	mov    %r15,%rdi
    7e2e:	e8 bd fa ff ff       	call   78f0 <buf_putc>
    7e33:	eb cb                	jmp    7e00 <fwp_loose+0x30>
    7e35:	48 83 c4 08          	add    $0x8,%rsp
    7e39:	5b                   	pop    %rbx
    7e3a:	41 5c                	pop    %r12
    7e3c:	41 5e                	pop    %r14
    7e3e:	41 5f                	pop    %r15
    7e40:	c3                   	ret
    7e41:	66 66 66 66 66 66 2e 	data16 data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    7e48:	0f 1f 84 00 00 00 00 
    7e4f:	00 

0000000000007e50 <fwp_choices>:
    7e50:	41 57                	push   %r15
    7e52:	41 56                	push   %r14
    7e54:	53                   	push   %rbx
    7e55:	48 83 ec 20          	sub    $0x20,%rsp
    7e59:	0f 57 c0             	xorps  %xmm0,%xmm0
    7e5c:	0f 29 04 24          	movaps %xmm0,(%rsp)
    7e60:	48 c7 44 24 10 00 00 	movq   $0x0,0x10(%rsp)
    7e67:	00 00 
    7e69:	83 3d 70 ce 00 00 00 	cmpl   $0x0,0xce70(%rip)        # 14ce0 <d0+0x10>
    7e70:	7e 5b                	jle    7ecd <fwp_choices+0x7d>
    7e72:	48 8b 05 6f ce 00 00 	mov    0xce6f(%rip),%rax        # 14ce8 <d0+0x18>
    7e79:	48 8b 30             	mov    (%rax),%rsi
    7e7c:	48 89 e7             	mov    %rsp,%rdi
    7e7f:	e8 5c 00 00 00       	call   7ee0 <fwp_kebab>
    7e84:	83 3d 55 ce 00 00 02 	cmpl   $0x2,0xce55(%rip)        # 14ce0 <d0+0x10>
    7e8b:	7c 40                	jl     7ecd <fwp_choices+0x7d>
    7e8d:	41 bf 01 00 00 00    	mov    $0x1,%r15d
    7e93:	48 8d 1d c1 63 00 00 	lea    0x63c1(%rip),%rbx        # e25b <exec_in_fp0+0xc1b>
    7e9a:	49 89 e6             	mov    %rsp,%r14
    7e9d:	0f 1f 00             	nopl   (%rax)
    7ea0:	4c 89 f7             	mov    %r14,%rdi
    7ea3:	48 89 de             	mov    %rbx,%rsi
    7ea6:	e8 65 fa ff ff       	call   7910 <buf_puts>
    7eab:	48 8b 05 36 ce 00 00 	mov    0xce36(%rip),%rax        # 14ce8 <d0+0x18>
    7eb2:	4a 8b 34 f8          	mov    (%rax,%r15,8),%rsi
    7eb6:	4c 89 f7             	mov    %r14,%rdi
    7eb9:	e8 22 00 00 00       	call   7ee0 <fwp_kebab>
    7ebe:	49 ff c7             	inc    %r15
    7ec1:	48 63 05 18 ce 00 00 	movslq 0xce18(%rip),%rax        # 14ce0 <d0+0x10>
    7ec8:	49 39 c7             	cmp    %rax,%r15
    7ecb:	7c d3                	jl     7ea0 <fwp_choices+0x50>
    7ecd:	48 89 e7             	mov    %rsp,%rdi
    7ed0:	e8 ab fa ff ff       	call   7980 <buf_to_str>
    7ed5:	48 83 c4 20          	add    $0x20,%rsp
    7ed9:	5b                   	pop    %rbx
    7eda:	41 5e                	pop    %r14
    7edc:	41 5f                	pop    %r15
    7ede:	c3                   	ret
    7edf:	90                   	nop

0000000000007ee0 <fwp_kebab>:
    7ee0:	41 57                	push   %r15
    7ee2:	41 56                	push   %r14
    7ee4:	53                   	push   %rbx
    7ee5:	44 0f b6 3e          	movzbl (%rsi),%r15d
    7ee9:	45 84 ff             	test   %r15b,%r15b
    7eec:	74 71                	je     7f5f <fwp_kebab+0x7f>
    7eee:	48 89 f3             	mov    %rsi,%rbx
    7ef1:	49 89 fe             	mov    %rdi,%r14
    7ef4:	48 ff c3             	inc    %rbx
    7ef7:	31 c0                	xor    %eax,%eax
    7ef9:	eb 36                	jmp    7f31 <fwp_kebab+0x51>
    7efb:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)
    7f00:	41 0f be f7          	movsbl %r15b,%esi
    7f04:	4c 89 f7             	mov    %r14,%rdi
    7f07:	e8 e4 f9 ff ff       	call   78f0 <buf_putc>
    7f0c:	41 8d 47 9f          	lea    -0x61(%r15),%eax
    7f10:	3c 1a                	cmp    $0x1a,%al
    7f12:	0f 92 c0             	setb   %al
    7f15:	41 80 c7 d0          	add    $0xd0,%r15b
    7f19:	41 80 ff 0a          	cmp    $0xa,%r15b
    7f1d:	0f 92 c1             	setb   %cl
    7f20:	08 c1                	or     %al,%cl
    7f22:	0f b6 c1             	movzbl %cl,%eax
    7f25:	44 0f b6 3b          	movzbl (%rbx),%r15d
    7f29:	48 ff c3             	inc    %rbx
    7f2c:	45 84 ff             	test   %r15b,%r15b
    7f2f:	74 2e                	je     7f5f <fwp_kebab+0x7f>
    7f31:	41 8d 4f bf          	lea    -0x41(%r15),%ecx
    7f35:	80 f9 19             	cmp    $0x19,%cl
    7f38:	77 c6                	ja     7f00 <fwp_kebab+0x20>
    7f3a:	85 c0                	test   %eax,%eax
    7f3c:	74 0d                	je     7f4b <fwp_kebab+0x6b>
    7f3e:	4c 89 f7             	mov    %r14,%rdi
    7f41:	be 2d 00 00 00       	mov    $0x2d,%esi
    7f46:	e8 a5 f9 ff ff       	call   78f0 <buf_putc>
    7f4b:	41 80 cf 20          	or     $0x20,%r15b
    7f4f:	41 0f be f7          	movsbl %r15b,%esi
    7f53:	4c 89 f7             	mov    %r14,%rdi
    7f56:	e8 95 f9 ff ff       	call   78f0 <buf_putc>
    7f5b:	31 c0                	xor    %eax,%eax
    7f5d:	eb c6                	jmp    7f25 <fwp_kebab+0x45>
    7f5f:	5b                   	pop    %rbx
    7f60:	41 5e                	pop    %r14
    7f62:	41 5f                	pop    %r15
    7f64:	c3                   	ret
    7f65:	66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
    7f6c:	00 00 00 00 

0000000000007f70 <tp_value>:
    7f70:	55                   	push   %rbp
    7f71:	41 57                	push   %r15
    7f73:	41 56                	push   %r14
    7f75:	41 55                	push   %r13
    7f77:	41 54                	push   %r12
    7f79:	53                   	push   %rbx
    7f7a:	48 81 ec a8 01 00 00 	sub    $0x1a8,%rsp
    7f81:	48 89 cd             	mov    %rcx,%rbp
    7f84:	49 89 f6             	mov    %rsi,%r14
    7f87:	49 89 ff             	mov    %rdi,%r15
    7f8a:	85 d2                	test   %edx,%edx
    7f8c:	74 4c                	je     7fda <tp_value+0x6a>
    7f8e:	41 83 3e 0c          	cmpl   $0xc,(%r14)
    7f92:	75 46                	jne    7fda <tp_value+0x6a>
    7f94:	4d 8b 77 08          	mov    0x8(%r15),%r14
    7f98:	49 8b 47 10          	mov    0x10(%r15),%rax
    7f9c:	4d 8b 27             	mov    (%r15),%r12
    7f9f:	49 01 c4             	add    %rax,%r12
    7fa2:	49 29 c6             	sub    %rax,%r14
    7fa5:	4c 89 e7             	mov    %r12,%rdi
    7fa8:	4c 89 f6             	mov    %r14,%rsi
    7fab:	e8 a0 f7 ff ff       	call   7750 <fwp_valid_utf8>
    7fb0:	85 c0                	test   %eax,%eax
    7fb2:	0f 84 e9 07 00 00    	je     87a1 <tp_value+0x831>
    7fb8:	4c 89 e7             	mov    %r12,%rdi
    7fbb:	4c 89 f6             	mov    %r14,%rsi
    7fbe:	e8 ed f8 ff ff       	call   78b0 <fwp_str_new>
    7fc3:	48 89 45 00          	mov    %rax,0x0(%rbp)
    7fc7:	49 8b 47 08          	mov    0x8(%r15),%rax
    7fcb:	49 89 47 10          	mov    %rax,0x10(%r15)
    7fcf:	41 bc 01 00 00 00    	mov    $0x1,%r12d
    7fd5:	e9 ca 07 00 00       	jmp    87a4 <tp_value+0x834>
    7fda:	41 89 d5             	mov    %edx,%r13d
    7fdd:	4c 89 ff             	mov    %r15,%rdi
    7fe0:	e8 bb 08 00 00       	call   88a0 <tp_ws>
    7fe5:	41 8b 06             	mov    (%r14),%eax
    7fe8:	45 31 e4             	xor    %r12d,%r12d
    7feb:	48 83 f8 15          	cmp    $0x15,%rax
    7fef:	0f 87 af 07 00 00    	ja     87a4 <tp_value+0x834>
    7ff5:	48 8d 0d dc 51 00 00 	lea    0x51dc(%rip),%rcx        # d1d8 <_IO_stdin_used+0x1d8>
    7ffc:	48 63 14 81          	movslq (%rcx,%rax,4),%rdx
    8000:	48 01 ca             	add    %rcx,%rdx
    8003:	ff e2                	jmp    *%rdx
    8005:	4c 89 ff             	mov    %r15,%rdi
    8008:	4c 89 f6             	mov    %r14,%rsi
    800b:	48 89 ea             	mov    %rbp,%rdx
    800e:	48 81 c4 a8 01 00 00 	add    $0x1a8,%rsp
    8015:	5b                   	pop    %rbx
    8016:	41 5c                	pop    %r12
    8018:	41 5d                	pop    %r13
    801a:	41 5e                	pop    %r14
    801c:	41 5f                	pop    %r15
    801e:	5d                   	pop    %rbp
    801f:	e9 cc 08 00 00       	jmp    88f0 <tp_int>
    8024:	41 0f 10 46 38       	movups 0x38(%r14),%xmm0
    8029:	0f 29 44 24 20       	movaps %xmm0,0x20(%rsp)
    802e:	31 c9                	xor    %ecx,%ecx
    8030:	83 f8 13             	cmp    $0x13,%eax
    8033:	0f 94 c1             	sete   %cl
    8036:	0f 57 c0             	xorps  %xmm0,%xmm0
    8039:	0f 29 44 24 30       	movaps %xmm0,0x30(%rsp)
    803e:	48 c7 44 24 40 00 00 	movq   $0x0,0x40(%rsp)
    8045:	00 00 
    8047:	89 4c 24 48          	mov    %ecx,0x48(%rsp)
    804b:	48 8d 05 1e 62 00 00 	lea    0x621e(%rip),%rax        # e270 <exec_in_fp0+0xc30>
    8052:	48 8d 35 1b 62 00 00 	lea    0x621b(%rip),%rsi        # e274 <exec_in_fp0+0xc34>
    8059:	48 0f 44 f0          	cmove  %rax,%rsi
    805d:	4c 89 ff             	mov    %r15,%rdi
    8060:	e8 fb 0b 00 00       	call   8c60 <tp_eat>
    8065:	45 31 e4             	xor    %r12d,%r12d
    8068:	85 c0                	test   %eax,%eax
    806a:	0f 84 34 07 00 00    	je     87a4 <tp_value+0x834>
    8070:	48 8d 35 d3 62 00 00 	lea    0x62d3(%rip),%rsi        # e34a <exec_in_fp0+0xd0a>
    8077:	48 8d 15 e6 55 00 00 	lea    0x55e6(%rip),%rdx        # d664 <exec_in_fp0+0x24>
    807e:	48 8d 0d 7b 0e 00 00 	lea    0xe7b(%rip),%rcx        # 8f00 <tp_kv_item>
    8085:	4c 8d 44 24 20       	lea    0x20(%rsp),%r8
    808a:	4c 89 ff             	mov    %r15,%rdi
    808d:	e8 2e 0c 00 00       	call   8cc0 <tp_list_of>
    8092:	85 c0                	test   %eax,%eax
    8094:	0f 84 a1 03 00 00    	je     843b <tp_value+0x4cb>
    809a:	48 83 7c 24 38 00    	cmpq   $0x0,0x38(%rsp)
    80a0:	0f 84 2b 05 00 00    	je     85d1 <tp_value+0x661>
    80a6:	48 8d 05 23 cd 01 00 	lea    0x1cd23(%rip),%rax        # 24dd0 <fwp_empty_map>
    80ad:	31 db                	xor    %ebx,%ebx
    80af:	90                   	nop
    80b0:	48 8b 4c 24 30       	mov    0x30(%rsp),%rcx
    80b5:	48 8b 3c d9          	mov    (%rcx,%rbx,8),%rdi
    80b9:	48 8b 74 d9 08       	mov    0x8(%rcx,%rbx,8),%rsi
    80be:	49 8b 4e 38          	mov    0x38(%r14),%rcx
    80c2:	48 89 c2             	mov    %rax,%rdx
    80c5:	e8 d6 0e 00 00       	call   8fa0 <fwp_p_map_insert>
    80ca:	48 83 c3 02          	add    $0x2,%rbx
    80ce:	48 3b 5c 24 38       	cmp    0x38(%rsp),%rbx
    80d3:	72 db                	jb     80b0 <tp_value+0x140>
    80d5:	e9 fe 04 00 00       	jmp    85d8 <tp_value+0x668>
    80da:	0f 57 c0             	xorps  %xmm0,%xmm0
    80dd:	0f 11 44 24 38       	movups %xmm0,0x38(%rsp)
    80e2:	0f 11 44 24 28       	movups %xmm0,0x28(%rsp)
    80e7:	48 c7 44 24 48 00 00 	movq   $0x0,0x48(%rsp)
    80ee:	00 00 
    80f0:	49 8b 4e 38          	mov    0x38(%r14),%rcx
    80f4:	48 89 4c 24 20       	mov    %rcx,0x20(%rsp)
    80f9:	83 f8 11             	cmp    $0x11,%eax
    80fc:	75 17                	jne    8115 <tp_value+0x1a5>
    80fe:	48 8d 35 65 61 00 00 	lea    0x6165(%rip),%rsi        # e26a <exec_in_fp0+0xc2a>
    8105:	4c 89 ff             	mov    %r15,%rdi
    8108:	e8 53 0b 00 00       	call   8c60 <tp_eat>
    810d:	85 c0                	test   %eax,%eax
    810f:	0f 84 8c 06 00 00    	je     87a1 <tp_value+0x831>
    8115:	48 8d 35 1a 62 00 00 	lea    0x621a(%rip),%rsi        # e336 <exec_in_fp0+0xcf6>
    811c:	48 8d 15 96 55 00 00 	lea    0x5596(%rip),%rdx        # d6b9 <exec_in_fp0+0x79>
    8123:	48 8d 0d e6 0c 00 00 	lea    0xce6(%rip),%rcx        # 8e10 <tp_elem_item>
    812a:	4c 8d 44 24 20       	lea    0x20(%rsp),%r8
    812f:	4c 89 ff             	mov    %r15,%rdi
    8132:	e8 89 0b 00 00       	call   8cc0 <tp_list_of>
    8137:	48 8b 7c 24 30       	mov    0x30(%rsp),%rdi
    813c:	85 c0                	test   %eax,%eax
    813e:	0f 84 06 03 00 00    	je     844a <tp_value+0x4da>
    8144:	48 8b 74 24 38       	mov    0x38(%rsp),%rsi
    8149:	e8 42 f5 ff ff       	call   7690 <fwp_list_from>
    814e:	49 89 c7             	mov    %rax,%r15
    8151:	48 8b 7c 24 30       	mov    0x30(%rsp),%rdi
    8156:	e8 c5 d5 ff ff       	call   5720 <fwp_mem_free>
    815b:	41 83 3e 11          	cmpl   $0x11,(%r14)
    815f:	75 0b                	jne    816c <tp_value+0x1fc>
    8161:	4c 89 ff             	mov    %r15,%rdi
    8164:	e8 e7 0c 00 00       	call   8e50 <fwp_p_array_from_list>
    8169:	49 89 c7             	mov    %rax,%r15
    816c:	4c 89 7d 00          	mov    %r15,0x0(%rbp)
    8170:	e9 5a fe ff ff       	jmp    7fcf <tp_value+0x5f>
    8175:	4c 89 ff             	mov    %r15,%rdi
    8178:	4c 89 f6             	mov    %r14,%rsi
    817b:	48 89 ea             	mov    %rbp,%rdx
    817e:	48 81 c4 a8 01 00 00 	add    $0x1a8,%rsp
    8185:	5b                   	pop    %rbx
    8186:	41 5c                	pop    %r12
    8188:	41 5d                	pop    %r13
    818a:	41 5e                	pop    %r14
    818c:	41 5f                	pop    %r15
    818e:	5d                   	pop    %rbp
    818f:	e9 bc 07 00 00       	jmp    8950 <tp_float>
    8194:	45 85 ed             	test   %r13d,%r13d
    8197:	0f 85 f7 fd ff ff    	jne    7f94 <tp_value+0x24>
    819d:	4c 89 ff             	mov    %r15,%rdi
    81a0:	48 89 ee             	mov    %rbp,%rsi
    81a3:	48 81 c4 a8 01 00 00 	add    $0x1a8,%rsp
    81aa:	5b                   	pop    %rbx
    81ab:	41 5c                	pop    %r12
    81ad:	41 5d                	pop    %r13
    81af:	41 5e                	pop    %r14
    81b1:	41 5f                	pop    %r15
    81b3:	5d                   	pop    %rbp
    81b4:	e9 57 08 00 00       	jmp    8a10 <tp_quoted>
    81b9:	0f 57 c0             	xorps  %xmm0,%xmm0
    81bc:	0f 29 44 24 40       	movaps %xmm0,0x40(%rsp)
    81c1:	0f 29 44 24 30       	movaps %xmm0,0x30(%rsp)
    81c6:	0f 29 44 24 20       	movaps %xmm0,0x20(%rsp)
    81cb:	48 8d 35 8c 60 00 00 	lea    0x608c(%rip),%rsi        # e25e <exec_in_fp0+0xc1e>
    81d2:	4c 89 ff             	mov    %r15,%rdi
    81d5:	e8 86 0a 00 00       	call   8c60 <tp_eat>
    81da:	45 31 e4             	xor    %r12d,%r12d
    81dd:	85 c0                	test   %eax,%eax
    81df:	0f 84 6f 02 00 00    	je     8454 <tp_value+0x4e4>
    81e5:	48 8d 35 4a 61 00 00 	lea    0x614a(%rip),%rsi        # e336 <exec_in_fp0+0xcf6>
    81ec:	48 8d 15 c6 54 00 00 	lea    0x54c6(%rip),%rdx        # d6b9 <exec_in_fp0+0x79>
    81f3:	48 8d 0d 46 0b 00 00 	lea    0xb46(%rip),%rcx        # 8d40 <tp_byte_item>
    81fa:	4c 8d 44 24 20       	lea    0x20(%rsp),%r8
    81ff:	4c 89 ff             	mov    %r15,%rdi
    8202:	e8 b9 0a 00 00       	call   8cc0 <tp_list_of>
    8207:	85 c0                	test   %eax,%eax
    8209:	0f 84 2c 02 00 00    	je     843b <tp_value+0x4cb>
    820f:	0f 57 c0             	xorps  %xmm0,%xmm0
    8212:	0f 29 84 24 20 01 00 	movaps %xmm0,0x120(%rsp)
    8219:	00 
    821a:	48 c7 84 24 30 01 00 	movq   $0x0,0x130(%rsp)
    8221:	00 00 00 00 00 
    8226:	48 83 7c 24 38 00    	cmpq   $0x0,0x38(%rsp)
    822c:	74 2d                	je     825b <tp_value+0x2eb>
    822e:	31 db                	xor    %ebx,%ebx
    8230:	4c 8d b4 24 20 01 00 	lea    0x120(%rsp),%r14
    8237:	00 
    8238:	0f 1f 84 00 00 00 00 	nopl   0x0(%rax,%rax,1)
    823f:	00 
    8240:	48 8b 44 24 30       	mov    0x30(%rsp),%rax
    8245:	0f be 34 d8          	movsbl (%rax,%rbx,8),%esi
    8249:	4c 89 f7             	mov    %r14,%rdi
    824c:	e8 9f f6 ff ff       	call   78f0 <buf_putc>
    8251:	48 ff c3             	inc    %rbx
    8254:	48 3b 5c 24 38       	cmp    0x38(%rsp),%rbx
    8259:	72 e5                	jb     8240 <tp_value+0x2d0>
    825b:	48 8b 7c 24 30       	mov    0x30(%rsp),%rdi
    8260:	e8 bb d4 ff ff       	call   5720 <fwp_mem_free>
    8265:	48 8d bc 24 20 01 00 	lea    0x120(%rsp),%rdi
    826c:	00 
    826d:	e8 0e f7 ff ff       	call   7980 <buf_to_str>
    8272:	48 89 45 00          	mov    %rax,0x0(%rbp)
    8276:	e9 54 fd ff ff       	jmp    7fcf <tp_value+0x5f>
    827b:	48 8d 74 24 20       	lea    0x20(%rsp),%rsi
    8280:	ba 00 01 00 00       	mov    $0x100,%edx
    8285:	4c 89 ff             	mov    %r15,%rdi
    8288:	e8 f3 0a 00 00       	call   8d80 <tp_token>
    828d:	45 31 e4             	xor    %r12d,%r12d
    8290:	48 83 f8 02          	cmp    $0x2,%rax
    8294:	0f 82 0a 05 00 00    	jb     87a4 <tp_value+0x834>
    829a:	80 7c 24 20 30       	cmpb   $0x30,0x20(%rsp)
    829f:	0f 85 ff 04 00 00    	jne    87a4 <tp_value+0x834>
    82a5:	80 7c 24 21 74       	cmpb   $0x74,0x21(%rsp)
    82aa:	0f 85 f4 04 00 00    	jne    87a4 <tp_value+0x834>
    82b0:	48 8d 48 fe          	lea    -0x2(%rax),%rcx
    82b4:	49 63 56 48          	movslq 0x48(%r14),%rdx
    82b8:	48 39 d1             	cmp    %rdx,%rcx
    82bb:	0f 87 e3 04 00 00    	ja     87a4 <tp_value+0x834>
    82c1:	48 83 f8 03          	cmp    $0x3,%rax
    82c5:	0f 82 21 05 00 00    	jb     87ec <tp_value+0x87c>
    82cb:	ba 02 00 00 00       	mov    $0x2,%edx
    82d0:	31 c9                	xor    %ecx,%ecx
    82d2:	e9 3d 01 00 00       	jmp    8414 <tp_value+0x4a4>
    82d7:	48 8d 74 24 20       	lea    0x20(%rsp),%rsi
    82dc:	ba 10 00 00 00       	mov    $0x10,%edx
    82e1:	4c 89 ff             	mov    %r15,%rdi
    82e4:	e8 97 0a 00 00       	call   8d80 <tp_token>
    82e9:	8b 44 24 20          	mov    0x20(%rsp),%eax
    82ed:	89 c1                	mov    %eax,%ecx
    82ef:	81 f1 2b 31 00 00    	xor    $0x312b,%ecx
    82f5:	0f b6 54 24 22       	movzbl 0x22(%rsp),%edx
    82fa:	66 09 ca             	or     %cx,%dx
    82fd:	41 bc 01 00 00 00    	mov    $0x1,%r12d
    8303:	74 2d                	je     8332 <tp_value+0x3c2>
    8305:	66 83 f8 31          	cmp    $0x31,%ax
    8309:	74 27                	je     8332 <tp_value+0x3c2>
    830b:	45 31 e4             	xor    %r12d,%r12d
    830e:	66 83 f8 30          	cmp    $0x30,%ax
    8312:	74 1e                	je     8332 <tp_value+0x3c2>
    8314:	b8 2d 31 00 00       	mov    $0x312d,%eax
    8319:	33 44 24 20          	xor    0x20(%rsp),%eax
    831d:	0f b6 4c 24 22       	movzbl 0x22(%rsp),%ecx
    8322:	66 09 c1             	or     %ax,%cx
    8325:	0f 85 79 04 00 00    	jne    87a4 <tp_value+0x834>
    832b:	49 c7 c4 ff ff ff ff 	mov    $0xffffffffffffffff,%r12
    8332:	4c 89 65 00          	mov    %r12,0x0(%rbp)
    8336:	e9 94 fc ff ff       	jmp    7fcf <tp_value+0x5f>
    833b:	49 8b 7e 08          	mov    0x8(%r14),%rdi
    833f:	48 85 ff             	test   %rdi,%rdi
    8342:	0f 84 18 01 00 00    	je     8460 <tp_value+0x4f0>
    8348:	48 8d 35 29 5f 00 00 	lea    0x5f29(%rip),%rsi        # e278 <exec_in_fp0+0xc38>
    834f:	e8 7c 9f ff ff       	call   22d0 <strcmp@plt>
    8354:	85 c0                	test   %eax,%eax
    8356:	0f 84 23 03 00 00    	je     867f <tp_value+0x70f>
    835c:	4c 89 ff             	mov    %r15,%rdi
    835f:	e8 3c 05 00 00       	call   88a0 <tp_ws>
    8364:	4d 8b 6e 08          	mov    0x8(%r14),%r13
    8368:	4c 89 ef             	mov    %r13,%rdi
    836b:	e8 00 9e ff ff       	call   2170 <strlen@plt>
    8370:	49 89 c4             	mov    %rax,%r12
    8373:	49 8b 47 08          	mov    0x8(%r15),%rax
    8377:	49 8b 5f 10          	mov    0x10(%r15),%rbx
    837b:	48 29 d8             	sub    %rbx,%rax
    837e:	4c 39 e0             	cmp    %r12,%rax
    8381:	0f 82 c4 01 00 00    	jb     854b <tp_value+0x5db>
    8387:	49 8b 3f             	mov    (%r15),%rdi
    838a:	48 01 df             	add    %rbx,%rdi
    838d:	4c 89 ee             	mov    %r13,%rsi
    8390:	4c 89 e2             	mov    %r12,%rdx
    8393:	e8 d8 9f ff ff       	call   2370 <bcmp@plt>
    8398:	85 c0                	test   %eax,%eax
    839a:	0f 85 ab 01 00 00    	jne    854b <tp_value+0x5db>
    83a0:	4c 01 e3             	add    %r12,%rbx
    83a3:	49 89 5f 10          	mov    %rbx,0x10(%r15)
    83a7:	e9 9f 01 00 00       	jmp    854b <tp_value+0x5db>
    83ac:	48 89 2c 24          	mov    %rbp,(%rsp)
    83b0:	48 8d 74 24 20       	lea    0x20(%rsp),%rsi
    83b5:	4c 89 ff             	mov    %r15,%rdi
    83b8:	e8 d3 0e 00 00       	call   9290 <tp_ident>
    83bd:	41 8b 5e 10          	mov    0x10(%r14),%ebx
    83c1:	85 db                	test   %ebx,%ebx
    83c3:	4c 89 74 24 08       	mov    %r14,0x8(%rsp)
    83c8:	0f 8e 9c 01 00 00    	jle    856a <tp_value+0x5fa>
    83ce:	4d 8b 66 18          	mov    0x18(%r14),%r12
    83d2:	bd ff ff ff ff       	mov    $0xffffffff,%ebp
    83d7:	45 31 f6             	xor    %r14d,%r14d
    83da:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)
    83e0:	4b 8b 3c f4          	mov    (%r12,%r14,8),%rdi
    83e4:	48 8d 74 24 20       	lea    0x20(%rsp),%rsi
    83e9:	e8 e2 9e ff ff       	call   22d0 <strcmp@plt>
    83ee:	85 c0                	test   %eax,%eax
    83f0:	41 0f 44 ee          	cmove  %r14d,%ebp
    83f4:	49 ff c6             	inc    %r14
    83f7:	4c 39 f3             	cmp    %r14,%rbx
    83fa:	75 e4                	jne    83e0 <tp_value+0x470>
    83fc:	e9 6e 01 00 00       	jmp    856f <tp_value+0x5ff>
    8401:	48 8d 0c 49          	lea    (%rcx,%rcx,2),%rcx
    8405:	48 ff c9             	dec    %rcx
    8408:	48 ff c2             	inc    %rdx
    840b:	48 39 d0             	cmp    %rdx,%rax
    840e:	0f 84 da 03 00 00    	je     87ee <tp_value+0x87e>
    8414:	0f b6 74 14 20       	movzbl 0x20(%rsp,%rdx,1),%esi
    8419:	83 fe 30             	cmp    $0x30,%esi
    841c:	74 17                	je     8435 <tp_value+0x4c5>
    841e:	83 fe 2d             	cmp    $0x2d,%esi
    8421:	74 de                	je     8401 <tp_value+0x491>
    8423:	83 fe 2b             	cmp    $0x2b,%esi
    8426:	0f 85 75 03 00 00    	jne    87a1 <tp_value+0x831>
    842c:	48 8d 0c 49          	lea    (%rcx,%rcx,2),%rcx
    8430:	48 ff c1             	inc    %rcx
    8433:	eb d3                	jmp    8408 <tp_value+0x498>
    8435:	48 8d 0c 49          	lea    (%rcx,%rcx,2),%rcx
    8439:	eb cd                	jmp    8408 <tp_value+0x498>
    843b:	48 8b 7c 24 30       	mov    0x30(%rsp),%rdi
    8440:	e8 db d2 ff ff       	call   5720 <fwp_mem_free>
    8445:	e9 5a 03 00 00       	jmp    87a4 <tp_value+0x834>
    844a:	e8 d1 d2 ff ff       	call   5720 <fwp_mem_free>
    844f:	e9 4d 03 00 00       	jmp    87a1 <tp_value+0x831>
    8454:	31 ff                	xor    %edi,%edi
    8456:	e8 c5 d2 ff ff       	call   5720 <fwp_mem_free>
    845b:	e9 44 03 00 00       	jmp    87a4 <tp_value+0x834>
    8460:	49 63 7e 10          	movslq 0x10(%r14),%rdi
    8464:	48 85 ff             	test   %rdi,%rdi
    8467:	0f 84 4c 03 00 00    	je     87b9 <tp_value+0x849>
    846d:	41 83 7e 48 00       	cmpl   $0x0,0x48(%r14)
    8472:	0f 84 d3 00 00 00    	je     854b <tp_value+0x5db>
    8478:	48 c1 e7 03          	shl    $0x3,%rdi
    847c:	e8 2f d1 ff ff       	call   55b0 <fwp_alloc>
    8481:	48 89 c3             	mov    %rax,%rbx
    8484:	48 8d 35 fd 5d 00 00 	lea    0x5dfd(%rip),%rsi        # e288 <exec_in_fp0+0xc48>
    848b:	4c 89 ff             	mov    %r15,%rdi
    848e:	e8 cd 07 00 00       	call   8c60 <tp_eat>
    8493:	85 c0                	test   %eax,%eax
    8495:	0f 84 09 03 00 00    	je     87a4 <tp_value+0x834>
    849b:	48 89 2c 24          	mov    %rbp,(%rsp)
    849f:	41 83 7e 10 00       	cmpl   $0x0,0x10(%r14)
    84a4:	7e 77                	jle    851d <tp_value+0x5ad>
    84a6:	49 8b 46 20          	mov    0x20(%r14),%rax
    84aa:	48 8b 30             	mov    (%rax),%rsi
    84ad:	4c 89 ff             	mov    %r15,%rdi
    84b0:	31 d2                	xor    %edx,%edx
    84b2:	48 89 d9             	mov    %rbx,%rcx
    84b5:	e8 b6 fa ff ff       	call   7f70 <tp_value>
    84ba:	85 c0                	test   %eax,%eax
    84bc:	0f 84 df 02 00 00    	je     87a1 <tp_value+0x831>
    84c2:	41 83 7e 10 02       	cmpl   $0x2,0x10(%r14)
    84c7:	7c 54                	jl     851d <tp_value+0x5ad>
    84c9:	48 89 dd             	mov    %rbx,%rbp
    84cc:	48 83 c5 08          	add    $0x8,%rbp
    84d0:	41 bd 01 00 00 00    	mov    $0x1,%r13d
    84d6:	4c 89 ff             	mov    %r15,%rdi
    84d9:	48 8d 35 aa 5d 00 00 	lea    0x5daa(%rip),%rsi        # e28a <exec_in_fp0+0xc4a>
    84e0:	e8 7b 07 00 00       	call   8c60 <tp_eat>
    84e5:	85 c0                	test   %eax,%eax
    84e7:	0f 84 b4 02 00 00    	je     87a1 <tp_value+0x831>
    84ed:	49 8b 46 20          	mov    0x20(%r14),%rax
    84f1:	4a 8b 34 e8          	mov    (%rax,%r13,8),%rsi
    84f5:	45 31 e4             	xor    %r12d,%r12d
    84f8:	4c 89 ff             	mov    %r15,%rdi
    84fb:	31 d2                	xor    %edx,%edx
    84fd:	48 89 e9             	mov    %rbp,%rcx
    8500:	e8 6b fa ff ff       	call   7f70 <tp_value>
    8505:	85 c0                	test   %eax,%eax
    8507:	0f 84 97 02 00 00    	je     87a4 <tp_value+0x834>
    850d:	49 ff c5             	inc    %r13
    8510:	49 63 46 10          	movslq 0x10(%r14),%rax
    8514:	48 83 c5 08          	add    $0x8,%rbp
    8518:	49 39 c5             	cmp    %rax,%r13
    851b:	7c b9                	jl     84d6 <tp_value+0x566>
    851d:	48 8d 35 29 5e 00 00 	lea    0x5e29(%rip),%rsi        # e34d <exec_in_fp0+0xd0d>
    8524:	4c 89 ff             	mov    %r15,%rdi
    8527:	e8 34 07 00 00       	call   8c60 <tp_eat>
    852c:	41 bc 00 00 00 00    	mov    $0x0,%r12d
    8532:	85 c0                	test   %eax,%eax
    8534:	0f 84 6a 02 00 00    	je     87a4 <tp_value+0x834>
    853a:	41 8b 7e 10          	mov    0x10(%r14),%edi
    853e:	48 89 de             	mov    %rbx,%rsi
    8541:	e8 aa a9 ff ff       	call   2ef0 <fwp_record>
    8546:	e9 28 01 00 00       	jmp    8673 <tp_value+0x703>
    854b:	4c 89 ff             	mov    %r15,%rdi
    854e:	4c 89 f6             	mov    %r14,%rsi
    8551:	48 89 ea             	mov    %rbp,%rdx
    8554:	48 81 c4 a8 01 00 00 	add    $0x1a8,%rsp
    855b:	5b                   	pop    %rbx
    855c:	41 5c                	pop    %r12
    855e:	41 5d                	pop    %r13
    8560:	41 5e                	pop    %r14
    8562:	41 5f                	pop    %r15
    8564:	5d                   	pop    %rbp
    8565:	e9 56 0b 00 00       	jmp    90c0 <tp_record_body>
    856a:	bd ff ff ff ff       	mov    $0xffffffff,%ebp
    856f:	45 85 ed             	test   %r13d,%r13d
    8572:	74 7a                	je     85ee <tp_value+0x67e>
    8574:	85 ed                	test   %ebp,%ebp
    8576:	48 8b 5c 24 08       	mov    0x8(%rsp),%rbx
    857b:	79 76                	jns    85f3 <tp_value+0x683>
    857d:	48 8b 7b 08          	mov    0x8(%rbx),%rdi
    8581:	45 31 e4             	xor    %r12d,%r12d
    8584:	48 85 ff             	test   %rdi,%rdi
    8587:	0f 84 17 02 00 00    	je     87a4 <tp_value+0x834>
    858d:	48 8d 35 c2 5c 00 00 	lea    0x5cc2(%rip),%rsi        # e256 <exec_in_fp0+0xc16>
    8594:	e8 37 9d ff ff       	call   22d0 <strcmp@plt>
    8599:	85 c0                	test   %eax,%eax
    859b:	0f 85 03 02 00 00    	jne    87a4 <tp_value+0x834>
    85a1:	8b 44 24 20          	mov    0x20(%rsp),%eax
    85a5:	89 c1                	mov    %eax,%ecx
    85a7:	81 f1 74 72 75 65    	xor    $0x65757274,%ecx
    85ad:	0f b6 54 24 24       	movzbl 0x24(%rsp),%edx
    85b2:	09 ca                	or     %ecx,%edx
    85b4:	b9 01 00 00 00       	mov    $0x1,%ecx
    85b9:	0f 44 e9             	cmove  %ecx,%ebp
    85bc:	35 66 61 6c 73       	xor    $0x736c6166,%eax
    85c1:	0f b7 4c 24 24       	movzwl 0x24(%rsp),%ecx
    85c6:	83 f1 65             	xor    $0x65,%ecx
    85c9:	09 c1                	or     %eax,%ecx
    85cb:	75 26                	jne    85f3 <tp_value+0x683>
    85cd:	31 ed                	xor    %ebp,%ebp
    85cf:	eb 2a                	jmp    85fb <tp_value+0x68b>
    85d1:	48 8d 05 f8 c7 01 00 	lea    0x1c7f8(%rip),%rax        # 24dd0 <fwp_empty_map>
    85d8:	48 8b 7c 24 30       	mov    0x30(%rsp),%rdi
    85dd:	48 89 c3             	mov    %rax,%rbx
    85e0:	e8 3b d1 ff ff       	call   5720 <fwp_mem_free>
    85e5:	48 89 5d 00          	mov    %rbx,0x0(%rbp)
    85e9:	e9 e1 f9 ff ff       	jmp    7fcf <tp_value+0x5f>
    85ee:	48 8b 5c 24 08       	mov    0x8(%rsp),%rbx
    85f3:	85 ed                	test   %ebp,%ebp
    85f5:	0f 88 a6 01 00 00    	js     87a1 <tp_value+0x831>
    85fb:	48 8b 43 28          	mov    0x28(%rbx),%rax
    85ff:	41 89 ed             	mov    %ebp,%r13d
    8602:	4a 63 1c a8          	movslq (%rax,%r13,4),%rbx
    8606:	48 8d 3c dd 08 00 00 	lea    0x8(,%rbx,8),%rdi
    860d:	00 
    860e:	e8 9d cf ff ff       	call   55b0 <fwp_alloc>
    8613:	48 89 c5             	mov    %rax,%rbp
    8616:	89 d8                	mov    %ebx,%eax
    8618:	48 89 44 24 10       	mov    %rax,0x10(%rsp)
    861d:	48 85 db             	test   %rbx,%rbx
    8620:	7e 41                	jle    8663 <tp_value+0x6f3>
    8622:	48 8b 44 24 10       	mov    0x10(%rsp),%rax
    8627:	48 8d 1c c5 00 00 00 	lea    0x0(,%rax,8),%rbx
    862e:	00 
    862f:	45 31 e4             	xor    %r12d,%r12d
    8632:	45 31 f6             	xor    %r14d,%r14d
    8635:	48 8b 44 24 08       	mov    0x8(%rsp),%rax
    863a:	48 8b 40 30          	mov    0x30(%rax),%rax
    863e:	4a 8b 04 e8          	mov    (%rax,%r13,8),%rax
    8642:	4a 8b 34 30          	mov    (%rax,%r14,1),%rsi
    8646:	49 8d 14 2e          	lea    (%r14,%rbp,1),%rdx
    864a:	4c 89 ff             	mov    %r15,%rdi
    864d:	e8 fe 0c 00 00       	call   9350 <tp_atom>
    8652:	85 c0                	test   %eax,%eax
    8654:	0f 84 4a 01 00 00    	je     87a4 <tp_value+0x834>
    865a:	49 83 c6 08          	add    $0x8,%r14
    865e:	4c 39 f3             	cmp    %r14,%rbx
    8661:	75 d2                	jne    8635 <tp_value+0x6c5>
    8663:	44 89 ef             	mov    %r13d,%edi
    8666:	48 8b 74 24 10       	mov    0x10(%rsp),%rsi
    866b:	48 89 ea             	mov    %rbp,%rdx
    866e:	e8 8d a8 ff ff       	call   2f00 <fwp_data>
    8673:	48 8b 0c 24          	mov    (%rsp),%rcx
    8677:	48 89 01             	mov    %rax,(%rcx)
    867a:	e9 50 f9 ff ff       	jmp    7fcf <tp_value+0x5f>
    867f:	48 89 2c 24          	mov    %rbp,(%rsp)
    8683:	48 8d 74 24 20       	lea    0x20(%rsp),%rsi
    8688:	ba 80 00 00 00       	mov    $0x80,%edx
    868d:	4c 89 ff             	mov    %r15,%rdi
    8690:	48 89 f3             	mov    %rsi,%rbx
    8693:	e8 e8 06 00 00       	call   8d80 <tp_token>
    8698:	49 89 c7             	mov    %rax,%r15
    869b:	4c 8d 24 04          	lea    (%rsp,%rax,1),%r12
    869f:	49 83 c4 20          	add    $0x20,%r12
    86a3:	41 be 08 00 00 00    	mov    $0x8,%r14d
    86a9:	eb 0e                	jmp    86b9 <tp_value+0x749>
    86ab:	49 83 c6 10          	add    $0x10,%r14
    86af:	49 83 fe 68          	cmp    $0x68,%r14
    86b3:	0f 84 e8 00 00 00    	je     87a1 <tp_value+0x831>
    86b9:	48 8d 05 e0 a5 00 00 	lea    0xa5e0(%rip),%rax        # 12ca0 <tp_value.units>
    86c0:	49 8b 6c 06 f8       	mov    -0x8(%r14,%rax,1),%rbp
    86c5:	48 89 ef             	mov    %rbp,%rdi
    86c8:	e8 a3 9a ff ff       	call   2170 <strlen@plt>
    86cd:	4d 89 fd             	mov    %r15,%r13
    86d0:	49 29 c5             	sub    %rax,%r13
    86d3:	76 d6                	jbe    86ab <tp_value+0x73b>
    86d5:	4c 89 e7             	mov    %r12,%rdi
    86d8:	48 29 c7             	sub    %rax,%rdi
    86db:	48 89 ee             	mov    %rbp,%rsi
    86de:	e8 ed 9b ff ff       	call   22d0 <strcmp@plt>
    86e3:	85 c0                	test   %eax,%eax
    86e5:	75 c4                	jne    86ab <tp_value+0x73b>
    86e7:	48 8d ac 24 20 01 00 	lea    0x120(%rsp),%rbp
    86ee:	00 
    86ef:	48 89 ef             	mov    %rbp,%rdi
    86f2:	48 89 de             	mov    %rbx,%rsi
    86f5:	4c 89 ea             	mov    %r13,%rdx
    86f8:	e8 33 9c ff ff       	call   2330 <memcpy@plt>
    86fd:	42 c6 84 2c 20 01 00 	movb   $0x0,0x120(%rsp,%r13,1)
    8704:	00 00 
    8706:	48 89 ef             	mov    %rbp,%rdi
    8709:	4c 89 ee             	mov    %r13,%rsi
    870c:	e8 6f 09 00 00       	call   9080 <fwp_valid_int>
    8711:	85 c0                	test   %eax,%eax
    8713:	74 96                	je     86ab <tp_value+0x73b>
    8715:	0f b6 b4 24 20 01 00 	movzbl 0x120(%rsp),%esi
    871c:	00 
    871d:	8d 4e d5             	lea    -0x2b(%rsi),%ecx
    8720:	31 c0                	xor    %eax,%eax
    8722:	f6 c1 fd             	test   $0xfd,%cl
    8725:	0f 94 c0             	sete   %al
    8728:	44 0f b6 94 04 20 01 	movzbl 0x120(%rsp,%rax,1),%r10d
    872f:	00 00 
    8731:	45 31 e4             	xor    %r12d,%r12d
    8734:	45 84 d2             	test   %r10b,%r10b
    8737:	0f 84 ba 00 00 00    	je     87f7 <tp_value+0x887>
    873d:	48 8d 8c 24 20 01 00 	lea    0x120(%rsp),%rcx
    8744:	00 
    8745:	48 01 c1             	add    %rax,%rcx
    8748:	48 ff c1             	inc    %rcx
    874b:	31 c0                	xor    %eax,%eax
    874d:	bf 0a 00 00 00       	mov    $0xa,%edi
    8752:	49 b9 00 00 00 00 00 	movabs $0x8000000000000000,%r9
    8759:	00 00 80 
    875c:	45 31 c0             	xor    %r8d,%r8d
    875f:	48 8b 1c 24          	mov    (%rsp),%rbx
    8763:	48 f7 e7             	mul    %rdi
    8766:	4f 8d 04 80          	lea    (%r8,%r8,4),%r8
    876a:	4a 8d 14 42          	lea    (%rdx,%r8,2),%rdx
    876e:	45 0f be c2          	movsbl %r10b,%r8d
    8772:	41 83 c0 d0          	add    $0xffffffd0,%r8d
    8776:	4d 63 d0             	movslq %r8d,%r10
    8779:	4d 89 d0             	mov    %r10,%r8
    877c:	49 c1 f8 3f          	sar    $0x3f,%r8
    8780:	4c 01 d0             	add    %r10,%rax
    8783:	49 11 d0             	adc    %rdx,%r8
    8786:	49 39 c1             	cmp    %rax,%r9
    8789:	ba 00 00 00 00       	mov    $0x0,%edx
    878e:	4c 19 c2             	sbb    %r8,%rdx
    8791:	7c 0e                	jl     87a1 <tp_value+0x831>
    8793:	44 0f b6 11          	movzbl (%rcx),%r10d
    8797:	48 ff c1             	inc    %rcx
    879a:	45 84 d2             	test   %r10b,%r10b
    879d:	75 c4                	jne    8763 <tp_value+0x7f3>
    879f:	eb 5f                	jmp    8800 <tp_value+0x890>
    87a1:	45 31 e4             	xor    %r12d,%r12d
    87a4:	44 89 e0             	mov    %r12d,%eax
    87a7:	48 81 c4 a8 01 00 00 	add    $0x1a8,%rsp
    87ae:	5b                   	pop    %rbx
    87af:	41 5c                	pop    %r12
    87b1:	41 5d                	pop    %r13
    87b3:	41 5e                	pop    %r14
    87b5:	41 5f                	pop    %r15
    87b7:	5d                   	pop    %rbp
    87b8:	c3                   	ret
    87b9:	48 8d 35 c8 5a 00 00 	lea    0x5ac8(%rip),%rsi        # e288 <exec_in_fp0+0xc48>
    87c0:	4c 89 ff             	mov    %r15,%rdi
    87c3:	e8 98 04 00 00       	call   8c60 <tp_eat>
    87c8:	85 c0                	test   %eax,%eax
    87ca:	74 d8                	je     87a4 <tp_value+0x834>
    87cc:	48 8d 35 7a 5b 00 00 	lea    0x5b7a(%rip),%rsi        # e34d <exec_in_fp0+0xd0d>
    87d3:	4c 89 ff             	mov    %r15,%rdi
    87d6:	e8 85 04 00 00       	call   8c60 <tp_eat>
    87db:	85 c0                	test   %eax,%eax
    87dd:	74 c5                	je     87a4 <tp_value+0x834>
    87df:	48 c7 45 00 00 00 00 	movq   $0x0,0x0(%rbp)
    87e6:	00 
    87e7:	e9 e3 f7 ff ff       	jmp    7fcf <tp_value+0x5f>
    87ec:	31 c9                	xor    %ecx,%ecx
    87ee:	48 89 4d 00          	mov    %rcx,0x0(%rbp)
    87f2:	e9 d8 f7 ff ff       	jmp    7fcf <tp_value+0x5f>
    87f7:	31 c0                	xor    %eax,%eax
    87f9:	45 31 c0             	xor    %r8d,%r8d
    87fc:	48 8b 1c 24          	mov    (%rsp),%rbx
    8800:	48 89 c1             	mov    %rax,%rcx
    8803:	48 f7 d9             	neg    %rcx
    8806:	bf 00 00 00 00       	mov    $0x0,%edi
    880b:	4c 19 c7             	sbb    %r8,%rdi
    880e:	40 80 fe 2d          	cmp    $0x2d,%sil
    8812:	49 0f 45 f8          	cmovne %r8,%rdi
    8816:	48 0f 45 c8          	cmovne %rax,%rcx
    881a:	48 b8 ff ff ff ff ff 	movabs $0x7fffffffffffffff,%rax
    8821:	ff ff 7f 
    8824:	48 39 c8             	cmp    %rcx,%rax
    8827:	b8 00 00 00 00       	mov    $0x0,%eax
    882c:	48 19 f8             	sbb    %rdi,%rax
    882f:	0f 8c 6f ff ff ff    	jl     87a4 <tp_value+0x834>
    8835:	48 8d 05 64 a4 00 00 	lea    0xa464(%rip),%rax        # 12ca0 <tp_value.units>
    883c:	49 8b 34 06          	mov    (%r14,%rax,1),%rsi
    8840:	48 89 c8             	mov    %rcx,%rax
    8843:	48 f7 e6             	mul    %rsi
    8846:	48 0f af fe          	imul   %rsi,%rdi
    884a:	48 c1 fe 3f          	sar    $0x3f,%rsi
    884e:	48 0f af f1          	imul   %rcx,%rsi
    8852:	48 01 d6             	add    %rdx,%rsi
    8855:	48 01 f7             	add    %rsi,%rdi
    8858:	48 b9 00 00 00 00 00 	movabs $0x8000000000000000,%rcx
    885f:	00 00 80 
    8862:	48 01 c1             	add    %rax,%rcx
    8865:	48 83 d7 ff          	adc    $0xffffffffffffffff,%rdi
    8869:	48 83 ff ff          	cmp    $0xffffffffffffffff,%rdi
    886d:	0f 85 31 ff ff ff    	jne    87a4 <tp_value+0x834>
    8873:	48 89 44 24 18       	mov    %rax,0x18(%rsp)
    8878:	41 bc 01 00 00 00    	mov    $0x1,%r12d
    887e:	48 8d 74 24 18       	lea    0x18(%rsp),%rsi
    8883:	bf 01 00 00 00       	mov    $0x1,%edi
    8888:	e8 63 a6 ff ff       	call   2ef0 <fwp_record>
    888d:	48 89 03             	mov    %rax,(%rbx)
    8890:	e9 0f ff ff ff       	jmp    87a4 <tp_value+0x834>
    8895:	66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
    889c:	00 00 00 00 

00000000000088a0 <tp_ws>:
    88a0:	48 8b 47 08          	mov    0x8(%rdi),%rax
    88a4:	48 8b 4f 10          	mov    0x10(%rdi),%rcx
    88a8:	48 39 c1             	cmp    %rax,%rcx
    88ab:	73 39                	jae    88e6 <tp_ws+0x46>
    88ad:	48 8b 17             	mov    (%rdi),%rdx
    88b0:	48 f7 d8             	neg    %rax
    88b3:	48 ff c1             	inc    %rcx
    88b6:	48 be 00 26 00 00 01 	movabs $0x100002600,%rsi
    88bd:	00 00 00 
    88c0:	44 0f b6 44 0a ff    	movzbl -0x1(%rdx,%rcx,1),%r8d
    88c6:	49 83 f8 20          	cmp    $0x20,%r8
    88ca:	77 1a                	ja     88e6 <tp_ws+0x46>
    88cc:	4c 0f a3 c6          	bt     %r8,%rsi
    88d0:	73 14                	jae    88e6 <tp_ws+0x46>
    88d2:	48 89 4f 10          	mov    %rcx,0x10(%rdi)
    88d6:	4c 8d 04 08          	lea    (%rax,%rcx,1),%r8
    88da:	49 ff c0             	inc    %r8
    88dd:	48 ff c1             	inc    %rcx
    88e0:	49 83 f8 01          	cmp    $0x1,%r8
    88e4:	75 da                	jne    88c0 <tp_ws+0x20>
    88e6:	c3                   	ret
    88e7:	66 0f 1f 84 00 00 00 	nopw   0x0(%rax,%rax,1)
    88ee:	00 00 

00000000000088f0 <tp_int>:
    88f0:	55                   	push   %rbp
    88f1:	41 56                	push   %r14
    88f3:	53                   	push   %rbx
    88f4:	48 81 ec 80 00 00 00 	sub    $0x80,%rsp
    88fb:	48 89 d3             	mov    %rdx,%rbx
    88fe:	49 89 f6             	mov    %rsi,%r14
    8901:	48 89 e6             	mov    %rsp,%rsi
    8904:	ba 80 00 00 00       	mov    $0x80,%edx
    8909:	e8 72 04 00 00       	call   8d80 <tp_token>
    890e:	31 ed                	xor    %ebp,%ebp
    8910:	48 83 f8 7f          	cmp    $0x7f,%rax
    8914:	77 28                	ja     893e <tp_int+0x4e>
    8916:	48 89 e7             	mov    %rsp,%rdi
    8919:	e8 d2 0a 00 00       	call   93f0 <fwp_cstr>
    891e:	41 8b 36             	mov    (%r14),%esi
    8921:	41 8b 56 48          	mov    0x48(%r14),%edx
    8925:	48 89 c7             	mov    %rax,%rdi
    8928:	e8 e3 0a 00 00       	call   9410 <fwp_p_parse_int>
    892d:	48 85 c0             	test   %rax,%rax
    8930:	74 0c                	je     893e <tp_int+0x4e>
    8932:	48 8b 40 08          	mov    0x8(%rax),%rax
    8936:	48 89 03             	mov    %rax,(%rbx)
    8939:	bd 01 00 00 00       	mov    $0x1,%ebp
    893e:	89 e8                	mov    %ebp,%eax
    8940:	48 81 c4 80 00 00 00 	add    $0x80,%rsp
    8947:	5b                   	pop    %rbx
    8948:	41 5e                	pop    %r14
    894a:	5d                   	pop    %rbp
    894b:	c3                   	ret
    894c:	0f 1f 40 00          	nopl   0x0(%rax)

0000000000008950 <tp_float>:
    8950:	41 56                	push   %r14
    8952:	53                   	push   %rbx
    8953:	48 81 ec 88 00 00 00 	sub    $0x88,%rsp
    895a:	48 89 d3             	mov    %rdx,%rbx
    895d:	49 89 f6             	mov    %rsi,%r14
    8960:	48 89 e6             	mov    %rsp,%rsi
    8963:	ba 80 00 00 00       	mov    $0x80,%edx
    8968:	e8 13 04 00 00       	call   8d80 <tp_token>
    896d:	31 c9                	xor    %ecx,%ecx
    896f:	48 83 f8 7f          	cmp    $0x7f,%rax
    8973:	0f 87 84 00 00 00    	ja     89fd <tp_float+0xad>
    8979:	8b 0c 24             	mov    (%rsp),%ecx
    897c:	81 f9 69 6e 66 00    	cmp    $0x666e69,%ecx
    8982:	75 0a                	jne    898e <tp_float+0x3e>
    8984:	f2 0f 10 05 9c 46 00 	movsd  0x469c(%rip),%xmm0        # d028 <_IO_stdin_used+0x28>
    898b:	00 
    898c:	eb 5f                	jmp    89ed <tp_float+0x9d>
    898e:	ba 2d 69 6e 66       	mov    $0x666e692d,%edx
    8993:	33 14 24             	xor    (%rsp),%edx
    8996:	0f b6 74 24 04       	movzbl 0x4(%rsp),%esi
    899b:	09 d6                	or     %edx,%esi
    899d:	74 12                	je     89b1 <tp_float+0x61>
    899f:	81 f9 4e 61 4e 00    	cmp    $0x4e614e,%ecx
    89a5:	75 14                	jne    89bb <tp_float+0x6b>
    89a7:	f2 0f 10 05 89 46 00 	movsd  0x4689(%rip),%xmm0        # d038 <_IO_stdin_used+0x38>
    89ae:	00 
    89af:	eb 3c                	jmp    89ed <tp_float+0x9d>
    89b1:	f2 0f 10 05 77 46 00 	movsd  0x4677(%rip),%xmm0        # d030 <_IO_stdin_used+0x30>
    89b8:	00 
    89b9:	eb 32                	jmp    89ed <tp_float+0x9d>
    89bb:	48 89 e7             	mov    %rsp,%rdi
    89be:	48 89 c6             	mov    %rax,%rsi
    89c1:	e8 7a 0e 00 00       	call   9840 <fwp_valid_float>
    89c6:	31 c9                	xor    %ecx,%ecx
    89c8:	85 c0                	test   %eax,%eax
    89ca:	74 31                	je     89fd <tp_float+0xad>
    89cc:	41 83 3e 0a          	cmpl   $0xa,(%r14)
    89d0:	75 11                	jne    89e3 <tp_float+0x93>
    89d2:	48 89 e7             	mov    %rsp,%rdi
    89d5:	31 f6                	xor    %esi,%esi
    89d7:	e8 24 98 ff ff       	call   2200 <strtof@plt>
    89dc:	e8 5f c4 ff ff       	call   4e40 <fwp_from_f32>
    89e1:	eb 12                	jmp    89f5 <tp_float+0xa5>
    89e3:	48 89 e7             	mov    %rsp,%rdi
    89e6:	31 f6                	xor    %esi,%esi
    89e8:	e8 13 97 ff ff       	call   2100 <strtod@plt>
    89ed:	41 8b 3e             	mov    (%r14),%edi
    89f0:	e8 3b 0f 00 00       	call   9930 <fwp_float_of>
    89f5:	48 89 03             	mov    %rax,(%rbx)
    89f8:	b9 01 00 00 00       	mov    $0x1,%ecx
    89fd:	89 c8                	mov    %ecx,%eax
    89ff:	48 81 c4 88 00 00 00 	add    $0x88,%rsp
    8a06:	5b                   	pop    %rbx
    8a07:	41 5e                	pop    %r14
    8a09:	c3                   	ret
    8a0a:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)

0000000000008a10 <tp_quoted>:
    8a10:	55                   	push   %rbp
    8a11:	41 57                	push   %r15
    8a13:	41 56                	push   %r14
    8a15:	41 55                	push   %r13
    8a17:	41 54                	push   %r12
    8a19:	53                   	push   %rbx
    8a1a:	48 83 ec 18          	sub    $0x18,%rsp
    8a1e:	49 89 f6             	mov    %rsi,%r14
    8a21:	49 89 ff             	mov    %rdi,%r15
    8a24:	e8 77 fe ff ff       	call   88a0 <tp_ws>
    8a29:	4d 8b 6f 08          	mov    0x8(%r15),%r13
    8a2d:	49 8b 6f 10          	mov    0x10(%r15),%rbp
    8a31:	31 db                	xor    %ebx,%ebx
    8a33:	4c 39 ed             	cmp    %r13,%rbp
    8a36:	0f 83 0d 02 00 00    	jae    8c49 <tp_quoted+0x239>
    8a3c:	49 8b 07             	mov    (%r15),%rax
    8a3f:	80 3c 28 22          	cmpb   $0x22,(%rax,%rbp,1)
    8a43:	0f 85 00 02 00 00    	jne    8c49 <tp_quoted+0x239>
    8a49:	48 ff c5             	inc    %rbp
    8a4c:	49 89 6f 10          	mov    %rbp,0x10(%r15)
    8a50:	0f 57 c0             	xorps  %xmm0,%xmm0
    8a53:	0f 29 04 24          	movaps %xmm0,(%rsp)
    8a57:	48 c7 44 24 10 00 00 	movq   $0x0,0x10(%rsp)
    8a5e:	00 00 
    8a60:	31 db                	xor    %ebx,%ebx
    8a62:	4c 39 ed             	cmp    %r13,%rbp
    8a65:	0f 83 8d 01 00 00    	jae    8bf8 <tp_quoted+0x1e8>
    8a6b:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)
    8a70:	4d 8b 27             	mov    (%r15),%r12
    8a73:	48 8d 4d 01          	lea    0x1(%rbp),%rcx
    8a77:	49 89 4f 10          	mov    %rcx,0x10(%r15)
    8a7b:	41 0f b6 04 2c       	movzbl (%r12,%rbp,1),%eax
    8a80:	83 f8 5c             	cmp    $0x5c,%eax
    8a83:	74 2b                	je     8ab0 <tp_quoted+0xa0>
    8a85:	83 f8 22             	cmp    $0x22,%eax
    8a88:	0f 84 8b 01 00 00    	je     8c19 <tp_quoted+0x209>
    8a8e:	0f be f0             	movsbl %al,%esi
    8a91:	48 89 e7             	mov    %rsp,%rdi
    8a94:	e8 57 ee ff ff       	call   78f0 <buf_putc>
    8a99:	4d 8b 6f 08          	mov    0x8(%r15),%r13
    8a9d:	49 8b 6f 10          	mov    0x10(%r15),%rbp
    8aa1:	4c 39 ed             	cmp    %r13,%rbp
    8aa4:	72 ca                	jb     8a70 <tp_quoted+0x60>
    8aa6:	e9 63 01 00 00       	jmp    8c0e <tp_quoted+0x1fe>
    8aab:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)
    8ab0:	4c 39 e9             	cmp    %r13,%rcx
    8ab3:	0f 83 48 01 00 00    	jae    8c01 <tp_quoted+0x1f1>
    8ab9:	48 8d 45 02          	lea    0x2(%rbp),%rax
    8abd:	49 89 47 10          	mov    %rax,0x10(%r15)
    8ac1:	41 0f b6 4c 2c 01    	movzbl 0x1(%r12,%rbp,1),%ecx
    8ac7:	8d 51 a4             	lea    -0x5c(%rcx),%edx
    8aca:	83 fa 19             	cmp    $0x19,%edx
    8acd:	77 1a                	ja     8ae9 <tp_quoted+0xd9>
    8acf:	48 8d 35 5a 47 00 00 	lea    0x475a(%rip),%rsi        # d230 <_IO_stdin_used+0x230>
    8ad6:	48 63 0c 96          	movslq (%rsi,%rdx,4),%rcx
    8ada:	48 01 f1             	add    %rsi,%rcx
    8add:	ff e1                	jmp    *%rcx
    8adf:	48 89 e7             	mov    %rsp,%rdi
    8ae2:	be 5c 00 00 00       	mov    $0x5c,%esi
    8ae7:	eb ab                	jmp    8a94 <tp_quoted+0x84>
    8ae9:	83 f9 22             	cmp    $0x22,%ecx
    8aec:	0f 84 bf 00 00 00    	je     8bb1 <tp_quoted+0x1a1>
    8af2:	83 f9 30             	cmp    $0x30,%ecx
    8af5:	0f 85 06 01 00 00    	jne    8c01 <tp_quoted+0x1f1>
    8afb:	48 89 e7             	mov    %rsp,%rdi
    8afe:	31 f6                	xor    %esi,%esi
    8b00:	eb 92                	jmp    8a94 <tp_quoted+0x84>
    8b02:	48 89 e7             	mov    %rsp,%rdi
    8b05:	be 09 00 00 00       	mov    $0x9,%esi
    8b0a:	eb 88                	jmp    8a94 <tp_quoted+0x84>
    8b0c:	48 89 e7             	mov    %rsp,%rdi
    8b0f:	be 0d 00 00 00       	mov    $0xd,%esi
    8b14:	e9 7b ff ff ff       	jmp    8a94 <tp_quoted+0x84>
    8b19:	48 89 e7             	mov    %rsp,%rdi
    8b1c:	be 0a 00 00 00       	mov    $0xa,%esi
    8b21:	e9 6e ff ff ff       	jmp    8a94 <tp_quoted+0x84>
    8b26:	4c 39 e8             	cmp    %r13,%rax
    8b29:	0f 83 d2 00 00 00    	jae    8c01 <tp_quoted+0x1f1>
    8b2f:	41 80 3c 04 7b       	cmpb   $0x7b,(%r12,%rax,1)
    8b34:	0f 85 c7 00 00 00    	jne    8c01 <tp_quoted+0x1f1>
    8b3a:	48 8d 45 03          	lea    0x3(%rbp),%rax
    8b3e:	49 89 47 10          	mov    %rax,0x10(%r15)
    8b42:	4c 39 e8             	cmp    %r13,%rax
    8b45:	0f 83 b6 00 00 00    	jae    8c01 <tp_quoted+0x1f1>
    8b4b:	e8 b0 99 ff ff       	call   2500 <__ctype_b_loc@plt>
    8b50:	48 8b 08             	mov    (%rax),%rcx
    8b53:	48 8d 55 04          	lea    0x4(%rbp),%rdx
    8b57:	49 8d 3c 2c          	lea    (%r12,%rbp,1),%rdi
    8b5b:	48 83 c7 03          	add    $0x3,%rdi
    8b5f:	49 29 ed             	sub    %rbp,%r13
    8b62:	49 83 c5 fd          	add    $0xfffffffffffffffd,%r13
    8b66:	31 c0                	xor    %eax,%eax
    8b68:	31 f6                	xor    %esi,%esi
    8b6a:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)
    8b70:	44 0f b6 04 07       	movzbl (%rdi,%rax,1),%r8d
    8b75:	42 f6 44 41 01 10    	testb  $0x10,0x1(%rcx,%r8,2)
    8b7b:	74 41                	je     8bbe <tp_quoted+0x1ae>
    8b7d:	4c 8d 04 02          	lea    (%rdx,%rax,1),%r8
    8b81:	4d 89 47 10          	mov    %r8,0x10(%r15)
    8b85:	44 0f be 04 07       	movsbl (%rdi,%rax,1),%r8d
    8b8a:	c1 e6 04             	shl    $0x4,%esi
    8b8d:	45 8d 48 d0          	lea    -0x30(%r8),%r9d
    8b91:	45 89 c2             	mov    %r8d,%r10d
    8b94:	41 83 ca 20          	or     $0x20,%r10d
    8b98:	41 83 c2 a9          	add    $0xffffffa9,%r10d
    8b9c:	41 83 f8 3a          	cmp    $0x3a,%r8d
    8ba0:	45 0f 4c d1          	cmovl  %r9d,%r10d
    8ba4:	44 01 d6             	add    %r10d,%esi
    8ba7:	48 ff c0             	inc    %rax
    8baa:	49 39 c5             	cmp    %rax,%r13
    8bad:	75 c1                	jne    8b70 <tp_quoted+0x160>
    8baf:	eb 50                	jmp    8c01 <tp_quoted+0x1f1>
    8bb1:	48 89 e7             	mov    %rsp,%rdi
    8bb4:	be 22 00 00 00       	mov    $0x22,%esi
    8bb9:	e9 d6 fe ff ff       	jmp    8a94 <tp_quoted+0x84>
    8bbe:	85 c0                	test   %eax,%eax
    8bc0:	74 3f                	je     8c01 <tp_quoted+0x1f1>
    8bc2:	41 80 f8 7d          	cmp    $0x7d,%r8b
    8bc6:	75 39                	jne    8c01 <tp_quoted+0x1f1>
    8bc8:	81 fe ff ff 10 00    	cmp    $0x10ffff,%esi
    8bce:	77 31                	ja     8c01 <tp_quoted+0x1f1>
    8bd0:	89 f1                	mov    %esi,%ecx
    8bd2:	81 e1 00 f8 ff ff    	and    $0xfffff800,%ecx
    8bd8:	81 f9 00 d8 00 00    	cmp    $0xd800,%ecx
    8bde:	74 21                	je     8c01 <tp_quoted+0x1f1>
    8be0:	48 01 e8             	add    %rbp,%rax
    8be3:	48 83 c0 04          	add    $0x4,%rax
    8be7:	49 89 47 10          	mov    %rax,0x10(%r15)
    8beb:	48 89 e7             	mov    %rsp,%rdi
    8bee:	e8 5d 0d 00 00       	call   9950 <fwp_utf8_put>
    8bf3:	e9 a1 fe ff ff       	jmp    8a99 <tp_quoted+0x89>
    8bf8:	31 ff                	xor    %edi,%edi
    8bfa:	e8 51 94 ff ff       	call   2050 <free@plt>
    8bff:	eb 48                	jmp    8c49 <tp_quoted+0x239>
    8c01:	48 8b 3c 24          	mov    (%rsp),%rdi
    8c05:	e8 46 94 ff ff       	call   2050 <free@plt>
    8c0a:	31 db                	xor    %ebx,%ebx
    8c0c:	eb 3b                	jmp    8c49 <tp_quoted+0x239>
    8c0e:	48 8b 3c 24          	mov    (%rsp),%rdi
    8c12:	e8 39 94 ff ff       	call   2050 <free@plt>
    8c17:	eb 30                	jmp    8c49 <tp_quoted+0x239>
    8c19:	48 8b 1c 24          	mov    (%rsp),%rbx
    8c1d:	48 8b 74 24 08       	mov    0x8(%rsp),%rsi
    8c22:	48 85 db             	test   %rbx,%rbx
    8c25:	48 8d 3d 5a 54 00 00 	lea    0x545a(%rip),%rdi        # e086 <exec_in_fp0+0xa46>
    8c2c:	48 0f 45 fb          	cmovne %rbx,%rdi
    8c30:	e8 1b eb ff ff       	call   7750 <fwp_valid_utf8>
    8c35:	85 c0                	test   %eax,%eax
    8c37:	74 21                	je     8c5a <tp_quoted+0x24a>
    8c39:	48 89 e7             	mov    %rsp,%rdi
    8c3c:	e8 3f ed ff ff       	call   7980 <buf_to_str>
    8c41:	49 89 06             	mov    %rax,(%r14)
    8c44:	bb 01 00 00 00       	mov    $0x1,%ebx
    8c49:	89 d8                	mov    %ebx,%eax
    8c4b:	48 83 c4 18          	add    $0x18,%rsp
    8c4f:	5b                   	pop    %rbx
    8c50:	41 5c                	pop    %r12
    8c52:	41 5d                	pop    %r13
    8c54:	41 5e                	pop    %r14
    8c56:	41 5f                	pop    %r15
    8c58:	5d                   	pop    %rbp
    8c59:	c3                   	ret
    8c5a:	48 89 df             	mov    %rbx,%rdi
    8c5d:	eb a6                	jmp    8c05 <tp_quoted+0x1f5>
    8c5f:	90                   	nop

0000000000008c60 <tp_eat>:
    8c60:	55                   	push   %rbp
    8c61:	41 57                	push   %r15
    8c63:	41 56                	push   %r14
    8c65:	53                   	push   %rbx
    8c66:	50                   	push   %rax
    8c67:	49 89 f6             	mov    %rsi,%r14
    8c6a:	48 89 fb             	mov    %rdi,%rbx
    8c6d:	e8 2e fc ff ff       	call   88a0 <tp_ws>
    8c72:	4c 89 f7             	mov    %r14,%rdi
    8c75:	e8 f6 94 ff ff       	call   2170 <strlen@plt>
    8c7a:	48 8b 4b 08          	mov    0x8(%rbx),%rcx
    8c7e:	4c 8b 7b 10          	mov    0x10(%rbx),%r15
    8c82:	4c 29 f9             	sub    %r15,%rcx
    8c85:	31 ed                	xor    %ebp,%ebp
    8c87:	48 39 c1             	cmp    %rax,%rcx
    8c8a:	72 24                	jb     8cb0 <tp_eat+0x50>
    8c8c:	48 8b 3b             	mov    (%rbx),%rdi
    8c8f:	4c 01 ff             	add    %r15,%rdi
    8c92:	4c 89 f6             	mov    %r14,%rsi
    8c95:	49 89 c6             	mov    %rax,%r14
    8c98:	48 89 c2             	mov    %rax,%rdx
    8c9b:	e8 d0 96 ff ff       	call   2370 <bcmp@plt>
    8ca0:	85 c0                	test   %eax,%eax
    8ca2:	75 0c                	jne    8cb0 <tp_eat+0x50>
    8ca4:	4d 01 f7             	add    %r14,%r15
    8ca7:	4c 89 7b 10          	mov    %r15,0x10(%rbx)
    8cab:	bd 01 00 00 00       	mov    $0x1,%ebp
    8cb0:	89 e8                	mov    %ebp,%eax
    8cb2:	48 83 c4 08          	add    $0x8,%rsp
    8cb6:	5b                   	pop    %rbx
    8cb7:	41 5e                	pop    %r14
    8cb9:	41 5f                	pop    %r15
    8cbb:	5d                   	pop    %rbp
    8cbc:	c3                   	ret
    8cbd:	0f 1f 00             	nopl   (%rax)

0000000000008cc0 <tp_list_of>:
    8cc0:	55                   	push   %rbp
    8cc1:	41 57                	push   %r15
    8cc3:	41 56                	push   %r14
    8cc5:	41 55                	push   %r13
    8cc7:	41 54                	push   %r12
    8cc9:	53                   	push   %rbx
    8cca:	50                   	push   %rax
    8ccb:	4d 89 c6             	mov    %r8,%r14
    8cce:	49 89 cf             	mov    %rcx,%r15
    8cd1:	49 89 d4             	mov    %rdx,%r12
    8cd4:	49 89 fd             	mov    %rdi,%r13
    8cd7:	e8 84 ff ff ff       	call   8c60 <tp_eat>
    8cdc:	31 db                	xor    %ebx,%ebx
    8cde:	85 c0                	test   %eax,%eax
    8ce0:	74 14                	je     8cf6 <tp_list_of+0x36>
    8ce2:	4c 89 ef             	mov    %r13,%rdi
    8ce5:	4c 89 e6             	mov    %r12,%rsi
    8ce8:	e8 73 ff ff ff       	call   8c60 <tp_eat>
    8ced:	85 c0                	test   %eax,%eax
    8cef:	74 16                	je     8d07 <tp_list_of+0x47>
    8cf1:	bb 01 00 00 00       	mov    $0x1,%ebx
    8cf6:	89 d8                	mov    %ebx,%eax
    8cf8:	48 83 c4 08          	add    $0x8,%rsp
    8cfc:	5b                   	pop    %rbx
    8cfd:	41 5c                	pop    %r12
    8cff:	41 5d                	pop    %r13
    8d01:	41 5e                	pop    %r14
    8d03:	41 5f                	pop    %r15
    8d05:	5d                   	pop    %rbp
    8d06:	c3                   	ret
    8d07:	48 8d 2d 7c 55 00 00 	lea    0x557c(%rip),%rbp        # e28a <exec_in_fp0+0xc4a>
    8d0e:	66 90                	xchg   %ax,%ax
    8d10:	4c 89 ef             	mov    %r13,%rdi
    8d13:	4c 89 f6             	mov    %r14,%rsi
    8d16:	41 ff d7             	call   *%r15
    8d19:	85 c0                	test   %eax,%eax
    8d1b:	74 d9                	je     8cf6 <tp_list_of+0x36>
    8d1d:	4c 89 ef             	mov    %r13,%rdi
    8d20:	4c 89 e6             	mov    %r12,%rsi
    8d23:	e8 38 ff ff ff       	call   8c60 <tp_eat>
    8d28:	85 c0                	test   %eax,%eax
    8d2a:	75 c5                	jne    8cf1 <tp_list_of+0x31>
    8d2c:	4c 89 ef             	mov    %r13,%rdi
    8d2f:	48 89 ee             	mov    %rbp,%rsi
    8d32:	e8 29 ff ff ff       	call   8c60 <tp_eat>
    8d37:	85 c0                	test   %eax,%eax
    8d39:	75 d5                	jne    8d10 <tp_list_of+0x50>
    8d3b:	eb b9                	jmp    8cf6 <tp_list_of+0x36>
    8d3d:	0f 1f 00             	nopl   (%rax)

0000000000008d40 <tp_byte_item>:
    8d40:	53                   	push   %rbx
    8d41:	48 83 ec 10          	sub    $0x10,%rsp
    8d45:	48 89 f3             	mov    %rsi,%rbx
    8d48:	48 8d 35 b1 9f 00 00 	lea    0x9fb1(%rip),%rsi        # 12d00 <tp_byte_item.u8d>
    8d4f:	48 8d 54 24 08       	lea    0x8(%rsp),%rdx
    8d54:	e8 97 fb ff ff       	call   88f0 <tp_int>
    8d59:	85 c0                	test   %eax,%eax
    8d5b:	74 14                	je     8d71 <tp_byte_item+0x31>
    8d5d:	48 8b 74 24 08       	mov    0x8(%rsp),%rsi
    8d62:	48 89 df             	mov    %rbx,%rdi
    8d65:	e8 96 0c 00 00       	call   9a00 <tp_push>
    8d6a:	b8 01 00 00 00       	mov    $0x1,%eax
    8d6f:	eb 02                	jmp    8d73 <tp_byte_item+0x33>
    8d71:	31 c0                	xor    %eax,%eax
    8d73:	48 83 c4 10          	add    $0x10,%rsp
    8d77:	5b                   	pop    %rbx
    8d78:	c3                   	ret
    8d79:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)

0000000000008d80 <tp_token>:
    8d80:	55                   	push   %rbp
    8d81:	41 57                	push   %r15
    8d83:	41 56                	push   %r14
    8d85:	41 55                	push   %r13
    8d87:	41 54                	push   %r12
    8d89:	53                   	push   %rbx
    8d8a:	50                   	push   %rax
    8d8b:	49 89 d7             	mov    %rdx,%r15
    8d8e:	48 89 34 24          	mov    %rsi,(%rsp)
    8d92:	48 89 fb             	mov    %rdi,%rbx
    8d95:	e8 06 fb ff ff       	call   88a0 <tp_ws>
    8d9a:	4c 8b 73 10          	mov    0x10(%rbx),%r14
    8d9e:	4c 8b 23             	mov    (%rbx),%r12
    8da1:	4c 8b 6b 08          	mov    0x8(%rbx),%r13
    8da5:	4c 89 f5             	mov    %r14,%rbp
    8da8:	4d 39 ee             	cmp    %r13,%r14
    8dab:	73 20                	jae    8dcd <tp_token+0x4d>
    8dad:	4c 89 f5             	mov    %r14,%rbp
    8db0:	41 0f be 3c 2c       	movsbl (%r12,%rbp,1),%edi
    8db5:	e8 a6 0c 00 00       	call   9a60 <tp_is_delim>
    8dba:	85 c0                	test   %eax,%eax
    8dbc:	75 0f                	jne    8dcd <tp_token+0x4d>
    8dbe:	48 ff c5             	inc    %rbp
    8dc1:	48 89 6b 10          	mov    %rbp,0x10(%rbx)
    8dc5:	49 39 ed             	cmp    %rbp,%r13
    8dc8:	75 e6                	jne    8db0 <tp_token+0x30>
    8dca:	4c 89 ed             	mov    %r13,%rbp
    8dcd:	4c 29 f5             	sub    %r14,%rbp
    8dd0:	4d 8d 6f ff          	lea    -0x1(%r15),%r13
    8dd4:	4c 39 fd             	cmp    %r15,%rbp
    8dd7:	4c 0f 42 ed          	cmovb  %rbp,%r13
    8ddb:	4d 01 f4             	add    %r14,%r12
    8dde:	4c 8b 3c 24          	mov    (%rsp),%r15
    8de2:	4c 89 ff             	mov    %r15,%rdi
    8de5:	4c 89 e6             	mov    %r12,%rsi
    8de8:	4c 89 ea             	mov    %r13,%rdx
    8deb:	e8 40 95 ff ff       	call   2330 <memcpy@plt>
    8df0:	43 c6 04 2f 00       	movb   $0x0,(%r15,%r13,1)
    8df5:	48 8b 43 10          	mov    0x10(%rbx),%rax
    8df9:	4c 29 f0             	sub    %r14,%rax
    8dfc:	48 83 c4 08          	add    $0x8,%rsp
    8e00:	5b                   	pop    %rbx
    8e01:	41 5c                	pop    %r12
    8e03:	41 5d                	pop    %r13
    8e05:	41 5e                	pop    %r14
    8e07:	41 5f                	pop    %r15
    8e09:	5d                   	pop    %rbp
    8e0a:	c3                   	ret
    8e0b:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)

0000000000008e10 <tp_elem_item>:
    8e10:	55                   	push   %rbp
    8e11:	53                   	push   %rbx
    8e12:	50                   	push   %rax
    8e13:	48 89 f3             	mov    %rsi,%rbx
    8e16:	48 8b 36             	mov    (%rsi),%rsi
    8e19:	31 ed                	xor    %ebp,%ebp
    8e1b:	48 89 e1             	mov    %rsp,%rcx
    8e1e:	31 d2                	xor    %edx,%edx
    8e20:	e8 4b f1 ff ff       	call   7f70 <tp_value>
    8e25:	85 c0                	test   %eax,%eax
    8e27:	74 11                	je     8e3a <tp_elem_item+0x2a>
    8e29:	48 8b 34 24          	mov    (%rsp),%rsi
    8e2d:	48 89 df             	mov    %rbx,%rdi
    8e30:	e8 cb 0b 00 00       	call   9a00 <tp_push>
    8e35:	bd 01 00 00 00       	mov    $0x1,%ebp
    8e3a:	89 e8                	mov    %ebp,%eax
    8e3c:	48 83 c4 08          	add    $0x8,%rsp
    8e40:	5b                   	pop    %rbx
    8e41:	5d                   	pop    %rbp
    8e42:	c3                   	ret
    8e43:	66 66 66 66 2e 0f 1f 	data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    8e4a:	84 00 00 00 00 00 

0000000000008e50 <fwp_p_array_from_list>:
    8e50:	41 56                	push   %r14
    8e52:	53                   	push   %rbx
    8e53:	50                   	push   %rax
    8e54:	48 89 fb             	mov    %rdi,%rbx
    8e57:	e8 44 0c 00 00       	call   9aa0 <fwp_list_len>
    8e5c:	49 89 c6             	mov    %rax,%r14
    8e5f:	48 89 c7             	mov    %rax,%rdi
    8e62:	e8 09 c7 ff ff       	call   5570 <fwp_arr_new>
    8e67:	4d 85 f6             	test   %r14,%r14
    8e6a:	0f 84 84 00 00 00    	je     8ef4 <fwp_p_array_from_list+0xa4>
    8e70:	44 89 f1             	mov    %r14d,%ecx
    8e73:	83 e1 03             	and    $0x3,%ecx
    8e76:	49 83 fe 04          	cmp    $0x4,%r14
    8e7a:	73 04                	jae    8e80 <fwp_p_array_from_list+0x30>
    8e7c:	31 d2                	xor    %edx,%edx
    8e7e:	eb 4d                	jmp    8ecd <fwp_p_array_from_list+0x7d>
    8e80:	49 83 e6 fc          	and    $0xfffffffffffffffc,%r14
    8e84:	31 d2                	xor    %edx,%edx
    8e86:	66 2e 0f 1f 84 00 00 	cs nopw 0x0(%rax,%rax,1)
    8e8d:	00 00 00 
    8e90:	48 8b 73 08          	mov    0x8(%rbx),%rsi
    8e94:	48 89 74 d0 08       	mov    %rsi,0x8(%rax,%rdx,8)
    8e99:	48 8b 73 10          	mov    0x10(%rbx),%rsi
    8e9d:	48 8b 7e 08          	mov    0x8(%rsi),%rdi
    8ea1:	48 89 7c d0 10       	mov    %rdi,0x10(%rax,%rdx,8)
    8ea6:	48 8b 76 10          	mov    0x10(%rsi),%rsi
    8eaa:	48 8b 7e 08          	mov    0x8(%rsi),%rdi
    8eae:	48 89 7c d0 18       	mov    %rdi,0x18(%rax,%rdx,8)
    8eb3:	48 8b 76 10          	mov    0x10(%rsi),%rsi
    8eb7:	48 8b 7e 08          	mov    0x8(%rsi),%rdi
    8ebb:	48 89 7c d0 20       	mov    %rdi,0x20(%rax,%rdx,8)
    8ec0:	48 8b 5e 10          	mov    0x10(%rsi),%rbx
    8ec4:	48 83 c2 04          	add    $0x4,%rdx
    8ec8:	49 39 d6             	cmp    %rdx,%r14
    8ecb:	75 c3                	jne    8e90 <fwp_p_array_from_list+0x40>
    8ecd:	48 85 c9             	test   %rcx,%rcx
    8ed0:	74 22                	je     8ef4 <fwp_p_array_from_list+0xa4>
    8ed2:	48 8d 14 d0          	lea    (%rax,%rdx,8),%rdx
    8ed6:	48 83 c2 08          	add    $0x8,%rdx
    8eda:	31 f6                	xor    %esi,%esi
    8edc:	0f 1f 40 00          	nopl   0x0(%rax)
    8ee0:	48 8b 7b 08          	mov    0x8(%rbx),%rdi
    8ee4:	48 89 3c f2          	mov    %rdi,(%rdx,%rsi,8)
    8ee8:	48 8b 5b 10          	mov    0x10(%rbx),%rbx
    8eec:	48 ff c6             	inc    %rsi
    8eef:	48 39 f1             	cmp    %rsi,%rcx
    8ef2:	75 ec                	jne    8ee0 <fwp_p_array_from_list+0x90>
    8ef4:	48 83 c4 08          	add    $0x8,%rsp
    8ef8:	5b                   	pop    %rbx
    8ef9:	41 5e                	pop    %r14
    8efb:	c3                   	ret
    8efc:	0f 1f 40 00          	nopl   0x0(%rax)

0000000000008f00 <tp_kv_item>:
    8f00:	41 57                	push   %r15
    8f02:	41 56                	push   %r14
    8f04:	53                   	push   %rbx
    8f05:	48 83 ec 10          	sub    $0x10,%rsp
    8f09:	48 89 f3             	mov    %rsi,%rbx
    8f0c:	49 89 ff             	mov    %rdi,%r15
    8f0f:	48 c7 04 24 00 00 00 	movq   $0x0,(%rsp)
    8f16:	00 
    8f17:	48 8b 36             	mov    (%rsi),%rsi
    8f1a:	45 31 f6             	xor    %r14d,%r14d
    8f1d:	48 8d 4c 24 08       	lea    0x8(%rsp),%rcx
    8f22:	31 d2                	xor    %edx,%edx
    8f24:	e8 47 f0 ff ff       	call   7f70 <tp_value>
    8f29:	85 c0                	test   %eax,%eax
    8f2b:	74 27                	je     8f54 <tp_kv_item+0x54>
    8f2d:	45 31 f6             	xor    %r14d,%r14d
    8f30:	83 7b 28 00          	cmpl   $0x0,0x28(%rbx)
    8f34:	74 2b                	je     8f61 <tp_kv_item+0x61>
    8f36:	48 8b 74 24 08       	mov    0x8(%rsp),%rsi
    8f3b:	48 89 df             	mov    %rbx,%rdi
    8f3e:	e8 bd 0a 00 00       	call   9a00 <tp_push>
    8f43:	48 89 df             	mov    %rbx,%rdi
    8f46:	4c 89 f6             	mov    %r14,%rsi
    8f49:	e8 b2 0a 00 00       	call   9a00 <tp_push>
    8f4e:	41 be 01 00 00 00    	mov    $0x1,%r14d
    8f54:	44 89 f0             	mov    %r14d,%eax
    8f57:	48 83 c4 10          	add    $0x10,%rsp
    8f5b:	5b                   	pop    %rbx
    8f5c:	41 5e                	pop    %r14
    8f5e:	41 5f                	pop    %r15
    8f60:	c3                   	ret
    8f61:	48 8d 35 36 53 00 00 	lea    0x5336(%rip),%rsi        # e29e <exec_in_fp0+0xc5e>
    8f68:	4c 89 ff             	mov    %r15,%rdi
    8f6b:	e8 f0 fc ff ff       	call   8c60 <tp_eat>
    8f70:	85 c0                	test   %eax,%eax
    8f72:	74 e0                	je     8f54 <tp_kv_item+0x54>
    8f74:	48 8b 73 08          	mov    0x8(%rbx),%rsi
    8f78:	45 31 f6             	xor    %r14d,%r14d
    8f7b:	48 89 e1             	mov    %rsp,%rcx
    8f7e:	4c 89 ff             	mov    %r15,%rdi
    8f81:	31 d2                	xor    %edx,%edx
    8f83:	e8 e8 ef ff ff       	call   7f70 <tp_value>
    8f88:	85 c0                	test   %eax,%eax
    8f8a:	74 c8                	je     8f54 <tp_kv_item+0x54>
    8f8c:	4c 8b 34 24          	mov    (%rsp),%r14
    8f90:	eb a4                	jmp    8f36 <tp_kv_item+0x36>
    8f92:	66 66 66 66 66 2e 0f 	data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    8f99:	1f 84 00 00 00 00 00 

0000000000008fa0 <fwp_p_map_insert>:
    8fa0:	55                   	push   %rbp
    8fa1:	41 57                	push   %r15
    8fa3:	41 56                	push   %r14
    8fa5:	41 55                	push   %r13
    8fa7:	41 54                	push   %r12
    8fa9:	53                   	push   %rbx
    8faa:	48 83 ec 18          	sub    $0x18,%rsp
    8fae:	49 89 d6             	mov    %rdx,%r14
    8fb1:	48 89 74 24 08       	mov    %rsi,0x8(%rsp)
    8fb6:	48 89 fe             	mov    %rdi,%rsi
    8fb9:	48 8d 44 24 04       	lea    0x4(%rsp),%rax
    8fbe:	48 89 d7             	mov    %rdx,%rdi
    8fc1:	48 89 74 24 10       	mov    %rsi,0x10(%rsp)
    8fc6:	48 89 ca             	mov    %rcx,%rdx
    8fc9:	48 89 c1             	mov    %rax,%rcx
    8fcc:	e8 ef 0a 00 00       	call   9ac0 <fwp_map_find>
    8fd1:	48 89 c5             	mov    %rax,%rbp
    8fd4:	4d 8b 3e             	mov    (%r14),%r15
    8fd7:	44 8b 64 24 04       	mov    0x4(%rsp),%r12d
    8fdc:	31 ff                	xor    %edi,%edi
    8fde:	45 85 e4             	test   %r12d,%r12d
    8fe1:	40 0f 94 c7          	sete   %dil
    8fe5:	4c 01 ff             	add    %r15,%rdi
    8fe8:	e8 23 0c 00 00       	call   9c10 <fwp_map_alloc>
    8fed:	49 89 c5             	mov    %rax,%r13
    8ff0:	48 8d 58 08          	lea    0x8(%rax),%rbx
    8ff4:	49 83 c6 08          	add    $0x8,%r14
    8ff8:	45 85 e4             	test   %r12d,%r12d
    8ffb:	74 22                	je     901f <fwp_p_map_insert+0x7f>
    8ffd:	49 c1 e7 04          	shl    $0x4,%r15
    9001:	48 89 df             	mov    %rbx,%rdi
    9004:	4c 89 f6             	mov    %r14,%rsi
    9007:	4c 89 fa             	mov    %r15,%rdx
    900a:	e8 21 93 ff ff       	call   2330 <memcpy@plt>
    900f:	48 c1 e5 04          	shl    $0x4,%rbp
    9013:	48 8b 44 24 08       	mov    0x8(%rsp),%rax
    9018:	49 89 44 2d 10       	mov    %rax,0x10(%r13,%rbp,1)
    901d:	eb 46                	jmp    9065 <fwp_p_map_insert+0xc5>
    901f:	49 89 ec             	mov    %rbp,%r12
    9022:	49 c1 e4 04          	shl    $0x4,%r12
    9026:	48 89 df             	mov    %rbx,%rdi
    9029:	4c 89 f6             	mov    %r14,%rsi
    902c:	4c 89 e2             	mov    %r12,%rdx
    902f:	e8 fc 92 ff ff       	call   2330 <memcpy@plt>
    9034:	48 8b 44 24 10       	mov    0x10(%rsp),%rax
    9039:	4b 89 44 25 08       	mov    %rax,0x8(%r13,%r12,1)
    903e:	48 8b 44 24 08       	mov    0x8(%rsp),%rax
    9043:	4b 89 44 25 10       	mov    %rax,0x10(%r13,%r12,1)
    9048:	4a 8d 3c 23          	lea    (%rbx,%r12,1),%rdi
    904c:	48 83 c7 10          	add    $0x10,%rdi
    9050:	4d 01 f4             	add    %r14,%r12
    9053:	49 29 ef             	sub    %rbp,%r15
    9056:	49 c1 e7 04          	shl    $0x4,%r15
    905a:	4c 89 e6             	mov    %r12,%rsi
    905d:	4c 89 fa             	mov    %r15,%rdx
    9060:	e8 cb 92 ff ff       	call   2330 <memcpy@plt>
    9065:	4c 89 e8             	mov    %r13,%rax
    9068:	48 83 c4 18          	add    $0x18,%rsp
    906c:	5b                   	pop    %rbx
    906d:	41 5c                	pop    %r12
    906f:	41 5d                	pop    %r13
    9071:	41 5e                	pop    %r14
    9073:	41 5f                	pop    %r15
    9075:	5d                   	pop    %rbp
    9076:	c3                   	ret
    9077:	66 0f 1f 84 00 00 00 	nopw   0x0(%rax,%rax,1)
    907e:	00 00 

0000000000009080 <fwp_valid_int>:
    9080:	31 c0                	xor    %eax,%eax
    9082:	48 85 f6             	test   %rsi,%rsi
    9085:	74 32                	je     90b9 <fwp_valid_int+0x39>
    9087:	0f b6 17             	movzbl (%rdi),%edx
    908a:	80 c2 d5             	add    $0xd5,%dl
    908d:	31 c9                	xor    %ecx,%ecx
    908f:	f6 c2 fd             	test   $0xfd,%dl
    9092:	0f 94 c1             	sete   %cl
    9095:	48 39 f1             	cmp    %rsi,%rcx
    9098:	74 1f                	je     90b9 <fwp_valid_int+0x39>
    909a:	73 18                	jae    90b4 <fwp_valid_int+0x34>
    909c:	0f 1f 40 00          	nopl   0x0(%rax)
    90a0:	0f b6 14 0f          	movzbl (%rdi,%rcx,1),%edx
    90a4:	80 c2 c6             	add    $0xc6,%dl
    90a7:	80 fa f5             	cmp    $0xf5,%dl
    90aa:	76 0d                	jbe    90b9 <fwp_valid_int+0x39>
    90ac:	48 ff c1             	inc    %rcx
    90af:	48 39 ce             	cmp    %rcx,%rsi
    90b2:	75 ec                	jne    90a0 <fwp_valid_int+0x20>
    90b4:	b8 01 00 00 00       	mov    $0x1,%eax
    90b9:	c3                   	ret
    90ba:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)

00000000000090c0 <tp_record_body>:
    90c0:	55                   	push   %rbp
    90c1:	41 57                	push   %r15
    90c3:	41 56                	push   %r14
    90c5:	41 55                	push   %r13
    90c7:	41 54                	push   %r12
    90c9:	53                   	push   %rbx
    90ca:	48 81 ec 28 01 00 00 	sub    $0x128,%rsp
    90d1:	48 89 d3             	mov    %rdx,%rbx
    90d4:	49 89 f5             	mov    %rsi,%r13
    90d7:	48 89 fd             	mov    %rdi,%rbp
    90da:	48 63 46 10          	movslq 0x10(%rsi),%rax
    90de:	48 8d 3c c5 08 00 00 	lea    0x8(,%rax,8),%rdi
    90e5:	00 
    90e6:	e8 c5 c4 ff ff       	call   55b0 <fwp_alloc>
    90eb:	49 89 c7             	mov    %rax,%r15
    90ee:	49 63 7d 10          	movslq 0x10(%r13),%rdi
    90f2:	48 ff c7             	inc    %rdi
    90f5:	e8 f6 d5 ff ff       	call   66f0 <fwp_alloc_leaf>
    90fa:	49 89 c4             	mov    %rax,%r12
    90fd:	49 63 55 10          	movslq 0x10(%r13),%rdx
    9101:	48 ff c2             	inc    %rdx
    9104:	45 31 f6             	xor    %r14d,%r14d
    9107:	48 89 c7             	mov    %rax,%rdi
    910a:	31 f6                	xor    %esi,%esi
    910c:	e8 ff 90 ff ff       	call   2210 <memset@plt>
    9111:	48 8d 35 32 52 00 00 	lea    0x5232(%rip),%rsi        # e34a <exec_in_fp0+0xd0a>
    9118:	48 89 ef             	mov    %rbp,%rdi
    911b:	e8 40 fb ff ff       	call   8c60 <tp_eat>
    9120:	85 c0                	test   %eax,%eax
    9122:	0f 84 3b 01 00 00    	je     9263 <tp_record_body+0x1a3>
    9128:	48 8d 35 35 45 00 00 	lea    0x4535(%rip),%rsi        # d664 <exec_in_fp0+0x24>
    912f:	48 89 ef             	mov    %rbp,%rdi
    9132:	e8 29 fb ff ff       	call   8c60 <tp_eat>
    9137:	85 c0                	test   %eax,%eax
    9139:	74 3e                	je     9179 <tp_record_body+0xb9>
    913b:	41 8b 7d 10          	mov    0x10(%r13),%edi
    913f:	85 ff                	test   %edi,%edi
    9141:	7e 20                	jle    9163 <tp_record_body+0xa3>
    9143:	45 31 f6             	xor    %r14d,%r14d
    9146:	31 c0                	xor    %eax,%eax
    9148:	0f 1f 84 00 00 00 00 	nopl   0x0(%rax,%rax,1)
    914f:	00 
    9150:	41 80 3c 04 00       	cmpb   $0x0,(%r12,%rax,1)
    9155:	0f 84 08 01 00 00    	je     9263 <tp_record_body+0x1a3>
    915b:	48 ff c0             	inc    %rax
    915e:	48 39 c7             	cmp    %rax,%rdi
    9161:	75 ed                	jne    9150 <tp_record_body+0x90>
    9163:	4c 89 fe             	mov    %r15,%rsi
    9166:	e8 85 9d ff ff       	call   2ef0 <fwp_record>
    916b:	48 89 03             	mov    %rax,(%rbx)
    916e:	41 be 01 00 00 00    	mov    $0x1,%r14d
    9174:	e9 ea 00 00 00       	jmp    9263 <tp_record_body+0x1a3>
    9179:	48 89 1c 24          	mov    %rbx,(%rsp)
    917d:	48 8d 74 24 20       	lea    0x20(%rsp),%rsi
    9182:	48 89 ef             	mov    %rbp,%rdi
    9185:	e8 06 01 00 00       	call   9290 <tp_ident>
    918a:	41 8b 45 10          	mov    0x10(%r13),%eax
    918e:	85 c0                	test   %eax,%eax
    9190:	0f 8e ca 00 00 00    	jle    9260 <tp_record_body+0x1a0>
    9196:	48 8d 5c 24 20       	lea    0x20(%rsp),%rbx
    919b:	4c 89 7c 24 18       	mov    %r15,0x18(%rsp)
    91a0:	4c 89 64 24 10       	mov    %r12,0x10(%rsp)
    91a5:	48 89 6c 24 08       	mov    %rbp,0x8(%rsp)
    91aa:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)
    91b0:	4d 8b 65 18          	mov    0x18(%r13),%r12
    91b4:	41 89 c7             	mov    %eax,%r15d
    91b7:	41 be ff ff ff ff    	mov    $0xffffffff,%r14d
    91bd:	31 ed                	xor    %ebp,%ebp
    91bf:	90                   	nop
    91c0:	49 8b 3c ec          	mov    (%r12,%rbp,8),%rdi
    91c4:	48 89 de             	mov    %rbx,%rsi
    91c7:	e8 04 91 ff ff       	call   22d0 <strcmp@plt>
    91cc:	85 c0                	test   %eax,%eax
    91ce:	44 0f 44 f5          	cmove  %ebp,%r14d
    91d2:	48 ff c5             	inc    %rbp
    91d5:	49 39 ef             	cmp    %rbp,%r15
    91d8:	75 e6                	jne    91c0 <tp_record_body+0x100>
    91da:	45 85 f6             	test   %r14d,%r14d
    91dd:	4c 8b 7c 24 18       	mov    0x18(%rsp),%r15
    91e2:	4c 8b 64 24 10       	mov    0x10(%rsp),%r12
    91e7:	48 8b 6c 24 08       	mov    0x8(%rsp),%rbp
    91ec:	78 72                	js     9260 <tp_record_body+0x1a0>
    91ee:	48 89 ef             	mov    %rbp,%rdi
    91f1:	48 8d 35 a8 50 00 00 	lea    0x50a8(%rip),%rsi        # e2a0 <exec_in_fp0+0xc60>
    91f8:	e8 63 fa ff ff       	call   8c60 <tp_eat>
    91fd:	85 c0                	test   %eax,%eax
    91ff:	74 5f                	je     9260 <tp_record_body+0x1a0>
    9201:	49 8b 45 20          	mov    0x20(%r13),%rax
    9205:	45 89 f6             	mov    %r14d,%r14d
    9208:	4a 8b 34 f0          	mov    (%rax,%r14,8),%rsi
    920c:	4b 8d 0c f7          	lea    (%r15,%r14,8),%rcx
    9210:	48 89 ef             	mov    %rbp,%rdi
    9213:	31 d2                	xor    %edx,%edx
    9215:	e8 56 ed ff ff       	call   7f70 <tp_value>
    921a:	85 c0                	test   %eax,%eax
    921c:	74 42                	je     9260 <tp_record_body+0x1a0>
    921e:	43 c6 04 34 01       	movb   $0x1,(%r12,%r14,1)
    9223:	48 89 ef             	mov    %rbp,%rdi
    9226:	48 8d 35 37 44 00 00 	lea    0x4437(%rip),%rsi        # d664 <exec_in_fp0+0x24>
    922d:	e8 2e fa ff ff       	call   8c60 <tp_eat>
    9232:	85 c0                	test   %eax,%eax
    9234:	75 42                	jne    9278 <tp_record_body+0x1b8>
    9236:	48 89 ef             	mov    %rbp,%rdi
    9239:	48 8d 35 4a 50 00 00 	lea    0x504a(%rip),%rsi        # e28a <exec_in_fp0+0xc4a>
    9240:	e8 1b fa ff ff       	call   8c60 <tp_eat>
    9245:	85 c0                	test   %eax,%eax
    9247:	74 17                	je     9260 <tp_record_body+0x1a0>
    9249:	48 89 ef             	mov    %rbp,%rdi
    924c:	48 89 de             	mov    %rbx,%rsi
    924f:	e8 3c 00 00 00       	call   9290 <tp_ident>
    9254:	41 8b 45 10          	mov    0x10(%r13),%eax
    9258:	85 c0                	test   %eax,%eax
    925a:	0f 8f 50 ff ff ff    	jg     91b0 <tp_record_body+0xf0>
    9260:	45 31 f6             	xor    %r14d,%r14d
    9263:	44 89 f0             	mov    %r14d,%eax
    9266:	48 81 c4 28 01 00 00 	add    $0x128,%rsp
    926d:	5b                   	pop    %rbx
    926e:	41 5c                	pop    %r12
    9270:	41 5d                	pop    %r13
    9272:	41 5e                	pop    %r14
    9274:	41 5f                	pop    %r15
    9276:	5d                   	pop    %rbp
    9277:	c3                   	ret
    9278:	48 8b 1c 24          	mov    (%rsp),%rbx
    927c:	e9 ba fe ff ff       	jmp    913b <tp_record_body+0x7b>
    9281:	66 66 66 66 66 66 2e 	data16 data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    9288:	0f 1f 84 00 00 00 00 
    928f:	00 

0000000000009290 <tp_ident>:
    9290:	41 56                	push   %r14
    9292:	53                   	push   %rbx
    9293:	50                   	push   %rax
    9294:	48 89 f3             	mov    %rsi,%rbx
    9297:	49 89 fe             	mov    %rdi,%r14
    929a:	e8 01 f6 ff ff       	call   88a0 <tp_ws>
    929f:	49 8b 46 10          	mov    0x10(%r14),%rax
    92a3:	49 8b 36             	mov    (%r14),%rsi
    92a6:	49 8b 56 08          	mov    0x8(%r14),%rdx
    92aa:	48 89 c1             	mov    %rax,%rcx
    92ad:	48 39 d0             	cmp    %rdx,%rax
    92b0:	73 63                	jae    9315 <tp_ident+0x85>
    92b2:	48 bf 03 00 00 00 00 	movabs $0x4000000000003,%rdi
    92b9:	00 04 00 
    92bc:	48 89 c1             	mov    %rax,%rcx
    92bf:	eb 1b                	jmp    92dc <tp_ident+0x4c>
    92c1:	66 66 66 66 66 66 2e 	data16 data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    92c8:	0f 1f 84 00 00 00 00 
    92cf:	00 
    92d0:	48 ff c1             	inc    %rcx
    92d3:	49 89 4e 10          	mov    %rcx,0x10(%r14)
    92d7:	48 39 ca             	cmp    %rcx,%rdx
    92da:	74 36                	je     9312 <tp_ident+0x82>
    92dc:	44 0f b6 04 0e       	movzbl (%rsi,%rcx,1),%r8d
    92e1:	45 8d 48 d0          	lea    -0x30(%r8),%r9d
    92e5:	41 80 f9 0a          	cmp    $0xa,%r9b
    92e9:	72 e5                	jb     92d0 <tp_ident+0x40>
    92eb:	45 89 c1             	mov    %r8d,%r9d
    92ee:	41 80 e1 df          	and    $0xdf,%r9b
    92f2:	41 80 c1 bf          	add    $0xbf,%r9b
    92f6:	41 80 f9 1a          	cmp    $0x1a,%r9b
    92fa:	72 d4                	jb     92d0 <tp_ident+0x40>
    92fc:	45 0f b6 c0          	movzbl %r8b,%r8d
    9300:	41 83 c0 d3          	add    $0xffffffd3,%r8d
    9304:	41 83 f8 32          	cmp    $0x32,%r8d
    9308:	77 0b                	ja     9315 <tp_ident+0x85>
    930a:	4c 0f a3 c7          	bt     %r8,%rdi
    930e:	72 c0                	jb     92d0 <tp_ident+0x40>
    9310:	eb 03                	jmp    9315 <tp_ident+0x85>
    9312:	48 89 d1             	mov    %rdx,%rcx
    9315:	48 29 c1             	sub    %rax,%rcx
    9318:	48 81 f9 ff 00 00 00 	cmp    $0xff,%rcx
    931f:	41 be ff 00 00 00    	mov    $0xff,%r14d
    9325:	4c 0f 42 f1          	cmovb  %rcx,%r14
    9329:	48 01 c6             	add    %rax,%rsi
    932c:	48 89 df             	mov    %rbx,%rdi
    932f:	4c 89 f2             	mov    %r14,%rdx
    9332:	e8 f9 8f ff ff       	call   2330 <memcpy@plt>
    9337:	42 c6 04 33 00       	movb   $0x0,(%rbx,%r14,1)
    933c:	48 83 c4 08          	add    $0x8,%rsp
    9340:	5b                   	pop    %rbx
    9341:	41 5e                	pop    %r14
    9343:	c3                   	ret
    9344:	66 66 66 2e 0f 1f 84 	data16 data16 cs nopw 0x0(%rax,%rax,1)
    934b:	00 00 00 00 00 

0000000000009350 <tp_atom>:
    9350:	41 57                	push   %r15
    9352:	41 56                	push   %r14
    9354:	53                   	push   %rbx
    9355:	49 89 d6             	mov    %rdx,%r14
    9358:	49 89 f7             	mov    %rsi,%r15
    935b:	48 89 fb             	mov    %rdi,%rbx
    935e:	e8 3d f5 ff ff       	call   88a0 <tp_ws>
    9363:	41 83 3f 10          	cmpl   $0x10,(%r15)
    9367:	75 07                	jne    9370 <tp_atom+0x20>
    9369:	49 83 7f 08 00       	cmpq   $0x0,0x8(%r15)
    936e:	74 5e                	je     93ce <tp_atom+0x7e>
    9370:	31 c0                	xor    %eax,%eax
    9372:	48 8b 4b 10          	mov    0x10(%rbx),%rcx
    9376:	48 3b 4b 08          	cmp    0x8(%rbx),%rcx
    937a:	73 0e                	jae    938a <tp_atom+0x3a>
    937c:	48 8b 13             	mov    (%rbx),%rdx
    937f:	80 3c 0a 28          	cmpb   $0x28,(%rdx,%rcx,1)
    9383:	0f 95 c2             	setne  %dl
    9386:	08 c2                	or     %al,%dl
    9388:	74 15                	je     939f <tp_atom+0x4f>
    938a:	48 89 df             	mov    %rbx,%rdi
    938d:	4c 89 fe             	mov    %r15,%rsi
    9390:	31 d2                	xor    %edx,%edx
    9392:	4c 89 f1             	mov    %r14,%rcx
    9395:	5b                   	pop    %rbx
    9396:	41 5e                	pop    %r14
    9398:	41 5f                	pop    %r15
    939a:	e9 d1 eb ff ff       	jmp    7f70 <tp_value>
    939f:	48 ff c1             	inc    %rcx
    93a2:	48 89 4b 10          	mov    %rcx,0x10(%rbx)
    93a6:	48 89 df             	mov    %rbx,%rdi
    93a9:	4c 89 fe             	mov    %r15,%rsi
    93ac:	31 d2                	xor    %edx,%edx
    93ae:	4c 89 f1             	mov    %r14,%rcx
    93b1:	e8 ba eb ff ff       	call   7f70 <tp_value>
    93b6:	85 c0                	test   %eax,%eax
    93b8:	74 25                	je     93df <tp_atom+0x8f>
    93ba:	48 8d 35 8c 4f 00 00 	lea    0x4f8c(%rip),%rsi        # e34d <exec_in_fp0+0xd0d>
    93c1:	48 89 df             	mov    %rbx,%rdi
    93c4:	5b                   	pop    %rbx
    93c5:	41 5e                	pop    %r14
    93c7:	41 5f                	pop    %r15
    93c9:	e9 92 f8 ff ff       	jmp    8c60 <tp_eat>
    93ce:	41 83 7f 10 00       	cmpl   $0x0,0x10(%r15)
    93d3:	74 12                	je     93e7 <tp_atom+0x97>
    93d5:	41 83 7f 48 00       	cmpl   $0x0,0x48(%r15)
    93da:	0f 95 c0             	setne  %al
    93dd:	eb 93                	jmp    9372 <tp_atom+0x22>
    93df:	31 c0                	xor    %eax,%eax
    93e1:	5b                   	pop    %rbx
    93e2:	41 5e                	pop    %r14
    93e4:	41 5f                	pop    %r15
    93e6:	c3                   	ret
    93e7:	b0 01                	mov    $0x1,%al
    93e9:	eb 87                	jmp    9372 <tp_atom+0x22>
    93eb:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)

00000000000093f0 <fwp_cstr>:
    93f0:	53                   	push   %rbx
    93f1:	48 89 fb             	mov    %rdi,%rbx
    93f4:	e8 77 8d ff ff       	call   2170 <strlen@plt>
    93f9:	48 89 df             	mov    %rbx,%rdi
    93fc:	48 89 c6             	mov    %rax,%rsi
    93ff:	5b                   	pop    %rbx
    9400:	e9 ab e4 ff ff       	jmp    78b0 <fwp_str_new>
    9405:	66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
    940c:	00 00 00 00 

0000000000009410 <fwp_p_parse_int>:
    9410:	55                   	push   %rbp
    9411:	41 57                	push   %r15
    9413:	41 56                	push   %r14
    9415:	41 55                	push   %r13
    9417:	41 54                	push   %r12
    9419:	53                   	push   %rbx
    941a:	48 83 ec 18          	sub    $0x18,%rsp
    941e:	89 d3                	mov    %edx,%ebx
    9420:	89 f5                	mov    %esi,%ebp
    9422:	49 89 fe             	mov    %rdi,%r14
    9425:	4c 8b 3f             	mov    (%rdi),%r15
    9428:	49 83 c6 08          	add    $0x8,%r14
    942c:	4c 89 f7             	mov    %r14,%rdi
    942f:	4c 89 fe             	mov    %r15,%rsi
    9432:	e8 49 fc ff ff       	call   9080 <fwp_valid_int>
    9437:	85 c0                	test   %eax,%eax
    9439:	0f 84 1a 01 00 00    	je     9559 <fwp_p_parse_int+0x149>
    943f:	41 0f b6 06          	movzbl (%r14),%eax
    9443:	31 ff                	xor    %edi,%edi
    9445:	3c 2d                	cmp    $0x2d,%al
    9447:	0f 94 c1             	sete   %cl
    944a:	3c 2b                	cmp    $0x2b,%al
    944c:	0f 94 c0             	sete   %al
    944f:	08 c8                	or     %cl,%al
    9451:	44 0f b6 e0          	movzbl %al,%r12d
    9455:	4d 39 e7             	cmp    %r12,%r15
    9458:	0f 86 d0 00 00 00    	jbe    952e <fwp_p_parse_int+0x11e>
    945e:	88 4c 24 07          	mov    %cl,0x7(%rsp)
    9462:	89 6c 24 08          	mov    %ebp,0x8(%rsp)
    9466:	89 5c 24 0c          	mov    %ebx,0xc(%rsp)
    946a:	bf 0a 00 00 00       	mov    $0xa,%edi
    946f:	48 bb cd cc cc cc cc 	movabs $0xcccccccccccccccd,%rbx
    9476:	cc cc cc 
    9479:	48 bd cc cc cc cc cc 	movabs $0xcccccccccccccccc,%rbp
    9480:	cc cc cc 
    9483:	31 f6                	xor    %esi,%esi
    9485:	45 31 db             	xor    %r11d,%r11d
    9488:	0f 1f 84 00 00 00 00 	nopl   0x0(%rax,%rax,1)
    948f:	00 
    9490:	4d 89 dd             	mov    %r11,%r13
    9493:	49 89 f0             	mov    %rsi,%r8
    9496:	48 89 f0             	mov    %rsi,%rax
    9499:	48 f7 e7             	mul    %rdi
    949c:	4b 8d 0c 9b          	lea    (%r11,%r11,4),%rcx
    94a0:	48 8d 0c 4a          	lea    (%rdx,%rcx,2),%rcx
    94a4:	43 0f be 14 26       	movsbl (%r14,%r12,1),%edx
    94a9:	83 c2 d0             	add    $0xffffffd0,%edx
    94ac:	48 63 d2             	movslq %edx,%rdx
    94af:	49 89 d3             	mov    %rdx,%r11
    94b2:	49 c1 fb 3f          	sar    $0x3f,%r11
    94b6:	48 89 c6             	mov    %rax,%rsi
    94b9:	48 01 d6             	add    %rdx,%rsi
    94bc:	49 11 cb             	adc    %rcx,%r11
    94bf:	4d 89 d9             	mov    %r11,%r9
    94c2:	49 0f a4 f1 3f       	shld   $0x3f,%rsi,%r9
    94c7:	4c 89 d9             	mov    %r11,%rcx
    94ca:	48 d1 e9             	shr    $1,%rcx
    94cd:	4d 89 ca             	mov    %r9,%r10
    94d0:	49 01 ca             	add    %rcx,%r10
    94d3:	49 83 d2 00          	adc    $0x0,%r10
    94d7:	4c 89 d0             	mov    %r10,%rax
    94da:	48 f7 e3             	mul    %rbx
    94dd:	48 c1 ea 02          	shr    $0x2,%rdx
    94e1:	48 8d 04 92          	lea    (%rdx,%rdx,4),%rax
    94e5:	49 29 c2             	sub    %rax,%r10
    94e8:	4d 29 d1             	sub    %r10,%r9
    94eb:	48 83 d9 00          	sbb    $0x0,%rcx
    94ef:	4d 89 ca             	mov    %r9,%r10
    94f2:	4c 0f af d5          	imul   %rbp,%r10
    94f6:	4c 89 c8             	mov    %r9,%rax
    94f9:	48 f7 e3             	mul    %rbx
    94fc:	4c 01 d2             	add    %r10,%rdx
    94ff:	48 0f af cb          	imul   %rbx,%rcx
    9503:	48 01 d1             	add    %rdx,%rcx
    9506:	4c 31 e9             	xor    %r13,%rcx
    9509:	4c 31 c0             	xor    %r8,%rax
    950c:	48 09 c8             	or     %rcx,%rax
    950f:	75 48                	jne    9559 <fwp_p_parse_int+0x149>
    9511:	49 ff c4             	inc    %r12
    9514:	4d 39 e7             	cmp    %r12,%r15
    9517:	0f 85 73 ff ff ff    	jne    9490 <fwp_p_parse_int+0x80>
    951d:	8b 5c 24 0c          	mov    0xc(%rsp),%ebx
    9521:	8b 6c 24 08          	mov    0x8(%rsp),%ebp
    9525:	31 ff                	xor    %edi,%edi
    9527:	0f b6 4c 24 07       	movzbl 0x7(%rsp),%ecx
    952c:	eb 05                	jmp    9533 <fwp_p_parse_int+0x123>
    952e:	31 f6                	xor    %esi,%esi
    9530:	45 31 db             	xor    %r11d,%r11d
    9533:	40 88 cf             	mov    %cl,%dil
    9536:	4c 8d 4c 24 10       	lea    0x10(%rsp),%r9
    953b:	4c 89 da             	mov    %r11,%rdx
    953e:	89 e9                	mov    %ebp,%ecx
    9540:	41 89 d8             	mov    %ebx,%r8d
    9543:	e8 28 00 00 00       	call   9570 <fwp_int_in_range>
    9548:	48 85 c0             	test   %rax,%rax
    954b:	74 0c                	je     9559 <fwp_p_parse_int+0x149>
    954d:	48 8b 7c 24 10       	mov    0x10(%rsp),%rdi
    9552:	e8 99 00 00 00       	call   95f0 <fwp_some>
    9557:	eb 02                	jmp    955b <fwp_p_parse_int+0x14b>
    9559:	31 c0                	xor    %eax,%eax
    955b:	48 83 c4 18          	add    $0x18,%rsp
    955f:	5b                   	pop    %rbx
    9560:	41 5c                	pop    %r12
    9562:	41 5d                	pop    %r13
    9564:	41 5e                	pop    %r14
    9566:	41 5f                	pop    %r15
    9568:	5d                   	pop    %rbp
    9569:	c3                   	ret
    956a:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)

0000000000009570 <fwp_int_in_range>:
    9570:	53                   	push   %rbx
    9571:	83 f9 09             	cmp    $0x9,%ecx
    9574:	75 24                	jne    959a <fwp_int_in_range+0x2a>
    9576:	85 ff                	test   %edi,%edi
    9578:	74 08                	je     9582 <fwp_int_in_range+0x12>
    957a:	48 89 f0             	mov    %rsi,%rax
    957d:	48 09 d0             	or     %rdx,%rax
    9580:	75 3c                	jne    95be <fwp_int_in_range+0x4e>
    9582:	48 89 f7             	mov    %rsi,%rdi
    9585:	48 89 d6             	mov    %rdx,%rsi
    9588:	4c 89 cb             	mov    %r9,%rbx
    958b:	e8 80 00 00 00       	call   9610 <fwp_box_u128>
    9590:	48 89 03             	mov    %rax,(%rbx)
    9593:	b8 01 00 00 00       	mov    $0x1,%eax
    9598:	5b                   	pop    %rbx
    9599:	c3                   	ret
    959a:	48 89 f0             	mov    %rsi,%rax
    959d:	48 f7 d8             	neg    %rax
    95a0:	48 b8 00 00 00 00 00 	movabs $0x8000000000000000,%rax
    95a7:	00 00 80 
    95aa:	49 89 c2             	mov    %rax,%r10
    95ad:	49 19 d2             	sbb    %rdx,%r10
    95b0:	72 0c                	jb     95be <fwp_int_in_range+0x4e>
    95b2:	85 ff                	test   %edi,%edi
    95b4:	75 0c                	jne    95c2 <fwp_int_in_range+0x52>
    95b6:	48 31 d0             	xor    %rdx,%rax
    95b9:	48 09 f0             	or     %rsi,%rax
    95bc:	75 04                	jne    95c2 <fwp_int_in_range+0x52>
    95be:	31 c0                	xor    %eax,%eax
    95c0:	5b                   	pop    %rbx
    95c1:	c3                   	ret
    95c2:	31 c0                	xor    %eax,%eax
    95c4:	49 89 f2             	mov    %rsi,%r10
    95c7:	49 f7 da             	neg    %r10
    95ca:	48 19 d0             	sbb    %rdx,%rax
    95cd:	85 ff                	test   %edi,%edi
    95cf:	4c 0f 44 d6          	cmove  %rsi,%r10
    95d3:	48 0f 44 c2          	cmove  %rdx,%rax
    95d7:	4c 89 d7             	mov    %r10,%rdi
    95da:	48 89 c6             	mov    %rax,%rsi
    95dd:	89 ca                	mov    %ecx,%edx
    95df:	44 89 c1             	mov    %r8d,%ecx
    95e2:	4d 89 c8             	mov    %r9,%r8
    95e5:	e8 56 00 00 00       	call   9640 <fwp_int_fits>
    95ea:	89 c0                	mov    %eax,%eax
    95ec:	5b                   	pop    %rbx
    95ed:	c3                   	ret
    95ee:	66 90                	xchg   %ax,%ax

00000000000095f0 <fwp_some>:
    95f0:	50                   	push   %rax
    95f1:	48 89 3c 24          	mov    %rdi,(%rsp)
    95f5:	48 89 e2             	mov    %rsp,%rdx
    95f8:	bf 01 00 00 00       	mov    $0x1,%edi
    95fd:	be 01 00 00 00       	mov    $0x1,%esi
    9602:	e8 f9 98 ff ff       	call   2f00 <fwp_data>
    9607:	59                   	pop    %rcx
    9608:	c3                   	ret
    9609:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)

0000000000009610 <fwp_box_u128>:
    9610:	41 56                	push   %r14
    9612:	53                   	push   %rbx
    9613:	50                   	push   %rax
    9614:	48 89 f3             	mov    %rsi,%rbx
    9617:	49 89 fe             	mov    %rdi,%r14
    961a:	bf 10 00 00 00       	mov    $0x10,%edi
    961f:	e8 cc d0 ff ff       	call   66f0 <fwp_alloc_leaf>
    9624:	48 89 58 08          	mov    %rbx,0x8(%rax)
    9628:	4c 89 30             	mov    %r14,(%rax)
    962b:	48 83 c4 08          	add    $0x8,%rsp
    962f:	5b                   	pop    %rbx
    9630:	41 5e                	pop    %r14
    9632:	c3                   	ret
    9633:	66 66 66 66 2e 0f 1f 	data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    963a:	84 00 00 00 00 00 

0000000000009640 <fwp_int_fits>:
    9640:	41 57                	push   %r15
    9642:	41 56                	push   %r14
    9644:	53                   	push   %rbx
    9645:	31 c0                	xor    %eax,%eax
    9647:	83 fa 14             	cmp    $0x14,%edx
    964a:	0f 87 02 01 00 00    	ja     9752 <fwp_int_fits+0x112>
    9650:	89 d2                	mov    %edx,%edx
    9652:	4c 8d 0d 3f 3c 00 00 	lea    0x3c3f(%rip),%r9        # d298 <_IO_stdin_used+0x298>
    9659:	49 63 14 91          	movslq (%r9,%rdx,4),%rdx
    965d:	4c 01 ca             	add    %r9,%rdx
    9660:	ff e2                	jmp    *%rdx
    9662:	48 89 f9             	mov    %rdi,%rcx
    9665:	48 83 c1 80          	add    $0xffffffffffffff80,%rcx
    9669:	48 83 d6 ff          	adc    $0xffffffffffffffff,%rsi
    966d:	48 81 f9 00 ff ff ff 	cmp    $0xffffffffffffff00,%rcx
    9674:	eb 3b                	jmp    96b1 <fwp_int_fits+0x71>
    9676:	48 89 f9             	mov    %rdi,%rcx
    9679:	48 81 c1 00 00 00 80 	add    $0xffffffff80000000,%rcx
    9680:	48 83 d6 ff          	adc    $0xffffffffffffffff,%rsi
    9684:	48 ba 00 00 00 00 ff 	movabs $0xffffffff00000000,%rdx
    968b:	ff ff ff 
    968e:	48 39 d1             	cmp    %rdx,%rcx
    9691:	eb 1e                	jmp    96b1 <fwp_int_fits+0x71>
    9693:	31 c0                	xor    %eax,%eax
    9695:	b9 ff 00 00 00       	mov    $0xff,%ecx
    969a:	eb 2b                	jmp    96c7 <fwp_int_fits+0x87>
    969c:	48 89 f9             	mov    %rdi,%rcx
    969f:	48 81 c1 00 80 ff ff 	add    $0xffffffffffff8000,%rcx
    96a6:	48 83 d6 ff          	adc    $0xffffffffffffffff,%rsi
    96aa:	48 81 f9 00 00 ff ff 	cmp    $0xffffffffffff0000,%rcx
    96b1:	48 83 de ff          	sbb    $0xffffffffffffffff,%rsi
    96b5:	0f 83 8f 00 00 00    	jae    974a <fwp_int_fits+0x10a>
    96bb:	e9 92 00 00 00       	jmp    9752 <fwp_int_fits+0x112>
    96c0:	31 c0                	xor    %eax,%eax
    96c2:	b9 ff ff 00 00       	mov    $0xffff,%ecx
    96c7:	48 39 f9             	cmp    %rdi,%rcx
    96ca:	b9 00 00 00 00       	mov    $0x0,%ecx
    96cf:	48 19 f1             	sbb    %rsi,%rcx
    96d2:	73 76                	jae    974a <fwp_int_fits+0x10a>
    96d4:	eb 7c                	jmp    9752 <fwp_int_fits+0x112>
    96d6:	48 89 f9             	mov    %rdi,%rcx
    96d9:	48 c1 e9 20          	shr    $0x20,%rcx
    96dd:	48 09 f1             	or     %rsi,%rcx
    96e0:	74 68                	je     974a <fwp_int_fits+0x10a>
    96e2:	eb 6e                	jmp    9752 <fwp_int_fits+0x112>
    96e4:	48 b9 00 00 00 00 00 	movabs $0x8000000000000000,%rcx
    96eb:	00 00 80 
    96ee:	48 01 f9             	add    %rdi,%rcx
    96f1:	48 83 d6 ff          	adc    $0xffffffffffffffff,%rsi
    96f5:	48 83 fe ff          	cmp    $0xffffffffffffffff,%rsi
    96f9:	74 4f                	je     974a <fwp_int_fits+0x10a>
    96fb:	eb 55                	jmp    9752 <fwp_int_fits+0x112>
    96fd:	4c 89 c3             	mov    %r8,%rbx
    9700:	e8 5b 00 00 00       	call   9760 <fwp_box_i128>
    9705:	49 89 d8             	mov    %rbx,%r8
    9708:	48 89 c7             	mov    %rax,%rdi
    970b:	eb 3d                	jmp    974a <fwp_int_fits+0x10a>
    970d:	4c 89 c3             	mov    %r8,%rbx
    9710:	49 89 fe             	mov    %rdi,%r14
    9713:	89 cf                	mov    %ecx,%edi
    9715:	49 89 f7             	mov    %rsi,%r15
    9718:	e8 73 00 00 00       	call   9790 <fwp_tint_max>
    971d:	48 89 c1             	mov    %rax,%rcx
    9720:	31 c0                	xor    %eax,%eax
    9722:	49 89 c8             	mov    %rcx,%r8
    9725:	49 f7 d8             	neg    %r8
    9728:	41 b9 00 00 00 00    	mov    $0x0,%r9d
    972e:	49 19 d1             	sbb    %rdx,%r9
    9731:	4c 39 f1             	cmp    %r14,%rcx
    9734:	4c 19 fa             	sbb    %r15,%rdx
    9737:	7c 19                	jl     9752 <fwp_int_fits+0x112>
    9739:	4c 89 fe             	mov    %r15,%rsi
    973c:	4c 89 f7             	mov    %r14,%rdi
    973f:	4d 39 c6             	cmp    %r8,%r14
    9742:	4c 19 ce             	sbb    %r9,%rsi
    9745:	49 89 d8             	mov    %rbx,%r8
    9748:	7c 08                	jl     9752 <fwp_int_fits+0x112>
    974a:	49 89 38             	mov    %rdi,(%r8)
    974d:	b8 01 00 00 00       	mov    $0x1,%eax
    9752:	5b                   	pop    %rbx
    9753:	41 5e                	pop    %r14
    9755:	41 5f                	pop    %r15
    9757:	c3                   	ret
    9758:	48 85 f6             	test   %rsi,%rsi
    975b:	74 ed                	je     974a <fwp_int_fits+0x10a>
    975d:	eb f3                	jmp    9752 <fwp_int_fits+0x112>
    975f:	90                   	nop

0000000000009760 <fwp_box_i128>:
    9760:	41 56                	push   %r14
    9762:	53                   	push   %rbx
    9763:	50                   	push   %rax
    9764:	48 89 f3             	mov    %rsi,%rbx
    9767:	49 89 fe             	mov    %rdi,%r14
    976a:	bf 10 00 00 00       	mov    $0x10,%edi
    976f:	e8 7c cf ff ff       	call   66f0 <fwp_alloc_leaf>
    9774:	48 89 58 08          	mov    %rbx,0x8(%rax)
    9778:	4c 89 30             	mov    %r14,(%rax)
    977b:	48 83 c4 08          	add    $0x8,%rsp
    977f:	5b                   	pop    %rbx
    9780:	41 5e                	pop    %r14
    9782:	c3                   	ret
    9783:	66 66 66 66 2e 0f 1f 	data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    978a:	84 00 00 00 00 00 

0000000000009790 <fwp_tint_max>:
    9790:	85 ff                	test   %edi,%edi
    9792:	7e 27                	jle    97bb <fwp_tint_max+0x2b>
    9794:	8d 47 ff             	lea    -0x1(%rdi),%eax
    9797:	83 f8 4f             	cmp    $0x4f,%eax
    979a:	41 b8 4f 00 00 00    	mov    $0x4f,%r8d
    97a0:	44 0f 42 c0          	cmovb  %eax,%r8d
    97a4:	41 ff c0             	inc    %r8d
    97a7:	44 89 c6             	mov    %r8d,%esi
    97aa:	83 e6 07             	and    $0x7,%esi
    97ad:	83 ff 08             	cmp    $0x8,%edi
    97b0:	73 11                	jae    97c3 <fwp_tint_max+0x33>
    97b2:	b8 01 00 00 00       	mov    $0x1,%eax
    97b7:	31 c9                	xor    %ecx,%ecx
    97b9:	eb 38                	jmp    97f3 <fwp_tint_max+0x63>
    97bb:	31 c0                	xor    %eax,%eax
    97bd:	31 c9                	xor    %ecx,%ecx
    97bf:	48 89 ca             	mov    %rcx,%rdx
    97c2:	c3                   	ret
    97c3:	41 81 e0 f8 00 00 00 	and    $0xf8,%r8d
    97ca:	b8 01 00 00 00       	mov    $0x1,%eax
    97cf:	31 c9                	xor    %ecx,%ecx
    97d1:	bf a1 19 00 00       	mov    $0x19a1,%edi
    97d6:	66 2e 0f 1f 84 00 00 	cs nopw 0x0(%rax,%rax,1)
    97dd:	00 00 00 
    97e0:	48 f7 e7             	mul    %rdi
    97e3:	48 69 c9 a1 19 00 00 	imul   $0x19a1,%rcx,%rcx
    97ea:	48 01 d1             	add    %rdx,%rcx
    97ed:	41 83 c0 f8          	add    $0xfffffff8,%r8d
    97f1:	75 ed                	jne    97e0 <fwp_tint_max+0x50>
    97f3:	85 f6                	test   %esi,%esi
    97f5:	74 17                	je     980e <fwp_tint_max+0x7e>
    97f7:	bf 03 00 00 00       	mov    $0x3,%edi
    97fc:	0f 1f 40 00          	nopl   0x0(%rax)
    9800:	48 f7 e7             	mul    %rdi
    9803:	48 8d 0c 49          	lea    (%rcx,%rcx,2),%rcx
    9807:	48 01 d1             	add    %rdx,%rcx
    980a:	ff ce                	dec    %esi
    980c:	75 f2                	jne    9800 <fwp_tint_max+0x70>
    980e:	48 83 c0 ff          	add    $0xffffffffffffffff,%rax
    9812:	48 83 d1 ff          	adc    $0xffffffffffffffff,%rcx
    9816:	48 89 ca             	mov    %rcx,%rdx
    9819:	48 c1 ea 3f          	shr    $0x3f,%rdx
    981d:	48 01 c2             	add    %rax,%rdx
    9820:	48 89 d0             	mov    %rdx,%rax
    9823:	48 83 d1 00          	adc    $0x0,%rcx
    9827:	48 0f ac c8 01       	shrd   $0x1,%rcx,%rax
    982c:	48 d1 f9             	sar    $1,%rcx
    982f:	48 89 ca             	mov    %rcx,%rdx
    9832:	c3                   	ret
    9833:	66 66 66 66 2e 0f 1f 	data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    983a:	84 00 00 00 00 00 

0000000000009840 <fwp_valid_float>:
    9840:	48 85 f6             	test   %rsi,%rsi
    9843:	74 0e                	je     9853 <fwp_valid_float+0x13>
    9845:	0f b6 07             	movzbl (%rdi),%eax
    9848:	04 d5                	add    $0xd5,%al
    984a:	31 d2                	xor    %edx,%edx
    984c:	a8 fd                	test   $0xfd,%al
    984e:	0f 94 c2             	sete   %dl
    9851:	eb 02                	jmp    9855 <fwp_valid_float+0x15>
    9853:	31 d2                	xor    %edx,%edx
    9855:	41 b1 01             	mov    $0x1,%r9b
    9858:	49 89 d0             	mov    %rdx,%r8
    985b:	48 39 f2             	cmp    %rsi,%rdx
    985e:	73 1d                	jae    987d <fwp_valid_float+0x3d>
    9860:	42 0f b6 04 07       	movzbl (%rdi,%r8,1),%eax
    9865:	8d 48 d0             	lea    -0x30(%rax),%ecx
    9868:	80 f9 09             	cmp    $0x9,%cl
    986b:	77 15                	ja     9882 <fwp_valid_float+0x42>
    986d:	49 ff c0             	inc    %r8
    9870:	4c 39 c6             	cmp    %r8,%rsi
    9873:	75 eb                	jne    9860 <fwp_valid_float+0x20>
    9875:	49 89 f0             	mov    %rsi,%r8
    9878:	48 89 f1             	mov    %rsi,%rcx
    987b:	eb 38                	jmp    98b5 <fwp_valid_float+0x75>
    987d:	48 89 d1             	mov    %rdx,%rcx
    9880:	eb 33                	jmp    98b5 <fwp_valid_float+0x75>
    9882:	3c 2e                	cmp    $0x2e,%al
    9884:	75 2c                	jne    98b2 <fwp_valid_float+0x72>
    9886:	49 8d 48 01          	lea    0x1(%r8),%rcx
    988a:	48 39 f1             	cmp    %rsi,%rcx
    988d:	73 16                	jae    98a5 <fwp_valid_float+0x65>
    988f:	90                   	nop
    9890:	0f b6 04 0f          	movzbl (%rdi,%rcx,1),%eax
    9894:	04 d0                	add    $0xd0,%al
    9896:	3c 09                	cmp    $0x9,%al
    9898:	77 0b                	ja     98a5 <fwp_valid_float+0x65>
    989a:	48 ff c1             	inc    %rcx
    989d:	48 39 f1             	cmp    %rsi,%rcx
    98a0:	72 ee                	jb     9890 <fwp_valid_float+0x50>
    98a2:	48 89 f1             	mov    %rsi,%rcx
    98a5:	48 8d 41 ff          	lea    -0x1(%rcx),%rax
    98a9:	4c 39 c0             	cmp    %r8,%rax
    98ac:	41 0f 94 c1          	sete   %r9b
    98b0:	eb 03                	jmp    98b5 <fwp_valid_float+0x75>
    98b2:	4c 89 c1             	mov    %r8,%rcx
    98b5:	31 c0                	xor    %eax,%eax
    98b7:	49 39 d0             	cmp    %rdx,%r8
    98ba:	75 06                	jne    98c2 <fwp_valid_float+0x82>
    98bc:	45 84 c9             	test   %r9b,%r9b
    98bf:	74 01                	je     98c2 <fwp_valid_float+0x82>
    98c1:	c3                   	ret
    98c2:	48 39 f1             	cmp    %rsi,%rcx
    98c5:	73 58                	jae    991f <fwp_valid_float+0xdf>
    98c7:	0f b6 14 0f          	movzbl (%rdi,%rcx,1),%edx
    98cb:	83 ca 20             	or     $0x20,%edx
    98ce:	83 fa 65             	cmp    $0x65,%edx
    98d1:	75 4c                	jne    991f <fwp_valid_float+0xdf>
    98d3:	48 8d 51 01          	lea    0x1(%rcx),%rdx
    98d7:	48 39 f2             	cmp    %rsi,%rdx
    98da:	73 18                	jae    98f4 <fwp_valid_float+0xb4>
    98dc:	44 0f b6 04 17       	movzbl (%rdi,%rdx,1),%r8d
    98e1:	41 83 f8 2d          	cmp    $0x2d,%r8d
    98e5:	74 06                	je     98ed <fwp_valid_float+0xad>
    98e7:	41 83 f8 2b          	cmp    $0x2b,%r8d
    98eb:	75 07                	jne    98f4 <fwp_valid_float+0xb4>
    98ed:	48 83 c1 02          	add    $0x2,%rcx
    98f1:	48 89 ca             	mov    %rcx,%rdx
    98f4:	48 39 f2             	cmp    %rsi,%rdx
    98f7:	73 c8                	jae    98c1 <fwp_valid_float+0x81>
    98f9:	48 89 d1             	mov    %rdx,%rcx
    98fc:	0f 1f 40 00          	nopl   0x0(%rax)
    9900:	44 0f b6 04 0f       	movzbl (%rdi,%rcx,1),%r8d
    9905:	41 80 c0 d0          	add    $0xd0,%r8b
    9909:	41 80 f8 09          	cmp    $0x9,%r8b
    990d:	77 0b                	ja     991a <fwp_valid_float+0xda>
    990f:	48 ff c1             	inc    %rcx
    9912:	48 39 ce             	cmp    %rcx,%rsi
    9915:	75 e9                	jne    9900 <fwp_valid_float+0xc0>
    9917:	48 89 f1             	mov    %rsi,%rcx
    991a:	48 39 d1             	cmp    %rdx,%rcx
    991d:	74 a2                	je     98c1 <fwp_valid_float+0x81>
    991f:	31 c0                	xor    %eax,%eax
    9921:	48 39 f1             	cmp    %rsi,%rcx
    9924:	0f 94 c0             	sete   %al
    9927:	c3                   	ret
    9928:	0f 1f 84 00 00 00 00 	nopl   0x0(%rax,%rax,1)
    992f:	00 

0000000000009930 <fwp_float_of>:
    9930:	83 ff 0a             	cmp    $0xa,%edi
    9933:	0f 85 07 90 ff ff    	jne    2940 <fwp_from_f64>
    9939:	f2 0f 5a c0          	cvtsd2ss %xmm0,%xmm0
    993d:	e9 fe b4 ff ff       	jmp    4e40 <fwp_from_f32>
    9942:	66 66 66 66 66 2e 0f 	data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    9949:	1f 84 00 00 00 00 00 

0000000000009950 <fwp_utf8_put>:
    9950:	50                   	push   %rax
    9951:	83 fe 7f             	cmp    $0x7f,%esi
    9954:	77 0f                	ja     9965 <fwp_utf8_put+0x15>
    9956:	40 88 74 24 04       	mov    %sil,0x4(%rsp)
    995b:	ba 01 00 00 00       	mov    $0x1,%edx
    9960:	e9 8e 00 00 00       	jmp    99f3 <fwp_utf8_put+0xa3>
    9965:	89 f0                	mov    %esi,%eax
    9967:	81 fe ff 07 00 00    	cmp    $0x7ff,%esi
    996d:	77 1d                	ja     998c <fwp_utf8_put+0x3c>
    996f:	c1 e8 06             	shr    $0x6,%eax
    9972:	0c c0                	or     $0xc0,%al
    9974:	88 44 24 04          	mov    %al,0x4(%rsp)
    9978:	40 80 e6 3f          	and    $0x3f,%sil
    997c:	40 80 ce 80          	or     $0x80,%sil
    9980:	40 88 74 24 05       	mov    %sil,0x5(%rsp)
    9985:	ba 02 00 00 00       	mov    $0x2,%edx
    998a:	eb 67                	jmp    99f3 <fwp_utf8_put+0xa3>
    998c:	81 fe ff ff 00 00    	cmp    $0xffff,%esi
    9992:	77 2a                	ja     99be <fwp_utf8_put+0x6e>
    9994:	c1 e8 0c             	shr    $0xc,%eax
    9997:	0c e0                	or     $0xe0,%al
    9999:	88 44 24 04          	mov    %al,0x4(%rsp)
    999d:	89 f0                	mov    %esi,%eax
    999f:	c1 e8 06             	shr    $0x6,%eax
    99a2:	24 3f                	and    $0x3f,%al
    99a4:	0c 80                	or     $0x80,%al
    99a6:	88 44 24 05          	mov    %al,0x5(%rsp)
    99aa:	40 80 e6 3f          	and    $0x3f,%sil
    99ae:	40 80 ce 80          	or     $0x80,%sil
    99b2:	40 88 74 24 06       	mov    %sil,0x6(%rsp)
    99b7:	ba 03 00 00 00       	mov    $0x3,%edx
    99bc:	eb 35                	jmp    99f3 <fwp_utf8_put+0xa3>
    99be:	c1 e8 12             	shr    $0x12,%eax
    99c1:	0c f0                	or     $0xf0,%al
    99c3:	88 44 24 04          	mov    %al,0x4(%rsp)
    99c7:	89 f0                	mov    %esi,%eax
    99c9:	c1 e8 0c             	shr    $0xc,%eax
    99cc:	24 3f                	and    $0x3f,%al
    99ce:	0c 80                	or     $0x80,%al
    99d0:	88 44 24 05          	mov    %al,0x5(%rsp)
    99d4:	89 f0                	mov    %esi,%eax
    99d6:	c1 e8 06             	shr    $0x6,%eax
    99d9:	24 3f                	and    $0x3f,%al
    99db:	0c 80                	or     $0x80,%al
    99dd:	88 44 24 06          	mov    %al,0x6(%rsp)
    99e1:	40 80 e6 3f          	and    $0x3f,%sil
    99e5:	40 80 ce 80          	or     $0x80,%sil
    99e9:	40 88 74 24 07       	mov    %sil,0x7(%rsp)
    99ee:	ba 04 00 00 00       	mov    $0x4,%edx
    99f3:	48 8d 74 24 04       	lea    0x4(%rsp),%rsi
    99f8:	e8 43 df ff ff       	call   7940 <buf_put>
    99fd:	58                   	pop    %rax
    99fe:	c3                   	ret
    99ff:	90                   	nop

0000000000009a00 <tp_push>:
    9a00:	41 56                	push   %r14
    9a02:	53                   	push   %rbx
    9a03:	50                   	push   %rax
    9a04:	48 89 f3             	mov    %rsi,%rbx
    9a07:	49 89 fe             	mov    %rdi,%r14
    9a0a:	48 8b 77 18          	mov    0x18(%rdi),%rsi
    9a0e:	48 3b 77 20          	cmp    0x20(%rdi),%rsi
    9a12:	75 2f                	jne    9a43 <tp_push+0x43>
    9a14:	48 8d 04 36          	lea    (%rsi,%rsi,1),%rax
    9a18:	48 85 f6             	test   %rsi,%rsi
    9a1b:	ba 08 00 00 00       	mov    $0x8,%edx
    9a20:	48 0f 45 d0          	cmovne %rax,%rdx
    9a24:	49 89 56 20          	mov    %rdx,0x20(%r14)
    9a28:	49 8b 7e 10          	mov    0x10(%r14),%rdi
    9a2c:	48 c1 e6 03          	shl    $0x3,%rsi
    9a30:	48 c1 e2 03          	shl    $0x3,%rdx
    9a34:	e8 07 dc ff ff       	call   7640 <fwp_mem_realloc>
    9a39:	49 89 46 10          	mov    %rax,0x10(%r14)
    9a3d:	49 8b 76 18          	mov    0x18(%r14),%rsi
    9a41:	eb 04                	jmp    9a47 <tp_push+0x47>
    9a43:	49 8b 46 10          	mov    0x10(%r14),%rax
    9a47:	48 8d 4e 01          	lea    0x1(%rsi),%rcx
    9a4b:	49 89 4e 18          	mov    %rcx,0x18(%r14)
    9a4f:	48 89 1c f0          	mov    %rbx,(%rax,%rsi,8)
    9a53:	48 83 c4 08          	add    $0x8,%rsp
    9a57:	5b                   	pop    %rbx
    9a58:	41 5e                	pop    %r14
    9a5a:	c3                   	ret
    9a5b:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)

0000000000009a60 <tp_is_delim>:
    9a60:	b8 01 00 00 00       	mov    $0x1,%eax
    9a65:	83 ff 2c             	cmp    $0x2c,%edi
    9a68:	77 13                	ja     9a7d <tp_is_delim+0x1d>
    9a6a:	89 f9                	mov    %edi,%ecx
    9a6c:	48 ba 00 26 00 00 01 	movabs $0x130100002600,%rdx
    9a73:	13 00 00 
    9a76:	48 0f a3 ca          	bt     %rcx,%rdx
    9a7a:	73 01                	jae    9a7d <tp_is_delim+0x1d>
    9a7c:	c3                   	ret
    9a7d:	83 ff 5d             	cmp    $0x5d,%edi
    9a80:	74 fa                	je     9a7c <tp_is_delim+0x1c>
    9a82:	83 ff 7d             	cmp    $0x7d,%edi
    9a85:	74 f5                	je     9a7c <tp_is_delim+0x1c>
    9a87:	31 c0                	xor    %eax,%eax
    9a89:	40 80 ff 3a          	cmp    $0x3a,%dil
    9a8d:	0f 94 c0             	sete   %al
    9a90:	c3                   	ret
    9a91:	66 66 66 66 66 66 2e 	data16 data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    9a98:	0f 1f 84 00 00 00 00 
    9a9f:	00 

0000000000009aa0 <fwp_list_len>:
    9aa0:	31 c0                	xor    %eax,%eax
    9aa2:	48 85 ff             	test   %rdi,%rdi
    9aa5:	74 15                	je     9abc <fwp_list_len+0x1c>
    9aa7:	66 0f 1f 84 00 00 00 	nopw   0x0(%rax,%rax,1)
    9aae:	00 00 
    9ab0:	48 ff c0             	inc    %rax
    9ab3:	48 8b 7f 10          	mov    0x10(%rdi),%rdi
    9ab7:	48 85 ff             	test   %rdi,%rdi
    9aba:	75 f4                	jne    9ab0 <fwp_list_len+0x10>
    9abc:	c3                   	ret
    9abd:	0f 1f 00             	nopl   (%rax)

0000000000009ac0 <fwp_map_find>:
    9ac0:	55                   	push   %rbp
    9ac1:	41 57                	push   %r15
    9ac3:	41 56                	push   %r14
    9ac5:	41 55                	push   %r13
    9ac7:	41 54                	push   %r12
    9ac9:	53                   	push   %rbx
    9aca:	50                   	push   %rax
    9acb:	49 89 f6             	mov    %rsi,%r14
    9ace:	49 89 ff             	mov    %rdi,%r15
    9ad1:	48 8b 2f             	mov    (%rdi),%rbp
    9ad4:	8b 02                	mov    (%rdx),%eax
    9ad6:	83 f8 04             	cmp    $0x4,%eax
    9ad9:	72 53                	jb     9b2e <fwp_map_find+0x6e>
    9adb:	83 c0 fb             	add    $0xfffffffb,%eax
    9ade:	83 f8 04             	cmp    $0x4,%eax
    9ae1:	0f 83 a3 00 00 00    	jae    9b8a <fwp_map_find+0xca>
    9ae7:	48 85 ed             	test   %rbp,%rbp
    9aea:	0f 84 f7 00 00 00    	je     9be7 <fwp_map_find+0x127>
    9af0:	31 f6                	xor    %esi,%esi
    9af2:	48 b8 fe ff ff ff ff 	movabs $0x1ffffffffffffffe,%rax
    9af9:	ff ff 1f 
    9afc:	eb 0a                	jmp    9b08 <fwp_map_find+0x48>
    9afe:	66 90                	xchg   %ax,%ax
    9b00:	4c 89 e5             	mov    %r12,%rbp
    9b03:	48 39 ee             	cmp    %rbp,%rsi
    9b06:	73 74                	jae    9b7c <fwp_map_find+0xbc>
    9b08:	48 8d 14 2e          	lea    (%rsi,%rbp,1),%rdx
    9b0c:	49 89 d4             	mov    %rdx,%r12
    9b0f:	49 d1 ec             	shr    $1,%r12
    9b12:	48 21 c2             	and    %rax,%rdx
    9b15:	49 8b 54 d7 08       	mov    0x8(%r15,%rdx,8),%rdx
    9b1a:	4c 39 f2             	cmp    %r14,%rdx
    9b1d:	74 64                	je     9b83 <fwp_map_find+0xc3>
    9b1f:	73 df                	jae    9b00 <fwp_map_find+0x40>
    9b21:	49 ff c4             	inc    %r12
    9b24:	4c 89 e6             	mov    %r12,%rsi
    9b27:	48 39 ee             	cmp    %rbp,%rsi
    9b2a:	72 dc                	jb     9b08 <fwp_map_find+0x48>
    9b2c:	eb 4e                	jmp    9b7c <fwp_map_find+0xbc>
    9b2e:	48 85 ed             	test   %rbp,%rbp
    9b31:	0f 84 b0 00 00 00    	je     9be7 <fwp_map_find+0x127>
    9b37:	31 f6                	xor    %esi,%esi
    9b39:	48 b8 fe ff ff ff ff 	movabs $0x1ffffffffffffffe,%rax
    9b40:	ff ff 1f 
    9b43:	eb 13                	jmp    9b58 <fwp_map_find+0x98>
    9b45:	66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
    9b4c:	00 00 00 00 
    9b50:	4c 89 e5             	mov    %r12,%rbp
    9b53:	48 39 ee             	cmp    %rbp,%rsi
    9b56:	73 24                	jae    9b7c <fwp_map_find+0xbc>
    9b58:	48 8d 14 2e          	lea    (%rsi,%rbp,1),%rdx
    9b5c:	49 89 d4             	mov    %rdx,%r12
    9b5f:	49 d1 ec             	shr    $1,%r12
    9b62:	48 21 c2             	and    %rax,%rdx
    9b65:	49 8b 54 d7 08       	mov    0x8(%r15,%rdx,8),%rdx
    9b6a:	4c 39 f2             	cmp    %r14,%rdx
    9b6d:	74 14                	je     9b83 <fwp_map_find+0xc3>
    9b6f:	7d df                	jge    9b50 <fwp_map_find+0x90>
    9b71:	49 ff c4             	inc    %r12
    9b74:	4c 89 e6             	mov    %r12,%rsi
    9b77:	48 39 ee             	cmp    %rbp,%rsi
    9b7a:	72 dc                	jb     9b58 <fwp_map_find+0x98>
    9b7c:	31 c0                	xor    %eax,%eax
    9b7e:	49 89 f4             	mov    %rsi,%r12
    9b81:	eb 69                	jmp    9bec <fwp_map_find+0x12c>
    9b83:	b8 01 00 00 00       	mov    $0x1,%eax
    9b88:	eb 62                	jmp    9bec <fwp_map_find+0x12c>
    9b8a:	48 85 ed             	test   %rbp,%rbp
    9b8d:	74 58                	je     9be7 <fwp_map_find+0x127>
    9b8f:	49 89 d5             	mov    %rdx,%r13
    9b92:	48 89 0c 24          	mov    %rcx,(%rsp)
    9b96:	31 db                	xor    %ebx,%ebx
    9b98:	eb 0e                	jmp    9ba8 <fwp_map_find+0xe8>
    9b9a:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)
    9ba0:	4c 89 e5             	mov    %r12,%rbp
    9ba3:	48 39 eb             	cmp    %rbp,%rbx
    9ba6:	73 38                	jae    9be0 <fwp_map_find+0x120>
    9ba8:	48 8d 04 2b          	lea    (%rbx,%rbp,1),%rax
    9bac:	49 89 c4             	mov    %rax,%r12
    9baf:	49 d1 ec             	shr    $1,%r12
    9bb2:	48 b9 fe ff ff ff ff 	movabs $0x1ffffffffffffffe,%rcx
    9bb9:	ff ff 1f 
    9bbc:	48 21 c8             	and    %rcx,%rax
    9bbf:	49 8b 7c c7 08       	mov    0x8(%r15,%rax,8),%rdi
    9bc4:	4c 89 f6             	mov    %r14,%rsi
    9bc7:	4c 89 ea             	mov    %r13,%rdx
    9bca:	e8 61 00 00 00       	call   9c30 <fwp_cmp>
    9bcf:	85 c0                	test   %eax,%eax
    9bd1:	74 2d                	je     9c00 <fwp_map_find+0x140>
    9bd3:	79 cb                	jns    9ba0 <fwp_map_find+0xe0>
    9bd5:	49 ff c4             	inc    %r12
    9bd8:	4c 89 e3             	mov    %r12,%rbx
    9bdb:	48 39 eb             	cmp    %rbp,%rbx
    9bde:	72 c8                	jb     9ba8 <fwp_map_find+0xe8>
    9be0:	31 c0                	xor    %eax,%eax
    9be2:	49 89 dc             	mov    %rbx,%r12
    9be5:	eb 1e                	jmp    9c05 <fwp_map_find+0x145>
    9be7:	31 c0                	xor    %eax,%eax
    9be9:	45 31 e4             	xor    %r12d,%r12d
    9bec:	89 01                	mov    %eax,(%rcx)
    9bee:	4c 89 e0             	mov    %r12,%rax
    9bf1:	48 83 c4 08          	add    $0x8,%rsp
    9bf5:	5b                   	pop    %rbx
    9bf6:	41 5c                	pop    %r12
    9bf8:	41 5d                	pop    %r13
    9bfa:	41 5e                	pop    %r14
    9bfc:	41 5f                	pop    %r15
    9bfe:	5d                   	pop    %rbp
    9bff:	c3                   	ret
    9c00:	b8 01 00 00 00       	mov    $0x1,%eax
    9c05:	48 8b 0c 24          	mov    (%rsp),%rcx
    9c09:	eb e1                	jmp    9bec <fwp_map_find+0x12c>
    9c0b:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)

0000000000009c10 <fwp_map_alloc>:
    9c10:	53                   	push   %rbx
    9c11:	48 89 fb             	mov    %rdi,%rbx
    9c14:	48 c1 e7 04          	shl    $0x4,%rdi
    9c18:	48 83 cf 08          	or     $0x8,%rdi
    9c1c:	e8 8f b9 ff ff       	call   55b0 <fwp_alloc>
    9c21:	48 89 18             	mov    %rbx,(%rax)
    9c24:	5b                   	pop    %rbx
    9c25:	c3                   	ret
    9c26:	66 2e 0f 1f 84 00 00 	cs nopw 0x0(%rax,%rax,1)
    9c2d:	00 00 00 

0000000000009c30 <fwp_cmp>:
    9c30:	55                   	push   %rbp
    9c31:	41 57                	push   %r15
    9c33:	41 56                	push   %r14
    9c35:	41 55                	push   %r13
    9c37:	41 54                	push   %r12
    9c39:	53                   	push   %rbx
    9c3a:	48 83 ec 18          	sub    $0x18,%rsp
    9c3e:	48 89 f3             	mov    %rsi,%rbx
    9c41:	49 89 fe             	mov    %rdi,%r14
    9c44:	44 8b 2a             	mov    (%rdx),%r13d
    9c47:	49 83 fd 15          	cmp    $0x15,%r13
    9c4b:	77 25                	ja     9c72 <fwp_cmp+0x42>
    9c4d:	49 89 d7             	mov    %rdx,%r15
    9c50:	48 8d 05 95 36 00 00 	lea    0x3695(%rip),%rax        # d2ec <_IO_stdin_used+0x2ec>
    9c57:	4a 63 0c a8          	movslq (%rax,%r13,4),%rcx
    9c5b:	48 01 c1             	add    %rax,%rcx
    9c5e:	ff e1                	jmp    *%rcx
    9c60:	31 c9                	xor    %ecx,%ecx
    9c62:	49 39 de             	cmp    %rbx,%r14
    9c65:	0f 9f c1             	setg   %cl
    9c68:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    9c6d:	0f 4d c1             	cmovge %ecx,%eax
    9c70:	eb 10                	jmp    9c82 <fwp_cmp+0x52>
    9c72:	31 c9                	xor    %ecx,%ecx
    9c74:	49 39 de             	cmp    %rbx,%r14
    9c77:	0f 97 c1             	seta   %cl
    9c7a:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    9c7f:	0f 43 c1             	cmovae %ecx,%eax
    9c82:	48 83 c4 18          	add    $0x18,%rsp
    9c86:	5b                   	pop    %rbx
    9c87:	41 5c                	pop    %r12
    9c89:	41 5d                	pop    %r13
    9c8b:	41 5e                	pop    %r14
    9c8d:	41 5f                	pop    %r15
    9c8f:	5d                   	pop    %rbp
    9c90:	c3                   	ret
    9c91:	4d 8b 3e             	mov    (%r14),%r15
    9c94:	4c 8b 23             	mov    (%rbx),%r12
    9c97:	49 83 c6 08          	add    $0x8,%r14
    9c9b:	48 83 c3 08          	add    $0x8,%rbx
    9c9f:	4d 39 e7             	cmp    %r12,%r15
    9ca2:	4c 89 e2             	mov    %r12,%rdx
    9ca5:	49 0f 42 d7          	cmovb  %r15,%rdx
    9ca9:	4c 89 f7             	mov    %r14,%rdi
    9cac:	48 89 de             	mov    %rbx,%rsi
    9caf:	e8 bc 85 ff ff       	call   2270 <memcmp@plt>
    9cb4:	85 c0                	test   %eax,%eax
    9cb6:	0f 84 ce 02 00 00    	je     9f8a <fwp_cmp+0x35a>
    9cbc:	c1 f8 1f             	sar    $0x1f,%eax
    9cbf:	83 c8 01             	or     $0x1,%eax
    9cc2:	eb be                	jmp    9c82 <fwp_cmp+0x52>
    9cc4:	49 8b 06             	mov    (%r14),%rax
    9cc7:	48 8b 2b             	mov    (%rbx),%rbp
    9cca:	48 39 e8             	cmp    %rbp,%rax
    9ccd:	48 89 6c 24 08       	mov    %rbp,0x8(%rsp)
    9cd2:	48 89 44 24 10       	mov    %rax,0x10(%rsp)
    9cd7:	48 0f 42 e8          	cmovb  %rax,%rbp
    9cdb:	48 85 ed             	test   %rbp,%rbp
    9cde:	74 54                	je     9d34 <fwp_cmp+0x104>
    9ce0:	49 8b 47 38          	mov    0x38(%r15),%rax
    9ce4:	48 89 04 24          	mov    %rax,(%rsp)
    9ce8:	41 bc 10 00 00 00    	mov    $0x10,%r12d
    9cee:	eb 09                	jmp    9cf9 <fwp_cmp+0xc9>
    9cf0:	49 83 c4 10          	add    $0x10,%r12
    9cf4:	48 ff cd             	dec    %rbp
    9cf7:	74 3b                	je     9d34 <fwp_cmp+0x104>
    9cf9:	4b 8b 7c 26 f8       	mov    -0x8(%r14,%r12,1),%rdi
    9cfe:	4a 8b 74 23 f8       	mov    -0x8(%rbx,%r12,1),%rsi
    9d03:	48 8b 14 24          	mov    (%rsp),%rdx
    9d07:	e8 24 ff ff ff       	call   9c30 <fwp_cmp>
    9d0c:	85 c0                	test   %eax,%eax
    9d0e:	0f 85 6e ff ff ff    	jne    9c82 <fwp_cmp+0x52>
    9d14:	41 83 fd 12          	cmp    $0x12,%r13d
    9d18:	75 d6                	jne    9cf0 <fwp_cmp+0xc0>
    9d1a:	4b 8b 3c 26          	mov    (%r14,%r12,1),%rdi
    9d1e:	4a 8b 34 23          	mov    (%rbx,%r12,1),%rsi
    9d22:	49 8b 57 40          	mov    0x40(%r15),%rdx
    9d26:	e8 05 ff ff ff       	call   9c30 <fwp_cmp>
    9d2b:	85 c0                	test   %eax,%eax
    9d2d:	74 c1                	je     9cf0 <fwp_cmp+0xc0>
    9d2f:	e9 4e ff ff ff       	jmp    9c82 <fwp_cmp+0x52>
    9d34:	31 c9                	xor    %ecx,%ecx
    9d36:	48 8b 44 24 08       	mov    0x8(%rsp),%rax
    9d3b:	48 39 44 24 10       	cmp    %rax,0x10(%rsp)
    9d40:	e9 32 ff ff ff       	jmp    9c77 <fwp_cmp+0x47>
    9d45:	4c 89 f7             	mov    %r14,%rdi
    9d48:	e8 73 02 00 00       	call   9fc0 <fwp_u128>
    9d4d:	49 89 c7             	mov    %rax,%r15
    9d50:	49 89 d6             	mov    %rdx,%r14
    9d53:	48 89 df             	mov    %rbx,%rdi
    9d56:	e8 65 02 00 00       	call   9fc0 <fwp_u128>
    9d5b:	48 89 c1             	mov    %rax,%rcx
    9d5e:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    9d63:	49 39 cf             	cmp    %rcx,%r15
    9d66:	4c 89 f6             	mov    %r14,%rsi
    9d69:	48 19 d6             	sbb    %rdx,%rsi
    9d6c:	0f 82 10 ff ff ff    	jb     9c82 <fwp_cmp+0x52>
    9d72:	4c 39 f9             	cmp    %r15,%rcx
    9d75:	4c 19 f2             	sbb    %r14,%rdx
    9d78:	0f 92 c0             	setb   %al
    9d7b:	0f b6 c0             	movzbl %al,%eax
    9d7e:	e9 ff fe ff ff       	jmp    9c82 <fwp_cmp+0x52>
    9d83:	4c 89 f7             	mov    %r14,%rdi
    9d86:	e8 a5 b0 ff ff       	call   4e30 <fwp_f32>
    9d8b:	e8 40 02 00 00       	call   9fd0 <fwp_total_key32>
    9d90:	89 c5                	mov    %eax,%ebp
    9d92:	48 89 df             	mov    %rbx,%rdi
    9d95:	e8 96 b0 ff ff       	call   4e30 <fwp_f32>
    9d9a:	e8 31 02 00 00       	call   9fd0 <fwp_total_key32>
    9d9f:	89 c1                	mov    %eax,%ecx
    9da1:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    9da6:	39 cd                	cmp    %ecx,%ebp
    9da8:	0f 8c d4 fe ff ff    	jl     9c82 <fwp_cmp+0x52>
    9dae:	eb 2e                	jmp    9dde <fwp_cmp+0x1ae>
    9db0:	4c 89 f7             	mov    %r14,%rdi
    9db3:	e8 e8 90 ff ff       	call   2ea0 <fwp_f64>
    9db8:	e8 23 02 00 00       	call   9fe0 <fwp_total_key64>
    9dbd:	49 89 c6             	mov    %rax,%r14
    9dc0:	48 89 df             	mov    %rbx,%rdi
    9dc3:	e8 d8 90 ff ff       	call   2ea0 <fwp_f64>
    9dc8:	e8 13 02 00 00       	call   9fe0 <fwp_total_key64>
    9dcd:	48 89 c1             	mov    %rax,%rcx
    9dd0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    9dd5:	49 39 ce             	cmp    %rcx,%r14
    9dd8:	0f 8c a4 fe ff ff    	jl     9c82 <fwp_cmp+0x52>
    9dde:	0f 9f c0             	setg   %al
    9de1:	0f b6 c0             	movzbl %al,%eax
    9de4:	e9 99 fe ff ff       	jmp    9c82 <fwp_cmp+0x52>
    9de9:	4c 89 f7             	mov    %r14,%rdi
    9dec:	e8 bf 01 00 00       	call   9fb0 <fwp_i128>
    9df1:	49 89 c7             	mov    %rax,%r15
    9df4:	49 89 d6             	mov    %rdx,%r14
    9df7:	48 89 df             	mov    %rbx,%rdi
    9dfa:	e8 b1 01 00 00       	call   9fb0 <fwp_i128>
    9dff:	48 89 c1             	mov    %rax,%rcx
    9e02:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    9e07:	49 39 cf             	cmp    %rcx,%r15
    9e0a:	4c 89 f6             	mov    %r14,%rsi
    9e0d:	48 19 d6             	sbb    %rdx,%rsi
    9e10:	0f 8c 6c fe ff ff    	jl     9c82 <fwp_cmp+0x52>
    9e16:	4c 39 f9             	cmp    %r15,%rcx
    9e19:	4c 19 f2             	sbb    %r14,%rdx
    9e1c:	0f 9c c0             	setl   %al
    9e1f:	0f b6 c0             	movzbl %al,%eax
    9e22:	e9 5b fe ff ff       	jmp    9c82 <fwp_cmp+0x52>
    9e27:	4d 85 f6             	test   %r14,%r14
    9e2a:	0f 94 c0             	sete   %al
    9e2d:	74 3e                	je     9e6d <fwp_cmp+0x23d>
    9e2f:	48 85 db             	test   %rbx,%rbx
    9e32:	74 39                	je     9e6d <fwp_cmp+0x23d>
    9e34:	4d 8b 7f 38          	mov    0x38(%r15),%r15
    9e38:	0f 1f 84 00 00 00 00 	nopl   0x0(%rax,%rax,1)
    9e3f:	00 
    9e40:	49 8b 7e 08          	mov    0x8(%r14),%rdi
    9e44:	48 8b 73 08          	mov    0x8(%rbx),%rsi
    9e48:	4c 89 fa             	mov    %r15,%rdx
    9e4b:	e8 e0 fd ff ff       	call   9c30 <fwp_cmp>
    9e50:	85 c0                	test   %eax,%eax
    9e52:	0f 85 2a fe ff ff    	jne    9c82 <fwp_cmp+0x52>
    9e58:	4d 8b 76 10          	mov    0x10(%r14),%r14
    9e5c:	48 8b 5b 10          	mov    0x10(%rbx),%rbx
    9e60:	4d 85 f6             	test   %r14,%r14
    9e63:	0f 94 c0             	sete   %al
    9e66:	74 05                	je     9e6d <fwp_cmp+0x23d>
    9e68:	48 85 db             	test   %rbx,%rbx
    9e6b:	75 d3                	jne    9e40 <fwp_cmp+0x210>
    9e6d:	48 85 db             	test   %rbx,%rbx
    9e70:	0f 95 c1             	setne  %cl
    9e73:	08 c1                	or     %al,%cl
    9e75:	80 f1 01             	xor    $0x1,%cl
    9e78:	0f b6 c9             	movzbl %cl,%ecx
    9e7b:	84 c0                	test   %al,%al
    9e7d:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    9e82:	0f 44 c1             	cmove  %ecx,%eax
    9e85:	48 85 db             	test   %rbx,%rbx
    9e88:	0f 44 c1             	cmove  %ecx,%eax
    9e8b:	e9 f2 fd ff ff       	jmp    9c82 <fwp_cmp+0x52>
    9e90:	45 8b 67 10          	mov    0x10(%r15),%r12d
    9e94:	45 85 e4             	test   %r12d,%r12d
    9e97:	0f 8e f7 00 00 00    	jle    9f94 <fwp_cmp+0x364>
    9e9d:	4d 8b 7f 20          	mov    0x20(%r15),%r15
    9ea1:	45 31 ed             	xor    %r13d,%r13d
    9ea4:	66 66 66 2e 0f 1f 84 	data16 data16 cs nopw 0x0(%rax,%rax,1)
    9eab:	00 00 00 00 00 
    9eb0:	4b 8b 7c ee 08       	mov    0x8(%r14,%r13,8),%rdi
    9eb5:	4a 8b 74 eb 08       	mov    0x8(%rbx,%r13,8),%rsi
    9eba:	4b 8b 14 ef          	mov    (%r15,%r13,8),%rdx
    9ebe:	e8 6d fd ff ff       	call   9c30 <fwp_cmp>
    9ec3:	85 c0                	test   %eax,%eax
    9ec5:	0f 85 b7 fd ff ff    	jne    9c82 <fwp_cmp+0x52>
    9ecb:	49 ff c5             	inc    %r13
    9ece:	31 c0                	xor    %eax,%eax
    9ed0:	4d 39 ec             	cmp    %r13,%r12
    9ed3:	75 db                	jne    9eb0 <fwp_cmp+0x280>
    9ed5:	e9 a8 fd ff ff       	jmp    9c82 <fwp_cmp+0x52>
    9eda:	49 8b 06             	mov    (%r14),%rax
    9edd:	4c 8b 2b             	mov    (%rbx),%r13
    9ee0:	4c 39 e8             	cmp    %r13,%rax
    9ee3:	4c 89 ed             	mov    %r13,%rbp
    9ee6:	48 89 04 24          	mov    %rax,(%rsp)
    9eea:	48 0f 42 e8          	cmovb  %rax,%rbp
    9eee:	48 85 ed             	test   %rbp,%rbp
    9ef1:	74 2f                	je     9f22 <fwp_cmp+0x2f2>
    9ef3:	4d 8b 7f 38          	mov    0x38(%r15),%r15
    9ef7:	45 31 e4             	xor    %r12d,%r12d
    9efa:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)
    9f00:	4b 8b 7c e6 08       	mov    0x8(%r14,%r12,8),%rdi
    9f05:	4a 8b 74 e3 08       	mov    0x8(%rbx,%r12,8),%rsi
    9f0a:	4c 89 fa             	mov    %r15,%rdx
    9f0d:	e8 1e fd ff ff       	call   9c30 <fwp_cmp>
    9f12:	85 c0                	test   %eax,%eax
    9f14:	0f 85 68 fd ff ff    	jne    9c82 <fwp_cmp+0x52>
    9f1a:	49 ff c4             	inc    %r12
    9f1d:	4c 39 e5             	cmp    %r12,%rbp
    9f20:	75 de                	jne    9f00 <fwp_cmp+0x2d0>
    9f22:	31 c9                	xor    %ecx,%ecx
    9f24:	4c 39 2c 24          	cmp    %r13,(%rsp)
    9f28:	e9 4a fd ff ff       	jmp    9c77 <fwp_cmp+0x47>
    9f2d:	4c 89 f7             	mov    %r14,%rdi
    9f30:	e8 cb 00 00 00       	call   a000 <fwp_tag>
    9f35:	89 c5                	mov    %eax,%ebp
    9f37:	48 89 df             	mov    %rbx,%rdi
    9f3a:	e8 c1 00 00 00       	call   a000 <fwp_tag>
    9f3f:	39 c5                	cmp    %eax,%ebp
    9f41:	75 58                	jne    9f9b <fwp_cmp+0x36b>
    9f43:	49 8b 4f 28          	mov    0x28(%r15),%rcx
    9f47:	89 e8                	mov    %ebp,%eax
    9f49:	44 8b 24 81          	mov    (%rcx,%rax,4),%r12d
    9f4d:	45 85 e4             	test   %r12d,%r12d
    9f50:	7e 42                	jle    9f94 <fwp_cmp+0x364>
    9f52:	49 8b 4f 30          	mov    0x30(%r15),%rcx
    9f56:	4c 8b 3c c1          	mov    (%rcx,%rax,8),%r15
    9f5a:	45 31 ed             	xor    %r13d,%r13d
    9f5d:	0f 1f 00             	nopl   (%rax)
    9f60:	4b 8b 7c ee 08       	mov    0x8(%r14,%r13,8),%rdi
    9f65:	4a 8b 74 eb 08       	mov    0x8(%rbx,%r13,8),%rsi
    9f6a:	4b 8b 14 ef          	mov    (%r15,%r13,8),%rdx
    9f6e:	e8 bd fc ff ff       	call   9c30 <fwp_cmp>
    9f73:	85 c0                	test   %eax,%eax
    9f75:	0f 85 07 fd ff ff    	jne    9c82 <fwp_cmp+0x52>
    9f7b:	49 ff c5             	inc    %r13
    9f7e:	31 c0                	xor    %eax,%eax
    9f80:	4d 39 ec             	cmp    %r13,%r12
    9f83:	75 db                	jne    9f60 <fwp_cmp+0x330>
    9f85:	e9 f8 fc ff ff       	jmp    9c82 <fwp_cmp+0x52>
    9f8a:	31 c9                	xor    %ecx,%ecx
    9f8c:	4d 39 e7             	cmp    %r12,%r15
    9f8f:	e9 e3 fc ff ff       	jmp    9c77 <fwp_cmp+0x47>
    9f94:	31 c0                	xor    %eax,%eax
    9f96:	e9 e7 fc ff ff       	jmp    9c82 <fwp_cmp+0x52>
    9f9b:	0f 97 c0             	seta   %al
    9f9e:	0f b6 c8             	movzbl %al,%ecx
    9fa1:	e9 d4 fc ff ff       	jmp    9c7a <fwp_cmp+0x4a>
    9fa6:	66 2e 0f 1f 84 00 00 	cs nopw 0x0(%rax,%rax,1)
    9fad:	00 00 00 

0000000000009fb0 <fwp_i128>:
    9fb0:	48 8b 07             	mov    (%rdi),%rax
    9fb3:	48 8b 57 08          	mov    0x8(%rdi),%rdx
    9fb7:	c3                   	ret
    9fb8:	0f 1f 84 00 00 00 00 	nopl   0x0(%rax,%rax,1)
    9fbf:	00 

0000000000009fc0 <fwp_u128>:
    9fc0:	48 8b 07             	mov    (%rdi),%rax
    9fc3:	48 8b 57 08          	mov    0x8(%rdi),%rdx
    9fc7:	c3                   	ret
    9fc8:	0f 1f 84 00 00 00 00 	nopl   0x0(%rax,%rax,1)
    9fcf:	00 

0000000000009fd0 <fwp_total_key32>:
    9fd0:	66 0f 7e c1          	movd   %xmm0,%ecx
    9fd4:	89 c8                	mov    %ecx,%eax
    9fd6:	c1 f8 1f             	sar    $0x1f,%eax
    9fd9:	d1 e8                	shr    $1,%eax
    9fdb:	31 c8                	xor    %ecx,%eax
    9fdd:	c3                   	ret
    9fde:	66 90                	xchg   %ax,%ax

0000000000009fe0 <fwp_total_key64>:
    9fe0:	66 48 0f 7e c1       	movq   %xmm0,%rcx
    9fe5:	48 89 c8             	mov    %rcx,%rax
    9fe8:	48 c1 f8 3f          	sar    $0x3f,%rax
    9fec:	48 d1 e8             	shr    $1,%rax
    9fef:	48 31 c8             	xor    %rcx,%rax
    9ff2:	c3                   	ret
    9ff3:	66 66 66 66 2e 0f 1f 	data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    9ffa:	84 00 00 00 00 00 

000000000000a000 <fwp_tag>:
    a000:	48 89 f8             	mov    %rdi,%rax
    a003:	48 81 ff ff 0f 00 00 	cmp    $0xfff,%rdi
    a00a:	76 02                	jbe    a00e <fwp_tag+0xe>
    a00c:	8b 00                	mov    (%rax),%eax
    a00e:	c3                   	ret
    a00f:	90                   	nop

000000000000a010 <fwp_transport_off>:
    a010:	50                   	push   %rax
    a011:	48 8d 3d 9f 42 00 00 	lea    0x429f(%rip),%rdi        # e2b7 <exec_in_fp0+0xc77>
    a018:	e8 13 80 ff ff       	call   2030 <getenv@plt>
    a01d:	48 85 c0             	test   %rax,%rax
    a020:	74 1a                	je     a03c <fwp_transport_off+0x2c>
    a022:	48 8d 35 9c 42 00 00 	lea    0x429c(%rip),%rsi        # e2c5 <exec_in_fp0+0xc85>
    a029:	48 89 c7             	mov    %rax,%rdi
    a02c:	e8 9f 82 ff ff       	call   22d0 <strcmp@plt>
    a031:	89 c1                	mov    %eax,%ecx
    a033:	31 c0                	xor    %eax,%eax
    a035:	85 c9                	test   %ecx,%ecx
    a037:	0f 94 c0             	sete   %al
    a03a:	59                   	pop    %rcx
    a03b:	c3                   	ret
    a03c:	31 c0                	xor    %eax,%eax
    a03e:	59                   	pop    %rcx
    a03f:	c3                   	ret

000000000000a040 <fwp_pipe_addr>:
    a040:	50                   	push   %rax
    a041:	0f 57 c0             	xorps  %xmm0,%xmm0
    a044:	0f 11 47 5e          	movups %xmm0,0x5e(%rdi)
    a048:	0f 11 47 52          	movups %xmm0,0x52(%rdi)
    a04c:	0f 11 47 42          	movups %xmm0,0x42(%rdi)
    a050:	0f 11 47 32          	movups %xmm0,0x32(%rdi)
    a054:	0f 11 47 22          	movups %xmm0,0x22(%rdi)
    a058:	0f 11 47 12          	movups %xmm0,0x12(%rdi)
    a05c:	0f 11 47 02          	movups %xmm0,0x2(%rdi)
    a060:	66 c7 07 01 00       	movw   $0x1,(%rdi)
    a065:	48 83 c7 03          	add    $0x3,%rdi
    a069:	48 8b 0e             	mov    (%rsi),%rcx
    a06c:	4c 8b 46 08          	mov    0x8(%rsi),%r8
    a070:	48 8d 15 54 42 00 00 	lea    0x4254(%rip),%rdx        # e2cb <exec_in_fp0+0xc8b>
    a077:	be 6b 00 00 00       	mov    $0x6b,%esi
    a07c:	31 c0                	xor    %eax,%eax
    a07e:	e8 4d 81 ff ff       	call   21d0 <snprintf@plt>
    a083:	83 c0 03             	add    $0x3,%eax
    a086:	59                   	pop    %rcx
    a087:	c3                   	ret
    a088:	0f 1f 84 00 00 00 00 	nopl   0x0(%rax,%rax,1)
    a08f:	00 

000000000000a090 <fwp_now_ns>:
    a090:	48 83 ec 18          	sub    $0x18,%rsp
    a094:	48 8d 74 24 08       	lea    0x8(%rsp),%rsi
    a099:	bf 01 00 00 00       	mov    $0x1,%edi
    a09e:	e8 8d 80 ff ff       	call   2130 <clock_gettime@plt>
    a0a3:	48 69 44 24 08 00 ca 	imul   $0x3b9aca00,0x8(%rsp),%rax
    a0aa:	9a 3b 
    a0ac:	48 03 44 24 10       	add    0x10(%rsp),%rax
    a0b1:	48 83 c4 18          	add    $0x18,%rsp
    a0b5:	c3                   	ret
    a0b6:	66 2e 0f 1f 84 00 00 	cs nopw 0x0(%rax,%rax,1)
    a0bd:	00 00 00 

000000000000a0c0 <fwp_ring_put>:
    a0c0:	55                   	push   %rbp
    a0c1:	41 57                	push   %r15
    a0c3:	41 56                	push   %r14
    a0c5:	41 55                	push   %r13
    a0c7:	41 54                	push   %r12
    a0c9:	53                   	push   %rbx
    a0ca:	48 83 ec 38          	sub    $0x38,%rsp
    a0ce:	48 89 3c 24          	mov    %rdi,(%rsp)
    a0d2:	48 85 f6             	test   %rsi,%rsi
    a0d5:	0f 84 27 01 00 00    	je     a202 <fwp_ring_put+0x142>
    a0db:	f6 05 16 ad 02 00 01 	testb  $0x1,0x2ad16(%rip)        # 34df8 <fwp_po_gone>
    a0e2:	0f 85 1a 01 00 00    	jne    a202 <fwp_ring_put+0x142>
    a0e8:	48 89 f3             	mov    %rsi,%rbx
    a0eb:	4c 8b 3d fe ac 02 00 	mov    0x2acfe(%rip),%r15        # 34df0 <fwp_po_ring>
    a0f2:	49 8d 87 00 10 00 00 	lea    0x1000(%r15),%rax
    a0f9:	48 89 44 24 28       	mov    %rax,0x28(%rsp)
    a0fe:	49 8d 87 c0 00 00 00 	lea    0xc0(%r15),%rax
    a105:	48 89 44 24 20       	mov    %rax,0x20(%rsp)
    a10a:	49 8d 87 c4 00 00 00 	lea    0xc4(%r15),%rax
    a111:	48 89 44 24 18       	mov    %rax,0x18(%rsp)
    a116:	49 8d 87 00 01 00 00 	lea    0x100(%r15),%rax
    a11d:	48 89 44 24 10       	mov    %rax,0x10(%rsp)
    a122:	49 8d 87 04 01 00 00 	lea    0x104(%r15),%rax
    a129:	48 89 44 24 08       	mov    %rax,0x8(%rsp)
    a12e:	4c 8b 74 24 28       	mov    0x28(%rsp),%r14
    a133:	66 66 66 66 2e 0f 1f 	data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    a13a:	84 00 00 00 00 00 
    a140:	4d 8b 67 40          	mov    0x40(%r15),%r12
    a144:	49 8b af 80 00 00 00 	mov    0x80(%r15),%rbp
    a14b:	4d 8b 6f 08          	mov    0x8(%r15),%r13
    a14f:	4c 29 e5             	sub    %r12,%rbp
    a152:	4c 01 ed             	add    %r13,%rbp
    a155:	74 69                	je     a1c0 <fwp_ring_put+0x100>
    a157:	48 39 eb             	cmp    %rbp,%rbx
    a15a:	48 0f 42 eb          	cmovb  %rbx,%rbp
    a15e:	49 8d 7d ff          	lea    -0x1(%r13),%rdi
    a162:	4c 21 e7             	and    %r12,%rdi
    a165:	49 29 fd             	sub    %rdi,%r13
    a168:	4c 39 ed             	cmp    %r13,%rbp
    a16b:	4c 0f 42 ed          	cmovb  %rbp,%r13
    a16f:	4c 01 f7             	add    %r14,%rdi
    a172:	48 89 5c 24 30       	mov    %rbx,0x30(%rsp)
    a177:	48 8b 1c 24          	mov    (%rsp),%rbx
    a17b:	48 89 de             	mov    %rbx,%rsi
    a17e:	4c 89 ea             	mov    %r13,%rdx
    a181:	e8 aa 81 ff ff       	call   2330 <memcpy@plt>
    a186:	4a 8d 34 2b          	lea    (%rbx,%r13,1),%rsi
    a18a:	48 89 ea             	mov    %rbp,%rdx
    a18d:	4c 29 ea             	sub    %r13,%rdx
    a190:	4c 89 f7             	mov    %r14,%rdi
    a193:	e8 98 81 ff ff       	call   2330 <memcpy@plt>
    a198:	49 01 ec             	add    %rbp,%r12
    a19b:	4d 89 67 40          	mov    %r12,0x40(%r15)
    a19f:	48 8b 7c 24 20       	mov    0x20(%rsp),%rdi
    a1a4:	48 8b 74 24 18       	mov    0x18(%rsp),%rsi
    a1a9:	e8 82 02 00 00       	call   a430 <fwp_ring_wake>
    a1ae:	48 01 eb             	add    %rbp,%rbx
    a1b1:	48 89 1c 24          	mov    %rbx,(%rsp)
    a1b5:	48 8b 5c 24 30       	mov    0x30(%rsp),%rbx
    a1ba:	48 29 eb             	sub    %rbp,%rbx
    a1bd:	eb 31                	jmp    a1f0 <fwp_ring_put+0x130>
    a1bf:	90                   	nop
    a1c0:	44 8b 05 f9 aa 00 00 	mov    0xaaf9(%rip),%r8d        # 14cc0 <fwp_po_sock>
    a1c7:	4c 89 ff             	mov    %r15,%rdi
    a1ca:	48 8b 74 24 10       	mov    0x10(%rsp),%rsi
    a1cf:	48 8b 54 24 08       	mov    0x8(%rsp),%rdx
    a1d4:	48 8d 0d 35 02 00 00 	lea    0x235(%rip),%rcx        # a410 <fwp_ring_has_space>
    a1db:	e8 f0 00 00 00       	call   a2d0 <fwp_ring_wait>
    a1e0:	85 c0                	test   %eax,%eax
    a1e2:	75 0c                	jne    a1f0 <fwp_ring_put+0x130>
    a1e4:	c6 05 0d ac 02 00 01 	movb   $0x1,0x2ac0d(%rip)        # 34df8 <fwp_po_gone>
    a1eb:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)
    a1f0:	48 85 db             	test   %rbx,%rbx
    a1f3:	74 0d                	je     a202 <fwp_ring_put+0x142>
    a1f5:	f6 05 fc ab 02 00 01 	testb  $0x1,0x2abfc(%rip)        # 34df8 <fwp_po_gone>
    a1fc:	0f 84 3e ff ff ff    	je     a140 <fwp_ring_put+0x80>
    a202:	48 83 c4 38          	add    $0x38,%rsp
    a206:	5b                   	pop    %rbx
    a207:	41 5c                	pop    %r12
    a209:	41 5d                	pop    %r13
    a20b:	41 5e                	pop    %r14
    a20d:	41 5f                	pop    %r15
    a20f:	5d                   	pop    %rbp
    a210:	c3                   	ret
    a211:	66 66 66 66 66 66 2e 	data16 data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    a218:	0f 1f 84 00 00 00 00 
    a21f:	00 

000000000000a220 <fwp_po_flush_sock>:
    a220:	48 8b 15 c1 ab 01 00 	mov    0x1abc1(%rip),%rdx        # 24de8 <fwp_po_len>
    a227:	48 85 d2             	test   %rdx,%rdx
    a22a:	74 17                	je     a243 <fwp_po_flush_sock+0x23>
    a22c:	50                   	push   %rax
    a22d:	8b 3d 8d aa 00 00    	mov    0xaa8d(%rip),%edi        # 14cc0 <fwp_po_sock>
    a233:	48 8d 35 b6 ab 01 00 	lea    0x1abb6(%rip),%rsi        # 24df0 <fwp_po_buf>
    a23a:	e8 11 00 00 00       	call   a250 <fwp_po_write_raw>
    a23f:	48 83 c4 08          	add    $0x8,%rsp
    a243:	48 c7 05 9a ab 01 00 	movq   $0x0,0x1ab9a(%rip)        # 24de8 <fwp_po_len>
    a24a:	00 00 00 00 
    a24e:	c3                   	ret
    a24f:	90                   	nop

000000000000a250 <fwp_po_write_raw>:
    a250:	48 85 d2             	test   %rdx,%rdx
    a253:	74 70                	je     a2c5 <fwp_po_write_raw+0x75>
    a255:	f6 05 9c ab 02 00 01 	testb  $0x1,0x2ab9c(%rip)        # 34df8 <fwp_po_gone>
    a25c:	75 67                	jne    a2c5 <fwp_po_write_raw+0x75>
    a25e:	55                   	push   %rbp
    a25f:	41 56                	push   %r14
    a261:	53                   	push   %rbx
    a262:	48 89 d3             	mov    %rdx,%rbx
    a265:	49 89 f6             	mov    %rsi,%r14
    a268:	89 fd                	mov    %edi,%ebp
    a26a:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)
    a270:	89 ef                	mov    %ebp,%edi
    a272:	4c 89 f6             	mov    %r14,%rsi
    a275:	48 89 da             	mov    %rbx,%rdx
    a278:	b9 00 40 00 00       	mov    $0x4000,%ecx
    a27d:	e8 1e 7f ff ff       	call   21a0 <send@plt>
    a282:	48 85 c0             	test   %rax,%rax
    a285:	78 19                	js     a2a0 <fwp_po_write_raw+0x50>
    a287:	74 31                	je     a2ba <fwp_po_write_raw+0x6a>
    a289:	49 01 c6             	add    %rax,%r14
    a28c:	48 29 c3             	sub    %rax,%rbx
    a28f:	eb 19                	jmp    a2aa <fwp_po_write_raw+0x5a>
    a291:	66 66 66 66 66 66 2e 	data16 data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    a298:	0f 1f 84 00 00 00 00 
    a29f:	00 
    a2a0:	e8 db 7d ff ff       	call   2080 <__errno_location@plt>
    a2a5:	83 38 04             	cmpl   $0x4,(%rax)
    a2a8:	75 10                	jne    a2ba <fwp_po_write_raw+0x6a>
    a2aa:	48 85 db             	test   %rbx,%rbx
    a2ad:	74 12                	je     a2c1 <fwp_po_write_raw+0x71>
    a2af:	f6 05 42 ab 02 00 01 	testb  $0x1,0x2ab42(%rip)        # 34df8 <fwp_po_gone>
    a2b6:	74 b8                	je     a270 <fwp_po_write_raw+0x20>
    a2b8:	eb 07                	jmp    a2c1 <fwp_po_write_raw+0x71>
    a2ba:	c6 05 37 ab 02 00 01 	movb   $0x1,0x2ab37(%rip)        # 34df8 <fwp_po_gone>
    a2c1:	5b                   	pop    %rbx
    a2c2:	41 5e                	pop    %r14
    a2c4:	5d                   	pop    %rbp
    a2c5:	c3                   	ret
    a2c6:	66 2e 0f 1f 84 00 00 	cs nopw 0x0(%rax,%rax,1)
    a2cd:	00 00 00 

000000000000a2d0 <fwp_ring_wait>:
    a2d0:	55                   	push   %rbp
    a2d1:	41 57                	push   %r15
    a2d3:	41 56                	push   %r14
    a2d5:	41 55                	push   %r13
    a2d7:	41 54                	push   %r12
    a2d9:	53                   	push   %rbx
    a2da:	50                   	push   %rax
    a2db:	44 89 44 24 04       	mov    %r8d,0x4(%rsp)
    a2e0:	49 89 cf             	mov    %rcx,%r15
    a2e3:	49 89 d6             	mov    %rdx,%r14
    a2e6:	49 89 f4             	mov    %rsi,%r12
    a2e9:	49 89 fd             	mov    %rdi,%r13
    a2ec:	8b 0d d2 a9 00 00    	mov    0xa9d2(%rip),%ecx        # 14cc4 <fwp_ring_spin>
    a2f2:	85 c9                	test   %ecx,%ecx
    a2f4:	78 06                	js     a2fc <fwp_ring_wait+0x2c>
    a2f6:	85 c9                	test   %ecx,%ecx
    a2f8:	75 1f                	jne    a319 <fwp_ring_wait+0x49>
    a2fa:	eb 6f                	jmp    a36b <fwp_ring_wait+0x9b>
    a2fc:	bf 54 00 00 00       	mov    $0x54,%edi
    a301:	e8 2a 81 ff ff       	call   2430 <sysconf@plt>
    a306:	31 c9                	xor    %ecx,%ecx
    a308:	48 83 f8 02          	cmp    $0x2,%rax
    a30c:	0f 9d c1             	setge  %cl
    a30f:	89 0d af a9 00 00    	mov    %ecx,0xa9af(%rip)        # 14cc4 <fwp_ring_spin>
    a315:	85 c9                	test   %ecx,%ecx
    a317:	74 52                	je     a36b <fwp_ring_wait+0x9b>
    a319:	4c 89 ef             	mov    %r13,%rdi
    a31c:	41 ff d7             	call   *%r15
    a31f:	89 c1                	mov    %eax,%ecx
    a321:	b8 01 00 00 00       	mov    $0x1,%eax
    a326:	85 c9                	test   %ecx,%ecx
    a328:	75 6a                	jne    a394 <fwp_ring_wait+0xc4>
    a32a:	bd 01 00 00 00       	mov    $0x1,%ebp
    a32f:	31 db                	xor    %ebx,%ebx
    a331:	eb 19                	jmp    a34c <fwp_ring_wait+0x7c>
    a333:	48 05 50 c3 00 00    	add    $0xc350,%rax
    a339:	48 89 c3             	mov    %rax,%rbx
    a33c:	0f 1f 40 00          	nopl   0x0(%rax)
    a340:	ff c5                	inc    %ebp
    a342:	4c 89 ef             	mov    %r13,%rdi
    a345:	41 ff d7             	call   *%r15
    a348:	85 c0                	test   %eax,%eax
    a34a:	75 43                	jne    a38f <fwp_ring_wait+0xbf>
    a34c:	e8 ff 00 00 00       	call   a450 <fwp_cpu_relax>
    a351:	40 f6 c5 3f          	test   $0x3f,%bpl
    a355:	75 e9                	jne    a340 <fwp_ring_wait+0x70>
    a357:	e8 f4 7e ff ff       	call   2250 <sched_yield@plt>
    a35c:	e8 2f fd ff ff       	call   a090 <fwp_now_ns>
    a361:	48 85 db             	test   %rbx,%rbx
    a364:	74 cd                	je     a333 <fwp_ring_wait+0x63>
    a366:	48 39 d8             	cmp    %rbx,%rax
    a369:	7e d5                	jle    a340 <fwp_ring_wait+0x70>
    a36b:	41 8b 2c 24          	mov    (%r12),%ebp
    a36f:	b8 01 00 00 00       	mov    $0x1,%eax
    a374:	41 87 06             	xchg   %eax,(%r14)
    a377:	0f ae f0             	mfence
    a37a:	4c 89 ef             	mov    %r13,%rdi
    a37d:	41 ff d7             	call   *%r15
    a380:	85 c0                	test   %eax,%eax
    a382:	8b 5c 24 04          	mov    0x4(%rsp),%ebx
    a386:	74 41                	je     a3c9 <fwp_ring_wait+0xf9>
    a388:	41 c7 06 00 00 00 00 	movl   $0x0,(%r14)
    a38f:	b8 01 00 00 00       	mov    $0x1,%eax
    a394:	48 83 c4 08          	add    $0x8,%rsp
    a398:	5b                   	pop    %rbx
    a399:	41 5c                	pop    %r12
    a39b:	41 5d                	pop    %r13
    a39d:	41 5e                	pop    %r14
    a39f:	41 5f                	pop    %r15
    a3a1:	5d                   	pop    %rbp
    a3a2:	c3                   	ret
    a3a3:	66 66 66 66 2e 0f 1f 	data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    a3aa:	84 00 00 00 00 00 
    a3b0:	41 8b 2c 24          	mov    (%r12),%ebp
    a3b4:	b8 01 00 00 00       	mov    $0x1,%eax
    a3b9:	41 87 06             	xchg   %eax,(%r14)
    a3bc:	0f ae f0             	mfence
    a3bf:	4c 89 ef             	mov    %r13,%rdi
    a3c2:	41 ff d7             	call   *%r15
    a3c5:	85 c0                	test   %eax,%eax
    a3c7:	75 bf                	jne    a388 <fwp_ring_wait+0xb8>
    a3c9:	4c 89 e7             	mov    %r12,%rdi
    a3cc:	31 f6                	xor    %esi,%esi
    a3ce:	89 ea                	mov    %ebp,%edx
    a3d0:	b9 64 00 00 00       	mov    $0x64,%ecx
    a3d5:	e8 86 00 00 00       	call   a460 <fwp_futex>
    a3da:	48 89 c5             	mov    %rax,%rbp
    a3dd:	41 c7 06 00 00 00 00 	movl   $0x0,(%r14)
    a3e4:	4c 89 ef             	mov    %r13,%rdi
    a3e7:	41 ff d7             	call   *%r15
    a3ea:	85 c0                	test   %eax,%eax
    a3ec:	75 a1                	jne    a38f <fwp_ring_wait+0xbf>
    a3ee:	48 85 ed             	test   %rbp,%rbp
    a3f1:	74 bd                	je     a3b0 <fwp_ring_wait+0xe0>
    a3f3:	e8 88 7c ff ff       	call   2080 <__errno_location@plt>
    a3f8:	83 38 6e             	cmpl   $0x6e,(%rax)
    a3fb:	75 b3                	jne    a3b0 <fwp_ring_wait+0xe0>
    a3fd:	89 df                	mov    %ebx,%edi
    a3ff:	e8 cc 00 00 00       	call   a4d0 <fwp_sock_gone>
    a404:	85 c0                	test   %eax,%eax
    a406:	74 a8                	je     a3b0 <fwp_ring_wait+0xe0>
    a408:	31 c0                	xor    %eax,%eax
    a40a:	eb 88                	jmp    a394 <fwp_ring_wait+0xc4>
    a40c:	0f 1f 40 00          	nopl   0x0(%rax)

000000000000a410 <fwp_ring_has_space>:
    a410:	48 8b 8f 80 00 00 00 	mov    0x80(%rdi),%rcx
    a417:	48 2b 4f 40          	sub    0x40(%rdi),%rcx
    a41b:	31 c0                	xor    %eax,%eax
    a41d:	48 03 4f 08          	add    0x8(%rdi),%rcx
    a421:	0f 95 c0             	setne  %al
    a424:	c3                   	ret
    a425:	66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
    a42c:	00 00 00 00 

000000000000a430 <fwp_ring_wake>:
    a430:	0f ae f0             	mfence
    a433:	8b 06                	mov    (%rsi),%eax
    a435:	85 c0                	test   %eax,%eax
    a437:	74 14                	je     a44d <fwp_ring_wake+0x1d>
    a439:	f0 ff 07             	lock incl (%rdi)
    a43c:	be 01 00 00 00       	mov    $0x1,%esi
    a441:	ba ff ff ff 7f       	mov    $0x7fffffff,%edx
    a446:	b9 ff ff ff ff       	mov    $0xffffffff,%ecx
    a44b:	eb 13                	jmp    a460 <fwp_futex>
    a44d:	c3                   	ret
    a44e:	66 90                	xchg   %ax,%ax

000000000000a450 <fwp_cpu_relax>:
    a450:	f3 90                	pause
    a452:	c3                   	ret
    a453:	66 66 66 66 2e 0f 1f 	data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    a45a:	84 00 00 00 00 00 

000000000000a460 <fwp_futex>:
    a460:	48 83 ec 18          	sub    $0x18,%rsp
    a464:	89 c8                	mov    %ecx,%eax
    a466:	89 d1                	mov    %edx,%ecx
    a468:	89 f2                	mov    %esi,%edx
    a46a:	48 89 fe             	mov    %rdi,%rsi
    a46d:	48 c7 44 24 08 00 00 	movq   $0x0,0x8(%rsp)
    a474:	00 00 
    a476:	48 98                	cltq
    a478:	48 69 f8 d3 4d 62 10 	imul   $0x10624dd3,%rax,%rdi
    a47f:	49 89 f8             	mov    %rdi,%r8
    a482:	49 c1 e8 3f          	shr    $0x3f,%r8
    a486:	48 c1 ff 26          	sar    $0x26,%rdi
    a48a:	44 01 c7             	add    %r8d,%edi
    a48d:	69 ff e8 03 00 00    	imul   $0x3e8,%edi,%edi
    a493:	41 89 c0             	mov    %eax,%r8d
    a496:	41 29 f8             	sub    %edi,%r8d
    a499:	41 69 f8 40 42 0f 00 	imul   $0xf4240,%r8d,%edi
    a4a0:	48 63 ff             	movslq %edi,%rdi
    a4a3:	48 89 7c 24 10       	mov    %rdi,0x10(%rsp)
    a4a8:	31 ff                	xor    %edi,%edi
    a4aa:	85 c0                	test   %eax,%eax
    a4ac:	4c 8d 44 24 08       	lea    0x8(%rsp),%r8
    a4b1:	4c 0f 48 c7          	cmovs  %rdi,%r8
    a4b5:	c7 04 24 00 00 00 00 	movl   $0x0,(%rsp)
    a4bc:	bf ca 00 00 00       	mov    $0xca,%edi
    a4c1:	45 31 c9             	xor    %r9d,%r9d
    a4c4:	31 c0                	xor    %eax,%eax
    a4c6:	e8 35 7e ff ff       	call   2300 <syscall@plt>
    a4cb:	48 83 c4 18          	add    $0x18,%rsp
    a4cf:	c3                   	ret

000000000000a4d0 <fwp_sock_gone>:
    a4d0:	55                   	push   %rbp
    a4d1:	53                   	push   %rbx
    a4d2:	48 83 ec 18          	sub    $0x18,%rsp
    a4d6:	89 fb                	mov    %edi,%ebx
    a4d8:	89 7c 24 10          	mov    %edi,0x10(%rsp)
    a4dc:	c7 44 24 14 01 00 00 	movl   $0x1,0x14(%rsp)
    a4e3:	00 
    a4e4:	48 8d 7c 24 10       	lea    0x10(%rsp),%rdi
    a4e9:	31 ed                	xor    %ebp,%ebp
    a4eb:	be 01 00 00 00       	mov    $0x1,%esi
    a4f0:	31 d2                	xor    %edx,%edx
    a4f2:	e8 c9 7e ff ff       	call   23c0 <poll@plt>
    a4f7:	85 c0                	test   %eax,%eax
    a4f9:	7e 2b                	jle    a526 <fwp_sock_gone+0x56>
    a4fb:	bd 01 00 00 00       	mov    $0x1,%ebp
    a500:	f6 44 24 16 18       	testb  $0x18,0x16(%rsp)
    a505:	75 1f                	jne    a526 <fwp_sock_gone+0x56>
    a507:	48 8d 74 24 0f       	lea    0xf(%rsp),%rsi
    a50c:	ba 01 00 00 00       	mov    $0x1,%edx
    a511:	89 df                	mov    %ebx,%edi
    a513:	b9 42 00 00 00       	mov    $0x42,%ecx
    a518:	e8 43 7b ff ff       	call   2060 <recv@plt>
    a51d:	31 ed                	xor    %ebp,%ebp
    a51f:	48 85 c0             	test   %rax,%rax
    a522:	40 0f 94 c5          	sete   %bpl
    a526:	89 e8                	mov    %ebp,%eax
    a528:	48 83 c4 18          	add    $0x18,%rsp
    a52c:	5b                   	pop    %rbx
    a52d:	5d                   	pop    %rbp
    a52e:	c3                   	ret
    a52f:	90                   	nop

000000000000a530 <fwp_pipe_poll>:
    a530:	83 3d 85 a7 00 00 00 	cmpl   $0x0,0xa785(%rip)        # 14cbc <fwp_po_listen>
    a537:	0f 88 9b 01 00 00    	js     a6d8 <fwp_pipe_poll+0x1a8>
    a53d:	55                   	push   %rbp
    a53e:	41 57                	push   %r15
    a540:	41 56                	push   %r14
    a542:	53                   	push   %rbx
    a543:	48 83 ec 28          	sub    $0x28,%rsp
    a547:	e8 44 fb ff ff       	call   a090 <fwp_now_ns>
    a54c:	48 3b 05 ad a8 02 00 	cmp    0x2a8ad(%rip),%rax        # 34e00 <fwp_po_next_check>
    a553:	0f 8c 75 01 00 00    	jl     a6ce <fwp_pipe_poll+0x19e>
    a559:	49 89 c6             	mov    %rax,%r14
    a55c:	48 05 40 42 0f 00    	add    $0xf4240,%rax
    a562:	48 89 05 97 a8 02 00 	mov    %rax,0x2a897(%rip)        # 34e00 <fwp_po_next_check>
    a569:	8b 3d 4d a7 00 00    	mov    0xa74d(%rip),%edi        # 14cbc <fwp_po_listen>
    a56f:	31 f6                	xor    %esi,%esi
    a571:	31 d2                	xor    %edx,%edx
    a573:	e8 c8 7e ff ff       	call   2440 <accept@plt>
    a578:	85 c0                	test   %eax,%eax
    a57a:	0f 88 10 01 00 00    	js     a690 <fwp_pipe_poll+0x160>
    a580:	89 c3                	mov    %eax,%ebx
    a582:	8b 3d 34 a7 00 00    	mov    0xa734(%rip),%edi        # 14cbc <fwp_po_listen>
    a588:	e8 a3 7c ff ff       	call   2230 <close@plt>
    a58d:	c7 05 25 a7 00 00 ff 	movl   $0xffffffff,0xa725(%rip)        # 14cbc <fwp_po_listen>
    a594:	ff ff ff 
    a597:	89 df                	mov    %ebx,%edi
    a599:	be 02 00 00 00       	mov    $0x2,%esi
    a59e:	ba 01 00 00 00       	mov    $0x1,%edx
    a5a3:	31 c0                	xor    %eax,%eax
    a5a5:	e8 76 7b ff ff       	call   2120 <fcntl@plt>
    a5aa:	89 df                	mov    %ebx,%edi
    a5ac:	be 03 00 00 00       	mov    $0x3,%esi
    a5b1:	31 c0                	xor    %eax,%eax
    a5b3:	e8 68 7b ff ff       	call   2120 <fcntl@plt>
    a5b8:	25 ff f7 ff ff       	and    $0xfffff7ff,%eax
    a5bd:	89 df                	mov    %ebx,%edi
    a5bf:	be 04 00 00 00       	mov    $0x4,%esi
    a5c4:	89 c2                	mov    %eax,%edx
    a5c6:	31 c0                	xor    %eax,%eax
    a5c8:	e8 53 7b ff ff       	call   2120 <fcntl@plt>
    a5cd:	c7 44 24 18 0c 00 00 	movl   $0xc,0x18(%rsp)
    a5d4:	00 
    a5d5:	89 5c 24 10          	mov    %ebx,0x10(%rsp)
    a5d9:	c7 44 24 14 01 00 00 	movl   $0x1,0x14(%rsp)
    a5e0:	00 
    a5e1:	48 8d 4c 24 1c       	lea    0x1c(%rsp),%rcx
    a5e6:	4c 8d 44 24 18       	lea    0x18(%rsp),%r8
    a5eb:	89 df                	mov    %ebx,%edi
    a5ed:	be 01 00 00 00       	mov    $0x1,%esi
    a5f2:	ba 11 00 00 00       	mov    $0x11,%edx
    a5f7:	e8 a4 7c ff ff       	call   22a0 <getsockopt@plt>
    a5fc:	85 c0                	test   %eax,%eax
    a5fe:	0f 85 c3 00 00 00    	jne    a6c7 <fwp_pipe_poll+0x197>
    a604:	8b 6c 24 20          	mov    0x20(%rsp),%ebp
    a608:	e8 73 7b ff ff       	call   2180 <getuid@plt>
    a60d:	39 c5                	cmp    %eax,%ebp
    a60f:	0f 85 b2 00 00 00    	jne    a6c7 <fwp_pipe_poll+0x197>
    a615:	48 8d 7c 24 10       	lea    0x10(%rsp),%rdi
    a61a:	be 01 00 00 00       	mov    $0x1,%esi
    a61f:	ba e8 03 00 00       	mov    $0x3e8,%edx
    a624:	e8 97 7d ff ff       	call   23c0 <poll@plt>
    a629:	85 c0                	test   %eax,%eax
    a62b:	0f 8e 96 00 00 00    	jle    a6c7 <fwp_pipe_poll+0x197>
    a631:	48 8d 74 24 03       	lea    0x3(%rsp),%rsi
    a636:	ba 05 00 00 00       	mov    $0x5,%edx
    a63b:	89 df                	mov    %ebx,%edi
    a63d:	31 c9                	xor    %ecx,%ecx
    a63f:	e8 1c 7a ff ff       	call   2060 <recv@plt>
    a644:	48 85 c0             	test   %rax,%rax
    a647:	7e 7e                	jle    a6c7 <fwp_pipe_poll+0x197>
    a649:	49 89 c6             	mov    %rax,%r14
    a64c:	4c 8d 7c 24 10       	lea    0x10(%rsp),%r15
    a651:	49 83 fe 04          	cmp    $0x4,%r14
    a655:	77 59                	ja     a6b0 <fwp_pipe_poll+0x180>
    a657:	be 01 00 00 00       	mov    $0x1,%esi
    a65c:	4c 89 ff             	mov    %r15,%rdi
    a65f:	ba e8 03 00 00       	mov    $0x3e8,%edx
    a664:	e8 57 7d ff ff       	call   23c0 <poll@plt>
    a669:	85 c0                	test   %eax,%eax
    a66b:	7e 5a                	jle    a6c7 <fwp_pipe_poll+0x197>
    a66d:	4a 8d 34 34          	lea    (%rsp,%r14,1),%rsi
    a671:	48 83 c6 03          	add    $0x3,%rsi
    a675:	ba 05 00 00 00       	mov    $0x5,%edx
    a67a:	4c 29 f2             	sub    %r14,%rdx
    a67d:	89 df                	mov    %ebx,%edi
    a67f:	31 c9                	xor    %ecx,%ecx
    a681:	e8 da 79 ff ff       	call   2060 <recv@plt>
    a686:	49 01 c6             	add    %rax,%r14
    a689:	48 85 c0             	test   %rax,%rax
    a68c:	7f c3                	jg     a651 <fwp_pipe_poll+0x121>
    a68e:	eb 37                	jmp    a6c7 <fwp_pipe_poll+0x197>
    a690:	4c 3b 35 41 a7 01 00 	cmp    0x1a741(%rip),%r14        # 24dd8 <fwp_po_give_up>
    a697:	7e 35                	jle    a6ce <fwp_pipe_poll+0x19e>
    a699:	8b 3d 1d a6 00 00    	mov    0xa61d(%rip),%edi        # 14cbc <fwp_po_listen>
    a69f:	e8 8c 7b ff ff       	call   2230 <close@plt>
    a6a4:	c7 05 0e a6 00 00 ff 	movl   $0xffffffff,0xa60e(%rip)        # 14cbc <fwp_po_listen>
    a6ab:	ff ff ff 
    a6ae:	eb 1e                	jmp    a6ce <fwp_pipe_poll+0x19e>
    a6b0:	81 7c 24 03 46 57 50 	cmpl   $0x54505746,0x3(%rsp)
    a6b7:	54 
    a6b8:	75 0d                	jne    a6c7 <fwp_pipe_poll+0x197>
    a6ba:	0f b6 44 24 07       	movzbl 0x7(%rsp),%eax
    a6bf:	8d 48 fd             	lea    -0x3(%rax),%ecx
    a6c2:	80 f9 fd             	cmp    $0xfd,%cl
    a6c5:	77 12                	ja     a6d9 <fwp_pipe_poll+0x1a9>
    a6c7:	89 df                	mov    %ebx,%edi
    a6c9:	e8 62 7b ff ff       	call   2230 <close@plt>
    a6ce:	48 83 c4 28          	add    $0x28,%rsp
    a6d2:	5b                   	pop    %rbx
    a6d3:	41 5e                	pop    %r14
    a6d5:	41 5f                	pop    %r15
    a6d7:	5d                   	pop    %rbp
    a6d8:	c3                   	ret
    a6d9:	89 1d e1 a5 00 00    	mov    %ebx,0xa5e1(%rip)        # 14cc0 <fwp_po_sock>
    a6df:	bb 01 00 00 00       	mov    $0x1,%ebx
    a6e4:	3c 02                	cmp    $0x2,%al
    a6e6:	75 10                	jne    a6f8 <fwp_pipe_poll+0x1c8>
    a6e8:	e8 53 00 00 00       	call   a740 <fwp_po_make_ring>
    a6ed:	83 f8 01             	cmp    $0x1,%eax
    a6f0:	bb 02 00 00 00       	mov    $0x2,%ebx
    a6f5:	83 db 00             	sbb    $0x0,%ebx
    a6f8:	c7 44 24 08 02 01 00 	movl   $0x102,0x8(%rsp)
    a6ff:	00 
    a700:	c6 44 24 0c 00       	movb   $0x0,0xc(%rsp)
    a705:	88 5c 24 0d          	mov    %bl,0xd(%rsp)
    a709:	4c 8b 35 a0 88 00 00 	mov    0x88a0(%rip),%r14        # 12fb0 <stdout@GLIBC_2.2.5>
    a710:	49 8b 0e             	mov    (%r14),%rcx
    a713:	48 8d 7c 24 08       	lea    0x8(%rsp),%rdi
    a718:	be 01 00 00 00       	mov    $0x1,%esi
    a71d:	ba 06 00 00 00       	mov    $0x6,%edx
    a722:	e8 79 7d ff ff       	call   24a0 <fwrite@plt>
    a727:	49 8b 3e             	mov    (%r14),%rdi
    a72a:	e8 21 7c ff ff       	call   2350 <fflush@plt>
    a72f:	89 1d ab a6 01 00    	mov    %ebx,0x1a6ab(%rip)        # 24de0 <fwp_po_kind>
    a735:	eb 97                	jmp    a6ce <fwp_pipe_poll+0x19e>
    a737:	66 0f 1f 84 00 00 00 	nopw   0x0(%rax,%rax,1)
    a73e:	00 00 

000000000000a740 <fwp_po_make_ring>:
    a740:	55                   	push   %rbp
    a741:	41 57                	push   %r15
    a743:	41 56                	push   %r14
    a745:	53                   	push   %rbx
    a746:	48 83 ec 68          	sub    $0x68,%rsp
    a74a:	48 8d 35 92 3b 00 00 	lea    0x3b92(%rip),%rsi        # e2e3 <exec_in_fp0+0xca3>
    a751:	31 ed                	xor    %ebp,%ebp
    a753:	bf 3f 01 00 00       	mov    $0x13f,%edi
    a758:	ba 01 00 00 00       	mov    $0x1,%edx
    a75d:	31 c0                	xor    %eax,%eax
    a75f:	e8 9c 7b ff ff       	call   2300 <syscall@plt>
    a764:	48 89 c3             	mov    %rax,%rbx
    a767:	85 db                	test   %ebx,%ebx
    a769:	78 17                	js     a782 <fwp_po_make_ring+0x42>
    a76b:	be 00 10 10 00       	mov    $0x101000,%esi
    a770:	89 df                	mov    %ebx,%edi
    a772:	e8 69 7a ff ff       	call   21e0 <ftruncate@plt>
    a777:	85 c0                	test   %eax,%eax
    a779:	74 14                	je     a78f <fwp_po_make_ring+0x4f>
    a77b:	89 df                	mov    %ebx,%edi
    a77d:	e8 ae 7a ff ff       	call   2230 <close@plt>
    a782:	89 e8                	mov    %ebp,%eax
    a784:	48 83 c4 68          	add    $0x68,%rsp
    a788:	5b                   	pop    %rbx
    a789:	41 5e                	pop    %r14
    a78b:	41 5f                	pop    %r15
    a78d:	5d                   	pop    %rbp
    a78e:	c3                   	ret
    a78f:	be 00 10 10 00       	mov    $0x101000,%esi
    a794:	31 ff                	xor    %edi,%edi
    a796:	ba 03 00 00 00       	mov    $0x3,%edx
    a79b:	b9 01 00 00 00       	mov    $0x1,%ecx
    a7a0:	41 89 d8             	mov    %ebx,%r8d
    a7a3:	45 31 c9             	xor    %r9d,%r9d
    a7a6:	e8 e5 79 ff ff       	call   2190 <mmap@plt>
    a7ab:	48 83 f8 ff          	cmp    $0xffffffffffffffff,%rax
    a7af:	74 ca                	je     a77b <fwp_po_make_ring+0x3b>
    a7b1:	49 89 c6             	mov    %rax,%r14
    a7b4:	48 b8 46 57 50 53 01 	movabs $0x153505746,%rax
    a7bb:	00 00 00 
    a7be:	49 89 06             	mov    %rax,(%r14)
    a7c1:	49 c7 46 08 00 00 10 	movq   $0x100000,0x8(%r14)
    a7c8:	00 
    a7c9:	c6 44 24 07 53       	movb   $0x53,0x7(%rsp)
    a7ce:	48 8d 44 24 07       	lea    0x7(%rsp),%rax
    a7d3:	48 89 44 24 20       	mov    %rax,0x20(%rsp)
    a7d8:	48 c7 44 24 28 01 00 	movq   $0x1,0x28(%rsp)
    a7df:	00 00 
    a7e1:	48 c7 44 24 18 00 00 	movq   $0x0,0x18(%rsp)
    a7e8:	00 00 
    a7ea:	0f 57 c0             	xorps  %xmm0,%xmm0
    a7ed:	0f 29 44 24 40       	movaps %xmm0,0x40(%rsp)
    a7f2:	0f 29 44 24 50       	movaps %xmm0,0x50(%rsp)
    a7f7:	0f 29 44 24 30       	movaps %xmm0,0x30(%rsp)
    a7fc:	48 c7 44 24 60 00 00 	movq   $0x0,0x60(%rsp)
    a803:	00 00 
    a805:	48 8d 44 24 20       	lea    0x20(%rsp),%rax
    a80a:	48 89 44 24 40       	mov    %rax,0x40(%rsp)
    a80f:	48 c7 44 24 48 01 00 	movq   $0x1,0x48(%rsp)
    a816:	00 00 
    a818:	48 8d 44 24 08       	lea    0x8(%rsp),%rax
    a81d:	48 89 44 24 50       	mov    %rax,0x50(%rsp)
    a822:	48 c7 44 24 58 18 00 	movq   $0x18,0x58(%rsp)
    a829:	00 00 
    a82b:	48 b8 01 00 00 00 01 	movabs $0x100000001,%rax
    a832:	00 00 00 
    a835:	48 89 44 24 10       	mov    %rax,0x10(%rsp)
    a83a:	48 c7 44 24 08 14 00 	movq   $0x14,0x8(%rsp)
    a841:	00 00 
    a843:	89 5c 24 18          	mov    %ebx,0x18(%rsp)
    a847:	8b 3d 73 a4 00 00    	mov    0xa473(%rip),%edi        # 14cc0 <fwp_po_sock>
    a84d:	48 8d 74 24 30       	lea    0x30(%rsp),%rsi
    a852:	ba 00 40 00 00       	mov    $0x4000,%edx
    a857:	e8 64 78 ff ff       	call   20c0 <sendmsg@plt>
    a85c:	49 89 c7             	mov    %rax,%r15
    a85f:	89 df                	mov    %ebx,%edi
    a861:	e8 ca 79 ff ff       	call   2230 <close@plt>
    a866:	49 83 ff 01          	cmp    $0x1,%r15
    a86a:	75 11                	jne    a87d <fwp_po_make_ring+0x13d>
    a86c:	4c 89 35 7d a5 02 00 	mov    %r14,0x2a57d(%rip)        # 34df0 <fwp_po_ring>
    a873:	bd 01 00 00 00       	mov    $0x1,%ebp
    a878:	e9 05 ff ff ff       	jmp    a782 <fwp_po_make_ring+0x42>
    a87d:	be 00 10 10 00       	mov    $0x101000,%esi
    a882:	4c 89 f7             	mov    %r14,%rdi
    a885:	e8 06 7b ff ff       	call   2390 <munmap@plt>
    a88a:	31 ed                	xor    %ebp,%ebp
    a88c:	e9 f1 fe ff ff       	jmp    a782 <fwp_po_make_ring+0x42>
    a891:	66 66 66 66 66 66 2e 	data16 data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    a898:	0f 1f 84 00 00 00 00 
    a89f:	00 

000000000000a8a0 <fwp_apply>:
    a8a0:	55                   	push   %rbp
    a8a1:	48 89 e5             	mov    %rsp,%rbp
    a8a4:	41 57                	push   %r15
    a8a6:	41 56                	push   %r14
    a8a8:	41 55                	push   %r13
    a8aa:	41 54                	push   %r12
    a8ac:	53                   	push   %rbx
    a8ad:	48 83 ec 18          	sub    $0x18,%rsp
    a8b1:	48 89 f3             	mov    %rsi,%rbx
    a8b4:	49 89 ff             	mov    %rdi,%r15
    a8b7:	be 01 00 00 00       	mov    $0x1,%esi
    a8bc:	eb 1e                	jmp    a8dc <fwp_apply+0x3c>
    a8be:	66 90                	xchg   %ax,%ax
    a8c0:	4a 8d 1c f3          	lea    (%rbx,%r14,8),%rbx
    a8c4:	31 c9                	xor    %ecx,%ecx
    a8c6:	49 89 c7             	mov    %rax,%r15
    a8c9:	4c 8b 75 c8          	mov    -0x38(%rbp),%r14
    a8cd:	48 8b 65 c0          	mov    -0x40(%rbp),%rsp
    a8d1:	89 d6                	mov    %edx,%esi
    a8d3:	83 f9 01             	cmp    $0x1,%ecx
    a8d6:	0f 84 ff 03 00 00    	je     acdb <fwp_apply+0x43b>
    a8dc:	48 8b 05 5d a4 00 00 	mov    0xa45d(%rip),%rax        # 14d40 <fwp_fns>
    a8e3:	41 8b 0f             	mov    (%r15),%ecx
    a8e6:	45 8b 67 04          	mov    0x4(%r15),%r12d
    a8ea:	48 c1 e1 05          	shl    $0x5,%rcx
    a8ee:	44 8b 2c 08          	mov    (%rax,%rcx,1),%r13d
    a8f2:	4d 85 e4             	test   %r12,%r12
    a8f5:	75 39                	jne    a930 <fwp_apply+0x90>
    a8f7:	41 8d 55 ff          	lea    -0x1(%r13),%edx
    a8fb:	39 f2                	cmp    %esi,%edx
    a8fd:	73 31                	jae    a930 <fwp_apply+0x90>
    a8ff:	49 89 f7             	mov    %rsi,%r15
    a902:	48 89 df             	mov    %rbx,%rdi
    a905:	ff 54 08 08          	call   *0x8(%rax,%rcx,1)
    a909:	4c 89 fe             	mov    %r15,%rsi
    a90c:	49 89 c7             	mov    %rax,%r15
    a90f:	44 39 ee             	cmp    %r13d,%esi
    a912:	0f 84 c0 03 00 00    	je     acd8 <fwp_apply+0x438>
    a918:	4a 8d 1c eb          	lea    (%rbx,%r13,8),%rbx
    a91c:	44 29 ee             	sub    %r13d,%esi
    a91f:	b9 03 00 00 00       	mov    $0x3,%ecx
    a924:	83 f9 01             	cmp    $0x1,%ecx
    a927:	75 b3                	jne    a8dc <fwp_apply+0x3c>
    a929:	e9 ad 03 00 00       	jmp    acdb <fwp_apply+0x43b>
    a92e:	66 90                	xchg   %ax,%ax
    a930:	4c 89 75 c8          	mov    %r14,-0x38(%rbp)
    a934:	48 89 75 d0          	mov    %rsi,-0x30(%rbp)
    a938:	45 8d 34 34          	lea    (%r12,%rsi,1),%r14d
    a93c:	45 39 ee             	cmp    %r13d,%r14d
    a93f:	0f 82 1a 02 00 00    	jb     ab5f <fwp_apply+0x2bf>
    a945:	48 89 65 c0          	mov    %rsp,-0x40(%rbp)
    a949:	45 89 eb             	mov    %r13d,%r11d
    a94c:	41 83 fd 02          	cmp    $0x2,%r13d
    a950:	ba 01 00 00 00       	mov    $0x1,%edx
    a955:	41 0f 43 d5          	cmovae %r13d,%edx
    a959:	48 8d 14 d5 0f 00 00 	lea    0xf(,%rdx,8),%rdx
    a960:	00 
    a961:	48 83 e2 f0          	and    $0xfffffffffffffff0,%rdx
    a965:	48 89 e7             	mov    %rsp,%rdi
    a968:	48 29 d7             	sub    %rdx,%rdi
    a96b:	48 89 fc             	mov    %rdi,%rsp
    a96e:	4d 85 e4             	test   %r12,%r12
    a971:	0f 84 c9 00 00 00    	je     aa40 <fwp_apply+0x1a0>
    a977:	41 83 fc 04          	cmp    $0x4,%r12d
    a97b:	72 10                	jb     a98d <fwp_apply+0xed>
    a97d:	48 89 fa             	mov    %rdi,%rdx
    a980:	4c 29 fa             	sub    %r15,%rdx
    a983:	48 83 c2 f8          	add    $0xfffffffffffffff8,%rdx
    a987:	48 83 fa 20          	cmp    $0x20,%rdx
    a98b:	73 65                	jae    a9f2 <fwp_apply+0x152>
    a98d:	31 d2                	xor    %edx,%edx
    a98f:	4d 89 e0             	mov    %r12,%r8
    a992:	48 89 d6             	mov    %rdx,%rsi
    a995:	49 83 e0 03          	and    $0x3,%r8
    a999:	74 16                	je     a9b1 <fwp_apply+0x111>
    a99b:	48 89 d6             	mov    %rdx,%rsi
    a99e:	66 90                	xchg   %ax,%ax
    a9a0:	4d 8b 4c f7 08       	mov    0x8(%r15,%rsi,8),%r9
    a9a5:	4c 89 0c f7          	mov    %r9,(%rdi,%rsi,8)
    a9a9:	48 ff c6             	inc    %rsi
    a9ac:	49 ff c8             	dec    %r8
    a9af:	75 ef                	jne    a9a0 <fwp_apply+0x100>
    a9b1:	4c 29 e2             	sub    %r12,%rdx
    a9b4:	48 83 fa fc          	cmp    $0xfffffffffffffffc,%rdx
    a9b8:	0f 87 82 00 00 00    	ja     aa40 <fwp_apply+0x1a0>
    a9be:	66 90                	xchg   %ax,%ax
    a9c0:	49 8b 54 f7 08       	mov    0x8(%r15,%rsi,8),%rdx
    a9c5:	48 89 14 f7          	mov    %rdx,(%rdi,%rsi,8)
    a9c9:	49 8b 54 f7 10       	mov    0x10(%r15,%rsi,8),%rdx
    a9ce:	48 89 54 f7 08       	mov    %rdx,0x8(%rdi,%rsi,8)
    a9d3:	49 8b 54 f7 18       	mov    0x18(%r15,%rsi,8),%rdx
    a9d8:	48 89 54 f7 10       	mov    %rdx,0x10(%rdi,%rsi,8)
    a9dd:	49 8b 54 f7 20       	mov    0x20(%r15,%rsi,8),%rdx
    a9e2:	48 89 54 f7 18       	mov    %rdx,0x18(%rdi,%rsi,8)
    a9e7:	48 83 c6 04          	add    $0x4,%rsi
    a9eb:	49 39 f4             	cmp    %rsi,%r12
    a9ee:	75 d0                	jne    a9c0 <fwp_apply+0x120>
    a9f0:	eb 4e                	jmp    aa40 <fwp_apply+0x1a0>
    a9f2:	44 89 e2             	mov    %r12d,%edx
    a9f5:	83 e2 fc             	and    $0xfffffffc,%edx
    a9f8:	4a 8d 34 e5 00 00 00 	lea    0x0(,%r12,8),%rsi
    a9ff:	00 
    aa00:	48 83 e6 e0          	and    $0xffffffffffffffe0,%rsi
    aa04:	45 31 c0             	xor    %r8d,%r8d
    aa07:	66 0f 1f 84 00 00 00 	nopw   0x0(%rax,%rax,1)
    aa0e:	00 00 
    aa10:	43 0f 10 44 07 08    	movups 0x8(%r15,%r8,1),%xmm0
    aa16:	43 0f 10 4c 07 18    	movups 0x18(%r15,%r8,1),%xmm1
    aa1c:	42 0f 29 04 07       	movaps %xmm0,(%rdi,%r8,1)
    aa21:	42 0f 29 4c 07 10    	movaps %xmm1,0x10(%rdi,%r8,1)
    aa27:	49 83 c0 20          	add    $0x20,%r8
    aa2b:	4c 39 c6             	cmp    %r8,%rsi
    aa2e:	75 e0                	jne    aa10 <fwp_apply+0x170>
    aa30:	4c 39 e2             	cmp    %r12,%rdx
    aa33:	0f 85 56 ff ff ff    	jne    a98f <fwp_apply+0xef>
    aa39:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)
    aa40:	45 29 e3             	sub    %r12d,%r11d
    aa43:	45 89 de             	mov    %r11d,%r14d
    aa46:	45 39 e5             	cmp    %r12d,%r13d
    aa49:	0f 84 85 00 00 00    	je     aad4 <fwp_apply+0x234>
    aa4f:	41 83 fb 0e          	cmp    $0xe,%r11d
    aa53:	0f 83 a0 00 00 00    	jae    aaf9 <fwp_apply+0x259>
    aa59:	31 d2                	xor    %edx,%edx
    aa5b:	4d 89 f0             	mov    %r14,%r8
    aa5e:	48 89 d6             	mov    %rdx,%rsi
    aa61:	49 83 e0 03          	and    $0x3,%r8
    aa65:	74 1d                	je     aa84 <fwp_apply+0x1e4>
    aa67:	48 89 d6             	mov    %rdx,%rsi
    aa6a:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)
    aa70:	4c 8b 0c f3          	mov    (%rbx,%rsi,8),%r9
    aa74:	45 8d 14 34          	lea    (%r12,%rsi,1),%r10d
    aa78:	4e 89 0c d7          	mov    %r9,(%rdi,%r10,8)
    aa7c:	48 ff c6             	inc    %rsi
    aa7f:	49 ff c8             	dec    %r8
    aa82:	75 ec                	jne    aa70 <fwp_apply+0x1d0>
    aa84:	4c 29 f2             	sub    %r14,%rdx
    aa87:	48 83 fa fc          	cmp    $0xfffffffffffffffc,%rdx
    aa8b:	77 47                	ja     aad4 <fwp_apply+0x234>
    aa8d:	0f 1f 00             	nopl   (%rax)
    aa90:	48 8b 14 f3          	mov    (%rbx,%rsi,8),%rdx
    aa94:	45 8d 04 34          	lea    (%r12,%rsi,1),%r8d
    aa98:	4a 89 14 c7          	mov    %rdx,(%rdi,%r8,8)
    aa9c:	48 8b 54 f3 08       	mov    0x8(%rbx,%rsi,8),%rdx
    aaa1:	45 8d 04 34          	lea    (%r12,%rsi,1),%r8d
    aaa5:	41 ff c0             	inc    %r8d
    aaa8:	4a 89 14 c7          	mov    %rdx,(%rdi,%r8,8)
    aaac:	48 8b 54 f3 10       	mov    0x10(%rbx,%rsi,8),%rdx
    aab1:	45 8d 44 34 02       	lea    0x2(%r12,%rsi,1),%r8d
    aab6:	4a 89 14 c7          	mov    %rdx,(%rdi,%r8,8)
    aaba:	48 8b 54 f3 18       	mov    0x18(%rbx,%rsi,8),%rdx
    aabf:	45 8d 04 34          	lea    (%r12,%rsi,1),%r8d
    aac3:	41 83 c0 03          	add    $0x3,%r8d
    aac7:	4a 89 14 c7          	mov    %rdx,(%rdi,%r8,8)
    aacb:	48 83 c6 04          	add    $0x4,%rsi
    aacf:	49 39 f6             	cmp    %rsi,%r14
    aad2:	75 bc                	jne    aa90 <fwp_apply+0x1f0>
    aad4:	45 89 dc             	mov    %r11d,%r12d
    aad7:	ff 54 08 08          	call   *0x8(%rax,%rcx,1)
    aadb:	b9 01 00 00 00       	mov    $0x1,%ecx
    aae0:	48 8b 75 d0          	mov    -0x30(%rbp),%rsi
    aae4:	89 f2                	mov    %esi,%edx
    aae6:	44 29 e2             	sub    %r12d,%edx
    aae9:	0f 85 d1 fd ff ff    	jne    a8c0 <fwp_apply+0x20>
    aaef:	89 f2                	mov    %esi,%edx
    aaf1:	49 89 c6             	mov    %rax,%r14
    aaf4:	e9 d4 fd ff ff       	jmp    a8cd <fwp_apply+0x2d>
    aaf9:	49 8d 56 ff          	lea    -0x1(%r14),%rdx
    aafd:	89 d6                	mov    %edx,%esi
    aaff:	44 01 e6             	add    %r12d,%esi
    ab02:	0f 82 51 ff ff ff    	jb     aa59 <fwp_apply+0x1b9>
    ab08:	48 c1 ea 20          	shr    $0x20,%rdx
    ab0c:	ba 00 00 00 00       	mov    $0x0,%edx
    ab11:	0f 85 44 ff ff ff    	jne    aa5b <fwp_apply+0x1bb>
    ab17:	4a 8d 14 e7          	lea    (%rdi,%r12,8),%rdx
    ab1b:	48 29 da             	sub    %rbx,%rdx
    ab1e:	48 83 fa 20          	cmp    $0x20,%rdx
    ab22:	0f 82 31 ff ff ff    	jb     aa59 <fwp_apply+0x1b9>
    ab28:	44 89 f2             	mov    %r14d,%edx
    ab2b:	83 e2 fc             	and    $0xfffffffc,%edx
    ab2e:	31 f6                	xor    %esi,%esi
    ab30:	0f 10 04 f3          	movups (%rbx,%rsi,8),%xmm0
    ab34:	0f 10 4c f3 10       	movups 0x10(%rbx,%rsi,8),%xmm1
    ab39:	45 8d 04 34          	lea    (%r12,%rsi,1),%r8d
    ab3d:	42 0f 11 04 c7       	movups %xmm0,(%rdi,%r8,8)
    ab42:	42 0f 11 4c c7 10    	movups %xmm1,0x10(%rdi,%r8,8)
    ab48:	48 83 c6 04          	add    $0x4,%rsi
    ab4c:	48 39 f2             	cmp    %rsi,%rdx
    ab4f:	75 df                	jne    ab30 <fwp_apply+0x290>
    ab51:	4c 39 f2             	cmp    %r14,%rdx
    ab54:	0f 85 01 ff ff ff    	jne    aa5b <fwp_apply+0x1bb>
    ab5a:	e9 75 ff ff ff       	jmp    aad4 <fwp_apply+0x234>
    ab5f:	44 89 f0             	mov    %r14d,%eax
    ab62:	48 8d 3c c5 08 00 00 	lea    0x8(,%rax,8),%rdi
    ab69:	00 
    ab6a:	e8 41 aa ff ff       	call   55b0 <fwp_alloc>
    ab6f:	41 8b 0f             	mov    (%r15),%ecx
    ab72:	89 08                	mov    %ecx,(%rax)
    ab74:	44 89 70 04          	mov    %r14d,0x4(%rax)
    ab78:	49 89 c6             	mov    %rax,%r14
    ab7b:	4d 85 e4             	test   %r12,%r12
    ab7e:	48 8b 7d d0          	mov    -0x30(%rbp),%rdi
    ab82:	0f 84 b9 00 00 00    	je     ac41 <fwp_apply+0x3a1>
    ab88:	31 c0                	xor    %eax,%eax
    ab8a:	41 83 fc 06          	cmp    $0x6,%r12d
    ab8e:	72 46                	jb     abd6 <fwp_apply+0x336>
    ab90:	4c 89 f1             	mov    %r14,%rcx
    ab93:	4c 29 f9             	sub    %r15,%rcx
    ab96:	48 83 f9 20          	cmp    $0x20,%rcx
    ab9a:	72 3a                	jb     abd6 <fwp_apply+0x336>
    ab9c:	44 89 e0             	mov    %r12d,%eax
    ab9f:	83 e0 fc             	and    $0xfffffffc,%eax
    aba2:	4a 8d 0c e5 00 00 00 	lea    0x0(,%r12,8),%rcx
    aba9:	00 
    abaa:	48 83 e1 e0          	and    $0xffffffffffffffe0,%rcx
    abae:	31 d2                	xor    %edx,%edx
    abb0:	41 0f 10 44 17 08    	movups 0x8(%r15,%rdx,1),%xmm0
    abb6:	41 0f 10 4c 17 18    	movups 0x18(%r15,%rdx,1),%xmm1
    abbc:	41 0f 11 44 16 08    	movups %xmm0,0x8(%r14,%rdx,1)
    abc2:	41 0f 11 4c 16 18    	movups %xmm1,0x18(%r14,%rdx,1)
    abc8:	48 83 c2 20          	add    $0x20,%rdx
    abcc:	48 39 d1             	cmp    %rdx,%rcx
    abcf:	75 df                	jne    abb0 <fwp_apply+0x310>
    abd1:	4c 39 e0             	cmp    %r12,%rax
    abd4:	74 6b                	je     ac41 <fwp_apply+0x3a1>
    abd6:	4c 89 e2             	mov    %r12,%rdx
    abd9:	48 89 c1             	mov    %rax,%rcx
    abdc:	48 83 e2 03          	and    $0x3,%rdx
    abe0:	74 20                	je     ac02 <fwp_apply+0x362>
    abe2:	48 89 c1             	mov    %rax,%rcx
    abe5:	66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
    abec:	00 00 00 00 
    abf0:	49 8b 74 cf 08       	mov    0x8(%r15,%rcx,8),%rsi
    abf5:	49 89 74 ce 08       	mov    %rsi,0x8(%r14,%rcx,8)
    abfa:	48 ff c1             	inc    %rcx
    abfd:	48 ff ca             	dec    %rdx
    ac00:	75 ee                	jne    abf0 <fwp_apply+0x350>
    ac02:	4c 29 e0             	sub    %r12,%rax
    ac05:	48 83 f8 fc          	cmp    $0xfffffffffffffffc,%rax
    ac09:	77 36                	ja     ac41 <fwp_apply+0x3a1>
    ac0b:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)
    ac10:	49 8b 44 cf 08       	mov    0x8(%r15,%rcx,8),%rax
    ac15:	49 89 44 ce 08       	mov    %rax,0x8(%r14,%rcx,8)
    ac1a:	49 8b 44 cf 10       	mov    0x10(%r15,%rcx,8),%rax
    ac1f:	49 89 44 ce 10       	mov    %rax,0x10(%r14,%rcx,8)
    ac24:	49 8b 44 cf 18       	mov    0x18(%r15,%rcx,8),%rax
    ac29:	49 89 44 ce 18       	mov    %rax,0x18(%r14,%rcx,8)
    ac2e:	49 8b 44 cf 20       	mov    0x20(%r15,%rcx,8),%rax
    ac33:	49 89 44 ce 20       	mov    %rax,0x20(%r14,%rcx,8)
    ac38:	48 83 c1 04          	add    $0x4,%rcx
    ac3c:	49 39 cc             	cmp    %rcx,%r12
    ac3f:	75 cf                	jne    ac10 <fwp_apply+0x370>
    ac41:	85 ff                	test   %edi,%edi
    ac43:	0f 84 92 00 00 00    	je     acdb <fwp_apply+0x43b>
    ac49:	89 f8                	mov    %edi,%eax
    ac4b:	83 ff 14             	cmp    $0x14,%edi
    ac4e:	0f 83 99 00 00 00    	jae    aced <fwp_apply+0x44d>
    ac54:	31 c9                	xor    %ecx,%ecx
    ac56:	48 89 c6             	mov    %rax,%rsi
    ac59:	48 89 ca             	mov    %rcx,%rdx
    ac5c:	48 83 e6 03          	and    $0x3,%rsi
    ac60:	74 23                	je     ac85 <fwp_apply+0x3e5>
    ac62:	48 89 ca             	mov    %rcx,%rdx
    ac65:	66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
    ac6c:	00 00 00 00 
    ac70:	48 8b 3c d3          	mov    (%rbx,%rdx,8),%rdi
    ac74:	45 8d 04 14          	lea    (%r12,%rdx,1),%r8d
    ac78:	4b 89 7c c6 08       	mov    %rdi,0x8(%r14,%r8,8)
    ac7d:	48 ff c2             	inc    %rdx
    ac80:	48 ff ce             	dec    %rsi
    ac83:	75 eb                	jne    ac70 <fwp_apply+0x3d0>
    ac85:	48 29 c1             	sub    %rax,%rcx
    ac88:	48 83 f9 fc          	cmp    $0xfffffffffffffffc,%rcx
    ac8c:	77 4d                	ja     acdb <fwp_apply+0x43b>
    ac8e:	66 90                	xchg   %ax,%ax
    ac90:	48 8b 0c d3          	mov    (%rbx,%rdx,8),%rcx
    ac94:	41 8d 34 14          	lea    (%r12,%rdx,1),%esi
    ac98:	49 89 4c f6 08       	mov    %rcx,0x8(%r14,%rsi,8)
    ac9d:	48 8b 4c d3 08       	mov    0x8(%rbx,%rdx,8),%rcx
    aca2:	41 8d 34 14          	lea    (%r12,%rdx,1),%esi
    aca6:	ff c6                	inc    %esi
    aca8:	49 89 4c f6 08       	mov    %rcx,0x8(%r14,%rsi,8)
    acad:	48 8b 4c d3 10       	mov    0x10(%rbx,%rdx,8),%rcx
    acb2:	41 8d 74 14 02       	lea    0x2(%r12,%rdx,1),%esi
    acb7:	49 89 4c f6 08       	mov    %rcx,0x8(%r14,%rsi,8)
    acbc:	48 8b 4c d3 18       	mov    0x18(%rbx,%rdx,8),%rcx
    acc1:	41 8d 34 14          	lea    (%r12,%rdx,1),%esi
    acc5:	83 c6 03             	add    $0x3,%esi
    acc8:	49 89 4c f6 08       	mov    %rcx,0x8(%r14,%rsi,8)
    accd:	48 83 c2 04          	add    $0x4,%rdx
    acd1:	48 39 d0             	cmp    %rdx,%rax
    acd4:	75 ba                	jne    ac90 <fwp_apply+0x3f0>
    acd6:	eb 03                	jmp    acdb <fwp_apply+0x43b>
    acd8:	4d 89 fe             	mov    %r15,%r14
    acdb:	4c 89 f0             	mov    %r14,%rax
    acde:	48 8d 65 d8          	lea    -0x28(%rbp),%rsp
    ace2:	5b                   	pop    %rbx
    ace3:	41 5c                	pop    %r12
    ace5:	41 5d                	pop    %r13
    ace7:	41 5e                	pop    %r14
    ace9:	41 5f                	pop    %r15
    aceb:	5d                   	pop    %rbp
    acec:	c3                   	ret
    aced:	48 8d 50 ff          	lea    -0x1(%rax),%rdx
    acf1:	31 c9                	xor    %ecx,%ecx
    acf3:	89 d6                	mov    %edx,%esi
    acf5:	44 01 e6             	add    %r12d,%esi
    acf8:	0f 82 58 ff ff ff    	jb     ac56 <fwp_apply+0x3b6>
    acfe:	48 c1 ea 20          	shr    $0x20,%rdx
    ad02:	0f 85 4e ff ff ff    	jne    ac56 <fwp_apply+0x3b6>
    ad08:	4b 8d 0c e6          	lea    (%r14,%r12,8),%rcx
    ad0c:	48 29 d9             	sub    %rbx,%rcx
    ad0f:	48 83 c1 08          	add    $0x8,%rcx
    ad13:	48 83 f9 20          	cmp    $0x20,%rcx
    ad17:	0f 82 37 ff ff ff    	jb     ac54 <fwp_apply+0x3b4>
    ad1d:	89 c1                	mov    %eax,%ecx
    ad1f:	83 e1 fc             	and    $0xfffffffc,%ecx
    ad22:	31 d2                	xor    %edx,%edx
    ad24:	66 66 66 2e 0f 1f 84 	data16 data16 cs nopw 0x0(%rax,%rax,1)
    ad2b:	00 00 00 00 00 
    ad30:	0f 10 04 d3          	movups (%rbx,%rdx,8),%xmm0
    ad34:	0f 10 4c d3 10       	movups 0x10(%rbx,%rdx,8),%xmm1
    ad39:	41 8d 34 14          	lea    (%r12,%rdx,1),%esi
    ad3d:	41 0f 11 44 f6 08    	movups %xmm0,0x8(%r14,%rsi,8)
    ad43:	41 0f 11 4c f6 18    	movups %xmm1,0x18(%r14,%rsi,8)
    ad49:	48 83 c2 04          	add    $0x4,%rdx
    ad4d:	48 39 d1             	cmp    %rdx,%rcx
    ad50:	75 de                	jne    ad30 <fwp_apply+0x490>
    ad52:	48 39 c1             	cmp    %rax,%rcx
    ad55:	0f 85 fb fe ff ff    	jne    ac56 <fwp_apply+0x3b6>
    ad5b:	e9 7b ff ff ff       	jmp    acdb <fwp_apply+0x43b>

000000000000ad60 <fwp_pap>:
    ad60:	50                   	push   %rax
    ad61:	bf 08 00 00 00       	mov    $0x8,%edi
    ad66:	e8 45 a8 ff ff       	call   55b0 <fwp_alloc>
    ad6b:	48 c7 00 04 00 00 00 	movq   $0x4,(%rax)
    ad72:	59                   	pop    %rcx
    ad73:	c3                   	ret
    ad74:	66 66 66 2e 0f 1f 84 	data16 data16 cs nopw 0x0(%rax,%rax,1)
    ad7b:	00 00 00 00 00 

000000000000ad80 <fwp_exec_error>:
    ad80:	41 57                	push   %r15
    ad82:	41 56                	push   %r14
    ad84:	53                   	push   %rbx
    ad85:	48 89 f3             	mov    %rsi,%rbx
    ad88:	49 89 fe             	mov    %rdi,%r14
    ad8b:	e8 90 bd ff ff       	call   6b20 <fwp_pipe_flush>
    ad90:	4c 8b 3d 41 82 00 00 	mov    0x8241(%rip),%r15        # 12fd8 <stderr@GLIBC_2.2.5>
    ad97:	49 8b 3f             	mov    (%r15),%rdi
    ad9a:	48 8d 35 63 35 00 00 	lea    0x3563(%rip),%rsi        # e304 <exec_in_fp0+0xcc4>
    ada1:	48 8d 15 d8 28 00 00 	lea    0x28d8(%rip),%rdx        # d680 <exec_in_fp0+0x40>
    ada8:	31 c0                	xor    %eax,%eax
    adaa:	e8 41 75 ff ff       	call   22f0 <fprintf@plt>
    adaf:	83 3b 10             	cmpl   $0x10,(%rbx)
    adb2:	75 1f                	jne    add3 <fwp_exec_error+0x53>
    adb4:	48 8b 7b 08          	mov    0x8(%rbx),%rdi
    adb8:	48 85 ff             	test   %rdi,%rdi
    adbb:	74 16                	je     add3 <fwp_exec_error+0x53>
    adbd:	48 8d 35 45 35 00 00 	lea    0x3545(%rip),%rsi        # e309 <exec_in_fp0+0xcc9>
    adc4:	e8 07 75 ff ff       	call   22d0 <strcmp@plt>
    adc9:	85 c0                	test   %eax,%eax
    adcb:	75 06                	jne    add3 <fwp_exec_error+0x53>
    adcd:	83 7b 10 02          	cmpl   $0x2,0x10(%rbx)
    add1:	74 20                	je     adf3 <fwp_exec_error+0x73>
    add3:	49 8b 17             	mov    (%r15),%rdx
    add6:	4c 89 f7             	mov    %r14,%rdi
    add9:	48 89 de             	mov    %rbx,%rsi
    addc:	e8 2f 00 00 00       	call   ae10 <fwp_display_top>
    ade1:	49 8b 37             	mov    (%r15),%rsi
    ade4:	bf 0a 00 00 00       	mov    $0xa,%edi
    ade9:	5b                   	pop    %rbx
    adea:	41 5e                	pop    %r14
    adec:	41 5f                	pop    %r15
    adee:	e9 4d 74 ff ff       	jmp    2240 <fputc@plt>
    adf3:	49 8b 7e 10          	mov    0x10(%r14),%rdi
    adf7:	48 8b 17             	mov    (%rdi),%rdx
    adfa:	48 83 c7 08          	add    $0x8,%rdi
    adfe:	49 8b 0f             	mov    (%r15),%rcx
    ae01:	be 01 00 00 00       	mov    $0x1,%esi
    ae06:	e8 95 76 ff ff       	call   24a0 <fwrite@plt>
    ae0b:	eb d4                	jmp    ade1 <fwp_exec_error+0x61>
    ae0d:	0f 1f 00             	nopl   (%rax)

000000000000ae10 <fwp_display_top>:
    ae10:	53                   	push   %rbx
    ae11:	48 83 ec 20          	sub    $0x20,%rsp
    ae15:	48 89 d3             	mov    %rdx,%rbx
    ae18:	48 89 f2             	mov    %rsi,%rdx
    ae1b:	48 89 fe             	mov    %rdi,%rsi
    ae1e:	0f 57 c0             	xorps  %xmm0,%xmm0
    ae21:	0f 29 04 24          	movaps %xmm0,(%rsp)
    ae25:	48 c7 44 24 10 00 00 	movq   $0x0,0x10(%rsp)
    ae2c:	00 00 
    ae2e:	48 89 e7             	mov    %rsp,%rdi
    ae31:	b9 01 00 00 00       	mov    $0x1,%ecx
    ae36:	e8 35 00 00 00       	call   ae70 <fwp_write>
    ae3b:	48 8b 3c 24          	mov    (%rsp),%rdi
    ae3f:	48 85 ff             	test   %rdi,%rdi
    ae42:	74 18                	je     ae5c <fwp_display_top+0x4c>
    ae44:	48 8b 54 24 08       	mov    0x8(%rsp),%rdx
    ae49:	be 01 00 00 00       	mov    $0x1,%esi
    ae4e:	48 89 d9             	mov    %rbx,%rcx
    ae51:	e8 4a 76 ff ff       	call   24a0 <fwrite@plt>
    ae56:	48 8b 3c 24          	mov    (%rsp),%rdi
    ae5a:	eb 02                	jmp    ae5e <fwp_display_top+0x4e>
    ae5c:	31 ff                	xor    %edi,%edi
    ae5e:	e8 ed 71 ff ff       	call   2050 <free@plt>
    ae63:	48 83 c4 20          	add    $0x20,%rsp
    ae67:	5b                   	pop    %rbx
    ae68:	c3                   	ret
    ae69:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)

000000000000ae70 <fwp_write>:
    ae70:	55                   	push   %rbp
    ae71:	41 57                	push   %r15
    ae73:	41 56                	push   %r14
    ae75:	41 55                	push   %r13
    ae77:	41 54                	push   %r12
    ae79:	53                   	push   %rbx
    ae7a:	48 81 ec 28 02 00 00 	sub    $0x228,%rsp
    ae81:	8b 02                	mov    (%rdx),%eax
    ae83:	48 83 f8 19          	cmp    $0x19,%rax
    ae87:	0f 87 3f 05 00 00    	ja     b3cc <fwp_write+0x55c>
    ae8d:	49 89 f5             	mov    %rsi,%r13
    ae90:	48 89 fb             	mov    %rdi,%rbx
    ae93:	48 89 54 24 08       	mov    %rdx,0x8(%rsp)
    ae98:	48 8d 15 a5 24 00 00 	lea    0x24a5(%rip),%rdx        # d344 <_IO_stdin_used+0x344>
    ae9f:	48 63 34 82          	movslq (%rdx,%rax,4),%rsi
    aea3:	48 01 d6             	add    %rdx,%rsi
    aea6:	ff e6                	jmp    *%rsi
    aea8:	48 8d 15 62 34 00 00 	lea    0x3462(%rip),%rdx        # e311 <exec_in_fp0+0xcd1>
    aeaf:	eb 07                	jmp    aeb8 <fwp_write+0x48>
    aeb1:	48 8d 15 21 34 00 00 	lea    0x3421(%rip),%rdx        # e2d9 <exec_in_fp0+0xc99>
    aeb8:	4c 8d 7c 24 20       	lea    0x20(%rsp),%r15
    aebd:	be 00 02 00 00       	mov    $0x200,%esi
    aec2:	4c 89 ff             	mov    %r15,%rdi
    aec5:	4c 89 e9             	mov    %r13,%rcx
    aec8:	31 c0                	xor    %eax,%eax
    aeca:	e8 01 73 ff ff       	call   21d0 <snprintf@plt>
    aecf:	48 89 df             	mov    %rbx,%rdi
    aed2:	4c 89 fe             	mov    %r15,%rsi
    aed5:	e9 ed 04 00 00       	jmp    b3c7 <fwp_write+0x557>
    aeda:	83 f8 13             	cmp    $0x13,%eax
    aedd:	48 8d 05 5e 34 00 00 	lea    0x345e(%rip),%rax        # e342 <exec_in_fp0+0xd02>
    aee4:	48 8d 35 5c 34 00 00 	lea    0x345c(%rip),%rsi        # e347 <exec_in_fp0+0xd07>
    aeeb:	48 0f 44 f0          	cmove  %rax,%rsi
    aeef:	48 89 df             	mov    %rbx,%rdi
    aef2:	e8 19 ca ff ff       	call   7910 <buf_puts>
    aef7:	49 83 7d 00 00       	cmpq   $0x0,0x0(%r13)
    aefc:	48 8b 44 24 08       	mov    0x8(%rsp),%rax
    af01:	0f 84 cb 00 00 00    	je     afd2 <fwp_write+0x162>
    af07:	4d 89 ec             	mov    %r13,%r12
    af0a:	48 8b 50 38          	mov    0x38(%rax),%rdx
    af0e:	48 89 df             	mov    %rbx,%rdi
    af11:	4c 89 eb             	mov    %r13,%rbx
    af14:	49 8b 74 24 08       	mov    0x8(%r12),%rsi
    af19:	49 89 c6             	mov    %rax,%r14
    af1c:	49 89 ff             	mov    %rdi,%r15
    af1f:	31 c9                	xor    %ecx,%ecx
    af21:	e8 4a ff ff ff       	call   ae70 <fwp_write>
    af26:	41 83 3e 12          	cmpl   $0x12,(%r14)
    af2a:	75 29                	jne    af55 <fwp_write+0xe5>
    af2c:	48 8d 35 d3 33 00 00 	lea    0x33d3(%rip),%rsi        # e306 <exec_in_fp0+0xcc6>
    af33:	4d 89 fe             	mov    %r15,%r14
    af36:	4c 89 ff             	mov    %r15,%rdi
    af39:	e8 d2 c9 ff ff       	call   7910 <buf_puts>
    af3e:	48 8b 73 10          	mov    0x10(%rbx),%rsi
    af42:	48 8b 44 24 08       	mov    0x8(%rsp),%rax
    af47:	48 8b 50 40          	mov    0x40(%rax),%rdx
    af4b:	4c 89 ff             	mov    %r15,%rdi
    af4e:	31 c9                	xor    %ecx,%ecx
    af50:	e8 1b ff ff ff       	call   ae70 <fwp_write>
    af55:	48 83 3b 02          	cmpq   $0x2,(%rbx)
    af59:	4c 89 fb             	mov    %r15,%rbx
    af5c:	4c 8b 7c 24 08       	mov    0x8(%rsp),%r15
    af61:	72 6f                	jb     afd2 <fwp_write+0x162>
    af63:	4d 8d 74 24 20       	lea    0x20(%r12),%r14
    af68:	bd 01 00 00 00       	mov    $0x1,%ebp
    af6d:	4c 8d 2d e7 32 00 00 	lea    0x32e7(%rip),%r13        # e25b <exec_in_fp0+0xc1b>
    af74:	eb 17                	jmp    af8d <fwp_write+0x11d>
    af76:	66 2e 0f 1f 84 00 00 	cs nopw 0x0(%rax,%rax,1)
    af7d:	00 00 00 
    af80:	48 ff c5             	inc    %rbp
    af83:	49 83 c6 10          	add    $0x10,%r14
    af87:	49 3b 2c 24          	cmp    (%r12),%rbp
    af8b:	73 45                	jae    afd2 <fwp_write+0x162>
    af8d:	48 89 df             	mov    %rbx,%rdi
    af90:	4c 89 ee             	mov    %r13,%rsi
    af93:	e8 78 c9 ff ff       	call   7910 <buf_puts>
    af98:	49 8b 76 f8          	mov    -0x8(%r14),%rsi
    af9c:	49 8b 57 38          	mov    0x38(%r15),%rdx
    afa0:	48 89 df             	mov    %rbx,%rdi
    afa3:	31 c9                	xor    %ecx,%ecx
    afa5:	e8 c6 fe ff ff       	call   ae70 <fwp_write>
    afaa:	41 83 3f 12          	cmpl   $0x12,(%r15)
    afae:	75 d0                	jne    af80 <fwp_write+0x110>
    afb0:	48 89 df             	mov    %rbx,%rdi
    afb3:	48 8d 35 4c 33 00 00 	lea    0x334c(%rip),%rsi        # e306 <exec_in_fp0+0xcc6>
    afba:	e8 51 c9 ff ff       	call   7910 <buf_puts>
    afbf:	49 8b 36             	mov    (%r14),%rsi
    afc2:	49 8b 57 40          	mov    0x40(%r15),%rdx
    afc6:	48 89 df             	mov    %rbx,%rdi
    afc9:	31 c9                	xor    %ecx,%ecx
    afcb:	e8 a0 fe ff ff       	call   ae70 <fwp_write>
    afd0:	eb ae                	jmp    af80 <fwp_write+0x110>
    afd2:	48 89 df             	mov    %rbx,%rdi
    afd5:	be 7d 00 00 00       	mov    $0x7d,%esi
    afda:	e9 48 05 00 00       	jmp    b527 <fwp_write+0x6b7>
    afdf:	4c 8b 7c 24 08       	mov    0x8(%rsp),%r15
    afe4:	4d 8b 67 08          	mov    0x8(%r15),%r12
    afe8:	4d 85 e4             	test   %r12,%r12
    afeb:	0f 84 38 04 00 00    	je     b429 <fwp_write+0x5b9>
    aff1:	48 8d 35 80 32 00 00 	lea    0x3280(%rip),%rsi        # e278 <exec_in_fp0+0xc38>
    aff8:	4c 89 e7             	mov    %r12,%rdi
    affb:	e8 d0 72 ff ff       	call   22d0 <strcmp@plt>
    b000:	85 c0                	test   %eax,%eax
    b002:	0f 84 44 05 00 00    	je     b54c <fwp_write+0x6dc>
    b008:	4d 8d 77 10          	lea    0x10(%r15),%r14
    b00c:	48 89 df             	mov    %rbx,%rdi
    b00f:	4c 89 e6             	mov    %r12,%rsi
    b012:	e8 f9 c8 ff ff       	call   7910 <buf_puts>
    b017:	48 89 df             	mov    %rbx,%rdi
    b01a:	be 20 00 00 00       	mov    $0x20,%esi
    b01f:	e8 cc c8 ff ff       	call   78f0 <buf_putc>
    b024:	31 ed                	xor    %ebp,%ebp
    b026:	e9 1f 04 00 00       	jmp    b44a <fwp_write+0x5da>
    b02b:	4c 89 ef             	mov    %r13,%rdi
    b02e:	e8 cd ef ff ff       	call   a000 <fwp_tag>
    b033:	4c 8b 7c 24 08       	mov    0x8(%rsp),%r15
    b038:	49 8b 4f 18          	mov    0x18(%r15),%rcx
    b03c:	41 89 c6             	mov    %eax,%r14d
    b03f:	4a 8b 34 f1          	mov    (%rcx,%r14,8),%rsi
    b043:	48 89 df             	mov    %rbx,%rdi
    b046:	e8 c5 c8 ff ff       	call   7910 <buf_puts>
    b04b:	49 8b 47 28          	mov    0x28(%r15),%rax
    b04f:	42 83 3c b0 00       	cmpl   $0x0,(%rax,%r14,4)
    b054:	0f 8e 72 03 00 00    	jle    b3cc <fwp_write+0x55c>
    b05a:	4c 89 f1             	mov    %r14,%rcx
    b05d:	45 31 f6             	xor    %r14d,%r14d
    b060:	4c 89 6c 24 18       	mov    %r13,0x18(%rsp)
    b065:	48 89 4c 24 10       	mov    %rcx,0x10(%rsp)
    b06a:	eb 3d                	jmp    b0a9 <fwp_write+0x239>
    b06c:	0f 1f 40 00          	nopl   0x0(%rax)
    b070:	48 89 dd             	mov    %rbx,%rbp
    b073:	48 89 df             	mov    %rbx,%rdi
    b076:	4c 89 e6             	mov    %r12,%rsi
    b079:	4c 89 ea             	mov    %r13,%rdx
    b07c:	31 c9                	xor    %ecx,%ecx
    b07e:	e8 ed fd ff ff       	call   ae70 <fwp_write>
    b083:	49 ff c6             	inc    %r14
    b086:	4c 8b 7c 24 08       	mov    0x8(%rsp),%r15
    b08b:	49 8b 47 28          	mov    0x28(%r15),%rax
    b08f:	48 8b 4c 24 10       	mov    0x10(%rsp),%rcx
    b094:	48 63 04 88          	movslq (%rax,%rcx,4),%rax
    b098:	49 39 c6             	cmp    %rax,%r14
    b09b:	4c 8b 6c 24 18       	mov    0x18(%rsp),%r13
    b0a0:	48 89 eb             	mov    %rbp,%rbx
    b0a3:	0f 8d 23 03 00 00    	jge    b3cc <fwp_write+0x55c>
    b0a9:	4f 8b 64 f5 08       	mov    0x8(%r13,%r14,8),%r12
    b0ae:	49 8b 47 30          	mov    0x30(%r15),%rax
    b0b2:	48 8b 04 c8          	mov    (%rax,%rcx,8),%rax
    b0b6:	4e 8b 2c f0          	mov    (%rax,%r14,8),%r13
    b0ba:	48 89 df             	mov    %rbx,%rdi
    b0bd:	be 20 00 00 00       	mov    $0x20,%esi
    b0c2:	e8 29 c8 ff ff       	call   78f0 <buf_putc>
    b0c7:	4c 89 e7             	mov    %r12,%rdi
    b0ca:	4c 89 ee             	mov    %r13,%rsi
    b0cd:	e8 8e 0e 00 00       	call   bf60 <fwp_needs_parens>
    b0d2:	85 c0                	test   %eax,%eax
    b0d4:	74 9a                	je     b070 <fwp_write+0x200>
    b0d6:	48 89 df             	mov    %rbx,%rdi
    b0d9:	be 28 00 00 00       	mov    $0x28,%esi
    b0de:	e8 0d c8 ff ff       	call   78f0 <buf_putc>
    b0e3:	48 89 df             	mov    %rbx,%rdi
    b0e6:	4c 89 e6             	mov    %r12,%rsi
    b0e9:	4c 89 ea             	mov    %r13,%rdx
    b0ec:	31 c9                	xor    %ecx,%ecx
    b0ee:	e8 7d fd ff ff       	call   ae70 <fwp_write>
    b0f3:	48 89 dd             	mov    %rbx,%rbp
    b0f6:	48 89 df             	mov    %rbx,%rdi
    b0f9:	be 29 00 00 00       	mov    $0x29,%esi
    b0fe:	e8 ed c7 ff ff       	call   78f0 <buf_putc>
    b103:	e9 7b ff ff ff       	jmp    b083 <fwp_write+0x213>
    b108:	4c 89 ef             	mov    %r13,%rdi
    b10b:	e8 90 7d ff ff       	call   2ea0 <fwp_f64>
    b110:	4c 8d 74 24 20       	lea    0x20(%rsp),%r14
    b115:	4c 89 f7             	mov    %r14,%rdi
    b118:	e8 93 08 00 00       	call   b9b0 <fwp_fmt_f64>
    b11d:	e9 9f 02 00 00       	jmp    b3c1 <fwp_write+0x551>
    b122:	48 89 df             	mov    %rbx,%rdi
    b125:	be 3c 00 00 00       	mov    $0x3c,%esi
    b12a:	e8 c1 c7 ff ff       	call   78f0 <buf_putc>
    b12f:	48 8b 44 24 08       	mov    0x8(%rsp),%rax
    b134:	48 8b 70 08          	mov    0x8(%rax),%rsi
    b138:	48 89 df             	mov    %rbx,%rdi
    b13b:	e9 d7 02 00 00       	jmp    b417 <fwp_write+0x5a7>
    b140:	48 8d 35 da 31 00 00 	lea    0x31da(%rip),%rsi        # e321 <exec_in_fp0+0xce1>
    b147:	e9 99 02 00 00       	jmp    b3e5 <fwp_write+0x575>
    b14c:	49 8d 75 08          	lea    0x8(%r13),%rsi
    b150:	49 8b 55 00          	mov    0x0(%r13),%rdx
    b154:	48 89 df             	mov    %rbx,%rdi
    b157:	48 81 c4 28 02 00 00 	add    $0x228,%rsp
    b15e:	85 c9                	test   %ecx,%ecx
    b160:	0f 84 d7 03 00 00    	je     b53d <fwp_write+0x6cd>
    b166:	5b                   	pop    %rbx
    b167:	41 5c                	pop    %r12
    b169:	41 5d                	pop    %r13
    b16b:	41 5e                	pop    %r14
    b16d:	41 5f                	pop    %r15
    b16f:	5d                   	pop    %rbp
    b170:	e9 cb c7 ff ff       	jmp    7940 <buf_put>
    b175:	4c 89 ef             	mov    %r13,%rdi
    b178:	e8 43 ee ff ff       	call   9fc0 <fwp_u128>
    b17d:	4c 8d 74 24 20       	lea    0x20(%rsp),%r14
    b182:	4c 89 f7             	mov    %r14,%rdi
    b185:	48 89 c6             	mov    %rax,%rsi
    b188:	e8 13 04 00 00       	call   b5a0 <fwp_fmt_u128>
    b18d:	e9 2f 02 00 00       	jmp    b3c1 <fwp_write+0x551>
    b192:	4c 89 ef             	mov    %r13,%rdi
    b195:	e8 16 ee ff ff       	call   9fb0 <fwp_i128>
    b19a:	4c 8d 74 24 20       	lea    0x20(%rsp),%r14
    b19f:	4c 89 f7             	mov    %r14,%rdi
    b1a2:	48 89 c6             	mov    %rax,%rsi
    b1a5:	e8 d6 03 00 00       	call   b580 <fwp_fmt_i128>
    b1aa:	e9 12 02 00 00       	jmp    b3c1 <fwp_write+0x551>
    b1af:	48 89 df             	mov    %rbx,%rdi
    b1b2:	be 5b 00 00 00       	mov    $0x5b,%esi
    b1b7:	e8 34 c7 ff ff       	call   78f0 <buf_putc>
    b1bc:	4d 85 ed             	test   %r13,%r13
    b1bf:	4c 8b 7c 24 08       	mov    0x8(%rsp),%r15
    b1c4:	0f 84 d5 01 00 00    	je     b39f <fwp_write+0x52f>
    b1ca:	49 8b 57 38          	mov    0x38(%r15),%rdx
    b1ce:	49 8b 75 08          	mov    0x8(%r13),%rsi
    b1d2:	48 89 df             	mov    %rbx,%rdi
    b1d5:	31 c9                	xor    %ecx,%ecx
    b1d7:	e8 94 fc ff ff       	call   ae70 <fwp_write>
    b1dc:	4d 8b 65 10          	mov    0x10(%r13),%r12
    b1e0:	4d 85 e4             	test   %r12,%r12
    b1e3:	0f 84 b6 01 00 00    	je     b39f <fwp_write+0x52f>
    b1e9:	4c 8d 35 6b 30 00 00 	lea    0x306b(%rip),%r14        # e25b <exec_in_fp0+0xc1b>
    b1f0:	48 89 df             	mov    %rbx,%rdi
    b1f3:	4c 89 f6             	mov    %r14,%rsi
    b1f6:	e8 15 c7 ff ff       	call   7910 <buf_puts>
    b1fb:	49 8b 74 24 08       	mov    0x8(%r12),%rsi
    b200:	49 8b 57 38          	mov    0x38(%r15),%rdx
    b204:	48 89 df             	mov    %rbx,%rdi
    b207:	31 c9                	xor    %ecx,%ecx
    b209:	e8 62 fc ff ff       	call   ae70 <fwp_write>
    b20e:	4d 8b 64 24 10       	mov    0x10(%r12),%r12
    b213:	4d 85 e4             	test   %r12,%r12
    b216:	75 d8                	jne    b1f0 <fwp_write+0x380>
    b218:	e9 82 01 00 00       	jmp    b39f <fwp_write+0x52f>
    b21d:	48 8b 44 24 08       	mov    0x8(%rsp),%rax
    b222:	8b 50 48             	mov    0x48(%rax),%edx
    b225:	48 89 df             	mov    %rbx,%rdi
    b228:	4c 89 ee             	mov    %r13,%rsi
    b22b:	48 81 c4 28 02 00 00 	add    $0x228,%rsp
    b232:	5b                   	pop    %rbx
    b233:	41 5c                	pop    %r12
    b235:	41 5d                	pop    %r13
    b237:	41 5e                	pop    %r14
    b239:	41 5f                	pop    %r15
    b23b:	5d                   	pop    %rbp
    b23c:	e9 2f 08 00 00       	jmp    ba70 <fwp_trits>
    b241:	49 83 fd ff          	cmp    $0xffffffffffffffff,%r13
    b245:	48 8d 05 1b 30 00 00 	lea    0x301b(%rip),%rax        # e267 <exec_in_fp0+0xc27>
    b24c:	48 8d 0d 15 31 00 00 	lea    0x3115(%rip),%rcx        # e368 <exec_in_fp0+0xd28>
    b253:	48 0f 44 c8          	cmove  %rax,%rcx
    b257:	49 83 fd 01          	cmp    $0x1,%r13
    b25b:	48 8d 35 02 30 00 00 	lea    0x3002(%rip),%rsi        # e264 <exec_in_fp0+0xc24>
    b262:	48 0f 45 f1          	cmovne %rcx,%rsi
    b266:	e9 7a 01 00 00       	jmp    b3e5 <fwp_write+0x575>
    b26b:	48 8d 35 c9 30 00 00 	lea    0x30c9(%rip),%rsi        # e33b <exec_in_fp0+0xcfb>
    b272:	48 89 df             	mov    %rbx,%rdi
    b275:	e8 96 c6 ff ff       	call   7910 <buf_puts>
    b27a:	49 83 7d 00 00       	cmpq   $0x0,0x0(%r13)
    b27f:	4c 8b 7c 24 08       	mov    0x8(%rsp),%r15
    b284:	0f 84 15 01 00 00    	je     b39f <fwp_write+0x52f>
    b28a:	49 8b 57 38          	mov    0x38(%r15),%rdx
    b28e:	49 8b 75 08          	mov    0x8(%r13),%rsi
    b292:	48 89 df             	mov    %rbx,%rdi
    b295:	31 c9                	xor    %ecx,%ecx
    b297:	e8 d4 fb ff ff       	call   ae70 <fwp_write>
    b29c:	49 83 7d 00 02       	cmpq   $0x2,0x0(%r13)
    b2a1:	0f 82 f8 00 00 00    	jb     b39f <fwp_write+0x52f>
    b2a7:	41 be 01 00 00 00    	mov    $0x1,%r14d
    b2ad:	4c 8d 25 a7 2f 00 00 	lea    0x2fa7(%rip),%r12        # e25b <exec_in_fp0+0xc1b>
    b2b4:	66 66 66 2e 0f 1f 84 	data16 data16 cs nopw 0x0(%rax,%rax,1)
    b2bb:	00 00 00 00 00 
    b2c0:	48 89 df             	mov    %rbx,%rdi
    b2c3:	4c 89 e6             	mov    %r12,%rsi
    b2c6:	e8 45 c6 ff ff       	call   7910 <buf_puts>
    b2cb:	4b 8b 74 f5 08       	mov    0x8(%r13,%r14,8),%rsi
    b2d0:	49 8b 57 38          	mov    0x38(%r15),%rdx
    b2d4:	48 89 df             	mov    %rbx,%rdi
    b2d7:	31 c9                	xor    %ecx,%ecx
    b2d9:	e8 92 fb ff ff       	call   ae70 <fwp_write>
    b2de:	49 ff c6             	inc    %r14
    b2e1:	4d 3b 75 00          	cmp    0x0(%r13),%r14
    b2e5:	72 d9                	jb     b2c0 <fwp_write+0x450>
    b2e7:	e9 b3 00 00 00       	jmp    b39f <fwp_write+0x52f>
    b2ec:	48 8d 35 3e 30 00 00 	lea    0x303e(%rip),%rsi        # e331 <exec_in_fp0+0xcf1>
    b2f3:	48 89 df             	mov    %rbx,%rdi
    b2f6:	e8 15 c6 ff ff       	call   7910 <buf_puts>
    b2fb:	49 83 7d 00 00       	cmpq   $0x0,0x0(%r13)
    b300:	0f 84 99 00 00 00    	je     b39f <fwp_write+0x52f>
    b306:	4c 89 ed             	mov    %r13,%rbp
    b309:	41 0f b6 4d 08       	movzbl 0x8(%r13),%ecx
    b30e:	48 8d 15 23 30 00 00 	lea    0x3023(%rip),%rdx        # e338 <exec_in_fp0+0xcf8>
    b315:	4c 8d 7c 24 20       	lea    0x20(%rsp),%r15
    b31a:	be 00 02 00 00       	mov    $0x200,%esi
    b31f:	4c 89 ff             	mov    %r15,%rdi
    b322:	31 c0                	xor    %eax,%eax
    b324:	e8 a7 6e ff ff       	call   21d0 <snprintf@plt>
    b329:	48 89 df             	mov    %rbx,%rdi
    b32c:	4c 89 fe             	mov    %r15,%rsi
    b32f:	e8 dc c5 ff ff       	call   7910 <buf_puts>
    b334:	49 83 7d 00 02       	cmpq   $0x2,0x0(%r13)
    b339:	72 64                	jb     b39f <fwp_write+0x52f>
    b33b:	41 be 09 00 00 00    	mov    $0x9,%r14d
    b341:	4c 8d 3d 13 2f 00 00 	lea    0x2f13(%rip),%r15        # e25b <exec_in_fp0+0xc1b>
    b348:	4c 8d 25 e9 2f 00 00 	lea    0x2fe9(%rip),%r12        # e338 <exec_in_fp0+0xcf8>
    b34f:	4c 8d 6c 24 20       	lea    0x20(%rsp),%r13
    b354:	66 66 66 2e 0f 1f 84 	data16 data16 cs nopw 0x0(%rax,%rax,1)
    b35b:	00 00 00 00 00 
    b360:	48 89 df             	mov    %rbx,%rdi
    b363:	4c 89 fe             	mov    %r15,%rsi
    b366:	e8 a5 c5 ff ff       	call   7910 <buf_puts>
    b36b:	42 0f b6 4c 35 00    	movzbl 0x0(%rbp,%r14,1),%ecx
    b371:	be 00 02 00 00       	mov    $0x200,%esi
    b376:	4c 89 ef             	mov    %r13,%rdi
    b379:	4c 89 e2             	mov    %r12,%rdx
    b37c:	31 c0                	xor    %eax,%eax
    b37e:	e8 4d 6e ff ff       	call   21d0 <snprintf@plt>
    b383:	48 89 df             	mov    %rbx,%rdi
    b386:	4c 89 ee             	mov    %r13,%rsi
    b389:	e8 82 c5 ff ff       	call   7910 <buf_puts>
    b38e:	49 8d 46 01          	lea    0x1(%r14),%rax
    b392:	49 83 c6 f9          	add    $0xfffffffffffffff9,%r14
    b396:	4c 3b 75 00          	cmp    0x0(%rbp),%r14
    b39a:	49 89 c6             	mov    %rax,%r14
    b39d:	72 c1                	jb     b360 <fwp_write+0x4f0>
    b39f:	48 89 df             	mov    %rbx,%rdi
    b3a2:	be 5d 00 00 00       	mov    $0x5d,%esi
    b3a7:	e9 7b 01 00 00       	jmp    b527 <fwp_write+0x6b7>
    b3ac:	4c 89 ef             	mov    %r13,%rdi
    b3af:	e8 7c 9a ff ff       	call   4e30 <fwp_f32>
    b3b4:	4c 8d 74 24 20       	lea    0x20(%rsp),%r14
    b3b9:	4c 89 f7             	mov    %r14,%rdi
    b3bc:	e8 ef 03 00 00       	call   b7b0 <fwp_fmt_f32>
    b3c1:	48 89 df             	mov    %rbx,%rdi
    b3c4:	4c 89 f6             	mov    %r14,%rsi
    b3c7:	e8 44 c5 ff ff       	call   7910 <buf_puts>
    b3cc:	48 81 c4 28 02 00 00 	add    $0x228,%rsp
    b3d3:	5b                   	pop    %rbx
    b3d4:	41 5c                	pop    %r12
    b3d6:	41 5d                	pop    %r13
    b3d8:	41 5e                	pop    %r14
    b3da:	41 5f                	pop    %r15
    b3dc:	5d                   	pop    %rbp
    b3dd:	c3                   	ret
    b3de:	48 8d 35 31 2f 00 00 	lea    0x2f31(%rip),%rsi        # e316 <exec_in_fp0+0xcd6>
    b3e5:	48 89 df             	mov    %rbx,%rdi
    b3e8:	48 81 c4 28 02 00 00 	add    $0x228,%rsp
    b3ef:	5b                   	pop    %rbx
    b3f0:	41 5c                	pop    %r12
    b3f2:	41 5d                	pop    %r13
    b3f4:	41 5e                	pop    %r14
    b3f6:	41 5f                	pop    %r15
    b3f8:	5d                   	pop    %rbp
    b3f9:	e9 12 c5 ff ff       	jmp    7910 <buf_puts>
    b3fe:	48 8d 35 25 2f 00 00 	lea    0x2f25(%rip),%rsi        # e32a <exec_in_fp0+0xcea>
    b405:	48 89 df             	mov    %rbx,%rdi
    b408:	e8 03 c5 ff ff       	call   7910 <buf_puts>
    b40d:	49 83 c5 10          	add    $0x10,%r13
    b411:	48 89 df             	mov    %rbx,%rdi
    b414:	4c 89 ee             	mov    %r13,%rsi
    b417:	e8 f4 c4 ff ff       	call   7910 <buf_puts>
    b41c:	48 89 df             	mov    %rbx,%rdi
    b41f:	be 3e 00 00 00       	mov    $0x3e,%esi
    b424:	e9 fe 00 00 00       	jmp    b527 <fwp_write+0x6b7>
    b429:	41 83 7f 10 00       	cmpl   $0x0,0x10(%r15)
    b42e:	0f 84 35 01 00 00    	je     b569 <fwp_write+0x6f9>
    b434:	4d 8d 77 10          	lea    0x10(%r15),%r14
    b438:	4d 85 e4             	test   %r12,%r12
    b43b:	0f 94 c0             	sete   %al
    b43e:	41 83 7f 48 00       	cmpl   $0x0,0x48(%r15)
    b443:	40 0f 95 c5          	setne  %bpl
    b447:	40 20 c5             	and    %al,%bpl
    b44a:	40 84 ed             	test   %bpl,%bpl
    b44d:	b8 28 00 00 00       	mov    $0x28,%eax
    b452:	be 7b 00 00 00       	mov    $0x7b,%esi
    b457:	0f 45 f0             	cmovne %eax,%esi
    b45a:	48 89 df             	mov    %rbx,%rdi
    b45d:	e8 8e c4 ff ff       	call   78f0 <buf_putc>
    b462:	41 83 3e 00          	cmpl   $0x0,(%r14)
    b466:	0f 8e a8 00 00 00    	jle    b514 <fwp_write+0x6a4>
    b46c:	40 84 ed             	test   %bpl,%bpl
    b46f:	75 1e                	jne    b48f <fwp_write+0x61f>
    b471:	49 8b 47 18          	mov    0x18(%r15),%rax
    b475:	48 8b 30             	mov    (%rax),%rsi
    b478:	48 89 df             	mov    %rbx,%rdi
    b47b:	e8 90 c4 ff ff       	call   7910 <buf_puts>
    b480:	48 8d 35 c8 2e 00 00 	lea    0x2ec8(%rip),%rsi        # e34f <exec_in_fp0+0xd0f>
    b487:	48 89 df             	mov    %rbx,%rdi
    b48a:	e8 81 c4 ff ff       	call   7910 <buf_puts>
    b48f:	49 8b 75 08          	mov    0x8(%r13),%rsi
    b493:	49 8b 47 20          	mov    0x20(%r15),%rax
    b497:	48 8b 10             	mov    (%rax),%rdx
    b49a:	48 89 df             	mov    %rbx,%rdi
    b49d:	31 c9                	xor    %ecx,%ecx
    b49f:	e8 cc f9 ff ff       	call   ae70 <fwp_write>
    b4a4:	41 83 7f 10 02       	cmpl   $0x2,0x10(%r15)
    b4a9:	7c 69                	jl     b514 <fwp_write+0x6a4>
    b4ab:	41 be 01 00 00 00    	mov    $0x1,%r14d
    b4b1:	4c 8d 25 a3 2d 00 00 	lea    0x2da3(%rip),%r12        # e25b <exec_in_fp0+0xc1b>
    b4b8:	eb 29                	jmp    b4e3 <fwp_write+0x673>
    b4ba:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)
    b4c0:	4b 8b 74 f5 08       	mov    0x8(%r13,%r14,8),%rsi
    b4c5:	49 8b 47 20          	mov    0x20(%r15),%rax
    b4c9:	4a 8b 14 f0          	mov    (%rax,%r14,8),%rdx
    b4cd:	48 89 df             	mov    %rbx,%rdi
    b4d0:	31 c9                	xor    %ecx,%ecx
    b4d2:	e8 99 f9 ff ff       	call   ae70 <fwp_write>
    b4d7:	49 ff c6             	inc    %r14
    b4da:	49 63 47 10          	movslq 0x10(%r15),%rax
    b4de:	49 39 c6             	cmp    %rax,%r14
    b4e1:	7d 31                	jge    b514 <fwp_write+0x6a4>
    b4e3:	48 89 df             	mov    %rbx,%rdi
    b4e6:	4c 89 e6             	mov    %r12,%rsi
    b4e9:	e8 22 c4 ff ff       	call   7910 <buf_puts>
    b4ee:	40 84 ed             	test   %bpl,%bpl
    b4f1:	75 cd                	jne    b4c0 <fwp_write+0x650>
    b4f3:	49 8b 47 18          	mov    0x18(%r15),%rax
    b4f7:	4a 8b 34 f0          	mov    (%rax,%r14,8),%rsi
    b4fb:	48 89 df             	mov    %rbx,%rdi
    b4fe:	e8 0d c4 ff ff       	call   7910 <buf_puts>
    b503:	48 89 df             	mov    %rbx,%rdi
    b506:	48 8d 35 42 2e 00 00 	lea    0x2e42(%rip),%rsi        # e34f <exec_in_fp0+0xd0f>
    b50d:	e8 fe c3 ff ff       	call   7910 <buf_puts>
    b512:	eb ac                	jmp    b4c0 <fwp_write+0x650>
    b514:	40 84 ed             	test   %bpl,%bpl
    b517:	b8 29 00 00 00       	mov    $0x29,%eax
    b51c:	be 7d 00 00 00       	mov    $0x7d,%esi
    b521:	0f 45 f0             	cmovne %eax,%esi
    b524:	48 89 df             	mov    %rbx,%rdi
    b527:	48 81 c4 28 02 00 00 	add    $0x228,%rsp
    b52e:	5b                   	pop    %rbx
    b52f:	41 5c                	pop    %r12
    b531:	41 5d                	pop    %r13
    b533:	41 5e                	pop    %r14
    b535:	41 5f                	pop    %r15
    b537:	5d                   	pop    %rbp
    b538:	e9 b3 c3 ff ff       	jmp    78f0 <buf_putc>
    b53d:	5b                   	pop    %rbx
    b53e:	41 5c                	pop    %r12
    b540:	41 5d                	pop    %r13
    b542:	41 5e                	pop    %r14
    b544:	41 5f                	pop    %r15
    b546:	5d                   	pop    %rbp
    b547:	e9 14 06 00 00       	jmp    bb60 <fwp_escape>
    b54c:	49 8b 75 08          	mov    0x8(%r13),%rsi
    b550:	48 89 f2             	mov    %rsi,%rdx
    b553:	48 c1 fa 3f          	sar    $0x3f,%rdx
    b557:	4c 8d 74 24 20       	lea    0x20(%rsp),%r14
    b55c:	4c 89 f7             	mov    %r14,%rdi
    b55f:	e8 0c 07 00 00       	call   bc70 <fwp_fmt_duration>
    b564:	e9 58 fe ff ff       	jmp    b3c1 <fwp_write+0x551>
    b569:	48 8d 35 dc 2d 00 00 	lea    0x2ddc(%rip),%rsi        # e34c <exec_in_fp0+0xd0c>
    b570:	e9 70 fe ff ff       	jmp    b3e5 <fwp_write+0x575>
    b575:	66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
    b57c:	00 00 00 00 

000000000000b580 <fwp_fmt_i128>:
    b580:	48 85 d2             	test   %rdx,%rdx
    b583:	79 1b                	jns    b5a0 <fwp_fmt_u128>
    b585:	c6 07 2d             	movb   $0x2d,(%rdi)
    b588:	48 ff c7             	inc    %rdi
    b58b:	31 c0                	xor    %eax,%eax
    b58d:	48 f7 de             	neg    %rsi
    b590:	48 19 d0             	sbb    %rdx,%rax
    b593:	48 89 c2             	mov    %rax,%rdx
    b596:	eb 08                	jmp    b5a0 <fwp_fmt_u128>
    b598:	0f 1f 84 00 00 00 00 	nopl   0x0(%rax,%rax,1)
    b59f:	00 

000000000000b5a0 <fwp_fmt_u128>:
    b5a0:	41 56                	push   %r14
    b5a2:	53                   	push   %rbx
    b5a3:	48 89 f0             	mov    %rsi,%rax
    b5a6:	48 09 d0             	or     %rdx,%rax
    b5a9:	0f 84 9d 00 00 00    	je     b64c <fwp_fmt_u128+0xac>
    b5af:	48 89 d1             	mov    %rdx,%rcx
    b5b2:	45 31 d2             	xor    %r10d,%r10d
    b5b5:	49 bb cd cc cc cc cc 	movabs $0xcccccccccccccccd,%r11
    b5bc:	cc cc cc 
    b5bf:	48 bb cc cc cc cc cc 	movabs $0xcccccccccccccccc,%rbx
    b5c6:	cc cc cc 
    b5c9:	49 89 d6             	mov    %rdx,%r14
    b5cc:	0f 1f 40 00          	nopl   0x0(%rax)
    b5d0:	49 89 c8             	mov    %rcx,%r8
    b5d3:	49 0f a4 f0 3f       	shld   $0x3f,%rsi,%r8
    b5d8:	49 d1 ee             	shr    $1,%r14
    b5db:	4d 89 c1             	mov    %r8,%r9
    b5de:	4d 01 f1             	add    %r14,%r9
    b5e1:	49 83 d1 00          	adc    $0x0,%r9
    b5e5:	4c 89 c8             	mov    %r9,%rax
    b5e8:	49 f7 e3             	mul    %r11
    b5eb:	48 c1 ea 02          	shr    $0x2,%rdx
    b5ef:	48 8d 04 92          	lea    (%rdx,%rdx,4),%rax
    b5f3:	49 29 c1             	sub    %rax,%r9
    b5f6:	4d 29 c8             	sub    %r9,%r8
    b5f9:	49 83 de 00          	sbb    $0x0,%r14
    b5fd:	4d 89 c1             	mov    %r8,%r9
    b600:	4c 0f af cb          	imul   %rbx,%r9
    b604:	4c 89 c0             	mov    %r8,%rax
    b607:	49 f7 e3             	mul    %r11
    b60a:	4c 01 ca             	add    %r9,%rdx
    b60d:	4d 0f af f3          	imul   %r11,%r14
    b611:	49 01 d6             	add    %rdx,%r14
    b614:	48 89 c2             	mov    %rax,%rdx
    b617:	48 01 c2             	add    %rax,%rdx
    b61a:	48 8d 14 92          	lea    (%rdx,%rdx,4),%rdx
    b61e:	41 89 f0             	mov    %esi,%r8d
    b621:	41 29 d0             	sub    %edx,%r8d
    b624:	41 80 c8 30          	or     $0x30,%r8b
    b628:	46 88 44 14 b8       	mov    %r8b,-0x48(%rsp,%r10,1)
    b62d:	49 ff c2             	inc    %r10
    b630:	48 83 fe 0a          	cmp    $0xa,%rsi
    b634:	48 83 d9 00          	sbb    $0x0,%rcx
    b638:	48 89 c6             	mov    %rax,%rsi
    b63b:	4c 89 f1             	mov    %r14,%rcx
    b63e:	73 90                	jae    b5d0 <fwp_fmt_u128+0x30>
    b640:	45 85 d2             	test   %r10d,%r10d
    b643:	7f 12                	jg     b657 <fwp_fmt_u128+0xb7>
    b645:	31 c0                	xor    %eax,%eax
    b647:	e9 56 01 00 00       	jmp    b7a2 <fwp_fmt_u128+0x202>
    b64c:	c6 44 24 b8 30       	movb   $0x30,-0x48(%rsp)
    b651:	41 ba 01 00 00 00    	mov    $0x1,%r10d
    b657:	44 89 d0             	mov    %r10d,%eax
    b65a:	41 83 fa 08          	cmp    $0x8,%r10d
    b65e:	73 0a                	jae    b66a <fwp_fmt_u128+0xca>
    b660:	31 c9                	xor    %ecx,%ecx
    b662:	48 89 c2             	mov    %rax,%rdx
    b665:	e9 10 01 00 00       	jmp    b77a <fwp_fmt_u128+0x1da>
    b66a:	83 f8 20             	cmp    $0x20,%eax
    b66d:	73 07                	jae    b676 <fwp_fmt_u128+0xd6>
    b66f:	31 c9                	xor    %ecx,%ecx
    b671:	e9 a4 00 00 00       	jmp    b71a <fwp_fmt_u128+0x17a>
    b676:	89 c1                	mov    %eax,%ecx
    b678:	81 e1 e0 ff ff 7f    	and    $0x7fffffe0,%ecx
    b67e:	48 8d 54 24 b8       	lea    -0x48(%rsp),%rdx
    b683:	48 01 c2             	add    %rax,%rdx
    b686:	48 83 c2 f0          	add    $0xfffffffffffffff0,%rdx
    b68a:	31 f6                	xor    %esi,%esi
    b68c:	66 0f ef c0          	pxor   %xmm0,%xmm0
    b690:	f3 0f 6f 4a f0       	movdqu -0x10(%rdx),%xmm1
    b695:	f3 0f 6f 12          	movdqu (%rdx),%xmm2
    b699:	66 0f 6f da          	movdqa %xmm2,%xmm3
    b69d:	66 0f 60 d8          	punpcklbw %xmm0,%xmm3
    b6a1:	66 0f 70 db 4e       	pshufd $0x4e,%xmm3,%xmm3
    b6a6:	f2 0f 70 db 1b       	pshuflw $0x1b,%xmm3,%xmm3
    b6ab:	f3 0f 70 db 1b       	pshufhw $0x1b,%xmm3,%xmm3
    b6b0:	66 0f 68 d0          	punpckhbw %xmm0,%xmm2
    b6b4:	66 0f 70 d2 4e       	pshufd $0x4e,%xmm2,%xmm2
    b6b9:	f2 0f 70 d2 1b       	pshuflw $0x1b,%xmm2,%xmm2
    b6be:	f3 0f 70 d2 1b       	pshufhw $0x1b,%xmm2,%xmm2
    b6c3:	66 0f 67 d3          	packuswb %xmm3,%xmm2
    b6c7:	66 0f 6f d9          	movdqa %xmm1,%xmm3
    b6cb:	66 0f 60 d8          	punpcklbw %xmm0,%xmm3
    b6cf:	66 0f 70 db 4e       	pshufd $0x4e,%xmm3,%xmm3
    b6d4:	f2 0f 70 db 1b       	pshuflw $0x1b,%xmm3,%xmm3
    b6d9:	f3 0f 70 db 1b       	pshufhw $0x1b,%xmm3,%xmm3
    b6de:	66 0f 68 c8          	punpckhbw %xmm0,%xmm1
    b6e2:	66 0f 70 c9 4e       	pshufd $0x4e,%xmm1,%xmm1
    b6e7:	f2 0f 70 c9 1b       	pshuflw $0x1b,%xmm1,%xmm1
    b6ec:	f3 0f 70 c9 1b       	pshufhw $0x1b,%xmm1,%xmm1
    b6f1:	66 0f 67 cb          	packuswb %xmm3,%xmm1
    b6f5:	f3 0f 7f 14 37       	movdqu %xmm2,(%rdi,%rsi,1)
    b6fa:	f3 0f 7f 4c 37 10    	movdqu %xmm1,0x10(%rdi,%rsi,1)
    b700:	48 83 c6 20          	add    $0x20,%rsi
    b704:	48 83 c2 e0          	add    $0xffffffffffffffe0,%rdx
    b708:	48 39 f1             	cmp    %rsi,%rcx
    b70b:	75 83                	jne    b690 <fwp_fmt_u128+0xf0>
    b70d:	48 39 c1             	cmp    %rax,%rcx
    b710:	0f 84 8c 00 00 00    	je     b7a2 <fwp_fmt_u128+0x202>
    b716:	a8 18                	test   $0x18,%al
    b718:	74 5b                	je     b775 <fwp_fmt_u128+0x1d5>
    b71a:	48 89 ce             	mov    %rcx,%rsi
    b71d:	89 c1                	mov    %eax,%ecx
    b71f:	81 e1 f8 ff ff 7f    	and    $0x7ffffff8,%ecx
    b725:	89 c2                	mov    %eax,%edx
    b727:	83 e2 07             	and    $0x7,%edx
    b72a:	49 89 c0             	mov    %rax,%r8
    b72d:	49 29 f0             	sub    %rsi,%r8
    b730:	49 01 e0             	add    %rsp,%r8
    b733:	49 83 c0 b0          	add    $0xffffffffffffffb0,%r8
    b737:	66 0f ef c0          	pxor   %xmm0,%xmm0
    b73b:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)
    b740:	f3 41 0f 7e 08       	movq   (%r8),%xmm1
    b745:	66 0f 60 c8          	punpcklbw %xmm0,%xmm1
    b749:	66 0f 70 c9 4e       	pshufd $0x4e,%xmm1,%xmm1
    b74e:	f2 0f 70 c9 1b       	pshuflw $0x1b,%xmm1,%xmm1
    b753:	f3 0f 70 c9 1b       	pshufhw $0x1b,%xmm1,%xmm1
    b758:	66 0f 67 c9          	packuswb %xmm1,%xmm1
    b75c:	66 0f d6 0c 37       	movq   %xmm1,(%rdi,%rsi,1)
    b761:	48 83 c6 08          	add    $0x8,%rsi
    b765:	49 83 c0 f8          	add    $0xfffffffffffffff8,%r8
    b769:	48 39 f1             	cmp    %rsi,%rcx
    b76c:	75 d2                	jne    b740 <fwp_fmt_u128+0x1a0>
    b76e:	48 39 c1             	cmp    %rax,%rcx
    b771:	75 07                	jne    b77a <fwp_fmt_u128+0x1da>
    b773:	eb 2d                	jmp    b7a2 <fwp_fmt_u128+0x202>
    b775:	89 c2                	mov    %eax,%edx
    b777:	83 e2 1f             	and    $0x1f,%edx
    b77a:	48 8d 74 24 b8       	lea    -0x48(%rsp),%rsi
    b77f:	48 01 f2             	add    %rsi,%rdx
    b782:	48 ff ca             	dec    %rdx
    b785:	66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
    b78c:	00 00 00 00 
    b790:	0f b6 32             	movzbl (%rdx),%esi
    b793:	40 88 34 0f          	mov    %sil,(%rdi,%rcx,1)
    b797:	48 ff c1             	inc    %rcx
    b79a:	48 ff ca             	dec    %rdx
    b79d:	48 39 c8             	cmp    %rcx,%rax
    b7a0:	75 ee                	jne    b790 <fwp_fmt_u128+0x1f0>
    b7a2:	c6 04 07 00          	movb   $0x0,(%rdi,%rax,1)
    b7a6:	5b                   	pop    %rbx
    b7a7:	41 5e                	pop    %r14
    b7a9:	c3                   	ret
    b7aa:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)

000000000000b7b0 <fwp_fmt_f32>:
    b7b0:	53                   	push   %rbx
    b7b1:	48 83 ec 20          	sub    $0x20,%rsp
    b7b5:	48 89 fb             	mov    %rdi,%rbx
    b7b8:	0f 2e c0             	ucomiss %xmm0,%xmm0
    b7bb:	0f 8a d8 01 00 00    	jp     b999 <fwp_fmt_f32+0x1e9>
    b7c1:	0f 28 c8             	movaps %xmm0,%xmm1
    b7c4:	0f 28 05 75 19 00 00 	movaps 0x1975(%rip),%xmm0        # d140 <_IO_stdin_used+0x140>
    b7cb:	0f 54 c1             	andps  %xmm1,%xmm0
    b7ce:	0f 2e 05 2f 18 00 00 	ucomiss 0x182f(%rip),%xmm0        # d004 <_IO_stdin_used+0x4>
    b7d5:	72 25                	jb     b7fc <fwp_fmt_f32+0x4c>
    b7d7:	0f 57 c0             	xorps  %xmm0,%xmm0
    b7da:	0f 2e c8             	ucomiss %xmm0,%xmm1
    b7dd:	48 8d 05 af 2a 00 00 	lea    0x2aaf(%rip),%rax        # e293 <exec_in_fp0+0xc53>
    b7e4:	48 8d 35 a7 2a 00 00 	lea    0x2aa7(%rip),%rsi        # e292 <exec_in_fp0+0xc52>
    b7eb:	48 0f 47 f0          	cmova  %rax,%rsi
    b7ef:	48 89 df             	mov    %rbx,%rdi
    b7f2:	48 83 c4 20          	add    $0x20,%rsp
    b7f6:	5b                   	pop    %rbx
    b7f7:	e9 b4 68 ff ff       	jmp    20b0 <strcpy@plt>
    b7fc:	0f 57 c0             	xorps  %xmm0,%xmm0
    b7ff:	f3 0f 5a c1          	cvtss2sd %xmm1,%xmm0
    b803:	48 89 df             	mov    %rbx,%rdi
    b806:	f2 0f 11 44 24 08    	movsd  %xmm0,0x8(%rsp)
    b80c:	be 01 00 00 00       	mov    $0x1,%esi
    b811:	0f 29 4c 24 10       	movaps %xmm1,0x10(%rsp)
    b816:	e8 95 07 00 00       	call   bfb0 <fwp_format_g>
    b81b:	48 89 df             	mov    %rbx,%rdi
    b81e:	31 f6                	xor    %esi,%esi
    b820:	e8 db 69 ff ff       	call   2200 <strtof@plt>
    b825:	0f 2e 44 24 10       	ucomiss 0x10(%rsp),%xmm0
    b82a:	75 06                	jne    b832 <fwp_fmt_f32+0x82>
    b82c:	0f 8b 5a 01 00 00    	jnp    b98c <fwp_fmt_f32+0x1dc>
    b832:	48 89 df             	mov    %rbx,%rdi
    b835:	f2 0f 10 44 24 08    	movsd  0x8(%rsp),%xmm0
    b83b:	be 02 00 00 00       	mov    $0x2,%esi
    b840:	e8 6b 07 00 00       	call   bfb0 <fwp_format_g>
    b845:	48 89 df             	mov    %rbx,%rdi
    b848:	31 f6                	xor    %esi,%esi
    b84a:	e8 b1 69 ff ff       	call   2200 <strtof@plt>
    b84f:	0f 2e 44 24 10       	ucomiss 0x10(%rsp),%xmm0
    b854:	75 06                	jne    b85c <fwp_fmt_f32+0xac>
    b856:	0f 8b 30 01 00 00    	jnp    b98c <fwp_fmt_f32+0x1dc>
    b85c:	48 89 df             	mov    %rbx,%rdi
    b85f:	f2 0f 10 44 24 08    	movsd  0x8(%rsp),%xmm0
    b865:	be 03 00 00 00       	mov    $0x3,%esi
    b86a:	e8 41 07 00 00       	call   bfb0 <fwp_format_g>
    b86f:	48 89 df             	mov    %rbx,%rdi
    b872:	31 f6                	xor    %esi,%esi
    b874:	e8 87 69 ff ff       	call   2200 <strtof@plt>
    b879:	0f 2e 44 24 10       	ucomiss 0x10(%rsp),%xmm0
    b87e:	75 06                	jne    b886 <fwp_fmt_f32+0xd6>
    b880:	0f 8b 06 01 00 00    	jnp    b98c <fwp_fmt_f32+0x1dc>
    b886:	48 89 df             	mov    %rbx,%rdi
    b889:	f2 0f 10 44 24 08    	movsd  0x8(%rsp),%xmm0
    b88f:	be 04 00 00 00       	mov    $0x4,%esi
    b894:	e8 17 07 00 00       	call   bfb0 <fwp_format_g>
    b899:	48 89 df             	mov    %rbx,%rdi
    b89c:	31 f6                	xor    %esi,%esi
    b89e:	e8 5d 69 ff ff       	call   2200 <strtof@plt>
    b8a3:	0f 2e 44 24 10       	ucomiss 0x10(%rsp),%xmm0
    b8a8:	75 06                	jne    b8b0 <fwp_fmt_f32+0x100>
    b8aa:	0f 8b dc 00 00 00    	jnp    b98c <fwp_fmt_f32+0x1dc>
    b8b0:	48 89 df             	mov    %rbx,%rdi
    b8b3:	f2 0f 10 44 24 08    	movsd  0x8(%rsp),%xmm0
    b8b9:	be 05 00 00 00       	mov    $0x5,%esi
    b8be:	e8 ed 06 00 00       	call   bfb0 <fwp_format_g>
    b8c3:	48 89 df             	mov    %rbx,%rdi
    b8c6:	31 f6                	xor    %esi,%esi
    b8c8:	e8 33 69 ff ff       	call   2200 <strtof@plt>
    b8cd:	0f 2e 44 24 10       	ucomiss 0x10(%rsp),%xmm0
    b8d2:	75 06                	jne    b8da <fwp_fmt_f32+0x12a>
    b8d4:	0f 8b b2 00 00 00    	jnp    b98c <fwp_fmt_f32+0x1dc>
    b8da:	48 89 df             	mov    %rbx,%rdi
    b8dd:	f2 0f 10 44 24 08    	movsd  0x8(%rsp),%xmm0
    b8e3:	be 06 00 00 00       	mov    $0x6,%esi
    b8e8:	e8 c3 06 00 00       	call   bfb0 <fwp_format_g>
    b8ed:	48 89 df             	mov    %rbx,%rdi
    b8f0:	31 f6                	xor    %esi,%esi
    b8f2:	e8 09 69 ff ff       	call   2200 <strtof@plt>
    b8f7:	0f 2e 44 24 10       	ucomiss 0x10(%rsp),%xmm0
    b8fc:	75 06                	jne    b904 <fwp_fmt_f32+0x154>
    b8fe:	0f 8b 88 00 00 00    	jnp    b98c <fwp_fmt_f32+0x1dc>
    b904:	48 89 df             	mov    %rbx,%rdi
    b907:	f2 0f 10 44 24 08    	movsd  0x8(%rsp),%xmm0
    b90d:	be 07 00 00 00       	mov    $0x7,%esi
    b912:	e8 99 06 00 00       	call   bfb0 <fwp_format_g>
    b917:	48 89 df             	mov    %rbx,%rdi
    b91a:	31 f6                	xor    %esi,%esi
    b91c:	e8 df 68 ff ff       	call   2200 <strtof@plt>
    b921:	0f 2e 44 24 10       	ucomiss 0x10(%rsp),%xmm0
    b926:	75 02                	jne    b92a <fwp_fmt_f32+0x17a>
    b928:	7b 62                	jnp    b98c <fwp_fmt_f32+0x1dc>
    b92a:	48 89 df             	mov    %rbx,%rdi
    b92d:	f2 0f 10 44 24 08    	movsd  0x8(%rsp),%xmm0
    b933:	be 08 00 00 00       	mov    $0x8,%esi
    b938:	e8 73 06 00 00       	call   bfb0 <fwp_format_g>
    b93d:	48 89 df             	mov    %rbx,%rdi
    b940:	31 f6                	xor    %esi,%esi
    b942:	e8 b9 68 ff ff       	call   2200 <strtof@plt>
    b947:	0f 28 4c 24 10       	movaps 0x10(%rsp),%xmm1
    b94c:	0f 2e c1             	ucomiss %xmm1,%xmm0
    b94f:	75 02                	jne    b953 <fwp_fmt_f32+0x1a3>
    b951:	7b 39                	jnp    b98c <fwp_fmt_f32+0x1dc>
    b953:	48 89 df             	mov    %rbx,%rdi
    b956:	f2 0f 10 44 24 08    	movsd  0x8(%rsp),%xmm0
    b95c:	be 09 00 00 00       	mov    $0x9,%esi
    b961:	e8 4a 06 00 00       	call   bfb0 <fwp_format_g>
    b966:	48 89 df             	mov    %rbx,%rdi
    b969:	31 f6                	xor    %esi,%esi
    b96b:	e8 90 68 ff ff       	call   2200 <strtof@plt>
    b970:	0f 2e 44 24 10       	ucomiss 0x10(%rsp),%xmm0
    b975:	75 02                	jne    b979 <fwp_fmt_f32+0x1c9>
    b977:	7b 13                	jnp    b98c <fwp_fmt_f32+0x1dc>
    b979:	48 89 df             	mov    %rbx,%rdi
    b97c:	f2 0f 10 44 24 08    	movsd  0x8(%rsp),%xmm0
    b982:	be 09 00 00 00       	mov    $0x9,%esi
    b987:	e8 24 06 00 00       	call   bfb0 <fwp_format_g>
    b98c:	48 89 df             	mov    %rbx,%rdi
    b98f:	48 83 c4 20          	add    $0x20,%rsp
    b993:	5b                   	pop    %rbx
    b994:	e9 97 07 00 00       	jmp    c130 <fwp_finish_float>
    b999:	c7 03 4e 61 4e 00    	movl   $0x4e614e,(%rbx)
    b99f:	48 83 c4 20          	add    $0x20,%rsp
    b9a3:	5b                   	pop    %rbx
    b9a4:	c3                   	ret
    b9a5:	66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
    b9ac:	00 00 00 00 

000000000000b9b0 <fwp_fmt_f64>:
    b9b0:	55                   	push   %rbp
    b9b1:	53                   	push   %rbx
    b9b2:	48 83 ec 18          	sub    $0x18,%rsp
    b9b6:	48 89 fb             	mov    %rdi,%rbx
    b9b9:	66 0f 2e c0          	ucomisd %xmm0,%xmm0
    b9bd:	0f 8a 98 00 00 00    	jp     ba5b <fwp_fmt_f64+0xab>
    b9c3:	66 0f 28 c8          	movapd %xmm0,%xmm1
    b9c7:	66 0f 28 05 81 17 00 	movapd 0x1781(%rip),%xmm0        # d150 <_IO_stdin_used+0x150>
    b9ce:	00 
    b9cf:	66 0f 54 c1          	andpd  %xmm1,%xmm0
    b9d3:	66 0f 2e 05 4d 16 00 	ucomisd 0x164d(%rip),%xmm0        # d028 <_IO_stdin_used+0x28>
    b9da:	00 
    b9db:	72 28                	jb     ba05 <fwp_fmt_f64+0x55>
    b9dd:	66 0f 57 c0          	xorpd  %xmm0,%xmm0
    b9e1:	66 0f 2e c8          	ucomisd %xmm0,%xmm1
    b9e5:	48 8d 05 a7 28 00 00 	lea    0x28a7(%rip),%rax        # e293 <exec_in_fp0+0xc53>
    b9ec:	48 8d 35 9f 28 00 00 	lea    0x289f(%rip),%rsi        # e292 <exec_in_fp0+0xc52>
    b9f3:	48 0f 47 f0          	cmova  %rax,%rsi
    b9f7:	48 89 df             	mov    %rbx,%rdi
    b9fa:	48 83 c4 18          	add    $0x18,%rsp
    b9fe:	5b                   	pop    %rbx
    b9ff:	5d                   	pop    %rbp
    ba00:	e9 ab 66 ff ff       	jmp    20b0 <strcpy@plt>
    ba05:	bd 01 00 00 00       	mov    $0x1,%ebp
    ba0a:	66 0f 29 0c 24       	movapd %xmm1,(%rsp)
    ba0f:	90                   	nop
    ba10:	48 89 df             	mov    %rbx,%rdi
    ba13:	66 0f 28 c1          	movapd %xmm1,%xmm0
    ba17:	89 ee                	mov    %ebp,%esi
    ba19:	e8 92 05 00 00       	call   bfb0 <fwp_format_g>
    ba1e:	48 89 df             	mov    %rbx,%rdi
    ba21:	31 f6                	xor    %esi,%esi
    ba23:	e8 d8 66 ff ff       	call   2100 <strtod@plt>
    ba28:	66 0f 28 0c 24       	movapd (%rsp),%xmm1
    ba2d:	66 0f 2e c1          	ucomisd %xmm1,%xmm0
    ba31:	75 02                	jne    ba35 <fwp_fmt_f64+0x85>
    ba33:	7b 18                	jnp    ba4d <fwp_fmt_f64+0x9d>
    ba35:	ff c5                	inc    %ebp
    ba37:	83 fd 12             	cmp    $0x12,%ebp
    ba3a:	75 d4                	jne    ba10 <fwp_fmt_f64+0x60>
    ba3c:	48 89 df             	mov    %rbx,%rdi
    ba3f:	66 0f 28 c1          	movapd %xmm1,%xmm0
    ba43:	be 11 00 00 00       	mov    $0x11,%esi
    ba48:	e8 63 05 00 00       	call   bfb0 <fwp_format_g>
    ba4d:	48 89 df             	mov    %rbx,%rdi
    ba50:	48 83 c4 18          	add    $0x18,%rsp
    ba54:	5b                   	pop    %rbx
    ba55:	5d                   	pop    %rbp
    ba56:	e9 d5 06 00 00       	jmp    c130 <fwp_finish_float>
    ba5b:	c7 03 4e 61 4e 00    	movl   $0x4e614e,(%rbx)
    ba61:	48 83 c4 18          	add    $0x18,%rsp
    ba65:	5b                   	pop    %rbx
    ba66:	5d                   	pop    %rbp
    ba67:	c3                   	ret
    ba68:	0f 1f 84 00 00 00 00 	nopl   0x0(%rax,%rax,1)
    ba6f:	00 

000000000000ba70 <fwp_trits>:
    ba70:	55                   	push   %rbp
    ba71:	41 57                	push   %r15
    ba73:	41 56                	push   %r14
    ba75:	53                   	push   %rbx
    ba76:	50                   	push   %rax
    ba77:	89 d5                	mov    %edx,%ebp
    ba79:	49 89 f6             	mov    %rsi,%r14
    ba7c:	48 89 fb             	mov    %rdi,%rbx
    ba7f:	4c 63 fa             	movslq %edx,%r15
    ba82:	49 8d 7f 03          	lea    0x3(%r15),%rdi
    ba86:	e8 65 ac ff ff       	call   66f0 <fwp_alloc_leaf>
    ba8b:	48 89 c6             	mov    %rax,%rsi
    ba8e:	66 c7 00 30 74       	movw   $0x7430,(%rax)
    ba93:	45 85 ff             	test   %r15d,%r15d
    ba96:	0f 8e 9f 00 00 00    	jle    bb3b <fwp_trits+0xcb>
    ba9c:	89 e9                	mov    %ebp,%ecx
    ba9e:	48 8d 3c 31          	lea    (%rcx,%rsi,1),%rdi
    baa2:	48 ff c7             	inc    %rdi
    baa5:	48 f7 d9             	neg    %rcx
    baa8:	45 31 c0             	xor    %r8d,%r8d
    baab:	49 b9 56 55 55 55 55 	movabs $0x5555555555555556,%r9
    bab2:	55 55 55 
    bab5:	eb 35                	jmp    baec <fwp_trits+0x7c>
    bab7:	66 0f 1f 84 00 00 00 	nopw   0x0(%rax,%rax,1)
    babe:	00 00 
    bac0:	41 b3 30             	mov    $0x30,%r11b
    bac3:	46 88 1c 07          	mov    %r11b,(%rdi,%r8,1)
    bac7:	48 85 d2             	test   %rdx,%rdx
    baca:	0f 95 c2             	setne  %dl
    bacd:	4d 85 f6             	test   %r14,%r14
    bad0:	41 0f 98 c3          	sets   %r11b
    bad4:	41 20 d3             	and    %dl,%r11b
    bad7:	41 0f b6 d3          	movzbl %r11b,%edx
    badb:	48 29 d0             	sub    %rdx,%rax
    bade:	4c 01 d0             	add    %r10,%rax
    bae1:	49 ff c8             	dec    %r8
    bae4:	49 89 c6             	mov    %rax,%r14
    bae7:	4c 39 c1             	cmp    %r8,%rcx
    baea:	74 4f                	je     bb3b <fwp_trits+0xcb>
    baec:	4c 89 f0             	mov    %r14,%rax
    baef:	49 f7 e9             	imul   %r9
    baf2:	48 89 d0             	mov    %rdx,%rax
    baf5:	48 c1 e8 3f          	shr    $0x3f,%rax
    baf9:	48 01 d0             	add    %rdx,%rax
    bafc:	4c 8d 14 40          	lea    (%rax,%rax,2),%r10
    bb00:	4c 89 f2             	mov    %r14,%rdx
    bb03:	4c 29 d2             	sub    %r10,%rdx
    bb06:	49 f7 da             	neg    %r10
    bb09:	4d 01 f2             	add    %r14,%r10
    bb0c:	49 83 c2 03          	add    $0x3,%r10
    bb10:	48 83 fa fd          	cmp    $0xfffffffffffffffd,%rdx
    bb14:	4c 0f 42 d2          	cmovb  %rdx,%r10
    bb18:	4d 85 d2             	test   %r10,%r10
    bb1b:	74 a3                	je     bac0 <fwp_trits+0x50>
    bb1d:	49 83 fa 01          	cmp    $0x1,%r10
    bb21:	75 0d                	jne    bb30 <fwp_trits+0xc0>
    bb23:	41 b3 2b             	mov    $0x2b,%r11b
    bb26:	45 31 d2             	xor    %r10d,%r10d
    bb29:	eb 98                	jmp    bac3 <fwp_trits+0x53>
    bb2b:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)
    bb30:	41 b3 2d             	mov    $0x2d,%r11b
    bb33:	41 ba 01 00 00 00    	mov    $0x1,%r10d
    bb39:	eb 88                	jmp    bac3 <fwp_trits+0x53>
    bb3b:	42 c6 44 3e 02 00    	movb   $0x0,0x2(%rsi,%r15,1)
    bb41:	48 89 df             	mov    %rbx,%rdi
    bb44:	48 83 c4 08          	add    $0x8,%rsp
    bb48:	5b                   	pop    %rbx
    bb49:	41 5e                	pop    %r14
    bb4b:	41 5f                	pop    %r15
    bb4d:	5d                   	pop    %rbp
    bb4e:	e9 bd bd ff ff       	jmp    7910 <buf_puts>
    bb53:	66 66 66 66 2e 0f 1f 	data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    bb5a:	84 00 00 00 00 00 

000000000000bb60 <fwp_escape>:
    bb60:	55                   	push   %rbp
    bb61:	41 57                	push   %r15
    bb63:	41 56                	push   %r14
    bb65:	41 55                	push   %r13
    bb67:	41 54                	push   %r12
    bb69:	53                   	push   %rbx
    bb6a:	48 83 ec 18          	sub    $0x18,%rsp
    bb6e:	48 89 d3             	mov    %rdx,%rbx
    bb71:	49 89 f7             	mov    %rsi,%r15
    bb74:	49 89 fe             	mov    %rdi,%r14
    bb77:	be 22 00 00 00       	mov    $0x22,%esi
    bb7c:	e8 6f bd ff ff       	call   78f0 <buf_putc>
    bb81:	48 85 db             	test   %rbx,%rbx
    bb84:	0f 84 c7 00 00 00    	je     bc51 <fwp_escape+0xf1>
    bb8a:	48 89 e5             	mov    %rsp,%rbp
    bb8d:	4c 8d 2d 18 18 00 00 	lea    0x1818(%rip),%r13        # d3ac <_IO_stdin_used+0x3ac>
    bb94:	45 31 e4             	xor    %r12d,%r12d
    bb97:	eb 28                	jmp    bbc1 <fwp_escape+0x61>
    bb99:	4c 89 f7             	mov    %r14,%rdi
    bb9c:	48 8d 35 d3 27 00 00 	lea    0x27d3(%rip),%rsi        # e376 <exec_in_fp0+0xd36>
    bba3:	66 66 66 66 2e 0f 1f 	data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    bbaa:	84 00 00 00 00 00 
    bbb0:	e8 5b bd ff ff       	call   7910 <buf_puts>
    bbb5:	49 ff c4             	inc    %r12
    bbb8:	4c 39 e3             	cmp    %r12,%rbx
    bbbb:	0f 84 90 00 00 00    	je     bc51 <fwp_escape+0xf1>
    bbc1:	43 0f b6 0c 27       	movzbl (%r15,%r12,1),%ecx
    bbc6:	8d 41 f7             	lea    -0x9(%rcx),%eax
    bbc9:	83 f8 19             	cmp    $0x19,%eax
    bbcc:	77 22                	ja     bbf0 <fwp_escape+0x90>
    bbce:	49 63 44 85 00       	movslq 0x0(%r13,%rax,4),%rax
    bbd3:	4c 01 e8             	add    %r13,%rax
    bbd6:	ff e0                	jmp    *%rax
    bbd8:	4c 89 f7             	mov    %r14,%rdi
    bbdb:	48 8d 35 91 27 00 00 	lea    0x2791(%rip),%rsi        # e373 <exec_in_fp0+0xd33>
    bbe2:	eb cc                	jmp    bbb0 <fwp_escape+0x50>
    bbe4:	66 66 66 2e 0f 1f 84 	data16 data16 cs nopw 0x0(%rax,%rax,1)
    bbeb:	00 00 00 00 00 
    bbf0:	83 f9 5c             	cmp    $0x5c,%ecx
    bbf3:	75 0c                	jne    bc01 <fwp_escape+0xa1>
    bbf5:	4c 89 f7             	mov    %r14,%rdi
    bbf8:	48 8d 35 6e 27 00 00 	lea    0x276e(%rip),%rsi        # e36d <exec_in_fp0+0xd2d>
    bbff:	eb af                	jmp    bbb0 <fwp_escape+0x50>
    bc01:	80 f9 20             	cmp    $0x20,%cl
    bc04:	72 2a                	jb     bc30 <fwp_escape+0xd0>
    bc06:	80 f9 7f             	cmp    $0x7f,%cl
    bc09:	74 25                	je     bc30 <fwp_escape+0xd0>
    bc0b:	0f be f1             	movsbl %cl,%esi
    bc0e:	4c 89 f7             	mov    %r14,%rdi
    bc11:	e8 da bc ff ff       	call   78f0 <buf_putc>
    bc16:	eb 9d                	jmp    bbb5 <fwp_escape+0x55>
    bc18:	4c 89 f7             	mov    %r14,%rdi
    bc1b:	48 8d 35 48 27 00 00 	lea    0x2748(%rip),%rsi        # e36a <exec_in_fp0+0xd2a>
    bc22:	eb 8c                	jmp    bbb0 <fwp_escape+0x50>
    bc24:	4c 89 f7             	mov    %r14,%rdi
    bc27:	48 8d 35 42 27 00 00 	lea    0x2742(%rip),%rsi        # e370 <exec_in_fp0+0xd30>
    bc2e:	eb 80                	jmp    bbb0 <fwp_escape+0x50>
    bc30:	be 10 00 00 00       	mov    $0x10,%esi
    bc35:	48 89 ef             	mov    %rbp,%rdi
    bc38:	48 8d 15 3a 27 00 00 	lea    0x273a(%rip),%rdx        # e379 <exec_in_fp0+0xd39>
    bc3f:	31 c0                	xor    %eax,%eax
    bc41:	e8 8a 65 ff ff       	call   21d0 <snprintf@plt>
    bc46:	4c 89 f7             	mov    %r14,%rdi
    bc49:	48 89 ee             	mov    %rbp,%rsi
    bc4c:	e9 5f ff ff ff       	jmp    bbb0 <fwp_escape+0x50>
    bc51:	4c 89 f7             	mov    %r14,%rdi
    bc54:	be 22 00 00 00       	mov    $0x22,%esi
    bc59:	48 83 c4 18          	add    $0x18,%rsp
    bc5d:	5b                   	pop    %rbx
    bc5e:	41 5c                	pop    %r12
    bc60:	41 5d                	pop    %r13
    bc62:	41 5e                	pop    %r14
    bc64:	41 5f                	pop    %r15
    bc66:	5d                   	pop    %rbp
    bc67:	e9 84 bc ff ff       	jmp    78f0 <buf_putc>
    bc6c:	0f 1f 40 00          	nopl   0x0(%rax)

000000000000bc70 <fwp_fmt_duration>:
    bc70:	41 57                	push   %r15
    bc72:	41 56                	push   %r14
    bc74:	41 54                	push   %r12
    bc76:	53                   	push   %rbx
    bc77:	48 83 ec 48          	sub    $0x48,%rsp
    bc7b:	49 89 d0             	mov    %rdx,%r8
    bc7e:	48 89 fb             	mov    %rdi,%rbx
    bc81:	48 89 f0             	mov    %rsi,%rax
    bc84:	48 09 d0             	or     %rdx,%rax
    bc87:	0f 84 1b 02 00 00    	je     bea8 <fwp_fmt_duration+0x238>
    bc8d:	48 b9 1d 3f c2 25 d6 	movabs $0xd2fe1d625c23f1d,%rcx
    bc94:	e1 2f 0d 
    bc97:	48 bf 0d b1 f3 e4 99 	movabs $0x1c52799e4f3b10d,%rdi
    bc9e:	27 c5 01 
    bca1:	48 89 f0             	mov    %rsi,%rax
    bca4:	48 f7 e7             	mul    %rdi
    bca7:	48 0f af ce          	imul   %rsi,%rcx
    bcab:	48 01 ca             	add    %rcx,%rdx
    bcae:	49 0f af f8          	imul   %r8,%rdi
    bcb2:	48 01 d7             	add    %rdx,%rdi
    bcb5:	48 b9 00 a0 34 52 a3 	movabs $0x6baf6aa35234a000,%rcx
    bcbc:	6a af 6b 
    bcbf:	48 01 c1             	add    %rax,%rcx
    bcc2:	48 b8 37 f9 ff e2 04 	movabs $0x4e2fff937,%rax
    bcc9:	00 00 00 
    bccc:	48 11 f8             	adc    %rdi,%rax
    bccf:	48 89 c2             	mov    %rax,%rdx
    bcd2:	48 0f ac ca 0d       	shrd   $0xd,%rcx,%rdx
    bcd7:	48 0f a4 c8 33       	shld   $0x33,%rcx,%rax
    bcdc:	48 b9 4b 23 35 aa f6 	movabs $0x9376baf6aa35234b,%rcx
    bce3:	ba 76 93 
    bce6:	48 39 c8             	cmp    %rcx,%rax
    bce9:	48 81 da ff 2f 4e 00 	sbb    $0x4e2fff,%rdx
    bcf0:	0f 82 d9 01 00 00    	jb     becf <fwp_fmt_duration+0x25f>
    bcf6:	48 b9 b3 b2 61 36 8c 	movabs $0xc5ce3b8c3661b2b3,%rcx
    bcfd:	3b ce c5 
    bd00:	48 bf c3 5f 47 6a 04 	movabs $0x1a8d52046a475fc3,%rdi
    bd07:	52 8d 1a 
    bd0a:	48 89 f0             	mov    %rsi,%rax
    bd0d:	48 f7 e7             	mul    %rdi
    bd10:	48 0f af ce          	imul   %rsi,%rcx
    bd14:	48 01 ca             	add    %rcx,%rdx
    bd17:	49 0f af f8          	imul   %r8,%rdi
    bd1b:	48 01 d7             	add    %rdx,%rdi
    bd1e:	48 b9 00 a8 16 d1 91 	movabs $0x4f473f91d116a800,%rcx
    bd25:	3f 47 4f 
    bd28:	48 01 c1             	add    %rax,%rcx
    bd2b:	48 b8 3f 9a ff 4c 49 	movabs $0x494cff9a3f,%rax
    bd32:	00 00 00 
    bd35:	48 11 f8             	adc    %rdi,%rax
    bd38:	48 89 c2             	mov    %rax,%rdx
    bd3b:	48 0f ac ca 0b       	shrd   $0xb,%rcx,%rdx
    bd40:	48 0f a4 c8 35       	shld   $0x35,%rcx,%rax
    bd45:	48 b9 ab 45 74 e4 cf 	movabs $0x8fd3d1cfe47445ab,%rcx
    bd4c:	d1 d3 8f 
    bd4f:	48 39 c8             	cmp    %rcx,%rax
    bd52:	48 81 da e6 3f 53 12 	sbb    $0x12533fe6,%rdx
    bd59:	0f 82 7f 01 00 00    	jb     bede <fwp_fmt_duration+0x26e>
    bd5f:	48 b9 7e 78 b9 2f 37 	movabs $0x97157d372fb9787e,%rcx
    bd66:	7d 15 97 
    bd69:	48 0f af ce          	imul   %rsi,%rcx
    bd6d:	48 bf 6d 9c 2e 3a 42 	movabs $0x8e47ce423a2e9c6d,%rdi
    bd74:	ce 47 8e 
    bd77:	48 89 f0             	mov    %rsi,%rax
    bd7a:	48 f7 e7             	mul    %rdi
    bd7d:	48 01 ca             	add    %rcx,%rdx
    bd80:	49 0f af f8          	imul   %r8,%rdi
    bd84:	48 01 d7             	add    %rdx,%rdi
    bd87:	48 b9 00 46 54 40 8b 	movabs $0xa52cb98b40544600,%rcx
    bd8e:	b9 2c a5 
    bd91:	48 01 c1             	add    %rax,%rcx
    bd94:	48 b8 b5 09 fa 82 4b 	movabs $0x44b82fa09b5,%rax
    bd9b:	04 00 00 
    bd9e:	48 11 f8             	adc    %rdi,%rax
    bda1:	48 89 c2             	mov    %rax,%rdx
    bda4:	48 0f ac ca 09       	shrd   $0x9,%rcx,%rdx
    bda9:	48 0f a4 c8 37       	shld   $0x37,%rcx,%rax
    bdae:	48 b9 47 54 40 8b b9 	movabs $0xb5a52cb98b405447,%rcx
    bdb5:	2c a5 b5 
    bdb8:	48 39 c8             	cmp    %rcx,%rax
    bdbb:	48 b8 09 fa 82 4b 04 	movabs $0x44b82fa09,%rax
    bdc2:	00 00 00 
    bdc5:	48 19 c2             	sbb    %rax,%rdx
    bdc8:	0f 82 22 01 00 00    	jb     bef0 <fwp_fmt_duration+0x280>
    bdce:	48 b9 cb d5 8f 4d f2 	movabs $0xc57e23f24d8fd5cb,%rcx
    bdd5:	23 7e c5 
    bdd8:	48 0f af ce          	imul   %rsi,%rcx
    bddc:	48 bf 39 61 c2 68 56 	movabs $0x790fb65668c26139,%rdi
    bde3:	b6 0f 79 
    bde6:	48 89 f0             	mov    %rsi,%rax
    bde9:	48 f7 e7             	mul    %rdi
    bdec:	48 01 ca             	add    %rcx,%rdx
    bdef:	49 0f af f8          	imul   %r8,%rdi
    bdf3:	48 01 d7             	add    %rdx,%rdi
    bdf6:	48 b9 00 0b 27 69 fe 	movabs $0xa6d698fe69270b00,%rcx
    bdfd:	98 d6 a6 
    be00:	48 01 c1             	add    %rax,%rcx
    be03:	48 b8 b1 bd 16 f4 de 	movabs $0x218def416bdb1,%rax
    be0a:	18 02 00 
    be0d:	48 11 f8             	adc    %rdi,%rax
    be10:	48 89 c2             	mov    %rax,%rdx
    be13:	48 0f ac ca 06       	shrd   $0x6,%rcx,%rdx
    be18:	48 0f a4 c8 3a       	shld   $0x3a,%rcx,%rax
    be1d:	48 b9 59 38 49 f3 c7 	movabs $0x8d36b4c7f3493859,%rcx
    be24:	b4 36 8d 
    be27:	48 39 c8             	cmp    %rcx,%rax
    be2a:	48 b8 ed b5 a0 f7 c6 	movabs $0x10c6f7a0b5ed,%rax
    be31:	10 00 00 
    be34:	48 19 c2             	sbb    %rax,%rdx
    be37:	0f 82 c0 00 00 00    	jb     befd <fwp_fmt_duration+0x28d>
    be3d:	48 b9 5a 64 3b df 4f 	movabs $0x6e978d4fdf3b645a,%rcx
    be44:	8d 97 6e 
    be47:	48 0f af ce          	imul   %rsi,%rcx
    be4b:	48 bf d5 78 e9 26 31 	movabs $0x1cac083126e978d5,%rdi
    be52:	08 ac 1c 
    be55:	48 89 f0             	mov    %rsi,%rax
    be58:	48 f7 e7             	mul    %rdi
    be5b:	48 01 ca             	add    %rcx,%rdx
    be5e:	49 0f af f8          	imul   %r8,%rdi
    be62:	48 01 d7             	add    %rdx,%rdi
    be65:	48 b9 48 62 10 58 39 	movabs $0x76c8b43958106248,%rcx
    be6c:	b4 c8 76 
    be6f:	48 01 c1             	add    %rax,%rcx
    be72:	48 b8 be 9f 1a 2f dd 	movabs $0x10624dd2f1a9fbe,%rax
    be79:	24 06 01 
    be7c:	48 11 f8             	adc    %rdi,%rax
    be7f:	48 89 c2             	mov    %rax,%rdx
    be82:	48 0f ac ca 03       	shrd   $0x3,%rcx,%rdx
    be87:	48 0f a4 c8 3d       	shld   $0x3d,%rcx,%rax
    be8c:	48 b9 93 18 04 56 0e 	movabs $0x9db22d0e56041893,%rcx
    be93:	2d b2 9d 
    be96:	48 39 c8             	cmp    %rcx,%rax
    be99:	48 b8 ef a7 c6 4b 37 	movabs $0x4189374bc6a7ef,%rax
    bea0:	89 41 00 
    bea3:	48 19 c2             	sbb    %rax,%rdx
    bea6:	72 62                	jb     bf0a <fwp_fmt_duration+0x29a>
    bea8:	49 89 e6             	mov    %rsp,%r14
    beab:	4c 89 f7             	mov    %r14,%rdi
    beae:	4c 89 c2             	mov    %r8,%rdx
    beb1:	e8 ca f6 ff ff       	call   b580 <fwp_fmt_i128>
    beb6:	48 8d 35 c8 24 00 00 	lea    0x24c8(%rip),%rsi        # e385 <exec_in_fp0+0xd45>
    bebd:	48 89 df             	mov    %rbx,%rdi
    bec0:	4c 89 f2             	mov    %r14,%rdx
    bec3:	31 c0                	xor    %eax,%eax
    bec5:	e8 a6 65 ff ff       	call   2470 <sprintf@plt>
    beca:	e9 84 00 00 00       	jmp    bf53 <fwp_fmt_duration+0x2e3>
    becf:	48 ba 00 a0 b8 30 46 	movabs $0x34630b8a000,%rdx
    bed6:	03 00 00 
    bed9:	45 31 ff             	xor    %r15d,%r15d
    bedc:	eb 37                	jmp    bf15 <fwp_fmt_duration+0x2a5>
    bede:	48 ba 00 58 47 f8 0d 	movabs $0xdf8475800,%rdx
    bee5:	00 00 00 
    bee8:	41 bf 01 00 00 00    	mov    $0x1,%r15d
    beee:	eb 25                	jmp    bf15 <fwp_fmt_duration+0x2a5>
    bef0:	ba 00 ca 9a 3b       	mov    $0x3b9aca00,%edx
    bef5:	41 bf 02 00 00 00    	mov    $0x2,%r15d
    befb:	eb 18                	jmp    bf15 <fwp_fmt_duration+0x2a5>
    befd:	ba 40 42 0f 00       	mov    $0xf4240,%edx
    bf02:	41 bf 03 00 00 00    	mov    $0x3,%r15d
    bf08:	eb 0b                	jmp    bf15 <fwp_fmt_duration+0x2a5>
    bf0a:	ba e8 03 00 00       	mov    $0x3e8,%edx
    bf0f:	41 bf 04 00 00 00    	mov    $0x4,%r15d
    bf15:	31 c9                	xor    %ecx,%ecx
    bf17:	41 c1 e7 04          	shl    $0x4,%r15d
    bf1b:	4c 8d 25 3e 6e 00 00 	lea    0x6e3e(%rip),%r12        # 12d60 <fwp_fmt_duration.units>
    bf22:	48 89 f7             	mov    %rsi,%rdi
    bf25:	4c 89 c6             	mov    %r8,%rsi
    bf28:	e8 13 0e 00 00       	call   cd40 <__divti3>
    bf2d:	49 89 e6             	mov    %rsp,%r14
    bf30:	4c 89 f7             	mov    %r14,%rdi
    bf33:	48 89 c6             	mov    %rax,%rsi
    bf36:	e8 45 f6 ff ff       	call   b580 <fwp_fmt_i128>
    bf3b:	4b 8b 0c 27          	mov    (%r15,%r12,1),%rcx
    bf3f:	48 8d 35 3a 24 00 00 	lea    0x243a(%rip),%rsi        # e380 <exec_in_fp0+0xd40>
    bf46:	48 89 df             	mov    %rbx,%rdi
    bf49:	4c 89 f2             	mov    %r14,%rdx
    bf4c:	31 c0                	xor    %eax,%eax
    bf4e:	e8 1d 65 ff ff       	call   2470 <sprintf@plt>
    bf53:	48 83 c4 48          	add    $0x48,%rsp
    bf57:	5b                   	pop    %rbx
    bf58:	41 5c                	pop    %r12
    bf5a:	41 5e                	pop    %r14
    bf5c:	41 5f                	pop    %r15
    bf5e:	c3                   	ret
    bf5f:	90                   	nop

000000000000bf60 <fwp_needs_parens>:
    bf60:	8b 06                	mov    (%rsi),%eax
    bf62:	83 f8 10             	cmp    $0x10,%eax
    bf65:	74 16                	je     bf7d <fwp_needs_parens+0x1d>
    bf67:	83 f8 0e             	cmp    $0xe,%eax
    bf6a:	0f 85 30 02 00 00    	jne    c1a0 <fwp_is_negative>
    bf70:	31 c0                	xor    %eax,%eax
    bf72:	48 81 ff 00 10 00 00 	cmp    $0x1000,%rdi
    bf79:	0f 93 c0             	setae  %al
    bf7c:	c3                   	ret
    bf7d:	48 8b 46 08          	mov    0x8(%rsi),%rax
    bf81:	48 85 c0             	test   %rax,%rax
    bf84:	0f 84 16 02 00 00    	je     c1a0 <fwp_is_negative>
    bf8a:	50                   	push   %rax
    bf8b:	48 8d 35 e6 22 00 00 	lea    0x22e6(%rip),%rsi        # e278 <exec_in_fp0+0xc38>
    bf92:	48 89 c7             	mov    %rax,%rdi
    bf95:	e8 36 63 ff ff       	call   22d0 <strcmp@plt>
    bf9a:	89 c1                	mov    %eax,%ecx
    bf9c:	31 c0                	xor    %eax,%eax
    bf9e:	85 c9                	test   %ecx,%ecx
    bfa0:	0f 95 c0             	setne  %al
    bfa3:	48 83 c4 08          	add    $0x8,%rsp
    bfa7:	c3                   	ret
    bfa8:	0f 1f 84 00 00 00 00 	nopl   0x0(%rax,%rax,1)
    bfaf:	00 

000000000000bfb0 <fwp_format_g>:
    bfb0:	55                   	push   %rbp
    bfb1:	41 57                	push   %r15
    bfb3:	41 56                	push   %r14
    bfb5:	41 55                	push   %r13
    bfb7:	41 54                	push   %r12
    bfb9:	53                   	push   %rbx
    bfba:	48 81 ec 98 00 00 00 	sub    $0x98,%rsp
    bfc1:	89 f5                	mov    %esi,%ebp
    bfc3:	48 89 fb             	mov    %rdi,%rbx
    bfc6:	ff cd                	dec    %ebp
    bfc8:	48 8d 15 84 23 00 00 	lea    0x2384(%rip),%rdx        # e353 <exec_in_fp0+0xd13>
    bfcf:	4c 8d 64 24 50       	lea    0x50(%rsp),%r12
    bfd4:	be 40 00 00 00       	mov    $0x40,%esi
    bfd9:	4c 89 e7             	mov    %r12,%rdi
    bfdc:	89 e9                	mov    %ebp,%ecx
    bfde:	f2 0f 11 44 24 08    	movsd  %xmm0,0x8(%rsp)
    bfe4:	b0 01                	mov    $0x1,%al
    bfe6:	e8 e5 61 ff ff       	call   21d0 <snprintf@plt>
    bfeb:	4c 89 e7             	mov    %r12,%rdi
    bfee:	be 65 00 00 00       	mov    $0x65,%esi
    bff3:	e8 b8 61 ff ff       	call   21b0 <strchr@plt>
    bff8:	49 89 c7             	mov    %rax,%r15
    bffb:	48 8d 78 01          	lea    0x1(%rax),%rdi
    bfff:	e8 5c 64 ff ff       	call   2460 <atoi@plt>
    c004:	41 89 c6             	mov    %eax,%r14d
    c007:	41 8d 46 ef          	lea    -0x11(%r14),%eax
    c00b:	83 f8 e9             	cmp    $0xffffffe9,%eax
    c00e:	77 58                	ja     c068 <fwp_format_g+0xb8>
    c010:	4d 29 e7             	sub    %r12,%r15
    c013:	4c 8d 6c 24 10       	lea    0x10(%rsp),%r13
    c018:	4c 89 ef             	mov    %r13,%rdi
    c01b:	4c 89 e6             	mov    %r12,%rsi
    c01e:	4c 89 fa             	mov    %r15,%rdx
    c021:	e8 0a 63 ff ff       	call   2330 <memcpy@plt>
    c026:	42 c6 44 3c 10 00    	movb   $0x0,0x10(%rsp,%r15,1)
    c02c:	4c 89 ef             	mov    %r13,%rdi
    c02f:	be 2e 00 00 00       	mov    $0x2e,%esi
    c034:	e8 77 61 ff ff       	call   21b0 <strchr@plt>
    c039:	48 85 c0             	test   %rax,%rax
    c03c:	0f 84 91 00 00 00    	je     c0d3 <fwp_format_g+0x123>
    c042:	4d 85 ff             	test   %r15,%r15
    c045:	0f 84 88 00 00 00    	je     c0d3 <fwp_format_g+0x123>
    c04b:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)
    c050:	42 0f b6 44 3c 0f    	movzbl 0xf(%rsp,%r15,1),%eax
    c056:	83 f8 30             	cmp    $0x30,%eax
    c059:	75 6d                	jne    c0c8 <fwp_format_g+0x118>
    c05b:	42 c6 44 3c 0f 00    	movb   $0x0,0xf(%rsp,%r15,1)
    c061:	49 ff cf             	dec    %r15
    c064:	75 ea                	jne    c050 <fwp_format_g+0xa0>
    c066:	eb 6b                	jmp    c0d3 <fwp_format_g+0x123>
    c068:	44 29 f5             	sub    %r14d,%ebp
    c06b:	31 c9                	xor    %ecx,%ecx
    c06d:	85 ed                	test   %ebp,%ebp
    c06f:	0f 4f cd             	cmovg  %ebp,%ecx
    c072:	48 8d 15 e9 22 00 00 	lea    0x22e9(%rip),%rdx        # e362 <exec_in_fp0+0xd22>
    c079:	be 90 01 00 00       	mov    $0x190,%esi
    c07e:	48 89 df             	mov    %rbx,%rdi
    c081:	f2 0f 10 44 24 08    	movsd  0x8(%rsp),%xmm0
    c087:	b0 01                	mov    $0x1,%al
    c089:	e8 42 61 ff ff       	call   21d0 <snprintf@plt>
    c08e:	48 89 df             	mov    %rbx,%rdi
    c091:	e8 da 60 ff ff       	call   2170 <strlen@plt>
    c096:	49 89 c6             	mov    %rax,%r14
    c099:	48 89 df             	mov    %rbx,%rdi
    c09c:	be 2e 00 00 00       	mov    $0x2e,%esi
    c0a1:	e8 0a 61 ff ff       	call   21b0 <strchr@plt>
    c0a6:	48 85 c0             	test   %rax,%rax
    c0a9:	74 5b                	je     c106 <fwp_format_g+0x156>
    c0ab:	4d 85 f6             	test   %r14,%r14
    c0ae:	74 56                	je     c106 <fwp_format_g+0x156>
    c0b0:	42 0f b6 44 33 ff    	movzbl -0x1(%rbx,%r14,1),%eax
    c0b6:	83 f8 30             	cmp    $0x30,%eax
    c0b9:	75 5d                	jne    c118 <fwp_format_g+0x168>
    c0bb:	42 c6 44 33 ff 00    	movb   $0x0,-0x1(%rbx,%r14,1)
    c0c1:	49 ff ce             	dec    %r14
    c0c4:	75 ea                	jne    c0b0 <fwp_format_g+0x100>
    c0c6:	eb 3e                	jmp    c106 <fwp_format_g+0x156>
    c0c8:	83 f8 2e             	cmp    $0x2e,%eax
    c0cb:	75 06                	jne    c0d3 <fwp_format_g+0x123>
    c0cd:	42 c6 44 3c 0f 00    	movb   $0x0,0xf(%rsp,%r15,1)
    c0d3:	44 89 f0             	mov    %r14d,%eax
    c0d6:	c1 e8 1f             	shr    $0x1f,%eax
    c0d9:	44 8d 04 45 2b 00 00 	lea    0x2b(,%rax,2),%r8d
    c0e0:	00 
    c0e1:	45 89 f1             	mov    %r14d,%r9d
    c0e4:	41 f7 d9             	neg    %r9d
    c0e7:	45 0f 48 ce          	cmovs  %r14d,%r9d
    c0eb:	48 8d 15 66 22 00 00 	lea    0x2266(%rip),%rdx        # e358 <exec_in_fp0+0xd18>
    c0f2:	48 8d 4c 24 10       	lea    0x10(%rsp),%rcx
    c0f7:	be 90 01 00 00       	mov    $0x190,%esi
    c0fc:	48 89 df             	mov    %rbx,%rdi
    c0ff:	31 c0                	xor    %eax,%eax
    c101:	e8 ca 60 ff ff       	call   21d0 <snprintf@plt>
    c106:	48 81 c4 98 00 00 00 	add    $0x98,%rsp
    c10d:	5b                   	pop    %rbx
    c10e:	41 5c                	pop    %r12
    c110:	41 5d                	pop    %r13
    c112:	41 5e                	pop    %r14
    c114:	41 5f                	pop    %r15
    c116:	5d                   	pop    %rbp
    c117:	c3                   	ret
    c118:	83 f8 2e             	cmp    $0x2e,%eax
    c11b:	75 e9                	jne    c106 <fwp_format_g+0x156>
    c11d:	42 c6 44 33 ff 00    	movb   $0x0,-0x1(%rbx,%r14,1)
    c123:	eb e1                	jmp    c106 <fwp_format_g+0x156>
    c125:	66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
    c12c:	00 00 00 00 

000000000000c130 <fwp_finish_float>:
    c130:	53                   	push   %rbx
    c131:	48 89 fb             	mov    %rdi,%rbx
    c134:	be 2e 00 00 00       	mov    $0x2e,%esi
    c139:	e8 72 60 ff ff       	call   21b0 <strchr@plt>
    c13e:	48 85 c0             	test   %rax,%rax
    c141:	74 02                	je     c145 <fwp_finish_float+0x15>
    c143:	5b                   	pop    %rbx
    c144:	c3                   	ret
    c145:	48 89 df             	mov    %rbx,%rdi
    c148:	be 65 00 00 00       	mov    $0x65,%esi
    c14d:	e8 5e 60 ff ff       	call   21b0 <strchr@plt>
    c152:	48 85 c0             	test   %rax,%rax
    c155:	75 ec                	jne    c143 <fwp_finish_float+0x13>
    c157:	48 8d 35 35 21 00 00 	lea    0x2135(%rip),%rsi        # e293 <exec_in_fp0+0xc53>
    c15e:	48 89 df             	mov    %rbx,%rdi
    c161:	e8 8a 63 ff ff       	call   24f0 <strstr@plt>
    c166:	48 85 c0             	test   %rax,%rax
    c169:	75 d8                	jne    c143 <fwp_finish_float+0x13>
    c16b:	48 8d 35 25 21 00 00 	lea    0x2125(%rip),%rsi        # e297 <exec_in_fp0+0xc57>
    c172:	48 89 df             	mov    %rbx,%rdi
    c175:	e8 76 63 ff ff       	call   24f0 <strstr@plt>
    c17a:	48 85 c0             	test   %rax,%rax
    c17d:	75 c4                	jne    c143 <fwp_finish_float+0x13>
    c17f:	48 89 df             	mov    %rbx,%rdi
    c182:	e8 e9 5f ff ff       	call   2170 <strlen@plt>
    c187:	66 c7 04 03 2e 30    	movw   $0x302e,(%rbx,%rax,1)
    c18d:	c6 44 03 02 00       	movb   $0x0,0x2(%rbx,%rax,1)
    c192:	5b                   	pop    %rbx
    c193:	c3                   	ret
    c194:	66 66 66 2e 0f 1f 84 	data16 data16 cs nopw 0x0(%rax,%rax,1)
    c19b:	00 00 00 00 00 

000000000000c1a0 <fwp_is_negative>:
    c1a0:	50                   	push   %rax
    c1a1:	8b 0e                	mov    (%rsi),%ecx
    c1a3:	31 c0                	xor    %eax,%eax
    c1a5:	48 83 f9 0b          	cmp    $0xb,%rcx
    c1a9:	77 16                	ja     c1c1 <fwp_is_negative+0x21>
    c1ab:	48 8d 15 62 12 00 00 	lea    0x1262(%rip),%rdx        # d414 <_IO_stdin_used+0x414>
    c1b2:	48 63 0c 8a          	movslq (%rdx,%rcx,4),%rcx
    c1b6:	48 01 d1             	add    %rdx,%rcx
    c1b9:	ff e1                	jmp    *%rcx
    c1bb:	48 c1 ef 3f          	shr    $0x3f,%rdi
    c1bf:	89 f8                	mov    %edi,%eax
    c1c1:	59                   	pop    %rcx
    c1c2:	c3                   	ret
    c1c3:	e8 68 8c ff ff       	call   4e30 <fwp_f32>
    c1c8:	0f 50 c0             	movmskps %xmm0,%eax
    c1cb:	eb 09                	jmp    c1d6 <fwp_is_negative+0x36>
    c1cd:	e8 ce 6c ff ff       	call   2ea0 <fwp_f64>
    c1d2:	66 0f 50 c0          	movmskpd %xmm0,%eax
    c1d6:	83 e0 01             	and    $0x1,%eax
    c1d9:	59                   	pop    %rcx
    c1da:	c3                   	ret
    c1db:	e8 d0 dd ff ff       	call   9fb0 <fwp_i128>
    c1e0:	48 89 d0             	mov    %rdx,%rax
    c1e3:	48 c1 e8 3f          	shr    $0x3f,%rax
    c1e7:	59                   	pop    %rcx
    c1e8:	c3                   	ret
    c1e9:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)

000000000000c1f0 <fwp_emit>:
    c1f0:	53                   	push   %rbx
    c1f1:	48 83 ec 30          	sub    $0x30,%rsp
    c1f5:	48 89 f8             	mov    %rdi,%rax
    c1f8:	83 3d c1 8b 01 00 00 	cmpl   $0x0,0x18bc1(%rip)        # 24dc0 <fwp_exec_binary_out>
    c1ff:	74 66                	je     c267 <fwp_emit+0x77>
    c201:	0f 57 c0             	xorps  %xmm0,%xmm0
    c204:	0f 29 44 24 10       	movaps %xmm0,0x10(%rsp)
    c209:	48 c7 44 24 20 00 00 	movq   $0x0,0x20(%rsp)
    c210:	00 00 
    c212:	48 8d 15 b7 8a 00 00 	lea    0x8ab7(%rip),%rdx        # 14cd0 <d0>
    c219:	48 8d 7c 24 10       	lea    0x10(%rsp),%rdi
    c21e:	48 89 c6             	mov    %rax,%rsi
    c221:	e8 9a 00 00 00       	call   c2c0 <fwp_encode>
    c226:	c6 44 24 0b 01       	movb   $0x1,0xb(%rsp)
    c22b:	8b 44 24 18          	mov    0x18(%rsp),%eax
    c22f:	89 44 24 0c          	mov    %eax,0xc(%rsp)
    c233:	48 8d 7c 24 0b       	lea    0xb(%rsp),%rdi
    c238:	be 05 00 00 00       	mov    $0x5,%esi
    c23d:	e8 2e a8 ff ff       	call   6a70 <fwp_pipe_write>
    c242:	48 8b 74 24 18       	mov    0x18(%rsp),%rsi
    c247:	48 85 f6             	test   %rsi,%rsi
    c24a:	74 0a                	je     c256 <fwp_emit+0x66>
    c24c:	48 8b 7c 24 10       	mov    0x10(%rsp),%rdi
    c251:	e8 1a a8 ff ff       	call   6a70 <fwp_pipe_write>
    c256:	48 8b 7c 24 10       	mov    0x10(%rsp),%rdi
    c25b:	e8 f0 5d ff ff       	call   2050 <free@plt>
    c260:	e8 9b 02 00 00       	call   c500 <fwp_pipe_frame_done>
    c265:	eb 1c                	jmp    c283 <fwp_emit+0x93>
    c267:	83 3d 62 8a 00 00 10 	cmpl   $0x10,0x8a62(%rip)        # 14cd0 <d0>
    c26e:	75 19                	jne    c289 <fwp_emit+0x99>
    c270:	83 3d 69 8a 00 00 00 	cmpl   $0x0,0x8a69(%rip)        # 14ce0 <d0+0x10>
    c277:	75 10                	jne    c289 <fwp_emit+0x99>
    c279:	48 83 3d 57 8a 00 00 	cmpq   $0x0,0x8a57(%rip)        # 14cd8 <d0+0x8>
    c280:	00 
    c281:	75 06                	jne    c289 <fwp_emit+0x99>
    c283:	48 83 c4 30          	add    $0x30,%rsp
    c287:	5b                   	pop    %rbx
    c288:	c3                   	ret
    c289:	48 8b 1d 20 6d 00 00 	mov    0x6d20(%rip),%rbx        # 12fb0 <stdout@GLIBC_2.2.5>
    c290:	48 8b 13             	mov    (%rbx),%rdx
    c293:	48 8d 35 36 8a 00 00 	lea    0x8a36(%rip),%rsi        # 14cd0 <d0>
    c29a:	48 89 c7             	mov    %rax,%rdi
    c29d:	e8 6e eb ff ff       	call   ae10 <fwp_display_top>
    c2a2:	48 8b 33             	mov    (%rbx),%rsi
    c2a5:	bf 0a 00 00 00       	mov    $0xa,%edi
    c2aa:	48 83 c4 30          	add    $0x30,%rsp
    c2ae:	5b                   	pop    %rbx
    c2af:	e9 8c 5f ff ff       	jmp    2240 <fputc@plt>
    c2b4:	66 66 66 2e 0f 1f 84 	data16 data16 cs nopw 0x0(%rax,%rax,1)
    c2bb:	00 00 00 00 00 

000000000000c2c0 <fwp_encode>:
    c2c0:	41 57                	push   %r15
    c2c2:	41 56                	push   %r14
    c2c4:	41 55                	push   %r13
    c2c6:	41 54                	push   %r12
    c2c8:	53                   	push   %rbx
    c2c9:	8b 02                	mov    (%rdx),%eax
    c2cb:	48 83 f8 15          	cmp    $0x15,%rax
    c2cf:	0f 87 14 02 00 00    	ja     c4e9 <fwp_encode+0x229>
    c2d5:	49 89 d7             	mov    %rdx,%r15
    c2d8:	49 89 f6             	mov    %rsi,%r14
    c2db:	48 89 fb             	mov    %rdi,%rbx
    c2de:	48 8d 0d 5f 11 00 00 	lea    0x115f(%rip),%rcx        # d444 <_IO_stdin_used+0x444>
    c2e5:	48 63 04 81          	movslq (%rcx,%rax,4),%rax
    c2e9:	48 01 c8             	add    %rcx,%rax
    c2ec:	ff e0                	jmp    *%rax
    c2ee:	48 89 df             	mov    %rbx,%rdi
    c2f1:	4c 89 f6             	mov    %r14,%rsi
    c2f4:	ba 01 00 00 00       	mov    $0x1,%edx
    c2f9:	e9 77 01 00 00       	jmp    c475 <fwp_encode+0x1b5>
    c2fe:	48 89 df             	mov    %rbx,%rdi
    c301:	4c 89 f6             	mov    %r14,%rsi
    c304:	ba 04 00 00 00       	mov    $0x4,%edx
    c309:	e9 67 01 00 00       	jmp    c475 <fwp_encode+0x1b5>
    c30e:	49 8b 36             	mov    (%r14),%rsi
    c311:	48 89 df             	mov    %rbx,%rdi
    c314:	e8 57 02 00 00       	call   c570 <fwp_leb128>
    c319:	49 8b 16             	mov    (%r14),%rdx
    c31c:	49 83 c6 08          	add    $0x8,%r14
    c320:	48 89 df             	mov    %rbx,%rdi
    c323:	4c 89 f6             	mov    %r14,%rsi
    c326:	5b                   	pop    %rbx
    c327:	41 5c                	pop    %r12
    c329:	41 5d                	pop    %r13
    c32b:	41 5e                	pop    %r14
    c32d:	41 5f                	pop    %r15
    c32f:	e9 0c b6 ff ff       	jmp    7940 <buf_put>
    c334:	48 89 df             	mov    %rbx,%rdi
    c337:	4c 89 f6             	mov    %r14,%rsi
    c33a:	ba 02 00 00 00       	mov    $0x2,%edx
    c33f:	e9 31 01 00 00       	jmp    c475 <fwp_encode+0x1b5>
    c344:	49 8b 36             	mov    (%r14),%rsi
    c347:	48 89 df             	mov    %rbx,%rdi
    c34a:	e8 21 02 00 00       	call   c570 <fwp_leb128>
    c34f:	49 83 3e 00          	cmpq   $0x0,(%r14)
    c353:	0f 84 90 01 00 00    	je     c4e9 <fwp_encode+0x229>
    c359:	4d 8d 66 10          	lea    0x10(%r14),%r12
    c35d:	45 31 ed             	xor    %r13d,%r13d
    c360:	eb 1e                	jmp    c380 <fwp_encode+0xc0>
    c362:	66 66 66 66 66 2e 0f 	data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    c369:	1f 84 00 00 00 00 00 
    c370:	49 ff c5             	inc    %r13
    c373:	49 83 c4 10          	add    $0x10,%r12
    c377:	4d 3b 2e             	cmp    (%r14),%r13
    c37a:	0f 83 69 01 00 00    	jae    c4e9 <fwp_encode+0x229>
    c380:	49 8b 74 24 f8       	mov    -0x8(%r12),%rsi
    c385:	49 8b 57 38          	mov    0x38(%r15),%rdx
    c389:	48 89 df             	mov    %rbx,%rdi
    c38c:	e8 2f ff ff ff       	call   c2c0 <fwp_encode>
    c391:	41 83 3f 12          	cmpl   $0x12,(%r15)
    c395:	75 d9                	jne    c370 <fwp_encode+0xb0>
    c397:	49 8b 34 24          	mov    (%r12),%rsi
    c39b:	49 8b 57 40          	mov    0x40(%r15),%rdx
    c39f:	48 89 df             	mov    %rbx,%rdi
    c3a2:	e8 19 ff ff ff       	call   c2c0 <fwp_encode>
    c3a7:	eb c7                	jmp    c370 <fwp_encode+0xb0>
    c3a9:	4c 89 f7             	mov    %r14,%rdi
    c3ac:	e8 4f dc ff ff       	call   a000 <fwp_tag>
    c3b1:	41 89 c4             	mov    %eax,%r12d
    c3b4:	48 89 df             	mov    %rbx,%rdi
    c3b7:	4c 89 e6             	mov    %r12,%rsi
    c3ba:	e8 b1 01 00 00       	call   c570 <fwp_leb128>
    c3bf:	49 8b 47 28          	mov    0x28(%r15),%rax
    c3c3:	42 83 3c a0 00       	cmpl   $0x0,(%rax,%r12,4)
    c3c8:	0f 8e 1b 01 00 00    	jle    c4e9 <fwp_encode+0x229>
    c3ce:	45 31 ed             	xor    %r13d,%r13d
    c3d1:	66 66 66 66 66 66 2e 	data16 data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    c3d8:	0f 1f 84 00 00 00 00 
    c3df:	00 
    c3e0:	4b 8b 74 ee 08       	mov    0x8(%r14,%r13,8),%rsi
    c3e5:	49 8b 47 30          	mov    0x30(%r15),%rax
    c3e9:	4a 8b 04 e0          	mov    (%rax,%r12,8),%rax
    c3ed:	4a 8b 14 e8          	mov    (%rax,%r13,8),%rdx
    c3f1:	48 89 df             	mov    %rbx,%rdi
    c3f4:	e8 c7 fe ff ff       	call   c2c0 <fwp_encode>
    c3f9:	49 ff c5             	inc    %r13
    c3fc:	49 8b 47 28          	mov    0x28(%r15),%rax
    c400:	4a 63 04 a0          	movslq (%rax,%r12,4),%rax
    c404:	49 39 c5             	cmp    %rax,%r13
    c407:	7c d7                	jl     c3e0 <fwp_encode+0x120>
    c409:	e9 db 00 00 00       	jmp    c4e9 <fwp_encode+0x229>
    c40e:	4c 89 f7             	mov    %r14,%rdi
    c411:	e8 9a db ff ff       	call   9fb0 <fwp_i128>
    c416:	eb 3f                	jmp    c457 <fwp_encode+0x197>
    c418:	4c 89 f7             	mov    %r14,%rdi
    c41b:	e8 80 d6 ff ff       	call   9aa0 <fwp_list_len>
    c420:	48 89 df             	mov    %rbx,%rdi
    c423:	48 89 c6             	mov    %rax,%rsi
    c426:	e8 45 01 00 00       	call   c570 <fwp_leb128>
    c42b:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)
    c430:	4d 85 f6             	test   %r14,%r14
    c433:	0f 84 b0 00 00 00    	je     c4e9 <fwp_encode+0x229>
    c439:	49 8b 76 08          	mov    0x8(%r14),%rsi
    c43d:	49 8b 57 38          	mov    0x38(%r15),%rdx
    c441:	48 89 df             	mov    %rbx,%rdi
    c444:	e8 77 fe ff ff       	call   c2c0 <fwp_encode>
    c449:	4d 8b 76 10          	mov    0x10(%r14),%r14
    c44d:	eb e1                	jmp    c430 <fwp_encode+0x170>
    c44f:	4c 89 f7             	mov    %r14,%rdi
    c452:	e8 69 db ff ff       	call   9fc0 <fwp_u128>
    c457:	49 89 d6             	mov    %rdx,%r14
    c45a:	48 89 df             	mov    %rbx,%rdi
    c45d:	48 89 c6             	mov    %rax,%rsi
    c460:	ba 08 00 00 00       	mov    $0x8,%edx
    c465:	e8 b6 00 00 00       	call   c520 <fwp_le>
    c46a:	48 89 df             	mov    %rbx,%rdi
    c46d:	4c 89 f6             	mov    %r14,%rsi
    c470:	ba 08 00 00 00       	mov    $0x8,%edx
    c475:	5b                   	pop    %rbx
    c476:	41 5c                	pop    %r12
    c478:	41 5d                	pop    %r13
    c47a:	41 5e                	pop    %r14
    c47c:	41 5f                	pop    %r15
    c47e:	e9 9d 00 00 00       	jmp    c520 <fwp_le>
    c483:	41 83 7f 10 00       	cmpl   $0x0,0x10(%r15)
    c488:	7e 5f                	jle    c4e9 <fwp_encode+0x229>
    c48a:	45 31 e4             	xor    %r12d,%r12d
    c48d:	0f 1f 00             	nopl   (%rax)
    c490:	4b 8b 74 e6 08       	mov    0x8(%r14,%r12,8),%rsi
    c495:	49 8b 47 20          	mov    0x20(%r15),%rax
    c499:	4a 8b 14 e0          	mov    (%rax,%r12,8),%rdx
    c49d:	48 89 df             	mov    %rbx,%rdi
    c4a0:	e8 1b fe ff ff       	call   c2c0 <fwp_encode>
    c4a5:	49 ff c4             	inc    %r12
    c4a8:	49 63 47 10          	movslq 0x10(%r15),%rax
    c4ac:	49 39 c4             	cmp    %rax,%r12
    c4af:	7c df                	jl     c490 <fwp_encode+0x1d0>
    c4b1:	eb 36                	jmp    c4e9 <fwp_encode+0x229>
    c4b3:	49 8b 36             	mov    (%r14),%rsi
    c4b6:	48 89 df             	mov    %rbx,%rdi
    c4b9:	e8 b2 00 00 00       	call   c570 <fwp_leb128>
    c4be:	49 83 3e 00          	cmpq   $0x0,(%r14)
    c4c2:	74 25                	je     c4e9 <fwp_encode+0x229>
    c4c4:	45 31 e4             	xor    %r12d,%r12d
    c4c7:	66 0f 1f 84 00 00 00 	nopw   0x0(%rax,%rax,1)
    c4ce:	00 00 
    c4d0:	4b 8b 74 e6 08       	mov    0x8(%r14,%r12,8),%rsi
    c4d5:	49 8b 57 38          	mov    0x38(%r15),%rdx
    c4d9:	48 89 df             	mov    %rbx,%rdi
    c4dc:	e8 df fd ff ff       	call   c2c0 <fwp_encode>
    c4e1:	49 ff c4             	inc    %r12
    c4e4:	4d 3b 26             	cmp    (%r14),%r12
    c4e7:	72 e7                	jb     c4d0 <fwp_encode+0x210>
    c4e9:	5b                   	pop    %rbx
    c4ea:	41 5c                	pop    %r12
    c4ec:	41 5d                	pop    %r13
    c4ee:	41 5e                	pop    %r14
    c4f0:	41 5f                	pop    %r15
    c4f2:	c3                   	ret
    c4f3:	66 66 66 66 2e 0f 1f 	data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    c4fa:	84 00 00 00 00 00 

000000000000c500 <fwp_pipe_frame_done>:
    c500:	83 3d b5 87 00 00 00 	cmpl   $0x0,0x87b5(%rip)        # 14cbc <fwp_po_listen>
    c507:	78 16                	js     c51f <fwp_pipe_frame_done+0x1f>
    c509:	8b 05 01 89 02 00    	mov    0x28901(%rip),%eax        # 34e10 <fwp_po_frames>
    c50f:	ff c0                	inc    %eax
    c511:	89 05 f9 88 02 00    	mov    %eax,0x288f9(%rip)        # 34e10 <fwp_po_frames>
    c517:	a8 3f                	test   $0x3f,%al
    c519:	0f 84 11 e0 ff ff    	je     a530 <fwp_pipe_poll>
    c51f:	c3                   	ret

000000000000c520 <fwp_le>:
    c520:	85 d2                	test   %edx,%edx
    c522:	7e 44                	jle    c568 <fwp_le+0x48>
    c524:	41 57                	push   %r15
    c526:	41 56                	push   %r14
    c528:	41 54                	push   %r12
    c52a:	53                   	push   %rbx
    c52b:	50                   	push   %rax
    c52c:	48 89 f3             	mov    %rsi,%rbx
    c52f:	49 89 fe             	mov    %rdi,%r14
    c532:	41 89 d4             	mov    %edx,%r12d
    c535:	49 c1 e4 03          	shl    $0x3,%r12
    c539:	45 31 ff             	xor    %r15d,%r15d
    c53c:	0f 1f 40 00          	nopl   0x0(%rax)
    c540:	48 89 d8             	mov    %rbx,%rax
    c543:	44 89 f9             	mov    %r15d,%ecx
    c546:	48 d3 e8             	shr    %cl,%rax
    c549:	0f be f0             	movsbl %al,%esi
    c54c:	4c 89 f7             	mov    %r14,%rdi
    c54f:	e8 9c b3 ff ff       	call   78f0 <buf_putc>
    c554:	49 83 c7 08          	add    $0x8,%r15
    c558:	4d 39 fc             	cmp    %r15,%r12
    c55b:	75 e3                	jne    c540 <fwp_le+0x20>
    c55d:	48 83 c4 08          	add    $0x8,%rsp
    c561:	5b                   	pop    %rbx
    c562:	41 5c                	pop    %r12
    c564:	41 5e                	pop    %r14
    c566:	41 5f                	pop    %r15
    c568:	c3                   	ret
    c569:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)

000000000000c570 <fwp_leb128>:
    c570:	41 57                	push   %r15
    c572:	41 56                	push   %r14
    c574:	53                   	push   %rbx
    c575:	49 89 f6             	mov    %rsi,%r14
    c578:	48 89 fb             	mov    %rdi,%rbx
    c57b:	48 81 fe 80 00 00 00 	cmp    $0x80,%rsi
    c582:	73 05                	jae    c589 <fwp_leb128+0x19>
    c584:	4d 89 f7             	mov    %r14,%r15
    c587:	eb 27                	jmp    c5b0 <fwp_leb128+0x40>
    c589:	4d 89 f7             	mov    %r14,%r15
    c58c:	0f 1f 40 00          	nopl   0x0(%rax)
    c590:	49 c1 ef 07          	shr    $0x7,%r15
    c594:	44 89 f0             	mov    %r14d,%eax
    c597:	0c 80                	or     $0x80,%al
    c599:	0f be f0             	movsbl %al,%esi
    c59c:	48 89 df             	mov    %rbx,%rdi
    c59f:	e8 4c b3 ff ff       	call   78f0 <buf_putc>
    c5a4:	49 81 fe ff 3f 00 00 	cmp    $0x3fff,%r14
    c5ab:	4d 89 fe             	mov    %r15,%r14
    c5ae:	77 e0                	ja     c590 <fwp_leb128+0x20>
    c5b0:	41 0f be f7          	movsbl %r15b,%esi
    c5b4:	48 89 df             	mov    %rbx,%rdi
    c5b7:	5b                   	pop    %rbx
    c5b8:	41 5e                	pop    %r14
    c5ba:	41 5f                	pop    %r15
    c5bc:	e9 2f b3 ff ff       	jmp    78f0 <buf_putc>
    c5c1:	66 66 66 66 66 66 2e 	data16 data16 data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    c5c8:	0f 1f 84 00 00 00 00 
    c5cf:	00 

000000000000c5d0 <fwp_pipe_read>:
    c5d0:	55                   	push   %rbp
    c5d1:	41 57                	push   %r15
    c5d3:	41 56                	push   %r14
    c5d5:	41 55                	push   %r13
    c5d7:	41 54                	push   %r12
    c5d9:	53                   	push   %rbx
    c5da:	50                   	push   %rax
    c5db:	48 89 f3             	mov    %rsi,%rbx
    c5de:	8b 05 30 88 02 00    	mov    0x28830(%rip),%eax        # 34e14 <fwp_pi_kind>
    c5e4:	83 f8 01             	cmp    $0x1,%eax
    c5e7:	0f 84 89 00 00 00    	je     c676 <fwp_pipe_read+0xa6>
    c5ed:	83 f8 02             	cmp    $0x2,%eax
    c5f0:	0f 85 d7 00 00 00    	jne    c6cd <fwp_pipe_read+0xfd>
    c5f6:	48 89 3c 24          	mov    %rdi,(%rsp)
    c5fa:	4c 8b 25 17 88 02 00 	mov    0x28817(%rip),%r12        # 34e18 <fwp_pi_ring>
    c601:	4d 8d ac 24 c0 00 00 	lea    0xc0(%r12),%r13
    c608:	00 
    c609:	49 8d ac 24 c4 00 00 	lea    0xc4(%r12),%rbp
    c610:	00 
    c611:	4c 8d 35 b8 01 00 00 	lea    0x1b8(%rip),%r14        # c7d0 <fwp_ring_has_data>
    c618:	45 31 ff             	xor    %r15d,%r15d
    c61b:	eb 23                	jmp    c640 <fwp_pipe_read+0x70>
    c61d:	0f 1f 00             	nopl   (%rax)
    c620:	44 8b 05 a1 86 00 00 	mov    0x86a1(%rip),%r8d        # 14cc8 <fwp_pi_sock>
    c627:	4c 89 e7             	mov    %r12,%rdi
    c62a:	4c 89 ee             	mov    %r13,%rsi
    c62d:	48 89 ea             	mov    %rbp,%rdx
    c630:	4c 89 f1             	mov    %r14,%rcx
    c633:	e8 98 dc ff ff       	call   a2d0 <fwp_ring_wait>
    c638:	85 c0                	test   %eax,%eax
    c63a:	0f 84 6c 01 00 00    	je     c7ac <fwp_pipe_read+0x1dc>
    c640:	49 8b 4c 24 40       	mov    0x40(%r12),%rcx
    c645:	49 8b 84 24 80 00 00 	mov    0x80(%r12),%rax
    c64c:	00 
    c64d:	48 29 c1             	sub    %rax,%rcx
    c650:	0f 85 9c 00 00 00    	jne    c6f2 <fwp_pipe_read+0x122>
    c656:	41 8b 84 24 40 01 00 	mov    0x140(%r12),%eax
    c65d:	00 
    c65e:	85 c0                	test   %eax,%eax
    c660:	74 be                	je     c620 <fwp_pipe_read+0x50>
    c662:	49 8b 44 24 40       	mov    0x40(%r12),%rax
    c667:	49 3b 84 24 80 00 00 	cmp    0x80(%r12),%rax
    c66e:	00 
    c66f:	75 af                	jne    c620 <fwp_pipe_read+0x50>
    c671:	e9 36 01 00 00       	jmp    c7ac <fwp_pipe_read+0x1dc>
    c676:	4c 8b 35 a3 87 02 00 	mov    0x287a3(%rip),%r14        # 34e20 <fwp_pi_pos>
    c67d:	4c 8b 3d a4 87 02 00 	mov    0x287a4(%rip),%r15        # 34e28 <fwp_pi_len>
    c684:	4d 39 fe             	cmp    %r15,%r14
    c687:	0f 85 f9 00 00 00    	jne    c786 <fwp_pipe_read+0x1b6>
    c68d:	49 89 fc             	mov    %rdi,%r12
    c690:	4c 8d 35 99 87 02 00 	lea    0x28799(%rip),%r14        # 34e30 <fwp_pi_buf>
    c697:	45 31 ff             	xor    %r15d,%r15d
    c69a:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)
    c6a0:	8b 3d 22 86 00 00    	mov    0x8622(%rip),%edi        # 14cc8 <fwp_pi_sock>
    c6a6:	ba 00 00 01 00       	mov    $0x10000,%edx
    c6ab:	4c 89 f6             	mov    %r14,%rsi
    c6ae:	31 c9                	xor    %ecx,%ecx
    c6b0:	e8 ab 59 ff ff       	call   2060 <recv@plt>
    c6b5:	48 85 c0             	test   %rax,%rax
    c6b8:	0f 89 b6 00 00 00    	jns    c774 <fwp_pipe_read+0x1a4>
    c6be:	e8 bd 59 ff ff       	call   2080 <__errno_location@plt>
    c6c3:	83 38 04             	cmpl   $0x4,(%rax)
    c6c6:	74 d8                	je     c6a0 <fwp_pipe_read+0xd0>
    c6c8:	e9 df 00 00 00       	jmp    c7ac <fwp_pipe_read+0x1dc>
    c6cd:	48 8b 05 e4 68 00 00 	mov    0x68e4(%rip),%rax        # 12fb8 <stdin@GLIBC_2.2.5>
    c6d4:	48 8b 08             	mov    (%rax),%rcx
    c6d7:	be 01 00 00 00       	mov    $0x1,%esi
    c6dc:	48 89 da             	mov    %rbx,%rdx
    c6df:	48 83 c4 08          	add    $0x8,%rsp
    c6e3:	5b                   	pop    %rbx
    c6e4:	41 5c                	pop    %r12
    c6e6:	41 5d                	pop    %r13
    c6e8:	41 5e                	pop    %r14
    c6ea:	41 5f                	pop    %r15
    c6ec:	5d                   	pop    %rbp
    c6ed:	e9 fe 59 ff ff       	jmp    20f0 <fread@plt>
    c6f2:	48 39 d9             	cmp    %rbx,%rcx
    c6f5:	48 0f 42 d9          	cmovb  %rcx,%rbx
    c6f9:	4d 8b 74 24 08       	mov    0x8(%r12),%r14
    c6fe:	49 8d 4e ff          	lea    -0x1(%r14),%rcx
    c702:	48 21 c1             	and    %rax,%rcx
    c705:	49 29 ce             	sub    %rcx,%r14
    c708:	4c 39 f3             	cmp    %r14,%rbx
    c70b:	4c 0f 42 f3          	cmovb  %rbx,%r14
    c70f:	4d 8d bc 24 00 10 00 	lea    0x1000(%r12),%r15
    c716:	00 
    c717:	49 8d 34 0c          	lea    (%r12,%rcx,1),%rsi
    c71b:	48 81 c6 00 10 00 00 	add    $0x1000,%rsi
    c722:	4c 8b 2c 24          	mov    (%rsp),%r13
    c726:	4c 89 ef             	mov    %r13,%rdi
    c729:	4c 89 f2             	mov    %r14,%rdx
    c72c:	e8 ff 5b ff ff       	call   2330 <memcpy@plt>
    c731:	4d 01 f5             	add    %r14,%r13
    c734:	48 89 da             	mov    %rbx,%rdx
    c737:	4c 29 f2             	sub    %r14,%rdx
    c73a:	4c 89 ef             	mov    %r13,%rdi
    c73d:	4c 89 fe             	mov    %r15,%rsi
    c740:	e8 eb 5b ff ff       	call   2330 <memcpy@plt>
    c745:	49 8b 84 24 80 00 00 	mov    0x80(%r12),%rax
    c74c:	00 
    c74d:	48 01 d8             	add    %rbx,%rax
    c750:	49 89 84 24 80 00 00 	mov    %rax,0x80(%r12)
    c757:	00 
    c758:	49 8d bc 24 00 01 00 	lea    0x100(%r12),%rdi
    c75f:	00 
    c760:	49 81 c4 04 01 00 00 	add    $0x104,%r12
    c767:	4c 89 e6             	mov    %r12,%rsi
    c76a:	e8 c1 dc ff ff       	call   a430 <fwp_ring_wake>
    c76f:	49 89 df             	mov    %rbx,%r15
    c772:	eb 38                	jmp    c7ac <fwp_pipe_read+0x1dc>
    c774:	74 48                	je     c7be <fwp_pipe_read+0x1ee>
    c776:	4c 89 e7             	mov    %r12,%rdi
    c779:	48 89 05 a8 86 02 00 	mov    %rax,0x286a8(%rip)        # 34e28 <fwp_pi_len>
    c780:	45 31 f6             	xor    %r14d,%r14d
    c783:	49 89 c7             	mov    %rax,%r15
    c786:	4d 29 f7             	sub    %r14,%r15
    c789:	49 39 df             	cmp    %rbx,%r15
    c78c:	4c 0f 43 fb          	cmovae %rbx,%r15
    c790:	48 8d 35 99 86 02 00 	lea    0x28699(%rip),%rsi        # 34e30 <fwp_pi_buf>
    c797:	4c 01 f6             	add    %r14,%rsi
    c79a:	4c 89 fa             	mov    %r15,%rdx
    c79d:	e8 8e 5b ff ff       	call   2330 <memcpy@plt>
    c7a2:	4d 01 fe             	add    %r15,%r14
    c7a5:	4c 89 35 74 86 02 00 	mov    %r14,0x28674(%rip)        # 34e20 <fwp_pi_pos>
    c7ac:	4c 89 f8             	mov    %r15,%rax
    c7af:	48 83 c4 08          	add    $0x8,%rsp
    c7b3:	5b                   	pop    %rbx
    c7b4:	41 5c                	pop    %r12
    c7b6:	41 5d                	pop    %r13
    c7b8:	41 5e                	pop    %r14
    c7ba:	41 5f                	pop    %r15
    c7bc:	5d                   	pop    %rbp
    c7bd:	c3                   	ret
    c7be:	45 31 ff             	xor    %r15d,%r15d
    c7c1:	eb e9                	jmp    c7ac <fwp_pipe_read+0x1dc>
    c7c3:	66 66 66 66 2e 0f 1f 	data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    c7ca:	84 00 00 00 00 00 

000000000000c7d0 <fwp_ring_has_data>:
    c7d0:	48 8b 4f 40          	mov    0x40(%rdi),%rcx
    c7d4:	b8 01 00 00 00       	mov    $0x1,%eax
    c7d9:	48 3b 8f 80 00 00 00 	cmp    0x80(%rdi),%rcx
    c7e0:	75 0d                	jne    c7ef <fwp_ring_has_data+0x1f>
    c7e2:	8b 8f 40 01 00 00    	mov    0x140(%rdi),%ecx
    c7e8:	31 c0                	xor    %eax,%eax
    c7ea:	85 c9                	test   %ecx,%ecx
    c7ec:	0f 95 c0             	setne  %al
    c7ef:	c3                   	ret

000000000000c7f0 <fwp_pipe_report>:
    c7f0:	53                   	push   %rbx
    c7f1:	48 89 fb             	mov    %rdi,%rbx
    c7f4:	48 8d 3d 9a 1b 00 00 	lea    0x1b9a(%rip),%rdi        # e395 <exec_in_fp0+0xd55>
    c7fb:	e8 30 58 ff ff       	call   2030 <getenv@plt>
    c800:	48 85 c0             	test   %rax,%rax
    c803:	74 18                	je     c81d <fwp_pipe_report+0x2d>
    c805:	80 38 00             	cmpb   $0x0,(%rax)
    c808:	74 13                	je     c81d <fwp_pipe_report+0x2d>
    c80a:	48 8d 35 57 1b 00 00 	lea    0x1b57(%rip),%rsi        # e368 <exec_in_fp0+0xd28>
    c811:	48 89 c7             	mov    %rax,%rdi
    c814:	e8 b7 5a ff ff       	call   22d0 <strcmp@plt>
    c819:	85 c0                	test   %eax,%eax
    c81b:	75 02                	jne    c81f <fwp_pipe_report+0x2f>
    c81d:	5b                   	pop    %rbx
    c81e:	c3                   	ret
    c81f:	48 8b 05 b2 67 00 00 	mov    0x67b2(%rip),%rax        # 12fd8 <stderr@GLIBC_2.2.5>
    c826:	48 8b 38             	mov    (%rax),%rdi
    c829:	48 8d 35 7a 1b 00 00 	lea    0x1b7a(%rip),%rsi        # e3aa <exec_in_fp0+0xd6a>
    c830:	48 89 da             	mov    %rbx,%rdx
    c833:	31 c0                	xor    %eax,%eax
    c835:	5b                   	pop    %rbx
    c836:	e9 b5 5a ff ff       	jmp    22f0 <fprintf@plt>
    c83b:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)

000000000000c840 <rd_le>:
    c840:	55                   	push   %rbp
    c841:	41 56                	push   %r14
    c843:	53                   	push   %rbx
    c844:	48 83 ec 10          	sub    $0x10,%rsp
    c848:	48 89 d3             	mov    %rdx,%rbx
    c84b:	89 f5                	mov    %esi,%ebp
    c84d:	41 89 f6             	mov    %esi,%r14d
    c850:	48 8d 54 24 08       	lea    0x8(%rsp),%rdx
    c855:	4c 89 f6             	mov    %r14,%rsi
    c858:	e8 23 01 00 00       	call   c980 <rd_take>
    c85d:	85 c0                	test   %eax,%eax
    c85f:	74 20                	je     c881 <rd_le+0x41>
    c861:	48 c7 03 00 00 00 00 	movq   $0x0,(%rbx)
    c868:	b8 01 00 00 00       	mov    $0x1,%eax
    c86d:	85 ed                	test   %ebp,%ebp
    c86f:	7e 7d                	jle    c8ee <rd_le+0xae>
    c871:	48 8b 74 24 08       	mov    0x8(%rsp),%rsi
    c876:	83 fd 01             	cmp    $0x1,%ebp
    c879:	75 0a                	jne    c885 <rd_le+0x45>
    c87b:	31 d2                	xor    %edx,%edx
    c87d:	31 ff                	xor    %edi,%edi
    c87f:	eb 55                	jmp    c8d6 <rd_le+0x96>
    c881:	31 c0                	xor    %eax,%eax
    c883:	eb 69                	jmp    c8ee <rd_le+0xae>
    c885:	45 89 f0             	mov    %r14d,%r8d
    c888:	41 81 e0 fe ff ff 7f 	and    $0x7ffffffe,%r8d
    c88f:	41 b9 08 00 00 00    	mov    $0x8,%r9d
    c895:	31 d2                	xor    %edx,%edx
    c897:	31 ff                	xor    %edi,%edi
    c899:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)
    c8a0:	44 0f b6 14 16       	movzbl (%rsi,%rdx,1),%r10d
    c8a5:	41 8d 49 f8          	lea    -0x8(%r9),%ecx
    c8a9:	80 e1 f0             	and    $0xf0,%cl
    c8ac:	49 d3 e2             	shl    %cl,%r10
    c8af:	49 09 fa             	or     %rdi,%r10
    c8b2:	4c 89 13             	mov    %r10,(%rbx)
    c8b5:	0f b6 7c 16 01       	movzbl 0x1(%rsi,%rdx,1),%edi
    c8ba:	44 89 c9             	mov    %r9d,%ecx
    c8bd:	80 e1 f8             	and    $0xf8,%cl
    c8c0:	48 d3 e7             	shl    %cl,%rdi
    c8c3:	4c 09 d7             	or     %r10,%rdi
    c8c6:	48 89 3b             	mov    %rdi,(%rbx)
    c8c9:	48 83 c2 02          	add    $0x2,%rdx
    c8cd:	49 83 c1 10          	add    $0x10,%r9
    c8d1:	49 39 d0             	cmp    %rdx,%r8
    c8d4:	75 ca                	jne    c8a0 <rd_le+0x60>
    c8d6:	41 f6 c6 01          	test   $0x1,%r14b
    c8da:	74 12                	je     c8ee <rd_le+0xae>
    c8dc:	0f b6 34 16          	movzbl (%rsi,%rdx,1),%esi
    c8e0:	c1 e2 03             	shl    $0x3,%edx
    c8e3:	89 d1                	mov    %edx,%ecx
    c8e5:	48 d3 e6             	shl    %cl,%rsi
    c8e8:	48 09 fe             	or     %rdi,%rsi
    c8eb:	48 89 33             	mov    %rsi,(%rbx)
    c8ee:	48 83 c4 10          	add    $0x10,%rsp
    c8f2:	5b                   	pop    %rbx
    c8f3:	41 5e                	pop    %r14
    c8f5:	5d                   	pop    %rbp
    c8f6:	c3                   	ret
    c8f7:	66 0f 1f 84 00 00 00 	nopw   0x0(%rax,%rax,1)
    c8fe:	00 00 

000000000000c900 <rd_leb>:
    c900:	41 57                	push   %r15
    c902:	41 56                	push   %r14
    c904:	41 54                	push   %r12
    c906:	53                   	push   %rbx
    c907:	50                   	push   %rax
    c908:	48 89 f3             	mov    %rsi,%rbx
    c90b:	49 89 fe             	mov    %rdi,%r14
    c90e:	48 c7 06 00 00 00 00 	movq   $0x0,(%rsi)
    c915:	49 c7 c7 f9 ff ff ff 	mov    $0xfffffffffffffff9,%r15
    c91c:	49 89 e4             	mov    %rsp,%r12
    c91f:	90                   	nop
    c920:	be 01 00 00 00       	mov    $0x1,%esi
    c925:	4c 89 f7             	mov    %r14,%rdi
    c928:	4c 89 e2             	mov    %r12,%rdx
    c92b:	e8 50 00 00 00       	call   c980 <rd_take>
    c930:	85 c0                	test   %eax,%eax
    c932:	74 2f                	je     c963 <rd_leb+0x63>
    c934:	48 8b 04 24          	mov    (%rsp),%rax
    c938:	0f b6 10             	movzbl (%rax),%edx
    c93b:	49 83 ff 38          	cmp    $0x38,%r15
    c93f:	75 07                	jne    c948 <rd_leb+0x48>
    c941:	89 d1                	mov    %edx,%ecx
    c943:	80 e1 7e             	and    $0x7e,%cl
    c946:	75 1b                	jne    c963 <rd_leb+0x63>
    c948:	49 83 c7 07          	add    $0x7,%r15
    c94c:	83 e2 7f             	and    $0x7f,%edx
    c94f:	44 89 f9             	mov    %r15d,%ecx
    c952:	48 d3 e2             	shl    %cl,%rdx
    c955:	48 09 13             	or     %rdx,(%rbx)
    c958:	80 38 00             	cmpb   $0x0,(%rax)
    c95b:	79 0a                	jns    c967 <rd_leb+0x67>
    c95d:	49 83 ff 38          	cmp    $0x38,%r15
    c961:	76 bd                	jbe    c920 <rd_leb+0x20>
    c963:	31 c0                	xor    %eax,%eax
    c965:	eb 05                	jmp    c96c <rd_leb+0x6c>
    c967:	b8 01 00 00 00       	mov    $0x1,%eax
    c96c:	48 83 c4 08          	add    $0x8,%rsp
    c970:	5b                   	pop    %rbx
    c971:	41 5c                	pop    %r12
    c973:	41 5e                	pop    %r14
    c975:	41 5f                	pop    %r15
    c977:	c3                   	ret
    c978:	0f 1f 84 00 00 00 00 	nopl   0x0(%rax,%rax,1)
    c97f:	00 

000000000000c980 <rd_take>:
    c980:	4c 8b 47 08          	mov    0x8(%rdi),%r8
    c984:	48 8b 4f 10          	mov    0x10(%rdi),%rcx
    c988:	49 29 c8             	sub    %rcx,%r8
    c98b:	31 c0                	xor    %eax,%eax
    c98d:	49 39 f0             	cmp    %rsi,%r8
    c990:	72 15                	jb     c9a7 <rd_take+0x27>
    c992:	48 8b 07             	mov    (%rdi),%rax
    c995:	48 01 c8             	add    %rcx,%rax
    c998:	48 89 02             	mov    %rax,(%rdx)
    c99b:	48 01 ce             	add    %rcx,%rsi
    c99e:	48 89 77 10          	mov    %rsi,0x10(%rdi)
    c9a2:	b8 01 00 00 00       	mov    $0x1,%eax
    c9a7:	c3                   	ret
    c9a8:	0f 1f 84 00 00 00 00 	nopl   0x0(%rax,%rax,1)
    c9af:	00 

000000000000c9b0 <fwp_getc>:
    c9b0:	48 63 05 15 84 01 00 	movslq 0x18415(%rip),%rax        # 24dcc <fwp_in_ppos>
    c9b7:	3b 05 0b 84 01 00    	cmp    0x1840b(%rip),%eax        # 24dc8 <fwp_in_npend>
    c9bd:	7d 15                	jge    c9d4 <fwp_getc+0x24>
    c9bf:	8d 48 01             	lea    0x1(%rax),%ecx
    c9c2:	89 0d 04 84 01 00    	mov    %ecx,0x18404(%rip)        # 24dcc <fwp_in_ppos>
    c9c8:	48 8d 0d f5 83 01 00 	lea    0x183f5(%rip),%rcx        # 24dc4 <fwp_in_pend>
    c9cf:	0f b6 04 08          	movzbl (%rax,%rcx,1),%eax
    c9d3:	c3                   	ret
    c9d4:	48 8b 05 dd 65 00 00 	mov    0x65dd(%rip),%rax        # 12fb8 <stdin@GLIBC_2.2.5>
    c9db:	48 8b 38             	mov    (%rax),%rdi
    c9de:	e9 3d 58 ff ff       	jmp    2220 <fgetc@plt>
    c9e3:	66 66 66 66 2e 0f 1f 	data16 data16 data16 cs nopw 0x0(%rax,%rax,1)
    c9ea:	84 00 00 00 00 00 

000000000000c9f0 <fwp_gc_find_data>:
    c9f0:	0f b7 77 18          	movzwl 0x18(%rdi),%esi
    c9f4:	48 85 f6             	test   %rsi,%rsi
    c9f7:	0f 84 be 00 00 00    	je     cabb <fwp_gc_find_data+0xcb>
    c9fd:	53                   	push   %rbx
    c9fe:	48 8b 07             	mov    (%rdi),%rax
    ca01:	4c 8b 47 10          	mov    0x10(%rdi),%r8
    ca05:	48 6b ce 38          	imul   $0x38,%rsi,%rcx
    ca09:	45 31 c9             	xor    %r9d,%r9d
    ca0c:	48 8d 15 85 68 00 00 	lea    0x6885(%rip),%rdx        # 13298 <fwp_gc>
    ca13:	41 bb 01 00 00 00    	mov    $0x1,%r11d
    ca19:	45 31 d2             	xor    %r10d,%r10d
    ca1c:	eb 0b                	jmp    ca29 <fwp_gc_find_data+0x39>
    ca1e:	66 90                	xchg   %ax,%ax
    ca20:	49 83 c1 38          	add    $0x38,%r9
    ca24:	4c 39 c9             	cmp    %r9,%rcx
    ca27:	74 22                	je     ca4b <fwp_gc_find_data+0x5b>
    ca29:	43 83 3c 08 01       	cmpl   $0x1,(%r8,%r9,1)
    ca2e:	75 f0                	jne    ca20 <fwp_gc_find_data+0x30>
    ca30:	4b 8b 5c 08 10       	mov    0x10(%r8,%r9,1),%rbx
    ca35:	48 01 c3             	add    %rax,%rbx
    ca38:	48 39 d3             	cmp    %rdx,%rbx
    ca3b:	77 e3                	ja     ca20 <fwp_gc_find_data+0x30>
    ca3d:	4b 03 5c 08 28       	add    0x28(%r8,%r9,1),%rbx
    ca42:	48 39 d3             	cmp    %rdx,%rbx
    ca45:	45 0f 47 d3          	cmova  %r11d,%r10d
    ca49:	eb d5                	jmp    ca20 <fwp_gc_find_data+0x30>
    ca4b:	31 c0                	xor    %eax,%eax
    ca4d:	45 85 d2             	test   %r10d,%r10d
    ca50:	0f 95 c0             	setne  %al
    ca53:	74 6e                	je     cac3 <fwp_gc_find_data+0xd3>
    ca55:	66 85 f6             	test   %si,%si
    ca58:	74 69                	je     cac3 <fwp_gc_find_data+0xd3>
    ca5a:	8b 05 c8 79 00 00    	mov    0x79c8(%rip),%eax        # 14428 <fwp_gc+0x1190>
    ca60:	48 8b 77 10          	mov    0x10(%rdi),%rsi
    ca64:	45 31 c0             	xor    %r8d,%r8d
    ca67:	eb 10                	jmp    ca79 <fwp_gc_find_data+0x89>
    ca69:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)
    ca70:	49 83 c0 38          	add    $0x38,%r8
    ca74:	4c 39 c1             	cmp    %r8,%rcx
    ca77:	74 45                	je     cabe <fwp_gc_find_data+0xce>
    ca79:	42 83 3c 06 01       	cmpl   $0x1,(%rsi,%r8,1)
    ca7e:	75 f0                	jne    ca70 <fwp_gc_find_data+0x80>
    ca80:	42 f6 44 06 04 02    	testb  $0x2,0x4(%rsi,%r8,1)
    ca86:	74 e8                	je     ca70 <fwp_gc_find_data+0x80>
    ca88:	83 f8 10             	cmp    $0x10,%eax
    ca8b:	74 31                	je     cabe <fwp_gc_find_data+0xce>
    ca8d:	4e 8b 4c 06 10       	mov    0x10(%rsi,%r8,1),%r9
    ca92:	4c 03 0f             	add    (%rdi),%r9
    ca95:	4c 63 d0             	movslq %eax,%r10
    ca98:	49 c1 e2 04          	shl    $0x4,%r10
    ca9c:	4d 89 8c 12 90 10 00 	mov    %r9,0x1090(%r10,%rdx,1)
    caa3:	00 
    caa4:	4e 8b 4c 06 28       	mov    0x28(%rsi,%r8,1),%r9
    caa9:	4d 89 8c 12 98 10 00 	mov    %r9,0x1098(%r10,%rdx,1)
    cab0:	00 
    cab1:	ff c0                	inc    %eax
    cab3:	89 05 6f 79 00 00    	mov    %eax,0x796f(%rip)        # 14428 <fwp_gc+0x1190>
    cab9:	eb b5                	jmp    ca70 <fwp_gc_find_data+0x80>
    cabb:	31 c0                	xor    %eax,%eax
    cabd:	c3                   	ret
    cabe:	b8 01 00 00 00       	mov    $0x1,%eax
    cac3:	5b                   	pop    %rbx
    cac4:	c3                   	ret
    cac5:	66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
    cacc:	00 00 00 00 

000000000000cad0 <fwp_gc_report>:
    cad0:	41 57                	push   %r15
    cad2:	41 56                	push   %r14
    cad4:	53                   	push   %rbx
    cad5:	48 83 ec 50          	sub    $0x50,%rsp
    cad9:	48 8b 05 c8 79 00 00 	mov    0x79c8(%rip),%rax        # 144a8 <fwp_gc+0x1210>
    cae0:	48 8b 0d b1 67 00 00 	mov    0x67b1(%rip),%rcx        # 13298 <fwp_gc>
    cae7:	48 29 c8             	sub    %rcx,%rax
    caea:	f2 48 0f 2a c8       	cvtsi2sd %rax,%xmm1
    caef:	f2 0f 58 0d 89 79 00 	addsd  0x7989(%rip),%xmm1        # 14480 <fwp_gc+0x11e8>
    caf6:	00 
    caf7:	f2 0f 11 0d 81 79 00 	movsd  %xmm1,0x7981(%rip)        # 14480 <fwp_gc+0x11e8>
    cafe:	00 
    caff:	48 89 0d a2 79 00 00 	mov    %rcx,0x79a2(%rip)        # 144a8 <fwp_gc+0x1210>
    cb06:	48 8b 05 cb 64 00 00 	mov    0x64cb(%rip),%rax        # 12fd8 <stderr@GLIBC_2.2.5>
    cb0d:	4c 8b 38             	mov    (%rax),%r15
    cb10:	48 8b 1d 59 79 00 00 	mov    0x7959(%rip),%rbx        # 14470 <fwp_gc+0x11d8>
    cb17:	4c 8b 35 92 77 00 00 	mov    0x7792(%rip),%r14        # 142b0 <fwp_gc+0x1018>
    cb1e:	f2 0f 10 15 7a 79 00 	movsd  0x797a(%rip),%xmm2        # 144a0 <fwp_gc+0x1208>
    cb25:	00 
    cb26:	f2 0f 58 ca          	addsd  %xmm2,%xmm1
    cb2a:	f2 0f 10 05 0e 05 00 	movsd  0x50e(%rip),%xmm0        # d040 <_IO_stdin_used+0x40>
    cb31:	00 
    cb32:	f2 0f 59 c8          	mulsd  %xmm0,%xmm1
    cb36:	f2 0f 11 4c 24 18    	movsd  %xmm1,0x18(%rsp)
    cb3c:	f2 0f 59 d0          	mulsd  %xmm0,%xmm2
    cb40:	f2 0f 11 54 24 10    	movsd  %xmm2,0x10(%rsp)
    cb46:	f2 0f 10 0d 92 77 00 	movsd  0x7792(%rip),%xmm1        # 142e0 <fwp_gc+0x1048>
    cb4d:	00 
    cb4e:	66 0f 28 15 0a 06 00 	movapd 0x60a(%rip),%xmm2        # d160 <_IO_stdin_used+0x160>
    cb55:	00 
    cb56:	0f 14 ca             	unpcklps %xmm2,%xmm1
    cb59:	66 0f 28 1d 0f 06 00 	movapd 0x60f(%rip),%xmm3        # d170 <_IO_stdin_used+0x170>
    cb60:	00 
    cb61:	66 0f 5c cb          	subpd  %xmm3,%xmm1
    cb65:	66 0f 28 e1          	movapd %xmm1,%xmm4
    cb69:	66 0f 15 e1          	unpckhpd %xmm1,%xmm4
    cb6d:	f2 0f 58 e1          	addsd  %xmm1,%xmm4
    cb71:	f2 0f 59 e0          	mulsd  %xmm0,%xmm4
    cb75:	66 0f 29 64 24 40    	movapd %xmm4,0x40(%rsp)
    cb7b:	f2 0f 10 0d dd 78 00 	movsd  0x78dd(%rip),%xmm1        # 14460 <fwp_gc+0x11c8>
    cb82:	00 
    cb83:	0f 14 ca             	unpcklps %xmm2,%xmm1
    cb86:	66 0f 5c cb          	subpd  %xmm3,%xmm1
    cb8a:	66 0f 28 e1          	movapd %xmm1,%xmm4
    cb8e:	66 0f 15 e1          	unpckhpd %xmm1,%xmm4
    cb92:	f2 0f 58 e1          	addsd  %xmm1,%xmm4
    cb96:	f2 0f 59 e0          	mulsd  %xmm0,%xmm4
    cb9a:	66 0f 29 64 24 30    	movapd %xmm4,0x30(%rsp)
    cba0:	f2 0f 10 0d c0 78 00 	movsd  0x78c0(%rip),%xmm1        # 14468 <fwp_gc+0x11d0>
    cba7:	00 
    cba8:	0f 14 ca             	unpcklps %xmm2,%xmm1
    cbab:	66 0f 5c cb          	subpd  %xmm3,%xmm1
    cbaf:	66 0f 28 d1          	movapd %xmm1,%xmm2
    cbb3:	66 0f 15 d1          	unpckhpd %xmm1,%xmm2
    cbb7:	f2 0f 58 d1          	addsd  %xmm1,%xmm2
    cbbb:	f2 0f 59 d0          	mulsd  %xmm0,%xmm2
    cbbf:	66 0f 29 54 24 20    	movapd %xmm2,0x20(%rsp)
    cbc5:	f2 0f 10 05 bb 78 00 	movsd  0x78bb(%rip),%xmm0        # 14488 <fwp_gc+0x11f0>
    cbcc:	00 
    cbcd:	f2 0f 11 44 24 08    	movsd  %xmm0,0x8(%rsp)
    cbd3:	f2 0f 10 05 b5 78 00 	movsd  0x78b5(%rip),%xmm0        # 14490 <fwp_gc+0x11f8>
    cbda:	00 
    cbdb:	f2 0f 11 04 24       	movsd  %xmm0,(%rsp)
    cbe0:	e8 6b 00 00 00       	call   cc50 <fwp_gc_status_kb>
    cbe5:	83 3d a0 76 00 00 00 	cmpl   $0x0,0x76a0(%rip)        # 1428c <fwp_gc+0xff4>
    cbec:	48 8d 0d 52 19 00 00 	lea    0x1952(%rip),%rcx        # e545 <exec_in_fp0+0xf05>
    cbf3:	4c 8d 0d 8c 14 00 00 	lea    0x148c(%rip),%r9        # e086 <exec_in_fp0+0xa46>
    cbfa:	4c 0f 44 c9          	cmove  %rcx,%r9
    cbfe:	48 8d 35 8b 18 00 00 	lea    0x188b(%rip),%rsi        # e490 <exec_in_fp0+0xe50>
    cc05:	4c 89 ff             	mov    %r15,%rdi
    cc08:	48 89 da             	mov    %rbx,%rdx
    cc0b:	4c 89 f1             	mov    %r14,%rcx
    cc0e:	f2 0f 10 44 24 18    	movsd  0x18(%rsp),%xmm0
    cc14:	f2 0f 10 4c 24 10    	movsd  0x10(%rsp),%xmm1
    cc1a:	0f 28 54 24 40       	movaps 0x40(%rsp),%xmm2
    cc1f:	0f 28 5c 24 30       	movaps 0x30(%rsp),%xmm3
    cc24:	0f 28 64 24 20       	movaps 0x20(%rsp),%xmm4
    cc29:	f2 0f 10 6c 24 08    	movsd  0x8(%rsp),%xmm5
    cc2f:	f2 0f 10 34 24       	movsd  (%rsp),%xmm6
    cc34:	49 89 c0             	mov    %rax,%r8
    cc37:	b0 07                	mov    $0x7,%al
    cc39:	48 83 c4 50          	add    $0x50,%rsp
    cc3d:	5b                   	pop    %rbx
    cc3e:	41 5e                	pop    %r14
    cc40:	41 5f                	pop    %r15
    cc42:	e9 a9 56 ff ff       	jmp    22f0 <fprintf@plt>
    cc47:	66 0f 1f 84 00 00 00 	nopw   0x0(%rax,%rax,1)
    cc4e:	00 00 

000000000000cc50 <fwp_gc_status_kb>:
    cc50:	55                   	push   %rbp
    cc51:	41 57                	push   %r15
    cc53:	41 56                	push   %r14
    cc55:	41 54                	push   %r12
    cc57:	53                   	push   %rbx
    cc58:	48 81 ec 00 01 00 00 	sub    $0x100,%rsp
    cc5f:	48 8d 3d f1 18 00 00 	lea    0x18f1(%rip),%rdi        # e557 <exec_in_fp0+0xf17>
    cc66:	48 8d 35 0a 17 00 00 	lea    0x170a(%rip),%rsi        # e377 <exec_in_fp0+0xd37>
    cc6d:	e8 ae 57 ff ff       	call   2420 <fopen@plt>
    cc72:	48 85 c0             	test   %rax,%rax
    cc75:	74 7d                	je     ccf4 <fwp_gc_status_kb+0xa4>
    cc77:	48 89 c3             	mov    %rax,%rbx
    cc7a:	48 89 e7             	mov    %rsp,%rdi
    cc7d:	be 00 01 00 00       	mov    $0x100,%esi
    cc82:	48 89 c2             	mov    %rax,%rdx
    cc85:	e8 06 56 ff ff       	call   2290 <fgets@plt>
    cc8a:	49 c7 c6 ff ff ff ff 	mov    $0xffffffffffffffff,%r14
    cc91:	48 85 c0             	test   %rax,%rax
    cc94:	74 54                	je     ccea <fwp_gc_status_kb+0x9a>
    cc96:	4c 8d 7c 24 06       	lea    0x6(%rsp),%r15
    cc9b:	bd 56 6d 48 57       	mov    $0x57486d56,%ebp
    cca0:	49 89 e4             	mov    %rsp,%r12
    cca3:	eb 20                	jmp    ccc5 <fwp_gc_status_kb+0x75>
    cca5:	66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
    ccac:	00 00 00 00 
    ccb0:	4c 89 e7             	mov    %r12,%rdi
    ccb3:	be 00 01 00 00       	mov    $0x100,%esi
    ccb8:	48 89 da             	mov    %rbx,%rdx
    ccbb:	e8 d0 55 ff ff       	call   2290 <fgets@plt>
    ccc0:	48 85 c0             	test   %rax,%rax
    ccc3:	74 25                	je     ccea <fwp_gc_status_kb+0x9a>
    ccc5:	8b 04 24             	mov    (%rsp),%eax
    ccc8:	31 e8                	xor    %ebp,%eax
    ccca:	0f b6 4c 24 04       	movzbl 0x4(%rsp),%ecx
    cccf:	83 f1 4d             	xor    $0x4d,%ecx
    ccd2:	09 c1                	or     %eax,%ecx
    ccd4:	75 da                	jne    ccb0 <fwp_gc_status_kb+0x60>
    ccd6:	80 7c 24 05 3a       	cmpb   $0x3a,0x5(%rsp)
    ccdb:	75 d3                	jne    ccb0 <fwp_gc_status_kb+0x60>
    ccdd:	4c 89 ff             	mov    %r15,%rdi
    cce0:	e8 1b 57 ff ff       	call   2400 <atol@plt>
    cce5:	49 89 c6             	mov    %rax,%r14
    cce8:	eb c6                	jmp    ccb0 <fwp_gc_status_kb+0x60>
    ccea:	48 89 df             	mov    %rbx,%rdi
    cced:	e8 5e 54 ff ff       	call   2150 <fclose@plt>
    ccf2:	eb 07                	jmp    ccfb <fwp_gc_status_kb+0xab>
    ccf4:	49 c7 c6 ff ff ff ff 	mov    $0xffffffffffffffff,%r14
    ccfb:	4c 89 f0             	mov    %r14,%rax
    ccfe:	48 81 c4 00 01 00 00 	add    $0x100,%rsp
    cd05:	5b                   	pop    %rbx
    cd06:	41 5c                	pop    %r12
    cd08:	41 5e                	pop    %r14
    cd0a:	41 5f                	pop    %r15
    cd0c:	5d                   	pop    %rbp
    cd0d:	c3                   	ret
    cd0e:	66 90                	xchg   %ax,%ax

000000000000cd10 <w4>:
    cd10:	50                   	push   %rax
    cd11:	e8 2a 5c ff ff       	call   2940 <fwp_from_f64>
    cd16:	48 bf 00 00 00 00 00 	movabs $0x3fc0000000000000,%rdi
    cd1d:	00 c0 3f 
    cd20:	48 89 c6             	mov    %rax,%rsi
    cd23:	e8 98 8d ff ff       	call   5ac0 <f6>
    cd28:	48 89 c7             	mov    %rax,%rdi
    cd2b:	58                   	pop    %rax
    cd2c:	e9 6f 61 ff ff       	jmp    2ea0 <fwp_f64>
    cd31:	66 2e 0f 1f 84 00 00 	cs nopw 0x0(%rax,%rax,1)
    cd38:	00 00 00 
    cd3b:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)

000000000000cd40 <__divti3>:
    cd40:	f3 0f 1e fa          	endbr64
    cd44:	55                   	push   %rbp
    cd45:	49 89 f8             	mov    %rdi,%r8
    cd48:	49 89 d2             	mov    %rdx,%r10
    cd4b:	49 89 cb             	mov    %rcx,%r11
    cd4e:	31 ff                	xor    %edi,%edi
    cd50:	48 89 e5             	mov    %rsp,%rbp
    cd53:	41 56                	push   %r14
    cd55:	53                   	push   %rbx
    cd56:	48 85 f6             	test   %rsi,%rsi
    cd59:	79 13                	jns    cd6e <__divti3+0x2e>
    cd5b:	45 31 c9             	xor    %r9d,%r9d
    cd5e:	49 f7 d8             	neg    %r8
    cd61:	48 c7 c7 ff ff ff ff 	mov    $0xffffffffffffffff,%rdi
    cd68:	49 19 f1             	sbb    %rsi,%r9
    cd6b:	4c 89 ce             	mov    %r9,%rsi
    cd6e:	4c 89 da             	mov    %r11,%rdx
    cd71:	4d 85 db             	test   %r11,%r11
    cd74:	0f 88 f6 00 00 00    	js     ce70 <__divti3+0x130>
    cd7a:	4d 89 d6             	mov    %r10,%r14
    cd7d:	75 31                	jne    cdb0 <__divti3+0x70>
    cd7f:	4c 39 f6             	cmp    %r14,%rsi
    cd82:	0f 83 b8 00 00 00    	jae    ce40 <__divti3+0x100>
    cd88:	48 89 f2             	mov    %rsi,%rdx
    cd8b:	31 f6                	xor    %esi,%esi
    cd8d:	4c 89 c0             	mov    %r8,%rax
    cd90:	49 f7 f6             	div    %r14
    cd93:	48 89 f2             	mov    %rsi,%rdx
    cd96:	48 85 ff             	test   %rdi,%rdi
    cd99:	74 0a                	je     cda5 <__divti3+0x65>
    cd9b:	48 f7 d8             	neg    %rax
    cd9e:	48 83 d2 00          	adc    $0x0,%rdx
    cda2:	48 f7 da             	neg    %rdx
    cda5:	5b                   	pop    %rbx
    cda6:	41 5e                	pop    %r14
    cda8:	5d                   	pop    %rbp
    cda9:	c3                   	ret
    cdaa:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)
    cdb0:	4c 39 de             	cmp    %r11,%rsi
    cdb3:	0f 82 d5 00 00 00    	jb     ce8e <__divti3+0x14e>
    cdb9:	4d 0f bd d3          	bsr    %r11,%r10
    cdbd:	41 83 f2 3f          	xor    $0x3f,%r10d
    cdc1:	44 89 d1             	mov    %r10d,%ecx
    cdc4:	b8 40 00 00 00       	mov    $0x40,%eax
    cdc9:	4c 89 f3             	mov    %r14,%rbx
    cdcc:	4d 89 f1             	mov    %r14,%r9
    cdcf:	48 d3 e2             	shl    %cl,%rdx
    cdd2:	49 63 ca             	movslq %r10d,%rcx
    cdd5:	49 89 f3             	mov    %rsi,%r11
    cdd8:	48 29 c8             	sub    %rcx,%rax
    cddb:	89 c1                	mov    %eax,%ecx
    cddd:	48 d3 eb             	shr    %cl,%rbx
    cde0:	44 89 d1             	mov    %r10d,%ecx
    cde3:	49 d3 e1             	shl    %cl,%r9
    cde6:	89 c1                	mov    %eax,%ecx
    cde8:	48 09 d3             	or     %rdx,%rbx
    cdeb:	4c 89 c2             	mov    %r8,%rdx
    cdee:	49 d3 eb             	shr    %cl,%r11
    cdf1:	44 89 d1             	mov    %r10d,%ecx
    cdf4:	48 d3 e6             	shl    %cl,%rsi
    cdf7:	89 c1                	mov    %eax,%ecx
    cdf9:	48 d3 ea             	shr    %cl,%rdx
    cdfc:	48 89 d0             	mov    %rdx,%rax
    cdff:	4c 89 da             	mov    %r11,%rdx
    ce02:	48 09 f0             	or     %rsi,%rax
    ce05:	48 f7 f3             	div    %rbx
    ce08:	49 89 d3             	mov    %rdx,%r11
    ce0b:	48 89 c6             	mov    %rax,%rsi
    ce0e:	49 f7 e1             	mul    %r9
    ce11:	49 39 d3             	cmp    %rdx,%r11
    ce14:	0f 82 be 00 00 00    	jb     ced8 <__divti3+0x198>
    ce1a:	44 89 d1             	mov    %r10d,%ecx
    ce1d:	49 d3 e0             	shl    %cl,%r8
    ce20:	49 39 c0             	cmp    %rax,%r8
    ce23:	73 09                	jae    ce2e <__divti3+0xee>
    ce25:	49 39 d3             	cmp    %rdx,%r11
    ce28:	0f 84 aa 00 00 00    	je     ced8 <__divti3+0x198>
    ce2e:	48 89 f0             	mov    %rsi,%rax
    ce31:	31 f6                	xor    %esi,%esi
    ce33:	e9 5b ff ff ff       	jmp    cd93 <__divti3+0x53>
    ce38:	0f 1f 84 00 00 00 00 	nopl   0x0(%rax,%rax,1)
    ce3f:	00 
    ce40:	4d 85 f6             	test   %r14,%r14
    ce43:	75 0d                	jne    ce52 <__divti3+0x112>
    ce45:	b8 01 00 00 00       	mov    $0x1,%eax
    ce4a:	31 d2                	xor    %edx,%edx
    ce4c:	49 f7 f6             	div    %r14
    ce4f:	49 89 c6             	mov    %rax,%r14
    ce52:	48 89 f0             	mov    %rsi,%rax
    ce55:	31 d2                	xor    %edx,%edx
    ce57:	49 f7 f6             	div    %r14
    ce5a:	48 89 c6             	mov    %rax,%rsi
    ce5d:	4c 89 c0             	mov    %r8,%rax
    ce60:	49 f7 f6             	div    %r14
    ce63:	e9 2b ff ff ff       	jmp    cd93 <__divti3+0x53>
    ce68:	0f 1f 84 00 00 00 00 	nopl   0x0(%rax,%rax,1)
    ce6f:	00 
    ce70:	49 f7 da             	neg    %r10
    ce73:	48 f7 d7             	not    %rdi
    ce76:	49 83 d3 00          	adc    $0x0,%r11
    ce7a:	4d 89 d6             	mov    %r10,%r14
    ce7d:	49 f7 db             	neg    %r11
    ce80:	4c 89 da             	mov    %r11,%rdx
    ce83:	0f 84 f6 fe ff ff    	je     cd7f <__divti3+0x3f>
    ce89:	4c 39 de             	cmp    %r11,%rsi
    ce8c:	73 12                	jae    cea0 <__divti3+0x160>
    ce8e:	31 f6                	xor    %esi,%esi
    ce90:	31 c0                	xor    %eax,%eax
    ce92:	e9 fc fe ff ff       	jmp    cd93 <__divti3+0x53>
    ce97:	66 0f 1f 84 00 00 00 	nopw   0x0(%rax,%rax,1)
    ce9e:	00 00 
    cea0:	49 0f bd c3          	bsr    %r11,%rax
    cea4:	48 83 f0 3f          	xor    $0x3f,%rax
    cea8:	41 89 c2             	mov    %eax,%r10d
    ceab:	85 c0                	test   %eax,%eax
    cead:	0f 85 0e ff ff ff    	jne    cdc1 <__divti3+0x81>
    ceb3:	49 39 f3             	cmp    %rsi,%r11
    ceb6:	72 0d                	jb     cec5 <__divti3+0x185>
    ceb8:	31 f6                	xor    %esi,%esi
    ceba:	31 c0                	xor    %eax,%eax
    cebc:	4d 39 f0             	cmp    %r14,%r8
    cebf:	0f 82 ce fe ff ff    	jb     cd93 <__divti3+0x53>
    cec5:	31 f6                	xor    %esi,%esi
    cec7:	b8 01 00 00 00       	mov    $0x1,%eax
    cecc:	e9 c2 fe ff ff       	jmp    cd93 <__divti3+0x53>
    ced1:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)
    ced8:	48 8d 46 ff          	lea    -0x1(%rsi),%rax
    cedc:	31 f6                	xor    %esi,%esi
    cede:	e9 b0 fe ff ff       	jmp    cd93 <__divti3+0x53>
    cee3:	66 2e 0f 1f 84 00 00 	cs nopw 0x0(%rax,%rax,1)
    ceea:	00 00 00 
    ceed:	0f 1f 00             	nopl   (%rax)

000000000000cef0 <atexit>:
    cef0:	f3 0f 1e fa          	endbr64
    cef4:	48 8b 15 8d 63 00 00 	mov    0x638d(%rip),%rdx        # 13288 <__dso_handle>
    cefb:	31 f6                	xor    %esi,%esi
    cefd:	e9 4e 55 ff ff       	jmp    2450 <__cxa_atexit@plt>

Disassembly of section .fini:

000000000000cf04 <_fini>:
    cf04:	f3 0f 1e fa          	endbr64
    cf08:	48 83 ec 08          	sub    $0x8,%rsp
    cf0c:	48 83 c4 08          	add    $0x8,%rsp
    cf10:	c3                   	ret
